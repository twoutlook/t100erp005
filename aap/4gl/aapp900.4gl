#該程式未解開Section, 採用最新樣板產出!
{<section id="aapp900.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2015-04-09 09:08:54), PR版次:0009(2016-10-12 14:33:15)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000129
#+ Filename...: aapp900
#+ Description: 應付帳款關帳作業
#+ Creator....: 03538(2014-08-20 10:47:20)
#+ Modifier...: 04152 -SD/PR- 08732
 
{</section>}
 
{<section id="aapp900.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#150112-00026#1          By Reanna  1.應立帳未立帳之交易單據：勾選法人檢核輔帳是否立帳，取aoos020之輔帳 2.執行帳款單檢核：增加單別參數要抛傳票之單別才檢核 3.應付款日未付款據：隱藏
#               15/01/27 By albireo 檢核應立帳未立帳時,多增加組織範圍
#150127-00007#1 15/02/24 By Reanna  掃把清空&給預設值
#150408-00006#2 15/04/09 By Reanna  檢查的範圍改為截止日期對應的會計週期期間起訖，aapp900檢核項隱藏預設=N
#160812-00027#3 16/08/16 By 06821   全面盤點應付程式帳套權限控管
#161006-00005#3 16/10/12 By 08732   組織類型與職能開窗調整
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
        sel              LIKE type_t.chr1,
        ooef017          LIKE ooef_t.ooef017,
        ooefl003         LIKE ooefl_t.ooefl003,
        ooab002          LIKE ooab_t.ooab002
                     END RECORD
TYPE type_master RECORD
        ooef001          LIKE ooef_t.ooef001,  
        ooef001_desc     LIKE type_t.chr80,
        ooab002          LIKE ooab_t.ooab002,
        chk1             LIKE type_t.chr1, 
        chk2             LIKE type_t.chr1, 
        chk3             LIKE type_t.chr1, 
        chk4             LIKE type_t.chr1  
                     END RECORD
DEFINE g_master          type_master
DEFINE g_detail_idx      LIKE type_t.num5
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
GLOBALS "../../cfg/top_finance.inc"       #財務模組使用
DEFINE g_glaa003     LIKE glaa_t.glaa003  #會計週期參照表
DEFINE g_glaa013     LIKE glaa_t.glaa013  #最後關帳日
DEFINE g_type        LIKE type_t.chr1     #帳別類型 主帳/輔帳
#end add-point
 
{</section>}
 
{<section id="aapp900.main" >}
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
   CALL cl_ap_init("aap","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
 
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapp900 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapp900_init()   
 
      #進入選單 Menu (="N")
      CALL aapp900_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aapp900
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aapp900.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aapp900_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
DEFINE r_success LIKE type_t.num5
DEFINE r_empsite LIKE ooab_t.ooabsite
DEFINE r_errno   LIKE gzze_t.gzze001
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   #展組織下階成員所需之暫存檔
   CALL s_fin_create_account_center_tmp()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapp900.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapp900_ui_dialog()
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
   #150127-00007#1
   CALL aapp900_qbe_clear()
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aapp900_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_master.ooef001,g_master.ooab002,
                       g_master.chk1,g_master.chk2,g_master.chk3,g_master.chk4
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            AFTER FIELD ooef001
               LET g_master.ooef001_desc = ' '
               DISPLAY BY NAME g_master.ooef001_desc
               IF NOT cl_null(g_master.ooef001) THEN
                  CALL s_fin_account_center_with_ld_chk(g_master.ooef001,'','','3','N','',g_master.ooab002) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD ooef001
                  END IF
               END IF           
               LET g_master.ooef001_desc = s_desc_get_department_desc(g_master.ooef001)
               DISPLAY BY NAME g_master.ooef001_desc       

            ON ACTION controlp INFIELD ooef001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.ooef001       #給予default值
               #LET g_qryparam.where = " ooef201 = 'Y' "       #160812-00027#3 mark
               #CALL q_ooef001()     #161006-00005#3  mark
               CALL q_ooef001_46()   #161006-00005#3  add
               LET g_master.ooef001 = g_qryparam.return1        #將開窗取得的值回傳到變數
               CALL s_desc_get_department_desc(g_master.ooef001) RETURNING g_master.ooef001_desc
               DISPLAY BY NAME g_master.ooef001,g_master.ooef001_desc
               LET g_qryparam.where = ''
               NEXT FIELD ooef001  
            
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         INPUT ARRAY g_detail_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                       INSERT ROW = FALSE,
                       DELETE ROW = FALSE,
                       APPEND ROW = FALSE)
            BEFORE ROW
               LET l_ac = ARR_CURR()
               DISPLAY l_ac TO FORMONLY.h_index
         END INPUT
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
            CALL aapp900_filter()
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
            CALL aapp900_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            #150127-00007#1
            CALL aapp900_qbe_clear()
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL aapp900_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            CALL aapp900_process()
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
 
{<section id="aapp900.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapp900_query()
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
   CALL aapp900_b_fill()
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
 
{<section id="aapp900.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapp900_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('3',g_master.ooef001,g_today,'1')
   #取得帳務組織底下所屬的法人範圍
   CALL s_fin_account_center_comp_str() RETURNING ls_wc
   #將取回的字串轉換為SQL條件
   CALL s_fin_get_wc_str(ls_wc) RETURNING ls_wc  
   LET g_sql =" SELECT 'Y',ooef001,'',ooab002 FROM ooef_t,ooab_t ",
              "  WHERE ooefent = ooabent AND ooef001=ooabsite ",
              "    AND ooab001='S-FIN-3007'",
              "    AND ooefent = ? ",
              "    AND ooef001 IN ",ls_wc
   #end add-point
 
   PREPARE aapp900_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aapp900_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
      g_detail_d[l_ac].*
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
      LET g_detail_d[l_ac].ooefl003 = s_desc_get_department_desc(g_detail_d[l_ac].ooef017)
      #end add-point
      
      CALL aapp900_detail_show()      
 
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
   IF g_detail_d.getLength() > 0 THEN
      CALL g_detail_d.deleteElement(g_detail_d.getLength())
   END IF
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aapp900_sel
   
   LET l_ac = 1
   CALL aapp900_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   DISPLAY l_ac TO FORMONLY.h_index
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapp900.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapp900_fetch()
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
 
{<section id="aapp900.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aapp900_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapp900.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aapp900_filter()
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
   
   CALL aapp900_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="aapp900.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aapp900_filter_parser(ps_field)
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
 
{<section id="aapp900.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aapp900_filter_show(ps_field,ps_object)
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
   LET ls_condition = aapp900_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aapp900.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 清空&給預設 #150127-00007#1
# Memo...........:
# Usage..........: CALL aapp900_qbe_clear()
# Date & Author..: 2015/02/24 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp900_qbe_clear()
   
   CLEAR FORM
   INITIALIZE g_master.* TO NULL
   CALL g_detail_d.clear()
   
   LET g_master.ooef001 = g_site
   LET g_master.ooef001_desc = s_desc_get_department_desc(g_master.ooef001)
   DISPLAY BY NAME g_master.ooef001_desc
   LET g_master.ooab002 = g_today
   #應立帳未立帳之交易單據
   #LET g_master.chk1 = 'Y' #150408-00006#2 mark
   LET g_master.chk1 = 'N'  #150408-00006#2
   #執行帳款單檢核
   #LET g_master.chk2 = 'Y' #150408-00006#2 mark
   LET g_master.chk2 = 'N'  #150408-00006#2
   #單據號碼連續號檢核
   LET g_master.chk3 = 'N'
   #應付款日未付款單據
   LET g_master.chk4 = 'N'
   
END FUNCTION

################################################################################
# Descriptions...: 資料處理
# Memo...........:
# Usage..........: CALL aapp900_process()
# Input parameter: 
# Date & Author..: 2014/09/09 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp900_process()
DEFINE l_n         LIKE type_t.num5
DEFINE l_cnt       LIKE type_t.num5
DEFINE l_ask       LIKE type_t.chr5
DEFINE p_comp      LIKE glaa_t.glaacomp

   #albireo 150225-----s
   IF cl_null(g_master.ooab002) OR cl_null(g_master.ooef001) THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = 'aap-00332'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   #albireo 150225-----e
   LET l_ask = "N"

   CALL s_azzi902_get_gzzd('aapp900',"lbl_glaald")    RETURNING g_coll_title[1],g_coll_title[1]  #帳別
   CALL s_azzi902_get_gzzd('aapp900',"lbl_oobx004")   RETURNING g_coll_title[2],g_coll_title[2]  #作業編號
   #CALL s_azzi902_get_gzzd('aapp901',"lbl_apdadocdt") RETURNING g_coll_title[3],g_coll_title[3]  #日期
   CALL cl_getmsg('aap-00339',g_lang) RETURNING g_coll_title[3]   #albireo 150225 150213-00005#3
   CALL s_azzi902_get_gzzd('aapp900',"lbl_apdadocno") RETURNING g_coll_title[4],g_coll_title[1]  #單據編號
   CALL s_azzi902_get_gzzd('aapp900',"lbl_nmbbseq")   RETURNING g_coll_title[5],g_coll_title[5]  #項次 
   
   #清空顯示條
   DISPLAY '' ,0 TO stagenow,stagecomplete
   #總共有幾筆資料要跑
   LET l_cnt = 0
   FOR l_n = 1 TO g_detail_d.getLength()
      IF g_detail_d[l_n].sel = "Y" THEN
         LET l_cnt = l_cnt + 1
      END IF
   END FOR
   IF l_cnt = 0 THEN
      #未選擇資料
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adb-00078'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   CALL cl_progress_bar_no_window(l_cnt)
         
   CALL cl_err_collect_init()
   FOR l_n = 1 TO g_detail_d.getLength()
      IF g_detail_d[l_n].sel = "Y" THEN
         #檢核
         CALL cl_progress_no_window_ing(s_desc_show1(g_detail_d[l_n].ooef017,g_detail_d[l_n].ooefl003))
         CALL aapp900_chk_item(g_detail_d[l_n].ooef017) RETURNING g_sub_success
         IF NOT g_sub_success THEN
            LET l_ask = "Y"
         END IF
      END IF
   END FOR
   CALL cl_err_collect_show()

   #若檢核有錯誤，詢問「檢核錯誤是否仍要執行關帳作業?」
   IF l_ask = "Y" THEN
      IF NOT cl_ask_confirm('aap-00137') THEN
         RETURN
      END IF
   END IF
   FOR l_n = 1 TO g_detail_d.getLength()
      IF g_detail_d[l_n].sel = "Y" THEN
         #回寫關帳日期
         CALL aapp900_writeback_closeday(g_detail_d[l_n].ooef017,g_master.ooab002) RETURNING g_sub_success
      END IF
   END FOR

   #顯示執行成功的訊息
   IF g_sub_success THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-00217'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL aapp900_b_fill()
   ELSE
      #執行失敗
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-00218'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL aapp900_b_fill()
   END IF
END FUNCTION

################################################################################
# Descriptions...: 檢查項目
# Memo...........:
# Usage..........: CALL aapp900_chk_item(p_comp)
#                  RETURNING r_success
# Input parameter: p_comp   法人
# Date & Author..: 2014/09/04 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp900_chk_item(p_comp)
DEFINE r_all_ld  DYNAMIC ARRAY OF RECORD
             l_ld    LIKE glaa_t.glaald,
             l_type  LIKE type_t.chr1
                 END RECORD
DEFINE r_success LIKE type_t.num5
DEFINE l_type    LIKE type_t.chr1
DEFINE l_n       LIKE type_t.num5
DEFINE l_len     LIKE type_t.num5
DEFINE p_comp    LIKE glaa_t.glaacomp

   LET r_success     = TRUE
   LET g_sub_success = TRUE
   IF cl_null(g_master.ooab002) THEN
      RETURN FALSE
   END IF
   
   CALL r_all_ld.clear()
   #取得該法人之所有帳別
   CALL aapp900_get_all_ld(p_comp) RETURNING r_all_ld
   LET l_len = r_all_ld.getLength()

   #檢核:應立帳卻未立帳之交易單據
   IF g_master.chk1 ='Y' THEN
      FOR l_n = 1 TO  l_len
         CALL s_aapp900_chk_cre_journal(r_all_ld[l_n].l_ld,p_comp,g_master.ooab002,r_all_ld[l_n].l_type) RETURNING g_sub_success   
            #albireo 150127 add p_comp
         IF NOT g_sub_success THEN
            LET r_success = FALSE
         END IF
      END FOR
   END IF
 
   #檢核:帳款單
   IF g_master.chk2 ='Y' THEN
      FOR l_n = 1 TO  l_len
         CALL s_aapp900_chk_bill(r_all_ld[l_n].l_ld,p_comp,g_master.ooab002,r_all_ld[l_n].l_type) RETURNING g_sub_success
         IF NOT g_sub_success THEN
            LET r_success = FALSE
         END IF
      END FOR
   END IF
 
   #檢核:單據號碼連續號
   IF g_master.chk3 ='Y' THEN
      FOR l_n = 1 TO  l_len
         CALL s_aapp900_chk_docno(r_all_ld[l_n].l_ld,p_comp,g_master.ooab002) RETURNING g_sub_success
         IF NOT g_sub_success THEN
            LET r_success = FALSE
         END IF
      END FOR
   END IF

   #檢核:已付款項無沖銷對應紀錄者
   IF g_master.chk4 ='Y' THEN
      FOR l_n = 1 TO  l_len
         CALL s_aapp900_chk_deadline(r_all_ld[l_n].l_ld,p_comp,g_master.ooab002,r_all_ld[l_n].l_type) RETURNING g_sub_success
         IF NOT g_sub_success THEN
            LET r_success = FALSE
         END IF
      END FOR
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 取得該法人之所有主帳&平行帳
# Memo...........:
# Usage..........: CALL aapp900_get_all_ld(p_comp)
#                  RETURNING 回传参数
# Input parameter: p_comp      法人
# Return code....: r_all_ld    帳別
# Date & Author..: 2014/09/10 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp900_get_all_ld(p_comp)
DEFINE p_comp    LIKE glaa_t.glaacomp
DEFINE r_all_ld  DYNAMIC ARRAY OF RECORD
             l_ld    LIKE glaa_t.glaald,
             l_type  LIKE type_t.chr1
                 END RECORD
DEFINE l_all_ld  STRING
DEFINE l_n       LIKE type_t.num5
DEFINE l_ld      LIKE glaa_t.glaald
DEFINE l_type    LIKE type_t.chr1

DEFINE l_sql     STRING
   
   #150112-00026#1修改抓帳套寫法-------------------------------------
   CALL r_all_ld.clear()
   LET l_sql = "SELECT DISTINCT glaald ",
               "  FROM s_fin_tmp1",
               " WHERE comp= '",p_comp,"' AND glaald IS NOT NULL"
   PREPARE get_ld_pre FROM l_sql
   DECLARE get_ld_cur CURSOR FOR get_ld_pre
   LET l_n = 1
   FOREACH get_ld_cur INTO l_ld
      #判斷是不是主帳or輔帳二or輔帳三
      #0:無/1:主帳/2:輔帳1(帳套2)/2:輔帳2(帳套3)
      CALL s_fin_get_ld_type(l_ld) RETURNING l_type
      IF l_type = 0 THEN
         CONTINUE FOREACH
      END IF
      LET r_all_ld[l_n].l_ld = l_ld
      LET r_all_ld[l_n].l_type = l_type
      LET l_n = l_n + 1
   END FOREACH
   
   IF r_all_ld.getLength() > 0 THEN
      CALL r_all_ld.deleteElement(l_n)
   END IF
   #150112-00026#1修改抓帳套寫法 END---------------------------------
   
   RETURN r_all_ld

END FUNCTION

################################################################################
# Descriptions...: 回寫關帳日期
# Memo...........:
# Usage..........: CALL aapp900_writeback_closeday(p_comp,p_closeday)
# Input parameter: p_comp       法人
#                : p_closeday   關帳日期
# Date & Author..: 2014/09/10 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp900_writeback_closeday(p_comp,p_closeday)
DEFINE p_comp      LIKE glaa_t.glaacomp
DEFINE p_closeday  LIKE type_t.dat
DEFINE r_success  LIKE type_t.num5

#抓出有勾選的法人
#抓出每個法人底下的帳套
#都update關帳日期
   
   LET r_success = TRUE
   IF NOT cl_null(p_comp) THEN
      UPDATE ooab_t
         SET ooab002 = p_closeday
       WHERE ooabent = g_enterprise
         AND ooab001 = 'S-FIN-3007'
         AND ooabsite = p_comp
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'UPDATE ooab_t wrong'
         LET g_errparam.popup = TRUE
         LET g_errparam.sqlerr = SQLCA.SQLCODE
         CALL cl_err()
         LET r_success = FALSE
      END IF
   END IF
    
   RETURN r_success

END FUNCTION

#end add-point
 
{</section>}
 
