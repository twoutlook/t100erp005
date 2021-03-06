#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq852.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:7(2015-09-24 14:28:10), PR版次:0007(2016-10-24 11:44:23)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000045
#+ Filename...: aglq852
#+ Description: 資產損益多期間查詢
#+ Creator....: 02599(2015-09-24 10:26:48)
#+ Modifier...: 02599 -SD/PR- 06821
 
{</section>}
 
{<section id="aglq852.global" >}
#應用 q04 樣板自動產生(Version:32)
#add-point:填寫註解說明 name="global.memo"
#+ Modifier...:   No.160318-00025#36   2016/04/14 BY pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160512-00030#1    2016/05/12 By 02599  当报表模板是损益表时，抓取agli070中‘本期数’设置公式
#160811-00039#4    2016/08/29 By 02599  查询是自行输入账套时要检核账套权限
#160913-00017#3    2016/09/21 By 07900  AGL模组调整交易客商开窗
#161021-00015#1    2016/10/21 By 02599  当选择的报表模板为资产负债表，且结构为左右时，排序改成左右+行序
#161021-00037#2    2016/10/24 By 06821  組織類型與職能開窗調整
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_master        RECORD
       glfa006 LIKE type_t.chr500
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_detail RECORD
       
       sel LIKE type_t.chr1, 
   glfbseq LIKE glfb_t.glfbseq, 
   glfb002 LIKE glfb_t.glfb002, 
   glfb002_desc LIKE type_t.chr500, 
   glfb003 LIKE glfb_t.glfb003, 
   amt1 LIKE type_t.num20_6, 
   per1 LIKE type_t.num20_6, 
   amt2 LIKE type_t.num20_6, 
   per2 LIKE type_t.num20_6, 
   amt3 LIKE type_t.num20_6, 
   per3 LIKE type_t.num20_6, 
   amt4 LIKE type_t.num20_6, 
   per4 LIKE type_t.num20_6, 
   amt5 LIKE type_t.num20_6, 
   per5 LIKE type_t.num20_6, 
   amt6 LIKE type_t.num20_6, 
   per6 LIKE type_t.num20_6, 
   amt7 LIKE type_t.num20_6, 
   per7 LIKE type_t.num20_6, 
   amt8 LIKE type_t.num20_6, 
   per8 LIKE type_t.num20_6, 
   amt9 LIKE type_t.num20_6, 
   per9 LIKE type_t.num20_6, 
   amt10 LIKE type_t.num20_6, 
   per10 LIKE type_t.num20_6, 
   amt11 LIKE type_t.num20_6, 
   per11 LIKE type_t.num20_6, 
   amt12 LIKE type_t.num20_6, 
   per12 LIKE type_t.num20_6, 
   amt13 LIKE type_t.num20_6, 
   per13 LIKE type_t.num20_6, 
   amt14 LIKE type_t.num20_6, 
   per14 LIKE type_t.num20_6, 
   amt15 LIKE type_t.num20_6, 
   per15 LIKE type_t.num20_6, 
   amt16 LIKE type_t.num20_6, 
   per16 LIKE type_t.num20_6, 
   amt17 LIKE type_t.num20_6, 
   per17 LIKE type_t.num20_6, 
   amt18 LIKE type_t.num20_6, 
   per18 LIKE type_t.num20_6, 
   amt19 LIKE type_t.num20_6, 
   per19 LIKE type_t.num20_6, 
   amt20 LIKE type_t.num20_6, 
   per20 LIKE type_t.num20_6, 
   amt21 LIKE type_t.num20_6, 
   per21 LIKE type_t.num20_6, 
   amt22 LIKE type_t.num20_6, 
   per22 LIKE type_t.num20_6, 
   amt23 LIKE type_t.num20_6, 
   per23 LIKE type_t.num20_6, 
   amt24 LIKE type_t.num20_6, 
   per24 LIKE type_t.num20_6, 
   amt25 LIKE type_t.num20_6, 
   per25 LIKE type_t.num20_6, 
   amt26 LIKE type_t.num20_6, 
   per26 LIKE type_t.num20_6, 
   amt27 LIKE type_t.num20_6, 
   per27 LIKE type_t.num20_6, 
   amt28 LIKE type_t.num20_6, 
   per28 LIKE type_t.num20_6, 
   amt29 LIKE type_t.num20_6, 
   per29 LIKE type_t.num20_6, 
   amt30 LIKE type_t.num20_6, 
   per30 LIKE type_t.num20_6, 
   samt LIKE type_t.num20_6, 
   sper LIKE type_t.num20_6, 
   glfb008 LIKE glfb_t.glfb008, 
   glfb010 LIKE glfb_t.glfb010
       END RECORD
PRIVATE TYPE type_g_detail2 RECORD
       glfbseq LIKE glfb_t.glfbseq, 
   glfb002 LIKE glfb_t.glfb002, 
   glfb002_2_desc LIKE type_t.chr500, 
   glfb003 LIKE glfb_t.glfb003, 
   amt201 LIKE type_t.num20_6, 
   per201 LIKE type_t.num20_6, 
   amt202 LIKE type_t.num20_6, 
   per202 LIKE type_t.num20_6, 
   amt203 LIKE type_t.num20_6, 
   per203 LIKE type_t.num20_6, 
   amt204 LIKE type_t.num20_6, 
   per204 LIKE type_t.num20_6, 
   amt205 LIKE type_t.num20_6, 
   per205 LIKE type_t.num20_6, 
   amt206 LIKE type_t.num20_6, 
   per206 LIKE type_t.num20_6, 
   amt207 LIKE type_t.num20_6, 
   per207 LIKE type_t.num20_6, 
   amt208 LIKE type_t.num26_10, 
   per208 LIKE type_t.num20_6, 
   amt209 LIKE type_t.num20_6, 
   per209 LIKE type_t.num20_6, 
   amt210 LIKE type_t.num20_6, 
   per210 LIKE type_t.num20_6, 
   amt211 LIKE type_t.num20_6, 
   per211 LIKE type_t.num20_6, 
   amt212 LIKE type_t.num20_6, 
   per212 LIKE type_t.num20_6, 
   amt213 LIKE type_t.num20_6, 
   per213 LIKE type_t.num20_6, 
   amt214 LIKE type_t.num20_6, 
   per214 LIKE type_t.num20_6, 
   amt215 LIKE type_t.num20_6, 
   per215 LIKE type_t.num20_6, 
   amt216 LIKE type_t.num20_6, 
   per216 LIKE type_t.num20_6, 
   amt217 LIKE type_t.num20_6, 
   per217 LIKE type_t.num20_6, 
   amt218 LIKE type_t.num20_6, 
   per218 LIKE type_t.num20_6, 
   amt219 LIKE type_t.num20_6, 
   per219 LIKE type_t.num20_6, 
   amt220 LIKE type_t.num20_6, 
   per220 LIKE type_t.num20_6, 
   amt221 LIKE type_t.num20_6, 
   per221 LIKE type_t.num20_6, 
   amt222 LIKE type_t.num20_6, 
   per222 LIKE type_t.num20_6, 
   amt223 LIKE type_t.num20_6, 
   per223 LIKE type_t.num20_6, 
   amt224 LIKE type_t.num20_6, 
   per224 LIKE type_t.num20_6, 
   amt225 LIKE type_t.num20_6, 
   per225 LIKE type_t.num20_6, 
   amt226 LIKE type_t.num20_6, 
   per226 LIKE type_t.num20_6, 
   amt227 LIKE type_t.num20_6, 
   per227 LIKE type_t.num20_6, 
   amt228 LIKE type_t.num20_6, 
   per228 LIKE type_t.num20_6, 
   amt229 LIKE type_t.num20_6, 
   per229 LIKE type_t.num20_6, 
   amt230 LIKE type_t.num20_6, 
   per230 LIKE type_t.num20_6, 
   samt2 LIKE type_t.num20_6, 
   sper2 LIKE type_t.num20_6
       END RECORD
 
PRIVATE TYPE type_g_detail3 RECORD
       glfbseq LIKE glfb_t.glfbseq, 
   glfb002 LIKE glfb_t.glfb002, 
   glfb002_3_desc LIKE type_t.chr500, 
   glfb003 LIKE glfb_t.glfb003, 
   amt301 LIKE type_t.num20_6, 
   per301 LIKE type_t.num20_6, 
   amt302 LIKE type_t.num20_6, 
   per302 LIKE type_t.num20_6, 
   amt303 LIKE type_t.num20_6, 
   per303 LIKE type_t.num20_6, 
   amt304 LIKE type_t.num20_6, 
   per304 LIKE type_t.num20_6, 
   amt305 LIKE type_t.num20_6, 
   per305 LIKE type_t.num20_6, 
   amt306 LIKE type_t.num20_6, 
   per306 LIKE type_t.num20_6, 
   amt307 LIKE type_t.num20_6, 
   per307 LIKE type_t.num20_6, 
   amt308 LIKE type_t.num20_6, 
   per308 LIKE type_t.num20_6, 
   amt309 LIKE type_t.num20_6, 
   per309 LIKE type_t.num20_6, 
   amt310 LIKE type_t.num20_6, 
   per310 LIKE type_t.num20_6, 
   amt311 LIKE type_t.num20_6, 
   per311 LIKE type_t.num20_6, 
   amt312 LIKE type_t.num20_6, 
   per312 LIKE type_t.num20_6, 
   amt313 LIKE type_t.num20_6, 
   per313 LIKE type_t.num20_6, 
   amt314 LIKE type_t.num20_6, 
   per314 LIKE type_t.num20_6, 
   amt315 LIKE type_t.num20_6, 
   per315 LIKE type_t.num20_6, 
   amt316 LIKE type_t.num20_6, 
   per316 LIKE type_t.num20_6, 
   amt317 LIKE type_t.num20_6, 
   per317 LIKE type_t.num20_6, 
   amt318 LIKE type_t.num20_6, 
   per318 LIKE type_t.num20_6, 
   amt319 LIKE type_t.num20_6, 
   per319 LIKE type_t.num20_6, 
   amt320 LIKE type_t.num20_6, 
   per320 LIKE type_t.num20_6, 
   amt321 LIKE type_t.num20_6, 
   per321 LIKE type_t.num20_6, 
   amt322 LIKE type_t.num20_6, 
   per322 LIKE type_t.num20_6, 
   amt323 LIKE type_t.num20_6, 
   per323 LIKE type_t.num20_6, 
   amt324 LIKE type_t.num20_6, 
   per324 LIKE type_t.num20_6, 
   amt325 LIKE type_t.num20_6, 
   per325 LIKE type_t.num20_6, 
   amt326 LIKE type_t.num20_6, 
   per326 LIKE type_t.num20_6, 
   amt327 LIKE type_t.num20_6, 
   per327 LIKE type_t.num20_6, 
   amt328 LIKE type_t.num20_6, 
   per328 LIKE type_t.num20_6, 
   amt329 LIKE type_t.num20_6, 
   per329 LIKE type_t.num20_6, 
   amt330 LIKE type_t.num20_6, 
   per330 LIKE type_t.num20_6, 
   samt3 LIKE type_t.num20_6, 
   sper3 LIKE type_t.num20_6
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE tm                   RECORD
       glfa001              LIKE glfa_t.glfa001,
       glfa001_desc         LIKE glfal_t.glfal003,
       glfa005              LIKE type_t.chr1000,
       glfa005_desc         LIKE glaal_t.glaal002,       
       ctype                LIKE type_t.chr1,
       glaa001              LIKE glaa_t.glaa001,
       glaa016              LIKE glaa_t.glaa016,
       glaa020              LIKE glaa_t.glaa020,
       syear                LIKE glfa_t.glfa010,
       smonth               LIKE glfa_t.glfa011,
       eyear                LIKE glfa_t.glfa010,
       emonth               LIKE glfa_t.glfa011,
       fix_type             LIKE type_t.chr2,
       fix_acc              LIKE type_t.chr1000,
       stus                 LIKE type_t.chr1,
       show_ad              LIKE type_t.chr1,
       show_per             LIKE type_t.chr1,
       glfa008              LIKE glfa_t.glfa008,
       glfa009              LIKE glfa_t.glfa009,
       show_xrbl            LIKE type_t.chr1,
       chg_curr             LIKE type_t.chr1,
       curr                 LIKE glaq_t.glaq005,
       rate                 LIKE glaq_t.glaq006 
       END RECORD
       
DEFINE g_glfa_m            DYNAMIC ARRAY OF RECORD
       glfa005             LIKE glfa_t.glfa005,
       fix_acc             LIKE type_t.chr1000,
       glad0171            LIKE glad_t.glad0171
       END RECORD 

DEFINE g_glfa002            LIKE glfa_t.glfa002
DEFINE g_glfa004            LIKE glfa_t.glfa004
DEFINE g_str                STRING
DEFINE g_field              LIKE type_t.chr100
DEFINE g_field_1            LIKE type_t.chr100
DEFINE g_field_2            LIKE type_t.chr100
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master            type_g_master
DEFINE g_master_t          type_g_master
 
   
 
DEFINE g_detail            DYNAMIC ARRAY OF type_g_detail
DEFINE g_detail_t          type_g_detail
DEFINE g_detail2     DYNAMIC ARRAY OF type_g_detail2
DEFINE g_detail2_t   type_g_detail2
 
DEFINE g_detail3     DYNAMIC ARRAY OF type_g_detail3
DEFINE g_detail3_t   type_g_detail3
 
 
 
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                 STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_cnt_sql             STRING                        #組 sql 用 
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL    
DEFINE g_cnt                 LIKE type_t.num10              
DEFINE l_ac                  LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數
DEFINE g_current_row         LIKE type_t.num10             #目前所在筆數
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_page                STRING                        #第幾頁
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_master_idx          LIKE type_t.num10
DEFINE g_detail_idx          LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail_idx2         LIKE type_t.num10
DEFINE g_hyper_url           STRING                        #hyperlink的主要網址
DEFINE g_msg                 STRING
DEFINE g_jump                LIKE type_t.num10
DEFINE g_no_ask              LIKE type_t.num5
DEFINE g_row_count           LIKE type_t.num10
DEFINE g_qbe_hidden          LIKE type_t.num5              #qbe頁籤折疊
DEFINE g_tot_cnt             LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page         LIKE type_t.num10             #每頁筆數
DEFINE g_page_act_list       STRING                        #分頁ACTION清單
DEFINE g_current_row_tot     LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_start_num      LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num        LIKE type_t.num10             #目前頁面結束筆數
DEFINE g_master_row_move     LIKE type_t.chr1              #是否為單頭筆數更動
 
#多table用wc
DEFINE g_wc_table           STRING
DEFINE g_detail_page_action STRING
DEFINE g_pagestart          LIKE type_t.num10
 
 
 
