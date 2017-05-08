#2015/12/24 目標改為for 上傳(給上傳完畢後的版次/標示)、過單(給過單完畢後的版次/標示)、Patch呼叫使用(給patch後的版次, 且標準客製皆要處理)
#           azzi090有設定format的N*屬性的欄位by作業都要找過一回
#           測試3個畫面, 每次一個畫面約花3~5秒, 一次傳入花費6~7秒
#           form參數傳遞範例[{"form":"azzi910","ver":"3","flag":"s"},{"form":"azzi800","ver":"7","flag":"c"},{"form":"azzi030","ver":"8","flag":"s"}]
#           form畫面代碼,ver規格版次,flag使用標示, ver, flag不傳遞沒關係, 就會用最大版次, c為優先處理
#           預防針: 記得曾經有部分作業是想要用自己的format, 這部分會被洗掉. 所有畫面都會處理, 沒有例外
#           Create by Saki
#           20160328 160328-00024 by madey :調整參數及增加display

IMPORT os
IMPORT util

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
GLOBALS
   DEFINE g_gen42s_flag     LIKE type_t.chr1        #是否自動產生所有的關聯的42s檔  #160328-00024
END GLOBALS

DEFINE g_sql STRING
DEFINE g_arg1 STRING   #JSON:程式清單
DEFINE g_list DYNAMIC ARRAY OF RECORD
         form LIKE dzfi_t.dzfi001,
         ver  LIKE dzfi_t.dzfi002,
         flag LIKE dzfi_t.dzfi009,
         gen  LIKE type_t.chr1     #是否重產 160328-00024
              END RECORD
DEFINE g_type DYNAMIC ARRAY OF RECORD
         code LIKE gztd_t.gztd001,
         format LIKE gztd_t.gztd007,
         leng LIKE type_t.num5
              END RECORD
DEFINE g_condition STRING

MAIN
   DEFINE lc_dzeb001 LIKE dzeb_t.dzeb001
   DEFINE lc_dzeb002 LIKE dzeb_t.dzeb002
   DEFINE lc_dzeb006 LIKE dzeb_t.dzeb006
   DEFINE lr_dzfk RECORD LIKE dzfk_t.*
   DEFINE lr_dzfj RECORD LIKE dzfj_t.*
   DEFINE li_i SMALLINT
   DEFINE om_doc om.DomDocument
   DEFINE om_node om.DomNode
   DEFINE ch_log base.Channel
   DEFINE ls_str STRING
   DEFINE ld_start DATETIME HOUR TO FRACTION(5)
   DEFINE ld_end DATETIME HOUR TO FRACTION(5)
   DEFINE li_cnt SMALLINT
   DEFINE lc_dzfi007 LIKE dzfi_t.dzfi007
   DEFINE ls_bug STRING
   DEFINE li_leng_chg SMALLINT
   DEFINE li_shift SMALLINT
   DEFINE li_result BOOLEAN
   DEFINE ls_logfile STRING
   DEFINE ls_msg STRING
   DEFINE ls_buildtype STRING
   DEFINE lr_dzaf RECORD
             dzaf001   VARCHAR(30), --建構代號
             dzaf002   INTEGER,     --建構版號
             dzaf003   INTEGER,     --規格版號
             dzaf004   INTEGER,     --代碼版號
             dzaf005   VARCHAR(20), --建構類型
             dzaf006   VARCHAR(20), --模組    
             dzaf007   VARCHAR(20), --產品代號
             dzaf008   VARCHAR(20), --產品版本
             dzaf009   VARCHAR(50), --客戶代碼
             dzaf010   VARCHAR(5)   --識別標示
                  END RECORD
   DEFINE ls_cmd STRING

   WHENEVER ERROR CONTINUE

   #依模組進行系統初始化設定(系統設定)
