#+ Version..: T100-ERP-1.00.00 Build-00001
#+
#+ Filename.: sadzp188_tab
#+ Buildtype: p01樣板自動產生
#+ Memo.....: 產生tab用
#+ ...........: 140804 調整非單頭、身都要加上table別名
#+ ...........: 140923 elena調整版次
#+ ...........: 141030 cynthia 修改l_numfmt1型態
#+ ...........: 141103 janet mark掉p_cust,存dzgl多用table別名
#+ ...........: 141127 janet 調整抓gztd003、gztd008
#+ ...........: 150123 janet 組sql非單頭、單身的欄位都加上table名或別名
#+ ...........: 150202 janet 確認真否已有在dagl019設Y了，若有只需設一個，dzgl019會存至gzgg017
#+ ...........: 150512 janet No.150512-00011#1 簽出時需要備份azzi300或azzi301至備份檔，取消簽出時，從備份檔將資料還原
#+ ...........: 150512 janet 150629-00034 縮排預設值為N
#+ ...........: 150902 janet #150901-00021#1 cl_xg_get_column_info改呼叫cl_rpt_get_column_info
#+ ...........: 151209 janet #151208-00023#1 調整從gztz_t抓取table名時，要排除備份檔(rebuil)。
#+ ...........: 151209 janet #160510-00017#1 調整抓取table時，排除rebuil
#+ ...........: 160615 janet #160615-00007#1 調整SQL為subquery組法, 補上關連表的key，gzgg017為y的判斷,複製查詢報表元件連同azzi300/azzi301一同複製
#+ ...........: 161031 janet #161031-00071#1 調整判斷客製的sql
#+ ...........: 161223 janet #161223-00004#1 enterprise字拼錯改正
#+ ...........: 161228 janet #161227-00056#1 調整撈取gztz_t時，要判斷掉'erp'、'all'、'b2b'、'pos'、'dsm'，避免多拉資料
#+ ...........: 170117 janet #170113-00040#1 將原來ooff002改成抓ooff003，且項次前後多增加ooff004=0的條件
#+ ...........: 170210 janet #170123-00046#1 整批調整報表工具訊息為多語言
#+ ...........: 170214 janet #160921-00012#1 讀取azzi901程式產生類型欄位及新增程式樣板x02
#+ ...........: 170301 janet #170227-00021#4 增加多語言客製碼

IMPORT os
IMPORT security
SCHEMA ds



GLOBALS "../../cfg/top_global.inc"

GLOBALS
   DEFINE g_prog_id         LIKE dzfi_t.dzfi001
   DEFINE g_sd_ver          LIKE dzaa_t.dzaa002  #規格版次/程式版次
#  DEFINE g_adp_ver         LIKE dzaa_t.dzaa002  #產生tab的版次
   DEFINE g_prog_type       STRING
   DEFINE g_table_main      STRING
   DEFINE g_sql             STRING 
   DEFINE g_code_ide        LIKE type_t.chr1     #140619 add 客製標示
            
END GLOBALS

DEFINE g_domDoc      om.DomDocument
DEFINE g_domRoot     om.DomNode
DEFINE g_gzzacrtid   LIKE gzza_t.gzzacrtid  #創建人
DEFINE g_gzzacrtdt   LIKE gzza_t.gzzacrtdt  #創建日期
DEFINE g_subseq      LIKE type_t.num5
DEFINE g_exe_success LIKE type_t.chr1 


#欄位存放陣列
DEFINE g_reference_col_set  STRING     #reference欄位存放字串

DEFINE g_4fdNode RECORD
         masterNode  om.DomNode,
         detailNode  om.DomNode,
         browserNode om.DomNode,
         doctailNode om.DomNode
             END RECORD

DEFINE g_table_main_pk  STRING
DEFINE g_table DYNAMIC ARRAY OF RECORD
         table_type  LIKE type_t.num5,   #1:單頭表 2:單身表
         table_id    STRING,
         table_pk    STRING,
         table_fk    STRING
#        table_ent   LIKE type_t.num5
           END RECORD
DEFINE g_dzgg007     LIKE dzgg_t.dzgg007  #備註子報表:Y要加      
  

DEFINE g_dzff   RECORD
         id     STRING,
         pid    STRING,
         type   STRING,
         desc   STRING,
         speed  STRING,
         slid   STRING,
         spid   STRING,
         stype  STRING,
         type2  STRING,
         type3  STRING,
         type4  STRING,
         type5  STRING,
         type6  STRING
            END RECORD

#########報表部分###########
# g01:  GR報表
# x01:  XG報表

PUBLIC FUNCTION sadzp188_tab_gen(p_prog_id,p_prog_ver,p_code_ide)  #140613  p_code_ide
#PUBLIC FUNCTION sadzp188_tab_gen(p_prog_id,p_prog_ver) #140613 mark
#PUBLIC FUNCTION sadzp188_tab_gen(p_prog_id,p_prog_ver,p_prog_type)
   DEFINE p_prog_id      STRING    #程式代碼
   DEFINE p_prog_ver     LIKE dzaa_t.dzaa002   #產生版本
   DEFINE p_code_ide     LIKE type_t.chr1     #140613 add 客製標示
   DEFINE ls_prog_type   STRING    #樣板型態
   DEFINE ls_sys         STRING
   DEFINE ls_4fd_file    STRING    #4FD畫面檔
   DEFINE ls_tab_file    STRING
   DEFINE li_cnt         LIKE type_t.num5
   DEFINE li_scuss       LIKE type_t.num5       #操作上是否成功(全過程)
   DEFINE lc_gzde005     LIKE dzge_t.dzge005
   DEFINE l_dzgj_cnt     LIKE type_t.num5      ##參數檔  
   DEFINE l_dzga_cnt     LIKE type_t.num5      #140620 add 單頭數

   LET g_prog_id = p_prog_id       #程式代碼
   LET g_sd_ver = p_prog_ver       #規格版本
#  LET g_adp_ver = p_prog_ver      #產生版本
   IF g_sd_ver IS NULL THEN
      #DISPLAY "ERROR: 未接到產生版次! "       #170123-00046#1 mark
      DISPLAY cl_getmsg("adz-01158",g_lang)  #170123-00046#1 add
      #LET g_sd_ver = 1  #140620 mark
      RETURN FALSE       #140620 add  不能不接到版次 
   END IF
   LET g_code_ide = p_code_ide
   
   LET g_subseq = 1
   ##140303
   ##是否要加備註子報表
   LET g_dzgg007 =''
   SELECT dzgg007 INTO g_dzgg007 FROM dzgg_t 
    WHERE dzgg001 = g_prog_id AND dzgg002 = g_sd_ver AND dzgg003 = g_prog_id 
      AND dzgg017 = g_code_ide #AND dzgg016 = p_cust   #140617 add

   #如果進來的規格名稱是子畫面的,特別處理,Return TRUE回去
   IF cl_chk_spec_type(g_prog_id) = "F" THEN
      RETURN TRUE
   END IF

   #執行前清空dynamic array,預防有工具多次連續呼叫
   #CALL g_col_set.clear()
   CALL g_table.clear()
   #CALL sadzp188_tab_ma_init()   #報表先不用

   #開始判斷關係
   CALL sadzp188_tab_relation_prog_type(g_prog_id) RETURNING g_prog_type,g_gzzacrtid,g_gzzacrtdt    #160921-00012#1 add

   SELECT gzzx006 INTO li_cnt FROM gzzx_t WHERE gzzx001 = g_prog_id
   IF SQLCA.SQLCODE THEN 
      LET li_cnt = 0
   END IF
   IF li_cnt IS NULL THEN LET li_cnt = 1 END IF
   DISPLAY "INFO: 程式",g_prog_id CLIPPED,"第",li_cnt +1 USING "<<<<<<","次產出藍圖檔(tab)"

   LET li_scuss = TRUE

   ###140418 先判斷參數檔是否有資料 ，若無則不往下跑-(S)
   LET l_dzgj_cnt = 0
   SELECT COUNT(*) INTO l_dzgj_cnt FROM dzgj_t 
   WHERE dzgj001 = g_prog_id AND dzgj002 = g_sd_ver  
     AND dzgj008 = g_code_ide #AND dzgj007 = p_cust   #140615 add
   ORDER BY dzgj003 
   DISPLAY "dzgj cnt :",l_dzgj_cnt
   IF l_dzgj_cnt = 0 THEN
      #140620 add 判斷主檔，若無則新產生，若有則是錯誤-(s)
      LET l_dzga_cnt = 0
      SELECT COUNT(*) INTO l_dzga_cnt FROM dzga_t 
      WHERE dzga001 = g_prog_id AND dzga002 = g_sd_ver  
        AND dzga006 = g_code_ide 
        DISPLAY "dzga cnt :", l_dzga_cnt
      IF l_dzga_cnt > 0 THEN 
      #140620 add 判斷主檔，若無則新產生，若有則是錯誤-(e)
          #DISPLAY "ERROR: 參數檔(dzgj_t)沒有資料...."    #170123-00046#1 mark
           DISPLAY cl_getmsg("adz-01159",g_lang)       #170123-00046#1 add
          LET li_scuss = FALSE
          RETURN li_scuss
      ELSE 
          #DISPLAY "版次:",g_sd_ver,"   標示:",g_code_ide                         #170123-00046#1  mark 
          #DISPLAY "ERROR: 報表元件",g_prog_id,"沒有設計資料....，請至adzp188維護。"   #170123-00046#1  mark 
          DISPLAY cl_getmsg_parm("adz-01160",g_lang,g_sd_ver),g_code_ide         #170123-00046#1 add
          DISPLAY cl_getmsg_parm("adz-01161",g_lang,g_prog_id)                   #170123-00046#1 add    
          LET li_scuss = FALSE
          RETURN li_scuss      
      END IF 
   END IF 
   ###140418 先判斷參數檔是否有資料 ，若無則不往下跑-(S)   
   
   #ls_sys模組代碼
   #LET ls_sys = UPSHIFT(g_prog_id[1,3])                         #140620 mark
   LET ls_sys = sadzp030_tab_file_module(g_prog_id,"A",g_code_ide)   ##140620 add
   #ls_sys模組代碼修正
   CASE
      WHEN ls_sys = "CL_"               LET ls_sys = "LIB"
      WHEN ls_sys.subString(1,2) = "S_" LET ls_sys = "SUB"
      OTHERWISE
   END CASE
   #path路徑
   #LET ls_sys = FGL_GETENV(ls_sys)  #140620 mark
   DISPLAY  "ls_sys:",ls_sys

   #產生TAB的來源檔案
   #tab  $MODULE/dzx/tab/xxxxx.tab
   LET ls_tab_file = g_prog_id,".tab"
   LET ls_tab_file = os.Path.join(os.Path.join(os.Path.join(ls_sys,"dzx"),"tab"),ls_tab_file)
   #DISPLAY "INFO: 產出tab路徑:",ls_tab_file                 #170123-00046#1 mark
   DISPLAY cl_getmsg_parm("adz-01104",g_lang,ls_tab_file)  #170123-00046#1 add

   #產出 tab
   IF li_scuss THEN
      CALL sadzp188_tab_gen_assembly(ls_tab_file) RETURNING li_scuss
   END IF

   IF os.Path.exists(ls_tab_file) THEN
      #DISPLAY "INFO: tab 檔產出成功, sadzp188_tab任務結束."      #170123-00046#1 mark
      DISPLAY cl_getmsg_parm("adz-01162",g_lang,ls_tab_file)   #170123-00046#1 add      
      CALL sadzp188_tab_log(g_prog_id)
   ELSE
      #DISPLAY "Error: tab 檔產出失敗,檔案",ls_tab_file,"不存在!"  #170123-00046#1 mark  
      DISPLAY cl_getmsg_parm("adz-01109",g_lang,ls_tab_file)    #170123-00046#1 add  
      LET li_scuss = FALSE
   END IF 

   RETURN li_scuss
END FUNCTION


#更新程式開發紀錄檔
PRIVATE FUNCTION sadzp188_tab_log(p_prog_type)
   DEFINE lc_gzzx003     LIKE gzzx_t.gzzx003  #UI樣板
   DEFINE lc_gzzx004     LIKE gzzx_t.gzzx004  #程式樣板
   DEFINE lc_gzzx005     DATETIME YEAR TO SECOND   #異動時間
   DEFINE li_gzzx006     LIKE gzzx_t.gzzx006  #異動次數
   DEFINE p_prog_type    STRING
   DEFINE li_cnt         LIKE type_t.num5

   LET lc_gzzx003 = p_prog_type.trim() #UI樣板
   LET lc_gzzx004 = g_prog_type.trim() #pattern樣板
   LET lc_gzzx005 = cl_get_current()            #異動時間

   SELECT COUNT(*) INTO li_cnt FROM gzzx_t 
    WHERE gzzx001 = g_prog_id
   IF li_cnt = 0 THEN
      LET li_gzzx006 = 1
      INSERT INTO gzzx_t(gzzx001,gzzx002,gzzx003,gzzx004,gzzx005,gzzx006)
       VALUES(g_prog_id, g_sd_ver,lc_gzzx003,lc_gzzx004,lc_gzzx005,li_gzzx006)
      IF SQLCA.SQLCODE THEN
         DISPLAY "Warning: 無法更新記錄檔(INS)"
      END IF
   ELSE
      SELECT gzzx006 INTO li_gzzx006 FROM gzzx_t
       WHERE gzzx001 = g_prog_id
      IF li_gzzx006 IS NULL THEN LET li_gzzx006 = 1 END IF
      LET li_gzzx006 = li_gzzx006 + 1
      UPDATE gzzx_t
         SET gzzx002 = g_sd_ver,   gzzx003 = lc_gzzx003,
             gzzx004 = lc_gzzx004, gzzx005 = lc_gzzx005,
             gzzx006 = li_gzzx006
       WHERE gzzx001 = g_prog_id
      IF SQLCA.SQLCODE THEN
         DISPLAY "Warning: 無法更新記錄檔(UPD)"
      END IF
   END IF

END FUNCTION

#產生tab主結構
PRIVATE FUNCTION sadzp188_tab_gen_assembly(ls_tab_file)
   DEFINE ls_tab_file    STRING
   DEFINE l_define       om.DomNode
   DEFINE l_selprep      om.DomNode
   DEFINE l_mainrep      om.DomNode
   DEFINE l_subrep       om.DomNode
   DEFINE li_detail_cnt  LIKE type_t.num5
   DEFINE li_scuss       LIKE type_t.num5      #操作上是否成功(全過程)
   DEFINE lc_dzfq014     LIKE dzfq_t.dzfq014   #空框架處理
   DEFINE lc_gzdel003    LIKE gzdel_t.gzdel003 #程式繁體中文名稱
   DEFINE ls_sys         STRING


   LET li_scuss = TRUE
   
   #範例:<assembly name="程式名稱aooi002" module="模組aoo"      jobmode="背景程式N"
   #               type="應用樣板i05"     industry="行業別std"  page="單身頁數1"
   #               crtid="首版開發人id"   crtdt="首版開發日期"
   #               modid="首版開發人id"   moddt="首版開發日期"
   #               sdver="產出程式版次"   tabver="TAB語言版本10001"
   #               description="程式的繁體中文名稱" />
   LET g_domDoc = om.DomDocument.create("assembly")
   LET g_domRoot = g_domDoc.getDocumentElement()
   
   #name:程式名稱
   CALL g_domRoot.setAttribute("name",g_prog_id)

   #module:模組
   #ls_sys模組代碼修正
   #LET ls_sys = g_prog_id[1,3]                                    #140620 mark
   LET ls_sys = DOWNSHIFT(sadzp030_tab_file_module(g_prog_id,"B",g_code_ide))
   CASE   ##140620 add
   
      WHEN ls_sys = "cl_"               LET ls_sys = "lib"
      WHEN ls_sys.subString(1,2) = "s_" LET ls_sys = "sub"
      OTHERWISE
   END CASE
   CALL g_domRoot.setAttribute("module",ls_sys)

   #jobmode:執行模式；N-視窗執行 B-背景執行 B-皆可(由參數指定)
   CALL g_domRoot.setAttribute("jobmode","N")

   #type: 樣板
   CALL g_domRoot.setAttribute("type",g_prog_type) 

   #industry:行業別
   CALL g_domRoot.setAttribute("industry","std")

   #adpver:Add-point版本
  #CALL g_domRoot.setAttribute("tpver","X.0") 

   #crt:創建作業的user-id/日期
   CALL g_domRoot.setAttribute("crtid",g_gzzacrtid) 
   CALL g_domRoot.setAttribute("crtdt",g_gzzacrtdt) 

   #mod:修改作業的user-id/日期
   CALL sadzp188_tab_modify_info() RETURNING g_gzzacrtid,g_gzzacrtdt
   CALL g_domRoot.setAttribute("modid",g_gzzacrtid) 
   CALL g_domRoot.setAttribute("moddt",g_gzzacrtdt) 

   CALL g_domRoot.setAttribute("sdver",g_sd_ver) 

   #tabversion:版本
   CALL g_domRoot.setAttribute("tabver","10001")

   #description:程式的繁體中文名稱
   SELECT gzdel003 INTO lc_gzdel003 FROM gzdel_t 
    #WHERE gzdel001 = g_prog_id AND gzdel002 = "zh_TW"    #160921-00012#1 mark
    WHERE gzdel001 = g_prog_id AND gzdel002 = g_lang      #160921-00012#1 add
   IF SQLCA.SQLCODE THEN
      LET lc_gzdel003 = "..."
   END IF
   CALL g_domRoot.setAttribute("description",lc_gzdel003 CLIPPED)

   #以下定義各大 SECTION 區塊
   
   #定義 <DEFINE>
   LET l_define = g_domRoot.createChild("define")
   CALL sadzp188_tab_gen_define(l_define)

   #定義 <SELECT>
   LET l_selprep = g_domRoot.createChild("selprep")
   CALL sadzp188_tab_gen_selprep(l_selprep)   

   ##140301 -(S)
   DISPLAY "gen tab g_prog_type:",g_prog_type
   IF g_prog_type = "g01"  THEN   #GR
      ##定義 <MAINREP>
      LET l_mainrep = g_domRoot.createChild("mainrep")
      CALL sadzp188_tab_gen_mainrep(l_mainrep)
      #定義 <SUBREP>
      LET l_subrep = g_domRoot.createChild("subrep")
      CALL sadzp188_tab_gen_subrep(l_subrep)     
   END IF

   ##140301 -(S)
   
   #檔案寫入
   CALL sadzp188_writefile(g_domRoot.toString(),ls_tab_file)

   RETURN li_scuss

END FUNCTION


#存檔 改用base.Channel的方式存檔
PRIVATE FUNCTION sadzp188_writefile(p_xmlStr,p_file)
   DEFINE p_file         STRING
   DEFINE p_xmlStr       STRING
   DEFINE l_ch_out       base.Channel
   DEFINE l_file_existed BOOLEAN
   DEFINE l_file_deleted BOOLEAN

   LET l_file_existed = FALSE
   LET l_file_deleted = FALSE

   IF os.Path.exists(p_file) THEN
      IF NOT os.Path.delete(p_file) THEN
         DISPLAY "WARNING:刪除檔案",p_file,"時發生問題"
      END IF
   END IF
   
   LET l_ch_out = base.Channel.create()
   CALL l_ch_out.setDelimiter("")
   CALL l_ch_out.openFile(p_file,"w")
   CALL l_ch_out.write(p_xmlStr)
   CALL l_ch_out.close()

   #對產生器寫出的檔案權限在UNIX下均全部打開
   IF os.Path.separator() = "/" THEN 
      IF os.Path.chrwx(p_file,511) THEN
      END IF
   END IF
   
END FUNCTION

#+ 找出最後修改人的資料(user-id與日期)
PRIVATE FUNCTION sadzp188_tab_modify_info()

   DEFINE lc_crtid      LIKE dzaa_t.dzaacrtid
   DEFINE lc_crtdt      LIKE dzaa_t.dzaacrtdt
   DEFINE lc_modid      LIKE dzaa_t.dzaamodid
   DEFINE lc_moddt      LIKE dzaa_t.dzaamoddt
   DEFINE lc_bakid      LIKE dzaa_t.dzaamodid
   DEFINE lc_bakdt      LIKE dzaa_t.dzaamoddt
   DEFINE lc_dzga002    LIKE dzga_t.dzga002    #設計點版次
   DEFINE ls_sql        STRING

   ##140324報表不用這個_(s)   
   #先把dzaa_t內的最高版次找出來 (但dzaa004不可以大於dzaa002)
   #SELECT MAX(DISTINCT(dzaa004)) INTO lc_dzaa004 FROM dzaa_t
    #WHERE dzaa001 = g_prog_id 
      #AND dzaa002 = g_sd_ver
      #AND dzaa002 >= dzaa004
   #IF SQLCA.SQLCODE OR lc_dzaa004 IS NULL THEN
      #LET lc_dzaa004 = "1"   #找不到就只好當作 1
   #END IF
#
   #先把dzaa_t內的最高版次找出來 (但dzba004不可以大於dzba002)
   #SELECT MAX(DISTINCT(dzba004)) INTO lc_dzba004 FROM dzba_t
    #WHERE dzba001 = g_prog_id 
      #AND dzba002 = g_sd_ver
      #AND dzba002 >= dzba004
   #IF SQLCA.SQLCODE OR lc_dzba004 IS NULL THEN
      #LET lc_dzba004 = "0"   #找不到就只好當作 1
   #END IF
#
   #IF lc_dzaa004 >= lc_dzba004 THEN
      #LET ls_sql = "SELECT dzaacrtid,dzaacrtdt,dzaamodid,dzaamoddt FROM dzaa_t ",
                   #" WHERE dzaa001 = '",g_prog_id CLIPPED,"' ",
                     #" AND dzaa002 = '",g_sd_ver CLIPPED,"' ",
                     #" AND dzaa004 = '",lc_dzaa004 CLIPPED,"' "
   #ELSE
      #LET ls_sql = "SELECT dzbacrtid,dzbacrtdt,dzbamodid,dzbamoddt FROM dzba_t ",
                   #" WHERE dzba001 = '",g_prog_id CLIPPED,"' ",
                     #" AND dzba002 = '",g_sd_ver CLIPPED,"' ",
                     #" AND dzba004 = '",lc_dzaa004 CLIPPED,"' "
   #END IF
#
   #DECLARE sadzp188_tab_modify_info_cs CURSOR FROM ls_sql
   #FOREACH sadzp188_tab_modify_info_cs INTO lc_crtid,lc_crtdt,lc_modid,lc_moddt
      #撈到mod一整組都有值就算是新的
      #IF lc_modid IS NOT NULL AND lc_moddt IS NOT NULL THEN
         #EXIT FOREACH
      #END IF
      #沒撈到就把crt這一組記起來
      #IF lc_crtid IS NOT NULL AND lc_crtdt IS NOT NULL THEN
         #LET lc_bakid = lc_crtid CLIPPED
         #LET lc_bakdt = lc_crtdt CLIPPED
      #END IF
   #END FOREACH
#
   #滾完了如果mod這一組還是null,就把crt拿出來用(有可能這個版次只有新增一個other func)
   #IF lc_modid IS NULL OR lc_moddt IS NULL THEN
      #LET lc_modid = lc_bakid 
      #LET lc_moddt = lc_bakdt 
   #END IF
   #FREE sadzp188_tab_modify_info_cs 
   ##140324報表不用這個_(e) 


   #先把dzga_t內的最高版次找出來 140324 -(S)
   SELECT MAX(DISTINCT(dzga002)) INTO lc_dzga002 FROM dzga_t
    WHERE dzga001 = g_prog_id 

   IF SQLCA.SQLCODE OR lc_dzga002 IS NULL THEN
      LET lc_dzga002 = "1"   #找不到就只好當作 1
   END IF

   LET ls_sql = "SELECT dzgacrtid,dzgacrtdt,dzgamodid,dzgamoddt FROM dzga_t ",
                " WHERE dzga001 = '",g_prog_id CLIPPED,"' ",
                  " AND dzga002 = '",lc_dzga002 CLIPPED,"' ",
                  " AND dzga006 = '",g_code_ide ,"'"   #140619 add

   DECLARE sadzp188_tab_modify_info_cs CURSOR FROM ls_sql
   FOREACH sadzp188_tab_modify_info_cs INTO lc_crtid,lc_crtdt,lc_modid,lc_moddt
      #撈到mod一整組都有值就算是新的
      IF lc_modid IS NOT NULL AND lc_moddt IS NOT NULL THEN
         EXIT FOREACH
      END IF
      #沒撈到就把crt這一組記起來
      IF lc_crtid IS NOT NULL AND lc_crtdt IS NOT NULL THEN
         LET lc_bakid = lc_crtid CLIPPED
         LET lc_bakdt = lc_crtdt CLIPPED
      END IF
   END FOREACH

   #滾完了如果mod這一組還是null,就把crt拿出來用(有可能這個版次只有新增一個other func)
   IF lc_modid IS NULL OR lc_moddt IS NULL THEN
      LET lc_modid = lc_bakid 
      LET lc_moddt = lc_bakdt 
   END IF
   FREE sadzp188_tab_modify_info_cs   
   #先把dzga_t內的最高版次找出來140324 -(S) 
   
   RETURN lc_modid,lc_moddt
END FUNCTION

#產生 tab 檔內的 define結構
PRIVATE FUNCTION sadzp188_tab_gen_define(lnode_define)
   DEFINE lnode_define      om.DomNode   #TAB DEFINE結構
   DEFINE lnode_section     om.DomNode
   DEFINE ls_def_record     STRING 
   DEFINE i                 LIKE type_t.num5
   DEFINE ls_temp           STRING
   DEFINE ls_dtable_str     STRING 
    
  
   #建置 define -> 接的參數個數及資訊
   #參數存的table還沒規劃，先給固定值
   #CALL sadzp188_combi_arg_str(g_prog_id,g_sd_ver) RETURNING ls_temp  #140619 mark
   CALL sadzp188_combi_arg_str(g_prog_id,g_sd_ver,g_code_ide) RETURNING ls_temp  #140619 add
   CALL lnode_define.setAttribute("arg",ls_temp)

   #define 主報表及子報表資訊
   #Call sadzp188_get_field(g_prog_id,g_sd_ver,'3') RETURNING ls_def_record,ls_dtable_str   #140619 mark
   Call sadzp188_get_field(g_prog_id,g_sd_ver,'3',g_code_ide) RETURNING ls_def_record,ls_dtable_str  #140619 add
   
   IF ls_def_record.getLength()>0 THEN 
       LET lnode_section = lnode_define.createChild("var")
       CALL lnode_section.setAttribute("seq","1")   
       CALL lnode_section.setAttribute("value",ls_def_record)
   END IF 
   ##140314-(S)
   ##有子報表備註
   IF g_dzgg007 ="Y" THEN 
                           ##KEY1, KEY2,   備註說明
       LET ls_def_record ="ooff013"
       LET lnode_section = lnode_define.createChild("var")
       CALL lnode_section.setAttribute("seq","2")   
       CALL lnode_section.setAttribute("value",ls_def_record)  
   #140717 mark沒有子報表不用組-(s)    
   #ELSE 
       #LET ls_def_record =""
       #LET lnode_section = lnode_define.createChild("var")
       #CALL lnode_section.setAttribute("seq","2")   
       #CALL lnode_section.setAttribute("value",ls_def_record)
   #140717 mark沒有子報表不用組-(e)       
   END IF 
   ##140314-(E)
END FUNCTION



