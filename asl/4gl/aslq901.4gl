#該程式未解開Section, 採用最新樣板產出!
{<section id="aslq901.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-12-15 22:17:29), PR版次:0001(2016-12-20 13:32:55)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: aslq901
#+ Description: 庫存明細查詢
#+ Creator....: 01516(2016-10-30 14:24:00)
#+ Modifier...: 06189 -SD/PR- 06189
 
{</section>}
 
{<section id="aslq901.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160512-00004#2   2016/06/15  By  dorislai  新增製造日期的欄位(inad014)
#161030-00006#2   2016/12/07  by  geza      库存数量取inag009
#161214-00002#1   2016/12/14  by  geza      库存可用数量取inax
#161214-00002#1   2016/12/15  by  geza      大类修改，增加中类
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
DEFINE g_wc      STRING   #存放inag_t相關欄位的construct欄位
DEFINE g_wc_t    STRING   #存放inag_t相關欄位的construct欄位
DEFINE g_wc2     STRING   #存放imaa_t相關欄位的construct欄位
DEFINE g_wc2_t   STRING   #存放imaa_t相關欄位的construct欄位
DEFINE g_wc3     STRING   #存放inad_t相關欄位的construct欄位
DEFINE g_wc3_t   STRING   #存放inad_t相關欄位的construct欄位
DEFINE tm        RECORD   #存放條件選項
         l_inag012  LIKE type_t.chr10,
         l_inag010  LIKE type_t.chr10,
         l_qty_flag LIKE type_t.chr1
                 END RECORD
DEFINE tm2        RECORD  #存放單頭顯示內容的flag 
         inagsite   LIKE type_t.chr1,
         inag001    LIKE type_t.chr1,
         imaa126    LIKE type_t.chr1,
         inag002    LIKE type_t.chr1,
         inad010    LIKE type_t.chr1,
         inag004    LIKE type_t.chr1,
         inag005    LIKE type_t.chr1,
         inag006    LIKE type_t.chr1,
         imaa009    LIKE type_t.chr1,
         inag003    LIKE type_t.chr1,
         inag007    LIKE type_t.chr1,
         inad014    LIKE type_t.chr1,  #160512-00004#2-add
         #No:161202-------------------begin   #add by stcshy 161202
         imaa154    LIKE type_t.chr1,
         imaa133    LIKE type_t.chr1,
         imaa156    LIKE type_t.chr1,
         imaa132    LIKE type_t.chr1,
         imaa128    LIKE type_t.chr1,
         rtax001    LIKE type_t.chr1, #add by geza 20161215 161214-00002#1
         #No:161202---------------------end
         inad011    LIKE type_t.chr1
                 END RECORD
TYPE type_g_inag_d RECORD
       sel                LIKE type_t.chr1,
       inagsite           LIKE inag_t.inagsite,
       inagsite_desc      LIKE type_t.chr500,
       inag001            LIKE inag_t.inag001,
       inag001_desc       LIKE type_t.chr500,    
       inag001_desc_desc  LIKE type_t.chr500,
       imaa126            LIKE imaa_t.imaa126,
       imaa126_desc       LIKE type_t.chr500,   
       inag002            LIKE inag_t.inag002,
       inag002_desc       LIKE type_t.chr500,
       inad010            LIKE inad_t.inad010,
       inad010_desc       LIKE type_t.chr500,
       inag004            LIKE inag_t.inag004,
       inag004_desc       LIKE type_t.chr500,
       inaa102            LIKE inaa_t.inaa102,
       imaa154            LIKE imaa_t.imaa154,
       imaa133            LIKE imaa_t.imaa133,
       imaa133_desc       LIKE type_t.chr500,
       imaa156            LIKE imaa_t.imaa156,
       imaa132            LIKE imaa_t.imaa132,
       imaa132_desc       LIKE type_t.chr500,
       imaa128            LIKE imaa_t.imaa128,
       imaa128_desc       LIKE type_t.chr500,
       rtax001            LIKE rtax_t.rtax001, #add by geza 20161215 161214-00002#1
       rtax001_desc       LIKE type_t.chr500, #add by geza 20161215 161214-00002#1
       imaa009            LIKE imaa_t.imaa009,
       imaa009_desc       LIKE type_t.chr500,
       imaa157            LIKE imaa_t.imaa157,
       inaa120            LIKE inaa_t.inaa120,
       inaa120_desc       LIKE type_t.chr500,
       inag005            LIKE inag_t.inag005,
       inag005_desc       LIKE type_t.chr500,
       inag006            LIKE inag_t.inag006,
       inag003            LIKE inag_t.inag003,
       inag007            LIKE inag_t.inag007,
       inag007_desc       LIKE type_t.chr500,
       inad014            LIKE inad_t.inad014,  #160512-00004#2
       inad011            LIKE inad_t.inad011,
       inag008            LIKE inag_t.inag008,  #160604-00009#134 160706 by sakura add
       inag009            LIKE inag_t.inag009
                  END RECORD
TYPE type_g_inag2_d RECORD
       inagsite           LIKE inag_t.inagsite,
       inagsite_desc      LIKE type_t.chr500,
       inag001            LIKE inag_t.inag001,
       inag001_desc       LIKE type_t.chr500,
       inag001_desc_desc  LIKE type_t.chr500,
       imaa126            LIKE imaa_t.imaa126,
       imaa126_desc       LIKE type_t.chr500,   
       inag002            LIKE inag_t.inag002,
       inag002_desc       LIKE type_t.chr500,
       inad010            LIKE inad_t.inad010,
       inad010_desc       LIKE type_t.chr500,
       inag004            LIKE inag_t.inag004,
       inag004_desc       LIKE type_t.chr500,
       inaa102            LIKE inaa_t.inaa102,
       imaa154            LIKE imaa_t.imaa154,
       imaa133            LIKE imaa_t.imaa133,
       imaa133_desc       LIKE type_t.chr500,
       imaa156            LIKE imaa_t.imaa156,
       imaa132            LIKE imaa_t.imaa132,
       imaa132_desc       LIKE type_t.chr500,
       imaa128            LIKE imaa_t.imaa128,
       imaa128_desc       LIKE type_t.chr500,
       rtax001            LIKE rtax_t.rtax001, #add by geza 20161215 161214-00002#1
       rtax001_desc       LIKE type_t.chr500, #add by geza 20161215 161214-00002#1
       imaa009            LIKE imaa_t.imaa009,
       imaa009_desc       LIKE type_t.chr500,
       imaa157            like imaa_t.imaa157,
       inaa120            LIKE inaa_t.inaa120,
       inaa120_desc       LIKE type_t.chr500,
       inag005            LIKE inag_t.inag005,
       inag005_desc       LIKE type_t.chr500,
       inag006            LIKE inag_t.inag006,
       inag003            LIKE inag_t.inag003,
       inag007            LIKE inag_t.inag007,
       inag007_desc       LIKE type_t.chr500,
       inad014            LIKE inad_t.inad014,  #160512-00004#2
       inad011            LIKE inad_t.inad011,
       inag008            LIKE inag_t.inag008,
       inag009            LIKE inag_t.inag009,
       inag016            LIKE inag_t.inag016,
       inag015            LIKE inag_t.inag015,
       inag014            LIKE inag_t.inag014,
       inag012            LIKE inag_t.inag012,
       inag010            LIKE inag_t.inag010,
       inad012            LIKE inad_t.inad012
                  END RECORD
DEFINE g_inag_d   DYNAMIC ARRAY OF type_g_inag_d
DEFINE g_inag2_d   DYNAMIC ARRAY OF type_g_inag2_d
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_sql1                STRING
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL    
DEFINE g_cnt                 LIKE type_t.num10
DEFINE l_ac                  LIKE type_t.num10             #目前處理的ARRAY CNT  #161117-00022#1 161118 by lori mod:num5 to num10
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_current_page        LIKE type_t.num10             #目前所在頁數 #161117-00022#1 161118 by lori mod:num5 to num10
DEFINE g_current_row         LIKE type_t.num10             #目前所在筆數 #161117-00022#1 161118 by lori mod:num5 to num10
DEFINE g_current_idx         LIKE type_t.num5
DEFINE g_detail_cnt          LIKE type_t.num10             #單身 總筆數(所有資料) #161117-00022#1 161118 by lori mod:num5 to num10
DEFINE g_page                STRING                        #第幾頁
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_master_idx          LIKE type_t.num5
DEFINE g_detail_idx          LIKE type_t.num10             #單身 所在筆數(所有資料) #161117-00022#1 161118 by lori mod:num5 to num10
DEFINE g_detail_idx2         LIKE type_t.num10   #161117-00022#1 161118 by lori mod:num5 to num10
DEFINE g_detail_cnt2         LIKE type_t.num10             #單身 總筆數(所有資料) #161117-00022#1 161118 by lori mod:num5 to num10
DEFINE g_d1_sql              STRING
#150204-00013#7 150306 pomelo add(s)
DEFINE g_d1_join             STRING
DEFINE g_d1_imaa             STRING
#150204-00013#7 150306 pomelo add(e)
DEFINE g_d1_sql_order        STRING
DEFINE g_d1_sql_group        STRING   #160604-00009#134 160706 by sakura add
DEFINE g_d2_sql              STRING
#150204-00013#7 150306 pomelo add(s)
DEFINE g_d2_join             STRING
DEFINE g_d2_imaa             STRING
DEFINE g_d2_inad             STRING
DEFINE g_d2_rtax             STRING
DEFINE g_d2_rtaw             STRING
#150204-00013#7 150306 pomelo add(e)
DEFINE g_d2_sql_order        STRING
DEFINE g_d2_sql_group        STRING
DEFINE g_sys                 LIKE type_t.chr10 #add by geza 20161215 161214-00002#1
#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="aslq901.main" >}
#+ 作業開始
MAIN
   #add-point:main段define name="main.define"
   DEFINE l_success     LIKE type_t.num5 #150308-00001#3 150309 pomelo add
   #end add-point    
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("asl","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
 
   #add-point:SQL_define name="main.define_sql"
   LET g_forupd_sql = " "
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE aslq901_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aslq901 WITH FORM cl_ap_formpath("asl",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aslq901_init()
 
      #進入選單 Menu (='N')
      CALL aslq901_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_aslq901
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   CALL aslq901_drop_tmp() #add by geza 20161219 #161214-00002#1
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="aslq901.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION aslq901_init()
   DEFINE l_success     LIKE type_t.num5 #150308-00001#3 150309 pomelo add
   
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_error_show  = 1
   CALL cl_set_combo_scc('l_inaa102','6200')
   CALL cl_set_combo_scc('l_inaa102_1','6200')
   CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   CALL aslq901_default_search()
   CALL aslq901_create_tmp() RETURNING l_success #add by geza 20161219 #161214-00002#1
   #取得中類的層級 #add by geza 20161215 161214-00002#1
   LET g_sys = cl_get_para(g_enterprise,g_site,"E-CIR-0062")    
END FUNCTION

PRIVATE FUNCTION aslq901_default_search()

   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " inagsite = '", g_argv[01], "' AND "
   END IF

   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " inag001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " inag002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " inag003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " inag004 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " inag005 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " inag006 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc, " inag007 = '", g_argv[08], "' AND "
   END IF

   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      LET g_wc = " 1=2"
   END IF

END FUNCTION

PRIVATE FUNCTION aslq901_ui_dialog()
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num5
   DEFINE ls_result STRING
   DEFINE ls_wc     STRING
   DEFINE lc_action_choice_old   STRING

   CALL cl_set_act_visible("accept,cancel", FALSE)

   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()
   LET g_current_row = 0
   LET g_current_idx = 1
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   LET l_ac = 1
   
   CALL aslq901_b_fill()

   WHILE li_exit = FALSE
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         CONSTRUCT BY NAME g_wc ON inagsite,inag001,inag002,inag003,inag004
            BEFORE CONSTRUCT
         
            ON ACTION controlp INFIELD inagsite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'inagsite',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
               CALL q_ooef001_24()
               DISPLAY g_qryparam.return1 TO inagsite  #顯示到畫面上         
               NEXT FIELD inagsite                     #返回原欄位
                        
            ON ACTION controlp INFIELD inag001          
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #CALL q_inag001()                           #呼叫開窗    #160707-00039#1 160711 by sakura mark
               CALL q_inag001_7()                         #160707-00039#1 160711 by sakura add
               DISPLAY g_qryparam.return1 TO inag001      #顯示到畫面上
               NEXT FIELD inag001                         #返回原欄位
               
            ON ACTION controlp INFIELD inag002          
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_inag002()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO inag002      #顯示到畫面上
               NEXT FIELD inag002                         #返回原欄位
               
            ON ACTION controlp INFIELD inag003          
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_inag003()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO inag003      #顯示到畫面上
               NEXT FIELD inag003                         #返回原欄位
               
            ON ACTION controlp INFIELD inag004          
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_inag004_11()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO inag004      #顯示到畫面上
               NEXT FIELD inag004                         #返回原欄位
                       
         END CONSTRUCT  
         
         CONSTRUCT g_wc2 ON imaa009,imaa126,imaa154,imaa133,imaa156,imaa132,rtaw001,rtax001 FROM l_imaa009,l_imaa126,l_imaa154,l_imaa133,l_imaa156,l_imaa132,l_rtaw001,l_rtax001  #add by geza 20161215 161214-00002#1 rtaw001,rtax001
            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD l_imaa009
		   	   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		   	   LET g_qryparam.reqry = FALSE
               CALL q_rtax001()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO l_imaa009  #顯示到畫面上         
               NEXT FIELD l_imaa009                     #返回原欄位
            ON ACTION controlp INFIELD l_imaa126
		   	   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		   	   LET g_qryparam.reqry = FALSE
		   	   LET g_qryparam.arg1 = '2002'
               CALL q_oocq002()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO l_imaa126  #顯示到畫面上         
               NEXT FIELD l_imaa126                     #返回原欄位 
            #No:161202--------------begin     #add by stcshy 161202
            ON ACTION controlp INFIELD l_imaa133
		   	   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		   	   LET g_qryparam.reqry = FALSE
		   	   LET g_qryparam.arg1 = '2007'
               CALL q_oocq002()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO l_imaa133  #顯示到畫面上         
               NEXT FIELD l_imaa133                     #返回原欄位
            ON ACTION controlp INFIELD l_imaa132
		   	   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		   	   LET g_qryparam.reqry = FALSE
		   	   LET g_qryparam.arg1 = '2006'
               CALL q_oocq002()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO l_imaa132  #顯示到畫面上         
               NEXT FIELD l_imaa132                     #返回原欄位
            #mark by geza 20161215   #161214-00002#1   #161214-00002#1  #161214-00002#1  
#            ON ACTION controlp INFIELD l_imaa128
#		   	   INITIALIZE g_qryparam.* TO NULL
#               LET g_qryparam.state = 'c'
#		   	   LET g_qryparam.reqry = FALSE
#		   	   LET g_qryparam.arg1 = '2004'
#               CALL q_oocq002()                         #呼叫開窗
#               DISPLAY g_qryparam.return1 TO l_imaa128  #顯示到畫面上         
#               NEXT FIELD l_imaa128                     #返回原欄位
            #mark by geza 20161215   #161214-00002#1   #161214-00002#1  #161214-00002#1
            #add by geza 20161215   #161214-00002#1   #161214-00002#1  #161214-00002#1#  
            ON ACTION controlp INFIELD l_rtaw001
 		   	   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
 		   	   LET g_qryparam.reqry = FALSE
 		   	   LET g_qryparam.arg1 = '1'
               CALL q_rtax001_3()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO l_rtaw001  #顯示到畫面上         
               NEXT FIELD l_rtaw001                     #返回原欄位
               
            ON ACTION controlp INFIELD l_rtax001
 		   	   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
 		   	   LET g_qryparam.reqry = FALSE
 		   	   LET g_qryparam.arg1 = g_sys
               CALL q_rtax001_3()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO l_rtax001  #顯示到畫面上         
               NEXT FIELD l_rtax001                     #返回原欄位   
            #add by geza 20161215   #161214-00002#1   #161214-00002#1  #161214-00002#1            
            #No:161202----------------end
         END CONSTRUCT
         
         CONSTRUCT g_wc3 ON inad010 FROM l_inad010
            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD l_inad010
		   	   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		   	   LET g_qryparam.reqry = FALSE
               CALL q_pmaa001_3()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO l_inad010  #顯示到畫面上         
               NEXT FIELD l_inad010                     #返回原欄位
               
         END CONSTRUCT
         INPUT tm.l_qty_flag,tm.l_inag012,tm.l_inag010,
               tm2.inagsite,tm2.inag001,tm2.inag002,tm2.inag004,tm2.inag005,
               tm2.inag006 ,tm2.imaa009,tm2.inag003,tm2.inag007,tm2.inad014, #160512-00004#2-add-'tm2.inad014'
               tm2.inad011,tm2.inad010 ,tm2.imaa126,
               tm2.imaa154,tm2.imaa133,tm2.imaa156,tm2.imaa132,tm2.imaa128,tm2.rtax001       #add by stcshy 161202 #add by geza 20161215 161214-00002#1  rtax001
          FROM l_qty_flag,l_inag012,l_inag010,
               l_inagsite,l_inag001,l_inag002,l_inag004,l_inag005,
               l_inag006,l_imaa009_1,l_inag003,l_inag007,l_inad014, #160512-00004#2-add-'l_inad014'
               l_inad011,l_inad010_1,l_imaa126_1,
               l_imaa154_1,l_imaa133_1,l_imaa156_1,l_imaa132_1,l_imaa128_1,l_rtax001_1    #add by stcshy 161202 #add by geza 20161215 161214-00002#1  rtax001
            BEFORE INPUT 

            AFTER INPUT
         
         END INPUT 
         
         DISPLAY ARRAY g_inag_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)

            BEFORE DISPLAY
               LET g_current_page = 1

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_inag_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
               CALL aslq901_b_fill2()

         END DISPLAY
         
         DISPLAY ARRAY g_inag2_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt2)

            BEFORE DISPLAY
               LET g_current_page = 2

            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.h_index
               DISPLAY g_inag2_d.getLength() TO FORMONLY.h_count

         END DISPLAY

         BEFORE DIALOG
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            #給預設值
            LET tm.l_inag012 = 'ALL'
            LET tm.l_inag010 = 'ALL'
            LET tm.l_qty_flag = 'Y'
            LET tm2.inagsite = 'Y'
            LET tm2.inag001 = 'N'
            LET tm2.inag002 = 'N'
            LET tm2.inag004 = 'N'
            LET tm2.inag005 = 'N'
            LET tm2.inag006 = 'N'
            LET tm2.imaa009 = 'N'
            LET tm2.inag003 = 'N'
            LET tm2.inag007 = 'N'
            LET tm2.inad014 = 'N'  #160512-00004#2-add
            LET tm2.inad011 = 'N'  
            LET tm2.inad010 = 'N'
            LET tm2.imaa126 = 'N'
            #No:161202-----------------begin   #add by stcshy 161202
            LET tm2.imaa154 = 'N'
            LET tm2.imaa133 = 'N'
            LET tm2.imaa156 = 'N'
            LET tm2.imaa132 = 'N'
            LET tm2.imaa128 = 'N'
            LET tm2.rtax001 = 'N' #add by geza 20161215 161214-00002#1
            #No:161202-------------------end
            DISPLAY tm.l_qty_flag,
                    tm2.inagsite,tm2.inag001,tm2.inag002,tm2.inag004,tm2.inag005,
                    tm2.inag006 ,tm2.imaa009,tm2.inag003,tm2.inag007,tm2.inad011,
                    tm2.inad010 ,tm2.imaa126,
                    tm2.imaa154,tm2.imaa133,tm2.imaa156,tm2.imaa132,tm2.imaa128,tm2.rtax001   #add by stcshy 161202 #add by geza 20161215 161214-00002#1 rtax001
                 TO l_qty_flag,
                    l_inagsite,l_inag001,l_inag002,l_inag004,l_inag005,
                    l_inag006,l_imaa009_1,l_inag003,l_inag007,l_inad011,
                    l_inad010_1,l_imaa126_1,
                    l_imaa154_1,l_imaa133_1,l_imaa156_1,l_imaa132_1,l_imaa128_1,l_rtax001_1   #add by stcshy 161202 #add by geza 20161215 161214-00002#1 rtax001
            CALL aslq901_comp_visible()        
            NEXT FIELD inagsite

         AFTER DIALOG

         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG

         ON ACTION close
            LET INT_FLAG=FALSE
            LET li_exit = TRUE
            EXIT DIALOG

         ON ACTION accept
            INITIALIZE g_wc_filter TO NULL
            IF cl_null(g_wc) THEN
               LET g_wc = " 1=1"
            END IF
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF 
            CALL aslq901_comp_visible()
            CALL aslq901_b_fill()
            #NEXT FIELD sel       #160808-00026#1 Mark By Ken 160808 修正切換營運據點後inagsite條件會有多組織導致查不到資料問題
            NEXT FIELD inagsite   #160808-00026#1 Add By Ken 160808 修正切換營運據點後inagsite條件會有多組織導致查不到資料問題


         ON ACTION agendum   # 待辦事項
            CALL cl_user_overview()

         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_inag_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_inag2_d)
               LET g_export_id[2]   = "s_detail2"
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF

         ON ACTION datarefresh   # 重新整理
            CALL aslq901_b_fill()
            NEXT FIELD sel

         #ON ACTION qbehidden     #qbe頁籤折疊
         #   IF g_qbe_hidden THEN
         #      CALL gfrm_curr.setElementHidden("qbe",0)
         #      CALL gfrm_curr.setElementImage("qbehidden","16/mainhidden.png")
         #      LET g_qbe_hidden = 0     #visible
         #   ELSE
         #      CALL gfrm_curr.setElementHidden("qbe",1)
         #      CALL gfrm_curr.setElementImage("qbehidden","16/worksheethidden.png")
         #      LET g_qbe_hidden = 1     #hidden
         #   END IF

        ##有關於sel欄位選取的action段落
        ##選擇全部
        #ON ACTION selall
        #   CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
        #   FOR li_idx = 1 TO g_inag_d.getLength()
        #      LET g_inag_d[li_idx].sel = "Y"
        #   END FOR

        ##取消全部
        #ON ACTION selnone
        #   CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
        #   FOR li_idx = 1 TO g_inag_d.getLength()
        #      LET g_inag_d[li_idx].sel = "N"
        #   END FOR

        ##勾選所選資料
        #ON ACTION sel
        #   FOR li_idx = 1 TO g_inag_d.getLength()
        #      IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
        #         LET g_inag_d[li_idx].sel = "Y"
        #      END IF
        #   END FOR

        ##取消所選資料
        #ON ACTION unsel
        #   FOR li_idx = 1 TO g_inag_d.getLength()
        #      IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
        #         LET g_inag_d[li_idx].sel = "N"
        #      END IF
        #   END FOR
        
         #應用 qs16 樣板自動產生(Version:2)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aslq901_filter()
            CALL aslq901_b_fill()
            NEXT FIELD sel

        ##應用 a43 樣板自動產生(Version:2)
        #ON ACTION insert
        #   LET g_action_choice="insert"
        #   IF cl_auth_chk_act("insert") THEN
        #      EXIT DIALOG
        #   END IF



         #應用 a43 樣板自動產生(Version:2)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN

               EXIT DIALOG
            END IF

        ##應用 a43 樣板自動產生(Version:2)
        #ON ACTION query
        #   LET g_action_choice="query"
        #   IF cl_auth_chk_act("query") THEN
        #
        #   END IF

         #應用 a43 樣板自動產生(Version:2)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN

               EXIT DIALOG
            END IF

         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"

         ON ACTION qbeclear   # 條件清除
            CLEAR FORM

      END DIALOG

   END WHILE

END FUNCTION

PRIVATE FUNCTION aslq901_b_fill()
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE l_inag009       LIKE inag_t.inag009
   DEFINE l_sql           STRING
   
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
  
   
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   
   #IF cl_null(g_wc) THEN    #160808-00026#1 Mark By Ken 160808 修正切換營運據點後inagsite條件會有多組織導致查不到資料問題
   IF g_wc = " 1=1" THEN     #160808-00026#1 Add By Ken 160808 修正切換營運據點後inagsite條件會有多組織導致查不到資料問題
      LET g_wc = s_aooi500_sql_where(g_prog,'inagsite')
   ELSE 
      LET g_wc = g_wc," AND ",s_aooi500_sql_where(g_prog,'inagsite')
   END IF
   
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   
   IF cl_null(g_wc3) THEN
      LET g_wc3 = " 1=1"
   END IF
   
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, " AND ",g_wc3

   CALL g_inag_d.clear()
   CALL g_inag2_d.clear()

   LET g_cnt = l_ac
   LET l_ac = 1

   # b_fill段sql組成及FOREACH撰寫
   LET g_d1_sql        = ''
   LET g_d1_sql_order  = ''
   LET g_d1_sql_group  = ''   #160604-00009#134 160706 by sakura add   
   LET g_d2_sql        = ''   
   LET g_d2_sql_order  = ''   
   LET g_d2_sql_group  = ''   
   #150204-00013#7 150306 pomelo add(s)
   LET g_d1_join = ''
   LET g_d2_join = ''
   LET g_d1_imaa = ''
   LET g_d2_imaa = ''
   LET g_d2_inad = ''
   LET g_d2_rtax = '' #add by geza 20161215 161214-00002#1
   LET g_d2_rtaw = '' #add by geza 20161215 161214-00002#1
   #150204-00013#7 150306 pomelo add(e)
   
   LET g_d1_sql = "SELECT UNIQUE "
   LET g_d2_sql = "SELECT UNIQUE "

   #---1---營運組織
   IF tm2.inagsite = 'Y' THEN
      #LET g_d1_sql = g_d1_sql," '',inagsite,''"          #150204-00013#7 150306 pomelo mark
      #150924-00002#1 20150924 s983961--mark and mod(s)
      #LET g_d1_sql = g_d1_sql," '',inagsite,t1.ooefl003"  #150204-00013#7 150306 pomelo add
      LET g_d1_sql = g_d1_sql," '',inagsite,  ", 
                              "    (SELECT ooefl003 ",
                              "       FROM ooefl_t ",
                              "      WHERE ooeflent = inagent AND ooefl001 = inagsite AND ooefl002 ='"||g_dlang||"') inagsite_desc "
      LET g_d2_sql = g_d2_sql," '',''"
      LET g_d1_sql_group = g_d1_sql_group," '',inagsite,inagent "   #160604-00009#134 160706 by sakura add
      #150204-00013#7 150306 pomelo add(s)
      #LET g_d1_join = g_d1_join," LEFT OUTER JOIN ooefl_t t1 ON t1.ooeflent = inagent",
      #                          "                           AND t1.ooefl001 = inagsite",
      #                          "                           AND t1.ooefl002 = '",g_dlang,"' " 
      #150204-00013#7 150306 pomelo add(e)
      #150924-00002#1 20150924 s983961--mark and mod(e)
      
      
      IF cl_null(g_d1_sql_order) THEN
         LET g_d1_sql_order = "inagsite"
      ELSE
         LET g_d1_sql_order = g_d1_sql_order,",inagsite"
      END IF
   ELSE
      LET g_d1_sql = g_d1_sql," '','',''"
      LET g_d1_sql_group = g_d1_sql_group," '','',''"   #160604-00009#134 160706 by sakura add
      #LET g_d2_sql = g_d2_sql," inagsite,''"          #150204-00013#7 150306 pomelo mark
      #150924-00002#1 20150924 s983961--mark and mod(s)
      LET g_d2_sql = g_d2_sql," inagsite,t1.ooefl003"  #150204-00013#7 150306 pomelo add
      #LET g_d2_sql = g_d2_sql," inagsite, ",
      #                        " (SELECT ooefl003 ",
      #                        "    FROM ooefl_t ",
      #                        "   WHERE ooeflent = inagent AND ooefl001 = inagsite AND ooefl002 ='"||g_dlang||"') inagsite_desc "      
      #150204-00013#7 150306 pomelo add(s)
      LET g_d2_join = g_d2_join," LEFT OUTER JOIN ooefl_t t1 ON t1.ooeflent = inagent",
                                "                           AND t1.ooefl001 = inagsite",
                                "                           AND t1.ooefl002 = '",g_dlang,"'"
      #150924-00002#1 20150924 s983961--mark and mod(e)          
      
      
      #150204-00013#7 150306 pomelo add(e)
      IF cl_null(g_d2_sql_order) THEN
         LET g_d2_sql_order = "inagsite"
         #LET g_d2_sql_group = "inagsite"              #150204-00013#7 150306 pomelo mark
         LET g_d2_sql_group = "inagsite,t1.ooefl003"   #150204-00013#7 150306 pomelo add              
      ELSE
         LET g_d2_sql_order = g_d2_sql_order,",inagsite"
         #LET g_d2_sql_group = g_d2_sql_group,",inagsite"            #150204-00013#7 150306 pomelo mark
         LET g_d2_sql_group = g_d2_sql_group,",inagsite,t1.ooefl003" #150204-00013#7 150306 pomelo add   
      END IF
   END IF
   
   #---2---商品編號
   IF tm2.inag001 = 'Y' THEN
      #LET g_d1_sql = g_d1_sql,",inag001,'',''"                  #150204-00013#7 150306 pomelo mark
      LET g_d1_sql = g_d1_sql,",inag001,t2.imaal003,t2.imaal004" #150204-00013#7 150306 pomelo add
      LET g_d1_sql_group = g_d1_sql_group,",inag001,t2.imaal003,t2.imaal004"   #160604-00009#134 160706 by sakura add
      LET g_d2_sql = g_d2_sql,",'','',''"
      #150204-00013#7 150306 pomelo add(s)
      LET g_d1_join = g_d1_join," LEFT OUTER JOIN imaal_t t2 ON t2.imaalent = inagent",
                                "                           AND t2.imaal001 = inag001",
                                "                           AND t2.imaal002 = '",g_dlang,"'"
      #150204-00013#7 150306 pomelo add(e)
      IF cl_null(g_d1_sql_order) THEN
         LET g_d1_sql_order = "inag001"
      ELSE
         LET g_d1_sql_order = g_d1_sql_order,",inag001"
      END IF
   ELSE
      LET g_d1_sql = g_d1_sql,",'','',''"
      LET g_d1_sql_group = g_d1_sql_group,",'','',''"   #160604-00009#134 160706 by sakura add
      #LET g_d2_sql = g_d2_sql,",inag001,'',''"                  #150204-00013#7 150306 pomelo mark
      LET g_d2_sql = g_d2_sql,",inag001,t2.imaal003,t2.imaal004" #150204-00013#7 150306 pomelo add
      #150204-00013#7 150306 pomelo add(s)
      LET g_d2_join = g_d2_join," LEFT OUTER JOIN imaal_t t2 ON t2.imaalent = inagent",
                                "                           AND t2.imaal001 = inag001",
                                "                           AND t2.imaal002 = '",g_dlang,"'"
      #150204-00013#7 150306 pomelo add(e)
      IF cl_null(g_d2_sql_order) THEN
         LET g_d2_sql_order = "inag001"
         #LET g_d2_sql_group = "inag001"                         #150204-00013#7 150306 pomelo mark
         LET g_d2_sql_group = "inag001,t2.imaal003,t2.imaal004" #150204-00013#7 150306 pomelo add
      ELSE
         LET g_d2_sql_order = g_d2_sql_order,",inag001"
         #LET g_d2_sql_group = g_d2_sql_group,",inag001"                        #150204-00013#7 150306 pomelo mark
         LET g_d2_sql_group = g_d2_sql_group,",inag001,t2.imaal003,t2.imaal004" #150204-00013#7 150306 pomelo add
      END IF
   END IF
   #---2.1---品牌
   IF tm2.imaa126 = 'Y' THEN
      #150924-00002#1 20150925 s983961--mark and mod(s) 
      #LET g_d1_sql = g_d1_sql,",imaa126,t8.oocql004"
      LET g_d1_sql = g_d1_sql," ,imaa126, ",
                              "  (SELECT oocql004 ",
                              "     FROM oocql_t ",
                              "    WHERE oocqlent = imaaent AND oocql001 = '2002' AND oocql002 = imaa126 AND oocql003 ='"||g_dlang||"') imaa126_desc "                       
      #150924-00002#1 20150925 s983961--mark and mod(e) 
      LET g_d1_sql_group = g_d1_sql_group,",imaa126,imaaent "   #160604-00009#134 160706 by sakura add
      LET g_d2_sql = g_d2_sql,",'',''"
      #LET g_d1_imaa = g_d1_imaa," LEFT OUTER JOIN oocql_t t8 ON t8.oocqlent = imaaent",
      #                          "                           AND t8.oocql001 = '2002'",
      #                          "                           AND t8.oocql002 = imaa126",
      #                          "                           AND t8.oocql003 = '",g_dlang,"'"
      IF cl_null(g_d1_sql_order) THEN
         LET g_d1_sql_order = "imaa126"
      ELSE
         LET g_d1_sql_order = g_d1_sql_order,",imaa126"
      END IF
   ELSE
      LET g_d1_sql = g_d1_sql,",'',''"
      LET g_d1_sql_group = g_d1_sql_group,",'',''"   #160604-00009#134 160706 by sakura add
      LET g_d2_sql = g_d2_sql,",imaa126,t8.oocql004"
      LET g_d2_imaa = g_d2_imaa," LEFT OUTER JOIN oocql_t t8 ON t8.oocqlent = imaaent",
                                "                           AND t8.oocql001 = '2002'",
                                "                           AND t8.oocql002 = imaa126",
                                "                           AND t8.oocql003 = '",g_dlang,"'"
      IF cl_null(g_d2_sql_order) THEN
         LET g_d2_sql_order = "imaa126"
         LET g_d2_sql_group = "imaa126,t8.oocql004"
      ELSE
         LET g_d2_sql_order = g_d2_sql_order,",imaa126"
         LET g_d2_sql_group = g_d2_sql_group,",imaa126,t8.oocql004"
      END IF
   END IF
   
   #---3---產品特徵
   IF tm2.inag002 = 'Y' THEN
      LET g_d1_sql = g_d1_sql,",inag002,''"
      LET g_d1_sql_group = g_d1_sql_group,",inag002,''"   #160604-00009#134 160706 by sakura add
      LET g_d2_sql = g_d2_sql,",'',''"
      IF cl_null(g_d1_sql_order) THEN
         LET g_d1_sql_order = "inag002"
      ELSE
         LET g_d1_sql_order = g_d1_sql_order,",inag002"
      END IF
   ELSE
      LET g_d1_sql = g_d1_sql,",'',''"
      LET g_d1_sql_group = g_d1_sql_group,",'',''"   #160604-00009#134 160706 by sakura add
      LET g_d2_sql = g_d2_sql,",inag002,''"

      IF cl_null(g_d2_sql_order) THEN
         LET g_d2_sql_order = "inag002"
         LET g_d2_sql_group = "inag002"
      ELSE
         LET g_d2_sql_order = g_d2_sql_order,",inag002"
         LET g_d2_sql_group = g_d2_sql_group,",inag002"
      END IF
   END IF


   
   #---4---庫位
   IF tm2.inag004 = 'Y' THEN
      #150204-00013#7 150306 pomelo mark(s)
      #LET g_d1_sql = g_d1_sql,",inag004,''"
      #LET g_d2_sql = g_d2_sql,",'',''"
      #150204-00013#7 150306 pomelo mark(e)
      #150204-00013#7 150306 pomelo add(s)
      #150924-00002#1 20150925 s983961--mark and mod(s) 
      #LET g_d1_sql = g_d1_sql,",inag004,t3.inayl003,t4.inaa102,t4.inaa120,''"
      LET g_d1_sql = g_d1_sql,",inag004, ",
                              " (SELECT inayl003 ",
                              "    FROM inayl_t ",
                              "   WHERE inaylent = inagent AND inayl001 = inag004 AND inayl002 ='"||g_dlang||"') inag004_desc, ",
                              " t4.inaa102,t4.inaa120,",
                              " (SELECT mhael023 ",
                              "    FROM mhael_t ",
                              "   WHERE mhaelent = t4.inaaent AND mhael001 = t4.inaa120 AND mhael022 ='"||g_dlang||"') inaa120_desc "
      #150924-00002#1 20150925 s983961--mark and mod(e) 
      LET g_d1_sql_group = g_d1_sql_group,",inag004,t4.inaa102,t4.inaa120,t4.inaaent "   #160604-00009#134 160706 by sakura add
      LET g_d2_sql = g_d2_sql,",'','','','',''"
      #LET g_d1_join = g_d1_join," LEFT OUTER JOIN inayl_t t3 ON t3.inaylent = inagent",
      #                          "                           AND t3.inayl001 = inag004",
      #                          "                           AND t3.inayl002 = '",g_dlang,"'",
      #                          " LEFT OUTER JOIN inaa_t  t4 ON t4.inaaent = inagent",
      #                          "                           AND t4.inaasite = inagsite",
      #                          "                           AND t4.inaa001 = inag004"
      LET g_d1_join = g_d1_join," LEFT OUTER JOIN inaa_t  t4 ON t4.inaaent = inagent",
                                "                           AND t4.inaasite = inagsite",
                                "                           AND t4.inaa001 = inag004"
      #150204-00013#7 150306 pomelo add(e)
      IF cl_null(g_d1_sql_order) THEN
         LET g_d1_sql_order = "inag004"
      ELSE
         LET g_d1_sql_order = g_d1_sql_order,",inag004"
      END IF
   ELSE
      #150204-00013#7 150306 pomelo mark(s)
      #LET g_d1_sql = g_d1_sql,",'',''"
      #LET g_d2_sql = g_d2_sql,",inag004,''"
      #150204-00013#7 150306 pomelo mark(e)
      #150204-00013#7 150306 pomelo add(s)
      LET g_d1_sql = g_d1_sql,",'','','','',''"
      LET g_d1_sql_group = g_d1_sql_group,",'','','','',''"   #160604-00009#134 160706 by sakura add
      LET g_d2_sql = g_d2_sql,",inag004,t3.inayl003,t4.inaa102,t4.inaa120,''"
      LET g_d2_join = g_d2_join," LEFT OUTER JOIN inayl_t t3 ON t3.inaylent = inagent",
                                "                           AND t3.inayl001 = inag004",
                                "                           AND t3.inayl002 = '",g_dlang,"'",
                                " LEFT OUTER JOIN inaa_t  t4 ON t4.inaaent = inagent",
                                "                           AND t4.inaasite = inagsite",
                                "                           AND t4.inaa001 = inag004"
      #150204-00013#7 150306 pomelo add(e)
      IF cl_null(g_d2_sql_order) THEN
         LET g_d2_sql_order = "inag004"
         #LET g_d2_sql_group = "inag004" #150204-00013#7 150306 pomelo mark
         LET g_d2_sql_group = "inag004,t3.inayl003,t4.inaa102,t4.inaa120" #150204-00013#7 150306 pomelo add
      ELSE
         LET g_d2_sql_order = g_d2_sql_order,",inag004"
         #LET g_d2_sql_group = g_d2_sql_group,",inag004" #150204-00013#7 150306 pomelo mark
         LET g_d2_sql_group = g_d2_sql_group,",inag004,t3.inayl003,t4.inaa102,t4.inaa120" #150204-00013#7 150306 pomelo add
      END IF
   END IF

   #No:161202---------------begin    #add by stcshy 161202
   IF tm2.imaa154 = 'Y' THEN
      LET g_d1_sql = g_d1_sql,",imaa154"
      LET g_d1_sql_group = g_d1_sql_group,",imaa154 "
      LET g_d2_sql = g_d2_sql,",''"
      IF cl_null(g_d1_sql_order) THEN
         LET g_d1_sql_order = "imaa154"
      ELSE
         LET g_d1_sql_order = g_d1_sql_order,",imaa154"
      END IF
   ELSE
      LET g_d1_sql = g_d1_sql,",''"
      LET g_d1_sql_group = g_d1_sql_group,",''"
      LET g_d2_sql = g_d2_sql,",imaa154"
      IF cl_null(g_d2_sql_order) THEN
         LET g_d2_sql_order = "imaa154"
         LET g_d2_sql_group = "imaa154"
      ELSE
         LET g_d2_sql_order = g_d2_sql_order,",imaa154"
         LET g_d2_sql_group = g_d2_sql_group,",imaa154"
      END IF
   END IF

   IF tm2.imaa133 = 'Y' THEN
      LET g_d1_sql = g_d1_sql,",imaa133, ",
                              "  (SELECT oocql004 FROM oocql_t ",
                              "    WHERE oocqlent = ",g_enterprise," AND oocql001 = '2007' AND oocql002 = imaa133 AND oocql003 ='"||g_dlang||"') imaa133_desc "      
      LET g_d1_sql_group = g_d1_sql_group,",imaa133 "
      LET g_d2_sql = g_d2_sql,",'',''"
      IF cl_null(g_d1_sql_order) THEN
         LET g_d1_sql_order = "imaa133"
      ELSE
         LET g_d1_sql_order = g_d1_sql_order,",imaa133"
      END IF
   ELSE
      LET g_d1_sql = g_d1_sql,",'',''"
      LET g_d1_sql_group = g_d1_sql_group,",'',''"
      LET g_d2_sql = g_d2_sql,",imaa133,t9.oocql004"
      LET g_d2_imaa = g_d2_imaa," LEFT OUTER JOIN oocql_t t9 ON t9.oocqlent = imaaent AND t9.oocql001 = '2007' AND t9.oocql002 = imaa133 AND t9.oocql003 = '",g_dlang,"'"
      IF cl_null(g_d2_sql_order) THEN
         LET g_d2_sql_order = "imaa133"
         LET g_d2_sql_group = "imaa133,t9.oocql004"
      ELSE
         LET g_d2_sql_order = g_d2_sql_order,",imaa133"
         LET g_d2_sql_group = g_d2_sql_group,",imaa133,t9.oocql004"
      END IF
   END IF

   IF tm2.imaa156 = 'Y' THEN
      LET g_d1_sql = g_d1_sql,",imaa156"
      LET g_d1_sql_group = g_d1_sql_group,",imaa156 "
      LET g_d2_sql = g_d2_sql,",''"
      IF cl_null(g_d1_sql_order) THEN
         LET g_d1_sql_order = "imaa156"
      ELSE
         LET g_d1_sql_order = g_d1_sql_order,",imaa156"
      END IF
   ELSE
      LET g_d1_sql = g_d1_sql,",''"
      LET g_d1_sql_group = g_d1_sql_group,",''"
      LET g_d2_sql = g_d2_sql,",imaa156"
      IF cl_null(g_d2_sql_order) THEN
         LET g_d2_sql_order = "imaa156"
         LET g_d2_sql_group = "imaa156"
      ELSE
         LET g_d2_sql_order = g_d2_sql_order,",imaa156"
         LET g_d2_sql_group = g_d2_sql_group,",imaa156"
      END IF
   END IF

   IF tm2.imaa132 = 'Y' THEN
      LET g_d1_sql = g_d1_sql,",imaa132, ",
                              "  (SELECT oocql004 FROM oocql_t ",
                              "    WHERE oocqlent = ",g_enterprise," AND oocql001 = '2006' AND oocql002 = imaa132 AND oocql003 ='"||g_dlang||"') imaa132_desc "      
      LET g_d1_sql_group = g_d1_sql_group,",imaa132 "
      LET g_d2_sql = g_d2_sql,",'',''"
      IF cl_null(g_d1_sql_order) THEN
         LET g_d1_sql_order = "imaa132"
      ELSE
         LET g_d1_sql_order = g_d1_sql_order,",imaa132"
      END IF
   ELSE
      LET g_d1_sql = g_d1_sql,",'',''"
      LET g_d1_sql_group = g_d1_sql_group,",'',''"
      LET g_d2_sql = g_d2_sql,",imaa132,t10.oocql004"
      LET g_d2_imaa = g_d2_imaa," LEFT OUTER JOIN oocql_t t10 ON t10.oocqlent = imaaent AND t10.oocql001 = '2006' AND t10.oocql002 = imaa132 AND t10.oocql003 = '",g_dlang,"'"
      IF cl_null(g_d2_sql_order) THEN
         LET g_d2_sql_order = "imaa132"
         LET g_d2_sql_group = "imaa132,t10.oocql004"
      ELSE
         LET g_d2_sql_order = g_d2_sql_order,",imaa132"
         LET g_d2_sql_group = g_d2_sql_group,",imaa132,t10.oocql004"
      END IF
   END IF

   #mark by geza 20161215   #161214-00002#1(S)
#   IF tm2.imaa128 = 'Y' THEN
#      LET g_d1_sql = g_d1_sql,",imaa128, ",
#                              "  (SELECT oocql004 FROM oocql_t ",
#                              "    WHERE oocqlent = imaaent AND oocql001 = '2004' AND oocql002 = imaa128 AND oocql003 ='"||g_dlang||"') imaa128_desc "      
#      LET g_d1_sql_group = g_d1_sql_group,",imaa128 "
#      LET g_d2_sql = g_d2_sql,",'',''"
#      IF cl_null(g_d1_sql_order) THEN
#         LET g_d1_sql_order = "imaa128"
#      ELSE
#         LET g_d1_sql_order = g_d1_sql_order,",imaa128"
#      END IF
#   ELSE
#      LET g_d1_sql = g_d1_sql,",'',''"
#      LET g_d1_sql_group = g_d1_sql_group,",'',''"
#      LET g_d2_sql = g_d2_sql,",imaa128,t11.oocql004"
#      LET g_d2_imaa = g_d2_imaa," LEFT OUTER JOIN oocql_t t11 ON t11.oocqlent = imaaent AND t11.oocql001 = '2004' AND t11.oocql002 = imaa128 AND t11.oocql003 = '",g_dlang,"'"
#      IF cl_null(g_d2_sql_order) THEN
#         LET g_d2_sql_order = "imaa128"
#         LET g_d2_sql_group = "imaa128,t11.oocql004"
#      ELSE
#         LET g_d2_sql_order = g_d2_sql_order,",imaa128"
#         LET g_d2_sql_group = g_d2_sql_group,",imaa128,t11.oocql004"
#      END IF
#   END IF
   #mark by geza 20161215   #161214-00002#1(E)
   
   #add by geza 20161215   #161214-00002#1(S)
   IF tm2.imaa128 = 'Y' THEN
      LET g_d1_sql = g_d1_sql,",rtaw001, ",
                              "  (SELECT rtaxl003 FROM rtaxl_t ",
                              "    WHERE rtaxlent = rtawent AND rtaxl001 = rtaw001 AND rtaxl002 ='"||g_dlang||"') rtaw001_desc "      
      LET g_d1_sql_group = g_d1_sql_group,",rtaw001,rtawent "
      LET g_d2_sql = g_d2_sql,",'','' "
      IF cl_null(g_d1_sql_order) THEN
         LET g_d1_sql_order = "rtaw001"
      ELSE
         LET g_d1_sql_order = g_d1_sql_order,",rtaw001"
      END IF
   ELSE
      LET g_d1_sql = g_d1_sql,",'',''"
      LET g_d1_sql_group = g_d1_sql_group,",'',''"
      LET g_d2_sql = g_d2_sql,",rtaw001,t11.rtaxl003"
      LET g_d2_rtaw= g_d2_rtaw," LEFT OUTER JOIN rtaxl_t t11 ON t11.rtaxlent = rtawent AND t11.rtaxl001 = rtaw001 AND t11.rtaxl002 = '",g_dlang,"'"
      IF cl_null(g_d2_sql_order) THEN
         LET g_d2_sql_order = "rtaw001"
         LET g_d2_sql_group = "rtaw001,t11.rtaxl003"
      ELSE
         LET g_d2_sql_order = g_d2_sql_order,",rtaw001"
         LET g_d2_sql_group = g_d2_sql_group,",rtaw001,t11.rtaxl003"
      END IF
   END IF
   
   IF tm2.rtax001 = 'Y' THEN
      LET g_d1_sql = g_d1_sql,",rtax001, ",
                              "  (SELECT rtaxl003 FROM rtaxl_t ",
                              "    WHERE rtaxlent = rtaxent AND rtaxl001 = rtax001 AND rtaxl002 ='"||g_dlang||"') rtax001_desc "      
      LET g_d1_sql_group = g_d1_sql_group,",rtax001,rtaxent "
      LET g_d2_sql = g_d2_sql,",'','' "
      IF cl_null(g_d1_sql_order) THEN
         LET g_d1_sql_order = "rtax001"
      ELSE
         LET g_d1_sql_order = g_d1_sql_order,",rtax001"
      END IF
   ELSE
      LET g_d1_sql = g_d1_sql,",'',''"
      LET g_d1_sql_group = g_d1_sql_group,",'',''"
      LET g_d2_sql = g_d2_sql,",rtax001,t12.rtaxl003"
      LET g_d2_rtax= g_d2_rtax," LEFT OUTER JOIN rtaxl_t t12 ON t12.rtaxlent = rtaxent AND t12.rtaxl001 = rtax001 AND t12.rtaxl002 = '",g_dlang,"'"
      IF cl_null(g_d2_sql_order) THEN
         LET g_d2_sql_order = "rtax001"
         LET g_d2_sql_group = "rtax001,t12.rtaxl003"
      ELSE
         LET g_d2_sql_order = g_d2_sql_order,",rtax001"
         LET g_d2_sql_group = g_d2_sql_group,",rtax001,t12.rtaxl003"
      END IF
   END IF
   #add by geza 20161215   #161214-00002#1(E)
   
   #No:161202-----------------end

   #150204-00013#7 150306 pomelo add(s)
   #---5---產品分類
   IF tm2.imaa009 = 'Y' THEN
      #150924-00002#1 20150925 s983961--mark and mod(s) 
      #LET g_d1_sql = g_d1_sql,",imaa009,t7.rtaxl003"
      LET g_d1_sql = g_d1_sql,",imaa009, ",
                              "  (SELECT rtaxl003 ",
                              "     FROM rtaxl_t ",
                              "    WHERE rtaxlent = ",g_enterprise," AND rtaxl001 = imaa009 AND rtaxl002 ='"||g_dlang||"') imaa009_desc "        
      #150924-00002#1 20150925 s983961--mark and mod(e) 
      LET g_d1_sql_group = g_d1_sql_group,",imaa009 "   #160604-00009#134 160706 by sakura add
      LET g_d2_sql = g_d2_sql,",'',''"
      #150924-00002#1 20150925 s983961--mark(s)
      #LET g_d1_imaa = g_d1_imaa," LEFT OUTER JOIN rtaxl_t t7 ON t7.rtaxlent = imaaent",
      #                          "                           AND t7.rtaxl001 = imaa009",
      #                          "                           AND t7.rtaxl002 = '",g_dlang,"'"
      #150924-00002#1 20150925 s983961--mark(e)
      IF cl_null(g_d1_sql_order) THEN
         LET g_d1_sql_order = "imaa009"
      ELSE
         LET g_d1_sql_order = g_d1_sql_order,",imaa009"
      END IF
   ELSE
      LET g_d1_sql = g_d1_sql,",'',''"
      LET g_d1_sql_group = g_d1_sql_group,",'',''"   #160604-00009#134 160706 by sakura add
      LET g_d2_sql = g_d2_sql,",imaa009,t7.rtaxl003"
      LET g_d2_imaa = g_d2_imaa," LEFT OUTER JOIN rtaxl_t t7 ON t7.rtaxlent = imaaent",
                                "                           AND t7.rtaxl001 = imaa009",
                                "                           AND t7.rtaxl002 = '",g_dlang,"'"
      IF cl_null(g_d2_sql_order) THEN
         LET g_d2_sql_order = "imaa009"
         LET g_d2_sql_group = "imaa009,t7.rtaxl003"
      ELSE
         LET g_d2_sql_order = g_d2_sql_order,",imaa009"
         LET g_d2_sql_group = g_d2_sql_group,",imaa009,t7.rtaxl003"
      END IF
   END IF
   #150204-00013#7 150306 pomelo add(e)
   
   #mark by geza 20161214 #161214-00002#1(S)
   #No:161206-------------------begin     #add by stcshy 161206
#   LET g_d2_sql = g_d2_sql,",imaa157" 
#   IF cl_null(g_d2_sql_order) THEN
#      LET g_d2_sql_order = "imaa157"
#      LET g_d2_sql_group = "imaa157"
#   ELSE
#      LET g_d2_sql_order = g_d2_sql_order,",imaa157"
#      LET g_d2_sql_group = g_d2_sql_group,",imaa157"
#   END IF
#   #No:161206---------------------end
   #mark by geza 20161214 #161214-00002#1(E)
   
   #add by geza 20161214 #161214-00002#1(S)
   LET g_d2_sql = g_d2_sql,",imaa116" 
   IF cl_null(g_d2_sql_order) THEN
      LET g_d2_sql_order = "imaa116"
      LET g_d2_sql_group = "imaa116"
   ELSE
      LET g_d2_sql_order = g_d2_sql_order,",imaa116"
      LET g_d2_sql_group = g_d2_sql_group,",imaa116"
   END IF
   #add by geza 20161214 #161214-00002#1(E)
   
   #---6---儲位
   IF tm2.inag005 = 'Y' THEN
      #LET g_d1_sql = g_d1_sql,",inag005,''"          #150204-00013#7 150306 pomelo mark
      #150924-00002#1 20150925 s983961--mark and mod(s)
      #LET g_d1_sql = g_d1_sql,",inag005,t5.inab003"   #150204-00013#7 150306 pomelo add
      LET g_d1_sql = g_d1_sql,",inag005, ", 
                              " (SELECT inab003 ",
                              "    FROM inab_t ",
                              "   WHERE inabent = inagent AND inabsite = inagsite AND inab001 = inag004 AND inab002 = inag005) inag005_desc "        
      #150924-00002#1 20150925 s983961--mark and mod(e) 
      LET g_d1_sql_group = g_d1_sql_group,",inag005 "   #160604-00009#134 160706 by sakura add
      LET g_d2_sql = g_d2_sql,",'',''"
      #150924-00002#1 20150925 s983961--mark(s)
      #150204-00013#7 150306 pomelo add(s)
      #LET g_d1_join = g_d1_join," LEFT OUTER JOIN inab_t t5 ON t5.inabent = inagent",
      #                          "                          AND t5.inabsite = inagsite",
      #                          "                          AND t5.inab001 = inag004",
      #                          "                          AND t5.inab002 = inag005"
      #150204-00013#7 150306 pomelo add(e)
      #150924-00002#1 20150925 s983961--mark(s)
      IF cl_null(g_d1_sql_order) THEN
         LET g_d1_sql_order = "inag005"
      ELSE
         LET g_d1_sql_order = g_d1_sql_order,",inag005"
      END IF
   ELSE
      LET g_d1_sql = g_d1_sql,",'',''"
      LET g_d1_sql_group = g_d1_sql_group,",'',''"   #160604-00009#134 160706 by sakura add
      #LET g_d2_sql = g_d2_sql,",inag005,''"         #150204-00013#7 150306 pomelo mark
      LET g_d2_sql = g_d2_sql,",inag005,t5.inab003"  #150204-00013#7 150306 pomelo add
      #150204-00013#7 150306 pomelo add(s)
      LET g_d2_join = g_d2_join," LEFT OUTER JOIN inab_t t5 ON t5.inabent = inagent",
                                "                          AND t5.inabsite = inagsite",
                                "                          AND t5.inab001 = inag004",
                                "                          AND t5.inab002 = inag005"
      #150204-00013#7 150306 pomelo add(e)
      IF cl_null(g_d2_sql_order) THEN
         LET g_d2_sql_order = "inag005"
         #LET g_d2_sql_group = "inag005"            #150204-00013#7 150306 pomelo mark
         LET g_d2_sql_group = "inag005,t5.inab003"  #150204-00013#7 150306 pomelo add
      ELSE
         LET g_d2_sql_order = g_d2_sql_order,",inag005"
         #LET g_d2_sql_group = g_d2_sql_group,",inag005"           #150204-00013#7 150306 pomelo mark
         LET g_d2_sql_group = g_d2_sql_group,",inag005,t5.inab003" #150204-00013#7 150306 pomelo add
      END IF
   END IF
   
   #---7---批號
   IF tm2.inag006 = 'Y' THEN
      LET g_d1_sql = g_d1_sql,",inag006"
      LET g_d1_sql_group = g_d1_sql_group,",inag006"   #160604-00009#134 160706 by sakura add
      LET g_d2_sql = g_d2_sql,",''"
      IF cl_null(g_d1_sql_order) THEN
         LET g_d1_sql_order = "inag006"
      ELSE
         LET g_d1_sql_order = g_d1_sql_order,",inag006"
      END IF
   ELSE
      LET g_d1_sql = g_d1_sql,",''"
      LET g_d1_sql_group = g_d1_sql_group,",''"   #160604-00009#134 160706 by sakura add
      LET g_d2_sql = g_d2_sql,",inag006"

      IF cl_null(g_d2_sql_order) THEN
         LET g_d2_sql_order = "inag006"
         LET g_d2_sql_group = "inag006"
      ELSE
         LET g_d2_sql_order = g_d2_sql_order,",inag006"
         LET g_d2_sql_group = g_d2_sql_group,",inag006"
      END IF
   END IF
   
   #---8---庫存管理特徵
   IF tm2.inag003 = 'Y' THEN
      LET g_d1_sql = g_d1_sql,",inag003"
      LET g_d1_sql_group = g_d1_sql_group,",inag003"   #160604-00009#134 160706 by sakura add
      LET g_d2_sql = g_d2_sql,",''"
      IF cl_null(g_d1_sql_order) THEN
         LET g_d1_sql_order = "inag003"
      ELSE
         LET g_d1_sql_order = g_d1_sql_order,",inag003"
      END IF
   ELSE
      LET g_d1_sql = g_d1_sql,",''"
      LET g_d1_sql_group = g_d1_sql_group,",''"   #160604-00009#134 160706 by sakura add
      LET g_d2_sql = g_d2_sql,",inag003"
      IF cl_null(g_d2_sql_order) THEN
         LET g_d2_sql_order = "inag003"
         LET g_d2_sql_group = "inag003"
      ELSE
         LET g_d2_sql_order = g_d2_sql_order,",inag003"
         LET g_d2_sql_group = g_d2_sql_group,",inag003"
      END IF
   END IF
   
   #---9---庫存單位
   IF tm2.inag007 = 'Y' THEN
      #LET g_d1_sql = g_d1_sql,",inag007,''"           #150204-00013#7 150306 pomelo mark
      #150924-00002#1 20150925 s983961--mark and mod(s)
      #LET g_d1_sql = g_d1_sql,",inag007,t6.oocal003"   #150204-00013#7 150306 pomelo add
      LET g_d1_sql = g_d1_sql,",inag007, ",
                              " (SELECT oocal003 ",
                              "    FROM oocal_t ",
                              "   WHERE oocalent = inagent AND oocal001 = inag007 AND oocal002 = '",g_dlang,"') inag007_desc "       
      #150924-00002#1 20150925 s983961--mark and mod(e)
      LET g_d1_sql_group = g_d1_sql_group,",inag007 "   #160604-00009#134 160706 by sakura add
      LET g_d2_sql = g_d2_sql,",'',''"
      #150924-00002#1 20150925 s983961--mark(s)
      #150204-00013#7 150306 pomelo add(s)
      #LET g_d1_join = g_d1_join," LEFT OUTER JOIN oocal_t t6 ON t6.oocalent = inagent",
      #                          "                           AND t6.oocal001 = inag007",
      #                          "                           AND t6.oocal002 = '",g_dlang,"'"
      #150924-00002#1 20150925 s983961--mark(e)                          
      #150204-00013#7 150306 pomelo add(e)
      IF cl_null(g_d1_sql_order) THEN
         LET g_d1_sql_order = "inag007"
      ELSE
         LET g_d1_sql_order = g_d1_sql_order,",inag007"
      END IF
   ELSE
      LET g_d1_sql = g_d1_sql,",'',''"
      LET g_d1_sql_group = g_d1_sql_group,",'',''"   #160604-00009#134 160706 by sakura add
      #LET g_d2_sql = g_d2_sql,",inag007,''"           #150204-00013#7 150306 pomelo mark
      LET g_d2_sql = g_d2_sql,",inag007,t6.oocal003"   #150204-00013#7 150306 pomelo add
      #150204-00013#7 150306 pomelo add(s)
      LET g_d2_join = g_d2_join," LEFT OUTER JOIN oocal_t t6 ON t6.oocalent = inagent",
                                "                           AND t6.oocal001 = inag007",
                                "                           AND t6.oocal002 = '",g_dlang,"'"
      #150204-00013#7 150306 pomelo add(e)
      IF cl_null(g_d2_sql_order) THEN
         LET g_d2_sql_order = "inag007"
         #LET g_d2_sql_group = "inag007"              #150204-00013#7 150306 pomelo mark
         LET g_d2_sql_group = "inag007,t6.oocal003"   #150204-00013#7 150306 pomelo add
      ELSE
         LET g_d2_sql_order = g_d2_sql_order,",inag007"
         #LET g_d2_sql_group = g_d2_sql_group,",inag007"              #150204-00013#7 150306 pomelo mark
         LET g_d2_sql_group = g_d2_sql_group,",inag007,t6.oocal003"   #150204-00013#7 150306 pomelo add
      END IF
   END IF
   
   #150204-00013#7 150306 pomelo add(s)
   #---10---有效日期、製造日期
   #160512-00004#2-add-「OR tm2.inad014 = 'Y'」
   IF tm2.inad010 = 'Y' OR tm2.inad011 = 'Y' OR tm2.inad014 = 'Y' THEN
     #LET g_d1_sql = g_d1_sql,",inad011"
     #LET g_d2_sql = g_d2_sql,",''"   
     
     #150924-00002#1 20150925 s983961--mark and mod(s)
     #LET g_d1_join = g_d1_join," LEFT OUTER JOIN (SELECT inadent,inadsite,inad001,inad002,inad003,inad010,pmaal004,inad011,inad012 ",
     #                          "                    FROM inad_t LEFT OUTER JOIN pmaal_t ON inadent = pmaalent AND  ",
     #                          "                                                              inad010 = pmaal001 AND  ",
     #                          "                                                              pmaal002 = '",g_dlang,"')",                                                              
     #                          "              ON inadent = inagent",
     #                          "             AND inadsite = inagsite",
     #                          "             AND inad001 = inag001",
     #                          "             AND inad002 = inag002",
     #                          "             AND inad003 = inag006"                               
     #
     #LET g_d2_inad = " LEFT OUTER JOIN (SELECT inadent,inadsite,inad001,inad002,inad003,inad010,pmaal004,inad011,inad012 ",
     #                "                    FROM inad_t LEFT OUTER JOIN pmaal_t ON inadent = pmaalent AND  ",
     #                "                                                              inad010 = pmaal001 AND  ",
     #                "                                                              pmaal002 = '",g_dlang,"')",                                                              
     #                "              ON inadent = inagent",
     #                "             AND inadsite = inagsite",
     #                "             AND inad001 = inag001",
     #                "             AND inad002 = inag002",
     #                "             AND inad003 = inag006"        
     #160512-00004#2-add-'inad014'
     LET g_d1_join = g_d1_join," LEFT OUTER JOIN (SELECT inadent,inadsite,inad001,inad002,inad003,inad010,inad014,inad011,inad012, ",
                               "                         (SELECT pmaal004 ",
                               "                            FROM pmaal_t ",
                               "                           WHERE pmaalent = inadent AND pmaal001 = inad010 AND pmaal002 = '",g_dlang,"') pmaal004 ",    
                               "                    FROM inad_t)  ",                                                            
                               "              ON inadent = inagent",
                               "             AND inadsite = inagsite",
                               "             AND inad001 = inag001",
                               "             AND inad002 = inag002",
                               "             AND inad003 = inag006"
     #160512-00004#2-add-'inad014'
     LET g_d2_inad = " LEFT OUTER JOIN (SELECT inadent,inadsite,inad001,inad002,inad003,inad010,inad014,inad011,inad012, ",
                     "                         (SELECT pmaal004 ",
                     "                            FROM pmaal_t ",
                     "                           WHERE pmaalent = inadent AND pmaal001 = inad010 AND pmaal002 = '",g_dlang,"') pmaal004 ",    
                     "                    FROM inad_t)  ",                                                            
                     "              ON inadent = inagent",
                     "             AND inadsite = inagsite",
                     "             AND inad001 = inag001",
                     "             AND inad002 = inag002",
                     "             AND inad003 = inag006"     
     #150924-00002#1 20150925 s983961--mark and mod(e)
     
     #IF cl_null(g_d1_sql_order) THEN
     #   LET g_d1_sql_order = "inad011"
     #ELSE
     #   LET g_d1_sql_order = g_d1_sql_order,",inad011"
     #END IF
   ELSE
     #LET g_d1_sql = g_d1_sql,",''"
     #LET g_d2_sql = g_d2_sql,",inad011"
     #150924-00002#1 20150925 s983961--mark and mod(s)
     #LET g_d2_join = g_d2_join, " LEFT OUTER JOIN (SELECT inadent,inadsite,inad001,inad002,inad003,inad010,pmaal004,inad011,inad012 ",
     #                           "                    FROM inad_t LEFT OUTER JOIN pmaal_t ON inadent = pmaalent AND  ",
     #                           "                                                              inad010 = pmaal001 AND  ",
     #                           "                                                              pmaal002 = '",g_dlang,"')",                                                              
     #                           "              ON inadent = inagent",
     #                           "             AND inadsite = inagsite",
     #                           "             AND inad001 = inag001",
     #                           "             AND inad002 = inag002",
     #                           "             AND inad003 = inag006"
     #160512-00004#2-add-'inad014'
     LET g_d2_join = g_d2_join," LEFT OUTER JOIN (SELECT inadent,inadsite,inad001,inad002,inad003,inad010,inad014,inad011,inad012, ",
                               "                         (SELECT pmaal004 ",
                               "                            FROM pmaal_t ",
                               "                           WHERE pmaalent = inadent AND pmaal001 = inad010 AND pmaal002 = '",g_dlang,"') pmaal004 ",    
                               "                    FROM inad_t)  ",                                                            
                               "              ON inadent = inagent",
                               "             AND inadsite = inagsite",
                               "             AND inad001 = inag001",
                               "             AND inad002 = inag002",
                               "             AND inad003 = inag006"  
     #150924-00002#1 20150925 s983961--mark and mod(e)                           
     #IF cl_null(g_d2_sql_order) THEN
     #   LET g_d2_sql_order = "inad011"
     #   LET g_d2_sql_group = "inad011"
     #ELSE
     #   LET g_d2_sql_order = g_d2_sql_order,",inad011"
     #   LET g_d2_sql_group = g_d2_sql_group,",inad011"
     #END IF
   END IF
   #150204-00013#7 150306 pomelo add(e)
   #160512-00004#2-add-(S)
   IF tm2.inad014 = 'Y' THEN
      LET g_d1_sql = g_d1_sql,",inad014"
      LET g_d1_sql_group = g_d1_sql_group,",inad014"   #160604-00009#134 160706 by sakura add
      LET g_d2_sql = g_d2_sql,",''" 
      
      IF cl_null(g_d1_sql_order) THEN
         LET g_d1_sql_order = "inad014"
      ELSE
         LET g_d1_sql_order = g_d1_sql_order,",inad014"
      END IF
   ELSE
      LET g_d1_sql = g_d1_sql,",''"
      LET g_d1_sql_group = g_d1_sql_group,",''"   #160604-00009#134 160706 by sakura add
      LET g_d2_sql = g_d2_sql,",inad014"
      IF cl_null(g_d2_sql_order) THEN
         LET g_d2_sql_order = "inad014"
         LET g_d2_sql_group = "inad014"
      ELSE
         LET g_d2_sql_order = g_d2_sql_order,",inad014"
         LET g_d2_sql_group = g_d2_sql_group,",inad014"
      END IF   
   END IF
   #160512-00004#2-add-(E)
   IF tm2.inad011 = 'Y' THEN
      LET g_d1_sql = g_d1_sql,",inad011"
      LET g_d1_sql_group = g_d1_sql_group,",inad011"   #160604-00009#134 160706 by sakura add
      LET g_d2_sql = g_d2_sql,",''" 
      
      IF cl_null(g_d1_sql_order) THEN
         LET g_d1_sql_order = "inad011"
      ELSE
         LET g_d1_sql_order = g_d1_sql_order,",inad011"
      END IF
   ELSE
      LET g_d1_sql = g_d1_sql,",''"
      LET g_d1_sql_group = g_d1_sql_group,",''"   #160604-00009#134 160706 by sakura add
      LET g_d2_sql = g_d2_sql,",inad011"
      IF cl_null(g_d2_sql_order) THEN
         LET g_d2_sql_order = "inad011"
         LET g_d2_sql_group = "inad011"
      ELSE
         LET g_d2_sql_order = g_d2_sql_order,",inad011"
         LET g_d2_sql_group = g_d2_sql_group,",inad011"
      END IF   
   END IF
   
   IF tm2.inad010 = 'Y' THEN
      LET g_d1_sql = g_d1_sql,",inad010,pmaal004"
      LET g_d1_sql_group = g_d1_sql_group,",inad010,pmaal004"   #160604-00009#134 160706 by sakura add
      LET g_d2_sql = g_d2_sql,",'',''" 
      
      IF cl_null(g_d1_sql_order) THEN
         LET g_d1_sql_order = "inad010"
      ELSE
         LET g_d1_sql_order = g_d1_sql_order,",inad010"
      END IF
   ELSE
      LET g_d1_sql = g_d1_sql,",'',''"
      LET g_d1_sql_group = g_d1_sql_group,",'',''"   #160604-00009#134 160706 by sakura add
      LET g_d2_sql = g_d2_sql,",inad010,pmaal004"
      IF cl_null(g_d2_sql_order) THEN
         LET g_d2_sql_order = "inad010"
         LET g_d2_sql_group = "inad010,pmaal004"
      ELSE
         LET g_d2_sql_order = g_d2_sql_order,",inad010"
         LET g_d2_sql_group = g_d2_sql_group,",inad010,pmaal004"
      END IF   
   END IF
   
   LET g_sql = g_d1_sql,",SUM(NVL(inag008,0)),SUM(NVL(inag009,0)) ",
                       # "  FROM inag_t",g_d1_join," ,imaa_t " #mark by geza 20161215   #161214-00002#1
                         "  FROM inag_t",g_d1_join," ,imaa_t,rtaw_t,rtax_t " #add by geza 20161215   #161214-00002#1
   #LET g_sql1 = "INSERT INTO temp_inag SELECT UNIQUE inagsite,inag001,inag002,0 FROM inag_t",g_d1_join,",imaa_t" #mark by geza 20161214 #161214-00002#1
   LET g_sql1 = "INSERT INTO temp_inag SELECT UNIQUE inagsite,inag001,inag002,inag004,inag007,0 FROM inag_t",g_d1_join,",imaa_t,rtaw_t,rtax_t" #add by geza 20161214 #161214-00002#1
   IF tm2.inad010 = 'N' AND tm2.inad011 = 'N' AND tm2.inad014 = 'N' AND g_wc3 != " 1=1" THEN
      LET g_sql = g_sql ,",inad_t "
      LET g_sql1= g_sql1,",inad_t "
   END IF

   #LET g_sql = g_sql," WHERE inagent= ? AND inagent = imaaent AND inag001 = imaa001 AND ", ls_wc #mark by geza 20161215   #161214-00002#1
   LET g_sql = g_sql," WHERE inagent= ? AND inagent = imaaent AND inag001 = imaa001 ",
                     "   AND rtaxent = imaaent AND rtax006 = rtaw001 AND rtax004 = '",g_sys,"' ",  #add by geza 20161215   #161214-00002#1
                     "   AND EXISTS (SELECT 1 FROM rtaw_t a WHERE a.rtawent = rtaxent AND a.rtaw002 = imaa009 AND a.rtaw001 = rtax001   )",#add by geza 20161215   #161214-00002#1
                     "   AND rtaw002 = imaa009 AND rtawent = imaaent AND rtaw003 = '1' AND " ,ls_wc #add by geza 20161215   #161214-00002#1
   #LET g_sql1= g_sql1," WHERE inagent= ? AND inagent = imaaent AND inag001 = imaa001 AND ", ls_wc #mark by geza 20161215   #161214-00002#1
   LET g_sql1= g_sql1," WHERE inagent= ? AND inagent = imaaent AND inag001 = imaa001 ",
                     "   AND rtaxent = imaaent AND rtax006 = rtaw001 AND rtax004 = '",g_sys,"' ",  #add by geza 20161215   #161214-00002#1                     
                     "   AND EXISTS (SELECT 1 FROM rtaw_t a WHERE a.rtawent = rtaxent AND a.rtaw002 = imaa009 AND a.rtaw001 = rtax001   )",#add by geza 20161215   #161214-00002#1
                     "   AND rtaw002 = imaa009 AND rtawent = imaaent AND rtaw003 = '1' AND ",ls_wc #add geza 20161215   #161214-00002#1
   #160512-00004#2-add-「AND tm2.inad014 = 'N'」           
   IF tm2.inad010 = 'N' AND tm2.inad011 = 'N' AND tm2.inad014 = 'N' AND g_wc3 != ' 1=1' THEN
      LET g_sql = g_sql , " AND inadent = inagent AND inadsite = inagsite",
                          " AND inad001 = inag001 AND inad002 = inag002",
                          " AND inad003 = inag006 "
      LET g_sql1= g_sql1, " AND inadent = inagent AND inadsite = inagsite",
                          " AND inad001 = inag001 AND inad002 = inag002",
                          " AND inad003 = inag006 "
   END IF
              
   IF tm.l_inag012 != 'ALL' THEN
      LET g_sql = g_sql," AND inag012 ='",tm.l_inag012,"'"
      LET g_sql1= g_sql1," AND inag012 ='",tm.l_inag012,"'"
   END IF
   
   IF tm.l_inag010 != 'ALL' THEN
      LET g_sql = g_sql," AND inag010 ='",tm.l_inag010,"'"
      LET g_sql1= g_sql1," AND inag010 ='",tm.l_inag010,"'"
   END IF
    
   IF tm.l_qty_flag = 'Y' THEN
      #LET g_sql = g_sql," AND inag008 != 0" #mark by geza 20161215   #161214-00002#1
      #LET g_sql1= g_sql1," AND inag008 != 0" #mark by geza 20161215   #161214-00002#1
      LET g_sql = g_sql," AND inag009 != 0" #add by geza 20161215   #161214-00002#1
      LET g_sql1= g_sql1," AND inag009 != 0" #add by geza 20161215   #161214-00002#1
   END IF

   LET g_sql = g_sql, cl_sql_add_filter("inag_t") 
   LET g_sql1= g_sql1, cl_sql_add_filter("inag_t") 
   
   LET g_sql = g_sql," GROUP BY ",g_d1_sql_group   #160604-00009#134 160706 by sakura add
   
   IF NOT cl_null(g_d1_sql_order) THEN
      LET g_sql = g_sql," ORDER BY ",g_d1_sql_order
   END IF

   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   
   #DROP TABLE temp_inag #mark by geza 20161214 #161214-00002#1
   #SELECT inagsite,inag001,inag002,inag009 FROM inag_t WHERE 1=2 INTO TEMP temp_inag #mark by geza 20161214 #161214-00002#1
   #SELECT inagsite,inag001,inag002,inag004,inag007,inag009 FROM inag_t WHERE 1=2 INTO TEMP temp_inag #add by geza 20161214 #161214-00002#1
   #add by geza 20161214 #161214-00002#1(S)
   #PREPARE aslq901_tp FROM g_sql1
   #EXECUTE aslq901_tp USING g_enterprise
   #CALL aslq901_tpu()
   #add by geza 20161214 #161214-00002#1(E)
   PREPARE aslq901_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aslq901_pb

   OPEN b_fill_curs USING g_enterprise

   FOREACH b_fill_curs INTO g_inag_d[l_ac].sel,g_inag_d[l_ac].inagsite,g_inag_d[l_ac].inagsite_desc,
                            g_inag_d[l_ac].inag001,g_inag_d[l_ac].inag001_desc,g_inag_d[l_ac].inag001_desc_desc,
                            g_inag_d[l_ac].imaa126,g_inag_d[l_ac].imaa126_desc,
                            g_inag_d[l_ac].inag002,g_inag_d[l_ac].inag002_desc,                            
                            g_inag_d[l_ac].inag004,g_inag_d[l_ac].inag004_desc,
                            #150204-00013#7 150306 pomelo add(s)
                            g_inag_d[l_ac].inaa102,g_inag_d[l_ac].inaa120,g_inag_d[l_ac].inaa120_desc,
                            g_inag_d[l_ac].imaa154,g_inag_d[l_ac].imaa133,g_inag_d[l_ac].imaa133_desc,g_inag_d[l_ac].imaa156,g_inag_d[l_ac].imaa132,g_inag_d[l_ac].imaa132_desc,g_inag_d[l_ac].imaa128,g_inag_d[l_ac].imaa128_desc,    #add by stcshy 161202                            
                            g_inag_d[l_ac].rtax001,g_inag_d[l_ac].rtax001_desc, #add by geza 20161215   #161214-00002#1
                            g_inag_d[l_ac].imaa009,g_inag_d[l_ac].imaa009_desc,
                            #150204-00013#7 150306 pomelo add(e)
                            g_inag_d[l_ac].inag005,g_inag_d[l_ac].inag005_desc,
                            g_inag_d[l_ac].inag006,g_inag_d[l_ac].inag003,
                            g_inag_d[l_ac].inag007,g_inag_d[l_ac].inag007_desc,
                            g_inag_d[l_ac].inad014,         #160512-00004#2-add
                            g_inag_d[l_ac].inad011,         #150204-00013#7 150306 pomelo add
                            g_inag_d[l_ac].inad010,g_inag_d[l_ac].inad010_desc,
                            g_inag_d[l_ac].inag008,g_inag_d[l_ac].inag009          #160604-00009#134 160706 by sakura add
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      LET g_inag_d[l_ac].inag008 = g_inag_d[l_ac].inag009 #add by geza 20161207 #161030-00006#2
      #No:161030----------------begin      #add by stcshy 161030
      LET l_inag009=0
      #mark by geza #161214-00002#1(S)
#      LET l_sql = "SELECT SUM(inag009) FROM temp_inag WHERE 1=1"
#      IF tm2.inagsite = 'Y' THEN
#         LET l_sql = l_sql," AND inagsite='",g_inag_d[l_ac].inagsite,"'"
#      END IF
#      IF tm2.inag001 = 'Y' THEN
#         LET l_sql = l_sql," AND inag001='",g_inag_d[l_ac].inag001,"'"
#      END IF
#      IF tm2.inag002 = 'Y' THEN
#         LET l_sql = l_sql," AND inag002='",g_inag_d[l_ac].inag002,"'"
#      END IF
#      #add by geza 20161214 #161214-00002#1(S)
#      IF tm2.inag004 = 'Y' THEN
#         LET l_sql = l_sql," AND inag004='",g_inag_d[l_ac].inag004,"'"
#      END IF
#      IF tm2.inag007 = 'Y' THEN
#         LET l_sql = l_sql," AND inag007='",g_inag_d[l_ac].inag007,"'"
#      END IF
#      #add by geza 20161214 #161214-00002#1(E)
#      PREPARE aslq901_kup FROM l_sql
#      DECLARE aslq901_kuc CURSOR FOR aslq901_kup
#      OPEN aslq901_kuc
#      FETCH aslq901_kuc INTO l_inag009
#      CLOSE aslq901_kuc
      #mark by geza #161214-00002#1(E)
     #add by geza #161214-00002#1(S)
#      IF tm2.inagsite = 'Y' AND tm2.inag001 = 'Y' AND tm2.inag002 = 'Y' AND tm2.inag004 = 'Y' AND tm2.inag007 = 'Y' THEN
#         OPEN aslq901_kuc USING g_inag_d[l_ac].inagsite,g_inag_d[l_ac].inag001,g_inag_d[l_ac].inag002,g_inag_d[l_ac].inag004,g_inag_d[l_ac].inag007
#      END IF
#      IF tm2.inagsite = 'Y' AND tm2.inag001 = 'Y' AND tm2.inag002 = 'Y' AND tm2.inag004 = 'Y' AND tm2.inag007 = 'N' THEN
#         OPEN aslq901_kuc USING g_inag_d[l_ac].inagsite,g_inag_d[l_ac].inag001,g_inag_d[l_ac].inag002,g_inag_d[l_ac].inag004      
#      END IF
#      IF tm2.inagsite = 'Y' AND tm2.inag001 = 'Y' AND tm2.inag002 = 'Y' AND tm2.inag004 = 'N' AND tm2.inag007 = 'N' THEN
#         OPEN aslq901_kuc USING g_inag_d[l_ac].inagsite,g_inag_d[l_ac].inag001,g_inag_d[l_ac].inag002
#      END IF
#      IF tm2.inagsite = 'Y' AND tm2.inag001 = 'Y' AND tm2.inag002 = 'N' AND tm2.inag004 = 'N' AND tm2.inag007 = 'N' THEN
#         OPEN aslq901_kuc USING g_inag_d[l_ac].inagsite,g_inag_d[l_ac].inag001
#      END IF
#      IF tm2.inagsite = 'Y' AND tm2.inag001 = 'N' AND tm2.inag002 = 'N' AND tm2.inag004 = 'N' AND tm2.inag007 = 'N' THEN
#         OPEN aslq901_kuc USING g_inag_d[l_ac].inagsite
#      END IF
#      IF tm2.inagsite = 'N' AND tm2.inag001 = 'N' AND tm2.inag002 = 'N' AND tm2.inag004 = 'N' AND tm2.inag007 = 'N' THEN
#         OPEN aslq901_kuc
#      END IF 
#      FETCH aslq901_kuc INTO l_inag009
      #add by geza #161214-00002#1(S)
      LET l_sql = " SELECT SUM((CASE WHEN inax002 = '1' THEN 1  ELSE -1 END)*inax014) ",
                  "   FROM inax_t,imaa_t,rtaw_t,rtax_t,inag_t",
                  "  WHERE inaxent = ",g_enterprise," ",
                  "    AND inax010 = inag001 AND inax011 = inag002 AND inax013 = inag007 AND inax015 = inag004 AND inax017 = inagsite ",
                  "    AND imaaent = inaxent AND inax010 = imaa001 ",
                  "    AND rtaxent = imaaent AND rtax006 = rtaw001 AND rtax004 = '",g_sys,"' ",                   
                  "    AND EXISTS (SELECT 1 FROM rtaw_t a WHERE a.rtawent = rtaxent AND a.rtaw002 = imaa009 AND a.rtaw001 = rtax001   )",
                  "    AND rtaw002 = imaa009 AND rtawent = imaaent AND rtaw003 = '1' AND " ,ls_wc              
      IF tm2.inagsite = 'Y' THEN
         LET l_sql = l_sql," AND inax017= '",g_inag_d[l_ac].inagsite,"' "
      END IF
      IF tm2.inag001 = 'Y' THEN
         LET l_sql = l_sql," AND inax010= '",g_inag_d[l_ac].inag001,"' "
      END IF
      IF tm2.inag002 = 'Y' THEN
         LET l_sql = l_sql," AND inax011= '",g_inag_d[l_ac].inag002,"' "
      END IF
      IF tm2.inag004 = 'Y' THEN
         LET l_sql = l_sql," AND inax015= '",g_inag_d[l_ac].inag004,"' "
      END IF
      IF tm2.inag007 = 'Y' THEN
         LET l_sql = l_sql," AND inax013= '",g_inag_d[l_ac].inag007,"' "
      END IF
      IF g_inag_d[l_ac].imaa126 IS NOT NULL THEN
         LET l_sql = l_sql," AND imaa126= '",g_inag_d[l_ac].imaa126,"' "
      END IF
      IF g_inag_d[l_ac].imaa154 IS NOT NULL THEN
         LET l_sql = l_sql," AND imaa154= '",g_inag_d[l_ac].imaa154,"' "
      END IF
      IF g_inag_d[l_ac].imaa133 IS NOT NULL THEN
         LET l_sql = l_sql," AND imaa133= '",g_inag_d[l_ac].imaa133,"' "
      END IF
      IF g_inag_d[l_ac].imaa156 IS NOT NULL THEN
         LET l_sql = l_sql," AND imaa156= '",g_inag_d[l_ac].imaa156,"' "
      END IF
      IF g_inag_d[l_ac].imaa132 IS NOT NULL THEN
         LET l_sql = l_sql," AND imaa132= '",g_inag_d[l_ac].imaa132,"' "
      END IF
      IF g_inag_d[l_ac].imaa128 IS NOT NULL THEN
         LET l_sql = l_sql," AND rtaw001= '",g_inag_d[l_ac].imaa128,"' "
      END IF
      IF g_inag_d[l_ac].rtax001 IS NOT NULL THEN
         LET l_sql = l_sql," AND rtax001= '",g_inag_d[l_ac].rtax001,"' "
      END IF
      IF g_inag_d[l_ac].imaa009 IS NOT NULL THEN
         LET l_sql = l_sql," AND imaa009= '",g_inag_d[l_ac].imaa009,"' "
      END IF                
      IF g_inag_d[l_ac].imaa009 IS NOT NULL THEN
         LET l_sql = l_sql," AND imaa009= '",g_inag_d[l_ac].imaa009,"' "
      END IF
      IF tm.l_qty_flag = 'Y' THEN
         LET l_sql = l_sql," AND inag009 != 0" 
      END IF
          
      PREPARE aslq901_kup FROM l_sql
      DECLARE aslq901_kuc CURSOR FOR aslq901_kup
      OPEN aslq901_kuc
      FETCH aslq901_kuc INTO l_inag009
      #add by geza #161214-00002#1(E)
      
      #add by geza #161214-00002#1(E)
      IF l_inag009 IS NULL THEN
         LET l_inag009 = 0
      END IF
      LET g_inag_d[l_ac].inag009=g_inag_d[l_ac].inag009+l_inag009
      #No:161030------------------end

      CALL aslq901_detail_show("'1'")

      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend =  ""
            LET g_errparam.code   =  9035
            LET g_errparam.popup  = TRUE
            CALL cl_err()

         END IF
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1

   END FOREACH

   CALL g_inag_d.deleteElement(g_inag_d.getLength())

   LET g_error_show = 0

   LET g_detail_cnt = g_inag_d.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET g_detail_idx = 1
   DISPLAY g_detail_idx TO FORMONLY.h_index
   LET l_ac = g_cnt
   LET g_cnt = 0

   #應用 qs06 樣板自動產生(Version:2)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE aslq901_pb

   LET l_ac = 1
   CALL aslq901_b_fill2()

   CALL aslq901_filter_show('inagsite','b_inagsite')
   CALL aslq901_filter_show('inag001','b_inag001')
   CALL aslq901_filter_show('inag002','b_inag002')
   CALL aslq901_filter_show('inag004','b_inag004')
   CALL aslq901_filter_show('inag005','b_inag005')
   CALL aslq901_filter_show('inag006','b_inag006')
   CALL aslq901_filter_show('inag003','b_inag003')
   CALL aslq901_filter_show('inag007','b_inag007')
   
END FUNCTION

PRIVATE FUNCTION aslq901_b_fill2()
   DEFINE li_ac           LIKE type_t.num5
   DEFINE ls_wc           STRING
   DEFINE l_sql_group     STRING
   DEFINE l_inagsite      LIKE inag_t.inagsite
   DEFINE l_inag001       LIKE inag_t.inag001
   DEFINE l_inag002       LIKE inag_t.inag002
   DEFINE l_inag004       LIKE inag_t.inag004
   DEFINE l_inag007       LIKE inag_t.inag007
   DEFINE l_inag009       LIKE inag_t.inag009
   DEFINE l_inag008_1     LIKE inag_t.inag008 #add by geza 20161216 #161214-00002#1 #实际库存
   DEFINE l_inag009_1     LIKE inag_t.inag009 #add by geza 20161216 #161214-00002#1 #可用库存
   DEFINE l_sql           STRING
   
   
   #add by geza 20161214 #161214-00002#1(S)       
   LET l_sql = " SELECT SUM((CASE WHEN inax002 = '1' THEN 1  ELSE -1 END)*inax014) ",
               "   FROM inax_t ",
               "  WHERE inaxent = ",g_enterprise," ",
               "    AND inax017=? ",
               "    AND inax010=? ",
               "    AND inax011=? ",
               "    AND inax015=? ",
               "    AND inax013=? "
                
   PREPARE aslq901_kup1 FROM l_sql
   DECLARE aslq901_kuc1 CURSOR FOR aslq901_kup1
   #add by geza 20161214 #161214-00002#1(E)
   
   
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, " AND ",g_wc3
   
   LET li_ac = l_ac
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
   CALL g_inag2_d.clear()
   #150204-00013#7 150306 pomelo mark(s)
   #LET g_sql = g_d2_sql,",SUM(COALESCE(inag008,0)),inag016,inag015,inag014,inag012,inag010",
               #"  FROM inag_t,imaa_t",
   #150204-00013#7 150306 pomelo mark(e)
   #150204-00013#7 150306 pomelo add(s)
   #LET g_sql = g_d2_sql,",SUM(COALESCE(inag008,0)),SUM(COALESCE(inag009,0)),inag016,inag015,inag014,inag012,inag010,inad012", #mark by geza 20161214 #161214-00002#1
   LET g_sql = g_d2_sql,",SUM(COALESCE(inag009,0)),SUM(COALESCE(inag009,0)),inag016,inag015,inag014,inag012,inag010,inad012", #add by geza 20161214 #161214-00002#1
               "  FROM inag_t",
               g_d2_join,g_d2_inad," ,imaa_t ",g_d2_imaa," ,rtaw_t ",g_d2_rtaw," ,rtax_t ",g_d2_rtax, #add by geza 20161215   #161214-00002#1 rtaw,rtax
   #150204-00013#7 150306 pomelo add(e) 
               " WHERE inagent = ? ",
               "   AND inagent = imaaent ",
               "   AND rtax006 = rtaw001 AND rtaxent = imaaent AND rtax004 = '",g_sys,"'  ", #add by geza 20161215   #161214-00002#1
               "   AND EXISTS (SELECT 1 FROM rtaw_t a WHERE a.rtawent = rtaxent AND a.rtaw002 = imaa009 AND a.rtaw001 = rtax001   )",#add by geza 20161215   #161214-00002#1
               "   AND rtaw002 = imaa009 AND rtawent = imaaent AND rtaw003 = '1'  ", #add by geza 20161215   #161214-00002#1
               "   AND inag001 = imaa001 AND ",ls_wc
               
   IF tm.l_inag012 != 'ALL' THEN
      LET g_sql = g_sql," AND inag012 ='",tm.l_inag012,"'"
   END IF 
   
   IF tm.l_inag010 != 'ALL' THEN
      LET g_sql = g_sql," AND inag010 ='",tm.l_inag010,"'"
   END IF   
   
   IF tm.l_qty_flag = 'Y' THEN
      #LET g_sql = g_sql," AND inag008 != 0" #mark by geza 20161215   #161214-00002#1
      LET g_sql = g_sql," AND inag009 != 0" #add by geza 20161215   #161214-00002#1
   END IF
   
   #---1---營運組織
   IF tm2.inagsite = 'Y' THEN
      LET g_sql = g_sql ," AND inagsite = '",g_inag_d[g_detail_idx].inagsite CLIPPED,"'"
   END IF
   
   #---2---商品編號
   IF tm2.inag001 = 'Y' THEN
      LET g_sql = g_sql ," AND inag001 = '",g_inag_d[g_detail_idx].inag001 CLIPPED,"'"
   END IF
   #---2.1---品牌
   IF tm2.imaa126 = 'Y' THEN
      IF g_inag_d[g_detail_idx].imaa126 IS NULL THEN
         LET g_sql = g_sql ," AND imaa126 IS NULL"
      ELSE
         LET g_sql = g_sql ," AND imaa126 = '",g_inag_d[g_detail_idx].imaa126 CLIPPED,"'"
      END IF
   END IF
   #---3---產品特徵
   IF tm2.inag002 = 'Y' THEN
      IF cl_null(g_inag_d[g_detail_idx].inag002) THEN
         LET g_sql = g_sql ," AND inag002 = ' '"
      ELSE
         LET g_sql = g_sql ," AND inag002 = '",g_inag_d[g_detail_idx].inag002 CLIPPED,"'"
      END IF
   END IF
   
   #---4---庫存管理特徵
   IF tm2.inag003 = 'Y' THEN
      IF cl_null(g_inag_d[g_detail_idx].inag003) THEN
         LET g_sql = g_sql ," AND inag003 = ' '"
      ELSE
         LET g_sql = g_sql ," AND inag003 = '",g_inag_d[g_detail_idx].inag003 CLIPPED,"'"
      END IF 
   END IF
   
   #---5---庫位編號
   IF tm2.inag004 = 'Y' THEN
      LET g_sql = g_sql ," AND inag004 = '",g_inag_d[g_detail_idx].inag004 CLIPPED,"'"
   END IF

   #No:161202-----------------begin    #add by stcshy 161202
   IF tm2.imaa154 = 'Y' THEN
      #LET g_sql = g_sql ," AND imaa154 = '",g_inag_d[g_detail_idx].imaa154 CLIPPED,"'" #mark by geza 20161215   #161214-00002#1
      #add by geza 20161215   #161214-00002#1(S)
      IF g_inag_d[g_detail_idx].imaa154 IS NULL THEN
         LET g_sql = g_sql ," AND imaa154 IS NULL "
      ELSE
         LET g_sql = g_sql ," AND imaa154 = '",g_inag_d[g_detail_idx].imaa154 CLIPPED,"'"
      END IF
      #add by geza 20161215   #161214-00002#1(E)      
   END IF
   IF tm2.imaa133 = 'Y' THEN
      #LET g_sql = g_sql ," AND imaa133 = '",g_inag_d[g_detail_idx].imaa133 CLIPPED,"'" #mark by geza 20161215   #161214-00002#1
      #add by geza 20161215   #161214-00002#1(S)
      IF g_inag_d[g_detail_idx].imaa133 IS NULL THEN
         LET g_sql = g_sql ," AND imaa133 IS NULL "
      ELSE
         LET g_sql = g_sql ," AND imaa133 = '",g_inag_d[g_detail_idx].imaa133 CLIPPED,"'"
      END IF
      #add by geza 20161215   #161214-00002#1(E)      
   END IF
   IF tm2.imaa156 = 'Y' THEN
      #LET g_sql = g_sql ," AND imaa156 = '",g_inag_d[g_detail_idx].imaa156 CLIPPED,"'" #mark by geza 20161215   #161214-00002#1
      #add by geza 20161215   #161214-00002#1(S)
      IF g_inag_d[g_detail_idx].imaa156 IS NULL THEN
         LET g_sql = g_sql ," AND imaa156 IS NULL "
      ELSE
         LET g_sql = g_sql ," AND imaa156 = '",g_inag_d[g_detail_idx].imaa156 CLIPPED,"'"
      END IF
      #add by geza 20161215   #161214-00002#1(E)      
   END IF
   IF tm2.imaa132 = 'Y' THEN
      #LET g_sql = g_sql ," AND imaa132 = '",g_inag_d[g_detail_idx].imaa132 CLIPPED,"'" #mark by geza 20161215   #161214-00002#1
      #add by geza 20161215   #161214-00002#1(S)
      IF g_inag_d[g_detail_idx].imaa132 IS NULL THEN
         LET g_sql = g_sql ," AND imaa132 IS NULL "
      ELSE
         LET g_sql = g_sql ," AND imaa132 = '",g_inag_d[g_detail_idx].imaa132 CLIPPED,"'"
      END IF
      #add by geza 20161215   #161214-00002#1(E)      
   END IF
   #mark by geza 20161215   #161214-00002#1(S)
#   IF tm2.imaa128 = 'Y' THEN
#      LET g_sql = g_sql ," AND imaa128 = '",g_inag_d[g_detail_idx].imaa128 CLIPPED,"'"
#   END IF
   #mark by geza 20161215   #161214-00002#1(E)
   #add by geza 20161215   #161214-00002#1(S)
   IF tm2.imaa128 = 'Y' THEN
      LET g_sql = g_sql ," AND rtaw001 = '",g_inag_d[g_detail_idx].imaa128 CLIPPED,"'"
   END IF
   IF tm2.rtax001 = 'Y' THEN
      LET g_sql = g_sql ," AND rtax001 = '",g_inag_d[g_detail_idx].rtax001 CLIPPED,"'"
   END IF
   #add by geza 20161215   #161214-00002#1(E)
   #No:161202-------------------end

   #150204-00013#7 150306 pomelo add(s)
   #---6---產品分類
   IF tm2.imaa009 = 'Y' THEN
      LET g_sql = g_sql ," AND imaa009 = '",g_inag_d[g_detail_idx].imaa009 CLIPPED,"'"
   END IF
   
   #150204-00013#7 150306 pomelo add(e)
   
   #---7---儲位編號
   IF tm2.inag005 = 'Y' THEN
      IF cl_null(g_inag_d[g_detail_idx].inag005) THEN
         LET g_sql = g_sql ," AND inag005 = ' '"
      ELSE
         LET g_sql = g_sql ," AND inag005 = '",g_inag_d[g_detail_idx].inag005 CLIPPED,"'"
      END IF
   END IF
   
   #---8---批號
   IF tm2.inag006 = 'Y' THEN
      IF cl_null(g_inag_d[g_detail_idx].inag006) THEN
         LET g_sql = g_sql ," AND inag006 = ' '"
      ELSE
         LET g_sql = g_sql ," AND inag006 = '",g_inag_d[g_detail_idx].inag006 CLIPPED,"'"
      END IF
   END IF
   
   #---9---庫存單位
   IF tm2.inag007 = 'Y' THEN
      LET g_sql = g_sql ," AND inag007 = '",g_inag_d[g_detail_idx].inag007 CLIPPED,"'"
   END IF
   
   #160512-00004#2-add-(S)
   #---12---製造日期
   IF tm2.inad014 = 'Y' THEN
      IF cl_null(g_inag_d[g_detail_idx].inad014) THEN
         LET g_sql = g_sql ," AND inad014 IS NULL"
      ELSE
         LET g_sql = g_sql ," AND inad014 = '",g_inag_d[g_detail_idx].inad014 CLIPPED,"'"
      END IF
   END IF
   #160512-00004#2-add-(E)
   
   #150204-00013#7 150306 pomelo add(s)
   #---10---有效日期
   IF tm2.inad011 = 'Y' THEN
      IF cl_null(g_inag_d[g_detail_idx].inad011) THEN
         LET g_sql = g_sql ," AND inad011 IS NULL"
      ELSE
         LET g_sql = g_sql ," AND inad011 = '",g_inag_d[g_detail_idx].inad011 CLIPPED,"'"
      END IF
   END IF
   #150204-00013#7 150306 pomelo add(e)
   
   #---11---供應商
   
   IF tm2.inad010 = 'Y' THEN
      IF cl_null(g_inag_d[g_detail_idx].inad010) THEN
         LET g_sql = g_sql ," AND inad010 IS NULL"
      ELSE
         LET g_sql = g_sql ," AND inad010 = '",g_inag_d[g_detail_idx].inad010 CLIPPED,"'"
      END IF
   END IF
   LET g_sql = g_sql," AND rownum <= ",g_max_rec," "
   LET g_sql = g_sql, cl_sql_add_filter("inag_t") 

   IF cl_null(g_d2_sql_group) THEN
      LET l_sql_group = " GROUP BY inag016,inag015,inag014,inag012,inag010,inad012"
   ELSE
      LET l_sql_group = " GROUP BY ",g_d2_sql_group,",inag016,inag015,inag014,inag012,inag010,inad012"
   END IF

   LET g_sql = g_sql," ",l_sql_group

   IF NOT cl_null(g_d2_sql_order) THEN
      LET g_sql = g_sql," ORDER BY ",g_d2_sql_order
   END IF
   #add by geza 20161219 #161214-00002#1(S)
   DELETE FROM aslq901_tmp
   LET g_sql = "INSERT INTO aslq901_tmp (inagsite          ,inagsite_desc     ,inag001           ,inag001_desc      ,inag001_desc_desc ,
                                         imaa126           ,imaa126_desc      ,inag002           ,inag002_desc      ,inag004           ,
                                         inag004_desc      ,inaa102           ,inaa120           ,inaa120_desc      ,imaa154           ,
                                         imaa133           ,imaa133_desc      ,imaa156           ,imaa132           ,imaa132_desc      ,
                                         imaa128           ,imaa128_desc      ,rtax001           ,rtax001_desc      ,imaa009           ,
                                         imaa009_desc      ,imaa157           ,inag005           ,inag005_desc      ,inag006           ,
                                         inag003           ,inag007           ,inag007_desc      ,inad014           ,inad011           ,
                                         inad010           ,inad010_desc      ,inag008           ,inag009           ,inag016           ,
                                         inag015           ,inag014           ,inag012           ,inag010           ,inad012  ) ", g_sql

   PREPARE aslq901_ins_tmp FROM g_sql
   EXECUTE aslq901_ins_tmp USING g_enterprise             
   #更新临时表的可用库存
   LET l_sql = " MERGE INTO aslq901_tmp ",
               " USING( ",
               " SELECT inax017,inax010,inax011,inax013,inax015,SUM((CASE WHEN inax002 = '1' THEN 1  ELSE -1 END)*inax014) as a1 ",
               "   FROM inax_t ",
               "  WHERE inaxent = ",g_enterprise,
               "  GROUP BY inax017,inax010,inax011,inax013,inax015 ",
               " ) ",
               " ON ( "
   IF tm2.inagsite = 'Y' THEN
      LET l_sql=l_sql," inax017 = '",g_inag_d[g_detail_idx].inagsite,"' "
   ELSE
      LET l_sql=l_sql," inax017 = inagsite "
   END IF
   IF tm2.inag001 = 'Y' THEN
      LET l_sql=l_sql," AND inax010 = '",g_inag_d[g_detail_idx].inag001,"' "
   ELSE
      LET l_sql=l_sql," AND inax010 = inag001 "
   END IF
   IF tm2.inag002 = 'Y' THEN
      LET l_sql=l_sql," AND inax011 = '",g_inag_d[g_detail_idx].inag002,"' "
   ELSE
      LET l_sql=l_sql," AND inax011 = inag002 "
   END IF
   #add by geza 20161214 #161214-00002#1(S)       
   IF tm2.inag004 = 'Y' THEN
      LET l_sql=l_sql," AND inax015 = '",g_inag_d[g_detail_idx].inag004,"' "
   ELSE
      LET l_sql=l_sql," AND inax015 = inag004 "
   END IF
   IF tm2.inag007 = 'Y' THEN
      LET l_sql=l_sql," AND inax013 = '",g_inag_d[g_detail_idx].inag007,"' "
   ELSE
      LET l_sql=l_sql," AND inax013 = inag007 "
   END IF            
   LET l_sql=l_sql," ) ",          
                  " WHEN MATCHED THEN  ",
                  "    UPDATE SET inag009 = inag009+COALESCE(a1,0)  " 
   PREPARE aslq901_upd FROM l_sql
   EXECUTE aslq901_upd

   LET g_sql = " SELECT  inagsite          ,inagsite_desc     ,inag001           ,inag001_desc      ,inag001_desc_desc ,
                         imaa126           ,imaa126_desc      ,inag002           ,inag002_desc      ,inag004           ,
                         inag004_desc      ,inaa102           ,inaa120           ,inaa120_desc      ,imaa154           ,
                         imaa133           ,imaa133_desc      ,imaa156           ,imaa132           ,imaa132_desc      ,
                         imaa128           ,imaa128_desc      ,rtax001           ,rtax001_desc      ,imaa009           ,
                         imaa009_desc      ,imaa157           ,inag005           ,inag005_desc      ,inag006           ,
                         inag003           ,inag007           ,inag007_desc      ,inad014           ,inad011           ,
                         inad010           ,inad010_desc      ,inag008           ,inag009           ,inag016           ,
                         inag015           ,inag014           ,inag012           ,inag010           ,inad012 ",
               "   FROM aslq901_tmp "          
   #add by geza 20161219 #161214-00002#1(E)
   
   
   
   #add by geza 20161214 #161214-00002#1(E)
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aslq901_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR aslq901_pb2

   #OPEN b_fill_curs2 USING g_enterprise #mark by geza 20161219 #161214-00002#1
   LET l_inag008_1 = 0
   LET l_inag009_1 = 0
   LET l_ac = 1
   FOREACH b_fill_curs2 INTO g_inag2_d[l_ac].inagsite,g_inag2_d[l_ac].inagsite_desc,
                             g_inag2_d[l_ac].inag001, g_inag2_d[l_ac].inag001_desc,g_inag2_d[l_ac].inag001_desc_desc,
                             g_inag2_d[l_ac].imaa126, g_inag2_d[l_ac].imaa126_desc,
                             g_inag2_d[l_ac].inag002, g_inag2_d[l_ac].inag002_desc,
                             g_inag2_d[l_ac].inag004, g_inag2_d[l_ac].inag004_desc,
                             #150204-00013#7 150306 pomelo add(s)
                             g_inag2_d[l_ac].inaa102,g_inag2_d[l_ac].inaa120,g_inag2_d[l_ac].inaa120_desc,
                             g_inag2_d[l_ac].imaa154,g_inag2_d[l_ac].imaa133,g_inag2_d[l_ac].imaa133_desc,g_inag2_d[l_ac].imaa156,g_inag2_d[l_ac].imaa132,g_inag2_d[l_ac].imaa132_desc,g_inag2_d[l_ac].imaa128,g_inag2_d[l_ac].imaa128_desc,    #add by stcshy 161202
                             g_inag2_d[l_ac].rtax001,g_inag2_d[l_ac].rtax001_desc, #add by geza 20161215   #161214-00002#1
                             g_inag2_d[l_ac].imaa009,g_inag2_d[l_ac].imaa009_desc,g_inag2_d[l_ac].imaa157,
                             #150204-00013#7 150306 pomelo add(e)
                             g_inag2_d[l_ac].inag005, g_inag2_d[l_ac].inag005_desc,
                             g_inag2_d[l_ac].inag006, g_inag2_d[l_ac].inag003,
                             g_inag2_d[l_ac].inag007, g_inag2_d[l_ac].inag007_desc,
                             g_inag2_d[l_ac].inad014,    #160512-00004#2-add
                             g_inag2_d[l_ac].inad011,    #150204-00013#7 150306 pomelo add
                             g_inag2_d[l_ac].inad010, g_inag2_d[l_ac].inad010_desc,
                             g_inag2_d[l_ac].inag008, g_inag2_d[l_ac].inag009,
                             g_inag2_d[l_ac].inag016, g_inag2_d[l_ac].inag015,
                             g_inag2_d[l_ac].inag014, g_inag2_d[l_ac].inag012, g_inag2_d[l_ac].inag010,
                             g_inag2_d[l_ac].inad012     #150204-00013#7 150306 pomelo add

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      #mark by geza 20161219 #161214-00002#1(S)
#      LET g_inag2_d[l_ac].inag008 = g_inag2_d[l_ac].inag009 #add by geza 20161207 #161030-00006#2 #mark by geza 20161219 #161214-00002#1
#      #No:161030----------------begin      #add by stcshy 161030
#      LET l_inag009=0
#      IF tm2.inagsite = 'Y' THEN
#         LET l_inagsite=g_inag_d[g_detail_idx].inagsite
#      ELSE
#         LET l_inagsite=g_inag2_d[l_ac].inagsite
#      END IF
#      IF tm2.inag001 = 'Y' THEN
#         LET l_inag001=g_inag_d[g_detail_idx].inag001
#      ELSE
#         LET l_inag001=g_inag2_d[l_ac].inag001
#      END IF
#      IF tm2.inag002 = 'Y' THEN
#         LET l_inag002=g_inag_d[g_detail_idx].inag002
#      ELSE
#         LET l_inag002=g_inag2_d[l_ac].inag002
#      END IF
#      #add by geza 20161214 #161214-00002#1(S)       
#      IF tm2.inag004 = 'Y' THEN
#         LET l_inag004=g_inag_d[g_detail_idx].inag004
#      ELSE
#         LET l_inag004=g_inag2_d[l_ac].inag004
#      END IF
#      IF tm2.inag007 = 'Y' THEN
#         LET l_inag007=g_inag_d[g_detail_idx].inag007
#      ELSE
#         LET l_inag007=g_inag2_d[l_ac].inag007
#      END IF
      #mark by geza 20161219 #161214-00002#1(E)
      
      #add by geza 20161214 #161214-00002#1(E)
      #mark by geza 20161214 #161214-00002#1(S)       
