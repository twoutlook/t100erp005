#+ Version..: T6-ERP-1.00.00 Build-00001
#+
#+ Filename.: adzp180
#+ Buildtype: 
#+ Memo.....: 讀取tgl分析add-point 置換內容
#+            add-point的取用, 以dzba為準 -> 由dzba取出 add-point id/應搭版本/個案碼
#+            但若取得的 dzbb005 標示為引用(Y), 則去取 "標準程式" 的同id/版本/個案碼
#+            引用進來

#20160623 ka0132 不對other function排除特定字元

IMPORT os
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"

DEFINE ms_module        STRING               #模組編號
DEFINE ms_prog          STRING               #程式編號
DEFINE ms_ver           STRING               #程式版本
DEFINE ms_dgenv         LIKE dzaa_t.dzaa009  #區域 (識別標示)
DEFINE ms_wmode         STRING               
#DEFINE ms_erp_ver       LIKE dzaa_t.dzaa008  #產品版本
#DEFINE ms_cust          LIKE dzaa_t.dzaa010  #客戶編號
DEFINE g_mark           BOOLEAN
DEFINE ms_filename      STRING               #產生4gl檔案名稱
DEFINE gb_oth_func      BOOLEAN #20160623
DEFINE gs_oth_func      BOOLEAN #20160623
DEFINE gs_dzbb098       LIKE dzbb_t.dzbb098

MAIN
   DEFINE ls_sql        STRING
   DEFINE ls_gzza001    LIKE gzza_t.gzza001
   DEFINE ls_gzza007    LIKE gzza_t.gzza007

   DISPLAY "開始產生tgl檔案, adzp180開始運作時間:",CURRENT #cl_get_current()
   
   LOCATE gs_dzbb098 IN FILE 
   
   CALL cl_tool_init()

   #取得目前的環境代碼
   LET ms_module  = ARG_VAL(1) CLIPPED    #模組編號
   LET ms_prog    = ARG_VAL(2) CLIPPED    #程式編號
   LET ms_ver     = ARG_VAL(3) CLIPPED    #程式版次
   LET ms_dgenv   = ARG_VAL(4) CLIPPED    #區域(識別標示)
#  LET ms_erp_ver = FGL_GETENV("ERPVER")  #產品版本
#  LET ms_cust    = FGL_GETENV("CUST")    #客戶編號
   LET ms_wmode   = ARG_VAL(5)            #產出類型
   IF cl_null(ms_wmode) THEN              #  類型1:標準產出
      LET ms_wmode = '1'                  #  類型2:來源2產生2
   END IF                                 #  adzp151用環境變數 GEN_MODE
   
   #子畫面不做處理
   IF cl_chk_spec_type(ARG_VAL(2)) = "F" THEN
      EXIT PROGRAM
   END IF

   IF ms_prog.getLength() = 0 THEN
      DISPLAY "Error: Program ID is NULL."
      EXIT PROGRAM
   END IF
   
   #確定是否調整過section
   CALL adzp180_chk_section()

   IF ms_ver.getLength() = 0 THEN 
      DISPLAY "WARNING: 程式版次無法取得,指定為1"
      LET ms_ver = "1"
   END IF
   DISPLAY "INFO: 程式:",ms_prog CLIPPED," 目標程式版次:",ms_ver

   #判斷是否產生
   LET ls_gzza001 = ms_prog 

                      #設計點版次004/使用標示005/代碼引用否007/硬結構是否mark009
   LET ls_sql = " SELECT dzba004,dzba005,dzba007,dzba009 FROM dzba_t ",
                 " WHERE dzba001 = '",ms_prog.trim(),"' ",      #程式編號
                   " AND dzba002 = '",ms_ver.trim(),"' ",       #程式版次
                   " AND dzba003 = ? ",                         #add-point編號
#                  " AND dzba008 = '",ms_erp_ver CLIPPED,"' ",  #產品版本
                   " AND dzba010 = '",ms_dgenv CLIPPED,"' ",    #區域(識別標示)
#                  " AND dzba011 = '",ms_cust CLIPPED,"' ",     #客戶編號
                   " AND dzbastus = 'Y' "                       #只取有效的部分
   PREPARE s1 FROM ls_sql

   CALL adzp180_read_and_replace()
   FREE s1

   #將程式版次記錄起來
   CALL adzp180_log()

   DISPLAY "adzp180結束運作時間:",CURRENT #cl_get_current()

