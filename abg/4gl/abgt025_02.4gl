#該程式未解開Section, 採用最新樣板產出!
{<section id="abgt025_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2015-08-06 10:47:24), PR版次:0004(2016-11-10 13:55:24)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000034
#+ Filename...: abgt025_02
#+ Description: 預算調整
#+ Creator....: 03080(2015-08-06 10:43:31)
#+ Modifier...: 03080 -SD/PR- 08171
 
{</section>}
 
{<section id="abgt025_02.global" >}
#應用 c01c 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160920-00019#3    2016/09/20   By 08732  交易對象開窗調整為q_pmaa001_25
#161006-00005#10   2016/10/21   By 08732  組織類型與職能開窗調整
#161104-00024#8    2016/11/08   By 08171  程式中DEFINE RECORD LIKE時不可以用*的寫法，要一個一個欄位定義
#161108-00017#5    2016/11/10   By 08732  程式中INSERT INTO時不可以用*的寫法，要一個一個欄位定義
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc" name="global.inc"

#end add-point
 
DEFINE g_rec_b               LIKE type_t.num10
DEFINE g_wc                  STRING
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_bgbi_d        RECORD
        l_bgbiseq   LIKE bgbi_t.bgbiseq,
        l_bgbi004   LIKE bgbi_t.bgbi004,
        l_bgbi004_desc LIKE type_t.chr1000,
        l_bgbi006   LIKE bgbi_t.bgbi006,
        l_bgbi007   LIKE bgbi_t.bgbi007,
        l_bgbi007_desc LIKE type_t.chr1000,
        l_bgbi008   LIKE bgbi_t.bgbi008,
        l_bgbi008_desc LIKE type_t.chr1000,
        l_bgbi009   LIKE bgbi_t.bgbi009,
        l_bgbi009_desc LIKE type_t.chr1000,
        l_bgbi010   LIKE bgbi_t.bgbi010,
        l_bgbi010_desc LIKE type_t.chr1000,
        l_bgbi011   LIKE bgbi_t.bgbi011,
        l_bgbi011_desc LIKE type_t.chr1000,
        l_bgbi012   LIKE bgbi_t.bgbi012,
        l_bgbi012_desc LIKE type_t.chr1000,
        l_bgbi013   LIKE bgbi_t.bgbi013,
        l_bgbi013_desc LIKE type_t.chr1000,
        l_bgbi039   LIKE bgbi_t.bgbi039,
        l_bgbi040   LIKE bgbi_t.bgbi040,
        l_bgbi040_desc LIKE type_t.chr1000,
        l_bgbi041   LIKE bgbi_t.bgbi041,
        l_bgbi041_desc LIKE type_t.chr1000,
        l_bgbi014   LIKE bgbi_t.bgbi014,
        l_bgbi014_desc LIKE type_t.chr1000,
        l_bgbi015   LIKE bgbi_t.bgbi015,
        l_bgbi015_desc LIKE type_t.chr1000,
        l_bgbi016   LIKE bgbi_t.bgbi016,
        l_bgbi016_desc LIKE type_t.chr1000,
        l_bgbi028   LIKE bgbi_t.bgbi028,
        l_bgbi028_desc LIKE type_t.chr1000,
        l_bgbi029   LIKE bgbi_t.bgbi029,
        l_bgbi029_desc LIKE type_t.chr1000,
        l_bgbi030   LIKE bgbi_t.bgbi030,
        l_bgbi030_desc LIKE type_t.chr1000,
        l_bgbi031   LIKE bgbi_t.bgbi031,
        l_bgbi031_desc LIKE type_t.chr1000,
        l_bgbi032   LIKE bgbi_t.bgbi032,
        l_bgbi032_desc LIKE type_t.chr1000,
        l_bgbi033   LIKE bgbi_t.bgbi033,
        l_bgbi033_desc LIKE type_t.chr1000,
        l_bgbi034   LIKE bgbi_t.bgbi034,
        l_bgbi034_desc LIKE type_t.chr1000,
        l_bgbi035   LIKE bgbi_t.bgbi035,
        l_bgbi035_desc LIKE type_t.chr1000,
        l_bgbi036   LIKE bgbi_t.bgbi036,
        l_bgbi036_desc LIKE type_t.chr1000,
        l_bgbi037   LIKE bgbi_t.bgbi037,
        l_bgbi037_desc LIKE type_t.chr1000,
        l_bgbi038   LIKE bgbi_t.bgbi038,
        l_bgbi038_desc LIKE type_t.chr1000,
        l_bgbi020   LIKE bgbi_t.bgbi020,
        l_amountb   LIKE type_t.num20_6,
        l_accountb  LIKE type_t.num20_6,
        l_taxb      LIKE type_t.num20_6,
        l_amountc   LIKE type_t.num20_6,
        l_accountc  LIKE type_t.num20_6,
        l_amounta   LIKE type_t.num20_6,
        l_accounta  LIKE type_t.num20_6,
        l_taxa      LIKE type_t.num20_6
END RECORD
DEFINE g_bgbi_d          DYNAMIC ARRAY OF type_g_bgbi_d
DEFINE g_bgbi_d_t        type_g_bgbi_d
DEFINE g_bgbi_d_o        type_g_bgbi_d

DEFINE g_groupbyfield   DYNAMIC ARRAY OF RECORD
                         l_field   LIKE type_t.chr100,
                         l_used    LIKE type_t.chr1
                         END RECORD
DEFINE g_construct_display   STRING
DEFINE l_ac  LIKE type_t.num10
DEFINE g_bgbh   RECORD
                bgbh001   LIKE bgbh_t.bgbh001,
                bgbh002   LIKE bgbh_t.bgbh002,
                bgbh003   LIKE bgbh_t.bgbh003,
                bgbh004   LIKE bgbh_t.bgbh004,
                bgbh005   LIKE bgbh_t.bgbh005,
                bgbh006   LIKE bgbh_t.bgbh006
                END RECORD
DEFINE g_detail_idx   LIKE type_t.num10
DEFINE g_do_lock      LIKE type_t.chr1
DEFINE g_userorga     STRING   #161006-00005#10   add
DEFINE g_wc_orga      STRING   #161006-00005#10   add
DEFINE l_orga         STRING   #161006-00005#10   add
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point  
 
{</section>}
 
{<section id="abgt025_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION abgt025_02(--)
   #add-point:construct段變數傳入 name="construct.get_var"
   p_bgbh001,p_bgbh002,p_bgbh003,p_bgbh004,p_bgbh006
   #end add-point
   )
   #add-point:construct段define name="construct.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   #add-point:construct段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="construct.define"
   DEFINE p_bgbh001   LIKE bgbh_t.bgbh001
   DEFINE p_bgbh002   LIKE bgbh_t.bgbh002
   DEFINE p_bgbh003   LIKE bgbh_t.bgbh003
   DEFINE p_bgbh004   LIKE bgbh_t.bgbh004
   DEFINE p_bgbh006   LIKE bgbh_t.bgbh006
   DEFINE l_sql       STRING
   DEFINE l_orga      STRING   #161006-00005#10   add
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_abgt025_02 WITH FORM cl_ap_formpath("abg","abgt025_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   #輸入前處理
   #add-point:單頭前置處理 name="construct.pre_construct"
#   #宣告lock cursor
#   #TEMPTABLE中的KEY欄位 
#   #abgt025的LOCK在原程式呼叫
#   
#   LET l_sql = "SELECT bgbh001,bgbh002,bgbh003,bgbh004,bgbh005,bgbh006 ",

   INITIALIZE g_bgbh.* TO NULL
   SELECT bgbh001,bgbh002,bgbh003,bgbh004,bgbh005,bgbh006
     INTO g_bgbh.*
     FROM bgbh_t
    WHERE bgbhent = g_enterprise
      AND bgbh001 = p_bgbh001
      AND bgbh002 = p_bgbh002
      AND bgbh003 = p_bgbh003
      AND bgbh004 = p_bgbh004
      AND bgbh006 = p_bgbh006
      
   LET g_do_lock = 'N'
    #用tmp資料lock cursor
   LET l_sql = "SELECT * FROM bgbh_t ",
               " WHERE bgbhent = ",g_enterprise," ",
               "   AND (bgbh001,bgbh002,bgbh003,bgbh004,bgbh006) IN (",
               "      SELECT DISTINCT bgbi002,bgbi003,bgbi004,bgbi005,bgbi044 ",
               "         FROM s_abgt025_tmp1 ",
               "        ) ",
               " FOR UPDATE "
   PREPARE lock_bgbhp1 FROM l_sql
   DECLARE lock_bgbhc1 CURSOR FOR lock_bgbhp1
   CALL abgt025_02_prepare_declare()
   CALL cl_set_combo_scc('bgbh006','9989')
   CALL cl_set_combo_scc('bgbi039','6013')
   CALL g_bgbi_d.clear()
   
   #161006-00005#10  add---s
   CALL s_fin_create_account_center_tmp()
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_sons_str() RETURNING g_userorga
   CALL s_fin_get_wc_str(g_userorga) RETURNING g_userorga
   CALL s_fin_abg_center_sons_query(g_userorga,'','')
   CALL s_fin_account_center_sons_str() RETURNING g_wc_orga   
   CALL s_fin_get_wc_str(g_wc_orga) RETURNING g_wc_orga    
   #161006-00005#10  add---e
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      CONSTRUCT BY NAME g_wc ON a 
      
            #add-point:自定義action name="construct.action"
 
            #end add-point
      
         BEFORE CONSTRUCT
            #add-point:單頭輸入前處理 name="construct.before_construct"
            
            #end add-point
            
         AFTER CONSTRUCT
            #add-point:單頭輸入後處理 name="construct.after_construct"
            
            #end add-point
            
         
 
         
       
      END CONSTRUCT
 
      #add-point:自定義construct name="construct.more_construct"
      DISPLAY ARRAY g_bgbi_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b)
      END DISPLAY
      
      BEFORE DIALOG
         CALL cl_set_act_visible('accept,cancel',FALSE)
         DISPLAY BY NAME g_bgbh.bgbh001,g_bgbh.bgbh002,g_bgbh.bgbh004,g_bgbh.bgbh005,g_bgbh.bgbh006
         #DISPLAY g_bgbh.bgbh003 TO bgbi004
         CALL cl_set_act_visible('modify_detail,modify',FALSE)
      ON ACTION query
         CALL abgt025_02_construct()
         CALL cl_set_act_visible('modify_detail,modify',TRUE)
         LET l_count = NULL
         SELECT COUNT(*) INTO l_count FROM s_abgt025_tmp1
         IF cl_null(l_count)THEN LET l_count = 0 END IF
         
         IF l_count = 0 THEN
            CALL cl_set_act_visible('modify_detail,modify',FALSE)
         ELSE
         END IF
      ON ACTION modify_detail
         CALL abgt025_02_input()
         
      ON ACTION modify
         CALL abgt025_02_input()
      #end add-point
      
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit
         LET INT_FLAG = TRUE 
         EXIT DIALOG
   
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
         
   END DIALOG
 
   #add-point:畫面關閉前 name="construct.before_close"
   CALL abgt025_02_upd_source()
   IF g_do_lock = 'Y' THEN
      CLOSE lock_bgbhc1
   END IF
   #end add-point 
   
   #畫面關閉
   CLOSE WINDOW w_abgt025_02 
   
   #add-point:construct段after construct name="construct.post_construct"
   IF INT_FLAG THEN
      LET INT_FLAG = 0
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abgt025_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="abgt025_02.other_function" readonly="Y" >}

PRIVATE FUNCTION abgt025_02_prepare_declare()
   DEFINE l_sql   STRING 
   
   WHENEVER ERROR CONTINUE
   #取得相對應在abgt025的項次
   LET l_sql = "SELECT bgbiseq ",
               "  FROM bgbi_t,bgbh_t ",  
               " WHERE bgbient = bgbhent ",
               "   AND bgbi002 = bgbh001 ",
               "   AND bgbi003 = bgbh002 ",
               "   AND bgbi004 = bgbh003 ",
               "   AND bgbi005 = bgbh004 ",
               "   AND bgbi044 = bgbh006 ",
               "   AND bgbient = ", g_enterprise," ",
               "   AND bgbh001 = ? ",               
               "   AND bgbh002 = ? ",
               "   AND bgbh003 = ? ",
               "   AND bgbh004 = ? ",
               "   AND bgbh006 = ? ",
               "   AND (COALESCE(bgbi006,0) = COALESCE( ? ,0))",
               "   AND (COALESCE(bgbi007,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi008,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi009,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi010,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi011,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi012,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi013,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi014,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi015,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi016,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi039,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi040,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi041,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi028,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi029,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi030,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi031,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi032,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi033,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi034,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi035,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi036,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi037,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi038,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi017,' ') = COALESCE( ? ,' '))"
   PREPARE sel_bgbiseqp1 FROM l_sql
   
  
   
END FUNCTION

