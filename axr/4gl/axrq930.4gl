#該程式未解開Section, 採用最新樣板產出!
{<section id="axrq930.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2015-01-16 17:28:06), PR版次:0002(2015-01-23 09:53:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000074
#+ Filename...: axrq930
#+ Description: 應收未收暨帳齡查詢作業
#+ Creator....: 02599(2014-09-17 14:57:42)
#+ Modifier...: 01727 -SD/PR- 01727
 
{</section>}
 
{<section id="axrq930.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
# Modify.....: 141226-00016#13 15/01/12 By zhangwei 1.帳套移至單身顯示,[交易對象]移至前面帳套欄位之後
#            :                                        帳套移到單身多影響了跟會計年度有關的計算及預設值變更
#            :                                        原單頭帳套保留方便作其他欄位預設值用
#            :                                        原單頭期別因帳套到單身改為固定13期
#            :                                      2.依單頭的[帳務中心]展開,符合組織範圍內的法人帳套者 且 USER有該帳套權限者,皆可顯示
#            :                                      3.單身可二次篩選資料,含[帳套]欄位處理
#            :                                        修正二次篩選問題
#            :                                      4.[彙總訊息]不分帳套別合併顯示
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
 
#單身 type 宣告
PRIVATE TYPE type_g_xrcc_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   xrcbsite LIKE xrcb_t.xrcbsite, 
   xrcald LIKE type_t.chr500, 
   glaal002 LIKE type_t.chr500, 
   xrca004 LIKE type_t.chr500, 
   xrca004_desc LIKE type_t.chr500, 
   xrca001 LIKE type_t.chr500, 
   xrccdocno LIKE type_t.chr500, 
   xrccseq LIKE type_t.chr500, 
   xrcc001 LIKE type_t.chr500, 
   xrcadocdt LIKE xrca_t.xrcadocdt, 
   xrcc004 LIKE xrcc_t.xrcc004, 
   delay LIKE type_t.chr500, 
   xrek037 LIKE type_t.chr500, 
   xrcc100 LIKE xrcc_t.xrcc100, 
   xrcc108 LIKE xrcc_t.xrcc108, 
   xrcc118 LIKE xrcc_t.xrcc118, 
   xrek039 LIKE xrek_t.xrek039, 
   xrcc104 LIKE xrcc_t.xrcc104, 
   xrcc114 LIKE xrcc_t.xrcc114 
       END RECORD
PRIVATE TYPE type_g_xrcc2_d RECORD
       xrcborga LIKE xrcb_t.xrcborga, 
   xrca001 LIKE xrca_t.xrca001, 
   xrccdocno LIKE xrcc_t.xrccdocno, 
   xrccseq LIKE xrcc_t.xrccseq, 
   xrcc001 LIKE xrcc_t.xrcc001, 
   xrca004 LIKE xrca_t.xrca004, 
   xrca004_2_desc LIKE type_t.chr500, 
   xrcadocdt LIKE xrca_t.xrcadocdt, 
   xrcc004 LIKE xrcc_t.xrcc004, 
   delay2 LIKE type_t.chr500, 
   xrek037 LIKE xrek_t.xrek037, 
   xrcc128 LIKE xrcc_t.xrcc128, 
   xrek039 LIKE xrek_t.xrek039, 
   xrcc124 LIKE xrcc_t.xrcc124
       END RECORD
 
PRIVATE TYPE type_g_xrcc3_d RECORD
       xrcborga LIKE xrcb_t.xrcborga, 
   xrca001 LIKE xrca_t.xrca001, 
   xrccdocno LIKE xrcc_t.xrccdocno, 
   xrccseq LIKE xrcc_t.xrccseq, 
   xrcc001 LIKE xrcc_t.xrcc001, 
   xrca004 LIKE xrca_t.xrca004, 
   xrca004_3_desc LIKE type_t.chr500, 
   xrcadocdt LIKE xrca_t.xrcadocdt, 
   xrcc004 LIKE xrcc_t.xrcc004, 
   delay3 LIKE type_t.chr500, 
   xrek037 LIKE xrek_t.xrek037, 
   xrcc138 LIKE xrcc_t.xrcc138, 
   xrek039 LIKE xrek_t.xrek039, 
   xrcc134 LIKE xrcc_t.xrcc134
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_xrcc4_d RECORD
      option_4       LIKE type_t.chr100, 
      xrcc100_4      LIKE xrcc_t.xrcc100,
      amt1_4         LIKE xrcc_t.xrcc108, 
      amt2_4         LIKE xrcc_t.xrcc118,
      amt3_4         LIKE xrcc_t.xrcc108, 
      amt4_4         LIKE xrcc_t.xrcc118,
      amt5_4         LIKE xrcc_t.xrcc108, 
      amt6_4         LIKE xrcc_t.xrcc118,
      amt7_4         LIKE xrcc_t.xrcc108, 
      amt8_4         LIKE xrcc_t.xrcc118,      
      xrcc104_4      LIKE xrcc_t.xrcc108, 
      xrcc114_4      LIKE xrcc_t.xrcc118, 
      xrcc118_401    LIKE xrcc_t.xrcc118, 
      xrcc114_401    LIKE xrcc_t.xrcc118, 
      xrcc118_402    LIKE xrcc_t.xrcc118, 
      xrcc114_402    LIKE xrcc_t.xrcc118, 
      xrcc118_403    LIKE xrcc_t.xrcc118, 
      xrcc114_403    LIKE xrcc_t.xrcc118, 
      xrcc118_404    LIKE xrcc_t.xrcc118, 
      xrcc114_404    LIKE xrcc_t.xrcc118, 
      xrcc118_405    LIKE xrcc_t.xrcc118, 
      xrcc114_405    LIKE xrcc_t.xrcc118, 
      xrcc118_406    LIKE xrcc_t.xrcc118, 
      xrcc114_406    LIKE xrcc_t.xrcc118, 
      xrcc118_407    LIKE xrcc_t.xrcc118, 
      xrcc114_407    LIKE xrcc_t.xrcc118, 
      xrcc118_408    LIKE xrcc_t.xrcc118, 
      xrcc114_408    LIKE xrcc_t.xrcc118, 
      xrcc118_409    LIKE xrcc_t.xrcc118, 
      xrcc114_409    LIKE xrcc_t.xrcc118, 
      xrcc118_410    LIKE xrcc_t.xrcc118, 
      xrcc114_410    LIKE xrcc_t.xrcc118, 
      xrcc118_411    LIKE xrcc_t.xrcc118, 
      xrcc114_411    LIKE xrcc_t.xrcc118, 
      xrcc118_412    LIKE xrcc_t.xrcc118, 
      xrcc114_412    LIKE xrcc_t.xrcc118, 
      xrcc118_413    LIKE xrcc_t.xrcc118, 
      xrcc114_413    LIKE xrcc_t.xrcc118, 
      xrcc118_414    LIKE xrcc_t.xrcc118, 
      xrcc114_414    LIKE xrcc_t.xrcc118, 
      xrcc118_415    LIKE xrcc_t.xrcc118, 
      xrcc114_415    LIKE xrcc_t.xrcc118, 
      xrcc118_416    LIKE xrcc_t.xrcc118, 
      xrcc114_416    LIKE xrcc_t.xrcc118, 
      xrcc118_417    LIKE xrcc_t.xrcc118, 
      xrcc114_417    LIKE xrcc_t.xrcc118, 
      xrcc118_418    LIKE xrcc_t.xrcc118, 
      xrcc114_418    LIKE xrcc_t.xrcc118, 
      xrcc118_419    LIKE xrcc_t.xrcc118, 
      xrcc114_419    LIKE xrcc_t.xrcc118, 
      xrcc118_420    LIKE xrcc_t.xrcc118, 
      xrcc114_420    LIKE xrcc_t.xrcc118
                     END RECORD
 TYPE type_g_xrcc5_d RECORD
      option_5       LIKE type_t.chr100, 
      xrcc100_5      LIKE xrcc_t.xrcc100,
      amt9_5         LIKE xrcc_t.xrcc108, 
      amt10_5        LIKE xrcc_t.xrcc128, 
      amt11_5        LIKE xrcc_t.xrcc108,
      amt12_5        LIKE xrcc_t.xrcc108,      
      xrcc124_5      LIKE xrcc_t.xrcc118, 
      xrcc128_501    LIKE xrcc_t.xrcc128, 
      xrcc124_501    LIKE xrcc_t.xrcc128, 
      xrcc128_502    LIKE xrcc_t.xrcc128, 
      xrcc124_502    LIKE xrcc_t.xrcc128, 
      xrcc128_503    LIKE xrcc_t.xrcc128, 
      xrcc124_503    LIKE xrcc_t.xrcc128, 
      xrcc128_504    LIKE xrcc_t.xrcc128, 
      xrcc124_504    LIKE xrcc_t.xrcc128, 
      xrcc128_505    LIKE xrcc_t.xrcc128, 
      xrcc124_505    LIKE xrcc_t.xrcc128, 
      xrcc128_506    LIKE xrcc_t.xrcc128, 
      xrcc124_506    LIKE xrcc_t.xrcc128, 
      xrcc128_507    LIKE xrcc_t.xrcc128, 
      xrcc124_507    LIKE xrcc_t.xrcc128, 
      xrcc128_508    LIKE xrcc_t.xrcc128, 
      xrcc124_508    LIKE xrcc_t.xrcc128, 
      xrcc128_509    LIKE xrcc_t.xrcc128, 
      xrcc124_509    LIKE xrcc_t.xrcc128, 
      xrcc128_510    LIKE xrcc_t.xrcc128, 
      xrcc124_510    LIKE xrcc_t.xrcc128, 
      xrcc128_511    LIKE xrcc_t.xrcc128, 
      xrcc124_511    LIKE xrcc_t.xrcc128, 
      xrcc128_512    LIKE xrcc_t.xrcc128, 
      xrcc124_512    LIKE xrcc_t.xrcc128, 
      xrcc128_513    LIKE xrcc_t.xrcc128, 
      xrcc124_513    LIKE xrcc_t.xrcc128, 
      xrcc128_514    LIKE xrcc_t.xrcc128, 
      xrcc124_514    LIKE xrcc_t.xrcc128, 
      xrcc128_515    LIKE xrcc_t.xrcc128, 
      xrcc124_515    LIKE xrcc_t.xrcc128, 
      xrcc128_516    LIKE xrcc_t.xrcc128, 
      xrcc124_516    LIKE xrcc_t.xrcc128, 
      xrcc128_517    LIKE xrcc_t.xrcc128, 
      xrcc124_517    LIKE xrcc_t.xrcc128, 
      xrcc128_518    LIKE xrcc_t.xrcc128, 
      xrcc124_518    LIKE xrcc_t.xrcc128, 
      xrcc128_519    LIKE xrcc_t.xrcc128, 
      xrcc124_519    LIKE xrcc_t.xrcc128, 
      xrcc128_520    LIKE xrcc_t.xrcc128, 
      xrcc124_520    LIKE xrcc_t.xrcc128
                     END RECORD
 TYPE type_g_xrcc6_d RECORD
      option_6       LIKE type_t.chr100, 
      xrcc100_6      LIKE xrcc_t.xrcc100,
      amt13_6        LIKE xrcc_t.xrcc108, 
      amt14_6        LIKE xrcc_t.xrcc138, 
      amt15_6        LIKE xrcc_t.xrcc104,
      amt16_6        LIKE xrcc_t.xrcc104,      
      xrcc134_6      LIKE xrcc_t.xrcc138, 
      xrcc138_601    LIKE xrcc_t.xrcc138, 
      xrcc134_601    LIKE xrcc_t.xrcc138, 
      xrcc138_602    LIKE xrcc_t.xrcc138, 
      xrcc134_602    LIKE xrcc_t.xrcc138, 
      xrcc138_603    LIKE xrcc_t.xrcc138, 
      xrcc134_603    LIKE xrcc_t.xrcc138, 
      xrcc138_604    LIKE xrcc_t.xrcc138, 
      xrcc134_604    LIKE xrcc_t.xrcc138, 
      xrcc138_605    LIKE xrcc_t.xrcc138, 
      xrcc134_605    LIKE xrcc_t.xrcc138, 
      xrcc138_606    LIKE xrcc_t.xrcc138, 
      xrcc134_606    LIKE xrcc_t.xrcc138, 
      xrcc138_607    LIKE xrcc_t.xrcc138, 
      xrcc134_607    LIKE xrcc_t.xrcc138, 
      xrcc138_608    LIKE xrcc_t.xrcc138, 
      xrcc134_608    LIKE xrcc_t.xrcc138, 
      xrcc138_609    LIKE xrcc_t.xrcc138, 
      xrcc134_609    LIKE xrcc_t.xrcc138, 
      xrcc138_610    LIKE xrcc_t.xrcc138, 
      xrcc134_610    LIKE xrcc_t.xrcc138, 
      xrcc138_611    LIKE xrcc_t.xrcc138, 
      xrcc134_611    LIKE xrcc_t.xrcc138, 
      xrcc138_612    LIKE xrcc_t.xrcc138, 
      xrcc134_612    LIKE xrcc_t.xrcc138, 
      xrcc138_613    LIKE xrcc_t.xrcc138, 
      xrcc134_613    LIKE xrcc_t.xrcc138, 
      xrcc138_614    LIKE xrcc_t.xrcc138, 
      xrcc134_614    LIKE xrcc_t.xrcc138, 
      xrcc138_615    LIKE xrcc_t.xrcc138, 
      xrcc134_615    LIKE xrcc_t.xrcc138, 
      xrcc138_616    LIKE xrcc_t.xrcc138, 
      xrcc134_616    LIKE xrcc_t.xrcc138, 
      xrcc138_617    LIKE xrcc_t.xrcc138, 
      xrcc134_617    LIKE xrcc_t.xrcc138, 
      xrcc138_618    LIKE xrcc_t.xrcc138, 
      xrcc134_618    LIKE xrcc_t.xrcc138, 
      xrcc138_619    LIKE xrcc_t.xrcc138, 
      xrcc134_619    LIKE xrcc_t.xrcc138, 
      xrcc138_620    LIKE xrcc_t.xrcc138, 
      xrcc134_620    LIKE xrcc_t.xrcc138
                     END RECORD
DEFINE g_xrcc4_d   DYNAMIC ARRAY OF type_g_xrcc4_d
DEFINE g_xrcc4_d_t type_g_xrcc4_d
DEFINE g_xrcc5_d   DYNAMIC ARRAY OF type_g_xrcc5_d
DEFINE g_xrcc5_d_t type_g_xrcc5_d
DEFINE g_xrcc6_d   DYNAMIC ARRAY OF type_g_xrcc6_d
DEFINE g_xrcc6_d_t type_g_xrcc6_d

DEFINE g_wc_i                STRING
TYPE type_g_xrca_m           RECORD
            xrcasite          LIKE xrca_t.xrcasite,
            xrcasite_desc     LIKE ooefl_t.ooefl003,
            xrcald            LIKE xrca_t.xrcald, 
            xrcald_desc       LIKE glaal_t.glaal002, 
            xrcacomp          LIKE xrca_t.xrcacomp, 
            xrcacomp_desc     LIKE ooefl_t.ooefl003, 
            year              LIKE type_t.num5, 
            month             LIKE type_t.num5, 
            sum_type          LIKE type_t.chr1,
            xrad001           LIKE xrad_t.xrad001,
            xrad001_desc      LIKE xradl_t.xradl003,
            xrad004           LIKE xrad_t.xrad004,
            chk_a             LIKE type_t.chr1,
            chk_b             LIKE type_t.chr1,
            glcb008           LIKE glcb_t.glcb008,
            chk_c             LIKE type_t.chr1
                             END RECORD
DEFINE g_xrca_m          type_g_xrca_m
DEFINE g_xref004         LIKE xref_t.xref004
DEFINE g_xrad004         LIKE xrad_t.xrad004
DEFINE g_xref006         LIKE xref_t.xref006
DEFINE g_rec_b           LIKE type_t.num10
DEFINE g_glaa003         LIKE glaa_t.glaa003
DEFINE g_glaa015         LIKE glaa_t.glaa015
DEFINE g_glaa019         LIKE glaa_t.glaa019
DEFINE g_wc_filter2      STRING   #2015/01/16
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_xrcc_d
DEFINE g_master_t                   type_g_xrcc_d
DEFINE g_xrcc_d          DYNAMIC ARRAY OF type_g_xrcc_d
DEFINE g_xrcc_d_t        type_g_xrcc_d
DEFINE g_xrcc2_d   DYNAMIC ARRAY OF type_g_xrcc2_d
DEFINE g_xrcc2_d_t type_g_xrcc2_d
 
DEFINE g_xrcc3_d   DYNAMIC ARRAY OF type_g_xrcc3_d
DEFINE g_xrcc3_d_t type_g_xrcc3_d
 
 
      
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10              
DEFINE l_ac_d               LIKE type_t.num10              #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num5              #目前所在頁數
DEFINE g_detail_cnt         LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_detail_cnt2        LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num10
DEFINE g_detail_idx         LIKE type_t.num10
DEFINE g_detail_idx2        LIKE type_t.num10
DEFINE g_hyper_url          STRING                        #hyperlink的主要網址
DEFINE g_tot_cnt            LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page        LIKE type_t.num10             #每頁筆數
DEFINE g_current_row_tot    LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_act_list      STRING                        #分頁ACTION清單
DEFINE g_page_start_num     LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num       LIKE type_t.num10             #目前頁面結束筆數
 
#多table用wc
DEFINE g_wc_table           STRING
DEFINE g_wc_filter_table    STRING
DEFINE g_detail_page_action STRING
DEFINE g_pagestart          LIKE type_t.num10
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

##end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axrq930.main" >}
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
   CALL cl_ap_init("axr","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   CALL axrq930_create_temp_table()
   #end add-point
   LET g_forupd_sql = " ", 
                      " FROM ",
                      " "
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrq930_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axrq930_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrq930_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrq930 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrq930_init()   
 
      #進入選單 Menu (="N")
      CALL axrq930_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axrq930
      
   END IF 
   
   CLOSE axrq930_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE axrq930_tmp
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axrq930.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axrq930_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
DEFINE l_sql      STRING
DEFINE l_str      STRING 
DEFINE l_gzcb002  LIKE gzcb_t.gzcb002 
DEFINE l_success  LIKE type_t.num5
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL s_fin_set_comp_scc('year','43')
   CALL cl_set_combo_scc('xrad004','8312')
   CALL cl_set_combo_scc('xrca001','8302')
   CALL cl_set_combo_scc('xrca001_2','8302')
   CALL cl_set_combo_scc('xrca001_3','8302')
   CALL cl_set_combo_scc('sum_type','8330')
   CALL cl_set_combo_scc('glcb008','8328')   #扣除方式

   LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8312' AND gzcb003 = 'Y'",
               " ORDER BY gzcb002 ASC"
   PREPARE xrca001_pre FROM l_sql
   DECLARE xrca001_cur CURSOR FOR xrca001_pre
   LET l_str = Null
   LET l_gzcb002 = Null
   FOREACH xrca001_cur INTO l_gzcb002
      IF cl_null(l_str) THEN LET l_str = l_gzcb002 CONTINUE FOREACH END IF
      LET l_str = l_str,",",l_gzcb002
   END FOREACH

   CALL cl_set_combo_scc_part('xrad004','8312',l_str) 

   CALL axrq930_default()
   CALL s_fin_create_account_center_tmp()   #帳務組織底下所屬組織開窗的temptable
   #end add-point
 
   CALL axrq930_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="axrq930.default_search" >}
PRIVATE FUNCTION axrq930_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xrccld = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " xrccdocno = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " xrccseq = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " xrcc001 = '", g_argv[04], "' AND "
   END IF
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段開始後 name="default_search.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq930.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION axrq930_ui_dialog()
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE li_idx     LIKE type_t.num10
   DEFINE lc_action_choice_old     STRING
   DEFINE lc_current_row           LIKE type_t.num10
   DEFINE ls_js      STRING
   DEFINE la_param   RECORD
                     prog       STRING,
                     actionid   STRING,
                     background LIKE type_t.chr1,
                     param      DYNAMIC ARRAY OF STRING
                     END RECORD
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   
   #end add-point 
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   
   #end add-point
 
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
         
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   LET g_wc = " 1=1"
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL axrq930_b_fill()
   ELSE
      CALL axrq930_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xrcc_d.clear()
         CALL g_xrcc2_d.clear()
 
         CALL g_xrcc3_d.clear()
 
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 1
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL axrq930_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_xrcc_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL axrq930_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL axrq930_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
         DISPLAY ARRAY g_xrcc2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               DISPLAY g_xrcc2_d.getLength() TO FORMONLY.cnt
               #add-point:input段before row name="input.body2.before_row"
               
               #end add-point 
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_xrcc3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 3
            
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               DISPLAY g_xrcc3_d.getLength() TO FORMONLY.cnt
               #add-point:input段before row name="input.body3.before_row"
               
               #end add-point 
 
            #自訂ACTION(detail_show,page_3)
            
 
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
 
         END DISPLAY
 
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_xrcc4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_xrcc4_d.getLength() TO FORMONLY.h_count
               CALL axrq930_fetch()
               LET g_master_idx = l_ac
               
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               
         END DISPLAY
         DISPLAY ARRAY g_xrcc5_d TO s_detail5.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_xrcc5_d.getLength() TO FORMONLY.h_count
               CALL axrq930_fetch()
               LET g_master_idx = l_ac
               
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)      
            
         END DISPLAY
         DISPLAY ARRAY g_xrcc6_d TO s_detail6.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_xrcc6_d.getLength() TO FORMONLY.h_count
               CALL axrq930_fetch()
               LET g_master_idx = l_ac
                          
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)      
            
         END DISPLAY
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL axrq930_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
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
               CALL axrq930_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
               #END add-point
               
               
            END IF
 
 
 
 
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axrq930_filter()
            #add-point:ON ACTION filter name="menu.filter"
            CALL axrq930_filter2()#2015/01/16
            #END add-point
 
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
 
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION datarefresh   # 重新整理
            LET g_error_show = 1
            CALL axrq930_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_xrcc_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_xrcc2_d)
               LET g_export_id[2]   = "s_detail2"
 
               LET g_export_node[3] = base.typeInfo.create(g_xrcc3_d)
               LET g_export_id[3]   = "s_detail3"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               LET g_export_node[4] = base.typeInfo.create(g_xrcc4_d)
               LET g_export_id[4]   = "s_detail4"
               LET g_export_node[5] = base.typeInfo.create(g_xrcc5_d)
               LET g_export_id[5]   = "s_detail5"
 
               LET g_export_node[6] = base.typeInfo.create(g_xrcc6_d)
               LET g_export_id[6]   = "s_detail6"
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            CALL axrq930_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL axrq930_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL axrq930_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL axrq930_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_xrcc_d.getLength()
               LET g_xrcc_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_xrcc_d.getLength()
               LET g_xrcc_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_xrcc_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xrcc_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_xrcc_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xrcc_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         
         #end add-point
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
 
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"
         
         #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         
         #end add-point
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq930.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axrq930_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_success         LIKE type_t.num5
  #141226-00016#13 15/01/12 Mark
  #CALL axrq930_query1()
  #RETURN
  #141226-00016#13 15/01/12 Mark
   LET g_wc_filter2 = " 1=1"
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_xrcc_d.clear()
   CALL g_xrcc2_d.clear()
 
   CALL g_xrcc3_d.clear()
 
 
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_wc_filter = " 1=1"
   LET g_detail_page_action = ""
   LET g_pagestart = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET ls_wc2 = g_wc2
   LET g_master_idx = l_ac
 
   
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON xrcbsite
           FROM s_detail1[1].b_xrcbsite
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_xrcbsite>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrcbsite
            #add-point:BEFORE FIELD b_xrcbsite name="construct.b.page1.b_xrcbsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrcbsite
            
            #add-point:AFTER FIELD b_xrcbsite name="construct.a.page1.b_xrcbsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xrcbsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcbsite
            #add-point:ON ACTION controlp INFIELD b_xrcbsite name="construct.c.page1.b_xrcbsite"
            
            #END add-point
 
 
         #----<<xrcald>>----
         #----<<glaal002>>----
         #----<<xrca004>>----
         #----<<xrca004_desc>>----
         #----<<xrca001>>----
         #----<<xrccdocno>>----
         #----<<xrccseq>>----
         #----<<xrcc001>>----
         #----<<delay>>----
         #----<<xrek037>>----
         #----<<xrca004_2_desc>>----
         #----<<delay2>>----
         #----<<xrca004_3_desc>>----
         #----<<delay3>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
     #141226-00016#13 15/01/12 Add
      INPUT BY NAME g_xrca_m.xrcasite,g_xrca_m.year,g_xrca_m.month,g_xrca_m.sum_type,g_xrca_m.xrad001,
                    g_xrca_m.xrad004,g_xrca_m.chk_a,g_xrca_m.chk_b,g_xrca_m.glcb008,g_xrca_m.chk_c
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
            DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc,g_xrca_m.year,
                            g_xrca_m.month,g_xrca_m.sum_type,g_xrca_m.xrad001,g_xrca_m.xrad001_desc,
                            g_xrca_m.xrad004,g_xrca_m.chk_a,g_xrca_m.chk_b,
                            g_xrca_m.glcb008,g_xrca_m.chk_c

         AFTER FIELD xrcasite
            IF NOT cl_null(g_xrca_m.xrcasite) THEN
               #資料存在性、有效性檢查
               LET g_errno = ' '
               CALL s_fin_account_center_chk(g_xrca_m.xrcasite,'',3,g_today) RETURNING l_success,g_errno
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_xrca_m.xrcasite
                  LET g_errparam.code   = g_errno
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
           CALL axrq930_xrca_ref('xrcasite')

         AFTER FIELD xrad001
            IF NOT cl_null(g_xrca_m.xrad001) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_xrca_m.xrad001
               IF NOT cl_chk_exist("v_xrad001") THEN
                  LET g_xrca_m.xrad001=''
                  CALL axrq930_xrca_ref("xrad001")
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL axrq930_xrca_ref("xrad001")

         ON CHANGE chk_c
            IF NOT cl_null(g_xrca_m.chk_c) THEN
               IF g_xrca_m.chk_c = 'Y' THEN
                  CALL cl_set_comp_visible('xrcc100_1,xrcc108_1,xrcc104_1',TRUE)
                  CALL cl_set_comp_visible('xrcc100_4,amt1_4,amt2_4,amt3_4,amt4_4',TRUE)
               ELSE
                  CALL cl_set_comp_visible('xrcc100_1,xrcc108_1,xrcc104_1',FALSE)
                  CALL cl_set_comp_visible('xrcc100_4,amt1_4,amt2_4,amt3_4,amt4_4',FALSE)
               END IF
            END IF

         ON ACTION controlp INFIELD xrcasite
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrca_m.xrcasite             #給予default值
            LET g_qryparam.where = " ooef201 = 'Y' "
            CALL q_ooef001()                                        #呼叫開窗
            LET g_xrca_m.xrcasite = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_xrca_m.xrcasite TO xrcasite                   #顯示到畫面上
            CALL axrq930_xrca_ref('xrcasite')
            NEXT FIELD xrcasite 

         ON ACTION controlp INFIELD xrad001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_xrca_m.xrad001           #給予default值
               CALL axri014_01()                                    #呼叫開窗
               LET g_xrca_m.xrad001 = g_qryparam.return1              
               DISPLAY g_xrca_m.xrad001 TO xrad001
               CALL axrq930_xrca_ref('xrad001')
               NEXT FIELD xrad001                                   #返回原欄位
      END INPUT
     #141226-00016#13 15/01/12 Add
      #end add-point 
 
      ON ACTION accept
         #add-point:ON ACTION accept name="query.accept"
         
         #end add-point
 
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
 
      #add-point:query段查詢方案相關ACTION設定前 name="query.set_qbe_action_before"
      
      #end add-point 
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         #add-point:條件清除後 name="query.qbeclear"
         
         #end add-point 
 
      #add-point:query段查詢方案相關ACTION設定後 name="query.set_qbe_action_after"
      INITIALIZE g_xrca_m.* TO NULL
      CALL axrq930_default()
      #end add-point 
 
   END DIALOG
 
   
 
   LET g_wc = g_wc_table 
 
 
   
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
 
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = " 1=2"
      LET g_wc2 = " 1=1"
      LET g_wc_filter = g_wc_filter_t
      RETURN
   ELSE
      LET g_master_idx = 1
   END IF
        
   #add-point:cs段after_construct name="cs.after_construct"
   #141226-00016#13 15/01/12 Add
    CALL axrq930_get_data()
   #141226-00016#13 15/01/12 Add
   #end add-point
        
   LET g_error_show = 1
   CALL axrq930_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = -100 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   END IF
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
   
