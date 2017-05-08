#該程式未解開Section, 採用最新樣板產出!
{<section id="artp741.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2015-01-30 09:59:11), PR版次:0002(2016-04-27 14:10:44)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000066
#+ Filename...: artp741
#+ Description: 自動補貨模型初始化
#+ Creator....: 03247(2015-01-14 16:15:44)
#+ Modifier...: 03247 -SD/PR- 07673
 
{</section>}
 
{<section id="artp741.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#52 2016/04/27 By 07673   將重複內容的錯誤訊息置換為公用錯誤訊息
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
#歷史數據頁簽        
        sel              LIKE type_t.chr1,
        rtdxsite_1       LIKE rtdx_t.rtdxsite,
        rtdxsite_1_desc  LIKE ooefl_t.ooefl003,
        rtax001_1        LIKE rtax_t.rtax001,
        rtax001_1_desc   LIKE rtaxl_t.rtaxl003,
        amt1_1           LIKE inag_t.inag009,
        sdate_1          LIKE debs_t.debs002,
        amt2_1           LIKE inag_t.inag009,
        amt3_1           LIKE inag_t.inag009,
        amt4_1           LIKE inag_t.inag009,
        amt5_1           LIKE inag_t.inag009
                     END RECORD
#待計算數據頁簽
DEFINE g_detail2_d   DYNAMIC ARRAY OF RECORD
        sel2             LIKE type_t.chr1,
        rtdxsite_2       LIKE rtdx_t.rtdxsite,
        rtdxsite_2_desc  LIKE ooefl_t.ooefl003,
        rtax001_2        LIKE rtax_t.rtax001,
        rtax001_2_desc   LIKE rtaxl_t.rtaxl003,
        amt1_2           LIKE inag_t.inag009,
        sdate_2          LIKE debs_t.debs002,
        amt2_2           LIKE inag_t.inag009,
        amt3_2           LIKE inag_t.inag009,
        amt4_2           LIKE inag_t.inag009,
        amt5_2           LIKE inag_t.inag009
                     END RECORD
#門店參數預設頁簽
DEFINE g_detail3_d   DYNAMIC ARRAY OF RECORD
       rtki002           LIKE rtki_t.rtki002,
       rtki002_desc      LIKE type_t.chr500,
       rtki003           LIKE rtki_t.rtki003,
       rtki004           LIKE rtki_t.rtki004,
       rtki005           LIKE rtki_t.rtki005,
       rtki006           LIKE rtki_t.rtki006,
       rtki007           LIKE rtki_t.rtki007
                     END RECORD
#品類週參數頁簽
DEFINE g_detail4_d   DYNAMIC ARRAY OF RECORD
       rtkj002           LIKE rtkj_t.rtkj002,
       rtkj002_desc      LIKE type_t.chr500,
       rtkj101           LIKE rtkj_t.rtkj101,
       rtkj102           LIKE rtkj_t.rtkj102,
       rtkj103           LIKE rtkj_t.rtkj103,
       rtkj104           LIKE rtkj_t.rtkj104,
       rtkj105           LIKE rtkj_t.rtkj105,
       rtkj106           LIKE rtkj_t.rtkj106,
       rtkj107           LIKE rtkj_t.rtkj107,
       rtkj108           LIKE rtkj_t.rtkj108,
       rtkj109           LIKE rtkj_t.rtkj109,
       rtkj110           LIKE rtkj_t.rtkj110,
       rtkj111           LIKE rtkj_t.rtkj111,
       rtkj112           LIKE rtkj_t.rtkj112,
       rtkj113           LIKE rtkj_t.rtkj113,
       rtkj114           LIKE rtkj_t.rtkj114,
       rtkj115           LIKE rtkj_t.rtkj115,
       rtkj116           LIKE rtkj_t.rtkj116,
       rtkj117           LIKE rtkj_t.rtkj117,
       rtkj118           LIKE rtkj_t.rtkj118,
       rtkj119           LIKE rtkj_t.rtkj119,
       rtkj120           LIKE rtkj_t.rtkj120,
       rtkj121           LIKE rtkj_t.rtkj121,
       rtkj122           LIKE rtkj_t.rtkj122,
       rtkj123           LIKE rtkj_t.rtkj123,
       rtkj124           LIKE rtkj_t.rtkj124,
       rtkj125           LIKE rtkj_t.rtkj125,
       rtkj126           LIKE rtkj_t.rtkj126,
       rtkj127           LIKE rtkj_t.rtkj127,
       rtkj128           LIKE rtkj_t.rtkj128,
       rtkj129           LIKE rtkj_t.rtkj129,
       rtkj130           LIKE rtkj_t.rtkj130,
       rtkj131           LIKE rtkj_t.rtkj131,
       rtkj132           LIKE rtkj_t.rtkj132,
       rtkj133           LIKE rtkj_t.rtkj133,
       rtkj134           LIKE rtkj_t.rtkj134,
       rtkj135           LIKE rtkj_t.rtkj135,
       rtkj136           LIKE rtkj_t.rtkj136,
       rtkj137           LIKE rtkj_t.rtkj137,
       rtkj138           LIKE rtkj_t.rtkj138,
       rtkj139           LIKE rtkj_t.rtkj139,
       rtkj140           LIKE rtkj_t.rtkj140,
       rtkj141           LIKE rtkj_t.rtkj141,
       rtkj142           LIKE rtkj_t.rtkj142,
       rtkj143           LIKE rtkj_t.rtkj143,
       rtkj144           LIKE rtkj_t.rtkj144,
       rtkj145           LIKE rtkj_t.rtkj145,
       rtkj146           LIKE rtkj_t.rtkj146,
       rtkj147           LIKE rtkj_t.rtkj147,
       rtkj148           LIKE rtkj_t.rtkj148,
       rtkj149           LIKE rtkj_t.rtkj149,
       rtkj150           LIKE rtkj_t.rtkj150,
       rtkj151           LIKE rtkj_t.rtkj151,
       rtkj152           LIKE rtkj_t.rtkj152
                     END RECORD
#品類日參數頁簽
DEFINE g_detail5_d   DYNAMIC ARRAY OF RECORD
       rtkl002           LIKE rtkl_t.rtkl002,
       rtkl002_desc      LIKE type_t.chr500,
       rtkl101           LIKE rtkl_t.rtkl101,
       rtkl102           LIKE rtkl_t.rtkl102,
       rtkl103           LIKE rtkl_t.rtkl103,
       rtkl104           LIKE rtkl_t.rtkl104,
       rtkl105           LIKE rtkl_t.rtkl105,
       rtkl106           LIKE rtkl_t.rtkl106,
       rtkl107           LIKE rtkl_t.rtkl107
                     END RECORD
DEFINE g_method      LIKE type_t.chr1
DEFINE g_deba041     LIKE deba_t.deba041
DEFINE g_rtkh001     LIKE rtkh_t.rtkh001
DEFINE g_rtkh002     LIKE rtkh_t.rtkh002
DEFINE g_rtkh005     LIKE rtkh_t.rtkh005
DEFINE g_point1      LIKE type_t.num5
DEFINE g_point2      LIKE type_t.num5
DEFINE g_step        LIKE type_t.num5
DEFINE g_detail_idx  LIKE type_t.num5
DEFINE g_upd_cnt     LIKE type_t.num10
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="artp741.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
   #add-point:main段define name="main.define"
   DEFINE r_success  LIKE type_t.num5
   DEFINE l_success LIKE type_t.num5      #150308-00001#5  By benson 150309
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("art","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_artp741 WITH FORM cl_ap_formpath("art",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL artp741_init()   
 
      #進入選單 Menu (="N")
      CALL artp741_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      CALL s_artp741_tmp('2') RETURNING r_success
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_artp741
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#5  By benson 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="artp741.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION artp741_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#5  By benson 150309
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc("method","6750")
   CALL cl_set_combo_scc("rtkh002","6301")
   LET gfrm_curr = gwin_curr.getForm()
   LET g_step = 1
   CALL artp741_set_step_img(g_step)
   CALL artp741_set_act_visible(g_step)
   CALL artp741_set_vbox_visible(g_step)
   CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#5  By benson 150309
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="artp741.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION artp741_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_n         LIKE type_t.num5
   DEFINE l_sql       STRING
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL s_artp741_tmp('1') RETURNING r_success
   IF NOT r_success THEN
      RETURN
   END IF
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL artp741_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc ON rtdxsite
            BEFORE CONSTRUCT
               CALL cl_set_act_visible("filter",FALSE)
               
            ON ACTION controlp INFIELD rtdxsite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'debssite',g_site,'c')   #150308-00001#5  By benson add 'c' 
               CALL q_ooef001_24()
               DISPLAY g_qryparam.return1 TO rtdxsite  #顯示到畫面上
               NEXT FIELD CURRENT
         
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT g_method,g_deba041 FROM method,deba041 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            BEFORE INPUT
               CALL cl_set_act_visible("filter",FALSE)
               CALL artp741_set_comp_visible()
               
            ON CHANGE method
               CALL artp741_set_comp_visible()
               
            AFTER FIELD deba041
               IF NOT cl_null(g_deba041) THEN
                  IF g_deba041 > 2100 OR g_deba041 < 2000 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-00018'
                     LET g_errparam.extend = g_deba041
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD deba041
                  END IF
               END IF
               
         END INPUT
         
         INPUT g_rtkh001,g_rtkh002,g_rtkh005,g_point1,g_point2
            FROM rtkh001,rtkh002,rtkh005,point1,point2
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            BEFORE INPUT
               CALL cl_set_act_visible("filter",FALSE)
               #CALL artp741_set_entry()
               #CALL artp741_set_no_entry()
               
            AFTER FIELD rtkh001
               IF NOT cl_null(g_rtkh001) THEN
                  #CALL artp741_set_entry()
                  #CALL artp741_set_no_entry()
               END IF
               CALL artp741_rtkh001_ref()
               
            BEFORE FIELD rtkh002
               IF artp741_rtkh001_chk() THEN
                  NEXT FIELD rtkh005
               END IF
               
            BEFORE FIELD rtkh005
               IF artp741_rtkh001_chk() THEN
                  NEXT FIELD point1
               END IF
               
            AFTER FIELD rtkh005
               IF NOT cl_null(g_rtkh005) THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_rtkh005
                  LET g_errshow = TRUE   #160318-00025#52
                  LET g_chkparam.err_str[1] = "art-00357:sub-01302|arti730|",cl_get_progname("arti730",g_lang,"2"),"|:EXEPROGarti730"    #160318-00025#52
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_rtkg001") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME                 
                  ELSE
                     #檢查失敗時後續處理
                     NEXT FIELD rtkh005
                  END IF
               END IF
               
            AFTER FIELD point1
               IF NOT cl_ap_chk_Range(g_point1,"0.000000","1","100.000000","1","azz-00087",1) THEN
                  NEXT FIELD point1
               END IF
               LET g_point2 = 100 - g_point1
               DISPLAY BY NAME g_point2
               
            AFTER FIELD point2
               IF NOT cl_ap_chk_Range(g_point2,"0.000000","1","100.000000","1","azz-00087",1) THEN
                  NEXT FIELD point2
               END IF
               LET g_point1 = 100 - g_point2
               DISPLAY BY NAME g_point1
            
            ON ACTION controlp INFIELD rtkh001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               CALL q_rtkh001()                          #呼叫開窗
               LET g_rtkh001 = g_qryparam.return1        #將開窗取得的值回傳到變數
               DISPLAY BY NAME g_rtkh001                 #顯示到畫面上
               CALL artp741_rtkh001_ref()
               NEXT FIELD rtkh001
               
            ON ACTION controlp INFIELD rtkh005
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               CALL q_rtkg001()                          #呼叫開窗
               LET g_rtkh005 = g_qryparam.return1        #將開窗取得的值回傳到變數
               DISPLAY BY NAME g_rtkh005                 #顯示到畫面上
               NEXT FIELD rtkh005
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 1
               CALL cl_set_act_visible("filter",FALSE)
               
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_detail_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
               CALL artp741_fetch()
         END DISPLAY
         
         DISPLAY ARRAY g_detail2_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 1
               CALL cl_set_act_visible("filter",FALSE)
               
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_detail2_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
               CALL artp741_fetch()
         END DISPLAY
         
         DISPLAY ARRAY g_detail3_d TO s_detail3.* ATTRIBUTE(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 1
               CALL cl_set_act_visible("filter",FALSE)
               
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_detail3_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
               CALL artp741_fetch()
         END DISPLAY
         
         DISPLAY ARRAY g_detail4_d TO s_detail4.* ATTRIBUTE(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 1
               CALL cl_set_act_visible("filter",FALSE)
               
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_detail4_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
               CALL artp741_fetch()
         END DISPLAY
         
         DISPLAY ARRAY g_detail5_d TO s_detail5.* ATTRIBUTE(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 1
               CALL cl_set_act_visible("filter",FALSE)
               
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail5")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_detail5_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
               CALL artp741_fetch()
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
            CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
            LET g_method = '1'
            IF cl_null(g_deba041) OR g_deba041 = 0 THEN
               LET g_deba041 = YEAR(g_today) - 1
            END IF
            LET g_point1 = NULL
            LET g_point2 = NULL
            CALL DIALOG.setActionActive("accept", FALSE)
            CALL DIALOG.setActionActive("selall", FALSE)
            CALL DIALOG.setActionActive("selnone", FALSE)
            CALL DIALOG.setActionActive("sel", FALSE)
            CALL DIALOG.setActionActive("unsel", FALSE)
            LET g_upd_cnt = 0
            LET g_step = 1
            LET g_wc = ''
            CALL g_detail_d.clear()
            CALL artp741_set_step_img(g_step)
            CALL artp741_set_vbox_visible(g_step)
            CALL artp741_set_act_visible(g_step) 
            DELETE FROM artp741_tmp1
            DELETE FROM artp741_tmp2
            DELETE FROM artp741_tmp3
            DELETE FROM artp741_tmp4
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
            LET l_sql = " UPDATE artp741_tmp1 ",
                        "    SET tmp1_flag = 'Y' ",
                        "  WHERE tmp1_debsent = ",g_enterprise," "
            PREPARE upd_flag_pre1 FROM l_sql
            EXECUTE upd_flag_pre1
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "upd tmp1"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               EXIT DIALOG
            END IF
            LET g_upd_cnt = g_upd_cnt + 1
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
            LET l_sql = " UPDATE artp741_tmp1 ",
                        "    SET tmp1_flag = 'N' ",
                        "  WHERE tmp1_debsent = ",g_enterprise," "
            PREPARE upd_flag_pre2 FROM l_sql
            EXECUTE upd_flag_pre2
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "upd tmp1"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               EXIT DIALOG
            END IF
            LET g_upd_cnt = g_upd_cnt + 1
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            LET l_sql = " UPDATE artp741_tmp1 ",
                        "    SET tmp1_flag = 'Y' ",
                        "  WHERE tmp1_debsent = ",g_enterprise," ",
                        "    AND tmp1_debssite = '",g_detail_d[l_ac].rtdxsite_1,"' ",
                        "    AND tmp1_debs005 = '",g_detail_d[l_ac].rtax001_1,"' ",
                        "    AND tmp1_debs002 = '",g_detail_d[l_ac].sdate_1,"' "
            PREPARE upd_flag_pre3 FROM l_sql
            EXECUTE upd_flag_pre3
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "upd tmp1"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               EXIT DIALOG
            END IF
            LET g_upd_cnt = g_upd_cnt + 1
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            LET l_sql = " UPDATE artp741_tmp1 ",
                        "    SET tmp1_flag = 'N' ",
                        "  WHERE tmp1_debsent = ",g_enterprise," ",
                        "    AND tmp1_debssite = '",g_detail_d[l_ac].rtdxsite_1,"' ",
                        "    AND tmp1_debs005 = '",g_detail_d[l_ac].rtax001_1,"' ",
                        "    AND tmp1_debs002 = '",g_detail_d[l_ac].sdate_1,"' "
            PREPARE upd_flag_pre4 FROM l_sql
            EXECUTE upd_flag_pre4
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "upd tmp1"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               EXIT DIALOG
            END IF
            LET g_upd_cnt = g_upd_cnt + 1
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL artp741_filter()
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
            CALL artp741_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL artp741_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION back_step        #上一步
            LET g_action_choice = "back_step"
            LET g_step = g_step - 1
            #設定左方的流程圖  
            CALL artp741_set_step_img(g_step)
            CALL artp741_set_vbox_visible(g_step)
            CALL artp741_set_act_visible(g_step) 
            CASE g_step
               WHEN 1 
                  CALL DIALOG.setActionActive("selall", FALSE)
                  CALL DIALOG.setActionActive("selnone", FALSE)
                  CALL DIALOG.setActionActive("sel", FALSE)
                  CALL DIALOG.setActionActive("unsel", FALSE)
                  CALL artp741_b_fill()                  
               WHEN 2
                  CALL DIALOG.setActionActive("selall", TRUE)
                  CALL DIALOG.setActionActive("selnone", TRUE)
                  CALL DIALOG.setActionActive("sel", TRUE)
                  CALL DIALOG.setActionActive("unsel", TRUE)
                  CALL artp741_b_fill()
               WHEN 3
                  CALL DIALOG.setActionActive("selall", FALSE)
                  CALL DIALOG.setActionActive("selnone", FALSE)
                  CALL DIALOG.setActionActive("sel", FALSE)
                  CALL DIALOG.setActionActive("unsel", FALSE)
                  LET g_upd_cnt = 0
                  CALL artp741_b_fill2()
               WHEN 4
                  CALL DIALOG.setActionActive("selall", FALSE)
                  CALL DIALOG.setActionActive("selnone", FALSE)
                  CALL DIALOG.setActionActive("sel", FALSE)
                  CALL DIALOG.setActionActive("unsel", FALSE)
                  CALL artp741_b_fill3()
            END CASE
         
         ON ACTION next_step        #下一步
            LET g_action_choice="next_step"
            LET g_step = g_step + 1
            #設定左方的流程圖
            CALL artp741_set_step_img(g_step)
            CALL artp741_set_vbox_visible(g_step)
            CALL artp741_set_act_visible(g_step)
            CASE g_step
               WHEN 2
                  CALL DIALOG.setActionActive("selall", TRUE)
                  CALL DIALOG.setActionActive("selnone", TRUE)
                  CALL DIALOG.setActionActive("sel", TRUE)
                  CALL DIALOG.setActionActive("unsel", TRUE)
                  IF g_method = '1' AND (cl_null(g_wc) OR g_wc = " 1=1") THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code = "art-00455"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_step = g_step-1
                     CALL DIALOG.setActionActive("selall", FALSE)
                     CALL DIALOG.setActionActive("selnone", FALSE)
                     CALL DIALOG.setActionActive("sel", FALSE)
                     CALL DIALOG.setActionActive("unsel", FALSE)
                     CALL artp741_set_step_img(g_step)
                     CALL artp741_set_vbox_visible(g_step)
                     CALL artp741_set_act_visible(g_step)
                     NEXT FIELD rtdxsite
                  END IF
                  LET r_success = TRUE
                  IF artp741_chk_exist(g_step) THEN
                     IF cl_ask_confirm('art-00453') THEN
                        CALL artp741_ins_tmp1() RETURNING r_success
#                        IF NOT r_success THEN
#                           EXIT DIALOG                       
#                        END IF
                     END IF
                  ELSE
                     CALL artp741_ins_tmp1() RETURNING r_success
#                     IF NOT r_success THEN
#                        EXIT DIALOG                       
#                     END IF
                  END IF
                  IF NOT r_success THEN
                     LET g_step = g_step-1
                     DELETE FROM artp741_tmp1
                     CALL DIALOG.setActionActive("selall", FALSE)
                     CALL DIALOG.setActionActive("selnone", FALSE)
                     CALL DIALOG.setActionActive("sel", FALSE)
                     CALL DIALOG.setActionActive("unsel", FALSE)
                     CALL artp741_set_step_img(g_step)
                     CALL artp741_set_vbox_visible(g_step)
                     CALL artp741_set_act_visible(g_step)
                     CONTINUE DIALOG
                  END IF
                  CALL artp741_b_fill()
               WHEN 3
                  CALL DIALOG.setActionActive("selall", FALSE)
                  CALL DIALOG.setActionActive("selnone", FALSE)
                  CALL DIALOG.setActionActive("sel", FALSE)
                  CALL DIALOG.setActionActive("unsel", FALSE)
                  CALL artp741_b_fill2()
               WHEN 4
                  CALL DIALOG.setActionActive("selall", FALSE)
                  CALL DIALOG.setActionActive("selnone", FALSE)
                  CALL DIALOG.setActionActive("sel", FALSE)
                  CALL DIALOG.setActionActive("unsel", FALSE)
                  LET r_success = TRUE
                  IF artp741_chk_exist(g_step) THEN
                     IF cl_ask_confirm('art-00454') THEN
                        CALL s_artp741_ins_tmp(g_deba041) RETURNING r_success
#                        IF NOT r_success THEN
#                           EXIT DIALOG                       
#                        END IF
                     END IF
                  ELSE
                     CALL s_artp741_ins_tmp(g_deba041) RETURNING r_success
#                     IF NOT r_success THEN
#                        EXIT DIALOG                       
#                     END IF
                  END IF
                  IF NOT r_success THEN
                     LET g_step = g_step-1
                     DELETE FROM artp741_tmp2
                     DELETE FROM artp741_tmp3
                     DELETE FROM artp741_tmp4
                     CALL artp741_set_step_img(g_step)
                     CALL artp741_set_vbox_visible(g_step)
                     CALL artp741_set_act_visible(g_step)
                     CONTINUE DIALOG
                  END IF
                  CALL artp741_b_fill3()
                  NEXT FIELD rtkh001
               WHEN 5
                  #判斷欄位是否有輸入
                  IF cl_null(g_rtkh001) OR cl_null(g_rtkh002) OR cl_null(g_rtkh005)
                     OR cl_null(g_point1) OR cl_null(g_point2) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code = "art-00456"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_step = g_step-1
                     CALL artp741_set_step_img(g_step)
                     CALL artp741_set_vbox_visible(g_step)
                     CALL artp741_set_act_visible(g_step)
                     NEXT FIELD rtkh001
                  END IF
                  CALL DIALOG.setActionActive("selall", FALSE)
                  CALL DIALOG.setActionActive("selnone", FALSE)
                  CALL DIALOG.setActionActive("sel", FALSE)
                  CALL DIALOG.setActionActive("unsel", FALSE)
                  CALL s_transaction_begin()
                  CALL s_artp741_ins_rtkh(g_rtkh001,g_rtkh002,g_rtkh005,g_point1,g_point2) RETURNING r_success
                  IF NOT r_success THEN
                     CALL s_transaction_end('N','0')
                     LET g_step = g_step-1
                     CALL artp741_set_step_img(g_step)
                     CALL artp741_set_vbox_visible(g_step)
                     CALL artp741_set_act_visible(g_step)
                     CONTINUE DIALOG
                  END IF
                  CALL s_transaction_end('Y','0')
                  CALL artp741_b_fill3()
            END CASE
            
         ON ACTION init_step
            LET g_step = 1
            LET g_wc = ''
            CALL g_detail_d.clear()
            DELETE FROM artp741_tmp1
            DELETE FROM artp741_tmp2
            DELETE FROM artp741_tmp3
            DELETE FROM artp741_tmp4
            CALL DIALOG.setActionActive("selall", FALSE)
            CALL DIALOG.setActionActive("selnone", FALSE)
            CALL DIALOG.setActionActive("sel", FALSE)
            CALL DIALOG.setActionActive("unsel", FALSE)
            #設定左方的流程圖 
            CALL artp741_set_step_img(g_step)
            CALL artp741_set_vbox_visible(g_step)
            CALL artp741_set_act_visible(g_step)
            
         ON ACTION step01
            #此action是為了讓button的圖片有顏色 
            #EXIT DIALOG
            
         ON ACTION step02
            #此action是為了讓button的圖片有顏色 
            #EXIT DIALOG
            
         ON ACTION step03
            #此action是為了讓button的圖片有顏色 
            #EXIT DIALOG
            
         ON ACTION step04
            #此action是為了讓button的圖片有顏色 
            #EXIT DIALOG
            
         ON ACTION step05
            #此action是為了讓button的圖片有顏色 
            #EXIT DIALOG
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
 
{<section id="artp741.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION artp741_query()
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
   CALL artp741_b_fill()
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
 
{<section id="artp741.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION artp741_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_sdate         LIKE debs_t.debs002
   DEFINE l_edate         LIKE debs_t.debs002
   DEFINE l_sql           STRING
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_sql = " SELECT tmp1_flag,tmp1_debssite,'',tmp1_debs005,'',tmp1_amt1,tmp1_debs002, ",
               "        tmp1_amt2,tmp1_amt3,tmp1_amt4,tmp1_amt5 ",
               "   FROM artp741_tmp1 ",
               "  WHERE tmp1_debsent = ? ",
               "  ORDER BY tmp1_debssite,tmp1_debs005,tmp1_debs002 "
   #end add-point
 
   PREPARE artp741_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR artp741_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
      g_detail_d[l_ac].sel,g_detail_d[l_ac].rtdxsite_1,g_detail_d[l_ac].rtdxsite_1_desc,
      g_detail_d[l_ac].rtax001_1,g_detail_d[l_ac].rtax001_1_desc,g_detail_d[l_ac].amt1_1,
      g_detail_d[l_ac].sdate_1,g_detail_d[l_ac].amt2_1,g_detail_d[l_ac].amt3_1,
      g_detail_d[l_ac].amt4_1,g_detail_d[l_ac].amt5_1
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
#      #計算此品類的商品個數
#      SELECT COUNT(DISTINCT deba009) INTO g_detail_d[l_ac].amt1_1
#        FROM deba_t,imaa_t
#       WHERE debaent = g_enterprise
#         AND debaent = imaaent
#         AND deba009 = imaa001
#         AND debasite = g_detail_d[l_ac].rtdxsite_1
#         AND imaa009 = g_detail_d[l_ac].rtax001_1
#         AND deba002 = g_detail_d[l_ac].sdate_1
#         AND deba021 > 0
#      #計算此品類促銷商品個數
#      SELECT COUNT(DISTINCT deba009) INTO g_detail_d[l_ac].amt3_1
#        FROM deba_t,imaa_t
#       WHERE debaent = g_enterprise
#         AND debaent = imaaent
#         AND deba009 = imaa001
#         AND debasite = g_detail_d[l_ac].rtdxsite_1
#         AND imaa009 = g_detail_d[l_ac].rtax001_1
#         AND deba002 = g_detail_d[l_ac].sdate_1
#         AND deba021 > 0
#         AND deba030 > 0
      #計算收貨數量(暫定為0)
      
      
      #end add-point
      
      CALL artp741_detail_show()      
 
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
   FREE artp741_sel
   
   LET l_ac = 1
   CALL artp741_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="artp741.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION artp741_fetch()
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
 
{<section id="artp741.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION artp741_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_d[l_ac].rtdxsite_1
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_detail_d[l_ac].rtdxsite_1_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_detail_d[l_ac].rtdxsite_1_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_d[l_ac].rtax001_1
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_detail_d[l_ac].rtax001_1_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_detail_d[l_ac].rtax001_1_desc
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="artp741.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION artp741_filter()
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
   
   CALL artp741_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="artp741.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION artp741_filter_parser(ps_field)
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
 
{<section id="artp741.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION artp741_filter_show(ps_field,ps_object)
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
   LET ls_condition = artp741_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="artp741.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 設定左方流程圖片
# Memo...........:
# Usage..........: CALL artp741_set_step_img(p_step)
# Input parameter: p_step：第幾步驟的圖
# Date & Author..: 2015/01/20 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp741_set_step_img(p_step)
DEFINE p_step     LIKE type_t.num5 
      
   CALL gfrm_curr.setElementImage("step01","32/step01.png") 
   CALL gfrm_curr.setElementImage("step02","32/step02.png") 
   CALL gfrm_curr.setElementImage("step03","32/step03.png")
   CALL gfrm_curr.setElementImage("step04","32/step04.png")
   CALL gfrm_curr.setElementImage("step05","32/step05.png")
   CALL gfrm_curr.setElementStyle("step01","menuitem")
   CALL gfrm_curr.setElementStyle("step02","menuitem")
   CALL gfrm_curr.setElementStyle("step03","menuitem")
   CALL gfrm_curr.setElementStyle("step04","menuitem")
   CALL gfrm_curr.setElementStyle("step05","menuitem")
   
   CASE p_step 
      WHEN 1 
         CALL gfrm_curr.setElementImage("step01","32/step01on.png")   #有on的是顏色不同的圖
         CALL gfrm_curr.setElementStyle("step01","menuitemfocus")     #有focus是顏色不同的字體
      WHEN 2 
         CALL gfrm_curr.setElementImage("step02","32/step02on.png")   #有on的是顏色不同的圖
         CALL gfrm_curr.setElementStyle("step02","menuitemfocus")     #有focus是顏色不同的字體
      WHEN 3 
         CALL gfrm_curr.setElementImage("step03","32/step03on.png")   #有on的是顏色不同的圖
         CALL gfrm_curr.setElementStyle("step03","menuitemfocus")     #有focus是顏色不同的字體
      WHEN 4 
         CALL gfrm_curr.setElementImage("step04","32/step04on.png")   #有on的是顏色不同的圖
         CALL gfrm_curr.setElementStyle("step04","menuitemfocus")     #有focus是顏色不同的字體
      WHEN 5 
         CALL gfrm_curr.setElementImage("step05","32/step05on.png")   #有on的是顏色不同的圖
         CALL gfrm_curr.setElementStyle("step05","menuitemfocus")     #有focus是顏色不同的字體
   END CASE 
END FUNCTION

################################################################################
# Descriptions...: 設定各步驟的action顯示
# Memo...........:
# Usage..........: CALL artp741_set_act_visible(p_step)
# Input parameter: p_step：步驟
# Date & Author..: 2015/01/20 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp741_set_act_visible(p_step)
DEFINE p_step     LIKE type_t.num5 
   
   #設定下方的button的 顯示 與 隱藏 
   CALL cl_set_comp_visible("back_step",FALSE)         #上一步  
   CALL cl_set_comp_visible("next_step",FALSE)         #下一步 
   CALL cl_set_comp_visible("init_step",FALSE)         #重新初始化 
                                                       
   CASE p_step                                         
      WHEN 1                                           
         CALL cl_set_comp_visible("next_step",TRUE)    #下一步
      WHEN 2                                           
         CALL cl_set_comp_visible("back_step",TRUE)    #上一步 
         CALL cl_set_comp_visible("next_step",TRUE)    #下一步
      WHEN 3                                           
         CALL cl_set_comp_visible("back_step",TRUE)    #上一步 
         CALL cl_set_comp_visible("next_step",TRUE)    #下一步
      WHEN 4                                           
         CALL cl_set_comp_visible("back_step",TRUE)    #上一步 
         CALL cl_set_comp_visible("next_step",TRUE)    #下一步
      WHEN 5 
         CALL cl_set_comp_visible("init_step",TRUE)    #重新初始化
   END CASE 
END FUNCTION

################################################################################
# Descriptions...: 設定每一步的畫面顯示與隱藏
# Memo...........:
# Usage..........: CALL artp741_set_vbox_visible(p_step)
# Input parameter: p_step：步驟
# Date & Author..: 2015/01/21 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp741_set_vbox_visible(p_step)
DEFINE p_step     LIKE type_t.num5 
   
   #設定嵌入畫面的 顯示 與 隱藏     
   CALL cl_set_comp_visible("vbox_qbe",FALSE)
   CALL cl_set_comp_visible("vbox_input",FALSE)
   CALL cl_set_comp_visible("vbox_detail1",FALSE)
   CALL cl_set_comp_visible("vbox_detail2",FALSE)
   CALL cl_set_comp_visible("vbox_detail3",FALSE)
   
   CASE p_step 
      WHEN 1  
         CALL cl_set_comp_visible("vbox_qbe",TRUE)
         CALL cl_set_comp_visible("vbox_detail1",TRUE)
      WHEN 2
         CALL cl_set_comp_visible("vbox_detail1",TRUE)
      WHEN 3
         CALL cl_set_comp_visible("vbox_detail2",TRUE) 
      WHEN 4 
         CALL cl_set_comp_visible("vbox_input",TRUE)
         CALL cl_set_comp_visible("vbox_detail3",TRUE)
      WHEN 5
         CALL cl_set_comp_visible("vbox_detail3",TRUE)  
   END CASE 
END FUNCTION

################################################################################
# Descriptions...: 顯示待計算數據
# Memo...........:
# Usage..........: CALL artp741_b_fill2()
# Date & Author..: 20150121 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp741_b_fill2()
DEFINE li_idx   LIKE type_t.num5
DEFINE l_sql    STRING

   CALL g_detail2_d.clear()
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   
   LET l_sql = " SELECT tmp1_flag,tmp1_debssite,'',tmp1_debs005,'',tmp1_amt1,tmp1_debs002, ",
               "        tmp1_amt2,tmp1_amt3,tmp1_amt4,tmp1_amt5 ",
               "   FROM artp741_tmp1 ",
               "  WHERE tmp1_debsent = ",g_enterprise," ",
               "    AND tmp1_flag = 'Y' ",
               "  ORDER BY tmp1_debssite,tmp1_debs005,tmp1_debs002 "
   PREPARE sel_tmp1_pre FROM l_sql
   DECLARE sel_tmp1_cs  CURSOR FOR sel_tmp1_pre
   FOREACH sel_tmp1_cs  INTO 
      g_detail2_d[l_ac].sel2,g_detail2_d[l_ac].rtdxsite_2,g_detail2_d[l_ac].rtdxsite_2_desc,
      g_detail2_d[l_ac].rtax001_2,g_detail2_d[l_ac].rtax001_2_desc,g_detail2_d[l_ac].amt1_2,
      g_detail2_d[l_ac].sdate_2,g_detail2_d[l_ac].amt2_2,g_detail2_d[l_ac].amt3_2,
      g_detail2_d[l_ac].amt4_2,g_detail2_d[l_ac].amt5_2
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail2_d[l_ac].rtdxsite_2
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail2_d[l_ac].rtdxsite_2_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_detail2_d[l_ac].rtdxsite_2_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail2_d[l_ac].rtax001_2
      CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail2_d[l_ac].rtax001_2_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_detail2_d[l_ac].rtax001_2_desc
      
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
   
#   FOR li_idx = 1 TO g_detail_d.getLength()
#      IF g_detail_d[li_idx].sel = "Y" THEN
#         LET l_sql = " UPDATE artp741_tmp1 ",
#                     "    SET tmp1_flag = 'Y' ",
#                     "  WHERE tmp1_debssite = '",g_detail_d[li_idx].rtdxsite_1,"' ",
#                     "    AND tmp1_debs005 = '",g_detail_d[li_idx].rtax001_1,"' ",
#                     "    AND tmp1_debs002 = '",g_detail_d[li_idx].sdate_1,"' "
#         PREPARE upd_tmp1_pre3 FROM l_sql
#         EXECUTE upd_tmp1_pre3
#         IF SQLCA.sqlcode THEN
#            INITIALIZE g_errparam TO NULL 
#            LET g_errparam.extend = "upd tmp1" 
#            LET g_errparam.code   = SQLCA.sqlcode
#            LET g_errparam.popup  = TRUE 
#            CALL cl_err()
#            EXIT FOR
#         END IF
#         
#         LET g_detail2_d[l_ac].sel2 = g_detail_d[li_idx].sel
#         LET g_detail2_d[l_ac].rtdxsite_2 = g_detail_d[li_idx].rtdxsite_1
#         LET g_detail2_d[l_ac].rtdxsite_2_desc = g_detail_d[li_idx].rtdxsite_1_desc
#         LET g_detail2_d[l_ac].rtax001_2 = g_detail_d[li_idx].rtax001_1
#         LET g_detail2_d[l_ac].rtax001_2_desc = g_detail_d[li_idx].rtax001_1_desc
#         LET g_detail2_d[l_ac].amt1_2 = g_detail_d[li_idx].amt1_1
#         LET g_detail2_d[l_ac].sdate_2 = g_detail_d[li_idx].sdate_1
#         LET g_detail2_d[l_ac].amt2_2 = g_detail_d[li_idx].amt2_1
#         LET g_detail2_d[l_ac].amt3_2 = g_detail_d[li_idx].amt3_1
#         LET g_detail2_d[l_ac].amt4_2 = g_detail_d[li_idx].amt4_1
#         LET g_detail2_d[l_ac].amt5_2 = g_detail_d[li_idx].amt5_1
#         
#         LET l_ac = l_ac + 1
#         IF l_ac > g_max_rec THEN
#            IF g_error_show = 1 THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend =  "" 
#               LET g_errparam.code   =  9035 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
#            END IF
#            EXIT FOR
#         END IF
#      END IF
#   END FOR
   LET g_error_show = 0
   
   CALL g_detail2_d.deleteElement(l_ac)
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   LET l_ac = 1
   CALL artp741_fetch()
   
END FUNCTION

################################################################################
# Descriptions...: 顯示門店參數默認頁簽
# Memo...........:
# Usage..........: CALL artp741_b_fill3()
# Date & Author..: 20150121 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp741_b_fill3()
DEFINE l_sql   STRING

   CALL g_detail3_d.clear()
 
   LET g_cnt = l_ac
   LET l_ac = 1
   
   LET l_sql = " SELECT tmp2_rtki002,'',tmp2_rtki003,tmp2_rtki004, ",
               "        tmp2_rtki005,tmp2_rtki006,tmp2_rtki007 ",
               "   FROM artp741_tmp2 ",
               "  ORDER BY tmp2_rtki002 "
   PREPARE sel_tmp2_pre FROM l_sql
   DECLARE sel_tmp2_cs  CURSOR FOR sel_tmp2_pre
   FOREACH sel_tmp2_cs  INTO g_detail3_d[l_ac].rtki002,g_detail3_d[l_ac].rtki002_desc,g_detail3_d[l_ac].rtki003,g_detail3_d[l_ac].rtki004,
                             g_detail3_d[l_ac].rtki005,g_detail3_d[l_ac].rtki006,g_detail3_d[l_ac].rtki007
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail3_d[l_ac].rtki002
      CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail3_d[l_ac].rtki002_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_detail3_d[l_ac].rtki002_desc
      
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
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   LET l_ac = 1
   CALL artp741_fetch()
   
   CALL artp741_b_fill4()
   CALL artp741_b_fill5()
END FUNCTION

################################################################################
# Descriptions...: 顯示品類週參數頁簽
# Memo...........:
# Usage..........: CALL artp741_b_fill4()
# Date & Author..: 20150127 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp741_b_fill4()
DEFINE l_sql   STRING

   CALL g_detail4_d.clear()
 
   LET g_cnt = l_ac
   LET l_ac = 1
   
   LET l_sql = " SELECT tmp3_rtkj002,'',tmp3_rtkj101,tmp3_rtkj102, ",
               "        tmp3_rtkj103,tmp3_rtkj104,tmp3_rtkj105,tmp3_rtkj106, ",      
               "        tmp3_rtkj107,tmp3_rtkj108,tmp3_rtkj109,tmp3_rtkj110, ",
               "        tmp3_rtkj111,tmp3_rtkj112,tmp3_rtkj113,tmp3_rtkj114, ",
               "        tmp3_rtkj115,tmp3_rtkj116,tmp3_rtkj117,tmp3_rtkj118, ",
               "        tmp3_rtkj119,tmp3_rtkj120,tmp3_rtkj121,tmp3_rtkj122, ",
               "        tmp3_rtkj123,tmp3_rtkj124,tmp3_rtkj125,tmp3_rtkj126, ",
               "        tmp3_rtkj127,tmp3_rtkj128,tmp3_rtkj129,tmp3_rtkj130, ",
               "        tmp3_rtkj131,tmp3_rtkj132,tmp3_rtkj133,tmp3_rtkj134, ",
               "        tmp3_rtkj135,tmp3_rtkj136,tmp3_rtkj137,tmp3_rtkj138, ",
               "        tmp3_rtkj139,tmp3_rtkj140,tmp3_rtkj141,tmp3_rtkj142, ",
               "        tmp3_rtkj143,tmp3_rtkj144,tmp3_rtkj145,tmp3_rtkj146, ",
               "        tmp3_rtkj147,tmp3_rtkj148,tmp3_rtkj149,tmp3_rtkj150, ",
               "        tmp3_rtkj151,tmp3_rtkj152 ",
               "   FROM artp741_tmp3 ",
               "  ORDER BY tmp3_rtkj002 "
   PREPARE sel_tmp3_pre FROM l_sql
   DECLARE sel_tmp3_cs  CURSOR FOR sel_tmp3_pre
   FOREACH sel_tmp3_cs  INTO g_detail4_d[l_ac].rtkj002,g_detail4_d[l_ac].rtkj002_desc,g_detail4_d[l_ac].rtkj101,g_detail4_d[l_ac].rtkj102,
                             g_detail4_d[l_ac].rtkj103,g_detail4_d[l_ac].rtkj104,g_detail4_d[l_ac].rtkj105,g_detail4_d[l_ac].rtkj106,
                             g_detail4_d[l_ac].rtkj107,g_detail4_d[l_ac].rtkj108,g_detail4_d[l_ac].rtkj109,g_detail4_d[l_ac].rtkj110,
                             g_detail4_d[l_ac].rtkj111,g_detail4_d[l_ac].rtkj112,g_detail4_d[l_ac].rtkj113,g_detail4_d[l_ac].rtkj114,
                             g_detail4_d[l_ac].rtkj115,g_detail4_d[l_ac].rtkj116,g_detail4_d[l_ac].rtkj117,g_detail4_d[l_ac].rtkj118,
                             g_detail4_d[l_ac].rtkj119,g_detail4_d[l_ac].rtkj120,g_detail4_d[l_ac].rtkj121,g_detail4_d[l_ac].rtkj122,
                             g_detail4_d[l_ac].rtkj123,g_detail4_d[l_ac].rtkj124,g_detail4_d[l_ac].rtkj125,g_detail4_d[l_ac].rtkj126,
                             g_detail4_d[l_ac].rtkj127,g_detail4_d[l_ac].rtkj128,g_detail4_d[l_ac].rtkj129,g_detail4_d[l_ac].rtkj130,
                             g_detail4_d[l_ac].rtkj131,g_detail4_d[l_ac].rtkj132,g_detail4_d[l_ac].rtkj133,g_detail4_d[l_ac].rtkj134,
                             g_detail4_d[l_ac].rtkj135,g_detail4_d[l_ac].rtkj136,g_detail4_d[l_ac].rtkj137,g_detail4_d[l_ac].rtkj138,
                             g_detail4_d[l_ac].rtkj139,g_detail4_d[l_ac].rtkj140,g_detail4_d[l_ac].rtkj141,g_detail4_d[l_ac].rtkj142,
                             g_detail4_d[l_ac].rtkj143,g_detail4_d[l_ac].rtkj144,g_detail4_d[l_ac].rtkj145,g_detail4_d[l_ac].rtkj146,
                             g_detail4_d[l_ac].rtkj147,g_detail4_d[l_ac].rtkj148,g_detail4_d[l_ac].rtkj149,g_detail4_d[l_ac].rtkj150,
                             g_detail4_d[l_ac].rtkj151,g_detail4_d[l_ac].rtkj152
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail4_d[l_ac].rtkj002
      CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail4_d[l_ac].rtkj002_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_detail4_d[l_ac].rtkj002_desc
      
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
   
   CALL g_detail4_d.deleteElement(l_ac)
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   LET l_ac = 1
   CALL artp741_fetch()

END FUNCTION

################################################################################
# Descriptions...: 顯示品類日參數頁簽
# Memo...........:
# Usage..........: CALL artp741_b_fill5()
# Date & Author..: 20150127 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp741_b_fill5()
DEFINE l_sql   STRING

   CALL g_detail5_d.clear()
 
   LET g_cnt = l_ac
   LET l_ac = 1
   
   LET l_sql = " SELECT tmp4_rtkl002,'',tmp4_rtkl101,tmp4_rtkl102,tmp4_rtkl103,tmp4_rtkl104, ",
               "        tmp4_rtkl105,tmp4_rtkl106,tmp4_rtkl107 ",
               "   FROM artp741_tmp4 ",
               "  ORDER BY tmp4_rtkl002 "
   PREPARE sel_tmp4_pre FROM l_sql
   DECLARE sel_tmp4_cs  CURSOR FOR sel_tmp4_pre
   FOREACH sel_tmp4_cs  INTO g_detail5_d[l_ac].rtkl002,g_detail5_d[l_ac].rtkl002_desc,g_detail5_d[l_ac].rtkl101,
                             g_detail5_d[l_ac].rtkl102,g_detail5_d[l_ac].rtkl103,g_detail5_d[l_ac].rtkl104,
                             g_detail5_d[l_ac].rtkl105,g_detail5_d[l_ac].rtkl106,g_detail5_d[l_ac].rtkl107
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail5_d[l_ac].rtkl002
      CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail5_d[l_ac].rtkl002_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_detail5_d[l_ac].rtkl002_desc
      
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
   
   CALL g_detail5_d.deleteElement(l_ac)
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   LET l_ac = 1
   CALL artp741_fetch()

END FUNCTION

################################################################################
# Descriptions...: 由補貨模型帶出DMS公式和補貨公式
# Memo...........:
# Usage..........: CALL artp741_rtkh001_ref()
# Date & Author..: 20150127 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp741_rtkh001_ref()

   SELECT rtkh002,rtkh005 INTO g_rtkh002,g_rtkh005
     FROM rtkh_t
    WHERE rtkhent = g_enterprise
      AND rtkh001 = g_rtkh001
   DISPLAY g_rtkh002,g_rtkh005 TO rtkh002,rtkh005

END FUNCTION

################################################################################
# Descriptions...: 開啟欄位
# Memo...........:
# Usage..........: CALL artp741_set_entry()
# Date & Author..: 20150127 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp741_set_entry()

   CALL cl_set_comp_entry("rtkh002,rtkh005",TRUE)

END FUNCTION

################################################################################
# Descriptions...: 關閉欄位
# Memo...........:
# Usage..........: CALL artp741_set_no_entry()
# Date & Author..: 20150127 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp741_set_no_entry()
DEFINE l_n      LIKE type_t.num5
   
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM rtkh_t
    WHERE rtkhent = g_enterprise
      AND rtkh001 = g_rtkh001
   IF l_n > 0 THEN
      CALL cl_set_comp_entry("rtkh002,rtkh005",FALSE)
   END IF

END FUNCTION

################################################################################
# Descriptions...: 抓取數據插入到歷史數據頁簽臨時表
# Memo...........:
# Usage..........: CALL artp741_ins_tmp1()
# Date & Author..: 20150128 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp741_ins_tmp1()
DEFINE l_sdate         LIKE debs_t.debs002
DEFINE l_edate         LIKE debs_t.debs002
DEFINE l_sql           STRING
DEFINE l_msg           LIKE gzze_t.gzze003
DEFINE l_wc_t          STRING
DEFINE l_where         STRING
DEFINE l_sys1          LIKE type_t.chr80

   LET l_wc_t = g_wc
   IF cl_null(g_wc) OR g_wc = "rtdxsite='ALL'" THEN
      LET g_wc = " 1=1"
   END IF
   LET l_where = s_aooi500_q_where(g_prog,'debssite',g_site,'c')   #150308-00001#5  By benson add 'c'
   LET g_wc = g_wc," AND ",l_where
   LET g_wc = cl_replace_str(g_wc,'ooef001','debssite')
   CALL s_date_get_ymtodate(g_deba041,'01',g_deba041,'12')
      RETURNING l_sdate,l_edate
   
   LET g_wc = cl_replace_str(g_wc,'rtdxsite','debssite')
   DELETE FROM artp741_tmp1
   #根據畫面條件抓取數據插入臨時表
   LET l_sql = " INSERT INTO artp741_tmp1 ",
               " SELECT DISTINCT ",g_enterprise,",'Y',debssite,debs005,'',debs002,SUM(debs011),'',SUM(debs020),0,0,0,0,0 ",
               "   FROM debs_t,rtdx_t,imaa_t ",
               "  WHERE rtdxent = debsent ",
               "    AND debsent = imaaent ",
               "    AND debsent = ",g_enterprise," ",
               "    AND rtdx001 = imaa001 ",
               "    AND imaa009 = debs005 ",
               "    AND debssite = rtdxsite ",
               "    AND ",g_wc,
               "    AND debs002 >= '",l_sdate,"' ",
               "    AND debs002 <= '",l_edate,"' ",
               "    AND imaa125 <> 'Y' ",
               "  GROUP BY ",g_enterprise,",'N',debssite,debs005,debs002 ",
               "  ORDER BY debssite,debs005,debs002 "
   PREPARE ins_tmp1_pre FROM l_sql
   LET l_msg = cl_getmsg('art-00431',g_dlang)
   EXECUTE ins_tmp1_pre
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "ins tmp1",l_msg
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE
   END IF
   
   #計算採購入庫數量
   LET l_sql = " UPDATE artp741_tmp1 SET tmp1_amt51 = COALESCE(( ",
               " SELECT COALESCE(SUM(pmdt020),0) FROM pmdt_t,pmds_t,imaa_t ",
               "  WHERE pmdtent = pmdsent AND pmdtdocno = pmdsdocno AND pmdtent = imaaent ",
               "    AND pmds000 IN ('3','4','6') ",
               "    AND pmdsstus = 'S' AND pmdssite = tmp1_debssite AND pmds001 = tmp1_debs002 ",
               "    AND pmdt006 = imaa001 AND imaa009 = tmp1_debs005 AND imaa125 <> 'Y'),0) "
   PREPARE upd_tmp1_pre3 FROM l_sql
   LET l_msg = cl_getmsg('art-00499',g_dlang)
   EXECUTE upd_tmp1_pre3
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "upd tmp1",l_msg
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE
   END IF
   
   #計算退場數量
   LET l_sql = " UPDATE artp741_tmp1 SET tmp1_amt52 = COALESCE(( ",
               " SELECT COALESCE(SUM(pmdt020),0) FROM pmdt_t,pmds_t,imaa_t ",
               "  WHERE pmdtent = pmdsent AND pmdtdocno = pmdsdocno AND pmdtent = imaaent ",
               "    AND pmds000 IN ('7') ",
               "    AND pmdsstus = 'S' AND pmdssite = tmp1_debssite AND pmds001 = tmp1_debs002 ",
               "    AND pmdt006 = imaa001 AND imaa009 = tmp1_debs005 AND imaa125 <> 'Y'),0) "
   PREPARE upd_tmp1_pre4 FROM l_sql
   LET l_msg = cl_getmsg('art-00500',g_dlang)
   EXECUTE upd_tmp1_pre4
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "upd tmp1",l_msg
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE
   END IF
   
   #計算調撥入庫數量
   LET l_sql = " UPDATE artp741_tmp1 SET tmp1_amt53 = COALESCE(( ",
               " SELECT COALESCE(SUM(indd031),0) FROM indd_t,indc_t,imaa_t ",
               "  WHERE inddent = indcent AND indddocno = indcdocno AND inddent = imaaent ",
               "    AND indc000 = '3' AND indcstus IN ('P','C') ",
               "    AND indc005 <> indc006 ",
               "    AND indc006 = tmp1_debssite AND indc024 = tmp1_debs002 ",
               "    AND indd002 = imaa001 AND imaa009 = tmp1_debs005 AND imaa125 <> 'Y'),0) "
   PREPARE upd_tmp1_pre5 FROM l_sql
   LET l_msg = cl_getmsg('art-00501',g_dlang)
   EXECUTE upd_tmp1_pre5
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "upd tmp1",l_msg
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE
   END IF
   
   #計算撥出數量
   LET l_sql = " UPDATE artp741_tmp1 SET tmp1_amt54 = COALESCE(( ",
               " SELECT COALESCE(SUM(indd031),0) FROM indd_t,indc_t,imaa_t ",
               "  WHERE inddent = indcent AND indddocno = indcdocno AND inddent = imaaent ",
               "    AND indcstus IN ('O','P','C') "
   #取參數(組織間調撥是否啓用在途)
   CALL cl_get_para(g_enterprise,g_site,'E-BAS-0013') RETURNING l_sys1
   IF l_sys1 = 'Y' THEN
      LET l_sql = l_sql," AND indc000 = '2' "
   ELSE
      LET l_sql = l_sql," AND indc000 = '1' "
   END IF
   LET l_sql = l_sql," AND indc005 <> indc006 ",
                     " AND indc005 = tmp1_debssite AND indc022 = tmp1_debs002 ",
                     " AND indd002 = imaa001 AND imaa009 = tmp1_debs005 AND imaa125 <> 'Y'),0) "
   PREPARE upd_tmp1_pre6 FROM l_sql
   LET l_msg = cl_getmsg('art-00502',g_dlang)
   EXECUTE upd_tmp1_pre6
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "upd tmp1",l_msg
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE
   END IF
   
   #更新收貨數量
   LET l_sql = " UPDATE artp741_tmp1 ",
               "    SET tmp1_amt5 = (tmp1_amt51-tmp1_amt52+tmp1_amt53-tmp1_amt54) ",
               "  WHERE tmp1_debsent = ",g_enterprise," "
   PREPARE upd_tmp1_pre7 FROM l_sql
   LET l_msg = cl_getmsg('art-00503',g_dlang)
   EXECUTE upd_tmp1_pre7
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "upd tmp1",l_msg
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE
   END IF
   
   #計算品類對應的商品個數
   LET l_sql = " UPDATE artp741_tmp1 SET tmp1_amt1 = ( ",
               "    SELECT COUNT(DISTINCT deba009) ",
               "      FROM deba_t,imaa_t ",
               "     WHERE debaent = ",g_enterprise," ",
               "       AND debaent = imaaent ",
               "       AND deba009 = imaa001 ",
               "       AND debasite = tmp1_debssite ",
               "       AND imaa009 = tmp1_debs005 ",
               "       AND deba002 = tmp1_debs002 ",
               "       AND imaa125 <> 'Y' ",
               "       AND deba021 > 0) "
   PREPARE upd_tmp1_pre1 FROM l_sql
   LET l_msg = cl_getmsg('art-00471',g_dlang)
   EXECUTE upd_tmp1_pre1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "upd tmp1",l_msg
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE
   END IF
   
   #計算品類對應的促銷商品個數
   LET l_sql = " UPDATE artp741_tmp1 SET tmp1_amt3 = ( ",
               "    SELECT COUNT(DISTINCT deba009) ",
               "      FROM deba_t,imaa_t ",
               "     WHERE debaent = ",g_enterprise," ",
               "       AND debaent = imaaent ",
               "       AND deba009 = imaa001 ",
               "       AND debasite = tmp1_debssite ",
               "       AND imaa009 = tmp1_debs005 ",
               "       AND deba002 = tmp1_debs002 ",
               "       AND imaa125 <> 'Y' ",
               "       AND deba021 > 0 ",
               "       AND deba030 > 0) "
   PREPARE upd_tmp1_pre2 FROM l_sql
   LET l_msg = cl_getmsg('art-00472',g_dlang)
   EXECUTE upd_tmp1_pre2
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "upd tmp1",l_msg
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE
   END IF

   LET g_wc = l_wc_t

   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 系統提取或者文件提取對應欄位顯示
# Memo...........:
# Usage..........: CALL artp741_set_comp_visible()
# Date & Author..: 20150129 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp741_set_comp_visible()

   CALL cl_set_comp_visible("rtdxsite",FALSE)
   CALL cl_set_comp_visible("deba041",FALSE)
   CALL cl_set_comp_visible("path",FALSE)
   CALL cl_set_comp_visible("type",FALSE)
   CALL cl_set_comp_visible("sign",FALSE)
   
   IF g_method = '1' THEN
      CALL cl_set_comp_visible("rtdxsite",TRUE)
      CALL cl_set_comp_visible("deba041",TRUE)
   ELSE
      CALL cl_set_comp_visible("path",TRUE)
      CALL cl_set_comp_visible("type",TRUE)
      CALL cl_set_comp_visible("sign",TRUE)
   END IF

END FUNCTION

################################################################################
# Descriptions...: 判斷是否存在資料
# Memo...........:
# Usage..........: CALL artp741_chk_exist(p_step)
#                  RETURNING r_success
# Input parameter: p_step   步驟
# Date & Author..: 20150129 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp741_chk_exist(p_step)
DEFINE p_step       LIKE type_t.num5
DEFINE l_n          LIKE type_t.num5
DEFINE l_sql        STRING

   CASE p_step
      WHEN 2
         LET l_sql = " SELECT COUNT(*) FROM artp741_tmp1 "
         PREPARE sel_tmp1_pre1 FROM l_sql
         EXECUTE sel_tmp1_pre1 INTO l_n
         IF l_n > 0 THEN
            RETURN TRUE
         END IF
         
      WHEN 4
         LET l_sql = " SELECT COUNT(*) FROM artp741_tmp2 "
         PREPARE sel_tmp2_pre1 FROM l_sql
         EXECUTE sel_tmp2_pre1 INTO l_n
         IF l_n > 0 AND g_upd_cnt > 0 THEN
            RETURN TRUE
         END IF
   END CASE
   
   RETURN FALSE
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION artp741_rtkh001_chk()
DEFINE l_n      LIKE type_t.num5

   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM rtkh_t
    WHERE rtkhent = g_enterprise
      AND rtkh001 = g_rtkh001
   IF l_n > 0 THEN
      RETURN TRUE   
   END IF

   RETURN FALSE
END FUNCTION

#end add-point
 
{</section>}
 