PUBLIC FUNCTION sadzp188_get_field(p_prog_id,p_prog_ver,p_type,p_code_ide)    #140619 add
#PUBLIC FUNCTION sadzp188_get_field(p_prog_id,p_prog_ver,p_type)   #140619 mark
   DEFINE p_prog_id      LIKE dzgc_t.dzgc001
   DEFINE p_prog_ver     LIKE dzgc_t.dzgc002
   DEFINE p_type         LIKE dzgc_t.dzgc003            #欄位處理類型 2:SELECT, 3:印出record
   DEFINE p_code_ide     LIKE type_t.chr1               #140619 add 客製標示
   DEFINE ls_record_tmp  STRING
   DEFINE ls_def_record  STRING
   DEFINE ls_select_str  STRING   ##尚未使用
   DEFINE ls_dzgc004     LIKE dzgc_t.dzgc004
   DEFINE ls_dzgc006     LIKE dzgc_t.dzgc006
   DEFINE ls_dzgc007     LIKE dzgc_t.dzgc007
   DEFINE ls_dzgd004     LIKE dzgd_t.dzgd004
   DEFINE ls_dzgd004_tmp LIKE dzgd_t.dzgd004
   DEFINE ls_dzgd006     LIKE dzgd_t.dzgd006
   DEFINE ls_dzgd004_str STRING 
   DEFINE l_dzgi004_1    LIKE dzgi_t.dzgi004   #單頭
   DEFINE l_dzgi004_2    LIKE dzgi_t.dzgi004   #單身
   DEFINE ls_field_alias LIKE dzgh_t.dzgh010     ##回寫至dzgh_t的dzgh010欄位別名
   DEFINE ls_dtable_str  STRING                ##單身reference撈的欄位
   DEFINE ls_dzgd006_r   STRING 
   DEFINE ls_d_str       STRING
   DEFINE l_gzde003      LIKE gzde_t.gzde003    ##140604 報表元件類型 
   DEFINE l_gzde008      LIKE gzde_t.gzde008    #140619 add  
   DEFINE ls_detail_tables  STRING              #141127 add
   DEFINE l_cnt          LIKE type_t.num5       #150123 add
   DEFINE l_field_str    STRING                 #160615-00007#1 add 
   DEFINE l_dzgi_cnt     LIKE type_t.num5       #160615-00007#1 add 

   LET ls_def_record = ''
   LET ls_select_str = ''
   LET ls_detail_tables = ''  #141127 add
    IF p_type = "2" THEN LET ls_dtable_str ="" END IF 
   #資料模型欄位明細檔


   ##140325 新版  -(s)
   ##抓出單頭table
   SELECT dzgi004 INTO l_dzgi004_1 FROM dzgi_t 
    WHERE dzgi001 = p_prog_id AND dzgi002 = p_prog_ver AND dzgi003 = 1 
      AND dzgi006 = p_code_ide #140619 add   
   ##抓出單身table
   SELECT dzgi004 INTO l_dzgi004_2 FROM dzgi_t 
    WHERE dzgi001 = p_prog_id AND dzgi002 = p_prog_ver AND dzgi003 = 2 
      AND dzgi006 = p_code_ide #140619 add

    LET l_dzgi_cnt = 0  
    SELECT COUNT(dzgi004) INTO l_dzgi_cnt FROM dzgi_t 
     WHERE dzgi001 = p_prog_id AND dzgi002 = p_prog_ver 
       AND dzgi006 = p_code_ide 
      

   ##150123 add -(s) 
   #LET l_cnt = 0  
   #SELECT COUNT(dzag001) INTO l_cnt FROM dzag_t
    #WHERE dzag002 = l_dzgi004_1 AND dzag004 = l_dzgi004_2    
   #IF l_cnt = 0 THEN
      #LET l_dzgi004_2=''  
   #END IF 
   ##150123 add -(e)    
   ##抓出報表類型gr or xg  140605 -(s)
   #LET l_gzde008 ="Y"                                 #140619 add
   #IF p_code_ide ="s" THEN LET l_gzde008 ="N" END IF  #140619 add 
   LET l_gzde008 ="c"                                 #141023 add
   IF p_code_ide ="s" THEN LET l_gzde008 ="s" END IF  #141023 add 
   
   SELECT gzde003 INTO l_gzde003 FROM gzde_t WHERE gzde001 = p_prog_id
      AND gzde008 = l_gzde008    #140619 add
   ##抓出報表類型gr or xg  140605 -(s) 
   
   DECLARE sadzp188_get_field_cs CURSOR FOR
   SELECT dzgc004,dzgc006,dzgc007 FROM dzgc_t WHERE dzgc001 = p_prog_id AND dzgc002 = p_prog_ver AND (dzgc005 ='1' OR dzgc005 = p_type)
      AND dzgc009 = p_code_ide    #140619 add
   ORDER BY dzgc003
   
   FOREACH sadzp188_get_field_cs INTO ls_dzgc004,ls_dzgc006,ls_dzgc007 #欄位、是否為自訂欄位、table別名
        IF ls_dzgc006 = 'N' THEN  #從table挑選的欄位
           IF cl_null(ls_def_record) THEN  #第一筆
              #LET ls_def_record = ls_dzgc004
              #IF NOT sadzp188_chk_dtable_join_field(p_prog_id,p_prog_ver,ls_dzgc004,ls_dzgc007,l_dzgi004_2) THEN  #140619 mark 
              IF NOT sadzp188_chk_dtable_join_field(p_prog_id,p_prog_ver,ls_dzgc004,ls_dzgc007,l_dzgi004_2,p_code_ide) THEN  #140619 add
                IF ls_dzgc007 = sadzp188_get_table(ls_dzgc004) THEN  
                   ##不是單頭或單身的全加上別名或table名稱
                   ##150127 mark -(s)
                   #IF ls_dzgc007 <> l_dzgi004_1 AND ls_dzgc007 <> l_dzgi004_2 THEN  
                      #LET ls_def_record = ls_dzgc007,"_",ls_dzgc004,"(",ls_dzgc004,"|",ls_dzgc007,".",ls_dzgc004,")"
                      #LET ls_field_alias = ls_dzgc007,"_",ls_dzgc004       #140804 add           
                   #ELSE 
                      #LET ls_def_record = ls_dzgc004
                      #LET ls_field_alias = ls_dzgc004   #140804 add
                   #END IF
                   ##150127 mark -(e)
                   ##150127 add -(s) 
                   IF ls_dzgc007 = l_dzgi004_1 OR ls_dzgc007 = l_dzgi004_2 THEN                        
                      ##判斷有來源時，是否只有單頭沒單身
                      IF sadzp188_tab_chk_add_tablename(p_prog_id,p_prog_ver,p_code_ide,l_dzgi004_1,l_dzgi004_2) AND ls_dzgc007 = l_dzgi004_2  THEN
                         IF p_type ="3" THEN  #160615-00007#1 add
                             LET ls_def_record = ls_dzgc007,"_",ls_dzgc004,"(",ls_dzgc004,"|",ls_dzgc007,".",ls_dzgc004,")"
                         #160615-00007#1 add -(s)    
                         ELSE #sql段                              
                             LET l_field_str = ""
                             #CALL sadzp188_get_subquery_sql(p_prog_id,p_prog_ver,ls_dzgc004,ls_dzgc007,ls_dzgc006) RETURNING l_field_str   #161031-00071#1 mark
                             CALL sadzp188_get_subquery_sql(p_prog_id,p_prog_ver,ls_dzgc004,ls_dzgc007,ls_dzgc006,p_code_ide) RETURNING l_field_str    #161031-00071#1 add 
                             IF l_field_str.getLength() > 0 THEN  
                                LET ls_def_record = ls_dzgc007,"_",ls_dzgc004,"(",ls_dzgc004,"|",l_field_str,")"
                             ELSE 
                                LET ls_def_record = ls_dzgc007,"_",ls_dzgc004,"(",ls_dzgc004,"|",ls_dzgc007,".",ls_dzgc004,")"
                             END IF  
                         END IF 
                         #160615-00007#1 add -(e) 
                         LET ls_field_alias = ls_dzgc007,"_",ls_dzgc004      
                      ELSE
                         IF p_type ="3" THEN     #160615-00007#1 add
                             LET ls_def_record = ls_dzgc004
                             LET ls_field_alias = ls_dzgc004                            
                         #160615-00007#1 add -(s)
                         ELSE
                              #判斷資料表只有2個，剛好就是單頭與單身，且是有參考程式來源
                              IF l_dzgi_cnt = 2 THEN
                                 LET l_field_str = ""
                                 #CALL sadzp188_get_subquery_sql(p_prog_id,p_prog_ver,ls_dzgc004,ls_dzgc007,ls_dzgc006) RETURNING l_field_str             #161031-00071#1 mark
                                 CALL sadzp188_get_subquery_sql(p_prog_id,p_prog_ver,ls_dzgc004,ls_dzgc007,ls_dzgc006,p_code_ide) RETURNING l_field_str   #161031-00071#1 add
                                 IF l_field_str.getLength() > 0 THEN 
                                    IF cl_null(ls_def_record) THEN  
                                       LET ls_def_record = ls_dzgc004,"(",ls_dzgc004,"|",l_field_str,")" 
                                    ELSE 
                                       LET ls_def_record = ls_def_record, ls_dzgc004,"(",ls_dzgc004,"|",l_field_str,")"
                                    END IF 
                                 ELSE 
                                    IF cl_null(ls_def_record) THEN  
                                      LET ls_def_record = ls_dzgc004,"(",ls_dzgc004,"|",ls_dzgc004,")"
                                    ELSE 
                                      LET ls_def_record = ls_def_record,ls_dzgc004,"(",ls_dzgc004,"|",ls_dzgc004,")"
                                    END IF 
                                 END IF 
                                 LET ls_field_alias = ls_dzgc004
                              ELSE                             
                                 LET ls_def_record = ls_dzgc004
                                 LET ls_field_alias = ls_dzgc004
                              END IF                                   
                         END IF 
                         #160615-00007#1 add -(e)                         
                      END IF  
                   ELSE   #非單頭或單身的欄位
                      IF p_type ="3" THEN  #160615-00007#1 add
                         LET ls_def_record = ls_dzgc007,"_",ls_dzgc004,"(",ls_dzgc004,"|",ls_dzgc007,".",ls_dzgc004,")"
                      #160615-00007#1 add -(s)    
                      ELSE  #組g_from
                          LET l_field_str = ""
                          #CALL sadzp188_get_subquery_sql(p_prog_id,p_prog_ver,ls_dzgc004,ls_dzgc007,ls_dzgc006) RETURNING l_field_str              ##161031-00071#1 mark
                          CALL sadzp188_get_subquery_sql(p_prog_id,p_prog_ver,ls_dzgc004,ls_dzgc007,ls_dzgc006,p_code_ide) RETURNING l_field_str   #161031-00071#1 add
                          IF l_field_str.getLength() > 0 THEN
                             LET ls_def_record = ls_dzgc007,"_",ls_dzgc004,"(",ls_dzgc004,"|",l_field_str,")"
                          ELSE   
                             LET ls_def_record = ls_dzgc007,"_",ls_dzgc004,"(",ls_dzgc004,"|",ls_dzgc007,".",ls_dzgc004,")"
                          END IF                   
                      END IF 
                      #160615-00007#1 add -(e)  
                      LET ls_field_alias = ls_dzgc007,"_",ls_dzgc004                             
                   END IF                   
                   ##150127 add -(e)
                   #LET ls_field_alias = ls_dzgc004  #140804 mark
                ELSE
                   ##150123 add -(s)
                   ##不是單頭或單身的全加上別名或table名稱
                   ##150127 mark -(s)
                   #IF ls_dzgc007 <> l_dzgi004_1 AND ls_dzgc007 <> l_dzgi004_2 THEN  
                      #LET ls_def_record = ls_dzgc007,"_",ls_dzgc004,"(",ls_dzgc004,"|",ls_dzgc007,".",ls_dzgc004,")"
                      #LET ls_field_alias = ls_dzgc007,"_",ls_dzgc004       #140804 add           
                   #ELSE 
                      #LET ls_def_record = ls_dzgc004
                      #LET ls_field_alias = ls_dzgc004   #140804 add
                   #END IF
                   ##150123 add -(e)   
                   ##150127 mark -(e) 
                   ##150127 add -(s) 
                   IF ls_dzgc007 = l_dzgi004_1 AND ls_dzgc007 = l_dzgi004_2 THEN 
                      ##判斷有來源時，是否只有單頭沒單身
                      IF sadzp188_tab_chk_add_tablename(p_prog_id,p_prog_ver,p_code_ide,l_dzgi004_1,l_dzgi004_2) AND ls_dzgc007 = l_dzgi004_2  THEN
                         IF p_type = "3" THEN   #160615-00007#1 add                   
                            LET ls_def_record = ls_dzgc007,"_",ls_dzgc004,"(",ls_dzgc004,"|",ls_dzgc007,".",ls_dzgc004,")"
                         #160615-00007#1 add -(s)    
                         ELSE 
                             LET l_field_str = ""
                             #CALL sadzp188_get_subquery_sql(p_prog_id,p_prog_ver,ls_dzgc004,ls_dzgc007,ls_dzgc006) RETURNING l_field_str  #161031-00071#1 mark
                             CALL sadzp188_get_subquery_sql(p_prog_id,p_prog_ver,ls_dzgc004,ls_dzgc007,ls_dzgc006,p_code_ide) RETURNING l_field_str    #161031-00071#1  add
                             IF l_field_str.getLength() > 0  THEN
                                LET ls_def_record = ls_dzgc007,"_",ls_dzgc004,"(",ls_dzgc004,"|",l_field_str,")"
                             ELSE   
                                LET ls_def_record = ls_dzgc007,"_",ls_dzgc004,"(",ls_dzgc004,"|",ls_dzgc007,".",ls_dzgc004,")"
                             END IF                   
                         END IF 
                         #160615-00007#1 add -(e)   
                         LET ls_field_alias = ls_dzgc007,"_",ls_dzgc004      
                      ELSE
                         LET ls_def_record = ls_dzgc004
                         LET ls_field_alias = ls_dzgc004                          
                      END IF                   
                  
                   ELSE 
                     IF p_type = "3" THEN   #160615-00007#1 add     
                        LET ls_def_record = ls_dzgc007,"_",ls_dzgc004,"(",ls_dzgc004,"|",ls_dzgc007,".",ls_dzgc004,")"
                     #160615-00007#1 add -(s)    
                     ELSE 
                         LET l_field_str = ""
                         #CALL sadzp188_get_subquery_sql(p_prog_id,p_prog_ver,ls_dzgc004,ls_dzgc007,ls_dzgc006) RETURNING l_field_str   #161031-00071#1 mark
                        CALL sadzp188_get_subquery_sql(p_prog_id,p_prog_ver,ls_dzgc004,ls_dzgc007,ls_dzgc006,p_code_ide) RETURNING l_field_str     #161031-00071#1 add
                         IF l_field_str.getLength() > 0  THEN
                            LET ls_def_record = ls_dzgc007,"_",ls_dzgc004,"(",ls_dzgc004,"|",l_field_str,")"
                         ELSE   
                            LET ls_def_record = ls_dzgc007,"_",ls_dzgc004,"(",ls_dzgc004,"|",ls_dzgc007,".",ls_dzgc004,")"
                         END IF                   
                     END IF 
                     #160615-00007#1 add -(e)  
                     LET ls_field_alias = ls_dzgc007,"_",ls_dzgc004
                   END IF
                   ##150127 add -(e)                      
                    ##150123 mark -(s)             
                   #LET ls_def_record = ls_dzgc007,"_",ls_dzgc004,"(",ls_dzgc004,"|",ls_dzgc007,".",ls_dzgc004,")"
                   #LET ls_field_alias = ls_dzgc007,"_",ls_dzgc004
                   ##150123 mark -(e) 
                END IF 
              ELSE ##
                LET ls_def_record = "x_",ls_dzgc007,"_",ls_dzgc004,"(",ls_dzgc004,"|","x.",ls_dzgc007,"_",ls_dzgc004,")"
                LET ls_field_alias = "x_",ls_dzgc007,"_",ls_dzgc004
                ##單身join出來的欄位 
                IF p_type = "2" THEN 
                    ##EX:t1.imaal004 t1_imaal004   單身left join出來的欄位取別名
                    IF cl_null(ls_dtable_str) THEN 
                       LET ls_dtable_str = ls_dzgc007,".",ls_dzgc004," ", ls_dzgc007,"_",ls_dzgc004
                    ELSE 
                       LET ls_dtable_str = ls_dtable_str ,",",ls_dzgc007,".",ls_dzgc004," ", ls_dzgc007,"_",ls_dzgc004
                    END IF 
                END IF            
              END IF 
              
           ELSE 
             ##非單身TABLE JOIN出來的欄位
             #IF NOT sadzp188_chk_dtable_join_field(p_prog_id,p_prog_ver,ls_dzgc004,ls_dzgc007,l_dzgi004_2) THEN  #140619 mark
              IF NOT sadzp188_chk_dtable_join_field(p_prog_id,p_prog_ver,ls_dzgc004,ls_dzgc007,l_dzgi004_2,p_code_ide) THEN    #140619 add
                IF ls_dzgc007 = sadzp188_get_table(ls_dzgc004) THEN 
                   ##不是單頭或單身的全加上別名或table名稱
                   ##150123 mark -(s)
                   #IF ls_dzgc007 <> l_dzgi004_1 AND ls_dzgc007 <> l_dzgi004_2 THEN  
                      #LET ls_def_record = ls_def_record , ",",ls_dzgc007,"_",ls_dzgc004,"(",ls_dzgc004,"|",ls_dzgc007,".",ls_dzgc004,")"
                      #LET ls_field_alias = ls_dzgc007,"_",ls_dzgc004
                   #ELSE 
                      #LET ls_def_record = ls_def_record , ",",ls_dzgc004
                      #LET ls_field_alias = ls_dzgc004
                   #END IF
                   ##150123 mark -(e)
                   ##150123 add -(s) 
                   IF ls_dzgc007 = l_dzgi004_1 OR ls_dzgc007 = l_dzgi004_2 THEN  

                      ##判斷有來源時，是否只有單頭沒單身
                      IF sadzp188_tab_chk_add_tablename(p_prog_id,p_prog_ver,p_code_ide,l_dzgi004_1,l_dzgi004_2) AND ls_dzgc007 = l_dzgi004_2  THEN
                         IF p_type ="3" THEN
                            LET ls_def_record = ls_def_record , ",",ls_dzgc007,"_",ls_dzgc004,"(",ls_dzgc004,"|",ls_dzgc007,".",ls_dzgc004,")"
                         #160615-00007#1 add -(s)    
                         ELSE 
                             LET l_field_str = ""
                             #CALL sadzp188_get_subquery_sql(p_prog_id,p_prog_ver,ls_dzgc004,ls_dzgc007,ls_dzgc006) RETURNING l_field_str    #161031-00071#1 mark
                             CALL sadzp188_get_subquery_sql(p_prog_id,p_prog_ver,ls_dzgc004,ls_dzgc007,ls_dzgc006,p_code_ide) RETURNING l_field_str     #161031-00071#1 add
                             IF l_field_str.getLength() > 0  THEN
                                LET ls_def_record = ls_def_record , ",",ls_dzgc007,"_",ls_dzgc004,"(",ls_dzgc004,"|",l_field_str,")"
                             ELSE   
                                LET ls_def_record = ls_def_record , ",",ls_dzgc007,"_",ls_dzgc004,"(",ls_dzgc004,"|",ls_dzgc007,".",ls_dzgc004,")"
                             END IF                   
                         END IF 
                         #160615-00007#1 add -(e)
                         LET ls_field_alias = ls_dzgc007,"_",ls_dzgc004      
                      ELSE

                          IF p_type ="3" THEN    #160615-00007#1 add
                              LET ls_def_record = ls_def_record , ",",ls_dzgc004
                              LET ls_field_alias = ls_dzgc004
                          #160615-00007#1 add -(s)                              
                          ELSE
                              #判斷資料表只有2個，剛好就是單頭與單身，且是有參考程式來源
                              IF l_dzgi_cnt = 2 THEN
                                 LET l_field_str = ""
                                 #CALL sadzp188_get_subquery_sql(p_prog_id,p_prog_ver,ls_dzgc004,ls_dzgc007,ls_dzgc006) RETURNING l_field_str    #161031-00071#1 mark
                                 CALL sadzp188_get_subquery_sql(p_prog_id,p_prog_ver,ls_dzgc004,ls_dzgc007,ls_dzgc006,p_code_ide) RETURNING l_field_str     #161031-00071#1 add
                                 IF l_field_str.getLength() > 0 THEN  
                                    IF cl_null(ls_def_record) THEN 
                                       LET ls_def_record = ls_dzgc004,"(",ls_dzgc004,"|",l_field_str,")"
                                    ELSE 
                                       LET ls_def_record = ls_def_record,",",ls_dzgc004,"(",ls_dzgc004,"|",l_field_str,")"
                                    END IF 
                                 ELSE 
                                    IF cl_null(ls_def_record) THEN 
                                       LET ls_def_record = ls_dzgc004,"(",ls_dzgc004,"|",ls_dzgc004,")" 
                                    ELSE 
                                       LET ls_def_record = ls_def_record,",",ls_dzgc004,"(",ls_dzgc004,"|",ls_dzgc004,")"
                                    END IF 
                                 END IF 
                                 LET ls_field_alias = ls_dzgc004 
                              ELSE 
                                  LET ls_def_record = ls_def_record , ",",ls_dzgc004
                                  LET ls_field_alias = ls_dzgc004 
                              END IF                              
                          END IF     
                          #160615-00007#1 add -(e)                          
                      END IF  

                   ELSE 
                      IF p_type = "3" THEN #160615-00007#1 add
                         LET ls_def_record = ls_def_record , ",",ls_dzgc007,"_",ls_dzgc004,"(",ls_dzgc004,"|",ls_dzgc007,".",ls_dzgc004,")"
                      #160615-00007#1 add -(s)    
                      ELSE                          
                          LET l_field_str = ""
                          #CALL sadzp188_get_subquery_sql(p_prog_id,p_prog_ver,ls_dzgc004,ls_dzgc007,ls_dzgc006) RETURNING l_field_str   #161031-00071#1 mark
                          CALL sadzp188_get_subquery_sql(p_prog_id,p_prog_ver,ls_dzgc004,ls_dzgc007,ls_dzgc006,p_code_ide) RETURNING l_field_str    #161031-00071#1 add  
                          IF l_field_str.getLength() > 0  THEN
                             LET ls_def_record = ls_def_record , ",",ls_dzgc007,"_",ls_dzgc004,"(",ls_dzgc004,"|",l_field_str,")"
                          ELSE   
                             LET ls_def_record = ls_def_record , ",",ls_dzgc007,"_",ls_dzgc004,"(",ls_dzgc004,"|",ls_dzgc007,".",ls_dzgc004,")"
                          END IF                   
                      END IF 
                      #160615-00007#1 add -(e)    
                      LET ls_field_alias = ls_dzgc007,"_",ls_dzgc004
                   END IF  
                    ##150123 add -(e)                   
                ELSE
                   IF p_type = "3" THEN #160615-00007#1 add
                       LET ls_def_record = ls_def_record , ",",ls_dzgc007,"_",ls_dzgc004,"(",ls_dzgc004,"|",ls_dzgc007,".",ls_dzgc004,")"
                   #160615-00007#1 add -(s)    
                   ELSE 
                       LET l_field_str = ""
                       #CALL sadzp188_get_subquery_sql(p_prog_id,p_prog_ver,ls_dzgc004,ls_dzgc007,ls_dzgc006) RETURNING l_field_str  #161031-00071#1 mark
                       CALL sadzp188_get_subquery_sql(p_prog_id,p_prog_ver,ls_dzgc004,ls_dzgc007,ls_dzgc006,p_code_ide) RETURNING l_field_str    #161031-00071#1 add
                       IF l_field_str.getLength() > 0  THEN
                          LET ls_def_record = ls_def_record , ",",ls_dzgc007,"_",ls_dzgc004,"(",ls_dzgc004,"|",l_field_str,")"
                       ELSE   
                          LET ls_def_record = ls_def_record , ",",ls_dzgc007,"_",ls_dzgc004,"(",ls_dzgc004,"|",ls_dzgc007,".",ls_dzgc004,")"
                       END IF                   
                   END IF 
                   #160615-00007#1 add -(e)   
                   LET ls_field_alias = ls_dzgc007,"_",ls_dzgc004
                END IF 
             ELSE ##
                ##單身欄位在g_select不用調成subquery方式
                LET ls_def_record = ls_def_record , ",","x_",ls_dzgc007,"_",ls_dzgc004,"(",ls_dzgc004,"|","x.",ls_dzgc007,"_",ls_dzgc004,")"
                LET ls_field_alias = "x_",ls_dzgc007,"_",ls_dzgc004
                ##單身join出來的欄位 
                IF p_type = "2" THEN 
                    ##EX:t1.imaal004 t1_imaal004   單身left join出來的欄位取別名
                    IF cl_null(ls_dtable_str) THEN                      
                       #LET ls_dtable_str = ls_dzgc007,".",ls_dzgc004," ", ls_dzgc007,"_",ls_dzgc004 #160615-00007#1 mark
                       #160615-00007#1  add  -(s)
                       LET l_field_str = ""
                       #CALL sadzp188_get_subquery_sql(p_prog_id,p_prog_ver,ls_dzgc004,ls_dzgc007,ls_dzgc006) RETURNING l_field_str   #161031-00071#1 mark
                       CALL sadzp188_get_subquery_sql(p_prog_id,p_prog_ver,ls_dzgc004,ls_dzgc007,ls_dzgc006,p_code_ide) RETURNING l_field_str    #161031-00071#1 add
                       IF l_field_str.getLength() > 0  THEN
                          LET ls_dtable_str = l_field_str ," ", ls_dzgc007,"_",ls_dzgc004
                       ELSE     
                          LET ls_dtable_str = ls_dzgc007,".",ls_dzgc004," ", ls_dzgc007,"_",ls_dzgc004
                       END IF 
                       #160615-00007#1  add -(e)
                    ELSE 
                       #LET ls_dtable_str = ls_dtable_str ,",",ls_dzgc007,".",ls_dzgc004," ", ls_dzgc007,"_",ls_dzgc004 #160615-00007#1  mark
                       #160615-00007#1  add  -(s)
                       LET l_field_str = ""
                       #CALL sadzp188_get_subquery_sql(p_prog_id,p_prog_ver,ls_dzgc004,ls_dzgc007,ls_dzgc006) RETURNING l_field_str   #161031-00071#1 mark
                       CALL sadzp188_get_subquery_sql(p_prog_id,p_prog_ver,ls_dzgc004,ls_dzgc007,ls_dzgc006,p_code_ide) RETURNING l_field_str    #161031-00071#1 add
                       IF l_field_str.getLength() > 0  THEN
                          LET ls_dtable_str = ls_dtable_str ,",",l_field_str," ", ls_dzgc007,"_",ls_dzgc004
                       ELSE
                          LET ls_dtable_str = ls_dtable_str ,",",ls_dzgc007,".",ls_dzgc004," ", ls_dzgc007,"_",ls_dzgc004
                       END IF
                       #160615-00007#1  add  -(e)
                    END IF 

                END IF            
             END IF 
           END IF            
        ELSE  #自定義欄位
           SELECT dzgd004,dzgd006 INTO ls_dzgd004_tmp,ls_dzgd006
             FROM dzgd_t 
            WHERE dzgd001 = p_prog_id AND dzgd002 = p_prog_ver AND dzgd003 = ls_dzgc004
              AND dzgd008 = p_code_ide #140619 add
           IF SQLCA.SQLCODE THEN
              ##目前想不到會有找不到的狀態
           END IF
           IF NOT (cl_null(ls_dzgd004_tmp) AND cl_null(ls_dzgd006)) THEN 
               LET ls_dzgd004_str = ls_dzgd004_tmp           
               LET ls_dzgd004 = ls_dzgd004_str.subString(ls_dzgd004_str.getIndexOf(".",1)+1, ls_dzgd004_str.getLength())
               ##TABLE
               LET ls_dzgc007 = ls_dzgd004_str.subString(1,ls_dzgd004_str.getIndexOf(".",1)-1)
               IF ls_dzgd006 IS NULL THEN 
                  LET ls_dzgd006 = "\''"   #空值放''
               ELSE
                  #CALL sadzp188_tab_handle_usr_define(p_prog_id,p_prog_ver,p_type,ls_dzgd006,l_dzgi004_1,l_dzgi004_2) RETURNING ls_dzgd006_r,ls_d_str  #140619 mark
                  CALL sadzp188_tab_handle_usr_define(p_prog_id,p_prog_ver,p_type,ls_dzgd006,l_dzgi004_1,l_dzgi004_2,p_code_ide) RETURNING ls_dzgd006_r,ls_d_str  #140619 add
               END IF 
               IF NOT cl_null(ls_d_str) THEN 
                  IF cl_null(ls_dtable_str) THEN                      
                     LET ls_dtable_str = ls_d_str
                  ELSE 
                     LET ls_dtable_str = ls_dtable_str ,",",ls_d_str
                  END IF            
               END IF 
               #160615-00007#1  add  -(s)
               IF cl_null(ls_def_record) THEN   
                  LET ls_def_record = ls_dzgc004,"(",ls_dzgd004,"|",ls_dzgd006_r,")"
               ELSE
                  LET ls_def_record = ls_def_record , ",",ls_dzgc004,"(",ls_dzgd004,"|",ls_dzgd006_r,")"
               END IF 
               #160615-00007#1  add  -(e)
               #LET ls_def_record = ls_def_record , ",",ls_dzgc004,"(",ls_dzgd004,"|",ls_dzgd006_r,")" #160615-00007#1  mark
               LET ls_field_alias = ls_dzgc004
           END IF 
        END IF    
         #DISPLAY "欄位：",ls_dzgc004,"別名：", ls_field_alias
        IF l_gzde003 ="G" THEN  ##140605 判斷GR 更新dzgh010
          CALL sadzp188_update_dzgh010(ls_dzgc004,ls_dzgc007,ls_field_alias,p_prog_id,p_code_ide,p_prog_ver)  #140619 add p_code_ide
        ELSE                   ##140605 判斷xg 更新dzgl026gzgg026
          CALL sadzp188_update_dzgl028gzgg026(ls_dzgc004,ls_dzgc007,ls_field_alias,p_prog_id,p_code_ide,p_prog_ver)  #140619 add p_code_ide
        END IF 
   END FOREACH    
   ##140325 新版  -(e)
   
   RETURN ls_def_record,ls_dtable_str
   
END FUNCTION 


##140423 -(s)
#FUNCTION sadzp188_tab_handle_usr_define(p_prog_id,p_prog_ver,p_type,p_dzgd006,p_dzgi004_1,p_dzgi004_2)#140619 mark
FUNCTION sadzp188_tab_handle_usr_define(p_prog_id,p_prog_ver,p_type,p_dzgd006,p_dzgi004_1,p_dzgi004_2,p_code_ide) #140619 add
   DEFINE p_prog_id      LIKE dzgc_t.dzgc001
   DEFINE p_prog_ver     LIKE dzaa_t.dzaa002
   DEFINE p_type         LIKE dzgc_t.dzgc003
   DEFINE p_dzgd006      LIKE dzgd_t.dzgd006
   DEFINE p_dzgi004_1    LIKE dzgi_t.dzgi004   ##單頭
   DEFINE p_dzgi004_2    LIKE dzgi_t.dzgi004   ##單身
   DEFINE p_code_ide     LIKE type_t.chr1
   DEFINE ls_dzgd006     STRING
   DEFINE ls_dzgd006_tmp STRING
   DEFINE ls_dzgd006_tmp1 STRING 
   DEFINE ls_tmp_buf     base.StringBuffer 
   DEFINE ls_dzgc004     LIKE dzgc_t.dzgc004
   DEFINE ls_dzgc007     LIKE dzgc_t.dzgc007
   DEFINE ls_d_str       STRING 
   DEFINE ls_return_str  STRING 
   DEFINE l_field_str    STRING                #160615-00007#1 add
   

   LET ls_dzgd006 = p_dzgd006
   LET ls_dzgd006_tmp = ""
   LET ls_tmp_buf = base.StringBuffer.create()
   CALL ls_tmp_buf.clear()
   CALL ls_tmp_buf.append(ls_dzgd006)
   LET ls_d_str =""
   WHILE ls_dzgd006.getIndexOf(".",1) > 0 
     IF ls_dzgd006.getIndexOf("trim(",1) > 0 THEN 
        ##取第一個trim欄位
        LET ls_dzgd006_tmp = ls_dzgd006.subString(ls_dzgd006.getIndexOf("(",1)+1,ls_dzgd006.getIndexOf(")",1)-1)
        ##取得table名        
        LET ls_dzgc007 = ls_dzgd006_tmp.subString(1, ls_dzgd006_tmp.getIndexOf(".",1)-1)
        ##取得欄位名
        LET ls_dzgc004 = ls_dzgd006_tmp.subString(ls_dzgd006_tmp.getIndexOf(".",1)+1,ls_dzgd006_tmp.getLength())
        #IF NOT sadzp188_chk_dtable_join_field(p_prog_id,p_prog_ver,ls_dzgc004,ls_dzgc007,p_dzgi004_2) THEN  #140619 mark  
        IF NOT sadzp188_chk_dtable_join_field(p_prog_id,p_prog_ver,ls_dzgc004,ls_dzgc007,p_dzgi004_2,p_code_ide) THEN  #140619 add
           IF ls_dzgc007 = sadzp188_get_table(ls_dzgc004) THEN  
                ##不是單頭或單身的全加上別名或table名稱
              IF ls_dzgc007 <> p_dzgi004_1 AND ls_dzgc007 <> p_dzgi004_2 THEN 
                 #LET ls_dzgd006_tmp1 = ls_dzgd006_tmp  #160615-00007#1 mark
                 #160615-00007#1  add  -(s)
                 LET l_field_str = ""
                 #CALL sadzp188_get_subquery_sql(p_prog_id,p_prog_ver,ls_dzgc004,ls_dzgc007,'Y') RETURNING l_field_str   #161031-00071#1 mark
                 CALL sadzp188_get_subquery_sql(p_prog_id,p_prog_ver,ls_dzgc004,ls_dzgc007,'Y',p_code_ide) RETURNING l_field_str    #161031-00071#1 add
                 IF l_field_str.getLength() > 0  THEN
                    LET ls_dzgd006_tmp1 = "(",l_field_str,")"
                 ELSE 
                   LET ls_dzgd006_tmp1 = ls_dzgd006_tmp
                 END IF 
                 #160615-00007#1  add  -(e) 
              ELSE 
                 LET ls_dzgd006_tmp1 = ls_dzgc004
              END IF
           ELSE 
                 #LET ls_dzgd006_tmp1 = ls_dzgd006_tmp   #160615-00007#1 mark
                 #160615-00007#1  add  -(s)
                 LET l_field_str = ""
                 #CALL sadzp188_get_subquery_sql(p_prog_id,p_prog_ver,ls_dzgc004,ls_dzgc007,'Y') RETURNING l_field_str   #161031-00071#1 mark
                 CALL sadzp188_get_subquery_sql(p_prog_id,p_prog_ver,ls_dzgc004,ls_dzgc007,'Y',p_code_ide) RETURNING l_field_str    #161031-00071#1 add
                 IF l_field_str.getLength() > 0  THEN
                    LET ls_dzgd006_tmp1 = "(",l_field_str,")"
                 ELSE                         
                   LET ls_dzgd006_tmp1 = ls_dzgd006_tmp  
                 END IF  
                 #160615-00007#1  add  -(e)    
           END IF 
        ELSE ##
             LET ls_dzgd006_tmp1 = "x.",ls_dzgc007,"_",ls_dzgc004
             ##140424-mark(s)自定義欄位不需定義-
             ##單身join出來的欄位 
             #IF p_type = "2" THEN 
                 #IF cl_null(ls_d_str) THEN 
                    ##EX:t1.imaal004 t1_imaal004   單身left join出來的欄位取別名
                    #LET ls_d_str = ls_dzgc007,".",ls_dzgc004," ", ls_dzgc007,"_",ls_dzgc004
                 #ELSE 
                    #LET ls_d_str = ls_d_str ,",",ls_dzgc007,".",ls_dzgc004," ", ls_dzgc007,"_",ls_dzgc004
                 #END IF 
            #END IF
            ##140424-mark(e)自定義欄位不需定義            
        END IF   
        LET ls_dzgd006 = ls_dzgd006.subString(ls_dzgd006.getIndexOf(")",1)+ 1, ls_dzgd006.getLength())
        CALL ls_tmp_buf.replace(ls_dzgd006_tmp,ls_dzgd006_tmp1,0)   
     END IF 
   END WHILE 
   LET ls_return_str = ls_tmp_buf.toString()


   RETURN ls_return_str,ls_d_str
END FUNCTION 
##140423 -(e)

#FUNCTION sadzp188_update_dzgh010(ps_dzgc004,ps_dzgc007,ps_dzgh010,p_code_ide) #140619 mark
FUNCTION sadzp188_update_dzgh010(ps_dzgc004,ps_dzgc007,ps_dzgh010,p_prog_id,ps_code_ide,ps_code_ver)  #140619 add  #140730 add
   DEFINE  ps_dzgc004    LIKE dzgc_t.dzgc004
   DEFINE  ps_dzgc007    LIKE dzgc_t.dzgc007
   DEFINE  ps_dzgh010    LIKE dzgh_t.dzgh010
   DEFINE  ps_code_ver   LIKE dzgh_t.dzgh002  #140730
   DEFINE  p_prog_id     LIKE dzgh_t.dzgh001  #140730
   DEFINE  ps_code_ide   LIKE type_t.chr1
   
      UPDATE dzgh_t
         SET dzgh010 = ps_dzgh010
       #WHERE dzgh001 = g_prog_id AND dzgh002 = g_sd_ver   #140730 mark
       WHERE dzgh001 = p_prog_id AND dzgh002 = ps_code_ver  #140730 add
         AND dzgh007 = ps_dzgc004 AND dzgh009 = ps_dzgc007
         AND dzgh012 = ps_code_ide  #140619 add
      IF SQLCA.SQLCODE THEN

      END IF
      #DISPLAY "dzgc004:",ps_dzgc004,"  ps_dzgc007:",ps_dzgc007," ps_dzgh010:",ps_dzgh010 
END FUNCTION 


##140605 xg更新欄位別名  -(s) 先存設計資料
FUNCTION sadzp188_update_dzgl028gzgg026(ps_dzgc004,ps_dzgc007,ps_dzgh010,p_prog_id,p_code_ide,ps_code_ver) #140619 add ,p_code_ide #140730 add ,ps_code_ver
   DEFINE  ps_dzgc004    LIKE dzgc_t.dzgc004
   DEFINE  ps_dzgc007    LIKE dzgc_t.dzgc007
   DEFINE  ps_dzgh010    LIKE dzgh_t.dzgh010
   DEFINE  ps_code_ver   LIKE dzgl_t.dzgl002  #140730 add
   DEFINE  p_prog_id     LIKE dzgl_t.dzgl001   #140730 add
   DEFINE  p_code_ide    LIKE type_t.chr1 #140619 add

   
      UPDATE dzgl_t
         SET dzgl028 = ps_dzgh010
       #WHERE dzgl001 = g_prog_id AND dzgl002 = g_sd_ver  #140730 mark
       WHERE dzgl001 = p_prog_id AND dzgl002 = ps_code_ver   #140730 add
         AND dzgl005 = ps_dzgc004 AND dzgl027 = ps_dzgc007
         AND dzgl030 = p_code_ide   #140619 add
      IF SQLCA.SQLCODE THEN

      END IF

      
  
      #DISPLAY "dzgc004:",ps_dzgc004,"  ps_dzgc007:",ps_dzgc007," ps_dzgh010:",ps_dzgh010 