#      LET l_sql = "SELECT SUM(inag009) FROM temp_inag",
#                  " WHERE inagsite=?",
#                  "   AND inag001=?",
#                  "   AND inag002=?",
#      #add by geza 20161214 #161214-00002#1(S)             
#                  "   AND inag004=?",
#                  "   AND inag007=?"            
#      #add by geza 20161214 #161214-00002#1(E)               
#      PREPARE aslq901_kup1 FROM l_sql
#      DECLARE aslq901_kuc1 CURSOR FOR aslq901_kup1
      #mark by geza 20161214 #161214-00002#1(E)
      #OPEN aslq901_kuc1 USING l_inagsite,l_inag001,l_inag002 #mark by geza 20161214 #161214-00002#1

      #mark by geza 20161219 #161214-00002#1(S)   
#      OPEN aslq901_kuc1 USING l_inagsite,l_inag001,l_inag002,l_inag004,l_inag007 #add by geza 20161214 #161214-00002#1 
#      FETCH aslq901_kuc1 INTO l_inag009
#      #CLOSE aslq901_kuc1
#      IF l_inag009 IS NULL THEN
#         LET l_inag009 = 0
#      END IF
#      LET g_inag2_d[l_ac].inag009=g_inag2_d[l_ac].inag009+l_inag009
      #mark by geza 20161219 #161214-00002#1(E)
