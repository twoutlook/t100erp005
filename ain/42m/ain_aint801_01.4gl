#該程式未解開Section, 採用最新樣板產出!
{<section id="aint801_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2015-11-18 11:17:53), PR版次:0001(2015-12-03 18:57:48)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000059
#+ Filename...: aint801_01
#+ Description: 收貨入庫單選取作業
#+ Creator....: 01752(2015-06-11 16:41:33)
#+ Modifier...: 01752 -SD/PR- 01752
 
{</section>}
 
{<section id="aint801_01.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"

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
 
{<section id="aint801_01.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
#單身 type 宣告
 TYPE type_g_pmds_d RECORD
       sel                 LIKE type_t.chr1,
       pmdsdocno           LIKE pmds_t.pmdsdocno, 
       pmduseq             LIKE pmdu_t.pmduseq,
       pmduseq1            LIKE pmdu_t.pmduseq1,
       pmds007             LIKE pmds_t.pmds007, 
       pmds007_desc        LIKE type_t.chr500,
       pmdu001             LIKE pmdu_t.pmdu001,
       pmdu001_desc        LIKE type_t.chr500,
       pmdu001_desc_desc   LIKE type_t.chr500,
       pmdu002             LIKE pmdu_t.pmdu002,
       pmdu002_desc        LIKE type_t.chr500,
       pmdt200             LIKE pmdt_t.pmdt200,
       pmdu006             LIKE pmdu_t.pmdu006,
       pmdu006_desc        LIKE type_t.chr500,
       pmdu007             LIKE pmdu_t.pmdu007,
       pmdu007_desc        LIKE type_t.chr500,
       pmdu008             LIKE pmdu_t.pmdu008,
       pmdu005             LIKE pmdu_t.pmdu005,
       inag008             LIKE inag_t.inag008,
       inag007             LIKE inag_t.inag007,
       inag007_desc        LIKE type_t.chr500
       END RECORD

DEFINE g_pmds_d          DYNAMIC ARRAY OF type_g_pmds_d #單身變數
       
DEFINE g_wc2                STRING
DEFINE g_sql                STRING
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_temp_idx           LIKE type_t.num10             #單身 所在筆數(暫存用)
DEFINE g_detail_idx         LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail_cnt         LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_error_show         LIKE type_t.num5 

DEFINE g_indrsite           LIKE indr_t.indrsite
DEFINE g_indrdocno          LIKE indr_t.indrdocno
DEFINE g_indr002            LIKE indr_t.indr002
DEFINE g_indr004            LIKE indr_t.indr004
#end add-point
 
{</section>}
 
{<section id="aint801_01.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="aint801_01.other_dialog" >}

 
{</section>}
 
{<section id="aint801_01.other_function" readonly="Y" >}

PUBLIC FUNCTION aint801_01(p_indrsite,p_indrdocno,p_indr002,p_indr004)
   DEFINE p_indrsite     LIKE indr_t.indrsite
   DEFINE p_indrdocno    LIKE indr_t.indrdocno
   DEFINE p_indr002      LIKE indr_t.indr002
   DEFINE p_indr004      LIKE indr_t.indr004
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_success      LIKE type_t.num5
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log

   #畫面開啟 (identifier)
   OPEN WINDOW w_aint801_01 WITH FORM cl_ap_formpath("ain","aint801_01")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL aint801_01_init()
   
   LET g_indrsite = p_indrsite
   LET g_indrdocno = p_indrdocno
   LET g_indr002 = p_indr002
   LET g_indr004 = p_indr004
   
   #進入選單 Menu (="N")
   LET r_success = TRUE
   
   CALL aint801_01_ui_dialog() RETURNING l_success
   IF NOT l_success  THEN
      LET r_success = FALSE
   END IF

   #畫面關閉
   CLOSE WINDOW w_aint801_01

   RETURN r_success
END FUNCTION

PRIVATE FUNCTION aint801_01_b_fill(p_wc2)
   DEFINE p_wc2    STRING
   DEFINE l_where  STRING
   
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   LET l_where = s_aooi500_sql_where(g_prog,'pmdssite')
   LET l_where = cl_replace_str(l_where,'pmdssite','t0.pmdssite')
   LET p_wc2 = p_wc2 CLIPPED," AND ",l_where

   LET g_sql = "SELECT  UNIQUE 'N',t0.pmdsdocno, t2.pmduseq, t2.pmduseq1, t0.pmds007 ,t1.pmaal004,",
               "                   t2.pmdu001  , t3.imaal003,t3.imaal004, t2.pmdu002 ,'',",
               "                   t6.pmdt200  , t2.pmdu006 ,t4.inayl003, t2.pmdu007 ,t5.inab003,",
               "                   t2.pmdu008  , t2.pmdu005 , SUM(t7.inag008),t7.inag007,t8.oocal003 ",
               "  FROM pmds_t t0",
               "       LEFT JOIN pmaal_t t1 ON t1.pmaalent = t0.pmdsent AND t1.pmaal001 = t0.pmds007 AND t1.pmaal002 ='"||g_dlang||"' ",
               "      ,pmdu_t t2",
               "       LEFT JOIN imaal_t t3 ON t3.imaalent = t2.pmduent AND t3.imaal001 = t2.pmdu001 AND t3.imaal002 ='"||g_dlang||"' ",
               "       LEFT JOIN inayl_t t4 ON t4.inaylent = t2.pmduent AND t4.inayl001 = t2.pmdu006 AND t4.inayl002 ='"||g_dlang||"' ",
               "       LEFT JOIN inab_t t5  ON t5.inabent  = t2.pmduent AND t5.inabsite = t2.pmdusite AND t5.inab001 = t2.pmdu006 AND t5.inab002 = t2.pmdu007 ",
               "      ,pmdt_t t6",
               "      ,inag_t t7",
               "       LEFT JOIN oocal_t t8 ON t8.oocalent = t7.inagent AND t8.oocal001 = t7.inag007 AND t8.oocal002 ='"||g_dlang||"' ",               
               " WHERE t0.pmdsent= ? ",
               "   AND t0.pmdsent = t2.pmduent AND t0.pmdsent = t6.pmdtent AND t0.pmdsent = t7.inagent",
               "   AND t0.pmdsdocno = t2.pmdudocno AND t0.pmdsdocno = t6.pmdtdocno ",
               "   AND t2.pmduseq = t6.pmdtseq ",
               "   AND t2.pmdusite = t7.inagsite AND t2.pmdu001 = t7.inag001 AND t2.pmdu002 = t7.inag002 AND t2.pmdu005 = t7.inag003",
               "   AND t2.pmdu006  = t7.inag004  AND t2.pmdu007 = t7.inag005 AND t2.pmdu008 = t7.inag006 ",
               "   AND t2.pmdu008 != ' ' ",
               "   AND pmds000 IN ('3','4','6','22')", #151104-00007#2 add '22' 開帳入庫
               "   AND (", p_wc2, ") "
   IF g_indr002 != 'ALL' THEN
      LET g_sql = g_sql CLIPPED,
                  " AND pmdu001 IN (SELECT imaa001 FROM imaa_t ",
                  "                  WHERE imaaent = ",g_enterprise,
                  "                    AND imaa009 IN ( SELECT rtaw002 FROM rtaw_t ",
                  "                                      WHERE rtawent = ",g_enterprise,
                  "                                        AND rtaw001 = '",g_indr002,"'))"
   END IF
   LET g_sql = g_sql, cl_sql_add_filter("pmds_t"),
               " GROUP BY 'N',t0.pmdsdocno, t2.pmduseq, t2.pmduseq1, t0.pmds007 ,t1.pmaal004,",
               "              t2.pmdu001  , t3.imaal003,t3.imaal004, t2.pmdu002 ,'',",
               "              t6.pmdt200  , t2.pmdu006 ,t4.inayl003, t2.pmdu007 ,t5.inab003,",
               "              t2.pmdu008  , t2.pmdu005 ,t7.inag007,t8.oocal003 ",
               " ORDER BY t0.pmdsdocno,t2.pmduseq,t2.pmduseq1,t0.pmds007,t2.pmdu001"

   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aint801_01_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aint801_01_pb

   OPEN b_fill_curs USING g_enterprise

   CALL g_pmds_d.clear()


   LET g_cnt = l_ac
   LET l_ac = 1
   ERROR "Searching!"

   FOREACH b_fill_curs INTO g_pmds_d[l_ac].sel,g_pmds_d[l_ac].pmdsdocno,g_pmds_d[l_ac].pmduseq,g_pmds_d[l_ac].pmduseq1,g_pmds_d[l_ac].pmds007,g_pmds_d[l_ac].pmds007_desc,
                            g_pmds_d[l_ac].pmdu001,g_pmds_d[l_ac].pmdu001_desc,g_pmds_d[l_ac].pmdu001_desc_desc,g_pmds_d[l_ac].pmdu002,g_pmds_d[l_ac].pmdu002_desc,
                            g_pmds_d[l_ac].pmdt200,g_pmds_d[l_ac].pmdu006,g_pmds_d[l_ac].pmdu006_desc,g_pmds_d[l_ac].pmdu007,g_pmds_d[l_ac].pmdu007_desc,
                            g_pmds_d[l_ac].pmdu008,g_pmds_d[l_ac].pmdu005,g_pmds_d[l_ac].inag008,g_pmds_d[l_ac].inag007,g_pmds_d[l_ac].inag007_desc

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      #IF g_pmds_d[l_ac].inag008 <= 0 THEN
      #   CONTINUE FOREACH
      #END IF
      
      CALL aint801_01_detail_show()

      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035
            LET g_errparam.popup  = TRUE
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1

   END FOREACH

   LET g_error_show = 0

   CALL g_pmds_d.deleteElement(g_pmds_d.getLength())

   IF g_cnt > g_pmds_d.getLength() THEN
      LET l_ac = g_pmds_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac

   ERROR ""

   LET g_detail_cnt = g_pmds_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt

   CLOSE b_fill_curs
   FREE aint801_01_pb

END FUNCTION

PRIVATE FUNCTION aint801_01_detail_show()
   DEFINE l_success    LIKE type_t.num5
   
   
   #產品特徵
   CALL s_feature_description( g_pmds_d[l_ac].pmdu001, g_pmds_d[l_ac].pmdu002)
    RETURNING l_success,g_pmds_d[l_ac].pmdu002_desc

END FUNCTION

PRIVATE FUNCTION aint801_01_init()

   LET g_error_show = 1

END FUNCTION

PRIVATE FUNCTION aint801_01_query()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING

   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_pmds_d.clear()
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      CONSTRUCT g_wc2 ON pmdsdocno, pmduseq, pmduseq1, pmds007, pmdu001,
                         pmdu002,   pmdt200, pmdu006,  pmdu007, pmdu008,
                         pmdu005,   inag008, inag007
         FROM s_detail1[1].l_pmdsdocno,s_detail1[1].l_pmduseq,s_detail1[1].l_pmduseq1,s_detail1[1].l_pmds007,s_detail1[1].l_pmdu001,
              s_detail1[1].l_pmdu002,  s_detail1[1].l_pmdt200,s_detail1[1].l_pmdu006, s_detail1[1].l_pmdu007,s_detail1[1].l_pmdu008,
              s_detail1[1].l_pmdu005,  s_detail1[1].l_inag008,  s_detail1[1].l_inag007

         BEFORE CONSTRUCT

         ON ACTION controlp INFIELD l_pmdsdocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "('3','4','6')"
            CALL q_pmdsdocno()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_pmdsdocno  #顯示到畫面上
            NEXT FIELD l_pmdsdocno                     #返回原欄位


         ON ACTION controlp INFIELD l_pmds007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_3()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_pmds007  #顯示到畫面上
            NEXT FIELD l_pmds007                     #返回原欄位

         ON ACTION controlp INFIELD l_pmdu001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF g_indr002 != 'ALL' THEN
               LET g_qryparam.where = " imaa009 IN ( SELECT rtaw002 FROM rtaw_t ",
                                      "               WHERE rtawent = ",g_enterprise,
                                      "                 AND rtaw001 = '",g_indr002,"')"
            END IF
            CALL q_imaa001_15()                      #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_pmdu001  #顯示到畫面上
            NEXT FIELD l_pmdu001                     #返回原欄位

         ON ACTION controlp INFIELD l_pmdt200
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF g_indr002 != 'ALL' THEN
               LET g_qryparam.where = " imaa009 IN ( SELECT rtaw002 FROM rtaw_t ",
                                      "               WHERE rtawent = ",g_enterprise,
                                      "                 AND rtaw001 = '",g_indr002,"')"
            END IF
            CALL q_imay003_2()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_pmdt200  #顯示到畫面上
            NEXT FIELD l_pmdt200                     #返回原欄位

         ON ACTION controlp INFIELD l_pmdu006
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inay001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_pmdu006  #顯示到畫面上
            NEXT FIELD l_pmdu006                     #返回原欄位

         ON ACTION controlp INFIELD l_pmdu007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inab002_11()                      #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_pmdu007  #顯示到畫面上
            NEXT FIELD l_pmdu007                     #返回原欄位

         ON ACTION controlp INFIELD l_pmdu008
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag006_2()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_pmdu008  #顯示到畫面上
            NEXT FIELD l_pmdu008                     #返回原欄位

         ON ACTION controlp INFIELD l_inag007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_inag007  #顯示到畫面上
            NEXT FIELD l_inag007                     #返回原欄位

      END CONSTRUCT


      BEFORE DIALOG
         CALL cl_qbe_init()


      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc

      ON ACTION qbe_save
         CALL cl_qbe_save()

      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = 1
         CANCEL DIALOG

      #交談指令共用ACTION
      &include "common_action.4gl"
      CONTINUE DIALOG
   END DIALOG


   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc2 = ls_wc
   ELSE
      LET g_error_show = 1
      LET g_detail_idx = 1
   END IF

   CALL aint801_01_b_fill(g_wc2)

   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = -100
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF

   LET INT_FLAG = FALSE

END FUNCTION

PRIVATE FUNCTION aint801_01_ui_dialog()
   DEFINE r_success LIKE type_t.num5
   DEFINE li_idx    LIKE type_t.num10
   DEFINE la_param  RECORD #串查用
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING

   LET r_success = TRUE
   
   LET g_action_choice = " "
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()

   CALL cl_set_act_visible("accept,cancel", FALSE)

   LET g_detail_idx = 1

   CALL aint801_01_query()
   
   WHILE TRUE

      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_pmds_d.clear()

         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL aint801_01_init()
      END IF
      
      #CALL aint801_01_b_fill(g_wc2)
      
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         INPUT ARRAY g_pmds_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                     INSERT ROW = FALSE,
                     DELETE ROW = FALSE,
                     APPEND ROW = FALSE)
     
            BEFORE INPUT
               LET g_detail_cnt = g_pmds_d.getLength()
               
         END INPUT



         BEFORE DIALOG
            IF g_temp_idx > 0 THEN
               LET l_ac = g_temp_idx
               CALL DIALOG.setCurrentRow("s_detail1",l_ac)
               LET g_temp_idx = 1
            END IF
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)

            NEXT FIELD CURRENT

         #應用 a43 樣板自動產生(Version:2)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aint801_01_query()
               CALL g_curr_diag.setCurrentRow("s_detail1",1)

            END IF

         ON ACTION close
            LET INT_FLAG = 1
            LET g_action_choice="exit"
            CANCEL DIALOG

         ON ACTION exit
            LET INT_FLAG = 1
            LET g_action_choice="exit"
            CANCEL DIALOG

         ON ACTION accept
            ACCEPT DIALOG
        
         ON ACTION cancel
            LET INT_FLAG = 1
            CANCEL DIALOG

      END DIALOG
   
      IF NOT INT_FLAG THEN
         CALL cl_err_collect_init()
         IF NOT aint801_01_ins_inds() THEN
            LET r_success = FALSE      
            CALL cl_err_collect_show()            
            RETURN r_success 
         END IF
         CALL cl_err_collect_show()
      ELSE
         LET INT_FLAG = 0 
      END IF  

      EXIT WHILE

   END WHILE

   CALL cl_set_act_visible("accept,cancel", TRUE)

   RETURN r_success 
END FUNCTION

PRIVATE FUNCTION aint801_01_ins_inds()
   DEFINE r_success LIKE type_t.num5
   DEFINE l_i       LIKE type_t.num5
   DEFINE l_seq     LIKE type_t.num5
   DEFINE l_cnt     LIKE type_t.num5
   DEFINE l_success LIKE type_t.num5
   DEFINE l_stan006 LIKE stan_t.stan006
   DEFINE l_inds    RECORD
            indsent           LIKE inds_t.indsent,
            indssite          LIKE inds_t.indssite, 
            indsunit          LIKE inds_t.indsunit, 
            indsdocno         LIKE inds_t.indsdocno,
            indsseq           LIKE inds_t.indsseq, 
            indsseq1          LIKE inds_t.indsseq1, 
            inds001           LIKE inds_t.inds001, 
            inds002           LIKE inds_t.inds002,    #151118-00002#1 2015/11/20 By benson 
            inds003           LIKE inds_t.inds003, 
            inds004           LIKE inds_t.inds004, 
            inds005           LIKE inds_t.inds005, 
            inds006           LIKE inds_t.inds006, 
            inds007           LIKE inds_t.inds007, 
            inds008           LIKE inds_t.inds008, 
            inds009           LIKE inds_t.inds009,
            inds010           LIKE inds_t.inds010,
            inds014           LIKE inds_t.inds014,
            inds015           LIKE inds_t.inds015,
            inds020           LIKE inds_t.inds020,
            inds021           LIKE inds_t.inds021
                    END RECORD

   LET r_success = TRUE
   LET l_seq = 0
   SELECT MAX(indsseq)+1 INTO l_seq FROM inds_t
    WHERE indsent = g_enterprise
      AND indsdocno = g_indrdocno
   IF cl_null(l_seq) OR l_seq = 0 THEN
      LET l_seq = 1
   END IF
   
   FOR l_i = 1 TO g_pmds_d.getLength()
      IF g_pmds_d[l_i].sel = 'Y' THEN
      
         INITIALIZE l_inds.* TO NULL
         LET l_inds.indsent = g_enterprise
         LET l_inds.indsunit = g_indrsite
         LET l_inds.indsdocno = g_indrdocno
         LET l_inds.indsseq = l_seq
         LET l_inds.indsseq1 = 1
         LET l_inds.inds001 = g_pmds_d[l_i].pmdu008  #批號
         LET l_inds.inds002 = g_pmds_d[l_i].pmdu007  #儲位     #151118-00002#1 2015/11/20 By benson
         IF cl_null(l_inds.inds002) THEN LET l_inds.inds002 = ' ' END IF 
         LET l_inds.inds003 = g_pmds_d[l_i].pmdu006  #庫位      
         LET l_inds.inds004 = g_pmds_d[l_i].pmdu001  #商品編號
         LET l_inds.inds005 = g_pmds_d[l_i].pmdt200  #條碼編號
         LET l_inds.inds006 = g_pmds_d[l_i].inag007  #庫存單位
         LET l_inds.inds007 = g_pmds_d[l_i].inag008
         LET l_inds.inds008 = 0
         LET l_inds.inds009 = g_pmds_d[l_i].inag008   
         LET l_inds.inds014 = g_pmds_d[l_i].pmds007  #採購供應商
         
         LET l_inds.inds020 = g_pmds_d[l_i].pmdu002  #商品特徵
         IF cl_null(l_inds.inds020) THEN LET l_inds.inds020 = ' ' END IF
         
         LET l_inds.inds021 = g_pmds_d[l_i].pmdu005  #庫存管理特徵
         IF cl_null(l_inds.inds021) THEN LET l_inds.inds021 = ' ' END IF
         
         SELECT pmdtsite,pmdt212 INTO l_inds.indssite,l_inds.inds015 FROM pmdt_t
          WHERE pmdtent = g_enterprise
            AND pmdtdocno = g_pmds_d[l_i].pmdsdocno
            AND pmdtseq = g_pmds_d[l_i].pmduseq     
              
        SELECT stan006
          INTO l_stan006
          FROM stan_t
         WHERE stanent = g_enterprise
           AND stan001 = l_inds.inds015
                 
         CALL s_cost_price_get_item_cost(l_inds.indssite,             '',               '',             '',
                                         '',                          '',   l_inds.inds004,   l_inds.inds020,
                                         l_inds.inds006,  l_inds.inds001,   l_inds.inds021,   l_stan006)
          RETURNING l_success, l_inds.inds010
         IF NOT l_success THEN
            CONTINUE FOR
         END IF            
                    
         LET l_cnt = 0 
         SELECT COUNT(*) INTO l_cnt FROM inds_t
          WHERE indsent = l_inds.indsent
            AND indsdocno = l_inds.indsdocno
            AND indssite = l_inds.indssite
            AND inds001 = l_inds.inds001
            AND inds002 = l_inds.inds002
            AND inds003 = l_inds.inds003
            AND inds004 = l_inds.inds004
            AND inds005 = l_inds.inds005
            AND inds006 = l_inds.inds006
            AND inds014 = l_inds.inds014
            AND inds020 = l_inds.inds020
            AND inds021 = l_inds.inds021            
         IF l_cnt > 0 THEN
            CONTINUE FOR
         END IF
         
         
         INSERT INTO inds_t(indsent, indssite,indsunit,indsdocno,indsseq,
                            indsseq1,inds001, inds002, inds003,  inds004, 
                            inds005, inds006, inds007, inds008,  inds009, 
                            inds010, inds014, inds015, inds020, inds021)
                VALUES(l_inds.indsent, l_inds.indssite,l_inds.indsunit,l_inds.indsdocno,l_inds.indsseq,
                       l_inds.indsseq1,l_inds.inds001, l_inds.inds002, l_inds.inds003,  l_inds.inds004, 
                       l_inds.inds005, l_inds.inds006, l_inds.inds007, l_inds.inds008,  l_inds.inds009, 
                       l_inds.inds010, l_inds.inds014, l_inds.inds015, l_inds.inds020,  l_inds.inds021)

         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inds_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = FALSE 
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
         
         LET l_seq = l_seq + 1
      END IF
   END FOR

   RETURN r_success
END FUNCTION

 
{</section>}
 
