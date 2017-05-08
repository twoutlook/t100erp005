#該程式未解開Section, 採用最新樣板產出!
{<section id="aint801_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2015-11-20 18:10:01), PR版次:0001(2015-12-03 18:59:41)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000033
#+ Filename...: aint801_02
#+ Description: 庫存資料選取作業
#+ Creator....: 01752(2015-11-18 11:09:48)
#+ Modifier...: 01752 -SD/PR- 01752
 
{</section>}
 
{<section id="aint801_02.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"

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
 
{<section id="aint801_02.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
 TYPE type_g_inag_d RECORD
       l_sel             LIKE type_t.chr500, 
       inagsite          LIKE inag_t.inagsite, 
       inag006           LIKE inag_t.inag006, 
       inag001           LIKE inag_t.inag001, 
       inag001_desc      LIKE type_t.chr500, 
       inag001_desc_desc LIKE type_t.chr500, 
       inag002           LIKE inag_t.inag002, 
       inag003           LIKE inag_t.inag003, 
       inag004           LIKE inag_t.inag004, 
       inag004_desc      LIKE type_t.chr500, 
       inag005           LIKE inag_t.inag005, 
       inag005_desc      LIKE type_t.chr500, 
       inag007           LIKE inag_t.inag007, 
       inag007_desc      LIKE type_t.chr500, 
       inag008           LIKE inag_t.inag008, 
       l_inad010         LIKE type_t.chr500, 
       l_inad010_desc    LIKE type_t.chr500, 
       l_stan001         LIKE type_t.chr500
       END RECORD

DEFINE g_inag_d          DYNAMIC ARRAY OF type_g_inag_d #單身變數
       
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
 
{<section id="aint801_02.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="aint801_02.other_dialog" >}

 
{</section>}
 
{<section id="aint801_02.other_function" readonly="Y" >}

PUBLIC FUNCTION aint801_02(p_indrsite,p_indrdocno,p_indr002,p_indr004)
   DEFINE p_indrsite     LIKE indr_t.indrsite
   DEFINE p_indrdocno    LIKE indr_t.indrdocno
   DEFINE p_indr002      LIKE indr_t.indr002
   DEFINE p_indr004      LIKE indr_t.indr004
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_success      LIKE type_t.num5
   
   WHENEVER ERROR CALL cl_err_msg_log

   #畫面開啟 (identifier)
   OPEN WINDOW w_aint801_02 WITH FORM cl_ap_formpath("ain","aint801_02")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()

   #程式初始化
   CALL aint801_02_init()
   
   LET g_indrsite = p_indrsite
   LET g_indrdocno = p_indrdocno
   LET g_indr002 = p_indr002
   LET g_indr004 = p_indr004
   
   #進入選單 Menu (="N")
   LET r_success = TRUE
   
   CALL aint801_02_ui_dialog() RETURNING l_success
   IF NOT l_success  THEN
      LET r_success = FALSE
   END IF

   #畫面關閉
   CLOSE WINDOW w_aint801_02

   RETURN r_success
END FUNCTION

PRIVATE FUNCTION aint801_02_b_fill(p_wc2)
   DEFINE p_wc2    STRING
   DEFINE l_where  STRING
   DEFINE l_sql    STRING
   
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   LET l_where = s_aooi500_sql_where(g_prog,'inagsite')
   LET l_where = cl_replace_str(l_where,'inagsite','t0.inagsite')
   LET p_wc2 = p_wc2 CLIPPED," AND ",l_where
   

   LET g_sql = "SELECT  UNIQUE 'N',t0.inagsite,t0.inag006,t0.inag001,t0.inag002,t0.inag003,t0.inag004,t0.inag005,",
               "               t0.inag007,t0.inag008 ,t2.imaal003 ,t2.imaal004 , ",
               "               (SELECT inayl003 FROM inayl_t ",
               "                WHERE inaylent = t0.inagent  AND inayl001 = t0.inag004  ",
               "                  AND inayl002 = '",g_dlang,"' ),",
               "               (SELECT inab003 FROM inab_t  ",
               "                WHERE inabent = t0.inagent AND inab001 = t0.inag004 AND inab002 = t0.inag005 ",
               "                  AND inabsite = t0.inagsite ), ",
               "               (SELECT oocal003 FROM oocal_t ",
               "                WHERE oocalent= t0.inagent AND oocal001 = t0.inag007 AND oocal002='"||g_dlang||"' ),",
               "               COALESCE(t1.inad010,(SELECT imaf153 FROM imaf_t where imafent = t0.inagent AND imafsite = 'ALL' AND imaf001 = t0.inag001)) ",
               " FROM inag_t t0",
               " LEFT JOIN inad_t t1 ON t0.inagent = t1.inadent AND t0.inagsite = t1.inadsite AND t0.inag001 = t1.inad001 AND t0.inag002 = t1.inad002 AND t0.inag006 = t1.inad003",
               " LEFT JOIN imaal_t t2 ON t2.imaalent='"||g_enterprise||"' AND t2.imaal001=t0.inag001 AND t2.imaal002='"||g_dlang||"' ",
               " WHERE t0.inagent= ?  AND  1=1 AND (", p_wc2, ") ",
               "   AND inag006 != ' '"
   IF g_indr002 != 'ALL' THEN
      LET g_sql = g_sql CLIPPED,
                  " AND inag001 IN (SELECT imaa001 FROM imaa_t ",
                  "                  WHERE imaaent = ",g_enterprise,
                  "                    AND imaa009 IN ( SELECT rtaw002 FROM rtaw_t ",
                  "                                      WHERE rtawent = ",g_enterprise,
                  "                                        AND rtaw001 = '",g_indr002,"'))"
   END IF
   LET g_sql = g_sql, cl_sql_add_filter("inag_t"),
                      " ORDER BY t0.inagsite,t0.inag001,t0.inag002,t0.inag003,t0.inag004,t0.inag005,t0.inag006,t0.inag007"

   DISPLAY "g_sql:",g_sql
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aint801_02_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aint801_02_pb

   OPEN b_fill_curs USING g_enterprise

   LET l_sql = "SELECT star004  FROM star_t,stas_t ",
               " WHERE starent = stasent    AND starsite = stassite ",
               "   AND star001 = stas001    AND starent = ",g_enterprise,
               "   AND star003 = ? ",
               "   AND starstus = 'Y' ",
               "   AND starsite = ? ",
               "   AND ? BETWEEN stas018 AND stas019 ",
               "   AND stas003 = ? ",
               " ORDER BY starcnfdt DESC"
               
   PREPARE aint801_star004_prep FROM l_sql
   DECLARE aint801_star004_cs SCROLL CURSOR FOR aint801_star004_prep

   CALL g_inag_d.clear()

   LET g_cnt = l_ac
   LET l_ac = 1
   ERROR "Searching!"

   FOREACH b_fill_curs INTO g_inag_d[l_ac].l_sel,   g_inag_d[l_ac].inagsite,g_inag_d[l_ac].inag006,g_inag_d[l_ac].inag001,
                            g_inag_d[l_ac].inag002, g_inag_d[l_ac].inag003,g_inag_d[l_ac].inag004,
                            g_inag_d[l_ac].inag005, g_inag_d[l_ac].inag007,g_inag_d[l_ac].inag008,
                            g_inag_d[l_ac].inag001_desc,g_inag_d[l_ac].inag001_desc_desc,g_inag_d[l_ac].inag004_desc,
                            g_inag_d[l_ac].inag005_desc, g_inag_d[l_ac].inag007_desc,g_inag_d[l_ac].l_inad010
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      IF cl_null(g_inag_d[l_ac].l_inad010) THEN 
         CONTINUE FOREACH
      END IF 
      
      LET g_inag_d[l_ac].l_stan001 = ''
      OPEN aint801_star004_cs USING g_inag_d[l_ac].l_inad010, g_inag_d[l_ac].inagsite,
                                    g_today, g_inag_d[l_ac].inag001
      
      FETCH FIRST aint801_star004_cs INTO g_inag_d[l_ac].l_stan001 

      IF cl_null(g_inag_d[l_ac].l_stan001) THEN
         CONTINUE FOREACH
      END IF
           
      CALL aint801_02_detail_show()

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

   CALL g_inag_d.deleteElement(g_inag_d.getLength())

   IF g_cnt > g_inag_d.getLength() THEN
      LET l_ac = g_inag_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac

   ERROR ""

   LET g_detail_cnt = g_inag_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt

   CLOSE b_fill_curs
   FREE aint801_02_pb

END FUNCTION

PRIVATE FUNCTION aint801_02_detail_show()
   
   #因為供應商取值 是優先抓inad010 無資料時取imaf153 
   #無法在b_fill的主SQL中 一次處理
   CALL s_desc_get_trading_partner_abbr_desc(g_inag_d[l_ac].l_inad010) 
    RETURNING g_inag_d[l_ac].l_inad010_desc
  
   ##產品特徵
   #CALL s_feature_description( g_pmds_d[l_ac].pmdu001, g_pmds_d[l_ac].pmdu002)
   # RETURNING l_success,g_pmds_d[l_ac].pmdu002_desc
   
END FUNCTION

PRIVATE FUNCTION aint801_02_init()

   LET g_error_show = 1

END FUNCTION

PRIVATE FUNCTION aint801_02_query()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING

   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_inag_d.clear()

   LET g_qryparam.state = "c"

   LET ls_wc = g_wc2

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      CONSTRUCT g_wc2 ON inagsite,inag006,inag001,inag002,inag003,inag004,inag005,inag007,inag008

         FROM s_detail1[1].inagsite,s_detail1[1].inag006,s_detail1[1].inag001,s_detail1[1].inag002,
              s_detail1[1].inag003, s_detail1[1].inag004,s_detail1[1].inag005,s_detail1[1].inag007,
              s_detail1[1].inag008

         ON ACTION controlp INFIELD inagsite
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inagsite()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inagsite  #顯示到畫面上
            NEXT FIELD inagsite                     #返回原欄位

         ON ACTION controlp INFIELD inag006
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag006_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inag006  #顯示到畫面上
            NEXT FIELD inag006                     #返回原欄位

         ON ACTION controlp INFIELD inag001
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001_7()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inag001  #顯示到畫面上
            NEXT FIELD inag001                     #返回原欄位

         ON ACTION controlp INFIELD inag002
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inag002  #顯示到畫面上
            NEXT FIELD inag002                     #返回原欄位

         ON ACTION controlp INFIELD inag003
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inag003  #顯示到畫面上
            NEXT FIELD inag003                     #返回原欄位
            
         ON ACTION controlp INFIELD inag004
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag004_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inag004  #顯示到畫面上
            NEXT FIELD inag004                     #返回原欄位

         ON ACTION controlp INFIELD inag005
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag005_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inag005  #顯示到畫面上
            NEXT FIELD inag005                     #返回原欄位

         ON ACTION controlp INFIELD inag007
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inag007  #顯示到畫面上
            NEXT FIELD inag007                     #返回原欄位


         BEFORE CONSTRUCT

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
      #LET g_wc2 = ls_wc
      LET g_wc2 = " 1=2"
      RETURN
   ELSE
      LET g_error_show = 1
      LET g_detail_idx = 1
   END IF

   CALL aint801_02_b_fill(g_wc2)

   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = -100
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF

   LET INT_FLAG = FALSE

END FUNCTION

PRIVATE FUNCTION aint801_02_ui_dialog()
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

   CALL aint801_02_query()
   
   WHILE TRUE

      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_inag_d.clear()

         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL aint801_02_init()
      END IF

      #CALL aint801_02_b_fill(g_wc2)

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         INPUT ARRAY g_inag_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                     INSERT ROW = FALSE,
                     DELETE ROW = FALSE,
                     APPEND ROW = FALSE)
     
            BEFORE INPUT
               LET g_detail_cnt = g_inag_d.getLength()
               
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
               CALL aint801_02_query()
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
         IF NOT aint801_02_ins_inds() THEN
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

PUBLIC FUNCTION aint801_02_ins_inds()
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
            inds002           LIKE inds_t.inds002,
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
   
   FOR l_i = 1 TO g_inag_d.getLength()
      IF g_inag_d[l_i].l_sel = 'Y' THEN
      
         INITIALIZE l_inds.* TO NULL
         LET l_inds.indsent = g_enterprise
         LET l_inds.indsunit = g_indrsite
         LET l_inds.indsdocno = g_indrdocno
         LET l_inds.indsseq = l_seq
         LET l_inds.indsseq1 = 1
         LET l_inds.inds001 = g_inag_d[l_i].inag006  #批號
         LET l_inds.inds002 = g_inag_d[l_i].inag005  #儲位 
         IF cl_null(l_inds.inds002) THEN LET l_inds.inds002 = ' ' END IF
         LET l_inds.inds003 = g_inag_d[l_i].inag004  #庫位      
         LET l_inds.inds004 = g_inag_d[l_i].inag001  #商品編號
         LET l_inds.inds006 = g_inag_d[l_i].inag007  #庫存單位
         LET l_inds.inds007 = g_inag_d[l_i].inag008
         LET l_inds.inds008 = 0
         LET l_inds.inds009 = g_inag_d[l_i].inag008   
         LET l_inds.inds014 = g_inag_d[l_i].l_inad010#採購供應商
         LET l_inds.inds020 = g_inag_d[l_i].inag002  #商品特徵
         IF cl_null(l_inds.inds020) THEN LET l_inds.inds020 = ' ' END IF
         LET l_inds.inds021 = g_inag_d[l_i].inag003  #庫存管理特徵
         IF cl_null(l_inds.inds021) THEN LET l_inds.inds021 = ' ' END IF
         LET l_inds.inds015 = g_inag_d[l_i].l_stan001
         LET l_inds.indssite = g_indrsite

         SELECT imaa014 INTO l_inds.inds005  FROM imaa_t 
          WHERE imaaent = g_enterprise
            AND imaa001 = l_inds.inds004 

         LET l_stan006 = ''
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
                            inds010, inds014, inds015, inds020,  inds021)
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
 