END MAIN
 
 
#+ 程式讀取/程式寫出(一進一出) 
PUBLIC FUNCTION adzp180_read_and_replace()
 
   DEFINE lchannel_read         base.Channel
   DEFINE lchannel_write        base.Channel
   DEFINE ls_readline           STRING
   DEFINE ls_text               STRING
   DEFINE ls_code_filename      STRING
   DEFINE ls_sample_filename    STRING
   DEFINE ls_mark               STRING
   DEFINE ls_path               STRING
   DEFINE ls_prog               STRING
   DEFINE lc_markcode           LIKE dzba_t.dzba009 #本段程式碼關閉
   DEFINE li_mark               LIKE type_t.num5    #是否再add-point內准許mark
   DEFINE ls_sql                STRING
   DEFINE lc_modid              LIKE gzza_t.gzzamodid
   DEFINE lc_moddt              LIKE gzza_t.gzzamoddt
   DEFINE lc_cusid              LIKE gzza_t.gzzamodid   #客製的id
   DEFINE lc_cusdt              LIKE gzza_t.gzzamoddt   #客製的dt
   DEFINE ls_prog_name          STRING
   DEFINE li_ver                LIKE type_t.num5
   DEFINE lc_dzba001            LIKE dzba_t.dzba001
   DEFINE lc_dzba002            LIKE dzba_t.dzba002
 
   LET lchannel_read = base.Channel.create()
   LET lchannel_write = base.Channel.create()
 
   CALL lchannel_read.setDelimiter("")
   CALL lchannel_write.setDelimiter("")
 
   #判斷程式類型
   LET ls_prog = ARG_VAL(2)
   LET ls_path = sadzp030_tab_file_module(ls_prog,"A",ms_dgenv)
 
   #定義寫入檔案  $ERP/Module/4gl/xxxxx.4gl
   LET ls_sample_filename = os.Path.join(ls_path,"4gl")
   LET ls_prog_name = ms_prog,".4gl"
   IF ms_wmode = '2' THEN
      LET ls_prog_name = ls_prog_name,'2'
   END IF

   #外串影響產出程式名稱處
  #IF FGL_GETENV("GEN_MODE") = "diff" THEN
   CASE
      WHEN FGL_GETENV("GEN_MODE") = "diff" 
         LET ls_prog_name = ms_prog,".4gl.ver",ms_ver USING "<<<<<",".",ms_dgenv
      WHEN FGL_GETENV("GEN_MODE") = "chk_vied" 
         LET ls_prog_name = ms_prog,".4gl.diff",ms_ver USING "<<<<<",".",ms_dgenv
      OTHERWISE   #ELSE
         LET ls_prog_name = ms_prog,".4gl"
   END CASE
  #END IF

   LET ls_code_filename = os.Path.join(ls_sample_filename,ls_prog_name)
   LET ms_filename = ls_code_filename               #產生4gl檔案名稱

   #定義要讀取的 tgl 檔案  $ERP/Module/dzx/tgl/xxxxxx.tgl 
   LET ls_sample_filename = os.Path.join(ls_path,"dzx")
   LET ls_sample_filename = os.Path.join(ls_sample_filename,"tgl")
   LET ls_prog_name = ms_prog,".tgl"
   IF ms_wmode = '2' THEN
      LET ls_prog_name = ls_prog_name,'2'
   END IF

   #外串影響讀取tgl程式名稱處
  #IF FGL_GETENV("GEN_MODE") = "diff" THEN
   CASE
      WHEN FGL_GETENV("GEN_MODE") = "diff" 
         LET ls_prog_name = ms_prog,".tgl.ver",ms_ver USING "<<<<<",".",ms_dgenv
      WHEN FGL_GETENV("GEN_MODE") = "chk_vied" 
         LET ls_prog_name = ms_prog,".tgl"
      OTHERWISE  #ELSE
         LET ls_prog_name = ms_prog,".tgl"
   END CASE
  #END IF

   LET ls_sample_filename = os.Path.join(ls_sample_filename,ls_prog_name)

   #檢查來源
   IF NOT os.Path.exists(ls_sample_filename) THEN
      DISPLAY cl_getmsg_parm("adz-01143",g_lang,ls_sample_filename.trim())
     #DISPLAY "Error: 來源檔案:",ls_sample_filename.trim()," 不存在!"
      EXIT PROGRAM
   ELSE
      DISPLAY "INFO: 來源檔:",ls_sample_filename
      CALL lchannel_read.openFile( ls_sample_filename CLIPPED, "r" )
   END IF

   #先行移除4gl
   IF os.Path.delete(ls_code_filename) THEN
      DISPLAY "INFO: 刪除舊檔案:",ls_code_filename
   END IF

   #判斷是否砍除成功
   IF NOT os.Path.exists(ls_code_filename) THEN
   ELSE
      DISPLAY cl_getmsg("adz-01144",g_lang),ls_code_filename
     #DISPLAY "Error: 舊檔案刪除失敗:",ls_code_filename
      EXIT PROGRAM
   END IF

   DISPLAY "INFO: 目的檔:",ls_code_filename
   CALL lchannel_write.openFile( ls_code_filename CLIPPED, "w" )

   #事先準備資料: 最後修改人與修改日期
   LET ls_sql = "SELECT dzbamodid,dzbamoddt FROM dzba_t ",
                " WHERE dzba001 = '",ms_prog.trim(),"' ",      #程式編號
                  " AND dzba002 = ? ",                         #程式版次
                  " AND dzba010 = ? ",                         #區域(識別標示)
                  " AND dzbastus = 'Y' ",                      #只取有效的部分
                  " AND dzbamodid IS NOT NULL ",
                  " AND dzbamoddt IS NOT NULL ",
                " ORDER BY dzbamoddt DESC "
   DECLARE adzp180_readline_modid_cs CURSOR FROM ls_sql

   IF ms_dgenv = "c" THEN
      #標準的時間
      LET lc_dzba001 = ms_prog.trim()
      SELECT MAX(dzba002) INTO lc_dzba002 FROM dzba_t
       WHERE dzba001 = lc_dzba001 AND dzba010 = "s"
      FOREACH adzp180_readline_modid_cs USING lc_dzba002,"s" INTO lc_modid,lc_moddt
         EXIT FOREACH
      END FOREACH
      IF lc_modid IS NULL THEN LET lc_modid = "00000" END IF
      IF lc_moddt IS NULL THEN LET lc_moddt = "1900-01-01 00:00:00" END IF

      #客製的時間
      LET lc_dzba002 = ms_ver.trim()
      FOREACH adzp180_readline_modid_cs USING lc_dzba002,ms_dgenv INTO lc_cusid,lc_cusdt
         EXIT FOREACH
      END FOREACH
      IF lc_cusid IS NULL THEN LET lc_cusid = "00000" END IF
      IF lc_cusdt IS NULL THEN LET lc_cusdt = "1900-01-01 00:00:00" END IF
   ELSE
      #標準的時間
      LET lc_dzba002 = ms_ver.trim()
      FOREACH adzp180_readline_modid_cs USING lc_dzba002,"s" INTO lc_modid,lc_moddt
         EXIT FOREACH
      END FOREACH
      IF lc_modid IS NULL THEN LET lc_modid = "00000" END IF
      IF lc_moddt IS NULL THEN LET lc_moddt = "1900-01-01 00:00:00" END IF

      #客製的時間
      LET lc_cusdt = "1900-01-01 00:00:00"
   END IF
   FREE adzp180_readline_modid_cs

   #讀取及轉換
   LET gb_oth_func = FALSE #21060623 
   WHILE TRUE
      LET ls_text = ""
      LET ls_readline = lchannel_read.readLine()
      IF lchannel_read.isEof() THEN
         EXIT WHILE
      END IF

      #紀錄標準更新人資料
      IF ls_readline.getIndexOf("#+ Standard Version.....:",1) AND ls_readline.getIndexOf("PR版次:",1) THEN
         IF ms_dgenv = "c" THEN
            LET li_ver = lc_dzba002
         ELSE
            LET li_ver = ms_ver
         END IF
         LET ls_text = ls_readline,li_ver USING"&&&&","(",lc_moddt,")"
      END IF

      #紀錄客製更新人資料
      IF ls_readline.getIndexOf("#+ Customerized Version.:",1) AND ls_readline.getIndexOf("PR版次:",1) THEN
         IF ms_dgenv = "c" THEN
            LET li_ver = ms_ver
         ELSE
            LET li_ver = "0"
         END IF
         LET ls_text = ls_readline,li_ver USING"&&&&","(",lc_cusdt,")"
      END IF

      #紀錄更新人資料
      IF ls_readline.getIndexOf("#+ Modifier...: ",1) AND ls_readline.getIndexOf("-SD/PR-",1) THEN
         LET ls_text = ls_readline," ",lc_modid CLIPPED
      END IF
      
      #取得controlp tag
      IF ls_readline.getIndexOf("#Ctrlp:",1) THEN
         LET ls_mark = adzp180_ctrlp_mark(ls_readline)
         LET ls_readline = ls_readline, '\n', ls_mark, lchannel_read.readLine()
      END IF

      #對 add-point 置換
      IF ls_readline.getIndexOf("{<point",1) AND
         ( ls_readline.getIndexOf("{<point",1) < ls_readline.getIndexOf(">}",1) ) THEN
         #檢查此add-point標記有無 mark="Y"
         IF ls_readline.getIndexOf('mark="Y"',1) THEN
            LET li_mark = TRUE
         ELSE
            LET li_mark = FALSE
         END IF
         CALL adzp180_line_replace(ls_readline) RETURNING ls_text,lc_markcode
      END IF
 
      #一般未進行任何處理段落產出
      IF ls_text IS NULL THEN
         #有此標記者,到下一個add-point區間的程式碼要加上 #號
         IF li_mark AND lc_markcode="Y" THEN
            LET ls_text = "#",ls_readline
         ELSE
            LET ls_text = ls_readline
         END IF
      END IF

      #20160623
      #ls_text濾除 add point 的tag
      IF NOT gb_oth_func THEN
         LET ls_text = adzp180_remove_adp_tag(ls_text)
      END IF

      CALL lchannel_write.write(ls_text)
   END WHILE
   
   CALL lchannel_read.close()
   CALL lchannel_write.close()
   
   DISPLAY "INFO: ",ls_code_filename,"產生成功!"
   
   #對產生器寫出的檔案權限在UNIX下均全部打開
   IF os.Path.separator() = "/" THEN
      IF os.Path.chrwx(ls_code_filename,511) THEN
      END IF
   END IF
   
