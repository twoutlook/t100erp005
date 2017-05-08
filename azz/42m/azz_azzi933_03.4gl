#該程式未解開Section, 採用最新樣板產出!
{<section id="azzi933_03.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2015-05-04 11:08:31), PR版次:0005(2017-02-07 11:32:11)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000042
#+ Filename...: azzi933_03
#+ Description: 插入圖片或超連結
#+ Creator....: 01101(2014-12-30 09:58:09)
#+ Modifier...: 01101 -SD/PR- 01101
 
{</section>}
 
{<section id="azzi933_03.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#+ Modifier...: 01101(2015-03-23 17:25:34)   No.FUN-different 有別於azzi933_02
#+ Creator....: No.160726-00017#4 2016/07/29 By frank0521 共用函式改呼叫library
#+ Modifier...: No.161201-00013#1 2016/12/01 By tsai_yen 插入圖片或超連結的複製標籤內容功能限使用於GDC。
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"
IMPORT util
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"
 
#end add-point
 
{</section>}
 
{<section id="azzi933_03.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
#單頭 type 宣告
 TYPE type_g_gzwr_d RECORD
      gzwr004         LIKE gzwr_t.gzwr004,     #檔案編號
      gzwr007         LIKE gzwr_t.gzwr007,     #副檔名
      imgfiles        STRING,
      gzwr008         LIKE gzwr_t.gzwr008      #說明
      END RECORD
 TYPE type_g_gzwr_m RECORD
   #gzwr001          LIKE gzwr_t.gzwr001,    #作業編號
   #gzwr001_desc     LIKE type_t.chr80,
   #gzwr002          LIKE gzwr_t.gzwr002,    #客製
   #gzwr003          LIKE gzwr_t.gzwr003,    #語言別
   gzwr004          LIKE gzwr_t.gzwr004,    #檔案編號
   gzwr006          LIKE gzwr_t.gzwr006,    #檔名
   gzwr007          LIKE gzwr_t.gzwr007,    #副檔名
   gzwr008          LIKE gzwr_t.gzwr008,    #說明
   gzwrstus         LIKE gzwr_t.gzwrstus,   #狀態碼
   gzwrownid        LIKE gzwr_t.gzwrownid,  #資料所有者
   gzwrownid_desc   LIKE type_t.chr80,
   gzwrowndp        LIKE gzwr_t.gzwrowndp,  #資料所屬部門
   gzwrowndp_desc   LIKE type_t.chr80,
   gzwrcrtid        LIKE gzwr_t.gzwrcrtid,  #資料建立者
   gzwrcrtid_desc   LIKE type_t.chr80,
   gzwrcrtdp        LIKE gzwr_t.gzwrcrtdp,  #資料建立部門
   gzwrcrtdp_desc   LIKE type_t.chr80,
   gzwrcrtdt        LIKE gzwr_t.gzwrcrtdt,  #資料創建日
   gzwrmodid        LIKE gzwr_t.gzwrmodid,  #資料修改者
   gzwrmodid_desc   LIKE type_t.chr80,
   gzwrmoddt        LIKE gzwr_t.gzwrmoddt,  #最近修改日
   imgfiles         STRING,
   #FUN-different START
   tagcode          STRING,                 #組成內容
   htmlcode         STRING,
   imgwidth         LIKE type_t.num5,       #圖片寬度
   imgheight        LIKE type_t.num5,       #圖片高度
   imgwidthunit     STRING,                 #圖片寬度單位
   imgheightunit    STRING                  #圖片高度單位
   #FUN-different END
   END RECORD

#模組變數(Module Variables)
DEFINE g_doctype    STRING               #文件類型:userguide作業操作說明,APP應用專題
DEFINE g_gzwr_m     type_g_gzwr_m        #單頭變數宣告
DEFINE g_gzwr_m_t   type_g_gzwr_m        #單頭舊值宣告(系統還原用)
DEFINE g_gzwr_m_o   type_g_gzwr_m        #單頭舊值宣告(其他用途)
DEFINE g_browser    DYNAMIC ARRAY OF type_g_gzwr_d #單身變數
DEFINE g_gzwr_a     DYNAMIC ARRAY OF type_g_gzwr_m #單身變數完整資料

DEFINE g_gzwr001_t LIKE gzwr_t.gzwr001
DEFINE g_gzwr002_t LIKE gzwr_t.gzwr002
DEFINE g_gzwr003_t LIKE gzwr_t.gzwr003
DEFINE g_gzwr004_t LIKE gzwr_t.gzwr004

#DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列
#      b_statepic     LIKE type_t.chr50,
#      b_gzwr001 LIKE gzwr_t.gzwr001,
#      b_gzwr002 LIKE gzwr_t.gzwr002,
#      b_gzwr003 LIKE gzwr_t.gzwr003,
#      b_gzwr004 LIKE gzwr_t.gzwr004
#      END RECORD

DEFINE g_wc                  STRING                        #儲存查詢條件
DEFINE g_wc_t                STRING                        #備份查詢條件
DEFINE g_wc_filter           STRING                        #儲存過濾查詢條件
DEFINE g_wc_filter_t         STRING                        #備份過濾查詢條件
DEFINE g_sql                 STRING                        #資料撈取用SQL(含reference)
DEFINE g_forupd_sql          STRING                        #資料鎖定用SQL
DEFINE g_cnt                 LIKE type_t.num10             #指標/統計用變數
DEFINE g_jump                LIKE type_t.num10             #查詢指定的筆數
DEFINE g_no_ask              LIKE type_t.num5              #是否開啟指定筆視窗
DEFINE g_rec_b               LIKE type_t.num10             #單身筆數
DEFINE l_ac                  LIKE type_t.num10             #目前處理的ARRAY CNT
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_pagestart           LIKE type_t.num10             #page起始筆數
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_state               STRING                        #確認前一個動作是否為新增/複製
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_error_show          LIKE type_t.num5              #是否顯示資料過多的錯誤訊息
DEFINE g_aw                  STRING                        #確定當下點擊的單身(modify_detail用)
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #cl_log_modified_record用(舊值)
DEFINE g_log2                STRING                        #cl_log_modified_record用(新值)

#快速搜尋用
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序模式

#Browser用
DEFINE g_current_idx         LIKE type_t.num10             #Browser 所在筆數(當下page)
DEFINE g_current_row         LIKE type_t.num10             #Browser 所在筆數(暫存用)
DEFINE g_current_cnt         LIKE type_t.num10             #Browser 總筆數(當下page)
DEFINE g_browser_idx         LIKE type_t.num10             #Browser 所在筆數(所有資料)
DEFINE g_browser_cnt         LIKE type_t.num10             #Browser 總筆數(所有資料)
DEFINE g_row_index           LIKE type_t.num10             #階層樹狀用指標
DEFINE g_add_browse          STRING                        #新增填充用WC

#共用變數cl_helps933, azzi933_02, azzi933_03, azzi553_02, azzi553_03     160726-00017#4
DEFINE g_separator          STRING   #separate path segments, ex."/"
DEFINE g_www_path           STRING   #$TOP/www完整路徑,ex./u1/t10dev/www
DEFINE g_dir_doc            STRING   #doc目錄,ex."doc/erp"
#end add-point
 
{</section>}
 
{<section id="azzi933_03.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_p_action           STRING                #"ins_img","ins_hyperlink"
DEFINE g_p_gzwr001          LIKE gzwr_t.gzwr001   #作業編號
DEFINE g_p_gzwr002          LIKE gzwr_t.gzwr002   #客製
DEFINE g_p_gzwr003          LIKE gzwr_t.gzwr003   #語言別
DEFINE g_gzwr001_desc       STRING
DEFINE g_hyperlink_txt      STRING                #超連結文字或圖片
#end add-point
 
{</section>}
 
{<section id="azzi933_03.other_dialog" >}

 
{</section>}
 
{<section id="azzi933_03.other_function" readonly="Y" >}

PUBLIC FUNCTION azzi933_03(--)
   #add-point:main段變數傳入
   p_action,p_gzwr001,p_gzwr002,p_gzwr003
   #end add-point
   )
   DEFINE p_action           STRING
   DEFINE p_gzwr001          LIKE gzwr_t.gzwr001   #作業編號
   DEFINE p_gzwr002          LIKE gzwr_t.gzwr002   #客製
   DEFINE p_gzwr003          LIKE gzwr_t.gzwr003   #語言別     

   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log

   LET g_doctype = "userguide"   #作業操作說明
   LET g_p_action = p_action
   LET g_p_gzwr001 = p_gzwr001   #作業編號
   LET g_p_gzwr002 = p_gzwr002   #客製
   LET g_p_gzwr003 = p_gzwr003   #語言別

   IF cl_null(g_p_gzwr001) OR cl_null(g_p_gzwr002) OR cl_null(g_p_gzwr003) THEN
      RETURN
   END IF

   LET g_forupd_sql = "SELECT gzwr001,'',gzwr002,gzwr003,gzwr004,gzwr006,gzwr007,gzwr008,gzwrstus,gzwrownid,",
                      "'',gzwrowndp,'',gzwrcrtid,'',gzwrcrtdp,'',gzwrcrtdt,gzwrmodid,'',gzwrmoddt FROM gzwr_t",
                      " WHERE gzwr001=? AND gzwr002=? AND gzwr003=? AND gzwr004=? FOR UPDATE"
   #add-point:SQL_define

   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)   #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzi933_03_cl CURSOR FROM g_forupd_sql     # LOCK CURSOR

   #畫面開啟 (identifier)
   OPEN WINDOW w_azzi933_03 WITH FORM cl_ap_formpath("azz","azzi933_03")
                            ATTRIBUTE(STYLE="layoutwin")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()

   #程式初始化
   CALL azzi933_03_init()

   #進入選單 Menu (="N")
   CALL azzi933_03_ui_dialog()

   #畫面關閉
   CLOSE WINDOW w_azzi933_03

   CLOSE azzi933_03_cl

   #add-point:離開前
   LET INT_FLAG = FALSE   #避免影響主程式
   RETURN g_action_choice,g_gzwr_m.tagcode   #FUN-different
   #end add-point
END FUNCTION

PRIVATE FUNCTION azzi933_03_init()
   LET g_error_show  = 1
   LET l_ac = 1

   #定義combobox狀態
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()

   CALL cl_set_combo_scc_part('gzwrstus','17','N,Y')
   CALL cl_set_combo_lang("gzwr003")

   #FUN-different START
   CASE g_p_action
      WHEN "ins_img"
         CALL cl_set_comp_visible("lbl_hyperlink_txt,l_hyperlink_txt",FALSE)
      WHEN "ins_hyperlink"
         CALL cl_set_comp_visible("lbl_imgwidth,imgwidth,imgwidthunit,lbl_imgheight,imgheight,imgheightunit",FALSE)
   END CASE
   
   LET g_hyperlink_txt = ""
   #FUN-different END
   
   CALL cl_helps933_path_init() RETURNING g_separator,g_www_path,g_dir_doc
   CALL azzi933_03_default_search()
END FUNCTION

PRIVATE FUNCTION azzi933_03_ui_dialog()
   DEFINE li_exit   LIKE type_t.num10       #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10       #指標變數
   DEFINE ls_wc     STRING                  #wc用
   DEFINE la_param  RECORD                  #程式串查用變數
             prog   STRING,                 #串查程式名稱
             param  DYNAMIC ARRAY OF STRING #傳遞變數
                    END RECORD
   DEFINE ls_js     STRING                  #轉換後的json字串
   DEFINE l_chk     BOOLEAN

   LET li_exit = FALSE
   LET g_current_row = 0
   LET g_current_idx = 0


   #action default動作
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL azzi933_03_insert()
         END IF

      OTHERWISE
   END CASE

   WHILE li_exit = FALSE
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()
         CALL g_gzwr_a.clear()
         INITIALIZE g_gzwr_m.* TO NULL
         LET g_gzwr_m.imgwidthunit = "px"   #FUN-different
         LET g_gzwr_m.imgheightunit = "px"  #FUN-different
         LET g_wc  = ' 1=1'
         LET g_action_choice = ""
         CALL azzi933_03_init()
      END IF

      #確保g_current_idx位於正常區間內
      #小於,等於0則指到第1筆
      IF g_current_idx <= 0 THEN
         LET g_current_idx = 1
      END IF


         DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)


            #左側瀏覽頁簽
            DISPLAY ARRAY g_browser TO s_detail1.* ATTRIBUTE(COUNT=g_rec_b)

               BEFORE ROW
                  #回歸舊筆數位置 (回到當時異動的筆數)
                  LET g_current_idx = DIALOG.getCurrentRow("s_detail1")
                  IF g_current_idx = 0 THEN
                     LET g_current_idx = 1
                  END IF
                  LET g_current_row = g_current_idx  #目前指標
                  LET g_current_sw = TRUE
                  CALL cl_show_fld_cont()

                  #當每次點任一筆資料都會需要用到
                  CALL azzi933_03_fetch("")

#               ON ACTION qbefield_user   #欄位隱藏設定   #FUN-different mark
#                  LET g_action_choice="qbefield_user"
#                  CALL cl_ui_qbefield_user()

               ON ACTION btn_showfileimg   #開啟檔案
                  LET g_action_choice="btn_showfileimg"
                  IF cl_auth_chk_act("btn_showfileimg") THEN
                     IF  NOT cl_null(g_p_gzwr001) AND NOT cl_null(g_p_gzwr002) AND NOT cl_null(g_p_gzwr003) AND NOT cl_null(g_gzwr_m.gzwr004) THEN
                        CALL cl_helps932_open_url("www",g_gzwr_m.gzwr006) RETURNING l_chk
                     END IF
                  END IF
            END DISPLAY

            #FUN-different START
            INPUT g_gzwr_m.imgwidth,g_gzwr_m.imgwidthunit,g_gzwr_m.imgheight,g_gzwr_m.imgheightunit,g_hyperlink_txt FROM formonly.imgwidth,formonly.imgwidthunit,formonly.imgheight,formonly.imgheightunit,formonly.l_hyperlink_txt
               ATTRIBUTE(WITHOUT DEFAULTS)
               
               AFTER FIELD imgwidth
                  IF g_gzwr_m.imgwidth < 0 THEN
                     LET g_gzwr_m.imgwidth = NULL
                  END IF
               AFTER FIELD imgheight
                  IF g_gzwr_m.imgheight < 0 THEN
                     LET g_gzwr_m.imgheight = NULL
                  END IF
                  
               ON CHANGE imgwidth
                  CALL azzi933_03_tagcode(g_p_gzwr001,g_p_gzwr002,g_p_gzwr003,g_gzwr_m.gzwr004,g_gzwr_m.gzwr007)
               ON CHANGE imgwidthunit
                  CALL azzi933_03_tagcode(g_p_gzwr001,g_p_gzwr002,g_p_gzwr003,g_gzwr_m.gzwr004,g_gzwr_m.gzwr007)
               ON CHANGE imgheight
                  CALL azzi933_03_tagcode(g_p_gzwr001,g_p_gzwr002,g_p_gzwr003,g_gzwr_m.gzwr004,g_gzwr_m.gzwr007)
               ON CHANGE imgheightunit
                  CALL azzi933_03_tagcode(g_p_gzwr001,g_p_gzwr002,g_p_gzwr003,g_gzwr_m.gzwr004,g_gzwr_m.gzwr007)
               ON CHANGE l_hyperlink_txt
                  CALL azzi933_03_tagcode(g_p_gzwr001,g_p_gzwr002,g_p_gzwr003,g_gzwr_m.gzwr004,g_gzwr_m.gzwr007)
            END INPUT
            #FUN-different END

            BEFORE DIALOG
               #先填充browser資料
               CALL azzi933_03_browser_fill(g_wc,"")

               #當每次點任一筆資料都會需要用到
               IF g_browser_cnt > 0 THEN
                  CALL azzi933_03_fetch("")
               END IF
               
               #複製標籤內容的功能限使用於GDC
               IF FGL_GETENV("GUIMODE") <> "GDC" THEN   #161201-00013#1
                  CALL gfrm_curr.setElementHidden("act_cbset",TRUE)
               END IF

            #FUN-different START
            ON ACTION act_ok      #插入本文最後
               LET g_action_choice="act_ok"
               LET li_exit = TRUE
               IF cl_auth_chk_act("act_ok") THEN
                  CALL azzi933_03_tagcode(g_p_gzwr001,g_p_gzwr002,g_p_gzwr003,g_gzwr_m.gzwr004,g_gzwr_m.gzwr007)
                  EXIT DIALOG
               END IF
   
            ON ACTION act_cbset   #複製標籤內容
               LET g_action_choice="act_cbset"
               LET li_exit = TRUE
               IF cl_auth_chk_act("act_cbset") THEN
                  CALL azzi933_03_tagcode(g_p_gzwr001,g_p_gzwr002,g_p_gzwr003,g_gzwr_m.gzwr004,g_gzwr_m.gzwr007)
                  TRY
                     CALL ui.Interface.frontCall( "standard", "cbset", [g_gzwr_m.tagcode], [l_chk] )   #複製標籤內容的功能限使用於GDC
                  CATCH
                  END TRY
                  LET g_gzwr_m.tagcode = ""   #使用者自己貼上,所以要清空
                  EXIT DIALOG
               END IF
            #FUN-different END

#            #狀態碼切換      #FUN-different mark
#            ON ACTION statechange
#               CALL azzi933_03_statechange()
#               LET g_action_choice="statechange"
#               #根據資料狀態切換action狀態
#               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
#               CALL azzi933_03_set_act_visible()
#               CALL azzi933_03_set_act_no_visible()
#               IF NOT (g_p_gzwr001 IS NULL
#                 OR g_p_gzwr002 IS NULL
#                 OR g_p_gzwr003 IS NULL
#                 OR g_gzwr_m.gzwr004 IS NULL
#
#                 ) THEN
#                  #組合條件
#                  LET g_add_browse = " ",
#                                     " gzwr001 = '", g_p_gzwr001, "' "
#                                     ," AND gzwr002 = '", g_p_gzwr002, "' "
#                                     ," AND gzwr003 = '", g_p_gzwr003, "' "
#                                     ," AND gzwr004 = '", g_gzwr_m.gzwr004, "' "
#
#                  #填到對應位置
#                  CALL azzi933_03_browser_fill(g_wc,"")
#               END IF
#
#            #第一筆資料
#            ON ACTION first
#               CALL azzi933_03_fetch("F")
#               LET g_current_row = g_current_idx
#
#            #下一筆資料
#            ON ACTION next
#               CALL azzi933_03_fetch("N")
#               LET g_current_row = g_current_idx
#
#            #指定筆資料
#            ON ACTION jump
#               CALL azzi933_03_fetch("/")
#               LET g_current_row = g_current_idx
#
#            #上一筆資料
#            ON ACTION previous
#               CALL azzi933_03_fetch("P")
#               LET g_current_row = g_current_idx
#
#            #最後筆資料
#            ON ACTION last
#               CALL azzi933_03_fetch("L")
#               LET g_current_row = g_current_idx
#
            #離開程式
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT DIALOG

            #離開程式
            ON ACTION close
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT DIALOG
#
#            #主頁摺疊
#            ON ACTION mainhidden
#               IF g_main_hidden THEN
#                  CALL gfrm_curr.setElementHidden("mainlayout",0)
#                  CALL gfrm_curr.setElementHidden("worksheet",1)
#                  LET g_main_hidden = 0
#               ELSE
#                  CALL gfrm_curr.setElementHidden("mainlayout",1)
#                  CALL gfrm_curr.setElementHidden("worksheet",0)
#                  LET g_main_hidden = 1
#               END IF
#
#            #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
#            ON ACTION controls
#               IF g_header_hidden THEN
#                  CALL gfrm_curr.setElementHidden("vb_master",0)
#                  CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
#                  LET g_header_hidden = 0     #visible
#               ELSE
#                  CALL gfrm_curr.setElementHidden("vb_master",1)
#                  CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
#                  LET g_header_hidden = 1     #hidden
#               END IF
#
#
#            #查詢方案用
#            ON ACTION queryplansel
#               CALL cl_dlg_qryplan_select() RETURNING ls_wc
#               #不是空條件才寫入g_wc跟重新找資料
#               IF NOT cl_null(ls_wc) THEN
#                  LET g_wc = ls_wc
#                  CALL azzi933_03_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
#                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
#               END IF
#
#            #查詢方案用
#            ON ACTION qbe_select
#               CALL cl_qbe_list("m") RETURNING ls_wc
#               IF NOT cl_null(ls_wc) THEN
#                  LET g_wc = ls_wc
#                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
#                  CALL azzi933_03_browser_fill(g_wc,"F")
#                  IF g_browser_cnt = 0 THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.extend = ""
#                     LET g_errparam.code   = "-100"
#                     LET g_errparam.popup  = TRUE
#                     CALL cl_err()
#                     CLEAR FORM
#                  ELSE
#                     CALL azzi933_03_fetch("F")
#                  END IF
#               END IF
#               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
#               CALL cl_notice()
#
#
#         #應用 a43 樣板自動產生(Version:2)
#         ON ACTION exporttoexcel
#            LET g_action_choice="exporttoexcel"
#            IF cl_auth_chk_act("exporttoexcel") THEN
#
#               #add-point:ON ACTION exporttoexcel
#
#               #END add-point
#
#            END IF
#
#         #應用 a43 樣板自動產生(Version:2)
#         ON ACTION modify
#            LET g_action_choice="modify"
#            IF cl_auth_chk_act("modify") THEN
#               LET g_aw = ''
#               CALL azzi933_03_modify()
#            END IF
#
#         #應用 a43 樣板自動產生(Version:2)
#         ON ACTION delete
#            LET g_action_choice="delete"
#            IF cl_auth_chk_act("delete") THEN
#               CALL azzi933_03_delete()
#            END IF
#
#         #應用 a43 樣板自動產生(Version:2)
#         ON ACTION insert
#            LET g_action_choice="insert"
#            IF cl_auth_chk_act("insert") THEN
#               CALL azzi933_03_insert()
#            END IF
#
#         #應用 a43 樣板自動產生(Version:2)
#         ON ACTION output
#            LET g_action_choice="output"
#            IF cl_auth_chk_act("output") THEN
#            END IF
#
#         #應用 a43 樣板自動產生(Version:2)
#         ON ACTION reproduce
#            LET g_action_choice="reproduce"
#            IF cl_auth_chk_act("reproduce") THEN
#               CALL azzi933_03_reproduce()
#            END IF

         #應用 a43 樣板自動產生(Version:2)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL azzi933_03_query()
            END IF

          #應用 a46 樣板自動產生(Version:2)
#         #新增相關文件      #FUN-different mark
#         ON ACTION related_document
#            CALL azzi933_03_set_pk_array()
#            IF cl_auth_chk_act("related_document") THEN
#               CALL cl_doc()
#            END IF
#
#         ON ACTION agendum
#            CALL azzi933_03_set_pk_array()
#            CALL cl_user_overview()
#            CALL cl_user_overview_set_follow_pic()
#
#         ON ACTION followup
#            CALL azzi933_03_set_pk_array()
#            CALL cl_user_overview_follow('')
#
#            #主選單用ACTION
#            &include "main_menu_exit_dialog.4gl"
#            &include "relating_action.4gl"
#            #交談指令共用ACTION
#            &include "common_action.4gl"
         END DIALOG
   END WHILE
   
   #FUN-different START
   IF li_exit AND g_action_choice="exit" THEN
      LET g_gzwr_m.tagcode = ""
   END IF
   #FUN-different END
END FUNCTION

PRIVATE FUNCTION azzi933_03_browser_fill(p_wc,ps_page_action)
   DEFINE p_wc              STRING
   DEFINE ls_wc             STRING
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sql_rank        STRING

   LET l_searchcol = "gzwr001,gzwr002,gzwr003,gzwr004"

   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 "
   END IF

   LET g_sql = " SELECT COUNT(gzwr001) FROM gzwr_t ",
               " WHERE  ",
                    p_wc CLIPPED, cl_sql_add_filter("gzwr_t"),
                    " AND gzwr001=? AND gzwr002=? AND gzwr003=?"

   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre USING g_p_gzwr001,g_p_gzwr002,g_p_gzwr003 INTO g_browser_cnt
   FREE header_cnt_pre

   #若超過最大顯示筆數
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = g_browser_cnt
         LET g_errparam.code   = 9035
         LET g_errparam.popup  = TRUE
         CALL cl_err()
      END IF
   END IF


   IF ps_page_action = "F" OR
      ps_page_action = "P"  OR
      ps_page_action = "N"  OR
      ps_page_action = "L"  THEN
      LET g_page_action = ps_page_action
   END IF

   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM
      INITIALIZE g_gzwr_m.* TO NULL
      LET g_gzwr_m.imgwidthunit = "px"   #FUN-different
      LET g_gzwr_m.imgheightunit = "px"  #FUN-different
      CALL g_gzwr_a.clear()
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF

   LET g_sql = "SELECT t0.gzwr004,t0.gzwr006,t0.gzwr007,t0.gzwr008,",
               " t0.gzwrstus,",
               " t0.gzwrownid,t2.ooag011,t0.gzwrowndp,t3.ooefl003,",
               " t0.gzwrcrtid,t4.ooag011,t0.gzwrcrtdp,t5.ooefl003,t0.gzwrcrtdt,",
               " t0.gzwrmodid,t6.ooag011,t0.gzwrmoddt",
               " FROM gzwr_t t0",
               " LEFT JOIN gzzal_t t1 ON t1.gzzal001=t0.gzwr001 AND t1.gzzal002='"|| g_lang CLIPPED ||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent='"|| g_enterprise CLIPPED ||"' AND t2.ooag001=t0.gzwrownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent='"|| g_enterprise CLIPPED ||"' AND t3.ooefl001=t0.gzwrowndp AND t3.ooefl002='"|| g_dlang CLIPPED ||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent='"|| g_enterprise CLIPPED ||"' AND t4.ooag001=t0.gzwrcrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent='"|| g_enterprise CLIPPED ||"' AND t5.ooefl001=t0.gzwrcrtdp AND t5.ooefl002='"|| g_dlang CLIPPED ||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent='"|| g_enterprise CLIPPED ||"' AND t6.ooag001=t0.gzwrmodid  ",
               " WHERE ", ls_wc CLIPPED, cl_sql_add_filter("gzwr_t"),
                      " AND gzwr001=? AND gzwr002=? AND gzwr003=?"

   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料

   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre

   #CALL g_gzwr_a.clear()
   #LET g_cnt = 1
   FOREACH browse_cur USING g_p_gzwr001,g_p_gzwr002,g_p_gzwr003
      INTO g_gzwr_a[g_cnt].gzwr004,g_gzwr_a[g_cnt].gzwr006,g_gzwr_a[g_cnt].gzwr007,g_gzwr_a[g_cnt].gzwr008,
           g_gzwr_a[g_cnt].gzwrstus,
           g_gzwr_a[g_cnt].gzwrownid,g_gzwr_a[g_cnt].gzwrownid_desc,g_gzwr_a[g_cnt].gzwrowndp,g_gzwr_a[g_cnt].gzwrowndp_desc,
           g_gzwr_a[g_cnt].gzwrcrtid,g_gzwr_a[g_cnt].gzwrcrtid_desc,g_gzwr_a[g_cnt].gzwrcrtdp,g_gzwr_a[g_cnt].gzwrcrtdp_desc,g_gzwr_a[g_cnt].gzwrcrtdt,
           g_gzwr_a[g_cnt].gzwrmodid,g_gzwr_a[g_cnt].gzwrmodid_desc,g_gzwr_a[g_cnt].gzwrmoddt

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "foreach:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      CALL cl_helps933_gzwr006_path(g_www_path,NULL,g_gzwr_a[g_cnt].gzwr006) RETURNING g_gzwr_a[g_cnt].imgfiles
      LET g_browser[g_cnt].gzwr004  = g_gzwr_a[g_cnt].gzwr004   #檔案編號
      LET g_browser[g_cnt].gzwr007  = g_gzwr_a[g_cnt].gzwr007   #副檔名
      LET g_browser[g_cnt].imgfiles = g_gzwr_a[g_cnt].imgfiles
      LET g_browser[g_cnt].gzwr008  = g_gzwr_a[g_cnt].gzwr008   #說明

      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH

   #清空g_add_browse, 並指定指標位置
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = ""
      CALL g_curr_diag.setCurrentRow("s_detail1",g_current_idx)
   END IF

   IF cl_null(g_gzwr_a[g_cnt].gzwr004) THEN
      CALL g_gzwr_a.deleteElement(g_cnt)
   END IF

   LET g_header_cnt = g_gzwr_a.getLength()
   LET g_current_cnt = g_gzwr_a.getLength()
   LET g_rec_b = g_gzwr_a.getLength()
   LET g_cnt = 0
   DISPLAY g_browser_cnt TO FORMONLY.b_count
   DISPLAY g_browser_cnt TO FORMONLY.h_count


   FREE browse_pre

   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("statechange,modify,delete,reproduce,mainhidden", TRUE)
   END IF
END FUNCTION

PRIVATE FUNCTION azzi933_03_construct()
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING
   DEFINE ls_wc          STRING

   #清空畫面&資料初始化
   CLEAR FORM
   INITIALIZE g_gzwr_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1

   LET g_qryparam.state = "c"

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #螢幕上取條件
      #CONSTRUCT BY NAME g_wc ON gzwr004,gzwr007,gzwr008,gzwrstus,gzwrownid,          #FUN-different mark
      #    gzwrowndp,gzwrcrtid,gzwrcrtdp,gzwrcrtdt,gzwrmodid,gzwrmoddt                #FUN-different mark
      CONSTRUCT g_wc ON gzwr004,gzwr007,gzwr008                                       #FUN-different 在單身查詢
         FROM s_detail1[1].gzwr004_2,s_detail1[1].gzwr007_2,s_detail1[1].gzwr008_2    #FUN-different
      
         BEFORE CONSTRUCT
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:2)
         #共用欄位查詢處理
         ##----<<gzwrcrtdt>>----
         AFTER FIELD gzwrcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)

         #----<<gzwrmoddt>>----
         AFTER FIELD gzwrmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)

         #一般欄位
                  #Ctrlp:construct.c.gzwr001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzwr001
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_gzzz001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzwr001  #顯示到畫面上
            NEXT FIELD gzwr001                     #返回原欄位

         #Ctrlp:construct.c.gzwrownid
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzwrownid
            #add-point:ON ACTION controlp INFIELD gzwrownid
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzwrownid  #顯示到畫面上
            NEXT FIELD gzwrownid                     #返回原欄位

         #Ctrlp:construct.c.gzwrowndp
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzwrowndp
            #add-point:ON ACTION controlp INFIELD gzwrowndp
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzwrowndp  #顯示到畫面上
            NEXT FIELD gzwrowndp                     #返回原欄位

         #Ctrlp:construct.c.gzwrcrtid
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzwrcrtid
            #add-point:ON ACTION controlp INFIELD gzwrcrtid
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzwrcrtid  #顯示到畫面上
            NEXT FIELD gzwrcrtid                     #返回原欄位


         #Ctrlp:construct.c.gzwrcrtdp
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzwrcrtdp
            #add-point:ON ACTION controlp INFIELD gzwrcrtdp
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzwrcrtdp  #顯示到畫面上
            NEXT FIELD gzwrcrtdp                     #返回原欄位

         #Ctrlp:construct.c.gzwrmodid
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzwrmodid
            #add-point:ON ACTION controlp INFIELD gzwrmodid
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzwrmodid  #顯示到畫面上
            NEXT FIELD gzwrmodid                     #返回原欄位

      END CONSTRUCT


      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog

         #end add-point

      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG

      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc

      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG
END FUNCTION

PRIVATE FUNCTION azzi933_03_query()
   DEFINE ls_wc STRING

   LET INT_FLAG = 0
   LET ls_wc = g_wc

   #切換畫面

   CALL g_browser.clear()
   CALL g_gzwr_a.clear()
   INITIALIZE g_gzwr_m.* TO NULL

   #browser panel折疊
   IF g_worksheet_hidden THEN
      CALL gfrm_curr.setElementHidden("worksheet_vbox",0)
      CALL gfrm_curr.setElementImage("worksheethidden","worksheethidden-24.png")
      LET g_worksheet_hidden = 0
   END IF

   #單頭折疊
   IF g_header_hidden THEN
      CALL gfrm_curr.setElementHidden("vb_master",0)
      CALL gfrm_curr.setElementImage("controls","headerhidden-24")
      LET g_header_hidden = 0
   END IF

   #INITIALIZE g_gzwr_m.* TO NULL
   ERROR ""

   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL azzi933_03_construct()

   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL azzi933_03_browser_fill(g_wc,"F")
      CALL azzi933_03_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF

   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL azzi933_03_browser_fill(g_wc,"F")   # 移到第一頁

   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||")")

   #備份搜尋條件
   LET ls_wc = g_wc

   IF g_browser.getLength() = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "-100"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   ELSE
      CALL azzi933_03_fetch("F")
   END IF

   LET g_wc_filter = ""