PRIVATE FUNCTION abgt025_02_construct()
   DEFINE l_wc   STRING
   
   
   WHENEVER ERROR CONTINUE
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      CONSTRUCT BY NAME l_wc ON bgbi004,bgbi006,bgbi007,bgbi008,bgbi009,bgbi038,
                                bgbi010,bgbi011,bgbi012,bgbi013,bgbi039,
                                bgbi040,bgbi041,bgbi014,bgbi015,bgbi016,
                                bgbi028,bgbi029,bgbi030,bgbi031,bgbi032,
                                bgbi033,bgbi034,bgbi035,bgbi036,bgbi037
                                
         ON ACTION controlp INFIELD bgbi004
            #161006-00005#10  add----s
            CALL s_fin_abg_center_sons_query(g_bgbh.bgbh001,'','') 
            CALL s_fin_account_center_sons_str() RETURNING l_orga  
            CALL s_fin_get_wc_str(l_orga) RETURNING l_orga
            #161006-00005#10  add----e
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef001 IN ", g_userorga, " AND ooef001 IN ", l_orga      #161006-00005#10   add
            #CALL q_ooef001()                                                                  #161006-00005#10   mark
            CALL q_ooef001_77()                                                                #161006-00005#10   add
            DISPLAY g_qryparam.return1 TO bgbi004
            NEXT FIELD bgbi004
                                
         ON ACTION controlp INFIELD bgbi007
            #業務部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO bgbi007
            NEXT FIELD bgbi007
            
         ON ACTION controlp INFIELD bgbi008
            #成本利潤中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO bgbi008
            NEXT FIELD bgbi008

         ON ACTION controlp INFIELD bgbi009
            #區域
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()
            DISPLAY g_qryparam.return1 TO bgbi009
            NEXT FIELD bgbi009
            
         ON ACTION controlp INFIELD bgbi010
            #交易客商
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_pmaa001()    #160920-00019#3--mark
            CALL q_pmaa001_25()  #160920-00019#3--add
            DISPLAY g_qryparam.return1 TO bgbi010
            NEXT FIELD bgbi010 

         ON ACTION controlp INFIELD bgbi011
            #收款客商
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmac002_1()
            DISPLAY g_qryparam.return1 TO bgbi011
            NEXT FIELD bgbi011
            
         ON ACTION controlp INFIELD bgbi012
            #客群
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()
            DISPLAY g_qryparam.return1 TO bgbi012
            NEXT FIELD bgbi012

         ON ACTION controlp INFIELD bgbi013
            #產品類別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()
            DISPLAY g_qryparam.return1 TO bgbi013
            NEXT FIELD bgbi013
            
         ON ACTION controlp INFIELD bgbi014
            #人員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()
            DISPLAY g_qryparam.return1 TO bgbi014
            NEXT FIELD bgbi014
            
         ON ACTION controlp INFIELD bgbi015
            #專案代號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()
            DISPLAY g_qryparam.return1 TO bgbi015
            NEXT FIELD bgbi015
            
         ON ACTION controlp INFIELD bgbi016
            #WBS
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "pjbb012='1'"
            CALL q_pjbb002()
            DISPLAY g_qryparam.return1 TO bgbi016
            NEXT FIELD bgbi016
            
         ON ACTION controlp INFIELD bgbi040 
            #渠道
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oojd001_2()
            DISPLAY g_qryparam.return1 TO bgbi040
            NEXT FIELD bgbi040
            
         ON ACTION controlp INFIELD bgbi041
            #品牌
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()
            DISPLAY g_qryparam.return1 TO bgbi041
            NEXT FIELD bgbi041
            
         ON ACTION controlp INFIELD bgbi038
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmai002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgbi038  #顯示到畫面上
            NEXT FIELD bgbi038  
      END CONSTRUCT
      
      AFTER DIALOG
         #擷取銀幕變數確定USER打了哪些條件-----s
         LET g_groupbyfield = NULL
         CALL abgt025_02_field_default()
         LET g_construct_display = NULL
         LET g_construct_display = GET_FLDBUF(bgbi004)
         IF NOT cl_null(g_construct_display)THEN
            LET g_groupbyfield[1].l_used = 'Y'
         END IF
         
         LET g_construct_display = GET_FLDBUF(bgbi006)
         IF NOT cl_null(g_construct_display)THEN
            LET g_groupbyfield[2].l_used = 'Y'
         END IF
         
         LET g_construct_display = GET_FLDBUF(bgbi007)
         IF NOT cl_null(g_construct_display)THEN
            LET g_groupbyfield[3].l_used = 'Y'
         END IF
         
         LET g_construct_display = GET_FLDBUF(bgbi008)
         IF NOT cl_null(g_construct_display)THEN
            LET g_groupbyfield[4].l_used = 'Y'
         END IF  

         LET g_construct_display = GET_FLDBUF(bgbi009)
         IF NOT cl_null(g_construct_display)THEN
            LET g_groupbyfield[5].l_used = 'Y'
         END IF      
         
         LET g_construct_display = GET_FLDBUF(bgbi038)
         IF NOT cl_null(g_construct_display)THEN
            LET g_groupbyfield[6].l_used = 'Y'
         END IF 

         LET g_construct_display = GET_FLDBUF(bgbi010)
         IF NOT cl_null(g_construct_display)THEN
            LET g_groupbyfield[7].l_used = 'Y'
         END IF      
         
         LET g_construct_display = GET_FLDBUF(bgbi011)
         IF NOT cl_null(g_construct_display)THEN
            LET g_groupbyfield[8].l_used = 'Y'
         END IF      
         
         LET g_construct_display = GET_FLDBUF(bgbi012)
         IF NOT cl_null(g_construct_display)THEN
            LET g_groupbyfield[9].l_used = 'Y'
         END IF      
         
         LET g_construct_display = GET_FLDBUF(bgbi013)
         IF NOT cl_null(g_construct_display)THEN
           LET g_groupbyfield[10].l_used = 'Y'
         END IF      
         
         LET g_construct_display = GET_FLDBUF(bgbi039)
         IF NOT cl_null(g_construct_display)THEN
            LET g_groupbyfield[11].l_used = 'Y'
         END IF      
         
         LET g_construct_display = GET_FLDBUF(bgbi040)
         IF NOT cl_null(g_construct_display)THEN
            LET g_groupbyfield[12].l_used = 'Y'
         END IF               
         
         LET g_construct_display = GET_FLDBUF(bgbi041)
         IF NOT cl_null(g_construct_display)THEN
            LET g_groupbyfield[13].l_used = 'Y'
         END IF      
         
         LET g_construct_display = GET_FLDBUF(bgbi014)
         IF NOT cl_null(g_construct_display)THEN
            LET g_groupbyfield[14].l_used = 'Y'
         END IF      
         
         LET g_construct_display = GET_FLDBUF(bgbi015)
         IF NOT cl_null(g_construct_display)THEN
            LET g_groupbyfield[15].l_used = 'Y'
         END IF      
         
         LET g_construct_display = GET_FLDBUF(bgbi016)
         IF NOT cl_null(g_construct_display)THEN
            LET g_groupbyfield[16].l_used = 'Y'
         END IF      
         
         LET g_construct_display = GET_FLDBUF(bgbi028)
         IF NOT cl_null(g_construct_display)THEN
            LET g_groupbyfield[17].l_used = 'Y'
         END IF      
         
         LET g_construct_display = GET_FLDBUF(bgbi029)
         IF NOT cl_null(g_construct_display)THEN
            LET g_groupbyfield[18].l_used = 'Y'
         END IF      
         
         LET g_construct_display = GET_FLDBUF(bgbi030)
         IF NOT cl_null(g_construct_display)THEN
            LET g_groupbyfield[19].l_used = 'Y'
         END IF      
         
         LET g_construct_display = GET_FLDBUF(bgbi031)
         IF NOT cl_null(g_construct_display)THEN
            LET g_groupbyfield[20].l_used = 'Y'
         END IF      
         
         LET g_construct_display = GET_FLDBUF(bgbi032)
         IF NOT cl_null(g_construct_display)THEN
            LET g_groupbyfield[21].l_used = 'Y'
         END IF      
         
         LET g_construct_display = GET_FLDBUF(bgbi033)
         IF NOT cl_null(g_construct_display)THEN
            LET g_groupbyfield[22].l_used = 'Y'
         END IF      
         
         LET g_construct_display = GET_FLDBUF(bgbi034)
         IF NOT cl_null(g_construct_display)THEN
            LET g_groupbyfield[23].l_used = 'Y'
         END IF      
         
         LET g_construct_display = GET_FLDBUF(bgbi035)
         IF NOT cl_null(g_construct_display)THEN
            LET g_groupbyfield[24].l_used = 'Y'
         END IF      
         
         LET g_construct_display = GET_FLDBUF(bgbi036)
         IF NOT cl_null(g_construct_display)THEN
            LET g_groupbyfield[25].l_used = 'Y'
         END IF      
         
         LET g_construct_display = GET_FLDBUF(bgbi037)
         IF NOT cl_null(g_construct_display)THEN
            LET g_groupbyfield[26].l_used = 'Y'
         END IF      
         #擷取銀幕變數確定USER打了哪些條件-----e
      ON ACTION accept
         ACCEPT DIALOG
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      ON ACTION exit
         LET INT_FLAG = 1
         EXIT DIALOG
   END DIALOG
   
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      CALL g_bgbi_d.clear()
   ELSE
      CALL abgt025_02_upd_source()
      IF g_do_lock = 'Y' THEN
         CLOSE lock_bgbhc1
      END IF
#      LET g_wc = l_wc CLIPPED," AND bgbh001 = '",g_bgbh.bgbh001,"' AND bgbh002 = '",g_bgbh.bgbh002,"' ",
#                              " AND bgbh003 = '",g_bgbh.bgbh003,"' AND bgbh004 = '",g_bgbh.bgbh004,"' ",
#                              " AND bgbh006 = '",g_bgbh.bgbh006,"' "
      LET g_wc = l_wc
                              
      CALL abgt025_02_ins_tmp(g_wc)
      OPEN lock_bgbhc1
      LET g_do_lock = 'Y'
      CALL abgt025_02_b_fill()
   END IF
   
   
END FUNCTION

