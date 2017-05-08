#該程式未解開Section, 採用最新樣板產出!
{<section id="abgt025_03.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2015-09-01 09:32:14), PR版次:0001(2015-09-07 09:36:43)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000032
#+ Filename...: abgt025_03
#+ Description: 預算結果調整查詢
#+ Creator....: 03080(2015-08-19 10:51:17)
#+ Modifier...: 03080 -SD/PR- 03080
 
{</section>}
 
{<section id="abgt025_03.global" >}
#應用 c01c 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
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
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point  
 
{</section>}
 
{<section id="abgt025_03.input" >}
#+ 資料輸入
PUBLIC FUNCTION abgt025_03(--)
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
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_abgt025_03 WITH FORM cl_ap_formpath("abg","abgt025_03")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   #輸入前處理
   #add-point:單頭前置處理 name="construct.pre_construct"
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
   CALL cl_set_combo_scc('bgbh006','9989')
   CALL cl_set_combo_scc('bgbi039','6013')
   CALL g_bgbi_d.clear()
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
         CALL abgt025_03_b_fill()

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
 
   #end add-point 
   
   #畫面關閉
   CLOSE WINDOW w_abgt025_03 
   
   #add-point:construct段after construct name="construct.post_construct"
   IF INT_FLAG THEN
      LET INT_FLAG = 0
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abgt025_03.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="abgt025_03.other_function" readonly="Y" >}

PRIVATE FUNCTION abgt025_03_b_fill()
   DEFINE l_sql  STRING
   DEFINE l_field STRING
   DEFINE l_group STRING
   DEFINE l_i     LIKE type_t.num10
   DEFINE l_do    LIKE type_t.num10
   DEFINE l_bgaa009 LIKE bgaa_t.bgaa009
   
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
  
   LET l_sql = "SELECT bgbi004,bgbi006,bgbi007,",
               "       bgbi008,bgbi009,bgbi038,",
               "       bgbi010,bgbi011,bgbi012,",
               "       bgbi013,bgbi039,bgbi040,",
               "       bgbi041,bgbi014,bgbi015,",
               "       bgbi016,bgbi028,bgbi029,",
               "       bgbi030,bgbi031,bgbi032,",
               "       bgbi033,bgbi034,bgbi035,",
               "       bgbi036,bgbi037,",
               "       bgbi027,accountc ",
               "  FROM s_abgt025_tmp1 "
   
   PREPARE sel_abgt025_03_bfillp FROM l_sql
   DECLARE sel_abgt025_03_bfillc CURSOR FOR sel_abgt025_03_bfillp
   
   LET l_ac = 1 
   CALL g_bgbi_d.clear()
   FOREACH sel_abgt025_03_bfillc 
      INTO g_bgbi_d[l_ac].l_bgbi004,g_bgbi_d[l_ac].l_bgbi006,g_bgbi_d[l_ac].l_bgbi007,
           g_bgbi_d[l_ac].l_bgbi008,g_bgbi_d[l_ac].l_bgbi009,g_bgbi_d[l_ac].l_bgbi038,
           g_bgbi_d[l_ac].l_bgbi010,g_bgbi_d[l_ac].l_bgbi011,g_bgbi_d[l_ac].l_bgbi012,
           g_bgbi_d[l_ac].l_bgbi013,g_bgbi_d[l_ac].l_bgbi039,g_bgbi_d[l_ac].l_bgbi040,
           g_bgbi_d[l_ac].l_bgbi041,g_bgbi_d[l_ac].l_bgbi014,g_bgbi_d[l_ac].l_bgbi015,
           g_bgbi_d[l_ac].l_bgbi016,g_bgbi_d[l_ac].l_bgbi028,g_bgbi_d[l_ac].l_bgbi029,
           g_bgbi_d[l_ac].l_bgbi030,g_bgbi_d[l_ac].l_bgbi031,g_bgbi_d[l_ac].l_bgbi032,
           g_bgbi_d[l_ac].l_bgbi033,g_bgbi_d[l_ac].l_bgbi034,g_bgbi_d[l_ac].l_bgbi035,
           g_bgbi_d[l_ac].l_bgbi036,g_bgbi_d[l_ac].l_bgbi037,g_bgbi_d[l_ac].l_accountb,g_bgbi_d[l_ac].l_accountc
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
      LET g_bgbi_d[l_ac].l_amounta    = 0
      LET g_bgbi_d[l_ac].l_accounta   = g_bgbi_d[l_ac].l_accountb + g_bgbi_d[l_ac].l_accountc
      LET g_bgbi_d[l_ac].l_taxa       = 0
      LET l_ac = l_ac +1
   END FOREACH
   CALL g_bgbi_d.deleteElement(g_bgbi_d.getLength())
   
   
END FUNCTION

 
{</section>}
 