#  CALL cl_tool_init()
   CALL cl_db_connect("ds", FALSE) #160328-00024

   #將預備處理的4fd檔案放入g_list
  #LET g_arg1 = ARG_VAL(1)
   LET g_arg1 = ARG_VAL(2) #160328-00024
   IF g_arg1 IS NULL THEN
      DISPLAY "Please input parameter - form list"
      RETURN
   END IF
   CALL util.JSON.parse(g_arg1, g_list)


   #將須處理的欄位屬性放到g_type, 目前只針對N*且有format顯示設定的屬性, stus先不論, 假設時開時不開, 4fd設計資料曾經內存已定
   #放入Array(個位數毫秒)比放入TEMPTABLE(十位數毫秒)速度快約20倍,
   #接下來一筆搜尋存在Array的速度大致與TEMPTABLE差不多在十位數毫秒, 用Array處理多次為穩定速度, TABLE則會時快時慢
   LET g_sql = "SELECT gztd001,gztd007,'' FROM gztd_t",
               " WHERE gztd001 LIKE 'N%' AND gztd007 IS NOT NULL"
   PREPARE adzp167_get_gztd_pre FROM g_sql
   DECLARE adzp167_get_gztd_curs CURSOR FOR adzp167_get_gztd_pre
   LET li_i = 1
   FOREACH adzp167_get_gztd_curs INTO g_type[li_i].code, g_type[li_i].format, g_type[li_i].leng
      IF g_type[li_i].code IS NULL THEN
         CONTINUE FOREACH
      END IF
      #用DB處理長度, 時快時慢
      LET ls_str = g_type[li_i].format
      LET g_type[li_i].leng = ls_str.getLength()
      LET li_i = li_i + 1
   END FOREACH
   CALL g_type.deleteElement(li_i)

   #組合要處理的畫面檔在dzfk搜尋的條件
   INITIALIZE g_condition TO NULL
   FOR li_i = 1 TO g_list.getLength()
       IF cl_null(g_list[li_i].form) THEN
          CONTINUE FOR
       END IF
       DISPLAY "開始檢查/替代畫面檔:",g_list[li_i].FORM #160328-00024
       IF cl_null(g_list[li_i].ver) AND cl_null(g_list[li_i].flag) THEN
          #未指定版次及使用標示，自動抓目前該程式最新狀態"
          LET ls_buildtype = sadzp060_2_chk_spec_type(g_list[li_i].form)
          IF ls_buildtype = "N" THEN
             CONTINUE FOR
          ELSE
             CALL sadzp060_2_get_curr_ver_info(g_list[li_i].form, ls_buildtype, NULL) RETURNING lr_dzaf.*,ls_msg
             IF NOT cl_null(ls_msg) THEN
                CONTINUE FOR
             ELSE
                LET g_list[li_i].ver = lr_dzaf.dzaf003
                LET g_list[li_i].flag = lr_dzaf.dzaf010
                LET g_condition = g_condition, "(dzfk001 = '", DOWNSHIFT(g_list[li_i].form), "' AND dzfk002 = ", g_list[li_i].ver," AND dzfk007 = '", g_list[li_i].flag, "') OR "
             END IF
          END IF
       ELSE
          LET g_condition = g_condition, "(dzfk001 = '", DOWNSHIFT(g_list[li_i].form), "' AND dzfk002 = ", g_list[li_i].ver," AND dzfk007 = '", g_list[li_i].flag, "') OR "
       END IF
   END FOR
   LET g_condition = "(", g_condition.subString(1,g_condition.getLength()-4),")"

   #預定義的一堆資料處理
   LET g_sql = "UPDATE dzfk_t SET dzfk009 = ?",
               " WHERE dzfk001 = ? AND dzfk002 = ? AND dzfk003 = ? AND dzfk007 = ?"
   PREPARE upd_dzfk_pre FROM g_sql
   LET g_sql = "UPDATE dzfj_t SET dzfj015 = ?",
               " WHERE dzfj001 = ? AND dzfj002 = ? AND dzfj003 = ? AND dzfj004 = ? AND dzfj017 = ?"
   PREPARE upd_dzfj_pre FROM g_sql
   LET g_sql = "UPDATE dzfj_t SET dzfj013 = dzfj013 + ?",
               " WHERE dzfj001 = ? AND dzfj002 = ? AND dzfj003 = ? AND dzfj004 > ? AND dzfj017 = ?"
   PREPARE upd_aftercomp_pre FROM g_sql

   LET g_sql = "SELECT * FROM dzfj_t",
               " WHERE dzfj001 = ? AND dzfj002 = ? AND dzfj005 = ? AND dzfj017 = ?"
   PREPARE get_comp_detail_pre FROM g_sql
   LET g_sql = "SELECT COUNT(*) FROM dzfj_t",
               " WHERE dzfj001 = ? AND dzfj002 = ? AND dzfj003 = ? AND dzfj004 > ? AND dzfj017 = ?"
   PREPARE get_comp_after_pre FROM g_sql
   LET g_sql = "SELECT dzfi007 FROM dzfi_t",
               " WHERE dzfi006 = ",
               " (SELECT dzfi004 FROM dzfi_t",
               "   WHERE dzfi001 = ? AND dzfi002 = ? AND dzfi006 = ? AND dzfi009 = ?)",
               "     AND dzfi001 = ? AND dzfi002 = ? AND dzfi009 = ?"
   PREPARE get_comp_parent_pre FROM g_sql

   LET ld_start = CURRENT HOUR TO FRACTION(5)
   #log紀錄
   LET ch_log = base.Channel.create()
   LET ls_logfile = "adzp167-", FGL_GETENV("ZONE"), "-", TODAY USING "YYYYMMDD",".txt"
   CALL ch_log.openFile(ls_logfile, "a")
   CALL ch_log.setDelimiter("")
   LET ls_str = "===============================", ld_start, "============================================================================================="
   CALL ch_log.write(ls_str)
   DISPLAY ls_str #160328-00024
   LET ls_str = "執行結果|欄位屬性|畫面代碼|版次|客製|欄位代碼|變更前FORMAT|變更後FORMAT|變更前欄位寬度|變更後欄位寬度|須調整位置的欄位數|x軸調整"
   CALL ch_log.write(ls_str)
   DISPLAY ls_str #160328-00024

   #以指定的dzfk資料再去反查dzeb是否要設定format, 在一支畫面情況下需要1秒多, 若dzeb找dzfk的方式需要10幾秒
   LET g_sql = "SELECT dzeb006 FROM dzeb_t",
               " WHERE dzeb001 = ? AND dzeb002 = ? AND dzeb006 LIKE 'N%'"
   PREPARE adzp167_checktype_pre FROM g_sql
   LET g_sql = "SELECT dzeb006 FROM dzeb_t",
               " WHERE dzeb002 = ? AND dzeb006 LIKE 'N%'",
               " ORDER BY dzeb001"
   PREPARE adzp167_checktype2_pre FROM g_sql
   DECLARE adzp167_checktype2_curs CURSOR FOR adzp167_checktype2_pre
   #若只有找有設定format的元件資料量比較小, 但不確定沒設的是漏掉還是不要format, 先以全部下去搜尋, 扣掉一些已知不要進入的元件
   LOCATE lr_dzfk.dzfk009 IN FILE
   LET g_sql = "SELECT * FROM dzfk_t",
               " WHERE dzfk003 NOT LIKE '%_desc%' AND dzfk003 NOT LIKE 'lbl_%'",   #reference,title
               "   AND dzfk003 NOT LIKE 's_%' AND dzfk003 NOT LIKE 'vb_%'",        #Table, VBox
               "   AND dzfk003 NOT LIKE 'grid_%' AND dzfk003 NOT LIKE 'Grid_%'",   #Grid
               "   AND dzfk003 NOT LIKE 'bpage_%' AND dzfk003 NOT LIKE 'group_%'", #DetailPage, Group
               "   AND ",g_condition,
               " ORDER BY dzfk001,dzfk002,dzfk007"

   PREPARE adzp167_get_dzfk_pre FROM g_sql
   DECLARE adzp167_get_dzfk_curs CURSOR WITH HOLD FOR adzp167_get_dzfk_pre
   FOREACH adzp167_get_dzfk_curs INTO lr_dzfk.*
      #解析dzfk003元件代碼, 先解.前後, .後面先處理b_, 再去除_後的字串
      INITIALIZE ls_str, lc_dzeb001, lc_dzeb002, lc_dzeb006 TO NULL
      LET ls_str = lr_dzfk.dzfk003
      IF ls_str.getIndexOf(".",1) THEN
         LET lc_dzeb001 = ls_str.subString(1, ls_str.getIndexOf(".",1)-1)
         LET ls_str = ls_str.subString(ls_str.getIndexOf(".",1)+1, ls_str.getLength())
      END IF
      IF ls_str.subString(1,2) = "b_" THEN
         LET ls_str = ls_str.subString(3, ls_str.getLength())
      END IF
      IF ls_str.getIndexOf("_",1) THEN
         LET ls_str = ls_str.subString(1, ls_str.getIndexOf("_",1)-1)
      END IF
      LET lc_dzeb002 = ls_str
      IF lc_dzeb001 IS NULL THEN
         FOREACH adzp167_checktype2_curs USING lc_dzeb002 INTO lc_dzeb006
            EXIT FOREACH
         END FOREACH
      ELSE
         EXECUTE adzp167_checktype_pre USING lc_dzeb001, lc_dzeb002 INTO lc_dzeb006
      END IF
      IF lc_dzeb006 IS NULL THEN
         CONTINUE FOREACH
      END IF
      FOR li_i = 1 TO g_type.getLength()
          IF g_type[li_i].code = lc_dzeb006 THEN
             #正文開始
             INITIALIZE ls_bug,lc_dzfi007,ls_str TO NULL
             LET li_result = TRUE
             LET om_doc = om.DomDocument.createFromString(lr_dzfk.dzfk009)
             LET om_node = om_Doc.getDocumentElement()
             IF om_node.getAttribute("format") = g_type[li_i].format THEN
                CONTINUE FOREACH
             END IF
             IF om_node.getTagName() = "ButtonEdit" OR om_node.getTagName() = "DateEdit" OR
                om_node.getTagName() = "Edit" OR om_node.getTagName() = "FFLabel" OR
                om_node.getTagName() = "SpinEdit" OR om_node.getTagName() = "TimeEdit" THEN
                LET ls_str = "|",g_type[li_i].code,"|", lr_dzfk.dzfk001,"|", lr_dzfk.dzfk002,"|", lr_dzfk.dzfk007,"|", lr_dzfk.dzfk003,"|", om_node.getAttribute("format"),"|", g_type[li_i].format,"|", om_node.getAttribute("gridWidth")
             ELSE
                CONTINUE FOREACH
             END IF
   
             BEGIN WORK
             CALL om_node.setAttribute("format", g_type[li_i].format)
             EXECUTE get_comp_detail_pre USING lr_dzfk.dzfk001, lr_dzfk.dzfk002, lr_dzfk.dzfk003, lr_dzfk.dzfk007 INTO lr_dzfj.*
             #元件應有寬度計算
             LET li_leng_chg = g_type[li_i].leng
             IF om_node.getTagName() = "ButtonEdit" OR om_node.getTagName() = "DateEdit" OR
                om_node.getTagName() = "SpinEdit" OR om_node.getTagName() = "TimeEdit" THEN
                LET li_leng_chg = li_leng_chg + 2
             END IF
             IF om_node.getAttribute("gridWidth") > li_leng_chg THEN
                LET li_leng_chg = om_node.getAttribute("gridWidth")
             END IF
             LET ls_str = ls_str, "|", li_leng_chg
             IF om_node.getAttribute("gridWidth") < li_leng_chg OR
                lr_dzfj.dzfj015 < li_leng_chg THEN
                #開始檢查後面有沒有欄位可能覆蓋
                EXECUTE get_comp_after_pre USING lr_dzfj.dzfj001, lr_dzfj.dzfj002, lr_dzfj.dzfj003, lr_dzfj.dzfj004, lr_dzfj.dzfj017 INTO li_cnt
                IF li_cnt > 0 THEN
                   EXECUTE get_comp_parent_pre USING lr_dzfj.dzfj001, lr_dzfj.dzfj002, lr_dzfj.dzfj003, lr_dzfj.dzfj017,
                                                     lr_dzfj.dzfj001, lr_dzfj.dzfj002, lr_dzfj.dzfj017
                                                INTO lc_dzfi007
                   LET li_shift = li_leng_chg - om_node.getAttribute("gridWidth")
                   LET ls_str = ls_str,"|", li_cnt, "|", li_shift