################################################################################
# Descriptions...: 把資料倒入臨時表
# Memo...........:
# Usage..........:
# Date & Author..: 150803 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION abgt025_02_ins_tmp(p_wc)
   DEFINE p_wc   STRING
   DEFINE l_sql  STRING
   DEFINE l_tmp  RECORD
      bgbiseq   LIKE bgbi_t.bgbiseq,    #項次
      bgbi002   LIKE bgbi_t.bgbi002,    #預算編號
      bgbi003   LIKE bgbi_t.bgbi003,    #預算版本
      bgbi004   LIKE bgbi_t.bgbi004,    #預算組織
      bgbi005   LIKE bgbi_t.bgbi005,    #預算項目
      bgbi006   LIKE bgbi_t.bgbi006,    #預算期別
      bgbi007   LIKE bgbi_t.bgbi007,    #部門
      bgbi008   LIKE bgbi_t.bgbi008,    #成本利潤中心
      bgbi009   LIKE bgbi_t.bgbi009,    #區域
      bgbi010   LIKE bgbi_t.bgbi010,    #交易客商
      bgbi011   LIKE bgbi_t.bgbi011,    #收款客商
      bgbi012   LIKE bgbi_t.bgbi012,    #客群
      bgbi013   LIKE bgbi_t.bgbi013,    #產品類別
      bgbi014   LIKE bgbi_t.bgbi014,    #人員
      bgbi015   LIKE bgbi_t.bgbi015,    #專案編號
      bgbi016   LIKE bgbi_t.bgbi016,    #WBS
      bgbi039   LIKE bgbi_t.bgbi039,    #經營方式
      bgbi040   LIKE bgbi_t.bgbi040,    #渠道
      bgbi041   LIKE bgbi_t.bgbi041,    #品牌
      bgbi028   LIKE bgbi_t.bgbi028,    #自由核算項一
      bgbi029   LIKE bgbi_t.bgbi029,    #自由核算項二
      bgbi030   LIKE bgbi_t.bgbi030,    #自由核算項三
      bgbi031   LIKE bgbi_t.bgbi031,    #自由核算項四
      bgbi032   LIKE bgbi_t.bgbi032,    #自由核算項五
      bgbi033   LIKE bgbi_t.bgbi033,    #自由核算項六
      bgbi034   LIKE bgbi_t.bgbi034,    #自由核算項七
      bgbi035   LIKE bgbi_t.bgbi035,    #自由核算項八
      bgbi036   LIKE bgbi_t.bgbi036,    #自由核算項九
      bgbi037   LIKE bgbi_t.bgbi037,    #自由核算項十
      bgbi038   LIKE bgbi_t.bgbi038,    #現金變動碼
      bgbi023   LIKE bgbi_t.bgbi023,    #基準金額
      bgbi024   LIKE bgbi_t.bgbi024,    #本層調整
      bgbi025   LIKE bgbi_t.bgbi025,    #上層調整
      bgbi026   LIKE bgbi_t.bgbi026,    #下層調整
      bgbi027   LIKE bgbi_t.bgbi027,    #核准金額     
      accountc  LIKE type_t.num20_6,    #變動金額
      upd       LIKE type_t.chr1,        #已回寫
      bgbi044   LIKE bgbi_t.bgbi044,     #異動類型
      bgbi017   LIKE bgbi_t.bgbi017,    #來源原幣
      site025   LIKE ooef_t.ooef001,    #預算審核組織
      seq025    LIKE type_t.num10       #預算審核項次
                 END RECORD
   DEFINE l_bgbh003   LIKE bgbh_t.bgbh003
   DEFINE l_bgbh006   LIKE bgbh_t.bgbh006
   DEFINE l_tok       base.Stringtokenizer
   DEFINE l_count     LIKE type_t.num10
   DEFINE l_dnstep_str STRING
   WHENEVER ERROR CONTINUE
 
   ##########
 
     
   #1.先取得組織範圍   自己p_bgbh003    自己的下層l_dnstep_str
   LET l_dnstep_str = NULL
   CALL s_abgt025_get_dnstep_site(g_bgbh.bgbh001,'','',g_bgbh.bgbh003)
      RETURNING l_dnstep_str
      
   DELETE FROM s_abgt025_tmp1
   LET l_sql = "SELECT bgbiseq,      bgbi002,      bgbi003,      bgbi004,      bgbi005, ",
               "       bgbi006,      bgbi007,      bgbi008,      bgbi009,      bgbi010, ", 
               "       bgbi011,      bgbi012,      bgbi013,      bgbi014,      bgbi015, ",
               "       bgbi016,      bgbi039,      bgbi040,      bgbi041,      bgbi028, ",
               "       bgbi029,      bgbi030,      bgbi031,      bgbi032,      bgbi033, ",
               "       bgbi034,      bgbi035,      bgbi036,      bgbi037,      bgbi038, ",
               "       bgbi023,      bgbi024,      bgbi025,      bgbi026,      bgbi027,  ",
               "       0,            'N',          bgbi044,      bgbi017,      '', ",
               "       '' ",
               "  FROM bgbi_t ,bgbh_t    ",  
               " WHERE bgbient = bgbhent ",
               "   AND bgbi002 = bgbh001 ",
               "   AND bgbi003 = bgbh002 ",
               "   AND bgbi004 = bgbh003 ",
               "   AND bgbi005 = bgbh004 ",
               "   AND bgbi044 = bgbh006 ",
               "   AND bgbient = ", g_enterprise," ",
               "   AND bgbhstus = 'Y' ",
               "   AND bgbh001 = ? ",
               "   AND bgbh002 = ? ",
               "   AND bgbh003 = ? ",
               "   AND bgbh004 = ? ",
               "   AND bgbh006 = ? ",
               "   AND ",p_wc CLIPPED
   PREPARE sel_bgbip1 FROM l_sql
   DECLARE sel_bgbic1 CURSOR FOR sel_bgbip1
               
   #2.自己的abgt020資料倒入
   LET l_bgbh003 = g_bgbh.bgbh003
   LET l_bgbh006 = '1'
   FOREACH sel_bgbic1 USING g_bgbh.bgbh001,g_bgbh.bgbh002,l_bgbh003,g_bgbh.bgbh004,l_bgbh006
      INTO l_tmp.*
      IF SQLCA.SQLCODE THEN 
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'FOREACH:sel_bgbic1:1'
         CALL cl_err()
         EXIT FOREACH
      END IF
      #判斷26個維度  有空給空白 方便GROUP BY
      IF cl_null(l_tmp.bgbi006)THEN LET l_tmp.bgbi006 = 0 END IF
      IF cl_null(l_tmp.bgbi007)THEN LET l_tmp.bgbi007 = ' ' END IF
      IF cl_null(l_tmp.bgbi008)THEN LET l_tmp.bgbi008 = ' ' END IF
      IF cl_null(l_tmp.bgbi009)THEN LET l_tmp.bgbi009 = ' ' END IF
      IF cl_null(l_tmp.bgbi010)THEN LET l_tmp.bgbi010 = ' ' END IF
      IF cl_null(l_tmp.bgbi011)THEN LET l_tmp.bgbi011 = ' ' END IF
      IF cl_null(l_tmp.bgbi012)THEN LET l_tmp.bgbi012 = ' ' END IF
      IF cl_null(l_tmp.bgbi013)THEN LET l_tmp.bgbi013 = ' ' END IF
      IF cl_null(l_tmp.bgbi014)THEN LET l_tmp.bgbi014 = ' ' END IF
      IF cl_null(l_tmp.bgbi015)THEN LET l_tmp.bgbi015 = ' ' END IF
      IF cl_null(l_tmp.bgbi016)THEN LET l_tmp.bgbi016 = ' ' END IF
      IF cl_null(l_tmp.bgbi039)THEN LET l_tmp.bgbi039 = ' ' END IF
      IF cl_null(l_tmp.bgbi040)THEN LET l_tmp.bgbi040 = ' ' END IF
      IF cl_null(l_tmp.bgbi041)THEN LET l_tmp.bgbi041 = ' ' END IF         
      IF cl_null(l_tmp.bgbi028)THEN LET l_tmp.bgbi028 = ' ' END IF
      IF cl_null(l_tmp.bgbi029)THEN LET l_tmp.bgbi029 = ' ' END IF
      IF cl_null(l_tmp.bgbi030)THEN LET l_tmp.bgbi030 = ' ' END IF
      IF cl_null(l_tmp.bgbi031)THEN LET l_tmp.bgbi031 = ' ' END IF
      IF cl_null(l_tmp.bgbi032)THEN LET l_tmp.bgbi032 = ' ' END IF
      IF cl_null(l_tmp.bgbi033)THEN LET l_tmp.bgbi033 = ' ' END IF
      IF cl_null(l_tmp.bgbi034)THEN LET l_tmp.bgbi034 = ' ' END IF
      IF cl_null(l_tmp.bgbi035)THEN LET l_tmp.bgbi035 = ' ' END IF
      IF cl_null(l_tmp.bgbi036)THEN LET l_tmp.bgbi036 = ' ' END IF
      IF cl_null(l_tmp.bgbi037)THEN LET l_tmp.bgbi037 = ' ' END IF
      IF cl_null(l_tmp.bgbi038)THEN LET l_tmp.bgbi038 = ' ' END IF
      
      #取得對應的單身項次資訊
      LET l_tmp.site025 = g_bgbh.bgbh003
      EXECUTE sel_bgbiseqp1 
        USING g_bgbh.bgbh001,g_bgbh.bgbh002,g_bgbh.bgbh003,g_bgbh.bgbh004,g_bgbh.bgbh006,
              l_tmp.bgbi006,l_tmp.bgbi007,l_tmp.bgbi008,l_tmp.bgbi009,l_tmp.bgbi010,
              l_tmp.bgbi011,l_tmp.bgbi012,l_tmp.bgbi013,l_tmp.bgbi014,l_tmp.bgbi015,
              l_tmp.bgbi016,l_tmp.bgbi039,l_tmp.bgbi040,l_tmp.bgbi041,l_tmp.bgbi028,
              l_tmp.bgbi029,l_tmp.bgbi030,l_tmp.bgbi031,l_tmp.bgbi032,l_tmp.bgbi033,
              l_tmp.bgbi034,l_tmp.bgbi035,l_tmp.bgbi036,l_tmp.bgbi037,l_tmp.bgbi038,
              l_tmp.bgbi017
         INTO l_tmp.seq025
      #INSERT INTO s_abgt025_tmp1 VALUES(l_tmp.*)   #161108-00017#5   mark
      #161108-00017#5   add---s
      INSERT INTO s_abgt025_tmp1 (bgbiseq,bgbi002,bgbi003,bgbi004,bgbi005, 
                                  bgbi006,bgbi007,bgbi008,bgbi009,bgbi010,
                                  bgbi011,bgbi012,bgbi013,bgbi014,bgbi015, 
                                  bgbi016,bgbi039,bgbi040,bgbi041,bgbi028, 
                                  bgbi029,bgbi030,bgbi031,bgbi032,bgbi033, 
                                  bgbi034,bgbi035,bgbi036,bgbi037,bgbi038,
                                  bgbi023,bgbi024,bgbi025,bgbi026,bgbi027, 
                                  accountc,upd,bgbi044,bgbi017,site025, 
                                  seq025)
                          VALUES (l_tmp.bgbiseq,l_tmp.bgbi002,l_tmp.bgbi003,l_tmp.bgbi004,l_tmp.bgbi005, 
                                  l_tmp.bgbi006,l_tmp.bgbi007,l_tmp.bgbi008,l_tmp.bgbi009,l_tmp.bgbi010,
                                  l_tmp.bgbi011,l_tmp.bgbi012,l_tmp.bgbi013,l_tmp.bgbi014,l_tmp.bgbi015, 
                                  l_tmp.bgbi016,l_tmp.bgbi039,l_tmp.bgbi040,l_tmp.bgbi041,l_tmp.bgbi028, 
                                  l_tmp.bgbi029,l_tmp.bgbi030,l_tmp.bgbi031,l_tmp.bgbi032,l_tmp.bgbi033, 
                                  l_tmp.bgbi034,l_tmp.bgbi035,l_tmp.bgbi036,l_tmp.bgbi037,l_tmp.bgbi038,
                                  l_tmp.bgbi023,l_tmp.bgbi024,l_tmp.bgbi025,l_tmp.bgbi026,l_tmp.bgbi027, 
                                  l_tmp.accountc,l_tmp.upd,l_tmp.bgbi044,l_tmp.bgbi017,l_tmp.site025, 
                                  l_tmp.seq025)
      #161108-00017#5   add---e
   END FOREACH
   
   #3 下層組織的abgt020或abgt025資料倒入
   LET l_tok = base.StringTokenizer.create(l_dnstep_str,",")
   WHILE l_tok.hasMoreTokens()
      LET l_bgbh003 = l_tok.nextToken()
      IF l_bgbh003 = g_bgbh.bgbh003 THEN
         CONTINUE WHILE
      END IF
      #判斷本層匯總資料是否存在 存在就優先抓
      LET l_count = NULL
      SELECT COUNT(*) INTO l_count 
        FROM bgbh_t
       WHERE bgbhent = g_enterprise
         AND bgbh001 = g_bgbh.bgbh001
         AND bgbh002 = g_bgbh.bgbh002
         AND bgbh003 = l_bgbh003
         AND bgbh004 = g_bgbh.bgbh004
         AND bgbh006 = '2'
         AND bgbhstus = 'Y'
      IF cl_null(l_count)THEN LET l_count = 0 END IF
      
      IF l_count > 0 THEN
         LET l_bgbh006 = '2'
      ELSE
         LET l_bgbh006 = '1'
      END IF
      
      FOREACH sel_bgbic1 USING g_bgbh.bgbh001,g_bgbh.bgbh002,l_bgbh003,g_bgbh.bgbh004,l_bgbh006
         INTO l_tmp.*
         IF SQLCA.SQLCODE THEN 
            INITIALIZE g_errparam.* TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = 'FOREACH:sel_bgbic1:2'
            CALL cl_err()
            EXIT FOREACH
         END IF
         #判斷26個維度  有空給空白 方便GROUP BY
         IF cl_null(l_tmp.bgbi006)THEN LET l_tmp.bgbi006 = 0 END IF
         IF cl_null(l_tmp.bgbi007)THEN LET l_tmp.bgbi007 = ' ' END IF
         IF cl_null(l_tmp.bgbi008)THEN LET l_tmp.bgbi008 = ' ' END IF
         IF cl_null(l_tmp.bgbi009)THEN LET l_tmp.bgbi009 = ' ' END IF
         IF cl_null(l_tmp.bgbi010)THEN LET l_tmp.bgbi010 = ' ' END IF
         IF cl_null(l_tmp.bgbi011)THEN LET l_tmp.bgbi011 = ' ' END IF
         IF cl_null(l_tmp.bgbi012)THEN LET l_tmp.bgbi012 = ' ' END IF
         IF cl_null(l_tmp.bgbi013)THEN LET l_tmp.bgbi013 = ' ' END IF
         IF cl_null(l_tmp.bgbi014)THEN LET l_tmp.bgbi014 = ' ' END IF
         IF cl_null(l_tmp.bgbi015)THEN LET l_tmp.bgbi015 = ' ' END IF
         IF cl_null(l_tmp.bgbi016)THEN LET l_tmp.bgbi016 = ' ' END IF
         IF cl_null(l_tmp.bgbi039)THEN LET l_tmp.bgbi039 = ' ' END IF
         IF cl_null(l_tmp.bgbi040)THEN LET l_tmp.bgbi040 = ' ' END IF
         IF cl_null(l_tmp.bgbi041)THEN LET l_tmp.bgbi041 = ' ' END IF         
         IF cl_null(l_tmp.bgbi028)THEN LET l_tmp.bgbi028 = ' ' END IF
         IF cl_null(l_tmp.bgbi029)THEN LET l_tmp.bgbi029 = ' ' END IF
         IF cl_null(l_tmp.bgbi030)THEN LET l_tmp.bgbi030 = ' ' END IF
         IF cl_null(l_tmp.bgbi031)THEN LET l_tmp.bgbi031 = ' ' END IF
         IF cl_null(l_tmp.bgbi032)THEN LET l_tmp.bgbi032 = ' ' END IF
         IF cl_null(l_tmp.bgbi033)THEN LET l_tmp.bgbi033 = ' ' END IF
         IF cl_null(l_tmp.bgbi034)THEN LET l_tmp.bgbi034 = ' ' END IF
         IF cl_null(l_tmp.bgbi035)THEN LET l_tmp.bgbi035 = ' ' END IF
         IF cl_null(l_tmp.bgbi036)THEN LET l_tmp.bgbi036 = ' ' END IF
         IF cl_null(l_tmp.bgbi037)THEN LET l_tmp.bgbi037 = ' ' END IF
         IF cl_null(l_tmp.bgbi038)THEN LET l_tmp.bgbi038 = ' ' END IF

         #取得對應的單身項次資訊
         LET l_tmp.site025 = g_bgbh.bgbh003
         EXECUTE sel_bgbiseqp1 
         USING g_bgbh.bgbh001,g_bgbh.bgbh002,g_bgbh.bgbh003,g_bgbh.bgbh004,g_bgbh.bgbh006,
               l_tmp.bgbi006,l_tmp.bgbi007,l_tmp.bgbi008,l_tmp.bgbi009,l_tmp.bgbi010,
               l_tmp.bgbi011,l_tmp.bgbi012,l_tmp.bgbi013,l_tmp.bgbi014,l_tmp.bgbi015,
               l_tmp.bgbi016,l_tmp.bgbi039,l_tmp.bgbi040,l_tmp.bgbi041,l_tmp.bgbi028,
               l_tmp.bgbi029,l_tmp.bgbi030,l_tmp.bgbi031,l_tmp.bgbi032,l_tmp.bgbi033,
               l_tmp.bgbi034,l_tmp.bgbi035,l_tmp.bgbi036,l_tmp.bgbi037,l_tmp.bgbi038,
               l_tmp.bgbi017
          INTO l_tmp.seq025
         #INSERT INTO s_abgt025_tmp1 VALUES(l_tmp.*)   #161108-00017#5   mark
         #161108-00017#5   add---s
         INSERT INTO s_abgt025_tmp1 (bgbiseq,bgbi002,bgbi003,bgbi004,bgbi005, 
                                     bgbi006,bgbi007,bgbi008,bgbi009,bgbi010,
                                     bgbi011,bgbi012,bgbi013,bgbi014,bgbi015, 
                                     bgbi016,bgbi039,bgbi040,bgbi041,bgbi028, 
                                     bgbi029,bgbi030,bgbi031,bgbi032,bgbi033, 
                                     bgbi034,bgbi035,bgbi036,bgbi037,bgbi038,
                                     bgbi023,bgbi024,bgbi025,bgbi026,bgbi027, 
                                     accountc,upd,bgbi044,bgbi017,site025, 
                                     seq025)
                             VALUES (l_tmp.bgbiseq,l_tmp.bgbi002,l_tmp.bgbi003,l_tmp.bgbi004,l_tmp.bgbi005, 
                                     l_tmp.bgbi006,l_tmp.bgbi007,l_tmp.bgbi008,l_tmp.bgbi009,l_tmp.bgbi010,
                                     l_tmp.bgbi011,l_tmp.bgbi012,l_tmp.bgbi013,l_tmp.bgbi014,l_tmp.bgbi015, 
                                     l_tmp.bgbi016,l_tmp.bgbi039,l_tmp.bgbi040,l_tmp.bgbi041,l_tmp.bgbi028, 
                                     l_tmp.bgbi029,l_tmp.bgbi030,l_tmp.bgbi031,l_tmp.bgbi032,l_tmp.bgbi033, 
                                     l_tmp.bgbi034,l_tmp.bgbi035,l_tmp.bgbi036,l_tmp.bgbi037,l_tmp.bgbi038,
                                     l_tmp.bgbi023,l_tmp.bgbi024,l_tmp.bgbi025,l_tmp.bgbi026,l_tmp.bgbi027, 
                                     l_tmp.accountc,l_tmp.upd,l_tmp.bgbi044,l_tmp.bgbi017,l_tmp.site025, 
                                     l_tmp.seq025)
         #161108-00017#5   add---e
      END FOREACH
   END WHILE


END FUNCTION

