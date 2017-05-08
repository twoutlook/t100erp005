#該程式已解開Section, 不再透過樣板產出!
{<section id="aglq714.description" >}
#+ Version..: T100-ERP-1.00.00(版次:1) Build-000173
#+ 
#+ Filename...: aglq714
#+ Description: 科目各期餘額查詢作業
#+ Creator....: 02599(2014/03/12)
#+ Modifier...: 02599(2014/03/13)
#+ Buildtype..: 應用 q02 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="aglq714.global" >}
 
 
IMPORT os
IMPORT util
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_glar_d RECORD
       #statepic       LIKE type_t.chr1,
       sel            LIKE type_t.chr1,
       glar001 LIKE glar_t.glar001, 
   glar001_desc LIKE type_t.chr500, 
   glar009 LIKE glar_t.glar009, 
   oyeard LIKE glaq_t.glaq003, 
   oyearc LIKE glaq_t.glaq003, 
   yeard LIKE glaq_t.glaq003, 
   yearc LIKE glaq_t.glaq003, 
   yeard2 LIKE glaq_t.glaq003, 
   yearc2 LIKE glaq_t.glaq003, 
   yeard3 LIKE glaq_t.glaq003, 
   yearc3 LIKE glaq_t.glaq003, 
   oqcd LIKE glaq_t.glaq003, 
   oqcc LIKE glaq_t.glaq003, 
   qcd LIKE glaq_t.glaq003, 
   qcc LIKE glaq_t.glaq003, 
   qcd2 LIKE glaq_t.glaq003, 
   qcc2 LIKE glaq_t.glaq003, 
   qcd3 LIKE glaq_t.glaq003, 
   qcc3 LIKE glaq_t.glaq003, 
   oqj LIKE glaq_t.glaq003, 
   qj LIKE glaq_t.glaq003, 
   qj2 LIKE glaq_t.glaq003, 
   qj3 LIKE glaq_t.glaq003, 
   oqmd LIKE glaq_t.glaq003, 
   oqmc LIKE glaq_t.glaq003, 
   qmd LIKE glaq_t.glaq003, 
   qmc LIKE glaq_t.glaq003, 
   qmd2 LIKE glaq_t.glaq003, 
   qmc2 LIKE glaq_t.glaq003, 
   qmd3 LIKE glaq_t.glaq003, 
   qmc3 LIKE glaq_t.glaq003, 
   obsum LIKE glaq_t.glaq003, 
   bsum LIKE glaq_t.glaq003, 
   bsum2 LIKE glaq_t.glaq003, 
   bsum3 LIKE glaq_t.glaq003
       END RECORD
 
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_glar_d
DEFINE g_master_t                   type_g_glar_d
DEFINE g_glar_d          DYNAMIC ARRAY OF type_g_glar_d
DEFINE g_glar_d_t        type_g_glar_d
 
      
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num5              
DEFINE l_ac_d               LIKE type_t.num5              #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num5              #目前所在頁數
DEFINE g_detail_cnt         LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num5
DEFINE g_detail_idx         LIKE type_t.num5
DEFINE g_detail_idx2        LIKE type_t.num5
DEFINE g_hyper_url          STRING                        #hyperlink的主要網址
 
 
#多table用wc
DEFINE g_wc_table           STRING
 
 
 
DEFINE g_wc_filter_table           STRING
 
 
 
 
#add-point:自定義模組變數(Module Variable)
#依据当前账别，抓取账别所归属的法人，使用币别，汇率参照表号，会计科目参照表号
DEFINE g_bookno        LIKE glap_t.glapld
DEFINE g_glaald        LIKE glaa_t.glaald
DEFINE g_glaald_desc   LIKE glaal_t.glaal002
DEFINE g_glaacomp      LIKE glaa_t.glaacomp
DEFINE g_glaacomp_desc LIKE ooefl_t.ooefl003
DEFINE g_glaa001       LIKE glaa_t.glaa001
DEFINE g_glaa002       LIKE glaa_t.glaa002
DEFINE g_glaa003       LIKE glaa_t.glaa003
DEFINE g_glaa004       LIKE glaa_t.glaa004
DEFINE g_glaa013       LIKE glaa_t.glaa013
DEFINE g_glaa015       LIKE glaa_t.glaa015
DEFINE g_glaa016       LIKE glaa_t.glaa016
DEFINE g_glaa017       LIKE glaa_t.glaa017
DEFINE g_glaa018       LIKE glaa_t.glaa018
DEFINE g_glaa019       LIKE glaa_t.glaa019
DEFINE g_glaa020       LIKE glaa_t.glaa020
DEFINE g_glaa021       LIKE glaa_t.glaa021
DEFINE g_glaa022       LIKE glaa_t.glaa022
#查询条件定义
DEFINE tm              RECORD
       year            LIKE glap_t.glap002,    #會計年度
       smm             LIKE glap_t.glap004,    #起始期別
       emm             LIKE glap_t.glap004,    #截止期別
       ctype           LIKE type_t.chr1,       #多本位幣
       curr_o          LIKE type_t.chr1, 
       curr_p          LIKE type_t.chr1, 
       show_y          LIKE type_t.chr1, 
       show_acc        LIKE type_t.chr1, 
       glac005	       LIKE glac_t.glac005,
       stus            LIKE type_t.chr1,
       glac009	       LIKE glac_t.glac009,
       show_ad         LIKE type_t.chr1,
       show_ce         LIKE type_t.chr1,
       show_ye         LIKE type_t.chr1
       END RECORD
DEFINE g_wc1           STRING
DEFINE g_glar009       LIKE glar_t.glar009
DEFINE g_glar_s        DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位 
       glar009         LIKE glar_t.glar009
      END RECORD 
DEFINE g_current_row   LIKE type_t.num5 
DEFINE g_current_idx   LIKE type_t.num10     
DEFINE g_jump          LIKE type_t.num10        
DEFINE g_no_ask        LIKE type_t.num5  
DEFINE g_rec_b         LIKE type_t.num5
DEFINE g_xg_visible    STRING
#end add-point
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="aglq714.main" >}
#+ 此段落由子樣板a26產生
#OPTIONS SHORT CIRCUIT
#+ 作業開始 
MAIN
   #add-point:main段define
   
   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("agl","")
 
   #add-point:作業初始化
   
   #end add-point
   
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = ""
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   DECLARE aglq714_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE ",
               " FROM ",
               " WHERE  "
   #add-point:SQL_define
   
   #end add-point
   PREPARE aglq714_master_referesh FROM g_sql
 
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call
      
      #end add-point
 
   ELSE
      
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq714 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq714_init()   
 
      #進入選單 Menu (="N")
      CALL aglq714_ui_dialog() 
      
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq714
      
   END IF 
   
   CLOSE aglq714_cl
   
   
 
   #add-point:作業離開前
   DROP TABLE aglq714_tmp
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="aglq714.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aglq714_init()
   #add-point:init段define
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_pass      LIKE type_t.num5
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   
   
   
   #add-point:畫面資料初始化
   LET g_detail_idx  = 1
   CALL cl_set_combo_scc('stus','9922')
   #获取账别
   IF cl_null(g_glaald) THEN
      CALL s_ld_bookno()  RETURNING l_success,g_glaald
      IF l_success = FALSE THEN
         RETURN 
      END IF 
      CALL s_ld_chk_authorization(g_user,g_glaald) RETURNING l_pass
      IF l_pass = FALSE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00164'
         LET g_errparam.extend = g_glaald
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN
      END IF
   END IF      
   CALL aglq714_glaald_desc(g_glaald)
   CALL aglq714_set_default_value()
   #建立临时表
   CALL aglq714_create_temp_table()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aglq714.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aglq714_ui_dialog()
   {<Local define>}
   DEFINE li_idx   LIKE type_t.num5
   {</Local define>}
   #add-point:ui_dialog段define

   #end add-point 
 
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   #add-point:ui_dialog段before dialog 

   #end add-point
   
   CALL aglq714_query()
   
   WHILE TRUE
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_glar_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_glar_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
               CALL aglq714_fetch()
               #add-point:input段before row
               DISPLAY g_current_idx TO FORMONLY.h_index
               DISPLAY g_glar_s.getLength() TO FORMONLY.h_count
               DISPLAY g_detail_idx TO FORMONLY.idx
               DISPLAY g_glar_d.getLength() TO FORMONLY.cnt
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array

         #end add-point
         
         BEFORE DIALOG      
            CALL DIALOG.setSelectionMode("s_detail1", 1)
 
            #add-point:ui_dialog段before dialog
            #上下筆按鈕顯示否設置
            IF g_header_cnt=1 THEN
               CALL cl_set_act_visible("first,previous,jump,next,last",FALSE) 
            ELSE
               IF g_current_idx=1 THEN
                  CALL cl_set_act_visible("first,previous", FALSE) 
                  CALL cl_set_act_visible("jump,next,last", TRUE) 
               ELSE
                  IF g_current_idx<>g_header_cnt THEN
                     CALL cl_set_act_visible("first,previous,jump,next,last",TRUE) 
                  ELSE
                     CALL cl_set_act_visible("first,previous,jump",TRUE) 
                     CALL cl_set_act_visible("next,last", FALSE) 
                  END IF
               END IF
            END IF
            CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
            #end add-point
 
            NEXT FIELD sel
      
         
 
         ON ACTION datainfo
 
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN 
               #add-point:ON ACTION datainfo

               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION exchange_ld
 
            LET g_action_choice="exchange_ld"
            IF cl_auth_chk_act("exchange_ld") THEN 
               #add-point:ON ACTION exchange_ld
               CALL aglt310_01(g_glaald) RETURNING g_bookno
               IF g_glaald <> g_bookno THEN
                  CLEAR FORM
                  CALL g_glar_s.clear()
                  CALL g_glar_d.clear()
               END IF
               LET g_glaald = g_bookno
               #依据对应的主账套编码，抓取对应法人，币别，汇率参照编号，会计科目参照编号,关账日期
               CALL aglq714_glaald_desc(g_glaald)
               CALL aglq714_show()
                IF cl_null(g_wc) THEN
                   LET g_wc = '1=1'
                END IF 
                LET g_wc1 = ' 1=1'
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION first
 
            LET g_action_choice="fetch" #161011-00018#1 mod first-->fetch
#            IF cl_auth_chk_act("first") THEN  #161011-00018#1 mark
               #add-point:ON ACTION first
               CALL aglq714_fetch1('F')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #END add-point
               EXIT DIALOG
#            END IF #161011-00018#1 mark
 
 
         ON ACTION jump
 
            LET g_action_choice="fetch" #161011-00018#1 mod jump-->fetch
#            IF cl_auth_chk_act("jump") THEN #161011-00018#1 mark
               #add-point:ON ACTION jump
               CALL aglq714_fetch1('/')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #END add-point
               EXIT DIALOG
#            END IF #161011-00018#1 mark
 
 
         ON ACTION last
 
            LET g_action_choice="fetch" #161011-00018#1 mod last-->fetch
#            IF cl_auth_chk_act("last") THEN  #161011-00018#1 mark
               #add-point:ON ACTION last
               CALL aglq714_fetch1('L')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #END add-point
               EXIT DIALOG
#            END IF #161011-00018#1 mark
 
 
         ON ACTION next
 
            LET g_action_choice="fetch" #161011-00018#1 mod next-->fetch
#            IF cl_auth_chk_act("next") THEN  #161011-00018#1 mark
               #add-point:ON ACTION next
               CALL aglq714_fetch1('N')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #END add-point
               EXIT DIALOG
#            END IF #161011-00018#1 mark
 
 
         ON ACTION output
 
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN 
               #add-point:ON ACTION output
               CALL aglq714_output()
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION previous
 
            LET g_action_choice="fetch" #161011-00018#1 mod previous-->fetch
#            IF cl_auth_chk_act("previous") THEN  #161011-00018#1 mark
               #add-point:ON ACTION previous
               CALL aglq714_fetch1('P')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #END add-point
               EXIT DIALOG
#            END IF #161011-00018#1 mark
 
 
         ON ACTION query
 
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN 
               CALL aglq714_query()
               #add-point:ON ACTION query
               EXIT DIALOG
               #END add-point
            END IF
 
      
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_glar_d.getLength()
               LET g_glar_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall

            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_glar_d.getLength()
               LET g_glar_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone

            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_glar_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glar_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel

            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_glar_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glar_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify_detail") THEN
               IF g_detail_idx>=1 THEN
                  CALL aglq714_cmdrun() #串查aglq740總分類帳資料                    
               END IF
               EXIT DIALOG
            END IF
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aglq714_filter()
            #add-point:ON ACTION filter

            #END add-point
            EXIT DIALOG
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            CALL aglq714_glaald_desc(g_glaald)
            CALL aglq714_set_default_value()
            CALL aglq714_query()
            EXIT DIALOG
            
         ON ACTION datarefresh   # 重新整理
            LET g_error_show = 1
            #CALL aglq714_b_fill()
            CALL aglq714_fetch()
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_glar_d)
 
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
            
      
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq714.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglq714_query()
   {<Local define>}
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   {</Local define>}
   #add-point:query段define
   DEFINE l_flag           LIKE type_t.num5
   DEFINE l_flag1          LIKE type_t.chr1
   DEFINE l_errno          LIKE type_t.chr100
   DEFINE l_glav002        LIKE glav_t.glav002
   DEFINE l_glav005        LIKE glav_t.glav005
   DEFINE l_sdate_s        LIKE glav_t.glav004
   DEFINE l_sdate_e        LIKE glav_t.glav004
   DEFINE l_glav006        LIKE glav_t.glav006
   DEFINE l_pdate_s        LIKE glav_t.glav004
   DEFINE l_pdate_e        LIKE glav_t.glav004
   DEFINE l_glav007        LIKE glav_t.glav007
   DEFINE l_wdate_s        LIKE glav_t.glav004
   DEFINE l_wdate_e        LIKE glav_t.glav004
   DEFINE l_cnt            LIKE type_t.num5
   DEFINE l_glav006_max    LIKE glav_t.glav006
   
   #建立临时表
   CALL aglq714_create_temp_table()
   LET l_flag=TRUE
   #end add-point 
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_glar_d.clear()
   LET g_wc_filter = " 1=1"
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET g_master_idx = l_ac
 
   
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON glar001
           FROM s_detail1[1].b_glar001
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
       #---------------------<  Detail: page1  >---------------------
         #----<<b_glar001>>----
         #Ctrlp:construct.c.page1.b_glar001
         ON ACTION controlp INFIELD b_glar001
            #add-point:ON ACTION controlp INFIELD b_glar001
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND glac006 = '1'"
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar001  #顯示到畫面上

            NEXT FIELD b_glar001                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_glar001
            #add-point:BEFORE FIELD b_glar001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glar001
            
            #add-point:AFTER FIELD b_glar001

            #END add-point
            
 
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct
      CONSTRUCT g_wc1 ON glar009
           FROM s_detail1[1].b_glar009
                      
         BEFORE CONSTRUCT
         
         ON ACTION controlp INFIELD b_glar009
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar009  #顯示到畫面上
            NEXT FIELD b_glar009                     #返回原欄位            
      END CONSTRUCT
      
      INPUT BY NAME tm.year,tm.smm,tm.emm,tm.ctype,tm.curr_o,tm.curr_p,tm.show_y,
                    tm.show_acc,tm.glac005,tm.stus,tm.glac009,tm.show_ad,tm.show_ce,tm.show_ye
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
         
         AFTER FIELD smm
            IF NOT cl_null(tm.smm) THEN 
               LET l_glav006_max = ''
               SELECT MAX(glav006) INTO l_glav006_max
                 FROM glav_t
                WHERE glavent = g_enterprise 
                  AND glav001 = g_glaa003 
                  AND glav002 = tm.year     
            
               IF tm.smm < 1 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abg-00266'
                  LET g_errparam.extend = tm.smm
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET tm.smm = ''
                  NEXT FIELD smm
               END IF
               
               IF tm.smm > l_glav006_max THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abg-00267'
                  LET g_errparam.extend = tm.smm
                  LET g_errparam.replace[1] = l_glav006_max
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET tm.smm = ''
                  NEXT FIELD smm
               END IF
               
               IF tm.smm > tm.emm THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00227'
                  LET g_errparam.extend = tm.smm
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET tm.smm = ''
                  NEXT FIELD smm
               END IF
            END IF
               
         AFTER FIELD emm
            IF NOT cl_null(tm.emm) THEN 
               LET l_glav006_max = ''
               SELECT MAX(glav006) INTO l_glav006_max
                 FROM glav_t
                WHERE glavent = g_enterprise 
                  AND glav001 = g_glaa003 
                  AND glav002 = tm.year      
               
               IF tm.emm < 1 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abg-00266'
                  LET g_errparam.extend = tm.emm
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET tm.emm = ''
                  NEXT FIELD emm
               END IF
               
               IF tm.emm > l_glav006_max THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abg-00267'
                  LET g_errparam.extend = tm.emm
                  LET g_errparam.replace[1] = l_glav006_max
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET tm.emm = ''
                  NEXT FIELD emm
               END IF
               
               IF tm.emm < tm.smm THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00228'
                  LET g_errparam.extend = tm.emm
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET tm.emm = ''
                  NEXT FIELD emm
               END IF
            END IF
         
         ON CHANGE ctype
            IF tm.ctype MATCHES '[0123]' THEN
               CALL aglq714_set_curr_show()
            ELSE
               NEXT FIELD ctype
            END IF
            
         ON CHANGE curr_o 
            IF tm.curr_o MATCHES '[yYnN]' THEN
               IF tm.curr_o='Y' THEN
                  CALL cl_set_comp_visible('b_glar009,oqcd,oqcc,oqj,oqmd,oqmc,obsum',TRUE)
                  CALL cl_set_comp_entry('curr_p',TRUE)      
                  IF tm.show_y='Y' THEN
                     CALL cl_set_comp_visible('oyeard,oyearc',TRUE)
                  END IF
               ELSE
                  CALL cl_set_comp_visible('b_glar009,oyeard,oyearc,oqcd,oqcc,oqj,oqmd,oqmc,obsum',FALSE)
                  CALL cl_set_comp_entry('curr_p',FALSE)      
                  LET tm.curr_p='N'
                  DISPLAY tm.curr_p TO curr_p
               END IF                  
            ELSE
               NEXT FIELD curr_o
            END IF
            
         ON CHANGE curr_p
            IF tm.curr_p NOT MATCHES '[yYnN]' THEN
                NEXT FIELD curr_p
            END IF
            
         ON CHANGE show_y
            IF tm.show_y NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_y
            END IF
            IF tm.show_y='Y' THEN
               CALL cl_set_comp_visible('yeard,yearc',TRUE)
               IF tm.curr_o='Y' THEN
                  CALL cl_set_comp_visible('oyeard,oyearc',TRUE)
               END IF
               IF tm.ctype='1' OR tm.ctype='3' THEN
                  CALL cl_set_comp_visible('yeard2,yearc2',TRUE)
               END IF
               IF tm.ctype='2' OR tm.ctype='3' THEN
                  CALL cl_set_comp_visible('yeard3,yearc3',TRUE)
               END IF
            ELSE
               CALL cl_set_comp_visible('oyeard,oyearc,yeard,yearc,yeard2,yearc2,yeard3,yearc3',FALSE)
            END IF
            
         AFTER FIELD show_acc
            IF tm.show_acc NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_acc
            END IF
         
         AFTER FIELD glac005
            IF NOT cl_ap_chk_Range(tm.glac005,"1","1","99","1","azz-00087",1) THEN
               NEXT FIELD glac005
            END IF
         
         AFTER FIELD stus
            IF tm.stus NOT MATCHES '[123]' THEN
               NEXT FIELD stus
            END IF
            
         AFTER FIELD glac009
            IF tm.glac009 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glac009
            END IF
        
        AFTER FIELD show_ad
            IF tm.show_ad NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_ad
            END IF
            
         AFTER FIELD show_ce
            IF tm.show_ce NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_ce
            END IF
         
         AFTER FIELD show_ye
            IF tm.show_ye NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_ye
            END IF
         
      END INPUT
      
      BEFORE DIALOG
        #預設
        CALL aglq714_show()
        LET g_glar_d[1].sel = ""
        DISPLAY ARRAY g_glar_d TO s_detail1.*
           BEFORE DISPLAY
              EXIT DISPLAY
        END DISPLAY
        
       ON ACTION qbeclear   # 條件清除
          CLEAR FORM
          #預設
          CALL aglq714_glaald_desc(g_glaald)
          CALL aglq714_set_default_value()
          CALL aglq714_show()
      #end add-point 
      
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
      #還原
      LET g_wc = ls_wc
      LET l_flag=FALSE
   ELSE
      LET g_master_idx = 1
   END IF
   
   LET g_wc = g_wc_table 
 
 
        
   LET g_wc2 = " 1=1"
 
        
   #add-point:cs段after_construct
   IF l_flag=TRUE THEN
      IF cl_null(g_wc) THEN LET g_wc = " 1=1" END IF
      CALL aglq714_get_data()
      SELECT COUNT(*) INTO l_cnt FROM aglq714_tmp
      IF l_cnt=0 THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = -100
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         RETURN
      END IF
      CALL aglq714_set_page()
      CALL aglq714_fetch1('F')
   ELSE
      IF g_glar_d.getLength()>0 THEN
         CALL aglq714_b_fill1()
         DISPLAY g_current_idx TO FORMONLY.h_index
         DISPLAY g_glar_s.getLength() TO FORMONLY.h_count
         DISPLAY g_detail_idx TO FORMONLY.idx
      END IF
   END IF
   #end add-point
        
   LET g_error_show = 1
   #CALL aglq714_b_fill()
   LET l_ac = g_master_idx
   CALL aglq714_fetch()