END FUNCTION

#+ 濾除原檔案內的add-point tag
PRIVATE FUNCTION adzp180_remove_adp_tag(ls_text)
   DEFINE ls_text   STRING
   DEFINE li_pos    LIKE type_t.num5
   DEFINE ls_right,ls_left  STRING

   LET ls_right = ""
   LET ls_left = ""

   LET li_pos = ls_text.getIndexOf("{<point",1) 
   IF li_pos > 0 AND ( li_pos < ls_text.getIndexOf(">}",1) ) THEN
      IF li_pos > 1 THEN
         LET ls_left = ls_text.subString(1,li_pos-1)
      END IF
      IF ls_text.getLength() > ls_text.getIndexOf(">}",1) + 2 THEN
         LET ls_right = ls_text.subString(ls_text.getIndexOf(">}",1)+2,ls_text.getLength())
      END IF
      LET ls_text = ls_left,ls_right
   END IF
   RETURN ls_text
END FUNCTION
 
#+ 從db內把資料讀出來
PRIVATE FUNCTION adzp180_line_replace(ls_readline)
 
   DEFINE ls_readline    STRING
   DEFINE lc_dzba007     LIKE dzba_t.dzba007  #代碼引用否
   DEFINE lc_dzba009     LIKE dzba_t.dzba009  #下方硬結構註解
   DEFINE lc_dzbb        RECORD 
      dzbb001 LIKE dzbb_t.dzbb001,   #規格編號
      dzbb002 LIKE dzbb_t.dzbb002,   #add-point編號
      dzbb003 LIKE dzbb_t.dzbb003,   #版次
      dzbb004 LIKE dzbb_t.dzbb004,   #使用標示
      dzbb005 LIKE dzbb_t.dzbb005,   #是否引用標準程式
      dzbb098 LIKE dzbb_t.dzbb098    #內容資料
   END RECORD      
   DEFINE li_start        LIKE type_t.num5
   DEFINE li_end          LIKE type_t.num5
   DEFINE ls_return       STRING
   DEFINE ls_return_cite  STRING
   DEFINE ls_dgenv        STRING
   DEFINE ls_temp         STRING
 
   LET lc_dzbb.dzbb001 = ms_prog
   
   #取出 Add-point name (dzbb002)
   IF ls_readline.getIndexOf("name=",1) THEN
      LET li_start = ls_readline.getIndexOf("name=",1)+6   #+6是移動到名稱處
      LET li_end = ls_readline.getIndexOf('"',li_start)-1  #預設是雙引號 (前一碼處)
      IF li_start <> 0 AND li_end <> 0 AND li_start < li_end THEN
         LET lc_dzbb.dzbb002 = ls_readline.subString(li_start,li_end)
      ELSE
         DISPLAY cl_getmsg("adz-01141",g_lang),ls_readline
        #DISPLAY "Error: point指標內部未依規範撰寫:",ls_readline
      END IF
   ELSE
      DISPLAY cl_getmsg("adz-01142",g_lang),ls_readline
     #DISPLAY "Error: point指標Error! ",ls_readline
   END IF

   #確認point編號是否含有 _customerization
   LET ls_temp = lc_dzbb.dzbb002
   IF ls_temp.getIndexOf("_customerization",1) THEN
      IF FGL_GETENV("DGENV") = "s" AND NOT FGL_GETENV("LOGNAME") = "topstd" THEN
         RETURN ls_return,lc_dzba009
      END IF
   END IF

   #point name = other.function
   CASE
      WHEN lc_dzbb.dzbb002 = "other.function"         #自定義元件(Function)
         LET ls_return = adzp180_other_function("function")
         IF NOT cl_null(ls_return) THEN
            LET gb_oth_func = TRUE
         END IF

      WHEN lc_dzbb.dzbb002 = "other.dialog"           #自訂義DIALOG-作為SUBDIALOG用
         LET ls_return = adzp180_other_function("dialog")

      WHEN lc_dzbb.dzbb002 = "other.report"           #自訂義DIALOG-作為SUBDIALOG用
         LET ls_return = adzp180_other_function("report")

      OTHERWISE 
         #從 dzba_t中取出該add-point應該吃進來的
         #   版號(dzbb003/dzba004)/使用標示(dzbb004/dzba005)
         EXECUTE s1 USING lc_dzbb.dzbb002
                     INTO lc_dzbb.dzbb003,lc_dzbb.dzbb004,lc_dzba007,lc_dzba009
         IF STATUS THEN

            #空框架關鍵連接點處理
            IF lc_dzbb.dzbb002 = "ui_dialog.code" THEN
               IF ls_return IS NULL THEN
                  LET ls_return = "MENU ON ACTION exit EXIT MENU END MENU"
               END IF 
            END IF 
            #若,dzba樹上沒有這個節點,表示本作業內並不需要代換這個點!
         ELSE
            #依照產出的定義，搜尋資料庫內是否有存檔的 add-point
            #此處只取enable部分，enable開關交由設計器處理，若有-206回傳，則秀出錯誤訊息後略過此段落   
            LOCATE lc_dzbb.dzbb098 IN FILE 
            
             SELECT dzbb098,dzbb005
               INTO lc_dzbb.dzbb098,lc_dzbb.dzbb005
               FROM dzbb_t
              WHERE dzbb001 = lc_dzbb.dzbb001 AND dzbb002 = lc_dzbb.dzbb002
                AND dzbb003 = lc_dzbb.dzbb003 AND dzbb004 = lc_dzbb.dzbb004
