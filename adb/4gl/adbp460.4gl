#該程式未解開Section, 採用最新樣板產出!
{<section id="adbp460.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0011(2016-04-13 16:25:57), PR版次:0011(2017-02-18 15:25:43)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000129
#+ Filename...: adbp460
#+ Description: 寄售出貨銷退單產生作業
#+ Creator....: 02749(2014-06-19 08:29:40)
#+ Modifier...: 06815 -SD/PR- 06814
 
{</section>}
 
{<section id="adbp460.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#Memos
#170109-00037#1  2017/01/10 by 06814   批次LOCK處理:1.UI勾選LOCK檢查
#                                                  2.資料處理LOCK
#170218-00001#1  2017/02/18 by 06814   批次作業執行後，若此次執行異動筆數為0，必須彈出提示訊息：sub-00491 輸入的條件無資料產生！
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
 #Standard---保留彈性,RECORD欄位要自定義&加上END RECORD
     sel             LIKE type_t.chr1,
     dbdasite        LIKE dbda_t.dbdasite,
     dbdasite_desc   LIKE ooefl_t.ooefl003,
     dbdadocno       LIKE dbda_t.dbdadocno,
     dbdadocdt       LIKE dbda_t.dbdadocdt,
     dbda003         LIKE dbda_t.dbda003,
     dbda001         LIKE dbda_t.dbda001,
     dbda001_desc    LIKE pmaal_t.pmaal004,
     dbda002         LIKE dbda_t.dbda002,
     dbda002_desc    LIKE pmaal_t.pmaal004,
     dbda004         LIKE dbda_t.dbda004,
     dbda004_desc    LIKE oofa_t.oofa011,
     dbda005         LIKE dbda_t.dbda005,
     dbda005_desc    LIKE ooefl_t.ooefl003
                     END RECORD
TYPE type_g_detail2_d RECORD
     dbdbdocno           LIKE dbdb_t.dbdbdocno,
     dbdbseq             LIKE dbdb_t.dbdbseq,
     dbdb001             LIKE dbdb_t.dbdb001,
     dbdb004             LIKE dbdb_t.dbdb004,
     dbdb005             LIKE dbdb_t.dbdb005,
     dbdb005_desc        LIKE imaal_t.imaal003,
     dbdb005_desc_desc   LIKE imaal_t.imaal004,
     dbdb006             LIKE dbdb_t.dbdb006,
     dbdb007             LIKE dbdb_t.dbdb007,
     dbdb008             LIKE dbdb_t.dbdb008,
     dbdb009             LIKE dbdb_t.dbdb009,
     dbdb009_desc        LIKE oocal_t.oocal003,
     dbdb012             LIKE dbdb_t.dbdb012,
     dbdb013             LIKE dbdb_t.dbdb013   
                      END RECORD
DEFINE g_detail2_cnt         LIKE type_t.num5      
DEFINE g_detail2_d           DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_detail_idx          LIKE type_t.num5
DEFINE g_detail_idx2         LIKE type_t.num5
#170218-00001#1 20170218 add by beckxie---S
GLOBALS 
   DEFINE g_do_flag          LIKE type_t.chr1        #Y:有異動,N:沒異動   
END GLOBALS
#170218-00001#1 20170218 add by beckxie---E
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
 
#end add-point
 
{</section>}
 
{<section id="adbp460.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
   #add-point:main段define name="main.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
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
      OPEN WINDOW w_adbp460 WITH FORM cl_ap_formpath("adb",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adbp460_init()   
 
      #進入選單 Menu (="N")
      CALL adbp460_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_adbp460
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success #150308-00001#1  By Ken 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="adbp460.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION adbp460_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success #150308-00001#1  By Ken 150309   
   CALL cl_set_combo_scc('b_dbdb001','6053')
   LET g_errshow = '1'
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="adbp460.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION adbp460_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_flag          LIKE type_t.chr1
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_cmd           STRING
   DEFINE l_str           STRING
   DEFINE l_str1          STRING
   DEFINE la_param    RECORD
             prog     STRING,
             param    DYNAMIC ARRAY OF STRING
                      END RECORD
   DEFINE ls_js       STRING 
   DEFINE l_msg       STRING   #160225-00040#18 2016/04/13 s983961--add
   DEFINE l_flag_lock LIKE type_t.chr1   #170109-00037#1 20170113 add by beckxie
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   #170109-00037#1 20170110 add by beckxie---S
   LET l_flag_lock = 'N'
   #LOCK檢查
   LET g_sql = "SELECT dbdbseq FROM dbda_t,dbdb_t ",
               " WHERE dbdaent = dbdbent ",
               "   AND dbdadocno = dbdbdocno ",
               "   AND dbdaent = ",g_enterprise,
               "   AND dbdbdocno = ? ",
               "   AND dbdbseq = ? ",
               "   FOR UPDATE SKIP LOCKED "
   PREPARE adbp460_chk_lock_dbda FROM g_sql
   
   LET g_sql = " SELECT dbdbdocno,dbdbseq ",
               "   FROM dbdb_t ",
               "  WHERE dbdbent = ",g_enterprise,
               "    AND dbdbdocno = ? ",
               "  ORDER BY dbdbseq "
   PREPARE adbp460_sel_dbdb_pre FROM g_sql
   DECLARE adbp460_sel_dbdb_cur CURSOR FOR adbp460_sel_dbdb_pre
   #170109-00037#1 20170110 add by beckxie---E
   
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL adbp460_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc ON dbdadocdt,dbda003,dbda001,dbda002,dbda004,dbda005
            BEFORE CONSTRUCT
               CALL cl_set_act_visible("filter",FALSE)
               
            ON ACTION controlp
               CASE
                  WHEN INFIELD(dbda001)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     CALL q_pmaa001_17()
                     DISPLAY g_qryparam.return1 TO dbda001  #顯示到畫面上
                     NEXT FIELD CURRENT
                  WHEN INFIELD(dbda002)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     CALL q_pmac002_1()
                     DISPLAY g_qryparam.return1 TO dbda002  #顯示到畫面上
                     NEXT FIELD CURRENT
                  WHEN INFIELD(dbda004)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     CALL q_ooag001()
                     DISPLAY g_qryparam.return1 TO dbda004  #顯示到畫面上
                     NEXT FIELD CURRENT
                  WHEN INFIELD(dbda005)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     LET g_qryparam.arg1 = g_today
                     CALL q_ooeg001_4()
                     DISPLAY g_qryparam.return1 TO dbda005  #顯示到畫面上
                     NEXT FIELD CURRENT
               END CASE
         END CONSTRUCT                     
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         #sakura---add---str---150105-00012#2
         INPUT ARRAY g_detail_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                     INSERT ROW = FALSE,DELETE ROW = FALSE, APPEND ROW = FALSE)
            BEFORE INPUT
               LET g_current_page = 1
               CALL cl_set_act_visible("filter",FALSE)
               
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_detail_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
               CALL adbp460_fetch()
               IF g_detail_d[l_ac].sel = 'N' THEN
                  NEXT FIELD sel
               END IF
            #170109-00037#1 20170110 add by beckxie---S
            ON CHANGE sel
               IF l_ac > 0 THEN 
                  #UI勾選LOCK檢查
                  IF g_detail_d[l_ac].sel = "Y" THEN
                     CALL cl_err_collect_init() 
                     CALL s_transaction_begin()
                     
                     IF NOT adbp460_lock_chk(l_ac) THEN
                        #FALSE=被lock
                        LET g_detail_d[l_ac].sel = "N"
                     END IF
                     CALL s_transaction_end('Y',0)
                     CALL cl_err_collect_show()
                  END IF
               END IF
            #170109-00037#1 20170110 add by beckxie---E
         END INPUT         
         #sakura---add---end---150105-00012#2
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
        #sakura---mark---str---150105-00012#2
        #DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
        #   BEFORE DISPLAY
        #      LET g_current_page = 1
        #      CALL cl_set_act_visible("filter",FALSE)
        #      
        #   BEFORE ROW
        #      LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
        #      LET l_ac = g_detail_idx
        #      DISPLAY g_detail_idx TO FORMONLY.h_index
        #      DISPLAY g_detail_d.getLength() TO FORMONLY.h_count
        #      LET g_master_idx = l_ac
        #      CALL adbp460_fetch()
        #END DISPLAY
        #sakura---mark---str---150105-00012#2         
         
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
            
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            CALL cl_err_collect_init()   #170109-00037#1 20170110 add by beckxie
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
               #170109-00037#1 20170110 add by beckxie---S
               CALL s_transaction_begin()
               
               IF NOT adbp460_lock_chk(li_idx) THEN
                  #被lock
                  LET g_detail_d[li_idx].sel = "N"
               END IF
               
               CALL s_transaction_end('Y',0)
               #170109-00037#1 20170110 add by beckxie---E
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            CALL cl_err_collect_show()   #170109-00037#1 20170110 add by beckxie
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
            #170109-00037#1 20170110 add by beckxie---S
            CALL cl_err_collect_init() 
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  CALL s_transaction_begin()
                  
                  IF NOT adbp460_lock_chk(li_idx) THEN
                     #FALSE=被lock
                     LET g_detail_d[li_idx].sel = "N"
                  END IF
                  
                  CALL s_transaction_end('Y',0)
               END IF
            END FOR
            CALL cl_err_collect_show()
            #170109-00037#1 20170110 add by beckxie---E
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
            CALL adbp460_filter()
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
            CALL adbp460_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL adbp460_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION select_item   #提供選取資料功能
            IF g_detail_d[l_ac].sel = "Y" THEN
               LET g_detail_d[l_ac].sel = "N"
            ELSE
               LET g_detail_d[l_ac].sel = "Y"
            END IF
            
         ON ACTION batch_execute
            #160225-00040#18 2016/04/13 s983961--add(s)
            IF g_bgjob <> "Y" THEN
               CALL cl_progress_bar_no_window(4)
            END IF   
            #160225-00040#18 2016/04/13 s983961--add(e)
            #170109-00037#1 20170110 add by beckxie---S
            #由下方搬移至前面:(避免破壞transation)&且開始錯誤收集
            CALL s_adbp460_drop_tmp()
            CALL s_adbp460_create_tmp() RETURNING l_success
            IF NOT l_success THEN
              #160225-00040#18 2016/04/13 s983961--add(s)
              LET l_msg = cl_getmsg('ast-00330',g_lang)   
              CALL cl_progress_no_window_ing(l_msg)
              #160225-00040#18 2016/04/13 s983961--add(e) 
              
              #160225-00040#18 2016/04/13 s983961--add(s)
              LET l_msg = cl_getmsg('ast-00330',g_lang)   
              CALL cl_progress_no_window_ing(l_msg)
              #160225-00040#18 2016/04/13 s983961--add(e)
              
              CONTINUE DIALOG
            END IF
            CALL s_transaction_begin()
            CALL cl_err_collect_init()
            #170109-00037#1 20170110 add by beckxie---E
            
            LET l_flag = 'N'
            LET l_cmd = ''
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF g_detail_d[li_idx].sel = "Y" THEN
                  #170109-00037#1 20170110 add by beckxie---S
                  #(資料處理LOCK)檢查這個勾選起來的單號有沒有被lock,如果沒被LOCK就把該筆LOCK
                  IF NOT adbp460_lock_chk(li_idx) THEN
                     #若被lock就不做此筆
                     LET l_flag_lock = 'Y'
                     CONTINUE FOR
                  END IF
                  #170109-00037#1 20170110 add by beckxie---E
                  IF cl_null(l_cmd) THEN
                     LET l_cmd = g_detail_d[li_idx].dbdadocno
                  ELSE
                     LET l_cmd = l_cmd CLIPPED,",",g_detail_d[li_idx].dbdadocno
                  END IF
                  LET l_flag = 'Y'
               END IF
            END FOR

            IF l_flag = 'N' THEN
               INITIALIZE g_errparam TO NULL
               #LET g_errparam.code = 'adb-00078' #170109-00037#1 20170113 mark by beckxie
               #170109-00037#1 20170113 add by beckxie---S
               CASE l_flag_lock
                  WHEN 'N'
                     LET g_errparam.code = 'adb-00078'
                  WHEN 'Y'
                     LET g_errparam.code = 'ast-00867'
               END CASE
               #170109-00037#1 20170113 add by beckxie---E
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               #170109-00037#1 20170110 add by beckxie---S
               CALL s_transaction_end('N','1')
               CALL cl_err_collect_show()
               #170109-00037#1 20170110 add by beckxie---E
               CONTINUE DIALOG
            ELSE
               #160225-00040#18 2016/04/13 s983961--add(s)
               LET l_msg = cl_getmsg('ade-00114',g_lang)   
               CALL cl_progress_no_window_ing(l_msg)
               #160225-00040#18 2016/04/13 s983961--add(e)
               #170109-00037#1 20170110 mark by beckxie---S
               #CALL s_adbp460_drop_tmp()
               #CALL s_adbp460_create_tmp() RETURNING l_success
               #IF NOT l_success THEN
               #  #160225-00040#18 2016/04/13 s983961--add(s)
               #  LET l_msg = cl_getmsg('ast-00330',g_lang)   
               #  CALL cl_progress_no_window_ing(l_msg)
               #  #160225-00040#18 2016/04/13 s983961--add(e) 
               #  
               #  #160225-00040#18 2016/04/13 s983961--add(s)
               #  LET l_msg = cl_getmsg('ast-00330',g_lang)   
               #  CALL cl_progress_no_window_ing(l_msg)
               #  #160225-00040#18 2016/04/13 s983961--add(e)
               #  
               #  CONTINUE DIALOG
               #END IF
               #CALL s_transaction_begin()
               #CALL cl_err_collect_init()
               #170109-00037#1 20170110 mark by beckxie---E
               
               CALL s_adbp460(l_cmd) RETURNING l_success,l_str,l_str1
               
               DISPLAY "adbt541: ",l_str
               DISPLAY "adbt601: ",l_str1
               
               
               IF l_success THEN
                  #CALL cl_err_collect_show()        #170218-00001#1 20170218 mark by beckxie
                  #CALL s_transaction_end('Y','1')   #170218-00001#1 20170218 mark by beckxie
                  #170218-00001#1 20170218 add by beckxie---S
                  IF g_do_flag = 'N' THEN
                     #若異動0筆 就不show更新成功的訊息
                     CALL s_transaction_end('Y','0')
                  ELSE
                     CALL s_transaction_end('Y','1')
                  END IF
                  CALL cl_err_collect_show()
                  #170218-00001#1 20170218 add by beckxie---E
                  
                  IF NOT cl_null(l_str) THEN
                     LET la_param.prog = 'adbt541'
                     LET la_param.param[1] = l_str    
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun(ls_js)
                  END IF
                  IF NOT cl_null(l_str1) THEN
                     LET la_param.prog = 'adbt601'
                     LET la_param.param[1] = l_str1   
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun(ls_js)
                  END IF                  
               ELSE
                  #CALL cl_err_collect_show()   #170218-00001#1 20170218 mark by beckxie
                  CALL s_transaction_end('N','1')   
                  CALL cl_err_collect_show()    #170218-00001#1 20170218 add by beckxie
               END IF
               
               CALL s_adbp460_drop_tmp()
            END IF
            
            CALL adbp460_b_fill()     
            #160225-00040#18 2016/04/13 s983961--add(s)
            LET l_msg = cl_getmsg('std-00012',g_lang)
            CALL cl_progress_no_window_ing(l_msg)  
           #CALL cl_err_collect_show()                  #160602-00026#1 160606 by lori mark
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
 
{<section id="adbp460.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION adbp460_query()
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
   CALL adbp460_b_fill()
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
 
{<section id="adbp460.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adbp460_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_where         STRING   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #Standard---樣板保留彈性,要補g_sql & INTO 的欄位
   CALL s_aooi500_sql_where(g_prog,'dbdasite') RETURNING l_where
   
   IF cl_null(g_wc) THEN 
      LET g_wc = " 1=1"
   END IF
   
   #IF cl_null(g_wc2) OR g_wc2 = " 1=1" THEN
      LET g_sql = "SELECT 'N',dbdasite,'',dbdadocno,dbdadocdt, ",   
                  "       dbda003 ,dbda001,'',dbda002,'',dbda004, ",       
                  "       '',dbda005 ",
                  "  FROM dbda_t ",
                  " WHERE dbdaent = ? ",
                  "   AND dbdasite = '",g_site,"' ",
                  "   AND dbda000= '1' ",
                  "   AND dbda006 = 'N' ",
                  "   AND dbdastus = 'S' ",
                  "   AND ",g_wc CLIPPED,
                  "   AND ",l_where,
                  "   AND EXISTS (SELECT 1 FROM dbdb_t ",
                  "                 WHERE dbdbent = dbdaent AND dbdbdocno = dbdadocno ",
                  "                   AND dbdb001 IN('2','3')) ",
                  " ORDER BY dbdadocno"                  
   #ELSE   #單身有開放查詢條件時才需要
   #   LET g_sql = "SELECT 'N',dbdasite,'',dbdadocno,dbdadocdt, ",   
   #               "       dbda003 ,dbda001,'',dbda002,'',dbda004, ",       
   #               "       '',dbda005 ",
   #               "  FROM dbdb_t,dbda_t ",
   #               " WHERE dbdbent = dbdaent AND dbdbdocno = dbdadocno ",
   #               "   AND dbdaent = ? ",
   #               "   AND dbdasite = '",g_site,"' ",
   #               "   AND dbda000= '1' ", 
   #               "   AND dbda006 = 'N' ",
   #               "   AND dbdastus = 'S' ",
   #               "   AND ",g_wc CLIPPED,
   #               "   AND dbdb001 IN('2','3') ",
   #               "   AND ",g_wc2 CLIPPED   
   #END IF
   #end add-point
 
   PREPARE adbp460_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adbp460_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
      #Standard---樣板保留彈性,要補g_sql & INTO 的欄位
      g_detail_d[l_ac].sel,         g_detail_d[l_ac].dbdasite,    g_detail_d[l_ac].dbdasite_desc, 
      g_detail_d[l_ac].dbdadocno,   g_detail_d[l_ac].dbdadocdt,   g_detail_d[l_ac].dbda003,       
      g_detail_d[l_ac].dbda001,     g_detail_d[l_ac].dbda001_desc,g_detail_d[l_ac].dbda002,       
      g_detail_d[l_ac].dbda002_desc,g_detail_d[l_ac].dbda004,     g_detail_d[l_ac].dbda004_desc,  
      g_detail_d[l_ac].dbda005,     g_detail_d[l_ac].dbda005_desc  
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
      
      CALL adbp460_detail_show()      
 
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
   CALL g_detail_d.deleteElement(l_ac)   #Standard---保留彈性,要補上清除ARRAY的最後一行
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE adbp460_sel
   
   LET l_ac = 1
   CALL adbp460_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adbp460.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adbp460_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
 
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   CALL g_detail2_d.clear()
   IF g_detail_idx = 0 THEN
      LET g_detail_idx = 1
   END IF
   
   LET g_sql = "SELECT dbdbdocno,dbdbseq,dbdb001,dbdb004,dbdb005, ",          
               "       '','',dbdb006,dbdb007,dbdb008, ",           
               "       dbdb009,'',dbdb012,dbdb013 ",
               "  FROM dbdb_t ",
               " WHERE dbdbent = ",g_enterprise,
               "   AND dbdbdocno = '",g_detail_d[g_detail_idx].dbdadocno CLIPPED,"' ",
               " ORDER BY dbdbseq "
   PREPARE adbp460_b_fill_pre2 FROM g_sql
   DECLARE adbp460_b_fill_cur2 CURSOR FOR adbp460_b_fill_pre2
   
   LET l_ac = 1
   FOREACH adbp460_b_fill_cur2 INTO g_detail2_d[l_ac].dbdbdocno,        g_detail2_d[l_ac].dbdbseq,g_detail2_d[l_ac].dbdb001,           
                                    g_detail2_d[l_ac].dbdb004,          g_detail2_d[l_ac].dbdb005,g_detail2_d[l_ac].dbdb005_desc,      
                                    g_detail2_d[l_ac].dbdb005_desc_desc,g_detail2_d[l_ac].dbdb006,g_detail2_d[l_ac].dbdb007,           
                                    g_detail2_d[l_ac].dbdb008,          g_detail2_d[l_ac].dbdb009,g_detail2_d[l_ac].dbdb009_desc,      
                                    g_detail2_d[l_ac].dbdb012,          g_detail2_d[l_ac].dbdb013           

      INITIALIZE g_ref_fields TO NULL
      CALL s_desc_get_item_desc(g_detail2_d[l_ac].dbdb005) 
         RETURNING g_detail2_d[l_ac].dbdb005_desc,g_detail2_d[l_ac].dbdb005_desc_desc
      DISPLAY BY NAME g_detail2_d[l_ac].dbdb005_desc,g_detail2_d[l_ac].dbdb005_desc_desc
      
      LET g_detail2_d[l_ac].dbdb009_desc = s_desc_get_unit_desc(g_detail2_d[l_ac].dbdb009)
      DISPLAY BY NAME g_detail2_d[l_ac].dbdb009_desc   

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
 
{<section id="adbp460.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION adbp460_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
      LET g_detail_d[l_ac].dbdasite_desc = s_desc_get_department_desc(g_detail_d[l_ac].dbdasite)
      DISPLAY BY NAME g_detail_d[l_ac].dbdasite_desc
      
      LET g_detail_d[l_ac].dbda001_desc = s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].dbda001)
      DISPLAY BY NAME g_detail_d[l_ac].dbda001_desc

      LET g_detail_d[l_ac].dbda002_desc = s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].dbda002)
      DISPLAY BY NAME g_detail_d[l_ac].dbda002_desc
      
      LET g_detail_d[l_ac].dbda004_desc = s_desc_get_person_desc(g_detail_d[l_ac].dbda004)
      DISPLAY BY NAME g_detail_d[l_ac].dbda004_desc

      LET g_detail_d[l_ac].dbda005_desc = s_desc_get_department_desc(g_detail_d[l_ac].dbda005)
      DISPLAY BY NAME g_detail_d[l_ac].dbda005_desc
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adbp460.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION adbp460_filter()
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
   
   CALL adbp460_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="adbp460.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION adbp460_filter_parser(ps_field)
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
 
{<section id="adbp460.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION adbp460_filter_show(ps_field,ps_object)
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
   LET ls_condition = adbp460_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="adbp460.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 檢查該筆(p_ac)的dbda_t,dbdb_t是否被lock
# Memo...........:
# Usage..........: CALL adbp460_lock_chk(p_ac) RETURNING r_success
# Input parameter: p_ac           列(l_ac)
# Return code....: r_success      TRUE/FALSE (#TRUE=沒有被LOCK; #FALSE=被LOCK)
# Date & Author..: #170109-00037#1 20170110 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION adbp460_lock_chk(p_ac)
   DEFINE p_ac        LIKE type_t.num10
   DEFINE l_dbdbdocno LIKE dbdb_t.dbdbdocno   
   DEFINE l_dbdbseq   LIKE dbdb_t.dbdbseq
   DEFINE l_dbdbseq_1 LIKE dbdb_t.dbdbseq
   DEFINE r_success   LIKE type_t.num5
   
   LET r_success = TRUE
   LET l_dbdbdocno = ''
   LET l_dbdbseq = ''
   
   #防呆
   IF p_ac <= 0 THEN 
      RETURN r_success
   END IF
   
   #若單號為空,防呆
   IF cl_null(g_detail_d[p_ac].dbdadocno) THEN
      RETURN r_success
   END IF
      
   LET l_dbdbdocno = ''
   LET l_dbdbseq = ''
   FOREACH adbp460_sel_dbdb_cur USING g_detail_d[p_ac].dbdadocno INTO l_dbdbdocno,l_dbdbseq
      
      LET l_dbdbseq_1 = ''
      EXECUTE adbp460_chk_lock_dbda USING l_dbdbdocno,l_dbdbseq INTO l_dbdbseq_1
      CASE SQLCA.sqlcode 
         WHEN 100 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'apm-01117'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_dbdbdocno
            LET g_errparam.replace[2] = l_dbdbseq
            CALL cl_err()
         OTHERWISE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'excute adbp460_chk_lock_dbda'
            LET g_errparam.popup = TRUE
            CALL cl_err()
      END CASE
      
      IF cl_null(l_dbdbseq_1) THEN
         #FALSE=被LOCK
         LET r_success = FALSE
      END IF
      
      LET l_dbdbdocno = ''
      LET l_dbdbseq = ''
      
   END FOREACH 
   
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
