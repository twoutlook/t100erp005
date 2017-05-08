#該程式已解開Section, 不再透過樣板產出!
{<section id="azzp189.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(1900-01-01 00:00:00), PR版次:0007(2016-04-14 11:40:44)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000045
#+ Filename...: azzp189
#+ Description: 畫面預覽作業(preview)
#+ Creator....: 01856(2014-08-22 17:38:06)
#+ Modifier...: 00000 -SD/PR- 01856
 
{</section>}
 
{<section id="azzp189.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160414-00005 #1 by jrg542 修正行業別程式無法預覽的問題
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT util
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:free_style模組變數(Module Variable) name="free_style.variable"

#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE gc_frm_name    LIKE gzza_t.gzza001
DEFINE gs_42s_temp    STRING    #42s檔的暫存
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="azzp189.main" >}
#+ 作業開始
MAIN
   #add-point:main段define
   DEFINE ls_frm_name STRING
   DEFINE ls_frm_path STRING
   DEFINE li_n        LIKE type_t.num5   
   DEFINE li_error    LIKE type_t.num5   
   DEFINE ls_js       STRING
   DEFINE la_send     RECORD 
             sessionkey  STRING,
             parent      STRING,
             background  LIKE type_t.chr1,
             prog        STRING,
             extra       STRING,
             param       DYNAMIC ARRAY OF STRING 
                     END RECORD
   #end add-point    
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   LET g_bgjob = "Y"
   #依模組進行系統初始化設定(系統設定)
   #CALL cl_ap_init("azz","")
 
   #add-point:作業初始化

   LET ls_js = ARG_VAL(1)
   CALL util.JSON.parse(ls_js,la_send)

   LET g_argv = la_send.param

   LET ls_frm_name = g_argv[1]  #畫面檔案
   LET g_lang      = g_argv[2]  #語言別
   LET g_enterprise= FGL_GETENV("TOPENT")
   LET g_account   = FGL_GETENV("LOGNAME")

   LET gs_42s_temp = os.Path.join(os.Path.join(FGL_GETENV("TEMPDIR"),gs_42s_temp),"preview.42s")

   #清理 temp 42s
   IF os.Path.exists(gs_42s_temp) THEN
      IF os.Path.delete(gs_42s_temp) THEN
      END IF
   END IF
  
   CLOSE WINDOW screen
   CALL cl_db_connect("ds",FALSE)

   #語言別檢查
   IF g_lang IS NULL THEN
      SELECT gzxa010 INTO g_lang FROM gzxa_t 
       WHERE gzxaent = g_enterprise AND gzxa001 = g_account
   ELSE
      IF g_lang = "default" THEN
         LET g_lang = ""
      ELSE
         SELECT count(1) INTO li_n FROM gzzy_t
          WHERE gzzy001 = g_lang
         IF li_n <= 0 OR STATUS THEN
            DISPLAY " "
            DISPLAY "INFO: 語言別:",g_lang,"系統中尚未開放使用,直接原樣顯示!"
            DISPLAY " "
            LET g_lang = ""
            CALL azzp189_err_msg()
         END IF
      END IF
   END IF

   #取得模組名, 檔案名
   CALL azzp189_get_frm_path(ls_frm_name) RETURNING li_error,ls_frm_path

   IF li_error THEN
      DISPLAY " "
      DISPLAY "錯誤:",ls_frm_name.trim(),"檔名不符合命名原則, 請重新確認檔名."
      DISPLAY " "
      CALL azzp189_err_msg()
      CALL cl_ap_exitprogram("0")
   END IF

   IF os.Path.exists(ls_frm_path||".42f") THEN
      CALL azzp189_gen_prog(ls_frm_path)
   ELSE
      DISPLAY "錯誤:準備預覽的檔案不存在:",ls_frm_path
   END IF 
   #end add-point
 
   #add-point:SQL_define

   #end add-point
#   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
#   DECLARE azzp189_cl CURSOR FROM g_forupd_sql 
#   
#   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call

      #end add-point
#   ELSE
      #畫面開啟 (identifier)
#      OPEN WINDOW w_azzp189 WITH FORM cl_ap_formpath("azz",g_code)
#   
#      #程式初始化
#      CALL azzp189_init()
#   
#      #瀏覽頁簽資料初始化
#      CALL cl_ui_init()
#   
#      #進入選單 Menu (='N')
#      CALL azzp189_ui_dialog()
#   
#      #畫面關閉
#      CLOSE WINDOW w_azzp189
#   END IF
 
   #add-point:作業離開前

   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="azzp189.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION azzp189_err_msg()

   DISPLAY " "
   DISPLAY "使用方法:r.p 畫面檔名 [語言別] "
   DISPLAY " "
   DISPLAY "Ex. r.p aooi010           -> 以個人使用語系顯示畫面設計"
   DISPLAY "    r.p aooi010 zh_TW     -> 搭配指定語言別進行顯示畫面設計"
   DISPLAY "    r.p aooi010 default   -> 傳入default或無法識別的語言別, 即以原始畫面顯示"
   DISPLAY " "

   RETURN
END FUNCTION

PRIVATE FUNCTION azzp189_gen_prog(ls_path)

   DEFINE ch      base.Channel
   DEFINE ls_file STRING
   DEFINE ls_cmd  STRING
   DEFINE ls_temp STRING
   DEFINE ls_path STRING

   LET ls_file = "preview.4gl"
   LET ls_file = os.Path.join(FGL_GETENV("TEMPDIR"),ls_file)

   IF os.Path.exists(ls_file) THEN
      IF NOT os.Path.delete(ls_file) THEN
         DISPLAY "錯誤:暫存用檔案:",ls_file,"無法刪除!"
      END IF
   END IF

   LET ch = base.Channel.create()
   CALL ch.openFile(ls_file,"w")
   CALL ch.setDelimiter("")

   LET ls_temp ="MAIN"                            CALL ch.write(ls_temp)
   LET ls_temp ="  CLOSE WINDOW screen"           CALL ch.write(ls_temp)
   LET ls_temp ="  OPEN WINDOW w_curr WITH FORM \"",ls_path,"\""
                                                  CALL ch.write(ls_temp)
   LET ls_temp ="  MENU ''"                       CALL ch.write(ls_temp)
   LET ls_temp ="     ON ACTION exit"             CALL ch.write(ls_temp)
   LET ls_temp ="        EXIT MENU"               CALL ch.write(ls_temp)

   LET ls_temp ="     ON IDLE 180"                CALL ch.write(ls_temp)
   LET ls_temp ="        EXIT MENU"               CALL ch.write(ls_temp)

   LET ls_temp ="     ON ACTION close"            CALL ch.write(ls_temp)
   LET ls_temp ="        LET INT_FLAG=FALSE"      CALL ch.write(ls_temp)
   LET ls_temp ="        EXIT MENU"               CALL ch.write(ls_temp)
   LET ls_temp ="  END MENU"                      CALL ch.write(ls_temp)

   LET ls_temp ="  CLOSE WINDOW w_curr"           CALL ch.write(ls_temp)
   LET ls_temp ="END MAIN"                        CALL ch.write(ls_temp)
   CALL ch.close()

   LET ls_cmd = "cd ",FGL_GETENV("TEMPDIR"),"; r.cs preview;",
                "FGLRESOURCEPATH=",FGL_GETENV("TEMPDIR"),"; export FGLRESOURCEPATH;",FGL_GETENV("FGLRUN")," preview"
   RUN ls_cmd

END FUNCTION

PRIVATE FUNCTION azzp189_get_frm_path(ls_frm_name)
   DEFINE ls_module   STRING
   DEFINE ls_fun_path STRING   #區分 COM/ERP/CRM等functional路徑
   DEFINE ls_frm_name STRING
   DEFINE ls_frm_path STRING
   DEFINE lc_gzzo001  LIKE gzzo_t.gzzo001
   DEFINE ls_checking STRING
   DEFINE li_n        LIKE type_t.num5
   DEFINE li_error    LIKE type_t.num5
   DEFINE lc_std_cust LIKE type_t.chr1  
   DEFINE lc_type     LIKE type_t.chr1  
   DEFINE lc_gzdf002  LIKE gzdf_t.gzdf002
   

   #改寫系統判斷式
   LET ls_checking = ls_frm_name.toLowerCase() #ls_frm_name:form 名稱
   LET ls_checking = ls_checking.trim()
   LET li_error = FALSE
   

   CASE
      # 1.當 frm_name 以 a 開頭時, 必為標準 package
      #WHEN ls_checking.subString(1,1) = "a" OR
      #     ls_checking.subString(1,1) = "b" OR
      #     ls_checking.subString(1,1) = "d" OR
      #     ls_checking.subString(1,1) = "e" OR
      #     ls_checking.subString(1,1) = "m" OR 
      #     ls_checking.subString(1,1) = "n" OR 改成 MATCHES
      WHEN ls_checking.subString(1,1) MATCHES "[abdemn]" OR    
           (ls_checking.subString(1,1) = "c" AND NOT ls_checking.subString(1,3) = "cl_"
                                             AND NOT ls_checking.subString(1,4) = "ccl_"
                                             AND NOT ls_checking.subString(1,3) = "cs_"
                                             AND NOT ls_checking.subString(1,3) = "cq_"  )

         
         FOR li_n = 3 TO ls_checking.getLength()
            LET ls_module = ls_checking.subString(1,li_n)
            LET lc_gzzo001 = UPSHIFT(ls_module.trim())

            SELECT gzzj001 FROM gzzj_t WHERE gzzj001 = lc_gzzo001
            IF NOT SQLCA.SQLCODE THEN
               LET li_error = FALSE
               EXIT FOR
            ELSE
               IF ls_checking.subString(1,1) MATCHES "[b]" THEN 
                  #行業別"b" 開頭模組，不存在再換成 a開頭模組到gzzj_t 確認模組是否存在
                  LET ls_module = "a",ls_checking.subString(2,li_n)
                  LET lc_gzzo001 = UPSHIFT(ls_module.trim())
                  SELECT gzzj001 FROM gzzj_t WHERE gzzj001 = lc_gzzo001
                  IF NOT SQLCA.SQLCODE THEN
                     LET li_error = FALSE
                     EXIT FOR 
                  END IF  
               END IF
               
               LET li_error = TRUE
            END IF
         END FOR

         #當 frm_name 以 a 開頭或frm_name 以 b 額外判斷標準或客製
         #IF ls_checking.subString(1,1) = "a" OR ls_checking.subString(1,1) = "b" OR ls_checking.subString(1,1) = "m" OR ls_checking.subString(1,1) = "n" THEN 改成 MATCHES 
         IF ls_checking.subString(1,1) MATCHES "[abmn]" THEN    
            LET lc_gzdf002 = ls_checking
            LET lc_type = cl_chk_spec_type(ls_checking) 
            CASE 
               WHEN lc_type = "M" #主程式
                   SELECT gzza011 INTO lc_std_cust FROM gzza_t
                    WHERE gzza001 = lc_gzdf002

               WHEN lc_type = "S" #子程式
                  SELECT gzde008 INTO lc_std_cust FROM gzde_t
                    WHERE gzde001 = lc_gzdf002
               
               WHEN lc_type = "F" #子畫面 
                  SELECT gzdf003 INTO lc_std_cust FROM gzdf_t 
                   WHERE gzdf002 = lc_gzdf002       
           END CASE 
           #假如是客製，把標準轉到客製路徑
           IF lc_std_cust = 'c' THEN
              #IF ls_checking.subString(1,1) = "a" THEN 改成 MATCHES
              IF ls_checking.subString(1,1) MATCHES "[a]" THEN 
                 LET ls_module = "c",ls_checking.subString(2,3)
              ELSE 
                 LET ls_module = "d",ls_checking.subString(2,3)
              END IF  
           END IF
         END IF 
          
      # 5.當 frm_name 以 s_ 開頭時，判斷子畫面標準轉客製 或 cl_ 開頭時，判斷子畫面標準轉客製
      WHEN ls_checking.subString(1,2)="s_"  OR ls_checking.subString(1,3)="cl_"  #LET ls_module = "sub"
       LET lc_gzdf002 = ls_checking
       SELECT gzdf003 INTO lc_std_cust FROM gzdf_t
        WHERE gzdf002 = lc_gzdf002

        IF ls_checking.subString(1,2)="s_" THEN 
           IF lc_std_cust = 's' THEN 
              LET ls_module = "sub"
           ELSE 
              LET ls_module = "csub"  
           END IF   
        ELSE 
           IF lc_std_cust = 's' THEN 
              LET ls_module = "lib"
           ELSE 

              LET ls_module = "clib"  
           END IF
        END IF 
       
      WHEN ls_checking.subString(1,3)="cs_"    LET ls_module = "csub"
#     15/04/15      
#      # 5.當 frm_name 以 cl_ 開頭時, 必為 lib
#      --WHEN ls_checking.subString(1,3)="cl_"    #LET ls_module = "lib"
#       --LET lc_gzdf002 = ls_checking
#       --SELECT gzdf003 INTO lc_std_cust FROM gzdf_t
#        --WHERE gzdf002 = lc_gzdf002
#--
#       --IF lc_std_cust = 's' THEN 
#          --LET ls_module = "lib"
#       --ELSE 
#          --LET ls_module = "clib"  
#       --END IF
#     15/04/15
      WHEN ls_checking.subString(1,4)="ccl_"   LET ls_module = "clib"
      WHEN ls_checking.subString(1,4)="cwss"   LET ls_module = "cwss"
      # 6.當 frm_name 以 q_ 開頭時, 必為 qry
      WHEN ls_checking.subString(1,2)="q_"     #LET ls_module = "qry"

         LET lc_gzdf002 = ls_checking
         SELECT dzca002 INTO lc_std_cust FROM dzca_t
          WHERE dzca001 = lc_gzdf002

         IF lc_std_cust = 's' THEN 
            LET ls_module = "qry"
         ELSE 
            LET ls_module = "cqry"  
         END IF
      WHEN ls_checking.subString(1,3)="cq_"    LET ls_module = "cqry"      
      # 6.當 frm_name 以 n_ 開頭時, 必為 lng
      WHEN ls_checking.subString(1,2)="l_"     LET ls_module = "lng"

      OTHERWISE
         LET li_error = TRUE
   END CASE

   #先區分 functional 路徑
   CASE
      #WHEN ls_module.subString(1,1) = "a" 改成 MATCHES
      #實際模組路徑
      WHEN ls_module.subString(1,1) MATCHES "[a]"
         LET ls_fun_path = os.Path.join(FGL_GETENV("ERP"),ls_module)
      WHEN ls_module = "lib" OR ls_module = "sub" OR ls_module = "qry" OR
           ls_module = "lng" OR ls_module.getLength() = 4
         LET ls_fun_path = os.Path.join(FGL_GETENV("COM"),ls_module)
      OTHERWISE
         LET ls_fun_path = os.Path.join(FGL_GETENV("ERP"),ls_module)
   END CASE
   
   IF g_lang IS NOT NULL THEN
      #複製42s來源
      LET ls_frm_path = os.Path.join(ls_fun_path,"42s")
      LET ls_frm_path = os.Path.join(os.Path.join(ls_frm_path,g_lang),ls_frm_name),".42s"
      IF NOT os.Path.copy(ls_frm_path,gs_42s_temp) THEN
         DISPLAY "錯誤:複製42s檔失敗,請檢查來源:",ls_frm_path
      END IF
   END IF

   LET ls_frm_path = os.Path.join(ls_fun_path,"42f")
   LET ls_frm_path = os.Path.join(ls_frm_path, ls_frm_name)

   DISPLAY "ls_frm_path=" ,ls_frm_path

   RETURN li_error,ls_frm_path
END FUNCTION

#end add-point
 
{</section>}
 