################################################################################
# Descriptions...: ins符合條件的下層組織資料到臨時表
# Memo...........:
# Usage..........: 
# Date & Author..: 150810 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt025_02_ins_tmp2(p_bgbi002,p_bgbi003,p_bgbi004,p_bgbi005,p_bgbi044,p_bgbiseq)
   DEFINE p_bgbi002 LIKE bgbi_t.bgbi002
   DEFINE p_bgbi003 LIKE bgbi_t.bgbi003
   DEFINE p_bgbi004 LIKE bgbi_t.bgbi004
   DEFINE p_bgbi005 LIKE bgbi_t.bgbi005
   DEFINE p_bgbi044 LIKE bgbi_t.bgbi044
   DEFINE p_bgbiseq LIKE bgbi_t.bgbiseq
   DEFINE l_sql  STRING
  #DEFINE l_bgbi      RECORD LIKE bgbi_t.* #161104-00024#8  mark
   #161104-00024#8   --s add
   DEFINE l_bgbi RECORD  #年度預算單身檔
       bgbient LIKE bgbi_t.bgbient, #企業編號
       bgbiseq LIKE bgbi_t.bgbiseq, #項次
       bgbi001 LIKE bgbi_t.bgbi001, #摘要
       bgbi002 LIKE bgbi_t.bgbi002, #預算編號
       bgbi003 LIKE bgbi_t.bgbi003, #預算版本
       bgbi004 LIKE bgbi_t.bgbi004, #預算組織
       bgbi005 LIKE bgbi_t.bgbi005, #預算細項
       bgbi006 LIKE bgbi_t.bgbi006, #預算期別
       bgbi007 LIKE bgbi_t.bgbi007, #部門
       bgbi008 LIKE bgbi_t.bgbi008, #成本利潤中心
       bgbi009 LIKE bgbi_t.bgbi009, #區域
       bgbi010 LIKE bgbi_t.bgbi010, #交易客商
       bgbi011 LIKE bgbi_t.bgbi011, #收款客商
       bgbi012 LIKE bgbi_t.bgbi012, #客群
       bgbi013 LIKE bgbi_t.bgbi013, #產品類別
       bgbi014 LIKE bgbi_t.bgbi014, #人員
       bgbi015 LIKE bgbi_t.bgbi015, #專案編號
       bgbi016 LIKE bgbi_t.bgbi016, #WBS
       bgbi017 LIKE bgbi_t.bgbi017, #預算幣別
       bgbi018 LIKE bgbi_t.bgbi018, #含稅單價
       bgbi019 LIKE bgbi_t.bgbi019, #不含稅單價
       bgbi020 LIKE bgbi_t.bgbi020, #稅別
       bgbi021 LIKE bgbi_t.bgbi021, #交易數量
       bgbi022 LIKE bgbi_t.bgbi022, #交易金額
       bgbi023 LIKE bgbi_t.bgbi023, #基準金額
       bgbi024 LIKE bgbi_t.bgbi024, #本層調整
       bgbi025 LIKE bgbi_t.bgbi025, #上層調整
       bgbi026 LIKE bgbi_t.bgbi026, #下層調整
       bgbi027 LIKE bgbi_t.bgbi027, #核准金額
       bgbi028 LIKE bgbi_t.bgbi028, #自由核算項一
       bgbi029 LIKE bgbi_t.bgbi029, #自由核算項二
       bgbi030 LIKE bgbi_t.bgbi030, #自由核算項三
       bgbi031 LIKE bgbi_t.bgbi031, #自由核算項四
       bgbi032 LIKE bgbi_t.bgbi032, #自由核算項五
       bgbi033 LIKE bgbi_t.bgbi033, #自由核算項六
       bgbi034 LIKE bgbi_t.bgbi034, #自由核算項七
       bgbi035 LIKE bgbi_t.bgbi035, #自由核算項八
       bgbi036 LIKE bgbi_t.bgbi036, #自由核算項九
       bgbi037 LIKE bgbi_t.bgbi037, #自由核算項十
       bgbi038 LIKE bgbi_t.bgbi038, #現金變動碼
       bgbi039 LIKE bgbi_t.bgbi039, #經營方式
       bgbi040 LIKE bgbi_t.bgbi040, #通路
       bgbi041 LIKE bgbi_t.bgbi041, #品牌
       bgbi042 LIKE bgbi_t.bgbi042, #稅率
       bgbi043 LIKE bgbi_t.bgbi043, #匯率
       bgbiud001 LIKE bgbi_t.bgbiud001, #自定義欄位(文字)001
       bgbiud002 LIKE bgbi_t.bgbiud002, #自定義欄位(文字)002
       bgbiud003 LIKE bgbi_t.bgbiud003, #自定義欄位(文字)003
       bgbiud004 LIKE bgbi_t.bgbiud004, #自定義欄位(文字)004
       bgbiud005 LIKE bgbi_t.bgbiud005, #自定義欄位(文字)005
       bgbiud006 LIKE bgbi_t.bgbiud006, #自定義欄位(文字)006
       bgbiud007 LIKE bgbi_t.bgbiud007, #自定義欄位(文字)007
       bgbiud008 LIKE bgbi_t.bgbiud008, #自定義欄位(文字)008
       bgbiud009 LIKE bgbi_t.bgbiud009, #自定義欄位(文字)009
       bgbiud010 LIKE bgbi_t.bgbiud010, #自定義欄位(文字)010
       bgbiud011 LIKE bgbi_t.bgbiud011, #自定義欄位(數字)011
       bgbiud012 LIKE bgbi_t.bgbiud012, #自定義欄位(數字)012
       bgbiud013 LIKE bgbi_t.bgbiud013, #自定義欄位(數字)013
       bgbiud014 LIKE bgbi_t.bgbiud014, #自定義欄位(數字)014
       bgbiud015 LIKE bgbi_t.bgbiud015, #自定義欄位(數字)015
       bgbiud016 LIKE bgbi_t.bgbiud016, #自定義欄位(數字)016
       bgbiud017 LIKE bgbi_t.bgbiud017, #自定義欄位(數字)017
       bgbiud018 LIKE bgbi_t.bgbiud018, #自定義欄位(數字)018
       bgbiud019 LIKE bgbi_t.bgbiud019, #自定義欄位(數字)019
       bgbiud020 LIKE bgbi_t.bgbiud020, #自定義欄位(數字)020
       bgbiud021 LIKE bgbi_t.bgbiud021, #自定義欄位(日期時間)021
       bgbiud022 LIKE bgbi_t.bgbiud022, #自定義欄位(日期時間)022
       bgbiud023 LIKE bgbi_t.bgbiud023, #自定義欄位(日期時間)023
       bgbiud024 LIKE bgbi_t.bgbiud024, #自定義欄位(日期時間)024
       bgbiud025 LIKE bgbi_t.bgbiud025, #自定義欄位(日期時間)025
       bgbiud026 LIKE bgbi_t.bgbiud026, #自定義欄位(日期時間)026
       bgbiud027 LIKE bgbi_t.bgbiud027, #自定義欄位(日期時間)027
       bgbiud028 LIKE bgbi_t.bgbiud028, #自定義欄位(日期時間)028
       bgbiud029 LIKE bgbi_t.bgbiud029, #自定義欄位(日期時間)029
       bgbiud030 LIKE bgbi_t.bgbiud030, #自定義欄位(日期時間)030
       bgbi044 LIKE bgbi_t.bgbi044, #資料來源
       bgbi045 LIKE bgbi_t.bgbi045, #管理組織
       bgbi046 LIKE bgbi_t.bgbi046, #預算樣表
       bgbiownid LIKE bgbi_t.bgbiownid, #資料所有者
       bgbiowndp LIKE bgbi_t.bgbiowndp, #資料所屬部門
       bgbicrtid LIKE bgbi_t.bgbicrtid, #資料建立者
       bgbicrtdp LIKE bgbi_t.bgbicrtdp, #資料建立部門
       bgbicrtdt LIKE bgbi_t.bgbicrtdt, #資料創建日
       bgbimodid LIKE bgbi_t.bgbimodid, #資料修改者
       bgbimoddt LIKE bgbi_t.bgbimoddt, #最近修改日
       bgbicnfid LIKE bgbi_t.bgbicnfid, #資料確認者
       bgbicnfdt LIKE bgbi_t.bgbicnfdt, #資料確認日
       bgbistus LIKE bgbi_t.bgbistus, #狀態碼
       bgbi047 LIKE bgbi_t.bgbi047  #上層組織
   END RECORD
   #161104-00024#8  --e add
   DEFINE l_tmp  RECORD
      bgbiseq   LIKE bgbi_t.bgbiseq,    #項次
      bgbi002   LIKE bgbi_t.bgbi002,    #預算編號
      bgbi003   LIKE bgbi_t.bgbi003,    #預算版本
      bgbi004   LIKE bgbi_t.bgbi004,    #預算組織
      bgbi005   LIKE bgbi_t.bgbi005,    #預算項目
      bgbi006   LIKE bgbi_t.bgbi006,    #預算期別
      bgbi007   LIKE bgbi_t.bgbi007,    #部門
      bgbi008   LIKE bgbi_t.bgbi008,    #成本利潤中心
      bgbi009   LIKE bgbi_t.bgbi009,    #區域
      bgbi010   LIKE bgbi_t.bgbi010,    #交易客商
      bgbi011   LIKE bgbi_t.bgbi011,    #收款客商
      bgbi012   LIKE bgbi_t.bgbi012,    #客群
      bgbi013   LIKE bgbi_t.bgbi013,    #產品類別
      bgbi014   LIKE bgbi_t.bgbi014,    #人員
      bgbi015   LIKE bgbi_t.bgbi015,    #專案編號
      bgbi016   LIKE bgbi_t.bgbi016,    #WBS
      bgbi039   LIKE bgbi_t.bgbi039,    #經營方式
      bgbi040   LIKE bgbi_t.bgbi040,    #渠道
      bgbi041   LIKE bgbi_t.bgbi041,    #品牌
      bgbi028   LIKE bgbi_t.bgbi028,    #自由核算項一
      bgbi029   LIKE bgbi_t.bgbi029,    #自由核算項二
      bgbi030   LIKE bgbi_t.bgbi030,    #自由核算項三
      bgbi031   LIKE bgbi_t.bgbi031,    #自由核算項四
      bgbi032   LIKE bgbi_t.bgbi032,    #自由核算項五
      bgbi033   LIKE bgbi_t.bgbi033,    #自由核算項六
      bgbi034   LIKE bgbi_t.bgbi034,    #自由核算項七
      bgbi035   LIKE bgbi_t.bgbi035,    #自由核算項八
      bgbi036   LIKE bgbi_t.bgbi036,    #自由核算項九
      bgbi037   LIKE bgbi_t.bgbi037,    #自由核算項十
      bgbi038   LIKE bgbi_t.bgbi038,    #現金變動碼
      bgbi023   LIKE bgbi_t.bgbi023,    #基準金額
      bgbi024   LIKE bgbi_t.bgbi024,    #本層調整
      bgbi025   LIKE bgbi_t.bgbi025,    #上層調整
      bgbi026   LIKE bgbi_t.bgbi026,    #下層調整
      bgbi027   LIKE bgbi_t.bgbi027,    #核准金額     
      accountc  LIKE type_t.num20_6,    #變動金額
      upd       LIKE type_t.chr1,        #已回寫
      bgbi044   LIKE bgbi_t.bgbi044,     #異動類型
      bgbi017   LIKE bgbi_t.bgbi017,    #來源原幣
      site025   LIKE ooef_t.ooef001,    #預算審核組織
      seq025    LIKE type_t.num10       #預算審核項次
                 END RECORD
   DEFINE l_bgbh003   LIKE bgbh_t.bgbh003
   DEFINE l_bgbh006   LIKE bgbh_t.bgbh006
   DEFINE l_tok       base.Stringtokenizer
   DEFINE l_count     LIKE type_t.num10
   DEFINE l_dnstep_str STRING
   WHENEVER ERROR CONTINUE
     
   #符合KEY且26維度也符合
   LET l_sql = "SELECT bgbiseq,      bgbi002,      bgbi003,      bgbi004,      bgbi005, ",
               "       bgbi006,      bgbi007,      bgbi008,      bgbi009,      bgbi010, ", 
               "       bgbi011,      bgbi012,      bgbi013,      bgbi014,      bgbi015, ",
               "       bgbi016,      bgbi039,      bgbi040,      bgbi041,      bgbi028, ",
               "       bgbi029,      bgbi030,      bgbi031,      bgbi032,      bgbi033, ",
               "       bgbi034,      bgbi035,      bgbi036,      bgbi037,      bgbi038, ",
               "       bgbi023,      bgbi024,      bgbi025,      bgbi026,      bgbi027,  ",
               "       0,            'N',          bgbi044,      bgbi017,      '', ",
               "       '' ",
               "  FROM bgbi_t ,bgbh_t    ",  
               " WHERE bgbient = bgbhent ",
               "   AND bgbi002 = bgbh001 ",
               "   AND bgbi003 = bgbh002 ",
               "   AND bgbi004 = bgbh003 ",
               "   AND bgbi005 = bgbh004 ",
               "   AND bgbi044 = bgbh006 ",
               "   AND bgbient = ", g_enterprise," ",
               "   AND bgbh001 = ? ",               
               "   AND bgbh002 = ? ",
               "   AND bgbh003 = ? ",
               "   AND bgbh004 = ? ",
               "   AND bgbh006 = ? ",
               "   AND (COALESCE(bgbi006,0) = COALESCE( ? ,0))",
               "   AND (COALESCE(bgbi007,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi008,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi009,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi010,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi011,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi012,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi013,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi014,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi015,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi016,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi039,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi040,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi041,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi028,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi029,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi030,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi031,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi032,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi033,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi034,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi035,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi036,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi037,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi038,' ') = COALESCE( ? ,' '))",
               "   AND (COALESCE(bgbi017,' ') = COALESCE( ? ,' '))"
   PREPARE sel_bgbip2 FROM l_sql
   DECLARE sel_bgbic2 CURSOR FOR sel_bgbip2
     
     
   #取得項次的核算項及其他維度
   INITIALIZE l_bgbi.* TO NULL
   SELECT * INTO l_bgbi.* FROM bgbi_t
    WHERE bgbient = g_enterprise
      AND bgbi002 = p_bgbi002
      AND bgbi003 = p_bgbi003
      AND bgbi004 = p_bgbi004
      AND bgbi005 = p_bgbi005
      AND bgbi044 = p_bgbi044
      AND bgbiseq = p_bgbiseq  
     
   #1.先取得組織範圍   自己p_bgbh003    自己的下層l_dnstep_str
   LET l_dnstep_str = NULL
   CALL s_abgt025_get_dnstep_site(l_bgbi.bgbi002,'','',l_bgbi.bgbi004)
      RETURNING l_dnstep_str
               
   #2.自己的abgt020資料倒入
   LET l_bgbh003 = l_bgbi.bgbi004
   LET l_bgbh006 = '1'
   FOREACH sel_bgbic2 USING l_bgbi.bgbi002,l_bgbi.bgbi003,l_bgbh003,l_bgbi.bgbi005,l_bgbh006,
                            l_bgbi.bgbi006,l_bgbi.bgbi007,l_bgbi.bgbi008,l_bgbi.bgbi009,l_bgbi.bgbi010,
                            l_bgbi.bgbi011,l_bgbi.bgbi012,l_bgbi.bgbi013,l_bgbi.bgbi014,l_bgbi.bgbi015,
                            l_bgbi.bgbi016,l_bgbi.bgbi039,l_bgbi.bgbi040,l_bgbi.bgbi041,l_bgbi.bgbi028,
                            l_bgbi.bgbi029,l_bgbi.bgbi030,l_bgbi.bgbi031,l_bgbi.bgbi032,l_bgbi.bgbi033,
                            l_bgbi.bgbi034,l_bgbi.bgbi035,l_bgbi.bgbi036,l_bgbi.bgbi037,l_bgbi.bgbi038,
                            l_bgbi.bgbi017
      INTO l_tmp.*
      IF SQLCA.SQLCODE THEN 
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'FOREACH:sel_bgbic1:1'
         CALL cl_err()
         EXIT FOREACH
      END IF
      #判斷26個維度  有空給空白 方便GROUP BY
      IF cl_null(l_tmp.bgbi006)THEN LET l_tmp.bgbi006 = ' ' END IF
      IF cl_null(l_tmp.bgbi007)THEN LET l_tmp.bgbi007 = ' ' END IF
      IF cl_null(l_tmp.bgbi008)THEN LET l_tmp.bgbi008 = ' ' END IF
      IF cl_null(l_tmp.bgbi009)THEN LET l_tmp.bgbi009 = ' ' END IF
      IF cl_null(l_tmp.bgbi010)THEN LET l_tmp.bgbi010 = ' ' END IF
      IF cl_null(l_tmp.bgbi011)THEN LET l_tmp.bgbi011 = ' ' END IF
      IF cl_null(l_tmp.bgbi012)THEN LET l_tmp.bgbi012 = ' ' END IF
      IF cl_null(l_tmp.bgbi013)THEN LET l_tmp.bgbi013 = ' ' END IF
      IF cl_null(l_tmp.bgbi014)THEN LET l_tmp.bgbi014 = ' ' END IF
      IF cl_null(l_tmp.bgbi015)THEN LET l_tmp.bgbi015 = ' ' END IF
      IF cl_null(l_tmp.bgbi016)THEN LET l_tmp.bgbi016 = ' ' END IF
      IF cl_null(l_tmp.bgbi039)THEN LET l_tmp.bgbi039 = ' ' END IF
      IF cl_null(l_tmp.bgbi040)THEN LET l_tmp.bgbi040 = ' ' END IF
      IF cl_null(l_tmp.bgbi041)THEN LET l_tmp.bgbi041 = ' ' END IF         
      IF cl_null(l_tmp.bgbi028)THEN LET l_tmp.bgbi028 = ' ' END IF
      IF cl_null(l_tmp.bgbi029)THEN LET l_tmp.bgbi029 = ' ' END IF
      IF cl_null(l_tmp.bgbi030)THEN LET l_tmp.bgbi030 = ' ' END IF
      IF cl_null(l_tmp.bgbi031)THEN LET l_tmp.bgbi031 = ' ' END IF
      IF cl_null(l_tmp.bgbi032)THEN LET l_tmp.bgbi032 = ' ' END IF
      IF cl_null(l_tmp.bgbi033)THEN LET l_tmp.bgbi033 = ' ' END IF
      IF cl_null(l_tmp.bgbi034)THEN LET l_tmp.bgbi034 = ' ' END IF
      IF cl_null(l_tmp.bgbi035)THEN LET l_tmp.bgbi035 = ' ' END IF
      IF cl_null(l_tmp.bgbi036)THEN LET l_tmp.bgbi036 = ' ' END IF
      IF cl_null(l_tmp.bgbi037)THEN LET l_tmp.bgbi037 = ' ' END IF
      IF cl_null(l_tmp.bgbi038)THEN LET l_tmp.bgbi038 = ' ' END IF
      
      #INSERT INTO s_abgt025_tmp2 VALUES(l_tmp.*)   #161108-00017#5   mark
      #161108-00017#5   add---s
      INSERT INTO s_abgt025_tmp2 (bgbiseq,bgbi002,bgbi003,bgbi004,bgbi005, 
                                  bgbi006,bgbi007,bgbi008,bgbi009,bgbi010,
                                  bgbi011,bgbi012,bgbi013,bgbi014,bgbi015, 
                                  bgbi016,bgbi039,bgbi040,bgbi041,bgbi028, 
                                  bgbi029,bgbi030,bgbi031,bgbi032,bgbi033, 
                                  bgbi034,bgbi035,bgbi036,bgbi037,bgbi038,
                                  bgbi023,bgbi024,bgbi025,bgbi026,bgbi027, 
                                  accountc,upd,bgbi044,bgbi017,site025, 
                                  seq025)
                          VALUES (l_tmp.bgbiseq,l_tmp.bgbi002,l_tmp.bgbi003,l_tmp.bgbi004,l_tmp.bgbi005, 
                                  l_tmp.bgbi006,l_tmp.bgbi007,l_tmp.bgbi008,l_tmp.bgbi009,l_tmp.bgbi010,
                                  l_tmp.bgbi011,l_tmp.bgbi012,l_tmp.bgbi013,l_tmp.bgbi014,l_tmp.bgbi015, 
                                  l_tmp.bgbi016,l_tmp.bgbi039,l_tmp.bgbi040,l_tmp.bgbi041,l_tmp.bgbi028, 
                                  l_tmp.bgbi029,l_tmp.bgbi030,l_tmp.bgbi031,l_tmp.bgbi032,l_tmp.bgbi033, 
                                  l_tmp.bgbi034,l_tmp.bgbi035,l_tmp.bgbi036,l_tmp.bgbi037,l_tmp.bgbi038,
                                  l_tmp.bgbi023,l_tmp.bgbi024,l_tmp.bgbi025,l_tmp.bgbi026,l_tmp.bgbi027, 
                                  l_tmp.accountc,l_tmp.upd,l_tmp.bgbi044,l_tmp.bgbi017,l_tmp.site025, 
                                  l_tmp.seq025)
      #161108-00017#5   add---e
   END FOREACH
   
   #3 下層組織的abgt020或abgt025資料倒入
   LET l_tok = base.StringTokenizer.create(l_dnstep_str,",")
   WHILE l_tok.hasMoreTokens()
      LET l_bgbh003 = l_tok.nextToken()
      IF l_bgbh003 = g_bgbh.bgbh003 THEN
         CONTINUE WHILE
      END IF      
      #判斷本層匯總資料是否存在 存在就優先抓
      LET l_count = NULL
      SELECT COUNT(*) INTO l_count 
        FROM bgbh_t
       WHERE bgbhent = g_enterprise
         AND bgbh001 = g_bgbh.bgbh001
         AND bgbh002 = g_bgbh.bgbh002
         AND bgbh003 = l_bgbh003
         AND bgbh004 = g_bgbh.bgbh004
         AND bgbh006 = '2'
         AND bgbhstus = 'Y'
      IF cl_null(l_count)THEN LET l_count = 0 END IF
      
      IF l_count > 0 THEN
         LET l_bgbh006 = '2'
      ELSE
         LET l_bgbh006 = '1'
      END IF
      
      FOREACH sel_bgbic2 USING l_bgbi.bgbi002,l_bgbi.bgbi003,l_bgbh003,l_bgbi.bgbi005,l_bgbh006,
                               l_bgbi.bgbi006,l_bgbi.bgbi007,l_bgbi.bgbi008,l_bgbi.bgbi009,l_bgbi.bgbi010,
                               l_bgbi.bgbi011,l_bgbi.bgbi012,l_bgbi.bgbi013,l_bgbi.bgbi014,l_bgbi.bgbi015,
                               l_bgbi.bgbi016,l_bgbi.bgbi039,l_bgbi.bgbi040,l_bgbi.bgbi041,l_bgbi.bgbi028,
                               l_bgbi.bgbi029,l_bgbi.bgbi030,l_bgbi.bgbi031,l_bgbi.bgbi032,l_bgbi.bgbi033,
                               l_bgbi.bgbi034,l_bgbi.bgbi035,l_bgbi.bgbi036,l_bgbi.bgbi037,l_bgbi.bgbi038,
                               l_bgbi.bgbi017
         INTO l_tmp.*
         IF SQLCA.SQLCODE THEN 
            INITIALIZE g_errparam.* TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = 'FOREACH:sel_bgbic1:2'
            CALL cl_err()
            EXIT FOREACH
         END IF
         #判斷26個維度  有空給空白 方便GROUP BY
         IF cl_null(l_tmp.bgbi006)THEN LET l_tmp.bgbi006 = ' ' END IF
         IF cl_null(l_tmp.bgbi007)THEN LET l_tmp.bgbi007 = ' ' END IF
         IF cl_null(l_tmp.bgbi008)THEN LET l_tmp.bgbi008 = ' ' END IF
         IF cl_null(l_tmp.bgbi009)THEN LET l_tmp.bgbi009 = ' ' END IF
         IF cl_null(l_tmp.bgbi010)THEN LET l_tmp.bgbi010 = ' ' END IF
         IF cl_null(l_tmp.bgbi011)THEN LET l_tmp.bgbi011 = ' ' END IF
         IF cl_null(l_tmp.bgbi012)THEN LET l_tmp.bgbi012 = ' ' END IF
         IF cl_null(l_tmp.bgbi013)THEN LET l_tmp.bgbi013 = ' ' END IF
         IF cl_null(l_tmp.bgbi014)THEN LET l_tmp.bgbi014 = ' ' END IF
         IF cl_null(l_tmp.bgbi015)THEN LET l_tmp.bgbi015 = ' ' END IF
         IF cl_null(l_tmp.bgbi016)THEN LET l_tmp.bgbi016 = ' ' END IF
         IF cl_null(l_tmp.bgbi039)THEN LET l_tmp.bgbi039 = ' ' END IF
         IF cl_null(l_tmp.bgbi040)THEN LET l_tmp.bgbi040 = ' ' END IF
         IF cl_null(l_tmp.bgbi041)THEN LET l_tmp.bgbi041 = ' ' END IF         
         IF cl_null(l_tmp.bgbi028)THEN LET l_tmp.bgbi028 = ' ' END IF
         IF cl_null(l_tmp.bgbi029)THEN LET l_tmp.bgbi029 = ' ' END IF
         IF cl_null(l_tmp.bgbi030)THEN LET l_tmp.bgbi030 = ' ' END IF
         IF cl_null(l_tmp.bgbi031)THEN LET l_tmp.bgbi031 = ' ' END IF
         IF cl_null(l_tmp.bgbi032)THEN LET l_tmp.bgbi032 = ' ' END IF
         IF cl_null(l_tmp.bgbi033)THEN LET l_tmp.bgbi033 = ' ' END IF
         IF cl_null(l_tmp.bgbi034)THEN LET l_tmp.bgbi034 = ' ' END IF
         IF cl_null(l_tmp.bgbi035)THEN LET l_tmp.bgbi035 = ' ' END IF
         IF cl_null(l_tmp.bgbi036)THEN LET l_tmp.bgbi036 = ' ' END IF
         IF cl_null(l_tmp.bgbi037)THEN LET l_tmp.bgbi037 = ' ' END IF
         IF cl_null(l_tmp.bgbi038)THEN LET l_tmp.bgbi038 = ' ' END IF

         #INSERT INTO s_abgt025_tmp2 VALUES(l_tmp.*)   #161108-00017#5   mark
         #161108-00017#5   add---s
         INSERT INTO s_abgt025_tmp2 (bgbiseq,bgbi002,bgbi003,bgbi004,bgbi005, 
                                     bgbi006,bgbi007,bgbi008,bgbi009,bgbi010,
                                     bgbi011,bgbi012,bgbi013,bgbi014,bgbi015, 
                                     bgbi016,bgbi039,bgbi040,bgbi041,bgbi028, 
                                     bgbi029,bgbi030,bgbi031,bgbi032,bgbi033, 
                                     bgbi034,bgbi035,bgbi036,bgbi037,bgbi038,
                                     bgbi023,bgbi024,bgbi025,bgbi026,bgbi027, 
                                     accountc,upd,bgbi044,bgbi017,site025, 
                                     seq025)
                             VALUES (l_tmp.bgbiseq,l_tmp.bgbi002,l_tmp.bgbi003,l_tmp.bgbi004,l_tmp.bgbi005, 
                                     l_tmp.bgbi006,l_tmp.bgbi007,l_tmp.bgbi008,l_tmp.bgbi009,l_tmp.bgbi010,
                                     l_tmp.bgbi011,l_tmp.bgbi012,l_tmp.bgbi013,l_tmp.bgbi014,l_tmp.bgbi015, 
                                     l_tmp.bgbi016,l_tmp.bgbi039,l_tmp.bgbi040,l_tmp.bgbi041,l_tmp.bgbi028, 
                                     l_tmp.bgbi029,l_tmp.bgbi030,l_tmp.bgbi031,l_tmp.bgbi032,l_tmp.bgbi033, 
                                     l_tmp.bgbi034,l_tmp.bgbi035,l_tmp.bgbi036,l_tmp.bgbi037,l_tmp.bgbi038,
                                     l_tmp.bgbi023,l_tmp.bgbi024,l_tmp.bgbi025,l_tmp.bgbi026,l_tmp.bgbi027, 
                                     l_tmp.accountc,l_tmp.upd,l_tmp.bgbi044,l_tmp.bgbi017,l_tmp.site025, 
                                     l_tmp.seq025)
         #161108-00017#5   add---e
      END FOREACH
   END WHILE
