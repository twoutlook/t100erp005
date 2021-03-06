#該程式已解開Section, 不再透過樣板產出!
{<section id="aprq211.description" >}
#+ Version..: T100-ERP-1.00.00(版次:1) Build-000057
#+ 
#+ Filename...: aprq211
#+ Description: 一般促銷規則查詢作業
#+ Creator....: 02482(2014/03/31)
#+ Modifier...: 02482(2014/04/01)
#+ Buildtype..: 應用 t01 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="aprq211.global" >}
#160318-00005#39  2016/03/30    By 07900     重复错误讯息修改
#160318-00025#31  2016/04/11    By 07959     重复错误讯息修改
#160905-00007#12  2016/09/05    by 08742     调整系统中无ENT的SQL条件增加ent
#161108-00016#1   2016/11/09    by 08742     修改 g_browser_cnt 定义大小
#161111-00028#2   2016/11/11    BY 02481     标准程式定义采用宣告模式,弃用.*写法
#160819-00054#42  2016/11/15    By 02749     prdg003(屬性)增加清單項目:15
#161117-00005#1   2016/11/22    By 02749     修正查詢後array虛增筆數顯示問題
    
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
   prdw010 LIKE prdw_t.prdw010, 
   prdw011 LIKE prdw_t.prdw011, 
   prdw012 LIKE prdw_t.prdw012, 
   prdw013 LIKE prdw_t.prdw013, 
   prdw024 LIKE prdw_t.prdw024, 
   prdw025 LIKE prdw_t.prdw025, 
   prdw026 LIKE prdw_t.prdw026, 
   prdd003_1 LIKE type_t.dat, 
   prdd004_1 LIKE type_t.dat, 
   prdw098 LIKE prdw_t.prdw098, 
   prdw004 LIKE prdw_t.prdw004, 
   prdw004_desc LIKE type_t.chr80, 
   prdw005 LIKE prdw_t.prdw005, 
   prdw005_desc LIKE type_t.chr80, 
   prdb005_1 LIKE type_t.num20_6, 
   prdd005_1 LIKE type_t.chr8, 
   prdd006_1 LIKE type_t.chr8, 
   prdw003 LIKE prdw_t.prdw003, 
   prdw033 LIKE prdw_t.prdw033, 
   prdw033_desc LIKE type_t.chr80, 
   prdw008 LIKE prdw_t.prdw008, 
   prdw008_desc LIKE type_t.chr80, 
   prdw009 LIKE prdw_t.prdw009, 
   prdw009_desc LIKE type_t.chr80, 
   prdb005_2 LIKE type_t.num20_6, 
   prdd007_1 LIKE type_t.chr10, 
   prdd008_1 LIKE type_t.chr1, 
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
   prdw037   LIKE prdw_t.prdw037,
   prdw034   LIKE prdw_t.prdw034,           #151204-00007#14 add prdw034
   prdw038   LIKE prdw_t.prdw038,
   prdw042   LIKE prdw_t.prdw042
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_prde_d        RECORD
       prde002 LIKE prde_t.prde002, 
   prdeacti LIKE prde_t.prdeacti, 
   prde003 LIKE prde_t.prde003, 
   prde004 LIKE prde_t.prde004, 
   prde004_desc LIKE type_t.chr500, 
   prdesite LIKE prde_t.prdesite, 
   prdeunit LIKE prde_t.prdeunit
       END RECORD
PRIVATE TYPE type_g_prde2_d RECORD
       prdgacti LIKE prdg_t.prdgacti, 
   prdg002 LIKE prdg_t.prdg002,
   prdg011  LIKE prdg_t.prdg011,   
   prdg003 LIKE prdg_t.prdg003, 
   prdg004 LIKE prdg_t.prdg004, 
   prdg004_desc LIKE type_t.chr500, 
   prdg005 LIKE prdg_t.prdg005, 
   prdg006 LIKE prdg_t.prdg006, 
   prdg006_desc LIKE type_t.chr500, 
   prdg007 LIKE prdg_t.prdg007, 
   prdgsite LIKE prdg_t.prdgsite, 
   prdgunit LIKE prdg_t.prdgunit,
   prdg010  LIKE prdg_t.prdg010
       END RECORD
PRIVATE TYPE type_g_prde3_d RECORD
       prdfacti LIKE prdf_t.prdfacti, 
   prdf003 LIKE prdf_t.prdf003, 
   prdf003_desc LIKE type_t.chr500, 
   prdf004 LIKE prdf_t.prdf004, 
   prdf004_desc LIKE type_t.chr500, 
   prdf002 LIKE prdf_t.prdf002, 
   prdfsite LIKE prdf_t.prdfsite, 
   prdfunit LIKE prdf_t.prdfunit
       END RECORD
PRIVATE TYPE type_g_prde4_d RECORD
       prddacti LIKE prdd_t.prddacti, 
   prdd002 LIKE prdd_t.prdd002, 
   prdd003 LIKE prdd_t.prdd003, 
   prdd004 LIKE prdd_t.prdd004, 
   prdd005 LIKE prdd_t.prdd005, 
   prdd006 LIKE prdd_t.prdd006, 
   prdd007 LIKE prdd_t.prdd007, 
   prdd008 LIKE prdd_t.prdd008, 
   prddsite LIKE prdd_t.prddsite, 
   prddunit LIKE prdd_t.prddunit
       END RECORD
 
 
#模組變數(Module Variables)
DEFINE g_prdw_m          type_g_prdw_m
DEFINE g_prdw_m_t        type_g_prdw_m
 
   DEFINE g_prdwsite_t LIKE prdw_t.prdwsite
DEFINE g_prdw001_t LIKE prdw_t.prdw001
 
 
DEFINE g_prde_d          DYNAMIC ARRAY OF type_g_prde_d
DEFINE g_prde_d_t        type_g_prde_d
DEFINE g_prde2_d   DYNAMIC ARRAY OF type_g_prde2_d
DEFINE g_prde2_d_t type_g_prde2_d
DEFINE g_prde3_d   DYNAMIC ARRAY OF type_g_prde3_d
DEFINE g_prde3_d_t type_g_prde3_d
DEFINE g_prde4_d   DYNAMIC ARRAY OF type_g_prde4_d
DEFINE g_prde4_d_t type_g_prde4_d
 
 
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
      b_prdw027 LIKE prdw_t.prdw027,
      b_prdw099 LIKE prdw_t.prdw099,
      b_prdw100 DATETIME YEAR TO SECOND
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
      b_prdw027 LIKE prdw_t.prdw027,
      b_prdw099 LIKE prdw_t.prdw099,
      b_prdw100 DATETIME YEAR TO SECOND
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
 
DEFINE g_wc2_table4   STRING
 
 
 
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
DEFINE l_prdadocno           LIKE prda_t.prdadocno
DEFINE l_prda024             LIKE prda_t.prda024
DEFINE g_wc2_table5          STRING
DEFINE g_wc2_table6          STRING

 TYPE type_g_prde5_d RECORD
   prdbacti LIKE prdb_t.prdbacti, 
   prdb004  LIKE prdb_t.prdb004, 
   prdb002  LIKE prdb_t.prdb002, 
   prdb003  LIKE prdb_t.prdb003, 
   prdb005  LIKE prdb_t.prdb005
       END RECORD
       
 TYPE type_g_prde6_d RECORD
   prdcacti      LIKE prdc_t.prdcacti, 
   prdc003       LIKE prdc_t.prdc003, 
   prdc004       LIKE prdc_t.prdc004, 
   prdc004_desc  LIKE type_t.chr500
       END RECORD       
       
DEFINE g_prde5_d   DYNAMIC ARRAY OF type_g_prde5_d
DEFINE g_prde6_d   DYNAMIC ARRAY OF type_g_prde6_d
DEFINE l_exeprog   LIKE type_t.chr80               #160318-00005#39  By 07900 --add  
#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="aprq211.main" >}
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
       '',prdw007,'',prdw027,prdwstus,prdw010,prdw011,prdw012,prdw013,prdw024,prdw025,prdw026,'','', 
       prdw098,prdw004,'',prdw005,'','','','',prdw003,prdw008,'',prdw009,'','','','',prdwcrtid,'',prdwcrtdp, 
       '',prdwcrtdt,prdwownid,'',prdwowndp,'',prdwmodid,'',prdwmoddt,prdwcnfid,'',prdwcnfdt FROM prdw_t  
       WHERE prdwent= ?  AND prdwsite = ? AND prdw001=? FOR UPDATE"
   #add-point:SQL_define
   LET g_forupd_sql = "SELECT prdwunit,'',prdwsite,'',prdw099,'',prdw001,prdw002,'',prdw100,prdw006, 
       '',prdw007,'',prdw027,prdwstus,prdw010,prdw011,prdw012,prdw013,prdw024,prdw025,prdw026,'','', 
       prdw098,prdw004,'',prdw005,'','','','',prdw003,prdw033,prdw008,'',prdw009,'','','','',prdwcrtid,'',prdwcrtdp, 
       '',prdwcrtdt,prdwownid,'',prdwowndp,'',prdwmodid,'',prdwmoddt,prdwcnfid,'',prdwcnfdt FROM prdw_t  
       WHERE prdwent= ?  AND prdwsite = ? AND prdw001=? FOR UPDATE"
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   DECLARE aprq211_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call

      #end add-point
 
   ELSE
      
      #畫面開啟 (identifier)
      OPEN WINDOW w_aprq211 WITH FORM cl_ap_formpath("apr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aprq211_init()   
 
      #進入選單 Menu (="N")
      CALL aprq211_ui_dialog() 
	  
      #add-point:畫面關閉前

      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aprq211
      
   END IF 
   
   CLOSE aprq211_cl
   
   
 
   #add-point:作業離開前

   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="aprq211.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aprq211_init()
   #add-point:init段define

   #end add-point    
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_error_show  = 1
   LET l_ac = 1
      CALL cl_set_combo_scc_part('prdwstus','50','N,X,Y')
 
      CALL cl_set_combo_scc('prdw024','6564') 
   CALL cl_set_combo_scc('prdw025','6565') 
   CALL cl_set_combo_scc('prdw026','6566') 
   CALL cl_set_combo_scc('prde003','6560') 
   CALL cl_set_combo_scc('prdg003','6517') 
   CALL cl_set_combo_scc('prdg011','6761')
   CALL cl_set_combo_scc('prdd007','6520') 
   CALL cl_set_combo_scc('prdd008','30') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
 
   #add-point:畫面資料初始化
   CALL cl_set_comp_visible('prdb004',FALSE)
   CALL cl_set_combo_scc('prdb003','6567')
   CALL aprq211_prdc003_display()
   CALL cl_set_combo_scc('prdd007_1','6520') 
   CALL cl_set_combo_scc('prdd008_1','30') 
   CALL cl_set_combo_scc('b_prdw000','32') 
   CALL cl_set_combo_scc_part('prdw024','6564','2,3') 
   CALL cl_set_combo_scc_part('prdg003','6517','4,5,6,7,8,9,14,A,B,C,D,E,F,G,H,I,J,K,L,15')   #160819-00054#42 161115 by lori add:15
   CALL aprq211_set_comp_visible()
   CALL aprq211_set_comp_att_text()
        
   #end add-point
   
   CALL aprq211_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aprq211.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aprq211_ui_dialog()
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
   
      CALL aprq211_browser_fill("")
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
               
               CALL aprq211_fetch('') # reload data
               LET l_ac = 1
               CALL aprq211_ui_detailshow() #Setting the current row 
      
               CALL aprq211_idx_chk()
               #NEXT FIELD prde002
         
         END DISPLAY
        
         DISPLAY ARRAY g_prde_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               CALL aprq211_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               
               #add-point:page1, before row動作

               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               CALL aprq211_idx_chk()
               #add-point:page1自定義行為

               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為

            #end add-point
               
         END DISPLAY
        
         DISPLAY ARRAY g_prde2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               CALL aprq211_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               
               #add-point:page2, before row動作

               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               CALL aprq211_idx_chk()
               #add-point:page2自定義行為

               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為

            #end add-point
         
         END DISPLAY
         DISPLAY ARRAY g_prde3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               CALL aprq211_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               
               #add-point:page3, before row動作

               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               CALL aprq211_idx_chk()
               #add-point:page3自定義行為

               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為

            #end add-point
         
         END DISPLAY
         DISPLAY ARRAY g_prde4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               CALL aprq211_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx = l_ac
               
               #add-point:page4, before row動作

               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_current_page = 4
               CALL aprq211_idx_chk()
               #add-point:page4自定義行為

               #end add-point
      
            #自訂ACTION(detail_show,page_4)
            
         
            #add-point:page4自定義行為

            #end add-point
         
         END DISPLAY
 
         
         #add-point:ui_dialog段自定義display array
         DISPLAY ARRAY g_prde5_d TO s_detail5.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               CALL aprq211_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_detail_idx = l_ac
               IF g_prde5_d[g_detail_idx].prdb003 = '2' THEN
                  CALL aprq211_prdc003_display()                     
               END IF
               IF g_prde5_d[g_detail_idx].prdb003 = '3' THEN
                  CALL cl_set_combo_scc('prdc003','6035')
               END IF   
               CALL aprq211_b6_fill()               

               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_current_page = 5
               CALL aprq211_idx_chk()

         
         END DISPLAY
         
         DISPLAY ARRAY g_prde6_d TO s_detail6.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               CALL aprq211_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
               LET g_detail_idx = l_ac
               

               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
               LET g_current_page = 6
               CALL aprq211_idx_chk()

         
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
               CALL aprq211_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aprq211_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aprq211_idx_chk()
            
            #add-point:ui_dialog段before_dialog2

            #end add-point
            
            IF lb_first THEN
               LET lb_first = FALSE
               NEXT FIELD prde002
            END IF
        
         ON ACTION statechange
            CALL aprq211_statechange()
            LET g_action_choice = "statechange"
            EXIT DIALOG
      
         
          
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL aprq211_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
 
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL aprq211_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "-100"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
 
                  CLEAR FORM
               ELSE
                  CALL aprq211_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
          
         #ACTION表單列
         ON ACTION filter
            CALL aprq211_filter()
            EXIT DIALOG
         
         ON ACTION first
            CALL aprq211_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprq211_idx_chk()
            
         ON ACTION previous
            CALL aprq211_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprq211_idx_chk()
            
         ON ACTION jump
            CALL aprq211_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprq211_idx_chk()
            
         ON ACTION next
            CALL aprq211_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprq211_idx_chk()
            
         ON ACTION last
            CALL aprq211_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprq211_idx_chk()
            
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
    
         
 
         ON ACTION object
 
            LET g_action_choice="object"
            IF cl_auth_chk_act("object") THEN 
               #add-point:ON ACTION object
#               IF NOT cl_null(g_prdw_m.prdw001) THEN
#                  IF g_prdw_m.prdw026 = '4' THEN
#                     CALL aprm211_01(g_prdw_m.prdw001,'N','N')
#                  END IF
#               END IF
#               LET  g_action_choice=''
               SELECT prdadocno,prda024 
                 INTO l_prdadocno,l_prda024
                 FROM prda_t
                WHERE prda001 = g_prdw_m.prdw001 AND prda002 = g_prdw_m.prdw002
                  AND prdaent = g_enterprise                
               IF NOT cl_null(l_prdadocno) THEN
                  IF g_prdw_m.prdw026 = '4' THEN
                     CALL aprt211_01(l_prdadocno,l_prda024,g_prdw_m.prdw001,'N','N')
                  ELSE
                     CALL aprt211_01(l_prdadocno,l_prda024,g_prdw_m.prdw001,'N','N')
                  END IF
               END IF
               LET  g_action_choice=''
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
               CALL aprq211_query()
               #add-point:ON ACTION query
               #防呆處理,避免虛增筆數
               EXIT DIALOG   #161117-00005#1 161122 by lori add
               #END add-point
            END IF
 
         
         #+ 此段落由子樣板a46產生
         #新增相關文件
         ON ACTION related_document
            CALL g_pk_array.clear()
            LET g_pk_array[1].values = g_prdw_m.prdwsite
            LET g_pk_array[1].column = 'prdwsite'
            LET g_pk_array[2].values = g_prdw_m.prdw001
            LET g_pk_array[2].column = 'prdw001'
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document

               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL g_pk_array.clear()
            LET g_pk_array[1].values = g_prdw_m.prdwsite
            LET g_pk_array[1].column = 'prdwsite'
            LET g_pk_array[2].values = g_prdw_m.prdw001
            LET g_pk_array[2].column = 'prdw001'
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL g_pk_array.clear()
            LET g_pk_array[1].values = g_prdw_m.prdwsite
            LET g_pk_array[1].column = 'prdwsite'
            LET g_pk_array[2].values = g_prdw_m.prdw001
            LET g_pk_array[2].column = 'prdw001'
            #add-point:ON ACTION followup
            CALL cl_user_overview_follow('')

         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_browser)
               LET g_export_id[1]   = "s_browser"
               LET g_export_node[2] = base.typeInfo.create(g_prde_d)
               LET g_export_id[2]   = "s_detail1"
               LET g_export_node[3] = base.typeInfo.create(g_prde2_d)
               LET g_export_id[3]   = "s_detail2"
               LET g_export_node[4] = base.typeInfo.create(g_prde3_d)
               LET g_export_id[4]   = "s_detail3"
               LET g_export_node[5] = base.typeInfo.create(g_prde4_d)
               LET g_export_id[5]   = "s_detail4"
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
            EXIT DIALOG
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
 