END FUNCTION 
##140605 xg更新欄位別名  -(s)

##判斷欄位是由單身join取得~~
FUNCTION sadzp188_chk_dtable_join_field(p_prog_id,p_prog_ver,p_dzgc004,p_dzgc007,p_dzgi004,p_code_ide)
   DEFINE p_prog_id      LIKE dzgb_t.dzgb001
   DEFINE p_prog_ver     LIKE dzgb_t.dzgb002
   DEFINE p_dzgc004      LIKE dzgc_t.dzgc004
   DEFINE p_dzgc007      LIKE dzgc_t.dzgc007
   DEFINE p_dzgi004      LIKE dzgi_t.dzgi004
   DEFINE p_code_ide     LIKE type_t.chr1 #140619 add
   DEFINE l_cnt          LIKE type_t.num5


   LET l_cnt = 0 
   ##一種是用欄位去找dzgb，若有找到則要加上單身x.欄位別名
   SELECT COUNT(*) INTO l_cnt FROM dzgb_t
    WHERE dzgb001 = g_prog_id AND dzgb002 = g_sd_ver AND dzgb005 = p_dzgi004 AND dzgb016 = p_dzgc004 AND dzgb017 = p_dzgc007
      AND dzgb019 = p_code_ide #140619 add
   ##一種是用table別名去找，若是在單身join 別的table段，中則要加上單身x.欄位別名
   SELECT COUNT(*) INTO l_cnt FROM dzgb_t
    WHERE dzgb001 = p_prog_id AND dzgb002 = p_prog_ver AND dzgb005 = p_dzgi004 AND dzgb017 = p_dzgc007
      AND dzgb019 = p_code_ide #140619 add
    
   RETURN l_cnt 
   

END FUNCTION 

##組參數檔dzgj_t的資訊
FUNCTION sadzp188_combi_arg_str(p_prog_id,p_prog_ver,p_code_ide)  #140619 add p_code_ide
   DEFINE p_prog_id      LIKE dzgc_t.dzgc001
   DEFINE p_prog_ver     LIKE dzgc_t.dzgc002
   DEFINE l_arg_str      STRING 
   DEFINE p_code_ide     LIKE type_t.chr1
   DEFINE lc_dzgj003     LIKE dzgj_t.dzgj003
   DEFINE lc_dzgj004     LIKE dzgj_t.dzgj004
   DEFINE lc_dzgj005     LIKE dzgj_t.dzgj005
   DEFINE lc_dzgj006     LIKE dzgj_t.dzgj006
   

   LET l_arg_str = ""
   DECLARE sadzp188_get_arg_cs CURSOR FOR 
           SELECT dzgj003,dzgj004,dzgj005,dzgj006 FROM dzgj_t 
            WHERE dzgj001 = p_prog_id AND dzgj002 = p_prog_ver
              AND dzgj008 = p_code_ide  #140619 add
            ORDER BY dzgj003 
   FOREACH sadzp188_get_arg_cs INTO lc_dzgj003,lc_dzgj004,lc_dzgj005,lc_dzgj006
     IF lc_dzgj005 = "0" THEN LET lc_dzgj005 ="STRING" END IF 
     IF lc_dzgj003 = 1 THEN
        LET l_arg_str = lc_dzgj004,"(",lc_dzgj005,"|",lc_dzgj006,")"
     ELSE 
        LET l_arg_str = l_arg_str ,",",lc_dzgj004,"(",lc_dzgj005,"|",lc_dzgj006,")"
     END IF 
   END FOREACH 

   RETURN l_arg_str
   
END FUNCTION 


#將傳入的欄位清單,濾除 b_ 後傳出
PRIVATE FUNCTION sadzp188_tab_cut_b(ls_cols)

   DEFINE l_token   base.StringTokenizer
   DEFINE ls_cols   STRING
   DEFINE ls_next   STRING
   DEFINE ls_return STRING

   LET l_token = base.StringTokenizer.create(ls_cols CLIPPED,",")
   LET ls_return = ""

   WHILE l_token.hasMoreTokens()
      LET ls_next = l_token.nextToken()
      IF ls_next.subString(1,2) = "b_" AND ls_next.getLength() > 3 THEN
         LET ls_next = ls_next.subString(3,ls_next.getLength())
      END IF
      LET ls_return = ls_return,ls_next,","
   END WHILE

   RETURN ls_return.subString(1,ls_return.getLength()-1)

END FUNCTION


#多KEY的分解
PRIVATE FUNCTION sadzp188_tab_get_ref_mkey(ls_reffk)

   DEFINE ls_reffk   STRING
   DEFINE ls_lastcol STRING
   DEFINE ls_wc      STRING
   DEFINE l_token1   base.StringTokenizer
   DEFINE ls_next1   STRING

   LET l_token1 = base.StringTokenizer.create(ls_reffk, ",")
   LET ls_wc = ""
   
   WHILE l_token1.hasMoreTokens()
      LET ls_next1 = l_token1.nextToken()
      LET ls_lastcol = ls_next1
      LET ls_wc = ls_wc,ls_next1,"=? AND "
   END WHILE

   RETURN ls_wc.subString(1,ls_wc.getLength()-4),ls_lastcol
END FUNCTION


#抓取多語言欄位 
PRIVATE FUNCTION sadzp188_get_langual_col(ls_colany)

   DEFINE ls_colany  STRING
   DEFINE ls_collang STRING
   DEFINE li_pos     LIKE type_t.num5
   DEFINE li_cnt     LIKE type_t.num5
   DEFINE lc_chr     LIKE type_t.chr1

   #傳入值安全性檢查:未傳入任何值,則直接回傳空
   IF ls_colany.getLength() < 1 THEN
      RETURN ""
   END IF

   #直接取流水號+1 (假定語言別欄位都是在PK後方第一個)
   FOR li_pos = 1 TO ls_colany.getLength()
      LET lc_chr = ls_colany.subString(li_pos,li_pos)
      IF lc_chr MATCHES "[0-9]" THEN 
         EXIT FOR
      END IF
   END FOR
 
   LET li_cnt = ls_colany.subString(li_pos,ls_colany.getLength()) + 1
   LET ls_collang = ls_colany.subString(1,li_pos-1),li_cnt USING "&&&"

   #此處應該要回頭檢查該欄位是否為語言別欄位

   RETURN ls_collang

END FUNCTION

#+ 確認PK欄位是否完全存在 master清單中 (全到:TRUE/缺少:FALSE)
PRIVATE FUNCTION sadzp188_tab_check_real_t01(ls_master,ls_pk) 
   DEFINE ls_master  STRING
   DEFINE ls_pk      STRING
   DEFINE li_status  LIKE type_t.num5  #檢查結果
   DEFINE l_token    base.StringTokenizer
   DEFINE ls_next    STRING

   #設定初始值
   LET li_status = TRUE

   LET l_token = base.StringTokenizer.create(ls_pk, ",")
   
   WHILE l_token.hasMoreTokens()
      LET ls_next = l_token.nextToken()
      IF NOT ls_master.getIndexOf(ls_next,1) THEN
         LET li_status = FALSE
         EXIT WHILE
      END IF
   END WHILE

   RETURN li_status
END FUNCTION


#分析i07 TSD傳入的兩組字樣,挑出都有出現的字段 (pk放前面,畫面欄位放後面)
PRIVATE FUNCTION sadzp188_tab_analyze_pk_i07(ls_list1,ls_list2)

   DEFINE ls_next1   STRING
   DEFINE ls_list1   STRING
   DEFINE ls_list2   STRING
   DEFINE l_token1   base.StringTokenizer
   DEFINE ls_common  STRING

   LET l_token1 = base.StringTokenizer.create(ls_list1, ",")
   
   WHILE l_token1.hasMoreTokens()
      LET ls_next1 = l_token1.nextToken()
      IF ls_list2.getIndexOf(ls_next1,1) THEN
         LET ls_common = ls_common,",",ls_next1
         CONTINUE WHILE
      END IF
   END WHILE

   RETURN ls_common.subString(2,ls_common.getLength())

END FUNCTION


#產生selprep結構
PRIVATE FUNCTION sadzp188_tab_gen_selprep(p_selprep)
   DEFINE p_selprep     om.DomNode
   DEFINE l_select      om.DomNode
   DEFINE l_from        om.DomNode
   DEFINE l_where       om.DomNode
   DEFINE l_order       om.DomNode
   DEFINE l_cnt         LIKE type_t.num10
   DEFINE l_cnt1        LIKE type_t.num10
   DEFINE ls_master_col STRING
   DEFINE ls_detail_col STRING
   DEFINE l_tok         base.StringTokenizer
   DEFINE ls_col        STRING
   DEFINE ls_def_record STRING 
   DEFINE ls_qry_str    STRING 
   DEFINE ls_select_alias STRING 
   DEFINE ls_dtable_str STRING    ##單身join出來的欄位
   DEFINE l_dzgi004_1   LIKE dzgi_t.dzgi004   #140707主表

 
   #建置 selprep -> section id="l_select"  SELECT子句
   LET ls_def_record =""
   #CALL sadzp188_get_field(g_prog_id ,g_sd_ver,'2') RETURNING ls_def_record,ls_dtable_str  #140619 mark
   CALL sadzp188_get_field(g_prog_id ,g_sd_ver,'2',g_code_ide) RETURNING ls_def_record,ls_dtable_str   #140619 add
   
   LET l_select = p_selprep.createChild("sql")
   CALL l_select.setAttribute("id","g_select")
   CALL l_select.setAttribute("query",ls_def_record)

   #CALL sadzp188_get_fromwhere_str(g_prog_id,g_sd_ver,"from",ls_dtable_str) RETURNING ls_qry_str  #140619 mark
   CALL sadzp188_get_fromwhere_str(g_prog_id,g_sd_ver,"from",ls_dtable_str,g_code_ide) RETURNING ls_qry_str   #140619 add
   LET l_where = p_selprep.createChild("sql")
   CALL l_where.setAttribute("id","g_from")
   CALL l_where.setAttribute("query",ls_qry_str)   

   ##140301 -(S)
   #CALL sadzp188_get_fromwhere_str(g_prog_id,g_sd_ver,"where","") RETURNING ls_qry_str  #140619 mark
   CALL sadzp188_get_fromwhere_str(g_prog_id,g_sd_ver,"where","",g_code_ide) RETURNING ls_qry_str  #140619 add
   LET l_where = p_selprep.createChild("sql")
   CALL l_where.setAttribute("id","g_where")
   CALL l_where.setAttribute("query",ls_qry_str)   
   #140707 add主表 -(s)
   ##抓出單頭table
   SELECT dzgi004 INTO l_dzgi004_1 FROM dzgi_t 
    WHERE dzgi001 = g_prog_id AND dzgi002 = g_sd_ver AND dzgi003 = 1 
      AND dzgi006 = g_code_ide #140619 add  
      #DISPLAY "maintable:",l_dzgi004_1
   CALL l_where.setAttribute("maintable",l_dzgi004_1)    
   #140707 add主表 -(s)
   IF g_prog_type ="g01" THEN 
       #CALL sadzp188_get_order_str(g_prog_id,g_sd_ver,"sql") RETURNING ls_qry_str   #140619 mark
       CALL sadzp188_get_order_str(g_prog_id,g_sd_ver,"sql",g_code_ide) RETURNING ls_qry_str    #140619 add
       LET l_where = p_selprep.createChild("sql")
       CALL l_where.setAttribute("id","g_order")
       CALL l_where.setAttribute("query",ls_qry_str)
   END IF    
   ##140301 -(S)
 
END FUNCTION


#PUBLIC FUNCTION sadzp188_get_fromwhere_str(p_prog_id,p_prog_ver,p_type,p_dtable_str)   #140619 mark
PUBLIC FUNCTION sadzp188_get_fromwhere_str(p_prog_id,p_prog_ver,p_type,p_dtable_str,p_code_ide)    #140619 add
   DEFINE p_prog_id     LIKE dzga_t.dzga001
   DEFINE p_prog_ver    LIKE dzga_t.dzga002
   DEFINE p_type        STRING  
   DEFINE p_dtable_str  STRING              ##單身join出來的欄位
   DEFINE p_code_ide    LIKE type_t.chr1    ##140619 add 客製標示
   DEFINE ls_from_str   STRING 
   DEFINE ls_from_tmp   STRING
   DEFINE ls_dzgb       DYNAMIC ARRAY OF RECORD
          dzgb004       LIKE dzgb_t.dzgb004,
          dzgb005       LIKE dzgb_t.dzgb005,  
          dzgb006       LIKE dzgb_t.dzgb006,
          dzgb007       LIKE dzgb_t.dzgb007,   
          dzgb008       LIKE dzgb_t.dzgb008,  
          dzgb009       LIKE dzgb_t.dzgb009,
          dzgb010       LIKE dzgb_t.dzgb010,
          dzgb011       LIKE dzgb_t.dzgb011,
          dzgb012       LIKE dzgb_t.dzgb012,      #判斷是否為foreign key產生
          dzgb016       LIKE dzgb_t.dzgb016        ##160615-00007#1 add
          END RECORD
   DEFINE ls_dzgf       DYNAMIC ARRAY OF RECORD
          dzgf004       LIKE dzgf_t.dzgf004,
          dzgf005       LIKE dzgf_t.dzgf005,  
          dzgf006       LIKE dzgf_t.dzgf006,
          dzgf007       LIKE dzgf_t.dzgf007,   
          dzgf008       LIKE dzgf_t.dzgf008,  
          dzgf009       LIKE dzgf_t.dzgf009,
          dzgf010       LIKE dzgf_t.dzgf010
          END RECORD 
   DEFINE l_i           LIKE type_t.num5
   DEFINE ls_join_tmp   STRING 
   DEFINE ls_join_str   STRING 
   DEFINE ls_dzgb011_str STRING 
   DEFINE ls_table_t    STRING 
   #DEFINE l_foreign_str STRING 
   DEFINE ls_suffix     STRING     #保留字的處理
   DEFINE l_once        INTEGER
   DEFINE l_foreign_str STRING
   DEFINE ls_dzgb005_str STRING  
   DEFINE l_tmp         base.StringBuffer
   DEFINE ls_prefix_str STRING     ##每行join的字首
   DEFINE l_dzgi004     LIKE dzgi_t.dzgi004  ##TABLE名  ##140512add
   DEFINE l_dzgb_d_max  LIKE type_t.num5     #140626 add  join單身筆數
   DEFINE l_master_cnt  LIKE type_t.num5     #140703 add  判斷單頭是否有reference資料
   DEFINE l_dzgi004_1   LIKE dzgi_t.dzgi004  #140703 add  單頭欄位
   DEFINE l_cnt         LIKE type_t.num5     #判斷是沒參考來源
   

   CALL ls_dzgb.clear()
   CALL ls_dzgf.clear()
   
   DECLARE sadzp188_get_from_str_cs CURSOR FOR
   #SELECT dzgb004,dzgb005,dzgb006,dzgb007,dzgb008,dzgb009,dzgb010,dzgb011,dzgb012         ##160615-00007#1 mark 
   SELECT dzgb004,dzgb005,dzgb006,dzgb007,dzgb008,dzgb009,dzgb010,dzgb011,dzgb012,dzgb016  ##160615-00007#1 add 
   FROM dzgb_t 
   #WHERE dzgb001 = g_prog_id AND dzgb002 = g_sd_ver 
   WHERE dzgb001 = p_prog_id AND dzgb002 = p_prog_ver 
     AND dzgb019 = p_code_ide  #140619 add
   ORDER BY dzgb003

   LET l_i = 1
   LET ls_join_tmp =""
   #140703 add 沒單頭就先將單頭加上join_tmp-(s)
   IF p_type = "from" THEN 
       #140626 add -(S) 判斷最後一筆是pk 組出來的(沒有單身的意思)
       LET l_dzgb_d_max = 0
       SELECT COUNT(*) INTO l_dzgb_d_max
       FROM dzgb_t,dzgi_t 
       WHERE dzgb001 = p_prog_id AND dzgb002 = p_prog_ver 
         AND dzgb019 = p_code_ide  
         AND dzgi003 = 2
         AND dzgb005 = dzgi004
         AND dzgb001 = dzgi001 AND dzgb002 = dzgi002 AND  dzgb019 = dzgi006
       ORDER BY dzgb003
       #140626 add -(e) 判斷是否為列後一筆

       #140703 add -(S) 判斷沒有單頭join
       LET l_master_cnt = 0
       SELECT COUNT(*) INTO l_master_cnt
       FROM dzgb_t,dzgi_t 
       WHERE dzgb001 = p_prog_id AND dzgb002 = p_prog_ver 
         AND dzgb019 = p_code_ide  
         AND dzgi003 = 1
         AND dzgb005 = dzgi004
         AND dzgb001 = dzgi001 AND dzgb002 = dzgi002 AND  dzgb019 = dzgi006
       ORDER BY dzgb003
       ##抓出單頭table
       #140710 add-判斷沒有來源程式-(s)
       LET l_cnt = 0 
       SELECT COUNT(dzgb001) INTO l_cnt  FROM dzgb_t
        WHERE dzgb001 = p_prog_id AND dzgb002 = p_prog_ver 
          AND dzgb019 = p_code_ide  #140619 add
       IF l_cnt > 0 THEN  
       #140710 add-判斷沒有來源程式-(e)  
           SELECT dzgi004 INTO l_dzgi004_1 FROM dzgi_t 
            WHERE dzgi001 = p_prog_id AND dzgi002 = p_prog_ver AND dzgi003 = 1 
              AND dzgi006 = p_code_ide #140619 add     
           #140703 add -(e) 判斷沒有單頭join   
           IF l_master_cnt = 0 THEN
              LET ls_join_tmp = " " ,l_dzgi004_1," " 
              LET ls_table_t = l_dzgi004_1
           END IF 
       END IF #140710 add-判斷沒有來源程式
   END IF 
   #140703 add 沒單頭就先將單頭加上join_tmp-(s)
   FOREACH sadzp188_get_from_str_cs INTO ls_dzgb[l_i].*      
      LET ls_dzgb011_str = ls_dzgb[l_i].dzgb011 CLIPPED 
      #left join or right join,或預設的sql裡有join 
      CASE 
         WHEN p_type = "from"

              ##140321 新版-(s)
              ##140318 add g將單頭與單身sql組成一串可執行的sql-(s)  先不改
              ##配置出來
              IF ls_dzgb[l_i].dzgb004 = 'Y' OR ls_dzgb[l_i].dzgb008 = 'Y' THEN 
                ##先不判斷LEFT JOIN前的TABLE是否重覆?  
                 IF cl_null(ls_join_tmp) THEN
                    #LET ls_join_tmp = sadzp188_handle_dzgb011_dlang(sadzp188_combine_join_wc(ls_dzgb[l_i].dzgb004,ls_dzgb[l_i].dzgb005,ls_dzgb[l_i].dzgb006,ls_dzgb[l_i].dzgb007,ls_dzgb[l_i].dzgb008,ls_dzgb[l_i].dzgb009,ls_dzgb[l_i].dzgb010)) ##160615-00007#1 mark
                    LET ls_join_tmp = ls_dzgb[l_i].dzgb005                                            ##160615-00007#1 add
                 #ELSE  
                    #LET ls_join_tmp = ls_join_tmp ,",", sadzp188_handle_dzgb011_dlang(sadzp188_combine_join_wc(ls_dzgb[l_i].dzgb004,ls_dzgb[l_i].dzgb005,ls_dzgb[l_i].dzgb006,ls_dzgb[l_i].dzgb007,ls_dzgb[l_i].dzgb008,ls_dzgb[l_i].dzgb009,ls_dzgb[l_i].dzgb010)) ##160615-00007#1 mark
                    #LET ls_join_tmp = ls_dzgb[l_i].dzgb005      ##160615-00007#1 mark                                       ##160615-00007#1 add
                 END IF
                 #DISPLAY "1 ls_join_tmp:",ls_join_tmp
              ELSE ##非配置出來          
                 IF ls_dzgb011_str.getIndexOf("JOIN",1) > 0 THEN
                    IF cl_null(ls_join_tmp) THEN 
                       #LET ls_join_tmp = sadzp188_handle_dzgb011_dlang( ls_dzgb[l_i].dzgb011) CLIPPED   #160615-00007 mark
                       #160615-00007 add -(s) 
                       IF l_dzgi004_1 = ls_dzgb[l_i].dzgb005 THEN ##單頭連結
                          LET ls_join_tmp = ls_dzgb[l_i].dzgb005            ##不用組連結，因為用subquery移到select
                       ELSE             
                          #LET ls_join_tmp = ls_join_tmp ," ",sadzp188_handle_dzgb011_dlang(sadzp188_get_handle_subquery_sql(ls_dzgb[l_i].dzgb016,ls_dzgb[l_i].dzgb011,"Y")) CLIPPED  #暫時先拿掉 
                          LET ls_join_tmp = ls_dzgb[l_i].dzgb005    #暫時改不用接  
                       END IF 
                       #160615-00007 add -(e)      
                       LET ls_table_t = ls_dzgb[l_i].dzgb005
                       #DISPLAY "2 ls_join_tmp:", ls_join_tmp
                    ELSE 
                       IF ls_dzgb[l_i].dzgb005 = ls_table_t THEN
                          ##若是foreign key組成的，先暫存
                          IF cl_null(ls_dzgb[l_i].dzgb012) THEN 
                             LET l_foreign_str = sadzp188_handle_dzgb011_dlang(ls_dzgb[l_i].dzgb011)                             
                             CONTINUE FOREACH 
                          END IF 
                          #LET ls_join_tmp = ls_join_tmp ," ",sadzp188_handle_dzgb011_dlang(ls_dzgb[l_i].dzgb011) CLIPPED #160615-00007 mark
                          #160615-00007 add -(s) 
                          IF l_dzgi004_1 = ls_dzgb[l_i].dzgb005 THEN ##單頭連結
                             LET ls_join_tmp = ls_dzgb[l_i].dzgb005                    ##不用組連結，因為用subquery移到select
                          ELSE  ##單身連結, f改成subquery後不需要組
                             #LET ls_join_tmp = ls_join_tmp ," ",sadzp188_get_handle_subquery_sql(ls_dzgb[l_i].dzgb016,ls_dzgb[l_i].dzgb011,"Y") CLIPPED  #160615-00007 mark  
                             LET ls_join_tmp = ls_join_tmp    #160615-00007 add
                          END IF 
                          #DISPLAY "3 ls_join_tmp:", ls_join_tmp
                           #160615-00007 add -(e)      
                       ELSE   
                          ##若是foreign key組成的，先暫存
                          IF cl_null(ls_dzgb[l_i].dzgb012) THEN 
                             LET l_foreign_str = ls_dzgb[l_i].dzgb011 
                              #140626 add 只有一行單身join又是foreign key-(S)
                              IF l_dzgb_d_max = 1 THEN 
                                  IF l_once = 0 THEN    ##20140326                            
                                     LET ls_join_tmp = ls_join_tmp, " LEFT OUTER JOIN ( SELECT ",ls_dzgb[l_i].dzgb005,".*"  
                                     LET ls_join_tmp = ls_join_tmp, p_dtable_str ," FROM "
                                     LET ls_prefix_str = ls_dzgb011_str.subString(1,ls_dzgb011_str.getIndexOf(" ",1)-1)
                                     LET ls_prefix_str = ls_prefix_str.trim()
                                     LET ls_dzgb005_str = ls_dzgb[l_i].dzgb005
                                     LET ls_join_tmp = ls_join_tmp ,ls_dzgb[l_i].dzgb005," "
                                     LET l_once = 1 
                                     LET ls_table_t = ls_dzgb[l_i].dzgb005
                                  ELSE                                      
                                     #LET ls_join_tmp = ls_join_tmp ,",",sadzp188_handle_dzgb011_dlang(ls_dzgb[l_i].dzgb011) CLIPPED ##160615-00007#1 mark 
                                     LET ls_table_t = ls_dzgb[l_i].dzgb005                          
                                  END IF                                      
                              END IF
                              #DISPLAY "4 ls_join_tmp:", ls_join_tmp 
                              #140626 add 只有一行單身join-(e)                                                            
                             CONTINUE FOREACH  
                          END IF                           
                          ##單身table與單頭TABLE中間就先補上這串sql  只做一次
                          IF l_once = 0 THEN    ##20140326                            
                             LET ls_join_tmp = ls_join_tmp, " LEFT OUTER JOIN ( SELECT ",ls_dzgb[l_i].dzgb005,".*"  
                             LET ls_join_tmp = ls_join_tmp, ",",p_dtable_str ," FROM "
                             LET ls_prefix_str = ls_dzgb011_str.subString(1,ls_dzgb011_str.getIndexOf(" ",1)-1)
                             LET ls_prefix_str = ls_prefix_str.trim()
                             LET ls_dzgb005_str = ls_dzgb[l_i].dzgb005
                             IF ls_prefix_str.getLength()= 0 THEN 
                                #LET ls_join_tmp = ls_join_tmp ,ls_dzgb[l_i].dzgb005," " ,sadzp188_handle_dzgb011_dlang(ls_dzgb011_str.subString(ls_dzgb011_str.getIndexOf(ls_dzgb[l_i].dzgb005,1)+1,ls_dzgb011_str.getLength())) CLIPPED
                                #LET ls_join_tmp = ls_join_tmp ,ls_dzgb[l_i].dzgb005," " ,sadzp188_handle_dzgb011_dlang(ls_dzgb[l_i].dzgb011) CLIPPED ##160615-00007#1 mark 
                                LET ls_join_tmp = ls_join_tmp ,ls_dzgb[l_i].dzgb005  ##160615-00007#1 add 
                             ELSE 
                                #LET ls_join_tmp = ls_join_tmp ,sadzp188_handle_dzgb011_dlang(ls_dzgb[l_i].dzgb011) CLIPPED ##160615-00007#1 mark
                                LET ls_join_tmp = ls_join_tmp,ls_dzgb[l_i].dzgb005 ##160615-00007#1 add 
                             END IF 
                             LET ls_table_t = ls_dzgb[l_i].dzgb005
                             #DISPLAY "5 ls_join_tmp:", ls_join_tmp
                             LET l_once = 1 
                          ELSE 
                             #LET ls_join_tmp = ls_join_tmp ,",",sadzp188_handle_dzgb011_dlang(ls_dzgb[l_i].dzgb011) CLIPPED  ##160615-00007#1 mark
                             LET ls_join_tmp = ls_join_tmp,ls_dzgb[l_i].dzgb011                                           ##160615-00007#1 add 
                             LET ls_table_t = ls_dzgb[l_i].dzgb005 
                             #DISPLAY "6 ls_join_tmp:", ls_join_tmp                         
                          END IF                    
                       END IF 
                    END IF 
                 END IF   
              END IF   
              ##140318 add g將單頭與單身sql組成一串可執行的sql-(e)  
              ##140321 新版-(e)
              
         WHEN p_type = "where"
              IF ls_dzgb011_str.getIndexOf("JOIN",1)= 0 THEN 
                #先不判斷LEFT JOIN前的TABLE是否重覆?  
                 IF cl_null(ls_join_tmp) THEN 
                    #LET ls_join_tmp = ls_dzgb[l_i].dzgb011                         ##140319 mark
                    LET ls_join_tmp = sadzp188_handle_dzgb011_dlang(ls_dzgb[l_i].dzgb011) ##140319 g_enterprise與g_dlang需另外處理
                 ELSE 
                    #LET ls_join_tmp = ls_join_tmp ," AND ",ls_dzgb[l_i].dzgb011    ##140319 mark
                    
                    LET ls_join_tmp =  ls_join_tmp ," AND ",sadzp188_handle_dzgb011_dlang(ls_dzgb[l_i].dzgb011) ##140319 g_enterprise與g_dlang需另外處理
                 END IF    
              END IF            
      END CASE 
   END FOREACH
   IF p_type = "from" THEN

      IF NOT cl_null(l_foreign_str) THEN
         LET l_foreign_str = l_foreign_str.subString(l_foreign_str.getIndexOf("ON",1) -1 ,l_foreign_str.getLength())
         ##把on的句子，單身table置換為x
         LET l_tmp = base.StringBuffer.create()
         CALL l_tmp.clear()
         CALL l_tmp.append(l_foreign_str)
         CALL l_tmp.replace(ls_table_t,"x",0)
         LET l_foreign_str = l_tmp.toString()      
      END IF 
      IF l_once = 1 THEN 
         LET ls_join_tmp = ls_join_tmp ," ) x " ,l_foreign_str
      END IF
      
      ##140512 XG 沒有join條件時，就將table加上  -(s)
      IF cl_null(ls_join_tmp) THEN 
         LET l_i = 1
         DECLARE sadzp188_get_dzgi004_cs CURSOR FOR 
                SELECT dzgi004 FROM dzgi_t WHERE dzgi001 = p_prog_id AND dzgi002 = p_prog_ver
                   AND dzgi006 = p_code_ide #140619 add
         FOREACH sadzp188_get_dzgi004_cs INTO l_dzgi004
            IF l_i = 1 THEN
               LET ls_join_tmp = l_dzgi004 
            ELSE 
               LET ls_join_tmp = ls_join_tmp,",",l_dzgi004 
            END IF 
            LET l_i = l_i + 1
         END FOREACH          
      END IF 
      ##140512 XG 沒有join條件時，就將table加上  -(s)
   END IF 
   IF p_type = "where" THEN  
       #抓dzgf_t
       DECLARE sadzp188_get_where_str_cs CURSOR FOR 
       SELECT dzgf004,dzgf005,dzgf006,dzgf007,dzgf008,dzgf009,dzgf010
       FROM dzgf_t 
       WHERE dzgf001 = p_prog_id AND dzgf002 = g_sd_ver 
         AND dzgf012 = p_code_ide #140619 add
       ORDER BY dzgf003
       FOREACH sadzp188_get_where_str_cs INTO ls_dzgf[l_i].*  
           IF cl_null(ls_join_tmp) THEN 
              LET ls_join_tmp = sadzp188_combine_filter_wc(ls_dzgf[l_i].dzgf004,ls_dzgf[l_i].dzgf005,ls_dzgf[l_i].dzgf006,ls_dzgf[l_i].dzgf007,ls_dzgf[l_i].dzgf008,ls_dzgf[l_i].dzgf009,ls_dzgf[l_i].dzgf010)
           ELSE               
              ##不用加上and 、or，因為dzgf010會存是否有連結的and/or
              LET ls_join_tmp = ls_join_tmp ," ",sadzp188_combine_filter_wc(ls_dzgf[l_i].dzgf004,ls_dzgf[l_i].dzgf005,ls_dzgf[l_i].dzgf006,ls_dzgf[l_i].dzgf007,ls_dzgf[l_i].dzgf008,ls_dzgf[l_i].dzgf009,ls_dzgf[l_i].dzgf010)
           END IF 

       END FOREACH  
      ##多增加and

      #DISPLAY "ls_join_tmp:", ls_join_tmp
      IF NOT cl_null(ls_join_tmp) THEN  #空值不用加AND         
         LET ls_join_tmp = ls_join_tmp ," AND " 
      END IF  
   END IF 
   
   RETURN ls_join_tmp
   
END FUNCTION 


##140301 -(S)
PUBLIC FUNCTION sadzp188_get_order_str(p_prog_id,p_prog_ver,p_type,p_code_ide)  #140619 add
#PUBLIC FUNCTION sadzp188_get_order_str(p_prog_id,p_prog_ver,p_type)            #140619 mark
   DEFINE p_prog_id     STRING 
   DEFINE p_prog_ver    STRING
   DEFINE p_type        STRING 
   DEFINE p_code_ide    LIKE type_t.chr1   #140619 add
   DEFINE l_order_str   STRING
   DEFINE lc_dzge006    LIKE dzge_t.dzge006 
   DEFINE li            LIKE type_t.num5

   LET li = 1
   LET l_order_str = ''
   LET g_sql = " SELECT dzge006 FROM dzge_t ",
               " WHERE dzge001 ='",p_prog_id,"'"," AND dzge002 ='",p_prog_ver,"'",
               "   AND dzge009 ='",p_code_ide,"'"   #140619 add
   CASE p_type
      WHEN "sql"  #組sql
          LET g_sql = g_sql , " AND dzge003 ='1'"
      WHEN "rep"  #組rep
          LET g_sql = g_sql , " AND dzge003 ='2'"
   END CASE    
   LET g_sql = g_sql," ORDER BY dzge004 "
   PREPARE sadzp188_getorder_pre FROM g_sql
   DECLARE sadzp188_getorder_cs CURSOR FOR sadzp188_getorder_pre
   FOREACH sadzp188_getorder_cs INTO lc_dzge006
      IF li = 1 THEN
         LET l_order_str = lc_dzge006 
      ELSE 
         LET l_order_str = l_order_str ,",",lc_dzge006
      END IF 
      LET li = li +1
   END FOREACH 

   RETURN l_order_str
END FUNCTION 
#140301 -(E)
   