#   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
#      CALL cl_err("",-100,1)
#   END IF
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
   
END FUNCTION
 
{</section>}
 
{<section id="aglq714.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq714_b_fill()
   {<Local define>}
   DEFINE ls_wc           STRING
   {</Local define>}
   #add-point:b_fill段define
       
       RETURN
   #end add-point
 
   #add-point:b_fill段sql_before

   #end add-point
   
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter
   
   LET g_sql = "SELECT  UNIQUE glar001,'',glar009,'','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','' FROM glar_t",
 
 
               "",
               " WHERE glarent= ? AND 1=1 AND ", ls_wc
    
   LET g_sql = g_sql, " ORDER BY glar_t.glarld,glar_t.glar001,glar_t.glar002,glar_t.glar003,glar_t.glar004"
  
   #add-point:b_fill段sql_after
  
   #end add-point
  
   PREPARE aglq714_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aglq714_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_glar_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_glar_d[l_ac].glar001,g_glar_d[l_ac].glar001_desc,g_glar_d[l_ac].glar009, 
       g_glar_d[l_ac].oyeard,g_glar_d[l_ac].oyearc,g_glar_d[l_ac].yeard,g_glar_d[l_ac].yearc,g_glar_d[l_ac].yeard2, 
       g_glar_d[l_ac].yearc2,g_glar_d[l_ac].yeard3,g_glar_d[l_ac].yearc3,g_glar_d[l_ac].oqcd,g_glar_d[l_ac].oqcc, 
       g_glar_d[l_ac].qcd,g_glar_d[l_ac].qcc,g_glar_d[l_ac].qcd2,g_glar_d[l_ac].qcc2,g_glar_d[l_ac].qcd3, 
       g_glar_d[l_ac].qcc3,g_glar_d[l_ac].oqj,g_glar_d[l_ac].qj,
       g_glar_d[l_ac].qj2,g_glar_d[l_ac].qj3,g_glar_d[l_ac].oqmd, 
       g_glar_d[l_ac].oqmc,g_glar_d[l_ac].qmd,g_glar_d[l_ac].qmc,g_glar_d[l_ac].qmd2,g_glar_d[l_ac].qmc2, 
       g_glar_d[l_ac].qmd3,g_glar_d[l_ac].qmc3,g_glar_d[l_ac].obsum,g_glar_d[l_ac].bsum, 
       g_glar_d[l_ac].bsum2,g_glar_d[l_ac].bsum3
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      LET g_glar_d[l_ac].sel = "N"
      #LET g_glar_d[l_ac].statepic = cl_get_actipic(g_glar_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充

      #end add-point
      
      CALL aglq714_detail_show()      
 
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
   LET g_error_show = 0
   
 
   
   CALL g_glar_d.deleteElement(g_glar_d.getLength())   
 
   
   #add-point:b_fill段資料填充(其他單身)

   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aglq714_pb
   
   LET l_ac = 1
   CALL aglq714_fetch()
   
      CALL aglq714_filter_show('glar001','b_glar001')
   CALL aglq714_filter_show('glar009','b_glar009')
 
   
END FUNCTION
 
{</section>}
 
{<section id="aglq714.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq714_fetch()
   {<Local define>}
   DEFINE li_ac           LIKE type_t.num5
   {</Local define>}
   #add-point:fetch段define
   RETURN
   #end add-point
   
 
   
   LET li_ac = l_ac 
   
 
   
   #DISPLAY g_detail_cnt TO FORMONLY.cnt
 
   #add-point:單身填充後
   
   #end add-point 
   
 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aglq714.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aglq714_detail_show()
   #add-point:show段define
   
   #end add-point
 
   #add-point:detail_show段之前
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
 
   
   #讀入ref值
   #add-point:show段單身reference
   
   #end add-point
   
 
 
   #add-point:detail_show段之後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq714.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aglq714_filter()
   {<Local define>}
   {</Local define>}
   #add-point:filter段define

   #end add-point    
   
   LET l_ac = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
    CONSTRUCT g_wc_filter ON glar001,glar009
                          FROM s_detail1[1].b_glar001,s_detail1[1].b_glar009
 
       BEFORE CONSTRUCT
#saki       CALL cl_qbe_init()
            DISPLAY aglq714_filter_parser('glar001') TO s_detail1[1].b_glar001
            DISPLAY aglq714_filter_parser('glar009') TO s_detail1[1].b_glar009
            
            
         ON ACTION controlp INFIELD b_glar001
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
		    	LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND glac006 = '1'"
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar001  #顯示到畫面上
 
            NEXT FIELD b_glar001                     #返回原欄位
 
 
            #END add-point
            
         ON ACTION controlp INFIELD b_glar009
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar009  #顯示到畫面上
            NEXT FIELD b_glar009                     #返回原欄位  
        
            
 
      END CONSTRUCT
 
      #add-point:filter段add_cs

      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog

         #end add-point  
 
      ON ACTION accept
         ACCEPT DIALOG 
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
 
   END DIALOG
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
   
    CALL aglq714_filter_show('glar001','b_glar001')
    CALL aglq714_filter_show('glar009','b_glar009')
 
  
    
    CALL aglq714_b_fill1()#160302-00006#1  ADD By 07675
  
 
   #CALL aglq714_b_fill()
   #CALL aglq714_fetch()
   
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq714.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aglq714_filter_parser(ps_field)
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}
   #add-point:filter段define
   
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
 
{<section id="aglq714.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aglq714_filter_show(ps_field,ps_object)
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
   LET ls_condition = aglq714_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq714.insert" >}
#+ insert
PRIVATE FUNCTION aglq714_insert()
   #add-point:insert段define
   
   #end add-point
 
   #add-point:insert段control
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aglq714.modify" >}
#+ modify
PRIVATE FUNCTION aglq714_modify()
   #add-point:modify段define
   
   #end add-point
 
   #add-point:modify段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq714.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aglq714_reproduce()
   #add-point:reproduce段define
   
   #end add-point
 
   #add-point:reproduce段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq714.delete" >}
#+ delete
PRIVATE FUNCTION aglq714_delete()
   #add-point:delete段define
   
   #end add-point
 
   #add-point:delete段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq714.other_function" >}
################################################################################
# Descriptions...: 建立臨時表
# Memo...........:
# Usage..........: CALL aglq714_create_temp_table()
# Date & Author..: 2014/03/10 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq714_create_temp_table()
   DROP TABLE aglq714_tmp
   CREATE TEMP TABLE aglq714_tmp(
   glar001      LIKE glar_t.glar001,
   glar009      LIKE glar_t.glar009,
   oyeard       LIKE glaq_t.glaq003,
   oyearc       LIKE glaq_t.glaq003,
   yeard        LIKE glaq_t.glaq003,
   yearc        LIKE glaq_t.glaq003,
   yeard2       LIKE glaq_t.glaq003,
   yearc2       LIKE glaq_t.glaq003,
   yeard3       LIKE glaq_t.glaq003,
   yearc3       LIKE glaq_t.glaq003,
   oqcd         LIKE glaq_t.glaq003,
   oqcc         LIKE glaq_t.glaq003,
   qcd          LIKE glaq_t.glaq003,
   qcc          LIKE glaq_t.glaq003,
   qcd2         LIKE glaq_t.glaq003,
   qcc2         LIKE glaq_t.glaq003,
   qcd3         LIKE glaq_t.glaq003,
   qcc3         LIKE glaq_t.glaq003,
   oqj          LIKE glaq_t.glaq003,
   qj           LIKE glaq_t.glaq003,
   qj2          LIKE glaq_t.glaq003,
   qj3          LIKE glaq_t.glaq003,
   oqmd         LIKE glaq_t.glaq003,
   oqmc         LIKE glaq_t.glaq003,
   qmd          LIKE glaq_t.glaq003,
   qmc          LIKE glaq_t.glaq003,
   qmd2         LIKE glaq_t.glaq003,
   qmc2         LIKE glaq_t.glaq003,
   qmd3         LIKE glaq_t.glaq003,
   qmc3         LIKE glaq_t.glaq003,
   obsum        LIKE glaq_t.glaq003,
   bsum         LIKE glaq_t.glaq003,
   bsum2        LIKE glaq_t.glaq003,
   bsum3        LIKE glaq_t.glaq003)
   
   DROP TABLE aglq714_tmp01              
   CREATE TEMP TABLE aglq714_tmp01(     
   glaald_desc    LIKE type_t.chr500,
   glaacomp_desc  LIKE type_t.chr500,
   glaa001_desc   LIKE type_t.chr500,
   year           LIKE type_t.chr500,
   mm             LIKE type_t.chr500,
   ctype          LIKE type_t.chr500,
   stus           LIKE type_t.chr500,
   glar001        LIKE glar_t.glar001, 
   glar001_desc   LIKE type_t.chr500, 
   qj             LIKE glaq_t.glaq003,
   qj2            LIKE glaq_t.glaq003,
   qj3            LIKE glaq_t.glaq003,
   bsum           LIKE glaq_t.glaq003,
   bsum2          LIKE glaq_t.glaq003,
   bsum3          LIKE glaq_t.glaq003
   )
   
END FUNCTION
################################################################################
# Descriptions...: 設置本位幣二、別你幣三顯示否
# Memo...........:
# Usage..........: CALL aglq714_set_curr_show()
# Date & Author..: 2014/03/13 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq714_set_curr_show()
   
   #顯示本位幣二
   IF tm.ctype='1' THEN
      IF tm.show_y='Y' THEN
         CALL cl_set_comp_visible("yeard2,yearc2",TRUE)
      ELSE
         CALL cl_set_comp_visible("yeard2,yearc2",FALSE)
      END IF
      CALL cl_set_comp_visible("qj2,bsum2",TRUE)
   ELSE
      CALL cl_set_comp_visible("yeard2,yearc2,qcd2,qcc2,qj2,qmd2,qmc2,bsum2",FALSE)
   END IF
   #顯示本位幣三
   IF tm.ctype='2' THEN
      IF tm.show_y='Y' THEN
         CALL cl_set_comp_visible("yeard3,yearc3",TRUE)
      ELSE
         CALL cl_set_comp_visible("yeard3,yearc3",FALSE)
      END IF
      CALL cl_set_comp_visible("qj3,bsum3",TRUE)
   ELSE
      CALL cl_set_comp_visible("yeard3,yearc3,qcd3,qcc3,qj3,qmd3,qmc3,bsum3",FALSE)
   END IF
   #全部
   IF tm.ctype='3' THEN
      IF tm.show_y='Y' THEN
         CALL cl_set_comp_visible("yeard2,yearc2,yeard3,yearc3",TRUE)
      ELSE
         CALL cl_set_comp_visible("yeard2,yearc2,yeard3,yearc3",FALSE)
      END IF
      CALL cl_set_comp_visible("qj2,bsum2",TRUE)
      CALL cl_set_comp_visible("qj3,bsum3",TRUE)
   END IF
END FUNCTION
################################################################################
# Descriptions...: 獲取帳套相關資料
# Memo...........:
# Usage..........: CALL aglq714_glaald_desc(p_glaald)
# Input parameter: p_glaald   帳套
# Date & Author..: 2014/03/10 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq714_glaald_desc(p_glaald)
   DEFINE  p_glaald    LIKE glaa_t.glaald
   
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_glaald 
    CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_glaald_desc=g_rtn_fields[1]
    #依据对应的主账套编码，抓取对应法人，币别，汇率参照编号，会计科目参照编号,关账日期
   SELECT glaacomp,glaa001,glaa002,glaa003,glaa004,glaa013,
          glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,
          glaa021,glaa022 
     INTO g_glaacomp,g_glaa001,g_glaa002,g_glaa003,g_glaa004,g_glaa013,
          g_glaa015,g_glaa016,g_glaa017,g_glaa018,g_glaa019,g_glaa020,
          g_glaa021,g_glaa022
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_glaald 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glaacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glaacomp_desc= g_rtn_fields[1]
  
   #本位幣二
   IF g_glaa015='Y' THEN
      CALL cl_set_comp_visible("glaa016",TRUE)
   ELSE
      CALL cl_set_comp_visible("glaa016",FALSE)
   END IF
   #本位幣三
   IF g_glaa019='Y' THEN
      CALL cl_set_comp_visible("glaa020",TRUE)
   ELSE
      CALL cl_set_comp_visible("glaa020",FALSE)
   END IF 
   #多本位幣
   CALL cl_set_comp_entry("ctype",TRUE)
   CASE
      WHEN g_glaa015<>'Y' AND g_glaa019<>'Y' 
         CALL cl_set_comp_entry("ctype",FALSE)
         CALL cl_set_combo_scc_part('ctype','9921','0')
      WHEN g_glaa015='Y' AND g_glaa019<>'Y' 
         CALL cl_set_combo_scc_part('ctype','9921','0,1')
      WHEN g_glaa015<>'Y' AND g_glaa019='Y' 
         CALL cl_set_combo_scc_part('ctype','9921','0,2') 
      WHEN g_glaa015='Y' AND g_glaa019='Y' 
         CALL cl_set_combo_scc_part('ctype','9921','0,1,2,3')
   END CASE
   LET tm.ctype='0'
   #年初數
   IF cl_null(tm.show_y) THEN
      LET tm.show_y='N'
   END IF
   CALL aglq714_set_curr_show() #顯示本位幣二、本位幣三
END FUNCTION
################################################################################
# Descriptions...: 抓取數據
# Memo...........: 只抓取已过账的CE或YE或AD凭证
# Usage..........: CALL aglq714_get_data()
# Date & Author..: 2014/03/10 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq714_get_data()
   DEFINE l_pdate_s1       LIKE glav_t.glav004 #起始年度+期別對應的起始截止日期
   DEFINE l_pdate_e1       LIKE glav_t.glav004
   DEFINE l_pdate_s2       LIKE glav_t.glav004 #截止年度+期別對應的起始截止日期
   DEFINE l_pdate_e2       LIKE glav_t.glav004
   DEFINE l_flag1          LIKE type_t.chr1
   DEFINE l_errno          LIKE type_t.chr100
   DEFINE l_glav002        LIKE glav_t.glav002
   DEFINE l_glav005        LIKE glav_t.glav005
   DEFINE l_sdate_s        LIKE glav_t.glav004
   DEFINE l_sdate_e        LIKE glav_t.glav004
   DEFINE l_glav006        LIKE glav_t.glav006
   DEFINE l_glav007        LIKE glav_t.glav007
   DEFINE l_wdate_s        LIKE glav_t.glav004
   DEFINE l_wdate_e        LIKE glav_t.glav004
   DEFINE l_flag           LIKE type_t.num5    #表示是否是完整期別
   DEFINE l_sql,l_sql1,l_sql2   STRING
   DEFINE l_sql3,l_sql4         STRING
   DEFINE l_wc,l_wc1            STRING 
   DEFINE l_glaq002        STRING
   DEFINE l_glaq002_desc   LIKE glacl_t.glacl004
   DEFINE l_glar009        LIKE glar_t.glar009
   DEFINE l_oyeard         LIKE type_t.num20_6
   DEFINE l_oyearc         LIKE type_t.num20_6
   DEFINE l_yeard          LIKE type_t.num20_6
   DEFINE l_yearc          LIKE type_t.num20_6
   DEFINE l_yeard2         LIKE type_t.num20_6
   DEFINE l_yearc2         LIKE type_t.num20_6
   DEFINE l_yeard3         LIKE type_t.num20_6
   DEFINE l_yearc3         LIKE type_t.num20_6
   DEFINE l_oqcd           LIKE type_t.num20_6
   DEFINE l_oqcc           LIKE type_t.num20_6
   DEFINE l_qcd            LIKE type_t.num20_6
   DEFINE l_qcc            LIKE type_t.num20_6
   DEFINE l_qcd2           LIKE type_t.num20_6
   DEFINE l_qcc2           LIKE type_t.num20_6
   DEFINE l_qcd3           LIKE type_t.num20_6
   DEFINE l_qcc3           LIKE type_t.num20_6
   DEFINE l_oqjd           LIKE type_t.num20_6
   DEFINE l_oqjc           LIKE type_t.num20_6
   DEFINE l_qjd            LIKE type_t.num20_6
   DEFINE l_qjc            LIKE type_t.num20_6
   DEFINE l_qjd2           LIKE type_t.num20_6
   DEFINE l_qjc2           LIKE type_t.num20_6
   DEFINE l_qjd3           LIKE type_t.num20_6
   DEFINE l_qjc3           LIKE type_t.num20_6
   DEFINE l_oqj            LIKE type_t.num20_6
   DEFINE l_qj             LIKE type_t.num20_6
   DEFINE l_qj2            LIKE type_t.num20_6
   DEFINE l_qj3            LIKE type_t.num20_6
   DEFINE l_oqmd           LIKE type_t.num20_6
   DEFINE l_oqmc           LIKE type_t.num20_6
   DEFINE l_qmd            LIKE type_t.num20_6
   DEFINE l_qmc            LIKE type_t.num20_6
   DEFINE l_qmd2           LIKE type_t.num20_6
   DEFINE l_qmc2           LIKE type_t.num20_6
   DEFINE l_qmd3           LIKE type_t.num20_6
   DEFINE l_qmc3           LIKE type_t.num20_6
   DEFINE l_osumd          LIKE type_t.num20_6
   DEFINE l_osumc          LIKE type_t.num20_6
   DEFINE l_sumd           LIKE type_t.num20_6
   DEFINE l_sumc           LIKE type_t.num20_6
   DEFINE l_sumd2          LIKE type_t.num20_6
   DEFINE l_sumc2          LIKE type_t.num20_6
   DEFINE l_sumd3          LIKE type_t.num20_6
   DEFINE l_sumc3          LIKE type_t.num20_6
   DEFINE l_obsum          LIKE type_t.num20_6
   DEFINE l_bsum           LIKE type_t.num20_6
   DEFINE l_bsum2          LIKE type_t.num20_6
   DEFINE l_bsum3          LIKE type_t.num20_6
   DEFINE l_amt1           LIKE type_t.num20_6
   DEFINE l_amt2           LIKE type_t.num20_6
   DEFINE l_amt3           LIKE type_t.num20_6
   DEFINE l_amt4           LIKE type_t.num20_6
   DEFINE l_amt5           LIKE type_t.num20_6
   DEFINE l_amt6           LIKE type_t.num20_6
   DEFINE l_amt7           LIKE type_t.num20_6
   DEFINE l_amt8           LIKE type_t.num20_6
   DEFINE l_period         LIKE glap_t.glap004
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_str,l_str1,l_str2   STRING
   DEFINE l_glac002        LIKE glac_t.glac002
   DEFINE l_glav004        LIKE glav_t.glav004
   DEFINE l_glav004_m      LIKE glav_t.glav004
   DEFINE l_glav004_e      LIKE glav_t.glav004
   DEFINE l_glac002_str    STRING            
   DEFINE l_sql_pr         STRING
   DEFINE l_sql_pr_1       STRING
   DEFINE l_sql_pr2        STRING
   DEFINE l_sql_pr4        STRING
   DEFINE l_sql_pr5        STRING
   DEFINE l_sql_pr6        STRING
   DEFINE l_sql_pr7        STRING
   DEFINE l_sql_pr8        STRING
   DEFINE l_sql_pr6_1      STRING
   DEFINE l_sql_pr7_1      STRING
   DEFINE l_sql_pr8_1      STRING
   DEFINE l_glac003        LIKE glac_t.glac003
   DEFINE l_sql_t01        STRING  
   DEFINE l_sql_t02        STRING 
   DEFINE l_sql_t03        STRING 
   DEFINE l_sql_nch        STRING 
   DEFINE l_sql_qch        STRING 
   DEFINE l_sql_qj         STRING 
   DEFINE l_sql_lj         STRING
   
   #刪除臨時表中資料
   DELETE FROM aglq714_tmp
   
   CALL s_get_accdate(g_glaa003,'',tm.year,tm.smm) 
   RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s1,l_pdate_e1,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag1='N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

   END IF

   CALL s_get_accdate(g_glaa003,'',tm.year,tm.emm) 
   RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s2,l_pdate_e2,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag1='N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

   END IF
   
   LET l_wc=cl_replace_str(g_wc,'glar001','glaq002')
   LET l_wc1=cl_replace_str(g_wc1,'glar009','glaq005')
   LET l_sql1=cl_replace_str(g_wc,'glar001','glac002')
   #顯示統制科目否
   IF tm.show_acc<>'Y' THEN
      LET l_sql1=l_sql1," AND glac003<>'1' "
   END IF
   #科目層級
   IF NOT cl_null(tm.glac005) THEN
      LET l_sql1=l_sql1," AND glac005<=",tm.glac005
   END IF
   #含內部管理科目否
   IF tm.glac009<>'Y' THEN
      LET l_sql1=l_sql1," AND glac009<>'Y'"
   END IF

   #含年結YE憑證否
   IF tm.show_ye<>'Y' THEN
      LET l_sql2=l_sql2," AND glap007<>'YE' "
      IF NOT cl_null(l_sql3) THEN
         LET l_sql3=l_sql3,",'YE'"
      ELSE
         LET l_sql3="'YE'" 
      END IF
   END IF

   #含AD審計調整傳票否
   IF tm.show_ad<>'Y' THEN
      LET l_sql2=l_sql2," AND glap007<>'AD' "
      IF NOT cl_null(l_sql3) THEN
         LET l_sql3=l_sql3,",'AD'"
      ELSE
         LET l_sql3="'AD'" 
      END IF
   END IF

   IF NOT cl_null(l_sql3) THEN
      LET l_sql3=" AND glap007 IN (",l_sql3,")"
   END IF
   #單據狀態
   CASE
      WHEN tm.stus='1'
         LET l_sql4=l_sql4," AND glapstus='S' "
      WHEN tm.stus='2'
         LET l_sql4=l_sql4," AND glapstus IN ('S','Y') "
      WHEN tm.stus='3'
         LET l_sql4=l_sql4," AND glapstus IN ('S','Y','N') "
   END CASE
   
   #抓取該年第一天
   SELECT MIN(glav004) INTO l_glav004 FROM glav_t
    WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.year
   #抓取上一期最後一天
   IF tm.smm > 1 THEN
      LET l_period=tm.smm-1 #上期
      SELECT MAX(glav004) INTO l_glav004_m FROM glav_t
       WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.year AND glav006=l_period
   ELSE
      #抓取上一年的最后一天
      SELECT MAX(glav004) INTO l_glav004_m FROM glav_t
       WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.year-1 
      IF cl_null(l_glav004_m) THEN
         LET l_glav004_m=MDY(12,31,l_pdate_s1-1)
      END IF
   END IF
   
   LET l_glav004_e=l_glav004_m
   
   #抓取科目及金额
   IF tm.curr_o<>'Y' THEN
      #抓取栏位
      LET g_sql="SELECT glac002,glac003,'',"
      #年初數
      IF tm.show_y='Y' THEN 
         LET g_sql=g_sql,
                   #年初數：原幣借方
                   "       CASE WHEN nch.glar010>=0 THEN nch.glar010 ELSE 0 END,",
                   #年初數：原幣貸方
                   "       CASE WHEN nch.glar010<0 THEN nch.glar010*-1 ELSE 0 END,",
                   #年初數：本幣借方
                   "       CASE WHEN nch.glar005>=0 THEN nch.glar005 ELSE 0 END,",
                   #年初數：本幣貸方
                   "       CASE WHEN nch.glar005<0 THEN nch.glar005*-1 ELSE 0 END,",
                   #年初數：本位幣二借方
                   "       CASE WHEN nch.glar034>=0 THEN nch.glar034 ELSE 0 END,",
                   #年初數：本位幣二貸方
                   "       CASE WHEN nch.glar034<0 THEN nch.glar034*-1 ELSE 0 END,",
                   #年初數：本位幣三借方
                   "       CASE WHEN nch.glar036>=0 THEN nch.glar036 ELSE 0 END,",
                   #年初數：本位幣三貸方
                   "       CASE WHEN nch.glar036<0 THEN nch.glar036*-1 ELSE 0 END,"
      ELSE
         LET g_sql=g_sql,
                   "       0,0,0,0,0,0,0,0, "
      END IF
   
      LET g_sql=g_sql,
                #期初金額（借-貸）
                #原幣      /本幣   /本幣二  /本幣三
                " qch.oqcd,qch.qcd,qch.qcd2,qch.qcd3,",
                #期間異動
                #原幣借     /原幣貸   /本幣借  /本幣貸  /本幣二借  /本幣二貸  /本幣三借  /本幣三貸
                " qj.oqjd,  qj.oqjc, qj.qjd, qj.qjc,  qj.qjd2,  qj.qjc2,  qj.qjd3,  qj.qjc3,",
                #本年累計
                #原幣借     /原幣貸    /本幣借   /本幣貸  /本幣二借  /本幣二貸  /本幣三借  /本幣三貸
                " lj.osumd, lj.osumc, lj.sumd, lj.sumc, lj.sumd2, lj.sumc2, lj.sumd3,  lj.sumc3",
                " FROM glac_t"
      
      #年初數
      IF tm.show_y='Y' THEN 
         LET g_sql=g_sql,
                   "  LEFT JOIN (",
                   "             SELECT glar001,SUM(glar010-glar011) glar010,SUM(glar005-glar006) glar005,",
                   "                            SUM(glar034-glar035) glar034,SUM(glar036-glar037) glar036 ",
                   "               FROM glar_t",    
                   "              WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
                   "                AND glar002=",tm.year," AND glar003=0  ",
                   "              GROUP BY glar001 ",
                   "            ) nch ON glac002 = nch.glar001"
      END IF
   
      #期初
      #當傳票狀態是已過帳時抓取餘額當glar_t資料，否則抓取傳票當glaq_t資料
      IF tm.stus='1' THEN 
         LET l_period=tm.smm-1 #上期
         LET g_sql=g_sql,
                   " LEFT JOIN (",
                   #                    科目    /原幣借-貸                 /本幣借-貸
                   "             SELECT glar001,SUM(glar010-glar011) oqcd,SUM(glar005-glar006) qcd,",
                   #                           本幣二借-貸                 /本幣三借-貸
                   "                            SUM(glar034-glar035) qcd2,SUM(glar036-glar037) qcd3 ",
                   "               FROM glar_t",    
                   "              WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
                   "                AND glar002=",tm.year," AND glar003<=",l_period,
                   "              GROUP BY glar001 ",
                   "           ) qch ON glac002=qch.glar001"
      ELSE
         LET g_sql=g_sql,
                   " LEFT JOIN (",
                   #                    科目    /原幣借-貸
                   "            SELECT glaq002,SUM(CASE WHEN glaq003=0 THEN glaq010*-1 ELSE glaq010 END) oqcd,",
                   #                   本幣借-貸                 /本幣二借-貸               /本幣三借-貸
                   "                   SUM(glaq003-glaq004) qcd,SUM(glaq040-glaq041) qcd2,SUM(glaq043-glaq044) qcd3",
                   "              FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                   "             WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                   "               AND glap002 = ",tm.year,
                   "               AND glap004 <= ",tm.smm - 1,
                   "               AND ",l_wc1,l_sql2,l_sql4,
                   "             GROUP BY glaq002 ",
                   "           ) qch ON glac002=qch.glaq002"
      END IF
   
      #期間異動
      #当傳票狀態是已過帳时，抓取餘額當glar_t資料，否則抓取傳票當glaq_t資料
      IF tm.stus='1' THEN
         LET g_sql=g_sql,
                   " LEFT JOIN (",
                   #                   科目    /原幣借方金額      /原幣貸方金額 
                   "            SELECT glar001,SUM(glar010) oqjd,SUM(glar011) oqjc,",
                   #                   本幣借方金額       /本幣貸方金額
                   "                   SUM(glar005) qjd, SUM(glar006) qjc,",
                   #                   本幣二借方金額      /本幣二貸方金額     /本幣三借方金額     /本幣三貸方金額
                   "                   SUM(glar034) qjd2, SUM(glar035) qjc2, SUM(glar036) qjd3, SUM(glar037) qjc3",
                   "              FROM glar_t",
                   "             WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"'",
                   "               AND glar002=",tm.year,
                   "               AND glar003 BETWEEN ",tm.smm," AND ",tm.emm,
                   "               AND ",g_wc1,  
                   "             GROUP BY glar001 ",
                   "           ) qj ON glac002=qj.glar001"
      ELSE
         LET g_sql=g_sql,
                   " LEFT JOIN (",
                   #                   科目    /原幣借方金額 
                   "            SELECT glaq002,SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END ) oqjd,",
                   #                   原幣貸方金額
                   "                   SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END ) oqjc,",
                   #                   本幣借方金額      /本幣貸方金額     /本幣二借方金額    /本幣二貸方金額 
                   "                   SUM(glaq003) qjd,SUM(glaq004) qjc,SUM(glaq040) qjd2,SUM(glaq041) qjc2,",
                   #                   本幣三借方金額     /本幣三貸方金額
                   "                   SUM(glaq043) qjd3,SUM(glaq044) qjc3",
                   "              FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                   "             WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                   "               AND glap002 = ",tm.year,
                   "               AND glap004 BETWEEN ",tm.smm," AND ",tm.emm,
                   "               AND ",l_wc1,l_sql2,l_sql4,
                   "             GROUP BY glaq002 ",
                   "           ) qj ON glac002=qj.glaq002"
      END IF
   
      #本年累計
      #當截止日期為該期最後一天，且傳票狀態為1：已過帳時，抓取glar_t餘額當資料,否則，直接抓取glaq_t傳票資料
      IF tm.stus='1' THEN
         LET g_sql=g_sql,
                   " LEFT JOIN (",
                   #                   科目    /原幣借方金額       /原幣貸方金額       /本幣借方金額      /本幣貸方金額
                   "            SELECT glar001,SUM(glar010) osumd,SUM(glar011) osumc,SUM(glar005) sumd,SUM(glar006) sumc,",
                   #                   本幣二借方金額      /本幣二貸方金額     /本幣三借方金額      /本幣三貸方金額
                   "                   SUM(glar034) sumd2,SUM(glar035) sumc2,SUM(glar036) sumd3,SUM(glar037) sumc3",
                   "              FROM glar_t",    
                   "             WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
                   "               AND glar002=",tm.year," AND glar003<= ",tm.emm,
                   "               AND glar003<>0",  
                   "             GROUP BY glar001 ",
                   "           ) lj ON glac002=lj.glar001"
      ELSE
         LET g_sql=g_sql,
                   " LEFT JOIN (",
                   #                   科目    /原幣借方金額
                   "            SELECT glaq002,SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END) osumd,",
                   #                   原幣貸方金額
                   "                   SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END) osumc,",
                   #                   本幣借方金額       /本幣貸方金額      /本幣二借方金額      /本幣二貸方金額
                   "                   SUM(glaq003) sumd,SUM(glaq004) sumc,SUM(glaq040) sumd2,SUM(glaq041) sumc2,",
                   #                   本幣三借方金額      /本幣三貸方金額
                   "                   SUM(glaq043) sumd3,SUM(glaq044) sumc3",
                   "              FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                   "             WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                   "               AND glap002 = ",tm.year,
                   "               AND glap004 <= ",tm.emm,
                   "               AND ",l_wc1,l_sql2,l_sql4,
                   "             GROUP BY glaq002 ",
                   "           ) lj ON glac002=lj.glaq002"
      END IF
      LET g_sql=g_sql,
                " WHERE glacent=",g_enterprise,
                "   AND glac001='",g_glaa004,"' AND ",l_sql1,
                "   AND glacstus='Y'", 
                " ORDER BY glac002"
   ELSE
      #当查询条件是：显示原币，不显示统制科目或（显示统制科目+凭证状态是已过账）时，可以通过科目+币别直接抓取金额
      IF tm.show_acc <> 'Y' OR (tm.show_acc = 'Y' AND tm.stus = '1' ) THEN
         LET g_sql="SELECT km.glac002,km.glac003,km.glar009,"
         #年初數
         IF tm.show_y='Y' THEN 
            LET g_sql=g_sql,
                      #年初數：原幣借方
                      "       CASE WHEN nch.glar010>=0 THEN nch.glar010 ELSE 0 END,",
                      #年初數：原幣貸方
                      "       CASE WHEN nch.glar010<0 THEN nch.glar010*-1 ELSE 0 END,",
                      #年初數：本幣借方
                      "       CASE WHEN nch.glar005>=0 THEN nch.glar005 ELSE 0 END,",
                      #年初數：本幣貸方
                      "       CASE WHEN nch.glar005<0 THEN nch.glar005*-1 ELSE 0 END,",
                      #年初數：本位幣二借方
                      "       CASE WHEN nch.glar034>=0 THEN nch.glar034 ELSE 0 END,",
                      #年初數：本位幣二貸方
                      "       CASE WHEN nch.glar034<0 THEN nch.glar034*-1 ELSE 0 END,",
                      #年初數：本位幣三借方
                      "       CASE WHEN nch.glar036>=0 THEN nch.glar036 ELSE 0 END,",
                      #年初數：本位幣三貸方
                      "       CASE WHEN nch.glar036<0 THEN nch.glar036*-1 ELSE 0 END,"
         ELSE
            LET g_sql=g_sql,
                      "       0,0,0,0,0,0,0,0, "
         END IF
      
         LET g_sql=g_sql,
                   #期初金額（借-貸）
                   #原幣      /本幣   /本幣二  /本幣三
                   " qch.oqcd,qch.qcd,qch.qcd2,qch.qcd3,",
                   #期間異動
                   #原幣借     /原幣貸   /本幣借  /本幣貸  /本幣二借  /本幣二貸  /本幣三借  /本幣三貸
                   " qj.oqjd,  qj.oqjc, qj.qjd, qj.qjc,  qj.qjd2,  qj.qjc2,  qj.qjd3,  qj.qjc3,",
                   #本年累計
                   #原幣借     /原幣貸    /本幣借   /本幣貸  /本幣二借  /本幣二貸  /本幣三借  /本幣三貸
                   " lj.osumd, lj.osumc, lj.sumd, lj.sumc, lj.sumd2, lj.sumc2, lj.sumd3,  lj.sumc3"
         
         #抓取科目+币别
         #当传票状态为已过正时抓取glar_t资料，反之抓取glaq_t资料
         IF tm.stus = '1' THEN
            LET g_sql=g_sql,
                      " FROM (",
                      "       SELECT DISTINCT glac002,glac003,glar009 ",
                      "         FROM glac_t,glar_t ",
                      "        WHERE glacent=glarent AND glac002=glar001",
                      "          AND glacent=",g_enterprise,
                      "          AND glac001='",g_glaa004,"' AND ",l_sql1,
                      "          AND glacstus='Y'",
                      "          AND glarld='",g_glaald,"' "
            LET g_sql=g_sql,
                      " AND glar002=",tm.year,
                      " AND glar003<=",tm.emm
            LET g_sql=g_sql,
                      " AND ",g_wc1,
                      "      ) km "
         ELSE 
            LET g_sql=g_sql,
                      " FROM (",
                      "       SELECT DISTINCT glac002,glac003,glar009 ",
                      "       FROM (",
                      "             SELECT glac002,glac003,glaq005 glar009 ",
                      "               FROM glac_t,",
                      "                    glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                      "              WHERE glacent=glaqent AND glac002=glaq002",
                      "                AND glacent=",g_enterprise,
                      "                AND glac001='",g_glaa004,"' AND ",l_sql1,
                      "                AND glacstus='Y'",
                      "                AND glaqld='",g_glaald,"' ",
                      "                AND glap002 = ",tm.year,
                      "                AND glap004 <= ",tm.emm,
                      "                AND ",l_wc1,l_sql2,l_sql4,
                      "             UNION ",
                      "             SELECT glac002,glac003,glar009 ",
                      "               FROM glac_t,glar_t ",
                      "              WHERE glacent=glarent AND glac002=glar001",
                      "                AND glacent=",g_enterprise,
                      "                AND glac001='",g_glaa004,"' AND ",l_sql1,
                      "                AND glacstus='Y'",
                      "                AND glarld='",g_glaald,"' ",
                      "                AND glar002 = ",tm.year,
                      "                AND glar003 = 0 ",
                      "                AND ",g_wc1,
                      "            )",
                      "      ) km "
         END IF
   
         #年初數
         IF tm.show_y='Y' THEN 
            LET g_sql=g_sql,
                      "  LEFT JOIN (",
                      #                    科目    /币别
                      "             SELECT glar001,glar009,",
                      #                    原幣借-貸                 /本幣借-貸
                      "                    SUM(glar010-glar011) glar010,SUM(glar005-glar006) glar005,",
                      #                    本幣二借-貸                 /本幣三借-貸
                      "                    SUM(glar034-glar035) glar034,SUM(glar036-glar037) glar036 ",
                      "               FROM glar_t",    
                      "              WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
                      "                AND glar002=",tm.year," AND glar003=0  ",
                      "              GROUP BY glar001,glar009 ",
                      "            ) nch ON km.glac002 = nch.glar001 AND km.glar009 = nch.glar009 "
         END IF
   
         #期初
         #當傳票狀態是已過帳時抓取餘額當glar_t資料，否則抓取傳票當glaq_t資料
         IF tm.stus='1' THEN 
            LET l_period = tm.smm-1 #上期
            LET g_sql=g_sql,
                      " LEFT JOIN (",
                      #                    科目    /币别
                      "             SELECT glar001,glar009,",
                      #                    原幣借-貸                 /本幣借-貸
                      "                    SUM(glar010-glar011) oqcd,SUM(glar005-glar006) qcd,",
                      #                    本幣二借-貸                 /本幣三借-貸
                      "                    SUM(glar034-glar035) qcd2,SUM(glar036-glar037) qcd3 ",
                      "               FROM glar_t",    
                      "              WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
                      "                AND glar002=",tm.year," AND glar003<=",l_period,
                      "              GROUP BY glar001,glar009 ",
                      "           ) qch ON km.glac002=qch.glar001 AND km.glar009 = qch.glar009 "
         ELSE
            LET g_sql=g_sql,
                      " LEFT JOIN (",
                      #                   科目    /币别
                      "            SELECT glaq002,glaq005,",
                      #                   原幣借-貸
                      "                   SUM(CASE WHEN glaq003=0 THEN glaq010*-1 ELSE glaq010 END) oqcd,",
                      #                   本幣借-貸                 /本幣二借-貸               /本幣三借-貸
                      "                   SUM(glaq003-glaq004) qcd,SUM(glaq040-glaq041) qcd2,SUM(glaq043-glaq044) qcd3",
                      "              FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                      "             WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                      "               AND glap002 = ",tm.year,
                      "               AND glap004 < ",tm.smm,
                      "               AND ",l_wc1,l_sql2,l_sql4,
                      "             GROUP BY glaq002,glaq005 ",
                      "           ) qch ON km.glac002=qch.glaq002 AND km.glar009 = qch.glaq005"
         END IF
   
         #期間異動
         #当傳票狀態是已過帳时，抓取餘額檔glar_t資料，否則抓取傳票檔glaq_t資料
         IF tm.stus='1' THEN
            LET g_sql=g_sql,
                      " LEFT JOIN (",
                      #                   科目    /币别   /原幣借方金額      /原幣貸方金額 
                      "            SELECT glar001,glar009,SUM(glar010) oqjd,SUM(glar011) oqjc,",
                      #                   本幣借方金額       /本幣貸方金額
                      "                   SUM(glar005) qjd, SUM(glar006) qjc,",
                      #                   本幣二借方金額      /本幣二貸方金額     /本幣三借方金額     /本幣三貸方金額
                      "                   SUM(glar034) qjd2, SUM(glar035) qjc2, SUM(glar036) qjd3, SUM(glar037) qjc3",
                      "              FROM glar_t",
                      "             WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"'",
                      "               AND glar002=",tm.year,
                      "               AND glar003 BETWEEN ",tm.smm," AND ",tm.emm,
                      "               AND ",g_wc1,  
                      "             GROUP BY glar001,glar009 ",
                      "           ) qj ON km.glac002=qj.glar001 AND km.glar009 = qj.glar009 "
         ELSE
            LET g_sql=g_sql,
                      " LEFT JOIN (",
                      #                   科目    /币别
                      "            SELECT glaq002,glaq005,",
                      #                   原幣借方金額
                      "                   SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END ) oqjd,",
                      #                   原幣貸方金額
                      "                   SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END ) oqjc,",
                      #                   本幣借方金額      /本幣貸方金額     /本幣二借方金額    /本幣二貸方金額 
                      "                   SUM(glaq003) qjd,SUM(glaq004) qjc,SUM(glaq040) qjd2,SUM(glaq041) qjc2,",
                      #                   本幣三借方金額     /本幣三貸方金額
                      "                   SUM(glaq043) qjd3,SUM(glaq044) qjc3",
                      "              FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                      "             WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                      "               AND glap002 = ",tm.year,
                      "               AND glap004 BETWEEN ",tm.smm," AND ",tm.emm,
                      "               AND ",l_wc1,l_sql2,l_sql4,
                      "             GROUP BY glaq002,glaq005 ",
                      "           ) qj ON km.glac002=qj.glaq002 AND km.glar009 = qj.glaq005"
         END IF
   
         #本年累計
         #當傳票狀態為1：已過帳時，抓取glar_t餘額當資料,否則，直接抓取glaq_t傳票資料
         IF tm.stus='1' THEN
            LET g_sql=g_sql,
                      " LEFT JOIN (",
                      #                   科目    /币别
                      "            SELECT glar001,glar009,",
                      #                   原幣借方金額       /原幣貸方金額       /本幣借方金額      /本幣貸方金額
                      "                   SUM(glar010) osumd,SUM(glar011) osumc,SUM(glar005) sumd,SUM(glar006) sumc,",
                      #                   本幣二借方金額      /本幣二貸方金額     /本幣三借方金額      /本幣三貸方金額
                      "                   SUM(glar034) sumd2,SUM(glar035) sumc2,SUM(glar036) sumd3,SUM(glar037) sumc3",
                      "              FROM glar_t",    
                      "             WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
                      "               AND glar002=",tm.year," AND glar003<= ",tm.emm,
                      "               AND glar003<>0 ", 
                      "             GROUP BY glar001,glar009 ",
                      "           ) lj ON km.glac002=lj.glar001 AND km.glar009 = lj.glar009"
         ELSE
            LET g_sql=g_sql,
                      " LEFT JOIN (",
                      #                   科目    /币别    /原幣借方金額
                      "            SELECT glaq002,glaq005,SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END) osumd,",
                      #                   原幣貸方金額
                      "                   SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END) osumc,",
                      #                   本幣借方金額       /本幣貸方金額      /本幣二借方金額      /本幣二貸方金額
                      "                   SUM(glaq003) sumd,SUM(glaq004) sumc,SUM(glaq040) sumd2,SUM(glaq041) sumc2,",
                      #                   本幣三借方金額      /本幣三貸方金額
                      "                   SUM(glaq043) sumd3,SUM(glaq044) sumc3",
                      "              FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                      "             WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                      "               AND glap002 = ",tm.year,
                      "               AND glap004 <= ",tm.emm,
                      "               AND ",l_wc1,l_sql2,l_sql4,
                      "             GROUP BY glaq002,glaq005 ",
                      "           ) lj ON km.glac002=lj.glaq002 AND km.glar009 = lj.glaq005"
         END IF
         LET g_sql=g_sql,
                   " ORDER BY glac002"
      ELSE
         #需要遍历科目，在通过币别查询金额
         LET g_sql="SELECT glac002,glac003 FROM glac_t",
                   " WHERE glacent=",g_enterprise,
                   "   AND glac001='",g_glaa004,"' AND ",l_sql1,
                   "   AND glacstus='Y'", 
                   " ORDER BY glac002"
      END IF
   END IF
   PREPARE aglq714_sel_glac_pr FROM g_sql
   DECLARE aglq714_sel_glac_cs CURSOR FOR aglq714_sel_glac_pr
   #160503-00025#1--add--end
   
   
   #年初、期初
   LET l_sql="SELECT SUM(glar010-glar011),SUM(glar005-glar006),SUM(glar034-glar035),SUM(glar036-glar037) FROM glar_t",    
             " WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
             "   AND glar001 = ? AND glar002=? AND glar003<=?  "
   IF tm.curr_o='Y' THEN
      LET l_sql=l_sql," AND glar009=?"
   END IF
   PREPARE aglq714_sel_pr1 FROM l_sql


   #期間異動
   #当整期间且不跨年查询时
   IF tm.stus='1' THEN 

   ELSE 
      LET l_sql_pr5="SELECT SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END ),",
                    "       SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END ),",
                    "       SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),SUM(glaq043),SUM(glaq044)",
                    "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                    " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                    "   AND glap002 = ",tm.year,
                    "   AND glap004 BETWEEN ",tm.smm," AND ",tm.emm,
                    l_sql2,l_sql4," AND ",l_wc1
      IF tm.curr_o='Y' THEN 
         LET l_sql_pr5=l_sql_pr5," AND glaq005=? "
      END IF
   END IF 
   
   #期初：根據不同傳票類型抓glaq_t資料(stus=1/2/3)   
   LET l_sql_pr2="SELECT SUM(CASE WHEN glaq003=0 THEN glaq010*-1 ELSE glaq010 END),",
                 "      SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                 "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                 " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                 "   AND glap002 = ? AND glap004 < ?",
                 "   AND ",l_wc1,l_sql2,l_sql4
   IF tm.curr_o='Y' THEN
      LET l_sql_pr2=l_sql_pr2," AND glaq005=?"
   END IF
   
   IF tm.show_ye <> 'Y' OR tm.show_ad <> 'Y' THEN 
      #期初：抓取YE、AD傳票金額
      LET l_sql_pr6="SELECT SUM(CASE WHEN glaq003=0 THEN glaq010*-1 ELSE glaq010 END),",
                    "      SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                    "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                    " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                    "   AND glap002= ? AND glap004<=? ",
                    "   AND glapstus='S' ",
                    "   AND ",l_wc1,l_sql3
      IF tm.curr_o='Y' THEN
         LET l_sql_pr6=l_sql_pr6," AND glaq005=?"
      END IF
      
      #用于本年累计YE、AD凭证
      LET l_sql_pr7="SELECT SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END),",
                    "       SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END),",
                    "       SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                    "       SUM(glaq043),SUM(glaq044) ",
                    "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                    " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                    "   AND glap002= ? AND glap004<=? ",
                    "   AND glapstus='S' ",
                    "   AND ",l_wc1,l_sql3
      IF tm.curr_o='Y' THEN
         LET l_sql_pr7=l_sql_pr7," AND glaq005=? "
      END IF
      
      #期間異動：抓取YE、AD傳票金額
      LET l_sql_pr8="SELECT SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END ),",
                    "       SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END ),",
                    "       SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),SUM(glaq043),SUM(glaq044)",
                    "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                    " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                    "   AND glap002 = ",tm.year,
                    "   AND glap004 BETWEEN ",tm.smm," AND ",tm.emm,
                    "   AND glapstus='S' ",
                    "   AND ",l_wc1,l_sql3
      IF tm.curr_o='Y' THEN 
         LET l_sql_pr8=l_sql_pr8," AND glaq005=? "
      END IF
   END IF
   
   #破期本年累計
   LET l_sql_pr4="SELECT SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END),",
                 "       SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END),",
                 "       SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                 "       SUM(glaq043),SUM(glaq044) ",
                 "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                 " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                 "   AND glap002 = ? AND glap004 <= ?",
                 "   AND ",l_wc1,l_sql2,l_sql4
   IF tm.curr_o='Y' THEN
      LET l_sql_pr4=l_sql_pr4," AND glaq005=? "
   END IF
   
   #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
   IF tm.show_ce <> 'Y' THEN
      #期初：抓取CE、XC傳票金額
      LET l_sql_pr6_1="SELECT SUM(CASE WHEN glaq003=0 THEN glaq010*-1 ELSE glaq010 END),",
                      "       SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                      "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                      " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                      "   AND glap002= ? AND glap004<=? ",
                      "   AND ",l_wc1,l_sql4
      IF tm.curr_o='Y' THEN
         LET l_sql_pr6_1=l_sql_pr6_1," AND glaq005=?"
      END IF 
      
      #用于本年累计CE、XC凭证
      LET l_sql_pr7_1="SELECT SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END),",
                      "       SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END),",
                      "       SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                      "       SUM(glaq043),SUM(glaq044) ",
                      "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                      " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                      "   AND glap002= ? AND glap004<=? ",
                      "   AND ",l_wc1,l_sql4
      IF tm.curr_o='Y' THEN
         LET l_sql_pr7_1=l_sql_pr7_1," AND glaq005=? "
      END IF
   
      #期間異動：抓取CE、XC傳票金額
      LET l_sql_pr8_1="SELECT SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END ),",
                      "       SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END ),",
                      "       SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),SUM(glaq043),SUM(glaq044)",
                      "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                      " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                      "   AND glap002 = ",tm.year,
                    "     AND glap004 BETWEEN ",tm.smm," AND ",tm.emm,
                      "   AND ",l_wc1,l_sql4
      IF tm.curr_o='Y' THEN 
         LET l_sql_pr8_1=l_sql_pr8_1," AND glaq005=? "
      END IF
   END IF
   
   #插入临时表
   LET l_sql="INSERT INTO aglq714_tmp ",
             "VALUES(",
             "   ?,?,?,?,?, ?,?,?,?,?,",
             "   ?,?,?,?,?, ?,?,?,?,?,",
             "   ?,?,?,?,?, ?,?,?,?,?,",
             "   ?,?,?,?)"
   PREPARE aglq714_ins_pr FROM l_sql
   
   CALL cl_err_collect_init()
   LET l_success = TRUE
   
IF tm.curr_o <> 'Y' OR
   (tm.curr_o = 'Y' AND tm.show_acc <> 'Y') OR 
   (tm.curr_o = 'Y' AND tm.show_acc = 'Y' AND tm.stus = '1' ) THEN 
                                    #科目     /科目型态    /币别
   FOREACH aglq714_sel_glac_cs INTO l_glac002,l_glac003,l_glar009,
                                    #年初數
                                    l_oyeard,l_oyearc,l_yeard,l_yearc,l_yeard2,l_yearc2,l_yeard3,l_yearc3,
                                    #期初數(借-貸)
                                    l_oqcd,l_qcd,l_qcd2,l_qcd3,
                                    #期間異動
                                    l_oqjd,l_oqjc,l_qjd,l_qjc,l_qjd2,l_qjc2,l_qjd3,l_qjc3,
                                    #本年累計
                                    l_osumd,l_osumc,l_sumd,l_sumc,l_sumd2,l_sumc2,l_sumd3,l_sumc3
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'FOREACH aglq714_sel_glac_cs'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF
      
      #当科目是统治科目时，抓取下层明细科目
      LET l_glaq002 = '' 
      IF l_glac003 = '1' THEN 
         #抓取科目对应的明细科目或者独立科目
         CALL s_voucher_get_glac_str(g_glaa004,l_glac002) RETURNING l_glaq002
      END IF  
      
      IF cl_null(l_glaq002) THEN 
         LET l_glaq002 = "'",l_glac002,"'"
      END IF 
      
      IF tm.show_ce <> 'Y' THEN
         LET l_glac002_str = " AND glac002 IN (",l_glaq002,")"
      END IF
      
      #当该统治科目没有下层明细科目时，抓取该科目本身资料
      IF cl_null(l_glaq002) THEN
         LET l_glaq002 = " AND glaq002='",l_glac002,"'"
      ELSE
         LET l_glaq002 = " AND glaq002 IN (",l_glaq002,")"
      END IF


     IF NOT ( tm.stus='1' ) AND l_glac003='1' THEN 
        LET l_sql=l_sql_pr5,l_glaq002
        PREPARE aglq714_sel_pr5 FROM l_sql
     END IF

      IF l_glac003='1' THEN  
         LET l_sql=l_sql_pr2,l_glaq002  
         PREPARE aglq714_sel_pr2 FROM l_sql 
      END IF 
      
      IF tm.show_ye <> 'Y' OR tm.show_ad <> 'Y' THEN 
         LET l_sql=l_sql_pr6,l_glaq002  
         PREPARE aglq714_sel_pr6 FROM l_sql 
         
         #用于本年累计YE、AD凭证
         LET l_sql=l_sql_pr7,l_glaq002  
         PREPARE aglq714_sel_pr7 FROM l_sql
         
         #期間異動：抓取YE、AD傳票金額
         LET l_sql=l_sql_pr8,l_glaq002
         PREPARE aglq714_sel_pr8 FROM l_sql
      END IF
      
      IF l_glac003='1' THEN  
         LET l_sql=l_sql_pr4,l_glaq002
         PREPARE aglq714_sel_pr4 FROM l_sql
      END IF 
      
      #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
      IF tm.show_ce <> 'Y' THEN
         #期初：抓取CE、XC傳票金額
         LET l_sql=l_sql_pr6_1,l_glaq002, 
                   "   AND (",
                   "        (glap007='CE' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                   "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                   "                                         AND glac007='6' ",l_glac002_str,"))",
                   "         OR ",
                   "        (glap007='XC' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                   "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                   "                                         AND glac010 <> 'N' ",   #排除非费用类科目
                   "                                         AND glac007='5' ",l_glac002_str,
                   "                                     )",
                   "                      AND glapdocno IN (SELECT xcea101 FROM xcea_t ",     
                   "                                             WHERE xceaent=",g_enterprise," AND xceald='",g_glaald,"'",
                   "                                               AND xcea002 = '9' AND xcea101 IS NOT NULL",
                   "                                               AND xcea001>='",l_glav004,"' AND xcea001<='",l_glav004_e,"'",
                   "                                     )",
                   "        )",
                   "       )"
         PREPARE aglq714_sel_pr6_1 FROM l_sql 
         
         #用于本年累计CE、XC凭证
         LET l_sql=l_sql_pr7_1,l_glaq002, 
                   "   AND (",
                   "        (glap007='CE' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                   "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                   "                                         AND glac007='6' ",l_glac002_str,"))",
                   "         OR ",
                   "        (glap007='XC' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                   "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                   "                                         AND glac010 <> 'N' ",   #排除非费用类科目
                   "                                         AND glac007='5' ",l_glac002_str,
                   "                                     )",
                   "                      AND glapdocno IN (SELECT xcea101 FROM xcea_t ",     
                   "                                             WHERE xceaent=",g_enterprise," AND xceald='",g_glaald,"'",
                   "                                               AND xcea002 = '9' AND xcea101 IS NOT NULL", 
                   "                                               AND xcea001>='",l_glav004,"' AND xcea001<='",l_pdate_e2,"'",
                   "                                     )",
                   "        )",
                   "       )"
         PREPARE aglq714_sel_pr7_1 FROM l_sql
      
         #期間異動：抓取CE、XC傳票金額
         LET l_sql=l_sql_pr8_1,l_glaq002, 
                   "   AND (",
                   "        (glap007='CE' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                   "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                   "                                         AND glac007='6' ",l_glac002_str,"))",
                   "         OR ",
                   "        (glap007='XC' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                   "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                   "                                         AND glac010 <> 'N' ",   #排除非费用类科目
                   "                                         AND glac007='5' ",l_glac002_str,
                   "                                     )",
                   "                      AND glapdocno IN (SELECT xcea101 FROM xcea_t ",     
                   "                                             WHERE xceaent=",g_enterprise," AND xceald='",g_glaald,"'",
                   "                                               AND xcea002 = '9' AND xcea101 IS NOT NULL", 
                   "                                               AND xcea001 BETWEEN '",l_pdate_s1,"' AND '",l_pdate_e2,"'",
                   "                                     )",
                   "        )",
                   "       )"
         PREPARE aglq714_sel_pr8_1 FROM l_sql
      END IF
      
      #根據是否勾選顯示原幣抓取值
      IF tm.curr_o<>'Y' THEN
         #期初金額
         LET l_amt1=0
         LET l_amt2=0
         LET l_amt3=0
         LET l_amt4=0
         LET l_amt5=0
         LET l_amt6=0
         LET l_amt7=0
         LET l_amt8=0
         LET l_period=tm.smm-1 #上期
         #當傳狀態為stus=1:已過帳時，抓取匯總glar_t,否則抓取資料來源為glaq_t
         IF tm.stus='1' THEN  
            #匯總上期之前已過帳資料
            LET l_amt1=l_oqcd
            LET l_amt2=l_qcd
            LET l_amt3=l_qcd2
            LET l_amt4=l_qcd3
            
            IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
            IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
            IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
            IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
            #當不包含YE或AD傳票時，減去YE或AD傳票金額
            IF tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN 
               EXECUTE aglq714_sel_pr6 USING tm.year,l_period
                                        INTO l_amt5,l_amt6,l_amt7,l_amt8
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'aglq714_sel_pr6'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
               IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
               IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
               IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
               LET l_amt1=l_amt1-l_amt5
               LET l_amt2=l_amt2-l_amt6
               LET l_amt3=l_amt3-l_amt7
               LET l_amt4=l_amt4-l_amt8
            END IF
         #當為破期時，匯總該年第一天到查詢條件的起始日期tm.sdate的傳票資料
         ELSE
            #抓取年初金額
            LET l_period=0
            EXECUTE aglq714_sel_pr1 USING l_glac002,tm.year,l_period
                                     INTO l_amt1,l_amt2,l_amt3,l_amt4
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'aglq714_sel_pr1'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
            END IF
            #抓取起始年度第一天到起始日期前一天
            #當科目是統治科目時，需要通過下級明細科目抓取金額
            IF l_glac003='1' THEN  #160503-00025#1 add
               EXECUTE aglq714_sel_pr2 USING tm.year,tm.smm
                                        INTO l_amt5,l_amt6,l_amt7,l_amt8
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'aglq714_sel_pr2'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
            ELSE
               LET l_amt5=l_oqcd
               LET l_amt6=l_qcd
               LET l_amt7=l_qcd2
               LET l_amt8=l_qcd3
            END IF

            IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
            IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
            IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
            IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
            IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
            IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
            IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
            IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
            LET l_amt1=l_amt1+l_amt5
            LET l_amt2=l_amt2+l_amt6
            LET l_amt3=l_amt3+l_amt7
            LET l_amt4=l_amt4+l_amt8
         END IF
         
         #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
         IF tm.show_ce <> 'Y' THEN
            LET l_amt5 = 0
            LET l_amt6 = 0
            LET l_amt7 = 0
            LET l_amt8 = 0
            LET l_period=tm.smm-1 #上期 
            EXECUTE aglq714_sel_pr6_1 USING tm.year,l_period
                                       INTO l_amt5,l_amt6,l_amt7,l_amt8
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'aglq714_sel_pr6_1'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
            END IF
            IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
            IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
            IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
            IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
            LET l_amt1=l_amt1-l_amt5
            LET l_amt2=l_amt2-l_amt6
            LET l_amt3=l_amt3-l_amt7
            LET l_amt4=l_amt4-l_amt8
         END IF
         
         IF l_amt2>=0 THEN    
            LET l_oqcd=l_amt1
            LET l_oqcc=0
            LET l_qcd =l_amt2
            LET l_qcc =0
            LET l_qcd2=l_amt3
            LET l_qcc2=0
            LET l_qcd3=l_amt4
            LET l_qcc3=0
         ELSE
            LET l_oqcd=0
            LET l_oqcc=-1*l_amt1
            LET l_qcd =0
            LET l_qcc =-1*l_amt2
            LET l_qcd2=0
            LET l_qcc2=-1*l_amt3
            LET l_qcd3=0
            LET l_qcc3=-1*l_amt4
         END IF
         
         #期間異動
         #当整期间且不跨年查询时
         IF tm.stus = '1' THEN 

         ELSE
            #當科目是統治科目時，需要通過下層明細科目去抓取傳票中的金額
            IF l_glac003 = '1' THEN
               LET l_oqjd = 0
               LET l_oqjc = 0
               LET l_qjd  = 0
               LET l_qjc  = 0
               LET l_qjd2 = 0
               LET l_qjc2 = 0
               LET l_qjd3 = 0
               LET l_qjc3 = 0
               EXECUTE aglq714_sel_pr5 INTO l_oqjd,l_oqjc,l_qjd,l_qjc,l_qjd2,l_qjc2,l_qjd3,l_qjc3
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'aglq714_sel_pr5'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
            END IF
         END IF

         IF cl_null(l_oqjd) THEN LET l_oqjd=0 END IF
         IF cl_null(l_oqjc) THEN LET l_oqjc=0 END IF
         IF cl_null(l_qjd)  THEN LET l_qjd=0  END IF
         IF cl_null(l_qjc)  THEN LET l_qjc=0  END IF
         IF cl_null(l_qjd2) THEN LET l_qjd2=0 END IF
         IF cl_null(l_qjc2) THEN LET l_qjc2=0 END IF
         IF cl_null(l_qjd3) THEN LET l_qjd3=0 END IF
         IF cl_null(l_qjc3) THEN LET l_qjc3=0 END IF
         
         #當不包含YE或AD憑證時，減去YE或AD傳票金額
         IF tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN  
            LET l_amt1=0
            LET l_amt2=0
            LET l_amt3=0
            LET l_amt4=0
            LET l_amt5=0
            LET l_amt6=0
            LET l_amt7=0
            LET l_amt8=0
            EXECUTE aglq714_sel_pr8 INTO l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_amt7,l_amt8
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'aglq714_sel_pr8'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
            END IF
            IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
            IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
            IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
            IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
            IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
            IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
            IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
            IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
            LET l_oqjd=l_oqjd-l_amt1
            LET l_oqjc=l_oqjc-l_amt2
            LET l_qjd =l_qjd -l_amt3
            LET l_qjc =l_qjc -l_amt4
            LET l_qjd2=l_qjd2-l_amt5
            LET l_qjc2=l_qjc2-l_amt6
            LET l_qjd3=l_qjd3-l_amt7
            LET l_qjc3=l_qjc3-l_amt8
         END IF
         
         #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
         IF tm.show_ce <> 'Y' THEN
            LET l_amt1=0
            LET l_amt2=0
            LET l_amt3=0
            LET l_amt4=0
            LET l_amt5=0
            LET l_amt6=0
            LET l_amt7=0
            LET l_amt8=0
            EXECUTE aglq714_sel_pr8_1 INTO l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_amt7,l_amt8
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'aglq714_sel_pr8_1'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
            END IF
            IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
            IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
            IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
            IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
            IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
            IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
            IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
            IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
            LET l_oqjd=l_oqjd-l_amt1
            LET l_oqjc=l_oqjc-l_amt2
            LET l_qjd =l_qjd -l_amt3
            LET l_qjc =l_qjc -l_amt4
            LET l_qjd2=l_qjd2-l_amt5
            LET l_qjc2=l_qjc2-l_amt6
            LET l_qjd3=l_qjd3-l_amt7
            LET l_qjc3=l_qjc3-l_amt8
         END IF
         
         #期末金額=期初+期間
         #原幣
         LET l_amt1=(l_oqcd+l_oqjd)-(l_oqcc+l_oqjc)
         IF l_amt1>=0 THEN    
            LET l_oqmd=l_amt1
            LET l_oqmc=0
         ELSE
            LET l_oqmd=0
            LET l_oqmc=l_amt1*-1
         END IF
         #本幣
         LET l_amt1=(l_qcd+l_qjd)-(l_qcc+l_qjc)
         IF l_amt1>=0 THEN   
            LET l_qmd=l_amt1
            LET l_qmc=0
         ELSE
            LET l_qmd=0
            LET l_qmc=l_amt1*-1
         END IF
         #本幣二
         LET l_amt1=(l_qcd2+l_qjd2)-(l_qcc2+l_qjc2)
         IF l_amt1>=0 THEN    
            LET l_qmd2=l_amt1
            LET l_qmc2=0
         ELSE
            LET l_qmd2=0
            LET l_qmc2=l_amt1*-1
         END IF
         #本幣三
         LET l_amt1=(l_qcd3+l_qjd3)-(l_qcc3+l_qjc3)
         IF l_amt1>=0 THEN    
            LET l_qmd3=l_amt1
            LET l_qmc3=0
         ELSE
            LET l_qmd3=0
            LET l_qmc3=l_amt1*-1
         END IF  

         #本年累計金額
         LET l_amt1 = 0
         LET l_amt2 = 0
         LET l_amt3 = 0
         LET l_amt4 = 0
         LET l_amt5 = 0
         LET l_amt6 = 0
         LET l_amt7 = 0
         LET l_amt8 = 0

         #當傳票狀態為1：已過帳時，抓取glar_t餘額當資料,否則，直接抓取glaq_t傳票資料
         IF tm.stus='1' THEN
            IF cl_null(l_osumd) THEN LET l_osumd=0 END IF
            IF cl_null(l_osumc) THEN LET l_osumc=0 END IF
            IF cl_null(l_sumd)  THEN LET l_sumd=0  END IF
            IF cl_null(l_sumc)  THEN LET l_sumc=0  END IF
            IF cl_null(l_sumd2) THEN LET l_sumd2=0 END IF
            IF cl_null(l_sumc2) THEN LET l_sumc2=0 END IF
            IF cl_null(l_sumd3) THEN LET l_sumd3=0 END IF
            IF cl_null(l_sumc3) THEN LET l_sumc3=0 END IF
            #當不包含YE或AD傳票時，減去YE或AD傳票金額
            IF tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN  
               EXECUTE aglq714_sel_pr7 USING tm.year,tm.emm
                                        INTO l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_amt7,l_amt8                                       
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'aglq714_sel_pr7'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_amt1)  THEN LET l_amt1=0 END IF
               IF cl_null(l_amt2)  THEN LET l_amt2=0 END IF
               IF cl_null(l_amt3)  THEN LET l_amt3=0 END IF
               IF cl_null(l_amt4)  THEN LET l_amt4=0 END IF
               IF cl_null(l_amt5)  THEN LET l_amt5=0 END IF
               IF cl_null(l_amt6)  THEN LET l_amt6=0 END IF
               IF cl_null(l_amt7)  THEN LET l_amt7=0 END IF
               IF cl_null(l_amt8)  THEN LET l_amt8=0 END IF
               LET l_osumd=l_osumd-l_amt1
               LET l_osumc=l_osumc-l_amt2
               LET l_sumd =l_sumd -l_amt3
               LET l_sumc =l_sumc -l_amt4
               LET l_sumd2=l_sumd2-l_amt5
               LET l_sumc2=l_sumc2-l_amt6
               LET l_sumd3=l_sumd3-l_amt7
               LET l_sumc3=l_sumc3-l_amt8 
            END IF
         ELSE
            #當科目為統治科目，需要通過下層明細科目抓取傳票中的金額
            IF l_glac003 = '1' THEN
               LET l_osumd = 0
               LET l_osumc = 0
               LET l_sumd  = 0
               LET l_sumc  = 0
               LET l_sumd2 = 0
               LET l_sumc2 = 0
               LET l_sumd3 = 0
               LET l_sumc3 = 0
               #所有傳票匯總
               EXECUTE aglq714_sel_pr4 USING tm.year,tm.emm
                                        INTO l_osumd,l_osumc,l_sumd,l_sumc,l_sumd2,l_sumc2,l_sumd3,l_sumc3 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'aglq714_sel_pr4'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
            END IF
            IF cl_null(l_osumd) THEN LET l_osumd=0 END IF
            IF cl_null(l_osumc) THEN LET l_osumc=0 END IF
            IF cl_null(l_sumd)  THEN LET l_sumd=0  END IF
            IF cl_null(l_sumc)  THEN LET l_sumc=0  END IF
            IF cl_null(l_sumd2) THEN LET l_sumd2=0 END IF
            IF cl_null(l_sumc2) THEN LET l_sumc2=0 END IF
            IF cl_null(l_sumd3) THEN LET l_sumd3=0 END IF
            IF cl_null(l_sumc3) THEN LET l_sumc3=0 END IF
            IF cl_null(l_amt1)  THEN LET l_amt1=0 END IF
            IF cl_null(l_amt2)  THEN LET l_amt2=0 END IF
            IF cl_null(l_amt3)  THEN LET l_amt3=0 END IF
            IF cl_null(l_amt4)  THEN LET l_amt4=0 END IF
            IF cl_null(l_amt5)  THEN LET l_amt5=0 END IF
            IF cl_null(l_amt6)  THEN LET l_amt6=0 END IF
            IF cl_null(l_amt7)  THEN LET l_amt7=0 END IF
            IF cl_null(l_amt8)  THEN LET l_amt8=0 END IF
            LET l_osumd=l_osumd+l_amt1
            LET l_osumc=l_osumc+l_amt2
            LET l_sumd =l_sumd +l_amt3
            LET l_sumc =l_sumc +l_amt4
            LET l_sumd2=l_sumd2+l_amt5
            LET l_sumc2=l_sumc2+l_amt6
            LET l_sumd3=l_sumd3+l_amt7
            LET l_sumc3=l_sumc3+l_amt8            
         END IF 
         
         #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
         IF tm.show_ce <> 'Y' THEN
            LET l_amt1 = 0
            LET l_amt2 = 0
            LET l_amt3 = 0
            LET l_amt4 = 0
            LET l_amt5 = 0
            LET l_amt6 = 0
            LET l_amt7 = 0
            LET l_amt8 = 0
            EXECUTE aglq714_sel_pr7_1 USING tm.year,tm.emm
                                        INTO l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_amt7,l_amt8                                       
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'aglq714_sel_pr7_1'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_amt1)  THEN LET l_amt1=0 END IF
               IF cl_null(l_amt2)  THEN LET l_amt2=0 END IF
               IF cl_null(l_amt3)  THEN LET l_amt3=0 END IF
               IF cl_null(l_amt4)  THEN LET l_amt4=0 END IF
               IF cl_null(l_amt5)  THEN LET l_amt5=0 END IF
               IF cl_null(l_amt6)  THEN LET l_amt6=0 END IF
               IF cl_null(l_amt7)  THEN LET l_amt7=0 END IF
               IF cl_null(l_amt8)  THEN LET l_amt8=0 END IF
               LET l_osumd=l_osumd-l_amt1
               LET l_osumc=l_osumc-l_amt2
               LET l_sumd =l_sumd -l_amt3
               LET l_sumc =l_sumc -l_amt4
               LET l_sumd2=l_sumd2-l_amt5
               LET l_sumc2=l_sumc2-l_amt6
               LET l_sumd3=l_sumd3-l_amt7
               LET l_sumc3=l_sumc3-l_amt8 
         END IF
         
         IF l_yeard=0 AND l_yearc=0 AND  #年初數
            l_qcd=0 AND l_qcc=0 AND      #期初數
            l_qjd=0 AND l_qjc=0 AND      #期間異動
            l_qmd=0 AND l_qmc=0 AND      #期末
            l_sumd=0 AND l_sumc=0 THEN   #本年累計，以上全部等於0時該筆科目資料不顯示
            CONTINUE FOREACH
         END IF
         

         #期间
         LET l_oqj = l_oqjd - l_oqjc
         LET l_qj  = l_qjd  - l_qjc
         LET l_qj2 = l_qjd2 - l_qjc2
         LET l_qj3 = l_qjd3 - l_qjc3 

         #本年合计
         LET l_obsum = l_osumd - l_osumc
         LET l_bsum  = l_sumd  - l_sumc
         LET l_bsum2 = l_sumd2 - l_sumc2
         LET l_bsum3 = l_sumd3 - l_sumc3

         EXECUTE aglq714_ins_pr USING l_glac002,l_glar009,
                l_oyeard,l_oyearc,l_yeard,l_yearc,l_yeard2,l_yearc2,l_yeard3,l_yearc3,
                l_oqcd,l_oqcc,l_qcd,l_qcc,l_qcd2,l_qcc2,l_qcd3,l_qcc3,
                l_oqj,l_qj,l_qj2,l_qj3,
                l_oqmd,l_oqmc,l_qmd,l_qmc,l_qmd2,l_qmc2,l_qmd3,l_qmc3,
                l_obsum,l_bsum,l_bsum2,l_bsum3
     
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'insert'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
      ELSE
            #期初金額
            LET l_amt1=0
            LET l_amt2=0
            LET l_amt3=0
            LET l_amt4=0
            LET l_amt5=0
            LET l_amt6=0
            LET l_amt7=0
            LET l_amt8=0
            LET l_period=tm.smm-1 #上期
            IF tm.stus='1' THEN
               LET l_amt1=l_oqcd
               LET l_amt2=l_qcd
               LET l_amt3=l_qcd2
               LET l_amt4=l_qcd3
               IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
               IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
               IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
               IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
               #當不包含YE或AD傳票時，減去YE或AD傳票金額
               IF tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN   
                  EXECUTE aglq714_sel_pr6 USING tm.year,l_period,l_glar009
                                           INTO l_amt5,l_amt6,l_amt7,l_amt8
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'aglq714_sel_pr6'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET l_success = FALSE
                  END IF
                  IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
                  IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
                  IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
                  IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
                  LET l_amt1=l_amt1-l_amt5
                  LET l_amt2=l_amt2-l_amt6
                  LET l_amt3=l_amt3-l_amt7
                  LET l_amt4=l_amt4-l_amt8
               END IF
            #當為破期時，匯總該年第一天到上期最後一天的傳票資料
            ELSE
               #年初數
               LET l_period=0
               EXECUTE aglq714_sel_pr1 USING l_glac002,tm.year,l_period,l_glar009
                                        INTO l_amt1,l_amt2,l_amt3,l_amt4
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'aglq714_sel_pr1'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
               IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
               IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
               IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
               
               #當科目是統治科目時，需要通過下級明細科目抓取金額
               IF l_glac003='1' THEN  
                  #匯總該年第一天到起始日期前一天的傳票資料
                  EXECUTE aglq714_sel_pr2 USING tm.year,tm.smm,l_glar009
                                           INTO l_amt5,l_amt6,l_amt7,l_amt8
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'aglq714_sel_pr2'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET l_success = FALSE
                  END IF
               ELSE
                   LET l_amt5=l_oqcd
                   LET l_amt6=l_qcd
                   LET l_amt7=l_qcd2
                   LET l_amt8=l_qcd3
               END IF
               IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
               IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
               IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
               IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
               LET l_amt1=l_amt1+l_amt5
               LET l_amt2=l_amt2+l_amt6
               LET l_amt3=l_amt3+l_amt7
               LET l_amt4=l_amt4+l_amt8
            END IF
            
            #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
            IF tm.show_ce <> 'Y' THEN
               LET l_amt5=0
               LET l_amt6=0
               LET l_amt7=0
               LET l_amt8=0
               LET l_period=tm.smm-1 #上期 
               EXECUTE aglq714_sel_pr6_1 USING tm.year,l_period,l_glar009
                                           INTO l_amt5,l_amt6,l_amt7,l_amt8
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'aglq714_sel_pr6_1'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET l_success = FALSE
                  END IF
                  IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
                  IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
                  IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
                  IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
                  LET l_amt1=l_amt1-l_amt5
                  LET l_amt2=l_amt2-l_amt6
                  LET l_amt3=l_amt3-l_amt7
                  LET l_amt4=l_amt4-l_amt8
            END IF
            
            IF l_amt2>=0 THEN    
               LET l_oqcd=l_amt1
               LET l_oqcc=0
               LET l_qcd =l_amt2
               LET l_qcc =0
               LET l_qcd2=l_amt3
               LET l_qcc2=0
               LET l_qcd3=l_amt4
               LET l_qcc3=0
            ELSE
               LET l_oqcd=0
               LET l_oqcc=-1*l_amt1
               LET l_qcd =0
               LET l_qcc =-1*l_amt2
               LET l_qcd2=0
               LET l_qcc2=-1*l_amt3
               LET l_qcd3=0
               LET l_qcc3=-1*l_amt4
            END IF 
         
            #期間異動
            #当整期间且不跨年查询时
            IF tm.stus='1' THEN 

            ELSE
               #當科目是統治科目時，需要通過下層明細科目去抓取傳票中的金額
               IF l_glac003 = '1' THEN
                  LET l_oqjd = 0
                  LET l_oqjc = 0
                  LET l_qjd  = 0
                  LET l_qjc  = 0
                  LET l_qjd2 = 0
                  LET l_qjc2 = 0
                  LET l_qjd3 = 0
                  LET l_qjc3 = 0
                  EXECUTE aglq714_sel_pr5 USING l_glar009
                                           INTO l_oqjd,l_oqjc,l_qjd,l_qjc,l_qjd2,l_qjc2,l_qjd3,l_qjc3
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'aglq714_sel_pr1'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET l_success = FALSE
                  END IF
               END IF
            END IF

            IF cl_null(l_oqjd) THEN LET l_oqjd=0 END IF
            IF cl_null(l_oqjc) THEN LET l_oqjc=0 END IF
            IF cl_null(l_qjd)  THEN LET l_qjd=0  END IF
            IF cl_null(l_qjc)  THEN LET l_qjc=0  END IF
            IF cl_null(l_qjd2) THEN LET l_qjd2=0 END IF
            IF cl_null(l_qjc2) THEN LET l_qjc2=0 END IF
            IF cl_null(l_qjd3) THEN LET l_qjd3=0 END IF
            IF cl_null(l_qjc3) THEN LET l_qjc3=0 END IF
            
            #当整期间且不跨年查询时，當不包含YE或AD傳票時，減去YE或AD傳票金額
            IF tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN 
               EXECUTE aglq714_sel_pr8 USING l_glar009
                                        INTO l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_amt7,l_amt8
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'aglq714_sel_pr8'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
               IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
               IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
               IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
               IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
               IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
               IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
               IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
               LET l_oqjd=l_oqjd-l_amt1
               LET l_oqjc=l_oqjc-l_amt2
               LET l_qjd =l_qjd -l_amt3
               LET l_qjc =l_qjc -l_amt4
               LET l_qjd2=l_qjd2-l_amt5
               LET l_qjc2=l_qjc2-l_amt6
               LET l_qjd3=l_qjd3-l_amt7
               LET l_qjc3=l_qjc3-l_amt8
            END IF
            
            #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
            IF tm.show_ce <> 'Y' THEN
               LET l_amt1=0
               LET l_amt2=0
               LET l_amt3=0
               LET l_amt4=0
               LET l_amt5=0
               LET l_amt6=0
               LET l_amt7=0
               LET l_amt8=0
               EXECUTE aglq714_sel_pr8_1 USING l_glar009
                                        INTO l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_amt7,l_amt8
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'aglq714_sel_pr8_1'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
               IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
               IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
               IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
               IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
               IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
               IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
               IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
               LET l_oqjd=l_oqjd-l_amt1
               LET l_oqjc=l_oqjc-l_amt2
               LET l_qjd =l_qjd -l_amt3
               LET l_qjc =l_qjc -l_amt4
               LET l_qjd2=l_qjd2-l_amt5
               LET l_qjc2=l_qjc2-l_amt6
               LET l_qjd3=l_qjd3-l_amt7
               LET l_qjc3=l_qjc3-l_amt8
            END IF
            
            #期末金額=期初+期間
            #原幣
            LET l_amt1=(l_oqcd+l_oqjd)-(l_oqcc+l_oqjc)
            IF l_amt1>=0 THEN     
               LET l_oqmd=l_amt1
               LET l_oqmc=0
            ELSE
               LET l_oqmd=0
               LET l_oqmc=l_amt1*-1
            END IF
            #本幣
            LET l_amt1=(l_qcd+l_qjd)-(l_qcc+l_qjc)
            IF l_amt1>=0 THEN    
               LET l_qmd=l_amt1
               LET l_qmc=0
            ELSE
               LET l_qmd=0
               LET l_qmc=l_amt1*-1
            END IF
            #本幣二
            LET l_amt1=(l_qcd2+l_qjd2)-(l_qcc2+l_qjc2)
            IF l_amt1>=0 THEN     
               LET l_qmd2=l_amt1
               LET l_qmc2=0
            ELSE
               LET l_qmd2=0
               LET l_qmc2=l_amt1*-1
            END IF
            #本幣三
            LET l_amt1=(l_qcd3+l_qjd3)-(l_qcc3+l_qjc3)
            IF l_amt1>=0 THEN    
               LET l_qmd3=l_amt1
               LET l_qmc3=0
            ELSE
               LET l_qmd3=0
               LET l_qmc3=l_amt1*-1
            END IF  

            #本年累計金額
            LET l_amt1 = 0
            LET l_amt2 = 0
            LET l_amt3 = 0
            LET l_amt4 = 0
            LET l_amt5 = 0
            LET l_amt6 = 0
            LET l_amt7 = 0
            LET l_amt8 = 0

            #當傳票狀態為1：已過帳時，抓取glar_t餘額當資料,否則，直接抓取glaq_t傳票資料
            IF tm.stus='1' THEN
               IF cl_null(l_osumd) THEN LET l_osumd=0 END IF
               IF cl_null(l_osumc) THEN LET l_osumc=0 END IF
               IF cl_null(l_sumd)  THEN LET l_sumd=0  END IF
               IF cl_null(l_sumc)  THEN LET l_sumc=0  END IF
               IF cl_null(l_sumd2) THEN LET l_sumd2=0 END IF
               IF cl_null(l_sumc2) THEN LET l_sumc2=0 END IF
               IF cl_null(l_sumd3) THEN LET l_sumd3=0 END IF
               IF cl_null(l_sumc3) THEN LET l_sumc3=0 END IF
               #當不包含YE或AD傳票時，減去YE或AD傳票金額
               IF tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN 
                  EXECUTE aglq714_sel_pr7 USING tm.year,tm.emm,l_glar009
                                           INTO l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_amt7,l_amt8                                       
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'aglq714_sel_pr7'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET l_success = FALSE
                  END IF
                  IF cl_null(l_amt1)  THEN LET l_amt1=0 END IF
                  IF cl_null(l_amt2)  THEN LET l_amt2=0 END IF
                  IF cl_null(l_amt3)  THEN LET l_amt3=0 END IF
                  IF cl_null(l_amt4)  THEN LET l_amt4=0 END IF
                  IF cl_null(l_amt5)  THEN LET l_amt5=0 END IF
                  IF cl_null(l_amt6)  THEN LET l_amt6=0 END IF
                  IF cl_null(l_amt7)  THEN LET l_amt7=0 END IF
                  IF cl_null(l_amt8)  THEN LET l_amt8=0 END IF
                  LET l_osumd=l_osumd-l_amt1
                  LET l_osumc=l_osumc-l_amt2
                  LET l_sumd =l_sumd -l_amt3
                  LET l_sumc =l_sumc -l_amt4
                  LET l_sumd2=l_sumd2-l_amt5
                  LET l_sumc2=l_sumc2-l_amt6
                  LET l_sumd3=l_sumd3-l_amt7
                  LET l_sumc3=l_sumc3-l_amt8 
               END IF
            ELSE
               #年初數
               #當科目為統治科目，需要通過下層明細科目抓取傳票中的金額
               IF l_glac003 = '1' THEN
                  LET l_osumd = 0
                  LET l_osumc = 0
                  LET l_sumd  = 0
                  LET l_sumc  = 0
                  LET l_sumd2 = 0
                  LET l_sumc2 = 0
                  LET l_sumd3 = 0
                  LET l_sumc3 = 0
                  #匯總該年第一天到查詢條件截止日期的傳票資料
                  EXECUTE aglq714_sel_pr4 USING tm.year,tm.emm,l_glar009
                                           INTO l_osumd,l_osumc,l_sumd,l_sumc,l_sumd2,l_sumc2,l_sumd3,l_sumc3 
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'aglq714_sel_pr4'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET l_success = FALSE
                  END IF
               END IF  
               IF cl_null(l_osumd) THEN LET l_osumd=0 END IF
               IF cl_null(l_osumc) THEN LET l_osumc=0 END IF
               IF cl_null(l_sumd)  THEN LET l_sumd=0  END IF
               IF cl_null(l_sumc)  THEN LET l_sumc=0  END IF
               IF cl_null(l_sumd2) THEN LET l_sumd2=0 END IF
               IF cl_null(l_sumc2) THEN LET l_sumc2=0 END IF
               IF cl_null(l_sumd3) THEN LET l_sumd3=0 END IF
               IF cl_null(l_sumc3) THEN LET l_sumc3=0 END IF
            END IF 
            
            #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
            IF tm.show_ce <> 'Y' THEN
                LET l_amt1=0
                LET l_amt2=0
                LET l_amt3=0
                LET l_amt4=0
                LET l_amt5=0
                LET l_amt6=0
                LET l_amt7=0
                LET l_amt8=0
               EXECUTE aglq714_sel_pr7_1 USING tm.year,tm.emm,l_glar009
                                        INTO l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_amt7,l_amt8                                       
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'aglq714_sel_pr7_1'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_amt1)  THEN LET l_amt1=0 END IF
               IF cl_null(l_amt2)  THEN LET l_amt2=0 END IF
               IF cl_null(l_amt3)  THEN LET l_amt3=0 END IF
               IF cl_null(l_amt4)  THEN LET l_amt4=0 END IF
               IF cl_null(l_amt5)  THEN LET l_amt5=0 END IF
               IF cl_null(l_amt6)  THEN LET l_amt6=0 END IF
               IF cl_null(l_amt7)  THEN LET l_amt7=0 END IF
               IF cl_null(l_amt8)  THEN LET l_amt8=0 END IF
               LET l_osumd=l_osumd-l_amt1
               LET l_osumc=l_osumc-l_amt2
               LET l_sumd =l_sumd -l_amt3
               LET l_sumc =l_sumc -l_amt4
               LET l_sumd2=l_sumd2-l_amt5
               LET l_sumc2=l_sumc2-l_amt6
               LET l_sumd3=l_sumd3-l_amt7
               LET l_sumc3=l_sumc3-l_amt8 
            END IF
            
            IF l_yeard=0 AND l_yearc=0 AND  #年初數
               l_qcd=0 AND l_qcc=0 AND      #期初數
               l_qjd=0 AND l_qjc=0 AND      #期間異動
               l_qmd=0 AND l_qmc=0 AND      #期末
               l_sumd=0 AND l_sumc=0 THEN   #本年累計，以上全部等於0時該筆科目資料不顯示
               CONTINUE FOREACH
            END IF
            
            #期间
            LET l_oqj = l_oqjd - l_oqjc
            LET l_qj  = l_qjd  - l_qjc
            LET l_qj2 = l_qjd2 - l_qjc2
            LET l_qj3 = l_qjd3 - l_qjc3 
            
            #本年合计
            LET l_obsum = l_osumd - l_osumc
            LET l_bsum  = l_sumd  - l_sumc
            LET l_bsum2 = l_sumd2 - l_sumc2
            LET l_bsum3 = l_sumd3 - l_sumc3

            EXECUTE aglq714_ins_pr USING l_glac002,l_glar009,
                   l_oyeard,l_oyearc,l_yeard,l_yearc,l_yeard2,l_yearc2,l_yeard3,l_yearc3,
                   l_oqcd,l_oqcc,l_qcd,l_qcc,l_qcd2,l_qcc2,l_qcd3,l_qcc3,
                   l_oqj,l_qj,l_qj2,l_qj3,
                   l_oqmd,l_oqmc,l_qmd,l_qmc,l_qmd2,l_qmc2,l_qmd3,l_qmc3,
                   l_obsum,l_bsum,l_bsum2,l_bsum3
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'insert'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
            END IF
      END IF
   END FOREACH