{<section id="aprq211.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aprq211_browser_fill(ps_page_action)
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   #add-point:browser_fill段define

   #end add-point    
 
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_prdw_m.* TO NULL
   CALL g_prde_d.clear()        
   CALL g_prde2_d.clear() 
   CALL g_prde3_d.clear() 
   CALL g_prde4_d.clear() 
 
   CALL g_browser.clear()
   
   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = '0' THEN
      LET l_searchcol = "prdw001"
 
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
      LET l_sub_sql = " SELECT UNIQUE prdwsite,prdw001 ",
 
                        " FROM prdw_t",
                        " LEFT JOIN prdwl_t ON prdwsite = prdwlsite AND prdw001 = prdwl001 AND prdwl002 = '",g_lang,"' ",
                        ",prda_t ",
                              " ",                              
                              " LEFT JOIN prde_t ON prdeent = prdaent AND prdadocno = prdedocno ",
                              " LEFT JOIN prdg_t ON prdgent = prdaent AND prdadocno = prdgdocno", 
                              " LEFT JOIN prdf_t ON prdfent = prdaent AND prdadocno = prdfdocno", 
                              " LEFT JOIN prdd_t ON prddent = prdaent AND prdadocno = prdddocno",  
                              " LEFT JOIN prdb_t ON prdbent = prdaent AND prdadocno = prdbdocno", 
                              " LEFT JOIN prdc_t ON prdcent = prdaent AND prdadocno = prdcdocno ",                               
                              " ", 
                       " WHERE prdaent=prdwent AND prda001=prdw001 AND prda002=prdw002 AND prdwent = '" ||g_enterprise|| "'  AND prdw003 = '1' AND prdw098 = '1' AND prdeent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2
 
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE prdwsite,prdw001 ",
 
                        " FROM prdw_t ", 
                              " ",
                              " LEFT JOIN prdwl_t ON prdwsite = prdwlsite AND prdw001 = prdwl001 AND prdwl002 = '",g_lang,"' ",
                        "WHERE prdwent = '" ||g_enterprise|| "'  AND prdw003 = '1' AND prdw098 = '1' AND ",l_wc CLIPPED
   END IF
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前
 
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
      #依照prdwunit,'',prdw001,prdw002,prdw006,'',prdw007,'',prdw027 Browser欄位定義(取代原本bs_sql功能)
      LET l_sql_rank = "SELECT DISTINCT prdwstus,prdwunit,'',prdwsite,'',prdw001,prdw002,prdw006,'',prdw007,'',prdw027,prdw099,prdw100, 
          DENSE_RANK() OVER(ORDER BY prdw001 ",g_order,") AS RANK ",
                        " FROM prdw_t ",
                        " LEFT JOIN prdwl_t ON prdwsite = prdwlsite AND prdw001 = prdwl001 AND prdwl002 = '",g_lang,"' ",
                        ",prda_t",
                              " ",
                              " LEFT JOIN prde_t ON prdeent = prdaent AND prdadocno = prdedocno ",
                              " LEFT JOIN prdg_t ON prdgent = prdaent AND prdadocno = prdgdocno", 
                              " LEFT JOIN prdf_t ON prdfent = prdaent AND prdadocno = prdfdocno", 
                              " LEFT JOIN prdd_t ON prddent = prdaent AND prdadocno = prdddocno",  
                              " LEFT JOIN prdb_t ON prdbent = prdaent AND prdadocno = prdbdocno", 
                              " LEFT JOIN prdc_t ON prdcent = prdaent AND prdadocno = prdcdocno ",  
                              " ",
                       " ",
                       " WHERE prdaent=prdwent AND prda001=prdw001 AND prda002=prdw002 AND prdwent = '" ||g_enterprise|| "'  AND prdw003 = '1' AND prdw098 = '1' AND ",g_wc," AND ",g_wc2
   ELSE
      #單身無輸入資料
      LET l_sql_rank = "SELECT DISTINCT prdwstus,prdwunit,'',prdwsite,'',prdw001,prdw002,prdw006,'',prdw007,'',prdw027,prdw099,prdw100, 
          DENSE_RANK() OVER(ORDER BY prdw001 ",g_order,") AS RANK ",
                       " FROM prdw_t ",
                            "  ",
                            "  LEFT JOIN prdwl_t ON prdwsite = prdwlsite AND prdw001 = prdwl001 AND prdwl002 = '",g_lang,"' ",
                       " WHERE prdwent = '" ||g_enterprise|| "'  AND prdw003 = '1' AND prdw098 = '1' AND ", g_wc
   END IF
   
   #定義翻頁CURSOR
   LET g_sql= "SELECT prdwstus,prdwunit,'',prdwsite,'',prdw001,prdw002,prdw006,'',prdw007,'',prdw027,prdw099,prdw100 FROM (",l_sql_rank, 
       ") WHERE ",
              " RANK >= ",1," AND RANK<",1+g_max_browse,
              " ORDER BY ",l_searchcol," ",g_order
               
   #add-point:browser_fill,before_prepare
 
   #end add-point
               
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
   
   #add-point:browser_fill,open

   #end add-point
 
   CALL g_browser.clear()
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_prdwunit,g_browser[g_cnt].b_prdwunit_desc,g_browser[g_cnt].b_prdwsite,g_browser[g_cnt].b_prdwsite_desc, 
       g_browser[g_cnt].b_prdw001,g_browser[g_cnt].b_prdw002,g_browser[g_cnt].b_prdw006,g_browser[g_cnt].b_prdw006_desc, 
       g_browser[g_cnt].b_prdw007,g_browser[g_cnt].b_prdw007_desc,g_browser[g_cnt].b_prdw027,g_browser[g_cnt].b_prdw099,g_browser[g_cnt].b_prdw100
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
 
{<section id="aprq211.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aprq211_ui_headershow()
   #add-point:ui_headershow段define

   #end add-point    
   
   LET g_prdw_m.prdwsite = g_browser[g_current_idx].b_prdwsite   
   LET g_prdw_m.prdw001 = g_browser[g_current_idx].b_prdw001   
 
    SELECT UNIQUE prdwunit,prdwsite,prdw099,prdw001,prdw002,prdw100,prdw006,prdw007,prdw027,prdwstus, 
        prdw010,prdw011,prdw012,prdw013,prdw024,prdw025,prdw026,prdw098,prdw004,prdw005,prdw003,prdw008, 
        prdw009,prdwcrtid,prdwcrtdp,prdwcrtdt,prdwownid,prdwowndp,prdwmodid,prdwmoddt,prdwcnfid,prdwcnfdt,prdw042  ##add by zhangnan prdw042 
 
 INTO g_prdw_m.prdwunit,g_prdw_m.prdwsite,g_prdw_m.prdw099,g_prdw_m.prdw001,g_prdw_m.prdw002,g_prdw_m.prdw100, 
     g_prdw_m.prdw006,g_prdw_m.prdw007,g_prdw_m.prdw027,g_prdw_m.prdwstus,g_prdw_m.prdw010,g_prdw_m.prdw011, 
     g_prdw_m.prdw012,g_prdw_m.prdw013,g_prdw_m.prdw024,g_prdw_m.prdw025,g_prdw_m.prdw026,g_prdw_m.prdw098, 
     g_prdw_m.prdw004,g_prdw_m.prdw005,g_prdw_m.prdw003,g_prdw_m.prdw008,g_prdw_m.prdw009,g_prdw_m.prdwcrtid, 
     g_prdw_m.prdwcrtdp,g_prdw_m.prdwcrtdt,g_prdw_m.prdwownid,g_prdw_m.prdwowndp,g_prdw_m.prdwmodid, 
     g_prdw_m.prdwmoddt,g_prdw_m.prdwcnfid,g_prdw_m.prdwcnfdt,g_prdw_m.prdw042
 FROM prdw_t
 WHERE prdwent = g_enterprise  AND prdwsite = g_prdw_m.prdwsite AND prdw001 = g_prdw_m.prdw001
   CALL aprq211_show()
   
END FUNCTION
 
{</section>}
 
{<section id="aprq211.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aprq211_ui_detailshow()
   #add-point:ui_detailshow段define
   
   #end add-point    
   
   #add-point:ui_detailshow段before
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aprq211.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aprq211_ui_browser_refresh()
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
 
{<section id="aprq211.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aprq211_construct()
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define

   #end add-point    
 
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_prdw_m.* TO NULL
   CALL g_prde_d.clear()        
   CALL g_prde2_d.clear() 
   CALL g_prde3_d.clear() 
   CALL g_prde4_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
   INITIALIZE g_wc2_table4 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前
   CALL cl_set_comp_visible('bpage2',TRUE)
   CALL cl_set_comp_visible('bpage3',TRUE)
   CALL cl_set_comp_visible('bpage4',TRUE)
   CALL cl_set_comp_visible('lbl_prdd003',TRUE)
   CALL cl_set_comp_visible('prdd003_1',TRUE)
   CALL cl_set_comp_visible('lbl_prdd004',TRUE)
   CALL cl_set_comp_visible('prdd004_1',TRUE)
   CALL cl_set_comp_visible('lbl_prdd005',TRUE)
   CALL cl_set_comp_visible('prdd005_1',TRUE)
   CALL cl_set_comp_visible('lbl_prdd006',TRUE)
   CALL cl_set_comp_visible('prdd006_1',TRUE)
   CALL cl_set_comp_visible('lbl_prdd007',TRUE)
   CALL cl_set_comp_visible('prdd007_1',TRUE)
   CALL cl_set_comp_visible('lbl_prdd008',TRUE)
   CALL cl_set_comp_visible('prdd008_1',TRUE)
   CALL cl_set_comp_visible('lbl_prdb005_1',TRUE)
   CALL cl_set_comp_visible('lbl_prdb005_2',TRUE)
   CALL cl_set_comp_visible('prdb005_1',TRUE)
   CALL cl_set_comp_visible('prdb005_2',TRUE)
   CALL cl_set_comp_visible('lbl_3',FALSE)
   CALL cl_set_comp_visible('lbl_4',FALSE)
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON prdwunit,prdwsite,prdw099,prdw001,prdw002,prdwl003,prdw100,prdw006,prdw007, 
          prdw027,prdwstus,prdw010,prdw011,prdw012,prdw013,prdw024,prdw025,prdw026,prdw098,prdw004,prdw005, 
          prdw003,prdw033,prdw008,prdw009,prdwcrtid,prdwcrtdp,prdwcrtdt,prdwownid,prdwowndp,prdwmodid,prdwmoddt, 
          prdwcnfid,prdwcnfdt,prdw037,prdw038,prdw034,prdw042   #151204-00007#14 add prdw034
 
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
               #DISPLAY g_qryparam.return2 TO ooefl003 #說明(簡稱) 

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
         #Ctrlp:construct.c.prdwsite
         ON ACTION controlp INFIELD prdwsite
            #add-point:ON ACTION controlp INFIELD prdwsite
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdwsite  #顯示到畫面上
            NEXT FIELD prdwsite                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdwsite
            #add-point:BEFORE FIELD prdwsite

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdwsite
            
            #add-point:AFTER FIELD prdwsite

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
			LET g_qryparam.arg1 = '1'
			LET g_qryparam.arg2 = '1'
            CALL q_prdl001()                           #呼叫開窗
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
			   LET g_qryparam.arg1 = '1'
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
			   LET g_qryparam.arg1 = '1'
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
 
         #----<<prdw024>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw024
            #add-point:BEFORE FIELD prdw024

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw024
            
            #add-point:AFTER FIELD prdw024

            #END add-point
            
 
         #Ctrlp:construct.c.prdw024
         ON ACTION controlp INFIELD prdw024
            #add-point:ON ACTION controlp INFIELD prdw024

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
 
         #----<<prdd003_1>>----
         #----<<prdd004_1>>----
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
               #DISPLAY g_qryparam.return2 TO ooeg001 #部門編號 

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
         #----<<prdb005_1>>----
         #----<<prdd005_1>>----
         #----<<prdd006_1>>----
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
         
         #----<<prdw033>>----
         #Ctrlp:construct.c.prdw033
         ON ACTION controlp INFIELD prdw033
            #add-point:ON ACTION controlp INFIELD prdw033
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2135'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdw033  #顯示到畫面上
            NEXT FIELD prdw033                     #返回原欄位
    
 
 
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdw033
            #add-point:BEFORE FIELD prdw033
 
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw033
            
            #add-point:AFTER FIELD prdw033
 
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
         #----<<prdb005_2>>----
         #----<<prdd007_1>>----
         #----<<prdd008_1>>----
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
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON prde002,prdeacti,prde003,prde004,prdesite,prdeunit
           FROM s_detail1[1].prde002,s_detail1[1].prdeacti,s_detail1[1].prde003,s_detail1[1].prde004, 
               s_detail1[1].prdesite,s_detail1[1].prdeunit
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       #此段落由子樣板a11產生
         ##----<<prdeownid>>----
         ##ON ACTION controlp INFIELD prdeownid
         ##   CALL q_common('prdw_t','prdeownid',TRUE,FALSE,.prdeownid) RETURNING ls_return
         ##   DISPLAY ls_return TO prdeownid
         ##   NEXT FIELD prdeownid  
         #
         ##----<<prdeowndp>>----
         ##ON ACTION controlp INFIELD prdeowndp
         ##   CALL q_common('prdw_t','prdeowndp',TRUE,FALSE,.prdeowndp) RETURNING ls_return
         ##   DISPLAY ls_return TO prdeowndp
         ##   NEXT FIELD prdeowndp
         #
         ##----<<prdecrtid>>----
         ##ON ACTION controlp INFIELD prdecrtid
         ##   CALL q_common('prdw_t','prdecrtid',TRUE,FALSE,.prdecrtid) RETURNING ls_return
         ##   DISPLAY ls_return TO prdecrtid
         ##   NEXT FIELD prdecrtid
         #
         ##----<<prdecrtdp>>----
         ##ON ACTION controlp INFIELD prdecrtdp
         ##   CALL q_common('prdw_t','prdecrtdp',TRUE,FALSE,.prdecrtdp) RETURNING ls_return
         ##   DISPLAY ls_return TO prdecrtdp
         ##   NEXT FIELD prdecrtdp
         #
         ##----<<prdemodid>>----
         ##ON ACTION controlp INFIELD prdemodid
         ##   CALL q_common('prdw_t','prdemodid',TRUE,FALSE,.prdemodid) RETURNING ls_return
         ##   DISPLAY ls_return TO prdemodid
         ##   NEXT FIELD prdemodid
         #
         ##----<<prdecnfid>>----
         ##ON ACTION controlp INFIELD prdecnfid
         ##   CALL q_common('prdw_t','prdecnfid',TRUE,FALSE,.prdecnfid) RETURNING ls_return
         ##   DISPLAY ls_return TO prdecnfid
         ##   NEXT FIELD prdecnfid
         #
         ##----<<prdepstid>>----
         ##ON ACTION controlp INFIELD prdepstid
         ##   CALL q_common('prdw_t','prdepstid',TRUE,FALSE,.prdepstid) RETURNING ls_return
         ##   DISPLAY ls_return TO prdepstid
         ##   NEXT FIELD prdepstid
         
         ##----<<prdecrtdt>>----
         #AFTER FIELD prdecrtdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prdemoddt>>----
         #AFTER FIELD prdemoddt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prdecnfdt>>----
         #AFTER FIELD prdecnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prdepstdt>>----
         #AFTER FIELD prdepstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
         
       #單身一般欄位開窗相關處理
       #---------------------<  Detail: page1  >---------------------
         #----<<prde002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prde002
            #add-point:BEFORE FIELD prde002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prde002
            
            #add-point:AFTER FIELD prde002

            #END add-point
            
 
         #Ctrlp:construct.c.page1.prde002
         ON ACTION controlp INFIELD prde002
            #add-point:ON ACTION controlp INFIELD prde002

            #END add-point
 
         #----<<prdestus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdeacti
            #add-point:BEFORE FIELD prdestus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdeacti
            
            #add-point:AFTER FIELD prdestus

            #END add-point
            
 
         #Ctrlp:construct.c.page1.prdestus
         ON ACTION controlp INFIELD prdeacti
            #add-point:ON ACTION controlp INFIELD prdestus

            #END add-point
 
         #----<<prde003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prde003
            #add-point:BEFORE FIELD prde003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prde003
            
            #add-point:AFTER FIELD prde003

            #END add-point
            
 
         #Ctrlp:construct.c.page1.prde003
         ON ACTION controlp INFIELD prde003
            #add-point:ON ACTION controlp INFIELD prde003

            #END add-point
 
         #----<<prde004>>----
         #Ctrlp:construct.c.page1.prde004
         ON ACTION controlp INFIELD prde004
            #add-point:ON ACTION controlp INFIELD prde004
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '1'
            LET g_qryparam.arg2 = '1'
            CALL q_prde004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prde004  #顯示到畫面上

            NEXT FIELD prde004                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD prde004
            #add-point:BEFORE FIELD prde004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prde004
            
            #add-point:AFTER FIELD prde004

            #END add-point
            
 
         #----<<prde004_desc>>----
         #----<<prdesite>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdesite
            #add-point:BEFORE FIELD prdesite

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdesite
            
            #add-point:AFTER FIELD prdesite

            #END add-point
            
 
         #Ctrlp:construct.c.page1.prdesite
         ON ACTION controlp INFIELD prdesite
            #add-point:ON ACTION controlp INFIELD prdesite

            #END add-point
 
         #----<<prdeunit>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdeunit
            #add-point:BEFORE FIELD prdeunit

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdeunit
            
            #add-point:AFTER FIELD prdeunit

            #END add-point
            
 
         #Ctrlp:construct.c.page1.prdeunit
         ON ACTION controlp INFIELD prdeunit
            #add-point:ON ACTION controlp INFIELD prdeunit

            #END add-point
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON prdgacti,prdg002,prdg011,prdg003,prdg004,prdg005,prdg006,prdg007,prdgsite,prdgunit,prdg010 
 
           FROM s_detail2[1].prdgacti,s_detail2[1].prdg002,s_detail2[1].prdg011,s_detail2[1].prdg003,s_detail2[1].prdg004, 
               s_detail2[1].prdg005,s_detail2[1].prdg006,s_detail2[1].prdg007,s_detail2[1].prdgsite, 
               s_detail2[1].prdgunit,s_detail2[1].prdg010
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       #此段落由子樣板a11產生
         ##----<<prdgownid>>----
         ##ON ACTION controlp INFIELD prdgownid
         ##   CALL q_common('prdw_t','prdgownid',TRUE,FALSE,.prdgownid) RETURNING ls_return
         ##   DISPLAY ls_return TO prdgownid
         ##   NEXT FIELD prdgownid  
         #
         ##----<<prdgowndp>>----
         ##ON ACTION controlp INFIELD prdgowndp
         ##   CALL q_common('prdw_t','prdgowndp',TRUE,FALSE,.prdgowndp) RETURNING ls_return
         ##   DISPLAY ls_return TO prdgowndp
         ##   NEXT FIELD prdgowndp
         #
         ##----<<prdgcrtid>>----
         ##ON ACTION controlp INFIELD prdgcrtid
         ##   CALL q_common('prdw_t','prdgcrtid',TRUE,FALSE,.prdgcrtid) RETURNING ls_return
         ##   DISPLAY ls_return TO prdgcrtid
         ##   NEXT FIELD prdgcrtid
         #
         ##----<<prdgcrtdp>>----
         ##ON ACTION controlp INFIELD prdgcrtdp
         ##   CALL q_common('prdw_t','prdgcrtdp',TRUE,FALSE,.prdgcrtdp) RETURNING ls_return
         ##   DISPLAY ls_return TO prdgcrtdp
         ##   NEXT FIELD prdgcrtdp
         #
         ##----<<prdgmodid>>----
         ##ON ACTION controlp INFIELD prdgmodid
         ##   CALL q_common('prdw_t','prdgmodid',TRUE,FALSE,.prdgmodid) RETURNING ls_return
         ##   DISPLAY ls_return TO prdgmodid
         ##   NEXT FIELD prdgmodid
         #
         ##----<<prdgcnfid>>----
         ##ON ACTION controlp INFIELD prdgcnfid
         ##   CALL q_common('prdw_t','prdgcnfid',TRUE,FALSE,.prdgcnfid) RETURNING ls_return
         ##   DISPLAY ls_return TO prdgcnfid
         ##   NEXT FIELD prdgcnfid
         #
         ##----<<prdgpstid>>----
         ##ON ACTION controlp INFIELD prdgpstid
         ##   CALL q_common('prdw_t','prdgpstid',TRUE,FALSE,.prdgpstid) RETURNING ls_return
         ##   DISPLAY ls_return TO prdgpstid
         ##   NEXT FIELD prdgpstid
         
         ##----<<prdgcrtdt>>----
         #AFTER FIELD prdgcrtdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prdgmoddt>>----
         #AFTER FIELD prdgmoddt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prdgcnfdt>>----
         #AFTER FIELD prdgcnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prdgpstdt>>----
         #AFTER FIELD prdgpstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
       
       #單身一般欄位開窗相關處理       
       #---------------------<  Detail: page2  >---------------------
         #----<<prdgstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdgacti
            #add-point:BEFORE FIELD prdgstus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdgacti
            
            #add-point:AFTER FIELD prdgstus

            #END add-point
            
 
         #Ctrlp:construct.c.page2.prdgstus
         ON ACTION controlp INFIELD prdgacti
            #add-point:ON ACTION controlp INFIELD prdgstus

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
            
 
         #Ctrlp:construct.c.page2.prdg002
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
            
 
         #Ctrlp:construct.c.page2.prdg003
         ON ACTION controlp INFIELD prdg003
            #add-point:ON ACTION controlp INFIELD prdg003

            #END add-point
 
         #----<<prdg004>>----
         #Ctrlp:construct.c.page2.prdg004
         ON ACTION controlp INFIELD prdg004
            #add-point:ON ACTION controlp INFIELD prdg004
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '1'
            LET g_qryparam.arg2 = '1'
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
         #----<<prdg005>>----
         #Ctrlp:construct.c.page2.prdg005
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
            
 
         #----<<prdg006>>----
         #Ctrlp:construct.c.page2.prdg006
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
            
 
         #Ctrlp:construct.c.page2.prdg007
         ON ACTION controlp INFIELD prdg007
            #add-point:ON ACTION controlp INFIELD prdg007

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
            
 
         #Ctrlp:construct.c.page2.prdgsite
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
            
 
         #Ctrlp:construct.c.page2.prdgunit
         ON ACTION controlp INFIELD prdgunit
            #add-point:ON ACTION controlp INFIELD prdgunit

            #END add-point
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON prdfacti,prdf003,prdf004,prdf002,prdfsite,prdfunit
           FROM s_detail3[1].prdfacti,s_detail3[1].prdf003,s_detail3[1].prdf004,s_detail3[1].prdf002, 
               s_detail3[1].prdfsite,s_detail3[1].prdfunit
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       #此段落由子樣板a11產生
         ##----<<prdfownid>>----
         ##ON ACTION controlp INFIELD prdfownid
         ##   CALL q_common('prdw_t','prdfownid',TRUE,FALSE,.prdfownid) RETURNING ls_return
         ##   DISPLAY ls_return TO prdfownid
         ##   NEXT FIELD prdfownid  
         #
         ##----<<prdfowndp>>----
         ##ON ACTION controlp INFIELD prdfowndp
         ##   CALL q_common('prdw_t','prdfowndp',TRUE,FALSE,.prdfowndp) RETURNING ls_return
         ##   DISPLAY ls_return TO prdfowndp
         ##   NEXT FIELD prdfowndp
         #
         ##----<<prdfcrtid>>----
         ##ON ACTION controlp INFIELD prdfcrtid
         ##   CALL q_common('prdw_t','prdfcrtid',TRUE,FALSE,.prdfcrtid) RETURNING ls_return
         ##   DISPLAY ls_return TO prdfcrtid
         ##   NEXT FIELD prdfcrtid
         #
         ##----<<prdfcrtdp>>----
         ##ON ACTION controlp INFIELD prdfcrtdp
         ##   CALL q_common('prdw_t','prdfcrtdp',TRUE,FALSE,.prdfcrtdp) RETURNING ls_return
         ##   DISPLAY ls_return TO prdfcrtdp
         ##   NEXT FIELD prdfcrtdp
         #
         ##----<<prdfmodid>>----
         ##ON ACTION controlp INFIELD prdfmodid
         ##   CALL q_common('prdw_t','prdfmodid',TRUE,FALSE,.prdfmodid) RETURNING ls_return
         ##   DISPLAY ls_return TO prdfmodid
         ##   NEXT FIELD prdfmodid
         #
         ##----<<prdfcnfid>>----
         ##ON ACTION controlp INFIELD prdfcnfid
         ##   CALL q_common('prdw_t','prdfcnfid',TRUE,FALSE,.prdfcnfid) RETURNING ls_return
         ##   DISPLAY ls_return TO prdfcnfid
         ##   NEXT FIELD prdfcnfid
         #
         ##----<<prdfpstid>>----
         ##ON ACTION controlp INFIELD prdfpstid
         ##   CALL q_common('prdw_t','prdfpstid',TRUE,FALSE,.prdfpstid) RETURNING ls_return
         ##   DISPLAY ls_return TO prdfpstid
         ##   NEXT FIELD prdfpstid
         
         ##----<<prdfcrtdt>>----
         #AFTER FIELD prdfcrtdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prdfmoddt>>----
         #AFTER FIELD prdfmoddt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prdfcnfdt>>----
         #AFTER FIELD prdfcnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prdfpstdt>>----
         #AFTER FIELD prdfpstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
       
       #單身一般欄位開窗相關處理       
       #---------------------<  Detail: page3  >---------------------
         #----<<prdfstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdfacti
            #add-point:BEFORE FIELD prdfstus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdfacti
            
            #add-point:AFTER FIELD prdfstus

            #END add-point
            
 
         #Ctrlp:construct.c.page3.prdfstus
         ON ACTION controlp INFIELD prdfacti
            #add-point:ON ACTION controlp INFIELD prdfstus

            #END add-point
 
         #----<<prdf003>>----
         #Ctrlp:construct.c.page3.prdf003
         ON ACTION controlp INFIELD prdf003
            #add-point:ON ACTION controlp INFIELD prdf003
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooia001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdf003  #顯示到畫面上
            
            NEXT FIELD prdf003                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdf003
            #add-point:BEFORE FIELD prdf003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdf003
            
            #add-point:AFTER FIELD prdf003

            #END add-point
            
 
         #----<<prdf003_desc>>----
         #----<<prdf004>>----
         #Ctrlp:construct.c.page3.prdf004
         ON ACTION controlp INFIELD prdf004
            #add-point:ON ACTION controlp INFIELD prdf004
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '1'
            LET g_qryparam.arg2 = '1'
            CALL q_prdf004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdf004  #顯示到畫面上

            NEXT FIELD prdf004                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdf004
            #add-point:BEFORE FIELD prdf004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdf004
            
            #add-point:AFTER FIELD prdf004

            #END add-point
            
 
         #----<<prdf004_desc>>----
         #----<<prdf002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdf002
            #add-point:BEFORE FIELD prdf002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdf002
            
            #add-point:AFTER FIELD prdf002

            #END add-point
            
 
         #Ctrlp:construct.c.page3.prdf002
         ON ACTION controlp INFIELD prdf002
            #add-point:ON ACTION controlp INFIELD prdf002

            #END add-point
 
         #----<<prdfsite>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdfsite
            #add-point:BEFORE FIELD prdfsite

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdfsite
            
            #add-point:AFTER FIELD prdfsite

            #END add-point
            
 
         #Ctrlp:construct.c.page3.prdfsite
         ON ACTION controlp INFIELD prdfsite
            #add-point:ON ACTION controlp INFIELD prdfsite

            #END add-point
 
         #----<<prdfunit>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdfunit
            #add-point:BEFORE FIELD prdfunit

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdfunit
            
            #add-point:AFTER FIELD prdfunit

            #END add-point
            
 
         #Ctrlp:construct.c.page3.prdfunit
         ON ACTION controlp INFIELD prdfunit
            #add-point:ON ACTION controlp INFIELD prdfunit

            #END add-point
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table4 ON prddacti,prdd002,prdd003,prdd004,prdd005,prdd006,prdd007,prdd008,prddsite, 
          prddunit
           FROM s_detail4[1].prddacti,s_detail4[1].prdd002,s_detail4[1].prdd003,s_detail4[1].prdd004, 
               s_detail4[1].prdd005,s_detail4[1].prdd006,s_detail4[1].prdd007,s_detail4[1].prdd008,s_detail4[1].prddsite, 
               s_detail4[1].prddunit
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理(table 4)
       #此段落由子樣板a11產生
         ##----<<prddownid>>----
         ##ON ACTION controlp INFIELD prddownid
         ##   CALL q_common('prdw_t','prddownid',TRUE,FALSE,.prddownid) RETURNING ls_return
         ##   DISPLAY ls_return TO prddownid
         ##   NEXT FIELD prddownid  
         #
         ##----<<prddowndp>>----
         ##ON ACTION controlp INFIELD prddowndp
         ##   CALL q_common('prdw_t','prddowndp',TRUE,FALSE,.prddowndp) RETURNING ls_return
         ##   DISPLAY ls_return TO prddowndp
         ##   NEXT FIELD prddowndp
         #
         ##----<<prddcrtid>>----
         ##ON ACTION controlp INFIELD prddcrtid
         ##   CALL q_common('prdw_t','prddcrtid',TRUE,FALSE,.prddcrtid) RETURNING ls_return
         ##   DISPLAY ls_return TO prddcrtid
         ##   NEXT FIELD prddcrtid
         #
         ##----<<prddcrtdp>>----
         ##ON ACTION controlp INFIELD prddcrtdp
         ##   CALL q_common('prdw_t','prddcrtdp',TRUE,FALSE,.prddcrtdp) RETURNING ls_return
         ##   DISPLAY ls_return TO prddcrtdp
         ##   NEXT FIELD prddcrtdp
         #
         ##----<<prddmodid>>----
         ##ON ACTION controlp INFIELD prddmodid
         ##   CALL q_common('prdw_t','prddmodid',TRUE,FALSE,.prddmodid) RETURNING ls_return
         ##   DISPLAY ls_return TO prddmodid
         ##   NEXT FIELD prddmodid
         #
         ##----<<prddcnfid>>----
         ##ON ACTION controlp INFIELD prddcnfid
         ##   CALL q_common('prdw_t','prddcnfid',TRUE,FALSE,.prddcnfid) RETURNING ls_return
         ##   DISPLAY ls_return TO prddcnfid
         ##   NEXT FIELD prddcnfid
         #
         ##----<<prddpstid>>----
         ##ON ACTION controlp INFIELD prddpstid
         ##   CALL q_common('prdw_t','prddpstid',TRUE,FALSE,.prddpstid) RETURNING ls_return
         ##   DISPLAY ls_return TO prddpstid
         ##   NEXT FIELD prddpstid
         
         ##----<<prddcrtdt>>----
         #AFTER FIELD prddcrtdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prddmoddt>>----
         #AFTER FIELD prddmoddt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prddcnfdt>>----
         #AFTER FIELD prddcnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prddpstdt>>----
         #AFTER FIELD prddpstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
       
       #單身一般欄位開窗相關處理       
       #---------------------<  Detail: page4  >---------------------
         #----<<prddstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prddacti
            #add-point:BEFORE FIELD prddstus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prddacti
            
            #add-point:AFTER FIELD prddstus

            #END add-point
            
 
         #Ctrlp:construct.c.page4.prddstus
         ON ACTION controlp INFIELD prddacti
            #add-point:ON ACTION controlp INFIELD prddstus

            #END add-point
 
         #----<<prdd002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdd002
            #add-point:BEFORE FIELD prdd002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdd002
            
            #add-point:AFTER FIELD prdd002

            #END add-point
            
 
         #Ctrlp:construct.c.page4.prdd002
         ON ACTION controlp INFIELD prdd002
            #add-point:ON ACTION controlp INFIELD prdd002

            #END add-point
 
         #----<<prdd003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdd003
            #add-point:BEFORE FIELD prdd003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdd003
            
            #add-point:AFTER FIELD prdd003

            #END add-point
            
 
         #Ctrlp:construct.c.page4.prdd003
         ON ACTION controlp INFIELD prdd003
            #add-point:ON ACTION controlp INFIELD prdd003

            #END add-point
 
         #----<<prdd004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdd004
            #add-point:BEFORE FIELD prdd004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdd004
            
            #add-point:AFTER FIELD prdd004

            #END add-point
            
 
         #Ctrlp:construct.c.page4.prdd004
         ON ACTION controlp INFIELD prdd004
            #add-point:ON ACTION controlp INFIELD prdd004

            #END add-point
 
         #----<<prdd005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdd005
            #add-point:BEFORE FIELD prdd005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdd005
            
            #add-point:AFTER FIELD prdd005

            #END add-point
            
 
         #Ctrlp:construct.c.page4.prdd005
         ON ACTION controlp INFIELD prdd005
            #add-point:ON ACTION controlp INFIELD prdd005

            #END add-point
 
         #----<<prdd006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdd006
            #add-point:BEFORE FIELD prdd006

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdd006
            
            #add-point:AFTER FIELD prdd006

            #END add-point
            
 
         #Ctrlp:construct.c.page4.prdd006
         ON ACTION controlp INFIELD prdd006
            #add-point:ON ACTION controlp INFIELD prdd006

            #END add-point
 
         #----<<prdd007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdd007
            #add-point:BEFORE FIELD prdd007

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdd007
            
            #add-point:AFTER FIELD prdd007

            #END add-point
            
 
         #Ctrlp:construct.c.page4.prdd007
         ON ACTION controlp INFIELD prdd007
            #add-point:ON ACTION controlp INFIELD prdd007

            #END add-point
 
         #----<<prdd008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdd008
            #add-point:BEFORE FIELD prdd008

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdd008
            
            #add-point:AFTER FIELD prdd008

            #END add-point
            
 
         #Ctrlp:construct.c.page4.prdd008
         ON ACTION controlp INFIELD prdd008
            #add-point:ON ACTION controlp INFIELD prdd008

            #END add-point
 
         #----<<prddsite>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prddsite
            #add-point:BEFORE FIELD prddsite

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prddsite
            
            #add-point:AFTER FIELD prddsite

            #END add-point
            
 
         #Ctrlp:construct.c.page4.prddsite
         ON ACTION controlp INFIELD prddsite
            #add-point:ON ACTION controlp INFIELD prddsite

            #END add-point
 
         #----<<prddunit>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prddunit
            #add-point:BEFORE FIELD prddunit

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prddunit
            
            #add-point:AFTER FIELD prddunit

            #END add-point
            
 
         #Ctrlp:construct.c.page4.prddunit
         ON ACTION controlp INFIELD prddunit
            #add-point:ON ACTION controlp INFIELD prddunit

            #END add-point
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令)
      CONSTRUCT g_wc2_table5 ON prdbacti,prdb004,prdb002,prdb003,prdb005
           FROM s_detail5[1].prdbacti,s_detail5[1].prdb004,s_detail5[1].prdb002,s_detail5[1].prdb003, 
               s_detail5[1].prdb005

                      
         BEFORE CONSTRUCT

         BEFORE FIELD prdbacti

         AFTER FIELD prdbacti
            

         ON ACTION controlp INFIELD prdbacti

         BEFORE FIELD prdb004

         AFTER FIELD prdb004

         ON ACTION controlp INFIELD prdb004

         BEFORE FIELD prdb002

         AFTER FIELD prdb002
            

         ON ACTION controlp INFIELD prdb002

         BEFORE FIELD prdb003

         AFTER FIELD prdb003
            

         ON ACTION controlp INFIELD prdb003

         BEFORE FIELD prdb005

         AFTER FIELD prdb005
            

         ON ACTION controlp INFIELD prdb005

       
      END CONSTRUCT
 

      CONSTRUCT g_wc2_table6 ON prdcacti,prdc003,prdc004,prdc004_desc
           FROM s_detail6[1].prdcacti,s_detail6[1].prdc003,s_detail6[1].prdc004,s_detail6[1].prdc004_desc
                      
         BEFORE CONSTRUCT

         BEFORE FIELD prdcacti
 
 

         AFTER FIELD prdcacti
            

         ON ACTION controlp INFIELD prdcacti

         BEFORE FIELD prdc003

         AFTER FIELD prdc003
            

         ON ACTION controlp INFIELD prdc003

         ON ACTION controlp INFIELD prdc004

			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '1' 
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdc004  #顯示到畫面上
            
            NEXT FIELD prdc004                     #返回原欄位


         BEFORE FIELD prdc004


         AFTER FIELD prdc004
            

            
 

         ON ACTION controlp INFIELD prdc004_desc

            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdc004_desc  #顯示到畫面上
            NEXT FIELD prdc004_desc                     #返回原欄位
    

         BEFORE FIELD prdc004_desc


         AFTER FIELD prdc004_desc

            
 
         BEFORE FIELD prdc001

 
     
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
 
   IF g_wc2_table4 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
   END IF
 
 
 
 
   
   #add-point:cs段結束前
   IF g_wc2_table5 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
   END IF
   IF g_wc2_table6 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table6
   END IF
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aprq211.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aprq211_filter()
   #add-point:filter段define
   DEFINE ls_result      STRING
   #end add-point   
 
   #切換畫面
   IF NOT g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF   
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON prdwunit,prdwsite,prdw001,prdw002,prdw006,prdw007,prdw027,prdw099,prdw100 
 
                          FROM s_browse[1].b_prdwunit,s_browse[1].b_prdwsite,s_browse[1].b_prdw001,s_browse[1].b_prdw002, 
                              s_browse[1].b_prdw006,s_browse[1].b_prdw007,s_browse[1].b_prdw027,s_browse[1].b_prdw099, 
                              s_browse[1].b_prdw100
 
         BEFORE CONSTRUCT
               DISPLAY aprq211_filter_parser('prdwunit') TO s_browse[1].b_prdwunit
            DISPLAY aprq211_filter_parser('prdwsite') TO s_browse[1].b_prdwsite
            DISPLAY aprq211_filter_parser('prdw001') TO s_browse[1].b_prdw001
            DISPLAY aprq211_filter_parser('prdw002') TO s_browse[1].b_prdw002
            DISPLAY aprq211_filter_parser('prdw006') TO s_browse[1].b_prdw006
            DISPLAY aprq211_filter_parser('prdw007') TO s_browse[1].b_prdw007
            DISPLAY aprq211_filter_parser('prdw027') TO s_browse[1].b_prdw027
            DISPLAY aprq211_filter_parser('prdw099') TO s_browse[1].b_prdw099
            DISPLAY aprq211_filter_parser('prdw100') TO s_browse[1].b_prdw100
      
                            #add-point:filter段cs_ctrl
                            AFTER FIELD b_prdw100
                               CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
                               IF NOT cl_null(ls_result) THEN
                                  IF NOT cl_chk_date_symbol(ls_result) THEN
                                     LET ls_result = cl_add_date_extra_cond(ls_result)
                                  END IF
                               END IF
                               CALL FGL_DIALOG_SETBUFFER(ls_result)
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
 
      CALL aprq211_filter_show('prdwunit')
   CALL aprq211_filter_show('prdwsite')
   CALL aprq211_filter_show('prdw001')
   CALL aprq211_filter_show('prdw002')
   CALL aprq211_filter_show('prdw006')
   CALL aprq211_filter_show('prdw007')
   CALL aprq211_filter_show('prdw027')
   CALL aprq211_filter_show('prdw099')
   CALL aprq211_filter_show('prdw100')
 
END FUNCTION
 
{</section>}
 
{<section id="aprq211.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aprq211_filter_parser(ps_field)
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
 
{<section id="aprq211.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aprq211_filter_show(ps_field)
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
   LET ls_condition = aprq211_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aprq211.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aprq211_query()
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
   CALL g_prde_d.clear()
   CALL g_prde2_d.clear()
   CALL g_prde3_d.clear()
   CALL g_prde4_d.clear()
 
   
   #add-point:query段other
   CALL g_prde5_d.clear()
   CALL g_prde6_d.clear()
   CALL cl_set_comp_visible("page_3", TRUE)
   #end add-point   
   
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL aprq211_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL aprq211_browser_fill("")
      CALL aprq211_fetch("")
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
      CALL aprq211_filter_show('prdwunit')
   CALL aprq211_filter_show('prdwsite')
   CALL aprq211_filter_show('prdw001')
   CALL aprq211_filter_show('prdw002')
   CALL aprq211_filter_show('prdw006')
   CALL aprq211_filter_show('prdw007')
   CALL aprq211_filter_show('prdw027')
   CALL aprq211_filter_show('prdw099')
   CALL aprq211_filter_show('prdw100')
   CALL aprq211_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "-100"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
   ELSE
      CALL aprq211_fetch("F") 
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aprq211.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aprq211_fetch(p_flag)
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
    SELECT UNIQUE prdwunit,prdwsite,prdw099,prdw001,prdw002,prdw100,prdw006,prdw007,prdw027,prdwstus, 
        prdw010,prdw011,prdw012,prdw013,prdw024,prdw025,prdw026,prdw098,prdw004,prdw005,prdw003,prdw033,prdw008, 
        prdw009,prdwcrtid,prdwcrtdp,prdwcrtdt,prdwownid,prdwowndp,prdwmodid,prdwmoddt,prdwcnfid,prdwcnfdt,prdw037,prdw038,prdw034,prdw042  #151204-00007#14 add prdw034 
 
 INTO g_prdw_m.prdwunit,g_prdw_m.prdwsite,g_prdw_m.prdw099,g_prdw_m.prdw001,g_prdw_m.prdw002,g_prdw_m.prdw100, 
     g_prdw_m.prdw006,g_prdw_m.prdw007,g_prdw_m.prdw027,g_prdw_m.prdwstus,g_prdw_m.prdw010,g_prdw_m.prdw011, 
     g_prdw_m.prdw012,g_prdw_m.prdw013,g_prdw_m.prdw024,g_prdw_m.prdw025,g_prdw_m.prdw026,g_prdw_m.prdw098, 
     g_prdw_m.prdw004,g_prdw_m.prdw005,g_prdw_m.prdw003,g_prdw_m.prdw033,g_prdw_m.prdw008,g_prdw_m.prdw009,g_prdw_m.prdwcrtid, 
     g_prdw_m.prdwcrtdp,g_prdw_m.prdwcrtdt,g_prdw_m.prdwownid,g_prdw_m.prdwowndp,g_prdw_m.prdwmodid, 
     g_prdw_m.prdwmoddt,g_prdw_m.prdwcnfid,g_prdw_m.prdwcnfdt,g_prdw_m.prdw037,g_prdw_m.prdw038,g_prdw_m.prdw034,g_prdw_m.prdw042  #151204-00007#14 add prdw034 
 FROM prdw_t
 WHERE prdwent = g_enterprise AND prdwsite = g_prdw_m.prdwsite AND prdw001 = g_prdw_m.prdw001
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
#   IF g_prdw_m.prdwstus = 'N' THEN
#      CALL cl_set_act_visible("modify,modify_detail,delete", TRUE)
#   ELSE
#      CALL cl_set_act_visible("modify,modify_detail,delete", FALSE)
#   END IF
   IF g_prdw_m.prdw026 <> '4' THEN
      CALL cl_set_comp_visible("page_3", FALSE)
   ELSE
      CALL cl_set_comp_visible("page_3", TRUE)
   END IF
   CALL cl_set_act_visible("statechange", FALSE)
   CALL aprq211_set_comp_att_text()
   
   CALL cl_set_act_visible("object", FALSE)
   #end add-point  
   
   
   
   #add-point:fetch結束前

   #end add-point
   
   #LET g_data_owner =       
   #LET g_data_group =   
   
   #重新顯示   
   CALL aprq211_show()
 
END FUNCTION
 
{</section>}
 
{<section id="aprq211.insert" >}
#+ 資料新增
PRIVATE FUNCTION aprq211_insert()
   #add-point:insert段define
   
   #end add-point    
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_prde_d.clear()   
   CALL g_prde2_d.clear()  
   CALL g_prde3_d.clear()  
   CALL g_prde4_d.clear()  
 
 
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
      #LET g_prdw_m.prdwstus = ""
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_prdw_m.prdwstus = "N"
      LET g_prdw_m.prdw010 = "N"
      LET g_prdw_m.prdw011 = "N"
      LET g_prdw_m.prdw012 = "N"
      LET g_prdw_m.prdw013 = "N"
 
  
      #add-point:單頭預設值
      LET g_prdw_m.prdwunit = g_site
      LET g_prdw_m.prdwsite = g_site
      LET g_prdw_m.prdw003 = '1'
      LET g_prdw_m.prdw004 = g_user
      LET g_prdw_m.prdw005 = g_dept
      LET g_prdw_m.prdw002 = 1
      LET g_prdw_m.prdw098 = '1'
      LET g_prdw_m.prdd005_1 = '00:00:00'
      LET g_prdw_m.prdd006_1 = '23:59:59'
      CALL aprq211_desc()
      CALL aprq211_set_comp_visible()
      LET g_prdw_m_t.* = g_prdw_m.*
      #end add-point 
     
      CALL aprq211_input("a")
      
      #add-point:單頭輸入後

      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_prdw_m.* = g_prdw_m_t.*
         CALL aprq211_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         EXIT WHILE
      END IF
      
      CALL g_prde_d.clear()
      CALL g_prde2_d.clear()
      CALL g_prde3_d.clear()
      CALL g_prde4_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   LET g_state = "Y"
   
   LET g_prdwsite_t = g_prdw_m.prdwsite
   LET g_prdw001_t = g_prdw_m.prdw001
 
   
   LET g_wc = g_wc,  
              " OR ( prdwent = '" ||g_enterprise|| "' AND",
              " prdwsite = '", g_prdw_m.prdwsite CLIPPED, "' "
              ," AND prdw001 = '", g_prdw_m.prdw001 CLIPPED, "' "
 
              , ") "
   
   CLOSE aprq211_cl
   
END FUNCTION
 
{</section>}
 
{<section id="aprq211.modify" >}
#+ 資料修改
PRIVATE FUNCTION aprq211_modify()
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   #add-point:modify段define

   #end add-point    
   
   IF g_prdw_m.prdw001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      RETURN
   END IF
   
    SELECT UNIQUE prdwunit,prdwsite,prdw099,prdw001,prdw002,prdw100,prdw006,prdw007,prdw027,prdwstus, 
        prdw010,prdw011,prdw012,prdw013,prdw024,prdw025,prdw026,prdw098,prdw004,prdw005,prdw003,prdw033,prdw008, 
        prdw009,prdwcrtid,prdwcrtdp,prdwcrtdt,prdwownid,prdwowndp,prdwmodid,prdwmoddt,prdwcnfid,prdwcnfdt 
 
 INTO g_prdw_m.prdwunit,g_prdw_m.prdwsite,g_prdw_m.prdw099,g_prdw_m.prdw001,g_prdw_m.prdw002,g_prdw_m.prdw100, 
     g_prdw_m.prdw006,g_prdw_m.prdw007,g_prdw_m.prdw027,g_prdw_m.prdwstus,g_prdw_m.prdw010,g_prdw_m.prdw011, 
     g_prdw_m.prdw012,g_prdw_m.prdw013,g_prdw_m.prdw024,g_prdw_m.prdw025,g_prdw_m.prdw026,g_prdw_m.prdw098, 
     g_prdw_m.prdw004,g_prdw_m.prdw005,g_prdw_m.prdw003,g_prdw_m.prdw033,g_prdw_m.prdw008,g_prdw_m.prdw009,g_prdw_m.prdwcrtid, 
     g_prdw_m.prdwcrtdp,g_prdw_m.prdwcrtdt,g_prdw_m.prdwownid,g_prdw_m.prdwowndp,g_prdw_m.prdwmodid, 
     g_prdw_m.prdwmoddt,g_prdw_m.prdwcnfid,g_prdw_m.prdwcnfdt
 FROM prdw_t
 WHERE prdwent = g_enterprise AND prdwsite = g_prdw_m.prdwsite AND prdw001 = g_prdw_m.prdw001
 
   ERROR ""
  
   LET g_prdw001_t = g_prdw_m.prdw001
 
   CALL s_transaction_begin()
   
   OPEN aprq211_cl USING g_enterprise,g_prdw_m.prdwsite,g_prdw_m.prdw001
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN aprq211_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      CLOSE aprq211_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH aprq211_cl INTO g_prdw_m.prdwunit,g_prdw_m.prdwunit_desc,g_prdw_m.prdwsite,g_prdw_m.prdwsite_desc, 
       g_prdw_m.prdw099,g_prdw_m.pos,g_prdw_m.prdw001,g_prdw_m.prdw002,g_prdw_m.prdwl003,g_prdw_m.prdw100, 
       g_prdw_m.prdw006,g_prdw_m.prdw006_desc,g_prdw_m.prdw007,g_prdw_m.prdw007_desc,g_prdw_m.prdw027, 
       g_prdw_m.prdwstus,g_prdw_m.prdw010,g_prdw_m.prdw011,g_prdw_m.prdw012,g_prdw_m.prdw013,g_prdw_m.prdw024, 
       g_prdw_m.prdw025,g_prdw_m.prdw026,g_prdw_m.prdd003_1,g_prdw_m.prdd004_1,g_prdw_m.prdw098,g_prdw_m.prdw004, 
       g_prdw_m.prdw004_desc,g_prdw_m.prdw005,g_prdw_m.prdw005_desc,g_prdw_m.prdb005_1,g_prdw_m.prdd005_1, 
       g_prdw_m.prdd006_1,g_prdw_m.prdw003,g_prdw_m.prdw033,g_prdw_m.prdw033_desc,g_prdw_m.prdw008,g_prdw_m.prdw008_desc,g_prdw_m.prdw009,g_prdw_m.prdw009_desc, 
       g_prdw_m.prdb005_2,g_prdw_m.prdd007_1,g_prdw_m.prdd008_1,g_prdw_m.prdwcrtid,g_prdw_m.prdwcrtid_desc, 
       g_prdw_m.prdwcrtdp,g_prdw_m.prdwcrtdp_desc,g_prdw_m.prdwcrtdt,g_prdw_m.prdwownid,g_prdw_m.prdwownid_desc, 
       g_prdw_m.prdwowndp,g_prdw_m.prdwowndp_desc,g_prdw_m.prdwmodid,g_prdw_m.prdwmodid_desc,g_prdw_m.prdwmoddt, 
       g_prdw_m.prdwcnfid,g_prdw_m.prdwcnfid_desc,g_prdw_m.prdwcnfdt
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_prdw_m.prdw001
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      CLOSE aprq211_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   
   
   #add-point:modify段show之前

   #end add-point  
   
   CALL aprq211_show()
   WHILE TRUE
      LET g_prdw001_t = g_prdw_m.prdw001
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_prdw_m.prdwmodid = g_user 
LET g_prdw_m.prdwmoddt = cl_get_current()
 
      
      #add-point:modify段修改前

      #end add-point
      
      CALL aprq211_input("u")     #欄位更改
 
      #add-point:modify段修改後

      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_prdw_m.* = g_prdw_m_t.*
         CALL aprq211_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更
      IF g_prdw_m.prdw001 != g_prdw001_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前

         #end add-point
         
         #更新單身key值
         UPDATE prde_t SET prde001 = g_prdw_m.prdw001
 
          WHERE prdeent = g_enterprise AND prde001 = g_prdw001_t
 
            
         #add-point:單身fk修改中

         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "prde_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "prde_t"
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
            SET prdg001 = g_prdw_m.prdw001
 
          WHERE prdgent = g_enterprise AND
                prdg001 = g_prdw001_t
 
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
 
         #更新單身key值
         #add-point:單身fk修改前

         #end add-point
         UPDATE prdf_t
            SET prdf001 = g_prdw_m.prdw001
 
          WHERE prdfent = g_enterprise AND
                prdf001 = g_prdw001_t
 
         #add-point:單身fk修改中

         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "prdf_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "prdf_t"
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
         UPDATE prdd_t
            SET prdd001 = g_prdw_m.prdw001
 
          WHERE prddent = g_enterprise AND
                prdd001 = g_prdw001_t
 
         #add-point:單身fk修改中

         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "prdd_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "prdd_t"
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
   IF NOT cl_log_modified_record(g_prdw_m.prdw001,g_site) THEN 
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aprq211_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-U
   CALL cl_flow_notify(g_prdw_m.prdw001,'U')
 
END FUNCTION   
 
{</section>}
 
{<section id="aprq211.input" >}
#+ 資料輸入
PRIVATE FUNCTION aprq211_input(p_cmd)
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
   DEFINE  l_ooef004             LIKE ooef_t.ooef004
   DEFINE  l_prdw001             LIKE prdw_t.prdw001
   DEFINE  l_n1                  LIKE type_t.num5
   DEFINE  l_ooia002             LIKE ooia_t.ooia002
   DEFINE  l_time                DATETIME YEAR TO SECOND
   DEFINE  l_prdw002             LIKE type_t.num5
   DEFINE  l_prdg004             LIKE prdg_t.prdg004
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
   LET g_forupd_sql = "SELECT prde002,prdeacti,prde003,prde004,'',prdesite,prdeunit FROM prde_t WHERE  
       prdeent=? AND prde001=? AND prde002=? FOR UPDATE"
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aprq211_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql

   #end add-point    
   LET g_forupd_sql = "SELECT prdgacti,prdg002,prdg011,prdg003,prdg004,'',prdg005,prdg006,'',prdg007,prdgsite, 
       prdgunit,prdg010 FROM prdg_t WHERE prdgent=? AND prdg001=? AND prdg002=? AND prdg003=? AND prdg004=?  
       FOR UPDATE"
   #add-point:input段define_sql

   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aprq211_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql

   #end add-point    
   LET g_forupd_sql = "SELECT prdfacti,prdf003,'',prdf004,'',prdf002,prdfsite,prdfunit FROM prdf_t WHERE  
       prdfent=? AND prdf001=? AND prdf002=? FOR UPDATE"
   #add-point:input段define_sql

   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aprq211_bcl3 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql

   #end add-point    
   LET g_forupd_sql = "SELECT prddacti,prdd002,prdd003,prdd004,prdd005,prdd006,prdd007,prdd008,prddsite, 
       prddunit FROM prdd_t WHERE prddent=? AND prdd001=? AND prdd002=? FOR UPDATE"
   #add-point:input段define_sql

   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aprq211_bcl4 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql

   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aprq211_set_entry(p_cmd)
   #add-point:set_entry後
   CALL aprq211_set_no_required(p_cmd)
   CALL aprq211_set_required(p_cmd) 
   #end add-point
   CALL aprq211_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_prdw_m.prdwunit,g_prdw_m.prdwsite,g_prdw_m.prdw099,g_prdw_m.prdw001,g_prdw_m.prdw002, 
       g_prdw_m.prdwl003,g_prdw_m.prdw100,g_prdw_m.prdw006,g_prdw_m.prdw007,g_prdw_m.prdw027,g_prdw_m.prdwstus, 
       g_prdw_m.prdw010,g_prdw_m.prdw011,g_prdw_m.prdw012,g_prdw_m.prdw013,g_prdw_m.prdw024,g_prdw_m.prdw025, 
       g_prdw_m.prdw026,g_prdw_m.prdd003_1,g_prdw_m.prdd004_1,g_prdw_m.prdw098,g_prdw_m.prdw004,g_prdw_m.prdw005, 
       g_prdw_m.prdb005_1,g_prdw_m.prdd005_1,g_prdw_m.prdd006_1,g_prdw_m.prdw003,g_prdw_m.prdw033,g_prdw_m.prdw008,g_prdw_m.prdw009, 
       g_prdw_m.prdb005_2,g_prdw_m.prdd007_1,g_prdw_m.prdd008_1
   
   LET lb_reproduce = FALSE
   
   #add-point:資料輸入前
   LET g_errshow = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
 
{</section>}
 
{<section id="aprq211.input.head" >}
      #單頭段
      INPUT BY NAME g_prdw_m.prdwunit,g_prdw_m.prdwsite,g_prdw_m.prdw099,g_prdw_m.prdw001,g_prdw_m.prdw002, 
          g_prdw_m.prdwl003,g_prdw_m.prdw100,g_prdw_m.prdw006,g_prdw_m.prdw007,g_prdw_m.prdw027,g_prdw_m.prdwstus, 
          g_prdw_m.prdw010,g_prdw_m.prdw011,g_prdw_m.prdw012,g_prdw_m.prdw013,g_prdw_m.prdw024,g_prdw_m.prdw025, 
          g_prdw_m.prdw026,g_prdw_m.prdd003_1,g_prdw_m.prdd004_1,g_prdw_m.prdw098,g_prdw_m.prdw004,g_prdw_m.prdw005, 
          g_prdw_m.prdb005_1,g_prdw_m.prdd005_1,g_prdw_m.prdd006_1,g_prdw_m.prdw003,g_prdw_m.prdw033,g_prdw_m.prdw008, 
          g_prdw_m.prdw009,g_prdw_m.prdb005_2,g_prdw_m.prdd007_1,g_prdw_m.prdd008_1 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
 
         ON ACTION update_item
            #add-point:ON ACTION update_item
 
            #END add-point
 
     
         BEFORE INPUT
            LET g_master_multi_table_t.prdwl001 = g_prdw_m.prdw001
LET g_master_multi_table_t.prdwl003 = g_prdw_m.prdwl003
 
            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.prdwl001 = ''
LET g_master_multi_table_t.prdwl003 = ''
 
            END IF
            #add-point:資料輸入前

            #end add-point
 
         #---------------------------<  Master  >---------------------------
         #----<<prdwunit>>----
         #此段落由子樣板a02產生
         AFTER FIELD prdwunit
            
            #add-point:AFTER FIELD prdwunit
 
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdwunit
            #add-point:BEFORE FIELD prdwunit

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE prdwunit
            #add-point:ON CHANGE prdwunit

            #END add-point
 
         #----<<prdwsite>>----
         #此段落由子樣板a02產生
         AFTER FIELD prdwsite
            
            #add-point:AFTER FIELD prdwsite
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prdw_m.prdwsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prdw_m.prdwsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prdw_m.prdwsite_desc


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdwsite
            #add-point:BEFORE FIELD prdwsite

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE prdwsite
            #add-point:ON CHANGE prdwsite

            #END add-point
 
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
 
         #----<<prdw001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw001
            #add-point:BEFORE FIELD prdw001
#            IF g_prdw_m.prda000 = 'I' AND p_cmd = 'a' THEN
#               LET l_n1 = 0
#               SELECT COUNT(*) INTO l_n1
#                 FROM oofg_t
#                WHERE oofgent = g_enterprise
#                  AND oofg002 = '21'
#                  AND oofgstus = 'Y'
#               IF l_n1 > 0 THEN
#                  CALL s_aooi390('21') RETURNING l_success,l_prdw001
#                  IF l_success THEN
#                     LET g_prdw_m.prdw001 = l_prdw001
#                  END IF 
#                  IF NOT cl_null(g_prdw_m.prdw001) THEN
#                     CALL aprq211_chk_prdw001()
#                     IF NOT cl_null(g_errno) THEN
#                        CALL cl_err(g_prdw_m.prdw001,g_errno,1)
#                        LET g_prdw_m.prdw001 = g_prdw_m_t.prdw001
#                        NEXT FIELD prdw001
#                     END IF
##                     CALL cl_set_comp_entry("prdw001",FALSE)
##                  ELSE
##                     NEXT FIELD prda000
#                  END IF
#               END IF
#            END IF
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw001
            
            #add-point:AFTER FIELD prdw001
#            IF NOT cl_null(g_prdw_m.prdw001) THEN
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prdw_m.prdw001 != g_prdw_m_t.prdw001 )) THEN 
#                  CALL aprq211_chk_prdw001()
#                  IF NOT cl_null(g_errno) THEN
#                     CALL cl_err(g_prdw_m.prdw001,g_errno,1)
#                     LET g_prdw_m.prdw001 = g_prdw_m_t.prdw001
#                     NEXT FIELD prdw001
#                  END IF
#               END IF
#               IF g_prdw_m.prda000 = 'U' THEN   
#                  SELECT MAX(to_number(prdw002)) +1 INTO l_prdw002
#                       FROM prdw_t
#                      WHERE prdwent = g_enterprise
#                        AND prdw001 = g_prdw_m.prdw001
#                     IF cl_null(l_prdw002) THEN
#                        LET g_prdw_m.prdw002 = 1
#                     ELSE
#                        LET g_prdw_m.prdw002 = l_prdw002
#                     END IF
#               END IF
#            END IF
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
 
         #----<<prdw010>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw010
            #add-point:BEFORE FIELD prdw010

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw010
            
            #add-point:AFTER FIELD prdw010
#            CALL aprq211_set_comp_visible()
#            IF g_prdw_m.prdw010 = 'Y' THEN
#               DELETE FROM prdg_t WHERE prdgent = g_enterprise AND prdgdocno = g_prdw_m.prdadocno
#               CALL aprq211_b_fill()
#            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdw010
            #add-point:ON CHANGE prdw010
#            CALL aprq211_set_comp_visible()
#            IF g_prdw_m.prdw010 = 'Y' THEN
#               DELETE FROM prdg_t WHERE prdgent = g_enterprise AND prdgdocno = g_prdw_m.prdadocno
#               CALL aprq211_b_fill()
#            END IF
            #END add-point
 
         #----<<prdw011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw011
            #add-point:BEFORE FIELD prdw011

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw011
            
            #add-point:AFTER FIELD prdw011
            CALL aprq211_set_comp_visible()
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdw011
            #add-point:ON CHANGE prdw011
            CALL aprq211_set_comp_visible()
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
 
         #----<<prdw013>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw013
            #add-point:BEFORE FIELD prdw013

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw013
            
            #add-point:AFTER FIELD prdw013
            CALL aprq211_set_comp_visible()
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdw013
            #add-point:ON CHANGE prdw013
            IF g_prdw_m.prdw013 = 'N' THEN
               LET g_prdw_m.prdd005_1 = '00:00:00'
               LET g_prdw_m.prdd006_1 = '23:59:59'
            END IF
            CALL aprq211_set_comp_visible()
            #END add-point
 
         #----<<prdw024>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw024
            #add-point:BEFORE FIELD prdw024

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw024
            
            #add-point:AFTER FIELD prdw024
            IF NOT cl_null(g_prdw_m.prdw024) THEN
               IF g_prdw_m.prdw024 = '2' THEN
                  IF g_prdw_m.prdb005_1 < 0 OR g_prdw_m.prdb005_1 > 100 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apr-00077'
                     LET g_errparam.extend = g_prdw_m.prdb005_1
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prdw_m.prdw024 = g_prdw_m_t.prdw024
                     NEXT FIELD prdw024
                  END IF
                  IF g_prdw_m.prdb005_2 < 0 OR g_prdw_m.prdb005_2 > 100 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apr-00077'
                     LET g_errparam.extend = g_prdw_m.prdb005_2
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prdw_m.prdw024 = g_prdw_m_t.prdw024
                     NEXT FIELD prdw024
                  END IF
               END IF
               IF g_prdw_m.prdw024 = '3' THEN
                  IF g_prdw_m.prdb005_1 <= 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apr-00078'
                     LET g_errparam.extend = g_prdw_m.prdb005_1
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prdw_m.prdw024 = g_prdw_m_t.prdw024
                     NEXT FIELD prdw024
                  END IF
                  IF g_prdw_m.prdb005_2 <= 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apr-00078'
                     LET g_errparam.extend = g_prdw_m.prdb005_2
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prdw_m.prdw024 = g_prdw_m_t.prdw024
                     NEXT FIELD prdw024
                  END IF
               END IF
            END IF
            CALL aprq211_set_comp_att_text()
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdw024
            #add-point:ON CHANGE prdw024
            CALL aprq211_set_comp_att_text()
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
 
         #----<<prdw026>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdw026
            #add-point:BEFORE FIELD prdw026

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdw026
            
            #add-point:AFTER FIELD prdw026
#            CALL aprq211_set_entry(p_cmd)
#            CALL aprq211_set_no_entry(p_cmd)
#            CALL aprq211_set_comp_visible()
#            IF g_prdw_m.prdw026 <> '4' THEN
#               CALL cl_set_act_visible("object", FALSE)
#               DELETE FROM prdb_t WHERE prdbent = g_enterprise AND prdbdocno = g_prdw_m.prdadocno
#               DELETE FROM prdc_t WHERE prdcent = g_enterprise AND prdcdocno = g_prdw_m.prdadocno
#            ELSE
#               CALL cl_set_act_visible("object", TRUE)
#            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdw026
            #add-point:ON CHANGE prdw026
#            CALL aprq211_set_entry(p_cmd)
#            CALL aprq211_set_no_entry(p_cmd)
#            CALL aprq211_set_comp_visible()
#            IF g_prdw_m.prdw026 <> '4' THEN
#               CALL cl_set_act_visible("object", FALSE)
#               DELETE FROM prdb_t WHERE prdbent = g_enterprise AND prdbdocno = g_prdw_m.prdadocno
#               DELETE FROM prdc_t WHERE prdcent = g_enterprise AND prdcdocno = g_prdw_m.prdadocno
#            ELSE
#               CALL cl_set_act_visible("object", TRUE)
#            END IF
            #END add-point
 
         #----<<prdd003_1>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdd003_1
            #add-point:BEFORE FIELD prdd003_1

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdd003_1
            
            #add-point:AFTER FIELD prdd003_1
            IF NOT cl_null(g_prdw_m.prdd003_1) AND NOT cl_null(g_prdw_m.prdd004_1) THEN
               IF g_prdw_m.prdd003_1 > g_prdw_m.prdd004_1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00080'
                  LET g_errparam.extend = g_prdw_m.prdd003_1
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prdw_m.prdd003_1 = g_prdw_m_t.prdd003_1
                  NEXT FIELD prdd003_1
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdd003_1
            #add-point:ON CHANGE prdd003_1

            #END add-point
 
         #----<<prdd004_1>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdd004_1
            #add-point:BEFORE FIELD prdd004_1

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdd004_1
            
            #add-point:AFTER FIELD prdd004_1
            IF NOT cl_null(g_prdw_m.prdd003_1) AND NOT cl_null(g_prdw_m.prdd004_1) THEN
               IF g_prdw_m.prdd003_1 > g_prdw_m.prdd004_1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00081'
                  LET g_errparam.extend = g_prdw_m.prdd003_1
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prdw_m.prdd004_1 = g_prdw_m_t.prdd004_1
                  NEXT FIELD prdd004_1
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdd004_1
            #add-point:ON CHANGE prdd004_1

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
 
         #----<<prdw004>>----
         #此段落由子樣板a02產生
         AFTER FIELD prdw004
            
            #add-point:AFTER FIELD prdw004
            CALL aprq211_desc()
            IF NOT cl_null(g_prdw_m.prdw004) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#31  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prdw_m.prdw004
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"#要執行的建議程式待補 #160318-00025#31  add
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooag001") THEN
                  LET g_prdw_m.prdw004 = g_prdw_m_t.prdw004
                  CALL aprq211_desc()
                  NEXT FIELD CURRENT
               END IF
               SELECT ooag003 INTO g_prdw_m.prdw005
                 FROM ooag_t
                WHERE ooagent = g_enterprise
                  AND ooag001 = g_prdw_m.prdw004
               CALL aprq211_desc()
            END IF 
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdw004
            #add-point:BEFORE FIELD prdw004

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE prdw004
            #add-point:ON CHANGE prdw004

            #END add-point
 
         #----<<prdw005>>----
         #此段落由子樣板a02產生
         AFTER FIELD prdw005
            
            #add-point:AFTER FIELD prdw005
            CALL aprq211_desc()
            IF NOT cl_null(g_prdw_m.prdw005) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#31  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prdw_m.prdw005
               LET g_chkparam.arg2 = g_today
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"#要執行的建議程式待補 #160318-00025#31  add
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooeg001") THEN
                  LET g_prdw_m.prdw005 = g_prdw_m_t.prdw005
                  CALL aprq211_desc()
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdw005
            #add-point:BEFORE FIELD prdw005

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE prdw005
            #add-point:ON CHANGE prdw005

            #END add-point
 
         #----<<prdb005_1>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdb005_1
            #add-point:BEFORE FIELD prdb005_1

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdb005_1
            
            #add-point:AFTER FIELD prdb005_1
            IF NOT cl_null(g_prdw_m.prdw024) THEN
               IF g_prdw_m.prdw024 = '2' THEN
                  IF g_prdw_m.prdb005_1 < 0 OR g_prdw_m.prdb005_1 > 100 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apr-00077'
                     LET g_errparam.extend = g_prdw_m.prdb005_1
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prdw_m.prdb005_1 = g_prdw_m_t.prdb005_1
                     NEXT FIELD prdb005_1
                  END IF
               END IF
               IF g_prdw_m.prdw024 = '3' THEN
                  IF g_prdw_m.prdb005_1 <= 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apr-00078'
                     LET g_errparam.extend = g_prdw_m.prdb005_1
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prdw_m.prdb005_1 = g_prdw_m_t.prdb005_1
                     NEXT FIELD prdb005_1
                  END IF
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdb005_1
            #add-point:ON CHANGE prdb005_1

            #END add-point
 
         #----<<prdd005_1>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdd005_1
            #add-point:BEFORE FIELD prdd005_1

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdd005_1
            
            #add-point:AFTER FIELD prdd005_1
            IF NOT cl_null(g_prdw_m.prdd005_1) AND NOT cl_null(g_prdw_m.prdd006_1) THEN
               IF g_prdw_m.prdd005_1 > g_prdw_m.prdd006_1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apr-00091'
                  LET g_errparam.extend = g_prdw_m.prdd005_1
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prdw_m.prdd005_1 = g_prdw_m_t.prdd005_1
                  NEXT FIELD prdd005_1
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdd005_1
            #add-point:ON CHANGE prdd005_1

            #END add-point
 
         #----<<prdd006_1>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdd006_1
            #add-point:BEFORE FIELD prdd006_1

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdd006_1
            
            #add-point:AFTER FIELD prdd006_1
            IF NOT cl_null(g_prdw_m.prdd005_1) AND NOT cl_null(g_prdw_m.prdd006_1) THEN
               IF g_prdw_m.prdd005_1 > g_prdw_m.prdd006_1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apr-00091'
                  LET g_errparam.extend = g_prdw_m.prdd006_1
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prdw_m.prdd006_1 = g_prdw_m_t.prdd006_1
                  NEXT FIELD prdd006_1
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdd006_1
            #add-point:ON CHANGE prdd006_1

            #END add-point
 
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
 
         #----<<prdw008>>----
         #此段落由子樣板a02產生
         AFTER FIELD prdw008
            
            #add-point:AFTER FIELD prdw008
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prdw_m.prdw008
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND '2100'=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
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
 
         #----<<prdw009>>----
         #此段落由子樣板a02產生
         AFTER FIELD prdw009
            
            #add-point:AFTER FIELD prdw009
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prdw_m.prdw009
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND '2101'=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
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
 
         #----<<prdb005_2>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdb005_2
            #add-point:BEFORE FIELD prdb005_2

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdb005_2
            
            #add-point:AFTER FIELD prdb005_2
            IF NOT cl_null(g_prdw_m.prdw024) THEN
               IF g_prdw_m.prdw024 = '2' THEN
                  IF g_prdw_m.prdb005_2 < 0 OR g_prdw_m.prdb005_2 > 100 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apr-00077'
                     LET g_errparam.extend = g_prdw_m.prdb005_2
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prdw_m.prdb005_2 = g_prdw_m_t.prdb005_2
                     NEXT FIELD prdb005_2
                  END IF
               END IF
               IF g_prdw_m.prdw024 = '3' THEN
                  IF g_prdw_m.prdb005_2 <= 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apr-00078'
                     LET g_errparam.extend = g_prdw_m.prdb005_2
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prdw_m.prdb005_2 = g_prdw_m_t.prdb005_2
                     NEXT FIELD prdb005_2
                  END IF
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdb005_2
            #add-point:ON CHANGE prdb005_2

            #END add-point
 
         #----<<prdd007_1>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdd007_1
            #add-point:BEFORE FIELD prdd007_1

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdd007_1
            
            #add-point:AFTER FIELD prdd007_1

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdd007_1
            #add-point:ON CHANGE prdd007_1

            #END add-point
 
         #----<<prdd008_1>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdd008_1
            #add-point:BEFORE FIELD prdd008_1

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdd008_1
            
            #add-point:AFTER FIELD prdd008_1

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdd008_1
            #add-point:ON CHANGE prdd008_1

            #END add-point
 
 #欄位檢查
         #---------------------------<  Master  >---------------------------
         #----<<prdwunit>>----
         #Ctrlp:input.c.prdwunit
         ON ACTION controlp INFIELD prdwunit
            #add-point:ON ACTION controlp INFIELD prdwunit

            #END add-point
 
         #----<<prdwsite>>----
         #Ctrlp:input.c.prdwsite
         ON ACTION controlp INFIELD prdwsite
            #add-point:ON ACTION controlp INFIELD prdwsite

            #END add-point
 
         #----<<prdw099>>----
         #Ctrlp:input.c.prdw099
         ON ACTION controlp INFIELD prdw099
            #add-point:ON ACTION controlp INFIELD prdw099

            #END add-point
 
         #----<<prdw001>>----
         #Ctrlp:input.c.prdw001
         ON ACTION controlp INFIELD prdw001
            #add-point:ON ACTION controlp INFIELD prdw001
 
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
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prdw_m.prdw006             #給予default值

            #給予arg 
            LET g_qryparam.arg1 = '1'
            CALL q_prcf001()                                #呼叫開窗

            LET g_prdw_m.prdw006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prdw_m.prdw006 TO prdw006              #顯示到畫面上
            CALL aprq211_desc()
            NEXT FIELD prdw006                          #返回原欄位


            #END add-point
 
         #----<<prdw007>>----
         #Ctrlp:input.c.prdw007
         ON ACTION controlp INFIELD prdw007
            #add-point:ON ACTION controlp INFIELD prdw007
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prdw_m.prdw007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = '1'
            CALL q_prcd001_1()                                #呼叫開窗

            LET g_prdw_m.prdw007 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prdw_m.prdw007 TO prdw007              #顯示到畫面上
            CALL aprq211_desc()
            NEXT FIELD prdw007                          #返回原欄位


            #END add-point
 
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
 
         #----<<prdw010>>----
         #Ctrlp:input.c.prdw010
         ON ACTION controlp INFIELD prdw010
            #add-point:ON ACTION controlp INFIELD prdw010

            #END add-point
 
         #----<<prdw011>>----
         #Ctrlp:input.c.prdw011
         ON ACTION controlp INFIELD prdw011
            #add-point:ON ACTION controlp INFIELD prdw011

            #END add-point
 
         #----<<prdw012>>----
         #Ctrlp:input.c.prdw012
         ON ACTION controlp INFIELD prdw012
            #add-point:ON ACTION controlp INFIELD prdw012

            #END add-point
 
         #----<<prdw013>>----
         #Ctrlp:input.c.prdw013
         ON ACTION controlp INFIELD prdw013
            #add-point:ON ACTION controlp INFIELD prdw013

            #END add-point
 
         #----<<prdw024>>----
         #Ctrlp:input.c.prdw024
         ON ACTION controlp INFIELD prdw024
            #add-point:ON ACTION controlp INFIELD prdw024

            #END add-point
 
         #----<<prdw025>>----
         #Ctrlp:input.c.prdw025
         ON ACTION controlp INFIELD prdw025
            #add-point:ON ACTION controlp INFIELD prdw025

            #END add-point
 
         #----<<prdw026>>----
         #Ctrlp:input.c.prdw026
         ON ACTION controlp INFIELD prdw026
            #add-point:ON ACTION controlp INFIELD prdw026

            #END add-point
 
         #----<<prdd003_1>>----
         #Ctrlp:input.c.prdd003_1
         ON ACTION controlp INFIELD prdd003_1
            #add-point:ON ACTION controlp INFIELD prdd003_1

            #END add-point
 
         #----<<prdd004_1>>----
         #Ctrlp:input.c.prdd004_1
         ON ACTION controlp INFIELD prdd004_1
            #add-point:ON ACTION controlp INFIELD prdd004_1

            #END add-point
 
         #----<<prdw098>>----
         #Ctrlp:input.c.prdw098
         ON ACTION controlp INFIELD prdw098
            #add-point:ON ACTION controlp INFIELD prdw098

            #END add-point
 
         #----<<prdw004>>----
         #Ctrlp:input.c.prdw004
         ON ACTION controlp INFIELD prdw004
            #add-point:ON ACTION controlp INFIELD prdw004
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prdw_m.prdw004             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_prdw_m.prdw004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prdw_m.prdw004 TO prdw004              #顯示到畫面上
            CALL aprq211_desc()
            NEXT FIELD prdw004                          #返回原欄位


            #END add-point
 
         #----<<prdw005>>----
         #Ctrlp:input.c.prdw005
         ON ACTION controlp INFIELD prdw005
            #add-point:ON ACTION controlp INFIELD prdw005
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prdw_m.prdw005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today #

            CALL q_ooeg001()                                #呼叫開窗

            LET g_prdw_m.prdw005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prdw_m.prdw005 TO prdw005              #顯示到畫面上
            CALL aprq211_desc()
            NEXT FIELD prdw005                          #返回原欄位


            #END add-point
 
         #----<<prdb005_1>>----
         #Ctrlp:input.c.prdb005_1
         ON ACTION controlp INFIELD prdb005_1
            #add-point:ON ACTION controlp INFIELD prdb005_1

            #END add-point
 
         #----<<prdd005_1>>----
         #Ctrlp:input.c.prdd005_1
         ON ACTION controlp INFIELD prdd005_1
            #add-point:ON ACTION controlp INFIELD prdd005_1

            #END add-point
 
         #----<<prdd006_1>>----
         #Ctrlp:input.c.prdd006_1
         ON ACTION controlp INFIELD prdd006_1
            #add-point:ON ACTION controlp INFIELD prdd006_1

            #END add-point
 
         #----<<prdw003>>----
         #Ctrlp:input.c.prdw003
         ON ACTION controlp INFIELD prdw003
            #add-point:ON ACTION controlp INFIELD prdw003

            #END add-point
 
         #----<<prdw008>>----
         #Ctrlp:input.c.prdw008
         ON ACTION controlp INFIELD prdw008
            #add-point:ON ACTION controlp INFIELD prdw008

            #END add-point
 
         #----<<prdw009>>----
         #Ctrlp:input.c.prdw009
         ON ACTION controlp INFIELD prdw009
            #add-point:ON ACTION controlp INFIELD prdw009

            #END add-point
 
         #----<<prdb005_2>>----
         #Ctrlp:input.c.prdb005_2
         ON ACTION controlp INFIELD prdb005_2
            #add-point:ON ACTION controlp INFIELD prdb005_2

            #END add-point
 
         #----<<prdd007_1>>----
         #Ctrlp:input.c.prdd007_1
         ON ACTION controlp INFIELD prdd007_1
            #add-point:ON ACTION controlp INFIELD prdd007_1

            #END add-point
 
         #----<<prdd008_1>>----
         #Ctrlp:input.c.prdd008_1
         ON ACTION controlp INFIELD prdd008_1
            #add-point:ON ACTION controlp INFIELD prdd008_1

            #END add-point
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            CALL cl_showmsg()      #錯誤訊息統整顯示
            DISPLAY BY NAME g_prdw_m.prdwsite             
                            ,g_prdw_m.prdw001   
 
                            
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前
              
               #end add-point
               
               INSERT INTO prdw_t (prdwent,prdwunit,prdwsite,prdw099,prdw001,prdw002,prdw100,prdw006, 
                   prdw007,prdw027,prdwstus,prdw010,prdw011,prdw012,prdw013,prdw024,prdw025,prdw026, 
                   prdw098,prdw004,prdw005,prdw003,prdw033,prdw008,prdw009,prdwcrtid,prdwcrtdp,prdwcrtdt,prdwownid, 
                   prdwowndp,prdwmodid,prdwmoddt,prdwcnfid,prdwcnfdt)
               VALUES (g_enterprise,g_prdw_m.prdwunit,g_prdw_m.prdwsite,g_prdw_m.prdw099,g_prdw_m.prdw001, 
                   g_prdw_m.prdw002,g_prdw_m.prdw100,g_prdw_m.prdw006,g_prdw_m.prdw007,g_prdw_m.prdw027, 
                   g_prdw_m.prdwstus,g_prdw_m.prdw010,g_prdw_m.prdw011,g_prdw_m.prdw012,g_prdw_m.prdw013, 
                   g_prdw_m.prdw024,g_prdw_m.prdw025,g_prdw_m.prdw026,g_prdw_m.prdw098,g_prdw_m.prdw004, 
                   g_prdw_m.prdw005,g_prdw_m.prdw003,g_prdw_m.prdw033,g_prdw_m.prdw008,g_prdw_m.prdw009,g_prdw_m.prdwcrtid, 
                   g_prdw_m.prdwcrtdp,g_prdw_m.prdwcrtdt,g_prdw_m.prdwownid,g_prdw_m.prdwowndp,g_prdw_m.prdwmodid, 
                   g_prdw_m.prdwmoddt,g_prdw_m.prdwcnfid,g_prdw_m.prdwcnfdt) 
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
               IF NOT aprq211_master_def() THEN
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aprq211_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前

               #end add-point
               
               UPDATE prdw_t SET (prdwunit,prdwsite,prdw099,prdw001,prdw002,prdw100,prdw006,prdw007, 
                   prdw027,prdwstus,prdw010,prdw011,prdw012,prdw013,prdw024,prdw025,prdw026,prdw098, 
                   prdw004,prdw005,prdw003,prdw033,prdw008,prdw009,prdwcrtid,prdwcrtdp,prdwcrtdt,prdwownid,prdwowndp, 
                   prdwmodid,prdwmoddt,prdwcnfid,prdwcnfdt) = (g_prdw_m.prdwunit,g_prdw_m.prdwsite,g_prdw_m.prdw099, 
                   g_prdw_m.prdw001,g_prdw_m.prdw002,g_prdw_m.prdw100,g_prdw_m.prdw006,g_prdw_m.prdw007, 
                   g_prdw_m.prdw027,g_prdw_m.prdwstus,g_prdw_m.prdw010,g_prdw_m.prdw011,g_prdw_m.prdw012, 
                   g_prdw_m.prdw013,g_prdw_m.prdw024,g_prdw_m.prdw025,g_prdw_m.prdw026,g_prdw_m.prdw098, 
                   g_prdw_m.prdw004,g_prdw_m.prdw005,g_prdw_m.prdw003,g_prdw_m.prdw033,g_prdw_m.prdw008,g_prdw_m.prdw009, 
                   g_prdw_m.prdwcrtid,g_prdw_m.prdwcrtdp,g_prdw_m.prdwcrtdt,g_prdw_m.prdwownid,g_prdw_m.prdwowndp, 
                   g_prdw_m.prdwmodid,g_prdw_m.prdwmoddt,g_prdw_m.prdwcnfid,g_prdw_m.prdwcnfdt)
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
               IF NOT aprq211_master_upd() THEN
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
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
 
{<section id="aprq211.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_prde_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prde_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aprq211_b_fill()
            LET g_rec_b = g_prde_d.getLength()
            #add-point:資料輸入前

            #end add-point
         
         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aprq211_cl USING g_enterprise,g_prdw_m.prdwsite,g_prdw_m.prdw001
 
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN aprq211_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               CLOSE aprq211_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_prde_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prde_d[l_ac].prde002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_prde_d_t.* = g_prde_d[l_ac].*  #BACKUP
               CALL aprq211_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b

               #end add-point  
               CALL aprq211_set_no_entry_b(l_cmd)
               IF NOT aprq211_lock_b("prde_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprq211_bcl INTO g_prde_d[l_ac].prde002,g_prde_d[l_ac].prdeacti,g_prde_d[l_ac].prde003, 
                      g_prde_d[l_ac].prde004,g_prde_d[l_ac].prde004_desc,g_prde_d[l_ac].prdesite,g_prde_d[l_ac].prdeunit 
 
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_prde_d_t.prde002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL aprq211_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row

            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_prde_d[l_ac].* TO NULL 
            
            LET g_prde_d_t.* = g_prde_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprq211_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b
            
            #end add-point
            CALL aprq211_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prde_d[li_reproduce_target].* = g_prde_d[li_reproduce].*
 
               LET g_prde_d[li_reproduce_target].prde002 = NULL
 
            END IF
            #公用欄位給值(單身)
            #此段落由子樣板a14產生    
      #LET .prdeownid = g_user
      #LET .prdeowndp = g_dept
      #LET .prdecrtid = g_user
      #LET .prdecrtdp = g_dept 
      #LET .prdecrtdt = cl_get_current()
      #LET .prdemodid = ""
      #LET .prdemoddt = ""
      #LET g_prde_d[l_ac].prdestus = ""
 
 
            
            #add-point:modify段before insert
#            SELECT MAX(prde002)+1 INTO g_prde_d[l_ac].prde002
#              FROM prde_t
#             WHERE prdeent = g_enterprise
#               AND prdedocno = g_prdw_m.prdadocno
#            IF cl_null(g_prde_d[l_ac].prde002) THEN
#               LET g_prde_d[l_ac].prde002 = 1
#            END IF
#            LET g_prde_d[l_ac].prde001 = g_prdw_m.prdw001
#            LET g_prde_d[l_ac].prdeunit = g_site
#            LET g_prde_d[l_ac].prdesite = g_site
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
            SELECT COUNT(*) INTO l_count FROM prde_t 
             WHERE prdeent = g_enterprise AND prde001 = g_prdw_m.prdw001
 
               AND prde002 = g_prde_d[l_ac].prde002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前

               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdw_m.prdw001
               LET gs_keys[2] = g_prde_d[g_detail_idx].prde002
               CALL aprq211_insert_b('prde_t',gs_keys,"'1'")
                           
               #add-point:單身新增後

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               INITIALIZE g_prde_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "prde_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprq211_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert
#               IF p_cmd = 'u' THEN
#                  LET l_time = cl_get_current()
#                  UPDATE prdw_t SET prdwmodid = g_user,
#                                    prdwmoddt = l_time
#                   WHERE prdwent = g_enterprise
#                     AND prdadocno = g_prdw_m.prdadocno
#                  IF SQLCA.SQLcode  THEN
#                     CALL cl_err("upd prdw_t",SQLCA.sqlcode,1)
#                     CALL s_transaction_end('N','0')
#                     CANCEL INSERT
#                  END IF
#               END IF
               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_prde_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_prde_d.deleteElement(l_ac)
               NEXT FIELD prde002
            END IF
         
            IF g_prde_d[l_ac].prde002 IS NOT NULL
 
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
               
               DELETE FROM prde_t
                WHERE prdeent = g_enterprise AND prde001 = g_prdw_m.prdw001 AND
 
                      prde002 = g_prde_d_t.prde002
 
                  
               #add-point:單身刪除中

               #end add-point 
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "prde_t"
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
               CLOSE aprq211_bcl
               LET l_count = g_prde_d.getLength()
            END IF 
            
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdw_m.prdw001
               LET gs_keys[2] = g_prde_d[g_detail_idx].prde002
 
              
         AFTER DELETE 
            #add-point:單身刪除後2

            #end add-point
                           CALL aprq211_delete_b('prde_t',gs_keys,"'1'")
 
         #---------------------<  Detail: page1  >---------------------
         #----<<prde002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prde002
            #add-point:BEFORE FIELD prde002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prde002
            
            #add-point:AFTER FIELD prde002
#            #此段落由子樣板a05產生
#            IF  g_prdw_m.prdadocno IS NOT NULL AND g_prde_d[g_detail_idx].prde002 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prdw_m.prdadocno != g_prdwdocno_t OR g_prde_d[g_detail_idx].prde002 != g_prde_d_t.prde002)) THEN 
#                  IF NOT ap_chk_notDup(g_prde_d[l_ac].prde002,"SELECT COUNT(*) FROM prde_t WHERE "||"prdeent = '" ||g_enterprise|| "' AND "||"prdedocno = '"||g_prdw_m.prdadocno ||"' AND "|| "prde002 = '"||g_prde_d[g_detail_idx].prde002 ||"'",'std-00004',1) THEN 
#                     LET g_prde_d[l_ac].prde002 = g_prde_d_t.prde002
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prde002
            #add-point:ON CHANGE prde002

            #END add-point
 
         #----<<prdestus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdeacti
            #add-point:BEFORE FIELD prdestus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdeacti
            
            #add-point:AFTER FIELD prdestus

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdeacti
            #add-point:ON CHANGE prdestus

            #END add-point
 
         #----<<prde003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prde003
            #add-point:BEFORE FIELD prde003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prde003
            
            #add-point:AFTER FIELD prde003
            IF NOT cl_null(g_prde_d[l_ac].prde003) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_prde_d[l_ac].prde003 <>　g_prde_d_t.prde003) THEN
                  LET g_prde_d[l_ac].prde004 = ''
                  LET g_prde_d[l_ac].prde004_desc = ''
                  DISPLAY BY NAME g_prde_d[l_ac].prde004
                  DISPLAY BY NAME g_prde_d[l_ac].prde004_desc
#                  CALL aprq211_chk_prde004()
#                  IF NOT cl_null(g_errno) THEN
#                     CALL cl_err(g_prde_d[l_ac].prde003,g_errno,1)
#                     LET g_prde_d[l_ac].prde003 = g_prde_d_t.prde003
#                     NEXT FIELD CURRENT
#                  END IF
#                  IF g_prde_d[l_ac].prde003 = '2' THEN
#                     INITIALIZE g_chkparam.* TO NULL
#                     LET g_chkparam.arg1 = g_prde_d[l_ac].prde004
#                     LET g_chkparam.arg2 = '2'
#                     LET g_chkparam.arg3 = g_site
#                     IF NOT cl_chk_exist("v_ooed004") THEN
#                        LET g_prde_d[l_ac].prde003 = g_prde_d_t.prde003
#                        NEXT FIELD CURRENT
#                     END IF
#                  END IF
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prde003
            #add-point:ON CHANGE prde003

            #END add-point
 
         #----<<prde004>>----
         #此段落由子樣板a02產生
         AFTER FIELD prde004
            
            #add-point:AFTER FIELD prde004
#            CALL aprq211_prde_desc()
#            IF NOT cl_null(g_prde_d[l_ac].prde004) THEN
#               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_prde_d[l_ac].prde004 <>　g_prde_d_t.prde004) THEN
#                  IF NOT ap_chk_notDup(g_prde_d[l_ac].prde004,"SELECT COUNT(*) FROM prde_t WHERE "||"prdeent = '" ||g_enterprise|| "' AND "||"prdedocno = '"||g_prdw_m.prdadocno ||"'  AND "||"prde004 = '"||g_prde_d[l_ac].prde004 ||"' ",'std-00004',1) THEN
#                     LET g_prde_d[l_ac].prde004 = g_prde_d_t.prde004
#                     CALL aprq211_prde_desc()
#                     NEXT FIELD CURRENT
#                  END IF
#                  CALL aprq211_chk_prde004()
#                  IF NOT cl_null(g_errno) THEN
#                     CALL cl_err(g_prde_d[l_ac].prde004,g_errno,1)
#                     LET g_prde_d[l_ac].prde004 = g_prde_d_t.prde004
#                     CALL aprq211_prde_desc()
#                     NEXT FIELD CURRENT
#                  END IF
#                  IF g_prde_d[l_ac].prde003 = '2' THEN
#                     INITIALIZE g_chkparam.* TO NULL
#                     LET g_chkparam.arg1 = g_prde_d[l_ac].prde004
#                     LET g_chkparam.arg2 = '2'
#                     LET g_chkparam.arg3 = g_site
#                     IF NOT cl_chk_exist("v_ooed004") THEN
#                        LET g_prde_d[l_ac].prde004 = g_prde_d_t.prde004
#                        CALL aprq211_prde_desc()
#                        NEXT FIELD CURRENT
#                     END IF
#                  END IF
#               END IF
#            END IF
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD prde004
            #add-point:BEFORE FIELD prde004

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE prde004
            #add-point:ON CHANGE prde004

            #END add-point
 
         #----<<prdesite>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdesite
            #add-point:BEFORE FIELD prdesite

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdesite
            
            #add-point:AFTER FIELD prdesite

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdesite
            #add-point:ON CHANGE prdesite

            #END add-point
 
         #----<<prdeunit>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdeunit
            #add-point:BEFORE FIELD prdeunit

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdeunit
            
            #add-point:AFTER FIELD prdeunit

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdeunit
            #add-point:ON CHANGE prdeunit

            #END add-point
 
 
         #---------------------<  Detail: page1  >---------------------
         #----<<prde002>>----
         #Ctrlp:input.c.page1.prde002
         ON ACTION controlp INFIELD prde002
            #add-point:ON ACTION controlp INFIELD prde002

            #END add-point
 
         #----<<prdestus>>----
         #Ctrlp:input.c.page1.prdestus
         ON ACTION controlp INFIELD prdeacti
            #add-point:ON ACTION controlp INFIELD prdestus

            #END add-point
 
         #----<<prde003>>----
         #Ctrlp:input.c.page1.prde003
         ON ACTION controlp INFIELD prde003
            #add-point:ON ACTION controlp INFIELD prde003

            #END add-point
 
         #----<<prde004>>----
         #Ctrlp:input.c.page1.prde004
         ON ACTION controlp INFIELD prde004
            #add-point:ON ACTION controlp INFIELD prde004
                                                                                                                        #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_prde_d[l_ac].prde004   #給予default值
            #給予arg
            IF g_prde_d[l_ac].prde003 = '1' THEN
               LET g_qryparam.arg1 = '4'
               LET g_qryparam.arg2 = g_site
               LET g_qryparam.arg3 = '8'
               CALL q_rtaa001_5()
            ELSE
               LET g_qryparam.arg1 = g_site
               LET g_qryparam.arg2 = '8'
               CALL q_ooed004()                                #呼叫開窗
            END IF

            LET g_prde_d[l_ac].prde004  = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_prde_d[l_ac].prde004  TO prde004         #顯示到畫面上
            CALL aprq211_prdp_desc()
            NEXT FIELD prde004                                 #返回原欄位                                                  
            #END add-point
 
         #----<<prdesite>>----
         #Ctrlp:input.c.page1.prdesite
         ON ACTION controlp INFIELD prdesite
            #add-point:ON ACTION controlp INFIELD prdesite

            #END add-point
 
         #----<<prdeunit>>----
         #Ctrlp:input.c.page1.prdeunit
         ON ACTION controlp INFIELD prdeunit
            #add-point:ON ACTION controlp INFIELD prdeunit

            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_prde_d[l_ac].* = g_prde_d_t.*
               CLOSE aprq211_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_prde_d[l_ac].prde002
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               LET g_prde_d[l_ac].* = g_prde_d_t.*
            ELSE
            
               #add-point:單身修改前

               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               #LET .prdemodid = g_user 
#LET .prdemoddt = cl_get_current()
 
      
               UPDATE prde_t SET (prde001,prde002,prdeacti,prde003,prde004,prdesite,prdeunit) = (g_prdw_m.prdw001, 
                   g_prde_d[l_ac].prde002,g_prde_d[l_ac].prdeacti,g_prde_d[l_ac].prde003,g_prde_d[l_ac].prde004, 
                   g_prde_d[l_ac].prdesite,g_prde_d[l_ac].prdeunit)
                WHERE prdeent = g_enterprise AND prde001 = g_prdw_m.prdw001 
 
                  AND prde002 = g_prde_d_t.prde002 #項次   
 
                  
               #add-point:單身修改中

               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "prde_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                     LET g_prde_d[l_ac].* = g_prde_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "prde_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
                     LET g_prde_d[l_ac].* = g_prde_d_t.*                     
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdw_m.prdw001
               LET gs_keys_bak[1] = g_prdw001_t
               LET gs_keys[2] = g_prde_d[g_detail_idx].prde002
               LET gs_keys_bak[2] = g_prde_d_t.prde002
               CALL aprq211_update_b('prde_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
               END CASE
               
               #add-point:單身修改後
#               IF p_cmd = 'u' THEN
#                  LET l_time = cl_get_current()
#                  UPDATE prdw_t SET prdwmodid = g_user,
#                                    prdwmoddt = l_time
#                   WHERE prdwent = g_enterprise
#                     AND prdadocno = g_prdw_m.prdadocno
#                  IF SQLCA.SQLcode  THEN
#                     CALL cl_err("upd prdw_t",SQLCA.sqlcode,1)
#                     CALL s_transaction_end('N','0')
#                  END IF
#               END IF
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row

            #end add-point
            CALL aprq211_unlock_b("prde_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
              
         AFTER INPUT
            #add-point:input段after input 

            #end add-point 
 
         ON ACTION controlo    
            CALL FGL_SET_ARR_CURR(g_prde_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_prde_d.getLength()+1
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_prde2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prde2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aprq211_b_fill()
            LET g_rec_b = g_prde2_d.getLength()
            #add-point:資料輸入前

            #end add-point
            
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_prde2_d[l_ac].* TO NULL 
                  LET g_prde2_d[l_ac].prdg003 = "4"
 
 
            LET g_prde2_d_t.* = g_prde2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprq211_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b

            #end add-point
            CALL aprq211_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prde2_d[li_reproduce_target].* = g_prde2_d[li_reproduce].*
 
               LET g_prde2_d[li_reproduce_target].prdg002 = NULL
               LET g_prde2_d[li_reproduce_target].prdg003 = NULL
               LET g_prde2_d[li_reproduce_target].prdg004 = NULL
            END IF
            #公用欄位給值(單身2)
            #此段落由子樣板a14產生    
      #LET .prdgownid = g_user
      #LET .prdgowndp = g_dept
      #LET .prdgcrtid = g_user
      #LET .prdgcrtdp = g_dept 
      #LET .prdgcrtdt = cl_get_current()
      #LET .prdgmodid = ""
      #LET .prdgmoddt = ""
      #LET g_prde2_d[l_ac].prdgstus = ""
 
 
            
            #add-point:modify段before insert
#            SELECT MAX(prdg002)+1 INTO g_prde2_d[l_ac].prdg002
#              FROM prdg_t
#             WHERE prdgent = g_enterprise
#               AND prdgdocno = g_prdw_m.prdadocno
#            IF cl_null(g_prde2_d[l_ac].prdg002) THEN
#               LET g_prde2_d[l_ac].prdg002 = 1
#            END IF
#            LET g_prde2_d[l_ac].prdg001 = g_prdw_m.prdw001
#            LET g_prde2_d[l_ac].prdgunit = g_site
#            LET g_prde2_d[l_ac].prdgsite = g_site
            #end add-point  
            
         BEFORE ROW     
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aprq211_cl USING g_enterprise,g_prdw_m.prdwsite,g_prdw_m.prdw001
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN aprq211_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               CLOSE aprq211_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_prde2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prde2_d[l_ac].prdg002 IS NOT NULL
               AND g_prde2_d[l_ac].prdg003 IS NOT NULL
               AND g_prde2_d[l_ac].prdg004 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_prde2_d_t.* = g_prde2_d[l_ac].*  #BACKUP
               CALL aprq211_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b

               #end add-point  
               CALL aprq211_set_no_entry_b(l_cmd)
               IF NOT aprq211_lock_b("prdg_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprq211_bcl2 INTO g_prde2_d[l_ac].prdgacti,g_prde2_d[l_ac].prdg002,g_prde2_d[l_ac].prdg003, 
                      g_prde2_d[l_ac].prdg004,g_prde2_d[l_ac].prdg004_desc,g_prde2_d[l_ac].prdg005,g_prde2_d[l_ac].prdg006, 
                      g_prde2_d[l_ac].prdg006_desc,g_prde2_d[l_ac].prdg007,g_prde2_d[l_ac].prdgsite, 
                      g_prde2_d[l_ac].prdgunit
                   IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL aprq211_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row

            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_prde2_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_prde2_d.deleteElement(l_ac)
               NEXT FIELD prdg002
            END IF
         
            IF g_prde2_d[l_ac].prdg002 IS NOT NULL
               AND g_prde2_d_t.prdg003 IS NOT NULL
               AND g_prde2_d_t.prdg004 IS NOT NULL
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
               
               #add-point:單身2刪除前

               #end add-point    
               
               DELETE FROM prdg_t
                WHERE prdgent = g_enterprise AND prdg001 = g_prdw_m.prdw001 AND
                      prdg002 = g_prde2_d_t.prdg002
                  AND prdg003 = g_prde2_d_t.prdg003
                  AND prdg004 = g_prde2_d_t.prdg004
                  
               #add-point:單身2刪除中

               #end add-point    
                  
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "prde_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  
                  #add-point:單身2刪除後

                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE aprq211_bcl
               LET l_count = g_prde_d.getLength()
            END IF 
            
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdw_m.prdw001
               LET gs_keys[2] = g_prde2_d[g_detail_idx].prdg002
               LET gs_keys[3] = g_prde2_d[g_detail_idx].prdg003
               LET gs_keys[4] = g_prde2_d[g_detail_idx].prdg004
 
            
         AFTER DELETE 
            #add-point:單身AFTER DELETE 

            #end add-point
                           CALL aprq211_delete_b('prdg_t',gs_keys,"'2'")
 
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
               
            #add-point:單身2新增前

            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM prdg_t 
             WHERE prdgent = g_enterprise AND prdg001 = g_prdw_m.prdw001
               AND prdg002 = g_prde2_d[l_ac].prdg002
               AND prdg003 = g_prde2_d[l_ac].prdg003
               AND prdg004 = g_prde2_d[l_ac].prdg004
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前

               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdw_m.prdw001
               LET gs_keys[2] = g_prde2_d[g_detail_idx].prdg002
               LET gs_keys[3] = g_prde2_d[g_detail_idx].prdg003
               LET gs_keys[4] = g_prde2_d[g_detail_idx].prdg004
               CALL aprq211_insert_b('prdg_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               INITIALIZE g_prde_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "prdg_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprq211_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後
#               IF p_cmd = 'u' THEN
#                  LET l_time = cl_get_current()
#                  UPDATE prdw_t SET prdwmodid = g_user,
#                                    prdwmoddt = l_time
#                   WHERE prdwent = g_enterprise
#                     AND prdadocno = g_prdw_m.prdadocno
#                  IF SQLCA.SQLcode  THEN
#                     CALL cl_err("upd prdw_t",SQLCA.sqlcode,1)
#                     CALL s_transaction_end('N','0')
#                     CANCEL INSERT
#                  END IF
#               END IF
               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_prde2_d[l_ac].* = g_prde2_d_t.*
               CLOSE aprq211_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               LET g_prde2_d[l_ac].* = g_prde2_d_t.*
            ELSE
               #add-point:單身page2修改前

               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               #LET .prdgmodid = g_user 
#LET .prdgmoddt = cl_get_current()
 
               
               UPDATE prdg_t SET (prdg001,prdgacti,prdg002,prdg011,prdg003,prdg004,prdg005,prdg006,prdg007,prdgsite, 
                   prdgunit,prdg010) = (g_prdw_m.prdw001,g_prde2_d[l_ac].prdgacti,g_prde2_d[l_ac].prdg002,g_prde2_d[l_ac].prdg011,g_prde2_d[l_ac].prdg003, 
                   g_prde2_d[l_ac].prdg004,g_prde2_d[l_ac].prdg005,g_prde2_d[l_ac].prdg006,g_prde2_d[l_ac].prdg007, 
                   g_prde2_d[l_ac].prdgsite,g_prde2_d[l_ac].prdgunit,g_prde2_d[l_ac].prdg010) #自訂欄位頁簽
                WHERE prdgent = g_enterprise AND prdg001 = g_prdw_m.prdw001
                  AND prdg002 = g_prde2_d_t.prdg002 #項次 
                  AND prdg003 = g_prde2_d_t.prdg003
                  AND prdg004 = g_prde2_d_t.prdg004
                  
               #add-point:單身page2修改中

               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "prdg_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                     LET g_prde2_d[l_ac].* = g_prde2_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "prdg_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                     LET g_prde2_d[l_ac].* = g_prde2_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdw_m.prdw001
               LET gs_keys_bak[1] = g_prdw001_t
               LET gs_keys[2] = g_prde2_d[g_detail_idx].prdg002
               LET gs_keys_bak[2] = g_prde2_d_t.prdg002
               LET gs_keys[3] = g_prde2_d[g_detail_idx].prdg003
               LET gs_keys_bak[3] = g_prde2_d_t.prdg003
               LET gs_keys[4] = g_prde2_d[g_detail_idx].prdg004
               LET gs_keys_bak[4] = g_prde2_d_t.prdg004
               CALL aprq211_update_b('prdg_t',gs_keys,gs_keys_bak,"'2'")
                     #資料多語言用-增/改
                     
               END CASE
               #add-point:單身page2修改後
#               IF p_cmd = 'u' THEN
#                  LET l_time = cl_get_current()
#                  UPDATE prdw_t SET prdwmodid = g_user,
#                                    prdwmoddt = l_time
#                   WHERE prdwent = g_enterprise
#                     AND prdadocno = g_prdw_m.prdadocno
#                  IF SQLCA.SQLcode  THEN
#                     CALL cl_err("upd prdw_t",SQLCA.sqlcode,1)
#                     CALL s_transaction_end('N','0')
#                  END IF
#               END IF
               #end add-point
            END IF
         
         #---------------------<  Detail: page2  >---------------------
         #----<<prdgstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdgacti
            #add-point:BEFORE FIELD prdgstus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdgacti
            
            #add-point:AFTER FIELD prdgstus

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdgacti
            #add-point:ON CHANGE prdgstus

            #END add-point
 
         #----<<prdg002>>----
         #此段落由子樣板a02產生
         AFTER FIELD prdg002
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_prde2_d[l_ac].prdg002,"0","0","","","azz-00079",1) THEN
               NEXT FIELD prdg002
            END IF
 
 
            #add-point:AFTER FIELD prdg002
            #此段落由子樣板a05產生
#            IF g_prdw_m.prdadocno IS NOT NULL AND g_prde2_d[g_detail_idx].prdg002 IS NOT NULL AND g_prde2_d[g_detail_idx].prdg003 IS NOT NULL AND g_prde2_d[g_detail_idx].prdg004 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prdw_m.prdadocno != g_prdwdocno_t OR g_prde2_d[g_detail_idx].prdg002 != g_prde2_d_t.prdg002 OR g_prde2_d[g_detail_idx].prdg003 != g_prde2_d_t.prdg003 OR g_prde2_d[g_detail_idx].prdg004 != g_prde2_d_t.prdg004)) THEN 
#                  IF NOT ap_chk_notDup(g_prde2_d[l_ac].prdg002,"SELECT COUNT(*) FROM prdg_t WHERE "||"prdgent = '" ||g_enterprise|| "' AND "||"prdgdocno = '"||g_prdw_m.prdadocno ||"' AND "|| "prdg002 = '"||g_prde2_d[g_detail_idx].prdg002 ||"' AND "|| "prdg003 = '"||g_prde2_d[g_detail_idx].prdg003 ||"' AND "|| "prdg004 = '"||g_prde2_d[g_detail_idx].prdg004 ||"' ",'std-00004',1) THEN 
#                     LET g_prde2_d[l_ac].prdg002 = g_prde2_d_t.prdg002
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdg002
            #add-point:BEFORE FIELD prdg002

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE prdg002
            #add-point:ON CHANGE prdg002

            #END add-point
 
         #----<<prdg003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdg003
            #add-point:BEFORE FIELD prdg003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdg003
            
            #add-point:AFTER FIELD prdg003
            #此段落由子樣板a05產生
#            IF g_prdw_m.prdadocno IS NOT NULL AND g_prde2_d[g_detail_idx].prdg002 IS NOT NULL AND g_prde2_d[g_detail_idx].prdg003 IS NOT NULL AND g_prde2_d[g_detail_idx].prdg004 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prdw_m.prdadocno != g_prdwdocno_t OR g_prde2_d[g_detail_idx].prdg002 != g_prde2_d_t.prdg002 OR g_prde2_d[g_detail_idx].prdg003 != g_prde2_d_t.prdg003 OR g_prde2_d[g_detail_idx].prdg004 != g_prde2_d_t.prdg004)) THEN 
#                  IF NOT ap_chk_notDup(g_prde2_d[l_ac].prdg003,"SELECT COUNT(*) FROM prdg_t WHERE "||"prdgent = '" ||g_enterprise|| "' AND "||"prdgdocno = '"||g_prdw_m.prdadocno ||"' AND "|| "prdg002 = '"||g_prde2_d[g_detail_idx].prdg002 ||"' AND "|| "prdg003 = '"||g_prde2_d[g_detail_idx].prdg003 ||"' AND "|| "prdg004 = '"||g_prde2_d[g_detail_idx].prdg004 ||"' ",'std-00004',1) THEN 
#                     LET g_prde2_d[l_ac].prdg003 = g_prde2_d_t.prdg003
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
#            IF NOT cl_null(g_prde2_d[l_ac].prdg003) THEN
#               IF l_cmd = 'a' THEN
#                  LET g_prde2_d[l_ac].prdg004 = ""
#                  DISPLAY BY NAME g_prde2_d[l_ac].prdg004
#               END IF
#               IF NOT cl_null(g_prde2_d[l_ac].prdg004) THEN
#                  IF NOT aprq211_chk_prdg004() THEN
#                     LET g_prde2_d[l_ac].prdg003 = g_prde2_d_t.prdg003
#                     NEXT FIELD prdg003
#                  END IF
#               END IF   
#            END IF
#            CALL aprq211_set_entry_b(l_cmd)
#            CALL aprq211_set_no_entry_b(l_cmd)

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdg003
            #add-point:ON CHANGE prdg003

            #END add-point
 
         #----<<prdg004>>----
         #此段落由子樣板a02產生
         AFTER FIELD prdg004
            
            #add-point:AFTER FIELD prdg004
            #此段落由子樣板a05產生
#            CALL aprq211_prdg_desc()
#            IF g_prdw_m.prdadocno IS NOT NULL AND g_prde2_d[g_detail_idx].prdg002 IS NOT NULL AND g_prde2_d[g_detail_idx].prdg003 IS NOT NULL AND g_prde2_d[g_detail_idx].prdg004 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prdw_m.prdadocno != g_prdwdocno_t OR g_prde2_d[g_detail_idx].prdg002 != g_prde2_d_t.prdg002 OR g_prde2_d[g_detail_idx].prdg003 != g_prde2_d_t.prdg003 OR g_prde2_d[g_detail_idx].prdg004 != g_prde2_d_t.prdg004)) THEN 
#                  IF NOT ap_chk_notDup(g_prde2_d[l_ac].prdg004,"SELECT COUNT(*) FROM prdg_t WHERE "||"prdgent = '" ||g_enterprise|| "' AND "||"prdgdocno = '"||g_prdw_m.prdadocno ||"' AND "|| "prdg002 = '"||g_prde2_d[g_detail_idx].prdg002 ||"' AND "|| "prdg003 = '"||g_prde2_d[g_detail_idx].prdg003 ||"' AND "|| "prdg004 = '"||g_prde2_d[g_detail_idx].prdg004 ||"' ",'std-00004',1) THEN 
#                     LET g_prde2_d[l_ac].prdg004 = g_prde2_d_t.prdg004
#                     CALL aprq211_prdg_desc()
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
#            IF NOT cl_null(g_prde2_d[l_ac].prdg004) THEN
#               IF NOT cl_null(g_prde2_d[l_ac].prdg003) THEN
#                  IF NOT aprq211_chk_prdg004() THEN
#                     LET g_prde2_d[l_ac].prdg004 = g_prde2_d_t.prdg004
#                     CALL aprq211_prdg_desc()
#                     NEXT FIELD CURRENT
#                  END IF
#                  IF g_prde2_d[l_ac].prdg003 = '4' THEN
#                     CALL aprq211_prdg004_def()
#                  END IF
#               END IF   
#            END IF

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdg004
            #add-point:BEFORE FIELD prdg004

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE prdg004
            #add-point:ON CHANGE prdg004

            #END add-point
 
         #----<<prdg005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdg005
            #add-point:BEFORE FIELD prdg005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdg005
            
            #add-point:AFTER FIELD prdg005
#            IF NOT cl_null(g_prde2_d[l_ac].prdg005) THEN
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_prde2_d[l_ac].prdg005
#               #呼叫檢查存在並帶值的library
#               IF NOT cl_chk_exist("v_imay003_1") THEN
#                  LET g_prde2_d[l_ac].prdg005 = g_prde2_d_t.prdg005
#                  NEXT FIELD CURRENT
#               END IF
#               IF g_prde2_d[l_ac].prdg003 = '4' THEN
#                  LET l_n1 = 0
#                  SELECT COUNT(*) INTO l_n1
#                    FROM imay_t
#                   WHERE imayent = g_enterprise
#                     AND imay003 = g_prde2_d[l_ac].prdg005
#                  IF l_n1 = 1 THEN
#                     SELECT imay001 INTO l_prdg004
#                       FROM imay_t
#                      WHERE imayent = g_enterprise
#                        AND imay003 = g_prde2_d[l_ac].prdg005
#                     IF NOT cl_null(l_prdg004) THEN
#                        LET l_n1 = 0
#                        SELECT COUNT(*) INTO l_n1
#                          FROM prdg_t
#                         WHERE prdgent = g_enterprise
#                           AND prdgdocno = g_prdw_m.prdadocno
#                           AND prdg004 = l_prdg004
#                           AND prdg002 <> g_prde2_d[l_ac].prdg002
#                        IF l_n1 > 0 THEN
#                           CALL cl_err(l_prdg004,'apr-00197',1)
#                           LET g_prde2_d[l_ac].prdg005 = g_prde2_d_t.prdg005
#                           NEXT FIELD CURRENT
#                        END IF
#                     END IF
#                     LET g_prde2_d[l_ac].prdg004 = l_prdg004
#                     CALL aprq211_prdg004_def() 
#                  END IF
#               END IF
#               CALL aprq211_prdg_desc()   
#            END IF               
#                
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdg005
            #add-point:ON CHANGE prdg005

            #END add-point
 
         #----<<prdg006>>----
         #此段落由子樣板a02產生
         AFTER FIELD prdg006
            
            #add-point:AFTER FIELD prdg006
 
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdg006
            #add-point:BEFORE FIELD prdg006

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE prdg006
            #add-point:ON CHANGE prdg006

            #END add-point
 
         #----<<prdg007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdg007
            #add-point:BEFORE FIELD prdg007

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdg007
            
            #add-point:AFTER FIELD prdg007

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdg007
            #add-point:ON CHANGE prdg007

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
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdgsite
            #add-point:ON CHANGE prdgsite

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
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdgunit
            #add-point:ON CHANGE prdgunit

            #END add-point
 
 
         #---------------------<  Detail: page2  >---------------------
         #----<<prdgstus>>----
         #Ctrlp:input.c.page2.prdgstus
         ON ACTION controlp INFIELD prdgacti
            #add-point:ON ACTION controlp INFIELD prdgstus

            #END add-point
 
         #----<<prdg002>>----
         #Ctrlp:input.c.page2.prdg002
         ON ACTION controlp INFIELD prdg002
            #add-point:ON ACTION controlp INFIELD prdg002

            #END add-point
 
         #----<<prdg003>>----
         #Ctrlp:input.c.page2.prdg003
         ON ACTION controlp INFIELD prdg003
            #add-point:ON ACTION controlp INFIELD prdg003

            #END add-point
 
         #----<<prdg004>>----
         #Ctrlp:input.c.page2.prdg004
         ON ACTION controlp INFIELD prdg004
            #add-point:ON ACTION controlp INFIELD prdg004
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_prde2_d[l_ac].prdg004             #給予default值

            IF g_prde2_d[l_ac].prdg003 = '4' THEN
               LET g_qryparam.arg1 = g_site
               CALL q_rtdx001_12()
            END IF                      
            IF g_prde2_d[l_ac].prdg003 = '5' THEN
               CALL q_rtax001()
            END IF
            IF g_prde2_d[l_ac].prdg003 = '6' THEN
               LET g_qryparam.arg1 = '2000'
               CALL q_oocq002()
            END IF
            IF g_prde2_d[l_ac].prdg003 = '7' THEN
               LET g_qryparam.arg1 = '2001'
               CALL q_oocq002()
            END IF
            IF g_prde2_d[l_ac].prdg003 = '8' THEN
               LET g_qryparam.arg1 = '2002'
               CALL q_oocq002()
            END IF
            IF g_prde2_d[l_ac].prdg003 = '9' THEN
               LET g_qryparam.arg1 = '2003'
               CALL q_oocq002()
            END IF
            IF g_prde2_d[l_ac].prdg003 = 'A' THEN
               LET g_qryparam.arg1 = '2004'
               CALL q_oocq002()
            END IF
            IF g_prde2_d[l_ac].prdg003 = 'B' THEN
               LET g_qryparam.arg1 = '2005'
               CALL q_oocq002()
            END IF
            IF g_prde2_d[l_ac].prdg003 = 'C' THEN
               LET g_qryparam.arg1 = '2006'
               CALL q_oocq002()
            END IF
            IF g_prde2_d[l_ac].prdg003 = 'D' THEN
               LET g_qryparam.arg1 = '2007'
               CALL q_oocq002()
            END IF
            IF g_prde2_d[l_ac].prdg003 = 'E' THEN
               LET g_qryparam.arg1 = '2008'
               CALL q_oocq002()
            END IF
            IF g_prde2_d[l_ac].prdg003 = 'F' THEN
               LET g_qryparam.arg1 = '2009'
               CALL q_oocq002()
            END IF
            IF g_prde2_d[l_ac].prdg003 = 'G' THEN
               LET g_qryparam.arg1 = '2010'
               CALL q_oocq002()
            END IF
            IF g_prde2_d[l_ac].prdg003 = 'H' THEN
               LET g_qryparam.arg1 = '2011'
               CALL q_oocq002()
            END IF
            IF g_prde2_d[l_ac].prdg003 = 'I' THEN
               LET g_qryparam.arg1 = '2012'
               CALL q_oocq002()
            END IF
            IF g_prde2_d[l_ac].prdg003 = 'J' THEN
               LET g_qryparam.arg1 = '2013'
               CALL q_oocq002()
            END IF
            IF g_prde2_d[l_ac].prdg003 = 'K' THEN
               LET g_qryparam.arg1 = '2014'
               CALL q_oocq002()
            END IF
            IF g_prde2_d[l_ac].prdg003 = 'L' THEN
               LET g_qryparam.arg1 = '2015'
               CALL q_oocq002()
            END IF
            ##add by zn --str  #160728-00006#24
            IF g_prde2_d[l_ac].prdg003 = '14' THEN
               CALL q_mhbc001_1()
            END IF
            ##add by zn  --str
            LET g_prde2_d[l_ac].prdg004 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_prde2_d[l_ac].prdg004 TO prdg004              #顯示到畫面上
            CALL aprq211_prdg_desc()
            NEXT FIELD prdg004                                      #返回原欄位
            #END add-point
 
         #----<<prdg005>>----
         #Ctrlp:input.c.page2.prdg005
         ON ACTION controlp INFIELD prdg005
            #add-point:ON ACTION controlp INFIELD prdg005
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prde2_d[l_ac].prdg005             #給予default值

            #給予arg

            CALL q_imay003_2()                                #呼叫開窗

            LET g_prde2_d[l_ac].prdg005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prde2_d[l_ac].prdg005 TO prdg005              #顯示到畫面上

            NEXT FIELD prdg005                          #返回原欄位


            #END add-point
 
         #----<<prdg006>>----
         #Ctrlp:input.c.page2.prdg006
         ON ACTION controlp INFIELD prdg006
            #add-point:ON ACTION controlp INFIELD prdg006
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prde2_d[l_ac].prdg006             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_prde2_d[l_ac].prdg006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prde2_d[l_ac].prdg006 TO prdg006              #顯示到畫面上

            NEXT FIELD prdg006                          #返回原欄位


            #END add-point
 
         #----<<prdg007>>----
         #Ctrlp:input.c.page2.prdg007
         ON ACTION controlp INFIELD prdg007
            #add-point:ON ACTION controlp INFIELD prdg007

            #END add-point
 
         #----<<prdgsite>>----
         #Ctrlp:input.c.page2.prdgsite
         ON ACTION controlp INFIELD prdgsite
            #add-point:ON ACTION controlp INFIELD prdgsite

            #END add-point
 
         #----<<prdgunit>>----
         #Ctrlp:input.c.page2.prdgunit
         ON ACTION controlp INFIELD prdgunit
            #add-point:ON ACTION controlp INFIELD prdgunit

            #END add-point
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row

            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_prde2_d[l_ac].* = g_prde2_d_t.*
               END IF
               CLOSE aprq211_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aprq211_unlock_b("prdg_t","'2'")
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input 

            #end add-point   
    
         ON ACTION controlo
            CALL FGL_SET_ARR_CURR(g_prde2_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_prde2_d.getLength()+1
 
      END INPUT
      INPUT ARRAY g_prde3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prde3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aprq211_b_fill()
            LET g_rec_b = g_prde3_d.getLength()
            #add-point:資料輸入前

            #end add-point
            
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_prde3_d[l_ac].* TO NULL 
            
            LET g_prde3_d_t.* = g_prde3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprq211_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b

            #end add-point
            CALL aprq211_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prde3_d[li_reproduce_target].* = g_prde3_d[li_reproduce].*
 
               LET g_prde3_d[li_reproduce_target].prdf002 = NULL
            END IF
            #公用欄位給值(單身3)
            #此段落由子樣板a14產生    
      #LET .prdfownid = g_user
      #LET .prdfowndp = g_dept
      #LET .prdfcrtid = g_user
      #LET .prdfcrtdp = g_dept 
      #LET .prdfcrtdt = cl_get_current()
      #LET .prdfmodid = ""
      #LET .prdfmoddt = ""
      #LET g_prde3_d[l_ac].prdfstus = ""
 
 
            
            #add-point:modify段before insert
#            SELECT MAX(prdf002)+1 INTO g_prde3_d[l_ac].prdf002
#              FROM prdf_t
#             WHERE prdfent = g_enterprise
#               AND prdfdocno = g_prdw_m.prdadocno
#            IF cl_null(g_prde3_d[l_ac].prdf002) THEN
#               LET g_prde3_d[l_ac].prdf002 = 1
#            END IF
#            LET g_prde3_d[l_ac].prdf001 = g_prdw_m.prdw001
#            LET g_prde3_d[l_ac].prdfunit = g_site
#            LET g_prde3_d[l_ac].prdfsite = g_site
            #end add-point  
            
         BEFORE ROW     
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aprq211_cl USING g_enterprise,g_prdw_m.prdwsite,g_prdw_m.prdw001
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN aprq211_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               CLOSE aprq211_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_prde3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prde3_d[l_ac].prdf002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_prde3_d_t.* = g_prde3_d[l_ac].*  #BACKUP
               CALL aprq211_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b

               #end add-point  
               CALL aprq211_set_no_entry_b(l_cmd)
               IF NOT aprq211_lock_b("prdf_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprq211_bcl3 INTO g_prde3_d[l_ac].prdfacti,g_prde3_d[l_ac].prdf003,g_prde3_d[l_ac].prdf003_desc, 
                      g_prde3_d[l_ac].prdf004,g_prde3_d[l_ac].prdf004_desc,g_prde3_d[l_ac].prdf002,g_prde3_d[l_ac].prdfsite, 
                      g_prde3_d[l_ac].prdfunit
                   IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL aprq211_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row

            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_prde3_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_prde3_d.deleteElement(l_ac)
               NEXT FIELD prdf002
            END IF
         
            IF g_prde3_d[l_ac].prdf002 IS NOT NULL
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
               
               #add-point:單身3刪除前

               #end add-point    
               
               DELETE FROM prdf_t
                WHERE prdfent = g_enterprise AND prdf001 = g_prdw_m.prdw001 AND
                      prdf002 = g_prde3_d_t.prdf002
                  
               #add-point:單身3刪除中

               #end add-point    
                  
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "prde_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  
                  #add-point:單身3刪除後

                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE aprq211_bcl
               LET l_count = g_prde_d.getLength()
            END IF 
            
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdw_m.prdw001
               LET gs_keys[2] = g_prde3_d[g_detail_idx].prdf002
 
            
         AFTER DELETE 
            #add-point:單身AFTER DELETE 

            #end add-point
                           CALL aprq211_delete_b('prdf_t',gs_keys,"'3'")
 
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
               
            #add-point:單身3新增前

            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM prdf_t 
             WHERE prdfent = g_enterprise AND prdf001 = g_prdw_m.prdw001
               AND prdf002 = g_prde3_d[l_ac].prdf002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前

               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdw_m.prdw001
               LET gs_keys[2] = g_prde3_d[g_detail_idx].prdf002
               CALL aprq211_insert_b('prdf_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               INITIALIZE g_prde_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "prdf_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprq211_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後
#               IF p_cmd = 'u' THEN
#                  LET l_time = cl_get_current()
#                  UPDATE prdw_t SET prdwmodid = g_user,
#                                    prdwmoddt = l_time
#                   WHERE prdwent = g_enterprise
#                     AND prdadocno = g_prdw_m.prdadocno
#                  IF SQLCA.SQLcode  THEN
#                     CALL cl_err("upd prdw_t",SQLCA.sqlcode,1)
#                     CALL s_transaction_end('N','0')
#                     CANCEL INSERT
#                  END IF
#               END IF
               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_prde3_d[l_ac].* = g_prde3_d_t.*
               CLOSE aprq211_bcl3
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               LET g_prde3_d[l_ac].* = g_prde3_d_t.*
            ELSE
               #add-point:單身page3修改前

               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               #LET .prdfmodid = g_user 
#LET .prdfmoddt = cl_get_current()
 
               
               UPDATE prdf_t SET (prdf001,prdfacti,prdf003,prdf004,prdf002,prdfsite,prdfunit) = (g_prdw_m.prdw001, 
                   g_prde3_d[l_ac].prdfacti,g_prde3_d[l_ac].prdf003,g_prde3_d[l_ac].prdf004,g_prde3_d[l_ac].prdf002, 
                   g_prde3_d[l_ac].prdfsite,g_prde3_d[l_ac].prdfunit) #自訂欄位頁簽
                WHERE prdfent = g_enterprise AND prdf001 = g_prdw_m.prdw001
                  AND prdf002 = g_prde3_d_t.prdf002 #項次 
                  
               #add-point:單身page3修改中

               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "prdf_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                     LET g_prde3_d[l_ac].* = g_prde3_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "prdf_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                     LET g_prde3_d[l_ac].* = g_prde3_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdw_m.prdw001
               LET gs_keys_bak[1] = g_prdw001_t
               LET gs_keys[2] = g_prde3_d[g_detail_idx].prdf002
               LET gs_keys_bak[2] = g_prde3_d_t.prdf002
               CALL aprq211_update_b('prdf_t',gs_keys,gs_keys_bak,"'3'")
                     #資料多語言用-增/改
                     
               END CASE
               #add-point:單身page3修改後
#               IF p_cmd = 'u' THEN
#                  LET l_time = cl_get_current()
#                  UPDATE prdw_t SET prdwmodid = g_user,
#                                    prdwmoddt = l_time
#                   WHERE prdwent = g_enterprise
#                     AND prdadocno = g_prdw_m.prdadocno
#                  IF SQLCA.SQLcode  THEN
#                     CALL cl_err("upd prdw_t",SQLCA.sqlcode,1)
#                     CALL s_transaction_end('N','0')
#                  END IF
#               END IF
               #end add-point
            END IF
         
         #---------------------<  Detail: page3  >---------------------
         #----<<prdfstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdfacti
            #add-point:BEFORE FIELD prdfstus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdfacti
            
            #add-point:AFTER FIELD prdfstus

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdfacti
            #add-point:ON CHANGE prdfstus

            #END add-point
 
         #----<<prdf003>>----
         #此段落由子樣板a02產生
         AFTER FIELD prdf003
            
            #add-point:AFTER FIELD prdf003
            CALL aprq211_prdf_desc()
            IF NOT cl_null(g_prde3_d[l_ac].prdf003) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#31  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prde3_d[l_ac].prdf003
               LET g_chkparam.err_str[1] = "aoo-00196:sub-01302|aooi713|",cl_get_progname("aooi713",g_lang,"2"),"|:EXEPROGaooi713" #160318-00025#31  add
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooia001_2") THEN
                  LET g_prde3_d[l_ac].prdf003 = g_prde3_d_t.prdf003
                  CALL aprq211_prdf_desc()
                  NEXT FIELD CURRENT
               END IF
               CALL aprq211_set_entry_b(l_cmd)
               CALL aprq211_set_no_entry_b(l_cmd)
               LET g_errparam.exeprog = ''  #160318-00005#39 by 07900 add
               LET l_exeprog = ''           #160318-00005#39 by 07900 add
               IF NOT cl_null(g_prde3_d[l_ac].prdf004) THEN
                  CALL aprq211_chk_prdf004()
                  IF NOT cl_null(g_errparam.exeprog)THEN LET l_exeprog = g_errparam.exeprog END IF #160318-00005#39 by 07900 add
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prde3_d[l_ac].prdf003
                     #160318-00005#39  By 07900 --add-str
                     IF NOT cl_null(l_exeprog) THEN
                        CASE g_errno
                            WHEN 'sub-01307'
                                 LET g_errparam.replace[1] = l_exeprog
                                 LET g_errparam.replace[2] = cl_get_progname(l_exeprog,g_lang,"2")
                                 LET g_errparam.exeprog = l_exeprog
                            WHEN 'sub-01302'   
                                 LET g_errparam.replace[1] = l_exeprog
                                 LET g_errparam.replace[2] = cl_get_progname(l_exeprog,g_lang,"2")
                                 LET g_errparam.exeprog = l_exeprog
                        END CASE  
                     END IF                         
                     #160318-00005#39  By 07900 --add-end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prde3_d[l_ac].prdf003 = g_prde3_d_t.prdf003
                     NEXT FIELD prdf003
                  END IF   
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdf003
            #add-point:BEFORE FIELD prdf003

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE prdf003
            #add-point:ON CHANGE prdf003

            #END add-point
 
         #----<<prdf004>>----
         #此段落由子樣板a02產生
         AFTER FIELD prdf004
            
            #add-point:AFTER FIELD prdf004
            CALL aprq211_prdf_desc()
            IF NOT cl_null(g_prde3_d[l_ac].prdf004) THEN
               LET g_errparam.exeprog = ''  #160318-00005#39 by 07900 add
               LET l_exeprog = ''           #160318-00005#39 by 07900 add
               IF NOT cl_null(g_prde3_d[l_ac].prdf003) THEN
                  CALL aprq211_chk_prdf004()
                  IF NOT cl_null(g_errparam.exeprog)THEN LET l_exeprog = g_errparam.exeprog END IF #160318-00005#39 by 07900 add
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prde3_d[l_ac].prdf004
                      #160318-00005#39  By 07900 --add-str
                     IF NOT cl_null(l_exeprog) THEN
                        CASE g_errno
                            WHEN 'sub-01307'
                                 LET g_errparam.replace[1] = l_exeprog
                                 LET g_errparam.replace[2] = cl_get_progname(l_exeprog,g_lang,"2")
                                 LET g_errparam.exeprog = l_exeprog
                            WHEN 'sub-01302'   
                                 LET g_errparam.replace[1] = l_exeprog
                                 LET g_errparam.replace[2] = cl_get_progname(l_exeprog,g_lang,"2")
                                 LET g_errparam.exeprog = l_exeprog
                        END CASE  
                     END IF                         
                     #160318-00005#39  By 07900 --add-end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prde3_d[l_ac].prdf004 = g_prde3_d_t.prdf004
                     CALL aprq211_prdf_desc()
                     NEXT FIELD prdf004
                  END IF   
               END IF
            END IF

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdf004
            #add-point:BEFORE FIELD prdf004

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE prdf004
            #add-point:ON CHANGE prdf004

            #END add-point
 
         #----<<prdf002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdf002
            #add-point:BEFORE FIELD prdf002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdf002
            
            #add-point:AFTER FIELD prdf002
            #此段落由子樣板a05產生
#            IF  g_prdw_m.prdadocno IS NOT NULL AND g_prde3_d[g_detail_idx].prdf002 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prdw_m.prdadocno != g_prdwdocno_t OR g_prde3_d[g_detail_idx].prdf002 != g_prde3_d_t.prdf002)) THEN 
#                  IF NOT ap_chk_notDup(g_prde3_d[l_ac].prdf002,"SELECT COUNT(*) FROM prdf_t WHERE "||"prdfent = '" ||g_enterprise|| "' AND "||"prdfdocno = '"||g_prdw_m.prdadocno ||"' AND "|| "prdf002 = '"||g_prde3_d[g_detail_idx].prdf002 ||"'",'std-00004',1) THEN 
#                     LET g_prde3_d[l_ac].prdf002 = g_prde3_d_t.prdf002
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
#
#
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdf002
            #add-point:ON CHANGE prdf002

            #END add-point
 
         #----<<prdfsite>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdfsite
            #add-point:BEFORE FIELD prdfsite

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdfsite
            
            #add-point:AFTER FIELD prdfsite

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdfsite
            #add-point:ON CHANGE prdfsite

            #END add-point
 
         #----<<prdfunit>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdfunit
            #add-point:BEFORE FIELD prdfunit

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdfunit
            
            #add-point:AFTER FIELD prdfunit

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdfunit
            #add-point:ON CHANGE prdfunit

            #END add-point
 
 
         #---------------------<  Detail: page3  >---------------------
         #----<<prdfstus>>----
         #Ctrlp:input.c.page3.prdfstus
         ON ACTION controlp INFIELD prdfacti
            #add-point:ON ACTION controlp INFIELD prdfstus

            #END add-point
 
         #----<<prdf003>>----
         #Ctrlp:input.c.page3.prdf003
         ON ACTION controlp INFIELD prdf003
            #add-point:ON ACTION controlp INFIELD prdf003
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prde3_d[l_ac].prdf003             #給予default值

            #給予arg

            CALL q_ooia001()                                #呼叫開窗

            LET g_prde3_d[l_ac].prdf003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prde3_d[l_ac].prdf003 TO prdf003              #顯示到畫面上
            CALL aprq211_prdf_desc()
            NEXT FIELD prdf003                          #返回原欄位


            #END add-point
 
         #----<<prdf004>>----
         #Ctrlp:input.c.page3.prdf004
         ON ACTION controlp INFIELD prdf004
            #add-point:ON ACTION controlp INFIELD prdf004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_prde3_d[l_ac].prdf004   #給予default值
            #給予arg
            IF NOT cl_null(g_prde3_d[l_ac].prdf003) THEN
               LET l_ooia002 = ''
               SELECT ooia002 INTO l_ooia002
                 FROM ooia_t
                WHERE ooiaent = g_enterprise
                  AND ooia001 = g_prde3_d[l_ac].prdf003
               IF l_ooia002 = '40' THEN
                  CALL q_gcaf001_4()
               END IF
               IF l_ooia002 = '60' THEN
                  CALL q_mman001_7()
               END IF
            END IF

            LET g_prde3_d[l_ac].prdf004  = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_prde3_d[l_ac].prdf004  TO prdf004         #顯示到畫面上
            CALL aprq211_prdf_desc()
            NEXT FIELD prdf004      
            #END add-point
 
         #----<<prdf002>>----
         #Ctrlp:input.c.page3.prdf002
         ON ACTION controlp INFIELD prdf002
            #add-point:ON ACTION controlp INFIELD prdf002

            #END add-point
 
         #----<<prdfsite>>----
         #Ctrlp:input.c.page3.prdfsite
         ON ACTION controlp INFIELD prdfsite
            #add-point:ON ACTION controlp INFIELD prdfsite

            #END add-point
 
         #----<<prdfunit>>----
         #Ctrlp:input.c.page3.prdfunit
         ON ACTION controlp INFIELD prdfunit
            #add-point:ON ACTION controlp INFIELD prdfunit

            #END add-point
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row

            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_prde3_d[l_ac].* = g_prde3_d_t.*
               END IF
               CLOSE aprq211_bcl3
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aprq211_unlock_b("prdf_t","'3'")
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input 

            #end add-point   
    
         ON ACTION controlo
            CALL FGL_SET_ARR_CURR(g_prde3_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_prde3_d.getLength()+1
 
      END INPUT
      INPUT ARRAY g_prde4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_4)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prde4_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aprq211_b_fill()
            LET g_rec_b = g_prde4_d.getLength()
            #add-point:資料輸入前

            #end add-point
            
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_prde4_d[l_ac].* TO NULL 
            
            LET g_prde4_d_t.* = g_prde4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprq211_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b

            #end add-point
            CALL aprq211_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prde4_d[li_reproduce_target].* = g_prde4_d[li_reproduce].*
 
               LET g_prde4_d[li_reproduce_target].prdd002 = NULL
            END IF
            #公用欄位給值(單身4)
            #此段落由子樣板a14產生    
      #LET .prddownid = g_user
      #LET .prddowndp = g_dept
      #LET .prddcrtid = g_user
      #LET .prddcrtdp = g_dept 
      #LET .prddcrtdt = cl_get_current()
      #LET .prddmodid = ""
      #LET .prddmoddt = ""
      #LET g_prde4_d[l_ac].prddstus = ""
 
 
            
            #add-point:modify段before insert
#            SELECT MAX(prdd002)+1 INTO g_prde4_d[l_ac].prdd002
#              FROM prdd_t
#             WHERE prddent = g_enterprise
#               AND prdddocno = g_prdw_m.prdadocno
            IF cl_null(g_prde4_d[l_ac].prdd002) THEN
               LET g_prde4_d[l_ac].prdd002 = 1
            END IF
#            LET g_prde4_d[l_ac].prdd001 = g_prdw_m.prdw001
            LET g_prde4_d[l_ac].prddunit = g_site
            LET g_prde4_d[l_ac].prddsite = g_site
            LET g_prde4_d[l_ac].prdd005 = '00:00:00'
            LET g_prde4_d[l_ac].prdd006 = '23:59:59'
            #end add-point  
            
         BEFORE ROW     
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aprq211_cl USING g_enterprise,g_prdw_m.prdwsite,g_prdw_m.prdw001
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN aprq211_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               CLOSE aprq211_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_prde4_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prde4_d[l_ac].prdd002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_prde4_d_t.* = g_prde4_d[l_ac].*  #BACKUP
               CALL aprq211_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b

               #end add-point  
               CALL aprq211_set_no_entry_b(l_cmd)
               IF NOT aprq211_lock_b("prdd_t","'4'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprq211_bcl4 INTO g_prde4_d[l_ac].prddacti,g_prde4_d[l_ac].prdd002,g_prde4_d[l_ac].prdd003, 
                      g_prde4_d[l_ac].prdd004,g_prde4_d[l_ac].prdd005,g_prde4_d[l_ac].prdd006,g_prde4_d[l_ac].prdd007, 
                      g_prde4_d[l_ac].prdd008,g_prde4_d[l_ac].prddsite,g_prde4_d[l_ac].prddunit
                   IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL aprq211_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row

            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_prde4_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_prde4_d.deleteElement(l_ac)
               NEXT FIELD prdd002
            END IF
         
            IF g_prde4_d[l_ac].prdd002 IS NOT NULL
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
               
               #add-point:單身4刪除前

               #end add-point    
               
               DELETE FROM prdd_t
                WHERE prddent = g_enterprise AND prdd001 = g_prdw_m.prdw001 AND
                      prdd002 = g_prde4_d_t.prdd002
                  
               #add-point:單身4刪除中

               #end add-point    
                  
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "prde_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  
                  #add-point:單身4刪除後

                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE aprq211_bcl
               LET l_count = g_prde_d.getLength()
            END IF 
            
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdw_m.prdw001
               LET gs_keys[2] = g_prde4_d[g_detail_idx].prdd002
 
            
         AFTER DELETE 
            #add-point:單身AFTER DELETE 

            #end add-point
                           CALL aprq211_delete_b('prdd_t',gs_keys,"'4'")
 
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
               
            #add-point:單身4新增前

            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM prdd_t 
             WHERE prddent = g_enterprise AND prdd001 = g_prdw_m.prdw001
               AND prdd002 = g_prde4_d[l_ac].prdd002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身4新增前

               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdw_m.prdw001
               LET gs_keys[2] = g_prde4_d[g_detail_idx].prdd002
               CALL aprq211_insert_b('prdd_t',gs_keys,"'4'")
                           
               #add-point:單身新增後4

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               INITIALIZE g_prde_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "prdd_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprq211_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後
#               IF p_cmd = 'u' THEN
#                  LET l_time = cl_get_current()
#                  UPDATE prdw_t SET prdwmodid = g_user,
#                                    prdwmoddt = l_time
#                   WHERE prdwent = g_enterprise
#                     AND prdadocno = g_prdw_m.prdadocno
#                  IF SQLCA.SQLcode  THEN
#                     CALL cl_err("upd prdw_t",SQLCA.sqlcode,1)
#                     CALL s_transaction_end('N','0')
#                     CANCEL INSERT
#                  END IF
#               END IF
               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_prde4_d[l_ac].* = g_prde4_d_t.*
               CLOSE aprq211_bcl4
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               LET g_prde4_d[l_ac].* = g_prde4_d_t.*
            ELSE
               #add-point:單身page4修改前

               #end add-point
               
               #寫入修改者/修改日期資訊(單身4)
               #LET .prddmodid = g_user 
#LET .prddmoddt = cl_get_current()
 
               
               UPDATE prdd_t SET (prdd001,prddacti,prdd002,prdd003,prdd004,prdd005,prdd006,prdd007,prdd008, 
                   prddsite,prddunit) = (g_prdw_m.prdw001,g_prde4_d[l_ac].prddacti,g_prde4_d[l_ac].prdd002, 
                   g_prde4_d[l_ac].prdd003,g_prde4_d[l_ac].prdd004,g_prde4_d[l_ac].prdd005,g_prde4_d[l_ac].prdd006, 
                   g_prde4_d[l_ac].prdd007,g_prde4_d[l_ac].prdd008,g_prde4_d[l_ac].prddsite,g_prde4_d[l_ac].prddunit)  
                   #自訂欄位頁簽
                WHERE prddent = g_enterprise AND prdd001 = g_prdw_m.prdw001
                  AND prdd002 = g_prde4_d_t.prdd002 #項次 
                  
               #add-point:單身page4修改中

               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "prdd_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                     LET g_prde4_d[l_ac].* = g_prde4_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "prdd_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                     LET g_prde4_d[l_ac].* = g_prde4_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdw_m.prdw001
               LET gs_keys_bak[1] = g_prdw001_t
               LET gs_keys[2] = g_prde4_d[g_detail_idx].prdd002
               LET gs_keys_bak[2] = g_prde4_d_t.prdd002
               CALL aprq211_update_b('prdd_t',gs_keys,gs_keys_bak,"'4'")
                     #資料多語言用-增/改
                     
               END CASE
               #add-point:單身page4修改後
#               IF p_cmd = 'u' THEN
#                  LET l_time = cl_get_current()
#                  UPDATE prdw_t SET prdwmodid = g_user,
#                                    prdwmoddt = l_time
#                   WHERE prdwent = g_enterprise
#                     AND prdadocno = g_prdw_m.prdadocno
#                  IF SQLCA.SQLcode  THEN
#                     CALL cl_err("upd prdw_t",SQLCA.sqlcode,1)
#                     CALL s_transaction_end('N','0')
#                  END IF
#               END IF
               #end add-point
            END IF
         
         #---------------------<  Detail: page4  >---------------------
         #----<<prddstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prddacti
            #add-point:BEFORE FIELD prddstus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prddacti
            
            #add-point:AFTER FIELD prddstus

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prddacti
            #add-point:ON CHANGE prddstus

            #END add-point
 
         #----<<prdd002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdd002
            #add-point:BEFORE FIELD prdd002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdd002
            
            #add-point:AFTER FIELD prdd002
            #此段落由子樣板a05產生
#            IF  g_prdw_m.prdadocno IS NOT NULL AND g_prde4_d[g_detail_idx].prdd002 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prdw_m.prdadocno != g_prdwdocno_t OR g_prde4_d[g_detail_idx].prdd002 != g_prde4_d_t.prdd002)) THEN 
#                  IF NOT ap_chk_notDup(g_prde4_d[l_ac].prdd002,"SELECT COUNT(*) FROM prdd_t WHERE "||"prddent = '" ||g_enterprise|| "' AND "||"prdddocno = '"||g_prdw_m.prdadocno ||"' AND "|| "prdd002 = '"||g_prde4_d[g_detail_idx].prdd002 ||"'",'std-00004',1) THEN 
#                     LET g_prde4_d[l_ac].prdd002 = g_prde4_d_t.prdd002
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
#
#
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdd002
            #add-point:ON CHANGE prdd002

            #END add-point
 
         #----<<prdd003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdd003
            #add-point:BEFORE FIELD prdd003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdd003
            
            #add-point:AFTER FIELD prdd003
            IF NOT cl_null(g_prde4_d[l_ac].prdd003) AND NOT cl_null(g_prde4_d[l_ac].prdd004) THEN
               IF g_prde4_d[l_ac].prdd003 > g_prde4_d[l_ac].prdd004 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00080'
                  LET g_errparam.extend = g_prde4_d[l_ac].prdd003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prde4_d[l_ac].prdd003 = g_prde4_d_t.prdd003
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
            IF NOT cl_null(g_prde4_d[l_ac].prdd003) AND NOT cl_null(g_prde4_d[l_ac].prdd004) THEN
               IF g_prde4_d[l_ac].prdd003 > g_prde4_d[l_ac].prdd004 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00081'
                  LET g_errparam.extend = g_prde4_d[l_ac].prdd003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prde4_d[l_ac].prdd004 = g_prde4_d_t.prdd004
                  NEXT FIELD prdd004
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdd004
            #add-point:ON CHANGE prdd004

            #END add-point
 
         #----<<prdd005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdd005
            #add-point:BEFORE FIELD prdd005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdd005
            
            #add-point:AFTER FIELD prdd005
            IF NOT cl_null(g_prde4_d[l_ac].prdd005) AND NOT cl_null(g_prde4_d[l_ac].prdd006) THEN
               IF g_prde4_d[l_ac].prdd005 > g_prde4_d[l_ac].prdd006 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apr-00091'
                  LET g_errparam.extend = g_prde4_d[l_ac].prdd005
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prde4_d[l_ac].prdd005 = g_prde4_d_t.prdd005
                  NEXT FIELD prdd005
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdd005
            #add-point:ON CHANGE prdd005

            #END add-point
 
         #----<<prdd006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdd006
            #add-point:BEFORE FIELD prdd006

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdd006
            
            #add-point:AFTER FIELD prdd006
            IF NOT cl_null(g_prde4_d[l_ac].prdd005) AND NOT cl_null(g_prde4_d[l_ac].prdd006) THEN
               IF g_prde4_d[l_ac].prdd005 > g_prde4_d[l_ac].prdd006 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apr-00091'
                  LET g_errparam.extend = g_prde4_d[l_ac].prdd006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prde4_d[l_ac].prdd006 = g_prde4_d_t.prdd006
                  NEXT FIELD prdd006
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdd006
            #add-point:ON CHANGE prdd006

            #END add-point
 
         #----<<prdd007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdd007
            #add-point:BEFORE FIELD prdd007

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdd007
            
            #add-point:AFTER FIELD prdd007

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdd007
            #add-point:ON CHANGE prdd007

            #END add-point
 
         #----<<prdd008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdd008
            #add-point:BEFORE FIELD prdd008

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdd008
            
            #add-point:AFTER FIELD prdd008

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdd008
            #add-point:ON CHANGE prdd008

            #END add-point
 
         #----<<prddsite>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prddsite
            #add-point:BEFORE FIELD prddsite

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prddsite
            
            #add-point:AFTER FIELD prddsite

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prddsite
            #add-point:ON CHANGE prddsite

            #END add-point
 
         #----<<prddunit>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prddunit
            #add-point:BEFORE FIELD prddunit

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prddunit
            
            #add-point:AFTER FIELD prddunit

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prddunit
            #add-point:ON CHANGE prddunit

            #END add-point
 
 
         #---------------------<  Detail: page4  >---------------------
         #----<<prddstus>>----
         #Ctrlp:input.c.page4.prddstus
         ON ACTION controlp INFIELD prddacti
            #add-point:ON ACTION controlp INFIELD prddstus

            #END add-point
 
         #----<<prdd002>>----
         #Ctrlp:input.c.page4.prdd002
         ON ACTION controlp INFIELD prdd002
            #add-point:ON ACTION controlp INFIELD prdd002

            #END add-point
 
         #----<<prdd003>>----
         #Ctrlp:input.c.page4.prdd003
         ON ACTION controlp INFIELD prdd003
            #add-point:ON ACTION controlp INFIELD prdd003

            #END add-point
 
         #----<<prdd004>>----
         #Ctrlp:input.c.page4.prdd004
         ON ACTION controlp INFIELD prdd004
            #add-point:ON ACTION controlp INFIELD prdd004

            #END add-point
 
         #----<<prdd005>>----
         #Ctrlp:input.c.page4.prdd005
         ON ACTION controlp INFIELD prdd005
            #add-point:ON ACTION controlp INFIELD prdd005

            #END add-point
 
         #----<<prdd006>>----
         #Ctrlp:input.c.page4.prdd006
         ON ACTION controlp INFIELD prdd006
            #add-point:ON ACTION controlp INFIELD prdd006

            #END add-point
 
         #----<<prdd007>>----
         #Ctrlp:input.c.page4.prdd007
         ON ACTION controlp INFIELD prdd007
            #add-point:ON ACTION controlp INFIELD prdd007

            #END add-point
 
         #----<<prdd008>>----
         #Ctrlp:input.c.page4.prdd008
         ON ACTION controlp INFIELD prdd008
            #add-point:ON ACTION controlp INFIELD prdd008

            #END add-point
 
         #----<<prddsite>>----
         #Ctrlp:input.c.page4.prddsite
         ON ACTION controlp INFIELD prddsite
            #add-point:ON ACTION controlp INFIELD prddsite

            #END add-point
 
         #----<<prddunit>>----
         #Ctrlp:input.c.page4.prddunit
         ON ACTION controlp INFIELD prddunit
            #add-point:ON ACTION controlp INFIELD prddunit

            #END add-point
 
 
 
         AFTER ROW
            #add-point:單身page4 after_row

            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_prde4_d[l_ac].* = g_prde4_d_t.*
               END IF
               CLOSE aprq211_bcl4
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aprq211_unlock_b("prdd_t","'4'")
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input 

            #end add-point   
    
         ON ACTION controlo
            CALL FGL_SET_ARR_CURR(g_prde4_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_prde4_d.getLength()+1
 
      END INPUT
 
      
 
      
 
      
 
      
 
{</section>}
 
{<section id="aprq211.input.other" >}
      
      #add-point:自定義input

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
                  NEXT FIELD prde002
               WHEN "s_detail2"
                  NEXT FIELD prdgacti
               WHEN "s_detail3"
                  NEXT FIELD prdfacti
               WHEN "s_detail4"
                  NEXT FIELD prddacti
 
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
 
{<section id="aprq211.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aprq211_show()
   DEFINE l_ac_t    LIKE type_t.num5
   #add-point:show段define

   #end add-point  
 
   #add-point:show段之前

   #end add-point
   
   
   
   LET g_prdw_m_t.* = g_prdw_m.*      #保存單頭舊值
   
   IF g_bfill = "Y" THEN
      CALL aprq211_b_fill() #單身填充
      CALL aprq211_b_fill2('0') #單身填充
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
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_prdw_m.prdwsite
   LET g_pk_array[1].column = 'prdwsite'
   LET g_pk_array[2].values = g_prdw_m.prdw001
   LET g_pk_array[2].column = 'prdw001'
   #add-point:ON ACTION agendum

   #END add-point
   CALL cl_user_overview_set_follow_pic()
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference
            DISPLAY BY NAME g_prdw_m.prdwunit,g_prdw_m.prdwsite,g_prdw_m.prdw099,g_prdw_m.prdw001,g_prdw_m.prdw002,g_prdw_m.prdw100, 
     g_prdw_m.prdw006,g_prdw_m.prdw007,g_prdw_m.prdw027,g_prdw_m.prdwstus,g_prdw_m.prdw010,g_prdw_m.prdw011, 
     g_prdw_m.prdw012,g_prdw_m.prdw013,g_prdw_m.prdw024,g_prdw_m.prdw025,g_prdw_m.prdw026,g_prdw_m.prdw098, 
     g_prdw_m.prdw004,g_prdw_m.prdw005,g_prdw_m.prdw003,g_prdw_m.prdw033,g_prdw_m.prdw008,g_prdw_m.prdw009,g_prdw_m.prdwcrtid, 
     g_prdw_m.prdwcrtdp,g_prdw_m.prdwcrtdt,g_prdw_m.prdwownid,g_prdw_m.prdwowndp,g_prdw_m.prdwmodid, g_prdw_m.prdw042,
     g_prdw_m.prdwmoddt,g_prdw_m.prdwcnfid,g_prdw_m.prdwcnfdt,g_prdw_m.prdw037,g_prdw_m.prdw038,g_prdw_m.prdw034 #151204-00007#14 add prdw034
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
            LET g_ref_fields[1] = g_prdw_m.prdwmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_prdw_m.prdwmodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prdw_m.prdwmodid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prdw_m.prdwcnfid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_prdw_m.prdwcnfid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prdw_m.prdwcnfid_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prdw_m.prdw001
            CALL ap_ref_array2(g_ref_fields," SELECT prdwl003 FROM prdwl_t WHERE prdwlent = '"||g_enterprise||"' AND prdwlsite = '"||g_prdw_m.prdwsite||"' AND prdwl001 = ? AND prdwl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
            LET g_prdw_m.prdwl003 = g_rtn_fields[1] 
            DISPLAY g_prdw_m.prdwl003 TO prdwl003
   
            LET g_prdw_m.pos = 'N'
            DISPLAY BY NAME g_prdw_m.pos
            CALL aprq211_desc()

            CALL aprq211_master_show()
            CALL aprq211_set_comp_visible()
   #end add-point
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_prdw_m.prdwunit,g_prdw_m.prdwunit_desc,g_prdw_m.prdwsite,g_prdw_m.prdwsite_desc, 
       g_prdw_m.prdw099,g_prdw_m.pos,g_prdw_m.prdw001,g_prdw_m.prdw002,g_prdw_m.prdwl003,g_prdw_m.prdw100, 
       g_prdw_m.prdw006,g_prdw_m.prdw006_desc,g_prdw_m.prdw007,g_prdw_m.prdw007_desc,g_prdw_m.prdw027, 
       g_prdw_m.prdwstus,g_prdw_m.prdw010,g_prdw_m.prdw011,g_prdw_m.prdw012,g_prdw_m.prdw013,g_prdw_m.prdw024, 
       g_prdw_m.prdw025,g_prdw_m.prdw026,g_prdw_m.prdd003_1,g_prdw_m.prdd004_1,g_prdw_m.prdw098,g_prdw_m.prdw004, 
       g_prdw_m.prdw004_desc,g_prdw_m.prdw005,g_prdw_m.prdw005_desc,g_prdw_m.prdb005_1,g_prdw_m.prdd005_1, 
       g_prdw_m.prdd006_1,g_prdw_m.prdw003,g_prdw_m.prdw033,g_prdw_m.prdw033_desc,g_prdw_m.prdw008,g_prdw_m.prdw008_desc,g_prdw_m.prdw009,g_prdw_m.prdw009_desc, 
       g_prdw_m.prdb005_2,g_prdw_m.prdd007_1,g_prdw_m.prdd008_1,g_prdw_m.prdwcrtid,g_prdw_m.prdwcrtid_desc, 
       g_prdw_m.prdwcrtdp,g_prdw_m.prdwcrtdp_desc,g_prdw_m.prdwcrtdt,g_prdw_m.prdwownid,g_prdw_m.prdwownid_desc, 
       g_prdw_m.prdwowndp,g_prdw_m.prdwowndp_desc,g_prdw_m.prdwmodid,g_prdw_m.prdwmodid_desc,g_prdw_m.prdwmoddt, 
       g_prdw_m.prdwcnfid,g_prdw_m.prdwcnfid_desc,g_prdw_m.prdwcnfdt,g_prdw_m.prdw042
   
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
   FOR l_ac = 1 TO g_prde_d.getLength()
      #帶出公用欄位reference值
      #此段落由子樣板a12產生
      ##LET .prddownid_desc = cl_get_username(.prddownid)
      ##LET .prddowndp_desc = cl_get_deptname(.prddowndp)
      ##LET .prddcrtid_desc = cl_get_username(.prddcrtid)
      ##LET .prddcrtdp_desc = cl_get_deptname(.prddcrtdp)
      ##LET .prddmodid_desc = cl_get_username(.prddmodid)
      ##LET .prddcnfid_desc = cl_get_deptname(.prddcnfid)
      ##LET .prddpstid_desc = cl_get_deptname(.prddpstid)
      
 
 
      #add-point:show段單身reference
      CALL aprq211_prdp_desc()
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_prde2_d.getLength()
      #帶出公用欄位reference值
      
      #add-point:show段單身reference
      
      CALL aprq211_prdg_desc()
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_prde3_d.getLength()
      #帶出公用欄位reference值
      
      #add-point:show段單身reference
      CALL aprq211_prdf_desc()     

      #end add-point
   END FOR
   FOR l_ac = 1 TO g_prde4_d.getLength()
      #帶出公用欄位reference值
      #此段落由子樣板a12產生
      ##LET .prdfownid_desc = cl_get_username(.prdfownid)
      ##LET .prdfowndp_desc = cl_get_deptname(.prdfowndp)
      ##LET .prdfcrtid_desc = cl_get_username(.prdfcrtid)
      ##LET .prdfcrtdp_desc = cl_get_deptname(.prdfcrtdp)
      ##LET .prdfmodid_desc = cl_get_username(.prdfmodid)
      ##LET .prdfcnfid_desc = cl_get_deptname(.prdfcnfid)
      ##LET .prdfpstid_desc = cl_get_deptname(.prdfpstid)
      
 
 
      #add-point:show段單身reference
 
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other

   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aprq211_detail_show()
   
   #add-point:show段之後

   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aprq211.detail_show" >}
#+ 單身reference detail_show
PRIVATE FUNCTION aprq211_detail_show()
   #add-point:detail_show段define
   
   #end add-point  
 
   #add-point:detail_show段之前
   
   #end add-point
   
   #add-point:detail_show段之後
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aprq211.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aprq211_reproduce()
   DEFINE l_newno     LIKE prdw_t.prdwsite 
   DEFINE l_oldno     LIKE prdw_t.prdwsite 
   DEFINE l_newno02     LIKE prdw_t.prdw001 
   DEFINE l_oldno02     LIKE prdw_t.prdw001 
 
   DEFINE l_master    RECORD LIKE prdw_t.*
   DEFINE l_detail    RECORD LIKE prde_t.*
   DEFINE l_detail2    RECORD LIKE prdg_t.*
 
   DEFINE l_detail3    RECORD LIKE prdf_t.*
 
   DEFINE l_detail4    RECORD LIKE prdd_t.*
 
 
 
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
 
    
   CALL aprq211_set_entry('a')
   CALL aprq211_set_no_entry('a')
 
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
      #LET g_prdw_m.prdwstus = ""
 
 
   
   #add-point:複製輸入前
   CALL aprq211_set_entry('a')
   CALL aprq211_set_no_required('a')
   CALL aprq211_set_required('a')
   CALL aprq211_set_no_entry('a')               
   #end add-point
   
   CALL aprq211_input("r")
   
      LET g_prdw_m.prdwsite_desc = ''
   DISPLAY BY NAME g_prdw_m.prdwsite_desc
 
   
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN
   END IF
 
   LET g_state = "Y"
   
   LET g_wc = g_wc,  
              " OR (",
              " prdwsite = '", g_prdw_m.prdwsite CLIPPED, "' "
              ," AND prdw001 = '", g_prdw_m.prdw001 CLIPPED, "' "
 
              , ") "
   
   #add-point:完成複製段落後

   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aprq211.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aprq211_detail_reproduce()
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE prde_t.*
   DEFINE l_detail2    RECORD LIKE prdg_t.*
 
   DEFINE l_detail3    RECORD LIKE prdf_t.*
 
   DEFINE l_detail4    RECORD LIKE prdd_t.*
 
 
 
   #add-point:delete段define

   #end add-point    
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aprq211_detail
   
   #add-point:單身複製前1

   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE aprq211_detail AS ",
                "SELECT * FROM prde_t "
   PREPARE repro_tbl FROM ls_sql
   EXECUTE repro_tbl
   FREE repro_tbl
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO aprq211_detail SELECT * FROM prde_t 
                                         WHERE prdeent = g_enterprise AND prde001 = g_prdw001_t
 
   
   #將key修正為調整後   
   UPDATE aprq211_detail 
      #更新key欄位
      SET prde001 = g_prdw_m.prdw001
 
      #更新共用欄位
      #此段落由子樣板a13產生
      # , prdeownid = g_user
      # , prdeowndp = g_dept
      # , prdecrtid = g_user
      # , prdecrtdp = g_dept 
      # , prdecrtdt = ld_date
      # , prdemodid = "" 
      # , prdemoddt = "" 
      #, prdestus = "Y"
 
#此段落由子樣板a13產生
      # , prdgownid = g_user
      # , prdgowndp = g_dept
      # , prdgcrtid = g_user
      # , prdgcrtdp = g_dept 
      # , prdgcrtdt = ld_date
      # , prdgmodid = "" 
      # , prdgmoddt = "" 
      #, prdgstus = "Y"
 
#此段落由子樣板a13產生
      # , prdfownid = g_user
      # , prdfowndp = g_dept
      # , prdfcrtid = g_user
      # , prdfcrtdp = g_dept 
      # , prdfcrtdt = ld_date
      # , prdfmodid = "" 
      # , prdfmoddt = "" 
      #, prdfstus = "Y"
 
#此段落由子樣板a13產生
      # , prddownid = g_user
      # , prddowndp = g_dept
      # , prddcrtid = g_user
      # , prddcrtdp = g_dept 
      # , prddcrtdt = ld_date
      # , prddmodid = "" 
      # , prddmoddt = "" 
      #, prddstus = "Y"
 
 
                                       
  
   #將資料塞回原table   
   INSERT INTO prde_t SELECT * FROM aprq211_detail
   
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
   DROP TABLE aprq211_detail
   
   #add-point:單身複製後1

   #end add-point
 
   #add-point:單身複製前

   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = 
      "CREATE GLOBAL TEMPORARY TABLE aprq211_detail AS ",
      "SELECT * FROM prdg_t "
   PREPARE repro_tbl2 FROM ls_sql
   EXECUTE repro_tbl2
   FREE repro_tbl2
      
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO aprq211_detail SELECT * FROM prdg_t
                                         WHERE prdgent = g_enterprise AND prdg001 = g_prdw001_t
 
 
   #將key修正為調整後   
   UPDATE aprq211_detail SET prdg001 = g_prdw_m.prdw001
 
  
   #將資料塞回原table   
   INSERT INTO prdg_t SELECT * FROM aprq211_detail
   
   #add-point:單身複製中

   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aprq211_detail
   
   #add-point:單身複製後

   #end add-point
 
   #add-point:單身複製前

   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = 
      "CREATE GLOBAL TEMPORARY TABLE aprq211_detail AS ",
      "SELECT * FROM prdf_t "
   PREPARE repro_tbl3 FROM ls_sql
   EXECUTE repro_tbl3
   FREE repro_tbl3
      
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO aprq211_detail SELECT * FROM prdf_t
                                         WHERE prdfent = g_enterprise AND prdf001 =  g_prdw001_t
 
 
   #將key修正為調整後   
   UPDATE aprq211_detail SET prdf001 = g_prdw_m.prdw001
 
  
   #將資料塞回原table   
   INSERT INTO prdf_t SELECT * FROM aprq211_detail
   
   #add-point:單身複製中

   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aprq211_detail
   
   #add-point:單身複製後

   #end add-point
 
   #add-point:單身複製前

   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = 
      "CREATE GLOBAL TEMPORARY TABLE aprq211_detail AS ",
      "SELECT * FROM prdd_t "
   PREPARE repro_tbl4 FROM ls_sql
   EXECUTE repro_tbl4
   FREE repro_tbl4
      
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO aprq211_detail SELECT * FROM prdd_t
                                         WHERE prddent = g_enterprise AND prdd001 = g_prdw001_t
 
 
   #將key修正為調整後   
   UPDATE aprq211_detail SET prdd001 = g_prdw_m.prdw001
 
  
   #將資料塞回原table   
   INSERT INTO prdd_t SELECT * FROM aprq211_detail
   
   #add-point:單身複製中

   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aprq211_detail
   
   #add-point:單身複製後

   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_prdwsite_t = g_prdw_m.prdwsite
   LET g_prdw001_t = g_prdw_m.prdw001
 
   
   DROP TABLE aprq211_detail
   
END FUNCTION
 
{</section>}
 
{<section id="aprq211.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aprq211_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define

   #end add-point     
   
   IF g_prdw_m.prdw001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      RETURN
   END IF
 
    SELECT UNIQUE prdwunit,prdwsite,prdw099,prdw001,prdw002,prdw100,prdw006,prdw007,prdw027,prdwstus, 
        prdw010,prdw011,prdw012,prdw013,prdw024,prdw025,prdw026,prdw098,prdw004,prdw005,prdw003,prdw033,prdw008, 
        prdw009,prdwcrtid,prdwcrtdp,prdwcrtdt,prdwownid,prdwowndp,prdwmodid,prdwmoddt,prdwcnfid,prdwcnfdt 
 
 INTO g_prdw_m.prdwunit,g_prdw_m.prdwsite,g_prdw_m.prdw099,g_prdw_m.prdw001,g_prdw_m.prdw002,g_prdw_m.prdw100, 
     g_prdw_m.prdw006,g_prdw_m.prdw007,g_prdw_m.prdw027,g_prdw_m.prdwstus,g_prdw_m.prdw010,g_prdw_m.prdw011, 
     g_prdw_m.prdw012,g_prdw_m.prdw013,g_prdw_m.prdw024,g_prdw_m.prdw025,g_prdw_m.prdw026,g_prdw_m.prdw098, 
     g_prdw_m.prdw004,g_prdw_m.prdw005,g_prdw_m.prdw003,g_prdw_m.prdw033,g_prdw_m.prdw008,g_prdw_m.prdw009,g_prdw_m.prdwcrtid, 
     g_prdw_m.prdwcrtdp,g_prdw_m.prdwcrtdt,g_prdw_m.prdwownid,g_prdw_m.prdwowndp,g_prdw_m.prdwmodid, 
     g_prdw_m.prdwmoddt,g_prdw_m.prdwcnfid,g_prdw_m.prdwcnfdt
 FROM prdw_t
 WHERE prdwent = g_enterprise AND prdwsite = g_prdw_m.prdwsite AND prdw001 = g_prdw_m.prdw001
   
   LET g_master_multi_table_t.prdwl001 = g_prdw_m.prdw001
LET g_master_multi_table_t.prdwl003 = g_prdw_m.prdwl003
 
 
   CALL aprq211_show()
   
   CALL s_transaction_begin()
 
   OPEN aprq211_cl USING g_enterprise,g_prdw_m.prdwsite,g_prdw_m.prdw001
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN aprq211_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      CLOSE aprq211_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   FETCH aprq211_cl INTO g_prdw_m.prdwunit,g_prdw_m.prdwunit_desc,g_prdw_m.prdwsite,g_prdw_m.prdwsite_desc, 
       g_prdw_m.prdw099,g_prdw_m.pos,g_prdw_m.prdw001,g_prdw_m.prdw002,g_prdw_m.prdwl003,g_prdw_m.prdw100, 
       g_prdw_m.prdw006,g_prdw_m.prdw006_desc,g_prdw_m.prdw007,g_prdw_m.prdw007_desc,g_prdw_m.prdw027, 
       g_prdw_m.prdwstus,g_prdw_m.prdw010,g_prdw_m.prdw011,g_prdw_m.prdw012,g_prdw_m.prdw013,g_prdw_m.prdw024, 
       g_prdw_m.prdw025,g_prdw_m.prdw026,g_prdw_m.prdd003_1,g_prdw_m.prdd004_1,g_prdw_m.prdw098,g_prdw_m.prdw004, 
       g_prdw_m.prdw004_desc,g_prdw_m.prdw005,g_prdw_m.prdw005_desc,g_prdw_m.prdb005_1,g_prdw_m.prdd005_1, 
       g_prdw_m.prdd006_1,g_prdw_m.prdw003,g_prdw_m.prdw033,g_prdw_m.prdw033_desc,g_prdw_m.prdw008,g_prdw_m.prdw008_desc,g_prdw_m.prdw009,g_prdw_m.prdw009_desc, 
       g_prdw_m.prdb005_2,g_prdw_m.prdd007_1,g_prdw_m.prdd008_1,g_prdw_m.prdwcrtid,g_prdw_m.prdwcrtid_desc, 
       g_prdw_m.prdwcrtdp,g_prdw_m.prdwcrtdp_desc,g_prdw_m.prdwcrtdt,g_prdw_m.prdwownid,g_prdw_m.prdwownid_desc, 
       g_prdw_m.prdwowndp,g_prdw_m.prdwowndp_desc,g_prdw_m.prdwmodid,g_prdw_m.prdwmodid_desc,g_prdw_m.prdwmoddt, 
       g_prdw_m.prdwcnfid,g_prdw_m.prdwcnfid_desc,g_prdw_m.prdwcnfdt              #鎖住將被更改或取消的資料 
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_prdw_m.prdw001
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
      CALL g_pk_array.clear()
      LET g_pk_array[1].values = g_prdw_m.prdw001
      LET g_pk_array[1].column = 'prdw001'
 
      #add-point:相關文件刪除前

      #end add-point   
      CALL cl_doc_remove()  
 
  
  
      #資料備份
      LET g_prdw001_t = g_prdw_m.prdw001
 
 
      DELETE FROM prdw_t
       WHERE prdwent = g_enterprise AND prdwsite = g_prdw_m.prdwsite AND prdw001 = g_prdw_m.prdw001
 
       
      #add-point:單頭刪除中

      #end add-point
       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_prdw_m.prdw001
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      #add-point:單頭刪除後
    
      #end add-point
  
      #add-point:單身刪除前

      #end add-point
      
      DELETE FROM prde_t
       WHERE prdeent = g_enterprise AND prde001 = g_prdw_m.prdw001
 
 
      #add-point:單身刪除中

      #end add-point
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "prde_t"
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
       WHERE prdgent = g_enterprise AND
             prdg001 = g_prdw_m.prdw001
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

      #end add-point
 
      #add-point:單身刪除前

      #end add-point
      DELETE FROM prdf_t
       WHERE prdfent = g_enterprise AND
             prdf001 = g_prdw_m.prdw001
      #add-point:單身刪除中

      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "prdf_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF      
 
      #add-point:單身刪除後

      #end add-point
 
      #add-point:單身刪除前

      #end add-point
      DELETE FROM prdd_t
       WHERE prddent = g_enterprise AND
             prdd001 = g_prdw_m.prdw001
      #add-point:單身刪除中

      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "prdd_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF      
 
      #add-point:單身刪除後

      #end add-point
 
 
 
 
                                                               
      CLEAR FORM
      CALL g_prde_d.clear() 
      CALL g_prde2_d.clear()       
      CALL g_prde3_d.clear()       
      CALL g_prde4_d.clear()       
 
     
      CALL aprq211_ui_browser_refresh()  
      CALL aprq211_ui_headershow()  
      CALL aprq211_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL aprq211_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
      ELSE
         LET g_wc = " 1=1"
         CALL aprq211_browser_fill("F")
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
   
   CLOSE aprq211_cl
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_prdw_m.prdw001,'D')
    
END FUNCTION
 
{</section>}
 
{<section id="aprq211.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aprq211_b_fill()
   DEFINE p_wc2      STRING
   #add-point:b_fill段define

   #end add-point     
 
   CALL g_prde_d.clear()    #g_prde_d 單頭及單身 
   CALL g_prde2_d.clear()
   CALL g_prde3_d.clear()
   CALL g_prde4_d.clear()
 
 
   #add-point:b_fill段sql_before
   CALL g_prde5_d.clear()
   CALL g_prde6_d.clear()
   #end add-point
   
   #判斷是否填充
   IF aprq211_fill_chk(1) THEN
   
      LET g_sql = "SELECT  UNIQUE prde002,prdeacti,prde003,prde004,'',prdesite,prdeunit FROM prde_t", 
             
                  " INNER JOIN prdw_t ON prdwsite = '",g_prdw_m.prdwsite,"' ",
                  " AND prdw001 = prde001 ",
 
                  #"",
                  
                  "",
                  " WHERE prdeent=? AND prde001=?"
      #add-point:b_fill段sql_before
      LET g_sql =g_sql," AND prdedocno IN (SELECT prdadocno FROM prda_t WHERE prda001='",g_prdw_m.prdw001,"' AND prda002=",g_prdw_m.prdw002,")"
      #end add-point
      IF NOT cl_null(g_wc2_table1) THEN
         LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY prde_t.prde002"
      
      #add-point:單身填充控制

      #end add-point
      
      PREPARE aprq211_pb FROM g_sql
      DECLARE b_fill_cs CURSOR FOR aprq211_pb
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs USING g_enterprise,g_prdw_m.prdw001
 
                                               
      FOREACH b_fill_cs INTO g_prde_d[l_ac].prde002,g_prde_d[l_ac].prdeacti,g_prde_d[l_ac].prde003,g_prde_d[l_ac].prde004, 
          g_prde_d[l_ac].prde004_desc,g_prde_d[l_ac].prdesite,g_prde_d[l_ac].prdeunit
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
         IF l_ac > g_max_rec AND g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            EXIT FOREACH
         END IF
         
      END FOREACH
      LET g_error_show = 0
   
   END IF
   
   #判斷是否填充
   IF aprq211_fill_chk(2) THEN
      LET g_sql = "SELECT  UNIQUE prdgacti,prdg002,prdg011,prdg003,prdg004,'',prdg005,prdg006,'',prdg007,prdgsite, 
          prdgunit,prdg010 FROM prdg_t",   
                  " INNER JOIN prdw_t ON prdwsite ='",g_prdw_m.prdwsite,"' ",
                  " AND prdw001 = prdg001  ",
 
                  "",
                  
                  " WHERE prdgent=? AND prdg001=?"   
      #add-point:b_fill段sql_before
      LET g_sql =g_sql," AND prdgdocno IN (SELECT prdadocno FROM prda_t WHERE prda001='",g_prdw_m.prdw001,"' AND prda002=",g_prdw_m.prdw002,")"
      #end add-point
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY prdg_t.prdg002,prdg_t.prdg003,prdg_t.prdg004"
      
      #add-point:單身填充控制

      #end add-point
      
      PREPARE aprq211_pb2 FROM g_sql
      DECLARE b_fill_cs2 CURSOR FOR aprq211_pb2
      
      LET l_ac = 1
      
      OPEN b_fill_cs2 USING g_enterprise,g_prdw_m.prdw001
 
                                               
      FOREACH b_fill_cs2 INTO g_prde2_d[l_ac].prdgacti,g_prde2_d[l_ac].prdg002,g_prde2_d[l_ac].prdg011,g_prde2_d[l_ac].prdg003, 
          g_prde2_d[l_ac].prdg004,g_prde2_d[l_ac].prdg004_desc,g_prde2_d[l_ac].prdg005,g_prde2_d[l_ac].prdg006, 
          g_prde2_d[l_ac].prdg006_desc,g_prde2_d[l_ac].prdg007,g_prde2_d[l_ac].prdgsite,g_prde2_d[l_ac].prdgunit,
          g_prde2_d[l_ac].prdg010          
 
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
 
   #判斷是否填充
   IF aprq211_fill_chk(3) THEN
      LET g_sql = "SELECT  UNIQUE prdfacti,prdf003,'',prdf004,'',prdf002,prdfsite,prdfunit FROM prdf_t", 
             
                  " INNER JOIN prdw_t ON prdwsite = '",g_prdw_m.prdwsite,"' ",
                  " AND prdw001 = prdf001 ",
 
                  "",
                  
                  " WHERE prdfent=? AND prdf001=?"   
      #add-point:b_fill段sql_before
      LET g_sql =g_sql," AND prdfdocno IN (SELECT prdadocno FROM prda_t WHERE prda001='",g_prdw_m.prdw001,"' AND prda002=",g_prdw_m.prdw002,")"
      #end add-point
      IF NOT cl_null(g_wc2_table3) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY prdf_t.prdf002"
      
      #add-point:單身填充控制

      #end add-point
      
      PREPARE aprq211_pb3 FROM g_sql
      DECLARE b_fill_cs3 CURSOR FOR aprq211_pb3
      
      LET l_ac = 1
      
      OPEN b_fill_cs3 USING g_enterprise,g_prdw_m.prdw001
 
                                               
      FOREACH b_fill_cs3 INTO g_prde3_d[l_ac].prdfacti,g_prde3_d[l_ac].prdf003,g_prde3_d[l_ac].prdf003_desc, 
          g_prde3_d[l_ac].prdf004,g_prde3_d[l_ac].prdf004_desc,g_prde3_d[l_ac].prdf002,g_prde3_d[l_ac].prdfsite, 
          g_prde3_d[l_ac].prdfunit
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
 
   #判斷是否填充
   IF aprq211_fill_chk(4) THEN
      LET g_sql = "SELECT  UNIQUE prddacti,prdd002,prdd003,prdd004,prdd005,prdd006,prdd007,prdd008,prddsite, 
          prddunit FROM prdd_t",   
                  " INNER JOIN prdw_t ON prdwsite = '",g_prdw_m.prdwsite,"' ",
                  " AND prdw001 = prdd001 ",
 
                  "",
                  
                  " WHERE prddent=? AND prdd001=?"   
      #add-point:b_fill段sql_before
      LET g_sql =g_sql," AND prdddocno IN (SELECT prdadocno FROM prda_t WHERE prda001='",g_prdw_m.prdw001,"' AND prda002=",g_prdw_m.prdw002,")"
      #end add-point
      IF NOT cl_null(g_wc2_table4) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY prdd_t.prdd002"
      
      #add-point:單身填充控制

      #end add-point
      
      PREPARE aprq211_pb4 FROM g_sql
      DECLARE b_fill_cs4 CURSOR FOR aprq211_pb4
      
      LET l_ac = 1
      
      OPEN b_fill_cs4 USING g_enterprise,g_prdw_m.prdw001
 
                                               
      FOREACH b_fill_cs4 INTO g_prde4_d[l_ac].prddacti,g_prde4_d[l_ac].prdd002,g_prde4_d[l_ac].prdd003, 
          g_prde4_d[l_ac].prdd004,g_prde4_d[l_ac].prdd005,g_prde4_d[l_ac].prdd006,g_prde4_d[l_ac].prdd007, 
          g_prde4_d[l_ac].prdd008,g_prde4_d[l_ac].prddsite,g_prde4_d[l_ac].prddunit
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
   CALL aprq211_b5_fill()
   CALL aprq211_b6_fill()

   #end add-point
   
   CALL g_prde_d.deleteElement(g_prde_d.getLength())
   CALL g_prde2_d.deleteElement(g_prde2_d.getLength())
   CALL g_prde3_d.deleteElement(g_prde3_d.getLength())
   CALL g_prde4_d.deleteElement(g_prde4_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aprq211_pb
   FREE aprq211_pb2
 
   FREE aprq211_pb3
 
   FREE aprq211_pb4
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="aprq211.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aprq211_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM prde_t
       WHERE prdeent = g_enterprise AND
         prde001 = ps_keys_bak[1] AND prde002 = ps_keys_bak[2]
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
      DELETE FROM prdg_t
       WHERE prdgent = g_enterprise AND
         prdg001 = ps_keys_bak[1] AND prdg002 = ps_keys_bak[2] AND prdg003 = ps_keys_bak[3] AND prdg004 = ps_keys_bak[4]
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
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前

      #end add-point    
      DELETE FROM prdf_t
       WHERE prdfent = g_enterprise AND
         prdf001 = ps_keys_bak[1] AND prdf002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中

      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "prdf_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
      END IF
      #add-point:delete_b段刪除後

      #end add-point    
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前

      #end add-point    
      DELETE FROM prdd_t
       WHERE prddent = g_enterprise AND
         prdd001 = ps_keys_bak[1] AND prdd002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中

      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "prdd_t"
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
 
{<section id="aprq211.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aprq211_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO prde_t
                  (prdeent,
                   prde001,
                   prde002
                   ,prdeacti,prde003,prde004,prdesite,prdeunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_prde_d[g_detail_idx].prdeacti,g_prde_d[g_detail_idx].prde003,g_prde_d[g_detail_idx].prde004, 
                       g_prde_d[g_detail_idx].prdesite,g_prde_d[g_detail_idx].prdeunit)
      #add-point:insert_b段資料新增中

      #end add-point 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "prde_t"
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
      INSERT INTO prdg_t
                  (prdgent,
                   prdg001,
                   prdg002,prdg011,prdg003,prdg004
                   ,prdgacti,prdg005,prdg006,prdg007,prdgsite,prdgunit,prdg010) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],g_prde2_d[g_detail_idx].prdg011,ps_keys[3],ps_keys[4]
                   ,g_prde2_d[g_detail_idx].prdgacti,g_prde2_d[g_detail_idx].prdg005,g_prde2_d[g_detail_idx].prdg006, 
                       g_prde2_d[g_detail_idx].prdg007,g_prde2_d[g_detail_idx].prdgsite,g_prde2_d[g_detail_idx].prdgunit,g_prde2_d[g_detail_idx].prdg010) 
 
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
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前

      #end add-point 
      INSERT INTO prdf_t
                  (prdfent,
                   prdf001,
                   prdf002
                   ,prdfacti,prdf003,prdf004,prdfsite,prdfunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_prde3_d[g_detail_idx].prdfacti,g_prde3_d[g_detail_idx].prdf003,g_prde3_d[g_detail_idx].prdf004, 
                       g_prde3_d[g_detail_idx].prdfsite,g_prde3_d[g_detail_idx].prdfunit)
      #add-point:insert_b段資料新增中

      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "prdf_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
      END IF
      #add-point:insert_b段資料新增後

      #end add-point
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前

      #end add-point 
      INSERT INTO prdd_t
                  (prddent,
                   prdd001,
                   prdd002
                   ,prddacti,prdd003,prdd004,prdd005,prdd006,prdd007,prdd008,prddsite,prddunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_prde4_d[g_detail_idx].prddacti,g_prde4_d[g_detail_idx].prdd003,g_prde4_d[g_detail_idx].prdd004, 
                       g_prde4_d[g_detail_idx].prdd005,g_prde4_d[g_detail_idx].prdd006,g_prde4_d[g_detail_idx].prdd007, 
                       g_prde4_d[g_detail_idx].prdd008,g_prde4_d[g_detail_idx].prddsite,g_prde4_d[g_detail_idx].prddunit) 
 
      #add-point:insert_b段資料新增中

      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "prdd_t"
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
 
{<section id="aprq211.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aprq211_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prde_t" THEN
      #add-point:update_b段修改前

      #end add-point     
      UPDATE prde_t 
         SET (prde001,
              prde002
              ,prdeacti,prde003,prde004,prdesite,prdeunit) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_prde_d[g_detail_idx].prdeacti,g_prde_d[g_detail_idx].prde003,g_prde_d[g_detail_idx].prde004, 
                  g_prde_d[g_detail_idx].prdesite,g_prde_d[g_detail_idx].prdeunit) 
         WHERE prdeent = g_enterprise AND prde001 = ps_keys_bak[1] AND prde002 = ps_keys_bak[2]
      #add-point:update_b段修改中

      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "prde_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "prde_t"
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prdg_t" THEN
      #add-point:update_b段修改前

      #end add-point     
      UPDATE prdg_t 
         SET (prdg001,
              prdg002,prdg011,prdg003,prdg004
              ,prdgacti,prdg005,prdg006,prdg007,prdgsite,prdgunit,prdg010) 
              = 
             (ps_keys[1],ps_keys[2],g_prde2_d[g_detail_idx].prdg011,ps_keys[3],ps_keys[4]
              ,g_prde2_d[g_detail_idx].prdgacti,g_prde2_d[g_detail_idx].prdg005,g_prde2_d[g_detail_idx].prdg006, 
                  g_prde2_d[g_detail_idx].prdg007,g_prde2_d[g_detail_idx].prdgsite,g_prde2_d[g_detail_idx].prdgunit,g_prde2_d[g_detail_idx].prdg010)  
 
         WHERE prdgent = g_enterprise AND prdg001 = ps_keys_bak[1] AND prdg002 = ps_keys_bak[2] AND prdg003 = ps_keys_bak[3] AND prdg004 = ps_keys_bak[4]
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
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prdf_t" THEN
      #add-point:update_b段修改前

      #end add-point     
      UPDATE prdf_t 
         SET (prdf001,
              prdf002
              ,prdfacti,prdf003,prdf004,prdfsite,prdfunit) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_prde3_d[g_detail_idx].prdfacti,g_prde3_d[g_detail_idx].prdf003,g_prde3_d[g_detail_idx].prdf004, 
                  g_prde3_d[g_detail_idx].prdfsite,g_prde3_d[g_detail_idx].prdfunit) 
         WHERE prdfent = g_enterprise AND prdf001 = ps_keys_bak[1] AND prdf002 = ps_keys_bak[2]
      #add-point:update_b段修改中

      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "prdf_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "prdf_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後

      #end add-point  
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prdd_t" THEN
      #add-point:update_b段修改前

      #end add-point     
      UPDATE prdd_t 
         SET (prdd001,
              prdd002
              ,prddacti,prdd003,prdd004,prdd005,prdd006,prdd007,prdd008,prddsite,prddunit) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_prde4_d[g_detail_idx].prddacti,g_prde4_d[g_detail_idx].prdd003,g_prde4_d[g_detail_idx].prdd004, 
                  g_prde4_d[g_detail_idx].prdd005,g_prde4_d[g_detail_idx].prdd006,g_prde4_d[g_detail_idx].prdd007, 
                  g_prde4_d[g_detail_idx].prdd008,g_prde4_d[g_detail_idx].prddsite,g_prde4_d[g_detail_idx].prddunit)  
 
         WHERE prddent = g_enterprise AND prdd001 = ps_keys_bak[1] AND prdd002 = ps_keys_bak[2]
      #add-point:update_b段修改中

      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "prdd_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "prdd_t"
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
 
{<section id="aprq211.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aprq211_lock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define

   #end add-point   
   
   #先刷新資料
   #CALL aprq211_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "prde_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aprq211_bcl USING g_enterprise,
                                       g_prdw_m.prdwsite,g_prdw_m.prdw001,g_prde_d[g_detail_idx].prde002  
                                               
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "aprq211_bcl"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "prdg_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aprq211_bcl2 USING g_enterprise,
                                             g_prdw_m.prdwsite,g_prdw_m.prdw001,g_prde2_d[g_detail_idx].prdg002, 
                                                 g_prde2_d[g_detail_idx].prdg003,g_prde2_d[g_detail_idx].prdg004 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "aprq211_bcl2"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "prdf_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aprq211_bcl3 USING g_enterprise,
                                             g_prdw_m.prdwsite,g_prdw_m.prdw001,g_prde3_d[g_detail_idx].prdf002 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "aprq211_bcl3"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'4',"
   #僅鎖定自身table
   LET ls_group = "prdd_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aprq211_bcl4 USING g_enterprise,
                                             g_prdw_m.prdwsite,g_prdw_m.prdw001,g_prde4_d[g_detail_idx].prdd002 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "aprq211_bcl4"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         RETURN FALSE
      END IF
   END IF
 
 
   
 
   
   #add-point:lock_b段other

   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aprq211.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aprq211_unlock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define
   
   #end add-point  
   
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aprq211_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aprq211_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aprq211_bcl3
   END IF
 
   LET ls_group = "'4',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aprq211_bcl4
   END IF
 
 
   
 
 
   #add-point:unlock_b段other
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aprq211.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aprq211_set_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define
   
   #end add-point       
 
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("prdwsite,prdw001",TRUE)
      #add-point:set_entry段欄位控制
 
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後
   CALL cl_set_comp_entry("prdw001",TRUE)
   CALL cl_set_comp_entry("prdb005_1",TRUE)
   CALL cl_set_comp_entry("prdb005_2",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprq211.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aprq211_set_no_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define
   
   #end add-point     
 
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("prdwsite,prdw001",FALSE)
      #add-point:set_no_entry段欄位控制
 
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後
   IF g_prdw_m.prdw026 = '1' THEN
      CALL cl_set_comp_entry("prdb005_2",FALSE)
      LET g_prdw_m.prdb005_2 = ''
   END IF
   IF g_prdw_m.prdw026 = '2' THEN
      CALL cl_set_comp_entry("prdb005_1",FALSE)
      LET g_prdw_m.prdb005_1 = ''
   END IF
#   IF NOT cl_null(g_prdw_m.prdw001) AND g_prdw_m.prda000 = 'I' THEN
#      CALL cl_set_comp_entry("prdw001",FALSE)
#   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprq211.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aprq211_set_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define
   
   #end add-point     
   #add-point:set_entry_b段
   CALL cl_set_comp_entry("prdf004",TRUE)
   CALL cl_set_comp_entry("prdg005",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aprq211.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aprq211_set_no_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define
   DEFINE l_ooia002       LIKE ooia_t.ooia002
   #end add-point    
   #add-point:set_no_entry_b段
   LET l_ooia002 = ''
   IF NOT cl_null(g_prde3_d[l_ac].prdf003) THEN
      SELECT ooia002 INTO l_ooia002
        FROM ooia_t
       WHERE ooiaent = g_enterprise
         AND ooia001 = g_prde3_d[l_ac].prdf003
   END IF
   IF l_ooia002 <> '40' AND l_ooia002 <> '60' THEN
      CALL cl_set_comp_entry("prdf004",FALSE)
      LET g_prde3_d[l_ac].prdf004 = ""
   END IF    
   IF g_prde2_d[l_ac].prdg003 <> '4' THEN
      CALL cl_set_comp_entry("prdg005",FALSE)
      LET g_prde2_d[l_ac].prdg005 = ""
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aprq211.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aprq211_default_search()
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
 
{<section id="aprq211.state_change" >}
   #+ 此段落由子樣板a09產生
#+ 確認碼變更
PRIVATE FUNCTION aprq211_statechange()
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define
   
   #end add-point  
   
   #add-point:statechange段開始前
   
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
 
{<section id="aprq211.idx_chk" >}
#+ 單身筆數變更
PRIVATE FUNCTION aprq211_idx_chk()
   #add-point:idx_chk段define

   #end add-point  
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_prde_d.getLength() THEN
         LET g_detail_idx = g_prde_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prde_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prde_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_prde2_d.getLength() THEN
         LET g_detail_idx = g_prde2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prde2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prde2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_prde3_d.getLength() THEN
         LET g_detail_idx = g_prde3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prde3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prde3_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_prde4_d.getLength() THEN
         LET g_detail_idx = g_prde4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prde4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prde4_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other
   IF g_current_page = 5 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail5")
      IF g_detail_idx > g_prde5_d.getLength() THEN
         LET g_detail_idx = g_prde5_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prde5_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prde5_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 6 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail6")
      IF g_detail_idx > g_prde6_d.getLength() THEN
         LET g_detail_idx = g_prde6_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prde6_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prde6_d.getLength() TO FORMONLY.cnt
   END IF   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aprq211.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aprq211_b_fill2(pi_idx)
   DEFINE pi_idx          LIKE type_t.num5
   DEFINE li_ac           LIKE type_t.num5
   DEFINE ls_chk          LIKE type_t.chr1
   #add-point:b_fill2段define
   
   #end add-point
   
   LET li_ac = l_ac 
   
 
      
   #add-point:單身填充後
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL aprq211_detail_show()
   
END FUNCTION
 
{</section>}
 
{<section id="aprq211.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aprq211_fill_chk(ps_idx)
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define

   #end add-point
   
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1')  AND 
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1')  AND 
      (cl_null(g_wc2_table3) OR g_wc2_table3.trim() = '1=1')  AND 
      (cl_null(g_wc2_table4) OR g_wc2_table4.trim() = '1=1') THEN
      #add-point:fill_chk段define

      #end add-point
      RETURN TRUE
   END IF
 
   RETURN TRUE
#   #第一單身
#   IF ps_idx = 1 AND
#      ((NOT cl_null(g_wc2_table1) AND g_wc2_table1.trim() <> '1=1')) THEN
#      RETURN TRUE
#   END IF
#   
#   #根據wc判定是否需要填充
#   IF ps_idx = 2 AND
#      ((NOT cl_null(g_wc2_table2) AND g_wc2_table2.trim() <> '1=1')) THEN
#      RETURN TRUE
#   END IF
# 
#   IF ps_idx = 3 AND
#      ((NOT cl_null(g_wc2_table3) AND g_wc2_table3.trim() <> '1=1')) THEN
#      RETURN TRUE
#   END IF
# 
#   IF ps_idx = 4 AND
#      ((NOT cl_null(g_wc2_table4) AND g_wc2_table4.trim() <> '1=1')) THEN
#      RETURN TRUE
#   END IF
# 
# 
# 
#   RETURN FALSE
 
END FUNCTION
 
{</section>}
 
{<section id="aprq211.signature" >}
   
 
{</section>}
 
{<section id="aprq211.set_pk_array" >}
 
 
{</section>}
 
{<section id="aprq211.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="aprq211.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 單頭帶值欄位顯示
# Memo...........:
# Usage..........: CALL aprq211_desc()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/13 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprq211_desc()
  
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
   LET g_ref_fields[1] = g_prdw_m.prdw033
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '2135' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prdw_m.prdw033_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdw_m.prdw033_desc

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
################################################################################
# Descriptions...: prde單身帶值欄位顯示
# Memo...........:
# Usage..........: CALL aprq211_prdp_desc()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/13 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprq211_prdp_desc()
   
   LET g_prde_d[l_ac].prde004_desc = ''
   IF g_prde_d[l_ac].prde003 = '1' THEN
      SELECT rtaal003 INTO g_prde_d[l_ac].prde004_desc
        FROM rtaal_t
       WHERE rtaalent = g_enterprise
         AND rtaal001 = g_prde_d[l_ac].prde004
         AND rtaal002 = g_dlang
   ELSE
      SELECT ooefl003 INTO g_prde_d[l_ac].prde004_desc
        FROM ooefl_t
       WHERE ooeflent = g_enterprise
         AND ooefl001 = g_prde_d[l_ac].prde004
         AND ooefl002 = g_dlang
   END IF
   
END FUNCTION
################################################################################
# Descriptions...: prdg單身帶值欄位顯示
# Memo...........:
# Usage..........: CALL aprq211_prdr_desc()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/13 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprq211_prdg_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prde2_d[l_ac].prdg006
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prde2_d[l_ac].prdg006_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prde2_d[l_ac].prdg006_desc
   
   IF g_prde2_d[l_ac].prdg003 = '4' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prde2_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prde2_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prde2_d[l_ac].prdg004_desc
   END IF
   IF g_prde2_d[l_ac].prdg003 = '5' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prde2_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prde2_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prde2_d[l_ac].prdg004_desc
   END IF
   IF g_prde2_d[l_ac].prdg003 = '6' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prde2_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2000' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prde2_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prde2_d[l_ac].prdg004_desc
   END IF
   IF g_prde2_d[l_ac].prdg003 = '7' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prde2_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2001' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prde2_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prde2_d[l_ac].prdg004_desc
   END IF
   IF g_prde2_d[l_ac].prdg003 = '8' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prde2_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2002' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prde2_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prde2_d[l_ac].prdg004_desc
   END IF
   IF g_prde2_d[l_ac].prdg003 = '9' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prde2_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2003' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prde2_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prde2_d[l_ac].prdg004_desc
   END IF
   IF g_prde2_d[l_ac].prdg003 = 'A' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prde2_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2004' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prde2_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prde2_d[l_ac].prdg004_desc
   END IF
   IF g_prde2_d[l_ac].prdg003 = 'B' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prde2_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2005' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prde2_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prde2_d[l_ac].prdg004_desc
   END IF
   IF g_prde2_d[l_ac].prdg003 = 'C' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prde2_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2006' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prde2_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prde2_d[l_ac].prdg004_desc
   END IF
   IF g_prde2_d[l_ac].prdg003 = 'D' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prde2_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2007' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prde2_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prde2_d[l_ac].prdg004_desc
   END IF
   IF g_prde2_d[l_ac].prdg003 = 'E' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prde2_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2008' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prde2_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prde2_d[l_ac].prdg004_desc
   END IF
   IF g_prde2_d[l_ac].prdg003 = 'F' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prde2_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2009' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prde2_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prde2_d[l_ac].prdg004_desc
   END IF
   IF g_prde2_d[l_ac].prdg003 = 'G' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prde2_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2010' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prde2_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prde2_d[l_ac].prdg004_desc
   END IF
   IF g_prde2_d[l_ac].prdg003 = 'H' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prde2_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2011' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prde2_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prde2_d[l_ac].prdg004_desc
   END IF
   IF g_prde2_d[l_ac].prdg003 = 'I' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prde2_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2012' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prde2_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prde2_d[l_ac].prdg004_desc
   END IF
   IF g_prde2_d[l_ac].prdg003 = 'J' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prde2_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2013' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prde2_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prde2_d[l_ac].prdg004_desc
   END IF
   IF g_prde2_d[l_ac].prdg003 = 'K' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prde2_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2014' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prde2_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prde2_d[l_ac].prdg004_desc
   END IF
   IF g_prde2_d[l_ac].prdg003 = 'L' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prde2_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2015' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prde2_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prde2_d[l_ac].prdg004_desc
   END IF
   ##add by zn --str #160728-00006#24
   IF g_prde2_d[l_ac].prdg003 = '14' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prde2_d[l_ac].prdg004
      CALL ap_ref_array2(g_ref_fields,"SELECT mhbel003 FROM mhbel_t WHERE mhbelent="||g_enterprise||" AND mhbel001=? AND mhbel002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prde2_d[l_ac].prdg004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prde2_d[l_ac].prdg004_desc
   END IF   
   ##add by zn --end
END FUNCTION
################################################################################
# Descriptions...: prdf單身帶值欄位顯示
# Memo...........:
# Usage..........: CALL aprq211_prdq_desc()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/13 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprq211_prdf_desc()
DEFINE l_ooia002     LIKE ooia_t.ooia002

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prde3_d[l_ac].prdf003
   CALL ap_ref_array2(g_ref_fields,"SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prde3_d[l_ac].prdf003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prde3_d[l_ac].prdf003_desc
   
   IF NOT cl_null(g_prde3_d[l_ac].prdf003) THEN
      SELECT ooia002 INTO l_ooia002
        FROM ooia_t
       WHERE ooiaent = g_enterprise
         AND ooia001 = g_prde3_d[l_ac].prdf003
      IF l_ooia002 = '40' THEN #券
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prde3_d[l_ac].prdf004
         CALL ap_ref_array2(g_ref_fields,"SELECT gcafl003 FROM gcafl_t WHERE gcaflent='"||g_enterprise||"' AND gcafl001=? AND gcafl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prde3_d[l_ac].prdf004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prde3_d[l_ac].prdf004_desc
      END IF
      IF l_ooia002 = '60' THEN #卡
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prde3_d[l_ac].prdf004
         CALL ap_ref_array2(g_ref_fields,"SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prde3_d[l_ac].prdf004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prde3_d[l_ac].prdf004_desc
      END IF
   END IF
END FUNCTION
################################################################################
# Descriptions...: 促銷方案帶值
# Memo...........:
# Usage..........: CALL aprq211_prdw006_def()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/14 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprq211_prdw006_def()
DEFINE l_sql             STRING
DEFINE l_prde002         LIKE prde_t.prde002
#DEFINE l_prce            RECORD LIKE prce_t.*  161111-00028#2-mark
#161111-00028#2---add----begin-----------
DEFINE l_prce RECORD  #活動計劃生效組織資料檔
       prceent LIKE prce_t.prceent, #企業編號
       prceunit LIKE prce_t.prceunit, #應用組織
       prcesite LIKE prce_t.prcesite, #營運據點
       prce001 LIKE prce_t.prce001, #活動計劃
       prce002 LIKE prce_t.prce002, #類型
       prce003 LIKE prce_t.prce003, #店群/門店
       prceacti LIKE prce_t.prceacti #有效否
       END RECORD
#161111-00028#2---add----end-----------

   SELECT prcf002,prcf007,prcf008,prcf009,prcf010
     INTO g_prdw_m.prdw007,g_prdw_m.prdw008,g_prdw_m.prdw009,g_prdw_m.prdd003_1,g_prdw_m.prdd004_1
     FROM prcf_t
    WHERE prcfent = g_enterprise
      AND prcf001 = g_prdw_m.prdw006
   DISPLAY BY NAME g_prdw_m.prdw007,g_prdw_m.prdw008,g_prdw_m.prdw009,g_prdw_m.prdd003_1,g_prdw_m.prdd004_1
   IF NOT cl_null(g_prdw_m.prdw007) THEN
#      DELETE FROM prde_t WHERE prdeent = g_enterprise AND prdedocno = g_prdw_m.prdadocno
      LET l_prde002 = 1
     #LET l_sql = " SELECT * FROM prce_t",   161111-00028#2-mark
      LET l_sql = " SELECT prceent,prceunit,prcesite,prce001,prce002,prce003,prceacti FROM prce_t",   #161111-00028#2-add
                  "  WHERE prceent = '",g_enterprise,"'",
                  "    AND prce001 = '",g_prdw_m.prdw007,"'"
      PREPARE aprq211_sel_prce_pre FROM l_sql
      DECLARE aprq211_sel_prce_cur CURSOR FOR aprq211_sel_prce_pre
      FOREACH aprq211_sel_prce_cur INTO l_prce.*
#         INSERT INTO prde_t(prdeent,prdeunit,prdesite,prdedocno,prde001,prde002,prde003,prde004,prdeacti)
#                     VALUES(g_enterprise,g_site,g_site,g_prdw_m.prdadocno,g_prdw_m.prdw001,l_prde002,l_prce.prce002,l_prce.prce003,l_prce.prceacti)
         LET l_prde002 = l_prde002+1            
      END FOREACH
      CALL aprq211_b_fill() 
   END IF
END FUNCTION
################################################################################
# Descriptions...: 活动方案帶值
# Memo...........:
# Usage..........: CALL aprq211_prdw007_def()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/14 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprq211_prdw007_def()
DEFINE l_sql             STRING
DEFINE l_prde002         LIKE prde_t.prde002
#DEFINE l_prce            RECORD LIKE prce_t.*  161111-00028#2-mark
#161111-00028#2---add----begin-----------
DEFINE l_prce RECORD  #活動計劃生效組織資料檔
       prceent LIKE prce_t.prceent, #企業編號
       prceunit LIKE prce_t.prceunit, #應用組織
       prcesite LIKE prce_t.prcesite, #營運據點
       prce001 LIKE prce_t.prce001, #活動計劃
       prce002 LIKE prce_t.prce002, #類型
       prce003 LIKE prce_t.prce003, #店群/門店
       prceacti LIKE prce_t.prceacti #有效否
END RECORD
#161111-00028#2---add----end-----------


   IF cl_null(g_prdw_m.prdw006) THEN
      SELECT prcd002,prcd003,prcd004,prcd005 
        INTO g_prdw_m.prdw008,g_prdw_m.prdw009,g_prdw_m.prdd003_1,g_prdw_m.prdd004_1
        FROM prcd_t
       WHERE prcdent = g_enterprise
         AND prcd001 = g_prdw_m.prdw007
      DISPLAY BY NAME g_prdw_m.prdw008,g_prdw_m.prdw009,g_prdw_m.prdd003_1,g_prdw_m.prdd004_1
#      DELETE FROM prde_t WHERE prdeent = g_enterprise AND prdedocno = g_prdw_m.prdadocno
      LET l_prde002 = 1
     #LET l_sql = " SELECT * FROM prce_t",   161111-00028#2-mark
      LET l_sql = " SELECT prceent,prceunit,prcesite,prce001,prce002,prce003,prceacti FROM prce_t",   #161111-00028#2-add
                  "  WHERE prceent = '",g_enterprise,"'",
                  "    AND prce001 = '",g_prdw_m.prdw007,"'"
      PREPARE aprq211_sel_prce_pre1 FROM l_sql
      DECLARE aprq211_sel_prce_cur1 CURSOR FOR aprq211_sel_prce_pre1
      FOREACH aprq211_sel_prce_cur1 INTO l_prce.*
#         INSERT INTO prde_t(prdeent,prdeunit,prdesite,prdedocno,prde001,prde002,prde003,prde004,prdeacti)
#                     VALUES(g_enterprise,g_site,g_site,g_prdw_m.prdadocno,g_prdw_m.prdw001,l_prde002,l_prce.prce002,l_prce.prce003,l_prce.prceacti)
         LET l_prde002 = l_prde002+1            
      END FOREACH
      CALL aprq211_b_fill()  
   END IF
END FUNCTION
################################################################################
# Descriptions...: 单头栏位必输关闭
# Memo...........:
# Usage..........: CALL aprq211_set_no_required(p_cmd)
# Input parameter: p_cmd          新增/修改标识符
# Return code....: 無
# Date & Author..: 2014/03/14 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprq211_set_no_required(p_cmd)
DEFINE p_cmd   LIKE type_t.chr1

   CALL cl_set_comp_required("prdw006",FALSE)
END FUNCTION
###############################################################################
# Descriptions...: 单头栏位必输
# Memo...........:
# Usage..........: CALL aprq211_set_required(p_cmd)
# Input parameter: p_cmd          新增/修改标识符
# Return code....: 無
# Date & Author..: 2014/03/14 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprq211_set_required(p_cmd)
DEFINE p_cmd        LIKE type_t.chr1
DEFINE l_prcd006    LIKE prcd_t.prcd006  

   IF NOT cl_null(g_prdw_m.prdw007) THEN  
      LET l_prcd006 = ''
      SELECT prcd006 INTO l_prcd006
        FROM prcd_t
       WHERE prcdent = g_enterprise
         AND prcd001 = g_prdw_m.prdw007
      IF l_prcd006 = 'Y' THEN
         CALL cl_set_comp_required("prdw006",TRUE)
      END IF
   END IF   
END FUNCTION
################################################################################
# Descriptions...: 檢查促銷方案對應的活動計劃是否和現在的活動計劃相同
# Memo...........:
# Usage..........: CALL aprq211_chk_prdw006_007()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/14 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprq211_chk_prdw006_007()
DEFINE l_prcf002        LIKE prcf_t.prcf002

   LET g_errno = ''
   SELECT prcf002 INTO l_prcf002
     FROM prcf_t
    WHERE prcfent = g_enterprise
      AND prcf001 = g_prdw_m.prdw006
   IF l_prcf002 <> g_prdw_m.prdw007 THEN
      LET g_errno = 'apr-00065'
   END IF
END FUNCTION
################################################################################
# Descriptions...: 畫面UI的呈現方式
# Memo...........:
# Usage..........: CALL aprq211_set_comp_visible()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/14 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprq211_set_comp_visible()
   CALL cl_set_comp_visible('bpage2',TRUE)
   IF g_prdw_m.prdw010 = 'Y' THEN
      CALL cl_set_comp_visible('bpage2',FALSE)
   END IF
   CALL cl_set_comp_visible('bpage3',FALSE)
   IF g_prdw_m.prdw011 = 'Y' THEN
      CALL cl_set_comp_visible('bpage3',TRUE)
   END IF
   CALL cl_set_comp_visible('bpage4',TRUE)
   CALL cl_set_comp_visible('lbl_prdd003',TRUE)
   CALL cl_set_comp_visible('prdd003_1',TRUE)
   CALL cl_set_comp_visible('lbl_prdd004',TRUE)
   CALL cl_set_comp_visible('prdd004_1',TRUE)
   CALL cl_set_comp_visible('lbl_prdd005',TRUE)
   CALL cl_set_comp_visible('prdd005_1',TRUE)
   CALL cl_set_comp_visible('lbl_prdd006',TRUE)
   CALL cl_set_comp_visible('prdd006_1',TRUE)
   CALL cl_set_comp_visible('lbl_prdd007',TRUE)
   CALL cl_set_comp_visible('prdd007_1',TRUE)
   CALL cl_set_comp_visible('lbl_prdd008',TRUE)
   CALL cl_set_comp_visible('prdd008_1',TRUE)
   IF g_prdw_m.prdw013 = 'Y' THEN
      CALL cl_set_comp_visible('lbl_prdd003',FALSE)
      CALL cl_set_comp_visible('prdd003_1',FALSE)
      LET g_prdw_m.prdd003_1 = ''
      CALL cl_set_comp_visible('lbl_prdd004',FALSE)
      CALL cl_set_comp_visible('prdd004_1',FALSE)
      LET g_prdw_m.prdd004_1 = ''
      CALL cl_set_comp_visible('lbl_prdd005',FALSE)
      CALL cl_set_comp_visible('prdd005_1',FALSE)
      LET g_prdw_m.prdd005_1 = ''
      CALL cl_set_comp_visible('lbl_prdd006',FALSE)
      CALL cl_set_comp_visible('prdd006_1',FALSE)
      LET g_prdw_m.prdd006_1 = ''
      CALL cl_set_comp_visible('lbl_prdd007',FALSE)
      CALL cl_set_comp_visible('prdd007_1',FALSE)
      LET g_prdw_m.prdd007_1 = ''
      CALL cl_set_comp_visible('lbl_prdd008',FALSE)
      CALL cl_set_comp_visible('prdd008_1',FALSE)
      LET g_prdw_m.prdd008_1 = ''
   ELSE
      CALL cl_set_comp_visible('bpage4',FALSE)
   END IF
   CALL cl_set_comp_visible('lbl_prdb005_1',TRUE)
   CALL cl_set_comp_visible('lbl_prdb005_2',TRUE)
   CALL cl_set_comp_visible('prdb005_1',TRUE)
   CALL cl_set_comp_visible('prdb005_2',TRUE)
   CALL cl_set_comp_visible('lbl_3',FALSE)
   CALL cl_set_comp_visible('lbl_4',FALSE)
   IF g_prdw_m.prdw026 = '1' THEN
      CALL cl_set_comp_visible('lbl_prdb005_2',FALSE)
      CALL cl_set_comp_visible('prdb005_2',FALSE)
      LET g_prdw_m.prdb005_2 = ''
      CALL cl_set_comp_visible('lbl_4',TRUE)
   END IF
   IF g_prdw_m.prdw026 = '2' THEN
      CALL cl_set_comp_visible('lbl_prdb005_1',FALSE)
      CALL cl_set_comp_visible('prdb005_1',FALSE)
      LET g_prdw_m.prdb005_1 = ''
      CALL cl_set_comp_visible('lbl_3',TRUE)
   END IF
   IF g_prdw_m.prdw026 = '4' THEN
      CALL cl_set_comp_visible('lbl_prdb005_1',FALSE)
      CALL cl_set_comp_visible('lbl_prdb005_2',FALSE)
      CALL cl_set_comp_visible('prdb005_1',FALSE)
      LET g_prdw_m.prdb005_1 = ''
      CALL cl_set_comp_visible('prdb005_2',FALSE)
      LET g_prdw_m.prdb005_2 = ''
      CALL cl_set_comp_visible('lbl_3',TRUE)
      CALL cl_set_comp_visible('lbl_4',TRUE)
   END IF
END FUNCTION
################################################################################
# Descriptions...: 根據不同的條件欄位顯示名稱不同
# Memo...........:
# Usage..........: CALL aprq211_set_comp_att_text()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/14 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprq211_set_comp_att_text()
DEFINE l_msg      STRING 

   CALL cl_getmsg('apr-00184',g_lang) RETURNING l_msg
   CALL cl_set_comp_att_text("lbl_prdb005_1",l_msg)
   CALL cl_getmsg('apr-00185',g_lang) RETURNING l_msg
   CALL cl_set_comp_att_text("lbl_prdb005_2",l_msg)
   IF g_prdw_m.prdw024 = '3' THEN
      CALL cl_getmsg('apr-00070',g_lang) RETURNING l_msg
      CALL cl_set_comp_att_text("lbl_prdb005_1",l_msg)
      CALL cl_getmsg('apr-00072',g_lang) RETURNING l_msg
      CALL cl_set_comp_att_text("lbl_prdb005_2",l_msg)
   END IF
END FUNCTION
################################################################################
# Descriptions...: 單頭日期+參考對象新增
# Memo...........:
# Usage..........: CALL aprq211_master_def()
# Input parameter: 無
# Return code....: TRUE/FALSE
# Date & Author..: 2014/03/14 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprq211_master_def()
#   DELETE FROM prdb_t WHERE prdbent = g_enterprise AND prdbdocno = g_prdw_m.prdadocno
   IF g_prdw_m.prdw026 = '1'  OR g_prdw_m.prdw026 = '3'  THEN
      #散客
      IF NOT cl_null(g_prdw_m.prdb005_1) THEN
#         INSERT INTO prdb_t(prdbent,prdbunit,prdbsite,prdbdocno,prdb001,prdb002,prdb003,prdb004,prdb005,prdbacti)
#                     VALUES(g_enterprise,g_site,g_site,g_prdw_m.prdadocno,g_prdw_m.prdw001,1,'1',0,g_prdw_m.prdb005_1,'Y')         
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins prdb'
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN FALSE
         END IF
      END IF
   END IF
   IF g_prdw_m.prdw026 = '2'  OR g_prdw_m.prdw026 = '3'  THEN
      #會員
      IF NOT cl_null(g_prdw_m.prdb005_2) THEN
#         INSERT INTO prdb_t(prdbent,prdbunit,prdbsite,prdbdocno,prdb001,prdb002,prdb003,prdb004,prdb005,prdbacti)
#                     VALUES(g_enterprise,g_site,g_site,g_prdw_m.prdadocno,g_prdw_m.prdw001,2,'2',0,g_prdw_m.prdb005_2,'Y')         
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins prdb'
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN FALSE
         END IF
      END IF
   END IF
#   DELETE FROM prdd_t WHERE prddent = g_enterprise AND prdddocno = g_prdw_m.prdadocno
   #日期
   IF g_prdw_m.prdw013 = 'N' THEN
#      INSERT INTO prdd_t(prddent,prddunit,prddsite,prdddocno,prdd001,prdd002,prdd003,prdd004,prdd005,prdd006,prdd007,prdd008,prddacti)
#                  VALUES(g_enterprise,g_site,g_site,g_prdw_m.prdadocno,g_prdw_m.prdw001,1,g_prdw_m.prdd003_1,g_prdw_m.prdd004_1,g_prdw_m.prdd005_1,g_prdw_m.prdd006_1,g_prdw_m.prdd007_1,g_prdw_m.prdd008_1,'Y')
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins prdd'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION
################################################################################
# Descriptions...: 單頭日期+參考對象更新
# Memo...........:
# Usage..........: CALL aprq211_master_upd()
# Input parameter: 無
# Return code....: TRUE/FALSE
# Date & Author..: 2014/03/14 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprq211_master_upd()
DEFINE l_n           LIKE type_t.num5


#   IF g_prdw_m.prdw026 = '1'  OR g_prdw_m.prdw026 = '3'  THEN
#      #散客
#      IF NOT cl_null(g_prdw_m.prdb005_1) THEN
#         LET l_n = 0
#         SELECT COUNT(*) INTO l_n
#           FROM prdb_t
#          WHERE prdbent = g_enterprise
#            AND prdbdocno = g_prdw_m.prdadocno
#            AND prdb002 = 1
#         IF l_n = 0 THEN
#            INSERT INTO prdb_t(prdbent,prdbunit,prdbsite,prdbdocno,prdb001,prdb002,prdb003,prdb004,prdb005,prdbacti)
#                        VALUES(g_enterprise,g_site,g_site,g_prdw_m.prdadocno,g_prdw_m.prdw001,1,'1',0,g_prdw_m.prdb005_1,'Y')         
#            IF SQLCA.sqlcode THEN
#               CALL cl_err('ins prdb',SQLCA.sqlcode,1)
#               RETURN FALSE
#            END IF
#         ELSE
#            UPDATE prdb_t SET prdb001 = g_prdw_m.prdw001,
#                              prdb003 = '1',
#                              prdb004 = 0,
#                              prdb005 = g_prdw_m.prdb005_1,
#                              prdbacti = 'Y'
#            WHERE prdbent = g_enterprise
#              AND prdbdocno = g_prdw_m.prdadocno
#              AND prdb002 = 1  
#            IF SQLCA.sqlcode THEN
#               CALL cl_err('upd prdb',SQLCA.sqlcode,1)
#               RETURN FALSE
#            END IF     
#         END IF
#      END IF
#   END IF
#   IF g_prdw_m.prdw026 = '2'  OR g_prdw_m.prdw026 = '3'  THEN
#      #散客
#      IF NOT cl_null(g_prdw_m.prdb005_2) THEN
#         LET l_n = 0
#         SELECT COUNT(*) INTO l_n
#           FROM prdb_t
#          WHERE prdbent = g_enterprise
#            AND prdbdocno = g_prdw_m.prdadocno
#            AND prdb002 = 2
#         IF l_n = 0 THEN
#            INSERT INTO prdb_t(prdbent,prdbunit,prdbsite,prdbdocno,prdb001,prdb002,prdb003,prdb004,prdb005,prdbacti)
#                        VALUES(g_enterprise,g_site,g_site,g_prdw_m.prdadocno,g_prdw_m.prdw001,2,'2',0,g_prdw_m.prdb005_2,'Y')         
#            IF SQLCA.sqlcode THEN
#               CALL cl_err('ins prdb',SQLCA.sqlcode,1)
#               RETURN FALSE
#            END IF
#         ELSE
#            UPDATE prdb_t SET prdb001 = g_prdw_m.prdw001,
#                              prdb003 = '2',
#                              prdb004 = 0,
#                              prdb005 = g_prdw_m.prdb005_2,
#                              prdbacti = 'Y'
#            WHERE prdbent = g_enterprise
#              AND prdbdocno = g_prdw_m.prdadocno
#              AND prdb002 = 2  
#            IF SQLCA.sqlcode THEN
#               CALL cl_err('upd prdb',SQLCA.sqlcode,1)
#               RETURN FALSE
#            END IF  
#         END IF
#      END IF
#   END IF
#   #日期
#   IF g_prdw_m.prdw013 = 'N' THEN
#      LET l_n = 0
#      SELECT COUNT(*) INTO l_n
#        FROM prdd_t
#       WHERE prddent = g_enterprise
#         AND prdddocno = g_prdw_m.prdadocno
#         AND prdd002 = 1
#      IF l_n = 0 THEN   
#         INSERT INTO prdd_t(prddent,prddunit,prddsite,prdddocno,prdd001,prdd002,prdd003,prdd004,prdd005,prdd006,prdd007,prdd008,prddacti)
#                     VALUES(g_enterprise,g_site,g_site,g_prdw_m.prdadocno,g_prdw_m.prdw001,1,g_prdw_m.prdd003_1,g_prdw_m.prdd004_1,g_prdw_m.prdd005_1,g_prdw_m.prdd006_1,g_prdw_m.prdd007_1,g_prdw_m.prdd008_1,'Y')
#         IF SQLCA.sqlcode THEN
#            CALL cl_err('ins prdd',SQLCA.sqlcode,1)
#            RETURN FALSE
#         END IF
#      ELSE
#         UPDATE prdd_t SET prdd001 = g_prdw_m.prdw001,
#                           prdd003 = g_prdw_m.prdd003_1,
#                           prdd004 = g_prdw_m.prdd004_1,
#                           prdd005 = g_prdw_m.prdd005_1,
#                           prdd006 = g_prdw_m.prdd006_1,
#                           prdd007 = g_prdw_m.prdd007_1,
#                           prdd008 = g_prdw_m.prdd008_1,
#                           prddacti = 'Y'
#         WHERE prddent = g_enterprise
#           AND prdddocno = g_prdw_m.prdadocno
#           AND prdd002 = 1  
#         IF SQLCA.sqlcode THEN
#            CALL cl_err('upd prdd',SQLCA.sqlcode,1)
#            RETURN FALSE
#         END IF  
#      END IF
#   END IF
   RETURN TRUE
END FUNCTION
################################################################################
# Descriptions...: 規則編號檢查
# Memo...........:
# Usage..........: CALL aprq211_chk_prdw001()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/17 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprq211_chk_prdw001()
DEFINE l_n              LIKE type_t.num5
DEFINE l_prdwstus       LIKE prdw_t.prdwstus

   LET g_errno = ""
   
#   IF g_prdw_m.prda000 = 'I' THEN
#      LET l_n = 0
#      SELECT COUNT(*) INTO l_n
#        FROM prdw_t
#       WHERE prdwent = g_enterprise
#         AND prdw001 = g_prdw_m.prdw001
#      IF l_n > 0 THEN
#         LET g_errno = 'apr-00080'
#         RETURN
#      END IF
#   END IF
#   IF g_prdw_m.prda000 = 'U' THEN
#      LET l_n = 0
#      SELECT COUNT(*) INTO l_n
#        FROM prdw_t
#       WHERE prdwent = g_enterprise
#         AND prdw001 = g_prdw_m.prdw001
#      IF l_n = 0 THEN
#         LET g_errno = 'apr-00081'
#         RETURN
#      END IF
#      LET l_prdwstus = ''
#      SELECT prdwstus INTO l_prdwstus
#        FROM prdw_t
#       WHERE prdwent = g_enterprise
#         AND prdw001 = g_prdw_m.prdw001
#      IF l_prdwstus = 'X' THEN
#         LET g_errno = 'apr-00082'
#         RETURN
#      END IF
#      IF l_prdwstus = 'N' THEN
#         LET g_errno = 'apr-00083'
#         RETURN
#      END IF
#   END IF
END FUNCTION
################################################################################
# Descriptions...: 店群/門店檢查
# Memo...........:
# Usage..........: CALL aprq211_chk_prdp004()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/17 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprq211_chk_prdp004()
DEFINE l_n       LIKE type_t.num5
DEFINE l_sql     STRING

   LET g_errno = ''
   IF g_prde_d[l_ac].prde003 = '1' THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM rtaa_t
       WHERE rtaaent = g_enterprise
         AND rtaa001 = g_prde_d[l_ac].prde004
      IF l_n = 0 THEN
         LET g_errno = 'apr-00006'
         RETURN
      END IF
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM rtaa_t
       WHERE rtaaent = g_enterprise
         AND rtaa001 = g_prde_d[l_ac].prde004
         AND rtaastus = 'Y'
      IF l_n = 0 THEN
         LET g_errno = 'apr-00007'  
         RETURN
      END IF
      LET l_n = 0
      #huangrh add rtak_t ----20150603  
      SELECT COUNT(*) INTO l_n
        FROM rtaa_t,rtak_t
       WHERE rtaaent = g_enterprise
         AND rtaa001 = g_prde_d[l_ac].prde004
         AND rtaastus = 'Y'
         AND rtakent=rtaaent
         AND rtak001=rtaa001
         AND rtak002='4'
         AND rtak003='Y'
      IF l_n = 0 THEN
         LET g_errno = 'apr-00008'
         RETURN
      END IF
      LET l_n = 0
      #huangrh add rtak_t ----20150603  
      LET l_sql = "SELECT COUNT(*) ",
                  "  FROM rtaa_t,rtab_t,rtak_t",
                  " WHERE rtaaent = '",g_enterprise,"'",
                  "   AND rtaa001 = '",g_prde_d[l_ac].prde004,"'",
                  "   AND rtaastus = 'Y'",
                  "   AND rtakent=rtaaent",
                  "   AND rtak001=rtaa001",
                  "   AND rtak002='4'",
                  "   AND rtak003='Y'", 
                  "   AND rtaaent = rtabent",
                  "   AND rtaa001 = rtab001",
                  #"   AND rtab002 IN (SELECT ooed004 FROM ooed_t ", #160905-00007#12  mark
                  "   AND rtab002 IN (SELECT ooed004 FROM ooed_t WHERE ooedent=",g_enterprise,   #160905-00007#12  add
                  "                    START WITH ooed005 = '",g_site,"'",
                  "                      AND ooed001='8'",
                  "                      AND ooed006<= '",g_today,"'",
                  "                      AND (ooed007>= '",g_today,"' OR ooed007 IS NULL)",
                  "                    CONNECT BY  nocycle PRIOR ooed004=ooed005 ",
                  "                      AND ooed001='8' ",
                  "                      AND ooed006<= '",g_today,"'",
                  "                      AND (ooed007>= '",g_today,"' OR ooed007 IS NULL)",
                  #"                    UNION SELECT ooed004 FROM ooed_t WHERE ooed004 = '",g_site,"' )" #160905-00007#12 mark
                  "                    UNION SELECT ooed004 FROM ooed_t WHERE ooedent = ",g_enterprise," AND ooed004 = '",g_site,"' )" #160905-00007#12 add
      PREPARE aprq211_sel_rtaa_pr FROM l_sql
      EXECUTE aprq211_sel_rtaa_pr INTO l_n
      IF l_n = 0 THEN
         LET g_errno = 'apr-00066'
         RETURN
      END IF
   END IF
#   IF g_prde_d[l_ac].prde003 = '1' THEN
#      LET l_n = 0
#      SELECT COUNT(*) INTO l_n
#        FROM rtab_t
#       WHERE rtabent = g_enterprise
#         AND rtab002 IN (SELECT prde004 FROM prde_t
#                          WHERE prdeent = g_enterprise
#                            AND prdedocno = g_prdw_m.prdadocno
#                            AND prde003 = '2')
#         AND rtab001 = g_prde_d[l_ac].prde004
#      IF l_n > 0 THEN
#         LET g_errno = 'apr-00013'
#         RETURN
#      END IF
#   END IF
#   IF g_prde_d[l_ac].prde003 = '2' THEN
#      LET l_n = 0
#      SELECT COUNT(*) INTO l_n
#        FROM prde_t
#       WHERE prdeent = g_enterprise
#         AND prdedocno = g_prdw_m.prdadocno
#         AND prde004 IN (SELECT rtab001 FROM rtab_t
#                          WHERE rtabent = g_enterprise
#                            AND rtab002 = g_prde_d[l_ac].prde004)
#         AND prde003 = '1'
#      IF l_n > 0 THEN
#         LET g_errno = 'apr-00014'
#         RETURN
#      END IF
#   END IF
END FUNCTION
################################################################################
# Descriptions...: 检查款别资料
# Memo...........:
# Usage..........: CALL aprq211_chk_prdq004()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/17 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprq211_chk_prdf004()
DEFINE l_ooia002       LIKE ooia_t.ooia002
DEFINE l_gcafstus      LIKE gcaf_t.gcafstus
DEFINE l_mmanstus      LIKE mman_t.mmanstus
DEFINE l_n             LIKE type_t.num5

   LET g_errno = ""
   SELECT ooia002 INTO l_ooia002
     FROM ooia_t
    WHERE ooiaent = g_enterprise
      AND ooia001 = g_prde3_d[l_ac].prdf003
   IF l_ooia002 = '40' THEN #券
      SELECT gcafstus INTO l_gcafstus
        FROM gcaf_t
       WHERE gcafent = g_enterprise
         AND gcaf001 = g_prde3_d[l_ac].prdf004
      CASE 
         WHEN SQLCA.sqlcode = 100
              LET g_errno = 'apr-00085'
              RETURN
         WHEN l_gcafstus = 'X'
              LET g_errno = 'sub-01307'  #apr-00086   #160318-00005#39  By 07900 --mod
               LET g_errparam.exeprog = 'agcm300'     #160318-00005#39  By 07900--add
              RETURN
         WHEN l_gcafstus = 'N'
              LET g_errno = 'sub-01302'  #apr-00087   #160318-00005#39  By 07900 --mod
              LET g_errparam.exeprog = 'agcm300'      #160318-00005#39  By 07900--add
              RETURN
      END CASE   
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM mmap_t
       WHERE mmapent = g_enterprise
         AND mmap001 = 'agcm300'
         AND mmap002 = g_prde3_d[l_ac].prdf004
         AND mmap003 = g_site
         AND mmapstus = 'Y'
      IF l_n = 0 THEN
         LET g_errno = 'apr-00092'
         RETURN
      END IF
   END IF
   IF l_ooia002 = '60' THEN #卡
      SELECT mmanstus INTO l_mmanstus
        FROM mman_t
       WHERE mmanent = g_enterprise
         AND mman001 = g_prde3_d[l_ac].prdf004
      CASE 
         WHEN SQLCA.sqlcode = 100
              LET g_errno = 'apr-00088'
              RETURN
         WHEN l_mmanstus = 'X'
              LET g_errno = 'sub-01307'  #apr-00089   #160318-00005#39  By 07900 --mod
              LET g_errparam.exeprog = 'ammm320'      #160318-00005#39  By 07900--add
              RETURN
         WHEN l_mmanstus = 'N'
              LET g_errno = 'sub-01302'  #apr-00090   #160318-00005#39  By 07900 --mod
              LET g_errparam.exeprog = 'ammm320'      #160318-00005#39  By 07900--add
              RETURN
      END CASE 
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM mmap_t
       WHERE mmapent = g_enterprise
         AND mmap001 = 'ammm320'
         AND mmap002 = g_prde3_d[l_ac].prdf004
         AND mmap003 = g_site
         AND mmapstus = 'Y'
      IF l_n = 0 THEN
         LET g_errno = 'apr-00092'
         RETURN
      END IF
   END IF
END FUNCTION
################################################################################
# Descriptions...: 屬性代碼檢查
# Memo...........:
# Usage..........: CALL aprq211_chk_prdr004()
#                  RETURNING TRUE/FALSE
# Input parameter: 無
# Return code....: TRUE/FALSE
# Date & Author..: 2014/03/17 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprq211_chk_prdr004()
   IF g_prde2_d[l_ac].prdg003 = '4' THEN
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_prde2_d[l_ac].prdg004
      LET g_chkparam.arg2 = g_site
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_rtdx001_1") THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prde2_d[l_ac].prdg003 = '5' THEN
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_prde2_d[l_ac].prdg004
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_rtax001_1") THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prde2_d[l_ac].prdg003 = '6' THEN
      IF NOT s_azzi650_chk_exist('2000',g_prde2_d[l_ac].prdg004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prde2_d[l_ac].prdg003 = '7' THEN
      IF NOT s_azzi650_chk_exist('2001',g_prde2_d[l_ac].prdg004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prde2_d[l_ac].prdg003 = '8' THEN
      IF NOT s_azzi650_chk_exist('2002',g_prde2_d[l_ac].prdg004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prde2_d[l_ac].prdg003 = '9' THEN
      IF NOT s_azzi650_chk_exist('2003',g_prde2_d[l_ac].prdg004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prde2_d[l_ac].prdg003 = 'A' THEN
      IF NOT s_azzi650_chk_exist('2004',g_prde2_d[l_ac].prdg004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prde2_d[l_ac].prdg003 = 'B' THEN
      IF NOT s_azzi650_chk_exist('2005',g_prde2_d[l_ac].prdg004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prde2_d[l_ac].prdg003 = 'C' THEN
      IF NOT s_azzi650_chk_exist('2006',g_prde2_d[l_ac].prdg004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prde2_d[l_ac].prdg003 = 'D' THEN
      IF NOT s_azzi650_chk_exist('2007',g_prde2_d[l_ac].prdg004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prde2_d[l_ac].prdg003 = 'E' THEN
      IF NOT s_azzi650_chk_exist('2008',g_prde2_d[l_ac].prdg004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prde2_d[l_ac].prdg003 = 'F' THEN
      IF NOT s_azzi650_chk_exist('2009',g_prde2_d[l_ac].prdg004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prde2_d[l_ac].prdg003 = 'G' THEN
      IF NOT s_azzi650_chk_exist('2010',g_prde2_d[l_ac].prdg004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prde2_d[l_ac].prdg003 = 'H' THEN
      IF NOT s_azzi650_chk_exist('2011',g_prde2_d[l_ac].prdg004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prde2_d[l_ac].prdg003 = 'I' THEN
      IF NOT s_azzi650_chk_exist('2012',g_prde2_d[l_ac].prdg004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prde2_d[l_ac].prdg003 = 'J' THEN
      IF NOT s_azzi650_chk_exist('2013',g_prde2_d[l_ac].prdg004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prde2_d[l_ac].prdg003 = 'K' THEN
      IF NOT s_azzi650_chk_exist('2014',g_prde2_d[l_ac].prdg004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prde2_d[l_ac].prdg003 = 'L' THEN
      IF NOT s_azzi650_chk_exist('2015',g_prde2_d[l_ac].prdg004) THEN
         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION
################################################################################
# Descriptions...: 商品編號帶值
# Memo...........:
# Usage..........: CALL aprq211_prdr004_def()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/17 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprq211_prdr004_def()
   #150312-00002#6 Modify-S By Ken 150319 原rtdx033改抓imaa106
   SELECT rtdx002    #,rtdx033 
     INTO g_prde2_d[l_ac].prdg005    #,g_prde2_d[l_ac].prdg006
     FROM rtdx_t
    WHERE rtdxent = g_enterprise
      AND rtdxsite = g_site
      AND rtdx001 = g_prde2_d[l_ac].prdg004
      
   SELECT imaa106 
     INTO g_prde2_d[l_ac].prdg006
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_prde2_d[l_ac].prdg004
   #150312-00002#6 Modify-E      
   CALL aprq211_prdg_desc()
END FUNCTION
################################################################################
# Descriptions...: 單頭其他表欄位顯示
# Memo...........:
# Usage..........: CALL　aprq211_master_show()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/18 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprq211_master_show()
   IF g_prdw_m.prdw026 = '1'  OR g_prdw_m.prdw026 = '3'  THEN
      #散客
      SELECT prdm005 INTO g_prdw_m.prdb005_1
        FROM prdm_t
       WHERE prdment = g_enterprise
         AND prdm001 = g_prdw_m.prdw001
         AND prdm002 = 1
   END IF
   IF g_prdw_m.prdw026 = '2'  OR g_prdw_m.prdw026 = '3'  THEN
      #會員
      SELECT prdm005 INTO g_prdw_m.prdb005_2
        FROM prdm_t
       WHERE prdment = g_enterprise
         AND prdm001 = g_prdw_m.prdw001
         AND prdm002 = 2
   END IF
   
   #日期
   IF g_prdw_m.prdw013 = 'N' THEN
      SELECT prdd003,prdd004,prdd005,prdd006,prdd007,prdd008 
        INTO g_prdw_m.prdd003_1,g_prdw_m.prdd004_1,g_prdw_m.prdd005_1,g_prdw_m.prdd006_1,g_prdw_m.prdd007_1,g_prdw_m.prdd008_1
        FROM prdd_t
       WHERE prddent = g_enterprise
         AND prdd001 = g_prdw_m.prdw001
         AND prdd002 = 1
   END IF
END FUNCTION

################################################################################
# Descriptions...: 顯示會員的對象屬性
# Memo...........:
# Usage..........: CALL aprq211_prdc003_display()
# Date & Author..: 20150416 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aprq211_prdc003_display()
DEFINE l_oocq002      LIKE oocq_t.oocq002
DEFINE l_oocql004     LIKE oocql_t.oocql004
DEFINE l_cnt          LIKE type_t.num5
DEFINE l_sql          STRING
DEFINE cb004          ui.ComboBox
   
   LET cb004 = ui.ComboBox.forName('prdc003')
   CALL cb004.clear()
   
   LET l_cnt = 0
   LET l_sql = " SELECT DISTINCT oocq002,oocql004 ",
               "   FROM oocq_t LEFT JOIN oocql_t ON oocqent = oocqlent AND oocq001 = oocql001 AND oocq002 = oocql002 AND oocql003 = '",g_dlang,"' ",
               "  WHERE oocqent = ",g_enterprise," ",
               "    AND oocq001 = '2049' ",
               "    AND oocqstus = 'Y' ",
               "  ORDER BY oocq002 "
   PREPARE sel_oocq_pre FROM l_sql
   DECLARE sel_oocq_cs  CURSOR FOR sel_oocq_pre
   LET l_cnt = 1
   FOREACH sel_oocq_cs  INTO l_oocq002,l_oocql004
      LET l_oocql004 = l_oocq002,':',l_oocql004
      IF cl_null(l_oocql004) THEN
         CALL cb004.addItem(l_oocq002,l_oocq002)
      ELSE
         CALL cb004.addItem(l_oocq002,l_oocql004)
      END IF
      LET l_cnt = l_cnt+1
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 單身填充
# Memo...........:
# Usage..........: CALL aprq211_b6_fill()
# Input parameter: 
# Return code....: 
# Date & Author..: 20150416 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aprq211_b6_fill()
DEFINE l_prdadocno      LIKE prda_t.prdadocno

   CALL g_prde6_d.clear()
   IF g_detail_idx <= 0 THEN
      RETURN
   END IF
   IF g_prde5_d.getLength() = 0 THEN
      RETURN
   END IF
   
   
   SELECT prdadocno 
     INTO l_prdadocno
     FROM prda_t
    WHERE prda001 = g_prdw_m.prdw001 AND prda002 = g_prdw_m.prdw002
      AND prdaent = g_enterprise  
  

    IF cl_null(g_wc2_table6) THEN
       LET g_wc2_table6=" 1=1"
    END IF
     
     
     
     LET g_sql = "SELECT prdcacti,prdc003,prdc004 FROM prdc_t", 
                 " WHERE prdcent=? AND prdc001=? AND prdc002=? AND prdcdocno=?"
     
     IF NOT cl_null(g_wc2_table6) THEN
        LET g_sql = g_sql CLIPPED," AND ",g_wc2_table6 CLIPPED
     END IF
           
     LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
     PREPARE aprq211_pb6 FROM g_sql
     DECLARE b_fill_curs6 CURSOR FOR aprq211_pb6
     
     OPEN b_fill_curs6 USING g_enterprise,g_prdw_m.prdw001,g_prde5_d[g_detail_idx].prdb002,l_prdadocno

     LET l_ac = 1
     FOREACH b_fill_curs6 INTO g_prde6_d[l_ac].prdcacti,g_prde6_d[l_ac].prdc003,g_prde6_d[l_ac].prdc004
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.extend = "FOREACH:" 
           LET g_errparam.code   = SQLCA.sqlcode 
           LET g_errparam.popup  = TRUE 
           CALL cl_err()
           EXIT FOREACH
        END IF
        
        CALL aprq211_prdc_desc() 
              
        IF l_ac > g_max_rec THEN
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.extend = l_ac
           LET g_errparam.code   = 9035 
           LET g_errparam.popup  = TRUE 
           CALL cl_err()
           EXIT FOREACH
        END IF
        
        LET l_ac = l_ac + 1
        
     END FOREACH
     CALL g_prde6_d.deleteElement(g_prde6_d.getLength())
     FREE aprq211_pb6
     
END FUNCTION

################################################################################
# Descriptions...: 屬性名稱帶值
# Memo...........:
# Usage..........: CALL aprq211_prdc_desc()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/04/16 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aprq211_prdc_desc()
DEFINE l_oocq004      LIKE oocq_t.oocq004   
   
   IF g_prde5_d[g_detail_idx].prdb003 = '2' THEN
      SELECT oocq004 INTO l_oocq004
        FROM oocq_t
       WHERE oocqent = g_enterprise
         AND oocq001 = '2049'
         AND oocq002 = g_prde6_d[l_ac].prdc003
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_oocq004
      LET g_ref_fields[2] = g_prde6_d[l_ac].prdc004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prde6_d[l_ac].prdc004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prde6_d[l_ac].prdc004_desc
   END IF
   
   IF g_prde5_d[g_detail_idx].prdb003 = '3' THEN
      IF g_prde6_d[l_ac].prdc003 = '1' THEN #客戶編號
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prde6_d[l_ac].prdc004
         CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prde6_d[l_ac].prdc004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prde6_d[l_ac].prdc004_desc
      END IF
      
      IF g_prde6_d[l_ac].prdc003 = '2' THEN #客戶分類
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prde6_d[l_ac].prdc004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='281' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prde6_d[l_ac].prdc004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prde6_d[l_ac].prdc004_desc
      END IF 
      
      IF g_prde6_d[l_ac].prdc003 = '3' THEN 
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prde6_d[l_ac].prdc004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2061' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prde6_d[l_ac].prdc004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prde6_d[l_ac].prdc004_desc
      END IF
      
      IF g_prde6_d[l_ac].prdc003 = '4' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prde6_d[l_ac].prdc004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2062' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prde6_d[l_ac].prdc004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prde6_d[l_ac].prdc004_desc
      END IF     

      IF g_prde6_d[l_ac].prdc003 = '5' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prde6_d[l_ac].prdc004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2063' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prde6_d[l_ac].prdc004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prde6_d[l_ac].prdc004_desc
      END IF  
      
      IF g_prde6_d[l_ac].prdc003 = '6' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prde6_d[l_ac].prdc004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2064' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prde6_d[l_ac].prdc004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prde6_d[l_ac].prdc004_desc
      END IF  
      
      IF g_prde6_d[l_ac].prdc003 = '7' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prde6_d[l_ac].prdc004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2065' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prde6_d[l_ac].prdc004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prde6_d[l_ac].prdc004_desc
      END IF  
      
      IF g_prde6_d[l_ac].prdc003 = '8' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prde6_d[l_ac].prdc004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2066' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prde6_d[l_ac].prdc004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prde6_d[l_ac].prdc004_desc
      END IF  
      
      IF g_prde6_d[l_ac].prdc003 = '9' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prde6_d[l_ac].prdc004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2067' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prde6_d[l_ac].prdc004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prde6_d[l_ac].prdc004_desc
      END IF  
      
      
      IF g_prde6_d[l_ac].prdc003 = '10' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prde6_d[l_ac].prdc004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2068' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prde6_d[l_ac].prdc004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prde6_d[l_ac].prdc004_desc
      END IF  
      
      IF g_prde6_d[l_ac].prdc003 = '11' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prde6_d[l_ac].prdc004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2069' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prde6_d[l_ac].prdc004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prde6_d[l_ac].prdc004_desc
      END IF  
      
      IF g_prde6_d[l_ac].prdc003 = '12' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prde6_d[l_ac].prdc004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2070' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prde6_d[l_ac].prdc004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prde6_d[l_ac].prdc004_desc
      END IF  
      
   END IF  
   
   IF g_prde5_d[g_detail_idx].prdb003 = '2' THEN
      CALL aprq211_prdc003_display()                    
   END IF
   IF g_prde5_d[g_detail_idx].prdb003 = '3' THEN
      CALL cl_set_combo_scc('prdc003','6035')
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 單身填充
# Memo...........:
# Usage..........: CALL aprq211_b5_fill()
# Input parameter: 
# Return code....: 
# Date & Author..: 20150416 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aprq211_b5_fill()
DEFINE l_prdadocno      LIKE prda_t.prdadocno
DEFINE l_prda024        LIKE prda_t.prda024
DEFINE l_msg            STRING


   SELECT prdadocno 
     INTO l_prdadocno,l_prda024
     FROM prda_t
    WHERE prda001 = g_prdw_m.prdw001 AND prda002 = g_prdw_m.prdw002
      AND prdaent = g_enterprise
   IF l_prda024 = '3' THEN
      CALL cl_getmsg('apr-00095',g_lang) RETURNING l_msg
      CALL cl_set_comp_att_text("prdb005",l_msg)
   END IF
   IF l_prda024 = '1' THEN
      CALL cl_getmsg('apr-00146',g_lang) RETURNING l_msg
      CALL cl_set_comp_att_text("prdb005",l_msg)
   END IF
   IF l_prda024 = '2' THEN
      CALL cl_getmsg('apr-00369',g_lang) RETURNING l_msg
      CALL cl_set_comp_att_text("prdb005",l_msg)
   END IF

    IF cl_null(g_wc2_table5) THEN
       LET g_wc2_table5=" 1=1"
    END IF
     


    CALL g_prde5_d.clear()
     
     LET g_sql = "SELECT prdbacti,prdb004,prdb002,prdb003,prdb005 FROM prdb_t", 
                 " WHERE prdbent=? AND prdb001=? AND prdbdocno=?"
     
     IF NOT cl_null(g_wc2_table5) THEN
        LET g_sql = g_sql CLIPPED," AND ",g_wc2_table5 CLIPPED
     END IF
           
     LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
     PREPARE aprq211_pb5 FROM g_sql
     DECLARE b_fill_curs5 CURSOR FOR aprq211_pb5
     
     OPEN b_fill_curs5 USING g_enterprise,g_prdw_m.prdw001,l_prdadocno

     LET l_ac = 1
     FOREACH b_fill_curs5 INTO g_prde5_d[l_ac].prdbacti,g_prde5_d[l_ac].prdb004,g_prde5_d[l_ac].prdb002,g_prde5_d[l_ac].prdb003,g_prde5_d[l_ac].prdb005
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.extend = "FOREACH:" 
           LET g_errparam.code   = SQLCA.sqlcode 
           LET g_errparam.popup  = TRUE 
           CALL cl_err()
           EXIT FOREACH
        END IF 
              
        IF l_ac > g_max_rec THEN
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.extend = l_ac
           LET g_errparam.code   = 9035 
           LET g_errparam.popup  = TRUE 
           CALL cl_err()
           EXIT FOREACH
        END IF
        
        LET l_ac = l_ac + 1
        
     END FOREACH
     CALL g_prde5_d.deleteElement(g_prde5_d.getLength())
     FREE aprq211_pb5

END FUNCTION

 
{</section>}
 