#####update start
                   #有覆蓋必須往後拉長
                   EXECUTE upd_aftercomp_pre USING li_shift, lr_dzfj.dzfj001, lr_dzfj.dzfj002, lr_dzfj.dzfj003, lr_dzfj.dzfj004, lr_dzfj.dzfj017
                   IF lc_dzfi007 = "ScrollGrid" THEN
                      CALL get_scrollgrid_label(lr_dzfj.*, li_shift) RETURNING li_result
                   END IF
#####update end
                END IF
                CALL om_node.setAttribute("gridWidth", li_leng_chg)
                LET lr_dzfj.dzfj015 = li_leng_chg
             END IF
#####update start
             IF li_result THEN
                LET lr_dzfk.dzfk009 = om_node.toString()
                EXECUTE upd_dzfk_pre USING lr_dzfk.dzfk009, lr_dzfk.dzfk001, lr_dzfk.dzfk002, lr_dzfk.dzfk003, lr_dzfk.dzfk007
                IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                  #LET ls_str = "Fail|", ls_str
                   LET ls_str = "ERROR|", ls_str #160328-00024
                   ROLLBACK WORK
                ELSE
                   EXECUTE upd_dzfj_pre USING lr_dzfj.dzfj015, lr_dzfj.dzfj001, lr_dzfj.dzfj002, lr_dzfj.dzfj003, lr_dzfj.dzfj004, lr_dzfj.dzfj017
                   IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                     #LET ls_str = "Fail|", ls_str
                      LET ls_str = "ERROR|", ls_str #160328-00024
                      ROLLBACK WORK
                   ELSE
                      LET ls_str = "Success|", ls_str
                      COMMIT WORK
                   END IF
                END IF
             ELSE
               #LET ls_str = "Fail|", ls_str
                LET ls_str = "ERROR|", ls_str #160328-00024
                ROLLBACK WORK
             END IF