#      LET l_inag008_1 = g_inag2_d[l_ac].inag008+l_inag008_1 #add by geza 20161214 #161214-00002#1
#      LET l_inag009_1 = g_inag2_d[l_ac].inag009+l_inag009_1 #add by geza 20161214 #161214-00002#1
      #No:161030------------------end

      CALL aslq901_detail_show("'2'")

      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend =  ""
            LET g_errparam.code   =  9035
            LET g_errparam.popup  = TRUE
            CALL cl_err()

         END IF
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1

   END FOREACH
   
   CALL g_inag2_d.deleteElement(g_inag2_d.getLength())
   
   #LET g_inag_d[g_detail_idx].inag008 = l_inag008_1   #add by geza 20161214 #161214-00002#1
   #LET g_inag_d[g_detail_idx].inag009 = l_inag009_1   #add by geza 20161214 #161214-00002#1
   
   LET g_error_show = 0

   LET g_detail_cnt2 = g_inag2_d.getLength()
   LET g_detail_idx2 = 1
   CLOSE b_fill_curs2
   FREE aslq901_pb2
   
   LET l_ac = li_ac

END FUNCTION

PRIVATE FUNCTION aslq901_detail_show(ps_page)
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   DEFINE l_success  LIKE type_t.num5

   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #150204-00013#7 150306 pomelo mark(s)
      ##營運組織
      #CALL s_desc_get_department_desc(g_inag_d[l_ac].inagsite) 
      # RETURNING g_inag_d[l_ac].inagsite_desc
      #
      ##商品編號
      #CALL s_desc_get_item_desc(g_inag_d[l_ac].inag001)
      # RETURNING g_inag_d[l_ac].inag001_desc,g_inag_d[l_ac].inag001_desc_desc
      #150204-00013#7 150306 pomelo mark(e)
      
      #產品特徵
      IF NOT cl_null(g_inag_d[l_ac].inag001) AND NOT cl_null( g_inag_d[l_ac].inag002) THEN
         CALL s_feature_description(g_inag_d[l_ac].inag001,g_inag_d[l_ac].inag002)
          RETURNING l_success,g_inag_d[l_ac].inag002_desc
      END IF
      #150204-00013#7 150306 pomelo mark(s)
      ##庫位
      #CALL s_desc_get_stock_desc(g_inag_d[l_ac].inagsite,g_inag_d[l_ac].inag004)
      # RETURNING g_inag_d[l_ac].inag004_desc
      #
      ##庫區類別、專櫃編號
      #SELECT inaa102,inaa120 INTO g_inag_d[l_ac].inaa102,g_inag_d[l_ac].inaa120
      # FROM inaa_t
      # WHERE inaaent = g_enterprise
      #   AND inaasite = g_inag_d[l_ac].inagsite
      #   AND inaa001 = g_inag_d[l_ac].inag004
      #
      ##商品品類
      #SELECT imaa009 INTO g_inag_d[l_ac].imaa009 FROM imaa_t
      # WHERE imaaent = g_enterprise
      #   AND imaa001 = g_inag_d[l_ac].inag001
      #
      #CALL s_desc_get_rtaxl003_desc(g_inag_d[l_ac].imaa009)
      # RETURNING g_inag_d[l_ac].imaa009_desc
      #
      ##儲位
      #CALL s_desc_get_locator_desc(g_inag_d[l_ac].inagsite,g_inag_d[l_ac].inag004,g_inag_d[l_ac].inag005)
      # RETURNING g_inag_d[l_ac].inag005_desc
      # 
      ##庫存單位
      #CALL s_desc_get_unit_desc(g_inag_d[l_ac].inag007)
      # RETURNING g_inag_d[l_ac].inag007_desc
      #
      #SELECT inad011 INTO g_inag_d[l_ac].inad011 FROM inad_t
      # WHERE inadent = g_enterprise
      #   AND inadsite = g_inag_d[l_ac].inagsite
      #   AND inad001 = g_inag_d[l_ac].inag001
      #   AND inad002 = g_inag_d[l_ac].inag002
      #   AND inad003 = g_inag_d[l_ac].inag006        
      #150204-00013#7 150306 pomelo mark(e)
      
      ##供應商
      #CALL s_desc_get_trading_partner_abbr_desc(g_inag_d[l_ac].inad010)
      # RETURNING g_inag_d[l_ac].inad010_desc
   END IF
   
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #150204-00013#7 150306 pomelo mark(s)
      ##營運組織
      #CALL s_desc_get_department_desc(g_inag2_d[l_ac].inagsite) 
      # RETURNING g_inag2_d[l_ac].inagsite_desc
      #
      ##商品編號
      #CALL s_desc_get_item_desc(g_inag2_d[l_ac].inag001)
      # RETURNING g_inag2_d[l_ac].inag001_desc,g_inag2_d[l_ac].inag001_desc_desc
      #150204-00013#7 150306 pomelo mark(e)
      
      #產品特徵
      IF NOT cl_null(g_inag2_d[l_ac].inag001) AND NOT cl_null( g_inag2_d[l_ac].inag002) THEN
         CALL s_feature_description(g_inag2_d[l_ac].inag001,g_inag2_d[l_ac].inag002)
          RETURNING l_success,g_inag2_d[l_ac].inag002_desc          
      END IF
      
      #150204-00013#7 150306 pomelo mark(s)
      ##庫位
      #CALL s_desc_get_stock_desc(g_inag2_d[l_ac].inagsite,g_inag2_d[l_ac].inag004)
      # RETURNING g_inag2_d[l_ac].inag004_desc
      #
      ##庫區類別、專櫃編號
      #SELECT inaa102,inaa120 INTO g_inag2_d[l_ac].inaa102,g_inag2_d[l_ac].inaa120
      # FROM inaa_t
      # WHERE inaaent = g_enterprise
      #   AND inaasite = g_inag2_d[l_ac].inagsite
      #   AND inaa001 = g_inag2_d[l_ac].inag004
      #
      ##商品品類
      #SELECT imaa009 INTO g_inag2_d[l_ac].imaa009 FROM imaa_t
      # WHERE imaaent = g_enterprise
      #   AND imaa001 = g_inag2_d[l_ac].inag001
      #
      #CALL s_desc_get_rtaxl003_desc(g_inag2_d[l_ac].imaa009)
      # RETURNING g_inag2_d[l_ac].imaa009_desc
      #
      ##儲位
      #CALL s_desc_get_locator_desc(g_inag2_d[l_ac].inagsite,g_inag2_d[l_ac].inag004,g_inag2_d[l_ac].inag005)
      # RETURNING g_inag2_d[l_ac].inag005_desc
      # 
      ##庫存單位
      #CALL s_desc_get_unit_desc(g_inag2_d[l_ac].inag007)
      # RETURNING g_inag2_d[l_ac].inag007_desc
      #
      #SELECT inad011,inad012 INTO g_inag2_d[l_ac].inad011,g_inag2_d[l_ac].inad012 FROM inad_t
      # WHERE inadent = g_enterprise
      #   AND inadsite = g_inag2_d[l_ac].inagsite
      #   AND inad001 = g_inag2_d[l_ac].inag001
      #   AND inad002 = g_inag2_d[l_ac].inag002
      #   AND inad003 = g_inag2_d[l_ac].inag006        
      #150204-00013#7 150306 pomelo mark(e)
      
      ##供應商
      #CALL s_desc_get_trading_partner_abbr_desc(g_inag2_d[l_ac].inad010)
      # RETURNING g_inag2_d[l_ac].inad010_desc
   END IF
   
   