END FUNCTION

PRIVATE FUNCTION azzi933_03_fetch(p_flag)
   DEFINE p_flag       LIKE type_t.chr1
   DEFINE ls_msg     STRING

   #根據傳入的條件決定抓取的資料
   CASE p_flag
      WHEN "F"
         LET g_current_idx = 1
      WHEN "P"
         IF g_current_idx > 1 THEN
            LET g_current_idx = g_current_idx - 1
         END IF
      WHEN "N"
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF
      WHEN "L"
         #LET g_current_idx = g_header_cnt
         LET g_current_idx = g_browser.getLength()
      WHEN "/"
         #詢問要指定的筆數
         IF (NOT g_no_ask) THEN
            CALL cl_getmsg("fetch", g_lang) RETURNING ls_msg
            LET INT_FLAG = 0

            PROMPT ls_msg CLIPPED,": " FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl"
            END PROMPT

            IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE
            END IF
         END IF
         IF g_jump > 0 THEN
            LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE
   END CASE

   LET g_browser_cnt = g_browser.getLength()

   #筆數顯示
   LET g_browser_idx = g_current_idx
   IF g_browser_cnt > 0 THEN
      DISPLAY g_browser_idx TO FORMONLY.b_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.b_count #總筆數
      DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
   ELSE
      DISPLAY '' TO FORMONLY.b_index #當下筆數
      DISPLAY '' TO FORMONLY.b_count #總筆數
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
   END IF

   CALL azzi933_03_browser_fill(g_wc,p_flag)

   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF

   # 設定browse索引
   CALL cl_navigator_setting(g_browser_idx, g_browser_cnt)

   #代表沒有資料, 無需做後續資料撈取之動作
   IF g_current_idx = 0 THEN
      RETURN
   END IF

   #根據選定的筆數給予key欄位值
   LET g_gzwr_m.gzwr004 = g_browser[g_current_idx].gzwr004

   #讀取單頭所有欄位資料
   CALL azzi933_03_master_referesh(g_gzwr_m.gzwr004)

   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL azzi933_03_set_act_visible()
   CALL azzi933_03_set_act_no_visible()

   #保存單頭舊值
   LET g_gzwr_m_t.* = g_gzwr_m.*
   LET g_gzwr_m_o.* = g_gzwr_m.*

   LET g_data_owner = g_gzwr_m.gzwrownid
   LET g_data_dept  = g_gzwr_m.gzwrowndp

   #重新顯示
   CALL azzi933_03_show()