PRIVATE FUNCTION sadzp188_combine_filter_wc(p_dzgb004, p_dzgb005, p_dzgb006, p_dzgb007, p_dzgb008, p_dzgb009, p_dzgb010)
   DEFINE p_dzgb004, p_dzgb005, p_dzgb006, p_dzgb007, p_dzgb008, p_dzgb009, p_dzgb010   STRING
   DEFINE ls_str   STRING
   DEFINE ls_wc    STRING
    

   
   IF p_dzgb004 IS NOT NULL THEN
      #LET ls_wc = p_dzgb004 ," "  #141002 mark
      ##141002 add -(s)
      DISPLAY "測試  p_dzgb004:",p_dzgb004
      CASE p_dzgb004
        WHEN '1'
           LET ls_wc = "( "
        WHEN '2'
           LET ls_wc = "(( "    
        WHEN '3'
           LET ls_wc = "((( "    
        WHEN '4'
           LET ls_wc = "(((( "    
        WHEN '5'
           LET ls_wc = "((((( "    
        OTHERWISE
           LET ls_wc = " "
      END CASE
      ##141002 add -(e) 
   END  IF
   LET ls_wc = ls_wc, p_dzgb005,".",p_dzgb006
   CASE p_dzgb007
      WHEN "01" LET ls_wc = ls_wc, " ="
      WHEN "02" LET ls_wc = ls_wc, " <>"
      WHEN "03" LET ls_wc = ls_wc, " >"
      WHEN "04" LET ls_wc = ls_wc, " <"
      WHEN "05" LET ls_wc = ls_wc, " >="
      WHEN "06" LET ls_wc = ls_wc, " <="
      WHEN "07" LET ls_wc = ls_wc, " BETWEEN"
      WHEN "08" LET ls_wc = ls_wc, " NOT BETWEEN"
      WHEN "09" LET ls_wc = ls_wc, " LIKE"
      WHEN "10" LET ls_wc = ls_wc, " NOT LIKE"
      WHEN "11" LET ls_wc = ls_wc, " IN"
      WHEN "12" LET ls_wc = ls_wc, " NOT IN"
      WHEN "13" LET ls_wc = ls_wc, " IS NULL"
      WHEN "14" LET ls_wc = ls_wc, " IS NOT NULL"
   END CASE
   CASE
      WHEN  p_dzgb007 = "11" OR p_dzgb007 = "12"
         LET ls_wc = ls_wc, " (", p_dzgb008 ,")"
      WHEN p_dzgb007 = "13" OR p_dzgb007 = "14"
      WHEN p_dzgb007 = "07" OR p_dzgb007 = "08"
         LET ls_wc = ls_wc, " ", p_dzgb008 
      OTHERWISE
         #判斷欄位型態
         #131219未寫完-(S)  #140217
         #CALL adzp188_decide_field_type(ps_dzgf006) RETURNING ls_con_str
         #LET ls_wc = ls_wc, " ",ls_con_str, ps_dzgf008,ls_con_str
         #131219未寫完-(S)
         IF p_dzgb008 = "g_enterprise" THEN
           LET ls_wc = ls_wc, " '\" ,", p_dzgb008,",\"'\" ,\""  
         ELSE 
           LET ls_wc = ls_wc, " '", p_dzgb008,"'"
         END IF 
   END CASE
   IF p_dzgb009 IS NOT NULL THEN
      #LET ls_wc = ls_wc, " ", p_dzgb009  #141002 mark
      ##141002 add -(s)
      CASE p_dzgb009
        WHEN '1'
           LET ls_wc = ls_wc," )"
        WHEN '2'
           LET ls_wc = ls_wc," ))"    
        WHEN '3'
           LET ls_wc = ls_wc," )))"    
        WHEN '4'
           LET ls_wc = ls_wc," ))))"    
        WHEN '5'
           LET ls_wc = ls_wc," )))))"    
        OTHERWISE
           LET ls_wc = ls_wc," "
      END CASE
      ##141002 add -(e) 

      
   END IF
   CASE p_dzgb010
      WHEN "1" LET ls_wc = ls_wc, " AND"
      WHEN "2" LET ls_wc = ls_wc, " OR"

   END CASE
   LET ls_str = ls_wc
   RETURN ls_str

END FUNCTION

PRIVATE FUNCTION sadzp188_combine_join_wc(p_dzgb004, p_dzgb005, p_dzgb006, p_dzgb007, p_dzgb008, p_dzgb009, p_dzgb010)
   DEFINE p_dzgb004, p_dzgb005, p_dzgb006, p_dzgb007, p_dzgb008, p_dzgb009, p_dzgb010   STRING
   DEFINE ls_str   STRING

   
   IF p_dzgb004 = "Y" THEN
      LET ls_str = p_dzgb005, " RIGHT OUTER JOIN ", p_dzgb009, " ON "
   END IF   
   IF p_dzgb008 = "Y" THEN
      LET ls_str = p_dzgb005, " LEFT OUTER JOIN ", p_dzgb009, " ON "
   END IF
   LET ls_str = ls_str, p_dzgb005, ".", p_dzgb006
   CASE p_dzgb007
      WHEN "01" LET ls_str = ls_str, " = ", p_dzgb009, ".", p_dzgb010
      WHEN "02" LET ls_str = ls_str, " <> ", p_dzgb009, ".", p_dzgb010
      WHEN "03" LET ls_str = ls_str, " > ", p_dzgb009, ".", p_dzgb010
      WHEN "04" LET ls_str = ls_str, " < ", p_dzgb009, ".", p_dzgb010
      WHEN "05" LET ls_str = ls_str, " >= ", p_dzgb009, ".", p_dzgb010
      WHEN "06" LET ls_str = ls_str, " <= ", p_dzgb009, ".", p_dzgb010
      WHEN "07" LET ls_str = ls_str, " BETWEEN '",p_dzgb008,"'"
      WHEN "08" LET ls_str = ls_str, " NOT BETWEEN '",p_dzgb008,"'"
      WHEN "09" LET ls_str = ls_str, " LIKE '",p_dzgb008,"'"
      WHEN "10" LET ls_str = ls_str, " NOT LIKE '",p_dzgb008,"'"
      WHEN "11" LET ls_str = ls_str, " IN '",p_dzgb008,"'"
      WHEN "12" LET ls_str = ls_str, " NOT IN '",p_dzgb008,"'"
      WHEN "13" LET ls_str = ls_str, " IS NULL "
      WHEN "14" LET ls_str = ls_str, " IS NOT NULL "
   END CASE

   RETURN ls_str

END FUNCTION




#檢查現在所在欄位,是否有存在reference column在此區塊中
PRIVATE FUNCTION sadzp188_tab_check_reference(ls_columnid)
   DEFINE ls_columnid  STRING

   LET ls_columnid = ls_columnid.trim(),"_desc"  #規範就是fflabel要設定成前方欄位的id+"_desc"

   RETURN g_reference_col_set.getIndexOf(ls_columnid,1)
END FUNCTION


#140301 -(s)

#產生 tab 檔內的 mainrep結構
PRIVATE FUNCTION sadzp188_tab_gen_mainrep(p_mainrep)
   DEFINE p_mainrep      om.DomNode
   DEFINE l_section      om.DomNode
   DEFINE ls_main_str    STRING
   DEFINE l_dzge005      LIKE dzge_t.dzge005


   #建置 id="repOrder"
   LET l_section = p_mainrep.createChild("section")
   CALL l_section.setAttribute("id","repOrder")
   ##抓取是否為EXTERNAL
   SELECT dzge005 INTO l_dzge005 FROM dzge_t 
    WHERE dzge001 = g_prog_id AND dzge002 = g_sd_ver AND dzge003 ='2' AND dzge004 = 1
      AND dzge009 = g_code_ide  #140619 add
   IF l_dzge005 = "1" THEN 
      CALL l_section.setAttribute("type","EXTERNAL")
   END IF 
   LET ls_main_str ="" 
   #CALL sadzp188_get_order_str(g_prog_id ,g_sd_ver,'rep') RETURNING ls_main_str   #140619 mark 
   CALL sadzp188_get_order_str(g_prog_id ,g_sd_ver,'rep',g_code_ide) RETURNING ls_main_str  #140619 add
   CALL l_section.setAttribute("name",ls_main_str)


   #建置 id="b_group"
   ##若有群組資料就需建置b_group與a_group
   IF NOT cl_null(ls_main_str) THEN 
      ##b_group
      CALL sadzp188_tab_gen_mainrep_slice(ls_main_str,"b_group",p_mainrep)
      ## oneveryrow
      CALL sadzp188_tab_gen_mainrep_slice(ls_main_str,"everyrow",p_mainrep)
      ##a_group
      CALL sadzp188_tab_gen_mainrep_slice(ls_main_str,"a_group",p_mainrep)  
   END IF 
   
   
END FUNCTION
#140301-(e)

##140303 -(S)
FUNCTION sadzp188_tab_gen_mainrep_slice(ps_main_str,ps_type,ps_mainrep)
   DEFINE ps_main_str       STRING   ##群組字串
   DEFINE ps_type           STRING   ##rep段區塊類別
   DEFINE ps_mainrep        om.DomNode  #
   DEFINE l_section         om.DomNode
   DEFINE l_token1          base.StringTokenizer
   DEFINE ls_next1          STRING 
   DEFINE l_section_type    om.DomNode
   DEFINE l_cnt             LIKE type_t.num5
   DEFINE ls_subseq         STRING 
   DEFINE l_token1_cnt      LIKE type_t.num5
   DEFINE l_table_name      LIKE gztz_t.gztz001
   DEFINE l_where_str       STRING 
   DEFINE l_gztz002         LIKE gztz_t.gztz002
   
  
      LET l_section = ps_mainrep.createChild("section")
      CALL l_section.setAttribute("id",ps_type)
      IF ps_type ="b_group" OR ps_type ="a_group" THEN 
         ##group版型
          CALL l_section.setAttribute("reptype","d01")
          LET l_cnt = 1 
          ##處理每個GROUP裡

          LET l_token1 = base.StringTokenizer.create(ps_main_str, ",")
          LET l_token1_cnt = l_token1.countTokens()
          WHILE l_token1.hasMoreTokens()
             LET ls_next1 = l_token1.nextToken()
              ##group版型
              ##EX:<rep type="itea002"/> 
             LET l_section_type = l_section.createChild("rep")
             CALL l_section_type.setAttribute("type",ls_next1)
             ##備註子報表只有主鍵有，只做一次
             IF g_dzgg007 ="Y" AND l_cnt =1 THEN 
                LET ls_subseq = g_subseq USING "&&" ##00格式
                CALL l_section_type.setAttribute("subtype","d03")
                CALL l_section_type.setAttribute("sub_seq",ls_subseq)
                CALL l_section_type.setAttribute("recordseq","2")
                ##140324 -(s)
                IF ps_type ="b_group" THEN  #單據單頭備註(列印在前)
                   #CALL l_section_type.setAttribute("sub_query"," SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ")                #170113-00040#1 mark
                   CALL l_section_type.setAttribute("sub_query"," SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ")   #170113-00040#1 add
                ELSE #單據單頭備註(列印在後)
                   #CALL l_section_type.setAttribute("sub_query"," SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ")                #170113-00040#1 mark
                   CALL l_section_type.setAttribute("sub_query"," SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ")   #170113-00040#1 add
                END IF 
                #CALL l_section_type.setAttribute("pk","ooffent,ooff002")  #140314要抓第一key值     #170113-00040#1 mark
                CALL l_section_type.setAttribute("pk","ooffent,ooff003")  #    #170113-00040#1 add 改成ooff003
                LET l_gztz002 = ls_next1
                SELECT gztz001 INTO l_table_name FROM gztz_t 
                 WHERE gztz002 = l_gztz002  AND gztz001 LIKE '%_t'  
                 #140715 add -(s)  
                 IF cl_null(l_table_name) THEN
                   ##抓出單頭table
                   SELECT dzgi004 INTO l_table_name FROM dzgi_t 
                    WHERE dzgi001 = g_prog_id AND dzgi002 = g_sd_ver AND dzgi003 = 1 
                      AND dzgi006 = g_code_ide #140619 add    
                 END IF
                #140715 add -(e)                  
                LET l_where_str = l_table_name  
                LET l_where_str = l_where_str.subString(1,l_where_str.getIndexOf("_",1)-1),"ent"
                LET l_where_str = l_where_str,",",ls_next1
                ##140324 -(s)
                CALL l_section_type.setAttribute("where",l_where_str)
                LET l_cnt = l_cnt + 1
                LET g_subseq = g_subseq + 1
             END IF              
          END WHILE
      ELSE 
         ##oneveryrow
               ##<rep type="before"
               
              LET l_token1 = base.StringTokenizer.create(ps_main_str, ",")
              LET l_token1_cnt = l_token1.countTokens()
              LET l_section_type = l_section.createChild("rep")
              CALL l_section_type.setAttribute("type","before")
              LET ls_next1 = l_token1.nextToken()
              ##備註子報表只有主鍵加項次
              IF g_dzgg007 ="Y" THEN 
               
                 LET ls_subseq = g_subseq USING "&&" ##00格式
                 CALL l_section_type.setAttribute("subtype","d03")
                 CALL l_section_type.setAttribute("sub_seq",ls_subseq)
                 CALL l_section_type.setAttribute("recordseq","2")
                 CALL l_section_type.setAttribute("sub_query"," SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ")
                 #CALL l_section_type.setAttribute("pk",ps_main_str) #140314要抓第一、二key值 
                 ##ORDER有2個存2個pk
                 IF l_token1_cnt = 2 THEN 
                    #CALL l_section_type.setAttribute("pk","ooffent,ooff002,ooff003")  #140314要抓第一、二key值   #170113-00040#1 mark
                    CALL l_section_type.setAttribute("pk","ooffent,ooff003,ooff004")  #140314要抓第一、二key值    #170113-00040#1 add
                 ELSE 
                    #CALL l_section_type.setAttribute("pk","ooffent,ooff002")   #170113-00040#1 mark
                    CALL l_section_type.setAttribute("pk","ooffent,ooff003")    #170113-00040#1 add
                 END IF  
                 LET l_gztz002 = ls_next1
                 SELECT gztz001 INTO l_table_name FROM gztz_t 
                  WHERE gztz002 = l_gztz002  AND gztz001 LIKE '%_t'  
                 #140715 add -(s)  
                 IF cl_null(l_table_name) THEN
                   ##抓出單頭table
                   SELECT dzgi004 INTO l_table_name FROM dzgi_t 
                    WHERE dzgi001 = g_prog_id AND dzgi002 = g_sd_ver AND dzgi003 = 1 
                      AND dzgi006 = g_code_ide #140619 add    
                 END IF
                #140715 add -(e) 
                 LET l_where_str = l_table_name  
                 LET l_where_str = l_where_str.subString(1,l_where_str.getIndexOf("_",1)-1),"ent"
                 LET l_where_str = l_where_str,",",ps_main_str            
                 CALL l_section_type.setAttribute("where",l_where_str)
                 LET l_cnt = l_cnt + 1
                 LET g_subseq = g_subseq + 1
              END IF              
               ##<rep type="after"
              LET l_section_type = l_section.createChild("rep")
              CALL l_section_type.setAttribute("type","after")
              ##備註子報表只有主鍵加項次
              IF g_dzgg007 ="Y" THEN 
                 LET ls_subseq = g_subseq USING "&&" ##00格式
                 CALL l_section_type.setAttribute("subtype","d03")
                 CALL l_section_type.setAttribute("sub_seq",ls_subseq)
                 CALL l_section_type.setAttribute("recordseq","2")
                 CALL l_section_type.setAttribute("sub_query"," SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ")
                 #CALL l_section_type.setAttribute("pk",ps_main_str) #140314要抓第一、二key值 
                 ##ORDER有2個存2個pk
                 IF l_token1_cnt = 2 THEN 
                    #CALL l_section_type.setAttribute("pk","ooffent,ooff002,ooff003")  #140314要抓第一、二key值  #170113-00040#1 mark
                    CALL l_section_type.setAttribute("pk","ooffent,ooff003,ooff004")  #140314要抓第一、二key值   #170113-00040#1 add
                 ELSE 
                    #CALL l_section_type.setAttribute("pk","ooff002")      #170113-00040#1 mark
                    CALL l_section_type.setAttribute("pk","ooff003")       #170113-00040#1 add
                 END IF 
                 CALL l_section_type.setAttribute("where",l_where_str)
                 LET l_cnt = l_cnt + 1
                 LET g_subseq = g_subseq + 1
              END IF      
      END IF 
END FUNCTION 
##140303 -(E)


#產生 tab 檔內的 mainrep結構
PRIVATE FUNCTION sadzp188_tab_gen_subrep(ps_mainrep)
   DEFINE ps_mainrep    om.DomNode
   DEFINE l_subrep      om.DomNode
   DEFINE i             LIKE type_t.num5
   DEFINE li_str        STRING 
   DEFINE l_subrep_cnt  LIKE type_t.num5

   LET l_subrep_cnt  = g_subseq - 1
   FOR i = 1 TO l_subrep_cnt
       LET l_subrep = ps_mainrep.createChild("subreptag")
       LET li_str = i USING "&&"
       CALL l_subrep.setAttribute("id",li_str)
       CALL l_subrep.setAttribute("recordseq","2")
   END FOR 
END FUNCTION 


#濾除資料多語言的輸入欄位 (只留下單頭table相關欄位,其餘都變成 '' )
PRIVATE FUNCTION sadzp188_tab_master_fixdlang_col(ls_cols,ls_tableid)

   DEFINE ls_cols    STRING
   DEFINE ls_tableid STRING
   DEFINE l_token1       base.StringTokenizer
   DEFINE ls_next1       STRING

   #取tableid的字首
   LET ls_tableid = ls_tableid.subString(1,ls_tableid.getIndexOf("_t",1)-1)
   #確認傳入的欄位清單,個別在TSD內是否已經有設定參考欄位資料
   LET l_token1 = base.StringTokenizer.create(ls_cols, ",")
   LET ls_cols = ""   
   WHILE l_token1.hasMoreTokens()
      LET ls_next1 = l_token1.nextToken()
      IF ls_next1.getIndexOf(ls_tableid,1) THEN
         LET ls_cols = ls_cols,ls_next1,","
      ELSE
         LET ls_cols = ls_cols,"'',"
      END IF
   END WHILE
   RETURN ls_cols

END FUNCTION







PRIVATE FUNCTION sadzp188_tab_master_not_main_fix(ls_cols)
   DEFINE ls_cols    STRING
   DEFINE ls_token   STRING
   DEFINE ls_return  STRING
   DEFINE tok        base.StringTokenizer

   IF ls_cols.getLength() < 1 THEN
      RETURN ""
   END IF
   LET tok = base.StringTokenizer.create(ls_cols,",")
   WHILE tok.hasMoreTokens()
      LET ls_token = tok.nextToken()
      LET ls_token = ls_token.trim()
      IF ls_token = "''" OR ls_token = '""' THEN
      ELSE
         LET ls_return = ls_return,ls_token,","
      END IF
   END WHILE
   RETURN ls_return.subString(1,ls_return.getLength()-1) 
END FUNCTION

#比對傳進來的reference欄位,是否已經寫入全域陣列,若沒有則補入,已有則離開
PUBLIC FUNCTION sadzp188_tab_gen_reference_array(ls_colid)
   DEFINE ls_colid  STRING

   IF NOT g_reference_col_set.getIndexOf(ls_colid,1) THEN
      LET g_reference_col_set = g_reference_col_set,ls_colid,","
   END IF

END FUNCTION



#濾除 = 號不等於傳入 table 欄位的那一個部分,留下等於 target_table 的欄位名稱回傳
FUNCTION sadzp188_tab_clearfyfk(ls_fkstr,ls_target_table)

   DEFINE ls_fkstr        STRING
   DEFINE ls_target_table STRING
   DEFINE ls_purefk       STRING
   DEFINE ls_next         STRING
   DEFINE l_line          base.StringTokenizer

   LET l_line = base.StringTokenizer.create(ls_fkstr, "=")

   WHILE l_line.hasMoreTokens()
      LET ls_next = l_line.nextToken()
      #暫時先假設 table id 是 4 碼，還沒考慮 行業別表/客製表
      IF ls_next.getIndexOf(ls_target_table.subString(1,4),1) THEN
         LET ls_purefk = ls_purefk,",",ls_next
      END IF
   END WHILE
   
   RETURN ls_purefk.subString(2,ls_purefk.getLength())
END FUNCTION

#140104 先不用-(s)

#PRIVATE FUNCTION sadzp188_tab_get_relation(ps_tableid,ps_type,ps_uptable)
#
   #DEFINE ps_tableid  STRING    #要取的主要關注表編號(PK,FK)
   #DEFINE ps_type     STRING    #型態 PK OR FK
   #DEFINE ps_uptable  STRING    #FK關注的上階表
   #DEFINE ls_str      STRING
   #DEFINE ls_sql      STRING
   #DEFINE lc_dzed004  LIKE dzed_t.dzed004   #FK欄位
   #DEFINE lc_dzed006  LIKE dzed_t.dzed006   #對應主表的PK欄位
   #DEFINE ls_site     STRING
   #DEFINE ls_next     STRING
   #DEFINE l_line      base.StringTokenizer
#
   #LET ls_str = NULL
   #CASE
      ##取得各資料表的PK
      #WHEN ps_type = "pk"
#
         #LET lc_dzed004 = sadzp188_tab_relation_pk(ps_tableid)
#
         #LET l_line = base.StringTokenizer.create(lc_dzed004,",")
         #WHILE l_line.hasMoreTokens()
            #LET ls_next = l_line.nextToken()
            #如果主表有 site 欄位存在,就刪除 
            #IF NOT g_table_main_pk.getIndexOf(g_table_main.trim()||"site",3) THEN
               #LET ls_site = g_table_main.trim(),"site"
               #IF ls_site = ls_next THEN
                  #CONTINUE WHILE
               #END IF
            #END IF
            #LET ls_str = ls_str, ls_next.trim(),","
         #END WHILE
         #LET ls_str = ls_str.subString(1,ls_str.getLength()-1)
#
      #取得各資料表的FK
      #WHEN ps_type = "fk"
         #借用ls_next變數來擷取tableid去除_t的部分
         #LET ls_next = ps_tableid 
         #LET ls_next = ls_next.subString(1,ls_next.getIndexOf("_t",1)-1)
#
         #LET ls_sql = "SELECT dzed004,dzed006 FROM dzed_t",
                      #" WHERE dzed001='",ps_tableid CLIPPED,"' ",
                        #" AND dzed002='",ls_next.trim(),"_fk' ",  #只抓取名稱為 _fk 的部分
                        #" AND dzed003='F' ",          #型式為 F
                        #" AND dzed005='",ps_uptable CLIPPED,"'"
         #PREPARE dzed_prep FROM ls_sql
         #EXECUTE dzed_prep INTO lc_dzed004,lc_dzed006
         #FREE dzed_prep
#
         ##把對應建置起來之後,在依照主表(p_uptable)的PK順序重新排序
      #
         #LET ls_str = lc_dzed004 CLIPPED 
   #END CASE
   #RETURN ls_str
#
#END FUNCTION

#140104 先不用-(s)

#PRIVATE FUNCTION sadzp188_tab_page_tab(lc_dzfs004)
#
   #DEFINE ls_str      STRING
   #DEFINE ls_sql      STRING
   #DEFINE ls_dzfs003  STRING
   #DEFINE lc_dzfs003  LIKE dzfs_t.dzfs003
   #DEFINE lc_dzfs004  LIKE dzfs_t.dzfs004
   #DEFINE li_cnt      LIKE type_t.num5
#
   #LET ls_str = ""
#
   #FOR li_cnt = 1 TO g_detail_id.getLength()
      #IF g_detail_id[li_cnt].detail_tab = lc_dzfs004 THEN
         #LET ls_str = ls_str, g_detail_id[li_cnt].detail_sn USING "<<<<<" ,","
      #END IF
   #END FOR
#
   #RETURN ls_str.subString(1,ls_str.getLength()-1)
#
#END FUNCTION


PRIVATE FUNCTION sadzp188_tab_chk_site(lc_dzeb001)

   DEFINE li_ent     LIKE type_t.num5
   DEFINE lc_dzeb001 LIKE dzeb_t.dzeb001
   DEFINE ls_temp    STRING

   #如果傳進來的table id(lc_dzeb001)是 g_table_main
   IF g_table_main = lc_dzeb001 AND lc_dzeb001 IS NOT NULL THEN
      #且 g_table_main_pk 也出現site
      LET ls_temp = g_table_main.subString(1,g_table_main.getIndexOf("_t",1)-1),"site"
      IF g_table_main_pk.getIndexOf(ls_temp,1) THEN
         #表示這個欄位有出現在畫面上,就不加上了
         RETURN FALSE
      END IF
   END IF

   #確認table內是否已經有 site
   SELECT count(*) INTO li_ent FROM dzeb_t
    WHERE dzeb001 = lc_dzeb001 AND dzeb002 LIKE "%site" AND dzeb004="Y"

   RETURN li_ent

END FUNCTION


PRIVATE FUNCTION sadzp188_tab_chk_ent(lc_dzeb001)

   DEFINE li_ent     LIKE type_t.num5
   DEFINE lc_dzeb001 LIKE dzeb_t.dzeb001

   SELECT count(*) INTO li_ent FROM dzeb_t
    WHERE dzeb001 = lc_dzeb001 AND dzeb002 LIKE "%ent" AND dzeb004="Y"

   RETURN li_ent

END FUNCTION


#+當i04樣板 有type要比對FK 濾除掉跟type 同一個欄位
PRIVATE FUNCTION sadzp188_tab_gen_chk_type(ps_field)
   DEFINE ps_field STRING 
   IF g_dzff.type = ps_field THEN 
      RETURN TRUE
   ELSE 
      RETURN FALSE 
   END IF 
END FUNCTION 


#+ 檢查傳入的欄位清單中是否含有 XXXsite,若有則回傳TRUE/無則回傳FALSE
PRIVATE FUNCTION s_adzp030_tab_chk_site_4fd(ls_fields)
   DEFINE ls_fields   STRING
   DEFINE ls_colid    STRING
   DEFINE li_return   LIKE type_t.num5

   #決定site欄位名稱
   LET ls_colid = g_table_main.subString(1,g_table_main.getIndexOf("_t",1)-1),"site"

   IF ls_fields.getIndexOf(ls_colid,1) THEN
      LET li_return = TRUE
   ELSE
      LET li_return = FALSE
   END IF
   RETURN li_return
END FUNCTION

#+ 找出reference的欄位名稱 
PRIVATE FUNCTION sadzp188_tab_get_reference_col(ls_columnid,ls_set)

   DEFINE ls_columnid  STRING
   DEFINE ls_set       STRING
   DEFINE ls_refid     STRING

   LET ls_refid = ls_columnid,"_desc"

   RETURN ls_refid
END FUNCTION

############################################################
#+ @code
#+ 函式目的 回傳指定的action(dzad002) 清單
#+          若傳入 "db" 則抓取所有 "db_" 開頭的 action id 回傳,注意dzad005可能同時出現YN
#+          若傳入空值，則抓取第一碼非 'm|d' 且第四碼非 '_' 的 action id 回傳
#+ @param   pc_type    char(20) 回傳型態
#+ @return  STRING     action清單
############################################################
PUBLIC FUNCTION sadzp188_tab_action(pc_type)

   DEFINE pc_type    LIKE type_t.chr20
   DEFINE ls_sql     STRING
   DEFINE l_dzad001  LIKE dzad_t.dzad001
   DEFINE l_dzad002  LIKE dzad_t.dzad002
   DEFINE l_dzad003  LIKE dzad_t.dzad003
   DEFINE ls_str     STRING

   DEFINE ls_sd_ver  STRING         #140923 elena add

   LET ls_sd_ver = g_sd_ver CLIPPED #140923 elena add
   LET ls_sd_ver = ls_sd_ver.trim() #140923 elena add
   #如果是 "db" 表示為主 menu, 附加基本功能項目
   IF pc_type = "db" THEN
      LET ls_sql = "SELECT UNIQUE dzad001,dzad002,dzad003 ",
                    " FROM dzaa_t,dzad_t,dzah_t ",
                 #---------------------------dzaa--------------#
                   " WHERE dzaa001 = '",g_prog_id CLIPPED,"'",
                     " AND dzaa002 = '",ls_sd_ver CLIPPED,"'", #140923 elena add
                     #" AND dzaa002 = '",g_sd_ver CLIPPED,"'", #140923 elena mark
                     " AND dzaa005 = '2'",
                     " AND dzaastus = 'Y'",
                 #---------------------------dzad--------------#
                     " AND dzad001 = dzaa001 ",      #規格編號
                     " AND dzad002 = dzaa003 ",      #Action識別碼
                     " AND dzad005 = dzaa006 ",      #使用標示
                     " AND dzad003 = dzaa004 ",      #識別碼版次
                     " AND (dzad006 = 'all' ",       #觸發時機
                       " OR dzad006 LIKE 'all,%' ",     #觸發時機
                       " OR dzad006 LIKE '%,all' ",     #觸發時機
                       " OR dzad006 LIKE '%,all,%') ",  #觸發時機
                     " AND dzadstus = 'Y' "          #有效碼
                 #---------------------------dzah--------------#
                 #   " AND dzah001 = dzad001 ",      #規格編號
                 #   " AND dzah002 = dzad002 ",      #Action識別碼
                 #   " AND dzah003 = dzad003 ",      #識別碼版次
                 #   " AND dzah004 = dzad005 ",      #使用標示
                 #   " AND dzah005 = 'all' ",        #觸發時機
                 #   " AND dzahstus = 'Y' "          #有效碼
   ELSE
      #細項先決定,再組合出主表 (因為開始要動 pc_type)
      LET pc_type = pc_type CLIPPED
      LET ls_sql = "SELECT UNIQUE dzad001,dzad002,dzad003 ",
                    " FROM dzaa_t,dzad_t,dzah_t ",
                 #---------------------------dzaa--------------#
                   " WHERE dzaa001 = '",g_prog_id CLIPPED,"'",
                     " AND dzaa002 = '",g_sd_ver CLIPPED,"'",
                     " AND dzaa005 = '2'",
                     " AND dzaastus = 'Y'",
                 #---------------------------dzad--------------#
                     " AND dzad001 = dzaa001 ",      #規格編號
                     " AND dzad002 = dzaa003 ",      #Action識別碼
                     " AND dzad005 = dzaa006 ",      #使用標示
                     " AND dzad003 = dzaa004 ",      #識別碼版次
                     " AND (dzad006 = '",pc_type CLIPPED,"' ",       #觸發時機
                       " OR dzad006 LIKE '",pc_type CLIPPED,",%' ",     #觸發時機
                       " OR dzad006 LIKE '%,",pc_type CLIPPED,"' ",     #觸發時機
                       " OR dzad006 LIKE '%,",pc_type CLIPPED,",%') ",  #觸發時機
                     " AND dzadstus = 'Y' "          #有效碼
                 #---------------------------dzah--------------#
                 #   " AND dzah001 = dzad001 ",      #規格編號
                 #   " AND dzah002 = dzad002 ",      #Action識別碼
                 #   " AND dzah003 = dzad003 ",      #識別碼版次
                 #   " AND dzah004 = dzad005 ",      #使用標示
                 #   " AND dzah005 = '",pc_type CLIPPED,"' ",  #觸發時機
                 #   " AND dzahstus = 'Y' "          #有效碼
   END IF

   PREPARE dzad_prep FROM ls_sql
   DECLARE dzad_cs CURSOR FOR dzad_prep

   FOREACH dzad_cs INTO l_dzad001,l_dzad002,l_dzad003
      IF cl_null(ls_str) THEN
         LET ls_str = l_dzad002
      ELSE
         LET ls_str = ls_str CLIPPED,",",l_dzad002 CLIPPED
      END IF
   END FOREACH

   FREE dzad_cs
   RETURN ls_str
END FUNCTION

#+ 定位s_detail的順序,以避免畫面上插入一個就亂生一個,造成全域變數名稱混亂
#PRIVATE FUNCTION sadzp188_tab_gen_pageid()
   #DEFINE la_pageid   DYNAMIC ARRAY OF RECORD
             #record      STRING,
             #page        LIKE type_t.num5
                      #END RECORD
   #DEFINE li_cnt      LIKE type_t.num5
   #DEFINE li_pos      LIKE type_t.num5
   #DEFINE ls_temp     STRING
   #DEFINE li_finish   LIKE type_t.num5
#
   #變數清理
   #CALL la_pageid.clear()
#
   #以樹狀型態表示的單檔多欄 (暫時取消) 特別處理
   #IF g_prog_type = "i03" THEN
      #LET la_pageid[1].record = "s_browse" 
      #LET la_pageid[1].page = 1
      #RETURN la_pageid
   #END IF
#
   #處理一般頁簽
   #FOR li_cnt = 1 TO g_detail_id.getLength()
#
      #LET ls_temp = g_detail_id[li_cnt].detail_id
#
      #有筆數就開始進行比序
      #IF la_pageid.getLength() > 0 THEN
         #LET li_finish = FALSE
         #FOR li_pos = 1 TO la_pageid.getLength()
            #比序, 前比後還小就用isert填入,比較大(FLASE)就跳過
            #IF NOT li_finish AND sadzp188_tab_page_sort(ls_temp,la_pageid[li_pos].record) THEN
               #CALL la_pageid.insertElement(li_pos)
               #LET la_pageid[li_pos].record = ls_temp
               #LET li_finish = TRUE
            #END IF
         #END FOR
         #比完了還沒有比他小的,就是最大
         #IF NOT li_finish THEN
            #LET la_pageid[la_pageid.getLength()+1].record = ls_temp
         #END IF
      #ELSE
         #LET la_pageid[1].record = ls_temp
      #END IF
   #END FOR
