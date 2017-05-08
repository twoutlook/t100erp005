#該程式已解開Section, 不再透過樣板產出!
{<section id="acrm300.description" >}
#+ Version..: T100-ERP-1.00.00(版次:1) Build-000085
#+ 
#+ Filename...: acrm300
#+ Description: 潛在客戶主檔維護作業
#+ Creator....: 04226(2014/04/16)
#+ Modifier...: 04226(2014/04/18)
#+ Buildtype..: 應用 i01 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="acrm300.global" >}
#160318-00025#27  16/04/29 BY 07900     校验代码重复错误讯息的修改
#160812-00017#4   16/08/15 By 06814     在satatchange( )的FUNCTION中，有RETURN指令但沒有加上transaction_end( ) 造成transaction沒有結束就直接RETURN
#160818-00017#5   16/08/22 by 08172     修改删除时重新检查状态
#160905-00007#1   2016-09-05  By08734   ent调整
#161024-00025#6   2016/10/26  By 02481  组织开窗aooi500规范调整
#161108-00016#1   2016/11/09  by 08742  修改 g_browser_cnt 定义大小
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目
IMPORT FGL aoo_aooi350_01
IMPORT FGL aoo_aooi350_02
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單頭 type 宣告
PRIVATE TYPE type_g_craa_m RECORD
       craaunit LIKE craa_t.craaunit, 
   craaunit_desc LIKE type_t.chr80, 
   craa001 LIKE craa_t.craa001, 
   craal004 LIKE type_t.chr80, 
   craal003 LIKE type_t.chr80, 
   craal005 LIKE type_t.chr80, 
   craa003 LIKE craa_t.craa003, 
   craa032 LIKE craa_t.craa032, 
   craastus LIKE craa_t.craastus, 
   craa004 LIKE craa_t.craa004, 
   craa005 LIKE craa_t.craa005, 
   craa006 LIKE craa_t.craa006, 
   craa007 LIKE craa_t.craa007, 
   craa008 LIKE craa_t.craa008, 
   craa008_desc LIKE type_t.chr80, 
   craa009 LIKE craa_t.craa009, 
   craa010 LIKE craa_t.craa010, 
   craa010_desc LIKE type_t.chr80, 
   craa011 LIKE craa_t.craa011, 
   craa012 LIKE craa_t.craa012, 
   craa014 LIKE craa_t.craa014, 
   craa014_desc LIKE type_t.chr80, 
   craa015 LIKE craa_t.craa015, 
   craa015_desc LIKE type_t.chr80, 
   craa016 LIKE craa_t.craa016, 
   craa016_desc LIKE type_t.chr80, 
   craa013 LIKE craa_t.craa013, 
   craa020 LIKE craa_t.craa020, 
   craa020_desc LIKE type_t.chr80, 
   craa019 LIKE craa_t.craa019, 
   craa019_desc LIKE type_t.chr80, 
   craa018 LIKE craa_t.craa018, 
   craa018_desc LIKE type_t.chr80, 
   craa017 LIKE craa_t.craa017, 
   craa017_desc LIKE type_t.chr80, 
   craa021 LIKE craa_t.craa021, 
   craa021_desc LIKE type_t.chr80, 
   craa022 LIKE craa_t.craa022, 
   craa023 LIKE craa_t.craa023, 
   craa024 LIKE craa_t.craa024, 
   craa025 LIKE craa_t.craa025, 
   craa026 LIKE craa_t.craa026, 
   craa027 LIKE craa_t.craa027, 
   craa027_desc LIKE type_t.chr80, 
   craa028 LIKE craa_t.craa028, 
   craa033 LIKE craa_t.craa033, 
   craa029 LIKE craa_t.craa029, 
   craa029_desc LIKE type_t.chr80, 
   craa030 LIKE craa_t.craa030, 
   craa031 LIKE craa_t.craa031, 
   craa031_desc LIKE type_t.chr80, 
   craaownid LIKE craa_t.craaownid, 
   craaownid_desc LIKE type_t.chr80, 
   craaowndp LIKE craa_t.craaowndp, 
   craaowndp_desc LIKE type_t.chr80, 
   craacrtid LIKE craa_t.craacrtid, 
   craacrtid_desc LIKE type_t.chr80, 
   craacrtdp LIKE craa_t.craacrtdp, 
   craacrtdp_desc LIKE type_t.chr80, 
   craacrtdt DATETIME YEAR TO SECOND, 
   craamodid LIKE craa_t.craamodid, 
   craamodid_desc LIKE type_t.chr80, 
   craamoddt DATETIME YEAR TO SECOND, 
   craacnfid LIKE craa_t.craacnfid, 
   craacnfid_desc LIKE type_t.chr80, 
   craacnfdt DATETIME YEAR TO SECOND
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_craa_m        type_g_craa_m
DEFINE g_craa_m_t      type_g_craa_m                #備份舊值
   DEFINE g_craa001_t LIKE craa_t.craa001
 
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD                   #資料瀏覽之欄位  
         b_statepic     LIKE type_t.chr50,
            b_craa001 LIKE craa_t.craa001
         #,rank           LIKE type_t.num10
      END RECORD 
          
DEFINE g_master_multi_table_t    RECORD
      craal001 LIKE craal_t.craal001,
      craal004 LIKE craal_t.craal004,
      craal003 LIKE craal_t.craal003,
      craal005 LIKE craal_t.craal005
      END RECORD
 
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
  
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL    
DEFINE g_cnt                 LIKE type_t.num10              
DEFINE g_jump                LIKE type_t.num10             #查詢指定的筆數 
DEFINE g_no_ask              LIKE type_t.num5              #是否開啟指定筆視窗 
#DEFINE g_rec_b               LIKE type_t.num5             #單身筆數   #161108-00016#1   2016/11/09  by 08742 mark                      
DEFINE g_rec_b               LIKE type_t.num10             #單身筆數    #161108-00016#1   2016/11/09  by 08742 add                     
#DEFINE l_ac                  LIKE type_t.num5             #161108-00016#1   2016/11/09  by 08742 mark       
DEFINE l_ac                  LIKE type_t.num10             #161108-00016#1   2016/11/09  by 08742 add  #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_pagestart           LIKE type_t.num5              #page起始筆數
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_state               STRING
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_aw                  STRING             #確定當下點擊的單身
 
#快速搜尋用
DEFINE g_searchcol           STRING             #查詢欄位代碼
DEFINE g_searchstr           STRING             #查詢欄位字串
DEFINE g_order               STRING             #查詢排序模式
 
#Browser用
DEFINE g_current_idx         LIKE type_t.num5   #Browser 所在筆數(當下page)
DEFINE g_current_cnt         LIKE type_t.num10  #Browser 總筆數(當下page)
 
#161108-00016#1   2016/11/09  by 08742 -S
#DEFINE g_current_row        LIKE type_t.num5   #Browser 所在筆數(暫存用) 
#DEFINE g_browser_idx        LIKE type_t.num5   #Browser 所在筆數(所有資料)
#DEFINE g_browser_cnt        LIKE type_t.num5   #Browser 總筆數
DEFINE g_browser_idx         LIKE type_t.num10  #Browser 所在筆數(所有資料)
DEFINE g_current_row         LIKE type_t.num10  #Browser 所在筆數(暫存用) 
DEFINE g_browser_cnt         LIKE type_t.num10  
#161108-00016#1   2016/11/09  by 08742 -E
 
DEFINE g_tmp_page            LIKE type_t.num5   
DEFINE g_row_index           LIKE type_t.num5
DEFINE g_chk                 BOOLEAN
DEFINE g_default             BOOLEAN            #是否有外部參數查詢
 
#add-point:自定義模組變數(Module Variable)
DEFINE g_craa_m_o      type_g_craa_m

GLOBALS
   DEFINE g_detail_insert   LIKE type_t.num5   #單身的新增權限
   DEFINE g_detail_delete   LIKE type_t.num5   #單身的刪除權限
   DEFINE g_wc2_i35001      STRING             #聯絡地址QBE條件
   DEFINE g_wc2_i35002      STRING             #通訊方式QBE條件
   DEFINE g_d_idx_i35001    LIKE type_t.num5   #聯絡地址所在筆數
   DEFINE g_d_cnt_i35001    LIKE type_t.num5   #聯絡地址總筆數
   DEFINE g_d_idx_i35002    LIKE type_t.num5   #通訊方式所在筆數
   DEFINE g_d_cnt_i35002    LIKE type_t.num5   #通訊方式總筆數
   DEFINE g_pmaa027_d       LIKE pmaa_t.pmaa027
   DEFINE g_appoint_idx     LIKE type_t.num5   #指定進入單身行數
   TYPE type_g_oofb_d        RECORD
       oofbstus LIKE oofb_t.oofbstus, 
   oofb001 LIKE oofb_t.oofb001, 
   oofb019 LIKE oofb_t.oofb019, 
   oofb011 LIKE oofb_t.oofb011, 
   oofb008 LIKE oofb_t.oofb008, 
   oofb009 LIKE oofb_t.oofb009, 
   oofb009_desc LIKE type_t.chr500, 
   oofb010 LIKE oofb_t.oofb010, 
   oofb012 LIKE oofb_t.oofb012, 
   oofb012_desc LIKE type_t.chr500, 
   oofb013 LIKE oofb_t.oofb013, 
   oofb014 LIKE oofb_t.oofb014, 
   oofb014_desc LIKE type_t.chr500, 
   oofb015 LIKE oofb_t.oofb015, 
   oofb015_desc LIKE type_t.chr500, 
   oofb016 LIKE oofb_t.oofb016, 
   oofb016_desc LIKE type_t.chr500, 
   oofb017 LIKE oofb_t.oofb017, 
   oofb022 LIKE oofb_t.oofb022, 
   oofb022_desc LIKE type_t.chr500, 
   oofb020 LIKE oofb_t.oofb020, 
   oofb021 LIKE oofb_t.oofb021, 
   oofb018 LIKE oofb_t.oofb018
       END RECORD   
   DEFINE g_oofb_d2         DYNAMIC ARRAY OF type_g_oofb_d
   TYPE type_g_oofc_d        RECORD
       oofcstus LIKE oofc_t.oofcstus, 
   oofc001 LIKE oofc_t.oofc001, 
   oofc008 LIKE oofc_t.oofc008, 
   oofc009 LIKE oofc_t.oofc009, 
   oofc009_desc LIKE type_t.chr500, 
   oofc012 LIKE oofc_t.oofc012, 
   oofc010 LIKE oofc_t.oofc010, 
   oofc014 LIKE oofc_t.oofc014, 
   oofc011 LIKE oofc_t.oofc011, 
   oofc015 LIKE oofc_t.oofc015,
   oofc013 LIKE oofc_t.oofc013
       END RECORD
   DEFINE g_oofc_d2          DYNAMIC ARRAY OF type_g_oofc_d
END GLOBALS

DEFINE g_detail_id          STRING             #紀錄停留在聯絡地址, 通訊方式或不在此兩個Page
 #mark by geza 20160229(S)
# TYPE type_g_pmaj_d        RECORD
#       pmajstus LIKE pmaj_t.pmajstus, 
#   pmaj002 LIKE pmaj_t.pmaj002, 
#   pmaj003 LIKE pmaj_t.pmaj003, 
#   pmaj004 LIKE pmaj_t.pmaj004, 
#   pmaj005 LIKE pmaj_t.pmaj005, 
#   pmaj006 LIKE pmaj_t.pmaj006, 
#   pmaj007 LIKE pmaj_t.pmaj007, 
#   oofa008 LIKE type_t.chr80, 
#   oofa009 LIKE type_t.chr80, 
#   oofa010 LIKE type_t.chr80, 
#   oofa011 LIKE type_t.chr80, 
#   oofa012 LIKE type_t.chr80, 
#   oofa013 LIKE type_t.chr80, 
#   pmaj008 LIKE pmaj_t.pmaj008
#       END RECORD
 #mark by geza 20160229(E) 
 #add by geza 20160229(S)
 TYPE type_g_pmaj_d        RECORD
       pmajstus LIKE pmaj_t.pmajstus, 
   pmaj002 LIKE pmaj_t.pmaj002, 
   pmaj003 LIKE pmaj_t.pmaj003, 
   pmaj004 LIKE pmaj_t.pmaj004, 
   pmaj005 LIKE pmaj_t.pmaj005, 
   pmaj006 LIKE pmaj_t.pmaj006, 
   pmaj007 LIKE pmaj_t.pmaj007, 
   pmaj009 LIKE pmaj_t.pmaj009, 
   pmaj010 LIKE pmaj_t.pmaj010, 
   pmaj011 LIKE pmaj_t.pmaj011, 
   pmaj012 LIKE pmaj_t.pmaj012, 
   pmaj013 LIKE pmaj_t.pmaj013, 
   pmaj014 LIKE pmaj_t.pmaj014, 
   pmaj008 LIKE pmaj_t.pmaj008
       END RECORD
   #add by geza 20160229(E)    
DEFINE g_pmaj_d          DYNAMIC ARRAY OF type_g_pmaj_d
DEFINE g_pmaj_d_t        type_g_pmaj_d
DEFINE g_pmaj_d_o        type_g_pmaj_d
DEFINE g_wc2_table1      STRING
DEFINE g_detail_idx      LIKE type_t.num5  
DEFINE g_insert          LIKE type_t.chr5  
DEFINE gs_keys           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak       DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
     

#end add-point
 
#add-point:傳入參數說明(global.argv)
DEFINE g_ins_site_flag       LIKE type_t.chr1       #紀錄新增單據cracunit是否已輸入  #161024-00025#6--add
#end add-point
 
{</section>}
 
{<section id="acrm300.main" >}
#+ 此段落由子樣板a26產生
#OPTIONS SHORT CIRCUIT
#+ 作業開始 
MAIN
   #add-point:main段define
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("acr","")
 
   #add-point:作業初始化
   
   #end add-point
   
   
 
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = "SELECT craaunit,'',craa001,'','','',craa003,craa032,craastus,craa004,craa005, 
       craa006,craa007,craa008,'',craa009,craa010,'',craa011,craa012,craa014,'',craa015,'',craa016,'', 
       craa013,craa020,'',craa019,'',craa018,'',craa017,'',craa021,'',craa022,craa023,craa024,craa025, 
       craa026,craa027,'',craa028,craa033,craa029,'',craa030,craa031,'',craaownid,'',craaowndp,'',craacrtid, 
       '',craacrtdp,'',craacrtdt,craamodid,'',craamoddt,craacnfid,'',craacnfdt FROM craa_t WHERE craaent=  
       ? AND craa001=? FOR UPDATE"
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   DECLARE acrm300_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call
      
      #end add-point
 
   ELSE
      
      #畫面開啟 (identifier)
      OPEN WINDOW w_acrm300 WITH FORM cl_ap_formpath("acr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL acrm300_init()   
 
      #進入選單 Menu (="N")
      CALL acrm300_ui_dialog() 
	  
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_acrm300
      
   END IF 
   
   CLOSE acrm300_cl
   
   
 
   #add-point:作業離開前
   CALL s_aooi500_drop_temp() RETURNING l_success #150308-00001#1  By Ken 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="acrm300.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION acrm300_init()
   #add-point:init段define
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
   #end add-point
 
      CALL cl_set_combo_scc_part('craastus','50','N,X,Y')
 
      CALL cl_set_combo_scc('craa032','6052') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化
   CALL s_aooi500_create_temp() RETURNING l_success #150308-00001#1  By Ken 150309   
   LET g_errshow = 1
   
   CALL cl_ui_replace_sub_window(cl_ap_formpath("aoo", "aooi350_01"), "grid_3", "Table", "s_detail1_aooi350_01")
   CALL cl_set_combo_scc('oofb008','9')   #地址類型
   CALL cl_ui_replace_sub_window(cl_ap_formpath("aoo", "aooi350_02"), "grid_8", "Table", "s_detail1_aooi350_02")
   CALL cl_set_combo_scc('oofc008','6')   #通訊類型
   #end add-point
   
   CALL acrm300_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="acrm300.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION acrm300_ui_dialog() 
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num5
   DEFINE ls_wc     STRING
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   #add-point:ui_dialog段define

   #end add-point
   
   LET li_exit = FALSE
   LET g_current_row = 0
   LET g_current_idx = 1
   
   
   #action default動作
   #+ 此段落由子樣板a42產生
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL acrm300_insert()
            #add-point:ON ACTION insert

            #END add-point
         END IF
 
      #add-point:action default自訂

      #end add-point
      OTHERWISE
         
   END CASE
 
 
   
   #add-point:ui_dialog段before dialog 

   #end add-point
 
   WHILE li_exit = FALSE
      
      CALL acrm300_browser_fill(g_wc,"")
      
      #判斷前一個動作是否為新增, 若是的話切換到新增的筆數
      IF g_state = "Y" THEN
         FOR li_idx = 1 TO g_browser.getLength()
            IF g_browser[li_idx].b_craa001 = g_craa001_t
 
               THEN
               LET g_current_row = li_idx
               LET g_current_idx = li_idx
               EXIT FOR
            END IF
         END FOR
         LET g_state = ""
      END IF
    
      
 
              
 
               
 
              
               
              

              

               

              
 
               
 
 

 

 

 

 

 

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
        
         #add-point:ui_dialog段自定義display array
         DISPLAY ARRAY g_pmaj_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b)
    
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               
         END DISPLAY
         SUBDIALOG aoo_aooi350_01.aooi350_01_display
         SUBDIALOG aoo_aooi350_02.aooi350_02_display

         #end add-point
 
      
         BEFORE DIALOG
            #當每次點任一筆資料都會需要用到  
            IF g_browser_cnt > 0 THEN
               CALL acrm300_fetch("")   
            END IF               
            
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_pmaj_d)
               LET g_export_id[1]   = "s_detail1"
               
               LET g_export_node[2] = base.typeInfo.create(g_oofb_d2)
               LET g_export_id[2]   = "s_detail1_aooi350_01"
               
               LET g_export_node[3] = base.typeInfo.create(g_oofc_d2)
               LET g_export_id[3]   = "s_detail1_aooi350_02"
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF


            #end add-point
         
         ON ACTION statechange
            CALL acrm300_statechange()
            LET g_action_choice="statechange"
            EXIT DIALOG
      
 
         ON ACTION first
            CALL acrm300_fetch("F") 
            LET g_current_row = g_current_idx
         
         ON ACTION next
            CALL acrm300_fetch("N")
            LET g_current_row = g_current_idx
      
         ON ACTION jump
            CALL acrm300_fetch("/")
            LET g_current_row = g_current_idx
      
         ON ACTION previous
            CALL acrm300_fetch("P")
            LET g_current_row = g_current_idx
      
         ON ACTION last 
            CALL acrm300_fetch("L")  
            LET g_current_row = g_current_idx
      
         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG 
      
         ON ACTION close
            LET li_exit = TRUE
            EXIT DIALOG
      
         ON ACTION mainhidden       #主頁摺疊
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
            END IF
            EXIT DIALOG
            
      
         #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
         ON ACTION controls   
            IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("vb_master",0)
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("vb_master",1)
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden     
            END IF
 
         #快速搜尋
            
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL acrm300_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL acrm300_browser_fill(g_wc,"F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "-100"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
 
                  CLEAR FORM
               ELSE
                  CALL acrm300_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
            
         
 
      ON ACTION acrm300_clear_craa021
 
         LET g_action_choice="acrm300_clear_craa021"
         IF cl_auth_chk_act("acrm300_clear_craa021") THEN 
            #add-point:ON ACTION acrm300_clear_craa021
               IF cl_ask_confirm('acr-00005') THEN
                  CALL acrm300_clear_craa021()
               END IF
            #END add-point
            EXIT DIALOG
         END IF
 
 
      ON ACTION acrm300_clear_craa029
 
         LET g_action_choice="acrm300_clear_craa029"
         IF cl_auth_chk_act("acrm300_clear_craa029") THEN 
            #add-point:ON ACTION acrm300_clear_craa029
               IF cl_ask_confirm('acr-00006') THEN
                  CALL acrm300_clear_craa029()
               END IF
            #END add-point
            EXIT DIALOG
         END IF
 
 
      ON ACTION acrm300_clear_craa031
 
         LET g_action_choice="acrm300_clear_craa031"
         IF cl_auth_chk_act("acrm300_clear_craa031") THEN 
            #add-point:ON ACTION acrm300_clear_craa031
               IF cl_ask_confirm('acr-00007') THEN
                  CALL acrm300_clear_craa031()
               END IF
            #END add-point
            EXIT DIALOG
         END IF
 
 
      ON ACTION acrm300_upd_craa021
 
         LET g_action_choice="acrm300_upd_craa021"
         IF cl_auth_chk_act("acrm300_upd_craa021") THEN 
            #add-point:ON ACTION acrm300_upd_craa021
　　　　　　　　CALL acrm300_upd_craa021('u')
            #END add-point
            EXIT DIALOG
         END IF
 
 
      ON ACTION delete
 
         LET g_action_choice="delete"
         IF cl_auth_chk_act("delete") THEN 
            CALL acrm300_delete()
            #add-point:ON ACTION delete

            #END add-point
         END IF
 
 
      ON ACTION insert
 
         LET g_action_choice="insert"
         IF cl_auth_chk_act("insert") THEN 
            CALL acrm300_insert()
            #add-point:ON ACTION insert

            #END add-point
            EXIT DIALOG
         END IF
 
 
      ON ACTION modify
 
         LET g_aw = ''
         LET g_action_choice="modify"
         IF cl_auth_chk_act("modify") THEN 
            CALL acrm300_modify()
            #add-point:ON ACTION modify
            CALL acrm300_b_fill("1=1")
            #END add-point
            EXIT DIALOG
         END IF
 
 
      ON ACTION open_acrm300_01
 
         LET g_action_choice="open_acrm300_01"
         IF cl_auth_chk_act("open_acrm300_01") THEN 
            #add-point:ON ACTION open_acrm300_01
               CALL acrm300_01(g_craa_m.craa001)
               LET g_action_choice = ""
               LET INT_FLAG = ''
            #END add-point
            EXIT DIALOG
         END IF
 
 
      ON ACTION open_acrm300_02
 
         LET g_action_choice="open_acrm300_02"
         IF cl_auth_chk_act("open_acrm300_02") THEN 
            #add-point:ON ACTION open_acrm300_02
　　　　　　　　CALL acrm300_02(g_craa_m.craa001)
               LET g_action_choice = ""
               LET INT_FLAG = ''
            #END add-point
            EXIT DIALOG
         END IF
 
 
      ON ACTION output
 
         LET g_action_choice="output"
         IF cl_auth_chk_act("output") THEN 
            #add-point:ON ACTION output

            #END add-point
            EXIT DIALOG
         END IF
 
 
      ON ACTION query
 
         LET g_action_choice="query"
         IF cl_auth_chk_act("query") THEN 
            CALL acrm300_query()
            #add-point:ON ACTION query

            #END add-point
         END IF
 
 
      ON ACTION reproduce
 
         LET g_action_choice="reproduce"
         IF cl_auth_chk_act("reproduce") THEN 
            CALL acrm300_reproduce()
            #add-point:ON ACTION reproduce

            #END add-point
            EXIT DIALOG
         END IF
 
         
         
 
         #+ 此段落由子樣板a46產生
      #新增相關文件
      ON ACTION related_document
         CALL g_pk_array.clear()
         LET g_pk_array[1].values = g_craa_m.craa001
         LET g_pk_array[1].column = 'craa001'
 
         IF cl_auth_chk_act("related_document") THEN
            #add-point:ON ACTION related_document

            #END add-point
            CALL cl_doc()
         END IF
         
      ON ACTION agendum
		    CALL g_pk_array.clear()
         LET g_pk_array[1].values = g_craa_m.craa001
         LET g_pk_array[1].column = 'craa001'
 
         #add-point:ON ACTION agendum

         #END add-point
			CALL cl_user_overview_set_follow_pic()
      
      ON ACTION followup
         CALL g_pk_array.clear()
         LET g_pk_array[1].values = g_craa_m.craa001
         LET g_pk_array[1].column = 'craa001'
 
         #add-point:ON ACTION followup

         #END add-point
         CALL cl_user_overview_follow('')
 
      　　#主選單用ACTION
      　　&include "main_menu.4gl"
      　　&include "relating_action.4gl"
      　　#交談指令共用ACTION
      　　&include "common_action.4gl"
      END DIALOG 
      
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="acrm300.browser_fill" >}
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION acrm300_browser_fill(p_wc,ps_page_action) 
   DEFINE p_wc              STRING
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define
 
   #end add-point
   
   CLEAR FORM
   INITIALIZE g_craa_m.* TO NULL
   INITIALIZE g_wc TO NULL
   CALL g_browser.clear()
   
   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = "0" THEN
      LET l_searchcol = "craa001"
   ELSE
      LET l_searchcol = g_searchcol
   END IF
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   
   #add-point:browser_fill段wc控制