ELSE
   #抓取科目+币别
      #当传票状态为已过正时抓取glar_t资料，反之抓取glaq_t资料
      
      IF tm.stus = '1' THEN
         LET l_sql_t01="SELECT DISTINCT glar009 ",
                       "  FROM glac_t,glar_t ",
                       " WHERE glacent=glarent AND glac002=glar001",
                       "   AND glacent=",g_enterprise,
                       "   AND glac001='",g_glaa004,"'",
                       "   AND glacstus='Y'",
                       "   AND glarld='",g_glaald,"' "

         LET l_sql_t01=l_sql_t01,
                       " AND glar002=",tm.year,
                       " AND glar003<=",tm.emm
         LET l_sql_t01=l_sql_t01,
                       " AND ",g_wc1
      ELSE 
         LET l_sql_t01=
                   "SELECT DISTINCT glar009 ",
                   "  FROM (",
                   "        SELECT glaq005 glar009 ",
                   "          FROM glac_t,",
                   "               glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                   "         WHERE glacent=glaqent AND glac002=glaq002",
                   "           AND glacent=",g_enterprise,
                   "           AND glac001='",g_glaa004,"'",
                   "           AND glacstus='Y'",
                   "           AND glaqld='",g_glaald,"' ",
                   "           AND glap002 = ",tm.year,
                   "           AND glap004 <= ",tm.smm,
                   "           AND ",l_wc1,l_sql2,l_sql4
                   
         LET l_sql_t02=" UNION ",
                       " SELECT glar009 ",
                       "   FROM glac_t,glar_t ",
                       "  WHERE glacent=glarent AND glac002=glar001",
                       "    AND glacent=",g_enterprise,
                       "    AND glac001='",g_glaa004,"'",
                       "    AND glacstus='Y'",
                       "    AND glarld='",g_glaald,"' ",
                       "    AND glar002 = ",tm.year,
                       "    AND glar003=0 ",
                       "    AND ",g_wc1
      END IF
      
      #年初數
      IF tm.show_y='Y' THEN
                       #         原幣借-貸            /本幣借-貸
         LET l_sql_nch="  SELECT SUM(glar010-glar011),SUM(glar005-glar006),",
                       #         本幣二借-貸          /本幣三借-貸
                       "         SUM(glar034-glar035),SUM(glar036-glar037) ",
                       "    FROM glar_t",    
                       "   WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
                       "     AND glar002=",tm.year," AND glar003=0 AND glar009=?"
      END IF
   
      #期初
      #當傳票狀態是已過帳時抓取餘額當glar_t資料，否則抓取傳票當glaq_t資料
      IF tm.stus='1' THEN 
         LET l_period=tm.smm-1 #上期
                       #        原幣借-貸            /本幣借-貸
         LET l_sql_qch=" SELECT SUM(glar010-glar011),SUM(glar005-glar006),",
                       #        本幣二借-貸          /本幣三借-貸
                       "        SUM(glar034-glar035),SUM(glar036-glar037) ",
                       "   FROM glar_t",    
                       "  WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
                       "    AND glar002=",tm.year," AND glar003<=",l_period,
                       "    AND glar009=? "
      ELSE
                       #        原幣借-貸
          LET l_sql_qch=" SELECT SUM(CASE WHEN glaq003=0 THEN glaq010*-1 ELSE glaq010 END),",
                       #        本幣借-貸            /本幣二借-貸          /本幣三借-貸
                       "        SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044)",
                       "   FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                       "  WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                       "    AND glap002 = ",tm.year,
                       "    AND glap004 < ",tm.smm,
                       "    AND glaq005=? AND ",l_wc1,l_sql2,l_sql4
      END IF
   
      #期間異動
      #当傳票狀態是已過帳时，抓取餘額當glar_t資料，否則抓取傳票當glaq_t資料
      IF tm.stus='1' THEN
                      #        原幣借方金額  /原幣貸方金額 
         LET l_sql_qj=" SELECT SUM(glar010),SUM(glar011),",
                      #        本幣借方金額  /本幣貸方金額
                      "        SUM(glar005), SUM(glar006)",
                      #        本幣二借方金額 /本幣二貸方金額 /本幣三借方金額 /本幣三貸方金額
                      "        SUM(glar034), SUM(glar035), SUM(glar036), SUM(glar037)",
                      "   FROM glar_t",
                      "  WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"'",
                      "    AND glar002=",tm.year,
                      "    AND glar003 BETWEEN ",tm.smm," AND ",tm.emm,
                      "    AND glar009=? AND ",g_wc1
      ELSE
                      #        原幣借方金額
         LET l_sql_qj=" SELECT SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END ),",
                      #        原幣貸方金額
                      "        SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END ),",
                      #        本幣借方金額  /本幣貸方金額/本幣二借方金額/本幣二貸方金額 
                      "        SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                      #        本幣三借方金額/本幣三貸方金額
                      "        SUM(glaq043),SUM(glaq044)",
                      "   FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                      "  WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                      "    AND glap002 = ",tm.year,
                      "    AND glap004 BETWEEN ",tm.smm," AND ",tm.emm,
                      "    AND glaq005=? AND ",l_wc1,l_sql2,l_sql4
      END IF
   
      #本年累計
      #當傳票狀態為1：已過帳時，抓取glar_t餘額當資料,否則，直接抓取glaq_t傳票資料
      IF tm.stus='1' THEN
                      #        原幣借方金額  /原幣貸方金額 /本幣借方金額 /本幣貸方金額
         LET l_sql_lj=" SELECT SUM(glar010),SUM(glar011),SUM(glar005),SUM(glar006),",
                      #        本幣二借方金額/本幣二貸方金額/本幣三借方金額/本幣三貸方金額
                      "        SUM(glar034),SUM(glar035),SUM(glar036),SUM(glar037)",
                      "   FROM glar_t",    
                      "  WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
                      "    AND glar002=",tm.year," AND glar003<= ",tm.emm,
                      "    AND glar003<>0 ", 
                      "    AND glar009=? "
      ELSE
                      #        原幣借方金額
          LET l_sql_lj=" SELECT SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END),",
                      #        原幣貸方金額
                      "        SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END),",
                      #        本幣借方金額  /本幣貸方金額 /本幣二借方金額/本幣二貸方金額
                      "        SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                      #        本幣三借方金額/本幣三貸方金額
                      "        SUM(glaq043),SUM(glaq044)",
                      "   FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                      "  WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                      "    AND glap002 = ",tm.year,
                      "    AND glap004 <= ",tm.emm,
                      "    AND glaq005=? AND ",l_wc1,l_sql2,l_sql4
      END IF
   

      FOREACH aglq714_sel_glac_cs INTO l_glac002,l_glac003 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'FOREACH aglq714_sel_glac_cs'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH
         END IF
      
         #当科目是统治科目时，抓取下层明细科目
         LET l_glaq002 = '' 
         IF l_glac003 = '1' THEN 
            #抓取科目对应的明细科目或者独立科目
            CALL s_voucher_get_glac_str(g_glaa004,l_glac002) RETURNING l_glaq002
         END IF 

         IF cl_null(l_glaq002) THEN 
            LET l_glaq002 = "'",l_glac002,"'"
         END IF 
      
         IF tm.show_ce <> 'Y' THEN
            LET l_glac002_str = " AND glac002 IN (",l_glaq002,")"
         END IF
         
         #当该统治科目没有下层明细科目时，抓取该科目本身资料
         IF cl_null(l_glaq002) THEN
            LET l_glaq002 = " AND glaq002='",l_glac002,"'"
         ELSE
            LET l_glaq002 = " AND glaq002 IN (",l_glaq002,")"
         END IF
      
         #抓取科目+币别
         #当整期间且传票状态为已过正时抓取glar_t资料，反之抓取glaq_t资料
         IF tm.stus = '1' THEN
            LET g_sql=l_sql_t01,
                      " AND glar001 = '",l_glac002,"'"
         ELSE 
            LET g_sql=l_sql_t01,
                      l_glaq002,
                      l_sql_t02,
                      " AND glar001 = '",l_glac002,"'",
                      " )"
         END IF
         PREPARE aglq714_sel_pr_3 FROM g_sql
         DECLARE aglq714_sel_cr_3 CURSOR FOR aglq714_sel_pr_3
      
         #抓取栏位
         #年初數
         IF tm.show_y='Y' THEN 
            LET l_sql=l_sql_nch,
                      " AND glar001 = '",l_glac002,"'"
            PREPARE aglq714_sum_pr_nch FROM l_sql
         END IF
   
         #期初
         #當傳票狀態是已過帳時抓取餘額當glar_t資料，否則抓取傳票當glaq_t資料
         IF tm.stus='1' THEN
            LET l_sql=l_sql_qch,
                      " AND glar001 = '",l_glac002,"'"
         ELSE
            LET l_sql=l_sql_qch,
                      l_glaq002
         END IF
         PREPARE aglq714_sum_pr_qch FROM l_sql
   
         #期間異動
         #当傳票狀態是已過帳时，抓取餘額當glar_t資料，否則抓取傳票當glaq_t資料
         IF tm.stus='1' THEN
            LET l_sql=l_sql_qj,
                      " AND glar001 = '",l_glac002,"'"
         ELSE
            LET l_sql=l_sql_qj,
                      l_glaq002
         END IF
         PREPARE aglq714_sum_pr_qj FROM l_sql
   
         #本年累計
         #當傳票狀態為1：已過帳時，抓取glar_t餘額當資料,否則，直接抓取glaq_t傳票資料
         IF tm.stus='1' THEN
            LET l_sql=l_sql_lj,
                      " AND glar001 = '",l_glac002,"'"
         ELSE
            LET l_sql=l_sql_lj,
                      l_glaq002
         END IF
         PREPARE aglq714_sum_pr_lj FROM l_sql

         IF tm.show_ye <> 'Y' OR tm.show_ad <> 'Y' THEN 
            LET l_sql=l_sql_pr6,l_glaq002  
            PREPARE aglq714_sel_pr6_3 FROM l_sql 
            
            #用于本年累计YE、AD凭证
            LET l_sql=l_sql_pr7,l_glaq002 
            PREPARE aglq714_sel_pr7_3 FROM l_sql
            
            #期間異動：抓取YE、AD傳票金額
            LET l_sql=l_sql_pr8,l_glaq002
            PREPARE aglq714_sel_pr8_3 FROM l_sql
         END IF
      
         #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
         IF tm.show_ce <> 'Y' THEN
            #期初：抓取CE、XC傳票金額
            LET l_sql=l_sql_pr6_1,l_glaq002, 
                      "   AND (",
                      "        (glap007='CE' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                      "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                      "                                         AND glac007='6' ",l_glac002_str,"))",
                      "         OR ",
                      "        (glap007='XC' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                      "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                      "                                         AND glac010 <> 'N' ",  
                      "                                         AND glac007='5' ",l_glac002_str,
                      "                                     )",
                      "                      AND glapdocno IN (SELECT xcea101 FROM xcea_t ",    
                      "                                             WHERE xceaent=",g_enterprise," AND xceald='",g_glaald,"'",
                      "                                               AND xcea002 = '9' AND xcea101 IS NOT NULL", 
                      "                                               AND xcea001>='",l_glav004,"' AND xcea001<'",l_glav004_e,"'",
                      "                                     )",
                      "        )",
                      "       )"
            PREPARE aglq714_sel_pr6_4 FROM l_sql 
            
            #用于本年累计CE、XC凭证
            LET l_sql=l_sql_pr7_1,l_glaq002, 
                      "   AND (",
                      "        (glap007='CE' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                      "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                      "                                         AND glac007='6' ",l_glac002_str,"))",
                      "         OR ",
                      "        (glap007='XC' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                      "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                      "                                         AND glac010 <> 'N' ",  
                      "                                         AND glac007='5' ",l_glac002_str,
                      "                                     )",
                      "                      AND glapdocno IN (SELECT xcea101 FROM xcea_t ",     
                      "                                             WHERE xceaent=",g_enterprise," AND xceald='",g_glaald,"'",
                      "                                               AND xcea002 = '9' AND xcea101 IS NOT NULL", 
                      "                                               AND xcea001>='",l_glav004,"' AND xcea001<='",l_pdate_e2,"'",
                      "                                     )",
                      "        )",
                      "       )"
         
            PREPARE aglq714_sel_pr7_4 FROM l_sql
         
            #期間異動：抓取CE、XC傳票金額
            LET l_sql=l_sql_pr8_1,l_glaq002, 
                      "   AND (",
                      "        (glap007='CE' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                      "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                      "                                         AND glac007='6' ",l_glac002_str,"))",
                      "         OR ",
                      "        (glap007='XC' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                      "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                      "                                         AND glac010 <> 'N' ",  
                      "                                         AND glac007='5' ",l_glac002_str,
                      "                                     )",
                      "                      AND glapdocno IN (SELECT xcea101 FROM xcea_t ",      
                      "                                             WHERE xceaent=",g_enterprise," AND xceald='",g_glaald,"'",
                      "                                               AND xcea002 = '9' AND xcea101 IS NOT NULL", 
                      "                                               AND xcea001 BETWEEN '",l_pdate_s1,"' AND '",l_pdate_e2,"'",
                      "                                     )",
                      "        )",
                      "       )"
         
            PREPARE aglq714_sel_pr8_4 FROM l_sql
         END IF
      
         #按照幣別抓取科目餘額
         FOREACH aglq714_sel_cr_3 INTO l_glar009
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'FOREACH aglq714_sel_cr_3'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET l_success = FALSE
                  EXIT FOREACH
               END IF
               #年初數
               LET l_oyeard = 0  LET l_oyearc = 0
               LET l_yeard = 0   LET l_yearc = 0
               LET l_yeard2 = 0  LET l_yearc2 = 0
               LET l_yeard3 = 0  LET l_yearc3 = 0            
               IF tm.show_y='Y' THEN
                  EXECUTE aglq714_sum_pr_nch USING l_glar009
                                              INTO l_oyeard,l_oyearc,l_yeard,l_yearc,l_yeard2,l_yearc2,l_yeard3,l_yearc3
                  IF cl_null(l_oyeard) THEN LET l_oyeard = 0 END IF
                  IF cl_null(l_oyearc) THEN LET l_oyearc = 0 END IF 
                  IF cl_null(l_yeard) THEN LET l_yeard = 0 END IF
                  IF cl_null(l_yearc) THEN LET l_yearc = 0 END IF
                  IF cl_null(l_yeard2) THEN LET l_yeard2 = 0 END IF
                  IF cl_null(l_yearc2) THEN LET l_yearc2 = 0 END IF
                  IF cl_null(l_yeard3) THEN LET l_yeard3 = 0 END IF
                  IF cl_null(l_yearc3) THEN LET l_yearc3 = 0 END IF
               END IF
         
               #期初金額
               LET l_amt1=0
               LET l_amt2=0
               LET l_amt3=0
               LET l_amt4=0
               EXECUTE aglq714_sum_pr_qch USING l_glar009 
                                          INTO l_amt1,l_amt2,l_amt3,l_amt4
               IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
               IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
               IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
               IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
               LET l_period=tm.smm-1 #上期
               IF tm.stus='1' THEN
                  #當不包含YE或AD傳票時，減去YE或AD傳票金額
                  IF tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN  
                     LET l_amt5=0
                     LET l_amt6=0
                     LET l_amt7=0
                     LET l_amt8=0
                     EXECUTE aglq714_sel_pr6_3 USING tm.year,l_period,l_glar009
                                              INTO l_amt5,l_amt6,l_amt7,l_amt8
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = 'aglq714_sel_pr6_3'
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET l_success = FALSE
                     END IF
                     IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
                     IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
                     IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
                     IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
                     LET l_amt1=l_amt1-l_amt5
                     LET l_amt2=l_amt2-l_amt6
                     LET l_amt3=l_amt3-l_amt7
                     LET l_amt4=l_amt4-l_amt8
                  END IF
               #當為破期時，匯總該年第一天到上期最後一天的傳票資料
               ELSE
                  #年初數
                  LET l_amt5=0
                  LET l_amt6=0
                  LET l_amt7=0
                  LET l_amt8=0
                  LET l_period=0
                  EXECUTE aglq714_sel_pr1 USING l_glac002,tm.year,l_period,l_glar009
                                           INTO l_amt5,l_amt6,l_amt7,l_amt8
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'aglq714_sel_pr1'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET l_success = FALSE
                  END IF
                  IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
                  IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
                  IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
                  IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
                  LET l_amt1=l_amt1+l_amt5
                  LET l_amt2=l_amt2+l_amt6
                  LET l_amt3=l_amt3+l_amt7
                  LET l_amt4=l_amt4+l_amt8
               END IF
            
               #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
               IF tm.show_ce <> 'Y' THEN
                  LET l_amt5=0
                  LET l_amt6=0
                  LET l_amt7=0
                  LET l_amt8=0
                  LET l_period=tm.smm-1 #上期 
                  EXECUTE aglq714_sel_pr6_4 USING tm.year,l_period,l_glar009
                                              INTO l_amt5,l_amt6,l_amt7,l_amt8
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = 'aglq714_sel_pr6_4'
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET l_success = FALSE
                     END IF
                     IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
                     IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
                     IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
                     IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
                     LET l_amt1=l_amt1-l_amt5
                     LET l_amt2=l_amt2-l_amt6
                     LET l_amt3=l_amt3-l_amt7
                     LET l_amt4=l_amt4-l_amt8
               END IF
            
               IF l_amt2>=0 THEN    
                  LET l_oqcd=l_amt1
                  LET l_oqcc=0
                  LET l_qcd =l_amt2
                  LET l_qcc =0
                  LET l_qcd2=l_amt3
                  LET l_qcc2=0
                  LET l_qcd3=l_amt4
                  LET l_qcc3=0
               ELSE
                  LET l_oqcd=0
                  LET l_oqcc=-1*l_amt1
                  LET l_qcd =0
                  LET l_qcc =-1*l_amt2
                  LET l_qcd2=0
                  LET l_qcc2=-1*l_amt3
                  LET l_qcd3=0
                  LET l_qcc3=-1*l_amt4
               END IF 
         
               #期間異動
               LET l_oqjd = 0         LET l_oqjc = 0
               LET l_qjd  = 0         LET l_qjc  = 0
               LET l_qjd2 = 0         LET l_qjc2 = 0
               LET l_qjd3 = 0         LET l_qjc3 = 0
               EXECUTE aglq714_sum_pr_qj USING l_glar009
                                         INTO l_oqjd,l_oqjc,l_qjd,l_qjc,l_qjd2,l_qjc2,l_qjd3,l_qjc3
               IF cl_null(l_oqjd) THEN LET l_oqjd=0 END IF
               IF cl_null(l_oqjc) THEN LET l_oqjc=0 END IF
               IF cl_null(l_qjd)  THEN LET l_qjd=0  END IF
               IF cl_null(l_qjc)  THEN LET l_qjc=0  END IF
               IF cl_null(l_qjd2) THEN LET l_qjd2=0 END IF
               IF cl_null(l_qjc2) THEN LET l_qjc2=0 END IF
               IF cl_null(l_qjd3) THEN LET l_qjd3=0 END IF
               IF cl_null(l_qjc3) THEN LET l_qjc3=0 END IF
            
               #当整期间且不跨年查询时，當不包含YE或AD傳票時，減去YE或AD傳票金額
               IF tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN 
                  LET l_amt1=0
                  LET l_amt2=0
                  LET l_amt3=0
                  LET l_amt4=0
                  LET l_amt5=0
                  LET l_amt6=0
                  LET l_amt7=0
                  LET l_amt8=0
                  EXECUTE aglq714_sel_pr8_3 USING l_glar009
                                           INTO l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_amt7,l_amt8
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'aglq714_sel_pr8_3'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET l_success = FALSE
                  END IF
                  IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
                  IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
                  IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
                  IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
                  IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
                  IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
                  IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
                  IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
                  LET l_oqjd=l_oqjd-l_amt1
                  LET l_oqjc=l_oqjc-l_amt2
                  LET l_qjd =l_qjd -l_amt3
                  LET l_qjc =l_qjc -l_amt4
                  LET l_qjd2=l_qjd2-l_amt5
                  LET l_qjc2=l_qjc2-l_amt6
                  LET l_qjd3=l_qjd3-l_amt7
                  LET l_qjc3=l_qjc3-l_amt8
               END IF
            
               #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
               IF tm.show_ce <> 'Y' THEN
                  LET l_amt1=0
                  LET l_amt2=0
                  LET l_amt3=0
                  LET l_amt4=0
                  LET l_amt5=0
                  LET l_amt6=0
                  LET l_amt7=0
                  LET l_amt8=0
                  EXECUTE aglq714_sel_pr8_4 USING l_glar009
                                           INTO l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_amt7,l_amt8
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'aglq714_sel_pr8_4'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET l_success = FALSE
                  END IF
                  IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
                  IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
                  IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
                  IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
                  IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
                  IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
                  IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
                  IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
                  LET l_oqjd=l_oqjd-l_amt1
                  LET l_oqjc=l_oqjc-l_amt2
                  LET l_qjd =l_qjd -l_amt3
                  LET l_qjc =l_qjc -l_amt4
                  LET l_qjd2=l_qjd2-l_amt5
                  LET l_qjc2=l_qjc2-l_amt6
                  LET l_qjd3=l_qjd3-l_amt7
                  LET l_qjc3=l_qjc3-l_amt8
               END IF
            
               #期末金額=期初+期間
               #原幣
               LET l_amt1=(l_oqcd+l_oqjd)-(l_oqcc+l_oqjc)
               IF l_amt1>=0 THEN     
                  LET l_oqmd=l_amt1
                  LET l_oqmc=0
               ELSE
                  LET l_oqmd=0
                  LET l_oqmc=l_amt1*-1
               END IF
               #本幣
               LET l_amt1=(l_qcd+l_qjd)-(l_qcc+l_qjc)
               IF l_amt1>=0 THEN    
                  LET l_qmd=l_amt1
                  LET l_qmc=0
               ELSE
                  LET l_qmd=0
                  LET l_qmc=l_amt1*-1
               END IF
               #本幣二
               LET l_amt1=(l_qcd2+l_qjd2)-(l_qcc2+l_qjc2)
               IF l_amt1>=0 THEN     
                  LET l_qmd2=l_amt1
                  LET l_qmc2=0
               ELSE
                  LET l_qmd2=0
                  LET l_qmc2=l_amt1*-1
               END IF
               #本幣三
               LET l_amt1=(l_qcd3+l_qjd3)-(l_qcc3+l_qjc3)
               IF l_amt1>=0 THEN    
                  LET l_qmd3=l_amt1
                  LET l_qmc3=0
               ELSE
                  LET l_qmd3=0
                  LET l_qmc3=l_amt1*-1
               END IF  

               #本年累計金額
               LET l_osumd= 0         LET l_osumc= 0
               LET l_sumd = 0         LET l_sumc = 0
               LET l_sumd2= 0         LET l_sumc2= 0
               LET l_sumd3= 0         LET l_sumc3= 0
               EXECUTE aglq714_sum_pr_lj USING l_glar009
                                          INTO l_osumd,l_osumc,l_sumd,l_sumc,l_sumd2,l_sumc2,l_sumd3,l_sumc3
               IF cl_null(l_osumd) THEN LET l_osumd=0 END IF
               IF cl_null(l_osumc) THEN LET l_osumc=0 END IF
               IF cl_null(l_sumd)  THEN LET l_sumd=0  END IF
               IF cl_null(l_sumc)  THEN LET l_sumc=0  END IF
               IF cl_null(l_sumd2) THEN LET l_sumd2=0 END IF
               IF cl_null(l_sumc2) THEN LET l_sumc2=0 END IF
               IF cl_null(l_sumd3) THEN LET l_sumd3=0 END IF
               IF cl_null(l_sumc3) THEN LET l_sumc3=0 END IF
               #當截止日期為該期最後一天，且傳票狀態為1：已過帳時，抓取glar_t餘額當資料,否則，直接抓取glaq_t傳票資料
               IF tm.stus='1' THEN
                  #當不包含YE或AD傳票時，減去YE或AD傳票金額
                  IF tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN 
                     LET l_amt1 = 0
                     LET l_amt2 = 0
                     LET l_amt3 = 0
                     LET l_amt4 = 0
                     LET l_amt5 = 0
                     LET l_amt6 = 0
                     LET l_amt7 = 0
                     LET l_amt8 = 0
                     EXECUTE aglq714_sel_pr7_3 USING tm.year,tm.emm,l_glar009
                                              INTO l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_amt7,l_amt8                                       
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = 'aglq714_sel_pr7_3'
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET l_success = FALSE
                     END IF
                     IF cl_null(l_amt1)  THEN LET l_amt1=0 END IF
                     IF cl_null(l_amt2)  THEN LET l_amt2=0 END IF
                     IF cl_null(l_amt3)  THEN LET l_amt3=0 END IF
                     IF cl_null(l_amt4)  THEN LET l_amt4=0 END IF
                     IF cl_null(l_amt5)  THEN LET l_amt5=0 END IF
                     IF cl_null(l_amt6)  THEN LET l_amt6=0 END IF
                     IF cl_null(l_amt7)  THEN LET l_amt7=0 END IF
                     IF cl_null(l_amt8)  THEN LET l_amt8=0 END IF
                     LET l_osumd=l_osumd-l_amt1
                     LET l_osumc=l_osumc-l_amt2
                     LET l_sumd =l_sumd -l_amt3
                     LET l_sumc =l_sumc -l_amt4
                     LET l_sumd2=l_sumd2-l_amt5
                     LET l_sumc2=l_sumc2-l_amt6
                     LET l_sumd3=l_sumd3-l_amt7
                     LET l_sumc3=l_sumc3-l_amt8 
                  END IF
               ELSE

               END IF 
            
               #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
               IF tm.show_ce <> 'Y' THEN
                   LET l_amt1=0
                   LET l_amt2=0
                   LET l_amt3=0
                   LET l_amt4=0
                   LET l_amt5=0
                   LET l_amt6=0
                   LET l_amt7=0
                   LET l_amt8=0
                  EXECUTE aglq714_sel_pr7_4 USING tm.year,tm.emm,l_glar009
                                           INTO l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_amt7,l_amt8                                       
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'aglq714_sel_pr7_4'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET l_success = FALSE
                  END IF
                  IF cl_null(l_amt1)  THEN LET l_amt1=0 END IF
                  IF cl_null(l_amt2)  THEN LET l_amt2=0 END IF
                  IF cl_null(l_amt3)  THEN LET l_amt3=0 END IF
                  IF cl_null(l_amt4)  THEN LET l_amt4=0 END IF
                  IF cl_null(l_amt5)  THEN LET l_amt5=0 END IF
                  IF cl_null(l_amt6)  THEN LET l_amt6=0 END IF
                  IF cl_null(l_amt7)  THEN LET l_amt7=0 END IF
                  IF cl_null(l_amt8)  THEN LET l_amt8=0 END IF
                  LET l_osumd=l_osumd-l_amt1
                  LET l_osumc=l_osumc-l_amt2
                  LET l_sumd =l_sumd -l_amt3
                  LET l_sumc =l_sumc -l_amt4
                  LET l_sumd2=l_sumd2-l_amt5
                  LET l_sumc2=l_sumc2-l_amt6
                  LET l_sumd3=l_sumd3-l_amt7
                  LET l_sumc3=l_sumc3-l_amt8 
               END IF
            
               IF l_yeard=0 AND l_yearc=0 AND  #年初數
                  l_qcd=0 AND l_qcc=0 AND      #期初數
                  l_qjd=0 AND l_qjc=0 AND      #期間異動
                  l_qmd=0 AND l_qmc=0 AND      #期末
                  l_sumd=0 AND l_sumc=0 THEN   #本年累計，以上全部等於0時該筆科目資料不顯示
                  CONTINUE FOREACH
               END IF

               #期间
               LET l_oqj = l_oqjd - l_oqjc
               LET l_qj  = l_qjd  - l_qjc
               LET l_qj2 = l_qjd2 - l_qjc2
               LET l_qj3 = l_qjd3 - l_qjc3 
               
               #本年合计
               LET l_obsum = l_osumd - l_osumc
               LET l_bsum  = l_sumd  - l_sumc
               LET l_bsum2 = l_sumd2 - l_sumc2
               LET l_bsum3 = l_sumd3 - l_sumc3

               EXECUTE aglq714_ins_pr USING l_glac002,l_glar009,
                      l_oyeard,l_oyearc,l_yeard,l_yearc,l_yeard2,l_yearc2,l_yeard3,l_yearc3,
                      l_oqcd,l_oqcc,l_qcd,l_qcc,l_qcd2,l_qcc2,l_qcd3,l_qcc3,
                      l_oqj,l_qj,l_qj2,l_qj3,
                      l_oqmd,l_oqmc,l_qmd,l_qmc,l_qmd2,l_qmc2,l_qmd3,l_qmc3,
                      l_obsum,l_bsum,l_bsum2,l_bsum3

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'insert'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
            END FOREACH
      END FOREACH
   END IF
   
   IF l_success = FALSE THEN
      CALL cl_err_collect_show()
      DELETE FROM aglq714_tmp
   ELSE
      CALL cl_err_collect_init()
      CALL cl_err_collect_show()
   END IF
 