END FUNCTION

PRIVATE FUNCTION aslq901_filter()

   LET INT_FLAG = 0

   LET g_qryparam.state = 'c'
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1

   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc

   #CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   #CALL gfrm_curr.setFieldHidden("formonly.b_statepic", TRUE)

   IF g_wc_filter != " 1=1" THEN
      LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   END IF

   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   #應用 qs08 樣板自動產生(Version:3)
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單頭
      CONSTRUCT g_wc_filter ON inagsite,inag001,inag002,inag004,inag005,inag006,inag003,inag007
                          FROM s_detail1[1].b_inagsite,s_detail1[1].b_inag001,s_detail1[1].b_inag002,
                              s_detail1[1].b_inag004,s_detail1[1].b_inag005,s_detail1[1].b_inag006,s_detail1[1].b_inag003,
                              s_detail1[1].b_inag007

         BEFORE CONSTRUCT
            DISPLAY aslq901_filter_parser('inagsite') TO s_detail1[1].b_inagsite
            DISPLAY aslq901_filter_parser('inag001') TO s_detail1[1].b_inag001
            DISPLAY aslq901_filter_parser('inag002') TO s_detail1[1].b_inag002
            DISPLAY aslq901_filter_parser('inag004') TO s_detail1[1].b_inag004
            DISPLAY aslq901_filter_parser('inag005') TO s_detail1[1].b_inag005
            DISPLAY aslq901_filter_parser('inag006') TO s_detail1[1].b_inag006
            DISPLAY aslq901_filter_parser('inag003') TO s_detail1[1].b_inag003
            DISPLAY aslq901_filter_parser('inag007') TO s_detail1[1].b_inag007

         ON ACTION controlp INFIELD b_inagsite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'inagsite',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
            CALL q_ooef001_24() 
            DISPLAY g_qryparam.return1 TO b_inagsite  #顯示到畫面上         
            NEXT FIELD b_inagsite                     #返回原欄位
                     
         ON ACTION controlp INFIELD b_inag001          
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_inag001()                             #呼叫開窗   #160707-00039#1 160711 by sakura mark
            CALL q_inag001_7()                           #160707-00039#1 160711 by sakura add
            DISPLAY g_qryparam.return1 TO b_inag001      #顯示到畫面上
            NEXT FIELD b_inag001                         #返回原欄位
            
         ON ACTION controlp INFIELD b_inag002          
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag002()                             #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inag002      #顯示到畫面上
            NEXT FIELD b_inag002                         #返回原欄位
            
         ON ACTION controlp INFIELD b_inag003          
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag003()                             #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inag003      #顯示到畫面上
            NEXT FIELD b_inag003                         #返回原欄位
            
         ON ACTION controlp INFIELD b_inag004          
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag004_11()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inag004      #顯示到畫面上
            NEXT FIELD b_inag004                         #返回原欄位
            
         ON ACTION controlp INFIELD b_inag005          
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag005_12()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inag005      #顯示到畫面上
            NEXT FIELD b_inag005                         #返回原欄位 
            
         ON ACTION controlp INFIELD b_inag007          
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inag007      #顯示到畫面上
            NEXT FIELD b_inag007                         #返回原欄位
            
            
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
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF

   CALL aslq901_filter_show('inagsite','b_inagsite')
   CALL aslq901_filter_show('inag001','b_inag001')
   CALL aslq901_filter_show('inag002','b_inag002')
   CALL aslq901_filter_show('inag004','b_inag004')
   CALL aslq901_filter_show('inag005','b_inag005')
   CALL aslq901_filter_show('inag006','b_inag006')
   CALL aslq901_filter_show('inag003','b_inag003')
   CALL aslq901_filter_show('inag007','b_inag007')

  #CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
  #CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)