END FUNCTION

################################################################################
# Descriptions...: 判斷欄位用陣列初始化
# Date & Author..: 150810 by albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION abgt025_02_field_default()
   DEFINE l_i  LIKE type_t.num10  
   CALL g_groupbyfield.clear()
   
   LET g_groupbyfield[1].l_field  = "bgbi004"    
   LET g_groupbyfield[2].l_field  = "bgbi006"
   LET g_groupbyfield[3].l_field  = "bgbi007"
   LET g_groupbyfield[4].l_field  = "bgbi008"
   LET g_groupbyfield[5].l_field  = "bgbi009"
   LET g_groupbyfield[6].l_field  = "bgbi038"
   LET g_groupbyfield[7].l_field  = "bgbi010"
   LET g_groupbyfield[8].l_field  = "bgbi011"
   LET g_groupbyfield[9].l_field  = "bgbi012"
   LET g_groupbyfield[10].l_field = "bgbi013"
   LET g_groupbyfield[11].l_field = "bgbi039"
   LET g_groupbyfield[12].l_field = "bgbi040"
   LET g_groupbyfield[13].l_field = "bgbi041"
   LET g_groupbyfield[14].l_field = "bgbi014"
   LET g_groupbyfield[15].l_field = "bgbi015"
   LET g_groupbyfield[16].l_field = "bgbi016"
   LET g_groupbyfield[17].l_field = "bgbi028"
   LET g_groupbyfield[18].l_field = "bgbi029"
   LET g_groupbyfield[19].l_field = "bgbi030"
   LET g_groupbyfield[20].l_field = "bgbi031"
   LET g_groupbyfield[21].l_field = "bgbi032"
   LET g_groupbyfield[22].l_field = "bgbi033"
   LET g_groupbyfield[23].l_field = "bgbi034"
   LET g_groupbyfield[24].l_field = "bgbi035"
   LET g_groupbyfield[25].l_field = "bgbi036"
   LET g_groupbyfield[26].l_field = "bgbi037"
    
   FOR l_i = 1 TO 26 
      LET g_groupbyfield[l_i].l_used = 'N'
   END FOR
END FUNCTION

