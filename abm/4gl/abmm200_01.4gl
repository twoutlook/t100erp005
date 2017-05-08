#該程式未解開Section, 採用最新樣板產出!
{<section id="abmm200_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2013-09-23 00:00:00), PR版次:0007(2016-12-13 15:08:35)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000161
#+ Filename...: abmm200_01
#+ Description: BOM用量公式維護
#+ Creator....: 00768()
#+ Modifier...: 00768 -SD/PR- 02295
 
{</section>}
 
{<section id="abmm200_01.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160317-00006#1  2016/03/22 By xianghui 公式维护子作业中调用维护BOM用量维护作业时，cmdrun格式不对
#161213-00009#1  2016/12/13 By ywtsai   於公式用量開窗前，須將開窗條件先清空g_qryparam
#161213-00021#1  2016/12/13 By 02295    开窗回传值没有回传
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"
IMPORT util     #160317-00006#1
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
{</section>}
 
{<section id="abmm200_01.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
{<Module define>}

#單頭 type 宣告
 type type_g_bmze_m        RECORD
       bmba028 LIKE bmba_t.bmba028,
       bmze002 LIKE bmze_t.bmze002
       END RECORD

#單身 type 宣告
 TYPE type_g_bmzf_d        RECORD
       bmzf002 LIKE bmzf_t.bmzf002,
   bmzf003 LIKE bmzf_t.bmzf003,
   bmzf004 LIKE bmzf_t.bmzf004,
   bmzf005 LIKE bmzf_t.bmzf005,
   bmzf006 LIKE bmzf_t.bmzf006,
   bmzf007 LIKE bmzf_t.bmzf007,
   bmzf008 LIKE bmzf_t.bmzf008
       END RECORD


#模組變數(Module Variables)
DEFINE g_bmze_m          type_g_bmze_m
DEFINE g_bmze_m_t        type_g_bmze_m

DEFINE g_bmba028_t     LIKE bmze_t.bmze001


DEFINE g_bmzf_d          DYNAMIC ARRAY OF type_g_bmzf_d


DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位
         b_statepic     LIKE type_t.chr50,
            b_bmze001 LIKE bmze_t.bmze001
         #,rank           LIKE type_t.num10
      END RECORD

DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_jump                LIKE type_t.num10
DEFINE g_no_ask              LIKE type_t.num5
DEFINE g_rec_b               LIKE type_t.num5
DEFINE l_ac                  LIKE type_t.num5
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog

DEFINE g_pagestart           LIKE type_t.num5
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁

DEFINE g_detail_idx          LIKE type_t.num5              #單身目前所在筆數

DEFINE g_order               STRING                        #查詢排序欄位

DEFINE g_current_row         LIKE type_t.num5              #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page

DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_error_show          LIKE type_t.num5

DEFINE g_wc_table1           STRING                        #第1個單身table所使用的g_wc

DEFINE g_wc_frozen           STRING                        #凍結欄位使用

{</Module define>}
#end add-point
 
{</section>}
 
{<section id="abmm200_01.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_bmba001   LIKE bmba_t.bmba001
DEFINE g_bmba003   LIKE bmba_t.bmba003
DEFINE g_bmba028   LIKE bmba_t.bmba028
DEFINE g_bmba001_imaal003  LIKE imaal_t.imaal003
DEFINE g_bmba001_imaal004  LIKE imaal_t.imaal004
DEFINE g_bmba003_imaal003  LIKE imaal_t.imaal003
DEFINE g_bmba003_imaal004  LIKE imaal_t.imaal004
DEFINE g_bmze002   LIKE bmze_t.bmze002
DEFINE g_bmze003   LIKE bmze_t.bmze003
DEFINE g_bmze003_desc  LIKE type_t.chr80
#end add-point
 
{</section>}
 
{<section id="abmm200_01.other_dialog" >}

 
{</section>}
 
{<section id="abmm200_01.other_function" readonly="Y" >}

PUBLIC FUNCTION abmm200_01(--)
   #add-point:main段變數傳入
   p_bmba001,p_bmba003,p_bmba028
   #end add-point
   )
   #add-point:main段define
   DEFINE p_bmba001   LIKE bmba_t.bmba001
   DEFINE p_bmba003   LIKE bmba_t.bmba003
   DEFINE p_bmba028   LIKE bmba_t.bmba028

   #end add-point

   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log

   #add-point:作業初始化
   LET g_bmba001 = p_bmba001
   LET g_bmba003 = p_bmba003
   LET g_bmba028 = p_bmba028
   LET g_bmba028_t = p_bmba028
   #end add-point

   #畫面開啟 (identifier)
   OPEN WINDOW w_abmm200_01 WITH FORM cl_ap_formpath("abm","abmm200_01")

   #程式初始化
   CALL abmm200_01_init()

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()

   #進入選單 Menu (="N")
   IF cl_null(g_bmba028) THEN
      CALL abmm200_01_input()
   END IF
   CALL abmm200_01_ui_dialog()
   IF INT_FLAG THEN
      LET g_bmba028 = g_bmba028_t
   END IF

   #畫面關閉
   CLOSE WINDOW w_abmm200_01
   
   RETURN g_bmba028

END FUNCTION

PRIVATE FUNCTION abmm200_01_init()
   CALL cl_set_combo_scc('bmzf004','1112')
   CALL cl_set_combo_scc('bmzf005','1113')
   
   CALL abmm200_01_show()

END FUNCTION

PRIVATE FUNCTION abmm200_01_show()
   DEFINE l_sql     STRING

   LET g_bmze_m_t.* = g_bmze_m.*      #保存單頭舊值


   #將資料輸出到畫面上
   DISPLAY g_bmba001 TO FORMONLY.bmba001
   DISPLAY g_bmba003 TO FORMONLY.bmba003
   DISPLAY g_bmba028 TO FORMONLY.bmba028

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_bmba001
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_bmba001_imaal003 = '', g_rtn_fields[1] , ''
   LET g_bmba001_imaal004 = '', g_rtn_fields[2] , ''
   DISPLAY g_bmba001_imaal003 TO FORMONLY.bmba001_imaal003
   DISPLAY g_bmba001_imaal004 TO FORMONLY.bmba001_imaal004

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_bmba003
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_bmba003_imaal003 = '', g_rtn_fields[1] , ''
   LET g_bmba003_imaal004 = '', g_rtn_fields[2] , ''
   DISPLAY g_bmba003_imaal003 TO FORMONLY.bmba003_imaal003
   DISPLAY g_bmba003_imaal004 TO FORMONLY.bmba003_imaal004

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_bmba028
   CALL ap_ref_array2(g_ref_fields,"SELECT bmze002,bmze003 FROM bmze_t WHERE bmzeent='"||g_enterprise||"' AND bmze001=? ","") RETURNING g_rtn_fields
   LET g_bmze002 = '', g_rtn_fields[1] , ''
   LET g_bmze003 = '', g_rtn_fields[2] , ''
   DISPLAY g_bmze002 TO FORMONLY.bmba028_bmze002
   DISPLAY g_bmze003 TO FORMONLY.bmba028_bmze003

   CALL abmm200_01_bmze003_ref(g_bmze003) RETURNING g_bmze003_desc
   DISPLAY g_bmze003_desc TO FORMONLY.bmze003_desc

   CALL abmm200_01_b_fill()                 #單身
   
   #設定有特殊格式設定的欄位
   CALL cl_show_fld_cont()


END FUNCTION

PRIVATE FUNCTION abmm200_01_b_fill()
   DEFINE l_sql  STRING
   
   CALL g_bmzf_d.clear()    #g_bmzf_d 單頭及單身
   
   IF cl_null(g_bmba028) THEN
      RETURN
   END IF

   LET g_sql = "SELECT  UNIQUE bmzf002,bmzf003,bmzf004,bmzf005,bmzf006,bmzf007,bmzf008 FROM bmzf_t",
               " WHERE bmzfent=? AND bmzf001=?"
   LET g_sql = g_sql, " ORDER BY bmzf_t.bmzf002"
   PREPARE abmm200_01_pb FROM g_sql
   DECLARE b_fill_cs CURSOR FOR abmm200_01_pb
   LET g_cnt = l_ac
   LET l_ac = 1
   OPEN b_fill_cs USING g_enterprise,g_bmba028
   FOREACH b_fill_cs INTO g_bmzf_d[l_ac].bmzf002,g_bmzf_d[l_ac].bmzf003,g_bmzf_d[l_ac].bmzf004,g_bmzf_d[l_ac].bmzf005,g_bmzf_d[l_ac].bmzf006,g_bmzf_d[l_ac].bmzf007,g_bmzf_d[l_ac].bmzf008
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      #值取栏位料号的时候
      IF (g_bmzf_d[l_ac].bmzf004='2' OR g_bmzf_d[l_ac].bmzf004='3')  #2:主件料件主檔 3:元件料件主檔
         AND NOT cl_null(g_bmzf_d[l_ac].bmzf005) AND NOT cl_null(g_bmzf_d[l_ac].bmzf006)  #來源檔案 來源欄位
      THEN
         LET l_sql = " SELECT ",g_bmzf_d[l_ac].bmzf006," FROM ",g_bmzf_d[l_ac].bmzf005,
                     "  WHERE ",g_bmzf_d[l_ac].bmzf005[1,4],"ent = ",g_enterprise
         #來源檔案:imaa_t\imac_t\imae_t\imaf_t
         IF g_bmzf_d[l_ac].bmzf005='imae_t' OR g_bmzf_d[l_ac].bmzf005='imaf_t' THEN
            LET l_sql = l_sql CLIPPED," AND ",g_bmzf_d[l_ac].bmzf005[1,4],"site = '",g_site,"' "
         END IF
         #主件or元件
         CASE g_bmzf_d[l_ac].bmzf004
            WHEN '2' #主件料件主檔
                 LET l_sql = l_sql CLIPPED," AND ",g_bmzf_d[l_ac].bmzf005[1,4],"001 ='",g_bmba001,"' "
            WHEN '3' #元件料件主檔
                 LET l_sql = l_sql CLIPPED," AND ",g_bmzf_d[l_ac].bmzf005[1,4],"001 ='",g_bmba003,"' "
         END CASE
         
         DECLARE abmm200_01_b_fill_c2 SCROLL CURSOR FROM l_sql                                                                                    
         OPEN abmm200_01_b_fill_c2                                                       
         FETCH FIRST abmm200_01_b_fill_c2 INTO g_bmzf_d[l_ac].bmzf008
         CLOSE abmm200_01_b_fill_c2
      END IF

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF

   END FOREACH
   CALL g_bmzf_d.deleteElement(g_bmzf_d.getLength())

   LET l_ac = g_cnt
   LET g_cnt = 0

   FREE abmm200_01_pb


END FUNCTION
#+
PRIVATE FUNCTION abmm200_01_bmze003_ref(p_bmze003)
DEFINE  p_bmze003       STRING
DEFINE  l_bmze003_str1  LIKE bmze_t.bmze003
DEFINE  bst             base.StringTokenizer
DEFINE  l_index         LIKE type_t.num5
DEFINE  l_index2        LIKE type_t.num5
DEFINE  l_bmze003_desc  STRING
DEFINE  l_bmzf003       LIKE bmzf_t.bmzf003
DEFINE  l_bmzf002       LIKE bmzf_t.bmzf002

      LET l_index = 1
      LET l_bmze003_desc = ''
      LET l_index2 = p_bmze003.getIndexOf('$',1)
      LET bst= base.StringTokenizer.create(p_bmze003,'$')
      IF l_index2 = 1 THEN
         WHILE bst.hasMoreTokens()
            IF l_index = 2 THEN
               LET l_bmze003_str1 = bst.nextToken()
               LET l_bmze003_desc = l_bmze003_desc,l_bmze003_str1
               LET l_index = 1
            ELSE
               LET l_bmzf002 = bst.nextToken()
               SELECT bmzf003 INTO l_bmzf003 FROM bmzf_t WHERE bmzfent = g_enterprise AND bmzf001 = g_bmba028 AND bmzf002 = l_bmzf002
               LET l_bmze003_desc = l_bmze003_desc,l_bmzf003
               LET l_index = l_index + 1
            END IF
         END WHILE
      ELSE
         WHILE bst.hasMoreTokens()
            IF l_index = 2 THEN
               LET l_bmzf002 = bst.nextToken()
               SELECT bmzf003 INTO l_bmzf003 FROM bmzf_t WHERE bmzfent = g_enterprise AND bmzf001 = g_bmba028 AND bmzf002 = l_bmzf002
               LET l_bmze003_desc = l_bmze003_desc,l_bmzf003
               LET l_index = 1
            ELSE
               LET l_bmze003_str1 = bst.nextToken()
               LET l_bmze003_desc = l_bmze003_desc,l_bmze003_str1
               LET l_index = l_index + 1
            END IF
         END WHILE
      END IF
      RETURN l_bmze003_desc


END FUNCTION

PRIVATE FUNCTION abmm200_01_ui_dialog()
   {<Local define>}
   DEFINE li_idx  LIKE type_t.num5
   #160317-00006#1---add---begin
   DEFINE ls_js   STRING
   DEFINE la_param   RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
          END RECORD
   #160317-00006#1---add---end 
   {</Local define>}

   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件

   CALL cl_set_act_visible("accept,cancel", FALSE)

   WHILE TRUE

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_bmzf_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1

            #BEFORE ROW
               #CALL abmm200_01_idx_chk()
               #LET l_ac = DIALOG.getCurrentRow("s_detail1")

            #BEFORE DISPLAY
               #CALL FGL_SET_ARR_CURR(g_detail_idx)
               #LET l_ac = DIALOG.getCurrentRow("s_detail1")
               #CALL abmm200_01_idx_chk()
               #LET g_current_page = 1

         END DISPLAY

         BEFORE DIALOG
            #CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            #LET g_curr_diag = ui.DIALOG.getCurrent()
            #LET g_page = "first"
            #LET g_current_sw = FALSE
            #LET g_current_row = g_current_idx #目前指標
            #IF g_current_idx = 0 THEN
            #   LET g_current_idx = 1
            #END IF
            #LET g_current_sw = TRUE

            #IF g_current_idx > g_browser.getLength() THEN
            #   LET g_current_idx = g_browser.getLength()
            #END IF

            ##有資料才進行fetch
            #IF g_current_idx <> 0 THEN
            #   CALL abmm200_01_fetch('') # reload data
            #END IF
            #CALL cl_ui_set_browse_page_button(g_curr_diag,g_page_action,g_pagestart,g_browser_cnt)

            ##筆數顯示
            #LET g_current_page = 1
            #CALL abmm200_01_idx_chk()



         #ACTION表單列
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               CALL abmm200_01_input()
               EXIT DIALOG
            END IF
            
         ON ACTION formula_edit  #BOM用量公式维护作业
            LET g_action_choice="formula_edit"
            IF cl_auth_chk_act("formula_edit") THEN
               #160317-00006#1---mod---begin
               #CALL cl_cmdrun_wait(" abmi002 '"||g_bmba028||"'")
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'abmi002'
               LET la_param.param[1] = g_bmba028
                
               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun(ls_js)
               #160317-00006#1---mod---end
               CALL abmm200_01_show()
               EXIT DIALOG
            END IF
            
         ON ACTION formula_test  #公式测试
            LET g_action_choice="formula_test"
            IF cl_auth_chk_act("formula_test") THEN
               CALL abmi002_01(g_bmba028)
               IF INT_FLAG THEN
                  LET INT_FLAG = 0
               END IF
               EXIT DIALOG
            END IF
            
         ON ACTION close
            LET INT_FLAG=FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG

         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG

         ON ACTION mainhidden       #主頁摺疊
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
            END IF

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
   LET g_action_choice = ""
   CALL cl_set_act_visible("accept,cancel", TRUE)

END FUNCTION

PRIVATE FUNCTION abmm200_01_input()
   {<Local define>}
   DEFINE  l_allow_insert  LIKE type_t.num5                #可新增否
   DEFINE  l_allow_delete  LIKE type_t.num5                #可刪除否
   {</Local define>}

   CALL cl_set_head_visible("","YES")

   LET g_action_choice = ""

   #LET g_forupd_sql = "SELECT bmzf002,bmzf003,bmzf004,bmzf005,bmzf006,bmzf007,bmzf008 FROM bmzf_t WHERE bmzfent=? AND bmzf001=? AND bmzf002=? FOR UPDATE"
   #LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   #DECLARE abmm200_01_bcl CURSOR FROM g_forupd_sql

   #LET l_allow_insert = cl_auth_detail_input("insert")
   #LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'

   #DISPLAY BY NAME g_bmze_m.bmze001,g_bmze_m.bmze002

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單頭段
      INPUT g_bmba028 FROM bmba028 #ATTRIBUTE(FIELD ORDER FORM)
         ATTRIBUTE(WITHOUT DEFAULTS)

         BEFORE INPUT

         AFTER FIELD bmba028
            IF g_bmba028 IS NULL THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aoo-00052'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD CURRENT
            END IF
            LET g_bmze002 = ''
            LET g_bmze003 = ''
            SELECT bmze002,bmze003 INTO g_bmze002,g_bmze003 FROM bmze_t
             WHERE bmzeent = g_enterprise
               AND bmze001 = g_bmba028
               AND bmzestus= 'Y'
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abm-00046'
               LET g_errparam.extend = g_bmba028
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD CURRENT
            END IF
            DISPLAY g_bmze002 TO FORMONLY.bmba028_bmze002
            DISPLAY g_bmze003 TO FORMONLY.bmba028_bmze003
            IF NOT cl_null(g_bmze003) THEN
               CALL abmm200_01_bmze003_ref(g_bmze003) RETURNING g_bmze003_desc
               DISPLAY BY NAME g_bmze003_desc
            END IF
            
         ON ACTION controlp INFIELD bmba028
            INITIALIZE g_qryparam.* TO NULL                 #161213-00009#1 add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'   #161213-00021#1
            LET g_qryparam.default1 = g_bmba028             #給予default值
            #給予arg
            CALL q_bmze001()                                #呼叫開窗
            LET g_bmba028 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_bmba028 TO bmba028              #顯示到畫面上
            NEXT FIELD bmba028                         #返回原欄位

         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF

      END INPUT

      BEFORE DIALOG

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

   CALL abmm200_01_show()

END FUNCTION

PRIVATE FUNCTION abmm200_01_fetch(p_flag)
#   {<Local define>}
   DEFINE p_flag     LIKE type_t.chr1
#   DEFINE ls_msg     STRING
#   {</Local define>}
#
#
#   CASE p_flag
#      WHEN 'F' LET g_current_idx = 1
#      WHEN 'L' LET g_current_idx = g_header_cnt
#      WHEN 'P'
#         IF g_current_idx > 1 THEN
#            LET g_current_idx = g_current_idx - 1
#         END IF
#      WHEN 'N'
#         IF g_current_idx < g_header_cnt THEN
#            LET g_current_idx =  g_current_idx + 1
#         END IF
#      WHEN '/'
#         IF (NOT g_no_ask) THEN
#            CALL cl_set_act_visible("accept,cancel", TRUE)
#            CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
#            LET INT_FLAG = 0
#
#            PROMPT ls_msg CLIPPED,':' FOR g_jump
#               #交談指令共用ACTION
#               &include "common_action.4gl"
#            END PROMPT
#
#            CALL cl_set_act_visible("accept,cancel", FALSE)
#            IF INT_FLAG THEN
#                LET INT_FLAG = 0
#                EXIT CASE
#            END IF
#         END IF
#
#         IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
#             LET g_current_idx = g_jump
#         END IF
#
#         LET g_no_ask = FALSE
#   END CASE
#
#
#
#
#   #瀏覽頁筆數顯示
#   LET g_pagestart = g_current_idx
#   DISPLAY g_pagestart TO FORMONLY.b_index   #當下筆數
#   DISPLAY g_pagestart TO FORMONLY.h_index   #當下筆數
#
#   #CALL cl_navigator_setting( g_pagestart, g_browser_cnt )
#
#   #代表沒有資料
#   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
#      RETURN
#   END IF
#
#   #超出範圍
#   IF g_current_idx > g_browser.getLength() THEN
#      LET g_current_idx = g_browser.getLength()
#   END IF
#
#   LET g_bmze_m.bmze001 = g_browser[g_current_idx].b_bmze001
#
#   #重讀DB,因TEMP有不被更新特性
#    SELECT UNIQUE bmze001,bmze002
#      INTO g_bmze_m.bmze001,g_bmze_m.bmze002
#      FROM bmze_t
#     WHERE bmzeent = g_enterprise AND bmze001 = g_bmze_m.bmze001
#   IF SQLCA.sqlcode THEN
#      #CALL cl_err("bmze_t",SQLCA.sqlcode,1)
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = "bmze_t"
#      LET g_errparam.popup = TRUE
#      CALL cl_err()

#      INITIALIZE g_bmze_m.* TO NULL
#      RETURN
#   END IF
#
#   #重新顯示
#   CALL abmm200_01_show()

END FUNCTION

PRIVATE FUNCTION abmm200_01_idx_chk()
#   IF g_current_page = 1 THEN
#      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
#      IF g_detail_idx > g_bmzf_d.getLength() THEN
#         LET g_detail_idx = g_bmzf_d.getLength()
#      END IF
#      IF g_detail_idx = 0 AND g_bmzf_d.getLength() <> 0 THEN
#         LET g_detail_idx = 1
#      END IF
#   END IF



END FUNCTION

 
{</section>}
 
