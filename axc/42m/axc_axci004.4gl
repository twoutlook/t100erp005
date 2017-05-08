#該程式未解開Section, 採用最新樣板產出!
{<section id="axci004.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2014-12-18 18:28:51), PR版次:0006(2016-11-14 11:06:14)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000798
#+ Filename...: axci004
#+ Description: 成本BOM維護作業
#+ Creator....: ()
#+ Modifier...: 00768 -SD/PR- 08734
 
{</section>}
 
{<section id="axci004.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#  mod 141217 by zhangllc xcad_t增加栏位xcadseq(key),xcad009-xcad013
#160804-00008#1   2016/08/04  By xianghui    优化树状结构数据的抓取
#160902-00048#2   2016/09/06  By 02097       針對SQL的WHERE條件中缺少ent的清單做補強
#161108-00012#4   2016/11/09  By 08734       g_browser_cnt 由num5改為num10
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
{<Module define>}

#單頭 type 宣告
 type type_g_xcad_m        RECORD
   xcad001 LIKE xcad_t.xcad001, 
   xcad002 LIKE xcad_t.xcad002, 
   imaa006_desc_1 LIKE type_t.chr10, 
   imaal003_desc_1 LIKE type_t.chr500, 
   imaal004_desc_1 LIKE type_t.chr500,
   xcadsite        LIKE xcad_t.xcadsite,
   xcadsite_desc   LIKE type_t.chr500,
   xcadstus        LIKE xcad_t.xcadstus
       END RECORD
 
#單身 type 宣告
 TYPE type_g_xcad_d        RECORD
   xcadseq LIKE xcad_t.xcadseq,
   xcad003 LIKE xcad_t.xcad003, 
   imaal003_desc_2 LIKE type_t.chr500, 
   imaal004_desc_2 LIKE type_t.chr500, 
   imaa006_desc_2 LIKE type_t.chr10, 
   xcad004 LIKE xcad_t.xcad004, 
   xcad005 LIKE xcad_t.xcad005, 
   xcad006 LIKE xcad_t.xcad006, 
   xcad007 LIKE xcad_t.xcad007, 
   xcad008 LIKE xcad_t.xcad008, 
   xcad009 LIKE xcad_t.xcad009, 
   xcad009_desc LIKE type_t.chr500, 
   xcad010 LIKE xcad_t.xcad010, 
   xcad011 LIKE xcad_t.xcad011, 
   xcad011_desc LIKE type_t.chr500, 
   xcad012 LIKE xcad_t.xcad012, 
   xcad013 LIKE xcad_t.xcad013
       END RECORD
 TYPE type_g_xcad2_d RECORD
   #xcad003 LIKE xcad_t.xcad003, 
   xcadseq LIKE xcad_t.xcadseq,
   xcadownid LIKE xcad_t.xcadownid, 
   xcadownid_desc LIKE type_t.chr500, 
   xcadowndp LIKE xcad_t.xcadowndp, 
   xcadowndp_desc LIKE type_t.chr500, 
   xcadcrtid LIKE xcad_t.xcadcrtid, 
   xcadcrtid_desc LIKE type_t.chr500, 
   xcadcrtdp LIKE xcad_t.xcadcrtdp, 
   xcadcrtdp_desc LIKE type_t.chr500, 
   xcadcrtdt DATETIME YEAR TO SECOND, 
   xcadmodid LIKE xcad_t.xcadmodid, 
   xcadmodid_desc LIKE type_t.chr500, 
   xcadmoddt DATETIME YEAR TO SECOND
       END RECORD


#模組變數(Module Variables)
DEFINE g_xcad_m          type_g_xcad_m
DEFINE g_xcad_m_t        type_g_xcad_m
DEFINE g_xcad_d          DYNAMIC ARRAY OF type_g_xcad_d
DEFINE g_xcad_d_t        type_g_xcad_d
DEFINE g_xcad2_d   DYNAMIC ARRAY OF type_g_xcad2_d
DEFINE g_xcad2_d_t type_g_xcad2_d

DEFINE g_xcad001_t        LIKE xcad_t.xcad001
DEFINE g_xcad002_t        LIKE xcad_t.xcad002
#DEFINE g_xcad003_t        LIKE xcad_t.xcad003
DEFINE g_xcadseq_t        LIKE xcad_t.xcadseq
DEFINE g_xcadsite_t       LIKE xcad_t.xcadsite

DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位
       #外顯欄位
       b_show          LIKE type_t.chr100,
       #父節點id
       b_pid           LIKE type_t.chr100,
       #本身節點id
       b_id            LIKE type_t.chr100,
       #是否展開
       b_exp           LIKE type_t.chr100,
       #是否有子節點
       b_hasC          LIKE type_t.num5,
       #是否已展開
       b_isExp         LIKE type_t.num5,
       #展開值
       b_expcode       LIKE type_t.num5,
       #tree自定義欄位
      b_xcad001 LIKE xcad_t.xcad001,
      b_xcad002 LIKE xcad_t.xcad002,
      b_xcad002_desc LIKE imaal_t.imaal003,
      b_xcad002_desc_desc LIKE imaal_t.imaal004,
      b_imaa006_desc_1 LIKE imaa_t.imaa006,
      b_xcadseq LIKE xcad_t.xcadseq,
      b_xcad003 LIKE xcad_t.xcad003,
      b_xcad003_desc LIKE imaal_t.imaal003,
      b_xcad003_desc_desc LIKE imaal_t.imaal004,
      b_imaa006_desc_2 LIKE imaa_t.imaa006,
      b_xcad004 LIKE xcad_t.xcad004,
      b_xcad005 LIKE xcad_t.xcad005,
      b_xcad006 LIKE xcad_t.xcad006,
      b_xcad007 LIKE xcad_t.xcad007,
      b_xcad008 LIKE xcad_t.xcad008,
      b_xcadsite LIKE xcad_t.xcadsite
       END RECORD

DEFINE g_browser_root    DYNAMIC ARRAY OF INTEGER    #root資料所在

#多table用變數
DEFINE g_master_multi_table_t    RECORD
      xcad001 LIKE xcad_t.xcad001,
      xcad002 LIKE xcad_t.xcad002,
      #xcad003 LIKE xcad_t.xcad003
      xcadseq LIKE xcad_t.xcadseq
      END RECORD

DEFINE g_wc                  STRING
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_jump                LIKE type_t.num10
DEFINE g_no_ask              LIKE type_t.num5
#DEFINE g_rec_b               LIKE type_t.num5   #161108-00012#4  2016/11/09 By 08734 mark
DEFINE g_rec_b               LIKE type_t.num10   #161108-00012#4  2016/11/09 By 08734 add
#DEFINE l_ac                  LIKE type_t.num5   #161108-00012#4  2016/11/09 By 08734 mark
DEFINE l_ac                  LIKE type_t.num10   #161108-00012#4  2016/11/09 By 08734 add
DEFINE g_curr_diag           ui.Dialog                #Current Dialog

#DEFINE g_pagestart           LIKE type_t.num5   #161108-00012#4  2016/11/09 By 08734 mark
DEFINE g_pagestart           LIKE type_t.num10   #161108-00012#4  2016/11/09 By 08734 add
DEFINE gwin_curr             ui.Window                #Current Window
DEFINE gfrm_curr             ui.Form                  #Current Form
DEFINE g_page_action         STRING                   #page action
DEFINE g_header_hidden       LIKE type_t.num5         #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5         #隱藏工作Panel
#DEFINE g_browser_cnt         LIKE type_t.num5         #total count   #161108-00012#4  2016/11/09 By 08734 mark
DEFINE g_browser_cnt         LIKE type_t.num10         #total count   #161108-00012#4  2016/11/09 By 08734 add
DEFINE g_page                STRING                   #第幾頁

#DEFINE g_detail_cnt          LIKE type_t.num5      #161108-00012#4  2016/11/09 By 08734 mark  
DEFINE g_detail_cnt          LIKE type_t.num10      #161108-00012#4  2016/11/09 By 08734 add
#DEFINE g_detail_idx          LIKE type_t.num5      #161108-00012#4  2016/11/09 By 08734 mark
DEFINE g_detail_idx          LIKE type_t.num10      #161108-00012#4  2016/11/09 By 08734 add

#DEFINE g_current_row         LIKE type_t.num5         #Browser所在筆數   #161108-00012#4  2016/11/09 By 08734 mark
DEFINE g_current_row         LIKE type_t.num10         #Browser所在筆數   #161108-00012#4  2016/11/09 By 08734 add
DEFINE g_current_sw          LIKE type_t.num10         #Browser所在筆數用開關  #161108-00012#4 num5==》num10

DEFINE g_searchcol           LIKE type_t.chr200
DEFINE g_searchstr           LIKE type_t.chr200
DEFINE g_searchtype          LIKE type_t.chr200
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_row_index           LIKE type_t.num10  #161108-00012#4 num5==》num10
DEFINE g_root_search         BOOLEAN
#160804-00008#1---add---s
DEFINE g_error_show          LIKE type_t.num5              #是否顯示資料過多的錯誤訊息   
DEFINE g_browser_expand   DYNAMIC ARRAY OF RECORD                   #資料瀏覽之欄位  
      b_xcad001 STRING
      ,b_xcad002 STRING
      END RECORD 
#160804-00008#1---add---e      
{</Module define>}          {#ADP版次:1#}          {#ADP版次:1#}          {#ADP版次:1#}
#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_xcadsite            LIKE xcad_t.xcadsite
DEFINE g_idx                 LIKE type_t.num10  #161108-00012#4 num5==》num10
DEFINE g_path_add            DYNAMIC ARRAY OF STRING
DEFINE g_wc_table1           STRING
DEFINE g_state               STRING
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page 
DEFINE g_wc2                 STRING 
DEFINE g_wc2_table1          STRING
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
#DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數   #161108-00012#4  2016/11/09 By 08734 mark
DEFINE g_current_page        LIKE type_t.num10              #目前所在頁數   #161108-00012#4  2016/11/09 By 08734 add
DEFINE g_copy                LIKE type_t.chr1
DEFINE g_xcad001_c           LIKE xcad_t.xcad001
DEFINE g_xcad002_c           LIKE xcad_t.xcad002
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="axci004.main" >}
#+ 作業開始
MAIN
   #add-point:main段define name="main.define"
   
   #end add-point    
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axc","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
 
   #add-point:SQL_define name="main.define_sql"
   LET g_forupd_sql = "SELECT xcad001,xcad002,'','','',xcadstus FROM xcad_t WHERE xcadent= ? AND xcad001=? AND  
       xcad002=? FOR UPDATE"
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE axci004_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axci004 WITH FORM cl_ap_formpath("axc",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axci004_init()
 
      #進入選單 Menu (='N')
      CALL axci004_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_axci004
   END IF
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE axci004_tmp 
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="axci004.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION axci004_ui_dialog()
   #add-point:ui_dialog段define
   DEFINE l_success    LIKE type_t.chr1
   #end add-point
   {<Local define>}
   DEFINE li_exit      LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx       LIKE type_t.num10  #161108-00012#4 num5==》num10
   DEFINE li_wc        LIKE type_t.chr200
   #DEFINE l_ac         LIKE type_t.num5   #161108-00012#4  2016/11/09 By 08734 mark
   DEFINE l_ac         LIKE type_t.num10   #161108-00012#4  2016/11/09 By 08734 add
   {</Local define>}

   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()

   #CALL gfrm_curr.setElementImage("logo","logo/applogo.png")
   #CALL gfrm_curr.setElementHidden("mainlayout",1)
   #CALL gfrm_curr.setElementHidden("worksheet",0)
   #LET g_main_hidden = 1

   #add-point:ui_dialog段before dialog
   {<point name="ui_dialog.before_dialog"/>}
   #end add-point
   LET g_current_page = 1
   WHILE li_exit = FALSE

      #判斷前一個動作是否為新增, 若是的話切換到新增的筆數
      IF g_state = "Y" THEN
         FOR li_idx = 1 TO g_browser.getLength()
            IF g_browser[li_idx].b_xcad001 = g_xcad001_t AND g_browser[li_idx].b_xcad002 = g_xcad002_t THEN
               LET g_current_row = li_idx
               EXIT FOR
            END IF
         END FOR
         LET g_state = ""
      END IF

      CALL axci004_browser_fill(g_wc,g_searchtype)

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         INPUT g_searchstr,g_searchcol,g_searchtype FROM formonly.searchstr,formonly.cbo_searchcol,formonly.rdo_searchtype
            BEFORE INPUT
         END INPUT

         #左側瀏覽頁簽
         DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTE(COUNT=g_rec_b)

            BEFORE ROW
               IF g_copy = 'Y' THEN    #複製后,顯示新的資料
                  FOR l_ac = 1 TO g_browser.getLength()
                     IF g_browser[l_ac].b_xcad001 = g_xcad001_c AND g_browser[l_ac].b_xcad002 = g_xcad002_c THEN 
                        LET g_current_idx = l_ac
                        EXIT FOR
                     END IF     
                  END FOR
                  LET g_copy = 'N' 
               ELSE
                  #回歸舊筆數位置 (回到當時異動的筆數)
                  LET g_current_idx = DIALOG.getCurrentRow("s_browse")
                  IF g_current_row > 1 AND g_current_sw = FALSE THEN
                     CALL DIALOG.setCurrentRow("s_browse",g_current_row)
                     LET g_current_idx = g_current_row
                  END IF
               END IF
               LET g_current_row = g_current_idx #目前指標
               LET g_current_sw = TRUE
               CALL cl_show_fld_cont()
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)

               CALL axci004_fetch('')  #當每次點任一筆資料都會需要用到
               LET g_detail_idx = 1
               IF g_current_page = 1 THEN
                  LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
                  IF g_detail_idx > g_xcad_d.getLength() THEN
                     LET g_detail_idx = g_xcad_d.getLength()
                  END IF
                  IF g_detail_idx = 0 AND g_xcad_d.getLength() <> 0 THEN
                     LET g_detail_idx = 1
                  END IF
                  DISPLAY g_detail_idx TO FORMONLY.idx
                  DISPLAY g_xcad_d.getLength() TO FORMONLY.cnt
               END IF
               
            ON EXPAND (g_row_index)
               #樹展開
               CALL axci004_browser_expand(g_row_index)
               LET g_browser[g_row_index].b_isExp = 1
               LET g_browser_expand[g_browser_expand.getLength()+1].b_xcad001 = g_browser[g_row_index].b_xcad001   #160804-00008#1
               LET g_browser_expand[g_browser_expand.getLength()].b_xcad002  = g_browser[g_row_index].b_xcad002    #160804-00008#1
            ON COLLAPSE (g_row_index)
               #樹關閉

         END DISPLAY
         
         DISPLAY ARRAY g_xcad_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL axci004_ui_detailshow()
            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #控制stus哪個按鈕可以按
            
         END DISPLAY
        
         DISPLAY ARRAY g_xcad2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL axci004_ui_detailshow()
            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)      
               LET g_current_page = 2
         
         END DISPLAY

         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            IF g_copy = 'Y' THEN    #複製后,顯示新的資料
               FOR l_ac = 1 TO g_browser.getLength()
                  IF g_browser[l_ac].b_xcad001 = g_xcad001_c AND g_browser[l_ac].b_xcad002 = g_xcad002_c THEN 
                     LET g_current_idx = l_ac
                     EXIT FOR
                  END IF     
               END FOR
               LET g_copy = 'N' 
            ELSE
               #回歸舊筆數位置 (回到當時異動的筆數)
               LET g_current_idx = DIALOG.getCurrentRow("s_browse")
               IF g_current_row > 1 AND g_current_sw = FALSE THEN
                  IF g_current_row > g_browser.getLength() THEN
                     LEt g_current_row = g_browser.getLength()
                  END IF
                  CALL DIALOG.setCurrentRow("s_browse",g_current_row)
                  LET g_current_idx = g_current_row
               END IF
            END IF
            LET g_current_row = g_current_idx #目前指標
            LET g_current_sw = TRUE
            CALL cl_show_fld_cont()
            CALL DIALOG.setCurrentRow("s_browse",g_current_row)
            IF g_current_idx > 0 THEN
            CALL axci004_fetch('')            #當每次點任一筆資料都會需要用到
            END IF

         ON ACTION statechange
            CALL axci004_statechange()
            EXIT DIALOG

         #一般搜尋
         ON ACTION searchdata
            LET g_searchstr = GET_FLDBUF(searchstr)
            LET g_searchcol = GET_FLDBUF(cbo_searchcol)
            #若無輸入關鍵字則查找出所有資料
            IF g_searchcol='0' AND NOT cl_null(g_searchstr) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00001"
               LET g_errparam.extend = "searchcol:"
               LET g_errparam.popup = FALSE
               CALL cl_err()

               CONTINUE DIALOG
            END IF
            IF NOT cl_null(g_searchstr) THEN
               LET g_wc = " lower(", g_searchcol, ") LIKE '%", g_searchstr, "%'"
               LET g_wc = g_wc.toLowerCase()
            ELSE
               LET g_wc = " 1=1 "
            END IF
            EXIT DIALOG
            #CALL axci004_browser_fill(g_wc,g_searchtype)

            #LET g_current_idx = 1
            #IF g_browser_cnt = 0 THEN
            #   CALL cl_err('','-100',1)
            #ELSE
            #   CALL axci004_fetch('F')
            #END IF

         #進階搜尋
         #ON ACTION advancesearch

         #ACTION表單列
         ON ACTION first
            LET g_current_idx = 1
            CALL axci004_fetch('')
            LET g_current_row = g_current_idx

         ON ACTION next
            LET g_current_idx = g_current_idx + 1
            CALL axci004_fetch('')
            LET g_current_row = g_current_idx

         ON ACTION jump
            CALL axci004_fetch('/')
            LET g_current_row = g_current_idx

         ON ACTION previous
            LET g_current_idx = g_current_idx - 1
            CALL axci004_fetch('')
            LET g_current_row = g_current_idx

         ON ACTION last
            LET g_current_idx = g_browser_cnt
            CALL axci004_fetch('')
            LET g_current_row = g_current_idx

         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG

         ON ACTION close
            LET li_exit = TRUE
            EXIT DIALOG

         ON ACTION mainhidden       #主頁摺疊
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementImage("mainhidden","small/arr-r.png")
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementImage("mainhidden","small/arr-l.png")
               LET g_main_hidden = 1
            END IF
            EXIT DIALOG

         ON ACTION worksheethidden   #瀏覽頁折疊
            IF g_worksheet_hidden THEN
               CALL gfrm_curr.setElementHidden("worksheet",0)
               CALL gfrm_curr.setElementImage("worksheethidden","small/arr-l.png")
               LET g_worksheet_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("worksheet",1)
               CALL gfrm_curr.setElementImage("worksheethidden","small/arr-r.png")
               LET g_worksheet_hidden = 1
            END IF
            EXIT DIALOG

         ON ACTION controls      #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
            IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("worksheet_detail",0)
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("worksheet_detail",1)
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden
            END IF

         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL axci004_delete()
            END IF

         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axci004_insert()
                EXIT DIALOG
            END IF

         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               CALL axci004_modify()
                EXIT DIALOG
            END IF
            
         ON ACTION modify_detail
            LET g_aw = g_curr_diag.getCurrentItem()
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN 
               CALL axci004_modify()
               EXIT DIALOG
            END IF

         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               EXIT DIALOG
            END IF

         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axci004_query()
            END IF

         ON ACTION open_axci004_01
            LET g_action_choice="open_axci004_01"
            IF cl_auth_chk_act("open_axci004_01") THEN
               IF axci004_01_create() THEN
                  CALL s_transaction_begin()
                  CALL axci004_01(g_xcad_m.xcad001) RETURNING l_success
                  IF l_success = TRUE THEN
                     CALL s_transaction_end('Y','1')
                     ERROR "INSERT O.K"
                  ELSE
                     CALL s_transaction_end('N','1')
                  END IF
               END IF
               CALL axci004_01_drop() RETURNING l_success
               CALL axci004_show() 
               EXIT DIALOG
            END IF

         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL axci004_reproduce()
               EXIT DIALOG
            END IF

            &include "main_menu.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"

      END DIALOG
   END WHILE
END FUNCTION

PRIVATE FUNCTION axci004_init()
   #add-point:init段define
   {<point name="init.define"/>}
   #end add-point

   #add-point:畫面資料初始化
   {<point name="init.init"/>}
   CALL cl_set_combo_scc_part('xcadstus','50','N,Y')
   LET g_copy = 'N'
   #end add-point

   CALL axci004_default_search()

END FUNCTION

PRIVATE FUNCTION axci004_browser_fill(p_wc,p_type)
   DEFINE p_wc       STRING
   DEFINE p_type     LIKE type_t.chr10
   DEFINE ls_sql             STRING
   DEFINE li_idx             LIKE type_t.num10
   DEFINE li_idx2            LIKE type_t.num10
   
   CALL g_browser.clear()
   CLEAR FORM
   #160804-00008#1---add---s
   LET ls_sql = " SELECT DISTINCT xcad001 ",
                " FROM xcad_t ",
                " WHERE xcadent = '" ||g_enterprise|| "' AND ", g_wc ,cl_sql_add_filter("xcad_t")
          
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料             
   PREPARE browse_pre FROM ls_sql
   DECLARE browse_cur CURSOR FOR browse_pre
   
   LET li_idx = 1 
   FOREACH browse_cur INTO g_browser[li_idx].b_xcad001
      
      LET g_browser[li_idx].b_pid     = 0
      LET g_browser[li_idx].b_id      = 0, ".", li_idx USING "<<<"
      LET g_browser[li_idx].b_exp     = FALSE
      LET g_browser[li_idx].b_expcode = 1
      LET g_browser[li_idx].b_hasC    = TRUE
      LET g_browser[li_idx].b_show    = g_browser[li_idx].b_xcad001
      #CALL axci004_desc_show(li_idx)
      LET li_idx = li_idx + 1
      
      IF li_idx > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   IF li_idx > g_max_rec AND g_error_show = 1 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = li_idx
      LET g_errparam.code   = 9035 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   
   LET g_error_show = 0
   
   CALL g_browser.deleteElement(g_browser.getLength())
   
   LET g_browser_cnt = g_browser.getLength()
 
   #瀏覽頁筆數顯示
   DISPLAY g_browser_cnt TO FORMONLY.b_count        #總筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count        #總筆數
   
   #樹展開
   FOR li_idx = 1 TO g_browser.getLength()
      FOR li_idx2 = 1 TO g_browser_expand.getLength()
         IF g_browser_expand[li_idx2].b_xcad001.equals(g_browser[li_idx].b_xcad001)
            AND g_browser_expand[li_idx2].b_xcad002.equals(g_browser[li_idx].b_xcad002)
            THEN
            CALL axci004_browser_expand(li_idx)
            LET g_browser[li_idx].b_isExp = 1  
            LET g_browser[li_idx].b_exp = TRUE
         END IF 
      END FOR
   END FOR
   
   FREE browse_pre
   RETURN 
   #160804-00008#1---add---e   
   #160804-00008#1---mark---s   
   #IF cl_null(g_wc2) THEN 
   #   LET g_wc2 = " 1=1 "
   #END IF
   #
   #DROP TABLE axci004_tmp 
   #CREATE TEMP TABLE axci004_tmp
   #(xcad001 LIKE xcad_t.xcad001,
   # xcad002 LIKE xcad_t.xcad002,
   # xcad002_desc LIKE imaal_t.imaal003,
   # xcad002_desc_desc LIKE imaal_t.imaal004,
   # imaa006_desc_1 LIKE imaa_t.imaa006,
   # xcadseq LIKE xcad_t.xcadseq,
   # xcad003 LIKE xcad_t.xcad003,
   # xcad003_desc LIKE imaal_t.imaal003,
   # xcad003_desc_desc LIKE imaal_t.imaal004,
   # imaa006_desc_2 LIKE imaa_t.imaa006,
   # xcad004 LIKE xcad_t.xcad004,
   # xcad005 LIKE xcad_t.xcad005,
   # xcad006 LIKE xcad_t.xcad006,
   # xcad007 LIKE xcad_t.xcad007,
   # xcad008 LIKE xcad_t.xcad008,
   # xcadsite LIKE xcad_t.xcadsite,
   # exp_code  LIKE type_t.num5
   #);
   #
   ###先確定搜尋範圍(若無條件搜尋則只找root出來)
   ##SELECT COUNT(*) INTO l_cnt FROM xcad_t
   ##
   ###取得符合p_wc的所有資料
   ##LET g_sql = "SELECT COUNT(*)",
   ##            " FROM xcad_t  ",
   ##            " WHERE xcadent = '" ||g_enterprise|| "' AND ",p_wc," AND ",g_wc2
   ##PREPARE master_cnt FROM g_sql
   ##DECLARE master_cntcur CURSOR FOR master_cnt
   ##OPEN master_cntcur
   ##FETCH master_cntcur INTO l_cnt2
   #
   ##LET g_root_search = FALSE
   #
   #
   ##搜尋建構樹所需的節點
   #CALL axci004_match_node(p_wc,p_type) #p_type:1.上推 2.下展 3.全部
   #CALL axci004_browser_create(p_type)
   #160804-00008#1---mark---s
END FUNCTION

PRIVATE FUNCTION axci004_match_node(p_wc,p_type)
   DEFINE p_wc         LIKE type_t.chr200
   DEFINE p_type       LIKE type_t.chr10
   DEFINE ls_code      LIKE type_t.chr50
   DEFINE ls_code2     LIKE type_t.chr50
   DEFINE l_bstmp      RECORD    #body欄位
             xcad001           LIKE xcad_t.xcad001,
             xcad002           LIKE xcad_t.xcad002,
             xcad002_desc      LIKE imaal_t.imaal003,
             xcad002_desc_desc LIKE imaal_t.imaal004,
             imaa006_desc_1    LIKE imaa_t.imaa006,
             xcadseq           LIKE xcad_t.xcadseq,
             xcad003           LIKE xcad_t.xcad003,
             xcad003_desc      LIKE imaal_t.imaal003,
             xcad003_desc_desc LIKE imaal_t.imaal004,
             imaa006_desc_2    LIKE imaa_t.imaa006,
             xcad004           LIKE xcad_t.xcad004,
             xcad005           LIKE xcad_t.xcad005,
             xcad006           LIKE xcad_t.xcad006,
             xcad007           LIKE xcad_t.xcad007,
             xcad008           LIKE xcad_t.xcad008,
             xcadsite          LIKE xcad_t.xcadsite             
          #僅含單身table的欄位
   END RECORD
   DEFINE l_child_list DYNAMIC ARRAY OF RECORD    #body欄位 
             xcad001           LIKE xcad_t.xcad001,
             xcad002           LIKE xcad_t.xcad002,
             xcad002_desc      LIKE imaal_t.imaal003,
             xcad002_desc_desc LIKE imaal_t.imaal004,
             imaa006_desc_1    LIKE imaa_t.imaa006,
             xcadseq           LIKE xcad_t.xcadseq,
             xcad003           LIKE xcad_t.xcad003,
             xcad003_desc      LIKE imaal_t.imaal003,
             xcad003_desc_desc LIKE imaal_t.imaal004,
             imaa006_desc_2    LIKE imaa_t.imaa006,
             xcad004           LIKE xcad_t.xcad004,
             xcad005           LIKE xcad_t.xcad005,
             xcad006           LIKE xcad_t.xcad006,
             xcad007           LIKE xcad_t.xcad007,
             xcad008           LIKE xcad_t.xcad008,
             xcadsite          LIKE xcad_t.xcadsite              
          #僅含單身table的欄位
   END RECORD
   #add-point:match_node段define
   DEFINE l_xcadstus LIKE xcad_t.xcadstus
   #end add-point

   #先找出符合條件的節點並給予展開值
   CASE p_type
      WHEN "1" #上推
         LET ls_code = "0"
      WHEN "2" #下展
         LET ls_code = "1"
      WHEN "3" #全部
         LET ls_code = "1"
   END CASE

   #IF cl_null('xcad002') THEN
   #   LET ls_code = '0'
   #END IF

   LET g_sql = " INSERT INTO axci004_tmp (xcad001,xcad002,xcad002_desc,xcad002_desc_desc,imaa006_desc_1,xcadseq,xcad003,xcad003_desc,xcad003_desc_desc,imaa006_desc_2,xcad004,xcad005,xcad006,xcad007,xcad008,xcadsite,exp_code) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
   PREPARE master_tmp FROM g_sql

   #IF g_root_search THEN
   #   FOREACH master_extcur INTO l_bstmp.*
   #      EXECUTE master_tmp USING l_bstmp.*,ls_code
   #   END FOREACH
   #   CALL s_transaction_end('Y','0')
   #   RETURN
   #END IF

   #取得符合p_wc的所有資料
   LET g_sql = "SELECT xcad001,xcad002,'','','',xcadseq,xcad003,'','','',xcad004,xcad005,xcad006,xcad007,xcad008,xcadsite ",
               " FROM xcad_t  ",
               " WHERE xcadent = '" ||g_enterprise|| "' AND ",p_wc," AND ",g_wc2
   PREPARE master_ext FROM g_sql
   DECLARE master_extcur CURSOR FOR master_ext
   FOREACH master_extcur INTO l_bstmp.*
      EXECUTE master_tmp USING l_bstmp.*,ls_code
      LET l_child_list[l_child_list.getLength()+1].* = l_bstmp.*

      #找出符合條件的節點的所有祖先並給予展開值
      CASE p_type
         WHEN "1" #上推
            LET ls_code2 = "1"
         WHEN "2" #下展
            LET ls_code2 = "-1"
         WHEN "3" #全部
            LET ls_code2 = "1"
      END CASE

      #若pid欄位存在才進行後續處理
      #擷取該節點的父節點到temp table中
      LET g_sql = " SELECT xcad001,xcad002,'','','',xcadseq,xcad003,'','','',xcad004,xcad005,xcad006,xcad007,xcad008,xcadsite ",
                  #"   FROM xcad_t  ",
                  #"  WHERE xcadent = '" ||g_enterprise|| "' AND xcad003 = ? "
                  "   FROM axci004_tmp  ",
                  "  WHERE xcad003 = ? ",
                  "    AND xcad001 = ? "
      PREPARE master_getparent_up FROM g_sql

      #擷取該節點的所有父節點s
      WHILE TRUE
         IF cl_null(l_child_list[1].xcad003) THEN
            IF l_child_list.getLength() = 1 THEN
               EXIT WHILE
            ELSE
               CALL l_child_list.deleteElement(1)
               CONTINUE WHILE
            END IF
         END IF
         
         SELECT DISTINCT xcadstus INTO l_xcadstus FROM xcad_t WHERE xcad001 = l_child_list[1].xcad001 AND xcadent = g_enterprise    #160902-00048#2
         LET g_xcad_m.xcadstus = l_xcadstus
         DISPLAY BY NAME g_xcad_m.xcadstus

         EXECUTE master_getparent_up USING l_child_list[1].xcad002,l_child_list[1].xcad001
                                      INTO l_bstmp.*
         IF SQLCA.sqlcode THEN
            FREE master_getparent_up
            EXIT WHILE
         END IF
         FREE master_getparent_up
      #確定該節點是否存在於temp table中

         IF STATUS = 0 AND axci004_tmp_tbl_chk(l_bstmp.xcad003,ls_code2,l_bstmp.xcad001) THEN
            EXECUTE master_tmp USING l_bstmp.*,ls_code2
            LET l_child_list[l_child_list.getLength()+1].* = l_bstmp.*
         END IF
         CALL l_child_list.deleteElement(1)
      END WHILE

   END FOREACH

   CLOSE master_tmp

END FUNCTION

PRIVATE FUNCTION axci004_tmp_tbl_chk(ps_id,pi_code,ps_type)
   DEFINE ps_id       STRING
   DEFINE pi_code     LIKE type_t.num10
   DEFINE ps_type     STRING
   DEFINE ls_id       LIKE type_t.chr500
   DEFINE ls_search   LIKE type_t.chr500
   DEFINE ls_type     LIKE type_t.chr500
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE li_code     LIKE type_t.num10

   LET ls_id = ps_id
   LET ls_type = ps_type

   IF cl_null(ls_id) THEN
      RETURN TRUE
   END IF

   LET g_sql = " SELECT COUNT(*) FROM axci004_tmp ",
               " WHERE xcad003 = ? AND xcad001 = ? "
   PREPARE axci004_get_cnt FROM g_sql
   EXECUTE axci004_get_cnt USING ls_id ,ls_type INTO li_cnt
   FREE axci004_get_cnt

   IF li_cnt = 0 OR SQLCA.sqlcode THEN
      RETURN TRUE
   ELSE
      #資料已存在, 確定是否需要更新展開值
      LET g_sql = " SELECT exp_code FROM axci004_tmp  ",
                  " WHERE xcad003 = ? AND xcad001 = ? "
      PREPARE axci004_chk_exp FROM g_sql
      EXECUTE axci004_chk_exp USING ls_id ,ls_type INTO li_code
      FREE axci004_chk_exp

      #若新展開值>原展開值則做更新
      IF pi_code > li_code THEN
         LET g_sql = " UPDATE axci004_tmp SET (exp_code) = ('",pi_code,"') ",
                     " WHERE xcad003 = ? "
                      ," AND xcad001 = ? "
         PREPARE axci004_upd_exp FROM g_sql
         EXECUTE axci004_upd_exp USING ls_id ,ls_type
         FREE axci004_upd_exp
      END IF

      RETURN FALSE
   END IF

END FUNCTION

PRIVATE FUNCTION axci004_browser_expand(p_id)
   DEFINE p_id          LIKE type_t.num10
   DEFINE l_id          LIKE type_t.num10
   DEFINE l_cnt         LIKE type_t.num10
   DEFINE l_keyvalue    LIKE type_t.chr50
   DEFINE l_typevalue   LIKE type_t.chr50
   DEFINE l_type        LIKE type_t.chr50
   DEFINE l_sql         LIKE type_t.chr500
   DEFINE ls_source     LIKE type_t.chr500
   DEFINE ls_exp_code   LIKE type_t.chr500
   DEFINE l_return      LIKE type_t.num5
   
   DEFINE pi_id            LIKE type_t.num10
   DEFINE li_lv            LIKE type_t.num10
   DEFINE li_idx           LIKE type_t.num10
   DEFINE ls_wc            STRING
   DEFINE ls_sql           STRING
   DEFINE ls_type_list     STRING
   DEFINE ls_order         STRING
   
   #若已經展開
   IF g_browser[p_id].b_isExp = 1 THEN
      RETURN
   END IF


   #160804-00008#1---add---s
   
   CASE g_browser[p_id].b_expcode 
      WHEN 1   
         LET ls_sql = " SELECT UNIQUE '','','','','','','',t1.xcad001,t1.xcad002,imaal003,imaal004,imaa006,'','','','','','','','','','',t1.xcadsite ",
                      "   FROM xcad_t t1 ",
                      "   LEFT JOIN imaal_t ON imaalent = '"||g_enterprise||"' AND t1.xcad002 = imaal001 AND imaal002 = '",g_dlang,"' ",
                      "   LEFT JOIN imaa_t ON imaaent = '"||g_enterprise||"' AND t1.xcad002 = imaa001 ",
                      "  WHERE t1.xcadent = '" ||g_enterprise|| "'",
                      "    AND t1.xcad001 = '", g_browser[p_id].b_xcad001, "'",
                      "    AND NOT EXISTS(SELECT 1 FROM xcad_t t2 WHERE t1.xcadent = t2.xcadent AND t1.xcad001 = t2.xcad001 AND t1.xcad002 = t2.xcad003)",
                      "  ORDER BY t1.xcad002 "                      
      WHEN 2
         LET ls_sql = " SELECT UNIQUE '','','','FALSE','','','',t1.xcad001,t1.xcad002,a.imaal003,a.imaal004,c.imaa001,t1.xcadseq,t1.xcad003,b.imaal003,b.imaal004,d.imaa006,t1.xcad004,t1.xcad005,t1.xcad006,t1.xcad007,t1.xcad008,t1.xcadsite ",
                      "   FROM xcad_t t1 ",
                      "   LEFT JOIN imaal_t a ON a.imaalent = '"||g_enterprise||"' AND t1.xcad002 = a.imaal001 AND a.imaal002 = '",g_dlang,"' ",
                      "   LEFT JOIN imaal_t b ON b.imaalent = '"||g_enterprise||"' AND t1.xcad003 = b.imaal001 AND b.imaal002 = '",g_dlang,"' ",
                      "   LEFT JOIN imaa_t c ON c.imaaent = '"||g_enterprise||"' AND t1.xcad002 = c.imaa001 ",
                      "   LEFT JOIN imaa_t d ON d.imaaent = '"||g_enterprise||"' AND t1.xcad003 = d.imaa001 ",
                      "  WHERE t1.xcadent = '" ||g_enterprise|| "'",
                      "    AND t1.xcad001 = '", g_browser[p_id].b_xcad001, "'",
                      "    AND t1.xcad002 = '", g_browser[p_id].b_xcad002, "'",
                      "    AND NOT EXISTS(SELECT 1 FROM xcad_t t2 WHERE t1.xcadent = t2.xcadent AND t1.xcad001 = t2.xcad001 AND t1.xcad002 = t2.xcad003)",
                      "  ORDER BY t1.xcad002,t1.xcadseq "        
      WHEN 3   
         LET ls_sql = " SELECT UNIQUE '','','','FALSE','','','',t1.xcad001,t1.xcad002,a.imaal003,a.imaal004,c.imaa001,t1.xcadseq,t1.xcad003,b.imaal003,b.imaal004,d.imaa006,t1.xcad004,t1.xcad005,t1.xcad006,t1.xcad007,t1.xcad008,t1.xcadsite ",
                      "   FROM xcad_t t1 ",
                      "   LEFT JOIN imaal_t a ON a.imaalent = '"||g_enterprise||"' AND t1.xcad002 = a.imaal001 AND a.imaal002 = '",g_dlang,"' ",
                      "   LEFT JOIN imaal_t b ON b.imaalent = '"||g_enterprise||"' AND t1.xcad003 = b.imaal001 AND b.imaal002 = '",g_dlang,"' ",
                      "   LEFT JOIN imaa_t c ON c.imaaent = '"||g_enterprise||"' AND t1.xcad002 = c.imaa001 ",
                      "   LEFT JOIN imaa_t d ON d.imaaent = '"||g_enterprise||"' AND t1.xcad003 = d.imaa001 ",                      
                      "  WHERE t1.xcadent = '" ||g_enterprise|| "'",
                      "    AND t1.xcad001 = '", g_browser[p_id].b_xcad001, "'",
                      "    AND t1.xcad002 = '", g_browser[p_id].b_xcad003, "'",
                      "    AND EXISTS(SELECT 1 FROM xcad_t t2 WHERE t1.xcadent = t2.xcadent AND t1.xcad001 = t2.xcad001 AND t1.xcad003 <> t2.xcad002)",
                      "  ORDER BY t1.xcad002,t1.xcadseq "   
   END CASE
   PREPARE leaf_pre FROM ls_sql
   DECLARE leaf_cur CURSOR FOR leaf_pre
   
   LET g_cnt = p_id + 1
   CALL g_browser.insertElement(g_cnt)
   FOREACH leaf_cur INTO g_browser[g_cnt].*
      LET g_browser[g_cnt].b_pid     = g_browser[p_id].b_id 
      LET g_browser[g_cnt].b_id      = g_browser[p_id].b_id , ".", g_cnt USING "<<<"
      LET g_browser[g_cnt].b_exp     = FALSE
      IF g_browser[p_id].b_expcode = 1 THEN  
         LET g_browser[g_cnt].b_expcode = 2         
         LET g_browser[g_cnt].b_show = g_browser[g_cnt].b_xcad002
         LET g_browser[g_cnt].b_xcad003 = g_browser[g_cnt].b_xcad002          
      ELSE
         LET g_browser[g_cnt].b_expcode = 3
         LET g_browser[g_cnt].b_show = g_browser[g_cnt].b_xcad003
         LET g_browser[g_cnt].b_xcad002_desc = g_browser[g_cnt].b_xcad003_desc
         LET g_browser[g_cnt].b_xcad002_desc_desc = g_browser[g_cnt].b_xcad003_desc_desc 
         LET g_browser[g_cnt].b_imaa006_desc_1 = g_browser[g_cnt].b_imaa006_desc_2        
      END IF         
      LET g_browser[g_cnt].b_hasC    = axci004_chk_hasC(g_cnt)     
      LET g_cnt = g_cnt + 1
      CALL g_browser.insertElement(g_cnt)
   END FOREACH
   
   CALL g_browser.deleteElement(g_cnt)
   
   LET g_browser_cnt = g_browser.getLength()
 
   #瀏覽頁筆數顯示
   DISPLAY g_browser_cnt TO FORMONLY.b_count        #總筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count        #總筆數
   #160804-00008#1---add---e
   
   #160804-00008#1---mark---s
   #LET l_return = FALSE
   #
   #LET l_keyvalue = g_browser[p_id].b_xcad003
   #LET l_typevalue = g_browser[p_id].b_xcad001
   #
   #CASE g_browser[p_id].b_expcode
   #   WHEN -1
   #      CALL g_browser.deleteElement(p_id)
   #   WHEN 0
   #      RETURN
   #   WHEN 1
   #      LET ls_source = "axci004_tmp"
   #      LET ls_exp_code = "exp_code"
   #   WHEN 2
   #      LET ls_source = "xcad_t"
   #      LET ls_exp_code = "'2'"
   #END CASE
   #
   #LET l_sql = " SELECT UNIQUE '','','','FALSE','','',",ls_exp_code,",xcad001,xcad002,'','','',xcadseq,xcad003,'','','',xcad004,xcad005,xcad006,xcad007,xcad008,xcadsite",
   #            " FROM   ",ls_source,
   #            " WHERE  xcad002 = '", l_keyvalue,"'",
   #            #"  AND   xcad003 <> xcad002",
   #            " AND  xcad001 = '", l_typevalue,"'",
   #            " ORDER BY xcad003"
   #
   #PREPARE tree_expand FROM l_sql
   #DECLARE tree_ex_cur CURSOR FOR tree_expand
   #
   #LET l_id = p_id + 1
   #CALL g_browser.insertElement(l_id)
   #LET l_cnt = 1
   #FOREACH tree_ex_cur INTO g_browser[l_id].*
   #
   #   #帶出品名单位
   #   SELECT imaa006 INTO g_browser[l_id].b_imaa006_desc_1
   #     FROM imaa_t
   #    WHERE imaa001 = g_browser[l_id].b_xcad003
   #      AND imaaent = g_enterprise
   #
   #   CALL s_desc_get_item_desc(g_browser[l_id].b_xcad003) RETURNING g_browser[l_id].b_xcad002_desc,g_browser[l_id].b_xcad002_desc_desc
   #
   #   #pid=父節點id
   #   LET g_browser[l_id].b_pid  = g_browser[p_id].b_id
   #   #id=本身節點id(採流水號遞增)
   #   LET g_browser[l_id].b_id   = g_browser[p_id].b_id||"."||l_cnt
   #   #hasC=確認該節點是否有子孫
   #   #LET g_browser[l_id].b_xcad003 = g_browser[l_id].b_xcad003 CLIPPED
   #   CALL axci004_desc_show(l_id)
   #   LET g_browser[l_id].b_hasC = axci004_chk_hasC(l_id)
   #   LET l_id = l_id + 1
   #   CALL g_browser.insertElement(l_id)
   #   LET l_cnt = l_cnt + 1
   #
   #   LET l_return = TRUE
   #END FOREACH
   #
   ##刪除空資料
   #CALL g_browser.deleteElement(l_id)
   #160804-00008#1---mark---s
END FUNCTION

PRIVATE FUNCTION axci004_browser_create(p_type)
   {<Local define>}
   DEFINE p_type   LIKE type_t.chr50
   DEFINE l_pid    LIKE type_t.chr50
   DEFINE l_pid_t  LIKE type_t.chr50
   {</Local define>}
   #add-point:browser_create
   DEFINE l_xcadsite LIKE xcad_t.xcadsite
   DEFINE l_xcad001  LIKE xcad_t.xcad001
   DEFINE l_xcadsite_desc LIKE type_t.chr80
   DEFINE l_ac1 LIKE type_t.num10  #161108-00012#4 num5==》num10
   #end add-point
#160804-00008#1---mark---s
#   CALL g_browser.clear()
#
#   #先找出所有的版本資料
#   LET g_sql = " SELECT UNIQUE xcad001 FROM axci004_tmp ORDER BY xcad001"
#   PREPARE master_type FROM g_sql
#   DECLARE master_typecur CURSOR FOR master_type
#
#   INITIALIZE g_browser_root TO NULL
#
#   LET l_ac = 1
#   LET g_cnt = 1
#   FOREACH master_typecur INTO g_browser[l_ac].b_xcad001
#      #確定root節點所在
#      LET g_browser_root[g_browser_root.getLength()+1] = l_ac
#      #此處為版本部分(LV-1)
#      LET g_browser[l_ac].b_xcad003  = g_browser[l_ac].b_xcad001
#      LET g_browser[l_ac].b_xcad002  = g_browser[l_ac].b_xcad001
#      LET g_browser[l_ac].b_xcad001 = g_browser[l_ac].b_xcad001
#      LET l_xcad001 = g_browser[l_ac].b_xcad001
#      LET g_browser[l_ac].b_pid = '0' CLIPPED
#      LET g_browser[l_ac].b_id = l_ac USING "<<<"
#      LET g_browser[l_ac].b_exp = FALSE
#      LET g_browser[l_ac].b_hasC = TRUE
#      LET l_pid = g_browser[l_ac].b_id CLIPPED
#      LET l_ac = l_ac + 1
#
#      #抓出LV2的所有資料
#      LET g_sql = "SELECT UNIQUE xcad002 FROM axci004_tmp a", 
#                  " WHERE a.xcad001 = ? ",
#                  "   AND (( SELECT COUNT(*) FROM axci004_tmp b WHERE a.xcad002=b.xcad003 AND a.xcad001=b.xcad001) = 0 ",
#                  "        OR a.xcad003 = a.xcad002 )",
#                  " ORDER BY a.xcad002"
#      PREPARE master_getLV2 FROM g_sql
#      DECLARE master_getLV2cur CURSOR FOR master_getLV2
#
#      #以下為一般資料root(LV-2)
#      OPEN master_getLV2cur USING g_browser[l_ac-1].b_xcad001
#
#      LET g_cnt = l_ac
#
#      FOREACH master_getLV2cur INTO g_browser[g_cnt].b_xcad002 
#         #帶出品名单位
#         SELECT imaa006 INTO g_browser[g_cnt].b_imaa006_desc_1
#           FROM imaa_t
#          WHERE imaa001 = g_browser[g_cnt].b_xcad002
#            AND imaaent = g_enterprise
#         
#         CALL s_desc_get_item_desc(g_browser[g_cnt].b_xcad002) RETURNING g_browser[g_cnt].b_xcad002_desc,g_browser[g_cnt].b_xcad002_desc_desc
#                     
#         #去除多餘空白
#         LET g_browser[g_cnt].b_xcad003 = g_browser[g_cnt].b_xcad002 
#         LET g_browser[g_cnt].b_xcad001 = g_browser[l_ac-1].b_xcad001
#         LET g_browser[g_cnt].b_pid = l_pid
#         LET l_pid_t = l_pid
#         LET g_browser[g_cnt].b_id = l_pid,".",g_cnt USING "<<<"
#         LET g_browser[g_cnt].b_exp = FALSE
#         IF g_wc2 <> " 1=1 "  THEN
#            LET g_browser[g_cnt].b_expcode = 1
#         ELSE
#            LET g_browser[g_cnt].b_expcode = 2
#         END IF
#         LET l_pid = g_browser[g_cnt].b_id CLIPPED
#         IF cl_null('xcad002') THEN
#            LET g_browser[g_cnt].b_hasC = FALSE
#         ELSE
#            LET g_browser[g_cnt].b_hasC = TRUE
#         END IF
#         IF g_browser[g_cnt].b_hasC = 1 THEN
#            CALL axci004_browser_expand(g_cnt)
#            LET g_browser[g_cnt].b_isExp = 1
#            LET g_cnt = g_browser.getLength()
#         END IF
#         
#         LET l_pid = l_pid_t
#         LET g_cnt = g_cnt + 1
#   
#      END FOREACH
#      LET l_ac = g_browser.getLength()
#
#   END FOREACH
#
#   #組合描述欄位&刪除多於資料
#   FOR l_ac = 1 TO g_browser.getLength()
#      IF cl_null(g_browser[l_ac].b_xcad003) THEN
#         CALL g_browser.deleteElement(l_ac)
#         LET l_ac = l_ac - 1
#         EXIT FOR
#      ELSE
#         CALL axci004_desc_show(l_ac)
#      END IF
#   END FOR
#   CALL g_browser.deleteElement(l_ac+1)
#
#   LET g_browser_cnt = g_browser.getLength() - g_browser_root.getLength()
#
#   FREE tree_expand
#   FREE master_getLV2
#160804-00008#1---mark---e
END FUNCTION

PRIVATE FUNCTION axci004_desc_show(pi_ac)
   DEFINE pi_ac   LIKE type_t.num10  #161108-00012#4 num5==》num10
   DEFINE li_tmp  LIKE type_t.num10  #161108-00012#4 num5==》num10
   
   LET li_tmp = l_ac
   LET l_ac = pi_ac

   #add-point:browser_create段desc處理 
   #LET g_browser[l_ac].b_show = g_browser[l_ac].b_xcad003  #160804-00008#1---mark
   #end add-point

   LET l_ac = li_tmp

END FUNCTION

PRIVATE FUNCTION axci004_find_node(pi_ac)
   DEFINE pi_ac   LIKE type_t.num10  #161108-00012#4 num5==》num10
   DEFINE li_idx  LIKE type_t.num10  #161108-00012#4 num5==》num10
   DEFINE li_tmp  LIKE type_t.num10  #161108-00012#4 num5==》num10
   DEFINE ls_pid  STRING
#160804-00008#1---mark---s
#   LET ls_pid = g_browser[pi_ac].b_pid
#
#   LET g_sql = " SELECT UNIQUE '','','','FALSE','','',exp_code,xcad001,xcad002,'','','',xcadseq,xcad003,'','','',xcad004,xcad005,xcad006,xcad007,xcad008,xcadsite ",
#               " FROM axci004_tmp ",
#               " WHERE xcad002 = ? AND xcad002 <> xcad003",
#               " ORDER BY xcad003"
#   PREPARE master_getNode FROM g_sql
#   DECLARE master_getNodecur CURSOR FOR master_getNode
#
#   LET li_idx = pi_ac
#   WHILE li_idx <= g_browser.getLength()
#      IF g_browser[li_idx].b_expcode = -1 THEN
#         OPEN master_getNodecur USING g_browser[li_idx].b_xcad003
#         FOREACH master_getNodecur INTO g_browser[g_browser.getLength()+1].*
#            CALL axci004_desc_show(g_browser.getLength())
#            LET g_browser[g_browser.getLength()].b_pid = ls_pid
#            LET g_browser[g_browser.getLength()].b_id = g_browser.getLength()
#            LET g_browser[g_browser.getLength()].b_hasC = axci004_chk_hasC(g_browser.getLength())
#         END FOREACH
#         CALL g_browser.deleteElement(li_idx)
#         CALL g_browser.deleteElement(g_browser.getLength())
#      ELSE
#         LET li_idx = li_idx + 1
#      END IF
#
#   END WHILE
#
#   FREE master_getNode
#
#   RETURN g_browser.getLength()
#160804-00008#1---mark---e
END FUNCTION

PRIVATE FUNCTION axci004_chk_hasC(pi_id)
   DEFINE pi_id    INTEGER
   DEFINE li_cnt   INTEGER

#160804-00008#1---mark---s
#   LET g_sql = "SELECT COUNT(xcad002) FROM axci004_tmp ",
#               " WHERE xcad002 = ? AND exp_code <> '-1' AND xcad003 <> xcad002 AND xcad001 = ?"
#   PREPARE axci004_temp_chk FROM g_sql
#
#   LET g_sql = "SELECT COUNT(*) FROM xcad_t ",
#               " WHERE xcadent = '" ||g_enterprise|| "' AND xcad003 <> xcad002 AND xcad002 = ? AND xcad001 = ?"
#   PREPARE axci004_master_chk FROM g_sql
#
#   CASE g_browser[pi_id].b_expcode
#      WHEN -1
#         RETURN FALSE
#      WHEN 0
#         RETURN FALSE
#      WHEN 1
#         EXECUTE axci004_temp_chk
#           USING g_browser[pi_id].b_xcad003
#                 ,g_browser[pi_id].b_xcad001
#            INTO li_cnt
#         FREE axci004_temp_chk
#      WHEN 2
#         EXECUTE axci004_master_chk
#           USING g_browser[pi_id].b_xcad003
#                 ,g_browser[pi_id].b_xcad001
#            INTO li_cnt
#         FREE axci004_master_chk
#   END CASE
#160804-00008#1---mark---e
   #160804-00008#1---mark---s
   IF g_browser[pi_id].b_expcode = 2 THEN
         LET g_sql = "SELECT COUNT(*) FROM xcad_t ",
                     " WHERE xcadent = '" ||g_enterprise|| "' AND xcad002 = ? AND xcad001 = ?"      
   ELSE
         LET g_sql = "SELECT COUNT(*) FROM xcad_t ",
                     " WHERE xcadent = '" ||g_enterprise|| "' AND xcad003 <> xcad002 AND xcad002 = ? AND xcad001 = ?"      
   END IF   
   PREPARE axci004_master_chk FROM g_sql
   IF g_browser[pi_id].b_expcode = 2 THEN
      EXECUTE axci004_master_chk   
        USING g_browser[pi_id].b_xcad002,g_browser[pi_id].b_xcad001
         INTO li_cnt     
   ELSE
      EXECUTE axci004_master_chk   
        USING g_browser[pi_id].b_xcad003,g_browser[pi_id].b_xcad001
         INTO li_cnt     
   END IF   
   FREE axci004_master_chk   
   #160804-00008#1---mark---e
   IF li_cnt > 0 THEN
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF

END FUNCTION

PRIVATE FUNCTION axci004_construct()
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING    
 
   #清除畫面上相關資料
   CLEAR FORM                 
   INITIALIZE g_xcad_m.* TO NULL
   CALL g_xcad_d.clear()
   CALL g_xcad2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xcad001,xcad002,#imaa006_desc_1,imaal003_desc_1,imaal004_desc_1
                                xcadstus
 
         BEFORE CONSTRUCT

         ON ACTION controlp INFIELD xcad001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcad001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcad001  #顯示到畫面上
            NEXT FIELD xcad001                     #返回原欄位

         ON ACTION controlp INFIELD xcad002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcad002  #顯示到畫面上
            NEXT FIELD xcad002                     #返回原欄位

         #ON ACTION controlp INFIELD imaa006_desc_1
         #   INITIALIZE g_qryparam.* TO NULL
         #   LET g_qryparam.state = 'c'
         #   LET g_qryparam.reqry = FALSE
         #   CALL q_ooca001_1()                           #呼叫開窗
         #   DISPLAY g_qryparam.return1 TO imaa006_desc_1  #顯示到畫面上
         #   NEXT FIELD imaa006_desc_1                     #返回原欄位
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON xcadseq,xcad003,xcad004,xcad005,xcad006,xcad007,xcad008,
                                xcad009,xcad010,xcad011,xcad012,xcad013,
                                xcadownid,xcadowndp,xcadcrtid,xcadcrtdp,xcadcrtdt,xcadmodid,xcadmoddt
           FROM s_detail1[1].xcadseq,s_detail1[1].xcad003,s_detail1[1].xcad004,s_detail1[1].xcad005,s_detail1[1].xcad006, 
               s_detail1[1].xcad007,s_detail1[1].xcad008,
               s_detail1[1].xcad009,s_detail1[1].xcad010,
               s_detail1[1].xcad011,s_detail1[1].xcad012,s_detail1[1].xcad013,
               s_detail2[1].xcadownid,s_detail2[1].xcadowndp, 
               s_detail2[1].xcadcrtid,s_detail2[1].xcadcrtdp,s_detail2[1].xcadcrtdt,s_detail2[1].xcadmodid, 
               s_detail2[1].xcadmoddt
                      
         BEFORE CONSTRUCT

            
         #單身公用欄位開窗相關處理
         #此段落由子樣板a11產生
         ##----<<xcadownid>>----
         #ON ACTION controlp INFIELD xcadownid
         #   CALL q_common('xcad_t','xcadownid',TRUE,FALSE,g_xcad2_d[1].xcadownid) RETURNING ls_return
         #   DISPLAY ls_return TO xcadownid
         #   NEXT FIELD xcadownid  
         #
         ##----<<xcadowndp>>----
         #ON ACTION controlp INFIELD xcadowndp
         #   CALL q_common('xcad_t','xcadowndp',TRUE,FALSE,g_xcad2_d[1].xcadowndp) RETURNING ls_return
         #   DISPLAY ls_return TO xcadowndp
         #   NEXT FIELD xcadowndp
         #
         ##----<<xcadcrtid>>----
         #ON ACTION controlp INFIELD xcadcrtid
         #   CALL q_common('xcad_t','xcadcrtid',TRUE,FALSE,g_xcad2_d[1].xcadcrtid) RETURNING ls_return
         #   DISPLAY ls_return TO xcadcrtid
         #   NEXT FIELD xcadcrtid
         #
         ##----<<xcadcrtdp>>----
         #ON ACTION controlp INFIELD xcadcrtdp
         #   CALL q_common('xcad_t','xcadcrtdp',TRUE,FALSE,g_xcad2_d[1].xcadcrtdp) RETURNING ls_return
         #   DISPLAY ls_return TO xcadcrtdp
         #   NEXT FIELD xcadcrtdp
         #
         ##----<<xcadmodid>>----
         #ON ACTION controlp INFIELD xcadmodid
         #   CALL q_common('xcad_t','xcadmodid',TRUE,FALSE,g_xcad2_d[1].xcadmodid) RETURNING ls_return
         #   DISPLAY ls_return TO xcadmodid
         #   NEXT FIELD xcadmodid
         #
         ##----<<xcadcnfid>>----
         ##ON ACTION controlp INFIELD xcadcnfid
         ##   CALL q_common('xcad_t','xcadcnfid',TRUE,FALSE,.xcadcnfid) RETURNING ls_return
         ##   DISPLAY ls_return TO xcadcnfid
         ##   NEXT FIELD xcadcnfid
         #
         ##----<<xcadpstid>>----
         ##ON ACTION controlp INFIELD xcadpstid
         ##   CALL q_common('xcad_t','xcadpstid',TRUE,FALSE,.xcadpstid) RETURNING ls_return
         ##   DISPLAY ls_return TO xcadpstid
         ##   NEXT FIELD xcadpstid
         
         ##----<<xcadcrtdt>>----
         AFTER FIELD xcadcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xcadmoddt>>----
         AFTER FIELD xcadmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xcadcnfdt>>----
         #AFTER FIELD xcadcnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xcadpstdt>>----
         #AFTER FIELD xcadpstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 

         ON ACTION controlp INFIELD xcad003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcad003  #顯示到畫面上
            NEXT FIELD xcad003                     #返回原欄位

         ON ACTION controlp INFIELD xcad009
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "221" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcad009  #顯示到畫面上
            NEXT FIELD xcad009                     #返回原欄位

         ON ACTION controlp INFIELD xcad011
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "215" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcad011  #顯示到畫面上
            NEXT FIELD xcad011                    #返回原欄位
       
      END CONSTRUCT
 
      BEFORE DIALOG
         CALL cl_qbe_init()
      
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
    
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

   LET g_current_row = 1

   IF INT_FLAG THEN
      RETURN
   END IF
   
   LET g_wc_filter = ""

END FUNCTION

PRIVATE FUNCTION axci004_query()
   DEFINE ls_wc STRING

   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF

   LET INT_FLAG = 0
   LET ls_wc = g_wc

   #CLEAR FORM
   #CALL g_browser.clear()

   DISPLAY ' ' TO FORMONLY.b_count

   CALL axci004_construct()

   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      #CALL axci004_browser_fill(g_wc,g_searchtype)
      CALL axci004_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_browser_cnt = 0
      LET g_current_idx = 1
      CALL g_browser.clear()
      CALL g_browser_expand.clear()   #160804-00008#1
   END IF

   LET g_searchtype = "3"
   LET g_searchcol = "0"
   CALL axci004_browser_fill(g_wc,g_searchtype)

   #第一層模糊搜尋
   IF g_browser_cnt = 0 THEN
      LET g_wc = cl_wc_parser(g_wc)
      CALL axci004_browser_fill(g_wc,g_searchtype)
   END IF

   #第二層速記碼搜尋
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = '-100'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF

END FUNCTION

PRIVATE FUNCTION axci004_insert()

   #清除相關資料
   CLEAR FORM                    
   CALL g_xcad_d.clear()

   INITIALIZE g_xcad_m.* LIKE xcad_t.*             #DEFAULT 設定
   LET g_xcad001_t = NULL
   LET g_xcad002_t = NULL

   CALL s_transaction_begin()
   WHILE TRUE
      #單頭預設值
      #LET g_xcad_m.xcadownid = g_user
      #LET g_xcad_m.xcadowndp = g_dept
      #LET g_xcad_m.xcadcrtid = g_user
      #LET g_xcad_m.xcadcrtdp = g_dept
      #LET g_xcad_m.xcadcrtdt = cl_get_current()
      #LET g_xcad_m.xcadmodid = g_user
      #LET g_xcad_m.xcadmoddt = cl_get_current()
      LET g_xcad_m.xcadstus = "N"
      LET g_xcad_m_t.* = g_xcad_m.*
 
      CALL axci004_input("a")
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_xcad_m.* = g_xcad_m_t.*
         CALL axci004_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         EXIT WHILE
      END IF
      
      CALL g_xcad_d.clear()

      #add-point:單頭輸入後2
      #end add-point

      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   CALL s_transaction_end('Y','0')
   LET g_state = "Y"
   
   LET g_xcad001_t = g_xcad_m.xcad001
   LET g_xcad002_t = g_xcad_m.xcad002

   LET g_wc = g_wc,  
              " OR ( xcadent = '" ||g_enterprise|| "' AND ",
              " xcad001 = '", g_xcad_m.xcad001 CLIPPED, "' "
              ," AND xcad002 = '", g_xcad_m.xcad002 CLIPPED, "' "
              , ") "
END FUNCTION

PRIVATE FUNCTION axci004_fetch(p_flag)
   {<Local define>}
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   DEFINE ls_chk     STRING
   DEFINE li_idx     LIKE type_t.num10  #161108-00012#4 num5==》num10
   DEFINE l_xcadstus LIKE xcad_t.xcadstus
   DEFINE l_xcadsite LIKE xcad_t.xcadsite
   {</Local define>}
   #add-point:fetch段define
   DEFINE l_status   LIKE xcad_t.xcadstus
   #end add-point

   LET ls_chk = g_browser[g_current_idx].b_id
   SELECT unique xcadstus INTO l_status FROM xcad_t WHERE xcadent = g_enterprise AND xcad001 = g_browser[g_current_idx].b_xcad001
   CASE l_status
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
   END CASE
   IF ls_chk.getIndexOf('.',1) = 0 THEN
      #让根节点审核按钮可用
      SELECT distinct xcadstus,xcadsite into l_xcadstus,l_xcadsite from xcad_t where xcad001 = g_browser[g_current_idx].b_xcad001
      INITIALIZE g_xcad_m.* TO NULL
      DISPLAY BY NAME g_xcad_m.*
      CALL g_xcad_d.clear()
      CALL cl_set_act_visible("statechange", TRUE)
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
      DISPLAY '' TO FORMONLY.b_index
      LET g_xcad_m.xcadstus = l_xcadstus
      DISPLAY BY NAME g_xcad_m.xcadstus
      RETURN
   ELSE
      #CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)  #每層都可以審核
   END IF

   #瀏覽頁筆數顯示
   LET li_idx = 1
   FOR li_idx = 1 TO g_browser_root.getLength()
      IF g_browser_root[li_idx] > g_current_idx THEN
       EXIT FOR
      END IF
   END FOR
   LET li_idx = g_current_idx - li_idx + 1
   DISPLAY li_idx TO FORMONLY.b_index   #當下筆數

   IF p_flag = '/' THEN
      IF (NOT g_no_ask) THEN
         CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
         LET INT_FLAG = 0

         PROMPT ls_msg CLIPPED,': ' FOR g_jump
            #交談指令共用ACTION
            &include "common_action.4gl"
         END PROMPT

         IF INT_FLAG THEN
            LET INT_FLAG = 0
         ELSE
            IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
               LET g_current_idx = g_jump
            END IF
            LET g_no_ask = FALSE
         END IF
      END IF
   END IF

   #若無資料則離開
   IF g_current_idx = 0 THEN
      RETURN
   END IF
   
   #單身筆數顯示
   DISPLAY g_detail_cnt TO FORMONLY.cnt                      #設定page 總筆數 
   #LET g_detail_idx = 1
   IF g_detail_cnt > 0 THEN
      #LET g_detail_idx = 1
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY ' ' TO FORMONLY.idx    
   END IF

   LET g_xcad_m.xcad002 = g_browser[g_current_idx].b_xcad002
   LET g_xcad_m.xcad001 = g_browser[g_current_idx].b_xcad001


   #重讀DB,因TEMP有不被更新特性
   SELECT UNIQUE xcad001,xcad002,xcadstus
     INTO g_xcad_m.xcad001,g_xcad_m.xcad002,g_xcad_m.xcadstus
     FROM xcad_t
    WHERE xcadent = g_enterprise AND xcad001 = g_xcad_m.xcad001 AND xcad002 = g_browser[g_current_idx].b_xcad003
   DISPLAY g_xcad_m.xcadstus TO xcadstus
   IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = "xcad_t"
       LET g_errparam.popup = FALSE
       CALL cl_err()
       INITIALIZE g_xcad_m.* TO NULL
       CLEAR FORM
       CALL g_xcad_d.clear()
       CALL cl_set_act_visible("statechange", FALSE)
       RETURN
   END IF

   #若無資料則關閉相關功能
   SELECT xcadstus INTO l_status FROM xcad_t WHERE xcadent = g_enterprise AND xcad001 = g_xcad_m.xcad001
   IF l_status = 'Y' THEN
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)
   END IF


   #重新顯示
   CALL axci004_show()
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   DISPLAY g_browser_cnt TO FORMONLY.b_count

