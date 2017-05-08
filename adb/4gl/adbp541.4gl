#該程式未解開Section, 採用最新樣板產出!
{<section id="adbp541.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0012(2017-01-18 09:43:18), PR版次:0012(2017-01-19 18:29:32)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000137
#+ Filename...: adbp541
#+ Description: 出通單轉出貨單批次處理作業
#+ Creator....: 02748(2014-06-10 09:42:25)
#+ Modifier...: 02749 -SD/PR- 02749
 
{</section>}
 
{<section id="adbp541.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160729-00027#2  2016/08/02 By Lori   校能調整
#160809-00015#1  2016/08/29 by lori   訂單/出通單單號開窗依aooi500過濾組織, r.q 移除 ooed_t 相關設定 
#161230-00039#1  2016/12/30 by lori   勾選出通單時檢查是否有其他人正在使用並報錯
#170109-00037#4  2017/01/17 by lori   1.承161230-00039#1處理內容,調整報錯統一使用彙總模式
#                                     2.指標或筆數統計變數型態調整為num10
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc" 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10              
DEFINE l_ac_d               LIKE type_t.num10             #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num10             #目前所在頁數
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num10
 
TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable) name="global.parameter"
   
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
            sel               LIKE type_t.chr1,
            xmda202           LIKE xmda_t.xmda202,
            xmda202_desc      LIKE ooefl_t.ooefl003,
            xmdgdocno         LIKE xmdg_t.xmdgdocno,
            xmdhseq           LIKE xmdh_t.xmdhseq,
            xmdg001           LIKE xmdg_t.xmdg001,
            xmdg005           LIKE xmdg_t.xmdg005,
            xmdg005_desc      LIKE pmaal_t.pmaal004,
            xmdg006           LIKE xmdg_t.xmdg006,
            xmdg006_desc      LIKE pmaal_t.pmaal004,
            xmdg007           LIKE xmdg_t.xmdg007,
            xmdg007_desc      LIKE pmaal_t.pmaal004,
            xmdhunit          LIKE xmdh_t.xmdhunit,
            xmdhunit_desc     LIKE ooefl_t.ooefl003,
            xmdh201           LIKE xmdh_t.xmdh201,
            xmdh006           LIKE xmdh_t.xmdh006,
            xmdh006_desc      LIKE imaal_t.imaal003,
            xmdh006_desc_desc LIKE imaal_t.imaal004, 
            xmdh007           LIKE xmdh_t.xmdh007,
            xmdh202           LIKE xmdh_t.xmdh202,
            xmdh202_desc      LIKE oocal_t.oocal003,
            xmdh203           LIKE xmdh_t.xmdh203,
            xmdh015           LIKE xmdh_t.xmdh015,
            xmdh015_desc      LIKE oocal_t.oocal003,
            xmdh016           LIKE xmdh_t.xmdh016,
            xmdh018           LIKE xmdh_t.xmdh018,
            xmdh018_desc      LIKE oocal_t.oocal003,
            xmdh019           LIKE xmdh_t.xmdh019,
            xmdc012           LIKE xmdc_t.xmdc012,
            xmdh211           LIKE xmdh_t.xmdh211,
            xmdh211_desc      LIKE pmaal_t.pmaal004,
            xmdh213           LIKE xmdh_t.xmdh213,
            xmdh213_desc      LIKE oofb_t.oofb011,
            xmdh214           LIKE xmdh_t.xmdh214,
            xmdh214_desc      LIKE dbadl_t.dbadl003,
            xmdh030           LIKE xmdh_t.xmdh030,
            xmdh219           LIKE xmdh_t.xmdh219,
            xmdh219_desc      LIKE dbbcl_t.dbbcl003,
            xmdh050           LIKE xmdh_t.xmdh050,

            xmdgsite          LIKE xmdg_t.xmdgsite,
            xmdh212           LIKE xmdh_t.xmdh212
                     END RECORD
DEFINE g_xmdg001            LIKE xmdg_t.xmdg001
DEFINE g_xmdg028            LIKE xmdg_t.xmdg028
DEFINE g_xmdhunit           LIKE xmdh_t.xmdhunit
DEFINE g_construct_display  RECORD 
            xmdg005           LIKE xmdg_t.xmdg005,
            xmdg201           LIKE xmdg_t.xmdg201,
            xmdh212           LIKE xmdh_t.xmdh212,
            xmdh213           LIKE xmdh_t.xmdh213,
            xmdh214           LIKE xmdh_t.xmdh214,
            xmdg001           LIKE xmdg_t.xmdg001,
            xmdgdocno         LIKE xmdg_t.xmdgdocno,
            xmdg028           LIKE xmdg_t.xmdg028
                     END RECORD
DEFINE g_detail_d_t type_g_detail_d
DEFINE g_detail_d_o type_g_detail_d
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="adbp541.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
   #add-point:main段define name="main.define"
   DEFINE l_success    LIKE type_t.num5
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
 
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("adb","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adbp541 WITH FORM cl_ap_formpath("adb",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adbp541_init()   
 
      #進入選單 Menu (="N")
      CALL adbp541_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_adbp541
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success #150308-00001#1  By Ken 150309   
   CALL s_adbp541_drop_temp_table() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="adbp541.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION adbp541_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   DEFINE l_success     LIKE type_t.num5
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success #150308-00001#1  By Ken 150309  
   CALL cl_set_combo_scc_part('xmdg001','2063','1,2,3,6')
   CALL cl_set_combo_scc_part('b_xmdg001','2063','1,2,3,6')
   CALL s_adbp541_create_temp_table() RETURNING l_success
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="adbp541.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION adbp541_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
  #DEFINE l_cnt       LIKE type_t.num5        #170109-00037#5 170118 by lori mark
   DEFINE l_cnt       LIKE type_t.num5        #170109-00037#5 170118 by lori add
   DEFINE l_str       STRING
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_qty       LIKE xmdh_t.xmdh016
   DEFINE l_xmdh019   LIKE xmdh_t.xmdh019
   DEFINE l_msg       STRING       
   DEFINE l_where     STRING                  #160809-00015#1 160829 by lori add  
   DEFINE l_xmdhdocno LIKE xmdh_t.xmdhdocno   #161230-00039#1 161230 by lori add
   DEFINE l_xmdhseq   LIKE xmdh_t.xmdhseq     #161230-00039#1 161230 by lori add   
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   INITIALIZE g_construct_display.* TO NULL
   LET g_construct_display.xmdg028 = ''
   LET g_construct_display.xmdg001 = '1'
   
   #161230-00039#1 161230 by lori add---(S)
   LET g_sql = "SELECT xmdhdocno,xmdhseq FROM xmdh_t ",
               " WHERE xmdhent = ",g_enterprise,
               "   AND xmdhdocno = ? ",
               "   AND xmdhseq = ? ",
               "   FOR UPDATE SKIP LOCKED "
   PREPARE adbp541_chk_lock_xmdh FROM g_sql
   #161230-00039#1 161230 by lori add---(E)   
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL adbp541_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc  ON xmdg005,xmdg201,xmdgdocno
            BEFORE CONSTRUCT
               #CALL cl_set_act_visible("batch_execute", TRUE)
               #CALL cl_set_act_visible("sel,unsel,selall,selnone", FALSE)
               LET g_xmdhunit = g_site
               DISPLAY g_xmdhunit TO xmdhunit
               
            AFTER CONSTRUCT
               LET g_construct_display.xmdg005 = GET_FLDBUF(xmdg005)
               LET g_construct_display.xmdg201 = GET_FLDBUF(xmdg201)
               LET g_construct_display.xmdgdocno = GET_FLDBUF(xmdgdocno)

                
            ON ACTION controlp INFIELD xmdg005
               #開窗c段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = 'ALL'			      
               CALL q_pmaa001_6()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdg005        #顯示到畫面上
               NEXT FIELD xmdg005                           #返回原欄位
            
            ON ACTION controlp INFIELD xmdg201
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_pmaa001_10()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdg201        #顯示到畫面上
               NEXT FIELD xmdg201                           #返回原欄位
    
            ON ACTION controlp INFIELD xmdgdocno
               #開窗c段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE

              #CALL q_xmdgdocno_1()      #160809-00015#1 160829 by lori mark      

			     #160809-00015#1 160829 by lori add---(S)
              LET l_where = ""
              LET l_where = s_aooi500_q_where('adbt520','xmdgunit',g_site,'c')
              LET l_where = cl_str_replace(l_where,"ooef001","xmdgunit")
              LET g_qryparam.where = l_where
              
              CALL q_xmdgdocno_2()           
              #160809-00015#1 160829 by lori add---(E)
            
               DISPLAY g_qryparam.return1 TO xmdgdocno    
               NEXT FIELD xmdgdocno                       

         END CONSTRUCT
         
         CONSTRUCT BY NAME g_wc2 ON xmdh212,xmdh213,xmdh214
             BEFORE CONSTRUCT
                #CALL cl_set_act_visible("batch_execute", TRUE)
                #CALL cl_set_act_visible("sel,unsel,selall,selnone", FALSE)
                LET g_xmdhunit = g_site
                DISPLAY g_xmdhunit TO xmdhunit
               
            AFTER CONSTRUCT
               LET g_construct_display.xmdh212 = GET_FLDBUF(xmdh212)
               LET g_construct_display.xmdh213 = GET_FLDBUF(xmdh213)
               LET g_construct_display.xmdh214 = GET_FLDBUF(xmdh214)
             
             ON ACTION controlp INFIELD xmdh212
                #開窗c段
			       INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
			       LET g_qryparam.reqry = FALSE
                CALL q_pmac002_4()                       #呼叫開窗
                DISPLAY g_qryparam.return1 TO xmdh212    #顯示到畫面上
                NEXT FIELD xmdh212                       #返回原欄位
    
             ON ACTION controlp INFIELD xmdh213
                #開窗c段
			       INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
			       LET g_qryparam.reqry = FALSE
                CALL q_oofb019_2()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO xmdh213        #顯示到畫面上
                NEXT FIELD xmdh213                           #返回原欄位

             ON ACTION controlp INFIELD xmdh214
                #開窗c段
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                CALL q_dbad001()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO xmdh214      #顯示到畫面上
                NEXT FIELD xmdh214                         #返回原欄位
    

         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT g_xmdg001,g_xmdhunit,g_xmdg028 FROM xmdg001,xmdhunit,xmdg028
            BEFORE INPUT
               #CALL cl_set_act_visible("batch_execute", TRUE)
               #CALL cl_set_act_visible("sel,unsel,selall,selnone", FALSE)
               LET g_xmdhunit = g_site
               DISPLAY g_xmdhunit TO xmdhunit
               
            AFTER INPUT 
               LET g_construct_display.xmdg001 = GET_FLDBUF(xmdg001)
               LET g_construct_display.xmdg028 = GET_FLDBUF(xmdg028)
         END INPUT
         
         INPUT ARRAY g_detail_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                     INSERT ROW = FALSE,DELETE ROW = FALSE, APPEND ROW = FALSE)
            BEFORE INPUT 
               #CALL cl_set_act_visible("batch_execute", FALSE)
               #CALL cl_set_act_visible("sel,unsel,selall,selnone", TRUE)
            
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_master_idx = l_ac
               LET g_detail_d_o.* = g_detail_d[l_ac].*
               LET g_detail_d_t.* = g_detail_d[l_ac].*
               DISPLAY l_ac TO FORMONLY.h_index
               CALL adbp541_set_entry_b()
               CALL adbp541_set_no_entry_b()
            

#            AFTER FIELD b_xmdh019 
#               LET l_ac = DIALOG.getCurrentRow("s_detail1")
#               IF NOT cl_ap_chk_Range(g_detail_d[l_ac].xmdh019,"0.000","0","","","azz-00079",1) THEN
#                  LET g_detail_d[l_ac].xmdh019 = l_xmdh019_t
#                  NEXT FIELD b_xmdh019 
#               END IF
#               IF NOT cl_null(g_detail_d[l_ac].xmdh019) THEN
#                  CALL s_aooi250_take_decimals(g_detail_d[l_ac].xmdh018,g_detail_d[l_ac].xmdh019) RETURNING l_success,g_detail_d[l_ac].xmdh019
#               END IF
# 
#            AFTER FIELD b_xmdh203   
#               LET l_ac = DIALOG.getCurrentRow("s_detail1")
#               IF NOT cl_ap_chk_Range(g_detail_d[l_ac].xmdh203,"0.000","0","","","azz-00079",1) THEN
#                  LET g_detail_d[l_ac].xmdh203 = l_xmdh203_t
#                  NEXT FIELD b_xmdh203
#               END IF
#               
#               IF NOT adbp541_xmdh203_chk() THEN
#                  LET g_detail_d[l_ac].xmdh203 = l_xmdh203_t
#                  NEXT FIELD b_xmdh203
#               END IF
#               #可出貨數
##               CALL adbp541_xmdh203_qty() RETURNING l_qty
##
##               IF g_detail_d[l_ac].xmdh203 > l_qty THEN
##                  INITIALIZE g_errparam TO NULL
##                  LET g_errparam.code = "adb-00121"
##                  LET g_errparam.extend = ""
##                  LET g_errparam.popup = TRUE
##                  CALL cl_err()
##
##                  LET g_detail_d[l_ac].xmdh203 = l_xmdh203_t
##                  NEXT FIELD b_xmdh203
##               END IF 
#            
#               IF NOT cl_null(g_detail_d[l_ac].xmdh203) THEN
#                  CALL s_aooi250_take_decimals(g_detail_d[l_ac].xmdh202,g_detail_d[l_ac].xmdh203) RETURNING l_success,g_detail_d[l_ac].xmdh203
#               END IF
#            
#               #換算參考數量
#               IF NOT cl_null(g_detail_d[l_ac].xmdh018) THEN
#                  CALL s_aooi250_convert_qty(g_detail_d[l_ac].xmdh006,g_detail_d[l_ac].xmdh202,g_detail_d[l_ac].xmdh018,g_detail_d[l_ac].xmdh203)
#                      RETURNING l_success,l_xmdh019
#                  IF l_success THEN
#                     LET g_detail_d[l_ac].xmdh019 = l_xmdh019   #分批計價數量     
#                  END IF 
#                  IF NOT cl_null(g_detail_d[l_ac].xmdh019) THEN
#                     CALL s_aooi250_take_decimals(g_detail_d[l_ac].xmdh018,g_detail_d[l_ac].xmdh019) RETURNING l_success,g_detail_d[l_ac].xmdh019
#                  END IF
#               END IF
          
            AFTER FIELD b_xmdh203   
               IF NOT cl_null(g_detail_d[l_ac].xmdh203) THEN
                  CALL s_aooi250_take_decimals(g_detail_d[l_ac].xmdh202,g_detail_d[l_ac].xmdh203) RETURNING l_success,g_detail_d[l_ac].xmdh203
                  IF NOT cl_ap_chk_Range(g_detail_d[l_ac].xmdh203,"0.000","1","","","azz-00079",1) THEN
                     LET g_detail_d[l_ac].xmdh203 = g_detail_d_o.xmdh203
                     NEXT FIELD b_xmdh203
                  END IF
                  IF NOT adbp541_xmdh203_chk() THEN
                     LET g_detail_d[l_ac].xmdh203 = g_detail_d_o.xmdh203
                     NEXT FIELD b_xmdh203
                  END IF

                  IF NOT cl_null(g_detail_d[l_ac].xmdh015) THEN
                     CALL s_aooi250_convert_qty(g_detail_d[l_ac].xmdh006,g_detail_d[l_ac].xmdh202,g_detail_d[l_ac].xmdh015,g_detail_d[l_ac].xmdh203) RETURNING l_success,g_detail_d[l_ac].xmdh016
                  END IF
                  IF NOT cl_null(g_detail_d[l_ac].xmdh018) THEN
                     CALL s_aooi250_convert_qty(g_detail_d[l_ac].xmdh006,g_detail_d[l_ac].xmdh202,g_detail_d[l_ac].xmdh018,g_detail_d[l_ac].xmdh203) RETURNING l_success,g_detail_d[l_ac].xmdh019
                  END IF
               END IF
               LET g_detail_d_o.xmdh203 = g_detail_d[l_ac].xmdh203
               LET g_detail_d_o.xmdh016 = g_detail_d[l_ac].xmdh016
               LET g_detail_d_o.xmdh019 = g_detail_d[l_ac].xmdh019
               
            AFTER FIELD b_xmdh016
               IF NOT cl_null(g_detail_d[l_ac].xmdh016) THEN
                  IF g_detail_d[l_ac].xmdh016 <> g_detail_d_o.xmdh016 OR cl_null(g_detail_d_o.xmdh016) THEN
                     CALL s_aooi250_take_decimals(g_detail_d[l_ac].xmdh015,g_detail_d[l_ac].xmdh016) RETURNING l_success,g_detail_d[l_ac].xmdh016
                     IF NOT cl_ap_chk_Range(g_detail_d[l_ac].xmdh016,"0.000","0","","","azz-00079",1) THEN
                        LET g_detail_d[l_ac].xmdh016 = g_detail_d_o.xmdh016
                        NEXT FIELD b_xmdh016
                     END IF                     
                     IF NOT adbp541_xmdh016_chk(g_detail_d[l_ac].xmdh016) THEN
                        LET g_detail_d[l_ac].xmdh016 = g_detail_d_o.xmdh016
                        NEXT FIELD b_xmdh016
                     END IF
                     IF NOT cl_null(g_detail_d[l_ac].xmdh202) THEN
                        CALL s_aooi250_convert_qty(g_detail_d[l_ac].xmdh006,g_detail_d[l_ac].xmdh015,g_detail_d[l_ac].xmdh202,g_detail_d[l_ac].xmdh016) RETURNING l_success,g_detail_d[l_ac].xmdh203
                     END IF
                     IF NOT cl_null(g_detail_d[l_ac].xmdh018) THEN
                        CALL s_aooi250_convert_qty(g_detail_d[l_ac].xmdh006,g_detail_d[l_ac].xmdh015,g_detail_d[l_ac].xmdh018,g_detail_d[l_ac].xmdh016) RETURNING l_success,g_detail_d[l_ac].xmdh019
                     END IF
                  END IF
               ELSE
                  LET g_detail_d[l_ac].xmdh203 = ''
                  LET g_detail_d[l_ac].xmdh019 = ''
               END IF               
               LET g_detail_d_o.xmdh016 = g_detail_d[l_ac].xmdh016
               LET g_detail_d_o.xmdh203 = g_detail_d[l_ac].xmdh203
               LET g_detail_d_o.xmdh019 = g_detail_d[l_ac].xmdh019
               CALL adbp541_set_entry_b()    
               CALL adbp541_set_no_entry_b()   
            
            AFTER FIELD b_xmdh019 
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               IF NOT cl_null(g_detail_d[l_ac].xmdh019) THEN
                  IF NOT cl_null(g_detail_d[l_ac].xmdh018) THEN
                     CALL s_aooi250_take_decimals(g_detail_d[l_ac].xmdh018,g_detail_d[l_ac].xmdh019) RETURNING l_success,g_detail_d[l_ac].xmdh019
                     IF NOT cl_ap_chk_Range(g_detail_d[l_ac].xmdh019,"0.000","1","","","azz-00079",1) THEN
                        LET g_detail_d[l_ac].xmdh019 =  g_detail_d_o.xmdh019
                        NEXT FIELD b_xmdh019 
                     END IF
                  END IF
               END IF

            ON CHANGE sel
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               CALL cl_err_collect_init()   #170109-00037#5 170118 by lori add
               CALL adbp541_upd_temp1()   
               CALL cl_err_collect_show()   #170109-00037#5 170118 by lori add
               CALL adbp541_set_entry_b()
               CALL adbp541_set_no_entry_b()
            
            ON ROW CHANGE
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               CALL cl_err_collect_init()   #170109-00037#5 170118 by lori add
               CALL adbp541_upd_temp1()
               CALL cl_err_collect_show()   #170109-00037#5 170118 by lori add
            #AFTER INPUT
            
            #ON ACTION accept
            #   ACCEPT DIALOG
            
         END INPUT 
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         BEFORE DIALOG
            IF g_detail_d.getLength() > 0 THEN
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
            ELSE
               CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            END IF
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
            CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            CALL cl_set_act_visible("filter", FALSE)
            
            DISPLAY g_construct_display.xmdg005 TO xmdg005
            DISPLAY g_construct_display.xmdg201 TO xmdg201
            DISPLAY g_construct_display.xmdh212 TO xmdh212
            DISPLAY g_construct_display.xmdh213 TO xmdh213
            DISPLAY g_construct_display.xmdh214 TO xmdh214
            DISPLAY g_construct_display.xmdgdocno TO xmdgdocno
            DISPLAY g_construct_display.xmdg028 TO xmdg028
            
            LET g_xmdg001 = g_construct_display.xmdg001
            IF cl_null(g_xmdg001) THEN
               LET g_xmdg001 = '1'
            END IF
            LET g_xmdhunit = g_site
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            CALL cl_err_collect_init()   #161230-00039#1 161230 by lori add
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
               LET l_ac = li_idx
               CALL adbp541_upd_temp1()
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            CALL cl_err_collect_show()   #161230-00039#1 161230 by lori add
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone name="ui_dialog.for.onaction_selnone"
               LET l_ac = li_idx
               CALL adbp541_upd_temp1()
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
 
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            #161230-00039#1 161230 by lori mod---(S)
            #LET l_ac = DIALOG.getCurrentRow("s_detail1")
            #IF l_ac > 0 THEN
            #   CALL adbp541_upd_temp1()
            #END IF
            
            CALL cl_err_collect_init() 
            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y" 
               LET l_ac = li_idx
               CALL adbp541_upd_temp1()               
            END FOR
            
            CALL cl_err_collect_show()   
            #161230-00039#1 161230 by lori mod---(E)
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            LET l_ac = DIALOG.getCurrentRow("s_detail1")
            IF l_ac > 0 THEN
               CALL adbp541_upd_temp1()
            END IF
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL adbp541_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION accept
            #add-point:ui_dialog段accept之前 name="menu.filter"
            
            #end add-point
            CALL adbp541_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL adbp541_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            #160225-00040#18 2016/04/13 s983961--add(s)
            IF g_bgjob <> "Y" THEN
               CALL cl_progress_bar_no_window(2)
            END IF   
            #160225-00040#18 2016/04/13 s983961--add(e)
            IF l_ac > 0 THEN               
               #By benson ----S---- 
               #因為資料改成出貨數量xmdh016為主,如果不加這段會在某些操作情境下產生錯誤的資料
               IF NOT cl_null(g_detail_d[l_ac].xmdh016) THEN
                  IF g_detail_d[l_ac].xmdh016 <> g_detail_d_o.xmdh016 OR cl_null(g_detail_d_o.xmdh016) THEN
                     CALL s_aooi250_take_decimals(g_detail_d[l_ac].xmdh015,g_detail_d[l_ac].xmdh016) RETURNING l_success,g_detail_d[l_ac].xmdh016
                     IF NOT cl_ap_chk_Range(g_detail_d[l_ac].xmdh016,"0.000","0","","","azz-00079",1) THEN
                        LET g_detail_d[l_ac].xmdh016 = g_detail_d_o.xmdh016
                        CONTINUE DIALOG
                     END IF                     
                     IF NOT adbp541_xmdh016_chk(g_detail_d[l_ac].xmdh016) THEN
                        LET g_detail_d[l_ac].xmdh016 = g_detail_d_o.xmdh016
                        CONTINUE DIALOG
                     END IF
                     IF NOT cl_null(g_detail_d[l_ac].xmdh202) THEN
                        CALL s_aooi250_convert_qty(g_detail_d[l_ac].xmdh006,g_detail_d[l_ac].xmdh015,g_detail_d[l_ac].xmdh202,g_detail_d[l_ac].xmdh016) RETURNING l_success,g_detail_d[l_ac].xmdh203
                     END IF
                     IF NOT cl_null(g_detail_d[l_ac].xmdh018) THEN
                        CALL s_aooi250_convert_qty(g_detail_d[l_ac].xmdh006,g_detail_d[l_ac].xmdh015,g_detail_d[l_ac].xmdh018,g_detail_d[l_ac].xmdh016) RETURNING l_success,g_detail_d[l_ac].xmdh019
                     END IF
                  END IF
               ELSE
                  LET g_detail_d[l_ac].xmdh203 = ''
                  LET g_detail_d[l_ac].xmdh019 = ''
               END IF   
               #By benson ----E----    

               CALL cl_err_collect_init()   #170109-00037#5 170118 by lori add
               CALL adbp541_upd_temp1()      
               CALL cl_err_collect_show()   #170109-00037#5 170118 by lori add
               IF NOT adbp541_chk_data() THEN
                  CONTINUE DIALOG
               END IF
            END IF
            
            SELECT COUNT(*)
              INTO l_cnt
              FROM s_adbp541_temp1
             WHERE sel = 'Y'
            IF l_cnt > 0 THEN 
               #160225-00040#18 2016/04/13 s983961--add(s)
               LET l_msg = cl_getmsg('ast-00330',g_lang)   
               CALL cl_progress_no_window_ing(l_msg)
               #160225-00040#18 2016/04/13 s983961--add(e)
               CALL s_transaction_begin()
               CALL s_adbp541('1','') RETURNING l_success,l_str
               IF l_success THEN
                  CALL s_transaction_end('Y','1')
                  CALL s_adbp541_open_adbt540(l_str)
               ELSE
                  CALL s_transaction_end('N','1')
               END IF 
               DELETE FROM s_adbp541_temp2
               CALL adbp541_b_fill()
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'adb-00078'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CONTINUE DIALOG
            END IF
            #160225-00040#18 2016/04/13 s983961--add(s)
            LET l_msg = cl_getmsg('std-00012',g_lang)
            CALL cl_progress_no_window_ing(l_msg)  
           #CALL cl_err_collect_show()    #170109-00037#5 170118 by lori mark:誤寫,多餘的處理
            #160225-00040#18 2016/04/13 s983961--add(e)            
         #end add-point
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      #(ver:22) ---start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:22) --- end ---
 
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #(ver:22) ---start---
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         #(ver:22) --- end ---
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="adbp541.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION adbp541_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   IF l_ac > 0 THEN
      CALL cl_err_collect_init()   #170109-00037#5 170118 by lori add
      CALL adbp541_upd_temp1()      
      CALL cl_err_collect_show()   #170109-00037#5 170118 by lori add
   END IF
   
   DELETE FROM s_adbp541_temp2
   INSERT INTO s_adbp541_temp2
        SELECT xmdhent,xmdhdocno,xmdhseq,xmdh203,xmdh016,xmdh019
          FROM s_adbp541_temp1
         WHERE sel = 'Y'
   #end add-point
        
   LET g_error_show = 1
   CALL adbp541_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
   #add-point:cs段after_query name="query.cs_after_query"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="adbp541.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adbp541_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_xmdh203       LIKE xmdh_t.xmdh203
   DEFINE l_xmdh016       LIKE xmdh_t.xmdh016
   DEFINE l_xmdh019       LIKE xmdh_t.xmdh019
   DEFINE l_qty           LIKE xmdh_t.xmdh203
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_where         STRING
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET l_where = s_aooi500_sql_where(g_prog,'xmdgsite') 
   DELETE FROM s_adbp541_temp1
   
   #160729-00027#2 16/08/02 by lori mark---(S)
   #LET g_sql = "SELECT      'N', xmda202,      '',xmdgdocno, xmdhseq,",
   #            "        xmdg001, xmdg005,      '', xmdg006,       '',", 
   #            "        xmdg007,      '',xmdhunit,      '',",
   #            "        xmdh201, xmdh006,      '',      '',",
   #            "        xmdh007, xmdh202,      '', xmdh203, xmdh015, ",
   #            "             '', xmdh016, xmdh018,",
   #            "             '', xmdh019, xmdc012, xmdh211,       '',",
   #            "        xmdh213,      '', xmdh214,      '',  xmdh030,",
   #            "        xmdh219,      '', xmdgsite, xmdh212 ",
   #            "  FROM xmdg_t,xmdh_t ",
   #            "       LEFT OUTER JOIN xmda_t ON xmdadocno = xmdh001 ",
   #            "       LEFT OUTER JOIN xmdc_t ON xmdcdocno = xmdh001 AND xmdcseq = xmdh002 ",
   #            " WHERE xmdgent = xmdhent AND xmdgdocno = xmdhdocno ",
   #            "   AND xmdgent = ? ",
   #            "   AND ",g_wc CLIPPED,
   #            "   AND ",g_wc2 CLIPPED ,
   #            "   AND xmdg001 = '",g_xmdg001,"'",
   #            "   AND xmdhunit = '",g_xmdhunit,"'",                       
   #            "   AND xmdgstus = 'Y' ",
   #            "   AND xmdh015 IS NOT NULL",   #當出貨單位 或 包裝單位 其中一個為空值時,則不顯示於畫面上
   #            "   AND xmdh202 IS NOT NULL"
   #160729-00027#2 16/08/02 by lori mark---(E)

   #160729-00027#2 16/08/02 by lori add---(S)
   #校能調整
   LET g_sql = "SELECT       'N', ",
               "         xmda202, ",
               " (SELECT ooefl003 FROM ooefl_t WHERE ooeflent=",g_enterprise," AND ooefl001=xmda202 AND ooefl002='",g_dlang,"'), ",
               "       xmdgdocno, xmdhseq, xmdg001, xmdg005, ",
               " (SELECT pmaal004 FROM pmaal_t WHERE pmaalent=",g_enterprise," AND pmaal001=xmdg005 AND pmaal002='",g_dlang,"'), ",
               "         xmdg006, ",
               " (SELECT pmaal004 FROM pmaal_t WHERE pmaalent=",g_enterprise," AND pmaal001=xmdg006 AND pmaal002='",g_dlang,"'), ", 
               "         xmdg007, ",
               " (SELECT pmaal004 FROM pmaal_t WHERE pmaalent=",g_enterprise," AND pmaal001=xmdg007 AND pmaal002='",g_dlang,"'), ",
               "        xmdhunit, ",
               " (SELECT ooefl003 FROM ooefl_t WHERE ooeflent=",g_enterprise," AND ooefl001=xmdhunit AND ooefl002='",g_dlang,"'), ",
               "         xmdh201, xmdh006, imaal003, imaal004, ",
               "         xmdh007, xmdh202, ",
               " (SELECT oocal003 FROM oocal_t WHERE oocalent=",g_enterprise," AND oocal001=xmdh202 AND oocal002='",g_dlang,"'), ",
               "         xmdh203, xmdh015, ",
               " (SELECT oocal003 FROM oocal_t WHERE oocalent=",g_enterprise," AND oocal001=xmdh015 AND oocal002='",g_dlang,"'), ",
               "         xmdh016, xmdh018, ",
               " (SELECT oocal003 FROM oocal_t WHERE oocalent=",g_enterprise," AND oocal001=xmdh018 AND oocal002='",g_dlang,"'), ",
               "         xmdh019, xmdc012, xmdh211, ",
               " (SELECT pmaal004 FROM pmaal_t WHERE pmaalent=",g_enterprise," AND pmaal001=xmdh211 AND pmaal002='",g_dlang,"'), ",
               "         xmdh213, ",
               " (SELECT oofb011 FROM oofb_t WHERE oofbent=",g_enterprise," AND oofb019=xmdh213 AND oofb008 = '3' AND oofb002=pmaa027), ",
               "         xmdh214, ",
               " (SELECT dbadl003 FROM dbadl_t WHERE dbadlent=",g_enterprise," AND dbadl001=xmdh214 AND dbadl002='",g_dlang,"'), ",
               "         xmdh030, ",
               "         xmdh219, ",
               " (SELECT dbbcl003 FROM dbbcl_t WHERE dbbclent=",g_enterprise," AND dbbcl001=xmdh219 AND dbbcl002='",g_dlang,"'), ",
               "        xmdgsite, ",
               "         xmdh212 ",
               "  FROM xmdg_t,xmdh_t ",
               "       LEFT OUTER JOIN xmda_t  ON xmdaent  = xmdhent AND xmdadocno = xmdh001 ",
               "       LEFT OUTER JOIN xmdc_t  ON xmdcent  = xmdhent AND xmdcdocno = xmdh001 AND xmdcseq = xmdh002 ",
               "       LEFT OUTER JOIN imaal_t ON imaalent = xmdhent AND imaal001 = xmdh006 AND imaal002='",g_dlang,"' ",
               "       LEFT OUTER JOIN pmaa_t  ON pmaaent  = xmdhent AND pmaa001 = xmdh212 ",
               " WHERE xmdgent = xmdhent AND xmdgdocno = xmdhdocno ",
               "   AND xmdgent = ? ",
               "   AND ",g_wc CLIPPED,
               "   AND ",g_wc2 CLIPPED ,
               "   AND xmdg001 = '",g_xmdg001,"'",
               "   AND xmdhunit = '",g_xmdhunit,"'",                       
               "   AND xmdgstus = 'Y' ",
               "   AND xmdh015 IS NOT NULL",   #當出貨單位 或 包裝單位 其中一個為空值時,則不顯示於畫面上
               "   AND xmdh202 IS NOT NULL" 
   #160729-00027#2 16/08/02 by lori add---(E)
               
   #150112 by lori add---(S)
   IF NOT cl_null(g_xmdg028) THEN
      LET g_sql = g_sql , 
                  " AND xmdg028 = '",g_xmdg028,"' "
   END IF
   #150112 by lori add---(E)
   
   LET g_sql = g_sql CLIPPED," AND ",l_where
   #end add-point
 
   PREPARE adbp541_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adbp541_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].sel,          g_detail_d[l_ac].xmda202,      g_detail_d[l_ac].xmda202_desc, g_detail_d[l_ac].xmdgdocno,
   g_detail_d[l_ac].xmdhseq,      g_detail_d[l_ac].xmdg001,      g_detail_d[l_ac].xmdg005,     g_detail_d[l_ac].xmdg005_desc, 
   #g_detail_d[l_ac].xmdh201,   #160525-00034#1 160531 by sakura mark
   g_detail_d[l_ac].xmdg006,
   g_detail_d[l_ac].xmdg006_desc, g_detail_d[l_ac].xmdg007,      g_detail_d[l_ac].xmdg007_desc, g_detail_d[l_ac].xmdhunit,
   g_detail_d[l_ac].xmdhunit_desc,g_detail_d[l_ac].xmdh201,   #160525-00034#1 160531 by sakura add xmdh201
   g_detail_d[l_ac].xmdh006,      g_detail_d[l_ac].xmdh006_desc, g_detail_d[l_ac].xmdh006_desc_desc, g_detail_d[l_ac].xmdh007,
   g_detail_d[l_ac].xmdh202,      g_detail_d[l_ac].xmdh202_desc, g_detail_d[l_ac].xmdh203,      g_detail_d[l_ac].xmdh015, 
   g_detail_d[l_ac].xmdh015_desc, g_detail_d[l_ac].xmdh016,      g_detail_d[l_ac].xmdh018,
   g_detail_d[l_ac].xmdh018_desc, g_detail_d[l_ac].xmdh019,      g_detail_d[l_ac].xmdc012,      g_detail_d[l_ac].xmdh211,
   g_detail_d[l_ac].xmdh211_desc, g_detail_d[l_ac].xmdh213,      g_detail_d[l_ac].xmdh213_desc, g_detail_d[l_ac].xmdh214,
   g_detail_d[l_ac].xmdh214_desc, g_detail_d[l_ac].xmdh030,      g_detail_d[l_ac].xmdh219,      g_detail_d[l_ac].xmdh219_desc, 
   g_detail_d[l_ac].xmdgsite,     g_detail_d[l_ac].xmdh212
   #end add-point
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充 name="b_fill.foreach_iside"
      
      #可出貨數
      CALL s_adbt540_get_max_ship_qty('1','',g_detail_d[l_ac].xmdgdocno,g_detail_d[l_ac].xmdhseq,'','') RETURNING l_xmdh016
      IF l_xmdh016 > 0 THEN
         LET g_detail_d[l_ac].xmdh016 = l_xmdh016
         CALL s_aooi250_convert_qty(g_detail_d[l_ac].xmdh006,g_detail_d[l_ac].xmdh015,g_detail_d[l_ac].xmdh202,l_xmdh016)
           RETURNING l_success,l_xmdh016
         IF l_success THEN
            LET g_detail_d[l_ac].xmdh203 = l_xmdh016
         END IF          
      ELSE
         CONTINUE FOREACH
      END IF
      
      
      #此筆資料已勾選
      LET l_xmdh203 =''
      LET l_xmdh016 =''
      LET l_xmdh019 =''
      SELECT xmdh203,xmdh019
        INTO l_xmdh203,l_xmdh019
        FROM s_adbp541_temp2
       WHERE xmdhent = g_enterprise
         AND xmdhdocno = g_detail_d[l_ac].xmdgdocno
         AND xmdhseq = g_detail_d[l_ac].xmdhseq
         
      IF NOT cl_null(l_xmdh203) THEN
         LET g_detail_d[l_ac].sel = 'Y'
         LET g_detail_d[l_ac].xmdh203 = l_xmdh203
         LET g_detail_d[l_ac].xmdh016 = l_xmdh016
         LET g_detail_d[l_ac].xmdh019 = l_xmdh019
      END IF
      INSERT INTO s_adbp541_temp1(sel,xmdhent,xmdhdocno,xmdhseq,xmdh203,xmdh016,xmdh019)
      VALUES(g_detail_d[l_ac].sel,g_enterprise,g_detail_d[l_ac].xmdgdocno,g_detail_d[l_ac].xmdhseq,
             g_detail_d[l_ac].xmdh203,g_detail_d[l_ac].xmdh016,g_detail_d[l_ac].xmdh019)
      #end add-point
      
      CALL adbp541_detail_show()      
 
      LET l_ac = l_ac + 1
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
      
   END FOREACH
   LET g_error_show = 0
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.other_table"
   CALL g_detail_d.deleteElement(l_ac)
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE adbp541_sel
   
   LET l_ac = 1
   CALL adbp541_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adbp541.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adbp541_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="adbp541.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION adbp541_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   #160729-00027#2 16/08/02 by lori mark---(S)
   #CALL adbp541_xmda202_ref()
   #CALL adbp541_xmdg005_ref()
   #CALL adbp541_xmdg006_ref()
   #CALL adbp541_xmdg007_ref()
   #CALL adbp541_xmdhunit_ref()
   #CALL adbp541_xmdh006_ref()
   #CALL adbp541_xmdh202_ref()
   #CALL adbp541_xmdh018_ref()
   #CALL adbp541_xmdh211_ref()
   #CALL adbp541_xmdh213_ref()
   #CALL adbp541_xmdh214_ref()
   #CALL adbp541_xmdh219_ref()
   #CALL adbp541_xmdh015_ref()
   #160729-00027#2 16/08/02 by lori mark---(S)
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adbp541.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION adbp541_filter()
   #add-point:filter段define(客製用) name="filter.define_customerization"
   
   #end add-point    
   #add-point:filter段define name="filter.define"
   
   #end add-point
   
   DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
      ON UPDATE
 
   END DISPLAY
 
   LET l_ac = 1
   LET g_detail_cnt = 1
   #add-point:filter段define name="filter.detail_cnt"
   
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL adbp541_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="adbp541.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION adbp541_filter_parser(ps_field)
   #add-point:filter段define(客製用) name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define name="filter_parser.define"
   
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
 