END FUNCTION
################################################################################
# Descriptions...: 抓取下一筆資料
# Memo...........:
# Usage..........: CALL aglq714_fetch1(p_flag)
# Input parameter: p_flag            
# Date & Author..: 2014/3/17 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq714_fetch1(p_flag)
   DEFINE p_flag   LIKE type_t.chr1
   DEFINE ls_msg     STRING
   
   IF g_header_cnt = 0 THEN
      RETURN
   END IF
   
   CASE p_flag
      WHEN 'F' LET g_current_idx = 1
      WHEN 'L' LET g_current_idx = g_header_cnt        
      WHEN 'P'
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN 'N'
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN '/'
         IF (NOT g_no_ask) THEN    
            CALL cl_set_act_visible("accept,cancel", TRUE)    
            CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,':' FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl" 
            END PROMPT
 
            CALL cl_set_act_visible("accept,cancel", FALSE)    
            IF INT_FLAG THEN
                LET INT_FLAG = 0
                EXIT CASE  
            END IF           
         END IF
         
         IF g_jump > 0 AND g_jump <= g_glar_s.getLength() THEN
             LET g_current_idx = g_jump
         END IF
         
         LET g_no_ask = FALSE  
   END CASE 
   
   #代表沒有資料
   IF g_current_idx = 0 OR g_glar_s.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_glar_s.getLength() THEN
      LET g_current_idx = g_glar_s.getLength()
   END IF
   
   DISPLAY g_current_idx TO FORMONLY.h_index
   LET g_glar009 = g_glar_s[g_current_idx].glar009 
   CALL aglq714_b_fill1() 
   