#
   #最後填上數字
   #FOR li_cnt = 1 TO la_pageid.getLength()
      #LET la_pageid[li_cnt].page = li_cnt
   #END FOR
#
   #RETURN la_pageid
#END FUNCTION

#+ 如果ls_temp1比ls_temp2小,回傳TRUE,其他回傳FALSE
#PRIVATE FUNCTION sadzp188_tab_page_sort(ls_temp1,ls_temp2) 
   #DEFINE ls_temp1  STRING
   #DEFINE ls_temp2  STRING
   #DEFINE li_length1, li_length2  LIKE type_t.num5
   #DEFINE li_return LIKE type_t.num5
   #DEFINE li_cnt    LIKE type_t.num5
#
   #先比字串長度,比較長的就是大
   #LET li_length1 = ls_temp1.getLength()
   #LET li_length2 = ls_temp1.getLength()
 #
   #IF li_length1 <> li_length2 THEN
      #CASE
         #WHEN li_length1 < li_length2  LET li_return = TRUE
            #RETURN li_return
         #WHEN li_length1 > li_length2  LET li_return = FALSE
            #RETURN li_return
         #OTHERWISE
      #END CASE
   #END IF 
#
   #長度一樣的時候比內容(轉ASCII逐字比較)
   #FOR li_cnt = 1 TO ls_temp1.getLength()
      #LET li_length1 = ASCII(ls_temp1.subString(li_cnt,li_cnt))
      #LET li_length2 = ASCII(ls_temp2.subString(li_cnt,li_cnt))
      #CASE
         #WHEN li_length1 < li_length2  LET li_return = TRUE
            #EXIT FOR
         #WHEN li_length1 > li_length2  LET li_return = FALSE
            #EXIT FOR
         #OTHERWISE
      #END CASE
   #END FOR
#
   #RETURN li_return
#
#END FUNCTION


############################################################
#+ @code
#+ 函式目的 將資料存入gzgg_t XtraGrid報表樣板明細檔
#+          傳入p_field_name  :欄位別名
#+          傳入p_table_name  :表格名稱
#+          傳入p_column_name :欄位名稱
#+          傳入p_table_cnt   :主報表'1',子報表'2'
#+ @param   
#+ @return  
############################################################
PUBLIC FUNCTION sadzp188_ins_gzgg_pre(p_dzga001,p_dzga002,p_gzgf_max,p_cust,p_code_ide) #140617 add ,p_cust,p_code_ide
   DEFINE p_dzga001          LIKE dzga_t.dzga001
   DEFINE p_dzga002          LIKE dzga_t.dzga002
   #DEFINE p_gzgf_max         LIKE type_t.num5         ##140512 mark
   DEFINE p_gzgf_max         LIKE gzgf_t.gzgf000       ##140512 add 
   DEFINE p_cust             LIKE dzga_t.dzga005       #140617 add
   DEFINE p_code_ide         LIKE dzga_t.dzga006       #140617 add
   DEFINE ls_dzgc004         LIKE dzgc_t.dzgc004
   DEFINE ls_dzgc006         LIKE dzgc_t.dzgc006
   #DEFINE l_field_name       LIKE dzeb_t.dzeb002      ##140605 mark
   DEFINE l_field_name       LIKE dzgc_t.dzgc004       ##140605 add
   DEFINE l_table_name       LIKE dzeb_t.dzeb001
   #DEFINE l_column_name      LIKE dzeb_t.dzeb002      ##140605 mark
   DEFINE l_column_name      LIKE dzgc_t.dzgc004         ##140605 add
   DEFINE l_table            STRING
   DEFINE ls_dzgd004_tmp     LIKE dzgd_t.dzgd004
   DEFINE ls_dzgd006         LIKE dzgd_t.dzgd006    
   DEFINE ls_dzgd004         LIKE dzgd_t.dzgd004
   DEFINE ls_dzgd004_str     STRING 
   DEFINE l_lang_cnt         LIKE type_t.num5            ##140605 add
   DEFINE l_gzgdl          DYNAMIC ARRAY OF RECORD       ##140605 add
         gzgdl001            LIKE gzgdl_t.gzgdl001,
         gzgdl002            LIKE gzgdl_t.gzgdl002,
         gzgdl003            LIKE gzgdl_t.gzgdl003       #170227-00021#4 add
         END RECORD
   DEFINE l_gzgdl_cnt        LIKE type_t.num5            ##140605 add
   DEFINE l_gzgg001          LIKE gzgg_t.gzgg001         ##140606 add
   DEFINE l_gzgg025          LIKE gzgg_t.gzgg025         ##140606 add
   DEFINE ls_dzgc007         LIKE dzgc_t.dzgc007         ##140610 add
   DEFINE l_gzgdl002         LIKE gzgdl_t.gzgdl002       ##140909 add

   ##140606 add 先刪dzgl_t -(s)
     DELETE FROM dzgl_t    
      WHERE dzgl001 = p_dzga001 
        AND dzgl002 = p_dzga002      #版次
        AND dzgl003 = p_dzga001      #報表樣板
        #AND dzgl029 = p_cust          #140617 add  #141103 mark
        AND dzgl030 = p_code_ide      #140617 add
     IF STATUS THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = STATUS
        LET g_errparam.extend = 'delete dzgl_t:'
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_exe_success = 'N'

     END IF             
   ##140606 add 先刪dzgl_t -(e)

 
   ##140605  add -多語言(s) 
   ##140611 mark, 只留繁中-(s)  
   #DECLARE gzgdl000 SCROLL CURSOR FOR
         #SELECT gzgdl001,gzgdl002 FROM gzgdl_t WHERE gzgdl000='default' 
         
   #LET l_lang_cnt = 1
   #CALL l_gzgdl.clear()
   #FOREACH gzgdl000 INTO l_gzgdl[l_lang_cnt].*
     #LET l_lang_cnt = l_lang_cnt + 1
   #END FOREACH
   #CALL l_gzgdl.deleteElement(l_lang_cnt)
   #FOR l_lang_cnt = 1 TO l_gzgdl.getLength() 
   ##140611 mark, 只留繁中-(e) 
   ##140611 add, 只留繁中-(s) 


   LET l_lang_cnt = 1
   CALL l_gzgdl.clear()

   LET l_gzgdl[l_lang_cnt].gzgdl001 = g_lang

   
   FOR l_lang_cnt = 1 TO l_gzgdl.getLength() 
   ##140611 add, 只留繁中-(s)   
   ##140605 add -(e)  
   
           LET g_exe_success = 'Y'
           DECLARE sadzp188_get_field_cs1 CURSOR FOR
           SELECT dzgc004,dzgc006,dzgc007 FROM dzgc_t 
            WHERE dzgc001 =  p_dzga001 AND dzgc002 = p_dzga002  AND (dzgc005 ='1' OR dzgc005 = '3')
              #AND dzgc008 = p_cust AND dzgc009 = p_code_ide   #140617 add  #141103 mark
              AND dzgc009 = p_code_ide   #141103 add
            
           ORDER BY dzgc003   
           LET ls_dzgc007 =''        
           FOREACH sadzp188_get_field_cs1 INTO ls_dzgc004,ls_dzgc006,ls_dzgc007
              IF ls_dzgc006 = 'N' THEN  #從table挑選的欄位
                 LET l_field_name = ls_dzgc004
                 LET l_table_name =""
                 IF cl_null(ls_dzgc007) THEN 
                     SELECT gztz001 INTO l_table_name FROM gztz_t 
                     WHERE gztz002 = ls_dzgc004  AND gztz001 LIKE '%_t'
                 ELSE 
                    LET l_table_name = ls_dzgc007
                 END IF 
                 LET l_column_name = ls_dzgc004
              ELSE
                 #自定義欄位
                 SELECT dzgd004,dzgd006 INTO ls_dzgd004_tmp,ls_dzgd006 FROM dzgd_t 
                  WHERE dzgd001 = p_dzga001 AND dzgd002 = p_dzga002 AND dzgd003 = ls_dzgc004 
                    #AND dzgd007 = p_cust AND dzgd008 = p_code_ide  #140617 add  #141103 mark
                    AND dzgd008 = p_code_ide  #141103 add
                 LET l_field_name = ls_dzgc004
                 LET ls_dzgd004_str = ls_dzgd004_tmp
                 LET l_column_name = ls_dzgd004_str.subString(ls_dzgd004_str.getIndexOf(".",1)+1, ls_dzgd004_str.getLength())
                 LET l_table_name =""
                 LET l_table_name = ls_dzgd004_str.subString(1,ls_dzgd004_str.getIndexOf(".",1)-1)
 
              END IF
              #CALL sadzp188_ins_gzgg(l_field_name,l_table_name,l_column_name,l_table_cnt) 最後一個是要判別主、子報表
              
              #CALL sadzp188_ins_gzgg(p_dzga001,p_dzga002,p_gzgf_max,l_field_name,l_table_name,l_column_name,1,l_gzgdl[l_lang_cnt].gzgdl001)  #目前都只有主報表  #140617 mark
              #140618 存入dzgl_t
              CALL sadzp188_ins_gzgg(p_dzga001,p_dzga002,p_gzgf_max,l_field_name,l_table_name,l_column_name,1,l_gzgdl[l_lang_cnt].gzgdl001,p_cust,p_code_ide)  #目前都只有主報表   #140617 add
           END FOREACH 
           FREE sadzp188_get_field_cs1

           ##140606 add 反向用gzgg判斷dzgc -(s)
           DECLARE sadzp188_get_gzgg_field_cs CURSOR FOR
           SELECT gzgg001,gzgg025 FROM gzgg_t
           #WHERE gzggent = g_enterprise   #140613 mark
           # AND gzgg000 = p_gzgf_max     #報表樣板ID #140613 mark
           WHERE gzgg000 = p_gzgf_max      #140613 add
             AND gzgg002 = l_gzgdl[l_lang_cnt].gzgdl001
           FOREACH sadzp188_get_gzgg_field_cs INTO l_gzgg001,l_gzgg025

               LET l_gzgdl_cnt = 0
               SELECT COUNT(dzgc004) INTO l_gzgdl_cnt FROM dzgc_t
                WHERE dzgc001 = p_dzga001 AND dzgc002 = p_dzga002  AND (dzgc005 ='1' OR dzgc005 = '3')
                  AND dzgc004 = l_gzgg001 AND dzgc007 = l_gzgg025
                  #AND dzgc008 = p_cust AND dzgc009 = p_code_ide  #140617 add  #141103 mark
                  AND dzgc009 = p_code_ide  #141103 add
               IF l_gzgdl_cnt = 0 THEN  ##dzgc刪欄位，則gzgg也需刪欄位
                  DELETE FROM gzgg_t 
                   #WHERE gzggent = g_enterprise    #140613 mark
                     #AND gzgg000 = p_gzgf_max     #報表樣板ID #140613 mark
                   WHERE  gzgg000 = p_gzgf_max     #報表樣板ID
                     AND gzgg002 = l_gzgdl[l_lang_cnt].gzgdl001 
                     AND gzgg001 = l_gzgg001
                     AND gzgg025 = l_gzgg025
                   IF STATUS THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = STATUS
                      LET g_errparam.extend = 'delete gzgg_t:'
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      LET g_exe_success = 'N'
                   END IF                
               END IF 

           END FOREACH 
           ##140606 add 反向用gzgg判斷dzgc -(e)
           
           ##140605 存樣板說明多語言 -(s)
              #同時須寫入"報表樣板說明多語言檔(GR+XtraGrid)gzgdl_t"
 
            
               LET l_gzgdl_cnt = 0
               SELECT COUNT(gzgdl000) INTO l_gzgdl_cnt FROM gzgdl_t                
                WHERE gzgdl000= p_gzgf_max                               #140613 add
                  AND gzgdl001 = l_gzgdl[l_lang_cnt].gzgdl001
               IF l_gzgdl_cnt = 0 THEN  
                   LET l_gzgdl002 =''
                   SELECT gzgdl002 INTO l_gzgdl002 FROM gzgdl_t 
                    WHERE gzgdl000='default' AND gzgdl001 = l_gzgdl[l_lang_cnt].gzgdl001      
                    
                   #INSERT INTO gzgdl_t VALUES (p_gzgf_max,l_gzgdl[l_lang_cnt].gzgdl001,l_gzgdl002)  #140617 add  #170227-00021#4 mark
                   #170227-00021#4 -(s)
                   INSERT INTO gzgdl_t (gzgdl000,gzgdl001,gzgdl002,gzgdl003)
                                VALUES (p_gzgf_max,l_gzgdl[l_lang_cnt].gzgdl001,l_gzgdl002,p_code_ide)  
                   #170227-00021#4 -(e)
                   IF STATUS THEN
                      #CALL cl_err('insert gzgdl_t:',STATUS,1)
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = STATUS
                      LET g_errparam.extend = 'insert gzgdl_t:'
                      LET g_errparam.popup = TRUE
                      CALL cl_err()                      
                      LET g_exe_success = 'N'
                   END IF                 
               END IF 
           ##140605 存樣板說明多語言 -(s)           
    END FOR   ##140605  add
END FUNCTION 




############################################################
#+ @code
#+ 函式目的 將先資料存入dzgl，做為後面存入gzgg_t XtraGrid報表樣板明細檔的資料
#+          傳入p_dzga001  :   報表元件代號
#+          傳入p_field_name  :欄位別名
#+          傳入p_table_name  :表格名稱
#+          傳入p_column_name :欄位名稱
#+          傳入p_table_cnt   :主報表'1',子報表'2'
#+ @param   
#+ @return  
############################################################
PUBLIC FUNCTION sadzp188_ins_gzgg(p_dzga001,p_dzga002,p_gzgf_max,p_field_name,p_table_name,p_column_name,p_table_cnt,p_lang,p_cust,p_code_ide) #140617 add  ,p_cust,p_code_ide
#PUBLIC FUNCTION sadzp188_ins_gzgg(p_dzga001,p_dzga002,p_gzgf_max,p_field_name,p_table_name,p_column_name,p_table_cnt,p_lang) #140617 mark 
   DEFINE p_dzga001          LIKE dzga_t.dzga001
   DEFINE p_dzga002          LIKE dzga_t.dzga002      ##140605
   DEFINE p_gzgf_max         LIKE gzgg_t.gzgg000
   DEFINE p_cust             LIKE dzga_t.dzga005      #140617 add
   DEFINE p_code_ide         LIKE dzga_t.dzga006      #140617 add
   #DEFINE p_field_name       LIKE dzeb_t.dzeb002     ##140605 mark
   DEFINE p_field_name       LIKE dzgc_t.dzgc004     ##140605 add
   DEFINE p_table_name       LIKE dzeb_t.dzeb001
   #DEFINE p_column_name      LIKE dzeb_t.dzeb002     ##140605 mark
   DEFINE p_column_name      LIKE dzgc_t.dzgc004     ##140605 add
   DEFINE p_table_cnt        LIKE type_t.num5 
   DEFINE p_lang             LIKE gzgdl_t.gzgdl001   ##140605 add
   DEFINE l_cnt              LIKE type_t.num5
   DEFINE l_datatype         LIKE dzeb_t.dzeb007
   DEFINE l_length           LIKE dzeb_t.dzeb008
   DEFINE l_gzgg             RECORD LIKE gzgg_t.*
   DEFINE l_gzgg_max         LIKE type_t.num5
   DEFINE l_typestr          STRING 
   DEFINE l_numfmt           STRING
   DEFINE l_numfmt1          STRING   #141030 cynthia add
   #DEFINE l_numfmt1          LIKE gzgg_t.gzgg008    #141030 cynthia mark
   DEFINE l_dzgl_max         LIKE type_t.num5        ##140606 add 


      ##140606 改判斷先mark -(s)
       #SELECT COUNT(*) INTO l_cnt FROM gzgg_t
       #WHERE gzggent = g_enterprise 
         #AND gzgg000 = p_gzgf_max     #報表樣板ID
         #AND gzgg001 = p_field_name   #報表欄位代碼
         #AND gzgg002 = p_lang
       #IF l_cnt>0 THEN RETURN END IF  #已存在不需再存
       ##140606 改判斷先mark -(s)
       
       #CALL cl_xg_get_column_info('ds',p_table_name,p_column_name)   #150901-00021#1 mark
       CALL cl_rpt_get_column_info('ds',p_table_name,p_column_name)   #150901-00021#1 add            
              RETURNING l_datatype,l_length
       IF cl_null(l_datatype) AND cl_null(l_length) THEN
          #141127 mark -(s)
          #SELECT dzeb007,dzeb008 INTO l_datatype,l_length FROM dzeb_t
          #WHERE dzeb001 = p_table_name
            #AND dzeb002 = p_column_name
          #141127 mark -(e)
          ##141127 add -(s)
          SELECT gztd003,gztd008 INTO l_datatype,l_length
          FROM gztd_t LEFT JOIN dzeb_t ON dzeb006 = gztd001
          WHERE dzeb001 = p_table_name
            AND dzeb002 = p_column_name  
          ##141127 add -(e)  
       END IF 
       
       INITIALIZE l_gzgg.* TO NULL  
       #LET l_gzgg.gzggent = g_enterprise
       LET l_gzgg.gzgg000 = p_gzgf_max  #報表樣板ID
       LET l_gzgg.gzgg001 = p_field_name #報表欄位代碼
       LET l_gzgg.gzgg002 = p_lang       #語系
       CASE l_datatype
            WHEN "varchar"  LET l_gzgg.gzgg003 = 'C'
            WHEN "varchar2" LET l_gzgg.gzgg003 = 'C'
            WHEN "number"   LET l_gzgg.gzgg003 = 'N'
            WHEN "date"     LET l_gzgg.gzgg003 = 'D'
            WHEN "datetime" LET l_gzgg.gzgg003 = 'D'
            OTHERWISE       LET l_gzgg.gzgg003 = 'C'
       END CASE 
       ##取出最大順序值
       #140612 mark -(S)
       #SELECT MAX(gzgg004) INTO l_gzgg_max FROM gzgg_t    
       #WHERE gzggent = g_enterprise
       #AND gzgg000 = p_gzgf_max     #報表樣板ID
       #AND gzgg002 = p_lang
       #140612 mark (e)
       #140612 add -(s)
       SELECT MAX(dzgl004) INTO l_gzgg_max FROM dzgl_t    
       WHERE dzgl001 = p_dzga001 
         AND dzgl002 = p_dzga002      #版次
         AND dzgl003 = p_dzga001      #報表樣板 
         #AND dzgl029 = p_cust         #客戶代號 #140618 add  #141103 mark
         AND dzgl030 = p_code_ide     #客製標示 #140618 add
       #140612 add -(e) 
       
       IF cl_null(l_gzgg_max) THEN LET l_gzgg_max = 0 END IF 
       LET l_gzgg.gzgg004 = l_gzgg_max + 1 
       #寬度
       LET l_gzgg.gzgg005 = sadzp188_get_field_width(l_datatype,l_length)
       IF l_gzgg.gzgg005 IS NULL THEN
          LET l_gzgg.gzgg005 =4.000 
       END  IF 
       LET l_gzgg.gzgg006 = "Y"     #顯示
       #對齊位置
       CASE l_gzgg.gzgg003 
          WHEN "N"
               LET l_gzgg.gzgg007 = "2"  #靠右
          WHEN "C" 
               LET l_gzgg.gzgg007 = "1"  #靠左
          WHEN "D"  
               LET l_gzgg.gzgg007 = "1"  #靠左
          OTHERWISE LET l_gzgg.gzgg007 = "1" 
       END CASE
       ##140528 小數儲存型態-(s)
       CALL sadzp188_gen4rp_get_type(p_dzga001,p_field_name,'') RETURNING l_typestr, l_numfmt,l_numfmt1
       LET l_gzgg.gzgg008 = l_numfmt1            #小數位顯示位數
       ##140528 小數儲存型態-(s)
       LET l_gzgg.gzgg009 = "6"          #不小計0:加總1:最小值2:最大值3.數量4.平均6.無
       LET l_gzgg.gzgg010 = "6"          #不總計0:加總1:最小值2:最大值3.數量4.平均6.無
       LET l_gzgg.gzgg011 = ""           #條件隱藏欄位
       LET l_gzgg.gzgg012 = ""           #可設為條件隱藏欄位
       LET l_gzgg.gzgg013 = ""           #縮排    ## 150629-00034 mark       
       LET l_gzgg.gzgg013 = "N"          #縮排    ##150629-00034 add
       LET l_gzgg.gzgg014 = NULL         #交叉表橫軸順序 
       LET l_gzgg.gzgg015 = NULL         #交叉表縱軸順序
       LET l_gzgg.gzgg016 = NULL         #交叉表数据区順序
       IF l_gzgg.gzgg004 = 1 THEN 
         ##150129 add 判斷是否已設y了 -(s)
         IF sadzp188_tab_chk_prikey(p_dzga001,p_dzga002,p_code_ide) THEN           
            LET l_gzgg.gzgg017 = "Y"           #主鍵/父節點欄位   
         ELSE
            LET l_gzgg.gzgg017 = "" 
         END IF
         ##150129 add 判斷是否已設y了 -(e)
         #LET l_gzgg.gzgg017 = "Y"           #主鍵/父節點欄位    ##150129 mark 判斷是否已設y了
       ELSE 
         LET l_gzgg.gzgg017 = ""           #主鍵/父節點欄位   
       END IF 
       LET l_gzgg.gzgg018 = ""           #與主報表關聯鍵/自節點欄位
       LET l_gzgg.gzgg019 = ""           #報表樣板區段 1:單頭2:單身
       LET l_gzgg.gzgg020 = ""           #圖表類型  1.長條圖2.線圖3.區域圖4.餅圖5.雷達圖
       LET l_gzgg.gzgg021 = 0            #圖表欄位順序
       LET l_gzgg.gzgg022 = 0            #分類欄位(X軸)
       LET l_gzgg.gzgg023 = ""           #自訂欄位
       LET l_gzgg.gzgg024 = ""           #自訂欄位公式
       LET l_gzgg.gzgg025 = p_table_name  ##140605 TABLE別名  
       LET l_gzgg.gzgg026 = ""            ##140605 欄位別名
       

         

       ##140612 改先存完dzgl_t後再存到gzgg_t mark -(s)
       ##140606 add -(s)
       #SELECT COUNT(*) INTO l_cnt FROM gzgg_t
       #WHERE gzggent = g_enterprise 
         #AND gzgg000 = p_gzgf_max     #報表樣板ID
         #AND gzgg001 = p_field_name   #報表欄位代碼
         #AND gzgg025 = p_table_name   #報表表格別名
         #AND gzgg002 = p_lang
       #IF l_cnt = 0 THEN 
       ##140606 add -(e)
           #INSERT INTO gzgg_t VALUES(l_gzgg.*) 
           #IF STATUS THEN
              #CALL cl_err('insert gzgg:',STATUS,1)
              #LET g_exe_success = 'N'
           #END IF  
       #END IF ##140606 add
       ##140606 add -(s)
       ##140612 mark -(e)
       LET l_cnt = 0
       SELECT COUNT(*) INTO l_cnt FROM dzgl_t
       WHERE dzgl001 = p_dzga001 
         AND dzgl002 = p_dzga002      #版次
         AND dzgl003 = p_dzga001      #報表樣板
         AND dzgl005 = l_gzgg.gzgg001 #欄位
         AND dzgl027 = p_table_name   #報表表格別名   #141103 add
         #AND dzgl029 = p_cust        #141103 mark
         AND dzgl030 = p_code_ide
       IF l_cnt = 0 THEN 
           ##取出最大順序值
           SELECT MAX(dzgl004) INTO l_dzgl_max FROM dzgl_t    
            WHERE dzgl001 = p_dzga001 
              AND dzgl002 = p_dzga002      #版次
              AND dzgl003 = p_dzga001      #報表樣板
              #AND dzgl029 = p_cust        #141103 mark
              AND dzgl030 = p_code_ide              
           IF cl_null(l_dzgl_max) THEN LET l_dzgl_max = 0 END IF 
           LET l_dzgl_max = l_dzgl_max + 1           
         ##140606 add -(e)
           ##140605 add 增加xg樣板設計資料dzgl_t -(s)
           INSERT INTO dzgl_t VALUES(p_dzga001,p_dzga002,p_dzga001,l_dzgl_max,l_gzgg.gzgg001,l_gzgg.gzgg003,l_gzgg.gzgg005,
                                     l_gzgg.gzgg006, l_gzgg.gzgg007, l_gzgg.gzgg008, l_gzgg.gzgg009, l_gzgg.gzgg010, l_gzgg.gzgg011,
                                     l_gzgg.gzgg012, l_gzgg.gzgg013, l_gzgg.gzgg014, l_gzgg.gzgg015, l_gzgg.gzgg016, l_gzgg.gzgg017,
                                     l_gzgg.gzgg018, l_gzgg.gzgg019, l_gzgg.gzgg020, l_gzgg.gzgg021, l_gzgg.gzgg022, l_gzgg.gzgg023,
                                     l_gzgg.gzgg024, l_gzgg.gzgg025, l_gzgg.gzgg026,p_cust,p_code_ide) 
           IF STATUS THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = STATUS
              LET g_errparam.extend = 'insert dzgl_t:'
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET g_exe_success = 'N'
           END IF        
           ##140605 add 增加xg樣板設計資料dzgl_t -(s)
       END IF 

     

END FUNCTION 

FUNCTION sadzp188_get_field_width(p_datatype,p_length)
   DEFINE p_datatype         LIKE dzeb_t.dzeb007
   DEFINE p_length           LIKE dzeb_t.dzeb008 
   DEFINE l_gzgg005          LIKE gzgg_t.gzgg005

      LET l_gzgg005 = p_length / 5
      IF l_gzgg005 > 5 THEN
         LET l_gzgg005 = 5
      END IF
      IF l_gzgg005 < 1 THEN
         LET l_gzgg005 = 1
      END IF

      RETURN l_gzgg005
END FUNCTION


FUNCTION sadzp188_get_table(p_field)
   DEFINE p_field   LIKE gztz_t.gztz002
   DEFINE ls_table  LIKE gztz_t.gztz001
   DEFINE li_cnt    LIKE type_t.num5   #160510-00017 add 
       

   LET ls_table =''
   LET li_cnt = 0    #160510-00017 add 
   #SELECT gztz001 INTO ls_table FROM gztz_t WHERE gztz002 = p_field  #160510-00017 mark
   SELECT COUNT(gztz001) INTO li_cnt FROM gztz_t WHERE gztz002 = p_field   #160510-00017 add
      AND gztz001 NOT LIKE '%rebuil' #151208-00023#1 add
      ##161227-00056#1 add -(s)
      AND gztz001 NOT LIKE 'erp%'   
      AND gztz001 NOT LIKE 'all%'
      AND gztz001 NOT LIKE 'b2b%'
      AND gztz001 NOT LIKE 'pos%'
      AND gztz001 NOT LIKE 'dsm%'
      ##161227-00056#1 add -(e)      

   IF li_cnt > 1 THEN
      #DISPLAY "ERROR: 表格編號 ",p_field,"在實體資料庫中查詢到:",li_cnt USING "<<<<<","筆"   #170123-00046#1 mark
      DISPLAY cl_getmsg_parm("adz-01143",g_lang,p_field)               #170123-00046#1 add
      LET ls_table = ""
   ELSE
      SELECT gztz001 INTO ls_table FROM gztz_t WHERE gztz002 = p_field
      AND gztz001 NOT LIKE '%rebuil' #160510-00017 add
      ##161227-00056#1 add -(s)
      AND gztz001 NOT LIKE 'erp%'   
      AND gztz001 NOT LIKE 'all%'
      AND gztz001 NOT LIKE 'b2b%'
      AND gztz001 NOT LIKE 'pos%'
      AND gztz001 NOT LIKE 'dsm%'
      ##161227-00056#1 add -(e)      
   END IF

   RETURN ls_table
END FUNCTION 

###g_enterpise與g_dlang 組sql要另外處理   #161223-00004#1 mark
##g_enterprise與g_dlang 組sql要另外處理   #161223-00004#1 add
FUNCTION sadzp188_handle_dzgb011_dlang(ps_dzgb011)  
   #DEFINE ps_dzgb011    LIKE dzgb_t.dzgb011       #160615-00007#1 mark
   DEFINE ps_dzgb011    STRING                     #160615-00007#1 add
   DEFINE l_str         base.StringBuffer
   DEFINE l_tmp         STRING 


   LET l_str = base.StringBuffer.create()
   CALL l_str.clear()
   CALL l_str.append(ps_dzgb011)
   #160615-00007#1 mark -(s) ENT是數字不用加單引號       
   #IF l_str.getIndexOf("g_enterprise",1) > 0 THEN
      #LET l_tmp = "'\" ,", "g_enterprise",",\"'\" ,\""   #160615-00007#1 mark
      #CALL l_str.replace("g_enterprise",l_tmp,0) #160615-00007#1 mark ENT是數字不用加單引號       
   #END IF 
   #160615-00007#1 mark -(e) 
   IF l_str.getIndexOf("g_dlang",1) > 0 THEN
      LET l_tmp = "'\" ,", "g_dlang",",\"'\" ,\""  
      CALL l_str.replace("g_dlang",l_tmp,0)    
   END IF    

   RETURN l_str.toString()

END FUNCTION 


#取出報表元件相關資訊
FUNCTION sadzp188_tab_relation_prog_type(p_prog_id)                    
   DEFINE p_prog_id       LIKE gzde_t.gzde001                           
   DEFINE lc_gzdecrtid    LIKE gzde_t.gzdecrtid
   DEFINE lc_gzdecrtdt    LIKE gzde_t.gzdecrtdt
   DEFINE lc_gzde005      LIKE gzde_t.gzde005
   DEFINE l_prog_type     STRING 
   DEFINE lc_gzde008      LIKE gzde_t.gzde008               #160921-00012#1 add
   DEFINE lc_gzde006      LIKE gzde_t.gzde006               #160921-00012#1 add 

    ##160921-00012#1 add -(s)
    LET lc_gzdecrtid = ""
    LET lc_gzde005 = ""
    LET lc_gzdecrtdt = ""
    LET lc_gzde006 = ""
    ##160921-00012#1 add -(e)

   
     SELECT gzdecrtid,gzde005,gzdecrtdt,gzde006             #160921-00012#1 add  gzde006
       INTO lc_gzdecrtid,lc_gzde005,lc_gzdecrtdt,lc_gzde006 #160921-00012#1 add  lc_gzde006
       FROM gzde_t
      WHERE gzde001 = g_prog_id #規格/畫面編號
        #AND gzde008 = g_code_ide  #140619 客製標示
        

   #20140312 (s)-先暫定抓gzde_t
   IF lc_gzde005 = "X" THEN 
     #160921-00012#1 -(s)
     CASE lc_gzde006
       WHEN "1"
         LET l_prog_type = "x01" 
       WHEN "2"
         LET l_prog_type = "x02"   
       OTHERWISE 
         LET l_prog_type = "x01"       
     END CASE
     #160921-00012#1 -(e)    
     #LET l_prog_type = "x01"   #樣板型態 #160921-00012#1 mark
   ELSE 
     #160921-00012#1 -(s)
     CASE lc_gzde006
       WHEN "1"
         LET l_prog_type = "g01" 
       OTHERWISE 
         LET l_prog_type = "g01"       
     END CASE   
     #160921-00012#1 -(e)
     #LET l_prog_type = "g01"   #樣板型態 #160921-00012#1 mark
   END IF 
   #20140312 (e) 


   RETURN l_prog_type, lc_gzdecrtid,lc_gzdecrtdt   
END FUNCTION 


################################################################################
# Descriptions...: 判斷欄位的屬性是否符合屬性檔
# Memo...........: 
# Usage..........: CALL sadzp188_tab_chk_field_property(l_m_field,"C")
# Input parameter: ps_mfield           欄位代號
# Input parameter: ps_type             類別        
# Return code....: TRUE/FALSE          boolen
# Date & Author..: 2014/04/30
# Modify.........:
################################################################################
PUBLIC FUNCTION sadzp188_tab_chk_field_property(ps_mfield,ps_type)
  DEFINE ps_mfield       LIKE dzgd_t.dzgd003
  DEFINE ps_type         LIKE dzgk_t.dzgk003
  DEFINE l_gztz001       LIKE gztz_t.gztz001
  DEFINE l_cnt           LIKE type_t.num5
  DEFINE  l_dzeb006       LIKE dzeb_t.dzeb006


  SELECT dzeb006 INTO l_dzeb006 FROM dzeb_t 
   LEFT JOIN gztz_t ON gztz001 = dzeb001 AND gztz002 = dzeb002
   WHERE dzeb002 = ps_mfield

  SELECT COUNT(*) INTO l_cnt FROM dzgk_t WHERE dzgk002 = l_dzeb006 AND dzgk003 = ps_type

  IF l_cnt > 0 THEN
      RETURN TRUE 
  ELSE 
      RETURN FALSE 
  END IF
  
END FUNCTION 



