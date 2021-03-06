#該程式未解開Section, 採用最新樣板產出!
{<section id="axrt400_06.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2014-08-21 10:21:50), PR版次:0005(2016-11-22 13:34:26)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000231
#+ Filename...: axrt400_06
#+ Description: 沖銷發票資料挑選
#+ Creator....: 01727(2013-11-26 16:31:38)
#+ Modifier...: 01727 -SD/PR- 07900
 
{</section>}
 
{<section id="axrt400_06.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160905-00002#5   2016/09/05  By 08729    處理SQL條件多一項ENT
#161118-00019#2   2016/11/22  By 07900    numt5 to num10(需人工调整部分)
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
 
{<section id="axrt400_06.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
 TYPE type_g_isaf_d        RECORD
       check          LIKE type_t.chr80, 
       isaf011        LIKE isaf_t.isaf011,
       isaf010        LIKE isaf_t.isaf010,
       isaf014        LIKE isaf_t.isaf014,
       isaf025        LIKE isaf_t.isaf025,
       isaf028        LIKE isaf_t.isaf028,
       isag105        LIKE isag_t.isag105,
       isag115        LIKE isag_t.isag115,
       isaf008        LIKE isaf_t.isaf008,
       isaf002        LIKE isaf_t.isaf002,
       lbl_n1         LIKE isag_t.isag105
       END RECORD
 
 

DEFINE g_isaf_d          DYNAMIC ARRAY OF type_g_isaf_d
DEFINE g_isaf_d_t        type_g_isaf_d
DEFINE g_isaf_d_sel      DYNAMIC ARRAY OF type_g_isaf_d
 
DEFINE l_ac                  LIKE type_t.num10        #161118-00019#2 mod  type_t.num5 -> type_t.num10
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rec_b               LIKE type_t.num10        #161118-00019#2 mod  type_t.num5 -> type_t.num10  
DEFINE g_detail_idx          LIKE type_t.num10        #161118-00019#2 mod  type_t.num5 -> type_t.num10 
DEFINE gi_multi_sel      LIKE type_t.num5   #是否需要複選資料(TRUE/FALSE)
DEFINE gi_need_cons      LIKE type_t.num5   #是否需要CONSTRUCT(TRUE/FALSE)
DEFINE gi_cons_where     STRING                #暫存CONSTRUCT區塊的WHERE條件
DEFINE gi_cons_where_old STRING                #暫存CONSTRUCT區塊的WHERE條件(舊的,用來比對條件是否改變)
 
DEFINE gs_default1       STRING 

DEFINE gi_page_count     LIKE type_t.num10  #每頁顯現資料筆數
DEFINE gs_pageswitch     STRING                #選擇的頁面
DEFINE gs_action         STRING
DEFINE gi_reconstruct    LIKE type_t.num5   #重新查詢
DEFINE g_pagestart       LIKE type_t.num10  #161118-00019#2 mod  type_t.num5 -> type_t.num10
DEFINE g_data_cnt        LIKE type_t.num5
DEFINE g_page_idx        LIKE type_t.num5   #目前所在頁數
DEFINE g_page_last       LIKE type_t.num5   #最後一頁
DEFINE g_sel_limit       LIKE type_t.num5   #選擇筆數的上限
DEFINE gwin_curr         ui.Window 
#end add-point
 
{</section>}
 
{<section id="axrt400_06.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="axrt400_06.other_dialog" >}

 
{</section>}
 
{<section id="axrt400_06.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 沖銷發票資料挑選
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
PUBLIC FUNCTION axrt400_06()
   DEFINE pi_multi_sel   LIKE type_t.num5
   DEFINE pi_need_cons   LIKE type_t.num5
   DEFINE lwin_curr      ui.Window
   DEFINE lfrm_curr      ui.Form
   DEFINE ls_path        STRING
 
   WHENEVER ERROR CALL cl_err_msg_log
 
   #目前因為cl_ap_formpath() lib尚未調整
   #所以open window路徑先寫死,未來應該要call cl_ap_formpath()
   OPEN WINDOW w_axrt400_06 WITH FORM cl_ap_formpath("axr","axrt400_06")
      ATTRIBUTE(STYLE="openwin")
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
   LET ls_path = os.Path.join(ls_path,"toolbar_openwin.4tb")
   CALL lfrm_curr.loadToolBar(ls_path)
   IF g_qryparam.state = 'i' THEN
      LET gi_multi_sel = FALSE
   ELSE
      LET gi_multi_sel = TRUE
   END IF 
   LET gi_need_cons = g_qryparam.reqry
   LET gs_default1 = g_qryparam.default1 

 
   CALL axrt400_06_init()
   CALL axrt400_06_sel()
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
   END IF 
 
   CLOSE WINDOW w_axrt400_06
 
END FUNCTION
################################################################################
# Descriptions...: 初始化
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
PRIVATE FUNCTION axrt400_06_init()
   DEFINE l_qry_text LIKE dzcal_t.dzcal003
   DEFINE l_qry_id   LIKE dzca_t.dzca001
   DEFINE l_text     STRING
 
   IF NOT (gi_multi_sel) THEN
      CALL cl_set_comp_visible("check", FALSE)
      CALL cl_set_toolbaritem_visible("selectall, selectnone, selectpageall, selectpagenone", FALSE)
   END IF
 
   IF (gi_multi_sel) THEN
      #lib尚未修正
      #CALL cl_set_comp_font_color("oea01", "red")
   END IF
 
   LET INT_FLAG = FALSE         #避免被其他函式影響
   LET g_page_idx = 0
   LET g_page_last = 0
   LET g_sel_limit = axrt400_06_get_sel_limit()     #選擇筆數的上限
   LET gi_page_count = axrt400_06_get_page_count()  #每頁顯現資料筆數
   LET gi_cons_where = " 1=1"   #預設查詢全部資料
   LET gi_cons_where_old = NULL
   LET gi_reconstruct = FALSE
   INITIALIZE gs_pageswitch TO NULL
   INITIALIZE gs_action TO NULL
   INITIALIZE g_qryparam.return1 TO NULL  

   CALL g_isaf_d.clear()
   CALL g_isaf_d_sel.clear()
 
   #動態設定comboBox項目
   ### 此開窗無comboBox的欄位 ###
 
   #設定開窗識別碼的說明
   LET gwin_curr = ui.Window.forName("w_qry")
   SELECT dzca001,dzcal003 INTO l_qry_id,l_qry_text FROM dzca_t
      LEFT JOIN dzcal_t ON dzcal001=dzca001 AND dzcal002=g_lang 
      WHERE dzca001="axrt400_06"
   LET l_text = l_qry_text,"(",l_qry_id,")"
   CALL gwin_curr.setText(l_text)
 
END FUNCTION
################################################################################
# Descriptions...: 取得每頁顯現資料筆數
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
PRIVATE FUNCTION axrt400_06_get_page_count()
   DEFINE l_sel_limit  LIKE type_t.num5,
          l_ooaa002    LIKE ooaa_t.ooaa002,
          l_default    LIKE type_t.num5
 
   LET l_default = 10 #設定預設值

   ##從dsdemo.ooaa_t提取開窗每頁顯現資料筆數
   #SELECT ooaa002 INTO l_ooaa002 FROM dsdemo.ooaa_t
   #   WHERE ooaa001= "E-SYS-0002"  #開窗每頁顯現資料筆數 >=10
   #     AND ooaaent = g_enterprise
   
   CALL cl_get_para(g_enterprise, g_site,"E-SYS-0002") RETURNING l_ooaa002
 
   IF l_ooaa002 <10 OR cl_null(l_ooaa002) THEN
      LET l_sel_limit = l_default
   ELSE
      LET l_sel_limit = l_ooaa002
   END IF
 
   RETURN l_sel_limit
END FUNCTION
################################################################################
# Descriptions...: 取得選擇筆數的上限
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
PRIVATE FUNCTION axrt400_06_get_sel_limit()
   DEFINE l_sel_limit  LIKE type_t.num5,
          l_ooaa002    LIKE ooaa_t.ooaa002,
          l_default    LIKE type_t.num5
 
   LET l_default = 200 #設定預設值
 
   #從資料庫提取開窗選擇筆數資料上限
   #SELECT ooaa002 INTO l_ooaa002 FROM dsdemo.ooaa_t
   #   WHERE ooaa001= "E-SYS-0003"  #開窗選擇筆數資料上限 >=200
   #     AND ooaaent = g_enterprise
   
   CALL cl_get_para(g_enterprise, g_site,"E-SYS-0003") RETURNING l_ooaa002
 
   IF l_ooaa002 <200 OR cl_null(l_ooaa002) THEN
      LET l_sel_limit = l_default
   ELSE
      LET l_sel_limit = l_ooaa002
   END IF
 
   RETURN l_sel_limit
END FUNCTION
################################################################################
# Descriptions...: 畫面顯現與資料的選擇.
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
PRIVATE FUNCTION axrt400_06_sel()
   WHILE TRUE
      CALL axrt400_06_prep_result_set()
 
      IF (gi_multi_sel) THEN
         CALL axrt400_06_input_array()
      ELSE
         CALL axrt400_06_display_array()
      END IF
 
      IF gs_action = "exit" THEN
         EXIT WHILE
      END IF
   END WHILE
END FUNCTION
################################################################################
# Descriptions...: 準備查詢畫面的資料集.
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
PRIVATE FUNCTION axrt400_06_prep_result_set()
   CALL g_isaf_d.clear()
   CALL g_isaf_d_sel.clear()
 
   IF (gi_need_cons) OR (gi_reconstruct) THEN
 
      #避免使用預先查詢時,按重新整理的時候,進入CONSTRUCT段
      LET gi_need_cons = FALSE
 
      LET gi_reconstruct = FALSE
      LET gi_cons_where_old = NULL
      DISPLAY "" TO formonly.index
      CONSTRUCT gi_cons_where ON isaf011,isaf010,isaf014,isaf025,isaf028,isag105,isag115,isaf008,isaf002,lbl_n1
         FROM s_detail1[l_ac].isaf011,s_detail1[l_ac].isaf010,s_detail1[l_ac].isaf014,s_detail1[l_ac].isaf025,s_detail1[l_ac].isaf028,s_detail1[l_ac].isag105,s_detail1[l_ac].isag115,s_detail1[l_ac].isaf008,s_detail1[l_ac].isaf002
      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         LET gi_cons_where = " 1=1"
      END IF
   END IF
 
   IF cl_null(gs_pageswitch) THEN
      LET gs_pageswitch = "first"
   END IF
   CALL axrt400_06_pagedata_fill(gs_pageswitch)
   INITIALIZE gs_pageswitch TO NULL
END FUNCTION
################################################################################
# Descriptions...: 採用INPUT ARRAY的方式來顯現查詢過後的資料.
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
PRIVATE FUNCTION axrt400_06_input_array()
   DEFINE li_ac     LIKE type_t.num5
   DEFINE ldig_curr ui.Dialog
   DEFINE l_msg     STRING           
   DEFINE l_chk     LIKE type_t.num5 
 
   #動態設定comboBox項目
   ### 此開窗無comboBox的欄位 ###
 
   DIALOG ATTRIBUTES(UNBUFFERED)
      INPUT ARRAY g_isaf_d FROM s_detail1.*
         ATTRIBUTES(COUNT=g_data_cnt, 
                    APPEND ROW=FALSE, INSERT ROW=FALSE, DELETE ROW=FALSE) 
         
         BEFORE INPUT
            CALL axrt400_06_set_pagebutton(ldig_curr) 
            
         BEFORE ROW
            LET li_ac = DIALOG.getCurrentRow("s_detail1") 
            
         ON CHANGE check   #改變勾選狀態
            CALL axrt400_06_qry_check("", g_isaf_d[li_ac].check, li_ac, li_ac)
      END INPUT
 
      BEFORE DIALOG
         LET ldig_curr = ui.Dialog.getCurrent()
 
      ON ACTION accept
         CALL axrt400_06_get_multiret()
         LET gs_action = "exit"
         EXIT DIALOG
         
      ON ACTION cancel
         LET g_qryparam.return1 = NULL
         
         LET gs_action = "exit"
         LET INT_FLAG = TRUE
         EXIT DIALOG
         
      ON ACTION pg_first
         CALL axrt400_06_pagedata_fill("first")
         CALL axrt400_06_set_pagebutton(ldig_curr)
         NEXT FIELD CURRENT
         
      ON ACTION pg_prev
         CALL axrt400_06_pagedata_fill("prev")
         CALL axrt400_06_set_pagebutton(ldig_curr)
         NEXT FIELD CURRENT
         
      ON ACTION pg_next
         CALL axrt400_06_pagedata_fill("next")
         CALL axrt400_06_set_pagebutton(ldig_curr)
         NEXT FIELD CURRENT
         
      ON ACTION pg_last
         CALL axrt400_06_pagedata_fill("last")
         CALL axrt400_06_set_pagebutton(ldig_curr)
         NEXT FIELD CURRENT
         
      #重新整理
      ON ACTION refresh
         CALL axrt400_06_pagedata_fill("first")
         CALL axrt400_06_set_pagebutton(ldig_curr)
         EXIT DIALOG
         
      #重新查詢
      ON ACTION reconstruct
         LET gi_reconstruct = TRUE
         CALL g_isaf_d.clear()
         CALL g_isaf_d_sel.clear()
         CALL axrt400_06_data_count("0")    #總筆數
         EXIT DIALOG
         
      #全部選取
      ON ACTION selectall
         # 連未選擇的頁面都必須選擇
         CALL axrt400_06_qry_check("selectall", "Y", 1, g_isaf_d.getLength()) 
         
      #全部取消選取
      ON ACTION selectnone
         CALL axrt400_06_qry_check("selectnone", "N", 1, g_isaf_d.getLength()) 
         
      #此頁全選
      ON ACTION selectpageall
         CALL axrt400_06_qry_check("selectpageall", "Y", 1, g_isaf_d.getLength()) 
         
      #此頁取消選取
      ON ACTION selectpagenone
         CALL axrt400_06_qry_check("selectpagenone", "N", 1, g_isaf_d.getLength()) 
         
      ON ACTION exporttoexcel
         MESSAGE ""
 
      #開窗程式串查沒有設定
 
         
   END DIALOG
END FUNCTION
################################################################################
# Descriptions...: 採用DISPLAY ARRAY的方式來顯現查詢過後的資料.
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
PRIVATE FUNCTION axrt400_06_display_array()
   DEFINE li_ac       LIKE type_t.num5
   DEFINE ldig_curr   ui.Dialog
   DEFINE l_msg       STRING           
   DEFINE l_chk       LIKE type_t.num5 
 
   #動態設定comboBox項目
   ### 此開窗無comboBox的欄位 ###
   
   DIALOG ATTRIBUTES(UNBUFFERED)
      DISPLAY ARRAY g_isaf_d TO s_detail1.*
         ATTRIBUTES(COUNT=g_data_cnt)
         BEFORE ROW
            LET li_ac = DIALOG.getCurrentRow("s_detail1")
      END DISPLAY
 
      BEFORE DIALOG
         LET ldig_curr = ui.Dialog.getCurrent()
         CALL axrt400_06_set_pagebutton(ldig_curr)
 
      ON ACTION accept
         IF li_ac > 0 THEN
            LET g_qryparam.return1 = g_isaf_d[li_ac].isaf010 CLIPPED 
          
         ELSE
            LET g_qryparam.return1 = gs_default1 

         END IF
         LET gs_action = "exit"
         EXIT DIALOG
         
      ON ACTION CANCEL
            LET g_qryparam.return1 = gs_default1 

 
         LET gs_action = "exit"
         LET INT_FLAG = TRUE
         EXIT DIALOG
         
      ON ACTION pg_first
         CALL axrt400_06_pagedata_fill("first")
         CALL axrt400_06_set_pagebutton(ldig_curr)
         NEXT FIELD CURRENT
         
      ON ACTION pg_prev
         CALL axrt400_06_pagedata_fill("prev")
         CALL axrt400_06_set_pagebutton(ldig_curr)
         NEXT FIELD CURRENT
         
      ON ACTION pg_next
         CALL axrt400_06_pagedata_fill("next")
         CALL axrt400_06_set_pagebutton(ldig_curr)
         NEXT FIELD CURRENT
         
      ON ACTION pg_last
         CALL axrt400_06_pagedata_fill("last")
         CALL axrt400_06_set_pagebutton(ldig_curr)
         NEXT FIELD CURRENT
         
      ON ACTION refresh       #重新整理
         CALL axrt400_06_pagedata_fill("first") 
         CALL axrt400_06_set_pagebutton(ldig_curr)
         EXIT DIALOG
         
      ON ACTION reconstruct   #重新查詢 
         LET gi_reconstruct = TRUE
         CALL g_isaf_d.clear()
         CALL axrt400_06_data_count("0")    #總筆數
         EXIT DIALOG
         
      ON ACTION exporttoexcel
         MESSAGE ""
 
      #開窗程式串查沒有設定
 
         
   END DIALOG
END FUNCTION
################################################################################
# Descriptions...: 準備查詢畫面的資料集.
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
PRIVATE FUNCTION axrt400_06_pagedata_fill(ps_page_action)
   DEFINE ps_page_action STRING
   DEFINE ls_sql         STRING
   DEFINE ls_where       STRING
   DEFINE li_i           LIKE type_t.num10
   DEFINE li_j           LIKE type_t.num10
   DEFINE l_datarange    STRING   #第m-n筆
   DEFINE l_str          STRING   #字串
   DEFINE l_str1         STRING
   DEFINE l_str2         STRING
 
   CASE ps_page_action
      WHEN "first"
         LET g_page_idx = 1
      WHEN "prev"
         LET g_page_idx = g_page_idx - 1
      WHEN "next"
         LET g_page_idx = g_page_idx + 1
      WHEN "last"
         LET g_page_idx = g_page_last
   END CASE
 
   IF g_page_idx > 0 THEN
      LET g_pagestart = (g_page_idx - 1) * gi_page_count + 1
   END IF
 
   CALL axrt400_06_sqlwhere() RETURNING ls_where
   #全部選取
   LET ls_sql = "SELECT 'N',isaf011,isaf010,isaf014,isaf025,isaf028,SUM (isag105 - isag116),SUM (isag115 - isag117),isaf008,isaf002,0",
                "  FROM isaf_t, isag_t",
                " WHERE isafent = isagent AND isafcomp = isagcomp AND isafdocno = isagdocno", 
                "   AND isafent = ",g_enterprise,  #160905-00002#5
                "   AND ", ls_where CLIPPED,
                " GROUP BY isaf011,isaf010,isaf014,isaf025,isaf028,isaf008,isaf002"
   DECLARE lcurs_detail1_all CURSOR FROM ls_sql
 
   #此頁
   #@如果不需要複選資料,則不要設定check的預設值(將'N'刪除)
   LET ls_sql = "SELECT isaf011,isaf010,isaf014,isaf025,isaf028,isag105,isag115,isaf008,isaf002,RANK",
                "  FROM( ",
                "      SELECT isaf011,isaf010,isaf014,isaf025,isaf028,isag105,isag115,isaf008,isaf002,",
                "             RANK () OVER (ORDER BY isaf011,isaf010,isaf014,isaf025,isaf028,isag105,isag115,isaf008,isaf002) ",
                "             AS RANK",
                "        FROM(",
                "             SELECT isaf011,isaf010,isaf014,SUM (isag105 - isag016) isag105,isaf028,",
                "                    isaf008,isaf002,isaf025,SUM (isag115 - isag017) isag115",
                "               FROM isaf_t, isag_t",
                "              WHERE isafent = isagent AND isafcomp = isagcomp AND isafdocno = isagdocno",
                "                AND isafent = ",g_enterprise,  #160905-00002#5
                "              GROUP BY isaf011,isaf010,isaf014,isaf025,isaf028,isaf008,isaf002))",
                " WHERE RANK >= ", g_pagestart," AND RANK < ", g_pagestart + gi_page_count,
                "   AND ", ls_where CLIPPED
 
   #DISPLAY "%%%%%%%%%%%%%%%%%%%%%%"
   #DISPLAY "ls_sql = ",ls_sql
 
   DECLARE lcurs_detail1 CURSOR FROM ls_sql
 
   CALL g_isaf_d.clear()
 
   LET li_i = 1
   FOREACH lcurs_detail1 INTO g_isaf_d[li_i].*
     #LET l_str1 = g_isaf_d[li_i].xrcald_1, g_isaf_d[li_i].xrcasite_2, g_isaf_d[li_i].ooefl003_3, g_isaf_d[li_i].xrca004_4, g_isaf_d[li_i].pmaal004_5, g_isaf_d[li_i].xrcadocno_6, g_isaf_d[li_i].xrcadocdt_7, g_isaf_d[li_i].xrca018_8, g_isaf_d[li_i].xrca100_9, g_isaf_d[li_i].xrca108_10, g_isaf_d[li_i].xrca118_11, g_isaf_d[li_i].xrca007_12, g_isaf_d[li_i].oocql004_13, g_isaf_d[li_i].xrca001_14, g_isaf_d[li_i].gzcbl004_15
     #FOR li_j = 1 TO g_isaf_d_sel.getLength()
     #   LET l_str2 = g_isaf_d_sel[li_j].xrcald_1, g_isaf_d_sel[li_j].xrcasite_2, g_isaf_d_sel[li_j].ooefl003_3, g_isaf_d_sel[li_j].xrca004_4, g_isaf_d_sel[li_j].pmaal004_5, g_isaf_d_sel[li_j].xrcadocno_6, g_isaf_d_sel[li_j].xrcadocdt_7, g_isaf_d_sel[li_j].xrca018_8, g_isaf_d_sel[li_j].xrca100_9, g_isaf_d_sel[li_j].xrca108_10, g_isaf_d_sel[li_j].xrca118_11, g_isaf_d_sel[li_j].xrca007_12, g_isaf_d_sel[li_j].oocql004_13, g_isaf_d_sel[li_j].xrca001_14, g_isaf_d_sel[li_j].gzcbl004_15
     #   IF l_str1 = l_str2 THEN
     #      LET g_isaf_d[li_i].check = g_isaf_d_sel[li_j].check
     #   END IF
     #END FOR
     #LET li_i = li_i + 1
   END FOREACH
   CALL g_isaf_d.deleteElement(li_i)
 
   IF gi_cons_where <> gi_cons_where_old OR cl_null(gi_cons_where) OR cl_null(gi_cons_where_old) THEN   #查詢條件改變
      LET gi_cons_where_old = gi_cons_where
      #CALL axrt400_06_data_count("db")  #查詢資料的總筆數,給下一段計算第m-n筆
   END IF
 
   CALL axrt400_06_data_count("db") #查詢資料的總筆數,給下一段計算第m-n筆
 
   #第m-n筆
   IF g_page_idx > 0 THEN
      LET li_i = g_data_cnt MOD gi_page_count
      #現在在最後一頁，而且不是滿頁的狀況
      IF g_page_idx = g_page_last AND li_i > 0 THEN
         LET l_str = g_pagestart - 1 + li_i
      ELSE
         LET l_str = g_pagestart - 1 + gi_page_count
      END IF
      LET l_datarange = g_pagestart
      LET l_datarange = l_datarange CLIPPED, " - ", l_str
   ELSE
      LET l_datarange = ""
   END IF
   DISPLAY l_datarange TO formonly.index
 
END FUNCTION
################################################################################
# Descriptions...: 查詢資料的總筆數
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
PRIVATE FUNCTION axrt400_06_data_count(p_data_cnt)
   DEFINE p_data_cnt  STRING     #總筆數計算方式 "db":資料庫中的資料/非"db"則以此值為總筆數
   DEFINE ls_sql      STRING
   DEFINE ls_where    STRING
   DEFINE ls_sql_1    STRING
 
 
   IF p_data_cnt = "db" THEN
      CALL axrt400_06_sqlwhere() RETURNING ls_where
      LET ls_sql = "SELECT COUNT(1) FROM (",
                   "SELECT 'Y',isaf011,isaf010,isaf014,isaf025,isaf028,SUM (isag105 - isag016),SUM (isag115 - isag017),isaf008,isaf002,0",
                "  FROM isaf_t, isag_t",
                " WHERE isafent = isagent AND isafcomp = isagcomp AND isafdocno = isagdocno",
                "   AND isafent = ",g_enterprise,  #160905-00002#5
                "   AND ", ls_where CLIPPED,
                " GROUP BY isaf011,isaf010,isaf014,isaf025,isaf028,isaf008,isaf002",
               ")"
      LET ls_sql_1 = "SELECT 'Y',isaf011,isaf010,isaf014,isaf025,isaf028,SUM (isag105 - isag016),SUM (isag115 - isag017),isaf008,isaf002,0",
                "  FROM isaf_t, isag_t",
                " WHERE isafent = isagent AND isafcomp = isagcomp AND isafdocno = isagdocno",
                "   AND isafent = ",g_enterprise,  #160905-00002#5
                "   AND ", ls_where CLIPPED,
                " GROUP BY isaf011,isaf010,isaf014,isaf025,isaf028,isaf008,isaf002"
      DISPLAY "########################################################################"
      DISPLAY "[sql for axrt400_06] = ",ls_sql_1
      DISPLAY "########################################################################"
      CALL axrt400_06_sql_verify(ls_sql_1)
      PREPARE qry_count FROM ls_sql
      EXECUTE qry_count INTO g_data_cnt
   ELSE
      LET g_data_cnt = p_data_cnt
   END IF
 
   IF g_data_cnt > 0 THEN
      IF g_data_cnt MOD gi_page_count = 0 THEN
         LET g_page_last = g_data_cnt / gi_page_count   #總筆數 / 每頁顯現資料筆數
      ELSE
         LET g_page_last = g_data_cnt / gi_page_count + 1
      END IF
   ELSE
      LET g_page_last = 0
   END IF
 
   #DISPLAY "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
   #DISPLAY "ls_sql = ",ls_sql
   #DISPLAY "ls_sql_1 = ",ls_sql_1
   #DISPLAY "g_data_cnt = ",g_data_cnt
   #DISPLAY "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
 
   DISPLAY g_data_cnt TO formonly.count    #顯示總筆數
END FUNCTION
################################################################################
# Descriptions...: 進行SQL驗證
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
PRIVATE FUNCTION axrt400_06_sql_verify(p_sql)
   DEFINE p_sql      STRING
   DEFINE l_sql      STRING
   DEFINE l_sql_msg  STRING
   
   TRY
      LET l_sql = "SELECT COUNT(1) FROM (",p_sql,")"
       
      #實際進行驗證
      EXECUTE IMMEDIATE l_sql
 
 
      MESSAGE 'Verify OK!' 
   CATCH
      DISPLAY ":SQLCA.SQLCODE=",SQLCA.SQLCODE,SQLERRMESSAGE
      LET l_sql_msg = ":SQLCA.SQLCODE=",SQLCA.SQLCODE,ASCII 10," \ sql = ",l_sql,ASCII 10," \ SQLERRMESSAGE=",SQLERRMESSAGE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00024"
      LET g_errparam.extend = l_sql_msg
      LET g_errparam.popup = TRUE
      CALL cl_err()

 
   END TRY 
END FUNCTION
################################################################################
# Descriptions...: 組SQL的where條件
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
PRIVATE FUNCTION axrt400_06_sqlwhere()
   DEFINE ls_where   STRING
 
   LET ls_where = gi_cons_where CLIPPED   #gi_cons_where 螢幕抓取的where 條件
 
   #在input段開窗的時候自動加入<inwc></inwc>之間的where條件 cch_20130605
   IF  g_qryparam.state = "i" THEN
   
   END IF
   
   #entprise - Start -
    
   #entprise -  End  -
   IF NOT cl_null(g_qryparam.where) THEN
      LET ls_where = ls_where, " AND ", g_qryparam.where CLIPPED   # g_qryparam.where查詢資料的條件
   END IF
   RETURN ls_where
END FUNCTION
################################################################################
# Descriptions...: 設定上下頁按鈕狀態
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
PRIVATE FUNCTION axrt400_06_set_pagebutton(pdig_curr)
   DEFINE pdig_curr ui.Dialog
 
   CALL pdig_curr.setActionActive("pg_first", 0)
   CALL pdig_curr.setActionActive("pg_prev", 0)
   CALL pdig_curr.setActionActive("pg_next", 0)
   CALL pdig_curr.setActionActive("pg_last", 0)
 
   IF g_page_idx > 1 THEN
      CALL pdig_curr.setActionActive("pg_first", 1)
      CALL pdig_curr.setActionActive("pg_prev", 1)
   END IF
 
   IF g_page_idx < g_page_last THEN
      CALL pdig_curr.setActionActive("pg_next", 1)
      CALL pdig_curr.setActionActive("pg_last", 1)
   END IF
 
END FUNCTION
################################################################################
# Descriptions...: 組合多選資料
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
PRIVATE FUNCTION axrt400_06_get_multiret()
   DEFINE li_i   LIKE type_t.num10
 
   IF g_qryparam.state = "c" THEN
      LET g_qryparam.return1 = ""
      FOR li_i = 1 TO g_isaf_d_sel.getLength()
         IF g_isaf_d_sel[li_i].check = "Y" THEN
            #@因為複選資料(display array)只能回傳一個欄位的組合字串.這裡不處理多欄位的回傳,以序號最小的回傳欄位為回傳值
            IF cl_null(g_qryparam.return1) THEN
               LET g_qryparam.return1 = g_isaf_d_sel[li_i].isaf010 CLIPPED

            ELSE
               LET g_qryparam.return1 = g_qryparam.return1 CLIPPED, "|", g_isaf_d_sel[li_i].isaf010 CLIPPED 

            END IF
         END IF
      END FOR
   END IF
 
   IF g_qryparam.state = "m" THEN
      CALL g_qryparam.str_array.clear()
 
      FOR li_i = 1 TO g_isaf_d_sel.getLength()
         #DISPLAY "g_isaf_d_sel[",li_i,"] = ",g_isaf_d_sel[li_i].*
         
         LET g_qryparam.str_array[li_i] = g_isaf_d_sel[li_i].isaf010
         #DISPLAY "g_qryparam.str_array[",li_i,"] = ",g_qryparam.str_array[li_i]
      END FOR
   END IF
 
END FUNCTION
################################################################################
# Descriptions...: 記錄已勾選的資料
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
PRIVATE FUNCTION axrt400_06_qry_check(p_mode,p_check,p_start,p_end)
   DEFINE p_mode   STRING                 #選取方式
   DEFINE p_check  LIKE type_t.chr1    #選取狀態 Y/N
   DEFINE p_start  LIKE type_t.num10   #此頁選取範圍第一筆
   DEFINE p_end    LIKE type_t.num10   #此頁選取範圍最後一筆
   DEFINE li_i     LIKE type_t.num10
   DEFINE li_j     LIKE type_t.num10
   DEFINE l_check  LIKE type_t.chr1
   DEFINE l_str1   STRING
   DEFINE l_str2   STRING
 
   CASE
      #全部選取
      WHEN p_mode = "selectall"
         IF g_data_cnt > g_sel_limit THEN   #選取資料筆數超出系統容許上限
            #qry-005:選取資料筆數超出系統容許上限%1
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "qry-005"
            LET g_errparam.extend = ""
            LET g_errparam.popup = TRUE
            CALL cl_err()

         ELSE
            FOR li_i = p_start TO p_end
               LET g_isaf_d[li_i].check = "Y"
            END FOR
 
            CALL g_isaf_d_sel.clear()
            LET li_i = 1
            FOREACH lcurs_detail1_all INTO g_isaf_d_sel[li_i].*
               LET li_i = li_i + 1
            END FOREACH
            CALL g_isaf_d_sel.deleteElement(li_i)
         END IF
      #全部取消選取
      WHEN p_mode = "selectnone"
         CALL g_isaf_d_sel.clear()
         FOR li_i = p_start TO p_end
            LET g_isaf_d[li_i].check = "N"
         END FOR
      #改變單筆資料的選取狀態/此頁全選/此頁取消選取
      WHEN p_end > 0 AND (cl_null(p_mode) OR p_mode = "selectpageall" OR p_mode = "selectpagenone")
         FOR li_i = p_start TO p_end
         	  #將所有欄位值串在一起,以利做開窗record唯一值判斷
            #要和已被選取的陣列(g_isaf_d_sel)做唯一值判斷比較
         	  LET l_str1 = g_isaf_d[li_i].isaf011,g_isaf_d[li_i].isaf010,g_isaf_d[li_i].isaf014,g_isaf_d[li_i].isaf025,g_isaf_d[li_i].isaf028,
                           g_isaf_d[li_i].isag105,g_isaf_d[li_i].isag115,g_isaf_d[li_i].isaf008,g_isaf_d[li_i].isaf002,g_isaf_d[li_i].lbl_n1
         	  
            IF p_check = "Y" THEN
               IF g_isaf_d_sel.getLength() >= g_sel_limit THEN   #選取資料筆數超出系統容許上限
                  LET g_isaf_d[li_i].check = "N"
                  INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "qry-005"
            LET g_errparam.extend = ""
            LET g_errparam.popup = TRUE
            CALL cl_err()

                  EXIT FOR
               ELSE
                  LET l_check = "Y"
                  LET g_isaf_d[li_i].check = "Y"             #此頁全選時,用程式批次改變值
                  FOR li_j = 1 TO g_isaf_d_sel.getLength()   #勾選清單中有此筆資料
                     LET l_str2 = g_isaf_d[li_j].isaf011,g_isaf_d[li_j].isaf010,g_isaf_d[li_j].isaf014,g_isaf_d[li_j].isaf025,g_isaf_d[li_j].isaf028,
                                  g_isaf_d[li_j].isag105,g_isaf_d[li_j].isag115,g_isaf_d[li_j].isaf008,g_isaf_d[li_j].isaf002,g_isaf_d[li_j].lbl_n1
                     IF l_str1 = l_str2 THEN
                        LET l_check = ""
                        EXIT FOR
                     END IF
                  END FOR
                  IF l_check = "Y" THEN  #加入勾選清單
                     LET li_j = g_isaf_d_sel.getLength() + 1
                     LET g_isaf_d_sel[li_j].* = g_isaf_d[li_i].*
                  END IF
               END IF
            ELSE
               LET g_isaf_d[li_i].check = "N"             #此頁取消選取時,用程式批次改變值
               FOR li_j = 1 TO g_isaf_d_sel.getLength()   #刪除勾選清單中的此筆資料
                  LET l_str2 = g_isaf_d[li_j].isaf011,g_isaf_d[li_j].isaf010,g_isaf_d[li_j].isaf014,g_isaf_d[li_j].isaf025,g_isaf_d[li_j].isaf028,
                               g_isaf_d[li_j].isag105,g_isaf_d[li_j].isag115,g_isaf_d[li_j].isaf008,g_isaf_d[li_j].isaf002,g_isaf_d[li_j].lbl_n1
                  IF l_str1 = l_str2 THEN
                      CALL g_isaf_d_sel.deleteElement(li_j)
                     EXIT FOR
                  END IF
               END FOR
            END IF
         END FOR
   END CASE

END FUNCTION
################################################################################
# Descriptions...: 設定comboBox
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
PRIVATE FUNCTION axrt400_06_setting_comboBox(p_col_str)
   DEFINE p_col_str           STRING,
          l_i                 LIKE type_t.num5,
          l_dzep011           LIKE dzep_t.dzep010, #系統分類碼
          l_dzeb001           LIKE dzeb_t.dzeb001, #表格代號
          l_gzcc003           LIKE gzcc_t.gzcc003, #系統分類碼
          l_gzcc004_str       STRING,              #系統分類值的字串 
          l_token             base.StringTokenizer,
          l_token_str         LIKE dzeb_t.dzeb002,
          l_str               STRING,
          l_parameter1        STRING,
          l_parameter2        STRING,
          l_parameter3        STRING,
          l_col_id            LIKE dzeb_t.dzeb002
          
   #優先處理 token
   LET l_token = base.StringTokenizer.create(p_col_str,"|")
 
   WHILE l_token.hasMoreTokens()
 
      LET l_token_str =l_token.nextToken()
 
      LET l_str = l_token_str
      LET l_str = l_str.subString(1,l_str.getLength()-2)
      LET l_col_id = l_str.trim()
         
      #找出欄位的所屬表格代號
      SELECT dzeb001 INTO l_dzeb001 FROM dzeb_t WHERE dzeb002 = l_col_id
      
      IF l_col_id MATCHES "*stus" THEN
         #找出該表格的狀態碼欄位和系統分類碼
         SELECT DISTINCT gzcc003 INTO l_gzcc003 FROM gzcc_t WHERE gzcc001 = l_dzeb001
         #組合出表格有效的系統分類值的字串
         LET l_gzcc004_str = axrt400_06_setting_system_type_value_for_table(l_dzeb001)
 
         #DISPLAY "###########",l_token_str
         LET l_parameter1 = "formonly.",l_token_str
         LET l_parameter2 = l_gzcc003
         LET l_parameter3 = l_gzcc004_str
         
         #DISPLAY l_parameter1
         #DISPLAY l_parameter2
         #DISPLAY l_parameter3
         
         #組合 動態設定有選擇SCC資料的ComboBox選項 的程式碼,列出部分的系統分類值
         CALL cl_set_combo_scc_part(l_parameter1,l_parameter2,l_parameter3)
      ELSE
         #找出該欄位的系統分類碼
         SELECT dzep011 INTO l_dzep011 FROM dzep_t WHERE dzep002 = l_col_id
 
         #DISPLAY "###########",l_token_str
         LET l_parameter1 = "formonly.",l_token_str
         LET l_parameter2 = l_dzep011
         
         #DISPLAY l_parameter1
         #DISPLAY l_parameter2
         
         #組合 動態設定有選擇SCC資料的ComboBox選項 的程式碼,列出全部的系統分類值
         CALL cl_set_combo_scc(l_parameter1,l_parameter2)
      END IF
 
   END WHILE
END FUNCTION
################################################################################
# Descriptions...: 組合出表格有效的系統分類值的字串
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
PRIVATE FUNCTION axrt400_06_setting_system_type_value_for_table(p_table)
   DEFINE p_table     LIKE  gzcc_t.gzcc001,
          l_gzcc_d    DYNAMIC ARRAY OF  RECORD
            gzcc004     LIKE dzeb_t.dzeb001
                      END  RECORD,
          l_cnt       LIKE type_t.num5,
          ls_sql      STRING,
          r_str       STRING
 
   LET ls_sql = "SELECT gzcc004 FROM gzcc_t ",
               "WHERE gzcc001='",p_table,"' AND gzccstus='Y' ",
               "ORDER BY gzcc006 "
 
   LET r_str = ""
 
   PREPARE gzcc_prep FROM ls_sql
   DECLARE gzcc_curs CURSOR FOR gzcc_prep
   LET l_cnt = 1
   FOREACH gzcc_curs INTO l_gzcc_d[l_cnt].gzcc004
      LET r_str = r_str,l_gzcc_d[l_cnt].gzcc004,","
 
      LET l_cnt = l_cnt + 1
   END FOREACH
 
   CALL l_gzcc_d.deleteElement(l_cnt)
 
   #去掉最後面的逗號
   LET r_str = r_str.subString(1,r_str.getLength()-1)
   
   RETURN r_str
END FUNCTION

 
{</section>}
 