END FUNCTION
################################################################################
# Descriptions...: 設置默認值
# Memo...........:
# Usage..........: CALL aglq714_set_default_value()
# Date & Author..: 2014/03/13 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq714_set_default_value()
   DEFINE l_flag           LIKE type_t.chr1
   DEFINE l_errno          LIKE type_t.chr100
   DEFINE l_glav002        LIKE glav_t.glav002
   DEFINE l_glav005        LIKE glav_t.glav005
   DEFINE l_sdate_s        LIKE glav_t.glav004
   DEFINE l_sdate_e        LIKE glav_t.glav004
   DEFINE l_glav006        LIKE glav_t.glav006
   DEFINE l_pdate_s        LIKE glav_t.glav004
   DEFINE l_pdate_e        LIKE glav_t.glav004
   DEFINE l_glav007        LIKE glav_t.glav007
   DEFINE l_wdate_s        LIKE glav_t.glav004
   DEFINE l_wdate_e        LIKE glav_t.glav004
   
   CALL s_get_accdate(g_glaa003,g_today,'','')
   RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag='N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

   END IF
   LET tm.year=l_glav002
   LET tm.smm=l_glav006
   LET tm.emm=l_glav006
  
   #原幣顯示設置
   LET tm.curr_o='N'
   LET tm.curr_p='N'
   CALL aglq714_set_comp_entry('curr_p',FALSE)
   #年初數
   LET tm.show_y='N'
   
   CALL cl_set_comp_visible('b_glar009,oyeard,oyearc,oqcd,oqcc,oqj,oqmd,oqmc,obsum,yeard,yearc,yeard2,yearc2,yeard3,yearc3',FALSE)
   #統制科目
   LET tm.show_acc='N'
   #科目層級
   LET tm.glac005=99
   #單據狀態
   LET tm.stus='1'
   #含內部管理科目
   LET tm.glac009='Y'
   #含月結傳票
   LET tm.show_ce='Y'
   #含年結傳票
   LET tm.show_ye='Y'
   #含審計調整傳票
   LET tm.show_ad='Y'
