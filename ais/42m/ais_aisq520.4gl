#該程式未解開Section, 採用最新樣板產出!
{<section id="aisq520.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:5(2015-02-26 16:35:47), PR版次:0005(2016-10-24 16:19:33)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000075
#+ Filename...: aisq520
#+ Description: 交易明細稅查詢作業
#+ Creator....: 04226(2014-09-30 11:40:06)
#+ Modifier...: 04152 -SD/PR- 04152
 
{</section>}
 
{<section id="aisq520.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#150127-00007#1  2015/02/26 By Reanna     掃把清空&給預設值
#160318-00025#44 2016/04/19 By 07959      將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#161006-00005#28 2016/10/24 By Reanna     1.法人(xrcdcomp)需控卡azzi800 2.營運據點(xrcdsite) 需控卡zzi800控卡
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
PRIVATE TYPE type_g_xrcd_d RECORD
       
       sel LIKE type_t.chr1, 
   xrcdld LIKE xrcd_t.xrcdld, 
   xrcdsite LIKE xrcd_t.xrcdsite, 
   xrcdsite_desc LIKE type_t.chr500, 
   xrcddocno LIKE xrcd_t.xrcddocno, 
   prog_b_xrcddocno LIKE type_t.chr500, 
   xrcdseq LIKE xrcd_t.xrcdseq, 
   imaa001 LIKE type_t.chr500, 
   imaa001_desc LIKE type_t.chr500, 
   docdt LIKE type_t.chr500, 
   cust LIKE type_t.chr500, 
   cust_desc LIKE type_t.chr500, 
   xrcd002 LIKE xrcd_t.xrcd002, 
   xrcd002_desc LIKE type_t.chr500, 
   xrcd003 LIKE xrcd_t.xrcd003, 
   xrcd004 LIKE xrcd_t.xrcd004, 
   xrcd103 LIKE xrcd_t.xrcd103, 
   xrcd104 LIKE xrcd_t.xrcd104, 
   xrcd105 LIKE xrcd_t.xrcd105, 
   xrcd009 LIKE xrcd_t.xrcd009, 
   xrcd009_desc LIKE type_t.chr500
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_g_xrcd     RECORD
        xrcdcomp        LIKE xrcd_t.xrcdcomp,
        xrcdcomp_desc   LIKE ooefl_t.ooefl003,
        xrcd001         LIKE xrcd_t.xrcd001,
        condition       LIKE type_t.chr1
                     END RECORD
DEFINE g_xrcd        type_g_xrcd
DEFINE g_xrcd_o      type_g_xrcd
DEFINE g_wc_xrcdcomp STRING     #161006-00005#28
DEFINE g_wc_xrcdsite STRING     #161006-00005#28
#end add-point
 
#模組變數(Module Variables)
DEFINE g_xrcd_d            DYNAMIC ARRAY OF type_g_xrcd_d
DEFINE g_xrcd_d_t          type_g_xrcd_d
 
 
 
 
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
 
{<section id="aisq520.main" >}
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
   CALL cl_ap_init("ais","")
 
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
   DECLARE aisq520_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aisq520_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aisq520_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aisq520 WITH FORM cl_ap_formpath("ais",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aisq520_init()   
 
      #進入選單 Menu (="N")
      CALL aisq520_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aisq520
      
   END IF 
   
   CLOSE aisq520_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aisq520.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aisq520_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   LET g_errshow = 1
   CALL cl_set_combo_scc('xrcd001','9740')
   CALL s_fin_create_account_center_tmp()  #161006-00005#28
   #end add-point
 
   CALL aisq520_default_search()
END FUNCTION
 
{</section>}
 
{<section id="aisq520.default_search" >}
PRIVATE FUNCTION aisq520_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xrcdld = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " xrcddocno = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " xrcdseq = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " xrcdseq2 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " xrcd007 = '", g_argv[05], "' AND "
   END IF
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aisq520.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aisq520_ui_dialog() 
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
   DEFINE l_ld      LIKE glaa_t.glaald
   DEFINE l_errno   LIKE gzze_t.gzze001
   DEFINE l_success LIKE type_t.num10
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   
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
 
   #end add-point
 
   #應用 qs03 樣板自動產生(Version:3) 
   # 若有做串查功能，在CONSTRUCT後，需先將顯示欄位開啟、查詢欄位隱藏 
   CALL gfrm_curr.setFieldHidden('b_xrcddocno', TRUE) 
   CALL gfrm_curr.setFieldHidden('prog_b_xrcddocno', FALSE) 
 
  
 
 
 
   CALL aisq520_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xrcd_d.clear()
 
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
 
         CALL aisq520_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT BY NAME g_xrcd.xrcdcomp,g_xrcd.xrcd001,g_xrcd.condition
            BEFORE INPUT
            
            AFTER FIELD xrcdcomp
               LET g_xrcd.xrcdcomp_desc = ''
               IF NOT cl_null(g_xrcd.xrcdcomp) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xrcd.xrcdcomp
                  IF cl_chk_exist("v_ooef001_1") THEN
                     #檢查成功時後續處理
                  ELSE
                     #檢查失敗時後續處理
                     LET g_xrcd.xrcdcomp = g_xrcd_o.xrcdcomp
                     CALL s_desc_get_department_desc(g_xrcd.xrcdcomp)RETURNING g_xrcd.xrcdcomp_desc
                     DISPLAY BY NAME g_xrcd.xrcdcomp_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161006-00005#28 add ------
                  #檢查輸入帳套是否存在帳務中心下帳套範圍內
                  IF s_chr_get_index_of(g_wc_xrcdcomp,g_xrcd.xrcdcomp,1) = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00127'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_xrcd.xrcdcomp = g_xrcd_o.xrcdcomp
                     CALL s_desc_get_department_desc(g_xrcd.xrcdcomp)RETURNING g_xrcd.xrcdcomp_desc
                     DISPLAY BY NAME g_xrcd.xrcdcomp_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161006-00005#28 add end---
               END IF
               CALL s_desc_get_department_desc(g_xrcd.xrcdcomp) RETURNING g_xrcd.xrcdcomp_desc
               DISPLAY BY NAME g_xrcd.xrcdcomp_desc
               LET g_xrcd_o.xrcdcomp = g_xrcd.xrcdcomp
            
            
            AFTER FIELD xrcd001
               IF g_xrcd.xrcd001 != g_xrcd_o.xrcd001 OR g_xrcd_o.xrcd001 IS NULL THEN
                  DISPLAY '' TO xrcddocno
               END IF
               LET g_xrcd_o.xrcd001 = g_xrcd.xrcd001
            
            
            ON ACTION controlp INFIELD xrcdcomp
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_xrcd.xrcdcomp
               #LET g_qryparam.where = " ooef003 = 'Y' " #161006-00005#28 mark
               LET g_qryparam.where = "ooef003 = 'Y' AND ooef001 IN ",g_wc_xrcdcomp CLIPPED  #161006-00005#28
               CALL q_ooef001()
               LET g_xrcd.xrcdcomp = g_qryparam.return1
               CALL s_desc_get_department_desc(g_xrcd.xrcdcomp)RETURNING g_xrcd.xrcdcomp_desc
               DISPLAY BY NAME g_xrcd.xrcdcomp,g_xrcd.xrcdcomp_desc
               NEXT FIELD xrcdcomp
         END INPUT
         
         CONSTRUCT BY NAME g_wc ON xrcdsite,xrcddocno,qdocdt,xrcd002,xrcd003
            AFTER FIELD qdocdt
               #CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
               #IF NOT cl_null(ls_result) THEN
               #   IF NOT cl_chk_date_symbol(ls_result) THEN
               #      LET ls_result = cl_add_date_extra_cond(ls_result)
               #   END IF
               #END IF
               #CALL FGL_DIALOG_SETBUFFER(ls_result)
            
            
            ON ACTION controlp INFIELD xrcdsite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " ooef201 = 'Y'"
               LET g_qryparam.where = g_qryparam.where," AND ooef001 IN ",g_wc_xrcdsite CLIPPED  #161006-00005#28
               CALL q_ooef001()
               DISPLAY g_qryparam.return1 TO xrcdsite
               NEXT FIELD xrcdsite
               
            
            ON ACTION controlp INFIELD xrcddocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CASE g_xrcd.xrcd001
                  WHEN 'aapt300' #aapt300
                     CALL q_apcadocno()
                  WHEN 'axrt300' #axrt300
                     CALL q_xrcadocno()
                  WHEN 'aist310' #aist310
                     CALL q_isafdocno()
                  WHEN 'axmt500' #axmt500
                     CALL q_xmdadocno()
                  WHEN 'axmt540' #axmt540
                     CALL q_xmdkdocno_2()
                  WHEN 'apmt500' #apmt500
                     CALL q_pmdldocno()
               END CASE
               DISPLAY g_qryparam.return1 TO xrcddocno
               NEXT FIELD xrcddocno
            
            
            ON ACTION controlp INFIELD xrcd002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_xrcd002()
               DISPLAY g_qryparam.return1 TO xrcd002
               NEXT FIELD xrcd002
         END CONSTRUCT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         
         #end add-point
     
         DISPLAY ARRAY g_xrcd_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL aisq520_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aisq520_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION 相關動作 name="menu.detail_show.page1_sub."
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_axrt300
                  LET g_action_choice="prog_axrt300"
                  IF cl_auth_chk_act("prog_axrt300") THEN
                     
                     #add-point:ON ACTION prog_axrt300 name="menu.detail_show.page1_sub.prog_axrt300"
               #應用 a41 樣板自動產生(Version:3)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'axrt300'
               LET la_param.param[1] = g_xrcd_d[g_detail_idx].xrcddocno

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 



                     #END add-point
                     
                     
                  END IF
 
 
 
               #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_aapt300
                  LET g_action_choice="prog_aapt300"
                  IF cl_auth_chk_act("prog_aapt300") THEN
                     
                     #add-point:ON ACTION prog_aapt300 name="menu.detail_show.page1_sub.prog_aapt300"
               #應用 a41 樣板自動產生(Version:3)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'aapt300'
               LET la_param.param[1] = g_xrcd_d[g_detail_idx].xrcddocno

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 



                     #END add-point
                     
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page1.detail_qrystr"
               
               #END add-point
               
 
 
 
 
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL aisq520_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            #150127-00007#1
            CALL aisq520_qbe_clear()
            #150127-00007#1 mark---
            #為了掃把清空時給預設所以移至 aisq520_qbe_clear()裡面
            #CALL s_fin_ld_carry('',g_user)
            #   RETURNING l_success,l_ld,g_xrcd.xrcdcomp,l_errno
            #CALL s_desc_get_department_desc(g_xrcd.xrcdcomp)
            #   RETURNING g_xrcd.xrcdcomp_desc
            #DISPLAY BY NAME g_xrcd.xrcdcomp_desc
            #LET g_xrcd.xrcd001 = 'aapt300'
            #LET g_xrcd.condition = '2'
            #LET g_xrcd_o.* = g_xrcd.*
            #LET g_wc = " 1=1"
            #CALL aisq520_comp_visible()
            #150127-00007#1 mark end---
            #end add-point
            NEXT FIELD xrcdcomp
 
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
            CALL aisq520_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_xrcd_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL aisq520_b_fill()
 
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
            CALL aisq520_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aisq520_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aisq520_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aisq520_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_xrcd_d.getLength()
               LET g_xrcd_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_xrcd_d.getLength()
               LET g_xrcd_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_xrcd_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xrcd_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_xrcd_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xrcd_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aisq520_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query name="menu.query"
               
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
            #150127-00007#1
            CALL aisq520_qbe_clear()
            #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="aisq520.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aisq520_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_from          STRING
   DEFINE l_docdt_cust    STRING
   DEFINE l_imaa001       STRING
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CASE g_xrcd.xrcd001
      WHEN 'aapt300' #aapt300
         LET l_docdt_cust = "SELECT apcadocdt,apca005 FROM apca_t",
                            " WHERE apcaent = ",g_enterprise,
                            "   AND apcald = ?",
                            "   AND apcadocno = ?"
         LET l_imaa001 = "SELECT xrcb004,xrcb005",
                         "  FROM xrcb_t",
                         " WHERE xrcbent = ",g_enterprise,
                         "   AND xrcbld = ?",
                         "   AND xrcbdocno = ?",
                         "   AND xrcbseq = ?"
      WHEN 'axrt300' #axrt300
         LET l_docdt_cust = "SELECT xrcadocdt,xrca023 FROM xrca_t",
                            " WHERE xrcaent = ",g_enterprise,
                            "   AND xrcald = ?",
                            "   AND xrcadocno = ?"
         LET l_imaa001 = "SELECT xrcb004,xrcb005",
                         "  FROM xrcb_t",
                         " WHERE xrcbent = ",g_enterprise,
                         "   AND xrcbld = ?",
                         "   AND xrcbdocno = ?",
                         "   AND xrcbseq = ?"
      WHEN 'aist310' #aist310
         LET l_docdt_cust = "SELECT isafdocdt,isaf002 FROM isaf_t",
                            " WHERE isafent = ",g_enterprise,
                            "   AND isafld = ?",
                            "   AND isafdocno = ?"
         LET l_imaa001 = "SELECT xrcb004,xrcb005",
                         "  FROM xrcb_t",
                         " WHERE xrcbent = ",g_enterprise,
                         "   AND xrcbld = ?",
                         "   AND xrcbdocno = ?",
                         "   AND xrcbseq = ?"
      WHEN 'axmt500' #axmt500
         LET l_docdt_cust = "SELECT xmdadocdt,xmda203 FROM xmda_t",
                            " WHERE xmdaent = ",g_enterprise,
                            "   AND xmdadocno = ?"
         LET l_imaa001 = "SELECT xmdc001,imaal003",
                         "  FROM xmdc_t",
                         "  LEFT OUTER JOIN imaal_t",
                         "    ON imaalent = xmdcent",
                         "   AND imaal001 = xmdc001",
                         "   AND imaal002 = '",g_dlang,"'",
                         " WHERE xmdcent = ",g_enterprise,
                         "   AND xmdcdocno = ?",
                         "   AND xmdcseq = ?"
      WHEN 'axmt540' #axmt540
         LET l_docdt_cust = "SELECT xmdkdocdt,xmdk202 FROM xmdk_t",
                            " WHERE xmdkent = ",g_enterprise,
                            "   AND xmdkdocno = ?"
         LET l_imaa001 = "SELECT xmdl008,imaal003",
                         "  FROM xmdl_t",
                         "  LEFT OUTER JOIN imaal_t",
                         "    ON imaalent = xmdlent",
                         "   AND imaal001 = xmdl008",
                         "   AND imaal002 = '",g_dlang,"'",
                         " WHERE xmdlent = ",g_enterprise,
                         "   AND xmdldocno = ?",
                         "   AND xmdlseq = ?"
      WHEN 'apmt500' #apmt500
         LET l_docdt_cust = "SELECT pmdldocdt,pmac002 FROM pmdl_t",
                            "  LEFT OUTER JOIN pmac_t",
                            "    ON pmacent = pmdlent",
                            "   AND pmac001 = pmdl004",
                            "   AND pmac003 = '3'",
                            "   AND pmac004 = 'Y'",
                            "   AND pmacstus = 'Y'",
                            " WHERE pmdlent = ",g_enterprise,
                            "   AND pmdldocno = ?"
         LET l_imaa001 = "SELECT pmdn001,imaal003",
                         "  FROM pmdn_t",
                         "  LEFT OUTER JOIN imaal_t",
                         "    ON imaalent = pmdnent",
                         "   AND imaal001 = pmdn001",
                         "   AND imaal002 = '",g_dlang,"'",
                         " WHERE pmdnent = ",g_enterprise,
                         "   AND pmdndocno = ?",
                         "   AND pmdnseq = ?"
   END CASE
   
   #單據日期 發票客戶
   PREPARE aisq520_docdt_cust FROM l_docdt_cust
   
   #料件編號 品名
   PREPARE aisq520_imaa001 FROM l_imaa001
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
 
   CALL g_xrcd_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   LET ls_wc = ls_wc," AND xrcdcomp = '",g_xrcd.xrcdcomp,"'",
                     " AND xrcd001 = '",g_xrcd.xrcd001,"'"
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',xrcdld,xrcdsite,'',xrcddocno,'',xrcdseq,'','','','','',xrcd002, 
       '',xrcd003,xrcd004,xrcd103,xrcd104,xrcd105,xrcd009,''  ,DENSE_RANK() OVER( ORDER BY xrcd_t.xrcdld, 
       xrcd_t.xrcddocno,xrcd_t.xrcdseq,xrcd_t.xrcdseq2,xrcd_t.xrcd007) AS RANK FROM xrcd_t",
 
 
                     "",
                     " WHERE xrcdent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xrcd_t"),
                     " ORDER BY xrcd_t.xrcdld,xrcd_t.xrcddocno,xrcd_t.xrcdseq,xrcd_t.xrcdseq2,xrcd_t.xrcd007"
 
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
 
   LET g_sql = "SELECT '',xrcdld,xrcdsite,'',xrcddocno,'',xrcdseq,'','','','','',xrcd002,'',xrcd003, 
       xrcd004,xrcd103,xrcd104,xrcd105,xrcd009,''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   CASE g_xrcd.xrcd001
      WHEN 'aapt300' #aapt300
         LET ls_wc = cl_replace_str(ls_wc,"qdocdt","apcadocdt")
         LET l_from = "  LEFT OUTER JOIN apca_t ON apcaent = xrcdent AND apcadocno = xrcddocno"
      WHEN 'axrt300' #axrt300
         LET ls_wc = cl_replace_str(ls_wc,"qdocdt","xrcadocdt")
         LET l_from = "  LEFT OUTER JOIN xrca_t ON xrcaent = xrcdent AND xrcadocno = xrcddocno"
      WHEN 'aist310' #aist310
         LET ls_wc = cl_replace_str(ls_wc,"qdocdt","isafdocdt")
         LET l_from = "  LEFT OUTER JOIN isaf_t ON isafent = xrcdent AND isafdocno = xrcddocno"
      WHEN 'axmt500' #axmt500
         LET ls_wc = cl_replace_str(ls_wc,"qdocdt","xmdadocdt")
         LET l_from = "  LEFT OUTER JOIN xmda_t ON xmdaent = xrcdent AND xmdadocno = xrcddocno"
      WHEN 'axmt540' #axmt540
         LET ls_wc = cl_replace_str(ls_wc,"qdocdt","xmdkdocdt")
         LET l_from = "  LEFT OUTER JOIN xmdk_t ON xmdkent = xrcdent AND xmdkdocno = xrcddocno"
      WHEN 'apmt500' #apmt500
         LET ls_wc = cl_replace_str(ls_wc,"qdocdt","pmdldocdt")
         LET l_from = "  LEFT OUTER JOIN pmdl_t ON pmdlent = xrcdent AND pmdldocno = xrcddocno"
   END CASE
   
   CASE g_xrcd.condition
      WHEN '1' #依單據號碼
         LET g_sql = "SELECT UNIQUE 'N',xrcdld,xrcdsite,'',xrcddocno,",
                     "              '','','','','',",
                     "              '','','','','',",
                     "              SUM(xrcd103),SUM(xrcd104),SUM(xrcd105),'',''",
                     "  FROM xrcd_t",l_from,
                     " WHERE xrcdent= ? AND ", ls_wc,
                     " GROUP BY xrcdld,xrcdsite,xrcddocno",
                     " ORDER BY xrcdld,xrcdsite,xrcddocno"
      WHEN '2' #依稅別
         LET g_sql = "SELECT UNIQUE 'N','','','','',",
                     "              '','','','','',",
                     "              '',xrcd002,'',xrcd003,SUM(xrcd004),",
                     "              SUM(xrcd103),SUM(xrcd104),SUM(xrcd105),'',''",
                     "  FROM xrcd_t",l_from,
                     " WHERE xrcdent= ? AND 1=1 AND ", ls_wc,
                     " GROUP BY xrcd002,xrcd003",
                     " ORDER BY xrcd002,xrcd003"
      WHEN '3' #依營運據點+稅別
         LET g_sql = "SELECT UNIQUE 'N','',xrcdsite,'','',",
                     "              '','','','','',",
                     "              '',xrcd002,'','',SUM(xrcd004),",
                     "              SUM(xrcd103),SUM(xrcd104),SUM(xrcd105),'',''",
                     "  FROM xrcd_t",l_from,
                     " WHERE xrcdent= ? AND 1=1 AND ", ls_wc,
                     " GROUP BY xrcdsite,xrcd002",
                     " ORDER BY xrcdsite,xrcd002"
      WHEN '4' #明細顯示
         LET g_sql = "SELECT UNIQUE 'N',xrcdld,xrcdsite,'',xrcddocno,",
                     "              xrcdseq,'','','','',",
                     "              '',xrcd002,'',xrcd003,xrcd004,",
                     "              xrcd103,xrcd104,xrcd105,xrcd009,''",
                     "  FROM xrcd_t",l_from,
                     " WHERE xrcdent= ? AND 1=1 AND ", ls_wc,
                     " ORDER BY xrcdsite,xrcddocno,xrcdseq"
   END CASE
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aisq520_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aisq520_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_xrcd_d[l_ac].sel,g_xrcd_d[l_ac].xrcdld,g_xrcd_d[l_ac].xrcdsite,g_xrcd_d[l_ac].xrcdsite_desc, 
       g_xrcd_d[l_ac].xrcddocno,g_xrcd_d[l_ac].xrcdseq,g_xrcd_d[l_ac].imaa001,g_xrcd_d[l_ac].imaa001_desc, 
       g_xrcd_d[l_ac].docdt,g_xrcd_d[l_ac].cust,g_xrcd_d[l_ac].cust_desc,g_xrcd_d[l_ac].xrcd002,g_xrcd_d[l_ac].xrcd002_desc, 
       g_xrcd_d[l_ac].xrcd003,g_xrcd_d[l_ac].xrcd004,g_xrcd_d[l_ac].xrcd103,g_xrcd_d[l_ac].xrcd104,g_xrcd_d[l_ac].xrcd105, 
       g_xrcd_d[l_ac].xrcd009,g_xrcd_d[l_ac].xrcd009_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      #應用 qs24 樣板自動產生(Version:5) 
      #+ b_fill段欄位串查功能設定 
      IF FGL_GETENV("GUIMODE") = "GWC" THEN 
         LET g_hyper_url = aisq520_get_hyper_data("prog_b_xrcddocno")
         LET g_xrcd_d[l_ac].prog_b_xrcddocno = "<a href = '",g_hyper_url,"'>",cl_bpm_replace_xml_specail_char(g_xrcd_d[l_ac].xrcddocno), 
             "</a>"
 
      ELSE 
         LET g_xrcd_d[l_ac].prog_b_xrcddocno = g_xrcd_d[l_ac].xrcddocno
 
      END IF 
 
 
 
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL aisq520_detail_show("'1'")
 
      CALL aisq520_xrcd_t_mask()
 
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
   CALL aisq520_comp_visible()
   #end add-point
 
   CALL g_xrcd_d.deleteElement(g_xrcd_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_xrcd_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE aisq520_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aisq520_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aisq520_detail_action_trans()
 
   LET l_ac = 1
   IF g_xrcd_d.getLength() > 0 THEN
      CALL aisq520_b_fill2()
   END IF
 
      CALL aisq520_filter_show('xrcdld','b_xrcdld')
   CALL aisq520_filter_show('xrcdsite','b_xrcdsite')
   CALL aisq520_filter_show('xrcddocno','b_xrcddocno')
   CALL aisq520_filter_show('xrcdseq','b_xrcdseq')
   CALL aisq520_filter_show('xrcd002','b_xrcd002')
   CALL aisq520_filter_show('xrcd003','b_xrcd003')
   CALL aisq520_filter_show('xrcd004','b_xrcd004')
   CALL aisq520_filter_show('xrcd103','b_xrcd103')
   CALL aisq520_filter_show('xrcd104','b_xrcd104')
   CALL aisq520_filter_show('xrcd105','b_xrcd105')
   CALL aisq520_filter_show('xrcd009','b_xrcd009')
 
 
END FUNCTION
 
{</section>}
 
{<section id="aisq520.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aisq520_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
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
 
{<section id="aisq520.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aisq520_detail_show(ps_page)
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
      #營運據點
      CALL s_desc_get_department_desc(g_xrcd_d[l_ac].xrcdsite)
         RETURNING g_xrcd_d[l_ac].xrcdsite_desc
      CALL s_desc_show1(g_xrcd_d[l_ac].xrcdsite,g_xrcd_d[l_ac].xrcdsite_desc)
         RETURNING g_xrcd_d[l_ac].xrcdsite_desc
      
      CASE g_xrcd.condition
         WHEN '1'
            #單據日期 發票客戶
            CASE g_xrcd.xrcd001
               WHEN 'aapt300' #aapt300
                  EXECUTE aisq520_docdt_cust USING g_xrcd_d[l_ac].xrcdld,g_xrcd_d[l_ac].xrcddocno
                     INTO g_xrcd_d[l_ac].docdt,g_xrcd_d[l_ac].cust
               WHEN 'axrt300' #axrt300
                  EXECUTE aisq520_docdt_cust USING g_xrcd_d[l_ac].xrcdld,g_xrcd_d[l_ac].xrcddocno
                     INTO g_xrcd_d[l_ac].docdt,g_xrcd_d[l_ac].cust
               WHEN 'aist310' #aist310
                  EXECUTE aisq520_docdt_cust USING g_xrcd_d[l_ac].xrcdld,g_xrcd_d[l_ac].xrcddocno
                     INTO g_xrcd_d[l_ac].docdt,g_xrcd_d[l_ac].cust
               WHEN 'axmt500' #axmt500
                  EXECUTE aisq520_docdt_cust USING g_xrcd_d[l_ac].xrcddocno
                     INTO g_xrcd_d[l_ac].docdt,g_xrcd_d[l_ac].cust
               WHEN 'axmt540' #axmt540
                  EXECUTE aisq520_docdt_cust USING g_xrcd_d[l_ac].xrcddocno
                     INTO g_xrcd_d[l_ac].docdt,g_xrcd_d[l_ac].cust
               WHEN 'apmt500' #apmt500
                  EXECUTE aisq520_docdt_cust USING g_xrcd_d[l_ac].xrcddocno
                     INTO g_xrcd_d[l_ac].docdt,g_xrcd_d[l_ac].cust
            END CASE
            #客戶名稱
            CALL s_desc_get_trading_partner_abbr_desc(g_xrcd_d[l_ac].cust)
               RETURNING g_xrcd_d[l_ac].cust_desc
         WHEN '2'
            #稅別
            CALL s_desc_get_tax_desc1(g_xrcd.xrcdcomp,g_xrcd_d[l_ac].xrcd002)
               RETURNING g_xrcd_d[l_ac].xrcd002_desc
            CALL s_desc_show1(g_xrcd_d[l_ac].xrcd002,g_xrcd_d[l_ac].xrcd002_desc)
               RETURNING g_xrcd_d[l_ac].xrcd002_desc
         WHEN '3'
            #稅別
            CALL s_desc_get_tax_desc1(g_xrcd.xrcdcomp,g_xrcd_d[l_ac].xrcd002)
               RETURNING g_xrcd_d[l_ac].xrcd002_desc
            CALL s_desc_show1(g_xrcd_d[l_ac].xrcd002,g_xrcd_d[l_ac].xrcd002_desc)
               RETURNING g_xrcd_d[l_ac].xrcd002_desc
            
         WHEN '4'
            #稅別
            CALL s_desc_get_tax_desc1(g_xrcd.xrcdcomp,g_xrcd_d[l_ac].xrcd002)
               RETURNING g_xrcd_d[l_ac].xrcd002_desc
            CALL s_desc_show1(g_xrcd_d[l_ac].xrcd002,g_xrcd_d[l_ac].xrcd002_desc)
               RETURNING g_xrcd_d[l_ac].xrcd002_desc
            
            #單據日期 發票客戶
            CASE g_xrcd.xrcd001
               WHEN 'aapt300' #aapt300
                  EXECUTE aisq520_imaa001 USING g_xrcd_d[l_ac].xrcdld,g_xrcd_d[l_ac].xrcddocno,g_xrcd_d[l_ac].xrcdseq
                     INTO g_xrcd_d[l_ac].imaa001,g_xrcd_d[l_ac].imaa001_desc
               WHEN 'axrt300' #axrt300
                  EXECUTE aisq520_imaa001 USING g_xrcd_d[l_ac].xrcdld,g_xrcd_d[l_ac].xrcddocno,g_xrcd_d[l_ac].xrcdseq
                     INTO g_xrcd_d[l_ac].imaa001,g_xrcd_d[l_ac].imaa001_desc
               WHEN 'aist310' #aist310
                  EXECUTE aisq520_imaa001 USING g_xrcd_d[l_ac].xrcdld,g_xrcd_d[l_ac].xrcddocno,g_xrcd_d[l_ac].xrcdseq
                     INTO g_xrcd_d[l_ac].imaa001,g_xrcd_d[l_ac].imaa001_desc
               WHEN 'axmt500' #axmt500
                  EXECUTE aisq520_imaa001 USING g_xrcd_d[l_ac].xrcddocno,g_xrcd_d[l_ac].xrcdseq
                     INTO g_xrcd_d[l_ac].imaa001,g_xrcd_d[l_ac].imaa001_desc
               WHEN 'axmt540' #axmt540
                  EXECUTE aisq520_imaa001 USING g_xrcd_d[l_ac].xrcddocno,g_xrcd_d[l_ac].xrcdseq
                     INTO g_xrcd_d[l_ac].imaa001,g_xrcd_d[l_ac].imaa001_desc
               WHEN 'apmt500' #apmt500
                  EXECUTE aisq520_imaa001 USING g_xrcd_d[l_ac].xrcddocno,g_xrcd_d[l_ac].xrcdseq
                     INTO g_xrcd_d[l_ac].imaa001,g_xrcd_d[l_ac].imaa001_desc
            END CASE
      END CASE
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aisq520.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION aisq520_filter()
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
 
   #應用 qs02 樣板自動產生(Version:3) 
   # 若有做串查功能，在CONSTRUCT前，需先將查詢欄位開啟、顯示欄位隱藏 
   CALL gfrm_curr.setFieldHidden('prog_b_xrcddocno', TRUE) 
   CALL gfrm_curr.setFieldHidden('b_xrcddocno', FALSE) 
 
  
 
 
 
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   #應用 qs08 樣板自動產生(Version:5)
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON xrcdld,xrcdsite,xrcddocno,xrcdseq,xrcd002,xrcd003,xrcd004,xrcd103,xrcd104, 
          xrcd105,xrcd009
                          FROM s_detail1[1].b_xrcdld,s_detail1[1].b_xrcdsite,s_detail1[1].b_xrcddocno, 
                              s_detail1[1].b_xrcdseq,s_detail1[1].b_xrcd002,s_detail1[1].b_xrcd003,s_detail1[1].b_xrcd004, 
                              s_detail1[1].b_xrcd103,s_detail1[1].b_xrcd104,s_detail1[1].b_xrcd105,s_detail1[1].b_xrcd009 
 
 
         BEFORE CONSTRUCT
                     DISPLAY aisq520_filter_parser('xrcdld') TO s_detail1[1].b_xrcdld
            DISPLAY aisq520_filter_parser('xrcdsite') TO s_detail1[1].b_xrcdsite
            DISPLAY aisq520_filter_parser('xrcddocno') TO s_detail1[1].b_xrcddocno
            DISPLAY aisq520_filter_parser('xrcdseq') TO s_detail1[1].b_xrcdseq
            DISPLAY aisq520_filter_parser('xrcd002') TO s_detail1[1].b_xrcd002
            DISPLAY aisq520_filter_parser('xrcd003') TO s_detail1[1].b_xrcd003
            DISPLAY aisq520_filter_parser('xrcd004') TO s_detail1[1].b_xrcd004
            DISPLAY aisq520_filter_parser('xrcd103') TO s_detail1[1].b_xrcd103
            DISPLAY aisq520_filter_parser('xrcd104') TO s_detail1[1].b_xrcd104
            DISPLAY aisq520_filter_parser('xrcd105') TO s_detail1[1].b_xrcd105
            DISPLAY aisq520_filter_parser('xrcd009') TO s_detail1[1].b_xrcd009
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_xrcdld>>----
         #Ctrlp:construct.c.filter.page1.b_xrcdld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcdld
            #add-point:ON ACTION controlp INFIELD b_xrcdld name="construct.c.filter.page1.b_xrcdld"
            
            #END add-point
 
 
         #----<<b_xrcdsite>>----
         #Ctrlp:construct.c.filter.page1.b_xrcdsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcdsite
            #add-point:ON ACTION controlp INFIELD b_xrcdsite name="construct.c.filter.page1.b_xrcdsite"
            
            #END add-point
 
 
         #----<<b_xrcdsite_desc>>----
         #----<<b_xrcddocno>>----
         #Ctrlp:construct.c.filter.page1.b_xrcddocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcddocno
            #add-point:ON ACTION controlp INFIELD b_xrcddocno name="construct.c.filter.page1.b_xrcddocno"
            
            #END add-point
 
 
         #----<<prog_b_xrcddocno>>----
         #----<<b_xrcdseq>>----
         #Ctrlp:construct.c.filter.page1.b_xrcdseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcdseq
            #add-point:ON ACTION controlp INFIELD b_xrcdseq name="construct.c.filter.page1.b_xrcdseq"
            
            #END add-point
 
 
         #----<<b_imaa001>>----
         #----<<b_imaa001_desc>>----
         #----<<b_docdt>>----
         #----<<b_cust>>----
         #----<<b_cust_desc>>----
         #----<<b_xrcd002>>----
         #Ctrlp:construct.c.page1.b_xrcd002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcd002
            #add-point:ON ACTION controlp INFIELD b_xrcd002 name="construct.c.filter.page1.b_xrcd002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xrcd002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrcd002  #顯示到畫面上
            NEXT FIELD b_xrcd002                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_xrcd002_desc>>----
         #----<<b_xrcd003>>----
         #Ctrlp:construct.c.filter.page1.b_xrcd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcd003
            #add-point:ON ACTION controlp INFIELD b_xrcd003 name="construct.c.filter.page1.b_xrcd003"
            
            #END add-point
 
 
         #----<<b_xrcd004>>----
         #Ctrlp:construct.c.filter.page1.b_xrcd004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcd004
            #add-point:ON ACTION controlp INFIELD b_xrcd004 name="construct.c.filter.page1.b_xrcd004"
            
            #END add-point
 
 
         #----<<b_xrcd103>>----
         #Ctrlp:construct.c.filter.page1.b_xrcd103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcd103
            #add-point:ON ACTION controlp INFIELD b_xrcd103 name="construct.c.filter.page1.b_xrcd103"
            
            #END add-point
 
 
         #----<<b_xrcd104>>----
         #Ctrlp:construct.c.filter.page1.b_xrcd104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcd104
            #add-point:ON ACTION controlp INFIELD b_xrcd104 name="construct.c.filter.page1.b_xrcd104"
            
            #END add-point
 
 
         #----<<b_xrcd105>>----
         #Ctrlp:construct.c.filter.page1.b_xrcd105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcd105
            #add-point:ON ACTION controlp INFIELD b_xrcd105 name="construct.c.filter.page1.b_xrcd105"
            
            #END add-point
 
 
         #----<<b_xrcd009>>----
         #Ctrlp:construct.c.page1.b_xrcd009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcd009
            #add-point:ON ACTION controlp INFIELD b_xrcd009 name="construct.c.filter.page1.b_xrcd009"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glac002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrcd009  #顯示到畫面上
            NEXT FIELD b_xrcd009                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_xrcd009_desc>>----
 
 
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
 
 
 
 
 
   #應用 qs03 樣板自動產生(Version:3) 
   # 若有做串查功能，在CONSTRUCT後，需先將顯示欄位開啟、查詢欄位隱藏 
   CALL gfrm_curr.setFieldHidden('b_xrcddocno', TRUE) 
   CALL gfrm_curr.setFieldHidden('prog_b_xrcddocno', FALSE) 
 
  
 
 
 
 
   #add-point:離開DIALOG後相關處理 name="filter.after_dialog"
   
   #end add-point
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
 
      CALL aisq520_filter_show('xrcdld','b_xrcdld')
   CALL aisq520_filter_show('xrcdsite','b_xrcdsite')
   CALL aisq520_filter_show('xrcddocno','b_xrcddocno')
   CALL aisq520_filter_show('xrcdseq','b_xrcdseq')
   CALL aisq520_filter_show('xrcd002','b_xrcd002')
   CALL aisq520_filter_show('xrcd003','b_xrcd003')
   CALL aisq520_filter_show('xrcd004','b_xrcd004')
   CALL aisq520_filter_show('xrcd103','b_xrcd103')
   CALL aisq520_filter_show('xrcd104','b_xrcd104')
   CALL aisq520_filter_show('xrcd105','b_xrcd105')
   CALL aisq520_filter_show('xrcd009','b_xrcd009')
 
 
   CALL aisq520_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aisq520.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION aisq520_filter_parser(ps_field)
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
 
{<section id="aisq520.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION aisq520_filter_show(ps_field,ps_object)
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
   LET ls_condition = aisq520_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="aisq520.get_hyper_data" >}
#應用 qs01 樣板自動產生(Version:9) 
#+ 取得單身串查網址(包含程式代號及參數) 
PRIVATE FUNCTION aisq520_get_hyper_data(ps_field_name) 
   #add-point:get_hyper_data段define-客製 name="get_hyper_data.define_customerization" 
   
   #end add-point 
   DEFINE ps_field_name    STRING 
   DEFINE ps_url           STRING 
   DEFINE ls_js            STRING 
   DEFINE la_param         RECORD 
                           prog       STRING, 
                           actionid   STRING, 
                           background LIKE type_t.chr1, 
                           param      DYNAMIC ARRAY OF STRING 
                           END RECORD 
   DEFINE ps_type          LIKE type_t.chr10 
   #add-point:get_hyper_data段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="get_hyper_data.define" 
   
   #end add-point 
  
  
   #add-point:FUNCTION前置處理 name="get_hyper_data.before_function" 
   
   #end add-point 
  
   LET ps_url = NULL 
  
   # 設定要做串查的程式代碼 
   CASE 
      WHEN ps_field_name = "prog_b_xrcddocno" 
         LET la_param.prog = "aapt300" 
  
         # 設定傳入參數，請依序放置於 la_param.param[1]、la_param.param[2]、... 
         #應用 qs25 樣板自動產生(Version:3)
         #+ 產生串查功能傳入參數部分
 
 
 
         LET la_param.param[1] = g_xrcd_d[l_ac].xrcddocno
         LET la_param.param[2] = g_xrcd_d[l_ac].xrcddocno 
         #add-point:傳入參數設定 name="get_hyper_data.set_parameter_prog_b_xrcddocno" 
         CASE g_xrcd.xrcd001
            WHEN 'aapt300'
               LET la_param.prog = "aapt300" 
               LET la_param.param[1] = g_xrcd_d[l_ac].xrcdld 
               LET la_param.param[2] = g_xrcd_d[l_ac].xrcddocno
            WHEN 'axrt300' #axrt300
               LET la_param.prog = "axrt300" 
               LET la_param.param[1] = g_xrcd_d[l_ac].xrcdld 
               LET la_param.param[2] = g_xrcd_d[l_ac].xrcddocno 
            WHEN 'aist310' #aist310
               LET la_param.prog = "aist310" 
               LET la_param.param[1] = g_xrcd.xrcdcomp
               LET la_param.param[2] = g_xrcd_d[l_ac].xrcddocno 
            WHEN 'axmt500' #axmt500
               LET la_param.prog = "axmt500" 
               LET la_param.param[1] = g_xrcd_d[l_ac].xrcddocno 
            WHEN 'axmt540' #axmt540
               LET la_param.prog = "axmt540" 
               LET la_param.param[1] = g_xrcd_d[l_ac].xrcddocno 
            WHEN 'apmt500' #apmt500
               LET la_param.prog = "apmt500" 
               LET la_param.param[1] = g_xrcd_d[l_ac].xrcddocno 
         END CASE
         #end add-point 
  
 
   END CASE 
  
   # 設定傳入參數，請依序放置於 la_param.param[1]、la_param.param[2]、... 
   #add-point:傳入參數設定 name="get_hyper_data.set_parameter" 
   
   #end add-point 
  
   #將陣列資料組合成一個string字串 
   LET ls_js = util.JSON.stringify(la_param) 
  
   #依環境設定要走GDC或GWC模式 (""表示會依據目前的環境判斷，若有自行定義，會依據所定義的模式去執行) 
   LET ps_type = "" 
   #add-point:定義執行模式 name="get_hyper_data.set_env" 
   
   #end add-point 
  
   #呼叫lib，取得完整的url資訊 
   CALL cl_ap_url(ps_type,ls_js) RETURNING ps_url 
 
   LET ps_url = cl_replace_str(ps_url, "&", "&amp;")  
   RETURN ps_url 
  
END FUNCTION 
 
{</section>}
 
{<section id="aisq520.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aisq520_detail_action_trans()
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
 
{<section id="aisq520.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aisq520_detail_index_setting()
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
            IF g_xrcd_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_xrcd_d.getLength() AND g_xrcd_d.getLength() > 0
            LET g_detail_idx = g_xrcd_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_xrcd_d.getLength() THEN
               LET g_detail_idx = g_xrcd_d.getLength()
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
 
{<section id="aisq520.mask_functions" >}
 &include "erp/ais/aisq520_mask.4gl"
 
{</section>}
 
{<section id="aisq520.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 欄位隱藏
# Memo...........:
# Usage..........: CALL aisq520_comp_visible()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/10/01 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION aisq520_comp_visible()

   CALL cl_set_comp_visible('b_xrcdsite_desc',TRUE)
   CALL cl_set_comp_visible('prog_b_xrcddocno',TRUE)
   CALL cl_set_comp_visible('b_xrcdseq',TRUE)
   CALL cl_set_comp_visible('b_cust',TRUE)
   CALL cl_set_comp_visible('b_cust_desc',TRUE)
   CALL cl_set_comp_visible('b_imaa001_desc',TRUE)
   CALL cl_set_comp_visible('b_docdt',TRUE)
   CALL cl_set_comp_visible('b_xrcd002_desc',TRUE)
   CALL cl_set_comp_visible('b_xrcd003',TRUE)
   CALL cl_set_comp_visible('b_xrcd004',TRUE)
   CALL cl_set_comp_visible('b_xrcd009_desc',TRUE)
   
   CASE g_xrcd.condition
      WHEN '1' #依單據號碼
         CALL cl_set_comp_visible('b_xrcdseq',FALSE)
         CALL cl_set_comp_visible('b_imaa001_desc',FALSE)
         CALL cl_set_comp_visible('b_xrcd002_desc',FALSE)
         CALL cl_set_comp_visible('b_xrcd003',FALSE)
         CALL cl_set_comp_visible('b_xrcd004',FALSE)
         CALL cl_set_comp_visible('b_xrcd009_desc',FALSE)
      WHEN '2' #依稅別
         CALL cl_set_comp_visible('b_xrcdsite_desc',FALSE)
         CALL cl_set_comp_visible('prog_b_xrcddocno',FALSE)
         CALL cl_set_comp_visible('b_xrcdseq',FALSE)
         CALL cl_set_comp_visible('b_cust',FALSE)
         CALL cl_set_comp_visible('b_cust_desc',FALSE)
         CALL cl_set_comp_visible('b_imaa001_desc',FALSE)
         CALL cl_set_comp_visible('b_docdt',FALSE)
         CALL cl_set_comp_visible('b_xrcd009_desc',FALSE)
      WHEN '3' #依營運據點+稅別
         CALL cl_set_comp_visible('prog_b_xrcddocno',FALSE)
         CALL cl_set_comp_visible('b_xrcdseq',FALSE)
         CALL cl_set_comp_visible('b_cust',FALSE)
         CALL cl_set_comp_visible('b_cust_desc',FALSE)
         CALL cl_set_comp_visible('b_imaa001_desc',FALSE)
         CALL cl_set_comp_visible('b_docdt',FALSE)
         CALL cl_set_comp_visible('b_xrcd003',FALSE)
         CALL cl_set_comp_visible('b_xrcd009_desc',FALSE)
      WHEN '4' #明細顯示
         CALL cl_set_comp_visible('b_cust',FALSE)
         CALL cl_set_comp_visible('b_cust_desc',FALSE)
         CALL cl_set_comp_visible('b_docdt',FALSE)
         IF g_xrcd.xrcd001 = 'axrt300' OR g_xrcd.xrcd001 = 'aapt300' THEN
         ELSE
            CALL cl_set_comp_visible('b_xrcd009_desc',FALSE)
         END IF
   END CASE
END FUNCTION
################################################################################
# Descriptions...: 清空&給預設 #150127-00007#1
# Memo...........:
# Usage..........: CALL aisq520_qbe_clear()
# Date & Author..: 2015/02/26 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq520_qbe_clear()
DEFINE l_ld      LIKE glaa_t.glaald

   INITIALIZE g_xrcd.* TO NULL
   CALL g_xrcd_d.clear()
   
   CALL s_fin_ld_carry('',g_user) RETURNING g_sub_success,l_ld,g_xrcd.xrcdcomp,g_errno
   CALL s_desc_get_department_desc(g_xrcd.xrcdcomp) RETURNING g_xrcd.xrcdcomp_desc
   DISPLAY BY NAME g_xrcd.xrcdcomp_desc
   
   LET g_xrcd.xrcd001 = 'aapt300'
   LET g_xrcd.condition = '2'
   LET g_xrcd_o.* = g_xrcd.*
   LET g_wc = " 1=1"
   
   CALL aisq520_comp_visible()
   
   #161006-00005#28 add ------
   CALL s_fin_account_center_sons_query('3',g_site,g_today,'')
   CALL s_fin_account_center_comp_str() RETURNING g_wc_xrcdcomp
   CALL s_fin_get_wc_str(g_wc_xrcdcomp) RETURNING g_wc_xrcdcomp
   CALL s_fin_account_center_sons_str() RETURNING g_wc_xrcdsite
   CALL s_fin_get_wc_str(g_wc_xrcdsite) RETURNING g_wc_xrcdsite
   #161006-00005#28 add end---
   
END FUNCTION

 
{</section>}
 
