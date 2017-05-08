#該程式未解開Section, 採用最新樣板產出!
{<section id="aisp701.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2016-03-31 13:48:00), PR版次:0004(2016-10-26 11:11:15)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000031
#+ Filename...: aisp701
#+ Description: 防偽稅控開票作業
#+ Creator....: 01727(2016-03-31 13:48:00)
#+ Modifier...: 01727 -SD/PR- 08171
 
{</section>}
 
{<section id="aisp701.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160920-00019#6  2016/09/20 By 08732      交易對象開窗調整為q_pmaa001_13
#161006-00005#26 2016/10/21 By Reanna     1.帳務中心(isafsite)開窗改用q_ooef001_46()
#                                         2.法人(isafcomp)增加where條件 ooef003 = 'Y' 和azzi800控卡，開窗改用q_ooef001( )
#161017-00005#1  2016/10/26 By 08171      增加控制組
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"
IMPORT JAVA java.lang.String
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
        isatdocno       LIKE isat_t.isatdocno,
        isatseq         LIKE isat_t.isatseq,
        isat003         LIKE isat_t.isat003,
        isat004         LIKE isat_t.isat004,
        isaf002         LIKE isaf_t.isaf002,
        isaf002_desc    LIKE type_t.chr80,
        isaf021         LIKE isaf_t.isaf021,
        isat113         LIKE isat_t.isat113,
        isat114         LIKE isat_t.isat114,
        isat115         LIKE isat_t.isat115
                     END RECORD

DEFINE g_detail_idx     LIKE type_t.num5
DEFINE g_confirmer      LIKE type_t.chr20
DEFINE g_confirmer_desc LIKE type_t.chr20
DEFINE g_isafdocno      LIKE isaf_t.isafdocno
DEFINE g_master         RECORD
          isafdocno        LIKE isaf_t.isafdocno,
          isafsite         LIKE isaf_t.isafsite,
          isafcomp         LIKE isaf_t.isafcomp,
          isafdocdt        LIKE isaf_t.isafdocdt,
          isaf002          LIKE isaf_t.isaf002,
          isaf008          LIKE isaf_t.isaf008,
          isaf057          LIKE isaf_t.isaf057,
          isaf005          LIKE isaf_t.isaf005,
          confirmer        LIKE type_t.chr20,
          wc               STRING
                        END RECORD
DEFINE g_wc_isafcomp    STRING     #161006-00005#26
DEFINE g_sql_ctrl       STRING    #交易對象控制組 #161017-00005#1
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aisp701.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
   #add-point:main段define name="main.define"
   DEFINE lc_param type_parameter
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ais","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      LET ls_js = g_argv[01]
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aisp701 WITH FORM cl_ap_formpath("ais",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aisp701_init()   
 
      #進入選單 Menu (="N")
      CALL aisp701_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aisp701
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aisp701.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aisp701_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_fin_create_account_center_tmp()  #161006-00005#26
   #161017-00005#1 --s add
   #控制組
   LET g_sql_ctrl = NULL
   CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl
   #161017-00005#1 --e add
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aisp701.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aisp701_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_success LIKE type_t.num5
   DEFINE l_flag    LIKE type_t.num5
   DEFINE l_ooag011 LIKE ooag_t.ooag011
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
         CALL aisp701_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc ON isafsite,isafdocdt,isafcomp,isafdocno,isaf005,isaf008,isaf057,isaf002
         
            BEFORE CONSTRUCT
               CALL aisp701_def() RETURNING g_isafdocno#160105 add by zhangtn
               CALL aisp701_create_tmp() RETURNING l_success
             
            ON ACTION controlp INFIELD isafsite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #CALL q_ooef001()      #161006-00005#26 mark
               CALL q_ooef001_46()    #161006-00005#26
               DISPLAY g_qryparam.return1 TO isafsite
               NEXT FIELD isafsite
             
            ON ACTION controlp INFIELD isafcomp
               CALL s_fin_account_center_sons_query('3',g_site,g_today,'')
               CALL s_fin_account_center_comp_str() RETURNING g_wc_isafcomp
               CALL s_fin_get_wc_str(g_wc_isafcomp) RETURNING g_wc_isafcomp
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = "ooef001 IN ",g_wc_isafcomp CLIPPED," "  #161006-00005#26
               CALL q_ooef001_2()
               DISPLAY g_qryparam.return1 TO isafcomp
               NEXT FIELD isafcomp
            
            ON ACTION controlp INFIELD isafdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_isafdocno()
               DISPLAY g_qryparam.return1 TO isafdocno
               NEXT FIELD isafdocno
                
            ON ACTION controlp INFIELD isaf002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #161017-00005#1 --s add
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_sql_ctrl
               END IF
               #161017-00005#1 --e add
               #CALL q_pmaa001()  #呼叫開窗  #160920-00019#6--mark
               CALL q_pmaa001_13()           #160920-00019#6--add
               DISPLAY g_qryparam.return1 TO isaf002
               NEXT FIELD isaf002
            
            
            ON ACTION controlp INFIELD isaf008
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_isac002()
               DISPLAY g_qryparam.return1 TO isaf008
               NEXT FIELD isaf008

            ON ACTION controlp INFIELD isaf057
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO isaf057
               NEXT FIELD isaf057
            
            ON ACTION controlp INFIELD isaf005
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO isaf002
               NEXT FIELD isaf002

         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT g_confirmer FROM ooag001

           AFTER FIELD ooag001
              IF NOT cl_null(g_confirmer) THEN
                 INITIALIZE g_chkparam.* TO NULL
                 LET g_chkparam.arg1 = g_confirmer
                 IF NOT cl_chk_exist("v_ooag001") THEN
                    LET g_confirmer = ""
                    LET g_confirmer_desc = ""
                    NEXT FIELD CURRENT
                 ELSE
                    CALL s_axrt300_xrca_ref('xrca014',g_confirmer,'','')
                       RETURNING l_success,g_confirmer_desc
                 END IF
              END IF
              DISPLAY g_confirmer_desc TO ooag011

           ON ACTION controlp INFIELD ooag001
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'i'
              LET g_qryparam.reqry = FALSE

              LET g_qryparam.default1 = g_confirmer             #給予default值

              #給予arg
              LET g_qryparam.arg1 = "" 

            
              CALL q_ooag001()                                #呼叫開窗

              LET g_confirmer = g_qryparam.return1              

              DISPLAY g_confirmer TO ooag001
              #160309 add by zhangtn---str--
              SELECT ooag011 INTO g_confirmer_desc FROM ooag_t WHERE ooagent = g_enterprise AND ooag001 = g_confirmer
              DISPLAY g_confirmer_desc TO ooag011
              #160309 add by zhangtn---end--              

              NEXT FIELD ooag001                    #返回原欄位
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         INPUT ARRAY g_detail_d FROM s_detail1.*
            ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         
            BEFORE INPUT
               IF g_detail_d.getLength() > 0 THEN
                  CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
                  CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
               ELSE
                  CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
                  CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
               END IF
               DISPLAY g_detail_d.getLength() TO FORMONLY.h_count           

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
         
            AFTER FIELD b_sel
               IF l_ac <> 0 THEN
                  IF NOT cl_null(g_detail_d[l_ac].sel) THEN
                     IF g_detail_d[l_ac].sel NOT MATCHES '[YN]' THEN
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF 

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
            CALL aisp701_filter()
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
            CALL aisp701_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL aisp701_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            LET l_flag = FALSE
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  IF g_detail_d[li_idx].sel = "Y" THEN
                     LET l_flag = TRUE
                     EXIT FOR
                  END IF
               END IF
            END FOR
            IF l_flag THEN
               CALL aisp701_exporttotxt()
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00159'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
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
 
{<section id="aisp701.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aisp701_query()
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
   CALL aisp701_b_fill()
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
 
{<section id="aisp701.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aisp701_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_isao006       LIKE isao_t.isao006
   DEFINE l_isafcomp      LIKE isaf_t.isafcomp
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(g_wc) THEN  #p_wc 查詢條件
      LET g_wc = " 1=1 "
   END IF

   LET g_sql = " SELECT 'N',isatdocno,isatseq,isat003,isat004,isaf002,'',isaf021,isat113,isat114,isat115 ",
               " FROM isaf_t,isat_t ",
               "  WHERE isafent = isatent AND isafcomp = isatcomp AND isafdocno = isatdocno ",
               "       AND isafstus = 'Y' AND isat014 in ('11','21','14','24') ",
               "    AND isafent = '",g_enterprise,"' ",
               "    AND isatent = ?",
               "    AND ",g_wc CLIPPED,
               "   ORDER BY isat003,isat004"
   #end add-point
 
   PREPARE aisp701_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aisp701_sel
   
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
      SELECT isafcomp INTO l_isafcomp FROM isaf_t WHERE isafent = g_enterprise
         AND isafdocno = g_detail_d[l_ac].isatdocno

      SELECT count(*) INTO l_n FROM xrca_t WHERE xrcaent = g_enterprise
         AND xrcacomp = l_isafcomp
         AND xrca018 = g_detail_d[l_ac].isatdocno

      IF l_n > 0 THEN CONTINUE FOREACH END IF

      SELECT isao006 INTO l_isao006 FROM isao_t WHERE isaoent = g_enterprise
      AND isaosite = l_isafcomp
      AND isaostus = 'Y'

      IF l_isao006 NOT MATCHES "[Yy]" OR cl_null(l_isao006) THEN CONTINUE FOREACH END IF

      IF NOT cl_null(g_argv[1]) THEN LET g_detail_d[l_ac].sel = 'Y' END IF

      SELECT pmaal004 INTO g_detail_d[l_ac].isaf002_desc FROM pmaal_t
       WHERE pmaalent = g_enterprise AND pmaal001 =g_detail_d[l_ac].isaf002 AND pmaal002 = 'zh_CN'
      #end add-point
      
      CALL aisp701_detail_show()      
 
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
   FREE aisp701_sel
   
   LET l_ac = 1
   CALL aisp701_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aisp701.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aisp701_fetch()
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
 
{<section id="aisp701.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aisp701_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aisp701.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aisp701_filter()
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
   
   CALL aisp701_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="aisp701.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aisp701_filter_parser(ps_field)
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
 
{<section id="aisp701.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aisp701_filter_show(ps_field,ps_object)
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
   LET ls_condition = aisp701_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aisp701.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

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
PRIVATE FUNCTION aisp701_create_tmp()
 DEFINE r_success       LIKE type_t.num5
    
    WHENEVER ERROR CONTINUE
    LET r_success = FALSE
 
    DROP TABLE aisp701_tmp;
    CREATE TEMP TABLE aisp701_tmp(    
      isatent        SMALLINT,
      isatcomp       VARCHAR(10),
      isatsite       VARCHAR(10),
      isatdocno      VARCHAR(20),
      isatseq        INTEGER,
      isat003        VARCHAR(20),
      isat004        VARCHAR(20))

      
    IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "create" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      
      RETURN r_success
   END IF
   

    DROP TABLE aisp701_isat_tmp;
    SELECT * FROM isat_t WHERE 1=2 INTO TEMP aisp701_isat_tmp

    IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "create" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      
      RETURN r_success
    END IF
    
    DROP TABLE aisp701_isat_tmp2;
    SELECT * FROM isat_t WHERE 1=2 INTO TEMP aisp701_isat_tmp2

    IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "create" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      
      RETURN r_success
    END IF
   
   
   
   LET r_success = TRUE
   RETURN r_success     

END FUNCTION

################################################################################
# Descriptions...: 接收aist310所传参数
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                 
# Input parameter: 
#                : 
# Return code....: l_isafdocno
# Date & Author..: 160105 By zhangtn
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp701_def()
   DEFINE l_isafdocno   LIKE isaf_t.isafdocno
   DEFINE l_success     LIKE type_t.chr1
   DEFINE l_ld          LIKE type_t.chr10 

   IF NOT cl_null(g_argv[1]) AND NOT cl_null(g_argv[2]) AND NOT cl_null(g_argv[3]) AND NOT cl_null(g_argv[4]) 
     AND NOT cl_null(g_argv[5]) AND NOT cl_null(g_argv[6]) AND NOT cl_null(g_argv[7]) AND NOT cl_null(g_argv[8]) THEN
      LET g_master.isafdocno  = g_argv[1] #对账单号
      LET g_master.isafsite = g_argv[2]   #营运据点
      LET g_master.isafcomp  = g_argv[3]  #法人
      LET g_master.isafdocdt = g_argv[4]  #单据日期
      LET g_master.isaf002  = g_argv[5]   #发票客户
      LET g_master.isaf008 = g_argv[6]    #发票类型
      LET g_master.isaf057  = g_argv[7]   #业务人员
      LET g_master.isaf005 = g_argv[8]    #开票人员

      LET g_wc = "isafdocno='",g_master.isafdocno,"' AND isafsite ='",g_master.isafsite,"' AND isafcomp ='",g_master.isafcomp,"' "
      DISPLAY g_master.isafdocno TO isafdocno
      DISPLAY g_master.isafsite TO isafsite
      DISPLAY g_master.isafcomp TO isafcomp
      DISPLAY g_master.isafdocdt TO isafdocdt
      DISPLAY g_master.isaf002 TO isaf002
      DISPLAY g_master.isaf008 TO isaf008
      DISPLAY g_master.isaf057 TO isaf057
      DISPLAY g_master.isaf005 TO isaf005

      CALL aisp701_b_fill()

   ELSE
      #帳務中心
      #取得預設的帳務中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
      CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING l_success,g_master.isafsite,g_errno
      #該帳務中心與帳別無法勾稽到,以登入人員g_user取得預設帳別/法人
      CALL s_fin_orga_get_comp_ld(g_master.isafsite) RETURNING l_success,g_errno,g_master.isafcomp,l_ld
      DISPLAY g_master.isafsite TO isafsite
      DISPLAY g_master.isafcomp TO isafcomp      
   END IF

   RETURN l_isafdocno

END FUNCTION

################################################################################
# Descriptions...: 导出文本
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
PRIVATE FUNCTION aisp701_exporttotxt()
   DEFINE r_success   LIKE type_t.num5
   DEFINE lc_channel  base.channel
   DEFINE buf         base.StringBuffer
   DEFINE java_str    java.lang.String
   DEFINE txt_name    STRING
   DEFINE l_path      STRING
   DEFINE l_str       STRING
   DEFINE l_excel     STRING
   DEFINE ls_str      STRING
   DEFINE l_sql       STRING
   DEFINE lc_time     LIKE type_t.chr20
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5      
   DEFINE l_status    LIKE type_t.num5
   DEFINE l_chr       LIKE type_t.chr1   
   DEFINE l_chr1      LIKE type_t.chr1 
   DEFINE l_chr2      LIKE type_t.chr5   
   DEFINE l_num       LIKE type_t.num5
   DEFINE l_isaf017   LIKE isaf_t.isaf017
   DEFINE l_isaf021   LIKE isaf_t.isaf021
   DEFINE l_isaf022   LIKE isaf_t.isaf022
   DEFINE l_isaf023   LIKE isaf_t.isaf023
   DEFINE l_isaf024   LIKE isaf_t.isaf024
   DEFINE l_isaf025   LIKE isaf_t.isaf025
   DEFINE l_isaf026   LIKE isaf_t.isaf026
   DEFINE l_isaf038   LIKE isaf_t.isaf038
   DEFINE l_isaf031   LIKE isaf_t.isaf031
   DEFINE l_isaf032   LIKE isaf_t.isaf032
   DEFINE l_isaf029   LIKE isaf_t.isaf029
   DEFINE l_isaf030   LIKE isaf_t.isaf030
   DEFINE l_isaf056   LIKE isaf_t.isaf056
   DEFINE l_isafcomp  LIKE isaf_t.isafcomp
   DEFINE l_isah004   LIKE isah_t.isah004
   DEFINE l_isah013   LIKE isah_t.isah013
   DEFINE l_isah006   LIKE isah_t.isah006
   DEFINE l_isah007   LIKE isah_t.isah007
   DEFINE l_isah106   LIKE isah_t.isah106
   DEFINE l_isah114   LIKE isah_t.isah114
   DEFINE l_isah101   LIKE isah_t.isah101
   DEFINE l_isah113   LIKE isah_t.isah113
   DEFINE l_isah115   LIKE isah_t.isah115
   DEFINE l_isai002   LIKE isai_t.isai002
   DEFINE l_oocal003  LIKE oocal_t.oocal003
   DEFINE l_flag      LIKE type_t.num5
   DEFINE l_count     LIKE type_t.num5
   DEFINE l_amt1      LIKE isah_t.isah103   #折扣稅額
   DEFINE l_amt2      LIKE isah_t.isah103   #折扣率

   LET l_sql = "SELECT isah004,isah013,isah006,isah007,isah106,isah114,isah101,isah113,isah115 FROM isah_t ",
               " WHERE isahent = '",g_enterprise,"'",
               "   AND isahdocno = ? ",
               "   AND (( 1 = ? AND isah001 = ? AND isah002 = ?) OR ( 1 = ? AND isah009 = ?))"
   PREPARE aisp701_isah_prep FROM l_sql
   DECLARE aisp701_isah_curs CURSOR FOR aisp701_isah_prep

   LET l_sql = "SELECT COUNT(*) FROM (",l_sql,")"
   PREPARE aisp701_isah_count FROM l_sql

   LET lc_time = time(current)
   LET txt_name = "SKXXFP.txt"
   LET buf = base.StringBuffer.create()
   CALL buf.append(txt_name)
   LET txt_name = buf.toString()
   LET txt_name =cl_replace_str(txt_name,':','-') #特殊符号不可出现在文件名中
   
   LET l_path = FGL_GETENV("TEMPDIR")||"/"||txt_name CLIPPED #包含文件名
   
   LET lc_channel = base.Channel.create()
   IF os.Path.delete(l_path CLIPPED) THEN END IF 
   CALL lc_channel.openFile(l_path CLIPPED,"a")
   CALL lc_channel.setDelimiter("")  #设置分隔符

   #寫入固定開頭
   LET l_str = "SJJK0101~~销售单据传入~~",ASCII 13
   CALL lc_channel.write(l_str)

   FOR l_cnt = 1 TO g_detail_d.getLength()
      IF g_detail_d[l_cnt].sel = "N" THEN CONTINUE FOR END IF
      SELECT isaf021,isaf022,isaf023,isaf024,isaf025,isaf026,isaf038,isaf031,isaf032,isaf029,isaf030,isaf056,isafcomp,isaf017
        INTO l_isaf021,l_isaf022,l_isaf023,l_isaf024,l_isaf025,l_isaf026,l_isaf038,l_isaf031,l_isaf032,l_isaf029,l_isaf030,l_isaf056,l_isafcomp,l_isaf017
        FROM isaf_t
       WHERE isafent   = g_enterprise
         AND isafdocno = g_detail_d[l_cnt].isatdocno

      SELECT isai002 INTO l_isai002 FROM isai_t,ooef_t WHERE ooefent = isaient AND isaient = g_enterprise
         AND ooef019 = isai001
         AND ooef001 = l_isafcomp
         AND ooefstus = 'Y'

      IF l_isaf056 = '2' AND l_isai002 = '1' THEN
         LET l_flag = 2
      ELSE
         LET l_flag = 1
      END IF

      LET l_count = 0
      EXECUTE aisp701_isah_count USING g_detail_d[l_cnt].isatdocno,l_flag,g_detail_d[l_cnt].isat003,g_detail_d[l_cnt].isat004,l_flag,g_detail_d[l_cnt].isat004
                                  INTO l_count

      #寫入單頭資料
      LET l_str = "//单据" CLIPPED||l_cnt||":",ASCII 13
      CALL lc_channel.write(l_str)
      LET l_str = g_detail_d[l_cnt].isat004 CLIPPED,"~~",
                  l_count CLIPPED,"~~",
                  l_isaf021 CLIPPED,"~~",
                  l_isaf022 CLIPPED,"~~",
                  l_isaf023 CLIPPED,l_isaf024 CLIPPED,"~~",
                  l_isaf025 CLIPPED,l_isaf026 CLIPPED,"~~",
                  l_isaf038 CLIPPED,"~~",
                  g_confirmer_desc CLIPPED,"~~",
                  "~~","~~","~~",
                  l_isaf031 CLIPPED,l_isaf032 CLIPPED,"~~",
                  l_isaf029 CLIPPED,l_isaf030 CLIPPED,"~~",ASCII 13                   
      LET l_str = cl_replace_str(l_str,' ','')                  
      CALL lc_channel.write(l_str)

      #寫入單身資料
      FOREACH aisp701_isah_curs USING g_detail_d[l_cnt].isatdocno,l_flag,g_detail_d[l_cnt].isat003,g_detail_d[l_cnt].isat004,l_flag,g_detail_d[l_cnt].isat004
                                 INTO l_isah004,l_isah013,l_isah006,l_isah007,l_isah106,l_isah114,l_isah101,l_isah113,l_isah115

         SELECT oocal003 INTO l_oocal003 FROM oocal_t WHERE oocalent = g_enterprise
            AND oocal001 = l_isah005 AND oocal002 = g_dlang

         IF l_isaf017 = 'Y' THEN
            LET l_isah113 = l_isah115
            LET l_num = 1
         ELSE
            LET l_num = 0
         END IF

         LET l_amt1 =l_isah106 / (1 + l_isah007)* l_isah007
         LET l_amt2 = l_isah106 / l_isah113

         LET l_str = l_isah004 CLIPPED,"~~",
                     l_oocal003 CLIPPED,"~~",
                     l_isah013 CLIPPED,"~~",
                     l_isah006/1.0000 CLIPPED,"~~",
                     l_isah113/1.0000 CLIPPED,"~~",
                     l_isah007/100 CLIPPED,"~~", #要小数格式
                     "9002~~",
                     l_isah106/1.0000 CLIPPED,"~~",
                     l_isah114/1.0000 CLIPPED,"~~",
                     l_amt1/1.0000 CLIPPED,"~~",
                     l_amt2/1.0000 CLIPPED,"%~~",
                     l_isah101 CLIPPED,"~~",
                     l_num CLIPPED,ASCII 13
         LET l_str = cl_replace_str(l_str,' ','')                  
         CALL lc_channel.write(l_str)

      END FOREACH

   END FOR
   CALL lc_channel.close()     

   CALL cl_client_browse_dir() RETURNING l_excel
   LET ls_str= ''
   LET l_chr = ''
   LET l_chr1 = ''
   LET ls_str = l_excel
   #抓取目录斜杆
   LET l_num =ls_str.getIndexOf(':',1)                                  #抓取：后的字符位置
   LET l_chr = ls_str.substring(l_num+1,l_num+1)                        #截取冒号后的字符 
   LET l_chr1 = ls_str.substring(ls_str.getLength(),ls_str.getLength()) #判断是否为根目录
   IF l_chr <> l_chr1  THEN         
       LET l_excel = l_excel||l_chr||txt_name
   ELSE
       LET l_excel = l_excel||txt_name
   END IF
   LET l_path = "$TEMPDIR"||"/"||txt_name   

   IF NOT cl_null(l_excel) THEN         
      LET g_bgjob = 'Y' 
      LET l_excel =cl_replace_str(l_excel,'/','\\')  #目标路径要用反斜杠
      LET status =  cl_client_download_file(l_path,l_excel) 
      IF status THEN
         ERROR "Download OK!!"
         LET r_success = TRUE
      ELSE
         ERROR "Download fail!!"
         LET r_success = FALSE
      END IF         
   END IF

END FUNCTION

#end add-point
 
{</section>}
 