END FUNCTION
################################################################################
# Descriptions...: 科目说明
# Memo...........:
# Usage..........: CALL aglq714_glar001_desc(p_glar001)
#                  RETURNING r_desc
# Input parameter: p_glar001   科目編號
# Return code....: r_desc      科目說
# Date & Author..: 2014/03/14 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq714_glar001_desc(p_glar001)
   DEFINE p_glar001   LIKE glar_t.glar001
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glar001
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001 = '"||g_glaa004||"' AND glacl002 = ? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN  g_rtn_fields[1]
END FUNCTION

################################################################################
# Descriptions...: 動態設定元件是否需輸入值
# Memo...........:
# Usage..........: CALL aglq714_set_comp_entry(ps_fields,pi_entry)
# Input parameter: ps_fields   欄位名稱
#                : pi_entry    是否進入欄位
# Date & Author..: 2014/04/10 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq714_set_comp_entry(ps_fields,pi_entry)
   DEFINE ps_fields STRING,
          pi_entry  LIKE type_t.num5           
   DEFINE lst_fields base.StringTokenizer,
          ls_field_name STRING
   DEFINE lwin_curr     ui.Window
   DEFINE lnode_win     om.DomNode,
          llst_items    om.NodeList,
          li_i          LIKE type_t.num5,        
          lnode_item    om.DomNode,
          ls_item_name  STRING
 
   IF g_bgjob = 'Y' AND g_gui_type NOT MATCHES "[13]"  THEN  
      RETURN
   END IF
 
   IF (ps_fields IS NULL) THEN
      RETURN
   END IF
 
   LET ps_fields = ps_fields.toLowerCase()
 
   LET lst_fields = base.StringTokenizer.create(ps_fields, ",")
 
   LET lwin_curr = ui.Window.getCurrent()
   LET lnode_win = lwin_curr.getNode()
 
   LET llst_items = lnode_win.selectByPath("//Form//*")
 
   WHILE lst_fields.hasMoreTokens()
     LET ls_field_name = lst_fields.nextToken()
     LET ls_field_name = ls_field_name.trim()
 
     IF (ls_field_name.getLength() > 0) THEN
        FOR li_i = 1 TO llst_items.getLength()
            LET lnode_item = llst_items.item(li_i)
            LET ls_item_name = lnode_item.getAttribute("colName")
 
            IF (ls_item_name IS NULL) THEN
               LET ls_item_name = lnode_item.getAttribute("name")
 
               IF (ls_item_name IS NULL) THEN
                  CONTINUE FOR
               END IF
            END IF
 
            LET ls_item_name = ls_item_name.trim()
 
            IF (ls_item_name.equals(ls_field_name)) THEN
               IF (pi_entry) THEN
                  CALL lnode_item.setAttribute("noEntry", "0")
                  CALL lnode_item.setAttribute("active", "1")
               ELSE
                  CALL lnode_item.setAttribute("noEntry", "1")
                  CALL lnode_item.setAttribute("active", "0")
               END IF
 
               EXIT FOR
            END IF
        END FOR
     END IF
   END WHILE