#140611 add -(s)
################################################################################
# Descriptions...: 報表元件設計資料與樣板資訊複製
# Memo...........: 
# Usage..........: CALL sadzp188_copy_rep_table()
# Input parameter: p_prog           報表元件代號
#                : p_old_ver        舊版次
#                : p_old_env        舊客製標示
#                : p_new_ver        新版次
#                : p_new_env        新客製標示
# Return code....: boolen           
# Date & Author..: 2014/06/11
# Modify.........:
################################################################################
PUBLIC FUNCTION sadzp188_copy_rep_table(p_prog,p_old_ver,p_old_env,p_new_ver,p_new_env,p_delete)
  DEFINE p_prog       LIKE dzga_t.dzga001     #報表元件代號
  DEFINE p_old_ver    LIKE dzga_t.dzga002     #舊版次
  DEFINE p_old_env    LIKE dzga_t.dzga006     #舊客製標示
  DEFINE p_new_ver    LIKE dzga_t.dzga002     #新版次     
  DEFINE p_new_env    LIKE dzga_t.dzga006     #新客製標示
  DEFINE p_delete     LIKE type_t.chr1        #N:新增/D:刪除
  DEFINE l_dzga       RECORD LIKE dzga_t.*                  #報表元件設計主檔
  DEFINE l_dzgb       DYNAMIC ARRAY OF RECORD LIKE dzgb_t.* #報表元件設計-資料模型Table連結明細檔
  DEFINE l_dzgc       DYNAMIC ARRAY OF RECORD LIKE dzgc_t.* #報表元件設計-資料模型欄位明細檔
  DEFINE l_dzgd       DYNAMIC ARRAY OF RECORD LIKE dzgd_t.* #報表元件設計-資料模型自訂義欄位明細檔
  DEFINE l_dzge       DYNAMIC ARRAY OF RECORD LIKE dzge_t.* #報表元件設計-資料模型群組明細檔(GR) 
  DEFINE l_dzgf       DYNAMIC ARRAY OF RECORD LIKE dzgf_t.* #報表元件設計-資料模型篩選條件式明細檔
  DEFINE l_dzgg       DYNAMIC ARRAY OF RECORD LIKE dzgg_t.* #報表元件設計-樣板單頭檔(GR)
  DEFINE l_dzgh       DYNAMIC ARRAY OF RECORD LIKE dzgh_t.* #報表元件設計-樣板明細檔(GR)
  DEFINE l_dzgi       DYNAMIC ARRAY OF RECORD LIKE dzgi_t.* #報表元件設計-資料模型位Table明細檔 
  DEFINE l_dzgj       DYNAMIC ARRAY OF RECORD LIKE dzgj_t.* #報表元件設計-參數明細檔
  DEFINE l_dzgl       DYNAMIC ARRAY OF RECORD LIKE dzgl_t.* #報表元件設計-樣板明細檔(XG)
  DEFINE l_gzgd       DYNAMIC ARRAY OF RECORD LIKE gzgd_t.* #GR報表樣板主檔
  DEFINE l_gzgdl      DYNAMIC ARRAY OF RECORD LIKE gzgdl_t.*#報表樣板說明多語言檔(GR+XtraGrid)
  DEFINE l_gzge       DYNAMIC ARRAY OF RECORD LIKE gzge_t.* #報表樣板多語言紀錄檔(GR+XtraGrid)
  DEFINE l_gzgf       DYNAMIC ARRAY OF RECORD LIKE gzgf_t.* #XtraGrid報表樣板主檔
  DEFINE l_gzgg       DYNAMIC ARRAY OF RECORD LIKE gzgg_t.* #XtraGrid報表樣板明細檔
  DEFINE l_i          LIKE type_t.num5
  DEFINE l_j          LIKE type_t.num5
  DEFINE l_gzgf000    LIKE gzgf_t.gzgf000
  DEFINE l_gzgf000_t  LIKE gzgf_t.gzgf000   
  DEFINE l_gzgd000    LIKE gzgd_t.gzgd000
  DEFINE l_gzgd000_t  LIKE gzgd_t.gzgd000
  DEFINE l_ide        LIKE dzga_t.dzga001
  DEFINE l_cnt        LIKE type_t.num5 
  DEFINE ls_gzgd000   LIKE gzgd_t.gzgd000   #140616 add
  DEFINE ls_gzgf000   LIKE gzgf_t.gzgf000   #140616 add
  DEFINE ls_gzgd003   LIKE gzgd_t.gzgd003   #140616 add
  DEFINE ls_gzgd003_o LIKE gzgd_t.gzgd003   #140616 add
  DEFINE ls_gzgd003_n LIKE gzgd_t.gzgd003   #140616 add
  DEFINE lb_result    BOOLEAN               #140620 add 判斷結果
  DEFINE l_sql        STRING                #150512-00011#1 add


  
  IF p_delete ='N' THEN 
      IF p_old_ver = '0' THEN 
         DISPLAY "old ver:",p_old_ver
         RETURN FALSE
      ELSE 
         LET lb_result = TRUE   #140620 add
         BEGIN WORK
         ##dzga_t
         ##沒資料才做
         LET l_cnt = 0
         SELECT COUNT(dzga001) INTO l_cnt FROM dzga_t
          WHERE dzgastus ='Y' AND dzga001 = p_prog AND dzga002 = p_new_ver AND dzga006 = p_new_env 
          IF l_cnt = 0 THEN           

             SELECT dzgastus,dzga003,dzga004 INTO l_dzga.dzgastus, l_dzga.dzga003,l_dzga.dzga004 FROM dzga_t     
              WHERE dzgastus ='Y' AND dzga001 = p_prog AND dzga002 = p_old_ver AND dzga006 = p_old_env
             IF STATUS THEN
                #CALL cl_err('select dzga_t:',STATUS,1)
                DISPLAY "select dzga_t:"
                LET lb_result = FALSE  #140620 add
                GOTO _return           #140620 add  
                #RETURN FALSE          #140620 mark
             END IF      
             LET l_dzga.dzga001 = p_prog
             LET l_dzga.dzga002 = p_new_ver
             LET l_dzga.dzgaownid = g_user
             LET l_dzga.dzgaowndp = g_dept
             LET l_dzga.dzgacrtid = g_user
             LET l_dzga.dzgacrtdp = g_dept
             LET l_dzga.dzgacrtdt = cl_get_current()
             LET l_dzga.dzga005 = FGL_GETENV("CUST") CLIPPED
             LET l_dzga.dzga006 = p_new_env
             INSERT INTO dzga_t VALUES(l_dzga.*) 
             IF STATUS THEN
                #CALL cl_err('copy insert dzga:',STATUS,1)
                DISPLAY "copy insert dzga"
                #ROLLBACK WORK         #140620 mark
                #RETURN FALSE          #140620 mark                
                LET lb_result = FALSE  #140620 add
                GOTO _return           #140620 add  

                
             END IF          


             ##dzgb_t
             ##沒資料才做
             LET l_cnt = 0
             SELECT COUNT(dzgb001) INTO l_cnt FROM dzgb_t
              WHERE dzgb001 = p_prog AND dzgb002 = p_new_ver AND dzgb019 = p_new_env 
              IF l_cnt = 0 THEN

                 DECLARE sadzp188_get_dzgb_cs CURSOR FOR
                 SELECT * FROM dzgb_t
                  WHERE dzgb001 = p_prog AND dzgb002 = p_old_ver AND dzgb019 = p_old_env
                 LET l_i = 1
                 CALL l_dzgb.clear()
                 FOREACH sadzp188_get_dzgb_cs INTO l_dzgb[l_i].* 
                     LET l_dzgb[l_i].dzgb002 = p_new_ver
                     LET l_dzgb[l_i].dzgb018 = FGL_GETENV("CUST") CLIPPED
                     LET l_dzgb[l_i].dzgb019 = p_new_env             
                     INSERT INTO dzgb_t VALUES(l_dzgb[l_i].*) 
                     IF STATUS THEN
                        #CALL cl_err('copy insert dzgb:',STATUS,1)
                        DISPLAY "copy insert dzgb" 
                        #ROLLBACK WORK         #140620 mark
                        #RETURN FALSE          #140620 mark                
                        LET lb_result = FALSE  #140620 add
                        GOTO _return           #140620 add 
                     END IF 
                     LET l_i = l_i + 1 
                 END FOREACH 
              END IF  

             ##dzgc_t
             ##沒資料才做
             LET l_cnt = 0
             SELECT COUNT(dzgc001) INTO l_cnt FROM dzgc_t
              WHERE dzgc001 = p_prog AND dzgc002 = p_new_ver AND dzgc009 = p_new_env 
              IF l_cnt = 0 THEN
                 DECLARE sadzp188_get_dzgc_cs CURSOR FOR
                 SELECT * FROM dzgc_t
                  WHERE dzgc001 = p_prog AND dzgc002 = p_old_ver AND dzgc009 = p_old_env
                 LET l_i = 1
                 CALL l_dzgc.clear()
                 FOREACH sadzp188_get_dzgc_cs INTO l_dzgc[l_i].* 
                     LET l_dzgc[l_i].dzgc002 = p_new_ver
                     LET l_dzgc[l_i].dzgc008 = FGL_GETENV("CUST") CLIPPED
                     LET l_dzgc[l_i].dzgc009 = p_new_env             
                     INSERT INTO dzgc_t VALUES(l_dzgc[l_i].*) 
                     IF STATUS THEN
                        #CALL cl_err('copy insert dzgc:',STATUS,1)
                        DISPLAY "copy insert dzgc" 
                        #ROLLBACK WORK         #140620 mark
                        #RETURN FALSE          #140620 mark                
                        LET lb_result = FALSE  #140620 add
                        GOTO _return           #140620 add 
                     END IF 
                     LET l_i = l_i + 1 
                 END FOREACH 
              END IF 


             ##dzgd_t
             ##沒資料才做
             LET l_cnt = 0
             SELECT COUNT(dzgd001) INTO l_cnt FROM dzgd_t
              WHERE dzgd001 = p_prog AND dzgd002 = p_new_ver AND dzgd008 = p_new_env 
              IF l_cnt = 0 THEN

                 DECLARE sadzp188_get_dzgd_cs CURSOR FOR
                 SELECT * FROM dzgd_t
                  WHERE dzgd001 = p_prog AND dzgd002 = p_old_ver AND dzgd008 = p_old_env
                 LET l_i = 1
                 CALL l_dzgd.clear()
                 FOREACH sadzp188_get_dzgd_cs INTO l_dzgd[l_i].* 
                     LET l_dzgd[l_i].dzgd002 = p_new_ver
                     LET l_dzgd[l_i].dzgd007 = FGL_GETENV("CUST") CLIPPED
                     LET l_dzgd[l_i].dzgd008 = p_new_env             
                     INSERT INTO dzgd_t VALUES(l_dzgd[l_i].*) 
                     IF STATUS THEN
                        #CALL cl_err('copy insert dzgd:',STATUS,1)
                        DISPLAY "copy insert dzgd" 
                        #ROLLBACK WORK         #140620 mark
                        #RETURN FALSE          #140620 mark                
                        LET lb_result = FALSE  #140620 add
                        GOTO _return           #140620 add 
                     END IF 
                     LET l_i = l_i + 1 
                 END FOREACH 
              END IF       


             ##dzge_t
             ##沒資料才做
             LET l_cnt = 0
             SELECT COUNT(dzge001) INTO l_cnt FROM dzge_t
              WHERE dzge001 = p_prog AND dzge002 = p_new_ver AND dzge009 = p_new_env 
              IF l_cnt = 0 THEN

                 DECLARE sadzp188_get_dzge_cs CURSOR FOR
                 SELECT * FROM dzge_t
                  WHERE dzge001 = p_prog AND dzge002 = p_old_ver AND dzge009 = p_old_env
                 LET l_i = 1
                 CALL l_dzge.clear()
                 FOREACH sadzp188_get_dzge_cs INTO l_dzge[l_i].* 
                     LET l_dzge[l_i].dzge002 = p_new_ver
                     LET l_dzge[l_i].dzge008 = FGL_GETENV("CUST") CLIPPED
                     LET l_dzge[l_i].dzge009 = p_new_env             
                     INSERT INTO dzge_t VALUES(l_dzge[l_i].*) 
                     IF STATUS THEN
                        #CALL cl_err('copy insert dzge:',STATUS,1)
                        DISPLAY "copy insert dzge" 
                        #ROLLBACK WORK         #140620 mark
                        #RETURN FALSE          #140620 mark                
                        LET lb_result = FALSE  #140620 add
                        GOTO _return           #140620 add 
                     END IF 
                     LET l_i = l_i + 1 
                 END FOREACH 
              END IF 

             ##dzgf_t
             ##沒資料才做
             LET l_cnt = 0
             SELECT COUNT(dzgf001) INTO l_cnt FROM dzgf_t
              WHERE dzgf001 = p_prog AND dzgf002 = p_new_ver AND dzgf012 = p_new_env 
              IF l_cnt = 0 THEN

                 DECLARE sadzp188_get_dzgf_cs CURSOR FOR
                 SELECT * FROM dzgf_t
                  WHERE dzgf001 = p_prog AND dzgf002 = p_old_ver AND dzgf012 = p_old_env
                 LET l_i = 1
                 CALL l_dzgf.clear()
                 FOREACH sadzp188_get_dzgf_cs INTO l_dzgf[l_i].* 
                     LET l_dzgf[l_i].dzgf002 = p_new_ver
                     LET l_dzgf[l_i].dzgf011 = FGL_GETENV("CUST") CLIPPED
                     LET l_dzgf[l_i].dzgf012 = p_new_env             
                     INSERT INTO dzgf_t VALUES(l_dzgf[l_i].*) 
                     IF STATUS THEN
                        #CALL cl_err('copy insert dzgf:',STATUS,1)
                        DISPLAY "copy insert dzgf" 
                        #ROLLBACK WORK         #140620 mark
                        #RETURN FALSE          #140620 mark                
                        LET lb_result = FALSE  #140620 add
                        GOTO _return           #140620 add 
                     END IF 
                     LET l_i = l_i + 1 
                 END FOREACH 
              END IF 

             ##dzgi_t
             ##沒資料才做
             LET l_cnt = 0
             SELECT COUNT(dzgi001) INTO l_cnt FROM dzgi_t
              WHERE dzgi001 = p_prog AND dzgi002 = p_new_ver AND dzgi006 = p_new_env 
              IF l_cnt = 0 THEN

                 DECLARE sadzp188_get_dzgi_cs CURSOR FOR
                 SELECT * FROM dzgi_t
                  WHERE dzgi001 = p_prog AND dzgi002 = p_old_ver AND dzgi006 = p_old_env
                 LET l_i = 1
                 CALL l_dzgi.clear()
                 FOREACH sadzp188_get_dzgi_cs INTO l_dzgi[l_i].* 
                     LET l_dzgi[l_i].dzgi002 = p_new_ver
                     LET l_dzgi[l_i].dzgi005 = FGL_GETENV("CUST") CLIPPED
                     LET l_dzgi[l_i].dzgi006 = p_new_env             
                     INSERT INTO dzgi_t VALUES(l_dzgi[l_i].*) 
                     IF STATUS THEN
                        #CALL cl_err('copy insert dzgi:',STATUS,1)
                        DISPLAY "copy insert dzgi" 
                        #ROLLBACK WORK         #140620 mark
                        #RETURN FALSE          #140620 mark                
                        LET lb_result = FALSE  #140620 add
                        GOTO _return           #140620 add 
                     END IF 
                     LET l_i = l_i + 1 
                 END FOREACH 
              END IF 

             ##dzgj_t
             ##沒資料才做
             LET l_cnt = 0
             SELECT COUNT(dzgj001) INTO l_cnt FROM dzgj_t
              WHERE dzgj001 = p_prog AND dzgj002 = p_new_ver AND dzgj008 = p_new_env 
              IF l_cnt = 0 THEN     
                 DECLARE sadzp188_get_dzgj_cs CURSOR FOR
                 SELECT * FROM dzgj_t
                  WHERE dzgj001 = p_prog AND dzgj002 = p_old_ver AND dzgj008 = p_old_env
                 LET l_i = 1
                 CALL l_dzgj.clear()
                 FOREACH sadzp188_get_dzgj_cs INTO l_dzgj[l_i].* 
                     LET l_dzgj[l_i].dzgj002 = p_new_ver
                     LET l_dzgj[l_i].dzgj007 = FGL_GETENV("CUST") CLIPPED
                     LET l_dzgj[l_i].dzgj008 = p_new_env             
                     INSERT INTO dzgj_t VALUES(l_dzgj[l_i].*) 
                     IF STATUS THEN
                        #CALL cl_err('copy insert dzgj:',STATUS,1)
                        DISPLAY "copy insert dzgj" 
                        #ROLLBACK WORK         #140620 mark
                        #RETURN FALSE          #140620 mark                
                        LET lb_result = FALSE  #140620 add
                        GOTO _return           #140620 add 
                     END IF 
                     LET l_i = l_i + 1 
                 END FOREACH 
              END IF   
             DISPLAY "l_dzga.dzga003:",l_dzga.dzga002
             IF l_dzga.dzga003 ="1" THEN  ##GR才存gzgg、gzgh      
                 ##dzgg_t
                 ##沒資料才做
                 LET l_cnt = 0
                 SELECT COUNT(dzgg001) INTO l_cnt FROM dzgg_t
                  WHERE dzgg001 = p_prog AND dzgg002 = p_new_ver AND dzgg017 = p_new_env 
                  IF l_cnt = 0 THEN

                     DECLARE sadzp188_get_dzgg_cs CURSOR FOR
                     SELECT * FROM dzgg_t
                      WHERE dzgg001 = p_prog AND dzgg002 = p_old_ver AND dzgg017 = p_old_env
                     LET l_i = 1
                     CALL l_dzgg.clear()
                     FOREACH sadzp188_get_dzgg_cs INTO l_dzgg[l_i].* 
                         LET l_dzgg[l_i].dzgg002 = p_new_ver
                         LET l_dzgg[l_i].dzgg016 = FGL_GETENV("CUST") CLIPPED
                         LET l_dzgg[l_i].dzgg017 = p_new_env             
                         INSERT INTO dzgg_t VALUES(l_dzgg[l_i].*) 
                         IF STATUS THEN
                            #CALL cl_err('copy insert dzgg:',STATUS,1)
                            DISPLAY "copy insert dzgg" 
                            #ROLLBACK WORK         #140620 mark
                            #RETURN FALSE          #140620 mark                
                            LET lb_result = FALSE  #140620 add
                            GOTO _return           #140620 add 
                         END IF 
                         LET l_i = l_i + 1 
                     END FOREACH 
                  END IF 

                 ##dzgh_t
                 ##沒資料才做
                 LET l_cnt = 0
                 SELECT COUNT(dzgh001) INTO l_cnt FROM dzgh_t
                  WHERE dzgh001 = p_prog AND dzgh002 = p_new_ver  AND dzgh012 = p_new_env   
                  IF l_cnt = 0 THEN

                     DECLARE sadzp188_get_dzgh_cs CURSOR FOR
                     SELECT * FROM dzgh_t
                      WHERE dzgh001 = p_prog AND dzgh002 = p_old_ver AND dzgh012 = p_old_env
                     LET l_i = 1
                     CALL l_dzgh.clear()
                     FOREACH sadzp188_get_dzgh_cs INTO l_dzgh[l_i].* 
                         LET l_dzgh[l_i].dzgh002 = p_new_ver
                         LET l_dzgh[l_i].dzgh011 = FGL_GETENV("CUST") CLIPPED
                         LET l_dzgh[l_i].dzgh012 = p_new_env             
                         INSERT INTO dzgh_t VALUES(l_dzgh[l_i].*) 
                         IF STATUS THEN
                            #CALL cl_err('copy insert dzgh:',STATUS,1)
                            DISPLAY "copy insert dzgh" 
                            #ROLLBACK WORK         #140620 mark
                            #RETURN FALSE          #140620 mark                
                            LET lb_result = FALSE  #140620 add
                            GOTO _return           #140620 add  
                         END IF 
                         LET l_i = l_i + 1 
                     END FOREACH 
                  END IF   

                  ##NO.150512-00011   add 簽出時複製至備份檔-(s)

                  ##刪除備份檔資料
                  ##報表樣板說明多語言檔(GR+XtraGrid)(備份)
                  LET l_sql = " DELETE FROM dzrdl_t rdl WHERE EXISTS ( ",
                              " SELECT * FROM dzrd_t rd WHERE rd.dzrd000 = rdl.dzrdl000 ",
                              "    AND dzrdstus = 'Y' AND dzrd001 = '", p_prog ,"' AND dzrd003 = '", p_old_env,"'",
                              "    AND dzrd004 = 'default' AND dzrd005 = 'default')"    
                  PREPARE delete_gzgdl_data_gr FROM l_sql
                  EXECUTE delete_gzgdl_data_gr    
                  IF STATUS THEN
                     DISPLAY "delete_gzgdl_data_gr"            
                     LET lb_result = FALSE  
                     GOTO _return           
                  END IF      
                  
                  ##樣板說明多語言
                  LET l_sql = " DELETE FROM dzre_t re WHERE EXISTS ( ",
                              " SELECT * FROM dzrd_t rd WHERE rd.dzrd000 = re.dzre000 ",
                              "    AND dzrdstus = 'Y' AND dzrd001 = '", p_prog ,"' AND dzrd003 = '", p_old_env,"'",
                              "    AND dzrd004 = 'default' AND dzrd005 = 'default')"      
                  PREPARE delete_dzre_data_gr FROM l_sql
                  EXECUTE delete_dzre_data_gr   
                  IF STATUS THEN
                     DISPLAY "delete_dzre_data_gr"            
                     LET lb_result = FALSE  
                     GOTO _return           
                  END IF                     

                  DELETE FROM dzrd_t 
                        WHERE dzrdstus = 'Y' AND dzrd001 = p_prog AND dzrd003 = p_old_env
                                             AND dzrd004 = 'default' AND dzrd005 = 'default'
                  IF STATUS THEN
                     DISPLAY "delete_dzrd_data_gr"            
                     LET lb_result = FALSE  
                     GOTO _return           
                  END IF                  
                  
                  INSERT INTO dzrd_t
                       SELECT * FROM gzgd_t WHERE gzgdstus = 'Y' AND gzgd001 = p_prog AND gzgd003 = p_old_env
                                              AND gzgd004 = 'default' AND gzgd005 = 'default'
                  ##報表樣板說明多語言檔(GR+XtraGrid)(備份)
                  LET l_sql = " INSERT INTO dzrdl_t ",
                              " SELECT * FROM gzgdl_t gdl WHERE EXISTS ( ",
                              " SELECT * FROM gzgd_t gd WHERE gd.gzgd000 = gdl.gzgdl000 ",
                              "    AND gzgdstus = 'Y' AND gzgd001 = '", p_prog ,"' AND gzgd003 = '", p_old_env,"'",
                              "    AND gzgd004 = 'default' AND gzgd005 = 'default')"    
                  PREPARE insert_data_to_dzrdl_t FROM l_sql
                  EXECUTE insert_data_to_dzrdl_t    
                  IF STATUS THEN
                     DISPLAY "insert_data_to_dzrdl_t"            
                     LET lb_result = FALSE  
                     GOTO _return           
                  END IF                   
                  ##樣板說明多語言
                  LET l_sql = " INSERT INTO dzre_t ",
                              " SELECT * FROM gzge_t ge WHERE EXISTS ( ",
                              " SELECT * FROM gzgd_t gd WHERE gd.gzgd000 = ge.gzge000 ",
                              "    AND gzgdstus = 'Y' AND gzgd001 = '", p_prog ,"' AND gzgd003 = '", p_old_env,"'",
                              "    AND gzgd004 = 'default' AND gzgd005 = 'default')"    
                  PREPARE insert_data_to_dzre_t FROM l_sql
                  EXECUTE insert_data_to_dzre_t   
                  IF STATUS THEN
                     DISPLAY "insert_data_to_dzre_t"            
                     LET lb_result = FALSE  
                     GOTO _return           
                  END IF                    
                  ##NO.150512-00011   add 簽出時複製至備份檔-(e)
                  ##gzgd_t  
                  IF p_old_env <> p_new_env THEN  ##客製標示不同才做
                      #LET ls_gzgd003_n ="Y"  #141002 客製 mark
                      LET ls_gzgd003_n ="c"   #141002 客製 add
                      #IF p_new_env = "s" THEN LET ls_gzgd003_n ="N" END IF  #141002 客製 mark
                     IF p_new_env = "s" THEN LET ls_gzgd003_n ="s" END IF   #141002 客製 add
                      LET l_cnt = 0       
                      SELECT COUNT(gzgd000) INTO l_cnt FROM gzgd_t 
                       WHERE gzgdstus = 'Y'    
                         AND gzgd001 = p_prog
                         AND gzgd003 = ls_gzgd003_n
                         AND gzgd004 = 'default'
                         AND gzgd005 = 'default' 
                      IF l_cnt = 0 THEN 

                         #LET ls_gzgd003_o = "Y"   #141002 客製 mark
                         LET ls_gzgd003_o = "c"   #141002 客製 add
                         #IF p_old_env = "s" THEN LET ls_gzgd003_o ="N" END IF     #141002 客製 mark            
                         IF p_old_env = "s" THEN LET ls_gzgd003_o ="s" END IF     #141002 客製 add            
                         DECLARE sadzp188_get_gzgd_cs CURSOR FOR
                          SELECT * FROM gzgd_t 
                           WHERE gzgdstus = 'Y'    
                             AND gzgd001 = p_prog
                             AND gzgd003 = ls_gzgd003_o
                             AND gzgd004 = 'default'
                             AND gzgd005 = 'default' 
                         LET l_i = 1
                         CALL l_dzgd.clear()
                         LET l_gzgd000 =''
                         FOREACH sadzp188_get_gzgd_cs INTO l_gzgd[l_i].* 
                            CALL security.RandomGenerator.CreateUUIDString() RETURNING l_gzgd000
                            LET l_gzgd000_t = ''
                            LET l_gzgd000_t = l_gzgd[l_i].gzgd000
                            LET l_gzgd[l_i].gzgd000 = l_gzgd000 
                            LET l_gzgd[l_i].gzgd003 = ls_gzgd003_n 
                            LET l_gzgd[l_i].gzgdownid = g_user
                            LET l_gzgd[l_i].gzgdowndp = g_dept
                            LET l_gzgd[l_i].gzgdcrtid = g_user
                            LET l_gzgd[l_i].gzgdcrtdp = g_dept
                            LET l_gzgd[l_i].gzgdcrtdt = cl_get_current()
                            INSERT INTO gzgd_t VALUES(l_gzgd[l_i].*) 
                            IF STATUS THEN
                               #CALL cl_err('copy insert dzgg:',STATUS,1)
                               DISPLAY "copy insert dzgg" 
                               #ROLLBACK WORK         #140620 mark
                               #RETURN FALSE          #140620 mark                
                               LET lb_result = FALSE  #140620 add
                               GOTO _return           #140620 add 
                            END IF 

                            #dzgdl_t   
                            LET l_cnt = 0
                            SELECT COUNT(gzgdl000) INTO l_cnt FROM gzgdl_t 
                             WHERE gzgdl000 = l_gzgd000
                            IF l_cnt =0 THEN 

                               DECLARE sadzp188_get_gzgdl_cs CURSOR FOR
                                SELECT * FROM gzgdl_t 
                                 WHERE gzgdl000 = l_gzgd000_t  
             
                               LET l_j = 1
                               CALL l_gzgdl.clear()
                               FOREACH sadzp188_get_gzgdl_cs INTO l_gzgdl[l_j].*                       
                                  LET l_gzgdl[l_j].gzgdl000 = l_gzgd000 
                                  INSERT INTO gzgdl_t VALUES(l_gzgdl[l_j].*) 
                                  IF STATUS THEN
                                     #CALL cl_err('copy insert gzgdl:',STATUS,1)
                                     DISPLAY "copy insert gzgdl" 
                                    #ROLLBACK WORK         #140620 mark
                                    #RETURN FALSE          #140620 mark                
                                    LET lb_result = FALSE  #140620 add
                                    GOTO _return           #140620 add 
                                  END IF                       
                                  LET l_j = l_j + 1                               
                               END FOREACH 

                            END IF 
                            
                            #dzge_t   
                            LET l_cnt = 0
                            SELECT COUNT(gzge000) INTO l_cnt FROM gzge_t 
                             WHERE gzge000 = l_gzgd000
                            IF l_cnt = 0 THEN 

                               DECLARE sadzp188_get_gzge_cs CURSOR FOR
                                SELECT * FROM gzge_t 
                                 WHERE gzge000 = l_gzgd000_t  
             
                               LET l_j = 1
                               CALL l_gzge.clear()
                               FOREACH sadzp188_get_gzge_cs INTO l_gzge[l_j].*                       
                                  LET l_gzge[l_j].gzge000 = l_gzgd000 
                                  INSERT INTO gzge_t VALUES(l_gzge[l_j].*) 
                                  IF STATUS THEN
                                     #CALL cl_err('copy insert gzge:',STATUS,1)
                                     DISPLAY "copy insert gzge" 
                                    #ROLLBACK WORK         #140620 mark
                                    #RETURN FALSE          #140620 mark                
                                    LET lb_result = FALSE  #140620 add
                                    GOTO _return           #140620 add 
                                  END IF                       
                                  LET l_j = l_j + 1                               
                               END FOREACH 

                            END IF                 
                            LET l_i = l_i + 1                               
                         END FOREACH 
                         
                     END IF 
                 END IF 
                  
             ELSE ##XG
             
                 ##dzgl_t
                 ##沒資料才做
                     LET l_cnt = 0
                     SELECT COUNT(dzgl001) INTO l_cnt FROM dzgl_t
                      WHERE dzgl001 = p_prog AND dzgl002 = p_new_ver AND dzgl030 = p_new_env 
                      IF l_cnt = 0 THEN

                         #LET ls_gzgd003_o = "Y"     #141002 客製 mark
                         LET ls_gzgd003_o = "s"      #141002 客製 add
                         #IF p_old_env = "s" THEN LET ls_gzgd003_o ="N" END IF   #141002 客製 mark
                         IF p_old_env = "s" THEN LET ls_gzgd003_o ="s" END IF   #141002 客製 add
                         DECLARE sadzp188_get_dzgl_cs CURSOR FOR
                         SELECT * FROM dzgl_t
                          WHERE dzgl001 = p_prog AND dzgl002 = p_old_ver AND dzgl030 = p_old_env 
                         LET l_i = 1
                         CALL l_dzgl.clear()
                         FOREACH sadzp188_get_dzgl_cs INTO l_dzgl[l_i].* 
                             LET l_dzgl[l_i].dzgl002 = p_new_ver
                             LET l_dzgl[l_i].dzgl029 = FGL_GETENV("CUST") CLIPPED
                             LET l_dzgl[l_i].dzgl030 = p_new_env             
                             INSERT INTO dzgl_t VALUES(l_dzgl[l_i].*) 
                             IF STATUS THEN
                                #CALL cl_err('copy insert dzgl:',STATUS,1)
                                DISPLAY "copy insert dzgl" 
                                #ROLLBACK WORK         #140620 mark
                                #RETURN FALSE          #140620 mark                
                                LET lb_result = FALSE  #140620 add
                                GOTO _return           #140620 add 
                             END IF 
                             LET l_i = l_i + 1 
                         END FOREACH 
                      END IF  

                  ##NO.150512-00011   add 簽出時複製至備份檔-(s)
                  ##先刪除備份檔資料
                  ##XtraGrid報表樣板明細檔(備份)
                  LET l_sql = " DELETE FROM dzrg_t rg WHERE EXISTS ( ",
                              " SELECT * FROM dzrf_t rf WHERE rf.dzrf000 = rg.dzrg000 ",
                              "    AND dzrfstus = 'Y' AND dzrf001 = '", p_prog ,"' AND dzrf003 = '", p_old_env,"'",
                              "    AND dzrf004 = 'default' AND dzrf005 = 'default')"   
                  PREPARE delete_dzrg_data_xg FROM l_sql
                  EXECUTE delete_dzrg_data_xg                                 
                  IF STATUS THEN
                     DISPLAY "delete_dzrg_data_xg"            
                     LET lb_result = FALSE  
                     GOTO _return           
                  END IF    
                  
                  ##報表樣板說明多語言檔(GR+XtraGrid)(備份)
                  LET l_sql = " DELETE FROM dzrdl_t rdl WHERE EXISTS ( ",
                              " SELECT * FROM dzrf_t rf WHERE rf.dzrf000 = rdl.dzrdl000 ",
                              "    AND dzrfstus = 'Y' AND dzrf001 = '", p_prog ,"' AND dzrf003 = '", p_old_env,"'",
                              "    AND dzrf004 = 'default' AND dzrf005 = 'default')"   
                  PREPARE delete_dzrdl_data_xg FROM l_sql
                  EXECUTE delete_dzrdl_data_xg                                 
                  IF STATUS THEN
                     DISPLAY "delete_dzrdl_data_xg"            
                     LET lb_result = FALSE  
                     GOTO _return           
                  END IF     
                  
                  ##樣板說明多語言
                  LET l_sql = " DELETE FROM dzre_t re WHERE EXISTS ( ",
                              " SELECT * FROM dzrf_t rf WHERE rf.dzrf000 = re.dzre000 ",
                              "    AND dzrfstus = 'Y' AND dzrf001 = '", p_prog ,"' AND dzrf003 = '", p_old_env,"'",
                              "    AND dzrf004 = 'default' AND dzrf005 = 'default')"      
                  PREPARE delete_dzre_data_xg FROM l_sql
                  EXECUTE delete_dzre_data_xg                               
                  IF STATUS THEN
                     DISPLAY "delete_dzre_data_xg"            
                     LET lb_result = FALSE  
                     GOTO _return           
                  END IF    

                  DELETE FROM dzrf_t WHERE dzrfstus = 'Y' AND dzrf001 = p_prog AND dzrf003 = p_old_env
                                              AND dzrf004 = 'default' AND dzrf005 = 'default'
                  IF STATUS THEN
                     DISPLAY "delete_dzrf_data_xg"            
                     LET lb_result = FALSE  
                     GOTO _return           
                  END IF   
                  
                  
                  ##XtraGrid報表樣板主檔(備份)
                  INSERT INTO dzrf_t
                       SELECT * FROM gzgf_t WHERE gzgfstus = 'Y' AND gzgf001 = p_prog AND gzgf003 = p_old_env
                                              AND gzgf004 = 'default' AND gzgf005 = 'default'

                  ##XtraGrid報表樣板明細檔(備份)
                  LET l_sql = " INSERT INTO dzrg_t ",
                              " SELECT * FROM gzgg_t gg WHERE EXISTS ( ",
                              " SELECT * FROM gzgf_t gf WHERE gf.gzgf000 = gg.gzgg000 ",
                              "    AND gzgfstus = 'Y' AND gzgf001 = '", p_prog ,"' AND gzgf003 = '", p_old_env,"'",
                              "    AND gzgf004 = 'default' AND gzgf005 = 'default')"  
                  PREPARE ins_dzrg_data_xg FROM l_sql
                  EXECUTE ins_dzrg_data_xg                                 
                  IF STATUS THEN
                     DISPLAY "insert_data_to_dzrg_t"            
                     LET lb_result = FALSE  
                     GOTO _return           
                  END IF       
                  
                  ##報表樣板說明多語言檔(GR+XtraGrid)(備份)
                  LET l_sql = " INSERT INTO dzrdl_t ",
                              " SELECT * FROM gzgdl_t gdl WHERE EXISTS ( ",
                              " SELECT * FROM gzgf_t gf WHERE gf.gzgf000 = gdl.gzgdl000 ",
                              "    AND gzgfstus = 'Y' AND gzgf001 = '", p_prog ,"' AND gzgf003 = '", p_old_env,"'",
                              "    AND gzgf004 = 'default' AND gzgf005 = 'default')"     
                  PREPARE ins_gzgdl_data_xg FROM l_sql
                  EXECUTE ins_gzgdl_data_xg                                 
                  IF STATUS THEN
                     DISPLAY "insert_data_to_dzrdl_t"            
                     LET lb_result = FALSE  
                     GOTO _return           
                  END IF   
                  
                  ##樣板說明多語言
                  LET l_sql = " INSERT INTO dzre_t ",
                              " SELECT * FROM gzge_t ge WHERE EXISTS ( ",
                              " SELECT * FROM gzgf_t gf WHERE gf.gzgf000 = ge.gzge000 ",
                              "    AND gzgfstus = 'Y' AND gzgf001 = '", p_prog ,"' AND gzgf003 = '", p_old_env,"'",
                              "    AND gzgf004 = 'default' AND gzgf005 = 'default')"  
                  PREPARE ins_dzre_data_xg FROM l_sql
                  EXECUTE ins_dzre_data_xg                                 
                  IF STATUS THEN
                     DISPLAY "insert_data_to_dzre_t"            
                     LET lb_result = FALSE  
                     GOTO _return           
                  END IF                               
                  ##NO.150512-00011   add 簽出時複製至備份檔-(e)
                 
                 IF p_old_env <> p_new_env THEN  ##客製標示不同才做
                     #LET ls_gzgd003_n = "Y"  #141002 客製 mark
                     LET ls_gzgd003_n = "c"   #141002 客製 add 
                     #IF p_new_env = "s" THEN LET ls_gzgd003_n ="N" END IF    #141002 客製 mark
                     IF p_new_env = "s" THEN LET ls_gzgd003_n ="s" END IF     #141002 客製 add

                      ##gzgf_t  
                      LET l_cnt = 0        
                      SELECT COUNT(gzgf000) INTO l_cnt FROM gzgf_t 
                       WHERE gzgfstus = 'Y'    
                         AND gzgf001 = p_prog
                         AND gzgf002 = p_prog   
                         AND gzgf003 = ls_gzgd003_n
                         AND gzgf004 = 'default'
                         AND gzgf005 = 'default' 
                      IF l_cnt = 0 THEN

                         DECLARE sadzp188_get_gzgf_cs CURSOR FOR
                          SELECT * FROM gzgf_t 
                           WHERE gzgfstus = 'Y'    
                             AND gzgf001 = p_prog
                             AND gzgf003 = ls_gzgd003_o
                             AND gzgf004 = 'default'
                             AND gzgf005 = 'default' 
                         LET l_i = 1
                         CALL l_dzgf.clear()
                         LET l_gzgf000 =''
                         FOREACH sadzp188_get_gzgf_cs INTO l_gzgf[l_i].* 
                            CALL security.RandomGenerator.CreateUUIDString() RETURNING l_gzgf000
                            LET l_gzgf000_t =''
                            LET l_gzgf000_t = l_gzgf[l_i].gzgf000
                            LET l_gzgf[l_i].gzgf000 = l_gzgf000 
                            LET l_gzgf[l_i].gzgf003 = ls_gzgd003_n 
                            LET l_gzgf[l_i].gzgfownid = g_user
                            LET l_gzgf[l_i].gzgfowndp = g_dept
                            LET l_gzgf[l_i].gzgfcrtid = g_user
                            LET l_gzgf[l_i].gzgfcrtid = g_dept
                            LET l_gzgf[l_i].gzgfcrtdt = cl_get_current()
                            INSERT INTO gzgf_t VALUES(l_gzgf[l_i].*) 
                            IF STATUS THEN
                               #CALL cl_err('copy insert gzgf:',STATUS,1)
                               DISPLAY "copy insert gzgf" 
                                #ROLLBACK WORK         #140620 mark
                                #RETURN FALSE          #140620 mark                
                                LET lb_result = FALSE  #140620 add
                                GOTO _return           #140620 add 
                            END IF 

                            ##gzgg_t          
                            SELECT COUNT(gzgg000) INTO l_cnt FROM gzgg_t 
                             WHERE gzgg000 = l_gzgf000   
                            IF l_cnt = 0 THEN 

                               DECLARE sadzp188_get_gzgg_cs CURSOR FOR
                                SELECT * FROM gzgg_t 
                                 WHERE gzgg000 = l_gzgf000_t    

                               LET l_j = 1
                               CALL l_gzgg.clear()
                               FOREACH sadzp188_get_gzgg_cs INTO l_gzgg[l_j].*                       
                                  LET l_gzgg[l_j].gzgg000 = l_gzgf000 
                                  INSERT INTO gzgg_t VALUES(l_gzgg[l_j].*) 
                                  IF STATUS THEN
                                     #CALL cl_err('copy insert gzgg:',STATUS,1)
                                     DISPLAY "copy insert gzgg" 
                                    #ROLLBACK WORK         #140620 mark
                                    #RETURN FALSE          #140620 mark                
                                    LET lb_result = FALSE  #140620 add
                                    GOTO _return           #140620 add 
                                  END IF                       
                                  LET l_j = l_j + 1                               
                               END FOREACH 
                            END IF

                            #140624 add -(S)
                            LET l_cnt = 0
                            SELECT COUNT(gzge000) INTO l_cnt FROM gzge_t 
                             WHERE gzge000 = l_gzgf000
                            IF l_cnt = 0 THEN 

                               DECLARE sadzp188_get_gzge_cs1 CURSOR FOR
                                SELECT * FROM gzge_t 
                                 WHERE gzge000 = l_gzgf000_t  
             
                               LET l_j = 1
                               CALL l_gzge.clear()
                               FOREACH sadzp188_get_gzge_cs1 INTO l_gzge[l_j].*                       
                                  LET l_gzge[l_j].gzge000 = l_gzgf000 
                                  INSERT INTO gzge_t VALUES(l_gzge[l_j].*) 
                                  IF STATUS THEN
                                     #CALL cl_err('copy insert gzge:',STATUS,1)
                                     DISPLAY "copy insert gzge" 
                                    #ROLLBACK WORK         #140620 mark
                                    #RETURN FALSE          #140620 mark                
                                    LET lb_result = FALSE  #140620 add
                                    GOTO _return           #140620 add 
                                  END IF                       
                                  LET l_j = l_j + 1                               
                               END FOREACH 

                            END IF  
                            #140624 add -(e)
                            ##150518 add -(s)
                            LET l_cnt = 0
                            SELECT COUNT(gzgdl000) INTO l_cnt FROM gzgdl_t 
                             WHERE gzgdl000 = l_gzgf000
                            IF l_cnt = 0 THEN 

                               DECLARE sadzp188_get_gzgdl_cs1 CURSOR FOR
                                SELECT * FROM gzgdl_t 
                                 WHERE gzgdl000 = l_gzgf000_t  
             
                               LET l_j = 1
                               CALL l_gzgdl.clear()
                               FOREACH sadzp188_get_gzgdl_cs1 INTO l_gzgdl[l_j].*                       
                                  LET l_gzgdl[l_j].gzgdl000 = l_gzgf000 
                                  INSERT INTO gzgdl_t VALUES(l_gzgdl[l_j].*) 
                                  IF STATUS THEN
                                     DISPLAY "copy insert gzgdl"                     
                                    LET lb_result = FALSE  
                                    GOTO _return           
                                  END IF                       
                                  LET l_j = l_j + 1                               
                               END FOREACH 

                            END IF                              
                            LET l_i = l_i + 1                               
                         END FOREACH                
                      END IF  
                       ##150518 add -(e)
                 END IF          
             END IF   #判斷是gr/xg        
          END IF 
       END IF  

  ELSE #刪資料
       ##刪掉最新版new_ver與new_env
       LET lb_result = TRUE   #140620 add
       BEGIN WORK
       SELECT dzgastus,dzga003,dzga004 INTO l_dzga.dzgastus, l_dzga.dzga003,l_dzga.dzga004 FROM dzga_t
        WHERE dzgastus ='Y' AND dzga001 = p_prog AND dzga002 = p_old_ver AND dzga006 = p_old_env
        
       DELETE FROM dzga_t 
        WHERE dzgastus ='Y' AND dzga001 = p_prog AND dzga002 = p_new_ver AND dzga006 = p_new_env
        IF STATUS THEN
           #CALL cl_err('DELETE dzga_t:',STATUS,1)
           DISPLAY "delete dzga_t" 
           #ROLLBACK WORK         #140620 mark
           #RETURN FALSE          #140620 mark                
           LET lb_result = FALSE  #140620 add
           GOTO _return           #140620 add 
        END IF 
        

        DELETE FROM dzgb_t
         WHERE dzgb001 = p_prog AND dzgb002 = p_new_ver AND dzgb019 = p_new_env        
        IF STATUS THEN
           #CALL cl_err('DELETE dzgb_t:',STATUS,1)
           DISPLAY "delete dzgb_t" 
           #ROLLBACK WORK         #140620 mark
           #RETURN FALSE          #140620 mark                
           LET lb_result = FALSE  #140620 add
           GOTO _return           #140620 add 
        END IF

        DELETE FROM dzgc_t
          WHERE dzgc001 = p_prog AND dzgc002 = p_new_ver AND dzgc009 = p_new_env 
        IF STATUS THEN
           #CALL cl_err('DELETE dzgc_t:',STATUS,1)
           DISPLAY "delete dzgc_t" 
           #ROLLBACK WORK         #140620 mark
           #RETURN FALSE          #140620 mark                
           LET lb_result = FALSE  #140620 add
           GOTO _return           #140620 add 
        END IF          

        DELETE FROM dzgd_t
          WHERE dzgd001 = p_prog AND dzgd002 = p_new_ver AND dzgd008 = p_new_env 
        IF STATUS THEN
           #CALL cl_err('DELETE dzgd_t:',STATUS,1)
           DISPLAY "delete dzgd_t" 
           #ROLLBACK WORK         #140620 mark
           #RETURN FALSE          #140620 mark                
           LET lb_result = FALSE  #140620 add
           GOTO _return           #140620 add 
        END IF           

        DELETE FROM dzge_t
          WHERE dzge001 = p_prog AND dzge002 = p_new_ver AND dzge009 = p_new_env 
        IF STATUS THEN
           #CALL cl_err('DELETE dzge_t:',STATUS,1)
           DISPLAY "delete dzge_t" 
           #ROLLBACK WORK         #140620 mark
           #RETURN FALSE          #140620 mark                
           LET lb_result = FALSE  #140620 add
           GOTO _return           #140620 add 
        END IF    

        DELETE FROM dzgf_t
          WHERE dzgf001 = p_prog AND dzgf002 = p_new_ver AND dzgf012 = p_new_env  
        IF STATUS THEN
           #CALL cl_err('DELETE dzgf_t:',STATUS,1)
           DISPLAY "delete dzgf_t" 
           #ROLLBACK WORK         #140620 mark
           #RETURN FALSE          #140620 mark                
           LET lb_result = FALSE  #140620 add
           GOTO _return           #140620 add  
        END IF   

        DELETE FROM dzgi_t
          WHERE dzgi001 = p_prog AND dzgi002 = p_new_ver AND dzgi006 = p_new_env 
        IF STATUS THEN
           #CALL cl_err('DELETE dzgi_t:',STATUS,1)
           DISPLAY "delete dzgi_t" 
           #ROLLBACK WORK         #140620 mark
           #RETURN FALSE          #140620 mark                
           LET lb_result = FALSE  #140620 add
           GOTO _return           #140620 add E 
        END IF 

        DELETE FROM dzgj_t
          WHERE dzgj001 = p_prog AND dzgj002 = p_new_ver AND dzgj008 = p_new_env 
        IF STATUS THEN
           #CALL cl_err('DELETE dzgj_t:',STATUS,1)
           DISPLAY "delete dzgj_t" 
           #ROLLBACK WORK         #140620 mark
           #RETURN FALSE          #140620 mark                
           LET lb_result = FALSE  #140620 add
           GOTO _return           #140620 add 
        END IF 
        #LET ls_gzgd003="Y"   #141002 客製 mark
        LET ls_gzgd003="c"   #141002 客製 add
        #IF p_new_env ="s" THEN LET ls_gzgd003="N" END IF   #141002 客製 mark
        IF p_new_env ="s" THEN LET ls_gzgd003="s" END IF   #141002 客製 add
        IF l_dzga.dzga003 ="1" THEN  ##GR
             DELETE FROM dzgg_t           
              WHERE dzgg001 = p_prog AND dzgg002 = p_new_ver AND dzgg017 = p_new_env 
            IF STATUS THEN
               #CALL cl_err('DELETE dzgg_t:',STATUS,1)
               DISPLAY "delete dzgg_t" 
               #ROLLBACK WORK         #140620 mark
               #RETURN FALSE          #140620 mark                
               LET lb_result = FALSE  #140620 add
               GOTO _return           #140620 add  
            END IF       
             DELETE FROM dzgh_t
              WHERE dzgh001 = p_prog AND dzgh002 = p_new_ver  AND dzgh012 = p_new_env 
            IF STATUS THEN
               #CALL cl_err('DELETE dzgh_t:',STATUS,1)
               DISPLAY "delete dzgh_t" 
               #ROLLBACK WORK         #140620 mark
               #RETURN FALSE          #140620 mark                
               LET lb_result = FALSE  #140620 add
               GOTO _return           #140620 add 
            END IF  
            #IF p_old_env <> p_new_env THEN  ##客製標示不同才做  #NO.150512-00011 mark
                DECLARE sadzp188_tab_del_gzgd_cs CURSOR FOR  
                SELECT gzgd000 FROM gzgd_t 
                 WHERE gzgdstus = 'Y'    
                   AND gzgd001 = p_prog               
                   AND gzgd003 = ls_gzgd003  
                   AND gzgd004 = 'default'
                   AND gzgd005 = 'default' 
                FOREACH sadzp188_tab_del_gzgd_cs INTO ls_gzgd000
                   DELETE FROM gzgdl_t WHERE gzgdl000 = ls_gzgd000 
                   IF STATUS THEN
                      #CALL cl_err('DELETE gzgdl_t:',STATUS,1)
                      DISPLAY "delete gzgdl_t" 
                      #ROLLBACK WORK         #140620 mark
                      #RETURN FALSE          #140620 mark                
                      LET lb_result = FALSE  #140620 add
                      GOTO _return           #140620 add 
                   END IF 
                   
                   DELETE FROM gzge_t WHERE gzge000 = ls_gzgd000
                   IF STATUS THEN
                      #CALL cl_err('DELETE gzge_t:',STATUS,1)
                      DISPLAY "delete gzge_t" 
                      #ROLLBACK WORK         #140620 mark
                      #RETURN FALSE          #140620 mark                
                      LET lb_result = FALSE  #140620 add
                      GOTO _return           #140620 add 
                   END IF   
                 
                END FOREACH    
                   
    
                DELETE FROM gzgd_t 
                 WHERE gzgdstus = 'Y'    
                   AND gzgd001 = p_prog
                   AND gzgd003 = ls_gzgd003
                   AND gzgd004 = 'default'
                   AND gzgd005 = 'default' 
                IF STATUS THEN
                   #CALL cl_err('DELETE gzgd_t:',STATUS,1)
                   DISPLAY "delete gzgd_t" 
                   #ROLLBACK WORK         #140620 mark
                   #RETURN FALSE          #140620 mark                
                   LET lb_result = FALSE  #140620 add
                   GOTO _return           #140620 add 
                END IF  

                ##NO.150512-00011 從備份檔將資料存回 add -(s)
                #IF p_old_env <> p_new_env THEN  ##客製標示不同才做

                  INSERT INTO gzgd_t
                       SELECT * FROM dzrd_t WHERE dzrdstus = 'Y' AND dzrd001 = p_prog AND dzrd003 = p_old_env
                                              AND dzrd004 = 'default' AND dzrd005 = 'default'
                  IF STATUS THEN
                     DISPLAY "backup_data_to_gzgd_t"            
                     LET lb_result = FALSE  
                     GOTO _return           
                  END IF       
                  
                  ##報表樣板說明多語言檔(GR+XtraGrid)(備份)
                  LET l_sql = " INSERT INTO gzgdl_t ",
                              " SELECT * FROM dzrdl_t rdl WHERE EXISTS ( ",
                              " SELECT * FROM dzrd_t rd WHERE rd.dzrd000 = rdl.dzrdl000 ",
                              "    AND dzrdstus = 'Y' AND dzrd001 = '", p_prog ,"' AND dzrd003 = '", p_old_env,"'",
                              "    AND dzrd004 = 'default' AND dzrd005 = 'default')"    
                  PREPARE insert_data_to_gzgdl_t FROM l_sql
                  EXECUTE insert_data_to_gzgdl_t    
                  IF STATUS THEN
                     DISPLAY "backup_data_to_gzgdl_t"            
                     LET lb_result = FALSE  
                     GOTO _return           
                  END IF      
                  
                  ##樣板說明多語言
                  LET l_sql = " INSERT INTO gzge_t ",
                              " SELECT * FROM dzre_t re WHERE EXISTS ( ",
                              " SELECT * FROM dzrd_t rd WHERE rd.dzrd000 = re.dzre000 ",
                              "    AND dzrdstus = 'Y' AND dzrd001 = '", p_prog ,"' AND dzrd003 = '", p_old_env,"'",
                              "    AND dzrd004 = 'default' AND dzrd005 = 'default')"      
                  PREPARE insert_data_to_gzge_t FROM l_sql
                  EXECUTE insert_data_to_gzge_t   
                  IF STATUS THEN
                     DISPLAY "backup_data_to gzge_t"            
                     LET lb_result = FALSE  
                     GOTO _return           
                  END IF    

                ##NO.150512-00011 從備份檔將資料存回 add -(e)              
             #END IF 
             ##刪除備份檔資料
              ##報表樣板說明多語言檔(GR+XtraGrid)(備份)
              LET l_sql = " DELETE FROM dzrdl_t rdl WHERE EXISTS ( ",
                          " SELECT * FROM dzrd_t rd WHERE rd.dzrd000 = rdl.dzrdl000 ",
                          "    AND dzrdstus = 'Y' AND dzrd001 = '", p_prog ,"' AND dzrd003 = '", p_old_env,"'",
                          "    AND dzrd004 = 'default' AND dzrd005 = 'default')"    
              PREPARE delete_gzgdl_data FROM l_sql
              EXECUTE delete_gzgdl_data    
              IF STATUS THEN
                 DISPLAY "delete_gzgdl_data"            
                 LET lb_result = FALSE  
                 GOTO _return           
              END IF      
              
              ##樣板說明多語言
              LET l_sql = " DELETE FROM dzre_t re WHERE EXISTS ( ",
                          " SELECT * FROM dzrd_t rd WHERE rd.dzrd000 = re.dzre000 ",
                          "    AND dzrdstus = 'Y' AND dzrd001 = '", p_prog ,"' AND dzrd003 = '", p_old_env,"'",
                          "    AND dzrd004 = 'default' AND dzrd005 = 'default')"      
              PREPARE delete_dzre_data FROM l_sql
              EXECUTE delete_dzre_data   
              IF STATUS THEN
                 DISPLAY "delete_dzre_data"            
                 LET lb_result = FALSE  
                 GOTO _return           
              END IF                     

              DELETE FROM dzrd_t 
                    WHERE dzrdstus = 'Y' AND dzrd001 = p_prog AND dzrd003 = p_old_env
                                         AND dzrd004 = 'default' AND dzrd005 = 'default'
              IF STATUS THEN
                 DISPLAY "delete_dzrd_data"            
                 LET lb_result = FALSE  
                 GOTO _return           
              END IF              
        ELSE  ##XG
            DELETE FROM dzgl_t
              WHERE dzgl001 = p_prog AND dzgl002 = p_new_ver AND dzgl030 = p_new_env 
            IF STATUS THEN
               #CALL cl_err('DELETE dzgl_t:',STATUS,1)
               DISPLAY "delete dzgl_t" 
               #ROLLBACK WORK         #140620 mark
               #RETURN FALSE          #140620 mark                
               LET lb_result = FALSE  #140620 add
               GOTO _return           #140620 add 
            END IF  

            #IF p_old_env <> p_new_env THEN  ##客製標示不同才做  #NO.150512-00011 mark
            DECLARE sadzp188_tab_del_gzgf_cs CURSOR FOR 
            SELECT gzgf000 FROM gzgf_t
               WHERE gzgfstus = 'Y'    
                 AND gzgf001 = p_prog
                 #AND gzgf002 = p_prog   #140616不列為條件，要將所有樣板代號資料全複製
                 AND gzgf003 = p_new_env
                 AND gzgf004 = 'default'
                 AND gzgf005 = 'default' 
            FOREACH sadzp188_tab_del_gzgf_cs INTO ls_gzgf000                
               DELETE FROM gzgg_t WHERE gzgg000 = ls_gzgf000 
               IF STATUS THEN
                  #CALL cl_err('DELETE gzgg_t:',STATUS,1)
                  DISPLAY "delete gzgg_t" 
                  #ROLLBACK WORK         #140620 mark
                  #RETURN FALSE          #140620 mark                
                  LET lb_result = FALSE  #140620 add
                  GOTO _return           #140620 add  
               END IF              

                DELETE FROM gzgdl_t WHERE gzgdl000 = ls_gzgf000 
               IF STATUS THEN
                  DISPLAY "delete gzgdl_t"               
                  LET lb_result = FALSE  
                  GOTO _return           
               END IF 
               
               DELETE FROM gzge_t WHERE gzge000 = ls_gzgf000
               IF STATUS THEN
                  DISPLAY "delete gzge_t"       
                  LET lb_result = FALSE  
                  GOTO _return           
               END IF                  
            END FOREACH             

            
            DELETE FROM gzgf_t 
               WHERE gzgfstus = 'Y' AND gzgf001 = p_prog AND gzgf003 = p_new_env 
                 AND gzgf004 = 'default' AND gzgf005 = 'default' 
               IF STATUS THEN                  
                  DISPLAY "delete gzgf_t" 
                  #ROLLBACK WORK         #140620 mark
                  #RETURN FALSE          #140620 mark                
                  LET lb_result = FALSE  #140620 add
                  GOTO _return           #140620 add  
               END IF 
  
            ##NO.150512-00011 從備份檔將資料存回 add -(s)
            #IF p_old_env <> p_new_env THEN  ##客製標示不同才做
                  ##XtraGrid報表樣板主檔(備份)
                  
                  INSERT INTO gzgf_t
                       SELECT * FROM dzrf_t WHERE dzrfstus = 'Y' AND dzrf001 = p_prog AND dzrf003 = p_old_env
                                              AND dzrf004 = 'default' AND dzrf005 = 'default'
                  IF STATUS THEN
                     DISPLAY "backup_data_to_gzgf_t"            
                     LET lb_result = FALSE  
                     GOTO _return           
                  END IF   
                  
                  ##XtraGrid報表樣板明細檔(備份)
                  LET l_sql = " INSERT INTO gzgg_t ",
                              " SELECT * FROM dzrg_t rg WHERE EXISTS ( ",
                              " SELECT * FROM dzrf_t rf WHERE rf.dzrf000 = rg.dzrg000 ",
                              "    AND dzrfstus = 'Y' AND dzrf001 = '", p_prog ,"' AND dzrf003 = '", p_old_env,"'",
                              "    AND dzrf004 = 'default' AND dzrf005 = 'default')"  
                  PREPARE delete_gzgg_data FROM l_sql
                  EXECUTE delete_gzgg_data                                
                  IF STATUS THEN
                     DISPLAY "backup_data_to_gzgg_t"            
                     LET lb_result = FALSE  
                     GOTO _return           
                  END IF    
                  
                  ##報表樣板說明多語言檔(GR+XtraGrid)(備份)
                  LET l_sql = " INSERT INTO gzgdl_t ",
                              " SELECT * FROM dzrdl_t rdl WHERE EXISTS ( ",
                              " SELECT * FROM dzrf_t rf WHERE rf.dzrf000 = rdl.dzrdl000 ",
                              "    AND dzrfstus = 'Y' AND dzrf001 = '", p_prog ,"' AND dzrf003 = '", p_old_env,"'",
                              "    AND dzrf004 = 'default' AND dzrf005 = 'default')"   
                  PREPARE delete_gzgdl_t_data FROM l_sql
                  EXECUTE delete_gzgdl_t_data                               
                  IF STATUS THEN
                     DISPLAY "backup_data_to_gzgdl_t"            
                     LET lb_result = FALSE  
                     GOTO _return           
                  END IF     
                  
                  ##樣板說明多語言
                  LET l_sql = " INSERT INTO gzge_t ",
                              " SELECT * FROM dzre_t re WHERE EXISTS ( ",
                              " SELECT * FROM dzrf_t rf WHERE rf.dzrf000 = re.dzre000 ",
                              "    AND dzrfstus = 'Y' AND dzrf001 = '", p_prog ,"' AND dzrf003 = '", p_old_env,"'",
                              "    AND dzrf004 = 'default' AND dzrf005 = 'default')"      
                  PREPARE delete_gzge_t_data FROM l_sql
                  EXECUTE delete_gzge_t_data                                 
                  IF STATUS THEN
                     DISPLAY "backup_data_to_gzge_t"            
                     LET lb_result = FALSE  
                     GOTO _return           
                  END IF     
                  
            #END IF 
             ##刪除備份檔
             ##XtraGrid報表樣板明細檔(備份)
             LET l_sql = " DELETE FROM dzrg_t rg WHERE EXISTS ( ",
                         " SELECT * FROM dzrf_t rf WHERE rf.dzrf000 = rg.dzrg000 ",
                         "    AND dzrfstus = 'Y' AND dzrf001 = '", p_prog ,"' AND dzrf003 = '", p_old_env,"'",
                         "    AND dzrf004 = 'default' AND dzrf005 = 'default')"   
             PREPARE delete_dzrg_t_data FROM l_sql
             EXECUTE delete_dzrg_t_data                         
             IF STATUS THEN
                DISPLAY "delete_dzrg_data"            
                LET lb_result = FALSE  
                GOTO _return           
             END IF    
             
             ##報表樣板說明多語言檔(GR+XtraGrid)(備份)
             LET l_sql = " DELETE FROM dzrdl_t rdl WHERE EXISTS ( ",
                         " SELECT * FROM dzrf_t rf WHERE rf.dzrf000 = rdl.dzrdl000 ",
                         "    AND dzrfstus = 'Y' AND dzrf001 = '", p_prog ,"' AND dzrf003 = '", p_old_env,"'",
                         "    AND dzrf004 = 'default' AND dzrf005 = 'default')"  
             PREPARE delete_dzrdl_t_data FROM l_sql
             EXECUTE delete_dzrdl_t_data                           
             IF STATUS THEN
                DISPLAY "delete_dzrdl_data"            
                LET lb_result = FALSE  
                GOTO _return           
             END IF     
             
             ##樣板說明多語言
             LET l_sql = " DELETE FROM dzre_t re WHERE EXISTS ( ",
                         " SELECT * FROM dzrf_t rf WHERE rf.dzrf000 = re.dzre000 ",
                         "    AND dzrfstus = 'Y' AND dzrf001 = '", p_prog ,"' AND dzrf003 = '", p_old_env,"'",
                         "    AND dzrf004 = 'default' AND dzrf005 = 'default')"    
             PREPARE delete_dzre_t_data FROM l_sql
             EXECUTE delete_dzre_t_data                             
             IF STATUS THEN
                DISPLAY "delete_dzre_data"            
                LET lb_result = FALSE  
                GOTO _return           
             END IF    

             DELETE FROM dzrf_t WHERE dzrfstus = 'Y' AND dzrf001 = p_prog AND dzrf003 = p_old_env
                                         AND dzrf004 = 'default' AND dzrf005 = 'default'
             IF STATUS THEN
                DISPLAY "delete_dzrf_data"            
                LET lb_result = FALSE  
                GOTO _return           
             END IF             
            ##NO.150512-00011 從備份檔將資料存回 add -(e)    

        END IF
      

  END IF 
  
 # RETURN TRUE  

  #140620 add -(s)
  LABEL _return:
  
      IF lb_result then
        COMMIT WORK 
      ELSE 
        ROLLBACK WORK 
      END IF    
      
      RETURN lb_result
  #140620 add -(e) 