　　CALL aooi350_01_clear_detail()
   CALL aooi350_02_clear_detail()
   #end add-point
 
   LET g_sql = " SELECT COUNT(*) FROM craa_t ",
               "  ",
               "  LEFT JOIN craal_t ON craa001 = craal001 AND craal002 = '",g_lang,"' ",
               " WHERE craaent = '" ||g_enterprise|| "' AND ", 
               p_wc CLIPPED
                
   #add-point:browser_fill段cnt_sql
   LET g_sql = " SELECT COUNT(DISTINCT craa001) FROM craa_t ",
               "   LEFT JOIN craal_t ON craa001 = craal001 AND craal002 = '",g_lang,"' ",
               "   LEFT JOIN oofb_t ON oofbent = craaent AND craa013 = oofb002",
               "   LEFT JOIN oofc_t ON oofcent = craaent AND craa013 = oofc002",
               "   LEFT JOIN pmaj_t ON pmajent = craaent AND craa001 = pmaj001",
               "  WHERE craaent = '" ||g_enterprise|| "' AND ",  p_wc CLIPPED
   #end add-point
				
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt
   FREE header_cnt_pre 
   
   #若超過最大顯示筆數
   
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count
   DISPLAY g_browser_cnt TO FORMONLY.h_count
   
   LET g_wc = p_wc
   #LET g_page_action = ps_page_action          # Keep Action
   
   IF ps_page_action = "F" OR
      ps_page_action = "P"  OR
      ps_page_action = "N"  OR
      ps_page_action = "L"  THEN
      LET g_page_action = ps_page_action
   END IF
 
   CASE ps_page_action
      
      WHEN "F" 
         LET g_pagestart = 1
      
      WHEN "P"  
         LET g_pagestart = g_pagestart - g_max_browse
         IF g_pagestart < 1 THEN
            LET g_pagestart = 1
         END IF
      
      WHEN "N"  
         LET g_pagestart = g_pagestart + g_max_browse
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = g_browser_cnt - (g_browser_cnt mod g_max_browse) + 1
            WHILE g_pagestart > g_browser_cnt 
               LET g_pagestart = g_pagestart - g_max_browse
            END WHILE
         END IF
      
      WHEN "L"  
         LET g_pagestart = g_browser_cnt - (g_browser_cnt mod g_max_browse) + 1
         WHILE g_pagestart > g_browser_cnt 
            LET g_pagestart = g_pagestart - g_max_browse
         END WHILE
         
      WHEN '/'
         LET g_pagestart = g_jump
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = 1
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'azz-998'
            LET g_errparam.extend = g_jump
            LET g_errparam.popup = FALSE
            CALL cl_err()
 
         END IF
         
      OTHERWISE
         
   END CASE
   
   LET l_sql_rank = "SELECT craastus,craa001,RANK() OVER(ORDER BY craa001 ",
 
                    g_order,
                    ") AS RANK ",
                    " FROM craa_t ",
                    "  ",
                    "  LEFT JOIN craal_t ON craa001 = craal001 AND craal002 = '",g_lang,"' ",
                    " WHERE craaent = '" ||g_enterprise|| "' AND ", g_wc
 
   #add-point:browser_fill段before_pre
   LET l_sql_rank = "SELECT DISTINCT craastus,craa001,RANK() OVER(ORDER BY craa001 ",g_order,") AS RANK ",
                    "  FROM craa_t ",
                    "  LEFT JOIN craal_t ON craa001 = craal001 AND craal002 = '",g_lang,"' ",
                    "  LEFT JOIN oofb_t ON oofbent = craaent AND craa013 = oofb002",
                    "  LEFT JOIN oofc_t ON oofcent = craaent AND craa013 = oofc002",
                    "  LEFT JOIN pmaj_t ON pmajent = craaent AND craa001 = pmaj001",
                    " WHERE craaent = '" ||g_enterprise|| "' AND ", g_wc
   #end add-point					
					
   #定義翻頁CURSOR
   LET g_sql= " SELECT craastus,craa001 FROM (",l_sql_rank,") ",
              "  WHERE RANK >= ", g_pagestart,
              "    AND RANK <  ", (g_pagestart + g_max_browse) , 
              "  ORDER BY ",l_searchcol," ",g_order
 
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
   CALL g_browser.clear()
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_craa001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      
      
      #add-point:browser_fill段reference
      
      #end add-point
      
      LET g_browser[g_cnt].b_statepic = cl_get_actipic(g_browser[g_cnt].b_statepic)
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "std-00002"
         LET g_errparam.extend = "Max_Row:"||g_max_rec USING "<<<<<"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         EXIT FOREACH
      END IF
   END FOREACH
 
   CALL g_browser.deleteElement(g_cnt)
   LET g_header_cnt = g_browser_cnt
   LET g_rec_b = g_cnt - 1
   LET g_current_cnt = g_browser_cnt
   LET g_cnt = 0
   
   
   FREE browse_pre
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
   ELSE
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   END IF
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="acrm300.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION acrm300_construct()
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING 
   DEFINE ls_wc          STRING 
   #add-point:cs段define
   
   #end add-point
   
   CLEAR FORM
   INITIALIZE g_craa_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON craaunit,craa001,craal004,craal003,craal005,craa003,craa032,craastus, 
          craa004,craa005,craa006,craa007,craa008,craa009,craa010,craa011,craa012,craa014,craa015,craa016, 
          craa013,craa020,craa019,craa018,craa017,craa021,craa022,craa023,craa024,craa025,craa026,craa027, 
          craa028,craa033,craa029,craa030,craa031,craaownid,craaowndp,craacrtid,craacrtdp,craacrtdt, 
          craamodid,craamoddt,craacnfid,craacnfdt
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct
            
            #end add-point             
      
         #公用欄位開窗相關處理
         #此段落由子樣板a11產生
         ##----<<craaownid>>----
         #ON ACTION controlp INFIELD craaownid
         #   CALL q_common('craa_t','craaownid',TRUE,FALSE,g_craa_m.craaownid) RETURNING ls_return
         #   DISPLAY ls_return TO craaownid
         #   NEXT FIELD craaownid  
         #
         ##----<<craaowndp>>----
         #ON ACTION controlp INFIELD craaowndp
         #   CALL q_common('craa_t','craaowndp',TRUE,FALSE,g_craa_m.craaowndp) RETURNING ls_return
         #   DISPLAY ls_return TO craaowndp
         #   NEXT FIELD craaowndp
         #
         ##----<<craacrtid>>----
         #ON ACTION controlp INFIELD craacrtid
         #   CALL q_common('craa_t','craacrtid',TRUE,FALSE,g_craa_m.craacrtid) RETURNING ls_return
         #   DISPLAY ls_return TO craacrtid
         #   NEXT FIELD craacrtid
         #
         ##----<<craacrtdp>>----
         #ON ACTION controlp INFIELD craacrtdp
         #   CALL q_common('craa_t','craacrtdp',TRUE,FALSE,g_craa_m.craacrtdp) RETURNING ls_return
         #   DISPLAY ls_return TO craacrtdp
         #   NEXT FIELD craacrtdp
         #
         ##----<<craamodid>>----
         #ON ACTION controlp INFIELD craamodid
         #   CALL q_common('craa_t','craamodid',TRUE,FALSE,g_craa_m.craamodid) RETURNING ls_return
         #   DISPLAY ls_return TO craamodid
         #   NEXT FIELD craamodid
         #
         ##----<<craacnfid>>----
         #ON ACTION controlp INFIELD craacnfid
         #   CALL q_common('craa_t','craacnfid',TRUE,FALSE,g_craa_m.craacnfid) RETURNING ls_return
         #   DISPLAY ls_return TO craacnfid
         #   NEXT FIELD craacnfid
         #
         ##----<<craapstid>>----
         ##ON ACTION controlp INFIELD craapstid
         ##   CALL q_common('craa_t','craapstid',TRUE,FALSE,g_craa_m.craapstid) RETURNING ls_return
         ##   DISPLAY ls_return TO craapstid
         ##   NEXT FIELD craapstid
         
         ##----<<craacrtdt>>----
         AFTER FIELD craacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<craamoddt>>----
         AFTER FIELD craamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<craacnfdt>>----
         AFTER FIELD craacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<craapstdt>>----
         #AFTER FIELD craapstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
      
         #一般欄位
         #---------------------------<  Master  >---------------------------
         #----<<craaunit>>----
         #Ctrlp:construct.c.craaunit
         ON ACTION controlp INFIELD craaunit
            #add-point:ON ACTION controlp INFIELD craaunit
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.arg1 = g_site
#            LET g_qryparam.arg2 = '8'
#            CALL q_ooed004_3()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'craaunit',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO craaunit  #顯示到畫面上
            NEXT FIELD craaunit                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD craaunit
            #add-point:BEFORE FIELD craaunit
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craaunit
            
            #add-point:AFTER FIELD craaunit
            
            #END add-point
            
 
         #----<<craaunit_desc>>----
         #----<<craa001>>----
         #Ctrlp:construct.c.craa001
         ON ACTION controlp INFIELD craa001
            #add-point:ON ACTION controlp INFIELD craa001
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_craa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO craa001  #顯示到畫面上
            NEXT FIELD craa001                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD craa001
            #add-point:BEFORE FIELD craa001
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa001
            
            #add-point:AFTER FIELD craa001
            
            #END add-point
            
 
         #----<<craal004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craal004
            #add-point:BEFORE FIELD craal004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craal004
            
            #add-point:AFTER FIELD craal004
            
            #END add-point
            
 
         #Ctrlp:construct.c.craal004
         ON ACTION controlp INFIELD craal004
            #add-point:ON ACTION controlp INFIELD craal004
            
            #END add-point
 
         #----<<craal003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craal003
            #add-point:BEFORE FIELD craal003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craal003
            
            #add-point:AFTER FIELD craal003
            
            #END add-point
            
 
         #Ctrlp:construct.c.craal003
         ON ACTION controlp INFIELD craal003
            #add-point:ON ACTION controlp INFIELD craal003
            
            #END add-point
 
         #----<<craal005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craal005
            #add-point:BEFORE FIELD craal005
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craal005
            
            #add-point:AFTER FIELD craal005
            
            #END add-point
            
 
         #Ctrlp:construct.c.craal005
         ON ACTION controlp INFIELD craal005
            #add-point:ON ACTION controlp INFIELD craal005
            
            #END add-point
 
         #----<<craa003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craa003
            #add-point:BEFORE FIELD craa003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa003
            
            #add-point:AFTER FIELD craa003
            
            #END add-point
            
 
         #Ctrlp:construct.c.craa003
         ON ACTION controlp INFIELD craa003
            #add-point:ON ACTION controlp INFIELD craa003
            
            #END add-point
 
         #----<<craa032>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craa032
            #add-point:BEFORE FIELD craa032
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa032
            
            #add-point:AFTER FIELD craa032
            
            #END add-point
            
 
         #Ctrlp:construct.c.craa032
         ON ACTION controlp INFIELD craa032
            #add-point:ON ACTION controlp INFIELD craa032
            
            #END add-point
 
         #----<<craastus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craastus
            #add-point:BEFORE FIELD craastus
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craastus
            
            #add-point:AFTER FIELD craastus
            
            #END add-point
            
 
         #Ctrlp:construct.c.craastus
         ON ACTION controlp INFIELD craastus
            #add-point:ON ACTION controlp INFIELD craastus
 
            #END add-point
 
         #----<<craa004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craa004
            #add-point:BEFORE FIELD craa004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa004
            
            #add-point:AFTER FIELD craa004
            
            #END add-point
            
 
         #Ctrlp:construct.c.craa004
         ON ACTION controlp INFIELD craa004
            #add-point:ON ACTION controlp INFIELD craa004
            
            #END add-point
 
         #----<<craa005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craa005
            #add-point:BEFORE FIELD craa005
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa005
            
            #add-point:AFTER FIELD craa005
            
            #END add-point
            
 
         #Ctrlp:construct.c.craa005
         ON ACTION controlp INFIELD craa005
            #add-point:ON ACTION controlp INFIELD craa005
            
            #END add-point
 
         #----<<craa006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craa006
            #add-point:BEFORE FIELD craa006
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa006
            
            #add-point:AFTER FIELD craa006
            
            #END add-point
            
 
         #Ctrlp:construct.c.craa006
         ON ACTION controlp INFIELD craa006
            #add-point:ON ACTION controlp INFIELD craa006
            
            #END add-point
 
         #----<<craa007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craa007
            #add-point:BEFORE FIELD craa007
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa007
            
            #add-point:AFTER FIELD craa007
            
            #END add-point
            
 
         #Ctrlp:construct.c.craa007
         ON ACTION controlp INFIELD craa007
            #add-point:ON ACTION controlp INFIELD craa007
            
            #END add-point
 
         #----<<craa008>>----
         #Ctrlp:construct.c.craa008
         ON ACTION controlp INFIELD craa008
            #add-point:ON ACTION controlp INFIELD craa008
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO craa008  #顯示到畫面上
            NEXT FIELD craa008                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD craa008
            #add-point:BEFORE FIELD craa008
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa008
            
            #add-point:AFTER FIELD craa008
            
            #END add-point
            
 
         #----<<craa008_desc>>----
         #----<<craa009>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craa009
            #add-point:BEFORE FIELD craa009
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa009
            
            #add-point:AFTER FIELD craa009
            
            #END add-point
            
 
         #Ctrlp:construct.c.craa009
         ON ACTION controlp INFIELD craa009
            #add-point:ON ACTION controlp INFIELD craa009
            
            #END add-point
 
         #----<<craa010>>----
         #Ctrlp:construct.c.craa010
         ON ACTION controlp INFIELD craa010
            #add-point:ON ACTION controlp INFIELD craa010
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO craa010  #顯示到畫面上
            NEXT FIELD craa010                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD craa010
            #add-point:BEFORE FIELD craa010
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa010
            
            #add-point:AFTER FIELD craa010
            
            #END add-point
            
 
         #----<<craa010_desc>>----
         #----<<craa011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craa011
            #add-point:BEFORE FIELD craa011
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa011
            
            #add-point:AFTER FIELD craa011
            
            #END add-point
            
 
         #Ctrlp:construct.c.craa011
         ON ACTION controlp INFIELD craa011
            #add-point:ON ACTION controlp INFIELD craa011
            
            #END add-point
 
         #----<<craa012>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craa012
            #add-point:BEFORE FIELD craa012
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa012
            
            #add-point:AFTER FIELD craa012
            
            #END add-point
            
 
         #Ctrlp:construct.c.craa012
         ON ACTION controlp INFIELD craa012
            #add-point:ON ACTION controlp INFIELD craa012
            
            #END add-point
 
         #----<<craa014>>----
         #Ctrlp:construct.c.craa014
         ON ACTION controlp INFIELD craa014
            #add-point:ON ACTION controlp INFIELD craa014
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2107"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO craa014  #顯示到畫面上
            NEXT FIELD craa014                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD craa014
            #add-point:BEFORE FIELD craa014
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa014
            
            #add-point:AFTER FIELD craa014
            
            #END add-point
            
 
         #----<<craa014_desc>>----
         #----<<craa015>>----
         #Ctrlp:construct.c.craa015
         ON ACTION controlp INFIELD craa015
            #add-point:ON ACTION controlp INFIELD craa015
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "281"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO craa015  #顯示到畫面上
            NEXT FIELD craa015                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD craa015
            #add-point:BEFORE FIELD craa015
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa015
            
            #add-point:AFTER FIELD craa015
            
            #END add-point
            
 
         #----<<craa015_desc>>----
         #----<<craa016>>----
         #Ctrlp:construct.c.craa016
         ON ACTION controlp INFIELD craa016
            #add-point:ON ACTION controlp INFIELD craa016
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2105"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO craa016  #顯示到畫面上
            NEXT FIELD craa016                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD craa016
            #add-point:BEFORE FIELD craa016
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa016
            
            #add-point:AFTER FIELD craa016
            
            #END add-point
            
 
         #----<<craa016_desc>>----
         #----<<craa013>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craa013
            #add-point:BEFORE FIELD craa013
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa013
            
            #add-point:AFTER FIELD craa013
            
            #END add-point
            
 
         #Ctrlp:construct.c.craa013
         ON ACTION controlp INFIELD craa013
            #add-point:ON ACTION controlp INFIELD craa013
            
            #END add-point
 
         #----<<craa020>>----
         #Ctrlp:construct.c.craa020
         ON ACTION controlp INFIELD craa020
            #add-point:ON ACTION controlp INFIELD craa020
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '4'
            CALL q_dbaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO craa020  #顯示到畫面上
            NEXT FIELD craa020                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD craa020
            #add-point:BEFORE FIELD craa020
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa020
            
            #add-point:AFTER FIELD craa020
            
            #END add-point
            
 
         #----<<craa020_desc>>----
         #----<<craa019>>----
         #Ctrlp:construct.c.craa019
         ON ACTION controlp INFIELD craa019
            #add-point:ON ACTION controlp INFIELD craa019
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '3'
            CALL q_dbaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO craa019  #顯示到畫面上
            NEXT FIELD craa019                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD craa019
            #add-point:BEFORE FIELD craa019
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa019
            
            #add-point:AFTER FIELD craa019
            
            #END add-point
            
 
         #----<<craa019_desc>>----
         #----<<craa018>>----
         #Ctrlp:construct.c.craa018
         ON ACTION controlp INFIELD craa018
            #add-point:ON ACTION controlp INFIELD craa018
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2'
            CALL q_dbaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO craa018  #顯示到畫面上
            NEXT FIELD craa018                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD craa018
            #add-point:BEFORE FIELD craa018
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa018
            
            #add-point:AFTER FIELD craa018
            
            #END add-point
            
 
         #----<<craa018_desc>>----
         #----<<craa017>>----
         #Ctrlp:construct.c.craa017
         ON ACTION controlp INFIELD craa017
            #add-point:ON ACTION controlp INFIELD craa017
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '1'
            CALL q_dbaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO craa017  #顯示到畫面上
            NEXT FIELD craa017                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD craa017
            #add-point:BEFORE FIELD craa017
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa017
            
            #add-point:AFTER FIELD craa017
            
            #END add-point
            
 
         #----<<craa017_desc>>----
         #----<<craa021>>----
         #Ctrlp:construct.c.craa021
         ON ACTION controlp INFIELD craa021
            #add-point:ON ACTION controlp INFIELD craa021
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO craa021  #顯示到畫面上
            NEXT FIELD craa021                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD craa021
            #add-point:BEFORE FIELD craa021
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa021
            
            #add-point:AFTER FIELD craa021
            
            #END add-point
            
 
         #----<<craa021_desc>>----
         #----<<craa022>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craa022
            #add-point:BEFORE FIELD craa022
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa022
            
            #add-point:AFTER FIELD craa022
            
            #END add-point
            
 
         #Ctrlp:construct.c.craa022
         ON ACTION controlp INFIELD craa022
            #add-point:ON ACTION controlp INFIELD craa022
            
            #END add-point
 
         #----<<craa023>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craa023
            #add-point:BEFORE FIELD craa023
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa023
            
            #add-point:AFTER FIELD craa023
            
            #END add-point
            
 
         #Ctrlp:construct.c.craa023
         ON ACTION controlp INFIELD craa023
            #add-point:ON ACTION controlp INFIELD craa023
            
            #END add-point
 
         #----<<craa024>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craa024
            #add-point:BEFORE FIELD craa024
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa024
            
            #add-point:AFTER FIELD craa024
            
            #END add-point
            
 
         #Ctrlp:construct.c.craa024
         ON ACTION controlp INFIELD craa024
            #add-point:ON ACTION controlp INFIELD craa024
            
            #END add-point
 
         #----<<craa025>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craa025
            #add-point:BEFORE FIELD craa025
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa025
            
            #add-point:AFTER FIELD craa025
            
            #END add-point
            
 
         #Ctrlp:construct.c.craa025
         ON ACTION controlp INFIELD craa025
            #add-point:ON ACTION controlp INFIELD craa025
            
            #END add-point
 
         #----<<craa026>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craa026
            #add-point:BEFORE FIELD craa026
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa026
            
            #add-point:AFTER FIELD craa026
            
            #END add-point
            
 
         #Ctrlp:construct.c.craa026
         ON ACTION controlp INFIELD craa026
            #add-point:ON ACTION controlp INFIELD craa026
            
            #END add-point
 
         #----<<craa027>>----
         #Ctrlp:construct.c.craa027
         ON ACTION controlp INFIELD craa027
            #add-point:ON ACTION controlp INFIELD craa027
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO craa027  #顯示到畫面上
            NEXT FIELD craa027                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD craa027
            #add-point:BEFORE FIELD craa027
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa027
            
            #add-point:AFTER FIELD craa027
            
            #END add-point
            
 
         #----<<craa027_desc>>----
         #----<<craa028>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craa028
            #add-point:BEFORE FIELD craa028
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa028
            
            #add-point:AFTER FIELD craa028
            
            #END add-point
            
 
         #Ctrlp:construct.c.craa028
         ON ACTION controlp INFIELD craa028
            #add-point:ON ACTION controlp INFIELD craa028
            
            #END add-point
 
         #----<<craa033>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craa033
            #add-point:BEFORE FIELD craa033
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa033
            
            #add-point:AFTER FIELD craa033
            
            #END add-point
            
 
         #Ctrlp:construct.c.craa033
         ON ACTION controlp INFIELD craa033
            #add-point:ON ACTION controlp INFIELD craa033
            
            #END add-point
 
         #----<<craa029>>----
         #Ctrlp:construct.c.craa029
         ON ACTION controlp INFIELD craa029
            #add-point:ON ACTION controlp INFIELD craa029
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = 'ALL'
            CALL q_pmaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO craa029  #顯示到畫面上
            NEXT FIELD craa029                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD craa029
            #add-point:BEFORE FIELD craa029
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa029
            
            #add-point:AFTER FIELD craa029
            
            #END add-point
            
 
         #----<<craa029_desc>>----
         #----<<craa030>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craa030
            #add-point:BEFORE FIELD craa030
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa030
            
            #add-point:AFTER FIELD craa030
            
            #END add-point
            
 
         #Ctrlp:construct.c.craa030
         ON ACTION controlp INFIELD craa030
            #add-point:ON ACTION controlp INFIELD craa030
            
            #END add-point
 
         #----<<craa031>>----
         #Ctrlp:construct.c.craa031
         ON ACTION controlp INFIELD craa031
            #add-point:ON ACTION controlp INFIELD craa031
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO craa031  #顯示到畫面上
            NEXT FIELD craa031                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD craa031
            #add-point:BEFORE FIELD craa031
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa031
            
            #add-point:AFTER FIELD craa031
            
            #END add-point
            
 
         #----<<craa031_desc>>----
         #----<<craaownid>>----
         #Ctrlp:construct.c.craaownid
         ON ACTION controlp INFIELD craaownid
            #add-point:ON ACTION controlp INFIELD craaownid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO craaownid  #顯示到畫面上
            NEXT FIELD craaownid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD craaownid
            #add-point:BEFORE FIELD craaownid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craaownid
            
            #add-point:AFTER FIELD craaownid
            
            #END add-point
            
 
         #----<<craaownid_desc>>----
         #----<<craaowndp>>----
         #Ctrlp:construct.c.craaowndp
         ON ACTION controlp INFIELD craaowndp
            #add-point:ON ACTION controlp INFIELD craaowndp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO craaowndp  #顯示到畫面上
            NEXT FIELD craaowndp                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD craaowndp
            #add-point:BEFORE FIELD craaowndp
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craaowndp
            
            #add-point:AFTER FIELD craaowndp
            
            #END add-point
            
 
         #----<<craaowndp_desc>>----
         #----<<craacrtid>>----
         #Ctrlp:construct.c.craacrtid
         ON ACTION controlp INFIELD craacrtid
            #add-point:ON ACTION controlp INFIELD craacrtid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO craacrtid  #顯示到畫面上
            NEXT FIELD craacrtid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD craacrtid
            #add-point:BEFORE FIELD craacrtid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craacrtid
            
            #add-point:AFTER FIELD craacrtid
            
            #END add-point
            
 
         #----<<craacrtid_desc>>----
         #----<<craacrtdp>>----
         #Ctrlp:construct.c.craacrtdp
         ON ACTION controlp INFIELD craacrtdp
            #add-point:ON ACTION controlp INFIELD craacrtdp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO craacrtdp  #顯示到畫面上
            NEXT FIELD craacrtdp                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD craacrtdp
            #add-point:BEFORE FIELD craacrtdp
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craacrtdp
            
            #add-point:AFTER FIELD craacrtdp
            
            #END add-point
            
 
         #----<<craacrtdp_desc>>----
         #----<<craacrtdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craacrtdt
            #add-point:BEFORE FIELD craacrtdt
            
            #END add-point
 
         #----<<craamodid>>----
         #Ctrlp:construct.c.craamodid
         ON ACTION controlp INFIELD craamodid
            #add-point:ON ACTION controlp INFIELD craamodid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO craamodid  #顯示到畫面上
            NEXT FIELD craamodid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD craamodid
            #add-point:BEFORE FIELD craamodid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craamodid
            
            #add-point:AFTER FIELD craamodid
            
            #END add-point
            
 
         #----<<craamodid_desc>>----
         #----<<craamoddt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craamoddt
            #add-point:BEFORE FIELD craamoddt
            
            #END add-point
 
         #----<<craacnfid>>----
         #Ctrlp:construct.c.craacnfid
         ON ACTION controlp INFIELD craacnfid
            #add-point:ON ACTION controlp INFIELD craacnfid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO craacnfid  #顯示到畫面上
            NEXT FIELD craacnfid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD craacnfid
            #add-point:BEFORE FIELD craacnfid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craacnfid
            
            #add-point:AFTER FIELD craacnfid
            
            #END add-point
            
 
         #----<<craacnfid_desc>>----
         #----<<craacnfdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craacnfdt
            #add-point:BEFORE FIELD craacnfdt
            
            #END add-point
 
 
           
      END CONSTRUCT
      
      #add-point:cs段more_construct