#               AND dzbb005 = ms_cust     #客戶編號

            IF STATUS THEN
               DISPLAY "注意: 組合add-point,程式BOM有標示但不存在add-point"
               DISPLAY "      作業:",lc_dzbb.dzbb001," add-point:",lc_dzbb.dzbb002
               DISPLAY "      版號:",lc_dzbb.dzbb003," 使用標示:",lc_dzbb.dzbb004
            ELSE
               #查看有無引用標示 (dzbb005='Y')
               IF lc_dzbb.dzbb005 = "Y" THEN
                  DISPLAY "INFO:進入引用"
                  LET ls_return = adzp180_cite(lc_dzbb.dzbb002,lc_dzbb.dzbb003,lc_dzbb.dzbb004)
               ELSE
                  LET ls_return = lc_dzbb.dzbb098
               END IF
            END IF

            FREE lc_dzbb.dzbb098
         END IF
   END CASE
 
   RETURN ls_return,lc_dzba009
END FUNCTION
 

#+ 從db內把所有的other function資料讀出來
PRIVATE FUNCTION adzp180_other_function(lc_type)

   DEFINE lc_dzba001    LIKE dzba_t.dzba001   #程式編號
   DEFINE lc_dzbb002    LIKE dzbb_t.dzbb002   #add-point 編號
   DEFINE lc_dzbb003    LIKE dzbb_t.dzbb003   #設計點版次 (資源池版次)
   DEFINE lc_dzbb004    LIKE dzbb_t.dzbb004   #使用標示
   DEFINE lc_dzbb098    LIKE dzbb_t.dzbb098   #設計點內容
   DEFINE lc_dzbb005    LIKE dzbb_t.dzbb005   #是否引用
   DEFINE ls_return     STRING
   DEFINE ls_return_cite STRING 
   DEFINE lc_type       LIKE type_t.chr20
   DEFINE ls_sql        STRING
   DEFINE ls_temp       STRING

   LET lc_type = lc_type CLIPPED,"%"

   LOCATE lc_dzbb098 IN FILE

   LET ls_sql = "SELECT dzba003,dzba004,dzba005 FROM dzba_t ",
                " WHERE dzba001 = '",ms_prog.trim(),"' ",
                  " AND dzba002 = '",ms_ver.trim(),"' ",
                  " AND dzba003 LIKE '",lc_type CLIPPED,"' ",