END FUNCTION

PRIVATE FUNCTION azzi933_03_insert()
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_gzwr_m.* LIKE gzwr_t.*             #DEFAULT 設定
   LET g_gzwr001_t = NULL
   LET g_gzwr002_t = NULL
   LET g_gzwr003_t = NULL
   LET g_gzwr004_t = NULL

   CALL s_transaction_begin()

   WHILE TRUE

      #公用欄位給值
      #應用 a14 樣板自動產生(Version:4)
      #公用欄位新增給值
      LET g_gzwr_m.gzwrownid = g_user
      LET g_gzwr_m.gzwrowndp = g_dept
      LET g_gzwr_m.gzwrcrtid = g_user
      LET g_gzwr_m.gzwrcrtdp = g_dept
      LET g_gzwr_m.gzwrcrtdt = cl_get_current()
      LET g_gzwr_m.gzwrmodid = g_user
      LET g_gzwr_m.gzwrmoddt = cl_get_current()
      LET g_gzwr_m.gzwrstus = 'Y'

      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:2)
	  #根據當下狀態碼顯示圖片
      CASE g_gzwr_m.gzwrstus
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")

      END CASE

      #資料輸入
      CALL azzi933_03_input("a")

      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ""
         LET g_errparam.code   = 9001
         LET g_errparam.popup  = FALSE
         CALL cl_err()
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_gzwr_m.* TO NULL
         CALL azzi933_03_show()
         RETURN
      END IF

      LET g_rec_b = 0
      EXIT WHILE
   END WHILE

   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL azzi933_03_set_act_visible()
   CALL azzi933_03_set_act_no_visible()

   #將新增的資料併入搜尋條件中
   LET g_state = "insert"

   LET g_gzwr001_t = g_p_gzwr001
   LET g_gzwr002_t = g_p_gzwr002
   LET g_gzwr003_t = g_p_gzwr003
   LET g_gzwr004_t = g_gzwr_m.gzwr004


   #組合新增資料的條件
   LET g_add_browse = " ",
                      " gzwr001 = '", g_p_gzwr001, "' "
                      ," AND gzwr002 = '", g_p_gzwr002, "' "
                      ," AND gzwr003 = '", g_p_gzwr003, "' "
                      ," AND gzwr004 = '", g_gzwr_m.gzwr004, "' "

   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL azzi933_03_browser_fill("","")

   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)

   #撈取異動後的資料(主要是帶出reference)
   CALL azzi933_03_master_referesh(g_gzwr_m.gzwr004)

   #將資料顯示到畫面上
   DISPLAY g_p_gzwr001,g_gzwr001_desc,g_p_gzwr002,g_p_gzwr003,g_gzwr_m.gzwr004,
       g_gzwr_m.gzwr006,g_gzwr_m.gzwr007,g_gzwr_m.gzwr008,g_gzwr_m.gzwrstus,
       g_gzwr_m.imgfiles,
       g_gzwr_m.gzwrownid,g_gzwr_m.gzwrownid_desc,g_gzwr_m.gzwrowndp,g_gzwr_m.gzwrowndp_desc,
       g_gzwr_m.gzwrcrtid,g_gzwr_m.gzwrcrtid_desc,g_gzwr_m.gzwrcrtdp,g_gzwr_m.gzwrcrtdp_desc,g_gzwr_m.gzwrcrtdt,
       g_gzwr_m.gzwrmodid,g_gzwr_m.gzwrmodid_desc,g_gzwr_m.gzwrmoddt
    TO gzwr001,formonly.gzwr001_desc,gzwr002,gzwr003,gzwr004,
       gzwr006,gzwr007,gzwr008,gzwrstus,
       formonly.l_imgfile,
       gzwrownid,formonly.gzwrownid_desc,gzwrowndp,formonly.gzwrowndp_desc,
       gzwrcrtid,formonly.gzwrcrtid_desc,gzwrcrtdp,formonly.gzwrcrtdp_desc,gzwrcrtdt,
       gzwrmodid,formonly.gzwrmodid_desc,gzwrmoddtddt
END FUNCTION

PRIVATE FUNCTION azzi933_03_modify()
   #先確定key值無遺漏
   IF g_p_gzwr001 IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "std-00003"
      LET g_errparam.popup  = FALSE
      CALL cl_err()
      RETURN
   END IF

   ERROR ""

   #備份key值
   LET g_gzwr001_t = g_p_gzwr001
   LET g_gzwr002_t = g_p_gzwr002
   LET g_gzwr003_t = g_p_gzwr003
   LET g_gzwr004_t = g_gzwr_m.gzwr004

   CALL s_transaction_begin()

   #先lock資料
   OPEN azzi933_03_cl USING g_p_gzwr001,g_p_gzwr002,g_p_gzwr003,g_gzwr_m.gzwr004
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "OPEN azzi933_03_cl:"
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      CLOSE azzi933_03_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #顯示最新的資料
   CALL azzi933_03_master_referesh(g_gzwr_m.gzwr004)

   #顯示資料
   CALL azzi933_03_show()

   WHILE TRUE
      LET g_gzwr_m.gzwr004 = g_gzwr004_t


      #寫入修改者/修改日期資訊
      LET g_gzwr_m.gzwrmodid = g_user
      LET g_gzwr_m.gzwrmoddt = cl_get_current()
      LET g_gzwr_m.gzwrmodid_desc = cl_get_username(g_gzwr_m.gzwrmodid)

      #資料輸入
      CALL azzi933_03_input("u")

      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_gzwr_m.* = g_gzwr_m_t.*
         CALL azzi933_03_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ""
         LET g_errparam.code   = 9001
         LET g_errparam.popup  = FALSE
         CALL cl_err()
         EXIT WHILE
      END IF

      #若有modid跟moddt則進行update
      UPDATE gzwr_t SET (gzwrmodid,gzwrmoddt) = (g_gzwr_m.gzwrmodid,g_gzwr_m.gzwrmoddt)
       WHERE  gzwr001 = g_gzwr001_t
         AND gzwr002 = g_gzwr002_t
         AND gzwr003 = g_gzwr003_t
         AND gzwr004 = g_gzwr004_t


      EXIT WHILE

   END WHILE

   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL azzi933_03_set_act_visible()
   CALL azzi933_03_set_act_no_visible()

   #組合新增資料的條件
   LET g_add_browse = " ",
                      " gzwr001 = '", g_p_gzwr001, "' "
                      ," AND gzwr002 = '", g_p_gzwr002, "' "
                      ," AND gzwr003 = '", g_p_gzwr003, "' "
                      ," AND gzwr004 = '", g_gzwr_m.gzwr004, "' "

   #填到對應位置
   CALL azzi933_03_browser_fill(g_wc,"")

   CLOSE azzi933_03_cl
   CALL s_transaction_end('Y','0')

   #流程通知預埋點-U(暫時無用)
   #CALL cl_flow_notify(g_p_gzwr001,"U")

   LET g_worksheet_hidden = 0
END FUNCTION