END FUNCTION
 
{</section>}
 
{<section id="axrq930.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrq930_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_success         LIKE type_t.num5
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(g_wc_filter2) THEN#2015/01/16
      LET g_wc_filter2 = "1=1"
   END IF
   #end add-point
 
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:40) add cl_sql_auth_filter()
 
   LET ls_sql_rank = "SELECT  UNIQUE '','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY xrcc_t.xrccld, 
       xrcc_t.xrccdocno,xrcc_t.xrccseq,xrcc_t.xrcc001) AS RANK FROM xrcc_t",
 
 
                     "",
                     " WHERE AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xrcc_t"),
                     " ORDER BY xrcc_t.xrccld,xrcc_t.xrccdocno,xrcc_t.xrccseq,xrcc_t.xrcc001"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql
   EXECUTE b_fill_cnt_pre USING g_enterprise INTO g_tot_cnt
   FREE b_fill_cnt_pre
 
   #add-point:b_fill段rank_sql_after_count name="b_fill.rank_sql_after_count"
   
   #end add-point
 
   CASE g_detail_page_action
      WHEN "detail_first"
          LET g_pagestart = 1
 
      WHEN "detail_previous"
          LET g_pagestart = g_pagestart - g_num_in_page
          IF g_pagestart < 1 THEN
              LET g_pagestart = 1
          END IF
 
      WHEN "detail_next"
         LET g_pagestart = g_pagestart + g_num_in_page
         IF g_pagestart > g_tot_cnt THEN
            LET g_pagestart = g_tot_cnt - (g_tot_cnt mod g_num_in_page) + 1
            WHILE g_pagestart > g_tot_cnt
               LET g_pagestart = g_pagestart - g_num_in_page
            END WHILE
         END IF
 
      WHEN "detail_last"
         LET g_pagestart = g_tot_cnt - (g_tot_cnt mod g_num_in_page) + 1
         WHILE g_pagestart > g_tot_cnt
            LET g_pagestart = g_pagestart - g_num_in_page
         END WHILE
 
      OTHERWISE
         LET g_pagestart = 1
 
   END CASE
 
   LET g_sql = "SELECT '','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql=" SELECT UNIQUE 'N','',xrcald,'',xrca004,'',xrca001,xrccdocno,xrccseq,xrcc001,xrcadocdt,",
             "        xrcc004,delay,xrek037,xrcc100,xrcc108 - xrcc109 - xrcc106,",
             "        xrcc118 - xrcc119 + xrcc113 -xrcc116,xrek039,xrcc104,xrcc114,",
             "        '',xrca001,xrccdocno,xrccseq,xrcc001,xrca004,'',xrcadocdt,",
             "        xrcc004,delay,xrek037,xrcc128 - xrcc129 + xrcc123 - xrcc126,xrek039,xrcc124,",
             "        '',xrca001,xrccdocno,xrccseq,xrcc001,xrca004,'',xrcadocdt,",
             "        xrcc004,delay,xrek037,xrcc138 - xrcc139 + xrcc133 - xrcc136,xrek039,xrcc134 ",
             "   FROM axrq930_tmp",
             "  WHERE ((xrcc108-xrcc106 <>0) OR (xrcc118-xrcc116 <>0)) ",#2015/01/16
             "    AND ",g_wc_filter2,  #2015/01/16
             "    AND xrcaent = ?"
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axrq930_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axrq930_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_xrcc_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   CALL g_xrcc2_d.clear()   
   CALL g_xrcc3_d.clear()
   CALL g_xrcc4_d.clear()
   CALL g_xrcc5_d.clear()
   CALL g_xrcc6_d.clear()
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_xrcc_d[l_ac].sel,g_xrcc_d[l_ac].xrcbsite,g_xrcc_d[l_ac].xrcald,g_xrcc_d[l_ac].glaal002, 
       g_xrcc_d[l_ac].xrca004,g_xrcc_d[l_ac].xrca004_desc,g_xrcc_d[l_ac].xrca001,g_xrcc_d[l_ac].xrccdocno, 
       g_xrcc_d[l_ac].xrccseq,g_xrcc_d[l_ac].xrcc001,g_xrcc_d[l_ac].xrcadocdt,g_xrcc_d[l_ac].xrcc004, 
       g_xrcc_d[l_ac].delay,g_xrcc_d[l_ac].xrek037,g_xrcc_d[l_ac].xrcc100,g_xrcc_d[l_ac].xrcc108,g_xrcc_d[l_ac].xrcc118, 
       g_xrcc_d[l_ac].xrek039,g_xrcc_d[l_ac].xrcc104,g_xrcc_d[l_ac].xrcc114,g_xrcc2_d[l_ac].xrcborga, 
       g_xrcc2_d[l_ac].xrca001,g_xrcc2_d[l_ac].xrccdocno,g_xrcc2_d[l_ac].xrccseq,g_xrcc2_d[l_ac].xrcc001, 
       g_xrcc2_d[l_ac].xrca004,g_xrcc2_d[l_ac].xrca004_2_desc,g_xrcc2_d[l_ac].xrcadocdt,g_xrcc2_d[l_ac].xrcc004, 
       g_xrcc2_d[l_ac].delay2,g_xrcc2_d[l_ac].xrek037,g_xrcc2_d[l_ac].xrcc128,g_xrcc2_d[l_ac].xrek039, 
       g_xrcc2_d[l_ac].xrcc124,g_xrcc3_d[l_ac].xrcborga,g_xrcc3_d[l_ac].xrca001,g_xrcc3_d[l_ac].xrccdocno, 
       g_xrcc3_d[l_ac].xrccseq,g_xrcc3_d[l_ac].xrcc001,g_xrcc3_d[l_ac].xrca004,g_xrcc3_d[l_ac].xrca004_3_desc, 
       g_xrcc3_d[l_ac].xrcadocdt,g_xrcc3_d[l_ac].xrcc004,g_xrcc3_d[l_ac].delay3,g_xrcc3_d[l_ac].xrek037, 
       g_xrcc3_d[l_ac].xrcc138,g_xrcc3_d[l_ac].xrek039,g_xrcc3_d[l_ac].xrcc134
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_xrcc_d[l_ac].statepic = cl_get_actipic(g_xrcc_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      CALL s_axrt300_xrca_ref('xrcald',g_xrcc_d[l_ac].xrcald,'','') RETURNING l_success,g_xrcc_d[l_ac].glaal002
      IF NOT cl_null(g_xrcc_d[l_ac].xrca004) THEN
         CALL s_axrt300_xrca_ref('xrca004',g_xrcc_d[l_ac].xrca004,'','') RETURNING l_success,g_xrcc_d[l_ac].xrca004_desc
         LET g_xrcc_d[l_ac].xrca004_desc = g_xrcc_d[l_ac].xrca004,"(",g_xrcc_d[l_ac].xrca004_desc,")"
      ELSE
         LET g_xrcc_d[l_ac].xrca004_desc = ""
      END IF
      #end add-point
 
      CALL axrq930_detail_show("'1'")      
 
      CALL axrq930_xrcc_t_mask()
 
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "" 
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
      
   END FOREACH
   LET g_error_show = 0
   
 
   
   CALL g_xrcc_d.deleteElement(g_xrcc_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"

   #顯示匯總資料
   #待抵資料處理
   CALL axrq930_analy_data()
   CALL axrq930_title()
   CALL axrq930_summary()
  
   #end add-point
 
   LET g_detail_cnt = g_xrcc_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE axrq930_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axrq930_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axrq930_detail_action_trans()
 
   IF g_xrcc_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL axrq930_fetch()
   END IF
   
      CALL axrq930_filter_show('xrcbsite','b_xrcbsite')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq930.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrq930_fetch()
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   RETURN
   #end add-point
   
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
   CALL g_xrcc2_d.clear()
 
   CALL g_xrcc3_d.clear()
 
 
   #add-point:陣列清空 name="fetch.array_clear"
   
   #end add-point
   
   LET li_ac = l_ac 
   
 
   
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point 
   
   CALL g_xrcc2_d.deleteElement(g_xrcc2_d.getLength())   
 
   #單身總筆數顯示
   LET g_detail_cnt2 = g_xrcc2_d.getLength()
   DISPLAY g_detail_cnt2 TO FORMONLY.cnt
   IF g_detail_cnt2 > 0 THEN
      LET g_detail_idx2 = 1
      DISPLAY g_detail_idx2 TO FORMONLY.idx
   ELSE
      LET g_detail_idx2 = 0
      DISPLAY ' ' TO FORMONLY.idx
   END IF
 
   CALL g_xrcc3_d.deleteElement(g_xrcc3_d.getLength())   
 
   #單身總筆數顯示
   LET g_detail_cnt2 = g_xrcc3_d.getLength()
   DISPLAY g_detail_cnt2 TO FORMONLY.cnt
   IF g_detail_cnt2 > 0 THEN
      LET g_detail_idx2 = 1
      DISPLAY g_detail_idx2 TO FORMONLY.idx
   ELSE
      LET g_detail_idx2 = 0
      DISPLAY ' ' TO FORMONLY.idx
   END IF
 
 
   #add-point:陣列筆數調整 name="fetch.array_deleteElement"
   
   #end add-point
 
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axrq930.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axrq930_detail_show(ps_page)
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
 
{<section id="axrq930.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axrq930_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   RETURN
   #end add-point
   
   #add-point:FUNCTION前置處理 name="filter.before_function"
   
   #end add-point
 
   LET l_ac = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON xrcbsite
                          FROM s_detail1[1].b_xrcbsite
 
         BEFORE CONSTRUCT
                     DISPLAY axrq930_filter_parser('xrcbsite') TO s_detail1[1].b_xrcbsite
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_xrcbsite>>----
         #Ctrlp:construct.c.filter.page1.b_xrcbsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcbsite
            #add-point:ON ACTION controlp INFIELD b_xrcbsite name="construct.c.filter.page1.b_xrcbsite"
            
            #END add-point
 
 
         #----<<xrcald>>----
         #----<<glaal002>>----
         #----<<xrca004>>----
         #----<<xrca004_desc>>----
         #----<<xrca001>>----
         #----<<xrccdocno>>----
         #----<<xrccseq>>----
         #----<<xrcc001>>----
         #----<<delay>>----
         #----<<xrek037>>----
         #----<<xrca004_2_desc>>----
         #----<<delay2>>----
         #----<<xrca004_3_desc>>----
         #----<<delay3>>----
   
 
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog name="filter.b_dialog"
         
         #end add-point  
 
      ON ACTION accept
         ACCEPT DIALOG 
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
 
   END DIALOG
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
      LET g_wc_filter_t = g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
   
      CALL axrq930_filter_show('xrcbsite','b_xrcbsite')
 
    
   CALL axrq930_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq930.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axrq930_filter_parser(ps_field)
   #add-point:filter段define-客製 name="filter_parser.define_customerization"
   
   #end add-point
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_parser.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter_parser.before_function"
   
   #end add-point
 
   #一般條件解析
   LET ls_tmp = ps_field, "='"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
   END IF
 
   #模糊條件解析
   LET ls_tmp = ps_field, " like '"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
      LET ls_var = cl_replace_str(ls_var,'%','*')
   END IF
 
   RETURN ls_var
 
END FUNCTION
 
{</section>}
 
{<section id="axrq930.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axrq930_filter_show(ps_field,ps_object)
   #add-point:filter_show段define-客製 name="filter_show.define_customerization"
   
   #end add-point
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
   #add-point:filter_show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter_show.before_function"
   
   #end add-point
 
   LET ls_name = "formonly.", ps_object
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = axrq930_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq930.insert" >}
#+ insert
PRIVATE FUNCTION axrq930_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axrq930.modify" >}
#+ modify
PRIVATE FUNCTION axrq930_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axrq930.reproduce" >}
#+ reproduce
PRIVATE FUNCTION axrq930_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axrq930.delete" >}
#+ delete
PRIVATE FUNCTION axrq930_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axrq930.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axrq930_detail_action_trans()
   #add-point:detail_action_trans段define-客製 name="detail_action_trans.define_customerization"
   
   #end add-point
   #add-point:detail_action_trans段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_action_trans.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_action_trans.before_function"
   
   #end add-point
 
   #因應單身切頁功能，筆數計算方式調整
   LET g_current_row_tot = g_pagestart + g_detail_idx - 1
   DISPLAY g_current_row_tot TO FORMONLY.h_index
   DISPLAY g_tot_cnt TO FORMONLY.h_count
 
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
 
{<section id="axrq930.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axrq930_detail_index_setting()
   #add-point:detail_index_setting段define-客製 name="deatil_index_setting.define_customerization"
   
   #end add-point
   DEFINE li_redirect     BOOLEAN
   DEFINE ldig_curr       ui.Dialog
   #add-point:detail_index_setting段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_index_setting.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_index_setting.before_function"
   
   #end add-point
 
   IF g_curr_diag IS NOT NULL THEN
      CASE
         WHEN g_curr_diag.getCurrentRow("s_detail1") <= "0"
            LET g_detail_idx = 1
            IF g_xrcc_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_xrcc_d.getLength() AND g_xrcc_d.getLength() > 0
            LET g_detail_idx = g_xrcc_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_xrcc_d.getLength() THEN
               LET g_detail_idx = g_xrcc_d.getLength()
            END IF
            LET li_redirect = TRUE
      END CASE
   END IF
 
   IF li_redirect THEN
      LET ldig_curr = ui.Dialog.getCurrent()
      CALL ldig_curr.setCurrentRow("s_detail1", g_detail_idx)
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axrq930.mask_functions" >}
 &include "erp/axr/axrq930_mask.4gl"
 
{</section>}
 
{<section id="axrq930.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 多語言欄位帶值
# Memo...........:
# Usage..........: CALL axrq930_xrca_ref(p_lab)
#                  RETURNING ---
# Input parameter: p_lab          欄位名稱
# Return code....: 
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq930_xrca_ref(p_lab)
   DEFINE p_lab         LIKE type_t.chr20

   CASE
      WHEN p_lab = 'xrcald'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xrca_m.xrcald
         CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xrca_m.xrcald_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_xrca_m.xrcald_desc
         #法人
         SELECT glaacomp,glaa003,glaa015,glaa019
         INTO g_xrca_m.xrcacomp,g_glaa003,g_glaa015,g_glaa019 
         FROM glaa_t 
         WHERE glaaent = g_enterprise AND glaald =  g_xrca_m.xrcald
         
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xrca_m.xrcacomp
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xrca_m.xrcacomp_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_xrca_m.xrcacomp,g_xrca_m.xrcacomp_desc
      WHEN p_lab = 'xrcasite'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xrca_m.xrcasite
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xrca_m.xrcasite_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_xrca_m.xrcasite_desc
      WHEN p_lab = 'xrad001'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xrca_m.xrad001
         CALL ap_ref_array2(g_ref_fields,"SELECT xradl003 FROM xradl_t WHERE xradlent='"||g_enterprise||"' AND xradl001=? AND xradl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xrca_m.xrad001_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_xrca_m.xrad001_desc
         #帳齡起算日基準
         SELECT xrad004 INTO g_xrca_m.xrad004 FROM xrad_t
         WHERE xradent=g_enterprise AND xrad001=g_xrca_m.xrad001
         DISPLAY BY NAME g_xrca_m.xrad004
   END CASE
   
END FUNCTION

################################################################################
# Descriptions...: 本位幣資訊匯總
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
PRIVATE FUNCTION axrq930_summary()
   DEFINE l_sql,l_sql1  STRING
   DEFINE l_str         STRING
   DEFINE l_str1        STRING
   DEFINE l_str2        STRING
   DEFINE l_group       STRING
   DEFINE l_glaa        RECORD LIKE glaa_t.*
   DEFINE l_count       LIKE type_t.num5
   DEFINE l_amt1,l_amt2 LIKE type_t.num5
   DEFINE l_group1      LIKE type_t.chr50
   DEFINE l_xrca004     LIKE xrca_t.xrca004
   DEFINE l_xrca035     LIKE xrca_t.xrca035
   DEFINE l_xrae002     LIKE xrae_t.xrae002
   DEFINE l_xrcc108     LIKE xrcc_t.xrcc108
   DEFINE l_xrcc128     LIKE xrcc_t.xrcc128
   DEFINE l_xrcc138     LIKE xrcc_t.xrcc138
   DEFINE l_xrcc118     LIKE xrcc_t.xrcc118
   DEFINE l_xrcc104     LIKE xrcc_t.xrcc108
   DEFINE l_xrcc114     LIKE xrcc_t.xrcc118
   DEFINE l_xrcc124     LIKE xrcc_t.xrcc128
   DEFINE l_xrcc134     LIKE xrcc_t.xrcc138
   DEFINE l_xrcc118_g   LIKE xrcc_t.xrcc118
   DEFINE l_xrcc114_g   LIKE xrcc_t.xrcc118
   DEFINE l_xrcc128_g   LIKE xrcc_t.xrcc128
   DEFINE l_xrcc124_g   LIKE xrcc_t.xrcc128
   DEFINE l_xrcc138_g   LIKE xrcc_t.xrcc138
   DEFINE l_xrcc134_g   LIKE xrcc_t.xrcc138
   DEFINE l_xrea103     LIKE xrea_t.xrea103
   DEFINE l_xrea113     LIKE xrea_t.xrea113
   DEFINE l_xrea123     LIKE xrea_t.xrea123
   DEFINE l_xrea133     LIKE xrea_t.xrea133
   DEFINE l_date_s      LIKE glav_t.glav004
   DEFINE l_date_e      LIKE glav_t.glav004
   DEFINE l_xrae003     LIKE xrae_t.xrae003
   DEFINE l_xrae004     LIKE xrae_t.xrae004
   DEFINE l_xrcc100     LIKE xrcc_t.xrcc100
   
   CASE
      WHEN g_xrca_m.sum_type = '1'   #應收科目
         LET l_str = "xrca035"
         LET l_str1= "xrca035 = ? "
      WHEN g_xrca_m.sum_type = '2'   #交易對象
         LET l_str = "xrca004"
         LET l_str1= "xrca004 = ? "
      WHEN g_xrca_m.sum_type = '3'   #業務部門
         LET l_str = "xrca015"
         LET l_str1= "xrca015 = ? "
      WHEN g_xrca_m.sum_type = '4'   #業務人員
         LET l_str = "xrca014"
         LET l_str1= "xrca014 = ? "
      WHEN g_xrca_m.sum_type = '5'   #對象＋科目
         LET l_str = "xrca004||'&'||xrca035"
         LET l_str1= "xrca004 = ? AND xrca035 = ? "
   END CASE

   LET l_sql = "SELECT ",l_str,",xrcc100,SUM(xrcc108-xrcc109-xrcc106),SUM(xrcc118-xrcc119+xrcc113-xrcc116),",
                               " SUM(xrcc128-xrcc129+xrcc123-xrcc126),SUM(xrcc138-xrcc139+xrcc133-xrcc136),",
                               " SUM(xrcc104),SUM(xrcc114),SUM(xrcc124),SUM(xrcc134), ",
                               " SUM(xrea103),SUM(xrea113),SUM(xrea123),SUM(xrea133)",
               "  FROM axrq930_tmp  ",
             "   WHERE ",g_wc_filter2,  #2015/01/16
               " GROUP BY ",l_str,",xrcc100"
   PREPARE axrq930_sum_prep FROM l_sql
   DECLARE axrq930_sum_curs CURSOR FOR axrq930_sum_prep

   #本期起始截止日期
   SELECT MIN(glav004),MAX(glav004) INTO l_date_s,l_date_e FROM glav_t
    WHERE glavent=g_enterprise AND glav001=g_glaa003 
      AND glav002=g_xrca_m.year AND glav006=g_xrca_m.month 
      
   LET l_sql=" SELECT SUM(xrcc108-xrcc106),SUM(xrcc118-xrcc116),SUM(xrcc128-xrcc126),SUM(xrcc138-xrcc136) ",
             "   FROM axrq930_tmp  ",
             "  WHERE xrcadocdt BETWEEN '",l_date_s,"' AND '",l_date_e,"' ",
             "    AND ",g_wc_filter2,  #2015/01/16
             "    AND xrcc100 = ? AND ",l_str1
   PREPARE axrq930_sum_add_prep FROM l_sql 
   
   LET l_sql = "SELECT xrae003,xrae004 FROM xrae_t WHERE xraeent = '",g_enterprise,"'",
               "   AND xrae001 = '",g_xrca_m.xrad001,"'",
               "   AND xrae002 = ?"
   PREPARE axrq930_sel_xrae_pr FROM l_sql
   
   SELECT COUNT(*) INTO l_count FROM xrae_t WHERE xraeent = g_enterprise AND xrae001 = g_xrca_m.xrad001

   SELECT * INTO l_glaa.* FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrca_m.xrcald

   LET l_ac = 1

   FOREACH axrq930_sum_curs INTO l_group1,l_xrcc100,l_xrcc108,l_xrcc118,l_xrcc128,l_xrcc138,
                                          l_xrcc104,l_xrcc114,l_xrcc124,l_xrcc134,
                                          l_xrea103,l_xrea113,l_xrea123,l_xrea133
      #匯總選項處理
      LET l_group = l_group1
      CASE
         WHEN g_xrca_m.sum_type = '1'   #應收科目
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_group
            CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001='"||l_glaa.glaa004||"' AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET l_group = l_group,'(', g_rtn_fields[1] , ')'
         WHEN g_xrca_m.sum_type = '2'   #交易對象
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_group
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET l_group = l_group,'(', g_rtn_fields[1] , ')'
         WHEN g_xrca_m.sum_type = '3'   #業務部門
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_group
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET l_group = l_group,'(', g_rtn_fields[1] , ')'
         WHEN g_xrca_m.sum_type = '4'   #業務人員
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_group
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET l_group = l_group,'(', g_rtn_fields[1] , ')'
         WHEN g_xrca_m.sum_type = '5'   #對象＋科目
            LET l_amt1 = l_group.getLength()
            LET l_amt2 = l_group.getIndexOf('&',1)
            #交易對象
            LET l_xrca004 = l_group.subString(1,l_amt2 - 1)
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_xrca004
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET l_str1 = l_xrca004,'(', g_rtn_fields[1] , ')'
            #科目
            LET l_xrca035 = l_group.subString(l_amt2 + 1,l_amt1)
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_xrca035
            CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001='"||l_glaa.glaa004||"' AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET l_str2 = l_xrca035,'(', g_rtn_fields[1] , ')'
            #對象＋科目
            LET l_group = l_str1.trim(),'&',l_str2.trim()
      END CASE

      #固定欄位賦值
      #本位幣匯總資訊
      LET g_xrcc4_d[l_ac].option_4 = l_group
      LET g_xrcc4_d[l_ac].xrcc100_4 = l_xrcc100
      LET g_xrcc4_d[l_ac].amt1_4 = l_xrea103      #原幣期初金額
      LET g_xrcc4_d[l_ac].amt4_4 = l_xrcc108      #原幣期末金額
      LET g_xrcc4_d[l_ac].amt5_4 = l_xrea113      #原幣期初金額
      LET g_xrcc4_d[l_ac].amt8_4 = l_xrcc118      #本幣期末金額
      LET g_xrcc4_d[l_ac].xrcc104_4 = l_xrcc104
      LET g_xrcc4_d[l_ac].xrcc114_4 = l_xrcc114

      #本位幣二匯總資訊
      LET g_xrcc5_d[l_ac].option_5 = l_group
      LET g_xrcc5_d[l_ac].xrcc100_5 = l_xrcc100
      LET g_xrcc5_d[l_ac].amt9_5  = l_xrea123   #本位幣二期初金額
      LET g_xrcc5_d[l_ac].amt12_5 = l_xrcc128   #本位幣二期末金額
      LET g_xrcc5_d[l_ac].xrcc124_5 = l_xrcc124

      #本位幣三匯總資訊
      LET g_xrcc6_d[l_ac].option_6 = l_group
      LET g_xrcc6_d[l_ac].xrcc100_6 = l_xrcc100
      LET g_xrcc6_d[l_ac].amt13_6 = l_xrea133   #本位幣三期初金額
      LET g_xrcc6_d[l_ac].amt16_6 = l_xrcc138   #本位幣三期末金額
      LET g_xrcc6_d[l_ac].xrcc134_6 = l_xrcc134
      
      #本期增加金額
      IF g_xrca_m.sum_type = '5' THEN   #對象＋科目
         EXECUTE axrq930_sum_add_prep USING l_xrcc100,l_xrca004,l_xrca035
                                       INTO g_xrcc4_d[l_ac].amt2_4,g_xrcc4_d[l_ac].amt6_4,
                                            g_xrcc5_d[l_ac].amt10_5,g_xrcc6_d[l_ac].amt14_6 
      ELSE
         EXECUTE axrq930_sum_add_prep USING l_xrcc100,l_group1
                                       INTO g_xrcc4_d[l_ac].amt2_4,g_xrcc4_d[l_ac].amt6_4,
                                            g_xrcc5_d[l_ac].amt10_5,g_xrcc6_d[l_ac].amt14_6 
      END IF      
      #本期减少金额 = 期初金额＋本期新增金额－期末金额
      #原幣
      IF cl_null(g_xrcc4_d[l_ac].amt1_4) THEN LET g_xrcc4_d[l_ac].amt1_4 = 0 END IF
      IF cl_null(g_xrcc4_d[l_ac].amt2_4) THEN LET g_xrcc4_d[l_ac].amt2_4 = 0 END IF
      IF cl_null(g_xrcc4_d[l_ac].amt4_4) THEN LET g_xrcc4_d[l_ac].amt4_4 = 0 END IF
      LET g_xrcc4_d[l_ac].amt3_4 = g_xrcc4_d[l_ac].amt1_4 + g_xrcc4_d[l_ac].amt2_4 - g_xrcc4_d[l_ac].amt4_4
      #本位幣一
      IF cl_null(g_xrcc4_d[l_ac].amt5_4) THEN LET g_xrcc4_d[l_ac].amt5_4 = 0 END IF
      IF cl_null(g_xrcc4_d[l_ac].amt6_4) THEN LET g_xrcc4_d[l_ac].amt6_4 = 0 END IF
      IF cl_null(g_xrcc4_d[l_ac].amt8_4) THEN LET g_xrcc4_d[l_ac].amt8_4 = 0 END IF
      LET g_xrcc4_d[l_ac].amt7_4 = g_xrcc4_d[l_ac].amt5_4 + g_xrcc4_d[l_ac].amt6_4 - g_xrcc4_d[l_ac].amt8_4
      #本位幣二
      IF cl_null(g_xrcc5_d[l_ac].amt9_5)  THEN LET g_xrcc5_d[l_ac].amt9_5 = 0 END IF
      IF cl_null(g_xrcc5_d[l_ac].amt10_5) THEN LET g_xrcc5_d[l_ac].amt10_5 = 0 END IF
      IF cl_null(g_xrcc5_d[l_ac].amt12_5) THEN LET g_xrcc5_d[l_ac].amt12_5 = 0 END IF
      LET g_xrcc5_d[l_ac].amt11_5 = g_xrcc5_d[l_ac].amt9_5 + g_xrcc5_d[l_ac].amt10_5 - g_xrcc5_d[l_ac].amt12_5
      #本位幣三
      IF cl_null(g_xrcc6_d[l_ac].amt13_6) THEN LET g_xrcc6_d[l_ac].amt13_6 = 0 END IF
      IF cl_null(g_xrcc6_d[l_ac].amt14_6) THEN LET g_xrcc6_d[l_ac].amt14_6 = 0 END IF
      IF cl_null(g_xrcc6_d[l_ac].amt16_6) THEN LET g_xrcc6_d[l_ac].amt16_6 = 0 END IF
      LET g_xrcc6_d[l_ac].amt15_6 = g_xrcc6_d[l_ac].amt13_6 + g_xrcc6_d[l_ac].amt14_6 - g_xrcc6_d[l_ac].amt16_6
      
      IF g_xrca_m.sum_type = '5' THEN   #對象＋科目
         LET l_sql = "SELECT SUM(xrcc118-xrcc119+xrcc113),SUM(xrcc114),SUM(xrcc128-xrcc129+xrcc123),",
                     "       SUM(xrcc124),SUM(xrcc138-xrcc139+xrcc133),SUM(xrcc134)",
                     "  FROM axrq930_tmp ",
                     " WHERE xrek037 BETWEEN ? AND ? ",
                     "   AND ",g_wc_filter2,  #2015/01/16
                     "   AND xrcc100 ='",l_xrcc100,"'",
                     "   AND xrca004 ='",l_xrca004,"'",
                     "   AND xrca035 ='",l_xrca035,"'"
      ELSE
         LET l_sql = "SELECT SUM(xrcc118-xrcc119+xrcc113),SUM(xrcc114),SUM(xrcc128-xrcc129+xrcc123),",
                     "       SUM(xrcc124),SUM(xrcc138-xrcc139+xrcc133),SUM(xrcc134)",
                     "  FROM axrq930_tmp ",
                     " WHERE xrek037 BETWEEN ? AND ? ",
                     "   AND ",g_wc_filter2,  #2015/01/16
                     "   AND xrcc100 ='",l_xrcc100,"'",
                     "   AND ",l_str," ='",l_group1,"'"
      END IF
      PREPARE axrq930_amt_prep FROM l_sql
      #壞帳欄位賦值
      LET l_xrae002 = 1
      #第01段帳齡
      IF l_xrae002 <= l_count THEN
         #分段起始截止時間
         EXECUTE axrq930_sel_xrae_pr USING l_xrae002 INTO l_xrae003,l_xrae004
         EXECUTE axrq930_amt_prep USING l_xrae003,l_xrae004
                                   INTO l_xrcc118_g,l_xrcc114_g,l_xrcc128_g,l_xrcc124_g,l_xrcc138_g,l_xrcc134_g
         IF cl_null(l_xrcc118_g) THEN LET l_xrcc118_g = 0 END IF
         IF cl_null(l_xrcc114_g) THEN LET l_xrcc114_g = 0 END IF
         IF cl_null(l_xrcc128_g) THEN LET l_xrcc128_g = 0 END IF
         IF cl_null(l_xrcc124_g) THEN LET l_xrcc124_g = 0 END IF
         IF cl_null(l_xrcc138_g) THEN LET l_xrcc138_g = 0 END IF
         IF cl_null(l_xrcc134_g) THEN LET l_xrcc134_g = 0 END IF
         
         LET g_xrcc4_d[l_ac].xrcc118_401 = l_xrcc118_g   #本位幣匯總資訊
         LET g_xrcc4_d[l_ac].xrcc114_401 = l_xrcc114_g   #本位幣匯總資訊
         LET g_xrcc5_d[l_ac].xrcc128_501 = l_xrcc128_g   #本位幣二匯總資訊
         LET g_xrcc5_d[l_ac].xrcc124_501 = l_xrcc124_g   #本位幣二匯總資訊
         LET g_xrcc6_d[l_ac].xrcc138_601 = l_xrcc138_g   #本位幣三匯總資訊
         LET g_xrcc6_d[l_ac].xrcc134_601 = l_xrcc134_g   #本位幣三匯總資訊

         LET l_xrae002 = l_xrae002 + 1
      END IF
      #第02段帳齡
      IF l_xrae002 <= l_count THEN
         EXECUTE axrq930_sel_xrae_pr USING l_xrae002 INTO l_xrae003,l_xrae004
         EXECUTE axrq930_amt_prep USING l_xrae003,l_xrae004
                                   INTO l_xrcc118_g,l_xrcc114_g,l_xrcc128_g,l_xrcc124_g,l_xrcc138_g,l_xrcc134_g
         IF cl_null(l_xrcc118_g) THEN LET l_xrcc118_g = 0 END IF
         IF cl_null(l_xrcc114_g) THEN LET l_xrcc114_g = 0 END IF
         IF cl_null(l_xrcc128_g) THEN LET l_xrcc128_g = 0 END IF
         IF cl_null(l_xrcc124_g) THEN LET l_xrcc124_g = 0 END IF
         IF cl_null(l_xrcc138_g) THEN LET l_xrcc138_g = 0 END IF
         IF cl_null(l_xrcc134_g) THEN LET l_xrcc134_g = 0 END IF
         
         LET g_xrcc4_d[l_ac].xrcc118_402 = l_xrcc118_g   #本位幣匯總資訊
         LET g_xrcc4_d[l_ac].xrcc114_402 = l_xrcc114_g   #本位幣匯總資訊
         LET g_xrcc5_d[l_ac].xrcc128_502 = l_xrcc128_g   #本位幣二匯總資訊
         LET g_xrcc5_d[l_ac].xrcc124_502 = l_xrcc124_g   #本位幣二匯總資訊
         LET g_xrcc6_d[l_ac].xrcc138_602 = l_xrcc138_g   #本位幣三匯總資訊
         LET g_xrcc6_d[l_ac].xrcc134_602 = l_xrcc134_g   #本位幣三匯總資訊

         LET l_xrae002 = l_xrae002 + 1
      END IF
      #第03段帳齡
      IF l_xrae002 <= l_count THEN
         EXECUTE axrq930_sel_xrae_pr USING l_xrae002 INTO l_xrae003,l_xrae004
         EXECUTE axrq930_amt_prep USING l_xrae003,l_xrae004
                                   INTO l_xrcc118_g,l_xrcc114_g,l_xrcc128_g,l_xrcc124_g,l_xrcc138_g,l_xrcc134_g
         IF cl_null(l_xrcc118_g) THEN LET l_xrcc118_g = 0 END IF
         IF cl_null(l_xrcc114_g) THEN LET l_xrcc114_g = 0 END IF
         IF cl_null(l_xrcc128_g) THEN LET l_xrcc128_g = 0 END IF
         IF cl_null(l_xrcc124_g) THEN LET l_xrcc124_g = 0 END IF
         IF cl_null(l_xrcc138_g) THEN LET l_xrcc138_g = 0 END IF
         IF cl_null(l_xrcc134_g) THEN LET l_xrcc134_g = 0 END IF
         
         LET g_xrcc4_d[l_ac].xrcc118_403 = l_xrcc118_g   #本位幣匯總資訊
         LET g_xrcc4_d[l_ac].xrcc114_403 = l_xrcc114_g   #本位幣匯總資訊
         LET g_xrcc5_d[l_ac].xrcc128_503 = l_xrcc128_g   #本位幣二匯總資訊
         LET g_xrcc5_d[l_ac].xrcc124_503 = l_xrcc124_g   #本位幣二匯總資訊
         LET g_xrcc6_d[l_ac].xrcc138_603 = l_xrcc138_g   #本位幣三匯總資訊
         LET g_xrcc6_d[l_ac].xrcc134_603 = l_xrcc134_g   #本位幣三匯總資訊

         LET l_xrae002 = l_xrae002 + 1
      END IF
      #第04段帳齡
      IF l_xrae002 <= l_count THEN
         EXECUTE axrq930_sel_xrae_pr USING l_xrae002 INTO l_xrae003,l_xrae004
         EXECUTE axrq930_amt_prep USING l_xrae003,l_xrae004
                                   INTO l_xrcc118_g,l_xrcc114_g,l_xrcc128_g,l_xrcc124_g,l_xrcc138_g,l_xrcc134_g
         IF cl_null(l_xrcc118_g) THEN LET l_xrcc118_g = 0 END IF
         IF cl_null(l_xrcc114_g) THEN LET l_xrcc114_g = 0 END IF
         IF cl_null(l_xrcc128_g) THEN LET l_xrcc128_g = 0 END IF
         IF cl_null(l_xrcc124_g) THEN LET l_xrcc124_g = 0 END IF
         IF cl_null(l_xrcc138_g) THEN LET l_xrcc138_g = 0 END IF
         IF cl_null(l_xrcc134_g) THEN LET l_xrcc134_g = 0 END IF
         
         LET g_xrcc4_d[l_ac].xrcc118_404 = l_xrcc118_g   #本位幣匯總資訊
         LET g_xrcc4_d[l_ac].xrcc114_404 = l_xrcc114_g   #本位幣匯總資訊
         LET g_xrcc5_d[l_ac].xrcc128_504 = l_xrcc128_g   #本位幣二匯總資訊
         LET g_xrcc5_d[l_ac].xrcc124_504 = l_xrcc124_g   #本位幣二匯總資訊
         LET g_xrcc6_d[l_ac].xrcc138_604 = l_xrcc138_g   #本位幣三匯總資訊
         LET g_xrcc6_d[l_ac].xrcc134_604 = l_xrcc134_g   #本位幣三匯總資訊

         LET l_xrae002 = l_xrae002 + 1
      END IF
      #第05段帳齡
      IF l_xrae002 <= l_count THEN
         EXECUTE axrq930_sel_xrae_pr USING l_xrae002 INTO l_xrae003,l_xrae004
         EXECUTE axrq930_amt_prep USING l_xrae003,l_xrae004
                                   INTO l_xrcc118_g,l_xrcc114_g,l_xrcc128_g,l_xrcc124_g,l_xrcc138_g,l_xrcc134_g
         IF cl_null(l_xrcc118_g) THEN LET l_xrcc118_g = 0 END IF
         IF cl_null(l_xrcc114_g) THEN LET l_xrcc114_g = 0 END IF
         IF cl_null(l_xrcc128_g) THEN LET l_xrcc128_g = 0 END IF
         IF cl_null(l_xrcc124_g) THEN LET l_xrcc124_g = 0 END IF
         IF cl_null(l_xrcc138_g) THEN LET l_xrcc138_g = 0 END IF
         IF cl_null(l_xrcc134_g) THEN LET l_xrcc134_g = 0 END IF
         
         LET g_xrcc4_d[l_ac].xrcc118_405 = l_xrcc118_g   #本位幣匯總資訊
         LET g_xrcc4_d[l_ac].xrcc114_405 = l_xrcc114_g   #本位幣匯總資訊
         LET g_xrcc5_d[l_ac].xrcc128_505 = l_xrcc128_g   #本位幣二匯總資訊
         LET g_xrcc5_d[l_ac].xrcc124_505 = l_xrcc124_g   #本位幣二匯總資訊
         LET g_xrcc6_d[l_ac].xrcc138_605 = l_xrcc138_g   #本位幣三匯總資訊
         LET g_xrcc6_d[l_ac].xrcc134_605 = l_xrcc134_g   #本位幣三匯總資訊

         LET l_xrae002 = l_xrae002 + 1
      END IF
      #第06段帳齡
      IF l_xrae002 <= l_count THEN
         EXECUTE axrq930_sel_xrae_pr USING l_xrae002 INTO l_xrae003,l_xrae004
         EXECUTE axrq930_amt_prep USING l_xrae003,l_xrae004
                                   INTO l_xrcc118_g,l_xrcc114_g,l_xrcc128_g,l_xrcc124_g,l_xrcc138_g,l_xrcc134_g
         IF cl_null(l_xrcc118_g) THEN LET l_xrcc118_g = 0 END IF
         IF cl_null(l_xrcc114_g) THEN LET l_xrcc114_g = 0 END IF
         IF cl_null(l_xrcc128_g) THEN LET l_xrcc128_g = 0 END IF
         IF cl_null(l_xrcc124_g) THEN LET l_xrcc124_g = 0 END IF
         IF cl_null(l_xrcc138_g) THEN LET l_xrcc138_g = 0 END IF
         IF cl_null(l_xrcc134_g) THEN LET l_xrcc134_g = 0 END IF
         
         LET g_xrcc4_d[l_ac].xrcc118_406 = l_xrcc118_g   #本位幣匯總資訊
         LET g_xrcc4_d[l_ac].xrcc114_406 = l_xrcc114_g   #本位幣匯總資訊
         LET g_xrcc5_d[l_ac].xrcc128_506 = l_xrcc128_g   #本位幣二匯總資訊
         LET g_xrcc5_d[l_ac].xrcc124_506 = l_xrcc124_g   #本位幣二匯總資訊
         LET g_xrcc6_d[l_ac].xrcc138_606 = l_xrcc138_g   #本位幣三匯總資訊
         LET g_xrcc6_d[l_ac].xrcc134_606 = l_xrcc134_g   #本位幣三匯總資訊

         LET l_xrae002 = l_xrae002 + 1
      END IF
      #第07段帳齡
      IF l_xrae002 <= l_count THEN
         EXECUTE axrq930_sel_xrae_pr USING l_xrae002 INTO l_xrae003,l_xrae004
         EXECUTE axrq930_amt_prep USING l_xrae003,l_xrae004
                                   INTO l_xrcc118_g,l_xrcc114_g,l_xrcc128_g,l_xrcc124_g,l_xrcc138_g,l_xrcc134_g
         IF cl_null(l_xrcc118_g) THEN LET l_xrcc118_g = 0 END IF
         IF cl_null(l_xrcc114_g) THEN LET l_xrcc114_g = 0 END IF
         IF cl_null(l_xrcc128_g) THEN LET l_xrcc128_g = 0 END IF
         IF cl_null(l_xrcc124_g) THEN LET l_xrcc124_g = 0 END IF
         IF cl_null(l_xrcc138_g) THEN LET l_xrcc138_g = 0 END IF
         IF cl_null(l_xrcc134_g) THEN LET l_xrcc134_g = 0 END IF
         
         LET g_xrcc4_d[l_ac].xrcc118_407 = l_xrcc118_g   #本位幣匯總資訊
         LET g_xrcc4_d[l_ac].xrcc114_407 = l_xrcc114_g   #本位幣匯總資訊
         LET g_xrcc5_d[l_ac].xrcc128_507 = l_xrcc128_g   #本位幣二匯總資訊
         LET g_xrcc5_d[l_ac].xrcc124_507 = l_xrcc124_g   #本位幣二匯總資訊
         LET g_xrcc6_d[l_ac].xrcc138_607 = l_xrcc138_g   #本位幣三匯總資訊
         LET g_xrcc6_d[l_ac].xrcc134_607 = l_xrcc134_g   #本位幣三匯總資訊

         LET l_xrae002 = l_xrae002 + 1
      END IF
      #第08段帳齡
      IF l_xrae002 <= l_count THEN
         EXECUTE axrq930_sel_xrae_pr USING l_xrae002 INTO l_xrae003,l_xrae004
         EXECUTE axrq930_amt_prep USING l_xrae003,l_xrae004
                                   INTO l_xrcc118_g,l_xrcc114_g,l_xrcc128_g,l_xrcc124_g,l_xrcc138_g,l_xrcc134_g
         IF cl_null(l_xrcc118_g) THEN LET l_xrcc118_g = 0 END IF
         IF cl_null(l_xrcc114_g) THEN LET l_xrcc114_g = 0 END IF
         IF cl_null(l_xrcc128_g) THEN LET l_xrcc128_g = 0 END IF
         IF cl_null(l_xrcc124_g) THEN LET l_xrcc124_g = 0 END IF
         IF cl_null(l_xrcc138_g) THEN LET l_xrcc138_g = 0 END IF
         IF cl_null(l_xrcc134_g) THEN LET l_xrcc134_g = 0 END IF
         
         LET g_xrcc4_d[l_ac].xrcc118_408 = l_xrcc118_g   #本位幣匯總資訊
         LET g_xrcc4_d[l_ac].xrcc114_408 = l_xrcc114_g   #本位幣匯總資訊
         LET g_xrcc5_d[l_ac].xrcc128_508 = l_xrcc128_g   #本位幣二匯總資訊
         LET g_xrcc5_d[l_ac].xrcc124_508 = l_xrcc124_g   #本位幣二匯總資訊
         LET g_xrcc6_d[l_ac].xrcc138_608 = l_xrcc138_g   #本位幣三匯總資訊
         LET g_xrcc6_d[l_ac].xrcc134_608 = l_xrcc134_g   #本位幣三匯總資訊

         LET l_xrae002 = l_xrae002 + 1
      END IF
      #第09段帳齡
      IF l_xrae002 <= l_count THEN
         EXECUTE axrq930_sel_xrae_pr USING l_xrae002 INTO l_xrae003,l_xrae004
         EXECUTE axrq930_amt_prep USING l_xrae003,l_xrae004
                                   INTO l_xrcc118_g,l_xrcc114_g,l_xrcc128_g,l_xrcc124_g,l_xrcc138_g,l_xrcc134_g
         IF cl_null(l_xrcc118_g) THEN LET l_xrcc118_g = 0 END IF
         IF cl_null(l_xrcc114_g) THEN LET l_xrcc114_g = 0 END IF
         IF cl_null(l_xrcc128_g) THEN LET l_xrcc128_g = 0 END IF
         IF cl_null(l_xrcc124_g) THEN LET l_xrcc124_g = 0 END IF
         IF cl_null(l_xrcc138_g) THEN LET l_xrcc138_g = 0 END IF
         IF cl_null(l_xrcc134_g) THEN LET l_xrcc134_g = 0 END IF
         
         LET g_xrcc4_d[l_ac].xrcc118_409 = l_xrcc118_g   #本位幣匯總資訊
         LET g_xrcc4_d[l_ac].xrcc114_409 = l_xrcc114_g   #本位幣匯總資訊
         LET g_xrcc5_d[l_ac].xrcc128_509 = l_xrcc128_g   #本位幣二匯總資訊
         LET g_xrcc5_d[l_ac].xrcc124_509 = l_xrcc124_g   #本位幣二匯總資訊
         LET g_xrcc6_d[l_ac].xrcc138_609 = l_xrcc138_g   #本位幣三匯總資訊
         LET g_xrcc6_d[l_ac].xrcc134_609 = l_xrcc134_g   #本位幣三匯總資訊

         LET l_xrae002 = l_xrae002 + 1
      END IF
      #第10段帳齡
      IF l_xrae002 <= l_count THEN
         EXECUTE axrq930_sel_xrae_pr USING l_xrae002 INTO l_xrae003,l_xrae004
         EXECUTE axrq930_amt_prep USING l_xrae003,l_xrae004
                                   INTO l_xrcc118_g,l_xrcc114_g,l_xrcc128_g,l_xrcc124_g,l_xrcc138_g,l_xrcc134_g
         IF cl_null(l_xrcc118_g) THEN LET l_xrcc118_g = 0 END IF
         IF cl_null(l_xrcc114_g) THEN LET l_xrcc114_g = 0 END IF
         IF cl_null(l_xrcc128_g) THEN LET l_xrcc128_g = 0 END IF
         IF cl_null(l_xrcc124_g) THEN LET l_xrcc124_g = 0 END IF
         IF cl_null(l_xrcc138_g) THEN LET l_xrcc138_g = 0 END IF
         IF cl_null(l_xrcc134_g) THEN LET l_xrcc134_g = 0 END IF
         
         LET g_xrcc4_d[l_ac].xrcc118_410 = l_xrcc118_g   #本位幣匯總資訊
         LET g_xrcc4_d[l_ac].xrcc114_410 = l_xrcc114_g   #本位幣匯總資訊
         LET g_xrcc5_d[l_ac].xrcc128_510 = l_xrcc128_g   #本位幣二匯總資訊
         LET g_xrcc5_d[l_ac].xrcc124_510 = l_xrcc124_g   #本位幣二匯總資訊
         LET g_xrcc6_d[l_ac].xrcc138_610 = l_xrcc138_g   #本位幣三匯總資訊
         LET g_xrcc6_d[l_ac].xrcc134_610 = l_xrcc134_g   #本位幣三匯總資訊

         LET l_xrae002 = l_xrae002 + 1
      END IF
      #第11段帳齡
      IF l_xrae002 <= l_count THEN
         EXECUTE axrq930_sel_xrae_pr USING l_xrae002 INTO l_xrae003,l_xrae004
         EXECUTE axrq930_amt_prep USING l_xrae003,l_xrae004
                                   INTO l_xrcc118_g,l_xrcc114_g,l_xrcc128_g,l_xrcc124_g,l_xrcc138_g,l_xrcc134_g
         IF cl_null(l_xrcc118_g) THEN LET l_xrcc118_g = 0 END IF
         IF cl_null(l_xrcc114_g) THEN LET l_xrcc114_g = 0 END IF
         IF cl_null(l_xrcc128_g) THEN LET l_xrcc128_g = 0 END IF
         IF cl_null(l_xrcc124_g) THEN LET l_xrcc124_g = 0 END IF
         IF cl_null(l_xrcc138_g) THEN LET l_xrcc138_g = 0 END IF
         IF cl_null(l_xrcc134_g) THEN LET l_xrcc134_g = 0 END IF
         
         LET g_xrcc4_d[l_ac].xrcc118_411 = l_xrcc118_g   #本位幣匯總資訊
         LET g_xrcc4_d[l_ac].xrcc114_411 = l_xrcc114_g   #本位幣匯總資訊
         LET g_xrcc5_d[l_ac].xrcc128_511 = l_xrcc128_g   #本位幣二匯總資訊
         LET g_xrcc5_d[l_ac].xrcc124_511 = l_xrcc124_g   #本位幣二匯總資訊
         LET g_xrcc6_d[l_ac].xrcc138_611 = l_xrcc138_g   #本位幣三匯總資訊
         LET g_xrcc6_d[l_ac].xrcc134_611 = l_xrcc134_g   #本位幣三匯總資訊

         LET l_xrae002 = l_xrae002 + 1
      END IF
      #第12段帳齡
      IF l_xrae002 <= l_count THEN
         EXECUTE axrq930_sel_xrae_pr USING l_xrae002 INTO l_xrae003,l_xrae004
         EXECUTE axrq930_amt_prep USING l_xrae003,l_xrae004
                                   INTO l_xrcc118_g,l_xrcc114_g,l_xrcc128_g,l_xrcc124_g,l_xrcc138_g,l_xrcc134_g
         IF cl_null(l_xrcc118_g) THEN LET l_xrcc118_g = 0 END IF
         IF cl_null(l_xrcc114_g) THEN LET l_xrcc114_g = 0 END IF
         IF cl_null(l_xrcc128_g) THEN LET l_xrcc128_g = 0 END IF
         IF cl_null(l_xrcc124_g) THEN LET l_xrcc124_g = 0 END IF
         IF cl_null(l_xrcc138_g) THEN LET l_xrcc138_g = 0 END IF
         IF cl_null(l_xrcc134_g) THEN LET l_xrcc134_g = 0 END IF
         
         LET g_xrcc4_d[l_ac].xrcc118_412 = l_xrcc118_g   #本位幣匯總資訊
         LET g_xrcc4_d[l_ac].xrcc114_412 = l_xrcc114_g   #本位幣匯總資訊
         LET g_xrcc5_d[l_ac].xrcc128_512 = l_xrcc128_g   #本位幣二匯總資訊
         LET g_xrcc5_d[l_ac].xrcc124_512 = l_xrcc124_g   #本位幣二匯總資訊
         LET g_xrcc6_d[l_ac].xrcc138_612 = l_xrcc138_g   #本位幣三匯總資訊
         LET g_xrcc6_d[l_ac].xrcc134_612 = l_xrcc134_g   #本位幣三匯總資訊

         LET l_xrae002 = l_xrae002 + 1
      END IF
      #第13段帳齡
      IF l_xrae002 <= l_count THEN
         EXECUTE axrq930_sel_xrae_pr USING l_xrae002 INTO l_xrae003,l_xrae004
         EXECUTE axrq930_amt_prep USING l_xrae003,l_xrae004
                                   INTO l_xrcc118_g,l_xrcc114_g,l_xrcc128_g,l_xrcc124_g,l_xrcc138_g,l_xrcc134_g
         IF cl_null(l_xrcc118_g) THEN LET l_xrcc118_g = 0 END IF
         IF cl_null(l_xrcc114_g) THEN LET l_xrcc114_g = 0 END IF
         IF cl_null(l_xrcc128_g) THEN LET l_xrcc128_g = 0 END IF
         IF cl_null(l_xrcc124_g) THEN LET l_xrcc124_g = 0 END IF
         IF cl_null(l_xrcc138_g) THEN LET l_xrcc138_g = 0 END IF
         IF cl_null(l_xrcc134_g) THEN LET l_xrcc134_g = 0 END IF
         
         LET g_xrcc4_d[l_ac].xrcc118_413 = l_xrcc118_g   #本位幣匯總資訊
         LET g_xrcc4_d[l_ac].xrcc114_413 = l_xrcc114_g   #本位幣匯總資訊
         LET g_xrcc5_d[l_ac].xrcc128_513 = l_xrcc128_g   #本位幣二匯總資訊
         LET g_xrcc5_d[l_ac].xrcc124_513 = l_xrcc124_g   #本位幣二匯總資訊
         LET g_xrcc6_d[l_ac].xrcc138_613 = l_xrcc138_g   #本位幣三匯總資訊
         LET g_xrcc6_d[l_ac].xrcc134_613 = l_xrcc134_g   #本位幣三匯總資訊

         LET l_xrae002 = l_xrae002 + 1
      END IF
      #第14段帳齡
      IF l_xrae002 <= l_count THEN
         EXECUTE axrq930_sel_xrae_pr USING l_xrae002 INTO l_xrae003,l_xrae004
         EXECUTE axrq930_amt_prep USING l_xrae003,l_xrae004
                                   INTO l_xrcc118_g,l_xrcc114_g,l_xrcc128_g,l_xrcc124_g,l_xrcc138_g,l_xrcc134_g
         IF cl_null(l_xrcc118_g) THEN LET l_xrcc118_g = 0 END IF
         IF cl_null(l_xrcc114_g) THEN LET l_xrcc114_g = 0 END IF
         IF cl_null(l_xrcc128_g) THEN LET l_xrcc128_g = 0 END IF
         IF cl_null(l_xrcc124_g) THEN LET l_xrcc124_g = 0 END IF
         IF cl_null(l_xrcc138_g) THEN LET l_xrcc138_g = 0 END IF
         IF cl_null(l_xrcc134_g) THEN LET l_xrcc134_g = 0 END IF
         
         LET g_xrcc4_d[l_ac].xrcc118_414 = l_xrcc118_g   #本位幣匯總資訊
         LET g_xrcc4_d[l_ac].xrcc114_414 = l_xrcc114_g   #本位幣匯總資訊
         LET g_xrcc5_d[l_ac].xrcc128_514 = l_xrcc128_g   #本位幣二匯總資訊
         LET g_xrcc5_d[l_ac].xrcc124_514 = l_xrcc124_g   #本位幣二匯總資訊
         LET g_xrcc6_d[l_ac].xrcc138_614 = l_xrcc138_g   #本位幣三匯總資訊
         LET g_xrcc6_d[l_ac].xrcc134_614 = l_xrcc134_g   #本位幣三匯總資訊

         LET l_xrae002 = l_xrae002 + 1
      END IF
      #第15段帳齡
      IF l_xrae002 <= l_count THEN
         EXECUTE axrq930_sel_xrae_pr USING l_xrae002 INTO l_xrae003,l_xrae004
         EXECUTE axrq930_amt_prep USING l_xrae003,l_xrae004
                                   INTO l_xrcc118_g,l_xrcc114_g,l_xrcc128_g,l_xrcc124_g,l_xrcc138_g,l_xrcc134_g
         IF cl_null(l_xrcc118_g) THEN LET l_xrcc118_g = 0 END IF
         IF cl_null(l_xrcc114_g) THEN LET l_xrcc114_g = 0 END IF
         IF cl_null(l_xrcc128_g) THEN LET l_xrcc128_g = 0 END IF
         IF cl_null(l_xrcc124_g) THEN LET l_xrcc124_g = 0 END IF
         IF cl_null(l_xrcc138_g) THEN LET l_xrcc138_g = 0 END IF
         IF cl_null(l_xrcc134_g) THEN LET l_xrcc134_g = 0 END IF
         
         LET g_xrcc4_d[l_ac].xrcc118_415 = l_xrcc118_g   #本位幣匯總資訊
         LET g_xrcc4_d[l_ac].xrcc114_415 = l_xrcc114_g   #本位幣匯總資訊
         LET g_xrcc5_d[l_ac].xrcc128_515 = l_xrcc128_g   #本位幣二匯總資訊
         LET g_xrcc5_d[l_ac].xrcc124_515 = l_xrcc124_g   #本位幣二匯總資訊
         LET g_xrcc6_d[l_ac].xrcc138_615 = l_xrcc138_g   #本位幣三匯總資訊
         LET g_xrcc6_d[l_ac].xrcc134_615 = l_xrcc134_g   #本位幣三匯總資訊

         LET l_xrae002 = l_xrae002 + 1
      END IF
      #第16段帳齡
      IF l_xrae002 <= l_count THEN
         EXECUTE axrq930_sel_xrae_pr USING l_xrae002 INTO l_xrae003,l_xrae004
         EXECUTE axrq930_amt_prep USING l_xrae003,l_xrae004
                                   INTO l_xrcc118_g,l_xrcc114_g,l_xrcc128_g,l_xrcc124_g,l_xrcc138_g,l_xrcc134_g
         IF cl_null(l_xrcc118_g) THEN LET l_xrcc118_g = 0 END IF
         IF cl_null(l_xrcc114_g) THEN LET l_xrcc114_g = 0 END IF
         IF cl_null(l_xrcc128_g) THEN LET l_xrcc128_g = 0 END IF
         IF cl_null(l_xrcc124_g) THEN LET l_xrcc124_g = 0 END IF
         IF cl_null(l_xrcc138_g) THEN LET l_xrcc138_g = 0 END IF
         IF cl_null(l_xrcc134_g) THEN LET l_xrcc134_g = 0 END IF
         
         LET g_xrcc4_d[l_ac].xrcc118_416 = l_xrcc118_g   #本位幣匯總資訊
         LET g_xrcc4_d[l_ac].xrcc114_416 = l_xrcc114_g   #本位幣匯總資訊
         LET g_xrcc5_d[l_ac].xrcc128_516 = l_xrcc128_g   #本位幣二匯總資訊
         LET g_xrcc5_d[l_ac].xrcc124_516 = l_xrcc124_g   #本位幣二匯總資訊
         LET g_xrcc6_d[l_ac].xrcc138_616 = l_xrcc138_g   #本位幣三匯總資訊
         LET g_xrcc6_d[l_ac].xrcc134_616 = l_xrcc134_g   #本位幣三匯總資訊

         LET l_xrae002 = l_xrae002 + 1
      END IF
      #第17段帳齡
      IF l_xrae002 <= l_count THEN
         EXECUTE axrq930_sel_xrae_pr USING l_xrae002 INTO l_xrae003,l_xrae004
         EXECUTE axrq930_amt_prep USING l_xrae003,l_xrae004
                                   INTO l_xrcc118_g,l_xrcc114_g,l_xrcc128_g,l_xrcc124_g,l_xrcc138_g,l_xrcc134_g
         IF cl_null(l_xrcc118_g) THEN LET l_xrcc118_g = 0 END IF
         IF cl_null(l_xrcc114_g) THEN LET l_xrcc114_g = 0 END IF
         IF cl_null(l_xrcc128_g) THEN LET l_xrcc128_g = 0 END IF
         IF cl_null(l_xrcc124_g) THEN LET l_xrcc124_g = 0 END IF
         IF cl_null(l_xrcc138_g) THEN LET l_xrcc138_g = 0 END IF
         IF cl_null(l_xrcc134_g) THEN LET l_xrcc134_g = 0 END IF
         
         LET g_xrcc4_d[l_ac].xrcc118_417 = l_xrcc118_g   #本位幣匯總資訊
         LET g_xrcc4_d[l_ac].xrcc114_417 = l_xrcc114_g   #本位幣匯總資訊
         LET g_xrcc5_d[l_ac].xrcc128_517 = l_xrcc128_g   #本位幣二匯總資訊
         LET g_xrcc5_d[l_ac].xrcc124_517 = l_xrcc124_g   #本位幣二匯總資訊
         LET g_xrcc6_d[l_ac].xrcc138_617 = l_xrcc138_g   #本位幣三匯總資訊
         LET g_xrcc6_d[l_ac].xrcc134_617 = l_xrcc134_g   #本位幣三匯總資訊

         LET l_xrae002 = l_xrae002 + 1
      END IF
      #第18段帳齡
      IF l_xrae002 <= l_count THEN
         EXECUTE axrq930_sel_xrae_pr USING l_xrae002 INTO l_xrae003,l_xrae004
         EXECUTE axrq930_amt_prep USING l_xrae003,l_xrae004
                                   INTO l_xrcc118_g,l_xrcc114_g,l_xrcc128_g,l_xrcc124_g,l_xrcc138_g,l_xrcc134_g
         IF cl_null(l_xrcc118_g) THEN LET l_xrcc118_g = 0 END IF
         IF cl_null(l_xrcc114_g) THEN LET l_xrcc114_g = 0 END IF
         IF cl_null(l_xrcc128_g) THEN LET l_xrcc128_g = 0 END IF
         IF cl_null(l_xrcc124_g) THEN LET l_xrcc124_g = 0 END IF
         IF cl_null(l_xrcc138_g) THEN LET l_xrcc138_g = 0 END IF
         IF cl_null(l_xrcc134_g) THEN LET l_xrcc134_g = 0 END IF
         
         LET g_xrcc4_d[l_ac].xrcc118_418 = l_xrcc118_g   #本位幣匯總資訊
         LET g_xrcc4_d[l_ac].xrcc114_418 = l_xrcc114_g   #本位幣匯總資訊
         LET g_xrcc5_d[l_ac].xrcc128_518 = l_xrcc128_g   #本位幣二匯總資訊
         LET g_xrcc5_d[l_ac].xrcc124_518 = l_xrcc124_g   #本位幣二匯總資訊
         LET g_xrcc6_d[l_ac].xrcc138_618 = l_xrcc138_g   #本位幣三匯總資訊
         LET g_xrcc6_d[l_ac].xrcc134_618 = l_xrcc134_g   #本位幣三匯總資訊

         LET l_xrae002 = l_xrae002 + 1
      END IF
      #第19段帳齡
      IF l_xrae002 <= l_count THEN
         EXECUTE axrq930_sel_xrae_pr USING l_xrae002 INTO l_xrae003,l_xrae004
         EXECUTE axrq930_amt_prep USING l_xrae003,l_xrae004
                                   INTO l_xrcc118_g,l_xrcc114_g,l_xrcc128_g,l_xrcc124_g,l_xrcc138_g,l_xrcc134_g
         IF cl_null(l_xrcc118_g) THEN LET l_xrcc118_g = 0 END IF
         IF cl_null(l_xrcc114_g) THEN LET l_xrcc114_g = 0 END IF
         IF cl_null(l_xrcc128_g) THEN LET l_xrcc128_g = 0 END IF
         IF cl_null(l_xrcc124_g) THEN LET l_xrcc124_g = 0 END IF
         IF cl_null(l_xrcc138_g) THEN LET l_xrcc138_g = 0 END IF
         IF cl_null(l_xrcc134_g) THEN LET l_xrcc134_g = 0 END IF
         
         LET g_xrcc4_d[l_ac].xrcc118_419 = l_xrcc118_g   #本位幣匯總資訊
         LET g_xrcc4_d[l_ac].xrcc114_419 = l_xrcc114_g   #本位幣匯總資訊
         LET g_xrcc5_d[l_ac].xrcc128_519 = l_xrcc128_g   #本位幣二匯總資訊
         LET g_xrcc5_d[l_ac].xrcc124_519 = l_xrcc124_g   #本位幣二匯總資訊
         LET g_xrcc6_d[l_ac].xrcc138_619 = l_xrcc138_g   #本位幣三匯總資訊
         LET g_xrcc6_d[l_ac].xrcc134_619 = l_xrcc134_g   #本位幣三匯總資訊

         LET l_xrae002 = l_xrae002 + 1
      END IF
      #第20段帳齡
      IF l_xrae002 <= l_count THEN
         EXECUTE axrq930_sel_xrae_pr USING l_xrae002 INTO l_xrae003,l_xrae004
         EXECUTE axrq930_amt_prep USING l_xrae003,l_xrae004
                                   INTO l_xrcc118_g,l_xrcc114_g,l_xrcc128_g,l_xrcc124_g,l_xrcc138_g,l_xrcc134_g
         IF cl_null(l_xrcc118_g) THEN LET l_xrcc118_g = 0 END IF
         IF cl_null(l_xrcc114_g) THEN LET l_xrcc114_g = 0 END IF
         IF cl_null(l_xrcc128_g) THEN LET l_xrcc128_g = 0 END IF
         IF cl_null(l_xrcc124_g) THEN LET l_xrcc124_g = 0 END IF
         IF cl_null(l_xrcc138_g) THEN LET l_xrcc138_g = 0 END IF
         IF cl_null(l_xrcc134_g) THEN LET l_xrcc134_g = 0 END IF
         
         LET g_xrcc4_d[l_ac].xrcc118_420 = l_xrcc118_g   #本位幣匯總資訊
         LET g_xrcc4_d[l_ac].xrcc114_420 = l_xrcc114_g   #本位幣匯總資訊
         LET g_xrcc5_d[l_ac].xrcc128_520 = l_xrcc128_g   #本位幣二匯總資訊
         LET g_xrcc5_d[l_ac].xrcc124_520 = l_xrcc124_g   #本位幣二匯總資訊
         LET g_xrcc6_d[l_ac].xrcc138_620 = l_xrcc138_g   #本位幣三匯總資訊
         LET g_xrcc6_d[l_ac].xrcc134_620 = l_xrcc134_g   #本位幣三匯總資訊

         LET l_xrae002 = l_xrae002 + 1
      END IF

      LET l_ac = l_ac + 1
   END FOREACH

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axrq930_xreb116_ref()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq930_xreb116_ref()
   DEFINE l_glca002         LIKE glca_t.glca002
   

END FUNCTION

################################################################################
# Descriptions...: 壞帳欄位說明
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
PRIVATE FUNCTION axrq930_title()
   DEFINE l_xrae003        LIKE xrae_t.xrae003
   DEFINE l_xrae004        LIKE xrae_t.xrae004
   DEFINE l_count          LIKE type_t.num5
   DEFINE l_xrae002        LIKE xrae_t.xrae002
   DEFINE lbl_xrcc118_g    LIKE gzzd_t.gzzd005
   DEFINE lbl_xrcc114_g    LIKE gzzd_t.gzzd005
   DEFINE l_sql            STRING
   DEFINE l_str            STRING

   #STEP1.依照帳齡段數修改title名稱
   #STEP2.隱藏不使用的欄位

   SELECT COUNT(*) INTO l_count FROM xrae_t WHERE xraeent = g_enterprise AND xrae001 = g_xrca_m.xrad001

   LET l_sql = "SELECT xrae003,xrae004 FROM xrae_t WHERE xraeent = '",g_enterprise,"'",
               "   AND xrae001 = '",g_xrca_m.xrad001,"'",
               "   AND xrae002 = ?"
   PREPARE axrq930_xrae002 FROM l_sql

   SELECT gzzd005 INTO lbl_xrcc118_g FROM gzzd_t WHERE gzzd001 = 'axrq930' AND gzzd003 = 'lbl_xrcc118_g' AND gzzd002 = g_lang
   SELECT gzzd005 INTO lbl_xrcc114_g FROM gzzd_t WHERE gzzd001 = 'axrq930' AND gzzd003 = 'lbl_xrcc114_g' AND gzzd002 = g_lang

   LET l_xrae002 = 1

   #依照帳齡段數修改title名稱
   #第01段帳齡
   IF l_xrae002 <= l_count THEN
      EXECUTE axrq930_xrae002 USING l_xrae002 INTO l_xrae003,l_xrae004
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc118_g CLIPPED
      ELSE
         IF l_xrae003= 0 THEN
            LET l_str = '0-',l_xrae004 USING '<<<<',lbl_xrcc118_g CLIPPED
         ELSE
            LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc118_g CLIPPED
         END IF
      END IF
      CALL cl_set_comp_att_text('xrcc118_401',l_str)
      CALL cl_set_comp_att_text('xrcc128_501',l_str)
      CALL cl_set_comp_att_text('xrcc138_601',l_str)
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc114_g CLIPPED
      ELSE
         IF l_xrae003= 0 THEN
            LET l_str = '0-',l_xrae004 USING '<<<<',lbl_xrcc114_g CLIPPED
         ELSE
            LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc114_g CLIPPED
         END IF
      END IF
      CALL cl_set_comp_att_text('xrcc114_401',l_str)
      CALL cl_set_comp_att_text('xrcc124_501',l_str)
      CALL cl_set_comp_att_text('xrcc134_601',l_str)
      LET l_xrae002 = l_xrae002 + 1
   END IF

   #第02段帳齡
   IF l_xrae002 <= l_count THEN
      EXECUTE axrq930_xrae002 USING l_xrae002 INTO l_xrae003,l_xrae004
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc118_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc118_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc118_402',l_str)
      CALL cl_set_comp_att_text('xrcc128_502',l_str)
      CALL cl_set_comp_att_text('xrcc138_602',l_str)
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc114_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc114_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc114_402',l_str)
      CALL cl_set_comp_att_text('xrcc124_502',l_str)
      CALL cl_set_comp_att_text('xrcc134_602',l_str)
      LET l_xrae002 = l_xrae002 + 1
   END IF

   #第03段帳齡
   IF l_xrae002 <= l_count THEN
      EXECUTE axrq930_xrae002 USING l_xrae002 INTO l_xrae003,l_xrae004
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc118_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc118_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc118_403',l_str)
      CALL cl_set_comp_att_text('xrcc128_503',l_str)
      CALL cl_set_comp_att_text('xrcc138_603',l_str)
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc114_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc114_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc114_403',l_str)
      CALL cl_set_comp_att_text('xrcc124_503',l_str)
      CALL cl_set_comp_att_text('xrcc134_603',l_str)
      LET l_xrae002 = l_xrae002 + 1
   END IF

   #第04段帳齡
   IF l_xrae002 <= l_count THEN
      EXECUTE axrq930_xrae002 USING l_xrae002 INTO l_xrae003,l_xrae004
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc118_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc118_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc118_404',l_str)
      CALL cl_set_comp_att_text('xrcc128_504',l_str)
      CALL cl_set_comp_att_text('xrcc138_604',l_str)
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc114_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc114_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc114_404',l_str)
      CALL cl_set_comp_att_text('xrcc124_504',l_str)
      CALL cl_set_comp_att_text('xrcc134_604',l_str)
      LET l_xrae002 = l_xrae002 + 1
   END IF

   #第05段帳齡
   IF l_xrae002 <= l_count THEN
      EXECUTE axrq930_xrae002 USING l_xrae002 INTO l_xrae003,l_xrae004
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc118_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc118_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc118_405',l_str)
      CALL cl_set_comp_att_text('xrcc128_505',l_str)
      CALL cl_set_comp_att_text('xrcc138_605',l_str)
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc114_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc114_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc114_405',l_str)
      CALL cl_set_comp_att_text('xrcc124_505',l_str)
      CALL cl_set_comp_att_text('xrcc134_605',l_str)
      LET l_xrae002 = l_xrae002 + 1
   END IF

   #第06段帳齡
   IF l_xrae002 <= l_count THEN
      EXECUTE axrq930_xrae002 USING l_xrae002 INTO l_xrae003,l_xrae004
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc118_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc118_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc118_406',l_str)
      CALL cl_set_comp_att_text('xrcc128_506',l_str)
      CALL cl_set_comp_att_text('xrcc138_606',l_str)
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc114_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc114_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc114_406',l_str)
      CALL cl_set_comp_att_text('xrcc124_506',l_str)
      CALL cl_set_comp_att_text('xrcc134_606',l_str)
      LET l_xrae002 = l_xrae002 + 1
   END IF

   #第07段帳齡
   IF l_xrae002 <= l_count THEN
      EXECUTE axrq930_xrae002 USING l_xrae002 INTO l_xrae003,l_xrae004
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc118_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc118_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc118_407',l_str)
      CALL cl_set_comp_att_text('xrcc128_507',l_str)
      CALL cl_set_comp_att_text('xrcc138_607',l_str)
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc114_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc114_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc114_407',l_str)
      CALL cl_set_comp_att_text('xrcc124_507',l_str)
      CALL cl_set_comp_att_text('xrcc134_607',l_str)
      LET l_xrae002 = l_xrae002 + 1
   END IF

   #第08段帳齡
   IF l_xrae002 <= l_count THEN
      EXECUTE axrq930_xrae002 USING l_xrae002 INTO l_xrae003,l_xrae004
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc118_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc118_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc118_408',l_str)
      CALL cl_set_comp_att_text('xrcc128_508',l_str)
      CALL cl_set_comp_att_text('xrcc138_608',l_str)
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc114_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc114_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc114_408',l_str)
      CALL cl_set_comp_att_text('xrcc124_508',l_str)
      CALL cl_set_comp_att_text('xrcc134_608',l_str)
      LET l_xrae002 = l_xrae002 + 1
   END IF

   #第09段帳齡
   IF l_xrae002 <= l_count THEN
      EXECUTE axrq930_xrae002 USING l_xrae002 INTO l_xrae003,l_xrae004
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc118_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc118_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc118_409',l_str)
      CALL cl_set_comp_att_text('xrcc128_509',l_str)
      CALL cl_set_comp_att_text('xrcc138_609',l_str)
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc114_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc114_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc114_409',l_str)
      CALL cl_set_comp_att_text('xrcc124_509',l_str)
      CALL cl_set_comp_att_text('xrcc134_609',l_str)
      LET l_xrae002 = l_xrae002 + 1
   END IF

   #第10段帳齡
   IF l_xrae002 <= l_count THEN
      EXECUTE axrq930_xrae002 USING l_xrae002 INTO l_xrae003,l_xrae004
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc118_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc118_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc118_410',l_str)
      CALL cl_set_comp_att_text('xrcc128_510',l_str)
      CALL cl_set_comp_att_text('xrcc138_610',l_str)
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc114_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc114_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc114_410',l_str)
      CALL cl_set_comp_att_text('xrcc124_510',l_str)
      CALL cl_set_comp_att_text('xrcc134_610',l_str)
      LET l_xrae002 = l_xrae002 + 1
   END IF

   #第11段帳齡
   IF l_xrae002 <= l_count THEN
      EXECUTE axrq930_xrae002 USING l_xrae002 INTO l_xrae003,l_xrae004
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc118_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc118_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc118_411',l_str)
      CALL cl_set_comp_att_text('xrcc128_511',l_str)
      CALL cl_set_comp_att_text('xrcc138_611',l_str)
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc114_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc114_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc114_411',l_str)
      CALL cl_set_comp_att_text('xrcc124_511',l_str)
      CALL cl_set_comp_att_text('xrcc134_611',l_str)
      LET l_xrae002 = l_xrae002 + 1
   END IF

   #第12段帳齡
   IF l_xrae002 <= l_count THEN
      EXECUTE axrq930_xrae002 USING l_xrae002 INTO l_xrae003,l_xrae004
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc118_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc118_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc118_412',l_str)
      CALL cl_set_comp_att_text('xrcc128_512',l_str)
      CALL cl_set_comp_att_text('xrcc138_612',l_str)
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc114_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc114_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc114_412',l_str)
      CALL cl_set_comp_att_text('xrcc124_512',l_str)
      CALL cl_set_comp_att_text('xrcc134_612',l_str)
      LET l_xrae002 = l_xrae002 + 1
   END IF

   #第13段帳齡
   IF l_xrae002 <= l_count THEN
      EXECUTE axrq930_xrae002 USING l_xrae002 INTO l_xrae003,l_xrae004
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc118_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc118_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc118_413',l_str)
      CALL cl_set_comp_att_text('xrcc128_513',l_str)
      CALL cl_set_comp_att_text('xrcc138_613',l_str)
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc114_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc114_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc114_413',l_str)
      CALL cl_set_comp_att_text('xrcc124_513',l_str)
      CALL cl_set_comp_att_text('xrcc134_613',l_str)
      LET l_xrae002 = l_xrae002 + 1
   END IF

   #第14段帳齡
   IF l_xrae002 <= l_count THEN
      EXECUTE axrq930_xrae002 USING l_xrae002 INTO l_xrae003,l_xrae004
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc118_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc118_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc118_414',l_str)
      CALL cl_set_comp_att_text('xrcc128_514',l_str)
      CALL cl_set_comp_att_text('xrcc138_614',l_str)
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc114_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc114_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc114_414',l_str)
      CALL cl_set_comp_att_text('xrcc124_514',l_str)
      CALL cl_set_comp_att_text('xrcc134_614',l_str)
      LET l_xrae002 = l_xrae002 + 1
   END IF

   #第15段帳齡
   IF l_xrae002 <= l_count THEN
      EXECUTE axrq930_xrae002 USING l_xrae002 INTO l_xrae003,l_xrae004
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc118_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc118_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc118_415',l_str)
      CALL cl_set_comp_att_text('xrcc128_515',l_str)
      CALL cl_set_comp_att_text('xrcc138_615',l_str)
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc114_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc114_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc114_415',l_str)
      CALL cl_set_comp_att_text('xrcc124_515',l_str)
      CALL cl_set_comp_att_text('xrcc134_615',l_str)
      LET l_xrae002 = l_xrae002 + 1
   END IF

   #第16段帳齡
   IF l_xrae002 <= l_count THEN
      EXECUTE axrq930_xrae002 USING l_xrae002 INTO l_xrae003,l_xrae004
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc118_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc118_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc118_416',l_str)
      CALL cl_set_comp_att_text('xrcc128_516',l_str)
      CALL cl_set_comp_att_text('xrcc138_616',l_str)
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc114_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc114_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc114_416',l_str)
      CALL cl_set_comp_att_text('xrcc124_516',l_str)
      CALL cl_set_comp_att_text('xrcc134_616',l_str)
      LET l_xrae002 = l_xrae002 + 1
   END IF

   #第17段帳齡
   IF l_xrae002 <= l_count THEN
      EXECUTE axrq930_xrae002 USING l_xrae002 INTO l_xrae003,l_xrae004
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc118_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc118_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc118_417',l_str)
      CALL cl_set_comp_att_text('xrcc128_517',l_str)
      CALL cl_set_comp_att_text('xrcc138_617',l_str)
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc114_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc114_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc114_417',l_str)
      CALL cl_set_comp_att_text('xrcc124_517',l_str)
      CALL cl_set_comp_att_text('xrcc134_617',l_str)
      LET l_xrae002 = l_xrae002 + 1
   END IF

   #第18段帳齡
   IF l_xrae002 <= l_count THEN
      EXECUTE axrq930_xrae002 USING l_xrae002 INTO l_xrae003,l_xrae004
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc118_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc118_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc118_418',l_str)
      CALL cl_set_comp_att_text('xrcc128_518',l_str)
      CALL cl_set_comp_att_text('xrcc138_618',l_str)
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc114_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc114_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc114_418',l_str)
      CALL cl_set_comp_att_text('xrcc124_518',l_str)
      CALL cl_set_comp_att_text('xrcc134_618',l_str)
      LET l_xrae002 = l_xrae002 + 1
   END IF

   #第19段帳齡
   IF l_xrae002 <= l_count THEN
      EXECUTE axrq930_xrae002 USING l_xrae002 INTO l_xrae003,l_xrae004
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc118_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc118_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc118_419',l_str)
      CALL cl_set_comp_att_text('xrcc128_519',l_str)
      CALL cl_set_comp_att_text('xrcc138_619',l_str)
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc114_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc114_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc114_419',l_str)
      CALL cl_set_comp_att_text('xrcc124_519',l_str)
      CALL cl_set_comp_att_text('xrcc134_619',l_str)
      LET l_xrae002 = l_xrae002 + 1
   END IF

   #第20段帳齡
   IF l_xrae002 <= l_count THEN
      EXECUTE axrq930_xrae002 USING l_xrae002 INTO l_xrae003,l_xrae004
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc118_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc118_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc118_420',l_str)
      CALL cl_set_comp_att_text('xrcc128_520',l_str)
      CALL cl_set_comp_att_text('xrcc138_620',l_str)
      IF l_xrae002 = l_count THEN
         LET l_str = '>',l_xrae003 USING '<<<<',lbl_xrcc114_g CLIPPED
      ELSE
         LET l_str = l_xrae003 USING '<<<<','-',l_xrae004 USING '<<<<',lbl_xrcc114_g CLIPPED
      END IF
      CALL cl_set_comp_att_text('xrcc114_420',l_str)
      CALL cl_set_comp_att_text('xrcc124_520',l_str)
      CALL cl_set_comp_att_text('xrcc134_620',l_str)
      LET l_xrae002 = l_xrae002 + 1
   END IF

   #隱藏不使用的欄位
   #顯示全部欄位
   CALL axrq930_comp_visible()
   #依照帳齡段數隱藏不使用欄位
   CALL axrq930_comp_unvisible(l_count)

END FUNCTION

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
PRIVATE FUNCTION axrq930_comp_visible()
   CALL cl_set_comp_visible('xrcc118_401,xrcc118_402,xrcc118_403,xrcc118_404,xrcc118_405,xrcc118_406,xrcc118_407,xrcc118_408,xrcc118_409,xrcc118_410',TRUE)
   CALL cl_set_comp_visible('xrcc118_411,xrcc118_412,xrcc118_413,xrcc118_414,xrcc118_415,xrcc118_416,xrcc118_417,xrcc118_418,xrcc118_419,xrcc118_420',TRUE)
   CALL cl_set_comp_visible('xrcc128_501,xrcc128_502,xrcc128_503,xrcc128_504,xrcc128_505,xrcc128_506,xrcc128_507,xrcc128_508,xrcc128_509,xrcc128_510',TRUE)
   CALL cl_set_comp_visible('xrcc128_511,xrcc128_512,xrcc128_513,xrcc128_514,xrcc128_515,xrcc128_516,xrcc128_517,xrcc128_518,xrcc128_519,xrcc128_520',TRUE)
   CALL cl_set_comp_visible('xrcc138_601,xrcc138_602,xrcc138_603,xrcc138_604,xrcc138_605,xrcc138_606,xrcc138_607,xrcc138_608,xrcc138_609,xrcc138_610',TRUE)
   CALL cl_set_comp_visible('xrcc138_611,xrcc138_612,xrcc138_613,xrcc138_614,xrcc138_615,xrcc138_616,xrcc138_617,xrcc138_618,xrcc138_619,xrcc138_620',TRUE)

   CALL cl_set_comp_visible('xrcc114_401,xrcc114_402,xrcc114_403,xrcc114_404,xrcc114_405,xrcc114_406,xrcc114_407,xrcc114_408,xrcc114_409,xrcc114_410',TRUE)
   CALL cl_set_comp_visible('xrcc114_411,xrcc114_412,xrcc114_413,xrcc114_414,xrcc114_415,xrcc114_416,xrcc114_417,xrcc114_418,xrcc114_419,xrcc114_420',TRUE)
   CALL cl_set_comp_visible('xrcc124_501,xrcc124_502,xrcc124_503,xrcc124_504,xrcc124_505,xrcc124_506,xrcc124_507,xrcc124_508,xrcc124_509,xrcc124_510',TRUE)
   CALL cl_set_comp_visible('xrcc124_511,xrcc124_512,xrcc124_513,xrcc124_514,xrcc124_515,xrcc124_516,xrcc124_517,xrcc124_518,xrcc124_519,xrcc124_520',TRUE)
   CALL cl_set_comp_visible('xrcc134_601,xrcc134_602,xrcc134_603,xrcc134_604,xrcc134_605,xrcc134_606,xrcc134_607,xrcc134_608,xrcc134_609,xrcc134_610',TRUE)
   CALL cl_set_comp_visible('xrcc134_611,xrcc134_612,xrcc134_613,xrcc134_614,xrcc134_615,xrcc134_616,xrcc134_617,xrcc134_618,xrcc134_619,xrcc134_620',TRUE)
END FUNCTION

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
PRIVATE FUNCTION axrq930_comp_unvisible(p_num)
   DEFINE p_num         LIKE type_t.num5

   IF p_num < 1 THEN
      CALL cl_set_comp_visible('xrcc118_401,xrcc128_501,xrcc138_601,xrcc114_401,xrcc124_501,xrcc134_601',FALSE)
   END IF

   IF p_num < 2 THEN
      CALL cl_set_comp_visible('xrcc118_402,xrcc128_502,xrcc138_602,xrcc114_402,xrcc124_502,xrcc134_602',FALSE)
   END IF

   IF p_num < 3 THEN
      CALL cl_set_comp_visible('xrcc118_403,xrcc128_503,xrcc138_603,xrcc114_403,xrcc124_503,xrcc134_603',FALSE)
   END IF

   IF p_num < 4 THEN
      CALL cl_set_comp_visible('xrcc118_404,xrcc128_504,xrcc138_604,xrcc114_404,xrcc124_504,xrcc134_604',FALSE)
   END IF

   IF p_num < 5 THEN
      CALL cl_set_comp_visible('xrcc118_405,xrcc128_505,xrcc138_605,xrcc114_405,xrcc124_505,xrcc134_605',FALSE)
   END IF

   IF p_num < 6 THEN
      CALL cl_set_comp_visible('xrcc118_406,xrcc128_506,xrcc138_606,xrcc114_406,xrcc124_506,xrcc134_606',FALSE)
   END IF

   IF p_num < 7 THEN
      CALL cl_set_comp_visible('xrcc118_407,xrcc128_507,xrcc138_607,xrcc114_407,xrcc124_507,xrcc134_607',FALSE)
   END IF

   IF p_num < 8 THEN
      CALL cl_set_comp_visible('xrcc118_408,xrcc128_508,xrcc138_608,xrcc114_408,xrcc124_508,xrcc134_608',FALSE)
   END IF

   IF p_num < 9 THEN
      CALL cl_set_comp_visible('xrcc118_409,xrcc128_509,xrcc138_609,xrcc114_409,xrcc124_509,xrcc134_609',FALSE)
   END IF

   IF p_num < 10 THEN
      CALL cl_set_comp_visible('xrcc118_410,xrcc128_510,xrcc138_610,xrcc114_410,xrcc124_510,xrcc134_610',FALSE)
   END IF

   IF p_num < 11 THEN
      CALL cl_set_comp_visible('xrcc118_411,xrcc128_511,xrcc138_611,xrcc114_411,xrcc124_511,xrcc134_611',FALSE)
   END IF

   IF p_num < 12 THEN
      CALL cl_set_comp_visible('xrcc118_412,xrcc128_512,xrcc138_612,xrcc114_412,xrcc124_512,xrcc134_612',FALSE)
   END IF

   IF p_num < 13 THEN
      CALL cl_set_comp_visible('xrcc118_413,xrcc128_513,xrcc138_613,xrcc114_413,xrcc124_513,xrcc134_613',FALSE)
   END IF

   IF p_num < 14 THEN
      CALL cl_set_comp_visible('xrcc118_414,xrcc128_514,xrcc138_614,xrcc114_414,xrcc124_514,xrcc134_614',FALSE)
   END IF

   IF p_num < 15 THEN
      CALL cl_set_comp_visible('xrcc118_415,xrcc128_515,xrcc138_615,xrcc114_415,xrcc124_515,xrcc134_615',FALSE)
   END IF

   IF p_num < 16 THEN
      CALL cl_set_comp_visible('xrcc118_416,xrcc128_516,xrcc138_616,xrcc114_416,xrcc124_516,xrcc134_616',FALSE)
   END IF

   IF p_num < 17 THEN
      CALL cl_set_comp_visible('xrcc118_417,xrcc128_517,xrcc138_617,xrcc114_417,xrcc124_517,xrcc134_617',FALSE)
   END IF

   IF p_num < 18 THEN
      CALL cl_set_comp_visible('xrcc118_418,xrcc128_518,xrcc138_618,xrcc114_418,xrcc124_518,xrcc134_618',FALSE)
   END IF

   IF p_num < 19 THEN
      CALL cl_set_comp_visible('xrcc118_419,xrcc128_519,xrcc138_619,xrcc114_419,xrcc124_519,xrcc134_619',FALSE)
   END IF

   IF p_num < 20 THEN
      CALL cl_set_comp_visible('xrcc118_420,xrcc128_520,xrcc138_620,xrcc114_420,xrcc124_520,xrcc134_620',FALSE)
   END IF

END FUNCTION

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
PRIVATE FUNCTION axrq930_sel_gen()
   IF cl_null(g_xrca_m.xrcald)  THEN RETURN END IF
   IF cl_null(g_xrca_m.year) THEN RETURN END IF
   IF cl_null(g_xrca_m.month) THEN RETURN END IF

#   LET g_xrca_m.xref006 = ''
#   SELECT DISTINCT xref006 INTO g_xrca_m.xref006 FROM xref_t WHERE xrefent = g_enterprise
#      AND xrefld = g_xrca_m.xrcald AND xref001 = g_xrca_m.year AND xref002 = g_xrca_m.month AND xref003 = 'AR'

#   CALL axrq930_set_entry('')
#   CALL axrq930_set_no_entry('')
#
END FUNCTION

################################################################################
# Descriptions...: 預設值
# Memo...........:
# Usage..........: CALL axrq930_default()
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq930_default()
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_glcb007   LIKE glcb_t.glcb007
   
   #帳務中心
   CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING l_success,g_xrca_m.xrcasite,g_errno
   CALL axrq930_xrca_ref("xrcasite")
   #帳別
   CALL s_ld_bookno()  RETURNING l_success,g_xrca_m.xrcald
   IF l_success = FALSE THEN
      LET g_xrca_m.xrcald=""
   END IF 
   CALL s_ld_chk_authorization(g_user,g_xrca_m.xrcald) RETURNING l_success
   IF l_success = FALSE THEN
      LET g_xrca_m.xrcald=""
   END IF
   #帳別說明、法人、法人說明
   CALL axrq930_xrca_ref("xrcald")
   #會計年度
   LET g_xrca_m.year=YEAR(g_today)
   #期別
   LET g_xrca_m.month=MONTH(g_today)
   CALL axrq930_set_month_scc()
   #帳齡類型
   SELECT glcb003,glcb008,glcb007 INTO g_xrca_m.xrad001,g_xrca_m.glcb008,l_glcb007 FROM glcb_t
   WHERE glcbent=g_enterprise AND glcbld=g_xrca_m.xrcald AND glcb001='AR'
   CALL axrq930_xrca_ref("xrad001")
   #暫估單
   IF l_glcb007 <> 'Y' THEN
      LET g_xrca_m.chk_a='N'
   ELSE
      LET g_xrca_m.chk_a='Y'
   END IF
   #折讓待抵單
   LET g_xrca_m.chk_b='Y'
   #原幣顯示否
   LET g_xrca_m.chk_c='Y'
   #扣抵方式
   IF cl_null(g_xrca_m.glcb008) THEN
      LET g_xrca_m.glcb008='1'
   END IF
   #是否隐藏本位币二、三页签
   IF g_glaa015='Y' THEN
      CALL cl_set_comp_visible("bpage_2,bpage_5",TRUE)
   ELSE
      CALL cl_set_comp_visible("bpage_2,bpage_5",FALSE)
   END IF
   IF g_glaa019='Y' THEN
      CALL cl_set_comp_visible("bpage_3,bpage_6",TRUE)
   ELSE
      CALL cl_set_comp_visible("bpage_3,bpage_6",FALSE)
   END IF
   #匯總方式
   LET g_xrca_m.sum_type='1'
   DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc,g_xrca_m.xrcald,
                   g_xrca_m.xrcald_desc,g_xrca_m.xrcacomp,g_xrca_m.xrcacomp_desc,
                   g_xrca_m.year,g_xrca_m.month,g_xrca_m.sum_type,g_xrca_m.xrad001,
                   g_xrca_m.xrad001_desc,g_xrca_m.xrad004,g_xrca_m.chk_a,g_xrca_m.chk_b
END FUNCTION

################################################################################
# Descriptions...: 設置期別scc
# Memo...........:
# Usage..........: CALL axrq930_set_month_scc()
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq930_set_month_scc()
   DEFINE l_glaa003       LIKE glaa_t.glaa003
   DEFINE l_glav003       LIKE glav_t.glav003
   DEFINE l_glav006       LIKE glav_t.glav006
   
   SELECT glav003,glav006 INTO l_glav003,l_glav006 FROM glav_t
    WHERE glavent=g_enterprise AND glav001=g_glaa003
      AND glav002=g_xrca_m.year AND glav004=g_today
   IF l_glav003='2' THEN
      CALL cl_set_combo_items('month','1,2,3,4,5,6,7,8,9,10,11,12,13','1,2,3,4,5,6,7,8,9,10,11,12,13')
#      CALL cl_set_combo_scc_part('month','8861','1,2,3,4,5,6,7,8,9,10,11,12,13')
   ELSE
      CALL cl_set_combo_items('month','1,2,3,4,5,6,7,8,9,10,11,12','1,2,3,4,5,6,7,8,9,10,11,12')
#      CALL cl_set_combo_scc_part('month','8861','1,2,3,4,5,6,7,8,9,10,11,12')
   END IF
   LET g_xrca_m.month=l_glav006
END FUNCTION

################################################################################
# Descriptions...: 建立临时表
# Memo...........:
# Usage..........: CALL axrq930_create_temp_table()
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq930_create_temp_table()
   DROP TABLE axrq930_tmp
   CREATE TEMP TABLE axrq930_tmp(
   xrcaent          LIKE xrca_t.xrcaent,
   xrcald           LIKE xrca_t.xrcald,
   xrca001          LIKE xrca_t.xrca001,
   xrccdocno        LIKE xrcc_t.xrccdocno,
   xrccseq          LIKE xrcc_t.xrccseq,
   xrcc001          LIKE xrcc_t.xrcc001,
   xrcc100          LIKE xrcc_t.xrcc100,
   xrca004          LIKE xrca_t.xrca004,
   xrcadocdt        LIKE xrca_t.xrcadocdt,
   xrca014          LIKE xrca_t.xrca014,
   xrca015          LIKE xrca_t.xrca015,
   xrca035          LIKE xrca_t.xrca035,
   xrcc003          LIKE xrcc_t.xrcc003,
   xrcc004          LIKE xrcc_t.xrcc004,
   delay              LIKE type_t.num10,
   xrek039          LIKE xrek_t.xrek039,
   xrek037          LIKE xrek_t.xrek037,
   xrcc108          LIKE xrcc_t.xrcc108,
   xrcc109          LIKE xrcc_t.xrcc109,
   xrcc104          LIKE xrcc_t.xrcc108,
   xrcc106          LIKE xrcc_t.xrcc108,
   xrcc118          LIKE xrcc_t.xrcc118,
   xrcc119          LIKE xrcc_t.xrcc119,
   xrcc113          LIKE xrcc_t.xrcc113,
   xrcc114          LIKE xrcc_t.xrcc118,
   xrcc116          LIKE xrcc_t.xrcc118,
   xrcc128          LIKE xrcc_t.xrcc128,
   xrcc129          LIKE xrcc_t.xrcc129,
   xrcc123          LIKE xrcc_t.xrcc123,
   xrcc124          LIKE xrcc_t.xrcc128,
   xrcc126          LIKE xrcc_t.xrcc128,
   xrcc138          LIKE xrcc_t.xrcc138,
   xrcc139          LIKE xrcc_t.xrcc139,
   xrcc133          LIKE xrcc_t.xrcc133,
   xrcc134          LIKE xrcc_t.xrcc138,
   xrcc136          LIKE xrcc_t.xrcc138,
   xrea103          LIKE xrea_t.xrea103,
   xrea113          LIKE xrea_t.xrea113,
   xrea123          LIKE xrea_t.xrea123,
   xrea133          LIKE xrea_t.xrea133)
END FUNCTION

################################################################################
# Descriptions...: 抓取资料插入临时表
# Memo...........:
# Usage..........: CALL axrq930_get_data()
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq930_get_data()
   DEFINE l_sql,l_sql1       STRING
   DEFINE l_wc               STRING
   DEFINE l_xrcc       RECORD 
          xrcaent          LIKE xrca_t.xrcaent,
          xrcald           LIKE xrca_t.xrcald,
          xrca001          LIKE xrca_t.xrca001,
          xrccdocno        LIKE xrcc_t.xrccdocno,
          xrccseq          LIKE xrcc_t.xrccseq,
          xrcc001          LIKE xrcc_t.xrcc001,
          xrcc100          LIKE xrcc_t.xrcc100,
          xrca004          LIKE xrca_t.xrca004,    #帳款客戶
          xrcadocdt        LIKE xrca_t.xrcadocdt,
          xrca014          LIKE xrca_t.xrca014,    #業務人員
          xrca015          LIKE xrca_t.xrca015,    #業務部門
          xrca035          LIKE xrca_t.xrca035,    #應收科目
          xrcc003          LIKE xrcc_t.xrcc003,
          xrcc004          LIKE xrcc_t.xrcc004,
          delay              LIKE type_t.num10,
          xrek039          LIKE xrek_t.xrek039,
          xrek037          LIKE xrek_t.xrek037,
          xrcc108          LIKE xrcc_t.xrcc108,
          xrcc109          LIKE xrcc_t.xrcc109,
          xrcc104          LIKE xrcc_t.xrcc108,
          xrcc106          LIKE xrcc_t.xrcc108,
          xrcc118          LIKE xrcc_t.xrcc118,
          xrcc119          LIKE xrcc_t.xrcc119,
          xrcc113          LIKE xrcc_t.xrcc113,
          xrcc114          LIKE xrcc_t.xrcc118,
          xrcc116          LIKE xrcc_t.xrcc118,
          xrcc128          LIKE xrcc_t.xrcc128,
          xrcc129          LIKE xrcc_t.xrcc129,
          xrcc123          LIKE xrcc_t.xrcc123,
          xrcc124          LIKE xrcc_t.xrcc128,
          xrcc126          LIKE xrcc_t.xrcc128,
          xrcc138          LIKE xrcc_t.xrcc138,
          xrcc139          LIKE xrcc_t.xrcc139,
          xrcc133          LIKE xrcc_t.xrcc133,
          xrcc134          LIKE xrcc_t.xrcc138,
          xrcc136          LIKE xrcc_t.xrcc138,
          xrea103          LIKE xrea_t.xrea103,
          xrea113          LIKE xrea_t.xrea113,
          xrea123          LIKE xrea_t.xrea123,
          xrea133          LIKE xrea_t.xrea133
          END RECORD
   DEFINE l_date           LIKE xrca_t.xrcadocdt
   DEFINE l_xrcb001        LIKE xrcb_t.xrcb001
   DEFINE l_xrcb002        LIKE xrcb_t.xrcb002
   DEFINE l_xrcb003        LIKE xrcb_t.xrcb003
   DEFINE l_xrcc010        LIKE xrcc_t.xrcc010
   DEFINE l_xrcc011        LIKE xrcc_t.xrcc011
   DEFINE l_xrcc012        LIKE xrcc_t.xrcc012
   DEFINE l_xrcc013        LIKE xrcc_t.xrcc013
   DEFINE l_xrcc014        LIKE xrcc_t.xrcc014
   DEFINE l_xrek036        LIKE xrek_t.xrek036
   DEFINE l_xrce109        LIKE xrce_t.xrce109
   DEFINE l_xrce119        LIKE xrce_t.xrce119
   DEFINE l_xrce129        LIKE xrce_t.xrce129
   DEFINE l_xrce139        LIKE xrce_t.xrce139
   DEFINE l_apce109        LIKE apce_t.apce109
   DEFINE l_apce119        LIKE apce_t.apce119
   DEFINE l_apce129        LIKE apce_t.apce129
   DEFINE l_apce139        LIKE apce_t.apce139
   DEFINE l_year           LIKE type_t.num5
   DEFINE l_month          LIKE type_t.num5
   
   DELETE FROM axrq930_tmp
   #當期最大日期
   SELECT MAX(glav004) INTO l_date FROM glav_t
    WHERE glavent=g_enterprise AND glav001=g_glaa003 
      AND glav002=g_xrca_m.year AND glav006=g_xrca_m.month
   #前期
   LET l_year = g_xrca_m.year
   LET l_month = g_xrca_m.month
   LET l_month = l_month - 1 
   IF l_month = 0 THEN
      LET l_month = 12
      LET l_year = l_year - 1
   END IF

   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('3',g_xrca_m.xrcasite,g_today,'1')
   #取得帳務中心底下的帳套範圍               
   CALL s_fin_account_center_ld_str() RETURNING l_wc
   CALL s_fin_get_wc_str(l_wc) RETURNING l_wc

   #抓取所有符合條件的帳款資料    
   LET l_sql="SELECT xrcaent,xrcald,xrca001,xrccdocno,xrccseq,xrcc001,xrcc100,xrca004,xrcadocdt,",
             "       xrcc003,xrcc004,xrca014,xrca015,xrca035,xrcb001,xrcb002,xrcb003,",
             "       xrcc010,xrcc011,xrcc012,xrcc013,xrcc014,",
             "       xrcc108,xrcc109,xrcc118,xrcc119,xrcc113,xrcc128,xrcc129,xrcc123,",
             "       xrcc138,xrcc139,xrcc133 ",
             "  FROM xrca_t,xrcb_t,xrcc_t ",
             " WHERE xrcaent=xrcbent AND xrcald=xrcbld AND xrcadocno=xrcbdocno ",
             "   AND xrcaent=xrccent AND xrcald=xrccld AND xrcadocno=xrccdocno AND xrcbseq=xrccseq ",
             "   AND xrcaent=",g_enterprise," AND xrcald IN ",l_wc,
             "   AND xrcasite='",g_xrca_m.xrcasite,"' ",
             "   AND xrcadocdt<='",l_date,"' AND xrcastus='Y'"
   #暫估類帳款納入分析否
   IF g_xrca_m.chk_a <> 'Y' THEN
      LET l_sql=l_sql," AND xrca001 NOT LIKE '0%'"
   END IF
   #待抵及帳款減項扣除
   IF g_xrca_m.chk_b <> 'Y' THEN
      LET l_sql=l_sql," AND xrca001 NOT LIKE '2%'"
   END IF
   
   PREPARE axrq930_data_pr FROM l_sql
   DECLARE axrq930_data_cs CURSOR FOR axrq930_data_pr
   
   FOREACH axrq930_data_cs INTO l_xrcc.xrcaent,l_xrcc.xrcald,l_xrcc.xrca001,l_xrcc.xrccdocno,l_xrcc.xrccseq,
                                l_xrcc.xrcc001,l_xrcc.xrcc100,l_xrcc.xrca004,l_xrcc.xrcadocdt,l_xrcc.xrcc003,
                                l_xrcc.xrcc004,l_xrcc.xrca014,l_xrcc.xrca015,l_xrcc.xrca035,l_xrcb001,
                                l_xrcb002,l_xrcb003,l_xrcc010,l_xrcc011,l_xrcc012,l_xrcc013,l_xrcc014,
                                l_xrcc.xrcc108,l_xrcc.xrcc109,l_xrcc.xrcc118,l_xrcc.xrcc119,l_xrcc.xrcc113,
                                l_xrcc.xrcc128,l_xrcc.xrcc129,l_xrcc.xrcc123,
                                l_xrcc.xrcc138,l_xrcc.xrcc139,l_xrcc.xrcc133
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      IF cl_null(l_xrcc.xrcc108) THEN LET l_xrcc.xrcc108=0 END IF
      IF cl_null(l_xrcc.xrcc109) THEN LET l_xrcc.xrcc109=0 END IF
      IF cl_null(l_xrcc.xrcc118) THEN LET l_xrcc.xrcc118=0 END IF
      IF cl_null(l_xrcc.xrcc119) THEN LET l_xrcc.xrcc119=0 END IF
      IF cl_null(l_xrcc.xrcc113) THEN LET l_xrcc.xrcc113=0 END IF
      IF cl_null(l_xrcc.xrcc128) THEN LET l_xrcc.xrcc128=0 END IF
      IF cl_null(l_xrcc.xrcc129) THEN LET l_xrcc.xrcc129=0 END IF
      IF cl_null(l_xrcc.xrcc123) THEN LET l_xrcc.xrcc123=0 END IF
      IF cl_null(l_xrcc.xrcc138) THEN LET l_xrcc.xrcc138=0 END IF
      IF cl_null(l_xrcc.xrcc139) THEN LET l_xrcc.xrcc139=0 END IF
      IF cl_null(l_xrcc.xrcc133) THEN LET l_xrcc.xrcc133=0 END IF
      
      #逾期天數  = 條件期別最大日期 - 實際應兌現日 xrcc004 (負數則給0 ) 
      IF NOT cl_null(l_date) AND NOT cl_null(l_xrcc.xrcc004) THEN
         LET l_xrcc.delay = l_date - l_xrcc.xrcc004
      ELSE
         LET l_xrcc.delay = 0
      END IF
      IF l_xrcc.delay<0 THEN LET l_xrcc.delay=0 END IF
      
      #帳齡起算起始日
      CASE g_xrca_m.xrad004
         WHEN '01' #交易單據日期
            LET l_xrek036 = l_xrcc011
         WHEN '03' #發票日期
            LET l_xrek036 = l_xrcc010
	      WHEN '05' #立帳日期
	         LET l_xrek036 = l_xrcc012
	      WHEN '07' #出入庫扣帳日期
	         LET l_xrek036 = l_xrcc014
	      WHEN '09' #交易認定日期
	         LET l_xrek036 = l_xrcc013
	      WHEN '90' #應收付款日
	         LET l_xrek036 = l_xrcc.xrcc003
	      WHEN '92' #依交易對象設定     
#	         等 apmm100 開好欄位才能處理
#               select pmaa073 from apmm100 
#                 where 客戶 =  xrca004 
#                 依客戶設定取 對應的上述的 xrcc 欄位
      END CASE
      #帳齡天數   = 條件期別最大日期 - 帳齡起算日   (負數則給0 )
      IF NOT cl_null(l_date) AND NOT cl_null(l_xrek036) THEN
         LET l_xrcc.xrek037=l_date - l_xrek036
      ELSE
         LET l_xrcc.xrek037=0
      END IF
      IF l_xrcc.xrek037<0 THEN LET l_xrcc.xrek037=0 END IF
      
      #原幣未沖金額
      #xrcc108-xrcc109(扣除大於當期的沖帳金額,反推)
      LET l_xrce109 = 0
      LET l_xrce119 = 0
      LET l_xrce129 = 0
      LET l_xrce139 = 0
      IF l_xrcc.xrca001[1,1] <> '0' THEN
         SELECT SUM(xrce109),SUM(xrce119),SUM(xrce129),SUM(xrce139)
         INTO l_xrce109,l_xrce119,l_xrce129,l_xrce139
         FROM xrce_t,xrda_t
         WHERE xrceent=xrdaent AND xrcedocno=xrdadocno AND xrceld=xrdald
         AND xrceent=g_enterprise AND xrceld=g_xrca_m.xrcald
         AND xrce003=l_xrcc.xrccdocno AND xrce004=l_xrcc.xrccseq AND xrce005=l_xrcc.xrcc001
         AND xrdadocdt > l_date AND xrdastus='Y'
      ELSE
         SELECT SUM(xrcf105),SUM(xrcf115),SUM(xrcf125),SUM(xrcf135)
         INTO l_xrce109,l_xrce119,l_xrce129,l_xrce139
         FROM xrcf_t,xrca_t
         WHERE xrcfent=xrcaent AND xrcfdocno=xrcadocno AND xrcfld=xrcald
         AND xrcfent=g_enterprise AND xrcfld=g_xrca_m.xrcald
         AND xrcf008=l_xrcc.xrccdocno AND xrcf009=l_xrcc.xrccseq
         AND xrcadocdt > l_date AND xrcastus='Y'
      END IF
      IF cl_null(l_xrce109) THEN LET l_xrce109=0 END IF
      IF cl_null(l_xrce119) THEN LET l_xrce119=0 END IF
      IF cl_null(l_xrce129) THEN LET l_xrce129=0 END IF
      IF cl_null(l_xrce139) THEN LET l_xrce139=0 END IF
      LET l_xrcc.xrcc109=l_xrcc.xrcc109 - l_xrce109
      LET l_xrcc.xrcc119=l_xrcc.xrcc119 - l_xrce119
      LET l_xrcc.xrcc129=l_xrcc.xrcc129 - l_xrce129
      LET l_xrcc.xrcc139=l_xrcc.xrcc139 - l_xrce139
      
      #應付回沖
      LET l_apce109 = 0
      LET l_apce119 = 0
      LET l_apce129 = 0
      LET l_apce139 = 0
      SELECT SUM(apce109),SUM(apce119),SUM(apce129),SUM(apce139)
        INTO l_apce109,l_apce119,l_apce129,l_apce139
        FROM apda_t,apce_t 
       WHERE apdaent = apceent AND apdald = apceld AND apdadocno = apcedocno
         AND apdaent = g_enterprise 
         AND apdadocdt > l_date
         AND apdasite= g_xrca_m.xrcasite    #同一帳務中心
         AND apdald  = g_xrca_m.xrcald       #同一帳套
         AND apce003 = l_xrcc.xrccdocno #AR 單號 
         AND apce004 = l_xrcc.xrccseq #AR 項次 
         AND apce005 = l_xrcc.xrcc001 #AR 期別
         AND apdastus= 'Y'
      IF cl_null(l_apce109) THEN LET l_apce109=0 END IF
      IF cl_null(l_apce119) THEN LET l_apce119=0 END IF
      IF cl_null(l_apce129) THEN LET l_apce129=0 END IF
      IF cl_null(l_apce139) THEN LET l_apce139=0 END IF
      LET l_xrcc.xrcc109=l_xrcc.xrcc109 - l_apce109
      LET l_xrcc.xrcc119=l_xrcc.xrcc119 - l_apce119
      LET l_xrcc.xrcc129=l_xrcc.xrcc129 - l_apce129
      LET l_xrcc.xrcc139=l_xrcc.xrcc139 - l_apce139
      
      #壞帳提列比率
      CALL axrq930_get_xrek039(l_xrcc.xrca004,l_xrcc.xrek037) RETURNING l_xrcc.xrek039
      
      LET l_xrcc.xrcc104=(l_xrcc.xrcc108 - l_xrcc.xrcc109)*l_xrcc.xrek039/100
      LET l_xrcc.xrcc114=(l_xrcc.xrcc118 - l_xrcc.xrcc119 + l_xrcc.xrcc113)*l_xrcc.xrek039/100
      LET l_xrcc.xrcc124=(l_xrcc.xrcc128 - l_xrcc.xrcc129 + l_xrcc.xrcc123)*l_xrcc.xrek039/100
      LET l_xrcc.xrcc134=(l_xrcc.xrcc138 - l_xrcc.xrcc139 + l_xrcc.xrcc133)*l_xrcc.xrek039/100
      LET l_xrcc.xrcc106=0
      LET l_xrcc.xrcc116=0
      LET l_xrcc.xrcc126=0
      LET l_xrcc.xrcc136=0
      
      #期初金額 : 取月結檔上一期的金額
      LET l_xrcc.xrea103 = 0
      LET l_xrcc.xrea113 = 0
      LET l_xrcc.xrea123 = 0
      LET l_xrcc.xrea133 = 0
      SELECT xrea103,xrea113,xrea123,xrea133 
        INTO l_xrcc.xrea103,l_xrcc.xrea113,l_xrcc.xrea123,l_xrcc.xrea133
        FROM xrea_t
       WHERE xreaent=g_enterprise AND xrea001=l_year AND xrea002=l_month 
         AND xreald=g_xrca_m.xrcald AND xrea003='AR'
         AND xrea005=l_xrcc.xrccdocno AND xrea006=l_xrcc.xrccseq AND xrea007=l_xrcc.xrcc001
      IF cl_null(l_xrcc.xrea103) THEN LET l_xrcc.xrea103=0 END IF
      IF cl_null(l_xrcc.xrea113) THEN LET l_xrcc.xrea113=0 END IF
      IF cl_null(l_xrcc.xrea123) THEN LET l_xrcc.xrea123=0 END IF
      IF cl_null(l_xrcc.xrea133) THEN LET l_xrcc.xrea133=0 END IF
      
      #待抵單金額以負數呈現
      IF l_xrcc.xrca001[1,1] = '2' OR l_xrcc.xrca001 = '02' OR l_xrcc.xrca001 = '04' THEN
         LET l_xrcc.xrcc108 = l_xrcc.xrcc108 * (-1)
         LET l_xrcc.xrcc109 = l_xrcc.xrcc109 * (-1)
         LET l_xrcc.xrcc104 = l_xrcc.xrcc104 * (-1)
         LET l_xrcc.xrcc106 = l_xrcc.xrcc106 * (-1)
         LET l_xrcc.xrcc118 = l_xrcc.xrcc118 * (-1)
         LET l_xrcc.xrcc119 = l_xrcc.xrcc119 * (-1)
         LET l_xrcc.xrcc113 = l_xrcc.xrcc113 * (-1)
         LET l_xrcc.xrcc114 = l_xrcc.xrcc114 * (-1)
         LET l_xrcc.xrcc116 = l_xrcc.xrcc116 * (-1)
         LET l_xrcc.xrcc128 = l_xrcc.xrcc128 * (-1)
         LET l_xrcc.xrcc129 = l_xrcc.xrcc129 * (-1)
         LET l_xrcc.xrcc123 = l_xrcc.xrcc123 * (-1)
         LET l_xrcc.xrcc124 = l_xrcc.xrcc124 * (-1)
         LET l_xrcc.xrcc126 = l_xrcc.xrcc126 * (-1)
         LET l_xrcc.xrcc138 = l_xrcc.xrcc138 * (-1)
         LET l_xrcc.xrcc139 = l_xrcc.xrcc139 * (-1)
         LET l_xrcc.xrcc133 = l_xrcc.xrcc133 * (-1)
         LET l_xrcc.xrcc134 = l_xrcc.xrcc134 * (-1)
         LET l_xrcc.xrcc136 = l_xrcc.xrcc136 * (-1)
         LET l_xrcc.xrea103 = l_xrcc.xrea103 * (-1)
         LET l_xrcc.xrea113 = l_xrcc.xrea113 * (-1)
         LET l_xrcc.xrea123 = l_xrcc.xrea123 * (-1)
         LET l_xrcc.xrea133 = l_xrcc.xrea133 * (-1)
      END IF
      
      INSERT INTO axrq930_tmp VALUES(l_xrcc.*)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF 
   END FOREACH
   
   
   
END FUNCTION

################################################################################
# Descriptions...: 通過客戶信評等級抓取壞帳提列比率（axri041 xraf_t）
# Memo...........:
# Usage..........: CALL axrq930_get_xrek039(p_xrca004,p_xrek037)
# Modify.........: 
################################################################################
PRIVATE FUNCTION axrq930_get_xrek039(p_xrca004,p_xrek037)
   DEFINE p_xrca004     LIKE xrca_t.xrca004
   DEFINE p_xrek037     LIKE xrek_t.xrek037
   DEFINE l_pmab004     LIKE pmab_t.pmab004
   DEFINE l_xrae002     LIKE xrae_t.xrae002
   DEFINE l_xraf        RECORD LIKE xraf_t.*
   DEFINE r_xrek039     LIKE xrek_t.xrek039
   
   # 信評等級
   SELECT pmab004 INTO l_pmab004 FROM pmab_t  
     WHERE pmabent=g_enterprise AND pmab001 = p_xrca004
       AND pmabsite=g_xrca_m.xrcacomp    
   # 分段序號
   SELECT xrae002 INTO l_xrae002 FROM xrae_t 
     WHERE xraeent = g_enterprise
       AND xrae001 = g_xrca_m.xrad001 #帳齡類型 
       AND xrae003 <= p_xrek037 #帳齡天數 >= 起始天數
       AND xrae004 >= p_xrek037 #帳齡天數 <= 截止天數
 
   SELECT * INTO l_xraf.* FROM xraf_t 
    WHERE xrafent = g_enterprise
      AND xraf001 = g_xrca_m.xrad001 #帳齡類型 
      AND xraf002 = l_pmab004 # 信評等級
         
    CASE l_xrae002   # 分段序號
       WHEN 1  LET r_xrek039= l_xraf.xraf003 
       WHEN 2  LET r_xrek039= l_xraf.xraf004
       WHEN 3  LET r_xrek039= l_xraf.xraf005
       WHEN 4  LET r_xrek039= l_xraf.xraf006
       WHEN 5  LET r_xrek039= l_xraf.xraf007
       WHEN 6  LET r_xrek039= l_xraf.xraf008
       WHEN 7  LET r_xrek039= l_xraf.xraf009
       WHEN 8  LET r_xrek039= l_xraf.xraf010
       WHEN 9  LET r_xrek039= l_xraf.xraf011
       WHEN 10  LET r_xrek039= l_xraf.xraf012
       WHEN 11  LET r_xrek039= l_xraf.xraf013
       WHEN 12  LET r_xrek039= l_xraf.xraf014
       WHEN 13  LET r_xrek039= l_xraf.xraf015
       WHEN 14  LET r_xrek039= l_xraf.xraf016
       WHEN 15  LET r_xrek039= l_xraf.xraf017
       WHEN 16  LET r_xrek039= l_xraf.xraf018
       WHEN 17  LET r_xrek039= l_xraf.xraf019
       WHEN 18  LET r_xrek039= l_xraf.xraf020
       WHEN 19  LET r_xrek039= l_xraf.xraf021
       WHEN 20  LET r_xrek039= l_xraf.xraf022
       OTHERWISE  LET r_xrek039= 0 
   END CASE
   IF SQLCA.sqlcode = 100 THEN   
      # 分段序號
      SELECT xrae005 INTO r_xrek039 FROM xrae_t 
       WHERE xraeent = g_enterprise
         AND xrae001 = g_xrca_m.xrad001 #帳齡類型 
         AND xrae003 <= p_xrek037 #帳齡天數 >= 起始天數
         AND xrae004 >= p_xrek037 #帳齡天數 <= 截止天數
   END IF
   RETURN r_xrek039
END FUNCTION

################################################################################
# Descriptions...: 推算帳齡天數
# Memo...........:
# Usage..........: CALL axrq930_get_xred013(p_xrcadocdt,p_xrcb001,p_xrcb002,p_xrcc003)
#                  RETURNING r_xred012
# Input parameter: p_xrcadocdt    應收帳款日期
#                : p_xrcb001      來源類型
#                : p_xrcb002      來源單號
#                : p_xrcc003      應收款日
# Return code....: r_xred012      帳齡天數
# Date & Author..: 日期 By 作者
# Modify.........: 暫時不用這隻函數
################################################################################
PRIVATE FUNCTION axrq930_get_xred013(p_xrcadocdt,p_xrcb001,p_xrcb002,p_xrcc003)
   DEFINE p_xrcadocdt           LIKE xrca_t.xrcadocdt
   DEFINE p_xrcb001             LIKE xrcb_t.xrcb001
   DEFINE p_xrcb002             LIKE xrcb_t.xrcb002
   DEFINE p_xrcc003             LIKE xrcc_t.xrcc003
   DEFINE l_date_s              LIKE xrca_t.xrcadocdt
   DEFINE l_date_e              LIKE xrca_t.xrcadocdt
   DEFINE r_xrek037             LIKE type_t.num5
   
   #帳齡起算起始日
   CASE g_xrca_m.xrad004
      WHEN '01'
         IF p_xrcb001='axmt540' OR p_xrcb001='axmt600' THEN
            SELECT xmdkdocdt INTO l_date_s FROM xmdk_t
            WHERE xmdkent=g_enterprise AND xmdkdocno=p_xrcb002
         END IF
         IF p_xrcb001='artt600' THEN
            SELECT rtiadocdt INTO l_date_s FROM rtia_t
            WHERE rtiaent=g_enterprise AND rtiadocdt=p_xrcb002
         END IF
         IF cl_null(l_date_s) THEN LET l_date_s=p_xrcadocdt END IF
      WHEN '03'
         SELECT MIN(isaf014) INTO l_date_s FROM isaf_t
         WHERE isafent=g_enterprise AND isaf035=p_xrcb002
         IF cl_null(l_date_s) THEN LET l_date_s=p_xrcadocdt END IF
      WHEN '05'
         LET l_date_s=p_xrcadocdt
      WHEN '07'
         IF p_xrcb001='axmt540' OR p_xrcb001='axmt600' THEN
            SELECT xmdk001 INTO l_date_s FROM xmdk_t
            WHERE xmdkent=g_enterprise AND xmdkdocno=p_xrcb002
         END IF
         IF p_xrcb001='artt600' THEN
            SELECT rtia006 INTO l_date_s FROM rtia_t
            WHERE rtiaent=g_enterprise AND rtiadocdt=p_xrcb002
         END IF
         IF cl_null(l_date_s) THEN LET l_date_s=p_xrcadocdt END IF
      WHEN '90'
         LET l_date_s=p_xrcc003
   END CASE
   #該期別最大日期
   SELECT MAX(glav004) INTO l_date_e FROM glav_t
    WHERE glavent=g_enterprise AND glav001=g_glaa003 
      AND glav002=g_xrca_m.year AND glav006=g_xrca_m.month
   #帳齡天數=該期別最大日期 – 帳齡起算日 ???
   IF NOT cl_null(l_date_e) AND NOT cl_null(l_date_s) THEN
      LET r_xrek037=l_date_e - l_date_s
   ELSE
      LET r_xrek037=0
   END IF
   IF r_xrek037<0 THEN LET r_xrek037=0 END IF
   RETURN r_xrek037
END FUNCTION

################################################################################
# Descriptions...: 明細單身資料
# Memo...........:
# Usage..........: CALL axrq930_b_fill1()
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq930_b_fill1()
   DEFINE ls_wc           STRING
   {
   LET g_sql=" SELECT UNIQUE 'N',xrcborga,xrcborga,'','',xrca004,'',xrca001,xrccdocno,xrccseq,xrcc001,xrcadocdt,",
             "        xrcc004,delay,xrek037,xrcc100,xrcc108 - xrcc109 - xrcc106,",
             "        xrcc118 - xrcc119 + xrcc113 -xrcc116,xrek039,xrcc104,xrcc114,",
             "        xrcborga,xrca001,xrccdocno,xrccseq,xrcc001,xrca004,'',xrcadocdt,",
             "        xrcc004,delay,xrek037,xrcc128 - xrcc129 + xrcc123 - xrcc126,xrek039,xrcc124,",
             "        xrcborga,xrca001,xrccdocno,xrccseq,xrcc001,xrca004,'',xrcadocdt,",
             "        xrcc004,delay,xrek037,xrcc138 - xrcc139 + xrcc133 - xrcc136,xrek039,xrcc134 ",
             "   FROM axrq930_tmp",
             "  WHERE (xrcc108-xrcc106 <>0) OR (xrcc118-xrcc116 <>0) "
   
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axrq930_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR axrq930_pb1
 
   CALL g_xrcc_d.clear()
   CALL g_xrcc2_d.clear()   
   CALL g_xrcc3_d.clear()
   CALL g_xrcc4_d.clear()
   CALL g_xrcc5_d.clear()
   CALL g_xrcc6_d.clear()
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs1 INTO g_xrcc_d[l_ac].sel,g_xrcc_d[l_ac].xrcborga,g_xrcc_d[l_ac].xrcborga,g_xrcc_d[l_ac].xrcald,g_xrcc_d[l_ac].glaal002,g_xrcc_d[l_ac].xrca004,
       g_xrcc_d[l_ac].xrca004_desc,g_xrcc_d[l_ac].xrca001, 
       g_xrcc_d[l_ac].xrccdocno,g_xrcc_d[l_ac].xrccseq,g_xrcc_d[l_ac].xrcc001, 
       g_xrcc_d[l_ac].xrcadocdt,g_xrcc_d[l_ac].xrcc004,g_xrcc_d[l_ac].delay,g_xrcc_d[l_ac].xrek037,g_xrcc_d[l_ac].xrcc100,g_xrcc_d[l_ac].xrcc108, 
       g_xrcc_d[l_ac].xrcc118,g_xrcc_d[l_ac].xrek039,g_xrcc_d[l_ac].xrcc104,g_xrcc_d[l_ac].xrcc114,g_xrcc2_d[l_ac].xrcborga, 
       g_xrcc2_d[l_ac].xrca001,g_xrcc2_d[l_ac].xrccdocno,g_xrcc2_d[l_ac].xrccseq,g_xrcc2_d[l_ac].xrcc001, 
       g_xrcc2_d[l_ac].xrca004,g_xrcc2_d[l_ac].xrca004_2_desc,g_xrcc2_d[l_ac].xrcadocdt,
       g_xrcc2_d[l_ac].xrcc004,g_xrcc2_d[l_ac].delay2, 
       g_xrcc2_d[l_ac].xrek037,g_xrcc2_d[l_ac].xrcc128,g_xrcc2_d[l_ac].xrek039,g_xrcc2_d[l_ac].xrcc124, 
       g_xrcc3_d[l_ac].xrcborga,g_xrcc3_d[l_ac].xrca001,g_xrcc3_d[l_ac].xrccdocno,g_xrcc3_d[l_ac].xrccseq, 
       g_xrcc3_d[l_ac].xrcc001,g_xrcc3_d[l_ac].xrca004,g_xrcc3_d[l_ac].xrca004_3_desc,g_xrcc3_d[l_ac].xrcadocdt, 
       g_xrcc3_d[l_ac].xrcc004,g_xrcc3_d[l_ac].delay3,g_xrcc3_d[l_ac].xrek037,g_xrcc3_d[l_ac].xrcc138, 
       g_xrcc3_d[l_ac].xrek039,g_xrcc3_d[l_ac].xrcc134
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xrcc_d[l_ac].xrca004
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_xrcc_d[l_ac].xrca004_desc = g_xrcc_d[l_ac].xrca004,'(', g_rtn_fields[1] , ')'
      LET g_xrcc2_d[l_ac].xrca004_2_desc = g_xrcc_d[l_ac].xrca004_desc
      LET g_xrcc3_d[l_ac].xrca004_3_desc = g_xrcc_d[l_ac].xrca004_desc
      
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
      
   END FOREACH
   LET g_error_show = 0
   
 
   
   CALL g_xrcc_d.deleteElement(g_xrcc_d.getLength())   
   CALL g_xrcc2_d.deleteElement(g_xrcc2_d.getLength())
 
   CALL g_xrcc3_d.deleteElement(g_xrcc3_d.getLength())

   #顯示匯總資料
   #待抵資料處理
   CALL axrq930_analy_data()
   CALL axrq930_title()
   CALL axrq930_summary()
  
   LET g_detail_cnt = g_xrcc_d.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   LET l_ac = 1
   IF g_xrcc_d.getLength() > 0 THEN
      CALL axrq930_fetch()
   END IF
   
   CALL axrq930_filter_show('xrcbsite','b_xrcbsite')
}
END FUNCTION

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
PRIVATE FUNCTION axrq930_query1()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_glcb003       LIKE glcb_t.glcb003
   DEFINE l_glcb008       LIKE glcb_t.glcb008
   #end add-point 
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_xrcc_d.clear()
   LET g_wc_filter = " 1=1"
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET g_master_idx = l_ac
 
   
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
       INPUT BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcald,g_xrca_m.xrcacomp,g_xrca_m.year,
                    g_xrca_m.month,g_xrca_m.sum_type,g_xrca_m.xrad001,g_xrca_m.xrad004,
                    g_xrca_m.chk_a,g_xrca_m.chk_b,g_xrca_m.glcb008
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
            DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc,g_xrca_m.xrcald,
                            g_xrca_m.xrcald_desc,g_xrca_m.xrcacomp,g_xrca_m.xrcacomp_desc,
                            g_xrca_m.year,g_xrca_m.month,g_xrca_m.sum_type,g_xrca_m.xrad001,
                            g_xrca_m.xrad001_desc,g_xrca_m.xrad004,g_xrca_m.chk_a,g_xrca_m.chk_b,
                            g_xrca_m.glcb008
         AFTER FIELD xrcasite
            IF NOT cl_null(g_xrca_m.xrcasite) THEN
               CALL s_fin_account_center_with_ld_chk(g_xrca_m.xrcasite,g_xrca_m.xrcald,g_user,'3','N','',g_today) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  LET g_xrca_m.xrcasite = ''
                  LET g_xrca_m.xrcald=''
                  CALL axrq930_xrca_ref('xrcasite')
                  CALL axrq930_xrca_ref('xrcald')
                  NEXT FIELD CURRENT
               END IF
            END IF
           CALL axrq930_xrca_ref('xrcasite')
          
         AFTER FIELD xrcald
            IF NOT cl_null(g_xrca_m.xrcald) THEN
               CALL s_fin_account_center_with_ld_chk(g_xrca_m.xrcasite,g_xrca_m.xrcald,g_user,'3','N','',g_today) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  LET g_xrca_m.xrcald=''
                  CALL axrq930_xrca_ref('xrcald')
                  NEXT FIELD CURRENT
               ELSE
                  #帳齡類型
                  SELECT glcb003,glcb008 INTO l_glcb003,l_glcb008 FROM glcb_t
                  WHERE glcbent=g_enterprise AND glcbld=g_xrca_m.xrcald AND glcb001='AR'
                  IF cl_null(g_xrca_m.xrad001) THEN
                     LET g_xrca_m.xrad001=l_glcb003
                     CALL axrq930_xrca_ref('xrad001')
                  END IF
                  IF cl_null(g_xrca_m.glcb008) THEN
                     LET g_xrca_m.glcb008=l_glcb008
                  END IF
                  
                  SELECT glaacomp,glaa003,glaa015,glaa019
                    INTO g_xrca_m.xrcacomp,g_glaa003,g_glaa015,g_glaa019 
                    FROM glaa_t 
                   WHERE glaaent = g_enterprise AND glaald =  g_xrca_m.xrcald
                  #是否隐藏本位币二、三页签
                  IF g_glaa015='Y' THEN
                     CALL cl_set_comp_visible("bpage_2,bpage_5",TRUE)
                  ELSE
                     CALL cl_set_comp_visible("bpage_2,bpage_5",FALSE)
                  END IF
                  IF g_glaa019='Y' THEN
                     CALL cl_set_comp_visible("bpage_3,bpage_6",TRUE)
                  ELSE
                     CALL cl_set_comp_visible("bpage_3,bpage_6",FALSE)
                  END IF
               END IF
            END IF
            CALL axrq930_xrca_ref('xrcald')
            CALL axrq930_set_month_scc()
      
         AFTER FIELD xrad001
            IF NOT cl_null(g_xrca_m.xrad001) THEN
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xrca_m.xrad001
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_xrad001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  LET g_xrca_m.xrad001=''
                  CALL axrq930_xrca_ref("xrad001")
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL axrq930_xrca_ref("xrad001")
            
         ON ACTION controlp INFIELD xrcasite
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrca_m.xrcasite             #給予default值
            LET g_qryparam.default2 = "" #g_xrca_m.xrah002 #帳務中心
            LET g_qryparam.where = " ooef201 = 'Y' "
            CALL q_ooef001()                                #呼叫開窗
            LET g_xrca_m.xrcasite = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_xrca_m.xrcasite TO xrcasite              #顯示到畫面上
            CALL axrq930_xrca_ref('xrcasite')
            NEXT FIELD xrcasite 

         ON ACTION controlp INFIELD xrcald
            CALL s_fin_create_account_center_tmp()   
            #取得帳務組織下所屬成員
            CALL s_fin_account_center_sons_query('3',g_xrca_m.xrcasite,g_today,'1')
            #取得帳務組織下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING ls_wc
            #將取回的字串轉換為SQL條件
            CALL s_fin_get_wc_str(ls_wc) RETURNING ls_wc
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrca_m.xrcald             #給予default值
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",ls_wc,""
            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()                                #呼叫開窗
            LET g_xrca_m.xrcald = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_xrca_m.xrcald TO xrcald              #顯示到畫面上
            CALL axrq930_xrca_ref('xrcald')
            NEXT FIELD xrcald                          #返回原欄位

         ON ACTION controlp INFIELD xrad001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_xrca_m.xrad001           #給予default值
               CALL axri014_01()                                #呼叫開窗
               LET g_xrca_m.xrad001 = g_qryparam.return1              
               DISPLAY g_xrca_m.xrad001 TO xrad001
               CALL axrq930_xrca_ref('xrad001')
               NEXT FIELD xrad001                          #返回原欄位
               
      END INPUT
 
      ON ACTION accept
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
 
     
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
 
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         
 
   END DIALOG
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = ls_wc
      RETURN
   ELSE
      LET g_master_idx = 1
   END IF
   
   #數據處理，寫入臨時表
   CALL axrq930_get_data()
 
   LET g_error_show = 1
   CALL axrq930_b_fill1()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 折讓待抵資料沖抵
# Memo...........:
# Usage..........: CALL axrq930_analy_data()
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq930_analy_data()
   DEFINE l_sql,l_sql1     STRING
   DEFINE l_xrccdocno      LIKE xrcc_t.xrccdocno
   DEFINE l_xrccseq        LIKE xrcc_t.xrccseq
   DEFINE l_xrcc001        LIKE xrcc_t.xrcc001
   DEFINE l_xrcc106        LIKE xrcc_t.xrcc108
   DEFINE l_xrcc116        LIKE xrcc_t.xrcc108
   DEFINE l_xrcc126        LIKE xrcc_t.xrcc108
   DEFINE l_xrcc136        LIKE xrcc_t.xrcc108
   DEFINE l_sum            LIKE xrcc_t.xrcc108
   DEFINE l_sum1           LIKE xrcc_t.xrcc108
   DEFINE l_sum2           LIKE xrcc_t.xrcc108
   DEFINE l_sum3           LIKE xrcc_t.xrcc108
   DEFINE l_amt            LIKE xrcc_t.xrcc108
   DEFINE l_amt1           LIKE xrcc_t.xrcc108
   DEFINE l_amt2           LIKE xrcc_t.xrcc108
   DEFINE l_amt3           LIKE xrcc_t.xrcc108
   DEFINE l_xrccdocno_s    LIKE xrcc_t.xrccdocno
   DEFINE l_xrccseq_s      LIKE xrcc_t.xrccseq
   DEFINE l_xrcc001_s      LIKE xrcc_t.xrcc001
   DEFINE l_xrca004        LIKE xrca_t.xrca004
   DEFINE l_xrcc100        LIKE xrcc_t.xrcc100
   DEFINE l_xrek037        LIKE xrek_t.xrek037
   DEFINE l_xrcc108        LIKE xrcc_t.xrcc108
   DEFINE l_xrcc118        LIKE xrcc_t.xrcc118
   DEFINE l_xrcc128        LIKE xrcc_t.xrcc128
   DEFINE l_xrcc138        LIKE xrcc_t.xrcc138
   
   #待抵方式
   LET l_sql1= ""
   CASE g_xrca_m.glcb008
      WHEN '1'
         RETURN
      WHEN '2'
         LET l_sql1=" ORDER BY xrek037 DESC"
      WHEN '3'
         LET l_sql1=" ORDER BY xrek037 "
      WHEN '4'
         RETURN
   END CASE 
   
   #折讓待抵帳款
   LET l_sql="SELECT xrccdocno,xrccseq,xrcc001,xrcc100,xrca004,xrek037,",
             "       (-1)*(xrcc108 - xrcc109),(-1)*(xrcc118 - xrcc119 + xrcc113),",
             "       (-1)*(xrcc128 - xrcc129 + xrcc123),(-1)*(xrcc138 - xrcc139 + xrcc133) ",
             "  FROM axrq930_tmp",
             " WHERE xrca001 LIKE '2%' ",
             "   AND ",g_wc_filter2,  #2015/01/16
             "   AND ((xrcc108 - xrcc109)<>0 OR (xrcc118 - xrcc119 + xrcc113)<>0) ",l_sql1
   
   PREPARE axrq930_data_pr1 FROM l_sql
   DECLARE axrq930_data_cs1 CURSOR FOR axrq930_data_pr1
   #立帳帳款
   LET l_sql="SELECT xrccdocno,xrccseq,xrcc001,xrek037,xrcc108 - xrcc109 - xrcc106,xrcc118 - xrcc119 + xrcc113 - xrcc116,",
             "       xrcc128 - xrcc129 + xrcc123 - xrcc126,xrcc138 - xrcc139 + xrcc133 - xrcc136 ",
             "  FROM axrq930_tmp",
             " WHERE xrca001  LIKE '1%' ",
             "   AND ",g_wc_filter2,  #2015/01/16
             "   AND xrcc100=? AND xrca004 =? ",
             "   AND ((xrcc108 - xrcc109 - xrcc106)<>0 OR (xrcc118 - xrcc119 + xrcc113 - xrcc116)<>0) ",l_sql1
            
   PREPARE axrq930_data_pr2 FROM l_sql
   DECLARE axrq930_data_cs2 CURSOR FOR axrq930_data_pr2
   
   #沖抵帳款資料
   FOREACH axrq930_data_cs1 INTO l_xrccdocno,l_xrccseq,l_xrcc001,
                                 l_xrcc100,l_xrca004,l_xrek037,
                                 l_xrcc108,l_xrcc118,l_xrcc128,l_xrcc138  #沖抵帳款金額
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      LET l_sum  = l_xrcc108
      LET l_sum1 = l_xrcc118
      LET l_sum3 = l_xrcc128
      LET l_sum3 = l_xrcc138
      #立帳帳款資料
      FOREACH axrq930_data_cs2 USING l_xrcc100,l_xrca004 
                                INTO l_xrccdocno_s,l_xrccseq_s,l_xrcc001_s,l_xrek037,
                                     l_amt,l_amt1,l_amt2,l_amt3 #應收立帳中未沖金額 - 扣抵金額
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF  
         #待抵金額 > 立帳金額
         IF l_sum > l_amt THEN
            LET l_xrcc106 = l_amt
            LET l_xrcc116 = l_amt1
            LET l_xrcc126 = l_amt2
            LET l_xrcc136 = l_amt3
         ELSE
            LET l_xrcc106 =l_sum
            LET l_xrcc116 = l_sum1
            LET l_xrcc126 = l_sum2
            LET l_xrcc136 = l_sum3
         END IF
         LET l_sum =l_sum  - l_xrcc106
         LET l_sum1=l_sum1 - l_xrcc116
         LET l_sum2=l_sum2 - l_xrcc126
         LET l_sum3=l_sum3 - l_xrcc136
         #更新立帳單分攤金額
         UPDATE axrq930_tmp SET xrcc106=xrcc106 + l_xrcc106, 
                                xrcc116=xrcc116 + l_xrcc116,
                                xrcc126=xrcc126 + l_xrcc126,
                                xrcc136=xrcc136 + l_xrcc136
         WHERE xrccdocno=l_xrccdocno_s AND xrccseq=l_xrccseq_s AND xrcc001=l_xrcc001_s
         IF l_sum <= 0 THEN 
            EXIT FOREACH
         END IF
      END FOREACH
      #更新待抵單被分攤金額
      LET l_xrcc106 = l_xrcc108 - l_sum
      LET l_xrcc116 = l_xrcc118 - l_sum1
      LET l_xrcc126 = l_xrcc128 - l_sum2
      LET l_xrcc136 = l_xrcc138 - l_sum3
      #待抵單以負數呈現
      UPDATE axrq930_tmp SET xrcc106= l_xrcc106 * (-1),
                             xrcc116= l_xrcc116 * (-1),
                             xrcc126= l_xrcc126 * (-1),
                             xrcc136= l_xrcc136 * (-1)
      WHERE xrccdocno=l_xrccdocno AND xrccseq=l_xrccseq AND xrcc001=l_xrcc001
   END FOREACH
END FUNCTION
################################################################################
# Descriptions...: 單身二次篩選
# Memo...........:
# Usage..........: CALL axrq930_filter2()
# Date & Author..: 2015/01/16 By zhangweib
# Modify.........: 
#                : 
################################################################################
PRIVATE FUNCTION axrq930_filter2()
 DEFINE l_wc_filter2_t STRING
 DEFINE ls_wc          STRING
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
 
   LET l_wc_filter2_t = g_wc_filter2
   LET g_wc_t = g_wc
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", TRUE)    

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM) 
      CONSTRUCT g_wc_filter2 ON xrcald,xrccdocno,xrca004_desc,xrcadocdt_1,
                                xrcc004_1,xrcc100_1
                          FROM s_detail1[1].xrcald,s_detail1[1].xrccdocno,s_detail1[1].xrca004_desc,s_detail1[1].xrcadocdt_1,
                               s_detail1[1].xrcc004_1,s_detail1[1].xrcc100_1
      
         ON ACTION controlp INFIELD xrccdocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xrcadocno()
            DISPLAY g_qryparam.return1 TO xrccdocno
            NEXT FIELD xrccdocno
         
         ON ACTION controlp INFIELD xrca004_desc
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "pmaa002 IN ('2','3')"
            CALL q_pmaa001()
            DISPLAY g_qryparam.return1 TO xrca004_desc            
            NEXT FIELD xrca004_desc   
         
         ON ACTION controlp INFIELD xrcc100_1
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()
            DISPLAY g_qryparam.return1 TO xrcc100_1     
            NEXT FIELD xrcc100_1      
          
         ON ACTION controlp INFIELD xrcald
            CALL s_fin_create_account_center_tmp()   
            #取得帳務組織下所屬成員
            CALL s_fin_account_center_sons_query('3',g_xrca_m.xrcasite,g_today,'1')
            #取得帳務組織下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING ls_wc
            #將取回的字串轉換為SQL條件
            CALL axrq930_get_ooef001_wc(ls_wc) RETURNING ls_wc  
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaald IN ",ls_wc
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO xrcald
            NEXT FIELD xrcald
      END CONSTRUCT

      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
 
     &include "common_action.4gl"
     CONTINUE DIALOG
    
   END DIALOG  

   LET g_wc_filter2 = cl_replace_str(g_wc_filter2,"xrca004_desc","xrca004")

   IF NOT INT_FLAG THEN
      LET g_wc_filter2 = g_wc_filter2, " "
   ELSE
      LET g_wc_filter2 = l_wc_filter2_t
   END IF

   CALL axrq930_b_fill()   
END FUNCTION
################################################################################
# Descriptions...: 將取回的字串轉換為SQL條件
# Memo...........:
# Usage..........: CALL axrt340_get_ooef001_wc(p_wc)
#                  RETURNING r_wc
# Input parameter: p_wc           字符串
# Return code....: r_wc           sql組合條件
# Date & Author..: 2014/09/11 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq930_get_ooef001_wc(p_wc)
   DEFINE p_wc       STRING
   DEFINE r_wc       STRING
   DEFINE tok        base.StringTokenizer
   DEFINE l_str      STRING

   LET tok = base.StringTokenizer.create(p_wc,",")
   WHILE tok.hasMoreTokens()
      IF cl_null(l_str) THEN
         LET l_str = tok.nextToken()
      ELSE
         LET l_str = l_str,"','",tok.nextToken()
      END IF      
   END WHILE   
   LET r_wc = "('",l_str,"')"
   
   RETURN r_wc
END FUNCTION

 
{</section>}
 
