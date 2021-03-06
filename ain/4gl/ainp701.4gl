#該程式未解開Section, 採用最新樣板產出!
{<section id="ainp701.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0012(2016-12-01 15:55:50), PR版次:0012(2016-12-22 14:58:15)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000011
#+ Filename...: ainp701
#+ Description: 裝箱單批次出庫作業
#+ Creator....: 08172(2016-09-20 17:00:38)
#+ Modifier...: 06137 -SD/PR- 06814
 
{</section>}
 
{<section id="ainp701.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#+ Modifier...: 03247 dongsz #160909-00069#10 2016/10/08   查询增加筛选条件 
#add by geza  20161018 #161018-00043#1  #调用ainp512
#add by 06814 20161030 #161024-00023#12 #原本狀態只有:過帳,未過帳,全部;將開放狀態全顯示
#                                       #開啟程式的預先查詢查出可以執行批處理的資料
#add by 06814 20161030 #161024-00023#13 #開窗對應修改
#add by 06137 20161102 #161024-00023#17 #增加分销销退部分处理
#add by 06814 20161110 #161109-00078#8  #点批次执行按钮执行完或点刷新按钮后，可以刷新界面为装箱待出库部分数据
#add by 06814 20161117 #161109-00078#12 #來源為4.配送單，對應出庫單據的時候，
#                                        1.原關聯出庫單據的時候，來源單號條件用的單頭來源單號inbm004，現改為單身來源單號inbp002;
#                                        2.篩選：配送調撥aint512的時候，原根據inbp011，inbp012對應aint512單身來源需求單號，項次來找aint512，
#                                               增加條件，已裝箱量inbp009 <> 0的裝箱單身才對應;                             
#                                        3.篩選：分銷出庫adbt540的時候，原根據inbp011，inbp012對應adbt540單身來源訂單單號，項次來找adbt540，
#                                                增加條件，已裝箱量inbp009 <> 0的裝箱單身才對應
#add by 06137 20161201 #161017-00051#16 1.需求明细页签底部增加数量合计，
#                                       2.ainp701增加已装箱量、过账人员、过账人员名称，已装箱量sum对应单身同需求单号iinbp011的已装箱量inbp009，过账人员抓后置出库单adbt540的过账人员，并带出过账人员名称，或者aint512上的拨出审核人员，并带出拨出审核人员名称
#add by 06814 20161208 #161208-00023#4  1.ainp701同一装箱单号的备注，只需显示第一笔，其他笔显示*************
#add by 06814 20161222 #161220-00037#6  1.調整關聯的條件:配送调拨单身档(indd_t),分销出库单身档(xmdl_t)
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
   #161024-00023#5 20161027 mark by beckxie---S
   #改欄位順序
   #sel         LIKE type_t.chr1,          
   #inbmdocno   LIKE inbm_t.inbmdocno,      #装箱单号
   #inbmdocdt   LIKE inbm_t.inbmdocdt,      #装箱日期
   #inbm006     LIKE inbm_t.inbm006,        #装箱部门
   #inbm005     LIKE inbm_t.inbm005,        #装箱人员
   #inbm008     LIKE inbm_t.inbm008,        #需求对象类型
   #inbm001     LIKE inbm_t.inbm001,        #需求对象
   #inbm002     LIKE inbm_t.inbm002,        #需求单号
   #indcdocno   LIKE indc_t.indcdocno,      #出库单号
   #indcdocdt   LIKE indc_t.indcdocdt,      #出库单据日期
   #161024-00023#5 20161027 mark by beckxie---E
   #161024-00023#5 20161027 add by beckxie---S
   #改欄位順序
   sel         LIKE type_t.chr1,          
   inbmdocno   LIKE inbm_t.inbmdocno,      #装箱单号
   inbmdocdt   LIKE inbm_t.inbmdocdt,      #装箱日期
   inbm005     LIKE inbm_t.inbm005,        #装箱人员
   inbm006     LIKE inbm_t.inbm006,        #装箱部门
   inbp009     LIKE inbp_t.inbp009,        #已裝箱量   #161017-00051#16 Add By Ken 161201
   inbm007     LIKE inbm_t.inbm007,        #備註
   inbm003     LIKE inbm_t.inbm003,        #來源類型
   inbm004     LIKE inbm_t.inbm004,        #來源單號
   inbp010     LIKE inbp_t.inbp010,        #需求類型
   inbm002     LIKE inbm_t.inbm002,        #需求单号
   inbm008     LIKE inbm_t.inbm008,        #需求对象类型
   #inbm001     LIKE inbm_t.inbm001,        #需求对象   #161024-00023#12 20161030 mark by beckxie
   inbm001     LIKE type_t.chr500,         #需求对象    #161024-00023#12 20161030 add by beckxie #需直接顯示名稱
   indcdocno   LIKE indc_t.indcdocno,      #出库单号
   indcdocdt   LIKE indc_t.indcdocdt,      #出库单据日期
   indcstus    LIKE indc_t.indcstus,       #過帳狀態
   indcpstdt   LIKE indc_t.indcpstdt,      #過帳日期
   #161017-00051#16 Add By Ken 161201(S)
   indcpstid   LIKE indc_t.indcpstid,      #過帳人員
   indcpstid_desc LIKE type_t.chr500       #過帳人員名稱
   #161017-00051#16 Add By Ken 161201(E)
   #161024-00023#5 20161027 add by beckxie---E
               END RECORD
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
DEFINE g_detail_d_t        type_g_detail_d
DEFINE g_query      LIKE type_t.chr1
DEFINE g_inbm008    LIKE inbm_t.inbm008
DEFINE g_detail_idx LIKE type_t.num5
DEFINE g_check_all  LIKE type_t.chr1
DEFINE g_no_check   LIKE type_t.chr1
DEFINE g_default_flag  LIKE type_t.num5   #default search否 #161024-00023#12 20161030 add by beckxie
DEFINE g_indcpstdt  LIKE indc_t.indcdocdt   #161024-00023#13 20161031 add by beckxie
#end add-point
 
{</section>}
 
{<section id="ainp701.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
   #add-point:main段define name="main.define"
   DEFINE l_success      LIKE type_t.num5
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ain","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ainp701 WITH FORM cl_ap_formpath("ain",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL ainp701_init()   
 
      #進入選單 Menu (="N")
      CALL ainp701_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_ainp701
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   CALL ainp701_drop_tmp() RETURNING l_success
   CALL s_lot_auto_drop_tmp('aint512')
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="ainp701.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION ainp701_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_session_id    LIKE type_t.num20
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   SELECT USERENV('SESSIONID') INTO l_session_id FROM DUAL
   DISPLAY "------------------------------"
   DISPLAY "SessionId: ",l_session_id
   DISPLAY "------------------------------"
   CALL cl_set_combo_scc('b_inbm008','6968')
   #161024-00023#5 20161027 add by beckxie---S
   CALL cl_set_combo_scc('b_inbm003','6977')
   #CALL cl_set_combo_scc('b_indcstus','6979')                   #161024-00023#12 20161030 mark by beckxie
   CALL cl_set_combo_scc_part('b_indcstus','13','N,Y,S,C,P,O')   #161024-00023#12 20161030  add by beckxie
   CALL cl_set_combo_scc('b_inbp010','6874')
   #161024-00023#5 20161027 add by beckxie---E
   CALL ainp701_create_tmp() RETURNING l_success
   LET g_check_all = 'N'
   LET g_no_check = 'N'
   LET l_success = ''
   CALL s_lot_auto_create_tmp('aint512') RETURNING l_success
   LET g_default_flag = TRUE   #161024-00023#12 20161030 add by beckxie
   LET g_query = '1'           #161024-00023#12 20161030 add by beckxie
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="ainp701.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainp701_ui_dialog()
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
 
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL ainp701_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
        
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
#         INPUT ARRAY g_detail_d FROM s_detail1.*
#             ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
#                       INSERT ROW = FALSE,
#                       DELETE ROW = FALSE, 
#                       APPEND ROW = FALSE)
#            BEFORE INPUT
#               LET g_current_page = 1
#               CALL cl_set_act_visible("filter",FALSE)
#               
#            BEFORE ROW
#               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
#               LET l_ac = g_detail_idx
#               DISPLAY g_detail_idx TO FORMONLY.h_index
#               DISPLAY g_detail_d.getLength() TO FORMONLY.h_count
#               LET g_master_idx = l_ac
#               CALL ainp701_b_fill()
#               IF g_detail_d[l_ac].sel = 'N' THEN
#                  NEXT FIELD sel
#               END IF 
#            
#            ON CHANGE b_sel
#               UPDATE ainp701_tmp SET sel = g_detail_d[l_ac].sel 
#                WHERE inbmdocno = g_detail_d[l_ac].inbmdocno
#                  AND inbmdocdt = g_detail_d[l_ac].inbmdocdt
#                  AND inbm006 = g_detail_d[l_ac].inbm005
#                  AND inbm005 = g_detail_d[l_ac].inbm005
#                  AND inbm008 = g_detail_d[l_ac].inbm008
#                  AND inbm001 = g_detail_d[l_ac].inbm001
#                  AND inbm002 = g_detail_d[l_ac].inbm002
#                  AND indcdocno = g_detail_d[l_ac].indcdocno
#                  AND indcdocdt = g_detail_d[l_ac].indcdocdt
#               IF SQLCA.sqlcode THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = SQLCA.sqlcode
#                  LET g_errparam.extend = 'update ainp701_tmp'
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#               END IF
#            
#            AFTER ROW
#            
#            AFTER INPUT
#         
#         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTES(COUNT=g_detail_cnt)  
    
            BEFORE ROW
               #顯示單身筆數
               #160909-00069#10--dongsz add--s
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               IF g_detail_idx > g_detail_d.getLength() THEN
                  LET g_detail_idx = g_detail_d.getLength()
               END IF
               IF g_detail_idx = 0 AND g_detail_d.getLength() <> 0 THEN
                  LET g_detail_idx = 1
               END IF
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_detail_d.getLength() TO FORMONLY.h_count
               #160909-00069#10--dongsz add--e
               
            BEFORE DISPLAY

                       
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
            #161024-00023#12 20161030 add by beckxie---S
            IF g_default_flag THEN
               CALL ainp701_b_fill()   
               CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            END IF
            #161024-00023#12 20161030 add by beckxie---E
            #DISPLAY '1' TO b_inbm008   #161024-00023#12 20161031 mark by beckxie
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
            UPDATE ainp701_tmp SET sel = 'Y'
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'update ainp701_tmp'
               LET g_errparam.popup = TRUE
               CALL cl_err()
            END IF
            LET g_query = '0'
            CALL ainp701_b_fill()
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
            UPDATE ainp701_tmp SET sel = 'N'
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'update ainp701_tmp'
               LET g_errparam.popup = TRUE
               CALL cl_err()
            END IF
            LET g_query = '0'
            CALL ainp701_b_fill()
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            FOR li_idx = 1 TO g_detail_d.getLength()  #161024-00023#12 20161031 add by beckxie
               IF g_detail_d[li_idx].sel = "Y" THEN   #161024-00023#12 20161031 add by beckxie
                  #LET li_idx = li_idx - 1            #161024-00023#12 20161031 mark by beckxie
                  UPDATE ainp701_tmp SET sel = 'Y'
                   WHERE inbmdocno = g_detail_d[li_idx].inbmdocno
                     AND inbmdocdt = g_detail_d[li_idx].inbmdocdt
                     AND indcdocno = g_detail_d[li_idx].indcdocno
                     AND indcdocdt = g_detail_d[li_idx].indcdocdt
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'update ainp701_tmp'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  END IF
               END IF   #161024-00023#12 20161031 add by beckxie
            END FOR     #161024-00023#12 20161031 add by beckxie
            LET g_query = '0'
            CALL ainp701_b_fill()
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            FOR li_idx = 1 TO g_detail_d.getLength()  #161024-00023#12 20161031 add by beckxie
               IF g_detail_d[li_idx].sel = "N" THEN   #161024-00023#12 20161031 add by beckxie
                  #LET li_idx = li_idx - 1            #161024-00023#12 20161031 mark by beckxie
                  UPDATE ainp701_tmp SET sel = 'N'
                   WHERE inbmdocno = g_detail_d[li_idx].inbmdocno
                     AND inbmdocdt = g_detail_d[li_idx].inbmdocdt
                     AND indcdocno = g_detail_d[li_idx].indcdocno
                     AND indcdocdt = g_detail_d[li_idx].indcdocdt
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'update ainp701_tmp'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  END IF
               END IF   #161024-00023#12 20161031 add by beckxie
            END FOR     #161024-00023#12 20161031 add by beckxie
            LET g_query = '0'
            CALL ainp701_b_fill()
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL ainp701_filter()
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
            LET g_inbm008 = GET_FLDBUF(b_inbm008)
            LET g_indcpstdt = GET_FLDBUF(b_indcpstdt)   #161024-00023#13 20161031 add by beckxie
            LET g_query = '3'
            #end add-point
            CALL ainp701_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            #LET g_query = '0'   #161109-00078#8 20161110 mark by beckxie
            #161109-00078#8 20161110 add by beckxie---S
            #重查出待出庫明細
            LET g_default_flag = TRUE
            LET g_query = '1'
            LET g_indcpstdt = ''
            LET g_wc = ''
            LET g_wc2 = ''
            #161109-00078#8 20161110 add by beckxie---E
            #end add-point
            CALL ainp701_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
#         ON ACTION check_all
#            LET g_check_all = 'Y'
#            CALL ainp701_select()
#         ON ACTION no_check
#            LET g_no_check = 'Y'
#            CALL ainp701_select()
         ON ACTION modify_detail
            CALL ainp701_modify()

         ON ACTION query_1
            CALL ainp701_construct()
            
         ON ACTION batch_execute
            CALL ainp701_process()
            CALL g_detail_d.clear()
            CLEAR FORM
            #161109-00078#8 20161110 add by beckxie---S
            #重查出待出庫明細
            LET g_default_flag = TRUE
            LET g_query = '1'
            LET g_indcpstdt = ''
            LET g_wc = ''
            LET g_wc2 = ''
            CALL ainp701_b_fill()
            #161109-00078#8 20161110 add by beckxie---E
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
 
{<section id="ainp701.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION ainp701_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   IF g_query = '3' THEN
      RETURN
   END IF
   #end add-point
        
   LET g_error_show = 1
   CALL ainp701_b_fill()
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
 
{<section id="ainp701.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION ainp701_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_sql           STRING
   DEFINE l_sql1          STRING
   DEFINE l_sql2          STRING
   DEFINE l_sql3          STRING   #161024-00023#5 20161028 add by beckxie
   DEFINE l_sql4          STRING   #161024-00023#5 20161028 add by beckxie
   DEFINE l_sql5          STRING   #161024-00023#17 20161102 add by Ken
   DEFINE l_wc            STRING
   DEFINE l_wc_2          STRING   #161024-00023#5 20161028 add by beckxie
   DEFINE l_wc_3          STRING   #161024-00023#5 20161028 add by beckxie
   DEFINE l_wc_4          STRING   #161024-00023#5 20161028 add by beckxie
   DEFINE l_wc_5          STRING   #161024-00023#5 20161028 add by beckxie
   DEFINE l_wc_6          STRING   #161024-00023#5 20161028 add by beckxie
   DEFINE l_wc_7          STRING   #161024-00023#5 20161028 add by beckxie
   DEFINE l_wc_8          STRING   #161024-00023#17 20161102 add by Ken
   DEFINE l_date_s        STRING   #161024-00023#13 20161101 add by beckxie
   DEFINE l_date_e        STRING   #161024-00023#13 20161101 add by beckxie
   
   IF cl_null(g_wc) THEN
      LET g_wc = ' 1=1'
   END IF
   
   #161024-00023#13 20161031 add by beckxie---S
   IF NOT cl_null(g_indcpstdt) THEN 
      IF cl_null(g_wc2) THEN
         LET g_wc2 = " 1=1 "
      ELSE
         LET l_date_s = g_indcpstdt," 00:00:00 "
         LET l_date_e = g_indcpstdt," 23:59:59 "
         LET g_wc2 = "  indcpstdt BETWEEN (TO_DATE('",l_date_s,"','yyyy-mm-dd hh24:mi:ss')) ",
                     "                AND (TO_DATE('",l_date_e,"','yyyy-mm-dd hh24:mi:ss')) "
      END IF
      LET l_wc_4 = cl_replace_str(g_wc2,'indcpstdt','indc022')
      LET l_wc_5 = cl_replace_str(g_wc2,'indcpstdt','indc024')
      LET l_wc_6 = g_wc," AND ",l_wc_4  #indc022
      LET l_wc_7 = g_wc," AND ",l_wc_5  #indc024
      
      LET g_wc = g_wc," AND ",g_wc2
      
   END IF

   IF cl_null(l_wc_6) THEN
      LET l_wc_6 = g_wc," AND 1=1 "
   END IF
   IF cl_null(l_wc_7) THEN
      LET l_wc_7 = g_wc," AND 1=1 "
   END IF
   #161024-00023#13 20161031 add by beckxie---E
   
   #161024-00023#12 20161030 mark by beckxie---S
   ##161024-00023#5 20161028 add by beckxie---S
   #IF cl_null(g_wc2) THEN
   #   LET g_wc2 = ' 1=1'
   #ELSE
   #   CASE g_wc2
   #      WHEN "indcstus='S'"
   #         LET g_wc2 = " indcstus IN ('S','P','C') "
   #     # WHEN "indcstus='ALL'"
   #     #    LET g_wc2 = " 1=1 "
   #      WHEN "indcstus='N'"
   #         LET g_wc2 = " indcstus NOT IN ('S','P','C') "
   #      OTHERWISE
   #         LET g_wc2 = " 1=1 "
   #   END CASE
   #END IF
   #LET g_wc = g_wc," AND ",g_wc2
   ##161024-00023#5 20161028 add by beckxie---E
   #161024-00023#12 20161030  mark by beckxie---E
   LET l_wc = cl_replace_str(g_wc,'indcdocno','xmdkdocno')
   #LET l_wc = cl_replace_str(g_wc,'indcdocdt','xmdkdocdt')   #161024-00023#13 20161031 mark by beckxie
   LET l_wc = cl_replace_str(l_wc,'indcdocdt','xmdkdocdt')    #161024-00023#13 20161031 add by beckxie
   LET l_wc = cl_replace_str(l_wc,'indcpstdt','xmdkpstdt')    #161024-00023#13 20161031 add by beckxie
   LET l_wc = cl_replace_str(l_wc,'indcpstid','xmdkpstid')    #161017-00051#16 Add By Ken 161201
   LET l_wc_2 = cl_replace_str(l_wc,'indcstus','xmdkstus')     #161024-00023#5 20161028 add by beckxie
   LET l_wc_3 = cl_replace_str(g_wc,'indcdocno','pmdsdocno')   #161024-00023#5 20161028 add by beckxie
   LET l_wc_3 = cl_replace_str(l_wc_3,'indcpstdt','pmdspstdt') #161024-00023#13 20161031 add by beckxie
   LET l_wc_3 = cl_replace_str(l_wc_3,'indcpstid','pmdspstid') #161017-00051#16 Add By Ken 161201
   LET l_wc_3 = cl_replace_str(l_wc_3,'indcdocdt','pmdsdocdt') #161024-00023#5 20161028 add by beckxie
   LET l_wc_3 = cl_replace_str(l_wc_3,'indcstus','pmdsstus')   #161024-00023#5 20161028 add by beckxie
   #161024-00023#17 Add By Ken 161102(S)
   LET l_wc_8 = cl_replace_str(g_wc,'indcdocno','xmdkdocno')
   LET l_wc_8 = cl_replace_str(l_wc_8,'indcdocdt','xmdkdocdt')
   LET l_wc_8 = cl_replace_str(l_wc_8,'indcpstdt','xmdkpstdt') 
   LET l_wc_8 = cl_replace_str(l_wc_8,'indcpstid','xmdkpstid')  #161017-00051#16 Add By Ken 161201
   LET l_wc_8 = cl_replace_str(l_wc_8,'indcstus','xmdkstus') 
   #161024-00023#17 Add By Ken 161102(E)
   #161017-00051#16 Add By Ken 161201(S)
   LET l_wc_6 = cl_replace_str(l_wc_6,'indcpstid','indc021')
   LET l_wc_7 = cl_replace_str(l_wc_7,'indcpstid','indc023')
   #161017-00051#16 Add By Ken 161201(E)   

   IF g_query = '1' THEN
   DELETE FROM ainp701_tmp
   
   #161024-00023#12 20161030 mark by beckxie---S
   #LET l_sql1 = " SELECT DISTINCT 'Y',inbment,inbmstus,inbmdocno,inbmdocdt,inbm006,inbm005,inbm008,inbm001,inbm002,indcdocno,indcdocdt",   
   #             #161024-00023#5 20161027 add by beckxie---S
   #             #161024-00023#12 20161030 modify by beckxie---S
   #             #改回直接取原有狀態碼
   #             #"                 ,CASE indcstus WHEN 'S' THEN 'S' ",
   #             #"                               WHEN 'P' THEN 'S' ",
   #             #"                               WHEN 'C' THEN 'S' ",
   #             #"                               ELSE 'N' END indcstus, ",
   #             "                 ,indcstus , ",
   #             #161024-00023#12 20161030 modify by beckxie---E
   #             "                 indcpstdt, ",
   #             "                 inbm007,inbm003,inbm004,",
   #             "                 '' inbp010",
   #             #161024-00023#5 20161027 add by beckxie---E
   #             "   FROM indc_t,inbm_t,inbo_t,indd_t ",           #160909-00069#10 add inbo_t,indd_t
   #             "  WHERE indcent = ",g_enterprise,
   #             "    AND inbment = indcent AND indc002 = '4' AND indc003 = inbm004",
   #             "    AND inboent = inbment AND inbodocno = inbmdocno AND indddocno = indcdocno ",     #160909-00069#10 add
   #             "    AND inddent = indcent AND indd001 = inbo011 AND inbmstus <> 'X' ",               #160909-00069#10 add
   #             "    AND inddseq = (SELECT MIN(inddseq) FROM indd_t WHERE indddocno = indcdocno AND inddent = indcent) ",   #160909-00069#10 add
   #             "    AND (indcstus = 'Y' OR indcstus = 'N')",
   #             "    AND ",g_wc
   #161024-00023#12 20161030 mark by beckxie---E

   #161024-00023#12 20161030 add by beckxie---S
   LET l_sql1 = " SELECT  DISTINCT 'Y' ,inbment,inbmstus,inbmdocno,inbmdocdt, ",
                #161109-00078#12 20161117 modify by beckxie---S
                "               inbm006,inbm005,inbm008,inbm001,inbp011 inbm002, ",
                #161109-00078#12 20161117 modify by beckxie---E
                "               indcdocno,indcdocdt,indcstus,",
                "               indc022 indcpstdt, ",  #inbm003 ='4' 配送 取撥出審核日為過帳日顯示
                #161109-00078#12 20161117 modify by beckxie---S
                #"               inbm007,inbm003,inbm004,inbp010 ",   
                "               inbm007,inbm003,inbp002 inbm004,inbp010, ",   
                #161109-00078#12 20161117 modify by beckxie---E                
                "               SUM(inbp009) inbp009,indc021 indcpstid ",                #161017-00051#16 Add By Ken 161201
                "   FROM inbm_t,inbp_t,indd_t,indc_t ",
                "  WHERE inbment = inbpent AND inbmdocno = inbpdocno ",
                #"    AND inddent = inbpent AND inbp011 = indd047 AND inbp012 = indd048 ",   #161220-00037#6 20161222 mark by beckxie
                #161220-00037#6 20161222 add by beckxie---S
                "    AND inddent = inbpent AND inbpdocno = indd049 AND inbpseq = indd050 ",   
                "    AND indc199 = '2' ",
                #161220-00037#6 20161222 add by beckxie---E
                #161109-00078#12 20161117 modify by beckxie---S
                #1.inbm004 現在改為有可能為空,不可作為關聯條件,改取單身inbp002)
                #2.現有邏輯有可能出現已裝數量=0的情況,為0的單身不顯示
                #"    AND indcent = inddent AND indcdocno =indddocno AND indc003 = inbm004 AND indcstus <>'X' ",
                "    AND indcent = inddent AND indcdocno =indddocno AND indc003 = inbp002 AND indcstus <>'X' ",
                "    AND inbp009 <> 0 ",
                #161109-00078#12 20161117 modify by beckxie---E
                #161220-00037#6 20161222 mark by beckxie---S
                #"    AND indc000 <>'3' ", #调拨单据性质[indc000]<>3.调拨拨   #161024-00023#12 20161031 add by beckxie
                #161220-00037#6 20161222 mark by beckxie---E
                "    AND inbment = ",g_enterprise,
                "    AND inbm003='4' ",
                "    AND inbm008='1' ",
                "    AND inbmstus <>'X'  ",
                #"    AND ",g_wc
                "    AND ",l_wc_6                
                #161017-00051#16 Add By Ken 161201(S)
                IF g_default_flag THEN
                   LET l_sql1 = l_sql1 , "AND indcstus IN ('N','Y') "
                END IF
                LET l_sql1 = l_sql1 ,
                "  GROUP BY inbment,inbmstus,inbmdocno,inbmdocdt,inbm006, ",
                "           inbm005,inbm008,inbm001,inbp011,indcdocno,    ",
                "           indcdocdt,indcstus,indc022,inbm007,inbm003,   ",
                "           inbp002,inbp010,indc021 "
                #161017-00051#16 Add By Ken 161201(E)                
   #161024-00023#12 20161030 add by beckxie---E


   
              
   
   #161024-00023#12 20161030 mark by beckxie---S
   #LET l_sql2 = " SELECT DISTINCT 'Y',inbment,inbmstus,inbmdocno,inbmdocdt,inbm006,inbm005,inbm008,inbm001,inbm002,xmdkdocno indcdocno,xmdkdocdt indcdocdt",
   #             #161024-00023#5 20161027 add by beckxie---S
   #             #161024-00023#12 20161030 modify by beckxie---S
   #             #改回直接取原有狀態碼
   #             #"                 ,CASE xmdkstus WHEN 'S' THEN 'S' ",
   #             #"                                WHEN 'P' THEN 'S' ",
   #             #"                                WHEN 'C' THEN 'S' ",
   #             #"                                ELSE 'N' END indcstus, ",
   #             "                 ,xmdkstus indcstus, ",
   #             #161024-00023#12 20161030 modify by beckxie---E
   #             "                 xmdkpstdt indcpstdt, ",
   #             "                 inbm007,inbm003,inbm004,",
   #             "                 '' inbp010",
   #             #161024-00023#5 20161027 add by beckxie---E
   #             "   FROM xmdk_t,inbm_t,inbo_t,xmdl_t ",           #160909-00069#10 add inbo_t,xmdl_t
   #             "  WHERE xmdkent = ",g_enterprise,
   #             "    AND inbment = xmdkent AND xmdk088 = '4' AND xmdk089 = inbm004",
   #             "    AND inbodocno = inbmdocno AND xmdldocno = xmdkdocno ",     #160909-00069#10 add
   #             "    AND xmdl003 = inbo004 AND xmdl004 = inbo005 ",             #160909-00069#10 add
   #             "    AND inboent = inbment AND xmdlent = xmdkent AND inbmstus <> 'X' ",   #160909-00069#10 add
   #             "    AND xmdlseq = (SELECT MIN(xmdlseq) FROM xmdl_t WHERE xmdldocno = xmdkdocno AND xmdlent = xmdkent) ",  #160909-00069#10 add
   #             "    AND xmdkstus = 'Y' ",
   #             #"    AND ",l_wc   #161024-00023#5 20161027 mark by beckxie
   #             "    AND ",l_wc_2  #161024-00023#5 20161027 add by beckxie
   #161024-00023#12 20161030 mark by beckxie---E
   #161024-00023#12 20161030 add by beckxie---S
   LET l_sql2 = " SELECT DISTINCT 'Y',inbment,inbmstus,inbmdocno,inbmdocdt, ",
                #161109-00078#12 20161117 modify by beckxie---S
                #"                 inbm006,inbm005,inbm008,inbm001,inbm002, ",
                "                 inbm006,inbm005,inbm008,inbm001,inbp011 inbm002, ",
                #161109-00078#12 20161117 modify by beckxie---E
                "                 xmdkdocno indcdocno,xmdkdocdt indcdocdt, ",
                "                 xmdkstus indcstus,xmdkpstdt indcpstdt, ",
                #161109-00078#12 20161117 modify by beckxie---S
                #"                 inbm007,inbm003,inbm004,inbp010 ",
                "                 inbm007,inbm003,inbp002 inbm004,inbp010, ",
                #161109-00078#12 20161117 modify by beckxie---E
                "                 SUM(inbp009) inbp009,xmdkpstid indcpstid ",      #161017-00051#16 Add By Ken 161201
                "   FROM inbm_t,inbp_t,xmdl_t,xmdk_t ",
                "  WHERE inbment = inbpent AND inbmdocno = inbpdocno ",
                #"    AND inbpent = xmdlent AND inbp011 = xmdl003 AND inbp012 = xmdl004 ",   #161220-00037#6 20161222 mark by beckxie
                "    AND inbpent = xmdlent AND inbpdocno = xmdl097 AND inbpseq = xmdl098 ",  #161220-00037#6 20161222  add by beckxie
                "    AND xmdlent = xmdkent AND xmdldocno = xmdkdocno AND xmdkstus <>'X' ",
                #161109-00078#12 20161117 add by beckxie---S
                #現有邏輯有可能出現已裝數量=0的情況,為0的單身不顯示
                "    AND inbp009 <> 0 ",
                #161109-00078#12 20161117 add by beckxie---E
                "    AND inbm003 = '4' ",
                "    AND inbm008 = '2' ",
                "    AND inbmstus <>'X' ",
                "    AND ",l_wc_2 
                #161017-00051#16 Add By Ken 161201(S)
                IF g_default_flag THEN
                   LET l_sql2 = l_sql2 , "AND xmdkstus = 'Y' "
                END IF
                LET l_sql2 = l_sql2 ,                
                "  GROUP BY inbment,inbmstus,inbmdocno,inbmdocdt,inbm006, ",
                "           inbm005,inbm008,inbm001,inbp011,xmdkdocno,    ",
                "           xmdkdocdt,xmdkstus,xmdkpstdt,inbm007,inbm003, ",
                "           inbp002,inbp010,xmdkpstid "
                #161017-00051#16 Add By Ken 161201(E)                
   #161024-00023#12 20161030 add by beckxie---E

   
   
                
   #161024-00023#5 20161028 add by beckxie---S
   #委外採購入庫單資料apmt571
   LET l_sql3 = " SELECT DISTINCT 'Y',inbment,inbmstus,inbmdocno,inbmdocdt,inbm006,inbm005,inbm008,inbm001,inbm002,pmdsdocno indcdocno,pmdsdocdt indcdocdt ",
                #161024-00023#12 20161030 modify by beckxie---S
                #改回直接取原有狀態碼
                #"                 ,CASE pmdsstus WHEN 'S' THEN 'S' ",
                #"                                WHEN 'P' THEN 'S' ",
                #"                                WHEN 'C' THEN 'S' ",
                #"                                ELSE 'N' END indcstus, ",
                "                 ,pmdsstus indcstus, ",
                #161024-00023#12 20161030 modify by beckxie---E
                "                  pmdspstdt indcpstdt,inbm007,inbm003,inbm004, ",
                "                  inbp010, ",
                "                  SUM(inbp009) inbp009,pmdspstid indcpstid  ",    #161017-00051#16 Add By Ken 161201
                #"   FROM inbm_t ,inbp_t,pmds_t  ",   #161024-00023#17 Mark BY Ken 161102
                #161024-00023#17 Add BY Ken 161102(S)
                "   FROM inbm_t ",
                "        LEFT JOIN pmds_t ON inbment = pmdsent AND inbm004 = pmds006 AND pmdsstus <> 'X' ",
                "        ,inbp_t  ",
                #161024-00023#17 Add BY Ken 161102(E)
                "  WHERE inbment = inbpent  ",
                "    AND inbmdocno = inbpdocno ",                
                "    AND inbment = ",g_enterprise,  #161024-00023#17 Add BY Ken 161102
                "    AND inbm003 = '5' ",  #5:委外採購收貨單               
                "    AND inbmstus <> 'X' ",
                "    AND ",l_wc_3  ,            
                #161017-00051#16 Add By Ken 161201(S)
                "  GROUP BY inbment,inbmstus,inbmdocno,inbmdocdt,inbm006, ",
                "           inbm005,inbm008,inbm001,inbm002,pmdsdocno,    ",
                "           pmdsdocdt,pmdsstus,pmdspstdt ,inbm007,inbm003,",
                "           inbm004,inbp010,pmdspstid "
                #161017-00051#16 Add By Ken 161201(E)
                #161024-00023#17 Mark BY Ken 161102(S)
                #"    AND inbment = pmdsent ",
                #"    AND pmds006 = inbm004   ",
                #"    AND pmdsent =",g_enterprise,
                #"    AND pmdsstus <> 'X' ",   #161024-00023#13 20161031 add by beckxie
                #161024-00023#17 Mark BY Ken 161102(E)
                
                
                
                

   #161024-00023#5 20161028 add by beckxie---E
   #161024-00023#5 20161027 add by beckxie---S
   #倉退單邏輯aint513
   LET l_sql4 = " SELECT DISTINCT 'Y',inbment,inbmstus,inbmdocno,inbmdocdt,inbm006,inbm005,inbm008,inbm001,inbm002,indcdocno,indcdocdt, ",
                #161024-00023#12 20161030 modify by beckxie---S
                #"        CASE indcstus WHEN 'S' THEN 'S' ",
                #"           WHEN 'P' THEN 'S' ",
                #"           WHEN 'C' THEN 'S' ",
                #"        ELSE 'N' END indcstus, ",
                "         indcstus, ",
                #161024-00023#12 20161030 modify by beckxie---E
                "        indc024 indcpstdt, ",  #inbm003 ='6' 倉退 取撥入審核日為過帳日顯示
                "        inbm007,inbm003,inbm004,inbp010, ",
                "        SUM(inbp009) inbp009,indc023 indcpstid ",        #161017-00051#16 Add By Ken 161201
                "   FROM indc_t,inbm_t,inbp_t ",
                "  WHERE inbpent = inbment ",
                "    AND inbpdocno = inbmdocno ",
                "    AND indcent = inbment ",
                "    AND indc001 = inbm004  ",
                "    AND indcstus <> 'X' ",   #161024-00023#13 20161031 add by beckxie
                "    AND inbmstus <> 'X' ",
                "    AND inbm003 = '6' ",   #6:門店倉退單
                #"    AND ",l_wc
                #"    AND ",g_wc
                "     AND ",l_wc_7 ,
                #161017-00051#16 Add By Ken 161201(S)
                "  GROUP BY inbment,inbmstus,inbmdocno,inbmdocdt,inbm006,  ",
                "           inbm005,inbm008,inbm001,inbm002,indcdocno, ",
                "           indcdocdt,indcstus,indc024,inbm007,inbm003, ", 
                "           inbm004,inbp010,indc023 "
                #161017-00051#16 Add By Ken 161201(E)
   #DISPLAY "sql_4:",l_sql4
   #161024-00023#5 20161027 add by beckxie---E
   
   #161024-00023#17 Add BY Ken 161102(S)   
   #分銷銷退單邏輯adbt600
   LET l_sql5 = " SELECT DISTINCT  'Y',          inbment,    inbmstus,  inbmdocno, inbmdocdt, ",
                "                  inbm006,      inbm005,    inbm008,   inbm001,   inbm002, ",
                "                  xmdkdocno,    xmdkdocdt,  xmdkstus,  xmdkpstdt, inbm007, ",
                "                  inbm003,      inbm004,    inbp010, ",
                "                  SUM(inbp009) inbp009, xmdkpstid indcpstid ",    #161017-00051#16 Add By Ken 161201
                "   FROM xmdk_t,inbm_t,inbp_t ",
                "  WHERE inbpent = inbment ",
                "    AND inbpdocno = inbmdocno ",
                "    AND xmdkent = inbment ",
                "    AND xmdkdocno = inbm004  ",
                "    AND xmdkstus <> 'X' ",
                "    AND inbmstus <> 'X' ",
                "    AND inbm003 = '7' ",   #7:分銷銷退單
                "    AND ",l_wc_8   ,
                #161017-00051#16 Add By Ken 161201(S)
                "  GROUP BY inbment,    inbmstus,  inbmdocno, inbmdocdt,   inbm006,   ",
                "           inbm005,    inbm008,   inbm001,   inbm002,     xmdkdocno, ",
                "           xmdkdocdt,  xmdkstus,  xmdkpstdt, inbm007,     inbm003,   ",
                "           inbm004,    inbp010,   xmdkpstid "
                #161017-00051#16 Add By Ken 161201(E)
   #161024-00023#17 Add BY Ken 161102(E)   
   
   
   #161024-00023#12 20161031 mark by beckxie---S
   #IF g_inbm008 = '1' THEN
   #   LET l_sql = l_sql1," ORDER BY inbmdocno,inbmdocdt"
   #END IF
   #IF g_inbm008 = '2' THEN
   #   LET l_sql = l_sql2," ORDER BY inbmdocno,inbmdocdt"
   #END IF
   #IF cl_null(g_inbm008) THEN
   #161024-00023#12 20161031 mark by beckxie---E
   LET l_sql = " SELECT DISTINCT 'Y',inbment,inbmstus,inbmdocno,inbmdocdt,inbm006,inbm005,inbm008,inbm001,inbm002,indcdocno,indcdocdt",
               #161024-00023#5 20161027 add by beckxie---S
               "                 ,indcstus, ",
               "                 indcpstdt,inbm007,inbm003,inbm004,",
               "                 inbp010,",               
               #161024-00023#5 20161027 add by beckxie---E
               "                 inbp009, indcpstid ",    #161017-00051#16 Add By Ken 161201
               "   FROM ( ",l_sql1,
               #"          UNION ",l_sql2," )",   #161024-00023#5 20161027 mark by beckxie
               #161024-00023#5 20161027 add by beckxie---S
               "          UNION ",l_sql2,
               "          UNION ",l_sql3,
               "          UNION ",l_sql4,
               "          UNION ",l_sql5,       #161024-00023#17 Add BY Ken 161102
               "        )",
               #161024-00023#5 20161027 add by beckxie---E
               "  ORDER BY inbmdocno,inbmdocdt"
   #END IF   #161024-00023#12 20161031 mark by beckxie
   #161024-00023#12 20161030 add by beckxie---S
   #預先查詢的條件,若是預先查詢,把l_sql 改為 只找l_sql1,l_sql2
   IF g_default_flag THEN
      LET g_default_flag = FALSE  #將此flag 改為FALSE :只在開啟程式時做此動作
      LET g_query = ''
      LET l_sql = " SELECT DISTINCT 'Y',inbment,inbmstus,inbmdocno,inbmdocdt,inbm006,inbm005,inbm008,inbm001,inbm002,indcdocno,indcdocdt",
                  "                 ,indcstus, ",
                  "                 indcpstdt,inbm007,inbm003,inbm004,",
                  "                 inbp010,",
                  "                 inbp009, indcpstid ",    #161017-00051#16 Add By Ken 161201
                  "   FROM ( ",l_sql1,
                  #"          AND indcstus IN ('N','Y') ",   #161017-00051#16 Mark By Ken 161201
                  "          UNION ",l_sql2,
                  #"          AND xmdkstus = 'Y' ",          #161017-00051#16 Mark By Ken 161201
                  "        )",
                  "  ORDER BY inbmdocno,inbmdocdt"
      #DISPLAY "sql:",l_sql
   END IF 
   #161024-00023#12 20161030 add by beckxie---E
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL ainp701_tmp_mod(l_sql)
   END IF
   LET g_sql = " SELECT   sel, ",
               "          inbmdocno, ",
               "          inbmdocdt, ",
               "          inbm006, ",
               "          inbm005, ",
               "          inbm008, ",
               #"          inbm001, ",   #161024-00023#12 20161030 mark by beckxie
               #161024-00023#12 20161030 add by beckxie---S
               "          CASE WHEN inbm008 = '1' THEN (SELECT ooefl003 ",
               "                                          FROM ooefl_t ",
               "                                         WHERE ooeflent = "||g_enterprise||" ",
               "                                           AND ooefl001 = inbm001 ",
               "                                           AND ooefl002 = '"||g_dlang||"') ",
               "               WHEN inbm008 = '2' THEN (SELECT pmaal004 ",
               "                                          FROM pmaal_t ",
               "                                         WHERE pmaalent = "||g_enterprise||" ",
               "                                           AND pmaal001 = inbm001 ",
               "                                           AND pmaal002 = '"||g_dlang||"')  ",
               "               WHEN inbm008 = '3' THEN (SELECT pmaal004 ",
               "                                          FROM pmaal_t ",
               "                                         WHERE pmaalent = "||g_enterprise||" ",
               "                                           AND pmaal001 = inbm001 ",
               "                                           AND pmaal002 = '"||g_dlang||"') END inbm008_desc,",
               #161024-00023#12 20161030 add by beckxie---E
               "          inbm002, ",
               "          indcdocno, ",
               "          indcdocdt, ",
               #161024-00023#5 20161027 add by beckxie---S
               "          indcstus, ",
               "          indcpstdt, ",
               "          inbm007, ",
               "          inbm003, ",
               "          inbm004, ",
               "          CASE WHEN inbm002 IS NOT NULL ",
               "                  THEN inbp010 ",
               "               ELSE '' END inbp010, ",
               #161024-00023#5 20161027 add by beckxie---E
               #161017-00051#16 Add By Ken 161201(S)
               "          inbp009 ,",
               "          indcpstid , ",
               "          (SELECT ooag011 FROM ooag_t WHERE ooagent = inbment AND ooag001 = indcpstid) indcpstid_desc, ",
               #161017-00051#16 Add By Ken 161201(E)
               #161208-00023#4 20161208 add by beckxie---S
               "          ROW_NUMBER() OVER (PARTITION BY inbmdocno ORDER BY inbmdocno,indcdocno) l_rownum ",   
               #161208-00023#4 20161208 add by beckxie---E
               "    FROM ainp701_tmp",
               "   WHERE inbment = ?",
               "   ORDER BY inbmdocno,inbmdocdt "   #161024-00023#5 20161027 add by beckxie---S
              
   #DISPLAY "l_sql:",l_sql
   #DISPLAY "g_sql:",g_sql
   #161208-00023#4 20161208 add by beckxie---S
   LET g_sql = "SELECT sel, ",
               "       inbmdocno,inbmdocdt,inbm006,inbm005,inbm008, ",
               "       inbm008_desc,inbm002,indcdocno,indcdocdt,indcstus, ",
               "       indcpstdt,CASE WHEN l_rownum = 1 THEN inbm007 ",
               "                      WHEN (l_rownum <>'1' AND inbm007 IS NOT NULL) THEN '*************' END inbm007, ",
               "       inbm003,inbm004,inbp010,inbp009,indcpstid, ",
               "       indcpstid_desc ",
               "  FROM (",g_sql,") ",
               "  ORDER BY inbmdocno,inbmdocdt "
   DISPLAY "g_sql:",g_sql
   #161208-00023#4 20161208 add by beckxie---E
   #end add-point
 
   PREPARE ainp701_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR ainp701_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
      g_detail_d[l_ac].sel,g_detail_d[l_ac].inbmdocno,g_detail_d[l_ac].inbmdocdt,g_detail_d[l_ac].inbm006,
      g_detail_d[l_ac].inbm005,g_detail_d[l_ac].inbm008,g_detail_d[l_ac].inbm001,g_detail_d[l_ac].inbm002,
      g_detail_d[l_ac].indcdocno,g_detail_d[l_ac].indcdocdt
      #161024-00023#5 20161027 add by beckxie---S
      ,g_detail_d[l_ac].indcstus,g_detail_d[l_ac].indcpstdt,g_detail_d[l_ac].inbm007,g_detail_d[l_ac].inbm003,
      g_detail_d[l_ac].inbm004,g_detail_d[l_ac].inbp010
      #161024-00023#5 20161027 add by beckxie---E
      ,g_detail_d[l_ac].inbp009,g_detail_d[l_ac].indcpstid,g_detail_d[l_ac].indcpstid_desc
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
 
      #end add-point
      
      CALL ainp701_detail_show()      
 
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
   FREE ainp701_sel
   
   LET l_ac = 1
   CALL ainp701_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="ainp701.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION ainp701_fetch()
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
 
{<section id="ainp701.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION ainp701_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
#   DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
#      
# 
#   END DISPLAY
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="ainp701.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION ainp701_filter()
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
   
   CALL ainp701_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="ainp701.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION ainp701_filter_parser(ps_field)
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
 
{<section id="ainp701.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION ainp701_filter_show(ps_field,ps_object)
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
   LET ls_condition = ainp701_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="ainp701.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 创建临时表
# Date & Author..: 2016/09/21 by 08172
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp701_create_tmp()
   DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT ainp701_drop_tmp() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   CREATE TEMP TABLE ainp701_tmp(
   sel         LIKE type_t.chr1,
   inbment     LIKE inbm_t.inbment,
   inbmstus    LIKE inbm_t.inbmstus,
   inbmdocno   LIKE inbm_t.inbmdocno,    #装箱单号
   inbmdocdt   LIKE inbm_t.inbmdocdt,    #装箱日期
   inbm006     LIKE inbm_t.inbm006,      #装箱部门
   inbm005     LIKE inbm_t.inbm005,      #装箱人员
   inbm008     LIKE inbm_t.inbm008,      #需求对象类型
   inbm001     LIKE inbm_t.inbm001,      #需求对象
   inbm002     LIKE inbm_t.inbm002,      #需求单号
   indcdocno   LIKE indc_t.indcdocno,    #出库单号
   indcdocdt   LIKE indc_t.indcdocdt,    #出库单据日期
   #161024-00023#5 20161027 add by beckxie---S
   indcstus    LIKE indc_t.indcstus,     #過帳狀態
   indcpstdt   LIKE indc_t.indcpstdt,    #過帳日期
   inbm007     LIKE inbm_t.inbm007,      #備註
   inbm003     LIKE inbm_t.inbm003,      #來源類型
   inbm004     LIKE inbm_t.inbm004,      #來源單號
   inbp010     LIKE inbp_t.inbp010,      #需求類型
   #161024-00023#5 20161027 add by beckxie---E
   #161017-00051#16 Add By Ken 161201(S)
   inbp009     LIKE inbp_t.inbp009,      #已裝箱量
   indcpstid   LIKE indc_t.indcpstid     #過帳人員
   #161017-00051#16 Add By Ken 161201(E)
   )
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create ainp701_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 删除临时表
# Date & Author..: 2016/09/21 by 08172
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp701_drop_tmp()
   DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE ainp701_tmp

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop ainp701_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
      
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 临时表异动
# Date & Author..: 2016/09/21 by 08172
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp701_tmp_mod(p_sql)
   DEFINE p_sql          STRING
   DEFINE l_sql          STRING
   
   #清空临时表
    TRUNCATE TABLE ainp701_tmp
   #数据插入临时表
    LET l_sql = " INSERT INTO ainp701_tmp ",p_sql         
    PREPARE ins_tmp FROM l_sql
    EXECUTE ins_tmp 
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = 'ins ainp701_tmp'
       LET g_errparam.popup = TRUE
       CALL cl_err()
    END IF
    
END FUNCTION

################################################################################
# Descriptions...: 全选OR全不选
# Date & Author..: 2016/09/21 by 08172
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp701_select()
   #全选
   IF g_check_all = 'Y' THEN
      UPDATE ainp701_tmp SET sel = 'Y'
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'update ainp701_tmp'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
      CALL ainp701_b_fill()
      LET g_check_all = 'N'
   END IF
   #全不选
   IF g_no_check = 'Y' THEN
      UPDATE ainp701_tmp SET sel = 'N'
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'update ainp701_tmp'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
      CALL ainp701_b_fill()
      LET g_check_all = 'N'
   END IF
END FUNCTION

################################################################################
# Descriptions...: 单身资料修改
# Date & Author..: 2016/09/22
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp701_modify()
   DEFINE la_param  RECORD
          prog   STRING,
          param  DYNAMIC ARRAY OF STRING
                 END RECORD
   DEFINE ls_js     STRING
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
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
            LET g_query = '0'
            CALL ainp701_b_fill()
            LET g_detail_d_t.* = g_detail_d[g_detail_idx].*
         
         ON CHANGE sel
            UPDATE ainp701_tmp SET sel = g_detail_d[g_detail_idx].sel 
             WHERE inbmdocno = g_detail_d[g_detail_idx].inbmdocno
               AND inbmdocdt = g_detail_d[g_detail_idx].inbmdocdt
               AND indcdocno = g_detail_d[g_detail_idx].indcdocno
               AND indcdocdt = g_detail_d[g_detail_idx].indcdocdt
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'update ainp701_tmp'
               LET g_errparam.popup = TRUE
               CALL cl_err()
            END IF
         
         AFTER ROW
         
         AFTER INPUT
      
      END INPUT
       
      
      ON ACTION close
         LET INT_FLAG=FALSE         
         LET g_action_choice = "exit"
         LET g_detail_d[g_detail_idx].* = g_detail_d_t.*
         EXIT DIALOG
      
      ON ACTION exit
         LET g_action_choice="exit"
         LET g_detail_d[g_detail_idx].* = g_detail_d_t.*
         EXIT DIALOG
      
      ON ACTION accept
         #add-point:ui_dialog段accept之前
#         LET g_inbm008 = GET_FLDBUF(b_inbm008)
#         #end add-point
#         CALL ainp701_query()  
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET g_detail_d[g_detail_idx].* = g_detail_d_t.*
         EXIT DIALOG
      
      ON ACTION modify_detail
         
         LET la_param.prog = 'aint701'
         LET la_param.param[1] = g_detail_d[g_detail_idx].inbmdocno
         LET ls_js = util.JSON.stringify(la_param)
         CALL cl_cmdrun(ls_js)
      
   END DIALOG 
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
PRIVATE FUNCTION ainp701_construct()
   CALL g_detail_d.clear()
   CLEAR FORM
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      CONSTRUCT g_wc 
             ON inbmdocno,inbmdocdt,inbm001,inbm002,inbm005,inbm006,inbm008,indcdocno,indcdocdt
                ,inbm007,inbm003,inbm004,inbp010   #161024-00023#5 20161028 add by beckxie
                ,indcstus  #161024-00023#12 20161030 add by beckxie
                ,indcpstid   #161017-00051#16 Add By Ken 161201
           FROM b_inbmdocno,b_inbmdocdt,b_inbm001,b_inbm002,b_inbm005,b_inbm006,b_inbm008,b_indcdocno,b_indcdocdt
                ,b_inbm007,b_inbm003,b_inbm004,b_inbp010   #161024-00023#5 20161028 add by beckxie
                ,b_indcstus   #161024-00023#12 20161030 add by beckxie
                ,b_indcpstid   #161017-00051#16 Add By Ken 161201
         BEFORE CONSTRUCT
            CALL cl_set_act_visible("filter",FALSE)
         
         ON ACTION controlp INFIELD b_inbmdocno
            LET g_inbm008 = GET_FLDBUF(b_inbm008)
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            
            #161024-00023#13 20161031 add by beckxie---S
            LET g_qryparam.where = " inbmstus <> 'X' "
            CALL q_inbmdocno()   
            #161024-00023#13 20161031 add by beckxie---E
            
            #161024-00023#13 20161031 mark  by beckxie---S
            #IF g_inbm008 = '1' THEN
            #   LET g_qryparam.where = " inbmstus = 'Y' AND EXISTS( SELECT 1 
            #                                                         FROM indc_t 
            #                                                        WHERE indcent = inbment 
            #                                                          AND indc002 = '4' 
            #                                                          AND indc003 = inbm004
            #                                                          AND (indcstus = 'Y' OR indcstus = 'N') )"
            #   CALL q_inbmdocno()
            #END IF
            #IF g_inbm008 = '2' THEN
            #   LET g_qryparam.where = " inbmstus = 'Y' AND EXISTS( SELECT 1 
            #                                                         FROM xmdk_t 
            #                                                        WHERE xmdkent = inbment 
            #                                                          AND xmdk088 = '4' 
            #                                                          AND xmdk089 = inbm004
            #                                                          AND xmdkstus = 'Y' )"
            #   CALL q_inbmdocno()
            #END IF
            #161024-00023#13 20161031 mark by beckxie---E
            DISPLAY g_qryparam.return1 TO b_inbmdocno
            NEXT FIELD b_inbmdocno
         
         ON ACTION controlp INFIELD b_inbm001
            LET g_inbm008 = GET_FLDBUF(b_inbm008)
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            #161024-00023#13 20161031 mark by beckxie---S
            #IF g_inbm008 = '1' THEN
            #   LET g_qryparam.arg1 = '1'
            #   CALL q_pmcz062_1()
            #END IF
            #IF g_inbm008 = '2' THEN
            #   LET g_qryparam.arg1 = '2'
            #   CALL q_pmcz062_1()
            #END IF
            #161024-00023#13 20161031 mark by beckxie---E
            
            #161024-00023#13 20161031 add by beckxie---S
            IF NOT cl_null(g_inbm008) THEN
               LET g_qryparam.where = " inbm008 = '",g_inbm008,"' "
            END IF
            CALL q_inbm001()
            #161024-00023#13 20161031 add by beckxie---E
           
            DISPLAY g_qryparam.return1 TO b_inbm002
            NEXT FIELD b_inbm001
         
         ON ACTION controlp INFIELD b_inbm002
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " EXISTS(SELECT 1",
                                                   "  FROM inbm_t",
                                                   " WHERE inbment = ",g_enterprise,
                                                   "   AND inbmstus ='Y' AND inbm002 = pmcz001)"
            CALL q_pmcz001()
            DISPLAY g_qryparam.return1 TO b_inbm002
            NEXT FIELD b_inbm002
         
         ON ACTION controlp INFIELD b_inbm005
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " EXISTS(SELECT 1",
                                                   "  FROM inbm_t",
                                                   " WHERE inbment = ",g_enterprise,
                                                   "   AND inbmstus ='Y' AND inbm005 = ooag001)"
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO b_inbm005
            NEXT FIELD b_inbm005
         
         ON ACTION controlp INFIELD b_inbm006
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " EXISTS(SELECT 1",
                                                   "  FROM inbm_t",
                                                   " WHERE inbment = ",g_enterprise,
                                                   "   AND inbmstus ='Y' AND inbm006 = ooeg001)"
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO b_inbm006
            NEXT FIELD b_inbm006
         
         ON ACTION controlp INFIELD b_indcdocno
            LET g_inbm008 = GET_FLDBUF(b_inbm008)
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            IF g_inbm008 = '1' THEN
               #LET g_qryparam.where = " indcstus IN ('N','Y') AND indc002 = '4' AND  EXISTS (",   #161024-00023#13 20161031 mark by beckxie
               LET g_qryparam.where = " indcstus <>'X' AND indc002 = '4' AND  EXISTS (",   #161024-00023#13 20161031 add by beckxie
                                      " SELECT 1",
                                      "   FROM inbm_t",
                                      "  WHERE inbment = ",g_enterprise,
                                      #"    AND inbmstus ='Y' AND inbm004 = indc003)"   #161024-00023#5 20161027 mark by beckxie
                                      "    AND inbmstus <> 'X' ",    #161024-00023#5 20161027 add by beckxie
                                      "    AND inbm004 = indc003)"                      #161024-00023#5 20161027 add by beckxie
               CALL q_indcdocno()
            END IF
            IF g_inbm008 = '2' THEN
               LET g_qryparam.arg1 = '1'
               #LET g_qryparam.where = " xmdk002 <> '7' AND xmdk088 = '4' AND xmdkstus IN ('N','Y') AND  EXISTS (",   #161024-00023#13 20161031 mark by beckxie
               LET g_qryparam.where = " xmdk002 <> '7' AND xmdk088 = '4' AND xmdkstus <> 'X' AND  EXISTS (",   #161024-00023#13 20161031 add by beckxie
                                      " SELECT 1",
                                      "   FROM inbm_t",
                                      "  WHERE inbment = ",g_enterprise,
                                      #"    AND inbmstus ='Y' AND inbm004 = xmdk089)"   #161024-00023#5 20161027 mark by beckxie
                                      "    AND inbmstus <> 'X' ",    #161024-00023#5 20161027 add by beckxie
                                      "    AND inbm004 = xmdk089)"   #161024-00023#5 20161027 add by beckxie
               CALL q_xmdkdocno_2()                       
            END IF
            #161024-00023#13 20161031 add by beckxie---S
            IF g_inbm008 = '3' THEN
               #開委外入庫
               LET g_qryparam.arg1 = "('12')"
               LET g_qryparam.where = " pmdsstus <>'X' AND  EXISTS (",
                                      " SELECT 1",
                                      "   FROM inbm_t",
                                      "  WHERE inbment = ",g_enterprise,
                                      "    AND inbm003 = '5' ",
                                      "    AND pmds006 = inbm004",
                                      "    AND inbmstus <> 'X' )"
               CALL q_pmdsdocno_8()
            END IF
            #161024-00023#13 20161031 add by beckxie---E
            DISPLAY g_qryparam.return1 TO b_indcdocno
            NEXT FIELD b_indcdocno
         #161024-00023#5 20161028 add by beckxie---S
         ON ACTION controlp INFIELD b_inbm004
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            CALL q_inbm004()
            DISPLAY g_qryparam.return1 TO b_inbm004
            NEXT FIELD b_inbm004
         ON ACTION controlp INFIELD b_inbm007
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            CALL q_inbm007()
            DISPLAY g_qryparam.return1 TO b_inbm007
            NEXT FIELD b_inbm007
         #161024-00023#5 20161028 add by beckxie---E
         
         #161017-00051#16 Add By Ken 161201(S)
         ON ACTION controlp INFIELD b_indcpstid
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO b_indcpstid
            NEXT FIELD b_indcpstid         
         #161017-00051#16 Add By Ken 161201(E)
         AFTER CONSTRUCT
      
      END CONSTRUCT
      #161024-00023#12 20161030 mark by beckxie---S
      ##161024-00023#5 20161028 add by beckxie---S
      #CONSTRUCT g_wc2
      #       ON indcstus   
      #     FROM b_indcstus 
      #     AFTER CONSTRUCT
      #        DISPLAY "g_wc2",g_wc2 
      #END CONSTRUCT
      ##161024-00023#5 20161028 add by beckxie---E
      #161024-00023#12 20161030 mark by beckxie---E

      #161024-00023#13 20161031 add by beckxie---S
      CONSTRUCT g_wc2
             ON indcpstdt   
           FROM b_indcpstdt 
           AFTER CONSTRUCT
              DISPLAY "g_wc2",g_wc2 
      END CONSTRUCT
      #161024-00023#13 20161031 add by beckxie---E
      
      BEFORE DIALOG
         LET g_detail_d[1].inbmdocno =""
         DISPLAY ARRAY g_detail_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY        
         END DISPLAY
         #DISPLAY '1' TO b_inbm008   #161024-00023#12 20161030 mark by beckxie
      
      ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION accept
            #add-point:ui_dialog段accept之前
            LET g_inbm008 = GET_FLDBUF(b_inbm008)
            LET g_indcpstdt = GET_FLDBUF(b_indcpstdt)   #161024-00023#13 20161031 add by beckxie
            #end add-point
            LET g_query = '1'
            CALL ainp701_query()
            ACCEPT DIALOG 
                       
        
#        ON ACTION check_all
#            LET g_check_all = 'Y'
#            CALL ainp701_select()
#        
#        ON ACTION no_check
#           LET g_no_check = 'Y'
#           CALL ainp701_select()
#        
#        ON ACTION modify_detail
#            CALL ainp701_modify()
      
      #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
   END DIALOG 
END FUNCTION

################################################################################
# Descriptions...: 批次处理
# Date & Author..: 2016/09/23 by 08172
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp701_process()
   DEFINE l_sql        STRING
   DEFINE l_cnt        LIKE type_t.num5
   DEFINE l_n          LIKE type_t.num5
   DEFINE l_success    LIKE type_t.num5
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_inbm008    LIKE inbm_t.inbm008
   DEFINE l_inbm003    LIKE inbm_t.inbm003  #來源類型
   DEFINE l_inbmstus   LIKE inbm_t.inbmstus
   DEFINE l_indcdocno  LIKE indc_t.indcdocno
   DEFINE l_prog       LIKE type_t.chr10
   DEFINE l_wc         STRING 
   DEFINE p_cnt        LIKE type_t.num5
   LET l_n = 1
   LET l_cnt = 1
   LET r_success = TRUE
   
   SELECT COUNT(*) INTO l_cnt FROM ainp701_tmp WHERE inbment = g_enterprise
   CALL cl_progress_bar_no_window(l_cnt)
   
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   
   #LET l_sql = " SELECT inbm008,indcdocno,inbmstus",          #161024-00023#5 20161028 mark by beckxie
   #161109-00078#12 20161118 modify(有可能有多筆對應到同一筆出入庫單號,同樣的出入庫單號只做一次) by beckxie---S
   #LET l_sql = " SELECT inbm003,inbm008,indcdocno,inbmstus",   #161024-00023#5 20161028 add by beckxie
   LET l_sql = " SELECT DISTINCT inbm003,inbm008,indcdocno,inbmstus",   #161024-00023#5 20161028 add by beckxie   
   #161109-00078#12 20161118 modify(有可能有多筆對應到同一筆出入庫單號,同樣的出入庫單號只做一次) by beckxie---E
               "   FROM ainp701_tmp",
               "  WHERE inbment = ? AND sel ='Y' ",
               "    AND inbm003 = '4' ",                                #161024-00023#5 20161031 add by beckxie
               "    AND ( (inbm008= '1' AND indcstus IN ('N','Y')) ",   #161024-00023#5 20161031 add by beckxie
               "         OR (inbm008= '2' AND indcstus = 'Y') )"        #161024-00023#5 20161031 add by beckxie
   PREPARE process_pre FROM l_sql
   DECLARE process_cur CURSOR FOR process_pre
   #FOREACH process_cur USING g_enterprise INTO l_inbm008,l_indcdocno,l_inbmstus            #161024-00023#5 20161028 mark by beckxie
   FOREACH process_cur USING g_enterprise INTO l_inbm003,l_inbm008,l_indcdocno,l_inbmstus   #161024-00023#5 20161028 add by beckxie
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      CALL cl_progress_no_window_ing(l_n) 
      ##161024-00023#5 20161028 add by beckxie---S
      #IF l_inbm003 MATCHES '[56]' THEN
      #   CONTINUE FOREACH
      #END IF
      ##161024-00023#5 20161028 add by beckxie---E
      IF l_inbm008 = '1' THEN   
         LET l_prog = g_prog
         LET g_prog = 'aint512'  
         CALL s_aint510_outconf_chk(l_indcdocno,l_inbmstus) RETURNING l_success
         IF NOT l_success THEN
            LET g_prog = l_prog 
            LET r_success = FALSE            
         ELSE
            UPDATE indc_t
               SET indc022 = g_today
             WHERE indcent = g_enterprise
               AND indcdocno = l_indcdocno
            IF SQLCA.sqlcode THEN
               LET g_prog = l_prog 
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "update indc_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
              
               LET r_success = FALSE
            END IF
            CALL s_aint510_outconf_upd(l_indcdocno) RETURNING l_success
            IF NOT l_success THEN
               LET g_prog = l_prog 
               LET r_success = FALSE
            END IF            
         END IF
         LET g_prog = l_prog 
      ELSE
         CALL s_adbt540_post_chk(l_indcdocno) RETURNING l_success
         IF NOT l_success THEN     
               LET r_success = FALSE
         ELSE
            UPDATE xmdk_t
               SET xmdk001 = g_today
             WHERE xmdkent = g_enterprise
               AND xmdkdocno = l_indcdocno
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "update xmdk_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success = FALSE
            END IF
            CALL s_adbt540_post_upd(l_indcdocno) RETURNING l_success
            IF NOT l_success THEN
               LET r_success = FALSE
            END IF
         END IF   
      END IF
      LET l_n = l_n + 1
   END FOREACH
   IF r_success = FALSE THEN
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "adz-00218"
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   ELSE
      CALL s_transaction_end('Y','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "adz-00217"
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF  

   #add by geza 20161018 #161018-00043#1(S)					
   #调用批量处理作业ainp512呼叫pos接口	
   LET l_indcdocno = ''  
   LET l_sql = " SELECT indcdocno FROM ainp701_tmp WHERE sel = 'Y' AND inbm008 = '1' AND inbment = ",g_enterprise," ",
               "    AND inbm003 = '4' ",          #161024-00023#5 20161031 add by beckxie
               "    AND indcstus IN ('N','Y') "   #161024-00023#5 20161031 add by beckxie
   PREPARE ainp701_sel_indc_pr FROM l_sql
   DECLARE ainp701_sel_indc_cs CURSOR WITH HOLD FOR ainp701_sel_indc_pr 
   INITIALIZE l_indcdocno TO NULL
   FOREACH ainp701_sel_indc_cs INTO  l_indcdocno
      LET l_wc = " indcdocno = '",l_indcdocno,"' "
      CALL s_ainp512_send(l_wc)  RETURNING l_success,p_cnt 
   END FOREACH   
   #add by geza 20161018 #161018-00043#1(E)   
   CALL cl_err_collect_show()
   DELETE FROM ainp701_tmp
END FUNCTION

#end add-point
 
{</section>}
 