PRIVATE FUNCTION azzi933_03_input(p_cmd)
   DEFINE p_cmd           LIKE type_t.chr1
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT
   DEFINE l_n             LIKE type_t.num10       #檢查重複用
   DEFINE l_cnt           LIKE type_t.num10       #檢查重複用
   DEFINE l_lock_sw       LIKE type_t.chr1        #單身鎖住否
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_i             LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num10
   DEFINE ls_return       STRING
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING

   DEFINE l_colname          STRING
   DEFINE l_comment          STRING
   DEFINE ls_upload          STRING
   DEFINE l_chk              BOOLEAN
   DEFINE l_dest             STRING
   DEFINE l_gzwr007_t        LIKE gzwr_t.gzwr007    #舊副檔名
   DEFINE l_nametag          STRING                 #檔名標籤
   DEFINE l_sql              STRING
   DEFINE l_gzwp RECORD                             #作業操作說明
            gzwp003          LIKE gzwp_t.gzwp003,   #類別
            gzwp007          LIKE gzwp_t.gzwp007,   #網頁內容
            gzwp008          LIKE gzwp_t.gzwp008    #編輯內容
            END RECORD
   DEFINE l_gzwq RECORD                             #作業操作說明細項
            gzwq003          LIKE gzwq_t.gzwq003,   #類別
            gzwq004          LIKE gzwq_t.gzwq004,   #編號
            gzwq008          LIKE gzwq_t.gzwq008,   #網頁內容
            gzwq009          LIKE gzwq_t.gzwq009    #編輯內容
            END RECORD


   LOCATE l_gzwp.gzwp007 IN MEMORY
   LOCATE l_gzwp.gzwp008 IN MEMORY
   LOCATE l_gzwq.gzwq008 IN MEMORY
   LOCATE l_gzwq.gzwq009 IN MEMORY
   #切換至輸入畫面

   #將資料輸出到畫面上
   DISPLAY g_p_gzwr001,g_gzwr001_desc,g_p_gzwr002,g_p_gzwr003,g_gzwr_m.gzwr004,
       g_gzwr_m.gzwr006,g_gzwr_m.gzwr007,g_gzwr_m.gzwr008,g_gzwr_m.gzwrstus,
       g_gzwr_m.imgfiles,
       g_gzwr_m.gzwrownid,g_gzwr_m.gzwrownid_desc,g_gzwr_m.gzwrowndp,g_gzwr_m.gzwrowndp_desc,
       g_gzwr_m.gzwrcrtid,g_gzwr_m.gzwrcrtid_desc,g_gzwr_m.gzwrcrtdp,g_gzwr_m.gzwrcrtdp_desc,g_gzwr_m.gzwrcrtdt,
       g_gzwr_m.gzwrmodid,g_gzwr_m.gzwrmodid_desc,g_gzwr_m.gzwrmoddt
    TO gzwr001,formonly.gzwr001_desc,gzwr002,gzwr003,gzwr004,
       gzwr006,gzwr007,gzwr008,gzwrstus,
       formonly.l_imgfile,
       gzwrownid,formonly.gzwrownid_desc,gzwrowndp,formonly.gzwrowndp_desc,
       gzwrcrtid,formonly.gzwrcrtid_desc,gzwrcrtdp,formonly.gzwrcrtdp_desc,gzwrcrtdt,
       gzwrmodid,formonly.gzwrmodid_desc,gzwrmoddt

   CALL cl_set_head_visible("","YES")

   #a-新增,r-複製,u-修改
   IF p_cmd = 'r' THEN
      #此段落的r動作等同於a
      LET p_cmd = 'a'
   END IF

   LET l_insert = FALSE
   LET g_action_choice = ""

   LET g_qryparam.state = "i"

   #控制key欄位可否輸入
   CALL azzi933_03_set_entry(p_cmd)
   CALL azzi933_03_set_no_entry(p_cmd)

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單頭段
      INPUT BY NAME g_gzwr_m.gzwr004,g_gzwr_m.gzwr008,g_gzwr_m.gzwrstus
         ATTRIBUTE(WITHOUT DEFAULTS)

         #自訂ACTION(master_input)


         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)

            #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzwr001

            #add-point:AFTER FIELD gzwr001
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_p_gzwr001
            CALL ap_ref_array2(g_ref_fields,"SELECT gzzal003 FROM gzzal_t WHERE gzzal001=? AND gzzal002='"||g_lang||"'","") RETURNING g_rtn_fields
            LET g_gzwr001_desc = '', g_rtn_fields[1] , ''
            DISPLAY g_gzwr001_desc TO gzwr001_desc

            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_p_gzwr001) AND NOT cl_null(g_p_gzwr002) AND NOT cl_null(g_p_gzwr003) AND NOT cl_null(g_gzwr_m.gzwr004) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_p_gzwr001 != g_gzwr001_t  OR g_p_gzwr002 != g_gzwr002_t  OR g_p_gzwr003 != g_gzwr003_t  OR g_gzwr_m.gzwr004 != g_gzwr004_t )) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzwr_t WHERE "||"gzwr001 = '"||g_p_gzwr001 ||"' AND "|| "gzwr002 = '"||g_p_gzwr002 ||"' AND "|| "gzwr003 = '"||g_p_gzwr003 ||"' AND "|| "gzwr004 = '"||g_gzwr_m.gzwr004 ||"'",'std-00004',0) THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point

         AFTER FIELD gzwr002
            #確認資料無重複
            IF  NOT cl_null(g_p_gzwr001) AND NOT cl_null(g_p_gzwr002) AND NOT cl_null(g_p_gzwr003) AND NOT cl_null(g_gzwr_m.gzwr004) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_p_gzwr001 != g_gzwr001_t  OR g_p_gzwr002 != g_gzwr002_t  OR g_p_gzwr003 != g_gzwr003_t  OR g_gzwr_m.gzwr004 != g_gzwr004_t )) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzwr_t WHERE "||"gzwr001 = '"||g_p_gzwr001 ||"' AND "|| "gzwr002 = '"||g_p_gzwr002 ||"' AND "|| "gzwr003 = '"||g_p_gzwr003 ||"' AND "|| "gzwr004 = '"||g_gzwr_m.gzwr004 ||"'",'std-00004',0) THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


         AFTER FIELD gzwr003
            #確認資料無重複
            IF  NOT cl_null(g_p_gzwr001) AND NOT cl_null(g_p_gzwr002) AND NOT cl_null(g_p_gzwr003) AND NOT cl_null(g_gzwr_m.gzwr004) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_p_gzwr001 != g_gzwr001_t  OR g_p_gzwr002 != g_gzwr002_t  OR g_p_gzwr003 != g_gzwr003_t  OR g_gzwr_m.gzwr004 != g_gzwr004_t )) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzwr_t WHERE "||"gzwr001 = '"||g_p_gzwr001 ||"' AND "|| "gzwr002 = '"||g_p_gzwr002 ||"' AND "|| "gzwr003 = '"||g_p_gzwr003 ||"' AND "|| "gzwr004 = '"||g_gzwr_m.gzwr004 ||"'",'std-00004',0) THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzwr004
            #限輸入英文字,數字,底線
            CALL s_azzi902_get_gzzd("azzi933_02","lbl_gzwr004") RETURNING l_colname, l_comment
            IF  NOT cl_chk_num(g_gzwr_m.gzwr004,"NUL_") THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "azz-00308"   #%1只能輸入英文字,數字,底線
               LET g_errparam.extend = g_gzwr_m.gzwr004
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] = l_colname
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF
            #確認資料無重複
            IF  NOT cl_null(g_p_gzwr001) AND NOT cl_null(g_p_gzwr002) AND NOT cl_null(g_p_gzwr003) AND NOT cl_null(g_gzwr_m.gzwr004) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_p_gzwr001 != g_gzwr001_t  OR g_p_gzwr002 != g_gzwr002_t  OR g_p_gzwr003 != g_gzwr003_t  OR g_gzwr_m.gzwr004 != g_gzwr004_t )) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzwr_t WHERE "||"gzwr001 = '"||g_p_gzwr001 ||"' AND "|| "gzwr002 = '"||g_p_gzwr002 ||"' AND "|| "gzwr003 = '"||g_p_gzwr003 ||"' AND "|| "gzwr004 = '"||g_gzwr_m.gzwr004 ||"'",'std-00004',0) THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


         ON ACTION file_upload   #上傳
            LET g_action_choice="file_upload"
            IF cl_auth_chk_act("file_upload") THEN

               #add-point:ON ACTION file_upload
               IF g_gzwr_m.gzwr004 IS NOT NULL THEN
                  CALL cl_client_browse_file() RETURNING ls_upload
                  CALL azzi933_03_file_upload(g_p_gzwr001,g_p_gzwr002,g_p_gzwr003,g_gzwr_m.gzwr004,ls_upload) RETURNING l_chk,g_gzwr_m.imgfiles,g_gzwr_m.gzwr007
                  #因為圖片檔名路徑要有不同才能重新顯示,修改前後的檔名都相同,所以圖片無法及時更新顯示,這裡先將路徑指到暫存圖片,之後陣列重撈資料庫後會改成正式路徑
                  IF p_cmd = 'u' THEN
                     LET g_browser[g_current_idx].imgfiles = g_gzwr_m.imgfiles
                  END IF
                  DISPLAY g_gzwr_m.gzwr007,g_gzwr_m.imgfiles TO gzwr007,formonly.l_imgfile
                  IF NOT l_chk THEN
                     CONTINUE DIALOG
                  END IF
               ELSE
                  CALL s_azzi902_get_gzzd("azzi933_02","lbl_gzwr004") RETURNING l_colname, l_comment
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "adz-00255"
                  LET g_errparam.extend = l_colname
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF
               #END add-point
            END IF

 #欄位開窗

         AFTER INPUT
            #若點選cancel則離開dialog
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF

            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()

            IF p_cmd <> "u" THEN
               #當p_cmd不為u代表為新增/複製
               LET l_count = 1

               #確定新增的資料不存在(不重複)
               SELECT COUNT(*) INTO l_count FROM gzwr_t
                WHERE  gzwr001 = g_p_gzwr001
                  AND gzwr002 = g_p_gzwr002
                  AND gzwr003 = g_p_gzwr003
                  AND gzwr004 = g_gzwr_m.gzwr004

               IF l_count = 0 THEN

                  #add-point:單頭新增前

                  #end add-point

                  #將新增的單頭資料寫入資料庫
                  INSERT INTO gzwr_t (gzwr001,gzwr002,gzwr003,gzwr004,gzwr006,gzwr007,gzwr008,gzwrstus,
                      gzwrownid,gzwrowndp,gzwrcrtid,gzwrcrtdp,gzwrcrtdt,gzwrmodid,gzwrmoddt)
                  VALUES (g_p_gzwr001,g_p_gzwr002,g_p_gzwr003,g_gzwr_m.gzwr004,g_gzwr_m.gzwr006,
                      g_gzwr_m.gzwr007,g_gzwr_m.gzwr008,g_gzwr_m.gzwrstus,g_gzwr_m.gzwrownid,g_gzwr_m.gzwrowndp,
                      g_gzwr_m.gzwrcrtid,g_gzwr_m.gzwrcrtdp,g_gzwr_m.gzwrcrtdt,g_gzwr_m.gzwrmodid,g_gzwr_m.gzwrmoddt)


                  #add-point:單頭新增中

                  #end add-point

                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = "gzwr_t"
                     LET g_errparam.code   = SQLCA.sqlcode
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF



                  #資料多語言用-增/改


                  #add-point:單頭新增後
                  CALL cl_helps933_gzwr006_upd(g_doctype,g_p_gzwr001,g_p_gzwr002,g_p_gzwr003,g_gzwr_m.gzwr004,g_gzwr_m.imgfiles,g_gzwr_m.gzwr007) RETURNING l_chk,l_dest,g_gzwr_m.gzwr006
                  DISPLAY g_gzwr_m.gzwr006 TO gzwr006
                  #移動暫存檔
                  IF NOT os.Path.copy(g_gzwr_m.imgfiles,l_dest) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "-16366"   #在嘗試寫入檔案時發生錯誤.
                     LET g_errparam.extend = l_dest
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                  END IF
                  #end add-point

                  CALL s_transaction_end('Y','0')
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend =  "g_p_gzwr001"
                  LET g_errparam.code   = "std-00006"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
               END IF
            ELSE
               #add-point:單頭修改前
               #修改前的副檔名
               LET l_sql = "SELECT gzwr007 FROM gzwr_t",
                           " WHERE gzwr001 = ? AND gzwr002 = ? AND gzwr003 = ? AND gzwr004 = ?"
               PREPARE azzi933_03_input_gzwr007t_pre FROM l_sql
               EXECUTE azzi933_03_input_gzwr007t_pre USING g_gzwr001_t,g_gzwr002_t,g_gzwr003_t,g_gzwr004_t INTO l_gzwr007_t
               #end add-point
               UPDATE gzwr_t SET (gzwr001,gzwr002,gzwr003,gzwr004,gzwr006,gzwr007,gzwr008,gzwrstus,gzwrownid,
                   gzwrowndp,gzwrcrtid,gzwrcrtdp,gzwrcrtdt,gzwrmodid,gzwrmoddt) = (g_p_gzwr001,
                   g_p_gzwr002,g_p_gzwr003,g_gzwr_m.gzwr004,g_gzwr_m.gzwr006,g_gzwr_m.gzwr007,
                   g_gzwr_m.gzwr008,g_gzwr_m.gzwrstus,g_gzwr_m.gzwrownid,g_gzwr_m.gzwrowndp,g_gzwr_m.gzwrcrtid,
                   g_gzwr_m.gzwrcrtdp,g_gzwr_m.gzwrcrtdt,g_gzwr_m.gzwrmodid,g_gzwr_m.gzwrmoddt)
                WHERE  gzwr001 = g_gzwr001_t #
                  AND gzwr002 = g_gzwr002_t
                  AND gzwr003 = g_gzwr003_t
                  AND gzwr004 = g_gzwr004_t

               #add-point:單頭修改中

               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = "gzwr_t"
                     LET g_errparam.code   = "std-00009"
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     NEXT FIELD CURRENT
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = "gzwr_t"
                     LET g_errparam.code   = SQLCA.sqlcode
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     NEXT FIELD CURRENT
                  OTHERWISE

                     #資料多語言用-增/改

                     CALL cl_helps933_gzwr006_upd(g_doctype,g_p_gzwr001,g_p_gzwr002,g_p_gzwr003,g_gzwr_m.gzwr004,g_gzwr_m.imgfiles,g_gzwr_m.gzwr007) RETURNING l_chk,l_dest,g_gzwr_m.gzwr006
                     DISPLAY g_gzwr_m.gzwr006 TO gzwr006
                     #紀錄資料更動
                     LET g_log1 = util.JSON.stringify(g_gzwr_m_t)
                     LET g_log2 = util.JSON.stringify(g_gzwr_m)
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     ELSE
                        #移動暫存檔
                        IF g_gzwr_m.imgfiles != l_dest THEN
                           IF NOT os.Path.copy(g_gzwr_m.imgfiles,l_dest) THEN
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = "-16366"   #在嘗試寫入檔案時發生錯誤.
                              LET g_errparam.extend = l_dest
                              LET g_errparam.popup = FALSE
                              CALL cl_err()
                           ELSE
                              CALL cl_helps933_delete_file(g_www_path,g_gzwr_m.imgfiles)   #刪除舊檔案
                           END IF
                        END IF
                        #檔案編號不能修改,但副檔名可能因重新上傳而改變,要自動修改此作業有使用到的資料,編輯內容轉網頁內容
                        CALL cl_helps933_gzwr006_nametag(g_p_gzwr001,g_p_gzwr002,g_p_gzwr003,g_gzwr_m.gzwr004) RETURNING l_nametag   #ex.'aitq202,s,zh_TW,imgname'
                        IF NOT cl_null(l_nametag) AND (l_gzwr007_t != g_gzwr_m.gzwr007) THEN
                           #(1)作業操作說明
                           LET l_sql = "SELECT gzwp003,gzwp008 FROM gzwp_t",
                                       " WHERE gzwp001 = ? AND gzwp002 = ? AND gzwp004 = ?",
                                         " AND gzwp008 LIKE '%",l_nametag CLIPPED,"%'"
                           PREPARE azzi933_03_input_gzwp008_pre FROM l_sql
                           DECLARE azzi933_03_input_gzwp008_cur CURSOR FOR azzi933_03_input_gzwp008_pre

                           LET l_sql = "UPDATE gzwp_t SET gzwp007=?",
                                       " WHERE gzwp001 = ? AND gzwp002 = ? AND gzwp003 = ? AND gzwp004 = ?"
                           PREPARE azzi933_03_input_gzwp007_upd_pre FROM l_sql

                           FOREACH azzi933_03_input_gzwp008_cur USING g_p_gzwr001,g_p_gzwr002,g_p_gzwr003 INTO l_gzwp.gzwp003,l_gzwp.gzwp008
                              IF SQLCA.sqlcode THEN
                                 INITIALIZE g_errparam TO NULL
                                 LET g_errparam.extend = "FOREACH:"
                                 LET g_errparam.code   = SQLCA.sqlcode
                                 LET g_errparam.popup  = FALSE
                                 CALL cl_err()

                                 EXIT FOREACH
                              END IF
                              CALL cl_helps933_edittohtml(g_doctype,l_gzwp.gzwp008) RETURNING l_gzwp.gzwp007
                              EXECUTE azzi933_03_input_gzwp007_upd_pre USING l_gzwp.gzwp007,g_p_gzwr001,g_p_gzwr002,l_gzwp.gzwp003,g_p_gzwr003
                           END FOREACH
                           #(2)作業操作說明細項
                           LET l_sql = "SELECT gzwq003,gzwq004,gzwq009 FROM gzwq_t",
                                       " WHERE gzwq001 = ? AND gzwq002 = ? AND gzwq006 = ?",
                                         " AND gzwq009 LIKE '%",l_nametag CLIPPED,"%'"
                           PREPARE azzi933_03_input_gzwq009_pre FROM l_sql
                           DECLARE azzi933_03_input_gzwq009_cur CURSOR FOR azzi933_03_input_gzwq009_pre

                           LET l_sql = "UPDATE gzwq_t SET gzwq008=?",
                                       " WHERE gzwq001 = ? AND gzwq002 = ? AND gzwq003 = ? AND gzwq004 = ? AND gzwq006 = ?"
                           PREPARE azzi933_03_input_gzwq008_upd_pre FROM l_sql

                           FOREACH azzi933_03_input_gzwq009_cur USING g_p_gzwr001,g_p_gzwr002,g_p_gzwr003 INTO l_gzwq.gzwq003,l_gzwq.gzwq004,l_gzwq.gzwq009
                              IF SQLCA.sqlcode THEN
                                 INITIALIZE g_errparam TO NULL
                                 LET g_errparam.extend = "FOREACH:"
                                 LET g_errparam.code   = SQLCA.sqlcode
                                 LET g_errparam.popup  = FALSE
                                 CALL cl_err()

                                 EXIT FOREACH
                              END IF
                              CALL cl_helps933_edittohtml(g_doctype,l_gzwq.gzwq009) RETURNING l_gzwq.gzwq008
                              EXECUTE azzi933_03_input_gzwq008_upd_pre USING l_gzwq.gzwq008,g_p_gzwr001,g_p_gzwr002,l_gzwq.gzwq003,l_gzwq.gzwq004,g_p_gzwr003
                           END FOREACH
                        END IF
                        CALL s_transaction_end('Y','0')
                     END IF
               END CASE
            END IF
           #controlp
      END INPUT

      #add-point:input段more input
      DISPLAY ARRAY g_browser TO s_detail1.* ATTRIBUTE(COUNT=g_rec_b)

         BEFORE ROW
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_idx = DIALOG.getCurrentRow("s_detail1")
            IF g_current_idx = 0 THEN
               LET g_current_idx = 1
            END IF
            LET g_current_row = g_current_idx  #目前指標
            LET g_current_sw = TRUE
            CALL cl_show_fld_cont()

            #當每次點任一筆資料都會需要用到
            CALL azzi933_03_fetch("")
      END DISPLAY
      #end add-point

      BEFORE DIALOG
         #CALL cl_err_collect_init()
         #add-point:input段before_dialog
         IF g_current_idx <= 0 THEN
           LET g_current_idx = 1
         END IF
         CALL DIALOG.setCurrentRow("s_detail1", g_current_idx)
         #end add-point

      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name, g_fld_name, g_lang)

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
         ACCEPT DIALOG

      #放棄輸入
      ON ACTION cancel
         LET g_action_choice=""
         LET INT_FLAG = TRUE
         EXIT DIALOG

      #在dialog 右上角 (X)
      ON ACTION close
         LET INT_FLAG = TRUE
         EXIT DIALOG

      #toolbar 離開
      ON ACTION exit
         LET INT_FLAG = TRUE
         EXIT DIALOG

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG

   FREE l_gzwp.gzwp007
   FREE l_gzwp.gzwp008
   FREE l_gzwq.gzwq008
   FREE l_gzwq.gzwq009
