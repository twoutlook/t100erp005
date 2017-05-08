#該程式未解開Section, 採用最新樣板產出!
{<section id="adbp501.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2015-03-09 11:15:14), PR版次:0005(2017-01-18 10:39:53)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000090
#+ Filename...: adbp501
#+ Description: 促銷產品分配轉訂單批次處理作業
#+ Creator....: 04226(2014-07-29 10:15:46)
#+ Modifier...: 06137 -SD/PR- 06814
 
{</section>}
 
{<section id="adbp501.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161006-00008#5     2016/10/18  by  08729  處理組織開窗
#170109-00037#2     2017/01/16  by  06814  批次LOCK處理1.UI勾選LOCK檢查
#                                                     2.資料處理LOCK
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
     prcmdocno       LIKE prcm_t.prcmdocno,
     prcnseq         LIKE prcn_t.prcnseq,
     prcn004         LIKE prcn_t.prcn004,
     prcn004_desc    LIKE pmaal_t.pmaal004,
     prcn005         LIKE prcn_t.prcn005,
     prcn005_desc    LIKE pmaal_t.pmaal004,
     prcn018         LIKE prcn_t.prcn018,
     prcn010         LIKE prcn_t.prcn010,
     prcn010_desc    LIKE imaal_t.imaal003,
     prcn011         LIKE prcn_t.prcn011,
     prcn011_desc    LIKE oocal_t.oocal003,
     prcn013         LIKE prcn_t.prcn013,
     xmja013         LIKE xmja_t.xmja013,
     xmja013_desc    LIKE oocal_t.oocal003,
     xmja014         LIKE xmja_t.xmja014,
     xmja031         LIKE xmja_t.xmja031,
     prcn006         LIKE prcn_t.prcn006,
     prcn006_desc    LIKE dbbcl_t.dbbcl003,
     prcn007         LIKE prcn_t.prcn007,
     prcn007_desc    LIKE oojdl_t.oojdl003,
     prcn008         LIKE prcn_t.prcn008,
     prcn008_desc    LIKE ooefl_t.ooefl003,
     prcn009         LIKE prcn_t.prcn009,
     prcn009_desc    LIKE dbbal_t.dbbal003
                     END RECORD
DEFINE g_detail_d_t  type_g_detail_d
DEFINE g_detail_d_o  type_g_detail_d
DEFINE g_docslip     LIKE type_t.chr10
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
 
#end add-point
 
{</section>}
 
{<section id="adbp501.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
   #add-point:main段define name="main.define"
   DEFINE l_success     LIKE type_t.num5
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
      OPEN WINDOW w_adbp501 WITH FORM cl_ap_formpath("adb",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adbp501_init()   
 
      #進入選單 Menu (="N")
      CALL adbp501_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_adbp501
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   CALL s_adbp520_drop_temp_table() RETURNING l_success
   CALL s_aooi500_drop_temp() RETURNING l_success #150308-00001#1  By Ken 150309   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="adbp501.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION adbp501_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   DEFINE l_success      LIKE type_t.num5
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_adbp501_create_temp_table() RETURNING l_success 
   CALL s_aooi500_create_temp() RETURNING l_success #150308-00001#1  By Ken 150309   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="adbp501.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION adbp501_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_cons     RECORD
          prcmsite   STRING,
          prcmdocdt  STRING,
          prcmdocno  STRING,
          prcm003    STRING,
          prcm004    STRING,
          prcm001    STRING,
          prcm002    STRING,
          prcn006    STRING,
          prcn007    STRING,
          prcn009    STRING,
          prcn008    STRING            
                     END RECORD
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_str       STRING
   DEFINE la_param    RECORD
             prog     STRING,
             param    DYNAMIC ARRAY OF STRING
                      END RECORD
   DEFINE ls_js       STRING
   DEFINE l_xmdadocno LIKE xmda_t.xmdadocno
   DEFINE l_xmdadocdt LIKE xmda_t.xmdadocdt
   DEFINE l_msg       LIKE type_t.chr100
   #170109-00037#2 20170116 add by beckxie---S
   DEFINE l_i         LIKE type_t.num10      
   DEFINE l_prcmdocno LIKE prcm_t.prcmdocno  
   DEFINE l_prcnseq   LIKE prcn_t.prcnseq    
   DEFINE l_lock_flag LIKE type_t.chr1
   #170109-00037#2 20170116 add by beckxie---E
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
#mark by benson
#   CALL s_arti200_get_def_doc_type(g_site,'adbt500','2')
#    RETURNING l_success,g_docslip
#   IF NOT l_success OR cl_null(g_docslip) THEN   
#      LET l_msg = ''
#      SELECT gzzal003 INTO l_msg FROM gzzal_t
#       WHERE gzzal001 = 'adbt500'
#         AND gzzal002 = g_lang         
#      LET l_msg = l_msg CLIPPED,'adbt500'
#
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.replace[1] = l_msg       
#      LET g_errparam.code = 'adb-00406'
#      LET g_errparam.extend = ''
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#      RETURN
#   END IF
   #170109-00037#2 20170116 add by beckxie---S
   LET g_sql = "SELECT prcndocno,prcnseq FROM prcn_t ",
               " WHERE prcnent = ",g_enterprise,
               "   AND prcndocno = ? ",
               "   AND prcnseq = ? ",
               "   FOR UPDATE SKIP LOCKED "
   PREPARE adbp501_chk_lock_prcn FROM g_sql 
   #170109-00037#2 20170116 add by beckxie---E
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL adbp501_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc ON prcmsite,prcmdocdt,prcmdocno,prcm003,prcm004,
                                   prcm001, prcm002,  prcn006,  prcn007,prcn009,
                                   prcn008
            BEFORE CONSTRUCT
               CALL cl_set_act_visible("filter",FALSE)
               
            ON ACTION controlp
               CASE
                  WHEN INFIELD(prcmsite)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     LET g_qryparam.where = s_aooi500_q_where(g_prog,'prcmsite',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
                     CALL q_ooef001_24()
                     DISPLAY g_qryparam.return1 TO prcmsite
                     NEXT FIELD CURRENT
                     
                  WHEN INFIELD(prcmdocno)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     CALL q_prcmdocno_1()
                     DISPLAY g_qryparam.return1 TO prcmdocno
                     NEXT FIELD CURRENT
                     
                  WHEN INFIELD(prcm003)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     CALL q_ooag001_6()
                     DISPLAY g_qryparam.return1 TO prcm003
                     NEXT FIELD CURRENT
                     
                  WHEN INFIELD(prcm004)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     LET g_qryparam.arg1 = g_today
                     CALL q_ooeg001_4()
                     DISPLAY g_qryparam.return1 TO prcm004
                     NEXT FIELD CURRENT
                     
                  WHEN INFIELD(prcm001)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     LET g_qryparam.arg1 = '2'
                     CALL q_prcf001_2()
                     DISPLAY g_qryparam.return1 TO prcm001
                     NEXT FIELD CURRENT
                  
                  WHEN INFIELD(prcm002)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     LET g_qryparam.arg1 = '2'
                     CALL q_prcd001_1()
                     DISPLAY g_qryparam.return1 TO prcm002
                     NEXT FIELD CURRENT
                     
                  WHEN INFIELD(prcn006)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     CALL q_dbbc001_1()
                     DISPLAY g_qryparam.return1 TO prcn006
                     NEXT FIELD CURRENT

                  WHEN INFIELD(prcn007)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     LET g_qryparam.arg1 = '1'   #銷售渠道(通路)
                     CALL q_oojd001_1()
                     DISPLAY g_qryparam.return1 TO prcn007
                     NEXT FIELD CURRENT
                  
                  WHEN INFIELD(prcn009)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     CALL q_dbba001()
                     DISPLAY g_qryparam.return1 TO prcn009
                     NEXT FIELD CURRENT
                     
                  WHEN INFIELD(prcn008)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     #LET g_qryparam.arg1 = 'G'   #161006-00008#5 mark
                     #161006-00008#5-add(s)
                     IF s_aooi500_setpoint(g_prog,'prcn008') THEN
                        LET g_qryparam.where = s_aooi500_q_where(g_prog,'prcn008',g_site,'c')
                        CALL q_ooef001_24()                   
                     ELSE
                        LET g_qryparam.where = "ooef305 = 'Y' "
                        CALL q_ooef001()
                     END IF
                     #161006-00008#5-add(e)
                     #CALL q_ooef001_3()    #161006-00008#5 mark
                     DISPLAY g_qryparam.return1 TO prcn008
                     NEXT FIELD CURRENT
               END CASE
               
            AFTER CONSTRUCT
               LET l_cons.prcmsite  = GET_FLDBUF(prcmsite)
               LET l_cons.prcmdocdt = GET_FLDBUF(prcmdocdt)
               LET l_cons.prcmdocno = GET_FLDBUF(prcmdocno)
               LET l_cons.prcm003   = GET_FLDBUF(prcm003)
               LET l_cons.prcm004   = GET_FLDBUF(prcm004)
               LET l_cons.prcm001   = GET_FLDBUF(prcm001)
               LET l_cons.prcm002   = GET_FLDBUF(prcm002)
               LET l_cons.prcn006   = GET_FLDBUF(prcn006)
               LET l_cons.prcn007   = GET_FLDBUF(prcn007)
               LET l_cons.prcn009   = GET_FLDBUF(prcn009)
               LET l_cons.prcn008   = GET_FLDBUF(prcn008)
                 
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT ARRAY g_detail_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                     INSERT ROW = FALSE,DELETE ROW = FALSE, APPEND ROW = FALSE)
            BEFORE INPUT
               CALL cl_set_act_visible("filter",FALSE)
               
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_master_idx = l_ac
               LET g_detail_d_t.* = g_detail_d[l_ac].*
               LET g_detail_d_o.* = g_detail_d[l_ac].*
               DISPLAY l_ac TO FORMONLY.h_index
               CALL adbp501_set_entry_b()
               CALL adbp501_set_no_entry_b()
               IF g_detail_d[l_ac].sel = 'N' THEN
                  NEXT FIELD b_sel
               END IF
               
            AFTER FIELD b_sel
               #N->Y(勾選)
               IF g_detail_d_o.sel = 'N' AND g_detail_d[l_ac].sel = 'Y' THEN
                  LET g_detail_d[l_ac].xmja031 = g_today
               END IF
               #Y->(取消勾選)
               IF g_detail_d_o.sel = 'Y' AND g_detail_d[l_ac].sel = 'N' THEN
                  LET g_detail_d[l_ac].xmja031 = ''
               END IF
               CALL cl_err_collect_init()   #170109-00037#2 20170116 add by beckxie
               CALL adbp501_upd_s_adbp501_temp1(l_ac)
               CALL cl_err_collect_show()   #170109-00037#2 20170116 add by beckxie
               LET g_detail_d_o.sel = g_detail_d[l_ac].sel
               CALL adbp501_set_entry_b()
               CALL adbp501_set_no_entry_b()
            
            ON CHANGE b_sel
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               CALL cl_err_collect_init()   #170109-00037#2 20170116 add by beckxie
               CALL adbp501_upd_s_adbp501_temp1(l_ac)
               CALL adbp501_set_entry_b()
               CALL cl_err_collect_show()   #170109-00037#2 20170116 add by beckxie
            
            ON ROW CHANGE
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               CALL cl_err_collect_init()   #170109-00037#2 20170116 add by beckxie
               CALL adbp501_upd_s_adbp501_temp1(l_ac)
               CALL cl_err_collect_show()   #170109-00037#2 20170116 add by beckxie
            
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
            
            DISPLAY l_cons.prcmsite  TO prcmsite
            DISPLAY l_cons.prcmdocdt TO prcmdocdt
            DISPLAY l_cons.prcmdocno TO prcmdocno
            DISPLAY l_cons.prcm003   TO prcm003
            DISPLAY l_cons.prcm004   TO prcm004
            DISPLAY l_cons.prcm001   TO prcm001
            DISPLAY l_cons.prcm002   TO prcm002
            DISPLAY l_cons.prcn006   TO prcn006
            DISPLAY l_cons.prcn007   TO prcn007
            DISPLAY l_cons.prcn009   TO prcn009
            DISPLAY l_cons.prcn008   TO prcn008

            NEXT FIELD prcmsite
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            CALL cl_err_collect_init()   #170109-00037#2 20170116 add by beckxie
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
               IF cl_null(g_detail_d[li_idx].xmja031) THEN
                  LET g_detail_d[li_idx].xmja031 = g_today
               END IF
               CALL adbp501_upd_s_adbp501_temp1(li_idx)
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            CALL cl_err_collect_show()   #170109-00037#2 20170116 add by beckxie
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone name="ui_dialog.for.onaction_selnone"
               #LET g_detail_d[l_ac].xmja031 = ''   #170109-00037#2 20170116 mark by beckxie
               LET g_detail_d[li_idx].xmja031 = ''   #170109-00037#2 20170116 add by beckxie
               CALL adbp501_upd_s_adbp501_temp1(li_idx)
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
            CALL cl_err_collect_init()   #170109-00037#2 20170116 add by beckxie
            LET l_ac = DIALOG.getCurrentRow("s_detail1")
            IF l_ac > 0 THEN
               CALL adbp501_upd_s_adbp501_temp1(l_ac)
               DISPLAY BY NAME g_detail_d[l_ac].sel
            END IF
            CALL cl_err_collect_show()   #170109-00037#2 20170116 add by beckxie
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
               CALL adbp501_upd_s_adbp501_temp1(l_ac)
               DISPLAY BY NAME g_detail_d[l_ac].sel
            END IF
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL adbp501_filter()
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
            CALL adbp501_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL adbp501_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute 
            #160225-00040#18 2016/04/13 s983961--add(s)
            IF g_bgjob <> "Y" THEN
               CALL cl_progress_bar_no_window(5)
            END IF   
            #160225-00040#18 2016/04/13 s983961--add(e)
            IF l_ac > 0 THEN
               IF NOT adbp501_chk_data() THEN
                  CONTINUE DIALOG
               END IF
            END IF
            
            #170109-00037#2 20170116 add by beckxie---S
            CALL s_transaction_begin()
            CALL cl_err_collect_init()
            #資料處理LOCK
            LET l_lock_flag = 'N'
            FOR l_i=1 TO g_detail_d.getlength()
               IF g_detail_d[l_i].sel = 'Y' THEN
                  LET l_prcmdocno = ''
                  LET l_prcnseq = ''
                  EXECUTE adbp501_chk_lock_prcn USING g_detail_d[l_i].prcmdocno,g_detail_d[l_i].prcnseq
                                                INTO l_prcmdocno,l_prcnseq
                  IF cl_null(l_prcmdocno) OR cl_null(l_prcnseq) THEN
                     LET g_detail_d[l_i].sel = 'N'
                     LET g_detail_d[l_i].xmja031 = ''
                     LET l_lock_flag = 'Y'
                     
                    
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'apm-01117'
                     LET g_errparam.replace[1] = g_detail_d[l_i].prcmdocno
                     LET g_errparam.replace[2] = g_detail_d[l_i].prcnseq
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
         
                     UPDATE s_adbp501_temp1
                        SET sel = g_detail_d[l_i].sel,
                            xmja031 = g_detail_d[l_i].xmja031
                      WHERE prcment = g_enterprise
                        AND prcmdocno = g_detail_d[l_i].prcmdocno
                        AND prcnseq = g_detail_d[l_i].prcnseq
                      IF SQLCA.SQLCODE THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = "UPDATE s_adbp501_temp1:" 
                         LET g_errparam.code = SQLCA.SQLCODE 
                         LET g_errparam.popup = TRUE 
                         CALL cl_err()
                      END IF
                  END IF
               END IF 
            END FOR
            #170109-00037#2 20170116 add by beckxie---E
            
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt
              FROM s_adbp501_temp1
             WHERE sel = 'Y'
            IF l_cnt > 0 THEN
               #160225-00040#18 2016/04/13 s983961--add(s)
               LET l_msg = cl_getmsg('ade-00114',g_lang)   
               CALL cl_progress_no_window_ing(l_msg)
               #160225-00040#18 2016/04/13 s983961--add(e)
               #CALL s_transaction_begin()   #170109-00037#2 20170116 mark by beckxie
               DELETE FROM s_adbp501_temp1 
                WHERE sel = 'N'
               
               LET l_success = ''
               CALL s_adbp501_input() RETURNING l_success,l_xmdadocno,l_xmdadocdt
               IF l_success THEN
                  #CALL cl_err_collect_init()   #170109-00037#2 20170116 mark by beckxie
                  #160225-00040#18 2016/04/13 s983961--add(s)
                  LET l_msg = cl_getmsg('ast-00330',g_lang)   
                  CALL cl_progress_no_window_ing(l_msg)
                  #160225-00040#18 2016/04/13 s983961--add(e)
                  CALL s_adbp501(l_xmdadocdt) RETURNING l_success,l_str
                  IF l_success THEN
                     CALL s_transaction_end('Y','1')
                  
                     LET la_param.prog = 'adbt500'
                     LET la_param.param[1] = ''
                     LET la_param.param[2] = l_str
                     LET ls_js = util.JSON.stringify(la_param)
                     #lori522612  150115  add ----------------------(S)
                     #CALL cl_cmdrun_wait(ls_js)
                     CALL cl_cmdrun(ls_js)
                     #lori522612  150115  add ----------------------(E)
                  ELSE
                     CALL s_transaction_end('N','1')
                  END IF
                  CALL cl_err_collect_show()
                  DELETE FROM s_adbp501_temp2
                  CALL adbp501_b_fill()
               END IF
            ELSE
               INITIALIZE g_errparam TO NULL
               #170109-00037#2 20170116 add by beckxie---S
               IF l_lock_flag THEN
                  LET g_errparam.code = 'ast-00867'
               ELSE
               #170109-00037#2 20170116 add by beckxie---E
                  LET g_errparam.code = 'adb-00078'
               END IF   #170109-00037#2 20170116 add by beckxie
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               #160225-00040#18 2016/04/13 s983961--add(s)
               LET l_msg = cl_getmsg('ade-00114',g_lang)   
               CALL cl_progress_no_window_ing(l_msg)

               LET l_msg = cl_getmsg('ast-00330',g_lang)   
               CALL cl_progress_no_window_ing(l_msg)

               LET l_msg = cl_getmsg('ast-00330',g_lang)   
               CALL cl_progress_no_window_ing(l_msg)

               LET l_msg = cl_getmsg('ast-00330',g_lang)   
               CALL cl_progress_no_window_ing(l_msg)
               #160225-00040#18 2016/04/13 s983961--add(e)
               CALL s_transaction_end('N','1')   #170109-00037#2 20170116 add by beckxie
               CALL cl_err_collect_show()   #170109-00037#2 20170116 add by beckxie
               CONTINUE DIALOG
            END IF
            
            #160225-00040#18 2016/04/13 s983961--add(s)
            LET l_msg = cl_getmsg('std-00012',g_lang)
            CALL cl_progress_no_window_ing(l_msg)  
            #CALL cl_err_collect_show()      #170109-00037#2 20170116 mark by beckxie
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
 
{<section id="adbp501.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION adbp501_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   DELETE FROM s_adbp501_temp2

   INSERT INTO s_adbp501_temp2
        SELECT sel,prcment,prcmdocno,prcnseq,prcn004,
               prcn005,prcn018,prcn010,prcn011,prcn013,
               xmja031,prcn006,prcn007,prcn008,prcn009
          FROM s_adbp501_temp1
   #end add-point
        
   LET g_error_show = 1
   CALL adbp501_b_fill()
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
 
{<section id="adbp501.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adbp501_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_xmja031       LIKE xmja_t.xmja031
   DEFINE l_where         STRING
   DEFINE l_xmja014       LIKE xmja_t.xmja014
   DEFINE l_success       LIKE xmja_t.xmja014
   DEFINE l_slip_where     STRING
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   DELETE FROM s_adbp501_temp1
   LET l_where = s_aooi500_sql_where(g_prog,"prcmsite")
   LET l_slip_where = s_arti200_sql_where('2','adbt500','prcmsite')
   IF NOT cl_null(l_slip_where) THEN
      LET l_where = l_where CLIPPED," AND ",l_slip_where
   END IF
   LET g_sql = "SELECT 'N',     prcmdocno, prcnseq, prcn004, '',",
               "       prcn005, '',        prcn018, prcn010, '',",
               "       prcn011, '',        prcn013, '',     '',",
               "            '', '',        prcn006,",
               "       '',      prcn007,   '',      prcn008, '',",
               "       prcn009, ''",
               "  FROM prcm_t,prcn_t ",
               " WHERE prcment = prcnent AND prcmdocno = prcndocno ",
               "   AND prcment = ?",
               "   AND ",g_wc CLIPPED,
               "   AND ",l_where CLIPPED,
               "   AND prcmstus = 'Y'",
               "   AND NOT EXISTS (SELECT 1",
               "                     FROM xmda_t,xmja_t",
               "                    WHERE xmdaent = xmjaent",
               "                      AND xmdadocno = xmjadocno",
               "                      AND xmdastus != 'X'",
               "                      AND xmja035 = prcndocno",
               "                      AND xmja036 = prcnseq) ",
               "   AND prcn011 IS NOT NULL",  #如果包裝單位為空值就不納入產生的單據中
               " ORDER BY prcmdocno,prcnseq"
   #end add-point
 
   PREPARE adbp501_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adbp501_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
      g_detail_d[l_ac].sel,         g_detail_d[l_ac].prcmdocno,
      g_detail_d[l_ac].prcnseq,     g_detail_d[l_ac].prcn004,
      g_detail_d[l_ac].prcn004_desc,g_detail_d[l_ac].prcn005,
      g_detail_d[l_ac].prcn005_desc,g_detail_d[l_ac].prcn018,
      g_detail_d[l_ac].prcn010,     g_detail_d[l_ac].prcn010_desc,
      g_detail_d[l_ac].prcn011,     g_detail_d[l_ac].prcn011_desc,
      g_detail_d[l_ac].prcn013,     g_detail_d[l_ac].xmja013,
      g_detail_d[l_ac].xmja013_desc,g_detail_d[l_ac].xmja014,
      g_detail_d[l_ac].xmja031,
      g_detail_d[l_ac].prcn006,     g_detail_d[l_ac].prcn006_desc,
      g_detail_d[l_ac].prcn007,     g_detail_d[l_ac].prcn007_desc,
      g_detail_d[l_ac].prcn008,     g_detail_d[l_ac].prcn008_desc,
      g_detail_d[l_ac].prcn009,     g_detail_d[l_ac].prcn009_desc
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
      SELECT imaa105 INTO g_detail_d[l_ac].xmja013 FROM imaa_t
       WHERE imaaent = g_enterprise
         AND imaa001 = g_detail_d[l_ac].prcn010
         
      IF NOT cl_null(g_detail_d[l_ac].xmja013) THEN
         CALL s_aooi250_convert_qty(g_detail_d[l_ac].prcn010,g_detail_d[l_ac].prcn011,g_detail_d[l_ac].xmja013,g_detail_d[l_ac].prcn013)
           RETURNING l_success,l_xmja014
         IF l_success THEN
            LET g_detail_d[l_ac].xmja014 = l_xmja014
         END IF
      ELSE
         #如果商品的銷售單位為空值就不納入可產生的單據中
         CONTINUE FOREACH
      END IF
       
      #在b_fill時 如果已在暫存的temp_table 中,則將temp_table 的值顯示於畫面
      LET l_cnt = 0
      LET l_xmja031 = ''
      SELECT COUNT(*),xmja031
        INTO l_cnt,l_xmja031
        FROM s_adbp501_temp2
       WHERE prcment = g_enterprise
         AND prcmdocno = g_detail_d[l_ac].prcmdocno
         AND prcnseq = g_detail_d[l_ac].prcnseq
         AND sel = 'Y'
       GROUP BY xmja031

      IF l_cnt = 1 THEN
         LET g_detail_d[l_ac].sel     = 'Y'
         LET g_detail_d[l_ac].xmja031 = l_xmja031
      END IF

      #將這一次b_fill 的值 寫到主要的temp中
      INSERT INTO s_adbp501_temp1(sel,    prcment,prcmdocno,prcnseq,prcn004,
                                  prcn005,prcn018,prcn010,  prcn011,prcn013,
                                  xmja031,prcn006,prcn007,  prcn008,prcn009)
      VALUES(g_detail_d[l_ac].sel,       g_enterprise,
             g_detail_d[l_ac].prcmdocno,g_detail_d[l_ac].prcnseq,
             g_detail_d[l_ac].prcn004,  g_detail_d[l_ac].prcn005,
             g_detail_d[l_ac].prcn018,  g_detail_d[l_ac].prcn010,
             g_detail_d[l_ac].prcn011,  g_detail_d[l_ac].prcn013,
             g_detail_d[l_ac].xmja031,  g_detail_d[l_ac].prcn006,
             g_detail_d[l_ac].prcn007,  g_detail_d[l_ac].prcn008,
             g_detail_d[l_ac].prcn009)
      #end add-point
      
      CALL adbp501_detail_show()      
 
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
   FREE adbp501_sel
   
   LET l_ac = 1
   CALL adbp501_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adbp501.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adbp501_fetch()
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
 
{<section id="adbp501.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION adbp501_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   DEFINE l_imaal004     LIKE imaal_t.imaal004
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   #經銷商簡稱
   CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].prcn004)
      RETURNING g_detail_d[l_ac].prcn004_desc
      
   #網點簡稱
   CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].prcn005)
      RETURNING g_detail_d[l_ac].prcn005_desc
      
   #品名
   CALL s_desc_get_item_desc(g_detail_d[l_ac].prcn010)
      RETURNING g_detail_d[l_ac].prcn010_desc,l_imaal004
      
   #包裝單位說明
   CALL s_desc_get_unit_desc(g_detail_d[l_ac].prcn011)
      RETURNING g_detail_d[l_ac].prcn011_desc
      
   #銷售範圍說明
   CALL s_desc_get_sales_range_desc(g_detail_d[l_ac].prcn006)
      RETURNING g_detail_d[l_ac].prcn006_desc
   
   #銷售渠道說明
   CALL s_desc_get_oojdl003_desc(g_detail_d[l_ac].prcn007)
      RETURNING g_detail_d[l_ac].prcn007_desc
      
   #辦事處簡稱
   CALL s_desc_get_department_desc(g_detail_d[l_ac].prcn008)
      RETURNING g_detail_d[l_ac].prcn008_desc
      
   #產品組說明
   CALL s_desc_get_prod_group_desc(g_detail_d[l_ac].prcn009)
      RETURNING g_detail_d[l_ac].prcn009_desc
      
   #包裝單位說明
   CALL s_desc_get_unit_desc(g_detail_d[l_ac].xmja013)
      RETURNING g_detail_d[l_ac].xmja013_desc
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adbp501.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION adbp501_filter()
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
   
   CALL adbp501_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="adbp501.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION adbp501_filter_parser(ps_field)
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
 
{<section id="adbp501.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION adbp501_filter_show(ps_field,ps_object)
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
   LET ls_condition = adbp501_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="adbp501.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 更新temp table資料
# Memo...........:
# Usage..........: CALL adbp501_upd_s_adbp501_temp1(p_ac)
# Input parameter: p_ac   陣列第幾筆
# Return code....: 無
# Date & Author..: 2014/07/29 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbp501_upd_s_adbp501_temp1(p_ac)
DEFINE p_ac     LIKE type_t.num5
DEFINE l_prcmdocno LIKE prcm_t.prcmdocno   #170109-00037#2 20170116 add by beckxie
DEFINE l_prcnseq   LIKE prcn_t.prcnseq     #170109-00037#2 20170116 add by beckxie

   #170109-00037#2 20170116 add by beckxie---S
   #UI勾選LOCK檢查
   IF g_detail_d[p_ac].sel = 'Y' THEN
      CALL s_transaction_begin()
      LET l_prcmdocno = ''
      LET l_prcnseq = ''
      EXECUTE adbp501_chk_lock_prcn USING g_detail_d[p_ac].prcmdocno,g_detail_d[p_ac].prcnseq
                                     INTO l_prcmdocno,l_prcnseq
      IF cl_null(l_prcmdocno) OR cl_null(l_prcnseq) THEN
         LET g_detail_d[p_ac].sel = 'N'
         LET g_detail_d[p_ac].xmja031 = ''
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'apm-01117'
         LET g_errparam.replace[1] = g_detail_d[p_ac].prcmdocno
         LET g_errparam.replace[2] = g_detail_d[p_ac].prcnseq
         LET g_errparam.popup  = TRUE
         CALL cl_err()
      END IF
      
      CALL s_transaction_end('Y',0)
   END IF
   #170109-00037#2 20170116 add by beckxie---E
   UPDATE s_adbp501_temp1
      SET sel = g_detail_d[p_ac].sel,
          xmja031 = g_detail_d[p_ac].xmja031
    WHERE prcment = g_enterprise
      AND prcmdocno = g_detail_d[p_ac].prcmdocno
      AND prcnseq = g_detail_d[p_ac].prcnseq
END FUNCTION

################################################################################
# Descriptions...: 欄位開啟
# Memo...........:
# Usage..........: CALL adbp501_set_entry_b()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/07/29 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbp501_set_entry_b()
   CALL cl_set_comp_entry("b_xmja031",TRUE)
END FUNCTION

################################################################################
# Descriptions...: 欄位關閉
# Memo...........:
# Usage..........: CALL adbp501_set_no_entry_b()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/07/29 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbp501_set_no_entry_b()
   IF g_detail_d[l_ac].sel = 'N' THEN
      CALL cl_set_comp_entry("b_xmja031",FALSE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 於整批處理前,校驗當下那筆資料(l_ac)的正確性
# Memo...........:
# Usage..........: CALL adbp501_chk_data()
#                :    RETURNING r_success
# Input parameter: 無
# Return code....: r_success      True/False
# Date & Author..: 2014/08/13 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbp501_chk_data()
DEFINE r_success  LIKE type_t.num5

   LET r_success = TRUE

   IF g_detail_d[l_ac].sel = 'Y' AND cl_null(g_detail_d[l_ac].xmja031) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = 'adb-00283'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
