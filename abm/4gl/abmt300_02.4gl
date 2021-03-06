#該程式未解開Section, 採用最新樣板產出!
{<section id="abmt300_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2014-06-29 21:52:14), PR版次:0007(2016-04-13 14:24:56)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000274
#+ Filename...: abmt300_02
#+ Description: ECN特徵管理維護
#+ Creator....: 01258(2013-08-16 10:37:46)
#+ Modifier...: 02295 -SD/PR- 07900
 
{</section>}
 
{<section id="abmt300_02.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00025#18 2016/04/13 BY 07900    校验代码重复错误讯息的修改
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point 
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_bmfb_m        RECORD
       bmfbdocno LIKE bmfb_t.bmfbdocno, 
   bmfb005 LIKE bmfb_t.bmfb005, 
   bmfb006 LIKE bmfb_t.bmfb006, 
   bmfb002 LIKE bmfb_t.bmfb002, 
   bmfb005_desc LIKE type_t.chr500, 
   bmfb006_desc LIKE type_t.chr500, 
   bmfb003 LIKE bmfb_t.bmfb003, 
   bmfb005_desc1 LIKE type_t.chr500, 
   bmfb006_desc1 LIKE type_t.chr500, 
   bmfa003 LIKE bmfa_t.bmfa003, 
   bmfb008 LIKE bmfb_t.bmfb008, 
   bmfb008_desc LIKE type_t.chr80, 
   bmfa003_desc LIKE type_t.chr500, 
   bmfb009 LIKE bmfb_t.bmfb009, 
   bmfb009_desc LIKE type_t.chr80, 
   bmfa003_desc1 LIKE type_t.chr500, 
   bmfb010 LIKE bmfb_t.bmfb010
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_bmfi_d        RECORD
       bmfi003 LIKE bmfi_t.bmfi003, 
   bmfi003_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_bmfi2_d RECORD
       bmfk003 LIKE bmfk_t.bmfk003, 
   bmfk003_desc LIKE type_t.chr500, 
   bmfk004 LIKE bmfk_t.bmfk004
       END RECORD
PRIVATE TYPE type_g_bmfi3_d RECORD
       bmfm003 LIKE bmfm_t.bmfm003, 
   bmfm003_desc LIKE type_t.chr500
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_bmfbdocno LIKE bmfb_t.bmfbdocno,
      b_bmfb002 LIKE bmfb_t.bmfb002
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_bmfi4_d        RECORD
        bmfj004 LIKE bmfj_t.bmfj004,
        bmfj005 LIKE bmfj_t.bmfj005,
        bmfj006 LIKE bmfj_t.bmfj006
        END RECORD
        
 TYPE type_g_bmfi5_d        RECORD
        bmfl004 LIKE bmfl_t.bmfl004,
        bmfl005 LIKE bmfl_t.bmfl005
        END RECORD
        
PRIVATE TYPE type_g_bmfi6_d        RECORD
        bmfn004 LIKE bmfn_t.bmfn004,
        bmfn005 LIKE bmfn_t.bmfn005,
        bmfn006 LIKE bmfn_t.bmfn006
        END RECORD
DEFINE g_bmfi4_d   DYNAMIC ARRAY OF type_g_bmfi4_d
DEFINE g_bmfi4_d_t type_g_bmfi4_d
DEFINE g_bmfi5_d   DYNAMIC ARRAY OF type_g_bmfi5_d
DEFINE g_bmfi5_d_t type_g_bmfi5_d
DEFINE g_bmfi6_d   DYNAMIC ARRAY OF type_g_bmfi6_d
DEFINE g_bmfi6_d_t type_g_bmfi6_d
DEFINE g_rec_b1             LIKE type_t.num5           
DEFINE l_ac1                LIKE type_t.num5

DEFINE g_type               LIKE type_t.chr1
DEFINE g_bmfbdocno          LIKE bmfb_t.bmfbdocno
DEFINE g_bmfa003            LIKE bmfa_t.bmfa003
DEFINE g_bmfb002            LIKE bmfb_t.bmfb002
DEFINE g_bmfb003            LIKE bmfb_t.bmfb003
DEFINE g_bmfb005            LIKE bmfb_t.bmfb005
DEFINE g_bmfb006            LIKE bmfb_t.bmfb006
DEFINE g_bmfb008            LIKE bmfb_t.bmfb008
DEFINE g_bmfb009            LIKE bmfb_t.bmfb009
DEFINE g_bmfb010            LIKE bmfb_t.bmfb010
DEFINE g_type1              LIKE type_t.chr1
DEFINE g_type2              LIKE type_t.chr1
#end add-point
       
#模組變數(Module Variables)
DEFINE g_bmfb_m          type_g_bmfb_m
DEFINE g_bmfb_m_t        type_g_bmfb_m
DEFINE g_bmfb_m_o        type_g_bmfb_m
DEFINE g_bmfb_m_mask_o   type_g_bmfb_m #轉換遮罩前資料
DEFINE g_bmfb_m_mask_n   type_g_bmfb_m #轉換遮罩後資料
 
   DEFINE g_bmfbdocno_t LIKE bmfb_t.bmfbdocno
DEFINE g_bmfb002_t LIKE bmfb_t.bmfb002
 
 
DEFINE g_bmfi_d          DYNAMIC ARRAY OF type_g_bmfi_d
DEFINE g_bmfi_d_t        type_g_bmfi_d
DEFINE g_bmfi_d_o        type_g_bmfi_d
DEFINE g_bmfi_d_mask_o   DYNAMIC ARRAY OF type_g_bmfi_d #轉換遮罩前資料
DEFINE g_bmfi_d_mask_n   DYNAMIC ARRAY OF type_g_bmfi_d #轉換遮罩後資料
DEFINE g_bmfi2_d          DYNAMIC ARRAY OF type_g_bmfi2_d
DEFINE g_bmfi2_d_t        type_g_bmfi2_d
DEFINE g_bmfi2_d_o        type_g_bmfi2_d
DEFINE g_bmfi2_d_mask_o   DYNAMIC ARRAY OF type_g_bmfi2_d #轉換遮罩前資料
DEFINE g_bmfi2_d_mask_n   DYNAMIC ARRAY OF type_g_bmfi2_d #轉換遮罩後資料
DEFINE g_bmfi3_d          DYNAMIC ARRAY OF type_g_bmfi3_d
DEFINE g_bmfi3_d_t        type_g_bmfi3_d
DEFINE g_bmfi3_d_o        type_g_bmfi3_d
DEFINE g_bmfi3_d_mask_o   DYNAMIC ARRAY OF type_g_bmfi3_d #轉換遮罩前資料
DEFINE g_bmfi3_d_mask_n   DYNAMIC ARRAY OF type_g_bmfi3_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
 
 
DEFINE g_wc2_extend          STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
 
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5        
DEFINE g_rec_b               LIKE type_t.num10           
DEFINE l_ac                  LIKE type_t.num10    
DEFINE g_curr_diag           ui.Dialog                         #Current Dialog
                                                               
DEFINE g_pagestart           LIKE type_t.num10                 
DEFINE gwin_curr             ui.Window                         #Current Window
DEFINE gfrm_curr             ui.Form                           #Current Form
DEFINE g_page_action         STRING                            #page action
DEFINE g_header_hidden       LIKE type_t.num5                  #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5                  #隱藏工作Panel
DEFINE g_page                STRING                            #第幾頁
DEFINE g_state               STRING       
DEFINE g_header_cnt          LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10                  #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx_tmp      LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10                  #單身2目前所在筆數
DEFINE g_detail_idx_list     DYNAMIC ARRAY OF LIKE type_t.num10 #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10                  #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10                  #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10                  #Browser目前所在筆數(暫存用)
DEFINE g_order               STRING                             #查詢排序欄位
                                                        
DEFINE g_current_row         LIKE type_t.num10                  #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                            #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10                  #目前所在頁數
DEFINE g_insert              LIKE type_t.chr5                   #是否導到其他page
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
DEFINE g_error_show          LIKE type_t.num5              #是否顯示筆數提示訊息
DEFINE g_master_insert       BOOLEAN                       #確認單頭資料是否寫入
 
DEFINE g_wc_frozen           STRING                        #凍結欄位使用
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_loc                 LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_add_browse          STRING                        #新增填充用WC
DEFINE g_update              BOOLEAN                       #確定單頭/身是否異動過
DEFINE g_idx_group           om.SaxAttributes              #頁籤群組
DEFINE g_master_commit       LIKE type_t.chr1              #確認單頭是否修改過
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="abmt300_02.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION abmt300_02(--)
   #add-point:main段變數傳入 name="main.get_var"
   p_type,p_bmfbdocno,p_bmfa003,p_bmfb002,p_bmfb003,p_bmfb005,p_bmfb006,p_bmfb008,p_bmfb009,p_bmfb010,p_type1,p_type2
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE p_type               LIKE type_t.chr1
   DEFINE p_bmfbdocno          LIKE bmfb_t.bmfbdocno
   DEFINE p_bmfa003            LIKE bmfa_t.bmfa003
   DEFINE p_bmfb002            LIKE bmfb_t.bmfb002
   DEFINE p_bmfb003            LIKE bmfb_t.bmfb003
   DEFINE p_bmfb005            LIKE bmfb_t.bmfb005
   DEFINE p_bmfb006            LIKE bmfb_t.bmfb006
   DEFINE p_bmfb008            LIKE bmfb_t.bmfb008
   DEFINE p_bmfb009            LIKE bmfb_t.bmfb009
   DEFINE p_bmfb010            LIKE bmfb_t.bmfb010
   DEFINE p_type1              LIKE type_t.chr1
   DEFINE p_type2              LIKE type_t.chr1
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化 name="main.init"
   LET g_type = p_type
   LET g_bmfbdocno = p_bmfbdocno
   LET g_bmfa003 = p_bmfa003
   LET g_bmfb005 = p_bmfb005
   LET g_bmfb006 = p_bmfb006
   LET g_bmfb002 = p_bmfb002
   LET g_bmfb003 = p_bmfb003
   LET g_bmfb008 = p_bmfb008
   LET g_bmfb009 = p_bmfb009
   LET g_bmfb010 = p_bmfb010
   LET g_bmfb_m.bmfbdocno = g_bmfbdocno
   LET g_bmfb_m.bmfa003 = g_bmfa003
   LET g_bmfb_m.bmfb005 = g_bmfb005
   LET g_bmfb_m.bmfb006 = g_bmfb006
   LET g_bmfb_m.bmfb002 = g_bmfb002
   LET g_bmfb_m.bmfb003 = g_bmfb003
   LET g_bmfb_m.bmfb008 = g_bmfb008
   LET g_bmfb_m.bmfb009 = g_bmfb009
   LET g_bmfb_m.bmfb010 = g_bmfb010
   LET g_type1 = p_type1
   LET g_type2 = p_type2
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = "SELECT bmfbdocno,bmfb005,bmfb006,bmfb002,'','',bmfb003,'','','',bmfb008,'','', 
       bmfb009,'','',bmfb010 FROM bmfb_t WHERE bmfbent= ? AND bmfbsite= ? AND bmfbdocno=? AND bmfb002=?  
       FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)   #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abmt300_02_cl CURSOR FROM g_forupd_sql     # LOCK CURSOR
 
   LET g_sql = " SELECT t0.bmfbdocno,t0.bmfb005,t0.bmfb006,t0.bmfb002,t0.bmfb003,t0.bmfb008,t0.bmfb009, 
       t0.bmfb010",
               " FROM bmfb_t t0",
               " WHERE bmfbent = " ||g_enterprise|| " AND bmfbsite = '" ||g_site|| "' AND t0.bmfbdocno = ? AND t0.bmfb002 = ?"
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE abmt300_02_master_referesh FROM g_sql
   
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_abmt300_02 WITH FORM cl_ap_formpath("abm","abmt300_02")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL abmt300_02_init()   
 
   #進入選單 Menu (="N")
   CALL abmt300_02_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_abmt300_02
 
   CLOSE abmt300_02_cl
   
   
 
   #add-point:離開前 name="main.exit"
   LET g_action_choice=''
   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abmt300_02.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION abmt300_02_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1 #第一層單身指標
   LET g_detail_idx2 = 1 #第二層單身指標
   
   #各個page指標
   LET g_detail_idx_list[1] = 1 
   LET g_detail_idx_list[2] = 1
   LET g_detail_idx_list[3] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
   
      CALL cl_set_combo_scc('bmfb003','1109') 
   CALL cl_set_combo_scc('bmfk004','1106') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   IF g_type = '2' THEN
      CALL cl_set_comp_visible("bmfa003",FALSE)
      CALL cl_set_comp_visible("bmfa003_desc",FALSE)
      CALL cl_set_comp_visible("bmfa003_desc1",FALSE)
      CALL cl_set_comp_visible("lbl_bmfa003",FALSE)
      CALL cl_set_comp_visible("lbl_bmfa003_desc",FALSE)
      CALL cl_set_comp_visible("lbl_bmfa003_desc1",FALSE)
   ELSE
      CALL cl_set_comp_visible("bmfa003",TRUE)
      CALL cl_set_comp_visible("bmfa003_desc",TRUE)
      CALL cl_set_comp_visible("bmfa003_desc1",TRUE)
      CALL cl_set_comp_visible("lbl_bmfa003",TRUE)
      CALL cl_set_comp_visible("lbl_bmfa003_desc",TRUE)
      CALL cl_set_comp_visible("lbl_bmfa003_desc1",TRUE)
   END IF
   CALL abmt300_02_default(g_bmfbdocno,g_bmfb002,g_bmfb005,g_bmfb008,g_bmfb009,g_bmfb010,'Y')
   CALL abmt300_02_del_no_exists()
   CALL abmt300_02_bmfb_show()
   #end add-point
   
   #初始化搜尋條件
   CALL abmt300_02_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION abmt300_02_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_idx     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE lb_first   BOOLEAN
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE la_param   RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
          END RECORD
   DEFINE ls_js      STRING
   DEFINE la_output  DYNAMIC ARRAY OF STRING   #報表元件鬆耦合使用
   DEFINE  l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE  l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE  l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   
   #action default動作
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL abmt300_02_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   CALL abmt300_02_bmfb_show()
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_bmfb_m.* TO NULL
         CALL g_bmfi_d.clear()
         CALL g_bmfi2_d.clear()
         CALL g_bmfi3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL abmt300_02_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_bmfi_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL abmt300_02_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               CALL abmt300_02_b_fill1()
               DISPLAY ARRAY g_bmfi4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b1)
                  BEFORE DISPLAY
                    EXIT DISPLAY
               END DISPLAY
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL abmt300_02_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_bmfi2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL abmt300_02_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL abmt300_02_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_bmfi3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL abmt300_02_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("'3',",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body3.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               #顯示單身筆數
               CALL abmt300_02_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_bmfi4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b1)  
         
            BEFORE ROW
               CALL abmt300_02_idx_chk()
               LET l_ac1 = DIALOG.getCurrentRow("s_detail4")
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac1 = DIALOG.getCurrentRow("s_detail4")
               CALL abmt300_02_idx_chk()
               LET g_current_page = 4
               
         END DISPLAY
         DISPLAY ARRAY g_bmfi5_d TO s_detail5.* ATTRIBUTES(COUNT=g_rec_b1)  
         
            BEFORE ROW
               CALL abmt300_02_idx_chk()
               LET l_ac1 = DIALOG.getCurrentRow("s_detail5")
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac1 = DIALOG.getCurrentRow("s_detail5")
               CALL abmt300_02_idx_chk()
               LET g_current_page = 5
               
         END DISPLAY
         DISPLAY ARRAY g_bmfi6_d TO s_detail6.* ATTRIBUTES(COUNT=g_rec_b1)  
         
            BEFORE ROW
               CALL abmt300_02_idx_chk()
               LET l_ac1 = DIALOG.getCurrentRow("s_detail6")
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac1 = DIALOG.getCurrentRow("s_detail6")
               CALL abmt300_02_idx_chk()
               LET g_current_page = 6
               
         END DISPLAY
         #end add-point
         
      
         BEFORE DIALOG
            #先填充browser資料
            CALL abmt300_02_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            
            #確保g_current_idx位於正常區間內
            #小於,等於0則指到第1筆
            IF g_current_idx <= 0 THEN
               LET g_current_idx = 1
            END IF
            #超過最大筆數則指到最後1筆
            IF g_current_idx > g_browser.getLength() THEN
               LEt g_current_idx = g_browser.getLength()
            END IF 
            
            LET g_current_sw = TRUE
            LET g_current_row = g_current_idx #目前指標
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL abmt300_02_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL abmt300_02_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL abmt300_02_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            CALL abmt300_02_bmfb_show()
            CALL abmt300_02_b_fill()
            CALL abmt300_02_b_fill1()
            IF g_type1 = 'N' THEN
               CALL cl_set_act_visible("insert,modify,delete",FALSE)
            ELSE
               CALL cl_set_act_visible("insert,modify,delete",TRUE)
            END IF
            IF g_type2 = 'Y' THEN
               CALL abmt300_02_insert()
            END IF
            CALL abmt300_02_b_fill()
            CALL abmt300_02_b_fill1()
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
 
 
         
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "bmfb_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "bmfi_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "bmfk_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "bmfm_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL abmt300_02_browser_fill("F")   #browser_fill()會將notice區塊清空
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "bmfb_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "bmfi_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "bmfk_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "bmfm_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL abmt300_02_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL abmt300_02_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL abmt300_02_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abmt300_02_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL abmt300_02_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abmt300_02_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL abmt300_02_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abmt300_02_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL abmt300_02_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abmt300_02_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL abmt300_02_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abmt300_02_idx_chk()
          
         #excel匯出功能          
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               #browser
               CALL g_export_node.clear()
               IF g_main_hidden = 1 THEN
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
               #非browser
               ELSE
                  LET g_export_node[1] = base.typeInfo.create(g_bmfi_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_bmfi2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_bmfi3_d)
                  LET g_export_id[3]   = "s_detail3"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  
                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
        
         ON ACTION close
            LET INT_FLAG = FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
    
         #主頁摺疊
         ON ACTION mainhidden       
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
               CALL cl_notice()
            END IF
            
       
         #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
         ON ACTION controls     
            IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("vb_master",0)
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("vb_master",1)
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden     
            END IF
    
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL abmt300_02_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL abmt300_02_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL abmt300_02_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL abmt300_02_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL abmt300_02_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL abmt300_02_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL abmt300_02_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
         
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
    
         #交談指令共用ACTION
         &include "common_action.4gl" 
            CONTINUE DIALOG
      END DIALOG
 
      #(ver:79) ---add start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:79) --- add end ---
    
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
    
   END WHILE    
      
   CALL cl_set_act_visible("accept,cancel", TRUE)
    
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION abmt300_02_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   
   #end add-point
   
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
 
   #add-point:browser_fill,foreach前 name="browser_fill.before_foreach"
   
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT bmfbdocno,bmfb002 ",
                      " FROM bmfb_t ",
                      " ",
                      " LEFT JOIN bmfi_t ON bmfient = bmfbent AND bmfisite = bmfbsite AND bmfbdocno = bmfidocno AND bmfb002 = bmfi002 ", "  ",
                      #add-point:browser_fill段sql(bmfi_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN bmfk_t ON bmfkent = bmfbent AND bmfksite = bmfbsite AND bmfbdocno = bmfkdocno AND bmfb002 = bmfk002", "  ",
                      #add-point:browser_fill段sql(bmfk_t1) name="browser_fill.cnt.join.bmfk_t1"
                      
                      #end add-point
 
                      " LEFT JOIN bmfm_t ON bmfment = bmfbent AND bmfmsite = bmfbsite AND bmfbdocno = bmfmdocno AND bmfb002 = bmfm002", "  ",
                      #add-point:browser_fill段sql(bmfm_t1) name="browser_fill.cnt.join.bmfm_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
                      " ",                      
 
 
 
                      " WHERE bmfbent = " ||g_enterprise|| " AND bmfbsite = '" ||g_site|| "' AND bmfient = " ||g_enterprise|| " AND bmfisite = '" ||g_site|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("bmfb_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT bmfbdocno,bmfb002 ",
                      " FROM bmfb_t ", 
                      "  ",
                      "  ",
                      " WHERE bmfbent = " ||g_enterprise|| " AND bmfbsite = '" ||g_site|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("bmfb_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   
   #end add-point
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   
   #end add-point
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE header_cnt_pre FROM g_sql
      EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
      FREE header_cnt_pre
   END IF
    
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt
         LET g_errparam.code = 9035 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
      END IF
      LET g_browser_cnt = g_max_browse
   END IF
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
 
   #根據行為確定資料填充位置及WC
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_bmfb_m.* TO NULL
      CALL g_bmfi_d.clear()        
      CALL g_bmfi2_d.clear() 
      CALL g_bmfi3_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.bmfbdocno,t0.bmfb002 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT '',t0.bmfbdocno,t0.bmfb002 ",
                  " FROM bmfb_t t0",
                  "  ",
                  "  LEFT JOIN bmfi_t ON bmfient = bmfbent AND bmfisite = bmfbsite AND bmfbdocno = bmfidocno AND bmfb002 = bmfi002 ", "  ", 
                  #add-point:browser_fill段sql(bmfi_t1) name="browser_fill.join.bmfi_t1"
                  
                  #end add-point
                  "  LEFT JOIN bmfk_t ON bmfkent = bmfbent AND bmfksite = bmfbsite AND bmfbdocno = bmfkdocno AND bmfb002 = bmfk002", "  ", 
                  #add-point:browser_fill段sql(bmfk_t1) name="browser_fill.join.bmfk_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN bmfm_t ON bmfment = bmfbent AND bmfmsite = bmfbsite AND bmfbdocno = bmfmdocno AND bmfb002 = bmfm002", "  ", 
                  #add-point:browser_fill段sql(bmfm_t1) name="browser_fill.join.bmfm_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
                  " ",                      
 
 
 
                  
                  " WHERE t0.bmfbent = " ||g_enterprise|| " AND t0.bmfbsite = '" ||g_site|| "' AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("bmfb_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT '',t0.bmfbdocno,t0.bmfb002 ",
                  " FROM bmfb_t t0",
                  "  ",
                  
                  " WHERE t0.bmfbent = " ||g_enterprise|| " AND t0.bmfbsite = '" ||g_site|| "' AND ",l_wc, cl_sql_add_filter("bmfb_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY bmfbdocno,bmfb002 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"bmfb_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_bmfbdocno,g_browser[g_cnt].b_bmfb002 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
         
         #end add-point
      
      
         
         LET g_cnt = g_cnt + 1
         IF g_cnt > g_max_browse THEN
            EXIT FOREACH
         END IF
         
      END FOREACH
      FREE browse_pre
   END IF
   
   #清空g_add_browse, 並指定指標位置
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = ""
      CALL g_curr_diag.setCurrentRow("s_browse",g_current_idx)
   END IF
   
   IF cl_null(g_browser[g_cnt].b_bmfbdocno) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   LET g_header_cnt  = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   
   #筆數顯示
   IF g_browser_cnt > 0 THEN
      DISPLAY g_browser_idx TO FORMONLY.b_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.b_count #總筆數
      DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
      DISPLAY g_detail_idx  TO FORMONLY.idx     #單身當下筆數
      DISPLAY g_detail_cnt  TO FORMONLY.cnt     #單身總筆數
   ELSE
      DISPLAY '' TO FORMONLY.b_index #當下筆數
      DISPLAY '' TO FORMONLY.b_count #總筆數
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
      DISPLAY '' TO FORMONLY.idx     #單身當下筆數
      DISPLAY '' TO FORMONLY.cnt     #單身總筆數
   END IF
 
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
 
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
                  
   
   #add-point:browser_fill段結束前 name="browser_fill.after"
   
   #end add-point   
 
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION abmt300_02_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_bmfb_m.bmfbdocno = g_browser[g_current_idx].b_bmfbdocno   
   LET g_bmfb_m.bmfb002 = g_browser[g_current_idx].b_bmfb002   
 
   EXECUTE abmt300_02_master_referesh USING g_site,g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002 INTO g_bmfb_m.bmfbdocno, 
       g_bmfb_m.bmfb005,g_bmfb_m.bmfb006,g_bmfb_m.bmfb002,g_bmfb_m.bmfb003,g_bmfb_m.bmfb008,g_bmfb_m.bmfb009, 
       g_bmfb_m.bmfb010,g_bmfb_m.bmfb008_desc,g_bmfb_m.bmfb009_desc
   
   CALL abmt300_02_bmfb_t_mask()
   CALL abmt300_02_show()
      
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION abmt300_02_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION abmt300_02_ui_browser_refresh()
   #add-point:ui_browser_refresh段define(客製用) name="ui_browser_refresh.define_customerization"
   
   #end add-point    
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_bmfbdocno = g_bmfb_m.bmfbdocno 
         AND g_browser[l_i].b_bmfb002 = g_bmfb_m.bmfb002 
 
         THEN
         CALL g_browser.deleteElement(l_i)
         EXIT FOR
      END IF
   END FOR
   LET g_browser_cnt = g_browser_cnt - 1
   LET g_header_cnt = g_header_cnt - 1
    
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
      CLEAR FORM
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
   
   #add-point:ui_browser_refresh段after name="ui_browser_refresh.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION abmt300_02_construct()
   #add-point:cs段define(客製用) name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   DEFINE la_wc       DYNAMIC ARRAY OF RECORD
          tableid     STRING,
          wc          STRING
          END RECORD
   DEFINE li_idx      LIKE type_t.num10
   #add-point:cs段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_bmfb_m.* TO NULL
   CALL g_bmfi_d.clear()        
   CALL g_bmfi2_d.clear() 
   CALL g_bmfi3_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON bmfbdocno,bmfb005,bmfb006,bmfb002,bmfb003,bmfa003,bmfb008,bmfb009,bmfb010 
 
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmfbdocno
            #add-point:BEFORE FIELD bmfbdocno name="construct.b.bmfbdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmfbdocno
            
            #add-point:AFTER FIELD bmfbdocno name="construct.a.bmfbdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bmfbdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmfbdocno
            #add-point:ON ACTION controlp INFIELD bmfbdocno name="construct.c.bmfbdocno"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bmfb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmfb005
            #add-point:ON ACTION controlp INFIELD bmfb005 name="construct.c.bmfb005"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmfb005  #顯示到畫面上

            NEXT FIELD bmfb005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmfb005
            #add-point:BEFORE FIELD bmfb005 name="construct.b.bmfb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmfb005
            
            #add-point:AFTER FIELD bmfb005 name="construct.a.bmfb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bmfb006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmfb006
            #add-point:ON ACTION controlp INFIELD bmfb006 name="construct.c.bmfb006"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmfb006  #顯示到畫面上

            NEXT FIELD bmfb006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmfb006
            #add-point:BEFORE FIELD bmfb006 name="construct.b.bmfb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmfb006
            
            #add-point:AFTER FIELD bmfb006 name="construct.a.bmfb006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmfb002
            #add-point:BEFORE FIELD bmfb002 name="construct.b.bmfb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmfb002
            
            #add-point:AFTER FIELD bmfb002 name="construct.a.bmfb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bmfb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmfb002
            #add-point:ON ACTION controlp INFIELD bmfb002 name="construct.c.bmfb002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmfb003
            #add-point:BEFORE FIELD bmfb003 name="construct.b.bmfb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmfb003
            
            #add-point:AFTER FIELD bmfb003 name="construct.a.bmfb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bmfb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmfb003
            #add-point:ON ACTION controlp INFIELD bmfb003 name="construct.c.bmfb003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bmfa003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmfa003
            #add-point:ON ACTION controlp INFIELD bmfa003 name="construct.c.bmfa003"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_bmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmfa003  #顯示到畫面上

            NEXT FIELD bmfa003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmfa003
            #add-point:BEFORE FIELD bmfa003 name="construct.b.bmfa003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmfa003
            
            #add-point:AFTER FIELD bmfa003 name="construct.a.bmfa003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmfb008
            #add-point:BEFORE FIELD bmfb008 name="construct.b.bmfb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmfb008
            
            #add-point:AFTER FIELD bmfb008 name="construct.a.bmfb008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bmfb008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmfb008
            #add-point:ON ACTION controlp INFIELD bmfb008 name="construct.c.bmfb008"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmfb008  #顯示到畫面上

            NEXT FIELD bmfb008                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmfb009
            #add-point:BEFORE FIELD bmfb009 name="construct.b.bmfb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmfb009
            
            #add-point:AFTER FIELD bmfb009 name="construct.a.bmfb009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bmfb009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmfb009
            #add-point:ON ACTION controlp INFIELD bmfb009 name="construct.c.bmfb009"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmfb009  #顯示到畫面上

            NEXT FIELD bmfb009                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmfb010
            #add-point:BEFORE FIELD bmfb010 name="construct.b.bmfb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmfb010
            
            #add-point:AFTER FIELD bmfb010 name="construct.a.bmfb010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bmfb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmfb010
            #add-point:ON ACTION controlp INFIELD bmfb010 name="construct.c.bmfb010"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON bmfi003
           FROM s_detail1[1].bmfi003
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmfi003
            #add-point:BEFORE FIELD bmfi003 name="construct.b.page1.bmfi003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmfi003
            
            #add-point:AFTER FIELD bmfi003 name="construct.a.page1.bmfi003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmfi003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmfi003
            #add-point:ON ACTION controlp INFIELD bmfi003 name="construct.c.page1.bmfi003"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON bmfk003,bmfk004
           FROM s_detail2[1].bmfk003,s_detail2[1].bmfk004
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmfk003
            #add-point:BEFORE FIELD bmfk003 name="construct.b.page2.bmfk003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmfk003
            
            #add-point:AFTER FIELD bmfk003 name="construct.a.page2.bmfk003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bmfk003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmfk003
            #add-point:ON ACTION controlp INFIELD bmfk003 name="construct.c.page2.bmfk003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmfk004
            #add-point:BEFORE FIELD bmfk004 name="construct.b.page2.bmfk004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmfk004
            
            #add-point:AFTER FIELD bmfk004 name="construct.a.page2.bmfk004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bmfk004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmfk004
            #add-point:ON ACTION controlp INFIELD bmfk004 name="construct.c.page2.bmfk004"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON bmfm003
           FROM s_detail3[1].bmfm003
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmfm003
            #add-point:BEFORE FIELD bmfm003 name="construct.b.page3.bmfm003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmfm003
            
            #add-point:AFTER FIELD bmfm003 name="construct.a.page3.bmfm003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.bmfm003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmfm003
            #add-point:ON ACTION controlp INFIELD bmfm003 name="construct.c.page3.bmfm003"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         
         #end add-point  
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
         IF NOT cl_null(ls_wc) THEN
            CALL util.JSON.parse(ls_wc, la_wc)
            INITIALIZE g_wc, g_wc2, g_wc2_table1, g_wc2_extend TO NULL
            INITIALIZE g_wc2_table2 TO NULL
 
            INITIALIZE g_wc2_table3 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "bmfb_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "bmfi_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "bmfk_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "bmfm_t" 
                     LET g_wc2_table3 = la_wc[li_idx].wc
 
 
               END CASE
            END FOR
         END IF
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
   END DIALOG
   
   #組合g_wc2
   LET g_wc2 = g_wc2_table1
   IF g_wc2_table2 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
   END IF
 
   IF g_wc2_table3 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
   END IF
 
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION abmt300_02_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_bmfi_d.clear()
   CALL g_bmfi2_d.clear()
   CALL g_bmfi3_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL abmt300_02_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL abmt300_02_browser_fill("")
      CALL abmt300_02_fetch("")
      RETURN
   END IF
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||") AND ("||g_wc2||")")
   
   #搜尋後資料初始化 
   LET g_detail_cnt  = 0
   LET g_current_idx = 1
   LET g_current_row = 0
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_detail_idx_list[1] = 1
   LET g_detail_idx_list[2] = 1
   LET g_detail_idx_list[3] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
   CALL abmt300_02_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL abmt300_02_fetch("F") 
      #顯示單身筆數
      CALL abmt300_02_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION abmt300_02_fetch(p_flag)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point    
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
 
   #清空第二階單身
 
   
   CALL cl_ap_performance_next_start()
   CASE p_flag
      WHEN 'F' 
         LET g_current_idx = 1
      WHEN 'L'  
         LET g_current_idx = g_browser.getLength()              
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
         
         IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
             LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE  
   END CASE 
 
   
   LET g_current_row = g_current_idx
   LET g_detail_cnt = g_header_cnt                  
   
   #單身總筆數顯示
   IF g_detail_cnt > 0 THEN
      #若單身有資料時, idx至少為1
      IF g_detail_idx <= 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY '' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_pagestart = g_current_idx
   DISPLAY g_pagestart TO FORMONLY.b_index   #當下筆數
   DISPLAY g_pagestart TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_pagestart, g_browser_cnt )
 
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_bmfb_m.bmfbdocno = g_browser[g_current_idx].b_bmfbdocno
   LET g_bmfb_m.bmfb002 = g_browser[g_current_idx].b_bmfb002
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE abmt300_02_master_referesh USING g_site,g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002 INTO g_bmfb_m.bmfbdocno, 
       g_bmfb_m.bmfb005,g_bmfb_m.bmfb006,g_bmfb_m.bmfb002,g_bmfb_m.bmfb003,g_bmfb_m.bmfb008,g_bmfb_m.bmfb009, 
       g_bmfb_m.bmfb010,g_bmfb_m.bmfb008_desc,g_bmfb_m.bmfb009_desc
   
   #遮罩相關處理
   LET g_bmfb_m_mask_o.* =  g_bmfb_m.*
   CALL abmt300_02_bmfb_t_mask()
   LET g_bmfb_m_mask_n.* =  g_bmfb_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL abmt300_02_set_act_visible()   
   CALL abmt300_02_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_bmfb_m_t.* = g_bmfb_m.*
   LET g_bmfb_m_o.* = g_bmfb_m.*
   
   
   #重新顯示   
   CALL abmt300_02_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.insert" >}
#+ 資料新增
PRIVATE FUNCTION abmt300_02_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_bmfi_d.clear()   
   CALL g_bmfi2_d.clear()  
   CALL g_bmfi3_d.clear()  
 
 
   INITIALIZE g_bmfb_m.* TO NULL             #DEFAULT 設定
   
   LET g_bmfbdocno_t = NULL
   LET g_bmfb002_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      CALL abmt300_02_bmfb_show()
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_bmfb_m_t.* = g_bmfb_m.*
      LET g_bmfb_m_o.* = g_bmfb_m.*
      
      #顯示狀態(stus)圖片
      
    
      CALL abmt300_02_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      IF NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_bmfb_m.* TO NULL
         INITIALIZE g_bmfi_d TO NULL
         INITIALIZE g_bmfi2_d TO NULL
         INITIALIZE g_bmfi3_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL abmt300_02_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_bmfi_d.clear()
      #CALL g_bmfi2_d.clear()
      #CALL g_bmfi3_d.clear()
 
 
      LET g_rec_b = 0
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL abmt300_02_set_act_visible()   
   CALL abmt300_02_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_bmfbdocno_t = g_bmfb_m.bmfbdocno
   LET g_bmfb002_t = g_bmfb_m.bmfb002
 
   
   #組合新增資料的條件
   LET g_add_browse = " bmfbent = " ||g_enterprise|| " AND bmfbsite = '" ||g_site|| "' AND",
                      " bmfbdocno = '", g_bmfb_m.bmfbdocno, "' "
                      ," AND bmfb002 = '", g_bmfb_m.bmfb002, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abmt300_02_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE abmt300_02_cl
   
   CALL abmt300_02_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE abmt300_02_master_referesh USING g_site,g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002 INTO g_bmfb_m.bmfbdocno, 
       g_bmfb_m.bmfb005,g_bmfb_m.bmfb006,g_bmfb_m.bmfb002,g_bmfb_m.bmfb003,g_bmfb_m.bmfb008,g_bmfb_m.bmfb009, 
       g_bmfb_m.bmfb010,g_bmfb_m.bmfb008_desc,g_bmfb_m.bmfb009_desc
   
   
   #遮罩相關處理
   LET g_bmfb_m_mask_o.* =  g_bmfb_m.*
   CALL abmt300_02_bmfb_t_mask()
   LET g_bmfb_m_mask_n.* =  g_bmfb_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb005,g_bmfb_m.bmfb006,g_bmfb_m.bmfb002,g_bmfb_m.bmfb005_desc, 
       g_bmfb_m.bmfb006_desc,g_bmfb_m.bmfb003,g_bmfb_m.bmfb005_desc1,g_bmfb_m.bmfb006_desc1,g_bmfb_m.bmfa003, 
       g_bmfb_m.bmfb008,g_bmfb_m.bmfb008_desc,g_bmfb_m.bmfa003_desc,g_bmfb_m.bmfb009,g_bmfb_m.bmfb009_desc, 
       g_bmfb_m.bmfa003_desc1,g_bmfb_m.bmfb010
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   
   #功能已完成,通報訊息中心
   CALL abmt300_02_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.modify" >}
#+ 資料修改
PRIVATE FUNCTION abmt300_02_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
   DEFINE l_wc2_table3   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_bmfb_m_t.* = g_bmfb_m.*
   LET g_bmfb_m_o.* = g_bmfb_m.*
   
   IF g_bmfb_m.bmfbdocno IS NULL
   OR g_bmfb_m.bmfb002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_bmfbdocno_t = g_bmfb_m.bmfbdocno
   LET g_bmfb002_t = g_bmfb_m.bmfb002
 
   CALL s_transaction_begin()
   
   OPEN abmt300_02_cl USING g_enterprise, g_site,g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abmt300_02_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE abmt300_02_cl
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abmt300_02_master_referesh USING g_site,g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002 INTO g_bmfb_m.bmfbdocno, 
       g_bmfb_m.bmfb005,g_bmfb_m.bmfb006,g_bmfb_m.bmfb002,g_bmfb_m.bmfb003,g_bmfb_m.bmfb008,g_bmfb_m.bmfb009, 
       g_bmfb_m.bmfb010,g_bmfb_m.bmfb008_desc,g_bmfb_m.bmfb009_desc
   
   #檢查是否允許此動作
   IF NOT abmt300_02_action_chk() THEN
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_bmfb_m_mask_o.* =  g_bmfb_m.*
   CALL abmt300_02_bmfb_t_mask()
   LET g_bmfb_m_mask_n.* =  g_bmfb_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
   #LET l_wc2_table3 = g_wc2_table3
   #LET l_wc2_table3 = " 1=1"
 
 
 
   
   CALL abmt300_02_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
 
 
    
   WHILE TRUE
      LET g_bmfbdocno_t = g_bmfb_m.bmfbdocno
      LET g_bmfb002_t = g_bmfb_m.bmfb002
 
      
      #寫入修改者/修改日期資訊(單頭)
      
      
      #add-point:modify段修改前 name="modify.before_input"
      CALL abmt300_02_bmfb_show()
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL abmt300_02_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
 
    
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_bmfb_m.* = g_bmfb_m_t.*
            CALL abmt300_02_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_bmfb_m.bmfbdocno != g_bmfb_m_t.bmfbdocno
      OR g_bmfb_m.bmfb002 != g_bmfb_m_t.bmfb002
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE bmfi_t SET bmfidocno = g_bmfb_m.bmfbdocno
                                       ,bmfi002 = g_bmfb_m.bmfb002
 
          WHERE bmfient = g_enterprise AND bmfisite = g_site AND bmfidocno = g_bmfb_m_t.bmfbdocno
            AND bmfi002 = g_bmfb_m_t.bmfb002
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "bmfi_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bmfi_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update2"
         
         #end add-point
         
         UPDATE bmfk_t
            SET bmfkdocno = g_bmfb_m.bmfbdocno
               ,bmfk002 = g_bmfb_m.bmfb002
 
          WHERE bmfkent = g_enterprise AND bmfksite = g_site AND
                bmfkdocno = g_bmfbdocno_t
            AND bmfk002 = g_bmfb002_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "bmfk_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bmfk_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update2"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update3"
         
         #end add-point
         
         UPDATE bmfm_t
            SET bmfmdocno = g_bmfb_m.bmfbdocno
               ,bmfm002 = g_bmfb_m.bmfb002
 
          WHERE bmfment = g_enterprise AND bmfmsite = g_site AND
                bmfmdocno = g_bmfbdocno_t
            AND bmfm002 = g_bmfb002_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "bmfm_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bmfm_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update3"
         
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
         
 
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL abmt300_02_set_act_visible()   
   CALL abmt300_02_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " bmfbent = " ||g_enterprise|| " AND bmfbsite = '" ||g_site|| "' AND",
                      " bmfbdocno = '", g_bmfb_m.bmfbdocno, "' "
                      ," AND bmfb002 = '", g_bmfb_m.bmfb002, "' "
 
   #填到對應位置
   CALL abmt300_02_browser_fill("")
 
   CLOSE abmt300_02_cl
   
 
   #功能已完成,通報訊息中心
   CALL abmt300_02_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="abmt300_02.input" >}