PRIVATE FUNCTION abgt025_02_b_fill()
   DEFINE l_sql  STRING
   DEFINE l_field STRING
   DEFINE l_group STRING
   DEFINE l_i     LIKE type_t.num10
   DEFINE l_do    LIKE type_t.num10
   #albireo 150907-----s
   DEFINE l_bgaa009 LIKE bgaa_t.bgaa009
   #albireo 150907-----e
   
   #albireo 150904-----s
   LET l_bgaa009 = NULL
   SELECT bgaa009 INTO l_bgaa009 
     FROM bgaa_t
    WHERE bgaaent = g_enterprise
      AND bgaa001 = g_bgbh.bgbh001
   #albireo 150904-----e
   
   LET l_field = NULL
   LET l_group = NULL
   LET l_do = 0
   FOR l_i = 1 TO 26 
      IF g_groupbyfield[l_i].l_used = 'Y' THEN
         IF cl_null(l_field)THEN  
            LET l_field = g_groupbyfield[l_i].l_field,","
         ELSE
            LET l_field = l_field CLIPPED,g_groupbyfield[l_i].l_field,","    
         END IF
         
         IF cl_null(l_group)THEN
            LET l_group = g_groupbyfield[l_i].l_field
         ELSE
            LET l_group = l_group CLIPPED,",",g_groupbyfield[l_i].l_field          
         END IF
         
         LET l_do = l_do + 1
      ELSE
         IF cl_null(l_field)THEN  
            LET l_field = "'',"
         ELSE
            LET l_field = l_field CLIPPED,"'',"
         END IF
      END IF
   END FOR
   
   LET l_sql = "SELECT ",l_field," ",
               "       SUM(bgbi027) ",
               "  FROM s_abgt025_tmp1 "
   IF l_do > 0 THEN
      LET l_sql = l_sql CLIPPED,
                  " GROUP BY ",l_group CLIPPED
   END IF
   
   PREPARE sel_abgt025_02_bfillp FROM l_sql
   DECLARE sel_abgt025_02_bfillc CURSOR FOR sel_abgt025_02_bfillp
   
   LET l_ac = 1 
   CALL g_bgbi_d.clear()
   FOREACH sel_abgt025_02_bfillc 
      INTO g_bgbi_d[l_ac].l_bgbi004,g_bgbi_d[l_ac].l_bgbi006,g_bgbi_d[l_ac].l_bgbi007,
           g_bgbi_d[l_ac].l_bgbi008,g_bgbi_d[l_ac].l_bgbi009,g_bgbi_d[l_ac].l_bgbi038,
           g_bgbi_d[l_ac].l_bgbi010,g_bgbi_d[l_ac].l_bgbi011,g_bgbi_d[l_ac].l_bgbi012,
           g_bgbi_d[l_ac].l_bgbi013,g_bgbi_d[l_ac].l_bgbi039,g_bgbi_d[l_ac].l_bgbi040,
           g_bgbi_d[l_ac].l_bgbi041,g_bgbi_d[l_ac].l_bgbi014,g_bgbi_d[l_ac].l_bgbi015,
           g_bgbi_d[l_ac].l_bgbi016,g_bgbi_d[l_ac].l_bgbi028,g_bgbi_d[l_ac].l_bgbi029,
           g_bgbi_d[l_ac].l_bgbi030,g_bgbi_d[l_ac].l_bgbi031,g_bgbi_d[l_ac].l_bgbi032,
           g_bgbi_d[l_ac].l_bgbi033,g_bgbi_d[l_ac].l_bgbi034,g_bgbi_d[l_ac].l_bgbi035,
           g_bgbi_d[l_ac].l_bgbi036,g_bgbi_d[l_ac].l_bgbi037,g_bgbi_d[l_ac].l_accountb
           IF SQLCA.SQLCODE THEN EXIT FOREACH END IF    
      LET g_bgbi_d[l_ac].l_bgbi004_desc = s_desc_show1(g_bgbi_d[l_ac].l_bgbi004,s_desc_get_department_desc(g_bgbi_d[l_ac].l_bgbi004))
      LET g_bgbi_d[l_ac].l_bgbi007_desc = s_desc_show1(g_bgbi_d[l_ac].l_bgbi007,s_desc_get_department_desc(g_bgbi_d[l_ac].l_bgbi007))
      LET g_bgbi_d[l_ac].l_bgbi008_desc = s_desc_show1(g_bgbi_d[l_ac].l_bgbi008,s_desc_get_department_desc(g_bgbi_d[l_ac].l_bgbi008))
      LET g_bgbi_d[l_ac].l_bgbi009_desc = s_desc_show1(g_bgbi_d[l_ac].l_bgbi009,s_desc_get_acc_desc('287',g_bgbi_d[l_ac].l_bgbi009))
      LET g_bgbi_d[l_ac].l_bgbi010_desc = s_desc_show1(g_bgbi_d[l_ac].l_bgbi010,s_desc_get_trading_partner_abbr_desc(g_bgbi_d[l_ac].l_bgbi010))
      LET g_bgbi_d[l_ac].l_bgbi011_desc = s_desc_show1(g_bgbi_d[l_ac].l_bgbi011,s_desc_get_trading_partner_abbr_desc(g_bgbi_d[l_ac].l_bgbi011))
      LET g_bgbi_d[l_ac].l_bgbi012_desc = s_desc_show1(g_bgbi_d[l_ac].l_bgbi012,s_desc_get_acc_desc('281',g_bgbi_d[l_ac].l_bgbi012))
      LET g_bgbi_d[l_ac].l_bgbi013_desc = s_desc_show1(g_bgbi_d[l_ac].l_bgbi013,s_desc_get_rtaxl003_desc(g_bgbi_d[l_ac].l_bgbi013))
      LET g_bgbi_d[l_ac].l_bgbi014_desc = s_desc_show1(g_bgbi_d[l_ac].l_bgbi014,s_desc_get_person_desc(g_bgbi_d[l_ac].l_bgbi014))
      LET g_bgbi_d[l_ac].l_bgbi015_desc = s_desc_show1(g_bgbi_d[l_ac].l_bgbi015,s_desc_get_project_desc(g_bgbi_d[l_ac].l_bgbi015))
      LET g_bgbi_d[l_ac].l_bgbi016_desc = s_desc_show1(g_bgbi_d[l_ac].l_bgbi016,s_desc_get_pjbbl004_desc(g_bgbi_d[l_ac].l_bgbi015,g_bgbi_d[l_ac].l_bgbi016))
      LET g_bgbi_d[l_ac].l_bgbi038_desc = s_desc_show1(g_bgbi_d[l_ac].l_bgbi038,s_desc_get_nmail004_desc(l_bgaa009,g_bgbi_d[l_ac].l_bgbi038))
      LET g_bgbi_d[l_ac].l_bgbi040_desc = s_desc_show1(g_bgbi_d[l_ac].l_bgbi040,s_desc_get_oojdl003_desc(g_bgbi_d[l_ac].l_bgbi040))
      LET g_bgbi_d[l_ac].l_bgbi041_desc = s_desc_show1(g_bgbi_d[l_ac].l_bgbi041,s_desc_get_acc_desc('2002',g_bgbi_d[l_ac].l_bgbi041))
      
      #CALL s_fin_sel_glad(g_glaald,g_glac002,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
      #     RETURNING g_errno,g_glad.*
      #
      #LET g_bgbi_d[l_ac].bgbi028_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi028,s_fin_get_accting_desc(g_glad.glad0171,g_bgbi_d[l_ac].bgbi028))
      #LET g_bgbi_d[l_ac].bgbi029_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi029,s_fin_get_accting_desc(g_glad.glad0181,g_bgbi_d[l_ac].bgbi029))
      #LET g_bgbi_d[l_ac].bgbi030_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi030,s_fin_get_accting_desc(g_glad.glad0191,g_bgbi_d[l_ac].bgbi030))
      #LET g_bgbi_d[l_ac].bgbi031_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi031,s_fin_get_accting_desc(g_glad.glad0201,g_bgbi_d[l_ac].bgbi031))
      #LET g_bgbi_d[l_ac].bgbi032_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi032,s_fin_get_accting_desc(g_glad.glad0211,g_bgbi_d[l_ac].bgbi032))
      #LET g_bgbi_d[l_ac].bgbi033_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi033,s_fin_get_accting_desc(g_glad.glad0221,g_bgbi_d[l_ac].bgbi033))
      #LET g_bgbi_d[l_ac].bgbi034_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi034,s_fin_get_accting_desc(g_glad.glad0231,g_bgbi_d[l_ac].bgbi034))
      #LET g_bgbi_d[l_ac].bgbi035_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi035,s_fin_get_accting_desc(g_glad.glad0241,g_bgbi_d[l_ac].bgbi035))
      #LET g_bgbi_d[l_ac].bgbi036_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi036,s_fin_get_accting_desc(g_glad.glad0251,g_bgbi_d[l_ac].bgbi036))
      #LET g_bgbi_d[l_ac].bgbi037_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi037,s_fin_get_accting_desc(g_glad.glad0261,g_bgbi_d[l_ac].bgbi037))
      LET g_bgbi_d[l_ac].l_bgbi028_desc = s_desc_show1(g_bgbi_d[l_ac].l_bgbi028,'')
      LET g_bgbi_d[l_ac].l_bgbi029_desc = s_desc_show1(g_bgbi_d[l_ac].l_bgbi029,'')
      LET g_bgbi_d[l_ac].l_bgbi030_desc = s_desc_show1(g_bgbi_d[l_ac].l_bgbi030,'')
      LET g_bgbi_d[l_ac].l_bgbi031_desc = s_desc_show1(g_bgbi_d[l_ac].l_bgbi031,'')
      LET g_bgbi_d[l_ac].l_bgbi032_desc = s_desc_show1(g_bgbi_d[l_ac].l_bgbi032,'')
      LET g_bgbi_d[l_ac].l_bgbi033_desc = s_desc_show1(g_bgbi_d[l_ac].l_bgbi033,'')
      LET g_bgbi_d[l_ac].l_bgbi034_desc = s_desc_show1(g_bgbi_d[l_ac].l_bgbi034,'')
      LET g_bgbi_d[l_ac].l_bgbi035_desc = s_desc_show1(g_bgbi_d[l_ac].l_bgbi035,'')
      LET g_bgbi_d[l_ac].l_bgbi036_desc = s_desc_show1(g_bgbi_d[l_ac].l_bgbi036,'')
      LET g_bgbi_d[l_ac].l_bgbi037_desc = s_desc_show1(g_bgbi_d[l_ac].l_bgbi037,'')
      
      LET g_bgbi_d[l_ac].l_amountb    = 0
      LET g_bgbi_d[l_ac].l_taxb       = 0
      LET g_bgbi_d[l_ac].l_amountc    = 0
      LET g_bgbi_d[l_ac].l_accountc   = 0
      LET g_bgbi_d[l_ac].l_amounta    = 0
      LET g_bgbi_d[l_ac].l_accounta   = g_bgbi_d[l_ac].l_accountb
      LET g_bgbi_d[l_ac].l_taxa       = 0
      LET l_ac = l_ac +1
   END FOREACH
   CALL g_bgbi_d.deleteElement(g_bgbi_d.getLength())
   
   
END FUNCTION

PRIVATE FUNCTION abgt025_02_input()
   DEFINE l_accounta   LIKE type_t.num20_6
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT ARRAY g_bgbi_d FROM s_detail1.*
              ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS,
                        INSERT ROW = FALSE,
                        DELETE ROW = FALSE,
                        APPEND ROW = FALSE)
         BEFORE ROW 
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac   
            LET g_bgbi_d_t.* = g_bgbi_d[l_ac].*            
              
         AFTER FIELD l_accountc
            IF NOT cl_null(g_bgbi_d[l_ac].l_accountc)THEN
               LET l_accounta = g_bgbi_d[l_ac].l_accountb+g_bgbi_d[l_ac].l_accountc
               IF l_accounta < 0 THEN
                  INITIALIZE g_errparam.* TO NULL
                  LET g_errparam.code = 'abg-00083'
                  LET g_errparam.extend = ''
                  CALL cl_err()
                  LET g_bgbi_d[l_ac].l_accountc = 0
               END IF
               LET g_bgbi_d[l_ac].l_accounta = g_bgbi_d[l_ac].l_accountb+g_bgbi_d[l_ac].l_accountc
               DISPLAY BY NAME g_bgbi_d[l_ac].l_accountc,g_bgbi_d[l_ac].l_accounta,g_bgbi_d[l_ac].l_accountb
            END IF
         AFTER FIELD l_accounta         
            IF NOT cl_null(g_bgbi_d[l_ac].l_accounta)THEN
               LET l_accounta = g_bgbi_d[l_ac].l_accounta
               IF l_accounta < 0 THEN
                  INITIALIZE g_errparam.* TO NULL
                  LET g_errparam.code = 'abg-00083'
                  LET g_errparam.extend = ''
                  CALL cl_err()
                  LET g_bgbi_d[l_ac].l_accountc = 0
                  LET g_bgbi_d[l_ac].l_accounta = g_bgbi_d[l_ac].l_accountb
               END IF            
               LET g_bgbi_d[l_ac].l_accountc = g_bgbi_d[l_ac].l_accounta - g_bgbi_d[l_ac].l_accountb
               DISPLAY BY NAME g_bgbi_d[l_ac].l_accountc,g_bgbi_d[l_ac].l_accounta,g_bgbi_d[l_ac].l_accountb
            END IF 

         ON ROW CHANGE
            
      END INPUT
      
      ON ACTION accept
         ACCEPT DIALOG
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      ON ACTION exit
         LET INT_FLAG = 1
         EXIT DIALOG
   END DIALOG
   
   IF INT_FLAG AND l_ac > 0 THEN
      LET g_bgbi_d[l_ac].* = g_bgbi_d_t.*  
   END IF
   
   IF INT_FLAG THEN
      LET INT_FLAG = 0
   END IF
END FUNCTION

