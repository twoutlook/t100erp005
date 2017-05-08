#該程式未解開Section, 採用最新樣板產出!
{<section id="axrt300_12.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2014-08-08 14:27:21), PR版次:0006(2016-12-02 14:47:59)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000211
#+ Filename...: axrt300_12
#+ Description: 科目核算項維護
#+ Creator....: 01727(2014-03-17 17:41:52)
#+ Modifier...: 01727 -SD/PR- 02481
 
{</section>}
 
{<section id="axrt300_12.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160318-00025#13 2016/04/15 By 07673   將重複內容的錯誤訊息置換為公用錯誤訊息
#161118-00019#2  2016/11/22 By 07900   numt5 to num10(需人工调整部分)
#161128-00061#4  2016/12/02 by 02481    标准程式定义采用宣告模式,弃用.*写法
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
{</section>}
 
{<section id="axrt300_12.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
 TYPE type_g_xrcb_d RECORD
   xrcbseq      LIKE xrcb_t.xrcbseq, 
   xrcb029      LIKE xrcb_t.xrcb029, 
   xrcb029_t    LIKE ooefl_t.ooefl003, 
   xrcb021      LIKE xrcb_t.xrcb021, 
   xrcb021_t    LIKE ooefl_t.ooefl003, 
   xrcb005      LIKE xrcb_t.xrcb005, 
   xrcb010      LIKE xrcb_t.xrcb010, 
   xrcb010_t    LIKE ooefl_t.ooefl003, 
   xrcb011      LIKE xrcb_t.xrcb011, 
   xrcb011_t    LIKE ooefl_t.ooefl003, 
   xrcblegl     LIKE xrcb_t.xrcblegl,
   xrcblegl_t   LIKE ooefl_t.ooefl003, 
   xrcb012      LIKE xrcb_t.xrcb012,  
   xrcb012_t    LIKE ooefl_t.ooefl003, 
   xrcb015      LIKE xrcb_t.xrcb015, 
   xrcb015_t    LIKE ooefl_t.ooefl003, 
   xrcb016      LIKE xrcb_t.xrcb016, 
   xrcb016_t    LIKE ooefl_t.ooefl003, 
   xrcb113      LIKE xrcb_t.xrcb113
       END RECORD
 TYPE type_g_xrce_d RECORD
   xrceseq      LIKE xrce_t.xrceseq,
   xrce016      LIKE xrce_t.xrce016,
   xrce016_t    LIKE ooefl_t.ooefl003, 
   xrce018      LIKE xrce_t.xrce018,
   xrce018_t    LIKE ooefl_t.ooefl003, 
   xrce019      LIKE xrce_t.xrce019,
   xrce019_t    LIKE ooefl_t.ooefl003, 
   xrcelegl     LIKE xrce_t.xrcelegl,
   xrcelegl_t   LIKE ooefl_t.ooefl003, 
   xrce020      LIKE xrce_t.xrce020,
   xrce020_t    LIKE ooefl_t.ooefl003, 
   xrce022      LIKE xrce_t.xrce022,
   xrce022_t    LIKE ooefl_t.ooefl003, 
   xrce023      LIKE xrce_t.xrce023,
   xrce023_t    LIKE ooefl_t.ooefl003, 
   xrce119      LIKE xrce_t.xrce119
       END RECORD
 
 
 
#end add-point
 
{</section>}
 
{<section id="axrt300_12.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_xrcb_d          DYNAMIC ARRAY OF type_g_xrcb_d
DEFINE g_xrcb_d_t        type_g_xrcb_d
DEFINE g_xrce_d          DYNAMIC ARRAY OF type_g_xrce_d
DEFINE g_xrce_d_t        type_g_xrce_d



DEFINE g_wc2                STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10              #目前處理的ARRAY CNT    #161118-00019#2 mod  type_t.num5 -> type_t.num10
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_temp_idx           LIKE type_t.num10              #單身 所在筆數(暫存用)   #161118-00019#2 mod  type_t.num5 -> type_t.num10
DEFINE g_detail_idx         LIKE type_t.num10              #單身 所在筆數(所有資料) #161118-00019#2 mod  type_t.num5 -> type_t.num10
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)   #161118-00019#2 mod  type_t.num5 -> type_t.num10
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_chk                BOOLEAN
DEFINE g_aw                 STRING                        #確定當下點擊的單身

DEFINE g_wc_table           STRING
#161128-00061#4-----modify--begin----------
#DEFINE g_glaa_t              RECORD LIKE glaa_t.* 
DEFINE g_glaa_t  RECORD  #帳套資料檔
       glaaent LIKE glaa_t.glaaent, #企業編號
       glaaownid LIKE glaa_t.glaaownid, #資料所有者
       glaaowndp LIKE glaa_t.glaaowndp, #資料所屬部門
       glaacrtid LIKE glaa_t.glaacrtid, #資料建立者
       glaacrtdp LIKE glaa_t.glaacrtdp, #資料建立部門
       glaacrtdt LIKE glaa_t.glaacrtdt, #資料創建日
       glaamodid LIKE glaa_t.glaamodid, #資料修改者
       glaamoddt LIKE glaa_t.glaamoddt, #最近修改日
       glaastus LIKE glaa_t.glaastus, #狀態碼
       glaald LIKE glaa_t.glaald, #帳套編號
       glaacomp LIKE glaa_t.glaacomp, #歸屬法人
       glaa001 LIKE glaa_t.glaa001, #使用幣別
       glaa002 LIKE glaa_t.glaa002, #匯率參照表號
       glaa003 LIKE glaa_t.glaa003, #會計週期參照表號
       glaa004 LIKE glaa_t.glaa004, #會計科目參照表號
       glaa005 LIKE glaa_t.glaa005, #現金變動參照表號
       glaa006 LIKE glaa_t.glaa006, #月結方式
       glaa007 LIKE glaa_t.glaa007, #年結方式
       glaa008 LIKE glaa_t.glaa008, #平行記帳否
       glaa009 LIKE glaa_t.glaa009, #傳票登入方式
       glaa010 LIKE glaa_t.glaa010, #現行年度
       glaa011 LIKE glaa_t.glaa011, #現行期別
       glaa012 LIKE glaa_t.glaa012, #最後過帳日期
       glaa013 LIKE glaa_t.glaa013, #關帳日期
       glaa014 LIKE glaa_t.glaa014, #主帳套
       glaa015 LIKE glaa_t.glaa015, #啟用本位幣二
       glaa016 LIKE glaa_t.glaa016, #本位幣二
       glaa017 LIKE glaa_t.glaa017, #本位幣二換算基準
       glaa018 LIKE glaa_t.glaa018, #本位幣二匯率採用
       glaa019 LIKE glaa_t.glaa019, #啟用本位幣三
       glaa020 LIKE glaa_t.glaa020, #本位幣三
       glaa021 LIKE glaa_t.glaa021, #本位幣三換算基準
       glaa022 LIKE glaa_t.glaa022, #本位幣三匯率採用
       glaa023 LIKE glaa_t.glaa023, #次帳套帳務產生時機
       glaa024 LIKE glaa_t.glaa024, #單據別參照表號
       glaa025 LIKE glaa_t.glaa025, #本位幣一匯率採用
       glaa026 LIKE glaa_t.glaa026, #幣別參照表號
       glaa100 LIKE glaa_t.glaa100, #傳票輸入時自動按缺號產生
       glaa101 LIKE glaa_t.glaa101, #傳票總號輸入時機
       glaa102 LIKE glaa_t.glaa102, #傳票成立時,借貸不平衡的處理方式
       glaa103 LIKE glaa_t.glaa103, #未列印的傳票可否進行過帳
       glaa111 LIKE glaa_t.glaa111, #應計調整單別
       glaa112 LIKE glaa_t.glaa112, #期末結轉單別
       glaa113 LIKE glaa_t.glaa113, #年底結轉單別
       glaa120 LIKE glaa_t.glaa120, #成本計算類型
       glaa121 LIKE glaa_t.glaa121, #子模組啟用分錄底稿
       glaa122 LIKE glaa_t.glaa122, #總帳可維護資金異動明細
       glaa027 LIKE glaa_t.glaa027, #單據據點編號
       glaa130 LIKE glaa_t.glaa130, #合併帳套否
       glaa131 LIKE glaa_t.glaa131, #分層合併
       glaa132 LIKE glaa_t.glaa132, #平均匯率計算方式
       glaa133 LIKE glaa_t.glaa133, #非T100公司匯入餘額類型
       glaa134 LIKE glaa_t.glaa134, #合併科目轉換依據異動碼設定值
       glaa135 LIKE glaa_t.glaa135, #現流表間接法群組參照表號
       glaa136 LIKE glaa_t.glaa136, #應收帳款核銷限定己立帳傳票
       glaa137 LIKE glaa_t.glaa137, #應付帳款核銷限定已立帳傳票
       glaa138 LIKE glaa_t.glaa138, #合併報表編制期別
       glaa139 LIKE glaa_t.glaa139, #遞延收入(負債)管理產生否
       glaa140 LIKE glaa_t.glaa140, #無原出貨單的遞延負債減項者,是否仍立遞延收入管理?
       glaa123 LIKE glaa_t.glaa123, #應收帳款核銷可維護資金異動明細
       glaa124 LIKE glaa_t.glaa124, #應付帳款核銷可維護資金異動明細
       glaa028 LIKE glaa_t.glaa028  #匯率來源
       END RECORD
#161128-00061#4-----modify--end----------
DEFINE g_xrcbld             LIKE xrcb_t.xrcbld
DEFINE g_xrcbdocno          LIKE xrcb_t.xrcbdocno
#end add-point
 
{</section>}
 
{<section id="axrt300_12.other_dialog" >}

 
{</section>}
 
{<section id="axrt300_12.other_function" readonly="Y" >}
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
PUBLIC FUNCTION axrt300_12(p_ld,p_docno)
   DEFINE p_ld      LIKE xrcb_t.xrcbld
   DEFINE p_docno   LIKE xrcb_t.xrcbdocno
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log

   #作業初始化

   LET g_xrcbld = p_ld
   LET g_xrcbdocno = p_docno

   #161128-00061#4-----modify--begin----------
   #SELECT * INTO g_glaa_t.* 
    SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
           glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
           glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
           glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
           glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
           glaa140,glaa123,glaa124,glaa028 INTO g_glaa_t.* 
   #161128-00061#4----modify--end----------
   FROM glaa_t WHERE glaaent = g_enterprise
      AND glaald = p_ld

   #LOCK CURSOR (identifier)

   LET g_forupd_sql = ""

   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)   #轉換不同資料庫語法
   DECLARE axrt300_12_cl CURSOR FROM g_forupd_sql     # LOCK CURSOR


   #畫面開啟 (identifier)
   OPEN WINDOW w_axrt300_12 WITH FORM cl_ap_formpath("axr","axrt300_12")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()

   #程式初始化
   CALL axrt300_12_init()

   #進入選單 Menu (="N")
   CALL axrt300_12_ui_dialog()

   #畫面關閉
   CLOSE WINDOW w_axrt300_12

   CLOSE axrt300_12_cl
   
   LET g_action_choice = ''
   
END FUNCTION

PRIVATE FUNCTION axrt300_12_init()
   DEFINE l_gzzd005         LIKE gzzd_t.gzzd005

   LET g_error_show = 1

   SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t WHERE gzzd001 = 'axrt300_12' AND gzzd003 = 'lbl_xrcb021_t' AND gzzd002 = g_lang
   CALL cl_set_comp_att_text('xrcb021_t',l_gzzd005)

   CALL axrt300_12_default_search()

END FUNCTION

PRIVATE FUNCTION axrt300_12_b_fill()
   LET g_sql = "SELECT UNIQUE xrcbseq,xrcb029,'',xrcb021,'',xrcb005,xrcb010,'',xrcb011,'',xrcblegl,'',",
               "               xrcb012,'',xrcb015,'',xrcb016,'',xrcb113 FROM xrcb_t",
               " WHERE xrcbent= ? AND xrcbdocno = '",g_xrcbdocno,"' AND xrcbld = '",g_xrcbld,"'"
   LET g_sql = g_sql, " ORDER BY xrcbld,xrcbdocno,xrcbseq"

   PREPARE axrt300_12_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axrt300_12_pb

   OPEN b_fill_curs USING g_enterprise

   CALL g_xrcb_d.clear()

   LET g_cnt = l_ac
   LET l_ac = 1
   ERROR "Searching!"

   FOREACH b_fill_curs INTO g_xrcb_d[l_ac].xrcbseq,  g_xrcb_d[l_ac].xrcb029,  g_xrcb_d[l_ac].xrcb029_t,g_xrcb_d[l_ac].xrcb021,
                            g_xrcb_d[l_ac].xrcb021_t,g_xrcb_d[l_ac].xrcb005,  g_xrcb_d[l_ac].xrcb010,  g_xrcb_d[l_ac].xrcb010_t,
                            g_xrcb_d[l_ac].xrcb011,  g_xrcb_d[l_ac].xrcb011_t,g_xrcb_d[l_ac].xrcblegl, g_xrcb_d[l_ac].xrcblegl_t,
                            g_xrcb_d[l_ac].xrcb012,  g_xrcb_d[l_ac].xrcb012_t,g_xrcb_d[l_ac].xrcb015,  g_xrcb_d[l_ac].xrcb015_t,
                            g_xrcb_d[l_ac].xrcb016,  g_xrcb_d[l_ac].xrcb016_t,g_xrcb_d[l_ac].xrcb113

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      CALL axrt300_12_detail_show('xrcb')

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF

   END FOREACH

   IF l_ac > g_max_rec AND g_error_show = 1 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 9035
      LET g_errparam.extend = "xrcb_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
   LET g_error_show = 0

   CALL g_xrcb_d.deleteElement(g_xrcb_d.getLength())

   LET g_detail_cnt = l_ac - 1
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   LET l_ac = g_cnt
   LET g_cnt = 0

   CLOSE b_fill_curs
   FREE axrt300_12_pb



   LET g_sql = "SELECT UNIQUE xrceseq,xrce016,'',xrce018,'',xrce019,'',xrcelegl,'',",
               "               xrce020,'',xrce022,'',xrce023,'',xrce119 FROM xrce_t",
               " WHERE xrceent= ? AND xrcedocno = '",g_xrcbdocno,"' AND xrceld = '",g_xrcbld,"'"
   LET g_sql = g_sql, " ORDER BY xrceld,xrcedocno,xrceseq"

   PREPARE axrt300_12_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR axrt300_12_pb2

   OPEN b_fill_curs2 USING g_enterprise

   CALL g_xrce_d.clear()

   LET g_cnt = l_ac
   LET l_ac = 1
   ERROR "Searching!"

   FOREACH b_fill_curs2 INTO g_xrce_d[l_ac].xrceseq,   g_xrce_d[l_ac].xrce016,g_xrce_d[l_ac].xrce016_t,g_xrce_d[l_ac].xrce018,
                             g_xrce_d[l_ac].xrce018_t, g_xrce_d[l_ac].xrce019,g_xrce_d[l_ac].xrce019_t,g_xrce_d[l_ac].xrcelegl,
                             g_xrce_d[l_ac].xrcelegl_t,g_xrce_d[l_ac].xrce020,g_xrce_d[l_ac].xrce020_t,g_xrce_d[l_ac].xrce022,
                             g_xrce_d[l_ac].xrce022_t, g_xrce_d[l_ac].xrce023,g_xrce_d[l_ac].xrce023_t,g_xrce_d[l_ac].xrce119

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      CALL axrt300_12_detail_show('xrce')

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF

   END FOREACH

   IF l_ac > g_max_rec AND g_error_show = 1 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 9035
      LET g_errparam.extend = "xrce_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
   LET g_error_show = 0

   CALL g_xrce_d.deleteElement(g_xrce_d.getLength())

   LET g_detail_cnt = l_ac - 1
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   LET l_ac = g_cnt
   LET g_cnt = 0

   CLOSE b_fill_curs2
   FREE axrt300_12_pb2

END FUNCTION

PRIVATE FUNCTION axrt300_12_ui_dialog()
   DEFINE li_idx   LIKE type_t.num5

   LET g_action_choice = " "
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()

   CALL cl_set_act_visible("accept,cancel", FALSE)

   LET g_detail_idx = 1

   WHILE TRUE

      CALL axrt300_12_b_fill()

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_xrcb_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac

               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont()

            #自訂ACTION(detail_show,page_1)


         END DISPLAY

          DISPLAY ARRAY g_xrce_d TO s_detail2.*
             ATTRIBUTES(COUNT=g_detail_cnt)
	    
             BEFORE DISPLAY
                CALL FGL_SET_ARR_CURR(g_detail_idx)
	    
             BEFORE ROW
                LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
                LET l_ac = g_detail_idx
                LET g_temp_idx = l_ac
                DISPLAY g_detail_idx TO FORMONLY.idx
                CALL cl_show_fld_cont()
	    
             #自訂ACTION(detail_show,page_2)
	    
	    
          END DISPLAY

         BEFORE DIALOG
            IF g_temp_idx > 0 THEN
               LET l_ac = g_temp_idx
               CALL DIALOG.setCurrentRow("s_detail1",l_ac)
               LET g_temp_idx = 1
            END IF
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)

            NEXT FIELD CURRENT

         ON ACTION output

            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN

               EXIT DIALOG
            END IF

         ON ACTION modify

            LET g_aw = ''
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               CALL axrt300_12_modify()

               EXIT DIALOG
            END IF

         ON ACTION modify_detail

            LET g_aw = g_curr_diag.getCurrentItem()
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               CALL axrt300_12_modify()
               
               EXIT DIALOG
            END IF

         ON ACTION close
            LET INT_FLAG=FALSE
            LET g_action_choice="exit"
            EXIT DIALOG

         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG

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

PRIVATE FUNCTION axrt300_12_modify()
   DEFINE  l_cmd                  LIKE type_t.chr1
   DEFINE  l_ac_t                 LIKE type_t.num10                #未取消的ARRAY CNT  #161118-00019#2 mod  type_t.num5 -> type_t.num10
   DEFINE  l_n                    LIKE type_t.num5                #檢查重複用
   DEFINE  l_cnt                  LIKE type_t.num5                #檢查重複用
   DEFINE  l_lock_sw              LIKE type_t.chr1                #單身鎖住否
   DEFINE  l_allow_insert         LIKE type_t.num5                #可新增否
   DEFINE  l_allow_delete         LIKE type_t.num5                #可刪除否
   DEFINE  l_count                LIKE type_t.num5
   DEFINE  l_i                    LIKE type_t.num5
   DEFINE  ls_return              STRING
   DEFINE  l_var_keys             DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys           DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                 DYNAMIC ARRAY OF STRING
   DEFINE  l_fields               DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak         DYNAMIC ARRAY OF STRING
   DEFINE  li_reproduce           LIKE type_t.num5
   DEFINE  li_reproduce_target    LIKE type_t.num5
   DEFINE  lb_reproduce           BOOLEAN
   DEFINE  l_docdt                LIKE xrca_t.xrcadocdt

   LET g_action_choice = ""

   LET g_qryparam.state = "i"

   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")

   LET g_forupd_sql = "SELECT xrcbseq,xrcb029,'',xrcb021,'',xrcb005,xrcb010,'',xrcb011,'',xrcblegl,'',xrcb012,'',xrcb015,'',xrcb016,'',xrcb113",
                      "  FROM xrcb_t WHERE xrcbent=? AND xrcbld=? AND xrcbdocno=? AND xrcbseq=? FOR UPDATE"

   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE axrt300_12_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR

   LET g_forupd_sql = "SELECT xrceseq,xrce016,'',xrce018,'',xrce019,'',xrcelegl,'',xrce020,'',xrce022,'',xrce023,'',xrce119",
                      "  FROM xrce_t WHERE xrceent=? AND xrceld=? AND xrcedocno=? AND xrceseq=? FOR UPDATE"

   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE axrt300_12_bcl2 CURSOR FROM g_forupd_sql      # LOCK CURSOR

   LET INT_FLAG = FALSE
   LET lb_reproduce = FALSE

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #Page1
      INPUT ARRAY g_xrcb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)

         #自訂ACTION(detail_input,page_1)


         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN
              CALL FGL_SET_ARR_CURR(g_xrcb_d.getLength()+1)
              LET g_insert = 'N'
           END IF

            CALL axrt300_12_b_fill()
            LET g_detail_cnt = g_xrcb_d.getLength()

         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_xrcb_d.getLength() TO FORMONLY.cnt

            CALL s_transaction_begin()
            LET g_detail_cnt = g_xrcb_d.getLength()

            IF g_detail_cnt >= l_ac AND g_xrcb_d[l_ac].xrcbseq IS NOT NULL THEN
               LET l_cmd='u'
               LET g_xrcb_d_t.* = g_xrcb_d[l_ac].*  #BACKUP
               IF NOT axrt300_12_lock_b("xrcb_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axrt300_12_bcl INTO g_xrcb_d[l_ac].xrcbseq,  g_xrcb_d[l_ac].xrcb029,  g_xrcb_d[l_ac].xrcb029_t,g_xrcb_d[l_ac].xrcb021,
                                            g_xrcb_d[l_ac].xrcb021_t,g_xrcb_d[l_ac].xrcb005,  g_xrcb_d[l_ac].xrcb010,  g_xrcb_d[l_ac].xrcb010_t,
                                            g_xrcb_d[l_ac].xrcb011,  g_xrcb_d[l_ac].xrcb011_t,g_xrcb_d[l_ac].xrcblegl, g_xrcb_d[l_ac].xrcblegl_t,
                                            g_xrcb_d[l_ac].xrcb012,  g_xrcb_d[l_ac].xrcb012_t,g_xrcb_d[l_ac].xrcb015,  g_xrcb_d[l_ac].xrcb015_t,
                                            g_xrcb_d[l_ac].xrcb016,  g_xrcb_d[l_ac].xrcb016_t,g_xrcb_d[l_ac].xrcb113
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_xrcb_d_t.xrcbseq
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF

                  CALL axrt300_12_detail_show('xrcb')
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF

         BEFORE INSERT

         AFTER INSERT

         BEFORE DELETE                            #是否取消單身

         AFTER DELETE

         #----<<xrcb029>>----
         BEFORE FIELD xrcb029_t

         AFTER FIELD xrcb029_t
            IF NOT cl_null(g_xrcb_d[l_ac].xrcb029_t) THEN
               IF g_xrcb_d[l_ac].xrcb029_t != g_xrcb_d_t.xrcb029_t OR g_xrcb_d_t.xrcb029_t IS NULL THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_glaa_t.glaa004
                  LET g_chkparam.arg2 = g_xrcb_d[l_ac].xrcb029_t
                  LET g_errshow = TRUE   #160318-00025#13
                  LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"    #160318-00025#13
                  IF NOT cl_chk_exist("v_glac002_4") THEN
                     LET g_xrcb_d[l_ac].xrcb029 = g_xrcb_d_t.xrcb029
                     CALL axrt300_12_ref('xrcb029_t')
                     NEXT FIELD CURRENT
                  END IF
                  LET g_xrcb_d[l_ac].xrcb029 = g_xrcb_d[l_ac].xrcb029_t
                  LET g_xrcb_d_t.xrcb029_t = g_xrcb_d[l_ac].xrcb029_t
               END IF
            END IF
            CALL axrt300_12_ref('xrcb029_t')

         #----<<xrcb021>>----
         BEFORE FIELD xrcb021_t

         AFTER FIELD xrcb021_t
            IF NOT cl_null(g_xrcb_d[l_ac].xrcb021_t) THEN
               IF g_xrcb_d[l_ac].xrcb021_t != g_xrcb_d_t.xrcb021_t OR g_xrcb_d_t.xrcb021_t IS NULL THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_glaa_t.glaa004
                  LET g_chkparam.arg2 = g_xrcb_d[l_ac].xrcb021_t
                  LET g_errshow = TRUE   #160318-00025#13
                  LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"    #160318-00025#13
                  IF NOT cl_chk_exist("v_glac002_4") THEN
                     LET g_xrcb_d[l_ac].xrcb021 = g_xrcb_d_t.xrcb021
                     CALL axrt300_12_ref('xrcb021_t')
                     NEXT FIELD CURRENT
                  END IF
                  LET g_xrcb_d[l_ac].xrcb021 = g_xrcb_d[l_ac].xrcb021_t
                  LET g_xrcb_d_t.xrcb021_t = g_xrcb_d[l_ac].xrcb021_t
               END IF
            END IF
            CALL axrt300_12_ref('xrcb021_t')

         #----<<xrcb010>>----
         BEFORE FIELD xrcb010_t

         AFTER FIELD xrcb010_t
            IF NOT cl_null(g_xrcb_d[l_ac].xrcb010_t) THEN
               IF g_xrcb_d[l_ac].xrcb010_t != g_xrcb_d_t.xrcb010_t OR g_xrcb_d_t.xrcb010_t IS NULL THEN
                  SELECT xrcadocdt INTO l_docdt FROM xrca_t WHERE xrcaent = g_enterprise
                     AND xrcadocno = g_xrcbdocno AND xrcald = g_xrcbld
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xrcb_d[l_ac].xrcb010_t
                  LET g_chkparam.arg2 = l_docdt
                  LET g_errshow = TRUE   #160318-00025#13
                  LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"    #160318-00025#13 
                  LET g_chkparam.err_str[2] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"    #160318-00025#13                
                  IF NOT cl_chk_exist("v_ooeg001") THEN
                     LET g_xrcb_d[l_ac].xrcb010 = g_xrcb_d_t.xrcb010
                     CALL axrt300_12_ref('xrcb010_t')
                     NEXT FIELD CURRENT
                  END IF
                  LET g_xrcb_d[l_ac].xrcb010 = g_xrcb_d[l_ac].xrcb010_t
                  LET g_xrcb_d_t.xrcb010_t = g_xrcb_d[l_ac].xrcb010_t
               END IF
            END IF
            CALL axrt300_12_ref('xrcb010_t')

         #----<<xrcb011>>----
         BEFORE FIELD xrcb011_t

         AFTER FIELD xrcb011_t
            IF NOT cl_null(g_xrcb_d[l_ac].xrcb011_t) THEN
               IF g_xrcb_d[l_ac].xrcb011_t != g_xrcb_d_t.xrcb011_t OR g_xrcb_d_t.xrcb011_t IS NULL THEN
                  SELECT xrcadocdt INTO l_docdt FROM xrca_t WHERE xrcaent = g_enterprise
                     AND xrcadocno = g_xrcbdocno AND xrcald = g_xrcbld
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xrcb_d[l_ac].xrcb011_t
                  LET g_chkparam.arg2 = l_docdt
                  LET g_errshow = TRUE   #160318-00025#13                 
                  LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"    #160318-00025#13        
                  IF NOT cl_chk_exist("v_ooeg001_4") THEN
                     LET g_xrcb_d[l_ac].xrcb011 = g_xrcb_d_t.xrcb011
                     CALL axrt300_12_ref('xrcb011_t')
                     NEXT FIELD CURRENT
                  END IF
                  LET g_xrcb_d[l_ac].xrcb011 = g_xrcb_d[l_ac].xrcb011_t
                  LET g_xrcb_d_t.xrcb011_t = g_xrcb_d[l_ac].xrcb011_t
               END IF
            END IF
            CALL axrt300_12_ref('xrcb011_t')

         #----<<xrcblegl>>----
         BEFORE FIELD xrcblegl_t

         AFTER FIELD xrcblegl_t
            IF NOT cl_null(g_xrcb_d[l_ac].xrcblegl_t) THEN
               IF g_xrcb_d[l_ac].xrcblegl_t != g_xrcb_d_t.xrcblegl_t OR g_xrcb_d_t.xrcblegl_t IS NULL THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xrcb_d[l_ac].xrcblegl_t
                  LET g_chkparam.arg2 = ' '
                  LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"    #160318-00025#13
                  IF NOT cl_chk_exist("v_ooef001_14") THEN
                     LET g_xrcb_d[l_ac].xrcblegl = g_xrcb_d_t.xrcblegl
                     CALL axrt300_12_ref('xrcblegl_t')
                     NEXT FIELD CURRENT
                  END IF
                  LET g_xrcb_d[l_ac].xrcblegl = g_xrcb_d[l_ac].xrcblegl_t
                  LET g_xrcb_d_t.xrcblegl_t = g_xrcb_d[l_ac].xrcblegl_t
               END IF
            END IF
            CALL axrt300_12_ref('xrcblegl_t')

         #----<<xrcb012>>----
         BEFORE FIELD xrcb012_t

         AFTER FIELD xrcb012_t
            IF NOT cl_null(g_xrcb_d[l_ac].xrcb012_t) THEN
               IF g_xrcb_d[l_ac].xrcb012_t != g_xrcb_d_t.xrcb012_t OR g_xrcb_d_t.xrcb012_t IS NULL THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xrcb_d[l_ac].xrcb012_t
                  LET g_chkparam.arg2 = ' '
                  LET g_errshow = TRUE   #160318-00025#13
                  LET g_chkparam.err_str[1] = "anm-00081:sub-01302|aimi010|",cl_get_progname("aimi010",g_lang,"2"),"|:EXEPROGaimi010"    #160318-00025#13
                  IF NOT cl_chk_exist("v_rtax001") THEN
                     LET g_xrcb_d[l_ac].xrcb012 = g_xrcb_d_t.xrcb012
                     CALL axrt300_12_ref('xrcb012_t')
                     NEXT FIELD CURRENT
                  END IF
                  LET g_xrcb_d[l_ac].xrcb012 = g_xrcb_d[l_ac].xrcb012_t
                  LET g_xrcb_d_t.xrcb012_t = g_xrcb_d[l_ac].xrcb012_t
               END IF
            END IF
            CALL axrt300_12_ref('xrcb012_t')

         #----<<xrcb015>>----
         BEFORE FIELD xrcb015_t

         AFTER FIELD xrcb015_t
            LET g_xrcb_d[l_ac].xrcb015 = g_xrcb_d[l_ac].xrcb015_t
            CALL axrt300_12_ref('xrcb015_t')

         #----<<xrcb016>>----
         BEFORE FIELD xrcb016_t

         AFTER FIELD xrcb016_t
            LET g_xrcb_d[l_ac].xrcb016 = g_xrcb_d[l_ac].xrcb016_t
            CALL axrt300_12_ref('xrcb016_t')

         #----<<xrcb113>>----
         BEFORE FIELD xrcb113

         AFTER FIELD xrcb113

         #---------------------<  Detail: page1  >---------------------
         #----<<xrcb029>>----
         #Ctrlp:input.c.page1.xrcb029
          ON ACTION controlp INFIELD xrcb029_t
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrcb_d[l_ac].xrcb029       #給予default值

            CALL aglt310_04()                                      #呼叫開窗

            LET g_xrcb_d[l_ac].xrcb029 = g_qryparam.return1        #將開窗取得的值回傳到變數
            CALL axrt300_12_ref('xrcb029_t')
            
            LET g_xrcb_d_t.xrcb029_t = g_xrcb_d[l_ac].xrcb029_t

            NEXT FIELD xrcb029_t                                   #返回原欄位
            
         #----<<xrcb021>>----
         #Ctrlp:input.c.page1.xrcb021
          ON ACTION controlp INFIELD xrcb021_t
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrcb_d[l_ac].xrcb021       #給予default值

            CALL aglt310_04()                                      #呼叫開窗

            LET g_xrcb_d[l_ac].xrcb021 = g_qryparam.return1        #將開窗取得的值回傳到變數
            CALL axrt300_12_ref('xrcb021_t')

            LET g_xrcb_d_t.xrcb021_t = g_xrcb_d[l_ac].xrcb021_t

            NEXT FIELD xrcb021_t                                   #返回原欄位
            
         #----<<xrcb010>>----
         #Ctrlp:input.c.page1.xrcb010
          ON ACTION controlp INFIELD xrcb010_t
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrcb_d[l_ac].xrcb010       #給予default值

            SELECT xrcadocdt INTO l_docdt FROM xrca_t WHERE xrcaent = g_enterprise
               AND xrcadocno = g_xrcbdocno AND xrcald = g_xrcbld

            LET g_qryparam.arg1 = l_docdt                          #給予default值

            CALL q_ooeg001()                                       #呼叫開窗

            LET g_xrcb_d[l_ac].xrcb010 = g_qryparam.return1        #將開窗取得的值回傳到變數
            CALL axrt300_12_ref('xrcb010_t')

            LET g_xrcb_d_t.xrcb010_t = g_xrcb_d[l_ac].xrcb010_t

            NEXT FIELD xrcb010_t                                   #返回原欄位
            
         #----<<xrcb011>>----
         #Ctrlp:input.c.page1.xrcb011
         ON ACTION controlp INFIELD xrcb011_t
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrcb_d[l_ac].xrcb011       #給予default值

            SELECT xrcadocdt INTO l_docdt FROM xrca_t WHERE xrcaent = g_enterprise
               AND xrcadocno = g_xrcbdocno AND xrcald = g_xrcbld

            LET g_qryparam.arg1 = l_docdt                          #給予default值

            CALL q_ooeg001_5()                                     #呼叫開窗

            LET g_xrcb_d[l_ac].xrcb011 = g_qryparam.return1        #將開窗取得的值回傳到變數
            CALL axrt300_12_ref('xrcb011_t')

            LET g_xrcb_d_t.xrcb011_t = g_xrcb_d[l_ac].xrcb011_t

            NEXT FIELD xrcb011_t                                   #返回原欄位
            
         #----<<xrcblegl>>----
         #Ctrlp:input.c.page1.xrcblegl
          ON ACTION controlp INFIELD xrcblegl_t
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrcb_d[l_ac].xrcblegl     #給予default值

            CALL q_ooef001()                                      #呼叫開窗

            LET g_xrcb_d[l_ac].xrcblegl = g_qryparam.return1      #將開窗取得的值回傳到變數
            CALL axrt300_12_ref('xrcblegl_t')

            LET g_xrcb_d_t.xrcblegl_t = g_xrcb_d[l_ac].xrcblegl_t

            NEXT FIELD xrcblegl_t                                 #返回原欄位

         #----<<xrcb012>>----
         #Ctrlp:input.c.page1.xrcb012
          ON ACTION controlp INFIELD xrcb012_t
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrcb_d[l_ac].xrcb012       #給予default值

            CALL q_rtax001()                                       #呼叫開窗

            LET g_xrcb_d[l_ac].xrcb012 = g_qryparam.return1        #將開窗取得的值回傳到變數
            CALL axrt300_12_ref('xrcb012_t')

            LET g_xrcb_d_t.xrcb012_t = g_xrcb_d[l_ac].xrcb012_t

            NEXT FIELD xrcb012_t                                   #返回原欄位

         #----<<xrcb015>>----
         #Ctrlp:input.c.page1.xrcb015
          ON ACTION controlp INFIELD xrcb015_t


         #----<<xrcb016>>----
         #Ctrlp:input.c.page1.xrcb016
          ON ACTION controlp INFIELD xrcb016_t

         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_xrcb_d[l_ac].* = g_xrcb_d_t.*
               CLOSE axrt300_12_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_xrcb_d[l_ac].xrcbseq
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_xrcb_d[l_ac].* = g_xrcb_d_t.*
            ELSE

               #寫入修改者/修改日期資訊(單身)

               UPDATE xrcb_t SET (xrcb029,xrcb021,xrcb010,xrcb011,xrcblegl,xrcb012,xrcb015,xrcb016)
                               = (g_xrcb_d[l_ac].xrcb029, g_xrcb_d[l_ac].xrcb021,g_xrcb_d[l_ac].xrcb010,g_xrcb_d[l_ac].xrcb011,
                                  g_xrcb_d[l_ac].xrcblegl,g_xrcb_d[l_ac].xrcb012,g_xrcb_d[l_ac].xrcb015,g_xrcb_d[l_ac].xrcb016)
                WHERE xrcbent = g_enterprise AND xrcbld = g_xrcbld #項次
                  AND xrcbdocno = g_xrcbdocno
                  AND xrcbseq = g_xrcb_d_t.xrcbseq

               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "xrcb_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode         #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "xrcb_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
               END CASE
            END IF

         AFTER ROW
            CALL axrt300_12_unlock_b("xrcb_t")
            CALL s_transaction_end('Y','0')

         AFTER INPUT

         ON ACTION controlo
            CALL FGL_SET_ARR_CURR(g_xrcb_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_xrcb_d.getLength()+1

      END INPUT

      #Page2
      INPUT ARRAY g_xrce_d FROM s_detail2.*
          ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)

         #自訂ACTION(detail_input,page_1)

         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN
              CALL FGL_SET_ARR_CURR(g_xrce_d.getLength()+1)
              LET g_insert = 'N'
           END IF

            CALL axrt300_12_b_fill()
            LET g_detail_cnt = g_xrce_d.getLength()

         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_xrce_d.getLength() TO FORMONLY.cnt

            CALL s_transaction_begin()
            LET g_detail_cnt = g_xrce_d.getLength()

            IF g_detail_cnt >= l_ac AND g_xrce_d[l_ac].xrceseq IS NOT NULL THEN
               LET l_cmd='u'
               LET g_xrce_d_t.* = g_xrce_d[l_ac].*  #BACKUP
               IF NOT axrt300_12_lock_b("xrce_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axrt300_12_bcl2 INTO g_xrce_d[l_ac].xrceseq,   g_xrce_d[l_ac].xrce016,g_xrce_d[l_ac].xrce016_t,g_xrce_d[l_ac].xrce018,
                                             g_xrce_d[l_ac].xrce018_t, g_xrce_d[l_ac].xrce019,g_xrce_d[l_ac].xrce019_t,g_xrce_d[l_ac].xrcelegl,
                                             g_xrce_d[l_ac].xrcelegl_t,g_xrce_d[l_ac].xrce020,g_xrce_d[l_ac].xrce020_t,g_xrce_d[l_ac].xrce022,
                                             g_xrce_d[l_ac].xrce022_t, g_xrce_d[l_ac].xrce023,g_xrce_d[l_ac].xrce023_t,g_xrce_d[l_ac].xrce119
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_xrce_d_t.xrceseq
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF

                  CALL axrt300_12_detail_show('xrcb')
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF

         BEFORE INSERT

         AFTER INSERT

         BEFORE DELETE                            #是否取消單身

         AFTER DELETE

         #----<<xrce016>>----
         BEFORE FIELD xrce016_t

         AFTER FIELD xrce016_t
            IF NOT cl_null(g_xrce_d[l_ac].xrce016_t) THEN
               IF g_xrce_d[l_ac].xrce016_t != g_xrce_d_t.xrce016_t OR g_xrce_d_t.xrce016_t IS NULL THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_glaa_t.glaa004
                  LET g_chkparam.arg2 = g_xrce_d[l_ac].xrce016_t
                  LET g_errshow = TRUE   #160318-00025#13
                  LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"    #160318-00025#13
                  IF NOT cl_chk_exist("v_glac002_4") THEN
                     LET g_xrce_d[l_ac].xrce016 = g_xrce_d_t.xrce016
                     CALL axrt300_12_ref('xrce016_t')
                     NEXT FIELD CURRENT
                  END IF
                  LET g_xrce_d[l_ac].xrce016 = g_xrce_d[l_ac].xrce016_t
                  LET g_xrce_d_t.xrce016_t = g_xrce_d[l_ac].xrce016_t
               END IF
            END IF
            CALL axrt300_12_ref('xrce016_t')

         #----<<xrce018>>----
         BEFORE FIELD xrce018_t

         AFTER FIELD xrce018_t
            IF NOT cl_null(g_xrce_d[l_ac].xrce018_t) THEN
               IF g_xrce_d[l_ac].xrce018_t != g_xrce_d_t.xrce018_t OR g_xrce_d_t.xrce018_t IS NULL THEN
                  SELECT xrcadocdt INTO l_docdt FROM xrca_t WHERE xrcaent = g_enterprise
                     AND xrcadocno = g_xrcbdocno AND xrcald = g_xrcbld
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xrce_d[l_ac].xrce018_t
                  LET g_chkparam.arg2 = l_docdt
                  LET g_errshow = TRUE   #160318-00025#13
                  LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"    #160318-00025#13 
                  LET g_chkparam.err_str[2] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"    #160318-00025#13                
                  IF NOT cl_chk_exist("v_ooeg001") THEN
                     LET g_xrce_d[l_ac].xrce018 = g_xrce_d_t.xrce018
                     CALL axrt300_12_ref('xrce018_t')
                     NEXT FIELD CURRENT
                  END IF
                  LET g_xrce_d[l_ac].xrce018 = g_xrce_d[l_ac].xrce018_t
                  LET g_xrce_d_t.xrce018_t = g_xrce_d[l_ac].xrce018_t
               END IF
            END IF
            CALL axrt300_12_ref('xrce018_t')

         #----<<xrce019>>----
         BEFORE FIELD xrce019_t

         AFTER FIELD xrce019_t
            IF NOT cl_null(g_xrce_d[l_ac].xrce019_t) THEN
               IF g_xrce_d[l_ac].xrce019_t != g_xrce_d_t.xrce019_t OR g_xrce_d_t.xrce019_t IS NULL THEN
                  SELECT xrcadocdt INTO l_docdt FROM xrca_t WHERE xrcaent = g_enterprise
                     AND xrcadocno = g_xrcbdocno AND xrcald = g_xrcbld
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xrce_d[l_ac].xrce019_t
                  LET g_chkparam.arg2 = l_docdt
                  LET g_errshow = TRUE   #160318-00025#13                 
                  LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"    #160318-00025#13        
                  IF NOT cl_chk_exist("v_ooeg001_4") THEN
                     LET g_xrce_d[l_ac].xrce019 = g_xrce_d_t.xrce019
                     CALL axrt300_12_ref('xrce019_t')
                     NEXT FIELD CURRENT
                  END IF
                  LET g_xrce_d[l_ac].xrce019 = g_xrce_d[l_ac].xrce019_t
                  LET g_xrce_d_t.xrce019_t = g_xrce_d[l_ac].xrce019_t
               END IF
            END IF
            CALL axrt300_12_ref('xrce019_t')

         #----<<xrcelegl>>----
         BEFORE FIELD xrcelegl_t

         AFTER FIELD xrcelegl_t
            IF NOT cl_null(g_xrce_d[l_ac].xrcelegl_t) THEN
               IF g_xrce_d[l_ac].xrcelegl_t != g_xrce_d_t.xrcelegl_t OR g_xrce_d_t.xrcelegl_t IS NULL THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xrce_d[l_ac].xrcelegl_t
                  LET g_chkparam.arg2 = ' '
                  LET g_errshow = TRUE   #160318-00025#13
                  LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"    #160318-00025#13
                  IF NOT cl_chk_exist("v_ooef001_14") THEN
                     LET g_xrce_d[l_ac].xrcelegl = g_xrce_d_t.xrcelegl
                     CALL axrt300_12_ref('xrcelegl_t')
                     NEXT FIELD CURRENT
                  END IF
                  LET g_xrce_d[l_ac].xrcelegl = g_xrce_d[l_ac].xrcelegl_t
                  LET g_xrce_d_t.xrcelegl_t = g_xrce_d[l_ac].xrcelegl_t
               END IF
            END IF
            CALL axrt300_12_ref('xrcelegl_t')

         #----<<xrce020>>----
         BEFORE FIELD xrce020_t

         AFTER FIELD xrce020_t
            IF NOT cl_null(g_xrce_d[l_ac].xrce020_t) THEN
               IF g_xrce_d[l_ac].xrce020_t != g_xrce_d_t.xrce020_t OR g_xrce_d_t.xrce020_t IS NULL THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = "200"
                  LET g_chkparam.arg2 = g_xrce_d[l_ac].xrce020_t
                  LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "aqc-00032:sub-01302|aqci030|",cl_get_progname("aqci030",g_lang,"2"),"|:EXEPROGaqci030"    #160318-00025#13
                  IF NOT cl_chk_exist("v_oocq002_01") THEN
                     LET g_xrce_d[l_ac].xrce020 = g_xrce_d_t.xrce020
                     CALL axrt300_12_ref('xrce020_t')
                     NEXT FIELD CURRENT
                  END IF
                  LET g_xrce_d[l_ac].xrce020 = g_xrce_d[l_ac].xrce020_t
                  LET g_xrce_d_t.xrce020_t = g_xrce_d[l_ac].xrce020_t
               END IF
            END IF
            CALL axrt300_12_ref('xrce020_t')

         #----<<xrce022>>----
         BEFORE FIELD xrce022_t

         AFTER FIELD xrce022_t

         #----<<xrce023>>----
         BEFORE FIELD xrce023_t

         AFTER FIELD xrce023_t

         #---------------------<  Detail: page1  >---------------------
         #----<<xrce016>>----
         #Ctrlp:input.c.page1.xrce016
          ON ACTION controlp INFIELD xrce016_t
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrce_d[l_ac].xrce016       #給予default值

            CALL aglt310_04()                                      #呼叫開窗

            LET g_xrce_d[l_ac].xrce016 = g_qryparam.return1        #將開窗取得的值回傳到變數
            CALL axrt300_12_ref('xrce016_t')
            
            LET g_xrce_d_t.xrce016_t = g_xrce_d[l_ac].xrce016_t

            NEXT FIELD xrce016_t                                   #返回原欄位
            
         #----<<xrce018>>----
         #Ctrlp:input.c.page1.xrce018
          ON ACTION controlp INFIELD xrce018_t
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrce_d[l_ac].xrce018       #給予default值

            SELECT xrcadocdt INTO l_docdt FROM xrca_t WHERE xrcaent = g_enterprise
               AND xrcadocno = g_xrcbdocno AND xrcald = g_xrcbld

            LET g_qryparam.arg1 = l_docdt                          #給予default值

            CALL q_ooeg001()                                       #呼叫開窗

            LET g_xrce_d[l_ac].xrce018 = g_qryparam.return1        #將開窗取得的值回傳到變數
            CALL axrt300_12_ref('xrce018_t')

            LET g_xrce_d_t.xrce018_t = g_xrce_d[l_ac].xrce018_t

            NEXT FIELD xrce018_t                                   #返回原欄位
            
         #----<<xrce019>>----
         #Ctrlp:input.c.page1.xrce019
          ON ACTION controlp INFIELD xrce019_t
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrce_d[l_ac].xrce019       #給予default值

            SELECT xrcadocdt INTO l_docdt FROM xrca_t WHERE xrcaent = g_enterprise
               AND xrcadocno = g_xrcbdocno AND xrcald = g_xrcbld

            LET g_qryparam.arg1 = l_docdt                          #給予default值

            CALL q_ooeg001_5()                                     #呼叫開窗

            LET g_xrce_d[l_ac].xrce019 = g_qryparam.return1        #將開窗取得的值回傳到變數
            CALL axrt300_12_ref('xrce019_t')

            LET g_xrce_d_t.xrce019_t = g_xrce_d[l_ac].xrce019_t

            NEXT FIELD xrce019_t                                   #返回原欄位

         #----<<xrcelegl>>----
         #Ctrlp:input.c.page1.xrcelegl
          ON ACTION controlp INFIELD xrcelegl_t
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrce_d[l_ac].xrcelegl     #給予default值

            CALL q_ooef001()                                      #呼叫開窗

            LET g_xrce_d[l_ac].xrcelegl = g_qryparam.return1      #將開窗取得的值回傳到變數
            CALL axrt300_12_ref('xrcelegl_t')

            LET g_xrce_d_t.xrcelegl_t = g_xrce_d[l_ac].xrcelegl_t

            NEXT FIELD xrcelegl_t                                 #返回原欄位

         #----<<xrce020>>----
         #Ctrlp:input.c.page1.xrce020
          ON ACTION controlp INFIELD xrce020_t
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrce_d[l_ac].xrce020      #給予default值

            #給予arg
            LET g_qryparam.arg1 = "200"

            CALL q_oocq002_5()                                    #呼叫開窗

            LET g_xrce_d[l_ac].xrce020 = g_qryparam.return1       #將開窗取得的值回傳到變數

            CALL axrt300_12_ref('xrce020_t')
      
            LET g_xrce_d_t.xrce020_t = g_xrce_d[l_ac].xrce020_t
            
            NEXT FIELD xrce020_t                                  #返回原欄位

         #----<<xrce022>>----
         #Ctrlp:input.c.page1.xrce022
          ON ACTION controlp INFIELD xrce022

         #----<<xrce023>>----
         #Ctrlp:input.c.page1.xrce023
          ON ACTION controlp INFIELD xrce023

         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_xrce_d[l_ac].* = g_xrce_d_t.*
               CLOSE axrt300_12_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_xrce_d[l_ac].xrceseq
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_xrce_d[l_ac].* = g_xrce_d_t.*
            ELSE

               #寫入修改者/修改日期資訊(單身)

               UPDATE xrce_t SET (xrce016,xrce018,xrce019,xrcelegl,xrce020,xrce022,xrce023)
                               = (g_xrce_d[l_ac].xrce016,g_xrce_d[l_ac].xrce018,g_xrce_d[l_ac].xrce019,g_xrce_d[l_ac].xrcelegl,
                                  g_xrce_d[l_ac].xrce020,g_xrce_d[l_ac].xrce022,g_xrce_d[l_ac].xrce023)
                WHERE xrceent = g_enterprise AND xrceld = g_xrcbld #項次
                  AND xrcedocno = g_xrcbdocno
                  AND xrceseq = g_xrce_d_t.xrceseq

               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "xrce_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode         #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "xrce_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
               END CASE
            END IF

         AFTER ROW
            CALL axrt300_12_unlock_b("xrce_t")
            CALL s_transaction_end('Y','0')

         AFTER INPUT

         ON ACTION controlo
            CALL FGL_SET_ARR_CURR(g_xrce_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_xrce_d.getLength()+1

      END INPUT

      BEFORE DIALOG
         IF g_temp_idx > 0 THEN
            LET l_ac = g_temp_idx
            CALL DIALOG.setCurrentRow("s_detail1",l_ac)
            LET g_temp_idx = 1
         END IF
         LET g_curr_diag = ui.DIALOG.getCurrent()
         CASE g_aw
            WHEN "s_detail1"
               NEXT FIELD xrcb029_t
            WHEN "s_detail2"
               NEXT FIELD xrce016_t
         END CASE

      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION controlr
         CALL cl_show_req_fields()

      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode())
              RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG

   END DIALOG

   CLOSE axrt300_12_bcl
   CLOSE axrt300_12_bcl2
   CALL s_transaction_end('Y','0')

END FUNCTION

PRIVATE FUNCTION axrt300_12_detail_show(p_cmd)
   DEFINE p_cmd         LIKE type_t.chr10

   IF p_cmd = 'xrcb' THEN
      CALL axrt300_12_ref('xrcb029_t')
   
      CALL axrt300_12_ref('xrcb021_t')
   
      CALL axrt300_12_ref('xrcb010_t')
   
      CALL axrt300_12_ref('xrcb011_t')
   
      CALL axrt300_12_ref('xrcblegl_t')
   
      CALL axrt300_12_ref('xrcb012_t')
   
      CALL axrt300_12_ref('xrcb015_t')
   
      CALL axrt300_12_ref('xrcb016_t')
   END IF

   IF p_cmd = 'xrce' THEN
      CALL axrt300_12_ref('xrce016_t')
   
      CALL axrt300_12_ref('xrce018_t')
   
      CALL axrt300_12_ref('xrce019_t')
   
      CALL axrt300_12_ref('xrcelegl_t')
   
      CALL axrt300_12_ref('xrce020_t')
   
      CALL axrt300_12_ref('xrce022_t')
   
      CALL axrt300_12_ref('xrce023_t')
   END IF
END FUNCTION

PRIVATE FUNCTION axrt300_12_set_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1

END FUNCTION

PRIVATE FUNCTION axrt300_12_set_no_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1

END FUNCTION

PRIVATE FUNCTION axrt300_12_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING

   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " xrcbld = '", g_argv[1], "' AND "
   END IF

   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xrcbdocno = ", g_argv[02], " AND "
   END IF

   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xrcbseq = ", g_argv[03], " AND "
   END IF



   IF NOT cl_null(ls_wc) THEN
      LET ls_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_wc2 = ls_wc
   ELSE
      LET g_wc2 = " 1=1"
   END IF

END FUNCTION

PRIVATE FUNCTION axrt300_12_lock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING

   LET ls_group = "xrcb_t"

   IF ps_table = 'xrcb_t' THEN
      OPEN axrt300_12_bcl USING g_enterprise,g_xrcbld,g_xrcbdocno,g_xrcb_d[g_detail_idx].xrcbseq

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "axrt300_12_bcl"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF

   IF ps_table = 'xrce_t' THEN
      OPEN axrt300_12_bcl2 USING g_enterprise,g_xrcbld,g_xrcbdocno,g_xrce_d[g_detail_idx].xrceseq

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "axrt300_12_bcl2"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF

   RETURN TRUE

END FUNCTION

PRIVATE FUNCTION axrt300_12_unlock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING

   LET ls_group = ""

   CLOSE axrt300_12_bcl
   CLOSE axrt300_12_bcl2

END FUNCTION
################################################################################
# Descriptions...: 刷新欄位說明
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
PRIVATE FUNCTION axrt300_12_ref(p_lab)
   DEFINE p_lab      LIKE type_t.chr20
   
   CASE
      WHEN p_lab = 'xrcb029_t'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xrcb_d[l_ac].xrcb029
         CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001='"||g_glaa_t.glaa004||"' AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xrcb_d[l_ac].xrcb029_t = g_xrcb_d[l_ac].xrcb029,'(', g_rtn_fields[1] , ')'
         DISPLAY g_xrcb_d[l_ac].xrcb029_t TO s_detail1[l_ac].xrcb029_t
      WHEN p_lab = 'xrcb021_t'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xrcb_d[l_ac].xrcb021
         CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001='"||g_glaa_t.glaa004||"' AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xrcb_d[l_ac].xrcb021_t = g_xrcb_d[l_ac].xrcb021,'(', g_rtn_fields[1] , ')'
         DISPLAY g_xrcb_d[l_ac].xrcb021_t TO s_detail1[l_ac].xrcb021_t
      WHEN p_lab = 'xrcb010_t'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xrcb_d[l_ac].xrcb010
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xrcb_d[l_ac].xrcb010_t = g_xrcb_d[l_ac].xrcb010,'(', g_rtn_fields[1] , ')'
         DISPLAY g_xrcb_d[l_ac].xrcb010_t TO s_detail1[l_ac].xrcb010_t
      WHEN p_lab = 'xrcb011_t'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xrcb_d[l_ac].xrcb011
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xrcb_d[l_ac].xrcb011_t = g_xrcb_d[l_ac].xrcb011,'(', g_rtn_fields[1] , ')'
         DISPLAY g_xrcb_d[l_ac].xrcb011_t TO s_detail1[l_ac].xrcb011_t
      WHEN p_lab = 'xrcblegl_t'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xrcb_d[l_ac].xrcblegl
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xrcb_d[l_ac].xrcblegl_t = g_xrcb_d[l_ac].xrcblegl,'(', g_rtn_fields[1] , ')'
         DISPLAY g_xrcb_d[l_ac].xrcblegl_t TO s_detail1[l_ac].xrcblegl_t
      WHEN p_lab = 'xrcb012_t'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xrcb_d[l_ac].xrcb012
         CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xrcb_d[l_ac].xrcb012_t = g_xrcb_d[l_ac].xrcb012,'(', g_rtn_fields[1] , ')'
         DISPLAY g_xrcb_d[l_ac].xrcb012_t TO s_detail1[l_ac].xrcb012_t
      WHEN p_lab = 'xrcb015_t'
         LET g_xrcb_d[l_ac].xrcb015_t = g_xrcb_d[l_ac].xrcb015,'(',')'
         DISPLAY g_xrcb_d[l_ac].xrcb015_t TO s_detail1[l_ac].xrcb015_t
      WHEN p_lab = 'xrcb016_t'
         LET g_xrcb_d[l_ac].xrcb016_t = g_xrcb_d[l_ac].xrcb016,'(',')'
         DISPLAY g_xrcb_d[l_ac].xrcb016_t TO s_detail1[l_ac].xrcb016_t

      WHEN p_lab = 'xrce016_t'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xrce_d[l_ac].xrce016
         CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001='"||g_glaa_t.glaa004||"' AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xrce_d[l_ac].xrce016_t = g_xrce_d[l_ac].xrce016,'(', g_rtn_fields[1] , ')'
         DISPLAY g_xrce_d[l_ac].xrce016_t TO s_detail2[l_ac].xrce016_t
      WHEN p_lab = 'xrce018_t'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xrce_d[l_ac].xrce018
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xrce_d[l_ac].xrce018_t = g_xrce_d[l_ac].xrce018,'(', g_rtn_fields[1] , ')'
         DISPLAY g_xrce_d[l_ac].xrce018_t TO s_detail2[l_ac].xrce018_t
      WHEN p_lab = 'xrce019_t'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xrce_d[l_ac].xrce019
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xrce_d[l_ac].xrce019_t = g_xrce_d[l_ac].xrce019,'(', g_rtn_fields[1] , ')'
         DISPLAY g_xrce_d[l_ac].xrce019_t TO s_detail2[l_ac].xrce019_t
      WHEN p_lab = 'xrcelegl_t'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xrce_d[l_ac].xrcelegl
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xrce_d[l_ac].xrcelegl_t = g_xrce_d[l_ac].xrcelegl,'(', g_rtn_fields[1] , ')'
         DISPLAY g_xrce_d[l_ac].xrcelegl_t TO s_detail2[l_ac].xrcelegl_t
      WHEN p_lab = 'xrce020_t'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xrce_d[l_ac].xrce020
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='200' AND oocql002=? AND oocql003='"||g_lang||"'","") RETURNING g_rtn_fields
         LET g_xrce_d[l_ac].xrce020_t = g_xrce_d[l_ac].xrce020,'(', g_rtn_fields[1] , ')'
         DISPLAY g_xrce_d[l_ac].xrce020_t TO s_detail2[l_ac].xrce020_t
      WHEN p_lab = 'xrce022_t'
         LET g_xrce_d[l_ac].xrce022_t = g_xrce_d[l_ac].xrce022,'(',')'
         DISPLAY g_xrce_d[l_ac].xrce022_t TO s_detail2[l_ac].xrce022_t
      WHEN p_lab = 'xrce023_t'
         LET g_xrce_d[l_ac].xrce023_t = g_xrce_d[l_ac].xrce023,'(',')'
         DISPLAY g_xrce_d[l_ac].xrce023_t TO s_detail2[l_ac].xrce023_t
   END CASE

END FUNCTION

 
{</section>}
 
