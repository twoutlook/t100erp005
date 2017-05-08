#該程式已解開Section, 不再透過樣板產出!
{<section id="aprq551.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PD版次:1) Build-000009
#+ 
#+ Filename...: aprq551
#+ Description: 促銷規則清單查詢
#+ Creator....: 02296(2014/06/09)
#+ Modifier...: 02296(2014/06/09)
#+ Buildtype..: 應用 t01 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="aprq551.global" >}
#160318-00025#15  2016/04/05    BY 07900     重复错误讯息的修改
#160905-00007#12  2016/09/05    by 08742     调整系统中无ENT的SQL条件增加ent
#160919-00062#2   2016/09/21    by dongsz    调整单身b_fill条件关联错误
#161108-00016#1   2016/11/09    by 08742     修改 g_browser_cnt 定义大小
    
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_prdw_m        RECORD
       prdwunit LIKE prdw_t.prdwunit, 
   prdwunit_desc LIKE type_t.chr80, 
   prdwsite LIKE prdw_t.prdwsite, 
   prdwsite_desc LIKE type_t.chr80, 
   prdw099 LIKE prdw_t.prdw099, 
   pos LIKE type_t.chr1, 
   prdw001 LIKE prdw_t.prdw001, 
   prdw002 LIKE prdw_t.prdw002, 
   prdwl003 LIKE prdwl_t.prdwl003, 
   prdw100 DATETIME YEAR TO SECOND, 
   prdw006 LIKE prdw_t.prdw006, 
   prdw006_desc LIKE type_t.chr80, 
   prdw007 LIKE prdw_t.prdw007, 
   prdw007_desc LIKE type_t.chr80, 
   prdw027 LIKE prdw_t.prdw027, 
   prdwstus LIKE prdw_t.prdwstus, 
   prdw004 LIKE prdw_t.prdw004, 
   prdw004_desc LIKE type_t.chr80, 
   prdw005 LIKE prdw_t.prdw005, 
   prdw005_desc LIKE type_t.chr80, 
   prdw003 LIKE prdw_t.prdw003, 
   prdw012 LIKE prdw_t.prdw012, 
   prdw010 LIKE prdw_t.prdw010, 
   prdw013 LIKE prdw_t.prdw013, 
   prdw011 LIKE prdw_t.prdw011, 
   prdw014 LIKE prdw_t.prdw014, 
   prdd003 LIKE prdd_t.prdd003, 
   prdd004 LIKE prdd_t.prdd004, 
   prdw098 LIKE prdw_t.prdw098, 
   prdw017 LIKE prdw_t.prdw017, 
   prdw020 LIKE prdw_t.prdw020, 
   prdw021 LIKE prdw_t.prdw021, 
   prdw008 LIKE prdw_t.prdw008, 
   prdw008_desc LIKE type_t.chr80, 
   prdw009 LIKE prdw_t.prdw009, 
   prdw009_desc LIKE type_t.chr80, 
   prdw022 LIKE prdw_t.prdw022, 
   prdw026 LIKE prdw_t.prdw026, 
   prdw023 LIKE prdw_t.prdw023, 
   prdw025 LIKE prdw_t.prdw025, 
   prdw028 LIKE prdw_t.prdw028, 
   prdw029 LIKE prdw_t.prdw029, 
   prdw030 LIKE prdw_t.prdw030, 
   prdw031 LIKE prdw_t.prdw031, 
   prdwcrtid LIKE prdw_t.prdwcrtid, 
   prdwcrtid_desc LIKE type_t.chr80, 
   prdwcrtdp LIKE prdw_t.prdwcrtdp, 
   prdwcrtdp_desc LIKE type_t.chr80, 
   prdwcrtdt DATETIME YEAR TO SECOND, 
   prdwownid LIKE prdw_t.prdwownid, 
   prdwownid_desc LIKE type_t.chr80, 
   prdwowndp LIKE prdw_t.prdwowndp, 
   prdwowndp_desc LIKE type_t.chr80, 
   prdwmodid LIKE prdw_t.prdwmodid, 
   prdwmodid_desc LIKE type_t.chr80, 
   prdwmoddt DATETIME YEAR TO SECOND, 
   prdwcnfid LIKE prdw_t.prdwcnfid, 
   prdwcnfid_desc LIKE type_t.chr80, 
   prdwcnfdt DATETIME YEAR TO SECOND, 
   prdw018 LIKE prdw_t.prdw018, 
   prdw032 LIKE prdw_t.prdw032, 
   prdw019 LIKE prdw_t.prdw019
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_prdc_d        RECORD
       prdcacti LIKE prdc_t.prdcacti, 
   prdc002 LIKE prdc_t.prdc002, 
   prdc003 LIKE prdc_t.prdc003, 
   prdc004 LIKE prdc_t.prdc004, 
   prdc004_desc LIKE type_t.chr500, 
   prdc001 LIKE prdc_t.prdc001, 
   prdcsite LIKE prdc_t.prdcsite, 
   prdcunit LIKE prdc_t.prdcunit
       END RECORD
PRIVATE TYPE type_g_prdc2_d RECORD
       prdhacti LIKE prdh_t.prdhacti, 
   prdh002 LIKE prdh_t.prdh002, 
   prdh000 LIKE prdh_t.prdh000, 
   prdh003 LIKE prdh_t.prdh003, 
   prdh005 LIKE prdh_t.prdh005,
   prdh006 LIKE prdh_t.prdh006,    
   prdh008 LIKE prdh_t.prdh008, 
   prdh009 LIKE prdh_t.prdh009,
   prdb005 LIKE type_t.num20_6, 
   prdh010 LIKE prdh_t.prdh010, 
   prdh011 LIKE prdh_t.prdh011, 
   prdh012 LIKE prdh_t.prdh012, 
   prdh013 LIKE prdh_t.prdh013, 
   prdh004 LIKE prdh_t.prdh004, 
   prdh007 LIKE prdh_t.prdh007, 
   prdh001 LIKE prdh_t.prdh001, 
   prdhsite LIKE prdh_t.prdhsite, 
   prdhunit LIKE prdh_t.prdhunit
       END RECORD
PRIVATE TYPE type_g_prdc3_d RECORD
       prdgacti LIKE prdg_t.prdgacti, 
   prdg010 LIKE prdg_t.prdg010, 
   prdg002 LIKE prdg_t.prdg002, 
   prdg003 LIKE prdg_t.prdg003, 
   prdg004 LIKE prdg_t.prdg004, 
   prdg004_desc LIKE type_t.chr500, 
   prdg006 LIKE prdg_t.prdg006, 
   prdg006_desc LIKE type_t.chr500, 
   prdg007 LIKE prdg_t.prdg007, 
   prdg008 LIKE prdg_t.prdg008, 
   prdg009 LIKE prdg_t.prdg009, 
   prdg001 LIKE prdg_t.prdg001, 
   prdgsite LIKE prdg_t.prdgsite, 
   prdgunit LIKE prdg_t.prdgunit, 
   prdg005 LIKE prdg_t.prdg005
       END RECORD
 
 
#模組變數(Module Variables)
DEFINE g_prdw_m          type_g_prdw_m
DEFINE g_prdw_m_t        type_g_prdw_m
 
   DEFINE g_prdwsite_t LIKE prdw_t.prdwsite
DEFINE g_prdw001_t LIKE prdw_t.prdw001
 
 
DEFINE g_prdc_d          DYNAMIC ARRAY OF type_g_prdc_d
DEFINE g_prdc_d_t        type_g_prdc_d
DEFINE g_prdc2_d   DYNAMIC ARRAY OF type_g_prdc2_d
DEFINE g_prdc2_d_t type_g_prdc2_d
DEFINE g_prdc3_d   DYNAMIC ARRAY OF type_g_prdc3_d
DEFINE g_prdc3_d_t type_g_prdc3_d
 
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位 
         b_statepic     LIKE type_t.chr50,
            b_prdwunit LIKE prdw_t.prdwunit,
   b_prdwunit_desc LIKE type_t.chr80,
      b_prdwsite LIKE prdw_t.prdwsite,
   b_prdwsite_desc LIKE type_t.chr80,
      b_prdw001 LIKE prdw_t.prdw001,
      b_prdw002 LIKE prdw_t.prdw002,
      b_prdw006 LIKE prdw_t.prdw006,
   b_prdw006_desc LIKE type_t.chr80,
      b_prdw007 LIKE prdw_t.prdw007,
   b_prdw007_desc LIKE type_t.chr80,
      b_prdw027 LIKE prdw_t.prdw027
      END RECORD 
      
DEFINE g_browser_f  RECORD    #資料瀏覽之欄位 
         b_statepic     LIKE type_t.chr50,
            b_prdwunit LIKE prdw_t.prdwunit,
   b_prdwunit_desc LIKE type_t.chr80,
      b_prdwsite LIKE prdw_t.prdwsite,
   b_prdwsite_desc LIKE type_t.chr80,
      b_prdw001 LIKE prdw_t.prdw001,
      b_prdw002 LIKE prdw_t.prdw002,
      b_prdw006 LIKE prdw_t.prdw006,
   b_prdw006_desc LIKE type_t.chr80,
      b_prdw007 LIKE prdw_t.prdw007,
   b_prdw007_desc LIKE type_t.chr80,
      b_prdw027 LIKE prdw_t.prdw027
      END RECORD 
      
DEFINE g_master_multi_table_t    RECORD
      prdwl001 LIKE prdwl_t.prdwl001,
      prdwl003 LIKE prdwl_t.prdwl003
      END RECORD
#無單身append欄位定義
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
 
 
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
 
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5        
#DEFINE g_rec_b               LIKE type_t.num5             #單身筆數   #161108-00016#1   2016/11/09  by 08742 mark                      
DEFINE g_rec_b               LIKE type_t.num10             #單身筆數    #161108-00016#1   2016/11/09  by 08742 add       
#DEFINE l_ac                  LIKE type_t.num5             #161108-00016#1   2016/11/09  by 08742 mark       
DEFINE l_ac                  LIKE type_t.num10             #161108-00016#1   2016/11/09  by 08742 add    
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
    
#DEFINE g_pagestart           LIKE type_t.num5             #page起始筆數#161108-00016#1   2016/11/09  by 08742 mark 
DEFINE g_pagestart           LIKE type_t.num10             #page起始筆數#161108-00016#1   2016/11/09  by 08742 add            
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_state               STRING       
 
#161108-00016#1   2016/11/09  by 08742 -S
#DEFINE g_detail_cnt          LIKE type_t.num5             #單身總筆數 
#DEFINE g_detail_idx          LIKE type_t.num5             #單身目前所在筆數
#DEFINE g_detail_idx2         LIKE type_t.num5             #單身2目前所在筆數
#DEFINE g_browser_cnt         LIKE type_t.num5             #Browser總筆數
#DEFINE g_browser_idx         LIKE type_t.num5             #Browser目前所在筆數
#DEFINE g_temp_idx            LIKE type_t.num5             #Browser目前所在筆數(暫存用)
DEFINE g_detail_cnt          LIKE type_t.num10             #單身總筆數  
DEFINE g_detail_idx          LIKE type_t.num10             #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10             #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10             
DEFINE g_browser_idx         LIKE type_t.num10             #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10             #Browser目前所在筆數(暫存用)
#161108-00016#1   2016/11/09  by 08742 -E
 
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序欄位
                                                        
#DEFINE g_current_row         LIKE type_t.num5             #Browser 所在筆數(暫存用) #161108-00016#1   2016/11/09  by 08742 mark
DEFINE g_current_row         LIKE type_t.num10             #Browser 所在筆數(暫存用) #161108-00016#1   2016/11/09  by 08742 add
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
#DEFINE g_current_page        LIKE type_t.num5             #目前所在頁數 #161108-00016#1   2016/11/09  by 08742 mark
DEFINE g_current_page        LIKE type_t.num10             #目前所在頁數 #161108-00016#1   2016/11/09  by 08742 add
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
DEFINE g_error_show          LIKE type_t.num5              #
 
DEFINE g_wc_frozen           STRING                        #凍結欄位使用
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
 
#add-point:自定義模組變數(Module Variable)
DEFINE l_success             LIKE type_t.num5
DEFINE g_prdw_m_o            type_g_prdw_m
DEFINE g_ooef004             LIKE ooef_t.ooef004
 TYPE type_g_prdc4_d RECORD
       prdkacti LIKE prdk_t.prdkacti, 
   prdj003 LIKE prdj_t.prdj003, 
   prdk003 like prdk_t.prdk003,
   prdk005 like prdk_t.prdk005,
   prdk005_desc like type_t.chr100,
   prdk007 like prdk_t.prdk007,
   prdk007_desc like type_t.chr100,
   prdk008 like prdk_t.prdk008,
   prdj005 like prdj_t.prdj005,
   prdj002 like prdj_t.prdj002
       END RECORD
 TYPE type_g_prdc5_d RECORD
       prdjacti_1 LIKE prdj_t.prdjacti, 
   prdj003_1 LIKE prdj_t.prdj003, 
   prdj002_1 like prdj_t.prdj002,
   prdj005_1 like prdj_t.prdj005  
       END RECORD 
 TYPE type_g_prdc6_d RECORD
       prdkacti_1 LIKE prdk_t.prdkacti, 
   prdk002_1 LIKE prdk_t.prdk002, 
   prdk003_1 like prdk_t.prdk003,
   prdk004_1 like prdk_t.prdk004,
   prdk005_1 like prdk_t.prdk005,
   prdk005_1_desc like type_t.chr100,
   prdk007_1 like prdk_t.prdk007,
   prdk007_1_desc like type_t.chr100,
   prdk008_1 like prdk_t.prdk008
       END RECORD
DEFINE g_prdc4_d   DYNAMIC ARRAY OF type_g_prdc4_d
DEFINE g_prdc4_d_t type_g_prdc4_d 
DEFINE g_prdc5_d   DYNAMIC ARRAY OF type_g_prdc5_d
DEFINE g_prdc5_d_t type_g_prdc4_d
DEFINE g_prdc6_d   DYNAMIC ARRAY OF type_g_prdc6_d
DEFINE g_prdc6_d_t type_g_prdc4_d
DEFINE l_ac4       LIKE type_t.num5
DEFINE l_ac5       LIKE type_t.num5
DEFINE l_ac6       LIKE type_t.num5
DEFINE g_wc2_table4   STRING
DEFINE g_wc2_table5   STRING
DEFINE g_wc2_table6   STRING
#end add-point
 
#add-point:傳入參數說明(global.argv)
 
#end add-point
 
{</section>}
 
{<section id="aprq551.main" >}
#+ 此段落由子樣板a26產生
#OPTIONS SHORT CIRCUIT
#+ 作業開始 
MAIN
   #add-point:main段define
   
   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("apr","")
 
   #add-point:作業初始化
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = "SELECT prdwunit,'',prdwsite,'',prdw099,'',prdw001,prdw002,'',prdw100,prdw006, 
       '',prdw007,'',prdw027,prdwstus,prdw004,'',prdw005,'',prdw003,prdw012,prdw010,prdw013,prdw011, 
       prdw014,'','',prdw098,prdw017,prdw020,prdw021,prdw008,'',prdw009,'',prdw022,prdw026,prdw023,prdw025, 
       prdw028,prdw029,prdw030,prdw031,prdwcrtid,'',prdwcrtdp,'',prdwcrtdt,prdwownid,'',prdwowndp,'', 
       prdwmodid,'',prdwmoddt,prdwcnfid,'',prdwcnfdt,prdw018,prdw032,prdw019 FROM prdw_t WHERE prdwent=  
       ? AND prdwsite=? AND prdw001=? FOR UPDATE"
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   DECLARE aprq551_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE prdwunit,prdwsite,prdw099,prdw001,prdw002,prdw100,prdw006,prdw007,prdw027, 
       prdwstus,prdw004,prdw005,prdw003,prdw012,prdw010,prdw013,prdw011,prdw014,prdw098,prdw017,prdw020, 
       prdw021,prdw008,prdw009,prdw022,prdw026,prdw023,prdw025,prdw028,prdw029,prdw030,prdw031,prdwcrtid, 
       prdwcrtdp,prdwcrtdt,prdwownid,prdwowndp,prdwmodid,prdwmoddt,prdwcnfid,prdwcnfdt,prdw018,prdw032, 
       prdw019",
               " FROM prdw_t",
               " WHERE prdwent = '" ||g_enterprise|| "' AND prdwsite = ? AND prdw001 = ?"
   #add-point:SQL_define
   
   #end add-point
   PREPARE aprq551_master_referesh FROM g_sql
 
 
 
 
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call
      
      #end add-point
 
   ELSE
      
      #畫面開啟 (identifier)
      OPEN WINDOW w_aprq551 WITH FORM cl_ap_formpath("apr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aprq551_init()   
 
      #進入選單 Menu (="N")
      CALL aprq551_ui_dialog() 
      
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aprq551
      
   END IF 
   
   CLOSE aprq551_cl
   
   
 
   #add-point:作業離開前
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="aprq551.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aprq551_init()
   #add-point:init段define
   
   #end add-point    
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_error_show  = 1
   LET l_ac = 1
      CALL cl_set_combo_scc_part('prdwstus','50','N,X,Y')
 
      CALL cl_set_combo_scc('prdw017','6561') 
   CALL cl_set_combo_scc('prdw021','6563') 
   CALL cl_set_combo_scc('prdw026','6566') 
   CALL cl_set_combo_scc('prdw025','6565') 
   CALL cl_set_combo_scc('prdw028','6715') 
   CALL cl_set_combo_scc('prdw018','6562') 
   CALL cl_set_combo_scc('prdw032','6716') 
   CALL cl_set_combo_scc('prdw019','6714') 
   CALL cl_set_combo_scc('prdh000','6717') 
   CALL cl_set_combo_scc('prdh003','6503') 
   CALL cl_set_combo_scc('prdh008','6570') 
   CALL cl_set_combo_scc('prdh009','6719') 
   CALL cl_set_combo_scc('prdh004','6569') 
   CALL cl_set_combo_scc('prdg003','6517') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
 
   #add-point:畫面資料初始化
   CALL cl_set_combo_scc('prdc003','6035')
  #CALL cl_set_combo_scc_part('prdh000','6717','1,3,4')
   CALL cl_set_combo_scc_part('prdg003','6517','4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L') 
   CALL cl_set_comp_entry("prdw019",FALSE)
   call cl_set_comp_visible("s_detail5,s_detail6",FALSE)   
   #end add-point
   
   CALL aprq551_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aprq551.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aprq551_ui_dialog()
   DEFINE li_idx    LIKE type_t.num5
   DEFINE ls_wc     STRING
   DEFINE lb_first  BOOLEAN
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   #add-point:ui_dialog段define

   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   CALL gfrm_curr.setElementImage("logo","logo/applogo.png") 
   IF g_default THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   ELSE
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF
   
   #action default動作
   
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog 

   #end add-point
   
   WHILE TRUE 
   
      CALL aprq551_browser_fill("")
      CALL lib_cl_dlg.cl_dlg_before_display()
      CALL cl_notice()
            
      #判斷前一個動作是否為新增, 若是的話切換到新增的筆數
      IF g_state = "Y" THEN
         FOR li_idx = 1 TO g_browser.getLength()
            IF g_browser[li_idx].b_prdwsite = g_prdwsite_t
               AND g_browser[li_idx].b_prdw001 = g_prdw001_t
 
               THEN
               LET g_current_row = li_idx
               LET g_current_idx = li_idx
               EXIT FOR
            END IF
         END FOR
         LET g_state = ""
      END IF
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
         #左側瀏覽頁簽
         DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTES(COUNT=g_header_cnt)
 
            BEFORE ROW
               #回歸舊筆數位置 (回到當時異動的筆數)
               LET g_current_idx = DIALOG.getCurrentRow("s_browse")
               IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
                  CALL DIALOG.setCurrentRow("s_browse",g_current_row)
                  LET g_current_idx = g_current_row
               END IF
               LET g_current_row = g_current_idx #目前指標
               LET g_current_sw = TRUE
 
               IF g_current_idx > g_browser.getLength() THEN
                  LET g_current_idx = g_browser.getLength()
               END IF 
               
               CALL aprq551_fetch('') # reload data
               LET l_ac = 1
               CALL aprq551_ui_detailshow() #Setting the current row 
      
               CALL aprq551_idx_chk()
               #NEXT FIELD prdcdocno
         
         END DISPLAY
        
         DISPLAY ARRAY g_prdc_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               CALL aprq551_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               
               #add-point:page1, before row動作

               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               CALL aprq551_idx_chk()
               #add-point:page1自定義行為

               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為

            #end add-point
               
         END DISPLAY
        
         DISPLAY ARRAY g_prdc2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               CALL aprq551_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               
               #add-point:page2, before row動作

               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               CALL aprq551_idx_chk()
               #add-point:page2自定義行為

               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為

            #end add-point
         
         END DISPLAY
         DISPLAY ARRAY g_prdc3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               CALL aprq551_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               
               #add-point:page3, before row動作

               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               CALL aprq551_idx_chk()
               #add-point:page3自定義行為

               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為

            #end add-point
         
         END DISPLAY
 
         
         #add-point:ui_dialog段自定義display array
         DISPLAY ARRAY g_prdc4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               CALL aprq551_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx = l_ac
               
               #add-point:page3, before row動作

               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_current_page = 4
               CALL aprq551_idx_chk()
               #add-point:page3自定義行為

               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為

            #end add-point
         
         END DISPLAY
         DISPLAY ARRAY g_prdc5_d TO s_detail5.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               CALL aprq551_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_detail_idx = l_ac
               
               #add-point:page3, before row動作

               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_current_page = 4
               CALL aprq551_idx_chk()
               #add-point:page3自定義行為

               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為

            #end add-point
         
         END DISPLAY
         DISPLAY ARRAY g_prdc6_d TO s_detail6.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               CALL aprq551_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
               LET g_detail_idx = l_ac
               
               #add-point:page3, before row動作

               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
               LET g_current_page = 4
               CALL aprq551_idx_chk()
               #add-point:page3自定義行為

               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為

            #end add-point
         
         END DISPLAY
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_page = "first"
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_idx = DIALOG.getCurrentRow("s_browse")
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               LET g_current_idx = g_current_row
            END IF
            LET g_current_row = g_current_idx #目前指標
            IF g_current_idx = 0 THEN
               LET g_current_idx = 1
            END IF
            LET g_current_sw = TRUE
            
            IF g_current_idx > g_browser.getLength() THEN
               LEt g_current_idx = g_browser.getLength()
            END IF 
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL aprq551_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aprq551_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aprq551_idx_chk()
            
            #add-point:ui_dialog段before_dialog2

            #end add-point
            
            IF lb_first THEN
               LET lb_first = FALSE
               NEXT FIELD prdc002
            END IF
         
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               #browser
               CALL g_export_node.clear()
               IF g_main_hidden = 1 THEN
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
               #非browser
               ELSE
                  LET g_export_node[1] = base.typeInfo.create(g_prdc_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_prdc2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_prdc3_d)
                  LET g_export_id[3]   = "s_detail3"
 
                  #add-point:ON ACTION exporttoexcel
                  LET g_export_node[4] = base.typeInfo.create(g_prdc4_d)
                  LET g_export_id[4]   = "s_detail4"
                  LET g_export_node[5] = base.typeInfo.create(g_prdc5_d)
                  LET g_export_id[5]   = "s_detail5"
                  LET g_export_node[6] = base.typeInfo.create(g_prdc6_d)
                  LET g_export_id[6]   = "s_detail6"
                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
         
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aprq551_statechange()
            EXIT DIALOG
      
         
          
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL aprq551_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
 
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL aprq551_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "-100"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
 
                  CLEAR FORM
               ELSE
                  CALL aprq551_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
          
         #+ 此段落由子樣板a49產生
            ON ACTION filter
               #add-point:filter action

               #end add-point
               CALL aprq551_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            CALL aprq551_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprq551_idx_chk()
            
         ON ACTION previous
            CALL aprq551_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprq551_idx_chk()
            
         ON ACTION jump
            CALL aprq551_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprq551_idx_chk()
            
         ON ACTION next
            CALL aprq551_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprq551_idx_chk()
            
         ON ACTION last
            CALL aprq551_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprq551_idx_chk()
            
         ON ACTION close
            LET INT_FLAG = FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG
          
         ON ACTION exit
            LET g_action_choice = "exit"
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
            
         ON ACTION worksheethidden   #瀏覽頁折疊
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
            END IF
       
         ON ACTION controls      #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
            IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("vb_master",0)
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("vb_master",1)
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden     
            END IF
    
         
         #+ 此段落由子樣板a43產生
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aprq551_query()
               #add-point:ON ACTION query
               
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output

               #END add-point
               EXIT DIALOG
            END IF
 
 
         
         #+ 此段落由子樣板a46產生
         #新增相關文件
         ON ACTION related_document
            CALL aprq551_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document

               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aprq551_set_pk_array()
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aprq551_set_pk_array()
            #add-point:ON ACTION followup

            #END add-point
            CALL cl_user_overview_follow('')
 
 
         
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl" 
            CONTINUE DIALOG
            
      END DIALOG
    
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
    
   END WHILE    
      
   CALL cl_set_act_visible("accept,cancel", TRUE)
    
END FUNCTION
 
{</section>}
 
{<section id="aprq551.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aprq551_browser_fill(ps_page_action)
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   #add-point:browser_fill段define
   CALL g_prdc4_d.clear()
   CALL g_prdc5_d.clear()
   CALL g_prdc6_d.clear()
   #end add-point    
 
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_prdw_m.* TO NULL
   CALL g_prdc_d.clear()        
   CALL g_prdc2_d.clear() 
   CALL g_prdc3_d.clear() 
 
   CALL g_browser.clear()
   
   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = '0' THEN
      LET l_searchcol = "prdwsite"
                        ,",prdw001"
 
   ELSE
      LET l_searchcol = g_searchcol
   END IF
   
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      RETURN
   END IF
   
   #add-point:browser_fill,foreach前
   
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE prdwsite ",
                                    ",prdw001 ",
 
                        " FROM prdw_t ",
                              " ",
                              " LEFT JOIN prdc_t ON prdcent = prdwent AND prdwsite = prdcdocno AND prdw001 = prdc002 AND  = prdc003 AND  = prdc004 ",
                              " LEFT JOIN prdh_t ON prdhent = prdwent AND prdwsite = prdhdocno AND prdw001 = prdh002", 
 
                              " LEFT JOIN prdg_t ON prdgent = prdwent AND prdwsite = prdgdocno AND prdw001 = prdg002 AND  = prdg003 AND  = prdg004", 
 
 
 
                              " LEFT JOIN prdwl_t ON prdwdocno = prdwl001 AND prdwl002 = '",g_lang,"' ", 
                              " ", 
                       " WHERE prdwent = '" ||g_enterprise|| "' AND prdcent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("prdw_t")
 
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE prdwsite ",
                                    ",prdw001 ",
 
                        " FROM prdw_t ", 
                              " ",
                              " LEFT JOIN prdwl_t ON prdwdocno = prdwl001 AND prdwl002 = '",g_lang,"' ",
                        "WHERE prdwent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("prdw_t")
   END IF
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前
      IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE prdwsite,prdw001 ",
 
                        " FROM prdw_t ",
                              " ",
                              " LEFT JOIN prdc_t ON prdcent = prdwent AND prdw001 = prdc001 AND prdwsite = prdcsite ",
                              " LEFT JOIN prdh_t ON prdhent = prdwent AND prdw001 = prdh001 AND prdwsite = prdhsite ", 
 
                              " LEFT JOIN prdg_t ON prdgent = prdwent AND prdw001 = prdg001 AND prdwsite = prdgsite ", 
                              " LEFT JOIN prdj_t ON prdjent = prdwent AND prdw001 = prdj001 AND prdwsite = prdjsite ",
                              " LEFT JOIN prdk_t ON prdkent = prdwent AND prdw001 = prdk001 AND prdwsite = prdksite ",
 
                              " LEFT JOIN prdwl_t ON prdw001 = prdwl001 AND prdwsite=prdwlsite AND prdwl002 = '",g_lang,"' ", 
                              " ", 
                       " WHERE prdwent = '" ||g_enterprise|| "' AND prdw098 = '2' AND prdcent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("prdw_t")
 
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE prdwsite,prdw001 ",
 
                        " FROM prdw_t ", 
                              " ",
                              " LEFT JOIN prdwl_t ON prdw001 = prdwl001 AND prdwsite=prdwlsite AND prdwl002 = '",g_lang,"' ",
                        "WHERE prdwent = '" ||g_enterprise|| "' AND prdw098 = '2' AND ",l_wc CLIPPED, cl_sql_add_filter("prdw_t")
   END IF
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
   #end add-point
   
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
   FREE header_cnt_pre
 
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
   
   #LET g_page_action = ps_page_action          # Keep Action
   
   IF ps_page_action = "F" OR
      ps_page_action = "P" OR
      ps_page_action = "N" OR
      ps_page_action = "L" THEN
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
         END IF
         
   END CASE
  
   #單身有輸入查詢條件且非null
   IF g_wc2 <> " 1=1" AND NOT cl_null(g_wc2) THEN 
      #依照prdwunit,'',prdwsite,'',prdw001,prdw002,prdw006,'',prdw007,'',prdw027 Browser欄位定義(取代原本bs_sql功能)
      LET l_sql_rank = "SELECT DISTINCT prdwstus,prdwunit,'',prdwsite,'',prdw001,prdw002,prdw006,'', 
          prdw007,'',prdw027,DENSE_RANK() OVER(ORDER BY prdwsite,prdw001 ",g_order,") AS RANK ",
                        " FROM prdw_t ",
                              " ",
                              " LEFT JOIN prdc_t ON prdcent = prdwent AND prdwsite = prdcdocno AND prdw001 = prdc002 AND  = prdc003 AND  = prdc004 ",
                              " LEFT JOIN prdh_t ON prdhent = prdwent AND prdwsite = prdhdocno AND prdw001 = prdh002",
 
                              " LEFT JOIN prdg_t ON prdgent = prdwent AND prdwsite = prdgdocno AND prdw001 = prdg002 AND  = prdg003 AND  = prdg004",
 
 
 
                              " LEFT JOIN prdwl_t ON prdwdocno = prdwl001 AND prdwl002 = '",g_lang,"' ",
                              " ",
                       " ",
                       " WHERE prdwent = '" ||g_enterprise|| "' AND ",g_wc," AND ",g_wc2, cl_sql_add_filter("prdw_t")
   ELSE
      #單身無輸入資料
      LET l_sql_rank = "SELECT DISTINCT prdwstus,prdwunit,'',prdwsite,'',prdw001,prdw002,prdw006,'', 
          prdw007,'',prdw027,DENSE_RANK() OVER(ORDER BY prdwsite,prdw001 ",g_order,") AS RANK ",
                       " FROM prdw_t ",
                            "  ",
                            "  LEFT JOIN prdwl_t ON prdwdocno = prdwl001 AND prdwl002 = '",g_lang,"' ",
                       " WHERE prdwent = '" ||g_enterprise|| "' AND ", g_wc, cl_sql_add_filter("prdw_t")
   END IF
   
   #定義翻頁CURSOR
   LET g_sql= "SELECT prdwstus,prdwunit,'',prdwsite,'',prdw001,prdw002,prdw006,'',prdw007,'',prdw027 FROM (", 
       l_sql_rank,") WHERE ",
              " RANK >= ",1," AND RANK<",1+g_max_browse,
              " ORDER BY ",l_searchcol," ",g_order
               
   #add-point:browser_fill,before_prepare
   IF g_wc2 <> " 1=1" AND NOT cl_null(g_wc2) THEN 
      #依照prdwunit,'',prdadocno,prdadocdt,prda000,prdw001,prdw002,prdw006,'',prdw007,'',prdw027 Browser欄位定義(取代原本bs_sql功能)
      LET l_sql_rank = "SELECT DISTINCT prdwstus,prdwunit,'',prdwsite,'',prdw001,prdw002,prdw006,'', 
          prdw007,'',prdw027,DENSE_RANK() OVER(ORDER BY prdwsite,prdw001 ",g_order,") AS RANK ",
                        " FROM prdw_t ",
                              " ",
                              " LEFT JOIN prdc_t ON prdcent = prdwent AND prdw001 = prdc001 AND prdwsite=prdcsite ",
                              " LEFT JOIN prdh_t ON prdhent = prdwent AND prdw001 = prdh001 AND prdwsite = prdhsite ",
 
                              " LEFT JOIN prdg_t ON prdgent = prdwent AND prdw001 = prdg001 AND prdwsite = prdgsite ",
                              " LEFT JOIN prdj_t ON prdjent = prdwent AND prdw001 = prdj001 AND prdwsite = prdjsite ",
                              " LEFT JOIN prdk_t ON prdkent = prdwent AND prdw001 = prdk001 AND prdwsite = prdksite ",
 
 
                              " LEFT JOIN prdwl_t ON prdw001 = prdwl001 AND prdwsite = prdwlsite AND prdwl002 = '",g_lang,"' ",
                              " ",
                       " ",
                       " WHERE prdwent = '" ||g_enterprise|| "' AND prdw098 = '2'  AND ",g_wc," AND ",g_wc2, cl_sql_add_filter("prdw_t")
   ELSE
      #單身無輸入資料
      LET l_sql_rank = "SELECT DISTINCT prdwstus,prdwunit,'',prdwsite,'',prdw001,prdw002,prdw006,'', 
          prdw007,'',prdw027,DENSE_RANK() OVER(ORDER BY prdwsite,prdw001 ",g_order,") AS RANK ",
                        " FROM prdw_t ",
                            "  ",
                            "  LEFT JOIN prdwl_t ON prdw001 = prdwl001 AND prdwsite = prdwlsite AND prdwl002 = '",g_lang,"' ",
                       " WHERE prdwent = '" ||g_enterprise|| "' AND prdw098 = '2'  AND ", g_wc, cl_sql_add_filter("prdw_t")
   END IF
   
   #定義翻頁CURSOR
   LET g_sql= "SELECT prdwstus,prdwunit,'',prdwsite,'',prdw001,prdw002,prdw006,'',prdw007,'',prdw027 FROM (", 
       l_sql_rank,") WHERE ",
              " RANK >= ",1," AND RANK<",1+g_max_browse,
              " ORDER BY ",l_searchcol," ",g_order
   #end add-point
               
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
   
   #add-point:browser_fill,open
   
   #end add-point
 
   CALL g_browser.clear()
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_prdwunit,g_browser[g_cnt].b_prdwunit_desc, 
       g_browser[g_cnt].b_prdwsite,g_browser[g_cnt].b_prdwsite_desc,g_browser[g_cnt].b_prdw001,g_browser[g_cnt].b_prdw002, 
       g_browser[g_cnt].b_prdw006,g_browser[g_cnt].b_prdw006_desc,g_browser[g_cnt].b_prdw007,g_browser[g_cnt].b_prdw007_desc, 
       g_browser[g_cnt].b_prdw027
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         EXIT FOREACH
      END IF
  
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_prdwunit
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_lang||"'", 
          "") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_prdwunit_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_prdwunit_desc
 
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_prdwsite
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_lang||"'", 
          "") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_prdwsite_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_prdwsite_desc
 
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_prdw006
      CALL ap_ref_array2(g_ref_fields,"SELECT prcfl003 FROM prcfl_t WHERE prcflent='"||g_enterprise||"' AND prcfl001=? AND prcfl002='"||g_lang||"'", 
          "") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_prdw006_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_prdw006_desc
 
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_prdw007
      CALL ap_ref_array2(g_ref_fields,"SELECT prcdl003 FROM prcdl_t WHERE prcdlent='"||g_enterprise||"' AND prcdl001=? AND prcdl002='"||g_lang||"'", 
          "") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_prdw007_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_prdw007_desc
 
  
      #add-point:browser_fill段reference
      
      #end add-point
  
            #此段落由子樣板a24產生
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/open.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/void.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/valid.png"
         
      END CASE
 
 
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9035
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
   END FOREACH
 
   CALL g_browser.deleteElement(g_cnt)
   LET g_header_cnt = g_browser.getLength()
 
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   FREE browse_pre
   
   #add-point:browser_fill段結束前
   
   #end add-point
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
   ELSE
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   END IF
   
END FUNCTION
 
{</section>}
 
{<section id="aprq551.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aprq551_ui_headershow()
   #add-point:ui_headershow段define
   
   #end add-point    
   
   LET g_prdw_m.prdwsite = g_browser[g_current_idx].b_prdwsite   
   LET g_prdw_m.prdw001 = g_browser[g_current_idx].b_prdw001   
 
   EXECUTE aprq551_master_referesh USING g_prdw_m.prdwsite,g_prdw_m.prdw001 INTO g_prdw_m.prdwunit,g_prdw_m.prdwsite, 
       g_prdw_m.prdw099,g_prdw_m.prdw001,g_prdw_m.prdw002,g_prdw_m.prdw100,g_prdw_m.prdw006,g_prdw_m.prdw007, 
       g_prdw_m.prdw027,g_prdw_m.prdwstus,g_prdw_m.prdw004,g_prdw_m.prdw005,g_prdw_m.prdw003,g_prdw_m.prdw012, 
       g_prdw_m.prdw010,g_prdw_m.prdw013,g_prdw_m.prdw011,g_prdw_m.prdw014,g_prdw_m.prdw098,g_prdw_m.prdw017, 
       g_prdw_m.prdw020,g_prdw_m.prdw021,g_prdw_m.prdw008,g_prdw_m.prdw009,g_prdw_m.prdw022,g_prdw_m.prdw026, 
       g_prdw_m.prdw023,g_prdw_m.prdw025,g_prdw_m.prdw028,g_prdw_m.prdw029,g_prdw_m.prdw030,g_prdw_m.prdw031, 
       g_prdw_m.prdwcrtid,g_prdw_m.prdwcrtdp,g_prdw_m.prdwcrtdt,g_prdw_m.prdwownid,g_prdw_m.prdwowndp, 
       g_prdw_m.prdwmodid,g_prdw_m.prdwmoddt,g_prdw_m.prdwcnfid,g_prdw_m.prdwcnfdt,g_prdw_m.prdw018, 
       g_prdw_m.prdw032,g_prdw_m.prdw019
   CALL aprq551_show()
   
END FUNCTION
 
{</section>}
 
{<section id="aprq551.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aprq551_ui_detailshow()
   #add-point:ui_detailshow段define
   
   #end add-point    
   
   #add-point:ui_detailshow段before
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aprq551.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aprq551_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define
   
   #end add-point    
   
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_prdwsite = g_prdw_m.prdwsite 
         AND g_browser[l_i].b_prdw001 = g_prdw_m.prdw001 
 
         THEN  
         CALL g_browser.deleteElement(l_i)
         LET g_header_cnt = g_header_cnt - 1
      END IF
   END FOR
 
   LET g_browser_cnt = g_browser_cnt - 1
   IF g_current_row > g_browser_cnt THEN        #確定browse 筆數指在同一筆
      LET g_current_row = g_browser_cnt
   END IF
 
   #DISPLAY g_browser_cnt TO FORMONLY.b_count    #總筆數的顯示
   
END FUNCTION
 
{</section>}
 
{<section id="aprq551.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aprq551_construct()
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define
   CALL g_prdc4_d.clear()
   CALL g_prdc5_d.clear()
   CALL g_prdc6_d.clear()
   #end add-point    
 
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_prdw_m.* TO NULL
   CALL g_prdc_d.clear()        
   CALL g_prdc2_d.clear() 
   CALL g_prdc3_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前

   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON prdwunit,prdwsite,prdw099,prdw001,prdw002,prdwl003,prdw100,prdw006,prdw007, 
          prdw027,prdwstus,prdw004,prdw005,prdw003,prdw012,prdw010,prdw013,prdw011,prdw014,prdw098,prdw017, 
          prdw020,prdw021,prdw008,prdw009,prdw022,prdw026,prdw023,prdw025,prdw028,prdw029,prdw030,prdw031, 
          prdwcrtid,prdwcrtdp,prdwcrtdt,prdwownid,prdwowndp,prdwmodid,prdwmoddt,prdwcnfid,prdwcnfdt, 
          prdw018,prdw032,prdw019
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct

            #end add-point 
            
         #公用欄位開窗相關處理
         #此段落由子樣板a11產生
         ##----<<prdwownid>>----
         #ON ACTION controlp INFIELD prdwownid
         #   CALL q_common('prdw_t','prdwownid',TRUE,FALSE,g_prdw_m.prdwownid) RETURNING ls_return
         #   DISPLAY ls_return TO prdwownid
         #   NEXT FIELD prdwownid  
         #
         ##----<<prdwowndp>>----
         #ON ACTION controlp INFIELD prdwowndp
         #   CALL q_common('prdw_t','prdwowndp',TRUE,FALSE,g_prdw_m.prdwowndp) RETURNING ls_return
         #   DISPLAY ls_return TO prdwowndp
         #   NEXT FIELD prdwowndp
         #
         ##----<<prdwcrtid>>----
         #ON ACTION controlp INFIELD prdwcrtid
         #   CALL q_common('prdw_t','prdwcrtid',TRUE,FALSE,g_prdw_m.prdwcrtid) RETURNING ls_return
         #   DISPLAY ls_return TO prdwcrtid
         #   NEXT FIELD prdwcrtid
         #
         ##----<<prdwcrtdp>>----
         #ON ACTION controlp INFIELD prdwcrtdp
         #   CALL q_common('prdw_t','prdwcrtdp',TRUE,FALSE,g_prdw_m.prdwcrtdp) RETURNING ls_return
         #   DISPLAY ls_return TO prdwcrtdp
         #   NEXT FIELD prdwcrtdp
         #
         ##----<<prdwmodid>>----
         #ON ACTION controlp INFIELD prdwmodid
         #   CALL q_common('prdw_t','prdwmodid',TRUE,FALSE,g_prdw_m.prdwmodid) RETURNING ls_return
         #   DISPLAY ls_return TO prdwmodid
         #   NEXT FIELD prdwmodid
         #
         ##----<<prdwcnfid>>----
         #ON ACTION controlp INFIELD prdwcnfid
         #   CALL q_common('prdw_t','prdwcnfid',TRUE,FALSE,g_prdw_m.prdwcnfid) RETURNING ls_return
         #   DISPLAY ls_return TO prdwcnfid
         #   NEXT FIELD prdwcnfid
         #
         ##----<<prdwpstid>>----
         ##ON ACTION controlp INFIELD prdwpstid
         ##   CALL q_common('prdw_t','prdwpstid',TRUE,FALSE,g_prdw_m.prdwpstid) RETURNING ls_return
         ##   DISPLAY ls_return TO prdwpstid
         ##   NEXT FIELD prdwpstid
         
         ##----<<prdwcrtdt>>----
         AFTER FIELD prdwcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prdwmoddt>>----
         AFTER FIELD prdwmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prdwcnfdt>>----
         AFTER FIELD prdwcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prdwpstdt>>----
         #AFTER FIELD prdwpstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
            
         #一般欄位開窗相關處理    
         #---------------------------<  Master  >---------------------------
         #----<<prdwunit>>----
         #Ctrlp:construct.c.prdwunit
         ON ACTION controlp INFIELD prdwunit
            #add-point:ON ACTION controlp INFIELD prdwunit
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdwunit  #顯示到畫面上
            NEXT FIELD prdwunit                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdwunit
            #add-point:BEFORE FIELD prdwunit

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdwunit
            
            #add-point:AFTER FIELD prdwunit

            #END add-point
            
 
         #----<<prdwunit_desc>>----
         #----<<prdwsite>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdwsite
            #add-point:BEFORE FIELD prdwsite

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdwsite
            
            #add-point:AFTER FIELD prdwsite

            #END add-point
            
 
         #Ctrlp:construct.c.prdwsite
         ON ACTION controlp INFIELD prdwsite
            #add-point:ON ACTION controlp INFIELD prdwsite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdwsite  #顯示到畫面上
            NEXT FIELD prdwsite                     #返回原欄位
            #END add-point
 
         #----<<prdwsite_desc>>----
         #----<<prdw099>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw099
            #add-point:BEFORE FIELD prdw099

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw099
            
            #add-point:AFTER FIELD prdw099

            #END add-point
            
 
         #Ctrlp:construct.c.prdw099
         ON ACTION controlp INFIELD prdw099
            #add-point:ON ACTION controlp INFIELD prdw099

            #END add-point
 
         #----<<pos>>----
         #----<<prdw001>>----
         #Ctrlp:construct.c.prdw001
         ON ACTION controlp INFIELD prdw001
            #add-point:ON ACTION controlp INFIELD prdw001
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '31'
            LET g_qryparam.arg2 = '2'
            CALL q_prdw001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdw001  #顯示到畫面上
            NEXT FIELD prdw001                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdw001
            #add-point:BEFORE FIELD prdw001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw001
            
            #add-point:AFTER FIELD prdw001

            #END add-point
            
 
         #----<<prdw002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw002
            #add-point:BEFORE FIELD prdw002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw002
            
            #add-point:AFTER FIELD prdw002

            #END add-point
            
 
         #Ctrlp:construct.c.prdw002
         ON ACTION controlp INFIELD prdw002
            #add-point:ON ACTION controlp INFIELD prdw002

            #END add-point
 
         #----<<prdwl003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdwl003
            #add-point:BEFORE FIELD prdwl003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdwl003
            
            #add-point:AFTER FIELD prdwl003

            #END add-point
            
 
         #Ctrlp:construct.c.prdwl003
         ON ACTION controlp INFIELD prdwl003
            #add-point:ON ACTION controlp INFIELD prdwl003

            #END add-point
 
         #----<<prdw100>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw100
            #add-point:BEFORE FIELD prdw100

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw100
            
            #add-point:AFTER FIELD prdw100
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
            #END add-point
            
 
         #Ctrlp:construct.c.prdw100
         ON ACTION controlp INFIELD prdw100
            #add-point:ON ACTION controlp INFIELD prdw100

            #END add-point
 
         #----<<prdw006>>----
         #Ctrlp:construct.c.prdw006
         ON ACTION controlp INFIELD prdw006
            #add-point:ON ACTION controlp INFIELD prdw006
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2'
            CALL q_prcf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdw006  #顯示到畫面上
            NEXT FIELD prdw006                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdw006
            #add-point:BEFORE FIELD prdw006

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw006
            
            #add-point:AFTER FIELD prdw006

            #END add-point
            
 
         #----<<prdw006_desc>>----
         #----<<prdw007>>----
         #Ctrlp:construct.c.prdw007
         ON ACTION controlp INFIELD prdw007
            #add-point:ON ACTION controlp INFIELD prdw007
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2'
            CALL q_prcd001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdw007  #顯示到畫面上
            NEXT FIELD prdw007                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdw007
            #add-point:BEFORE FIELD prdw007

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw007
            
            #add-point:AFTER FIELD prdw007

            #END add-point
            
 
         #----<<prdw007_desc>>----
         #----<<prdw027>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw027
            #add-point:BEFORE FIELD prdw027

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw027
            
            #add-point:AFTER FIELD prdw027

            #END add-point
            
 
         #Ctrlp:construct.c.prdw027
         ON ACTION controlp INFIELD prdw027
            #add-point:ON ACTION controlp INFIELD prdw027

            #END add-point
 
         #----<<prdwstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdwstus
            #add-point:BEFORE FIELD prdwstus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdwstus
            
            #add-point:AFTER FIELD prdwstus

            #END add-point
            
 
         #Ctrlp:construct.c.prdwstus
         ON ACTION controlp INFIELD prdwstus
            #add-point:ON ACTION controlp INFIELD prdwstus

            #END add-point
 
         #----<<prdw004>>----
         #Ctrlp:construct.c.prdw004
         ON ACTION controlp INFIELD prdw004
            #add-point:ON ACTION controlp INFIELD prdw004
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdw004  #顯示到畫面上
            NEXT FIELD prdw004                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdw004
            #add-point:BEFORE FIELD prdw004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw004
            
            #add-point:AFTER FIELD prdw004

            #END add-point
            
 
         #----<<prdw004_desc>>----
         #----<<prdw005>>----
         #Ctrlp:construct.c.prdw005
         ON ACTION controlp INFIELD prdw005
            #add-point:ON ACTION controlp INFIELD prdw005
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdw005  #顯示到畫面上
            NEXT FIELD prdw005                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdw005
            #add-point:BEFORE FIELD prdw005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw005
            
            #add-point:AFTER FIELD prdw005

            #END add-point
            
 
         #----<<prdw005_desc>>----
         #----<<prdw003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw003
            #add-point:BEFORE FIELD prdw003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw003
            
            #add-point:AFTER FIELD prdw003

            #END add-point
            
 
         #Ctrlp:construct.c.prdw003
         ON ACTION controlp INFIELD prdw003
            #add-point:ON ACTION controlp INFIELD prdw003

            #END add-point
 
         #----<<prdw012>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw012
            #add-point:BEFORE FIELD prdw012

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw012
            
            #add-point:AFTER FIELD prdw012

            #END add-point
            
 
         #Ctrlp:construct.c.prdw012
         ON ACTION controlp INFIELD prdw012
            #add-point:ON ACTION controlp INFIELD prdw012

            #END add-point
 
         #----<<prdw010>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw010
            #add-point:BEFORE FIELD prdw010

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw010
            
            #add-point:AFTER FIELD prdw010

            #END add-point
            
 
         #Ctrlp:construct.c.prdw010
         ON ACTION controlp INFIELD prdw010
            #add-point:ON ACTION controlp INFIELD prdw010

            #END add-point
 
         #----<<prdw013>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw013
            #add-point:BEFORE FIELD prdw013

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw013
            
            #add-point:AFTER FIELD prdw013

            #END add-point
            
 
         #Ctrlp:construct.c.prdw013
         ON ACTION controlp INFIELD prdw013
            #add-point:ON ACTION controlp INFIELD prdw013

            #END add-point
 
         #----<<prdw011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw011
            #add-point:BEFORE FIELD prdw011

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw011
            
            #add-point:AFTER FIELD prdw011

            #END add-point
            
 
         #Ctrlp:construct.c.prdw011
         ON ACTION controlp INFIELD prdw011
            #add-point:ON ACTION controlp INFIELD prdw011

            #END add-point
 
         #----<<prdw014>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw014
            #add-point:BEFORE FIELD prdw014

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw014
            
            #add-point:AFTER FIELD prdw014

            #END add-point
            
 
         #Ctrlp:construct.c.prdw014
         ON ACTION controlp INFIELD prdw014
            #add-point:ON ACTION controlp INFIELD prdw014

            #END add-point
 
         #----<<prdd003>>----
         #----<<prdd004>>----
         #----<<prdw098>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw098
            #add-point:BEFORE FIELD prdw098

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw098
            
            #add-point:AFTER FIELD prdw098

            #END add-point
            
 
         #Ctrlp:construct.c.prdw098
         ON ACTION controlp INFIELD prdw098
            #add-point:ON ACTION controlp INFIELD prdw098

            #END add-point
 
         #----<<prdw017>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw017
            #add-point:BEFORE FIELD prdw017

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw017
            
            #add-point:AFTER FIELD prdw017

            #END add-point
            
 
         #Ctrlp:construct.c.prdw017
         ON ACTION controlp INFIELD prdw017
            #add-point:ON ACTION controlp INFIELD prdw017

            #END add-point
 
         #----<<prdw020>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw020
            #add-point:BEFORE FIELD prdw020

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw020
            
            #add-point:AFTER FIELD prdw020

            #END add-point
            
 
         #Ctrlp:construct.c.prdw020
         ON ACTION controlp INFIELD prdw020
            #add-point:ON ACTION controlp INFIELD prdw020

            #END add-point
 
         #----<<prdw021>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw021
            #add-point:BEFORE FIELD prdw021

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw021
            
            #add-point:AFTER FIELD prdw021

            #END add-point
            
 
         #Ctrlp:construct.c.prdw021
         ON ACTION controlp INFIELD prdw021
            #add-point:ON ACTION controlp INFIELD prdw021

            #END add-point
 
         #----<<prdw008>>----
         #Ctrlp:construct.c.prdw008
         ON ACTION controlp INFIELD prdw008
            #add-point:ON ACTION controlp INFIELD prdw008
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2100'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdw008  #顯示到畫面上
            NEXT FIELD prdw008                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdw008
            #add-point:BEFORE FIELD prdw008

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw008
            
            #add-point:AFTER FIELD prdw008

            #END add-point
            
 
         #----<<prdw008_desc>>----
         #----<<prdw009>>----
         #Ctrlp:construct.c.prdw009
         ON ACTION controlp INFIELD prdw009
            #add-point:ON ACTION controlp INFIELD prdw009
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2101'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdw009  #顯示到畫面上
            NEXT FIELD prdw009                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdw009
            #add-point:BEFORE FIELD prdw009

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw009
            
            #add-point:AFTER FIELD prdw009

            #END add-point
            
 
         #----<<prdw009_desc>>----
         #----<<prdw022>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw022
            #add-point:BEFORE FIELD prdw022

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw022
            
            #add-point:AFTER FIELD prdw022

            #END add-point
            
 
         #Ctrlp:construct.c.prdw022
         ON ACTION controlp INFIELD prdw022
            #add-point:ON ACTION controlp INFIELD prdw022

            #END add-point
 
         #----<<prdw026>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw026
            #add-point:BEFORE FIELD prdw026

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw026
            
            #add-point:AFTER FIELD prdw026

            #END add-point
            
 
         #Ctrlp:construct.c.prdw026
         ON ACTION controlp INFIELD prdw026
            #add-point:ON ACTION controlp INFIELD prdw026

            #END add-point
 
         #----<<prdw023>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw023
            #add-point:BEFORE FIELD prdw023

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw023
            
            #add-point:AFTER FIELD prdw023

            #END add-point
            
 
         #Ctrlp:construct.c.prdw023
         ON ACTION controlp INFIELD prdw023
            #add-point:ON ACTION controlp INFIELD prdw023

            #END add-point
 
         #----<<prdw025>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw025
            #add-point:BEFORE FIELD prdw025

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw025
            
            #add-point:AFTER FIELD prdw025

            #END add-point
            
 
         #Ctrlp:construct.c.prdw025
         ON ACTION controlp INFIELD prdw025
            #add-point:ON ACTION controlp INFIELD prdw025

            #END add-point
 
         #----<<prdw028>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw028
            #add-point:BEFORE FIELD prdw028

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw028
            
            #add-point:AFTER FIELD prdw028

            #END add-point
            
 
         #Ctrlp:construct.c.prdw028
         ON ACTION controlp INFIELD prdw028
            #add-point:ON ACTION controlp INFIELD prdw028

            #END add-point
 
         #----<<prdw029>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw029
            #add-point:BEFORE FIELD prdw029

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw029
            
            #add-point:AFTER FIELD prdw029

            #END add-point
            
 
         #Ctrlp:construct.c.prdw029
         ON ACTION controlp INFIELD prdw029
            #add-point:ON ACTION controlp INFIELD prdw029

            #END add-point
 
         #----<<prdw030>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw030
            #add-point:BEFORE FIELD prdw030

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw030
            
            #add-point:AFTER FIELD prdw030

            #END add-point
            
 
         #Ctrlp:construct.c.prdw030
         ON ACTION controlp INFIELD prdw030
            #add-point:ON ACTION controlp INFIELD prdw030

            #END add-point
 
         #----<<prdw031>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw031
            #add-point:BEFORE FIELD prdw031

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw031
            
            #add-point:AFTER FIELD prdw031

            #END add-point
            
 
         #Ctrlp:construct.c.prdw031
         ON ACTION controlp INFIELD prdw031
            #add-point:ON ACTION controlp INFIELD prdw031

            #END add-point
 
         #----<<prdwcrtid>>----
         #Ctrlp:construct.c.prdwcrtid
         ON ACTION controlp INFIELD prdwcrtid
            #add-point:ON ACTION controlp INFIELD prdwcrtid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdwcrtid  #顯示到畫面上
            NEXT FIELD prdwcrtid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdwcrtid
            #add-point:BEFORE FIELD prdwcrtid

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdwcrtid
            
            #add-point:AFTER FIELD prdwcrtid

            #END add-point
            
 
         #----<<prdwcrtid_desc>>----
         #----<<prdwcrtdp>>----
         #Ctrlp:construct.c.prdwcrtdp
         ON ACTION controlp INFIELD prdwcrtdp
            #add-point:ON ACTION controlp INFIELD prdwcrtdp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdwcrtdp  #顯示到畫面上
            NEXT FIELD prdwcrtdp                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdwcrtdp
            #add-point:BEFORE FIELD prdwcrtdp

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdwcrtdp
            
            #add-point:AFTER FIELD prdwcrtdp

            #END add-point
            
 
         #----<<prdwcrtdp_desc>>----
         #----<<prdwcrtdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdwcrtdt
            #add-point:BEFORE FIELD prdwcrtdt

            #END add-point
 
         #----<<prdwownid>>----
         #Ctrlp:construct.c.prdwownid
         ON ACTION controlp INFIELD prdwownid
            #add-point:ON ACTION controlp INFIELD prdwownid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdwownid  #顯示到畫面上
            NEXT FIELD prdwownid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdwownid
            #add-point:BEFORE FIELD prdwownid

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdwownid
            
            #add-point:AFTER FIELD prdwownid

            #END add-point
            
 
         #----<<prdwownid_desc>>----
         #----<<prdwowndp>>----
         #Ctrlp:construct.c.prdwowndp
         ON ACTION controlp INFIELD prdwowndp
            #add-point:ON ACTION controlp INFIELD prdwowndp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdwowndp  #顯示到畫面上
            NEXT FIELD prdwowndp                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdwowndp
            #add-point:BEFORE FIELD prdwowndp

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdwowndp
            
            #add-point:AFTER FIELD prdwowndp

            #END add-point
            
 
         #----<<prdwowndp_desc>>----
         #----<<prdwmodid>>----
         #Ctrlp:construct.c.prdwmodid
         ON ACTION controlp INFIELD prdwmodid
            #add-point:ON ACTION controlp INFIELD prdwmodid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdwmodid  #顯示到畫面上
            NEXT FIELD prdwmodid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdwmodid
            #add-point:BEFORE FIELD prdwmodid

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdwmodid
            
            #add-point:AFTER FIELD prdwmodid

            #END add-point
            
 
         #----<<prdwmodid_desc>>----
         #----<<prdwmoddt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdwmoddt
            #add-point:BEFORE FIELD prdwmoddt

            #END add-point
 
         #----<<prdwcnfid>>----
         #Ctrlp:construct.c.prdwcnfid
         ON ACTION controlp INFIELD prdwcnfid
            #add-point:ON ACTION controlp INFIELD prdwcnfid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdwcnfid  #顯示到畫面上
            NEXT FIELD prdwcnfid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdwcnfid
            #add-point:BEFORE FIELD prdwcnfid

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdwcnfid
            
            #add-point:AFTER FIELD prdwcnfid

            #END add-point
            
 
         #----<<prdwcnfid_desc>>----
         #----<<prdwcnfdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdwcnfdt
            #add-point:BEFORE FIELD prdwcnfdt

            #END add-point
 
         #----<<prdw018>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw018
            #add-point:BEFORE FIELD prdw018

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw018
            
            #add-point:AFTER FIELD prdw018

            #END add-point
            
 
         #Ctrlp:construct.c.prdw018
         ON ACTION controlp INFIELD prdw018
            #add-point:ON ACTION controlp INFIELD prdw018

            #END add-point
 
         #----<<prdw032>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw032
            #add-point:BEFORE FIELD prdw032

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw032
            
            #add-point:AFTER FIELD prdw032

            #END add-point
            
 
         #Ctrlp:construct.c.prdw032
         ON ACTION controlp INFIELD prdw032
            #add-point:ON ACTION controlp INFIELD prdw032

            #END add-point
 
         #----<<prdw019>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw019
            #add-point:BEFORE FIELD prdw019

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw019
            
            #add-point:AFTER FIELD prdw019

            #END add-point
            
 
         #Ctrlp:construct.c.prdw019
         ON ACTION controlp INFIELD prdw019
            #add-point:ON ACTION controlp INFIELD prdw019

            #END add-point
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON prdcacti,prdc002,prdc003,prdc004,prdc001,prdcsite,prdcunit
           FROM s_detail1[1].prdcacti,s_detail1[1].prdc002,s_detail1[1].prdc003,s_detail1[1].prdc004, 
               s_detail1[1].prdc001,s_detail1[1].prdcsite,s_detail1[1].prdcunit
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
       #---------------------<  Detail: page1  >---------------------
         #----<<prdcacti>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdcacti
            #add-point:BEFORE FIELD prdcacti

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdcacti
            
            #add-point:AFTER FIELD prdcacti

            #END add-point
            
 
         #Ctrlp:construct.c.page1.prdcacti
         ON ACTION controlp INFIELD prdcacti
            #add-point:ON ACTION controlp INFIELD prdcacti

            #END add-point
 
         #----<<prdc002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdc002
            #add-point:BEFORE FIELD prdc002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdc002
            
            #add-point:AFTER FIELD prdc002

            #END add-point
            
 
         #Ctrlp:construct.c.page1.prdc002
         ON ACTION controlp INFIELD prdc002
            #add-point:ON ACTION controlp INFIELD prdc002

            #END add-point
 
         #----<<prdc003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdc003
            #add-point:BEFORE FIELD prdc003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdc003
            
            #add-point:AFTER FIELD prdc003

            #END add-point
            
 
         #Ctrlp:construct.c.page1.prdc003
         ON ACTION controlp INFIELD prdc003
            #add-point:ON ACTION controlp INFIELD prdc003

            #END add-point
 
         #----<<prdc004>>----
         #Ctrlp:construct.c.page1.prdc004
         ON ACTION controlp INFIELD prdc004
            #add-point:ON ACTION controlp INFIELD prdc004
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2'
            LET g_qryparam.arg2 = '31'
            CALL q_prdc004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdc004  #顯示到畫面上
            NEXT FIELD prdc004                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdc004
            #add-point:BEFORE FIELD prdc004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdc004
            
            #add-point:AFTER FIELD prdc004

            #END add-point
            
 
         #----<<prdc004_desc>>----
         #----<<prdc001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdc001
            #add-point:BEFORE FIELD prdc001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdc001
            
            #add-point:AFTER FIELD prdc001

            #END add-point
            
 
         #Ctrlp:construct.c.page1.prdc001
         ON ACTION controlp INFIELD prdc001
            #add-point:ON ACTION controlp INFIELD prdc001

            #END add-point
 
         #----<<prdcsite>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdcsite
            #add-point:BEFORE FIELD prdcsite

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdcsite
            
            #add-point:AFTER FIELD prdcsite

            #END add-point
            
 
         #Ctrlp:construct.c.page1.prdcsite
         ON ACTION controlp INFIELD prdcsite
            #add-point:ON ACTION controlp INFIELD prdcsite

            #END add-point
 
         #----<<prdcunit>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdcunit
            #add-point:BEFORE FIELD prdcunit

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdcunit
            
            #add-point:AFTER FIELD prdcunit

            #END add-point
            
 
         #Ctrlp:construct.c.page1.prdcunit
         ON ACTION controlp INFIELD prdcunit
            #add-point:ON ACTION controlp INFIELD prdcunit

            #END add-point
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON prdhacti,prdh002,prdh000,prdh003,prdh005,prdh008,prdh009,prdh010, 
          prdh011,prdh012,prdh013,prdh004,prdh006,prdh007,prdh001,prdhsite,prdhunit
           FROM s_detail2[1].prdhacti,s_detail2[1].prdh002,s_detail2[1].prdh000,s_detail2[1].prdh003, 
               s_detail2[1].prdh005,s_detail2[1].prdh008,s_detail2[1].prdh009,s_detail2[1].prdh010, 
               s_detail2[1].prdh011,s_detail2[1].prdh012,s_detail2[1].prdh013,s_detail2[1].prdh004,s_detail2[1].prdh006, 
               s_detail2[1].prdh007,s_detail2[1].prdh001,s_detail2[1].prdhsite,s_detail2[1].prdhunit 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
       #---------------------<  Detail: page2  >---------------------
         #----<<prdhacti>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdhacti
            #add-point:BEFORE FIELD prdhacti

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdhacti
            
            #add-point:AFTER FIELD prdhacti

            #END add-point
            
 
         #Ctrlp:construct.c.page2.prdhacti
         ON ACTION controlp INFIELD prdhacti
            #add-point:ON ACTION controlp INFIELD prdhacti

            #END add-point
 
         #----<<prdh002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdh002
            #add-point:BEFORE FIELD prdh002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdh002
            
            #add-point:AFTER FIELD prdh002

            #END add-point
            
 
         #Ctrlp:construct.c.page2.prdh002
         ON ACTION controlp INFIELD prdh002
            #add-point:ON ACTION controlp INFIELD prdh002

            #END add-point
 
         #----<<prdh000>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdh000
            #add-point:BEFORE FIELD prdh000

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdh000
            
            #add-point:AFTER FIELD prdh000

            #END add-point
            
 
         #Ctrlp:construct.c.page2.prdh000
         ON ACTION controlp INFIELD prdh000
            #add-point:ON ACTION controlp INFIELD prdh000

            #END add-point
 
         #----<<prdh003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdh003
            #add-point:BEFORE FIELD prdh003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdh003
            
            #add-point:AFTER FIELD prdh003

            #END add-point
            
 
         #Ctrlp:construct.c.page2.prdh003
         ON ACTION controlp INFIELD prdh003
            #add-point:ON ACTION controlp INFIELD prdh003

            #END add-point
 
         #----<<prdh005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdh005
            #add-point:BEFORE FIELD prdh005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdh005
            
            #add-point:AFTER FIELD prdh005

            #END add-point
            
 
         #Ctrlp:construct.c.page2.prdh005
         ON ACTION controlp INFIELD prdh005
            #add-point:ON ACTION controlp INFIELD prdh005

            #END add-point
 
         #----<<prdh008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdh008
            #add-point:BEFORE FIELD prdh008

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdh008
            
            #add-point:AFTER FIELD prdh008

            #END add-point
            
 
         #Ctrlp:construct.c.page2.prdh008
         ON ACTION controlp INFIELD prdh008
            #add-point:ON ACTION controlp INFIELD prdh008

            #END add-point
 
         #----<<prdh009>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdh009
            #add-point:BEFORE FIELD prdh009

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdh009
            
            #add-point:AFTER FIELD prdh009

            #END add-point
            
 
         #Ctrlp:construct.c.page2.prdh009
         ON ACTION controlp INFIELD prdh009
            #add-point:ON ACTION controlp INFIELD prdh009

            #END add-point
 
         #----<<prdb005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdb005
            #add-point:BEFORE FIELD prdb005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdb005
            
            #add-point:AFTER FIELD prdb005

            #END add-point
            
 
         #Ctrlp:construct.c.page2.prdb005
         ON ACTION controlp INFIELD prdb005
            #add-point:ON ACTION controlp INFIELD prdb005

            #END add-point
 
         #----<<prdh010>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdh010
            #add-point:BEFORE FIELD prdh010

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdh010
            
            #add-point:AFTER FIELD prdh010

            #END add-point
            
 
         #Ctrlp:construct.c.page2.prdh010
         ON ACTION controlp INFIELD prdh010
            #add-point:ON ACTION controlp INFIELD prdh010

            #END add-point
 
         #----<<prdh011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdh011
            #add-point:BEFORE FIELD prdh011

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdh011
            
            #add-point:AFTER FIELD prdh011

            #END add-point
            
 
         #Ctrlp:construct.c.page2.prdh011
         ON ACTION controlp INFIELD prdh011
            #add-point:ON ACTION controlp INFIELD prdh011

            #END add-point
 
         #----<<prdh012>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdh012
            #add-point:BEFORE FIELD prdh012

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdh012
            
            #add-point:AFTER FIELD prdh012

            #END add-point
            
 
         #Ctrlp:construct.c.page2.prdh012
         ON ACTION controlp INFIELD prdh012
            #add-point:ON ACTION controlp INFIELD prdh012

            #END add-point
 
         #----<<prdh013>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdh013
            #add-point:BEFORE FIELD prdh013

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdh013
            
            #add-point:AFTER FIELD prdh013

            #END add-point
            
 
         #Ctrlp:construct.c.page2.prdh013
         ON ACTION controlp INFIELD prdh013
            #add-point:ON ACTION controlp INFIELD prdh013

            #END add-point
 
         #----<<prdh004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdh004
            #add-point:BEFORE FIELD prdh004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdh004
            
            #add-point:AFTER FIELD prdh004

            #END add-point
            
 
         #Ctrlp:construct.c.page2.prdh004
         ON ACTION controlp INFIELD prdh004
            #add-point:ON ACTION controlp INFIELD prdh004

            #END add-point
 
         #----<<prdh006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdh006
            #add-point:BEFORE FIELD prdh006

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdh006
            
            #add-point:AFTER FIELD prdh006

            #END add-point
            
 
         #Ctrlp:construct.c.page2.prdh006
         ON ACTION controlp INFIELD prdh006
            #add-point:ON ACTION controlp INFIELD prdh006

            #END add-point
 
         #----<<prdh007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdh007
            #add-point:BEFORE FIELD prdh007

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdh007
            
            #add-point:AFTER FIELD prdh007

            #END add-point
            
 
         #Ctrlp:construct.c.page2.prdh007
         ON ACTION controlp INFIELD prdh007
            #add-point:ON ACTION controlp INFIELD prdh007

            #END add-point
 
         #----<<prdh001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdh001
            #add-point:BEFORE FIELD prdh001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdh001
            
            #add-point:AFTER FIELD prdh001

            #END add-point
            
 
         #Ctrlp:construct.c.page2.prdh001
         ON ACTION controlp INFIELD prdh001
            #add-point:ON ACTION controlp INFIELD prdh001

            #END add-point
 
         #----<<prdhsite>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdhsite
            #add-point:BEFORE FIELD prdhsite

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdhsite
            
            #add-point:AFTER FIELD prdhsite

            #END add-point
            
 
         #Ctrlp:construct.c.page2.prdhsite
         ON ACTION controlp INFIELD prdhsite
            #add-point:ON ACTION controlp INFIELD prdhsite

            #END add-point
 
         #----<<prdhunit>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdhunit
            #add-point:BEFORE FIELD prdhunit

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdhunit
            
            #add-point:AFTER FIELD prdhunit

            #END add-point
            
 
         #Ctrlp:construct.c.page2.prdhunit
         ON ACTION controlp INFIELD prdhunit
            #add-point:ON ACTION controlp INFIELD prdhunit

            #END add-point
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON prdgacti,prdg010,prdg002,prdg003,prdg004,prdg006,prdg007,prdg008,prdg009, 
          prdg001,prdgsite,prdgunit,prdg005
           FROM s_detail3[1].prdgacti,s_detail3[1].prdg010,s_detail3[1].prdg002,s_detail3[1].prdg003, 
               s_detail3[1].prdg004,s_detail3[1].prdg006,s_detail3[1].prdg007,s_detail3[1].prdg008,s_detail3[1].prdg009, 
               s_detail3[1].prdg001,s_detail3[1].prdgsite,s_detail3[1].prdgunit,s_detail3[1].prdg005 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
       #---------------------<  Detail: page3  >---------------------
         #----<<prdgacti>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdgacti
            #add-point:BEFORE FIELD prdgacti

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdgacti
            
            #add-point:AFTER FIELD prdgacti

            #END add-point
            
 
         #Ctrlp:construct.c.page3.prdgacti
         ON ACTION controlp INFIELD prdgacti
            #add-point:ON ACTION controlp INFIELD prdgacti

            #END add-point
 
         #----<<prdg010>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdg010
            #add-point:BEFORE FIELD prdg010

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdg010
            
            #add-point:AFTER FIELD prdg010

            #END add-point
            
 
         #Ctrlp:construct.c.page3.prdg010
         ON ACTION controlp INFIELD prdg010
            #add-point:ON ACTION controlp INFIELD prdg010

            #END add-point
 
         #----<<prdg002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdg002
            #add-point:BEFORE FIELD prdg002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdg002
            
            #add-point:AFTER FIELD prdg002

            #END add-point
            
 
         #Ctrlp:construct.c.page3.prdg002
         ON ACTION controlp INFIELD prdg002
            #add-point:ON ACTION controlp INFIELD prdg002

            #END add-point
 
         #----<<prdg003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdg003
            #add-point:BEFORE FIELD prdg003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdg003
            
            #add-point:AFTER FIELD prdg003

            #END add-point
            
 
         #Ctrlp:construct.c.page3.prdg003
         ON ACTION controlp INFIELD prdg003
            #add-point:ON ACTION controlp INFIELD prdg003

            #END add-point
 
         #----<<prdg004>>----
         #Ctrlp:construct.c.page3.prdg004
         ON ACTION controlp INFIELD prdg004
            #add-point:ON ACTION controlp INFIELD prdg004
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2'
            LET g_qryparam.arg2 = '31'
            CALL q_prdg004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdg004  #顯示到畫面上
            NEXT FIELD prdg004                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdg004
            #add-point:BEFORE FIELD prdg004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdg004
            
            #add-point:AFTER FIELD prdg004

            #END add-point
            
 
         #----<<prdg004_desc>>----
         #----<<prdg006>>----
         #Ctrlp:construct.c.page3.prdg006
         ON ACTION controlp INFIELD prdg006
            #add-point:ON ACTION controlp INFIELD prdg006
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdg006  #顯示到畫面上
            NEXT FIELD prdg006                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdg006
            #add-point:BEFORE FIELD prdg006

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdg006
            
            #add-point:AFTER FIELD prdg006

            #END add-point
            
 
         #----<<prdg006_desc>>----
         #----<<prdg007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdg007
            #add-point:BEFORE FIELD prdg007

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdg007
            
            #add-point:AFTER FIELD prdg007

            #END add-point
            
 
         #Ctrlp:construct.c.page3.prdg007
         ON ACTION controlp INFIELD prdg007
            #add-point:ON ACTION controlp INFIELD prdg007

            #END add-point
 
         #----<<prdg008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdg008
            #add-point:BEFORE FIELD prdg008

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdg008
            
            #add-point:AFTER FIELD prdg008

            #END add-point
            
 
         #Ctrlp:construct.c.page3.prdg008
         ON ACTION controlp INFIELD prdg008
            #add-point:ON ACTION controlp INFIELD prdg008

            #END add-point
 
         #----<<prdg009>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdg009
            #add-point:BEFORE FIELD prdg009

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdg009
            
            #add-point:AFTER FIELD prdg009

            #END add-point
            
 
         #Ctrlp:construct.c.page3.prdg009
         ON ACTION controlp INFIELD prdg009
            #add-point:ON ACTION controlp INFIELD prdg009

            #END add-point
 
         #----<<prdg001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdg001
            #add-point:BEFORE FIELD prdg001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdg001
            
            #add-point:AFTER FIELD prdg001

            #END add-point
            
 
         #Ctrlp:construct.c.page3.prdg001
         ON ACTION controlp INFIELD prdg001
            #add-point:ON ACTION controlp INFIELD prdg001

            #END add-point
 
         #----<<prdgsite>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdgsite
            #add-point:BEFORE FIELD prdgsite

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdgsite
            
            #add-point:AFTER FIELD prdgsite

            #END add-point
            
 
         #Ctrlp:construct.c.page3.prdgsite
         ON ACTION controlp INFIELD prdgsite
            #add-point:ON ACTION controlp INFIELD prdgsite

            #END add-point
 
         #----<<prdgunit>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdgunit
            #add-point:BEFORE FIELD prdgunit

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdgunit
            
            #add-point:AFTER FIELD prdgunit

            #END add-point
            
 
         #Ctrlp:construct.c.page3.prdgunit
         ON ACTION controlp INFIELD prdgunit
            #add-point:ON ACTION controlp INFIELD prdgunit

            #END add-point
 
         #----<<prdg005>>----
         #Ctrlp:construct.c.page3.prdg005
         ON ACTION controlp INFIELD prdg005
            #add-point:ON ACTION controlp INFIELD prdg005
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdg005  #顯示到畫面上
            NEXT FIELD prdg005                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdg005
            #add-point:BEFORE FIELD prdg005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdg005
            
            #add-point:AFTER FIELD prdg005

            #END add-point
            
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令)
      CONSTRUCT g_wc2_table4 ON prdkacti,prdj003,prdk003,prdk005,prdk007,prdk008,prdj005
           FROM s_detail4[1].prdkacti,s_detail4[1].prdj003,s_detail4[1].prdk003,s_detail4[1].prdk005, 
               s_detail4[1].prdk007,s_detail4[1].prdk008,s_detail4[1].prdj005 

                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       
         #此段落由子樣板a02產生
         AFTER FIELD prdk005
            
            #add-point:AFTER FIELD prdk005

            #END add-point
            
 
         #Ctrlp:construct.c.page3.prdk005
         ON ACTION controlp INFIELD prdk005
            #add-point:ON ACTION controlp INFIELD prdk005
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	         LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_imaa001()
            DISPLAY g_qryparam.return1 TO prdk005  #顯示到畫面上
            NEXT FIELD prdk005
            #END add-point
 
         #----<<prdk002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdk007
            #add-point:BEFORE FIELD prdk007

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdk007
            
            #add-point:AFTER FIELD prdk007

            #END add-point
            
 
         #Ctrlp:construct.c.page3.prdk007
         ON ACTION controlp INFIELD prdk007
            #add-point:ON ACTION controlp INFIELD prdk007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdk007  #顯示到畫面上
            NEXT FIELD prdk007                     #返回原欄位
            #END add-point
                       
       
      END CONSTRUCT
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog

         #end add-point  
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
   END DIALOG
   
   #組合g_wc2
   LET g_wc2 = g_wc2_table1
   IF g_wc2_table2 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
   END IF
 
   IF g_wc2_table3 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
   END IF
 
 
 
 
   
   #add-point:cs段結束前
   IF g_wc2_table4 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
   END IF
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aprq551.filter" >}
#+ 此段落由子樣板a50產生
#+ filter過濾功能
PRIVATE FUNCTION aprq551_filter()
   #add-point:filter段define
   
   #end add-point   
 
   #切換畫面
   IF NOT g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF   
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter.trim()
   LET g_wc_t = g_wc
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter_t, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON prdwunit,prdwsite,prdw001,prdw002,prdw006,prdw007,prdw027
                          FROM s_browse[1].b_prdwunit,s_browse[1].b_prdwsite,s_browse[1].b_prdw001,s_browse[1].b_prdw002, 
                              s_browse[1].b_prdw006,s_browse[1].b_prdw007,s_browse[1].b_prdw027
 
         BEFORE CONSTRUCT
               DISPLAY aprq551_filter_parser('prdwunit') TO s_browse[1].b_prdwunit
            DISPLAY aprq551_filter_parser('prdwsite') TO s_browse[1].b_prdwsite
            DISPLAY aprq551_filter_parser('prdw001') TO s_browse[1].b_prdw001
            DISPLAY aprq551_filter_parser('prdw002') TO s_browse[1].b_prdw002
            DISPLAY aprq551_filter_parser('prdw006') TO s_browse[1].b_prdw006
            DISPLAY aprq551_filter_parser('prdw007') TO s_browse[1].b_prdw007
            DISPLAY aprq551_filter_parser('prdw027') TO s_browse[1].b_prdw027
      
         #add-point:filter段cs_ctrl
         
         #end add-point
      
      END CONSTRUCT
 
      #add-point:filter段add_cs
      
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog
         
         #end add-point  
      
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
   
   END DIALOG
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = "   AND   ", g_wc_filter, "   "
      LET g_wc = g_wc , g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
      LET g_wc = g_wc_t
   END IF
 
      CALL aprq551_filter_show('prdwunit')
   CALL aprq551_filter_show('prdwsite')
   CALL aprq551_filter_show('prdw001')
   CALL aprq551_filter_show('prdw002')
   CALL aprq551_filter_show('prdw006')
   CALL aprq551_filter_show('prdw007')
   CALL aprq551_filter_show('prdw027')
 
END FUNCTION
 
{</section>}
 
{<section id="aprq551.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aprq551_filter_parser(ps_field)
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   #add-point:filter段define
   
   #end add-point    
 
   #一般條件解析
   LET ls_tmp = ps_field, "='"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
   END IF
 
   #模糊條件解析
   LET ls_tmp = ps_field, " like '"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
      LET ls_var = cl_replace_str(ls_var,'%','*')
   END IF
 
   RETURN ls_var
 
END FUNCTION
 
{</section>}
 
{<section id="aprq551.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aprq551_filter_show(ps_field)
   DEFINE ps_field         STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.b_", ps_field
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = aprq551_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aprq551.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aprq551_query()
   DEFINE ls_wc STRING
   #add-point:query段define
   
   #end add-point   
 
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF   
   
   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_prdc_d.clear()
   CALL g_prdc2_d.clear()
   CALL g_prdc3_d.clear()
 
   
   #add-point:query段other
   CALL g_prdc4_d.clear()
   CALL g_prdc5_d.clear()
   CALL g_prdc6_d.clear()
   #end add-point   
   
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL aprq551_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL aprq551_browser_fill("")
      CALL aprq551_fetch("")
      RETURN
   END IF
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||") AND ("||g_wc2||")")
   
   #搜尋後資料初始化
   LET g_detail_cnt  = 0
   LET g_current_idx = 1
   LET g_current_row = 0
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL aprq551_filter_show('prdwunit')
   CALL aprq551_filter_show('prdwsite')
   CALL aprq551_filter_show('prdw001')
   CALL aprq551_filter_show('prdw002')
   CALL aprq551_filter_show('prdw006')
   CALL aprq551_filter_show('prdw007')
   CALL aprq551_filter_show('prdw027')
   CALL aprq551_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "-100"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
   ELSE
      CALL aprq551_fetch("F") 
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aprq551.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aprq551_fetch(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define
   
   #end add-point    
   
   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
   
   CASE p_flag
      WHEN 'F' LET g_current_idx = 1
      WHEN 'L' LET g_current_idx = g_header_cnt        
      WHEN 'P'
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN 'N'
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN '/'
         IF (NOT g_no_ask) THEN    
            CALL cl_set_act_visible("accept,cancel", TRUE)    
            CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,':' FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl" 
            END PROMPT
 
            CALL cl_set_act_visible("accept,cancel", FALSE)    
            IF INT_FLAG THEN
                LET INT_FLAG = 0
                EXIT CASE  
            END IF           
         END IF
         
         IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
             LET g_current_idx = g_jump
         END IF
         
         LET g_no_ask = FALSE  
   END CASE 
   
   
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
   
   LET g_detail_cnt = g_header_cnt                  
   
   #單身總筆數顯示
   #LET g_detail_idx = 1
   IF g_detail_cnt > 0 THEN
      #LET g_detail_idx = 1
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY ' ' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_current_idx, g_browser_cnt )
   
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_prdw_m.prdwsite = g_browser[g_current_idx].b_prdwsite
   LET g_prdw_m.prdw001 = g_browser[g_current_idx].b_prdw001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aprq551_master_referesh USING g_prdw_m.prdwsite,g_prdw_m.prdw001 INTO g_prdw_m.prdwunit,g_prdw_m.prdwsite, 
       g_prdw_m.prdw099,g_prdw_m.prdw001,g_prdw_m.prdw002,g_prdw_m.prdw100,g_prdw_m.prdw006,g_prdw_m.prdw007, 
       g_prdw_m.prdw027,g_prdw_m.prdwstus,g_prdw_m.prdw004,g_prdw_m.prdw005,g_prdw_m.prdw003,g_prdw_m.prdw012, 
       g_prdw_m.prdw010,g_prdw_m.prdw013,g_prdw_m.prdw011,g_prdw_m.prdw014,g_prdw_m.prdw098,g_prdw_m.prdw017, 
       g_prdw_m.prdw020,g_prdw_m.prdw021,g_prdw_m.prdw008,g_prdw_m.prdw009,g_prdw_m.prdw022,g_prdw_m.prdw026, 
       g_prdw_m.prdw023,g_prdw_m.prdw025,g_prdw_m.prdw028,g_prdw_m.prdw029,g_prdw_m.prdw030,g_prdw_m.prdw031, 
       g_prdw_m.prdwcrtid,g_prdw_m.prdwcrtdp,g_prdw_m.prdwcrtdt,g_prdw_m.prdwownid,g_prdw_m.prdwowndp, 
       g_prdw_m.prdwmodid,g_prdw_m.prdwmoddt,g_prdw_m.prdwcnfid,g_prdw_m.prdwcnfdt,g_prdw_m.prdw018, 
       g_prdw_m.prdw032,g_prdw_m.prdw019
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "prdw_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      INITIALIZE g_prdw_m.* TO NULL
      RETURN
   END IF
   
   #add-point:fetch段action控制
   
   IF g_prdw_m.prdw019='1' THEN
      CALL cl_set_comp_visible("s_detail4",true)
      CALL cl_set_comp_visible("s_detail5,s_detail6",false)
   END IF
   IF g_prdw_m.prdw019='2' THEN
      CALL cl_set_comp_visible("s_detail5,s_detail6",true)
      CALL cl_set_comp_visible("s_detail4",false)
   END IF
   IF g_prdw_m.prdwstus<>'N' THEN
      CALL cl_set_act_visible("modify,delete", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,delete", TRUE)
   END IF
   #end add-point  
   
   
   
   #add-point:fetch結束前
   
   #end add-point
   
   #LET g_data_owner =       
   #LET g_data_group =   
  
   #重新顯示   
   CALL aprq551_show()
 
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aprq551.insert" >}
#+ 資料新增
PRIVATE FUNCTION aprq551_insert()
   #add-point:insert段define
   CALL g_prdc4_d.clear()
   CALL g_prdc5_d.clear()
   CALL g_prdc6_d.clear()
   #end add-point    
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_prdc_d.clear()   
   CALL g_prdc2_d.clear()  
   CALL g_prdc3_d.clear()  
 
 
   INITIALIZE g_prdw_m.* LIKE prdw_t.*             #DEFAULT 設定
   
   LET g_prdwsite_t = NULL
   LET g_prdw001_t = NULL
 
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #此段落由子樣板a14產生    
      LET g_prdw_m.prdwownid = g_user
      LET g_prdw_m.prdwowndp = g_dept
      LET g_prdw_m.prdwcrtid = g_user
      LET g_prdw_m.prdwcrtdp = g_dept 
      LET g_prdw_m.prdwcrtdt = cl_get_current()
      LET g_prdw_m.prdwmodid = ""
      LET g_prdw_m.prdwmoddt = ""
      LET g_prdw_m.prdwstus = "N"
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_prdw_m.prdwstus = "N"
      LET g_prdw_m.prdw012 = "N"
      LET g_prdw_m.prdw010 = "N"
      LET g_prdw_m.prdw013 = "N"
      LET g_prdw_m.prdw011 = "N"
      LET g_prdw_m.prdw017 = "1"
      LET g_prdw_m.prdw021 = "0"
      LET g_prdw_m.prdw022 = "0"
      LET g_prdw_m.prdw026 = "3"
      LET g_prdw_m.prdw023 = "0"
      LET g_prdw_m.prdw025 = "1"
      LET g_prdw_m.prdw028 = "1"
      LET g_prdw_m.prdw018 = "1"
      LET g_prdw_m.prdw032 = "1"
      LET g_prdw_m.prdw019 = "1"
 
  
      #add-point:單頭預設值
      LET g_prdw_m.prdw003 = "31"
      LET g_prdw_m.prdw014 = 0
      LET g_prdw_m.prdw017 = "2"
      LET g_prdw_m.prdw020 = "N"
      LET g_prdw_m.prdw026 = "4"
      INITIALIZE g_prdw_m_o.* TO NULL
      LET g_prdw_m.prdwunit = g_site
      LET g_prdw_m.prdwsite = g_site
      LET g_prdw_m.prdw004 = g_user
      LET g_prdw_m.prdw005 = g_dept
      LET g_prdw_m.prdw002 = 1
      LET g_prdw_m.prdw098 = '2'
      CALL aprq551_desc()
      LET g_prdw_m_t.*= g_prdw_m.*
      #end add-point 
     
      CALL aprq551_input("a")
      
      #add-point:單頭輸入後
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_prdw_m.* = g_prdw_m_t.*
         CALL aprq551_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         EXIT WHILE
      END IF
      
      CALL g_prdc_d.clear()
      CALL g_prdc2_d.clear()
      CALL g_prdc3_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   LET g_state = "Y"
   LET g_current_idx = 1    
 
   LET g_prdwsite_t = g_prdw_m.prdwsite
   LET g_prdw001_t = g_prdw_m.prdw001
 
   
   LET g_wc = g_wc,  
              " OR ( prdwent = '" ||g_enterprise|| "' AND",
              " prdwsite = '", g_prdw_m.prdwsite CLIPPED, "' "
              ," AND prdw001 = '", g_prdw_m.prdw001 CLIPPED, "' "
 
              , ") "
   
   CLOSE aprq551_cl
   
END FUNCTION
 
{</section>}
 
{<section id="aprq551.modify" >}
#+ 資料修改
PRIVATE FUNCTION aprq551_modify()
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   #add-point:modify段define
   IF g_prdw_m.prdwstus NOT MATCHES "[NDR]" THEN
      RETURN
   END IF
   IF g_prdw_m.prdwstus MATCHES "[DR]" THEN
      LET g_prdw_m.prdwstus='N'
   END IF
   #end add-point    
   
   IF g_prdw_m.prdwsite IS NULL
   OR g_prdw_m.prdw001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      RETURN
   END IF
   
   EXECUTE aprq551_master_referesh USING g_prdw_m.prdwsite,g_prdw_m.prdw001 INTO g_prdw_m.prdwunit,g_prdw_m.prdwsite, 
       g_prdw_m.prdw099,g_prdw_m.prdw001,g_prdw_m.prdw002,g_prdw_m.prdw100,g_prdw_m.prdw006,g_prdw_m.prdw007, 
       g_prdw_m.prdw027,g_prdw_m.prdwstus,g_prdw_m.prdw004,g_prdw_m.prdw005,g_prdw_m.prdw003,g_prdw_m.prdw012, 
       g_prdw_m.prdw010,g_prdw_m.prdw013,g_prdw_m.prdw011,g_prdw_m.prdw014,g_prdw_m.prdw098,g_prdw_m.prdw017, 
       g_prdw_m.prdw020,g_prdw_m.prdw021,g_prdw_m.prdw008,g_prdw_m.prdw009,g_prdw_m.prdw022,g_prdw_m.prdw026, 
       g_prdw_m.prdw023,g_prdw_m.prdw025,g_prdw_m.prdw028,g_prdw_m.prdw029,g_prdw_m.prdw030,g_prdw_m.prdw031, 
       g_prdw_m.prdwcrtid,g_prdw_m.prdwcrtdp,g_prdw_m.prdwcrtdt,g_prdw_m.prdwownid,g_prdw_m.prdwowndp, 
       g_prdw_m.prdwmodid,g_prdw_m.prdwmoddt,g_prdw_m.prdwcnfid,g_prdw_m.prdwcnfdt,g_prdw_m.prdw018, 
       g_prdw_m.prdw032,g_prdw_m.prdw019
 
   ERROR ""
  
   LET g_prdwsite_t = g_prdw_m.prdwsite
   LET g_prdw001_t = g_prdw_m.prdw001
 
   CALL s_transaction_begin()
   
   OPEN aprq551_cl USING g_enterprise,g_prdw_m.prdwsite
                                                       ,g_prdw_m.prdw001
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN aprq551_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      CLOSE aprq551_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH aprq551_cl INTO g_prdw_m.prdwunit,g_prdw_m.prdwunit_desc,g_prdw_m.prdwsite,g_prdw_m.prdwsite_desc, 
       g_prdw_m.prdw099,g_prdw_m.pos,g_prdw_m.prdw001,g_prdw_m.prdw002,g_prdw_m.prdwl003,g_prdw_m.prdw100, 
       g_prdw_m.prdw006,g_prdw_m.prdw006_desc,g_prdw_m.prdw007,g_prdw_m.prdw007_desc,g_prdw_m.prdw027, 
       g_prdw_m.prdwstus,g_prdw_m.prdw004,g_prdw_m.prdw004_desc,g_prdw_m.prdw005,g_prdw_m.prdw005_desc, 
       g_prdw_m.prdw003,g_prdw_m.prdw012,g_prdw_m.prdw010,g_prdw_m.prdw013,g_prdw_m.prdw011,g_prdw_m.prdw014, 
       g_prdw_m.prdd003,g_prdw_m.prdd004,g_prdw_m.prdw098,g_prdw_m.prdw017,g_prdw_m.prdw020,g_prdw_m.prdw021, 
       g_prdw_m.prdw008,g_prdw_m.prdw008_desc,g_prdw_m.prdw009,g_prdw_m.prdw009_desc,g_prdw_m.prdw022, 
       g_prdw_m.prdw026,g_prdw_m.prdw023,g_prdw_m.prdw025,g_prdw_m.prdw028,g_prdw_m.prdw029,g_prdw_m.prdw030, 
       g_prdw_m.prdw031,g_prdw_m.prdwcrtid,g_prdw_m.prdwcrtid_desc,g_prdw_m.prdwcrtdp,g_prdw_m.prdwcrtdp_desc, 
       g_prdw_m.prdwcrtdt,g_prdw_m.prdwownid,g_prdw_m.prdwownid_desc,g_prdw_m.prdwowndp,g_prdw_m.prdwowndp_desc, 
       g_prdw_m.prdwmodid,g_prdw_m.prdwmodid_desc,g_prdw_m.prdwmoddt,g_prdw_m.prdwcnfid,g_prdw_m.prdwcnfid_desc, 
       g_prdw_m.prdwcnfdt,g_prdw_m.prdw018,g_prdw_m.prdw032,g_prdw_m.prdw019
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_prdw_m.prdwsite
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      CLOSE aprq551_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   
   
   #add-point:modify段show之前

   #end add-point  
   
   CALL aprq551_show()
   WHILE TRUE
      LET g_prdwsite_t = g_prdw_m.prdwsite
      LET g_prdw001_t = g_prdw_m.prdw001
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_prdw_m.prdwmodid = g_user 
LET g_prdw_m.prdwmoddt = cl_get_current()
 
      
      #add-point:modify段修改前

      #end add-point
      
      CALL aprq551_input("u")     #欄位更改
 
      #add-point:modify段修改後

      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_prdw_m.* = g_prdw_m_t.*
         CALL aprq551_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         EXIT WHILE
      END IF
     
      #若有modid跟moddt則進行update
      UPDATE prdw_t SET (prdwmodid,prdwmoddt) = (g_prdw_m.prdwmodid,g_prdw_m.prdwmoddt)
       WHERE prdwent = g_enterprise AND prdwsite = g_prdwsite_t
         AND prdw001 = g_prdw001_t
 
 
      #若單頭key欄位有變更
      IF g_prdw_m.prdwsite != g_prdwsite_t 
      OR g_prdw_m.prdw001 != g_prdw001_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前

         #end add-point
         
         #更新單身key值
         UPDATE prdc_t SET  prdcsite= g_prdw_m.prdwsite
                                      , prdc001= g_prdw_m.prdw001
 
          WHERE prdcent = g_enterprise AND  prdcsite= g_prdwsite_t
            AND  prdc001= g_prdw001_t
 
            
         #add-point:單身fk修改中

         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "prdc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "prdc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後

         #end add-point
         
         #更新單身key值
         #add-point:單身fk修改前

         #end add-point
         UPDATE prdh_t
            SET  prdhsite= g_prdw_m.prdwsite
               , prdh001= g_prdw_m.prdw001
 
          WHERE prdhent = g_enterprise AND
                 prdhsite= g_prdwsite_t
            AND  prdh001= g_prdw001_t
 
         #add-point:單身fk修改中

         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "prdh_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "prdh_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後

         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前

         #end add-point
         UPDATE prdg_t
            SET  prdgsite= g_prdw_m.prdwsite
               , prdg001= g_prdw_m.prdw001
 
          WHERE prdgent = g_enterprise AND
                 prdgsite= g_prdwsite_t
            AND  prdw001= g_prdw001_t
 
         #add-point:單身fk修改中

         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "prdg_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "prdg_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後

         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #修改歷程記錄
   IF NOT cl_log_modified_record(g_prdw_m.prdwsite,g_site) THEN 
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aprq551_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-U
   CALL cl_flow_notify(g_prdw_m.prdwsite,'U')
 
END FUNCTION   
 
{</section>}
 
{<section id="aprq551.input" >}
#+ 資料輸入
PRIVATE FUNCTION aprq551_input(p_cmd)
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num5                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num5                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num5
   DEFINE  l_i                   LIKE type_t.num5
   DEFINE  l_insert              BOOLEAN
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num5
   DEFINE  li_reproduce_target   LIKE type_t.num5
   #add-point:input段define
   DEFINE  l_n1                  LIKE type_t.num5 
   DEFINE  l_prdw001             LIKE prdw_t.prdw001
   DEFINE  l_prdw002             LIKE prdw_t.prdw002
   DEFINE  l_cnt1                LIKE type_t.num5
   DEFINE  l_cnt2                LIKE type_t.num5
   #end add-point  
 
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql
   
   #end add-point 
   LET g_forupd_sql = "SELECT prdcacti,prdc002,prdc003,prdc004,'',prdc001,prdcsite,prdcunit FROM prdc_t  
       WHERE prdcent=? AND prdcdocno=? AND prdc002=? AND prdc003=? AND prdc004=? FOR UPDATE"
   #add-point:input段define_sql
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aprq551_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql
   
   #end add-point    
   LET g_forupd_sql = "SELECT prdhacti,prdh002,prdh000,prdh003,prdh005,prdh008,prdh009,'',prdh010,prdh011, 
       prdh012,prdh013,prdh004,prdh006,prdh007,prdh001,prdhsite,prdhunit FROM prdh_t WHERE prdhent=?  
       AND prdhdocno=? AND prdh002=? FOR UPDATE"
   #add-point:input段define_sql
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aprq551_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql
   
   #end add-point    
   LET g_forupd_sql = "SELECT prdgacti,prdg010,prdg002,prdg003,prdg004,'',prdg006,'',prdg007,prdg008, 
       prdg009,prdg001,prdgsite,prdgunit,prdg005 FROM prdg_t WHERE prdgent=? AND prdgdocno=? AND prdg002=?  
       AND prdg003=? AND prdg004=? FOR UPDATE"
   #add-point:input段define_sql
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aprq551_bcl3 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql
   LET g_forupd_sql = "SELECT prdkacti,prdj003,prdk003,prdk005,'',prdk007,'',prdk008,prdj005,prdj002
       FROM prdk_t ,prdj_t WHERE prdkent=prdjent AND prdkdocno=prdjdocno AND prdj002=prdk002 AND prdj004=0 AND prdkent=? AND prdkdocno=? AND prdk002=?  
       AND prdk003=? AND prdk005=? AND prdj003=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aprq551_bcl4 CURSOR FROM g_forupd_sql
   
   SELECT ooef004 INTO g_ooef004 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
   LET g_errshow=1
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aprq551_set_entry(p_cmd)
   #add-point:set_entry後
   
   #end add-point
   CALL aprq551_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_prdw_m.prdwunit,g_prdw_m.prdwsite,g_prdw_m.prdw099,g_prdw_m.prdw001,g_prdw_m.prdw002, 
       g_prdw_m.prdwl003,g_prdw_m.prdw100,g_prdw_m.prdw006,g_prdw_m.prdw007,g_prdw_m.prdw027,g_prdw_m.prdwstus, 
       g_prdw_m.prdw004,g_prdw_m.prdw005,g_prdw_m.prdw003,g_prdw_m.prdw012,g_prdw_m.prdw010,g_prdw_m.prdw013, 
       g_prdw_m.prdw011,g_prdw_m.prdw014,g_prdw_m.prdd003,g_prdw_m.prdd004,g_prdw_m.prdw098,g_prdw_m.prdw017, 
       g_prdw_m.prdw020,g_prdw_m.prdw021,g_prdw_m.prdw008,g_prdw_m.prdw009,g_prdw_m.prdw022,g_prdw_m.prdw026, 
       g_prdw_m.prdw023,g_prdw_m.prdw025,g_prdw_m.prdw028,g_prdw_m.prdw029,g_prdw_m.prdw030,g_prdw_m.prdw031, 
       g_prdw_m.prdw018,g_prdw_m.prdw032,g_prdw_m.prdw019
   
   LET lb_reproduce = FALSE
   
   #add-point:資料輸入前
   LET g_prdw_m_o.* = g_prdw_m.*
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
 
{</section>}
 
{<section id="aprq551.input.head" >}
      #單頭段
      INPUT BY NAME g_prdw_m.prdwunit,g_prdw_m.prdwsite,g_prdw_m.prdw099,g_prdw_m.prdw001,g_prdw_m.prdw002, 
          g_prdw_m.prdwl003,g_prdw_m.prdw100,g_prdw_m.prdw006,g_prdw_m.prdw007,g_prdw_m.prdw027,g_prdw_m.prdwstus, 
          g_prdw_m.prdw004,g_prdw_m.prdw005,g_prdw_m.prdw003,g_prdw_m.prdw012,g_prdw_m.prdw010,g_prdw_m.prdw013, 
          g_prdw_m.prdw011,g_prdw_m.prdw014,g_prdw_m.prdd003,g_prdw_m.prdd004,g_prdw_m.prdw098,g_prdw_m.prdw017, 
          g_prdw_m.prdw020,g_prdw_m.prdw021,g_prdw_m.prdw008,g_prdw_m.prdw009,g_prdw_m.prdw022,g_prdw_m.prdw026, 
          g_prdw_m.prdw023,g_prdw_m.prdw025,g_prdw_m.prdw028,g_prdw_m.prdw029,g_prdw_m.prdw030,g_prdw_m.prdw031, 
          g_prdw_m.prdw018,g_prdw_m.prdw032,g_prdw_m.prdw019 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #+ 此段落由子樣板a43產生
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item
               
               #END add-point
            END IF
 
 
     
         BEFORE INPUT
            LET g_master_multi_table_t.prdwl001 = g_prdw_m.prdw001
LET g_master_multi_table_t.prdwl003 = g_prdw_m.prdwl003
 
            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.prdwl001 = ''
LET g_master_multi_table_t.prdwl003 = ''
 
            END IF
            #add-point:資料輸入前
            CALL aprq551_set_entry(p_cmd)

            CALL aprq551_set_no_entry(p_cmd) 
            #end add-point
 
         #---------------------------<  Master  >---------------------------
         #----<<prdwunit>>----
         #此段落由子樣板a02產生
         AFTER FIELD prdwunit
            
            #add-point:AFTER FIELD prdwunit
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prdw_m.prdwunit
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prdw_m.prdwunit_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prdw_m.prdwunit_desc


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdwunit
            #add-point:BEFORE FIELD prdwunit

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE prdwunit
            #add-point:ON CHANGE prdwunit

            #END add-point
 
         #----<<prdwunit_desc>>----
         #----<<prdwsite>>----
         #此段落由子樣板a02產生
         AFTER FIELD prdwsite
            
            #add-point:AFTER FIELD prdwsite
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_prdw_m.prdwsite) AND NOT cl_null(g_prdw_m.prdw001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prdw_m.prdwsite != g_prdwsite_t  OR g_prdw_m.prdw001 != g_prdw001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prdw_t WHERE "||"prdwent = '" ||g_enterprise|| "' AND "||"prdwsite = '"||g_prdw_m.prdwsite ||"' AND "|| "prdw001 = '"||g_prdw_m.prdw001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdwsite
            #add-point:BEFORE FIELD prdwsite

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE prdwsite
            #add-point:ON CHANGE prdwsite

            #END add-point
 
         #----<<prdwsite_desc>>----
         #----<<prdw099>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw099
            #add-point:BEFORE FIELD prdw099

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw099
            
            #add-point:AFTER FIELD prdw099

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdw099
            #add-point:ON CHANGE prdw099

            #END add-point
 
         #----<<pos>>----
         #----<<prdw001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw001
            #add-point:BEFORE FIELD prdw001
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw001
            
            #add-point:AFTER FIELD prdw001
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdw001
            #add-point:ON CHANGE prdw001
 
            #END add-point
 
         #----<<prdw002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw002
            #add-point:BEFORE FIELD prdw002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw002
            
            #add-point:AFTER FIELD prdw002

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdw002
            #add-point:ON CHANGE prdw002

            #END add-point
 
         #----<<prdwl003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdwl003
            #add-point:BEFORE FIELD prdwl003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdwl003
            
            #add-point:AFTER FIELD prdwl003

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdwl003
            #add-point:ON CHANGE prdwl003

            #END add-point
 
         #----<<prdw100>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw100
            #add-point:BEFORE FIELD prdw100

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw100
            
            #add-point:AFTER FIELD prdw100

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdw100
            #add-point:ON CHANGE prdw100

            #END add-point
 
         #----<<prdw006>>----
         #此段落由子樣板a02產生
         AFTER FIELD prdw006
            
            #add-point:AFTER FIELD prdw006
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdw006
            #add-point:BEFORE FIELD prdw006

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE prdw006
            #add-point:ON CHANGE prdw006

            #END add-point
 
         #----<<prdw006_desc>>----
         #----<<prdw007>>----
         #此段落由子樣板a02產生
         AFTER FIELD prdw007
            
            #add-point:AFTER FIELD prdw007
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdw007
            #add-point:BEFORE FIELD prdw007

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE prdw007
            #add-point:ON CHANGE prdw007

            #END add-point
 
         #----<<prdw007_desc>>----
         #----<<prdw027>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw027
            #add-point:BEFORE FIELD prdw027

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw027
            
            #add-point:AFTER FIELD prdw027

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdw027
            #add-point:ON CHANGE prdw027

            #END add-point
 
         #----<<prdwstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdwstus
            #add-point:BEFORE FIELD prdwstus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdwstus
            
            #add-point:AFTER FIELD prdwstus

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdwstus
            #add-point:ON CHANGE prdwstus

            #END add-point
 
         #----<<prdw004>>----
         #此段落由子樣板a02產生
         AFTER FIELD prdw004
            
            #add-point:AFTER FIELD prdw004
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdw004
            #add-point:BEFORE FIELD prdw004

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE prdw004
            #add-point:ON CHANGE prdw004

            #END add-point
 
         #----<<prdw004_desc>>----
         #----<<prdw005>>----
         #此段落由子樣板a02產生
         AFTER FIELD prdw005
            
            #add-point:AFTER FIELD prdw005
            

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdw005
            #add-point:BEFORE FIELD prdw005

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE prdw005
            #add-point:ON CHANGE prdw005

            #END add-point
 
         #----<<prdw005_desc>>----
         #----<<prdw003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw003
            #add-point:BEFORE FIELD prdw003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw003
            
            #add-point:AFTER FIELD prdw003

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdw003
            #add-point:ON CHANGE prdw003

            #END add-point
 
         #----<<prdw012>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw012
            #add-point:BEFORE FIELD prdw012

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw012
            
            #add-point:AFTER FIELD prdw012

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdw012
            #add-point:ON CHANGE prdw012

            #END add-point
 
         #----<<prdw010>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw010
            #add-point:BEFORE FIELD prdw010

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw010
            
            #add-point:AFTER FIELD prdw010

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdw010
            #add-point:ON CHANGE prdw010

            #END add-point
 
         #----<<prdw013>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw013
            #add-point:BEFORE FIELD prdw013

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw013
            
            #add-point:AFTER FIELD prdw013

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdw013
            #add-point:ON CHANGE prdw013

            #END add-point
 
         #----<<prdw011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw011
            #add-point:BEFORE FIELD prdw011

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw011
            
            #add-point:AFTER FIELD prdw011

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdw011
            #add-point:ON CHANGE prdw011

            #END add-point
 
         #----<<prdw014>>----
         #此段落由子樣板a02產生
         AFTER FIELD prdw014
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_prdw_m.prdw014,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD prdw014
            END IF
 
 
            #add-point:AFTER FIELD prdw014
            IF NOT cl_null(g_prdw_m.prdw014) THEN 
            END IF 


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdw014
            #add-point:BEFORE FIELD prdw014

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE prdw014
            #add-point:ON CHANGE prdw014

            #END add-point
 
         #----<<prdd003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdd003
            #add-point:BEFORE FIELD prdd003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdd003
            
            #add-point:AFTER FIELD prdd003
            IF NOT cl_null(g_prdw_m.prdd003) OR NOT cl_null(g_prdw_m.prdd004) THEN
               IF g_prdw_m.prdd003>g_prdw_m.prdd004 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "amm-00080"
                  LET g_errparam.extend = g_prdw_m.prdd003||'>'||g_prdw_m.prdd004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prdw_m.prdd003 = g_prdw_m_t.prdd003
                  NEXT FIELD prdd003
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdd003
            #add-point:ON CHANGE prdd003

            #END add-point
 
         #----<<prdd004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdd004
            #add-point:BEFORE FIELD prdd004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdd004
            
            #add-point:AFTER FIELD prdd004
            IF NOT cl_null(g_prdw_m.prdd003) OR NOT cl_null(g_prdw_m.prdd004) THEN
               IF g_prdw_m.prdd003>g_prdw_m.prdd004 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "amm-00080"
                  LET g_errparam.extend = g_prdw_m.prdd003||'>'||g_prdw_m.prdd004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prdw_m.prdd003 = g_prdw_m_t.prdd003
                  NEXT FIELD prdd003
               END IF
            END IF 
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdd004
            #add-point:ON CHANGE prdd004

            #END add-point
 
         #----<<prdw098>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw098
            #add-point:BEFORE FIELD prdw098

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw098
            
            #add-point:AFTER FIELD prdw098

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdw098
            #add-point:ON CHANGE prdw098

            #END add-point
 
         #----<<prdw017>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw017
            #add-point:BEFORE FIELD prdw017

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw017
            
            #add-point:AFTER FIELD prdw017

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdw017
            #add-point:ON CHANGE prdw017

            #END add-point
 
         #----<<prdw020>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw020
            #add-point:BEFORE FIELD prdw020

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw020
            
            #add-point:AFTER FIELD prdw020

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdw020
            #add-point:ON CHANGE prdw020

            #END add-point
 
         #----<<prdw021>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw021
            #add-point:BEFORE FIELD prdw021

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw021
            
            #add-point:AFTER FIELD prdw021

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdw021
            #add-point:ON CHANGE prdw021

            #END add-point
 
         #----<<prdw008>>----
         #此段落由子樣板a02產生
         AFTER FIELD prdw008
            
            #add-point:AFTER FIELD prdw008
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prdw_m.prdw008
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2100' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prdw_m.prdw008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prdw_m.prdw008_desc


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdw008
            #add-point:BEFORE FIELD prdw008

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE prdw008
            #add-point:ON CHANGE prdw008

            #END add-point
 
         #----<<prdw008_desc>>----
         #----<<prdw009>>----
         #此段落由子樣板a02產生
         AFTER FIELD prdw009
            
            #add-point:AFTER FIELD prdw009
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prdw_m.prdw009
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2101' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prdw_m.prdw009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prdw_m.prdw009_desc


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdw009
            #add-point:BEFORE FIELD prdw009

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE prdw009
            #add-point:ON CHANGE prdw009

            #END add-point
 
         #----<<prdw009_desc>>----
         #----<<prdw022>>----
         #此段落由子樣板a02產生
         AFTER FIELD prdw022
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_prdw_m.prdw022,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD prdw022
            END IF
 
 
            #add-point:AFTER FIELD prdw022
            IF NOT cl_null(g_prdw_m.prdw022) THEN 
            END IF 


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdw022
            #add-point:BEFORE FIELD prdw022

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE prdw022
            #add-point:ON CHANGE prdw022

            #END add-point
 
         #----<<prdw026>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw026
            #add-point:BEFORE FIELD prdw026

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw026
            
            #add-point:AFTER FIELD prdw026

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdw026
            #add-point:ON CHANGE prdw026

            #END add-point
 
         #----<<prdw023>>----
         #此段落由子樣板a02產生
         AFTER FIELD prdw023
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_prdw_m.prdw023,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD prdw023
            END IF
 
 
            #add-point:AFTER FIELD prdw023
            IF NOT cl_null(g_prdw_m.prdw023) THEN 
            END IF 


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdw023
            #add-point:BEFORE FIELD prdw023

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE prdw023
            #add-point:ON CHANGE prdw023

            #END add-point
 
         #----<<prdw025>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw025
            #add-point:BEFORE FIELD prdw025

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw025
            
            #add-point:AFTER FIELD prdw025

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdw025
            #add-point:ON CHANGE prdw025

            #END add-point
 
         #----<<prdw028>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw028
            #add-point:BEFORE FIELD prdw028

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw028
            
            #add-point:AFTER FIELD prdw028
 
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdw028
            #add-point:ON CHANGE prdw028
            
            #END add-point
 
         #----<<prdw029>>----
         #此段落由子樣板a02產生
         AFTER FIELD prdw029
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_prdw_m.prdw029,"0.000000","1","100.000000","1","azz-00087",1) THEN
               NEXT FIELD prdw029
            END IF
 
 
            #add-point:AFTER FIELD prdw029
            IF NOT cl_null(g_prdw_m.prdw029) THEN 
            END IF 


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdw029
            #add-point:BEFORE FIELD prdw029

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE prdw029
            #add-point:ON CHANGE prdw029

            #END add-point
 
         #----<<prdw030>>----
         #此段落由子樣板a02產生
         AFTER FIELD prdw030
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_prdw_m.prdw030,"0.000000","1","100.000000","1","azz-00087",1) THEN
               NEXT FIELD prdw030
            END IF
 
 
            #add-point:AFTER FIELD prdw030
            IF NOT cl_null(g_prdw_m.prdw030) THEN 
            END IF 


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdw030
            #add-point:BEFORE FIELD prdw030

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE prdw030
            #add-point:ON CHANGE prdw030

            #END add-point
 
         #----<<prdw031>>----
         #此段落由子樣板a02產生
         AFTER FIELD prdw031
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_prdw_m.prdw031,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD prdw031
            END IF
 
 
            #add-point:AFTER FIELD prdw031
            IF NOT cl_null(g_prdw_m.prdw031) THEN 
            END IF 


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdw031
            #add-point:BEFORE FIELD prdw031

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE prdw031
            #add-point:ON CHANGE prdw031

            #END add-point
 
         #----<<prdwcrtid>>----
         #----<<prdwcrtid_desc>>----
         #----<<prdwcrtdp>>----
         #----<<prdwcrtdp_desc>>----
         #----<<prdwcrtdt>>----
         #----<<prdwownid>>----
         #----<<prdwownid_desc>>----
         #----<<prdwowndp>>----
         #----<<prdwowndp_desc>>----
         #----<<prdwmodid>>----
         #----<<prdwmodid_desc>>----
         #----<<prdwmoddt>>----
         #----<<prdwcnfid>>----
         #----<<prdwcnfid_desc>>----
         #----<<prdwcnfdt>>----
         #----<<prdw018>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw018
            #add-point:BEFORE FIELD prdw018

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw018
            
            #add-point:AFTER FIELD prdw018

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdw018
            #add-point:ON CHANGE prdw018

            #END add-point
 
         #----<<prdw032>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw032
            #add-point:BEFORE FIELD prdw032

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw032
            
            #add-point:AFTER FIELD prdw032

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdw032
            #add-point:ON CHANGE prdw032

            #END add-point
 
         #----<<prdw019>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw019
            #add-point:BEFORE FIELD prdw019

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw019
            
            #add-point:AFTER FIELD prdw019

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdw019
            #add-point:ON CHANGE prdw019

            #END add-point
 
 #欄位檢查
         #---------------------------<  Master  >---------------------------
         #----<<prdwunit>>----
         #Ctrlp:input.c.prdwunit
         ON ACTION controlp INFIELD prdwunit
            #add-point:ON ACTION controlp INFIELD prdwunit

            #END add-point
 
         #----<<prdwunit_desc>>----
         #----<<prdwsite>>----
         #Ctrlp:input.c.prdwsite
         ON ACTION controlp INFIELD prdwsite
            #add-point:ON ACTION controlp INFIELD prdwsite

            #END add-point
 
         #----<<prdwsite_desc>>----
         #----<<prdw099>>----
         #Ctrlp:input.c.prdw099
         ON ACTION controlp INFIELD prdw099
            #add-point:ON ACTION controlp INFIELD prdw099

            #END add-point
 
         #----<<pos>>----
         #----<<prdw001>>----
         #Ctrlp:input.c.prdw001
         ON ACTION controlp INFIELD prdw001
            #add-point:ON ACTION controlp INFIELD prdw001
            #此段落由子樣板a07產生            
            #開窗i段
            
            

            #END add-point
 
         #----<<prdw002>>----
         #Ctrlp:input.c.prdw002
         ON ACTION controlp INFIELD prdw002
            #add-point:ON ACTION controlp INFIELD prdw002

            #END add-point
 
         #----<<prdwl003>>----
         #Ctrlp:input.c.prdwl003
         ON ACTION controlp INFIELD prdwl003
            #add-point:ON ACTION controlp INFIELD prdwl003

            #END add-point
 
         #----<<prdw100>>----
         #Ctrlp:input.c.prdw100
         ON ACTION controlp INFIELD prdw100
            #add-point:ON ACTION controlp INFIELD prdw100

            #END add-point
 
         #----<<prdw006>>----
         #Ctrlp:input.c.prdw006
         ON ACTION controlp INFIELD prdw006
            #add-point:ON ACTION controlp INFIELD prdw006
            #此段落由子樣板a07產生            
            #開窗i段
            


            #END add-point
 
         #----<<prdw006_desc>>----
         #----<<prdw007>>----
         #Ctrlp:input.c.prdw007
         ON ACTION controlp INFIELD prdw007
            #add-point:ON ACTION controlp INFIELD prdw007
            #此段落由子樣板a07產生            
            #開窗i段
            


            #END add-point
 
         #----<<prdw007_desc>>----
         #----<<prdw027>>----
         #Ctrlp:input.c.prdw027
         ON ACTION controlp INFIELD prdw027
            #add-point:ON ACTION controlp INFIELD prdw027

            #END add-point
 
         #----<<prdwstus>>----
         #Ctrlp:input.c.prdwstus
         ON ACTION controlp INFIELD prdwstus
            #add-point:ON ACTION controlp INFIELD prdwstus

            #END add-point
 
         #----<<prdw004>>----
         #Ctrlp:input.c.prdw004
         ON ACTION controlp INFIELD prdw004
            #add-point:ON ACTION controlp INFIELD prdw004
            #此段落由子樣板a07產生            
            #開窗i段
            

            #END add-point
 
         #----<<prdw004_desc>>----
         #----<<prdw005>>----
         #Ctrlp:input.c.prdw005
         ON ACTION controlp INFIELD prdw005
            #add-point:ON ACTION controlp INFIELD prdw005
            #此段落由子樣板a07產生            
            #開窗i段
            

            #END add-point
 
         #----<<prdw005_desc>>----
         #----<<prdw003>>----
         #Ctrlp:input.c.prdw003
         ON ACTION controlp INFIELD prdw003
            #add-point:ON ACTION controlp INFIELD prdw003

            #END add-point
 
         #----<<prdw012>>----
         #Ctrlp:input.c.prdw012
         ON ACTION controlp INFIELD prdw012
            #add-point:ON ACTION controlp INFIELD prdw012

            #END add-point
 
         #----<<prdw010>>----
         #Ctrlp:input.c.prdw010
         ON ACTION controlp INFIELD prdw010
            #add-point:ON ACTION controlp INFIELD prdw010

            #END add-point
 
         #----<<prdw013>>----
         #Ctrlp:input.c.prdw013
         ON ACTION controlp INFIELD prdw013
            #add-point:ON ACTION controlp INFIELD prdw013

            #END add-point
 
         #----<<prdw011>>----
         #Ctrlp:input.c.prdw011
         ON ACTION controlp INFIELD prdw011
            #add-point:ON ACTION controlp INFIELD prdw011

            #END add-point
 
         #----<<prdw014>>----
         #Ctrlp:input.c.prdw014
         ON ACTION controlp INFIELD prdw014
            #add-point:ON ACTION controlp INFIELD prdw014

            #END add-point
 
         #----<<prdd003>>----
         #Ctrlp:input.c.prdd003
         ON ACTION controlp INFIELD prdd003
            #add-point:ON ACTION controlp INFIELD prdd003

            #END add-point
 
         #----<<prdd004>>----
         #Ctrlp:input.c.prdd004
         ON ACTION controlp INFIELD prdd004
            #add-point:ON ACTION controlp INFIELD prdd004

            #END add-point
 
         #----<<prdw098>>----
         #Ctrlp:input.c.prdw098
         ON ACTION controlp INFIELD prdw098
            #add-point:ON ACTION controlp INFIELD prdw098

            #END add-point
 
         #----<<prdw017>>----
         #Ctrlp:input.c.prdw017
         ON ACTION controlp INFIELD prdw017
            #add-point:ON ACTION controlp INFIELD prdw017

            #END add-point
 
         #----<<prdw020>>----
         #Ctrlp:input.c.prdw020
         ON ACTION controlp INFIELD prdw020
            #add-point:ON ACTION controlp INFIELD prdw020

            #END add-point
 
         #----<<prdw021>>----
         #Ctrlp:input.c.prdw021
         ON ACTION controlp INFIELD prdw021
            #add-point:ON ACTION controlp INFIELD prdw021

            #END add-point
 
         #----<<prdw008>>----
         #Ctrlp:input.c.prdw008
         ON ACTION controlp INFIELD prdw008
            #add-point:ON ACTION controlp INFIELD prdw008

            #END add-point
 
         #----<<prdw008_desc>>----
         #----<<prdw009>>----
         #Ctrlp:input.c.prdw009
         ON ACTION controlp INFIELD prdw009
            #add-point:ON ACTION controlp INFIELD prdw009

            #END add-point
 
         #----<<prdw009_desc>>----
         #----<<prdw022>>----
         #Ctrlp:input.c.prdw022
         ON ACTION controlp INFIELD prdw022
            #add-point:ON ACTION controlp INFIELD prdw022

            #END add-point
 
         #----<<prdw026>>----
         #Ctrlp:input.c.prdw026
         ON ACTION controlp INFIELD prdw026
            #add-point:ON ACTION controlp INFIELD prdw026

            #END add-point
 
         #----<<prdw023>>----
         #Ctrlp:input.c.prdw023
         ON ACTION controlp INFIELD prdw023
            #add-point:ON ACTION controlp INFIELD prdw023

            #END add-point
 
         #----<<prdw025>>----
         #Ctrlp:input.c.prdw025
         ON ACTION controlp INFIELD prdw025
            #add-point:ON ACTION controlp INFIELD prdw025

            #END add-point
 
         #----<<prdw028>>----
         #Ctrlp:input.c.prdw028
         ON ACTION controlp INFIELD prdw028
            #add-point:ON ACTION controlp INFIELD prdw028

            #END add-point
 
         #----<<prdw029>>----
         #Ctrlp:input.c.prdw029
         ON ACTION controlp INFIELD prdw029
            #add-point:ON ACTION controlp INFIELD prdw029

            #END add-point
 
         #----<<prdw030>>----
         #Ctrlp:input.c.prdw030
         ON ACTION controlp INFIELD prdw030
            #add-point:ON ACTION controlp INFIELD prdw030

            #END add-point
 
         #----<<prdw031>>----
         #Ctrlp:input.c.prdw031
         ON ACTION controlp INFIELD prdw031
            #add-point:ON ACTION controlp INFIELD prdw031

            #END add-point
 
         #----<<prdwcrtid>>----
         #----<<prdwcrtid_desc>>----
         #----<<prdwcrtdp>>----
         #----<<prdwcrtdp_desc>>----
         #----<<prdwcrtdt>>----
         #----<<prdwownid>>----
         #----<<prdwownid_desc>>----
         #----<<prdwowndp>>----
         #----<<prdwowndp_desc>>----
         #----<<prdwmodid>>----
         #----<<prdwmodid_desc>>----
         #----<<prdwmoddt>>----
         #----<<prdwcnfid>>----
         #----<<prdwcnfid_desc>>----
         #----<<prdwcnfdt>>----
         #----<<prdw018>>----
         #Ctrlp:input.c.prdw018
         ON ACTION controlp INFIELD prdw018
            #add-point:ON ACTION controlp INFIELD prdw018

            #END add-point
 
         #----<<prdw032>>----
         #Ctrlp:input.c.prdw032
         ON ACTION controlp INFIELD prdw032
            #add-point:ON ACTION controlp INFIELD prdw032

            #END add-point
 
         #----<<prdw019>>----
         #Ctrlp:input.c.prdw019
         ON ACTION controlp INFIELD prdw019
            #add-point:ON ACTION controlp INFIELD prdw019

            #END add-point
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            CALL cl_showmsg()      #錯誤訊息統整顯示
            DISPLAY BY NAME g_prdw_m.prdwsite             
                            ,g_prdw_m.prdw001   
 
 
            #add-point:單頭INPUT後

            #end add-point
                   
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前
               
               #end add-point
               
               INSERT INTO prdw_t (prdwent,prdwunit,prdwsite,prdw099,prdw001,prdw002,prdw100,prdw006, 
                   prdw007,prdw027,prdwstus,prdw004,prdw005,prdw003,prdw012,prdw010,prdw013,prdw011, 
                   prdw014,prdw098,prdw017,prdw020,prdw021,prdw008,prdw009,prdw022,prdw026,prdw023,prdw025, 
                   prdw028,prdw029,prdw030,prdw031,prdwcrtid,prdwcrtdp,prdwcrtdt,prdwownid,prdwowndp, 
                   prdwcnfid,prdwcnfdt,prdw018,prdw032,prdw019)
               VALUES (g_enterprise,g_prdw_m.prdwunit,g_prdw_m.prdwsite,g_prdw_m.prdw099,g_prdw_m.prdw001, 
                   g_prdw_m.prdw002,g_prdw_m.prdw100,g_prdw_m.prdw006,g_prdw_m.prdw007,g_prdw_m.prdw027, 
                   g_prdw_m.prdwstus,g_prdw_m.prdw004,g_prdw_m.prdw005,g_prdw_m.prdw003,g_prdw_m.prdw012, 
                   g_prdw_m.prdw010,g_prdw_m.prdw013,g_prdw_m.prdw011,g_prdw_m.prdw014,g_prdw_m.prdw098, 
                   g_prdw_m.prdw017,g_prdw_m.prdw020,g_prdw_m.prdw021,g_prdw_m.prdw008,g_prdw_m.prdw009, 
                   g_prdw_m.prdw022,g_prdw_m.prdw026,g_prdw_m.prdw023,g_prdw_m.prdw025,g_prdw_m.prdw028, 
                   g_prdw_m.prdw029,g_prdw_m.prdw030,g_prdw_m.prdw031,g_prdw_m.prdwcrtid,g_prdw_m.prdwcrtdp, 
                   g_prdw_m.prdwcrtdt,g_prdw_m.prdwownid,g_prdw_m.prdwowndp,g_prdw_m.prdwcnfid,g_prdw_m.prdwcnfdt, 
                   g_prdw_m.prdw018,g_prdw_m.prdw032,g_prdw_m.prdw019) 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "g_prdw_m"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               
               #add-point:單頭新增中
 
               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_prdw_m.prdw001 = g_master_multi_table_t.prdwl001 AND
         g_prdw_m.prdwl003 = g_master_multi_table_t.prdwl003  THEN
         ELSE 
            LET l_var_keys[01] = g_prdw_m.prdw001
            LET l_field_keys[01] = 'prdwl001'
            LET l_var_keys_bak[01] = g_master_multi_table_t.prdwl001
            LET l_var_keys[02] = g_dlang
            LET l_field_keys[02] = 'prdwl002'
            LET l_var_keys_bak[02] = g_dlang
            LET l_vars[01] = g_prdw_m.prdwl003
            LET l_fields[01] = 'prdwl003'
            LET l_vars[02] = g_site 
            LET l_fields[02] = 'prdwlsite'
            LET l_vars[03] = g_enterprise 
            LET l_fields[03] = 'prdwlent'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'prdwl_t')
         END IF 
 
               
               #add-point:單頭新增後
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aprq551_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前

               #end add-point
               
               UPDATE prdw_t SET (prdwunit,prdwsite,prdw099,prdw001,prdw002,prdw100,prdw006,prdw007, 
                   prdw027,prdwstus,prdw004,prdw005,prdw003,prdw012,prdw010,prdw013,prdw011,prdw014, 
                   prdw098,prdw017,prdw020,prdw021,prdw008,prdw009,prdw022,prdw026,prdw023,prdw025,prdw028, 
                   prdw029,prdw030,prdw031,prdwcrtid,prdwcrtdp,prdwcrtdt,prdwownid,prdwowndp,prdwcnfid, 
                   prdwcnfdt,prdw018,prdw032,prdw019) = (g_prdw_m.prdwunit,g_prdw_m.prdwsite,g_prdw_m.prdw099, 
                   g_prdw_m.prdw001,g_prdw_m.prdw002,g_prdw_m.prdw100,g_prdw_m.prdw006,g_prdw_m.prdw007, 
                   g_prdw_m.prdw027,g_prdw_m.prdwstus,g_prdw_m.prdw004,g_prdw_m.prdw005,g_prdw_m.prdw003, 
                   g_prdw_m.prdw012,g_prdw_m.prdw010,g_prdw_m.prdw013,g_prdw_m.prdw011,g_prdw_m.prdw014, 
                   g_prdw_m.prdw098,g_prdw_m.prdw017,g_prdw_m.prdw020,g_prdw_m.prdw021,g_prdw_m.prdw008, 
                   g_prdw_m.prdw009,g_prdw_m.prdw022,g_prdw_m.prdw026,g_prdw_m.prdw023,g_prdw_m.prdw025, 
                   g_prdw_m.prdw028,g_prdw_m.prdw029,g_prdw_m.prdw030,g_prdw_m.prdw031,g_prdw_m.prdwcrtid, 
                   g_prdw_m.prdwcrtdp,g_prdw_m.prdwcrtdt,g_prdw_m.prdwownid,g_prdw_m.prdwowndp,g_prdw_m.prdwcnfid, 
                   g_prdw_m.prdwcnfdt,g_prdw_m.prdw018,g_prdw_m.prdw032,g_prdw_m.prdw019)
                WHERE prdwent = g_enterprise AND prdwsite = g_prdwsite_t
                  AND prdw001 = g_prdw001_t
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "prdw_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               
               #add-point:單頭修改中
               
               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_prdw_m.prdw001 = g_master_multi_table_t.prdwl001 AND
         g_prdw_m.prdwl003 = g_master_multi_table_t.prdwl003  THEN
         ELSE 
            LET l_var_keys[01] = g_prdw_m.prdw001
            LET l_field_keys[01] = 'prdwl001'
            LET l_var_keys_bak[01] = g_master_multi_table_t.prdwl001
            LET l_var_keys[02] = g_dlang
            LET l_field_keys[02] = 'prdwl002'
            LET l_var_keys_bak[02] = g_dlang
            LET l_vars[01] = g_prdw_m.prdwl003
            LET l_fields[01] = 'prdwl003'
            LET l_vars[02] = g_site 
            LET l_fields[02] = 'prdwlsite'
            LET l_vars[03] = g_enterprise 
            LET l_fields[03] = 'prdwlent'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'prdwl_t')
         END IF 
 
               CALL s_transaction_end('Y','0')
               
               #add-point:單頭修改後
               
               #end add-point
            END IF
            
            LET g_prdwsite_t = g_prdw_m.prdwsite
            LET g_prdw001_t = g_prdw_m.prdw001
 
            #controlp
            
      END INPUT
   
 
{</section>}
 
{<section id="aprq551.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_prdc_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = TRUE, 
                  DELETE ROW = TRUE,
                  APPEND ROW = TRUE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prdc_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aprq551_b_fill()
            LET g_rec_b = g_prdc_d.getLength()
            #add-point:資料輸入前

            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2

            #end add-point              
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aprq551_cl USING g_enterprise,g_prdw_m.prdwsite
                                                                ,g_prdw_m.prdw001
 
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN aprq551_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               CLOSE aprq551_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_prdc_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prdc_d[l_ac].prdc001 IS NOT NULL
               AND g_prdc_d[l_ac].prdc002 IS NOT NULL
               AND g_prdc_d[l_ac].prdc003 IS NOT NULL
               AND g_prdc_d[l_ac].prdc004 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_prdc_d_t.* = g_prdc_d[l_ac].*  #BACKUP
               CALL aprq551_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b

               #end add-point  
               CALL aprq551_set_no_entry_b(l_cmd)
               IF NOT aprq551_lock_b("prdc_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprq551_bcl INTO g_prdc_d[l_ac].prdcacti,g_prdc_d[l_ac].prdc002,g_prdc_d[l_ac].prdc003, 
                      g_prdc_d[l_ac].prdc004,g_prdc_d[l_ac].prdc004_desc,g_prdc_d[l_ac].prdc001,g_prdc_d[l_ac].prdcsite, 
                      g_prdc_d[l_ac].prdcunit
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_prdc_d_t.prdc001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL aprq551_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            IF l_cmd = 'u' THEN
               CALL cl_set_comp_entry("prdc002",false)
            ELSE
               CALL cl_set_comp_entry("prdc002",true)
            END IF
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_prdc_d[l_ac].* TO NULL 
                  LET g_prdc_d[l_ac].prdcacti = "Y"
 
 
            LET g_prdc_d_t.* = g_prdc_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprq551_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b

            #end add-point
            CALL aprq551_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prdc_d[li_reproduce_target].* = g_prdc_d[li_reproduce].*
 
               LET g_prdc_d[li_reproduce_target].prdc001 = NULL
               LET g_prdc_d[li_reproduce_target].prdc002 = NULL
               LET g_prdc_d[li_reproduce_target].prdc003 = NULL
               LET g_prdc_d[li_reproduce_target].prdc004 = NULL
 
            END IF
            #公用欄位給值(單身)
            
            
            #add-point:modify段before insert
 
            #end add-point  
  
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增

            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM prdc_t 
             WHERE prdcent = g_enterprise AND  prdcsite= g_prdw_m.prdwsite
               AND  prdw001= g_prdw_m.prdw001
 
               AND prdcdocno = g_prdc_d[l_ac].prdc001
               AND prdc002 = g_prdc_d[l_ac].prdc002
               AND prdc003 = g_prdc_d[l_ac].prdc003
               AND prdc004 = g_prdc_d[l_ac].prdc004
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdw_m.prdwsite
               LET gs_keys[2] = g_prdw_m.prdw001
               LET gs_keys[3] = g_prdc_d[g_detail_idx].prdc001
               LET gs_keys[4] = g_prdc_d[g_detail_idx].prdc002
               LET gs_keys[5] = g_prdc_d[g_detail_idx].prdc003
               LET gs_keys[6] = g_prdc_d[g_detail_idx].prdc004
               CALL aprq551_insert_b('prdc_t',gs_keys,"'1'")
                           
               #add-point:單身新增後

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               INITIALIZE g_prdc_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "prdc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprq551_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert
 
               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_prdc_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_prdc_d.deleteElement(l_ac)
               NEXT FIELD prdcdocno
            END IF
         
            IF g_prdc_d[l_ac].prdc001 IS NOT NULL
               AND g_prdc_d_t.prdc002 IS NOT NULL
               AND g_prdc_d_t.prdc003 IS NOT NULL
               AND g_prdc_d_t.prdc004 IS NOT NULL
 
               THEN 
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
 
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前
 
               #end add-point 
               
               DELETE FROM prdc_t
                WHERE prdcent = g_enterprise AND  prdcsite= g_prdw_m.prdwsite AND
                                           prdc001= g_prdw_m.prdw001
                  AND prdc002 = g_prdc_d_t.prdc002
                  AND prdc003 = g_prdc_d_t.prdc003
                  AND prdc004 = g_prdc_d_t.prdc004
 
                  
               #add-point:單身刪除中

               #end add-point 
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "prdc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  
                  #add-point:單身刪除後
                                    
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE aprq551_bcl
               LET l_count = g_prdc_d.getLength()
            END IF 
            
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdw_m.prdwsite
               LET gs_keys[2] = g_prdw_m.prdw001
               LET gs_keys[3] = g_prdc_d[g_detail_idx].prdc001
               LET gs_keys[4] = g_prdc_d[g_detail_idx].prdc002
               LET gs_keys[5] = g_prdc_d[g_detail_idx].prdc003
               LET gs_keys[6] = g_prdc_d[g_detail_idx].prdc004
 
              
         AFTER DELETE 
            #add-point:單身刪除後2

            #end add-point
                           CALL aprq551_delete_b('prdc_t',gs_keys,"'1'")
 
         #---------------------<  Detail: page1  >---------------------
         #----<<prdcacti>>----
         #----<<prdc002>>----
         #----<<prdc003>>----
         #----<<prdc004>>----
         #----<<prdc004_desc>>----
         #----<<prdc001>>----
         #----<<prdcsite>>----
         #----<<prdcunit>>----
 
         #---------------------<  Detail: page1  >---------------------
         #----<<prdcacti>>----
         #----<<prdc002>>----
         #----<<prdc003>>----
         #----<<prdc004>>----
         #----<<prdc004_desc>>----
         #----<<prdc001>>----
         #----<<prdcsite>>----
         #----<<prdcunit>>----
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_prdc_d[l_ac].* = g_prdc_d_t.*
               CLOSE aprq551_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_prdc_d[l_ac].prdc001
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               LET g_prdc_d[l_ac].* = g_prdc_d_t.*
            ELSE
            
               #add-point:單身修改前
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               UPDATE prdc_t SET (prdcacti,prdc002,prdc003,prdc004,prdc001,prdcsite,prdcunit) = (g_prdc_d[l_ac].prdcacti,g_prdc_d[l_ac].prdc002,g_prdc_d[l_ac].prdc003, 
                   g_prdc_d[l_ac].prdc004,g_prdc_d[l_ac].prdc001,g_prdc_d[l_ac].prdcsite,g_prdc_d[l_ac].prdcunit) 
 
                WHERE prdcent = g_enterprise AND  prdcsite= g_prdw_m.prdwsite 
                  AND  prdc001= g_prdw_m.prdw001 
 
                  AND prdc001 = g_prdc_d_t.prdc001 #項次   
                  AND prdc002 = g_prdc_d_t.prdc002  
                  AND prdc003 = g_prdc_d_t.prdc003  
                  AND prdc004 = g_prdc_d_t.prdc004  
 
                  
               #add-point:單身修改中

               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "prdc_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                     LET g_prdc_d[l_ac].* = g_prdc_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "prdc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
                     LET g_prdc_d[l_ac].* = g_prdc_d_t.*                     
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdw_m.prdwsite
               LET gs_keys_bak[1] = g_prdwsite_t
               LET gs_keys[2] = g_prdw_m.prdw001
               LET gs_keys_bak[2] = g_prdw001_t
               LET gs_keys[3] = g_prdc_d[g_detail_idx].prdc001
               LET gs_keys_bak[3] = g_prdc_d_t.prdc001
               LET gs_keys[4] = g_prdc_d[g_detail_idx].prdc002
               LET gs_keys_bak[4] = g_prdc_d_t.prdc002
               LET gs_keys[5] = g_prdc_d[g_detail_idx].prdc003
               LET gs_keys_bak[5] = g_prdc_d_t.prdc003
               LET gs_keys[6] = g_prdc_d[g_detail_idx].prdc004
               LET gs_keys_bak[6] = g_prdc_d_t.prdc004
               CALL aprq551_update_b('prdc_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
               END CASE
               
               #add-point:單身修改後

               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row

            #end add-point
            CALL aprq551_unlock_b("prdc_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
            #add-point:單身after_row2

            #end add-point
 
         AFTER INPUT
            #add-point:input段after input 

            #end add-point 
 
         ON ACTION controlo    
            CALL FGL_SET_ARR_CURR(g_prdc_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_prdc_d.getLength()+1
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
      
      DISPLAY ARRAY g_prdc2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL aprq551_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            LET g_detail_idx = l_ac
            
            #add-point:page2, before row動作
            IF l_cmd = 'u' THEN
               CALL cl_set_comp_entry("prdh002",false)
            ELSE
               CALL cl_set_comp_entry("prdh002",true)
            END IF
            #end add-point
            
         BEFORE DISPLAY
            CALL FGL_SET_ARR_CURR(g_detail_idx)
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            CALL aprq551_idx_chk()
            LET g_current_page = 2
      
         #add-point:page2自定義行為

         #end add-point
      
      END DISPLAY
      DISPLAY ARRAY g_prdc3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL aprq551_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail3")
            LET g_detail_idx = l_ac
            
            #add-point:page3, before row動作

            #end add-point
            
         BEFORE DISPLAY
            CALL FGL_SET_ARR_CURR(g_detail_idx)
            LET l_ac = DIALOG.getCurrentRow("s_detail3")
            CALL aprq551_idx_chk()
            LET g_current_page = 3
      
         #add-point:page3自定義行為

         #end add-point
      
      END DISPLAY
 
      
 
      
 
{</section>}
 
{<section id="aprq551.input.other" >}
      
      #add-point:自定義input
#      INPUT ARRAY g_prdc4_d FROM s_detail4.*
#         ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
#                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
#                 DELETE ROW = l_allow_delete,
#                 APPEND ROW = l_allow_insert)
#                 
#         #自訂ACTION(detail_input,page_2)
#         
#         
#         BEFORE INPUT
#            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
#              CALL FGL_SET_ARR_CURR(g_prdc4_d.getLength()+1) 
#              LET g_insert = 'N' 
#           END IF 
# 
#            CALL aprq551_b_fill()
#            LET g_rec_b = g_prdc4_d.getLength()
#            #add-point:資料輸入前
#            #end add-point
#            
#         BEFORE INSERT
#            
#            LET l_insert = TRUE
#            LET l_n = ARR_COUNT()
#            LET l_cmd = 'a'
#            INITIALIZE g_prdc4_d[l_ac].* TO NULL 
#                  LET g_prdc4_d[l_ac].prdkacti = "Y"
# 
# 
#            LET g_prdc4_d_t.* = g_prdc4_d[l_ac].*     #新輸入資料
#            CALL cl_show_fld_cont()
#            CALL aprq551_set_entry_b(l_cmd)
#            #add-point:modify段after_set_entry_b
#
#            #end add-point
#            CALL aprq551_set_no_entry_b(l_cmd)
#            IF lb_reproduce THEN
#               LET lb_reproduce = FALSE
#               LET g_prdc4_d[li_reproduce_target].* = g_prdc4_d[li_reproduce].*
# 
#               LET g_prdc4_d[li_reproduce_target].prdk003 = NULL
#            END IF
#            #公用欄位給值(單身2)
#            
#            
#            #add-point:modify段before insert
#            #end add-point  
#            
#         BEFORE ROW     
#            #add-point:modify段before row2
#
#            #end add-point  
#            LET l_insert = FALSE
#            LET l_cmd = ''
#            LET l_ac = ARR_CURR()
#            LET g_detail_idx = l_ac
#              
#            LET l_lock_sw = 'N'            #DEFAULT
#            LET l_n = ARR_COUNT()
#            DISPLAY l_ac TO FORMONLY.idx
#         
#            CALL s_transaction_begin()
#            OPEN aprq551_cl USING g_enterprise,g_prdw_m.prdwsite,g_prdw_m.prdw001
#            IF STATUS THEN
#               CALL cl_err("OPEN aprq551_cl:", STATUS, 1)
#               CLOSE aprq551_cl
#               CALL s_transaction_end('N','0')
#               RETURN
#            END IF
#            
#            LET g_rec_b = g_prdc4_d.getLength()
#            
#            IF g_rec_b >= l_ac 
#               AND g_prdc4_d[l_ac].prdk003 IS NOT NULL
#            THEN 
#               LET l_cmd='u'
#               LET g_prdc4_d_t.* = g_prdc4_d[l_ac].*  #BACKUP
#               CALL aprq551_set_entry_b(l_cmd)
#               #add-point:modify段after_set_entry_b
#               #end add-point  
#               CALL aprq551_set_no_entry_b(l_cmd)
#               IF NOT aprq551_lock_b("prdk_t","'4'") THEN
#                  LET l_lock_sw='Y'
#               ELSE
#                  FETCH aprq551_bcl4 INTO g_prdc4_d[l_ac].prdkacti,g_prdc4_d[l_ac].prdj003, 
#                      g_prdc4_d[l_ac].prdk003,g_prdc4_d[l_ac].prdk005,g_prdc4_d[l_ac].prdk005_desc,g_prdc4_d[l_ac].prdk007, 
#                      g_prdc4_d[l_ac].prdk007_desc,g_prdc4_d[l_ac].prdk008,g_prdc4_d[l_ac].prdj005,g_prdc4_d[l_ac].prdj002 
#                   IF SQLCA.sqlcode THEN
#                     CALL cl_err('',SQLCA.sqlcode,1)
#                     LET l_lock_sw = "Y"
#                  END IF
#                  
#                  LET g_bfill = "N"
#                  CALL aprq551_show()
#                  LET g_bfill = "Y"
#                  
#                  CALL cl_show_fld_cont()
#               END IF
#            ELSE
#               LET l_cmd='a'
#            END IF
#            #add-point:modify段before row
#
#            #end add-point  
#            #其他table資料備份(確定是否更改用)
#            
#            #其他table進行lock
#            
#            
#         BEFORE DELETE                            #是否取消單身
#            IF l_cmd = 'a' AND g_prdc4_d.getLength() < l_ac THEN
#               CALL FGL_SET_ARR_CURR(l_ac-1)
#               CALL g_prdc4_d.deleteElement(l_ac)
#               NEXT FIELD prdk003
#            END IF
#         
#            IF g_prdc4_d[l_ac].prdk003 IS NOT NULL
#            THEN
#               IF NOT cl_ask_del_detail() THEN
#                  CANCEL DELETE
#               END IF
#               IF l_lock_sw = "Y" THEN
#                  CALL cl_err("", -263, 1)
#                  CANCEL DELETE
#               END IF
#               
#               #add-point:單身2刪除前
#               DELETE FROM prdj_t
#               WHERE prdjent = g_enterprise AND prdjdocno = g_prdw_m.prdadocno AND 
#                     prdj002 = g_prdc4_d_t.prdk003 and prdj003 = g_prdc4_d_t.prdj003
#                 AND prdj004 = 0
#               IF SQLCA.sqlcode THEN
#                  CALL cl_err("prdj_t",SQLCA.sqlcode,1)
#                  CALL s_transaction_end('N','0')
#                  CANCEL DELETE   
#               END IF 
#               #end add-point    
#               
#               DELETE FROM prdk_t
#                WHERE prdkent = g_enterprise AND prdkdocno = g_prdw_m.prdadocno AND
#                      prdk002 = g_prdc4_d_t.prdk003 AND prdk003 = g_prdc4_d_t.prdk003
#                  
#               #add-point:單身2刪除中
#               
#               #end add-point    
#                  
#               IF SQLCA.sqlcode THEN
#                  CALL cl_err("prdc_t",SQLCA.sqlcode,1)
#                  CALL s_transaction_end('N','0')
#                  CANCEL DELETE   
#               ELSE
#                  LET g_rec_b = g_rec_b-1
#                  
#                  #add-point:單身2刪除後
#                   
#                  #end add-point
#                  CALL s_transaction_end('Y','0')
#               END IF 
#               CLOSE aprq551_bcl
#               LET l_count = g_prdc_d.getLength()
#            END IF 
#            
#                           INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_prdw_m.prdadocno
#               LET gs_keys[2] = g_prdc4_d[g_detail_idx].prdk003
# 
#            
#         AFTER DELETE 
#            #add-point:單身AFTER DELETE 
#
#            #end add-point
#            DELETE FROM prdj_t
#             WHERE prdjent = g_enterprise AND prdjdocno = g_prdw_m.prdadocno AND 
#                   prdj002 = g_prdc4_d_t.prdk003 and prdj003 = g_prdc4_d_t.prdj003
#               AND prdj004 = 0
#            IF SQLCA.sqlcode THEN
#               CALL cl_err("prdj_t",SQLCA.sqlcode,0)  
#            END IF 
#               #end add-point    
#               
#            DELETE FROM prdk_t
#             WHERE prdkent = g_enterprise AND prdkdocno = g_prdw_m.prdadocno AND
#                   prdk002 = g_prdc4_d_t.prdk003 AND prdk003 = g_prdc4_d_t.prdk003
#            IF SQLCA.sqlcode THEN
#               CALL cl_err("prdj_t",SQLCA.sqlcode,0)  
#            END IF      
#               #add-point:單身2刪除中
# 
#         AFTER INSERT    
#            LET l_insert = FALSE
#            IF INT_FLAG THEN
#               CALL cl_err('',9001,0)
#               LET INT_FLAG = 0
#               CANCEL INSERT
#            END IF
#               
#            #add-point:單身2新增前
#
#            #end add-point
#               
#            LET l_count = 1  
#            SELECT COUNT(*) INTO l_count FROM prdk_t 
#             WHERE prdkent = g_enterprise AND prdkdocno = g_prdw_m.prdadocno
#               AND prdk002 = g_prdc4_d[l_ac].prdk003 AND prdk003 = g_prdc4_d[l_ac].prdk003
#               AND prdk005 = g_prdc4_d[l_ac].prdk005
#                
#            #資料未重複, 插入新增資料
#            IF l_count = 0 THEN 
#               #add-point:單身2新增前
#               IF NOT cl_null(g_prdc4_d[l_ac].prdj003) AND NOT cl_null(g_prdc4_d[l_ac].prdK003) THEN
#                  SELECT count(*) INTO l_cnt FROM prdj_t 
#                   WHERE prdjent = g_enterprise AND prdjdocno = g_prdw_m.prdadocno
#                     AND prdj002 = g_prdc4_d[l_ac].prdk003 AND prdj003 = g_prdc4_d[l_ac].prdj003
#                  IF l_cnt>0 THEN
#                     CALL cl_err('',"apr-00324",1)
#                     NEXT FIELD prdj003 
#                  END IF
#               END IF
#               #end add-point
#                                 
#               INSERT INTO prdk_t (prdkent,prdksite,prdkunit,prdkdocno,prdk001,prdk002,prdk003,prdk004,prdk005,prdk007,prdk008,prdkacti)
#                VALUES (g_enterprise,g_prdw_m.prdwsite,g_prdw_m.prdwunit,g_prdw_m.prdadocno,g_prdw_m.prdw001,g_prdc4_d[l_ac].prdk003,g_prdc4_d[l_ac].prdk003,'4',g_prdc4_d[l_ac].prdk005,g_prdc4_d[l_ac].prdk007,g_prdc4_d[l_ac].prdk008,g_prdc4_d[l_ac].prdkacti)
#               IF SQLCA.SQLcode  THEN
#                  CALL cl_err("prdk_t",SQLCA.sqlcode,1)  
#                  CALL s_transaction_end('N','0')                    
#                  CANCEL INSERT
#               ELSE
#                  INSERT INTO prdj_t (prdjent,prdjsite,prdjunit,prdjdocno,prdj001,prdj002,prdj003,prdj004,prdj005,prdjacti)
#                  VALUES (g_enterprise,g_prdw_m.prdwsite,g_prdw_m.prdwunit,g_prdw_m.prdadocno,g_prdw_m.prdw001,g_prdc4_d[l_ac].prdk003,g_prdc4_d[l_ac].prdj003,0,g_prdc4_d[l_ac].prdj005,g_prdc4_d[l_ac].prdkacti)
#                  IF SQLCA.SQLcode  THEN
#                     CALL cl_err("prdj_t",SQLCA.sqlcode,1)  
#                     CALL s_transaction_end('N','0')                    
#                     CANCEL INSERT
#                  ELSE
#                     #先刷新資料
#                     #CALL aprq551_b_fill()
#                     #資料多語言用-增/改
#                     UPDATE prdw_t SET prdw018 = g_prdw_m.prdw018,
#                                       prdw019 = g_prdw_m.prdw019,
#                                       prdw032 = g_prdw_m.prdw032
#                      WHERE prdwent = g_enterprise AND prdadocno = g_prdw_m.prdadocno
#                     IF SQLCA.SQLcode  THEN
#                        CALL cl_err("prdk_t",SQLCA.sqlcode,1)  
#                        CALL s_transaction_end('N','0')                    
#                        CANCEL INSERT
#                     ELSE                      
#                     #add-point:單身新增後
#                     #end add-point
#                        CALL s_transaction_end('Y','0')
#                        ERROR 'INSERT O.K'
#                        LET g_rec_b = g_rec_b + 1
#                     END IF   
#                  END IF
#               END IF
#                           
#               #add-point:單身新增後2
#
#               #end add-point
#            ELSE    
#               CALL cl_err('INSERT',"std-00006",1)
#               INITIALIZE g_prdc_d[l_ac].* TO NULL
#               CALL s_transaction_end('N','0')
#               CANCEL INSERT
#            END IF
# 
#            
#            
#         ON ROW CHANGE 
#            IF INT_FLAG THEN
#               CALL cl_err('',9001,0)
#               LET INT_FLAG = 0
#               LET g_prdc4_d[l_ac].* = g_prdc4_d_t.*
#               CLOSE aprq551_bcl4
#               CALL s_transaction_end('N','0')
#               EXIT DIALOG 
#            END IF
#            
#            IF l_lock_sw = 'Y' THEN
#               CALL cl_err('',-263,1)
#               LET g_prdc4_d[l_ac].* = g_prdc4_d_t.*
#            ELSE
#               #add-point:單身page2修改前
#               UPDATE prdw_t SET prdw018 = g_prdw_m.prdw018,
#                                 prdw019 = g_prdw_m.prdw019,
#                                 prdw032 = g_prdw_m.prdw032
#                WHERE prdwent = g_enterprise AND prdadocno = g_prdw_m.prdadocno
#               IF SQLCA.sqlcode THEN #其他錯誤
#                  CALL cl_err("prdk_t",SQLCA.sqlcode,1)  
#                  CALL s_transaction_end('N','0')
#                  LET g_prdc4_d[l_ac].* = g_prdc4_d_t.*
#                  RETURN
#               END IF 
#               UPDATE prdj_t SET (prdjdocno,prdjacti,prdj002,prdj003,prdj005)=(g_prdw_m.prdadocno, 
#                   g_prdc4_d[l_ac].prdkacti,g_prdc4_d[l_ac].prdk003,g_prdc4_d[l_ac].prdj003,g_prdc4_d[l_ac].prdj005)
#                WHERE prdjent = g_enterprise AND prdjdocno = g_prdw_m.prdadocno
#                  AND prdj002 = g_prdc4_d_t.prdk003 AND prdj003 =  g_prdc4_d_t.prdj003
#                  AND prdj004 = 0
#               IF SQLCA.sqlcode THEN #其他錯誤
#                  CALL cl_err("prdk_t",SQLCA.sqlcode,1)  
#                  CALL s_transaction_end('N','0')
#                  LET g_prdc4_d[l_ac].* = g_prdc4_d_t.*
#                  RETURN
#               END IF 
#               #end add-point
#               
#               #寫入修改者/修改日期資訊(單身2)
#               
#               
#               UPDATE prdk_t SET (prdkdocno,prdkacti,prdk002,prdk003,prdk005,prdk007,prdk008,prdksite,prdkunit) = 
#(g_prdw_m.prdadocno, g_prdc4_d[l_ac].prdkacti,g_prdc4_d[l_ac].prdk003,g_prdc4_d[l_ac].prdk003,g_prdc4_d[l_ac].prdk005, 
#                   g_prdc4_d[l_ac].prdk007,g_prdc4_d[l_ac].prdk008,g_prdw_m.prdwsite,g_prdw_m.prdwunit) #自訂欄位頁簽
#                WHERE prdkent = g_enterprise AND prdkdocno = g_prdw_m.prdadocno
#                  AND prdk002 = g_prdc4_d_t.prdk003 AND prdk003 = g_prdc4_d_t.prdk003
#                  AND prdk004 = '4' AND prdk005=g_prdc4_d_t.prdk005
#                  
#               #add-point:單身page2修改中
#
#               #end add-point
#                  
#               CASE
#                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
#                     CALL cl_err("prdk_t","std-00009",1)
#                     CALL s_transaction_end('N','0')
#                     LET g_prdc4_d[l_ac].* = g_prdc4_d_t.*
#                  WHEN SQLCA.sqlcode #其他錯誤
#                     CALL cl_err("prdk_t",SQLCA.sqlcode,1)  
#                     CALL s_transaction_end('N','0')
#                     LET g_prdc4_d[l_ac].* = g_prdc4_d_t.*
#                  OTHERWISE
#                                    INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_prdw_m.prdadocno
#               LET gs_keys_bak[1] = g_prdwdocno_t
#               LET gs_keys[2] = g_prdc4_d[g_detail_idx].prdk003
#               LET gs_keys_bak[2] = g_prdc4_d_t.prdk003
#               CALL aprq551_update_b('prdk_t',gs_keys,gs_keys_bak,"'2'")
#                     #資料多語言用-增/改
#                     
#               END CASE
#               #add-point:單身page2修改後
#
#               #end add-point
#            END IF
#         
#         #---------------------<  Detail: page2  >---------------------
#         #----<<prdkacti>>----
#         #此段落由子樣板a01產生
#         BEFORE FIELD prdkacti
#            #add-point:BEFORE FIELD prdkacti
#
#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD prdkacti
#            
#            #add-point:AFTER FIELD prdkacti
#
#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE prdkacti
#            #add-point:ON CHANGE prdkacti
#
#            #END add-point
# 
#         #----<<prdk002>>----
#         #此段落由子樣板a02產生
#         AFTER FIELD prdj003
#            #此段落由子樣板a15產生
#            IF NOT cl_ap_chk_Range(g_prdc4_d[l_ac].prdj003,"0","1","","","azz-00079",1) THEN
#               LET g_prdc4_d[l_ac].prdj003 = g_prdc4_d_t.prdj003
#               NEXT FIELD prdj003
#            END IF
# 
# 
#            #add-point:AFTER FIELD prdj003
#            #此段落由子樣板a05產生
#            IF  g_prdw_m.prdadocno IS NOT NULL AND g_prdc4_d[g_detail_idx].prdj003 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_prdc4_d[l_ac].prdj003 != g_prdc4_d_t.prdj003)) THEN 
#                                       
#                  CALL aprq551_chk_prdj003()
#                  IF NOT cl_null(g_errno) THEN
#                     CALL cl_err(g_prdc4_d[l_ac].prdj003,g_errno,1)
#                     LET g_prdc4_d[l_ac].prdj003 = g_prdc4_d_t.prdj003
#                     NEXT FIELD prdj003 
#                  END IF
#                  IF NOT cl_null(g_prdc4_d[l_ac].prdk003) THEN
#                     SELECT count(*) INTO l_cnt FROM prdj_t 
#                      WHERE prdjent = g_enterprise AND prdjdocno = g_prdw_m.prdadocno
#                        AND prdj002 = g_prdc4_d[l_ac].prdk003 AND prdj003 = g_prdc4_d[l_ac].prdj003
#                     IF l_cnt>0 THEN
#                        CALL cl_err(g_prdc4_d[l_ac].prdj003,"apr-00324",1)
#                        LET g_prdc4_d[l_ac].prdj003 = g_prdc4_d_t.prdj003
#                        NEXT FIELD prdj003 
#                     END IF
#                  END IF                  
#               END IF
#            END IF
#
#
#            #END add-point
#            
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD prdj003
#            #add-point:BEFORE FIELD prdk002
#
#            #END add-point
# 
#         #此段落由子樣板a04產生
#         ON CHANGE prdj003
#            #add-point:ON CHANGE prdk002
#
#            #END add-point
#
# 
#         #----<<prdk003>>----
#         #此段落由子樣板a01產生
#         BEFORE FIELD prdk003
#            #add-point:BEFORE FIELD prdk003
#
#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD prdk003
#            
#            #add-point:AFTER FIELD prdk003
#            IF NOT cl_ap_chk_Range(g_prdc4_d[l_ac].prdk003,"0","1","","","azz-00079",1) THEN
#               LET g_prdc4_d[l_ac].prdk003 = g_prdc4_d_t.prdk003
#               NEXT FIELD prdk003
#            END IF
#
#            
#            IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prdw_m.prdadocno != g_prdwdocno_t OR g_prdc4_d[g_detail_idx].prdk003 != g_prdc4_d_t.prdk003 OR g_prdc4_d[g_detail_idx].prdk005 != g_prdc4_d_t.prdk005)) THEN 
#               IF g_prdc4_d[g_detail_idx].prdk003 IS NOT NULL AND  g_prdc4_d[g_detail_idx].prdk005 IS NOT NULL  THEN
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prdk_t WHERE "||"prdkent = '" ||g_enterprise|| "' AND "||"prdkdocno = '"||g_prdw_m.prdadocno ||"' AND "|| "prdk002 = '"||g_prdc4_d[g_detail_idx].prdk003 ||"' AND "|| "prdk003 = '"||g_prdc4_d[g_detail_idx].prdk003 ||"' AND "|| "prdk005 = '"||g_prdc4_d[g_detail_idx].prdk005 ||"'",'std-00004',1) THEN 
#                     LET g_prdc4_d[l_ac].prdk003 = g_prdc4_d_t.prdk003
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#               IF NOT cl_null(g_prdc4_d[l_ac].prdj003) THEN
#                  SELECT count(*) INTO l_cnt FROM prdj_t 
#                   WHERE prdjent = g_enterprise AND prdjdocno = g_prdw_m.prdadocno
#                     AND prdj002 = g_prdc4_d[l_ac].prdk003 AND prdj003 = g_prdc4_d[l_ac].prdj003
#                  IF l_cnt>0 THEN
#                     CALL cl_err(g_prdc4_d[l_ac].prdk003,"apr-00324",1)
#                     LET g_prdc4_d[l_ac].prdk003 = g_prdc4_d_t.prdk003
#                     NEXT FIELD prdk003 
#                  END IF
#               END IF
#            END IF
#            #END add-point
#            
#         #----<<prdk004>>----
#         #此段落由子樣板a01產生
#         BEFORE FIELD prdk005
#            #add-point:BEFORE FIELD prdk004
#
#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD prdk005
#            
#            #add-point:AFTER FIELD prdk004
#            LET g_prdc4_d[l_ac].prdk005_desc = null
#            DISPLAY BY NAME g_prdc4_d[l_ac].prdk005_desc
#            IF  g_prdw_m.prdadocno IS NOT NULL AND g_prdc4_d[g_detail_idx].prdk003 IS NOT NULL AND g_prdc4_d[g_detail_idx].prdk005 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prdw_m.prdadocno != g_prdwdocno_t OR g_prdc4_d[g_detail_idx].prdk003 != g_prdc4_d_t.prdk003 OR g_prdc4_d[g_detail_idx].prdk005 != g_prdc4_d_t.prdk005)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prdk_t WHERE "||"prdkent = '" ||g_enterprise|| "' AND "||"prdkdocno = '"||g_prdw_m.prdadocno ||"' AND "|| "prdk002 = '"||g_prdc4_d[g_detail_idx].prdk003 ||"' AND "|| "prdk003 = '"||g_prdc4_d[g_detail_idx].prdk003 ||"' AND "|| "prdk005 = '"||g_prdc4_d[g_detail_idx].prdk005 ||"'",'std-00004',0) THEN 
#                     LET g_prdc4_d[l_ac].prdk005 = g_prdc4_d_t.prdk005
#                     CALL aprq551_prdk005_ref()
#                     NEXT FIELD CURRENT
#                  END IF
#                  IF NOT cl_null(g_prdc4_d[l_ac].prdk003) THEN
#                     #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#                     INITIALIZE g_chkparam.* TO NULL
#                     #設定g_chkparam.*的參數
#                     LET g_chkparam.arg1 = g_prdc4_d[l_ac].prdk005
##                     LET g_chkparam.arg2 = g_site
#                     #呼叫檢查存在並帶值的library
#                     IF NOT cl_chk_exist("v_imaa001_5") THEN
#                        LET g_prdc4_d[l_ac].prdk005 = g_prdc4_d_t.prdk005
#                        CALL aprq551_prdk005_ref()
#                        NEXT FIELD CURRENT
#                     END IF
#                  END IF
#               END IF
#            END IF
#            CALL aprq551_prdk005_ref()
#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE prdk005
#            #add-point:ON CHANGE prdk004
#
#            #END add-point
# 
#         #----<<prdk006>>----
#         #此段落由子樣板a02產生
#         AFTER FIELD prdj005
#            #此段落由子樣板a15產生
##            IF NOT cl_ap_chk_Range(g_prdc4_d[l_ac].prdj005,"","","0","0","azz-00080",1) THEN
##               LET g_prdc4_d[l_ac].prdj005 = g_prdc4_d_t.prdj005
##               NEXT FIELD prdj005
##            END IF
#            IF NOT cl_ap_chk_Range(g_prdc4_d[l_ac].prdj005,"0","1","","","azz-00079",1) THEN
#               LET g_prdc4_d[l_ac].prdj005 = g_prdc4_d_t.prdj005
#               NEXT FIELD prdj005
#            END IF
# 
#            #add-point:AFTER FIELD prdk006
#            IF NOT cl_null(g_prdc4_d[l_ac].prdj005) THEN 
#            END IF 
#
#
#            #END add-point
#            
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD prdj005
#            #add-point:BEFORE FIELD prdk006
#
#            #END add-point
# 
#         #此段落由子樣板a04產生
#         ON CHANGE prdj005
#            #add-point:ON CHANGE prdk006
#
#            #END add-poin
# 
#         
#         #Ctrlp:input.c.page2.prdk003
#         ON ACTION controlp INFIELD prdk003
#            #add-point:ON ACTION controlp INFIELD prdk003
#
#            #END add-point
# 
#         #----<<prdk005>>----
#         #Ctrlp:input.c.page2.prdk005
#         ON ACTION controlp INFIELD prdk005
#            #add-point:ON ACTION controlp INFIELD prdk005
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'i'
#	         LET g_qryparam.reqry = FALSE
#            LET g_qryparam.default1 = g_prdc4_d[l_ac].prdk005             #給予default值
#            LET g_qryparam.arg1 = g_site
##            CALL q_rtdx001_12()
#            call q_imaa001()
#            LET g_prdc4_d[l_ac].prdk005  = g_qryparam.return1        #將開窗取得的值回傳到變數
#            DISPLAY g_prdc4_d[l_ac].prdk005  TO prdk005              #顯示到畫面上
#            CALL aprq551_prdk005_ref()
#            NEXT FIELD prdk005
#            #END add-point
# 
#         #----<<prdk008>>----
# 
# 
# 
#         AFTER ROW
#            #add-point:單身page2 after_row
#
#            #end add-point
#            LET l_ac = ARR_CURR()
#            IF INT_FLAG THEN
#               CALL cl_err('',9001,0)
#               LET INT_FLAG = 0
#               IF l_cmd = 'u' THEN
#                  LET g_prdc4_d[l_ac].* = g_prdc4_d_t.*
#               END IF
#               CLOSE aprq551_bcl4
#               CALL s_transaction_end('N','0')
#               EXIT DIALOG 
#            END IF
#            
#            #其他table進行unlock
#            
#            CLOSE aprq551_bcl4
#            CALL s_transaction_end('Y','0')
#            #add-point:單身page2 after_row2
#
#            #end add-point
# 
#         AFTER INPUT
#            #add-point:input段after input 
#
#            #end add-point   
#    
#         ON ACTION controlo
#            CALL FGL_SET_ARR_CURR(g_prdc4_d.getLength()+1)
#            LET lb_reproduce = TRUE
#            LET li_reproduce = l_ac
#            LET li_reproduce_target = g_prdc4_d.getLength()+1
# 
#      END INPUT
      #end add-point
      
      BEFORE DIALOG 
         #add-point:input段before dialog
         
         #end add-point    
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD prdwsite
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD prdcacti
               WHEN "s_detail2"
                  NEXT FIELD prdhacti
               WHEN "s_detail3"
                  NEXT FIELD prdgacti
 
            END CASE
         END IF
    
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
 
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
         #add-point:input段accept 
         
         #end add-point    
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
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
 
{<section id="aprq551.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aprq551_show()
   DEFINE l_ac_t    LIKE type_t.num5
   #add-point:show段define
   define l_prdadocno like prda_t.prdadocno
   #end add-point  
 
   #add-point:show段之前
   
   #end add-point
   
   
   
   LET g_prdw_m_t.* = g_prdw_m.*      #保存單頭舊值
   
   IF g_bfill = "Y" THEN
      CALL aprq551_b_fill() #單身填充
      CALL aprq551_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #此段落由子樣板a12產生
      #LET g_prdw_m.prdwownid_desc = cl_get_username(g_prdw_m.prdwownid)
      #LET g_prdw_m.prdwowndp_desc = cl_get_deptname(g_prdw_m.prdwowndp)
      #LET g_prdw_m.prdwcrtid_desc = cl_get_username(g_prdw_m.prdwcrtid)
      #LET g_prdw_m.prdwcrtdp_desc = cl_get_deptname(g_prdw_m.prdwcrtdp)
      #LET g_prdw_m.prdwmodid_desc = cl_get_username(g_prdw_m.prdwmodid)
      #LET g_prdw_m.prdwcnfid_desc = cl_get_deptname(g_prdw_m.prdwcnfid)
      ##LET g_prdw_m.prdwpstid_desc = cl_get_deptname(g_prdw_m.prdwpstid)
      
 
 
   
   #顯示followup圖示
   #+ 此段落由子樣板a48產生
   CALL aprq551_set_pk_array()
   #add-point:ON ACTION agendum
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference
   SELECT prdadocno INTO l_prdadocno FROM prda_t WHERE prdaent = g_enterprise AND prda001=g_prdw_m.prdw001
      AND prda002 = g_prdw_m.prdw002 AND prdaent = g_enterprise
   SELECT prdd003,prdd004 INTO g_prdw_m.prdd003,g_prdw_m.prdd004 FROM prdd_t
    WHERE prddent = g_enterprise AND prdddocno = l_prdadocno AND prdd002=1
   DISPLAY BY NAME g_prdw_m.prdd003,g_prdw_m.prdd004
   LET g_prdw_m.pos = 'N'
   DISPLAY BY NAME g_prdw_m.pos
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdw_m.prdw001
   LET g_ref_fields[2] = g_prdw_m.prdwsite
   CALL ap_ref_array2(g_ref_fields," SELECT prdwl003 FROM prdwl_t WHERE prdwlent = '"||g_enterprise||"' AND prdwl001 = ? AND prdwlsite = ? AND prdwl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_prdw_m.prdwl003 = g_rtn_fields[1] 
   DISPLAY g_prdw_m.prdwl003 TO prdwl003
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prdw_m.prdwunit
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prdw_m.prdwunit_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prdw_m.prdwunit_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prdw_m.prdwsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prdw_m.prdwsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prdw_m.prdwsite_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prdw_m.prdw006
            CALL ap_ref_array2(g_ref_fields,"SELECT prcfl003 FROM prcfl_t WHERE prcflent='"||g_enterprise||"' AND prcfl001=? AND prcfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prdw_m.prdw006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prdw_m.prdw006_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prdw_m.prdw007
            CALL ap_ref_array2(g_ref_fields,"SELECT prcdl003 FROM prcdl_t WHERE prcdlent='"||g_enterprise||"' AND prcdl001=? AND prcdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prdw_m.prdw007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prdw_m.prdw007_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prdw_m.prdw004
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_prdw_m.prdw004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prdw_m.prdw004_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prdw_m.prdw005
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prdw_m.prdw005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prdw_m.prdw005_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prdw_m.prdw008
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2100' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prdw_m.prdw008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prdw_m.prdw008_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prdw_m.prdw009
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2101' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prdw_m.prdw009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prdw_m.prdw009_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prdw_m.prdwcrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_prdw_m.prdwcrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prdw_m.prdwcrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prdw_m.prdwcrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prdw_m.prdwcrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prdw_m.prdwcrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prdw_m.prdwownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_prdw_m.prdwownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prdw_m.prdwownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prdw_m.prdwowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prdw_m.prdwowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prdw_m.prdwowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prdw_m.prdwmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_prdw_m.prdwmodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prdw_m.prdwmodid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prdw_m.prdwcnfid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_prdw_m.prdwcnfid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prdw_m.prdwcnfid_desc

   #end add-point
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_prdw_m.prdwunit,g_prdw_m.prdwunit_desc,g_prdw_m.prdwsite,g_prdw_m.prdwsite_desc, 
       g_prdw_m.prdw099,g_prdw_m.pos,g_prdw_m.prdw001,g_prdw_m.prdw002,g_prdw_m.prdwl003,g_prdw_m.prdw100, 
       g_prdw_m.prdw006,g_prdw_m.prdw006_desc,g_prdw_m.prdw007,g_prdw_m.prdw007_desc,g_prdw_m.prdw027, 
       g_prdw_m.prdwstus,g_prdw_m.prdw004,g_prdw_m.prdw004_desc,g_prdw_m.prdw005,g_prdw_m.prdw005_desc, 
       g_prdw_m.prdw003,g_prdw_m.prdw012,g_prdw_m.prdw010,g_prdw_m.prdw013,g_prdw_m.prdw011,g_prdw_m.prdw014, 
       g_prdw_m.prdd003,g_prdw_m.prdd004,g_prdw_m.prdw098,g_prdw_m.prdw017,g_prdw_m.prdw020,g_prdw_m.prdw021, 
       g_prdw_m.prdw008,g_prdw_m.prdw008_desc,g_prdw_m.prdw009,g_prdw_m.prdw009_desc,g_prdw_m.prdw022, 
       g_prdw_m.prdw026,g_prdw_m.prdw023,g_prdw_m.prdw025,g_prdw_m.prdw028,g_prdw_m.prdw029,g_prdw_m.prdw030, 
       g_prdw_m.prdw031,g_prdw_m.prdwcrtid,g_prdw_m.prdwcrtid_desc,g_prdw_m.prdwcrtdp,g_prdw_m.prdwcrtdp_desc, 
       g_prdw_m.prdwcrtdt,g_prdw_m.prdwownid,g_prdw_m.prdwownid_desc,g_prdw_m.prdwowndp,g_prdw_m.prdwowndp_desc, 
       g_prdw_m.prdwmodid,g_prdw_m.prdwmodid_desc,g_prdw_m.prdwmoddt,g_prdw_m.prdwcnfid,g_prdw_m.prdwcnfid_desc, 
       g_prdw_m.prdwcnfdt,g_prdw_m.prdw018,g_prdw_m.prdw032,g_prdw_m.prdw019
   
   #顯示狀態(stus)圖片
         #此段落由子樣板a21產生
      CASE g_prdw_m.prdwstus
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         
      END CASE
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_prdc_d.getLength()
      #帶出公用欄位reference值
      
      #add-point:show段單身reference

            CALL aprq551_prdc004_ref()

      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_prdc2_d.getLength()
      #帶出公用欄位reference值
      
      #add-point:show段單身reference
      IF g_prdc2_d[l_ac].prdh009<>'4' THEN
         SELECT prdb005 INTO g_prdc2_d[l_ac].prdb005 FROM prdb_t
          WHERE prdbent = g_enterprise AND prdbdocno = l_prdadocno
            AND prdb004 = g_prdc2_d[l_ac].prdh002 AND rownum = 1
         DISPLAY g_prdc2_d[l_ac].prdb005 TO s_detail2[l_ac].prdb005
      END IF         
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_prdc3_d.getLength()
      #帶出公用欄位reference值
      
      #add-point:show段單身reference

            CALL aprq551_prdg_desc()

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prdc3_d[l_ac].prdg006
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prdc3_d[l_ac].prdg006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prdc3_d[l_ac].prdg006_desc

      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other
   FOR l_ac = 1 TO g_prdc4_d.getLength()

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = g_prdc4_d[l_ac].prdk005
       CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET g_prdc4_d[l_ac].prdk005_desc = '', g_rtn_fields[1] , ''
       DISPLAY BY NAME g_prdc4_d[l_ac].prdk005_desc

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = g_prdc4_d[l_ac].prdk007
       CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET g_prdc4_d[l_ac].prdk007_desc = '', g_rtn_fields[1] , ''
       DISPLAY BY NAME g_prdc4_d[l_ac].prdk007_desc
      #end add-point
   END FOR
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aprq551_detail_show()
   
   #add-point:show段之後
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aprq551.detail_show" >}
#+ 單身reference detail_show
PRIVATE FUNCTION aprq551_detail_show()
   #add-point:detail_show段define
   
   #end add-point  
 
   #add-point:detail_show段之前
   
   #end add-point
   
   #add-point:detail_show段之後
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aprq551.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aprq551_reproduce()
   DEFINE l_newno     LIKE prdw_t.prdwsite 
   DEFINE l_oldno     LIKE prdw_t.prdwsite 
   DEFINE l_newno02     LIKE prdw_t.prdw001 
   DEFINE l_oldno02     LIKE prdw_t.prdw001 
 
   DEFINE l_master    RECORD LIKE prdw_t.*
   DEFINE l_detail    RECORD LIKE prdc_t.*
   DEFINE l_detail2    RECORD LIKE prdh_t.*
 
   DEFINE l_detail3    RECORD LIKE prdg_t.*
 
 
 
   DEFINE l_cnt       LIKE type_t.num5
   #add-point:reproduce段define
   
   #end add-point   
 
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   IF g_prdw_m.prdwsite IS NULL
   OR g_prdw_m.prdw001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      RETURN
   END IF
    
   LET g_prdwsite_t = g_prdw_m.prdwsite
   LET g_prdw001_t = g_prdw_m.prdw001
 
    
   LET g_prdw_m.prdwsite = ""
   LET g_prdw_m.prdw001 = ""
 
    
   CALL aprq551_set_entry('a')
   CALL aprq551_set_no_entry('a')
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #此段落由子樣板a14產生    
      LET g_prdw_m.prdwownid = g_user
      LET g_prdw_m.prdwowndp = g_dept
      LET g_prdw_m.prdwcrtid = g_user
      LET g_prdw_m.prdwcrtdp = g_dept 
      LET g_prdw_m.prdwcrtdt = cl_get_current()
      LET g_prdw_m.prdwmodid = ""
      LET g_prdw_m.prdwmoddt = ""
      LET g_prdw_m.prdwstus = "N"
 
 
  
   CALL s_transaction_begin()
 
   #add-point:複製輸入前
   
   #end add-point
   
   CALL aprq551_input("r")
   
      LET g_prdw_m.prdwsite_desc = ''
   DISPLAY BY NAME g_prdw_m.prdwsite_desc
 
   
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN
   END IF
 
   LET g_state = "Y"
   LET g_current_idx = 1    
 
   LET g_wc = g_wc,  
              " OR (",
              " prdwsite = '", g_prdw_m.prdwsite CLIPPED, "' "
              ," AND prdw001 = '", g_prdw_m.prdw001 CLIPPED, "' "
 
              , ") "
   
   #add-point:完成複製段落後
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aprq551.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aprq551_detail_reproduce()
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE prdc_t.*
   DEFINE l_detail2    RECORD LIKE prdh_t.*
 
   DEFINE l_detail3    RECORD LIKE prdg_t.*
 
 
 
   #add-point:delete段define

   #end add-point    
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aprq551_detail
   
   #add-point:單身複製前1

   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE aprq551_detail AS ",
                "SELECT * FROM prdc_t "
   PREPARE repro_tbl FROM ls_sql
   EXECUTE repro_tbl
   FREE repro_tbl
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO aprq551_detail SELECT * FROM prdc_t 
                                         WHERE prdcent = g_enterprise AND  prdcsite= g_prdwsite_t
                                         AND  prdc001= g_prdw001_t
 
   
   #將key修正為調整後   
   UPDATE aprq551_detail 
      #更新key欄位
      SET  prdcsite= g_prdw_m.prdwsite
          , prdc001 = g_prdw_m.prdw001
 
      #更新共用欄位
      
                                       
  
   #將資料塞回原table   
   INSERT INTO prdc_t SELECT * FROM aprq551_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "reproduce"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      RETURN
   END IF
   
   #add-point:單身複製中1

   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aprq551_detail
   
   #add-point:單身複製後1

   #end add-point
 
   #add-point:單身複製前

   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = 
      "CREATE GLOBAL TEMPORARY TABLE aprq551_detail AS ",
      "SELECT * FROM prdh_t "
   PREPARE repro_tbl2 FROM ls_sql
   EXECUTE repro_tbl2
   FREE repro_tbl2
      
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO aprq551_detail SELECT * FROM prdh_t
                                         WHERE prdhent = g_enterprise AND  prdhsite= g_prdwsite_t
                                         AND  prdh001= g_prdw001_t
 
 
   #將key修正為調整後   
   UPDATE aprq551_detail SET  prdhsite= g_prdw_m.prdwsite
                                       ,  prdh001= g_prdw_m.prdw001
 
  
   #將資料塞回原table   
   INSERT INTO prdh_t SELECT * FROM aprq551_detail
   
   #add-point:單身複製中

   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aprq551_detail
   
   #add-point:單身複製後

   #end add-point
 
   #add-point:單身複製前

   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = 
      "CREATE GLOBAL TEMPORARY TABLE aprq551_detail AS ",
      "SELECT * FROM prdg_t "
   PREPARE repro_tbl3 FROM ls_sql
   EXECUTE repro_tbl3
   FREE repro_tbl3
      
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO aprq551_detail SELECT * FROM prdg_t
                                         WHERE prdgent = g_enterprise AND  prdgsite= g_prdwsite_t
                                         AND  prdw001= g_prdw001_t
 
 
   #將key修正為調整後   
   UPDATE aprq551_detail SET  prdgsite= g_prdw_m.prdwsite
                                       ,  prdg001= g_prdw_m.prdw001
 
  
   #將資料塞回原table   
   INSERT INTO prdg_t SELECT * FROM aprq551_detail
   
   #add-point:單身複製中

   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aprq551_detail
   
   #add-point:單身複製後

   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_prdwsite_t = g_prdw_m.prdwsite
   LET g_prdw001_t = g_prdw_m.prdw001
 
   
   DROP TABLE aprq551_detail
   
END FUNCTION
 
{</section>}
 
{<section id="aprq551.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aprq551_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define

   #end add-point     
   
   IF g_prdw_m.prdwsite IS NULL
   OR g_prdw_m.prdw001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      RETURN
   END IF
 
   EXECUTE aprq551_master_referesh USING g_prdw_m.prdwsite,g_prdw_m.prdw001 INTO g_prdw_m.prdwunit,g_prdw_m.prdwsite, 
       g_prdw_m.prdw099,g_prdw_m.prdw001,g_prdw_m.prdw002,g_prdw_m.prdw100,g_prdw_m.prdw006,g_prdw_m.prdw007, 
       g_prdw_m.prdw027,g_prdw_m.prdwstus,g_prdw_m.prdw004,g_prdw_m.prdw005,g_prdw_m.prdw003,g_prdw_m.prdw012, 
       g_prdw_m.prdw010,g_prdw_m.prdw013,g_prdw_m.prdw011,g_prdw_m.prdw014,g_prdw_m.prdw098,g_prdw_m.prdw017, 
       g_prdw_m.prdw020,g_prdw_m.prdw021,g_prdw_m.prdw008,g_prdw_m.prdw009,g_prdw_m.prdw022,g_prdw_m.prdw026, 
       g_prdw_m.prdw023,g_prdw_m.prdw025,g_prdw_m.prdw028,g_prdw_m.prdw029,g_prdw_m.prdw030,g_prdw_m.prdw031, 
       g_prdw_m.prdwcrtid,g_prdw_m.prdwcrtdp,g_prdw_m.prdwcrtdt,g_prdw_m.prdwownid,g_prdw_m.prdwowndp, 
       g_prdw_m.prdwmodid,g_prdw_m.prdwmoddt,g_prdw_m.prdwcnfid,g_prdw_m.prdwcnfdt,g_prdw_m.prdw018, 
       g_prdw_m.prdw032,g_prdw_m.prdw019
   
   LET g_master_multi_table_t.prdwl001 = g_prdw_m.prdw001
LET g_master_multi_table_t.prdwl003 = g_prdw_m.prdwl003
 
 
   CALL aprq551_show()
   
   CALL s_transaction_begin()
 
   OPEN aprq551_cl USING g_enterprise,g_prdw_m.prdwsite
                                                       ,g_prdw_m.prdw001
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN aprq551_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      CLOSE aprq551_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   FETCH aprq551_cl INTO g_prdw_m.prdwunit,g_prdw_m.prdwunit_desc,g_prdw_m.prdwsite,g_prdw_m.prdwsite_desc, 
       g_prdw_m.prdw099,g_prdw_m.pos,g_prdw_m.prdw001,g_prdw_m.prdw002,g_prdw_m.prdwl003,g_prdw_m.prdw100, 
       g_prdw_m.prdw006,g_prdw_m.prdw006_desc,g_prdw_m.prdw007,g_prdw_m.prdw007_desc,g_prdw_m.prdw027, 
       g_prdw_m.prdwstus,g_prdw_m.prdw004,g_prdw_m.prdw004_desc,g_prdw_m.prdw005,g_prdw_m.prdw005_desc, 
       g_prdw_m.prdw003,g_prdw_m.prdw012,g_prdw_m.prdw010,g_prdw_m.prdw013,g_prdw_m.prdw011,g_prdw_m.prdw014, 
       g_prdw_m.prdd003,g_prdw_m.prdd004,g_prdw_m.prdw098,g_prdw_m.prdw017,g_prdw_m.prdw020,g_prdw_m.prdw021, 
       g_prdw_m.prdw008,g_prdw_m.prdw008_desc,g_prdw_m.prdw009,g_prdw_m.prdw009_desc,g_prdw_m.prdw022, 
       g_prdw_m.prdw026,g_prdw_m.prdw023,g_prdw_m.prdw025,g_prdw_m.prdw028,g_prdw_m.prdw029,g_prdw_m.prdw030, 
       g_prdw_m.prdw031,g_prdw_m.prdwcrtid,g_prdw_m.prdwcrtid_desc,g_prdw_m.prdwcrtdp,g_prdw_m.prdwcrtdp_desc, 
       g_prdw_m.prdwcrtdt,g_prdw_m.prdwownid,g_prdw_m.prdwownid_desc,g_prdw_m.prdwowndp,g_prdw_m.prdwowndp_desc, 
       g_prdw_m.prdwmodid,g_prdw_m.prdwmodid_desc,g_prdw_m.prdwmoddt,g_prdw_m.prdwcnfid,g_prdw_m.prdwcnfid_desc, 
       g_prdw_m.prdwcnfdt,g_prdw_m.prdw018,g_prdw_m.prdw032,g_prdw_m.prdw019              #鎖住將被更改或取消的資料 
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_prdw_m.prdwsite
      LET g_errparam.popup = FALSE
      CALL cl_err()
          #資料被他人LOCK
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:delete段before ask

   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前

      #end add-point   
      
      #+ 此段落由子樣板a47產生
      #刪除相關文件
      CALL aprq551_set_pk_array()
      #add-point:相關文件刪除前

      #end add-point   
      CALL cl_doc_remove()  
 
  
  
      #資料備份
      LET g_prdwsite_t = g_prdw_m.prdwsite
      LET g_prdw001_t = g_prdw_m.prdw001
 
 
      DELETE FROM prdw_t
       WHERE prdwent = g_enterprise AND prdwsite = g_prdw_m.prdwsite
         AND prdw001 = g_prdw_m.prdw001
 
       
      #add-point:單頭刪除中

      #end add-point
       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_prdw_m.prdwsite
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      #add-point:單頭刪除後

      #end add-point
  
      #add-point:單身刪除前

      #end add-point
      
      DELETE FROM prdc_t
       WHERE prdcent = g_enterprise AND  prdcsite= g_prdw_m.prdwsite
         AND  prdc001= g_prdw_m.prdw001
 
 
      #add-point:單身刪除中

      #end add-point
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "prdc_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF    
 
      #add-point:單身刪除後

      #end add-point
      
            
                                                               
      #add-point:單身刪除前

      #end add-point
      DELETE FROM prdh_t
       WHERE prdhent = g_enterprise AND  prdhsite= g_prdw_m.prdwsite
         AND  prdh001= g_prdw_m.prdw001
             
      #add-point:單身刪除中

      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "prdh_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF      
 
      #add-point:單身刪除後

      #end add-point
 
      #add-point:單身刪除前

      #end add-point
      DELETE FROM prdg_t
       WHERE prdgent = g_enterprise AND  prdgsite= g_prdw_m.prdwsite
         AND  prdg001= g_prdw_m.prdw001
             
      #add-point:單身刪除中

      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "prdg_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF      
 
      #add-point:單身刪除後
      
      CALL g_prdc4_d.clear() 
      CALL g_prdc5_d.clear()
      CALL g_prdc6_d.clear()      
      #end add-point
 
 
 
 
                                                               
      CLEAR FORM
      CALL g_prdc_d.clear() 
      CALL g_prdc2_d.clear()       
      CALL g_prdc3_d.clear()       
 
     
      #CALL aprq551_ui_browser_refresh()  
      CALL aprq551_ui_headershow()  
      CALL aprq551_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL aprq551_browser_fill("")
         CALL aprq551_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
      ELSE
         LET g_wc = " 1=1"
         CALL aprq551_browser_fill("F")
      END IF
      
      #單頭多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_master_multi_table_t.prdwl001
   LET l_field_keys[01] = 'prdwl001'
   LET l_var_keys_bak[02] = g_dlang
   LET l_field_keys[02] = 'prdwl002'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'prdwl_t')
 
      
      #單身多語言刪除
      
      
 
      
 
 
 
  
 
   END IF
 
   CALL s_transaction_end('Y','0')
   
   CLOSE aprq551_cl
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_prdw_m.prdwsite,'D')
    
END FUNCTION
 
{</section>}
 
{<section id="aprq551.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aprq551_b_fill()
   DEFINE p_wc2      STRING
   #add-point:b_fill段define
   define l_prdadocno like prda_t.prdadocno
   #end add-point     
 
   CALL g_prdc_d.clear()    #g_prdc_d 單頭及單身 
   CALL g_prdc2_d.clear()
   CALL g_prdc3_d.clear()
 
 
   #add-point:b_fill段sql_before
   CALL g_prdc4_d.clear()
   CALL g_prdc5_d.clear()
   CALL g_prdc6_d.clear()
   SELECT prdadocno INTO l_prdadocno FROM prda_t WHERE prdaent = g_enterprise AND prda001=g_prdw_m.prdw001
      AND prda002 = g_prdw_m.prdw002 AND prdaent = g_enterprise
   #end add-point
   
   #判斷是否填充
   IF aprq551_fill_chk(1) THEN
   
      LET g_sql = "SELECT  UNIQUE prdcacti,prdc002,prdc003,prdc004,'',prdc001,prdcsite,prdcunit FROM prdc_t", 
             
                  " INNER JOIN prdw_t ON prdwsite =  ",
                  " AND prdw001 =  ",
 
                  #"",
                  
                  "",
                  " WHERE prdcent=? AND prdcsite=? AND prdc001=?"
      #add-point:b_fill段sql_before
       LET g_sql = "SELECT  UNIQUE prdcacti,prdc002,prdc003,prdc004,'',prdc001,prdcsite,prdcunit FROM prdc_t",          
                  "  INNER JOIN prdw_t ON prdwsite =prdcsite  AND prdwent=prdcent ",
                  "    AND prdw001 = prdc001",
                  " WHERE prdcent=? AND prdcsite=? AND prdc001=?"
      #LET g_sql =g_sql," AND prdcdocno IN (SELECT prdadocno FROM prda_t WHERE prda001='",g_prdw_m.prdw001,"' AND prda002=",g_prdw_m.prdw002,")"  #160905-00007#12 mark
      LET g_sql =g_sql," AND prdcdocno IN (SELECT prdadocno FROM prda_t WHERE prdaent = ",g_enterprise," AND prda001='",g_prdw_m.prdw001,"' AND prda002=",g_prdw_m.prdw002,")"  #160905-00007#12 add
      #end add-point
      IF NOT cl_null(g_wc2_table1) THEN
         LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY prdc_t.prdc002,prdc_t.prdc003,prdc_t.prdc004"
      
      #add-point:單身填充控制

      #end add-point
      
      PREPARE aprq551_pb FROM g_sql
      DECLARE b_fill_cs CURSOR FOR aprq551_pb
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs USING g_enterprise,g_prdw_m.prdwsite
                                               ,g_prdw_m.prdw001
 
                                               
      FOREACH b_fill_cs INTO g_prdc_d[l_ac].prdcacti,g_prdc_d[l_ac].prdc002,g_prdc_d[l_ac].prdc003,g_prdc_d[l_ac].prdc004, 
          g_prdc_d[l_ac].prdc004_desc,g_prdc_d[l_ac].prdc001,g_prdc_d[l_ac].prdcsite,g_prdc_d[l_ac].prdcunit 
 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充

         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  9035
               LET g_errparam.extend =  ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
            END IF
            EXIT FOREACH
         END IF
         
      END FOREACH
      LET g_error_show = 0
   
   END IF
   
   #判斷是否填充
   IF aprq551_fill_chk(2) THEN
      LET g_sql = "SELECT  UNIQUE prdhacti,prdh002,prdh000,prdh003,prdh005,prdh008,prdh009,'',prdh010, 
          prdh011,prdh012,prdh013,prdh004,prdh006,prdh007,prdh001,prdhsite,prdhunit FROM prdh_t",    
 
                  " INNER JOIN prdw_t ON prdwsite =  ",
                  " AND prdw001 =  ",
 
                  "",
                  
                  " WHERE prdhent=? AND prdhsite=? AND prdh001=?"   
      #add-point:b_fill段sql_before
      LET g_sql = "SELECT  UNIQUE prdhacti,prdh002,prdh000,prdh003,prdh005,prdh006,prdh008,prdh009,'',prdh010, 
          prdh011,prdh012,prdh013,prdh004,prdh007,prdh001,prdhsite,prdhunit FROM prdh_t",
                  " INNER JOIN prdw_t ON prdwsite = prdhsite AND prdwent=prdhent ",
                  "   AND prdw001 = prdh001 ",
                  " WHERE prdhent=? AND prdhsite=? AND prdh001=?"
      #LET g_sql =g_sql," AND prdhdocno IN (SELECT prdadocno FROM prda_t WHERE prda001='",g_prdw_m.prdw001,"' AND prda002=",g_prdw_m.prdw002,")"  #160905-00007#12 mark
      #LET g_sql =g_sql," AND prdcdocno IN (SELECT prdadocno FROM prda_t WHERE prdaent = ",g_enterprise," AND prda001='",g_prdw_m.prdw001,"' AND prda002=",g_prdw_m.prdw002,")"  #160905-00007#12 add  #160919-00062#2 dongsz mark
      LET g_sql =g_sql," AND prdhdocno IN (SELECT prdadocno FROM prda_t WHERE prdaent = ",g_enterprise," AND prda001='",g_prdw_m.prdw001,"' AND prda002=",g_prdw_m.prdw002,")"   #160919-00062#2 dongsz add      
      #end add-point
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY prdh_t.prdh002"
      
      #add-point:單身填充控制

      #end add-point
      
      PREPARE aprq551_pb2 FROM g_sql
      DECLARE b_fill_cs2 CURSOR FOR aprq551_pb2
      
      LET l_ac = 1
      
      OPEN b_fill_cs2 USING g_enterprise,g_prdw_m.prdwsite
                                               ,g_prdw_m.prdw001
 
                                               
      FOREACH b_fill_cs2 INTO g_prdc2_d[l_ac].prdhacti,g_prdc2_d[l_ac].prdh002,g_prdc2_d[l_ac].prdh000, 
          g_prdc2_d[l_ac].prdh003,g_prdc2_d[l_ac].prdh005,g_prdc2_d[l_ac].prdh006,g_prdc2_d[l_ac].prdh008, 
          g_prdc2_d[l_ac].prdh009,g_prdc2_d[l_ac].prdb005,g_prdc2_d[l_ac].prdh010,g_prdc2_d[l_ac].prdh011, 
          g_prdc2_d[l_ac].prdh012,g_prdc2_d[l_ac].prdh013,g_prdc2_d[l_ac].prdh004,g_prdc2_d[l_ac].prdh007, 
          g_prdc2_d[l_ac].prdh001,g_prdc2_d[l_ac].prdhsite,g_prdc2_d[l_ac].prdhunit
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充
         SELECT prdb005 INTO g_prdc2_d[l_ac].prdb005 FROM prdb_t
          WHERE prdbent = g_enterprise AND prdbdocno = l_prdadocno
            AND prdb004 = g_prdc2_d[l_ac].prdh002 AND rownum = 1
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = FALSE
            CALL cl_err()
 
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
   #判斷是否填充
   IF aprq551_fill_chk(3) THEN
      LET g_sql = "SELECT  UNIQUE prdgacti,prdg010,prdg002,prdg003,prdg004,'',prdg006,'',prdg007,prdg008, 
          prdg009,prdg001,prdgsite,prdgunit,prdg005 FROM prdg_t",   
                  " INNER JOIN prdw_t ON prdwsite =  ",
                  " AND prdw001 =  ",
 
                  "",
                  
                  " WHERE prdgent=? AND prdgsite=? AND prdg001=?"   
      #add-point:b_fill段sql_before
      LET g_sql = "SELECT  UNIQUE prdgacti,prdg010,prdg002,prdg003,prdg004,'',prdg006,'',prdg007,prdg008, 
          prdg009,prdg001,prdgsite,prdgunit,prdg005 FROM prdg_t",   
                  " INNER JOIN prdw_t ON prdwsite = prdgsite AND prdwent = prdgent ",
                  "   AND prdw001 = prdg001 ",
                  " WHERE prdgent=? AND prdgsite=? AND prdg001=?"  
      #LET g_sql =g_sql," AND prdgdocno IN (SELECT prdadocno FROM prda_t WHERE prda001='",g_prdw_m.prdw001,"' AND prda002=",g_prdw_m.prdw002,")"  #160905-00007#12 mark
      #LET g_sql =g_sql," AND prdcdocno IN (SELECT prdadocno FROM prda_t WHERE prdaent = ",g_enterprise," AND prda001='",g_prdw_m.prdw001,"' AND prda002=",g_prdw_m.prdw002,")"  #160905-00007#12 add #160919-00062#2 dongsz mark
      LET g_sql =g_sql," AND prdgdocno IN (SELECT prdadocno FROM prda_t WHERE prdaent = ",g_enterprise," AND prda001='",g_prdw_m.prdw001,"' AND prda002=",g_prdw_m.prdw002,")"  #160919-00062#2 dongsz add      
      
      #end add-point
      IF NOT cl_null(g_wc2_table3) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY prdg_t.prdg002,prdg_t.prdg003,prdg_t.prdg004"
      
      #add-point:單身填充控制

      #end add-point
      
      PREPARE aprq551_pb3 FROM g_sql
      DECLARE b_fill_cs3 CURSOR FOR aprq551_pb3
      
      LET l_ac = 1
      
      OPEN b_fill_cs3 USING g_enterprise,g_prdw_m.prdwsite
                                               ,g_prdw_m.prdw001
 
                                               
      FOREACH b_fill_cs3 INTO g_prdc3_d[l_ac].prdgacti,g_prdc3_d[l_ac].prdg010,g_prdc3_d[l_ac].prdg002, 
          g_prdc3_d[l_ac].prdg003,g_prdc3_d[l_ac].prdg004,g_prdc3_d[l_ac].prdg004_desc,g_prdc3_d[l_ac].prdg006, 
          g_prdc3_d[l_ac].prdg006_desc,g_prdc3_d[l_ac].prdg007,g_prdc3_d[l_ac].prdg008,g_prdc3_d[l_ac].prdg009, 
          g_prdc3_d[l_ac].prdg001,g_prdc3_d[l_ac].prdgsite,g_prdc3_d[l_ac].prdgunit,g_prdc3_d[l_ac].prdg005 
 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充

         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = FALSE
            CALL cl_err()
 
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
 
   
   #add-point:browser_fill段其他table處理
   LET g_sql = "SELECT  UNIQUE prdkacti,prdj003,prdk003,prdk005,'',prdk007,'',prdj005,prdj002 FROM prdj_t",   
                  " INNER JOIN prdk_t ON prdjdocno = prdkdocno AND prdj002=prdk002 AND prdj002=prdk003 ",
                  " WHERE prdjent=? AND prdjsite=? AND prdj001=? "   
      #add-point:b_fill段sql_before
      #LET g_sql =g_sql," AND prdkdocno IN (SELECT prdadocno FROM prda_t WHERE prda001='",g_prdw_m.prdw001,"' AND prda002=",g_prdw_m.prdw002,")"  #160905-00007#12 mark
      #LET g_sql =g_sql," AND prdcdocno IN (SELECT prdadocno FROM prda_t WHERE prdaent = ",g_enterprise," AND prda001='",g_prdw_m.prdw001,"' AND prda002=",g_prdw_m.prdw002,")"  #160905-00007#12 add #160919-00062#2 dongsz mark
      LET g_sql =g_sql," AND prdkdocno IN (SELECT prdadocno FROM prda_t WHERE prdaent = ",g_enterprise," AND prda001='",g_prdw_m.prdw001,"' AND prda002=",g_prdw_m.prdw002,")"   #160919-00062#2 dongsz add 
      
      #end add-point
      IF NOT cl_null(g_wc2_table4) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY prdj_t.prdj003,prdk_t.prdk003,prdk_t.prdk005"
      
      #add-point:單身填充控制

      #end add-point
      
      PREPARE aprq551_pb4 FROM g_sql
      DECLARE b_fill_cs4 CURSOR FOR aprq551_pb4
      
      LET l_ac = 1
      
      OPEN b_fill_cs4 USING g_enterprise,g_prdw_m.prdwsite,g_prdw_m.prdw001
 
                                               
      FOREACH b_fill_cs4 INTO g_prdc4_d[l_ac].prdkacti,g_prdc4_d[l_ac].prdj003,g_prdc4_d[l_ac].prdk003, 
          g_prdc4_d[l_ac].prdk005,g_prdc4_d[l_ac].prdk005_desc,g_prdc4_d[l_ac].prdk007,g_prdc4_d[l_ac].prdk007_desc, 
          g_prdc4_d[l_ac].prdj005,g_prdc4_d[l_ac].prdj002

         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充

         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = FALSE
            CALL cl_err()

            EXIT FOREACH
         END IF
         
      END FOREACH
   CALL g_prdc4_d.deleteElement(g_prdc4_d.getLength()) 
   FREE aprq551_pb4   

   #end add-point
   
   CALL g_prdc_d.deleteElement(g_prdc_d.getLength())
   CALL g_prdc2_d.deleteElement(g_prdc2_d.getLength())
   CALL g_prdc3_d.deleteElement(g_prdc3_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aprq551_pb
   FREE aprq551_pb2
 
   FREE aprq551_pb3
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="aprq551.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aprq551_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define
   
   #end add-point     
 
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point    
      DELETE FROM prdc_t
       WHERE prdcent = g_enterprise AND
         prdcdocno = ps_keys_bak[1] AND prdc002 = ps_keys_bak[2] AND prdc003 = ps_keys_bak[3] AND prdc004 = ps_keys_bak[4]
      #add-point:delete_b段刪除中
      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
      END IF
      #add-point:delete_b段刪除後
      
      #end add-point   
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point    
      DELETE FROM prdh_t
       WHERE prdhent = g_enterprise AND
         prdhdocno = ps_keys_bak[1] AND prdh002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中
      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "prdh_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
      END IF
      #add-point:delete_b段刪除後
      
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point    
      DELETE FROM prdg_t
       WHERE prdgent = g_enterprise AND
         prdgdocno = ps_keys_bak[1] AND prdg002 = ps_keys_bak[2] AND prdg003 = ps_keys_bak[3] AND prdg004 = ps_keys_bak[4]
      #add-point:delete_b段刪除中
      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "prdg_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
      END IF
      #add-point:delete_b段刪除後
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aprq551.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aprq551_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   #add-point:insert_b段define

   #end add-point     
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前

      #end add-point 
      INSERT INTO prdc_t
                  (prdcent,
                   prdc001,
                   prdcdocno,prdc002,prdc003,prdc004
                   ,prdcacti,prdc001,prdcsite,prdcunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_prdc_d[g_detail_idx].prdcacti,g_prdc_d[g_detail_idx].prdc001,g_prdc_d[g_detail_idx].prdcsite, 
                       g_prdc_d[g_detail_idx].prdcunit)
      #add-point:insert_b段資料新增中

      #end add-point 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "prdc_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
      END IF
      #add-point:insert_b段資料新增後

      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前

      #end add-point 
      INSERT INTO prdh_t
                  (prdhent,
                   prdh001,
                   prdhdocno,prdh002
                   ,prdhacti,prdh000,prdh003,prdh005,prdh008,prdh009,prdh010,prdh011,prdh012,prdh013,prdh004,prdh006,prdh007,prdh001,prdhsite,prdhunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_prdc2_d[g_detail_idx].prdhacti,g_prdc2_d[g_detail_idx].prdh000,g_prdc2_d[g_detail_idx].prdh003, 
                       g_prdc2_d[g_detail_idx].prdh005,g_prdc2_d[g_detail_idx].prdh008,g_prdc2_d[g_detail_idx].prdh009, 
                       g_prdc2_d[g_detail_idx].prdh010,g_prdc2_d[g_detail_idx].prdh011,g_prdc2_d[g_detail_idx].prdh012, 
                       g_prdc2_d[g_detail_idx].prdh013,g_prdc2_d[g_detail_idx].prdh004,g_prdc2_d[g_detail_idx].prdh006, 
                       g_prdc2_d[g_detail_idx].prdh007,g_prdc2_d[g_detail_idx].prdh001,g_prdc2_d[g_detail_idx].prdhsite, 
                       g_prdc2_d[g_detail_idx].prdhunit)
      #add-point:insert_b段資料新增中

      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "prdh_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
      END IF
      #add-point:insert_b段資料新增後

      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前

      #end add-point 
      INSERT INTO prdg_t
                  (prdgent,
                   prdg001,
                   prdgdocno,prdg002,prdg003,prdg004
                   ,prdgacti,prdg010,prdg006,prdg007,prdg008,prdg009,prdg001,prdgsite,prdgunit,prdg005) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_prdc3_d[g_detail_idx].prdgacti,g_prdc3_d[g_detail_idx].prdg010,g_prdc3_d[g_detail_idx].prdg006, 
                       g_prdc3_d[g_detail_idx].prdg007,g_prdc3_d[g_detail_idx].prdg008,g_prdc3_d[g_detail_idx].prdg009, 
                       g_prdc3_d[g_detail_idx].prdg001,g_prdc3_d[g_detail_idx].prdgsite,g_prdc3_d[g_detail_idx].prdgunit, 
                       g_prdc3_d[g_detail_idx].prdg005)
      #add-point:insert_b段資料新增中

      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "prdg_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
      END IF
      #add-point:insert_b段資料新增後

      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other

   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aprq551.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aprq551_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num5 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define

   #end add-point     
   
   #判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR
   
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prdc_t" THEN
      #add-point:update_b段修改前

      #end add-point     
      UPDATE prdc_t 
         SET (prdc001,prdc002,prdc003,prdc004
              ,prdcacti,prdc001,prdcsite,prdcunit) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_prdc_d[g_detail_idx].prdcacti,g_prdc_d[g_detail_idx].prdc001,g_prdc_d[g_detail_idx].prdcsite, 
                  g_prdc_d[g_detail_idx].prdcunit) 
         WHERE prdcent = g_enterprise AND prdcdocno = ps_keys_bak[1] AND prdc002 = ps_keys_bak[2] AND prdc003 = ps_keys_bak[3] AND prdc004 = ps_keys_bak[4]
      #add-point:update_b段修改中

      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "prdc_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "prdc_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後

      #end add-point  
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prdh_t" THEN
      #add-point:update_b段修改前

      #end add-point     
      UPDATE prdh_t 
         SET (prdh001,prdh002
              ,prdhacti,prdh000,prdh003,prdh005,prdh008,prdh009,prdh010,prdh011,prdh012,prdh013,prdh004,prdh006,prdh007,prdh001,prdhsite,prdhunit) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_prdc2_d[g_detail_idx].prdhacti,g_prdc2_d[g_detail_idx].prdh000,g_prdc2_d[g_detail_idx].prdh003, 
                  g_prdc2_d[g_detail_idx].prdh005,g_prdc2_d[g_detail_idx].prdh008,g_prdc2_d[g_detail_idx].prdh009, 
                  g_prdc2_d[g_detail_idx].prdh010,g_prdc2_d[g_detail_idx].prdh011,g_prdc2_d[g_detail_idx].prdh012, 
                  g_prdc2_d[g_detail_idx].prdh013,g_prdc2_d[g_detail_idx].prdh004,g_prdc2_d[g_detail_idx].prdh006, 
                  g_prdc2_d[g_detail_idx].prdh007,g_prdc2_d[g_detail_idx].prdh001,g_prdc2_d[g_detail_idx].prdhsite, 
                  g_prdc2_d[g_detail_idx].prdhunit) 
         WHERE prdhent = g_enterprise AND prdhdocno = ps_keys_bak[1] AND prdh002 = ps_keys_bak[2]
      #add-point:update_b段修改中

      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "prdh_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "prdh_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後

      #end add-point  
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prdg_t" THEN
      #add-point:update_b段修改前

      #end add-point     
      UPDATE prdg_t 
         SET (prdg001,prdg002,prdg003,prdg004
              ,prdgacti,prdg010,prdg006,prdg007,prdg008,prdg009,prdg001,prdgsite,prdgunit,prdg005) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_prdc3_d[g_detail_idx].prdgacti,g_prdc3_d[g_detail_idx].prdg010,g_prdc3_d[g_detail_idx].prdg006, 
                  g_prdc3_d[g_detail_idx].prdg007,g_prdc3_d[g_detail_idx].prdg008,g_prdc3_d[g_detail_idx].prdg009, 
                  g_prdc3_d[g_detail_idx].prdg001,g_prdc3_d[g_detail_idx].prdgsite,g_prdc3_d[g_detail_idx].prdgunit, 
                  g_prdc3_d[g_detail_idx].prdg005) 
         WHERE prdgent = g_enterprise AND prdgdocno = ps_keys_bak[1] AND prdg002 = ps_keys_bak[2] AND prdg003 = ps_keys_bak[3] AND prdg004 = ps_keys_bak[4]
      #add-point:update_b段修改中

      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "prdg_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "prdg_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後

      #end add-point  
   END IF
 
 
   
 
   
 
   
   #add-point:update_b段other

   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aprq551.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aprq551_lock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define

   #end add-point   
   
   #先刷新資料
   #CALL aprq551_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "prdc_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aprq551_bcl USING g_enterprise,
                                       g_prdw_m.prdwsite,g_prdw_m.prdw001,g_prdc_d[g_detail_idx].prdc001, 
                                           g_prdc_d[g_detail_idx].prdc002,g_prdc_d[g_detail_idx].prdc003, 
                                           g_prdc_d[g_detail_idx].prdc004     
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "aprq551_bcl"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "prdh_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aprq551_bcl2 USING g_enterprise,
                                             g_prdw_m.prdwsite,g_prdw_m.prdw001,g_prdc2_d[g_detail_idx].prdh001, 
                                                 g_prdc2_d[g_detail_idx].prdh002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "aprq551_bcl2"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "prdg_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aprq551_bcl3 USING g_enterprise,
                                             g_prdw_m.prdwsite,g_prdw_m.prdw001,g_prdc3_d[g_detail_idx].prdg001, 
                                                 g_prdc3_d[g_detail_idx].prdg002,g_prdc3_d[g_detail_idx].prdg003, 
                                                 g_prdc3_d[g_detail_idx].prdg004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "aprq551_bcl3"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         RETURN FALSE
      END IF
   END IF
 
 
   
 
   
   #add-point:lock_b段other
   LET ls_group = "prdk_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aprq551_bcl4 USING g_enterprise,
                                             g_prdw_m.prdwsite,g_prdw_m.prdw001,g_prdc4_d[g_detail_idx].prdk003,g_prdc4_d[g_detail_idx].prdk003,g_prdc4_d[g_detail_idx].prdk005,g_prdc4_d[g_detail_idx].prdj003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "aprq551_bcl4"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aprq551.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aprq551_unlock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define
   
   #end add-point  
   
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aprq551_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aprq551_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aprq551_bcl3
   END IF
 
 
   
 
 
   #add-point:unlock_b段other
   LET ls_group = "'4',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aprq551_bcl4
   END IF
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aprq551.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aprq551_set_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define
   
   #end add-point       
 
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("prdwsite,prdw001",TRUE)
      #add-point:set_entry段欄位控制
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後
   CALL cl_set_comp_entry("prdw029,prdw030,prdw031",true)
   CALL cl_set_comp_entry("prda000,prdw001",TRUE)
   CALL cl_set_comp_entry("prdaacti",TRUE)
   CALL cl_set_comp_entry("prdw001",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprq551.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aprq551_set_no_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define
   
   #end add-point     
 
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("prdwsite,prdw001",FALSE)
      #add-point:set_no_entry段欄位控制
      CALL cl_set_comp_entry("prdadocdt",FALSE)
      CALL cl_set_comp_entry("prda000,prdw001",FALSE)  
      #end add-point 
   END IF 
   
   #add-point:set_no_entry段欄位控制後
   IF g_prdw_m.prdw028='1' THEN
      CALL cl_set_comp_entry("prdw029,prdw030,prdw031",false)
   ELSE
               
   END IF 
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprq551.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aprq551_set_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define
   
   #end add-point     
   #add-point:set_entry_b段
   
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aprq551.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aprq551_set_no_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define
   
   #end add-point    
   #add-point:set_no_entry_b段
   
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aprq551.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aprq551_default_search()
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
      LET ls_wc = ls_wc, " prdwsite = '", g_argv[1], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " prdw001 = '", g_argv[02], "' AND "
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
 
{<section id="aprq551.state_change" >}
   #+ 此段落由子樣板a09產生
#+ 確認碼變更
PRIVATE FUNCTION aprq551_statechange()
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define
   DEFINE l_success LIKE type_t.num5
   DEFINE l_time    DATETIME YEAR TO SECOND
   #end add-point  
   
   #add-point:statechange段開始前
   IF g_prdw_m.prdwstus='Y' THEN
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_prdw_m.prdwsite IS NULL
      OR g_prdw_m.prdw001 IS NULL
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      RETURN
   END IF
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_prdw_m.prdwstus
            WHEN "N"
               HIDE OPTION "open"
            WHEN "X"
               HIDE OPTION "void"
            WHEN "Y"
               HIDE OPTION "valid"
            
         END CASE
     
      #add-point:menu前
      IF g_prdw_m.prdwstus <> 'N' THEN
         CALL cl_set_act_visible("invalid", FALSE)
      ELSE
         CALL cl_set_act_visible("invalid", FALSE)       
      END IF
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
#   LET l_success = TRUE
#   CALL s_transaction_begin()
#   IF lc_state = 'Y' THEN
#      CALL s_aprt211_conf_chk(g_prdw_m.prdadocno,g_prdw_m.prdwstus) RETURNING l_success,g_errno
#      IF NOT l_success THEN
#         CALL cl_err(g_prdw_m.prdadocno,g_errno,1)
#         CALL s_transaction_end('N','0')
#         RETURN
#      ELSE
#         IF NOT cl_ask_confirm('aim-00108') THEN
#            CALL s_transaction_end('N','0')
#            RETURN
#         ELSE
#            CALL s_aprt211_conf_upd(g_prdw_m.prdadocno,g_prdw_m.prdwstus) RETURNING l_success
#            IF NOT l_success THEN
#               CALL s_transaction_end('N','0')
#               RETURN
#            END IF
#         END IF
#      END IF
#   END IF
#   LET l_time = cl_get_current()
#   IF (lc_state = 'Y' AND g_prdw_m.prdwstus = 'X') OR lc_state = 'X' OR lc_state = 'N'  THEN
#      UPDATE prdw_t SET prdwmodid = g_user,
#                        prdwmoddt = l_time
#       WHERE prdwent = g_enterprise
#         AND prdadocno = g_prdw_m.prdadocno
#   END IF
   #end add-point
      
   UPDATE prdw_t SET prdwstus = lc_state 
    WHERE prdwent = g_enterprise AND prdwsite = g_prdw_m.prdwsite
      AND prdw001 = g_prdw_m.prdw001
  
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
      LET g_prdw_m.prdwstus = lc_state
      DISPLAY BY NAME g_prdw_m.prdwstus
   END IF
 
   #add-point:stus修改後
   IF NOT l_success THEN
      CALL s_transaction_end('N','0')
   ELSE
      CALL s_transaction_end('Y','0')
   END IF
   #end add-point
 
   #add-point:statechange段結束前
   
   #end add-point  
 
END FUNCTION
 
 
 
{</section>}
 
{<section id="aprq551.idx_chk" >}
#+ 單身筆數變更
PRIVATE FUNCTION aprq551_idx_chk()
   #add-point:idx_chk段define
   
   #end add-point  
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_prdc_d.getLength() THEN
         LET g_detail_idx = g_prdc_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prdc_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prdc_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_prdc2_d.getLength() THEN
         LET g_detail_idx = g_prdc2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prdc2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prdc2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_prdc3_d.getLength() THEN
         LET g_detail_idx = g_prdc3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prdc3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prdc3_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other
   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_prdc4_d.getLength() THEN
         LET g_detail_idx = g_prdc4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prdc4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prdc4_d.getLength() TO FORMONLY.cnt
   END IF
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aprq551.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aprq551_b_fill2(pi_idx)
   DEFINE pi_idx          LIKE type_t.num5
   DEFINE li_ac           LIKE type_t.num5
   DEFINE ls_chk          LIKE type_t.chr1
   #add-point:b_fill2段define
   
   #end add-point
   
   LET li_ac = l_ac 
   
 
      
   #add-point:單身填充後
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL aprq551_detail_show()
   
END FUNCTION
 
{</section>}
 
{<section id="aprq551.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aprq551_fill_chk(ps_idx)
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define
   
   #end add-point
   
   #add-point:fill_chk段before_chk
   
   #end add-point
 
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1')  AND 
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1')  AND 
      (cl_null(g_wc2_table3) OR g_wc2_table3.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk
      
      #end add-point
      RETURN TRUE
   END IF
   
   #第一單身
   IF ps_idx = 1 AND
      ((NOT cl_null(g_wc2_table1) AND g_wc2_table1.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF
   
   #根據wc判定是否需要填充
   IF ps_idx = 2 AND
      ((NOT cl_null(g_wc2_table2) AND g_wc2_table2.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF
 
   IF ps_idx = 3 AND
      ((NOT cl_null(g_wc2_table3) AND g_wc2_table3.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF
 
 
 
   RETURN FALSE
 
END FUNCTION
 
{</section>}
 
{<section id="aprq551.signature" >}
   
 
{</section>}
 
{<section id="aprq551.set_pk_array" >}
   #+ 此段落由子樣板a51產生
#+ 給予pk_array內容
PRIVATE FUNCTION aprq551_set_pk_array()
   #add-point:set_pk_array段define
   
   #end add-point
   
   #add-point:set_pk_array段之前
   
   #end add-point  
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_prdw_m.prdwsite
   LET g_pk_array[1].column = 'prdwsite'
   LET g_pk_array[2].values = g_prdw_m.prdw001
   LET g_pk_array[2].column = 'prdw001'
   
   #add-point:set_pk_array段之後
   
   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="aprq551.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="aprq551.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 單頭帶值欄位顯示
# Memo...........:
# Usage..........: CALL aprq551_desc()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/05/15 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprq551_desc()

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdw_m.prdwunit
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prdw_m.prdwunit_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdw_m.prdwunit_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdw_m.prdw006
   CALL ap_ref_array2(g_ref_fields,"SELECT prcfl003 FROM prcfl_t WHERE prcflent='"||g_enterprise||"' AND prcfl001=? AND prcfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prdw_m.prdw006_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdw_m.prdw006_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdw_m.prdw007
   CALL ap_ref_array2(g_ref_fields,"SELECT prcdl003 FROM prcdl_t WHERE prcdlent='"||g_enterprise||"' AND prcdl001=? AND prcdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prdw_m.prdw007_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdw_m.prdw007_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdw_m.prdw004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_prdw_m.prdw004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdw_m.prdw004_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdw_m.prdw005
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prdw_m.prdw005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdw_m.prdw005_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdw_m.prdw008
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '2100' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prdw_m.prdw008_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdw_m.prdw008_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdw_m.prdw009
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '2101' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prdw_m.prdw009_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdw_m.prdw009_desc
END FUNCTION

#display prdw006
PRIVATE FUNCTION aprq551_prdw006_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdw_m.prdw006
   CALL ap_ref_array2(g_ref_fields,"SELECT prcfl003 FROM prcfl_t WHERE prcflent='"||g_enterprise||"' AND prcfl001=? AND prcfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prdw_m.prdw006_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdw_m.prdw006_desc
END FUNCTION

#chk prdw006,prdw007
PRIVATE FUNCTION aprq551_chk_prdw006()
   DEFINE  l_cnt  LIKE type_t.num5
   LET g_errno = NULL
   LET l_cnt = 0
   IF NOT cl_null(g_prdw_m.prdw006) AND NOT cl_null(g_prdw_m.prdw007) THEN
      SELECT count(*) INTO l_cnt FROM prcf_t
       WHERE prcf001 = g_prdw_m.prdw006 AND prcf002 = g_prdw_m.prdw007
         AND prcfent = g_enterprise
      IF l_cnt<=0 THEN
         LET g_errno = "apr-00065"
      END IF      
   END IF
END FUNCTION

#create prcf006
PRIVATE FUNCTION aprq551_create_prdw006()
   SELECT prcf002,prcf007,prcf008
     INTO g_prdw_m.prdw007,g_prdw_m.prdw008,g_prdw_m.prdw009
     FROM prcf_t
    WHERE prcfent = g_enterprise AND prcf001 = g_prdw_m.prdw006
   CALL aprq551_prdw007_ref()
   CALL aprq551_prdw008_ref()
   CALL aprq551_prdw009_ref()
   DISPLAY BY NAME  g_prdw_m.prdw007,g_prdw_m.prdw008,g_prdw_m.prdw009  
END FUNCTION

#display prdw007
PRIVATE FUNCTION aprq551_prdw007_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdw_m.prdw007
   CALL ap_ref_array2(g_ref_fields,"SELECT prcdl003 FROM prcdl_t WHERE prcdlent='"||g_enterprise||"' AND prcdl001=? AND prcdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prdw_m.prdw007_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdw_m.prdw007_desc
   SELECT prcd004,prcd005
     INTO g_prdw_m.prdd003,g_prdw_m.prdd004
     FROM prcd_t
    WHERE prcdent = g_enterprise AND prcd001 = g_prdw_m.prdw007
   DISPLAY BY NAME  g_prdw_m.prdd003,g_prdw_m.prdd004
END FUNCTION

#display prdw004
PRIVATE FUNCTION aprq551_prdw004_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdw_m.prdw004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_prdw_m.prdw004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdw_m.prdw004_desc
   
END FUNCTION

#display prdw005
PRIVATE FUNCTION aprq551_prdw005_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdw_m.prdw005
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prdw_m.prdw005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdw_m.prdw005_desc
END FUNCTION

#display prdw008
PRIVATE FUNCTION aprq551_prdw008_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdw_m.prdw008
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2100' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prdw_m.prdw008_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdw_m.prdw008_desc
END FUNCTION

#display prdw009
PRIVATE FUNCTION aprq551_prdw009_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdw_m.prdw009
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2101' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prdw_m.prdw009_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdw_m.prdw009_desc
END FUNCTION

#display prdw008,prdw009
PRIVATE FUNCTION aprq551_create_prdw007()
   IF cl_null(g_prdw_m.prdw006) THEN
      SELECT prcd002,prcd003
        INTO g_prdw_m.prdw008,g_prdw_m.prdw009
        FROM prcd_t
       WHERE prcdent = g_enterprise AND prcd001 = g_prdw_m.prdw007
      CALL aprq551_prdw008_ref()
      CALL aprq551_prdw009_ref()
      DISPLAY BY NAME  g_prdw_m.prdw007,g_prdw_m.prdw008,g_prdw_m.prdw009  
   END IF
   
END FUNCTION

#create prdw005
PRIVATE FUNCTION aprq551_create_prdw004()
   SELECT ooag003 INTO g_prdw_m.prdw005
     FROM ooag_t
    WHERE ooagent = g_enterprise AND ooag001 = g_prdw_m.prdw004
   DISPLAY BY NAME g_prdw_m.prdw005 
   CALL aprq551_prdw005_ref()   
END FUNCTION

#chk prdw004,prdw005
PRIVATE FUNCTION aprq551_chk_prdw004()
   DEFINE l_cnt  LIKE type_t.num5
   LET g_errno = NULL
   LET l_cnt = 0
   IF NOT cl_null(g_prdw_m.prdw004) AND NOT cl_null(g_prdw_m.prdw005) THEN
      SELECT count(*) INTO l_cnt FROM ooag_t
       WHERE ooagent = g_enterprise AND ooag001 = g_prdw_m.prdw004
         AND ooag003 = g_prdw_m.prdw005
      IF l_cnt<=0 THEN
         LET g_errno="apr-00307"
      END IF      
   END IF       
END FUNCTION

#display prdc004
PRIVATE FUNCTION aprq551_prdc004_ref()
   IF g_prdc_d[l_ac].prdc003 = '1' THEN #客戶編號
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdc_d[l_ac].prdc004
         CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdc_d[l_ac].prdc004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdc_d[l_ac].prdc004_desc
      END IF
      
      IF g_prdc_d[l_ac].prdc003 = '2' THEN #客戶分類
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdc_d[l_ac].prdc004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='281' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdc_d[l_ac].prdc004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdc_d[l_ac].prdc004_desc
      END IF 
      
      IF g_prdc_d[l_ac].prdc003 = '3' THEN 
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdc_d[l_ac].prdc004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2061' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdc_d[l_ac].prdc004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdc_d[l_ac].prdc004_desc
      END IF
      
      IF g_prdc_d[l_ac].prdc003 = '4' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdc_d[l_ac].prdc004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2062' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdc_d[l_ac].prdc004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdc_d[l_ac].prdc004_desc
      END IF     

      IF g_prdc_d[l_ac].prdc003 = '5' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdc_d[l_ac].prdc004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2063' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdc_d[l_ac].prdc004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdc_d[l_ac].prdc004_desc
      END IF  
      
      IF g_prdc_d[l_ac].prdc003 = '6' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdc_d[l_ac].prdc004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2064' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdc_d[l_ac].prdc004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdc_d[l_ac].prdc004_desc
      END IF  
      
      IF g_prdc_d[l_ac].prdc003 = '7' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdc_d[l_ac].prdc004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2065' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdc_d[l_ac].prdc004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdc_d[l_ac].prdc004_desc
      END IF  
      
      IF g_prdc_d[l_ac].prdc003 = '8' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdc_d[l_ac].prdc004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2066' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdc_d[l_ac].prdc004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdc_d[l_ac].prdc004_desc
      END IF  
      
      IF g_prdc_d[l_ac].prdc003 = '9' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdc_d[l_ac].prdc004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2067' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdc_d[l_ac].prdc004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdc_d[l_ac].prdc004_desc
      END IF  
      
      
      IF g_prdc_d[l_ac].prdc003 = '10' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdc_d[l_ac].prdc004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2068' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdc_d[l_ac].prdc004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdc_d[l_ac].prdc004_desc
      END IF  
      
      IF g_prdc_d[l_ac].prdc003 = '11' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdc_d[l_ac].prdc004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2069' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdc_d[l_ac].prdc004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdc_d[l_ac].prdc004_desc
      END IF  
      
      IF g_prdc_d[l_ac].prdc003 = '12' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdc_d[l_ac].prdc004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2070' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdc_d[l_ac].prdc004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdc_d[l_ac].prdc004_desc
      END IF  
END FUNCTION

#set prdh entry
PRIVATE FUNCTION aprq551_set_prdh_entry()
   CALL cl_set_comp_entry("prdh005,prdh003",true)
   CALL cl_set_comp_required("prdh005",true)
   
   IF g_prdc2_d[l_ac].prdh003='0' THEN
      CALL cl_set_comp_entry("prdh005",false)
   ELSE
      CALL cl_set_comp_entry("prdh005",TRUE)            
   END IF
   IF g_prdc2_d[l_ac].prdh009='4' THEN
      CALL cl_set_comp_entry("prdb005",false)
      CALL cl_set_comp_required("prdb005",false)
   ELSE
      CALL cl_set_comp_required("prdb005",true)   
   END IF
   IF (g_prdc2_d[l_ac].prdh000='1')  THEN
      CALL cl_set_comp_entry("prdh003,prdh008",false)
   ELSE
      CALL cl_set_comp_entry("prdh003,prdh008",TRUE)   
   END IF
   
END FUNCTION

##chk prdh005
PRIVATE FUNCTION aprq551_chk_prdh005()
   DEFINE l_cnt  LIKE type_t.num5
   LET l_cnt=0
   LET g_errno = NULL
   IF g_prdc2_d[l_ac].prdh009='2' OR g_prdc2_d[l_ac].prdh009='5' THEN
      IF g_prdc2_d[l_ac].prdb005>100 THEN
         LET g_errno = "apr-00308"
      END IF
   END IF
END FUNCTION

##display prdg
PRIVATE FUNCTION aprq551_prdg_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdc3_d[l_ac].prdg006
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prdc3_d[l_ac].prdg006_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdc3_d[l_ac].prdg006_desc
   
   IF g_prdc3_d[l_ac].prdg003 = '4' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdc3_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdc3_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdc3_d[l_ac].prdg004_desc
   END IF
   IF g_prdc3_d[l_ac].prdg003 = '5' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdc3_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdc3_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdc3_d[l_ac].prdg004_desc
   END IF
   IF g_prdc3_d[l_ac].prdg003 = '6' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdc3_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2000' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdc3_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdc3_d[l_ac].prdg004_desc
   END IF
   IF g_prdc3_d[l_ac].prdg003 = '7' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdc3_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2001' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdc3_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdc3_d[l_ac].prdg004_desc
   END IF
   IF g_prdc3_d[l_ac].prdg003 = '8' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdc3_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2002' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdc3_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdc3_d[l_ac].prdg004_desc
   END IF
   IF g_prdc3_d[l_ac].prdg003 = '9' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdc3_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2003' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdc3_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdc3_d[l_ac].prdg004_desc
   END IF
   IF g_prdc3_d[l_ac].prdg003 = 'A' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdc3_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2004' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdc3_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdc3_d[l_ac].prdg004_desc
   END IF
   IF g_prdc3_d[l_ac].prdg003 = 'B' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdc3_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2005' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdc3_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdc3_d[l_ac].prdg004_desc
   END IF
   IF g_prdc3_d[l_ac].prdg003 = 'C' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdc3_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2006' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdc3_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdc3_d[l_ac].prdg004_desc
   END IF
   IF g_prdc3_d[l_ac].prdg003 = 'D' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdc3_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2007' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdc3_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdc3_d[l_ac].prdg004_desc
   END IF
   IF g_prdc3_d[l_ac].prdg003 = 'E' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdc3_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2008' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdc3_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdc3_d[l_ac].prdg004_desc
   END IF
   IF g_prdc3_d[l_ac].prdg003 = 'F' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdc3_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2009' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdc3_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdc3_d[l_ac].prdg004_desc
   END IF
   IF g_prdc3_d[l_ac].prdg003 = 'G' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdc3_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2010' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdc3_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdc3_d[l_ac].prdg004_desc
   END IF
   IF g_prdc3_d[l_ac].prdg003 = 'H' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdc3_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2011' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdc3_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdc3_d[l_ac].prdg004_desc
   END IF
   IF g_prdc3_d[l_ac].prdg003 = 'I' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdc3_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2012' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdc3_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdc3_d[l_ac].prdg004_desc
   END IF
   IF g_prdc3_d[l_ac].prdg003 = 'J' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdc3_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2013' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdc3_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdc3_d[l_ac].prdg004_desc
   END IF
   IF g_prdc3_d[l_ac].prdg003 = 'K' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdc3_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2014' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdc3_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdc3_d[l_ac].prdg004_desc
   END IF
   IF g_prdc3_d[l_ac].prdg003 = 'L' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdc3_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2015' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdc3_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdc3_d[l_ac].prdg004_desc
   END IF
END FUNCTION

##chk prdg004
PRIVATE FUNCTION aprq551_chk_prdg004()
      IF g_prdc3_d[l_ac].prdg003 = '4' THEN
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
      #160318-00025#15 by 07900 --add-str 
       LET g_errshow = TRUE #是否開窗
      #160318-00025#15 by 07900 --add-end
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_prdc3_d[l_ac].prdg004
      #160318-00025#15 by 07900 --add-str 
       LET g_chkparam.err_str[1] ="aim-00002:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"
       LET g_chkparam.err_str[2] ="aim-00121:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"
      #160318-00025#15 by 07900 --add-end 
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_imaa001_5") THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdc3_d[l_ac].prdg003 = '5' THEN
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
      #160318-00025#15 by 07900 --add-str 
       LET g_errshow = TRUE #是否開窗
      #160318-00025#15 by 07900 --add-end
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_prdc3_d[l_ac].prdg004
      #160318-00025#15 by 07900 --add-str 
       LET g_chkparam.err_str[1] ="anm-00081:sub-01302|aimi010|",cl_get_progname("aimi010",g_lang,"2"),"|:EXEPROGaimi010"
       #160318-00025#15 by 07900 --add-end  
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_rtax001_1") THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdc3_d[l_ac].prdg003 = '6' THEN
      IF NOT s_azzi650_chk_exist('2000',g_prdc3_d[l_ac].prdg004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdc3_d[l_ac].prdg003 = '7' THEN
      IF NOT s_azzi650_chk_exist('2001',g_prdc3_d[l_ac].prdg004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdc3_d[l_ac].prdg003 = '8' THEN
      IF NOT s_azzi650_chk_exist('2002',g_prdc3_d[l_ac].prdg004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdc3_d[l_ac].prdg003 = '9' THEN
      IF NOT s_azzi650_chk_exist('2003',g_prdc3_d[l_ac].prdg004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdc3_d[l_ac].prdg003 = 'A' THEN
      IF NOT s_azzi650_chk_exist('2004',g_prdc3_d[l_ac].prdg004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdc3_d[l_ac].prdg003 = 'B' THEN
      IF NOT s_azzi650_chk_exist('2005',g_prdc3_d[l_ac].prdg004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdc3_d[l_ac].prdg003 = 'C' THEN
      IF NOT s_azzi650_chk_exist('2006',g_prdc3_d[l_ac].prdg004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdc3_d[l_ac].prdg003 = 'D' THEN
      IF NOT s_azzi650_chk_exist('2007',g_prdc3_d[l_ac].prdg004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdc3_d[l_ac].prdg003 = 'E' THEN
      IF NOT s_azzi650_chk_exist('2008',g_prdc3_d[l_ac].prdg004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdc3_d[l_ac].prdg003 = 'F' THEN
      IF NOT s_azzi650_chk_exist('2009',g_prdc3_d[l_ac].prdg004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdc3_d[l_ac].prdg003 = 'G' THEN
      IF NOT s_azzi650_chk_exist('2010',g_prdc3_d[l_ac].prdg004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdc3_d[l_ac].prdg003 = 'H' THEN
      IF NOT s_azzi650_chk_exist('2011',g_prdc3_d[l_ac].prdg004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdc3_d[l_ac].prdg003 = 'I' THEN
      IF NOT s_azzi650_chk_exist('2012',g_prdc3_d[l_ac].prdg004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdc3_d[l_ac].prdg003 = 'J' THEN
      IF NOT s_azzi650_chk_exist('2013',g_prdc3_d[l_ac].prdg004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdc3_d[l_ac].prdg003 = 'K' THEN
      IF NOT s_azzi650_chk_exist('2014',g_prdc3_d[l_ac].prdg004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdc3_d[l_ac].prdg003 = 'L' THEN
      IF NOT s_azzi650_chk_exist('2015',g_prdc3_d[l_ac].prdg004) THEN
         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

##display prdg004,prdg005
PRIVATE FUNCTION aprq551_prdg004_ref()
   #150312-00002#5 Modify-S By Ken 150317
   #SELECT rtdx002,rtdx033 INTO g_prdc3_d[l_ac].prdg005,g_prdc3_d[l_ac].prdg006
   #  FROM rtdx_t
   # WHERE rtdxent = g_enterprise
   #   AND rtdxsite = g_site
   #   AND rtdx001 = g_prdc3_d[l_ac].prdg004
   SELECT rtdx002,imaa106 INTO g_prdc3_d[l_ac].prdg005,g_prdc3_d[l_ac].prdg006
     FROM rtdx_t,imaa_t
    WHERE rtdxent  = imaaent
      AND rtdx001  = imaa001
      AND rtdxent  = g_enterprise
      AND rtdxsite = g_site
      AND rtdx001  = g_prdc3_d[l_ac].prdg004   
   #150312-00002#5 Modify-E   
   CALL aprq551_prdg_desc()
END FUNCTION

#chk prdk005
PRIVATE FUNCTION aprq551_prdk005_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdc4_d[l_ac].prdk005
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prdc4_d[l_ac].prdk005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdc4_d[l_ac].prdk005_desc
   
   #150312-00002#5 Modify-S By Ken 150317
   #SELECT rtdx033 INTO g_prdc4_d[l_ac].prdk007
   #  FROM rtdx_t
   # WHERE rtdxent = g_enterprise AND rtdx001 =  g_prdc4_d[l_ac].prdk005
   SELECT imaa106 INTO g_prdc4_d[l_ac].prdk007
     FROM imaa_t
    WHERE imaaent = g_enterprise AND imaa001 =  g_prdc4_d[l_ac].prdk005
   #150312-00002#5 Modify-E 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdc4_d[l_ac].prdk007
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prdc4_d[l_ac].prdk007_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdc4_d[l_ac].prdk007_desc   
END FUNCTION

 
{</section>}
 