END FUNCTION

PRIVATE FUNCTION axci004_modify()

   IF g_xcad_m.xcad001 IS NULL OR g_xcad_m.xcad002 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF
   
   SELECT UNIQUE xcad001,xcad002
     INTO g_xcad_m.xcad001,g_xcad_m.xcad002
     FROM xcad_t
     WHERE xcadent = g_enterprise AND xcad001 = g_xcad_m.xcad001 AND xcad002 = g_xcad_m.xcad002
 
   ERROR ""
  
   LET g_xcad001_t = g_xcad_m.xcad001
   LET g_xcad002_t = g_xcad_m.xcad002

   CALL s_transaction_begin()
   
   OPEN axci004_cl USING g_enterprise,g_xcad_m.xcad001,g_xcad_m.xcad002
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN axci004_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE axci004_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH axci004_cl INTO g_xcad_m.xcad001,g_xcad_m.xcad002,g_xcad_m.imaa006_desc_1,g_xcad_m.imaal003_desc_1,g_xcad_m.imaal004_desc_1,g_xcad_m.xcadstus
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_xcad_m.xcad001
      LET g_errparam.popup = FALSE
      CALL cl_err()
      CLOSE axci004_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   CALL s_transaction_end('Y','0')
 
   CALL axci004_show()
   WHILE TRUE
      LET g_xcad001_t = g_xcad_m.xcad001
      LET g_xcad002_t = g_xcad_m.xcad002
      
      CALL axci004_input("u")     #欄位更改
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_xcad_m.* = g_xcad_m_t.*
         CALL axci004_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更
      IF g_xcad_m.xcad001 != g_xcad001_t OR g_xcad_m.xcad002 != g_xcad002_t  THEN
         CALL s_transaction_begin()

         #更新單頭key值
         UPDATE xcad_t SET xcad001 = g_xcad_m.xcad001,
                           xcad002 = g_xcad_m.xcad002
          WHERE xcadent = g_enterprise AND xcad001 = g_xcad001_t
            AND xcad002 = g_xcad002_t
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "xcad_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "xcad_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE
      END IF
      
      EXIT WHILE
      
   END WHILE
 
   #修改歷程記錄
   IF NOT cl_log_modified_record(g_xcad_m.xcad001,g_site) THEN 
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE axci004_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-U
   CALL cl_flow_notify(g_xcad_m.xcad001,'U')
 
   CALL axci004_b_fill("1=1")