#      #mark by geza 20160229(S)
#      CONSTRUCT g_wc2_table1 ON pmajstus,pmaj002,pmaj003,pmaj004,pmaj005,pmaj006,pmaj007,oofa008,oofa009, 
#          oofa010,oofa011,oofa012,oofa013,pmaj008
#           FROM s_detail1[1].pmajstus,s_detail1[1].pmaj002,s_detail1[1].pmaj003,s_detail1[1].pmaj004, 
#               s_detail1[1].pmaj005,s_detail1[1].pmaj006,s_detail1[1].pmaj007,s_detail1[1].oofa008,s_detail1[1].oofa009, 
#               s_detail1[1].oofa010,s_detail1[1].oofa011,s_detail1[1].oofa012,s_detail1[1].oofa013,s_detail1[1].pmaj008 
#      #mark by geza 20160229(E)    
      #add by geza 20160229(S)
      CONSTRUCT g_wc2_table1 ON pmajstus,pmaj002,pmaj003,pmaj004,pmaj005,pmaj006,pmaj007,pmaj009,pmaj010, 
          pmaj011,pmaj012,pmaj013,pmaj014,pmaj008
           FROM s_detail1[1].pmajstus,s_detail1[1].pmaj002,s_detail1[1].pmaj003,s_detail1[1].pmaj004, 
               s_detail1[1].pmaj005,s_detail1[1].pmaj006,s_detail1[1].pmaj007,s_detail1[1].pmaj009,s_detail1[1].pmaj010, 
               s_detail1[1].pmaj011,s_detail1[1].pmaj012,s_detail1[1].pmaj013,s_detail1[1].pmaj014,s_detail1[1].pmaj008 
      #mark by geza 20160229(E)                    
         BEFORE CONSTRUCT

         ON ACTION controlp INFIELD pmaj003
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where= " oocqstus = 'Y' "
            LET g_qryparam.arg1 = "259"
            CALL q_oocq002()                       #呼叫開窗
            LET g_qryparam.where= " "
            DISPLAY g_qryparam.return1 TO pmaj003  #顯示到畫面上
            NEXT FIELD pmaj003                     #返回原欄位

      END CONSTRUCT
      SUBDIALOG aoo_aooi350_01.aooi350_01_construct
      SUBDIALOG aoo_aooi350_02.aooi350_02_construct

      #end add-point   
      
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog
         
         #end add-point  
      
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG
  
   #add-point:cs段after_construct
   LET g_wc = g_wc CLIPPED , " AND ",g_wc2_i35001 ," AND ",g_wc2_i35002," AND ",g_wc2_table1
   #end add-point
  
   #LET g_wc = g_wc CLIPPED,cl_get_extra_cond("", "")
 
END FUNCTION
 
{</section>}
 
{<section id="acrm300.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION acrm300_query()
   DEFINE ls_wc STRING
   #add-point:query段define
   
   #end add-point
   
   LET INT_FLAG = 0
   LET ls_wc = g_wc
   
   #切換畫面
 
   CALL g_browser.clear() 
 
   IF g_worksheet_hidden THEN  #browser panel折疊
      CALL gfrm_curr.setElementHidden("worksheet_vbox",0)
      CALL gfrm_curr.setElementImage("worksheethidden","worksheethidden-24.png")
      LET g_worksheet_hidden = 0
   END IF
   IF g_header_hidden THEN    #單頭折疊
      CALL gfrm_curr.setElementHidden("vb_master",0)
      CALL gfrm_curr.setElementImage("controls","headerhidden-24")
      LET g_header_hidden = 0
   END IF
 
   INITIALIZE g_craa_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL acrm300_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL acrm300_browser_fill(g_wc,"F")
      CALL acrm300_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   LET g_error_show = 1
   CALL acrm300_browser_fill(g_wc,"F")   # 移到第一頁
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||")")
   
   #備份搜尋條件
   LET ls_wc = g_wc
   
   IF g_browser.getLength() = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "-100"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
   ELSE
      CALL acrm300_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="acrm300.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION acrm300_fetch(p_fl)
   DEFINE p_fl       LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define

   #end add-point  
   
   CASE p_fl
      WHEN "F" LET g_current_idx = 1
      WHEN "P"
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN "N"
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN "L" 
         LET g_current_idx = g_header_cnt        
      WHEN "/"
         IF (NOT g_no_ask) THEN      
            CALL cl_getmsg("fetch", g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,": " FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl"
            END PROMPT
            
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE  
            END IF           
         END IF
         IF g_jump > 0 THEN
            LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE     
   END CASE
   
   LET g_browser_cnt = g_browser.getLength()
   
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index        #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.b_count        #總筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index        #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count        #總筆數
   CALL ui.Interface.refresh()
   
   #單頭筆數顯示
   #DISPLAY g_browser_idx TO FORMONLY.idx            #當下筆數
   #DISPLAY g_browser_cnt TO FORMONLY.cnt            #總筆數
   
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   # 設定browse索引
 
   CALL cl_navigator_setting(g_browser_idx, g_browser_cnt )
 
   #代表沒有資料, 無需做後續資料撈取之動作
   IF g_current_idx = 0 THEN
      RETURN
   END IF
 
   LET g_craa_m.craa001 = g_browser[g_current_idx].b_craa001
 
                       
   #重讀DB,因TEMP有不被更新特性
    SELECT UNIQUE craaunit,craa001,craa003,craa032,craastus,craa004,craa005,craa006,craa007,craa008, 
        craa009,craa010,craa011,craa012,craa014,craa015,craa016,craa013,craa020,craa019,craa018,craa017, 
        craa021,craa022,craa023,craa024,craa025,craa026,craa027,craa028,craa033,craa029,craa030,craa031, 
        craaownid,craaowndp,craacrtid,craacrtdp,craacrtdt,craamodid,craamoddt,craacnfid,craacnfdt
 INTO g_craa_m.craaunit,g_craa_m.craa001,g_craa_m.craa003,g_craa_m.craa032,g_craa_m.craastus,g_craa_m.craa004, 
     g_craa_m.craa005,g_craa_m.craa006,g_craa_m.craa007,g_craa_m.craa008,g_craa_m.craa009,g_craa_m.craa010, 
     g_craa_m.craa011,g_craa_m.craa012,g_craa_m.craa014,g_craa_m.craa015,g_craa_m.craa016,g_craa_m.craa013, 
     g_craa_m.craa020,g_craa_m.craa019,g_craa_m.craa018,g_craa_m.craa017,g_craa_m.craa021,g_craa_m.craa022, 
     g_craa_m.craa023,g_craa_m.craa024,g_craa_m.craa025,g_craa_m.craa026,g_craa_m.craa027,g_craa_m.craa028, 
     g_craa_m.craa033,g_craa_m.craa029,g_craa_m.craa030,g_craa_m.craa031,g_craa_m.craaownid,g_craa_m.craaowndp, 
     g_craa_m.craacrtid,g_craa_m.craacrtdp,g_craa_m.craacrtdt,g_craa_m.craamodid,g_craa_m.craamoddt, 
     g_craa_m.craacnfid,g_craa_m.craacnfdt
 FROM craa_t
 WHERE craaent = g_enterprise AND craa001 = g_craa_m.craa001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "craa_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      INITIALIZE g_craa_m.* TO NULL
      RETURN
   END IF
   
   #add-point:fetch段action控制
   CALL acrm300_act_set_no_entry()
   CALL acrm300_act_set_entry()
   #end add-point  
   
   
   
   #重新顯示
   CALL acrm300_show()
 
END FUNCTION
 
{</section>}
 
{<section id="acrm300.insert" >}
#+ 資料新增
PRIVATE FUNCTION acrm300_insert()
   #add-point:insert段define
   DEFINE l_insert      LIKE type_t.num5
   #end add-point    
   
   CLEAR FORM #清畫面欄位內容
 
   INITIALIZE g_craa_m.* LIKE craa_t.*             #DEFAULT 設定
   LET g_craa001_t = NULL
 
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      #六階樹狀給值
 
      
      #公用欄位給值
      #此段落由子樣板a14產生    
      LET g_craa_m.craaownid = g_user
      LET g_craa_m.craaowndp = g_dept
      LET g_craa_m.craacrtid = g_user
      LET g_craa_m.craacrtdp = g_dept 
      LET g_craa_m.craacrtdt = cl_get_current()
      LET g_craa_m.craamodid = ""
      LET g_craa_m.craamoddt = ""
      #LET g_craa_m.craastus = ""
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_craa_m.craa032 = "0"
      LET g_craa_m.craastus = "N"
 
 
      #add-point:單頭預設值
      LET g_ins_site_flag = FALSE   #161024-00025#6--add
      CALL s_aooi500_default(g_prog,'craaunit',g_site)
         RETURNING l_insert,g_craa_m.craaunit
      IF l_insert = FALSE THEN
         RETURN
      END IF
      CALL　s_desc_get_department_desc(g_craa_m.craaunit) RETURNING g_craa_m.craaunit_desc
      DISPLAY BY NAME g_craa_m.craaunit_desc
      LET g_craa_m.craa013 = ''
      LET g_pmaa027_d = ''
      CALL aooi350_01_clear_detail()
      CALL aooi350_02_clear_detail()
      LET g_craa_m_t.* = g_craa_m.*
      LET g_craa_m_o.* = g_craa_m.*
      #end add-point   
     
      CALL acrm300_input("a")
      
      #add-point:單頭輸入後
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_craa_m.* = g_craa_m_t.*
         CALL acrm300_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         EXIT WHILE
      END IF
 
      LET g_rec_b = 0
      EXIT WHILE
   END WHILE
   
   LET g_craa001_t = g_craa_m.craa001
 
   
   LET g_state = "Y"
 
   LET g_wc = g_wc,  
              " OR ( craaent = '" ||g_enterprise|| "' AND",
              " craa001 = '", g_craa_m.craa001 CLIPPED, "' "
 
              , ") "
 
END FUNCTION
 
{</section>}
 
{<section id="acrm300.modify" >}
#+ 資料修改
PRIVATE FUNCTION acrm300_modify()
   #add-point:modify段define

   #end add-point
   
   IF g_craa_m.craa001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      RETURN
   END IF 
   
    SELECT UNIQUE craaunit,craa001,craa003,craa032,craastus,craa004,craa005,craa006,craa007,craa008, 
        craa009,craa010,craa011,craa012,craa014,craa015,craa016,craa013,craa020,craa019,craa018,craa017, 
        craa021,craa022,craa023,craa024,craa025,craa026,craa027,craa028,craa033,craa029,craa030,craa031, 
        craaownid,craaowndp,craacrtid,craacrtdp,craacrtdt,craamodid,craamoddt,craacnfid,craacnfdt
 INTO g_craa_m.craaunit,g_craa_m.craa001,g_craa_m.craa003,g_craa_m.craa032,g_craa_m.craastus,g_craa_m.craa004, 
     g_craa_m.craa005,g_craa_m.craa006,g_craa_m.craa007,g_craa_m.craa008,g_craa_m.craa009,g_craa_m.craa010, 
     g_craa_m.craa011,g_craa_m.craa012,g_craa_m.craa014,g_craa_m.craa015,g_craa_m.craa016,g_craa_m.craa013, 
     g_craa_m.craa020,g_craa_m.craa019,g_craa_m.craa018,g_craa_m.craa017,g_craa_m.craa021,g_craa_m.craa022, 
     g_craa_m.craa023,g_craa_m.craa024,g_craa_m.craa025,g_craa_m.craa026,g_craa_m.craa027,g_craa_m.craa028, 
     g_craa_m.craa033,g_craa_m.craa029,g_craa_m.craa030,g_craa_m.craa031,g_craa_m.craaownid,g_craa_m.craaowndp, 
     g_craa_m.craacrtid,g_craa_m.craacrtdp,g_craa_m.craacrtdt,g_craa_m.craamodid,g_craa_m.craamoddt, 
     g_craa_m.craacnfid,g_craa_m.craacnfdt
 FROM craa_t
 WHERE craaent = g_enterprise AND craa001 = g_craa_m.craa001
 
   ERROR ""
  
   LET g_craa001_t = g_craa_m.craa001
 
   
   CALL s_transaction_begin()
   
   OPEN acrm300_cl USING g_enterprise,g_craa_m.craa001
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN acrm300_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      CLOSE acrm300_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH acrm300_cl INTO g_craa_m.craaunit,g_craa_m.craaunit_desc,g_craa_m.craa001,g_craa_m.craal004, 
       g_craa_m.craal003,g_craa_m.craal005,g_craa_m.craa003,g_craa_m.craa032,g_craa_m.craastus,g_craa_m.craa004, 
       g_craa_m.craa005,g_craa_m.craa006,g_craa_m.craa007,g_craa_m.craa008,g_craa_m.craa008_desc,g_craa_m.craa009, 
       g_craa_m.craa010,g_craa_m.craa010_desc,g_craa_m.craa011,g_craa_m.craa012,g_craa_m.craa014,g_craa_m.craa014_desc, 
       g_craa_m.craa015,g_craa_m.craa015_desc,g_craa_m.craa016,g_craa_m.craa016_desc,g_craa_m.craa013, 
       g_craa_m.craa020,g_craa_m.craa020_desc,g_craa_m.craa019,g_craa_m.craa019_desc,g_craa_m.craa018, 
       g_craa_m.craa018_desc,g_craa_m.craa017,g_craa_m.craa017_desc,g_craa_m.craa021,g_craa_m.craa021_desc, 
       g_craa_m.craa022,g_craa_m.craa023,g_craa_m.craa024,g_craa_m.craa025,g_craa_m.craa026,g_craa_m.craa027, 
       g_craa_m.craa027_desc,g_craa_m.craa028,g_craa_m.craa033,g_craa_m.craa029,g_craa_m.craa029_desc, 
       g_craa_m.craa030,g_craa_m.craa031,g_craa_m.craa031_desc,g_craa_m.craaownid,g_craa_m.craaownid_desc, 
       g_craa_m.craaowndp,g_craa_m.craaowndp_desc,g_craa_m.craacrtid,g_craa_m.craacrtid_desc,g_craa_m.craacrtdp, 
       g_craa_m.craacrtdp_desc,g_craa_m.craacrtdt,g_craa_m.craamodid,g_craa_m.craamodid_desc,g_craa_m.craamoddt, 
       g_craa_m.craacnfid,g_craa_m.craacnfid_desc,g_craa_m.craacnfdt
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "craa_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      CLOSE acrm300_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #160818-00017#5 -s by 08172
   #檢查是否允許此動作
   IF NOT acrm300_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #160818-00017#5 -e by 08172
 
   CALL acrm300_show()
   
   WHILE TRUE
      LET g_craa_m.craa001 = g_craa001_t
 
      
      #寫入修改者/修改日期資訊
      LET g_craa_m.craamodid = g_user 
LET g_craa_m.craamoddt = cl_get_current()
 
      
      #add-point:modify段修改前

      #end add-point
 
      CALL acrm300_input("u")     #欄位更改
 
      #add-point:modify段修改後

      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_craa_m.* = g_craa_m_t.*
         CALL acrm300_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         EXIT WHILE
      END IF
 
      EXIT WHILE
      
   END WHILE
 
   #修改歷程記錄
   IF NOT cl_log_modified_record(g_craa_m.craa001,g_site) THEN 
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE acrm300_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-U
   CALL cl_flow_notify(g_craa_m.craa001,"U")
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="acrm300.input" >}
#+ 資料輸入
PRIVATE FUNCTION acrm300_input(p_cmd)
   DEFINE p_cmd           LIKE type_t.chr1
   DEFINE l_ac_t          LIKE type_t.num5        #未取消的ARRAY CNT 
   DEFINE l_n             LIKE type_t.num5        #檢查重複用  
   DEFINE l_cnt           LIKE type_t.num5        #檢查重複用  
   DEFINE l_lock_sw       LIKE type_t.chr1        #單身鎖住否  
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   DEFINE ls_return       STRING
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   #add-point:input段define
   DEFINE l_success             LIKE type_t.num5
   DEFINE l_cmd_t               LIKE type_t.chr1
   DEFINE l_cmd                 LIKE type_t.chr1
   DEFINE lb_reproduce          BOOLEAN
   DEFINE l_oofa001             LIKE oofa_t.oofa001   
   DEFINE l_pmaa002             LIKE pmaa_t.pmaa002
   DEFINE li_reproduce_target   LIKE type_t.num5
   DEFINE li_reproduce          LIKE type_t.num5
   DEFINE l_where               STRING
   DEFINE l_errno               LIKE type_t.chr10
   #end add-point
 
   #切換畫面
   
   CALL cl_set_head_visible("","YES")  
   
   IF p_cmd = 'r' THEN
      #此段落的r動作等同於a
      LET p_cmd = 'a'
   END IF
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   LET g_qryparam.state = "i"
   
   #控制key欄位可否輸入
   CALL acrm300_set_entry(p_cmd)
   #add-point:set_entry後
   LET g_forupd_sql = "SELECT pmajstus,pmaj002,pmaj003,pmaj004,pmaj005,pmaj006,pmaj007,pmaj008 FROM  
       pmaj_t WHERE pmajent=? AND pmaj001=? AND pmaj002=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE acrm300_bcl CURSOR FROM g_forupd_sql
   #end add-point
   CALL acrm300_set_no_entry(p_cmd)
   #add-point:資料輸入前
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_detail_insert = l_allow_insert
   LET g_detail_delete = l_allow_delete
   #end add-point
   
   DISPLAY BY NAME g_craa_m.craaunit,g_craa_m.craa001,g_craa_m.craal004,g_craa_m.craal003,g_craa_m.craal005, 
       g_craa_m.craa003,g_craa_m.craa032,g_craa_m.craastus,g_craa_m.craa004,g_craa_m.craa005,g_craa_m.craa006, 
       g_craa_m.craa007,g_craa_m.craa008,g_craa_m.craa009,g_craa_m.craa010,g_craa_m.craa011,g_craa_m.craa012, 
       g_craa_m.craa014,g_craa_m.craa015,g_craa_m.craa016,g_craa_m.craa013,g_craa_m.craa020,g_craa_m.craa019, 
       g_craa_m.craa018,g_craa_m.craa017,g_craa_m.craa021,g_craa_m.craa022,g_craa_m.craa023,g_craa_m.craa024, 
       g_craa_m.craa025,g_craa_m.craa026,g_craa_m.craa027,g_craa_m.craa028,g_craa_m.craa033,g_craa_m.craa029, 
       g_craa_m.craa030,g_craa_m.craa031
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_craa_m.craaunit,g_craa_m.craa001,g_craa_m.craal004,g_craa_m.craal003,g_craa_m.craal005, 
          g_craa_m.craa003,g_craa_m.craa032,g_craa_m.craastus,g_craa_m.craa004,g_craa_m.craa005,g_craa_m.craa006, 
          g_craa_m.craa007,g_craa_m.craa008,g_craa_m.craa009,g_craa_m.craa010,g_craa_m.craa011,g_craa_m.craa012, 
          g_craa_m.craa014,g_craa_m.craa015,g_craa_m.craa016,g_craa_m.craa013,g_craa_m.craa020,g_craa_m.craa019, 
          g_craa_m.craa018,g_craa_m.craa017,g_craa_m.craa021,g_craa_m.craa022,g_craa_m.craa023,g_craa_m.craa024, 
          g_craa_m.craa025,g_craa_m.craa026,g_craa_m.craa027,g_craa_m.craa028,g_craa_m.craa033,g_craa_m.craa029, 
          g_craa_m.craa030,g_craa_m.craa031 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
 
         ON ACTION update_item
            #add-point:ON ACTION update_item
            IF NOT cl_null(g_craa_m.craa001)  THEN
               CALL n_craal(g_craa_m.craa001)
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_craa_m.craa001
               CALL ap_ref_array2(g_ref_fields," SELECT craal003,craal004,craal005 FROM craal_t WHERE craalent = '"||g_enterprise||"' AND craal001 = ? AND craal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_craa_m.craal003 = g_rtn_fields[1]
               LET g_craa_m.craal004 = g_rtn_fields[2]
               LET g_craa_m.craal005 = g_rtn_fields[3]
               DISPLAY BY NAME g_craa_m.craal003,g_craa_m.craal004,g_craa_m.craal005
            END IF
            #END add-point
 
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)
            LET g_master_multi_table_t.craal001 = g_craa_m.craa001