END FUNCTION

PRIVATE FUNCTION azzi933_03_reproduce()
   DEFINE l_newno     LIKE gzwr_t.gzwr001
   DEFINE l_oldno     LIKE gzwr_t.gzwr001
   DEFINE l_newno02     LIKE gzwr_t.gzwr002
   DEFINE l_oldno02     LIKE gzwr_t.gzwr002
   DEFINE l_newno03     LIKE gzwr_t.gzwr003
   DEFINE l_oldno03     LIKE gzwr_t.gzwr003
   DEFINE l_newno04     LIKE gzwr_t.gzwr004
   DEFINE l_oldno04     LIKE gzwr_t.gzwr004

   DEFINE l_master    RECORD LIKE gzwr_t.*
   DEFINE l_cnt       LIKE type_t.num10

   #切換畫面

   #先確定key值無遺漏
   IF g_p_gzwr001 IS NULL
      OR g_p_gzwr002 IS NULL
      OR g_p_gzwr003 IS NULL
      OR g_gzwr_m.gzwr004 IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "std-00003"
      LET g_errparam.popup  = FALSE
      CALL cl_err()
      RETURN
   END IF

   #備份key值
   LET g_gzwr001_t = g_p_gzwr001
   LET g_gzwr002_t = g_p_gzwr002
   LET g_gzwr003_t = g_p_gzwr003
   LET g_gzwr004_t = g_gzwr_m.gzwr004


   #清空key值
   LET g_gzwr_m.gzwr004 = ""


   CALL azzi933_03_set_entry("a")
   CALL azzi933_03_set_no_entry("a")

   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:4)
      #公用欄位新增給值
      LET g_gzwr_m.gzwrownid = g_user
      LET g_gzwr_m.gzwrowndp = g_dept
      LET g_gzwr_m.gzwrcrtid = g_user
      LET g_gzwr_m.gzwrcrtdp = g_dept
      LET g_gzwr_m.gzwrcrtdt = cl_get_current()
      LET g_gzwr_m.gzwrmodid = g_user
      LET g_gzwr_m.gzwrmoddt = cl_get_current()
      LET g_gzwr_m.gzwrstus = 'Y'

   CALL s_transaction_begin()

   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:2)
	  #根據當下狀態碼顯示圖片
      CASE g_gzwr_m.gzwrstus
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")

      END CASE

   #清空key欄位的desc
   LET g_gzwr001_desc = ''
   DISPLAY g_gzwr001_desc TO gzwr001_desc


   #資料輸入
   CALL azzi933_03_input("r")

   IF INT_FLAG THEN
      #取消
      LET INT_FLAG = 0
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = 9001
      LET g_errparam.popup  = FALSE
      CALL cl_err()
      INITIALIZE g_gzwr_m.* TO NULL
      CALL azzi933_03_show()
      RETURN
   END IF

   CALL s_transaction_begin()

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "gzwr_t"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   CALL s_transaction_end('Y','0')

   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL azzi933_03_set_act_visible()
   CALL azzi933_03_set_act_no_visible()

   #將新增的資料併入搜尋條件中
   LET g_state = "insert"

   LET g_gzwr001_t = g_p_gzwr001
   LET g_gzwr002_t = g_p_gzwr002
   LET g_gzwr003_t = g_p_gzwr003
   LET g_gzwr004_t = g_gzwr_m.gzwr004


   #組合新增資料的條件
   LET g_add_browse = " ",
                      " gzwr001 = '", g_p_gzwr001, "' "
                      ," AND gzwr002 = '", g_p_gzwr002, "' "
                      ," AND gzwr003 = '", g_p_gzwr003, "' "
                      ," AND gzwr004 = '", g_gzwr_m.gzwr004, "' "

   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL azzi933_03_browser_fill("","")

   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
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
PRIVATE FUNCTION azzi933_03_show()
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:2)
   CALL azzi933_03_set_pk_array()
   #add-point:ON ACTION agendum

   #END add-point
   CALL cl_user_overview_set_follow_pic()

   #將資料輸出到畫面上
   DISPLAY g_p_gzwr001,g_gzwr001_desc,g_p_gzwr002,g_p_gzwr003,g_gzwr_m.gzwr004,
       g_gzwr_m.gzwr006,g_gzwr_m.gzwr007,g_gzwr_m.gzwr008,g_gzwr_m.gzwrstus,
       g_gzwr_m.imgfiles,
       g_gzwr_m.gzwrownid,g_gzwr_m.gzwrownid_desc,g_gzwr_m.gzwrowndp,g_gzwr_m.gzwrowndp_desc,
       g_gzwr_m.gzwrcrtid,g_gzwr_m.gzwrcrtid_desc,g_gzwr_m.gzwrcrtdp,g_gzwr_m.gzwrcrtdp_desc,g_gzwr_m.gzwrcrtdt,
       g_gzwr_m.gzwrmodid,g_gzwr_m.gzwrmodid_desc,g_gzwr_m.gzwrmoddt
    TO gzwr001,formonly.gzwr001_desc,gzwr002,gzwr003,gzwr004,
       gzwr006,gzwr007,gzwr008,gzwrstus,
       formonly.l_imgfile,
       gzwrownid,formonly.gzwrownid_desc,gzwrowndp,formonly.gzwrowndp_desc,
       gzwrcrtid,formonly.gzwrcrtid_desc,gzwrcrtdp,formonly.gzwrcrtdp_desc,gzwrcrtdt,
       gzwrmodid,formonly.gzwrmodid_desc,gzwrmoddt

   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:2)
	  #根據當下狀態碼顯示圖片
      CASE g_gzwr_m.gzwrstus
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")

      END CASE

   #顯示有特殊格式設定的欄位或說明
   CALL cl_show_fld_cont()
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
PRIVATE FUNCTION azzi933_03_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING

   #先確定key值無遺漏
   IF g_p_gzwr001 IS NULL
   OR g_p_gzwr002 IS NULL
   OR g_p_gzwr003 IS NULL
   OR g_gzwr_m.gzwr004 IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "std-00003"
      LET g_errparam.popup  = FALSE
      CALL cl_err()
      RETURN
   END IF

   CALL s_transaction_begin()

   LET g_gzwr001_t = g_p_gzwr001
   LET g_gzwr002_t = g_p_gzwr002
   LET g_gzwr003_t = g_p_gzwr003
   LET g_gzwr004_t = g_gzwr_m.gzwr004

   OPEN azzi933_03_cl USING g_p_gzwr001,g_p_gzwr002,g_p_gzwr003,g_gzwr_m.gzwr004

   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "OPEN azzi933_03_cl:"
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      CLOSE azzi933_03_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #顯示最新的資料
   CALL azzi933_03_master_referesh(g_gzwr_m.gzwr004)

   #將最新資料顯示到畫面上
   CALL azzi933_03_show()

   IF cl_ask_delete() THEN

      #刪除相關文件
      CALL azzi933_03_set_pk_array()
      #add-point:相關文件刪除前

      #end add-point
      CALL cl_doc_remove()

      DELETE FROM gzwr_t
       WHERE  gzwr001 = g_p_gzwr001
         AND gzwr002 = g_p_gzwr002
         AND gzwr003 = g_p_gzwr003
         AND gzwr004 = g_gzwr_m.gzwr004

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "gzwr_t"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = FALSE
         CALL cl_err()
         CALL s_transaction_end('N','0')
      END IF

      #add-point:單頭刪除後
      CALL cl_helps933_delete_file(g_www_path,g_gzwr_m.gzwr006)
      #end add-point


      CLEAR FORM
      CALL azzi933_03_ui_browser_refresh()

      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL azzi933_03_browser_fill(g_wc,"")
         CALL azzi933_03_fetch("P")
      ELSE
         CLEAR FORM
      END IF

   END IF

   CLOSE azzi933_03_cl
   CALL s_transaction_end('Y','0')

   #流程通知預埋點-D
   CALL cl_flow_notify(g_p_gzwr001,"D")
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
PRIVATE FUNCTION azzi933_03_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10

   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].gzwr004 = g_gzwr_m.gzwr004 THEN
         CALL g_browser.deleteElement(l_i)
       END IF
   END FOR
   LET g_browser_cnt = g_browser_cnt - 1
   LET g_header_cnt = g_header_cnt - 1

   DISPLAY g_browser_cnt TO FORMONLY.b_count     #page count
   DISPLAY g_header_cnt  TO FORMONLY.h_count     #page count

   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
      CLEAR FORM
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 單頭欄位開啟設定
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
PRIVATE FUNCTION azzi933_03_set_entry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1

   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("gzwr004",TRUE)
   END IF
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
PRIVATE FUNCTION azzi933_03_set_no_entry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1

   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("gzwr004",FALSE)
   END IF
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
PRIVATE FUNCTION azzi933_03_set_act_visible()

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
PRIVATE FUNCTION azzi933_03_set_act_no_visible()

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
PRIVATE FUNCTION azzi933_03_default_search()
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING

   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF

   #根據外部參數(g_argv)組合wc
   IF NOT cl_null(g_p_gzwr001) THEN
      LET ls_wc = ls_wc, " gzwr001 = '", g_p_gzwr001, "' AND "
   END IF
   IF NOT cl_null(g_p_gzwr002) THEN
      LET ls_wc = ls_wc, " gzwr002 = '", g_p_gzwr002, "' AND "
   END IF
   IF NOT cl_null(g_p_gzwr003) THEN
      LET ls_wc = ls_wc, " gzwr003 = '", g_p_gzwr003, "' AND "
   END IF
   
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " gzwr004 = '", g_argv[04], "' AND "
   END IF

   IF NOT cl_null(ls_wc) THEN
      #若有外部參數則根據該參數組合
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         #LET g_wc = " 1=2"
         LET g_wc  = ' 1=1'
      END IF
   END IF

   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
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
PRIVATE FUNCTION azzi933_03_statechange()
   DEFINE lc_state LIKE type_t.chr5

   ERROR ""     #清空畫面右下側ERROR區塊

   IF g_p_gzwr001 IS NULL
      OR g_p_gzwr002 IS NULL      OR g_p_gzwr003 IS NULL      OR g_gzwr_m.gzwr004 IS NULL
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "std-00003"
      LET g_errparam.popup  = FALSE
      CALL cl_err()
      RETURN
   END IF

   CALL s_transaction_begin()

   OPEN azzi933_03_cl USING g_p_gzwr001,g_p_gzwr002,g_p_gzwr003,g_gzwr_m.gzwr004
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "OPEN azzi933_03_cl:"
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      CLOSE azzi933_03_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #顯示最新的資料
   CALL azzi933_03_master_referesh(g_gzwr_m.gzwr004)

   #將資料顯示到畫面上
   DISPLAY g_p_gzwr001,g_gzwr001_desc,g_p_gzwr002,g_p_gzwr003,g_gzwr_m.gzwr004,
       g_gzwr_m.gzwr006,g_gzwr_m.gzwr007,g_gzwr_m.gzwr008,g_gzwr_m.gzwrstus,
       g_gzwr_m.imgfiles,
       g_gzwr_m.gzwrownid,g_gzwr_m.gzwrownid_desc,g_gzwr_m.gzwrowndp,g_gzwr_m.gzwrowndp_desc,
       g_gzwr_m.gzwrcrtid,g_gzwr_m.gzwrcrtid_desc,g_gzwr_m.gzwrcrtdp,g_gzwr_m.gzwrcrtdp_desc,g_gzwr_m.gzwrcrtdt,
       g_gzwr_m.gzwrmodid,g_gzwr_m.gzwrmodid_desc,g_gzwr_m.gzwrmoddt
    TO gzwr001,formonly.gzwr001_desc,gzwr002,gzwr003,gzwr004,
       gzwr006,gzwr007,gzwr008,gzwrstus,
       formonly.l_imgfile,
       gzwrownid,formonly.gzwrownid_desc,gzwrowndp,formonly.gzwrowndp_desc,
       gzwrcrtid,formonly.gzwrcrtid_desc,gzwrcrtdp,formonly.gzwrcrtdp_desc,gzwrcrtdt,
       gzwrmodid,formonly.gzwrmodid_desc,gzwrmoddt

   CASE g_gzwr_m.gzwrstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")

   END CASE

   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_gzwr_m.gzwrstus
            WHEN "N"
               HIDE OPTION "inactive"
            WHEN "Y"
               HIDE OPTION "active"

         END CASE

      ON ACTION inactive
         IF cl_auth_chk_act("inactive") THEN
            LET lc_state = "N"
            #add-point:action控制

            #end add-point
         END IF
         EXIT MENU
      ON ACTION active
         IF cl_auth_chk_act("active") THEN
            LET lc_state = "Y"
         END IF
         EXIT MENU

   END MENU

   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N"
      AND lc_state <> "Y"
      ) OR
	  g_gzwr_m.gzwrstus = lc_state OR cl_null(lc_state) THEN
      CLOSE azzi933_03_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   LET g_gzwr_m.gzwrmodid = g_user
   LET g_gzwr_m.gzwrmoddt = cl_get_current()
   LET g_gzwr_m.gzwrstus = lc_state

   #異動狀態碼欄位/修改人/修改日期
   UPDATE gzwr_t
      SET (gzwrstus,gzwrmodid,gzwrmoddt)
        = (g_gzwr_m.gzwrstus,g_gzwr_m.gzwrmodid,g_gzwr_m.gzwrmoddt)
    WHERE  gzwr001 = g_p_gzwr001
      AND gzwr002 = g_p_gzwr002      AND gzwr003 = g_p_gzwr003      AND gzwr004 = g_gzwr_m.gzwr004

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = FALSE
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")

      END CASE

      #撈取異動後的資料
      CALL azzi933_03_master_referesh(g_gzwr_m.gzwr004)

	  #將資料顯示到畫面上
      DISPLAY g_p_gzwr001,g_gzwr001_desc,g_p_gzwr002,g_p_gzwr003,g_gzwr_m.gzwr004,
          g_gzwr_m.gzwr006,g_gzwr_m.gzwr007,g_gzwr_m.gzwr008,g_gzwr_m.gzwrstus,
          g_gzwr_m.imgfiles,
          g_gzwr_m.gzwrownid,g_gzwr_m.gzwrownid_desc,g_gzwr_m.gzwrowndp,g_gzwr_m.gzwrowndp_desc,
          g_gzwr_m.gzwrcrtid,g_gzwr_m.gzwrcrtid_desc,g_gzwr_m.gzwrcrtdp,g_gzwr_m.gzwrcrtdp_desc,g_gzwr_m.gzwrcrtdt,
          g_gzwr_m.gzwrmodid,g_gzwr_m.gzwrmodid_desc,g_gzwr_m.gzwrmoddt
       TO gzwr001,formonly.gzwr001_desc,gzwr002,gzwr003,gzwr004,
          gzwr006,gzwr007,gzwr008,gzwrstus,
          formonly.l_imgfile,
          gzwrownid,formonly.gzwrownid_desc,gzwrowndp,formonly.gzwrowndp_desc,
          gzwrcrtid,formonly.gzwrcrtid_desc,gzwrcrtdp,formonly.gzwrcrtdp_desc,gzwrcrtdt,
          gzwrmodid,formonly.gzwrmodid_desc,gzwrmoddt
   END IF

   CLOSE azzi933_03_cl
   CALL s_transaction_end('Y','0')

   #流程通知預埋點-S
   CALL azzi933_03_set_pk_array()
   CALL cl_flow_notify('','S')
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
PRIVATE FUNCTION azzi933_03_set_pk_array()
   IF l_ac <= 0 THEN
      RETURN
   END IF

   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_p_gzwr001
   LET g_pk_array[1].column = 'gzwr001'
   LET g_pk_array[2].values = g_p_gzwr002
   LET g_pk_array[2].column = 'gzwr002'
   LET g_pk_array[3].values = g_p_gzwr003
   LET g_pk_array[3].column = 'gzwr003'
   LET g_pk_array[4].values = g_gzwr_m.gzwr004
   LET g_pk_array[4].column = 'gzwr004'