END FUNCTION 
#140611 add -(s)


##150129 add -(s)
#判斷第2個table是否有在dzag裡且是否為單身table
PRIVATE FUNCTION sadzp188_tab_chk_add_tablename(p_prog_id,p_prog_ver,p_code_ide,l_dzgi004_1,l_dzgi004_2)
   DEFINE p_prog_id      LIKE dzga_t.dzga001    #程式代碼
   DEFINE p_prog_ver     LIKE dzaa_t.dzaa002   #產生版本
   DEFINE p_code_ide     LIKE type_t.chr1     #140613 add 客製標示
   DEFINE l_dzgi004_1    LIKE dzgi_t.dzgi004    ##單頭table
   DEFINE l_dzgi004_2    LIKE dzgi_t.dzgi004    ##單身table
   DEFINE l_cnt     LIKE type_t.num5
   DEFINE l_cnt1     LIKE type_t.num5

   
   LET l_cnt = 0  
   SELECT COUNT(dzgb001) INTO l_cnt FROM dzgb_t
   WHERE dzgb001 = p_prog_id AND dzgb002 = p_prog_ver 
     AND dzgb019 = p_code_ide
   ##有參考來源 
   IF l_cnt > 0 THEN
           LET l_cnt1 = 0  
           SELECT COUNT(dzag001) INTO l_cnt1 FROM dzag_t
            WHERE dzag002 = l_dzgi004_2 AND dzag004 = l_dzgi004_1            
           ##第2個table非單身table    
           IF l_cnt1 = 0 THEN
              RETURN TRUE 
           ELSE
              RETURN FALSE
           END IF 
   ELSE
      RETURN FALSE
   END IF 
   

END FUNCTION 
##150129 add -(s)

##150202 add -(s)
##確認是否已有在dagl019設Y了，若有只需設一個，dzgl019會存至gzgg017
PRIVATE FUNCTION sadzp188_tab_chk_prikey(p_prog_id,p_prog_ver,p_code_ide)  
   DEFINE p_prog_id      LIKE dzga_t.dzga001    #程式代碼
   DEFINE p_prog_ver     LIKE dzaa_t.dzaa002   #產生版本
   DEFINE p_code_ide     LIKE type_t.chr1      #客製標示
   DEFINE l_cnt LIKE type_t.num5

   LET l_cnt = 0
   SELECT COUNT(dzgl019) INTO l_cnt FROM dzgl_t
    WHERE dzgl001 = p_prog_id AND dzgl002 = p_prog_ver   
      AND dzgl030 = p_code_ide 
   IF l_cnt = 0 THEN    
      RETURN TRUE
   ELSE 
      RETURN FALSE
   END IF 
END FUNCTION
##150202 add -(s)

