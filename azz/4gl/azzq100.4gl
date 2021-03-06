#該程式未解開Section, 採用最新樣板產出!
{<section id="azzq100.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(1900-01-01 00:00:00), PR版次:0001(2014-03-27 10:44:47)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000087
#+ Filename...: azzq100
#+ Description: 系統現況數據回報作業
#+ Creator....: ()
#+ Modifier...: 00000 -SD/PR- 00845
 
{</section>}
 
{<section id="azzq100.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:free_style模組變數(Module Variable) name="free_style.variable"

{<Module define>}
#add-point:free_style模組變數(Module Variable)
{<point name="free_style.variable"/>}
#end add-point
{</Module define>}
#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_forupd_sql STRING
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="azzq100.main" >}
#+ 作業開始
MAIN
   #add-point:main段define name="main.define"
   
   #end add-point    
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("azz","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
 
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE azzq100_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzq100 WITH FORM cl_ap_formpath("azz",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL azzq100_init()
 
      #進入選單 Menu (='N')
      CALL azzq100_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_azzq100
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="azzq100.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION azzq100_data()
   DEFINE ls_temp  STRING
   DEFINE ls_freestyle  STRING
   DEFINE li_cnt   LIKE type_t.num10
   DEFINE lc_logz  RECORD
             logz001 DATETIME YEAR TO SECOND,  #紀錄時間
             logz002 LIKE logz_t.logz002,      #系統模組數
             logz003 LIKE logz_t.logz003,      #登記主程式數
             logz004 LIKE logz_t.logz004,      #有效主程式數
             logz010 LIKE logz_t.logz005,      #Free Style程式支數
             logz005 LIKE logz_t.logz006,      #登記子程式數
             logz006 LIKE logz_t.logz007,      #有效子程式數
             logz007 LIKE logz_t.logz008,      #註冊作業數
             logz008 LIKE logz_t.logz009,      #有效作業數
             logz009 LIKE logz_t.logz010       #實際開表數
                     END RECORD
   DEFINE lc_gzza001 LIKE gzza_t.gzza001
   DEFINE lc_gzzal003 LIKE gzzal_t.gzzal003

   #查詢時間
   LET lc_logz.logz001 = CURRENT

   #系統模組數
   SELECT count(*) INTO lc_logz.logz002
     FROM gzzo_t
    WHERE gzzo001 <> 'ADZ' AND gzzo001 <> 'AIT'

   #程式註冊支數
   SELECT count(*) INTO lc_logz.logz003
     FROM gzza_t
    WHERE gzza003 <> 'ADZ' AND gzza003 <> 'AIT'

   #程式有效支數
   DECLARE azzq100_gzza_cur CURSOR FOR
    SELECT gzza001 FROM gzza_t
     WHERE gzza003 <> 'ADZ' AND gzza003 <> 'AIT'
       AND gzzastus = "Y"
   LET li_cnt = 0
   FOREACH azzq100_gzza_cur INTO lc_gzza001
      IF cl_chk_app_executed(lc_gzza001) THEN
         LET li_cnt = li_cnt + 1
      END IF
   END FOREACH
   LET lc_logz.logz004 = li_cnt

   #FreeStyle作業支數
   SELECT count(*) INTO lc_logz.logz005
     FROM gzza_t,dzax_t
    WHERE gzza003 <> 'ADZ' AND gzza003 <> 'AIT'
      AND gzzastus = "Y"
      AND dzax001 = gzza001
      AND dzax003 = "Y"
      AND dzaxstus = "Y"

   #列出Free Style清單
   DECLARE azzq100_freestyle_cur CURSOR FOR
    SELECT gzza001 FROM gzza_t,dzax_t
     WHERE gzza003 <> 'ADZ' AND gzza003 <> 'AIT'
       AND gzzastus = "Y"
       AND dzax001 = gzza001
       AND dzax003 = "Y"
       AND dzaxstus = "Y"
     ORDER BY gzza001
   FOREACH azzq100_freestyle_cur INTO lc_gzza001
      SELECT gzzal003 INTO lc_gzzal003 FROM gzzal_t
       WHERE gzzal001 = lc_gzza001
         AND gzzal002 = g_lang
      LET ls_freestyle = ls_freestyle,lc_gzza001," ",lc_gzzal003,"\n"
   END FOREACH

   #子程式註冊支數
   SELECT count(*) INTO lc_logz.logz006
     FROM gzde_t
    WHERE gzde002 <> 'ADZ' AND gzde002 <> 'AIT'

   #子程式有效支數
   SELECT count(*) INTO lc_logz.logz007
     FROM gzde_t
    WHERE gzde002 <> 'ADZ' AND gzde002 <> 'AIT'
      AND gzde002 <> "LIB"
      AND gzde002 <> "SUB"
      AND gzde002 <> "QRY"
      AND gzde002 <> "LNG"
      AND gzdestus = "Y"

   #作業註冊支數
   SELECT count(*) INTO lc_logz.logz008
     FROM gzzz_t
    WHERE gzzz005 <> 'ADZ' AND gzzz005 <> 'AIT'

   #作業有效支數
   DECLARE azzq100_gzzz_cur CURSOR FOR
    SELECT gzzz001 FROM gzzz_t
     WHERE gzzz005 <> 'ADZ' AND gzzz005 <> 'AIT'
       AND gzzzstus = "Y"
   LET li_cnt = 0
   FOREACH azzq100_gzzz_cur INTO lc_gzza001
      IF cl_chk_app_executed(lc_gzza001) THEN
         LET li_cnt = li_cnt + 1
      END IF
   END FOREACH
   LET lc_logz.logz009 = li_cnt

   #實際開表數量
   SELECT count(unique gztz001) INTO lc_logz.logz010
     FROM gztz_t

   IF g_argv[1] = "Y" THEN
      INSERT INTO logz_t (logz001,logz002,logz003,logz004,logz005,logz006,logz007,
                          logz008,logz009,logz010)
           VALUES (lc_logz.logz001,lc_logz.logz002,lc_logz.logz003,lc_logz.logz004,
                   lc_logz.logz005,lc_logz.logz006,lc_logz.logz007,lc_logz.logz008,
                   lc_logz.logz009,lc_logz.logz010)
   END IF

   LET ls_temp = "資料查詢時間(排除ADZ/AIT):",lc_logz.logz001,"\n\n"
   LET ls_temp = ls_temp,"模組註冊數量:",lc_logz.logz002 USING "<<<<<<","\n\n"
   LET ls_temp = ls_temp,"程式註冊支數:",lc_logz.logz003 USING "<<<<<<","\n"
   LET ls_temp = ls_temp,"    有效支數:",lc_logz.logz004 USING "<<<<<<","\n\n"
   LET ls_temp = ls_temp,"Free Style數:",lc_logz.logz005 USING "<<<<<<","\n"
   LET ls_temp = ls_temp,ls_freestyle,"\n"
   LET ls_temp = ls_temp,"子程式註冊支數:",lc_logz.logz006 USING "<<<<<<","\n"
   LET ls_temp = ls_temp,"    有效支數:",lc_logz.logz007 USING "<<<<<<","\n\n"
   LET ls_temp = ls_temp,"作業註冊支數:",lc_logz.logz008 USING "<<<<<<","\n"
   LET ls_temp = ls_temp,"    有效支數:",lc_logz.logz009 USING "<<<<<<","\n\n"
   LET ls_temp = ls_temp,"實際開表個數:",lc_logz.logz010 USING "<<<<<<","\n"
   RETURN ls_temp

END FUNCTION

PRIVATE FUNCTION azzq100_init()

END FUNCTION

PRIVATE FUNCTION azzq100_ui_dialog()
   DEFINE ls_text STRING
   LET ls_text = azzq100_data()
   DISPLAY ls_text TO FORMONLY.textedit1
   MENU
      ON ACTION exit
         EXIT MENU
      ON ACTION close
         EXIT MENU
   END MENU
END FUNCTION

#end add-point
 
{</section>}
 