END FUNCTION

################################################################################
# Descriptions...: 取得作業操作說明檔案總管單頭相關資訊
# Memo...........:
# Usage..........: CALL azzi933_03_master_referesh(p_gzwr004)
#                  RETURNING void
# Input parameter: p_gzwr004     檔案編號
#                : 
# Return code....: 
#                : 
# Date & Author..: 2015/03/23 By tsai_yen
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi933_03_master_referesh(p_gzwr004)
   DEFINE p_gzwr004   LIKE gzwr_t.gzwr004   #檔案編號
   DEFINE l_i         LIKE type_t.num10

   INITIALIZE g_gzwr_m.* TO NULL
   #FUN-different START
   IF cl_null(g_gzwr_m.imgwidthunit) THEN
      LET g_gzwr_m.imgwidthunit = "px"
   END IF
   IF cl_null(g_gzwr_m.imgheightunit) THEN
      LET g_gzwr_m.imgheightunit = "px"
   END IF
   #FUN-different END
   
   IF g_gzwr_a.getLength() > 0 AND (NOT cl_null(p_gzwr004)) THEN
      FOR l_i = 1 TO g_gzwr_a.getLength()
         IF g_gzwr_a[l_i].gzwr004 = p_gzwr004 THEN
            LET g_gzwr_m.gzwr004        = g_gzwr_a[l_i].gzwr004
            LET g_gzwr_m.gzwr006        = g_gzwr_a[l_i].gzwr006
            LET g_gzwr_m.gzwr007        = g_gzwr_a[l_i].gzwr007
            LET g_gzwr_m.gzwr008        = g_gzwr_a[l_i].gzwr008
            LET g_gzwr_m.gzwrstus       = g_gzwr_a[l_i].gzwrstus
            LET g_gzwr_m.gzwrownid      = g_gzwr_a[l_i].gzwrownid
            LET g_gzwr_m.gzwrownid_desc = g_gzwr_a[l_i].gzwrownid_desc
            LET g_gzwr_m.gzwrowndp      = g_gzwr_a[l_i].gzwrowndp
            LET g_gzwr_m.gzwrowndp_desc = g_gzwr_a[l_i].gzwrowndp_desc
            LET g_gzwr_m.gzwrcrtid      = g_gzwr_a[l_i].gzwrcrtid
            LET g_gzwr_m.gzwrcrtid_desc = g_gzwr_a[l_i].gzwrcrtid_desc
            LET g_gzwr_m.gzwrcrtdp      = g_gzwr_a[l_i].gzwrcrtdp
            LET g_gzwr_m.gzwrcrtdp_desc = g_gzwr_a[l_i].gzwrcrtdp_desc
            LET g_gzwr_m.gzwrcrtdt      = g_gzwr_a[l_i].gzwrcrtdt
            LET g_gzwr_m.gzwrmodid      = g_gzwr_a[l_i].gzwrmodid
            LET g_gzwr_m.gzwrmodid_desc = g_gzwr_a[l_i].gzwrmodid_desc
            LET g_gzwr_m.gzwrmoddt      = g_gzwr_a[l_i].gzwrmoddt
            LET g_gzwr_m.imgfiles       = g_gzwr_a[l_i].imgfiles
            EXIT FOR
         END IF
      END FOR
   END IF
   
   CALL azzi933_03_tagcode(g_p_gzwr001,g_p_gzwr002,g_p_gzwr003,g_gzwr_m.gzwr004,g_gzwr_m.gzwr007)   #FUN-different