END FUNCTION

PRIVATE FUNCTION axci004_input(p_cmd)
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_ac_t                LIKE type_t.num10                #未取消的ARRAY CNT  #161108-00012#4 num5==》num10
   DEFINE  l_n                   LIKE type_t.num5                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num5                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num5
   DEFINE  l_i                   LIKE type_t.num5
   DEFINE  l_insert              BOOLEAN
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num5
   DEFINE  li_reproduce_target   LIKE type_t.num5
   DEFINE  l_loop                LIKE type_t.chr1 
   #add-point:input段define

   #end add-point    
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF  
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""

   LET g_forupd_sql = "SELECT xcadseq,xcad003,'','','',xcad004,xcad005,xcad006,xcad007,xcad008, ",
                      "       xcad009,'',xcad010,xcad011,'',xcad012,xcad013, ",
                      "       '',xcadownid,'',xcadowndp,'',xcadcrtid,'',xcadcrtdp,'',xcadcrtdt,xcadmodid,'',xcadmoddt ",
                      "  FROM xcad_t ",
                      " WHERE xcadent=? AND xcad001=? AND xcad002=? AND xcadseq=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE axci004_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR

   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axci004_set_entry(p_cmd)
   CALL axci004_set_no_entry(p_cmd)

   DISPLAY BY NAME g_xcad_m.xcad001,g_xcad_m.xcad002,g_xcad_m.imaa006_desc_1,g_xcad_m.imaal003_desc_1, 
       g_xcad_m.imaal004_desc_1,g_xcad_m.xcadstus
   
   LET lb_reproduce = FALSE
   
   #add-point:進入修改段前
   LET g_errshow = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_xcad_m.xcad001,g_xcad_m.xcad002,g_xcad_m.imaa006_desc_1,g_xcad_m.imaal003_desc_1, 
          g_xcad_m.imaal004_desc_1
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            IF l_cmd_t = 'r' THEN
               LET g_xcad_m.xcadstus = 'N'
            END IF

         AFTER FIELD xcad001
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_xcad_m.xcad001) AND NOT cl_null(g_xcad_m.xcad002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcad_m.xcad001 != g_xcad001_t  OR g_xcad_m.xcad002 != g_xcad002_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcad_t WHERE "||"xcadent = '" ||g_enterprise|| "' AND "||"xcad001 = '"||g_xcad_m.xcad001 ||"' AND "|| "xcad002 = '"||g_xcad_m.xcad002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

         AFTER FIELD xcad002
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_xcad_m.xcad001) AND NOT cl_null(g_xcad_m.xcad002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcad_m.xcad001 != g_xcad001_t  OR g_xcad_m.xcad002 != g_xcad002_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcad_t WHERE "||"xcadent = '" ||g_enterprise|| "' AND "||"xcad001 = '"||g_xcad_m.xcad001 ||"' AND "|| "xcad002 = '"||g_xcad_m.xcad002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            CALL axci004_xcad002_get()
            IF NOT cl_null(g_xcad_m.xcad002) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcad_m.xcad002
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_imaa001_6") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_xcad_m.xcad002 = g_xcad_m_t.xcad002
                  CALL axci004_xcad002_get()
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            

         ON ACTION controlp INFIELD xcad001

         ON ACTION controlp INFIELD xcad002
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xcad_m.xcad002             #給予default值
            LET g_qryparam.where = " imaa004 = 'A' "
            CALL q_imaa001_2()                                #呼叫開窗
            LET g_xcad_m.xcad002 = g_qryparam.return1              
            CALL axci004_xcad002_get()
            DISPLAY g_xcad_m.xcad002 TO xcad002              #
            NEXT FIELD xcad002                          #返回原欄位

         ON ACTION controlp INFIELD imaa006_desc_1
            #此段落由子樣板a07產生            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xcad_m.imaa006_desc_1             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "" #
            CALL q_ooca001_1()                                #呼叫開窗
            LET g_xcad_m.imaa006_desc_1 = g_qryparam.return1              
            DISPLAY g_xcad_m.imaa006_desc_1 TO imaa006_desc_1              #
            NEXT FIELD imaa006_desc_1                          #返回原欄位
 
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            
            IF s_transaction_chk("N",0) THEN
                CALL s_transaction_begin()
            END IF
 
            #多語言處理

            CALL cl_showmsg()
            DISPLAY BY NAME g_xcad_m.xcad001,g_xcad_m.xcad002   

            IF p_cmd = 'u' THEN
               UPDATE xcad_t SET (xcad001,xcad002) = (g_xcad_m.xcad001,g_xcad_m.xcad002)
                WHERE xcadent = g_enterprise AND xcad001 = g_xcad001_t
                  AND xcad002 = g_xcad002_t
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "xcad_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "xcad_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                     #資料多語言用-增/改
                     INITIALIZE gs_keys TO NULL 
                     LET gs_keys[1] = g_xcad_m.xcad001
                     LET gs_keys_bak[1] = g_xcad001_t
                     LET gs_keys[2] = g_xcad_m.xcad002
                     LET gs_keys_bak[2] = g_xcad002_t
                     LET gs_keys[3] = g_xcad_d[g_detail_idx].xcadseq
                     LET gs_keys_bak[3] = g_xcad_d_t.xcadseq
                     CALL axci004_update_b('xcad_t',gs_keys,gs_keys_bak,"'1'")
                     LET g_xcad001_t = g_xcad_m.xcad001
                     LET g_xcad002_t = g_xcad_m.xcad002
                     CALL s_transaction_end('Y','0')
               END CASE
            ELSE            
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axci004_detail_reproduce()
               END IF
            END IF
                     
            LET g_xcad001_t = g_xcad_m.xcad001
            LET g_xcad002_t = g_xcad_m.xcad002
            
            #若單身還沒有輸入資料, 強制切換至單身
            IF cl_null(g_xcad_d[1].xcadseq) THEN
               CALL g_xcad_d.deleteElement(1)
               NEXT FIELD xcadseq
            END IF
 
      END INPUT

      #Page1 預設值產生於此處
      INPUT ARRAY g_xcad_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION

         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
               CALL FGL_SET_ARR_CURR(g_xcad_d.getLength()+1) 
               LET g_insert = 'N' 
            END IF 
 
            CALL axci004_b_fill(g_wc2) 
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
         
         BEFORE ROW
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx

            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axci004_cl USING g_enterprise,g_xcad_m.xcad001,g_xcad_m.xcad002                     
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  STATUS
                  LET g_errparam.extend = "OPEN axci004_cl:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CLOSE axci004_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            
            IF g_rec_b >= l_ac  AND g_xcad_d[l_ac].xcadseq IS NOT NULL THEN
               LET l_cmd='u'
               LET g_xcad_d_t.* = g_xcad_d[l_ac].*  #BACKUP
               CALL axci004_set_entry_b(l_cmd)
               CALL axci004_set_no_entry_b(l_cmd)
               OPEN axci004_bcl USING g_enterprise,g_xcad_m.xcad001,g_xcad_m.xcad002,g_xcad_d_t.xcadseq
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  STATUS
                  LET g_errparam.extend = "OPEN axci004_bcl:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axci004_bcl INTO g_xcad_d[l_ac].xcadseq,g_xcad_d[l_ac].xcad003,g_xcad_d[l_ac].imaal003_desc_2,g_xcad_d[l_ac].imaal004_desc_2, 
                      g_xcad_d[l_ac].imaa006_desc_2,g_xcad_d[l_ac].xcad004,g_xcad_d[l_ac].xcad005,g_xcad_d[l_ac].xcad006, 
                      g_xcad_d[l_ac].xcad007,g_xcad_d[l_ac].xcad008, 
                      g_xcad_d[l_ac].xcad009,g_xcad_d[l_ac].xcad009_desc,g_xcad_d[l_ac].xcad010,
                      g_xcad_d[l_ac].xcad011,g_xcad_d[l_ac].xcad011_desc,g_xcad_d[l_ac].xcad012,g_xcad_d[l_ac].xcad013,
                      g_xcad2_d[l_ac].xcadseq,g_xcad2_d[l_ac].xcadownid, 
                      g_xcad2_d[l_ac].xcadownid_desc,g_xcad2_d[l_ac].xcadowndp,g_xcad2_d[l_ac].xcadowndp_desc, 
                      g_xcad2_d[l_ac].xcadcrtid,g_xcad2_d[l_ac].xcadcrtid_desc,g_xcad2_d[l_ac].xcadcrtdp, 
                      g_xcad2_d[l_ac].xcadcrtdp_desc,g_xcad2_d[l_ac].xcadcrtdt,g_xcad2_d[l_ac].xcadmodid, 
                      g_xcad2_d[l_ac].xcadmodid_desc,g_xcad2_d[l_ac].xcadmoddt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = g_xcad_d_t.xcadseq
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            CALL axci004_xcad003_get()
            #end add-point  
            
        
         BEFORE INSERT
            INITIALIZE g_xcad_d_t.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xcad_d[l_ac].* TO NULL
            LET g_xcad_d_t.* = g_xcad_d[l_ac].*     #新輸入資料
            #公用欄位預設值
            #此段落由子樣板a14產生    
            LET g_xcad2_d[l_ac].xcadownid = g_user
            LET g_xcad2_d[l_ac].xcadowndp = g_dept
            LET g_xcad2_d[l_ac].xcadcrtid = g_user
            LET g_xcad2_d[l_ac].xcadcrtdp = g_dept 
            LET g_xcad2_d[l_ac].xcadcrtdt = cl_get_current()
            LET g_xcad2_d[l_ac].xcadmodid = ""
            LET g_xcad2_d[l_ac].xcadmoddt = ""
            ##LET .xcadstus = ""

            #一般欄位預設值
            LET g_xcad_d[l_ac].xcad004 = 1
            LET g_xcad_d[l_ac].xcad005 = 1
            LET g_xcad_d[l_ac].xcad006 = 0
            LET g_xcad_d[l_ac].xcad007 = 0
            LET g_xcad_d[l_ac].xcad008 = 0
            LET g_xcad_d[l_ac].xcad012 = cl_get_current() #生效日期
            
            SELECT MAX(xcadseq) INTO g_xcad_d[l_ac].xcadseq  #项次
              FROM xcad_t
             WHERE xcadent = g_enterprise
               AND xcad001 = g_xcad_m.xcad001
               AND xcad002 = g_xcad_m.xcad002
            IF g_xcad_d[l_ac].xcadseq IS NULL THEN
               LET g_xcad_d[l_ac].xcadseq = 0
            END IF
            LET g_xcad_d[l_ac].xcadseq = g_xcad_d[l_ac].xcadseq + 1

            CALL cl_show_fld_cont()
            CALL axci004_set_entry_b(l_cmd)
            CALL axci004_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xcad_d[li_reproduce_target].* = g_xcad_d[li_reproduce].*
               LET g_xcad2_d[li_reproduce_target].* = g_xcad2_d[li_reproduce].*
               LET g_xcad_d[g_xcad_d.getLength()].xcadseq = NULL
            END IF 
 
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
            SELECT COUNT(*) INTO l_count FROM xcad_t 
             WHERE xcadent = g_enterprise AND xcad001 = g_xcad_m.xcad001
               AND xcad002 = g_xcad_m.xcad002
               AND xcadseq = g_xcad_d[l_ac].xcadseq   
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               INSERT INTO xcad_t
                           (xcadent,xcad001,xcad002,
                            xcadseq,xcad003,xcad004,xcad005,xcad006,xcad007,xcad008,
                            xcad009,xcad010,xcad011,xcad012,xcad013,
                            xcadownid,xcadowndp,xcadcrtid,xcadcrtdp,xcadcrtdt,xcadmodid,xcadmoddt,xcadstus) 
                     VALUES(g_enterprise,g_xcad_m.xcad001,g_xcad_m.xcad002,
                            g_xcad_d[l_ac].xcadseq,g_xcad_d[l_ac].xcad003,g_xcad_d[l_ac].xcad004,
                            g_xcad_d[l_ac].xcad005,g_xcad_d[l_ac].xcad006,g_xcad_d[l_ac].xcad007,g_xcad_d[l_ac].xcad008,
                            g_xcad_d[l_ac].xcad009,g_xcad_d[l_ac].xcad010,g_xcad_d[l_ac].xcad011,
                            g_xcad_d[l_ac].xcad012,g_xcad_d[l_ac].xcad013,
                            g_xcad2_d[l_ac].xcadownid,g_xcad2_d[l_ac].xcadowndp, 
                            g_xcad2_d[l_ac].xcadcrtid,g_xcad2_d[l_ac].xcadcrtdp,g_xcad2_d[l_ac].xcadcrtdt, 
                            g_xcad2_d[l_ac].xcadmodid,g_xcad2_d[l_ac].xcadmoddt,g_xcad_m.xcadstus)
               LET p_cmd = 'u'
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_xcad_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "xcad_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #資料多語言用-增/改
               CALL s_transaction_end('Y','0')
               ERROR "INSERT O.K"
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cnt
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_xcad_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_xcad_d.deleteElement(l_ac)
               NEXT FIELD xcadseq
            END IF
            IF g_xcad_d_t.xcadseq IS NOT NULL THEN
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
               IF axci004_before_delete() THEN 
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axci004_bcl
               LET l_count = g_xcad_d.getLength()
            END IF 
              
         AFTER DELETE 

 
         BEFORE FIELD xcadseq
         
         AFTER FIELD xcadseq
            IF  g_xcad_m.xcad001 IS NOT NULL AND g_xcad_m.xcad002 IS NOT NULL AND g_xcad_d[g_detail_idx].xcadseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcad_m.xcad001 != g_xcad001_t OR g_xcad_m.xcad002 != g_xcad002_t OR g_xcad_d[g_detail_idx].xcadseq != g_xcad_d_t.xcadseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcad_t WHERE "||"xcadent = '" ||g_enterprise|| "' AND "||"xcad001 = '"||g_xcad_m.xcad001 ||"' AND "|| "xcad002 = '"||g_xcad_m.xcad002 ||"' AND "|| "xcadseq = '"||g_xcad_d[g_detail_idx].xcadseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

         AFTER FIELD xcad003
            #此段落由子樣板a05產生
            IF  g_xcad_m.xcad001 IS NOT NULL AND g_xcad_m.xcad002 IS NOT NULL AND g_xcad_d[g_detail_idx].xcad003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcad_m.xcad001 != g_xcad001_t OR g_xcad_m.xcad002 != g_xcad002_t OR g_xcad_d[g_detail_idx].xcad003 != g_xcad_d_t.xcad003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcad_t WHERE "||"xcadent = '" ||g_enterprise|| "' AND "||"xcad001 = '"||g_xcad_m.xcad001 ||"' AND "|| "xcad002 = '"||g_xcad_m.xcad002 ||"' AND "|| "xcad003 = '"||g_xcad_d[g_detail_idx].xcad003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_xcad_d[l_ac].xcad003) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcad_d[l_ac].xcad003
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_imaa001") THEN
                  #檢查成功時後續處理
                  ##檢查是否為無窮迴圈
                  CALL axci004_tree_loop_chk(g_xcad_m.xcad002,g_xcad_d[l_ac].xcad003,NULL) RETURNING l_loop  
                  IF l_loop = "Y" THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axc-00026'
                     LET g_errparam.extend = g_xcad_d[l_ac].xcad003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_xcad_d[l_ac].xcad003 = g_xcad_d_t.xcad003
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_xcad_d[l_ac].xcad003 = g_xcad_d_t.xcad003
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL axci004_xcad003_get()

         AFTER FIELD xcad004

         AFTER FIELD xcad005

         AFTER FIELD xcad006

         AFTER FIELD xcad007

         AFTER FIELD xcad008

         AFTER FIELD xcad009
            IF NOT cl_null(g_xcad_d[l_ac].xcad009) THEN
               #检查是否存在作业档
               SELECT * FROM oocq_t
                WHERE oocqent = g_enterprise
                  AND oocq001 = '221'
                  AND oocq002 = g_xcad_d[l_ac].xcad009
                  AND oocqstus= 'Y'
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abm-00040'
                  LET g_errparam.extend = g_xcad_d[l_ac].xcad009
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_xcad_d[l_ac].xcad009 = g_xcad_d_t.xcad009
                  NEXT FIELD CURRENT
               END IF
            END IF
            
            CALL s_desc_get_acc_desc('221',g_xcad_d[l_ac].xcad009) RETURNING g_xcad_d[l_ac].xcad009_desc
            DISPLAY g_xcad_d[l_ac].xcad009_desc to xcad009_desc
            
         AFTER FIELD xcad010
         AFTER FIELD xcad011
            IF NOT cl_null(g_xcad_d[l_ac].xcad011) THEN
               #检查是否存在部位档
               SELECT * FROM oocq_t
                WHERE oocqent = g_enterprise
                  AND oocq001 = '215'
                  AND oocq002 = g_xcad_d[l_ac].xcad011
                  AND oocqstus= 'Y'
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abm-00039'
                  LET g_errparam.extend = g_xcad_d[l_ac].xcad011
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_xcad_d[l_ac].xcad011 = g_xcad_d_t.xcad011
                  NEXT FIELD CURRENT
               END IF
            END IF
            
            CALL s_desc_get_acc_desc('215',g_xcad_d[l_ac].xcad011) RETURNING g_xcad_d[l_ac].xcad011_desc
            DISPLAY g_xcad_d[l_ac].xcad011_desc to xcad011_desc
            
         AFTER FIELD xcad012
            IF NOT cl_null (g_xcad_d[l_ac].xcad012) THEN
               IF NOT cl_null(g_xcad_d[l_ac].xcad013) THEN
                  IF g_xcad_d[l_ac].xcad012 >= g_xcad_d[l_ac].xcad013 THEN
                     #生效日期不可大于或等于失效日期！
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aoo-00122'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
         
         AFTER FIELD xcad013
            IF NOT cl_null (g_xcad_d[l_ac].xcad012) AND NOT cl_null(g_xcad_d[l_ac].xcad013) THEN
               IF g_xcad_d[l_ac].xcad012 >= g_xcad_d[l_ac].xcad013 THEN
                  #生效日期不可大于或等于失效日期！
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00122'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF

         ON ACTION controlp INFIELD xcad003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xcad_d[l_ac].xcad003             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "" #
            CALL q_imaa001_2()                                #呼叫開窗
            LET g_xcad_d[l_ac].xcad003 = g_qryparam.return1              
            CALL axci004_xcad003_get()
            DISPLAY g_xcad_d[l_ac].xcad003 TO xcad003              #
            NEXT FIELD xcad003                          #返回原欄位

         ON ACTION controlp INFIELD xcad009
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xcad_d[l_ac].xcad009       #給予default值
            #給予arg
            LET g_qryparam.arg1 = "221" #應用分類
            CALL q_oocq002()                                #呼叫開窗
            LET g_xcad_d[l_ac].xcad009 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_xcad_d[l_ac].xcad009 TO xcad009              #顯示到畫面上

            CALL s_desc_get_acc_desc('221',g_xcad_d[l_ac].xcad009) RETURNING g_xcad_d[l_ac].xcad009_desc
            DISPLAY g_xcad_d[l_ac].xcad009_desc to xcad009_desc
            
            NEXT FIELD xcad009                          #返回原欄位
            
         ON ACTION controlp INFIELD xcad011
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xcad_d[l_ac].xcad011       #給予default值
            #給予arg
            LET g_qryparam.arg1 = "215" #應用分類
            CALL q_oocq002()                                #呼叫開窗
            LET g_xcad_d[l_ac].xcad011 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_xcad_d[l_ac].xcad011 TO xcad011              #顯示到畫面上

            CALL s_desc_get_acc_desc('215',g_xcad_d[l_ac].xcad011) RETURNING g_xcad_d[l_ac].xcad011_desc
            DISPLAY g_xcad_d[l_ac].xcad011_desc to xcad011_desc
            
            NEXT FIELD xcad011                          #返回原欄位
            
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_xcad_d[l_ac].* = g_xcad_d_t.*
               CLOSE axci004_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_xcad_d[l_ac].xcadseq
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_xcad_d[l_ac].* = g_xcad_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_xcad2_d[l_ac].xcadmodid = g_user 
               LET g_xcad2_d[l_ac].xcadmoddt = cl_get_current()
               UPDATE xcad_t SET (xcad001,xcad002,xcadseq,xcad003,xcad004,xcad005,xcad006,xcad007,xcad008,xcadownid, 
                   xcadowndp,xcadcrtid,xcadcrtdp,xcadcrtdt,xcadmodid,xcadmoddt) = (g_xcad_m.xcad001, 
                   g_xcad_m.xcad002,g_xcad_d[l_ac].xcadseq,g_xcad_d[l_ac].xcad003,g_xcad_d[l_ac].xcad004,g_xcad_d[l_ac].xcad005, 
                   g_xcad_d[l_ac].xcad006,g_xcad_d[l_ac].xcad007,g_xcad_d[l_ac].xcad008,g_xcad2_d[l_ac].xcadownid, 
                   g_xcad2_d[l_ac].xcadowndp,g_xcad2_d[l_ac].xcadcrtid,g_xcad2_d[l_ac].xcadcrtdp,g_xcad2_d[l_ac].xcadcrtdt, 
                   g_xcad2_d[l_ac].xcadmodid,g_xcad2_d[l_ac].xcadmoddt)
                WHERE xcadent = g_enterprise AND xcad001 = g_xcad_m.xcad001 
                 AND xcad002 = g_xcad_m.xcad002 
                 AND xcadseq = g_xcad_d_t.xcadseq #項次   
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "xcad_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "xcad_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                     INITIALIZE gs_keys TO NULL 
                     LET gs_keys[1] = g_xcad_m.xcad001
                     LET gs_keys_bak[1] = g_xcad001_t
                     LET gs_keys[2] = g_xcad_m.xcad002
                     LET gs_keys_bak[2] = g_xcad002_t
                     LET gs_keys[3] = g_xcad_d[g_detail_idx].xcadseq
                     LET gs_keys_bak[3] = g_xcad_d_t.xcadseq
                     CALL axci004_update_b('xcad_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
               END CASE
            END IF
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF cl_null(g_xcad_d[1].xcadseq) THEN
               CALL g_xcad_d.deleteElement(1)
               NEXT FIELD xcadseq
            END IF   
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_xcad_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_xcad_d.getLength()+1
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_xcad2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL axci004_b_fill(g_wc2) 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            DISPLAY g_detail_idx TO FORMONLY.idx
            CALL axci004_ui_detailshow()
        
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)      
         
         #add-point:page2自定義行為

         #end add-point
         
      END DISPLAY
 
 
      
 
      
      #add-point:input段more_input

      #end add-point    
      
      BEFORE DIALOG
         #add-point:input段before_dialog

         #end add-point 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD xcad001
        ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xcadseq
               WHEN "s_detail2"
                  NEXT FIELD xcadseq_2
            END CASE
         END IF
   
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controls
         CALL cl_set_head_visible("","AUTO")
 
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         LET g_action_choice=""
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
   
   #add-point:input段after_input

   #end add-point  
END FUNCTION

PRIVATE FUNCTION axci004_reproduce()
   DEFINE l_newno     LIKE xcad_t.xcad001 
   DEFINE l_oldno     LIKE xcad_t.xcad001 
   DEFINE l_newno02     LIKE xcad_t.xcad002 
   DEFINE l_oldno02     LIKE xcad_t.xcad002 
   DEFINE l_master    RECORD LIKE xcad_t.*
   DEFINE l_detail    RECORD LIKE xcad_t.*
   DEFINE l_cnt       LIKE type_t.num5

 
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF     
 
   IF g_xcad_m.xcad001 IS NULL OR g_xcad_m.xcad002 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF
   
   LET g_xcad001_t = g_xcad_m.xcad001
   LET g_xcad002_t = g_xcad_m.xcad002

   LET g_xcad_m.xcad001 = ""
   LET g_xcad_m.xcad002 = ""

   CALL axci004_set_entry('a')
   CALL axci004_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")

   CALL axci004_input("r")
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN
   END IF
   
   LET g_state = "Y"
   
   LET g_wc = g_wc,  
              " OR (",
              " xcad001 = '", g_xcad_m.xcad001 CLIPPED, "' "
              ," AND xcad002 = '", g_xcad_m.xcad002 CLIPPED, "' "
              , ") "
   
   #add-point:完成複製段落後
   LET g_copy = 'Y'
   LET g_xcad001_c = g_xcad_m.xcad001
   LET g_xcad002_c = g_xcad_m.xcad002
   #end add-point
END FUNCTION

PRIVATE FUNCTION axci004_show()
   IF g_bfill = "Y" THEN
      CALL axci004_b_fill(g_wc2) #單身填充
      CALL axci004_b_fill2('0') #單身填充
   END IF
   
   CALL axci004_xcad002_get()

   LET g_xcad_m_t.* = g_xcad_m.*      #保存單頭舊值
   
   DISPLAY BY NAME g_xcad_m.xcad001,g_xcad_m.xcad002,g_xcad_m.imaa006_desc_1,g_xcad_m.imaal003_desc_1,g_xcad_m.imaal004_desc_1
   CALL axci004_b_fill(g_wc2_table1)                 #單身
   CALL axci004_b_fill2('0') #單身填充

   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
END FUNCTION

PRIVATE FUNCTION axci004_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING    
   
   IF g_xcad_m.xcad001 IS NULL OR g_xcad_m.xcad002 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF
 
   SELECT UNIQUE xcad001,xcad002
     INTO g_xcad_m.xcad001,g_xcad_m.xcad002
     FROM xcad_t
     WHERE xcadent = g_enterprise AND xcad001 = g_xcad_m.xcad001 AND xcad002 = g_xcad_m.xcad002
   CALL axci004_show()
   
   CALL s_transaction_begin()
   
   OPEN axci004_cl USING g_enterprise,g_xcad_m.xcad001,g_xcad_m.xcad002
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN axci004_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE axci004_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH axci004_cl INTO g_xcad_m.xcad001,g_xcad_m.xcad002,g_xcad_m.imaa006_desc_1,g_xcad_m.imaal003_desc_1, 
       g_xcad_m.imaal004_desc_1,g_xcad_m.xcadstus
   #若資料已被他人LOCK
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_xcad_m.xcad001
      LET g_errparam.popup = FALSE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #IF NOT cl_ask_delete() THEN             #確認一下
   IF cl_ask_del_master() THEN              #確認一下
      INITIALIZE g_doc.* TO NULL         
      LET g_doc.column1 = "xcad001"       
      LET g_doc.value1 = g_xcad_m.xcad001     
      CALL cl_doc_remove() 
      #add-point:單身刪除前
      #end add-point
      #DELETE FROM xcad_t WHERE xcadent = g_enterprise AND xcad001 = g_xcad_m.xcad001
      #                                                AND xcad002 = g_xcad_m.xcad002
      DELETE FROM xcad_t
        WHERE xcadent = g_enterprise
          AND xcad001 = g_browser[g_current_idx].b_xcad001
          AND xcad002 = g_browser[g_current_idx].b_xcad003                                      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "xcad_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
         CALL s_transaction_end('N','0')
      END IF
      
      CLEAR FORM
      CALL g_xcad_d.clear() 
      CALL g_xcad2_d.clear()       

      #CALL axci004_ui_browser_refresh()  
      #CALL axci004_ui_headershow()  
      CALL axci004_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL axci004_fetch('P')
      ELSE
         LET g_wc = " 1=1"
         LET g_wc2 = " 1=1"
         #CALL axci004_browser_fill("F")
      END IF
       
   END IF
 
   CLOSE axci004_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_xcad_m.xcad001,'D')
   CALL axci004_browser_fill(g_wc,g_searchtype)