##150515 提供刪報表元件資訊的函式 No.150512-00011#1 - add (s)
################################################################################
# Descriptions...: 刪除報表元件設計資料與樣板資訊
# Memo...........: 
# Usage..........: CALL sadzp188_del_rep_data(p_prog,g_ide)
# Input parameter: p_prog           報表元件代號
#                : p_rep_ide        客製標示 c:客製，null:全部
# Return code....: boolen           
# Date & Author..: 2015/05/15
# Modify.........:
################################################################################
PUBLIC FUNCTION sadzp188_del_rep_data(p_prog,p_rep_ide)
  DEFINE p_prog       LIKE dzga_t.dzga001     #報表元件代號
  DEFINE p_rep_ide    LIKE dzga_t.dzga003     #客製標示
  DEFINE l_sql        STRING                  
  DEFINE l_gzde005    LIKE gzde_t.gzde005     #報表類別

   SELECT gzde005 INTO l_gzde005 
     FROM gzde_t
    WHERE gzde001 = p_prog 
   IF l_gzde005 IS NOT NULL THEN 
  
       IF p_rep_ide IS NOT NULL THEN 
          #刪除報表元件同客製標示下的設計資料與azzi300、azzi301
          DISPLAY "delete dzga_t"
          DELETE FROM dzga_t WHERE dzga001 = p_prog AND dzga006= p_rep_ide
          DISPLAY "delete dzgb_t"
          DELETE FROM dzgb_t WHERE dzgb001 = p_prog AND dzgb019= p_rep_ide
          DISPLAY "delete dzgc_t"
          DELETE FROM dzgc_t WHERE dzgc001 = p_prog AND dzgc009= p_rep_ide
          DISPLAY "delete dzgd_t"
          DELETE FROM dzgd_t WHERE dzgd001 = p_prog AND dzgd008= p_rep_ide
          DISPLAY "delete dzge_t"
          DELETE FROM dzge_t WHERE dzge001 = p_prog AND dzge009= p_rep_ide
          DISPLAY "delete dzgf_t"
          DELETE FROM dzgf_t WHERE dzgf001 = p_prog AND dzgf012= p_rep_ide
          DISPLAY "delete dzgg_t"
          DELETE FROM dzgg_t WHERE dzgg001 = p_prog AND dzgg017= p_rep_ide
          DISPLAY "delete dzgh_t"
          DELETE FROM dzgh_t WHERE dzgh001 = p_prog AND dzgh012= p_rep_ide
          DISPLAY "delete dzgi_t"
          DELETE FROM dzgi_t WHERE dzgi001 = p_prog AND dzgi006= p_rep_ide
          DISPLAY "delete dzgj_t"
          DELETE FROM dzgj_t WHERE dzgj001 = p_prog AND dzgj008= p_rep_ide
          DISPLAY "delete dzgl_t"
          DELETE FROM dzgl_t WHERE dzgl001 = p_prog AND dzgl030= p_rep_ide   

          #刪除報表元件樣板資料.
          DISPLAY "DELETE REPORT TEMPLATE DATA..."   

          IF l_gzde005 ='G' THEN

                DISPLAY "delete gr gzgdl_t"
                ##報表樣板說明多語言檔(GR+XtraGrid)(備份)
                LET l_sql = " DELETE FROM gzgdl_t dl WHERE EXISTS ( ",
                            " SELECT * FROM gzgd_t gd WHERE gd.gzgd000 = dl.gzgdl000 ",
                            "    AND gzgd001 = '", p_prog ,"'", " AND gzgd003 ='", p_rep_ide,"')"   
                PREPARE del_gr_gzgdl_data FROM l_sql
                EXECUTE del_gr_gzgdl_data    

                DISPLAY "delete gr gzge_t"
                ##報表樣板說明多語言檔(GR+XtraGrid)(備份)
                LET l_sql = " DELETE FROM gzge_t ge WHERE EXISTS ( ",
                            " SELECT * FROM gzgd_t gd WHERE gd.gzgd000 = ge.gzge000 ",
                            "    AND gzgd001 = '", p_prog ,"'"  , " AND gzgd003 ='", p_rep_ide,"')"    
                PREPARE del_gr_gzge_data FROM l_sql
                EXECUTE del_gr_gzge_data   

                DISPLAY "delete gzgd_t"
                DELETE FROM gzgd_t WHERE gzgd001 = p_prog  AND gzgd003 = p_rep_ide     
          ELSE 
                DISPLAY "delete xg gzgdl_t"
                ##報表樣板說明多語言檔
                LET l_sql = " DELETE FROM gzgdl_t dl WHERE EXISTS ( ",
                            " SELECT * FROM gzgf_t gf WHERE gf.gzgf000 = dl.gzgdl000 ",
                            "    AND gzgf001 = '", p_prog ,"'" , " AND gzgf003 ='", p_rep_ide,"')"     
                PREPARE del_xg_gzgdl_data FROM l_sql
                EXECUTE del_xg_gzgdl_data    

                DISPLAY "delete xg gzge_t"
                ##報表樣板說明多語言檔
                LET l_sql = " DELETE FROM gzge_t ge WHERE EXISTS ( ",
                            " SELECT * FROM gzgf_t gf WHERE gf.gzgf000 = ge.gzge000 ",
                            "    AND gzgf001 = '", p_prog ,"'" , " AND gzgf003 ='", p_rep_ide,"')"   
                PREPARE del_xg_gzge_data FROM l_sql
                EXECUTE del_xg_gzge_data  

                DISPLAY "delete xg gzgg_t"                
                ##報表樣板明細檔
                LET l_sql = " DELETE FROM gzgg_t gg WHERE EXISTS ( ",
                            " SELECT * FROM gzgf_t gf WHERE gf.gzgf000 = gg.gzgg000 ",
                            "    AND gzgf001 = '", p_prog ,"'" , " AND gzgf003 ='", p_rep_ide,"')"       
                PREPARE del_xg_gzgg_data FROM l_sql
                EXECUTE del_xg_gzgg_data                

                DISPLAY "delete gzgf_t"
                DELETE FROM gzgf_t WHERE gzgf001 = p_prog AND gzgf003 = p_rep_ide             
          END IF          
       ELSE 
       
          #刪除報表元件設計資料.
          DISPLAY "DELETE REPORT DEISGN DATA..."
          DISPLAY "delete dzga_t"
          DELETE FROM dzga_t WHERE dzga001 = p_prog
          DISPLAY "delete dzgb_t"
          DELETE FROM dzgb_t WHERE dzgb001 = p_prog
          DISPLAY "delete dzgc_t"
          DELETE FROM dzgc_t WHERE dzgc001 = p_prog
          DISPLAY "delete dzgd_t"
          DELETE FROM dzgd_t WHERE dzgd001 = p_prog
          DISPLAY "delete dzge_t"
          DELETE FROM dzge_t WHERE dzge001 = p_prog
          DISPLAY "delete dzgf_t"
          DELETE FROM dzgf_t WHERE dzgf001 = p_prog
          DISPLAY "delete dzgg_t"
          DELETE FROM dzgg_t WHERE dzgg001 = p_prog
          DISPLAY "delete dzgh_t"
          DELETE FROM dzgh_t WHERE dzgh001 = p_prog
          DISPLAY "delete dzgi_t"
          DELETE FROM dzgi_t WHERE dzgi001 = p_prog
          DISPLAY "delete dzgj_t"
          DELETE FROM dzgj_t WHERE dzgj001 = p_prog
          DISPLAY "delete dzgl_t"
          DELETE FROM dzgl_t WHERE dzgl001 = p_prog  

          #刪除報表元件樣板資料.
          DISPLAY "DELETE REPORT TEMPLATE DATA..."   

          IF l_gzde005 ='G' THEN

                DISPLAY "delete gr gzgdl_t"
                ##報表樣板說明多語言檔(GR+XtraGrid)(備份)
                LET l_sql = " DELETE FROM gzgdl_t dl WHERE EXISTS ( ",
                            " SELECT * FROM gzgd_t gd WHERE gd.gzgd000 = dl.gzgdl000 ",
                            "    AND gzgd001 = '", p_prog ,"')"    
                PREPARE del_gr_gzgdl_data_all FROM l_sql
                EXECUTE del_gr_gzgdl_data_all    

                DISPLAY "delete gr gzge_t"
                ##報表樣板說明多語言檔(GR+XtraGrid)(備份)
                LET l_sql = " DELETE FROM gzge_t ge WHERE EXISTS ( ",
                            " SELECT * FROM gzgd_t gd WHERE gd.gzgd000 = ge.gzge000 ",
                            "    AND gzgd001 = '", p_prog ,"')"    
                PREPARE del_gr_gzge_data_all FROM l_sql
                EXECUTE del_gr_gzge_data_all   

                DISPLAY "delete gzgd_t"
                DELETE FROM gzgd_t WHERE gzgd001 = p_prog       
          ELSE 
                DISPLAY "delete xg gzgdl_t"
                ##報表樣板說明多語言檔
                LET l_sql = " DELETE FROM gzgdl_t dl WHERE EXISTS ( ",
                            " SELECT * FROM gzgf_t gf WHERE gf.gzgf000 = dl.gzgdl000 ",
                            "    AND gzgf001 = '", p_prog ,"')"    
                PREPARE del_xg_gzgdl_data_all FROM l_sql
                EXECUTE del_xg_gzgdl_data_all    

                DISPLAY "delete xg gzge_t"
                ##報表樣板說明多語言檔
                LET l_sql = " DELETE FROM gzge_t ge WHERE EXISTS ( ",
                            " SELECT * FROM gzgf_t gf WHERE gf.gzgf000 = ge.gzge000 ",
                            "    AND gzgf001 = '", p_prog ,"')"    
                PREPARE del_xg_gzge_data_all FROM l_sql
                EXECUTE del_xg_gzge_data_all  

                DISPLAY "delete xg gzgg_t"
                
                ##報表樣板明細檔
                LET l_sql = " DELETE FROM gzgg_t gg WHERE EXISTS ( ",
                            " SELECT * FROM gzgf_t gf WHERE gf.gzgf000 = gg.gzgg000 ",
                            "    AND gzgf001 = '", p_prog ,"')"    
                PREPARE del_xg_gzgg_data_all FROM l_sql
                EXECUTE del_xg_gzgg_data_all                

                DISPLAY "delete gzgf_t"
                DELETE FROM gzgf_t WHERE gzgf001 = p_prog             
          END IF 
          
       END IF 
   END IF 
END FUNCTION


##150515 提供刪報表元件資訊的函式 No.150512-00011#1 - add (e)



#160615-00007 add -(s)
#PUBLIC FUNCTION sadzp188_get_subquery_sql(p_prog_id ,p_sd_ver,p_dzgb016,p_dzgb017,p_field_type)  #161031-00071#1 mark
PUBLIC FUNCTION sadzp188_get_subquery_sql(p_prog_id ,p_sd_ver,p_dzgb016,p_dzgb017,p_field_type,p_dzgb019)   #161031-00071#1 add 
  DEFINE p_prog_id   LIKE dzgb_t.dzgb001   #報表元件
  DEFINE p_sd_ver    LIKE dzgb_t.dzgb002   #報表版本 
  DEFINE p_dzgb016   LIKE dzgb_t.dzgb016   #欄位名
  DEFINE p_dzgb017   LIKE dzgb_t.dzgb017   #資料別名
  DEFINE p_field_type LIKE type_t.chr1     #欄位型態 N:一般，Y:自定義
  DEFINE l_dzgb011   LIKE dzgb_t.dzgb011   #left join sql
  DEFINE l_str       STRING
  DEFINE l_select    STRING                #組出select
  DEFINE l_rep_str   base.StringBuffer     
  DEFINE l_sub_dzgb016 STRING              #取欄位前幾碼
  DEFINE l_sql         STRING  
  DEFINE p_dzgb019   LIKE dzgb_t.dzgb019   #161031-00071#1 add   

  LET l_dzgb011 = ""
  LET l_select ="" 
  SELECT dzgb011 INTO l_dzgb011 FROM dzgb_t 
   WHERE dzgb001 = p_prog_id AND dzgb002 = p_sd_ver
     AND dzgb016 = p_dzgb016 AND dzgb017 = p_dzgb017
     AND dzgb019 = p_dzgb019                              #161031-00071#1 add 

  IF l_dzgb011 = ""  OR cl_null(l_dzgb011)THEN     
     LET l_sub_dzgb016 = p_dzgb016
     LET l_sub_dzgb016 = l_sub_dzgb016.subString(1,l_sub_dzgb016.getLength()-3)
     LET l_sql = " SELECT dzgb011 FROM dzgb_t ",
                 "  WHERE dzgb001 = '", p_prog_id ,"'", " AND dzgb002 = '",p_sd_ver ,"'",
                 #"    AND dzgb016 LIKE '",l_sub_dzgb016,"%' AND dzgb017 = '",p_dzgb017,"'"  ##161031-00071#1 mark
                 "    AND dzgb016 LIKE '",l_sub_dzgb016,"%' AND dzgb017 = '",p_dzgb017,"'",   ##161031-00071#1 add 
                 "    AND dzgb019 = '",p_dzgb019,"'"                                          ##161031-00071#1 add 
     PREPARE sadzp188_tab_get_dzgb011_pre FROM l_sql
     EXECUTE sadzp188_tab_get_dzgb011_pre INTO l_dzgb011    
  END IF    
  LET l_str = l_dzgb011
  IF l_str.getLength() > 0 THEN 
     LET l_select = sadzp188_get_handle_subquery_sql(p_dzgb016,l_dzgb011,p_field_type) 
  ELSE 
     LET l_select = "" 
  END IF

  RETURN l_select 

END FUNCTION 

PUBLIC FUNCTION sadzp188_get_handle_subquery_sql(p_dzgb016,p_dzgb011,p_field_type)
  DEFINE p_dzgb016   LIKE dzgb_t.dzgb016   #欄位名
  DEFINE p_dzgb011    LIKE dzgb_t.dzgb011  
  DEFINE p_field_type LIKE type_t.chr1     #欄位型態 N:一般，Y:自定義   
  DEFINE l_rep_str   base.StringBuffer 
  DEFINE l_str       STRING      
  DEFINE l_select    STRING                #組出select


      LET l_str = p_dzgb011
      LET l_rep_str = base.StringBuffer.create()
      LET l_str = l_str.subString(l_str.getIndexOf("LEFT OUTER JOIN",1)+15,l_str.getLength())
      LET l_select = "SELECT ",p_dzgb016, " FROM" ,l_str
      CALL l_rep_str.clear()
      CALL l_rep_str.append(l_select)
      CALL l_rep_str.replace("ON","WHERE",0)
      LET l_select = l_rep_str.toString()
      IF p_field_type = "N" THEN
         LET l_select = "( ",l_select,")"
      END IF   

      RETURN l_select
END FUNCTION 

PUBLIC FUNCTION sadzp188_get_jointable_key(p_dzgb005,p_dzgb013,p_dzgb014,p_dzgb015)
  DEFINE p_dzgb005      LIKE dzgb_t.dzgb005  #主表(單頭/單身)
  DEFINE p_dzgb013      LIKE dzgb_t.dzgb013  #單頭/身欄位
  DEFINE p_dzgb014      LIKE dzgb_t.dzgb014  #關連資料表
  DEFINE p_dzgb015      LIKE dzgb_t.dzgb015  #關連欄位
  DEFINE p_dzgb017      LIKE dzgb_t.dzgb017  #關連資料表別名
  DEFINE l_pk_field     STRING
  DEFINE l_main_key     DYNAMIC ARRAY OF STRING 
  DEFINE l_token        base.StringTokenizer
  DEFINE li_cnt         LIKE type_t.num10
  DEFINE ls_pkcol       STRING
  DEFINE ls_dzgb015     LIKE dzgb_t.dzgb015
  DEFINE ls_dzgb013     LIKE dzgb_t.dzgb013 
  DEFINE ls_result      BOOLEAN
  DEFINE ls_m_field     STRING               #主報表相對欄位
  DEFINE l_found        BOOLEAN              #找到否


  ##先將原來的key值存入陣列
  LET li_cnt = 1
  CALL l_main_key.clear()
  LET l_token = base.StringTokenizer.create(p_dzgb015, ",")
  WHILE l_token.hasMoreTokens()
     LET ls_pkcol = l_token.nextToken()
     LET l_main_key[li_cnt] = ls_pkcol
     LET li_cnt = li_cnt + 1
  END WHILE  
  LET ls_dzgb015 = p_dzgb015
  LET ls_dzgb013 = p_dzgb013
  
  ##取出關連TABLE的PK值
  CALL sadzp030_tab_relation_pk(p_dzgb014) RETURNING l_pk_field


  LET li_cnt = 1
  LET l_token = base.StringTokenizer.create(l_pk_field, ",")
  WHILE l_token.hasMoreTokens()
     LET l_found = 0
     LET ls_pkcol = l_token.nextToken()
     FOR li_cnt = 1 TO l_main_key.getLength()
           IF ls_pkcol = l_main_key[li_cnt] THEN              
              LET l_found = 1
           END IF
     END FOR    
     IF l_found = 0 AND ls_pkcol.getIndexOf("site",1) > 0 THEN  #找不到
         CALL sadzp188_tab_chk_gztz_filed_exist(p_dzgb005,ls_pkcol,p_dzgb014) RETURNING ls_result,ls_m_field
         IF ls_result THEN   
            DISPLAY "Add site:",ls_pkcol,"  ls_m_field",ls_m_field          
            LET ls_dzgb015 = ls_dzgb015,",",ls_pkcol
            LET ls_dzgb013 = ls_dzgb013,",",ls_m_field
         END IF 
     END IF 
  END WHILE
  

  RETURN  ls_dzgb013,ls_dzgb015
 
END FUNCTION 


PUBLIC FUNCTION sadzp188_tab_chk_gztz_filed_exist(p_dzgb005,p_field,p_dzgb014)
  DEFINE  p_dzgb005      LIKE dzgb_t.dzgb005  #主資料表
  DEFINE  p_dzgb014      LIKE dzgb_t.dzgb014  #關連資料表
  DEFINE  p_field        STRING               
  DEFINE  ls_str         STRING               #關連資料表前名
  DEFINE  ls_str1        STRING               #主資料表前名
  DEFINE  ls_buf_str     base.StringBuffer   
  DEFINE  ls_m_field     LIKE gztz_t.gztz002 
  DEFINE  l_cnt          INTEGER 
  DEFINE  ls_result      BOOLEAN 

  #取出關連表_t前的表名ex：inaal_t->inaal
  LET ls_str = p_dzgb014
  LET ls_str = ls_str.subString(1,ls_str.getIndexOf("_",1)-1)
  LET ls_str1 = p_dzgb005
  LET ls_str1 = ls_str1.subString(1,ls_str1.getIndexOf("_",1)-1)  
  LET ls_buf_str = base.StringBuffer.create()
  CALL ls_buf_str.clear()
  CALL ls_buf_str.append(p_field)
  #置換成主報表的欄位
  CALL ls_buf_str.replace(ls_str,ls_str1,0)
  LET ls_m_field = ls_buf_str.toString() 

  
  #尋找主表是否有此欄位
   LET ls_result = FALSE
   LET l_cnt = 0
   SELECT COUNT(1) INTO l_cnt FROM gztz_t 
    WHERE gztz001 = p_dzgb005 AND gztz002 = ls_m_field
   IF l_cnt > 0 THEN
      LET ls_result = TRUE
   END IF   

   RETURN ls_result,ls_m_field
END FUNCTION 


##複製報表元件時，也要複製原報表元件的azzi300/azzi301
FUNCTION sadzp188_copy_azzi300301(p_prog,ls_gzgd003,p_prog_type,p_prog_s,ls_gzgd003_s)
  DEFINE p_prog         LIKE gzgd_t.gzgd001  #目的報表元件
  DEFINE ls_gzgd003     LIKE dzgd_t.dzgd003  #目的
  DEFINE p_prog_type    LIKE gzde_t.gzde005  #G/X  
  DEFINE p_prog_s       LIKE gzgd_t.gzgd001  #來源報表元件
  DEFINE ls_gzgd003_s   LIKE dzgd_t.dzgd003  #來源
  DEFINE l_cnt          LIKE type_t.num10
  DEFINE l_i            LIKE type_t.num10
  DEFINE l_gzgd         DYNAMIC ARRAY OF RECORD LIKE gzgd_t.* #GR報表樣板主檔
  DEFINE l_gzgdl        DYNAMIC ARRAY OF RECORD LIKE gzgdl_t.*#報表樣板說明多語言檔(GR+XtraGrid)
  DEFINE l_gzge         DYNAMIC ARRAY OF RECORD LIKE gzge_t.* #報表樣板多語言紀錄檔(GR+XtraGrid)
  DEFINE l_gzgf         DYNAMIC ARRAY OF RECORD LIKE gzgf_t.* #XtraGrid報表樣板主檔
  DEFINE l_gzgg         DYNAMIC ARRAY OF RECORD LIKE gzgg_t.* #XtraGrid報表樣板明細檔 
  DEFINE l_gzgd000      LIKE gzgd_t.gzgd000 
  DEFINE l_gzgd000_t    LIKE gzgd_t.gzgd000
  DEFINE lb_result      BOOLEAN 
  DEFINE l_j            LIKE type_t.num10 
  DEFINE l_gzgf000      LIKE gzgf_t.gzgf000
  DEFINE l_gzgf000_t    LIKE gzgf_t.gzgf000
  DEFINE l_sql          STRING 
  DEFINE l_str          STRING
  DEFINE l_str_buf      base.StringBuffer 
  
     IF p_prog_type ="G" THEN

  
             LET l_cnt = 0       
             SELECT COUNT(gzgd000) INTO l_cnt FROM gzgd_t 
              WHERE gzgdstus = 'Y'    
                AND gzgd001 = p_prog
                AND gzgd003 = ls_gzgd003
                AND gzgd004 = 'default'
                AND gzgd005 = 'default' 
             IF l_cnt > 0 THEN 
                DISPLAY "delete gr gzgdl_t"
                ##報表樣板說明多語言檔(GR+XtraGrid)(備份)
                LET l_sql = " DELETE FROM gzgdl_t dl WHERE EXISTS ( ",
                            " SELECT * FROM gzgd_t gd WHERE gd.gzgd000 = dl.gzgdl000 ",
                            "    AND gzgd001 = '", p_prog ,"'", " AND gzgd003 ='", ls_gzgd003,"')"   
                PREPARE del_gr_gzgdl_data_cs FROM l_sql
                EXECUTE del_gr_gzgdl_data_cs    

                DISPLAY "delete gr gzge_t"
                ##報表樣板說明多語言檔(GR+XtraGrid)(備份)
                LET l_sql = " DELETE FROM gzge_t ge WHERE EXISTS ( ",
                            " SELECT * FROM gzgd_t gd WHERE gd.gzgd000 = ge.gzge000 ",
                            "    AND gzgd001 = '", p_prog ,"'"  , " AND gzgd003 ='", ls_gzgd003,"')"    
                PREPARE del_gr_gzge_data_cs FROM l_sql
                EXECUTE del_gr_gzge_data_cs

                DISPLAY "delete gzgd_t"
                DELETE FROM gzgd_t 
                  WHERE gzgdstus = 'Y'    
                    AND gzgd001 = p_prog
                    AND gzgd003 = ls_gzgd003
                    AND gzgd004 = 'default'
                    AND gzgd005 = 'default'                
             END IF    

                DECLARE sadzp188_cp_gzgd_cs CURSOR FOR
                 SELECT * FROM gzgd_t 
                  WHERE gzgdstus = 'Y'    
                    AND gzgd001 = p_prog_s
                    AND gzgd003 = ls_gzgd003_s
                    AND gzgd004 = 'default'
                    AND gzgd005 = 'default' 
                LET l_i = 1
                CALL l_gzgd.clear()
                LET l_gzgd000 =''
                FOREACH sadzp188_cp_gzgd_cs INTO l_gzgd[l_i].* 
                   CALL security.RandomGenerator.CreateUUIDString() RETURNING l_gzgd000
                   LET l_gzgd000_t = ''
                   LET l_gzgd000_t = l_gzgd[l_i].gzgd000
                   LET l_gzgd[l_i].gzgd000 = l_gzgd000 
                   LET l_gzgd[l_i].gzgd001 = p_prog 
                   #置換樣板代號
                   LET l_str = ""
                   LET l_str_buf = base.StringBuffer.create()
                   CALL l_str_buf.append(l_gzgd[l_i].gzgd002)
                   CALL l_str_buf.replace(p_prog_s,p_prog,1)
                   LET l_str = l_str_buf.toString() 
                   LET l_gzgd[l_i].gzgd002 = l_str 
                   LET l_gzgd[l_i].gzgd003 = ls_gzgd003 
                   #置換4RP樣板名稱
                   LET l_str = ""
                   LET l_str_buf = base.StringBuffer.create()
                   CALL l_str_buf.append(l_gzgd[l_i].gzgd007)
                   CALL l_str_buf.replace(p_prog_s,p_prog,1)
                   LET l_str = l_str_buf.toString() 
                   LET l_gzgd[l_i].gzgd007 = l_str                    
                   LET l_gzgd[l_i].gzgdownid = g_user
                   LET l_gzgd[l_i].gzgdowndp = g_dept
                   LET l_gzgd[l_i].gzgdcrtid = g_user
                   LET l_gzgd[l_i].gzgdcrtdp = g_dept
                   LET l_gzgd[l_i].gzgdcrtdt = cl_get_current()
                   INSERT INTO gzgd_t VALUES(l_gzgd[l_i].*) 
                   IF STATUS THEN
                      DISPLAY "copy insert gzgd" 
          
                   END IF 

                   #dzgdl_t   
                   LET l_cnt = 0
                   SELECT COUNT(gzgdl000) INTO l_cnt FROM gzgdl_t 
                    WHERE gzgdl000 = l_gzgd000
                   IF l_cnt =0 THEN 

                      DECLARE sadzp188_copy_gzgdl_cs CURSOR FOR
                       SELECT * FROM gzgdl_t 
                        WHERE gzgdl000 = l_gzgd000_t  
        
                      LET l_j = 1
                      CALL l_gzgdl.clear()
                      FOREACH sadzp188_copy_gzgdl_cs INTO l_gzgdl[l_j].*                       
                         LET l_gzgdl[l_j].gzgdl000 = l_gzgd000 
                         INSERT INTO gzgdl_t VALUES(l_gzgdl[l_j].*) 
                         IF STATUS THEN
                            DISPLAY "copy insert gzgdl" 
        
                         END IF                       
                         LET l_j = l_j + 1                               
                      END FOREACH 

                   END IF 
                   
                   #dzge_t   
                   LET l_cnt = 0
                   SELECT COUNT(gzge000) INTO l_cnt FROM gzge_t 
                    WHERE gzge000 = l_gzgd000
                   IF l_cnt = 0 THEN 

                      DECLARE sadzp188_copy_gzge_cs CURSOR FOR
                       SELECT * FROM gzge_t 
                        WHERE gzge000 = l_gzgd000_t  
        
                      LET l_j = 1
                      CALL l_gzge.clear()
                      FOREACH sadzp188_copy_gzge_cs INTO l_gzge[l_j].*                       
                         LET l_gzge[l_j].gzge000 = l_gzgd000 
                         INSERT INTO gzge_t VALUES(l_gzge[l_j].*) 
                         IF STATUS THEN
                            DISPLAY "copy insert gzge" 
           
                         END IF                       
                         LET l_j = l_j + 1                               
                      END FOREACH 

                   END IF                 
                   LET l_i = l_i + 1                               
                END FOREACH 


       ELSE           
           LET l_cnt = 0        
            SELECT COUNT(gzgf000) INTO l_cnt FROM gzgf_t 
             WHERE gzgfstus = 'Y'    
               AND gzgf001 = p_prog
               AND gzgf002 = p_prog   
               AND gzgf003 = ls_gzgd003
               AND gzgf004 = 'default'
               AND gzgf005 = 'default' 
           IF l_cnt > 0 THEN

                DISPLAY "delete xg gzgdl_t"
                ##報表樣板說明多語言檔
                LET l_sql = " DELETE FROM gzgdl_t dl WHERE EXISTS ( ",
                            " SELECT * FROM gzgf_t gf WHERE gf.gzgf000 = dl.gzgdl000 ",
                            "    AND gzgf001 = '", p_prog ,"'" , " AND gzgf003 ='", ls_gzgd003,"')"     
                PREPARE del_xg_gzgdl_data_cs FROM l_sql
                EXECUTE del_xg_gzgdl_data_cs    

                DISPLAY "delete xg gzge_t"
                ##報表樣板說明多語言檔
                LET l_sql = " DELETE FROM gzge_t ge WHERE EXISTS ( ",
                            " SELECT * FROM gzgf_t gf WHERE gf.gzgf000 = ge.gzge000 ",
                            "    AND gzgf001 = '", p_prog ,"'" , " AND gzgf003 ='", ls_gzgd003,"')"   
                PREPARE del_xg_gzge_data_cs FROM l_sql
                EXECUTE del_xg_gzge_data_cs  

                DISPLAY "delete xg gzgg_t"                
                ##報表樣板明細檔
                LET l_sql = " DELETE FROM gzgg_t gg WHERE EXISTS ( ",
                            " SELECT * FROM gzgf_t gf WHERE gf.gzgf000 = gg.gzgg000 ",
                            "    AND gzgf001 = '", p_prog ,"'" , " AND gzgf003 ='", ls_gzgd003,"')"       
                PREPARE del_xg_gzgg_data_cs FROM l_sql
                EXECUTE del_xg_gzgg_data_cs                

                DISPLAY "delete gzgf_t"
                DELETE FROM gzgf_t 
                 WHERE gzgfstus = 'Y'    
                   AND gzgf001 = p_prog
                   AND gzgf002 = p_prog   
                   AND gzgf003 = ls_gzgd003
                   AND gzgf004 = 'default'
                   AND gzgf005 = 'default' 
           END IF


               DECLARE sadzp188_cp_gzgf_cs CURSOR FOR
                SELECT * FROM gzgf_t 
                 WHERE gzgfstus = 'Y'    
                   AND gzgf001 = p_prog_s
                   AND gzgf003 = ls_gzgd003_s
                   AND gzgf004 = 'default'
                   AND gzgf005 = 'default' 
               LET l_i = 1
               CALL l_gzgf.clear()
               LET l_gzgf000 =''
               FOREACH sadzp188_cp_gzgf_cs INTO l_gzgf[l_i].* 
                  CALL security.RandomGenerator.CreateUUIDString() RETURNING l_gzgf000
                  LET l_gzgf000_t =''
                  LET l_gzgf000_t = l_gzgf[l_i].gzgf000
                  LET l_gzgf[l_i].gzgf000 = l_gzgf000 
                  LET l_gzgf[l_i].gzgf001 = p_prog
                  #置換樣板名稱
                  LET l_str = ""
                  LET l_str_buf = base.StringBuffer.create()
                  CALL l_str_buf.append(l_gzgf[l_i].gzgf002)
                  CALL l_str_buf.replace(p_prog_s,p_prog,1)
                  LET l_str = l_str_buf.toString()                   
                  LET l_gzgf[l_i].gzgf002 = l_str
                  LET l_gzgf[l_i].gzgf003 = ls_gzgd003 
                  LET l_gzgf[l_i].gzgfownid = g_user
                  LET l_gzgf[l_i].gzgfowndp = g_dept
                  LET l_gzgf[l_i].gzgfcrtid = g_user
                  LET l_gzgf[l_i].gzgfcrtid = g_dept
                  LET l_gzgf[l_i].gzgfcrtdt = cl_get_current()
                  INSERT INTO gzgf_t VALUES(l_gzgf[l_i].*) 
                  IF STATUS THEN
                     DISPLAY "copy insert gzgf" 
         
                  END IF 

                  ##gzgg_t          
                  SELECT COUNT(gzgg000) INTO l_cnt FROM gzgg_t 
                   WHERE gzgg000 = l_gzgf000   
                  IF l_cnt = 0 THEN 

                     DECLARE sadzp188_cp_gzgg_cs CURSOR FOR
                      SELECT * FROM gzgg_t 
                       WHERE gzgg000 = l_gzgf000_t    

                     LET l_j = 1
                     CALL l_gzgg.clear()
                     FOREACH sadzp188_cp_gzgg_cs INTO l_gzgg[l_j].*                       
                        LET l_gzgg[l_j].gzgg000 = l_gzgf000 
                        INSERT INTO gzgg_t VALUES(l_gzgg[l_j].*) 
                        IF STATUS THEN
                           DISPLAY "copy insert gzgg"                       
          
                        END IF                       
                        LET l_j = l_j + 1                               
                     END FOREACH 
                  END IF

                  LET l_cnt = 0
                  SELECT COUNT(gzge000) INTO l_cnt FROM gzge_t 
                   WHERE gzge000 = l_gzgf000
                  IF l_cnt = 0 THEN 

                     DECLARE sadzp188_cp_gzge_cs1 CURSOR FOR
                      SELECT * FROM gzge_t 
                       WHERE gzge000 = l_gzgf000_t  
           
                     LET l_j = 1
                     CALL l_gzge.clear()
                     FOREACH sadzp188_cp_gzge_cs1 INTO l_gzge[l_j].*                       
                        LET l_gzge[l_j].gzge000 = l_gzgf000 
                        INSERT INTO gzge_t VALUES(l_gzge[l_j].*) 
                        IF STATUS THEN
                           DISPLAY "copy insert gzge"               
           
                        END IF                       
                        LET l_j = l_j + 1                               
                     END FOREACH 

                  END IF  

                  LET l_cnt = 0
                  SELECT COUNT(gzgdl000) INTO l_cnt FROM gzgdl_t 
                   WHERE gzgdl000 = l_gzgf000
                  IF l_cnt = 0 THEN 

                     DECLARE sadzp188_cp_gzgdl_cs1 CURSOR FOR
                      SELECT * FROM gzgdl_t 
                       WHERE gzgdl000 = l_gzgf000_t  
           
                     LET l_j = 1
                     CALL l_gzgdl.clear()
                     FOREACH sadzp188_cp_gzgdl_cs1 INTO l_gzgdl[l_j].*                       
                        LET l_gzgdl[l_j].gzgdl000 = l_gzgf000 
                        INSERT INTO gzgdl_t VALUES(l_gzgdl[l_j].*) 
                        IF STATUS THEN
                           DISPLAY "copy insert gzgdl"                     
         
                        END IF                       
                        LET l_j = l_j + 1                               
                     END FOREACH 

                  END IF                              
                  LET l_i = l_i + 1                               
               END FOREACH                

      END IF 
      


END FUNCTION 


#160615-00007 add -(e)