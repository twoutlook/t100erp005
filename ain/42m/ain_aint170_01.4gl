#該程式未解開Section, 採用最新樣板產出!
{<section id="aint170_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2016-06-21 09:55:19), PR版次:0007(2016-12-09 18:07:36)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000184
#+ Filename...: aint170_01
#+ Description: 維護變更數量維護作業
#+ Creator....: 01996(2014-04-03 16:43:15)
#+ Modifier...: 04441 -SD/PR- 08734
 
{</section>}
 
{<section id="aint170_01.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160512-00004#1  160620 By Whitney  inai012製造日期改抓inae010
#161108-00012#2  2016/11/09 By 08734  g_browser_cnt 由num5改為num10
#161124-00048#5  2016/12/09 By 08734  星号整批调整
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
 
{<section id="aint170_01.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
 TYPE type_g_inag_d        RECORD
       sel  LIKE type_t.chr1,
       change_num  LIKE inag_t.inag008,
       inag008  LIKE inag_t.inag008,
       inag004  LIKE inag_t.inag004,
       inag004_desc LIKE type_t.chr500,
       inag005  LIKE inag_t.inag005,
       inag005_desc LIKE type_t.chr500,
       inag002  LIKE inag_t.inag002,
       inag003  LIKE inag_t.inag003,
       inag007  LIKE inag_t.inag007,
       inag006  LIKE inag_t.inag006
       END RECORD
       
  TYPE type_g_inai_d        RECORD
       sel1         LIKE type_t.chr1,
       change_num1  LIKE inai_t.inai010,
       inai010      LIKE inai_t.inai010,
       inai007      LIKE inai_t.inai007,
       inai008      LIKE inai_t.inai008,
      #inai012      LIKE inai_t.inai012  #160512-00004#1 by whitney mark
       inae010      LIKE inae_t.inae010  #160512-00004#1 by whitney add
       END RECORD
DEFINE g_inag_d          DYNAMIC ARRAY OF type_g_inag_d
DEFINE g_inai_d          DYNAMIC ARRAY OF type_g_inai_d
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING


DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING

DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_jump                LIKE type_t.num10
DEFINE g_no_ask              LIKE type_t.num5
DEFINE g_rec_b               LIKE type_t.num10  #161108-00012#2 num5==》num10
DEFINE l_ac                  LIKE type_t.num10  #161108-00012#2 num5==》num10
DEFINE g_rec_b1               LIKE type_t.num10  #161108-00012#2 num5==》num10
DEFINE l_ac1                  LIKE type_t.num10  #161108-00012#2 num5==》num10
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog

DEFINE g_pagestart           LIKE type_t.num10  #161108-00012#2 num5==》num10
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_state               STRING

DEFINE g_detail_cnt          LIKE type_t.num10              #單身總筆數  #161108-00012#2 num5==》num10
DEFINE g_detail_idx          LIKE type_t.num10              #單身目前所在筆數  #161108-00012#2 num5==》num10
DEFINE g_detail_idx2         LIKE type_t.num10              #單身2目前所在筆數  #161108-00012#2 num5==》num10
#DEFINE g_browser_cnt         LIKE type_t.num5              #Browser總筆數   #161108-00012#2  2016/11/09 By 08734 mark
DEFINE g_browser_cnt         LIKE type_t.num10              #Browser總筆數   #161108-00012#2  2016/11/09 By 08734 add
DEFINE g_browser_idx         LIKE type_t.num10              #Browser目前所在筆數  #161108-00012#2 num5==》num10
DEFINE g_temp_idx            LIKE type_t.num10              #Browser目前所在筆數(暫存用)  #161108-00012#2 num5==》num10

DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序欄位

DEFINE g_current_row         LIKE type_t.num10              #Browser所在筆數  #161108-00012#2 num5==》num10
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10              #目前所在頁數  #161108-00012#2 num5==》num10
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page

DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
DEFINE g_error_show          LIKE type_t.num5

DEFINE g_wc_frozen           STRING                        #凍結欄位使用
DEFINE g_chk                 BOOLEAN    
DEFINE g_inbgdocno           LIKE inbg_t.inbgdocno
DEFINE g_inbgsite            LIKE inbg_t.inbgsite
DEFINE g_inbgseq             LIKE inbg_t.inbgseq
DEFINE g_inbg002             LIKE inbg_t.inbg002
DEFINE g_cnt1                LIKE type_t.num10  #161108-00012#2 num5==》num10
 TYPE type_g_inbg_d        RECORD
       inbgseq LIKE inbg_t.inbgseq, 
       inbg001 LIKE inbg_t.inbg001, 
       inbg002 LIKE inbg_t.inbg002, 
       inbg002_desc LIKE type_t.chr500, 
       inbg002_desc_1 LIKE type_t.chr500, 
       inbg003 LIKE inbg_t.inbg003, 
       inbg003_desc LIKE type_t.chr500, 
       inbg004 LIKE inbg_t.inbg004, 
       inbg004_desc LIKE type_t.chr500, 
       inbg005 LIKE inbg_t.inbg005, 
       inbg005_desc LIKE type_t.chr500,
       inbg006 LIKE inbg_t.inbg006, 
       inbg008 LIKE inbg_t.inbg008, 
       inbg007 LIKE inbg_t.inbg007, 
       inbg009 LIKE inbg_t.inbg009, 
       inbg010 LIKE inbg_t.inbg010, 
       inbg011 LIKE inbg_t.inbg011, 
       inbg031 LIKE inbg_t.inbg031, 
       inbg031_desc LIKE type_t.chr500, 
       inbg012 LIKE inbg_t.inbg012, 
       inbg032 LIKE inbg_t.inbg032, 
       inbgsite LIKE inbg_t.inbgsite
       END RECORD
DEFINE g_inbg    type_g_inbg_d 
#end add-point
 
{</section>}
 
{<section id="aint170_01.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="aint170_01.other_dialog" >}

 
{</section>}
 
{<section id="aint170_01.other_function" readonly="Y" >}

PUBLIC FUNCTION aint170_01(p_inbgdocno,p_inbg)
DEFINE p_inbg    type_g_inbg_d 
DEFINE p_inbgdocno LIKE inbg_t.inbgdocno
   WHENEVER ERROR CALL cl_err_msg_log

   #畫面開啟 (identifier)
   OPEN WINDOW w_aint170_01 WITH FORM cl_ap_formpath("ain","aint170_01")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   CREATE TEMP TABLE inai_tmp(sel     varchar(1),
                              change_num  decimal(20,6),
                              inai010     decimal(20,6),
                              inai007     varchar(30),
                              inai008     varchar(30),
                             #inai012     date,  #160512-00004#1 by whitney mark
                              inae010     date,  
                              seq         decimal(5,0))
   LET g_inbgdocno = p_inbgdocno
   LET g_inbg.* = p_inbg.*
   CALL aint170_01_input()
   
   #畫面關閉
   DROP TABLE inai_tmp
   CLOSE WINDOW w_aint170_01
END FUNCTION

PRIVATE FUNCTION aint170_01_input()
   CALL cl_set_head_visible("","YES")
   CALL g_inag_d.clear()
   CALL aint170_01_b_fill()
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT ARRAY g_inag_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)   
          BEFORE INPUT
            LET g_rec_b = g_inag_d.getLength()
          AFTER FIELD change_num 
             IF NOT cl_ap_chk_Range(g_inag_d[l_ac].change_num,"0","0","","","azz-00079",1) THEN
                NEXT FIELD CURRENT
             END IF
             IF g_inag_d[l_ac].change_num > g_inag_d[l_ac].inag008 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'ain-00174'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                NEXT FIELD CURRENT 
             END IF

         BEFORE ROW
             LET l_ac = ARR_CURR()
             CALL g_inai_d.clear()
             CALL aint170_01_b_fill1()
             
      END INPUT
      
      INPUT ARRAY g_inai_d FROM s_detail2.*
          ATTRIBUTE(COUNT = g_rec_b1,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)  
         BEFORE INPUT            
            LET g_rec_b1 = g_inai_d.getLength()
         AFTER FIELD change_num1
            IF NOT cl_ap_chk_Range(g_inai_d[l_ac1].change_num1,"0","0","","","azz-00079",1) THEN
                NEXT FIELD CURRENT
             END IF
            IF g_inai_d[l_ac1].change_num1 > g_inai_d[l_ac1].inai010 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'ain-00174'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                NEXT FIELD CURRENT 
            END IF

         BEFORE ROW
            LET l_ac1 = ARR_CURR()    
         ON ROW CHANGE 
            UPDATE inai_tmp SET sel = g_inai_d[l_ac1].sel1,change_num = g_inai_d[l_ac1].change_num1
                          WHERE seq = l_ac
                                                     
      END INPUT
      
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)

      ON ACTION controlr
         CALL cl_show_req_fields()

      ON ACTION controls
         CALL cl_set_head_visible("","AUTO")

      ON ACTION accept
         CALL aint170_01_accept()
         ACCEPT DIALOG

      ON ACTION cancel      #在dialog button (放棄)
         
         EXIT DIALOG

      ON ACTION close       #在dialog 右上角 (X)
         
         EXIT DIALOG

      ON ACTION exit        #toolbar 離開
         
         EXIT DIALOG

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG

END FUNCTION

PRIVATE FUNCTION aint170_01_b_fill()
DEFINE l_n    LIKE type_t.num10  #161108-00012#2 num5==》num10
DEFINE l_sql  STRING
#DEFINE l_inbg RECORD LIKE inbg_t.*  #161124-00048#5  16/12/09 By 08734 mark
#161124-00048#5  16/12/09 By 08734 add(S)
DEFINE l_inbg RECORD  #庫存異常變更申請明細檔
       inbgent LIKE inbg_t.inbgent, #企业编号
       inbgsite LIKE inbg_t.inbgsite, #营运据点
       inbgdocno LIKE inbg_t.inbgdocno, #单据编号
       inbgseq LIKE inbg_t.inbgseq, #项次
       inbg001 LIKE inbg_t.inbg001, #变更类型
       inbg002 LIKE inbg_t.inbg002, #料件编号
       inbg003 LIKE inbg_t.inbg003, #库位
       inbg004 LIKE inbg_t.inbg004, #储位
       inbg005 LIKE inbg_t.inbg005, #产品特征
       inbg006 LIKE inbg_t.inbg006, #库存管理特征
       inbg007 LIKE inbg_t.inbg007, #批号
       inbg008 LIKE inbg_t.inbg008, #库存单位
       inbg009 LIKE inbg_t.inbg009, #制造批号
       inbg010 LIKE inbg_t.inbg010, #制造序号
       inbg011 LIKE inbg_t.inbg011, #变更内容
       inbg012 LIKE inbg_t.inbg012, #变更部分数量
       inbg031 LIKE inbg_t.inbg031, #理由码
       inbg032 LIKE inbg_t.inbg032 #备注
END RECORD
#161124-00048#5  16/12/09 By 08734 add(E)
   LET l_n = 0 
   SELECT COUNT(*) INTO l_n FROM inbh_t
     WHERE inbhent = g_enterprise AND inbhdocno = g_inbgdocno
       AND inbhsite = g_inbg.inbgsite AND inbhseq = g_inbg.inbgseq
   IF l_n > 0 THEN
      LET l_sql = "SELECT 'Y',inbh017,inag008,inbh003,inaa002,inbh004,inab003,inbh005,inbh006,inbh008,inbh007",
                  " FROM inbh_t LEFT JOIN inag_t ON inagent = inbhent AND inagsite = inbhsite AND inag001 = inbh002 ",
                  "                             AND inag002 = inbh005 AND inag003  = inbh006  AND inag004 = inbh003 ",
                  "                             AND inag005 = inbh004 AND inag006  = inbh007  AND inag007 = inbh008 ",
                  "             LEFT OUTER JOIN inaa_t ON inaaent = inbhent AND inaasite = inbhsite AND inaa001 = inbh003 ",
                  "             LEFT OUTER JOIN inab_t ON inabent = inbhent AND inabsite = inbhsite AND inab001 = inbh003 AND inab002 = inbh004",
                  " WHERE inbhent = ",g_enterprise," AND inbhdocno = '",g_inbgdocno,"' AND inbhseq = ",g_inbg.inbgseq," AND inbh002 = '",g_inbg.inbg002,"'"
      IF g_inbg.inbg005 IS NOT NULL THEN
         LET l_sql = l_sql," AND inbh005 = '",g_inbg.inbg005,"'"
      END IF
      IF g_inbg.inbg006 IS NOT NULL THEN
         LET l_sql = l_sql," AND inbh006 = '",g_inbg.inbg006,"'"
      END IF
      IF g_inbg.inbg003 IS NOT NULL THEN
         LET l_sql = l_sql," AND inbh003 = '",g_inbg.inbg003,"'"
      END IF    
      IF g_inbg.inbg004 IS NOT NULL THEN
         LET l_sql = l_sql," AND inbh004 = '",g_inbg.inbg004,"'"
      END IF
      IF g_inbg.inbg007 IS NOT NULL THEN
         LET l_sql = l_sql," AND inbh007 = '",g_inbg.inbg007,"'"
      END IF
      IF g_inbg.inbg008 IS NOT NULL THEN
         LET l_sql = l_sql," AND inbh008 = '",g_inbg.inbg008,"'"
      END IF
      PREPARE sel_inbh_prep FROM l_sql
      DECLARE sel_inbh_curs CURSOR FOR sel_inbh_prep 
      LET l_ac = 1
      FOREACH sel_inbh_curs  INTO g_inag_d[l_ac].*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
         CALL aint170_01_inai_tmp_ins()
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec AND g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
      END FOREACH
   ELSE
      
      LET l_sql = "SELECT 'Y',inag008,inag008,inag004,inaa002,inag005,inab003,inag002,inag003,inag007,inag006",
                  " FROM inag_t LEFT OUTER JOIN inaa_t ON inaaent = inagent AND inaasite = inagsite AND inaa001 = inag004 ",
                  "             LEFT OUTER JOIN inab_t ON inabent = inagent AND inabsite = inagsite AND inab001 = inag004 AND inab002 = inag005",
                  " WHERE inagent = ",g_enterprise," AND inagsite = '",g_inbg.inbgsite,"' AND inag008 <> 0 AND inag001 = '",g_inbg.inbg002,"'"
      IF g_inbg.inbg005 IS NOT NULL THEN
         LET l_sql = l_sql," AND inag002 = '",g_inbg.inbg005,"'"
      END IF
      IF g_inbg.inbg006 IS NOT NULL THEN
         LET l_sql = l_sql," AND inag003 = '",g_inbg.inbg006,"'"
      END IF
      IF g_inbg.inbg003 IS NOT NULL THEN
         LET l_sql = l_sql," AND inag004 = '",g_inbg.inbg003,"'"
      END IF    
      IF g_inbg.inbg004 IS NOT NULL THEN
         LET l_sql = l_sql," AND inag005 = '",g_inbg.inbg004,"'"
      END IF
      IF g_inbg.inbg007 IS NOT NULL THEN
         LET l_sql = l_sql," AND inag006 = '",g_inbg.inbg007,"'"
      END IF
      IF g_inbg.inbg008 IS NOT NULL THEN
         LET l_sql = l_sql," AND inag007 = '",g_inbg.inbg008,"'"
      END IF  

      PREPARE sel_inag_prep FROM l_sql
      DECLARE sel_inag_curs CURSOR FOR sel_inag_prep 
      LET l_ac = 1
      FOREACH sel_inag_curs  INTO g_inag_d[l_ac].*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
         CALL aint170_01_inai_tmp_ins()
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec AND g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
      END FOREACH
   END IF
   CALL g_inag_d.deleteElement(g_inag_d.getLength())

   DISPLAY ARRAY g_inag_d TO s_detail1.*
      BEFORE DISPLAY
         EXIT DISPLAY
   END DISPLAY 
   LET l_ac = g_cnt
   LET g_cnt = 0

   FREE sel_inag_curs
   FREE sel_inbh_curs
END FUNCTION

PRIVATE FUNCTION aint170_01_b_fill1()
DEFINE l_n    LIKE type_t.num10  #161108-00012#2 num5==》num10
DEFINE l_sql  STRING
#DEFINE l_inbg RECORD LIKE inbg_t.*  #161124-00048#5  16/12/09 By 08734 mark
#161124-00048#5  16/12/09 By 08734 add(S)
DEFINE l_inbg RECORD  #庫存異常變更申請明細檔
       inbgent LIKE inbg_t.inbgent, #企业编号
       inbgsite LIKE inbg_t.inbgsite, #营运据点
       inbgdocno LIKE inbg_t.inbgdocno, #单据编号
       inbgseq LIKE inbg_t.inbgseq, #项次
       inbg001 LIKE inbg_t.inbg001, #变更类型
       inbg002 LIKE inbg_t.inbg002, #料件编号
       inbg003 LIKE inbg_t.inbg003, #库位
       inbg004 LIKE inbg_t.inbg004, #储位
       inbg005 LIKE inbg_t.inbg005, #产品特征
       inbg006 LIKE inbg_t.inbg006, #库存管理特征
       inbg007 LIKE inbg_t.inbg007, #批号
       inbg008 LIKE inbg_t.inbg008, #库存单位
       inbg009 LIKE inbg_t.inbg009, #制造批号
       inbg010 LIKE inbg_t.inbg010, #制造序号
       inbg011 LIKE inbg_t.inbg011, #变更内容
       inbg012 LIKE inbg_t.inbg012, #变更部分数量
       inbg031 LIKE inbg_t.inbg031, #理由码
       inbg032 LIKE inbg_t.inbg032 #备注
END RECORD
#161124-00048#5  16/12/09 By 08734 add(E)
   
      LET l_sql = "SELECT sel,change_num,inai010,inai007,inai008,inae010 FROM inai_tmp WHERE seq = ",l_ac  #160512-00004#1 by whitney modify inai012->inae010
      
      PREPARE sel_inai_tmp_prep FROM l_sql
      DECLARE sel_inai_tmp_curs CURSOR FOR sel_inai_tmp_prep 
      LET l_ac1 = 1
      FOREACH sel_inai_tmp_curs  INTO g_inai_d[l_ac1].*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
         
         LET l_ac1 = l_ac1 + 1
         IF l_ac > g_max_rec AND g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
      END FOREACH                  

   CALL g_inai_d.deleteElement(g_inai_d.getLength())

   DISPLAY ARRAY g_inai_d TO s_detail2.*
      BEFORE DISPLAY
         EXIT DISPLAY
   END DISPLAY 
   LET l_ac1 = g_cnt1
   LET g_cnt1 = 0

   FREE sel_inai_tmp_curs
END FUNCTION

PRIVATE FUNCTION aint170_01_accept()
   IF NOT INT_FLAG THEN
      CALL s_transaction_begin()
      DELETE FROM inbh_t WHERE inbhent = g_enterprise AND inbhdocno = g_inbgdocno AND inbhseq = g_inbg.inbgseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = sqlca.sqlcode
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','1')
         RETURN
      END IF
      DELETE FROM inao_t WHERE inaoent = g_enterprise AND inaodocno = g_inbgdocno AND inaoseq = g_inbg.inbgseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = sqlca.sqlcode
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','1')
         RETURN
      END IF
      
      IF NOT aint170_01_inbh_ins() THEN
         CALL s_transaction_end('N','1')
         RETURN
      END IF
      
      IF NOT aint170_01_inao_ins() THEN
         CALL s_transaction_end('N','1')
         RETURN 
      END IF
      CALL s_transaction_end('Y','0')
   END IF
END FUNCTION

PRIVATE FUNCTION aint170_01_inbh_ins()
DEFINE l_i   LIKE type_t.num5
#DEFINE l_inbh RECORD LIKE inbh_t.*  #161124-00048#5  16/12/09 By 08734 mark
#161124-00048#5  16/12/09 By 08734 add(S)
DEFINE l_inbh RECORD  #庫存異常變更明細檔
       inbhent LIKE inbh_t.inbhent, #企业编号
       inbhsite LIKE inbh_t.inbhsite, #营运据点
       inbhdocno LIKE inbh_t.inbhdocno, #单据编号
       inbhseq LIKE inbh_t.inbhseq, #项次
       inbhseq1 LIKE inbh_t.inbhseq1, #项序
       inbh001 LIKE inbh_t.inbh001, #变更类型
       inbh002 LIKE inbh_t.inbh002, #料件编号
       inbh003 LIKE inbh_t.inbh003, #库位
       inbh004 LIKE inbh_t.inbh004, #储位
       inbh005 LIKE inbh_t.inbh005, #变更前-产品特征
       inbh006 LIKE inbh_t.inbh006, #变更前-库存管理特征
       inbh007 LIKE inbh_t.inbh007, #变更前-批号
       inbh008 LIKE inbh_t.inbh008, #变更前-库存单位
       inbh011 LIKE inbh_t.inbh011, #变更后-产品特征
       inbh012 LIKE inbh_t.inbh012, #变更后-库存管理特征
       inbh013 LIKE inbh_t.inbh013, #变更后-批号
       inbh014 LIKE inbh_t.inbh014, #变更后-库存单位
       inbh017 LIKE inbh_t.inbh017 #变更数量
END RECORD
#161124-00048#5  16/12/09 By 08734 add(E)
DEFINE l_cnt LIKE type_t.num5

  IF g_inbg.inbg001 NOT MATCHES '[56]' THEN 
     LET l_cnt = 1
     FOR l_i = 1 TO g_inag_d.getLength() 
        IF g_inag_d[l_i].sel = 'Y' THEN
           LET l_inbh.inbhent = g_enterprise
           LET l_inbh.inbhsite = g_site
           LET l_inbh.inbhdocno = g_inbgdocno
           LET l_inbh.inbhseq = g_inbg.inbgseq
           LET l_inbh.inbhseq1 = l_cnt
           LET l_inbh.inbh001 = g_inbg.inbg001
           LET l_inbh.inbh002 = g_inbg.inbg002
           LET l_inbh.inbh003 = g_inag_d[l_i].inag004
           LET l_inbh.inbh004 = g_inag_d[l_i].inag005
           LET l_inbh.inbh005 = g_inag_d[l_i].inag002
           LET l_inbh.inbh006 = g_inag_d[l_i].inag003
           LET l_inbh.inbh007 = g_inag_d[l_i].inag006
           LET l_inbh.inbh008 = g_inag_d[l_i].inag007 
           CASE 
               WHEN g_inbg.inbg001 = '1'
                  LET l_inbh.inbh011 = g_inbg.inbg011
                  LET l_inbh.inbh012 = g_inag_d[l_i].inag003
                  LET l_inbh.inbh013 = g_inag_d[l_i].inag006
                  LET l_inbh.inbh014 = g_inag_d[l_i].inag007
               WHEN g_inbg.inbg001 = '2'
                  LET l_inbh.inbh011 = g_inag_d[l_i].inag002
                  LET l_inbh.inbh012 = g_inbg.inbg011
                  LET l_inbh.inbh013 = g_inag_d[l_i].inag006
                  LET l_inbh.inbh014 = g_inag_d[l_i].inag007
               WHEN g_inbg.inbg001 = '3'
                  LET l_inbh.inbh011 = g_inag_d[l_i].inag002
                  LET l_inbh.inbh012 = g_inag_d[l_i].inag003
                  LET l_inbh.inbh013 = g_inag_d[l_i].inag006
                  LET l_inbh.inbh014 = g_inbg.inbg011
               WHEN g_inbg.inbg001 = '4'
                  LET l_inbh.inbh011 = g_inag_d[l_i].inag002
                  LET l_inbh.inbh012 = g_inag_d[l_i].inag003
                  LET l_inbh.inbh013 = g_inbg.inbg011
                  LET l_inbh.inbh014 = g_inag_d[l_i].inag007
#               WHEN g_inbg.inbg001 MATCHES '[56]'
#                  LET l_inbh.inbh011 = g_inag_d[l_i].inag002
#                  LET l_inbh.inbh012 = g_inag_d[l_i].inag003
#                  LET l_inbh.inbh013 = g_inag_d[l_i].inag006
#                  LET l_inbh.inbh014 = g_inag_d[l_i].inag007
            END CASE
            LET l_inbh.inbh017 = g_inag_d[l_i].change_num
            #INSERT INTO inbh_t VALUES (l_inbh.*)  #161124-00048#5  16/12/09 By 08734 mark
            INSERT INTO inbh_t(inbhent,inbhsite,inbhdocno,inbhseq,inbhseq1,inbh001,inbh002,inbh003,inbh004,inbh005,inbh006,inbh007,inbh008,inbh011,inbh012,inbh013,inbh014,inbh017)  #161124-00048#5  16/12/09 By 08734 add
               VALUES (l_inbh.inbhent,l_inbh.inbhsite,l_inbh.inbhdocno,l_inbh.inbhseq,l_inbh.inbhseq1,l_inbh.inbh001,l_inbh.inbh002,l_inbh.inbh003,l_inbh.inbh004,l_inbh.inbh005,l_inbh.inbh006,l_inbh.inbh007,l_inbh.inbh008,l_inbh.inbh011,l_inbh.inbh012,l_inbh.inbh013,l_inbh.inbh014,l_inbh.inbh017)
            IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               RETURN FALSE
            END IF
            LET l_cnt = l_cnt + 1
        END IF
     
     END FOR
  END IF
  RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aint170_01_inao_ins()
DEFINE l_i   LIKE type_t.num5

#DEFINE l_inao RECORD LIKE inao_t.*  #161124-00048#5  16/12/09 By 08734 mark
#161124-00048#5  16/12/09 By 08734 add(S)
DEFINE l_inao RECORD  #製造批序號庫存異動明細檔
       inaoent LIKE inao_t.inaoent, #企业编号
       inaosite LIKE inao_t.inaosite, #营运据点
       inaodocno LIKE inao_t.inaodocno, #单号
       inaoseq LIKE inao_t.inaoseq, #项次
       inaoseq1 LIKE inao_t.inaoseq1, #项序
       inaoseq2 LIKE inao_t.inaoseq2, #序号
       inao000 LIKE inao_t.inao000, #数据类型
       inao001 LIKE inao_t.inao001, #料件编号
       inao002 LIKE inao_t.inao002, #产品特征
       inao003 LIKE inao_t.inao003, #库存管理特征
       inao004 LIKE inao_t.inao004, #包装容器编号
       inao005 LIKE inao_t.inao005, #库位
       inao006 LIKE inao_t.inao006, #储位
       inao007 LIKE inao_t.inao007, #批号
       inao008 LIKE inao_t.inao008, #制造批号
       inao009 LIKE inao_t.inao009, #制造序号
       inao010 LIKE inao_t.inao010, #制造日期
       inao011 LIKE inao_t.inao011, #有效日期
       inao012 LIKE inao_t.inao012, #数量
       inao013 LIKE inao_t.inao013, #出入库码
       inao014 LIKE inao_t.inao014, #库存单位
       inao020 LIKE inao_t.inao020, #检验合格量
       inao021 LIKE inao_t.inao021, #已入库/出货/签收量
       inao022 LIKE inao_t.inao022, #已验退/签退量
       inao023 LIKE inao_t.inao023, #已仓退/销退量
       inao024 LIKE inao_t.inao024, #已转QC量
       inao025 LIKE inao_t.inao025 #已退品量
END RECORD
#161124-00048#5  16/12/09 By 08734 add(E)
DEFINE l_cnt LIKE type_t.num5

  LET l_cnt = 1  
  FOR l_i = 1 TO g_inai_d.getLength()
     IF g_inai_d[l_i].sel1 = 'Y' THEN
        LET l_inao.inaoent = g_enterprise
        LET l_inao.inaosite = g_site
        LET l_inao.inaodocno = g_inbgdocno
        LET l_inao.inaoseq = g_inbg.inbgseq
        LET l_inao.inaoseq1 = l_cnt
        LET l_inao.inaoseq2 = 1
        LET l_inao.inao000 = '2'
        LET l_inao.inao001 = g_inbg.inbg002
        LET l_inao.inao002 = g_inag_d[l_ac].inag002
        LET l_inao.inao003 = g_inag_d[l_ac].inag003
        LET l_inao.inao005 = g_inag_d[l_ac].inag004
        LET l_inao.inao006 = g_inag_d[l_ac].inag005
        LET l_inao.inao007 = g_inag_d[l_ac].inag006
        LET l_inao.inao008 = g_inai_d[l_i].inai007
        LET l_inao.inao009 = g_inai_d[l_i].inai008
        LET l_inao.inao012 = g_inai_d[l_i].change_num1
        LET l_inao.inao013 = -1
        LET l_inao.inao014 = g_inag_d[l_ac].inag007
        LET l_inao.inao010 = g_inai_d[l_i].inae010  #160512-00004#1 by whitney modify inai012->inae010
        #新增变更前
        #INSERT INTO inao_t VALUES(l_inao.*)  #161124-00048#5  16/12/09 By 08734 mark
        INSERT INTO inao_t(inaoent,inaosite,inaodocno,inaoseq,inaoseq1,inaoseq2,inao000,inao001,inao002,inao003,inao004,inao005,inao006,inao007,inao008,inao009,inao010,inao011,inao012,inao013,inao014,inao020,inao021,inao022,inao023,inao024,inao025)  #161124-00048#5  16/12/09 By 08734 add
           VALUES(l_inao.inaoent,l_inao.inaosite,l_inao.inaodocno,l_inao.inaoseq,l_inao.inaoseq1,l_inao.inaoseq2,l_inao.inao000,l_inao.inao001,l_inao.inao002,l_inao.inao003,l_inao.inao004,l_inao.inao005,l_inao.inao006,l_inao.inao007,l_inao.inao008,l_inao.inao009,l_inao.inao010,l_inao.inao011,l_inao.inao012,l_inao.inao013,l_inao.inao014,l_inao.inao020,l_inao.inao021,l_inao.inao022,l_inao.inao023,l_inao.inao024,l_inao.inao025)
        IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.SQLCODE
           LET g_errparam.extend = ''
           LET g_errparam.popup = TRUE
           CALL cl_err()

           RETURN FALSE
        END IF
        
        #新增变更后
        LET l_inao.inaoseq2 = 2
        LET l_inao.inao013 = 1
        CASE WHEN g_inbg.inbg001 = '1'
                LET l_inao.inao002 = g_inbg.inbg011
                LET l_inao.inao003 = g_inag_d[l_ac].inag003
                LET l_inao.inao007 = g_inag_d[l_ac].inag006
                LET l_inao.inao008 = g_inai_d[l_i].inai007
                LET l_inao.inao009 = g_inai_d[l_i].inai008
             WHEN g_inbg.inbg001 = '2'
                LET l_inao.inao002 = g_inag_d[l_ac].inag002
                LET l_inao.inao003 = g_inbg.inbg011
                LET l_inao.inao007 = g_inag_d[l_ac].inag006
                LET l_inao.inao008 = g_inai_d[l_i].inai007
                LET l_inao.inao009 = g_inai_d[l_i].inai008
             WHEN g_inbg.inbg001 = '4'
                LET l_inao.inao002 = g_inag_d[l_ac].inag002
                LET l_inao.inao003 = g_inag_d[l_ac].inag003
                LET l_inao.inao007 = g_inbg.inbg011
                LET l_inao.inao008 = g_inai_d[l_i].inai007
                LET l_inao.inao009 = g_inai_d[l_i].inai008
             WHEN g_inbg.inbg001 ='5'
                LET l_inao.inao002 = g_inag_d[l_ac].inag002
                LET l_inao.inao003 = g_inag_d[l_ac].inag003
                LET l_inao.inao007 = g_inag_d[l_ac].inag006
                LET l_inao.inao008 = g_inbg.inbg011
                LET l_inao.inao009 = g_inai_d[l_i].inai008
             WHEN g_inbg.inbg001 ='6'
                LET l_inao.inao002 = g_inag_d[l_ac].inag002
                LET l_inao.inao003 = g_inag_d[l_ac].inag003
                LET l_inao.inao007 = g_inag_d[l_ac].inag006
                LET l_inao.inao008 = g_inai_d[l_i].inai007
                LET l_inao.inao009 = g_inbg.inbg011
        END CASE
        #INSERT INTO inao_t VALUES(l_inao.*)  #161124-00048#5  16/12/09 By 08734 mark
        INSERT INTO inao_t(inaoent,inaosite,inaodocno,inaoseq,inaoseq1,inaoseq2,inao000,inao001,inao002,inao003,inao004,inao005,inao006,inao007,inao008,inao009,inao010,inao011,inao012,inao013,inao014,inao020,inao021,inao022,inao023,inao024,inao025)  #161124-00048#5  16/12/09 By 08734 add
           VALUES(l_inao.inaoent,l_inao.inaosite,l_inao.inaodocno,l_inao.inaoseq,l_inao.inaoseq1,l_inao.inaoseq2,l_inao.inao000,l_inao.inao001,l_inao.inao002,l_inao.inao003,l_inao.inao004,l_inao.inao005,l_inao.inao006,l_inao.inao007,l_inao.inao008,l_inao.inao009,l_inao.inao010,l_inao.inao011,l_inao.inao012,l_inao.inao013,l_inao.inao014,l_inao.inao020,l_inao.inao021,l_inao.inao022,l_inao.inao023,l_inao.inao024,l_inao.inao025)
        IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.SQLCODE
           LET g_errparam.extend = ''
           LET g_errparam.popup = TRUE
           CALL cl_err()

           RETURN FALSE
        END IF
        LET l_cnt = l_cnt + 1
     END IF
  END FOR
  RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aint170_01_inai_tmp_ins()
DEFINE l_n         LIKE type_t.num10  #161108-00012#2 num5==》num10
DEFINE l_sql       STRING
#DEFINE l_inbg      RECORD LIKE inbg_t.*  #161124-00048#5  16/12/09 By 08734 mark
#161124-00048#5  16/12/09 By 08734 add(S)
DEFINE l_inbg RECORD  #庫存異常變更申請明細檔
       inbgent LIKE inbg_t.inbgent, #企业编号
       inbgsite LIKE inbg_t.inbgsite, #营运据点
       inbgdocno LIKE inbg_t.inbgdocno, #单据编号
       inbgseq LIKE inbg_t.inbgseq, #项次
       inbg001 LIKE inbg_t.inbg001, #变更类型
       inbg002 LIKE inbg_t.inbg002, #料件编号
       inbg003 LIKE inbg_t.inbg003, #库位
       inbg004 LIKE inbg_t.inbg004, #储位
       inbg005 LIKE inbg_t.inbg005, #产品特征
       inbg006 LIKE inbg_t.inbg006, #库存管理特征
       inbg007 LIKE inbg_t.inbg007, #批号
       inbg008 LIKE inbg_t.inbg008, #库存单位
       inbg009 LIKE inbg_t.inbg009, #制造批号
       inbg010 LIKE inbg_t.inbg010, #制造序号
       inbg011 LIKE inbg_t.inbg011, #变更内容
       inbg012 LIKE inbg_t.inbg012, #变更部分数量
       inbg031 LIKE inbg_t.inbg031, #理由码
       inbg032 LIKE inbg_t.inbg032 #备注
END RECORD
#161124-00048#5  16/12/09 By 08734 add(E)
DEFINE l_inai      type_g_inai_d
DEFINE l_inae010   LIKE inae_t.inae010  #160512-00004#1 by whitney add


   LET l_n = 0 
   SELECT COUNT(*) INTO l_n FROM inao_t
     WHERE inaoent = g_enterprise AND inaodocno = g_inbgdocno
       AND inaosite = g_inbg.inbgsite AND inaoseq = g_inbg.inbgseq
   IF l_n > 0 THEN
      LET l_sql = "SELECT 'Y',inao012,inai010,inao008,inao009 FROM inao_t ",
                  "  LEFT JOIN inai_t ON inaient = inaoent AND inaisite = inaosite AND inai001 = inao001 AND inai002 = inao002 ",
                  "                  AND inai003 = inao003 AND inai004 = inao005 AND inai005 = inao006 AND inai006 = inao007 ",
                  "                  AND inai007 = inao008 AND inai008 = inao009 ",
                  " WHERE inaoent = ",g_enterprise," AND inaosite = '",g_site,"' AND inaodocno = '",g_inbgdocno,"' AND inaoseq = ",g_inbg.inbgseq,
                  " AND inao013 = -1  AND inao001 = '",g_inbg.inbg002,"'"
      IF g_inag_d[l_ac].inag002 IS NOT NULL THEN
         LET l_sql = l_sql," AND inao002 = '",g_inag_d[l_ac].inag002,"'"
      END IF
      IF g_inag_d[l_ac].inag003 IS NOT NULL THEN
         LET l_sql = l_sql," AND inao003 = '",g_inag_d[l_ac].inag003,"'"
      END IF
      IF g_inag_d[l_ac].inag004 IS NOT NULL THEN
         LET l_sql = l_sql," AND inao005 = '",g_inag_d[l_ac].inag004,"'"
      END IF
      IF g_inag_d[l_ac].inag005 IS NOT NULL THEN
         LET l_sql = l_sql," AND inao006 = '",g_inag_d[l_ac].inag005,"'"
      END IF
      IF g_inag_d[l_ac].inag006 IS NOT NULL THEN
         LET l_sql = l_sql," AND inao007 = '",g_inag_d[l_ac].inag006,"'"
      END IF
      PREPARE sel_inao_prep FROM l_sql
      DECLARE sel_inao_curs CURSOR FOR sel_inao_prep 
      FOREACH sel_inao_curs  INTO l_inai.*
         INSERT INTO inai_tmp VALUES(l_inai.sel1,l_inai.change_num1,l_inai.inai010,
                              l_inai.inai007,l_inai.inai008,l_ac)
      END FOREACH
   ELSE
      #160512-00004#1 by whitney modify start
      #LET l_sql = "SELECT 'Y',inai010,inai010,inai007,inai008,inai012 FROM inai_t  WHERE inaient = ",g_enterprise," AND inaisite = '",g_site,"'",
      #            "   AND inai001 = '",g_inbg.inbg002,"' AND inai010 > 0 "
      LET l_sql = " SELECT 'Y',inai010,inai010,inai007,inai008,inae010 ",
                  "   FROM inai_t ",
                  "   LEFT JOIN inae_t ON inaeent=inaient AND inae001=inai001 AND inaesite=inaisite AND inae002=inai002 AND inae003=inai007 AND inae004=inai008 ",
                  "  WHERE inaient = ",g_enterprise," AND inaisite = '",g_site,"' ",
                  "    AND inai001 = '",g_inbg.inbg002,"' AND inai010 > 0 "
      #160512-00004#1 by whitney modify end
      IF g_inag_d[l_ac].inag002 IS NOT NULL THEN
         LET l_sql = l_sql," AND inai002 = '",g_inag_d[l_ac].inag002,"'"
      END IF
      IF g_inag_d[l_ac].inag003 IS NOT NULL THEN
         LET l_sql = l_sql," AND inai003 = '",g_inag_d[l_ac].inag003,"'"
      END IF
      IF g_inag_d[l_ac].inag004 IS NOT NULL THEN
         LET l_sql = l_sql," AND inai004 = '",g_inag_d[l_ac].inag004,"'"
      END IF
      IF g_inag_d[l_ac].inag005 IS NOT NULL THEN
         LET l_sql = l_sql," AND inai005 = '",g_inag_d[l_ac].inag005,"'"
      END IF
      IF g_inag_d[l_ac].inag006 IS NOT NULL THEN
         LET l_sql = l_sql," AND inai006 = '",g_inag_d[l_ac].inag006,"'"
      END IF
      
      PREPARE sel_inai_prep FROM l_sql
      DECLARE sel_inai_curs CURSOR FOR sel_inai_prep 
  
      FOREACH sel_inai_curs  INTO l_inai.*
         INSERT INTO inai_tmp VALUES(l_inai.sel1,l_inai.change_num1,l_inai.inai010,
                              l_inai.inai007,l_inai.inai008,l_inai.inae010,l_ac)  #160512-00004#1 by whitney modify inai012->inae010
      END FOREACH                  
   END IF
   FREE sel_inai_curs
   FREE sel_inao_curs
END FUNCTION

 
{</section>}
 