LET g_master_multi_table_t.craal004 = g_craa_m.craal004
LET g_master_multi_table_t.craal003 = g_craa_m.craal003
LET g_master_multi_table_t.craal005 = g_craa_m.craal005
 
            #add-point:input開始前
            LET g_craa_m_o.* = g_craa_m.*
            CALL cl_showmsg_init()
            #end add-point
   
         #---------------------------<  Master  >---------------------------
         #----<<craaunit>>----
         #此段落由子樣板a02產生
         AFTER FIELD craaunit
            
            #add-point:AFTER FIELD craaunit
            
            LET g_craa_m.craaunit_desc = ' '
            DISPLAY BY NAME g_craa_m.craaunit_desc
            IF NOT cl_null(g_craa_m.craaunit) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_craa_m.craaunit != g_craa_m_o.craaunit OR g_craa_m_o.craaunit IS NULL )) THEN
                  CALL s_aooi500_chk(g_prog,'craaunit',g_craa_m.craaunit,g_site)
                     RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_craa_m.craaunit = g_craa_m_o.craaunit
                     CALL s_desc_get_department_desc(g_craa_m.craaunit) RETURNING g_craa_m.craaunit_desc
                     DISPLAY BY NAME g_craa_m.craaunit_desc
                     NEXT FIELD CURRENT
                  ELSE
                     LET g_ins_site_flag = TRUE  #161024-00025#6--add
                  END IF
               END IF
            END IF
            CALL s_desc_get_department_desc(g_craa_m.craaunit) RETURNING g_craa_m.craaunit_desc
            DISPLAY BY NAME g_craa_m.craaunit_desc
            LET g_craa_m_o.craaunit = g_craa_m.craaunit
            
            CALL acrm300_set_entry(p_cmd)      #161024-00025#6--add
            CALL acrm300_set_no_entry(p_cmd)   #161024-00025#6--add  
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD craaunit
            #add-point:BEFORE FIELD craaunit

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE craaunit
            #add-point:ON CHANGE craaunit

            #END add-point
 
         #----<<craaunit_desc>>----
         #----<<craa001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craa001
            #add-point:BEFORE FIELD craa001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa001
            
            #add-point:AFTER FIELD craa001
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_craa_m.craa001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_craa_m.craa001 != g_craa001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM craa_t WHERE "||"craaent = '" ||g_enterprise|| "' AND "||"craa001 = '"||g_craa_m.craa001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE craa001
            #add-point:ON CHANGE craa001

            #END add-point
 
         #----<<craal004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craal004
            #add-point:BEFORE FIELD craal004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craal004
            
            #add-point:AFTER FIELD craal004

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE craal004
            #add-point:ON CHANGE craal004

            #END add-point
 
         #----<<craal003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craal003
            #add-point:BEFORE FIELD craal003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craal003
            
            #add-point:AFTER FIELD craal003

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE craal003
            #add-point:ON CHANGE craal003

            #END add-point
 
         #----<<craal005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craal005
            #add-point:BEFORE FIELD craal005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craal005
            
            #add-point:AFTER FIELD craal005

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE craal005
            #add-point:ON CHANGE craal005

            #END add-point
 
         #----<<craa003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craa003
            #add-point:BEFORE FIELD craa003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa003
            
            #add-point:AFTER FIELD craa003
            IF NOT cl_null(g_craa_m.craa003) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_craa_m.craa003 != g_craa_m_t.craa003 OR cl_null(g_craa_m_t.craa003))) THEN
                  LET l_n = 0
                  IF cl_null(g_craa_m.craa001) THEN
                     SELECT COUNT(*) INTO l_n
                       FROM craa_t
                      WHERE craaent = g_enterprise
                        AND craa003 = g_craa_m.craa003
                  ELSE
                     SELECT COUNT(*) INTO l_n
                       FROM craa_t
                      WHERE craaent = g_enterprise
                        AND craa001 <> g_craa_m.craa001
                        AND craa003 = g_craa_m.craa003
                  END IF
                  IF l_n > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'acr-00070'
                     LET g_errparam.extend = g_craa_m.craa003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_craa_m.craa003 = g_craa_m_t.craa003
                     DISPLAY BY NAME g_craa_m.craa003
                     NEXT FIELD craa003
                  END IF
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE craa003
            #add-point:ON CHANGE craa003

            #END add-point
 
         #----<<craa032>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craa032
            #add-point:BEFORE FIELD craa032

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa032
            
            #add-point:AFTER FIELD craa032

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE craa032
            #add-point:ON CHANGE craa032

            #END add-point
 
         #----<<craastus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craastus
            #add-point:BEFORE FIELD craastus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craastus
            
            #add-point:AFTER FIELD craastus
 
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE craastus
            #add-point:ON CHANGE craastus

            #END add-point
 
         #----<<craa004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craa004
            #add-point:BEFORE FIELD craa004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa004
            
            #add-point:AFTER FIELD craa004

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE craa004
            #add-point:ON CHANGE craa004

            #END add-point
 
         #----<<craa005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craa005
            #add-point:BEFORE FIELD craa005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa005
            
            #add-point:AFTER FIELD craa005

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE craa005
            #add-point:ON CHANGE craa005

            #END add-point
 
         #----<<craa006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craa006
            #add-point:BEFORE FIELD craa006

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa006
            
            #add-point:AFTER FIELD craa006

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE craa006
            #add-point:ON CHANGE craa006

            #END add-point
 
         #----<<craa007>>----
         #此段落由子樣板a02產生
         AFTER FIELD craa007
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_craa_m.craa007,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD craa007
            END IF
 
 
            #add-point:AFTER FIELD craa007
            IF NOT cl_null(g_craa_m.craa007) THEN 
            END IF 


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD craa007
            #add-point:BEFORE FIELD craa007

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE craa007
            #add-point:ON CHANGE craa007

            #END add-point
 
         #----<<craa008>>----
         #此段落由子樣板a02產生
         AFTER FIELD craa008
            
            #add-point:AFTER FIELD craa008
            LET g_craa_m.craa008_desc = ' '
            DISPLAY BY NAME g_craa_m.craa008_desc
            IF NOT cl_null(g_craa_m.craa008) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_craa_m.craa008 != g_craa_m_o.craa008 OR g_craa_m_o.craa008 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_craa_m.craaunit
                  LET g_chkparam.arg2 = g_craa_m.craa008
                  #160318-00025#27  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
                  #160318-00025#27  by 07900 --add-end
                  IF NOT cl_chk_exist("v_ooaj002") THEN
                     LET g_craa_m.craa008 = g_craa_m_o.craa008
                     CALL s_desc_get_currency_desc(g_craa_m.craa008) RETURNING g_craa_m.craa008_desc
                     DISPLAY BY NAME g_craa_m.craa008_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_currency_desc(g_craa_m.craa008) RETURNING g_craa_m.craa008_desc
            DISPLAY BY NAME g_craa_m.craa008_desc
            LET g_craa_m_o.craa008 = g_craa_m.craa008
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD craa008
            #add-point:BEFORE FIELD craa008

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE craa008
            #add-point:ON CHANGE craa008

            #END add-point
 
         #----<<craa008_desc>>----
         #----<<craa009>>----
         #此段落由子樣板a02產生
         AFTER FIELD craa009
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_craa_m.craa009,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD craa009
            END IF
 
 
            #add-point:AFTER FIELD craa009
            IF NOT cl_null(g_craa_m.craa009) THEN 
            END IF 


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD craa009
            #add-point:BEFORE FIELD craa009

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE craa009
            #add-point:ON CHANGE craa009

            #END add-point
 
         #----<<craa010>>----
         #此段落由子樣板a02產生
         AFTER FIELD craa010
            
            #add-point:AFTER FIELD craa010
            LET g_craa_m.craa010_desc = ' '
            DISPLAY BY NAME g_craa_m.craa010_desc
            IF NOT cl_null(g_craa_m.craa008) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_craa_m.craa010 != g_craa_m_o.craa010 OR g_craa_m_o.craa010 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_craa_m.craaunit
                  LET g_chkparam.arg2 = g_craa_m.craa010
                  #160318-00025#27  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
                  #160318-00025#27  by 07900 --add-end
                  IF NOT cl_chk_exist("v_ooaj002") THEN
                     LET g_craa_m.craa010 = g_craa_m_o.craa010
                     CALL s_desc_get_currency_desc(g_craa_m.craa010) RETURNING g_craa_m.craa010_desc
                     DISPLAY BY NAME g_craa_m.craa010_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_currency_desc(g_craa_m.craa010) RETURNING g_craa_m.craa010_desc
            DISPLAY BY NAME g_craa_m.craa010_desc
            LET g_craa_m_o.craa010 = g_craa_m.craa010
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD craa010
            #add-point:BEFORE FIELD craa010

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE craa010
            #add-point:ON CHANGE craa010

            #END add-point
 
         #----<<craa010_desc>>----
         #----<<craa011>>----
         #此段落由子樣板a02產生
         AFTER FIELD craa011
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_craa_m.craa011,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD craa011
            END IF
 
 
            #add-point:AFTER FIELD craa011
            IF NOT cl_null(g_craa_m.craa011) THEN 
            END IF 


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD craa011
            #add-point:BEFORE FIELD craa011

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE craa011
            #add-point:ON CHANGE craa011

            #END add-point
 
         #----<<craa012>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craa012
            #add-point:BEFORE FIELD craa012

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa012
            
            #add-point:AFTER FIELD craa012

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE craa012
            #add-point:ON CHANGE craa012

            #END add-point
 
         #----<<craa014>>----
         #此段落由子樣板a02產生
         AFTER FIELD craa014
            
            #add-point:AFTER FIELD craa014
            LET g_craa_m.craa014_desc = ' '
            DISPLAY BY NAME g_craa_m.craa014_desc
            IF NOT cl_null(g_craa_m.craa014) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_craa_m.craa014 != g_craa_m_o.craa014 OR g_craa_m_o.craa014 IS NULL )) THEN
                  IF NOT s_azzi650_chk_exist('2107',g_craa_m.craa014) THEN
                     LET g_craa_m.craa014 = g_craa_m_o.craa014
                     CALL s_desc_get_acc_desc('2107',g_craa_m.craa014) RETURNING g_craa_m.craa014_desc
                     DISPLAY BY NAME g_craa_m.craa014_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_acc_desc('2107',g_craa_m.craa014) RETURNING g_craa_m.craa014_desc
            DISPLAY BY NAME g_craa_m.craa014_desc
            LET g_craa_m_o.craa014 = g_craa_m.craa014
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD craa014
            #add-point:BEFORE FIELD craa014

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE craa014
            #add-point:ON CHANGE craa014

            #END add-point
 
         #----<<craa014_desc>>----
         #----<<craa015>>----
         #此段落由子樣板a02產生
         AFTER FIELD craa015
            
            #add-point:AFTER FIELD craa015
            LET g_craa_m.craa015_desc = ' '
            DISPLAY BY NAME g_craa_m.craa015_desc
            IF NOT cl_null(g_craa_m.craa015) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_craa_m.craa015 != g_craa_m_o.craa015 OR g_craa_m_o.craa015 IS NULL )) THEN
                  IF NOT s_azzi650_chk_exist('281',g_craa_m.craa015) THEN
                     LET g_craa_m.craa015 = g_craa_m_o.craa015
                     CALL s_desc_get_acc_desc('281',g_craa_m.craa015) RETURNING g_craa_m.craa015_desc
                     DISPLAY BY NAME g_craa_m.craa015_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_acc_desc('281',g_craa_m.craa015) RETURNING g_craa_m.craa015_desc
            DISPLAY BY NAME g_craa_m.craa015_desc
            LET g_craa_m_o.craa015 = g_craa_m.craa015
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD craa015
            #add-point:BEFORE FIELD craa015

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE craa015
            #add-point:ON CHANGE craa015

            #END add-point
 
         #----<<craa015_desc>>----
         #----<<craa016>>----
         #此段落由子樣板a02產生
         AFTER FIELD craa016
            
            #add-point:AFTER FIELD craa016
            LET g_craa_m.craa016_desc = ' '
            DISPLAY BY NAME g_craa_m.craa016_desc
            IF NOT cl_null(g_craa_m.craa016) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_craa_m.craa016 != g_craa_m_o.craa016 OR g_craa_m_o.craa016 IS NULL )) THEN
                  IF NOT s_azzi650_chk_exist('2105',g_craa_m.craa016) THEN
                     LET g_craa_m.craa016 = g_craa_m_o.craa016
                     CALL s_desc_get_acc_desc('2105',g_craa_m.craa016) RETURNING g_craa_m.craa016_desc
                     DISPLAY BY NAME g_craa_m.craa016_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_acc_desc('2105',g_craa_m.craa016) RETURNING g_craa_m.craa016_desc
            DISPLAY BY NAME g_craa_m.craa016_desc
            LET g_craa_m_o.craa016 = g_craa_m.craa016
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD craa016
            #add-point:BEFORE FIELD craa016

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE craa016
            #add-point:ON CHANGE craa016

            #END add-point
 
         #----<<craa016_desc>>----
         #----<<craa013>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craa013
            #add-point:BEFORE FIELD craa013

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa013
            
            #add-point:AFTER FIELD craa013

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE craa013
            #add-point:ON CHANGE craa013

            #END add-point
 
         #----<<craa020>>----
         #此段落由子樣板a02產生
         AFTER FIELD craa020
            
            #add-point:AFTER FIELD craa020
            LET g_craa_m.craa020_desc = ' '
            DISPLAY BY NAME g_craa_m.craa020_desc
            IF NOT cl_null(g_craa_m.craa020) THEN
               IF g_craa_m.craa020 != g_craa_m_o.craa020 OR g_craa_m_o.craa020 IS NULL THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_craa_m.craa020
                  LET g_chkparam.arg2 = '4'
                  LET g_chkparam.err_str[1] = "acr-00004|",'4'
                  IF NOT cl_chk_exist("v_dbaa001_1") THEN
                     LET g_craa_m.craa020 = g_craa_m_o.craa020
                     CALL s_desc_get_dbaa001_desc(g_craa_m.craa020) RETURNING g_craa_m.craa020_desc
                     DISPLAY BY NAME g_craa_m.craa020_desc
                     NEXT FIELD CURRENT
                  END IF
                  IF cl_null(g_craa_m.craa019) THEN
                     CALL acrm300_get_dbaa003(g_craa_m.craa020,'4') RETURNING g_craa_m.craa019
                     CALL acrm300_get_dbaa003(g_craa_m.craa019,'3') RETURNING g_craa_m.craa018
                     CALL acrm300_get_dbaa003(g_craa_m.craa018,'2') RETURNING g_craa_m.craa017
                     CALL s_desc_get_dbaa001_desc(g_craa_m.craa019) RETURNING g_craa_m.craa019_desc
                     CALL s_desc_get_dbaa001_desc(g_craa_m.craa018) RETURNING g_craa_m.craa018_desc
                     CALL s_desc_get_dbaa001_desc(g_craa_m.craa017) RETURNING g_craa_m.craa017_desc
                     DISPLAY BY NAME g_craa_m.craa019_desc,g_craa_m.craa018_desc,g_craa_m.craa017_desc
                  END IF
               END IF
            END IF
            LET g_craa_m_o.craa017 = g_craa_m.craa017
            LET g_craa_m_o.craa018 = g_craa_m.craa018
            LET g_craa_m_o.craa019 = g_craa_m.craa019
            LET g_craa_m_o.craa020 = g_craa_m.craa020
            CALL s_desc_get_dbaa001_desc(g_craa_m.craa020) RETURNING g_craa_m.craa020_desc
            DISPLAY BY NAME g_craa_m.craa020_desc
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD craa020
            #add-point:BEFORE FIELD craa020

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE craa020
            #add-point:ON CHANGE craa020

            #END add-point
 
         #----<<craa020_desc>>----
         #----<<craa019>>----
         #此段落由子樣板a02產生
         AFTER FIELD craa019
            
            #add-point:AFTER FIELD craa019
            LET g_craa_m.craa019_desc = ' '
            DISPLAY BY NAME g_craa_m.craa019_desc
            IF NOT cl_null(g_craa_m.craa019) THEN
               IF g_craa_m.craa019 != g_craa_m_o.craa019 OR g_craa_m_o.craa019 IS NULL  THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_craa_m.craa019
                  LET g_chkparam.arg2 = '3'
                  LET g_chkparam.err_str[1] = "acr-00004|",'3'
                  IF NOT cl_chk_exist("v_dbaa001_1") THEN
                     LET g_craa_m.craa019 = g_craa_m_o.craa019
                     CALL s_desc_get_dbaa001_desc(g_craa_m.craa019) RETURNING g_craa_m.craa019_desc
                     DISPLAY BY NAME g_craa_m.craa019_desc
                     NEXT FIELD CURRENT
                  END IF
                  IF cl_null(g_craa_m.craa018) THEN
                     CALL acrm300_get_dbaa003(g_craa_m.craa019,'3') RETURNING g_craa_m.craa018
                     CALL acrm300_get_dbaa003(g_craa_m.craa018,'2') RETURNING g_craa_m.craa017
                     CALL s_desc_get_dbaa001_desc(g_craa_m.craa018) RETURNING g_craa_m.craa018_desc
                     CALL s_desc_get_dbaa001_desc(g_craa_m.craa017) RETURNING g_craa_m.craa017_desc
                     DISPLAY BY NAME g_craa_m.craa018_desc,g_craa_m.craa017_desc
                  END IF
                  LET g_craa_m.craa020 = ''
                  LET g_craa_m.craa020_desc = ''
                  DISPLAY BY NAME g_craa_m.craa020_desc
               END IF
            END IF
            LET g_craa_m_o.craa017 = g_craa_m.craa017
            LET g_craa_m_o.craa018 = g_craa_m.craa018
            LET g_craa_m_o.craa019 = g_craa_m.craa019
            LET g_craa_m_o.craa020 = g_craa_m.craa020
            CALL s_desc_get_dbaa001_desc(g_craa_m.craa019) RETURNING g_craa_m.craa019_desc
            DISPLAY BY NAME g_craa_m.craa019_desc
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD craa019
            #add-point:BEFORE FIELD craa019

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE craa019
            #add-point:ON CHANGE craa019

            #END add-point
 
         #----<<craa019_desc>>----
         #----<<craa018>>----
         #此段落由子樣板a02產生
         AFTER FIELD craa018
            
            #add-point:AFTER FIELD craa018
            LET g_craa_m.craa018_desc = ' '
            DISPLAY BY NAME g_craa_m.craa018_desc
            IF NOT cl_null(g_craa_m.craa018) THEN
               IF g_craa_m.craa018 != g_craa_m_o.craa018 OR g_craa_m_o.craa018 IS NULL THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_craa_m.craa018
                  LET g_chkparam.err_str[1] = "acr-00004|",'2'
                  LET g_chkparam.arg2 = '2'
                  IF NOT cl_chk_exist("v_dbaa001_1") THEN
                     LET g_craa_m.craa018 = g_craa_m_o.craa018
                     CALL s_desc_get_dbaa001_desc(g_craa_m.craa018) RETURNING g_craa_m.craa018_desc
                     DISPLAY BY NAME g_craa_m.craa018_desc
                     NEXT FIELD CURRENT
                  END IF
                  IF cl_null(g_craa_m.craa017) THEN
                     CALL acrm300_get_dbaa003(g_craa_m.craa018,'2') RETURNING g_craa_m.craa017
                     CALL s_desc_get_dbaa001_desc(g_craa_m.craa017) RETURNING g_craa_m.craa017_desc
                     DISPLAY BY NAME g_craa_m.craa017_desc
                  END IF
                  LET g_craa_m.craa019 = ''
                  LET g_craa_m.craa020 = ''
                  LET g_craa_m.craa019_desc = ''
                  LET g_craa_m.craa020_desc = ''
                  DISPLAY BY NAME g_craa_m.craa019_desc,g_craa_m.craa020_desc
               END IF
            END IF
            LET g_craa_m_o.craa017 = g_craa_m.craa017
            LET g_craa_m_o.craa018 = g_craa_m.craa018
            LET g_craa_m_o.craa019 = g_craa_m.craa019
            LET g_craa_m_o.craa020 = g_craa_m.craa020
            CALL s_desc_get_dbaa001_desc(g_craa_m.craa018) RETURNING g_craa_m.craa018_desc
            DISPLAY BY NAME g_craa_m.craa018_desc
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD craa018
            #add-point:BEFORE FIELD craa018

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE craa018
            #add-point:ON CHANGE craa018

            #END add-point
 
         #----<<craa018_desc>>----
         #----<<craa017>>----
         #此段落由子樣板a02產生
         AFTER FIELD craa017
            
            #add-point:AFTER FIELD craa017
            LET g_craa_m.craa017_desc = ' '
            DISPLAY BY NAME g_craa_m.craa017_desc
            IF NOT cl_null(g_craa_m.craa017) THEN
               IF g_craa_m.craa017 != g_craa_m_o.craa017 OR g_craa_m_o.craa017 IS NULL THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_craa_m.craa017
                  LET g_chkparam.arg2 = '1'
                  LET g_chkparam.err_str[1] = "acr-00004|",'1'
                  IF NOT cl_chk_exist("v_dbaa001_1") THEN
                     LET g_craa_m.craa017 = g_craa_m_o.craa017
                     CALL s_desc_get_dbaa001_desc(g_craa_m.craa017) RETURNING g_craa_m.craa017_desc
                     DISPLAY BY NAME g_craa_m.craa017_desc
                     NEXT FIELD CURRENT
                  END IF
                  LET g_craa_m.craa018 = ''
                  LET g_craa_m.craa019 = ''
                  LET g_craa_m.craa020 = ''
                  LET g_craa_m.craa018_desc = ''
                  LET g_craa_m.craa019_desc = ''
                  LET g_craa_m.craa020_desc = ''
                  DISPLAY BY NAME g_craa_m.craa018_desc,g_craa_m.craa019_desc,g_craa_m.craa020_desc
               END IF
            END IF
            CALL s_desc_get_dbaa001_desc(g_craa_m.craa017) RETURNING g_craa_m.craa017_desc
            DISPLAY BY NAME g_craa_m.craa017_desc
            LET g_craa_m_o.craa017 = g_craa_m.craa017
            LET g_craa_m_o.craa018 = g_craa_m.craa018
            LET g_craa_m_o.craa019 = g_craa_m.craa019
            LET g_craa_m_o.craa020 = g_craa_m.craa020
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD craa017
            #add-point:BEFORE FIELD craa017

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE craa017
            #add-point:ON CHANGE craa017

            #END add-point
 
         #----<<craa017_desc>>----
         #----<<craa021>>----
         #此段落由子樣板a02產生
         AFTER FIELD craa021
            
            #add-point:AFTER FIELD craa021
            LET g_craa_m.craa021_desc = ' '
            DISPLAY BY NAME g_craa_m.craa021_desc
            IF NOT cl_null(g_craa_m.craa021) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_craa_m.craa021 != g_craa_m_o.craa021 OR g_craa_m_o.craa021 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_craa_m.craa021
                  #160318-00025#27  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#27  by 07900 --add-end
                  IF NOT cl_chk_exist("v_ooag001") THEN
                     LET g_craa_m.craa021 = g_craa_m_o.craa021
                     CALL s_desc_get_person_desc(g_craa_m.craa021) RETURNING g_craa_m.craa021_desc
                     DISPLAY BY NAME g_craa_m.craa021_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_person_desc(g_craa_m.craa021) RETURNING g_craa_m.craa021_desc
            DISPLAY BY NAME g_craa_m.craa021_desc
            LET g_craa_m_o.craa021 = g_craa_m.craa021
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD craa021
            #add-point:BEFORE FIELD craa021

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE craa021
            #add-point:ON CHANGE craa021

            #END add-point
 
         #----<<craa021_desc>>----
         #----<<craa022>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craa022
            #add-point:BEFORE FIELD craa022

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa022
            
            #add-point:AFTER FIELD craa022

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE craa022
            #add-point:ON CHANGE craa022

            #END add-point
 
         #----<<craa023>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craa023
            #add-point:BEFORE FIELD craa023

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa023
            
            #add-point:AFTER FIELD craa023

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE craa023
            #add-point:ON CHANGE craa023

            #END add-point
 
         #----<<craa024>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craa024
            #add-point:BEFORE FIELD craa024

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa024
            
            #add-point:AFTER FIELD craa024

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE craa024
            #add-point:ON CHANGE craa024

            #END add-point
 
         #----<<craa025>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craa025
            #add-point:BEFORE FIELD craa025

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa025
            
            #add-point:AFTER FIELD craa025

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE craa025
            #add-point:ON CHANGE craa025

            #END add-point
 
         #----<<craa026>>----
         #此段落由子樣板a02產生
         AFTER FIELD craa026
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_craa_m.craa026,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD craa026
            END IF
 
 
            #add-point:AFTER FIELD craa026
            IF NOT cl_null(g_craa_m.craa026) THEN 
            END IF 


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD craa026
            #add-point:BEFORE FIELD craa026

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE craa026
            #add-point:ON CHANGE craa026

            #END add-point
 
         #----<<craa027>>----
         #此段落由子樣板a02產生
         AFTER FIELD craa027
            
            #add-point:AFTER FIELD craa027
            LET g_craa_m.craa027_desc = ' '
            DISPLAY BY NAME g_craa_m.craa027_desc
            IF NOT cl_null(g_craa_m.craa027) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_craa_m.craa027 != g_craa_m_o.craa027 OR g_craa_m_o.craa027 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_craa_m.craaunit
                  LET g_chkparam.arg2 = g_craa_m.craa027
                  #160318-00025#27  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
                  #160318-00025#27  by 07900 --add-end
                  IF NOT cl_chk_exist("v_ooaj002") THEN
                     LET g_craa_m.craa027 = g_craa_m_o.craa027
                     CALL s_desc_get_currency_desc(g_craa_m.craa027) RETURNING g_craa_m.craa027_desc
                     DISPLAY BY NAME g_craa_m.craa027_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_currency_desc(g_craa_m.craa027) RETURNING g_craa_m.craa027_desc
            DISPLAY BY NAME g_craa_m.craa027_desc
            LET g_craa_m_o.craa027 = g_craa_m.craa027
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD craa027
            #add-point:BEFORE FIELD craa027

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE craa027
            #add-point:ON CHANGE craa027

            #END add-point
 
         #----<<craa027_desc>>----
         #----<<craa028>>----
         #此段落由子樣板a02產生
         AFTER FIELD craa028
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_craa_m.craa028,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD craa028
            END IF
 
 
            #add-point:AFTER FIELD craa028
            IF NOT cl_null(g_craa_m.craa028) THEN 
            END IF 


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD craa028
            #add-point:BEFORE FIELD craa028

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE craa028
            #add-point:ON CHANGE craa028

            #END add-point
 
         #----<<craa033>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craa033
            #add-point:BEFORE FIELD craa033

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa033
            
            #add-point:AFTER FIELD craa033

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE craa033
            #add-point:ON CHANGE craa033

            #END add-point
 
         #----<<craa029>>----
         #此段落由子樣板a02產生
         AFTER FIELD craa029
            
            #add-point:AFTER FIELD craa029
            LET g_craa_m.craa029_desc = ' '
            DISPLAY BY NAME g_craa_m.craa029_desc
            IF NOT cl_null(g_craa_m.craa029) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_craa_m.craa029 != g_craa_m_o.craa029 OR g_craa_m_o.craa029 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_craa_m.craa029
                  LET g_chkparam.arg2 = 'ALL'
                  #160318-00025#27  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="apm-00201:sub-01302|axmm200|",cl_get_progname("axmm200",g_lang,"2"),"|:EXEPROGaxmm200"
                  #160318-00025#27  by 07900 --add-end 
                  IF NOT cl_chk_exist("v_pmaa001_3") THEN
                     LET g_craa_m.craa029 = g_craa_m_o.craa029
                     CALL s_desc_get_trading_partner_abbr_desc(g_craa_m.craa029) RETURNING g_craa_m.craa029_desc
                     DISPLAY BY NAME g_craa_m.craa029_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_trading_partner_abbr_desc(g_craa_m.craa029) RETURNING g_craa_m.craa029_desc
            DISPLAY BY NAME g_craa_m.craa029_desc
            LET g_craa_m_o.craa029 = g_craa_m.craa029
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD craa029
            #add-point:BEFORE FIELD craa029

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE craa029
            #add-point:ON CHANGE craa029

            #END add-point
 
         #----<<craa029_desc>>----
         #----<<craa030>>----
         #此段落由子樣板a01產生
         BEFORE FIELD craa030
            #add-point:BEFORE FIELD craa030

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD craa030
            
            #add-point:AFTER FIELD craa030

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE craa030
            #add-point:ON CHANGE craa030

            #END add-point
 
         #----<<craa031>>----
         #此段落由子樣板a02產生
         AFTER FIELD craa031
            
            #add-point:AFTER FIELD craa031
            LET g_craa_m.craa031_desc = ' '
            DISPLAY BY NAME g_craa_m.craa031_desc
            IF NOT cl_null(g_craa_m.craa031) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_craa_m.craa031 != g_craa_m_o.craa031 OR g_craa_m_o.craa031 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_craa_m.craa031
                  IF NOT cl_chk_exist("v_pmaa001_1") THEN
                     LET g_craa_m.craa031 = g_craa_m_o.craa031
                     CALL s_desc_get_trading_partner_abbr_desc(g_craa_m.craa031) RETURNING g_craa_m.craa031_desc
                     DISPLAY BY NAME g_craa_m.craa031_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_trading_partner_abbr_desc(g_craa_m.craa031) RETURNING g_craa_m.craa031_desc
            DISPLAY BY NAME g_craa_m.craa031_desc
            LET g_craa_m_o.craa031 = g_craa_m.craa031
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD craa031
            #add-point:BEFORE FIELD craa031

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE craa031
            #add-point:ON CHANGE craa031

            #END add-point
 
         #----<<craa031_desc>>----
         #----<<craaownid>>----
         #----<<craaownid_desc>>----
         #----<<craaowndp>>----
         #----<<craaowndp_desc>>----
         #----<<craacrtid>>----
         #----<<craacrtid_desc>>----
         #----<<craacrtdp>>----
         #----<<craacrtdp_desc>>----
         #----<<craacrtdt>>----
         #----<<craamodid>>----
         #----<<craamodid_desc>>----
         #----<<craamoddt>>----
         #----<<craacnfid>>----
         #----<<craacnfid_desc>>----
         #----<<craacnfdt>>----
 #欄位檢查
         #---------------------------<  Master  >---------------------------
         #----<<craaunit>>----
         #Ctrlp:input.c.craaunit
         ON ACTION controlp INFIELD craaunit
            #add-point:ON ACTION controlp INFIELD craaunit
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_craa_m.craaunit             #給予default值
            
            #給予arg
            CALL s_aooi500_q_where(g_prog,'craaunit',g_site,'i') RETURNING l_where #150308-00001#1  By Ken add 'i' 150309
            LET g_qryparam.where = l_where
            CALL q_ooef001_24()
            LET g_craa_m.craaunit = g_qryparam.return1
            DISPLAY g_craa_m.craaunit TO craaunit
            CALL s_desc_get_department_desc(g_craa_m.craaunit) RETURNING g_craa_m.craaunit_desc
            DISPLAY BY NAME g_craa_m.craaunit_desc
            NEXT FIELD craaunit                          #返回原欄位
            #END add-point
 
         #----<<craaunit_desc>>----
         #----<<craa001>>----
         #Ctrlp:input.c.craa001
         ON ACTION controlp INFIELD craa001
            #add-point:ON ACTION controlp INFIELD craa001

            #END add-point
 
         #----<<craal004>>----
         #Ctrlp:input.c.craal004
         ON ACTION controlp INFIELD craal004
            #add-point:ON ACTION controlp INFIELD craal004

            #END add-point
 
         #----<<craal003>>----
         #Ctrlp:input.c.craal003
         ON ACTION controlp INFIELD craal003
            #add-point:ON ACTION controlp INFIELD craal003

            #END add-point
 
         #----<<craal005>>----
         #Ctrlp:input.c.craal005
         ON ACTION controlp INFIELD craal005
            #add-point:ON ACTION controlp INFIELD craal005

            #END add-point
 
         #----<<craa003>>----
         #Ctrlp:input.c.craa003
         ON ACTION controlp INFIELD craa003
            #add-point:ON ACTION controlp INFIELD craa003

            #END add-point
 
         #----<<craa032>>----
         #Ctrlp:input.c.craa032
         ON ACTION controlp INFIELD craa032
            #add-point:ON ACTION controlp INFIELD craa032

            #END add-point
 
         #----<<craastus>>----
         #Ctrlp:input.c.craastus
         ON ACTION controlp INFIELD craastus
            #add-point:ON ACTION controlp INFIELD craastus
 
            #END add-point
 
         #----<<craa004>>----
         #Ctrlp:input.c.craa004
         ON ACTION controlp INFIELD craa004
            #add-point:ON ACTION controlp INFIELD craa004

            #END add-point
 
         #----<<craa005>>----
         #Ctrlp:input.c.craa005
         ON ACTION controlp INFIELD craa005
            #add-point:ON ACTION controlp INFIELD craa005

            #END add-point
 
         #----<<craa006>>----
         #Ctrlp:input.c.craa006
         ON ACTION controlp INFIELD craa006
            #add-point:ON ACTION controlp INFIELD craa006

            #END add-point
 
         #----<<craa007>>----
         #Ctrlp:input.c.craa007
         ON ACTION controlp INFIELD craa007
            #add-point:ON ACTION controlp INFIELD craa007

            #END add-point
 
         #----<<craa008>>----
         #Ctrlp:input.c.craa008
         ON ACTION controlp INFIELD craa008
            #add-point:ON ACTION controlp INFIELD craa008
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_craa_m.craa008             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_craa_m.craaunit
            CALL q_ooaj002_1()                                #呼叫開窗
            LET g_craa_m.craa008 = g_qryparam.return1      
            DISPLAY g_craa_m.craa008 TO craa008              #
            CALL s_desc_get_currency_desc(g_craa_m.craa008) RETURNING g_craa_m.craa008_desc
            DISPLAY BY NAME g_craa_m.craa008_desc
            NEXT FIELD craa008                          #返回原欄位
            #END add-point
 
         #----<<craa008_desc>>----
         #----<<craa009>>----
         #Ctrlp:input.c.craa009
         ON ACTION controlp INFIELD craa009
            #add-point:ON ACTION controlp INFIELD craa009

            #END add-point
 
         #----<<craa010>>----
         #Ctrlp:input.c.craa010
         ON ACTION controlp INFIELD craa010
            #add-point:ON ACTION controlp INFIELD craa010
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_craa_m.craa010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_craa_m.craaunit
            CALL q_ooaj002_1()                                #呼叫開窗
            LET g_craa_m.craa010 = g_qryparam.return1    
            DISPLAY g_craa_m.craa010 TO craa010              #
            CALL s_desc_get_currency_desc(g_craa_m.craa010) RETURNING g_craa_m.craa010_desc
            DISPLAY BY NAME g_craa_m.craa010_desc
            NEXT FIELD craa010                          #返回原欄位


            #END add-point
 
         #----<<craa010_desc>>----
         #----<<craa011>>----
         #Ctrlp:input.c.craa011
         ON ACTION controlp INFIELD craa011
            #add-point:ON ACTION controlp INFIELD craa011

            #END add-point
 
         #----<<craa012>>----
         #Ctrlp:input.c.craa012
         ON ACTION controlp INFIELD craa012
            #add-point:ON ACTION controlp INFIELD craa012

            #END add-point
 
         #----<<craa014>>----
         #Ctrlp:input.c.craa014
         ON ACTION controlp INFIELD craa014
            #add-point:ON ACTION controlp INFIELD craa014
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_craa_m.craa014             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2107" #
            CALL q_oocq002()                                #呼叫開窗
            LET g_craa_m.craa014 = g_qryparam.return1  
            DISPLAY g_craa_m.craa014 TO craa014              #
            CALL s_desc_get_acc_desc('2107',g_craa_m.craa014) RETURNING g_craa_m.craa014_desc
            DISPLAY BY NAME g_craa_m.craa014_desc
            NEXT FIELD craa014                          #返回原欄位
            #END add-point
 
         #----<<craa014_desc>>----
         #----<<craa015>>----
         #Ctrlp:input.c.craa015
         ON ACTION controlp INFIELD craa015
            #add-point:ON ACTION controlp INFIELD craa015
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_craa_m.craa015             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "281" #
            CALL q_oocq002()                                #呼叫開窗
            LET g_craa_m.craa015 = g_qryparam.return1   
            DISPLAY g_craa_m.craa015 TO craa015              #
            CALL s_desc_get_acc_desc('281',g_craa_m.craa015) RETURNING g_craa_m.craa015_desc
            DISPLAY BY NAME g_craa_m.craa015_desc
            NEXT FIELD craa015                          #返回原欄位
            #END add-point
 
         #----<<craa015_desc>>----
         #----<<craa016>>----
         #Ctrlp:input.c.craa016
         ON ACTION controlp INFIELD craa016
            #add-point:ON ACTION controlp INFIELD craa016
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_craa_m.craa016             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2105" #
            CALL q_oocq002()                                #呼叫開窗
            LET g_craa_m.craa016 = g_qryparam.return1   
            DISPLAY g_craa_m.craa016 TO craa016              #
            CALL s_desc_get_acc_desc('2105',g_craa_m.craa016) RETURNING g_craa_m.craa016_desc
            DISPLAY BY NAME g_craa_m.craa016_desc
            NEXT FIELD craa016                          #返回原欄位
            #END add-point
 
         #----<<craa016_desc>>----
         #----<<craa013>>----
         #Ctrlp:input.c.craa013
         ON ACTION controlp INFIELD craa013
            #add-point:ON ACTION controlp INFIELD craa013

            #END add-point
 
         #----<<craa020>>----
         #Ctrlp:input.c.craa020
         ON ACTION controlp INFIELD craa020
            #add-point:ON ACTION controlp INFIELD craa020
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_craa_m.craa020             #給予default值

            #給予arg
            IF NOT cl_null(g_craa_m.craa019) THEN
               LET g_qryparam.arg1 = "4"
               LET g_qryparam.arg2 = g_craa_m.craa019
               CALL q_dbaa001_2()                                #呼叫開窗
            ELSE
               LET g_qryparam.arg1 = "4"
               CALL q_dbaa001_1()
            END IF
            LET g_craa_m.craa020 = g_qryparam.return1   
            DISPLAY g_craa_m.craa020 TO craa020              #
            CALL s_desc_get_dbaa001_desc(g_craa_m.craa020) RETURNING g_craa_m.craa020_desc
            DISPLAY BY NAME g_craa_m.craa020_desc
            NEXT FIELD craa020                          #返回原欄位
            #END add-point
 
         #----<<craa020_desc>>----
         #----<<craa019>>----
         #Ctrlp:input.c.craa019
         ON ACTION controlp INFIELD craa019
            #add-point:ON ACTION controlp INFIELD craa019
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_craa_m.craa019             #給予default值

            #給予arg
            IF NOT cl_null(g_craa_m.craa018) THEN
               LET g_qryparam.arg1 = "3"
               LET g_qryparam.arg2 = g_craa_m.craa018
               CALL q_dbaa001_2()                                #呼叫開窗
            ELSE
               LET g_qryparam.arg1 = "3"
               CALL q_dbaa001_1()
            END IF
            LET g_craa_m.craa019 = g_qryparam.return1   
            DISPLAY g_craa_m.craa019 TO craa019              #
            CALL s_desc_get_dbaa001_desc(g_craa_m.craa019) RETURNING g_craa_m.craa019_desc
            DISPLAY BY NAME g_craa_m.craa019_desc
            NEXT FIELD craa019                          #返回原欄位
            #END add-point
 
         #----<<craa019_desc>>----
         #----<<craa018>>----
         #Ctrlp:input.c.craa018
         ON ACTION controlp INFIELD craa018
            #add-point:ON ACTION controlp INFIELD craa018
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_craa_m.craa018             #給予default值

            #給予arg
            IF NOT cl_null(g_craa_m.craa017) THEN
               LET g_qryparam.arg1 = "2"
               LET g_qryparam.arg2 = g_craa_m.craa017
               CALL q_dbaa001_2()                                #呼叫開窗
            ELSE
               LET g_qryparam.arg1 = "2"
               CALL q_dbaa001_1()
            END IF
            LET g_craa_m.craa018 = g_qryparam.return1   
            DISPLAY g_craa_m.craa018 TO craa018              #
            CALL s_desc_get_dbaa001_desc(g_craa_m.craa018) RETURNING g_craa_m.craa018_desc
            DISPLAY BY NAME g_craa_m.craa018_desc
            NEXT FIELD craa018                          #返回原欄位


            #END add-point
 
         #----<<craa018_desc>>----
         #----<<craa017>>----
         #Ctrlp:input.c.craa017
         ON ACTION controlp INFIELD craa017
            #add-point:ON ACTION controlp INFIELD craa017
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_craa_m.craa017             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "1" #區域
            CALL q_dbaa001_1()                                #呼叫開窗
            LET g_craa_m.craa017 = g_qryparam.return1   
            DISPLAY g_craa_m.craa017 TO craa017              #
            CALL s_desc_get_dbaa001_desc(g_craa_m.craa017) RETURNING g_craa_m.craa017_desc
            DISPLAY BY NAME g_craa_m.craa017_desc
            NEXT FIELD craa017                          #返回原欄位


            #END add-point
 
         #----<<craa017_desc>>----
         #----<<craa021>>----
         #Ctrlp:input.c.craa021
         ON ACTION controlp INFIELD craa021
            #add-point:ON ACTION controlp INFIELD craa021
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_craa_m.craa021             #給予default值
            CALL q_ooag001()                                #呼叫開窗
            LET g_craa_m.craa021 = g_qryparam.return1   
            DISPLAY g_craa_m.craa021 TO craa021              #
            CALL s_desc_get_person_desc(g_craa_m.craa021) RETURNING g_craa_m.craa021_desc
            DISPLAY BY NAME g_craa_m.craa021_desc
            NEXT FIELD craa021                          #返回原欄位
            #END add-point
 
         #----<<craa021_desc>>----
         #----<<craa022>>----
         #Ctrlp:input.c.craa022
         ON ACTION controlp INFIELD craa022
            #add-point:ON ACTION controlp INFIELD craa022

            #END add-point
 
         #----<<craa023>>----
         #Ctrlp:input.c.craa023
         ON ACTION controlp INFIELD craa023
            #add-point:ON ACTION controlp INFIELD craa023

            #END add-point
 
         #----<<craa024>>----
         #Ctrlp:input.c.craa024
         ON ACTION controlp INFIELD craa024
            #add-point:ON ACTION controlp INFIELD craa024

            #END add-point
 
         #----<<craa025>>----
         #Ctrlp:input.c.craa025
         ON ACTION controlp INFIELD craa025
            #add-point:ON ACTION controlp INFIELD craa025

            #END add-point
 
         #----<<craa026>>----
         #Ctrlp:input.c.craa026
         ON ACTION controlp INFIELD craa026
            #add-point:ON ACTION controlp INFIELD craa026

            #END add-point
 
         #----<<craa027>>----
         #Ctrlp:input.c.craa027
         ON ACTION controlp INFIELD craa027
            #add-point:ON ACTION controlp INFIELD craa027
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_craa_m.craa027             #給予default值
            
            #給予arg
            LET g_qryparam.arg1 = g_craa_m.craaunit
            CALL q_ooaj002_1()                                #呼叫開窗
            LET g_craa_m.craa027 = g_qryparam.return1              
            DISPLAY g_craa_m.craa027 TO craa027              #
            CALL s_desc_get_currency_desc(g_craa_m.craa027) RETURNING g_craa_m.craa027_desc
            DISPLAY BY NAME g_craa_m.craa027_desc
            NEXT FIELD craa027                          #返回原欄位
            #END add-point
 
         #----<<craa027_desc>>----
         #----<<craa028>>----
         #Ctrlp:input.c.craa028
         ON ACTION controlp INFIELD craa028
            #add-point:ON ACTION controlp INFIELD craa028

            #END add-point
 
         #----<<craa033>>----
         #Ctrlp:input.c.craa033
         ON ACTION controlp INFIELD craa033
            #add-point:ON ACTION controlp INFIELD craa033

            #END add-point
 
         #----<<craa029>>----
         #Ctrlp:input.c.craa029
         ON ACTION controlp INFIELD craa029
            #add-point:ON ACTION controlp INFIELD craa029
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_craa_m.craa029             #給予default值

            #給予arg
            LET g_qryparam.arg1 = 'ALL'
            CALL q_pmaa001_6()                                #呼叫開窗
            LET g_craa_m.craa029 = g_qryparam.return1    
            DISPLAY g_craa_m.craa029 TO craa029              #
            CALL s_desc_get_trading_partner_abbr_desc(g_craa_m.craa029) RETURNING g_craa_m.craa029_desc
            DISPLAY BY NAME g_craa_m.craa029_desc
            NEXT FIELD craa029                          #返回原欄位
            #END add-point
 
         #----<<craa029_desc>>----
         #----<<craa030>>----
         #Ctrlp:input.c.craa030
         ON ACTION controlp INFIELD craa030
            #add-point:ON ACTION controlp INFIELD craa030

            #END add-point
 
         #----<<craa031>>----
         #Ctrlp:input.c.craa031
         ON ACTION controlp INFIELD craa031
            #add-point:ON ACTION controlp INFIELD craa031
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_craa_m.craa031             #給予default值

            CALL q_pmaa001_3()                                #呼叫開窗
            LET g_craa_m.craa031 = g_qryparam.return1              
            DISPLAY g_craa_m.craa031 TO craa031              #
            CALL s_desc_get_trading_partner_abbr_desc(g_craa_m.craa031) RETURNING g_craa_m.craa031_desc
            DISPLAY BY NAME g_craa_m.craa031_desc
            NEXT FIELD craa031                          #返回原欄位
            #END add-point
 
         #----<<craa031_desc>>----
         #----<<craaownid>>----
         #----<<craaownid_desc>>----
         #----<<craaowndp>>----
         #----<<craaowndp_desc>>----
         #----<<craacrtid>>----
         #----<<craacrtid_desc>>----
         #----<<craacrtdp>>----
         #----<<craacrtdp_desc>>----
         #----<<craacrtdt>>----
         #----<<craamodid>>----
         #----<<craamodid_desc>>----
         #----<<craamoddt>>----
         #----<<craacnfid>>----
         #----<<craacnfid_desc>>----
         #----<<craacnfdt>>----
 #欄位開窗
 
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
                
            CALL cl_showmsg()   #錯誤訊息統整顯示
 
            IF p_cmd <> "u" THEN
               LET l_count = 1  
 
               SELECT COUNT(*) INTO l_count FROM craa_t
                WHERE craaent = g_enterprise AND craa001 = g_craa_m.craa001
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前
                  #聯絡對象識別碼
                  IF cl_null(g_craa_m.craa013) THEN
                     LET l_success = ''
                     CALL s_aooi350_ins_oofa('3',g_craa_m.craa001,'') RETURNING l_success,g_craa_m.craa013
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "oofa_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        CONTINUE DIALOG
                     END IF
                     LET g_pmaa027_d = g_craa_m.craa013
                  END IF
                  #end add-point
               
                  INSERT INTO craa_t (craaent,craaunit,craa001,craa003,craa032,craastus,craa004,craa005, 
                      craa006,craa007,craa008,craa009,craa010,craa011,craa012,craa014,craa015,craa016, 
                      craa013,craa020,craa019,craa018,craa017,craa021,craa022,craa023,craa024,craa025, 
                      craa026,craa027,craa028,craa033,craa029,craa030,craa031,craaownid,craaowndp,craacrtid, 
                      craacrtdp,craacrtdt,craamodid,craamoddt,craacnfid,craacnfdt)
                  VALUES (g_enterprise,g_craa_m.craaunit,g_craa_m.craa001,g_craa_m.craa003,g_craa_m.craa032, 
                      g_craa_m.craastus,g_craa_m.craa004,g_craa_m.craa005,g_craa_m.craa006,g_craa_m.craa007, 
                      g_craa_m.craa008,g_craa_m.craa009,g_craa_m.craa010,g_craa_m.craa011,g_craa_m.craa012, 
                      g_craa_m.craa014,g_craa_m.craa015,g_craa_m.craa016,g_craa_m.craa013,g_craa_m.craa020, 
                      g_craa_m.craa019,g_craa_m.craa018,g_craa_m.craa017,g_craa_m.craa021,g_craa_m.craa022, 
                      g_craa_m.craa023,g_craa_m.craa024,g_craa_m.craa025,g_craa_m.craa026,g_craa_m.craa027, 
                      g_craa_m.craa028,g_craa_m.craa033,g_craa_m.craa029,g_craa_m.craa030,g_craa_m.craa031, 
                      g_craa_m.craaownid,g_craa_m.craaowndp,g_craa_m.craacrtid,g_craa_m.craacrtdp,g_craa_m.craacrtdt, 
                      g_craa_m.craamodid,g_craa_m.craamoddt,g_craa_m.craacnfid,g_craa_m.craacnfdt) 
                  
                  #add-point:單頭新增中

                  #end add-point
                  
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "craa_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CONTINUE DIALOG
                  END IF
                  
                  
                  
                  #資料多語言用-增/改
                           INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_craa_m.craa001 = g_master_multi_table_t.craal001 AND
         g_craa_m.craal004 = g_master_multi_table_t.craal004 AND 
         g_craa_m.craal003 = g_master_multi_table_t.craal003 AND 
         g_craa_m.craal005 = g_master_multi_table_t.craal005  THEN
         ELSE 
            LET l_var_keys[01] = g_craa_m.craa001
            LET l_field_keys[01] = 'craal001'
            LET l_var_keys_bak[01] = g_master_multi_table_t.craal001
            LET l_var_keys[02] = g_dlang
            LET l_field_keys[02] = 'craal002'
            LET l_var_keys_bak[02] = g_dlang
            LET l_vars[01] = g_craa_m.craal004
            LET l_fields[01] = 'craal004'
            LET l_vars[02] = g_craa_m.craal003
            LET l_fields[02] = 'craal003'
            LET l_vars[03] = g_craa_m.craal005
            LET l_fields[03] = 'craal005'
            LET l_vars[04] = g_enterprise 
            LET l_fields[04] = 'craalent'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'craal_t')
         END IF 
 
                  
                  #add-point:單頭新增後

                  #end add-point
                  
                  CALL s_transaction_end('Y','0')
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  "std-00006"
                  LET g_errparam.extend =  "g_craa_m.craa001"
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
 
                  CALL s_transaction_end('N','0')
               END IF 
            ELSE
               #add-point:單頭修改前

               #end add-point
               UPDATE craa_t SET (craaunit,craa001,craa003,craa032,craastus,craa004,craa005,craa006, 
                   craa007,craa008,craa009,craa010,craa011,craa012,craa014,craa015,craa016,craa013,craa020, 
                   craa019,craa018,craa017,craa021,craa022,craa023,craa024,craa025,craa026,craa027,craa028, 
                   craa033,craa029,craa030,craa031,craaownid,craaowndp,craacrtid,craacrtdp,craacrtdt, 
                   craamodid,craamoddt,craacnfid,craacnfdt) = (g_craa_m.craaunit,g_craa_m.craa001,g_craa_m.craa003, 
                   g_craa_m.craa032,g_craa_m.craastus,g_craa_m.craa004,g_craa_m.craa005,g_craa_m.craa006, 
                   g_craa_m.craa007,g_craa_m.craa008,g_craa_m.craa009,g_craa_m.craa010,g_craa_m.craa011, 
                   g_craa_m.craa012,g_craa_m.craa014,g_craa_m.craa015,g_craa_m.craa016,g_craa_m.craa013, 
                   g_craa_m.craa020,g_craa_m.craa019,g_craa_m.craa018,g_craa_m.craa017,g_craa_m.craa021, 
                   g_craa_m.craa022,g_craa_m.craa023,g_craa_m.craa024,g_craa_m.craa025,g_craa_m.craa026, 
                   g_craa_m.craa027,g_craa_m.craa028,g_craa_m.craa033,g_craa_m.craa029,g_craa_m.craa030, 
                   g_craa_m.craa031,g_craa_m.craaownid,g_craa_m.craaowndp,g_craa_m.craacrtid,g_craa_m.craacrtdp, 
                   g_craa_m.craacrtdt,g_craa_m.craamodid,g_craa_m.craamoddt,g_craa_m.craacnfid,g_craa_m.craacnfdt) 
 
                WHERE craaent = g_enterprise AND craa001 = g_craa001_t #
 
               #add-point:單頭修改中

               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "craa_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "craa_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                     
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_craa_m.craa001 = g_master_multi_table_t.craal001 AND
         g_craa_m.craal004 = g_master_multi_table_t.craal004 AND 
         g_craa_m.craal003 = g_master_multi_table_t.craal003 AND 
         g_craa_m.craal005 = g_master_multi_table_t.craal005  THEN
         ELSE 
            LET l_var_keys[01] = g_craa_m.craa001
            LET l_field_keys[01] = 'craal001'
            LET l_var_keys_bak[01] = g_master_multi_table_t.craal001
            LET l_var_keys[02] = g_dlang
            LET l_field_keys[02] = 'craal002'
            LET l_var_keys_bak[02] = g_dlang
            LET l_vars[01] = g_craa_m.craal004
            LET l_fields[01] = 'craal004'
            LET l_vars[02] = g_craa_m.craal003
            LET l_fields[02] = 'craal003'
            LET l_vars[03] = g_craa_m.craal005
            LET l_fields[03] = 'craal005'
            LET l_vars[04] = g_enterprise 
            LET l_fields[04] = 'craalent'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'craal_t')
         END IF 
 
                     #add-point:單頭修改後
                     IF NOT cl_null(g_craa_m.craa013) THEN
                        LET g_pmaa027_d = g_craa_m.craa013
                        CALL aooi350_01_b_fill(g_pmaa027_d)
                        CALL aooi350_02_b_fill(g_pmaa027_d)
                     END IF
                     #end add-point
                     CALL s_transaction_end('Y','0')
               END CASE
            END IF
            LET g_craa001_t = g_craa_m.craa001
           #controlp
      END INPUT
          
      #add-point:input段more input 
      INPUT ARRAY g_pmaj_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_pmaj_d.getLength()+1) 
              LET g_insert = 'N' 
            END IF 
 
            CALL acrm300_b_fill(g_wc2_table1) 
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
         
         BEFORE ROW
            CALL acrm300_b_fill(g_wc2_table1) 
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN acrm300_cl USING g_enterprise,g_craa_m.craa001
                                               
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN acrm300_cl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CLOSE acrm300_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            
            IF g_rec_b >= l_ac 
               AND g_pmaj_d[l_ac].pmaj002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_pmaj_d_t.* = g_pmaj_d[l_ac].*  
               LET g_pmaj_d_o.* = g_pmaj_d[l_ac].*  
               OPEN acrm300_bcl USING g_enterprise,g_craa_m.craa001,g_pmaj_d[l_ac].pmaj002
 
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN acrm300_bcl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  LET l_lock_sw='Y'
               ELSE
                  FETCH acrm300_bcl INTO g_pmaj_d[l_ac].pmajstus,g_pmaj_d[l_ac].pmaj002,g_pmaj_d[l_ac].pmaj003, 
                      g_pmaj_d[l_ac].pmaj004,g_pmaj_d[l_ac].pmaj005,g_pmaj_d[l_ac].pmaj006,g_pmaj_d[l_ac].pmaj007, 
                      g_pmaj_d[l_ac].pmaj008
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_pmaj_d_t.pmaj002 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
 
                      LET l_lock_sw = "Y"
                  END IF
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            IF l_cmd = 'u' THEN
               #CALL acrm300_pmaj002_ref(g_pmaj_d[l_ac].pmaj002) RETURNING g_pmaj_d[l_ac].oofa008,g_pmaj_d[l_ac].oofa009,g_pmaj_d[l_ac].oofa010,g_pmaj_d[l_ac].oofa011,g_pmaj_d[l_ac].oofa012,g_pmaj_d[l_ac].oofa013 #mark by geza 20160229
               CALL acrm300_pmaj002_ref(g_craa_m.craa001,g_pmaj_d[l_ac].pmaj002) RETURNING g_pmaj_d[l_ac].pmaj009,g_pmaj_d[l_ac].pmaj010,g_pmaj_d[l_ac].pmaj011,g_pmaj_d[l_ac].pmaj012,g_pmaj_d[l_ac].pmaj013,g_pmaj_d[l_ac].pmaj014 #mark by geza 20160229
            END IF
            
        
         BEFORE INSERT
            
            INITIALIZE g_pmaj_d_t.* TO NULL
            INITIALIZE g_pmaj_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_pmaj_d[l_ac].* TO NULL
            LET g_pmaj_d[l_ac].pmajstus = "Y"
            LET g_pmaj_d[l_ac].pmaj004 = "N"
            LET g_pmaj_d[l_ac].pmaj005 = "N"
            LET g_pmaj_d_t.* = g_pmaj_d[l_ac].*     #新輸入資料
            LET g_pmaj_d_o.* = g_pmaj_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_pmaj_d[li_reproduce_target].* = g_pmaj_d[li_reproduce].*
 
               LET g_pmaj_d[g_pmaj_d.getLength()].pmaj002 = NULL
 
            END IF
            LET g_pmaj_d[l_ac].pmaj002 = " "
            LET g_pmaj_d_t.* = g_pmaj_d[l_ac].* 
 
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
 
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM pmaj_t 
             WHERE pmajent = g_enterprise AND pmaj001 = g_craa_m.craa001
               AND pmaj002 = g_pmaj_d[l_ac].pmaj002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前

               #end add-point
               INSERT INTO pmaj_t
                           (pmajent,
                            pmaj001,
                            pmaj002
                            ,pmajstus,pmaj003,pmaj004,pmaj005,pmaj006,pmaj007,pmaj008
                            ,pmaj009,pmaj010,pmaj011,pmaj012,pmaj013,pmaj014  #add by geza 20160229
                            ) 
                     VALUES(g_enterprise,
                            g_craa_m.craa001,
                            g_pmaj_d[l_ac].pmaj002
                            ,g_pmaj_d[l_ac].pmajstus,g_pmaj_d[l_ac].pmaj003,g_pmaj_d[l_ac].pmaj004,g_pmaj_d[l_ac].pmaj005, 
                             g_pmaj_d[l_ac].pmaj006,g_pmaj_d[l_ac].pmaj007,g_pmaj_d[l_ac].pmaj008
                            ,g_pmaj_d[l_ac].pmaj009,g_pmaj_d[l_ac].pmaj010,g_pmaj_d[l_ac].pmaj011  #add by geza 20160229
                            ,g_pmaj_d[l_ac].pmaj012,g_pmaj_d[l_ac].pmaj013,g_pmaj_d[l_ac].pmaj014  #add by geza 20160229 
                                ) 

               LET p_cmd = 'u'
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               INITIALIZE g_pmaj_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pmaj_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #資料多語言用-增/改
               LET l_success = ''
               LET l_oofa001 = ''
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_craa_m.craa001
               CALL ap_ref_array2(g_ref_fields,"SELECT pmaa002 FROM pmaa_t WHERE pmaaent='"||g_enterprise||"' AND pmaa001=? ","") RETURNING g_rtn_fields
               LET l_pmaa002 = g_rtn_fields[1]
               CALL s_aooi350_ins_oofa('4',g_craa_m.craa001,l_pmaa002) RETURNING l_success,l_oofa001
               IF l_success THEN
                  #UPDATE oofa_t SET (oofa008,oofa009,oofa010,oofa011,oofa012,oofa013) = (g_pmaj_d[l_ac].oofa008,g_pmaj_d[l_ac].oofa009,g_pmaj_d[l_ac].oofa010,g_pmaj_d[l_ac].oofa011,g_pmaj_d[l_ac].oofa012,g_pmaj_d[l_ac].oofa013) #mark by geza 20160324 
                  UPDATE oofa_t SET (oofa008,oofa009,oofa010,oofa011,oofa012,oofa013) = (g_pmaj_d[l_ac].pmaj009,g_pmaj_d[l_ac].pmaj010,g_pmaj_d[l_ac].pmaj011,g_pmaj_d[l_ac].pmaj012,g_pmaj_d[l_ac].pmaj013,g_pmaj_d[l_ac].pmaj014)  #add by geza 20160324
                  WHERE oofaent = g_enterprise AND oofa001 = l_oofa001
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "oofa_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     CANCEL INSERT
                  ELSE
                     UPDATE pmaj_t SET pmaj002 = l_oofa001 WHERE pmajent = g_enterprise AND pmaj001 = g_craa_m.craa001 AND pmaj002 = g_pmaj_d[l_ac].pmaj002
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "pmaj_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        CALL s_transaction_end('N','0')
                        CANCEL INSERT
                     END IF
                  END IF
               ELSE
                  INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "oofa_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL INSERT
               END IF
               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR "INSERT O.K"
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cnt
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   =  -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CANCEL DELETE
               END IF
               IF acrm300_before_delete() THEN 
                  CALL s_transaction_end('Y','0')
                  
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE acrm300_bcl
               LET l_count = g_pmaj_d.getLength()
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
            END IF
            #如果是最後一筆
            IF l_ac = (g_pmaj_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         #此段落由子樣板a02產生
         AFTER FIELD pmaj002
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_craa_m.craa001) AND NOT cl_null(g_pmaj_d[l_ac].pmaj002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_craa_m.craa001 != g_craa_m_t.craa001 OR g_pmaj_d[l_ac].pmaj002 != g_pmaj_d_t.pmaj002))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmaj_t WHERE "||"pmajent = '" ||g_enterprise|| "' AND "||"pmaj001 = '"||g_craa_m.craa001 ||"' AND "|| "pmaj002 = '"||g_pmaj_d[l_ac].pmaj002 ||"'",'std-00004',0) THEN 
                     LET g_pmaj_d[l_ac].pmaj002 = g_pmaj_d_t.pmaj002
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
 
         #此段落由子樣板a02產生
         AFTER FIELD pmaj003
            IF NOT cl_null(g_pmaj_d[l_ac].pmaj003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_pmaj_d[l_ac].pmaj003 != g_pmaj_d_t.pmaj003))) THEN  
                  IF NOT s_azzi650_chk_exist('259',g_pmaj_d[l_ac].pmaj003) THEN
                     LET g_pmaj_d[l_ac].pmaj003 = g_pmaj_d_t.pmaj003
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
         #此段落由子樣板a02產生
         AFTER FIELD pmaj004
            IF g_pmaj_d[l_ac].pmaj004 = 'Y' THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmaj_d[l_ac].pmaj004 != g_pmaj_d_t.pmaj004)) THEN 
                  IF NOT acrm300_pmaj004_chk() THEN
                     LET g_pmaj_d[l_ac].pmaj004 = g_pmaj_d_t.pmaj004
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
         #此段落由子樣板a04產生
         ON CHANGE pmaj004
            IF g_pmaj_d[l_ac].pmaj004 = 'Y' THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmaj_d[l_ac].pmaj004 != g_pmaj_d_t.pmaj004)) THEN
                  IF NOT acrm300_pmaj004_chk() THEN
                     LET g_pmaj_d[l_ac].pmaj004 = g_pmaj_d_t.pmaj004
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
 
         #此段落由子樣板a02產生
         AFTER FIELD pmaj005
            IF g_pmaj_d[l_ac].pmaj005 = 'Y' THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmaj_d[l_ac].pmaj005 != g_pmaj_d_t.pmaj005)) THEN
                  IF NOT acrm300_pmaj005_chk() THEN
                     LET g_pmaj_d[l_ac].pmaj005 = g_pmaj_d_t.pmaj005
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
 
         #此段落由子樣板a04產生
         ON CHANGE pmaj005
            IF g_pmaj_d[l_ac].pmaj005 = 'Y' THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmaj_d[l_ac].pmaj005 != g_pmaj_d_t.pmaj005)) THEN
                  IF NOT acrm300_pmaj005_chk() THEN
                     LET g_pmaj_d[l_ac].pmaj005 = g_pmaj_d_t.pmaj005
                     NEXT FIELD CURRENT
                   END IF
               END IF
            END IF
            
         #mark by geza 20160229(S)
         #此段落由子樣板a02產生