#                 " AND dzba008 = '",ms_erp_ver CLIPPED,"' ",  #產品版本
                  " AND dzba010 = '",ms_dgenv CLIPPED,"' ",    #區域(識別標示)
#                 " AND dzba011 = '",ms_cust CLIPPED,"' ",     #客戶編號
                  " AND dzbastus = 'Y' ",
                " ORDER BY dzba006, dzba003 "
   #看樹
   DECLARE adzp180_funcs_cs CURSOR FROM ls_sql


   LET ls_return = ""
   FOREACH adzp180_funcs_cs INTO lc_dzbb002,lc_dzbb003,lc_dzbb004
      #抓出實體的程式碼
      IF g_t100debug >= 3 THEN
         LET ls_temp = DOWNSHIFT(lc_dzbb002 CLIPPED) 
         IF ls_temp.getIndexOf("error",1) THEN
            DISPLAY "INFO: 取得擴增函式名稱:",ls_temp.subString(1,ls_temp.getIndexOf("error",1)-1),
                                              "err0r(0換成o)",ls_temp.subString(ls_temp.getIndexOf("error",1)+5,ls_temp.getLength())
         ELSE
            DISPLAY "INFO: 取得擴增函式名稱:",lc_dzbb002
         END IF
      END IF

      LET lc_dzba001 = ms_prog.trim()  #程式編號
      SELECT dzbb098,dzbb005 INTO lc_dzbb098 FROM dzbb_t
       WHERE dzbb001 = lc_dzba001 AND dzbb002 = lc_dzbb002
         AND dzbb003 = lc_dzbb003 AND dzbb004 = lc_dzbb004
#        AND dzbb005 = ms_cust     #客戶編號
      IF NOT STATUS THEN
         IF lc_dzbb005 = "Y" THEN
            DISPLAY "INFO:進入引用2"
            LET ls_return = ls_return,
                            adzp180_cite(lc_dzbb002,lc_dzbb003,lc_dzbb004),'\n'
         ELSE
            LET gs_dzbb098 = lc_dzbb098
            LET ls_return = ls_return,adzp180_insert_ind(lc_dzba001,lc_dzbb002),'\n'
         END IF
      END IF
   END FOREACH

   FREE lc_dzbb098
   FREE adzp180_funcs_cs

   RETURN ls_return