DEFINE g_wc_filter_table           STRING
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aglq852.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("agl","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " ", 
                      " FROM ",
                      " "
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq852_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglq852_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq852_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq852 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq852_init()   
 
      #進入選單 Menu (="N")
      CALL aglq852_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq852
      
   END IF 
   
   CLOSE aglq852_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglq852.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aglq852_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_str1,l_str2    STRING
   DEFINE l_i              LIKE type_t.num5
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_master_row_move = "Y"
   
      CALL cl_set_combo_scc('b_glfb010','9994') 
  
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('fix_type','9934')
   CALL cl_set_combo_scc('stus','9922')
   CALL cl_set_combo_scc('glfa008','8705')
   FOR l_i = 1 TO 30 
      #金额   
      IF NOT cl_null(l_str1) THEN LET l_str1 = l_str1 CLIPPED,"," END IF
      LET l_str1 = l_str1,"amt",l_i USING '<<<<' CLIPPED
      #百分比
      IF NOT cl_null(l_str2) THEN LET l_str2 = l_str2 CLIPPED,"," END IF
      LET l_str2 = l_str2,"per",l_i USING '<<<<' CLIPPED
   END FOR
   CALL cl_set_comp_visible(l_str1,FALSE)
   CALL cl_set_comp_visible(l_str2,FALSE)
   #end add-point
 
   CALL aglq852_default_search()
END FUNCTION
 
{</section>}
 
{<section id="aglq852.default_search" >}
PRIVATE FUNCTION aglq852_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq852.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aglq852_ui_dialog() 
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10
   DEFINE ls_result STRING
   DEFINE la_param  RECORD
                    prog       STRING,
                    actionid   STRING,
                    background LIKE type_t.chr1,
                    param      DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE ls_wc     STRING
   DEFINE lc_action_choice_old    STRING
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   
   #end add-point
 
   CLEAR FORM  
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
 
   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   LET g_current_idx = 1
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   LET g_current_row_tot = 0
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   LET g_master_row_move = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
 
   #end add-point
 
   
 
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      CALL aglq852_cs()
   END IF
 
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         INITIALIZE g_master.* TO NULL
         CALL g_detail.clear()
         CALL g_detail2.clear()
 
         CALL g_detail3.clear()
 
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 0
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_master_row_move = "Y"
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL aglq852_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         
         #end add-point
     
         DISPLAY ARRAY g_detail TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL aglq852_detail_action_trans()
               LET g_master_idx = l_ac
               CALL aglq852_b_fill2()
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_detail2 TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 2
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body2.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_detail3 TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 3
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body3.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_3)
            
 
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段define name="ui_dialog.more_displayarray"
         
         #end add-point
    
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            CALL aglq852_fetch('')
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible("output",FALSE)
            CALL aglq852_query()
            CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
            NEXT FIELD b_glfb003
            #end add-point
            NEXT FIELD glfa001
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
            
            #end add-point
            
         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG 
      
         ON ACTION close
            LET INT_FLAG=FALSE
            LET li_exit = TRUE
            EXIT DIALOG
 
         ON ACTION accept
            INITIALIZE g_wc_filter TO NULL
            IF cl_null(g_wc) THEN
               LET g_wc = " 1=1"
            END IF
 
 
   
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF
 
 
 
            #add-point:ON ACTION accept name="ui_dialog.accept"
            ACCEPT DIALOG
            #end add-point
 
            CALL aglq852_cs()
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"
            
            #end add-point
            CALL cl_user_overview()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_detail)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_detail2)
               LET g_export_id[2]   = "s_detail2"
 
               LET g_export_node[3] = base.typeInfo.create(g_detail3)
               LET g_export_id[3]   = "s_detail3"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #end add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
 
         ON ACTION datarefresh   # 重新整理
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq852_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION qbehidden     #qbe頁籤折疊
            IF g_qbe_hidden THEN
               CALL gfrm_curr.setElementHidden("qbe",0)
               CALL gfrm_curr.setElementImage("qbehidden","16/mainhidden.png")
               LET g_qbe_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("qbe",1)
               CALL gfrm_curr.setElementImage("qbehidden","16/worksheethidden.png")
               LET g_qbe_hidden = 1     #hidden
            END IF
 
         ON ACTION datainfo   #串查至主維護程式
            #add-point:ON ACTION datainfo name="ui_dialog.datainfo"
            
            #end add-point
            CALL aglq852_maintain_prog()
 
         ON ACTION first   # 第一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq852_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION previous   # 上一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq852_fetch('P')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION jump   # 跳至第幾筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq852_fetch('/')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION next   # 下一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq852_fetch('N')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION last   # 最後一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq852_fetch('L')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            LET g_master_row_move = "N"
            CALL aglq852_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            LET g_master_row_move = "N"
            CALL aglq852_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            LET g_master_row_move = "N"
            CALL aglq852_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            LET g_master_row_move = "N"
            CALL aglq852_b_fill()
 
         
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_detail.getLength()
               LET g_detail[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail.getLength()
               LET g_detail[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query name="menu.query"
               CALL aglq852_query()
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               #END add-point
               
               
            END IF
 
 
 
 
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"
         
         #end add-point
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            #add-point:條件清除後 name="ui_dialog.qbeclear"
            
            #end add-point 
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         
         #end add-point 
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="aglq852.cs" >}
#+ 組單頭CURSOR
PRIVATE FUNCTION aglq852_cs()
   #add-point:cs段define-客製 name="cs.define_customerization"
   
   #end add-point
   #add-point:cs段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   DEFINE l_sql          STRING
   DEFINE l_sql1         STRING
   DEFINE l_str          STRING
   DEFINE l_str_fix      STRING
   DEFINE l_str_fix_1    STRING
   DEFINE l_num          LIKE type_t.num5
   
   LET g_field="''"
   LET g_field_1="''"
   LET g_field_2="''"
   #設置核算項查詢條件
   #帳套+核算項
   IF NOT cl_null(tm.fix_type) THEN
      CASE tm.fix_type
         WHEN '1' #營運據點
            LET g_field="glar012"
            LET g_field_1="glaq017"
         WHEN '2' #部門
            LET g_field="glar013"
            LET g_field_1="glaq018"
         WHEN '3' #利潤/成本中心
            LET g_field="glar014"
            LET g_field_1="glaq019"
         WHEN '4' #區域
            LET g_field="glar015"
            LET g_field_1="glaq020"
         WHEN '5' #交易客商
            LET g_field="glar016"
            LET g_field_1="glaq021"
         WHEN '6' #帳款客戶
            LET g_field="glar017"
            LET g_field_1="glaq022"
         WHEN '7' #客群
            LET g_field="glar018"
            LET g_field_1="glaq023"
         WHEN '8' #產品類別
            LET g_field="glar019"
            LET g_field_1="glaq024"
         WHEN '9' #經營方式
            LET g_field="glar051"
            LET g_field_1="glaq051"
         WHEN '10' #渠道
            LET g_field="glar052"
            LET g_field_1="glaq052"
         WHEN '11' #品牌
            LET g_field="glar053" 
            LET g_field_1="glaq053"
         WHEN '12' #人員
            LET g_field="glar020"
            LET g_field_1="glaq025"
         WHEN '13' #專案
            LET g_field="glar022"
            LET g_field_1="glaq027"
         WHEN '14' #WBS
            LET g_field="glar023"
            LET g_field_1="glaq028"
         WHEN '15' #自由核算項一
            LET g_field="glar024"
            LET g_field_1="glaq029"
            LET g_field_2="glad0171"
         WHEN '16' #自由核算項二
            LET g_field="glar025"
            LET g_field_1="glaq030"
            LET g_field_2="glad0181"
         WHEN '17' #自由核算項三
            LET g_field="glar026"
            LET g_field_1="glaq031"
            LET g_field_2="glad0191"
         WHEN '18' #自由核算項四
            LET g_field="glar027"
            LET g_field_1="glaq032"
            LET g_field_2="glad0201"
         WHEN '19' #自由核算項五
            LET g_field="glar028"
            LET g_field_1="glaq033"
            LET g_field_2="glad0211"
         WHEN '20' #自由核算項六
            LET g_field="glar029"
            LET g_field_1="glaq034"
            LET g_field_2="glad0221"
         WHEN '21' #自由核算項七
            LET g_field="glar030"
            LET g_field_1="glaq035"
            LET g_field_2="glad0231"
         WHEN '22' #自由核算項八
            LET g_field="glar031"
            LET g_field_1="glaq036"
            LET g_field_2="glad0241"
         WHEN '23' #自由核算項九
            LET g_field="glar032"
            LET g_field_1="glaq037"
            LET g_field_2="glad0251"
         WHEN '24' #自由核算項十
            LET g_field="glar033"
            LET g_field_1="glaq038"
            LET g_field_2="glad0261"
      END CASE
      #核算項條件
      IF NOT cl_null(tm.fix_acc) THEN
         LET l_str=tm.fix_acc
         LET l_num =l_str.getIndexOf('*',1)
         IF l_num>0 THEN
            LET l_str=cl_replace_str(tm.fix_acc,"*","%")
            LET l_str_fix=" AND ",g_field," LIKE '",l_str,"' "
            LET l_str_fix_1=" AND ",g_field_1," LIKE '",l_str,"' "
         ELSE
            LET l_str=cl_replace_str(tm.fix_acc,"|","','")
            LET l_str="'",l_str_fix,"'" 
            LET l_str_fix=" AND ",g_field," IN (",l_str,")"
            LET l_str_fix_1=" AND ",g_field_1," IN (",l_str,")"
         END IF
      ELSE
         IF tm.fix_type='1' OR tm.fix_type='2' OR tm.fix_type='3' OR tm.fix_type='4' OR tm.fix_type='5' OR
            tm.fix_type='6' OR tm.fix_type='7' OR tm.fix_type='8' OR tm.fix_type='9' OR tm.fix_type='10' OR
            tm.fix_type='11' OR tm.fix_type='12' OR tm.fix_type='13' OR tm.fix_type='14'  THEN
            LET l_str_fix=" AND ",g_field," <> ' ' "
            LET l_str_fix_1=" AND ",g_field_1," <> ' ' "
         END IF
      END IF
   END IF
   
   IF tm.stus='1' AND tm.show_ad ='Y' THEN
      LET l_sql1="SELECT DISTINCT glaald,",g_field,",",g_field_2,
                 "  FROM glaa_t,glar_t"
      IF tm.fix_type='15' OR tm.fix_type='16' OR tm.fix_type='17' OR tm.fix_type='18' OR tm.fix_type='19' OR
         tm.fix_type='20' OR tm.fix_type='21' OR tm.fix_type='22' OR tm.fix_type='23' OR tm.fix_type='24' THEN
         LET l_sql1=l_sql1,"  LEFT OUTER JOIN glad_t ON gladent=glarent AND gladld=glarld AND glad001=glar001"
      END IF
      LET l_sql1=l_sql1," WHERE glaaent=glarent AND glaald=glarld ",
                        "   AND glaald IN (",g_str,")"
      #核算项条件
      IF NOT cl_null(tm.fix_type) THEN
         IF NOT cl_null(l_str_fix) THEN
            LET l_sql1=l_sql1,l_str_fix
         END IF
      END IF
      #勾选的本位币
      CASE tm.ctype
         WHEN '1' #本位币二
            LET l_sql1=l_sql1," AND glaa015='Y' AND glaa016 IS NOT NULL"
         WHEN '2' #本位币三
            LET l_sql1=l_sql1," AND glaa019='Y' AND glaa020 IS NOT NULL"
      END CASE
      #日期范围
      #当报表模板类型为資產負債類时，抓取到截止年期的余额档资料；当报表模板类型为损益表时，抓取起始截止年期范围的余额档资料
      IF g_glfa002 = '1' THEN
         IF tm.syear=tm.eyear THEN
            LET l_sql=l_sql1," AND glar002=",tm.eyear," AND glar003 <=",tm.emonth
         ELSE
            #跨年时分段组合查询
            LET l_sql="(",l_sql1," AND glar002<",tm.eyear,")"
            
            LET l_sql=l_sql," UNION ",
                            " (",l_sql1," AND glar002 = ",tm.eyear," AND glar003 <= ",tm.emonth," )"
         END IF
         
      ELSE
         IF tm.syear=tm.eyear THEN
            LET l_sql=l_sql1," AND glar002=",tm.syear," AND glar003 BETWEEN ",tm.smonth," AND ",tm.emonth
         ELSE
            #跨年时分段组合查询
            LET l_sql="(",l_sql1," AND glar002=",tm.syear," AND glar003>= ",tm.smonth,")"
            IF tm.syear + 1 < tm.eyear THEN
               LET l_sql=l_sql," UNION ",
                               " (",l_sql1," AND glar002 > ",tm.syear," AND glar002 < ",tm.eyear," )"
            END IF
            
            LET l_sql=l_sql," UNION ",
                            " (",l_sql1," AND glar002 = ",tm.eyear," AND glar003 <= ",tm.emonth," )"
         END IF
      END IF
   ELSE
      IF cl_null(g_field_1) OR g_field_1 = "''" THEN
         LET l_sql1="SELECT DISTINCT glaald,",g_field_1,",",g_field_2
      ELSE
         LET l_sql1="SELECT DISTINCT glaald,",g_field_1," ",g_field,",",g_field_2
      END IF
      LET l_sql1=l_sql1," FROM glaa_t,glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno"
      IF tm.fix_type='15' OR tm.fix_type='16' OR tm.fix_type='17' OR tm.fix_type='18' OR tm.fix_type='19' OR
         tm.fix_type='20' OR tm.fix_type='21' OR tm.fix_type='22' OR tm.fix_type='23' OR tm.fix_type='24' THEN
         LET l_sql1=l_sql1,"  LEFT OUTER JOIN glad_t ON gladent=glaqent AND gladld=glaqld AND glad001=glaq002"
      END IF    
      LET l_sql1=l_sql1," WHERE glaaent=glapent AND glaald=glapld ",
                        "   AND glaald IN (",g_str,")"
      #核算项条件
      IF NOT cl_null(tm.fix_type) THEN
         IF NOT cl_null(l_str_fix_1) THEN
            LET l_sql1=l_sql1,l_str_fix_1
         END IF
      END IF
      #单据状态
      CASE tm.stus
         WHEN '2'
            LET l_sql1=l_sql1," AND glapstus IN ('S','Y')"
         WHEN '3'
            LET l_sql1=l_sql1," AND glapstus IN ('S','Y','N')"
      END CASE
      #不包含AD审计凭证
      IF tm.show_ad='N' THEN
         LET l_sql1=l_sql1," AND glap007 <> 'AD' "
      END IF
      #勾选的本位币
      CASE tm.ctype
         WHEN '1' #本位币二
            LET l_sql1=l_sql1," AND glaa015='Y' AND glaa016 IS NOT NULL"
         WHEN '2' #本位币三
            LET l_sql1=l_sql1," AND glaa019='Y' AND glaa020 IS NOT NULL"
      END CASE
      #日期范围
      #当报表模板类型为資產負債類时，抓取到截止年期的凭证资料；当报表模板类型为损益表时，抓取起始截止年期范围的凭证资料
      IF g_glfa002 = '1' THEN
         IF tm.syear=tm.eyear THEN
            LET l_sql=l_sql1," AND glap002=",tm.eyear," AND glap004 <= ",tm.emonth
         ELSE
            #跨年时分段组合查询
            LET l_sql="(",l_sql1," AND glap002<=",tm.eyear,")"            
            LET l_sql=l_sql," UNION ",
                            " (",l_sql1," AND glap002 = ",tm.eyear," AND glap004 <= ",tm.emonth," )"
         END IF
      ELSE
         IF tm.syear=tm.eyear THEN
            LET l_sql=l_sql1," AND glap002=",tm.syear," AND glap004 BETWEEN ",tm.smonth," AND ",tm.emonth
         ELSE
            #跨年时分段组合查询
            LET l_sql="(",l_sql1," AND glap002=",tm.syear," AND glap004>= ",tm.smonth,")"
            IF tm.syear + 1 < tm.eyear THEN
               LET l_sql=l_sql," UNION ",
                               " (",l_sql1," AND glap002 > ",tm.syear," AND glap002 < ",tm.eyear," )"
            END IF
            LET l_sql=l_sql," UNION ",
                            " (",l_sql1," AND glap002 = ",tm.eyear," AND glap004 <= ",tm.emonth," )"
         END IF
      END IF
   END IF
   
   
   LET g_sql="SELECT DISTINCT glaald,",g_field,",",g_field_2," FROM (",l_sql,")",
             " ORDER BY glaald,",g_field,",",g_field_2
   PREPARE aglq852_pr FROM g_sql
   DECLARE aglq852_cs CURSOR FOR aglq852_pr
   #end add-point
 
   #add-point:FUNCTION前置處理 name="cs.before_function"
   
   #end add-point
 
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   IF g_wc2 = " 1=1" THEN
      #add-point:cs段單頭sql組成(未下單身條件) name="cs.sql_define_1"
      
      #end add-point
   ELSE
      #add-point:cs段單頭sql組成(有下單身條件) name="cs.sql_define_2"
      
      #end add-point
   END IF
 
   PREPARE aglq852_pre FROM g_sql
   DECLARE aglq852_curs SCROLL CURSOR WITH HOLD FOR aglq852_pre
   OPEN aglq852_curs
 
   #add-point:cs段單頭總筆數計算 name="cs.head_total_row_count"
   CALL g_glfa_m.clear()
   LET g_cnt = 1
   FOREACH aglq852_cs INTO g_glfa_m[g_cnt].glfa005,g_glfa_m[g_cnt].fix_acc,g_glfa_m[g_cnt].glad0171
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'aglq710_sel_pr1'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      LET g_cnt=g_cnt + 1
   END FOREACH
   LET g_cnt = g_cnt - 1
   CALL g_glfa_m.deleteElement(g_glfa_m.getLength())
   
   IF g_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = -100
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      LET g_row_count=0
      RETURN
   END IF
   LET g_cnt_sql="SELECT COUNT(*) FROM (",l_sql,")"
   #end add-point
   PREPARE aglq852_precount FROM g_cnt_sql
   EXECUTE aglq852_precount INTO g_row_count
 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = SQLCA.SQLCODE 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
   ELSE
      CALL aglq852_fetch("F")
   END IF
END FUNCTION
 
{</section>}
 
{<section id="aglq852.fetch" >}
#+ 抓取單頭資料
PRIVATE FUNCTION aglq852_fetch(p_flag)
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
   MESSAGE ""
 
   #FETCH段CURSOR移動
   #應用 qs18 樣板自動產生(Version:3)
   #add-point:fetch段CURSOR移動 name="fetch.cursor_action"
   IF cl_null(p_flag) THEN RETURN END IF
   IF g_row_count=0 THEN RETURN END IF
   #end add-point
 
 
 
 
 
   IF SQLCA.sqlcode THEN
      # 清空右側畫面欄位值，但須保留左側qbe查詢條件
      INITIALIZE g_master.* TO NULL
      DISPLAY g_master.* TO glfa_t.glfa006
      CALL g_detail.clear()
      CALL g_detail2.clear()
 
      CALL g_detail3.clear()
 
 
      #add-point:陣列清空 name="fetch.array_clear"
      
      #end add-point
      DISPLAY '' TO FORMONLY.h_index
      DISPLAY '' TO FORMONLY.h_count
      DISPLAY '' TO FORMONLY.idx
      DISPLAY '' TO FORMONLY.cnt
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = '-100' 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      RETURN
   ELSE
      CASE p_flag
         WHEN 'F' LET g_current_idx = 1
         WHEN 'P' LET g_current_idx = g_current_idx - 1
         WHEN 'N' LET g_current_idx = g_current_idx + 1
         WHEN 'L' LET g_current_idx = g_row_count
         WHEN '/' LET g_current_idx = g_jump
      END CASE
      DISPLAY g_current_idx TO FORMONLY.h_index
      DISPLAY g_row_count TO FORMONLY.h_count
      CALL cl_navigator_setting( g_current_idx, g_row_count )
   END IF
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   LET g_master_row_move = "Y"
   #重新顯示
   CALL aglq852_show()
 
END FUNCTION
 
{</section>}
 
{<section id="aglq852.show" >}
PRIVATE FUNCTION aglq852_show()
   #add-point:show段define-客製 name="show.define_customerization"
   
   #end add-point
   DEFINE ls_sql    STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE lc_fix_desc     STRING
   #end add-point
 
   #add-point:FUNCTION前置處理 name="show.before_function"
   
   #end add-point
 
   DISPLAY g_master.* TO glfa_t.glfa006
 
   #讀入ref值
   #add-point:show段單身reference name="show.head.reference"
   #报表模板说明
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = tm.glfa001
   CALL ap_ref_array2(g_ref_fields," SELECT glfal003 FROM glfal_t WHERE glfalent = '"
       ||g_enterprise||"' AND glfal001 = ? AND glfal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
   LET tm.glfa001_desc = g_rtn_fields[1]
   
   IF g_current_idx > 0 THEN
      #账套
      LET tm.glfa005=g_glfa_m[g_current_idx].glfa005
      CALL s_desc_get_ld_desc(tm.glfa005) RETURNING tm.glfa005_desc
      #币别
      SELECT glaa001,glaa016,glaa020 INTO tm.glaa001,tm.glaa016,tm.glaa020 FROM glaa_t 
       WHERE glaaent=g_enterprise AND glaald=tm.glfa005
      #核算项
      LET tm.fix_acc=g_glfa_m[g_current_idx].fix_acc
      IF NOT cl_null(tm.fix_acc) THEN
         CASE tm.fix_type
            WHEN '1' #營運據點
               CALL s_desc_get_department_desc(tm.fix_acc) RETURNING lc_fix_desc
            WHEN '2' #部門
               CALL s_desc_get_department_desc(tm.fix_acc) RETURNING lc_fix_desc
            WHEN '3' #利潤成本中心
               CALL s_desc_get_department_desc(tm.fix_acc) RETURNING lc_fix_desc
            WHEN '4' #區域
               CALL s_desc_get_acc_desc('287',tm.fix_acc) RETURNING lc_fix_desc 
            WHEN '5' #交易客商
               CALL s_desc_get_trading_partner_abbr_desc(tm.fix_acc) RETURNING lc_fix_desc
            WHEN '6' #帳款客戶
               CALL s_desc_get_trading_partner_abbr_desc(tm.fix_acc) RETURNING lc_fix_desc
            WHEN '7' #客群
               CALL s_desc_get_acc_desc('281',tm.fix_acc) RETURNING lc_fix_desc
            WHEN '8' #產品分類
               CALL s_desc_get_rtaxl003_desc(tm.fix_acc) RETURNING lc_fix_desc
            WHEN '9' #经营方式
               CALL s_desc_gzcbl004_desc('6013',tm.fix_acc) RETURNING lc_fix_desc
            WHEN '10' #渠道
               CALL s_desc_get_oojdl003_desc(tm.fix_acc) RETURNING lc_fix_desc
            WHEN '11' #品牌
               CALL s_desc_get_acc_desc('2002',tm.fix_acc) RETURNING lc_fix_desc
            WHEN '12' #人員
               CALL s_desc_get_person_desc(tm.fix_acc) RETURNING lc_fix_desc
            WHEN '13' #专案
               CALL s_desc_get_project_desc(tm.fix_acc) RETURNING lc_fix_desc
            WHEN '14' #WBS
               #CALL s_desc_get_wbs_desc('',g_glfbtext[1].detail[l_i].fix) RETURNING lc_fix_desc
               LET lc_fix_desc = ""
         END CASE
         IF tm.fix_type='15' OR tm.fix_type='16' OR tm.fix_type='17' OR tm.fix_type='18' OR tm.fix_type='19' OR
            tm.fix_type='20' OR tm.fix_type='21' OR tm.fix_type='22' OR tm.fix_type='23' OR tm.fix_type='24' THEN
            CALL s_voucher_free_account_desc(g_glfa_m[g_current_idx].glad0171,tm.fix_acc) 
            RETURNING lc_fix_desc
         END IF 
         LET tm.fix_acc = tm.fix_acc," ",lc_fix_desc
      END IF
   END IF
   DISPLAY BY NAME tm.glfa001,tm.glfa001_desc,tm.glfa005,tm.glfa005_desc,tm.ctype,tm.glaa001,tm.glaa016,tm.glaa020,tm.fix_acc
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   CALL aglq852_b_fill()
 
END FUNCTION
 
{</section>}
 
{<section id="aglq852.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq852_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_flag          LIKE type_t.num5
   DEFINE l_flag_fm       LIKE type_t.num5
   DEFINE l_amt_fm        LIKE type_t.num20_6
   DEFINE l_col           LIKE type_t.num5
   DEFINE l_amt1          LIKE type_t.num20_6
   DEFINE l_amt2          LIKE type_t.num20_6
   DEFINE l_amt3          LIKE type_t.num20_6
   DEFINE l_year          LIKE glap_t.glap002
   DEFINE l_month         LIKE glap_t.glap004
   DEFINE l_smonth        LIKE glap_t.glap004
   DEFINE l_emonth        LIKE glap_t.glap004
   DEFINE l_max_month     LIKE glap_t.glap004
   DEFINE l_glfbseq1      LIKE glfb_t.glfbseq1
   DEFINE l_glfb004       LIKE glfb_t.glfb004
   DEFINE l_glfb005       LIKE glfb_t.glfb005
   DEFINE l_glfb009       LIKE glfb_t.glfb009
   DEFINE l_j             LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_desc          STRING
   DEFINE l_desc1         STRING
   DEFINE l_sql           STRING
   DEFINE l_str           STRING
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_str1,l_str2,l_str3   STRING
   DEFINE l_str4,l_str5,l_str6   STRING
   DEFINE l_samt1         LIKE type_t.num20_6
   DEFINE l_samt2         LIKE type_t.num20_6
   DEFINE l_samt3         LIKE type_t.num20_6
   DEFINE l_format        STRING
   DEFINE l_count         LIKE type_t.num5
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:32) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   CALL g_detail.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   CALL g_detail2.clear()
   CALL g_detail3.clear()
   #end add-point
 
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs09 樣板自動產生(Version:3)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   #add-point:b_fill段sql name="b_fill.sql"
   LET g_sql="SELECT DISTINCT 'N',glfbseq,glfbseq1,glfb002,glfbl004,glfb003,glfb004,glfb005,glfb008,glfb009,glfb010 ",
             "  FROM glfb_t ",
             "  LEFT JOIN glfbl_t ON glfbent = glfblent AND glfb001 = glfbl001 AND glfbseq = glfblseq AND glfb002 = glfbl002 AND glfbl003 = '",g_lang,"' ", 
             "  LEFT OUTER JOIN glfa_t ON glfbent = glfaent AND glfb001 = glfa001  ",
             " WHERE glfbent=",g_enterprise," AND glfb001 ='",tm.glfa001,"'"
             
   IF g_glfa002 = '2'  THEN   #損益類
#      LET g_sql=g_sql," AND glfbseq1 IN ('B')  ",  #160512-00030#1 mark
      LET g_sql=g_sql," AND glfbseq1 IN ('A')  ",   #160512-00030#1 add
                      " ORDER BY glfb003"
   END IF
   
   IF g_glfa002 = '1'  THEN   #資產負債
      LET g_sql=g_sql," AND glfbseq1 IN ('B','D')  ",
                      " ORDER BY glfbseq1,glfb003"  #161021-00015#1 add glfbseq1
   END IF
   PREPARE b_fill_pr FROM g_sql
   DECLARE b_fill_cs CURSOR FOR b_fill_pr
   
   #核算项值
   IF g_current_idx > 0 THEN
      IF NOT cl_null(g_glfa_m[g_current_idx].fix_acc) THEN
         LET l_sql = g_field,"  = '",g_glfa_m[g_current_idx].fix_acc,"'"
         IF tm.fix_type='15' OR tm.fix_type='16' OR tm.fix_type='17' OR tm.fix_type='18' OR tm.fix_type='19' OR
            tm.fix_type='20' OR tm.fix_type='21' OR tm.fix_type='22' OR tm.fix_type='23' OR tm.fix_type='24' THEN
            LET l_sql=l_sql," AND glar001 IN (SELECT DISTINCT glad001 FROM glad_t ",
                            "                  WHERE gladent=glarent AND gladld=glarld ",
                            "                    AND ",g_field_2," = '",g_glfa_m[g_current_idx].glad0171,"')"
         END IF
      END IF
   END IF   
   
   LET l_flag = TRUE   #标示第一次循环期别，设置列说明
   LET l_flag_fm = 0   #标示分母位置,存储单身资料游标
   LET l_str1=NULL
   LET l_str2=NULL
   LET l_str3=NULL
   FOREACH b_fill_cs INTO g_detail[l_ac].sel,g_detail[l_ac].glfbseq,l_glfbseq1,g_detail[l_ac].glfb002,g_detail[l_ac].glfb002_desc,
                          g_detail[l_ac].glfb003,l_glfb004,l_glfb005,g_detail[l_ac].glfb008,l_glfb009,g_detail[l_ac].glfb010
      IF SQLCA.sqlcode THEN                    
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'aglq710_sel_pr1'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      
      LET l_year=tm.syear
      LET l_smonth=tm.smonth
      IF tm.syear=tm.eyear THEN
         LET l_emonth=tm.emonth
      ELSE
         #最大期别
         LET l_max_month=NULL
         SELECT MAX(glav006) INTO l_max_month FROM glav_t
          WHERE glavent=g_enterprise AND glav002=l_year
            AND glav001=(SELECT glaa003 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=tm.glfa005)
         IF cl_null(l_max_month) THEN LET l_max_month = 12 END IF
         LET l_emonth=l_max_month
      END IF 
      LET l_j =1
      LET l_samt1 = 0 
      LET l_samt2 = 0
      LET l_samt3 = 0
      WHILE TRUE
         FOR l_month = l_smonth TO l_emonth
            #第一次循环，获取列数时，设置列说明
            IF l_flag = TRUE THEN
               IF NOT cl_null(l_str1) THEN LET l_str1 = l_str1 CLIPPED,"," END IF
               #年度+期别
               LET l_desc=l_year USING '<<<<',cl_getmsg('agl-00274',g_lang),l_month USING '<<<<',cl_getmsg('axc-00589',g_lang)
               CALL cl_set_comp_att_text("amt" || l_j,l_desc)
               #显示比率
               IF tm.show_per = 'Y' THEN
                  LET l_desc1=l_desc,cl_getmsg('axc-00659',g_lang) #比率
                  CALL cl_set_comp_att_text("per" || l_j,l_desc1)
                  LET l_str1 = l_str1,"amt" CLIPPED,l_j USING '<<<<',",per" CLIPPED,l_j USING '<<<<'
               ELSE
                  LET l_str1 = l_str1,"amt" CLIPPED,l_j USING '<<<<'
               END IF
               
               #显示本位币二三
               IF tm.ctype = '3' THEN
                  IF l_flag = TRUE THEN
                     LET l_cnt = l_j + 200
                     IF NOT cl_null(l_str2) THEN LET l_str2 = l_str2 CLIPPED,"," END IF
                     CALL cl_set_comp_att_text("amt" || l_cnt,l_desc)
                     #显示比率
                     IF tm.show_per = 'Y' THEN
                        CALL cl_set_comp_att_text("per" || l_cnt,l_desc1)
                        LET l_str2 = l_str2,"amt" CLIPPED,l_cnt USING '<<<<',",per" CLIPPED,l_cnt USING '<<<<'
                     ELSE
                        LET l_str2 = l_str2,"amt" CLIPPED,l_cnt USING '<<<<'
                     END IF
                     
                     LET l_cnt = l_j + 300
                     IF NOT cl_null(l_str3) THEN LET l_str3 = l_str3 CLIPPED,"," END IF
                     
                     CALL cl_set_comp_att_text("amt" || l_cnt,l_desc)
                     #显示比率
                     IF tm.show_per = 'Y' THEN
                        CALL cl_set_comp_att_text("per" || l_cnt,l_desc1)
                        LET l_str3 = l_str3,"amt" CLIPPED,l_cnt USING '<<<<',",per" CLIPPED,l_cnt USING '<<<<'
                     ELSE
                        LET l_str3 = l_str3,"amt" CLIPPED,l_cnt USING '<<<<'
                     END IF
                  END IF
               END IF
            END IF  
            
            #有设置公式，计算金额
            IF NOT cl_null(l_glfb005) THEN
               LET l_amt1=NULL
               LET l_amt2=NULL
               LET l_amt3=NULL
                                 #帳別      #年度  #起始期別 #截止期別 #小數位數  #單位      #報表模板編號       
               CALL s_analy_form(tm.glfa005,l_year,l_month,l_month,tm.glfa009,tm.glfa008,tm.glfa001,
                                 #取數公式來源 #計算公式 #核算项条件 #含審計調整傳票否 #傳票狀態
                                 l_glfb004,   l_glfb005,l_sql,     tm.show_ad,     tm.stus) 
               RETURNING l_success,l_amt1#,l_amt2,l_amt3
               #150827-00036#1--add--str--
               #是否進行幣別轉換
               IF tm.chg_curr='Y'  THEN
                  LET l_amt1 = l_amt1 * tm.rate
#                  LET l_amt2 = l_amt2 * tm.rate
#                  LET l_amt3 = l_amt3 * tm.rate
               END IF
               #150827-00036#1--add--end
               CASE l_j
                  WHEN 1   LET g_detail[l_ac].amt1  = l_amt1
                  WHEN 2   LET g_detail[l_ac].amt2  = l_amt1
                  WHEN 3   LET g_detail[l_ac].amt3  = l_amt1
                  WHEN 4   LET g_detail[l_ac].amt4  = l_amt1  
                  WHEN 5   LET g_detail[l_ac].amt5  = l_amt1
                  WHEN 6   LET g_detail[l_ac].amt6  = l_amt1
                  WHEN 7   LET g_detail[l_ac].amt7  = l_amt1
                  WHEN 8   LET g_detail[l_ac].amt8  = l_amt1
                  WHEN 9   LET g_detail[l_ac].amt9  = l_amt1
                  WHEN 10  LET g_detail[l_ac].amt10 = l_amt1  
                  WHEN 11  LET g_detail[l_ac].amt11 = l_amt1
                  WHEN 12  LET g_detail[l_ac].amt12 = l_amt1
                  WHEN 13  LET g_detail[l_ac].amt13 = l_amt1
                  WHEN 14  LET g_detail[l_ac].amt14 = l_amt1
                  WHEN 15  LET g_detail[l_ac].amt15 = l_amt1
                  WHEN 16  LET g_detail[l_ac].amt16 = l_amt1 
                  WHEN 17  LET g_detail[l_ac].amt17 = l_amt1
                  WHEN 18  LET g_detail[l_ac].amt18 = l_amt1           
                  WHEN 19  LET g_detail[l_ac].amt19 = l_amt1
                  WHEN 20  LET g_detail[l_ac].amt20 = l_amt1
                  WHEN 21  LET g_detail[l_ac].amt21 = l_amt1
                  WHEN 22  LET g_detail[l_ac].amt22 = l_amt1 
                  WHEN 23  LET g_detail[l_ac].amt23 = l_amt1
                  WHEN 24  LET g_detail[l_ac].amt24 = l_amt1
                  WHEN 25  LET g_detail[l_ac].amt25 = l_amt1
                  WHEN 26  LET g_detail[l_ac].amt26 = l_amt1
                  WHEN 27  LET g_detail[l_ac].amt27 = l_amt1
                  WHEN 28  LET g_detail[l_ac].amt28 = l_amt1
                  WHEN 29  LET g_detail[l_ac].amt29 = l_amt1 
                  WHEN 30  LET g_detail[l_ac].amt30 = l_amt1
               END CASE
               IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
               LET l_samt1 = l_samt1 + l_amt1
               
               IF tm.ctype = '3' THEN
                  CASE l_j
                     WHEN 1   LET g_detail2[l_ac].amt201 = l_amt2    LET g_detail3[l_ac].amt301 = l_amt3
                     WHEN 2   LET g_detail2[l_ac].amt202 = l_amt2    LET g_detail3[l_ac].amt302 = l_amt3
                     WHEN 3   LET g_detail2[l_ac].amt203 = l_amt2    LET g_detail3[l_ac].amt303 = l_amt3
                     WHEN 4   LET g_detail2[l_ac].amt204 = l_amt2    LET g_detail3[l_ac].amt304 = l_amt3
                     WHEN 5   LET g_detail2[l_ac].amt205 = l_amt2    LET g_detail3[l_ac].amt305 = l_amt3
                     WHEN 6   LET g_detail2[l_ac].amt206 = l_amt2    LET g_detail3[l_ac].amt306 = l_amt3
                     WHEN 7   LET g_detail2[l_ac].amt207 = l_amt2    LET g_detail3[l_ac].amt307 = l_amt3
                     WHEN 8   LET g_detail2[l_ac].amt208 = l_amt2    LET g_detail3[l_ac].amt308 = l_amt3
                     WHEN 9   LET g_detail2[l_ac].amt209 = l_amt2    LET g_detail3[l_ac].amt309 = l_amt3
                     WHEN 10  LET g_detail2[l_ac].amt210 = l_amt2    LET g_detail3[l_ac].amt310 = l_amt3
                     WHEN 11  LET g_detail2[l_ac].amt211 = l_amt2    LET g_detail3[l_ac].amt311 = l_amt3
                     WHEN 12  LET g_detail2[l_ac].amt212 = l_amt2    LET g_detail3[l_ac].amt312 = l_amt3
                     WHEN 13  LET g_detail2[l_ac].amt213 = l_amt2    LET g_detail3[l_ac].amt313 = l_amt3
                     WHEN 14  LET g_detail2[l_ac].amt214 = l_amt2    LET g_detail3[l_ac].amt314 = l_amt3
                     WHEN 15  LET g_detail2[l_ac].amt215 = l_amt2    LET g_detail3[l_ac].amt315 = l_amt3
                     WHEN 16  LET g_detail2[l_ac].amt216 = l_amt2    LET g_detail3[l_ac].amt316 = l_amt3
                     WHEN 17  LET g_detail2[l_ac].amt217 = l_amt2    LET g_detail3[l_ac].amt317 = l_amt3
                     WHEN 18  LET g_detail2[l_ac].amt218 = l_amt2    LET g_detail3[l_ac].amt318 = l_amt3      
                     WHEN 19  LET g_detail2[l_ac].amt219 = l_amt2    LET g_detail3[l_ac].amt319 = l_amt3
                     WHEN 20  LET g_detail2[l_ac].amt220 = l_amt2    LET g_detail3[l_ac].amt320 = l_amt3
                     WHEN 21  LET g_detail2[l_ac].amt221 = l_amt2    LET g_detail3[l_ac].amt321 = l_amt3
                     WHEN 22  LET g_detail2[l_ac].amt222 = l_amt2    LET g_detail3[l_ac].amt322 = l_amt3
                     WHEN 23  LET g_detail2[l_ac].amt223 = l_amt2    LET g_detail3[l_ac].amt323 = l_amt3
                     WHEN 24  LET g_detail2[l_ac].amt224 = l_amt2    LET g_detail3[l_ac].amt324 = l_amt3
                     WHEN 25  LET g_detail2[l_ac].amt225 = l_amt2    LET g_detail3[l_ac].amt325 = l_amt3
                     WHEN 26  LET g_detail2[l_ac].amt226 = l_amt2    LET g_detail3[l_ac].amt326 = l_amt3
                     WHEN 27  LET g_detail2[l_ac].amt227 = l_amt2    LET g_detail3[l_ac].amt327 = l_amt3
                     WHEN 28  LET g_detail2[l_ac].amt228 = l_amt2    LET g_detail3[l_ac].amt328 = l_amt3
                     WHEN 29  LET g_detail2[l_ac].amt229 = l_amt2    LET g_detail3[l_ac].amt329 = l_amt3
                     WHEN 30  LET g_detail2[l_ac].amt230 = l_amt2    LET g_detail3[l_ac].amt330 = l_amt3
                  END CASE
                  IF cl_null(l_samt2) THEN LET l_samt2=0 END IF
                  IF cl_null(l_samt3) THEN LET l_samt3= 0 END IF
                  LET l_samt2 = l_samt2 + l_amt2
                  LET l_samt3 = l_samt3 + l_amt3
               END IF
            END IF
            
            LET l_j = l_j + 1
         END FOR
         
         LET l_year = l_year + 1
         IF l_year < tm.eyear THEN
            LET l_smonth = 1
            #最大期别
            LET l_max_month=NULL
            SELECT MAX(glav006) INTO l_max_month FROM glav_t
             WHERE glavent=g_enterprise AND glav002=l_year
               AND glav001=(SELECT glaa003 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=tm.glfa005)
            IF cl_null(l_max_month) THEN LET l_max_month = 12 END IF
            LET l_emonth=l_max_month
         END IF
         
         IF l_year = tm.eyear THEN
            LET l_smonth = 1
            LET l_emonth = tm.emonth
         END IF
         
         IF l_year > tm.eyear THEN
            EXIT WHILE
         END IF
      END WHILE
      
      LET l_flag = FALSE #只需要设置一次列说明
      
      #列数
      IF l_j > 1 THEN
         LET l_col = l_j - 1
      END IF 
      
      #合计
      LET g_detail[l_ac].samt = l_samt1
      
      #全部：显示本位币二、本位币三
      IF tm.ctype = '3' THEN
         LET g_detail2[l_ac].glfbseq=g_detail[l_ac].glfbseq
         LET g_detail2[l_ac].glfb002=g_detail[l_ac].glfb002
         LET g_detail2[l_ac].glfb002_2_desc=g_detail[l_ac].glfb002_desc
         LET g_detail2[l_ac].glfb003=g_detail[l_ac].glfb003
         LET g_detail2[l_ac].samt2=l_samt2
         
         LET g_detail3[l_ac].glfbseq=g_detail[l_ac].glfbseq
         LET g_detail3[l_ac].glfb002=g_detail[l_ac].glfb002
         LET g_detail3[l_ac].glfb002_3_desc=g_detail[l_ac].glfb002_desc
         LET g_detail3[l_ac].glfb003=g_detail[l_ac].glfb003
         LET g_detail3[l_ac].samt3=l_samt3
      END IF
      
      #寻找设置比率所在行
      IF l_glfb009='Y' THEN
         LET l_flag_fm = l_ac   #标示分母位置
      END IF
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ""
            LET g_errparam.popup = TRUE
            CALL cl_err()

         END IF
         EXIT FOREACH
      END IF
   END FOREACH
   LET l_ac= l_ac -1
   LET l_count=l_ac
   
   #分母
   IF l_flag_fm = 0 THEN
      LET l_amt_fm = 0
   END IF
   
   #逐行计算比率，合计比率无条件显示，每期比率根据单头是否勾选显示比率来判断是否显示
   FOR l_ac = 1 TO l_count
      #当勾选显示比率时，显示每月的比率
      IF tm.show_per = 'Y' THEN
         FOR l_j = 1 TO l_col
            CASE l_j
               WHEN 1   
                  IF NOT cl_null(g_detail[l_ac].amt1) THEN
                     IF l_flag_fm > 0 THEN
                        IF cl_null(g_detail[l_flag_fm].amt1) THEN LET l_amt_fm = 0 END IF
                     END IF 
                     IF l_amt_fm = 0 THEN
                        LET g_detail[l_ac].per1 = 0
                     ELSE
                        LET g_detail[l_ac].per1 = g_detail[l_ac].amt1 / g_detail[l_flag_fm].amt1 * 100
                     END IF
                  END IF
               WHEN 2   
                  IF NOT cl_null(g_detail[l_ac].amt2) THEN
                     IF l_flag_fm > 0 THEN
                        IF cl_null(g_detail[l_flag_fm].amt2) THEN LET l_amt_fm = 0 END IF
                     END IF 
                     IF l_amt_fm = 0 THEN
                        LET g_detail[l_ac].per2 = 0
                     ELSE
                        LET g_detail[l_ac].per2 = g_detail[l_ac].amt2 / g_detail[l_flag_fm].amt2 * 100
                     END IF
                  END IF
               WHEN 3   
                  IF NOT cl_null(g_detail[l_ac].amt3) THEN
                     IF l_flag_fm > 0 THEN
                        IF cl_null(g_detail[l_flag_fm].amt3) THEN LET l_amt_fm = 0 END IF
                     END IF 
                     IF l_amt_fm = 0 THEN
                        LET g_detail[l_ac].per3 = 0
                     ELSE
                        LET g_detail[l_ac].per3 = g_detail[l_ac].amt3 / g_detail[l_flag_fm].amt3 * 100
                     END IF
                  END IF
               WHEN 4   
                  IF NOT cl_null(g_detail[l_ac].amt4) THEN
                     IF l_flag_fm > 0 THEN
                        IF cl_null(g_detail[l_flag_fm].amt4) THEN LET l_amt_fm = 0 END IF
                     END IF 
                     IF l_amt_fm = 0 THEN
                        LET g_detail[l_ac].per4 = 0
                     ELSE
                        LET g_detail[l_ac].per4 = g_detail[l_ac].amt4 / g_detail[l_flag_fm].amt4 * 100
                     END IF
                  END IF
               WHEN 5  
                  IF NOT cl_null(g_detail[l_ac].amt5) THEN
                     IF l_flag_fm > 0 THEN
                        IF cl_null(g_detail[l_flag_fm].amt5) THEN LET l_amt_fm = 0 END IF
                     END IF 
                     IF l_amt_fm = 0 THEN
                        LET g_detail[l_ac].per5 = 0
                     ELSE
                        LET g_detail[l_ac].per5 = g_detail[l_ac].amt5 / g_detail[l_flag_fm].amt5 * 100
                     END IF
                  END IF
               WHEN 6   
                  IF NOT cl_null(g_detail[l_ac].amt6) THEN
                     IF l_flag_fm > 0 THEN
                        IF cl_null(g_detail[l_flag_fm].amt6) THEN LET l_amt_fm = 0 END IF
                     END IF 
                     IF l_amt_fm = 0 THEN
                        LET g_detail[l_ac].per6 = 0
                     ELSE
                        LET g_detail[l_ac].per6 = g_detail[l_ac].amt6 / g_detail[l_flag_fm].amt6 * 100
                     END IF
                  END IF
               WHEN 7   
                  IF NOT cl_null(g_detail[l_ac].amt7) THEN
                     IF l_flag_fm > 0 THEN
                        IF cl_null(g_detail[l_flag_fm].amt7) THEN LET l_amt_fm = 0 END IF
                     END IF 
                     IF l_amt_fm = 0 THEN
                        LET g_detail[l_ac].per7 = 0
                     ELSE
                        LET g_detail[l_ac].per7 = g_detail[l_ac].amt7 / g_detail[l_flag_fm].amt7 * 100
                     END IF
                  END IF
               WHEN 8   
                  IF NOT cl_null(g_detail[l_ac].amt8) THEN
                     IF l_flag_fm > 0 THEN
                        IF cl_null(g_detail[l_flag_fm].amt8) THEN LET l_amt_fm = 0 END IF
                     END IF 
                     IF l_amt_fm = 0 THEN
                        LET g_detail[l_ac].per8 = 0
                     ELSE
                        LET g_detail[l_ac].per8 = g_detail[l_ac].amt8 / g_detail[l_flag_fm].amt8 * 100
                     END IF
                  END IF
               WHEN 9   
                  IF NOT cl_null(g_detail[l_ac].amt9) THEN
                     IF l_flag_fm > 0 THEN
                        IF cl_null(g_detail[l_flag_fm].amt9) THEN LET l_amt_fm = 0 END IF
                     END IF 
                     IF l_amt_fm = 0 THEN
                        LET g_detail[l_ac].per9 = 0
                     ELSE
                        LET g_detail[l_ac].per9 = g_detail[l_ac].amt9 / g_detail[l_flag_fm].amt9 * 100
                     END IF
                  END IF
               WHEN 10  
                  IF NOT cl_null(g_detail[l_ac].amt10) THEN
                     IF l_flag_fm > 0 THEN
                        IF cl_null(g_detail[l_flag_fm].amt10) THEN LET l_amt_fm = 0 END IF
                     END IF 
                     IF l_amt_fm = 0 THEN
                        LET g_detail[l_ac].per10 = 0
                     ELSE
                        LET g_detail[l_ac].per10 = g_detail[l_ac].amt10 / g_detail[l_flag_fm].amt10 * 100
                     END IF
                  END IF
               WHEN 11  
                  IF NOT cl_null(g_detail[l_ac].amt11) THEN
                     IF l_flag_fm > 0 THEN
                        IF cl_null(g_detail[l_flag_fm].amt11) THEN LET l_amt_fm = 0 END IF
                     END IF 
                     IF l_amt_fm = 0 THEN
                        LET g_detail[l_ac].per11 = 0
                     ELSE
                        LET g_detail[l_ac].per11 = g_detail[l_ac].amt11 / g_detail[l_flag_fm].amt11 * 100
                     END IF
                  END IF
               WHEN 12  
                  IF NOT cl_null(g_detail[l_ac].amt12) THEN
                     IF l_flag_fm > 0 THEN
                        IF cl_null(g_detail[l_flag_fm].amt12) THEN LET l_amt_fm = 0 END IF
                     END IF 
                     IF l_amt_fm = 0 THEN
                        LET g_detail[l_ac].per12 = 0
                     ELSE
                        LET g_detail[l_ac].per12 = g_detail[l_ac].amt12 / g_detail[l_flag_fm].amt12 * 100
                     END IF
                  END IF
               WHEN 13 
                  IF NOT cl_null(g_detail[l_ac].amt13) THEN
                     IF l_flag_fm > 0 THEN
                        IF cl_null(g_detail[l_flag_fm].amt13) THEN LET l_amt_fm = 0 END IF
                     END IF 
                     IF l_amt_fm = 0 THEN
                        LET g_detail[l_ac].per13 = 0
                     ELSE
                        LET g_detail[l_ac].per13 = g_detail[l_ac].amt13 / g_detail[l_flag_fm].amt13 * 100
                     END IF
                  END IF
               WHEN 14  
                  IF NOT cl_null(g_detail[l_ac].amt14) THEN
                     IF l_flag_fm > 0 THEN
                        IF cl_null(g_detail[l_flag_fm].amt14) THEN LET l_amt_fm = 0 END IF
                     END IF 
                     IF l_amt_fm = 0 THEN
                        LET g_detail[l_ac].per14 = 0
                     ELSE
                        LET g_detail[l_ac].per14 = g_detail[l_ac].amt14 / g_detail[l_flag_fm].amt14 * 100
                     END IF
                  END IF
               WHEN 15
                  IF NOT cl_null(g_detail[l_ac].amt15) THEN
                     IF l_flag_fm > 0 THEN
                        IF cl_null(g_detail[l_flag_fm].amt15) THEN LET l_amt_fm = 0 END IF
                     END IF 
                     IF l_amt_fm = 0 THEN
                        LET g_detail[l_ac].per15 = 0
                     ELSE
                        LET g_detail[l_ac].per15 = g_detail[l_ac].amt15 / g_detail[l_flag_fm].amt15 * 100
                     END IF
                  END IF
               WHEN 16 
                  IF NOT cl_null(g_detail[l_ac].amt16) THEN
                     IF l_flag_fm > 0 THEN
                        IF cl_null(g_detail[l_flag_fm].amt16) THEN LET l_amt_fm = 0 END IF
                     END IF 
                     IF l_amt_fm = 0 THEN
                        LET g_detail[l_ac].per16 = 0
                     ELSE
                        LET g_detail[l_ac].per16 = g_detail[l_ac].amt16 / g_detail[l_flag_fm].amt16 * 100
                     END IF
                  END IF
               WHEN 17  
                  IF NOT cl_null(g_detail[l_ac].amt17) THEN
                     IF l_flag_fm > 0 THEN
                        IF cl_null(g_detail[l_flag_fm].amt17) THEN LET l_amt_fm = 0 END IF
                     END IF 
                     IF l_amt_fm = 0 THEN
                        LET g_detail[l_ac].per17 = 0
                     ELSE
                        LET g_detail[l_ac].per17 = g_detail[l_ac].amt17 / g_detail[l_flag_fm].amt17 * 100
                     END IF
                  END IF
               WHEN 18  
                  IF NOT cl_null(g_detail[l_ac].amt18) THEN
                     IF l_flag_fm > 0 THEN
                        IF cl_null(g_detail[l_flag_fm].amt18) THEN LET l_amt_fm = 0 END IF
                     END IF 
                     IF l_amt_fm = 0 THEN
                        LET g_detail[l_ac].per18 = 0
                     ELSE
                        LET g_detail[l_ac].per18 = g_detail[l_ac].amt18 / g_detail[l_flag_fm].amt18 * 100
                     END IF
                  END IF
               WHEN 19  IF NOT cl_null(g_detail[l_ac].amt19) THEN
                     IF l_flag_fm > 0 THEN
                        IF cl_null(g_detail[l_flag_fm].amt19) THEN LET l_amt_fm = 0 END IF
                     END IF 
                     IF l_amt_fm = 0 THEN
                        LET g_detail[l_ac].per19 = 0
                     ELSE
                        LET g_detail[l_ac].per19 = g_detail[l_ac].amt19 / g_detail[l_flag_fm].amt19 * 100
                     END IF
                  END IF
               WHEN 20 
                  IF NOT cl_null(g_detail[l_ac].amt20) THEN
                     IF l_flag_fm > 0 THEN
                        IF cl_null(g_detail[l_flag_fm].amt20) THEN LET l_amt_fm = 0 END IF
                     END IF 
                     IF l_amt_fm = 0 THEN
                        LET g_detail[l_ac].per20 = 0
                     ELSE
                        LET g_detail[l_ac].per20 = g_detail[l_ac].amt20 / g_detail[l_flag_fm].amt20 * 100
                     END IF
                  END IF
               WHEN 21  
                  IF NOT cl_null(g_detail[l_ac].amt21) THEN
                     IF l_flag_fm > 0 THEN
                        IF cl_null(g_detail[l_flag_fm].amt21) THEN LET l_amt_fm = 0 END IF
                     END IF 
                     IF l_amt_fm = 0 THEN
                        LET g_detail[l_ac].per21 = 0
                     ELSE
                        LET g_detail[l_ac].per21 = g_detail[l_ac].amt21 / g_detail[l_flag_fm].amt21 * 100
                     END IF
                  END IF
               WHEN 22  
                  IF NOT cl_null(g_detail[l_ac].amt22) THEN
                     IF l_flag_fm > 0 THEN
                        IF cl_null(g_detail[l_flag_fm].amt22) THEN LET l_amt_fm = 0 END IF
                     END IF 
                     IF l_amt_fm = 0 THEN
                        LET g_detail[l_ac].per22 = 0
                     ELSE
                        LET g_detail[l_ac].per22 = g_detail[l_ac].amt22 / g_detail[l_flag_fm].amt22 * 100
                     END IF
                  END IF
               WHEN 23  
                  IF NOT cl_null(g_detail[l_ac].amt23) THEN
                     IF l_flag_fm > 0 THEN
                        IF cl_null(g_detail[l_flag_fm].amt23) THEN LET l_amt_fm = 0 END IF
                     END IF 
                     IF l_amt_fm = 0 THEN
                        LET g_detail[l_ac].per23 = 0
                     ELSE
                        LET g_detail[l_ac].per23 = g_detail[l_ac].amt23 / g_detail[l_flag_fm].amt23 * 100
                     END IF
                  END IF
               WHEN 24  IF NOT cl_null(g_detail[l_ac].amt24) THEN
                     IF l_flag_fm > 0 THEN
                        IF cl_null(g_detail[l_flag_fm].amt24) THEN LET l_amt_fm = 0 END IF
                     END IF 
                     IF l_amt_fm = 0 THEN
                        LET g_detail[l_ac].per24 = 0
                     ELSE
                        LET g_detail[l_ac].per24 = g_detail[l_ac].amt24 / g_detail[l_flag_fm].amt24 * 100
                     END IF
                  END IF
               WHEN 25  
                  IF NOT cl_null(g_detail[l_ac].amt25) THEN
                     IF l_flag_fm > 0 THEN
                        IF cl_null(g_detail[l_flag_fm].amt25) THEN LET l_amt_fm = 0 END IF
                     END IF 
                     IF l_amt_fm = 0 THEN
                        LET g_detail[l_ac].per25 = 0
                     ELSE
                        LET g_detail[l_ac].per25 = g_detail[l_ac].amt25 / g_detail[l_flag_fm].amt25 * 100
                     END IF
                  END IF
               WHEN 26  
                  IF NOT cl_null(g_detail[l_ac].amt26) THEN
                     IF l_flag_fm > 0 THEN
                        IF cl_null(g_detail[l_flag_fm].amt26) THEN LET l_amt_fm = 0 END IF
                     END IF 
                     IF l_amt_fm = 0 THEN
                        LET g_detail[l_ac].per26 = 0
                     ELSE
                        LET g_detail[l_ac].per26 = g_detail[l_ac].amt26 / g_detail[l_flag_fm].amt26 * 100
                     END IF
                  END IF
               WHEN 27  
                  IF NOT cl_null(g_detail[l_ac].amt27) THEN
                     IF l_flag_fm > 0 THEN
                        IF cl_null(g_detail[l_flag_fm].amt27) THEN LET l_amt_fm = 0 END IF
                     END IF 
                     IF l_amt_fm = 0 THEN
                        LET g_detail[l_ac].per27 = 0
                     ELSE
                        LET g_detail[l_ac].per27 = g_detail[l_ac].amt27 / g_detail[l_flag_fm].amt27 * 100
                     END IF
                  END IF
               WHEN 28  IF NOT cl_null(g_detail[l_ac].amt28) THEN
                     IF l_flag_fm > 0 THEN
                        IF cl_null(g_detail[l_flag_fm].amt28) THEN LET l_amt_fm = 0 END IF
                     END IF 
                     IF l_amt_fm = 0 THEN
                        LET g_detail[l_ac].per28 = 0
                     ELSE
                        LET g_detail[l_ac].per28 = g_detail[l_ac].amt28 / g_detail[l_flag_fm].amt28 * 100
                     END IF
                  END IF
               WHEN 29  
                  IF NOT cl_null(g_detail[l_ac].amt29) THEN
                     IF l_flag_fm > 0 THEN
                        IF cl_null(g_detail[l_flag_fm].amt29) THEN LET l_amt_fm = 0 END IF
                     END IF 
                     IF l_amt_fm = 0 THEN
                        LET g_detail[l_ac].per29 = 0
                     ELSE
                        LET g_detail[l_ac].per29 = g_detail[l_ac].amt29 / g_detail[l_flag_fm].amt29 * 100
                     END IF
                  END IF
               WHEN 30  
                  IF NOT cl_null(g_detail[l_ac].amt30) THEN
                     IF l_flag_fm > 0 THEN
                        IF cl_null(g_detail[l_flag_fm].amt30) THEN LET l_amt_fm = 0 END IF
                     END IF 
                     IF l_amt_fm = 0 THEN
                        LET g_detail[l_ac].per30 = 0
                     ELSE
                        LET g_detail[l_ac].per30 = g_detail[l_ac].amt30 / g_detail[l_flag_fm].amt30 * 100
                     END IF
                  END IF
            END CASE
            
            #显示本位币二三
            IF tm.ctype = '3' THEN
               CASE l_j
                  WHEN 1
                     IF NOT cl_null(g_detail2[l_ac].amt201) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail2[l_flag_fm].amt201) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail2[l_ac].per201 = 0
                        ELSE
                           LET g_detail2[l_ac].per201 = g_detail2[l_ac].amt201 / g_detail2[l_flag_fm].amt201 * 100
                        END IF
                     END IF
                     IF NOT cl_null(g_detail3[l_ac].amt301) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail3[l_flag_fm].amt301) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail3[l_ac].per301 = 0
                        ELSE
                           LET g_detail3[l_ac].per301 = g_detail3[l_ac].amt301 / g_detail3[l_flag_fm].amt301 * 100
                        END IF
                     END IF
                  WHEN 2   
                     IF NOT cl_null(g_detail2[l_ac].amt202) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail2[l_flag_fm].amt202) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail2[l_ac].per202 = 0
                        ELSE
                           LET g_detail2[l_ac].per202 = g_detail2[l_ac].amt202 / g_detail2[l_flag_fm].amt202 * 100
                        END IF
                     END IF
                     IF NOT cl_null(g_detail3[l_ac].amt302) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail3[l_flag_fm].amt302) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail3[l_ac].per302 = 0
                        ELSE
                           LET g_detail3[l_ac].per302 = g_detail3[l_ac].amt302 / g_detail3[l_flag_fm].amt302 * 100
                        END IF
                     END IF
                  WHEN 3   
                     IF NOT cl_null(g_detail2[l_ac].amt203) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail2[l_flag_fm].amt203) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail2[l_ac].per203 = 0
                        ELSE
                           LET g_detail2[l_ac].per203 = g_detail2[l_ac].amt203 / g_detail2[l_flag_fm].amt203 * 100
                        END IF
                     END IF
                     IF NOT cl_null(g_detail3[l_ac].amt303) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail3[l_flag_fm].amt303) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail3[l_ac].per303 = 0
                        ELSE
                           LET g_detail3[l_ac].per303 = g_detail3[l_ac].amt303 / g_detail3[l_flag_fm].amt303 * 100
                        END IF
                     END IF
                  WHEN 4   
                     IF NOT cl_null(g_detail2[l_ac].amt204) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail2[l_flag_fm].amt204) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail2[l_ac].per204 = 0
                        ELSE
                           LET g_detail2[l_ac].per204 = g_detail2[l_ac].amt204 / g_detail2[l_flag_fm].amt204 * 100
                        END IF
                     END IF
                     IF NOT cl_null(g_detail3[l_ac].amt304) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail3[l_flag_fm].amt304) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail3[l_ac].per304 = 0
                        ELSE
                           LET g_detail3[l_ac].per304 = g_detail3[l_ac].amt304 / g_detail3[l_flag_fm].amt304 * 100
                        END IF
                     END IF
                  WHEN 5  
                     IF NOT cl_null(g_detail2[l_ac].amt205) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail2[l_flag_fm].amt205) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail2[l_ac].per205 = 0
                        ELSE
                           LET g_detail2[l_ac].per205 = g_detail2[l_ac].amt205 / g_detail2[l_flag_fm].amt205 * 100
                        END IF
                     END IF
                     IF NOT cl_null(g_detail3[l_ac].amt305) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail3[l_flag_fm].amt305) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail3[l_ac].per305 = 0
                        ELSE
                           LET g_detail3[l_ac].per305 = g_detail3[l_ac].amt305 / g_detail3[l_flag_fm].amt305 * 100
                        END IF
                     END IF
                  WHEN 6   
                     IF NOT cl_null(g_detail2[l_ac].amt206) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail2[l_flag_fm].amt206) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail2[l_ac].per206 = 0
                        ELSE
                           LET g_detail2[l_ac].per206 = g_detail2[l_ac].amt206 / g_detail2[l_flag_fm].amt206 * 100
                        END IF
                     END IF
                     IF NOT cl_null(g_detail3[l_ac].amt306) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail3[l_flag_fm].amt306) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail3[l_ac].per306 = 0
                        ELSE
                           LET g_detail3[l_ac].per306 = g_detail3[l_ac].amt306 / g_detail3[l_flag_fm].amt306 * 100
                        END IF
                     END IF
                  WHEN 7   
                     IF NOT cl_null(g_detail2[l_ac].amt207) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail2[l_flag_fm].amt207) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail2[l_ac].per207 = 0
                        ELSE
                           LET g_detail2[l_ac].per207 = g_detail2[l_ac].amt207 / g_detail2[l_flag_fm].amt207 * 100
                        END IF
                     END IF
                     IF NOT cl_null(g_detail3[l_ac].amt307) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail3[l_flag_fm].amt307) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail3[l_ac].per307 = 0
                        ELSE
                           LET g_detail3[l_ac].per307 = g_detail3[l_ac].amt307 / g_detail3[l_flag_fm].amt307 * 100
                        END IF
                     END IF
                  WHEN 8   
                     IF NOT cl_null(g_detail2[l_ac].amt208) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail2[l_flag_fm].amt208) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail2[l_ac].per208 = 0
                        ELSE
                           LET g_detail2[l_ac].per208 = g_detail2[l_ac].amt208 / g_detail2[l_flag_fm].amt208 * 100
                        END IF
                     END IF
                     IF NOT cl_null(g_detail3[l_ac].amt308) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail3[l_flag_fm].amt308) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail3[l_ac].per308 = 0
                        ELSE
                           LET g_detail3[l_ac].per308 = g_detail3[l_ac].amt308 / g_detail3[l_flag_fm].amt308 * 100
                        END IF
                     END IF
                  WHEN 9   
                     IF NOT cl_null(g_detail2[l_ac].amt209) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail2[l_flag_fm].amt209) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail2[l_ac].per209 = 0
                        ELSE
                           LET g_detail2[l_ac].per209 = g_detail2[l_ac].amt209 / g_detail2[l_flag_fm].amt209 * 100
                        END IF
                     END IF
                     IF NOT cl_null(g_detail3[l_ac].amt309) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail3[l_flag_fm].amt309) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail3[l_ac].per309 = 0
                        ELSE
                           LET g_detail3[l_ac].per309 = g_detail3[l_ac].amt309 / g_detail3[l_flag_fm].amt309 * 100
                        END IF
                     END IF
                  WHEN 10  
                     IF NOT cl_null(g_detail2[l_ac].amt210) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail2[l_flag_fm].amt210) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail2[l_ac].per210 = 0
                        ELSE
                           LET g_detail2[l_ac].per210 = g_detail2[l_ac].amt210 / g_detail2[l_flag_fm].amt210 * 100
                        END IF
                     END IF
                     IF NOT cl_null(g_detail3[l_ac].amt310) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail3[l_flag_fm].amt310) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail3[l_ac].per310 = 0
                        ELSE
                           LET g_detail3[l_ac].per310 = g_detail3[l_ac].amt310 / g_detail3[l_flag_fm].amt310 * 100
                        END IF
                     END IF
                  WHEN 11  
                     IF NOT cl_null(g_detail2[l_ac].amt211) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail2[l_flag_fm].amt211) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail2[l_ac].per211 = 0
                        ELSE
                           LET g_detail2[l_ac].per211 = g_detail2[l_ac].amt211 / g_detail2[l_flag_fm].amt211 * 100
                        END IF
                     END IF
                     IF NOT cl_null(g_detail3[l_ac].amt311) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail3[l_flag_fm].amt311) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail3[l_ac].per311 = 0
                        ELSE
                           LET g_detail3[l_ac].per311 = g_detail3[l_ac].amt311 / g_detail3[l_flag_fm].amt311 * 100
                        END IF
                     END IF
                  WHEN 12  
                     IF NOT cl_null(g_detail2[l_ac].amt212) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail2[l_flag_fm].amt212) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail2[l_ac].per212 = 0
                        ELSE
                           LET g_detail2[l_ac].per212 = g_detail2[l_ac].amt212 / g_detail2[l_flag_fm].amt212 * 100
                        END IF
                     END IF
                     IF NOT cl_null(g_detail3[l_ac].amt312) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail3[l_flag_fm].amt312) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail3[l_ac].per312 = 0
                        ELSE
                           LET g_detail3[l_ac].per312 = g_detail3[l_ac].amt312 / g_detail3[l_flag_fm].amt312 * 100
                        END IF
                     END IF
                  WHEN 13 
                     IF NOT cl_null(g_detail2[l_ac].amt213) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail2[l_flag_fm].amt213) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail2[l_ac].per213 = 0
                        ELSE
                           LET g_detail2[l_ac].per213 = g_detail2[l_ac].amt213 / g_detail2[l_flag_fm].amt213 * 100
                        END IF
                     END IF
                     IF NOT cl_null(g_detail3[l_ac].amt313) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail3[l_flag_fm].amt313) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail3[l_ac].per313 = 0
                        ELSE
                           LET g_detail3[l_ac].per313 = g_detail3[l_ac].amt313 / g_detail3[l_flag_fm].amt313 * 100
                        END IF
                     END IF
                  WHEN 14  
                     IF NOT cl_null(g_detail2[l_ac].amt214) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail2[l_flag_fm].amt214) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail2[l_ac].per214 = 0
                        ELSE
                           LET g_detail2[l_ac].per214 = g_detail2[l_ac].amt214 / g_detail2[l_flag_fm].amt214 * 100
                        END IF
                     END IF
                     IF NOT cl_null(g_detail3[l_ac].amt314) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail3[l_flag_fm].amt314) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail3[l_ac].per314 = 0
                        ELSE
                           LET g_detail3[l_ac].per314 = g_detail3[l_ac].amt314 / g_detail3[l_flag_fm].amt314 * 100
                        END IF
                     END IF
                  WHEN 15
                     IF NOT cl_null(g_detail2[l_ac].amt215) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail2[l_flag_fm].amt215) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail2[l_ac].per215 = 0
                        ELSE
                           LET g_detail2[l_ac].per215 = g_detail2[l_ac].amt215 / g_detail2[l_flag_fm].amt215 * 100
                        END IF
                     END IF
                     IF NOT cl_null(g_detail3[l_ac].amt315) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail3[l_flag_fm].amt315) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail3[l_ac].per315 = 0
                        ELSE
                           LET g_detail3[l_ac].per315 = g_detail3[l_ac].amt315 / g_detail3[l_flag_fm].amt315 * 100
                        END IF
                     END IF
                  WHEN 16 
                     IF NOT cl_null(g_detail2[l_ac].amt216) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail2[l_flag_fm].amt216) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail2[l_ac].per216 = 0
                        ELSE
                           LET g_detail2[l_ac].per216 = g_detail2[l_ac].amt216 / g_detail2[l_flag_fm].amt216 * 100
                        END IF
                     END IF
                     IF NOT cl_null(g_detail3[l_ac].amt316) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail3[l_flag_fm].amt316) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail3[l_ac].per316 = 0
                        ELSE
                           LET g_detail3[l_ac].per316 = g_detail3[l_ac].amt316 / g_detail3[l_flag_fm].amt316 * 100
                        END IF
                     END IF
                  WHEN 17  
                     IF NOT cl_null(g_detail2[l_ac].amt217) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail2[l_flag_fm].amt217) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail2[l_ac].per217 = 0
                        ELSE
                           LET g_detail2[l_ac].per217 = g_detail2[l_ac].amt217 / g_detail2[l_flag_fm].amt217 * 100
                        END IF
                     END IF
                     IF NOT cl_null(g_detail3[l_ac].amt317) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail3[l_flag_fm].amt317) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail3[l_ac].per317 = 0
                        ELSE
                           LET g_detail3[l_ac].per317 = g_detail3[l_ac].amt317 / g_detail3[l_flag_fm].amt317 * 100
                        END IF
                     END IF
                  WHEN 18  
                     IF NOT cl_null(g_detail2[l_ac].amt218) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail2[l_flag_fm].amt218) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail2[l_ac].per218 = 0
                        ELSE
                           LET g_detail2[l_ac].per218 = g_detail2[l_ac].amt218 / g_detail2[l_flag_fm].amt218 * 100
                        END IF
                     END IF
                     IF NOT cl_null(g_detail3[l_ac].amt318) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail3[l_flag_fm].amt318) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail3[l_ac].per318 = 0
                        ELSE
                           LET g_detail3[l_ac].per318 = g_detail3[l_ac].amt318 / g_detail3[l_flag_fm].amt318 * 100
                        END IF
                     END IF
                  WHEN 19  
                     IF NOT cl_null(g_detail2[l_ac].amt219) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail2[l_flag_fm].amt219) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail2[l_ac].per219 = 0
                        ELSE
                           LET g_detail2[l_ac].per219 = g_detail2[l_ac].amt219 / g_detail2[l_flag_fm].amt219 * 100
                        END IF
                     END IF
                     IF NOT cl_null(g_detail3[l_ac].amt319) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail3[l_flag_fm].amt319) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail3[l_ac].per319 = 0
                        ELSE
                           LET g_detail3[l_ac].per319 = g_detail3[l_ac].amt319 / g_detail3[l_flag_fm].amt319 * 100
                        END IF
                     END IF
                  WHEN 20 
                     IF NOT cl_null(g_detail2[l_ac].amt220) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail2[l_flag_fm].amt220) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail2[l_ac].per220 = 0
                        ELSE
                           LET g_detail2[l_ac].per220 = g_detail2[l_ac].amt220 / g_detail2[l_flag_fm].amt220 * 100
                        END IF
                     END IF
                     IF NOT cl_null(g_detail3[l_ac].amt320) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail3[l_flag_fm].amt320) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail3[l_ac].per320 = 0
                        ELSE
                           LET g_detail3[l_ac].per320 = g_detail3[l_ac].amt320 / g_detail3[l_flag_fm].amt320 * 100
                        END IF
                     END IF
                  WHEN 21  
                     IF NOT cl_null(g_detail2[l_ac].amt221) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail2[l_flag_fm].amt221) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail2[l_ac].per221 = 0
                        ELSE
                           LET g_detail2[l_ac].per221 = g_detail2[l_ac].amt221 / g_detail2[l_flag_fm].amt221 * 100
                        END IF
                     END IF
                     IF NOT cl_null(g_detail3[l_ac].amt321) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail3[l_flag_fm].amt321) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail3[l_ac].per321 = 0
                        ELSE
                           LET g_detail3[l_ac].per321 = g_detail3[l_ac].amt321 / g_detail3[l_flag_fm].amt321 * 100
                        END IF
                     END IF
                  WHEN 22  
                     IF NOT cl_null(g_detail2[l_ac].amt222) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail2[l_flag_fm].amt222) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail2[l_ac].per222 = 0
                        ELSE
                           LET g_detail2[l_ac].per222 = g_detail2[l_ac].amt222 / g_detail2[l_flag_fm].amt222 * 100
                        END IF
                     END IF
                     IF NOT cl_null(g_detail3[l_ac].amt322) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail3[l_flag_fm].amt322) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail3[l_ac].per322 = 0
                        ELSE
                           LET g_detail3[l_ac].per322 = g_detail3[l_ac].amt322 / g_detail3[l_flag_fm].amt322 * 100
                        END IF
                     END IF
                  WHEN 23  
                     IF NOT cl_null(g_detail2[l_ac].amt223) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail2[l_flag_fm].amt223) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail2[l_ac].per223 = 0
                        ELSE
                           LET g_detail2[l_ac].per223 = g_detail2[l_ac].amt223 / g_detail2[l_flag_fm].amt223 * 100
                        END IF
                     END IF
                     IF NOT cl_null(g_detail3[l_ac].amt323) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail3[l_flag_fm].amt323) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail3[l_ac].per323 = 0
                        ELSE
                           LET g_detail3[l_ac].per323 = g_detail3[l_ac].amt323 / g_detail3[l_flag_fm].amt323 * 100
                        END IF
                     END IF
                  WHEN 24  
                     IF NOT cl_null(g_detail2[l_ac].amt224) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail2[l_flag_fm].amt224) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail2[l_ac].per224 = 0
                        ELSE
                           LET g_detail2[l_ac].per224 = g_detail2[l_ac].amt224 / g_detail2[l_flag_fm].amt224 * 100
                        END IF
                     END IF
                     IF NOT cl_null(g_detail3[l_ac].amt324) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail3[l_flag_fm].amt324) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail3[l_ac].per324 = 0
                        ELSE
                           LET g_detail3[l_ac].per324 = g_detail3[l_ac].amt324 / g_detail3[l_flag_fm].amt324 * 100
                        END IF
                     END IF
                  WHEN 25  
                     IF NOT cl_null(g_detail2[l_ac].amt225) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail2[l_flag_fm].amt225) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail2[l_ac].per225 = 0
                        ELSE
                           LET g_detail2[l_ac].per225 = g_detail2[l_ac].amt225 / g_detail2[l_flag_fm].amt225 * 100
                        END IF
                     END IF
                     IF NOT cl_null(g_detail3[l_ac].amt325) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail3[l_flag_fm].amt325) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail3[l_ac].per325 = 0
                        ELSE
                           LET g_detail3[l_ac].per325 = g_detail3[l_ac].amt325 / g_detail3[l_flag_fm].amt325 * 100
                        END IF
                     END IF
                  WHEN 26  
                     IF NOT cl_null(g_detail2[l_ac].amt226) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail2[l_flag_fm].amt226) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail2[l_ac].per226 = 0
                        ELSE
                           LET g_detail2[l_ac].per226 = g_detail2[l_ac].amt226 / g_detail2[l_flag_fm].amt226 * 100
                        END IF
                     END IF
                     IF NOT cl_null(g_detail3[l_ac].amt326) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail3[l_flag_fm].amt326) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail3[l_ac].per326 = 0
                        ELSE
                           LET g_detail3[l_ac].per326 = g_detail3[l_ac].amt326 / g_detail3[l_flag_fm].amt326 * 100
                        END IF
                     END IF
                  WHEN 27  
                     IF NOT cl_null(g_detail2[l_ac].amt227) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail2[l_flag_fm].amt227) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail2[l_ac].per227 = 0
                        ELSE
                           LET g_detail2[l_ac].per227 = g_detail2[l_ac].amt227 / g_detail2[l_flag_fm].amt227 * 100
                        END IF
                     END IF
                     IF NOT cl_null(g_detail3[l_ac].amt327) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail3[l_flag_fm].amt327) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail3[l_ac].per327 = 0
                        ELSE
                           LET g_detail3[l_ac].per327 = g_detail3[l_ac].amt327 / g_detail3[l_flag_fm].amt327 * 100
                        END IF
                     END IF
                  WHEN 28  
                     IF NOT cl_null(g_detail2[l_ac].amt228) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail2[l_flag_fm].amt228) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail2[l_ac].per228 = 0
                        ELSE
                           LET g_detail2[l_ac].per228 = g_detail2[l_ac].amt228 / g_detail2[l_flag_fm].amt228 * 100
                        END IF
                     END IF
                     IF NOT cl_null(g_detail3[l_ac].amt328) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail3[l_flag_fm].amt328) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail3[l_ac].per328 = 0
                        ELSE
                           LET g_detail3[l_ac].per328 = g_detail3[l_ac].amt328 / g_detail3[l_flag_fm].amt328 * 100
                        END IF
                     END IF
                  WHEN 29  
                     IF NOT cl_null(g_detail2[l_ac].amt229) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail2[l_flag_fm].amt229) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail2[l_ac].per229 = 0
                        ELSE
                           LET g_detail2[l_ac].per229 = g_detail2[l_ac].amt229 / g_detail2[l_flag_fm].amt229 * 100
                        END IF
                     END IF
                     IF NOT cl_null(g_detail3[l_ac].amt329) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail3[l_flag_fm].amt329) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail3[l_ac].per329 = 0
                        ELSE
                           LET g_detail3[l_ac].per329 = g_detail3[l_ac].amt329 / g_detail3[l_flag_fm].amt329 * 100
                        END IF
                     END IF
                  WHEN 30  
                     IF NOT cl_null(g_detail2[l_ac].amt230) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail2[l_flag_fm].amt230) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail2[l_ac].per230 = 0
                        ELSE
                           LET g_detail2[l_ac].per230 = g_detail2[l_ac].amt230 / g_detail2[l_flag_fm].amt230 * 100
                        END IF
                     END IF
                     IF NOT cl_null(g_detail3[l_ac].amt330) THEN
                        IF l_flag_fm > 0 THEN
                           IF cl_null(g_detail3[l_flag_fm].amt330) THEN LET l_amt_fm = 0 END IF
                        END IF 
                        IF l_amt_fm = 0 THEN
                           LET g_detail3[l_ac].per330 = 0
                        ELSE
                           LET g_detail3[l_ac].per330 = g_detail3[l_ac].amt330 / g_detail3[l_flag_fm].amt330 * 100
                        END IF
                     END IF
               END CASE
            END IF
         END FOR
      END IF
      
      #合计比率
      IF NOT cl_null(g_detail[l_ac].samt) THEN
         IF l_flag_fm > 0 THEN
            IF cl_null(g_detail[l_flag_fm].samt) THEN LET l_amt_fm = 0 END IF
         END IF 
         IF l_amt_fm = 0 THEN
            LET g_detail[l_ac].sper = 0
         ELSE
            LET g_detail[l_ac].sper = g_detail[l_ac].samt / g_detail[l_flag_fm].samt * 100
         END IF
      END IF
      #合计比率：本位币二三
      IF tm.ctype='3' THEN
         IF NOT cl_null(g_detail2[l_ac].samt2) THEN
            IF l_flag_fm > 0 THEN
               IF cl_null(g_detail2[l_flag_fm].samt2) THEN LET l_amt_fm = 0 END IF
            END IF 
            IF l_amt_fm = 0 THEN
               LET g_detail2[l_ac].sper2 = 0
            ELSE
               LET g_detail2[l_ac].sper2 = g_detail2[l_ac].samt2 / g_detail2[l_flag_fm].samt2 * 100
            END IF
         END IF
         IF NOT cl_null(g_detail3[l_ac].samt3) THEN
            IF l_flag_fm > 0 THEN
               IF cl_null(g_detail3[l_flag_fm].samt3) THEN LET l_amt_fm = 0 END IF
            END IF 
            IF l_amt_fm = 0 THEN
               LET g_detail3[l_ac].sper3 = 0
            ELSE
               LET g_detail3[l_ac].sper3 = g_detail3[l_ac].samt3 / g_detail3[l_flag_fm].samt3 * 100
            END IF
         END IF
      END IF
   END FOR

   #设置栏位显示
   CALL cl_set_comp_visible(l_str1,TRUE)
   
   #設置單身金額欄位格式
   LET l_format = "---,---,---,--&"
   LET l_str4 = ""
   FOR l_j=1 TO tm.glfa009
       LET l_str4 = l_str4,"&"
   END FOR
   IF NOT cl_null(l_str4) THEN
      LET l_format = l_format,'.',l_str4
   END IF
   CALL cl_set_comp_format(l_str1,l_format)
   
   IF tm.ctype='3' THEN
      CALL cl_set_comp_visible(l_str2,TRUE)
      CALL cl_set_comp_visible(l_str3,TRUE)
      CALL cl_set_comp_format(l_str2,l_format)
      CALL cl_set_comp_format(l_str3,l_format)
   END IF
   
   LET l_str4 = NULL
   LET l_str5 = NULL
   LET l_str6 = NULL
   FOR l_j = l_col+1 TO 30     
      IF NOT cl_null(l_str4) THEN LET l_str4 = l_str4 CLIPPED,"," END IF
      LET l_str4 = l_str4,"amt" CLIPPED,l_j USING '<<<<',"per" CLIPPED,l_j USING '<<<<' 
      IF tm.ctype='3' THEN
         IF NOT cl_null(l_str5) THEN LET l_str5 = l_str5 CLIPPED,"," END IF
         LET l_cnt = 200 + l_j
         LET l_str5 = l_str5,"amt" CLIPPED,l_cnt USING '<<<<',"per" CLIPPED,l_cnt USING '<<<<'
         IF NOT cl_null(l_str6) THEN LET l_str6 = l_str6 CLIPPED,"," END IF
         LET l_cnt = 300 + l_j
         LET l_str6 = l_str6,"amt" CLIPPED,l_cnt USING '<<<<',"per" CLIPPED,l_cnt USING '<<<<'
      END IF
   END FOR
   CALL cl_set_comp_visible(l_str4,FALSE)
   IF tm.ctype='3' THEN
      CALL cl_set_comp_visible(l_str5,FALSE)
      CALL cl_set_comp_visible(l_str6,FALSE)
   END IF
   #end add-point
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   CALL g_detail.deleteElement(g_detail.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   #單身總筆數顯示
   LET g_detail_cnt = g_detail.getLength()
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aglq852_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aglq852_detail_action_trans()
 
   CALL aglq852_b_fill2()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="aglq852.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq852_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = 1
 
   #單身組成
   #應用 qs11 樣板自動產生(Version:3)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
   #add-point:sql組成 name="b_fill2.fill"
   
   #end add-point
 
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq852.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aglq852_detail_show(ps_page)
   #add-point:show段define-客製 name="detail_show.define_customerization"
   
   #end add-point
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
 
   #add-point:detail_show段之前 name="detail_show.before"
   
   #end add-point
 
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference name="detail_show.body.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = tm.glfa001
            LET g_ref_fields[2] = g_detail[l_ac].glfbseq
            LET g_ref_fields[3] = g_detail[l_ac].glfb002
            LET ls_sql = "SELECT glfbl004 FROM glfbl_t WHERE glfblent='"||g_enterprise||"' AND glfbl001=? AND glfblseq=? AND glfbl002=? AND glfbl003='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_detail[l_ac].glfb002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_detail[l_ac].glfb002_desc

      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'3'",1) > 0 THEN
      #帶出公用欄位reference值page3
      
 
      #add-point:show段單身reference name="detail_show.body3.reference"
      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq852.maintain_prog" >}
#+ 串查至主維護程式
PRIVATE FUNCTION aglq852_maintain_prog()
   #add-point:maintain_prog段define-客製 name="maintain_prog.define_customerization"
   
   #end add-point
   DEFINE ls_js      STRING
   DEFINE la_param   RECORD
                     prog       STRING,
                     actionid   STRING,
                     background LIKE type_t.chr1,
                     param      DYNAMIC ARRAY OF STRING
                     END RECORD
   DEFINE ls_j       LIKE type_t.num5
   #add-point:maintain_prog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="maintain_prog.define"
   
   #end add-point
 
 
   #add-point:maintain_prog段開始前 name="maintain_prog.before"
   
   #end add-point
 
   LET la_param.prog = ""
 
 
 
   IF NOT cl_null(la_param.prog) THEN
      LET ls_js = util.JSON.stringify(la_param)
      CALL cl_cmdrun_wait(ls_js)
   END IF
 
   #add-point:maintain_prog段結束前 name="maintain_prog.after"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglq852.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aglq852_detail_action_trans()
   #add-point:detail_action_trans段define-客製 name="detail_action_trans.define_customerization"
   
   #end add-point
   #add-point:detail_action_trans段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_action_trans.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_action_trans.before_function"
   
   #end add-point
 
   #因應單身切頁功能，筆數計算方式調整
   LET g_current_row_tot = g_pagestart + g_detail_idx - 1
   DISPLAY g_current_row_tot TO FORMONLY.idx
   DISPLAY g_tot_cnt TO FORMONLY.cnt
 
   #顯示單身頁面的起始與結束筆數
   LET g_page_start_num = g_pagestart
   LET g_page_end_num = g_pagestart + g_num_in_page - 1
   DISPLAY g_page_start_num TO FORMONLY.p_start
   DISPLAY g_page_end_num TO FORMONLY.p_end
 
   #目前不支援跳頁功能
   LET g_page_act_list = "detail_first,detail_previous,'',detail_next,detail_last"
   CALL cl_navigator_detail_page_setting(g_page_act_list,g_current_row_tot,g_pagestart,g_num_in_page,g_tot_cnt)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq852.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aglq852_detail_index_setting()
   #add-point:detail_index_setting段define-客製 name="detail_index_setting.define_customerization"
   
   #end add-point
   DEFINE li_redirect     BOOLEAN
   DEFINE ldig_curr       ui.Dialog
   #add-point:detail_index_setting段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_index_setting.define"
   
   #end add-point
 
 
   #add-point:FUNCTION前置處理 name="detail_index_setting.before_function"
   
   #end add-point
 
   IF g_master_row_move = "Y" THEN
      LET g_detail_idx = 1
      LET li_redirect = TRUE
   ELSE
      IF g_curr_diag IS NOT NULL THEN
         CASE
            WHEN g_curr_diag.getCurrentRow("s_detail1") <= "0"
               LET g_detail_idx = 1
               IF g_detail.getLength() THEN
                  LET li_redirect = TRUE
               END IF
            WHEN g_curr_diag.getCurrentRow("s_detail1") > g_detail.getLength() AND g_detail.getLength() > 0
               LET g_detail_idx = g_detail.getLength()
               LET li_redirect = TRUE
            WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
               IF g_detail_idx > g_detail.getLength() THEN
                  LET g_detail_idx = g_detail.getLength()
               END IF
               LET li_redirect = TRUE
         END CASE
      END IF
   END IF
 
   IF li_redirect THEN
      LET ldig_curr = ui.Dialog.getCurrent()
      CALL ldig_curr.setCurrentRow("s_detail1", g_detail_idx)
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aglq852.mask_functions" >}
 &include "erp/agl/aglq852_mask.4gl"
 
{</section>}
 
{<section id="aglq852.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 查询操作
# Memo...........:
# Usage..........: CALL aglq852_query()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/09/25 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq852_query()
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_glav006  LIKE glav_t.glav006
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_n        LIKE type_t.num5
   DEFINE l_tok  base.stringTokenizer
   DEFINE l_glfa005 LIKE glfa_t.glfa005
   DEFINE l_sql      STRING  
   DEFINE l_str1     STRING
   DEFINE l_str2     STRING   
   DEFINE l_i        LIKE type_t.num5
   DEFINE l_glaa004  LIKE glaa_t.glaa004
   
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_detail.clear()
   CALL g_detail2.clear()
   CALL g_detail3.clear()
   
   
   LET g_glfa002 = ''            #報表類型
   INITIALIZE tm.* TO NULL    
   LET tm.ctype = '0'            #本位币
   CALL cl_set_comp_visible("page_2,page_3,glaa016,glaa020",FALSE)
   
   CALL cl_set_comp_entry('ctype',FALSE)  #目前只處理本位幣一，故設置只可查詢本位幣一
   
   LET tm.syear=YEAR(g_today)    #起始年度
   LET tm.eyear=YEAR(g_today)    #截止年度
   LET tm.emonth=MONTH(g_today)  #截止期别
   IF tm.emonth = 1 THEN         
      LET tm.smonth=1            #起始期别
   ELSE                          
      LET tm.smonth=tm.emonth-1  #起始期别
   END IF
   LET tm.stus='1'               #单据状态
   LET tm.show_ad='Y'            #含审计凭证
   LET tm.show_per = 'Y'         #显示比率
   LET tm.show_xrbl='N'          #显示XRBL科目   
   CALL cl_set_comp_visible("b_glfb008",FALSE)
   LET tm.glfa008='1'            #显示单位
   LET tm.glfa009=2              #小数位数
   #币别转换
   LET tm.chg_curr='N'
   LET tm.curr=''
   LET tm.rate=''
   CALL cl_set_comp_entry('curr,rate',FALSE)
   DISPLAY BY NAME tm.glfa001,tm.glfa001_desc,tm.glfa005,tm.glfa005_desc,tm.ctype,tm.glaa001,tm.glaa016,tm.glaa020,
                   tm.syear,tm.smonth,tm.eyear,tm.emonth,tm.fix_type,tm.fix_acc,tm.stus,tm.show_ad,tm.show_per,
                   tm.show_xrbl,tm.glfa008,tm.glfa009,tm.chg_curr,tm.curr,tm.rate
   
   FOR l_i = 1 TO 30 
      #金额   
      IF NOT cl_null(l_str1) THEN LET l_str1 = l_str1 CLIPPED,"," END IF
      LET l_str1 = l_str1,"amt",l_i USING '<<<<' CLIPPED
      #百分比
      IF NOT cl_null(l_str2) THEN LET l_str2 = l_str2 CLIPPED,"," END IF
      LET l_str2 = l_str2,"per",l_i USING '<<<<' CLIPPED
   END FOR
   CALL cl_set_comp_visible(l_str1,FALSE)
   CALL cl_set_comp_visible(l_str2,FALSE)
   
   
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_wc_filter = " 1=1"
   LET g_detail_page_action = ""
   LET g_pagestart = 1
   
   LET g_master_idx = l_ac

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
        
      INPUT tm.glfa001,tm.glfa005,tm.ctype,tm.syear,tm.smonth,tm.eyear,tm.emonth,tm.fix_type,tm.fix_acc, 
            tm.stus,tm.show_ad,tm.show_per,tm.glfa008,tm.glfa009,tm.show_xrbl,tm.chg_curr,tm.curr,tm.rate  
       FROM glfa001,glfa005,ctype,syear,smonth,eyear,emonth,fix_type,fix_acc,
            stus,show_ad,show_per,glfa008,glfa009,show_xrbl,chg_curr,curr,rate 
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
     
         AFTER FIELD glfa001
            IF cl_null(tm.glfa001) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'acr-00015'
               LET g_errparam.extend = tm.glfa001
               LET g_errparam.popup = FALSE
               CALL cl_err()
               NEXT FIELD glfa001
            END IF 
            
            IF NOT cl_null(tm.glfa001) THEN
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt FROM glfa_t
                WHERE glfaent=g_enterprise AND glfa001=tm.glfa001 AND glfa002 <> '3'
               IF l_cnt=0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00249'
                  LET g_errparam.extend = tm.glfa001
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD glfa001
               END IF
               
               LET g_glfa002 = ''  #报表类型
               LET g_glfa004 = ''  #科目参照表
               SELECT glfa002,glfa004 INTO g_glfa002,g_glfa004 FROM glfa_t
                WHERE glfaent=g_enterprise AND glfa001=tm.glfa001
               IF g_glfa002 = '1' THEN   #資產負債類
                  CALL cl_set_comp_visible('samt,sper,samt2,sper2,samt3,sper3',FALSE)
                  #当资产负债表时，核算项类型只能等于1.营运据点或空白不选
                  CALL cl_set_combo_scc_part('fix_type','9934','1')
               END IF
               IF g_glfa002 = '2' THEN   #損益類
                  CALL cl_set_comp_visible('samt,sper',TRUE)
                  IF tm.ctype='3' THEN   #本位币选择‘3.全部’
                     CALL cl_set_comp_visible('samt2,sper2,samt3,sper3',TRUE)
                  END IF
                  CALL cl_set_combo_scc('fix_type','9934')
               END IF 
            END IF  

            AFTER FIELD glfa005
              IF NOT cl_null(tm.glfa005) THEN
                 LET l_tok = base.StringTokenizer.createExt(tm.glfa005,'|','',TRUE)
                 IF l_tok.countTokens() > 0 THEN
                    WHILE l_tok.hasMoreTokens()
                       LET l_glfa005= l_tok.nextToken()
                       SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=l_glfa005
                       IF SQLCA.sqlcode=100 THEN
                          INITIALIZE g_errparam TO NULL
                          LET g_errparam.code = 'agl-00055'
                          LET g_errparam.extend = l_glfa005
                          LET g_errparam.popup = FALSE
                          CALL cl_err()
                          NEXT FIELD glfa005
                       END IF
                       #160811-00039#4--add--str--
                       SELECT COUNT(*) INTO l_cnt FROM glaa_t WHERE glaaent=g_enterprise AND glaald=l_glfa005 AND glaastus='Y'
                       IF l_cnt=0 THEN
                          INITIALIZE g_errparam TO NULL
                          LET g_errparam.code = 'agl-00051'
                          LET g_errparam.extend = l_glfa005
                          LET g_errparam.popup = FALSE
                          CALL cl_err()
                       
                          NEXT FIELD glfa005
                       END IF
                       IF NOT s_ld_chk_authorization(g_user,l_glfa005) THEN
                          INITIALIZE g_errparam TO NULL
                          LET g_errparam.code = 'agl-00165'
                          LET g_errparam.extend = l_glfa005
                          LET g_errparam.popup = TRUE
                          CALL cl_err()
                       
                          NEXT FIELD glfa005
                       END IF
                       #160811-00039#4--add--end
                       IF NOT cl_null(g_glfa004) AND l_glaa004 <> g_glfa004 THEN
                          INITIALIZE g_errparam TO NULL
                          LET g_errparam.code = 'agl-00242'
                          LET g_errparam.extend = l_glfa005
                          LET g_errparam.popup = FALSE
                          CALL cl_err()
                          NEXT FIELD glfa005
                       END IF
                    END WHILE
                 END IF
              END IF  
              LET g_str = tm.glfa005              
           
            ON CHANGE ctype
               #当本位币选择3.全部时，转换币别不可录入
               IF tm.ctype = '3' THEN 
#                  CALL cl_set_comp_visible("page_2,page_3,glaa016,glaa020",TRUE)
                  LET tm.chg_curr='N'
                  LET tm.curr=''
                  LET tm.rate=''
                  CALL cl_set_comp_entry("chg_curr,curr,rate",FALSE)
               ELSE
                  CALL cl_set_comp_visible("page_2,page_3,glaa016,glaa020",FALSE)
                  LET tm.chg_curr='N'
                  CALL cl_set_comp_entry("chg_curr,",TRUE)
               END IF
            
            AFTER FIELD syear
               IF NOT cl_null(tm.syear) THEN
                  IF NOT cl_null(tm.eyear) AND tm.syear > tm.eyear THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-00378'
                     LET g_errparam.extend = tm.syear
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     NEXT FIELD syear
                  END IF
                  IF NOT cl_null(tm.eyear) AND NOT cl_null(tm.smonth) AND NOT cl_null(tm.emonth) AND 
                     tm.syear = tm.eyear AND tm.smonth > tm.emonth THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00227'
                     LET g_errparam.extend = tm.smonth
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     NEXT FIELD smonth
                  END IF
               END IF
               
            AFTER FIELD smonth
               IF NOT cl_null(tm.smonth) THEN
                  IF NOT cl_null(tm.syear) AND NOT cl_null(tm.eyear) AND NOT cl_null(tm.emonth) AND 
                     tm.syear = tm.eyear AND tm.smonth > tm.emonth THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00227'
                     LET g_errparam.extend = tm.smonth
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     NEXT FIELD smonth
                  END IF
               END IF
               IF NOT NOT cl_null(tm.syear) THEN
                  #限制录入的期别不可超过最大期别
                  LET l_glav006 = NULL
                  LET l_sql="SELECT MAX(glav006) FROM glav_t ",
                            " WHERE glavent=",g_enterprise," AND glav002=",tm.syear
                  IF NOT cl_null(tm.glfa005) THEN
                     LET l_str1=tm.glfa005
                     LET l_str1=cl_replace_str(l_str1,"|","','")
                     LET l_str1="'",l_str1,"'"
                     LET l_sql=l_sql," AND glav001 IN (SELECT DISTINCT glaa003 FROM glaa_t",
                                     "                 WHERE glaaent=",g_enterprise," AND glaald IN (",l_str1,") )"
                  END IF
                  IF NOT cl_null(g_glfa004) THEN
                     LET l_sql=l_sql," AND glav001 IN (SELECT DISTINCT glaa003 FROM glaa_t",
                                     "                 WHERE glaaent=",g_enterprise," AND glaa004='",g_glfa004,"' )" 
                  END IF                   
                  PREPARE aglq852_sel_glav_pr FROM l_sql
                  EXECUTE aglq852_sel_glav_pr INTO l_glav006
                  
                  IF NOT cl_null(l_glav006) THEN
                     IF tm.smonth>l_glav006 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'sub-00427'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = FALSE
                        CALL cl_err()
                        NEXT FIELD smonth
                     END IF
                  END IF
               END IF

            AFTER FIELD eyear
               IF NOT cl_null(tm.eyear) THEN
                  IF NOT cl_null(tm.syear) AND tm.eyear < tm.syear THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00373'
                     LET g_errparam.extend = tm.eyear
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     NEXT FIELD eyear
                  END IF
                  IF NOT cl_null(tm.syear) AND NOT cl_null(tm.smonth) AND NOT cl_null(tm.emonth) AND 
                     tm.syear = tm.eyear AND tm.emonth < tm.smonth THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00228'
                     LET g_errparam.extend = tm.emonth
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     NEXT FIELD emonth
                  END IF
               END IF
               
            AFTER FIELD emonth
               IF NOT cl_null(tm.emonth) THEN
                  IF NOT cl_null(tm.syear) AND NOT cl_null(tm.eyear) AND NOT cl_null(tm.smonth) AND 
                     tm.syear = tm.eyear AND tm.emonth < tm.smonth THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00228'
                     LET g_errparam.extend = tm.emonth
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     NEXT FIELD emonth
                  END IF
               
                  IF NOT cl_null(tm.eyear) THEN
                     #限制录入的期别不可超过最大期别
                     LET l_glav006 = NULL
                     LET l_sql="SELECT MAX(glav006) FROM glav_t ",
                               " WHERE glavent=",g_enterprise," AND glav002=",tm.eyear
                     IF NOT cl_null(tm.glfa005) THEN
                        LET l_str1=tm.glfa005
                        LET l_str1=cl_replace_str(l_str1,"|","','")
                        LET l_str1="'",l_str1,"'"
                        LET l_sql=l_sql," AND glav001 IN (SELECT DISTINCT glaa003 FROM glaa_t",
                                        "                 WHERE glaaent=",g_enterprise," AND glaald IN (",l_str1,") )"
                     END IF
                     IF NOT cl_null(g_glfa004) THEN
                        LET l_sql=l_sql," AND glav001 IN (SELECT DISTINCT glaa003 FROM glaa_t",
                                        "                 WHERE glaaent=",g_enterprise," AND glaa004='",g_glfa004,"' )" 
                     END IF                   
                     PREPARE aglq852_sel_glav_pr1 FROM l_sql
                     EXECUTE aglq852_sel_glav_pr1 INTO l_glav006
                     IF NOT cl_null(l_glav006) THEN
                        IF tm.emonth>l_glav006 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'sub-00427'
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = FALSE
                           CALL cl_err()
                           NEXT FIELD emonth
                        END IF
                     END IF
                  END IF
               END IF

            ON CHANGE fix_type
               IF NOT cl_null(tm.fix_type) THEN 
                  CALL cl_set_comp_entry('fix_acc',TRUE)
               ELSE
                  CALL cl_set_comp_entry('fix_acc',FALSE)
               END IF
               
            AFTER FIELD stus
               IF tm.stus NOT MATCHES '[123]' THEN
                  NEXT FIELD stus
               END IF
         
            AFTER FIELD show_ad
               IF tm.show_ad NOT MATCHES '[yYnN]' THEN
                  NEXT FIELD show_ad
               END IF
            
            ON CHANGE show_per
               IF tm.show_per NOT MATCHES '[yYnN]' THEN
                  NEXT FIELD show_ad
               END IF
            
            AFTER FIELD glfa009
                  IF NOT cl_ap_chk_Range(tm.glfa009,"0","1","","","azz-00079",1) THEN
                     NEXT FIELD glfa009
                  END IF
               
            ON CHANGE show_xrbl
               IF tm.show_xrbl = 'Y' THEN
                  CALL cl_set_comp_visible('b_glfb008',TRUE)
               ELSE
                  CALL cl_set_comp_visible('b_glfb008',FALSE)
               END IF
            
            ON CHANGE chg_curr
               IF tm.chg_curr = 'Y' THEN
                  CALL cl_set_comp_entry('curr,rate',TRUE)
               ELSE
                  CALL cl_set_comp_entry('curr,rate',FALSE)
                  LET tm.curr=''
                  LET tm.rate=''
                  DISPLAY BY NAME tm.curr,tm.rate
               END IF
            
            AFTER FIELD curr
               IF NOT cl_null(tm.curr) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#36  add
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1=tm.curr
                  LET g_chkparam.err_str[1] = "aoo-00011:sub-01302|aooi140|",cl_get_progname("aooi140",g_lang,"2"),"|:EXEPROGaooi140"  #160318-00025#36  add
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooai001") THEN
                     #檢查成功時後續處理
                  ELSE
                     #檢查失敗時後續處理
                     LET tm.curr=''
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
            AFTER FIELD rate
               IF NOT cl_null(tm.rate) THEN
                  CALL s_num_isnum(tm.rate) RETURNING l_success
                  IF l_success=FALSE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00036'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     NEXT FIELD rate
                  END IF
               END IF
         
            ON ACTION controlp INFIELD glfa001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " glfa002<> '3' "
               CALL q_glfa001()                          #呼叫開窗
               LET tm.glfa001 = g_qryparam.return1
               DISPLAY tm.glfa001 TO glfa001  #顯示到畫面上
               NEXT FIELD glfa001  
            
            ON ACTION controlp INFIELD glfa005
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #給予arg
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept
               IF NOT cl_null(tm.glfa001) THEN
                  LET g_qryparam.where = " glaa004='",g_glfa004,"'"
               END IF
               CALL q_authorised_ld()                                #呼叫開窗
               LET g_str = g_qryparam.return1
               LET tm.glfa005 = g_qryparam.return1
               DISPLAY tm.glfa005 TO glfa005  
               
               NEXT FIELD glfa005
               
            ON ACTION controlp INFIELD fix_acc
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CASE tm.fix_type
                  WHEN '1' #營運據點
                     LET g_qryparam.where = " ooef201 = 'Y' "   #161021-00037#2 add
                     CALL q_ooef001() 
                  WHEN '2' #部門
                     LET g_qryparam.where = "ooegstus='Y'"
                     CALL q_ooeg001_4()
                  WHEN '3' #利潤/成本中心
                     LET g_qryparam.where = "ooegstus='Y' AND ooeg003 IN ('1','2','3')"
                     CALL q_ooeg001_4() 
                  WHEN '4' #區域
                     CALL q_oocq002_287()  
                  WHEN '5' #交易客商
                     CALL q_pmaa001_25()      #160913-00017#3  add
                     #CALL q_pmaa001()        #160913-00017#3  mark               #呼叫開窗
                  WHEN '6' #帳款客戶
                     CALL q_pmaa001_25()      #160913-00017#3  add
                     #CALL q_pmaa001()        #160913-00017#3  mark               #呼叫開窗
                  WHEN '7' #客群
                     CALL q_oocq002_281() 
                  WHEN '8' #產品類別
                     CALL q_rtax001_1() 
                  WHEN '9' #經營方式
                     LET g_qryparam.arg1 = '6013'
                     CALL q_gzcb001()
                  WHEN '10' #渠道
                     CALL q_oojd001_2()
                  WHEN '11' #品牌
                     CALL q_oocq002_2002() 
                  WHEN '12' #人員
                     CALL q_ooag001_8()
                  WHEN '13' #專案
                     CALL q_pjba001()
                  WHEN '14' #WBS
                     LET g_qryparam.where = "pjbb012='1' "
                     CALL q_pjbb002()
                  WHEN '15' #自由核算項一
                     CALL q_glar024()
                  WHEN '16' #自由核算項二
                     CALL q_glar025()
                  WHEN '17' #自由核算項三
                     CALL q_glar026()
                  WHEN '18' #自由核算項四
                     CALL q_glar027()
                  WHEN '19' #自由核算項五
                     CALL q_glar028()
                  WHEN '20' #自由核算項六
                     CALL q_glar029()
                  WHEN '21' #自由核算項七
                     CALL q_glar030()
                  WHEN '22' #自由核算項八
                     CALL q_glar031()
                  WHEN '23' #自由核算項九
                     CALL q_glar032()
                  WHEN '24' #自由核算項十
                     CALL q_glar033()
               END CASE
               LET tm.fix_acc = g_qryparam.return1
               DISPLAY tm.fix_acc TO fix_acc  #顯示到畫面上
               NEXT FIELD fix_acc
               
            ON ACTION controlp INFIELD curr
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = tm.curr  
               CALL q_ooai001()                          #呼叫開窗
               LET tm.curr = g_qryparam.return1
               DISPLAY tm.curr TO curr  #顯示到畫面上
               NEXT FIELD curr 
      END INPUT
      ON ACTION accept
         #add-point:ON ACTION accept

         #end add-point
 
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
 
      #add-point:query段查詢方案相關ACTION設定前

      #end add-point 
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         #add-point:條件清除後

         #end add-point 
 
      #add-point:query段查詢方案相關ACTION設定後

      #end add-point 
 
   END DIALOG
 
   
 
   LET g_wc = g_wc_table 
 
 
        
   LET g_wc2 = " 1=1"
 
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      LET g_wc_filter = g_wc_filter_t
      LET g_str=NULL
      CALL cl_set_act_visible("accept,cancel", FALSE)
      RETURN
   ELSE
      LET g_master_idx = 1
   END IF
   
   IF NOT cl_null(g_str) THEN
      LET g_str=cl_replace_str(g_str,"|","','")
      LET g_str="'",g_str,"'"
   END IF
  
   CALL aglq852_cs()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
   CALL cl_set_act_visible("accept,cancel", FALSE)
END FUNCTION

 
{</section>}
 
