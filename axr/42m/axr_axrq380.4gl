#該程式未解開Section, 採用最新樣板產出!
{<section id="axrq380.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:12(2016-05-19 15:41:23), PR版次:0012(2017-01-17 14:59:33)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000040
#+ Filename...: axrq380
#+ Description: 應收立沖帳明細查詢
#+ Creator....: 01531(2016-05-16 13:34:36)
#+ Modifier...: 01531 -SD/PR- 05634
 
{</section>}
 
{<section id="axrq380.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#160705-00042#10 2016/07/13 By sakura   程式中寫死g_prog部分改寫MATCHES方式
#160731-00372#1  2016/08/16 By 07900    客户开窗不要开供应商
#160812-00027#2  2016/08/16 By 06821    全面盤點應付程式帳套權限控管
#160811-00009#2  2016/08/17 By 01531    账务中心/法人/账套权限控管
#160905-00002#7  2016/09/05 By 08171    SQL補上ent
#160913-00017#7  2016/09/22 By 07900    AXR模组调整交易客商开窗
#161021-00050#5  2016/10/26 By 08729    處理組織開窗
#161111-00049#1  2016/11/12 By 01727    控制组权限修改
#161109-00048#1  2016/12/07 By 01727    判斷 21,23 類預付/預收待抵來源單據若已付,且本張待抵仍有未沖金額時才需要顯示
#161223-00022#1  2016/12/30 By albireo  aapq380時應開窗 q_apcadocno
#161229-00047#69 2017/01/13 By Reanna   財務用供應商對象控制組,法人條件改為用 IN (site...)的方式,QBE時,傳入符合權限的法人；INPUT時傳入目前法人據點
#170116-00025#1  2017/01/17 By dorishsu 當g_prog為axrq380,预收axrt310 xrcc108-xrcc109=0则不显示预收单
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
 
#單身 type 宣告
PRIVATE TYPE type_g_xrca_d RECORD
       
       sel LIKE type_t.chr1, 
   xrca001 LIKE xrca_t.xrca001, 
   xrcadocno LIKE xrca_t.xrcadocno, 
   xrcadocdt LIKE xrca_t.xrcadocdt, 
   xrca007 LIKE xrca_t.xrca007, 
   xrca007_desc LIKE type_t.chr500, 
   xrca004 LIKE xrca_t.xrca004, 
   xrca004_desc LIKE type_t.chr500, 
   xrca005 LIKE xrca_t.xrca005, 
   xrca005_desc LIKE type_t.chr500, 
   xrca014 LIKE xrca_t.xrca014, 
   xrca014_desc LIKE type_t.chr500, 
   xrca009 LIKE xrca_t.xrca009, 
   xrca010 LIKE xrca_t.xrca010, 
   xrca100 LIKE xrca_t.xrca100, 
   xrca101 LIKE xrca_t.xrca101, 
   xrca103 LIKE type_t.num20_6, 
   xrcc108 LIKE type_t.num20_6, 
   xrcc118 LIKE type_t.num20_6
       END RECORD
PRIVATE TYPE type_g_xrca2_d RECORD
       xrcedocno LIKE type_t.chr20, 
   xrcadocdt LIKE type_t.dat, 
   xrce002 LIKE type_t.chr10, 
   xrce109 LIKE type_t.num20_6, 
   xrce119 LIKE type_t.num20_6
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_input        RECORD
          xrcasite       LIKE xrca_t.xrcasite,
          xrcasite_desc  LIKE type_t.chr500,
          xrcald         LIKE xrca_t.xrcald,
          xrcald_desc    LIKE type_t.chr500,
          edata          LIKE xrca_t.xrcadocdt,
          a              LIKE type_t.chr1
                      END RECORD
DEFINE g_wc_xrcald    STRING
DEFINE g_sql_ctrl     STRING
DEFINE l_ac2          LIKE type_t.num10
DEFINE g_comp_str     STRING               #161229-00047#69
#end add-point
 
#模組變數(Module Variables)
DEFINE g_xrca_d            DYNAMIC ARRAY OF type_g_xrca_d
DEFINE g_xrca_d_t          type_g_xrca_d
DEFINE g_xrca2_d     DYNAMIC ARRAY OF type_g_xrca2_d
DEFINE g_xrca2_d_t   type_g_xrca2_d
 
 
 
 
 
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                 STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL    
DEFINE g_cnt                 LIKE type_t.num10              
DEFINE l_ac                  LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數
DEFINE g_current_row         LIKE type_t.num10             #目前所在筆數
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_page                STRING                        #第幾頁
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_row_index           LIKE type_t.num10
DEFINE g_master_idx          LIKE type_t.num10
DEFINE g_detail_idx          LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail_idx2         LIKE type_t.num10
DEFINE g_hyper_url           STRING                        #hyperlink的主要網址
DEFINE g_qbe_hidden          LIKE type_t.num5              #qbe頁籤折疊
DEFINE g_tot_cnt             LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page         LIKE type_t.num10             #每頁筆數
DEFINE g_page_act_list       STRING                        #分頁ACTION清單
DEFINE g_current_row_tot     LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_start_num      LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num        LIKE type_t.num10             #目前頁面結束筆數
 
#多table用wc
DEFINE g_wc_table           STRING
DEFINE g_detail_page_action STRING
DEFINE g_pagestart          LIKE type_t.num10
 
 
 
DEFINE g_wc_filter_table           STRING
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axrq380.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axr","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " ", 
                      " FROM ",
                      " "
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrq380_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axrq380_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrq380_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrq380 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrq380_init()   
 
      #進入選單 Menu (="N")
      CALL axrq380_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axrq380
      
   END IF 
   
   CLOSE axrq380_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axrq380.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axrq380_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_gzze003     LIKE gzze_t.gzze003   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('b_xrca001','8302') 
  
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('xrce002','8051')
   LET l_gzze003=""
   
   #IF g_prog = 'axrq380' THEN        #160705-00042#10 160713 by sakura mark
   IF g_prog MATCHES 'axrq380' THEN   #160705-00042#10 160713 by sakura add
      CALL cl_set_combo_scc('b_xrca001','8302')
      LET l_gzze003 = cl_getmsg('aoo-00202',g_dlang)
      CALL cl_set_comp_att_text('b_xrca009',l_gzze003)
      LET l_gzze003 = cl_getmsg('aoo-00204',g_dlang)
      CALL cl_set_comp_att_text('b_xrca010',l_gzze003)
      LET l_gzze003 = cl_getmsg('axr-01012',g_dlang)
      CALL cl_set_comp_att_text('xrca103',l_gzze003) 
      LET l_gzze003 = cl_getmsg('axr-01014',g_dlang)
      CALL cl_set_comp_att_text('b_xrca005',l_gzze003)       
   ELSE
      CALL cl_set_combo_scc('b_xrca001','8502')
      LET l_gzze003 = cl_getmsg('aoo-00203',g_dlang)
      CALL cl_set_comp_att_text('b_xrca009',l_gzze003)
      LET l_gzze003 = cl_getmsg('aoo-00205',g_dlang)
      CALL cl_set_comp_att_text('b_xrca010',l_gzze003)
      LET l_gzze003 = cl_getmsg('axr-01013',g_dlang)
      CALL cl_set_comp_att_text('xrca103',l_gzze003)
      LET l_gzze003 = cl_getmsg('axr-01015',g_dlang)
      CALL cl_set_comp_att_text('b_xrca005',l_gzze003)         
   END IF   
   CALL axrq380_def()
   #end add-point
 
   CALL axrq380_default_search()
END FUNCTION
 
{</section>}
 
{<section id="axrq380.default_search" >}
PRIVATE FUNCTION axrq380_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"

   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " xrcasite = '", g_argv[03], "' AND "
   END IF
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xrcald = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " xrcadocno = '", g_argv[02], "' AND "
   END IF
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段結束前 name="default_search.after"
   #IF g_prog = 'aapq380' THEN        #160705-00042#10 160713 by sakura mark
   IF g_prog MATCHES 'aapq380' THEN   #160705-00042#10 160713 by sakura add
      LET g_wc = cl_replace_str(g_wc,"xrca","apca")   
   END IF

   CALL cl_set_comp_visible("folder_qbe,detail1",TRUE)
   IF NOT cl_null(g_argv[01]) AND NOT cl_null(g_argv[02]) AND NOT cl_null(g_argv[03]) THEN
      CALL cl_set_comp_visible("folder_qbe,detail1",FALSE)
   END IF
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq380.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrq380_ui_dialog() 
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10
   DEFINE ls_result STRING
   DEFINE ls_wc     STRING
   DEFINE lc_action_choice_old   STRING
   DEFINE ls_js     STRING
   DEFINE la_param  RECORD
                    prog       STRING,
                    actionid   STRING,
                    background LIKE type_t.chr1,
                    param      DYNAMIC ARRAY OF STRING
                    END RECORD
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   CALL axrq380_ui_dialog_1()
   RETURN
   #end add-point
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
 
   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   LET g_current_idx = 1
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   LET g_current_row_tot = 0
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"

   CALL axrq380_query()
   #end add-point
 
   
   CALL axrq380_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xrca_d.clear()
         CALL g_xrca2_d.clear()
 
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 0
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL axrq380_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
 
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         
         #end add-point
     
         DISPLAY ARRAY g_xrca_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axrq380_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL axrq380_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
 
         #end add-point
 
         DISPLAY ARRAY g_xrca2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 2
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body2.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL axrq380_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
            NEXT FIELD xrcasite
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
            
            #end add-point
            
         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG 
      
         ON ACTION close
            LET INT_FLAG=FALSE
            LET li_exit = TRUE
            EXIT DIALOG
 
         ON ACTION accept
            INITIALIZE g_wc_filter TO NULL
            IF cl_null(g_wc) THEN
               LET g_wc = " 1=1"
            END IF
 
 
         
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF
 
 
 
            #add-point:ON ACTION accept name="ui_dialog.accept"
            
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL axrq380_b_fill()
 
            IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = -100
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            END IF
 
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"
            
            #end add-point
            CALL cl_user_overview()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_xrca_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_xrca2_d)
               LET g_export_id[2]   = "s_detail2"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL axrq380_b_fill()
 
         ON ACTION qbehidden     #qbe頁籤折疊
            IF g_qbe_hidden THEN
               CALL gfrm_curr.setElementHidden("qbe",0)
               CALL gfrm_curr.setElementImage("qbehidden","16/mainhidden.png")
               LET g_qbe_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("qbe",1)
               CALL gfrm_curr.setElementImage("qbehidden","16/worksheethidden.png")
               LET g_qbe_hidden = 1     #hidden
            END IF
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            CALL axrq380_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL axrq380_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL axrq380_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL axrq380_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_xrca_d.getLength()
               LET g_xrca_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_xrca_d.getLength()
               LET g_xrca_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_xrca_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xrca_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_xrca_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xrca_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axrq380_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query name="menu.query"
               CALL axrq380_query()
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
               #END add-point
               
               
            END IF
 
 
 
 
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"
         
         #end add-point
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            #add-point:條件清除後 name="ui_dialog.qbeclear"
            
            #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="axrq380.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrq380_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL axrq380_b_fill_1()
   CALL axrq380_b_fill_2()
   RETURN
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
 
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:34) add cl_sql_auth_filter()
 
   CALL g_xrca_d.clear()
   CALL g_xrca2_d.clear()
 
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',xrca001,xrcadocno,xrcadocdt,xrca007,'',xrca004,'',xrca005,'', 
       xrca014,'',xrca009,xrca010,xrca100,xrca101,'','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY xrca_t.xrcald, 
       xrca_t.xrcadocno) AS RANK FROM xrca_t",
 
 
                     "",
                     " WHERE xrcaent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xrca_t"),
                     " ORDER BY xrca_t.xrcald,xrca_t.xrcadocno"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql  #總筆數
   EXECUTE b_fill_cnt_pre USING g_enterprise INTO g_tot_cnt
   FREE b_fill_cnt_pre
 
   #add-point:b_fill段rank_sql_after_count name="b_fill.rank_sql_after_count"
   
   #end add-point
 
   CASE g_detail_page_action
      WHEN "detail_first"
          LET g_pagestart = 1
 
      WHEN "detail_previous"
          LET g_pagestart = g_pagestart - g_num_in_page
          IF g_pagestart < 1 THEN
              LET g_pagestart = 1
          END IF
 
      WHEN "detail_next"
         LET g_pagestart = g_pagestart + g_num_in_page
         IF g_pagestart > g_tot_cnt THEN
            LET g_pagestart = g_tot_cnt - (g_tot_cnt mod g_num_in_page) + 1
            WHILE g_pagestart > g_tot_cnt
               LET g_pagestart = g_pagestart - g_num_in_page
            END WHILE
         END IF
 
      WHEN "detail_last"
         LET g_pagestart = g_tot_cnt - (g_tot_cnt mod g_num_in_page) + 1
         WHILE g_pagestart > g_tot_cnt
            LET g_pagestart = g_pagestart - g_num_in_page
         END WHILE
 
      OTHERWISE
         LET g_pagestart = 1
 
   END CASE
 
   LET g_sql = "SELECT '',xrca001,xrcadocno,xrcadocdt,xrca007,'',xrca004,'',xrca005,'',xrca014,'',xrca009, 
       xrca010,xrca100,xrca101,'','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axrq380_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axrq380_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_xrca_d[l_ac].sel,g_xrca_d[l_ac].xrca001,g_xrca_d[l_ac].xrcadocno,g_xrca_d[l_ac].xrcadocdt, 
       g_xrca_d[l_ac].xrca007,g_xrca_d[l_ac].xrca007_desc,g_xrca_d[l_ac].xrca004,g_xrca_d[l_ac].xrca004_desc, 
       g_xrca_d[l_ac].xrca005,g_xrca_d[l_ac].xrca005_desc,g_xrca_d[l_ac].xrca014,g_xrca_d[l_ac].xrca014_desc, 
       g_xrca_d[l_ac].xrca009,g_xrca_d[l_ac].xrca010,g_xrca_d[l_ac].xrca100,g_xrca_d[l_ac].xrca101,g_xrca_d[l_ac].xrca103, 
       g_xrca_d[l_ac].xrcc108,g_xrca_d[l_ac].xrcc118,g_xrca2_d[l_ac].xrcedocno,g_xrca2_d[l_ac].xrcadocdt, 
       g_xrca2_d[l_ac].xrce002,g_xrca2_d[l_ac].xrce109,g_xrca2_d[l_ac].xrce119
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL axrq380_detail_show("'1'")
 
      CALL axrq380_xrca_t_mask()
 
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
      LET l_ac = l_ac + 1
 
   END FOREACH
 
 
 
 
 
   #應用 qs05 樣板自動產生(Version:4)
   #+ b_fill段其他table資料取得(包含sql組成及資料填充)
 
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   CALL g_xrca_d.deleteElement(g_xrca_d.getLength())
   CALL g_xrca2_d.deleteElement(g_xrca2_d.getLength())
 
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_xrca_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE axrq380_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axrq380_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axrq380_detail_action_trans()
 
   LET l_ac = 1
   IF g_xrca_d.getLength() > 0 THEN
      CALL axrq380_b_fill2()
   END IF
 
      CALL axrq380_filter_show('xrca001','b_xrca001')
   CALL axrq380_filter_show('xrcadocno','b_xrcadocno')
   CALL axrq380_filter_show('xrcadocdt','b_xrcadocdt')
   CALL axrq380_filter_show('xrca007','b_xrca007')
   CALL axrq380_filter_show('xrca004','b_xrca004')
   CALL axrq380_filter_show('xrca005','b_xrca005')
   CALL axrq380_filter_show('xrca014','b_xrca014')
   CALL axrq380_filter_show('xrca009','b_xrca009')
   CALL axrq380_filter_show('xrca010','b_xrca010')
   CALL axrq380_filter_show('xrca100','b_xrca100')
   CALL axrq380_filter_show('xrca101','b_xrca101')
 
 
