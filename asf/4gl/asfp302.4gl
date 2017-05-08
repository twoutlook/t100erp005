#該程式未解開Section, 採用最新樣板產出!
{<section id="asfp302.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2015-12-18 15:33:07), PR版次:0008(2016-12-20 12:07:35)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000155
#+ Filename...: asfp302
#+ Description: RUNCARD拆分合併作業
#+ Creator....: 00768(2014-04-28 15:33:33)
#+ Modifier...: 04441 -SD/PR- 00768
 
{</section>}
 
{<section id="asfp302.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160825-00059#1  2016/08/29 By wuxja     1、新增sfcc、sfcd表资料，  2、还原150625-00005
#161109-00085#38 2016/11/17 By lienjunqi 整批調整系統星號寫法
#161109-00085#61 2016/11/29 By 08171     整批調整系統星號寫法
#161126-00005#1  2016/12/19 By 00768     上下站标准转出量sfcb027更新
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
                     sel                LIKE type_t.chr1,
                     b_sfcadocno        LIKE sfca_t.sfcadocno,
                     ismain             LIKE type_t.chr1,
                     b_sfca001          LIKE sfca_t.sfca001,
                     b_sfaa010          LIKE sfaa_t.sfaa010,
                     b_sfaa010_desc     LIKE imaal_t.imaal003,
                     b_sfaa010_desc_1   LIKE imaal_t.imaal004,
                     b_sfaa019          LIKE sfaa_t.sfaa019,
                     b_sfaa020          LIKE sfaa_t.sfaa020,
                     b_sfaa002          LIKE sfaa_t.sfaa002,
                     b_sfaa002_desc     LIKE ooag_t.ooag011,
                     b_sfca003          LIKE sfca_t.sfca003,
                     b_sfca004          LIKE sfca_t.sfca004,
                     b_sfaa016          LIKE sfaa_t.sfaa016,
                     b_sfcb003          LIKE sfcb_t.sfcb003,
                     b_sfcb004          LIKE sfcb_t.sfcb004,  
                     b_sfcb011          LIKE sfcb_t.sfcb011,
                     wip_qty            LIKE sfcb_t.sfcb028,
                     issue_qty          LIKE sfcb_t.sfcb028
                     END RECORD
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
DEFINE g_detail_d_t       type_g_detail_d
DEFINE g_rec_b            LIKE type_t.num5 
#end add-point
 
{</section>}
 
{<section id="asfp302.main" >}
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
   CALL cl_ap_init("asf","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_asfp302 WITH FORM cl_ap_formpath("asf",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL asfp302_init()   
 
      #進入選單 Menu (="N")
      CALL asfp302_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_asfp302
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="asfp302.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION asfp302_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   DEFINE lwin_curr      ui.Window
   DEFINE lfrm_curr      ui.Form
   DEFINE ls_path        STRING

   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
   LET ls_path = os.Path.join(ls_path,"toolbar_q.4tb")
   CALL lfrm_curr.loadToolBar(ls_path)
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="asfp302.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfp302_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_rec_b = g_detail_d.getLength()
   
   CALL asfp302_b_fill()  #进画面先直接显示资料
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL asfp302_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
 
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT ARRAY g_detail_d FROM s_detail1.*
             #ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
             ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         
            BEFORE INPUT
               #CALL asfp310_b_fill_sfaa()
               LET g_rec_b = g_detail_d.getLength()
         
            BEFORE ROW
               #LET l_cmd = ''
               LET l_ac = ARR_CURR()
            
               LET g_rec_b = g_detail_d.getLength()
               #LET l_cmd='u'
               LET g_detail_d_t.* = g_detail_d[l_ac].*  #BACKUP
         
            AFTER FIELD sel
               IF NOT cl_null(g_detail_d[l_ac].sel) THEN
                  IF g_detail_d[l_ac].sel NOT MATCHES '[YN]' THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
         
            AFTER FIELD ismain
               IF NOT cl_null(g_detail_d[l_ac].ismain) THEN
                  IF g_detail_d[l_ac].ismain NOT MATCHES '[YN]' THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            
            AFTER FIELD issue_qty
               IF g_detail_d[l_ac].issue_qty < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00041'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
               
               IF NOT cl_null(g_detail_d[l_ac].issue_qty) AND g_detail_d[l_ac].issue_qty > g_detail_d[l_ac].wip_qty THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00252'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF

            ON ROW CHANGE
               IF INT_FLAG THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 9001
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET INT_FLAG = 0
                  LET g_detail_d[l_ac].* = g_detail_d_t.*
                  NEXT FIELD sel
               END IF
         
         
            AFTER ROW
         
         
            AFTER INPUT
    
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
            #CALL asfp302_sel_all("Y")
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
            #CALL asfp302_sel_all("N")
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
            CALL asfp302_filter()
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
            CALL asfp302_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL asfp302_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL asfp302_query()
               #LET l_ac = ARR_CURR()
            END IF
         
         ON ACTION combine   #合并
            LET g_action_choice="combine"
            IF cl_auth_chk_act("combine") THEN
               CALL asfp302_combine()
            END IF
         
         ON ACTION split     #拆分
            LET g_action_choice="split"
            IF cl_auth_chk_act("split") THEN
               CALL asfp302_split()
            END IF
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
 
{<section id="asfp302.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION asfp302_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_detail_d.clear()
   
   LET g_action_choice = 'c'
   LET ls_wc = g_wc

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      #CONSTRUCT g_wc ON b_sfcadocno,b_sfca001,b_sfaa010,
      #                  b_sfaa019,b_sfaa020,b_sfaa002,
      #                  b_sfca003,b_sfca004,b_sfaa016,
      #                  b_sfcb003,b_sfcb004,b_sfcb011
      CONSTRUCT g_wc ON sfcadocno,sfca001,sfaa010,
                        sfaa019,sfaa020,sfaa002,
                        sfca003,sfca004,sfaa016,
                        sfcb003,sfcb004,sfcb011
           FROM s_detail1[1].b_sfcadocno,s_detail1[1].b_sfca001,s_detail1[1].b_sfaa010,
                s_detail1[1].b_sfaa019,s_detail1[1].b_sfaa020,s_detail1[1].b_sfaa002,
                s_detail1[1].b_sfca003,s_detail1[1].b_sfca004,s_detail1[1].b_sfaa016,
                s_detail1[1].b_sfcb003,s_detail1[1].b_sfcb004,s_detail1[1].b_sfcb011
      
         BEFORE CONSTRUCT
#sa              CALL cl_qbe_display_condition(lc_qbe_sn)
      
         ON ACTION controlp INFIELD b_sfcadocno  #工单单号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " sfaasite ='",g_site,"' "
            CALL q_sfaadocno_7()
            DISPLAY g_qryparam.return1 TO b_sfcadocno
            NEXT FIELD b_sfcadocno                  #返回原欄位
      
         ON ACTION controlp INFIELD b_sfca001   #RUNCARD
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " sfcasite ='",g_site,"' "
            CALL q_sfca001_2()
            DISPLAY g_qryparam.return1 TO b_sfca001
            NEXT FIELD b_sfca001                    #返回原欄位
      
         ON ACTION controlp INFIELD b_sfaa010   #生产料号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()
            DISPLAY g_qryparam.return1 TO b_sfaa010
            NEXT FIELD b_sfaa010                    #返回原欄位
      
         ON ACTION controlp INFIELD b_sfaa002   #生管员
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO b_sfaa002
            NEXT FIELD b_sfaa002                    #返回原欄位
      
         ON ACTION controlp INFIELD b_sfaa016   #制程编号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            CALL q_ecba002()
            DISPLAY g_qryparam.return1 TO b_sfaa016
            NEXT FIELD b_sfaa016                    #返回原欄位
      
         ON ACTION controlp INFIELD b_sfcb003   #作业编号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "221"
            CALL q_oocq002()
            DISPLAY g_qryparam.return1 TO b_sfcb003
            NEXT FIELD b_sfcb003                   #返回原欄位
      
      END CONSTRUCT

      BEFORE DIALOG
      
      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG

   END DIALOG
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      RETURN
   END IF
   
   LET g_error_show = 1
   CALL asfp302_b_fill()
   #LET l_ac = g_master_idx
   CALL asfp302_fetch()
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = -100
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
   RETURN  #不走下面
   #end add-point
        
   LET g_error_show = 1
   CALL asfp302_b_fill()
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
 
{<section id="asfp302.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION asfp302_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1 "
   END IF
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_sql = " SELECT 'N',sfcadocno,'N',sfca001,sfaa010,'','',sfaa019,sfaa020, ",
               "        sfaa002,'',sfca003,sfca004,sfaa016,sfcb003,sfcb004,sfcb011, ",  
               #150625-00005 by whitney modify start
               "        (sfcb028+sfcb029+sfcb030+sfcb031+sfcb032-sfcb033-sfcb034-sfcb035-sfcb036-sfcb037-sfcb038-sfcb039), ", #160825-00059#1 unmark
               #"        sfcb050, ",
               #可拆/并数量=生产数量-(良品转出+重工转出+回收转出+分割转出+合并转出+当站报废+当站下线)
               #"        (sfca003-(sfcb033+sfcb034+sfcb035+sfcb038+sfcb039+sfcb036+sfcb037)), ",  #160825-00059#1 mark
               #150625-00005 by whitney modify end
               "        0 ",
               "   FROM sfca_t,sfcb_t,sfaa_t ",
               "  WHERE sfcaent   = sfcbent ",
               "    AND sfcadocno = sfcbdocno ",
               "    AND sfca001   = sfcb001 ",
               "    AND sfcaent   = sfaaent ",
               "    AND sfcadocno = sfaadocno ",
               "    AND sfcaent   = ? ",
               "    AND sfcasite  = '",g_site,"' ",
               "    AND sfaastus NOT IN ('C','E','M') ",  #未结案的
               #150625-00005 by whitney modify start
               "    AND (sfcb028+sfcb029+sfcb030+sfcb031+sfcb032-sfcb033-sfcb034-sfcb035-sfcb036-sfcb037-sfcb038-sfcb039) > 0 ",  #160825-00059#1 unmark
               #"    AND sfcb050 > 0 ",
               #在制量>0代表在报工类型中有待报工数量
               #"    AND (sfca003-(sfcb033+sfcb034+sfcb035+sfcb038+sfcb039+sfcb036+sfcb037)) > 0 ",  #160825-00059#1 mark
               #150625-00005 by whitney modify end
               "    AND sfcb016 = 'Y' ",  #报工站
               "    AND sfcb005 !='3' ",  #排除无顺序群组--因新增runcard时无法处理 暂且排除，由SA分析后再做处理
               "    AND ",g_wc CLIPPED
   #end add-point
 
   PREPARE asfp302_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR asfp302_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].sel,g_detail_d[l_ac].b_sfcadocno,g_detail_d[l_ac].ismain,g_detail_d[l_ac].b_sfca001,
   g_detail_d[l_ac].b_sfaa010,g_detail_d[l_ac].b_sfaa010_desc,g_detail_d[l_ac].b_sfaa010_desc_1,
   g_detail_d[l_ac].b_sfaa019,g_detail_d[l_ac].b_sfaa020,g_detail_d[l_ac].b_sfaa002,g_detail_d[l_ac].b_sfaa002_desc,
   g_detail_d[l_ac].b_sfca003,g_detail_d[l_ac].b_sfca004,g_detail_d[l_ac].b_sfaa016,g_detail_d[l_ac].b_sfcb003,
   g_detail_d[l_ac].b_sfcb004,g_detail_d[l_ac].b_sfcb011,g_detail_d[l_ac].wip_qty,g_detail_d[l_ac].issue_qty
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
      CALL s_desc_get_item_desc(g_detail_d[l_ac].b_sfaa010)
           RETURNING g_detail_d[l_ac].b_sfaa010_desc,g_detail_d[l_ac].b_sfaa010_desc_1
      CALL s_desc_get_person_desc(g_detail_d[l_ac].b_sfaa002)
           RETURNING g_detail_d[l_ac].b_sfaa002_desc
      #end add-point
      
      CALL asfp302_detail_show()      
 
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
   LET g_rec_b = l_ac - 1
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE asfp302_sel
   
   LET l_ac = 1
   CALL asfp302_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asfp302.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION asfp302_fetch()
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
 
{<section id="asfp302.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION asfp302_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asfp302.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION asfp302_filter()
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
   LET g_rec_b = 1
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL asfp302_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="asfp302.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION asfp302_filter_parser(ps_field)
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
 
{<section id="asfp302.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION asfp302_filter_show(ps_field,ps_object)
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
   LET ls_condition = asfp302_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="asfp302.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION asfp302_sel_all(p_flag)
   DEFINE p_flag         LIKE type_t.chr1
   DEFINE l_i            LIKE type_t.num5

   #FOR l_i = 1 TO g_rec_b
   FOR l_i = 1 TO g_detail_cnt
       LET g_detail_d[l_i].sel = p_flag
   END FOR
END FUNCTION
#拆分
PRIVATE FUNCTION asfp302_split()
DEFINE l_success    LIKE type_t.num5
DEFINE l_i          LIKE type_t.num5
  
   #检查
   CALL asfp302_split_chk() RETURNING l_success
   IF NOT l_success THEN
      RETURN
   END IF

   CALL s_transaction_begin()

   #彈出畫面asfp302_1，录入拆分明细，进行拆分
   FOR l_i = 1 TO g_detail_cnt
       IF g_detail_d[l_i].sel = 'Y' THEN
          CALL asfp302_01(g_detail_d[l_i].b_sfcadocno,g_detail_d[l_i].b_sfca001,g_detail_d[l_i].b_sfcb003,g_detail_d[l_i].b_sfcb004,g_detail_d[l_i].wip_qty,g_detail_d[l_i].issue_qty)
             RETURNING l_success
          IF NOT l_success THEN
             CALL s_transaction_end('N','0')
             RETURN
          END IF
       END IF
   END FOR
   
   #执行成功
   INITIALIZE g_errparam TO NULL
   LET g_errparam.code = 'adz-00217'
   LET g_errparam.extend = ''
   LET g_errparam.popup = TRUE
   CALL cl_err()

   CALL s_transaction_end('Y','0')
   
   CALL asfp302_b_fill()
   
END FUNCTION
#所選項目的工單單號+作業編號+作業序是否一致，若有不一致情況不可合併
#是否有且僅有一筆主RunCard被勾選
PRIVATE FUNCTION asfp302_combine_chk()
   DEFINE r_success   LIKE type_t.num5
   DEFINE r_main      LIKE type_t.num5     #主runcard所在位置
   DEFINE r_sum       LIKE sfcb_t.sfcb028  #合并的异动数量
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_i         LIKE type_t.num5
   DEFINE l_str       STRING
   DEFINE l_str_t     STRING
   DEFINE l_sfaastus  LIKE sfaa_t.sfaastus #工单状态
   
   LET r_success = TRUE
   
   LET l_cnt = 0
   FOR l_i = 1 TO g_detail_cnt
       IF g_detail_d[l_i].sel = 'Y' THEN
          #仅有一笔runcard被勾选
          IF g_detail_d[l_i].ismain = 'Y' THEN
             LET r_main = l_i  #主runcard所在位置
             LET l_cnt = l_cnt + 1
             IF l_cnt > 1 THEN
                #有多笔主RUNCARD，不可合并！请选择一笔，且仅一笔作为主RUNCARD！
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'asf-00256'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                LET r_success = FALSE
                RETURN r_success,r_main
             END IF
          END IF
          
          #工單單號+作業編號+作業序 需一致
          LET l_str = g_detail_d[l_i].b_sfcadocno,',',g_detail_d[l_i].b_sfcb003,',',g_detail_d[l_i].b_sfcb004
          IF cl_null(l_str_t) THEN
             LET l_str_t = l_str
          ELSE
             IF l_str_t != l_str THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'asf-00258'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                LET r_success = FALSE
                RETURN r_success,r_main
             END IF
          END IF
          
          #工单未结案  单身显示时已筛选了，防止期间有人再做了结案动作
          SELECT sfaastus INTO l_sfaastus
            FROM sfaa_t
           WHERE sfaaent   = g_enterprise
             AND sfaadocno = g_detail_d[l_i].b_sfcadocno
          IF l_sfaastus MATCHES '[CEM]' THEN 
             #工单已结案，不可异动
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'asf-00264'
             LET g_errparam.extend = g_detail_d[l_i].b_sfcadocno
             LET g_errparam.popup = TRUE
             CALL cl_err()

             LET r_success = FALSE
             RETURN r_success,r_main
          END IF
                    
          #检查本次异动数量
          IF cl_null(g_detail_d[l_i].issue_qty) THEN 
             #异动量不可为空，请输入
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'asf-00282'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             LET r_success = FALSE
             RETURN r_success,r_main
          END IF
          IF g_detail_d[l_i].issue_qty = 0 THEN
             #待拆分数量为0，无需拆分！请确认
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'asf-00275'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             LET r_success = FALSE
             RETURN r_success,r_main
          END IF
          IF g_detail_d[l_i].issue_qty < 0 THEN
             #数量不可小于0，请重新录入
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'agl-00041'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             LET r_success = FALSE
             RETURN r_success,r_main
          END IF
          IF g_detail_d[l_i].issue_qty > g_detail_d[l_i].wip_qty THEN
             #异动量不可大于在制量，请重新输入
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'asf-00252'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             LET r_success = FALSE
             RETURN r_success,r_main
          END IF
       END IF
   END FOR
   #有且仅有一笔runcard被勾选
   IF l_cnt = 0 THEN
      #未选择主RUNCARD，不可合并！请选择一笔，且仅一笔作为主RUNCARD！
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00257'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success,r_main
   END IF
   
   RETURN r_success,r_main
END FUNCTION
#合并
PRIVATE FUNCTION asfp302_combine()
   DEFINE l_success   LIKE type_t.num5
   #161109-00085#38-s
   #DEFINE l_sfca      RECORD LIKE sfca_t.*
   DEFINE l_sfca RECORD  #工單製程單頭檔
       sfcaent LIKE sfca_t.sfcaent, #企業編號
       sfcasite LIKE sfca_t.sfcasite, #營運據點
       sfcadocno LIKE sfca_t.sfcadocno, #單號
       sfca001 LIKE sfca_t.sfca001, #RUN CARD編號
       sfca002 LIKE sfca_t.sfca002, #變更版本
       sfca003 LIKE sfca_t.sfca003, #生產數量
       sfca004 LIKE sfca_t.sfca004, #完工數量
      #sfca005 LIKE sfca_t.sfca005  #RUN CARD類型 #161109-00085#61 mark
       #161109-00085#61 --s add
       sfca005 LIKE sfca_t.sfca005, #RUN CARD類型
       sfcaud001 LIKE sfca_t.sfcaud001, #自定義欄位(文字)001
       sfcaud002 LIKE sfca_t.sfcaud002, #自定義欄位(文字)002
       sfcaud003 LIKE sfca_t.sfcaud003, #自定義欄位(文字)003
       sfcaud004 LIKE sfca_t.sfcaud004, #自定義欄位(文字)004
       sfcaud005 LIKE sfca_t.sfcaud005, #自定義欄位(文字)005
       sfcaud006 LIKE sfca_t.sfcaud006, #自定義欄位(文字)006
       sfcaud007 LIKE sfca_t.sfcaud007, #自定義欄位(文字)007
       sfcaud008 LIKE sfca_t.sfcaud008, #自定義欄位(文字)008
       sfcaud009 LIKE sfca_t.sfcaud009, #自定義欄位(文字)009
       sfcaud010 LIKE sfca_t.sfcaud010, #自定義欄位(文字)010
       sfcaud011 LIKE sfca_t.sfcaud011, #自定義欄位(數字)011
       sfcaud012 LIKE sfca_t.sfcaud012, #自定義欄位(數字)012
       sfcaud013 LIKE sfca_t.sfcaud013, #自定義欄位(數字)013
       sfcaud014 LIKE sfca_t.sfcaud014, #自定義欄位(數字)014
       sfcaud015 LIKE sfca_t.sfcaud015, #自定義欄位(數字)015
       sfcaud016 LIKE sfca_t.sfcaud016, #自定義欄位(數字)016
       sfcaud017 LIKE sfca_t.sfcaud017, #自定義欄位(數字)017
       sfcaud018 LIKE sfca_t.sfcaud018, #自定義欄位(數字)018
       sfcaud019 LIKE sfca_t.sfcaud019, #自定義欄位(數字)019
       sfcaud020 LIKE sfca_t.sfcaud020, #自定義欄位(數字)020
       sfcaud021 LIKE sfca_t.sfcaud021, #自定義欄位(日期時間)021
       sfcaud022 LIKE sfca_t.sfcaud022, #自定義欄位(日期時間)022
       sfcaud023 LIKE sfca_t.sfcaud023, #自定義欄位(日期時間)023
       sfcaud024 LIKE sfca_t.sfcaud024, #自定義欄位(日期時間)024
       sfcaud025 LIKE sfca_t.sfcaud025, #自定義欄位(日期時間)025
       sfcaud026 LIKE sfca_t.sfcaud026, #自定義欄位(日期時間)026
       sfcaud027 LIKE sfca_t.sfcaud027, #自定義欄位(日期時間)027
       sfcaud028 LIKE sfca_t.sfcaud028, #自定義欄位(日期時間)028
       sfcaud029 LIKE sfca_t.sfcaud029, #自定義欄位(日期時間)029
       sfcaud030 LIKE sfca_t.sfcaud030  #自定義欄位(日期時間)030
       #161109-00085#61 --e add
   END RECORD   
   #161109-00085#38-e
   
   #161109-00085#38-s
   #DEFINE l_sfcb      RECORD LIKE sfcb_t.*
   DEFINE l_sfcb RECORD  #工單製程單身檔
       sfcbent LIKE sfcb_t.sfcbent, #企業編號
       sfcbsite LIKE sfcb_t.sfcbsite, #營運據點
       sfcbdocno LIKE sfcb_t.sfcbdocno, #單號
       sfcb001 LIKE sfcb_t.sfcb001, #RUN CARD
       sfcb002 LIKE sfcb_t.sfcb002, #項次
       sfcb003 LIKE sfcb_t.sfcb003, #本站作業
       sfcb004 LIKE sfcb_t.sfcb004, #作業序
       sfcb005 LIKE sfcb_t.sfcb005, #群組性質
       sfcb006 LIKE sfcb_t.sfcb006, #群組
       sfcb007 LIKE sfcb_t.sfcb007, #上站作業
       sfcb008 LIKE sfcb_t.sfcb008, #上站作業序
       sfcb009 LIKE sfcb_t.sfcb009, #下站作業
       sfcb010 LIKE sfcb_t.sfcb010, #下站作業序
       sfcb011 LIKE sfcb_t.sfcb011, #工作站
       sfcb012 LIKE sfcb_t.sfcb012, #允許委外
       sfcb013 LIKE sfcb_t.sfcb013, #主要加工廠
       sfcb014 LIKE sfcb_t.sfcb014, #Move in
       sfcb015 LIKE sfcb_t.sfcb015, #Check in
       sfcb016 LIKE sfcb_t.sfcb016, #報工站
       sfcb017 LIKE sfcb_t.sfcb017, #PQC
       sfcb018 LIKE sfcb_t.sfcb018, #Check out
       sfcb019 LIKE sfcb_t.sfcb019, #Move out
       sfcb020 LIKE sfcb_t.sfcb020, #轉出單位
       sfcb021 LIKE sfcb_t.sfcb021, #單位轉換率分子
       sfcb022 LIKE sfcb_t.sfcb022, #單位轉換率分母
       sfcb023 LIKE sfcb_t.sfcb023, #固定工時
       sfcb024 LIKE sfcb_t.sfcb024, #標準工時
       sfcb025 LIKE sfcb_t.sfcb025, #固定機時
       sfcb026 LIKE sfcb_t.sfcb026, #標準機時
       sfcb027 LIKE sfcb_t.sfcb027, #標準產出量
       sfcb028 LIKE sfcb_t.sfcb028, #良品轉入
       sfcb029 LIKE sfcb_t.sfcb029, #重工轉入
       sfcb030 LIKE sfcb_t.sfcb030, #回收轉入
       sfcb031 LIKE sfcb_t.sfcb031, #分割轉入
       sfcb032 LIKE sfcb_t.sfcb032, #合併轉入
       sfcb033 LIKE sfcb_t.sfcb033, #良品轉出
       sfcb034 LIKE sfcb_t.sfcb034, #重工轉出
       sfcb035 LIKE sfcb_t.sfcb035, #回收轉出
       sfcb036 LIKE sfcb_t.sfcb036, #當站報廢
       sfcb037 LIKE sfcb_t.sfcb037, #當站下線
       sfcb038 LIKE sfcb_t.sfcb038, #分割轉出
       sfcb039 LIKE sfcb_t.sfcb039, #合併轉出
       sfcb040 LIKE sfcb_t.sfcb040, #Bonus
       sfcb041 LIKE sfcb_t.sfcb041, #委外加工數
       sfcb042 LIKE sfcb_t.sfcb042, #委外完工數
       sfcb043 LIKE sfcb_t.sfcb043, #盤點數
       sfcb044 LIKE sfcb_t.sfcb044, #預計開工日
       sfcb045 LIKE sfcb_t.sfcb045, #預計完工日
       sfcb046 LIKE sfcb_t.sfcb046, #待Move in數
       sfcb047 LIKE sfcb_t.sfcb047, #待Check in數
       sfcb048 LIKE sfcb_t.sfcb048, #待Check out數
       sfcb049 LIKE sfcb_t.sfcb049, #待Move out數
       sfcb050 LIKE sfcb_t.sfcb050, #在製數
       sfcb051 LIKE sfcb_t.sfcb051, #待PQC數
       sfcb052 LIKE sfcb_t.sfcb052, #轉入單位
       sfcb053 LIKE sfcb_t.sfcb053, #轉入單位轉換率分子
       sfcb054 LIKE sfcb_t.sfcb054, #轉入單位轉換率分母
      #sfcb055 LIKE sfcb_t.sfcb055  #回收站 #161109-00085#61 mark
       #161109-00085#61 --s add
       sfcb055 LIKE sfcb_t.sfcb055, #回收站
       sfcbud001 LIKE sfcb_t.sfcbud001, #自定義欄位(文字)001
       sfcbud002 LIKE sfcb_t.sfcbud002, #自定義欄位(文字)002
       sfcbud003 LIKE sfcb_t.sfcbud003, #自定義欄位(文字)003
       sfcbud004 LIKE sfcb_t.sfcbud004, #自定義欄位(文字)004
       sfcbud005 LIKE sfcb_t.sfcbud005, #自定義欄位(文字)005
       sfcbud006 LIKE sfcb_t.sfcbud006, #自定義欄位(文字)006
       sfcbud007 LIKE sfcb_t.sfcbud007, #自定義欄位(文字)007
       sfcbud008 LIKE sfcb_t.sfcbud008, #自定義欄位(文字)008
       sfcbud009 LIKE sfcb_t.sfcbud009, #自定義欄位(文字)009
       sfcbud010 LIKE sfcb_t.sfcbud010, #自定義欄位(文字)010
       sfcbud011 LIKE sfcb_t.sfcbud011, #自定義欄位(數字)011
       sfcbud012 LIKE sfcb_t.sfcbud012, #自定義欄位(數字)012
       sfcbud013 LIKE sfcb_t.sfcbud013, #自定義欄位(數字)013
       sfcbud014 LIKE sfcb_t.sfcbud014, #自定義欄位(數字)014
       sfcbud015 LIKE sfcb_t.sfcbud015, #自定義欄位(數字)015
       sfcbud016 LIKE sfcb_t.sfcbud016, #自定義欄位(數字)016
       sfcbud017 LIKE sfcb_t.sfcbud017, #自定義欄位(數字)017
       sfcbud018 LIKE sfcb_t.sfcbud018, #自定義欄位(數字)018
       sfcbud019 LIKE sfcb_t.sfcbud019, #自定義欄位(數字)019
       sfcbud020 LIKE sfcb_t.sfcbud020, #自定義欄位(數字)020
       sfcbud021 LIKE sfcb_t.sfcbud021, #自定義欄位(日期時間)021
       sfcbud022 LIKE sfcb_t.sfcbud022, #自定義欄位(日期時間)022
       sfcbud023 LIKE sfcb_t.sfcbud023, #自定義欄位(日期時間)023
       sfcbud024 LIKE sfcb_t.sfcbud024, #自定義欄位(日期時間)024
       sfcbud025 LIKE sfcb_t.sfcbud025, #自定義欄位(日期時間)025
       sfcbud026 LIKE sfcb_t.sfcbud026, #自定義欄位(日期時間)026
       sfcbud027 LIKE sfcb_t.sfcbud027, #自定義欄位(日期時間)027
       sfcbud028 LIKE sfcb_t.sfcbud028, #自定義欄位(日期時間)028
       sfcbud029 LIKE sfcb_t.sfcbud029, #自定義欄位(日期時間)029
       sfcbud030 LIKE sfcb_t.sfcbud030  #自定義欄位(日期時間)030
       #161109-00085#61 --e add
   END RECORD
   #161109-00085#38-e     
   DEFINE l_main      LIKE type_t.num5    #主runcard所在位置
   DEFINE l_qty_sum   LIKE sfcb_t.sfcb028 #合并量总数
   DEFINE l_sfcb053   LIKE sfcb_t.sfcb053 #轉入單位轉換率分子
   DEFINE l_sfcb054   LIKE sfcb_t.sfcb054 #轉入單位轉換率分母
   DEFINE l_sfca003   LIKE sfca_t.sfca003 #生产数量
   DEFINE l_sql       STRING
   DEFINE l_sfcb002   LIKE sfcb_t.sfcb002 #项次
   DEFINE l_sfcb005   LIKE sfcb_t.sfcb005 #群组性质
   DEFINE l_sfcb006   LIKE sfcb_t.sfcb006 #群组编号
   DEFINE l_sfcb002_r LIKE sfcb_t.sfcb002   #群组中此线路的第一站项次
   DEFINE l_sfcb003_r LIKE sfcb_t.sfcb003   #群组中此线路的第一站作业编号
   DEFINE l_sfcb004_r LIKE sfcb_t.sfcb004   #群组中此线路的第一站作业序
   DEFINE l_sfcb007_r LIKE sfcb_t.sfcb007   #群组前的站点作业编号
   DEFINE l_sfcb008_r LIKE sfcb_t.sfcb008   #群组前的站点作业序
   DEFINE l_i         LIKE type_t.num5
   DEFINE l_sfchseq   LIKE sfch_t.sfchseq
   #161109-00085#38-s
   #DEFINE l_sfcg      RECORD LIKE sfcg_t.*   
   DEFINE l_sfcg RECORD  #RunCard合併記錄單頭檔
       sfcgent LIKE sfcg_t.sfcgent, #企業編號
       sfcgsite LIKE sfcg_t.sfcgsite, #營運據點
       sfcgdocno LIKE sfcg_t.sfcgdocno, #工單單號
       sfcgdocdt LIKE sfcg_t.sfcgdocdt, #合併日期
       sfcg001 LIKE sfcg_t.sfcg001, #合併版本
       sfcg002 LIKE sfcg_t.sfcg002, #作業編號
       sfcg003 LIKE sfcg_t.sfcg003, #作業序
       sfcg004 LIKE sfcg_t.sfcg004, #新RunCard編號
      #sfcg005 LIKE sfcg_t.sfcg005  #合併轉入數量 #161109-00085#61 mark
       #161109-00085#61 --s add
       sfcg005 LIKE sfcg_t.sfcg005, #合併轉入數量
       sfcgud001 LIKE sfcg_t.sfcgud001, #自定義欄位(文字)001
       sfcgud002 LIKE sfcg_t.sfcgud002, #自定義欄位(文字)002
       sfcgud003 LIKE sfcg_t.sfcgud003, #自定義欄位(文字)003
       sfcgud004 LIKE sfcg_t.sfcgud004, #自定義欄位(文字)004
       sfcgud005 LIKE sfcg_t.sfcgud005, #自定義欄位(文字)005
       sfcgud006 LIKE sfcg_t.sfcgud006, #自定義欄位(文字)006
       sfcgud007 LIKE sfcg_t.sfcgud007, #自定義欄位(文字)007
       sfcgud008 LIKE sfcg_t.sfcgud008, #自定義欄位(文字)008
       sfcgud009 LIKE sfcg_t.sfcgud009, #自定義欄位(文字)009
       sfcgud010 LIKE sfcg_t.sfcgud010, #自定義欄位(文字)010
       sfcgud011 LIKE sfcg_t.sfcgud011, #自定義欄位(數字)011
       sfcgud012 LIKE sfcg_t.sfcgud012, #自定義欄位(數字)012
       sfcgud013 LIKE sfcg_t.sfcgud013, #自定義欄位(數字)013
       sfcgud014 LIKE sfcg_t.sfcgud014, #自定義欄位(數字)014
       sfcgud015 LIKE sfcg_t.sfcgud015, #自定義欄位(數字)015
       sfcgud016 LIKE sfcg_t.sfcgud016, #自定義欄位(數字)016
       sfcgud017 LIKE sfcg_t.sfcgud017, #自定義欄位(數字)017
       sfcgud018 LIKE sfcg_t.sfcgud018, #自定義欄位(數字)018
       sfcgud019 LIKE sfcg_t.sfcgud019, #自定義欄位(數字)019
       sfcgud020 LIKE sfcg_t.sfcgud020, #自定義欄位(數字)020
       sfcgud021 LIKE sfcg_t.sfcgud021, #自定義欄位(日期時間)021
       sfcgud022 LIKE sfcg_t.sfcgud022, #自定義欄位(日期時間)022
       sfcgud023 LIKE sfcg_t.sfcgud023, #自定義欄位(日期時間)023
       sfcgud024 LIKE sfcg_t.sfcgud024, #自定義欄位(日期時間)024
       sfcgud025 LIKE sfcg_t.sfcgud025, #自定義欄位(日期時間)025
       sfcgud026 LIKE sfcg_t.sfcgud026, #自定義欄位(日期時間)026
       sfcgud027 LIKE sfcg_t.sfcgud027, #自定義欄位(日期時間)027
       sfcgud028 LIKE sfcg_t.sfcgud028, #自定義欄位(日期時間)028
       sfcgud029 LIKE sfcg_t.sfcgud029, #自定義欄位(日期時間)029
       sfcgud030 LIKE sfcg_t.sfcgud030  #自定義欄位(日期時間)030
   #161109-00085#61 --e add
   END RECORD
   #161109-00085#38-e   
   #161109-00085#38-s
   #DEFINE l_sfch      RECORD LIKE sfch_t.*
   DEFINE l_sfch RECORD  #RunCard合併記錄單身檔
       sfchent LIKE sfch_t.sfchent, #企業編號
       sfchsite LIKE sfch_t.sfchsite, #營運據點
       sfchdocno LIKE sfch_t.sfchdocno, #工單單號
       sfchseq LIKE sfch_t.sfchseq, #項次
       sfch001 LIKE sfch_t.sfch001, #合併版本
       sfch002 LIKE sfch_t.sfch002, #作業編號
       sfch003 LIKE sfch_t.sfch003, #作業序
       sfch004 LIKE sfch_t.sfch004, #原RunCard編號
       #sfch005 LIKE sfch_t.sfch005  #合併轉出數量 #161109-00085#61 mark
       #161109-00085#61 --s add
       sfch005 LIKE sfch_t.sfch005, #合併轉出數量
       sfchud001 LIKE sfch_t.sfchud001, #自定義欄位(文字)001
       sfchud002 LIKE sfch_t.sfchud002, #自定義欄位(文字)002
       sfchud003 LIKE sfch_t.sfchud003, #自定義欄位(文字)003
       sfchud004 LIKE sfch_t.sfchud004, #自定義欄位(文字)004
       sfchud005 LIKE sfch_t.sfchud005, #自定義欄位(文字)005
       sfchud006 LIKE sfch_t.sfchud006, #自定義欄位(文字)006
       sfchud007 LIKE sfch_t.sfchud007, #自定義欄位(文字)007
       sfchud008 LIKE sfch_t.sfchud008, #自定義欄位(文字)008
       sfchud009 LIKE sfch_t.sfchud009, #自定義欄位(文字)009
       sfchud010 LIKE sfch_t.sfchud010, #自定義欄位(文字)010
       sfchud011 LIKE sfch_t.sfchud011, #自定義欄位(數字)011
       sfchud012 LIKE sfch_t.sfchud012, #自定義欄位(數字)012
       sfchud013 LIKE sfch_t.sfchud013, #自定義欄位(數字)013
       sfchud014 LIKE sfch_t.sfchud014, #自定義欄位(數字)014
       sfchud015 LIKE sfch_t.sfchud015, #自定義欄位(數字)015
       sfchud016 LIKE sfch_t.sfchud016, #自定義欄位(數字)016
       sfchud017 LIKE sfch_t.sfchud017, #自定義欄位(數字)017
       sfchud018 LIKE sfch_t.sfchud018, #自定義欄位(數字)018
       sfchud019 LIKE sfch_t.sfchud019, #自定義欄位(數字)019
       sfchud020 LIKE sfch_t.sfchud020, #自定義欄位(數字)020
       sfchud021 LIKE sfch_t.sfchud021, #自定義欄位(日期時間)021
       sfchud022 LIKE sfch_t.sfchud022, #自定義欄位(日期時間)022
       sfchud023 LIKE sfch_t.sfchud023, #自定義欄位(日期時間)023
       sfchud024 LIKE sfch_t.sfchud024, #自定義欄位(日期時間)024
       sfchud025 LIKE sfch_t.sfchud025, #自定義欄位(日期時間)025
       sfchud026 LIKE sfch_t.sfchud026, #自定義欄位(日期時間)026
       sfchud027 LIKE sfch_t.sfchud027, #自定義欄位(日期時間)027
       sfchud028 LIKE sfch_t.sfchud028, #自定義欄位(日期時間)028
       sfchud029 LIKE sfch_t.sfchud029, #自定義欄位(日期時間)029
       sfchud030 LIKE sfch_t.sfchud030  #自定義欄位(日期時間)030
       #161109-00085#61 --e add
   END RECORD
   #161109-00085#38-e
   
   #161109-00085#38-s
   #DEFINE l_sfcc      RECORD LIKE sfcc_t.*  #160825-00059#1 add 
   DEFINE l_sfcc RECORD  #工單製程上站作業資料
       sfccent LIKE sfcc_t.sfccent, #企業編號
       sfccsite LIKE sfcc_t.sfccsite, #營運據點
       sfccdocno LIKE sfcc_t.sfccdocno, #單號
       sfcc001 LIKE sfcc_t.sfcc001, #RUN CARD
       sfcc002 LIKE sfcc_t.sfcc002, #項次
       sfcc003 LIKE sfcc_t.sfcc003, #上站作業
      #sfcc004 LIKE sfcc_t.sfcc004  #上站作業序 #161109-00085#61 mark
       #161109-00085#61 --s add
       sfcc004 LIKE sfcc_t.sfcc004, #上站作業序
       sfccud001 LIKE sfcc_t.sfccud001, #自定義欄位(文字)001
       sfccud002 LIKE sfcc_t.sfccud002, #自定義欄位(文字)002
       sfccud003 LIKE sfcc_t.sfccud003, #自定義欄位(文字)003
       sfccud004 LIKE sfcc_t.sfccud004, #自定義欄位(文字)004
       sfccud005 LIKE sfcc_t.sfccud005, #自定義欄位(文字)005
       sfccud006 LIKE sfcc_t.sfccud006, #自定義欄位(文字)006
       sfccud007 LIKE sfcc_t.sfccud007, #自定義欄位(文字)007
       sfccud008 LIKE sfcc_t.sfccud008, #自定義欄位(文字)008
       sfccud009 LIKE sfcc_t.sfccud009, #自定義欄位(文字)009
       sfccud010 LIKE sfcc_t.sfccud010, #自定義欄位(文字)010
       sfccud011 LIKE sfcc_t.sfccud011, #自定義欄位(數字)011
       sfccud012 LIKE sfcc_t.sfccud012, #自定義欄位(數字)012
       sfccud013 LIKE sfcc_t.sfccud013, #自定義欄位(數字)013
       sfccud014 LIKE sfcc_t.sfccud014, #自定義欄位(數字)014
       sfccud015 LIKE sfcc_t.sfccud015, #自定義欄位(數字)015
       sfccud016 LIKE sfcc_t.sfccud016, #自定義欄位(數字)016
       sfccud017 LIKE sfcc_t.sfccud017, #自定義欄位(數字)017
       sfccud018 LIKE sfcc_t.sfccud018, #自定義欄位(數字)018
       sfccud019 LIKE sfcc_t.sfccud019, #自定義欄位(數字)019
       sfccud020 LIKE sfcc_t.sfccud020, #自定義欄位(數字)020
       sfccud021 LIKE sfcc_t.sfccud021, #自定義欄位(日期時間)021
       sfccud022 LIKE sfcc_t.sfccud022, #自定義欄位(日期時間)022
       sfccud023 LIKE sfcc_t.sfccud023, #自定義欄位(日期時間)023
       sfccud024 LIKE sfcc_t.sfccud024, #自定義欄位(日期時間)024
       sfccud025 LIKE sfcc_t.sfccud025, #自定義欄位(日期時間)025
       sfccud026 LIKE sfcc_t.sfccud026, #自定義欄位(日期時間)026
       sfccud027 LIKE sfcc_t.sfccud027, #自定義欄位(日期時間)027
       sfccud028 LIKE sfcc_t.sfccud028, #自定義欄位(日期時間)028
       sfccud029 LIKE sfcc_t.sfccud029, #自定義欄位(日期時間)029
       sfccud030 LIKE sfcc_t.sfccud030  #自定義欄位(日期時間)030
       #161109-00085#61 --e add
   END RECORD   
   #161109-00085#38-e
   
   #161109-00085#38-s
   #DEFINE l_sfcd      RECORD LIKE sfcd_t.*  #160825-00059#1 add
   DEFINE l_sfcd RECORD  #工單製程check in/out專案資料
       sfcdent LIKE sfcd_t.sfcdent, #企業編號
       sfcdsite LIKE sfcd_t.sfcdsite, #營運據點
       sfcddocno LIKE sfcd_t.sfcddocno, #單號
       sfcd001 LIKE sfcd_t.sfcd001, #RUN CARD
       sfcd002 LIKE sfcd_t.sfcd002, #項次
       sfcd003 LIKE sfcd_t.sfcd003, #專案
       sfcd004 LIKE sfcd_t.sfcd004, #型態
       sfcd005 LIKE sfcd_t.sfcd005, #下限
       sfcd006 LIKE sfcd_t.sfcd006, #上限
       sfcd007 LIKE sfcd_t.sfcd007, #預設值
       sfcd008 LIKE sfcd_t.sfcd008, #必要
      #sfcd009 LIKE sfcd_t.sfcd009  #check in/check out #161109-00085#61 mark
       #161109-00085#61 --s add
       sfcd009 LIKE sfcd_t.sfcd009, #check in/check out
       sfcdud001 LIKE sfcd_t.sfcdud001, #自定義欄位(文字)001
       sfcdud002 LIKE sfcd_t.sfcdud002, #自定義欄位(文字)002
       sfcdud003 LIKE sfcd_t.sfcdud003, #自定義欄位(文字)003
       sfcdud004 LIKE sfcd_t.sfcdud004, #自定義欄位(文字)004
       sfcdud005 LIKE sfcd_t.sfcdud005, #自定義欄位(文字)005
       sfcdud006 LIKE sfcd_t.sfcdud006, #自定義欄位(文字)006
       sfcdud007 LIKE sfcd_t.sfcdud007, #自定義欄位(文字)007
       sfcdud008 LIKE sfcd_t.sfcdud008, #自定義欄位(文字)008
       sfcdud009 LIKE sfcd_t.sfcdud009, #自定義欄位(文字)009
       sfcdud010 LIKE sfcd_t.sfcdud010, #自定義欄位(文字)010
       sfcdud011 LIKE sfcd_t.sfcdud011, #自定義欄位(數字)011
       sfcdud012 LIKE sfcd_t.sfcdud012, #自定義欄位(數字)012
       sfcdud013 LIKE sfcd_t.sfcdud013, #自定義欄位(數字)013
       sfcdud014 LIKE sfcd_t.sfcdud014, #自定義欄位(數字)014
       sfcdud015 LIKE sfcd_t.sfcdud015, #自定義欄位(數字)015
       sfcdud016 LIKE sfcd_t.sfcdud016, #自定義欄位(數字)016
       sfcdud017 LIKE sfcd_t.sfcdud017, #自定義欄位(數字)017
       sfcdud018 LIKE sfcd_t.sfcdud018, #自定義欄位(數字)018
       sfcdud019 LIKE sfcd_t.sfcdud019, #自定義欄位(數字)019
       sfcdud020 LIKE sfcd_t.sfcdud020, #自定義欄位(數字)020
       sfcdud021 LIKE sfcd_t.sfcdud021, #自定義欄位(日期時間)021
       sfcdud022 LIKE sfcd_t.sfcdud022, #自定義欄位(日期時間)022
       sfcdud023 LIKE sfcd_t.sfcdud023, #自定義欄位(日期時間)023
       sfcdud024 LIKE sfcd_t.sfcdud024, #自定義欄位(日期時間)024
       sfcdud025 LIKE sfcd_t.sfcdud025, #自定義欄位(日期時間)025
       sfcdud026 LIKE sfcd_t.sfcdud026, #自定義欄位(日期時間)026
       sfcdud027 LIKE sfcd_t.sfcdud027, #自定義欄位(日期時間)027
       sfcdud028 LIKE sfcd_t.sfcdud028, #自定義欄位(日期時間)028
       sfcdud029 LIKE sfcd_t.sfcdud029, #自定義欄位(日期時間)029
       sfcdud030 LIKE sfcd_t.sfcdud030  #自定義欄位(日期時間)030
       #161109-00085#61 --e add
   END RECORD
   #161109-00085#38-e
   
   #检查
   CALL asfp302_combine_chk() RETURNING l_success,l_main
   IF NOT l_success THEN
      RETURN
   END IF
   
   IF NOT cl_ask_confirm('asf-00266') THEN
      RETURN
   END IF
   CALL s_transaction_begin()
   
   ########
   #开始合并
   ########
   #计算合并数量,同时記錄RunCard合併記錄檔sfcg_t\sfch_t
   INITIALIZE l_sfcg.* TO NULL
   LET l_sfcg.sfcgent   = g_enterprise   #企業代碼
   LET l_sfcg.sfcgsite  = g_site         #營運據點
   LET l_sfcg.sfcgdocno = g_detail_d[l_main].b_sfcadocno   #工單單號
   LET l_sfcg.sfcgdocdt = cl_get_today()  #合併日期
   
   #合併版本
   SELECT MAX(sfcg001) INTO l_sfcg.sfcg001 FROM sfcg_t
    WHERE sfcgent   = l_sfcg.sfcgent
      AND sfcgdocno = l_sfcg.sfcgdocno
   IF cl_null(l_sfcg.sfcg001) THEN
      LET l_sfcg.sfcg001 = 0
   END IF
   LET l_sfcg.sfcg001   = l_sfcg.sfcg001 + 1
   
   LET l_sfcg.sfcg002   = g_detail_d[l_main].b_sfcb003   #作業編號
   LET l_sfcg.sfcg003   = g_detail_d[l_main].b_sfcb004   #作業序
   LET l_sfcg.sfcg004   = ''    #新RunCard編號
   LET l_sfcg.sfcg005   = 0   #合併轉入數量
   #161109-00085#38-s
   #INSERT INTO sfcg_t VALUES(l_sfcg.*) 
   #161109-00085#61 --s mark   
   #INSERT INTO sfcg_t (sfcgent,sfcgsite,sfcgdocno,sfcgdocdt,sfcg001,sfcg002,sfcg003,sfcg004,sfcg005)
   #            VALUES (l_sfcg.sfcgent,l_sfcg.sfcgsite,l_sfcg.sfcgdocno,l_sfcg.sfcgdocdt,l_sfcg.sfcg001,
   #                    l_sfcg.sfcg002,l_sfcg.sfcg003,l_sfcg.sfcg004,l_sfcg.sfcg005)  
   #161109-00085#61 --e mark
   #161109-00085#61 --s add
   INSERT INTO sfcg_t(sfcgent,sfcgsite,sfcgdocno,sfcgdocdt,sfcg001,
                      sfcg002,sfcg003,sfcg004,sfcg005,sfcgud001,
                      sfcgud002,sfcgud003,sfcgud004,sfcgud005,sfcgud006,
                      sfcgud007,sfcgud008,sfcgud009,sfcgud010,sfcgud011,
                      sfcgud012,sfcgud013,sfcgud014,sfcgud015,sfcgud016,
                      sfcgud017,sfcgud018,sfcgud019,sfcgud020,sfcgud021,
                      sfcgud022,sfcgud023,sfcgud024,sfcgud025,sfcgud026,
                      sfcgud027,sfcgud028,sfcgud029,sfcgud030)
   VALUES(l_sfcg.sfcgent,l_sfcg.sfcgsite,l_sfcg.sfcgdocno,l_sfcg.sfcgdocdt,l_sfcg.sfcg001,
          l_sfcg.sfcg002,l_sfcg.sfcg003,l_sfcg.sfcg004,l_sfcg.sfcg005,l_sfcg.sfcgud001,
          l_sfcg.sfcgud002,l_sfcg.sfcgud003,l_sfcg.sfcgud004,l_sfcg.sfcgud005,l_sfcg.sfcgud006,
          l_sfcg.sfcgud007,l_sfcg.sfcgud008,l_sfcg.sfcgud009,l_sfcg.sfcgud010,l_sfcg.sfcgud011,
          l_sfcg.sfcgud012,l_sfcg.sfcgud013,l_sfcg.sfcgud014,l_sfcg.sfcgud015,l_sfcg.sfcgud016,
          l_sfcg.sfcgud017,l_sfcg.sfcgud018,l_sfcg.sfcgud019,l_sfcg.sfcgud020,l_sfcg.sfcgud021,
          l_sfcg.sfcgud022,l_sfcg.sfcgud023,l_sfcg.sfcgud024,l_sfcg.sfcgud025,l_sfcg.sfcgud026,
          l_sfcg.sfcgud027,l_sfcg.sfcgud028,l_sfcg.sfcgud029,l_sfcg.sfcgud030)
   #161109-00085#61 --e add
   #161109-00085#38-e
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins sfcg_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CALL s_transaction_end('N','0')
      RETURN
   END IF

   LET l_qty_sum = 0
   LET l_sfchseq = 0
   FOR l_i = 1 TO g_detail_cnt
       IF g_detail_d[l_i].sel = 'Y' THEN
          #记录RunCard合併記錄檔单身sfch_t
          INITIALIZE l_sfch.* TO NULL
          LET l_sfch.sfchent   = g_enterprise   #企業代碼
          LET l_sfch.sfchsite  = g_site         #營運據點
          LET l_sfch.sfchdocno = g_detail_d[l_i].b_sfcadocno   #單工單號
          LET l_sfchseq = l_sfchseq + 1
          LET l_sfch.sfchseq   = l_sfchseq   #項次
          LET l_sfch.sfch001   = l_sfcg.sfcg001   #合併版本
          LET l_sfch.sfch002   = g_detail_d[l_i].b_sfcb003   #作業編號
          LET l_sfch.sfch003   = g_detail_d[l_i].b_sfcb004   #作業序
          LET l_sfch.sfch004   = g_detail_d[l_i].b_sfca001   #原RunCard編號
          LET l_sfch.sfch005   = g_detail_d[l_i].issue_qty   #合併轉出數量
          #161109-00085#38-s
          #INSERT INTO sfch_t VALUES(l_sfch.*)
          #161109-00085#61 --s mark
          #INSERT INTO sfch_t(sfchent,sfchsite,sfchdocno,sfchseq,sfch001,sfch002,sfch003,sfch004,sfch005)
          #VALUES(l_sfch.sfchent,l_sfch.sfchsite,l_sfch.sfchdocno,l_sfch.sfchseq,l_sfch.sfch001,
          #       l_sfch.sfch002,l_sfch.sfch003,l_sfch.sfch004,l_sfch.sfch005)
          #161109-00085#61 --e mark
          #161109-00085#61 --s add
          INSERT INTO sfch_t(sfchent,sfchsite,sfchdocno,sfchseq,sfch001,
                             sfch002,sfch003,sfch004,sfch005,sfchud001,
                             sfchud002,sfchud003,sfchud004,sfchud005,sfchud006,
                             sfchud007,sfchud008,sfchud009,sfchud010,sfchud011,
                             sfchud012,sfchud013,sfchud014,sfchud015,sfchud016,
                             sfchud017,sfchud018,sfchud019,sfchud020,sfchud021,
                             sfchud022,sfchud023,sfchud024,sfchud025,sfchud026,
                             sfchud027,sfchud028,sfchud029,sfchud030)
          VALUES(l_sfch.sfchent,l_sfch.sfchsite,l_sfch.sfchdocno,l_sfch.sfchseq,l_sfch.sfch001,
                 l_sfch.sfch002,l_sfch.sfch003,l_sfch.sfch004,l_sfch.sfch005,l_sfch.sfchud001,
                 l_sfch.sfchud002,l_sfch.sfchud003,l_sfch.sfchud004,l_sfch.sfchud005,l_sfch.sfchud006,
                 l_sfch.sfchud007,l_sfch.sfchud008,l_sfch.sfchud009,l_sfch.sfchud010,l_sfch.sfchud011,
                 l_sfch.sfchud012,l_sfch.sfchud013,l_sfch.sfchud014,l_sfch.sfchud015,l_sfch.sfchud016,
                 l_sfch.sfchud017,l_sfch.sfchud018,l_sfch.sfchud019,l_sfch.sfchud020,l_sfch.sfchud021,
                 l_sfch.sfchud022,l_sfch.sfchud023,l_sfch.sfchud024,l_sfch.sfchud025,l_sfch.sfchud026,
                 l_sfch.sfchud027,l_sfch.sfchud028,l_sfch.sfchud029,l_sfch.sfchud030)
          #161109-00085#61 --e add
          #161109-00085#38-e
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'ins sfch_t'
             LET g_errparam.popup = TRUE
             CALL cl_err()

             CALL s_transaction_end('N','0')
             RETURN
          END IF
   
          #项次,群组性质,群组编号            #,Move in,check in,報工站,PQC,Check out,Move out  只处理报工勾选的
          SELECT sfcb002,sfcb005,sfcb006       #,sfcb014,sfcb015,sfcb016,sfcb017,sfcb018,sfcb019
            INTO l_sfcb002,l_sfcb005,l_sfcb006   #,l_sfcb014,l_sfcb015,l_sfcb016,l_sfcb017,l_sfcb018,l_sfcb019
            FROM sfcb_t 
           WHERE sfcbent  = g_enterprise
             AND sfcbdocno= g_detail_d[l_i].b_sfcadocno #工单
             AND sfcb001  = g_detail_d[l_i].b_sfca001  #RUN CARD
             AND sfcb003  = g_detail_d[l_i].b_sfcb003  #作业
             AND sfcb004  = g_detail_d[l_i].b_sfcb004  #作业序
             
          #更新当站资料
          UPDATE sfcb_t SET sfcb039 = sfcb039 + g_detail_d[l_i].issue_qty,   #合并转出数
                            sfcb050 = sfcb050 - g_detail_d[l_i].issue_qty    #在製數
           WHERE sfcbent  = g_enterprise
             AND sfcbdocno= g_detail_d[l_i].b_sfcadocno  #工单
             AND sfcb001  = g_detail_d[l_i].b_sfca001    #RUN CARD
             AND sfcb003  = g_detail_d[l_i].b_sfcb003    #作业
             AND sfcb004  = g_detail_d[l_i].b_sfcb004    #作业序
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'upd sfcb_t'
             LET g_errparam.popup = TRUE
             CALL cl_err()

             CALL s_transaction_end('N','0')
             RETURN
          END IF
          
          #161126-00005#1 add--s
          #上下站标准转出量处理
          CALL asfp302_01_deal_sfcb027('co',g_detail_d[l_i].b_sfcadocno,g_detail_d[l_i].b_sfca001,g_detail_d[l_i].b_sfcb003,g_detail_d[l_i].b_sfcb004,g_detail_d[l_i].issue_qty)
             RETURNING l_success
          IF NOT l_success THEN
             CALL s_transaction_end('N','0')
             RETURN
          END IF
          #161126-00005#1 add--e
   
          #暂时不考虑替代群组等，只考虑最简单的单线工艺，具体待SA规划后再处理
          #IF l_sfcb005 = '2' THEN #替代群组
          #   #判断群组中是否是首站的首个报工类型
          #   #                                  工单号                       runcard号                 项次       作业                      作业序                    群组性质   群组编号   报工类型 
          #   CALL s_asft301_chk_group_f_station(g_detail_d[l_i].b_sfcadocno,g_detail_d[l_i].b_sfca001,l_sfcb002,g_detail_d[l_i].b_sfcb003,g_detail_d[l_i].b_sfcb004,l_sfcb005,l_sfcb006,'3')
          #      RETURNING l_success
          #   IF l_success THEN
          #      #若是首站，找到除本站所在线路外，其他线路的首站首个报工类型，同步扣减待转量，若是报工类型的需同时更新良品转入量
          #      #找出第一个站点以及群组前的站点
          #      #                                   工单号                       runcard号                 项次       作业                      作业序                    群组性质   群组编号
          #      CALL s_asft301_get_group_f_station2(g_detail_d[l_i].b_sfcadocno,g_detail_d[l_i].b_sfca001,l_sfcb002,g_detail_d[l_i].b_sfcb003,g_detail_d[l_i].b_sfcb004,l_sfcb005,l_sfcb006)
          #         RETURNING l_success,l_sfcb002_r,l_sfcb003_r,l_sfcb004_r,l_sfcb007_r,l_sfcb008_r
          #      IF NOT l_success THEN  #异常
          #         CALL s_transaction_end('N','0')
          #         RETURN
          #      END IF
          #      #根据群组前的站点往后找群组中各线路的首站报工类别，若是之前找出来的那个站点的那条线路略过
          #      #                                工单                         runcard号                 群组性质   群组编号  排除的首站作业与作业序    群组前的作业 群组前的作业序
          #      CALL asfp302_upd_group_f_station(g_detail_d[l_i].b_sfcadocno,g_detail_d[l_i].b_sfca001,l_sfcb005,l_sfcb006,l_sfcb003_r,l_sfcb004_r,l_sfcb007_r,l_sfcb008_r)
          #   END IF
          #END IF
                 
          LET l_qty_sum = l_qty_sum + g_detail_d[l_i].issue_qty
       END IF
   END FOR
   #INITIALIZE l_sfcb.* TO NULL
   #SELECT * INTO l_sfcb.* 
   SELECT sfcb053,sfcb054 INTO l_sfcb053,l_sfcb054
     FROM sfcb_t
    WHERE sfcbent  = g_enterprise
      AND sfcbdocno= g_detail_d[l_main].b_sfcadocno #工单
      AND sfcb001  = g_detail_d[l_main].b_sfca001  #RUN CARD
      AND sfcb003  = g_detail_d[l_main].b_sfcb003  #作业
      AND sfcb004  = g_detail_d[l_main].b_sfcb004  #作业序
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'sel sfcb'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #计算生产数量
   LET l_sfca003 = l_qty_sum * l_sfcb054 / l_sfcb053
   
   
   #新增一筆工單製程資料
   INITIALIZE l_sfca.* TO NULL
   LET l_sfca.sfcaent   = g_enterprise
   LET l_sfca.sfcasite  = g_site
   LET l_sfca.sfcadocno = g_detail_d[l_main].b_sfcadocno  #單號
   SELECT MAX(sfca001)+1 INTO l_sfca.sfca001    #RUN CARD編號
     FROM sfca_t
    WHERE sfcaent   = l_sfca.sfcaent
      AND sfcadocno = l_sfca.sfcadocno
   LET l_sfca.sfca002   = 0           #變更版本
   LET l_sfca.sfca003   = l_sfca003   #生產數量
   LET l_sfca.sfca004   = 0           #完工數量
   LET l_sfca.sfca005   = '1'         #RUN CARD類型:1:一般
   #161109-00085#38-s
   #INSERT INTO sfca_t VALUES(l_sfca.*)
   #161109-00085#61 --s mark
   #INSERT INTO sfca_t(sfcaent,sfcasite,sfcadocno,sfca001,sfca002,sfca003,sfca004,sfca005)
   #            VALUES(l_sfca.sfcaent,l_sfca.sfcasite,l_sfca.sfcadocno,l_sfca.sfca001,l_sfca.sfca002,
   #                   l_sfca.sfca003,l_sfca.sfca004,l_sfca.sfca005)
   #161109-00085#61 --e mark
   #161109-00085#61 --s add
   INSERT INTO sfca_t(sfcaent,sfcasite,sfcadocno,sfca001,sfca002,
                      sfca003,sfca004,sfca005,sfcaud001,sfcaud002,
                      sfcaud003,sfcaud004,sfcaud005,sfcaud006,sfcaud007,
                      sfcaud008,sfcaud009,sfcaud010,sfcaud011,sfcaud012,
                      sfcaud013,sfcaud014,sfcaud015,sfcaud016,sfcaud017,
                      sfcaud018,sfcaud019,sfcaud020,sfcaud021,sfcaud022,
                      sfcaud023,sfcaud024,sfcaud025,sfcaud026,sfcaud027,
                      sfcaud028,sfcaud029,sfcaud030)
   VALUES(l_sfca.sfcaent,l_sfca.sfcasite,l_sfca.sfcadocno,l_sfca.sfca001,l_sfca.sfca002,
          l_sfca.sfca003,l_sfca.sfca004,l_sfca.sfca005,l_sfca.sfcaud001,l_sfca.sfcaud002,
          l_sfca.sfcaud003,l_sfca.sfcaud004,l_sfca.sfcaud005,l_sfca.sfcaud006,l_sfca.sfcaud007,
          l_sfca.sfcaud008,l_sfca.sfcaud009,l_sfca.sfcaud010,l_sfca.sfcaud011,l_sfca.sfcaud012,
          l_sfca.sfcaud013,l_sfca.sfcaud014,l_sfca.sfcaud015,l_sfca.sfcaud016,l_sfca.sfcaud017,
          l_sfca.sfcaud018,l_sfca.sfcaud019,l_sfca.sfcaud020,l_sfca.sfcaud021,l_sfca.sfcaud022,
          l_sfca.sfcaud023,l_sfca.sfcaud024,l_sfca.sfcaud025,l_sfca.sfcaud026,l_sfca.sfcaud027,
          l_sfca.sfcaud028,l_sfca.sfcaud029,l_sfca.sfcaud030)
   #161109-00085#61 --e add
   #161109-00085#38-e
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins sfca_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CALL s_transaction_end('N','0')
      RETURN
   END IF


   UPDATE sfcg_t SET sfcg004 = l_sfca.sfca001,  #新RunCard編號
                     sfcg005 = l_qty_sum        #合併轉入數量
    WHERE sfcgent   = l_sfcg.sfcgent
      AND sfcgdocno = l_sfcg.sfcgdocno
      AND sfcg001   = l_sfcg.sfcg001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'upd sfcg_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #抓出主runcard的工艺资料
   #161109-00085#38-s
   #LET l_sql = " SELECT * FROM sfcb_t ",
   #161109-00085#61 --s mark
   #LET l_sql = " SELECT sfcbent,sfcbsite,sfcbdocno,sfcb001,sfcb002,sfcb003,sfcb004,sfcb005,sfcb006,sfcb007, ",
   #            "        sfcb008,sfcb009,sfcb010,sfcb011,sfcb012,sfcb013,sfcb014,sfcb015,sfcb016,sfcb017, ",
   #            "        sfcb018,sfcb019,sfcb020,sfcb021,sfcb022,sfcb023,sfcb024,sfcb025,sfcb026,sfcb027, ",
   #            "        sfcb028,sfcb029,sfcb030,sfcb031,sfcb032,sfcb033,sfcb034,sfcb035,sfcb036,sfcb037, ",
   #            "        sfcb038,sfcb039,sfcb040,sfcb041,sfcb042,sfcb043,sfcb044,sfcb045,sfcb046,sfcb047, ",
   #            "        sfcb048,sfcb049,sfcb050,sfcb051,sfcb052,sfcb053,sfcb054,sfcb055 ",
   #161109-00085#61 --e mark
   #161109-00085#61 --s add
   LET l_sql = " SELECT sfcbent,sfcbsite,sfcbdocno,sfcb001,sfcb002, ",
               "        sfcb003,sfcb004,sfcb005,sfcb006,sfcb007, ",
               "        sfcb008,sfcb009,sfcb010,sfcb011,sfcb012, ",
               "        sfcb013,sfcb014,sfcb015,sfcb016,sfcb017, ",
               "        sfcb018,sfcb019,sfcb020,sfcb021,sfcb022, ",
               "        sfcb023,sfcb024,sfcb025,sfcb026,sfcb027, ",
               "        sfcb028,sfcb029,sfcb030,sfcb031,sfcb032, ",
               "        sfcb033,sfcb034,sfcb035,sfcb036,sfcb037, ",
               "        sfcb038,sfcb039,sfcb040,sfcb041,sfcb042, ",
               "        sfcb043,sfcb044,sfcb045,sfcb046,sfcb047, ",
               "        sfcb048,sfcb049,sfcb050,sfcb051,sfcb052, ",
               "        sfcb053,sfcb054,sfcb055,sfcbud001,sfcbud002, ",
               "        sfcbud003,sfcbud004,sfcbud005,sfcbud006,sfcbud007, ",
               "        sfcbud008,sfcbud009,sfcbud010,sfcbud011,sfcbud012, ",
               "        sfcbud013,sfcbud014,sfcbud015,sfcbud016,sfcbud017, ",
               "        sfcbud018,sfcbud019,sfcbud020,sfcbud021,sfcbud022, ",
               "        sfcbud023,sfcbud024,sfcbud025,sfcbud026,sfcbud027, ",
               "        sfcbud028,sfcbud029,sfcbud030 ",
   #161109-00085#61 --e add
               "   FROM sfcb_t ",
               "  WHERE sfcbent  = ",g_enterprise,
               "    AND sfcbdocno='",g_detail_d[l_main].b_sfcadocno,"' ", #工单
               "    AND sfcb001  = ",g_detail_d[l_main].b_sfca001         #RUN CARD
   PREPARE asfp302_combine_p1 FROM l_sql
   DECLARE asfp302_combine_c1 CURSOR FOR asfp302_combine_p1
   LET l_sfcb002 = 0
   #FOREACH asfp302_combine_c1 INTO l_sfcb.*
   FOREACH asfp302_combine_c1 
   #161109-00085#61 --s mark
   #   INTO l_sfcb.sfcbent,l_sfcb.sfcbsite,l_sfcb.sfcbdocno,l_sfcb.sfcb001,l_sfcb.sfcb002,
   #        l_sfcb.sfcb003,l_sfcb.sfcb004,l_sfcb.sfcb005,l_sfcb.sfcb006,l_sfcb.sfcb007,
   #        l_sfcb.sfcb008,l_sfcb.sfcb009,l_sfcb.sfcb010,l_sfcb.sfcb011,l_sfcb.sfcb012,
   #        l_sfcb.sfcb013,l_sfcb.sfcb014,l_sfcb.sfcb015,l_sfcb.sfcb016,l_sfcb.sfcb017,
   #        l_sfcb.sfcb018,l_sfcb.sfcb019,l_sfcb.sfcb020,l_sfcb.sfcb021,l_sfcb.sfcb022,
   #        l_sfcb.sfcb023,l_sfcb.sfcb024,l_sfcb.sfcb025,l_sfcb.sfcb026,l_sfcb.sfcb027,
   #        l_sfcb.sfcb028,l_sfcb.sfcb029,l_sfcb.sfcb030,l_sfcb.sfcb031,l_sfcb.sfcb032,
   #        l_sfcb.sfcb033,l_sfcb.sfcb034,l_sfcb.sfcb035,l_sfcb.sfcb036,l_sfcb.sfcb037,
   #        l_sfcb.sfcb038,l_sfcb.sfcb039,l_sfcb.sfcb040,l_sfcb.sfcb041,l_sfcb.sfcb042,
   #        l_sfcb.sfcb043,l_sfcb.sfcb044,l_sfcb.sfcb045,l_sfcb.sfcb046,l_sfcb.sfcb047,
   #        l_sfcb.sfcb048,l_sfcb.sfcb049,l_sfcb.sfcb050,l_sfcb.sfcb051,l_sfcb.sfcb052,
   #        l_sfcb.sfcb053,l_sfcb.sfcb054,l_sfcb.sfcb055
   #161109-00085#61 --e mark
   #161109-00085#61 --s add
       INTO l_sfcb.sfcbent,l_sfcb.sfcbsite,l_sfcb.sfcbdocno,l_sfcb.sfcb001,l_sfcb.sfcb002,
            l_sfcb.sfcb003,l_sfcb.sfcb004,l_sfcb.sfcb005,l_sfcb.sfcb006,l_sfcb.sfcb007,
            l_sfcb.sfcb008,l_sfcb.sfcb009,l_sfcb.sfcb010,l_sfcb.sfcb011,l_sfcb.sfcb012,
            l_sfcb.sfcb013,l_sfcb.sfcb014,l_sfcb.sfcb015,l_sfcb.sfcb016,l_sfcb.sfcb017,
            l_sfcb.sfcb018,l_sfcb.sfcb019,l_sfcb.sfcb020,l_sfcb.sfcb021,l_sfcb.sfcb022,
            l_sfcb.sfcb023,l_sfcb.sfcb024,l_sfcb.sfcb025,l_sfcb.sfcb026,l_sfcb.sfcb027,
            l_sfcb.sfcb028,l_sfcb.sfcb029,l_sfcb.sfcb030,l_sfcb.sfcb031,l_sfcb.sfcb032,
            l_sfcb.sfcb033,l_sfcb.sfcb034,l_sfcb.sfcb035,l_sfcb.sfcb036,l_sfcb.sfcb037,
            l_sfcb.sfcb038,l_sfcb.sfcb039,l_sfcb.sfcb040,l_sfcb.sfcb041,l_sfcb.sfcb042,
            l_sfcb.sfcb043,l_sfcb.sfcb044,l_sfcb.sfcb045,l_sfcb.sfcb046,l_sfcb.sfcb047,
            l_sfcb.sfcb048,l_sfcb.sfcb049,l_sfcb.sfcb050,l_sfcb.sfcb051,l_sfcb.sfcb052,
            l_sfcb.sfcb053,l_sfcb.sfcb054,l_sfcb.sfcb055,l_sfcb.sfcbud001,l_sfcb.sfcbud002,
            l_sfcb.sfcbud003,l_sfcb.sfcbud004,l_sfcb.sfcbud005,l_sfcb.sfcbud006,l_sfcb.sfcbud007,
            l_sfcb.sfcbud008,l_sfcb.sfcbud009,l_sfcb.sfcbud010,l_sfcb.sfcbud011,l_sfcb.sfcbud012,
            l_sfcb.sfcbud013,l_sfcb.sfcbud014,l_sfcb.sfcbud015,l_sfcb.sfcbud016,l_sfcb.sfcbud017,
            l_sfcb.sfcbud018,l_sfcb.sfcbud019,l_sfcb.sfcbud020,l_sfcb.sfcbud021,l_sfcb.sfcbud022,
            l_sfcb.sfcbud023,l_sfcb.sfcbud024,l_sfcb.sfcbud025,l_sfcb.sfcbud026,l_sfcb.sfcbud027,
            l_sfcb.sfcbud028,l_sfcb.sfcbud029,l_sfcb.sfcbud030
   #161109-00085#61 --e add
   #161109-00085#38-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach s_asft310_confirm_chk_c1'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN
      END IF
      
      #更新所有数量为0
      #更新当站的合并转入数量,及相对应的待xx数量
      #找到当站制程后面的所有项次，反之没找到的项次，将报工项取消勾选（不能直接找到所有前站的项次取消勾选，还有平行的项次、自己本身群组的其他站点都不应该有报工项）

      #INITIALIZE l_sfcb.* TO NULL
      #LET l_sfcb.sfcbent    = g_enterprise   #企業代碼
      #LET l_sfcb.sfcbsite   = g_site         #營運據點
      #LET l_sfcb.sfcbdocno  = g_detail_d[l_i].b_sfcadocno   #單號
      LET l_sfcb.sfcb001	 = l_sfca.sfca001 #RUN CARD
      #LET l_sfcb002 = l_sfcb002 + 1
      #LET l_sfcb.sfcb002	 = l_sfcb002      #項次
      #LET l_sfcb.sfcb003	 = g_detail_d[l_i].b_sfcb003   #本站作業
      #LET l_sfcb.sfcb004	 = g_detail_d[l_i].b_sfcb004   #作業序
      #LET l_sfcb.sfcb005	 =    #群組性質
      #LET l_sfcb.sfcb006	 =    #群組
      #LET l_sfcb.sfcb007	 =    #上站作業
      #LET l_sfcb.sfcb008	 =    #上站作業序
      #LET l_sfcb.sfcb009	 =    #下站作業
      #LET l_sfcb.sfcb010	 =    #下站作業序
      #LET l_sfcb.sfcb011	 =    #工作站
      #LET l_sfcb.sfcb012	 =    #允許委外
      #LET l_sfcb.sfcb013	 =    #主要加工廠
      #LET l_sfcb.sfcb014	 =    #Move in
      #LET l_sfcb.sfcb015	 =    #Check in
      #LET l_sfcb.sfcb016	 =    #報工站
      #LET l_sfcb.sfcb017	 =    #PQC
      #LET l_sfcb.sfcb018	 =    #Check out
      #LET l_sfcb.sfcb019	 =    #Move out
      #LET l_sfcb.sfcb020	 =    #轉出單位
      #LET l_sfcb.sfcb021	 =    #單位轉換率分子
      #LET l_sfcb.sfcb022	 =    #單位轉換率分母
      #LET l_sfcb.sfcb023	 =    #固定工時
      #LET l_sfcb.sfcb024	 =    #標準工時
      #LET l_sfcb.sfcb025	 =    #固定機時
      #LET l_sfcb.sfcb026	 =    #標準機時
      #LET l_sfcb.sfcb027	 =    #標準產出量
      LET l_sfcb.sfcb028	 = 0   #良品轉入
      LET l_sfcb.sfcb029	 = 0   #重工轉入
      LET l_sfcb.sfcb030	 = 0   #回收轉入
      LET l_sfcb.sfcb031	 = 0   #分割轉入
      IF l_sfcb.sfcb003 = g_detail_d[l_main].b_sfcb003 AND l_sfcb.sfcb004 = g_detail_d[l_main].b_sfcb004 THEN
         LET l_sfcb.sfcb032 = l_qty_sum   #合併轉入
         LET l_sfcb.sfcb050 = l_qty_sum   #在製數
      ELSE
         LET l_sfcb.sfcb032 = 0   #合併轉入
         LET l_sfcb.sfcb050 = 0   #在製數
      END IF
      LET l_sfcb.sfcb033	 = 0   #良品轉出
      LET l_sfcb.sfcb034	 = 0   #重工轉出
      LET l_sfcb.sfcb035	 = 0   #回收轉出
      LET l_sfcb.sfcb036	 = 0   #當站報廢
      LET l_sfcb.sfcb037	 = 0   #當站下線
      LET l_sfcb.sfcb038	 = 0   #分割轉出
      LET l_sfcb.sfcb039	 = 0   #合併轉出
      LET l_sfcb.sfcb040	 = 0   #Bonus
      LET l_sfcb.sfcb041	 = 0   #委外加工數?
      LET l_sfcb.sfcb042	 = 0   #委外完工數
      LET l_sfcb.sfcb043	 = 0   #盤點數
      #LET l_sfcb.sfcb044	 =    #預計開工日
      #LET l_sfcb.sfcb045	 =    #預計完工日
      LET l_sfcb.sfcb046    = 0   #待Move in數
      LET l_sfcb.sfcb047    = 0   #待Check in數
      #LET l_sfcb.sfcb050    = 0   #在製數
      LET l_sfcb.sfcb051    = 0   #待PQC數
      LET l_sfcb.sfcb048    = 0   #待Check out數
      LET l_sfcb.sfcb049    = 0   #待Move out數
      #CASE
      #   WHEN l_sfcb.sfcb014 = 'Y'   #Move in
      #        LET l_sfcb.sfcb046 = l_qty_sum   #待Move in數
      #   WHEN l_sfcb.sfcb015 = 'Y'   #Check in
      #        LET l_sfcb.sfcb047 = l_qty_sum   #待Check in數
      #   WHEN l_sfcb.sfcb016 = 'Y'   #報工站
      #        LET l_sfcb.sfcb050 = l_qty_sum   #在製數
      #   WHEN l_sfcb.sfcb017 = 'Y'   #PQC
      #        LET l_sfcb.sfcb051 = l_qty_sum   #待PQC數
      #   WHEN l_sfcb.sfcb018 = 'Y'   #Check out
      #        LET l_sfcb.sfcb048 = l_qty_sum   #待Check out數
      #   WHEN l_sfcb.sfcb019 = 'Y'   #Move out
      #        LET l_sfcb.sfcb049 = l_qty_sum   #待Move out數
      #END CASE
      #LET l_sfcb.sfcb052	 =    #轉入單位
      #LET l_sfcb.sfcb053	 =    #轉入單位轉換率分子
      #LET l_sfcb.sfcb054	 =    #轉入單位轉換率分母
      #LET l_sfcb.sfcb055	 =    #回收站

   #161109-00085#38-s
   #INSERT INTO sfcb_t VALUES(l_sfcb.*)
   #161109-00085#61 --s mark
   #INSERT INTO sfcb_t (sfcbent,sfcbsite,sfcbdocno,sfcb001,sfcb002,sfcb003,sfcb004,sfcb005,sfcb006,sfcb007,
   #                    sfcb008,sfcb009,sfcb010,sfcb011,sfcb012,sfcb013,sfcb014,sfcb015,sfcb016,sfcb017,
   #                    sfcb018,sfcb019,sfcb020,sfcb021,sfcb022,sfcb023,sfcb024,sfcb025,sfcb026,sfcb027,
   #                    sfcb028,sfcb029,sfcb030,sfcb031,sfcb032,sfcb033,sfcb034,sfcb035,sfcb036,sfcb037,
   #                    sfcb038,sfcb039,sfcb040,sfcb041,sfcb042,sfcb043,sfcb044,sfcb045,sfcb046,sfcb047,
   #                    sfcb048,sfcb049,sfcb050,sfcb051,sfcb052,sfcb053,sfcb054,sfcb055)
   #             VALUES(l_sfcb.sfcbent,l_sfcb.sfcbsite,l_sfcb.sfcbdocno,l_sfcb.sfcb001,l_sfcb.sfcb002,
   #                    l_sfcb.sfcb003,l_sfcb.sfcb004,l_sfcb.sfcb005,l_sfcb.sfcb006,l_sfcb.sfcb007,
   #                    l_sfcb.sfcb008,l_sfcb.sfcb009,l_sfcb.sfcb010,l_sfcb.sfcb011,l_sfcb.sfcb012,
   #                    l_sfcb.sfcb013,l_sfcb.sfcb014,l_sfcb.sfcb015,l_sfcb.sfcb016,l_sfcb.sfcb017,
   #                    l_sfcb.sfcb018,l_sfcb.sfcb019,l_sfcb.sfcb020,l_sfcb.sfcb021,l_sfcb.sfcb022,
   #                    l_sfcb.sfcb023,l_sfcb.sfcb024,l_sfcb.sfcb025,l_sfcb.sfcb026,l_sfcb.sfcb027,
   #                    l_sfcb.sfcb028,l_sfcb.sfcb029,l_sfcb.sfcb030,l_sfcb.sfcb031,l_sfcb.sfcb032,
   #                    l_sfcb.sfcb033,l_sfcb.sfcb034,l_sfcb.sfcb035,l_sfcb.sfcb036,l_sfcb.sfcb037,
   #                    l_sfcb.sfcb038,l_sfcb.sfcb039,l_sfcb.sfcb040,l_sfcb.sfcb041,l_sfcb.sfcb042,
   #                    l_sfcb.sfcb043,l_sfcb.sfcb044,l_sfcb.sfcb045,l_sfcb.sfcb046,l_sfcb.sfcb047,
   #                    l_sfcb.sfcb048,l_sfcb.sfcb049,l_sfcb.sfcb050,l_sfcb.sfcb051,l_sfcb.sfcb052,
   #                    l_sfcb.sfcb053,l_sfcb.sfcb054,l_sfcb.sfcb055)
   #161109-00085#61 --e mark
   #161109-00085#38-e
   #161109-00085#61 --s add
   INSERT INTO sfcb_t(sfcbent,sfcbsite,sfcbdocno,sfcb001,sfcb002,
                      sfcb003,sfcb004,sfcb005,sfcb006,sfcb007,
                      sfcb008,sfcb009,sfcb010,sfcb011,sfcb012,
                      sfcb013,sfcb014,sfcb015,sfcb016,sfcb017,
                      sfcb018,sfcb019,sfcb020,sfcb021,sfcb022,
                      sfcb023,sfcb024,sfcb025,sfcb026,sfcb027,
                      sfcb028,sfcb029,sfcb030,sfcb031,sfcb032,
                      sfcb033,sfcb034,sfcb035,sfcb036,sfcb037,
                      sfcb038,sfcb039,sfcb040,sfcb041,sfcb042,
                      sfcb043,sfcb044,sfcb045,sfcb046,sfcb047,
                      sfcb048,sfcb049,sfcb050,sfcb051,sfcb052,
                      sfcb053,sfcb054,sfcb055,sfcbud001,sfcbud002,
                      sfcbud003,sfcbud004,sfcbud005,sfcbud006,sfcbud007,
                      sfcbud008,sfcbud009,sfcbud010,sfcbud011,sfcbud012,
                      sfcbud013,sfcbud014,sfcbud015,sfcbud016,sfcbud017,
                      sfcbud018,sfcbud019,sfcbud020,sfcbud021,sfcbud022,
                      sfcbud023,sfcbud024,sfcbud025,sfcbud026,sfcbud027,
                      sfcbud028,sfcbud029,sfcbud030)
   VALUES(l_sfcb.sfcbent,l_sfcb.sfcbsite,l_sfcb.sfcbdocno,l_sfcb.sfcb001,l_sfcb.sfcb002,
          l_sfcb.sfcb003,l_sfcb.sfcb004,l_sfcb.sfcb005,l_sfcb.sfcb006,l_sfcb.sfcb007,
          l_sfcb.sfcb008,l_sfcb.sfcb009,l_sfcb.sfcb010,l_sfcb.sfcb011,l_sfcb.sfcb012,
          l_sfcb.sfcb013,l_sfcb.sfcb014,l_sfcb.sfcb015,l_sfcb.sfcb016,l_sfcb.sfcb017,
          l_sfcb.sfcb018,l_sfcb.sfcb019,l_sfcb.sfcb020,l_sfcb.sfcb021,l_sfcb.sfcb022,
          l_sfcb.sfcb023,l_sfcb.sfcb024,l_sfcb.sfcb025,l_sfcb.sfcb026,l_sfcb.sfcb027,
          l_sfcb.sfcb028,l_sfcb.sfcb029,l_sfcb.sfcb030,l_sfcb.sfcb031,l_sfcb.sfcb032,
          l_sfcb.sfcb033,l_sfcb.sfcb034,l_sfcb.sfcb035,l_sfcb.sfcb036,l_sfcb.sfcb037,
          l_sfcb.sfcb038,l_sfcb.sfcb039,l_sfcb.sfcb040,l_sfcb.sfcb041,l_sfcb.sfcb042,
          l_sfcb.sfcb043,l_sfcb.sfcb044,l_sfcb.sfcb045,l_sfcb.sfcb046,l_sfcb.sfcb047,
          l_sfcb.sfcb048,l_sfcb.sfcb049,l_sfcb.sfcb050,l_sfcb.sfcb051,l_sfcb.sfcb052,
          l_sfcb.sfcb053,l_sfcb.sfcb054,l_sfcb.sfcb055,l_sfcb.sfcbud001,l_sfcb.sfcbud002,
          l_sfcb.sfcbud003,l_sfcb.sfcbud004,l_sfcb.sfcbud005,l_sfcb.sfcbud006,l_sfcb.sfcbud007,
          l_sfcb.sfcbud008,l_sfcb.sfcbud009,l_sfcb.sfcbud010,l_sfcb.sfcbud011,l_sfcb.sfcbud012,
          l_sfcb.sfcbud013,l_sfcb.sfcbud014,l_sfcb.sfcbud015,l_sfcb.sfcbud016,l_sfcb.sfcbud017,
          l_sfcb.sfcbud018,l_sfcb.sfcbud019,l_sfcb.sfcbud020,l_sfcb.sfcbud021,l_sfcb.sfcbud022,
          l_sfcb.sfcbud023,l_sfcb.sfcbud024,l_sfcb.sfcbud025,l_sfcb.sfcbud026,l_sfcb.sfcbud027,
          l_sfcb.sfcbud028,l_sfcb.sfcbud029,l_sfcb.sfcbud030)
   #161109-00085#61 --e add
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins sfcb_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF
   END FOREACH

   #160825-00059#1  add  --begin--
   #抓出主runcard的工艺多上站资料
   #161109-00085#38-s   
   #LET l_sql = " SELECT * FROM sfcc_t ",
   #LET l_sql = " SELECT sfccent,sfccsite,sfccdocno,sfcc001,sfcc002,sfcc003,sfcc004 ", #161109-00085#61 mark
   #161109-00085#61 --s add
   LET l_sql = "  SELECT sfccent,sfccsite,sfccdocno,sfcc001,sfcc002, ",
               "         sfcc003,sfcc004,sfccud001,sfccud002,sfccud003, ",
               "         sfccud004,sfccud005,sfccud006,sfccud007,sfccud008, ",
               "         sfccud009,sfccud010,sfccud011,sfccud012,sfccud013, ",
               "         sfccud014,sfccud015,sfccud016,sfccud017,sfccud018, ",
               "         sfccud019,sfccud020,sfccud021,sfccud022,sfccud023, ",
               "         sfccud024,sfccud025,sfccud026,sfccud027,sfccud028, ",
               "         sfccud029,sfccud030 ",
   #161109-00085#61 --e add
               "   FROM sfcc_t ",
               "  WHERE sfccent  = ",g_enterprise,
               "    AND sfccdocno='",g_detail_d[l_main].b_sfcadocno,"' ", #工单
               "    AND sfcc001  = ",g_detail_d[l_main].b_sfca001         #RUN CARD
   PREPARE asfp302_combine_p2 FROM l_sql
   DECLARE asfp302_combine_c2 CURSOR FOR asfp302_combine_p2
   #FOREACH asfp302_combine_c2 INTO l_sfcc.* 
   FOREACH asfp302_combine_c2 
   #161109-00085#61 --s mark
   #   INTO l_sfcc.sfccent,l_sfcc.sfccsite,l_sfcc.sfccdocno,l_sfcc.sfcc001,l_sfcc.sfcc002,
   #        l_sfcc.sfcc003,l_sfcc.sfcc004
   #161109-00085#61 --e mark
   #161109-00085#61 --s add
       INTO l_sfcc.sfccent,l_sfcc.sfccsite,l_sfcc.sfccdocno,l_sfcc.sfcc001,l_sfcc.sfcc002,
            l_sfcc.sfcc003,l_sfcc.sfcc004,l_sfcc.sfccud001,l_sfcc.sfccud002,l_sfcc.sfccud003,
            l_sfcc.sfccud004,l_sfcc.sfccud005,l_sfcc.sfccud006,l_sfcc.sfccud007,l_sfcc.sfccud008,
            l_sfcc.sfccud009,l_sfcc.sfccud010,l_sfcc.sfccud011,l_sfcc.sfccud012,l_sfcc.sfccud013,
            l_sfcc.sfccud014,l_sfcc.sfccud015,l_sfcc.sfccud016,l_sfcc.sfccud017,l_sfcc.sfccud018,
            l_sfcc.sfccud019,l_sfcc.sfccud020,l_sfcc.sfccud021,l_sfcc.sfccud022,l_sfcc.sfccud023,
            l_sfcc.sfccud024,l_sfcc.sfccud025,l_sfcc.sfccud026,l_sfcc.sfccud027,l_sfcc.sfccud028,
            l_sfcc.sfccud029,l_sfcc.sfccud030
   #161109-00085#61 --e add
   #161109-00085#38-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach s_asft310_confirm_chk_c2'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN
      END IF
      LET l_sfcc.sfcc001         = l_sfca.sfca001 #RUN CARD
      #161109-00085#38-s
      #INSERT INTO sfcc_t VALUES l_sfcc.*
      #161109-00085#61 --s mark
      #INSERT INTO sfcc_t (sfccent,sfccsite,sfccdocno,sfcc001,sfcc002,sfcc003,sfcc004)
      #            VALUES (l_sfcc.sfccent,l_sfcc.sfccsite,l_sfcc.sfccdocno,l_sfcc.sfcc001,l_sfcc.sfcc002,
      #                    l_sfcc.sfcc003,l_sfcc.sfcc004)
      #161109-00085#61 --e mark
      #161109-00085#61 --s add
      INSERT INTO sfcc_t(sfccent,sfccsite,sfccdocno,sfcc001,sfcc002,
                         sfcc003,sfcc004,sfccud001,sfccud002,sfccud003,
                         sfccud004,sfccud005,sfccud006,sfccud007,sfccud008,
                         sfccud009,sfccud010,sfccud011,sfccud012,sfccud013,
                         sfccud014,sfccud015,sfccud016,sfccud017,sfccud018,
                         sfccud019,sfccud020,sfccud021,sfccud022,sfccud023,
                         sfccud024,sfccud025,sfccud026,sfccud027,sfccud028,
                         sfccud029,sfccud030)
      VALUES (l_sfcc.sfccent,l_sfcc.sfccsite,l_sfcc.sfccdocno,l_sfcc.sfcc001,l_sfcc.sfcc002,
              l_sfcc.sfcc003,l_sfcc.sfcc004,l_sfcc.sfccud001,l_sfcc.sfccud002,l_sfcc.sfccud003,
              l_sfcc.sfccud004,l_sfcc.sfccud005,l_sfcc.sfccud006,l_sfcc.sfccud007,l_sfcc.sfccud008,
              l_sfcc.sfccud009,l_sfcc.sfccud010,l_sfcc.sfccud011,l_sfcc.sfccud012,l_sfcc.sfccud013,
              l_sfcc.sfccud014,l_sfcc.sfccud015,l_sfcc.sfccud016,l_sfcc.sfccud017,l_sfcc.sfccud018,
              l_sfcc.sfccud019,l_sfcc.sfccud020,l_sfcc.sfccud021,l_sfcc.sfccud022,l_sfcc.sfccud023,
              l_sfcc.sfccud024,l_sfcc.sfccud025,l_sfcc.sfccud026,l_sfcc.sfccud027,l_sfcc.sfccud028,
              l_sfcc.sfccud029,l_sfcc.sfccud030)
      #161109-00085#61 --e add
      #161109-00085#38-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins sfcc_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF
   END FOREACH
   
   #161126-00005#1 add--s 注意，需要先产生sfcc的资料
   #上下站标准转出量处理
   CALL asfp302_01_deal_sfcb027('cn',l_sfca.sfcadocno,l_sfca.sfca001,g_detail_d[l_main].b_sfcb003,g_detail_d[l_main].b_sfcb004,l_qty_sum)
      RETURNING l_success
   IF NOT l_success THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #161126-00005#1 add--e
   
   #抓出主runcard的工艺多上站资料
   #161109-00085#38-s
   #LET l_sql = " SELECT * FROM sfcd_t ",
   #161109-00085#61 --s mark
   #LET l_sql = " SELECT sfcdent,sfcdsite,sfcddocno,sfcd001,sfcd002,sfcd003,sfcd004,sfcd005,sfcd006,sfcd007, ",
   #            "        sfcd008,sfcd009 ",
   #161109-00085#61 --e mark
   #161109-00085#61 --s add
   LET l_sql = " SELECT sfcdent,sfcdsite,sfcddocno,sfcd001,sfcd002, ",
               "        sfcd003,sfcd004,sfcd005,sfcd006,sfcd007, ",
               "        sfcd008,sfcd009,sfcdud001,sfcdud002,sfcdud003, ",
               "        sfcdud004,sfcdud005,sfcdud006,sfcdud007,sfcdud008, ",
               "        sfcdud009,sfcdud010,sfcdud011,sfcdud012,sfcdud013, ",
               "        sfcdud014,sfcdud015,sfcdud016,sfcdud017,sfcdud018, ",
               "        sfcdud019,sfcdud020,sfcdud021,sfcdud022,sfcdud023, ",
               "        sfcdud024,sfcdud025,sfcdud026,sfcdud027,sfcdud028, ",
               "        sfcdud029,sfcdud030 ",
   #161109-00085#61 --e add
               "   FROM sfcd_t ",
               "  WHERE sfcdent  = ",g_enterprise,
               "    AND sfcddocno='",g_detail_d[l_main].b_sfcadocno,"' ", #工单
               "    AND sfcd001  = ",g_detail_d[l_main].b_sfca001         #RUN CARD
   PREPARE asfp302_combine_p3 FROM l_sql
   DECLARE asfp302_combine_c3 CURSOR FOR asfp302_combine_p3
   #FOREACH asfp302_combine_c3 INTO l_sfcd.*
   FOREACH asfp302_combine_c3 
   #161109-00085#61 --s mark
   #   INTO l_sfcd.sfcdent,l_sfcd.sfcdsite,l_sfcd.sfcddocno,l_sfcd.sfcd001,l_sfcd.sfcd002,
   #        l_sfcd.sfcd003,l_sfcd.sfcd004,l_sfcd.sfcd005,l_sfcd.sfcd006,l_sfcd.sfcd007,
   #        l_sfcd.sfcd008,l_sfcd.sfcd009
   #161109-00085#61 --e mark
   #161109-00085#61 --s add
       INTO l_sfcd.sfcdent,l_sfcd.sfcdsite,l_sfcd.sfcddocno,l_sfcd.sfcd001,l_sfcd.sfcd002,
            l_sfcd.sfcd003,l_sfcd.sfcd004,l_sfcd.sfcd005,l_sfcd.sfcd006,l_sfcd.sfcd007,
            l_sfcd.sfcd008,l_sfcd.sfcd009,l_sfcd.sfcdud001,l_sfcd.sfcdud002,l_sfcd.sfcdud003,
            l_sfcd.sfcdud004,l_sfcd.sfcdud005,l_sfcd.sfcdud006,l_sfcd.sfcdud007,l_sfcd.sfcdud008,
            l_sfcd.sfcdud009,l_sfcd.sfcdud010,l_sfcd.sfcdud011,l_sfcd.sfcdud012,l_sfcd.sfcdud013,
            l_sfcd.sfcdud014,l_sfcd.sfcdud015,l_sfcd.sfcdud016,l_sfcd.sfcdud017,l_sfcd.sfcdud018,
            l_sfcd.sfcdud019,l_sfcd.sfcdud020,l_sfcd.sfcdud021,l_sfcd.sfcdud022,l_sfcd.sfcdud023,
            l_sfcd.sfcdud024,l_sfcd.sfcdud025,l_sfcd.sfcdud026,l_sfcd.sfcdud027,l_sfcd.sfcdud028,
            l_sfcd.sfcdud029,l_sfcd.sfcdud030
   #161109-00085#61 --e add
   #161109-00085#38-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach s_asft310_confirm_chk_c3'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN
      END IF
      LET l_sfcd.sfcd001         = l_sfca.sfca001 #RUN CARD
      #161109-00085#38-s
      #INSERT INTO sfcd_t VALUES l_sfcd.*
      #161109-00085#61 --s mark
      #INSERT INTO sfcd_t (sfcdent,sfcdsite,sfcddocno,sfcd001,sfcd002,sfcd003,sfcd004,sfcd005,sfcd006,sfcd007,
      #                    sfcd008,sfcd009)
      #            VALUES (l_sfcd.sfcdent,l_sfcd.sfcdsite,l_sfcd.sfcddocno,l_sfcd.sfcd001,l_sfcd.sfcd002,
      #                    l_sfcd.sfcd003,l_sfcd.sfcd004,l_sfcd.sfcd005,l_sfcd.sfcd006,l_sfcd.sfcd007,
      #                    l_sfcd.sfcd008,l_sfcd.sfcd009)
      #161109-00085#61 --e mark
      #161109-00085#38-e
      #161109-00085#61 --s add
      INSERT INTO sfcd_t(sfcdent,sfcdsite,sfcddocno,sfcd001,sfcd002,
                         sfcd003,sfcd004,sfcd005,sfcd006,sfcd007,
                         sfcd008,sfcd009,sfcdud001,sfcdud002,sfcdud003,
                         sfcdud004,sfcdud005,sfcdud006,sfcdud007,sfcdud008,
                         sfcdud009,sfcdud010,sfcdud011,sfcdud012,sfcdud013,
                         sfcdud014,sfcdud015,sfcdud016,sfcdud017,sfcdud018,
                         sfcdud019,sfcdud020,sfcdud021,sfcdud022,sfcdud023,
                         sfcdud024,sfcdud025,sfcdud026,sfcdud027,sfcdud028,
                         sfcdud029,sfcdud030)
      VALUES (l_sfcd.sfcdent,l_sfcd.sfcdsite,l_sfcd.sfcddocno,l_sfcd.sfcd001,l_sfcd.sfcd002,
              l_sfcd.sfcd003,l_sfcd.sfcd004,l_sfcd.sfcd005,l_sfcd.sfcd006,l_sfcd.sfcd007,
              l_sfcd.sfcd008,l_sfcd.sfcd009,l_sfcd.sfcdud001,l_sfcd.sfcdud002,l_sfcd.sfcdud003,
              l_sfcd.sfcdud004,l_sfcd.sfcdud005,l_sfcd.sfcdud006,l_sfcd.sfcdud007,l_sfcd.sfcdud008,
              l_sfcd.sfcdud009,l_sfcd.sfcdud010,l_sfcd.sfcdud011,l_sfcd.sfcdud012,l_sfcd.sfcdud013,
              l_sfcd.sfcdud014,l_sfcd.sfcdud015,l_sfcd.sfcdud016,l_sfcd.sfcdud017,l_sfcd.sfcdud018,
              l_sfcd.sfcdud019,l_sfcd.sfcdud020,l_sfcd.sfcdud021,l_sfcd.sfcdud022,l_sfcd.sfcdud023,
              l_sfcd.sfcdud024,l_sfcd.sfcdud025,l_sfcd.sfcdud026,l_sfcd.sfcdud027,l_sfcd.sfcdud028,
              l_sfcd.sfcdud029,l_sfcd.sfcdud030)
      #161109-00085#61 --e add
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins sfcd_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF
   END FOREACH
   #160825-00059#1  add  --end--

   #执行成功
   INITIALIZE g_errparam TO NULL
   LET g_errparam.code = 'adz-00217'
   LET g_errparam.extend = ''
   LET g_errparam.popup = TRUE
   CALL cl_err()

   CALL s_transaction_end('Y','0')
   
   CALL asfp302_b_fill()
END FUNCTION
#根据群组前的站点往后找群组中各线路的首站报工类别，若是之前找出来的那个站点的那条线路略过
PRIVATE FUNCTION asfp302_upd_group_f_station(p_sfcadocno,p_sfca001,p_sfcb005,p_sfcb006,p_sfcb003,p_sfcb004,p_sfcb007,p_sfcb008)
DEFINE p_sfcadocno     LIKE sfca_t.sfcadocno #工单
DEFINE p_sfca001       LIKE sfca_t.sfca001   #RUNCARD
DEFINE p_sfcb005       LIKE sfcb_t.sfcb005   #群组性质
DEFINE p_sfcb006       LIKE sfcb_t.sfcb006   #群组编号 
DEFINE p_sfcb003       LIKE sfcb_t.sfcb003   #排除的首站作业  
DEFINE p_sfcb004       LIKE sfcb_t.sfcb004   #排除的首站作业序
DEFINE p_sfcb007       LIKE sfcb_t.sfcb007   #群组前的作业
DEFINE p_sfcb008       LIKE sfcb_t.sfcb008   #群组前的作业序
DEFINE l_sql STRING
     
#   LET l_sql = "SELECT * FROM sfcb_t ",
#               " WHERE "
#
END FUNCTION
#拆分前检查
PRIVATE FUNCTION asfp302_split_chk()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_i         LIKE type_t.num5
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_sfaastus  LIKE sfaa_t.sfaastus
   
   LET r_success = TRUE

   LET l_cnt = 0
   FOR l_i = 1 TO g_detail_cnt
       IF g_detail_d[l_i].sel = 'Y' THEN
          #若所選項目有多筆，不可執行拆分
          LET l_cnt = l_cnt + 1
          IF l_cnt > 1 THEN
             #待拆分RUNCARD一次不可选择多笔，不可拆分！请指定一笔需拆分的RUNCARD！
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'asf-00272'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             LET r_success = FALSE
             RETURN r_success
          END IF
          
          #工单未结案  单身显示时已筛选了，防止期间有人再做了结案动作
          SELECT sfaastus INTO l_sfaastus
            FROM sfaa_t
           WHERE sfaaent   = g_enterprise
             AND sfaadocno = g_detail_d[l_i].b_sfcadocno
          IF l_sfaastus MATCHES '[CEM]' THEN 
             #工单已结案，不可异动
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'asf-00264'
             LET g_errparam.extend = g_detail_d[l_i].b_sfcadocno
             LET g_errparam.popup = TRUE
             CALL cl_err()

             LET r_success = FALSE
             RETURN r_success
          END IF
          
          #检查本次异动数量
          IF cl_null(g_detail_d[l_i].issue_qty) THEN 
             #异动量不可为空，请输入
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'asf-00282'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             LET r_success = FALSE
             RETURN r_success
          END IF
          IF g_detail_d[l_i].issue_qty = 0 THEN
             #待拆分数量为0，无需拆分！请确认
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'asf-00275'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             LET r_success = FALSE
             RETURN r_success
          END IF
          IF g_detail_d[l_i].issue_qty < 0 THEN
             #数量不可小于0，请重新录入
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'agl-00041'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             LET r_success = FALSE
             RETURN r_success
          END IF
          IF g_detail_d[l_i].issue_qty > g_detail_d[l_i].wip_qty THEN
             #异动量不可大于在制量，请重新输入
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'asf-00252'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             LET r_success = FALSE
             RETURN r_success
          END IF
   
       END IF
   END FOR
   #有且仅有一笔待处理项
   IF l_cnt = 0 THEN
      #未选择待拆分RUNCARD，不可拆分！请指定一笔待拆分的RUNCARD！
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00271'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