#####update end
             COMMIT WORK
             CALL ch_log.write(ls_str)
             DISPLAY ls_str #160328-00024
             EXIT FOR
          END IF
      END FOR
   END FOREACH
   INITIALIZE ls_str TO NULL
   CALL ch_log.write(ls_str)
   CALL ch_log.write(ls_str)
   LET ld_end = CURRENT HOUR TO FRACTION(5)
   LET ls_str = "畫面檔format檢查/替代花費時間:", ld_end - ld_start
   CALL ch_log.write(ls_str)
   DISPLAY ls_str

   #最後要記得重產畫面檔
   DISPLAY "開始重產畫面檔"
   FOR li_i = 1 TO g_list.getLength()
      #Begin: 160328-00024
       IF g_list[li_i].gen = "N" THEN
          CONTINUE FOR
       END IF
      #End: 160328-00024
    #  LET ls_cmd = "r.r adzp171 ", g_list[li_i].form," ", g_list[li_i].ver," ", g_list[li_i].flag
    #  DISPLAY ls_cmd #160328-00024
    #  RUN ls_cmd

       LET ls_cmd = "call sadzp168_5(",g_list[li_i].form,",",g_list[li_i].ver,",",g_list[li_i].flag,",TRUE)"
       DISPLAY ls_cmd
       LET g_bgjob= "Y"
       LET g_gen42s_flag = FALSE
       CALL sadzp168_5(g_list[li_i].form, g_list[li_i].ver, g_list[li_i].flag, TRUE) RETURNING li_result,ls_msg
   END FOR
   CALL ch_log.close()