################################################################################
# Descriptions...: 回寫各來源資料及臨時表資料方便後續呈現
# Memo...........:
# Date & Author..: 150810 by albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt025_02_upd_source()
   DEFINE l_count    LIKE type_t.num10
   DEFINE l_i        LIKE type_t.num10
   DEFINE l_i2       LIKE type_t.num10
   DEFINE l_wc       STRING
   DEFINE l_sql      STRING
   DEFINE l_tmp  RECORD
      bgbiseq   LIKE bgbi_t.bgbiseq,    #項次
      bgbi002   LIKE bgbi_t.bgbi002,    #預算編號
      bgbi003   LIKE bgbi_t.bgbi003,    #預算版本
      bgbi004   LIKE bgbi_t.bgbi004,    #預算組織
      bgbi005   LIKE bgbi_t.bgbi005,    #預算項目
      bgbi006   LIKE bgbi_t.bgbi006,    #預算期別
      bgbi007   LIKE bgbi_t.bgbi007,    #部門
      bgbi008   LIKE bgbi_t.bgbi008,    #成本利潤中心
      bgbi009   LIKE bgbi_t.bgbi009,    #區域
      bgbi010   LIKE bgbi_t.bgbi010,    #交易客商
      bgbi011   LIKE bgbi_t.bgbi011,    #收款客商
      bgbi012   LIKE bgbi_t.bgbi012,    #客群
      bgbi013   LIKE bgbi_t.bgbi013,    #產品類別
      bgbi014   LIKE bgbi_t.bgbi014,    #人員
      bgbi015   LIKE bgbi_t.bgbi015,    #專案編號
      bgbi016   LIKE bgbi_t.bgbi016,    #WBS
      bgbi039   LIKE bgbi_t.bgbi039,    #經營方式
      bgbi040   LIKE bgbi_t.bgbi040,    #渠道
      bgbi041   LIKE bgbi_t.bgbi041,    #品牌
      bgbi028   LIKE bgbi_t.bgbi028,    #自由核算項一
      bgbi029   LIKE bgbi_t.bgbi029,    #自由核算項二
      bgbi030   LIKE bgbi_t.bgbi030,    #自由核算項三
      bgbi031   LIKE bgbi_t.bgbi031,    #自由核算項四
      bgbi032   LIKE bgbi_t.bgbi032,    #自由核算項五
      bgbi033   LIKE bgbi_t.bgbi033,    #自由核算項六
      bgbi034   LIKE bgbi_t.bgbi034,    #自由核算項七
      bgbi035   LIKE bgbi_t.bgbi035,    #自由核算項八
      bgbi036   LIKE bgbi_t.bgbi036,    #自由核算項九
      bgbi037   LIKE bgbi_t.bgbi037,    #自由核算項十
      bgbi038   LIKE bgbi_t.bgbi038,    #現金變動碼
      bgbi023   LIKE bgbi_t.bgbi023,    #基準金額
      bgbi024   LIKE bgbi_t.bgbi024,    #本層調整
      bgbi025   LIKE bgbi_t.bgbi025,    #上層調整
      bgbi026   LIKE bgbi_t.bgbi026,    #下層調整
      bgbi027   LIKE bgbi_t.bgbi027,    #核准金額     
      accountc  LIKE type_t.num20_6,    #變動金額
      upd       LIKE type_t.chr1,        #已回寫
      bgbi044   LIKE bgbi_t.bgbi044,     #異動類型
      bgbi017   LIKE bgbi_t.bgbi017,    #來源原幣
      site025   LIKE ooef_t.ooef001,    #預算審核組織
      seq025    LIKE type_t.num10       #預算審核項次
                 END RECORD
   DEFINE l_fieldh   STRING
   DEFINE l_do       LIKE type_t.num20_6   #已分攤回寫
   DEFINE l_needdo   LIKE type_t.num20_6   #需要分攤的
   DEFINE l_accountc LIKE type_t.num20_6   #
   DEFINE l_upd_up   LIKE type_t.chr1      #是否回寫上層
   DEFINE l_site025 LIKE ooef_t.ooef001  #上一層的組織
   DEFINE l_seq025   LIKE type_t.num10     #上層項次
   #albireo 150903-----s
   DEFINE l_bgaa003  LIKE bgaa_t.bgaa003
   #albireo 150903-----e
   WHENEVER ERROR CONTINUE

   #判斷是否有需要做UPDATE SOURCE
   LET l_count = NULL
   SELECT COUNT(*) INTO l_count
     FROM s_abgt025_tmp1
    WHERE upd = 'N' 
   IF cl_null(l_count)THEN LET l_count = 0 END IF
   
   IF l_count = 0 THEN RETURN END IF
   
   #判斷是否需要回寫上層
   CALL s_abgt020_get_upstep_site(g_bgbh.bgbh001,'','',g_bgbh.bgbh003)
      RETURNING l_site025
   
   LET l_count = NULL
   SELECT COUNT(*) INTO l_count
     FROM bgbh_t
    WHERE bgbhent = g_enterprise
      AND bgbh001 = g_bgbh.bgbh001
      AND bgbh002 = g_bgbh.bgbh002
      AND bgbh003 = l_site025
      AND bgbh004 = g_bgbh.bgbh004
      AND bgbh006 = '2'
      
   IF cl_null(l_count)THEN LET l_count = 0 END IF
   IF l_count > 0 AND l_site025 <> g_bgbh.bgbh003 THEN
      LET l_upd_up = 'Y'
   ELSE
      LEt l_upd_up = 'N'
   END IF

   #albireo 150903-----s
   #抓預算幣別
   LET l_bgaa003 = NULL
   SELECT bgaa003 INTO l_bgaa003 FROM bgaa_t
    WHERE bgaaent = g_enterprise
      AND bgaa001 = g_bgbh.bgbh001
   #albireo 150903-----e
   
   #攤修改的預算   #以單身為最後修改結果BASE
   FOR l_i = 1 TO g_bgbi_d.getLength()
      IF g_bgbi_d[l_i].l_accountc <> 0 THEN   #有調整金額
         #依查詢條件最後查的內容做GROUP
         LET l_wc = NULL
         
         FOR l_i2 = 1 TO 26

            CASE
                WHEN g_groupbyfield[l_i2].l_field = 'bgbi006' AND g_groupbyfield[l_i2].l_used = 'Y'
                   LET l_fieldh = "bgbi006 ='",g_bgbi_d[l_i].l_bgbi006,"' "

                WHEN g_groupbyfield[l_i2].l_field = 'bgbi007' AND g_groupbyfield[l_i2].l_used = 'Y'
                   LET l_fieldh = "bgbi007 ='",g_bgbi_d[l_i].l_bgbi007,"' "          
                WHEN g_groupbyfield[l_i2].l_field = 'bgbi008' AND g_groupbyfield[l_i2].l_used = 'Y'
                   LET l_fieldh = "bgbi008 ='",g_bgbi_d[l_i].l_bgbi008,"' "
                WHEN g_groupbyfield[l_i2].l_field = 'bgbi009' AND g_groupbyfield[l_i2].l_used = 'Y'
                   LET l_fieldh = "bgbi009 ='",g_bgbi_d[l_i].l_bgbi009,"' "          
                WHEN g_groupbyfield[l_i2].l_field = 'bgbi010' AND g_groupbyfield[l_i2].l_used = 'Y'
                   LET l_fieldh = "bgbi010 ='",g_bgbi_d[l_i].l_bgbi010,"' "
                WHEN g_groupbyfield[l_i2].l_field = 'bgbi011' AND g_groupbyfield[l_i2].l_used = 'Y'
                   LET l_fieldh = "bgbi011 ='",g_bgbi_d[l_i].l_bgbi011,"' "
                WHEN g_groupbyfield[l_i2].l_field = 'bgbi012' AND g_groupbyfield[l_i2].l_used = 'Y'
                   LET l_fieldh = "bgbi012 ='",g_bgbi_d[l_i].l_bgbi012,"' "
                WHEN g_groupbyfield[l_i2].l_field = 'bgbi013' AND g_groupbyfield[l_i2].l_used = 'Y'
                   LET l_fieldh = "bgbi013 ='",g_bgbi_d[l_i].l_bgbi013,"' "
                WHEN g_groupbyfield[l_i2].l_field = 'bgbi014' AND g_groupbyfield[l_i2].l_used = 'Y'
                   LET l_fieldh = "bgbi014 ='",g_bgbi_d[l_i].l_bgbi014,"' "
                WHEN g_groupbyfield[l_i2].l_field = 'bgbi015' AND g_groupbyfield[l_i2].l_used = 'Y'
                   LET l_fieldh = "bgbi015 ='",g_bgbi_d[l_i].l_bgbi015,"' "
                WHEN g_groupbyfield[l_i2].l_field = 'bgbi016' AND g_groupbyfield[l_i2].l_used = 'Y'
                   LET l_fieldh = "bgbi016 ='",g_bgbi_d[l_i].l_bgbi016,"' "
                WHEN g_groupbyfield[l_i2].l_field = 'bgbi028' AND g_groupbyfield[l_i2].l_used = 'Y'
                   LET l_fieldh = "bgbi028 ='",g_bgbi_d[l_i].l_bgbi028,"' "
                WHEN g_groupbyfield[l_i2].l_field = 'bgbi029' AND g_groupbyfield[l_i2].l_used = 'Y'
                   LET l_fieldh = "bgbi029 ='",g_bgbi_d[l_i].l_bgbi029,"' "
                WHEN g_groupbyfield[l_i2].l_field = 'bgbi030' AND g_groupbyfield[l_i2].l_used = 'Y'
                   LET l_fieldh = "bgbi030 ='",g_bgbi_d[l_i].l_bgbi030,"' "
                WHEN g_groupbyfield[l_i2].l_field = 'bgbi031' AND g_groupbyfield[l_i2].l_used = 'Y'
                   LET l_fieldh = "bgbi031 ='",g_bgbi_d[l_i].l_bgbi031,"' "
                WHEN g_groupbyfield[l_i2].l_field = 'bgbi032' AND g_groupbyfield[l_i2].l_used = 'Y'
                   LET l_fieldh = "bgbi032 ='",g_bgbi_d[l_i].l_bgbi032,"' "
                WHEN g_groupbyfield[l_i2].l_field = 'bgbi033' AND g_groupbyfield[l_i2].l_used = 'Y'
                   LET l_fieldh = "bgbi033 ='",g_bgbi_d[l_i].l_bgbi033,"' "
                WHEN g_groupbyfield[l_i2].l_field = 'bgbi034' AND g_groupbyfield[l_i2].l_used = 'Y'
                   LET l_fieldh = "bgbi034 ='",g_bgbi_d[l_i].l_bgbi034,"' "
                WHEN g_groupbyfield[l_i2].l_field = 'bgbi035' AND g_groupbyfield[l_i2].l_used = 'Y'
                   LET l_fieldh = "bgbi035 ='",g_bgbi_d[l_i].l_bgbi035,"' "
                WHEN g_groupbyfield[l_i2].l_field = 'bgbi036' AND g_groupbyfield[l_i2].l_used = 'Y'
                   LET l_fieldh = "bgbi036 ='",g_bgbi_d[l_i].l_bgbi036,"' "
                WHEN g_groupbyfield[l_i2].l_field = 'bgbi037' AND g_groupbyfield[l_i2].l_used = 'Y' 
                   LET l_fieldh = "bgbi037 ='",g_bgbi_d[l_i].l_bgbi037,"' " 
            END CASE
            IF NOT cl_null(l_fieldh)THEN
               IF cl_null(l_wc)THEN
                  LET l_wc = l_fieldh
               ELSE
                  LET l_wc = l_wc CLIPPED," AND ",l_fieldh CLIPPED
               END IF
            END IF
         END FOR
         IF cl_null(l_wc)THEN LET l_wc = " 1=1" END IF
         LET l_sql = "SELECT * FROM s_abgt025_tmp1 ",
                     " WHERE ",l_wc,
                     " ORDER BY bgbi027 "
                     
         PREPARE sel_abgt020_tmp2p FROM l_sql
         DECLARE sel_abgt020_tmp2c CURSOR FOR sel_abgt020_tmp2p
         
         LET l_sql = "SELECT COUNT(*) FROM ( ",l_sql,") "
         PREPARE sel_abgt020_tmp3p FROM l_sql
         LET l_count = NULL
         EXECUTE sel_abgt020_tmp3p INTO l_count
         IF cl_null(l_count) THEN LET l_count = 0 END IF
         
         LET l_ac = 1
         LET l_do = 0
         FOREACH sel_abgt020_tmp2c INTO l_tmp.*
            IF SQLCA.SQLCODE THEN
               EXIT FOREACH
            END IF            
                        
            
            IF l_count = l_ac THEN
               IF l_ac = 1 THEN
                  LET l_accountc = g_bgbi_d[l_i].l_accountc
               ELSE
                  LET l_accountc = g_bgbi_d[l_i].l_accountc - l_do
               END IF
            ELSE
               LET l_accountc = g_bgbi_d[l_i].l_accountc * l_tmp.bgbi027 / g_bgbi_d[l_i].l_accountb
               #albireo 150903-----s
               #依預算編制幣別取位
               CALL s_curr_round(g_bgbh.bgbh003,l_bgaa003,l_accountc,2) RETURNING l_accountc               
               #albireo 150903-----e
            END IF
            
            #UPDATE 來源單 上層調整
            UPDATE bgbi_t SET bgbi025 = bgbi025 + l_accountc,
                              bgbi027 = bgbi027 + l_accountc
             WHERE bgbient = g_enterprise
               AND bgbi002 = l_tmp.bgbi002
               AND bgbi003 = l_tmp.bgbi003
               AND bgbi004 = l_tmp.bgbi004
               AND bgbi005 = l_tmp.bgbi005
               AND bgbiseq = l_tmp.bgbiseq
               AND bgbi044 = l_tmp.bgbi044
               
            #UPDATE 現在這張單  本層調整
            UPDATE bgbi_t SET bgbi024 = bgbi024 + l_accountc,
                              bgbi027 = bgbi027 + l_accountc
             WHERE bgbient = g_enterprise
               AND bgbi002 = l_tmp.bgbi002
               AND bgbi003 = l_tmp.bgbi003
               AND bgbi004 = l_tmp.site025
               AND bgbi005 = l_tmp.bgbi005
               AND bgbiseq = l_tmp.seq025
               AND bgbi044 = '2'        

            #有上層的話要回寫上層的下層調整
            IF l_upd_up = 'Y' THEN
               #取得符合條件的seq
               EXECUTE sel_bgbiseqp1
               USING g_bgbh.bgbh001,g_bgbh.bgbh002,l_site025,g_bgbh.bgbh004,'2',
                     l_tmp.bgbi006,l_tmp.bgbi007,l_tmp.bgbi008,l_tmp.bgbi009,l_tmp.bgbi010,
                     l_tmp.bgbi011,l_tmp.bgbi012,l_tmp.bgbi013,l_tmp.bgbi014,l_tmp.bgbi015,
                     l_tmp.bgbi016,l_tmp.bgbi039,l_tmp.bgbi040,l_tmp.bgbi041,l_tmp.bgbi028,
                     l_tmp.bgbi029,l_tmp.bgbi030,l_tmp.bgbi031,l_tmp.bgbi032,l_tmp.bgbi033,
                     l_tmp.bgbi034,l_tmp.bgbi035,l_tmp.bgbi036,l_tmp.bgbi037,l_tmp.bgbi038,
                     l_tmp.bgbi017
                INTO l_seq025
                
                #UPDATE 上層
                UPDATE bgbi_t SET bgbi026 = bgbi026 + l_accountc,
                                  bgbi027 = bgbi027 + l_accountc
                 WHERE bgbient = g_enterprise
                   AND bgbi002 = l_tmp.bgbi002
                   AND bgbi003 = l_tmp.bgbi003
                   AND bgbi004 = l_site025
                   AND bgbi005 = l_tmp.bgbi005
                   AND bgbiseq = l_seq025
                   AND bgbi044 = '2'                
            END IF
               
            #UPDATE 已經攤算的
            UPDATE s_abgt025_tmp1 SET accountc = l_accountc,
                                      upd = 'Y'
             WHERE bgbi002 = l_tmp.bgbi002
               AND bgbi003 = l_tmp.bgbi003
               AND bgbi004 = l_tmp.bgbi004
               AND bgbi005 = l_tmp.bgbi005
               AND bgbiseq = l_tmp.bgbiseq
               AND bgbi044 = l_tmp.bgbi044 
            
            #來源為abgt025時要往下展
            IF l_tmp.bgbi044 = '2' THEN
               #往下層繼續展開
               CALL abgt025_02_upd_source_down(l_tmp.bgbi002,l_tmp.bgbi003,l_tmp.bgbi004,
                                               l_tmp.bgbi005,l_tmp.bgbi044,l_tmp.bgbiseq,l_accountc)
            END IF   
            
            LET l_do = l_do + l_accountc
            LET l_ac = l_ac + 1
         END FOREACH         
      END IF
   END FOR
   
END FUNCTION

