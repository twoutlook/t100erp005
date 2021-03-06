#該程式未解開Section, 採用最新樣板產出!
{<section id="ammm358.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0012(2016-06-17 09:06:19), PR版次:0012(2016-12-15 11:22:19)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000251
#+ Filename...: ammm358
#+ Description: 生效營運組織會員卡積點規則維護作業
#+ Creator....: 01533(2014-01-02 09:29:45)
#+ Modifier...: 02159 -SD/PR- 07900
 
{</section>}
 
{<section id="ammm358.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160729-00077#6    2016/08/17   by 06814       新增規則對象 :調整規則對象編號帶值的部份
#161108-00016#1    2016/11/09   by 08742       修改 g_browser_cnt 定义大小
#161111-00028#1    2016/11/11   BY 02481       标准程式定义采用宣告模式,弃用.*写法
#161214-00032#1    2016/12/15   by 07900       石狮通达权限设置.freestyle或者是改过section者,需检核规格【资料表关联设定】主表要跟现在程序主表一致;主sql部分要补上cl_sql_add_filter
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

#單頭 type 宣告
 TYPE type_g_mmby_m RECORD
       mmbysite LIKE mmby_t.mmbysite,
   mmbysite_desc LIKE type_t.chr80,
   mmbyunit LIKE mmby_t.mmbyunit,
   mmbyunit_desc LIKE type_t.chr80,
   mmby004 LIKE mmby_t.mmby004,
   mmby001 LIKE mmby_t.mmby001,
   mmby002 LIKE mmby_t.mmby002,
   mmbyl004 LIKE mmbyl_t.mmbyl004,
   mmbyl005 LIKE mmbyl_t.mmbyl005,
   mmby005 LIKE mmby_t.mmby005,
   mmby005_desc LIKE type_t.chr80,
   mmby006 LIKE mmby_t.mmby006,
   mmby007 LIKE mmby_t.mmby007,
   mmby008 LIKE mmby_t.mmby008,
   mmby014 LIKE mmby_t.mmby014,
   mmby015 LIKE mmby_t.mmby015,
   mmby016 DATETIME YEAR TO SECOND,
   mmby017 LIKE mmby_t.mmby017,
   mmby019 LIKE mmby_t.mmby019, 
   mmby020 LIKE mmby_t.mmby020,     
   mmbystus LIKE mmby_t.mmbystus,
   mmbyownid LIKE mmby_t.mmbyownid,
   mmbyownid_desc LIKE type_t.chr80,
   mmbyowndp LIKE mmby_t.mmbyowndp,
   mmbyowndp_desc LIKE type_t.chr80,
   mmbycrtid LIKE mmby_t.mmbycrtid,
   mmbycrtid_desc LIKE type_t.chr80,
   mmbycrtdp LIKE mmby_t.mmbycrtdp,
   mmbycrtdp_desc LIKE type_t.chr80,
   mmbycrtdt DATETIME YEAR TO SECOND,
   mmbymodid LIKE mmby_t.mmbymodid,
   mmbymodid_desc LIKE type_t.chr80,
   mmbymoddt DATETIME YEAR TO SECOND,
   mmbycnfid LIKE mmby_t.mmbycnfid,
   mmbycnfid_desc LIKE type_t.chr80,
   mmbycnfdt DATETIME YEAR TO SECOND,
   mmbr004_1 LIKE type_t.chr80, 
   mmbr014_1 LIKE type_t.chr80, 
   mmbr016_1 LIKE type_t.chr80, 
   mmbr018_1 LIKE type_t.chr80, 
   mmbr004_1_desc LIKE type_t.chr80, 
   mmbr015_1 LIKE type_t.chr80, 
   mmbr017_1 LIKE type_t.chr80, 
   mmbr019_1 LIKE type_t.chr80
       END RECORD

#模組變數(Module Variables)
DEFINE g_mmby_m        type_g_mmby_m
DEFINE g_mmby_m_t      type_g_mmby_m                #備份舊值
DEFINE g_mmbysite_t   LIKE mmby_t.mmbysite    #Key值備份
DEFINE g_mmby001_t   LIKE mmby_t.mmby001    #Key值備份

DEFINE g_mmby002_t   LIKE mmby_t.mmby002    #Key值備份



DEFINE g_browser    DYNAMIC ARRAY OF RECORD                   #資料瀏覽之欄位
         b_statepic     LIKE type_t.chr50,
            b_mmbysite LIKE mmby_t.mmbysite,
   b_mmbysite_desc LIKE type_t.chr80,
      b_mmbyunit LIKE mmby_t.mmbyunit,
   b_mmbyunit_desc LIKE type_t.chr80,
      b_mmby004 LIKE mmby_t.mmby004,
      b_mmby001 LIKE mmby_t.mmby001,
      b_mmby002 LIKE mmby_t.mmby002,
      b_mmby005 LIKE mmby_t.mmby005,
   b_mmby005_desc LIKE type_t.chr80,
      b_mmby006 LIKE mmby_t.mmby006,
      b_mmby007 LIKE mmby_t.mmby007,
      b_mmby008 LIKE mmby_t.mmby008,
      b_mmby014 LIKE mmby_t.mmby014,
      b_mmby015 LIKE mmby_t.mmby015,
      b_mmby016 LIKE mmby_t.mmby016,
      b_mmby017 LIKE mmby_t.mmby017
         #,rank           LIKE type_t.num10
      END RECORD

DEFINE g_master_multi_table_t    RECORD
      mmbyl001 LIKE mmbyl_t.mmbyl001,
      mmbyl002 LIKE mmbyl_t.mmbyl002,
      mmbyl004 LIKE mmbyl_t.mmbyl004,
      mmbyl005 LIKE mmbyl_t.mmbyl005
      END RECORD

DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING

DEFINE g_wc2                 STRING                        #儲存 user 的查詢條件
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2          STRING
DEFINE g_wc2_table3          STRING

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
#DEFINE g_pagestart           LIKE type_t.num5             #page起始筆數#161108-00016#1   2016/11/09  by 08742 mark 
DEFINE g_pagestart           LIKE type_t.num10             #page起始筆數#161108-00016#1   2016/11/09  by 08742 add 
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

#快速搜尋用
DEFINE g_searchcol           STRING             #查詢欄位代碼
DEFINE g_searchstr           STRING             #查詢欄位字串
DEFINE g_order               STRING             #查詢排序模式

#Browser用
DEFINE g_current_idx         LIKE type_t.num5   #Browser 所在筆數(當下page)
DEFINE g_current_cnt         LIKE type_t.num10  #Browser 總筆數(當下page)

#161108-00016#1   2016/11/09  by 08742 -S
#DEFINE g_current_row         LIKE type_t.num5   #Browser 所在筆數(暫存用)
#DEFINE g_browser_idx         LIKE type_t.num5   #Browser 所在筆數(所有資料)
#DEFINE g_browser_cnt         LIKE type_t.num5   #Browser 總筆數 
DEFINE g_current_row         LIKE type_t.num10   #Browser 所在筆數(暫存用)
DEFINE g_browser_idx         LIKE type_t.num10   #Browser 所在筆數(所有資料)
DEFINE g_browser_cnt         LIKE type_t.num10  
#161108-00016#1   2016/11/09  by 08742 -E

DEFINE g_tmp_page            LIKE type_t.num5
DEFINE g_row_index           LIKE type_t.num5
DEFINE g_chk                 BOOLEAN
{</Module define>}
#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_mmbp_d     DYNAMIC ARRAY OF RECORD
       mmbp004      LIKE mmbp_t.mmbp004, 
       mmbp004_desc LIKE type_t.chr80, 
       mmbp005      LIKE mmbp_t.mmbp005, 
       mmbp006      LIKE mmbp_t.mmbp006, 
       mmbp007      LIKE mmbp_t.mmbp007, 
       mmbp008      LIKE mmbp_t.mmbp008, 
       mmbp009      LIKE mmbp_t.mmbp009,    #add by yangxf
       mmbp010      LIKE mmbp_t.mmbp010,    #add by yangxf       
       mmbpacti     LIKE mmbp_t.mmbpacti
                    END RECORD
DEFINE g_mmbp2_d    DYNAMIC ARRAY OF RECORD
       mmbs004      LIKE mmbs_t.mmbs004, 
       mmbs004_desc LIKE type_t.chr80, 
       mmbs005      LIKE mmbs_t.mmbs005, 
       mmbsacti     LIKE mmbs_t.mmbsacti
                    END RECORD
DEFINE g_mmbp3_d    DYNAMIC ARRAY OF RECORD
       mmbr003      LIKE mmbr_t.mmbr003, 
       mmbr004      LIKE mmbr_t.mmbr004, 
       mmbr004_desc LIKE type_t.chr80, 
       mmbr005      LIKE mmbr_t.mmbr005, 
       mmbr006      LIKE mmbr_t.mmbr006, 
       mmbr007      LIKE mmbr_t.mmbr007, 
       mmbr008      LIKE mmbr_t.mmbr008, 
       mmbr009      LIKE mmbr_t.mmbr009, 
       mmbr010      LIKE mmbr_t.mmbr010, 
       mmbr011      LIKE mmbr_t.mmbr011, 
       mmbr012      LIKE mmbr_t.mmbr012, 
       mmbr013      LIKE mmbr_t.mmbr013, 
       mmbr014      LIKE mmbr_t.mmbr014, 
       mmbr015      LIKE mmbr_t.mmbr015, 
       mmbr016      LIKE mmbr_t.mmbr016, 
       mmbr017      LIKE mmbr_t.mmbr017, 
       mmbr018      LIKE mmbr_t.mmbr018, 
       mmbr019      LIKE mmbr_t.mmbr019, 
       mmbracti     LIKE mmbr_t.mmbracti
                    END RECORD
#DEFINE g_current_page        LIKE type_t.num5             #目前所在頁數 #161108-00016#1   2016/11/09  by 08742 mark
DEFINE g_current_page        LIKE type_t.num10             #目前所在頁數 #161108-00016#1   2016/11/09  by 08742 add
#DEFINE g_detail_idx          LIKE type_t.num5             #單身目前所在筆數 #161108-00016#1   2016/11/09  by 08742 mark
DEFINE g_detail_idx          LIKE type_t.num10             #單身目前所在筆數 #161108-00016#1   2016/11/09  by 08742 add
#DEFINE g_mmbo       RECORD LIKE mmbo_t.*    #161111-00028#1--amrk
#161111-00028#1----add------begin--------------
DEFINE g_mmbo RECORD  #卡活動規則申請單頭檔
       mmboent LIKE mmbo_t.mmboent, #企業編號
       mmbosite LIKE mmbo_t.mmbosite, #營運據點
       mmbounit LIKE mmbo_t.mmbounit, #應用組織
       mmbodocno LIKE mmbo_t.mmbodocno, #單據編號
       mmbodocdt LIKE mmbo_t.mmbodocdt, #單據日期
       mmbo000 LIKE mmbo_t.mmbo000, #異動類型
       mmbo001 LIKE mmbo_t.mmbo001, #活動規則編號
       mmbo002 LIKE mmbo_t.mmbo002, #版本
       mmbo003 LIKE mmbo_t.mmbo003, #活動規則說明
       mmbo004 LIKE mmbo_t.mmbo004, #活動類型
       mmbo005 LIKE mmbo_t.mmbo005, #規則對象編號
       mmbo006 LIKE mmbo_t.mmbo006, #活動檔期編號
       mmbo007 LIKE mmbo_t.mmbo007, #規則類型
       mmbo008 LIKE mmbo_t.mmbo008, #排除方式
       mmbo009 LIKE mmbo_t.mmbo009, #累計方式
       mmbo010 LIKE mmbo_t.mmbo010, #換贈方式
       mmbo011 LIKE mmbo_t.mmbo011, #規則兌換限制
       mmbo012 LIKE mmbo_t.mmbo012, #規則兌換次數
       mmbo013 LIKE mmbo_t.mmbo013, #參加其他換贈
       mmbo014 LIKE mmbo_t.mmbo014, #開始日期
       mmbo015 LIKE mmbo_t.mmbo015, #結束日期
       mmboacti LIKE mmbo_t.mmboacti, #資料有效
       mmboownid LIKE mmbo_t.mmboownid, #資料所有者
       mmboowndp LIKE mmbo_t.mmboowndp, #資料所有部門
       mmbocrtid LIKE mmbo_t.mmbocrtid, #資料建立者
       mmbocrtdp LIKE mmbo_t.mmbocrtdp, #資料建立部門
       mmbocrtdt LIKE mmbo_t.mmbocrtdt, #資料創建日
       mmbomodid LIKE mmbo_t.mmbomodid, #資料修改者
       mmbomoddt LIKE mmbo_t.mmbomoddt, #最近修改日
       mmbocnfid LIKE mmbo_t.mmbocnfid, #資料確認者
       mmbocnfdt LIKE mmbo_t.mmbocnfdt, #資料確認日
       mmbostus LIKE mmbo_t.mmbostus, #狀態碼
       mmbo016 LIKE mmbo_t.mmbo016, #限定金額
       mmbo017 LIKE mmbo_t.mmbo017, #規則對象
       mmbo018 LIKE mmbo_t.mmbo018, #no use
       mmbo019 LIKE mmbo_t.mmbo019, #單筆限額
       mmbo020 LIKE mmbo_t.mmbo020, #活動限額
       mmbo021 LIKE mmbo_t.mmbo021, #人數限制
       mmbo022 LIKE mmbo_t.mmbo022  #依業態設定換贈規則
       END RECORD

#161111-00028#1----add------end---------------
#160613-00031#3 160615 by sakura add(S)
DEFINE g_mmbp4_d    DYNAMIC ARRAY OF RECORD
       mmdj005      LIKE mmdj_t.mmdj005, 
       mmdj006      LIKE mmdj_t.mmdj006, 
       mmdj007      LIKE mmdj_t.mmdj007, 
       mmdj008      LIKE mmdj_t.mmdj008, 
       mmdj009      LIKE mmdj_t.mmdj009, 
       mmdj010      LIKE mmdj_t.mmdj010, 
       mmdj011      LIKE mmdj_t.mmdj011, 
       mmdjacti     LIKE mmdj_t.mmdjacti
                    END RECORD   
DEFINE g_wc2_table4          STRING
#160613-00031#3 160615 by sakura add(E)
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="ammm358.main" >}
#+ 作業開始
MAIN
   #add-point:main段define name="main.define"
   DEFINE l_success LIKE type_t.num5   #150308-00001#3 150309 pomelo add
   #end add-point    
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("amm","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
 
   #add-point:SQL_define name="main.define_sql"
   LET g_forupd_sql = "SELECT mmbysite,'',mmbyunit,'',mmby004,mmby001,mmby002,'','',mmby005,'',mmby006,mmby007,mmby008,mmby014,mmby015,mmby016,mmby017,mmbystus,mmbyownid,'',mmbyowndp,'',mmbycrtid,'',mmbycrtdp,'',mmbycrtdt,mmbymodid,'',mmbymoddt,mmbycnfid,'',mmbycnfdt FROM mmby_t WHERE mmbyent= ? AND mmbysite=? AND mmby001=? AND mmby002=? FOR UPDATE"
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE ammm358_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ammm358 WITH FORM cl_ap_formpath("amm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL ammm358_init()
 
      #進入選單 Menu (='N')
      CALL ammm358_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_ammm358
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="ammm358.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION ammm358_init()
   #add-point:init段define
   DEFINE l_success LIKE type_t.num5   #150308-00001#3 150309 pomelo add
   #end add-point

   #該樣板不需此段落LET g_main_hidden = 0
      CALL cl_set_combo_scc_part('mmbystus','50','N,X,Y')

      CALL cl_set_combo_scc('mmby004','6516')
   CALL cl_set_combo_scc('mmby007','6517')
   CALL cl_set_combo_scc('mmby008','6517')
 
   CALL cl_set_combo_scc('mmby019','6856')
   CALL cl_set_combo_scc('mmbp005','6503') 
   CALL cl_set_combo_scc('mmbr007','6518') 
   CALL cl_set_combo_scc('mmbr010','6519') 
   CALL cl_set_combo_scc('mmbr018','6520') 
   CALL cl_set_combo_scc('mmbr019','30') 
   
   LET g_detail_idx = 1   #160613-00031#3 160615 by sakura add
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()

   #add-point:畫面資料初始化
   #150324-00007#4 Add By Ken 150408
   CALL cl_set_combo_scc_part('mmby007','6517',"0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,T,U,V,Z")
   CALL cl_set_combo_scc_part('mmby008','6517',"0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,T,U,V,W")
   #150324-00007#4
  
   CALL cl_set_combo_scc('b_mmby004','6516')
   CALL cl_set_combo_scc_part('b_mmby007','6517',"0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,T,U,V,Z")
   CALL cl_set_combo_scc_part('b_mmby008','6517',"0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,T,U,V,W")
   CALL cl_set_combo_scc_part('mmbr003','6517',"1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,Q,S,T,U,V,Z")
   CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   #160613-00031#3 160615 by sakura add(S)
   CALL cl_set_combo_scc('mmdj010','6520')
   CALL cl_set_combo_scc('mmdj011','30')   
   #160613-00031#3 160615 by sakura add(E)   
   #end add-point

   CALL ammm358_default_search()

END FUNCTION

PRIVATE FUNCTION ammm358_ui_dialog()
   {<Local define>}
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num5
   {</Local define>}
   #add-point:ui_dialog段define
   {<point name="ui_dialog.define"/>}
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_errno     LIKE type_t.chr10
   #end add-point

   LET li_exit = FALSE
   LET g_current_row = 0
   LET g_current_idx = 1
   CALL gfrm_curr.setElementImage("logo","logo/applogo.png")

   IF g_wc.trim() <> "1=1" THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   ELSE
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF

   #add-point:ui_dialog段before dialog
   {<point name="ui_dialog.before_dialog"/>}
   #end add-point

   WHILE li_exit = FALSE

      CALL ammm358_browser_fill(g_wc,"")
      CALL lib_cl_dlg.cl_dlg_before_display()
      CALL cl_notice()

      #判斷前一個動作是否為新增, 若是的話切換到新增的筆數
      IF g_state = "Y" THEN
         FOR li_idx = 1 TO g_browser.getLength()
            IF g_browser[li_idx].b_mmbysite = g_mmbysite_t
               AND g_browser[li_idx].b_mmby001 = g_mmby001_t

               AND g_browser[li_idx].b_mmby002 = g_mmby002_t


               THEN
               LET g_current_row = li_idx
               EXIT FOR
            END IF
         END FOR
         LET g_state = ""
      END IF

      #該樣板不需此段落IF g_main_hidden = 2 THEN
   #  IF g_main_hidden = 0 THEN
   #     MENU
   #        BEFORE MENU
#
   #           CALL cl_navigator_setting(g_current_idx, g_current_cnt)
#
   #           #還原為原本指定筆數
   #           IF g_current_row > 0 THEN
   #              LET g_current_idx = g_current_row
   #           END IF
#
   #           #當每次點任一筆資料都會需要用到
   #           IF g_browser_cnt > 0 THEN
   #              CALL ammm358_fetch("")
   #           END IF
#
   #        ON ACTION statechange
   #           CALL ammm358_statechange()
   #           LET g_action_choice="statechange"
#
   #        ON ACTION first
   #           CALL ammm358_fetch("F")
   #           LET g_current_row = g_current_idx
#
   #        ON ACTION next
   #           CALL ammm358_fetch("N")
   #           LET g_current_row = g_current_idx
#
   #        ON ACTION jump
   #           CALL ammm358_fetch("/")
   #           LET g_current_row = g_current_idx
#
   #        ON ACTION previous
   #           CALL ammm358_fetch("P")
   #           LET g_current_row = g_current_idx
#
   #        ON ACTION last
   #           CALL ammm358_fetch("L")
   #           #CALL cl_navigator_setting(g_current_idx, g_current_cnt)
   #           #CALL fgl_set_arr_curr(g_current_idx)
   #           LET g_current_row = g_current_idx
#
   #        ON ACTION exit
   #           LET g_action_choice="exit"
   #           LET INT_FLAG = FALSE
   #           LET li_exit = TRUE
   #           EXIT MENU
#
   #        ON ACTION close
   #           LET li_exit = TRUE
   #           EXIT MENU
#
   #        ON ACTION mainhidden       #主頁摺疊
   #           IF g_main_hidden THEN
   #              CALL gfrm_curr.setElementHidden("mainlayout",0)
   #              CALL gfrm_curr.setElementHidden("worksheet",1)
   #              LET g_main_hidden = 0
   #           ELSE
   #              CALL gfrm_curr.setElementHidden("mainlayout",1)
   #              CALL gfrm_curr.setElementHidden("worksheet",0)
   #              LET g_main_hidden = 1
   #           END IF
   #           EXIT MENU
#
   #        ON ACTION worksheethidden   #瀏覽頁折疊
   #           IF g_main_hidden THEN
   #              CALL gfrm_curr.setElementHidden("mainlayout",0)
   #              CALL gfrm_curr.setElementHidden("worksheet",1)
   #              LET g_main_hidden = 0
   #           ELSE
   #              CALL gfrm_curr.setElementHidden("mainlayout",1)
   #              CALL gfrm_curr.setElementHidden("worksheet",0)
   #              LET g_main_hidden = 1
   #           END IF
   #           EXIT MENU
#
   #        #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
   #        ON ACTION controls
   #           IF g_header_hidden THEN
   #              CALL gfrm_curr.setElementHidden("worksheet_detail",0)
   #              CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
   #              LET g_header_hidden = 0     #visible
   #           ELSE
   #              CALL gfrm_curr.setElementHidden("worksheet_detail",1)
   #              CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
   #              LET g_header_hidden = 1     #hidden
   #           END IF
#
#
#
   #     ON ACTION insert
#
   #        LET g_action_choice="insert"
   #        IF cl_auth_chk_act("insert") THEN
   #           CALL ammm358_insert()
   #           #add-point:ON ACTION insert
   #           {<point name="menu2.insert" />}
   #           #END add-point
   #           EXIT MENU
   #        END IF
#
#
   #     ON ACTION modify
#
   #        LET g_action_choice="modify"
   #        IF cl_auth_chk_act("modify") THEN
   #           CALL ammm358_modify()
   #           #add-point:ON ACTION modify
   #           {<point name="menu2.modify" />}
   #           #END add-point
   #           EXIT MENU
   #        END IF
#
#
   #     ON ACTION delete
#
   #        LET g_action_choice="delete"
   #        IF cl_auth_chk_act("delete") THEN
   #           CALL ammm358_delete()
   #           #add-point:ON ACTION delete
   #           {<point name="menu2.delete" />}
   #           #END add-point
   #        END IF
#
#
   #     ON ACTION query
#
   #        LET g_action_choice="query"
   #        IF cl_auth_chk_act("query") THEN
   #           CALL ammm358_query()
   #           #add-point:ON ACTION query
   #           {<point name="menu2.query" />}
   #           #END add-point
   #        END IF
#
#
   #     ON ACTION reproduce
#
   #        LET g_action_choice="reproduce"
   #        IF cl_auth_chk_act("reproduce") THEN
   #           CALL ammm358_reproduce()
   #           #add-point:ON ACTION reproduce
   #           {<point name="menu2.reproduce" />}
   #           #END add-point
   #           EXIT MENU
   #        END IF
#
#
   #     ON ACTION output
#
   #        LET g_action_choice="output"
   #        IF cl_auth_chk_act("output") THEN
   #           #add-point:ON ACTION output
   #           {<point name="menu2.output" />}
   #           #END add-point
   #           EXIT MENU
   #        END IF
#
#
#
#
   #        #主選單用ACTION
   #        &include "main_menu.4gl"
   #        &include "relating_action.4gl"
   #        #交談指令共用ACTION
   #        &include "common_action.4gl"
#
   #     END MENU
#
   #  ELSE

         DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

            #該樣板不需此段落INPUT g_searchstr,g_searchcol FROM formonly.searchstr,formonly.cbo_searchcol
            #該樣板不需此段落   BEFORE INPUT
            #該樣板不需此段落
            #該樣板不需此段落END INPUT

            #左側瀏覽頁簽
            DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTE(COUNT=g_rec_b)

               BEFORE ROW
                  #回歸舊筆數位置 (回到當時異動的筆數)
                  LET g_current_idx = DIALOG.getCurrentRow("s_browse")
                  IF g_current_idx = 0 THEN
                     LET g_current_idx = 1
                  END IF
                  LET g_current_row = g_current_idx  #目前指標
                  LET g_current_sw = TRUE
                  CALL cl_show_fld_cont()

                  #當每次點任一筆資料都會需要用到
                  CALL ammm358_fetch("")

               #該樣板不需此段落ON EXPAND (g_row_index)
               #該樣板不需此段落   #樹展開
               #該樣板不需此段落   CALL ammm358_browser_expand(g_row_index)
               #該樣板不需此段落   LET g_browser[g_row_index].b_isExp = 1

               ON COLLAPSE (g_row_index)
                  #樹關閉

            END DISPLAY


             #add-point:ui_dialog段define
            DISPLAY ARRAY g_mmbp_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1

               BEFORE ROW
                  CALL ammm358_idx_chk()
                  LET l_ac = DIALOG.getCurrentRow("s_detail1")
                  LET g_detail_idx = l_ac

               BEFORE DISPLAY
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
                  LET l_ac = DIALOG.getCurrentRow("s_detail1")
                  CALL ammm358_idx_chk()
                  LET g_current_page = 1
            END DISPLAY

            DISPLAY ARRAY g_mmbp2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b) #page2

               BEFORE ROW
                  CALL ammm358_idx_chk()
                  LET l_ac = DIALOG.getCurrentRow("s_detail2")
                  LET g_detail_idx = l_ac

               BEFORE DISPLAY
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
                  LET l_ac = DIALOG.getCurrentRow("s_detail2")
                  CALL ammm358_idx_chk()
                  LET g_current_page = 2
            END DISPLAY

            DISPLAY ARRAY g_mmbp3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b) #page3

               BEFORE ROW
                  CALL ammm358_idx_chk()
                  LET l_ac = DIALOG.getCurrentRow("s_detail3")
                  CALL ammm358_b_fill2()   #160613-00031#3 160615 by sakura add
                  LET g_detail_idx = l_ac
                  CALL ammm358_show_desc(l_ac)

               BEFORE DISPLAY
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
                  LET l_ac = DIALOG.getCurrentRow("s_detail3")
                  CALL ammm358_idx_chk()
                  LET g_current_page = 3
            END DISPLAY          {#ADP版次:1#}
            
            #160613-00031#3 160615 by sakura add(S)
            DISPLAY ARRAY g_mmbp4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b) #page4

               BEFORE ROW
                  CALL ammm358_idx_chk()
                  LET l_ac = DIALOG.getCurrentRow("s_detail4")
                  LET g_detail_idx = l_ac

               BEFORE DISPLAY
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
                  LET l_ac = DIALOG.getCurrentRow("s_detail4")
                  CALL ammm358_idx_chk()
                  LET g_current_page = 4
            END DISPLAY            
            #160613-00031#3 160615 by sakura add(E)            

            SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
            SUBDIALOG lib_cl_dlg.cl_dlg_relateapps

            #add-point:ui_dialog段define
            {<point name="ui_dialog.more_displayarray"/>}
            #end add-point

            BEFORE DIALOG
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #LET g_page = "first"
               #還原為原本指定筆數
               IF g_current_row > 1 THEN
                  #當刪除最後一筆資料時可能產生錯誤, 進行額外判斷
                  IF g_current_row > g_browser.getLength() THEN
                     LET g_current_row = g_browser.getLength()
                  END IF
                  LET g_current_idx = g_current_row
                  CALL DIALOG.setCurrentRow("s_browse",g_current_idx)
               END IF

               #當每次點任一筆資料都會需要用到
               IF g_browser_cnt > 0 THEN
                  CALL ammm358_fetch("")
               END IF

            AFTER DIALOG
               #add-point:ui_dialog段 after dialog
               {<point name="ui_dialog.after_dialog"/>}
               #end add-point
            
            ON ACTION exporttoexcel
               LET g_action_choice="exporttoexcel"
               IF cl_auth_chk_act("exporttoexcel") THEN
                  CALL g_export_node.clear()
                  IF g_main_hidden = 1 THEN
                     LET g_export_node[1] = base.typeInfo.create(g_browser)
                     LET g_export_id[1]   = "s_browse"
                     CALL cl_export_to_excel()
               #非browser
                  ELSE
                     LET g_export_node[1] = base.typeInfo.create(g_mmbp_d)
                     LET g_export_id[1]   = "s_detail1"
                     LET g_export_node[2] = base.typeInfo.create(g_mmbp2_d)
                     LET g_export_id[2]   = "s_detail2"
                     LET g_export_node[3] = base.typeInfo.create(g_mmbp3_d)
                     LET g_export_id[3]   = "s_detail3"
                     #160613-00031#3 160615 by sakura add(S)
                     LET g_export_node[4] = base.typeInfo.create(g_mmbp4_d)
                     LET g_export_id[4]   = "s_detail4"
                     #160613-00031#3 160615 by sakura add(E)
                     CALL cl_export_to_excel_getpage()
                    CALL cl_export_to_excel()
                  END IF  
               END IF
           

            ON ACTION statechange
               CALL ammm358_statechange()
               LET g_action_choice="statechange"
               EXIT DIALOG

            ON ACTION filter
               CALL ammm358_filter()
               EXIT DIALOG

            ON ACTION first
               CALL ammm358_fetch("F")
               LET g_current_row = g_current_idx

            ON ACTION next
               CALL ammm358_fetch("N")
               LET g_current_row = g_current_idx

            ON ACTION jump
               CALL ammm358_fetch("/")
               LET g_current_row = g_current_idx

            ON ACTION previous
               CALL ammm358_fetch("P")
               LET g_current_row = g_current_idx

            ON ACTION last
               CALL ammm358_fetch("L")
               #CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               #CALL fgl_set_arr_curr(g_current_idx)
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
                  #該樣板不需此段落CALL gfrm_curr.setElementHidden("mainlayout",1)
                  #該樣板不需此段落LET g_main_hidden = 0
                  #該樣板不需此段落CALL gfrm_curr.setElementImage("mainhidden","small/arr-u.png")
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  LET g_main_hidden = 1
                  #該樣板不需此段落CALL gfrm_curr.setElementHidden("mainlayout",0)
                  #該樣板不需此段落LET g_main_hidden = 1
                  #該樣板不需此段落CALL gfrm_curr.setElementImage("mainhidden","small/arr-d.png")
               END IF
               EXIT DIALOG

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
               EXIT DIALOG

            #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
            ON ACTION controls
               IF g_header_hidden THEN
                  CALL gfrm_curr.setElementHidden("worksheet_detail",0)
                  CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
                  LET g_header_hidden = 0     #visible
               ELSE
                  CALL gfrm_curr.setElementHidden("worksheet_detail",1)
                  CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
                  LET g_header_hidden = 1     #hidden
               END IF

            #快速搜尋
            #該樣板不需此段落ON ACTION searchdata
            #該樣板不需此段落   LET g_current_idx = 1
            #該樣板不需此段落   LET g_searchstr = GET_FLDBUF(searchstr)
            #該樣板不需此段落   CALL ammm358_browser_search()
            #該樣板不需此段落   EXIT DIALOG



   #     ON ACTION insert
#
   #        LET g_action_choice="insert"
   #        IF cl_auth_chk_act("insert") THEN
   #           CALL ammm358_insert()
   #           #add-point:ON ACTION insert
   #           {<point name="menu.insert" />}
   #           #END add-point
   #           EXIT DIALOG
   #        END IF


   #     ON ACTION modify
#
   #        LET g_action_choice="modify"
   #        IF cl_auth_chk_act("modify") THEN
   #           CALL ammm358_modify()
   #           #add-point:ON ACTION modify
   #           {<point name="menu.modify" />}
   #           #END add-point
   #           EXIT DIALOG
   #        END IF


    #    ON ACTION delete
#
    #       LET g_action_choice="delete"
    #       IF cl_auth_chk_act("delete") THEN
    #          CALL ammm358_delete()
    #          #add-point:ON ACTION delete
    #          {<point name="menu.delete" />}
    #          #END add-point
    #       END IF


         ON ACTION query

            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL ammm358_query()
               #add-point:ON ACTION query
               {<point name="menu.query" />}
               #END add-point
            END IF


   #     ON ACTION reproduce
#
   #        LET g_action_choice="reproduce"
   #        IF cl_auth_chk_act("reproduce") THEN
   #           CALL ammm358_reproduce()
   #           #add-point:ON ACTION reproduce
   #           {<point name="menu.reproduce" />}
   #           #END add-point
   #           EXIT DIALOG
   #        END IF


         ON ACTION output

            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               #add-point:ON ACTION output
               {<point name="menu.output" />}
               #END add-point
               EXIT DIALOG
            END IF


          ON ACTION exclude

            LET g_action_choice="exclude"
            IF cl_auth_chk_act("exclude") THEN 
               #add-point:ON ACTION exclude
                    
                 #  SELECT mmbo_t.* INTO g_mmbo.* FROM mmbo_t   #161111-00028#1--mark
                 #161111-00028#1----add------begin------------
                    SELECT mmbodocno,mmbo001,mmbo005,mmbo008,mmbosite,mmbounit INTO
                    g_mmbo.mmbodocno,g_mmbo.mmbo001,g_mmbo.mmbo005,g_mmbo.mmbo008,g_mmbo.mmbosite,g_mmbo.mmbounit
                    FROM mmbo_t
                 #161111-00028#1----add------end---------------
                     WHERE mmboent = g_enterprise AND mmbo001 = g_mmby_m.mmby001 
                       AND mmbo002 = g_mmby_m.mmby002
                    
                    IF cl_null(g_mmbo.mmbodocno) THEN
                       CONTINUE DIALOG
                    END IF
                    CALL ammt350_01(g_mmbo.mmbodocno,g_mmbo.mmbo001,g_mmbo.mmbo005,g_mmbo.mmbo008,g_mmbo.mmbosite,g_mmbo.mmbounit)
               #END add-point
                EXIT DIALOG
            END IF

         ON ACTION issue

            LET g_action_choice="issue"
            IF cl_auth_chk_act("issue") THEN 
               CALL s_transaction_begin()
               CALL s_ammm358_issue_chk(g_mmby_m.mmbysite,g_mmby_m.mmby001,g_mmby_m.mmby002,g_mmby_m.mmby017) RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_mmby_m.mmby001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               ELSE
                  IF NOT cl_ask_confirm('amm-00178') THEN 
                  ELSE
                     CALL s_ammm358_issue_upd(g_mmby_m.mmbysite,g_mmby_m.mmby001,g_mmby_m.mmby002) RETURNING l_success
                  END IF
               END IF
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
               ELSE      
                  CALL s_transaction_end('Y','0')
               END IF
               EXIT DIALOG
            END IF


            #主選單用ACTION
            &include "main_menu.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"

         END DIALOG

    #  END IF

   END WHILE

END FUNCTION

PRIVATE FUNCTION ammm358_browser_fill(p_wc,ps_page_action)
   {<Local define>}
   DEFINE p_wc              STRING
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_where           STRING
   {</Local define>}
   #add-point:browser_fill段define
   {<point name="browser_fill.define"/>}
   #end add-point

   CLEAR FORM
   INITIALIZE g_mmby_m.* TO NULL
   INITIALIZE g_wc TO NULL
   CALL g_browser.clear()
   CALL g_mmbp_d.clear()
   CALL g_mmbp2_d.clear()
   CALL g_mmbp3_d.clear()

   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = "0" THEN
      LET l_searchcol = "mmbysite,mmby001,mmby002"
   ELSE
      LET l_searchcol = g_searchcol
   END IF

   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 "
   END IF
   
   IF cl_null(g_wc)  THEN LET g_wc  = " 1=1" END IF
   IF cl_null(g_wc2) THEN LET g_wc2 = " 1=1" END IF
   
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      RETURN
   END IF
   
   LET p_wc = p_wc CLIPPED," AND mmby004 = '1' "
   LET l_wc = l_wc CLIPPED," AND mmby004 = '1' "
   LET g_wc = g_wc CLIPPED," AND mmby004 = '1' "
   
   CALL s_aooi500_sql_where(g_prog,'mmbysite') RETURNING l_where
   LET l_wc = l_wc CLIPPED," AND mmby004 = '1' AND ",l_where
   LET g_wc = g_wc CLIPPED," AND mmby004 = '1' AND ",l_where
   LET p_wc = p_wc CLIPPED," AND mmby004 = '1' AND ",l_where
   #add-point:browser_fill段wc控制
   {<point name="browser_fill.wc"/>}
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE mmbysite,mmby001,mmby002 ",
                      "   FROM mmby_t ",
                      "   LEFT JOIN mmbyl_t ON mmbylent = mmbyent AND mmbylsite = mmbysite AND mmbyl001 = mmby001 AND mmbyl002 = mmby002 AND mmbyl003 = '",g_lang,"' ",
                      "       ,mmbo_t ",
                      "   LEFT JOIN mmbp_t ON mmbpent = mmboent AND mmbodocno = mmbpdocno ",
                      "   LEFT JOIN mmbs_t ON mmbsent = mmboent AND mmbodocno = mmbsdocno ", 
                      "   LEFT JOIN mmbr_t ON mmbrent = mmboent AND mmbodocno = mmbrdocno ", 
                      "  WHERE mmbyent = mmboent AND mmby001 = mmbo001 AND mmby002 = mmbo002 ",
                      "    AND mmbyent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2  CLIPPED ,cl_sql_add_filter("mmby_t") #161214-00032#1 add  CLIPPED ,cl_sql_add_filter("mmby_t") 
 
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE mmbysite,mmby001,mmby002 ",
                      "   FROM mmby_t ", 
                      "   LEFT JOIN mmbyl_t ON mmbylent = mmbyent AND mmbylsite = mmbysite AND mmbyl001 = mmby001 AND mmbyl002 = mmby002 AND mmbyl003 = '",g_lang,"' ",
                      "  WHERE mmbyent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED,cl_sql_add_filter("mmby_t") #161214-00032#1 add  ,cl_sql_add_filter("mmby_t") 
 
   END IF

   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"


   #add-point:browser_fill段cnt_sql
   {<point name="browser_fill.cnt_sql"/>}
   #end add-point
				
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt
   FREE header_cnt_pre

   #若超過最大顯示筆數
   IF g_browser_cnt > g_max_browse AND g_error_show = 1 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = '9035'
      LET g_errparam.extend = g_browser_cnt
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF

      LET g_error_show = 0

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
   IF g_wc2 <> " 1=1" AND NOT cl_null(g_wc2) THEN 
      LET l_sql_rank = "SELECT mmbystus,mmbysite,'',mmbyunit,'',mmby004,mmby001,mmby002,mmby005,'',mmby006,mmby007,mmby008,mmby014,mmby015,mmby016,mmby017,RANK() OVER(ORDER BY mmbysite,mmby001,mmby002 ",g_order,") AS RANK ",
                       "  FROM mmby_t ",
                       "   LEFT JOIN mmbyl_t ON mmbylent = mmbyent AND mmbylsite = mmbysite AND mmbyl001 = mmby001 AND mmbyl002 = mmby002 AND mmbyl003 = '",g_lang,"' ",
                       "       ,mmbo_t ",
                       "   LEFT JOIN mmbp_t ON mmbpent = mmboent AND mmbodocno = mmbpdocno ",
                       "   LEFT JOIN mmbs_t ON mmbsent = mmboent AND mmbodocno = mmbsdocno ", 
                       "   LEFT JOIN mmbr_t ON mmbrent = mmboent AND mmbodocno = mmbrdocno ", 
                       "  WHERE mmbyent = mmboent AND mmby001 = mmbo001 AND mmby002 = mmbo002 ",
                       "    AND mmbyent = '" ||g_enterprise|| "' AND ",g_wc, " AND ", g_wc2 CLIPPED,cl_sql_add_filter("mmby_t") #161214-00032#1 add  CLIPPED ,cl_sql_add_filter("mmby_t") 
   ELSE
      #單身無輸入資料
      LET l_sql_rank = "SELECT mmbystus,mmbysite,'',mmbyunit,'',mmby004,mmby001,mmby002,mmby005,'',mmby006,mmby007,mmby008,mmby014,mmby015,mmby016,mmby017,RANK() OVER(ORDER BY mmbysite,mmby001,mmby002 ",g_order,") AS RANK ",
                       "  FROM mmby_t ", 
                       "  LEFT JOIN mmbyl_t ON mmbylent = mmbyent AND mmbylsite = mmbysite AND mmbyl001 = mmby001 AND mmbyl002 = mmby002 AND mmbyl003 = '",g_lang,"' ",
                       " WHERE mmbyent = '" ||g_enterprise|| "' AND ",g_wc CLIPPED,cl_sql_add_filter("mmby_t") #161214-00032#1 add  CLIPPED ,cl_sql_add_filter("mmby_t") 
   END IF				
					
   #定義翻頁CURSOR
   LET g_sql= " SELECT mmbystus,mmbysite,'',mmbyunit,'',mmby004,mmby001,mmby002,mmby005,'',mmby006,mmby007,mmby008,mmby014,mmby015,mmby016,mmby017 FROM (",l_sql_rank,") ",
              "  WHERE RANK >= ", g_pagestart,
              "    AND RANK <  ", (g_pagestart + g_max_browse) ,
              "  ORDER BY ",l_searchcol," ",g_order

   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre

   CALL g_browser.clear()
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_mmbysite,g_browser[g_cnt].b_mmbysite_desc,g_browser[g_cnt].b_mmbyunit,g_browser[g_cnt].b_mmbyunit_desc,g_browser[g_cnt].b_mmby004,g_browser[g_cnt].b_mmby001,g_browser[g_cnt].b_mmby002,g_browser[g_cnt].b_mmby005,g_browser[g_cnt].b_mmby005_desc,g_browser[g_cnt].b_mmby006,g_browser[g_cnt].b_mmby007,g_browser[g_cnt].b_mmby008,g_browser[g_cnt].b_mmby014,g_browser[g_cnt].b_mmby015,g_browser[g_cnt].b_mmby016,g_browser[g_cnt].b_mmby017   #單身 ARRAY 填充
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF


      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_mmbysite
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_lang||"'","") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_mmbysite_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_mmbysite_desc

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_mmbyunit
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_lang||"'","") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_mmbyunit_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_mmbyunit_desc

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_mmby005
      CALL ap_ref_array2(g_ref_fields,"SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_lang||"'","") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_mmby005_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_mmby005_desc


      #add-point:browser_fill段reference
      {<point name="browser_fill.reference"/>}
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
   LET g_header_cnt = g_browser.getLength()
   #該樣板不需此段落LET g_header_cnt = g_browser_cnt
   LET g_rec_b = g_cnt - 1
   LET g_current_cnt = g_rec_b
   #該樣板不需此段落LET g_current_cnt = g_browser_cnt
   LET g_cnt = 0

   CALL ammm358_fetch("")

   FREE browse_pre

END FUNCTION

PRIVATE FUNCTION ammm358_construct()
   {<Local define>}
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING
   {</Local define>}
   #add-point:cs段define
   {<point name="cs.define"/>}
   #end add-point

   CLEAR FORM
   INITIALIZE g_mmby_m.* TO NULL
   CALL g_mmbp_d.clear()        
   CALL g_mmbp2_d.clear() 
   CALL g_mmbp3_d.clear() 
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
   LET g_current_row = 1

   LET g_qryparam.state = "c"

   DISPLAY '1' TO mmby004
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON mmbysite,mmbyunit,mmby001,mmby002,mmbyl004,mmbyl005,mmby005,mmby006,mmby007,mmby008,mmby014,mmby015,mmby016,mmby017,mmby019,mmbystus,mmbyownid,mmbyowndp,mmbycrtid,mmbycrtdp,mmbycrtdt,mmbymodid,mmbymoddt,mmbycnfid,mmbycnfdt

         BEFORE CONSTRUCT
            CALL cl_qbe_init()
            #add-point:cs段more_construct
            {<point name="cs.before_construct"/>}
            #end add-point

         #公用欄位開窗相關處理
         #此段落由子樣板a11產生
         ##----<<mmbyownid>>----
         #ON ACTION controlp INFIELD mmbyownid
         #   CALL q_common('mmby_t','mmbyownid',TRUE,FALSE,g_mmby_m.mmbyownid) RETURNING ls_return
         #   DISPLAY ls_return TO mmbyownid
         #   NEXT FIELD mmbyownid
         #
         ##----<<mmbyowndp>>----
         #ON ACTION controlp INFIELD mmbyowndp
         #   CALL q_common('mmby_t','mmbyowndp',TRUE,FALSE,g_mmby_m.mmbyowndp) RETURNING ls_return
         #   DISPLAY ls_return TO mmbyowndp
         #   NEXT FIELD mmbyowndp
         #
         ##----<<mmbycrtid>>----
         #ON ACTION controlp INFIELD mmbycrtid
         #   CALL q_common('mmby_t','mmbycrtid',TRUE,FALSE,g_mmby_m.mmbycrtid) RETURNING ls_return
         #   DISPLAY ls_return TO mmbycrtid
         #   NEXT FIELD mmbycrtid
         #
         ##----<<mmbycrtdp>>----
         #ON ACTION controlp INFIELD mmbycrtdp
         #   CALL q_common('mmby_t','mmbycrtdp',TRUE,FALSE,g_mmby_m.mmbycrtdp) RETURNING ls_return
         #   DISPLAY ls_return TO mmbycrtdp
         #   NEXT FIELD mmbycrtdp
         #
         ##----<<mmbymodid>>----
         #ON ACTION controlp INFIELD mmbymodid
         #   CALL q_common('mmby_t','mmbymodid',TRUE,FALSE,g_mmby_m.mmbymodid) RETURNING ls_return
         #   DISPLAY ls_return TO mmbymodid
         #   NEXT FIELD mmbymodid
         #
         ##----<<mmbycnfid>>----
         #ON ACTION controlp INFIELD mmbycnfid
         #   CALL q_common('mmby_t','mmbycnfid',TRUE,FALSE,g_mmby_m.mmbycnfid) RETURNING ls_return
         #   DISPLAY ls_return TO mmbycnfid
         #   NEXT FIELD mmbycnfid
         #
         ##----<<mmbypstid>>----
         ##ON ACTION controlp INFIELD mmbypstid
         ##   CALL q_common('mmby_t','mmbypstid',TRUE,FALSE,g_mmby_m.mmbypstid) RETURNING ls_return
         ##   DISPLAY ls_return TO mmbypstid
         ##   NEXT FIELD mmbypstid

         ##----<<mmbycrtdt>>----
         AFTER FIELD mmbycrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)

         #----<<mmbymoddt>>----
         AFTER FIELD mmbymoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)

         #----<<mmbycnfdt>>----
         AFTER FIELD mmbycnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)

         #----<<mmbypstdt>>----
         #AFTER FIELD mmbypstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)



         #一般欄位
         #---------------------------<  Master  >---------------------------
         #----<<mmbysite>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbysite
            #add-point:BEFORE FIELD mmbysite
            {<point name="construct.b.mmbysite" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmbysite

            #add-point:AFTER FIELD mmbysite
            {<point name="construct.a.mmbysite" />}
            #END add-point


         #Ctrlp:construct.c.mmbysite
         ON ACTION controlp INFIELD mmbysite
            #add-point:ON ACTION controlp INFIELD mmbysite
            {<point name="construct.c.mmbysite" />}
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			#LET g_qryparam.arg1 = '2'
#			   LET g_qryparam.where = "ooef201 = 'Y'"
#            CALL q_ooef001()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmbysite',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO mmbysite  #顯示到畫面上

            NEXT FIELD mmbysite                     #返回原欄位
            #END add-point

         #----<<mmbyunit>>----
         #Ctrlp:construct.c.mmbyunit
         ON ACTION controlp INFIELD mmbyunit
            #add-point:ON ACTION controlp INFIELD mmbyunit
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			#  LET g_qryparam.arg1 = '2'
#			   LET g_qryparam.where = "ooef201 = 'Y'"
#            CALL q_ooef001()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmbyunit',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO mmbyunit  #顯示到畫面上

            NEXT FIELD mmbyunit                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD mmbyunit
            #add-point:BEFORE FIELD mmbyunit
            {<point name="construct.b.mmbyunit" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmbyunit

            #add-point:AFTER FIELD mmbyunit
            {<point name="construct.a.mmbyunit" />}
            #END add-point


         #----<<mmby004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmby004
            #add-point:BEFORE FIELD mmby004
            {<point name="construct.b.mmby004" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmby004

            #add-point:AFTER FIELD mmby004
            {<point name="construct.a.mmby004" />}
            #END add-point


         #Ctrlp:construct.c.mmby004
#         ON ACTION controlp INFIELD mmby004
            #add-point:ON ACTION controlp INFIELD mmby004
            {<point name="construct.c.mmby004" />}
            #END add-point

         #----<<mmby001>>----
         #Ctrlp:construct.c.mmby001
         ON ACTION controlp INFIELD mmby001
            #add-point:ON ACTION controlp INFIELD mmby001
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '1'
            CALL q_mmbt001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmby001  #顯示到畫面上

            NEXT FIELD mmby001                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD mmby001
            #add-point:BEFORE FIELD mmby001
            {<point name="construct.b.mmby001" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmby001

            #add-point:AFTER FIELD mmby001
            {<point name="construct.a.mmby001" />}
            #END add-point


         #----<<mmby002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmby002
            #add-point:BEFORE FIELD mmby002
            {<point name="construct.b.mmby002" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmby002

            #add-point:AFTER FIELD mmby002
            {<point name="construct.a.mmby002" />}
            #END add-point


         #Ctrlp:construct.c.mmby002
#         ON ACTION controlp INFIELD mmby002
            #add-point:ON ACTION controlp INFIELD mmby002
            {<point name="construct.c.mmby002" />}
            #END add-point

         #----<<mmbyl004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbyl004
            #add-point:BEFORE FIELD mmbyl004
            {<point name="construct.b.mmbyl004" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmbyl004

            #add-point:AFTER FIELD mmbyl004
            {<point name="construct.a.mmbyl004" />}
            #END add-point


         #Ctrlp:construct.c.mmbyl004
#         ON ACTION controlp INFIELD mmbyl004
            #add-point:ON ACTION controlp INFIELD mmbyl004
            {<point name="construct.c.mmbyl004" />}
            #END add-point

         #----<<mmbyl005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbyl005
            #add-point:BEFORE FIELD mmbyl005
            {<point name="construct.b.mmbyl005" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmbyl005

            #add-point:AFTER FIELD mmbyl005
            {<point name="construct.a.mmbyl005" />}
            #END add-point


         #Ctrlp:construct.c.mmbyl005
#         ON ACTION controlp INFIELD mmbyl005
            #add-point:ON ACTION controlp INFIELD mmbyl005
            {<point name="construct.c.mmbyl005" />}
            #END add-point

         #----<<mmby005>>----
         #Ctrlp:construct.c.mmby005
         ON ACTION controlp INFIELD mmby005
            #add-point:ON ACTION controlp INFIELD mmby005
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '1'
            #CALL q_mmbo005()    #160729-00077#6 20160819 mark by beckxie 
            #160729-00077#6 20160819 add by beckxie---S 
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmbysite',g_site,'c')   
            LET g_qryparam.where = cl_replace_str(g_qryparam.where,'ooef001','t1.mmbysite')
            CALL q_mmby005()     
            #160729-00077#6 20160819 add by beckxie---E
            DISPLAY g_qryparam.return1 TO mmby005  #顯示到畫面上

            NEXT FIELD mmby005                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD mmby005
            #add-point:BEFORE FIELD mmby005
            {<point name="construct.b.mmby005" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmby005

            #add-point:AFTER FIELD mmby005
            {<point name="construct.a.mmby005" />}
            #END add-point


         #----<<mmby006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmby006
            #add-point:BEFORE FIELD mmby006
            {<point name="construct.b.mmby006" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmby006

            #add-point:AFTER FIELD mmby006
            {<point name="construct.a.mmby006" />}
            #END add-point


         #Ctrlp:construct.c.mmby006
#         ON ACTION controlp INFIELD mmby006
            #add-point:ON ACTION controlp INFIELD mmby006
            {<point name="construct.c.mmby006" />}
            #END add-point

         #----<<mmby007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmby007
            #add-point:BEFORE FIELD mmby007
            {<point name="construct.b.mmby007" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmby007

            #add-point:AFTER FIELD mmby007
            {<point name="construct.a.mmby007" />}
            #END add-point


         #Ctrlp:construct.c.mmby007
#         ON ACTION controlp INFIELD mmby007
            #add-point:ON ACTION controlp INFIELD mmby007
            {<point name="construct.c.mmby007" />}
            #END add-point

         #----<<mmby008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmby008
            #add-point:BEFORE FIELD mmby008
            {<point name="construct.b.mmby008" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmby008

            #add-point:AFTER FIELD mmby008
            {<point name="construct.a.mmby008" />}
            #END add-point


         #Ctrlp:construct.c.mmby008
#         ON ACTION controlp INFIELD mmby008
            #add-point:ON ACTION controlp INFIELD mmby008
            {<point name="construct.c.mmby008" />}
            #END add-point

         #----<<mmby014>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmby014
            #add-point:BEFORE FIELD mmby014
            {<point name="construct.b.mmby014" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmby014

            #add-point:AFTER FIELD mmby014
            {<point name="construct.a.mmby014" />}
            #END add-point


         #Ctrlp:construct.c.mmby014
#         ON ACTION controlp INFIELD mmby014
            #add-point:ON ACTION controlp INFIELD mmby014
            {<point name="construct.c.mmby014" />}
            #END add-point

         #----<<mmby015>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmby015
            #add-point:BEFORE FIELD mmby015
            {<point name="construct.b.mmby015" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmby015

            #add-point:AFTER FIELD mmby015
            {<point name="construct.a.mmby015" />}
            #END add-point


         #Ctrlp:construct.c.mmby015
#         ON ACTION controlp INFIELD mmby015
            #add-point:ON ACTION controlp INFIELD mmby015
            {<point name="construct.c.mmby015" />}
            #END add-point

         #----<<mmby016>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmby016
            #add-point:BEFORE FIELD mmby016
            {<point name="construct.b.mmby016" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmby016

            #add-point:AFTER FIELD mmby016
            {<point name="construct.a.mmby016" />}
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result) 
            #END add-point


         #Ctrlp:construct.c.mmby016
#         ON ACTION controlp INFIELD mmby016
            #add-point:ON ACTION controlp INFIELD mmby016
            {<point name="construct.c.mmby016" />}
            #END add-point

         #----<<mmby017>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmby017
            #add-point:BEFORE FIELD mmby017
            {<point name="construct.b.mmby017" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmby017

            #add-point:AFTER FIELD mmby017
            {<point name="construct.a.mmby017" />}
            #END add-point


         #Ctrlp:construct.c.mmby017
#         ON ACTION controlp INFIELD mmby017
            #add-point:ON ACTION controlp INFIELD mmby017
            {<point name="construct.c.mmby017" />}
            #END add-point

         #----<<mmbystus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbystus
            #add-point:BEFORE FIELD mmbystus
            {<point name="construct.b.mmbystus" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmbystus

            #add-point:AFTER FIELD mmbystus
            {<point name="construct.a.mmbystus" />}
            #END add-point


         #Ctrlp:construct.c.mmbystus
#         ON ACTION controlp INFIELD mmbystus
            #add-point:ON ACTION controlp INFIELD mmbystus
            {<point name="construct.c.mmbystus" />}
            #END add-point

         #----<<mmbyownid>>----
         #Ctrlp:construct.c.mmbyownid
         ON ACTION controlp INFIELD mmbyownid
            #add-point:ON ACTION controlp INFIELD mmbyownid
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbyownid  #顯示到畫面上

            NEXT FIELD mmbyownid                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD mmbyownid
            #add-point:BEFORE FIELD mmbyownid
            {<point name="construct.b.mmbyownid" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmbyownid

            #add-point:AFTER FIELD mmbyownid
            {<point name="construct.a.mmbyownid" />}
            #END add-point


         #----<<mmbyowndp>>----
         #Ctrlp:construct.c.mmbyowndp
         ON ACTION controlp INFIELD mmbyowndp
            #add-point:ON ACTION controlp INFIELD mmbyowndp
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbyowndp  #顯示到畫面上

            NEXT FIELD mmbyowndp                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD mmbyowndp
            #add-point:BEFORE FIELD mmbyowndp
            {<point name="construct.b.mmbyowndp" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmbyowndp

            #add-point:AFTER FIELD mmbyowndp
            {<point name="construct.a.mmbyowndp" />}
            #END add-point


         #----<<mmbycrtid>>----
         #Ctrlp:construct.c.mmbycrtid
         ON ACTION controlp INFIELD mmbycrtid
            #add-point:ON ACTION controlp INFIELD mmbycrtid
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbycrtid  #顯示到畫面上

            NEXT FIELD mmbycrtid                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD mmbycrtid
            #add-point:BEFORE FIELD mmbycrtid
            {<point name="construct.b.mmbycrtid" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmbycrtid

            #add-point:AFTER FIELD mmbycrtid
            {<point name="construct.a.mmbycrtid" />}
            #END add-point


         #----<<mmbycrtdp>>----
         #Ctrlp:construct.c.mmbycrtdp
         ON ACTION controlp INFIELD mmbycrtdp
            #add-point:ON ACTION controlp INFIELD mmbycrtdp
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbycrtdp  #顯示到畫面上

            NEXT FIELD mmbycrtdp                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD mmbycrtdp
            #add-point:BEFORE FIELD mmbycrtdp
            {<point name="construct.b.mmbycrtdp" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmbycrtdp

            #add-point:AFTER FIELD mmbycrtdp
            {<point name="construct.a.mmbycrtdp" />}
            #END add-point


         #----<<mmbycrtdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbycrtdt
            #add-point:BEFORE FIELD mmbycrtdt
            {<point name="construct.b.mmbycrtdt" />}
            #END add-point

         #----<<mmbymodid>>----
         #Ctrlp:construct.c.mmbymodid
         ON ACTION controlp INFIELD mmbymodid
            #add-point:ON ACTION controlp INFIELD mmbymodid
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbymodid  #顯示到畫面上

            NEXT FIELD mmbymodid                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD mmbymodid
            #add-point:BEFORE FIELD mmbymodid
            {<point name="construct.b.mmbymodid" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmbymodid

            #add-point:AFTER FIELD mmbymodid
            {<point name="construct.a.mmbymodid" />}
            #END add-point


         #----<<mmbymoddt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbymoddt
            #add-point:BEFORE FIELD mmbymoddt
            {<point name="construct.b.mmbymoddt" />}
            #END add-point

         #----<<mmbycnfid>>----
         #Ctrlp:construct.c.mmbycnfid
         ON ACTION controlp INFIELD mmbycnfid
            #add-point:ON ACTION controlp INFIELD mmbycnfid
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbycnfid  #顯示到畫面上

            NEXT FIELD mmbycnfid                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD mmbycnfid
            #add-point:BEFORE FIELD mmbycnfid
            {<point name="construct.b.mmbycnfid" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmbycnfid

            #add-point:AFTER FIELD mmbycnfid
            {<point name="construct.a.mmbycnfid" />}
            #END add-point


         #----<<mmbycnfdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbycnfdt
            #add-point:BEFORE FIELD mmbycnfdt
            {<point name="construct.b.mmbycnfdt" />}
            #END add-point




      END CONSTRUCT
      
        CONSTRUCT g_wc2_table1 ON mmbp004,mmbp005,mmbp006,mmbp007,mmbp008,mmbp009,mmbp010,mmbpacti
           FROM s_detail1[1].mmbp004,s_detail1[1].mmbp005,s_detail1[1].mmbp006,s_detail1[1].mmbp007,s_detail1[1].mmbp008,
                s_detail1[1].mmbp009,s_detail1[1].mmbp010,s_detail1[1].mmbpacti
                      
         BEFORE CONSTRUCT

         ON ACTION controlp INFIELD mmbp004
            #add-point:ON ACTION controlp INFIELD mmbp004
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mmbp004()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbp004  #顯示到畫面上
            NEXT FIELD mmbp004                     #返回原欄位

      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON mmbs004,mmbs005,mmbsacti
           FROM s_detail2[1].mmbs004,s_detail2[1].mmbs005,s_detail2[1].mmbsacti
                      
         BEFORE CONSTRUCT
            
         ON ACTION controlp INFIELD mmbs004
            #add-point:ON ACTION controlp INFIELD mmbs004
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.arg1= '2'
#            LET g_qryparam.where = " ooef201='Y' "
#            CALL q_ooef001()                     #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'mmbs004') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmbs004',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
               CALL q_ooef001_24() 
            ELSE
               LET g_qryparam.where = " ooef201='Y' "
               CALL q_ooef001()                     #呼叫開窗  
            END IF
            DISPLAY g_qryparam.return1 TO mmbs004  #顯示到畫面上
            NEXT FIELD mmbs004                     #返回原欄位

      END CONSTRUCT

      CONSTRUCT g_wc2_table3 ON mmbr003,mmbr004,mmbr005,mmbr006,mmbr007,mmbr008,mmbr009,mmbr010,mmbr011,mmbr012,mmbr013,mmbr014,mmbr015,mmbr016,mmbr017,mmbr018,mmbr019,mmbracti
           FROM s_detail3[1].mmbr003,s_detail3[1].mmbr004,s_detail3[1].mmbr005,s_detail3[1].mmbr006,s_detail3[1].mmbr007,s_detail3[1].mmbr008,s_detail3[1].mmbr009,s_detail3[1].mmbr010,s_detail3[1].mmbr011,s_detail3[1].mmbr012,s_detail3[1].mmbr013,s_detail3[1].mmbr014,s_detail3[1].mmbr015,s_detail3[1].mmbr016,s_detail3[1].mmbr017,s_detail3[1].mmbr018,s_detail3[1].mmbr019,s_detail3[1].mmbracti
                      
         BEFORE CONSTRUCT

         ON ACTION controlp INFIELD mmbr004
            #add-point:ON ACTION controlp INFIELD mmbr004
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mmbr004()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbr004  #顯示到畫面上
            NEXT FIELD mmbr004                     #返回原欄位

      END CONSTRUCT
      
      #160613-00031#3 160615 by sakura add(S)
      CONSTRUCT g_wc2_table4 ON mmdj005,mmdj006,mmdj007,mmdj008,mmdj009,mmdj010,mmdj011,mmdjacti
           FROM s_detail4[1].mmdj005,s_detail4[1].mmdj006,s_detail4[1].mmdj007,s_detail4[1].mmdj008,s_detail4[1].mmdj009,s_detail4[1].mmdj010,s_detail4[1].mmdj011,s_detail4[1].mmdjacti
                      
         BEFORE CONSTRUCT

      END CONSTRUCT       
      #160613-00031#3 160615 by sakura add(E)      

      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG

      #add-point:cs段more_construct
      {<point name="cs.more_construct"/>}
      #end add-point

      #查詢CONSTRUCT共用ACTION
      &include "construct_action.4gl"

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG

   #add-point:cs段after_construct
   {<point name="cs.after_construct"/>}
   #end add-point

   #LET g_wc = g_wc CLIPPED,cl_get_extra_cond("", "")
   
    #組合g_wc2
   LET g_wc2 = g_wc2_table1
   IF g_wc2_table2 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
   END IF

   IF g_wc2_table3 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
   END IF
   
   #160613-00031#3 160615 by sakura add(S)
   IF g_wc2_table4 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND EXISTS(SELECT 1 FROM mmdj_t ",
                         "             WHERE mmcpent = mmdjent AND mmcpdocno = mmdjdocno ",
                         "               AND mmcp003 = mmdj003 AND mmcp004 = mmdj004 ",
                         "               AND mmdjent = ",g_enterprise,
                         "               AND ",g_wc2_table4," ) "
   END IF   
   #160613-00031#3 160615 by sakura add(E)   

END FUNCTION

PRIVATE FUNCTION ammm358_filter()
   {<Local define>}
   {</Local define>}
   #add-point:filter段define
   {<point name="filter.define"/>}
    DEFINE ls_result      STRING
   #end add-point

   LET INT_FLAG = 0

   LET g_qryparam.state = 'c'

   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc

   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')

   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單頭
      CONSTRUCT g_wc_filter ON mmbysite,mmbyunit,mmby001,mmby002,mmby005,mmby006,mmby007,mmby008,mmby014,mmby015,mmby016,mmby017
                          FROM s_browse[1].b_mmbysite,s_browse[1].b_mmbyunit,s_browse[1].b_mmby001,s_browse[1].b_mmby002,s_browse[1].b_mmby005,s_browse[1].b_mmby006,s_browse[1].b_mmby007,s_browse[1].b_mmby008,s_browse[1].b_mmby014,s_browse[1].b_mmby015,s_browse[1].b_mmby016,s_browse[1].b_mmby017

         BEFORE CONSTRUCT
            CALL cl_qbe_init()
               DISPLAY ammm358_filter_parser('mmbysite') TO s_browse[1].b_mmbysite
            DISPLAY ammm358_filter_parser('mmbyunit') TO s_browse[1].b_mmbyunit
            DISPLAY '1' TO s_browse[1].b_mmby004
            DISPLAY ammm358_filter_parser('mmby001') TO s_browse[1].b_mmby001
            DISPLAY ammm358_filter_parser('mmby002') TO s_browse[1].b_mmby002
            DISPLAY ammm358_filter_parser('mmby005') TO s_browse[1].b_mmby005
            DISPLAY ammm358_filter_parser('mmby006') TO s_browse[1].b_mmby006
            DISPLAY ammm358_filter_parser('mmby007') TO s_browse[1].b_mmby007
            DISPLAY ammm358_filter_parser('mmby008') TO s_browse[1].b_mmby008
            DISPLAY ammm358_filter_parser('mmby014') TO s_browse[1].b_mmby014
            DISPLAY ammm358_filter_parser('mmby015') TO s_browse[1].b_mmby015
            DISPLAY ammm358_filter_parser('mmby016') TO s_browse[1].b_mmby016
            DISPLAY ammm358_filter_parser('mmby017') TO s_browse[1].b_mmby017
            
            
        AFTER FIELD b_mmby016
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)       

      END CONSTRUCT

      #add-point:filter段add_cs
      {<point name="filter.add_cs"/>}
      #end add-point

      BEFORE DIALOG
         #add-point:filter段b_dialog
         {<point name="filter.b_dialog"/>}
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

END FUNCTION

PRIVATE FUNCTION ammm358_filter_parser(ps_field)
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}
   #add-point:filter段define
   {<point name="filter_parser.define"/>}
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

PRIVATE FUNCTION ammm358_query()
   {<Local define>}
   DEFINE ls_wc STRING
   {</Local define>}
   #add-point:query段define
   {<point name="query.define"/>}
   #end add-point

   LET INT_FLAG = 0
   LET ls_wc = g_wc

   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF

   CALL g_browser.clear()

   IF g_worksheet_hidden THEN  #browser panel 單身折疊
      CALL gfrm_curr.setElementHidden("worksheet_vbox",0)
      CALL gfrm_curr.setElementImage("worksheethidden","worksheethidden-24.png")
      LET g_worksheet_hidden = 0
   END IF
   IF g_header_hidden THEN    #單頭折疊
      CALL gfrm_curr.setElementHidden("worksheet_detail",0)
      CALL gfrm_curr.setElementImage("controls","headerhidden-24")
      LET g_header_hidden = 0
   END IF

   INITIALIZE g_mmby_m.* TO NULL
   ERROR ""

   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL ammm358_construct()

   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL ammm358_browser_fill(g_wc,"F")
      CALL ammm358_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF

   LET g_error_show = 1
   CALL ammm358_browser_fill(g_wc,"F")   # 移到第一頁

   #備份搜尋條件
   LET ls_wc = g_wc

   #第一層模糊搜尋
   IF g_browser.getLength() = 0 THEN
      LET g_wc = cl_wc_parser(ls_wc)
      LET g_error_show = 1
      CALL ammm358_browser_fill(g_wc,"F")
   END IF

   #第二層助記碼搜尋
   IF g_browser.getLength() = 0 THEN

      LET g_wc = cl_mcode_parser(ls_wc,'mmbyl_t','mmbyl006','mmby_t','mmbysite','3','')

      IF NOT cl_null(g_wc) THEN
         LET g_error_show = 1
         CALL ammm358_browser_fill(g_wc,"F")
      END IF

   END IF

   IF g_browser.getLength() = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "-100"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

   ELSE
      CALL ammm358_fetch("F")
   END IF

   LET g_wc_filter = ""

END FUNCTION

PRIVATE FUNCTION ammm358_fetch(p_fl)

   {<Local define>}
   DEFINE p_fl       LIKE type_t.chr1
   DEFINE ls_msg     STRING
   {</Local define>}

   #add-point:fetch段define
   {<point name="fetch.define"/>}
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

   #該樣板不需此段落IF g_browser[g_current_idx].b_expcode <> "1" THEN
   #該樣板不需此段落   INITIALIZE g_mmby_m.* TO NULL
   #該樣板不需此段落   DISPLAY BY NAME g_mmby_m.*
   #該樣板不需此段落   CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
   #該樣板不需此段落   RETURN
   #該樣板不需此段落ELSE
   #該樣板不需此段落   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   #該樣板不需此段落END IF

   #該樣板不需此段落CALL ammm358_browser_fill(g_wc,p_fl)

   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF

   # 設定browse索引
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx)

   CALL cl_navigator_setting(g_browser_idx, g_current_cnt)
   #該樣板不需此段落CALL cl_navigator_setting(g_browser_idx, g_browser_cnt )

   #代表沒有資料, 無需做後續資料撈取之動作
   IF g_current_idx = 0 THEN
      RETURN
   END IF

   LET g_mmby_m.mmbysite = g_browser[g_current_idx].b_mmbysite
   LET g_mmby_m.mmby001 = g_browser[g_current_idx].b_mmby001

   LET g_mmby_m.mmby002 = g_browser[g_current_idx].b_mmby002



   #重讀DB,因TEMP有不被更新特性
    SELECT UNIQUE mmbysite,mmbyunit,mmby004,mmby001,mmby002,mmby005,mmby006,mmby007,mmby008,mmby014,mmby015,mmby016,mmby017,mmby019,mmbystus,mmbyownid,mmbyowndp,mmbycrtid,mmbycrtdp,mmbycrtdt,mmbymodid,mmbymoddt,mmbycnfid,mmbycnfdt
 INTO g_mmby_m.mmbysite,g_mmby_m.mmbyunit,g_mmby_m.mmby004,g_mmby_m.mmby001,g_mmby_m.mmby002,g_mmby_m.mmby005,g_mmby_m.mmby006,g_mmby_m.mmby007,g_mmby_m.mmby008,g_mmby_m.mmby014,g_mmby_m.mmby015,g_mmby_m.mmby016,g_mmby_m.mmby017,g_mmby_m.mmby019,g_mmby_m.mmbystus,g_mmby_m.mmbyownid,g_mmby_m.mmbyowndp,g_mmby_m.mmbycrtid,g_mmby_m.mmbycrtdp,g_mmby_m.mmbycrtdt,g_mmby_m.mmbymodid,g_mmby_m.mmbymoddt,g_mmby_m.mmbycnfid,g_mmby_m.mmbycnfdt
 FROM mmby_t
 WHERE mmbyent = g_enterprise AND mmbysite = g_mmby_m.mmbysite AND mmby001 = g_mmby_m.mmby001 AND mmby002 = g_mmby_m.mmby002
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "mmby_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()

      INITIALIZE g_mmby_m.* TO NULL
      RETURN
   END IF

   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
   ELSE
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   END IF

   #add-point:fetch段action控制
   {<point name="fetch.action_control"/>}
   #end add-point



   #重新顯示
   CALL ammm358_show()

END FUNCTION

PRIVATE FUNCTION ammm358_insert()
   #add-point:insert段define
   {<point name="insert.define"/>}
   #end add-point

   CLEAR FORM                    #清畫面欄位內容

   INITIALIZE g_mmby_m.* LIKE mmby_t.*             #DEFAULT 設定
   LET g_mmbysite_t = NULL
   LET g_mmby001_t = NULL

   LET g_mmby002_t = NULL



   CALL s_transaction_begin()

   WHILE TRUE
      #六階樹狀給值

      #該樣板不需此段落LET g_current_idx = g_curr_diag.getCurrentRow("s_browse")
      #該樣板不需此段落IF g_current_idx > 0 THEN
         #該樣板不需此段落IF NOT cl_null(g_browser[g_current_idx].b_show) THEN
            #該樣板不需此段落LET  = g_browser[g_current_idx].b_mmbysite
            #該樣板不需此段落#LET  = g_browser[g_current_idx].b_
            #該樣板不需此段落#LET  = g_browser[g_current_idx].b_
            #該樣板不需此段落#LET  = g_browser[g_current_idx].b_
            #該樣板不需此段落#LET  = g_browser[g_current_idx].b_
            #該樣板不需此段落#LET  = g_browser[g_current_idx].b_
         #該樣板不需此段落END IF
      #該樣板不需此段落END IF

      #公用欄位給值
      #此段落由子樣板a14產生
      LET g_mmby_m.mmbyownid = g_user
      LET g_mmby_m.mmbyowndp = g_dept
      LET g_mmby_m.mmbycrtid = g_user
      LET g_mmby_m.mmbycrtdp = g_dept
      LET g_mmby_m.mmbycrtdt = cl_get_current()
      LET g_mmby_m.mmbymodid = ""
      LET g_mmby_m.mmbymoddt = ""
      #LET g_mmby_m.mmbystus = ""



      #append欄位給值


      #一般欄位給值
            LET g_mmby_m.mmby004 = "1"
      LET g_mmby_m.mmby002 = "1"
      LET g_mmby_m.mmby007 = "0"
      LET g_mmby_m.mmby008 = "0"


      #add-point:單頭預設值
      {<point name="insert.default"/>}
      #end add-point

      CALL ammm358_input("a")

      #add-point:單頭輸入後
      {<point name="insert.after_insert"/>}
      #end add-point

      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_mmby_m.* = g_mmby_m_t.*
         CALL ammm358_show()
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

   LET g_mmbysite_t = g_mmby_m.mmbysite
   LET g_mmby001_t = g_mmby_m.mmby001

   LET g_mmby002_t = g_mmby_m.mmby002



   LET g_state = "Y"

   LET g_wc = g_wc,
              " OR ( mmbyent = '" ||g_enterprise|| "' AND",
              " mmbysite = '", g_mmby_m.mmbysite CLIPPED, "' "
              ," AND mmby001 = '", g_mmby_m.mmby001 CLIPPED, "' "

              ," AND mmby002 = '", g_mmby_m.mmby002 CLIPPED, "' "


              , ") "

END FUNCTION

PRIVATE FUNCTION ammm358_modify()
   #add-point:modify段define
   {<point name="modify.define"/>}
   #end add-point

   IF g_mmby_m.mmbysite IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

    SELECT UNIQUE mmbysite,mmbyunit,mmby004,mmby001,mmby002,mmby005,mmby006,mmby007,mmby008,mmby014,mmby015,mmby016,mmby017,mmbystus,mmbyownid,mmbyowndp,mmbycrtid,mmbycrtdp,mmbycrtdt,mmbymodid,mmbymoddt,mmbycnfid,mmbycnfdt
 INTO g_mmby_m.mmbysite,g_mmby_m.mmbyunit,g_mmby_m.mmby004,g_mmby_m.mmby001,g_mmby_m.mmby002,g_mmby_m.mmby005,g_mmby_m.mmby006,g_mmby_m.mmby007,g_mmby_m.mmby008,g_mmby_m.mmby014,g_mmby_m.mmby015,g_mmby_m.mmby016,g_mmby_m.mmby017,g_mmby_m.mmbystus,g_mmby_m.mmbyownid,g_mmby_m.mmbyowndp,g_mmby_m.mmbycrtid,g_mmby_m.mmbycrtdp,g_mmby_m.mmbycrtdt,g_mmby_m.mmbymodid,g_mmby_m.mmbymoddt,g_mmby_m.mmbycnfid,g_mmby_m.mmbycnfdt
 FROM mmby_t
 WHERE mmbyent = g_enterprise AND mmbysite = g_mmby_m.mmbysite AND mmby001 = g_mmby_m.mmby001 AND mmby002 = g_mmby_m.mmby002

   ERROR ""

   LET g_mmbysite_t = g_mmby_m.mmbysite
   LET g_mmby001_t = g_mmby_m.mmby001

   LET g_mmby002_t = g_mmby_m.mmby002



   CALL s_transaction_begin()

   OPEN ammm358_cl USING g_enterprise,g_mmby_m.mmbysite,g_mmby_m.mmby001,g_mmby_m.mmby002
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN ammm358_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE ammm358_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #鎖住將被更改或取消的資料
   FETCH ammm358_cl INTO g_mmby_m.mmbysite,g_mmby_m.mmbysite_desc,g_mmby_m.mmbyunit,g_mmby_m.mmbyunit_desc,g_mmby_m.mmby004,g_mmby_m.mmby001,g_mmby_m.mmby002,g_mmby_m.mmbyl004,g_mmby_m.mmbyl005,g_mmby_m.mmby005,g_mmby_m.mmby005_desc,g_mmby_m.mmby006,g_mmby_m.mmby007,g_mmby_m.mmby008,g_mmby_m.mmby014,g_mmby_m.mmby015,g_mmby_m.mmby016,g_mmby_m.mmby017,g_mmby_m.mmbystus,g_mmby_m.mmbyownid,g_mmby_m.mmbyownid_desc,g_mmby_m.mmbyowndp,g_mmby_m.mmbyowndp_desc,g_mmby_m.mmbycrtid,g_mmby_m.mmbycrtid_desc,g_mmby_m.mmbycrtdp,g_mmby_m.mmbycrtdp_desc,g_mmby_m.mmbycrtdt,g_mmby_m.mmbymodid,g_mmby_m.mmbymodid_desc,g_mmby_m.mmbymoddt,g_mmby_m.mmbycnfid,g_mmby_m.mmbycnfid_desc,g_mmby_m.mmbycnfdt

   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "mmby_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()

      CLOSE ammm358_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF



   CALL ammm358_show()

   WHILE TRUE
      LET g_mmby_m.mmbysite = g_mmbysite_t
      LET g_mmby_m.mmby001 = g_mmby001_t

      LET g_mmby_m.mmby002 = g_mmby002_t



      #寫入修改者/修改日期資訊
      LET g_mmby_m.mmbymodid = g_user
LET g_mmby_m.mmbymoddt = cl_get_current()


      #add-point:modify段修改前
      {<point name="modify.before_input"/>}
      #end add-point

      CALL ammm358_input("u")     #欄位更改

      #add-point:modify段修改後
      {<point name="modify.after_input"/>}
      #end add-point

      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_mmby_m.* = g_mmby_m_t.*
         CALL ammm358_show()
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
   IF NOT cl_log_modified_record(g_mmby_m.mmbysite,g_site) THEN
      CALL s_transaction_end('N','0')
   END IF

   CLOSE ammm358_cl
   CALL s_transaction_end('Y','0')

   #流程通知預埋點-U
   CALL cl_flow_notify(g_mmby_m.mmbysite,"U")

   LET g_worksheet_hidden = 0

END FUNCTION

PRIVATE FUNCTION ammm358_input(p_cmd)
   {<Local define>}
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
   {</Local define>}
   #add-point:input段define
   {<point name="input.define"/>}
   #end add-point

   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   #該樣板不需此段落CALL gfrm_curr.setElementHidden("mainlayout",0)
   #該樣板不需此段落CALL gfrm_curr.setElementImage("mainhidden","small/arr-u.png")
   #該樣板不需此段落LET g_main_hidden = 1

   CALL cl_set_head_visible("","YES")

   IF p_cmd = 'r' THEN
      #此段落的r動作等同於a
      LET p_cmd = 'a'
   END IF

   LET l_insert = FALSE
   LET g_action_choice = ""

   LET g_qryparam.state = "i"

   #控制key欄位可否輸入
   CALL ammm358_set_entry(p_cmd)
   #add-point:set_entry後
   {<point name="input.after_set_entry"/>}
   #end add-point
   CALL ammm358_set_no_entry(p_cmd)
   #add-point:資料輸入前
   {<point name="input.before_input"/>}
   #end add-point

   DISPLAY BY NAME g_mmby_m.mmbysite,g_mmby_m.mmbyunit,g_mmby_m.mmby004,g_mmby_m.mmby001,g_mmby_m.mmby002,g_mmby_m.mmbyl004,g_mmby_m.mmbyl005,g_mmby_m.mmby005,g_mmby_m.mmby006,g_mmby_m.mmby007,g_mmby_m.mmby008,g_mmby_m.mmby014,g_mmby_m.mmby015,g_mmby_m.mmby016,g_mmby_m.mmby017,g_mmby_m.mmbystus

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單頭段
      INPUT BY NAME g_mmby_m.mmbysite,g_mmby_m.mmbyunit,g_mmby_m.mmby004,g_mmby_m.mmby001,g_mmby_m.mmby002,g_mmby_m.mmbyl004,g_mmby_m.mmbyl005,g_mmby_m.mmby005,g_mmby_m.mmby006,g_mmby_m.mmby007,g_mmby_m.mmby008,g_mmby_m.mmby014,g_mmby_m.mmby015,g_mmby_m.mmby016,g_mmby_m.mmby017,g_mmby_m.mmbystus
         ATTRIBUTE(WITHOUT DEFAULTS)

         #自訂ACTION(master_input)


         ON ACTION update_item
            #add-point:ON ACTION update_item
            {<point name="input.master_input.update_item" />}
            #END add-point


         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)
            LET g_master_multi_table_t.mmbyl001 = g_mmby_m.mmby001
LET g_master_multi_table_t.mmbyl002 = g_mmby_m.mmby002
LET g_master_multi_table_t.mmbyl004 = g_mmby_m.mmbyl004
LET g_master_multi_table_t.mmbyl005 = g_mmby_m.mmbyl005

            #add-point:input開始前
            {<point name="input.before.input"/>}
            #end add-point

         #---------------------------<  Master  >---------------------------
         #----<<mmbysite>>----
         #此段落由子樣板a02產生
         AFTER FIELD mmbysite

            #add-point:AFTER FIELD mmbysite
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_mmby_m.mmbysite) AND NOT cl_null(g_mmby_m.mmby001) AND NOT cl_null(g_mmby_m.mmby002) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_mmby_m.mmbysite != g_mmbysite_t  OR g_mmby_m.mmby001 != g_mmby001_t  OR g_mmby_m.mmby002 != g_mmby002_t )) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmby_t WHERE "||"mmbyent = '" ||g_enterprise|| "' AND "||"mmbysite = '"||g_mmby_m.mmbysite ||"' AND "|| "mmby001 = '"||g_mmby_m.mmby001 ||"' AND "|| "mmby002 = '"||g_mmby_m.mmby002 ||"'",'std-00004',0) THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmby_m.mmbysite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmby_m.mmbysite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmby_m.mmbysite_desc
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD mmbysite
            #add-point:BEFORE FIELD mmbysite
            {<point name="input.b.mmbysite" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE mmbysite
            #add-point:ON CHANGE mmbysite
            {<point name="input.g.mmbysite" />}
            #END add-point

         #----<<mmbyunit>>----
         #此段落由子樣板a02產生
         AFTER FIELD mmbyunit

            #add-point:AFTER FIELD mmbyunit

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmby_m.mmbyunit
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmby_m.mmbyunit_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmby_m.mmbyunit_desc
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD mmbyunit
            #add-point:BEFORE FIELD mmbyunit
            {<point name="input.b.mmbyunit" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE mmbyunit
            #add-point:ON CHANGE mmbyunit
            {<point name="input.g.mmbyunit" />}
            #END add-point

         #----<<mmby004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmby004
            #add-point:BEFORE FIELD mmby004
            {<point name="input.b.mmby004" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmby004

            #add-point:AFTER FIELD mmby004
            {<point name="input.a.mmby004" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE mmby004
            #add-point:ON CHANGE mmby004
            {<point name="input.g.mmby004" />}
            #END add-point

         #----<<mmby001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmby001
            #add-point:BEFORE FIELD mmby001
            {<point name="input.b.mmby001" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmby001

            #add-point:AFTER FIELD mmby001
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_mmby_m.mmbysite) AND NOT cl_null(g_mmby_m.mmby001) AND NOT cl_null(g_mmby_m.mmby002) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_mmby_m.mmbysite != g_mmbysite_t  OR g_mmby_m.mmby001 != g_mmby001_t  OR g_mmby_m.mmby002 != g_mmby002_t )) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmby_t WHERE "||"mmbyent = '" ||g_enterprise|| "' AND "||"mmbysite = '"||g_mmby_m.mmbysite ||"' AND "|| "mmby001 = '"||g_mmby_m.mmby001 ||"' AND "|| "mmby002 = '"||g_mmby_m.mmby002 ||"'",'std-00004',0) THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE mmby001
            #add-point:ON CHANGE mmby001
            {<point name="input.g.mmby001" />}
            #END add-point

         #----<<mmby002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmby002
            #add-point:BEFORE FIELD mmby002
            {<point name="input.b.mmby002" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmby002

            #add-point:AFTER FIELD mmby002
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_mmby_m.mmbysite) AND NOT cl_null(g_mmby_m.mmby001) AND NOT cl_null(g_mmby_m.mmby002) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_mmby_m.mmbysite != g_mmbysite_t  OR g_mmby_m.mmby001 != g_mmby001_t  OR g_mmby_m.mmby002 != g_mmby002_t )) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmby_t WHERE "||"mmbyent = '" ||g_enterprise|| "' AND "||"mmbysite = '"||g_mmby_m.mmbysite ||"' AND "|| "mmby001 = '"||g_mmby_m.mmby001 ||"' AND "|| "mmby002 = '"||g_mmby_m.mmby002 ||"'",'std-00004',0) THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE mmby002
            #add-point:ON CHANGE mmby002
            {<point name="input.g.mmby002" />}
            #END add-point

         #----<<mmbyl004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbyl004
            #add-point:BEFORE FIELD mmbyl004
            {<point name="input.b.mmbyl004" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmbyl004

            #add-point:AFTER FIELD mmbyl004
            {<point name="input.a.mmbyl004" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE mmbyl004
            #add-point:ON CHANGE mmbyl004
            {<point name="input.g.mmbyl004" />}
            #END add-point

         #----<<mmbyl005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbyl005
            #add-point:BEFORE FIELD mmbyl005
            {<point name="input.b.mmbyl005" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmbyl005

            #add-point:AFTER FIELD mmbyl005
            {<point name="input.a.mmbyl005" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE mmbyl005
            #add-point:ON CHANGE mmbyl005
            {<point name="input.g.mmbyl005" />}
            #END add-point

         #----<<mmby005>>----
         #此段落由子樣板a02產生
         AFTER FIELD mmby005

            #add-point:AFTER FIELD mmby005
            
            #160729-00077#6 20160817 mark by beckxie---S
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_mmby_m.mmby005
            #CALL ap_ref_array2(g_ref_fields,"SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_mmby_m.mmby005_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_mmby_m.mmby005_desc
            #160729-00077#6 20160817 mark by beckxie---E
            
            #160729-00077#6 20160817 add by beckxie---S
            CALL ammm358_mmby005_ref()
            #160729-00077#6 20160817 add by beckxie---E
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD mmby005
            #add-point:BEFORE FIELD mmby005
            {<point name="input.b.mmby005" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE mmby005
            #add-point:ON CHANGE mmby005
            {<point name="input.g.mmby005" />}
            #END add-point

         #----<<mmby006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmby006
            #add-point:BEFORE FIELD mmby006
            {<point name="input.b.mmby006" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmby006

            #add-point:AFTER FIELD mmby006
            {<point name="input.a.mmby006" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE mmby006
            #add-point:ON CHANGE mmby006
            {<point name="input.g.mmby006" />}
            #END add-point

         #----<<mmby007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmby007
            #add-point:BEFORE FIELD mmby007
            {<point name="input.b.mmby007" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmby007

            #add-point:AFTER FIELD mmby007
            {<point name="input.a.mmby007" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE mmby007
            #add-point:ON CHANGE mmby007
            {<point name="input.g.mmby007" />}
            #END add-point

         #----<<mmby008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmby008
            #add-point:BEFORE FIELD mmby008
            {<point name="input.b.mmby008" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmby008

            #add-point:AFTER FIELD mmby008
            {<point name="input.a.mmby008" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE mmby008
            #add-point:ON CHANGE mmby008
            {<point name="input.g.mmby008" />}
            #END add-point

         #----<<mmby014>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmby014
            #add-point:BEFORE FIELD mmby014
            {<point name="input.b.mmby014" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmby014

            #add-point:AFTER FIELD mmby014
            {<point name="input.a.mmby014" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE mmby014
            #add-point:ON CHANGE mmby014
            {<point name="input.g.mmby014" />}
            #END add-point

         #----<<mmby015>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmby015
            #add-point:BEFORE FIELD mmby015
            {<point name="input.b.mmby015" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmby015

            #add-point:AFTER FIELD mmby015
            {<point name="input.a.mmby015" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE mmby015
            #add-point:ON CHANGE mmby015
            {<point name="input.g.mmby015" />}
            #END add-point

         #----<<mmby016>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmby016
            #add-point:BEFORE FIELD mmby016
            {<point name="input.b.mmby016" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmby016

            #add-point:AFTER FIELD mmby016
            {<point name="input.a.mmby016" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE mmby016
            #add-point:ON CHANGE mmby016
            {<point name="input.g.mmby016" />}
            #END add-point

         #----<<mmby017>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmby017
            #add-point:BEFORE FIELD mmby017
            {<point name="input.b.mmby017" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmby017

            #add-point:AFTER FIELD mmby017
            {<point name="input.a.mmby017" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE mmby017
            #add-point:ON CHANGE mmby017
            {<point name="input.g.mmby017" />}
            #END add-point

         #----<<mmbystus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbystus
            #add-point:BEFORE FIELD mmbystus
            {<point name="input.b.mmbystus" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD mmbystus

            #add-point:AFTER FIELD mmbystus
            {<point name="input.a.mmbystus" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE mmbystus
            #add-point:ON CHANGE mmbystus
            {<point name="input.g.mmbystus" />}
            #END add-point

         #----<<mmbyownid>>----
         #----<<mmbyowndp>>----
         #----<<mmbycrtid>>----
         #----<<mmbycrtdp>>----
         #----<<mmbycrtdt>>----
         #----<<mmbymodid>>----
         #----<<mmbymoddt>>----
         #----<<mmbycnfid>>----
         #----<<mmbycnfdt>>----
 #欄位檢查
         #---------------------------<  Master  >---------------------------
         #----<<mmbysite>>----
         #Ctrlp:input.c.mmbysite
#         ON ACTION controlp INFIELD mmbysite
            #add-point:ON ACTION controlp INFIELD mmbysite
            {<point name="input.c.mmbysite" />}
            #END add-point

         #----<<mmbyunit>>----
         #Ctrlp:input.c.mmbyunit
         ON ACTION controlp INFIELD mmbyunit
            #add-point:ON ACTION controlp INFIELD mmbyunit
#此段落由子樣板a07產生
            #開窗i段
			#INITIALIZE g_qryparam.* TO NULL
         #   LET g_qryparam.state = 'i'
			#LET g_qryparam.reqry = FALSE
         #
         #   LET g_qryparam.default1 = g_mmby_m.mmbyunit             #給予default值
         #
         #   #給予arg
         #   LET g_qryparam.arg1 = "" #
         #   LET g_qryparam.arg2 = "" #
         #
         #   CALL q_ooed004()                                #呼叫開窗
         #
         #   LET g_mmby_m.mmbyunit = g_qryparam.return1              #將開窗取得的值回傳到變數
         #
         #   DISPLAY g_mmby_m.mmbyunit TO mmbyunit              #顯示到畫面上
         #
         #   NEXT FIELD mmbyunit                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<mmby004>>----
         #Ctrlp:input.c.mmby004
#         ON ACTION controlp INFIELD mmby004
            #add-point:ON ACTION controlp INFIELD mmby004
            {<point name="input.c.mmby004" />}
            #END add-point

         #----<<mmby001>>----
         #Ctrlp:input.c.mmby001
#         ON ACTION controlp INFIELD mmby001
            #add-point:ON ACTION controlp INFIELD mmby001
            {<point name="input.c.mmby001" />}
            #END add-point

         #----<<mmby002>>----
         #Ctrlp:input.c.mmby002
#         ON ACTION controlp INFIELD mmby002
            #add-point:ON ACTION controlp INFIELD mmby002
            {<point name="input.c.mmby002" />}
            #END add-point

         #----<<mmbyl004>>----
         #Ctrlp:input.c.mmbyl004
#         ON ACTION controlp INFIELD mmbyl004
            #add-point:ON ACTION controlp INFIELD mmbyl004
            {<point name="input.c.mmbyl004" />}
            #END add-point

         #----<<mmbyl005>>----
         #Ctrlp:input.c.mmbyl005
#         ON ACTION controlp INFIELD mmbyl005
            #add-point:ON ACTION controlp INFIELD mmbyl005
            {<point name="input.c.mmbyl005" />}
            #END add-point

         #----<<mmby005>>----
         #Ctrlp:input.c.mmby005
         ON ACTION controlp INFIELD mmby005
            #add-point:ON ACTION controlp INFIELD mmby005
#此段落由子樣板a07產生
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmby_m.mmby005             #給予default值

            #給予arg

            CALL q_mman001()                                #呼叫開窗

            LET g_mmby_m.mmby005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmby_m.mmby005 TO mmby005              #顯示到畫面上

            NEXT FIELD mmby005                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<mmby006>>----
         #Ctrlp:input.c.mmby006
#         ON ACTION controlp INFIELD mmby006
            #add-point:ON ACTION controlp INFIELD mmby006
            {<point name="input.c.mmby006" />}
            #END add-point

         #----<<mmby007>>----
         #Ctrlp:input.c.mmby007
#         ON ACTION controlp INFIELD mmby007
            #add-point:ON ACTION controlp INFIELD mmby007
            {<point name="input.c.mmby007" />}
            #END add-point

         #----<<mmby008>>----
         #Ctrlp:input.c.mmby008
#         ON ACTION controlp INFIELD mmby008
            #add-point:ON ACTION controlp INFIELD mmby008
            {<point name="input.c.mmby008" />}
            #END add-point

         #----<<mmby014>>----
         #Ctrlp:input.c.mmby014
#         ON ACTION controlp INFIELD mmby014
            #add-point:ON ACTION controlp INFIELD mmby014
            {<point name="input.c.mmby014" />}
            #END add-point

         #----<<mmby015>>----
         #Ctrlp:input.c.mmby015
#         ON ACTION controlp INFIELD mmby015
            #add-point:ON ACTION controlp INFIELD mmby015
            {<point name="input.c.mmby015" />}
            #END add-point

         #----<<mmby016>>----
         #Ctrlp:input.c.mmby016
#         ON ACTION controlp INFIELD mmby016
            #add-point:ON ACTION controlp INFIELD mmby016
            {<point name="input.c.mmby016" />}
            #END add-point

         #----<<mmby017>>----
         #Ctrlp:input.c.mmby017
#         ON ACTION controlp INFIELD mmby017
            #add-point:ON ACTION controlp INFIELD mmby017
            {<point name="input.c.mmby017" />}
            #END add-point

         #----<<mmbystus>>----
         #Ctrlp:input.c.mmbystus
#         ON ACTION controlp INFIELD mmbystus
            #add-point:ON ACTION controlp INFIELD mmbystus
            {<point name="input.c.mmbystus" />}
            #END add-point

         #----<<mmbyownid>>----
         #----<<mmbyowndp>>----
         #----<<mmbycrtid>>----
         #----<<mmbycrtdp>>----
         #----<<mmbycrtdt>>----
         #----<<mmbymodid>>----
         #----<<mmbymoddt>>----
         #----<<mmbycnfid>>----
         #----<<mmbycnfdt>>----
 #欄位開窗

         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF

            CALL cl_showmsg()   #錯誤訊息統整顯示

            IF p_cmd <> "u" THEN
               LET l_count = 1

               SELECT COUNT(*) INTO l_count FROM mmby_t
                WHERE mmbyent = g_enterprise AND mmbysite = g_mmby_m.mmbysite
                  AND mmby001 = g_mmby_m.mmby001

                  AND mmby002 = g_mmby_m.mmby002


               IF l_count = 0 THEN

                  #add-point:單頭新增前
                  {<point name="input.head.b_insert" mark="Y"/>}
                  #end add-point

                  INSERT INTO mmby_t (mmbyent,mmbysite,mmbyunit,mmby004,mmby001,mmby002,mmby005,mmby006,mmby007,mmby008,mmby014,mmby015,mmby016,mmby017,mmbystus,mmbyownid,mmbyowndp,mmbycrtid,mmbycrtdp,mmbycrtdt,mmbymodid,mmbymoddt,mmbycnfid,mmbycnfdt)
                  VALUES (g_enterprise,g_mmby_m.mmbysite,g_mmby_m.mmbyunit,g_mmby_m.mmby004,g_mmby_m.mmby001,g_mmby_m.mmby002,g_mmby_m.mmby005,g_mmby_m.mmby006,g_mmby_m.mmby007,g_mmby_m.mmby008,g_mmby_m.mmby014,g_mmby_m.mmby015,g_mmby_m.mmby016,g_mmby_m.mmby017,g_mmby_m.mmbystus,g_mmby_m.mmbyownid,g_mmby_m.mmbyowndp,g_mmby_m.mmbycrtid,g_mmby_m.mmbycrtdp,g_mmby_m.mmbycrtdt,g_mmby_m.mmbymodid,g_mmby_m.mmbymoddt,g_mmby_m.mmbycnfid,g_mmby_m.mmbycnfdt)

                  #add-point:單頭新增中
                  {<point name="input.head.m_insert"/>}
                  #end add-point

                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "mmby_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CONTINUE DIALOG
                  END IF



                  #資料多語言用-增/改
                           INITIALIZE l_var_keys TO NULL
         INITIALIZE l_field_keys TO NULL
         INITIALIZE l_vars TO NULL
         INITIALIZE l_fields TO NULL
         IF g_mmby_m.mmby001 = g_master_multi_table_t.mmbyl001 AND
         g_mmby_m.mmby002 = g_master_multi_table_t.mmbyl002 AND
         g_mmby_m.mmbyl004 = g_master_multi_table_t.mmbyl004 AND
         g_mmby_m.mmbyl005 = g_master_multi_table_t.mmbyl005  THEN
         ELSE
            LET l_var_keys[01] = g_mmby_m.mmby001
            LET l_field_keys[01] = 'mmbyl001'
            LET l_var_keys_bak[01] = g_master_multi_table_t.mmbyl001
            LET l_var_keys[02] = g_mmby_m.mmby002
            LET l_field_keys[02] = 'mmbyl002'
            LET l_var_keys_bak[02] = g_master_multi_table_t.mmbyl002
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'mmbyl003'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_mmby_m.mmbyl004
            LET l_fields[01] = 'mmbyl004'
            LET l_vars[02] = g_mmby_m.mmbyl005
            LET l_fields[02] = 'mmbyl005'
            LET l_vars[03] = g_site
            LET l_fields[03] = 'mmbylsite'
            LET l_vars[04] = g_enterprise
            LET l_fields[04] = 'mmbylent'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mmbyl_t')
         END IF


                  #add-point:單頭新增後
                  {<point name="input.head.a_insert"/>}
                  #end add-point

                  CALL s_transaction_end('Y','0')
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  "std-00006"
                  LET g_errparam.extend =  "g_mmby_m.mmbysite"
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
               END IF
            ELSE
               #add-point:單頭修改前
               {<point name="input.head.b_update" mark="Y"/>}
               #end add-point
               UPDATE mmby_t SET (mmbysite,mmbyunit,mmby004,mmby001,mmby002,mmby005,mmby006,mmby007,mmby008,mmby014,mmby015,mmby016,mmby017,mmbystus,mmbyownid,mmbyowndp,mmbycrtid,mmbycrtdp,mmbycrtdt,mmbymodid,mmbymoddt,mmbycnfid,mmbycnfdt) = (g_mmby_m.mmbysite,g_mmby_m.mmbyunit,g_mmby_m.mmby004,g_mmby_m.mmby001,g_mmby_m.mmby002,g_mmby_m.mmby005,g_mmby_m.mmby006,g_mmby_m.mmby007,g_mmby_m.mmby008,g_mmby_m.mmby014,g_mmby_m.mmby015,g_mmby_m.mmby016,g_mmby_m.mmby017,g_mmby_m.mmbystus,g_mmby_m.mmbyownid,g_mmby_m.mmbyowndp,g_mmby_m.mmbycrtid,g_mmby_m.mmbycrtdp,g_mmby_m.mmbycrtdt,g_mmby_m.mmbymodid,g_mmby_m.mmbymoddt,g_mmby_m.mmbycnfid,g_mmby_m.mmbycnfdt)
                WHERE mmbyent = g_enterprise AND mmbysite = g_mmbysite_t #
                  AND mmby001 = g_mmby001_t

                  AND mmby002 = g_mmby002_t


               #add-point:單頭修改中
               {<point name="input.head.m_update"/>}
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "mmby_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "mmby_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                  OTHERWISE

                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL
         INITIALIZE l_field_keys TO NULL
         INITIALIZE l_vars TO NULL
         INITIALIZE l_fields TO NULL
         IF g_mmby_m.mmby001 = g_master_multi_table_t.mmbyl001 AND
         g_mmby_m.mmby002 = g_master_multi_table_t.mmbyl002 AND
         g_mmby_m.mmbyl004 = g_master_multi_table_t.mmbyl004 AND
         g_mmby_m.mmbyl005 = g_master_multi_table_t.mmbyl005  THEN
         ELSE
            LET l_var_keys[01] = g_mmby_m.mmby001
            LET l_field_keys[01] = 'mmbyl001'
            LET l_var_keys_bak[01] = g_master_multi_table_t.mmbyl001
            LET l_var_keys[02] = g_mmby_m.mmby002
            LET l_field_keys[02] = 'mmbyl002'
            LET l_var_keys_bak[02] = g_master_multi_table_t.mmbyl002
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'mmbyl003'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_mmby_m.mmbyl004
            LET l_fields[01] = 'mmbyl004'
            LET l_vars[02] = g_mmby_m.mmbyl005
            LET l_fields[02] = 'mmbyl005'
            LET l_vars[03] = g_site
            LET l_fields[03] = 'mmbylsite'
            LET l_vars[04] = g_enterprise
            LET l_fields[04] = 'mmbylent'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mmbyl_t')
         END IF

                     #add-point:單頭修改後
                     {<point name="input.head.a_update"/>}
                     #end add-point
                     CALL s_transaction_end('Y','0')
               END CASE
            END IF
           #controlp
      END INPUT

      #add-point:input段more input
      {<point name="input.more_input"/>}
      #end add-point
		
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name, g_fld_name, g_lang)

      ON ACTION controlr
         CALL cl_show_req_fields()

      ON ACTION controls
         CALL cl_set_head_visible("","AUTO")

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
   {<point name="input.after_input"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION ammm358_reproduce()
   {<Local define>}
   DEFINE l_newno     LIKE mmby_t.mmbysite
   DEFINE l_oldno     LIKE mmby_t.mmbysite
   DEFINE l_newno02     LIKE mmby_t.mmby001
   DEFINE l_oldno02     LIKE mmby_t.mmby001

   DEFINE l_newno03     LIKE mmby_t.mmby002
   DEFINE l_oldno03     LIKE mmby_t.mmby002


   DEFINE l_master    RECORD LIKE mmby_t.*
   DEFINE l_cnt       LIKE type_t.num5
   {</Local define>}

   #add-point:reproduce段define
   {<point name="reproduce.define"/>}
   #end add-point

   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF

   IF g_mmby_m.mmbysite IS NULL
      OR g_mmby_m.mmby001 IS NULL

      OR g_mmby_m.mmby002 IS NULL


   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

   LET g_mmbysite_t = g_mmby_m.mmbysite
   LET g_mmby001_t = g_mmby_m.mmby001

   LET g_mmby002_t = g_mmby_m.mmby002



   LET g_mmby_m.mmbysite = ""
   LET g_mmby_m.mmby001 = ""

   LET g_mmby_m.mmby002 = ""



   CALL ammm358_set_entry("a")
   CALL ammm358_set_no_entry("a")

   #公用欄位給予預設值
   #此段落由子樣板a14產生
      LET g_mmby_m.mmbyownid = g_user
      LET g_mmby_m.mmbyowndp = g_dept
      LET g_mmby_m.mmbycrtid = g_user
      LET g_mmby_m.mmbycrtdp = g_dept
      LET g_mmby_m.mmbycrtdt = cl_get_current()
      LET g_mmby_m.mmbymodid = ""
      LET g_mmby_m.mmbymoddt = ""
      #LET g_mmby_m.mmbystus = ""



   #add-point:複製輸入前
   {<point name="reproduce.head.b_input"/>}
   #end add-point

   CALL ammm358_input("r")

      LET g_mmby_m.mmbysite_desc = ''
   DISPLAY BY NAME g_mmby_m.mmbysite_desc


   IF INT_FLAG  THEN
      LET INT_FLAG = 0
      RETURN
   END IF

   CALL s_transaction_begin()

   #add-point:單頭複製前
   {<point name="reproduce.head.b_insert" mark="Y"/>}
   #end add-point

   #add-point:單頭複製中
   {<point name="reproduce.head.m_insert"/>}
   #end add-point

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "mmby_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #add-point:單頭複製後
   {<point name="reproduce.head.a_insert"/>}
   #end add-point

   CALL s_transaction_end('Y','0')

   LET g_state = "Y"

   LET g_wc = g_wc,
              " OR (",
              " mmbysite = '", g_mmby_m.mmbysite CLIPPED, "' "
              ," AND mmby001 = '", g_mmby_m.mmby001 CLIPPED, "' "

              ," AND mmby002 = '", g_mmby_m.mmby002 CLIPPED, "' "


              , ") "

   LET g_mmbysite_t = g_mmby_m.mmbysite
   LET g_mmby001_t = g_mmby_m.mmby001

   LET g_mmby002_t = g_mmby_m.mmby002



   #add-point:完成複製段落後
   {<point name="reproduce.after_reproduce" />}
   #end add-point

END FUNCTION

PRIVATE FUNCTION ammm358_show()
   #add-point:show段define
   {<point name="show.define"/>}
   DEFINE l_flag     LIKE type_t.num5
   #end add-point

   #add-point:show段之前
   {<point name="show.before"/>}
   #end add-point

   CALL ammm358_b_fill()
   CALL ammm358_b_fill2() #單身填充   #160613-00031#3 160615 by sakura add

   LET g_mmby_m_t.* = g_mmby_m.*      #保存單頭舊值

   #在browser 移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()

   #帶出公用欄位reference值
   #此段落由子樣板a12產生
      #LET g_mmby_m.mmbyownid_desc = cl_get_username(g_mmby_m.mmbyownid)
      #LET g_mmby_m.mmbyowndp_desc = cl_get_deptname(g_mmby_m.mmbyowndp)
      #LET g_mmby_m.mmbycrtid_desc = cl_get_username(g_mmby_m.mmbycrtid)
      #LET g_mmby_m.mmbycrtdp_desc = cl_get_deptname(g_mmby_m.mmbycrtdp)
      #LET g_mmby_m.mmbymodid_desc = cl_get_username(g_mmby_m.mmbymodid)
      #LET g_mmby_m.mmbycnfid_desc = cl_get_deptname(g_mmby_m.mmbycnfid)
      ##LET g_mmby_m.mmbypstid_desc = cl_get_deptname(g_mmby_m.mmbypstid)




   #讀入ref值(單頭)
   #add-point:show段reference
   #160729-00077#6 20160817 mark by beckxie---S
   #IF g_mmby_m.mmby019='1' THEN #卡种
   #   INITIALIZE g_ref_fields TO NULL
   #   LET g_ref_fields[1] = g_mmby_m.mmby005
   #   CALL ap_ref_array2(g_ref_fields,"SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   #   LET g_mmby_m.mmby005_desc = '', g_rtn_fields[1] , ''
   #   DISPLAY BY NAME g_mmby_m.mmby005_desc
   #END IF
   #IF g_mmby_m.mmby019='1' THEN #会员等级
   #   INITIALIZE g_ref_fields TO NULL
   #   LET g_ref_fields[1] = g_mmby_m.mmby005
   #   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2024' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   #   LET g_mmby_m.mmby005_desc = '', g_rtn_fields[1] , ''
   #   DISPLAY BY NAME g_mmby_m.mmby005_desc
   #END IF
   #160729-00077#6 20160817 mark by beckxie---E
   #160729-00077#6 20160817 add by beckxie---S
   CALL ammm358_mmby005_ref()
   #160729-00077#6 20160817 add by beckxie---E
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmby_m.mmby001
   LET g_ref_fields[2] = g_mmby_m.mmby002
   CALL ap_ref_array2(g_ref_fields," SELECT mmbyl004,mmbyl005 FROM mmbyl_t WHERE mmbylent = '"||g_enterprise||"' AND mmbyl001 = ? AND mmbyl002 = ? AND mmbyl003 = '"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmby_m.mmbyl004 = g_rtn_fields[1]
   LET g_mmby_m.mmbyl005 = g_rtn_fields[2]
   DISPLAY g_mmby_m.mmbyl004 TO mmbyl004
   DISPLAY g_mmby_m.mmbyl005 TO mmbyl005
   
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmby_m.mmbysite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmby_m.mmbysite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmby_m.mmbysite_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmby_m.mmbyunit
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmby_m.mmbyunit_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmby_m.mmbyunit_desc
            
            #160729-00077#6 20160817 mark by beckxie---S
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_mmby_m.mmby005
            #CALL ap_ref_array2(g_ref_fields,"SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_mmby_m.mmby005_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_mmby_m.mmby005_desc
            #160729-00077#6 20160817 mark by beckxie---E

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmby_m.mmbyownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_mmby_m.mmbyownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmby_m.mmbyownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmby_m.mmbyowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmby_m.mmbyowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmby_m.mmbyowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmby_m.mmbycrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_mmby_m.mmbycrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmby_m.mmbycrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmby_m.mmbycrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmby_m.mmbycrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmby_m.mmbycrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmby_m.mmbymodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_mmby_m.mmbymodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmby_m.mmbymodid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmby_m.mmbycnfid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_mmby_m.mmbycnfid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmby_m.mmbycnfid_desc
          {#ADP版次:1#}
   #end add-point

   #將資料輸出到畫面上
   DISPLAY BY NAME g_mmby_m.mmbysite,g_mmby_m.mmbysite_desc,g_mmby_m.mmbyunit,g_mmby_m.mmbyunit_desc,g_mmby_m.mmby004,g_mmby_m.mmby001,g_mmby_m.mmby002,g_mmby_m.mmbyl004,g_mmby_m.mmbyl005,g_mmby_m.mmby005,g_mmby_m.mmby005_desc,g_mmby_m.mmby006,g_mmby_m.mmby007,g_mmby_m.mmby008,g_mmby_m.mmby014,g_mmby_m.mmby015,g_mmby_m.mmby016,g_mmby_m.mmby017,g_mmby_m.mmbystus,g_mmby_m.mmbyownid,g_mmby_m.mmbyownid_desc,g_mmby_m.mmbyowndp,g_mmby_m.mmbyowndp_desc,g_mmby_m.mmbycrtid,g_mmby_m.mmbycrtid_desc,g_mmby_m.mmbycrtdp,g_mmby_m.mmbycrtdp_desc,g_mmby_m.mmbycrtdt,g_mmby_m.mmbymodid,g_mmby_m.mmbymodid_desc,g_mmby_m.mmbymoddt,g_mmby_m.mmbycnfid,g_mmby_m.mmbycnfid_desc,g_mmby_m.mmbycnfdt
   DISPLAY BY NAME g_mmby_m.mmby019
   #顯示狀態(stus)圖片
         #此段落由子樣板a21產生
      CASE g_mmby_m.mmbystus
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")

         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")


		
      END CASE



   #add-point:show段之後
   {<point name="show.after"/>}
   FOR l_ac = 1 TO g_mmbp_d.getLength()
      #CALL ammm358_mmbp004_ref()     
      CALL s_aint800_01_show(g_mmby_m.mmby007,g_mmbp_d[l_ac].mmbp004,'',g_mmby_m.mmbysite,'')  RETURNING l_flag,g_mmbp_d[l_ac].mmbp004_desc    
   END FOR

   FOR l_ac = 1 TO g_mmbp2_d.getLength()
      CALL ammm358_mmbs004_ref()
   END FOR

   FOR l_ac = 1 TO g_mmbp3_d.getLength()
      CALL ammm358_mmbr004_ref()
   END FOR
   #160613-00031#3 160615 by sakura add(S)
   FOR l_ac = 1 TO g_mmbp4_d.getLength()
   
   END FOR   
   #160613-00031#3 160615 by sakura add(E)   
   #end add-point

END FUNCTION

PRIVATE FUNCTION ammm358_delete()
   {<Local define>}
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:delete段define
   {<point name="delete.define"/>}
   #end add-point

   IF g_mmby_m.mmbysite IS NULL
   OR g_mmby_m.mmby001 IS NULL

   OR g_mmby_m.mmby002 IS NULL


   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

   CALL s_transaction_begin()

   LET g_mmbysite_t = g_mmby_m.mmbysite
   LET g_mmby001_t = g_mmby_m.mmby001

   LET g_mmby002_t = g_mmby_m.mmby002



   LET g_master_multi_table_t.mmbyl001 = g_mmby_m.mmby001
LET g_master_multi_table_t.mmbyl002 = g_mmby_m.mmby002
LET g_master_multi_table_t.mmbyl004 = g_mmby_m.mmbyl004
LET g_master_multi_table_t.mmbyl005 = g_mmby_m.mmbyl005


   OPEN ammm358_cl USING g_enterprise,
                           g_mmby_m.mmbysite
                           ,g_mmby_m.mmby001

                           ,g_mmby_m.mmby002


   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN ammm358_cl:"
      LET g_errparam.popup = FALSE
      CALL cl_err()

      CLOSE ammm358_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   FETCH ammm358_cl INTO g_mmby_m.mmbysite,g_mmby_m.mmbysite_desc,g_mmby_m.mmbyunit,g_mmby_m.mmbyunit_desc,g_mmby_m.mmby004,g_mmby_m.mmby001,g_mmby_m.mmby002,g_mmby_m.mmbyl004,g_mmby_m.mmbyl005,g_mmby_m.mmby005,g_mmby_m.mmby005_desc,g_mmby_m.mmby006,g_mmby_m.mmby007,g_mmby_m.mmby008,g_mmby_m.mmby014,g_mmby_m.mmby015,g_mmby_m.mmby016,g_mmby_m.mmby017,g_mmby_m.mmbystus,g_mmby_m.mmbyownid,g_mmby_m.mmbyownid_desc,g_mmby_m.mmbyowndp,g_mmby_m.mmbyowndp_desc,g_mmby_m.mmbycrtid,g_mmby_m.mmbycrtid_desc,g_mmby_m.mmbycrtdp,g_mmby_m.mmbycrtdp_desc,g_mmby_m.mmbycrtdt,g_mmby_m.mmbymodid,g_mmby_m.mmbymodid_desc,g_mmby_m.mmbymoddt,g_mmby_m.mmbycnfid,g_mmby_m.mmbycnfid_desc,g_mmby_m.mmbycnfdt
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_mmby_m.mmbysite
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

   CALL ammm358_show()
   IF cl_ask_delete() THEN
      INITIALIZE g_doc.* TO NULL
      LET g_doc.column1 = "mmbysite"
      LET g_doc.value1 = g_mmby_m.mmbysite
      CALL cl_doc_remove()

      #add-point:單頭刪除前
      {<point name="delete.head.b_delete" mark="Y"/>}
      #end add-point

      DELETE FROM mmby_t
       WHERE mmbyent = g_enterprise AND mmbysite = g_mmby_m.mmbysite
         AND mmby001 = g_mmby_m.mmby001

         AND mmby002 = g_mmby_m.mmby002



      #add-point:單頭刪除中
      {<point name="delete.head.m_delete"/>}
      #end add-point

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "mmby_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
      END IF



      #add-point:單頭刪除後
      {<point name="delete.head.a_delete"/>}
      #end add-point



      CLEAR FORM
      CALL ammm358_ui_browser_refresh()
      IF g_browser_cnt > 0 THEN
         CALL ammm358_fetch("P")
      ELSE
         CALL ammm358_browser_fill(" 1=1 ","F")
      END IF

   END IF

   CLOSE ammm358_cl
   CALL s_transaction_end('Y','0')

   #流程通知預埋點-D
   CALL cl_flow_notify(g_mmby_m.mmbysite,"D")

END FUNCTION


PRIVATE FUNCTION ammm358_ui_browser_refresh()
   {<Local define>}
   DEFINE l_i  LIKE type_t.num10
   {</Local define>}

   #add-point:ui_browser_refresh段define
   {<point name="ui_browser_refresh.define"/>}
   #end add-point

   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_mmbysite = g_mmby_m.mmbysite THEN
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

PRIVATE FUNCTION ammm358_set_entry(p_cmd)

   {<Local define>}
   DEFINE p_cmd LIKE type_t.chr1
   {</Local define>}

   #add-point:set_entry段define
   {<point name="set_entry.define"/>}
   #end add-point

   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("mmbysite,mmby001,mmby002",TRUE)
      #add-point:set_entry段欄位控制
      {<point name="set_entry.field_control"/>}
      #end add-point
   END IF

   #add-point:set_entry段欄位控制後
   {<point name="set_entry.after_control"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION ammm358_set_no_entry(p_cmd)

   {<Local define>}
   DEFINE p_cmd LIKE type_t.chr1
   {</Local define>}

   #add-point:set_no_entry段define
   {<point name="set_no_entry.define"/>}
   #end add-point

   IF p_cmd = "u" THEN
      CALL cl_set_comp_entry("mmbysite,mmby001,mmby002",FALSE)
      #add-point:set_no_entry段欄位控制
      {<point name="set_no_entry.field_control"/>}
      #end add-point
   END IF

   #add-point:set_no_entry段欄位控制後
   {<point name="set_no_entry.after_control"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION ammm358_default_search()
   {<Local define>}
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   {</Local define>}
   #add-point:default_search段define
   {<point name="default_search.define"/>}
   #end add-point

   #add-point:default_search段開始前
   {<point name="default_search.before"/>}
   #end add-point

   LET g_pagestart = 1
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " mmbysite = '", g_argv[1], "' AND "
   END IF

   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " mmby001 = '", g_argv[02], "' AND "
   END IF

   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " mmby002 = '", g_argv[03], "' AND "
   END IF



   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
   ELSE
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF

   #add-point:default_search段結束前
   {<point name="default_search.after"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION ammm358_statechange()
   {<Local define>}
   DEFINE lc_state LIKE type_t.chr5
   {</Local define>}
   #add-point:statechange段define
   {<point name="statechange.define"/>}
   #end add-point

   #add-point:statechange段開始前
   {<point name="statechange.before"/>}
   #end add-point

   ERROR ""     #清空畫面右下側ERROR區塊

   IF g_mmby_m.mmbysite IS NULL
      #key2
      OR g_mmby_m.mmby001 IS NULL
      #key3
      OR g_mmby_m.mmby002 IS NULL

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
         CASE g_mmby_m.mmbystus
            WHEN "N"
               HIDE OPTION "open"
            WHEN "X"
               HIDE OPTION "void"

            WHEN "Y"
               HIDE OPTION "valid"


			
         END CASE

      #add-point:menu前
      {<point name="statechange.before_menu"/>}
       CASE g_mmby_m.mmbystus
            WHEN "X"
               HIDE OPTION "open"
               HIDE OPTION "valid"
               RETURN 
               
            WHEN "Y"
               HIDE OPTION "open"	
               HIDE OPTION "void"
               RETURN               
         END CASE
      
      #end add-point
	
      ON ACTION open
         LET lc_state = "N"
         #add-point:action控制
         {<point name="statechange.open"/>}
         #end add-point
         EXIT MENU
      ON ACTION void
         LET lc_state = "X"
         #add-point:action控制
         {<point name="statechange.void"/>}
         #end add-point
         EXIT MENU

      ON ACTION valid
         LET lc_state = "Y"
         #add-point:action控制
         {<point name="statechange.valid"/>}
         #end add-point
         EXIT MENU


	
	
	
      #add-point:stus控制
      {<point name="statechange.more_control"/>}
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
   {<point name="statechange.b_update"/>}
   #end add-point

   UPDATE mmby_t SET mmbystus = lc_state
    WHERE mmbyent = g_enterprise AND mmbysite = g_mmby_m.mmbysite
      #key2
      AND mmby001 = g_mmby_m.mmby001
      #key3
      AND mmby002 = g_mmby_m.mmby002


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
      LET g_mmby_m.mmbystus = lc_state
      DISPLAY BY NAME g_mmby_m.mmbystus
   END IF

   #add-point:stus修改後
   {<point name="statechange.a_update"/>}
   #end add-point

   #add-point:statechange段結束前
   {<point name="statechange.after"/>}
   #end add-point

END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammm358_idx_chk()
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_mmbp_d.getLength() THEN
         LET g_detail_idx = g_mmbp_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mmbp_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mmbp_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_mmbp2_d.getLength() THEN
         LET g_detail_idx = g_mmbp2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mmbp2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mmbp2_d.getLength() TO FORMONLY.cnt
   END IF

   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_mmbp3_d.getLength() THEN
         LET g_detail_idx = g_mmbp3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mmbp3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mmbp3_d.getLength() TO FORMONLY.cnt
   END IF
   #160613-00031#3 160615 by sakura add(S)
   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_mmbp4_d.getLength() THEN
         LET g_detail_idx = g_mmbp4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mmbp4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mmbp4_d.getLength() TO FORMONLY.cnt
   END IF   
   #160613-00031#3 160615 by sakura add(E)   
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammm358_show_desc(p_ac)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammm358_show_desc(p_ac)
DEFINE p_ac   LIKE type_t.num10

   IF cl_null(p_ac) OR p_ac <= 0 THEN LET p_ac = 1 END IF
   
   LET g_mmby_m.mmbr004_1      = g_mmbp3_d[p_ac].mmbr004
   LET g_mmby_m.mmbr004_1_desc = g_mmbp3_d[p_ac].mmbr004_desc
   LET g_mmby_m.mmbr014_1      = g_mmbp3_d[p_ac].mmbr014
   LET g_mmby_m.mmbr015_1      = g_mmbp3_d[p_ac].mmbr015
   LET g_mmby_m.mmbr016_1      = g_mmbp3_d[p_ac].mmbr016
   LET g_mmby_m.mmbr017_1      = g_mmbp3_d[p_ac].mmbr017
   LET g_mmby_m.mmbr018_1      = g_mmbp3_d[p_ac].mmbr018
   LET g_mmby_m.mmbr019_1      = g_mmbp3_d[p_ac].mmbr019
   
   DISPLAY BY NAME g_mmby_m.mmbr004_1,g_mmby_m.mmbr004_1_desc,g_mmby_m.mmbr014_1,g_mmby_m.mmbr015_1,
                   g_mmby_m.mmbr016_1,g_mmby_m.mmbr017_1,g_mmby_m.mmbr018_1,g_mmby_m.mmbr019_1
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammm358_mmbp004_ref()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammm358_mmbp004_ref()
    CASE g_mmby_m.mmby007
       WHEN  '1' #會員等級
          SELECT oocql004 INTO  g_mmbp_d[l_ac].mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2024' AND oocql002 =g_mmbp_d[l_ac].mmbp004 AND oocql003 = g_dlang
           
        
       WHEN  '2' #會員類型
          SELECT oocql004 INTO  g_mmbp_d[l_ac].mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2025' AND oocql002 = g_mmbp_d[l_ac].mmbp004 AND oocql003 = g_dlang
       
       WHEN  '3' #款別類型
          SELECT ooial003 INTO  g_mmbp_d[l_ac].mmbp004_desc FROM ooial_t
           WHERE ooialent = g_enterprise AND ooial001 =  g_mmbp_d[l_ac].mmbp004 AND ooial002 = g_dlang
       
       WHEN '4' #商品編號
          SELECT imaal003 INTO  g_mmbp_d[l_ac].mmbp004_desc FROM imaal_t
           WHERE imaalent = g_enterprise AND imaal001 = g_mmbp_d[l_ac].mmbp004 AND imaal002 = g_dlang
           
       WHEN '5' #商品分類
           SELECT rtaxl003 INTO  g_mmbp_d[l_ac].mmbp004_desc FROM rtaxl_t
            WHERE rtaxlent = g_enterprise AND rtaxl001 = g_mmbp_d[l_ac].mmbp004 AND rtaxl002 = g_dlang 

       WHEN '6' #商品屬性-產地分類
           SELECT oocql004 INTO  g_mmbp_d[l_ac].mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2000' AND oocql002 = g_mmbp_d[l_ac].mmbp004 AND oocql003 = g_dlang
           
       WHEN '7' #商品屬性-價格帶
          SELECT oocql004 INTO  g_mmbp_d[l_ac].mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2001' AND oocql002 = g_mmbp_d[l_ac].mmbp004 AND oocql003 = g_dlang
           
       WHEN '8' #商品屬性-品牌
          SELECT oocql004 INTO  g_mmbp_d[l_ac].mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2002' AND oocql002 = g_mmbp_d[l_ac].mmbp004 AND oocql003 = g_dlang  

       WHEN '9' #商品屬性-系列
           SELECT oocql004 INTO  g_mmbp_d[l_ac].mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2003' AND oocql002 = g_mmbp_d[l_ac].mmbp004 AND oocql003 = g_dlang   

       WHEN 'A' #商品屬性-型別
          SELECT oocql004 INTO  g_mmbp_d[l_ac].mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2004' AND oocql002 = g_mmbp_d[l_ac].mmbp004 AND oocql003 = g_dlang 

       WHEN 'B' #商品屬性-功能
          SELECT oocql004 INTO  g_mmbp_d[l_ac].mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2005' AND oocql002 = g_mmbp_d[l_ac].mmbp004 AND oocql003 = g_dlang 
       
       WHEN 'C' #商品屬性-其它屬性一
         SELECT oocql004 INTO  g_mmbp_d[l_ac].mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2006' AND oocql002 = g_mmbp_d[l_ac].mmbp004 AND oocql003 = g_dlang  

       WHEN 'D' #商品屬性-其它屬性二
          SELECT oocql004 INTO  g_mmbp_d[l_ac].mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2007' AND oocql002 = g_mmbp_d[l_ac].mmbp004 AND oocql003 = g_dlang  
   
       WHEN 'E' #商品屬性-其它屬性三
          SELECT oocql004 INTO  g_mmbp_d[l_ac].mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2008' AND oocql002 = g_mmbp_d[l_ac].mmbp004 AND oocql003 = g_dlang  
       WHEN 'F' #商品屬性-其它屬性四
          SELECT oocql004 INTO  g_mmbp_d[l_ac].mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2009' AND oocql002 = g_mmbp_d[l_ac].mmbp004 AND oocql003 = g_dlang  
       WHEN 'G' #商品屬性-其它屬性五
          SELECT oocql004 INTO  g_mmbp_d[l_ac].mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2010' AND oocql002 = g_mmbp_d[l_ac].mmbp004 AND oocql003 = g_dlang  
        
       WHEN 'H' #商品屬性-其它屬性六
          SELECT oocql004 INTO  g_mmbp_d[l_ac].mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2011' AND oocql002 = g_mmbp_d[l_ac].mmbp004 AND oocql003 = g_dlang  
           
       WHEN 'I' #商品屬性-其它屬性七
          SELECT oocql004 INTO  g_mmbp_d[l_ac].mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2012' AND oocql002 = g_mmbp_d[l_ac].mmbp004 AND oocql003 = g_dlang   
       WHEN 'J' #商品屬性-其它屬性八
           SELECT oocql004 INTO  g_mmbp_d[l_ac].mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2013' AND oocql002 = g_mmbp_d[l_ac].mmbp004 AND oocql003 = g_dlang           
      
       WHEN 'K' #商品屬性-其它屬性九
           SELECT oocql004 INTO  g_mmbp_d[l_ac].mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2014' AND oocql002 = g_mmbp_d[l_ac].mmbp004 AND oocql003 = g_dlang   

       WHEN 'L' #商品屬性-其它屬性十
          SELECT oocql004 INTO  g_mmbp_d[l_ac].mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2014' AND oocql002 = g_mmbp_d[l_ac].mmbp004 AND oocql003 = g_dlang 
           
       WHEN 'U'
         #庫區類別
           SELECT gzcbl004 INTO  g_mmbp_d[l_ac].mmbp004_desc FROM gzcbl_t 
            WHERE gzcbl001 = '6200' AND gzcbl002 = g_mmbp_d[l_ac].mmbp004 AND gzcbl003 =  g_dlang 
       WHEN 'V' 
         #庫區品類 
           SELECT rtaxl003 INTO  g_mmbp_d[l_ac].mmbp004_desc FROM rtaxl_t
            WHERE rtaxlent = g_enterprise AND rtaxl001 = g_mmbp_d[l_ac].mmbp004 AND rtaxl002 = g_dlang 
    END CASE 


   DISPLAY BY NAME g_mmbp_d[l_ac].mmbp004_desc
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammm358_mmbr004_ref()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammm358_mmbr004_ref()
DEFINE r_success       LIKE type_t.num5

   CALL s_aint800_01_show(g_mmbp3_d[l_ac].mmbr003,g_mmbp3_d[l_ac].mmbr004,'',g_mmby_m.mmbysite,'') RETURNING r_success,g_mmbp3_d[l_ac].mmbr004_desc

   DISPLAY BY NAME g_mmbp3_d[l_ac].mmbr004_desc
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammm358_mmbs004_ref()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammm358_mmbs004_ref()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmbp2_d[l_ac].mmbs004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmbp2_d[l_ac].mmbs004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mmbp2_d[l_ac].mmbs004_desc
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammm358_b_fill()
 DEFINE p_wc2      STRING
 DEFINE l_flag     LIKE type_t.num5
 
   CALL g_mmbp_d.clear()
   CALL g_mmbp2_d.clear()
   CALL g_mmbp3_d.clear()
   
   LET g_sql = "SELECT UNIQUE mmbp004,'',mmbp005,mmbp006,mmbp007,mmbp008,mmbp009,mmbp010,mmbpacti ",
               "  FROM mmbp_t,mmbo_t,mmby_t ",
               " WHERE mmbyent = mmboent AND mmby001 = mmbo001 AND mmby002 = mmbo002 ",
               "   AND mmboent = mmbpent AND mmbodocno = mmbpdocno ",
               "   AND mmbyent = '",g_enterprise,"' AND mmby001 = '",g_mmby_m.mmby001,"' AND mmby002 = '",g_mmby_m.mmby002,"' "
      
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
   END IF 
   
   LET g_sql = g_sql, " ORDER BY mmbp004"
   
   PREPARE ammm358_pb FROM g_sql
   DECLARE b_fill_cs CURSOR FOR ammm358_pb
   LET g_cnt = l_ac
   LET l_ac = 1
    
   FOREACH b_fill_cs INTO g_mmbp_d[l_ac].mmbp004,g_mmbp_d[l_ac].mmbp004_desc,g_mmbp_d[l_ac].mmbp005,g_mmbp_d[l_ac].mmbp006,
                          g_mmbp_d[l_ac].mmbp007,g_mmbp_d[l_ac].mmbp008,g_mmbp_d[l_ac].mmbp009,g_mmbp_d[l_ac].mmbp010,g_mmbp_d[l_ac].mmbpacti
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      CALL s_aint800_01_show(g_mmby_m.mmby007,g_mmbp_d[l_ac].mmbp004,'',g_mmby_m.mmbysite,'')  RETURNING l_flag,g_mmbp_d[l_ac].mmbp004_desc
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec AND g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH
   
   LET g_sql = "SELECT UNIQUE mmbs004,'',mmbs005,mmbsacti ",
               "  FROM mmbs_t,mmby_t,mmbo_t ",
               " WHERE mmbyent = mmboent AND mmby001 = mmbo001 AND mmby002 = mmbo002 ",
               "   AND mmboent = mmbsent AND mmbodocno = mmbsdocno " ,
               "   AND mmbyent = '",g_enterprise,"' AND mmby001 = '",g_mmby_m.mmby001,"' AND mmby002 = '",g_mmby_m.mmby002,"' "
   
   IF NOT cl_null(g_wc2_table2) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
   END IF
   
   LET g_sql = g_sql, " ORDER BY mmbs004"
   
   PREPARE ammm358_pb2 FROM g_sql
   DECLARE b_fill_cs2 CURSOR FOR ammm358_pb2
   LET l_ac = 1
   
   FOREACH b_fill_cs2 INTO g_mmbp2_d[l_ac].mmbs004,g_mmbp2_d[l_ac].mmbs004_desc,g_mmbp2_d[l_ac].mmbs005,g_mmbp2_d[l_ac].mmbsacti
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   
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

   LET g_sql = "SELECT UNIQUE mmbr003,mmbr004,'',mmbr005,mmbr006,mmbr007,mmbr008,mmbr009,mmbr010,mmbr011,mmbr012,mmbr013,mmbr014,mmbr015,mmbr016,mmbr017,mmbr018,mmbr019,mmbracti ",
               "  FROM mmbr_t,mmby_t,mmbo_t ",
               " WHERE mmbyent = mmboent AND mmby001 = mmbo001 AND mmby002 = mmbo002 ",
               "   AND mmboent = mmbrent AND mmbodocno = mmbrdocno ",
               "   AND mmbyent = '",g_enterprise,"' AND mmby001 = '",g_mmby_m.mmby001,"' AND mmby002 = '",g_mmby_m.mmby002,"' "
   
   IF NOT cl_null(g_wc2_table3) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
   END IF
   
   LET g_sql = g_sql, " ORDER BY mmbr003,mmbr004"
   
   PREPARE ammm358_pb3 FROM g_sql
   DECLARE b_fill_cs3 CURSOR FOR ammm358_pb3
   LET l_ac = 1
   
   FOREACH b_fill_cs3 INTO g_mmbp3_d[l_ac].mmbr003,g_mmbp3_d[l_ac].mmbr004,g_mmbp3_d[l_ac].mmbr004_desc,g_mmbp3_d[l_ac].mmbr005,g_mmbp3_d[l_ac].mmbr006,g_mmbp3_d[l_ac].mmbr007,g_mmbp3_d[l_ac].mmbr008,g_mmbp3_d[l_ac].mmbr009,g_mmbp3_d[l_ac].mmbr010,g_mmbp3_d[l_ac].mmbr011,g_mmbp3_d[l_ac].mmbr012,g_mmbp3_d[l_ac].mmbr013,g_mmbp3_d[l_ac].mmbr014,g_mmbp3_d[l_ac].mmbr015,g_mmbp3_d[l_ac].mmbr016,g_mmbp3_d[l_ac].mmbr017,g_mmbp3_d[l_ac].mmbr018,g_mmbp3_d[l_ac].mmbr019,g_mmbp3_d[l_ac].mmbracti
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   
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

   CALL g_mmbp_d.deleteElement(g_mmbp_d.getLength())
   CALL g_mmbp2_d.deleteElement(g_mmbp2_d.getLength())
   CALL g_mmbp3_d.deleteElement(g_mmbp3_d.getLength())
   
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE ammm358_pb
   FREE ammm358_pb2
   FREE ammm358_pb3
   
   CALL ammm358_b_fill2() #單身填充   #160613-00031#3 160615 by sakura add
   
END FUNCTION

################################################################################
# Descriptions...: 新增高級時間設置頁面
# Memo...........:
# Usage..........: CALL ammm358_b_fill2 ()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/06/16 By sakura  #160613-00031#3
# Modify.........: 
################################################################################
PRIVATE FUNCTION ammm358_b_fill2()
   DEFINE li_ac                  LIKE type_t.num10
   DEFINE li_detail_idx_tmp      LIKE type_t.num10
   DEFINE ls_chk                 LIKE type_t.chr1

   LET li_ac = l_ac 
   
   IF g_detail_idx <= 0 THEN
      RETURN
   END IF
   
   LET li_detail_idx_tmp = g_detail_idx

   CALL g_mmbp4_d.clear()
   
   LET g_sql = "SELECT UNIQUE mmdj005,mmdj006,mmdj007,mmdj008,mmdj009, ",
               "       mmdj010,mmdj011,mmdjacti ",
               "  FROM mmdj_t,mmbr_t,mmby_t,mmbo_t ",
               " WHERE mmbyent = mmboent AND mmby001 = mmbo001 AND mmby002 = mmbo002 ",
               "   AND mmboent = mmbrent AND mmbodocno = mmbrdocno ",
               "   AND mmbrent = mmdjent AND mmbrdocno = mmdjdocno AND mmbr003 = mmdj003 AND mmbr004 = mmdj004 ",
               "   AND mmbyent = '",g_enterprise,"' AND mmby001 = '",g_mmby_m.mmby001,"' AND mmby002 = '",g_mmby_m.mmby002,"' ",          
               "   AND mmdj003 = '",g_mmbp3_d[g_detail_idx].mmbr003,"' AND mmdj004 = '",g_mmbp3_d[g_detail_idx].mmbr004,"' "
   
   IF NOT cl_null(g_wc2_table4) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
   END IF
   
   LET g_sql = g_sql, " ORDER BY mmdj005"
   
   PREPARE ammm358_pb4 FROM g_sql
   DECLARE b_fill_cs4 CURSOR FOR ammm358_pb4
   LET l_ac = 1
   
   FOREACH b_fill_cs4 INTO g_mmbp4_d[l_ac].mmdj005,g_mmbp4_d[l_ac].mmdj006,g_mmbp4_d[l_ac].mmdj007,g_mmbp4_d[l_ac].mmdj008,g_mmbp4_d[l_ac].mmdj009,g_mmbp4_d[l_ac].mmdj010,g_mmbp4_d[l_ac].mmdj011,g_mmbp4_d[l_ac].mmdjacti
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH
   
   
   CALL g_mmbp4_d.deleteElement(g_mmbp4_d.getLength())   
   FREE ammm358_pb4                                      
   LET l_ac = li_ac
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION ammm358_mmby005_ref()
   #160729-00077#6 20160817 add by beckxie---S
   LET g_mmby_m.mmby005_desc = ''   
   
   IF g_mmby_m.mmby019='1' THEN  #卡种
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_mmby_m.mmby005
      CALL ap_ref_array2(g_ref_fields,"SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_mmby_m.mmby005_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_mmby_m.mmby005_desc
   END IF
   IF g_mmby_m.mmby019='2' THEN  #会员等级
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_mmby_m.mmby005
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2024' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_mmby_m.mmby005_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_mmby_m.mmby005_desc
   END IF
   IF g_mmby_m.mmby019='11' THEN  #其他類型一
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_mmby_m.mmby005
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2026' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_mmby_m.mmby005_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_mmby_m.mmby005_desc
   END IF
   IF g_mmby_m.mmby019='12' THEN  #其他類型二
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_mmby_m.mmby005
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2027' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_mmby_m.mmby005_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_mmby_m.mmby005_desc
   END IF
   IF g_mmby_m.mmby019='13' THEN  #其他類型三
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_mmby_m.mmby005
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2028' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_mmby_m.mmby005_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_mmby_m.mmby005_desc
   END IF
   IF g_mmby_m.mmby019='14' THEN  #其他類型四
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_mmby_m.mmby005
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2029' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_mmby_m.mmby005_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_mmby_m.mmby005_desc
   END IF
   IF g_mmby_m.mmby019='15' THEN  #其他類型五
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_mmby_m.mmby005
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2030' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_mmby_m.mmby005_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_mmby_m.mmby005_desc
   END IF
   #160729-00077#6 20160817 add by beckxie---E
END FUNCTION

#end add-point
 
{</section>}
 