END FUNCTION
################################################################################
# Descriptions...: 显示资料
# Memo...........:
# Usage..........: CALL aglq714_show()
# Date & Author..:  2014/03/18 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq714_show()
   DISPLAY g_glaald,g_glaald_desc,g_glaacomp,g_glaacomp_desc,g_glaa001,g_glaa016,g_glaa020,
           tm.year,tm.smm,tm.emm,tm.ctype,tm.curr_o,tm.curr_p,
           tm.show_y,tm.show_acc,tm.glac005,tm.stus,tm.glac009,tm.show_ad,tm.show_ce,tm.show_ye
        TO glaald,glaald_desc,glaacomp,glaacomp_desc,glaa001,glaa016,glaa020,
           year,smm,emm,ctype,curr_o,curr_p,
           show_y,show_acc,glac005,stus,glac009,show_ad,show_ce,show_ye
           
END FUNCTION
################################################################################
# Descriptions...: 填充单身资料
# Memo...........:
# Usage..........: CALL aglq714_b_fill1()
# Date & Author..: 2014/03/18 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq714_b_fill1()
   DEFINE l_sum1      LIKE type_t.num20_6 
   DEFINE l_sum2      LIKE type_t.num20_6 
   DEFINE l_sum3      LIKE type_t.num20_6 
   DEFINE l_sum4      LIKE type_t.num20_6 
   DEFINE l_sum5      LIKE type_t.num20_6 
   DEFINE l_sum6      LIKE type_t.num20_6 
   DEFINE l_sum7      LIKE type_t.num20_6 
   DEFINE l_sum8      LIKE type_t.num20_6 
   DEFINE l_sum9      LIKE type_t.num20_6 
   DEFINE l_sum10     LIKE type_t.num20_6 
   DEFINE l_sum11     LIKE type_t.num20_6 
   DEFINE l_sum12     LIKE type_t.num20_6 
   DEFINE l_sum13     LIKE type_t.num20_6 
   DEFINE l_sum14     LIKE type_t.num20_6 
   DEFINE l_sum15     LIKE type_t.num20_6 
   DEFINE l_sum16     LIKE type_t.num20_6 
   DEFINE l_sum17     LIKE type_t.num20_6 
   DEFINE l_sum18     LIKE type_t.num20_6 
   DEFINE l_sum19     LIKE type_t.num20_6 
   DEFINE l_sum20     LIKE type_t.num20_6 
   DEFINE l_sum21     LIKE type_t.num20_6 
   DEFINE l_sum22     LIKE type_t.num20_6 
   DEFINE l_sum23     LIKE type_t.num20_6 
   DEFINE l_sum24     LIKE type_t.num20_6 
   DEFINE l_sum25     LIKE type_t.num20_6 
   DEFINE l_sum26     LIKE type_t.num20_6 
   DEFINE l_sum27     LIKE type_t.num20_6 
   DEFINE l_sum28     LIKE type_t.num20_6 
   DEFINE l_sum29     LIKE type_t.num20_6 
   DEFINE l_sum30     LIKE type_t.num20_6 
   
   LET g_sql="SELECT UNIQUE 'N',glar001,glacl004,glar009,",  
             "       oyeard,oyearc,yeard,yearc,yeard2,yearc2,yeard3,yearc3,",
             "       oqcd,oqcc,qcd,qcc,qcd2,qcc2,qcd3,qcc3,",
             "       oqj,qj,qj2,qj3,",
             "       oqmd,oqmc,qmd,qmc,qmd2,qmc2,qmd3,qmc3,",
             "       obsum,bsum,bsum2,bsum3 ",
             "  FROM aglq714_tmp ",
             "       LEFT JOIN glacl_t ON glaclent = ",g_enterprise," AND glacl001 = '",g_glaa004,"' AND glacl002 = glar001 AND glacl003='"||g_dlang||"'", #160411-00027#4 add
             "  WHERE 1=1 "
   #是否按照幣別分頁
   IF NOT cl_null(g_glar009) THEN
      LET g_sql=g_sql," AND glar009='",g_glar009, "'"
   END IF   
    LET g_sql = g_sql," AND ",g_wc_filter 
   LET g_sql=g_sql," ORDER BY glar001,glar009 "      
     
   PREPARE aglq714_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR aglq714_pb1

   LET g_sql="SELECT ",
             "       SUM(qj),SUM(qj2),SUM(qj3),",
             "       SUM(bsum),SUM(bsum2),SUM(bsum3) ",
             "  FROM aglq714_tmp"

   #勾选统治科目时，抓取最上次统治科目+独立科目金额。反之，抓取的是明细科目+独立科目金额
   IF tm.show_acc = 'Y' THEN
      LET g_sql=g_sql," WHERE glar001 IN (SELECT glac002 FROM glac_t ",
                      "                   WHERE glac002=glac004 AND glacent=",g_enterprise," AND glac001='",g_glaa004,"')"
   END IF

   #是否按照幣別分頁
   IF NOT cl_null(g_glar009) THEN
      LET g_sql=g_sql," AND glar009='",g_glar009,"'"
   END IF 
   PREPARE aglq714_sum_pb1 FROM g_sql

   CALL g_glar_d.clear()
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs1 INTO g_glar_d[l_ac].sel,g_glar_d[l_ac].glar001,g_glar_d[l_ac].glar001_desc,g_glar_d[l_ac].glar009, #160411-00027#4 add 'sel'  
       g_glar_d[l_ac].oyeard,g_glar_d[l_ac].oyearc,g_glar_d[l_ac].yeard,g_glar_d[l_ac].yearc,g_glar_d[l_ac].yeard2, 
       g_glar_d[l_ac].yearc2,g_glar_d[l_ac].yeard3,g_glar_d[l_ac].yearc3,g_glar_d[l_ac].oqcd,g_glar_d[l_ac].oqcc, 
       g_glar_d[l_ac].qcd,g_glar_d[l_ac].qcc,g_glar_d[l_ac].qcd2,g_glar_d[l_ac].qcc2,g_glar_d[l_ac].qcd3, 
       g_glar_d[l_ac].qcc3,g_glar_d[l_ac].oqj,g_glar_d[l_ac].qj,
       g_glar_d[l_ac].qj2,g_glar_d[l_ac].qj3,g_glar_d[l_ac].oqmd, 
       g_glar_d[l_ac].oqmc,g_glar_d[l_ac].qmd,g_glar_d[l_ac].qmc,g_glar_d[l_ac].qmd2,g_glar_d[l_ac].qmc2, 
       g_glar_d[l_ac].qmd3,g_glar_d[l_ac].qmc3,g_glar_d[l_ac].obsum,g_glar_d[l_ac].bsum, 
       g_glar_d[l_ac].bsum2,g_glar_d[l_ac].bsum3 

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
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
   LET g_error_show = 0
   
   #合计：
   EXECUTE aglq714_sum_pb1 INTO 
       l_sum1,l_sum2,l_sum3,l_sum4,l_sum5,l_sum6
       
   DISPLAY l_sum1 TO FORMONLY.sum1
   DISPLAY l_sum2 TO FORMONLY.sum2
   DISPLAY l_sum3 TO FORMONLY.sum3
   DISPLAY l_sum4 TO FORMONLY.sum4
   DISPLAY l_sum5 TO FORMONLY.sum5
   DISPLAY l_sum6 TO FORMONLY.sum6
   
   CALL g_glar_d.deleteElement(g_glar_d.getLength()) 
   LET g_detail_cnt = l_ac - 1
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   FREE aglq714_pb1
   
   LET l_ac = 1
   
   CALL aglq714_filter_show('glar001','b_glar001')
 