#         AFTER FIELD oofa008
#            IF (NOT cl_null(g_pmaj_d[l_ac].oofa008)) AND (NOT cl_null(g_pmaj_d[l_ac].oofa010)) THEN 
#                IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmaj_d[l_ac].oofa008 != g_pmaj_d_t.oofa008 OR cl_null(g_pmaj_d_t.oofa008))) THEN 
#                   CALL s_aooi350_gen_fullname(g_site,g_pmaj_d[l_ac].oofa008,g_pmaj_d[l_ac].oofa009,g_pmaj_d[l_ac].oofa010) RETURNING l_success,g_pmaj_d[l_ac].oofa011
#                END IF
#             END IF   
#
#         #此段落由子樣板a02產生
#         AFTER FIELD oofa009
#             IF (NOT cl_null(g_pmaj_d[l_ac].oofa009)) AND (NOT cl_null(g_pmaj_d[l_ac].oofa008)) AND (NOT cl_null(g_pmaj_d[l_ac].oofa010)) THEN 
#                IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmaj_d[l_ac].oofa009 != g_pmaj_d_t.oofa009 OR cl_null(g_pmaj_d_t.oofa009))) THEN 
#                   CALL s_aooi350_gen_fullname(g_site,g_pmaj_d[l_ac].oofa008,g_pmaj_d[l_ac].oofa009,g_pmaj_d[l_ac].oofa010) RETURNING l_success,g_pmaj_d[l_ac].oofa011
#                END IF
#             END IF
#
#         #此段落由子樣板a02產生
#         AFTER FIELD oofa010
#             IF (NOT cl_null(g_pmaj_d[l_ac].oofa008)) AND (NOT cl_null(g_pmaj_d[l_ac].oofa010)) THEN 
#                IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmaj_d[l_ac].oofa010 != g_pmaj_d_t.oofa010 OR cl_null(g_pmaj_d_t.oofa010))) THEN 
#                   CALL s_aooi350_gen_fullname(g_site,g_pmaj_d[l_ac].oofa008,g_pmaj_d[l_ac].oofa009,g_pmaj_d[l_ac].oofa010) RETURNING l_success,g_pmaj_d[l_ac].oofa011
#                END IF
#             END IF
         #mark by geza 20160229(E)
         
         #add by geza 20160229(S)
         #此段落由子樣板a02產生
         AFTER FIELD pmaj009
            IF (NOT cl_null(g_pmaj_d[l_ac].pmaj009)) AND (NOT cl_null(g_pmaj_d[l_ac].pmaj011)) THEN 
                IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmaj_d[l_ac].pmaj009 != g_pmaj_d_t.pmaj009 OR cl_null(g_pmaj_d_t.pmaj009))) THEN 
                   CALL s_aooi350_gen_fullname(g_site,g_pmaj_d[l_ac].pmaj009,g_pmaj_d[l_ac].pmaj010,g_pmaj_d[l_ac].pmaj011) RETURNING l_success,g_pmaj_d[l_ac].pmaj012
                END IF
             END IF   

         #此段落由子樣板a02產生
         AFTER FIELD pmaj010
             IF (NOT cl_null(g_pmaj_d[l_ac].pmaj010)) AND (NOT cl_null(g_pmaj_d[l_ac].pmaj009)) AND (NOT cl_null(g_pmaj_d[l_ac].pmaj011)) THEN 
                IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmaj_d[l_ac].pmaj010 != g_pmaj_d_t.pmaj010 OR cl_null(g_pmaj_d_t.pmaj010))) THEN 
                   CALL s_aooi350_gen_fullname(g_site,g_pmaj_d[l_ac].pmaj009,g_pmaj_d[l_ac].pmaj010,g_pmaj_d[l_ac].pmaj011) RETURNING l_success,g_pmaj_d[l_ac].pmaj012
                END IF
             END IF

         #此段落由子樣板a02產生
         AFTER FIELD pmaj011
             IF (NOT cl_null(g_pmaj_d[l_ac].pmaj009)) AND (NOT cl_null(g_pmaj_d[l_ac].pmaj011)) THEN 
                IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmaj_d[l_ac].pmaj011 != g_pmaj_d_t.pmaj011 OR cl_null(g_pmaj_d_t.pmaj011))) THEN 
                   CALL s_aooi350_gen_fullname(g_site,g_pmaj_d[l_ac].pmaj009,g_pmaj_d[l_ac].pmaj010,g_pmaj_d[l_ac].pmaj011) RETURNING l_success,g_pmaj_d[l_ac].pmaj012
                END IF
             END IF
         #add by geza 20160229(E)

         ON ACTION controlp INFIELD pmaj003     
            #開窗i段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmaj_d[l_ac].pmaj003             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "259" #應用分類
            CALL q_oocq002()                                             #呼叫開窗
            LET g_pmaj_d[l_ac].pmaj003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaj_d[l_ac].pmaj003 TO pmaj003                    #顯示到畫面上

            NEXT FIELD pmaj003                                           #返回原欄位
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_pmaj_d[l_ac].* = g_pmaj_d_t.*
               CLOSE acrm300_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_pmaj_d[l_ac].pmaj002 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               LET g_pmaj_d[l_ac].* = g_pmaj_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               #mark by geza 20160229(S)