END FUNCTION

PRIVATE FUNCTION aslq901_filter_parser(ps_field)
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}

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

PRIVATE FUNCTION aslq901_filter_show(ps_field,ps_object)
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING

   LET ls_name = "formonly.", ps_object

   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LET ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF

   #顯示資料組合
   LET ls_condition = aslq901_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF

   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)

END FUNCTION
#控制欄位的顯示
PRIVATE FUNCTION aslq901_comp_visible()
   CALL cl_set_comp_visible("b_inagsite,b_inagsite_desc",TRUE)
   CALL cl_set_comp_visible("b_inagsite_1,b_inagsite_1_desc",TRUE)
   IF tm2.inagsite = 'Y' THEN
      CALL cl_set_comp_visible("b_inagsite_1,b_inagsite_1_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_inagsite,b_inagsite_desc",FALSE)
   END IF

   CALL cl_set_comp_visible("b_inag001,b_inag001_desc,b_inag001_desc_desc",TRUE)
   CALL cl_set_comp_visible("b_inag001_1,b_inag001_1_desc,b_inag001_1_desc_desc",TRUE)
   IF tm2.inag001 = 'Y' THEN
      CALL cl_set_comp_visible("b_inag001_1,b_inag001_1_desc,b_inag001_1_desc_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_inag001,b_inag001_desc,b_inag001_desc_desc",FALSE)
   END IF

   CALL cl_set_comp_visible("b_inag002,b_inag002_desc",TRUE)
   CALL cl_set_comp_visible("b_inag002_1,b_inag002_1_desc",TRUE)
   IF tm2.inag002 = 'Y' THEN
      CALL cl_set_comp_visible("b_inag002_1,b_inag002_1_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_inag002,b_inag002_desc",FALSE)
   END IF

   CALL cl_set_comp_visible("b_inag003",TRUE)
   CALL cl_set_comp_visible("b_inag003_1",TRUE)
   IF tm2.inag003 = 'Y' THEN
      CALL cl_set_comp_visible("b_inag003_1",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_inag003",FALSE)
   END IF

   CALL cl_set_comp_visible("b_inag004_1,b_inag004_1_desc,l_inaa102_1,l_inaa120_1,l_inaa120_1_desc",TRUE)
   CALL cl_set_comp_visible("b_inag004,b_inag004_desc,l_inaa102,l_inaa120,l_inaa120_desc",TRUE)
   IF tm2.inag004 = 'Y' THEN
      CALL cl_set_comp_visible("b_inag004_1,b_inag004_1_desc,l_inaa102_1,l_inaa120_1,l_inaa120_1_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_inag004,b_inag004_desc,l_inaa102,l_inaa120,l_inaa120_desc",FALSE)
   END IF

   CALL cl_set_comp_visible("b_inag005,b_inag005_desc",TRUE)
   CALL cl_set_comp_visible("b_inag005_1,b_inag005_1_desc",TRUE)
   IF tm2.inag005 = 'Y' THEN
      CALL cl_set_comp_visible("b_inag005_1,b_inag005_1_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_inag005,b_inag005_desc",FALSE)
   END IF

   CALL cl_set_comp_visible("b_inag006",TRUE)
   CALL cl_set_comp_visible("b_inag006_1",TRUE)
   IF tm2.inag006 = 'Y' THEN
      CALL cl_set_comp_visible("b_inag006_1",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_inag006",FALSE)
   END IF

   CALL cl_set_comp_visible("b_inag007,b_inag007_desc",TRUE)
   CALL cl_set_comp_visible("b_inag007_1,b_inag007_1_desc",TRUE)
   IF tm2.inag007 = 'Y' THEN
      CALL cl_set_comp_visible("b_inag007_1,b_inag007_1_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_inag007,b_inag007_desc",FALSE)
   END IF
   
   #160512-00004#2-add-(S)
   CALL cl_set_comp_visible("l_inad014_d1",TRUE)
   CALL cl_set_comp_visible("l_inad014_d2",TRUE)
   IF tm2.inad014 = 'Y' THEN
      CALL cl_set_comp_visible("l_inad014_d2",FALSE)
   ELSE
      CALL cl_set_comp_visible("l_inad014_d1",FALSE)
   END IF
   #160512-00004#2-add-(E)
   
   CALL cl_set_comp_visible("l_inad011_d1",TRUE)
   CALL cl_set_comp_visible("l_inad011_d2",TRUE)
   IF tm2.inad011 = 'Y' THEN
      CALL cl_set_comp_visible("l_inad011_d2",FALSE)
   ELSE
      CALL cl_set_comp_visible("l_inad011_d1",FALSE)
   END IF

   CALL cl_set_comp_visible("l_imaa009_d1,l_imaa009_d1_desc",TRUE)
   CALL cl_set_comp_visible("l_imaa009_d2,l_imaa009_d2_desc",TRUE)
   IF tm2.imaa009 = 'Y' THEN
      CALL cl_set_comp_visible("l_imaa009_d2,l_imaa009_d2_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("l_imaa009_d1,l_imaa009_d1_desc",FALSE)
   END IF
   
   CALL cl_set_comp_visible("l_inad010_d1,l_inad010_d1_desc",TRUE)
   CALL cl_set_comp_visible("l_inad010_d2,l_inad010_d2_desc",TRUE)
   IF tm2.inad010 = 'Y' THEN
      CALL cl_set_comp_visible("l_inad010_d2,l_inad010_d2_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("l_inad010_d1,l_inad010_d1_desc",FALSE)
   END IF
   
   CALL cl_set_comp_visible("l_imaa126_d1,l_imaa126_d1_desc",TRUE)
   CALL cl_set_comp_visible("l_imaa126_d2,l_imaa126_d2_desc",TRUE)
   IF tm2.imaa126 = 'Y' THEN
      CALL cl_set_comp_visible("l_imaa126_d2,l_imaa126_d2_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("l_imaa126_d1,l_imaa126_d1_desc",FALSE)
   END IF

   #No:161202---------------begin   #add by stcshy 161202
   CALL cl_set_comp_visible("l_imaa154_d1",TRUE)
   CALL cl_set_comp_visible("l_imaa154_d2",TRUE)
   IF tm2.imaa154 = 'Y' THEN
      CALL cl_set_comp_visible("l_imaa154_d2",FALSE)
   ELSE
      CALL cl_set_comp_visible("l_imaa154_d1",FALSE)
   END IF

   CALL cl_set_comp_visible("l_imaa133_d1,l_imaa133_desc_d1",TRUE)
   CALL cl_set_comp_visible("l_imaa133_d2,l_imaa133_desc_d2",TRUE)
   IF tm2.imaa133 = 'Y' THEN
      CALL cl_set_comp_visible("l_imaa133_d2,l_imaa133_desc_d2",FALSE)
   ELSE
      CALL cl_set_comp_visible("l_imaa133_d1,l_imaa133_desc_d1",FALSE)
   END IF

   CALL cl_set_comp_visible("l_imaa156_d1",TRUE)
   CALL cl_set_comp_visible("l_imaa156_d2",TRUE)
   IF tm2.imaa156 = 'Y' THEN
      CALL cl_set_comp_visible("l_imaa156_d2",FALSE)
   ELSE
      CALL cl_set_comp_visible("l_imaa156_d1",FALSE)
   END IF

   CALL cl_set_comp_visible("l_imaa132_d1,l_imaa132_desc_d1",TRUE)
   CALL cl_set_comp_visible("l_imaa132_d2,l_imaa132_desc_d2",TRUE)
   IF tm2.imaa132 = 'Y' THEN
      CALL cl_set_comp_visible("l_imaa132_d2,l_imaa132_desc_d2",FALSE)
   ELSE
      CALL cl_set_comp_visible("l_imaa132_d1,l_imaa132_desc_d1",FALSE)
   END IF

   CALL cl_set_comp_visible("l_imaa128_d1,l_imaa128_desc_d1",TRUE)
   CALL cl_set_comp_visible("l_imaa128_d2,l_imaa128_desc_d2",TRUE)
   IF tm2.imaa128 = 'Y' THEN
      CALL cl_set_comp_visible("l_imaa128_d2,l_imaa128_desc_d2",FALSE)
   ELSE
      CALL cl_set_comp_visible("l_imaa128_d1,l_imaa128_desc_d1",FALSE)
   END IF
   #No:161202-----------------end
   #add by geza 20161215   #161214-00002#1(S)
   CALL cl_set_comp_visible("b_rtax001,b_rtax001_desc",TRUE)
   CALL cl_set_comp_visible("b_rtax001_1,b_rtax001_1_desc",TRUE)
   IF tm2.rtax001 = 'Y' THEN
      CALL cl_set_comp_visible("b_rtax001_1,b_rtax001_1_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_rtax001,b_rtax001_desc",FALSE)
   END IF
   #add by geza 20161215   #161214-00002#1(E)
END FUNCTION

PRIVATE FUNCTION aslq901_get_inag009()
DEFINE l_sql                 STRING 
DEFINE l_inbq002             LIKE inbq_t.inbq002     
DEFINE l_inbq003             LIKE inbq_t.inbq003
DEFINE l_str                 STRING
DEFINE l_inag001             STRING
DEFINE l_inag002             STRING
DEFINE l_inagsite            STRING

   IF tm2.inagsite = 'Y' THEN
      LET l_inagsite="'",g_inag_d[g_detail_idx].inagsite,"'"
   ELSE
      LET l_inagsite="inagsite"
   END IF
   IF tm2.inag001 = 'Y' THEN
      LET l_inag001="'",g_inag_d[g_detail_idx].inag001,"'"
   ELSE
      LET l_inag001="inag001"
   END IF
   IF tm2.inag002 = 'Y' THEN
      LET l_inag002="'",g_inag_d[g_detail_idx].inag002,"'"
   ELSE
      LET l_inag002="inag002"
   END IF

   LET l_str = NULL
   LET l_sql = "SELECT inbq002,inbq003 FROM inbq_t WHERE inbqent='",g_enterprise,"'"    
   PREPARE s_get_inag009_pb FROM l_sql
   DECLARE s_get_inag009_cs CURSOR FOR  s_get_inag009_pb
   FOREACH s_get_inag009_cs  INTO l_inbq002,l_inbq003
      IF l_inbq002='2' THEN
         IF l_inbq003='1' THEN
            LET l_str=l_str,'+'
         ELSE
            LET l_str=l_str,'-'
         END IF
         LET l_str = l_str,"NVL(",
                     "(SELECT SUM(xmja014) FROM xmja_t,xmda_t " ,  
                     "  WHERE xmjaent= ",g_enterprise," AND xmjaent = xmdaent ",
                     "    AND xmjadocno = xmdadocno AND xmdastus = 'Y'",
                     "    AND xmja003 = ",l_inag001," AND xmja004 = ",l_inag002,
                     "    AND xmdasite IN (SELECT ooed004 FROM ooed_t START WITH ooed005 = ",l_inagsite," AND ooed001 = '11' ",
                     "                        AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
                     "                    CONNECT BY nocycle PRIOR ooed004=ooed005 AND ooed001 = '11' ",
                     "                        AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
                     "                      UNION SELECT ooed004 FROM ooed_t WHERE ooed004 = ",l_inagsite,") ",
                     "    AND  EXISTS (SELECT 1 FROM pmcz_t WHERE pmczent = xmdaent AND pmcz001 = xmdadocno AND ((pmcz065 = 0 AND pmcz065 IS NOT NULL) OR pmcz065 IS NULL))),0)"
      END IF

      IF l_inbq002='14' THEN
         IF l_inbq003='1' THEN
            LET l_str=l_str,'+'
         ELSE
            LET l_str=l_str,'-'
         END IF
         LET l_str = l_str,"NVL(",
                     "(SELECT SUM(pmdb006) FROM pmda_t,pmdb_t ",   
                     "  WHERE pmdaent= ",g_enterprise," AND pmdaent = pmdbent ",
                     "    AND pmdadocno = pmdbdocno AND pmdastus = 'Y'",
                     "    AND pmdb004 = ",l_inag001," AND pmdb005 = ",l_inag002,
                     "    AND pmdasite IN (SELECT ooed004 FROM ooed_t START WITH ooed005 = ",l_inagsite," AND ooed001 = '11' ",
                     "                        AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
                     "                    CONNECT BY nocycle PRIOR ooed004=ooed005 AND ooed001 = '11' ",
                     "                        AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
                     "                      UNION SELECT ooed004 FROM ooed_t WHERE ooed004 = ",l_inagsite,") ",
                     "    AND  EXISTS (SELECT 1 FROM pmcz_t WHERE pmczent = pmdaent AND pmcz001 = pmdadocno AND ((pmcz065 = 0 AND pmcz065 IS NOT NULL) OR pmcz065 IS NULL))),0)"
      END IF

      IF l_inbq002='15' THEN
         IF l_inbq003='1' THEN
            LET l_str=l_str,'+'
         ELSE
            LET l_str=l_str,'-'
         END IF
         LET l_str = l_str,"NVL(",
                     "(SELECT SUM(pmcp004) FROM pmco_t,pmcp_t " ,  
                     "  WHERE pmcoent= ",g_enterprise," AND pmcoent = pmcpent ",
                     "    AND pmcodocno = pmcpdocno AND pmcostus = 'Y' ",
                     "    AND pmcp001 = ",l_inag001," AND pmcp003 = ",l_inag002,
                     "    AND pmcosite IN (SELECT ooed004 FROM ooed_t START WITH ooed005 = ",l_inagsite," AND ooed001 = '11' ",
                     "                        AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
                     "                    CONNECT BY nocycle PRIOR ooed004=ooed005 AND ooed001 = '11' ",
                     "                        AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
                     "                      UNION SELECT ooed004 FROM ooed_t WHERE ooed004 = ",l_inagsite,") ",
                     "    AND  EXISTS (SELECT 1 FROM pmcz_t WHERE pmczent = pmcoent AND pmcz001 = pmcodocno AND ((pmcz065 = 0 AND pmcz065 IS NOT NULL) OR pmcz065 IS NULL))),0)"
      END IF

      IF l_inbq002='16' THEN
         IF l_inbq003='1' THEN
            LET l_str=l_str,'+'
         ELSE
            LET l_str=l_str,'-'
         END IF
         LET l_str = l_str,"NVL(",
                     "(SELECT SUM(pmcz008-pmcz051) FROM pmcz_t " ,  
                     "  WHERE pmczent= ",g_enterprise,"  ",
                     "    AND pmcz004 = ",l_inag001," AND pmcz005 = ",l_inag002,
                     "    AND pmczsite IN (SELECT ooed004 FROM ooed_t START WITH ooed005 = ",l_inagsite," AND ooed001 = '11' ",
                     "                        AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
                     "                    CONNECT BY nocycle PRIOR ooed004=ooed005 AND ooed001 = '11' ",
                     "                        AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
                     "                      UNION SELECT ooed004 FROM ooed_t WHERE ooed004 = ",l_inagsite,") ",
                     "    AND ((pmcz065 = 0 AND pmcz065 IS NOT NULL) OR pmcz065 IS NULL) ",
                     "    AND EXISTS (SELECT 1 FROM indi_t,indj_t WHERE indient = indjent AND indidocno = indjdocno AND indistus = 'Y' AND pmcz001 = indj001 AND indj002 = pmcz002 )),0)"
      END IF
   END FOREACH

   RETURN l_str
END FUNCTION

PRIVATE FUNCTION aslq901_tpu()
DEFINE l_sql                 STRING 
DEFINE l_inbq002             LIKE inbq_t.inbq002     
DEFINE l_inbq003             LIKE inbq_t.inbq003
DEFINE l_str                 STRING
DEFINE l_inag001             STRING
DEFINE l_inag002             STRING
DEFINE l_inagsite            STRING
   #mark by geza #161214-00002#1(S)
#   LET l_str = '0'
#   LET l_sql = "SELECT inbq002,inbq003 FROM inbq_t WHERE inbqent='",g_enterprise,"'"    
#   PREPARE s_get_inag009_pb1 FROM l_sql
#   DECLARE s_get_inag009_cs1 CURSOR FOR  s_get_inag009_pb1
#   FOREACH s_get_inag009_cs1  INTO l_inbq002,l_inbq003
#      IF l_inbq002='2' THEN
#         IF l_inbq003='1' THEN
#            LET l_str=l_str,'+'
#         ELSE
#            LET l_str=l_str,'-'
#         END IF
#         LET l_str = l_str,"NVL(",
#                     "(SELECT SUM(xmja014) FROM xmja_t,xmda_t " ,  
#                     "  WHERE xmjaent= ",g_enterprise," AND xmjaent = xmdaent ",
#                     "    AND xmjadocno = xmdadocno AND xmdastus = 'Y'",
#                     "    AND xmja003 = inag001 AND xmja004 = inag002",
#                     "    AND xmdasite IN (SELECT ooed004 FROM ooed_t START WITH ooed005 = inagsite AND ooed001 = '11' ",
#                     "                        AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
#                     "                    CONNECT BY nocycle PRIOR ooed004=ooed005 AND ooed001 = '11' ",
#                     "                        AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
#                     "                      UNION SELECT ooed004 FROM ooed_t WHERE ooed004 = inagsite) ",
#                     "    AND  EXISTS (SELECT 1 FROM pmcz_t WHERE pmczent = xmdaent AND pmcz001 = xmdadocno AND ((pmcz065 = 0 AND pmcz065 IS NOT NULL) OR pmcz065 IS NULL))),0)"
#      END IF
#
#      IF l_inbq002='14' THEN
#         IF l_inbq003='1' THEN
#            LET l_str=l_str,'+'
#         ELSE
#            LET l_str=l_str,'-'
#         END IF
#         LET l_str = l_str,"NVL(",
#                     "(SELECT SUM(pmdb006) FROM pmda_t,pmdb_t ",   
#                     "  WHERE pmdaent= ",g_enterprise," AND pmdaent = pmdbent ",
#                     "    AND pmdadocno = pmdbdocno AND pmdastus = 'Y'",
#                     "    AND pmdb004 = inag001 AND pmdb005 = inag002",
#                     "    AND pmdasite IN (SELECT ooed004 FROM ooed_t START WITH ooed005 = inagsite AND ooed001 = '11' ",
#                     "                        AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
#                     "                    CONNECT BY nocycle PRIOR ooed004=ooed005 AND ooed001 = '11' ",
#                     "                        AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
#                     "                      UNION SELECT ooed004 FROM ooed_t WHERE ooed004 = inagsite) ",
#                     "    AND  EXISTS (SELECT 1 FROM pmcz_t WHERE pmczent = pmdaent AND pmcz001 = pmdadocno AND ((pmcz065 = 0 AND pmcz065 IS NOT NULL) OR pmcz065 IS NULL))),0)"
#      END IF
#
#      IF l_inbq002='15' THEN
#         IF l_inbq003='1' THEN
#            LET l_str=l_str,'+'
#         ELSE
#            LET l_str=l_str,'-'
#         END IF
#         LET l_str = l_str,"NVL(",
#                     "(SELECT SUM(pmcp004) FROM pmco_t,pmcp_t " ,  
#                     "  WHERE pmcoent= ",g_enterprise," AND pmcoent = pmcpent ",
#                     "    AND pmcodocno = pmcpdocno AND pmcostus = 'Y' ",
#                     "    AND pmcp001 = inag001 AND pmcp003 = inag002",
#                     "    AND pmcosite IN (SELECT ooed004 FROM ooed_t START WITH ooed005 = inagsite AND ooed001 = '11' ",
#                     "                        AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
#                     "                    CONNECT BY nocycle PRIOR ooed004=ooed005 AND ooed001 = '11' ",
#                     "                        AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
#                     "                      UNION SELECT ooed004 FROM ooed_t WHERE ooed004 = inagsite) ",
#                     "    AND  EXISTS (SELECT 1 FROM pmcz_t WHERE pmczent = pmcoent AND pmcz001 = pmcodocno AND ((pmcz065 = 0 AND pmcz065 IS NOT NULL) OR pmcz065 IS NULL))),0)"
#      END IF
#
#      IF l_inbq002='16' THEN
#         IF l_inbq003='1' THEN
#            LET l_str=l_str,'+'
#         ELSE
#            LET l_str=l_str,'-'
#         END IF
#         LET l_str = l_str,"NVL(",
#                     "(SELECT SUM(pmcz008-pmcz051) FROM pmcz_t " ,  
#                     "  WHERE pmczent= ",g_enterprise,"  ",
#                     "    AND pmcz004 = inag001 AND pmcz005 = inag002",
#                     "    AND pmczsite IN (SELECT ooed004 FROM ooed_t START WITH ooed005 = inagsite AND ooed001 = '11' ",
#                     "                        AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
#                     "                    CONNECT BY nocycle PRIOR ooed004=ooed005 AND ooed001 = '11' ",
#                     "                        AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
#                     "                      UNION SELECT ooed004 FROM ooed_t WHERE ooed004 = inagsite) ",
#                     "    AND ((pmcz065 = 0 AND pmcz065 IS NOT NULL) OR pmcz065 IS NULL) ",
#                     "    AND EXISTS (SELECT 1 FROM indi_t,indj_t WHERE indient = indjent AND indidocno = indjdocno AND indistus = 'Y' AND pmcz001 = indj001 AND indj002 = pmcz002 )),0)"
#      END IF
#   END FOREACH
#
#   LET l_sql = "UPDATE temp_inag SET inag009=",l_str
   #mark by geza #161214-00002#1(E)
   
   #add by geza #161214-00002#1(S)
#   LET l_str = '0 + '
#   LET l_str = l_str,"NVL(",
#               " (SELECT SUM((CASE WHEN inax002 = '1' THEN 1  ELSE -1 END)*inax014) ",
#               "   FROM inax_t ",
#               "  WHERE inaxent = ",g_enterprise," ",
#               #"    AND inax001 = '2' ",
#               "    AND inax010 = inag001",
#               "    AND inax011 = inag002",
#               "    AND inax013 = inag007",
#               "    AND inax015 = inag004",
#               "    AND inax017 = inagsite),0)"
#    
#
#   LET l_sql = "UPDATE temp_inag SET inag009=",l_str
   
   LET l_sql = " MERGE INTO temp_inag ",
               " USING( ",
               " SELECT inax017,inax010,inax011,inax013,inax015,SUM((CASE WHEN inax002 = '1' THEN 1  ELSE -1 END)*inax014) as a1 ",
               "   FROM inax_t ",
               "  WHERE inaxent = ",g_enterprise,
               "  GROUP BY inax017,inax010,inax011,inax013,inax015 ",
               " ) ",
               " ON (inax010 = inag001 AND inax011 = inag002 AND inax013 = inag007 AND inax015 = inag004 AND inax017 = inagsite) ",
               " WHEN MATCHED THEN  ",
               "    UPDATE SET inag009 = 0+COALESCE(a1,0)  " 
   #add by geza #161214-00002#1(E)
   
   PREPARE aslq901_tpu FROM l_sql
   EXECUTE aslq901_tpu
END FUNCTION

################################################################################
# Descriptions...: 建立暫存表
# Memo...........:
# Usage..........: CALL aslq901_create_tmp()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2016/12/19 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION aslq901_create_tmp()
   DEFINE r_success          LIKE type_t.num5
   DEFINE l_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE   
   LET r_success = TRUE
   
   CALL aslq901_drop_tmp()
  
   CREATE TEMP TABLE aslq901_tmp(         
       inagsite           LIKE inag_t.inagsite,
       inagsite_desc      LIKE type_t.chr500,
       inag001            LIKE inag_t.inag001,
       inag001_desc       LIKE type_t.chr500,
       inag001_desc_desc  LIKE type_t.chr500,
       imaa126            LIKE imaa_t.imaa126,
       imaa126_desc       LIKE type_t.chr500,   
       inag002            LIKE inag_t.inag002,
       inag002_desc       LIKE type_t.chr500,
       inad010            LIKE inad_t.inad010,
       inad010_desc       LIKE type_t.chr500,
       inag004            LIKE inag_t.inag004,
       inag004_desc       LIKE type_t.chr500,
       inaa102            LIKE inaa_t.inaa102,
       imaa154            LIKE imaa_t.imaa154,
       imaa133            LIKE imaa_t.imaa133,
       imaa133_desc       LIKE type_t.chr500,
       imaa156            LIKE imaa_t.imaa156,
       imaa132            LIKE imaa_t.imaa132,
       imaa132_desc       LIKE type_t.chr500,
       imaa128            LIKE imaa_t.imaa128,
       imaa128_desc       LIKE type_t.chr500,
       rtax001            LIKE rtax_t.rtax001,  
       rtax001_desc       LIKE type_t.chr500,  
       imaa009            LIKE imaa_t.imaa009,
       imaa009_desc       LIKE type_t.chr500,
       imaa157            LIKE imaa_t.imaa157,
       inaa120            LIKE inaa_t.inaa120,
       inaa120_desc       LIKE type_t.chr500,
       inag005            LIKE inag_t.inag005,
       inag005_desc       LIKE type_t.chr500,
       inag006            LIKE inag_t.inag006,
       inag003            LIKE inag_t.inag003,
       inag007            LIKE inag_t.inag007,
       inag007_desc       LIKE type_t.chr500,
       inad014            LIKE inad_t.inad014,   
       inad011            LIKE inad_t.inad011,
       inag008            LIKE inag_t.inag008,
       inag009            LIKE inag_t.inag009,
       inag016            LIKE inag_t.inag016,
       inag015            LIKE inag_t.inag015,
       inag014            LIKE inag_t.inag014,
       inag012            LIKE inag_t.inag012,
       inag010            LIKE inag_t.inag010,
       inad012            LIKE inad_t.inad012 )
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Create aslq901_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF 
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 刪除暫存檔
# Memo...........:
# Usage..........: CALL aslq901_drop_tmp()
# Input parameter: 
# Return code....:
# Date & Author..: 2016/12/19 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION aslq901_drop_tmp()
   
   WHENEVER ERROR CONTINUE   
   
   DROP TABLE aslq901_tmp 
END FUNCTION

#end add-point
 
{</section>}
 