END FUNCTION

PRIVATE FUNCTION axci004_set_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1
   DEFINE  l_n    LIKE type_t.num5

   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xcad001,xcad002",TRUE)
      #add-point:set_entry段欄位控制

      #end add-point
   END IF

   #add-point:set_entry段欄位控制後
   {<point name="set_entry.after_control"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION axci004_set_no_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1
   DEFINE  l_n    LIKE type_t.num5

   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("xcad001,xcad002",FALSE)
      #add-point:set_no_entry段欄位控制

      #end add-point
   END IF

   #add-point:set_no_entry段欄位控制後
   
   #end add-point

END FUNCTION

PRIVATE FUNCTION axci004_default_search()
   DEFINE li_idx  LIKE type_t.num10  #161108-00012#4 num5==》num10
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING

   IF g_searchtype = 0 OR cl_null(g_searchtype) THEN
      LET g_searchtype = 3
   END IF

   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " xcad001 = '", g_argv[1], "' AND "
   END IF

   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xcad002 = ", g_argv[02], " AND "
   END IF

   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xcadseq = ", g_argv[03], " AND "
   END IF

   IF NOT cl_null(ls_wc) THEN
      LET ls_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_wc = ls_wc
   ELSE
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF

   #CALL axci004_browser_fill(g_wc,g_searchtype)

END FUNCTION
#+ 確認碼變更
PRIVATE FUNCTION axci004_statechange()
   DEFINE lc_state     LIKE type_t.chr5
   DEFINE l_n1         LIKE type_t.num5
   DEFINE l_n2         LIKE type_t.num5
   #add-point:statechange段define
   DEFINE l_flag       LIKE type_t.chr1
   DEFINE l_xcad002    LIKE xcad_t.xcad002
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊

   IF g_browser[g_current_idx].b_xcad001 IS NULL
      #key2
      #OR g_xcad_m.xcad002 IS NULL
      #key3
      #OR g_xcad_m.xcad003 IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF

   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         CASE g_xcad_m.xcadstus
            WHEN "N"
               HIDE OPTION "open"
            WHEN "Y"
               HIDE OPTION "valid"
         END CASE
	  
      ON ACTION open
         LET lc_state = "N"
         EXIT MENU
      ON ACTION valid
         LET lc_state = "Y"
         #add-point:action控制  
         #CALL cl_showmsg_init()
         #LET l_flag = 'Y'
         #LET g_sql = "SELECT DISTINCT xcad002 ",
         #            "  FROM imaa_t,xcad_t ",
         #            " WHERE imaaent = '",g_enterprise,"'",
         #            "   AND imaastus = 'Y' ",
         #            "   AND imaa004 <> 'A' ",
         #            "   AND xcad002 = imaa001 ",
         #            "   AND xcad001 = '",g_browser[g_current_idx].b_xcad001,"'"
         #PREPARE xcad002_pre FROM g_sql
         #DECLARE xcad002_pre_cur CURSOR FOR xcad002_pre 
         #FOREACH xcad002_pre_cur INTO l_xcad002
         #   CALL cl_errmsg('',l_xcad002 ,'','axc-00507',1)
         #   LET l_flag = 'N'
         #END FOREACH 
         #IF l_flag = 'N' THEN 
         #   CALL cl_err_showmsg() 
         #   RETURN            
         #END IF
         #
         #LET l_n1 = 0        
         #SELECT COUNT(*) INTO l_n1
         #  FROM imaa_t
         # WHERE imaaent = g_enterprise
         #   AND imaastus = 'Y'
         #   AND imaa004 = 'A'
         #   
         #LET l_n2 = 0
         #SELECT COUNT(DISTINCT xcad002) INTO l_n2
         #  FROM xcad_t
         # WHERE xcadent = g_enterprise
         #   AND xcad001 = g_browser[g_current_idx].b_xcad001
         #   
         #IF l_n1 <> l_n2 THEN 
         #   CALL cl_err('','axc-00207',1)
         #   RETURN
         #END IF
         #end add-point
         EXIT MENU


   END MENU
   
   IF (lc_state <> "N" AND lc_state <> "Y" ) OR 
      cl_null(lc_state) THEN
      RETURN
   END IF

   UPDATE xcad_t SET xcadstus = lc_state 
    WHERE xcadent = g_enterprise AND xcad001 = g_browser[g_current_idx].b_xcad001
      #key2
      #AND xcad002 = g_xcad_m.xcad002
      #key3
      #AND xcad003 = g_xcad_m.xcad003
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
      END CASE
   END IF
END FUNCTION

#+ xcadsite欄位檢查
PRIVATE FUNCTION axci004_xcadsite_chk()
DEFINE  l_n             LIKE type_t.num5  

   #輸入值須存在[T:组织档]
   LET l_n = 0 
   SELECT count(*) INTO l_n 
     FROM ooef_t
    WHERE ooef001 = g_xcad_m.xcadsite
      AND ooefent = g_enterprise    #160902-00048#2
   IF l_n = 0 THEN 
      LET g_xcad_m.xcadsite_desc = ''
      DISPLAY g_xcad_m.xcadsite_desc TO xcadsite_desc
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axc-00005'
      LET g_errparam.extend = g_xcad_m.xcadsite
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE                       
   END IF
   #輸入值須在[T:组织档]里有效
   LET l_n = 0 
   SELECT count(*) INTO l_n 
     FROM ooef_t
    WHERE ooef001 = g_xcad_m.xcadsite
      AND ooefstus = 'Y'
      AND ooefent  = g_enterprise    #160902-00048#2
   IF l_n = 0 THEN 
      LET g_xcad_m.xcadsite_desc = ''
      DISPLAY  g_xcad_m.xcadsite_desc TO xcadsite_desc
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axc-00006'
      LET g_errparam.extend = g_xcad_m.xcadsite
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE  
   END IF 
   #輸入值須存在[T:组织档]里為"法人組織"or"营运組織否"or"核算組織否"
   LET l_n = 0 
   SELECT count(*) INTO l_n 
     FROM ooef_t
    WHERE ooef001 = g_xcad_m.xcadsite
      AND (ooef003 = 'Y' OR ooef201 = 'Y' OR ooef204 = 'Y')
      AND ooefent  = g_enterprise    #160902-00048#2
   IF l_n = 0 THEN 
      LET g_xcad_m.xcadsite_desc = ''
      DISPLAY g_xcad_m.xcadsite_desc TO xcadsite_desc
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axc-00058'
      LET g_errparam.extend = g_xcad_m.xcadsite
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE                       
   END IF
   SELECT ooefl003 INTO g_xcad_m.xcadsite_desc FROM ooefl_t WHERE ooefl001 = g_xcad_m.xcadsite AND ooeflent  = g_enterprise    #160902-00048#2
   DISPLAY g_xcad_m.xcadsite_desc TO xcadsite_desc
   RETURN TRUE
END FUNCTION

# 修改單身後其他table連動
PRIVATE FUNCTION axci004_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10   #161108-00012#4 num5==》num10
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING   
   
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
END FUNCTION

#+ 迴圈檢查
PRIVATE FUNCTION axci004_tree_loop_chk(p_key1,p_addkey2,p_flag)
DEFINE p_key1             STRING
DEFINE p_addkey2          STRING               #要增加的節點key2
DEFINE p_flag             LIKE type_t.chr1  #是否已跑遞迴
DEFINE l_xcad             DYNAMIC ARRAY OF RECORD
                          xcad003    LIKE xcad_t.xcad003
                          END RECORD
DEFINE l_child            INTEGER
DEFINE l_str              STRING
DEFINE l_i                LIKE type_t.num5
DEFINE l_cnt              LIKE type_t.num5
DEFINE l_loop             LIKE type_t.chr1  #是否為無窮迴圈Y/N

   IF cl_null(p_flag) THEN   #第一次進遞迴
      LET g_idx = 1
      LET g_path_add[g_idx] = p_addkey2
      IF g_path_add[g_idx] = p_key1 THEN
         LET l_loop = "Y"
         RETURN l_loop
      END IF
   END IF
   LET p_flag = "Y"
   IF cl_null(l_loop) THEN
      LET l_loop = "N"
   END IF

   IF NOT cl_null(p_addkey2) THEN
      LET g_sql = "SELECT UNIQUE xcad003 ",
                  "  FROM xcad_t ",
                  " WHERE xcad001 = '",g_xcad_m.xcad001,"'",  
                  "   AND xcad002 = '", p_addkey2,"'",  
                  "   AND xcad002 != xcad003",
                  " ORDER BY xcad003"
      PREPARE axci004_tree_pre FROM g_sql
      DECLARE axci004_tree_cs CURSOR FOR axci004_tree_pre

      #在FOREACH中直接使用遞迴,資料會錯亂,所以先將資料放到陣列後,在FOR迴圈處理
      LET l_cnt = 1
      CALL l_xcad.clear()
      FOREACH axci004_tree_cs INTO l_xcad[l_cnt].*
         IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'FOREACH:'
             LET g_errparam.popup = TRUE
             CALL cl_err()

             EXIT FOREACH
         END IF
         LET l_cnt = l_cnt + 1
      END FOREACH
      CALL l_xcad.deleteelement(l_cnt)  #刪除FOREACH最後新增的空白列
      LET l_cnt = l_cnt - 1

      IF l_cnt >0 THEN
         FOR l_i=1 TO l_cnt
            LET g_idx = g_idx + 1
            LET g_path_add[g_idx] = l_xcad[l_i].xcad003
            IF g_path_add[g_idx] = p_key1 THEN
               LET l_loop = "Y"
               RETURN l_loop
            END IF
            #有子節點
            SELECT COUNT(xcad003) INTO l_child FROM xcad_t WHERE xcad001 = g_xcad_m.xcad001 AND xcad002 = l_xcad[l_i].xcad003 AND xcadent  = g_enterprise    #160902-00048#2
            IF l_child > 0 THEN
               CALL axci004_tree_loop_chk(p_key1,l_xcad[l_i].xcad003,p_flag) RETURNING l_loop
               IF l_loop = 'Y' THEN 
                  RETURN l_loop 
               END IF          
            END IF
          END FOR
      END IF
   END IF
   RETURN l_loop
END FUNCTION

#
PRIVATE FUNCTION axci004_b_fill(p_wc2)
   DEFINE p_wc2      STRING    
 
   #先清空單身變數內容
   CALL g_xcad_d.clear()
   CALL g_xcad2_d.clear()

   LET g_sql = "SELECT  UNIQUE xcadseq,xcad003,'','','',xcad004,xcad005,xcad006,xcad007,xcad008, ",
               "        xcad009,'',xcad010,xcad011,'',xcad012,xcad013, ",
               "        xcadseq,xcadownid,'',xcadowndp,'',xcadcrtid,'',xcadcrtdp,'',xcadcrtdt,xcadmodid,'',xcadmoddt ",
               " FROM xcad_t",   
               " WHERE xcadent= ? AND xcad001=? AND xcad002=?"       
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED
   END IF
   #子單身的WC

   #判斷是否填充
   IF axci004_fill_chk(1) THEN
      LET g_sql = g_sql, " ORDER BY xcad_t.xcadseq"
      PREPARE axci004_pb FROM g_sql
      DECLARE b_fill_cs CURSOR FOR axci004_pb
      LET g_cnt = l_ac
      LET l_ac = 1
      OPEN b_fill_cs USING g_enterprise,g_xcad_m.xcad001,g_xcad_m.xcad002                             
      FOREACH b_fill_cs INTO g_xcad_d[l_ac].xcadseq,
                             g_xcad_d[l_ac].xcad003,g_xcad_d[l_ac].imaal003_desc_2,g_xcad_d[l_ac].imaal004_desc_2,g_xcad_d[l_ac].imaa006_desc_2,
                             g_xcad_d[l_ac].xcad004,g_xcad_d[l_ac].xcad005,g_xcad_d[l_ac].xcad006, 
                             g_xcad_d[l_ac].xcad007,g_xcad_d[l_ac].xcad008,
                             g_xcad_d[l_ac].xcad009,g_xcad_d[l_ac].xcad009_desc,g_xcad_d[l_ac].xcad010,
                             g_xcad_d[l_ac].xcad011,g_xcad_d[l_ac].xcad011_desc,
                             g_xcad_d[l_ac].xcad012,g_xcad_d[l_ac].xcad013,
                             g_xcad2_d[l_ac].xcadseq,g_xcad2_d[l_ac].xcadownid,g_xcad2_d[l_ac].xcadownid_desc,
                             g_xcad2_d[l_ac].xcadowndp,g_xcad2_d[l_ac].xcadowndp_desc,
                             g_xcad2_d[l_ac].xcadcrtid,g_xcad2_d[l_ac].xcadcrtid_desc,
                             g_xcad2_d[l_ac].xcadcrtdp,g_xcad2_d[l_ac].xcadcrtdp_desc,g_xcad2_d[l_ac].xcadcrtdt,
                             g_xcad2_d[l_ac].xcadmodid,g_xcad2_d[l_ac].xcadmodid_desc,g_xcad2_d[l_ac].xcadmoddt          
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充
         CALL axci004_xcad003_get()
         CALL axci004_ref_show()
         #end add-point

         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            EXIT FOREACH
         END IF
         
      END FOREACH
      
      CALL g_xcad_d.deleteElement(g_xcad_d.getLength())
      CALL g_xcad2_d.deleteElement(g_xcad2_d.getLength())
   END IF
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   FREE axci004_pb   
   
END FUNCTION
#
PRIVATE FUNCTION axci004_detail_reproduce()
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xcad_t.*

   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axci004_detail
   
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE axci004_detail AS ",
                "SELECT * FROM xcad_t "
   PREPARE repro_tbl FROM ls_sql
   EXECUTE repro_tbl
   FREE repro_tbl
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO axci004_detail
   SELECT * FROM xcad_t WHERE xcadent = g_enterprise AND xcad001 = g_xcad001_t

   #將key修正為調整後   
   UPDATE axci004_detail 
      #更新key欄位
      SET xcad001 = g_xcad_m.xcad001
      #更新共用欄位
       , xcadownid = g_user
       , xcadowndp = g_dept
       , xcadcrtid = g_user
       , xcadcrtdp = g_dept 
       , xcadcrtdt = ld_date
       , xcadmodid = "" 
       , xcadmoddt = "" 
      ##, xcadstus = "Y"

   #將資料塞回原table   
   INSERT INTO xcad_t SELECT * FROM axci004_detail
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "reproduce"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1
   UPDATE xcad_t 
      SET xcadstus = 'N'
    WHERE xcadent = g_enterprise AND xcad001 = g_xcad_m.xcad001
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axci004_detail
   
   #多語言複製段落
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xcad001_t = g_xcad_m.xcad001
   LET g_xcad002_t = g_xcad_m.xcad002
   
   DROP TABLE axci004_detail
END FUNCTION
#
PRIVATE FUNCTION axci004_set_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1      
   
 
END FUNCTION
#
PRIVATE FUNCTION axci004_set_no_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1     
   
   
END FUNCTION
#
PRIVATE FUNCTION axci004_fill_chk(ps_idx)
   DEFINE ps_idx        LIKE type_t.chr10
   DEFINE lst_token     base.StringTokenizer
   DEFINE ls_token      STRING
   
   ##全部為1=1 or null時回傳true
   #IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1') THEN
   #   RETURN TRUE
   #END IF
   #
   ##第一單身
   #IF ps_idx = 1 AND
   #   ((NOT cl_null(g_wc2_table1) AND g_wc2_table1.trim() <> '1=1')) THEN
   #   RETURN TRUE
   #END IF
   #
   ##根據wc判定是否需要填充
   #
   #
   #RETURN FALSE
   RETURN TRUE  #mod 150206 跟着版型调整mail for 150205
END FUNCTION
#
PRIVATE FUNCTION axci004_before_delete()

   DELETE FROM xcad_t
    WHERE xcadent = g_enterprise
      AND xcad001 = g_xcad_m.xcad001
      AND xcad002 = g_xcad_m.xcad002
      AND xcadseq = g_xcad_d_t.xcadseq    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "xcad_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE 
   END IF
   
   LET g_rec_b = g_rec_b-1
   DISPLAY g_rec_b TO FORMONLY.cnt
 
   RETURN TRUE
    
END FUNCTION
# 主件料號帶值
PRIVATE FUNCTION axci004_xcad002_get()
   
   LET g_xcad_m.imaa006_desc_1 = ''
   SELECT imaa006 INTO g_xcad_m.imaa006_desc_1 FROM imaa_t
    WHERE imaaent=g_enterprise
      AND imaa001=g_xcad_m.xcad002
   DISPLAY BY NAME g_xcad_m.imaa006_desc_1
   
   CALL s_desc_get_item_desc(g_xcad_m.xcad002) RETURNING g_xcad_m.imaal003_desc_1,g_xcad_m.imaal004_desc_1
   DISPLAY BY NAME g_xcad_m.imaal003_desc_1
   DISPLAY BY NAME g_xcad_m.imaal004_desc_1
   
END FUNCTION
#
PRIVATE FUNCTION axci004_ui_detailshow()

   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
END FUNCTION
# 元件料號帶值
PRIVATE FUNCTION axci004_xcad003_get()
   
   LET g_xcad_d[l_ac].imaa006_desc_2 = ''
   SELECT imaa006 INTO g_xcad_d[l_ac].imaa006_desc_2 FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_xcad_d[l_ac].xcad003
   DISPLAY g_xcad_d[l_ac].imaa006_desc_2 TO s_detail1[l_ac].imaa006_desc_2
   
   CALL s_desc_get_item_desc(g_xcad_d[l_ac].xcad003) RETURNING g_xcad_d[l_ac].imaal003_desc_2,g_xcad_d[l_ac].imaal004_desc_2
   DISPLAY g_xcad_d[l_ac].imaal003_desc_2 TO s_detail1[l_ac].imaal003_desc_2
   DISPLAY g_xcad_d[l_ac].imaal004_desc_2 TO s_detail1[l_ac].imaal004_desc_2
END FUNCTION
#
PRIVATE FUNCTION axci004_b_fill2(pi_idx)
   DEFINE pi_idx          LIKE type_t.num10  #161108-00012#4 num5==》num10
   DEFINE li_ac           LIKE type_t.num10  #161108-00012#4 num5==》num10
   
   LET li_ac = l_ac 

   LET l_ac = li_ac
END FUNCTION
#
PRIVATE FUNCTION axci004_ref_show()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcad2_d[l_ac].xcadownid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_xcad2_d[l_ac].xcadownid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcad2_d[l_ac].xcadownid_desc
 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcad2_d[l_ac].xcadowndp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcad2_d[l_ac].xcadowndp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcad2_d[l_ac].xcadowndp_desc
 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcad2_d[l_ac].xcadcrtid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_xcad2_d[l_ac].xcadcrtid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcad2_d[l_ac].xcadcrtid_desc
 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcad2_d[l_ac].xcadcrtdp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcad2_d[l_ac].xcadcrtdp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcad2_d[l_ac].xcadcrtdp_desc
 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcad2_d[l_ac].xcadmodid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_xcad2_d[l_ac].xcadmodid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcad2_d[l_ac].xcadmodid_desc
END FUNCTION

#end add-point
 
{</section>}
 