END FUNCTION


PRIVATE FUNCTION adzp180_ctrlp_mark(ps_line)
   
   DEFINE ps_line      STRING
   DEFINE li_cnt       INTEGER
   DEFINE lc_dzbb       RECORD 
      dzbb001 LIKE dzbb_t.dzbb001,    #程式代號
      dzbb002 LIKE dzbb_t.dzbb002,    #程式設計點 
      dzbb003 LIKE dzbb_t.dzbb003,    #設計點版號
      dzbb004 LIKE dzbb_t.dzbb004,    #使用標示
      dzbb098 LIKE dzbb_t.dzbb098     #設計點內容
   END RECORD    

   LET ps_line = ps_line.trim()   
   LET lc_dzbb.dzbb002 = ps_line.subString(8,ps_line.getLength()) #point名稱
   
   LET lc_dzbb.dzbb001 = ms_prog        #程式名稱

   EXECUTE s1 USING lc_dzbb.dzbb002 INTO lc_dzbb.dzbb003,lc_dzbb.dzbb004
   
   #先確定是否存在
   SELECT COUNT(*) INTO li_cnt FROM dzbb_t
    WHERE dzbb001 = lc_dzbb.dzbb001 AND dzbb002 = lc_dzbb.dzbb002 
      AND dzbb003 = lc_dzbb.dzbb003 AND dzbb004 = lc_dzbb.dzbb004 
#     AND dzbb005 = ms_cust     #客戶編號
      
   IF g_mark AND li_cnt = 0 THEN
      RETURN "#"
   END IF
   
   LOCATE lc_dzbb.dzbb098 IN FILE 
      
   #若存在則再確定是否有內容
   SELECT dzbb098 INTO lc_dzbb.dzbb098 FROM dzbb_t
    WHERE dzbb001 = lc_dzbb.dzbb001 AND dzbb002 = lc_dzbb.dzbb002 
      AND dzbb003 = lc_dzbb.dzbb003 AND dzbb004 = lc_dzbb.dzbb004 
#     AND dzbb005 = ms_cust     #客戶編號
      
   IF g_mark AND cl_null(lc_dzbb.dzbb098) THEN
      RETURN "#"
   ELSE 
      RETURN ""
   END IF
   
   FREE lc_dzbb.dzbb098
   
END FUNCTION


#+ 引用的處理
#+ 確認一下,引用的項目是否需要版本一致
PRIVATE FUNCTION adzp180_cite(lc_dzbb002,lc_dzbb003,lc_dzbb004)

   DEFINE lc_dzbb001    LIKE dzbb_t.dzbb001   #程式代號
   DEFINE lc_dzbb003    LIKE dzbb_t.dzbb003   #設計點版號
   DEFINE lc_dzbb004    LIKE dzbb_t.dzbb004   #使用標示
   DEFINE lc_dzbb005    LIKE dzbb_t.dzbb005   #引用
   DEFINE lc_dzbb098    LIKE dzbb_t.dzbb098   #設計點內容
   DEFINE lc_dzbb002    LIKE dzbb_t.dzbb002   #程式設計點
   DEFINE ls_return     STRING

   LOCATE lc_dzbb098 IN FILE

   DISPLAY "INFO: 引用處理中"
   FREE lc_dzbb098
   RETURN ""

   #確認被引用的對象 (找出lc_dzbb001)
   IF ms_prog.getIndexOf("_",3) THEN
      LET lc_dzbb001 = ms_prog.subString(1,ms_prog.getIndexOf("_",3)-1)
      DISPLAY "注意: 標準行業(",lc_dzbb001,"),內的",lc_dzbb002,"也標示為引用,出現迴圈,放棄引用"
      FREE lc_dzbb098
      RETURN ""
   END IF

   SELECT dzbb098,dzbb005 INTO lc_dzbb098,lc_dzbb005 FROM dzbb_t
    WHERE dzbb001 = lc_dzbb001
      AND dzbb002 = lc_dzbb002 
      AND dzbb003 = lc_dzbb003 AND dzbb004 = lc_dzbb004 
#     AND dzbb005 = ms_cust     #客戶編號

   IF STATUS THEN
   ELSE
      LET ls_return = lc_dzbb098
   END IF

   #判斷該欄位的引用是否為 "Y", 標準行業的引用若也是"Y", 回報錯誤,回傳NULL
   IF lc_dzbb005 = "Y" THEN
      DISPLAY "注意: 標準行業(",lc_dzbb001,"),內的",lc_dzbb002,"也標示為引用,出現迴圈,放棄引用"
      LET ls_return = ""
   END IF

   FREE lc_dzbb098
   RETURN ls_return

END FUNCTION 