END FUNCTION

################################################################################
# Descriptions...: 作業操作說明上傳檔案
# Memo...........:
# Usage..........: CALL azzi933_03_file_upload(p_gzwr001,p_gzwr002,p_gzwr003,p_gzwr004,ps_upload)
#                  RETURNING l_chk,l_tmppath,l_file_extension
# Input parameter: p_gzwr004         檔案編號
#                : p_gzwr002         客製
#                : p_gzwr003         語言別
#                : p_gzwr004         檔案編號
#                : ps_upload         上傳檔案
#                : p_is_getfile      是否需要GETFILE
# Return code....: l_chk             成功否
#                : l_tmppath         檔案上傳後的暫存路徑
#                : l_file_extension  副檔名
# Date & Author..: 2015/03/23 By tsai_yen
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi933_03_file_upload(p_gzwr001,p_gzwr002,p_gzwr003,p_gzwr004,ps_upload)
   DEFINE p_gzwr001           LIKE gzwr_t.gzwr001       #作業編號
   DEFINE p_gzwr002           LIKE gzwr_t.gzwr002       #客製
   DEFINE p_gzwr003           LIKE gzwr_t.gzwr003       #語言別
   DEFINE p_gzwr004           LIKE gzwr_t.gzwr004       #檔案編號
   DEFINE ps_upload           STRING                    #上傳檔案
   #DEFINE p_is_getfile        BOOLEAN                   #是否需要GETFILE
   DEFINE l_chk               BOOLEAN                   #成功否
   DEFINE l_tmppath           STRING                    #檔案上傳後的暫存路徑
   DEFINE l_file_extension    STRING                    #副檔名
   DEFINE l_file_basename     STRING                    #檔名
   DEFINE ls_pid              STRING
   DEFINE l_str               STRING
   DEFINE l_colname           STRING
   DEFINE l_comment           STRING


   LET l_chk = FALSE

   IF p_gzwr001 IS NOT NULL AND p_gzwr002 IS NOT NULL AND p_gzwr003 IS NOT NULL AND p_gzwr004 IS NOT NULL THEN
      IF NOT cl_null(ps_upload) THEN   #C:/Users/P12345/Desktop/title/hlep_titlebg1.png
         LET l_file_extension = os.Path.extension(ps_upload)        #副檔名
         LET l_file_basename = os.Path.basename(ps_upload)          #原始檔名
         IF NOT cl_null(l_file_extension) THEN    #拿掉副檔名
            LET l_str = ".",l_file_extension
            LET l_file_basename = cl_str_replace(l_file_basename, l_str, "")
         END IF

         CALL cl_helps933_gzwr006_path_tmp(p_gzwr001,p_gzwr002,p_gzwr003,p_gzwr004,ps_upload) RETURNING l_tmppath
         #IF p_is_getfile THEN
            CALL FGL_GETFILE(ps_upload,l_tmppath)   #Transfers a file from the front end workstation to the application server machine.
         #END IF
         IF os.Path.exists(l_tmppath) THEN
            LET l_chk = TRUE
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "azz-00101"   #檔案不存在實體路徑
            LET g_errparam.extend = ""
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
      END IF
   END IF

   RETURN l_chk,l_tmppath,l_file_extension
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
# Modify.........: No.FUN-different
################################################################################
PRIVATE FUNCTION azzi933_03_tagcode(p_gzwr001,p_gzwr002,p_gzwr003,p_gzwr004,p_gzwr007)
   DEFINE p_gzwr001          LIKE gzwr_t.gzwr001    #作業編號
   DEFINE p_gzwr002          LIKE gzwr_t.gzwr002    #客製
   DEFINE p_gzwr003          LIKE gzwr_t.gzwr003    #語言別
   DEFINE p_gzwr004          LIKE gzwr_t.gzwr004    #檔案編號
   DEFINE p_gzwr007          LIKE gzwr_t.gzwr007    #副檔名
   DEFINE l_path             STRING
   DEFINE l_str              STRING
   DEFINE l_type             STRING
   DEFINE l_colname          STRING
   DEFINE l_comment          STRING
   DEFINE l_nametag          STRING    #檔名標籤

   #g_gzwr_m.tagcode
   #組成內容
   LET g_gzwr_m.tagcode = ""
   
   IF (NOT cl_null(p_gzwr001)) AND (NOT cl_null(p_gzwr002)) AND (NOT cl_null(p_gzwr003)) AND (NOT cl_null(p_gzwr004)) THEN
      IF g_p_action = "ins_hyperlink" THEN
         LET l_type = "file"
      ELSE
         CALL cl_helps933_filetype(p_gzwr007) RETURNING l_type
      END IF

      CALL cl_helps933_gzwr006_nametag(p_gzwr001,p_gzwr002,p_gzwr003,p_gzwr004) RETURNING l_nametag
      CASE l_type
         WHEN "image"
            LET g_gzwr_m.tagcode = "[tag:img]",
                               "[tag:src]",l_nametag CLIPPED,
                               "[/tag:src]"
            #圖片寬度
            IF (NOT cl_null(g_gzwr_m.imgwidth)) AND g_gzwr_m.imgwidth > 0 AND (NOT cl_null(g_gzwr_m.imgwidthunit)) THEN
               LET l_str = g_gzwr_m.imgwidth
               LET g_gzwr_m.tagcode = g_gzwr_m.tagcode || "[tag:width]" || l_str || g_gzwr_m.imgwidthunit CLIPPED || "[/tag:width]"
            END IF
            #圖片高度
            IF (NOT cl_null(g_gzwr_m.imgheight)) AND g_gzwr_m.imgheight > 0 AND (NOT cl_null(g_gzwr_m.imgheightunit)) THEN
               LET l_str = g_gzwr_m.imgheight
               LET g_gzwr_m.tagcode = g_gzwr_m.tagcode || "[tag:height]" || l_str || g_gzwr_m.imgheightunit CLIPPED || "[/tag:height]"
            END IF
            
            LET g_gzwr_m.tagcode = g_gzwr_m.tagcode || "[/tag:img]"
         WHEN "file"
            LET g_gzwr_m.tagcode = "[tag:a]" ||
                               "[tag:href]" || l_nametag CLIPPED ||
                               "[/tag:href]" ||
                             "[/tag:a]"
                             
            #CALL s_azzi902_get_gzzd("azzi933_01","lbl_hyperlink_txt") RETURNING l_colname, l_comment
            #IF cl_null(l_colname) THEN
            #   LET l_colname = "lbl_hyperlink_txt"
            #END IF
            #LET g_gzwr_m.tagcode = g_gzwr_m.tagcode CLIPPED,l_colname CLIPPED
            LET g_gzwr_m.tagcode = g_gzwr_m.tagcode CLIPPED,g_hyperlink_txt CLIPPED
            
            LET g_gzwr_m.tagcode = g_gzwr_m.tagcode CLIPPED || "[/tag:/a]"
      END CASE
   END IF
   
   DISPLAY g_gzwr_m.tagcode TO formonly.tagcode
END FUNCTION

 
{</section>}
 
