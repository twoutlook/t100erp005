#該程式未解開Section, 採用最新樣板產出!
{<section id="astp405.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2016-07-26 18:11:55), PR版次:0003(2017-02-09 14:39:28)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000003
#+ Filename...: astp405
#+ Description: 專櫃合約單價收費項目批量調整作業
#+ Creator....: 06540(2016-07-25 10:30:52)
#+ Modifier...: 06540 -SD/PR- 08172
 
{</section>}
 
{<section id="astp405.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#151125-00001#4   2015/12/10   By 06948   增加作廢時詢問「是否作廢」
#170109-00037#12  2017/01/16   By sakura  批次LOCK處理1.UI勾選LOCK檢查2.資料處理LOCK3.修改單頭input更新條件
#170206-00020#1   2017/02/09   by 08172   日期格式调整
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
     sel          LIKE type_t.chr1    ,
     stflsite     LIKE stfl_t.stflsite,    
     ooefl003     LIKE ooefl_t.ooefl003,  
     stfl001      LIKE stfl_t.stfl001 ,    
     stflseq      LIKE stfl_t.stflseq , 
     stfa005      LIKE stfa_t.stfa005 , 
     mhael023     LIKE mhael_t.mhael023, 
     stfa010      LIKE stfa_t.stfa010 , 
     pmaal003     LIKE pmaal_t.pmaal003, 
     stfa051      LIKE stfa_t.stfa051 , 
     rtaxl003     LIKE rtaxl_t.rtaxl003, 
     stfa050      LIKE stfa_t.stfa050 , 
     stfl002      LIKE stfl_t.stfl002 , 
     stael003     LIKE stael_t.stael003, 
     stfl003      LIKE stfl_t.stfl003 , 
     stfl007      LIKE stfl_t.stfl007 , 
     l_type       LIKE pmaal_t.pmaal003,
     l_adjust     LIKE type_t.num20_6, 
     l_stfl007    LIKE stfl_t.stfl007  
                       END RECORD

DEFINE g_detail_idx          LIKE type_t.num5
DEFINE g_detail_idx2         LIKE type_t.num5

DEFINE l_str                 LIKE type_t.chr500
DEFINE type_1                LIKE type_t.chr1
DEFINE rate                  LIKE type_t.num20_6
DEFINE amount                LIKE type_t.num20_6

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="astp405.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
   #add-point:main段define name="main.define"
   DEFINE l_success  LIKE type_t.num5
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ast","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_astp405 WITH FORM cl_ap_formpath("ast",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL astp405_init()   
 
      #進入選單 Menu (="N")
      CALL astp405_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_astp405
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   CALL astp405_drop_tmp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="astp405.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION astp405_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"

   CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_str
   
   CALL s_aooi500_create_temp() RETURNING l_success  
   
   CALL cl_set_combo_scc_part('stfa003','6013','4,5')
   CALL cl_set_combo_scc('stfl003','6848')
   CALL cl_set_combo_scc('stfl003_1','6848')
   
   LET type_1 = '1'
   LET rate = '0'
   LET amount = '0'
   CALL cl_set_comp_entry("rate",TRUE)
   CALL cl_set_comp_entry("amount",FALSE)
   CALL astp405_create_tmp() RETURNING l_success
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="astp405.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION astp405_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_count    LIKE type_t.num5
   DEFINE l_lockcnt  LIKE type_t.num10   #170109-00037#12 by sakura add
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   #170109-00037#12 by sakura add(S)
   #LOCK檢查
   LET g_sql = "SELECT stfl001,stflseq FROM stfl_t ",
               " WHERE stflent = ",g_enterprise,
               "   AND stfl001 = ? ",
			   "   AND stflseq = ? ",
               "   FOR UPDATE SKIP LOCKED "
   PREPARE astp405_chk_lock_stfl FROM g_sql
   #170109-00037#12 by sakura add(E)
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL astp405_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
          CONSTRUCT BY NAME g_wc ON stfa010,stfa051,stfl003,stfl002,
                                    stfasite,stfa003,stfa005,stfa050
                                                                    
            BEFORE CONSTRUCT
               CALL cl_set_act_visible("filter",FALSE)
              
            ON ACTION controlp
               CASE
                  WHEN INFIELD(stfasite)   #營運組織
                       INITIALIZE g_qryparam.* TO NULL
                       LET g_qryparam.state = 'c'
                       LET g_qryparam.reqry = FALSE
                       LET g_qryparam.where = s_aooi500_q_where(g_prog,'stfasite',g_site,'c')
                       CALL q_ooef001_24()
                       DISPLAY g_qryparam.return1 TO stfasite 
                       NEXT FIELD CURRENT
                       
                  WHEN INFIELD(stfa005)    #專櫃編號
                       INITIALIZE g_qryparam.* TO NULL
                       LET g_qryparam.state = 'c'
                       LET g_qryparam.reqry = FALSE
                       LET g_qryparam.arg1 = g_site
                       CALL q_mhae001()
                       DISPLAY g_qryparam.return1 TO stfa005 
                       NEXT FIELD CURRENT      
                     
                  WHEN INFIELD(stfa010)    #供應商編號
                       INITIALIZE g_qryparam.* TO NULL
                       LET g_qryparam.state = 'c'
                       LET g_qryparam.reqry = FALSE
                       CALL q_pmaa001_10()
                       DISPLAY g_qryparam.return1 TO stfa010 
                       NEXT FIELD CURRENT

                  WHEN INFIELD(stfa051)
                       INITIALIZE g_qryparam.* TO NULL 
                       LET g_qryparam.state = 'c' 
                       LET g_qryparam.where = " rtax004 ='",cl_get_para(g_enterprise,"","E-CIR-0001"),"'"  #层级
                       LET g_qryparam.reqry = FALSE 
                       CALL q_rtax001_1() 
                       DISPLAY g_qryparam.return1 TO stfa051 
                       NEXT FIELD CURRENT 
           
                  WHEN INFIELD(stfl002)    #费用编号
                       INITIALIZE g_qryparam.* TO NULL
                       LET g_qryparam.state = 'c'
                       LET g_qryparam.reqry = FALSE
                       CALL q_stae001()
                       DISPLAY g_qryparam.return1 TO stfl002 
                       NEXT FIELD CURRENT 

               END CASE
         END CONSTRUCT 
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
               CALL astp405_set_entry()

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_detail_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
               
            ON CHANGE sel
               #170109-00037#12 by sakura add(S)               
               #UI勾選LOCK檢查
               IF g_detail_d[l_ac].sel = 'Y' THEN
                  CALL cl_err_collect_init() 
                  CALL s_transaction_begin()
                  LET l_ac = g_detail_idx                  
                  CALL astp405_lock_chk()
                  CALL s_transaction_end('Y',0)
                  CALL cl_err_collect_show()
               END IF
               #170109-00037#12 by sakura add(E)             
               UPDATE astp405_tmp 
                  SET sel = g_detail_d[l_ac].sel
                WHERE stfl001 = g_detail_d[l_ac].stfl001
                  AND stflseq = g_detail_d[l_ac].stflseq
            
            AFTER FIELD l_stfl007_1
               IF NOT cl_null(g_detail_d[l_ac].l_stfl007) THEN 
                  UPDATE astp405_tmp 
                     SET l_stfl007 = g_detail_d[l_ac].l_stfl007
                   WHERE stfl001 = g_detail_d[l_ac].stfl001
                     AND stflseq = g_detail_d[l_ac].stflseq
               ELSE 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "调整后单价请勿录入空值" 
                  LET g_errparam.code   = "adz-00482"
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err() 
                  NEXT FIELD l_stfl007_1
               END IF
                  
            AFTER ROW 
               UPDATE astp405_tmp 
                  SET sel = g_detail_d[l_ac].sel,
                      l_stfl007 = g_detail_d[l_ac].l_stfl007
                WHERE stfl001 = g_detail_d[l_ac].stfl001
                  AND stflseq = g_detail_d[l_ac].stflseq
         END INPUT     
         
         INPUT type_1,rate,amount
          FROM type_1,rate,amount
            ATTRIBUTE(WITHOUT DEFAULTS)
          
            ON CHANGE type_1
               IF type_1 = '1' THEN
                  CALL cl_set_comp_entry("rate",TRUE)
                  CALL cl_set_comp_entry("amount",FALSE)
                  SELECT COUNT(1) INTO l_count
                    FROM astp405_tmp
                  IF l_count > 0 THEN
                     UPDATE astp405_tmp 
                        SET l_adjust = rate/100,
                            l_stfl007 = stfl007*rate/100
                      #170109-00037#12 by sakura mark(S)
                      #WHERE stfl001 = g_detail_d[l_ac].stfl001
                      #  AND stflseq = g_detail_d[l_ac].stflseq
                      #170109-00037#12 by sakura mark(E)
                     CALL astp405_b_fill()
                  END IF
               ELSE
                  CALL cl_set_comp_entry("rate",FALSE)
                  CALL cl_set_comp_entry("amount",TRUE)  
                  SELECT COUNT(1) INTO l_count
                    FROM astp405_tmp
                  IF l_count > 0 THEN
                     UPDATE astp405_tmp 
                        SET l_adjust = amount,
                            l_stfl007 = stfl007+amount
                      #170109-00037#12 by sakura mark(S)
                      #WHERE stfl001 = g_detail_d[l_ac].stfl001 
                      #  AND stflseq = g_detail_d[l_ac].stflseq
                      #170109-00037#12 by sakura mark(E)
                     CALL astp405_b_fill()
                  END IF
               END IF
            
            AFTER FIELD rate
               SELECT COUNT(1) INTO l_count
                 FROM astp405_tmp
               IF l_count > 0 THEN
                  UPDATE astp405_tmp 
                     SET l_adjust = rate/100,
                         l_stfl007 = stfl007*rate/100
                   #170109-00037#12 by sakura mark(S)
                   #WHERE stfl001 = g_detail_d[l_ac].stfl001
                   #  AND stflseq = g_detail_d[l_ac].stflseq
                   #170109-00037#12 by sakura mark(E)
                  CALL astp405_b_fill()
               END IF

            AFTER FIELD amount
               SELECT COUNT(1) INTO l_count
                 FROM astp405_tmp
               IF l_count > 0 THEN
                  UPDATE astp405_tmp 
                     SET l_adjust = amount,
                         l_stfl007 = stfl007+amount
                   #170109-00037#12 by sakura mark(S)
                   #WHERE stfl001 = g_detail_d[l_ac].stfl001
                   #  AND stflseq = g_detail_d[l_ac].stflseq
                   #170109-00037#12 by sakura mark(E)
                  CALL astp405_b_fill()
               END IF
               
            AFTER INPUT
               IF INT_FLAG THEN
               
                  RETURN
               END IF
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
            
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            CALL cl_err_collect_init()   #170109-00037#12 by sakura add
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
               
               #170109-00037#12 by sakura add(S)             
               CALL s_transaction_begin()
               LET l_ac = li_idx
               CALL astp405_lock_chk()
               CALL s_transaction_end('Y',0)
               UPDATE astp405_tmp 
                  SET sel = g_detail_d[l_ac].sel
                WHERE stfl001 = g_detail_d[l_ac].stfl001
                  AND stflseq = g_detail_d[l_ac].stflseq               
               #170109-00037#12 by sakura add(E)               
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            CALL cl_err_collect_show()   #170109-00037#12 by sakura add
            #170109-00037#12 by sakura mark(S)
            #UPDATE astp405_tmp
            #   SET sel = 'Y'
            #170109-00037#12 by sakura mark(E)
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

            UPDATE astp405_tmp
               SET sel = 'N'
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            #170109-00037#12 by sakura add(S)
            CALL cl_err_collect_init()
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  CALL s_transaction_begin()
                  LET l_ac = li_idx
                  CALL astp405_lock_chk()
                  CALL s_transaction_end('Y',0)
               END IF
               UPDATE astp405_tmp
                  SET sel = g_detail_d[l_ac].sel
                WHERE stfl001 = g_detail_d[l_ac].stfl001
                  AND stflseq = g_detail_d[l_ac].stflseq               
            END FOR
            CALL cl_err_collect_show()
            #170109-00037#12 by sakura add(E)
            #170109-00037#12 by sakura mark(S)
            #UPDATE astp405_tmp
            #  SET sel = 'Y'
            # WHERE stfl001 = g_detail_d[li_idx].stfl001
            #   AND stflseq = g_detail_d[li_idx].stflseq
            #170109-00037#12 by sakura mark(E)
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            #170109-00037#8 by sakura mark(S)
            UPDATE astp405_tmp
               SET sel = 'N' 
             WHERE stfl001 = g_detail_d[li_idx].stfl001
               AND stflseq = g_detail_d[li_idx].stflseq
            #170109-00037#8 by sakura mark(E)
            #170109-00037#8 by sakura add(S)
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
                   UPDATE astp405_tmp
                      SET sel = 'N'
                    WHERE stfl001 = g_detail_d[li_idx].stfl001
                      AND stflseq = g_detail_d[li_idx].stflseq
               END IF
            END FOR            
            #170109-00037#8 by sakura add(E)
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL astp405_filter()
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
            CALL astp405_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL astp405_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            
            IF g_bgjob <> "Y" THEN
               CALL cl_progress_bar_no_window(2)    
            END IF
            
            #170109-00037#12 by sakura add(S)
            #資料處理LOCK
            CALL cl_err_collect_init()
            LET l_lockcnt = 0
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF g_detail_d[li_idx].sel = "Y" THEN
                 CALL s_transaction_begin()
                 LET l_ac = li_idx                 
                 CALL astp405_lock_chk()
                 CALL s_transaction_end('Y',0)
                 IF g_detail_d[li_idx].sel = "N" THEN
                    LET l_lockcnt = l_lockcnt + 1
                    UPDATE astp405_tmp 
                       SET sel = 'N'
                     WHERE stfl001 = g_detail_d[l_ac].stfl001
                       AND stflseq = g_detail_d[l_ac].stflseq
                 END IF
               END IF
            END FOR 
            #170109-00037#12 by sakura add(E)
            SELECT COUNT(1) INTO l_count
              FROM astp405_tmp
             WHERE sel = 'Y'
            IF l_count = 0 THEN
               #170109-00037#8 by sakura add(S)
               IF l_lockcnt > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ast-00867'   #目前選取的資料，均已被鎖定，請重新操作
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               ELSE
               #170109-00037#8 by sakura add(E)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "请选取需要跟新的合同项次" 
                  LET g_errparam.code   = "adz-00482"
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF
            ELSE
               #CALL astp405_merge_stfl()   #170109-00037#12 by sakura mark
               #170109-00037#12 by sakura add(S)
               CALL s_transaction_begin()
               IF NOT astp405_merge_stfl() THEN
                  CALL s_transaction_end('N',0)
               ELSE
                  CALL s_transaction_end('Y',0)
               END IF
               #170109-00037#12 by sakura add(E)
            END IF
            CALL cl_err_collect_show()   #170109-00037#12 by sakura add  
            
            
         ON ACTION export_to_excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN               
               CALL g_export_node.clear()
              
               LET g_export_node[1] = base.typeInfo.create(g_detail_d)
               LET g_export_id[1]   = "s_detail1"

              
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
               
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
 
{<section id="astp405.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION astp405_query()
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
   CALL astp405_b_fill()
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
 
{<section id="astp405.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION astp405_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_where         STRING
   DEFINE merge_type      STRING
   DEFINE l_sql_ins       STRING
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL s_aooi500_sql_where(g_prog,'stfasite') RETURNING l_where
   
   IF cl_null(g_wc) THEN 
      LET g_wc = " 1=1"
   END IF
   
   
   LET g_sql = " SELECT distinct   'N', stflsite,ooefl003,stfl001,stflseq,
                                        stfa005,mhael023,stfa010,pmaal003,
                                        stfa051,rtaxl003,stfa050,stfl002,
                                        stael003,stfl003,DECODE(stfl007,NULL,0,stfl007),",
               #"                        DECODE('",type,"','1','比例调整','金额调整'),",
               "                        '',",
               "                        DECODE('",type_1,"','1','",rate,"'/100,'",amount,"'),
                                        DECODE('",type_1,"','1',DECODE(stfl007,NULL,0,stfl007)*(1+'",rate,"'/100),DECODE(stfl007,NULL,0,stfl007)+'",amount,"') ",
               "  FROM stfl_t INNER JOIN stfa_t ON stfaent = stflent AND stfa001 = stfl001 ",  
               "               LEFT JOIN ooefl_t ON ooeflent = stflent AND ooefl001 = stflsite AND ooefl002 = '",g_dlang,"' ",
               "               LEFT JOIN mhael_t ON mhaelent = stfaent AND mhael001 = stfa005  AND mhael022 = '",g_dlang,"' ",
               "               LEFT JOIN pmaal_t ON pmaalent = stfaent AND pmaal001 = stfa010  AND pmaal002 = '",g_dlang,"' ",
               "               LEFT JOIN rtaxl_t ON rtaxlent = stfaent AND rtaxl001 = stfa051  AND rtaxl002 = '",g_dlang,"' ",
               "               LEFT JOIN stael_t ON staelent = stflent AND stael001 = stfl002  AND stael002 = '",g_dlang,"' ",

               " WHERE stflent = ? ",
               "   AND ",g_wc CLIPPED,
               " ORDER BY stfl001,stflseq " 
   
   TRUNCATE TABLE astp405_tmp
   
   LET l_sql_ins = " INSERT INTO astp405_tmp ",g_sql
   PREPARE ins_astp405 FROM l_sql_ins
   EXECUTE ins_astp405 USING g_enterprise
   
   LET merge_type = " MERGE INTO astp405_tmp O",
                    " USING ( SELECT stfl001,stflseq,DECODE(l_type,'1','1：按比例调整','2：按金额调整')  A
                                FROM astp405_tmp   ) U ",
                    "   ON (O.stfl001 = U.stfl001 AND O.stflseq = U.stflseq ) ",
                    " WHEN MATCHED THEN ",
                    "      UPDATE SET O.l_type = U.A "
   EXECUTE IMMEDIATE merge_type     
   
   LET g_sql = " SELECT * FROM astp405_tmp WHERE '",g_enterprise,"' = ? "
   #end add-point
 
   PREPARE astp405_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR astp405_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
     g_detail_d[l_ac].sel      ,
     g_detail_d[l_ac].stflsite ,
     g_detail_d[l_ac].ooefl003 ,
     g_detail_d[l_ac].stfl001  ,
     g_detail_d[l_ac].stflseq  ,
     g_detail_d[l_ac].stfa005  ,
     g_detail_d[l_ac].mhael023 ,
     g_detail_d[l_ac].stfa010  ,
     g_detail_d[l_ac].pmaal003 ,
     g_detail_d[l_ac].stfa051  ,
     g_detail_d[l_ac].rtaxl003 ,
     g_detail_d[l_ac].stfa050  ,
     g_detail_d[l_ac].stfl002  ,
     g_detail_d[l_ac].stael003 ,
     g_detail_d[l_ac].stfl003  ,
     g_detail_d[l_ac].stfl007  ,
     g_detail_d[l_ac].l_type   ,
     g_detail_d[l_ac].l_adjust ,
     g_detail_d[l_ac].l_stfl007

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
      
      CALL astp405_detail_show()      
 
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
   FREE astp405_sel
   
   LET l_ac = 1
   CALL astp405_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
 
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="astp405.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION astp405_fetch()
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
 
{<section id="astp405.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION astp405_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="astp405.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION astp405_filter()
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
   
   CALL astp405_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="astp405.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION astp405_filter_parser(ps_field)
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
 
{<section id="astp405.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION astp405_filter_show(ps_field,ps_object)
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
   LET ls_condition = astp405_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="astp405.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 更新合同收费项目单价
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                :    RETURNING r_success
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: r_success      True/False
# Date & Author..: 2016-07-26 by lanjj
# Modify.........: 2016-02-07 by sakura 增加回傳值#170109-00037#12
################################################################################
PRIVATE FUNCTION astp405_merge_stfl()

DEFINE l_merge    STRING
DEFINE l_merge2   STRING
DEFINE l_date     LIKE stfa_t.stfamoddt
#170109-00037#12 by sakura add(S)
DEFINE r_success   LIKE type_t.num5
DEFINE l_stfl001_tmp  LIKE stfl_t.stfl001
DEFINE l_stflseq_tmp  LIKE stfl_t.stflseq
DEFINE l_stfl001      LIKE stfl_t.stfl001
DEFINE l_stflseq      LIKE stfl_t.stflseq
DEFINE l_count        LIKE type_t.num10
#170109-00037#12 by sakura add(E)
   
   #170109-00037#12 by sakura add(S)
   LET r_success = TRUE
   #LOCK檢查
   LET g_sql = "SELECT stfl001,stflseq FROM astp405_tmp WHERE sel = 'Y' "
   PREPARE astp405_chk_lock_stfl_pre FROM g_sql
   DECLARE astp405_chk_lock_stfl_cs CURSOR FOR astp405_chk_lock_stfl_pre
   
   LET l_stfl001_tmp = ''
   LET l_stflseq_tmp = ''
   
   FOREACH astp405_chk_lock_stfl_cs INTO l_stfl001_tmp,l_stflseq_tmp
     
     EXECUTE astp405_chk_lock_stfl USING l_stfl001_tmp,l_stflseq_tmp INTO l_stfl001,l_stflseq
                                    
     IF cl_null(l_stfl001) OR cl_null(l_stflseq) THEN
        UPDATE astp405_tmp 
           SET sel = 'N'
         WHERE stfl001 = l_stfl001_tmp
           AND stflseq = l_stflseq_tmp
     END IF     
   END FOREACH
   
   LET l_count = 0
   SELECT COUNT(1) INTO l_count
     FROM astp405_tmp
    WHERE sel = 'Y'
   IF l_count = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ast-00867'   #目前選取的資料，均已被鎖定，請重新操作
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success      
   END IF   
   #170109-00037#12 by sakura add(S)
      
   
   LET l_date = cl_get_current()
   
   LET l_merge = " MERGE INTO stfl_t O",
                 " USING ( 
                           SELECT stfl001,stflseq,l_stfl007 A
                             FROM astp405_tmp  
                            WHERE sel = 'Y'
                          ) U ",
                 "    ON (O.stfl001 = U.stfl001 AND O.stflseq = U.stflseq AND O.stflent = '",g_enterprise,"') ",
                 " WHEN MATCHED THEN ",
                 "      UPDATE SET O.stfl007 = U.A "
   EXECUTE IMMEDIATE l_merge
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "merge stfl_t" 
      LET g_errparam.code   = 'adz-00482'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      #170109-00037#12 by sakura add(S)
      LET r_success = FALSE   
      RETURN r_success
      #170109-00037#12 by sakura add(E)
   ELSE   
#      LET l_merge2 = " UPDATE stfa_t SET stfamoddt = '",l_date,"' ,  #170206-00020#1  20170209 mark by 08172
      LET l_merge2 = " UPDATE stfa_t SET stfamoddt = to_date('",l_date,"','YYYY-MM-DD hh24:mi:ss') ,",   #170206-00020#1  20170209 add by 08172
                     "                   stfamodid = '",g_user,"' ",
                     "  WHERE stfaent = '",g_enterprise,"' ",
                     "    AND EXISTS ( SELECT 1 FROM astp405_tmp WHERE stfl001 = stfa001 )"
      EXECUTE IMMEDIATE l_merge2
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "merge stfa_t" 
         LET g_errparam.code   = 'adz-00482'
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         #170109-00037#12 by sakura add(S)
         LET r_success = FALSE   
         RETURN r_success
         #170109-00037#12 by sakura add(E)         
      ELSE 
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "更新成功" 
         LET g_errparam.code   = 'adz-00482'
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
   END IF
   
   RETURN r_success   #170109-00037#12 by sakura add   
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
# Date & Author..: 2016-07-26 by lanjj
# Modify.........:
################################################################################
PRIVATE FUNCTION astp405_set_entry()

   CALL cl_set_comp_entry("sel",TRUE)
   CALL cl_set_comp_entry("stflsite",FALSE)
   CALL cl_set_comp_entry("l_ooefl003",FALSE)
   CALL cl_set_comp_entry("stfl001",FALSE)
   CALL cl_set_comp_entry("stflseq",FALSE)
   CALL cl_set_comp_entry("stfa005_1",FALSE)
   CALL cl_set_comp_entry("l_mhael023",FALSE)
   CALL cl_set_comp_entry("stfa010_1",FALSE)
   CALL cl_set_comp_entry("l_pmaal003",FALSE)
   CALL cl_set_comp_entry("stfa051_1",FALSE)
   CALL cl_set_comp_entry("l_rtaxl003",FALSE)
   CALL cl_set_comp_entry("stfa050_1",FALSE)
   CALL cl_set_comp_entry("stfl002_1",FALSE)
   CALL cl_set_comp_entry("l_stael003",FALSE)
   CALL cl_set_comp_entry("stfl003_1",FALSE)
   CALL cl_set_comp_entry("stfl007",FALSE)
   CALL cl_set_comp_entry("l_type",FALSE)
   CALL cl_set_comp_entry("l_adjust",FALSE)
   CALL cl_set_comp_entry("l_stfl007_1",TRUE)
   
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
# Date & Author..: 2016-07-26 by lanjj 
# Modify.........:
################################################################################
PRIVATE FUNCTION astp405_create_tmp()
DEFINE r_success         LIKE type_t.num5
DEFINE l_create1         STRING 
DEFINE l_create2         STRING
DEFINE l_create3         STRING
DEFINE l_session         LIKE type_t.num10   #170109-00037#8 by sakura add

   WHENEVER ERROR CONTINUE

   #170109-00037#8 by sakura add(S)
   #查詢session編號
   LET l_session = ''
   SELECT USERENV('SESSIONID') INTO l_session FROM DUAL
   DISPLAY "[astp405_create_temp_session_id] ",l_session
   #170109-00037#8 by sakura add(E)

   LET r_success = TRUE

   IF NOT astp405_drop_tmp() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   CREATE TEMP TABLE astp405_tmp(
     sel          LIKE type_t.chr1    ,
     stflsite     LIKE stfl_t.stflsite,    
     ooefl003     LIKE ooefl_t.ooefl003,  
     stfl001      LIKE stfl_t.stfl001 ,    
     stflseq      LIKE stfl_t.stflseq , 
     stfa005      LIKE stfa_t.stfa005 , 
     mhael023     LIKE mhael_t.mhael023, 
     stfa010      LIKE stfa_t.stfa010 , 
     pmaal003     LIKE pmaal_t.pmaal003, 
     stfa051      LIKE stfa_t.stfa051 , 
     rtaxl003     LIKE rtaxl_t.rtaxl003, 
     stfa050      LIKE stfa_t.stfa050 , 
     stfl002      LIKE stfl_t.stfl002 , 
     stael003     LIKE stael_t.stael003, 
     stfl003      LIKE stfl_t.stfl003 , 
     stfl007      LIKE stfl_t.stfl007 , 
     l_type       LIKE pmaal_t.pmaal003,
     l_adjust     LIKE type_t.num20_6, 
     l_stfl007    LIKE stfl_t.stfl007  
     )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create astp405_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
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
# Date & Author..: 2016-07-26 by lanjj
# Modify.........:
################################################################################
PRIVATE FUNCTION astp405_drop_tmp()
DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE astp405_tmp

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop astp405_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 檢查該筆的stfl_t是否被lock
# Memo...........:
# Usage..........: CALL astp405_lock_chk()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2017/01/16  By sakura #170109-00037#12
# Modify.........:
################################################################################
PRIVATE FUNCTION astp405_lock_chk()
   DEFINE l_stfl001 LIKE stfl_t.stfl001
   DEFINE l_stflseq LIKE stfl_t.stflseq
   
   LET l_stfl001 = ''
   LET l_stflseq = ''
   
   EXECUTE astp405_chk_lock_stfl USING g_detail_d[l_ac].stfl001,g_detail_d[l_ac].stflseq
                                  INTO l_stfl001,l_stflseq
                                  
   IF cl_null(l_stfl001) OR cl_null(l_stflseq) THEN
      LET g_detail_d[l_ac].sel = 'N'
      
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = 'ast-00869'
      LET g_errparam.replace[1] = g_detail_d[l_ac].stfl001
	   LET g_errparam.replace[2] = g_detail_d[l_ac].stflseq
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF
END FUNCTION

#end add-point
 
{</section>}
 