END FUNCTION
 
{</section>}
 
{<section id="axrq380.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrq380_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   RETURN
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   
   #end add-point
 
 
 
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   
   #end add-point
 
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="axrq380.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axrq380_detail_show(ps_page)
   #add-point:show段define-客製 name="detail_show.define_customerization"
   
   #end add-point
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
 
   #add-point:detail_show段之前 name="detail_show.before"
   
   #end add-point
 
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference name="detail_show.body.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"
      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
 
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq380.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION axrq380_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", TRUE)
 
   
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   #應用 qs08 樣板自動產生(Version:5)
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON xrca001,xrcadocno,xrcadocdt,xrca007,xrca004,xrca005,xrca014,xrca009,xrca010, 
          xrca100,xrca101
                          FROM s_detail1[1].b_xrca001,s_detail1[1].b_xrcadocno,s_detail1[1].b_xrcadocdt, 
                              s_detail1[1].b_xrca007,s_detail1[1].b_xrca004,s_detail1[1].b_xrca005,s_detail1[1].b_xrca014, 
                              s_detail1[1].b_xrca009,s_detail1[1].b_xrca010,s_detail1[1].b_xrca100,s_detail1[1].b_xrca101 
 
 
         BEFORE CONSTRUCT
                     DISPLAY axrq380_filter_parser('xrca001') TO s_detail1[1].b_xrca001
            DISPLAY axrq380_filter_parser('xrcadocno') TO s_detail1[1].b_xrcadocno
            DISPLAY axrq380_filter_parser('xrcadocdt') TO s_detail1[1].b_xrcadocdt
            DISPLAY axrq380_filter_parser('xrca007') TO s_detail1[1].b_xrca007
            DISPLAY axrq380_filter_parser('xrca004') TO s_detail1[1].b_xrca004
            DISPLAY axrq380_filter_parser('xrca005') TO s_detail1[1].b_xrca005
            DISPLAY axrq380_filter_parser('xrca014') TO s_detail1[1].b_xrca014
            DISPLAY axrq380_filter_parser('xrca009') TO s_detail1[1].b_xrca009
            DISPLAY axrq380_filter_parser('xrca010') TO s_detail1[1].b_xrca010
            DISPLAY axrq380_filter_parser('xrca100') TO s_detail1[1].b_xrca100
            DISPLAY axrq380_filter_parser('xrca101') TO s_detail1[1].b_xrca101
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_xrca001>>----
         #Ctrlp:construct.c.filter.page1.b_xrca001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca001
            #add-point:ON ACTION controlp INFIELD b_xrca001 name="construct.c.filter.page1.b_xrca001"
            
            #END add-point
 
 
         #----<<b_xrcadocno>>----
         #Ctrlp:construct.c.page1.b_xrcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcadocno
            #add-point:ON ACTION controlp INFIELD b_xrcadocno name="construct.c.filter.page1.b_xrcadocno"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            #161223-00022#1 mark-----s
            #INITIALIZE g_qryparam.* TO NULL
            #LET g_qryparam.state = 'c' 
            #LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " xrcald = '",g_input.xrcald,"'"  #161111-00049#1 Add
            #CALL q_xrcadocno()                         #呼叫開窗
            #DISPLAY g_qryparam.return1 TO b_xrcadocno  #顯示到畫面上
            #NEXT FIELD b_xrcadocno              #返回原欄位
            #161223-00022#1 mark-----e
            #161223-00022#1-----s
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF g_prog MATCHES 'axrq380' THEN
               LET g_qryparam.where = " xrcald = '",g_input.xrcald,"'"
               CALL q_xrcadocno()
            ELSE
               LET g_qryparam.where = " apcald = '",g_input.xrcald,"'",
                                      " AND apcastus <> 'X' "
               CALL q_apcadocno()
            END IF
            DISPLAY g_qryparam.return1 TO b_xrcadocno
            NEXT FIELD b_xrcadocno
            #161223-00022#1-----e
    



            #END add-point
 
 
         #----<<b_xrcadocdt>>----
         #Ctrlp:construct.c.filter.page1.b_xrcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcadocdt
            #add-point:ON ACTION controlp INFIELD b_xrcadocdt name="construct.c.filter.page1.b_xrcadocdt"
            
            #END add-point
 
 
         #----<<b_xrca007>>----
         #Ctrlp:construct.c.page1.b_xrca007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca007
            #add-point:ON ACTION controlp INFIELD b_xrca007 name="construct.c.filter.page1.b_xrca007"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #IF g_prog = "axrq380" THEN        #160705-00042#10 160713 by sakura mark
            IF g_prog MATCHES "axrq380" THEN   #160705-00042#10 160713 by sakura add
               LET g_qryparam.arg1 = "3111"
            ELSE
               LET g_qryparam.arg1 = "3211"
            END IF
            CALL q_oocq002()
            DISPLAY g_qryparam.return1 TO b_xrca007
            NEXT FIELD b_xrca007
            #END add-point
 
 
         #----<<xrca007_desc>>----
         #----<<b_xrca004>>----
         #Ctrlp:construct.c.page1.b_xrca004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca004
            #add-point:ON ACTION controlp INFIELD b_xrca004 name="construct.c.filter.page1.b_xrca004"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            # CALL q_pmaa001()   #160913-00017#7  mark
            #160913-00017#7--ADD(S)--
           #LET g_qryparam.arg1="('2','3')"   #161111-00049#1 Mark
            #161111-00049#1 Add  ---(S)---
            IF g_prog MATCHES 'axrq380' THEN
               LET g_qryparam.arg1="('2','3')"
            ELSE
               LET g_qryparam.arg1="('1','3')"
            END IF
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            #161111-00049#1 Add  ---(E)---
            CALL q_pmaa001_1()
            #160913-00017#7--ADD(E)--
            DISPLAY g_qryparam.return1 TO b_xrca004
            NEXT FIELD b_xrca004
            #END add-point
 
 
         #----<<xrca004_desc>>----
         #----<<b_xrca005>>----
         #Ctrlp:construct.c.page1.b_xrca005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca005
            #add-point:ON ACTION controlp INFIELD b_xrca005 name="construct.c.filter.page1.b_xrca005"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmac002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrca005  #顯示到畫面上
            NEXT FIELD b_xrca005                     #返回原欄位
    



            #END add-point
 
 
         #----<<xrca005_desc>>----
         #----<<b_xrca014>>----
         #Ctrlp:construct.c.page1.b_xrca014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca014
            #add-point:ON ACTION controlp INFIELD b_xrca014 name="construct.c.filter.page1.b_xrca014"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrca014  #顯示到畫面上
            NEXT FIELD b_xrca014                     #返回原欄位
    



            #END add-point
 
 
         #----<<xrca014_desc>>----
         #----<<b_xrca009>>----
         #Ctrlp:construct.c.filter.page1.b_xrca009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca009
            #add-point:ON ACTION controlp INFIELD b_xrca009 name="construct.c.filter.page1.b_xrca009"
            
            #END add-point
 
 
         #----<<b_xrca010>>----
         #Ctrlp:construct.c.filter.page1.b_xrca010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca010
            #add-point:ON ACTION controlp INFIELD b_xrca010 name="construct.c.filter.page1.b_xrca010"
            
            #END add-point
 
 
         #----<<b_xrca100>>----
         #Ctrlp:construct.c.page1.b_xrca100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca100
            #add-point:ON ACTION controlp INFIELD b_xrca100 name="construct.c.filter.page1.b_xrca100"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrca100  #顯示到畫面上
            NEXT FIELD b_xrca100                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_xrca101>>----
         #Ctrlp:construct.c.filter.page1.b_xrca101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca101
            #add-point:ON ACTION controlp INFIELD b_xrca101 name="construct.c.filter.page1.b_xrca101"
            
            #END add-point
 
 
         #----<<xrca103>>----
         #----<<xrcc108>>----
         #----<<xrcc118>>----
         #----<<xrcedocno>>----
         #----<<xrcadocdt>>----
         #Ctrlp:construct.c.filter.page2.xrcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcadocdt
            #add-point:ON ACTION controlp INFIELD xrcadocdt name="construct.c.filter.page2.xrcadocdt"
            
            #END add-point
 
 
         #----<<xrce002>>----
         #----<<xrce109>>----
         #----<<xrce119>>----
 
 
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog name="filter.b_dialog"
         
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
 
 
 
 
 
   
 
   #add-point:離開DIALOG後相關處理 name="filter.after_dialog"
   
   #end add-point
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
 
      CALL axrq380_filter_show('xrca001','b_xrca001')
   CALL axrq380_filter_show('xrcadocno','b_xrcadocno')
   CALL axrq380_filter_show('xrcadocdt','b_xrcadocdt')
   CALL axrq380_filter_show('xrca007','b_xrca007')
   CALL axrq380_filter_show('xrca004','b_xrca004')
   CALL axrq380_filter_show('xrca005','b_xrca005')
   CALL axrq380_filter_show('xrca014','b_xrca014')
   CALL axrq380_filter_show('xrca009','b_xrca009')
   CALL axrq380_filter_show('xrca010','b_xrca010')
   CALL axrq380_filter_show('xrca100','b_xrca100')
   CALL axrq380_filter_show('xrca101','b_xrca101')
 
 
   CALL axrq380_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq380.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION axrq380_filter_parser(ps_field)
   #add-point:filter段define-客製 name="filter_parser.define_customerization"
   
   #end add-point
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_parser.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter_parser.before_function"
   
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
 
{<section id="axrq380.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION axrq380_filter_show(ps_field,ps_object)
   #add-point:filter_show段define-客製 name="filter_show.define_customerization"
   
   #end add-point
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
   #add-point:filter_show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter_show.before_function"
   
   #end add-point
 
   LET ls_name = "formonly.", ps_object
 
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LET ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = axrq380_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="axrq380.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axrq380_detail_action_trans()
   #add-point:detail_action_trans段define-客製 name="detail_action_trans.define_customerization"
   
   #end add-point
   #add-point:detail_action_trans段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_action_trans.define"
   
   #end add-point
 
 
   #add-point:FUNCTION前置處理 name="detail_action_trans.before_function"
   
   #end add-point
 
   #因應單身切頁功能，筆數計算方式調整
   LET g_current_row_tot = g_pagestart + g_detail_idx - 1
   DISPLAY g_current_row_tot TO FORMONLY.h_index
   DISPLAY g_tot_cnt TO FORMONLY.h_count
 
   #顯示單身頁面的起始與結束筆數
   LET g_page_start_num = g_pagestart
   LET g_page_end_num = g_pagestart + g_num_in_page - 1
   DISPLAY g_page_start_num TO FORMONLY.p_start
   DISPLAY g_page_end_num TO FORMONLY.p_end
 
   #目前不支援跳頁功能
   LET g_page_act_list = "detail_first,detail_previous,'',detail_next,detail_last"
   CALL cl_navigator_detail_page_setting(g_page_act_list,g_current_row_tot,g_pagestart,g_num_in_page,g_tot_cnt)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq380.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axrq380_detail_index_setting()
   #add-point:detail_index_setting段define-客製 name="detail_index_setting.define_customerization"
   
   #end add-point
   DEFINE li_redirect     BOOLEAN
   DEFINE ldig_curr       ui.Dialog
   #add-point:detail_index_setting段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_index_setting.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_index_setting.before_function"
   
   #end add-point
 
   IF g_curr_diag IS NOT NULL THEN
      CASE
         WHEN g_curr_diag.getCurrentRow("s_detail1") <= "0"
            LET g_detail_idx = 1
            IF g_xrca_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_xrca_d.getLength() AND g_xrca_d.getLength() > 0
            LET g_detail_idx = g_xrca_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_xrca_d.getLength() THEN
               LET g_detail_idx = g_xrca_d.getLength()
            END IF
            LET li_redirect = TRUE
      END CASE
   END IF
 
   IF li_redirect THEN
      LET ldig_curr = ui.Dialog.getCurrent()
      CALL ldig_curr.setCurrentRow("s_detail1", g_detail_idx)
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axrq380.mask_functions" >}
 &include "erp/axr/axrq380_mask.4gl"
 
{</section>}
 
{<section id="axrq380.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 单身一查询
# Memo...........:
# Usage..........: CALL axrq380_query()
# Date & Author..: 2016/05/16 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq380_query()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_wc1     STRING #160811-00009#2 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_xrca_d.clear()
   CALL g_xrca2_d.clear()

   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_wc_filter = " 1=1"
   LET g_detail_page_action = ""
   LET g_pagestart = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET ls_wc2 = g_wc2
   LET g_master_idx = l_ac  

   CALL cl_set_comp_visible("xrca004_desc,xrca007_desc,xrca014_desc,xrca005_desc",FALSE)
   CALL cl_set_comp_visible("b_xrca004,b_xrca007,b_xrca014,b_xrca005",TRUE)
      
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
         CONSTRUCT g_wc_table ON xrca001,xrcadocno,xrcadocdt,xrca007,xrca004,xrca005,xrca014,xrca009,xrca010,xrca100
                            FROM s_detail1[1].b_xrca001,s_detail1[1].b_xrcadocno,s_detail1[1].b_xrcadocdt, 
                                 s_detail1[1].b_xrca007,s_detail1[1].b_xrca004,s_detail1[1].b_xrca005,s_detail1[1].b_xrca014, 
                                 s_detail1[1].b_xrca009,s_detail1[1].b_xrca010,s_detail1[1].b_xrca100    
 
         BEFORE CONSTRUCT

         ON ACTION controlp INFIELD b_xrcadocno
            #161223-00022#1 mark-----s
            #INITIALIZE g_qryparam.* TO NULL
            #LET g_qryparam.state = 'c'
            #LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " xrcald = '",g_input.xrcald,"'"  #161111-00049#1 Add
            #CALL q_xrcadocno()                            
            #DISPLAY g_qryparam.return1 TO b_xrcadocno   
            #NEXT FIELD b_xrcadocno                           
            #161223-00022#1 mark-----e
            #161223-00022#1-----s
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF g_prog MATCHES 'axrq380' THEN
               LET g_qryparam.where = " xrcald = '",g_input.xrcald,"'"
               CALL q_xrcadocno()
            ELSE
               LET g_qryparam.where = " apcald = '",g_input.xrcald,"'",
                                      " AND apcastus <> 'X' "
               CALL q_apcadocno()
            END IF
            DISPLAY g_qryparam.return1 TO b_xrcadocno
            NEXT FIELD b_xrcadocno           
            #161223-00022#1-----e
         
        ON ACTION controlp INFIELD b_xrca007
           INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'c'
	    	  LET g_qryparam.reqry = FALSE
            #IF g_prog = "axrq380" THEN        #160705-00042#10 160713 by sakura mark
            IF g_prog MATCHES "axrq380" THEN   #160705-00042#10 160713 by sakura add
               LET g_qryparam.arg1 = "3111"
            ELSE
               LET g_qryparam.arg1 = "3211"
            END IF   
           CALL q_oocq002()                            
           DISPLAY g_qryparam.return1 TO b_xrca007   
           NEXT FIELD b_xrca007                      

        ON ACTION controlp INFIELD b_xrca004
		   INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'c'
		   LET g_qryparam.reqry = FALSE
		   #LET g_qryparam.where =" (pmaa002 ='2' OR pmaa002='3')"  #160731-00372#1 2016/08/16 By 07900 add  #160913-00017#7  mark
           IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
              LET g_qryparam.where = g_sql_ctrl
           END IF
           # CALL q_pmaa001()   #160913-00017#7  mark                  #呼叫開窗
            #160913-00017#7--ADD(S)--
           #LET g_qryparam.arg1="('2','3')"   #161111-00049#1 Mark
            #161111-00049#1 Add  ---(S)---
            IF g_prog MATCHES 'axrq380' THEN
               LET g_qryparam.arg1="('2','3')"
            ELSE
               LET g_qryparam.arg1="('1','3')"
            END IF
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            #161111-00049#1 Add  ---(E)---
            CALL q_pmaa001_1()
            #160913-00017#7--ADD(E)--                         
           DISPLAY g_qryparam.return1 TO b_xrca004  
           NEXT FIELD b_xrca004    
           
        ON ACTION controlp INFIELD b_xrca005
		   INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'c'
		   LET g_qryparam.reqry = FALSE
           IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
              LET g_qryparam.where = " EXISTS (SELECT 1 FROM pmaa_t ",
                                     "          WHERE pmaaent = ",g_enterprise,
                                     "            AND ",g_sql_ctrl,
                                     "            AND pmaaent = pmacent ",
                                     "            AND pmaa001 = pmac002 )"
           END IF
           CALL q_pmac002_1()                            
           DISPLAY g_qryparam.return1 TO b_xrca005   
           NEXT FIELD b_xrca005 
           
        ON ACTION controlp INFIELD b_xrca014
		   INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'c'
		   LET g_qryparam.reqry = FALSE
           CALL q_ooag001()                           
           DISPLAY g_qryparam.return1 TO b_xrca014  
           NEXT FIELD b_xrca014               
           
        ON ACTION controlp INFIELD b_xrca100
           INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'c'
           LET g_qryparam.reqry = FALSE
           CALL q_aooi001()                           
           DISPLAY g_qryparam.return1 TO b_xrca100   
           NEXT FIELD b_xrca100                             
        
         END CONSTRUCT

         INPUT BY NAME g_input.xrcasite,g_input.xrcald,g_input.edata,g_input.a  
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            BEFORE INPUT
               CALL axrq380_def()
            
            AFTER FIELD xrcasite
               #LET g_input.xrcasite_desc = ''
               #IF NOT cl_null(g_input.xrcasite) AND NOT cl_null(g_input.xrcald) THEN #161021-00050#5 mark
               IF NOT cl_null(g_input.xrcasite) THEN   #161021-00050#5 add
                  CALL s_fin_account_center_with_ld_chk(g_input.xrcasite,g_input.xrcald,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  LET g_input.xrcasite_desc = s_desc_get_department_desc(g_input.xrcasite)
                  DISPLAY BY NAME g_input.xrcasite_desc
               END IF               
               
            AFTER FIELD xrcald
               #LET g_input.xrcald_desc = ''
               IF NOT cl_null(g_input.xrcald) AND NOT cl_null(g_input.xrcasite) THEN
                  #CALL s_fin_account_center_with_ld_chk(g_input.xrcasite,g_input.xrcald,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno #160812-00027#2 mark
                  CALL s_fin_account_center_with_ld_chk(g_input.xrcasite,g_input.xrcald,g_user,'3','Y','',g_today) RETURNING g_sub_success,g_errno  #160812-00027#2 add
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF                  
                  LET g_input.xrcald_desc = s_desc_get_ld_desc(g_input.xrcald)
                  DISPLAY BY NAME g_input.xrcald_desc
                  CALL axrq380_get_control()   #161111-00049#1 Add
               END IF  
               
            ON ACTION controlp INFIELD xrcasite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.xrcasite
               #LET g_qryparam.where = " ooef201 = 'Y' "  #160812-00027#2 mark
               #CALL q_ooef001()                          #161021-00050#5 mark
               CALL q_ooef001_46()                        #161021-00050#5 add
               LET g_input.xrcasite = g_qryparam.return1
               CALL s_desc_get_department_desc(g_input.xrcasite) RETURNING g_input.xrcasite_desc        
               DISPLAY BY NAME g_input.xrcasite,g_input.xrcasite_desc 
               NEXT FIELD xrcasite                  
               
            ON ACTION controlp INFIELD xrcald
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               CALL s_fin_create_account_center_tmp() #160812-00027#2 add
               CALL s_fin_account_center_sons_query('3',g_input.xrcasite,g_today,'1')
               #160811-00009#2 mod s---
               #CALL s_fin_account_center_ld_str() RETURNING g_wc_xrcald
               #CALL s_fin_get_wc_str(g_wc_xrcald) RETURNING g_wc_xrcald   
               #取得帳務組織下所屬成員之帳別   
               CALL s_fin_account_center_comp_str() RETURNING ls_wc1  
               #將取回的字串轉換為SQL條件
               CALL s_fin_get_wc_str(ls_wc1) RETURNING ls_wc1   
               #160811-00009#2 mod e---               
               #LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaald IN ",g_wc_xrcald #160811-00009#2 
                LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",ls_wc1,""   #160811-00009#2 
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept        
               CALL q_authorised_ld()                 #160812-00027#2 add 補上元件:無呼叫開窗元件,因此畫面上無法開窗        
               DISPLAY g_qryparam.return1 TO xrcald   
               NEXT FIELD xrcald              
            
         END INPUT 
         
      BEFORE DIALOG
         CALL cl_qbe_init()
        
         LET g_xrca_d[1].sel=""
         DISPLAY ARRAY g_xrca_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY

      #end add-point 
 
      ON ACTION accept
         #add-point:ON ACTION accept name="query.accept"

         #end add-point
 
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
 
      #add-point:query段查詢方案相關ACTION設定前 name="query.set_qbe_action_before"

      #end add-point 
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM         
       
           
      END DIALOG
      
  LET g_wc = g_wc_table 
 
 
   
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
 
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = " 1=2"
      LET g_wc2 = " 1=2"
      LET g_wc_filter = g_wc_filter_t
      RETURN
   ELSE
      LET g_master_idx = 1
   END IF
        
   #add-point:cs段after_construct name="cs.after_construct"
   IF cl_null(g_wc) THEN
      LET g_wc=' 1=1'
   END IF
   #end add-point
        
   LET g_error_show = 1
   CALL axrq380_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
#   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)  
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)      
END FUNCTION

################################################################################
# Descriptions...: ui_dialog
# Memo...........:
# Usage..........: CALL axrq380_ui_dialog_1() 
# Date & Author..: 2016/05/16 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq380_ui_dialog_1()
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"

   #end add-point
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10
   DEFINE ls_result STRING
   DEFINE ls_wc     STRING
   DEFINE lc_action_choice_old   STRING
   DEFINE ls_js     STRING
   DEFINE la_param  RECORD
                    prog       STRING,
                    actionid   STRING,
                    background LIKE type_t.chr1,
                    param      DYNAMIC ARRAY OF STRING
                    END RECORD
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_xrca001 LIKE xrca_t.xrca001
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   
   #end add-point
 
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
 
 
   
   
   
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL axrq380_b_fill()
   ELSE
      CALL axrq380_query()
   END IF
 
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xrca_d.clear()
         CALL g_xrca2_d.clear()
 
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 0
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL axrq380_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"

         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         
         #end add-point
     
         DISPLAY ARRAY g_xrca_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axrq380_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL axrq380_b_fill_2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
   
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"

            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"

         #end add-point
 
         DISPLAY ARRAY g_xrca2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 2
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body2.before_row"

               #end add-point
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"

            #end add-point
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"

         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL axrq380_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
           
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"

            #end add-point
            
         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG 
      
         ON ACTION close
            LET INT_FLAG=FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG
 
#         ON ACTION accept
#            INITIALIZE g_wc_filter TO NULL
#            IF cl_null(g_wc) THEN
#               LET g_wc = " 1=1"
#            END IF
 
 
         
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF
 
 
 
            #add-point:ON ACTION accept name="ui_dialog.accept"

            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL axrq380_b_fill()
 
            IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = -100
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            END IF
 
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"

            #end add-point
            CALL cl_user_overview()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_xrca_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_xrca2_d)
               LET g_export_id[2]   = "s_detail2"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"

               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 

            
         ON ACTION datarefresh   # 重新整理
            CALL axrq380_b_fill()
 
         ON ACTION qbehidden     #qbe頁籤折疊
            IF g_qbe_hidden THEN
               CALL gfrm_curr.setElementHidden("qbe",0)
               CALL gfrm_curr.setElementImage("qbehidden","16/mainhidden.png")
               LET g_qbe_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("qbe",1)
               CALL gfrm_curr.setElementImage("qbehidden","16/worksheethidden.png")
               LET g_qbe_hidden = 1     #hidden
            END IF
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            CALL axrq380_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL axrq380_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL axrq380_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL axrq380_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
#         ON ACTION selall
#            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
#            FOR li_idx = 1 TO g_xrca_d.getLength()
#               LET g_xrca_d[li_idx].sel = "Y"
#            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"

            #end add-point
 
#         #取消全部
#         ON ACTION selnone
#            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
#            FOR li_idx = 1 TO g_xrca_d.getLength()
#               LET g_xrca_d[li_idx].sel = "N"
#            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"

            #end add-point
 
#         #勾選所選資料
#         ON ACTION sel
#            FOR li_idx = 1 TO g_xrca_d.getLength()
#               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
#                  LET g_xrca_d[li_idx].sel = "Y"
#               END IF
#            END FOR
# 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"

            #end add-point
 
#         #取消所選資料
#         ON ACTION unsel
#            FOR li_idx = 1 TO g_xrca_d.getLength()
#               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
#                  LET g_xrca_d[li_idx].sel = "N"
#               END IF
#            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"

            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axrq380_filter()
            #add-point:ON ACTION filter name="menu.filter"

            #END add-point
            EXIT DIALOG
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               
               #add-point:ON ACTION insert name="menu.insert"

               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
          ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
                  #創建臨時表
                  #為臨時表加數據
                  #IF g_prog = 'axrq380' THEN        #160705-00042#10 160713 by sakura mark
                  IF g_prog MATCHES 'axrq380' THEN   #160705-00042#10 160713 by sakura add
                     CALL axrq380_x01(g_wc,g_input.xrcasite,g_input.xrcald,g_input.edata,g_input.a)   
                  ELSE
                     CALL axrq380_x02(g_wc,g_input.xrcasite,g_input.xrcald,g_input.edata,g_input.a) 
                  END IF 
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query name="menu.query"
               CALL axrq380_query()
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"

               #END add-point
               
               
            END IF
 
 
          ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify_detail") THEN
              #IF g_prog = 'axrq380' THEN        #160705-00042#10 160713 by sakura mark
              IF g_prog MATCHES 'axrq380' THEN   #160705-00042#10 160713 by sakura add
               IF g_detail_idx>=1 THEN
                  INITIALIZE la_param.* TO NULL
                  CASE 
                     WHEN g_xrca_d[g_detail_idx].xrca001='12' OR g_xrca_d[g_detail_idx].xrca001='17'
                        LET la_param.prog = 'axrt300'
                     WHEN g_xrca_d[g_detail_idx].xrca001='11' OR g_xrca_d[g_detail_idx].xrca001='15'
                        LET la_param.prog = 'axrt310' 
                     WHEN g_xrca_d[g_detail_idx].xrca001='01' OR g_xrca_d[g_detail_idx].xrca001='02'
                       OR g_xrca_d[g_detail_idx].xrca001='03' OR g_xrca_d[g_detail_idx].xrca001='04'
                       OR g_xrca_d[g_detail_idx].xrca001='05' OR g_xrca_d[g_detail_idx].xrca001='06'
                        LET la_param.prog = 'axrt320'
                     WHEN g_xrca_d[g_detail_idx].xrca001='19' 
                        LET la_param.prog = 'axrt330'   
                     WHEN g_xrca_d[g_detail_idx].xrca001='22'    
                        LET la_param.prog = 'axrt340' 
                     WHEN g_xrca_d[g_detail_idx].xrca001='29'
                        LET la_param.prog = 'axrt341' 
                     WHEN g_xrca_d[g_detail_idx].xrca001='21'
                        LET la_param.prog = 'axrq342'                          
                     WHEN g_xrca_d[g_detail_idx].xrca001='24'
                        LET la_param.prog = 'axrq343'   
                     WHEN g_xrca_d[g_detail_idx].xrca001='18' 
                        LET la_param.prog = 'axrt210'                        
#                     WHEN g_xrca_d[g_detail_idx].xrca001='142' 
#                        LET la_param.prog = 'axrt380'                                              
                  END CASE
                  LET la_param.param[1] = g_input.xrcald
                  LET la_param.param[2] = g_xrca_d[g_detail_idx].xrcadocno         
               END IF  
              ELSE
               IF g_detail_idx>=1 THEN
                  INITIALIZE la_param.* TO NULL
                  CASE 
                     WHEN g_xrca_d[g_detail_idx].xrca001='13' OR g_xrca_d[g_detail_idx].xrca001='17'
                        LET la_param.prog = 'aapt300'
                     WHEN g_xrca_d[g_detail_idx].xrca001='14' OR g_xrca_d[g_detail_idx].xrca001='11' 
                        LET la_param.prog = 'aapt310' 
                     WHEN g_xrca_d[g_detail_idx].xrca001='01' OR g_xrca_d[g_detail_idx].xrca001='02'
                       OR g_xrca_d[g_detail_idx].xrca001='03' OR g_xrca_d[g_detail_idx].xrca001='04'
                        LET la_param.prog = 'aapt320'
                     WHEN g_xrca_d[g_detail_idx].xrca001='19' 
                        LET la_param.prog = 'aapt300'        
                     WHEN g_xrca_d[g_detail_idx].xrca001='15'  
                        LET la_param.prog = 'aapt330' 
                     WHEN g_xrca_d[g_detail_idx].xrca001='12'  
                        LET la_param.prog = 'aapt331'                           
                     WHEN g_xrca_d[g_detail_idx].xrca001='29'
                        LET la_param.prog = 'aapt340'                       
                     WHEN g_xrca_d[g_detail_idx].xrca001='22'
                        LET la_param.prog = 'aapt340'                      
                     WHEN g_xrca_d[g_detail_idx].xrca001='21' OR g_xrca_d[g_detail_idx].xrca001='23' OR g_xrca_d[g_detail_idx].xrca001='25'
                        LET la_param.prog = 'aapq342'                          
                     WHEN g_xrca_d[g_detail_idx].xrca001='24'
                        LET la_param.prog = 'aapq343'   
                     WHEN g_xrca_d[g_detail_idx].xrca001='18' 
                        LET la_param.prog = 'aapt210'                                                 
                  END CASE
                  CASE 
                    WHEN g_xrca_d[g_detail_idx].xrca001 = '19' or g_xrca_d[g_detail_idx].xrca001 = "29"   #aapt301 aapt341  
                         LET la_param.param[1] = '1'              
                         LET la_param.param[2] = g_input.xrcald
                         LET la_param.param[3] = g_xrca_d[g_detail_idx].xrcadocno  
                    WHEN g_xrca_d[g_detail_idx].xrca001 = "13" or g_xrca_d[g_detail_idx].xrca001 = "22" 
                      or g_xrca_d[g_detail_idx].xrca001 = "17"   #aapt300 aapt340  
                         LET la_param.param[1] = '1=1'              
                         LET la_param.param[2] = g_input.xrcald
                         LET la_param.param[3] = g_xrca_d[g_detail_idx].xrcadocno  
                     
                    
                  OTHERWISE
                      LET la_param.param[1] = g_input.xrcald
                      LET la_param.param[2] = g_xrca_d[g_detail_idx].xrcadocno                             
                  END CASE
                END IF  
               END IF
               LET ls_js = util.JSON.stringify( la_param )
               CALL cl_cmdrun_wait(ls_js) 
               #EXIT DIALOG
            END IF
 
          ON ACTION modify_detail_1
            LET g_action_choice="modify_detail_1"
            IF cl_auth_chk_act("modify_detail_1") THEN
              IF g_xrca2_d[g_detail_idx2].xrce002 !='5' AND g_xrca2_d[g_detail_idx2].xrce002 !='6' THEN 
              #IF g_prog = 'axrq380' THEN        #160705-00042#10 160713 by sakura mark
              IF g_prog MATCHES 'axrq380' THEN   #160705-00042#10 160713 by sakura add
               IF g_detail_idx2>=1 THEN
                  INITIALIZE la_param.* TO NULL 
                  LET l_xrca001 = NULL                  
                  CASE
                     WHEN g_xrca2_d[g_detail_idx2].xrce002 = '1' OR g_xrca2_d[g_detail_idx2].xrce002 = '3'  
                        SELECT xrca001 INTO l_xrca001 FROM xrca_t 
                         #WHERE xrcadocno = g_xrca2_d[g_detail_idx2].xrcedocno #160905-00002#7 mark 
                         WHERE xrcaent = g_enterprise #160905-00002#7
                           AND xrcadocno = g_xrca2_d[g_detail_idx2].xrcedocno  #160905-00002#7                    
                           AND xrcald = g_input.xrcald
                        CASE  
                           WHEN l_xrca001 = '12' OR l_xrca001 = '17'
                             LET la_param.prog = "axrt300" 
                           WHEN l_xrca001 = '11' OR l_xrca001 = '15'
                             LET la_param.prog = "axrt310"
                           WHEN l_xrca001 = '01' OR l_xrca001 = '02' 
                             OR l_xrca001 = '03' OR l_xrca001 = '04' 
                             OR l_xrca001 = '05' OR l_xrca001 = '06' 
                             LET la_param.prog = "axrt320"
                           WHEN l_xrca001 = '19' 
                             LET la_param.prog = "axrt330"
                           WHEN l_xrca001 = '22' 
                             LET la_param.prog = "axrt340"  
                           WHEN l_xrca001 = '29' 
                             LET la_param.prog = "axrt341"                         
#                           WHEN l_xrca001 ='142' 
#                              LET la_param.prog = 'axrt380'                              
                        END CASE
                  
                     WHEN g_xrca2_d[g_detail_idx2].xrce002 = '4'     
                        LET la_param.prog = "aapt420"
                     WHEN g_xrca2_d[g_detail_idx2].xrce002 = '2'     
                        LET la_param.prog = "axrt400" 
                  END CASE                        
                        
                  LET la_param.param[1] = g_input.xrcald
                  LET la_param.param[2] = g_xrca2_d[g_detail_idx2].xrcedocno         
                  
               END IF
              ELSE
               IF g_detail_idx2>=1 THEN
                  INITIALIZE la_param.* TO NULL 
                  LET l_xrca001 = NULL                    
                  CASE
                     WHEN g_xrca2_d[g_detail_idx2].xrce002 = '1' OR g_xrca2_d[g_detail_idx2].xrce002 = '3'  
                        SELECT apca001 INTO l_xrca001 FROM apca_t 
                         #WHERE apcadocno = g_xrca2_d[g_detail_idx2].xrcedocno #160905-00002#7 mark
                         WHERE apcaent = g_enterprise #160905-00002#7
                           AND apcadocno = g_xrca2_d[g_detail_idx2].xrcedocno #160905-00002#7                        
                           AND apcald = g_input.xrcald
                        CASE  
                           WHEN l_xrca001 = '13' OR l_xrca001 = '17'
                             LET la_param.prog = "aapt300" 
                           WHEN l_xrca001 = '11' OR l_xrca001 = '14'
                             LET la_param.prog = "aapt310"
                           WHEN l_xrca001 = '01' OR l_xrca001 = '02' OR l_xrca001 = '03' OR l_xrca001 = '04' 
                             LET la_param.prog = "aapt320"
                           WHEN l_xrca001 = '19' 
                             LET la_param.prog = "aapt300" 
                           WHEN l_xrca001 = '15' 
                             LET la_param.prog = "aapt330"      
                           WHEN l_xrca001 = '12'  
                             LET la_param.prog = "aapt331"                              
                           WHEN l_xrca001 = '29' or l_xrca001 = '22' 
                             LET la_param.prog = "aapt340"                         
                        END CASE
                  
                     WHEN g_xrca2_d[g_detail_idx2].xrce002 = '4'     
                        LET la_param.prog = "axrt400"
                     WHEN g_xrca2_d[g_detail_idx2].xrce002 = '2'     
                        LET la_param.prog = "aapt420" 
                  END CASE                        
                  CASE 
                    WHEN l_xrca001 = '19' or l_xrca001 = "29"   #aapt301 aapt341 
                         LET la_param.param[1] = '1'              
                         LET la_param.param[2] = g_input.xrcald
                         LET la_param.param[3] = g_xrca2_d[g_detail_idx2].xrcedocno  
                    WHEN l_xrca001 = '13' OR l_xrca001 = '17'  or l_xrca001 = '22'   #aapt300 aapt340 
                         LET la_param.param[1] = '1=1'              
                         LET la_param.param[2] = g_input.xrcald
                         LET la_param.param[3] = g_xrca2_d[g_detail_idx2].xrcedocno  
                                              
                  OTHERWISE
                      LET la_param.param[1] = g_input.xrcald
                      LET la_param.param[2] = g_xrca2_d[g_detail_idx2].xrcedocno                             
                  END CASE
               END IF              
              END IF
               LET ls_js = util.JSON.stringify( la_param )
               CALL cl_cmdrun_wait(ls_js) 
               #EXIT DIALOG
            END IF
           END IF 
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"

         #end add-point
 
#         ON ACTION qbeclear   # 條件清除
#            CLEAR FORM
            #add-point:條件清除後 name="ui_dialog.qbeclear"

            #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"

         #end add-point
 
      END DIALOG 
   
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION

################################################################################
# Descriptions...: 初始值
# Memo...........:
# Usage..........: CALL axrq380_def()
# Date & Author..: 2015/05/13 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq380_def()
DEFINE l_xrcacomp   LIKE xrca_t.xrcacomp
DEFINE l_success    LIKE type_t.chr1

   #IF cl_null(g_input.xrcasite) OR cl_null(g_input.xrcald) THEN
      #帳務中心
      #取得預設的帳務中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
      CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING l_success,g_input.xrcasite,g_errno
      #該帳務中心與帳別無法勾稽到,以登入人員g_user取得預設帳別/法人
      CALL s_fin_orga_get_comp_ld(g_input.xrcasite) RETURNING l_success,g_errno,l_xrcacomp,g_input.xrcald   

      #若取不出資料，則預設帳別/法人為空
      IF NOT l_success THEN
         LET g_input.xrcald   = ''
      END IF

      #用帳務中心取得帳別與法人
      IF cl_null(g_input.xrcald) THEN
         CALL s_fin_orga_get_comp_ld(g_input.xrcasite) RETURNING l_success,g_errno,l_xrcacomp,g_input.xrcald
         CALL s_fin_account_center_with_ld_chk(g_input.xrcasite,g_input.xrcald,g_user,'3','N','',g_today) RETURNING l_success,g_errno
      END IF

      #若取不出資料,則不預設帳別
      IF NOT l_success THEN
         LET g_input.xrcald   = ''
      END IF

      CALL s_desc_get_ld_desc(g_input.xrcald) RETURNING g_input.xrcald_desc
      CALL s_desc_get_department_desc(g_input.xrcasite) RETURNING g_input.xrcasite_desc
      DISPLAY g_input.xrcasite TO xrcasite  
      DISPLAY g_input.xrcasite_desc TO xrcasite_desc
      DISPLAY g_input.xrcald TO xrcald
      DISPLAY g_input.xrcald_desc TO xrcald_desc
   #END IF
   
   LET g_input.a = 'N'
   LET g_input.edata = g_today
   
   CALL axrq380_get_control()   #161111-00049#1 Add
   
   IF NOT cl_null(g_argv[01]) AND NOT cl_null(g_argv[02]) AND NOT cl_null(g_argv[03]) THEN
      LET g_input.a = 'Y'
      LET g_input.xrcasite = g_argv[03]
      LET g_input.xrcald = g_argv[01]      
   END IF
END FUNCTION

################################################################################
# Descriptions...: 单身填充
# Memo...........:
# Usage..........: axrq380_b_fill_1()
# Date & Author..: 2016/05/17 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq380_b_fill_1()
DEFINE l_xrce109   LIKE xrce_t.xrce109
DEFINE l_xrce119   LIKE xrce_t.xrce119
DEFINE l_wc        STRING

   #161111-00049#1 Add  ---(S)---
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET g_sql = g_sql," AND EXISTS (SELECT 1 FROM pmaa_t ",
                        "              WHERE pmaaent = ",g_enterprise,
                        "                AND ",g_sql_ctrl,
                        "                AND pmaaent = xrcaent ",
                        "                AND pmaa001 = xrca004 )"
   END IF
   #161111-00049#1 Add  ---(E)---

   LET l_wc = cl_replace_str(g_wc,"xrca","apca")
   #IF g_prog = 'axrq380' THEN        #160705-00042#10 160713 by sakura mark
   IF g_prog MATCHES 'axrq380' THEN   #160705-00042#10 160713 by sakura add
      #單身一
      LET g_sql = " SELECT UNIQUE 'N',xrca001,xrcadocno,xrcadocdt,",
                  "               xrca007,(SELECT oocql004 FROM oocql_t WHERE oocqlent = '",g_enterprise,"' AND oocql001 = '3111' AND oocql002 = xrca007 AND oocql003 = '",g_dlang,"'),",
                  "               xrca004,(SELECT pmaal004 FROM pmaal_t WHERE pmaalent='",g_enterprise,"' AND pmaal001=xrca004 AND pmaal002='",g_dlang,"'),",
                  "               xrca005,(SELECT pmaal004 FROM pmaal_t WHERE pmaalent='",g_enterprise,"' AND pmaal001=xrca004 AND pmaal002='",g_dlang,"'),",
                  "               xrca014,(SELECT ooag010 FROM ooag_t WHERE ooagent='",g_enterprise,"' AND ooag001=xrca014),",
                  "               xrca009,xrca010,xrca100,xrca101,",
                  "   CASE WHEN (xrca001 ='02' OR xrca001 = '04' OR xrca001 LIKE '2%') THEN AVG(xrca103+xrca104) * -1 ELSE AVG(xrca103+xrca104) END, ",
                  "   CASE WHEN (xrca001 ='02' OR xrca001 = '04' OR xrca001 LIKE '2%') THEN SUM(xrcc108-xrcc109) * -1 ELSE SUM(xrcc108-xrcc109) END, ",
                  "   CASE WHEN (xrca001 ='02' OR xrca001 = '04' OR xrca001 LIKE '2%') THEN SUM(xrcc118-xrcc119+xrcc113) * -1 ELSE SUM(xrcc118-xrcc119+xrcc113) END ",
                  "   FROM xrca_t,xrcc_t",
                  "   WHERE xrcaent=xrccent AND xrcald=xrccld AND xrcadocno=xrccdocno ",
                  "     AND xrcaent=",g_enterprise," AND xrcald='",g_input.xrcald,"'",
                  "     AND xrcasite = '",g_input.xrcasite,"'",
                  "     AND xrca001 NOT IN('141','142','14') ",
                  "     AND ",g_wc,
                  #161109-00048#1 Add  ---(S)---
                  "     AND xrcadocno IN ( ",
                  "      SELECT xrcadocno FROM xrca_t WHERE xrca001 NOT IN ('21','23') AND xrcaent = ",g_enterprise," AND xrcald='",g_input.xrcald,"' AND xrcasite = '",g_input.xrcasite,"'",
                  "       UNION ",
                  "      SELECT xrcadocno FROM xrca_t,xrcc_t WHERE xrcaent = xrccent AND xrcald = xrccld AND xrcadocno = xrccdocno AND xrca001 IN ('21','23') AND xrcc108 - xrcc109 > 0 ",
                  "         AND xrcaent = ",g_enterprise," AND xrcald='",g_input.xrcald,"' AND xrcasite = '",g_input.xrcasite,"'",
                  "         AND xrca018 IN (SELECT xrcadocno FROM xrca_t,xrcc_t WHERE xrcaent = xrccent AND xrcald = xrccld AND xrcadocno = xrccdocno  AND xrcc109 > 0))",
                  #161109-00048#1 Add  ---(E)---
                  "     AND xrcastus = 'Y' ",
                  "   GROUP BY xrca001,xrcadocno,xrcadocdt,xrca007,xrca004,xrca005,xrca014,xrca009,xrca010,xrca100,xrca101",
                  "   ORDER BY xrca001,xrcadocno,xrcadocdt,xrca007,xrca004,xrca005,xrca014,xrca009,xrca010,xrca100,xrca101"   
   ELSE
      LET g_sql = " SELECT UNIQUE 'N',apca001,apcadocno,apcadocdt,",
                  "               apca007,(SELECT oocql004 FROM oocql_t WHERE oocqlent = '",g_enterprise,"' AND oocql001 = '3211' AND oocql002 = apca007 AND oocql003 = '",g_dlang,"'),",
                  "               apca004,(SELECT pmaal004 FROM pmaal_t WHERE pmaalent='",g_enterprise,"' AND pmaal001=apca004 AND pmaal002='",g_dlang,"'),",
                  "               apca005,(SELECT pmaal004 FROM pmaal_t WHERE pmaalent='",g_enterprise,"' AND pmaal001=apca004 AND pmaal002='",g_dlang,"'),",
                  "               apca014,(SELECT ooag010 FROM ooag_t WHERE ooagent='",g_enterprise,"' AND ooag001=apca014),",
                  "               apca009,apca010,apca100,apca101,",
                  "   CASE WHEN (apca001 ='02' OR apca001 = '04' OR apca001 LIKE '2%') THEN AVG(apca103+apca104) * -1 ELSE AVG(apca103+apca104) END, ",
                  "   CASE WHEN (apca001 ='02' OR apca001 = '04' OR apca001 LIKE '2%') THEN SUM(apcc108-apcc109) * -1 ELSE SUM(apcc108-apcc109) END, ",
                  "   CASE WHEN (apca001 ='02' OR apca001 = '04' OR apca001 LIKE '2%') THEN SUM(apcc118-apcc119+apcc113) * -1 ELSE SUM(apcc118-apcc119+apcc113) END ",
                  "   FROM apca_t,apcc_t",
                  "   WHERE apcaent=apccent AND apcald=apccld AND apcadocno=apccdocno ",
                  "     AND apcaent=",g_enterprise," AND apcald='",g_input.xrcald,"'",
                  "     AND apcasite = '",g_input.xrcasite,"'",
                  "     AND ",l_wc,
                  #161109-00048#1 Add  ---(S)---
                  "     AND apcadocno IN ( ",
                  "      SELECT apcadocno FROM apca_t WHERE apca001 NOT IN ('21','23') AND apcaent = ",g_enterprise," AND apcald='",g_input.xrcald,"' AND apcasite = '",g_input.xrcasite,"'",
                  "       UNION ",
                  "      SELECT apcadocno FROM apca_t,apcc_t WHERE apcaent = apccent AND apcald = apccld AND apcadocno = apccdocno AND apca001 IN ('21','23') AND apcc108 - apcc109 > 0 ",
                  "         AND apcaent = ",g_enterprise," AND apcald='",g_input.xrcald,"' AND apcasite = '",g_input.xrcasite,"'",
                  "         AND apca018 IN (SELECT apcadocno FROM apca_t,apcc_t WHERE apcaent = apccent AND apcald = apccld AND apcadocno = apccdocno  AND apcc109 > 0))",
                  #161109-00048#1 Add  ---(E)---
                  "     AND apcastus = 'Y' ",                  
                  "   GROUP BY apca001,apcadocno,apcadocdt,apca007,apca004,apca005,apca014,apca009,apca010,apca100,apca101",
                  "   ORDER BY apca001,apcadocno,apcadocdt,apca007,apca004,apca005,apca014,apca009,apca010,apca100,apca101"         
   END IF 
      
      PREPARE axrq380_pb1 FROM g_sql
      DECLARE b_fill_curs1 CURSOR FOR axrq380_pb1 
      
   #IF g_prog = 'axrq380' THEN         #160705-00042#10 160713 by sakura mark
   IF g_prog MATCHES 'axrq380' THEN    #160705-00042#10 160713 by sakura add
      #反推未冲余额
      LET g_sql=" SELECT SUM(xrce109),SUM(xrce119) ",
                "   FROM xrda_t,xrce_t ",
                "  WHERE xrdaent=xrceent AND xrdald=xrceld AND xrdadocno=xrcedocno ",
                "    AND xrdaent=",g_enterprise," AND xrdald='",g_input.xrcald,"' ",
                "    AND xrdasite= '",g_input.xrcasite,"'",
                "    AND xrce003= ? AND xrdastus='Y' ",
                "    AND xrdadocdt > '",g_input.edata,"'"  
   ELSE
      LET g_sql=" SELECT SUM(apce109),SUM(apce119) ",
                "   FROM apda_t,apce_t ",
                "  WHERE apdaent=apceent AND apdald=apceld AND apdadocno=apcedocno ",
                "    AND apdaent=",g_enterprise," AND apdald='",g_input.xrcald,"' ",
                "    AND apdasite= '",g_input.xrcasite,"'",
                "    AND apce003= ? AND apdastus='Y' ",
                "    AND apdadocdt > '",g_input.edata,"'"    
   END IF   
      PREPARE axrq380_pb3 FROM g_sql
      

   CALL g_xrca_d.clear()
   
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 


   LET l_xrce109 = 0
   LET l_xrce119 = 0 
   FOREACH b_fill_curs1 INTO  g_xrca_d[l_ac].sel,    g_xrca_d[l_ac].xrca001,g_xrca_d[l_ac].xrcadocno,g_xrca_d[l_ac].xrcadocdt,
                              g_xrca_d[l_ac].xrca007,g_xrca_d[l_ac].xrca007_desc,
                              g_xrca_d[l_ac].xrca004,g_xrca_d[l_ac].xrca004_desc,
                              g_xrca_d[l_ac].xrca005,g_xrca_d[l_ac].xrca005_desc, 
                              g_xrca_d[l_ac].xrca014,g_xrca_d[l_ac].xrca014_desc,
                              g_xrca_d[l_ac].xrca009,g_xrca_d[l_ac].xrca010, 
                              g_xrca_d[l_ac].xrca100,g_xrca_d[l_ac].xrca101,g_xrca_d[l_ac].xrca103,
                              g_xrca_d[l_ac].xrcc108,g_xrca_d[l_ac].xrcc118
                               
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH 1:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #含已沖銷完畢之立帳單=N时不需显示
      IF g_input.a = 'N' THEN 
         IF g_xrca_d[l_ac].xrcc108 = 0 THEN
            CONTINUE FOREACH
         END IF
      END IF
      
      IF g_prog MATCHES 'axrq380' THEN   #170116-00025#1 add
         #预收axrt310 xrcc108-xrcc109=0则不显示预收单，且待底单(21,23)负数显示
         IF g_xrca_d[l_ac].xrca001 = '11' OR g_xrca_d[l_ac].xrca001 = '13' OR g_xrca_d[l_ac].xrca001 = '16' THEN
            IF g_xrca_d[l_ac].xrcc108 = 0 THEN
               CONTINUE FOREACH
            END IF 
         END IF
      END IF   #170116-00025#1 add
      
      #根据冲账截止日期反推未冲余额
      #未冲余额(xrcc108-xrcc109)+大于截止日期已冲账的axrt400
      EXECUTE axrq380_pb3 INTO l_xrce109,l_xrce119 USING g_xrca_d[l_ac].xrcadocno
      IF cl_null(l_xrce109) OR l_xrce109 IS NULL THEN LET l_xrce109 = 0 END IF
      IF cl_null(l_xrce119) OR l_xrce119 IS NULL THEN LET l_xrce119 = 0 END IF
      LET g_xrca_d[l_ac].xrcc108 = g_xrca_d[l_ac].xrcc108 + l_xrce109
      LET g_xrca_d[l_ac].xrcc118 = g_xrca_d[l_ac].xrcc118 + l_xrce119
    
      
      IF NOT cl_null(g_xrca_d[l_ac].xrca007_desc) THEN 
         LET g_xrca_d[l_ac].xrca007_desc = g_xrca_d[l_ac].xrca007,"(",g_xrca_d[l_ac].xrca007_desc,")"  
      ELSE
         LET g_xrca_d[l_ac].xrca007_desc = g_xrca_d[l_ac].xrca007       
      END IF   
      
      IF NOT cl_null(g_xrca_d[l_ac].xrca004_desc) THEN 
         LET g_xrca_d[l_ac].xrca004_desc = g_xrca_d[l_ac].xrca004,"(",g_xrca_d[l_ac].xrca004_desc,")"   
      ELSE
         LET g_xrca_d[l_ac].xrca004_desc = g_xrca_d[l_ac].xrca004      
      END IF
      
      IF NOT cl_null(g_xrca_d[l_ac].xrca005_desc) THEN 
         LET g_xrca_d[l_ac].xrca005_desc = g_xrca_d[l_ac].xrca005,"(",g_xrca_d[l_ac].xrca005_desc,")"
      ELSE
         LET g_xrca_d[l_ac].xrca005_desc = g_xrca_d[l_ac].xrca005
      END IF
      
      IF NOT cl_null(g_xrca_d[l_ac].xrca014_desc) THEN 
         LET g_xrca_d[l_ac].xrca014_desc = g_xrca_d[l_ac].xrca014,"(",g_xrca_d[l_ac].xrca014_desc,")"
      ELSE
         LET g_xrca_d[l_ac].xrca014_desc = g_xrca_d[l_ac].xrca014
      END IF
      
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
   CALL g_xrca_d.deleteElement(g_xrca_d.getLength())   
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   LET l_ac = 1
   CALL cl_set_comp_visible("xrca004_desc,xrca007_desc,xrca014_desc,xrca005_desc",TRUE)
   CALL cl_set_comp_visible("b_xrca004,b_xrca007,b_xrca014,b_xrca005",FALSE)   
   
   CALL axrq380_filter_show('xrca001','b_xrca001')
   CALL axrq380_filter_show('xrcadocno','b_xrcadocno')
   CALL axrq380_filter_show('xrcadocdt','b_xrcadocdt')
   CALL axrq380_filter_show('xrca007','b_xrca007')
   CALL axrq380_filter_show('xrca004','b_xrca004')
   CALL axrq380_filter_show('xrca005','b_xrca005')
   CALL axrq380_filter_show('xrca014','b_xrca014')
   CALL axrq380_filter_show('xrca009','b_xrca009')
   CALL axrq380_filter_show('xrca010','b_xrca010')
   CALL axrq380_filter_show('xrca100','b_xrca100')
 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axrq380_b_fill_2()
# Date & Author..: 2016/05/17 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq380_b_fill_2()
   
   #單身二
   #1:直接冲账
   #3:冲暂估
   #2:收款冲销
   #IF g_prog = 'axrq380' THEN        #160705-00042#10 160713 by sakura mark
   IF g_prog MATCHES 'axrq380' THEN   #160705-00042#10 160713 by sakura add
   LET g_sql=" SELECT xrcedocno,xrcadocdt,'1',SUM(xrce109),SUM(xrce119) ",
             "   FROM xrca_t,xrce_t ",
             "  WHERE xrcaent=xrceent AND xrcald=xrceld AND xrcadocno=xrcedocno ",
             "    AND xrcaent=",g_enterprise," AND xrcald='",g_input.xrcald,"' ",
             "    AND xrcasite= '",g_input.xrcasite,"'",
             "    AND xrce003='",g_xrca_d[l_ac].xrcadocno,"' AND xrcastus='Y' ",
             "  GROUP BY xrcedocno,xrcadocdt ",
             " UNION ",
             " SELECT xrcfdocno,xrcadocdt,'3',SUM(xrcf105),SUM(xrcf115)  ",
             "   FROM xrca_t,xrcb_t,xrcf_t ",
             "  WHERE xrcaent=xrcbent AND xrcald=xrcbld AND xrcadocno=xrcbdocno ",
             "    AND xrcbent=xrcfent AND xrcbld=xrcfld AND xrcbdocno=xrcfdocno AND xrcbseq=xrcfseq ",
             "    AND xrcaent=",g_enterprise," AND xrcald='",g_input.xrcald,"' ",
             "    AND xrcf008='",g_xrca_d[l_ac].xrcadocno,"' AND xrcastus='Y' ",
             "    AND xrcadocdt <= '",g_input.edata,"'",
             "  GROUP BY xrcfdocno,xrcadocdt ",
             " UNION ",
             " SELECT xrdadocno,xrdadocdt,'2',SUM(xrce109),SUM(xrce119) ",
             "   FROM xrda_t,xrce_t ",
             "  WHERE xrdaent=xrceent AND xrdald=xrceld AND xrdadocno=xrcedocno ",
             "    AND xrdaent=",g_enterprise," AND xrdald='",g_input.xrcald,"' ",
             "    AND xrce003='",g_xrca_d[l_ac].xrcadocno,"' AND xrdastus='Y' ",
             "    AND xrdadocdt <= '",g_input.edata,"'",             
             "  GROUP BY xrdadocno,xrdadocdt ", 
             " UNION ",             
             " SELECT apdadocno,apdadocdt,'4',SUM(apce109),SUM(apce119) ",
             "   FROM apda_t,apce_t ",
             "  WHERE apdaent=apceent AND apdald=apceld AND apdadocno=apcedocno ",
             "    AND apdaent=",g_enterprise," AND apdald='",g_input.xrcald,"' ",
             "    AND apdasite= '",g_input.xrcasite,"'",
             "    AND apdadocdt <= '",g_input.edata,"'",
             "    AND apce003='",g_xrca_d[l_ac].xrcadocno,"' AND apdastus='Y' ",
             "    AND apda001 <> '43' ",
             "  GROUP BY apdadocno,apdadocdt ",
             " UNION ",             
             " SELECT xrdedocno,xrde032,'5',SUM(xrde109),SUM(xrde119) ",
             "   FROM xrde_t,xrca_t ",
             "  WHERE xrdeent=xrcaent AND xrdeld=xrcald AND xrdedocno=xrcadocno ",
             "    AND xrdeent=",g_enterprise," AND xrdeld='",g_input.xrcald,"' ",
             "    AND xrdesite= '",g_input.xrcasite,"'",
             "    AND xrde032 <= '",g_input.edata,"'",
             "    AND xrdedocno='",g_xrca_d[l_ac].xrcadocno,"' ",
             "    AND xrcastus='Y' ",
             "  GROUP BY xrdedocno,xrde032 "               
   ELSE
   LET g_sql=" SELECT apcedocno,apcadocdt,'1',SUM(apce109),SUM(apce119) ",
             "   FROM apca_t,apce_t ",
             "  WHERE apcaent=apceent AND apcald=apceld AND apcadocno=apcedocno ",
             "    AND apcaent=",g_enterprise," AND apcald='",g_input.xrcald,"' ",
             "    AND apcasite= '",g_input.xrcasite,"'",
             "    AND apce003='",g_xrca_d[l_ac].xrcadocno,"' AND apcastus='Y' ",
             "  GROUP BY apcedocno,apcadocdt ",
             " UNION ",
             " SELECT apcfdocno,apcadocdt,'3',SUM(apcf105),SUM(apcf115)  ",
             "   FROM apca_t,apcb_t,apcf_t ",
             "  WHERE apcaent=apcbent AND apcald=apcbld AND apcadocno=apcbdocno ",
             "    AND apcbent=apcfent AND apcbld=apcfld AND apcbdocno=apcfdocno AND apcbseq=apcfseq ",
             "    AND apcaent=",g_enterprise," AND apcald='",g_input.xrcald,"' ",
             "    AND apcf008='",g_xrca_d[l_ac].xrcadocno,"' AND apcastus='Y' ",
             "    AND apcadocdt <= '",g_input.edata,"'",
             "  GROUP BY apcfdocno,apcadocdt ",
             " UNION ",
             " SELECT apdadocno,apdadocdt,'2',SUM(apce109),SUM(apce119) ",
             "   FROM apda_t,apce_t ",
             "  WHERE apdaent=apceent AND apdald=apceld AND apdadocno=apcedocno ",
             "    AND apdaent=",g_enterprise," AND apdald='",g_input.xrcald,"' ",
             "    AND apce003='",g_xrca_d[l_ac].xrcadocno,"' AND apdastus='Y' ",
             "    AND apdadocdt <= '",g_input.edata,"'",  
             "    AND apda001 <> '43' ",             
             "  GROUP BY apdadocno,apdadocdt ", 
             " UNION ",             
             " SELECT xrdadocno,xrdadocdt,'4',SUM(xrce109),SUM(xrce119) ",
             "   FROM xrda_t,xrce_t ",
             "  WHERE xrdaent=xrceent AND xrdald=xrceld AND xrdadocno=xrcedocno ",
             "    AND xrdaent=",g_enterprise," AND xrdald='",g_input.xrcald,"' ",
             "    AND xrdasite= '",g_input.xrcasite,"'",
             "    AND xrdadocdt <= '",g_input.edata,"'",
             "    AND xrce003='",g_xrca_d[l_ac].xrcadocno,"' AND xrdastus='Y' ",
             "  GROUP BY xrdadocno,xrdadocdt " ,
             " UNION ",             
             " SELECT apdedocno,apde032,'6',SUM(apde109),SUM(apde119) ",
             "   FROM apde_t,apca_t ",
             "  WHERE apdeent=apcaent AND apdeld=apcald AND apdedocno=apcadocno ",
             "    AND apdeent=",g_enterprise," AND apdeld='",g_input.xrcald,"' ",
             "    AND apdesite= '",g_input.xrcasite,"'",
             "    AND apde032 <= '",g_input.edata,"'",
             "    AND apdedocno='",g_xrca_d[l_ac].xrcadocno,"' ",
             "    AND apcastus='Y' ",
             "  GROUP BY apdedocno,apde032 "              
   END IF             
             
   PREPARE axrq380_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR axrq380_pb2             
   CALL g_xrca2_d.clear()
 
   LET l_ac2 = 1   
   ERROR "Searching!"     

   FOREACH b_fill_curs2 INTO g_xrca2_d[l_ac2].xrcedocno,g_xrca2_d[l_ac2].xrcadocdt,g_xrca2_d[l_ac2].xrce002,g_xrca2_d[l_ac2].xrce109,g_xrca2_d[l_ac2].xrce119
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
   

      LET l_ac2 = l_ac2 + 1
      IF l_ac2 > g_max_rec THEN
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
   LET l_ac2 = 1 
   CALL g_xrca2_d.deleteElement(g_xrca2_d.getLength())           
END FUNCTION

################################################################################
# Descriptions...: 抓取控制组
# Memo...........:
# Usage..........: CALL axrq380_get_control()
#                  RETURNING ---
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/11/16 By 01727
# Modify.........: #161111-00049#1 Add
################################################################################
PRIVATE FUNCTION axrq380_get_control()
   DEFINE l_glaacomp         LIKE glaa_t.glaacomp

   SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_input.xrcald

   IF g_prog MATCHES 'axrq380' THEN
      CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',l_glaacomp) RETURNING g_sub_success,g_sql_ctrl
   ELSE
      #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',l_glaacomp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#69 mark
      #161229-00047#69 add ------
      CALL s_fin_get_wc_str(l_glaacomp) RETURNING g_comp_str
      CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
      #161229-00047#69 add end---
   END IF

END FUNCTION

 
{</section>}
 