#更新程式開發紀錄檔
PRIVATE FUNCTION adzp180_log()

   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzzx001  LIKE gzzx_t.gzzx001
   DEFINE lc_gzzx010  LIKE gzzx_t.gzzx010
   DEFINE lc_gzzx013  LIKE gzzx_t.gzzx013
   DEFINE ls_cmd      STRING
   DEFINE ls_temp     STRING
   DEFINE lch_channel base.Channel

   LET lc_gzzx001 = ms_prog.trim()
   LET lc_gzzx010 = ms_ver.trim()

   #計算 MD5
   LET lch_channel = base.Channel.create()
   LET ls_cmd = "md5sum ",ms_filename
   CALL lch_channel.setDelimiter("\t")
   CALL lch_channel.openPipe(ls_cmd ,"r")
   WHILE lch_channel.read(ls_temp)
      EXIT WHILE
   END WHILE
   LET lc_gzzx013 = ls_temp.subString(1,32)
   CALL lch_channel.close()

   #更新資料
   SELECT COUNT(*) INTO li_cnt FROM gzzx_t
    WHERE gzzx001 = lc_gzzx001
   IF li_cnt = 0 THEN
      INSERT INTO gzzx_t(gzzx001,gzzx010,gzzx013)
       VALUES(lc_gzzx001,lc_gzzx010,lc_gzzx013)
      IF SQLCA.SQLCODE THEN
         DISPLAY "注意: 更新記錄檔(INS)無法執行,自動跳過此程序"
      END IF
   ELSE
      UPDATE gzzx_t SET gzzx010 = lc_gzzx010,gzzx013 = lc_gzzx013
       WHERE gzzx001 = lc_gzzx001
      IF SQLCA.SQLCODE THEN
         DISPLAY "注意: 更新記錄檔(UPD)無法執行,自動跳過此程序"
      END IF
   END IF

END FUNCTION

#確定section是否人工異動
FUNCTION adzp180_chk_section()
   DEFINE li_cnt    INTEGER
   DEFINE lr_dzbc   RECORD LIKE dzbc_t.*
   
   LET g_mark = TRUE

   #先確定是否有進行客製
   LET li_cnt = 0
   LET lr_dzbc.dzbc001 = ms_prog
   LET lr_dzbc.dzbc002 = ms_ver
   LET lr_dzbc.dzbc007 = ms_dgenv
   SELECT COUNT(*) INTO li_cnt FROM dzbc_t 
    WHERE dzbc001 = lr_dzbc.dzbc001 AND #程式名稱
          dzbc002 = lr_dzbc.dzbc002 AND #PR版次
          dzbc005 <> 's'            AND #使用標示
          dzbc007 = lr_dzbc.dzbc007      

   IF li_cnt = 0 THEN
      LET g_mark = TRUE
   ELSE
      LET g_mark = FALSE
   END IF
                        
END FUNCTION