#               UPDATE pmaj_t SET (pmaj001,pmajstus,pmaj002,pmaj003,pmaj004,pmaj005,pmaj006,pmaj007,pmaj008) = (g_craa_m.craa001, 
#                   g_pmaj_d[l_ac].pmajstus,g_pmaj_d[l_ac].pmaj002,g_pmaj_d[l_ac].pmaj003,g_pmaj_d[l_ac].pmaj004, 
#                   g_pmaj_d[l_ac].pmaj005,g_pmaj_d[l_ac].pmaj006,g_pmaj_d[l_ac].pmaj007,g_pmaj_d[l_ac].pmaj008) 
               #mark by geza 20160229(E)
               #add by geza 20160229(S)
               UPDATE pmaj_t SET (pmaj001,pmajstus,pmaj002,pmaj003,pmaj004,pmaj005,pmaj006,pmaj007,pmaj008,pmaj009,pmaj010,pmaj011,pmaj012,pmaj013,pmaj014) = (g_craa_m.craa001, 
                   g_pmaj_d[l_ac].pmajstus,g_pmaj_d[l_ac].pmaj002,g_pmaj_d[l_ac].pmaj003,g_pmaj_d[l_ac].pmaj004, 
                   g_pmaj_d[l_ac].pmaj005,g_pmaj_d[l_ac].pmaj006,g_pmaj_d[l_ac].pmaj007,g_pmaj_d[l_ac].pmaj008,
                   g_pmaj_d[l_ac].pmaj009,g_pmaj_d[l_ac].pmaj010,g_pmaj_d[l_ac].pmaj011,g_pmaj_d[l_ac].pmaj012,
                   g_pmaj_d[l_ac].pmaj013,g_pmaj_d[l_ac].pmaj014) 
               #add by geza 20160229(E)
                WHERE pmajent = g_enterprise AND pmaj001 = g_craa_m.craa001
                 AND pmaj002 = g_pmaj_d_t.pmaj002

               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmaj_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
               END CASE
               
               #add-point:單身修改後
               #mark by geza 20160229(S)
