#該程式未解開Section, 採用最新樣板產出!
{<section id="afmp510.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2015-05-22 14:42:34), PR版次:0003(2016-10-24 09:39:36)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000038
#+ Filename...: afmp510
#+ Description: 投資系統重評價作業
#+ Creator....: 04152(2015-05-13 10:51:35)
#+ Modifier...: 04152 -SD/PR- 06814
 
{</section>}
 
{<section id="afmp510.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#161006-00005#24   16/10/24 By 06814          帳務中心(fmnasite)開窗改用q_ooef001_46() 
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
   fmna001           LIKE fmna_t.fmna001,
   fmna001_desc      LIKE type_t.chr80,
   fmnadocno         LIKE fmna_t.fmnadocno,
   fmnacomp          LIKE fmna_t.fmnacomp,
   fmnacomp_desc     LIKE type_t.chr80,
   glaa001           LIKE glaa_t.glaa001,
   glca002           LIKE glca_t.glca002,
   glca003           LIKE glca_t.glca003,
   fmnadocdt         LIKE fmna_t.fmnadocdt,
   glaa024           LIKE glaa_t.glaa024
END RECORD
TYPE type_master RECORD
   fmnasite          LIKE fmna_t.fmnasite,
   fmnasite_desc     LIKE type_t.chr80,
   fmna002           LIKE fmna_t.fmna002,
   fmna003           LIKE fmna_t.fmna003
      END RECORD
DEFINE g_master      type_master
DEFINE g_sfin3007    LIKE type_t.chr80
DEFINE g_fmna002     LIKE fmna_t.fmna002
DEFINE g_fmna003     LIKE fmna_t.fmna003
DEFINE g_wc_fmna001  STRING
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="afmp510.main" >}
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
   CALL cl_ap_init("afm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afmp510 WITH FORM cl_ap_formpath("afm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afmp510_init()   
 
      #進入選單 Menu (="N")
      CALL afmp510_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_afmp510
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="afmp510.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION afmp510_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_glca002','8317')
   CALL cl_set_combo_scc('b_glca003','8724')
   
   #展組織下階成員所需之暫存檔
   CALL s_fin_create_account_center_tmp()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afmp510.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afmp510_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
DEFINE l_sfin30072 LIKE type_t.chr80
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL afmp510_qbe_clear()
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL afmp510_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_master.fmnasite,g_master.fmna002,g_master.fmna003
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            AFTER FIELD fmnasite
               LET g_master.fmnasite_desc = ' '
               DISPLAY BY NAME g_master.fmnasite_desc
               IF NOT cl_null(g_master.fmnasite) THEN
                  CALL s_fin_account_center_with_ld_chk(g_master.fmnasite,'','','3','N','',g_today) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD fmnasite
                  END IF
                  CALL cl_get_para(g_enterprise,g_master.fmnasite,'S-FIN-3007') RETURNING g_sfin3007
                  LET g_master.fmna002 = YEAR(g_sfin3007)
                  LET g_master.fmna003 = MONTH(g_sfin3007)
                  #預設關帳之年月
                  LET g_fmna002 = g_master.fmna002
                  LET g_fmna003 = g_master.fmna003
               END IF
               LET g_master.fmnasite_desc = s_desc_get_department_desc(g_master.fmnasite)
               DISPLAY BY NAME g_master.fmnasite_desc
         
            
            AFTER FIELD fmna002
               IF NOT cl_ap_chk_range(g_master.fmna002,"0","0","2099","1","azz-00087",1) THEN
                  NEXT FIELD fmna002
               END IF
               IF g_master.fmna002 < g_fmna002 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00248'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  LET g_master.fmna002 = g_fmna002
                  NEXT FIELD CURRENT
               END IF
            
            
            AFTER FIELD fmna003
               IF NOT cl_ap_chk_range(g_master.fmna003,"0","0","12","1","azz-00087",1) THEN
                  NEXT FIELD fmna003
               END IF
               IF g_master.fmna002 = g_fmna002 AND g_master.fmna003 < g_fmna003 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00249'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  LET g_master.fmna003 = g_fmna003
                  NEXT FIELD CURRENT
               END IF
            
            
            ON ACTION controlp INFIELD fmnasite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.fmnasite
               #161006-00005#24 20161024 mark by beckxie---S
               #LET g_qryparam.where = " ooef204 = 'Y' "
               #CALL q_ooef001()
               #161006-00005#24 20161024 mark by beckxie---E
               CALL q_ooef001_46()   #161006-00005#24 20161024 add by beckxie
               LET g_master.fmnasite = g_qryparam.return1
               CALL s_desc_get_department_desc(g_master.fmnasite) RETURNING g_master.fmnasite_desc
               DISPLAY BY NAME g_master.fmnasite,g_master.fmnasite_desc
               NEXT FIELD fmnasite
         
         END INPUT
         
         
         INPUT ARRAY g_detail_d FROM s_detail1.*
            ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                      INSERT ROW = FALSE,
                      DELETE ROW = FALSE,
                      APPEND ROW = FALSE)
            
            BEFORE ROW
               LET l_ac = ARR_CURR()
               DISPLAY l_ac TO FORMONLY.h_index

            ON CHANGE b_sel
               LET l_ac = ARR_CURR()
               #CALL cl_set_comp_required("b_fmnadocno",FALSE)
               #IF g_detail_d[l_ac].sel = 'Y' THEN
               #   ##已有重評傳票不可重計算
               #   #IF NOT cl_null(g_detail_d[l_ac].xreb023) THEN
               #   #   LET g_detail_d[l_ac].sel = 'N'
               #   #   INITIALIZE g_errparam TO NULL
               #   #   LET g_errparam.code = 'axr-00118'
               #   #   LET g_errparam.extend = ''
               #   #   LET g_errparam.popup = FALSE
               #   #   CALL cl_err()
               #   #END IF
               #   #取所屬法人關帳日
               #   CALL cl_get_para(g_enterprise,g_detail_d[l_ac].fmnacomp,'S-FIN-3007') RETURNING l_sfin30072
               #   #所屬法人關帳日期單頭年度期別不同
               #   IF g_master.fmna002 <> YEAR(l_sfin30072) OR g_master.fmna003 <> MONTH(l_sfin30072) THEN
               #      LET g_detail_d[l_ac].sel = 'N'
               #      INITIALIZE g_errparam TO NULL
               #      LET g_errparam.code = 'aap-00138'
               #      LET g_errparam.extend = ''
               #      LET g_errparam.popup = FALSE
               #      CALL cl_err()
               #   END IF
               #   
               #   #CALL cl_set_comp_required("b_fmnadocno",TRUE)
               #END IF
            
            ON ACTION controlp INFIELD b_fmnadocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail_d[l_ac].fmnadocno
               LET g_qryparam.where = "ooba001 = '",g_detail_d[l_ac].glaa024,"' AND oobx003 = 'afmt570'"
               CALL q_ooba002_4()
               LET g_detail_d[l_ac].fmnadocno = g_qryparam.return1
               DISPLAY BY NAME g_detail_d[l_ac].fmnadocno
               NEXT FIELD b_fmnadocno
            
            
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
            CALL afmp510_filter()
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
            CALL afmp510_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            CALL afmp510_qbe_clear()
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL afmp510_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            CALL afmp510_process()
            IF g_success ='N' THEN
               CONTINUE DIALOG
            END IF
            #執行成功
            IF g_success = "Y" THEN
               CALL cl_ask_confirm3("std-00012","")
            END IF
            NEXT FIELD fmnasite
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
 
{<section id="afmp510.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION afmp510_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   IF g_master.fmna002 < g_fmna002 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00248'
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
      LET g_master.fmna002 = g_fmna002
      RETURN
   END IF

   IF g_master.fmna002 = g_fmna002 AND g_master.fmna003 < g_fmna003 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00249'
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
      LET g_master.fmna002 = g_fmna002
      LET g_master.fmna003 = g_fmna003
      RETURN
   END IF
   #end add-point
        
   LET g_error_show = 1
   CALL afmp510_b_fill()
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
 
{<section id="afmp510.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afmp510_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_flag          LIKE type_t.chr1
   DEFINE l_errno         LIKE type_t.chr100
   DEFINE l_glav002       LIKE glav_t.glav002
   DEFINE l_glav005       LIKE glav_t.glav005
   DEFINE l_sdate_s       LIKE glav_t.glav004
   DEFINE l_sdate_e       LIKE glav_t.glav004
   DEFINE l_glav006       LIKE glav_t.glav006
   DEFINE l_pdate_s       LIKE glav_t.glav004   #當期起始日
   DEFINE l_pdate_e       LIKE glav_t.glav004   #當期截止日
   DEFINE l_glav007       LIKE glav_t.glav007
   DEFINE l_wdate_s       LIKE glav_t.glav004
   DEFINE l_wdate_e       LIKE glav_t.glav004
   
   DEFINE l_glaa003       LIKE glaa_t.glaa003
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('3',g_master.fmnasite,g_today,'1')
   #取得帳務組織下所屬成員之帳別
   CALL s_fin_account_center_ld_str() RETURNING g_wc_fmna001
   #將取回的字串轉換為SQL條件
   CALL s_fin_get_wc_str(g_wc_fmna001) RETURNING g_wc_fmna001

   LET g_sql =" SELECT 'N',glaald,'','',glaacomp,'','',glca002,glca003,'',''",
              "   FROM glaa_t,glca_t ",
              "  WHERE glaaent = ? ",
              "    AND glaaent = glcaent ",
              "    AND glaald = glcald ",
              "    AND glca001 = 'FM' ",
              "    AND glca002 <> '1' ",    #無重評不撈出
              "    AND glaald IN ",g_wc_fmna001,
              "  ORDER BY glaald,glaacomp "
   #end add-point
 
   PREPARE afmp510_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR afmp510_sel
   
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
      #帳套名稱
      LET g_detail_d[l_ac].fmna001_desc = s_desc_get_ld_desc(g_detail_d[l_ac].fmna001)
      
      #法人名稱
      LET g_detail_d[l_ac].fmnacomp_desc = s_desc_get_department_desc(g_detail_d[l_ac].fmnacomp)
      
      #幣別
      CALL s_ld_sel_glaa(g_detail_d[l_ac].fmna001,'glaa001|glaa003|glaa024') 
           RETURNING g_sub_success,g_detail_d[l_ac].glaa001,l_glaa003,g_detail_d[l_ac].glaa024
      
      #依年度+期別取得會計週期起迄日
      CALL s_get_accdate(l_glaa003,'',g_master.fmna002,g_master.fmna003)
      RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
      #單據日期放該期最後一天
      LET g_detail_d[l_ac].fmnadocdt = l_pdate_e
      #end add-point
      
      CALL afmp510_detail_show()      
 
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
   FREE afmp510_sel
   
   LET l_ac = 1
   CALL afmp510_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   DISPLAY l_ac TO FORMONLY.h_index
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afmp510.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afmp510_fetch()
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
 
{<section id="afmp510.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION afmp510_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afmp510.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION afmp510_filter()
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
   
   CALL afmp510_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="afmp510.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION afmp510_filter_parser(ps_field)
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
 
{<section id="afmp510.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION afmp510_filter_show(ps_field,ps_object)
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
   LET ls_condition = afmp510_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="afmp510.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 清空&給預設
# Memo...........:
# Usage..........: CALL afmp510_qbe_clear()
# Date & Author..: 2015/05/13 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION afmp510_qbe_clear()
   
   CLEAR FORM
   INITIALIZE g_master.* TO NULL
   CALL g_detail_d.clear()
   
   LET g_master.fmnasite = g_site
   LET g_master.fmnasite_desc = s_desc_get_department_desc(g_master.fmnasite)
   DISPLAY BY NAME g_master.fmnasite_desc
   #預設年度/期別
   CALL cl_get_para(g_enterprise,g_master.fmnasite,'S-FIN-3007') RETURNING g_sfin3007
   LET g_master.fmna002 = YEAR(g_sfin3007)
   LET g_master.fmna003 = MONTH(g_sfin3007)
   
END FUNCTION

################################################################################
# Descriptions...: 產生資料
# Memo...........:
# Usage..........: CALL afmp510_process()
# Date & Author..: 2015/05/13 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION afmp510_process()
DEFINE l_i         LIKE type_t.num5
DEFINE l_wc        STRING
DEFINE l_sql       STRING
DEFINE l_cnt       LIKE type_t.num5
DEFINE l_flag      LIKE type_t.chr1
DEFINE l_fmna002   LIKE fmna_t.fmna002
DEFINE l_fmna003   LIKE fmna_t.fmna003
DEFINE l_fmnadocno LIKE fmna_t.fmnadocno
   
   LET g_success = 'Y'
   
   CALL cl_err_collect_init()
   #取得有勾選的帳套條件
   FOR l_i = 1 TO g_detail_cnt
      IF g_detail_d[l_i].sel = 'N' THEN
         CONTINUE FOR
      ELSE
         IF cl_null(g_detail_d[l_i].fmnadocno) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'afm-00106'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = g_detail_d[l_i].fmna001
            CALL cl_err()
            LET g_success = "N"
         END IF
         IF cl_null(l_wc) THEN
            LET l_wc = g_detail_d[l_i].fmna001
         ELSE
            LET l_wc = l_wc,"','",g_detail_d[l_i].fmna001
         END IF
      END IF
   END FOR
   CALL cl_err_collect_show()
   IF g_success = "N" THEN
      RETURN
   END IF
   
   #check有沒有勾選帳套
   IF cl_null(l_wc) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axr-00159'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = "N"
      RETURN
   ELSE
      LET l_wc = "('",l_wc,"')"
   END IF
   
   #前一期是否已有資料，若無則問是否繼續?
   IF l_fmna003 = 12 THEN
      LET l_fmna002 = g_master.fmna002 - 1
      LET l_fmna003 = 1
   END IF
   LET l_cnt = 0
   LET l_sql = " SELECT COUNT(*) FROM fmna_t ",
               "  WHERE fmnaent = ",g_enterprise,
               "    AND fmnasite= '",g_master.fmnasite,"' ",
               "    AND fmna002 = ",l_fmna002,
               "    AND fmna003 = ",l_fmna003,
               "    AND fmna001 IN ",l_wc,
               "    AND fmnastus <> 'X'"
   PREPARE afmp510_chk_p1 FROM l_sql
   EXECUTE afmp510_chk_p1 INTO l_cnt
   IF l_cnt = 0 THEN
      IF NOT cl_ask_confirm("afm-00122") THEN
         LET g_success = "N"
         RETURN
      END IF
   END IF

   
   CALL cl_err_collect_init()
   CALL s_azzi902_get_gzzd('aapp960',"lbl_xrebld")    RETURNING g_coll_title[1],g_coll_title[1]  #帳別
   CALL s_azzi902_get_gzzd('aapp960',"lbl_xreb005")   RETURNING g_coll_title[2],g_coll_title[2]  #單據號碼

   #先檢查是否已有月結資料
   LET l_cnt = 0
   LET l_sql = " SELECT COUNT(*) FROM fmna_t ",
               "  WHERE fmnaent = ",g_enterprise,
               "    AND fmnasite= '",g_master.fmnasite,"' ",
               "    AND fmna002 = '",g_master.fmna002,"' ",
               "    AND fmna003 = '",g_master.fmna003,"' ",
               "    AND fmna001 IN ",l_wc,
               "    AND fmnastus <> 'X'"
   PREPARE afmp510_chk_p2 FROM l_sql
   EXECUTE afmp510_chk_p2 INTO l_cnt
   IF l_cnt > 0 THEN
      #若有資料詢問是否刪除重生?
      IF NOT cl_ask_confirm("afm-00111") THEN
         LET g_success = "N"
      ELSE
         #取得有勾選的帳套
         FOR l_i = 1 TO g_detail_cnt
            IF g_detail_d[l_i].sel = 'Y' THEN
               #若月結已拋傳票則不能還原
               LET l_fmnadocno = ""
               LET l_sql = " SELECT fmnadocno FROM fmna_t ",
                           "  WHERE fmnaent = ",g_enterprise,
                           "    AND fmnasite= '",g_master.fmnasite,"' ",
                           "    AND fmna002 = '",g_master.fmna002,"' ",
                           "    AND fmna003 = '",g_master.fmna003,"' ",
                           "    AND fmna005 IS NOT NULL",
                           "    AND fmna001 = '",g_detail_d[l_i].fmna001,"'",
                           "    AND fmnastus <> 'X'"
               PREPARE afmp510_chk_p3 FROM l_sql
               DECLARE afmp510_chk_c3 CURSOR FOR afmp510_chk_p3
               FOREACH afmp510_chk_c3 INTO l_fmnadocno
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00129'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  LET g_errparam.coll_vals[1]  = g_detail_d[l_i].fmna001
                  LET g_errparam.coll_vals[2]  = l_fmnadocno #單據號碼
                  CALL cl_err()
                  LET g_success = "N"
               END FOREACH

               #已確認單據不可重產
               LET l_fmnadocno = ""
               LET l_sql = " SELECT fmnadocno FROM fmna_t ",
                           "  WHERE fmnaent = ",g_enterprise,
                           "    AND fmnasite= '",g_master.fmnasite,"' ",
                           "    AND fmna002 = '",g_master.fmna002,"' ",
                           "    AND fmna003 = '",g_master.fmna003,"' ",
                           "    AND fmna001 = '",g_detail_d[l_i].fmna001,"'",
                           "    AND fmnastus = 'Y'"
               PREPARE afmp510_chk_p4 FROM l_sql
               DECLARE afmp510_chk_c4 CURSOR FOR afmp510_chk_p4
               FOREACH afmp510_chk_c4 INTO l_fmnadocno
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afm-00131'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  LET g_errparam.coll_vals[1]  = g_detail_d[l_i].fmna001
                  LET g_errparam.coll_vals[2]  = l_fmnadocno #單據號碼
                  CALL cl_err()
                  LET g_success = "N"
               END FOREACH
               
               #刪除月結檔案
               IF g_success <> "N" THEN
                  #刪除月結檔案
                  CALL s_transaction_begin()
                  CALL s_afmp510_del(g_master.fmnasite,g_detail_d[l_i].fmna001,g_master.fmna002,g_master.fmna003)
                       RETURNING g_sub_success
                  IF g_sub_success THEN
                     CALL s_transaction_end('Y','0')
                  ELSE
                     CALL s_transaction_end('N','0')
                  END IF
               END IF
            
            END IF
         END FOR
      END IF
   END IF

   CALL cl_err_collect_show()
   IF g_success = "N" THEN
      RETURN
   END IF

   
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   
   #有勾選的帳套資料才寫入
   FOR l_i = 1 TO g_detail_cnt
      IF g_detail_d[l_i].sel = 'N' THEN
         CONTINUE FOR
      ELSE
         #p_fmnasite,p_fmna002,p_fmna003,p_fmna001,p_fmnadocno,p_fmnadocdt,p_glca003
         CALL s_afmp510_ins(g_master.fmnasite,g_master.fmna002,g_master.fmna003,
                            g_detail_d[l_i].fmna001,g_detail_d[l_i].fmnadocno,g_detail_d[l_i].fmnadocdt,
                            g_detail_d[l_i].glca003)
              RETURNING g_sub_success,l_flag
      END IF
   END FOR

   IF l_flag = 'N' THEN    #條件範圍沒有資料
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00491'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'
   END IF
   
   CALL cl_err_collect_show()
   
   IF g_success = 'Y' THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
   
END FUNCTION

#end add-point
 
{</section>}
 