#+ 資料輸入
PRIVATE FUNCTION abmt300_02_input(p_cmd)
   #add-point:input段define(客製用) name="input.define_customerization"
   
   #end add-point  
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num10                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
   DEFINE  l_ac_t                LIKE type_t.num10
   DEFINE  l_insert              BOOLEAN
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num10
   DEFINE  li_reproduce_target   LIKE type_t.num10
   DEFINE  ls_keys               DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:input段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE l_ac1_t           LIKE type_t.num5
   DEFINE l_bmfj005         LIKE type_t.num5
   DEFINE l_bmfj006         LIKE type_t.num5
   DEFINE l_result          LIKE type_t.num5
   DEFINE l_result1         LIKE type_t.num5
   DEFINE l_bmfn005         LIKE type_t.num5
   DEFINE l_bmfn006         LIKE type_t.num5
   DEFINE l_imaa005         LIKE imaa_t.imaa005
   DEFINE l_imaa005_2       LIKE imaa_t.imaa005
   DEFINE l_flag            LIKE type_t.num5
   DEFINE l_bmfi003         LIKE bmfi_t.bmfi003
   DEFINE l_bmfk003         LIKE bmfk_t.bmfk003
   DEFINE l_bmfm003         LIKE bmfm_t.bmfm003
   #end add-point  
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb005,g_bmfb_m.bmfb006,g_bmfb_m.bmfb002,g_bmfb_m.bmfb005_desc, 
       g_bmfb_m.bmfb006_desc,g_bmfb_m.bmfb003,g_bmfb_m.bmfb005_desc1,g_bmfb_m.bmfb006_desc1,g_bmfb_m.bmfa003, 
       g_bmfb_m.bmfb008,g_bmfb_m.bmfb008_desc,g_bmfb_m.bmfa003_desc,g_bmfb_m.bmfb009,g_bmfb_m.bmfb009_desc, 
       g_bmfb_m.bmfa003_desc1,g_bmfb_m.bmfb010
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT bmfi003 FROM bmfi_t WHERE bmfient=? AND bmfisite=? AND bmfidocno=? AND  
       bmfi002=? AND bmfi003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abmt300_02_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT bmfk003,bmfk004 FROM bmfk_t WHERE bmfkent=? AND bmfksite=? AND bmfkdocno=?  
       AND bmfk002=? AND bmfk003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abmt300_02_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
   
   #end add-point    
   LET g_forupd_sql = "SELECT bmfm003 FROM bmfm_t WHERE bmfment=? AND bmfmsite=? AND bmfmdocno=? AND  
       bmfm002=? AND bmfm003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abmt300_02_bcl3 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL abmt300_02_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL abmt300_02_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb005,g_bmfb_m.bmfb006,g_bmfb_m.bmfb002,g_bmfb_m.bmfb003, 
       g_bmfb_m.bmfa003,g_bmfb_m.bmfb008,g_bmfb_m.bmfb009,g_bmfb_m.bmfb010
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET g_forupd_sql = "SELECT bmfj004,bmfj005,bmfj006 FROM bmfj_t WHERE bmfjent=? AND bmfjsite=? AND bmfjdocno=? AND bmfj002=? AND bmfj003=? AND bmfj004=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE abmt300_02_bcl4 CURSOR FROM g_forupd_sql
   
   LET g_forupd_sql = "SELECT bmfl004,bmfl005 FROM bmfl_t WHERE bmflent=? AND bmflsite=? AND bmfldocno=? AND bmfl002=? AND bmfl003=? AND bmfl004=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE abmt300_02_bcl5 CURSOR FROM g_forupd_sql
   
   LET g_forupd_sql = "SELECT bmfn004,bmfn005,bmfn006 FROM bmfn_t WHERE bmfnent=? AND bmfnsite=? AND bmfndocno=? AND bmfn002=? AND bmfn003=? AND bmfn004=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE abmt300_02_bcl6 CURSOR FROM g_forupd_sql
   SELECT imaa005 INTO l_imaa005
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_bmfb_m.bmfa003
   SELECT imaa005 INTO l_imaa005_2
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_bmfb_m.bmfb005      
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="abmt300_02.input.head" >}
      #單頭段
      INPUT BY NAME g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb005,g_bmfb_m.bmfb006,g_bmfb_m.bmfb002,g_bmfb_m.bmfb003, 
          g_bmfb_m.bmfa003,g_bmfb_m.bmfb008,g_bmfb_m.bmfb009,g_bmfb_m.bmfb010 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            OPEN abmt300_02_cl USING g_enterprise, g_site,g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN abmt300_02_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE abmt300_02_cl
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL abmt300_02_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL abmt300_02_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmfbdocno
            #add-point:BEFORE FIELD bmfbdocno name="input.b.bmfbdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmfbdocno
            
            #add-point:AFTER FIELD bmfbdocno name="input.a.bmfbdocno"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_bmfb_m.bmfbdocno) AND NOT cl_null(g_bmfb_m.bmfb002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_bmfb_m.bmfbdocno != g_bmfbdocno_t  OR g_bmfb_m.bmfb002 != g_bmfb002_t ))) THEN 
                  IF NOT ap_chk_notDup(g_bmfb_m.bmfbdocno,"SELECT COUNT(*) FROM bmfb_t WHERE "||"bmfbent = '" ||g_enterprise|| "' AND bmfbsite = '" ||g_site|| "' AND "||"bmfbdocno = '"||g_bmfb_m.bmfbdocno ||"' AND "|| "bmfb002 = '"||g_bmfb_m.bmfb002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmfbdocno
            #add-point:ON CHANGE bmfbdocno name="input.g.bmfbdocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmfb005
            
            #add-point:AFTER FIELD bmfb005 name="input.a.bmfb005"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmfb005
            #add-point:BEFORE FIELD bmfb005 name="input.b.bmfb005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmfb005
            #add-point:ON CHANGE bmfb005 name="input.g.bmfb005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmfb006
            
            #add-point:AFTER FIELD bmfb006 name="input.a.bmfb006"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmfb006
            #add-point:BEFORE FIELD bmfb006 name="input.b.bmfb006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmfb006
            #add-point:ON CHANGE bmfb006 name="input.g.bmfb006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmfb002
            #add-point:BEFORE FIELD bmfb002 name="input.b.bmfb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmfb002
            
            #add-point:AFTER FIELD bmfb002 name="input.a.bmfb002"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_bmfb_m.bmfbdocno) AND NOT cl_null(g_bmfb_m.bmfb002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_bmfb_m.bmfbdocno != g_bmfbdocno_t  OR g_bmfb_m.bmfb002 != g_bmfb002_t ))) THEN 
                  IF NOT ap_chk_notDup(g_bmfb_m.bmfb002,"SELECT COUNT(*) FROM bmfb_t WHERE "||"bmfbent = '" ||g_enterprise|| "' AND bmfbsite = '" ||g_site|| "' AND "||"bmfbdocno= '"||g_bmfb_m.bmfbdocno ||"' AND "|| "bmfb002 = '"||g_bmfb_m.bmfb002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmfb002
            #add-point:ON CHANGE bmfb002 name="input.g.bmfb002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmfb003
            #add-point:BEFORE FIELD bmfb003 name="input.b.bmfb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmfb003
            
            #add-point:AFTER FIELD bmfb003 name="input.a.bmfb003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmfb003
            #add-point:ON CHANGE bmfb003 name="input.g.bmfb003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmfa003
            
            #add-point:AFTER FIELD bmfa003 name="input.a.bmfa003"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmfa003
            #add-point:BEFORE FIELD bmfa003 name="input.b.bmfa003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmfa003
            #add-point:ON CHANGE bmfa003 name="input.g.bmfa003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmfb008
            
            #add-point:AFTER FIELD bmfb008 name="input.a.bmfb008"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmfb008
            #add-point:BEFORE FIELD bmfb008 name="input.b.bmfb008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmfb008
            #add-point:ON CHANGE bmfb008 name="input.g.bmfb008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmfb009
            
            #add-point:AFTER FIELD bmfb009 name="input.a.bmfb009"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmfb009
            #add-point:BEFORE FIELD bmfb009 name="input.b.bmfb009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmfb009
            #add-point:ON CHANGE bmfb009 name="input.g.bmfb009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmfb010
            #add-point:BEFORE FIELD bmfb010 name="input.b.bmfb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmfb010
            
            #add-point:AFTER FIELD bmfb010 name="input.a.bmfb010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmfb010
            #add-point:ON CHANGE bmfb010 name="input.g.bmfb010"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.bmfbdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmfbdocno
            #add-point:ON ACTION controlp INFIELD bmfbdocno name="input.c.bmfbdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.bmfb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmfb005
            #add-point:ON ACTION controlp INFIELD bmfb005 name="input.c.bmfb005"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmfb_m.bmfb005             #給予default值

            #給予arg

            CALL q_imaa001_2()                                #呼叫開窗

            LET g_bmfb_m.bmfb005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_bmfb_m.bmfb005 TO bmfb005              #顯示到畫面上

            NEXT FIELD bmfb005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.bmfb006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmfb006
            #add-point:ON ACTION controlp INFIELD bmfb006 name="input.c.bmfb006"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmfb_m.bmfb006             #給予default值

            #給予arg

            CALL q_imaa001_2()                                #呼叫開窗

            LET g_bmfb_m.bmfb006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_bmfb_m.bmfb006 TO bmfb006              #顯示到畫面上

            NEXT FIELD bmfb006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.bmfb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmfb002
            #add-point:ON ACTION controlp INFIELD bmfb002 name="input.c.bmfb002"
            
            #END add-point
 
 
         #Ctrlp:input.c.bmfb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmfb003
            #add-point:ON ACTION controlp INFIELD bmfb003 name="input.c.bmfb003"
            
            #END add-point
 
 
         #Ctrlp:input.c.bmfa003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmfa003
            #add-point:ON ACTION controlp INFIELD bmfa003 name="input.c.bmfa003"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmfb_m.bmfa003             #給予default值
            LET g_qryparam.default2 = "" #g_bmfb_m.bmaa002 #配方版本

            #給予arg

            CALL q_bmaa001()                                #呼叫開窗

            LET g_bmfb_m.bmfa003 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_bmfb_m.bmaa002 = g_qryparam.return2 #配方版本

            DISPLAY g_bmfb_m.bmfa003 TO bmfa003              #顯示到畫面上
            #DISPLAY g_bmfb_m.bmaa002 TO bmaa002 #配方版本

            NEXT FIELD bmfa003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.bmfb008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmfb008
            #add-point:ON ACTION controlp INFIELD bmfb008 name="input.c.bmfb008"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmfb_m.bmfb008             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_bmfb_m.bmfb008 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_bmfb_m.bmfb008 TO bmfb008              #顯示到畫面上

            NEXT FIELD bmfb008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.bmfb009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmfb009
            #add-point:ON ACTION controlp INFIELD bmfb009 name="input.c.bmfb009"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmfb_m.bmfb009             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_bmfb_m.bmfb009 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_bmfb_m.bmfb009 TO bmfb009              #顯示到畫面上

            NEXT FIELD bmfb009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.bmfb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmfb010
            #add-point:ON ACTION controlp INFIELD bmfb010 name="input.c.bmfb010"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO bmfb_t (bmfbent, bmfbsite,bmfbdocno,bmfb005,bmfb006,bmfb002,bmfb003,bmfb008, 
                   bmfb009,bmfb010)
               VALUES (g_enterprise, g_site,g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb005,g_bmfb_m.bmfb006,g_bmfb_m.bmfb002, 
                   g_bmfb_m.bmfb003,g_bmfb_m.bmfb008,g_bmfb_m.bmfb009,g_bmfb_m.bmfb010) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_bmfb_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL abmt300_02_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL abmt300_02_b_fill()
                  CALL abmt300_02_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL abmt300_02_bmfb_t_mask_restore('restore_mask_o')
               
               UPDATE bmfb_t SET (bmfbdocno,bmfb005,bmfb006,bmfb002,bmfb003,bmfb008,bmfb009,bmfb010) = (g_bmfb_m.bmfbdocno, 
                   g_bmfb_m.bmfb005,g_bmfb_m.bmfb006,g_bmfb_m.bmfb002,g_bmfb_m.bmfb003,g_bmfb_m.bmfb008, 
                   g_bmfb_m.bmfb009,g_bmfb_m.bmfb010)
                WHERE bmfbent = g_enterprise AND bmfbsite = g_site AND bmfbdocno = g_bmfbdocno_t
                  AND bmfb002 = g_bmfb002_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "bmfb_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL abmt300_02_bmfb_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_bmfb_m_t)
               LET g_log2 = util.JSON.stringify(g_bmfb_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
               ELSE
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_bmfbdocno_t = g_bmfb_m.bmfbdocno
            LET g_bmfb002_t = g_bmfb_m.bmfb002
 
            
      END INPUT
   
 
{</section>}
 
{<section id="abmt300_02.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_bmfi_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bmfi_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL abmt300_02_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_bmfi_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            CALL cl_set_act_visible("delete", TRUE)
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2 name="input.body.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_detail_idx_list[1] = l_ac
            LET g_current_page = 1
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN abmt300_02_cl USING g_enterprise, g_site,g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN abmt300_02_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE abmt300_02_cl
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_bmfi_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_bmfi_d[l_ac].bmfi003 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_bmfi_d_t.* = g_bmfi_d[l_ac].*  #BACKUP
               LET g_bmfi_d_o.* = g_bmfi_d[l_ac].*  #BACKUP
               CALL abmt300_02_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL abmt300_02_set_no_entry_b(l_cmd)
               IF NOT abmt300_02_lock_b("bmfi_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH abmt300_02_bcl INTO g_bmfi_d[l_ac].bmfi003
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_bmfi_d_t.bmfi003,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_bmfi_d_mask_o[l_ac].* =  g_bmfi_d[l_ac].*
                  CALL abmt300_02_bmfi_t_mask()
                  LET g_bmfi_d_mask_n[l_ac].* =  g_bmfi_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL abmt300_02_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            CALL abmt300_02_b_fill1()
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
        
         BEFORE INSERT  
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_bmfi_d[l_ac].* TO NULL 
            INITIALIZE g_bmfi_d_t.* TO NULL 
            INITIALIZE g_bmfi_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_bmfi_d_t.* = g_bmfi_d[l_ac].*     #新輸入資料
            LET g_bmfi_d_o.* = g_bmfi_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL abmt300_02_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL abmt300_02_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_bmfi_d[li_reproduce_target].* = g_bmfi_d[li_reproduce].*
 
               LET g_bmfi_d[li_reproduce_target].bmfi003 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            CALL abmt300_02_def_imeb004() RETURNING l_bmfi003
            LET l_flag = 0
            SELECT COUNT(*) INTO l_flag
              FROM bmfi_t
             WHERE bmfient = g_enterprise
               AND bmfisite = g_site
               AND bmfidocno = g_bmfb_m.bmfbdocno
               AND bmfi002 = g_bmfb_m.bmfb002
               AND bmfi003 = l_bmfi003
            IF l_flag > 0 THEN
               LET g_bmfi_d[l_ac].bmfi003 = ""
            ELSE
               LET g_bmfi_d[l_ac].bmfi003 = l_bmfi003
               #DISPLAY BY NAME g_bmfi_d[l_ac].bmfi003
            END IF
            IF NOT cl_null( g_bmfi_d[l_ac].bmfi003) THEN
               CALL abmt300_02_bmfi_desc()
            END IF
            #end add-point  
  
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增 name="input.body.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM bmfi_t 
             WHERE bmfient = g_enterprise AND bmfisite = g_site AND bmfidocno = g_bmfb_m.bmfbdocno
               AND bmfi002 = g_bmfb_m.bmfb002
 
               AND bmfi003 = g_bmfi_d[l_ac].bmfi003
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bmfb_m.bmfbdocno
               LET gs_keys[2] = g_bmfb_m.bmfb002
               LET gs_keys[3] = g_bmfi_d[g_detail_idx].bmfi003
               CALL abmt300_02_insert_b('bmfi_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_bmfi_d[l_ac].* TO NULL
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bmfi_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL abmt300_02_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身刪除後(=d) name="input.body.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_bmfb_m.bmfbdocno
               LET gs_keys[gs_keys.getLength()+1] = g_bmfb_m.bmfb002
 
               LET gs_keys[gs_keys.getLength()+1] = g_bmfi_d_t.bmfi003
 
            
               #刪除同層單身
               IF NOT abmt300_02_delete_b('bmfi_t',gs_keys,"'1'") THEN
                  CLOSE abmt300_02_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT abmt300_02_key_delete_b(gs_keys,'bmfi_t') THEN
                  CLOSE abmt300_02_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CLOSE abmt300_02_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
                  DELETE FROM bmfj_t
                   WHERE bmfjent = g_enterprise
                     AND bmfjsite = g_site
                     AND bmfjdocno = g_bmfb_m.bmfbdocno
                     AND bmfj002 = g_bmfb_m.bmfb002
                     AND bmfj003 = g_bmfi_d_t.bmfi003
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "bmfj_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     CANCEL DELETE   
                  END IF
               #end add-point
               LET l_count = g_bmfi_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_bmfi_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmfi003
            
            #add-point:AFTER FIELD bmfi003 name="input.a.page1.bmfi003"
            #此段落由子樣板a05產生
            CALL abmt300_02_bmfi_desc()
            IF NOT cl_null(g_bmfb_m.bmfbdocno) AND NOT cl_null(g_bmfb_m.bmfbdocno) AND NOT cl_null(g_bmfi_d[l_ac].bmfi003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_bmfb_m.bmfbdocno != g_bmfbdocno_t OR g_bmfb_m.bmfb002 != g_bmfb002_t OR g_bmfi_d[l_ac].bmfi003 != g_bmfi_d_t.bmfi003))) THEN 
                  IF NOT ap_chk_notDup(g_bmfi_d[l_ac].bmfi003,"SELECT COUNT(*) FROM bmfi_t WHERE "||"bmfient = '" ||g_enterprise|| "' AND bmfisite = '" ||g_site|| "' AND "||"bmfidocno = '"||g_bmfb_m.bmfbdocno ||"' AND "|| "bmfi002 = '"||g_bmfb_m.bmfb002 ||"' AND "|| "bmfi003 = '"||g_bmfi_d[l_ac].bmfi003 ||"'",'std-00004',0) THEN 
                     LET g_bmfi_d[l_ac].bmfi003 = g_bmfi_d_t.bmfi003
                     CALL abmt300_02_bmfi_desc()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_bmfi_d[l_ac].bmfi003) THEN
               IF NOT abmt300_02_chk_imeb(g_bmfi_d[l_ac].bmfi003,'1') THEN
                  LET g_bmfi_d[l_ac].bmfi003 = g_bmfi_d_t.bmfi003
                  CALL abmt300_02_bmfi_desc()
                  NEXT FIELD CURRENT
               END IF
            END IF
            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmfi003
            #add-point:BEFORE FIELD bmfi003 name="input.b.page1.bmfi003"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmfi003
            #add-point:ON CHANGE bmfi003 name="input.g.page1.bmfi003"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.bmfi003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmfi003
            #add-point:ON ACTION controlp INFIELD bmfi003 name="input.c.page1.bmfi003"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmfi_d[l_ac].bmfi003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = l_imaa005 #
            #20150702-xianghui-mod-b
            #CALL q_imeb004()                                #呼叫開窗
            CALL q_imeb004_4() 
            #20150702-xianghui-mod-e
            LET g_bmfi_d[l_ac].bmfi003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_bmfi_d[l_ac].bmfi003 TO bmfi003              #顯示到畫面上

            NEXT FIELD bmfi003                          #返回原欄位


            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_bmfi_d[l_ac].* = g_bmfi_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE abmt300_02_bcl
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_bmfi_d[l_ac].bmfi003 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_bmfi_d[l_ac].* = g_bmfi_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL abmt300_02_bmfi_t_mask_restore('restore_mask_o')
      
               UPDATE bmfi_t SET (bmfidocno,bmfi002,bmfi003) = (g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002, 
                   g_bmfi_d[l_ac].bmfi003)
                WHERE bmfient = g_enterprise AND bmfisite = g_site AND bmfidocno = g_bmfb_m.bmfbdocno 
                  AND bmfi002 = g_bmfb_m.bmfb002 
 
                  AND bmfi003 = g_bmfi_d_t.bmfi003 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_bmfi_d[l_ac].* = g_bmfi_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bmfi_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_bmfi_d[l_ac].* = g_bmfi_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bmfi_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bmfb_m.bmfbdocno
               LET gs_keys_bak[1] = g_bmfbdocno_t
               LET gs_keys[2] = g_bmfb_m.bmfb002
               LET gs_keys_bak[2] = g_bmfb002_t
               LET gs_keys[3] = g_bmfi_d[g_detail_idx].bmfi003
               LET gs_keys_bak[3] = g_bmfi_d_t.bmfi003
               CALL abmt300_02_update_b('bmfi_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL abmt300_02_bmfi_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_bmfi_d[g_detail_idx].bmfi003 = g_bmfi_d_t.bmfi003 
 
                  ) THEN
                  LET gs_keys[01] = g_bmfb_m.bmfbdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_bmfb_m.bmfb002
 
                  LET gs_keys[gs_keys.getLength()+1] = g_bmfi_d_t.bmfi003
 
                  CALL abmt300_02_key_update_b(gs_keys,'bmfi_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_bmfb_m),util.JSON.stringify(g_bmfi_d_t)
               LET g_log2 = util.JSON.stringify(g_bmfb_m),util.JSON.stringify(g_bmfi_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL abmt300_02_unlock_b("bmfi_t","'1'")
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_bmfi_d[li_reproduce_target].* = g_bmfi_d[li_reproduce].*
 
               LET g_bmfi_d[li_reproduce_target].bmfi003 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_bmfi_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_bmfi_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_bmfi2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bmfi2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL abmt300_02_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_bmfi2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_bmfi2_d[l_ac].* TO NULL 
            INITIALIZE g_bmfi2_d_t.* TO NULL 
            INITIALIZE g_bmfi2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_bmfi2_d[l_ac].bmfk004 = "1"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_bmfi2_d_t.* = g_bmfi2_d[l_ac].*     #新輸入資料
            LET g_bmfi2_d_o.* = g_bmfi2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL abmt300_02_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL abmt300_02_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_bmfi2_d[li_reproduce_target].* = g_bmfi2_d[li_reproduce].*
 
               LET g_bmfi2_d[li_reproduce_target].bmfk003 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
            CALL abmt300_02_def_imeb004() RETURNING l_bmfk003
            LET l_flag = 0
            SELECT COUNT(*) INTO l_flag
              FROM bmfk_t
             WHERE bmfkent = g_enterprise
               AND bmfksite = g_site
               AND bmfkdocno = g_bmfb_m.bmfbdocno
               AND bmfk002 = g_bmfb_m.bmfb002
               AND bmfk003 = l_bmfk003
            IF l_flag > 0 THEN
               LET g_bmfi2_d[l_ac].bmfk003 = ""
            ELSE
               LET g_bmfi2_d[l_ac].bmfk003 = l_bmfk003
               #DISPLAY BY NAME g_bmfi2_d[l_ac].bmfk003
            END IF
            CALL abmt300_02_bmfk_desc()
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body2.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[2] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 2
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN abmt300_02_cl USING g_enterprise, g_site,g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN abmt300_02_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE abmt300_02_cl
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_bmfi2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_bmfi2_d[l_ac].bmfk003 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_bmfi2_d_t.* = g_bmfi2_d[l_ac].*  #BACKUP
               LET g_bmfi2_d_o.* = g_bmfi2_d[l_ac].*  #BACKUP
               CALL abmt300_02_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL abmt300_02_set_no_entry_b(l_cmd)
               IF NOT abmt300_02_lock_b("bmfk_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH abmt300_02_bcl2 INTO g_bmfi2_d[l_ac].bmfk003,g_bmfi2_d[l_ac].bmfk004
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_bmfi2_d_mask_o[l_ac].* =  g_bmfi2_d[l_ac].*
                  CALL abmt300_02_bmfk_t_mask()
                  LET g_bmfi2_d_mask_n[l_ac].* =  g_bmfi2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL abmt300_02_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body2.before_row"
            CALL abmt300_02_b_fill1()
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body2.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body2.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身2刪除前 name="input.body2.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_bmfb_m.bmfbdocno
               LET gs_keys[gs_keys.getLength()+1] = g_bmfb_m.bmfb002
               LET gs_keys[gs_keys.getLength()+1] = g_bmfi2_d_t.bmfk003
            
               #刪除同層單身
               IF NOT abmt300_02_delete_b('bmfk_t',gs_keys,"'2'") THEN
                  CLOSE abmt300_02_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT abmt300_02_key_delete_b(gs_keys,'bmfk_t') THEN
                  CLOSE abmt300_02_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CLOSE abmt300_02_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
                  DELETE FROM bmfl_t
                   WHERE bmflent = g_enterprise
                     AND bmflsite = g_site
                     AND bmfldocno = g_bmfb_m.bmfbdocno
                     AND bmfl002 = g_bmfb_m.bmfb002
                     AND bmfl003 = g_bmfi2_d_t.bmfk003
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "bmfl_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     CANCEL DELETE   
                  END IF
               #end add-point
               LET l_count = g_bmfi_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_bmfi2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身2新增前 name="input.body2.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM bmfk_t 
             WHERE bmfkent = g_enterprise AND bmfksite = g_site AND bmfkdocno = g_bmfb_m.bmfbdocno
               AND bmfk002 = g_bmfb_m.bmfb002
               AND bmfk003 = g_bmfi2_d[l_ac].bmfk003
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bmfb_m.bmfbdocno
               LET gs_keys[2] = g_bmfb_m.bmfb002
               LET gs_keys[3] = g_bmfi2_d[g_detail_idx].bmfk003
               CALL abmt300_02_insert_b('bmfk_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_bmfi_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bmfk_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL abmt300_02_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"
               
               #end add-point
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_bmfi2_d[l_ac].* = g_bmfi2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE abmt300_02_bcl2
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_bmfi2_d[l_ac].* = g_bmfi2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL abmt300_02_bmfk_t_mask_restore('restore_mask_o')
                              
               UPDATE bmfk_t SET (bmfkdocno,bmfk002,bmfk003,bmfk004) = (g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002, 
                   g_bmfi2_d[l_ac].bmfk003,g_bmfi2_d[l_ac].bmfk004) #自訂欄位頁簽
                WHERE bmfkent = g_enterprise AND bmfksite = g_site AND bmfkdocno = g_bmfb_m.bmfbdocno
                  AND bmfk002 = g_bmfb_m.bmfb002
                  AND bmfk003 = g_bmfi2_d_t.bmfk003 #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_bmfi2_d[l_ac].* = g_bmfi2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bmfk_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_bmfi2_d[l_ac].* = g_bmfi2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bmfk_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bmfb_m.bmfbdocno
               LET gs_keys_bak[1] = g_bmfbdocno_t
               LET gs_keys[2] = g_bmfb_m.bmfb002
               LET gs_keys_bak[2] = g_bmfb002_t
               LET gs_keys[3] = g_bmfi2_d[g_detail_idx].bmfk003
               LET gs_keys_bak[3] = g_bmfi2_d_t.bmfk003
               CALL abmt300_02_update_b('bmfk_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL abmt300_02_bmfk_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_bmfi2_d[g_detail_idx].bmfk003 = g_bmfi2_d_t.bmfk003 
                  ) THEN
                  LET gs_keys[01] = g_bmfb_m.bmfbdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_bmfb_m.bmfb002
                  LET gs_keys[gs_keys.getLength()+1] = g_bmfi2_d_t.bmfk003
                  CALL abmt300_02_key_update_b(gs_keys,'bmfk_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_bmfb_m),util.JSON.stringify(g_bmfi2_d_t)
               LET g_log2 = util.JSON.stringify(g_bmfb_m),util.JSON.stringify(g_bmfi2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmfk003
            
            #add-point:AFTER FIELD bmfk003 name="input.a.page2.bmfk003"
            #此段落由子樣板a05產生
            CALL abmt300_02_bmfk_desc()
            IF NOT cl_null(g_bmfb_m.bmfbdocno) AND NOT cl_null(g_bmfb_m.bmfb002) AND NOT cl_null(g_bmfi2_d[l_ac].bmfk003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_bmfb_m.bmfbdocno != g_bmfbdocno_t OR g_bmfb_m.bmfb002 != g_bmfb002_t OR g_bmfi2_d[l_ac].bmfk003 != g_bmfi2_d_t.bmfk003))) THEN 
                  IF NOT ap_chk_notDup(g_bmfi2_d[l_ac].bmfk003,"SELECT COUNT(*) FROM bmfk_t WHERE "||"bmfkent = '" ||g_enterprise|| "' AND bmfksite = '" ||g_site|| "' AND "||"bmfkdocno = '"||g_bmfb_m.bmfbdocno ||"' AND "|| "bmfk002 = '"||g_bmfb_m.bmfb002 ||"' AND "|| "bmfk003 = '"||g_bmfi2_d[l_ac].bmfk003 ||"'",'std-00004',0) THEN 
                     LET g_bmfi2_d[l_ac].bmfk003 = g_bmfi2_d_t.bmfk003
                     CALL abmt300_02_bmfk_desc()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_bmfi2_d[l_ac].bmfk003) THEN
               IF cl_null(l_imaa005) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aec-00018'
                  LET g_errparam.extend = g_bmfi2_d[l_ac].bmfk003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bmfi2_d[l_ac].bmfk003 = g_bmfi2_d_t.bmfk003
                  CALL abmt300_02_bmfk_desc()
                  NEXT FIELD CURRENT
               END IF
               IF NOT abmt300_02_chk_imeb(g_bmfi2_d[l_ac].bmfk003,'2') THEN
                  LET g_bmfi2_d[l_ac].bmfk003 = g_bmfi2_d_t.bmfk003
                  CALL abmt300_02_bmfk_desc()
                  NEXT FIELD CURRENT
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmfk003
            #add-point:BEFORE FIELD bmfk003 name="input.b.page2.bmfk003"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmfk003
            #add-point:ON CHANGE bmfk003 name="input.g.page2.bmfk003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmfk004
            #add-point:BEFORE FIELD bmfk004 name="input.b.page2.bmfk004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmfk004
            
            #add-point:AFTER FIELD bmfk004 name="input.a.page2.bmfk004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmfk004
            #add-point:ON CHANGE bmfk004 name="input.g.page2.bmfk004"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.bmfk003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmfk003
            #add-point:ON ACTION controlp INFIELD bmfk003 name="input.c.page2.bmfk003"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmfi2_d[l_ac].bmfk003             #給予default值

            #給予arg
            LET g_qryparam.where = "imeb003 = '2' AND imeb001 = '",l_imaa005,"' ",
                                   " AND imeb004 IN (SELECT imeb004 FROM imeb_t WHERE imebent = '",g_enterprise,"'",
                                   "            AND imeb003 = '2' AND imeb001 = '",l_imaa005_2,"')"

            CALL q_imeb004_1()                                #呼叫開窗

            LET g_bmfi2_d[l_ac].bmfk003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_bmfi2_d[l_ac].bmfk003 TO bmfk003              #顯示到畫面上

            NEXT FIELD bmfk003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.bmfk004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmfk004
            #add-point:ON ACTION controlp INFIELD bmfk004 name="input.c.page2.bmfk004"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
 
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_bmfi2_d[l_ac].* = g_bmfi2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE abmt300_02_bcl2
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL abmt300_02_unlock_b("bmfk_t","'2'")
            #add-point:單身page2 after_row2 name="input.body2.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_bmfi2_d[li_reproduce_target].* = g_bmfi2_d[li_reproduce].*
 
               LET g_bmfi2_d[li_reproduce_target].bmfk003 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_bmfi2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_bmfi2_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_bmfi3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bmfi3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL abmt300_02_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_bmfi3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_bmfi3_d[l_ac].* TO NULL 
            INITIALIZE g_bmfi3_d_t.* TO NULL 
            INITIALIZE g_bmfi3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
            
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_bmfi3_d_t.* = g_bmfi3_d[l_ac].*     #新輸入資料
            LET g_bmfi3_d_o.* = g_bmfi3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL abmt300_02_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL abmt300_02_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_bmfi3_d[li_reproduce_target].* = g_bmfi3_d[li_reproduce].*
 
               LET g_bmfi3_d[li_reproduce_target].bmfm003 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body3.before_insert"
            CALL abmt300_02_def_imeb004() RETURNING l_bmfm003
            LET l_flag = 0
            SELECT COUNT(*) INTO l_flag
              FROM bmfm_t
             WHERE bmfment = g_enterprise
               AND bmfmsite = g_site
               AND bmfmdocno = g_bmfb_m.bmfbdocno
               AND bmfm002 = g_bmfb_m.bmfb002
               AND bmfm003 = l_bmfm003
            IF l_flag > 0 THEN
               LET g_bmfi3_d[l_ac].bmfm003 = ""
            ELSE
               LET g_bmfi3_d[l_ac].bmfm003 = l_bmfm003
               #DISPLAY BY NAME g_bmfi3_d[l_ac].bmfm003
            END IF
            
            CALL abmt300_02_bmfm_desc()
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body3.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[3] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 3
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN abmt300_02_cl USING g_enterprise, g_site,g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN abmt300_02_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE abmt300_02_cl
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_bmfi3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_bmfi3_d[l_ac].bmfm003 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_bmfi3_d_t.* = g_bmfi3_d[l_ac].*  #BACKUP
               LET g_bmfi3_d_o.* = g_bmfi3_d[l_ac].*  #BACKUP
               CALL abmt300_02_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL abmt300_02_set_no_entry_b(l_cmd)
               IF NOT abmt300_02_lock_b("bmfm_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH abmt300_02_bcl3 INTO g_bmfi3_d[l_ac].bmfm003
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_bmfi3_d_mask_o[l_ac].* =  g_bmfi3_d[l_ac].*
                  CALL abmt300_02_bmfm_t_mask()
                  LET g_bmfi3_d_mask_n[l_ac].* =  g_bmfi3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL abmt300_02_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body3.before_row"
            CALL abmt300_02_b_fill1()
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body3.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body3.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身3刪除前 name="input.body3.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_bmfb_m.bmfbdocno
               LET gs_keys[gs_keys.getLength()+1] = g_bmfb_m.bmfb002
               LET gs_keys[gs_keys.getLength()+1] = g_bmfi3_d_t.bmfm003
            
               #刪除同層單身
               IF NOT abmt300_02_delete_b('bmfm_t',gs_keys,"'3'") THEN
                  CLOSE abmt300_02_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT abmt300_02_key_delete_b(gs_keys,'bmfm_t') THEN
                  CLOSE abmt300_02_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CLOSE abmt300_02_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
                  DELETE FROM bmfn_t
                   WHERE bmfnent = g_enterprise
                     AND bmfnsite = g_site
                     AND bmfndocno = g_bmfb_m.bmfbdocno
                     AND bmfn002 = g_bmfb_m.bmfb002
                     AND bmfn003 = g_bmfi3_d_t.bmfm003
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "bmfn_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     CANCEL DELETE   
                  END IF
               #end add-point
               LET l_count = g_bmfi_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_bmfi3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身3新增前 name="input.body3.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM bmfm_t 
             WHERE bmfment = g_enterprise AND bmfmsite = g_site AND bmfmdocno = g_bmfb_m.bmfbdocno
               AND bmfm002 = g_bmfb_m.bmfb002
               AND bmfm003 = g_bmfi3_d[l_ac].bmfm003
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bmfb_m.bmfbdocno
               LET gs_keys[2] = g_bmfb_m.bmfb002
               LET gs_keys[3] = g_bmfi3_d[g_detail_idx].bmfm003
               CALL abmt300_02_insert_b('bmfm_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_bmfi_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bmfm_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL abmt300_02_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body3.after_insert"
               
               #end add-point
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_bmfi3_d[l_ac].* = g_bmfi3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE abmt300_02_bcl3
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_bmfi3_d[l_ac].* = g_bmfi3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL abmt300_02_bmfm_t_mask_restore('restore_mask_o')
                              
               UPDATE bmfm_t SET (bmfmdocno,bmfm002,bmfm003) = (g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002, 
                   g_bmfi3_d[l_ac].bmfm003) #自訂欄位頁簽
                WHERE bmfment = g_enterprise AND bmfmsite = g_site AND bmfmdocno = g_bmfb_m.bmfbdocno
                  AND bmfm002 = g_bmfb_m.bmfb002
                  AND bmfm003 = g_bmfi3_d_t.bmfm003 #項次 
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_bmfi3_d[l_ac].* = g_bmfi3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bmfm_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_bmfi3_d[l_ac].* = g_bmfi3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bmfm_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bmfb_m.bmfbdocno
               LET gs_keys_bak[1] = g_bmfbdocno_t
               LET gs_keys[2] = g_bmfb_m.bmfb002
               LET gs_keys_bak[2] = g_bmfb002_t
               LET gs_keys[3] = g_bmfi3_d[g_detail_idx].bmfm003
               LET gs_keys_bak[3] = g_bmfi3_d_t.bmfm003
               CALL abmt300_02_update_b('bmfm_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL abmt300_02_bmfm_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_bmfi3_d[g_detail_idx].bmfm003 = g_bmfi3_d_t.bmfm003 
                  ) THEN
                  LET gs_keys[01] = g_bmfb_m.bmfbdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_bmfb_m.bmfb002
                  LET gs_keys[gs_keys.getLength()+1] = g_bmfi3_d_t.bmfm003
                  CALL abmt300_02_key_update_b(gs_keys,'bmfm_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_bmfb_m),util.JSON.stringify(g_bmfi3_d_t)
               LET g_log2 = util.JSON.stringify(g_bmfb_m),util.JSON.stringify(g_bmfi3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmfm003
            
            #add-point:AFTER FIELD bmfm003 name="input.a.page3.bmfm003"
            #此段落由子樣板a05產生
            CALL abmt300_02_bmfm_desc()
            IF NOT cl_null(g_bmfb_m.bmfbdocno) AND NOT cl_null(g_bmfb_m.bmfb002) AND NOT cl_null(g_bmfi3_d[l_ac].bmfm003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_bmfb_m.bmfbdocno != g_bmfbdocno_t OR g_bmfb_m.bmfb002 != g_bmfb002_t OR g_bmfi3_d[l_ac].bmfm003 != g_bmfi3_d_t.bmfm003))) THEN 
                  IF NOT ap_chk_notDup(g_bmfi3_d[l_ac].bmfm003,"SELECT COUNT(*) FROM bmfm_t WHERE "||"bmfment = '" ||g_enterprise|| "' AND bmfmsite = '" ||g_site|| "' AND "||"bmfmdocno = '"||g_bmfb_m.bmfbdocno ||"' AND "|| "bmfm002 = '"||g_bmfb_m.bmfb002 ||"' AND "|| "bmfm003 = '"||g_bmfi3_d[l_ac].bmfm003 ||"'",'std-00004',0) THEN 
                     LET g_bmfi3_d[l_ac].bmfm003 = g_bmfi3_d_t.bmfm003
                     CALL abmt300_02_bmfm_desc()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_bmfi3_d[l_ac].bmfm003) THEN
               IF cl_null(l_imaa005) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aec-00018'
                  LET g_errparam.extend = g_bmfi3_d[l_ac].bmfm003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bmfi3_d[l_ac].bmfm003 = g_bmfi3_d_t.bmfm003
                  CALL abmt300_02_bmfm_desc()
                  NEXT FIELD CURRENT
               END IF
               IF NOT abmt300_02_chk_imeb(g_bmfi3_d[l_ac].bmfm003,'3') THEN
                  LET g_bmfi3_d[l_ac].bmfm003 = g_bmfi3_d_t.bmfm003
                  CALL abmt300_02_bmfm_desc()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmfm003
            #add-point:BEFORE FIELD bmfm003 name="input.b.page3.bmfm003"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmfm003
            #add-point:ON CHANGE bmfm003 name="input.g.page3.bmfm003"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.bmfm003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmfm003
            #add-point:ON ACTION controlp INFIELD bmfm003 name="input.c.page3.bmfm003"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmfi3_d[l_ac].bmfm003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = l_imaa005_2 #

            CALL q_imeb004_4()                                #呼叫開窗

            LET g_bmfi3_d[l_ac].bmfm003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_bmfi3_d[l_ac].bmfm003 TO bmfm003              #顯示到畫面上

            NEXT FIELD bmfm003                          #返回原欄位


            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_bmfi3_d[l_ac].* = g_bmfi3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE abmt300_02_bcl3
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL abmt300_02_unlock_b("bmfm_t","'3'")
            #add-point:單身page3 after_row2 name="input.body3.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_bmfi3_d[li_reproduce_target].* = g_bmfi3_d[li_reproduce].*
 
               LET g_bmfi3_d[li_reproduce_target].bmfm003 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_bmfi3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_bmfi3_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="abmt300_02.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      INPUT ARRAY g_bmfi4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b1,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert,
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         BEFORE INPUT
            IF g_bmfi_d[l_ac].bmfi003 IS NULL THEN 
               NEXT FIELD bmfi003
            END IF
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bmfi4_d.getLength()+1) 
              LET g_insert = 'N' 
            END IF 

            CALL abmt300_02_b_fill1()
            LET g_rec_b1 = g_bmfi4_d.getLength()
            
         BEFORE INSERT
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_bmfi4_d[l_ac1].* TO NULL 
            LET g_bmfi4_d_t.* = g_bmfi4_d[l_ac1].*     #新輸入資料
            CALL cl_show_fld_cont()
            SELECT MAX(bmfj004) +1 INTO g_bmfi4_d[l_ac1].bmfj004
              FROM bmfj_t
             WHERE bmfjent = g_enterprise
               AND bmfjsite = g_site
               AND bmfjdocno = g_bmfb_m.bmfbdocno
               AND bmfj002 = g_bmfb_m.bmfb002
               AND bmfj003 = g_bmfi_d[l_ac].bmfi003
            IF cl_null(g_bmfi4_d[l_ac1].bmfj004) THEN
               LET g_bmfi4_d[l_ac1].bmfj004 = 1
            END IF
            
         BEFORE ROW 
            LET l_insert = FALSE
            LET p_cmd = ''
            LET l_ac1 = ARR_CURR()
            LET g_detail_idx = l_ac1
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac1 TO FORMONLY.idx
            CALL s_transaction_begin()
            OPEN abmt300_02_cl USING g_enterprise, g_site,g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN abmt300_02_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE abmt300_02_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            LET g_rec_b1 = g_bmfi4_d.getLength()
            
            IF g_rec_b1 >= l_ac1 AND NOT cl_null(g_bmfi4_d[l_ac1].bmfj004) THEN 
               LET l_cmd='u'
               LET g_bmfi4_d_t.* = g_bmfi4_d[l_ac1].*  #BACKUP
               OPEN abmt300_02_bcl4 USING g_enterprise,g_site,g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002,g_bmfi_d[l_ac].bmfi003,g_bmfi4_d[l_ac1].bmfj004
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "abmt300_02_bcl4"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw='Y'
               ELSE
                  FETCH abmt300_02_bcl4 INTO g_bmfi4_d[l_ac1].bmfj004,g_bmfi4_d[l_ac1].bmfj005,g_bmfi4_d[l_ac1].bmfj006
                   IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  LET g_bfill = "N"
                  CALL abmt300_02_show()
                  LET g_bfill = "Y"
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            
         BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_bmfi4_d[l_ac1].bmfj004) THEN
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF
           
               DELETE FROM bmfj_t
                WHERE bmfjent = g_enterprise 
                  AND bmfjsite = g_site
                  AND bmfjdocno = g_bmfb_m.bmfbdocno
                  AND bmfj002 = g_bmfb_m.bmfb002 
                  AND bmfj003 = g_bmfi_d[l_ac].bmfi003
                  AND bmfj004 = g_bmfi4_d[l_ac1].bmfj004
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "bmfj_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b1 = g_rec_b1-1
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE abmt300_02_bcl4
               LET l_count = g_bmfi_d.getLength()
            END IF 
            
            
         AFTER DELETE 
            
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count 
              FROM bmfj_t 
             WHERE bmfjent = g_enterprise 
                  AND bmfjsite = g_site
                  AND bmfjdocno = g_bmfb_m.bmfbdocno
                  AND bmfj002 = g_bmfb_m.bmfb002 
                  AND bmfj003 = g_bmfi_d[l_ac].bmfi003
                  AND bmfj004 = g_bmfi4_d[l_ac1].bmfj004
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               INSERT INTO bmfj_t(bmfjent,bmfjsite,bmfjdocno,bmfj002,bmfj003,bmfj004,bmfj005,bmfj006) 
                           VALUES(g_enterprise,g_site,g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002,g_bmfi_d[l_ac].bmfi003,g_bmfi4_d[l_ac1].bmfj004,g_bmfi4_d[l_ac1].bmfj005,g_bmfi4_d[l_ac1].bmfj006)

            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_bmfi4_d[l_ac1].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "bmfj_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b1 = g_rec_b1 + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_bmfi4_d[l_ac1].* = g_bmfi4_d_t.*
               CLOSE abmt300_02_bcl4
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_bmfi4_d[l_ac1].* = g_bmfi4_d_t.*
            ELSE
               UPDATE bmfj_t SET (bmfjdocno,bmfj002,bmfj003,bmfj004,bmfj005,bmfj006) 
                               = (g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002,g_bmfi_d[l_ac].bmfi003,g_bmfi4_d[l_ac1].bmfj004,g_bmfi4_d[l_ac1].bmfj005,g_bmfi4_d[l_ac1].bmfj006)
                WHERE bmfjent = g_enterprise 
                  AND bmfjsite = g_site 
                  AND bmfjdocno = g_bmfb_m.bmfbdocno
                  AND bmfj002 = g_bmfb_m.bmfb002
                  AND bmfj003 = g_bmfi_d[l_ac].bmfi003
                  AND bmfj004 = g_bmfi4_d_t.bmfj004
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  LET g_bmfi4_d[l_ac1].* = g_bmfi4_d_t.*
               END IF
              
            END IF
 
         BEFORE FIELD bmfj004
            
         AFTER FIELD bmfj004
            IF NOT cl_null(g_bmfb_m.bmfbdocno) AND NOT cl_null(g_bmfb_m.bmfb002) AND NOT cl_null(g_bmfi_d[l_ac].bmfi003)AND NOT cl_null(g_bmfi4_d[l_ac1].bmfj004) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_bmfb_m.bmfbdocno != g_bmfbdocno_t OR g_bmfb_m.bmfb002 != g_bmfb002_t OR g_bmfi_d[l_ac].bmfi003 != g_bmfi_d_t.bmfi003 OR g_bmfi4_d[l_ac1].bmfj004 != g_bmfi4_d_t.bmfj004))) THEN 
                  IF NOT ap_chk_notDup(g_bmfi4_d[l_ac1].bmfj004,"SELECT COUNT(*) FROM bmfj_t WHERE "||"bmfjent = '" ||g_enterprise|| "' AND bmfjsite = '" ||g_site|| "' AND "||"bmfjdocno = '"||g_bmfb_m.bmfbdocno ||"' AND "|| "bmfj002 = '"||g_bmfb_m.bmfb002 ||"' AND "|| "bmfj003 = '"||g_bmfi_d[l_ac].bmfi003 ||"' AND "|| "bmfj004 = '"||g_bmfi4_d[l_ac1].bmfj004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
         ON CHANGE bmfj004
         ON ACTION controlp INFIELD bmfj004
         
         BEFORE FIELD bmfj005
            
         AFTER FIELD bmfj005
            LET l_result = TRUE
            LET l_result1 = TRUE
            IF NOT cl_null(g_bmfi4_d[l_ac1].bmfj005) THEN
               CALL abmt300_02_chk_num(g_bmfi4_d[l_ac1].bmfj005) RETURNING l_result
               IF l_result THEN
                  IF NOT cl_null(g_bmfi4_d[l_ac1].bmfj006) THEN
                     CALL abmt300_02_chk_num(g_bmfi4_d[l_ac1].bmfj006) RETURNING l_result1
                     IF l_result1 THEN
                        LET l_bmfj005 = g_bmfi4_d[l_ac1].bmfj005 
                        LET l_bmfj006 = g_bmfi4_d[l_ac1].bmfj006
                        IF l_bmfj005 > l_bmfj006 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'abm-00037'
                           LET g_errparam.extend = g_bmfi4_d[l_ac1].bmfj005
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                           LET g_bmfi4_d[l_ac1].bmfj005 = g_bmfi4_d_t.bmfj005
                           NEXT FIELD bmfj005
                        END IF
                        CALL abmt300_02_chk_bmfj005(g_bmfi4_d[l_ac1].bmfj005,g_bmfi4_d[l_ac1].bmfj006)
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = g_bmfi4_d[l_ac1].bmfj005
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                           LET g_bmfi4_d[l_ac1].bmfj005 = g_bmfi4_d_t.bmfj005
                           NEXT FIELD bmfj005
                        END IF
                     END IF 
                  END IF
               END IF
            END IF
            CALL abmt300_02_set_entry_b(l_cmd)
            CALL abmt300_02_set_no_entry_b(l_cmd)
            
         ON CHANGE bmfj005
            CALL abmt300_02_set_entry_b(l_cmd)
            CALL abmt300_02_set_no_entry_b(l_cmd)
            
         ON ACTION controlp INFIELD bmfj005

         BEFORE FIELD bmfj006
            IF cl_null(g_bmfi4_d[l_ac1].bmfj006) THEN
               LET g_bmfi4_d[l_ac1].bmfj006 = g_bmfi4_d[l_ac1].bmfj005
            END IF
            CALL abmt300_02_set_entry_b(l_cmd)
            CALL abmt300_02_set_no_entry_b(l_cmd)
            
         AFTER FIELD bmfj006
            LET l_result = TRUE
            LET l_result1 = TRUE
            IF NOT cl_null(g_bmfi4_d[l_ac1].bmfj006) THEN
               CALL abmt300_02_chk_num(g_bmfi4_d[l_ac1].bmfj006) RETURNING l_result
               IF l_result THEN
                  IF NOT cl_null(g_bmfi4_d[l_ac1].bmfj005) THEN
                     CALL abmt300_02_chk_num(g_bmfi4_d[l_ac1].bmfj005) RETURNING l_result1
                     IF l_result1 THEN
                        LET l_bmfj005 = g_bmfi4_d[l_ac1].bmfj005 
                        LET l_bmfj006 = g_bmfi4_d[l_ac1].bmfj006
                        IF l_bmfj005 > l_bmfj006 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'abm-00037'
                           LET g_errparam.extend = g_bmfi4_d[l_ac1].bmfj006
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                           LET g_bmfi4_d[l_ac1].bmfj006 = g_bmfi4_d_t.bmfj006
                           NEXT FIELD bmfj006
                        END IF
                        CALL abmt300_02_chk_bmfj005(g_bmfi4_d[l_ac1].bmfj005,g_bmfi4_d[l_ac1].bmfj006)
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = g_bmfi4_d[l_ac1].bmfj006
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                           LET g_bmfi4_d[l_ac1].bmfj006 = g_bmfi4_d_t.bmfj006
                           NEXT FIELD bmfj006
                        END IF
                     END IF 
                  END IF
               END IF
            END IF
         ON CHANGE bmfj006
         ON ACTION controlp INFIELD bmfj006
 
         AFTER ROW
            LET l_ac1 = ARR_CURR()
            LET l_ac1_t = l_ac1
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_bmfi4_d[l_ac1].* = g_bmfi4_d_t.*
               END IF
               CLOSE abmt300_02_bcl4
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            CLOSE abmt300_02_bcl4
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
 
      END INPUT
      
      INPUT ARRAY g_bmfi5_d FROM s_detail5.*
         ATTRIBUTE(COUNT = g_rec_b1,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert,
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         BEFORE INPUT
            IF g_bmfi2_d[l_ac].bmfk003 IS NULL THEN 
               NEXT FIELD bmfk003
            END IF
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bmfi5_d.getLength()+1) 
              LET g_insert = 'N' 
            END IF 

            CALL abmt300_02_b_fill1()
            LET g_rec_b1 = g_bmfi5_d.getLength()
            IF g_bmfi2_d[l_ac].bmfk004 = '1' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abm-00081'
               LET g_errparam.extend = g_bmfi2_d[l_ac].bmfk004
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD bmfk004
            END IF
            
         BEFORE INSERT
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_bmfi5_d[l_ac1].* TO NULL 
            LET g_bmfi5_d_t.* = g_bmfi5_d[l_ac1].*     #新輸入資料
            CALL cl_show_fld_cont()
            
         BEFORE ROW 
            LET l_insert = FALSE
            LET p_cmd = ''
            LET l_ac1 = ARR_CURR()
            LET g_detail_idx = l_ac1
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac1 TO FORMONLY.idx
            CALL s_transaction_begin()
            OPEN abmt300_02_cl USING g_enterprise, g_site,g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN abmt300_02_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE abmt300_02_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            LET g_rec_b1 = g_bmfi5_d.getLength()
            
            IF g_rec_b1 >= l_ac1 AND NOT cl_null(g_bmfi5_d[l_ac1].bmfl004) THEN 
               LET l_cmd='u'
               LET g_bmfi5_d_t.* = g_bmfi5_d[l_ac1].*  #BACKUP
               OPEN abmt300_02_bcl5 USING g_enterprise,g_site,g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002,g_bmfi2_d[l_ac].bmfk003,g_bmfi5_d[l_ac1].bmfl004
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "abmt300_02_bcl5"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw='Y'
               ELSE
                  FETCH abmt300_02_bcl5 INTO g_bmfi5_d[l_ac1].bmfl004,g_bmfi5_d[l_ac1].bmfl005
                   IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  LET g_bfill = "N"
                  CALL abmt300_02_show()
                  LET g_bfill = "Y"
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            IF g_bmfi2_d[l_ac].bmfk004 = '1' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abm-00081'
               LET g_errparam.extend = g_bmfi2_d[l_ac].bmfk004
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD bmfk004
            END IF
            
         BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_bmfi5_d[l_ac1].bmfl004) THEN
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF
           
               DELETE FROM bmfl_t
                WHERE bmflent = g_enterprise 
                  AND bmflsite = g_site
                  AND bmfldocno = g_bmfb_m.bmfbdocno
                  AND bmfl002 = g_bmfb_m.bmfb002 
                  AND bmfl003 = g_bmfi2_d[l_ac].bmfk003
                  AND bmfl004 = g_bmfi5_d[l_ac1].bmfl004
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "bmfl_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b1 = g_rec_b1-1
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE abmt300_02_bcl5
               LET l_count = g_bmfi_d.getLength()
            END IF 
            
            
         AFTER DELETE 
            
            
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count 
              FROM bmfl_t 
             WHERE bmflent = g_enterprise 
                  AND bmflsite = g_site
                  AND bmfldocno = g_bmfb_m.bmfbdocno
                  AND bmfl002 = g_bmfb_m.bmfb002 
                  AND bmfl003 = g_bmfi2_d[l_ac].bmfk003
                  AND bmfl004 = g_bmfi5_d[l_ac1].bmfl004
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               INSERT INTO bmfl_t(bmflent,bmflsite,bmfldocno,bmfl002,bmfl003,bmfl004,bmfl005) 
                           VALUES(g_enterprise,g_site,g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002,g_bmfi2_d[l_ac].bmfk003,g_bmfi5_d[l_ac1].bmfl004,g_bmfi5_d[l_ac1].bmfl005)

            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_bmfi5_d[l_ac1].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "bmfl_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b1 = g_rec_b1 + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_bmfi5_d[l_ac1].* = g_bmfi5_d_t.*
               CLOSE abmt300_02_bcl5
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_bmfi5_d[l_ac1].* = g_bmfi5_d_t.*
            ELSE
               UPDATE bmfl_t SET (bmfldocno,bmfl002,bmfl003,bmfl004,bmfl005) 
                               = (g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002,g_bmfi2_d[l_ac].bmfk003,g_bmfi5_d[l_ac1].bmfl004,g_bmfi5_d[l_ac1].bmfl005)
                WHERE bmflent = g_enterprise 
                  AND bmflsite = g_site 
                  AND bmfldocno = g_bmfb_m.bmfbdocno
                  AND bmfl002 = g_bmfb_m.bmfb002
                  AND bmfl003 = g_bmfi2_d[l_ac].bmfk003
                  AND bmfl004 = g_bmfi5_d_t.bmfl004
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  LET g_bmfi5_d[l_ac1].* = g_bmfi5_d_t.*
               END IF
              
            END IF
 
         BEFORE FIELD bmfl004
            
         AFTER FIELD bmfl004
            IF NOT cl_null(g_bmfb_m.bmfbdocno) AND NOT cl_null(g_bmfb_m.bmfb002) AND NOT cl_null(g_bmfi2_d[l_ac].bmfk003)AND NOT cl_null(g_bmfi5_d[l_ac1].bmfl004) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_bmfb_m.bmfbdocno != g_bmfbdocno_t OR g_bmfb_m.bmfb002 != g_bmfb002_t OR g_bmfi2_d[l_ac].bmfk003 != g_bmfi2_d_t.bmfk003 OR g_bmfi5_d[l_ac1].bmfl004 != g_bmfi5_d_t.bmfl004))) THEN 
                  IF NOT ap_chk_notDup(g_bmfi5_d[l_ac1].bmfl004,"SELECT COUNT(*) FROM bmfl_t WHERE "||"bmflent = '" ||g_enterprise|| "' AND bmflsite = '" ||g_site|| "' AND "||"bmfldocno = '"||g_bmfb_m.bmfbdocno ||"' AND "|| "bmfl002 = '"||g_bmfb_m.bmfb002 ||"' AND "|| "bmfl003 = '"||g_bmfi2_d[l_ac].bmfk003 ||"' AND "|| "bmfl004 = '"||g_bmfi5_d[l_ac1].bmfl004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
         ON CHANGE bmfl004
         ON ACTION controlp INFIELD bmfl004
         
         BEFORE FIELD bmfl005
            
         AFTER FIELD bmfl005
            
         ON CHANGE bmfl005
         ON ACTION controlp INFIELD bmfl005

         AFTER ROW
            LET l_ac1 = ARR_CURR()
            LET l_ac1_t = l_ac1
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_bmfi5_d[l_ac1].* = g_bmfi5_d_t.*
               END IF
               CLOSE abmt300_02_bcl5
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            CLOSE abmt300_02_bcl5
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
 
      END INPUT
      INPUT ARRAY g_bmfi6_d FROM s_detail6.*
         ATTRIBUTE(COUNT = g_rec_b1,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert,
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         BEFORE INPUT
            IF g_bmfi3_d[l_ac].bmfm003 IS NULL THEN 
               NEXT FIELD bmfm003
            END IF         
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bmfi6_d.getLength()+1) 
              LET g_insert = 'N' 
            END IF 

            CALL abmt300_02_b_fill1()
            LET g_rec_b1 = g_bmfi6_d.getLength()
            
         BEFORE INSERT
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_bmfi6_d[l_ac1].* TO NULL 
            LET g_bmfi6_d_t.* = g_bmfi6_d[l_ac1].*     #新輸入資料
            CALL cl_show_fld_cont()
            SELECT MAX(bmfn004) +1 INTO g_bmfi6_d[l_ac1].bmfn004
              FROM bmfn_t
             WHERE bmfnent = g_enterprise
               AND bmfnsite = g_site
               AND bmfndocno = g_bmfb_m.bmfbdocno
               AND bmfn002 = g_bmfb_m.bmfb002
               AND bmfn003 = g_bmfi3_d[l_ac].bmfm003
            IF cl_null(g_bmfi6_d[l_ac1].bmfn004) THEN
               LET g_bmfi6_d[l_ac1].bmfn004 = 1
            END IF
            
         BEFORE ROW 
            LET l_insert = FALSE
            LET p_cmd = ''
            LET l_ac1 = ARR_CURR()
            LET g_detail_idx = l_ac1
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac1 TO FORMONLY.idx
            CALL s_transaction_begin()
            OPEN abmt300_02_cl USING g_enterprise, g_site,g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN abmt300_02_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE abmt300_02_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            LET g_rec_b1 = g_bmfi6_d.getLength()
            
            IF g_rec_b1 >= l_ac1 AND NOT cl_null(g_bmfi6_d[l_ac1].bmfn004) THEN 
               LET l_cmd='u'
               LET g_bmfi6_d_t.* = g_bmfi6_d[l_ac1].*  #BACKUP
               OPEN abmt300_02_bcl6 USING g_enterprise,g_site,g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002,g_bmfi3_d[l_ac].bmfm003,g_bmfi6_d[l_ac1].bmfn004
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "abmt300_02_bcl6"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw='Y'
               ELSE
                  FETCH abmt300_02_bcl6 INTO g_bmfi6_d[l_ac1].bmfn004,g_bmfi6_d[l_ac1].bmfn005,g_bmfi6_d[l_ac1].bmfn006
                   IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  LET g_bfill = "N"
                  CALL abmt300_02_show()
                  LET g_bfill = "Y"
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            
         BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_bmfi6_d[l_ac1].bmfn004) THEN
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF
           
               DELETE FROM bmfn_t
                WHERE bmfnent = g_enterprise 
                  AND bmfnsite = g_site
                  AND bmfndocno = g_bmfb_m.bmfbdocno
                  AND bmfn002 = g_bmfb_m.bmfb002 
                  AND bmfn003 = g_bmfi3_d[l_ac].bmfm003
                  AND bmfn004 = g_bmfi6_d[l_ac1].bmfn004
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "bmfn_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b1 = g_rec_b1-1
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE abmt300_02_bcl6
               LET l_count = g_bmfi_d.getLength()
            END IF 
            
            
         AFTER DELETE 
            
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count 
              FROM bmfn_t 
             WHERE bmfnent = g_enterprise 
                  AND bmfnsite = g_site
                  AND bmfndocno = g_bmfb_m.bmfbdocno
                  AND bmfn002 = g_bmfb_m.bmfb002 
                  AND bmfn003 = g_bmfi3_d[l_ac].bmfm003
                  AND bmfn004 = g_bmfi6_d[l_ac1].bmfn004
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               INSERT INTO bmfn_t(bmfnent,bmfnsite,bmfndocno,bmfn002,bmfn003,bmfn004,bmfn005,bmfn006) 
                           VALUES(g_enterprise,g_site,g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002,g_bmfi3_d[l_ac].bmfm003,g_bmfi6_d[l_ac1].bmfn004,g_bmfi6_d[l_ac1].bmfn005,g_bmfi6_d[l_ac1].bmfn006)

            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_bmfi6_d[l_ac1].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "bmfn_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b1 = g_rec_b1 + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_bmfi6_d[l_ac1].* = g_bmfi6_d_t.*
               CLOSE abmt300_02_bcl6
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_bmfi6_d[l_ac1].* = g_bmfi6_d_t.*
            ELSE
               UPDATE bmfn_t SET (bmfndocno,bmfn002,bmfn003,bmfn004,bmfn005,bmfn006) 
                               = (g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002,g_bmfi3_d[l_ac].bmfm003,g_bmfi6_d[l_ac1].bmfn004,g_bmfi6_d[l_ac1].bmfn005,g_bmfi6_d[l_ac1].bmfn006)
                WHERE bmfnent = g_enterprise 
                  AND bmfnsite = g_site 
                  AND bmfndocno = g_bmfb_m.bmfbdocno
                  AND bmfn002 = g_bmfb_m.bmfb002
                  AND bmfn003 = g_bmfi3_d[l_ac].bmfm003
                  AND bmfn004 = g_bmfi6_d_t.bmfn004
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  LET g_bmfi6_d[l_ac1].* = g_bmfi6_d_t.*
               END IF
              
            END IF
 
         BEFORE FIELD bmfn004
            
         AFTER FIELD bmfn004
            IF NOT cl_null(g_bmfb_m.bmfbdocno) AND NOT cl_null(g_bmfb_m.bmfb002) AND NOT cl_null(g_bmfi3_d[l_ac].bmfm003)AND NOT cl_null(g_bmfi6_d[l_ac1].bmfn004) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_bmfb_m.bmfbdocno != g_bmfbdocno_t OR g_bmfb_m.bmfb002 != g_bmfb002_t OR g_bmfi3_d[l_ac].bmfm003 != g_bmfi_d_t.bmfi003 OR g_bmfi6_d[l_ac1].bmfn004 != g_bmfi6_d_t.bmfn004))) THEN 
                  IF NOT ap_chk_notDup(g_bmfi6_d[l_ac1].bmfn004,"SELECT COUNT(*) FROM bmfn_t WHERE "||"bmfnent = '" ||g_enterprise|| "' AND bmfnsite = '" ||g_site|| "' AND "||"bmfndocno = '"||g_bmfb_m.bmfbdocno ||"' AND "|| "bmfn002 = '"||g_bmfb_m.bmfb002 ||"' AND "|| "bmfn003 = '"||g_bmfi3_d[l_ac].bmfm003 ||"' AND "|| "bmfn004 = '"||g_bmfi6_d[l_ac1].bmfn004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
         ON CHANGE bmfn004
         ON ACTION controlp INFIELD bmfn004
         
         BEFORE FIELD bmfn005
            
         AFTER FIELD bmfn005
            LET l_result = TRUE
            LET l_result1 = TRUE
            IF NOT cl_null(g_bmfi6_d[l_ac1].bmfn005) THEN
               CALL abmt300_02_chk_num(g_bmfi6_d[l_ac1].bmfn005) RETURNING l_result
               IF l_result THEN
                  IF NOT cl_null(g_bmfi6_d[l_ac1].bmfn006) THEN
                     CALL abmt300_02_chk_num(g_bmfi6_d[l_ac1].bmfn006) RETURNING l_result1
                     IF l_result1 THEN
                        LET l_bmfn005 = g_bmfi6_d[l_ac1].bmfn005
                        LET l_bmfn006 = g_bmfi6_d[l_ac1].bmfn006
                        IF l_bmfn005 > l_bmfn006 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'abm-00037'
                           LET g_errparam.extend = g_bmfi6_d[l_ac1].bmfn005
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                           LET g_bmfi6_d[l_ac1].bmfn005 = g_bmfi6_d_t.bmfn005
                           NEXT FIELD bmfn005
                        END IF
                        CALL abmt300_02_chk_bmfn005(g_bmfi6_d[l_ac1].bmfn005,g_bmfi6_d[l_ac1].bmfn006)
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = g_bmfi6_d[l_ac1].bmfn005
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                           LET g_bmfi6_d[l_ac1].bmfn005 = g_bmfi6_d_t.bmfn005
                           NEXT FIELD bmfn005
                        END IF
                     END IF
                  END IF
               END IF
            END IF
            CALL abmt300_02_set_entry_b(l_cmd)
            CALL abmt300_02_set_no_entry_b(l_cmd)
            
         ON CHANGE bmfn005
            CALL abmt300_02_set_entry_b(l_cmd)
            CALL abmt300_02_set_no_entry_b(l_cmd)
            
         ON ACTION controlp INFIELD bmfn005

         BEFORE FIELD bmfn006
            IF cl_null(g_bmfi6_d[l_ac1].bmfn006) THEN
               LET g_bmfi6_d[l_ac1].bmfn006 = g_bmfi6_d_t.bmfn006
            END IF
            CALL abmt300_02_set_entry_b(l_cmd)
            CALL abmt300_02_set_no_entry_b(l_cmd)
            
         AFTER FIELD bmfn006
            LET l_result = TRUE
            LET l_result1 = TRUE
            IF NOT cl_null(g_bmfi6_d[l_ac1].bmfn006) THEN
               CALL abmt300_02_chk_num(g_bmfi6_d[l_ac1].bmfn006) RETURNING l_result
               IF l_result THEN
                  IF NOT cl_null(g_bmfi6_d[l_ac1].bmfn005) THEN
                     CALL abmt300_02_chk_num(g_bmfi6_d[l_ac1].bmfn005) RETURNING l_result1
                     IF l_result1 THEN
                        LET l_bmfn005 = g_bmfi6_d[l_ac1].bmfn005
                        LET l_bmfn006 = g_bmfi6_d[l_ac1].bmfn006
                        IF l_bmfn005 > l_bmfn006 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'abm-00037'
                           LET g_errparam.extend = g_bmfi6_d[l_ac1].bmfn006
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                           LET g_bmfi6_d[l_ac1].bmfn006 = g_bmfi6_d_t.bmfn006
                           NEXT FIELD bmfn006
                        END IF
                        CALL abmt300_02_chk_bmfn005(g_bmfi6_d[l_ac1].bmfn005,g_bmfi6_d[l_ac1].bmfn006)
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = g_bmfi6_d[l_ac1].bmfn006
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                           LET g_bmfi6_d[l_ac1].bmfn006 = g_bmfi6_d_t.bmfn006
                           NEXT FIELD bmfn006
                        END IF
                     END IF
                  END IF
               END IF
            END IF
            
         ON CHANGE bmfn006
         ON ACTION controlp INFIELD bmfn006
 
         AFTER ROW
            LET l_ac1 = ARR_CURR()
            LET l_ac1_t = l_ac1
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_bmfi6_d[l_ac1].* = g_bmfi6_d_t.*
               END IF
               CLOSE abmt300_02_bcl6
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            CLOSE abmt300_02_bcl6
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
 
      END INPUT
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         CALL abmt300_02_bmfb_show()
         NEXT FIELD bmfi003
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue("'3',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD bmfbdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD bmfi003
               WHEN "s_detail2"
                  NEXT FIELD bmfk003
               WHEN "s_detail3"
                  NEXT FIELD bmfm003
 
               #add-point:input段modify_detail  name="input.modify_detail.other"
               
               #end add-point  
            END CASE
         END IF
      
      AFTER DIALOG
         #add-point:input段after_dialog name="input.after_dialog"
         
         #end add-point    
         
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controls
         IF g_header_hidden THEN
            CALL gfrm_curr.setElementHidden("vb_master",0)
            CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
            LET g_header_hidden = 0     #visible
         ELSE
            CALL gfrm_curr.setElementHidden("vb_master",1)
            CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
            LET g_header_hidden = 1     #hidden     
         END IF
 
      ON ACTION accept
         #add-point:input段accept  name="input.accept"
         
         #end add-point    
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         #add-point:input段cancel name="input.cancel"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
         LET g_detail_idx_list[2] = 1
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         #add-point:input段close name="input.close"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         #add-point:input段exit name="input.exit"
         
         #end add-point
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
         LET g_detail_idx_list[2] = 1
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION abmt300_02_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   IF l_ac = 0 OR cl_null(l_ac) THEN
      LET l_ac = 1
   END IF
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL abmt300_02_b_fill() #單身填充
      CALL abmt300_02_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL abmt300_02_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   CALL abmt300_02_bmfb_show()
   IF g_bfill = "Y" THEN
      CALL abmt300_02_b_fill1()                 #聯動單身
   END IF
   #end add-point
   
   #遮罩相關處理
   LET g_bmfb_m_mask_o.* =  g_bmfb_m.*
   CALL abmt300_02_bmfb_t_mask()
   LET g_bmfb_m_mask_n.* =  g_bmfb_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb005,g_bmfb_m.bmfb006,g_bmfb_m.bmfb002,g_bmfb_m.bmfb005_desc, 
       g_bmfb_m.bmfb006_desc,g_bmfb_m.bmfb003,g_bmfb_m.bmfb005_desc1,g_bmfb_m.bmfb006_desc1,g_bmfb_m.bmfa003, 
       g_bmfb_m.bmfb008,g_bmfb_m.bmfb008_desc,g_bmfb_m.bmfa003_desc,g_bmfb_m.bmfb009,g_bmfb_m.bmfb009_desc, 
       g_bmfb_m.bmfa003_desc1,g_bmfb_m.bmfb010
   
   #顯示狀態(stus)圖片
   
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_bmfi_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      CALL abmt300_02_bmfi_desc()
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_bmfi2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bmfi2_d[l_ac].bmfk003
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bmfi2_d[l_ac].bmfk003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bmfi2_d[l_ac].bmfk003_desc

      #end add-point
   END FOR
   FOR l_ac = 1 TO g_bmfi3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bmfi3_d[l_ac].bmfm003
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bmfi3_d[l_ac].bmfm003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bmfi3_d[l_ac].bmfm003_desc

      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL abmt300_02_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION abmt300_02_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point  
   #add-point:detail_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="detail_show.before"
   
   #end add-point
   
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION abmt300_02_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE bmfb_t.bmfbdocno 
   DEFINE l_oldno     LIKE bmfb_t.bmfbdocno 
   DEFINE l_newno02     LIKE bmfb_t.bmfb002 
   DEFINE l_oldno02     LIKE bmfb_t.bmfb002 
 
   DEFINE l_master    RECORD LIKE bmfb_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE bmfi_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE bmfk_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE bmfm_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET g_master_insert = FALSE
   
   IF g_bmfb_m.bmfbdocno IS NULL
   OR g_bmfb_m.bmfb002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_bmfbdocno_t = g_bmfb_m.bmfbdocno
   LET g_bmfb002_t = g_bmfb_m.bmfb002
 
    
   LET g_bmfb_m.bmfbdocno = ""
   LET g_bmfb_m.bmfb002 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
   
   
   #清空key欄位的desc
   
   
   CALL abmt300_02_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_bmfb_m.* TO NULL
      INITIALIZE g_bmfi_d TO NULL
      INITIALIZE g_bmfi2_d TO NULL
      INITIALIZE g_bmfi3_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL abmt300_02_show()
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code = 9001 
      LET g_errparam.popup = FALSE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL abmt300_02_set_act_visible()   
   CALL abmt300_02_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_bmfbdocno_t = g_bmfb_m.bmfbdocno
   LET g_bmfb002_t = g_bmfb_m.bmfb002
 
   
   #組合新增資料的條件
   LET g_add_browse = " bmfbent = " ||g_enterprise|| " AND bmfbsite = '" ||g_site|| "' AND",
                      " bmfbdocno = '", g_bmfb_m.bmfbdocno, "' "
                      ," AND bmfb002 = '", g_bmfb_m.bmfb002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abmt300_02_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL abmt300_02_idx_chk()
   
   
   #功能已完成,通報訊息中心
   CALL abmt300_02_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION abmt300_02_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE bmfi_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE bmfk_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE bmfm_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE abmt300_02_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM bmfi_t
    WHERE bmfient = g_enterprise AND bmfisite = g_site AND bmfidocno = g_bmfbdocno_t
     AND bmfi002 = g_bmfb002_t
 
    INTO TEMP abmt300_02_detail
 
   #將key修正為調整後   
   UPDATE abmt300_02_detail 
      #更新key欄位
      SET bmfidocno = g_bmfb_m.bmfbdocno
          , bmfi002 = g_bmfb_m.bmfb002
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO bmfi_t SELECT * FROM abmt300_02_detail
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE abmt300_02_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM bmfk_t 
    WHERE bmfkent = g_enterprise AND bmfksite = g_site AND bmfkdocno = g_bmfbdocno_t
      AND bmfk002 = g_bmfb002_t   
 
    INTO TEMP abmt300_02_detail
 
   #將key修正為調整後   
   UPDATE abmt300_02_detail SET bmfkdocno = g_bmfb_m.bmfbdocno
                                       , bmfk002 = g_bmfb_m.bmfb002
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO bmfk_t SELECT * FROM abmt300_02_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE abmt300_02_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM bmfm_t 
    WHERE bmfment = g_enterprise AND bmfmsite = g_site AND bmfmdocno = g_bmfbdocno_t
      AND bmfm002 = g_bmfb002_t   
 
    INTO TEMP abmt300_02_detail
 
   #將key修正為調整後   
   UPDATE abmt300_02_detail SET bmfmdocno = g_bmfb_m.bmfbdocno
                                       , bmfm002 = g_bmfb_m.bmfb002
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO bmfm_t SELECT * FROM abmt300_02_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE abmt300_02_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_bmfbdocno_t = g_bmfb_m.bmfbdocno
   LET g_bmfb002_t = g_bmfb_m.bmfb002
 
   
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.delete" >}
#+ 資料刪除
PRIVATE FUNCTION abmt300_02_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_bmfb_m.bmfbdocno IS NULL
   OR g_bmfb_m.bmfb002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN abmt300_02_cl USING g_enterprise, g_site,g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abmt300_02_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE abmt300_02_cl
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abmt300_02_master_referesh USING g_site,g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002 INTO g_bmfb_m.bmfbdocno, 
       g_bmfb_m.bmfb005,g_bmfb_m.bmfb006,g_bmfb_m.bmfb002,g_bmfb_m.bmfb003,g_bmfb_m.bmfb008,g_bmfb_m.bmfb009, 
       g_bmfb_m.bmfb010,g_bmfb_m.bmfb008_desc,g_bmfb_m.bmfb009_desc
   
   
   #檢查是否允許此動作
   IF NOT abmt300_02_action_chk() THEN
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_bmfb_m_mask_o.* =  g_bmfb_m.*
   CALL abmt300_02_bmfb_t_mask()
   LET g_bmfb_m_mask_n.* =  g_bmfb_m.*
   
   CALL abmt300_02_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL abmt300_02_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_bmfbdocno_t = g_bmfb_m.bmfbdocno
      LET g_bmfb002_t = g_bmfb_m.bmfb002
 
 
      DELETE FROM bmfb_t
       WHERE bmfbent = g_enterprise AND bmfbsite = g_site AND bmfbdocno = g_bmfb_m.bmfbdocno
         AND bmfb002 = g_bmfb_m.bmfb002
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_bmfb_m.bmfbdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM bmfi_t
       WHERE bmfient = g_enterprise AND bmfisite = g_site AND bmfidocno = g_bmfb_m.bmfbdocno
         AND bmfi002 = g_bmfb_m.bmfb002
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bmfi_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      DELETE FROM bmfj_t
       WHERE bmfjent = g_enterprise
         AND bmfjsite = g_site
         AND bmfjdocno = g_bmfb_m.bmfbdocno
         AND bmfj002 = g_bmfb_m.bmfb002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "bmfj_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN  
      END IF
      #end add-point
      
            
                                                               
      #add-point:單身刪除前 name="delete.body.b_delete2"
      
      #end add-point
      DELETE FROM bmfk_t
       WHERE bmfkent = g_enterprise AND bmfksite = g_site AND
             bmfkdocno = g_bmfb_m.bmfbdocno AND bmfk002 = g_bmfb_m.bmfb002
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bmfk_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      DELETE FROM bmfl_t
       WHERE bmflent = g_enterprise
         AND bmflsite = g_site
         AND bmfldocno = g_bmfb_m.bmfbdocno
         AND bmfl002 = g_bmfb_m.bmfb002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "bmfl_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN  
      END IF
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete3"
      
      #end add-point
      DELETE FROM bmfm_t
       WHERE bmfment = g_enterprise AND bmfmsite = g_site AND
             bmfmdocno = g_bmfb_m.bmfbdocno AND bmfm002 = g_bmfb_m.bmfb002
      #add-point:單身刪除中 name="delete.body.m_delete3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bmfm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete3"
      DELETE FROM bmfn_t
       WHERE bmfnent = g_enterprise
         AND bmfnsite = g_site
         AND bmfndocno = g_bmfb_m.bmfbdocno
         AND bmfn002 = g_bmfb_m.bmfb002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "bmfn_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN  
      END IF
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_bmfb_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE abmt300_02_cl
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_bmfi_d.clear() 
      CALL g_bmfi2_d.clear()       
      CALL g_bmfi3_d.clear()       
 
     
      CALL abmt300_02_ui_browser_refresh()  
      #CALL abmt300_02_ui_headershow()  
      #CALL abmt300_02_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL abmt300_02_browser_fill("")
         CALL abmt300_02_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
   ELSE
   END IF
 
   CLOSE abmt300_02_cl
 
   #功能已完成,通報訊息中心
   CALL abmt300_02_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION abmt300_02_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_bmfi_d.clear()
   CALL g_bmfi2_d.clear()
   CALL g_bmfi3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
#   #判斷是否填充
#      LET g_sql = "SELECT UNIQUE bmfi003,'' FROM bmfi_t", 
#                  " WHERE bmfient = ? AND bmfisite = ? AND bmfidocno = ? AND bmfi002 = ?"
#      
#      IF NOT cl_null(g_wc2_table1) THEN
#         LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
#      END IF
#      
#      #子單身的WC
#      
#      
#      LET g_sql = g_sql, " ORDER BY bmfi_t.bmfi003"
#
#      PREPARE abmt300_02_pb_1 FROM g_sql
#      DECLARE b_fill_cs_1 CURSOR FOR abmt300_02_pb_1
#      
#      LET g_cnt = l_ac
#      LET l_ac = 1
#      
#      OPEN b_fill_cs_1 USING g_enterprise, g_site,g_bmfb_m.bmfbdocno
#                                               ,g_bmfb_m.bmfb002
#
#
#                                               
#      FOREACH b_fill_cs_1 INTO g_bmfi_d[l_ac].bmfi003,g_bmfi_d[l_ac].bmfi003_desc
#         IF SQLCA.sqlcode THEN
#            CALL cl_err("FOREACH:",SQLCA.sqlcode,1)
#            EXIT FOREACH
#         END IF
#        
#         #add-point:b_fill段資料填充
#         CALL abmt300_02_bmfi_desc()
#         #end add-point
#      
#         LET l_ac = l_ac + 1
#         IF l_ac > g_max_rec AND g_error_show = 1 THEN
#            CALL cl_err( '', 9035, 1)
#            EXIT FOREACH
#         END IF
#         
#      END FOREACH
#      LET g_error_show = 0
#  
#   
#      LET g_sql = "SELECT UNIQUE bmfk003,'',bmfk004 FROM bmfk_t",
#                  " WHERE bmfkent = ? AND bmfksite = ? AND bmfkdocno = ? AND bmfk002 = ?"   
#      
#      IF NOT cl_null(g_wc2_table2) THEN
#         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
#      END IF
#      
#      #子單身的WC
#      
#      
#      LET g_sql = g_sql, " ORDER BY bmfk_t.bmfk003"
#
#      
#      PREPARE abmt300_02_pb_12_1 FROM g_sql
#      DECLARE b_fill_cs_12_1 CURSOR FOR abmt300_02_pb_12_1
#      
#      LET l_ac = 1
#      
#      OPEN b_fill_cs_12_1 USING g_enterprise, g_site,g_bmfb_m.bmfbdocno
#                                               ,g_bmfb_m.bmfb002
#
#
#                                               
#      FOREACH b_fill_cs_12_1 INTO g_bmfi2_d[l_ac].bmfk003,g_bmfi2_d[l_ac].bmfk003_desc,g_bmfi2_d[l_ac].bmfk004
#         IF SQLCA.sqlcode THEN
#            CALL cl_err("FOREACH:",SQLCA.sqlcode,1)
#            EXIT FOREACH
#         END IF
#        
#         #add-point:b_fill段資料填充
#         CALL abmt300_02_bmfk_desc()
#         #end add-point
#      
#         LET l_ac = l_ac + 1
#         IF l_ac > g_max_rec THEN
#            CALL cl_err( '', 9035, 0 )
#            EXIT FOREACH
#         END IF
#         
#      END FOREACH
#
#      LET g_sql = "SELECT  UNIQUE bmfm003,'' FROM bmfm_t", 
#                  " WHERE bmfment = ? AND bmfmsite = ? AND bmfmdocno = ? AND bmfm002 = ?"   
#      
#      IF NOT cl_null(g_wc2_table3) THEN
#         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
#      END IF
#
#      
#      LET g_sql = g_sql, " ORDER BY bmfm_t.bmfm003"
#
#      PREPARE abmt300_02_pb_13_1 FROM g_sql
#      DECLARE b_fill_cs_13_1 CURSOR FOR abmt300_02_pb_13_1
#      
#      LET l_ac = 1
#      
#      OPEN b_fill_cs_13_1 USING g_enterprise, g_site,g_bmfb_m.bmfbdocno
#                                               ,g_bmfb_m.bmfb002
#
#
#                                               
#      FOREACH b_fill_cs_13_1 INTO g_bmfi3_d[l_ac].bmfm003,g_bmfi3_d[l_ac].bmfm003_desc
#         IF SQLCA.sqlcode THEN
#            CALL cl_err("FOREACH:",SQLCA.sqlcode,1)
#            EXIT FOREACH
#         END IF
#        
#         #add-point:b_fill段資料填充
#         CALL abmt300_02_bmfm_desc()
#         #end add-point
#      
#         LET l_ac = l_ac + 1
#         IF l_ac > g_max_rec THEN
#            CALL cl_err( '', 9035, 0 )
#            EXIT FOREACH
#         END IF
#         
#      END FOREACH
#
#   
#   CALL g_bmfi_d.deleteElement(g_bmfi_d.getLength())
#   CALL g_bmfi2_d.deleteElement(g_bmfi2_d.getLength())
#
#   CALL g_bmfi3_d.deleteElement(g_bmfi3_d.getLength())
#
#
#   
#
#   LET l_ac = g_cnt
#   LET g_cnt = 0  
#   
#   FREE abmt300_02_pb_1
#   FREE abmt300_02_pb_12_1
#
#   FREE abmt300_02_pb_13_1
#
#   RETURN
   #end add-point
   
   #判斷是否填充
   IF abmt300_02_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT bmfi003 ,t1.oocql004 FROM bmfi_t",   
                     " INNER JOIN bmfb_t ON bmfbent = " ||g_enterprise|| " AND bmfbsite = '" ||g_site|| "' AND bmfbdocno = bmfidocno ",
                     " AND bmfb002 = bmfi002 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='273' AND t1.oocql002=bmfi003 AND t1.oocql003='"||g_dlang||"' ",
 
                     " WHERE"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY bmfi_t.bmfi003"
         
         #add-point:單身填充控制 name="b_fill.sql"
      LET g_sql = "SELECT UNIQUE bmfi003,'' FROM bmfi_t", 
                  " WHERE bmfient = ? AND bmfisite = ? AND bmfidocno = ? AND bmfi002 = ?"
      
      IF NOT cl_null(g_wc2_table1) THEN
         LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY bmfi_t.bmfi003"
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE abmt300_02_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR abmt300_02_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise, g_site,g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise, g_site,g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002 INTO g_bmfi_d[l_ac].bmfi003, 
          g_bmfi_d[l_ac].bmfi003_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         CALL abmt300_02_bmfi_desc()
         #end add-point
      
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code = 9035 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
            END IF
            EXIT FOREACH
         END IF
         
         LET l_ac = l_ac + 1
      END FOREACH
      LET g_error_show = 0
   
   END IF
    
   #判斷是否填充
   IF abmt300_02_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT bmfk003,bmfk004 ,t2.oocql004 FROM bmfk_t",   
                     " INNER JOIN  bmfb_t ON bmfbent = " ||g_enterprise|| " AND bmfbsite = '" ||g_site|| "' AND bmfbdocno = bmfkdocno ",
                     " AND bmfb002 = bmfk002 ",
 
                     "",
                     
                                    " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='273' AND t2.oocql002=bmfk003 AND t2.oocql003='"||g_dlang||"' ",
 
                     " WHERE"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY bmfk_t.bmfk003"
         
         #add-point:單身填充控制 name="b_fill.sql2"
      LET g_sql = "SELECT UNIQUE bmfk003,bmfk004,'' FROM bmfk_t",
                  " WHERE bmfkent = ? AND bmfksite = ? AND bmfkdocno = ? AND bmfk002 = ?"   
      
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY bmfk_t.bmfk003"
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE abmt300_02_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR abmt300_02_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise, g_site,g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise, g_site,g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002 INTO g_bmfi2_d[l_ac].bmfk003, 
          g_bmfi2_d[l_ac].bmfk004,g_bmfi2_d[l_ac].bmfk003_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         CALL abmt300_02_bmfk_desc()
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
   #判斷是否填充
   IF abmt300_02_fill_chk(3) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body3.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT bmfm003 ,t3.oocql004 FROM bmfm_t",   
                     " INNER JOIN  bmfb_t ON bmfbent = " ||g_enterprise|| " AND bmfbsite = '" ||g_site|| "' AND bmfbdocno = bmfmdocno ",
                     " AND bmfb002 = bmfm002 ",
 
                     "",
                     
                                    " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='273' AND t3.oocql002=bmfm003 AND t3.oocql003='"||g_dlang||"' ",
 
                     " WHERE"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body3.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY bmfm_t.bmfm003"
         
         #add-point:單身填充控制 name="b_fill.sql3"
      LET g_sql = "SELECT  UNIQUE bmfm003,'' FROM bmfm_t", 
                  " WHERE bmfment = ? AND bmfmsite = ? AND bmfmdocno = ? AND bmfm002 = ?"   
      
      IF NOT cl_null(g_wc2_table3) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY bmfm_t.bmfm003"
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE abmt300_02_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR abmt300_02_pb3
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs3 USING g_enterprise, g_site,g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002   #(ver:78)
                                               
      FOREACH b_fill_cs3 USING g_enterprise, g_site,g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002 INTO g_bmfi3_d[l_ac].bmfm003, 
          g_bmfi3_d[l_ac].bmfm003_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill3.fill"
         CALL abmt300_02_bmfm_desc()
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   
   #end add-point
   
   CALL g_bmfi_d.deleteElement(g_bmfi_d.getLength())
   CALL g_bmfi2_d.deleteElement(g_bmfi2_d.getLength())
   CALL g_bmfi3_d.deleteElement(g_bmfi3_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE abmt300_02_pb
   FREE abmt300_02_pb2
 
   FREE abmt300_02_pb3
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_bmfi_d.getLength()
      LET g_bmfi_d_mask_o[l_ac].* =  g_bmfi_d[l_ac].*
      CALL abmt300_02_bmfi_t_mask()
      LET g_bmfi_d_mask_n[l_ac].* =  g_bmfi_d[l_ac].*
   END FOR
   
   LET g_bmfi2_d_mask_o.* =  g_bmfi2_d.*
   FOR l_ac = 1 TO g_bmfi2_d.getLength()
      LET g_bmfi2_d_mask_o[l_ac].* =  g_bmfi2_d[l_ac].*
      CALL abmt300_02_bmfk_t_mask()
      LET g_bmfi2_d_mask_n[l_ac].* =  g_bmfi2_d[l_ac].*
   END FOR
   LET g_bmfi3_d_mask_o.* =  g_bmfi3_d.*
   FOR l_ac = 1 TO g_bmfi3_d.getLength()
      LET g_bmfi3_d_mask_o[l_ac].* =  g_bmfi3_d[l_ac].*
      CALL abmt300_02_bmfm_t_mask()
      LET g_bmfi3_d_mask_n[l_ac].* =  g_bmfi3_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION abmt300_02_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM bmfi_t
       WHERE bmfient = g_enterprise AND bmfisite = g_site AND
         bmfidocno = ps_keys_bak[1] AND bmfi002 = ps_keys_bak[2] AND bmfi003 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ":",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_bmfi_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM bmfk_t
       WHERE bmfkent = g_enterprise AND bmfksite = g_site AND
             bmfkdocno = ps_keys_bak[1] AND bmfk002 = ps_keys_bak[2] AND bmfk003 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bmfk_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_bmfi2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      DELETE FROM bmfl_t
       WHERE bmflent = g_enterprise
         AND bmflsite = g_site
         AND bmfldocno = ps_keys_bak[1]
         AND bmfl002 = ps_keys_bak[2]
         AND bmfl003 = ps_keys_bak[3]
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "bmfl_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
      
      #end add-point    
      DELETE FROM bmfm_t
       WHERE bmfment = g_enterprise AND bmfmsite = g_site AND
             bmfmdocno = ps_keys_bak[1] AND bmfm002 = ps_keys_bak[2] AND bmfm003 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bmfm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_bmfi3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
      DELETE FROM bmfn_t
       WHERE bmfnent = g_enterprise
         AND bmfnsite = g_site
         AND bmfndocno = ps_keys_bak[1]
         AND bmfn002 = ps_keys_bak[2]
         AND bmfn003 = ps_keys_bak[3]
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "bmfn_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION abmt300_02_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:insert_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      
      #end add-point 
      INSERT INTO bmfi_t
                  (bmfient, bmfisite,
                   bmfidocno,bmfi002,
                   bmfi003
                   ) 
            VALUES(g_enterprise, g_site,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   )
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bmfi_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_bmfi_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO bmfk_t
                  (bmfkent, bmfksite,
                   bmfkdocno,bmfk002,
                   bmfk003
                   ,bmfk004) 
            VALUES(g_enterprise, g_site,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_bmfi2_d[g_detail_idx].bmfk004)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bmfk_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_bmfi2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
      
      #end add-point 
      INSERT INTO bmfm_t
                  (bmfment, bmfmsite,
                   bmfmdocno,bmfm002,
                   bmfm003
                   ) 
            VALUES(g_enterprise, g_site,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   )
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bmfm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_bmfi3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION abmt300_02_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define(客製用) name="update_b.define_customerization"
   
   #end add-point   
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="update_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="update_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE   
   
   #判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR
   
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "bmfi_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL abmt300_02_bmfi_t_mask_restore('restore_mask_o')
               
      UPDATE bmfi_t 
         SET (bmfidocno,bmfi002,
              bmfi003
              ) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ) 
         WHERE bmfient = g_enterprise AND bmfisite = g_site AND bmfidocno = ps_keys_bak[1] AND bmfi002 = ps_keys_bak[2] AND bmfi003 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bmfi_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bmfi_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL abmt300_02_bmfi_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "bmfk_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL abmt300_02_bmfk_t_mask_restore('restore_mask_o')
               
      UPDATE bmfk_t 
         SET (bmfkdocno,bmfk002,
              bmfk003
              ,bmfk004) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_bmfi2_d[g_detail_idx].bmfk004) 
         WHERE bmfkent = g_enterprise AND bmfksite = g_site AND bmfkdocno = ps_keys_bak[1] AND bmfk002 = ps_keys_bak[2] AND bmfk003 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bmfk_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bmfk_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL abmt300_02_bmfk_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "bmfm_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL abmt300_02_bmfm_t_mask_restore('restore_mask_o')
               
      UPDATE bmfm_t 
         SET (bmfmdocno,bmfm002,
              bmfm003
              ) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ) 
         WHERE bmfment = g_enterprise AND bmfmsite = g_site AND bmfmdocno = ps_keys_bak[1] AND bmfm002 = ps_keys_bak[2] AND bmfm003 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update3"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bmfm_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bmfm_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL abmt300_02_bmfm_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update3"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION abmt300_02_key_update_b(ps_keys_bak,ps_table)
   #add-point:update_b段define(客製用) name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_key       DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION abmt300_02_key_delete_b(ps_keys_bak,ps_table)
   #add-point:delete_b段define(客製用) name="key_delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_delete_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_delete_b.pre_function"
   
   #end add-point
   
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION abmt300_02_lock_b(ps_table,ps_page)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point   
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
    
   #先刷新資料
   #CALL abmt300_02_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "bmfi_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN abmt300_02_bcl USING g_enterprise, g_site,
                                       g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002,g_bmfi_d[g_detail_idx].bmfi003  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "abmt300_02_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "bmfk_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN abmt300_02_bcl2 USING g_enterprise, g_site,
                                             g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002,g_bmfi2_d[g_detail_idx].bmfk003 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "abmt300_02_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "bmfm_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN abmt300_02_bcl3 USING g_enterprise, g_site,
                                             g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002,g_bmfi3_d[g_detail_idx].bmfm003 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "abmt300_02_bcl3:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
 
   
 
   
   #add-point:lock_b段other name="lock_b.other"
   
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION abmt300_02_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE abmt300_02_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE abmt300_02_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE abmt300_02_bcl3
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION abmt300_02_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("bmfbdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("bmfbdocno,bmfb002",TRUE)
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("bmfbdocno,bmfb002",FALSE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION abmt300_02_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("bmfbdocno,bmfb002",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("bmfbdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION abmt300_02_set_entry_b(p_cmd)
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_entry_b.pre_function"
   
   #end add-point
    
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("",TRUE)
      #add-point:set_entry段欄位控制 name="set_entry_b.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   CALL cl_set_comp_entry("bmfj006",TRUE)
   CALL cl_set_comp_entry("bmfn006",TRUE)
   CALL cl_set_comp_entry("bmfi003",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION abmt300_02_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_result          LIKE type_t.num5
   DEFINE l_imaa005         LIKE imaa_t.imaa005
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   IF l_ac1 = 0 OR cl_null(l_ac1) THEN
      LET l_ac1 = 1
   END IF
   IF NOT cl_null(g_bmfi4_d[l_ac1].bmfj005) THEN
      LET l_result = TRUE
      CALL abmt300_02_chk_num(g_bmfi4_d[l_ac1].bmfj005) RETURNING l_result
      IF NOT l_result THEN
         CALL cl_set_comp_entry("bmfj006",FALSE)
         LET g_bmfi4_d[l_ac1].bmfj006 = g_bmfi4_d[l_ac1].bmfj005
      END IF
   END IF
   IF NOT cl_null(g_bmfi6_d[l_ac1].bmfn005) THEN
      LET l_result = TRUE
      CALL abmt300_02_chk_num(g_bmfi6_d[l_ac1].bmfn005) RETURNING l_result
      IF NOT l_result THEN
         CALL cl_set_comp_entry("bmfn006",FALSE)
         LET g_bmfi6_d[l_ac1].bmfn006 = g_bmfi6_d[l_ac1].bmfn005
      END IF
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION abmt300_02_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION abmt300_02_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION abmt300_02_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION abmt300_02_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION abmt300_02_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization"
   
   #end add-point  
   DEFINE li_idx     LIKE type_t.num10
   DEFINE li_cnt     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE ls_where   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="default_search.before"
   
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " bmfbdocno = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " bmfb002 = '", g_argv[02], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      
      #預設查詢條件
      CALL cl_qbe_get_default_qryplan() RETURNING ls_where
      IF NOT cl_null(ls_where) THEN
         CALL util.JSON.parse(ls_where, la_wc)
         INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
         INITIALIZE g_wc2_table2 TO NULL
 
         INITIALIZE g_wc2_table3 TO NULL
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "bmfb_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "bmfi_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "bmfk_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "bmfm_t" 
                  LET g_wc2_table3 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
            OR NOT cl_null(g_wc2_table3)
 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
            IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
            END IF
 
            IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
            END IF
 
 
            IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
            END IF
         
            IF g_wc2.subString(1,5) = " AND " THEN
               LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
            END IF
         END IF
      END IF
    
      IF cl_null(g_wc) AND cl_null(g_wc2) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.state_change" >}
   
 
{</section>}
 
{<section id="abmt300_02.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION abmt300_02_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_bmfi4_d.getLength() THEN
         LET g_detail_idx = g_bmfi4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_bmfi4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bmfi4_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 5 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail5")
      IF g_detail_idx > g_bmfi5_d.getLength() THEN
         LET g_detail_idx = g_bmfi5_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_bmfi5_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bmfi5_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 6 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail6")
      IF g_detail_idx > g_bmfi6_d.getLength() THEN
         LET g_detail_idx = g_bmfi6_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_bmfi6_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bmfi6_d.getLength() TO FORMONLY.cnt
   END IF
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_bmfi_d.getLength() THEN
         LET g_detail_idx = g_bmfi_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_bmfi_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bmfi_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_bmfi2_d.getLength() THEN
         LET g_detail_idx = g_bmfi2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_bmfi2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bmfi2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_bmfi3_d.getLength() THEN
         LET g_detail_idx = g_bmfi3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_bmfi3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bmfi3_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION abmt300_02_b_fill2(pi_idx)
   #add-point:b_fill2段define(客製用) name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx                 LIKE type_t.num10
   DEFINE li_ac                  LIKE type_t.num10
   DEFINE li_detail_idx_tmp      LIKE type_t.num10
   DEFINE ls_chk                 LIKE type_t.chr1
   #add-point:b_fill2段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_detail_idx <= 0 THEN
      RETURN
   END IF
   
   LET li_detail_idx_tmp = g_detail_idx
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL abmt300_02_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION abmt300_02_fill_chk(ps_idx)
   #add-point:fill_chk段define(客製用) name="fill_chk.define_customerization"
   
   #end add-point
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fill_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="fill_chk.before_chk"
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
 
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1')  AND 
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1')  AND 
      (cl_null(g_wc2_table3) OR g_wc2_table3.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.status_show" >}
PRIVATE FUNCTION abmt300_02_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.mask_functions" >}
&include "erp/abm/abmt300_02_mask.4gl"
 
{</section>}
 
{<section id="abmt300_02.signature" >}
   
 
{</section>}
 
{<section id="abmt300_02.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION abmt300_02_set_pk_array()
   #add-point:set_pk_array段define name="set_pk_array.define_customerization"
   
   #end add-point
   #add-point:set_pk_array段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_pk_array.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="set_pk_array.before"
   
   #end add-point  
   
   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_bmfb_m.bmfbdocno
   LET g_pk_array[1].column = 'bmfbdocno'
   LET g_pk_array[2].values = g_bmfb_m.bmfb002
   LET g_pk_array[2].column = 'bmfb002'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abmt300_02.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="abmt300_02.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION abmt300_02_msgcentre_notify(lc_state)
   #add-point:msgcentre_notify段define name="msgcentre_notify.define_customerization"
   
   #end add-point   
   DEFINE lc_state LIKE type_t.chr80
   #add-point:msgcentre_notify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="msgcentre_notify.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="msgcentre_notify.pre_function"
   
   #end add-point
   
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = lc_state
 
   #PK資料填寫
   CALL abmt300_02_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_bmfb_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abmt300_02.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION abmt300_02_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="abmt300_02.other_function" readonly="Y" >}
#單頭資料顯示
PRIVATE FUNCTION abmt300_02_bmfb_show()
   LET g_bmfb_m.bmfbdocno = g_bmfbdocno
   LET g_bmfb_m.bmfa003 = g_bmfa003
   LET g_bmfb_m.bmfb005 = g_bmfb005
   LET g_bmfb_m.bmfb006 = g_bmfb006
   LET g_bmfb_m.bmfb002 = g_bmfb002
   LET g_bmfb_m.bmfb003 = g_bmfb003
   LET g_bmfb_m.bmfb008 = g_bmfb008
   LET g_bmfb_m.bmfb009 = g_bmfb009
   LET g_bmfb_m.bmfb010 = g_bmfb010
   DISPLAY BY NAME g_bmfb_m.bmfbdocno,g_bmfb_m.bmfa003,g_bmfb_m.bmfb005,g_bmfb_m.bmfb006,
                   g_bmfb_m.bmfb002,g_bmfb_m.bmfb003,g_bmfb_m.bmfb008,g_bmfb_m.bmfb009,g_bmfb_m.bmfb010
                   
   IF NOT cl_null(g_bmfb_m.bmfa003) THEN
      SELECT imaal003,imaal004
        INTO g_bmfb_m.bmfa003_desc,g_bmfb_m.bmfa003_desc1
        FROM imaal_t
       WHERE imaalent = g_enterprise
         AND imaal001 = g_bmfb_m.bmfa003
         AND imaal002 = g_dlang
      DISPLAY BY NAME g_bmfb_m.bmfa003_desc,g_bmfb_m.bmfa003_desc1
   END IF
   IF NOT cl_null(g_bmfb_m.bmfb005) THEN
      SELECT imaal003,imaal004
        INTO g_bmfb_m.bmfb005_desc,g_bmfb_m.bmfb005_desc1
        FROM imaal_t
       WHERE imaalent = g_enterprise
         AND imaal001 = g_bmfb_m.bmfb005
         AND imaal002 = g_dlang
      DISPLAY BY NAME g_bmfb_m.bmfb005_desc,g_bmfb_m.bmfb005_desc1   
   END IF
   IF NOT cl_null(g_bmfb_m.bmfb006) THEN
      SELECT imaal003,imaal004
        INTO g_bmfb_m.bmfb006_desc,g_bmfb_m.bmfb006_desc1
        FROM imaal_t
       WHERE imaalent = g_enterprise
         AND imaal001 = g_bmfb_m.bmfb006
         AND imaal002 = g_dlang
      DISPLAY BY NAME g_bmfb_m.bmfb006_desc,g_bmfb_m.bmfb006_desc1   
   END IF
   IF NOT cl_null(g_bmfb_m.bmfb008) THEN
      SELECT oocql004
        INTO g_bmfb_m.bmfb008_desc
        FROM oocql_t
       WHERE oocqlent = g_enterprise
         AND oocql001 = '215'
         AND oocql002 = g_bmfb_m.bmfb008
         AND oocql003 = g_dlang
      DISPLAY BY NAME g_bmfb_m.bmfb008_desc  
   END IF
   IF NOT cl_null(g_bmfb_m.bmfb009) THEN
      SELECT oocql004
        INTO g_bmfb_m.bmfb009_desc
        FROM oocql_t
       WHERE oocqlent = g_enterprise
         AND oocql001 = '221'
         AND oocql002 = g_bmfb_m.bmfb009
         AND oocql003 = g_dlang
      DISPLAY BY NAME g_bmfb_m.bmfb009_desc  
   END IF
END FUNCTION
#聯動單身填充
PRIVATE FUNCTION abmt300_02_b_fill1()
   CALL g_bmfi4_d.clear()
   CALL g_bmfi5_d.clear()
   CALL g_bmfi6_d.clear()
   IF cl_null(l_ac) OR l_ac = 0 THEN
      RETURN
   END IF
   LET g_sql = "SELECT UNIQUE bmfj004,bmfj005,bmfj006 FROM bmfj_t",
               " WHERE bmfjent=? AND bmfjsite=? AND bmfjdocno=? AND bmfj002=? AND bmfj003 = ? ",
               " ORDER BY bmfj_t.bmfj004 "
   PREPARE abmt300_02_pb4 FROM g_sql
   DECLARE b_fill1_cs CURSOR FOR abmt300_02_pb4
   LET l_ac1 = 1
 
   OPEN b_fill1_cs USING g_enterprise,g_site,g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002,g_bmfi_d[l_ac].bmfi003
   FOREACH b_fill1_cs INTO g_bmfi4_d[l_ac1].bmfj004,g_bmfi4_d[l_ac1].bmfj005,g_bmfi4_d[l_ac1].bmfj006
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF 
      LET l_ac1 = l_ac1 + 1
      IF l_ac1 > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH
   
   LET g_sql = "SELECT UNIQUE bmfl004,bmfl005 FROM bmfl_t",
               " WHERE bmflent=? AND bmflsite=? AND bmfldocno=? AND bmfl002=? AND bmfl003 = ? ",
               " ORDER BY bmfl_t.bmfl004 "
   PREPARE abmt300_02_pb5 FROM g_sql
   DECLARE b_fill1_cs5 CURSOR FOR abmt300_02_pb5
   LET l_ac1 = 1
 
   OPEN b_fill1_cs5 USING g_enterprise,g_site,g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002,g_bmfi2_d[l_ac].bmfk003
   FOREACH b_fill1_cs5 INTO g_bmfi5_d[l_ac1].bmfl004,g_bmfi5_d[l_ac1].bmfl005
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF 
      LET l_ac1 = l_ac1 + 1
      IF l_ac1 > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH
   
   LET g_sql = "SELECT UNIQUE bmfn004,bmfn005,bmfn006 FROM bmfn_t",
               " WHERE bmfnent=? AND bmfnsite=? AND bmfndocno=? AND bmfn002=? AND bmfn003 = ? ",
               " ORDER BY bmfn_t.bmfn004 "
   PREPARE abmt300_02_pb6 FROM g_sql
   DECLARE b_fill1_cs6 CURSOR FOR abmt300_02_pb6
   LET l_ac1 = 1
 
   OPEN b_fill1_cs6 USING g_enterprise,g_site,g_bmfb_m.bmfbdocno,g_bmfb_m.bmfb002,g_bmfi3_d[l_ac].bmfm003
   FOREACH b_fill1_cs6 INTO g_bmfi6_d[l_ac1].bmfn004,g_bmfi6_d[l_ac1].bmfn005,g_bmfi6_d[l_ac1].bmfn006
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF 
      LET l_ac1 = l_ac1 + 1
      IF l_ac1 > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH
   
   CALL g_bmfi4_d.deleteElement(g_bmfi4_d.getLength())
   CALL g_bmfi5_d.deleteElement(g_bmfi5_d.getLength())
   CALL g_bmfi6_d.deleteElement(g_bmfi6_d.getLength())
   
   FREE abmt300_02_pb4
   FREE abmt300_02_pb5
   FREE abmt300_02_pb6
END FUNCTION
#主件庫存特徵限定用料頁簽特徵起始值，終止值檢查
PRIVATE FUNCTION abmt300_02_chk_bmfj005(p_bmfj005,p_bmfj006)
DEFINE p_bmfj005         LIKE bmfj_t.bmfj005
DEFINE p_bmfj006         LIKE bmfj_t.bmfj006
DEFINE l_bmfj005         LIKE bmfj_t.bmfj005
DEFINE l_bmfj006         LIKE bmfj_t.bmfj006
DEFINE p_bmfj005_1       LIKE type_t.num5
DEFINE p_bmfj006_1       LIKE type_t.num5
DEFINE l_bmfj005_1       LIKE type_t.num5
DEFINE l_bmfj006_1       LIKE type_t.num5
DEFINE l_result          LIKE type_t.num5
DEFINE l_result1         LIKE type_t.num5
DEFINE l_sql             STRING

   LET g_errno = ""
   LET l_result = TRUE
   LET l_result1 = TRUE
   LET p_bmfj005_1 = p_bmfj005
   LET p_bmfj006_1 = p_bmfj006
   LET l_sql = " SELECT bmfj005,bmfj006 ",
               "   FROM bmfj_t",
               "  WHERE bmfjent = '",g_enterprise,"' ",
               "    AND bmfjsite = '",g_site,"' ",
               "    AND bmfjdocno = '",g_bmfbdocno,"' ",
               "    AND bmfj002 = '",g_bmfb_m.bmfb002,"' ",
               "    AND bmfj003 = '",g_bmfi_d[l_ac].bmfi003,"'",
               "    AND bmfj005 <>'",g_bmfi4_d_t.bmfj005,"'",
               "    AND bmfj006 <>'",g_bmfi4_d_t.bmfj006,"'"             
   PREPARE abmt300_02_chk_bmfj005_pb FROM l_sql
   DECLARE abmt300_02_chk_bmfj005_cs CURSOR FOR abmt300_02_chk_bmfj005_pb
   FOREACH abmt300_02_chk_bmfj005_cs INTO l_bmfj005,l_bmfj006
      IF NOT cl_null(l_bmfj005) AND NOT cl_null(l_bmfj006) THEN
         CALL abmt300_02_chk_num(l_bmfj005) RETURNING l_result
         IF l_result THEN
            CALL abmt300_02_chk_num(l_bmfj006) RETURNING l_result1
            IF l_result1 THEN
               LET l_bmfj005_1 = l_bmfj005
               LET l_bmfj006_1 = l_bmfj006
               IF (p_bmfj005_1 >= l_bmfj005_1 AND p_bmfj005_1 <= l_bmfj006_1) OR (p_bmfj006_1 >= l_bmfj005_1 AND p_bmfj006_1 <= l_bmfj006_1) OR (p_bmfj005_1 <= l_bmfj005_1 AND p_bmfj006_1 >= l_bmfj006_1) THEN
                  LET g_errno = 'abm-00036'
                  EXIT FOREACH
                  RETURN
               END IF
            END IF
         END IF
      END IF
   END FOREACH
END FUNCTION
################################################################################
# Descriptions...: 檢查輸入的字符是否是數值(包含小數和負數)
# Memo...........:
# Usage..........: CALL abmt300_02_chk_num(p_num)
#                  RETURNING r_result
# Input parameter: p_num     要檢查的值
# Return code....: r_result TRUE 是数值格式 FALSE 非数值格式
# Date & Author..: 2013/11/12 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION abmt300_02_chk_num(p_num)
DEFINE p_num        LIKE ecab_t.ecab007
DEFINE r_result     LIKE type_t.num5
DEFINE l_i          LIKE type_t.num5
DEFINE l_chr        LIKE type_t.chr1
DEFINE l_cnt        LIKE type_t.num5
DEFINE l_pos        LIKE type_t.num5
DEFINE l_len        LIKE type_t.num5


   LET r_result = TRUE
   #数值开始的位置,含'.'
   LET l_pos = 0
   #小数点出现的次数
   LET l_cnt = 0
   LET l_len = LENGTH(p_num CLIPPED)
   #第一個字符可以是數字或負號
   IF p_num[1,1] NOT MATCHES '[-0123456789]' THEN
      LET r_result = FALSE
   END IF
   #第一個字符是'-'則第二個字符不可以是'.'
   IF p_num[1,1] = '-' AND p_num[2,2] = '.' THEN
      LET r_result = FALSE
   END IF
   #最後一個字符只能是數字
   IF p_num[l_len,l_len] NOT MATCHES '[0123456789]' THEN
      LET r_result = FALSE
   END IF
   FOR l_i = 3 TO l_len
          LET l_chr = p_num[l_i,l_i]
       IF l_chr MATCHES '[.0123456789]' THEN
          IF l_pos = 0 THEN
             LET l_pos = l_i
          END IF
          IF l_chr = '.' THEN
             LET l_cnt = l_cnt + 1
          END IF
       ELSE
          IF l_chr = ' ' AND l_pos = 0 THEN
          ELSE
             LET r_result = FALSE
          END IF
       END IF
   END FOR

   IF l_cnt > 1 THEN
      LET r_result = FALSE
   END IF

   RETURN r_result
END FUNCTION
#限定元件庫存特徵特徵起始值，終止值檢查
PRIVATE FUNCTION abmt300_02_chk_bmfn005(p_bmfn005,p_bmfn006)
DEFINE p_bmfn005         LIKE bmfn_t.bmfn005
DEFINE p_bmfn006         LIKE bmfn_t.bmfn006
DEFINE l_bmfn005         LIKE bmfn_t.bmfn005
DEFINE l_bmfn006         LIKE bmfn_t.bmfn006
DEFINE p_bmfn005_1       LIKE type_t.num5
DEFINE p_bmfn006_1       LIKE type_t.num5
DEFINE l_bmfn005_1       LIKE type_t.num5
DEFINE l_bmfn006_1       LIKE type_t.num5
DEFINE l_result          LIKE type_t.num5
DEFINE l_result1         LIKE type_t.num5
DEFINE l_sql             STRING

   LET g_errno = ""
   LET l_result = TRUE
   LET l_result1 = TRUE
   LET p_bmfn005_1 = p_bmfn005
   LET p_bmfn006_1 = p_bmfn006
   LET l_sql = " SELECT bmfn005,bmfn006 ",
               "   FROM bmfn_t",
               "  WHERE bmfnent = '",g_enterprise,"' ",
               "    AND bmfnsite = '",g_site,"' ",
               "    AND bmfndocno = '",g_bmfbdocno,"' ",
               "    AND bmfn002 = '",g_bmfb_m.bmfb002,"' ",
               "    AND bmfn003 = '",g_bmfi3_d[l_ac].bmfm003,"'",
               "    AND bmfn005 <>'",g_bmfi6_d_t.bmfn005,"'",
               "    AND bmfn006 <>'",g_bmfi6_d_t.bmfn006,"'"             
   PREPARE abmt300_02_chk_bmfn005_pb FROM l_sql
   DECLARE abmt300_02_chk_bmfn005_cs CURSOR FOR abmt300_02_chk_bmfn005_pb
   FOREACH abmt300_02_chk_bmfn005_cs INTO l_bmfn005,l_bmfn006
      IF NOT cl_null(l_bmfn005) AND NOT cl_null(l_bmfn006) THEN
         CALL abmt300_02_chk_num(l_bmfn005) RETURNING l_result
         IF l_result THEN
            CALL abmt300_02_chk_num(l_bmfn006) RETURNING l_result1
            IF l_result1 THEN
               LET l_bmfn005_1 = l_bmfn005
               LET l_bmfn006_1 = l_bmfn006
               IF (p_bmfn005_1 >= l_bmfn005_1 AND p_bmfn005_1 <= l_bmfn006_1) OR (p_bmfn006_1 >= l_bmfn005_1 AND p_bmfn006_1 <= l_bmfn006_1) OR (p_bmfn005_1 <= l_bmfn005_1 AND p_bmfn006_1 >= l_bmfn006_1) THEN
                  LET g_errno = 'abm-00036'
                  EXIT FOREACH
                  RETURN
               END IF
            END IF
         END IF
      END IF
   END FOREACH
END FUNCTION
################################################################################
# Descriptions...: bmfi單身說明欄位帶值
# Memo...........:
# Usage..........: CALL abmt300_02_bmfi_desc()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2013/11/13 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION abmt300_02_bmfi_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_bmfi_d[l_ac].bmfi003
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '273' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_bmfi_d[l_ac].bmfi003_desc = g_rtn_fields[1] 
   #DISPLAY BY NAME g_bmfi_d[l_ac].bmfi003_desc
END FUNCTION
################################################################################
# Descriptions...: bmfk單身說明欄位帶值
# Memo...........:
# Usage..........: CALL abmt300_02_bmfk_desc()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2013/11/13 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION abmt300_02_bmfk_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_bmfi2_d[l_ac].bmfk003
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '273' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_bmfi2_d[l_ac].bmfk003_desc = '', g_rtn_fields[1] , ''
   #DISPLAY BY NAME g_bmfi2_d[l_ac].bmfk003_desc
END FUNCTION
################################################################################
# Descriptions...: bmfm單身說明欄位帶值
# Memo...........:
# Usage..........: CALL abmt300_02_bmfm_desc()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2013/11/13 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION abmt300_02_bmfm_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_bmfi3_d[l_ac].bmfm003
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '273' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_bmfi3_d[l_ac].bmfm003_desc = '', g_rtn_fields[1] , ''
   #DISPLAY BY NAME g_bmfi3_d[l_ac].bmfm003_desc
END FUNCTION
################################################################################
# Descriptions...: 檢查主件料號是否存在特徵類型
# Memo...........:
# Usage..........: CALL abmt300_02_chk_imeb(p_bmfi003)
# Input parameter: p_bmfi003 特徵類型
# Return code....: 無
# Date & Author..: 2013/11/13 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION abmt300_02_chk_imeb(p_bmfi003,p_type)
DEFINE p_bmfi003         LIKE bmfi_t.bmfi003
DEFINE p_type            LIKE type_t.chr1
DEFINE l_imaa005         LIKE imaa_t.imaa005
DEFINE l_imaa005_2       LIKE imaa_t.imaa005
DEFINE l_n               LIKE type_t.num5
DEFINE r_success         LIKE type_t.num5

   LET r_success = FALSE
   LET l_imaa005 = ""
   LET l_imaa005_2 = ""
   SELECT imaa005 INTO l_imaa005
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_bmfb_m.bmfa003
      
   SELECT imaa005 INTO l_imaa005_2
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_bmfb_m.bmfb005
          
   CASE p_type
      WHEN '1'
         IF cl_null(l_imaa005) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aec-00018'
            LET g_errparam.extend = g_bmfb_m.bmfa003
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN r_success
         END IF      
         INITIALIZE g_chkparam.* TO NULL
         LET g_chkparam.arg1 = l_imaa005
         LET g_chkparam.arg2 = p_bmfi003
         #160318-00025#18  by 07900 --add-str
         LET g_errshow = TRUE #是否開窗                   
         LET g_chkparam.err_str[1] ="aim-00159:sub-01302|aimi092|",cl_get_progname("aimi092",g_lang,"2"),"|:EXEPROGaimi092"
         #160318-00025#18  by 07900 --add-end
         IF cl_chk_exist("v_imeb004") THEN
         
         ELSE
            RETURN r_success 
         END IF
      WHEN '2'
         IF cl_null(l_imaa005) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aec-00018'
            LET g_errparam.extend = g_bmfb_m.bmfa003
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN r_success
         END IF 
         IF cl_null(l_imaa005_2) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aec-00048'
            LET g_errparam.extend = g_bmfb_m.bmfb005
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN r_success
         END IF          
         INITIALIZE g_chkparam.* TO NULL
         LET g_chkparam.arg1 = l_imaa005
         LET g_chkparam.arg2 = p_bmfi003
         #160318-00025#18  by 07900 --add-str
         LET g_errshow = TRUE #是否開窗                   
         LET g_chkparam.err_str[1] ="aim-00159:sub-01302|aimi092|",cl_get_progname("aimi092",g_lang,"2"),"|:EXEPROGaimi092"
         #160318-00025#18  by 07900 --add-end
         IF cl_chk_exist("v_imeb004") THEN
            INITIALIZE g_chkparam.* TO NULL
            LET g_chkparam.arg1 = l_imaa005_2
            LET g_chkparam.arg2 = p_bmfi003
            #160318-00025#18  by 07900 --add-str
            LET g_errshow = TRUE #是否開窗                   
            LET g_chkparam.err_str[1] ="aim-00159:sub-01302|aimi092|",cl_get_progname("aimi092",g_lang,"2"),"|:EXEPROGaimi092"
            #160318-00025#18  by 07900 --add-end
            IF cl_chk_exist("v_imeb004") THEN
               
            ELSE
               RETURN r_success 
            END IF         
         ELSE
            RETURN r_success 
         END IF         
      WHEN '3'
         IF cl_null(l_imaa005_2) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aec-00048'
            LET g_errparam.extend = g_bmfb_m.bmfb005
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN r_success
         END IF       
         INITIALIZE g_chkparam.* TO NULL
         LET g_chkparam.arg1 = l_imaa005_2
         LET g_chkparam.arg2 = p_bmfi003
         #160318-00025#18  by 07900 --add-str
         LET g_errshow = TRUE #是否開窗                   
         LET g_chkparam.err_str[1] ="aim-00159:sub-01302|aimi092|",cl_get_progname("aimi092",g_lang,"2"),"|:EXEPROGaimi092"
         #160318-00025#18  by 07900 --add-end
         IF cl_chk_exist("v_imeb004") THEN
         
         ELSE
            RETURN r_success 
         END IF  
   END CASE
   LET r_success = TRUE
   RETURN r_success 
END FUNCTION
################################################################################
# Descriptions...: 預設特徵類型
# Memo...........:
# Usage..........: CALL abmt300_02_def_imeb004()
#                  RETURNING r_imeb004
# Input parameter: 無
# Return code....: r_imeb004 特徵類型
# Date & Author..: 2013/11/13 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION abmt300_02_def_imeb004()
DEFINE l_imaa005         LIKE imaa_t.imaa005
DEFINE l_n               LIKE type_t.num5
DEFINE r_imeb004         LIKE imeb_t.imeb004

   LET r_imeb004 = ""
   LET l_imaa005 = ""
   SELECT imaa005 INTO l_imaa005
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_bmfb_m.bmfa003
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM imeb_t
    WHERE imebent = g_enterprise
      AND imeb001 = l_imaa005
   IF l_n  = 1 THEN
      SELECT imeb004 INTO r_imeb004
        FROM imeb_t
       WHERE imebent = g_enterprise
         AND imeb001 = l_imaa005
   END IF
   RETURN r_imeb004
END FUNCTION

################################################################################
# Descriptions...: 将旧元件的产品特征insert到对应的特征表中
# Date & Author..: 2015/08/03 By xianghui
# Modify.........:
################################################################################
PUBLIC FUNCTION abmt300_02_default(p_bmfadocno,p_bmfb002,p_bmfb005,p_bmfb008,p_bmfb009,p_bmfb010,p_bmfb017)
DEFINE p_bmfadocno   LIKE bmfa_t.bmfadocno
DEFINE p_bmfb002     LIKE bmfb_t.bmfb002
DEFINE p_bmfb005     LIKE bmfb_t.bmfb005
DEFINE p_bmfb008     LIKE bmfb_t.bmfb008
DEFINE p_bmfb009     LIKE bmfb_t.bmfb009
DEFINE p_bmfb010     LIKE bmfb_t.bmfb010
DEFINE p_bmfb017     LIKE bmfb_t.bmfb017


#160308-00001#1 earl mod s 由abmt300_02_default搬至s_abmt300_default
   CALL s_abmt300_default(p_bmfadocno,p_bmfb002,p_bmfb005,p_bmfb008,p_bmfb009,p_bmfb010,p_bmfb017)

#DEFINE l_bmfa003     LIKE bmfa_t.bmfa003
#DEFINE l_bmfa004     LIKE bmfa_t.bmfa004
#DEFINE l_bmfa005     DATETIME YEAR TO SECOND
#DEFINE l_cnt         LIKE type_t.num5
#DEFINE l_sql         STRING 
#
#   SELECT bmfa003,bmfa004,bmfa005 INTO l_bmfa003,l_bmfa004,l_bmfa005
#     FROM bmfa_t
#    WHERE bmfadocno = p_bmfadocno
#      AND bmfaent = g_enterprise
#      AND bmfasite = g_site
#   IF p_bmfb017 = 'N' THEN 
#      DELETE FROM bmfi_t WHERE bmfient = g_enterprise AND bmfidocno = p_bmfadocno AND bmfi002 = p_bmfb002
#      DELETE FROM bmfj_t WHERE bmfjent = g_enterprise AND bmfjdocno = p_bmfadocno AND bmfj002 = p_bmfb002
#      DELETE FROM bmfk_t WHERE bmfkent = g_enterprise AND bmfkdocno = p_bmfadocno AND bmfk002 = p_bmfb002
#      DELETE FROM bmfl_t WHERE bmflent = g_enterprise AND bmfldocno = p_bmfadocno AND bmfl002 = p_bmfb002
#      DELETE FROM bmfm_t WHERE bmfment = g_enterprise AND bmfmdocno = p_bmfadocno AND bmfm002 = p_bmfb002
#      DELETE FROM bmfn_t WHERE bmfnent = g_enterprise AND bmfndocno = p_bmfadocno AND bmfn002 = p_bmfb002
#      RETURN 
#   END IF
#   LET l_cnt = 0 
#   SELECT COUNT(*) INTO l_cnt
#     FROM bmfi_t
#    WHERE bmfient = g_enterprise
#      AND bmfidocno = p_bmfadocno    
#      AND bmfi002 = p_bmfb002
#   IF l_cnt  = 0 THEN 
#      #INS bmfi_t  ECN特征限定用料单头档
#      LET l_sql = " INSERT INTO bmfi_t(bmfient,bmfisite,bmfidocno,bmfi002,bmfi003) ",
#                  " SELECT DISTINCT '",g_enterprise,"','",g_site,"','",p_bmfadocno,"','",p_bmfb002,"',bmca009 ",
#                  "   FROM bmca_t ",
#                  "  WHERE bmcaent = '",g_enterprise,"' ",
#                  "    AND bmcasite = '",g_site,"' ",
#                  "    AND bmca001 = '",l_bmfa003,"'",
#                  "    AND bmca002 = '",l_bmfa004,"'",
#                  "    AND bmca003 = '",p_bmfb005,"'",                  
#                  "    AND bmca004 = '",p_bmfb008,"'",
#                  "    AND bmca005 <= to_date('",l_bmfa005,"','YYYY-MM-DD hh24:mi:ss') ",                  
#                  "    AND bmca007 = '",p_bmfb009,"'",
#                  "    AND bmca008 = '",p_bmfb010,"'"         
#      PREPARE ins_bmfi_pre FROM l_sql
#      EXECUTE ins_bmfi_pre 
#   
#      #INS bmfj_t ECN特征限定用料单身档
#      LET l_sql = " INSERT INTO bmfj_t(bmfjent,bmfjsite,bmfjdocno,bmfj002,bmfj003,bmfj004,bmfj005,bmfj006) ",
#                  " SELECT DISTINCT '",g_enterprise,"','",g_site,"','",p_bmfadocno,"','",p_bmfb002,"',bmcb009,bmcb010,bmcb011,bmcb012 ",
#                  "   FROM bmcb_t ",
#                  "  WHERE bmcbent = '",g_enterprise,"' ",
#                  "    AND bmcbsite = '",g_site,"' ",
#                  "    AND bmcb001 = '",l_bmfa003,"'",
#                  "    AND bmcb002 = '",l_bmfa004,"'",
#                  "    AND bmcb003 = '",p_bmfb005,"'",                  
#                  "    AND bmcb004 = '",p_bmfb008,"'",
#                  "    AND bmcb005 <= to_date('",l_bmfa005,"','YYYY-MM-DD hh24:mi:ss') ",                  
#                  "    AND bmcb007 = '",p_bmfb009,"'",
#                  "    AND bmcb008 = '",p_bmfb010,"'" 
#      PREPARE ins_bmfj_pre FROM l_sql
#      EXECUTE ins_bmfj_pre 
#
#   END IF 
#
#   LET l_cnt = 0 
#   SELECT COUNT(*) INTO l_cnt
#     FROM bmfk_t
#    WHERE bmfkent = g_enterprise
#      AND bmfkdocno = p_bmfadocno    
#      AND bmfk002 = p_bmfb002
#   IF l_cnt  = 0 THEN 
#      #變更方式=1.新增或2.修改
#      #INS bmfk_t ECN特对应单头档
#      LET l_sql = " INSERT INTO bmfk_t(bmfkent,bmfksite,bmfkdocno,bmfk002,bmfk003,bmfk004) ",
#                  " SELECT DISTINCT '",g_enterprise,"','",g_site,"','",p_bmfadocno,"','",p_bmfb002,"',bmcc009,bmcc010 ",
#                  "   FROM bmcc_t ",
#                  "  WHERE bmccent = '",g_enterprise,"' ",
#                  "    AND bmccsite = '",g_site,"' ",
#                  "    AND bmcc001 = '",l_bmfa003,"'",
#                  "    AND bmcc002 = '",l_bmfa004,"'",
#                  "    AND bmcc003 = '",p_bmfb005,"'",                  
#                  "    AND bmcc004 = '",p_bmfb008,"'",
#                  "    AND bmcc005 <= to_date('",l_bmfa005,"','YYYY-MM-DD hh24:mi:ss') ",                  
#                  "    AND bmcc007 = '",p_bmfb009,"'",
#                  "    AND bmcc008 = '",p_bmfb010,"'" 
#      PREPARE ins_bmfk_pre FROM l_sql
#      EXECUTE ins_bmfk_pre 
#
#      #變更方式=1.新增或2.修改
#      #INS bmfl_t特徵對應單身檔
#      LET l_sql = " INSERT INTO bmfl_t(bmflent,bmflsite,bmfldocno,bmfl002,bmfl003,bmfl004,bmfl005) ",
#                  " SELECT DISTINCT '",g_enterprise,"','",g_site,"','",p_bmfadocno,"','",p_bmfb002,"',bmcd009,bmcd010,bmcd011 ",
#                  "   FROM bmcd_t ",
#                  "  WHERE bmcdent = '",g_enterprise,"' ",
#                  "    AND bmcdsite = '",g_site,"' ",
#                  "    AND bmcd001 = '",l_bmfa003,"'",
#                  "    AND bmcd002 = '",l_bmfa004,"'",
#                  "    AND bmcd003 = '",p_bmfb005,"'",                  
#                  "    AND bmcd004 = '",p_bmfb008,"'",
#                  "    AND bmcd005 <= to_date('",l_bmfa005,"','YYYY-MM-DD hh24:mi:ss') ",                  
#                  "    AND bmcd007 = '",p_bmfb009,"'",
#                  "    AND bmcd008 = '",p_bmfb010,"'" 
#      PREPARE ins_bmfl_pre FROM l_sql
#      EXECUTE ins_bmfl_pre 
#
#   END IF
#
#   LET l_cnt = 0 
#   SELECT COUNT(*) INTO l_cnt
#     FROM bmfm_t
#    WHERE bmfment = g_enterprise
#      AND bmfmdocno = p_bmfadocno    
#      AND bmfm002 = p_bmfb002
#   IF l_cnt  = 0 THEN 
#      #變更方式=1.新增或2.修改
#      #INS bmfm_t ECN元件限定库存特征单头档
#      LET l_sql = " INSERT INTO bmfm_t(bmfment,bmfmsite,bmfmdocno,bmfm002,bmfm003,bmfm004) ",
#                  " SELECT DISTINCT '",g_enterprise,"','",g_site,"','",p_bmfadocno,"','",p_bmfb002,"',bmce009,bmce010 ",
#                  "   FROM bmce_t ",
#                  "  WHERE bmceent = '",g_enterprise,"' ",
#                  "    AND bmcesite = '",g_site,"' ",
#                  "    AND bmce001 = '",l_bmfa003,"'",
#                  "    AND bmce002 = '",l_bmfa004,"'",
#                  "    AND bmce003 = '",p_bmfb005,"'",                  
#                  "    AND bmce004 = '",p_bmfb008,"'",
#                  "    AND bmce005 <= to_date('",l_bmfa005,"','YYYY-MM-DD hh24:mi:ss') ",                  
#                  "    AND bmce007 = '",p_bmfb009,"'",
#                  "    AND bmce008 = '",p_bmfb010,"'" 
#      PREPARE ins_bmfm_pre FROM l_sql
#      EXECUTE ins_bmfm_pre 
#
#      #變更方式=1.新增或2.修改
#      #INS bmfn_t ECN元件限定库存特征单身档
#      LET l_sql = " INSERT INTO bmfn_t(bmfnent,bmfnsite,bmfndocno,bmfn002,bmfn003,bmfn004,bmfn005,bmfn006) ",
#                  " SELECT DISTINCT '",g_enterprise,"','",g_site,"','",p_bmfadocno,"','",p_bmfb002,"',bmcf009,bmcf010,bmcf011,bmcf012 ",
#                  "   FROM bmcf_t ",
#                  "  WHERE bmcfent = '",g_enterprise,"' ",
#                  "    AND bmcfsite = '",g_site,"' ",
#                  "    AND bmcf001 = '",l_bmfa003,"'",
#                  "    AND bmcf002 = '",l_bmfa004,"'",
#                  "    AND bmcf003 = '",p_bmfb005,"'",                  
#                  "    AND bmcf004 = '",p_bmfb008,"'",
#                  "    AND bmcf005 <= to_date('",l_bmfa005,"','YYYY-MM-DD hh24:mi:ss') ",                  
#                  "    AND bmcf007 = '",p_bmfb009,"'",
#                  "    AND bmcf008 = '",p_bmfb010,"'" 
#      PREPARE ins_bmfn_pre FROM l_sql
#      EXECUTE ins_bmfn_pre  
#   END IF      
#160308-00001#1 earl mod e
END FUNCTION

################################################################################
# Descriptions...: 删除当前项次对应的产品特征管理资料
# Memo...........:
# Usage..........: CALL abmt300_02_del_no_exists()
# Date & Author..: 2015/08/25 By xianghui
# Modify.........:
################################################################################
PRIVATE FUNCTION abmt300_02_del_no_exists()


   DELETE FROM bmfi_t 
    WHERE bmfient = g_enterprise
      AND bmfisite = g_site
      AND bmfidocno = g_bmfbdocno
      AND bmfi002 = g_bmfb002
      AND EXISTS(SELECT 1 FROM bmfb_t 
                  WHERE bmfbent = g_enterprise 
                    AND bmfbsite = g_site 
                    AND bmfbdocno = g_bmfbdocno
                    AND bmfb002 = g_bmfb002
                    AND bmfb005 <> g_bmfb005)
      
   DELETE FROM bmfj_t 
    WHERE bmfjent = g_enterprise
      AND bmfjsite = g_site
      AND bmfjdocno = g_bmfbdocno
      AND bmfj002 = g_bmfb002 
      AND EXISTS(SELECT 1 FROM bmfb_t 
                  WHERE bmfbent = g_enterprise 
                    AND bmfbsite = g_site 
                    AND bmfbdocno = g_bmfbdocno
                    AND bmfb002 = g_bmfb002
                    AND bmfb005 <> g_bmfb005)
                    
   DELETE FROM bmfk_t 
    WHERE bmfkent = g_enterprise
      AND bmfksite = g_site
      AND bmfkdocno = g_bmfbdocno
      AND bmfk002 = g_bmfb002
      AND EXISTS(SELECT 1 FROM bmfb_t 
                  WHERE bmfbent = g_enterprise 
                    AND bmfbsite = g_site 
                    AND bmfbdocno = g_bmfbdocno
                    AND bmfb002 = g_bmfb002
                    AND bmfb005 <> g_bmfb005)
                    
   DELETE FROM bmfl_t 
    WHERE bmflent = g_enterprise
      AND bmflsite = g_site
      AND bmfldocno = g_bmfbdocno
      AND bmfl002 = g_bmfb002
      AND EXISTS(SELECT 1 FROM bmfb_t 
                  WHERE bmfbent = g_enterprise 
                    AND bmfbsite = g_site 
                    AND bmfbdocno = g_bmfbdocno
                    AND bmfb002 = g_bmfb002
                    AND bmfb005 <> g_bmfb005)
                    
   DELETE FROM bmfm_t 
    WHERE bmfment = g_enterprise
      AND bmfmsite = g_site
      AND bmfmdocno = g_bmfbdocno
      AND bmfm002 = g_bmfb002
      AND EXISTS(SELECT 1 FROM bmfb_t 
                  WHERE bmfbent = g_enterprise 
                    AND bmfbsite = g_site 
                    AND bmfbdocno = g_bmfbdocno
                    AND bmfb002 = g_bmfb002
                    AND bmfb005 <> g_bmfb005)

   DELETE FROM bmfn_t 
    WHERE bmfnent = g_enterprise
      AND bmfnsite = g_site
      AND bmfndocno = g_bmfbdocno
      AND bmfn002 = g_bmfb002
      AND EXISTS(SELECT 1 FROM bmfb_t 
                  WHERE bmfbent = g_enterprise 
                    AND bmfbsite = g_site 
                    AND bmfbdocno = g_bmfbdocno
                    AND bmfb002 = g_bmfb002
                    AND bmfb005 <> g_bmfb005)      
END FUNCTION

 
{</section>}
 