#               IF SQLCA.sqlcode THEN
#               ELSE          
#                  UPDATE oofa_t SET (oofa008,oofa009,oofa010,oofa011,oofa012,oofa013) = (g_pmaj_d[l_ac].oofa008,g_pmaj_d[l_ac].oofa009,g_pmaj_d[l_ac].oofa010,g_pmaj_d[l_ac].oofa011,g_pmaj_d[l_ac].oofa012,g_pmaj_d[l_ac].oofa013)
#                    WHERE oofaent = g_enterprise AND oofa001 = g_pmaj_d_t.pmaj002
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = SQLCA.sqlcode
#                     LET g_errparam.extend = "oofa_t"
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     LET g_pmaj_d[l_ac].* = g_pmaj_d_t.*
#                  END IF
#               END IF
               #mark by geza 20160229(E)
               #end add-point
            END IF
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_pmaj_d.getLength() = 0 THEN
               NEXT FIELD pmaj002
            END IF
            #add-point:input段after input 

            #end add-point    
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_pmaj_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_pmaj_d.getLength()+1
            
      END INPUT
      SUBDIALOG aoo_aooi350_01.aooi350_01_input
      SUBDIALOG aoo_aooi350_02.aooi350_02_input
      
      BEFORE DIALOG
         #為了修改功能doubleClick可以直接進入單身,需指定要進入哪一個單身
         IF NOT cl_null(p_cmd) AND p_cmd != 'a' THEN
            CASE g_aw
               WHEN "s_detail1_aooi350_01"
                  NEXT FIELD oofbstus
               WHEN "s_detail1_aooi350_02"
                  NEXT FIELD oofcstus
               OTHERWISE
                  NEXT FIELD craaunit
            END CASE
         END IF

         IF p_cmd = 'a' THEN
            NEXT FIELD craaunit
         END IF
      #end add-point
          
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name, g_fld_name, g_lang)
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controls
         IF g_header_hidden THEN
            CALL gfrm_curr.setElementHidden("vb_master",0)
            CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
            LET g_header_hidden = 0     #visible
         ELSE
            CALL gfrm_curr.setElementHidden("vb_master",1)
            CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
            LET g_header_hidden = 1     #hidden     
         END IF
 
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         LET g_action_choice=""
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         LET INT_FLAG = TRUE 
         EXIT DIALOG
   
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input 

   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="acrm300.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION acrm300_reproduce()
   DEFINE l_newno     LIKE craa_t.craa001 
   DEFINE l_oldno     LIKE craa_t.craa001 
 
   DEFINE l_master    RECORD LIKE craa_t.*
   DEFINE l_cnt       LIKE type_t.num5
   #add-point:reproduce段define
   DEFINE l_insert    LIKE type_t.num5
   #end add-point   
   
   #切換畫面
   
   IF g_craa_m.craa001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      RETURN
   END IF
   
   LET g_craa001_t = g_craa_m.craa001
 
   
   LET g_craa_m.craa001 = ""
 
    
   CALL acrm300_set_entry("a")
   CALL acrm300_set_no_entry("a")
   
   #公用欄位給予預設值
   #此段落由子樣板a14產生    
      LET g_craa_m.craaownid = g_user
      LET g_craa_m.craaowndp = g_dept
      LET g_craa_m.craacrtid = g_user
      LET g_craa_m.craacrtdp = g_dept 
      LET g_craa_m.craacrtdt = cl_get_current()
      LET g_craa_m.craamodid = ""
      LET g_craa_m.craamoddt = ""
      #LET g_craa_m.craastus = ""
 
 
   
   #add-point:複製輸入前
   CALL s_aooi500_default(g_prog,'craaunit',g_site)
      RETURNING l_insert,g_craa_m.craaunit
   IF l_insert = FALSE THEN
      RETURN
   END IF
   CALL　s_desc_get_department_desc(g_craa_m.craaunit) RETURNING g_craa_m.craaunit_desc
   DISPLAY BY NAME g_craa_m.craaunit_desc
   
   LET g_craa_m.craa032 = '0'
   LET g_craa_m.craa021 = ''
   LET g_craa_m.craa022 = ''
   LET g_craa_m.craa033 = ''
   LET g_craa_m.craa029 = ''
   LET g_craa_m.craa030 = ''
   LET g_craa_m.craa031 = ''
   LET g_craa_m.craastus = 'N'
   LET g_craa_m.craacnfid = ''
   LET g_craa_m.craacnfdt = ''
   LET g_craa_m.craa013 = ''
   LET g_pmaa027_d = ''
   CALL aooi350_01_clear_detail()
   CALL aooi350_02_clear_detail()
   LET g_craa_m_t.* = g_craa_m.*
   LET g_craa_m_o.* = g_craa_m.*
   #end add-point
   
   CALL acrm300_input("r")
 
   
   
   IF INT_FLAG  THEN
      LET INT_FLAG = 0
      RETURN
   END IF
   
   CALL s_transaction_begin()
   
   #add-point:單頭複製前
   
   #end add-point
   
   #add-point:單頭複製中
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "craa_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:單頭複製後
   
   #end add-point
   
   CALL s_transaction_end('Y','0')
   
   LET g_state = "Y"
   
   LET g_wc = g_wc,  
              " OR (",
              " craa001 = '", g_craa_m.craa001 CLIPPED, "' "
 
              , ") "
   
   LET g_craa001_t = g_craa_m.craa001
 
   
   #add-point:完成複製段落後
   
   #end add-point
                   
END FUNCTION
 
{</section>}
 
{<section id="acrm300.show" >}
#+ 單頭資料重新顯示 
PRIVATE FUNCTION acrm300_show()
   #add-point:show段define
   
   #end add-point  
   
   #add-point:show段之前
   
   #end add-point
   
   
   
   LET g_craa_m_t.* = g_craa_m.*      #保存單頭舊值
   
   #在browser 移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()
   
   #帶出公用欄位reference值
   #此段落由子樣板a12產生
      #LET g_craa_m.craaownid_desc = cl_get_username(g_craa_m.craaownid)
      #LET g_craa_m.craaowndp_desc = cl_get_deptname(g_craa_m.craaowndp)
      #LET g_craa_m.craacrtid_desc = cl_get_username(g_craa_m.craacrtid)
      #LET g_craa_m.craacrtdp_desc = cl_get_deptname(g_craa_m.craacrtdp)
      #LET g_craa_m.craamodid_desc = cl_get_username(g_craa_m.craamodid)
      #LET g_craa_m.craacnfid_desc = cl_get_deptname(g_craa_m.craacnfid)
      ##LET g_craa_m.craapstid_desc = cl_get_deptname(g_craa_m.craapstid)
      
 
 
    
   #顯示followup圖示
   #+ 此段落由子樣板a48產生
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_craa_m.craa001
   LET g_pk_array[1].column = 'craa001'
 
   #add-point:ON ACTION agendum
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_craa_m.craa001
   CALL ap_ref_array2(g_ref_fields," SELECT craal004,craal003,craal005 FROM craal_t WHERE craalent = '"||g_enterprise||"' AND craal001 = ? AND craal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_craa_m.craal004 = g_rtn_fields[1] 
   LET g_craa_m.craal003 = g_rtn_fields[2] 
   LET g_craa_m.craal005 = g_rtn_fields[3] 
   DISPLAY g_craa_m.craal004,g_craa_m.craal003,g_craa_m.craal005 TO craal004,craal003,craal005

   CALL s_desc_get_department_desc(g_craa_m.craaunit) RETURNING g_craa_m.craaunit_desc
   DISPLAY BY NAME g_craa_m.craaunit_desc
   CALL s_desc_get_currency_desc(g_craa_m.craa008) RETURNING g_craa_m.craa008_desc
   DISPLAY BY NAME g_craa_m.craa008_desc
   CALL s_desc_get_currency_desc(g_craa_m.craa010) RETURNING g_craa_m.craa010_desc
   DISPLAY BY NAME g_craa_m.craa010_desc
   CALL s_desc_get_acc_desc('2107',g_craa_m.craa014) RETURNING g_craa_m.craa014_desc
   DISPLAY BY NAME g_craa_m.craa014_desc
   CALL s_desc_get_acc_desc('281',g_craa_m.craa015) RETURNING g_craa_m.craa015_desc
   DISPLAY BY NAME g_craa_m.craa015_desc
   CALL s_desc_get_acc_desc('2105',g_craa_m.craa016) RETURNING g_craa_m.craa016_desc
   DISPLAY BY NAME g_craa_m.craa016_desc
   CALL s_desc_get_dbaa001_desc(g_craa_m.craa020) RETURNING g_craa_m.craa020_desc
   CALL s_desc_get_dbaa001_desc(g_craa_m.craa019) RETURNING g_craa_m.craa019_desc
   CALL s_desc_get_dbaa001_desc(g_craa_m.craa018) RETURNING g_craa_m.craa018_desc
   CALL s_desc_get_dbaa001_desc(g_craa_m.craa017) RETURNING g_craa_m.craa017_desc
   DISPLAY BY NAME g_craa_m.craa020_desc,g_craa_m.craa019_desc,
                   g_craa_m.craa018_desc,g_craa_m.craa017_desc
   CALL s_desc_get_person_desc(g_craa_m.craa021) RETURNING g_craa_m.craa021_desc
   DISPLAY BY NAME g_craa_m.craa021_desc
   CALL s_desc_get_currency_desc(g_craa_m.craa027) RETURNING g_craa_m.craa027_desc
   DISPLAY BY NAME g_craa_m.craa027_desc
   CALL s_desc_get_trading_partner_abbr_desc(g_craa_m.craa029) RETURNING g_craa_m.craa029_desc
   DISPLAY BY NAME g_craa_m.craa029_desc
   CALL s_desc_get_trading_partner_abbr_desc(g_craa_m.craa031) RETURNING g_craa_m.craa031_desc
   DISPLAY BY NAME g_craa_m.craa031_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_craa_m.craaownid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_craa_m.craaownid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_craa_m.craaownid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_craa_m.craaowndp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_craa_m.craaowndp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_craa_m.craaowndp_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_craa_m.craacrtid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_craa_m.craacrtid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_craa_m.craacrtid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_craa_m.craacrtdp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_craa_m.craacrtdp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_craa_m.craacrtdp_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_craa_m.craamodid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_craa_m.craamodid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_craa_m.craamodid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_craa_m.craacnfid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_craa_m.craacnfid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_craa_m.craacnfid_desc

   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_craa_m.craaunit,g_craa_m.craaunit_desc,g_craa_m.craa001,g_craa_m.craal004,g_craa_m.craal003, 
       g_craa_m.craal005,g_craa_m.craa003,g_craa_m.craa032,g_craa_m.craastus,g_craa_m.craa004,g_craa_m.craa005, 
       g_craa_m.craa006,g_craa_m.craa007,g_craa_m.craa008,g_craa_m.craa008_desc,g_craa_m.craa009,g_craa_m.craa010, 
       g_craa_m.craa010_desc,g_craa_m.craa011,g_craa_m.craa012,g_craa_m.craa014,g_craa_m.craa014_desc, 
       g_craa_m.craa015,g_craa_m.craa015_desc,g_craa_m.craa016,g_craa_m.craa016_desc,g_craa_m.craa013, 
       g_craa_m.craa020,g_craa_m.craa020_desc,g_craa_m.craa019,g_craa_m.craa019_desc,g_craa_m.craa018, 
       g_craa_m.craa018_desc,g_craa_m.craa017,g_craa_m.craa017_desc,g_craa_m.craa021,g_craa_m.craa021_desc, 
       g_craa_m.craa022,g_craa_m.craa023,g_craa_m.craa024,g_craa_m.craa025,g_craa_m.craa026,g_craa_m.craa027, 
       g_craa_m.craa027_desc,g_craa_m.craa028,g_craa_m.craa033,g_craa_m.craa029,g_craa_m.craa029_desc, 
       g_craa_m.craa030,g_craa_m.craa031,g_craa_m.craa031_desc,g_craa_m.craaownid,g_craa_m.craaownid_desc, 
       g_craa_m.craaowndp,g_craa_m.craaowndp_desc,g_craa_m.craacrtid,g_craa_m.craacrtid_desc,g_craa_m.craacrtdp, 
       g_craa_m.craacrtdp_desc,g_craa_m.craacrtdt,g_craa_m.craamodid,g_craa_m.craamodid_desc,g_craa_m.craamoddt, 
       g_craa_m.craacnfid,g_craa_m.craacnfid_desc,g_craa_m.craacnfdt
   
   #顯示狀態(stus)圖片
         #此段落由子樣板a21產生
      CASE g_craa_m.craastus
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         
      END CASE
 
 
 
   #add-point:show段之後
   IF NOT cl_null(g_craa_m.craa013) THEN
      LET g_pmaa027_d = g_craa_m.craa013
      CALL aooi350_01_b_fill(g_pmaa027_d)
      CALL aooi350_02_b_fill(g_pmaa027_d)
   END IF
   CALL acrm300_b_fill(g_wc2_table1)
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="acrm300.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION acrm300_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define

   #end add-point  
   
   IF g_craa_m.craa001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      RETURN
   END IF
 
   CALL acrm300_show()
   
   CALL s_transaction_begin()
    
   LET g_craa001_t = g_craa_m.craa001
 
   
   LET g_master_multi_table_t.craal001 = g_craa_m.craa001
LET g_master_multi_table_t.craal004 = g_craa_m.craal004
LET g_master_multi_table_t.craal003 = g_craa_m.craal003
LET g_master_multi_table_t.craal005 = g_craa_m.craal005
 
 
   OPEN acrm300_cl USING g_enterprise,
                           g_craa_m.craa001
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN acrm300_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      CLOSE acrm300_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   FETCH acrm300_cl INTO g_craa_m.craaunit,g_craa_m.craaunit_desc,g_craa_m.craa001,g_craa_m.craal004, 
       g_craa_m.craal003,g_craa_m.craal005,g_craa_m.craa003,g_craa_m.craa032,g_craa_m.craastus,g_craa_m.craa004, 
       g_craa_m.craa005,g_craa_m.craa006,g_craa_m.craa007,g_craa_m.craa008,g_craa_m.craa008_desc,g_craa_m.craa009, 
       g_craa_m.craa010,g_craa_m.craa010_desc,g_craa_m.craa011,g_craa_m.craa012,g_craa_m.craa014,g_craa_m.craa014_desc, 
       g_craa_m.craa015,g_craa_m.craa015_desc,g_craa_m.craa016,g_craa_m.craa016_desc,g_craa_m.craa013, 
       g_craa_m.craa020,g_craa_m.craa020_desc,g_craa_m.craa019,g_craa_m.craa019_desc,g_craa_m.craa018, 
       g_craa_m.craa018_desc,g_craa_m.craa017,g_craa_m.craa017_desc,g_craa_m.craa021,g_craa_m.craa021_desc, 
       g_craa_m.craa022,g_craa_m.craa023,g_craa_m.craa024,g_craa_m.craa025,g_craa_m.craa026,g_craa_m.craa027, 
       g_craa_m.craa027_desc,g_craa_m.craa028,g_craa_m.craa033,g_craa_m.craa029,g_craa_m.craa029_desc, 
       g_craa_m.craa030,g_craa_m.craa031,g_craa_m.craa031_desc,g_craa_m.craaownid,g_craa_m.craaownid_desc, 
       g_craa_m.craaowndp,g_craa_m.craaowndp_desc,g_craa_m.craacrtid,g_craa_m.craacrtid_desc,g_craa_m.craacrtdp, 
       g_craa_m.craacrtdp_desc,g_craa_m.craacrtdt,g_craa_m.craamodid,g_craa_m.craamodid_desc,g_craa_m.craamoddt, 
       g_craa_m.craacnfid,g_craa_m.craacnfid_desc,g_craa_m.craacnfdt
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_craa_m.craa001
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      RETURN
   END IF
   #160818-00017#5 -s by 08172
   #檢查是否允許此動作
   IF NOT acrm300_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #160818-00017#5 -e by 08172
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前

      #end add-point
 
      #+ 此段落由子樣板a47產生
      #刪除相關文件
      CALL g_pk_array.clear()
      LET g_pk_array[1].values = g_craa_m.craa001
      LET g_pk_array[1].column = 'craa001'
 
      #add-point:相關文件刪除前

      #end add-point   
      CALL cl_doc_remove()  
 
 
 
      DELETE FROM craa_t 
       WHERE craaent = g_enterprise AND craa001 = g_craa_m.craa001 
 
 
      #add-point:單頭刪除中

      #end add-point
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "craa_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
      END IF
  
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_master_multi_table_t.craal001
   LET l_field_keys[01] = 'craal001'
   LET l_var_keys_bak[02] = g_dlang
   LET l_field_keys[02] = 'craal002'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'craal_t')
 
      
      #add-point:單頭刪除後
      IF NOT cl_null(g_craa_m.craa013) THEN
         IF NOT s_aooi350_del(g_craa_m.craa013) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "oofa_t"
            LET g_errparam.popup = FALSE
            CALL cl_err()

            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
      #mark by geza 20160229(S)
#      DELETE FROM oofa_t
#       WHERE oofaent = g_enterprise
#         AND oofa001 IN (SELECT pmaj002 FROM pmaj_t WHERE pmajent = g_enterprise AND pmaj001 = g_craa_m.craa001)
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = 'del oofa'
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#         CALL s_transaction_end('N','0')
#         RETURN
#      END IF 
      #mark by geza 20160229(E)      
      DELETE FROM oofb_t
       WHERE oofbent = g_enterprise
         AND oofb002 IN (SELECT pmaj002 FROM pmaj_t WHERE pmajent = g_enterprise AND pmaj001 = g_craa_m.craa001)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'del oofb'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF         
      DELETE FROM oofc_t
       WHERE oofcent = g_enterprise
         AND oofc002 IN (SELECT pmaj002 FROM pmaj_t WHERE pmajent = g_enterprise AND pmaj001 = g_craa_m.craa001)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'del oofc'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF         
      DELETE FROM pmaj_t
       WHERE pmajent = g_enterprise AND pmaj001 = g_craa_m.craa001 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "craa_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      CALL g_pmaj_d.clear()
      #end add-point
      
          
      
      CLEAR FORM
      CALL acrm300_ui_browser_refresh()
      IF g_browser_cnt > 0 THEN
         CALL acrm300_fetch("P")
      ELSE
         CALL acrm300_browser_fill(" 1=1 ","F")
      END IF
      
   END IF
 
   CLOSE acrm300_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_craa_m.craa001,"D")
 
END FUNCTION
 
{</section>}
 