END MAIN

#ScrollGrid內被更新位置的欄位, 要連同上面的Label也一併更新位置
FUNCTION get_scrollgrid_label(pr_dzfj, pi_leng)
   DEFINE pr_dzfj RECORD LIKE dzfj_t.*   #原本被拉寬的欄位資訊
   DEFINE pi_leng SMALLINT
   DEFINE lr_dzfj_after RECORD LIKE dzfj_t.*   #跟隨在拉寬欄位後面的欄位資訊
   DEFINE ls_str STRING
   DEFINE li_posX SMALLINT
   DEFINE lr_label RECORD LIKE dzfj_t.*   #對應後面欄位上方的LABEL欄位
   DEFINE li_result BOOLEAN

   LET li_result = TRUE
   LET g_sql = "UPDATE dzfj_t SET dzfj013 = ?",
               " WHERE dzfj001 = ? AND dzfj002 = ? AND dzfj003 = ? AND dzfj004 = ? AND dzfj017 = ?"
   PREPARE upd_label_pre FROM g_sql
   #先找出大於目前位置的LABEL
   LET g_sql = "SELECT * FROM dzfj_t",
               " WHERE dzfj001 = ? AND dzfj002 = ? AND dzfj003 = ? AND dzfj004 > ? AND dzfj017 = ?",
               " ORDER BY dzfj004"
   PREPARE get_comp_aftercomp_pre FROM g_sql
   DECLARE get_comp_aftercomp_curs CURSOR WITH HOLD FOR get_comp_aftercomp_pre
   FOREACH get_comp_aftercomp_curs USING pr_dzfj.dzfj001, pr_dzfj.dzfj002, pr_dzfj.dzfj003, pr_dzfj.dzfj004, pr_dzfj.dzfj017 INTO lr_dzfj_after.*
      LET ls_str = lr_dzfj_after.dzfj005
      LET ls_str = ls_str.subString(ls_str.getIndexOf(".",1)+1, ls_str.getLength())
      LET lr_label.dzfj005 = "lbl_", ls_str
      SELECT * INTO lr_label.* FROM dzfj_t 
       WHERE dzfj001 = pr_dzfj.dzfj001 AND dzfj002 = pr_dzfj.dzfj002
         AND dzfj003 = pr_dzfj.dzfj003 AND dzfj017 = pr_dzfj.dzfj017
         AND dzfj005 = lr_label.dzfj005
      IF SQLCA.sqlcode = 100 THEN
         LET lr_label.dzfj005 = ""
      END IF
      IF lr_label.dzfj005 IS NOT NULL THEN
         LET li_posX = pi_leng + lr_label.dzfj013
         EXECUTE upd_label_pre USING li_posX, lr_label.dzfj001, lr_label.dzfj002, lr_label.dzfj003, lr_label.dzfj004, lr_label.dzfj017
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
            LET li_result = FALSE
            EXIT FOREACH
         END IF
      END IF
   END FOREACH
   RETURN li_result
END FUNCTION