END FUNCTION
################################################################################
# Descriptions...: 设置分页
# Memo...........:
# Usage..........: CALL aglq714_set_page()
# Date & Author..: 2014/03/18 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq714_set_page()
   DEFINE l_sql    STRING
   DEFINE l_idx    LIKE type_t.num5
   
   CALL g_glar_s.clear()
   IF tm.curr_p <>'Y' THEN
      LET g_glar_s[1].glar009=''
      LET g_header_cnt = 1
      LET g_rec_b = 1
   ELSE      
      LET l_sql="SELECT DISTINCT glar009 FROM aglq714_tmp ORDER BY glar009 "
      PREPARE aglq714_sel_s_pr FROM l_sql
      DECLARE aglq714_sel_s_cr CURSOR FOR aglq714_sel_s_pr
      LET l_idx=1
      FOREACH aglq714_sel_s_cr INTO g_glar_s[l_idx].glar009
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'FOREACH aglq714_sel_s_cr'
            LET g_errparam.popup = FALSE
            CALL cl_err()

            EXIT FOREACH
         END IF
         LET l_idx=l_idx+1
         IF l_idx > g_max_rec THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 9035
            LET g_errparam.extend = ''
            LET g_errparam.popup = FALSE
            CALL cl_err()

            EXIT FOREACH
         END IF
      END FOREACH
      LET l_idx=l_idx-1
      CALL g_glar_s.deleteElement(g_glar_s.getLength())
      LET g_header_cnt = l_idx
      LET g_rec_b = l_idx
   END IF
   DISPLAY g_header_cnt TO FORMONLY.h_count
END FUNCTION

################################################################################
# Descriptions...: 串查aglq740總分類帳查詢
# Memo...........:
# Usage..........: CALL aglq714_cmdrun()
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq714_cmdrun()
   DEFINE la_param     RECORD
          prog         STRING,
          param        DYNAMIC ARRAY OF STRING
                       END RECORD
   DEFINE ls_js        STRING
   
   INITIALIZE la_param.* TO NULL
   LET la_param.prog = 'aglq740'
   LET la_param.param[1] = g_glaald    #帳別
   LET la_param.param[2] = tm.year     #年度   
   LET la_param.param[3] = tm.smm      #起始期別
   LET la_param.param[4] = tm.emm      #截止期別
   LET la_param.param[5] = 'N'         #按科目分頁管理
   LET la_param.param[6] = tm.ctype    #多本位幣顯示
   LET la_param.param[7] = tm.show_acc #顯示統制科目
   LET la_param.param[8] = tm.glac005  #科目層級
   LET la_param.param[9] = tm.stus     #單據狀態
   LET la_param.param[10] = tm.glac009 #含內部管理
   LET la_param.param[11] = tm.show_ce #含月結
   LET la_param.param[12] = tm.show_ye #含年結
   LET la_param.param[13] = g_glar_d[g_detail_idx].glar001 #科目編號
   LET la_param.param[14] = tm.show_ad #含審計調整傳票
   LET ls_js = util.JSON.stringify( la_param )
   CALL cl_cmdrun(ls_js)
END FUNCTION
# 传进XG报表隐藏栏位设置
PRIVATE FUNCTION aglq714_xg_visible()
   LET g_xg_visible = NULL

   #顯示本位幣三
   IF tm.ctype = '2' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_qj2|l_bsum2"
   END IF
   #顯示本位幣二
   IF tm.ctype = '1' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_qj3|l_bsum3"
   END IF
   #只顯示本位幣一
   IF tm.ctype='0' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_qj2|l_qj3|l_bsum2|l_bsum3"
   END IF
   
END FUNCTION
# 打印
PRIVATE FUNCTION aglq714_output()
   DEFINE l_i,l_count      LIKE type_t.num5
   DEFINE l_smm,l_emm      STRING
   DEFINE l_glaald_desc    LIKE type_t.chr500,
          l_glaacomp_desc  LIKE type_t.chr500,
          l_glaa001_desc   LIKE type_t.chr500,
          l_year           LIKE type_t.chr500,
          l_mm             LIKE type_t.chr500,
          l_ctype          LIKE type_t.chr500,
          l_stus           LIKE type_t.chr500,
          l_dir1           LIKE type_t.chr500,
          l_dir2           LIKE type_t.chr500
       
   DELETE FROM aglq714_tmp01          
   LET l_count = g_glar_d.getLength()
   
   LET l_glaald_desc = g_glaald," ",g_glaald_desc
   LET l_glaacomp_desc = g_glaacomp," ",g_glaacomp_desc
   LET l_glaa001_desc = g_glaa001," ",g_glaa016," ",g_glaa020
   LET l_year = tm.year
   LET l_smm = tm.smm
   LET l_emm = tm.emm
   LET l_mm = l_smm,"-",l_emm
   LET l_ctype = tm.ctype,":",s_desc_gzcbl004_desc('9921',tm.ctype)
   LET l_stus = tm.stus,":",s_desc_gzcbl004_desc('9922',tm.stus)
   
   FOR l_i = 1 TO l_count
      INSERT INTO aglq714_tmp01      
      VALUES(l_glaald_desc,l_glaacomp_desc,l_glaa001_desc,l_year,l_mm,
         l_ctype,l_stus,g_glar_d[l_i].glar001,g_glar_d[l_i].glar001_desc,
         g_glar_d[l_i].qj,g_glar_d[l_i].qj2,g_glar_d[l_i].qj3,
         g_glar_d[l_i].bsum,g_glar_d[l_i].bsum2,g_glar_d[l_i].bsum3)
         
   END FOR
   CALL aglq714_xg_visible()
   CALL aglq714_x01(' 1=1','aglq714_tmp01',g_xg_visible)
END FUNCTION

 
{</section>}
 
