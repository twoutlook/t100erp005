#該程式未解開Section, 採用最新樣板產出!
{<section id="apmp864.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2015-10-22 11:13:15), PR版次:0003(2016-11-10 15:24:58)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000036
#+ Filename...: apmp864
#+ Description: 供應商庫存開帳批次處理作業
#+ Creator....: 01251(2015-10-15 16:16:37)
#+ Modifier...: 01251 -SD/PR- 00700
 
{</section>}
 
{<section id="apmp864.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161104-00002#11   2016/11/10  By Rainy  將程式中 *寫法改掉
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
     sel             LIKE type_t.chr1,
     pmdssite        LIKE pmds_t.pmdssite ,
     pmdssite_desc   LIKE ooefl_t.ooefl003,
     pmdsdocdt       LIKE pmds_t.pmdsdocdt,
     pmds001         LIKE pmds_t.pmds001  ,
     pmdsdocno       LIKE pmds_t.pmdsdocno,
     pmds002         LIKE pmds_t.pmds002  ,
     pmds002_desc    LIKE type_t.chr80    ,
     pmds003         LIKE pmds_t.pmds003  ,
     pmds003_desc    LIKE type_t.chr80    ,
     pmds007         LIKE pmds_t.pmds007  ,
     pmds007_desc    LIKE type_t.chr80    ,
     pmds037         LIKE pmds_t.pmds037  ,
     pmds033         LIKE pmds_t.pmds033  ,
     pmds033_desc    LIKE type_t.chr80    ,
     pmds044         LIKE pmds_t.pmds044  ,   #add by geza 20151031
     pmds045         LIKE pmds_t.pmds045  ,
     pmdscrtid       LIKE pmds_t.pmdscrtid,
     pmdscrtid_desc  LIKE type_t.chr80    ,
     pmdscrtdp       LIKE pmds_t.pmdscrtdp,
     pmdscrtdp_desc  LIKE type_t.chr80    ,
     pmdscrtdt       LIKE pmds_t.pmdscrtdt,
     pmdspstid       LIKE pmds_t.pmdspstid,
     pmdspstid_desc  LIKE type_t.chr80    ,
     pmdspstdt       LIKE pmds_t.pmdspstdt,     
     pmdsstus        LIKE pmds_t.pmdsstus     
                     END RECORD
                     
TYPE type_g_detail2_d RECORD
     pmdtseq          LIKE pmdt_t.pmdtseq  ,     
     pmdt200          LIKE pmdt_t.pmdt200  , 
     pmdt006          LIKE pmdt_t.pmdt006  ,
     pmdt006_desc     LIKE type_t.chr80    ,
     pmdt020          LIKE pmdt_t.pmdt020  ,
     pmdt036          LIKE pmdt_t.pmdt036  ,
     pmdt039          LIKE pmdt_t.pmdt039  ,    #add by geza 20151031
     pmdt019          LIKE pmdt_t.pmdt019  ,
     pmdt019_desc     LIKE type_t.chr80    ,
     pmdt016          LIKE pmdt_t.pmdt016  ,
     pmdt016_desc     LIKE type_t.chr80    ,
     pmdt017          LIKE pmdt_t.pmdt017  ,
     pmdt017_desc     LIKE type_t.chr80    ,   
     pmdt018          LIKE pmdt_t.pmdt018  ,   
     pmdt046          LIKE pmdt_t.pmdt046  ,  
     pmdt046_desc     LIKE type_t.chr80    ,     
     pmdt037          LIKE pmdt_t.pmdt037  ,
     pmdt213          LIKE pmdt_t.pmdt213  ,
     pmdt212          LIKE pmdt_t.pmdt212  ,          
     pmdt210          LIKE pmdt_t.pmdt210  ,       
     pmdt211          LIKE pmdt_t.pmdt211  , 
     pmdt211_desc     LIKE type_t.chr80  
                      END RECORD
##mark by geza 20160106(S)                      
#TYPE type_g_detail3_d RECORD
#     l_pmdssite        LIKE pmds_t.pmdssite ,
#     l_pmdssite_desc   LIKE ooefl_t.ooefl003,
#     l_pmdsdocdt       LIKE pmds_t.pmdsdocdt,
#     l_pmds001         LIKE pmds_t.pmds001  ,
#     l_pmdsdocno       LIKE pmds_t.pmdsdocno,
#     l_pmds007         LIKE pmds_t.pmds007  ,
#     l_pmds007_desc    LIKE type_t.chr80    ,  
#     l_pmdt006         LIKE pmdt_t.pmdt006  , #add by geza 20151030
#     l_pmdt006_desc    LIKE type_t.chr80    , #add by geza 20151030 
#     l_pmdt016         LIKE pmdt_t.pmdt016  ,
#     l_pmdt016_desc    LIKE type_t.chr80    ,
#     l_pmdt017         LIKE pmdt_t.pmdt017  ,   
#     l_pmdt018         LIKE pmdt_t.pmdt018  ,
#     l_pmdt020         LIKE pmdt_t.pmdt020  , #add by geza 20151031
#     l_pmdt036         LIKE pmdt_t.pmdt036  , #add by geza 20151031
#     l_pmdt039         LIKE pmdt_t.pmdt039  , #add by geza 20151031     
#     l_pmdt046         LIKE pmdt_t.pmdt046  ,  
#     l_pmdt046_desc    LIKE type_t.chr80    ,
#     l_pmdt037         LIKE pmdt_t.pmdt037  ,
#     l_pmdt213         LIKE pmdt_t.pmdt213  ,
#     l_pmdt212         LIKE pmdt_t.pmdt212  ,       
#     l_pmdt211         LIKE pmdt_t.pmdt211  , 
#     l_pmdt211_desc    LIKE type_t.chr80       
#                      END RECORD                      
##mark by geza 20160106(E) 
#add by geza 20160106(S)                      
TYPE type_g_detail3_d RECORD
     pmdrdocno         LIKE pmdr_t.pmdrdocno ,
     pmdrsite          LIKE pmdr_t.pmdrsite ,
     pmdrsite_desc     LIKE ooefl_t.ooefl003,
     pmdrdocdt         LIKE pmdr_t.pmdrdocdt,
     pmdr001           LIKE pmdr_t.pmdr001  ,
     pmdr001_desc      LIKE pmaal_t.pmaal003,
     pmdr002           LIKE pmdr_t.pmdr002 ,
     pmdr002_desc      LIKE imaal_t.imaal003,
     pmdr003           LIKE pmdr_t.pmdr003 ,
     pmdr003_desc      LIKE oodbl_t.oodbl004,
     pmdr004           LIKE pmdr_t.pmdr003 ,
     pmdr004_desc      LIKE inaa_t.inaa002,
     pmdr005           LIKE pmdr_t.pmdr002 ,
     pmdr005_desc      LIKE inab_t.inab003,
     pmdr006           LIKE pmdr_t.pmdr006 ,
     pmdr007           LIKE pmdr_t.pmdr007 ,
     pmdr008           LIKE pmdr_t.pmdr008 ,
     pmdr009           LIKE pmdr_t.pmdr009 ,
     pmdr010           LIKE pmdr_t.pmdr010 ,
     pmdr011           LIKE pmdr_t.pmdr011 
                      END RECORD                      
#add by geza 20160106(E) 
DEFINE g_detail2_cnt         LIKE type_t.num5      
DEFINE g_detail2_d           DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_detail3_cnt         LIKE type_t.num5      
DEFINE g_detail3_d           DYNAMIC ARRAY OF type_g_detail3_d
DEFINE g_detail_idx          LIKE type_t.num5
DEFINE g_detail_idx2         LIKE type_t.num5 
DEFINE g_cnt1                LIKE type_t.num10    
DEFINE g_deteal_cnt          LIKE type_t.num10    
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_time                LIKE pmdr_t.pmdrdocno      #20151022--dongsz add
DEFINE g_pmds201             LIKE pmds_t.pmds201        #20151031 By shi Add
DEFINE g_pmdr011             LIKE pmdr_t.pmdr011        #add by geza 20160106
DEFINE g_checkbox            LIKE pmdr_t.pmdr011        #add by geza 20160106
DEFINE g_checkbox_1          LIKE pmdr_t.pmdr011        #add by geza 20160119
#DEFINE g_jump                STRING                     #add by geza 20160119
#DEFINE g_no_ask              LIKE type_t.num5           #add by geza 20160119
DEFINE g_pmdrdocno           LIKE pmdr_t.pmdrdocno        #add by geza 20160121
DEFINE g_pmdsdocno           LIKE pmds_t.pmdsdocno        #add by geza 20160125
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apmp864.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
   #add-point:main段define name="main.define"
   
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("apm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmp864 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmp864_init()   
 
      #進入選單 Menu (="N")
      CALL apmp864_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apmp864
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   #add by geza 20151120(S)
   #天和产品回追
   IF NOT apmp864_create_tmp('2') THEN
   END IF
   #add by geza 20151120(E)
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apmp864.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION apmp864_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('pmdsstus','13','N,Y,S,X')
   CALL cl_set_combo_scc_part('b_pmdsstus','13','N,Y,S,X')
   CALL cl_set_combo_scc('b_pmdt210','6013')  #add by geza 20151031
   #add by geza 20151120(S)
   #天和产品回追
   IF NOT apmp864_create_tmp('1') THEN
   END IF
   #add by geza 20151120(E)
   LET g_wc2 = ' 1=2'
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apmp864.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmp864_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_stus   LIKE type_t.chr30 
   #20151022--add by dongsz--s
   DEFINE la_param    RECORD
          prog        STRING,
          actionid    STRING,
          background  LIKE type_t.chr1,
          param       DYNAMIC ARRAY OF STRING
          END RECORD
   DEFINE ls_js       STRING
   DEFINE l_time      DATETIME YEAR TO SECOND
   #20151022--add by dongsz--e
   DEFINE ls_msg      STRING   #add by geza 20160119
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
  
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apmp864_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc ON pmdssite,pmdsdocdt,pmds201                                   
            BEFORE CONSTRUCT
               CALL cl_set_act_visible("filter",FALSE)
               
            #add by geza 20151120(S)
            #天和回追产品
            AFTER FIELD pmds201
               LET g_pmds201 = GET_FLDBUF(pmds201)
            #add by geza 20151120(E)
            
            ON ACTION controlp INFIELD pmdssite
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_ooef001_24()
               DISPLAY g_qryparam.return1 TO pmdssite
               NEXT FIELD pmdssite
                                          
            ON ACTION controlp INFIELD pmds201
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
#			      LET g_qryparam.arg1 = '22'               #單據類型 #mark by geza 20160108
#               CALL q_pmds201()                       #呼叫開窗  #mark by geza 20160108
               IF g_pmdr011 = 'Y' THEN
                  LET g_qryparam.where = " pmdr011 = 'N'" 
               END IF
               CALL q_pmdrdocno()                       #呼叫開窗  #mark by geza 20160108
               DISPLAY g_qryparam.return1 TO pmds201  #顯示到畫面上
               NEXT FIELD pmds201                     #返回原欄位               
               

         END CONSTRUCT  
         #add by geza 20160105(S)
         CONSTRUCT BY NAME g_wc2 ON pmdsdocno,pmds002,pmds003,pmds007,pmdsstus                                   
            BEFORE CONSTRUCT
               CALL cl_set_act_visible("filter",FALSE)
                           
            ON ACTION controlp INFIELD pmdsdocno
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
			      LET g_qryparam.arg1 = '22'               #單據類型
               CALL q_pmdsdocno()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdsdocno  #顯示到畫面上
               NEXT FIELD pmdsdocno                     #返回原欄位
            
            ON ACTION controlp INFIELD pmds002
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmds002  #顯示到畫面上
               NEXT FIELD pmds002                     #返回原欄位
               
            ON ACTION controlp INFIELD pmds003
	            INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_ooeg001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmds003  #顯示到畫面上
               NEXT FIELD pmds003                     #返回原欄位

            ON ACTION controlp INFIELD pmds007
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_pmaa001_3()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmds007  #顯示到畫面上
               NEXT FIELD pmds007                     #返回原欄位
                              
         END CONSTRUCT  
         #add by geza 20150105(E)
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT ARRAY g_detail_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                       INSERT ROW = FALSE,
                       DELETE ROW = FALSE, 
                       APPEND ROW = FALSE)
            BEFORE INPUT
               LET g_current_page = 1
               CALL cl_set_act_visible("filter",FALSE)
               
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_detail_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
               CALL apmp864_fetch()
               IF g_detail_d[l_ac].sel = 'N' THEN
                  NEXT FIELD sel
               END IF 
         END INPUT 
         
         #add by geza 20160106(S)
         INPUT g_pmdr011,g_checkbox,g_checkbox_1  #add by geza 20160119 g_checkbox_1
           FROM pmdr011,checkbox,checkbox_1       #add by geza 20160119 checkbox_1               
             ATTRIBUTE(WITHOUT DEFAULTS)
        
            BEFORE INPUT 
            
            AFTER INPUT
            
         END INPUT 
         #add by geza 20160106(E)
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_detail2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
         
            BEFORE DISPLAY
               LET g_current_page = 2
               CALL cl_set_act_visible("filter",FALSE)
               
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               DISPLAY g_detail2_d.getLength() TO FORMONLY.cnt
         END DISPLAY
         
         DISPLAY ARRAY g_detail3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)
         
            BEFORE DISPLAY
               LET g_current_page = 3
               CALL cl_set_act_visible("filter",FALSE)
               
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               DISPLAY g_detail3_d.getLength() TO FORMONLY.cnt
         END DISPLAY 
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
            LET g_pmdr011 = 'N'
            LET g_checkbox = 'N'
            LET g_checkbox_1 = 'Y'  #add by geza 20160119
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
               
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone name="ui_dialog.for.onaction_selnone"
               
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
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL apmp864_filter()
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
            CALL g_detail_d.clear()
            #end add-point
            CALL apmp864_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL apmp864_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
#         ON ACTION batch_execute            
#            CALL apmp864_process(l_stus)
#            CALL apmp864_b_fill()
            
         ON ACTION apmp864_delete
            #CALL apmp864_p_delete() #mark by geza 20151030
            #CALL apmp864_b_fill()   #mark by geza 20151030
            #add by geza 20151030(S)
            IF cl_ask_confirm('adz-00145') THEN
               CALL apmp864_p_delete()
               CALL apmp864_b_fill()
            ELSE
               CONTINUE DIALOG
            END IF
            #add by geza 20151030(E) 

         ON ACTION apmp864_confirm
            #CALL apmp864_p_delete() #mark by geza 20151030
            #CALL apmp864_b_fill()   #mark by geza 20151030
            #add by geza 20151030(S)
            IF cl_ask_confirm('aim-00108') THEN
               CALL apmp864_p_confirm() #ad by geza 20151030
               CALL apmp864_b_fill()  
            ELSE
               CONTINUE DIALOG
            END IF
            #add by geza 20151030(E) 
         #20151022--dongsz add--str---
         ON ACTION excel_example
            LET g_action_choice="excel_example"
            IF cl_auth_chk_act("excel_example") THEN

               #add-point:ON ACTION excel_example
               LET la_param.prog = 'awsp200'
               LET la_param.param[1] = g_prog
               LET la_param.param[2] = "excel_example"
               LET ls_js = util.JSON.stringify( la_param )

               CALL cl_cmdrun_wait(ls_js)
               #END add-point

            END IF
            
         ON ACTION excel_load
            LET g_action_choice="excel_load"
            IF cl_auth_chk_act("excel_load") THEN

               #add-point:ON ACTION excel_load
               LET l_time = cl_get_current()
               LET g_time = cl_replace_str(l_time,'-','')
               LET g_time = cl_replace_str(g_time,' ','')
               LET g_time = cl_replace_str(g_time,':','')
               
               LET g_etlparam[1].para_id = "g_docno"
               LET g_etlparam[1].type = "string"
               LET g_etlparam[1].value = g_time
               
               LET la_param.prog = 'awsp200'
               LET la_param.param[1] = g_prog
               LET la_param.param[2] = "excel_load"
               LET la_param.param[3] = util.JSON.stringify(g_etlparam)
               
               LET ls_js = util.JSON.stringify( la_param )
               CALL cl_cmdrun_wait(ls_js)
               #每次導入--來源單號唯一，Excel會自動編號為:g_time,
               #mark by geza 20160107(S)
               #每次導入后--刪除中間表來源單號為g_time的資料                  
#               CALL apmp864_excle_insert(g_time) 
#               DISPLAY g_time TO pmds201   #add by geza 201511120
#               LET g_wc = " pmds201='",g_time,"'" #add by geza 20151030
#               CALL apmp864_b_fill()   #add by geza 20151030
               #mark by geza 20160107(E)               
               DISPLAY g_time TO pmds201   #add by geza 20160107
               LET g_wc = " pmds201='",g_time,"'" #add by geza 20160107
               
               #add by geza 20160119(S)
               #如果Excel导入后自动导入开账作业，默认为Y，excel导入后，自动call开账导入的逻辑
               IF g_checkbox_1 = 'Y' THEN
                  CALL apmp864_excle_insert(g_wc)   
               END IF
               #add by geza 20160119(E)
               
               CALL apmp864_b_fill()   #add by geza 20160107
               #END add-point

            END IF
         #20151022--dongsz add--end---
         
         #add by geza 20160106(S)
         #开账导入功能
         ON ACTION open_load
            LET g_action_choice="open_load"
            IF cl_auth_chk_act("open_load") THEN

               #add-point:ON ACTION open_load
               #add by geza 20160107(S)
               #每次導入后--刪除中間表來源單號為g_time的資料
               #LET g_pmds201 = GET_FLDBUF(pmds201) #mark by geza 20160108
               CALL apmp864_excle_insert(g_wc)                
               CALL apmp864_b_fill()    
               #add by geza 20160107(E)
               #END add-point
            END IF
         #add by geza 20160106(E)
         
         #add by geza 20160119(S)
         #数据清单批量删除
         ON ACTION pmdr_delete
            LET g_action_choice="pmdr_delete"
            IF cl_auth_chk_act("pmdr_delete") THEN

               #add-point:ON ACTION pmdr_delete
#               IF (NOT g_no_ask) THEN    
#                  CALL cl_set_act_visible("accept,cancel", TRUE)    
#                  CALL cl_getmsg('apm-01071',g_lang) RETURNING ls_msg
#                  LET INT_FLAG = 0
#               
#                  PROMPT ls_msg CLIPPED,':' FOR g_jump
#                     #交談指令共用ACTION
#                     &include "common_action.4gl" 
#                  END PROMPT
#               
#                  CALL cl_set_act_visible("accept,cancel", FALSE)             
#               END IF
#               
#               CALL apmp864_pmdr_delete(g_jump)
#               CALL apmp864_b_fill()  
               CALL apmp864_pmdr_clear()
               #END add-point
            END IF
         #add by geza 20160106(E)
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
 
{<section id="apmp864.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION apmp864_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   
   #end add-point
        
   LET g_error_show = 1
   CALL apmp864_b_fill()
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
 
{<section id="apmp864.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apmp864_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_desc          LIKE type_t.chr80
   DEFINE l_wc            STRING #add by geza 20160106
   DEFINE g_detail_cnt_1   LIKE type_t.num10              #add by geza 20160218
   DEFINE g_detail_cnt_2   LIKE type_t.num10              #add by geza 20160218
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(g_wc) THEN 
      LET g_wc = " 1=1"
   END IF
   #add by geza 20160106(S)
   IF cl_null(g_wc2) THEN 
      LET g_wc2 = " 1=1"
   END IF
   LET l_wc = g_wc
   #add by geza 20160106(E)
   
   LET g_wc2 = g_wc2,
              " AND pmds000 = '22' "
   
   LET g_sql = "SELECT 'N',pmdssite,pmdsdocdt,pmds001,pmdsdocno,",
               "       pmds002,pmds003,pmds007,pmds037,pmds033,pmds044,",  #add by geza 20151031 pmds044
               "       pmds045,pmdscrtid,pmdscrtdp,pmdscrtdt,pmdspstid,",
               "       pmdspstdt,pmdsstus  "    ,
               "  FROM pmds_t ",
               " WHERE pmdsent = ? ",
               "   AND ",g_wc CLIPPED,
               "   AND ",g_wc2 CLIPPED,  #add by geza 20160106
               " ORDER BY pmdsdocno "  
   #end add-point
 
   PREPARE apmp864_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apmp864_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
      g_detail_d[l_ac].sel           ,g_detail_d[l_ac].pmdssite      ,g_detail_d[l_ac].pmdsdocdt,
      g_detail_d[l_ac].pmds001       ,g_detail_d[l_ac].pmdsdocno     ,g_detail_d[l_ac].pmds002  ,
      g_detail_d[l_ac].pmds003       ,g_detail_d[l_ac].pmds007       ,g_detail_d[l_ac].pmds037  ,
      g_detail_d[l_ac].pmds033       ,g_detail_d[l_ac].pmds044       ,g_detail_d[l_ac].pmds045       ,g_detail_d[l_ac].pmdscrtid,  #add by geza 20151031 pmds044
      g_detail_d[l_ac].pmdscrtdp     ,g_detail_d[l_ac].pmdscrtdt     ,g_detail_d[l_ac].pmdspstid,
      g_detail_d[l_ac].pmdspstdt     ,g_detail_d[l_ac].pmdsstus       
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

      CALL s_desc_get_department_desc(g_detail_d[l_ac].pmdssite)
         RETURNING g_detail_d[l_ac].pmdssite_desc
      CALL s_desc_get_person_desc(g_detail_d[l_ac].pmds002) RETURNING g_detail_d[l_ac].pmds002_desc
      CALL s_desc_get_department_desc(g_detail_d[l_ac].pmds003) RETURNING g_detail_d[l_ac].pmds003_desc
      CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].pmds007) RETURNING g_detail_d[l_ac].pmds007_desc
      CALL s_desc_get_tax_desc1(g_detail_d[l_ac].pmdssite,g_detail_d[l_ac].pmds033) RETURNING g_detail_d[l_ac].pmds033_desc

      SELECT ooag011 INTO g_detail_d[l_ac].pmdscrtid_desc
        FROM ooag_t
       WHERE ooagent=g_enterprise
         AND ooag001=g_detail_d[l_ac].pmdscrtid
      
      SELECT ooefl003 INTO g_detail_d[l_ac].pmdscrtdp_desc 
        FROM ooefl_t
       WHERE ooeflent=g_enterprise
         AND ooefl001=g_detail_d[l_ac].pmdscrtdp
         AND ooefl002=g_dlang

      SELECT ooag011 INTO g_detail_d[l_ac].pmdspstid_desc
        FROM ooag_t
       WHERE ooagent=g_enterprise
         AND ooag001=g_detail_d[l_ac].pmdspstid
     
      #end add-point
      
      CALL apmp864_detail_show()      
 
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
   FREE apmp864_sel
   
   LET l_ac = 1
   CALL apmp864_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
#   #mark by geza 20160106(S)
#   #資料清單
#   LET g_sql = "SELECT pmdssite,pmdsdocdt,pmds001,pmdsdocno,pmds007,pmdt006,", #add by geza 20151030 pmdt006
#               "       pmdt016,pmdt017,pmdt018,pmdt020,pmdt036,pmdt039,pmdt046,pmdt037, ", #add by geza 20151030 pmdt020,pmdt036,pmdt039
#               "       pmdt213,pmdt212,pmdt211",
#               "  FROM pmds_t,pmdt_t",               
#               " WHERE pmdsent = ? ",
#               "   AND pmdsent=pmdtent",
#               "   AND pmdsdocno=pmdtdocno",
#               "   AND ",g_wc CLIPPED,
#               " ORDER BY pmdsdocno,pmdtseq "  
#               
#   PREPARE astp521_sel2 FROM g_sql
#   DECLARE b_fill_curs2 CURSOR FOR astp521_sel2
#
#
#   CALL g_detail3_d.clear()
#   LET l_ac = 1
#   
#   FOREACH b_fill_curs2 USING g_enterprise INTO 
#      g_detail3_d[l_ac].l_pmdssite      , g_detail3_d[l_ac].l_pmdsdocdt     , g_detail3_d[l_ac].l_pmds001       ,      
#      g_detail3_d[l_ac].l_pmdsdocno     , g_detail3_d[l_ac].l_pmds007       , g_detail3_d[l_ac].l_pmdt006       , 
#      g_detail3_d[l_ac].l_pmdt016       , #add by geza 20151030 pmdt006
#      g_detail3_d[l_ac].l_pmdt017       , g_detail3_d[l_ac].l_pmdt018       , 
#      g_detail3_d[l_ac].l_pmdt020       , g_detail3_d[l_ac].l_pmdt036       , g_detail3_d[l_ac].l_pmdt039       ,  #add by geza 20151031
#      g_detail3_d[l_ac].l_pmdt046       ,
#      g_detail3_d[l_ac].l_pmdt037       , g_detail3_d[l_ac].l_pmdt213       , g_detail3_d[l_ac].l_pmdt212       ,
#      g_detail3_d[l_ac].l_pmdt211       
#   
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "FOREACH:" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
# 
#         EXIT FOREACH
#      END IF   
# 
#      CALL s_desc_get_department_desc(g_detail3_d[l_ac].l_pmdssite)
#         RETURNING g_detail3_d[l_ac].l_pmdssite_desc 
#      CALL s_desc_get_item_desc(g_detail3_d[l_ac].l_pmdt006)
#         RETURNING g_detail3_d[l_ac].l_pmdt006_desc,l_desc    
#      CALL s_desc_get_trading_partner_abbr_desc(g_detail3_d[l_ac].l_pmds007) RETURNING g_detail3_d[l_ac].l_pmds007_desc 
#      CALL s_desc_get_stock_desc('',g_detail3_d[l_ac].l_pmdt016)
#         RETURNING g_detail3_d[l_ac].l_pmdt016_desc    
#      CALL s_desc_get_tax_desc1(g_detail3_d[l_ac].l_pmdssite,g_detail3_d[l_ac].l_pmdt046) 
#         RETURNING g_detail3_d[l_ac].l_pmdt046_desc  
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_detail3_d[l_ac].l_pmdt211
#      CALL ap_ref_array2(g_ref_fields,"SELECT staal003 FROM staal_t WHERE staalent='"||g_enterprise||"' AND staal001=? AND staal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET g_detail3_d[l_ac].l_pmdt211_desc = '', g_rtn_fields[1] , ''  
#
#      LET l_ac = l_ac + 1
#      IF l_ac > g_max_rec THEN
#         IF g_error_show = 1 THEN
#            INITIALIZE g_errparam TO NULL 
#            LET g_errparam.extend =  "" 
#            LET g_errparam.code   =  9035 
#            LET g_errparam.popup  = TRUE 
#            CALL cl_err()
# 
#         END IF
#         EXIT FOREACH
#      END IF
#      
#   END FOREACH
#   LET g_error_show = 0
#   
#   CALL g_detail3_d.deleteElement(l_ac)  
#   #mark by geza 20160106(E)
   LET g_detail_cnt_1 = g_detail_cnt #add by geza 20160218
   #add by geza 20160106(S)
   #資料清單
   LET l_wc = cl_replace_str(l_wc,'pmdssite','pmdrsite')
   LET l_wc = cl_replace_str(l_wc,'pmdsdocdt','pmdrdocdt')
   LET l_wc = cl_replace_str(l_wc,'pmds201','pmdrdocno') 
   IF l_wc IS NULL THEN
      LET l_wc = ' 1=1' 
   END IF
   LET g_sql = "SELECT pmdrdocno,pmdrsite,ooefl003,pmdrdocdt,", 
               "       pmdr001,pmaal003,pmdr002,imaal003, ",
               "       pmdr003,'',pmdr004,inayl003, ",
               "       pmdr005,inab003,pmdr006,pmdr007, ",
               "       pmdr008,pmdr009,pmdr010,pmdr011 ",
               "  FROM pmdr_t", 
               "  LEFT JOIN ooefl_t ON ooeflent = pmdrent AND ooefl001 = pmdrsite AND ooefl002='"||g_dlang||"'", 
               "  LEFT JOIN pmaal_t ON pmaalent = pmdrent AND pmaal001 = pmdr001  AND pmaal002='"||g_dlang||"'", 
               "  LEFT JOIN imaal_t ON imaalent = pmdrent AND imaal001 = pmdr002  AND imaal002='"||g_dlang||"'", 
               "  LEFT JOIN inayl_t ON inaylent = pmdrent AND inayl001 = pmdr004  AND inayl002='"||g_dlang||"'",
               "  LEFT JOIN inab_t  ON inabent  = pmdrent AND inab001  = pmdr004  AND inab002  = pmdr005 ",                
               " WHERE pmdrent = ? ",
               "   AND ",l_wc CLIPPED
   IF g_pmdr011 = 'Y' THEN
      LET g_sql = g_sql,"   AND pmdr011 = 'N'"
   END IF               
   LET g_sql = g_sql," ORDER BY pmdrdocno,pmdrsite,pmdrdocdt,pmdr001,pmdr002 "  
               
   PREPARE apmp864_sel2  FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR apmp864_sel2


   CALL g_detail3_d.clear()
   LET l_ac = 1
   
   FOREACH b_fill_curs2 USING g_enterprise INTO 
      g_detail3_d[l_ac].pmdrdocno  , g_detail3_d[l_ac].pmdrsite    , g_detail3_d[l_ac].pmdrsite_desc , g_detail3_d[l_ac].pmdrdocdt ,     
      g_detail3_d[l_ac].pmdr001    , g_detail3_d[l_ac].pmdr001_desc, g_detail3_d[l_ac].pmdr002       , g_detail3_d[l_ac].pmdr002_desc , 
      g_detail3_d[l_ac].pmdr003    , g_detail3_d[l_ac].pmdr003_desc, g_detail3_d[l_ac].pmdr004       , g_detail3_d[l_ac].pmdr004_desc , 
      g_detail3_d[l_ac].pmdr005    , g_detail3_d[l_ac].pmdr005_desc, g_detail3_d[l_ac].pmdr006       , g_detail3_d[l_ac].pmdr007 , 
      g_detail3_d[l_ac].pmdr008    , g_detail3_d[l_ac].pmdr009     , g_detail3_d[l_ac].pmdr010       , g_detail3_d[l_ac].pmdr011       
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF   
 
      CALL s_desc_get_tax_desc1(g_detail3_d[l_ac].pmdrsite,g_detail3_d[l_ac].pmdr003) RETURNING g_detail3_d[l_ac].pmdr003_desc

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
   
   CALL g_detail3_d.deleteElement(l_ac) 
   LET g_detail_cnt_2 = l_ac - 1  #add by geza 20160218
   #add by geza 20160218(S)
   IF g_detail_cnt_1 = 0 AND g_detail_cnt_2 = 0 THEN
      LET g_detail_cnt = 0
   ELSE
      IF g_detail_cnt_2 != 0 THEN
         LET g_detail_cnt = g_detail_cnt_2
      ELSE
         LET g_detail_cnt = g_detail_cnt_1      
      END IF
   END IF
   DISPLAY g_detail_cnt_2 TO FORMONLY.h_count
   #LET g_detail_cnt = l_ac - 1 
   #add by geza 20160218(S)   
   #add by geza 20160106(E)   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmp864.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apmp864_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   DEFINE l_pmdsdocno     LIKE pmds_t.pmdsdocno
   DEFINE l_pmdssite      LIKE pmds_t.pmdssite
   DEFINE l_desc          LIKE type_t.chr80
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   CALL g_detail2_d.clear()
   IF g_detail_idx = 0 THEN
      LET g_detail_idx = 1
   END IF
   LET l_pmdsdocno=g_detail_d[l_ac].pmdsdocno
   LET l_pmdssite= g_detail_d[l_ac].pmdssite  
   
   LET g_sql = "SELECT pmdtseq,pmdt200,pmdt006,pmdt020,pmdt036,pmdt039,pmdt019,", #add by geza 20151031 pmdt039
               "       pmdt016,pmdt017,pmdt018,pmdt046,pmdt037,pmdt213,", 
               "       pmdt212,pmdt210,pmdt211",
               #"  FROM pmdt_t ", #mark by geza 20151030
               "  FROM pmdt_t,pmds_t ",  #add by geza 20151030   
               " WHERE pmdtent = ",g_enterprise,
               "   AND pmdtdocno = '",l_pmdsdocno CLIPPED,"' ",
               "   AND pmdtdocno = pmdsdocno AND pmdtent = pmdsent ",  #add by geza 20151030   
               #"   AND pmdt000='22'",   #mark by geza 20151030
               "   AND pmds000='22'",    #add by geza 20151030               
               " ORDER BY pmdtseq "
   PREPARE apmp864_b_fill_pre2 FROM g_sql
   DECLARE apmp864_b_fill_cur2 CURSOR FOR apmp864_b_fill_pre2   
   
   LET l_ac = 1
   
   FOREACH apmp864_b_fill_cur2 INTO 
       g_detail2_d[l_ac].pmdtseq, g_detail2_d[l_ac].pmdt200, g_detail2_d[l_ac].pmdt006, 
       g_detail2_d[l_ac].pmdt020, g_detail2_d[l_ac].pmdt036, g_detail2_d[l_ac].pmdt039, g_detail2_d[l_ac].pmdt019, #add by geza 20151031 pmdt039
       g_detail2_d[l_ac].pmdt016, g_detail2_d[l_ac].pmdt017, g_detail2_d[l_ac].pmdt018,  
       g_detail2_d[l_ac].pmdt046, g_detail2_d[l_ac].pmdt037, g_detail2_d[l_ac].pmdt213,  
       g_detail2_d[l_ac].pmdt212, g_detail2_d[l_ac].pmdt210, g_detail2_d[l_ac].pmdt211                               

      CALL s_desc_get_item_desc(g_detail2_d[l_ac].pmdt006)
         RETURNING g_detail2_d[l_ac].pmdt006_desc,l_desc
      CALL s_desc_get_unit_desc(g_detail2_d[l_ac].pmdt019)
         RETURNING g_detail2_d[l_ac].pmdt019_desc   
      CALL s_desc_get_stock_desc('',g_detail2_d[l_ac].pmdt016)
         RETURNING g_detail2_d[l_ac].pmdt016_desc     
      CALL s_desc_get_locator_desc(l_pmdssite,g_detail2_d[l_ac].pmdt016,g_detail2_d[l_ac].pmdt017)
         RETURNING  g_detail2_d[l_ac].pmdt017_desc    
      CALL s_desc_get_tax_desc1(l_pmdssite,g_detail2_d[l_ac].pmdt046) 
         RETURNING g_detail2_d[l_ac].pmdt046_desc   
         
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail2_d[l_ac].pmdt211
      CALL ap_ref_array2(g_ref_fields,"SELECT staal003 FROM staal_t WHERE staalent='"||g_enterprise||"' AND staal001=? AND staal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail2_d[l_ac].pmdt211_desc = '', g_rtn_fields[1] , ''        
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ""
            LET g_errparam.popup = TRUE
            CALL cl_err()

         END IF
         EXIT FOREACH
      END IF   
   END FOREACH   

   CALL g_detail2_d.deleteElement(l_ac)
   LET g_detail2_cnt = l_ac - 1 
   DISPLAY g_detail2_cnt TO FORMONLY.cnt  
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="apmp864.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apmp864_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmp864.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION apmp864_filter()
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
   
   CALL apmp864_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="apmp864.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION apmp864_filter_parser(ps_field)
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
 
{<section id="apmp864.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION apmp864_filter_show(ps_field,ps_object)
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
   LET ls_condition = apmp864_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apmp864.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 批次處理
# Memo...........:
# Usage..........: CALL apmp864_process(p_stus)
# Input parameter: p_stus         處理狀態
# Date & Author..: 2015/10/19 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp864_process(p_stus)
DEFINE p_stus      LIKE type_t.chr30
DEFINE li_idx      LIKE type_t.num5
DEFINE l_cnt       LIKE type_t.num5
DEFINE l_pmdsmodid LIKE pmds_t.pmdsmodid 
DEFINE l_pmdsmoddt LIKE pmds_t.pmdsmoddt  
DEFINE l_pmdsstus  LIKE pmds_t.pmdsstus
DEFINE l_success   LIKE type_t.num5



   LET l_cnt = 0 
   CALL cl_err_collect_init()


        
   FOR li_idx = 1 TO g_detail_d.getLength()
      IF g_detail_d[li_idx].sel = "Y" THEN
         LET l_cnt = l_cnt + 1
         CALL s_transaction_begin()  
        CASE p_stus
           WHEN "conf"
              
              CALL apmp864_stus_chk(g_detail_d[li_idx].pmdsdocno,g_detail_d[li_idx].pmdsstus,'conf') RETURNING l_success
              IF l_success THEN
                 CALL s_apmt860_conf_chk(g_detail_d[li_idx].pmdsdocno) RETURNING l_success 
                 IF l_success THEN
                    CALL s_apmt860_conf_upd(g_detail_d[li_idx].pmdsdocno) RETURNING l_success
                    IF l_success THEN
                       LET l_pmdsmodid = g_user
                       LET l_pmdsmoddt = cl_get_current()
                       LET l_pmdsstus = 'Y'                
                       UPDATE pmds_t 
                          SET (pmdsstus,pmdsmodid,pmdsmoddt) 
                            = (l_pmsstus,l_pmdsmodid,l_pmdsmoddt)     
                        WHERE pmdsent = g_enterprise 
                          AND pmdsdocno = g_detail_d[li_idx].pmdsdocno   
                    END IF                       
                 END IF
              END IF
              

           WHEN "invalid"
              CALL apmp864_stus_chk(g_detail_d[li_idx].pmdsdocno,g_detail_d[li_idx].pmdsstus,'invalid') RETURNING l_success
              IF l_success THEN           
                 CALL s_apmt860_invalid_chk(g_detail_d[li_idx].pmdsdocno) RETURNING l_success
                 IF l_success THEN
                    CALL s_apmt860_invalid_upd(g_detail_d[li_idx].pmdsdocno) RETURNING l_success
                    IF l_success THEN
                       LET l_pmdsmodid = g_user
                       LET l_pmdsmoddt = cl_get_current()
                       LET l_pmdsstus = 'X'                
                       UPDATE pmds_t 
                          SET (pmdsstus,pmdsmodid,pmdsmoddt) 
                            = (l_pmsstus,l_pmdsmodid,l_pmdsmoddt)     
                        WHERE pmdsent = g_enterprise 
                          AND pmdsdocno = g_detail_d[li_idx].pmdsdocno   
                    END IF                     
                 END IF
              END IF
              
           WHEN "posted"
              CALL apmp864_stus_chk(g_detail_d[li_idx].pmdsdocno,g_detail_d[li_idx].pmdsstus,'posted') RETURNING l_success
              IF l_success THEN           
                 CALL s_apmt860_posted_chk(g_detail_d[li_idx].pmdsdocno) RETURNING l_success
                 IF l_success THEN
                    CALL s_apmt860_posted_upd(g_detail_d[li_idx].pmdsdocno) RETURNING l_success
                    IF l_success THEN
                       LET l_pmdsmodid = g_user
                       LET l_pmdsmoddt = cl_get_current()
                       LET l_pmdsstus = 'S'                
                       UPDATE pmds_t 
                          SET (pmdsstus,pmdsmodid,pmdsmoddt) 
                            = (l_pmsstus,l_pmdsmodid,l_pmdsmoddt)     
                        WHERE pmdsent = g_enterprise 
                          AND pmdsdocno = g_detail_d[li_idx].pmdsdocno   
                    END IF                     
                 END IF 
              END IF              
              
        END CASE 
        IF l_success THEN 
           #CALL s_transaction_end('Y',1)  #mark by geza 20151030
           CALL s_transaction_end('Y','0')   #add by geza 20151030
        ELSE
           CALL s_transaction_end('N',0)
        END IF
           
        
      END IF
   END FOR
           

   CALL cl_err_collect_show()
   
   IF l_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adb-00078'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
    
      RETURN
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 单据状态检查
# Memo...........:
# Usage..........: CALL apmp864_stus_chk(p_pmdsstus,p_stus)
#                  RETURNING r_success 
# Input parameter: p_pmdsstus     单据状态
#                : p_pmdsdocno    单号
#                : p_stus         删除、审核、過帐、作废动作
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 20151020 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp864_stus_chk(p_pmdsdocno,p_pmdsstus,p_stus)
DEFINE p_pmdsstus        LIKE pmds_t.pmdsstus
DEFINE p_pmdsdocno       LIKE pmds_t.pmdsdocno
DEFINE p_stus            LIKE pmds_t.pmdsstus
DEFINE r_success         LIKE type_t.num5


#原来sub的s_apmt860..中检查没有关于状态的检查，所以，现在自己添加检查
   LET r_success=TRUE
   
   
   CASE p_pmdsstus
      WHEN 'N'  
         IF p_stus='posted' THEN  #未審核不可以過帳
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'apm-01007'
            LET g_errparam.extend = p_pmdsdocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success =FALSE
            
            RETURN r_success
         END IF
      WHEN 'Y'
         IF p_stus='del' THEN #審核不可以刪除
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'afa-00005'
            LET g_errparam.extend = p_pmdsdocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success =FALSE
            
            RETURN r_success
         END IF               
         IF p_stus='invalid' THEN #審核不可以作廢
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'ain-00088'
            LET g_errparam.extend = p_pmdsdocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success =FALSE
            
            RETURN r_success
         END IF          
         IF p_stus='conf' THEN #審核不可以再次審核
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'ain-00084'
            LET g_errparam.extend = p_pmdsdocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success =FALSE
            
            RETURN r_success
         END IF    
      WHEN 'X'  #作廢資料不可以異動
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'afa-00023'
         LET g_errparam.extend = p_pmdsdocno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success =FALSE
         
         RETURN r_success   
      WHEN 'S'  
         IF p_stus='posted' THEN  #過帳不可以再次過帳
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'apm-01008'
            LET g_errparam.extend = p_pmdsdocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success =FALSE
            
            RETURN r_success
         END IF
         IF p_stus='del' THEN #過帳不可以刪除
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'apm-01009'
            LET g_errparam.extend = p_pmdsdocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success =FALSE
            
            RETURN r_success
         END IF               
         IF p_stus='invalid' THEN #過帳不可以作廢
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'ais-00091'
            LET g_errparam.extend = p_pmdsdocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success =FALSE
            
            RETURN r_success
         END IF          
         IF p_stus='conf' THEN #過帳不可以審核
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'ain-00216'
            LET g_errparam.extend = p_pmdsdocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success =FALSE
            
            RETURN r_success
         END IF 

      END CASE 

      RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 批量删除
# Memo...........:
# Usage..........: CALL apmp864_p_delete()
# Input parameter: 
# Return code....: 
# Date & Author..: 20151020 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp864_p_delete()
DEFINE li_idx      LIKE type_t.num5
DEFINE l_cnt       LIKE type_t.num5
DEFINE l_success   LIKE type_t.num5

   LET l_cnt = 0 
   CALL cl_err_collect_init()


        
   FOR li_idx = 1 TO g_detail_d.getLength()
      IF g_detail_d[li_idx].sel = "Y" THEN
         LET l_cnt = l_cnt + 1
         CALL s_transaction_begin()
         CALL apmp864_stus_chk(g_detail_d[li_idx].pmdsdocno,g_detail_d[li_idx].pmdsstus,'del') RETURNING l_success
         IF l_success THEN
            DELETE FROM pmds_t WHERE pmdsent = g_enterprise AND pmdsdocno = g_detail_d[li_idx].pmdsdocno
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_detail_d[li_idx].pmdsdocno
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET l_success =FALSE
            END IF            
            DELETE FROM pmdt_t WHERE pmdtent = g_enterprise AND pmdtdocno = g_detail_d[li_idx].pmdsdocno
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_detail_d[li_idx].pmdsdocno
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET l_success =FALSE
            END IF    
            DELETE FROM pmdu_t WHERE pmduent = g_enterprise AND pmdudocno = g_detail_d[li_idx].pmdsdocno
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_detail_d[li_idx].pmdsdocno
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET l_success =FALSE
            END IF
         END IF            
         IF l_success THEN 
            #CALL s_transaction_end('Y',1)    #mark by geza 20151030
            CALL s_transaction_end('Y','0')   #add by geza 20151030
         ELSE
            CALL s_transaction_end('N',0)
         END IF         

      END IF
   END FOR
           
   CALL cl_err_collect_show()
   
   IF l_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adb-00078'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
    
      RETURN
   END IF 




END FUNCTION

################################################################################
# Descriptions...: 批量確認并過帳
# Memo...........:
# Usage..........: CALL apmp864_p_confirm()
# Input parameter: 
# Return code....: 
# Date & Author..: 20151026 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp864_p_confirm()
DEFINE li_idx      LIKE type_t.num5
DEFINE l_cnt       LIKE type_t.num5
DEFINE l_success   LIKE type_t.num5
DEFINE l_pmdsmodid LIKE pmds_t.pmdsmodid 
DEFINE l_pmdsmoddt LIKE pmds_t.pmdsmoddt  
DEFINE l_pmdsstus  LIKE pmds_t.pmdsstus
DEFINE r_success   LIKE type_t.num5

   LET l_cnt = 0 
   CALL cl_err_collect_init()

        
   FOR li_idx = 1 TO g_detail_d.getLength()
      IF g_detail_d[li_idx].sel = "Y" THEN
         LET l_cnt = l_cnt + 1
         LET r_success = TRUE      #add by geza 20151031
         CALL s_transaction_begin()
         #審核
         CALL apmp864_stus_chk(g_detail_d[li_idx].pmdsdocno,g_detail_d[li_idx].pmdsstus,'conf') RETURNING l_success
         IF l_success THEN
            CALL s_apmt860_conf_chk(g_detail_d[li_idx].pmdsdocno) RETURNING l_success 
         END IF        
         IF l_success THEN
            CALL s_apmt860_conf_upd(g_detail_d[li_idx].pmdsdocno) RETURNING l_success
         END IF
         LET g_detail_d[li_idx].pmdsstus = 'Y'    #add by geza 20151120 天和回追产品
         #過帳
         IF l_success THEN          
            CALL apmp864_stus_chk(g_detail_d[li_idx].pmdsdocno,g_detail_d[li_idx].pmdsstus,'posted') RETURNING l_success
         END IF         
         IF l_success THEN           
            CALL s_apmt860_posted_chk(g_detail_d[li_idx].pmdsdocno) RETURNING l_success
         END IF
         IF l_success THEN
            CALL s_apmt860_posted_upd(g_detail_d[li_idx].pmdsdocno) RETURNING l_success
         END IF
         IF l_success THEN
             LET l_pmdsmodid = g_user
             LET l_pmdsmoddt = cl_get_current()
             LET l_pmdsstus = 'S'                
             UPDATE pmds_t 
                SET (pmdsstus,pmdsmodid,pmdsmoddt) 
                  = (l_pmsstus,l_pmdsmodid,l_pmdsmoddt)     
              WHERE pmdsent = g_enterprise 
                AND pmdsdocno = g_detail_d[li_idx].pmdsdocno   
         END IF                     
        
         IF l_success THEN 
            #CALL s_transaction_end('Y',1)    #mark by geza 20151030
            CALL s_transaction_end('Y','0')   #add by geza 20151030
         ELSE
            CALL s_transaction_end('N',0)
         END IF         

      END IF
   END FOR
           
   CALL cl_err_collect_show()
   
   IF l_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adb-00078'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
    
      RETURN
   END IF 


END FUNCTION

################################################################################
# Descriptions...: Excel導入后，數據處理
# Memo...........:
# Usage..........: CALL apmp864_excle_insert(p_docno)
# Input parameter: p_docno        來源單號
# Return code....: 
# Date & Author..: 20151027 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp864_excle_insert(p_docno)
#DEFINE p_docno       LIKE pmds_t.pmds201 #mark by geza 20160108
DEFINE l_success     LIKE type_t.num5
DEFINE p_docno       STRING  #add by geza 20160108
DEFINE l_wc          STRING  #add by geza 20160108
    LET l_wc = cl_replace_str(p_docno,'pmdssite','pmdrsite')
    LET l_wc = cl_replace_str(l_wc,'pmdsdocdt','pmdrdocdt')
    LET l_wc = cl_replace_str(l_wc,'pmds201','pmdrdocno')
    IF l_wc IS NULL THEN
       LET l_wc = ' 1=1'
    END IF
    #前提摘要：
    #1:Excel每次導入--來源單號唯一，Excel會自動編號為:p_docno,也就是中間表pmdr_t.pmdrdocno唯一
    
    #資料檢查   
    #CALL apmp864_excel_check(p_docno) RETURNING l_success #mark by geza 20160108
    CALL apmp864_excel_check(l_wc) RETURNING l_success #add by geza 20160108
    IF NOT l_success THEN
       RETURN
    END IF
    
    #從中間表pmdr_t插入到pmds_t,pmds_t,pmdu_t,xrcd_t
    #CALL apmp864_excel_insertpms(p_docno) RETURNING l_success #mark by geza 20160108
    CALL apmp864_excel_insertpms(l_wc) RETURNING l_success     #add by geza 20160108
    IF NOT l_success THEN
       RETURN
    END IF    
    
    #每次導入后--按照領導要求，刪除中間表來源單號為g_time的資料 
    #CALL apmp864_excel_deletepmdr(p_docno) RETURNING l_success  #mark by geza 20151120  天和回追产品
    IF NOT l_success THEN
       RETURN
    END IF        
        

END FUNCTION

################################################################################
# Descriptions...: EXCEL導入檢查
# Memo...........:
# Usage..........: CALL apmp864_excel_check(p_docno)
#                  RETURNING r_success
# Input parameter: p_docno        來源單號
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 20151027 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp864_excel_check(p_docno)
#DEFINE p_docno       LIKE pmds_t.pmds201 #mark by geza 20160108
DEFINE r_success     LIKE type_t.num5
DEFINE l_count       LIKE type_t.num5
#add by geza 20151120(S)
#天和回追产品
DEFINE l_tmp         RECORD
            #pmdr000  LIKE type_t.chr1,  #mark by geza 20160119
            pmdr000  LIKE type_t.chr5,  #add by geza 20160119
            pmdrsite LIKE pmdr_t.pmdrsite,
            pmdr001  LIKE pmdr_t.pmdr001,
            pmdr002  LIKE pmdr_t.pmdr003,
            pmdr006  LIKE pmdr_t.pmdr006
                     END RECORD
#add by geza 20151120(E)
DEFINE l_sql         STRING    #add by geza 20160108
DEFINE p_docno       STRING    #add by geza 20160108
    #資料檢查
    #1.供应商存在于供应商基本资料并审核
    #2.商品存在于商品主档并审核
    #3.商品存在于门店商品清单和门店采购协议
    #4.开账批次编号前面加上开账组织编号，并且跟系统批次编号不重复
    #5.excel中的开账组织+商品+開賬日期+供应商+库区+批號 不能重复 
    
    LET r_success=TRUE

    CALL cl_err_collect_init()
    
    #中間表是否有資料
    LET l_count=0
    LET l_sql = "SELECT COUNT(*) ",
                "  FROM pmdr_t   ",
                " WHERE pmdrent=",g_enterprise,""
    IF p_docno IS NOT NULL THEN
       LET l_sql = l_sql," AND ",p_docno
    END IF    
                   
    PREPARE sel_pmdr_pre FROM l_sql
    EXECUTE sel_pmdr_pre INTO l_count
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = "sel pmdr_t" 
       LET g_errparam.code   = SQLCA.sqlcode
       LET g_errparam.popup  = TRUE 
       CALL cl_err()            
       LET r_success = FALSE                
    END IF    
    IF cl_null(l_count) OR l_count=0 THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = 'apm-01014'
       LET g_errparam.extend = ''
       LET g_errparam.popup = TRUE
       CALL cl_err()
        
       LET r_success=FALSE  
    END IF       
    
    #mark by geza 20151120(S)
    #天和回追产品
    #供應商
#    LET l_count=0
#    SELECT COUNT(*) INTO l_count
#      FROM pmdr_t
#     WHERE pmdrent=g_enterprise
#       AND pmdrdocno=p_docno
#       AND NOT EXISTS(SELECT 1 
#                        FROM pmaa_t
#                       WHERE pmaaent=g_enterprise
#                         AND (pmaa002 = '1' OR pmaa002 = '3')
#                         AND pmaastus='Y'
#                         AND pmaa001=pmdr001)
#     IF NOT cl_null(l_count) AND l_count>0 THEN
#        INITIALIZE g_errparam TO NULL
#        LET g_errparam.code = 'apm-01015'
#        LET g_errparam.extend = ''
#        LET g_errparam.popup = TRUE
#        CALL cl_err()
#         
#        LET r_success=FALSE 
#     END IF
#    
#    #商品存在於商品基本資料
#    LET l_count=0
#    SELECT COUNT(*) INTO l_count
#      FROM pmdr_t
#     WHERE pmdrent=g_enterprise
#       AND pmdrdocno=p_docno
#       AND NOT EXISTS(SELECT 1 
#                        FROM imaa_t
#                       WHERE imaaent=g_enterprise
#                         AND imaastus='Y'
#                         AND imaa001=pmdr002)
#     IF NOT cl_null(l_count) AND l_count>0 THEN
#        INITIALIZE g_errparam TO NULL
#        LET g_errparam.code = 'apm-01016'
#        LET g_errparam.extend = ''
#        LET g_errparam.popup = TRUE
#        CALL cl_err()
#         
#        LET r_success=FALSE 
#     END IF     
#
#   #商品存在于門店商品清單
#    LET l_count=0
#    SELECT COUNT(*) INTO l_count
#      FROM pmdr_t
#     WHERE pmdrent=g_enterprise
#       AND pmdrdocno=p_docno
#       AND NOT EXISTS(SELECT 1 
#                        FROM rtdx_t
#                       WHERE rtdxent=g_enterprise
#                         AND rtdxstus='Y'
#                         AND rtdx001=pmdr002
#                         AND rtdxsite=pmdrsite)
#     IF NOT cl_null(l_count) AND l_count>0 THEN
#        INITIALIZE g_errparam TO NULL
#        LET g_errparam.code = 'apm-01017'
#        LET g_errparam.extend = ''
#        LET g_errparam.popup = TRUE
#        CALL cl_err()
#         
#        LET r_success=FALSE 
#     END IF       
#         
#    #商品存在于門店門店採購協議
#    LET l_count=0
#    SELECT COUNT(*) INTO l_count
#      FROM pmdr_t
#     WHERE pmdrent=g_enterprise
#       AND pmdrdocno=p_docno
#       AND NOT EXISTS(SELECT 1 
#                        FROM star_t,stas_t
#                       WHERE starent=stasent
#                         AND star001=stas001
#                         AND starsite=stassite
#                         AND starsite=pmdrsite
#                         AND star003=pmdr001
#                         AND starent=g_enterprise
#                         AND starstus='Y'
#                         AND stas003=pmdr002
#                         AND starsite=pmdrsite
#                         #AND stas018<=g_today  #mark by geza 20151030
#                         #AND stas019>=g_today  #mark by geza 20151030
#                         )
#     IF NOT cl_null(l_count) AND l_count>0 THEN
#        INITIALIZE g_errparam TO NULL
#        LET g_errparam.code = 'apm-01018'
#        LET g_errparam.extend = ''
#        LET g_errparam.popup = TRUE
#        CALL cl_err()
#         
#        LET r_success=FALSE 
#     END IF 
#
#    #开账批次编号前面加上开账组织编号，并且跟系统批次编号不重复
#    LET l_count=0
#    SELECT COUNT(*) INTO l_count
#      FROM pmdr_t
#     WHERE pmdrent=g_enterprise
#       AND pmdrdocno=p_docno
#       AND EXISTS(SELECT 1 
#                    FROM inag_t
#                   WHERE inagent=g_enterprise
#                     #AND inag006=pmdrsite||pmdr006   #mark by geza 20151030
#                     AND inag006=pmdr006    #add by geza 20151030
#                     #AND inagsite=pmdrsite #mark by geza 20151030
#                     )
#    #add by geza 20151030(S)
##    LET l_count=0
##    SELECT COUNT(*) INTO l_count
##      FROM pmdr_t
##     WHERE pmdrent=g_enterprise
##       AND pmdrdocno=p_docno
##       AND NOT EXISTS(SELECT 1  
##                        FROM pmdt_t
##                       WHERE pmdtent=g_enterprise
##                         AND pmdtent=pmdrent
##                         AND pmdr006=pmdt018)
#      #add by geza 20151030(E)                         
#     IF NOT cl_null(l_count) AND l_count>0 THEN
#        INITIALIZE g_errparam TO NULL
#        LET g_errparam.code = 'apm-01020'
#        LET g_errparam.extend = ''
#        LET g_errparam.popup = TRUE
#        CALL cl_err()
#         
#        LET r_success=FALSE  
#     END IF
#    #add by geza 20151031(S)
#    LET l_count=0
#    SELECT COUNT(*) INTO l_count
#      FROM pmdr_t
#     WHERE pmdrent=g_enterprise
#       AND pmdrdocno=p_docno
#       AND EXISTS(SELECT 1  
#                        FROM pmdt_t
#                       WHERE pmdtent=g_enterprise
#                         AND pmdtent=pmdrent
#                         AND pmdr006=pmdt018)                              
#     IF NOT cl_null(l_count) AND l_count>0 THEN
#        INITIALIZE g_errparam TO NULL
#        LET g_errparam.code = 'apm-01020'
#        LET g_errparam.extend = ''
#        LET g_errparam.popup = TRUE
#        CALL cl_err()
#         
#        LET r_success=FALSE  
#     END IF
#     #add by geza 20151031(E) 
#     #开账组织+開賬日期+供应商+商品+库区+批號 不能重复 
#     LET l_count=0
#     SELECT COUNT(*) INTO l_count
#       FROM pmdr_t
#      WHERE pmdrent=g_enterprise
#        AND pmdrdocno=p_docno
#      GROUP BY pmdrsite,pmdrdocdt,pmdr001,pmdr002,pmdr004,pmdr006
#     HAVING COUNT(*)>1 
#     IF NOT cl_null(l_count) AND l_count>0 THEN
#        INITIALIZE g_errparam TO NULL
#        LET g_errparam.code = 'apm-01021'
#        LET g_errparam.extend = ''
#        LET g_errparam.popup = TRUE
#        CALL cl_err()
#         
#        LET r_success=FALSE  
#     END IF     
    #mark by geza 20151120(E)  
    
    #add by geza 20151120(S)
    #天和回追产品
    DELETE FROM apmp864_tmp
    #mark by geza 20160108(S)
#    #供應商不在供应商主档中，或未审核
#    INSERT INTO apmp864_tmp (pmdr000,pmdrsite,pmdr001,pmdr002,pmdr006)
#    SELECT DISTINCT '1',pmdrsite,pmdr001,pmdr002,pmdr006
#      FROM pmdr_t
#     WHERE pmdrent=g_enterprise
#       AND pmdrdocno=p_docno
#       AND pmdr011 = 'N'  #add by geza 20160107
#       AND NOT EXISTS(SELECT 1 
#                        FROM pmaa_t
#                       WHERE pmaaent=g_enterprise
#                         AND (pmaa002 = '1' OR pmaa002 = '3')
#                         AND pmaastus='Y'
#                         AND pmaa001=pmdr001)
#    #商品不存在於商品基本資料
#    INSERT INTO apmp864_tmp (pmdr000,pmdrsite,pmdr001,pmdr002,pmdr006)
#    SELECT DISTINCT '2',pmdrsite,pmdr001,pmdr002,pmdr006
#      FROM pmdr_t
#     WHERE pmdrent=g_enterprise
#       AND pmdrdocno=p_docno
#       AND pmdr011 = 'N'  #add by geza 20160107
#       AND NOT EXISTS(SELECT 1 
#                        FROM imaa_t
#                       WHERE imaaent=g_enterprise
#                         AND imaastus='Y'
#                         AND imaa001=pmdr002)
#                         
#                         
#    IF g_checkbox = 'N' THEN   #不存在于门店商品清单是否自动新增=N，才提示商品在门店商品清单和采购协议不存在的报错 #add by geza 20160107
#       #商品不存在于門店商品清單
#       INSERT INTO apmp864_tmp (pmdr000,pmdrsite,pmdr001,pmdr002,pmdr006)
#       SELECT DISTINCT '3',pmdrsite,pmdr001,pmdr002,pmdr006
#         FROM pmdr_t
#        WHERE pmdrent=g_enterprise
#          AND pmdrdocno=p_docno
#          AND pmdr011 = 'N'  #add by geza 20160107
#          AND NOT EXISTS(SELECT 1 
#                           FROM rtdx_t
#                          WHERE rtdxent=g_enterprise
#                            AND rtdxstus='Y'
#                            AND rtdx001=pmdr002
#                            AND rtdxsite=pmdrsite)
#        
#       #商品不存在于門店門店採購協議
#       INSERT INTO apmp864_tmp (pmdr000,pmdrsite,pmdr001,pmdr002,pmdr006)
#       SELECT DISTINCT '4',pmdrsite,pmdr001,pmdr002,pmdr006
#         FROM pmdr_t
#        WHERE pmdrent=g_enterprise
#          AND pmdrdocno=p_docno
#          AND pmdr011 = 'N'  #add by geza 20160107
#          AND NOT EXISTS(SELECT 1 
#                           FROM star_t,stas_t
#                          WHERE starent=stasent
#                            AND star001=stas001
#                            AND starsite=stassite
#                            AND starsite=pmdrsite
#                            AND star003=pmdr001
#                            AND starent=g_enterprise
#                            AND starstus='Y'
#                            AND stas003=pmdr002
#                            AND starsite=pmdrsite
#                            #AND stas018<=g_today  #mark by geza 20151030
#                            #AND stas019>=g_today  #mark by geza 20151030
#                            )
#    END IF                        
#       
#    #开账批次编号前面加上开账组织编号，并且跟系统批次编号不重复
#    INSERT INTO apmp864_tmp (pmdr000,pmdrsite,pmdr001,pmdr002,pmdr006)
#    SELECT DISTINCT '5',pmdrsite,pmdr001,pmdr002,pmdr006
#      FROM pmdr_t,inag_t
#     WHERE pmdrent=g_enterprise
#       AND pmdrdocno=p_docno
#       AND pmdr011 = 'N'  #add by geza 20160107
#       AND inagent = pmdrent AND inag006=pmdr006
#       
#    INSERT INTO apmp864_tmp (pmdr000,pmdrsite,pmdr001,pmdr002,pmdr006)
#    SELECT DISTINCT '6',pmdrsite,pmdr001,pmdr002,pmdr006
#      FROM pmdr_t,pmdt_t
#     WHERE pmdrent=g_enterprise
#       AND pmdrdocno=p_docno
#       AND pmdr011 = 'N'  #add by geza 20160107
#       AND pmdtent = pmdrent AND pmdr006=pmdt018 
#       
#     #开账组织+開賬日期+供应商+商品+库区+批號 不能重复 
#    INSERT INTO apmp864_tmp (pmdr000,pmdrsite,pmdr001,pmdr002,pmdr006)
#    SELECT DISTINCT '7',pmdrsite,pmdr001,pmdr002,pmdr006
#       FROM pmdr_t
#      WHERE pmdrent=g_enterprise
#        AND pmdrdocno=p_docno
#        AND pmdr011 = 'N'  #add by geza 20160107
#      GROUP BY pmdrsite,pmdrdocdt,pmdr001,pmdr002,pmdr004,pmdr006
#     HAVING COUNT(*)>1 
    #mark by geza 20160108(E)
    
    #add by geza 20160108(S)
    #供應商不在供应商主档中，或未审核
    LET l_sql = " INSERT INTO apmp864_tmp (pmdr000,pmdrsite,pmdr001,pmdr002,pmdr006)
                  SELECT DISTINCT '1',pmdrsite,pmdr001,pmdr002,pmdr006
                    FROM pmdr_t
                   WHERE pmdrent=",g_enterprise,"
                     AND pmdr011 = 'N'    
                     AND NOT EXISTS(SELECT 1 
                                      FROM pmaa_t
                                     WHERE pmaaent=pmdrent
                                       AND (pmaa002 = '1' OR pmaa002 = '3')
                                       AND pmaastus='Y'
                                       AND pmaa001=pmdr001) "
    IF p_docno IS NOT NULL THEN
       LET l_sql = l_sql," AND ",p_docno
    END IF                       
    PREPARE ins_apmp864_tmp_pre1 FROM l_sql
    EXECUTE ins_apmp864_tmp_pre1  
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = "ins apmp864_tmp" 
       LET g_errparam.code   = SQLCA.sqlcode
       LET g_errparam.popup  = TRUE 
       CALL cl_err()            
       LET r_success = FALSE                
    END IF                        
    #商品不存在於商品基本資料
    LET l_sql = " INSERT INTO apmp864_tmp (pmdr000,pmdrsite,pmdr001,pmdr002,pmdr006)
                  SELECT DISTINCT '2',pmdrsite,pmdr001,pmdr002,pmdr006
                    FROM pmdr_t
                   WHERE pmdrent=",g_enterprise,"
                     AND pmdr011 = 'N'  
                     AND NOT EXISTS(SELECT 1 
                                      FROM imaa_t
                                     WHERE imaaent=pmdrent
                                       AND imaastus='Y'
                                       AND imaa001=pmdr002) "
    IF p_docno IS NOT NULL THEN
       LET l_sql = l_sql," AND ",p_docno
    END IF                       
    PREPARE ins_apmp864_tmp_pre2 FROM l_sql
    EXECUTE ins_apmp864_tmp_pre2  
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = "ins apmp864_tmp" 
       LET g_errparam.code   = SQLCA.sqlcode
       LET g_errparam.popup  = TRUE 
       CALL cl_err()            
       LET r_success = FALSE                
    END IF                      
                         
    IF g_checkbox = 'N' THEN   #不存在于门店商品清单是否自动新增=N，才提示商品在门店商品清单和采购协议不存在的报错 #add by geza 20160107
       #商品不存在于門店商品清單
       LET l_sql = " INSERT INTO apmp864_tmp (pmdr000,pmdrsite,pmdr001,pmdr002,pmdr006)
                     SELECT DISTINCT '3',pmdrsite,pmdr001,pmdr002,pmdr006
                       FROM pmdr_t
                      WHERE pmdrent=",g_enterprise,"
                        AND pmdr011 = 'N'   
                        AND NOT EXISTS(SELECT 1 
                                         FROM rtdx_t
                                        WHERE rtdxent=pmdrent
                                          AND rtdxstus='Y'
                                          AND rtdx001=pmdr002
                                          AND rtdxsite=pmdrsite) "
        IF p_docno IS NOT NULL THEN
           LET l_sql = l_sql," AND ",p_docno
        END IF                       
        PREPARE ins_apmp864_tmp_pre3 FROM l_sql
        EXECUTE ins_apmp864_tmp_pre3  
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.extend = "ins apmp864_tmp" 
           LET g_errparam.code   = SQLCA.sqlcode
           LET g_errparam.popup  = TRUE 
           CALL cl_err()            
           LET r_success = FALSE                
        END IF 
       #商品不存在于門店門店採購協議
       LET l_sql = " INSERT INTO apmp864_tmp (pmdr000,pmdrsite,pmdr001,pmdr002,pmdr006)
                     SELECT DISTINCT '4',pmdrsite,pmdr001,pmdr002,pmdr006
                       FROM pmdr_t
                      WHERE pmdrent=",g_enterprise,"
                        AND pmdr011 = 'N'   
                        AND NOT EXISTS(SELECT 1 
                                         FROM star_t,stas_t
                                        WHERE starent=stasent
                                          AND star001=stas001
                                          AND starsite=stassite
                                          AND starsite=pmdrsite
                                          AND star003=pmdr001
                                          AND starent=pmdrent
                                          AND starstus='Y'
                                          AND stas003=pmdr002
                                          AND starsite=pmdrsite
                                          )  "
       IF p_docno IS NOT NULL THEN
          LET l_sql = l_sql," AND ",p_docno
       END IF                       
       PREPARE ins_apmp864_tmp_pre4 FROM l_sql
       EXECUTE ins_apmp864_tmp_pre4  
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "ins apmp864_tmp" 
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = TRUE 
          CALL cl_err()            
          LET r_success = FALSE                
       END IF                                    
    END IF                        
       
    #开账批次编号前面加上开账组织编号，并且跟系统批次编号不重复
    LET l_sql = " INSERT INTO apmp864_tmp (pmdr000,pmdrsite,pmdr001,pmdr002,pmdr006)
                  SELECT DISTINCT '5',pmdrsite,pmdr001,pmdr002,pmdr006
                    FROM pmdr_t,inag_t
                   WHERE pmdrent=",g_enterprise,"
                     AND pmdr011 = 'N'   
                     AND inagent = pmdrent AND inag006=pmdr006 ",
                #只判断商品主档批号唯一性检查为1严格不允许重复的     
                " AND EXISTS (SELECT 1 FROM imaf_t WHERE imafent = pmdrent AND imafsite = 'ALL' AND imaf001 = pmdr002 AND imaf064 = '1')" #add by geza 2016011
    IF p_docno IS NOT NULL THEN
       LET l_sql = l_sql," AND ",p_docno
    END IF                       
    PREPARE ins_apmp864_tmp_pre5 FROM l_sql
    EXECUTE ins_apmp864_tmp_pre5  
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = "ins apmp864_tmp" 
       LET g_errparam.code   = SQLCA.sqlcode
       LET g_errparam.popup  = TRUE 
       CALL cl_err()            
       LET r_success = FALSE                
    END IF                   
       
    LET l_sql = " INSERT INTO apmp864_tmp (pmdr000,pmdrsite,pmdr001,pmdr002,pmdr006)
                  SELECT DISTINCT '6',pmdrsite,pmdr001,pmdr002,pmdr006
                    FROM pmdr_t,pmdt_t
                   WHERE pmdrent=",g_enterprise,"
                     AND pmdr011 = 'N'   
                     AND pmdtent = pmdrent AND pmdr006=pmdt018 ",
                #只判断商品主档批号唯一性检查为1严格不允许重复的     
                " AND EXISTS (SELECT 1 FROM imaf_t WHERE imafent = pmdrent AND imafsite = 'ALL' AND imaf001 = pmdr002 AND imaf064 = '1')" #add by geza 2016011  
    IF p_docno IS NOT NULL THEN
       LET l_sql = l_sql," AND ",p_docno
    END IF                       
    PREPARE ins_apmp864_tmp_pre6 FROM l_sql
    EXECUTE ins_apmp864_tmp_pre6  
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = "ins apmp864_tmp" 
       LET g_errparam.code   = SQLCA.sqlcode
       LET g_errparam.popup  = TRUE 
       CALL cl_err()            
       LET r_success = FALSE                
    END IF 
    
    #开账组织+開賬日期+供应商+商品+库区+批號 不能重复 
    LET l_sql = " INSERT INTO apmp864_tmp (pmdr000,pmdrsite,pmdr001,pmdr002,pmdr006)
                  SELECT DISTINCT '7',pmdrsite,pmdr001,pmdr002,pmdr006
                     FROM pmdr_t
                    WHERE pmdrent=",g_enterprise,"
                      AND pmdr011 = 'N'  ",
                #只判断商品主档批号唯一性检查为1严格不允许重复的     
                " AND EXISTS (SELECT 1 FROM imaf_t WHERE imafent = pmdrent AND imafsite = 'ALL' AND imaf001 = pmdr002 AND imaf064 = '1')" #add by geza 2016011        
    IF p_docno IS NOT NULL THEN
       LET l_sql = l_sql," AND ",p_docno
    END IF   
    LET l_sql = l_sql,"GROUP BY pmdrsite,pmdrdocdt,pmdr001,pmdr002,pmdr004,pmdr006
                       HAVING COUNT(*)>1  "
    
    PREPARE ins_apmp864_tmp_pre7 FROM l_sql
    EXECUTE ins_apmp864_tmp_pre7  
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = "ins apmp864_tmp" 
       LET g_errparam.code   = SQLCA.sqlcode
       LET g_errparam.popup  = TRUE 
       CALL cl_err()            
       LET r_success = FALSE                
    END IF                
    #add by geza 20160106(E)
    
    #add by geza 20160111(S)
    #商品主档批号控管方式必须有批号的话，则导入的批号不能为空
    LET l_sql = " INSERT INTO apmp864_tmp (pmdr000,pmdrsite,pmdr001,pmdr002,pmdr006)
                  SELECT DISTINCT '8',pmdrsite,pmdr001,pmdr002,pmdr006
                     FROM pmdr_t,imaf_t
                    WHERE pmdrent=",g_enterprise,"
                      AND imafent = pmdrent AND pmdr002=imaf001 AND imafsite = 'ALL'
                      AND imaf061 = '1' AND pmdr006 IS NULL
                      AND pmdr011 = 'N' "
    IF p_docno IS NOT NULL THEN
       LET l_sql = l_sql," AND ",p_docno
    END IF   
    
    PREPARE ins_apmp864_tmp_pre8 FROM l_sql
    EXECUTE ins_apmp864_tmp_pre8  
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = "ins apmp864_tmp" 
       LET g_errparam.code   = SQLCA.sqlcode
       LET g_errparam.popup  = TRUE 
       CALL cl_err()            
       LET r_success = FALSE                
    END IF  

    #商品主档批号控管方式不能有批号的话，则导入的批号不能有值
    LET l_sql = " INSERT INTO apmp864_tmp (pmdr000,pmdrsite,pmdr001,pmdr002,pmdr006)
                  SELECT DISTINCT '9',pmdrsite,pmdr001,pmdr002,pmdr006
                     FROM pmdr_t,imaf_t
                    WHERE pmdrent=",g_enterprise,"
                      AND imafent = pmdrent AND pmdr002=imaf001 AND imafsite = 'ALL'
                      AND imaf061 = '2' AND pmdr006 IS NOT NULL
                      AND pmdr011 = 'N' "
    IF p_docno IS NOT NULL THEN
       LET l_sql = l_sql," AND ",p_docno
    END IF   
    
    PREPARE ins_apmp864_tmp_pre9 FROM l_sql
    EXECUTE ins_apmp864_tmp_pre9  
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = "ins apmp864_tmp" 
       LET g_errparam.code   = SQLCA.sqlcode
       LET g_errparam.popup  = TRUE 
       CALL cl_err()            
       LET r_success = FALSE                
    END IF    
    
    #开账批次编号前面加上开账组织编号，并且跟系统批次编号不重复
    LET l_sql = " INSERT INTO apmp864_tmp (pmdr000,pmdrsite,pmdr001,pmdr002,pmdr006)
                  SELECT DISTINCT '10',pmdrsite,pmdr001,pmdr002,pmdr006
                    FROM pmdr_t,inag_t
                   WHERE pmdrent=",g_enterprise,"
                     AND pmdr011 = 'N'   
                     AND inagent = pmdrent AND inag006=pmdr006 ",
                #只判断商品主档批号唯一性检查为2警告信息的     
                " AND EXISTS (SELECT 1 FROM imaf_t WHERE imafent = pmdrent AND imafsite = 'ALL' AND imaf001 = pmdr002 AND imaf064 = '2')"  
    IF p_docno IS NOT NULL THEN
       LET l_sql = l_sql," AND ",p_docno
    END IF                       
    PREPARE ins_apmp864_tmp_pre10 FROM l_sql
    EXECUTE ins_apmp864_tmp_pre10 
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = "ins apmp864_tmp" 
       LET g_errparam.code   = SQLCA.sqlcode
       LET g_errparam.popup  = TRUE 
       CALL cl_err()            
       LET r_success = FALSE                
    END IF                   
       
    LET l_sql = " INSERT INTO apmp864_tmp (pmdr000,pmdrsite,pmdr001,pmdr002,pmdr006)
                  SELECT DISTINCT '11',pmdrsite,pmdr001,pmdr002,pmdr006
                    FROM pmdr_t,pmdt_t
                   WHERE pmdrent=",g_enterprise,"
                     AND pmdr011 = 'N'   
                     AND pmdtent = pmdrent AND pmdr006=pmdt018 ",
                #只判断商品主档批号唯一性检查为2警告信息的    
                " AND EXISTS (SELECT 1 FROM imaf_t WHERE imafent = pmdrent AND imafsite = 'ALL' AND imaf001 = pmdr002 AND imaf064 = '2')" 
    IF p_docno IS NOT NULL THEN
       LET l_sql = l_sql," AND ",p_docno
    END IF                       
    PREPARE ins_apmp864_tmp_pre11 FROM l_sql
    EXECUTE ins_apmp864_tmp_pre11  
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = "ins apmp864_tmp" 
       LET g_errparam.code   = SQLCA.sqlcode
       LET g_errparam.popup  = TRUE 
       CALL cl_err()            
       LET r_success = FALSE                
    END IF 
    
    #开账组织+開賬日期+供应商+商品+库区+批號 不能重复 
    LET l_sql = " INSERT INTO apmp864_tmp (pmdr000,pmdrsite,pmdr001,pmdr002,pmdr006)
                  SELECT DISTINCT '12',pmdrsite,pmdr001,pmdr002,pmdr006
                     FROM pmdr_t
                    WHERE pmdrent=",g_enterprise,"
                      AND pmdr011 = 'N'  ",
                #只判断商品主档批号唯一性检查为2警告信息的      
                " AND EXISTS (SELECT 1 FROM imaf_t WHERE imafent = pmdrent AND imafsite = 'ALL' AND imaf001 = pmdr002 AND imaf064 = '2')"  
    IF p_docno IS NOT NULL THEN
       LET l_sql = l_sql," AND ",p_docno
    END IF   
    LET l_sql = l_sql,"GROUP BY pmdrsite,pmdrdocdt,pmdr001,pmdr002,pmdr004,pmdr006
                       HAVING COUNT(*)>1  "
    
    PREPARE ins_apmp864_tmp_pre12 FROM l_sql
    EXECUTE ins_apmp864_tmp_pre12 
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = "ins apmp864_tmp" 
       LET g_errparam.code   = SQLCA.sqlcode
       LET g_errparam.popup  = TRUE 
       CALL cl_err()            
       LET r_success = FALSE                
    END IF    
    
    #add by geza 20160111(E)
    
    #add by geza 20160119(S)
    #判断税别是否存在 
    LET l_sql = " INSERT INTO apmp864_tmp (pmdr000,pmdrsite,pmdr001,pmdr002,pmdr006)
                  SELECT DISTINCT '13',pmdrsite,pmdr001,pmdr002,pmdr006
                    FROM pmdr_t
                   WHERE pmdrent=",g_enterprise,"
                     AND pmdr011 = 'N'
                     AND pmdr003 IS NOT NULL                     
                     AND NOT EXISTS(SELECT 1 
                                      FROM ooef_t,oodb_t
                                     WHERE ooefent=pmdrent
                                       AND ooefent=oodbent
                                       AND ooef001=pmdrsite
                                       AND oodbstus='Y'
                                       AND oodb002=pmdr003 
                                       AND ooef019=oodb001) "
    IF p_docno IS NOT NULL THEN
       LET l_sql = l_sql," AND ",p_docno
    END IF   
    
    PREPARE ins_apmp864_tmp_pre13 FROM l_sql
    EXECUTE ins_apmp864_tmp_pre13 
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = "ins apmp864_tmp" 
       LET g_errparam.code   = SQLCA.sqlcode
       LET g_errparam.popup  = TRUE 
       CALL cl_err()            
       LET r_success = FALSE                
    END IF
    
    #判断库区是否为空
    LET l_sql = " INSERT INTO apmp864_tmp (pmdr000,pmdrsite,pmdr001,pmdr002,pmdr006)
                  SELECT DISTINCT '14',pmdrsite,pmdr001,pmdr002,pmdr006
                    FROM pmdr_t
                   WHERE pmdrent=",g_enterprise,"
                     AND pmdr011 = 'N'  
                     AND pmdr004 IS NULL "
    IF p_docno IS NOT NULL THEN
       LET l_sql = l_sql," AND ",p_docno
    END IF   
    
    PREPARE ins_apmp864_tmp_pre14 FROM l_sql
    EXECUTE ins_apmp864_tmp_pre14 
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = "ins apmp864_tmp" 
       LET g_errparam.code   = SQLCA.sqlcode
       LET g_errparam.popup  = TRUE 
       CALL cl_err()            
       LET r_success = FALSE                
    END IF  
    
    #判断库区是否存在 
    LET l_sql = " INSERT INTO apmp864_tmp (pmdr000,pmdrsite,pmdr001,pmdr002,pmdr006)
                  SELECT DISTINCT '15',pmdrsite,pmdr001,pmdr002,pmdr006
                    FROM pmdr_t
                   WHERE pmdrent=",g_enterprise,"
                     AND pmdr011 = 'N' 
                     AND pmdr004 IS NOT NULL                     
                     AND NOT EXISTS(SELECT 1 
                                      FROM inaa_t
                                     WHERE inaaent=pmdrent
                                       AND inaasite=pmdrsite
                                       AND inaastus='Y'
                                       AND inaa001=pmdr004) "
    IF p_docno IS NOT NULL THEN
       LET l_sql = l_sql," AND ",p_docno
    END IF   
    
    PREPARE ins_apmp864_tmp_pre15 FROM l_sql
    EXECUTE ins_apmp864_tmp_pre15 
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = "ins apmp864_tmp" 
       LET g_errparam.code   = SQLCA.sqlcode
       LET g_errparam.popup  = TRUE 
       CALL cl_err()            
       LET r_success = FALSE                
    END IF  

    #判断储位是否存在 
    LET l_sql = " INSERT INTO apmp864_tmp (pmdr000,pmdrsite,pmdr001,pmdr002,pmdr006)
                  SELECT DISTINCT '16',pmdrsite,pmdr001,pmdr002,pmdr006
                    FROM pmdr_t
                   WHERE pmdrent=",g_enterprise,"
                     AND pmdr011 = 'N' 
                     AND pmdr004 IS NOT NULL
                     AND pmdr005 IS NOT NULL                     
                     AND NOT EXISTS(SELECT 1 
                                      FROM inab_t
                                     WHERE inabent=pmdrent
                                       AND inabsite=pmdrsite
                                       AND inabstus='Y'
                                       AND inab002=pmdr005
                                       AND inab001=pmdr004) "
    IF p_docno IS NOT NULL THEN
       LET l_sql = l_sql," AND ",p_docno
    END IF   
    
    PREPARE ins_apmp864_tmp_pre16 FROM l_sql
    EXECUTE ins_apmp864_tmp_pre16 
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = "ins apmp864_tmp" 
       LET g_errparam.code   = SQLCA.sqlcode
       LET g_errparam.popup  = TRUE 
       CALL cl_err()            
       LET r_success = FALSE                
    END IF  
    
    #判断税是否为空
    LET l_sql = " INSERT INTO apmp864_tmp (pmdr000,pmdrsite,pmdr001,pmdr002,pmdr006)
                  SELECT DISTINCT '17',pmdrsite,pmdr001,pmdr002,pmdr006
                    FROM pmdr_t
                   WHERE pmdrent=",g_enterprise,"
                     AND pmdr011 = 'N'  
                     AND pmdr003 IS NULL "
    IF p_docno IS NOT NULL THEN
       LET l_sql = l_sql," AND ",p_docno
    END IF   
    
    PREPARE ins_apmp864_tmp_pre17 FROM l_sql
    EXECUTE ins_apmp864_tmp_pre17 
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = "ins apmp864_tmp" 
       LET g_errparam.code   = SQLCA.sqlcode
       LET g_errparam.popup  = TRUE 
       CALL cl_err()            
       LET r_success = FALSE                
    END IF  
    #add by geza 20160119(E)
    
    #add by geza 20160125(S)
    #批次编号不能重复的商品的批号不能存在于已导入的pmdr资料中
    LET l_sql = " INSERT INTO apmp864_tmp (pmdr000,pmdrsite,pmdr001,pmdr002,pmdr006)
                  SELECT DISTINCT '18','','','',pmdr006
                    FROM pmdr_t
                   WHERE pmdrent=",g_enterprise,"
                     AND pmdr011 = 'Y' ", 
                #只判断商品主档批号唯一性检查为1严格不允许重复的     
                "    AND EXISTS (SELECT 1 FROM imaf_t WHERE imafent = pmdrent AND imafsite = 'ALL' AND imaf001 = pmdr002 AND imaf064 = '1')" 
    IF p_docno IS NOT NULL THEN
       LET l_sql = l_sql," AND ",p_docno
    END IF  
    LET l_sql = l_sql,"GROUP BY pmdr006
                       HAVING COUNT(*)>=1  "    
    PREPARE ins_apmp864_tmp_pre18 FROM l_sql
    EXECUTE ins_apmp864_tmp_pre18  
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = "ins apmp864_tmp" 
       LET g_errparam.code   = SQLCA.sqlcode
       LET g_errparam.popup  = TRUE 
       CALL cl_err()            
       LET r_success = FALSE                
    END IF  
    #add by geza 20160125(E)
    
    LET l_count = 0
    SELECT COUNT(*) INTO l_count FROM apmp864_tmp
    IF l_count > 0 THEN
       DECLARE apmp864_sel_tmp CURSOR FOR SELECT DISTINCT pmdr000,pmdrsite,pmdr001,pmdr002,pmdr006
                                           FROM apmp864_tmp
                                           
       FOREACH apmp864_sel_tmp INTO l_tmp.pmdr000,l_tmp.pmdrsite,l_tmp.pmdr001,l_tmp.pmdr002,l_tmp.pmdr006
          #供應商不在供应商主档中，或未审核
           IF l_tmp.pmdr000 = '1' THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'apm-01015'
              LET g_errparam.extend = "供应商：",l_tmp.pmdr001
              LET g_errparam.popup = TRUE
              CALL cl_err()
               
              LET r_success=FALSE 
           END IF
          
          #商品不存在於商品基本資料
           IF l_tmp.pmdr000 = '2' THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'apm-01016'
              LET g_errparam.extend = "商品：",l_tmp.pmdr002
              LET g_errparam.popup = TRUE
              CALL cl_err()
               
              LET r_success=FALSE 
           END IF     
           
          
           #商品补存在于門店商品清單
           IF l_tmp.pmdr000 = '3' THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'apm-01017'
              LET g_errparam.extend = "门店：",l_tmp.pmdrsite,"供应商：",l_tmp.pmdr001,"商品：",l_tmp.pmdr002
              LET g_errparam.popup = TRUE
              CALL cl_err()
               
              LET r_success=FALSE 
           END IF   
           
          #商品存在于門店門店採購協議
           IF l_tmp.pmdr000 = '4' THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'apm-01018'
              LET g_errparam.extend = "门店：",l_tmp.pmdrsite,"供应商：",l_tmp.pmdr001,"商品：",l_tmp.pmdr002
              LET g_errparam.popup = TRUE
              CALL cl_err()
               
              LET r_success=FALSE 
           END IF 
          
          #开账批次编号前面加上开账组织编号，并且跟系统批次编号不重复
           IF l_tmp.pmdr000 = '5' THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'apm-01020'
              LET g_errparam.extend = "门店：",l_tmp.pmdrsite,"供应商：",l_tmp.pmdr001,"商品：",l_tmp.pmdr002,"批号：",l_tmp.pmdr006
              LET g_errparam.popup = TRUE
              CALL cl_err()
               
              LET r_success=FALSE  
           END IF
           IF l_tmp.pmdr000 = '6' THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'apm-01020'
              LET g_errparam.extend = "门店：",l_tmp.pmdrsite,"供应商：",l_tmp.pmdr001,"商品：",l_tmp.pmdr002,"批号：",l_tmp.pmdr006
              LET g_errparam.popup = TRUE
              CALL cl_err()
               
              LET r_success=FALSE  
           END IF
           IF l_tmp.pmdr000 = '7' THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'apm-01021'
              LET g_errparam.extend = "门店：",l_tmp.pmdrsite,"供应商：",l_tmp.pmdr001,"商品：",l_tmp.pmdr002,"批号：",l_tmp.pmdr006
              LET g_errparam.popup = TRUE
              CALL cl_err()
               
              LET r_success=FALSE  
           END IF
           
           #add by geza 20160111(S)
           IF l_tmp.pmdr000 = '8' THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'apm-01061'
              LET g_errparam.extend = "门店：",l_tmp.pmdrsite,"供应商：",l_tmp.pmdr001,"商品：",l_tmp.pmdr002,"批号：",l_tmp.pmdr006
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET r_success=FALSE    
           END IF
           
           IF l_tmp.pmdr000 = '9' THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'apm-01062'
              LET g_errparam.extend = "门店：",l_tmp.pmdrsite,"供应商：",l_tmp.pmdr001,"商品：",l_tmp.pmdr002,"批号：",l_tmp.pmdr006
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET r_success=FALSE    
           END IF
           
           #开账批次编号前面加上开账组织编号，并且跟系统批次编号不重复
           IF l_tmp.pmdr000 = '10' THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'apm-01020'
              LET g_errparam.extend = "门店：",l_tmp.pmdrsite,"供应商：",l_tmp.pmdr001,"商品：",l_tmp.pmdr002,"批号：",l_tmp.pmdr006
              LET g_errparam.popup = TRUE
              CALL cl_err()
                 
           END IF
           IF l_tmp.pmdr000 = '11' THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'apm-01020'
              LET g_errparam.extend = "门店：",l_tmp.pmdrsite,"供应商：",l_tmp.pmdr001,"商品：",l_tmp.pmdr002,"批号：",l_tmp.pmdr006
              LET g_errparam.popup = TRUE
              CALL cl_err()
               
           END IF
           IF l_tmp.pmdr000 = '12' THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'apm-01021'
              LET g_errparam.extend = "门店：",l_tmp.pmdrsite,"供应商：",l_tmp.pmdr001,"商品：",l_tmp.pmdr002,"批号：",l_tmp.pmdr006
              LET g_errparam.popup = TRUE
              CALL cl_err()
               
           END IF
           #add by geza 20160111(E)
           
           #add by geza 20160119(S)
           #税别不存在
           IF l_tmp.pmdr000 = '13' THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'apm-01066'
              LET g_errparam.extend = "门店：",l_tmp.pmdrsite,"供应商：",l_tmp.pmdr001,"商品：",l_tmp.pmdr002,"批号：",l_tmp.pmdr006
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET r_success=FALSE    
           END IF
           #库位为空
           IF l_tmp.pmdr000 = '14' THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'apm-01067'
              LET g_errparam.extend = "门店：",l_tmp.pmdrsite,"供应商：",l_tmp.pmdr001,"商品：",l_tmp.pmdr002,"批号：",l_tmp.pmdr006
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET r_success=FALSE  
           END IF
           #库区不存在
           IF l_tmp.pmdr000 = '15' THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'apm-01068'
              LET g_errparam.extend = "门店：",l_tmp.pmdrsite,"供应商：",l_tmp.pmdr001,"商品：",l_tmp.pmdr002,"批号：",l_tmp.pmdr006
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET r_success=FALSE  
           END IF
           #储位不存在
           IF l_tmp.pmdr000 = '16' THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'apm-01069'
              LET g_errparam.extend = "门店：",l_tmp.pmdrsite,"供应商：",l_tmp.pmdr001,"商品：",l_tmp.pmdr002,"批号：",l_tmp.pmdr006
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET r_success=FALSE  
           END IF
           #税别为空
           IF l_tmp.pmdr000 = '17' THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'apm-01070'
              LET g_errparam.extend = "门店：",l_tmp.pmdrsite,"供应商：",l_tmp.pmdr001,"商品：",l_tmp.pmdr002,"批号：",l_tmp.pmdr006
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET r_success=FALSE  
           END IF
           #add by geza 20160119(E)
           
           #add by geza 20160125(S)
           #商品主档批号不能重复的，在pmdr_t不能有2笔资料
           IF l_tmp.pmdr000 = '18' THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'apm-01082'
              LET g_errparam.extend = "批号：",l_tmp.pmdr006
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET r_success=FALSE  
           END IF
           #add by geza 20160125(E)
           
        END FOREACH
    END IF
    #add by geza 20151120(E)
    
    CALL cl_err_collect_show()

    RETURN r_success
    
END FUNCTION

################################################################################
# Descriptions...: EXCEL導入,從中間表pmdr_t插入pms_t,pmdt_t,pmdu_t,crcd_t
# Memo...........:
# Usage..........: CALL apmp864_excel_insertpms(p_docno)
#                  RETURNING r_success
# Input parameter: p_docno        來源單號
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 20151027 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp864_excel_insertpms(p_docno)
#DEFINE p_docno       LIKE pmds_t.pmds201 #mark by geza 20160108
DEFINE r_success     LIKE type_t.num5
DEFINE l_count       LIKE type_t.num5
DEFINE l_pmdrsite    LIKE pmdr_t.pmdrsite
DEFINE l_pmdrdocdt   LIKE pmdr_t.pmdrdocdt
DEFINE l_pmdr001     LIKE pmdr_t.pmdr001
DEFINE l_pmdr003     LIKE pmdr_t.pmdr003
DEFINE l_success     LIKE type_t.num5
DEFINE l_doctype     LIKE rtai_t.rtai004
DEFINE l_pmdsdocno   LIKE pmds_t.pmdsdocno
#161104-00002#11 161110 By rainy mod---(S) 
 #調整*寫法 
#DEFINE l_pmds RECORD LIKE pmds_t.*
DEFINE l_pmds RECORD  #收貨/入庫單頭檔
       pmdsent LIKE pmds_t.pmdsent, #企業編號
       pmdssite LIKE pmds_t.pmdssite, #營運據點
       pmdsdocno LIKE pmds_t.pmdsdocno, #單據單號
       pmdsdocdt LIKE pmds_t.pmdsdocdt, #單據日期
       pmds000 LIKE pmds_t.pmds000, #單據性質
       pmds001 LIKE pmds_t.pmds001, #扣帳日期
       pmds002 LIKE pmds_t.pmds002, #申請人員
       pmds003 LIKE pmds_t.pmds003, #申請部門
       pmds006 LIKE pmds_t.pmds006, #來源單號
       pmds007 LIKE pmds_t.pmds007, #採購供應商
       pmds008 LIKE pmds_t.pmds008, #帳款供應商
       pmds009 LIKE pmds_t.pmds009, #送貨供應商
       pmds010 LIKE pmds_t.pmds010, #供應商送貨單號
       pmds011 LIKE pmds_t.pmds011, #採購性質
       pmds012 LIKE pmds_t.pmds012, #採購通路
       pmds013 LIKE pmds_t.pmds013, #採購分類
       pmds014 LIKE pmds_t.pmds014, #多角性質
       pmds021 LIKE pmds_t.pmds021, #LC進口
       pmds022 LIKE pmds_t.pmds022, #進口日期
       pmds023 LIKE pmds_t.pmds023, #進口報單
       pmds024 LIKE pmds_t.pmds024, #進口號碼
       pmds028 LIKE pmds_t.pmds028, #一次性交易對象識別碼
       pmds031 LIKE pmds_t.pmds031, #付款條件
       pmds032 LIKE pmds_t.pmds032, #交易條件
       pmds033 LIKE pmds_t.pmds033, #稅別
       pmds034 LIKE pmds_t.pmds034, #稅率
       pmds035 LIKE pmds_t.pmds035, #單價含稅否
       pmds036 LIKE pmds_t.pmds036, #交易類型
       pmds037 LIKE pmds_t.pmds037, #幣別
       pmds038 LIKE pmds_t.pmds038, #匯率
       pmds039 LIKE pmds_t.pmds039, #取價方式
       pmds040 LIKE pmds_t.pmds040, #付款優惠條件
       pmds041 LIKE pmds_t.pmds041, #多角序號
       pmds042 LIKE pmds_t.pmds042, #整合單號
       pmds043 LIKE pmds_t.pmds043, #採購總未稅金額
       pmds044 LIKE pmds_t.pmds044, #採購總含稅金額
       pmds045 LIKE pmds_t.pmds045, #備註
       pmds046 LIKE pmds_t.pmds046, #採購總稅額
       pmds047 LIKE pmds_t.pmds047, #多角貿易中斷點
       pmds048 LIKE pmds_t.pmds048, #內外購
       pmds049 LIKE pmds_t.pmds049, #匯率計算基準
       pmds050 LIKE pmds_t.pmds050, #多角貿易已拋轉
       pmds051 LIKE pmds_t.pmds051, #出貨單號
       pmds052 LIKE pmds_t.pmds052, #供應商出貨日
       pmds053 LIKE pmds_t.pmds053, #多角流程編號
       pmds081 LIKE pmds_t.pmds081, #取回日期
       pmds100 LIKE pmds_t.pmds100, #倉退方式
       pmds101 LIKE pmds_t.pmds101, #折讓日期
       pmds102 LIKE pmds_t.pmds102, #折讓原始發票
       pmdsownid LIKE pmds_t.pmdsownid, #資料所屬者
       pmdsowndp LIKE pmds_t.pmdsowndp, #資料所有部門
       pmdscrtid LIKE pmds_t.pmdscrtid, #資料建立者
       pmdscrtdp LIKE pmds_t.pmdscrtdp, #資料建立部門
       pmdscrtdt LIKE pmds_t.pmdscrtdt, #資料創建日
       pmdsmodid LIKE pmds_t.pmdsmodid, #資料修改者
       pmdsmoddt LIKE pmds_t.pmdsmoddt, #最近修改日
       pmdscnfid LIKE pmds_t.pmdscnfid, #資料確認者
       pmdscnfdt LIKE pmds_t.pmdscnfdt, #資料確認日
       pmdspstid LIKE pmds_t.pmdspstid, #資料過帳者
       pmdspstdt LIKE pmds_t.pmdspstdt, #資料過帳日
       pmdsstus LIKE pmds_t.pmdsstus, #狀態碼
       pmdsud001 LIKE pmds_t.pmdsud001, #自定義欄位(文字)001
       pmdsud002 LIKE pmds_t.pmdsud002, #自定義欄位(文字)002
       pmdsud003 LIKE pmds_t.pmdsud003, #自定義欄位(文字)003
       pmdsud004 LIKE pmds_t.pmdsud004, #自定義欄位(文字)004
       pmdsud005 LIKE pmds_t.pmdsud005, #自定義欄位(文字)005
       pmdsud006 LIKE pmds_t.pmdsud006, #自定義欄位(文字)006
       pmdsud007 LIKE pmds_t.pmdsud007, #自定義欄位(文字)007
       pmdsud008 LIKE pmds_t.pmdsud008, #自定義欄位(文字)008
       pmdsud009 LIKE pmds_t.pmdsud009, #自定義欄位(文字)009
       pmdsud010 LIKE pmds_t.pmdsud010, #自定義欄位(文字)010
       pmdsud011 LIKE pmds_t.pmdsud011, #自定義欄位(數字)011
       pmdsud012 LIKE pmds_t.pmdsud012, #自定義欄位(數字)012
       pmdsud013 LIKE pmds_t.pmdsud013, #自定義欄位(數字)013
       pmdsud014 LIKE pmds_t.pmdsud014, #自定義欄位(數字)014
       pmdsud015 LIKE pmds_t.pmdsud015, #自定義欄位(數字)015
       pmdsud016 LIKE pmds_t.pmdsud016, #自定義欄位(數字)016
       pmdsud017 LIKE pmds_t.pmdsud017, #自定義欄位(數字)017
       pmdsud018 LIKE pmds_t.pmdsud018, #自定義欄位(數字)018
       pmdsud019 LIKE pmds_t.pmdsud019, #自定義欄位(數字)019
       pmdsud020 LIKE pmds_t.pmdsud020, #自定義欄位(數字)020
       pmdsud021 LIKE pmds_t.pmdsud021, #自定義欄位(日期時間)021
       pmdsud022 LIKE pmds_t.pmdsud022, #自定義欄位(日期時間)022
       pmdsud023 LIKE pmds_t.pmdsud023, #自定義欄位(日期時間)023
       pmdsud024 LIKE pmds_t.pmdsud024, #自定義欄位(日期時間)024
       pmdsud025 LIKE pmds_t.pmdsud025, #自定義欄位(日期時間)025
       pmdsud026 LIKE pmds_t.pmdsud026, #自定義欄位(日期時間)026
       pmdsud027 LIKE pmds_t.pmdsud027, #自定義欄位(日期時間)027
       pmdsud028 LIKE pmds_t.pmdsud028, #自定義欄位(日期時間)028
       pmdsud029 LIKE pmds_t.pmdsud029, #自定義欄位(日期時間)029
       pmdsud030 LIKE pmds_t.pmdsud030, #自定義欄位(日期時間)030
       pmds200 LIKE pmds_t.pmds200, #收貨預約單號
       pmds054 LIKE pmds_t.pmds054, #資料來源
       pmds055 LIKE pmds_t.pmds055, #來源單號
       pmds201 LIKE pmds_t.pmds201, #來源單號
       pmds202 LIKE pmds_t.pmds202, #來源類型
       pmdsunit LIKE pmds_t.pmdsunit, #應用執行組織物件
       pmds056 LIKE pmds_t.pmds056, #No use
       pmds057 LIKE pmds_t.pmds057, #整合來源
       pmds058 LIKE pmds_t.pmds058, #倒扣領料單號
       pmds103 LIKE pmds_t.pmds103  #折讓證明單開立方式
END RECORD
#161104-00002#11 161110 By rainy mod---(E) 
DEFINE ls_result     STRING 
DEFINE l_sql         STRING 
DEFINE l_ooef019     LIKE ooef_t.ooef019
DEFINE l_string      STRING
DEFINE r_ooaj004     LIKE ooaj_t.ooaj004              #add by geza 20151030
DEFINE l_ooef014     LIKE ooef_t.ooef014              #add by geza 20151030
DEFINE l_wc          STRING                           #add by geza 20160107
DEFINE l_rtda001     LIKE rtda_t.rtda001              #add by geza 20160107
DEFINE l_ooag003     LIKE ooag_t.ooag003              #add by geza 20160107 #歸屬部門
DEFINE l_rtdxcrtdt   DATETIME YEAR TO SECOND          #add by geza 20160107 #資料創建日
DEFINE l_pmdrdocno   LIKE pmdr_t.pmdrdocno            #add by geza 20160108  
DEFINE p_docno       STRING                           #add by geza 20160108
    LET r_success=TRUE
    
    
    #開啟事務
    CALL s_transaction_begin()
    #add by geza 20160107(S)
    LET l_wc = cl_replace_str(g_wc,'pmdssite','pmdrsite')
    LET l_wc = cl_replace_str(l_wc,'pmdsdocdt','pmdrdocdt')
    LET l_wc = cl_replace_str(l_wc,'pmds201','pmdrdocno') 
    IF l_wc IS NULL THEN
       LET l_wc = ' 1=1' 
    END IF
    #add by geza 20160107(E)
    
    #add by geza 20160107(S)
    #抓取参数设置的清退生命周期编号
    LET l_rtda001 = cl_get_para(g_enterprise,g_site,'E-CIR-0056')
    LET l_rtdxcrtdt = cl_get_current()
    SELECT ooag003 INTO l_ooag003
      FROM ooag_t
     WHERE ooag001 = g_user
       AND ooagent = g_enterprise
    #不存在于门店商品清单是否自动新增=Y，则新增不存在于门店清单中的商品资料
    IF g_checkbox  = 'Y' THEN
       #新增imaf_t
       LET l_sql = "  INSERT INTO imaf_t(imafent,   imafsite,  imaf001,   imaf143,   imaf144,     ",
                   "                     imaf112,   imaf113,   imafownid, imafowndp,              ",
                   "                     imafcrtid, imafcrtdp, imafcrtdt, imafstus)               ",
                   "  SELECT           ",g_enterprise,",  pmdrsite,     pmdr002,     imaa107,    imaa145, ",
                   "                     imaa105,         imaa106,   '",g_user,"','",l_ooag003,"',      ",
                   "                     '",g_user,"', '",l_ooag003,"', to_date('",l_rtdxcrtdt,"','YYYY-MM-DD hh24:mi:ss'),'Y'  ",
                   "   FROM pmdr_t                                    ",
                   "   LFET JOIN imaa_t ON imaaent = pmdrent   AND imaa001 = pmdr002 AND imaastus = 'Y' ",
                   "  WHERE pmdrent = '",g_enterprise,"'              ",
                   #"    AND pmdrdocno = '",p_docno,"'                 ", #mark by geza 20160108
                   "    AND pmdr011 = 'N'                             ",
                   "    AND NOT EXISTS(SELECT 1                       ",
                   "                     FROM rtdx_t                  ",
                   "                    WHERE rtdxent=pmdrent         ",
                   "                      AND rtdxstus='Y'            ",
                   "                      AND rtdx001=pmdr002         ",
                   "                      AND rtdxsite=pmdrsite)      ",
                   "    AND ",l_wc CLIPPED 
#       IF p_docno IS NOT NULL THEN
#          LET l_sql = l_sql,"AND pmdrdocno='",p_docno,"' "
#       END IF                
       PREPARE ins_imaf_pre FROM l_sql
       EXECUTE ins_imaf_pre
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "INSERT imaf_t" 
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = TRUE 
          CALL cl_err() 
          CALL s_transaction_end('N','0')             
          LET r_success = FALSE      
          RETURN r_success          
       END IF 
       
       LET l_sql = " INSERT INTO rtdx_t(rtdxent,   rtdxsite,  rtdxunit,  rtdx001,   rtdx002,   ",              
                   "                    rtdx003,   rtdx004,   rtdx005,   rtdx043,   rtdx006,   ", 
                   "                    rtdx007,   rtdx008,   rtdx009,   rtdx010,   rtdx011,   ",
                   "                    rtdx012,   rtdx013,   rtdx014,   rtdx016,   rtdx017,   ",
                   "                    rtdx018,   rtdx019,   rtdx020,   rtdx021,   rtdx022,   ",                      
                   "                    rtdx023,   rtdx024,   rtdx025,   rtdx026,   rtdx027,   ",
                   "                    rtdx028,   rtdx029,   rtdx032,   rtdxstus,  rtdxownid, ",
                   "                    rtdxowndp, rtdxcrtid, rtdxcrtdp, rtdx044,   rtdx045,   ",
                   "                    rtdx046  , rtdx034,   rtdx035,   rtdx051,   rtdx052,   ",
                   "                    rtdx053,   rtdx054 ,  rtdxcrtdt, rtdxmodid, rtdxmoddt )",                                    
                   "             SELECT ",g_enterprise,",pmdrsite,pmdrsite,pmdr002, imay003,   ", 
                   "                                 '1',imay004,        1,    '1', '",l_rtda001,"',   ", 
                   "   to_date('",g_today,"','yy/mm/dd'),      '',      '',     '',      '',   ", 
                   "                                  '', pmdr010, pmdr003,pmdr010, pmdr010,   ",                    
                   "                             pmdr010, pmdr010,      '',     '',      '',   ", 
                   "                                  '',     'N',     'Y',    'Y',     '0',   ", 
                   "                                  '',      '',      '',    'Y','",g_user,"',   ", 
                   "                     '",l_ooag003,"','",g_user,"','",l_ooag003,"',pmdr004,'',  ",  
                   "                                 'N', pmdr008, pmdr003,pmdr008, pmdr008,   ",
                   "pmdr010, pmdr010, to_date('",l_rtdxcrtdt,"','YYYY-MM-DD hh24:mi:ss'),'",g_user,"',to_date('",l_rtdxcrtdt,"','YYYY-MM-DD hh24:mi:ss') ",                     
                   "   FROM pmdr_t                                    ",
                   "   LFET JOIN imay_t ON imayent = pmdrent AND imay006 = 'Y' AND imay001 = pmdr002 AND imaystus = 'Y' ",
                   "  WHERE pmdrent = '",g_enterprise,"'              ",
                   #"    AND pmdrdocno = '",p_docno,"'                 ",  #mark by geza 20160108
                   "    AND pmdr011 = 'N'                             ",
                   "    AND NOT EXISTS(SELECT 1                       ",
                   "                     FROM rtdx_t                  ",
                   "                    WHERE rtdxent=pmdrent         ",
                   "                      AND rtdxstus='Y'            ",
                   "                      AND rtdx001=pmdr002         ",
                   "                      AND rtdxsite=pmdrsite)      ",
                   "    AND ",l_wc CLIPPED
#       IF p_docno IS NOT NULL THEN
#          LET l_sql = l_sql,"AND pmdrdocno='",p_docno,"' "
#       END IF                      
       PREPARE ins_rtdx_pre FROM l_sql
       EXECUTE ins_rtdx_pre
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "INSERT rtdx_t" 
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = TRUE 
          CALL cl_err() 
          CALL s_transaction_end('N','0')             
          LET r_success = FALSE      
          RETURN r_success          
       END IF 
                   
    END IF
    #add by geza 20160107(E)
    
      
    
    #mark by geza 20160107(S)
#    DECLARE apmp864_selecpmdr CURSOR FOR SELECT DISTINCT pmdrsite,pmdrdocdt,pmdr001
#                                           FROM pmdr_t 
#                                          WHERE pmdrent=g_enterprise
#                                            AND pmdrdocno=p_docno 
    #mark by geza 20160107(E)    
    
    #資料按照：开账组织 +开账日期+供应商编号+来源单号來分單
    #         單別自動編號---  
    
    #add by geza 20160107(S)
    #单号和查询条件来新增apmt864
    LET l_sql = " SELECT DISTINCT pmdrsite,pmdrdocno,pmdrdocdt,pmdr001",
                "   FROM pmdr_t ",
                "  WHERE pmdrent = '",g_enterprise,"'",
                "    AND pmdr011 = 'N' ",                  
                "    AND ",l_wc CLIPPED  

    PREPARE apmp864_selecpmdr_pre FROM l_sql
    DECLARE apmp864_selecpmdr CURSOR FOR apmp864_selecpmdr_pre
    #add by geza 20160107(E)
   
    
    LET l_string=''      
    FOREACH apmp864_selecpmdr INTO l_pmdrsite,l_pmdrdocno,l_pmdrdocdt,l_pmdr001
    
       
       
       
       #預設單據的單別
       LET l_success = ''
       LET l_doctype = ''
       CALL s_arti200_get_def_doc_type(l_pmdrsite,'apmt864','1')
            RETURNING l_success,l_doctype
       #促销申请单号           
       LET l_pmdsdocno = l_doctype　
       
       #自动编号       
       CALL s_aooi200_gen_docno(l_pmdrsite,l_pmdsdocno,g_today,'apmt864') RETURNING l_success,l_pmdsdocno
       IF NOT l_success THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'apm-00003'
          LET g_errparam.extend = l_pmdsdocno
          LET g_errparam.popup = TRUE
          CALL cl_err()
          
          LET r_success = FALSE
          EXIT FOREACH                  
       END IF 

       IF cl_null(l_string) THEN
          LET l_string=l_pmdsdocno
       ELSE
          LET l_string=l_string||'|'||l_pmdsdocno
       END IF
       
       INITIALIZE l_pmds.* TO NULL
       LET l_pmds.pmdsent=g_enterprise
       LET l_pmds.pmdssite=l_pmdrsite
       LET l_pmds.pmdsdocno=l_pmdsdocno
       LET l_pmds.pmdsdocdt=l_pmdrdocdt
       LET l_pmds.pmds000='22'
       LET l_pmds.pmds001=l_pmdrdocdt
       LET l_pmds.pmds002=g_user
       LET l_pmds.pmds003=g_dept
       LET l_pmds.pmds007=l_pmdr001  
       LET l_pmds.pmds008=l_pmdr001  
       LET l_pmds.pmds009=l_pmdr001   
       LET l_pmds.pmds011='1'
       LET l_pmds.pmds014='1'  
       LET l_pmds.pmds021='N'       
       SELECT pmab037,pmab053,pmab034,pmab033 INTO l_pmds.pmds031,l_pmds.pmds032,l_pmds.pmds033,l_pmds.pmds037
         FROM pmab_t
        WHERE pmabent=g_enterprise
          AND pmabsite='ALL'
          AND pmab001=l_pmds.pmds007
          AND pmabstus='Y'
       SELECT ooef019 INTO l_ooef019
         FROM ooef_t
        WHERE ooefent=g_enterprise
          AND ooef001=l_pmds.pmdssite
          AND ooefstus='Y'
       SELECT oodb006,oodb005 INTO l_pmds.pmds034,l_pmds.pmds035
         FROM oodb_t
        WHERE oodbent=g_enterprise
          AND oodb001=l_ooef019
          AND oodb002=l_pmds.pmds033
       LET l_pmds.pmds038=1
#       #mark by geza 20160108(S)
#       SELECT SUM(pmdr009) INTO l_pmds.pmds044
#         FROM pmdr_t
#        WHERE pmdrent=g_enterprise
#          AND pmdrdocno=p_docno
#          AND pmdrsite=l_pmdrsite
#          AND pmdrdocdt=l_pmdrdocdt
#          AND pmdr001=l_pmdr001
#       #mark by geza 20160108(E) 
       #add by geza 20160108(S)
       SELECT SUM(pmdr009) INTO l_pmds.pmds044
         FROM pmdr_t
        WHERE pmdrent=g_enterprise
          AND pmdrdocno=l_pmdrdocno
          AND pmdrsite=l_pmdrsite
          AND pmdrdocdt=l_pmdrdocdt
          AND pmdr001=l_pmdr001 
       #add by geza 20160108(E)    
       IF cl_null(l_pmds.pmds044) THEN
          LET l_pmds.pmds044=0
       END IF          
       LET l_pmds.pmds043=l_pmds.pmds044/(1+l_pmds.pmds034/100)
       
       #add by geza 20151030(S)
       INITIALIZE r_ooaj004 TO NULL	
       #1.取币种参照表号
       SELECT ooef014 INTO l_ooef014 
         FROM ooef_t
        WHERE ooefent = g_enterprise
          AND ooef001 = l_pmdrsite
       #取币种的金额小数位数 取币种的单价小数位数
       SELECT ooaj004 INTO r_ooaj004 
         FROM ooaj_t
        WHERE ooaj001 = l_ooef014
          AND ooaj002 = l_pmds.pmds037
          AND ooajent = g_enterprise
          AND ooajstus = 'Y'
       IF r_ooaj004 IS NULL OR  r_ooaj004 = 0 THEN   #add by geza 20151015
          LET r_ooaj004 = '2'
       END IF
       #金额截位
       SELECT ROUND(l_pmds.pmds043,r_ooaj004) INTO l_pmds.pmds043 FROM dual  #add by geza 20151030 
       #add by geza 20151030(E)
       
       IF cl_null(l_pmds.pmds043) THEN
          LET l_pmds.pmds043=0
       END IF 
       LET l_pmds.pmds046=l_pmds.pmds044-l_pmds.pmds043       
       IF cl_null(l_pmds.pmds046) THEN
          LET l_pmds.pmds046=0
       END IF    
       LET l_pmds.pmds047='1'
       LET l_pmds.pmds048='1'
     
       LET l_pmds.pmdsownid=g_user
       LET l_pmds.pmdsowndp=g_dept
       LET l_pmds.pmdscrtid=g_user 
       LET l_pmds.pmdscrtdp=g_dept   
       LET l_pmds.pmdscrtdt=cl_get_current()
       LET l_pmds.pmdsmodid=g_user
       LET l_pmds.pmdsmoddt=cl_get_current()  
       LET l_pmds.pmdsstus='N'    
       LET l_pmds.pmdsud001='Y'
       LET l_pmds.pmdsud003='Y'      
       LET l_pmds.pmdsunit=l_pmds.pmdssite    
       #LET l_pmds.pmds201 = p_docno #add by geza 20151030 #mark by geza 20160108
       LET l_pmds.pmds201 = l_pmdrdocno #add by geza 20160108   
     #161104-00002#11 161110 By rainy mod---(S) 
      #調整*寫法        
       #INSERT INTO pmds_t VALUES(l_pmds.*)
       INSERT INTO pmds_t ( pmdsent,  pmdssite, pmdsdocno,pmdsdocdt,pmds000,
                            pmds001,  pmds002,  pmds003,  pmds006,  pmds007,
                            pmds008,  pmds009,  pmds010,  pmds011,  pmds012,
                            pmds013,  pmds014,  pmds021,  pmds022,  pmds023,
                            pmds024,  pmds028,  pmds031,  pmds032,  pmds033,
                            pmds034,  pmds035,  pmds036,  pmds037,  pmds038,
                            pmds039,  pmds040,  pmds041,  pmds042,  pmds043,
                            pmds044,  pmds045,  pmds046,  pmds047,  pmds048,
                            pmds049,  pmds050,  pmds051,  pmds052,  pmds053,
                            pmds081,  pmds100,  pmds101,  pmds102,  pmdsownid,
                            pmdsowndp,pmdscrtid,pmdscrtdp,pmdscrtdt,pmdsmodid,
                            pmdsmoddt,pmdscnfid,pmdscnfdt,pmdspstid,pmdspstdt,
                            pmdsstus, pmdsud001,pmdsud002,pmdsud003,pmdsud004,
                            pmdsud005,pmdsud006,pmdsud007,pmdsud008,pmdsud009,
                            pmdsud010,pmdsud011,pmdsud012,pmdsud013,pmdsud014,
                            pmdsud015,pmdsud016,pmdsud017,pmdsud018,pmdsud019,
                            pmdsud020,pmdsud021,pmdsud022,pmdsud023,pmdsud024,
                            pmdsud025,pmdsud026,pmdsud027,pmdsud028,pmdsud029,
                            pmdsud030,pmds200,  pmds054,  pmds055,  pmds201,
                            pmds202,  pmdsunit, pmds056,  pmds057,  pmds058,
                            pmds103
                          )
       VALUES ( l_pmds.pmdsent,  l_pmds.pmdssite, l_pmds.pmdsdocno,l_pmds.pmdsdocdt,l_pmds.pmds000,
                l_pmds.pmds001,  l_pmds.pmds002,  l_pmds.pmds003,  l_pmds.pmds006,  l_pmds.pmds007,
                l_pmds.pmds008,  l_pmds.pmds009,  l_pmds.pmds010,  l_pmds.pmds011,  l_pmds.pmds012,
                l_pmds.pmds013,  l_pmds.pmds014,  l_pmds.pmds021,  l_pmds.pmds022,  l_pmds.pmds023,
                l_pmds.pmds024,  l_pmds.pmds028,  l_pmds.pmds031,  l_pmds.pmds032,  l_pmds.pmds033,
                l_pmds.pmds034,  l_pmds.pmds035,  l_pmds.pmds036,  l_pmds.pmds037,  l_pmds.pmds038,
                l_pmds.pmds039,  l_pmds.pmds040,  l_pmds.pmds041,  l_pmds.pmds042,  l_pmds.pmds043,
                l_pmds.pmds044,  l_pmds.pmds045,  l_pmds.pmds046,  l_pmds.pmds047,  l_pmds.pmds048,
                l_pmds.pmds049,  l_pmds.pmds050,  l_pmds.pmds051,  l_pmds.pmds052,  l_pmds.pmds053,
                l_pmds.pmds081,  l_pmds.pmds100,  l_pmds.pmds101,  l_pmds.pmds102,  l_pmds.pmdsownid,
                l_pmds.pmdsowndp,l_pmds.pmdscrtid,l_pmds.pmdscrtdp,l_pmds.pmdscrtdt,l_pmds.pmdsmodid,
                l_pmds.pmdsmoddt,l_pmds.pmdscnfid,l_pmds.pmdscnfdt,l_pmds.pmdspstid,l_pmds.pmdspstdt,
                l_pmds.pmdsstus, l_pmds.pmdsud001,l_pmds.pmdsud002,l_pmds.pmdsud003,l_pmds.pmdsud004,
                l_pmds.pmdsud005,l_pmds.pmdsud006,l_pmds.pmdsud007,l_pmds.pmdsud008,l_pmds.pmdsud009,
                l_pmds.pmdsud010,l_pmds.pmdsud011,l_pmds.pmdsud012,l_pmds.pmdsud013,l_pmds.pmdsud014,
                l_pmds.pmdsud015,l_pmds.pmdsud016,l_pmds.pmdsud017,l_pmds.pmdsud018,l_pmds.pmdsud019,
                l_pmds.pmdsud020,l_pmds.pmdsud021,l_pmds.pmdsud022,l_pmds.pmdsud023,l_pmds.pmdsud024,
                l_pmds.pmdsud025,l_pmds.pmdsud026,l_pmds.pmdsud027,l_pmds.pmdsud028,l_pmds.pmdsud029,
                l_pmds.pmdsud030,l_pmds.pmds200,  l_pmds.pmds054,  l_pmds.pmds055,  l_pmds.pmds201,
                l_pmds.pmds202,  l_pmds.pmdsunit, l_pmds.pmds056,  l_pmds.pmds057,  l_pmds.pmds058,
                l_pmds.pmds103
              )
     #161104-00002#11 161110 By rainy mod---(E)   
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'ins pmds'
          LET g_errparam.popup = TRUE
          CALL cl_err()
              
          LET r_success = FALSE
          EXIT FOREACH 
       END IF       

      #mark by geza 20160107(S)
#      LET l_sql="INSERT INTO pmdt_t(pmdtent,pmdtsite,pmdtdocno,pmdtseq,",
#                "                   pmdt006,pmdt011,pmdt016,pmdt017,pmdt018,pmdt019,pmdt020,",
#                "                   pmdt021,pmdt022,pmdt023,pmdt024,pmdt025,",
#                "                   pmdt026,pmdt036,pmdt037,",
#                "                   pmdt038,pmdt039,pmdt041,",
#                "                   pmdt044,pmdt046,pmdt047,",
#                "                   pmdt052,pmdt053,pmdt054,pmdt055,",
#                "                   pmdt056,pmdt057,pmdt058,pmdt060,",
#                "                   pmdt061,pmdt062,",
#                "                   pmdt066,pmdt067,pmdt068,pmdt069,",
#                "                   pmdt200,pmdt201,pmdt202,pmdt203,pmdt204,",
#                "                   pmdt205,",
#                "                   pmdt210,pmdt211,pmdt212,pmdt213,pmdtorga,",
#                "                   pmdt214,pmdt215,",
#                "                   pmdt218,pmdt220)",                                        #151202-00010#2 151216 by lori add pmdt220
#                "            SELECT DISTINCT pmdrent,pmdrsite,'",l_pmds.pmdsdocno,"',rownum,",
#                "                   pmdr002,1,pmdr004,pmdr005,pmdr006,imaf143,pmdr007,",      #mark by geza 20151120  #add by geza 20151215
#                #"                   pmdr002,1,rtdx044,pmdr005,pmdr006,imaf143,pmdr007,",     #add by geza 20151120 #mark by geza 20151215
#                "                   imaf143,pmdr007,imaf143,pmdr007,'1',",
#                "                   'N',pmdr008,oodb006,",
#                "                   ROUND(pmdr009/(1+oodb006/100),2),pmdr009,'N',", 
#                #"                   pmdr008,rtdx035,pmdr009-ROUND(pmdr009/(1+oodb006/100),2),",#mark by geza 20151030
#                "                   pmdr008,stas020,pmdr009-ROUND(pmdr009/(1+oodb006/100),2),", #add by geza 20151030
#                "                   '1',pmdr007,0,0, ",
#                "                   0,0,0,pmdr006,",
#                "                   pmdr007,'N',",
#                "                   0,0,0,0,",
#                #"                   rtdx002,rtdx004,pmdr007,pmdrsite,stan016,",#mark by geza 20151030
#                "                   rtdx002,rtdx004,pmdr007,pmdrsite,star008,",#add by geza 20151030
#                "                   pmdrsite,",
#                #"                   stan002,stan009,stan001,star001,stan013,",#mark by geza 20151030
#                "                   star005,star006,star004,star001,star007,", #add by geza 20151030
#                "                   rtdx027,pmdrsite,",
#                "                   pmdr008,",
#                "                   (SELECT imaa009 FROM imaa_t WHERE imaaent = pmdrent AND imaa001 = pmdr002) ",   #151202-00010#2 151216 by lori add                
#                "              FROM pmdr_t,imaf_t,oodb_t,ooef_t,rtdx_t,stas_t,star_t",
#                "             WHERE pmdrent=",g_enterprise,
#                "               AND pmdrdocno='",p_docno,"'",
#                "               AND pmdrsite='",l_pmdrsite,"'",
#                "               AND pmdrdocdt='",l_pmdrdocdt,"'",
#                "               AND pmdr001='",l_pmdr001,"'",
#                "               AND pmdrent=imafent",
#                "               AND pmdrsite=imafsite",
#                "               AND pmdr002=imaf001",
#                "               AND pmdrent=ooefent",
#                "               AND pmdrent=oodbent",
#                "               AND ooef001=pmdrsite",
#                "               AND ooefstus='Y'",
#                "               AND ooef019=oodb001",
#                #"               AND rtdx035=oodb002", #mark by geza 20151030
#                "               AND stas020=oodb002",  #add by geza 20151030
#                "               AND pmdrent=rtdxent",
#                "               AND pmdrsite=rtdxsite",
#                "               AND pmdr002=rtdx001",
#                "               AND stasent=starent",
#                "               AND stas001=star001",
#                "               AND stassite=starsite",
#                "               AND stassite=pmdrsite",
#                "               AND star003=pmdr001",
#                "               AND stas003=pmdr002",
#                "               AND starstus='Y'"
#                #"               AND stas018<='",g_today,"'", #mark by geza 20151030
#                #"               AND stas019>='",g_today,"'", #mark by geza 20151030               
#                #"               AND stanent=starent",        #mark by geza 20151030    
#                #"               AND star004=stan001"         #mark by geza 20151030 
#       PREPARE apmp864_insert_pmdt_pre FROM l_sql
#       EXECUTE apmp864_insert_pmdt_pre                         
#       IF SQLCA.sqlcode THEN
#          INITIALIZE g_errparam TO NULL
#          LET g_errparam.code = SQLCA.sqlcode
#          LET g_errparam.extend = 'ins pmdt'
#          LET g_errparam.popup = TRUE
#          CALL cl_err()
#              
#          LET r_success = FALSE
#          EXIT FOREACH 
#       END IF      
       #mark by geza 20160107(E)
       
       #add by geza 20160107(S)
       #不存在于门店商品清单是否自动新增=Y，新增pmdt的时候分两个sql，存在的关联采购协议，不存在的只关联门店清单
       IF g_checkbox ='Y' THEN
          #存在采购协议的写入pmdt_t
          LET l_sql="INSERT INTO pmdt_t(pmdtent,pmdtsite,pmdtdocno,pmdtseq,",
                    "                   pmdt006,pmdt011,pmdt016,pmdt017,pmdt018,pmdt019,pmdt020,",
                    "                   pmdt021,pmdt022,pmdt023,pmdt024,pmdt025,",
                    "                   pmdt026,pmdt036,pmdt037,",
                    "                   pmdt038,pmdt039,pmdt041,",
                    "                   pmdt044,pmdt046,pmdt047,",
                    "                   pmdt052,pmdt053,pmdt054,pmdt055,",
                    "                   pmdt056,pmdt057,pmdt058,pmdt060,",
                    "                   pmdt061,pmdt062,",
                    "                   pmdt066,pmdt067,pmdt068,pmdt069,",
                    "                   pmdt200,pmdt201,pmdt202,pmdt203,pmdt204,",
                    "                   pmdt205,",
                    "                   pmdt210,pmdt211,pmdt212,pmdt213,pmdtorga,",
                    "                   pmdt214,pmdt215,",
                    "                   pmdt218,pmdt220)",                                        
                    "            SELECT DISTINCT pmdrent,pmdrsite,'",l_pmds.pmdsdocno,"',rownum,",
                    "                   pmdr002,1,pmdr004,pmdr005,pmdr006,imaf143,pmdr007,",      
                    "                   imaf143,pmdr007,imaf143,pmdr007,'1',",
                    "                   'N',pmdr008,oodb006,",
                    "                   ROUND(pmdr009/(1+oodb006/100),2),pmdr009,'N',", 
                    "                   pmdr008,stas020,pmdr009-ROUND(pmdr009/(1+oodb006/100),2),", 
                    "                   '1',pmdr007,0,0, ",
                    "                   0,0,0,pmdr006,",
                    "                   pmdr007,'N',",
                    "                   0,0,0,0,",
                    "                   rtdx002,rtdx004,pmdr007,pmdrsite,star008,",
                    "                   pmdrsite,",
                    "                   star005,star006,star004,star001,star007,", 
                    "                   rtdx027,pmdrsite,",
                    "                   pmdr008,",
                    "                   (SELECT imaa009 FROM imaa_t WHERE imaaent = pmdrent AND imaa001 = pmdr002) ",   
                    "              FROM pmdr_t,imaf_t,oodb_t,ooef_t,rtdx_t,stas_t,star_t",
                    "             WHERE pmdrent=",g_enterprise,
                    "               AND pmdrdocno='",l_pmdrdocno,"'",
                    "               AND pmdrsite='",l_pmdrsite,"'",
                    "               AND pmdrdocdt='",l_pmdrdocdt,"'",
                    "               AND pmdr001='",l_pmdr001,"'",
                    "               AND pmdrent=imafent",
                    "               AND pmdrsite=imafsite",
                    "               AND pmdr002=imaf001",
                    "               AND pmdrent=ooefent",
                    "               AND pmdrent=oodbent",
                    "               AND ooef001=pmdrsite",
                    "               AND ooefstus='Y'",
                    "               AND ooef019=oodb001",
                    "               AND stas020=oodb002",  
                    "               AND pmdrent=rtdxent",
                    "               AND pmdrsite=rtdxsite",
                    "               AND pmdr002=rtdx001",
                    "               AND stasent=starent",
                    "               AND stas001=star001",
                    "               AND stassite=starsite",
                    "               AND stassite=pmdrsite",
                    "               AND star003=pmdr001",
                    "               AND stas003=pmdr002",
                    "               AND starstus='Y'",
                    "               AND pmdr011='N'",
                    "               AND EXISTS(SELECT 1 ",
                    "                            FROM star_t,stas_t         ",
                    "                           WHERE starent=stasent       ",
                    "                             AND star001=stas001       ",
                    "                             AND starsite=stassite     ",
                    "                             AND starsite=pmdrsite     ",
                    "                             AND star003=pmdr001       ",
                    "                             AND starent=pmdrent  ",
                    "                             AND starstus='Y'          ",
                    "                             AND stas003=pmdr002       ",
                    "                             AND starsite=pmdrsite)   "
          PREPARE apmp864_insert_pmdt_pre1 FROM l_sql
          EXECUTE apmp864_insert_pmdt_pre1                         
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'ins pmdt'
             LET g_errparam.popup = TRUE
             CALL cl_err()
                 
             LET r_success = FALSE
             EXIT FOREACH 
          END IF
          
          #不存在采购协议的写入pmdt_t
          LET l_sql="INSERT INTO pmdt_t(pmdtent,pmdtsite,pmdtdocno,pmdtseq,",
                    "                   pmdt006,pmdt011,pmdt016,pmdt017,pmdt018,pmdt019,pmdt020,",
                    "                   pmdt021,pmdt022,pmdt023,pmdt024,pmdt025,",
                    "                   pmdt026,pmdt036,pmdt037,",
                    "                   pmdt038,pmdt039,pmdt041,",
                    "                   pmdt044,pmdt046,pmdt047,",
                    "                   pmdt052,pmdt053,pmdt054,pmdt055,",
                    "                   pmdt056,pmdt057,pmdt058,pmdt060,",
                    "                   pmdt061,pmdt062,",
                    "                   pmdt066,pmdt067,pmdt068,pmdt069,",
                    "                   pmdt200,pmdt201,pmdt202,pmdt203,pmdt204,",
                    "                   pmdt205,",
                    "                   pmdt210,pmdt211,pmdt212,pmdt213,pmdtorga,",
                    "                   pmdt214,pmdt215,",
                    "                   pmdt218,pmdt220)",                                        
                    "            SELECT DISTINCT pmdrent,pmdrsite,'",l_pmds.pmdsdocno,"',rownum,",
                    "                   pmdr002,1,pmdr004,pmdr005,pmdr006,imaf143,pmdr007,",      
                    "                   imaf143,pmdr007,imaf143,pmdr007,'1',",
                    "                   'N',pmdr008,oodb006,",
                    "                   ROUND(pmdr009/(1+oodb006/100),2),pmdr009,'N',", 
                    "                   pmdr008,rtdx035,pmdr009-ROUND(pmdr009/(1+oodb006/100),2),", 
                    "                   '1',pmdr007,0,0, ",
                    "                   0,0,0,pmdr006,",
                    "                   pmdr007,'N',",
                    "                   0,0,0,0,",
                    "                   rtdx002,rtdx004,pmdr007,pmdrsite,rtdx028,",
                    "                   pmdrsite,",
                    "                   rtdx003,'','','','',", 
                    "                   rtdx027,pmdrsite,",
                    "                   pmdr008,",
                    "                   (SELECT imaa009 FROM imaa_t WHERE imaaent = pmdrent AND imaa001 = pmdr002) ",   
                    "              FROM pmdr_t,imaf_t,oodb_t,ooef_t,rtdx_t",
                    "             WHERE pmdrent=",g_enterprise,
                    "               AND pmdrdocno='",l_pmdrdocno,"'",
                    "               AND pmdrsite='",l_pmdrsite,"'",
                    "               AND pmdrdocdt='",l_pmdrdocdt,"'",
                    "               AND pmdr001='",l_pmdr001,"'",
                    "               AND pmdrent=imafent",
                    "               AND pmdrsite=imafsite",
                    "               AND pmdr002=imaf001",
                    "               AND pmdrent=ooefent",
                    "               AND pmdrent=oodbent",
                    "               AND ooef001=pmdrsite",
                    "               AND ooefstus='Y'",
                    "               AND ooef019=oodb001",
                    "               AND rtdx035=oodb002",  
                    "               AND pmdrent=rtdxent",
                    "               AND pmdrsite=rtdxsite",
                    "               AND pmdr002=rtdx001",
                    "               AND pmdr011='N'",
                    "               AND NOT EXISTS(SELECT 1 ",
                    "                                FROM star_t,stas_t         ",
                    "                               WHERE starent=stasent       ",
                    "                                 AND star001=stas001       ",
                    "                                 AND starsite=stassite     ",
                    "                                 AND starsite=pmdrsite     ",
                    "                                 AND star003=pmdr001       ",
                    "                                 AND starent=pmdrent  ",
                    "                                 AND starstus='Y'          ",
                    "                                 AND stas003=pmdr002       ",
                    "                                 AND starsite=pmdrsite)   "
         
          PREPARE apmp864_insert_pmdt_pre2 FROM l_sql
          EXECUTE apmp864_insert_pmdt_pre2                         
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'ins pmdt'
             LET g_errparam.popup = TRUE
             CALL cl_err()
                 
             LET r_success = FALSE
             EXIT FOREACH 
          END IF
       ELSE
          LET l_sql="INSERT INTO pmdt_t(pmdtent,pmdtsite,pmdtdocno,pmdtseq,",
                    "                   pmdt006,pmdt011,pmdt016,pmdt017,pmdt018,pmdt019,pmdt020,",
                    "                   pmdt021,pmdt022,pmdt023,pmdt024,pmdt025,",
                    "                   pmdt026,pmdt036,pmdt037,",
                    "                   pmdt038,pmdt039,pmdt041,",
                    "                   pmdt044,pmdt046,pmdt047,",
                    "                   pmdt052,pmdt053,pmdt054,pmdt055,",
                    "                   pmdt056,pmdt057,pmdt058,pmdt060,",
                    "                   pmdt061,pmdt062,",
                    "                   pmdt066,pmdt067,pmdt068,pmdt069,",
                    "                   pmdt200,pmdt201,pmdt202,pmdt203,pmdt204,",
                    "                   pmdt205,",
                    "                   pmdt210,pmdt211,pmdt212,pmdt213,pmdtorga,",
                    "                   pmdt214,pmdt215,",
                    "                   pmdt218,pmdt220)",                                        
                    "            SELECT DISTINCT pmdrent,pmdrsite,'",l_pmds.pmdsdocno,"',rownum,",
                    "                   pmdr002,1,pmdr004,pmdr005,pmdr006,imaf143,pmdr007,",      
                    "                   imaf143,pmdr007,imaf143,pmdr007,'1',",
                    "                   'N',pmdr008,oodb006,",
                    "                   ROUND(pmdr009/(1+oodb006/100),2),pmdr009,'N',", 
                    "                   pmdr008,stas020,pmdr009-ROUND(pmdr009/(1+oodb006/100),2),", 
                    "                   '1',pmdr007,0,0, ",
                    "                   0,0,0,pmdr006,",
                    "                   pmdr007,'N',",
                    "                   0,0,0,0,",
                    "                   rtdx002,rtdx004,pmdr007,pmdrsite,star008,",
                    "                   pmdrsite,",
                    "                   star005,star006,star004,star001,star007,", 
                    "                   rtdx027,pmdrsite,",
                    "                   pmdr008,",
                    "                   (SELECT imaa009 FROM imaa_t WHERE imaaent = pmdrent AND imaa001 = pmdr002) ",   
                    "              FROM pmdr_t,imaf_t,oodb_t,ooef_t,rtdx_t,stas_t,star_t",
                    "             WHERE pmdrent=",g_enterprise,
                    "               AND pmdrdocno='",l_pmdrdocno,"'",
                    "               AND pmdrsite='",l_pmdrsite,"'",
                    "               AND pmdrdocdt='",l_pmdrdocdt,"'",
                    "               AND pmdr001='",l_pmdr001,"'",
                    "               AND pmdrent=imafent",
                    "               AND pmdrsite=imafsite",
                    "               AND pmdr002=imaf001",
                    "               AND pmdrent=ooefent",
                    "               AND pmdrent=oodbent",
                    "               AND ooef001=pmdrsite",
                    "               AND ooefstus='Y'",
                    "               AND ooef019=oodb001",
                    "               AND stas020=oodb002",  
                    "               AND pmdrent=rtdxent",
                    "               AND pmdrsite=rtdxsite",
                    "               AND pmdr002=rtdx001",
                    "               AND stasent=starent",
                    "               AND stas001=star001",
                    "               AND stassite=starsite",
                    "               AND stassite=pmdrsite",
                    "               AND star003=pmdr001",
                    "               AND stas003=pmdr002",
                    "               AND starstus='Y'",
                    "               AND pmdr011='N'"
                   
          PREPARE apmp864_insert_pmdt_pre3 FROM l_sql
          EXECUTE apmp864_insert_pmdt_pre3                         
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'ins pmdt'
             LET g_errparam.popup = TRUE
             CALL cl_err()
                 
             LET r_success = FALSE
             EXIT FOREACH 
          END IF          
       END IF
       
       #按照来源单号/供应商/商品/库区/储位/批号 来回写pmdr011
#       IF p_docno IS NOT NULL THEN
#          LET l_sql="  MERGE INTO pmdr_t ",
#                    "  USING (SELECT pmdssite,pmdsdocdt,pmds007",  
#                    "           FROM pmds_t,pmdt_t",
#                    "          WHERE pmdsent=",g_enterprise,
#                    "            AND pmdsent=pmdtent ",
#                    "            AND pmdsdocno=pmdtdocno",
#                    "            AND pmdtdocno='",l_pmds.pmdsdocno,"'", 
#                    "            AND pmdssite='",l_pmdrsite,"'",
#                    "            AND pmdsdocdt=to_date('",l_pmdrdocdt,"','yy/mm/dd')",
#                    "            AND pmds007='",l_pmdr001,"')",
#                    "    ON  (pmdrent=",g_enterprise," AND pmdrdocno = '",p_docno,"' AND pmdssite = pmdrsite AND pmdsdocdt= pmdrdocdt AND pmdr001 = pmds007 AND ",l_wc,") ",
#                    "  WHEN MATCHED THEN ",
#                    "       UPDATE SET pmdr011 = 'Y'"
#       ELSE
#          LET l_sql="  MERGE INTO pmdr_t ",
#                    "  USING (SELECT pmdssite,pmdsdocdt,pmds007",  
#                    "           FROM pmds_t,pmdt_t",
#                    "          WHERE pmdsent=",g_enterprise,
#                    "            AND pmdsent=pmdtent ",
#                    "            AND pmdsdocno=pmdtdocno",
#                    "            AND pmdtdocno='",l_pmds.pmdsdocno,"'", 
#                    "            AND pmdssite='",l_pmdrsite,"'",
#                    "            AND pmdsdocdt=to_date('",l_pmdrdocdt,"','yy/mm/dd')",
#                    "            AND pmds007='",l_pmdr001,"')",
#                    "    ON  (pmdrent=",g_enterprise," AND pmdssite = pmdrsite AND pmdsdocdt= pmdrdocdt AND pmdr001 = pmds007 AND ",l_wc,") ",
#                    "  WHEN MATCHED THEN ",
#                    "       UPDATE SET pmdr011 = 'Y'"  
#       END IF
       LET l_sql="UPDATE pmdr_t ",
                 "   SET pmdr011 = 'Y'",  
                 " WHERE pmdrent=",g_enterprise,
                 "   AND pmdrsite='",l_pmdrsite,"'",
                 "   AND pmdrdocdt=to_date('",l_pmdrdocdt,"','yy/mm/dd')",
                 "   AND pmdr001='",l_pmdr001,"'",
                 "   AND pmdrdocno = '",l_pmdrdocno,"' AND ",l_wc," "
       PREPARE apmp864_update_pmdr_pre FROM l_sql
       EXECUTE apmp864_update_pmdr_pre                         
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'UPDATE pmdr_t'
          LET g_errparam.popup = TRUE
          CALL cl_err()
              
          LET r_success = FALSE
          EXIT FOREACH 
       END IF 
       #add by geza 20160107(E)
       
       
       
       LET l_sql="INSERT INTO pmdu_t (pmduent,pmdusite,pmdudocno,pmduseq,pmduseq1,",
                 "                    pmdu001,pmdu006,",
                 "                    pmdu007,pmdu008,pmdu009,pmdu010,pmdu011,pmdu012,",
                 "                    pmdu013,pmdu014,pmdu015,",
                 "                    pmdu200,pmdu201)",
                 "             SELECT pmdtent,pmdtsite,pmdtdocno,pmdtseq,1,",
                 "                    pmdt006,pmdt016,",
                 "                    pmdt017,pmdt018,pmdt019,pmdt020,pmdt019,pmdt020,",
                 "                    pmdt020,0,0,",
                 "                    pmdt201,pmdt202",
                 "               FROM pmdt_t",
                 "              WHERE pmdtent=",g_enterprise,
                 "                AND pmdtdocno='",l_pmds.pmdsdocno,"'" 
                 
       PREPARE apmp864_insert_pmdu_pre FROM l_sql
       EXECUTE apmp864_insert_pmdu_pre                         
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'ins pmdu'
          LET g_errparam.popup = TRUE
          CALL cl_err()
              
          LET r_success = FALSE
          EXIT FOREACH 
       END IF 
       
       LET l_sql="INSERT INTO xrcd_t(xrcdent,xrcdcomp,xrcdld,xrcdsite,xrcddocno,xrcdseq,xrcdseq2,xrcdorga,",
                 "                   xrcd001,xrcd002,xrcd003,xrcd004,xrcd005,xrcd006,xrcd007,",
                 "                   xrcd100,xrcd101,xrcd102,xrcd103,xrcd104,xrcd105,xrcd106,",
                 "                   xrcd112,xrcd113,xrcd114,xrcd115,xrcd116)",
                 "            SELECT pmdtent,ooef017,' ',pmdtsite,pmdtdocno,pmdtseq,0,pmdtsite,",
                 "                   'apmt864',pmdt046,pmdt037,0,pmdt020,'Y',1,",
                 "                   'CNY',1,1,pmdt038,pmdt047,pmdt039,0,",
                 "                   1,pmdt038,pmdt047,pmdt039,0",
                 "              FROM pmdt_t,ooef_t",
                 "             WHERE pmdtent=",g_enterprise,
                 "               AND pmdtdocno='",l_pmds.pmdsdocno,"'",
                 "               AND ooefent=pmdtent",
                 "               AND ooef001=pmdtsite",
                 "               AND ooefstus='Y'"
                 
       PREPARE apmp864_insert_xrcd_pre FROM l_sql
       EXECUTE apmp864_insert_xrcd_pre                         
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'ins xrcd'
          LET g_errparam.popup = TRUE
          CALL cl_err()
              
          LET r_success = FALSE
          EXIT FOREACH 
       END IF                 
     
    END FOREACH
    
    IF r_success THEN 
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = 'aap-00125'
       LET g_errparam.extend = ''
       LET g_errparam.popup = TRUE
       LET g_errparam.replace[1] = l_string
       CALL cl_err()  
       #CALL s_transaction_end('Y',1)    #mark by geza 20151030
       CALL s_transaction_end('Y','0')   #add by geza 20151030
    ELSE
       CALL s_transaction_end('N',0)
    END IF
    
    RETURN r_success
    
    
END FUNCTION

################################################################################
# Descriptions...:     #每次導入后--按照領導要求，刪除中間表來源單號為g_time的資料 
# Memo...........:
# Usage..........: CALL apmp864_excel_deletepmdr(p_docno)
#                  RETURNING r_success
# Input parameter: p_docno        來源單號
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 20151030 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp864_excel_deletepmdr(p_docno)
DEFINE p_docno       LIKE pmds_t.pmds201
DEFINE r_success     LIKE type_t.num5


    LET r_success=TRUE
    
    DELETE FROM pmdr_t WHERE pmdrent=g_enterprise AND pmdrdocno=p_docno
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = 'del pmdr'
       LET g_errparam.popup = TRUE
       CALL cl_err()
           
       LET r_success = FALSE
       RETURN r_success
    END IF    
    

    RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 创建临时表
# Memo...........:
# Usage..........: CALL apmp864_create_tmp(p_type)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 20151120 By geza 
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp864_create_tmp(p_type)
DEFINE p_type     LIKE type_t.chr1
DEFINE r_success  LIKE type_t.num5
 
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   IF p_type = '1' THEN
      CREATE TEMP TABLE apmp864_tmp(
          #pmdr000          LIKE type_t.chr1,      #类型 #mark by geza 20160119
          pmdr000           VARCHAR(5),           #类型 #add by geza 20160119
          pmdrsite          VARCHAR(10),       #组织
          pmdr001           VARCHAR(10),        #供应商
          pmdr002           VARCHAR(40),        #商品
          pmdr006           VARCHAR(30))        #批号
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'Create apmp864_tmp'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   IF p_type = '2' THEN
      DROP TABLE apmp864_tmp
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 数据清单删除
# Memo...........:
# Usage..........: CALL apmp864_pmdr_delete(p_pmds201)
#                  RETURNING 回传参数
# Input parameter: p_pmds201   单据编号
# Date & Author..: 20160119 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp864_pmdr_delete(p_pmds201)
DEFINE p_pmds201   LIKE pmds_t.pmds201  
DEFINE l_sql       STRING
DEFINE l_success   LIKE type_t.num5   
DEFINE l_cnt         LIKE type_t.num10       #add by geza 20160125  
  LET l_success = TRUE
  IF p_pmds201 IS NOT NULL THEN
     LET l_cnt = 0
     SELECT COUNT(*) INTO l_cnt
       FROM pmdr_t
      WHERE pmdrent = g_enterprise
        AND pmdrdocno = p_pmds201
     IF l_cnt = 0 THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.extend = ''
        LET g_errparam.code   = 'apm-01079'
        LET g_errparam.popup  = TRUE
        CALL cl_err()
        RETURN
     END IF
     LET l_cnt = 0
     SELECT COUNT(*) INTO l_cnt
       FROM pmdr_t
      WHERE pmdrent = g_enterprise
        AND pmdrdocno = p_pmds201
        AND pmdr011 = 'N'
     IF l_cnt = 0 THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.extend = ''
        LET g_errparam.code   = 'apm-01080'
        LET g_errparam.popup  = TRUE
        CALL cl_err()
        RETURN
     END IF
  END IF
  
  CALL s_transaction_begin()
  LET l_sql = " DELETE FROM pmdr_t WHERE pmdrent = '",g_enterprise,"' AND pmdr011 = 'N' AND pmdrdocno = '",p_pmds201,"'" 
  
  PREPARE del_pmdr_pre FROM l_sql
  
  EXECUTE del_pmdr_pre  
  
  IF SQLCA.sqlcode  THEN
     INITIALIZE g_errparam TO NULL 
     LET g_errparam.extend = ''
     LET g_errparam.code   = SQLCA.sqlcode 
     LET g_errparam.popup  = TRUE
     CALL cl_err()
     LET l_success =FALSE
  ELSE
     CALL cl_ask_confirm3("adz-00217","")
  END IF

  
  IF l_success THEN 
     CALL s_transaction_end('Y','0')    
  ELSE
     CALL s_transaction_end('N',0)
  END IF   
   
END FUNCTION

################################################################################
# Descriptions...: 开启数据清单画面
# Memo...........:
# Usage..........: CALL apmp864_pmdr_clear()
#                  RETURNING 回传参数
# Date & Author..: 20160121 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp864_pmdr_clear()
DEFINE l_cnt         LIKE type_t.num10       #add by geza 20160125  
   INITIALIZE g_pmdrdocno TO NULL   
   
   OPEN WINDOW w_apmp864_s01 WITH FORM cl_ap_formpath("apm",'apmp864_s01')
    
#   WHILE TRUE
#      INPUT g_pmdsdocno,g_pmdrdocno FROM pmdsdocno,pmds201 ATTRIBUTE(WITHOUT DEFAULTS)     #WITHOUT DEFAULTS
#         BEFORE INPUT
#         
#         DISPLAY g_pmdsdocno,g_pmdrdocno TO pmdsdocno,pmds201
#         
#         BEFORE FIELD  pmds201    
#         
#         ON ACTION controlp INFIELD pmds201
#            #add-point:ON ACTION controlp INFIELD pmds201
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'i'
#            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.where = " pmdr011 = 'N' "
#            CALL q_pmdrdocno()
#            LET g_pmdrdocno = g_qryparam.return1
#            DISPLAY g_pmdrdocno TO pmds201  #顯示到畫面上
#            NEXT FIELD pmds201   
#          
#         AFTER FIELD  pmds201        
#           LET g_pmdrdocno = GET_FLDBUF(pmdrdocno)
#           IF g_pmdrdocno IS NOT NULL THEN
#              LET l_cnt = 0
#              SELECT COUNT(*) INTO l_cnt
#                FROM pmdr_t
#               WHERE pmdrent = g_enterprise
#                 AND pmdrdocno = g_pmdrdocno
#              IF l_cnt = 0 THEN
#                 INITIALIZE g_errparam TO NULL
#                 LET g_errparam.extend = ''
#                 LET g_errparam.code   = 'apm-01079'
#                 LET g_errparam.popup  = TRUE
#                 CALL cl_err()
#                 LET g_pmdrdocno = ''
#                 NEXT FIELD CURRENT 
#              END IF
#              LET l_cnt = 0
#              SELECT COUNT(*) INTO l_cnt
#                FROM pmdr_t
#               WHERE pmdrent = g_enterprise
#                 AND pmdrdocno = g_pmdrdocno
#                 AND pmdr011 = 'N'
#              IF l_cnt = 0 THEN
#                 INITIALIZE g_errparam TO NULL
#                 LET g_errparam.extend = ''
#                 LET g_errparam.code   = 'apm-01080'
#                 LET g_errparam.popup  = TRUE
#                 CALL cl_err()
#                 LET g_pmdrdocno = ''
#                 NEXT FIELD CURRENT 
#              END IF
#           END IF
#            
#         AFTER INPUT
#            
#         ON ACTION accept
#            LET INT_FLAG = TRUE
#            CALL apmp864_pmdr_delete(g_pmdrdocno)   
#            CALL apmp864_b_fill()            
#            ACCEPT INPUT
#         
#         ON ACTION cancel
#            LET INT_FLAG = TRUE 
#            EXIT INPUT 
#            
#      END INPUT
#      
#      IF INT_FLAG THEN
#         EXIT WHILE
#      ELSE
#         CONTINUE WHILE
#      END IF      
#   END WHILE
     
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT g_pmdsdocno,g_pmdrdocno FROM pmdsdocno,pmds201 ATTRIBUTE(WITHOUT DEFAULTS)     #WITHOUT DEFAULTS
         BEFORE INPUT
         
         DISPLAY g_pmdsdocno,g_pmdrdocno TO pmdsdocno,pmds201
            
         
         ON ACTION controlp INFIELD pmds201
            #add-point:ON ACTION controlp INFIELD pmds201
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " pmdr011 = 'N' "
            CALL q_pmdrdocno()
            LET g_pmdrdocno = g_qryparam.return1
            DISPLAY g_pmdrdocno TO pmds201  #顯示到畫面上
            NEXT FIELD pmds201   
                      
         AFTER INPUT
      END INPUT

      ON ACTION accept
         LET INT_FLAG = TRUE
         CALL apmp864_pmdr_delete(g_pmdrdocno)   
         CALL apmp864_b_fill()            
         ACCEPT DIALOG
      
      ON ACTION cancel
         LET INT_FLAG = TRUE 
         EXIT DIALOG 
                  
   END DIALOG

   CLOSE WINDOW w_apmp864_s01
   
   
END FUNCTION

#end add-point
 
{</section>}
 