################################################################################
# Descriptions...: 回寫下層組織來源
# Memo...........:
# Usage..........: 
# Date & Author..: 150810 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt025_02_upd_source_down(p_bgbi002,p_bgbi003,p_bgbi004,p_bgbi005,p_bgbi044,p_bgbiseq,p_accountc)
   DEFINE p_bgbi002   LIKE bgbi_t.bgbi002
   DEFINE p_bgbi003   LIKE bgbi_t.bgbi003
   DEFINE p_bgbi004   LIKE bgbi_t.bgbi004
   DEFINE p_bgbi005   LIKE bgbi_t.bgbi005
   DEFINE p_bgbi044   LIKE bgbi_t.bgbi044
   DEFINE p_bgbiseq   LIKE bgbi_t.bgbiseq
   DEFINE p_accountc  LIKE type_t.num20_6
   DEFINE l_accountb  LIKE type_t.num20_6
   DEFINE l_dnstep_str STRING
   DEFINE l_sql    STRING
   DEFINE l_i      LIKE type_t.num10
  #DEFINE l_bgbi      RECORD LIKE bgbi_t.* #161104-00024#8  mark
   #161104-00024#8   --s add
   DEFINE l_bgbi RECORD  #年度預算單身檔
       bgbient LIKE bgbi_t.bgbient, #企業編號
       bgbiseq LIKE bgbi_t.bgbiseq, #項次
       bgbi001 LIKE bgbi_t.bgbi001, #摘要
       bgbi002 LIKE bgbi_t.bgbi002, #預算編號
       bgbi003 LIKE bgbi_t.bgbi003, #預算版本
       bgbi004 LIKE bgbi_t.bgbi004, #預算組織
       bgbi005 LIKE bgbi_t.bgbi005, #預算細項
       bgbi006 LIKE bgbi_t.bgbi006, #預算期別
       bgbi007 LIKE bgbi_t.bgbi007, #部門
       bgbi008 LIKE bgbi_t.bgbi008, #成本利潤中心
       bgbi009 LIKE bgbi_t.bgbi009, #區域
       bgbi010 LIKE bgbi_t.bgbi010, #交易客商
       bgbi011 LIKE bgbi_t.bgbi011, #收款客商
       bgbi012 LIKE bgbi_t.bgbi012, #客群
       bgbi013 LIKE bgbi_t.bgbi013, #產品類別
       bgbi014 LIKE bgbi_t.bgbi014, #人員
       bgbi015 LIKE bgbi_t.bgbi015, #專案編號
       bgbi016 LIKE bgbi_t.bgbi016, #WBS
       bgbi017 LIKE bgbi_t.bgbi017, #預算幣別
       bgbi018 LIKE bgbi_t.bgbi018, #含稅單價
       bgbi019 LIKE bgbi_t.bgbi019, #不含稅單價
       bgbi020 LIKE bgbi_t.bgbi020, #稅別
       bgbi021 LIKE bgbi_t.bgbi021, #交易數量
       bgbi022 LIKE bgbi_t.bgbi022, #交易金額
       bgbi023 LIKE bgbi_t.bgbi023, #基準金額
       bgbi024 LIKE bgbi_t.bgbi024, #本層調整
       bgbi025 LIKE bgbi_t.bgbi025, #上層調整
       bgbi026 LIKE bgbi_t.bgbi026, #下層調整
       bgbi027 LIKE bgbi_t.bgbi027, #核准金額
       bgbi028 LIKE bgbi_t.bgbi028, #自由核算項一
       bgbi029 LIKE bgbi_t.bgbi029, #自由核算項二
       bgbi030 LIKE bgbi_t.bgbi030, #自由核算項三
       bgbi031 LIKE bgbi_t.bgbi031, #自由核算項四
       bgbi032 LIKE bgbi_t.bgbi032, #自由核算項五
       bgbi033 LIKE bgbi_t.bgbi033, #自由核算項六
       bgbi034 LIKE bgbi_t.bgbi034, #自由核算項七
       bgbi035 LIKE bgbi_t.bgbi035, #自由核算項八
       bgbi036 LIKE bgbi_t.bgbi036, #自由核算項九
       bgbi037 LIKE bgbi_t.bgbi037, #自由核算項十
       bgbi038 LIKE bgbi_t.bgbi038, #現金變動碼
       bgbi039 LIKE bgbi_t.bgbi039, #經營方式
       bgbi040 LIKE bgbi_t.bgbi040, #通路
       bgbi041 LIKE bgbi_t.bgbi041, #品牌
       bgbi042 LIKE bgbi_t.bgbi042, #稅率
       bgbi043 LIKE bgbi_t.bgbi043, #匯率
       bgbiud001 LIKE bgbi_t.bgbiud001, #自定義欄位(文字)001
       bgbiud002 LIKE bgbi_t.bgbiud002, #自定義欄位(文字)002
       bgbiud003 LIKE bgbi_t.bgbiud003, #自定義欄位(文字)003
       bgbiud004 LIKE bgbi_t.bgbiud004, #自定義欄位(文字)004
       bgbiud005 LIKE bgbi_t.bgbiud005, #自定義欄位(文字)005
       bgbiud006 LIKE bgbi_t.bgbiud006, #自定義欄位(文字)006
       bgbiud007 LIKE bgbi_t.bgbiud007, #自定義欄位(文字)007
       bgbiud008 LIKE bgbi_t.bgbiud008, #自定義欄位(文字)008
       bgbiud009 LIKE bgbi_t.bgbiud009, #自定義欄位(文字)009
       bgbiud010 LIKE bgbi_t.bgbiud010, #自定義欄位(文字)010
       bgbiud011 LIKE bgbi_t.bgbiud011, #自定義欄位(數字)011
       bgbiud012 LIKE bgbi_t.bgbiud012, #自定義欄位(數字)012
       bgbiud013 LIKE bgbi_t.bgbiud013, #自定義欄位(數字)013
       bgbiud014 LIKE bgbi_t.bgbiud014, #自定義欄位(數字)014
       bgbiud015 LIKE bgbi_t.bgbiud015, #自定義欄位(數字)015
       bgbiud016 LIKE bgbi_t.bgbiud016, #自定義欄位(數字)016
       bgbiud017 LIKE bgbi_t.bgbiud017, #自定義欄位(數字)017
       bgbiud018 LIKE bgbi_t.bgbiud018, #自定義欄位(數字)018
       bgbiud019 LIKE bgbi_t.bgbiud019, #自定義欄位(數字)019
       bgbiud020 LIKE bgbi_t.bgbiud020, #自定義欄位(數字)020
       bgbiud021 LIKE bgbi_t.bgbiud021, #自定義欄位(日期時間)021
       bgbiud022 LIKE bgbi_t.bgbiud022, #自定義欄位(日期時間)022
       bgbiud023 LIKE bgbi_t.bgbiud023, #自定義欄位(日期時間)023
       bgbiud024 LIKE bgbi_t.bgbiud024, #自定義欄位(日期時間)024
       bgbiud025 LIKE bgbi_t.bgbiud025, #自定義欄位(日期時間)025
       bgbiud026 LIKE bgbi_t.bgbiud026, #自定義欄位(日期時間)026
       bgbiud027 LIKE bgbi_t.bgbiud027, #自定義欄位(日期時間)027
       bgbiud028 LIKE bgbi_t.bgbiud028, #自定義欄位(日期時間)028
       bgbiud029 LIKE bgbi_t.bgbiud029, #自定義欄位(日期時間)029
       bgbiud030 LIKE bgbi_t.bgbiud030, #自定義欄位(日期時間)030
       bgbi044 LIKE bgbi_t.bgbi044, #資料來源
       bgbi045 LIKE bgbi_t.bgbi045, #管理組織
       bgbi046 LIKE bgbi_t.bgbi046, #預算樣表
       bgbiownid LIKE bgbi_t.bgbiownid, #資料所有者
       bgbiowndp LIKE bgbi_t.bgbiowndp, #資料所屬部門
       bgbicrtid LIKE bgbi_t.bgbicrtid, #資料建立者
       bgbicrtdp LIKE bgbi_t.bgbicrtdp, #資料建立部門
       bgbicrtdt LIKE bgbi_t.bgbicrtdt, #資料創建日
       bgbimodid LIKE bgbi_t.bgbimodid, #資料修改者
       bgbimoddt LIKE bgbi_t.bgbimoddt, #最近修改日
       bgbicnfid LIKE bgbi_t.bgbicnfid, #資料確認者
       bgbicnfdt LIKE bgbi_t.bgbicnfdt, #資料確認日
       bgbistus LIKE bgbi_t.bgbistus, #狀態碼
       bgbi047 LIKE bgbi_t.bgbi047  #上層組織
   END RECORD
   #161104-00024#8  --e add
   DEFINE l_bgbi2  DYNAMIC ARRAY OF RECORD 
      bgbiseq   LIKE bgbi_t.bgbiseq,    #項次
      bgbi002   LIKE bgbi_t.bgbi002,    #預算編號
      bgbi003   LIKE bgbi_t.bgbi003,    #預算版本
      bgbi004   LIKE bgbi_t.bgbi004,    #預算組織
      bgbi005   LIKE bgbi_t.bgbi005,    #預算項目
      bgbi006   LIKE bgbi_t.bgbi006,    #預算期別
      bgbi007   LIKE bgbi_t.bgbi007,    #部門
      bgbi008   LIKE bgbi_t.bgbi008,    #成本利潤中心
      bgbi009   LIKE bgbi_t.bgbi009,    #區域
      bgbi010   LIKE bgbi_t.bgbi010,    #交易客商
      bgbi011   LIKE bgbi_t.bgbi011,    #收款客商
      bgbi012   LIKE bgbi_t.bgbi012,    #客群
      bgbi013   LIKE bgbi_t.bgbi013,    #產品類別
      bgbi014   LIKE bgbi_t.bgbi014,    #人員
      bgbi015   LIKE bgbi_t.bgbi015,    #專案編號
      bgbi016   LIKE bgbi_t.bgbi016,    #WBS
      bgbi039   LIKE bgbi_t.bgbi039,    #經營方式
      bgbi040   LIKE bgbi_t.bgbi040,    #渠道
      bgbi041   LIKE bgbi_t.bgbi041,    #品牌
      bgbi028   LIKE bgbi_t.bgbi028,    #自由核算項一
      bgbi029   LIKE bgbi_t.bgbi029,    #自由核算項二
      bgbi030   LIKE bgbi_t.bgbi030,    #自由核算項三
      bgbi031   LIKE bgbi_t.bgbi031,    #自由核算項四
      bgbi032   LIKE bgbi_t.bgbi032,    #自由核算項五
      bgbi033   LIKE bgbi_t.bgbi033,    #自由核算項六
      bgbi034   LIKE bgbi_t.bgbi034,    #自由核算項七
      bgbi035   LIKE bgbi_t.bgbi035,    #自由核算項八
      bgbi036   LIKE bgbi_t.bgbi036,    #自由核算項九
      bgbi037   LIKE bgbi_t.bgbi037,    #自由核算項十
      bgbi038   LIKE bgbi_t.bgbi038,    #現金變動碼
      bgbi023   LIKE bgbi_t.bgbi023,    #基準金額
      bgbi024   LIKE bgbi_t.bgbi024,    #本層調整
      bgbi025   LIKE bgbi_t.bgbi025,    #上層調整
      bgbi026   LIKE bgbi_t.bgbi026,    #下層調整
      bgbi027   LIKE bgbi_t.bgbi027,    #核准金額     
      accountc  LIKE type_t.num20_6,    #變動金額
      upd       LIKE type_t.chr1,        #已回寫
      bgbi044   LIKE bgbi_t.bgbi044,     #異動類型
      bgbi017   LIKE bgbi_t.bgbi017,    #來源原幣
      site025   LIKE ooef_t.ooef001,    #預算審核組織
      seq025    LIKE type_t.num10       #預算審核項次   
                   END RECORD
   DEFINE l_do     LIKE type_t.num20_6
   DEFINE l_accountc LIKE type_t.num20_6
   DEFINE l_count  LIKE type_t.num10
   #albireo 150903-----s
   DEFINE l_bgaa003  LIKE bgaa_t.bgaa003
   #albireo 150903-----e
   WHENEVER ERROR CONTINUE
   
   #albireo 150903-----s
   #抓預算幣別
   LET l_bgaa003 = NULL
   SELECT bgaa003 INTO l_bgaa003 FROM bgaa_t
    WHERE bgaaent = g_enterprise
      AND bgaa001 = g_bgbh.bgbh001
   #albireo 150903-----e
   
   #取得下層組織
   #FOREACH下層組織符合的組成項次記錄到ARRAY
   #用ARRAY去跑攤算動作  如果遇到也是025結點就繼續CALL自己
       
      
   #用其維度及下一層的組織範圍取得資料
   #先insert到每層塞完都會刪除的temp2
   #做整理排序跟判斷要抓020 還是025
   DELETE FROM s_abgt025_tmp2
   CALL abgt025_02_ins_tmp2(p_bgbi002,p_bgbi003,p_bgbi004,p_bgbi005,p_bgbi044,p_bgbiseq)
   
   #tmp2資料FOREACH   金額由小排到大 方便攤尾差
   #先取得此資料範圍的核準金額bgbi027總合
   #以核準金額當做金額分攤比例
   LET l_sql = "SELECT * FROM s_abgt025_tmp2 ",
               " ORDER BY bgbi027 "
   PREPARE sel_tmpp2 FROM l_sql
   DECLARE sel_tmpc2 CURSOR FOR sel_tmpp2
   
   #取得資料範圍內核准金額總核
   LET l_sql = "SELECT SUM(bgbi027) FROM s_abgt025_tmp2 "
   PREPARE sel_tmpp3 FROM l_sql
   LET l_accountb = NULL
   EXECUTE sel_tmpp3 INTO l_accountb 
   IF cl_null(l_accountb)THEN LET l_accountb = 0 END IF
   IF l_accountb = 0 THEN RETURN END IF   #避免數學錯誤 除以0
   
   LET l_i = 1
   FOREACH sel_tmpc2 INTO l_bgbi2[l_i].*
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      LET l_i = l_i + 1   
   END FOREACH
   CALL l_bgbi2.deleteElement(l_bgbi2.getLength())
   
   FOR l_i = 1 TO l_bgbi2.getLength()
      IF l_count = l_i THEN
         IF l_i = 1 THEN
            LET l_accountc = p_accountc
         ELSE
            LET l_accountc = p_accountc - l_do
         END IF
      ELSE
         LET l_accountc = p_accountc * l_bgbi2[l_i].bgbi027 / l_accountb
         #albireo 150903-----s
         #依預算編制幣別取位
         CALL s_curr_round(g_bgbh.bgbh003,l_bgaa003,l_accountc,2) RETURNING l_accountc               
         #albireo 150903-----e
      END IF
      
      #UPDATE 來源單 上層調整
      UPDATE bgbi_t SET bgbi025 = bgbi025 + l_accountc,
                        bgbi027 = bgbi027 + l_accountc
       WHERE bgbient = g_enterprise
         AND bgbi002 = l_bgbi2[l_i].bgbi002
         AND bgbi003 = l_bgbi2[l_i].bgbi003
         AND bgbi004 = l_bgbi2[l_i].bgbi004
         AND bgbi005 = l_bgbi2[l_i].bgbi005
         AND bgbiseq = l_bgbi2[l_i].bgbiseq
         AND bgbi044 = l_bgbi2[l_i].bgbi044
         
      IF l_bgbi2[l_i].bgbi044 = '2' THEN
         #往下層繼續展開
         CALL abgt025_02_upd_source_down(l_bgbi2[l_i].bgbi002,l_bgbi2[l_i].bgbi003,l_bgbi2[l_i].bgbi004,
                                         l_bgbi2[l_i].bgbi005,l_bgbi2[l_i].bgbi044,l_bgbi2[l_i].bgbiseq,
                                         l_accountc)
      END IF      
      LET l_do = l_do + l_accountc  
   END FOR
    
END FUNCTION

 
{</section>}
 