{<section id="acrm300.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION acrm300_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define
   
   #end add-point     
 
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_craa001 = g_craa_m.craa001 THEN  
         CALL g_browser.deleteElement(l_i)
         LET g_header_cnt = g_header_cnt - 1
       END IF
   END FOR
   
   DISPLAY g_header_cnt TO FORMONLY.b_count     #page count
   DISPLAY g_header_cnt TO FORMONLY.h_count     #page count
   LET g_browser_cnt = g_browser_cnt-1
   IF g_current_idx > g_browser_cnt THEN        #確定browse 筆數指在同一筆
      LET g_current_idx = g_browser_cnt
   END IF
  
END FUNCTION
 
{</section>}
 
{<section id="acrm300.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION acrm300_set_entry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define
   
   #end add-point     
 
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("craa001",TRUE)
      #add-point:set_entry段欄位控制
      CALL cl_set_comp_entry("craaunit",TRUE)
      CALL cl_set_comp_entry("craa016",TRUE)
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後
   CALL cl_set_comp_entry("craa021",TRUE)
   CALL cl_set_comp_entry("craa022",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="acrm300.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION acrm300_set_no_entry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define
   
   #end add-point     
 
   IF p_cmd = "u" THEN
      CALL cl_set_comp_entry("craa001",FALSE)
      #add-point:set_no_entry段欄位控制
      CALL cl_set_comp_entry("craa016",FALSE)
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後
   CALL cl_set_comp_entry("craa021",FALSE)
   CALL cl_set_comp_entry("craa022",FALSE)
   
   #aooi500設定的欄位控卡
   IF NOT s_aooi500_comp_entry(g_prog,'craaunit') THEN
      CALL cl_set_comp_entry("craaunit",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="acrm300.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION acrm300_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   #add-point:default_search段define
   
   #end add-point  
   
   #add-point:default_search段開始前
 
   #end add-point  
   
   LET g_pagestart = 1
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " craa001 = '", g_argv[1], "' AND "
   END IF
   
 
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF
   
   #add-point:default_search段結束前
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="acrm300.state_change" >}
   #+ 此段落由子樣板a09產生
#+ 確認碼變更
PRIVATE FUNCTION acrm300_statechange()
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define
   DEFINE l_success       LIKE type_t.num5
   #end add-point  
   
   #add-point:statechange段開始前
#   IF g_craa_m.craastus = 'X' THEN
#      RETURN
#   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_craa_m.craa001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      RETURN
   END IF
   #160818-00017#5 -s by 08172
   #檢查是否允許此動作
   IF NOT acrm300_action_chk() THEN
      CLOSE acrm300_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #160818-00017#5 -e by 08172
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_craa_m.craastus
            WHEN "N"
               HIDE OPTION "open"
            WHEN "X"
               HIDE OPTION "void"
            WHEN "Y"
               HIDE OPTION "valid"
            
         END CASE
     
      #add-point:menu前
      CALL cl_set_act_visible("open,void,valid",TRUE)
      CASE g_craa_m.craastus
         WHEN "N"
            CALL cl_set_act_visible("open",FALSE)

         WHEN "X"
            CALL cl_set_act_visible("void,valid",FALSE)

         WHEN "Y"
            CALL cl_set_act_visible("void,valid",FALSE)

      END CASE
      #end add-point
      
      ON ACTION open
         LET lc_state = "N"
         #add-point:action控制

         #end add-point
         EXIT MENU
      ON ACTION void
         LET lc_state = "X"
         #add-point:action控制

         #end add-point
         EXIT MENU
      ON ACTION valid
         LET lc_state = "Y"
         #add-point:action控制

         #end add-point
         EXIT MENU
      
      
      
      #add-point:stus控制

      #end add-point
      
   END MENU
   
   IF (lc_state <> "N" 
      AND lc_state <> "X"
      AND lc_state <> "Y"
      ) OR 
      cl_null(lc_state) THEN
      RETURN
   END IF
   
   #add-point:stus修改前
   LET l_success = TRUE
   CALL cl_showmsg_init()
   CALL s_transaction_begin()
   OPEN acrm300_cl USING g_enterprise,g_craa_m.craa001
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN acrm300_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE acrm300_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   IF lc_state = 'Y' THEN
      CALL s_acrm300_conf_chk(g_craa_m.craa001) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_showmsg()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00108') THEN
            CALL s_transaction_end('N','0')
            CALL cl_showmsg()
            RETURN
         ELSE
            CALL s_acrm300_conf_upd(g_craa_m.craa001) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_showmsg()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
         END IF
      END IF
   END IF
   IF lc_state = 'N' AND g_craa_m.craastus = 'Y' THEN
      CALL s_acrm300_unconf_chk(g_craa_m.craa001) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_showmsg()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00110') THEN
            CALL s_transaction_end('N','0')   #160812-00017#4 20160815 add by beckxie
            RETURN
         ELSE
            CALL s_acrm300_unconf_upd(g_craa_m.craa001) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_showmsg()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
         END IF
      END IF
   END IF
   #dongsz--add--str---
   IF lc_state = 'N' AND g_craa_m.craastus = 'X' THEN
      CALL s_acrm300_valid_chk(g_craa_m.craa001) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_showmsg()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('art-00038') THEN
            CALL s_transaction_end('N','0')   #160812-00017#4 20160815 add by beckxie
            RETURN
         ELSE
            CALL s_acrm300_valid_upd(g_craa_m.craa001) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_showmsg()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
         END IF
      END IF
   END IF
   #dongsz--add--end---
   IF lc_state = 'X' THEN
      CALL s_acrm300_void_chk(g_craa_m.craa001) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_showmsg()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('art-00039') THEN
            CALL s_transaction_end('N','0')
            CALL cl_showmsg()
            RETURN
         ELSE
            CALL s_acrm300_void_upd(g_craa_m.craa001) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_showmsg()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
         END IF
      END IF
   END IF
   #end add-point
      
   UPDATE craa_t SET craastus = lc_state 
    WHERE craaent = g_enterprise AND craa001 = g_craa_m.craa001
 
  
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         
      END CASE
      LET g_craa_m.craastus = lc_state
      DISPLAY BY NAME g_craa_m.craastus
   END IF
 
   #add-point:stus修改後
   CALL acrm300_act_set_no_entry()
   CALL acrm300_act_set_entry()
   #end add-point
 
   #add-point:statechange段結束前

   #end add-point  
 
END FUNCTION
 
 
 
{</section>}
 
{<section id="acrm300.signature" >}
 
 
{</section>}
 
{<section id="acrm300.set_pk_array" >}
 
 
{</section>}
 
{<section id="acrm300.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="acrm300.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 取的上級地域編號
# Memo...........:
# Usage..........: CALL acrm300_get_dbaa003(p_dbaa001,p_dbaa002)
#                  RETURNING r_dbaa003
# Input parameter: p_dbaa001      地域編號
#                : p_dbaa002      地域類型
# Return code....: r_dbaa003      上級地域編號
# Date & Author..: 2014/04/17 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION acrm300_get_dbaa003(p_dbaa001,p_dbaa002)
DEFINE p_dbaa001       LIKE dbaa_t.dbaa001
DEFINE p_dbaa002       LIKE dbaa_t.dbaa002
DEFINE r_dbaa003       LIKE dbaa_t.dbaa003

   LET r_dbaa003 = ''
   SELECT dbaa003 INTO r_dbaa003
     FROM dbaa_t
    WHERE dbaaent = g_enterprise
      AND dbaa001 = p_dbaa001
      AND dbaa002 = p_dbaa002
      AND dbaastus = 'Y'
      
   RETURN r_dbaa003
END FUNCTION

################################################################################
# Descriptions...: action開啟(有條件)
# Memo...........:
# Usage..........: CALL acrm300_act_set_entry()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/17 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION acrm300_act_set_entry()
   IF g_craa_m.craastus = 'N' THEN
      CALL cl_set_act_visible("modify,delete",TRUE)
   END IF
   
   #指派
   IF g_craa_m.craastus = 'Y' AND (g_craa_m.craa032 = '0' OR g_craa_m.craa032 = '2') THEN
      CALL cl_set_act_visible("acrm300_upd_craa021",TRUE)
   END IF
   
   #開放
   IF g_craa_m.craastus = 'Y' AND g_craa_m.craa032 = '1' THEN
      CALL cl_set_act_visible("acrm300_clear_craa021",TRUE)
   END IF
   
   #成交
   IF g_craa_m.craastus = 'Y' AND g_craa_m.craa032 = '1' THEN
      CALL cl_set_act_visible("open_acrm300_01",TRUE)
   END IF
   
   #結案
   IF g_craa_m.craastus = 'Y' AND g_craa_m.craa032 = '1' THEN
      CALL cl_set_act_visible("open_acrm300_02",TRUE)
   END IF
   
   #取消成交
   IF g_craa_m.craastus = 'Y' AND g_craa_m.craa032 = '3' THEN
      CALL cl_set_act_visible("acrm300_clear_craa029",TRUE)
   END IF
   
   #取消結案
   IF g_craa_m.craastus = 'Y' AND g_craa_m.craa032 = '4' THEN
      CALL cl_set_act_visible("acrm300_clear_craa031",TRUE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: action關閉(無條件)
# Memo...........:
# Usage..........: CALL acrm300_act_set_no_entry()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/17 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION acrm300_act_set_no_entry()
   CALL cl_set_act_visible("acrm300_upd_craa021",FALSE)
   CALL cl_set_act_visible("acrm300_clear_craa021",FALSE)
   CALL cl_set_act_visible("open_acrm300_01",FALSE)
   CALL cl_set_act_visible("open_acrm300_02",FALSE)
   CALL cl_set_act_visible("acrm300_clear_craa029",FALSE)
   CALL cl_set_act_visible("acrm300_clear_craa031",FALSE)
   CALL cl_set_act_visible("modify,delete",FALSE)
END FUNCTION

################################################################################
# Descriptions...: 指派業務人員action動作
# Memo...........:
# Usage..........: CALL acrm300_upd_craa021(p_cmd)
# Input parameter: p_cmd   操作動作
# Return code....: 無
# Date & Author..: 2014/04/17 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION acrm300_upd_craa021(p_cmd)
DEFINE p_cmd       LIKE type_t.chr10

   IF cl_null(g_craa_m.craa001) THEN
      RETURN
   END IF
   
   CALL cl_set_comp_entry("craa021",TRUE)
   CALL cl_set_comp_entry("craa022",TRUE)
   DISPLAY BY NAME g_craa_m.craa021,g_craa_m.craa022
   
   CALL s_transaction_begin()
   OPEN acrm300_cl USING g_enterprise,g_craa_m.craa001
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN acrm300_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE acrm300_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   INPUT BY NAME g_craa_m.craa021,g_craa_m.craa022 WITHOUT DEFAULTS
     
      BEFORE INPUT
         IF s_transaction_chk("N",0) THEN
            CALL s_transaction_begin()
         END IF
         LET g_craa_m_o.* = g_craa_m.*
         LET g_craa_m.craa022 = g_today
         DISPLAY BY NAME g_craa_m.craa022
         CALL cl_showmsg_init()
   
      AFTER FIELD craa021
         LET g_craa_m.craa021_desc = ' '
         DISPLAY BY NAME g_craa_m.craa021_desc
         IF NOT cl_null(g_craa_m.craa021) THEN
            IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_craa_m.craa021 != g_craa_m_o.craa021 OR g_craa_m_o.craa021 IS NULL )) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_craa_m.craa021
               #160318-00025#27  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#27  by 07900 --add-end
               IF NOT cl_chk_exist("v_ooag001") THEN
                  LET g_craa_m.craa021 = g_craa_m_o.craa021
                  CALL s_desc_get_person_desc(g_craa_m.craa021) RETURNING g_craa_m.craa021_desc
                  DISPLAY BY NAME g_craa_m.craa021_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
         END IF
         CALL s_desc_get_person_desc(g_craa_m.craa021) RETURNING g_craa_m.craa021_desc
         DISPLAY BY NAME g_craa_m.craa021_desc
         LET g_craa_m_o.craa021 = g_craa_m.craa021

      ON ACTION controlp INFIELD craa021
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.default1 = g_craa_m.craa021      #給予default值
         CALL q_ooag001()                                #呼叫開窗
         LET g_craa_m.craa021 = g_qryparam.return1
         DISPLAY g_craa_m.craa021 TO craa021
         CALL s_desc_get_person_desc(g_craa_m.craa021) RETURNING g_craa_m.craa021_desc
         DISPLAY BY NAME g_craa_m.craa021_desc
         NEXT FIELD craa021                          #返回原欄位
 
      AFTER INPUT
         IF INT_FLAG THEN
            CALL s_transaction_end('N','0')
            EXIT INPUT
         END IF
             
         CALL cl_showmsg()   #錯誤訊息統整顯示
 
         IF p_cmd = "u" THEN
            LET g_craa_m.craa032 = '1'
            LET g_craa_m.craamodid = g_user
            LET g_craa_m.craamoddt = cl_get_current()
            
            UPDATE craa_t
               SET craa032 = g_craa_m.craa032,
                   craa021 = g_craa_m.craa021,
                   craa022 = g_craa_m.craa022,
                   craamodid = g_craa_m.craamodid,
                   craamoddt = g_craa_m.craamoddt
             WHERE craaent = g_enterprise
               AND craa001 = g_craa_m.craa001
            CASE
               WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "std-00009"
                  LET g_errparam.extend = "craa_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
               WHEN SQLCA.sqlcode #其他錯誤
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "craa_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CALL s_transaction_end('N','0')
               OTHERWISE
                  CALL s_transaction_end('Y','0')
            END CASE
         END IF
   END INPUT
   CLOSE acrm300_cl
   CALL cl_set_comp_entry("craa021",FALSE)
   CALL cl_set_comp_entry("craa022",FALSE)
END FUNCTION

################################################################################
# Descriptions...: 開放action動作
# Memo...........:
# Usage..........: CALL acrm300_clear_craa021()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/17 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION acrm300_clear_craa021()
   IF cl_null(g_craa_m.craa001) THEN
      RETURN
   END IF
   
   CALL s_transaction_begin()
   OPEN acrm300_cl USING g_enterprise,g_craa_m.craa001
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN acrm300_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE acrm300_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   LET g_craa_m.craa021 = ''
   LET g_craa_m.craa022 = ''
   LET g_craa_m.craa032 = '2'
   LET g_craa_m.craamodid = g_user
   LET g_craa_m.craamoddt = cl_get_current()
            
   UPDATE craa_t
      SET craa032 = g_craa_m.craa032,
          craa021 = g_craa_m.craa021,
          craa022 = g_craa_m.craa022,
          craamodid = g_craa_m.craamodid,
          craamoddt = g_craa_m.craamoddt
    WHERE craaent = g_enterprise
      AND craa001 = g_craa_m.craa001
   CASE
      WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "std-00009"
         LET g_errparam.extend = "craa_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
      WHEN SQLCA.sqlcode #其他錯誤
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "craa_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         CALL s_transaction_end('N','0')
      OTHERWISE
         CALL s_transaction_end('Y','0')
   END CASE
   CLOSE acrm300_cl
END FUNCTION

################################################################################
# Descriptions...: 取消成交action動作
# Memo...........:
# Usage..........: CALL acrm300_clear_craa029()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/17 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION acrm300_clear_craa029()
   IF cl_null(g_craa_m.craa001) THEN
      RETURN
   END IF
   
   CALL s_transaction_begin()
   OPEN acrm300_cl USING g_enterprise,g_craa_m.craa001
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN acrm300_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE acrm300_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   LET g_craa_m.craa033 = ''
   LET g_craa_m.craa029 = ''
   LET g_craa_m.craa032 = '1'
   LET g_craa_m.craamodid = g_user
   LET g_craa_m.craamoddt = cl_get_current()
            
   UPDATE craa_t
      SET craa032 = g_craa_m.craa032,
          craa029 = g_craa_m.craa029,
          craa033 = g_craa_m.craa033,
          craamodid = g_craa_m.craamodid,
          craamoddt = g_craa_m.craamoddt
    WHERE craaent = g_enterprise
      AND craa001 = g_craa_m.craa001
   CASE
      WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "std-00009"
         LET g_errparam.extend = "craa_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
      WHEN SQLCA.sqlcode #其他錯誤
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "craa_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         CALL s_transaction_end('N','0')
      OTHERWISE
         CALL s_transaction_end('Y','0')
   END CASE
   CLOSE acrm300_cl
END FUNCTION

################################################################################
# Descriptions...: 取消結案action動作
# Memo...........:
# Usage..........: CALL acrm300_clear_craa031()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/17 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION acrm300_clear_craa031()
   IF cl_null(g_craa_m.craa001) THEN
      RETURN
   END IF
   
   CALL s_transaction_begin()
   OPEN acrm300_cl USING g_enterprise,g_craa_m.craa001
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN acrm300_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE acrm300_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   LET g_craa_m.craa030 = ''
   LET g_craa_m.craa031 = ''
   LET g_craa_m.craa032 = '1'
   LET g_craa_m.craamodid = g_user
   LET g_craa_m.craamoddt = cl_get_current()
            
   UPDATE craa_t
      SET craa032 = g_craa_m.craa032,
          craa030 = g_craa_m.craa030,
          craa031 = g_craa_m.craa031,
          craamodid = g_craa_m.craamodid,
          craamoddt = g_craa_m.craamoddt
    WHERE craaent = g_enterprise
      AND craa001 = g_craa_m.craa001
   CASE
      WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "std-00009"
         LET g_errparam.extend = "craa_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
      WHEN SQLCA.sqlcode #其他錯誤
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "craa_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         CALL s_transaction_end('N','0')
      OTHERWISE
         CALL s_transaction_end('Y','0')
   END CASE
   CLOSE acrm300_cl
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL acrm300_pmaj002_ref(p_pmaj002)
# Input parameter: p_pmaj001      交易对象编号
# Input parameter: p_pmaj002      联络人识别码
# Return code....: 无
# Date & Author..: 2014/08/04 By yangxf
# Modify.........: 2016/02/29 By geza
################################################################################
PRIVATE FUNCTION acrm300_pmaj002_ref(p_pmaj001,p_pmaj002)
DEFINE p_pmaj002   LIKE pmaj_t.pmaj002
DEFINE r_oofa008   LIKE oofa_t.oofa008
DEFINE r_oofa009   LIKE oofa_t.oofa009
DEFINE r_oofa010   LIKE oofa_t.oofa010
DEFINE r_oofa011   LIKE oofa_t.oofa011
DEFINE r_oofa012   LIKE oofa_t.oofa012
DEFINE r_oofa013   LIKE oofa_t.oofa013
DEFINE p_pmaj001   LIKE pmaj_t.pmaj001 #add by geza 20160229
      LET r_oofa008 = ' '
      LET r_oofa009 = ' '
      LET r_oofa010 = ' '
      LET r_oofa011 = ' '
      LET r_oofa012 = ' '
      LET r_oofa013 = ' '
      #mark by geza 20160229(S)
#      SELECT oofa008,oofa009,oofa010,oofa011,oofa012,oofa013 INTO r_oofa008,r_oofa009,r_oofa010,r_oofa011,r_oofa012,r_oofa013 FROM oofa_t 
#         WHERE oofaent=g_enterprise AND oofa001=p_pmaj002
      #mark by geza 20160229(E)
      #add by geza 20160229(S)
      SELECT pmaj009,pmaj010,pmaj011,pmaj012,pmaj013,pmaj014 INTO r_oofa008,r_oofa009,r_oofa010,r_oofa011,r_oofa012,r_oofa013 FROM pmaj_t 
         WHERE pmajent=g_enterprise AND pmaj002=p_pmaj002 AND pmaj001 = p_pmaj001
      #add by geza 20160229(E)       
      RETURN r_oofa008,r_oofa009,r_oofa010,r_oofa011,r_oofa012,r_oofa013
END FUNCTION

################################################################################
# Descriptions...: 財務主要聯絡人否检查
# Memo...........:
# Usage..........: CALL acrm300_pmaj005_chk()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/08/04 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION acrm300_pmaj005_chk()
DEFINE l_n         LIKE type_t.num5
DEFINE r_success   LIKE type_t.num5
 
       LET l_n = 0
       LET r_success = TRUE
       
       SELECT COUNT(*) INTO l_n FROM pmaj_t WHERE pmaj001 = g_craa_m.craa001 AND pmaj005 = 'Y' AND pmajent=g_enterprise #160905-00007#1 add
       IF l_n > 0 THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'apm-00049'
          LET g_errparam.extend = g_craa_m.craa001
          LET g_errparam.popup = TRUE
          CALL cl_err()

          LET r_success = FALSE
          RETURN r_success
       END IF
       RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 不可勾選多個主要聯絡人
# Memo...........:
# Usage..........: CALL acrm300_pmaj004_chk()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/08/04 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION acrm300_pmaj004_chk()
DEFINE l_n         LIKE type_t.num5
DEFINE r_success   LIKE type_t.num5
 
       LET l_n = 0
       LET r_success = TRUE
       
       SELECT COUNT(*) INTO l_n FROM pmaj_t WHERE pmaj001 = g_craa_m.craa001 AND pmaj004 = 'Y' AND pmajent=g_enterprise #160905-00007#1 add
       IF l_n > 0 THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'apm-00048'
          LET g_errparam.extend = g_craa_m.craa001
          LET g_errparam.popup = TRUE
          CALL cl_err()

          LET r_success = FALSE
          RETURN r_success
       END IF
       RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 填充单身
# Memo...........:
# Usage..........: CALL acrm300_b_fill(p_wc2)
# Input parameter: p_wc2          查询条件
# Return code....: 无
# Date & Author..: 2014/08/04 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION acrm300_b_fill(p_wc2)
   DEFINE p_wc2      STRING  
 
   #先清空單身變數內容
   CALL g_pmaj_d.clear()
   
   LET g_sql = "SELECT  UNIQUE pmajstus,pmaj002,pmaj003,pmaj004,pmaj005,pmaj006,pmaj007,pmaj008 FROM pmaj_t", 
               " WHERE pmajent= ? AND pmaj001=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("pmaj_t")
   END IF
   LET g_sql = g_sql, " ORDER BY pmaj_t.pmaj002"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE acrm300_pb FROM g_sql
   DECLARE b_fill_cs CURSOR FOR acrm300_pb
   LET g_cnt = l_ac
   LET l_ac = 1
   OPEN b_fill_cs USING g_enterprise,g_craa_m.craa001
   FOREACH b_fill_cs INTO g_pmaj_d[l_ac].pmajstus,g_pmaj_d[l_ac].pmaj002,g_pmaj_d[l_ac].pmaj003,g_pmaj_d[l_ac].pmaj004, 
       g_pmaj_d[l_ac].pmaj005,g_pmaj_d[l_ac].pmaj006,g_pmaj_d[l_ac].pmaj007,g_pmaj_d[l_ac].pmaj008 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      #CALL acrm300_pmaj002_ref(g_pmaj_d[l_ac].pmaj002) RETURNING g_pmaj_d[l_ac].oofa008,g_pmaj_d[l_ac].oofa009,g_pmaj_d[l_ac].oofa010,g_pmaj_d[l_ac].oofa011,g_pmaj_d[l_ac].oofa012,g_pmaj_d[l_ac].oofa013 #mark by geza 20160229
      CALL acrm300_pmaj002_ref(g_craa_m.craa001,g_pmaj_d[l_ac].pmaj002) RETURNING g_pmaj_d[l_ac].pmaj009,g_pmaj_d[l_ac].pmaj010,g_pmaj_d[l_ac].pmaj011,g_pmaj_d[l_ac].pmaj012,g_pmaj_d[l_ac].pmaj013,g_pmaj_d[l_ac].pmaj014 #mark by geza 20160229

      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
   END FOREACH
   CALL g_pmaj_d.deleteElement(g_pmaj_d.getLength())
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
   FREE acrm300_pb   
END FUNCTION

################################################################################
# Descriptions...: 单身删除
# Memo...........:
# Usage..........: CALL acrm300_before_delete()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/08/04 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION acrm300_before_delete()

   DELETE FROM pmaj_t
    WHERE pmajent = g_enterprise AND pmaj001 = g_craa_m.craa001 AND
          pmaj002 = g_pmaj_d_t.pmaj002
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "pmaj_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      RETURN FALSE 
   END IF
   
   IF NOT s_aooi350_del(g_pmaj_d_t.pmaj002) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "oofa_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE 
   END IF
 
   LET g_rec_b = g_rec_b-1
   DISPLAY g_rec_b TO FORMONLY.cnt
 
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 修改，删除时重新检查状态
# Date & Author..: #160818-00017#5 2016/08/22 By 08172
# Modify.........:
################################################################################
PRIVATE FUNCTION acrm300_action_chk()
   SELECT craastus  INTO g_craa_m.craastus
     FROM craa_t
    WHERE craaent = g_enterprise
      AND craa001 = g_craa_m.craa001

   LET g_errno = NULL
   IF (g_action_choice="modify" OR g_action_choice="modify_detail" OR g_action_choice="delete")  THEN
     CASE g_craa_m.craastus
        WHEN 'W'
           LET g_errno = 'sub-00180'
        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
        WHEN 'S'
           LET g_errno = 'sub-00230'
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_craa_m.craa001
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL acrm300_show()
        RETURN FALSE
     END IF
   END IF
  
   #end add-point
      
   RETURN TRUE
END FUNCTION

 
{</section>}
 