{<section id="adbp541.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION adbp541_filter_show(ps_field,ps_object)
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
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = adbp541_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="adbp541.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION adbp541_set_entry_b()
   CALL cl_set_comp_entry("b_xmdh203,b_xmdh019,b_xmdh016",TRUE)
END FUNCTION

PRIVATE FUNCTION adbp541_set_no_entry_b()
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_slip           LIKE xmdg_t.xmdgdocno
   DEFINE l_ooac004        LIKE ooac_t.ooac004
   
   IF l_ac > 0 THEN
      CALL s_aooi200_get_slip(g_detail_d[l_ac].xmdgdocno) RETURNING l_success,l_slip
   
      CALL cl_get_doc_para(g_enterprise,g_detail_d[l_ac].xmdgsite,l_slip,'D-BAS-0060') RETURNING l_ooac004

      IF l_ooac004 = '1' THEN
         CALL cl_set_comp_entry("b_xmdh203,b_xmdh019,b_xmdh016",FALSE)
      END IF
      
      IF g_detail_d[l_ac].sel = 'N' THEN
         CALL cl_set_comp_entry("b_xmdh203,b_xmdh019,b_xmdh016",FALSE)
      END IF
      
      IF NOT cl_null(g_detail_d[l_ac].xmdh016) THEN
         CALL cl_set_comp_entry("b_xmdh203",FALSE)
      END IF
      IF cl_null(g_detail_d[l_ac].xmdh018) THEN
         CALL cl_set_comp_entry("b_xmdh019",FALSE)
      END IF
   END IF
END FUNCTION

PRIVATE FUNCTION adbp541_upd_temp1()
   DEFINE l_xmdhdocno LIKE xmdh_t.xmdhdocno   #161230-00039#1 161230 by lori add
   DEFINE l_xmdhseq   LIKE xmdh_t.xmdhseq     #161230-00039#1 161230 by lori add 
   
   #161230-00039#1 161230 by lori add---(S)    
   #batch_execute時仍會檢查當前指標資料,因此不論檢查如何都應更新sel   #170109-00037#5 
   IF g_detail_d[l_ac].sel = 'Y' THEN
      CALL s_transaction_begin()
      LET l_xmdhdocno = ''
      LET l_xmdhseq = ''
      EXECUTE adbp541_chk_lock_xmdh USING g_detail_d[l_ac].xmdgdocno,g_detail_d[l_ac].xmdhseq
                                     INTO l_xmdhdocno,l_xmdhseq 
      IF cl_null(l_xmdhdocno) OR cl_null(l_xmdhseq) THEN
         LET g_detail_d[l_ac].sel = 'N'
         
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'apm-01117'
         LET g_errparam.replace[1] = g_detail_d[l_ac].xmdgdocno
         LET g_errparam.replace[2] = g_detail_d[l_ac].xmdhseq
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         CALL s_transaction_end('N',0)     #170109-00037#5 170118 by lori add
      ELSE
         #170109-00037#5 170118 by lori mark---(S)
         #UPDATE s_adbp541_temp1
         #   SET sel = g_detail_d[l_ac].sel,
         #       xmdh203 = g_detail_d[l_ac].xmdh203,
         #       xmdh016 = g_detail_d[l_ac].xmdh016,
         #       xmdh019 = g_detail_d[l_ac].xmdh019
         #    WHERE xmdhent = g_enterprise
         #      AND xmdhdocno = g_detail_d[l_ac].xmdgdocno
         #      AND xmdhseq = g_detail_d[l_ac].xmdhseq    
         #170109-00037#5 170118 by lori mark---(E)  

         CALL s_transaction_end('Y',0)     #170109-00037#5 170118 by lori mark 
      END IF 
    
     #CALL s_transaction_end('Y',0)        #170109-00037#5 170118 by lori mark           
  #ELSE                                    #170109-00037#5 170118 by lori mark
  END IF                                   #170109-00037#5 170118 by lori add
   #161230-00039#1 161230 by lori add---(E)   
      UPDATE s_adbp541_temp1
         SET sel = g_detail_d[l_ac].sel,
             xmdh203 = g_detail_d[l_ac].xmdh203,
             xmdh016 = g_detail_d[l_ac].xmdh016,
             xmdh019 = g_detail_d[l_ac].xmdh019
          WHERE xmdhent = g_enterprise
            AND xmdhdocno = g_detail_d[l_ac].xmdgdocno
            AND xmdhseq = g_detail_d[l_ac].xmdhseq
  #END IF      #161230-00039#1 161230 by lori add    #170109-00037#5 170118 by lori mark:END IF搬到UPDATE之前
END FUNCTION

PRIVATE FUNCTION adbp541_xmdh203_qty()
   DEFINE r_qty       LIKE xmdh_t.xmdh016
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_xmdh016   LIKE xmdh_t.xmdh016
   
   LET r_qty = 0
   CALL s_adbt540_get_max_ship_qty('1','',g_detail_d[l_ac].xmdgdocno,g_detail_d[l_ac].xmdhseq,'','') RETURNING l_xmdh016
   #轉成出貨包裝單位
   IF NOT cl_null(g_detail_d[l_ac].xmdh015) THEN
      CALL s_aooi250_convert_qty(g_detail_d[l_ac].xmdh006,g_detail_d[l_ac].xmdh015,g_detail_d[l_ac].xmdh202,l_xmdh016)
        RETURNING l_success,r_qty
   END IF
   
   RETURN r_qty
END FUNCTION

PRIVATE FUNCTION adbp541_xmda202_ref()
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail_d[l_ac].xmda202
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail_d[l_ac].xmda202_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_detail_d[l_ac].xmda202_desc
END FUNCTION

PRIVATE FUNCTION adbp541_xmdg005_ref()
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail_d[l_ac].xmdg005
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail_d[l_ac].xmdg005_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_detail_d[l_ac].xmdg005_desc
END FUNCTION

PRIVATE FUNCTION adbp541_xmdg006_ref()
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail_d[l_ac].xmdg006
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail_d[l_ac].xmdg006_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_detail_d[l_ac].xmdg006_desc
END FUNCTION

PRIVATE FUNCTION adbp541_xmdg007_ref()
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail_d[l_ac].xmdg007
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail_d[l_ac].xmdg007_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_detail_d[l_ac].xmdg007_desc
END FUNCTION

PRIVATE FUNCTION adbp541_xmdhunit_ref()
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail_d[l_ac].xmdhunit
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail_d[l_ac].xmdhunit_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_detail_d[l_ac].xmdhunit_desc
END FUNCTION

PRIVATE FUNCTION adbp541_xmdh006_ref()
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail_d[l_ac].xmdh006
      CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail_d[l_ac].xmdh006_desc = '', g_rtn_fields[1] , ''
      LET g_detail_d[l_ac].xmdh006_desc_desc = '', g_rtn_fields[2] , ''
      DISPLAY BY NAME g_detail_d[l_ac].xmdh006_desc
      DISPLAY BY NAME g_detail_d[l_ac].xmdh006_desc_desc
END FUNCTION

PRIVATE FUNCTION adbp541_xmdh202_ref()
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail_d[l_ac].xmdh202
      CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail_d[l_ac].xmdh202_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_detail_d[l_ac].xmdh202_desc
END FUNCTION

PRIVATE FUNCTION adbp541_xmdh018_ref()
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail_d[l_ac].xmdh018
      CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail_d[l_ac].xmdh018_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_detail_d[l_ac].xmdh018_desc
END FUNCTION

PRIVATE FUNCTION adbp541_xmdh211_ref()
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail_d[l_ac].xmdh211
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail_d[l_ac].xmdh211_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_detail_d[l_ac].xmdh211_desc
END FUNCTION

PRIVATE FUNCTION adbp541_xmdh213_ref()
   DEFINE l_pmaa027    LIKE pmaa_t.pmaa027

      SELECT pmaa027 INTO l_pmaa027
        FROM pmaa_t
       WHERE pmaaent = g_enterprise
         AND pmaa001 = g_detail_d[l_ac].xmdh212
         
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail_d[l_ac].xmdh213
      CALL ap_ref_array2(g_ref_fields,"SELECT oofb011 FROM oofb_t WHERE oofbent='"||g_enterprise||"' AND oofb019=? AND oofb008 = '3' AND oofb002='"||l_pmaa027||"'","") RETURNING g_rtn_fields
      LET g_detail_d[l_ac].xmdh213_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_detail_d[l_ac].xmdh213_desc
END FUNCTION

PRIVATE FUNCTION adbp541_xmdh214_ref()
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail_d[l_ac].xmdh214
      CALL ap_ref_array2(g_ref_fields,"SELECT dbadl003 FROM dbadl_t WHERE dbadlent='"||g_enterprise||"' AND dbadl001=? AND dbadl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail_d[l_ac].xmdh214_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_detail_d[l_ac].xmdh214_desc
END FUNCTION

PRIVATE FUNCTION adbp541_xmdh219_ref()
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =  g_detail_d[l_ac].xmdh219
      CALL ap_ref_array2(g_ref_fields,"SELECT dbbcl003 FROM dbbcl_t WHERE dbbclent='"||g_enterprise||"' AND dbbcl001=? AND dbbcl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail_d[l_ac].xmdh219_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_detail_d[l_ac].xmdh219_desc
END FUNCTION

PRIVATE FUNCTION adbp541_xmdh203_chk()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_xmdh016   LIKE xmdh_t.xmdh016
      
   LET r_success = TRUE

   CALL s_aooi250_convert_qty(g_detail_d[l_ac].xmdh006,g_detail_d[l_ac].xmdh202,g_detail_d[l_ac].xmdh015,g_detail_d[l_ac].xmdh203) RETURNING l_success,l_xmdh016
   IF l_success THEN
      IF NOT adbp541_xmdh016_chk(l_xmdh016) THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   ELSE
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

PRIVATE FUNCTION adbp541_chk_data()
   DEFINE r_success  LIKE type_t.chr1
   
   LET r_success = TRUE
   
   IF g_detail_d[l_ac].sel = 'Y' AND (cl_null(g_detail_d[l_ac].xmdh203) OR cl_null(g_detail_d[l_ac].xmdh016)) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = 'adb-00092'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF NOT cl_ap_chk_Range(g_detail_d[l_ac].xmdh203,"0.000","1","","","azz-00079",1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF NOT cl_ap_chk_Range(g_detail_d[l_ac].xmdh016,"0.000","0","","","azz-00079",1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF NOT adbp541_xmdh016_chk(g_detail_d[l_ac].xmdh016) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF NOT cl_null(g_detail_d[l_ac].xmdh018) THEN
     IF NOT cl_ap_chk_Range(g_detail_d[l_ac].xmdh019,"0.000","1","","","azz-00079",1) THEN
        LET r_success = FALSE
        RETURN r_success 
     END IF
   END IF
   
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION adbp541_xmdh016_chk(p_xmdh016)
   DEFINE p_xmdh016   LIKE xmdh_t.xmdh016
   DEFINE l_xmdh016   LIKE xmdh_t.xmdh016
   DEFINE r_success   LIKE type_t.num5

   LET r_success = TRUE

   CALL s_adbt540_get_max_ship_qty('1','',g_detail_d[l_ac].xmdgdocno,g_detail_d[l_ac].xmdhseq,'','') RETURNING l_xmdh016                             
   IF p_xmdh016 > l_xmdh016 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adb-00121'
      LET g_errparam.extend = p_xmdh016
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

PRIVATE FUNCTION adbp541_xmdh015_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_d[l_ac].xmdh015
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_detail_d[l_ac].xmdh015_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_detail_d[l_ac].xmdh015_desc
END FUNCTION

#end add-point
 
{</section>}
 