#寫入行業別邏輯段
FUNCTION adzp180_insert_ind(ps_dzbb001,ps_dzbb002)
   DEFINE ps_dzbb001      LIKE dzbb_t.dzbb001 #程式名稱
   DEFINE ps_dzbb002      LIKE dzbb_t.dzbb002 #adp名稱
   DEFINE ls_dzbb098      STRING
   DEFINE lst_token       base.StringTokenizer
   DEFINE ls_token        STRING 
   DEFINE ls_line         STRING 
   DEFINE lb_func         STRING 
   DEFINE lb_define       STRING 
   DEFINE li_cnt          LIKE type_t.num5
   DEFINE ls_gzoj001      LIKE gzoj_t.gzoj001
   DEFINE ls_gzoj003      LIKE gzoj_t.gzoj003
   DEFINE ls_gzoj005      LIKE gzoj_t.gzoj005
   DEFINE ls_gzoj006      LIKE gzoj_t.gzoj006
   DEFINE ls_insert       STRING
   DEFINE ls_sql          STRING
   
   LOCATE ls_gzoj005 IN FILE 
   
   #只做other function
   IF NOT ps_dzbb002[1,9] = "function." THEN
      RETURN gs_dzbb098
   END IF
   
   #檢查ind有沒有設定插入段
   LET ls_gzoj001 = ps_dzbb001
   LET ls_gzoj006 = cl_replace_str(ps_dzbb002,"function.","")
   
   SELECT COUNT(*) INTO li_cnt FROM gzoj_t 
    WHERE gzoj001  = ls_gzoj001   #程式名稱
     # AND gzoj002 IN (SELECT gzoi001 FROM gzoi_t WHERE gzoistus = 'Y')
      AND gzoj006  = ls_gzoj006   #函式名稱
      AND gzojstus = 'Y'          #函式名稱
      
   IF li_cnt = 0 THEN
      RETURN gs_dzbb098
   END IF
   
   #開始抓邏輯
   LET ls_sql = " SELECT gzoj003,gzoj005 FROM gzoj_t ",
                "  WHERE gzoj001 = ? ",
                #"   AND gzoj002 IN (SELECT gzoi001 FROM gzoi_t WHERE gzoistus = 'Y')",
                "   AND gzoj006 = ? ",
                "   AND gzojstus = 'Y'"
   PREPARE adzp180_ins_ind FROM ls_sql
   DECLARE adzp180_ins_ind_cs CURSOR FOR adzp180_ins_ind
   OPEN adzp180_ins_ind_cs USING ls_gzoj001,ls_gzoj006
   FOREACH adzp180_ins_ind_cs INTO ls_gzoj003,ls_gzoj005 
      DISPLAY "INFO: 開始組合行業別(",ls_gzoj003,")邏輯段!"
      LET ls_insert = ls_insert, "\n", "   #---> 行業別(",ls_gzoj003,")插入段(開始) <---\n",
                                         ls_gzoj005,
                                 "\n", "   #---> 行業別(",ls_gzoj003,")插入段(結束) <---"
   END FOREACH
    
   #IF NOT ps_dzbb002 = 'function.azzi900_chk_module' THEN
   #   RETURN gs_dzbb098
   #END IF
   
   #先讀到有function出現才開始處理
   LET lb_func = FALSE
   LET lb_define = TRUE
   
   LET lst_token = base.StringTokenizer.create(gs_dzbb098, '\n')
   
   #先讀到有function出現才開始處理
   WHILE TRUE
      LET ls_token = lst_token.nextToken()
      
      #先讀到有function出現才開始處理
      LET ls_line = ls_token.trim()       #去空白
      LET ls_line = ls_line.toLowerCase() #轉小寫
      LET ls_dzbb098 = ls_dzbb098, "\n", ls_token
      IF ls_line.getIndexOf("function",1) > 0 AND ls_line.subString(1,1) <> "#"  THEN
         #DISPLAY ls_token,":函式定義段"
         EXIT WHILE
      END IF
   END WHILE
   
   #解析DEFINE段
   WHILE TRUE
      LET ls_token = lst_token.nextToken()
      LET ls_line = ls_token.trim()        #去空白 
      LET ls_line = ls_line.toLowerCase()  #轉小寫
      
      #定義段
      IF ls_line.subString(1,6) = "define" THEN
         
         #先去掉註解
         IF ls_line.getIndexOf("#",1) THEN
            LET ls_line = ls_line.subString(1,ls_line.getIndexOf("#",1)-1)
         END IF
         
         IF ls_line.getIndexOf(",",1) > 0 OR  
            ls_line.getIndexOf(" record",1) > 0 THEN
            
            #如果有LIKE為單行宣告
            IF ls_line.getIndexOf(" like ",1) > 0 THEN
               LET ls_dzbb098 = ls_dzbb098, "\n", ls_token
               CONTINUE WHILE
            END IF
            
            #有逗點 OR RECORD (多行定義)
            LET ls_dzbb098 = ls_dzbb098, "\n", ls_token
            WHILE TRUE
               LET ls_token = lst_token.nextToken()
               LET ls_line = ls_token.trim()
               LET ls_line = ls_line.toLowerCase() #轉小寫
               #去掉註解
               IF ls_line.getIndexOf("#",1) THEN
                  LET ls_line = ls_line.subString(1,ls_line.getIndexOf("#",1)-1)
               END IF
               
               #有end及record代表定義結束
               IF ls_line.getIndexOf("record ",1) > 0 AND
                  ls_line.getIndexOf("end ",1)    > 0 THEN
                  LET ls_dzbb098 = ls_dzbb098, "\n", ls_token
                  EXIT WHILE
               END IF             
               
               #判定如果有逗號代表定義未結束
               IF ls_line.getIndexOf(",",1) > 0 THEN
                  LET ls_dzbb098 = ls_dzbb098, "\n", ls_token
                  CONTINUE WHILE
               ELSE
                  LET ls_dzbb098 = ls_dzbb098, "\n", ls_token
                  EXIT WHILE
               END IF

            END WHILE
            CONTINUE WHILE
         ELSE 
            #無逗點 OR 非RECORD
            #DISPLAY ls_token,":單行定義"
            LET ls_dzbb098 = ls_dzbb098, "\n", ls_token
            CONTINUE WHILE
         END IF
      END IF
      
      #註解段
      IF ls_line.subString(1,1) = "#" THEN
         #DISPLAY ls_token,":註解段"
         LET ls_dzbb098 = ls_dzbb098, "\n", ls_token
         CONTINUE WHILE
      END IF
      
      #空白段
      IF cl_null(ls_line) THEN
         #DISPLAY ls_token,":空白段"
         LET ls_dzbb098 = ls_dzbb098, "\n", ls_token
         CONTINUE WHILE
      END IF
      
      #END RECORD
      IF ls_line.getIndexOf("end record",1) > 0 THEN
         #DISPLAY ls_token,":END RECORD"
         LET ls_dzbb098 = ls_dzbb098, "\n", ls_token
         CONTINUE WHILE
      END IF
      
      LET ls_dzbb098 = ls_dzbb098, "\n\n", ls_insert,"\n\n",ls_token

      #DISPLAY "插入!!!!!!!!!!!!!!!!"
      EXIT WHILE
   END WHILE   
   
   #一般程式邏輯
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()

      LET ls_dzbb098 = ls_dzbb098, "\n", ls_token
      #DISPLAY ls_token

   END WHILE
   
   #DISPLAY '--------------------------------------\n',ls_dzbb098
   #DISPLAY ls_dzbb098
   RETURN ls_dzbb098
    
END FUNCTION

