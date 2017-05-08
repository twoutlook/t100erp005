#該程式已解開Section, 不再透過樣板產出!
{<section id="aglq500.description" >}
#應用 a00 樣板自動產生(Version:1)
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000090
#+ 
#+ Filename...: aglq500
#+ Description: 憑證過帳前檢查作業
#+ Creator....: 01727(2015-09-16 14:40:13)
#+ Modifier...: 01727(2015-09-21 15:20:49) -SD/PR- 02599
 
{</section>}
 
{<section id="aglq500.global" >}
#應用 q04 樣板自動產生(Version:21)
#160321-00016#30   2016/03/25  By Jessy         修正azzi920重複定義之錯誤訊息
#160318-00005#17  2016/03/29   by 07675         將重複內容的錯誤訊息置換為公用錯誤訊息
#160727-00019#3   2016/08/01   By 08742         系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                               Mod   aglq500_prt_errno -->aglq500_tmp01
#                                               Mod   aglq500_prt_status -->aglq500_tmp02
#                                               Mod   aglq500_prt_lostno -->aglq500_tmp02
#170103-00019#19  2017/01/16   By 02599         增加细项立冲检核，檢核應立未立;應沖未沖
 
IMPORT os
IMPORT util
#add-point:增加匯入項目
 
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_master        RECORD
       fflabel_1 LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_detail RECORD
       #20150921 此處有做Section修改 chr500 --> clob
       sel LIKE type_t.chr1, 
   glapdocno LIKE glap_t.glapdocno, 
   glapdocdt LIKE glap_t.glapdocdt, 
   glap007 LIKE glap_t.glap007, 
   glapstus LIKE glap_t.glapstus, 
   glapcrtid LIKE glap_t.glapcrtid, 
   glapcnfid LIKE glap_t.glapcnfid, 
   glap010 LIKE glap_t.glap010, 
   glap011 LIKE glap_t.glap011, 
   error   LIKE ooff_t.ooff013,
   image LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_detail2 RECORD
       glapstus LIKE type_t.chr10, 
   glapdocno LIKE type_t.chr20, 
   glapdocdt LIKE type_t.dat, 
   glap007 LIKE type_t.chr10, 
   glapcrtid LIKE type_t.chr20, 
   glapcnfid LIKE type_t.chr20, 
   glap010 LIKE type_t.num20_6, 
   glap011 LIKE type_t.num20_6
       END RECORD
 
PRIVATE TYPE type_g_detail3 RECORD
       oobx001 LIKE type_t.chr5, 
   oobxl003 LIKE type_t.chr500, 
   oobx005 LIKE type_t.chr1, 
   oobx006 LIKE type_t.chr1, 
   oobx007 LIKE type_t.num5, 
   sdocno LIKE type_t.chr20, 
   edocno LIKE type_t.chr20, 
   count LIKE type_t.num5
       END RECORD
 
 
 
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
 
 
 
#add-point:自定義模組變數-標準(Module Variable)
 type type_g_input        RECORD
       glapld      LIKE glap_t.glapld,
       glapld_desc LIKE glaal_t.glaal002,
       glap002     LIKE glap_t.glap002,
       glap004     LIKE glap_t.glap004,
       sdate       LIKE glap_t.glapdocdt,
       edate       LIKE glap_t.glapdocdt,
       check1      LIKE type_t.chr1,
       check2      LIKE type_t.chr1,
       check3      LIKE type_t.chr1,
       check4      LIKE type_t.chr1
       END RECORD

DEFINE g_input            type_g_input
DEFINE l_msg           DYNAMIC ARRAY OF RECORD
          l_errno         LIKE type_t.chr1000
                       END RECORD
DEFINE g_glaa004   LIKE glaa_t.glaa004
DEFINE g_glaa005   LIKE glaa_t.glaa005
DEFINE g_glaa019   LIKE glaa_t.glaa019
DEFINE g_glaa001   LIKE glaa_t.glaa001
DEFINE g_glaa015   LIKE glaa_t.glaa015
#end add-point
#add-point:自定義模組變數-客製(Module Variable)

##end add-point
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="aglq500.main" >}
 #應用 a26 樣板自動產生(Version:5)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用)
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("agl","")
 
   #add-point:作業初始化
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = " ", 
                      " FROM ",
                      " "
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq500_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define
   
   #end add-point
   PREPARE aglq500_master_referesh FROM g_sql
 
   #add-point:main段define_sql
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq500_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq500 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq500_init()   
 
      #進入選單 Menu (="N")
      CALL aglq500_ui_dialog() 
      
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq500
      
   END IF 
   
   CLOSE aglq500_cl
   
   
 
   #add-point:作業離開前
   DROP TABLE aglq500_tmp01;   #160727-00019#3  Mod  aglq500_prt_errno -->aglq500_tmp01
   DROP TABLE aglq500_tmp02;   #160727-00019#3  Mod  aglq500_prt_status -->aglq500_tmp02
   DROP TABLE aglq500_tmp03;   #160727-00019#3  Mod  aglq500_prt_lostno -->aglq500_tmp03
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
{</section>}
 
{<section id="aglq500.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aglq500_init()
   #add-point:init段define-標準
   
   #end add-point
   #add-point:init段define-客製
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_master_row_move = "Y"
      CALL cl_set_combo_scc_part('b_glapstus','13','N,Y,S,A,D,R,W,X')
   CALL cl_set_combo_scc_part('glapstus','13','N,Y,S,A,D,R,W,X')
 
      CALL cl_set_combo_scc('b_glap007','8007') 
   CALL cl_set_combo_scc('glap007','8007') 
  
 
   #add-point:畫面資料初始化
   CALL cl_set_combo_scc("oobx006",'14')
   CALL aglq500_ctr_tmp()
   #end add-point
 
   CALL aglq500_default_search()
END FUNCTION
 
{</section>}
 
{<section id="aglq500.default_search" >}
PRIVATE FUNCTION aglq500_default_search()
   #add-point:default_search段define-標準
   
   #end add-point
   #add-point:default_search段define-客製
   
   #end add-point
 
 
   #add-point:default_search段開始前
   
   #end add-point
 
   
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段結束前
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq500.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aglq500_ui_dialog() 
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
   #add-point:ui_dialog段define-標準
   DEFINE l_site    LIKE glaa_t.glaacomp
   DEFINE l_comp    LIKE glaa_t.glaacomp
   DEFINE l_success LIKE type_t.num5
   #end add-point
   #add-point:ui_dialog段define-客製
   
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
 
   #add-point:ui_dialog段before dialog 
   
   #end add-point
 
   
 
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      CALL aglq500_cs()
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
 
         CALL aglq500_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落
         INPUT BY NAME g_input.glapld,g_input.glap002,g_input.glap004,g_input.sdate,
                       g_input.edate ,g_input.check1 ,g_input.check2 ,g_input.check3,g_input.check4

            BEFORE INPUT
               IF cl_null(g_input.glapld) THEN
                  #取得預設site,以登入人員做為依據
                  CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING l_success,l_site,g_errno
                  #該帳務中心與帳別無法勾稽到,以登入人員g_user取得預設帳別/法人
                  CALL s_fin_orga_get_comp_ld(l_site) RETURNING l_success,g_errno,l_comp,g_input.glapld
                  CALL s_axrt300_xrca_ref('xrcald',g_input.glapld,'','') RETURNING l_success,g_input.glapld_desc
                  DISPLAY BY NAME g_input.glapld_desc

                  #取得帳套現行年度、期別
                  SELECT glaa010,glaa011 INTO g_input.glap002,g_input.glap004 FROM glaa_t
                   WHERE glaaent = g_enterprise AND glaald = g_input.glapld
                  IF cl_null(g_input.glap002) THEN LET g_input.glap002 = YEAR(g_today) END IF
                  IF cl_null(g_input.glap004) THEN LET g_input.glap004 = MONTH(g_today) END IF

                  #取得起訖日期
                  CALL s_date_get_ymtodate(g_input.glap002,g_input.glap004,g_input.glap002,g_input.glap004)
                     RETURNING g_input.sdate,g_input.edate

                  #檢查內容給默認值
                  LET g_input.check1 = 'Y'
                  LET g_input.check2 = 'Y'
                  LET g_input.check3 = 'Y'
                  LET g_input.check4 = 'Y'
                  LET g_wc = " 1=1"

               END IF

            AFTER FIELD glapld
               IF NOT cl_null(g_input.glapld) THEN
                  LET g_errno = ' '
                  CALL s_fin_ld_chk(g_input.glapld,g_user,'N') RETURNING l_success,g_errno
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_input.glapld
                     #160321-00016#30 --s add
                     LET g_errparam.replace[1] = 'agli010'
                     LET g_errparam.replace[2] = cl_get_progname('agli010',g_lang,"2")
                     LET g_errparam.exeprog = 'agli010'
                     #160321-00016#30 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_input.glapld = ''
                     CALL s_axrt300_xrca_ref('xrcald',g_input.glapld,'','') RETURNING l_success,g_input.glapld_desc
                     NEXT FIELD CURRENT
                  END IF
                  #取得帳套現行年度、期別
                  SELECT glaa010,glaa011 INTO g_input.glap002,g_input.glap004 FROM glaa_t
                   WHERE glaaent = g_enterprise AND glaald = g_input.glapld
                  IF cl_null(g_input.glap002) THEN LET g_input.glap002 = YEAR(g_today) END IF
                  IF cl_null(g_input.glap004) THEN LET g_input.glap004 = MONTH(g_today) END IF

                  #取得起訖日期
                  CALL s_date_get_ymtodate(g_input.glap002,g_input.glap004,g_input.glap002,g_input.glap004)
                     RETURNING g_input.sdate,g_input.edate
               END IF
               CALL s_axrt300_xrca_ref('xrcald',g_input.glapld,'','') RETURNING l_success,g_input.glapld_desc
               DISPLAY BY NAME g_input.glapld_desc

            AFTER FIELD glap002
               IF NOT cl_null(g_input.glap002) THEN
                  IF g_input.glap002 <= 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-00310'
                     LET g_errparam.extend = g_input.glap002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  ELSE
                     #取得起訖日期
                     CALL s_date_get_ymtodate(g_input.glap002,g_input.glap004,g_input.glap002,g_input.glap004)
                        RETURNING g_input.sdate,g_input.edate
                  END IF
               END IF

            AFTER FIELD glap004
               IF NOT cl_null(g_input.glap004) THEN
                  IF g_input.glap002 <= 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-00310'
                     LET g_errparam.extend = g_input.glap004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  ELSE
                     #取得起訖日期
                     CALL s_date_get_ymtodate(g_input.glap002,g_input.glap004,g_input.glap002,g_input.glap004)
                        RETURNING g_input.sdate,g_input.edate
                  END IF
               END IF

            AFTER FIELD sdate
               IF NOT cl_null(g_input.sdate) THEN
                  IF g_input.glap002 <> YEAR(g_input.sdate) OR g_input.glap004 <> MONTH(g_input.sdate) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00225'
                     LET g_errparam.extend = g_input.sdate
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_input.edate) THEN
                     IF g_input.sdate > g_input.edate THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amm-00080'
                     LET g_errparam.extend = g_input.sdate
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF

            AFTER FIELD edate
               IF NOT cl_null(g_input.edate) THEN
                  IF g_input.glap002 <> YEAR(g_input.edate) OR g_input.glap004 <> MONTH(g_input.edate) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00225'
                     LET g_errparam.extend = g_input.sdate
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_input.sdate) THEN
                     IF g_input.sdate > g_input.edate THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amm-00080'
                     LET g_errparam.extend = g_input.edate
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF

            ON ACTION controlp INFIELD glapld
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE

               LET g_qryparam.default1 = g_input.glapld             #給予default值

               #給予arg
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept
               CALL q_authorised_ld()                                #呼叫開窗
               LET g_input.glapld = g_qryparam.return1              #將開窗取得的值回傳到變數
               DISPLAY g_input.glapld TO glapld
               NEXT FIELD glapld

         END INPUT
         #end add-point
 
         #add-point:construct段落
         CONSTRUCT g_wc ON glapcrtid,glapcnfid FROM glapcrtid,glapcnfid

            ON ACTION controlp INFIELD glapcrtid
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE

               #給予arg
               CALL q_ooag001()                              #呼叫開窗
               DISPLAY g_qryparam.return1 TO glapcrtid       #顯示到畫面上
               NEXT FIELD glapcrtid                          #返回原欄位

            ON ACTION controlp INFIELD glapcnfid
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE

               #給予arg
               CALL q_ooag001()                              #呼叫開窗
               DISPLAY g_qryparam.return1 TO glapcnfid       #顯示到畫面上
               NEXT FIELD glapcnfid                          #返回原欄位

         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_detail TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL aglq500_detail_action_trans()
               LET g_master_idx = l_ac
               CALL aglq500_b_fill2()
 
               #add-point:input段before row
               
               #end add-point
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為
            
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
 
               #add-point:input段before row
               
               #end add-point
 
            #自訂ACTION(detail_show,page_2)
            
            #add-point:page2自定義行為
            
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
 
               #add-point:input段before row
               
               #end add-point
 
            #自訂ACTION(detail_show,page_3)
            
            #add-point:page3自定義行為
            
            #end add-point
         END DISPLAY
 
 
 
         #add-point:ui_dialog段define
         
         #end add-point
    
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            CALL aglq500_fetch('')
 
            #add-point:ui_dialog段before dialog
            
            #end add-point
            NEXT FIELD glapld
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog
            
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
 
 
            #add-point:ON ACTION accept
            
            #end add-point
 
            CALL aglq500_cs()
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum
            
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
 
 
               #add-point:ON ACTION exporttoexcel
               
               #end add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
 
         ON ACTION datarefresh   # 重新整理
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq500_fetch('F')
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
            #add-point:ON ACTION datainfo
            
            #end add-point
            CALL aglq500_maintain_prog()
 
         ON ACTION first   # 第一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq500_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION previous   # 上一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq500_fetch('P')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION jump   # 跳至第幾筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq500_fetch('/')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION next   # 下一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq500_fetch('N')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION last   # 最後一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq500_fetch('L')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            LET g_master_row_move = "N"
            CALL aglq500_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            LET g_master_row_move = "N"
            CALL aglq500_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            LET g_master_row_move = "N"
            CALL aglq500_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            LET g_master_row_move = "N"
            CALL aglq500_b_fill()
 
         
         #應用 qs19 樣板自動產生(Version:2)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_detail.getLength()
               LET g_detail[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail.getLength()
               LET g_detail[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel
            
            #end add-point
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               
               #add-point:ON ACTION insert
               
               #END add-point
               
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output
               CALL aglq500_output()
               #END add-point
               
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query
               
               #END add-point
               
               
            END IF
 
 
 
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
         #add-point:查詢方案相關ACTION設定前
         
         #end add-point
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            #add-point:條件清除後
            
            #end add-point 
 
         #add-point:查詢方案相關ACTION設定後
         ON ACTION detail1_click
            CALL aglq500_open_aglt310(g_detail[l_ac].glapdocno)

         ON ACTION detail2_click
            CALL aglq500_open_aglt310(g_detail2[l_ac].glapdocno)

         #end add-point 
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="aglq500.cs" >}
#+ 組單頭CURSOR
PRIVATE FUNCTION aglq500_cs()
   #add-point:cs段define-標準
   CALL aglq500_b_fill()
   RETURN
   #end add-point
   #add-point:cs段define-客製
   
   #end add-point
 
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   IF g_wc2 = " 1=1" THEN
      #add-point:cs段單頭sql組成(未下單身條件)
 
      #end add-point
   ELSE
      #add-point:cs段單頭sql組成(有下單身條件)
      
      #end add-point
   END IF
 
   PREPARE aglq500_pre FROM g_sql
   DECLARE aglq500_curs SCROLL CURSOR WITH HOLD FOR aglq500_pre
   OPEN aglq500_curs
 
   #add-point:cs段單頭總筆數計算
   
   #end add-point
   PREPARE aglq500_precount FROM g_cnt_sql
   EXECUTE aglq500_precount INTO g_row_count
 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = SQLCA.SQLCODE 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
   ELSE
      CALL aglq500_fetch("F")
   END IF
END FUNCTION
 
{</section>}
 
{<section id="aglq500.fetch" >}
#+ 抓取單頭資料
PRIVATE FUNCTION aglq500_fetch(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define-標準
   
   #end add-point
   #add-point:fetch段define-客製
   
   #end add-point
 
   MESSAGE ""
 
   #FETCH段CURSOR移動
   #應用 qs18 樣板自動產生(Version:2)
   #add-point:fetch段CURSOR移動
   
   #end add-point
 
 
 
 
   IF SQLCA.sqlcode THEN
      # 清空右側畫面欄位值，但須保留左側qbe查詢條件
      INITIALIZE g_master.* TO NULL
      DISPLAY g_master.* TO fflabel_1
      CALL g_detail.clear()
      CALL g_detail2.clear()
 
      CALL g_detail3.clear()
 
 
      #add-point:陣列清空
      
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
 
   #add-point:fetch結束前
   
   #end add-point
 
   LET g_master_row_move = "Y"
   #重新顯示
   CALL aglq500_show()
 
END FUNCTION
 
{</section>}
 
{<section id="aglq500.show" >}
PRIVATE FUNCTION aglq500_show()
   DEFINE ls_sql    STRING
   #add-point:show段define-標準
   
   #end add-point
   #add-point:show段define-客製
   
   #end add-point
 
   DISPLAY g_master.* TO fflabel_1
 
   #讀入ref值
   #add-point:show段單身reference
   
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   CALL aglq500_b_fill()
 
END FUNCTION
 
{</section>}
 
{<section id="aglq500.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq500_b_fill()
   DEFINE ls_wc           STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準
   DEFINE li_ac             LIKE type_t.num5
   DEFINE l_diff            LIKE glap_t.glap010
   DEFINE l_diff2           LIKE glap_t.glap010
   DEFINE l_glaa103         LIKE glaa_t.glaa103
   DEFINE l_glap009         LIKE glap_t.glap009
   DEFINE l_glap012         LIKE glap_t.glap012
   DEFINE l_glaq003         LIKE glaq_t.glaq003
   DEFINE l_glaq004         LIKE glaq_t.glaq004
   DEFINE l_count           LIKE type_t.num5
   DEFINE l_str             LIKE type_t.chr1000
   DEFINE l_glap007_desc    LIKE type_t.chr200
   DEFINE l_glapstus_desc   LIKE type_t.chr200
   DEFINE l_glapcrtid_desc  LIKE type_t.chr200
   DEFINE l_glapcnfid_desc  LIKE type_t.chr200
   DEFINE l_sdate           LIKE glap_t.glapdocdt
   DEFINE l_edate           LIKE glap_t.glapdocdt
   #end add-point
   #add-point:b_fill段define-客製
   
   #end add-point
 
   #add-point:b_fill段sql_before

   #修改完年度/期别之后直接点确定,会不走AFTER FIELD
   #这次再次判断是否需要重新刷新开始/结束日期
   CALL s_date_get_ymtodate(g_input.glap002,g_input.glap004,g_input.glap002,g_input.glap004)
      RETURNING l_sdate,l_edate
   IF l_sdate > g_input.sdate OR l_edate < g_input.sdate THEN
      LET g_input.sdate = l_sdate
   END IF

   IF l_sdate > g_input.edate OR l_edate < g_input.edate THEN
      LET g_input.edate = l_edate
   END IF

   DISPLAY BY NAME g_input.sdate,g_input.edate

   SELECT glaa001,glaa103,glaa004,glaa005,glaa015,g_glaa019 INTO g_glaa001,l_glaa103,g_glaa004,g_glaa005,g_glaa015,g_glaa019
     FROM glaa_t WHERE glaaent = g_enterprise
      AND glaald = g_input.glapld

   #end add-point
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   CALL g_detail.clear()
 
   #add-point:陣列清空
   LET ls_wc = "SELECT listagg(glaqseq,',') WITHIN GROUP (ORDER BY glaqseq) FROM glaq_t ",
               " WHERE glaqent = '",g_enterprise,"'",
               "   AND glaqld  = '",g_input.glapld,"'",
               "   AND glaqdocno = ?"
   PREPARE aglq500_b_fill_glaq002 FROM ls_wc
   #end add-point
 
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs09 樣板自動產生(Version:2)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   #add-point:b_fill段sql
   LET g_sql = "SELECT glapdocno,glapdocdt,glap007,glapstus,glapcrtid,glapcnfid,glap010,glap011,glap012,glap009 ",
               "  FROM glap_t WHERE glapent = '",g_enterprise,"'",
               "   AND glapld = '",g_input.glapld,"' ",
               "   AND glap002= ",g_input.glap002,
               "   AND glap004= ",g_input.glap004,
               "   AND ",g_wc CLIPPED,
               "   AND glapdocdt BETWEEN '",g_input.sdate,"' AND '",g_input.edate,"'"

   IF g_input.check2 = 'Y' THEN
      LET g_sql = g_sql," AND glapstus IN ('Y','N')"
   ELSE
      LET g_sql = g_sql," AND glapstus IN ('Y')"
   END IF

   PREPARE aglq500_b_fill_prep FROM g_sql
   DECLARE aglq500_b_fill_curs CURSOR FOR aglq500_b_fill_prep

   DELETE FROM aglq500_tmp01    #160727-00019#3  Mod  aglq500_prt_errno -->aglq500_tmp01

   FOREACH aglq500_b_fill_curs INTO g_detail[l_ac].glapdocno,g_detail[l_ac].glapdocdt,g_detail[l_ac].glap007,
                                    g_detail[l_ac].glapstus ,g_detail[l_ac].glapcrtid,g_detail[l_ac].glapcnfid,
                                    g_detail[l_ac].glap010  ,g_detail[l_ac].glap011,
                                    l_glap012,l_glap009
      CALL l_msg.clear()
      LET li_ac = 1

      #STEP01.單頭借貸金額是否相平檢查
      IF g_detail[l_ac].glap010 <> g_detail[l_ac].glap011 THEN
         LET l_diff = g_detail[l_ac].glap010 - g_detail[l_ac].glap011
         IF l_diff < 0 THEN LET l_diff = l_diff * -1 END IF
         #帳套:%1 憑證編號:%2 借方金額: %3 貸方金額:%4 差異金額:%5 , 
         LET l_msg[li_ac].l_errno = cl_getmsg_parm('agl-00359',g_dlang,g_input.glapld ||'|'|| g_detail[l_ac].glapdocno ||'|'|| g_detail[l_ac].glap010 ||'|'|| g_detail[l_ac].glap011 ||'|'|| l_diff),
                                    cl_getmsg('agl-00033',g_dlang)
         LET li_ac = li_ac + 1
      END IF

      #STEP02.有單頭無單身檢查
      IF g_input.check1 = 'Y' THEN
         LET l_count = 0
         SELECT COUNT (*) INTO l_count FROM glaq_t WHERE glaqent = g_enterprise
            AND glaqld = g_input.glapld
            AND glaqdocno = g_detail[l_ac].glapdocno
         IF cl_null(l_count) THEN lET l_count = 0 END IF
         IF l_count < 1 THEN
            LET l_msg[li_ac].l_errno = cl_getmsg_parm('agl-00360',g_dlang,g_input.glapld ||'|'|| g_detail[l_ac].glapdocno),
                                       cl_getmsg('axm-00090',g_dlang)
            LET li_ac = li_ac + 1
         END IF
      END IF

      #STEP03.單頭借貸不等於單身借貸檢查
      LET l_glaq003 = 0
      LET l_glaq004 = 0
      SELECT SUM(glaq003),SUM(glaq004) INTO l_glaq003,l_glaq004 FROM glaq_t WHERE glaqent = g_enterprise
         AND glaqld = g_input.glapld
         AND glaqdocno = g_detail[l_ac].glapdocno
      IF cl_null(l_glaq003) THEN LET l_glaq003 = 0 END IF
      IF cl_null(l_glaq004) THEN LET l_glaq004 = 0 END IF
      IF g_detail[l_ac].glap010 <> l_glaq003 OR g_detail[l_ac].glap011 <> l_glaq004 THEN
         LET l_diff = g_detail[l_ac].glap010 - l_glaq003
         LET l_diff2= g_detail[l_ac].glap011 - l_glaq004
         IF l_diff < 0 THEN LET l_diff = l_diff * -1 END IF
         IF l_diff2< 0 THEN LET l_diff2= l_diff2* -1 END IF
         LET l_msg[li_ac].l_errno =  cl_getmsg_parm('agl-00361',g_dlang,g_input.glapld ||'|'|| g_detail[l_ac].glapdocno ||'|'|| 
                                                                g_detail[l_ac].glap010 ||'|'|| l_glaq003 ||'|'|| l_diff ||'|'|| 
                                                                g_detail[l_ac].glap011 ||'|'|| l_glaq004 ||'|'|| l_diff2),
                                     cl_getmsg('aap-00227',g_dlang)
         LET li_ac = li_ac + 1
      END IF

      #STEP04.單頭借貸金額為0檢查
      IF g_detail[l_ac].glap010 = 0 AND g_detail[l_ac].glap011 = 0 THEN
         LET l_msg[li_ac].l_errno = cl_getmsg_parm('agl-00362',g_dlang,g_input.glapld ||'|'|| g_detail[l_ac].glapdocno ||'|'|| g_detail[l_ac].glap010 ||'|'|| g_detail[l_ac].glap011),
                                    cl_getmsg('agl-00364',g_dlang)
         LET li_ac = li_ac + 1
      END IF

      #STEP05.單身借貸總和為0的檢查


      #STEP06.應列印未列印的檢查
      IF l_glaa103 = 'N' AND (cl_null(l_glap012) OR l_glap012 = 0) THEN
         LET l_msg[li_ac].l_errno = cl_getmsg_parm('agl-00360',g_dlang,g_input.glapld ||'|'|| g_detail[l_ac].glapdocno),
                                    cl_getmsg('agl-00363',g_dlang)
         LET li_ac = li_ac + 1
      END IF

      #STEP07.流水號空白的檢查
      IF cl_null(l_glap009) THEN
         LET l_msg[li_ac].l_errno = cl_getmsg_parm('agl-00360',g_dlang,g_input.glapld ||'|'|| g_detail[l_ac].glapdocno),
                                    cl_getmsg('agl-00365',g_dlang)
         LET li_ac = li_ac + 1
      END IF

      #STEP08.統制科目檢查
      #STEP09.有效科目檢查
      #STEP10.核算項控制檢查
      #STEP11.核算項有效性檢查
      #STEP12.預算控制檢查
      #STEP13.單身交易幣別為空或NULL檢查
      #STEP14.單身交易幣別為本位幣時匯率是否為1檢查
      #STEP15.單身科目是否單一幣別管理檢查
      #STEP16.單身科目是否做數量核算檢查
      #STEP17.單身科目是否不為帳戶類科目檢查
      #STEP18.現金變動碼有效檢查
      #STEP19.現金變動碼金額和憑證現金科目金額一致性檢查
      EXECUTE aglq500_b_fill_glaq002 USING g_detail[l_ac].glapdocno INTO l_str
      CALL aglq500_glaq_chk(g_detail[l_ac].glapdocno,l_str,li_ac) RETURNING li_ac

      CALL aglq500_glbc_chk(g_detail[l_ac].glapdocno,li_ac) RETURNING li_ac
      
      #STEP20.细项立冲科目是否应立未立，应冲未冲，冲账金额是否等于单身金额
      CALL aglq500_glax_glay_chk(g_detail[l_ac].glapdocno,li_ac) RETURNING li_ac#170103-00019#19 add
      
      FOR li_ac = 1 TO l_msg.getLength()
         IF cl_null(l_msg[li_ac].l_errno) THEN
            EXIT FOR
         ELSE
            IF cl_null(g_detail[l_ac].error) THEN
               LET g_detail[l_ac].error = l_msg[li_ac].l_errno
            ELSE
               LET g_detail[l_ac].error = g_detail[l_ac].error,"\n",l_msg[li_ac].l_errno
            END IF
         END IF
      END FOR

      IF cl_null(g_detail[l_ac].error) THEN
         CONTINUE FOREACH
      END IF

      LET l_glap007_desc = ""
      SELECT gzcbl004 INTO l_glap007_desc FROM gzcbl_t WHERE gzcbl001 = '8007' AND gzcbl002 = g_detail[l_ac].glap007
         AND gzcbl003 = g_dlang
      IF NOT cl_null(l_glap007_desc) THEN
         LET l_glap007_desc = g_detail[l_ac].glap007,":",l_glap007_desc
      END IF

      LET l_glapstus_desc = ""
      SELECT gzcbl004 INTO l_glapstus_desc FROM gzcbl_t WHERE gzcbl001 = '13' AND gzcbl002 = g_detail[l_ac].glapstus
         AND gzcbl003 = g_dlang
      IF NOT cl_null(l_glapstus_desc) THEN
         LET l_glapstus_desc = g_detail[l_ac].glapstus,".",l_glapstus_desc
      END IF

      LET l_glapcrtid_desc = ""
      SELECT ooag011 INTO l_glapcrtid_desc FROM ooag_t WHERE ooagent = g_enterprise AND ooag001 = g_detail[l_ac].glapcrtid
      IF NOT cl_null(l_glapcrtid_desc) THEN
         LET l_glapcrtid_desc = g_detail[l_ac].glapcrtid,"(",l_glapcrtid_desc,")"
      END IF

      LET l_glapcnfid_desc = ""
      SELECT ooag011 INTO l_glapcnfid_desc FROM ooag_t WHERE ooagent = g_enterprise AND ooag001 = g_detail[l_ac].glapcnfid
      IF NOT cl_null(l_glapcnfid_desc) THEN
         LET l_glapcnfid_desc = g_detail[l_ac].glapcnfid,"(",l_glapcnfid_desc,")"
      END IF

      INSERT INTO aglq500_tmp01(glapent,glapld,                         #160727-00019#3  Mod  aglq500_prt_errno -->aglq500_tmp01
                               glapdocno,glapdocdt,glap007,
                               glapstus, glapcrtid,glapcnfid,
                               glap010,  glap011,  error)
                        VALUES(g_enterprise,g_input.glapld,
                               g_detail[l_ac].glapdocno,g_detail[l_ac].glapdocdt,l_glap007_desc,
                               l_glapstus_desc         ,l_glapcrtid_desc        ,l_glapcnfid_desc,
                               g_detail[l_ac].glap010  ,g_detail[l_ac].glap011  ,g_detail[l_ac].error)

      LET l_ac = l_ac + 1

   END FOREACH

   #end add-point
 
 
 
 
   #add-point:b_fill段資料填充(其他單身)
   
   #end add-point
 
   CALL g_detail.deleteElement(g_detail.getLength())
 
   #add-point:陣列長度調整
   
   #end add-point
 
   LET g_error_show = 0
 
   #單身總筆數顯示
   LET g_detail_cnt = g_detail.getLength()
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aglq500_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aglq500_detail_action_trans()
 
   CALL aglq500_b_fill2()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="aglq500.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq500_b_fill2()
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準
   DEFINE l_sql           STRING
   #end add-point
   #add-point:b_fill2段define-客製
   
   #end add-point
 
   LET li_ac = 1
 
   #單身組成
   #應用 qs11 樣板自動產生(Version:2)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
   #add-point:sql組成

   CALL g_detail2.clear()
   IF g_input.check3 = 'Y' THEN
      CALL aglq500_b_fill3()
   END IF

   CALL g_detail3.clear()
   IF g_input.check4 = 'Y' THEN
      CALL aglq500_b_fill4()
   END IF

   #end add-point
 
 
 
 
 
   #add-point:單身填充後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq500.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aglq500_detail_show(ps_page)
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define-標準
   
   #end add-point
   #add-point:show段define-客製
   
   #end add-point
 
   #add-point:detail_show段之前
   
   #end add-point
 
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference
 
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'3'",1) > 0 THEN
      #帶出公用欄位reference值page3
      
 
      #add-point:show段單身reference
      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq500.maintain_prog" >}
#+ 串查至主維護程式
PRIVATE FUNCTION aglq500_maintain_prog()
   DEFINE ls_js      STRING
   DEFINE la_param   RECORD
                     prog       STRING,
                     actionid   STRING,
                     background LIKE type_t.chr1,
                     param      DYNAMIC ARRAY OF STRING
                     END RECORD
   DEFINE ls_j       LIKE type_t.num5
   #add-point:maintain_prog段define-標準
   
   #end add-point
   #add-point:maintain_prog段define-客製
   
   #end add-point
 
 
   #add-point:maintain_prog段開始前
   
   #end add-point
 
   LET la_param.prog = ""
 
 
 
   IF NOT cl_null(la_param.prog) THEN
      LET ls_js = util.JSON.stringify(la_param)
      CALL cl_cmdrun_wait(ls_js)
   END IF
 
   #add-point:maintain_prog段結束前
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglq500.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aglq500_detail_action_trans()
 
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
 
{<section id="aglq500.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aglq500_detail_index_setting()
   DEFINE li_redirect     BOOLEAN
   DEFINE ldig_curr       ui.Dialog
 
 
   IF g_master_row_move = "Y" THEN
      LET g_detail_idx = 1
      LET li_redirect = TRUE
   ELSE
      IF g_curr_diag IS NOT NULL THEN
         CASE
            WHEN g_curr_diag.getCurrentRow("s_detail1") <= "0"
               LET g_detail_idx = 1
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
 
{<section id="aglq500.mask_functions" >}
 &include "erp/agl/aglq500_mask.4gl"
 
{</section>}
 
{<section id="aglq500.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 建立臨時表 for 報表
# Memo...........:
# Usage..........: CALL aglq500_ctr_tmp()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq500_ctr_tmp()

   #第一單身臨時表
   DROP TABLE aglq500_tmp01;           #160727-00019#3  Mod  aglq500_prt_errno -->aglq500_tmp01
   CREATE TEMP TABLE aglq500_tmp01(    #160727-00019#3  Mod  aglq500_prt_errno -->aglq500_tmp01
      glapent        LIKE glap_t.glapent,
      glapld         LIKE glap_t.glapld,
      glapdocno      LIKE glap_t.glapdocno, 
      glapdocdt      LIKE glap_t.glapdocdt, 
      glap007        LIKE type_t.chr200, 
      glapstus       LIKE type_t.chr200, 
      glapcrtid      LIKE type_t.chr200, 
      glapcnfid      LIKE type_t.chr200, 
      glap010        LIKE glap_t.glap010, 
      glap011        LIKE glap_t.glap011, 
      error          LIKE ooff_t.ooff013
    )

   #第二單身臨時表
   DROP TABLE aglq500_tmp02;                 #160727-00019#3  Mod  aglq500_prt_status -->aglq500_tmp02
   CREATE TEMP TABLE aglq500_tmp02(          #160727-00019#3  Mod  aglq500_prt_status -->aglq500_tmp02
      glapent        LIKE glap_t.glapent,
      glapld         LIKE glap_t.glapld,
      glapstus       LIKE type_t.chr200,
      glapdocno      LIKE type_t.chr20, 
      glapdocdt      LIKE type_t.dat, 
      glap007        LIKE type_t.chr200,
      glapcrtid      LIKE type_t.chr200,
      glapcnfid      LIKE type_t.chr200,
      glap010        LIKE glap_t.glap010,
      glap011        LIKE glap_t.glap011
    )

   #第三單身臨時表
   DROP TABLE aglq500_tmp03;           #160727-00019#3  Mod  aglq500_prt_lostno -->aglq500_tmp03
   CREATE TEMP TABLE aglq500_tmp03(    #160727-00019#3  Mod  aglq500_prt_lostno -->aglq500_tmp03
      oobxent        LIKE oobx_t.oobxent,
      oobx001        LIKE type_t.chr5, 
      oobxl003       LIKE type_t.chr500, 
      oobx005        LIKE type_t.chr1, 
      oobx006        LIKE type_t.chr200,
      oobx007        LIKE type_t.num5, 
      sdocno         LIKE type_t.chr20, 
      edocno         LIKE type_t.chr20, 
      count          LIKE type_t.num5
    )
END FUNCTION

################################################################################
# Descriptions...: 憑證單身檢查
# Memo...........:
# Usage..........: CALL aglq500_glaq_chk(p_str)
#                  RETURNING r_errno
# Input parameter: p_str          項次編號
# Return code....: r_errno        报错信息
# Date & Author..: 2015/09/17 By 01727
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq500_glaq_chk(p_glaqdocno,p_str,p_ac)
   DEFINE p_glaqdocno   LIKE glaq_t.glaqdocno
   DEFINE p_ac          LIKE type_t.num5
   DEFINE p_str         STRING
   DEFINE r_errno       LIKE type_t.chr1000
   DEFINE l_glaqseq     LIKE glaq_t.glaqseq
   DEFINE tok           base.stringtokenizer
   DEFINE l_glap007     LIKE glap_t.glap007
   DEFINE l_glaq002     LIKE glaq_t.glaq002
   DEFINE l_glaq005     LIKE glaq_t.glaq005
   DEFINE l_glaq006     LIKE glaq_t.glaq006
   DEFINE l_glaq007     LIKE glaq_t.glaq007
   DEFINE l_glaq008     LIKE glaq_t.glaq008
   DEFINE l_glaq009     LIKE glaq_t.glaq009
   DEFINE l_glacl004    LIKE glacl_t.glacl004
   DEFINE l_glac003     LIKE glac_t.glac003
   DEFINE l_glacstus    LIKE glac_t.glacstus
   DEFINE l_glad034     LIKE glad_t.glad034
   DEFINE l_glaa001     LIKE glaa_t.glaa001
   DEFINE l_dzebl003    LIKE dzebl_t.dzebl003
   DEFINE l_glapdocdt   LIKE glap_t.glapdocdt
   DEFINE l_glac006     LIKE glac_t.glac006
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_errno       LIKE type_t.chr100
   DEFINE l_glaq018     LIKE glaq_t.glaq018
   DEFINE l_glaq019     LIKE glaq_t.glaq019
   DEFINE l_glaq020     LIKE glaq_t.glaq020
   DEFINE l_glaq021     LIKE glaq_t.glaq021
   DEFINE l_glaq022     LIKE glaq_t.glaq022
   DEFINE l_glaq023     LIKE glaq_t.glaq023
   DEFINE l_glaq024     LIKE glaq_t.glaq024
   DEFINE l_glaq025     LIKE glaq_t.glaq025
   DEFINE l_glaq027     LIKE glaq_t.glaq027
   DEFINE l_glaq028     LIKE glaq_t.glaq028
   DEFINE l_glaq029     LIKE glaq_t.glaq029
   DEFINE l_glaq030     LIKE glaq_t.glaq030
   DEFINE l_glaq031     LIKE glaq_t.glaq031
   DEFINE l_glaq032     LIKE glaq_t.glaq032
   DEFINE l_glaq033     LIKE glaq_t.glaq033
   DEFINE l_glaq034     LIKE glaq_t.glaq034
   DEFINE l_glaq035     LIKE glaq_t.glaq035
   DEFINE l_glaq036     LIKE glaq_t.glaq036
   DEFINE l_glaq037     LIKE glaq_t.glaq037
   DEFINE l_glaq038     LIKE glaq_t.glaq038
   DEFINE l_glaq051     LIKE glaq_t.glaq051
   DEFINE l_glaq052     LIKE glaq_t.glaq052
   DEFINE l_glaq053     LIKE glaq_t.glaq053
   #固定核算项（agli030）
   DEFINE l_glad005       LIKE glad_t.glad005     #数量/金额管理否
   DEFINE l_glad007       LIKE glad_t.glad007     #部門管理否
   DEFINE l_glad008       LIKE glad_t.glad008     #利潤成本中心管理
   DEFINE l_glad009       LIKE glad_t.glad009     #區域管理
   DEFINE l_glad010       LIKE glad_t.glad010     #交易客商管理
   DEFINE l_glad027       LIKE glad_t.glad027     #账款客商管理
   DEFINE l_glad011       LIKE glad_t.glad011     #客群管理否
   DEFINE l_glad012       LIKE glad_t.glad012     #產品類別
   DEFINE l_glad013       LIKE glad_t.glad013     #人員
#  DEFINE l_glad014       LIKE glad_t.glad014     #预算管理否
   DEFINE l_glad015       LIKE glad_t.glad015     #专案管理否
   DEFINE l_glad016       LIKE glad_t.glad016     #wbs管理
   DEFINE l_glad031       LIKE glad_t.glad031     #經營方式管理否
   DEFINE l_glad032       LIKE glad_t.glad032     #渠道管理否
   DEFINE l_glad033       LIKE glad_t.glad033     #品牌管理否
   #是否做自由科目核算项管理
   DEFINE l_glad017       LIKE glad_t.glad017
   DEFINE l_glad0171      LIKE glad_t.glad0171 
   DEFINE l_glad0172      LIKE glad_t.glad0172 
   DEFINE l_glad018       LIKE glad_t.glad018
   DEFINE l_glad0181      LIKE glad_t.glad0181
   DEFINE l_glad0182      LIKE glad_t.glad0182
   DEFINE l_glad019       LIKE glad_t.glad019
   DEFINE l_glad0191      LIKE glad_t.glad0191
   DEFINE l_glad0192      LIKE glad_t.glad0192
   DEFINE l_glad020       LIKE glad_t.glad020
   DEFINE l_glad0201      LIKE glad_t.glad0201
   DEFINE l_glad0202      LIKE glad_t.glad0202
   DEFINE l_glad021       LIKE glad_t.glad021
   DEFINE l_glad0211      LIKE glad_t.glad0211
   DEFINE l_glad0212      LIKE glad_t.glad0212
   DEFINE l_glad022       LIKE glad_t.glad022
   DEFINE l_glad0221      LIKE glad_t.glad0221
   DEFINE l_glad0222      LIKE glad_t.glad0222
   DEFINE l_glad023       LIKE glad_t.glad023
   DEFINE l_glad0231      LIKE glad_t.glad0231
   DEFINE l_glad0232      LIKE glad_t.glad0232
   DEFINE l_glad024       LIKE glad_t.glad024
   DEFINE l_glad0241      LIKE glad_t.glad0241
   DEFINE l_glad0242      LIKE glad_t.glad0242
   DEFINE l_glad025       LIKE glad_t.glad025
   DEFINE l_glad0251      LIKE glad_t.glad0251
   DEFINE l_glad0252      LIKE glad_t.glad0252
   DEFINE l_glad026       LIKE glad_t.glad026
   DEFINE l_glad0261      LIKE glad_t.glad0261
   DEFINE l_glad0262      LIKE glad_t.glad0262

   IF g_input.check1 = 'N' THEN RETURN p_ac END IF

   #STEP08.統制科目檢查
   #STEP09.有效科目檢查
   #STEP10.核算項控制檢查
   #STEP11.核算項有效性檢查
   #STEP12.預算控制檢查
   #STEP13.單身交易幣別為空或NULL檢查
   #STEP14.單身交易幣別為本位幣時匯率是否為1檢查
   #STEP15.單身科目是否單一幣別管理檢查
   #STEP16.單身科目是否做數量核算檢查
   #STEP17.單身科目是否不為帳戶類科目檢查
   #STEP18.現金變動碼有效檢查
   #STEP19.現金變動碼金額和憑證現金科目金額一致性檢查

   SELECT glapdocdt INTO l_glapdocdt FROM glap_t WHERE glapent = g_enterprise
      AND glapdocno = p_glaqdocno
      AND glapld = g_input.glapld

   LET tok = base.StringTokenizer.create(p_str,",")
   WHILE tok.hasMoreTokens()
      LET l_glaqseq = tok.nextToken()
      SELECT glaq002,glaq005,glaq006,glaq007,glaq008,glaq009,glaq018,
             glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,glaq024,glaq025,glaq027,glaq028,glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,glaq036,glaq037,glaq038,
             glaq051,glaq052,glaq053
        INTO l_glaq002,l_glaq005,l_glaq006,l_glaq007,l_glaq008,l_glaq009,l_glaq018,
             l_glaq018,l_glaq019,l_glaq020,l_glaq021,l_glaq022,l_glaq023,l_glaq024,l_glaq025,l_glaq027,l_glaq028,l_glaq029,l_glaq030,l_glaq031,l_glaq032,l_glaq033,l_glaq034,l_glaq035,l_glaq036,l_glaq037,l_glaq038,
             l_glaq051,l_glaq052,l_glaq053
             
        FROM glaq_t WHERE glaqent = g_enterprise AND glaqdocno = p_glaqdocno
         AND glaqld = g_input.glapld             AND glaqseq = l_glaqseq

      SELECT glac003,glacstus INTO l_glac003,l_glacstus FROM glac_t WHERE glacent = g_enterprise
         AND glac001 = g_glaa004
         AND glac002 = l_glaq002

      SELECT glacl004 INTO l_glacl004 FROM glacl_t WHERE glaclent = g_enterprise
         AND glacl001 = g_glaa004
         AND glacl002 = l_glaq002
         AND glacl003 = g_dlang
      LET l_glacl004 = l_glaq002,"(",l_glacl004,")"

      #STEP08.統制科目檢查
      IF l_glac003 = '1' THEN
         LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00366',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| l_glacl004),
                                    cl_getmsg('agl-00013',g_dlang)
         LET p_ac = p_ac + 1
      END IF

      #STEP09.有效科目檢查(存在性)
      IF cl_null(l_glacstus) THEN
         LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00366',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| l_glacl004),
                                    cl_getmsg('agl-00011',g_dlang)
         LET p_ac = p_ac + 1
      END IF

      #STEP09.有效科目檢查(有效性)
      IF l_glacstus = 'N' THEN
         LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00366',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| l_glacl004),
                                    cl_getmsg('sub-01302',g_dlang)#cl_getmsg('agl-00012',g_dlang) # 160318-00005#17 mod  
         LET p_ac = p_ac + 1
      END IF

      #STEP13.單身交易幣別為空或NULL檢查
      IF cl_null(l_glaq005) THEN
         LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00366',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| l_glacl004),
                                    cl_getmsg('agl-00367',g_dlang)
         LET p_ac = p_ac + 1
      END IF

      #STEP14.單身交易幣別為本位幣時匯率是否為1檢查
      IF NOT cl_null(l_glaq005) AND l_glaq005 = g_glaa001 AND l_glaq006 <> 1 THEN
         LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00368',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                           l_glacl004 ||'|'|| l_glaq005   ||'|'|| l_glaq006),
                                    cl_getmsg('agl-00327',g_dlang)
         LET p_ac = p_ac + 1
      END IF

      #STEP15.單身科目是否單一幣別管理檢查
      SELECT glad034 INTO l_glad034 FROM glad_t 
       WHERE gladent=g_enterprise AND gladld=g_input.glapld AND glad001=l_glaq002
      IF l_glad034 = 'N' AND l_glaq005 <> g_glaa001 THEN
         LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00369',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| l_glacl004 ||'|'|| l_glaq005),
                                    cl_getmsg('agl-00316',g_dlang)
         LET p_ac = p_ac + 1
      END IF

      #STEP10.核算項控制檢查 & STEP11.核算項有效性檢查
      #依據帳別，科目編號，判斷該科目是否启用
      #部門管理， 利潤成本中心管理，區域管理，交易客商管理，客群管理，產品類別，人員，預算，專案，wbs管理，账款客商管理，自由核算项1~10
      #1.清空核算项管理值
      LET l_glad007 = ''  LET l_glad008 = ''  LET l_glad009 = ''  LET l_glad010 = ''  LET l_glad027 = ''   LET l_glad011 = ''
      LET l_glad012 = ''  LET l_glad013 = ''  LET l_glad015 = ''  LET l_glad016 = ''  LET l_glad031 = ''   LET l_glad032 = ''  LET l_glad033 = ''
      LET l_glad017 = ''  LET l_glad0171 =''  LET l_glad0172 = '' LET l_glad018 = ''  LET l_glad0181 = ''  LET l_glad0182 = ''
      LET l_glad019 = ''  LET l_glad0191 =''  LET l_glad0192 = '' LET l_glad020 = ''  LET l_glad0201 = ''  LET l_glad0202 = ''
      LET l_glad021 = ''  LET l_glad0211 =''  LET l_glad0212 = '' LET l_glad022 = ''  LET l_glad0221 = ''  LET l_glad0222 = ''
      LET l_glad023 = ''  LET l_glad0231 =''  LET l_glad0232 = '' LET l_glad024 = ''  LET l_glad0241 = ''  LET l_glad0242 = ''
      LET l_glad025 = ''  LET l_glad0251 =''  LET l_glad0252 = '' LET l_glad026 = ''  LET l_glad0261 = ''  LET l_glad0262 = ''
      LET l_glad005 = ''
      #2.重新依账套，科目抓取核算项管理值(细部核算项)
      CALL s_voucher_fix_acc_open_chk(g_input.glapld,l_glaq002)
      RETURNING l_glad007,l_glad008,l_glad009,l_glad010,l_glad027,l_glad011,l_glad012,l_glad013,l_glad015,l_glad016,l_glad031,l_glad032,l_glad033

      #自由核算项
      SELECT glad005,glad017,glad0171,glad0172,glad018,glad0181,glad0182,glad019,glad0191,glad0192,
             glad020,glad0201,glad0202,glad021,glad0211,glad0212,glad022,glad0221,glad0222,
             glad023,glad0231,glad0232,glad024,glad0241,glad0242,glad025,glad0251,glad0252,
             glad026,glad0261,glad0262
        INTO l_glad005,l_glad017,l_glad0171,l_glad0172,l_glad018,l_glad0181,l_glad0182,l_glad019,l_glad0191,l_glad0192,
             l_glad020,l_glad0201,l_glad0202,l_glad021,l_glad0211,l_glad0212,l_glad022,l_glad0221,l_glad0222,
             l_glad023,l_glad0231,l_glad0232,l_glad024,l_glad0241,l_glad0242,l_glad025,l_glad0251,l_glad0252,
             l_glad026,l_glad0261,l_glad0262
        FROM glad_t
       WHERE gladent = g_enterprise
         AND gladld = g_input.glapld
         AND glad001 =l_glaq002

      #======================================
      #固定核算项检查
      #如果启用改固定核算项勾选，则对该核算项的值进行检查
      #======================================
      #該科目做部門管理時，部門不可空白
      IF l_glad007 = 'Y' THEN
         SELECT dzebl003 INTO l_dzebl003 FROM dzebl_t WHERE dzebl001 = 'glaq018' AND dzebl002 = g_dlang
         IF cl_null(l_glaq018) THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003),
                                      cl_getmsg('agl-00043',g_dlang)
            LET p_ac = p_ac + 1
         ELSE
            #部门检查
            LET g_errno = " "
            CALL s_department_chk(l_glaq018,l_glapdocdt) RETURNING l_success
            IF l_success = FALSE THEN
               LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00371',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003 ||'|'|| l_glaq018),
                                         cl_getmsg(g_errno,g_dlang)
            LET p_ac = p_ac + 1
            END IF
         END IF
      ELSE
         IF l_glaq018 <> ' ' THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| l_glacl004),
                                      cl_getmsg('agl-00357',g_dlang)
            LET p_ac = p_ac + 1
         END IF
      END IF

      #該科目做利潤成本管理時，利潤成本不可空白
      IF l_glad008 = 'Y'  THEN
         SELECT dzebl003 INTO l_dzebl003 FROM dzebl_t WHERE dzebl001 = 'glaq019' AND dzebl002 = g_dlang
         IF cl_null(l_glaq019) THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003),
                                      cl_getmsg('agl-00044',g_dlang)
               LET p_ac = p_ac + 1
         ELSE
            #利润成本中心检查
            LET g_errno = " "
            CALL s_voucher_glaq019_chk(l_glaq019,l_glapdocdt)
            IF NOT cl_null(g_errno) THEN
               LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00371',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003 ||'|'|| l_glaq019),
                                         cl_getmsg(g_errno,g_dlang)
               LET p_ac = p_ac + 1
            END IF
         END IF
      ELSE
         IF l_glaq019 <> ' ' THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| l_glacl004),
                                      cl_getmsg('agl-00357',g_dlang)
           LET p_ac = p_ac + 1
         END IF
      END IF

      #該科目做區域管理時，區域不可空白
      IF l_glad009 = 'Y'  THEN
         SELECT dzebl003 INTO l_dzebl003 FROM dzebl_t WHERE dzebl001 = 'glaq020' AND dzebl002 = g_dlang
         IF cl_null(l_glaq020) THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003),
                                      cl_getmsg('agl-00045',g_dlang)
               LET p_ac = p_ac + 1
         ELSE
            #区域检查
            CALL s_azzi650_chk_exist('287',l_glaq020) RETURNING l_success
            IF NOT l_success THEN
               LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00371',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003 ||'|'|| l_glaq020),
                                         cl_getmsg_parm(g_errparam.code,g_dlang,g_errparam.replace[1])
               LET p_ac = p_ac + 1
            END IF
         END IF
      ELSE
         IF l_glaq020 <> ' ' THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| l_glacl004),
                                      cl_getmsg('agl-00357',g_dlang)
           LET p_ac = p_ac + 1
         END IF
      END IF

      #該科目做交易客商管理時，客商不可空白
      IF l_glad010 = 'Y'  THEN
         SELECT dzebl003 INTO l_dzebl003 FROM dzebl_t WHERE dzebl001 = 'glaq021' AND dzebl002 = g_dlang
         IF cl_null(l_glaq021) THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003),
                                      cl_getmsg('agl-00046',g_dlang)
               LET p_ac = p_ac + 1
         ELSE
            #客商检查
            CALL s_voucher_glaq021_chk(l_glaq021)
            IF NOT cl_null(g_errno) THEN
               LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00371',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003 ||'|'|| l_glaq019),
                                         cl_getmsg(g_errno,g_dlang)
               LET p_ac = p_ac + 1
            END IF
         END IF
      ELSE
         IF l_glaq021 <> ' ' THEN
           LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| l_glacl004),
                                     cl_getmsg('agl-00357',g_dlang)
          LET p_ac = p_ac + 1
         END IF
      END IF

      #該科目做账款客商管理時，客商不可空白
      IF l_glad027 = 'Y'  THEN
         SELECT dzebl003 INTO l_dzebl003 FROM dzebl_t WHERE dzebl001 = 'glaq022' AND dzebl002 = g_dlang
         IF cl_null(l_glaq022) THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003),
                                      cl_getmsg('axr-00215',g_dlang)
            LET p_ac = p_ac + 1
         ELSE
            #客商检查
            CALL s_voucher_glaq021_chk(l_glaq022)
            IF NOT cl_null(g_errno) THEN
               LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00371',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003 ||'|'|| l_glaq019),
                                         cl_getmsg(g_errno,g_dlang)
               LET p_ac = p_ac + 1
            END IF
         END IF
      ELSE
         IF l_glaq022 <> ' ' THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| l_glacl004),
                                      cl_getmsg('agl-00357',g_dlang)
           LET p_ac = p_ac + 1
         END IF
      END IF

      #該科目做客群管理時，客群不可空白
      IF l_glad011 = 'Y'  THEN
         SELECT dzebl003 INTO l_dzebl003 FROM dzebl_t WHERE dzebl001 = 'glaq023' AND dzebl002 = g_dlang
         IF cl_null(l_glaq023) THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003),
                                      cl_getmsg('agl-00047',g_dlang)
            LET p_ac = p_ac + 1
         ELSE
           ##客群检查
            CALL s_azzi650_chk_exist('281',l_glaq023) RETURNING l_success
            IF NOT l_success THEN
               LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00371',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003 ||'|'|| l_glaq019),
                                         cl_getmsg_parm(g_errparam.code,g_dlang,g_errparam.replace[1])
               LET p_ac = p_ac + 1
            END IF
         END IF
      ELSE
         IF l_glaq023 <> ' ' THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| l_glacl004),
                                      cl_getmsg('agl-00357',g_dlang)
            LET p_ac = p_ac + 1
         END IF
      END IF

      #該科目做產品分類管理時，不可空白
      IF l_glad012 = 'Y'  THEN
         SELECT dzebl003 INTO l_dzebl003 FROM dzebl_t WHERE dzebl001 = 'glaq024' AND dzebl002 = g_dlang
         IF cl_null(l_glaq024) THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003),
                                      cl_getmsg('agl-00068',g_dlang)
            LET p_ac = p_ac + 1
         ELSE
            #产品分类检查
            CALL s_voucher_glaq024_chk(l_glaq024)
            IF NOT cl_null(g_errno) THEN
               LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00371',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003 ||'|'|| l_glaq019),
                                         cl_getmsg(g_errno,g_dlang)
               LET p_ac = p_ac + 1
            END IF
         END IF
      ELSE
         IF l_glaq024 <> ' ' THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| l_glacl004),
                                      cl_getmsg('agl-00357',g_dlang)
           LET p_ac = p_ac + 1
         END IF
      END IF

      #該科目做經營方式管理時，不可空白
      IF l_glad031 = 'Y'  THEN
         SELECT dzebl003 INTO l_dzebl003 FROM dzebl_t WHERE dzebl001 = 'glaq051' AND dzebl002 = g_dlang
         IF cl_null(l_glaq051) THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003),
                                      cl_getmsg('agl-00286',g_dlang)
            LET p_ac = p_ac + 1
         ELSE
            #經營方式检查
            CALL s_voucher_glaq051_chk(l_glaq051)
            IF NOT cl_null(g_errno) THEN
               LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00371',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003 ||'|'|| l_glaq019),
                                         cl_getmsg(g_errno,g_dlang)
               LET p_ac = p_ac + 1
            END IF
         END IF
      ELSE
         IF l_glaq051 <> ' ' THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| l_glacl004),
                                      cl_getmsg('agl-00357',g_dlang)
           LET p_ac = p_ac + 1
         END IF
      END IF

      #該科目做渠道管理時，不可空白
      IF l_glad032 = 'Y'  THEN
         SELECT dzebl003 INTO l_dzebl003 FROM dzebl_t WHERE dzebl001 = 'glaq052' AND dzebl002 = g_dlang
         IF cl_null(l_glaq052) THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003),
                                      cl_getmsg('agl-00287',g_dlang)
            LET p_ac = p_ac + 1
         ELSE
            #渠道检查
            CALL s_voucher_glaq052_chk(l_glaq052)
            IF NOT cl_null(g_errno) THEN
               LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00371',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003 ||'|'|| l_glaq019),
                                         cl_getmsg(g_errno,g_dlang)
               LET p_ac = p_ac + 1
            END IF
        END IF
      ELSE
         IF l_glaq052 <> ' ' THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| l_glacl004),
                                      cl_getmsg('agl-00357',g_dlang)
           LET p_ac = p_ac + 1
         END IF
      END IF

      #該科目做品牌管理時，不可空白
      IF l_glad033 = 'Y'  THEN
         SELECT dzebl003 INTO l_dzebl003 FROM dzebl_t WHERE dzebl001 = 'glaq053' AND dzebl002 = g_dlang
         IF cl_null(l_glaq053) THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003),
                                      cl_getmsg('agl-00288',g_dlang)
            LET p_ac = p_ac + 1
         ELSE
            #品牌检查
            CALL s_azzi650_chk_exist('2002',l_glaq053) RETURNING l_success
            IF NOT l_success THEN
               LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00371',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003 ||'|'|| l_glaq019),
                                         cl_getmsg_parm(g_errparam.code,g_dlang,g_errparam.replace[1])
               LET p_ac = p_ac + 1
            END IF
         END IF
      ELSE
         IF l_glaq053 <> ' ' THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| l_glacl004),
                                      cl_getmsg('agl-00357',g_dlang)
           LET p_ac = p_ac + 1
         END IF
      END IF

      #該科目做人員管理時，不可空白
      IF l_glad013 = 'Y'  THEN
         SELECT dzebl003 INTO l_dzebl003 FROM dzebl_t WHERE dzebl001 = 'glaq025' AND dzebl002 = g_dlang
         IF cl_null(l_glaq025) THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003),
                                      cl_getmsg('agl-00069',g_dlang)
            LET p_ac = p_ac + 1
         ELSE
            #人员检查
            CALL s_employee_chk(l_glaq025) RETURNING l_success
            IF NOT l_success THEN
               LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00371',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003 ||'|'|| l_glaq019),
                                         cl_getmsg(g_errno,g_dlang)
               LET p_ac = p_ac + 1
            END IF
         END IF
      ELSE
         IF l_glaq025 <> ' ' THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| l_glacl004),
                                      cl_getmsg('agl-00357',g_dlang)
            LET p_ac = p_ac + 1
         END IF
      END IF

      #該科目做專案管理時，不可空白
      IF l_glad015 = 'Y'  THEN
        SELECT dzebl003 INTO l_dzebl003 FROM dzebl_t WHERE dzebl001 = 'glaq027' AND dzebl002 = g_dlang
         IF cl_null(l_glaq027) THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003),
                                      cl_getmsg('agl-00071',g_dlang)
            LET p_ac = p_ac + 1
         ELSE
            CALL s_aap_project_chk(l_glaq027) RETURNING l_success,g_errno
            IF NOT l_success THEN
               LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00371',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003 ||'|'|| l_glaq019),
                                         cl_getmsg(g_errno,g_dlang)
               LET p_ac = p_ac + 1
            END IF
         END IF
      ELSE
         IF l_glaq027 <> ' ' THEN
           LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| l_glacl004),
                                     cl_getmsg('agl-00357',g_dlang)
          LET p_ac = p_ac + 1
         END IF
      END IF

      #該科目做WBS管理時，不可空白
      IF l_glad016 = 'Y'  THEN
         SELECT dzebl003 INTO l_dzebl003 FROM dzebl_t WHERE dzebl001 = 'glaq028' AND dzebl002 = g_dlang
         IF cl_null(l_glaq028) THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003),
                                      cl_getmsg('agl-00072',g_dlang)
            LET p_ac = p_ac + 1
         ELSE
            CALL s_voucher_glaq028_chk(l_glaq027,l_glaq028)
            IF NOT cl_null(g_errno) THEN
               LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00371',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003 ||'|'|| l_glaq019),
                                         cl_getmsg(g_errno,g_dlang)
               LET p_ac = p_ac + 1
            END IF
         END IF
      ELSE
         IF l_glaq028 <> ' ' THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| l_glacl004),
                                      cl_getmsg('agl-00357',g_dlang)
            LET p_ac = p_ac + 1
         END IF
      END IF
      #===================================================
      #自由核算项检查
      #如果启用该核算项勾选，并且控制方式不为1：允许空白，则对核算项的值进行检查
      #===================================================
      #核算项一
      IF l_glad017 = 'Y' THEN
         SELECT dzebl003 INTO l_dzebl003 FROM dzebl_t WHERE dzebl001 = 'glaq029' AND dzebl002 = g_dlang
         IF l_glad0172<>'1' THEN
            IF cl_null(l_glaq029) THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003),
                                      cl_getmsg('agl-00074',g_dlang)
               LET p_ac = p_ac + 1
            END IF
         END IF
         IF NOT cl_null(l_glaq029) THEN
            CALL s_voucher_free_account_chk(l_glad0171,l_glaq029,l_glad0172) RETURNING l_errno
            IF NOT cl_null(l_errno) THEN
               LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00371',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003 ||'|'|| l_glaq019),
                                         cl_getmsg(g_errno,g_dlang)
               LET p_ac = p_ac + 1
            END IF
          END IF
      ELSE
         IF l_glaq029 <> ' ' THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| l_glacl004),
                                      cl_getmsg('agl-00357',g_dlang)
           LET p_ac = p_ac + 1
         END IF
      END IF
      #核算项二
      IF l_glad018 = 'Y'  THEN
         SELECT dzebl003 INTO l_dzebl003 FROM dzebl_t WHERE dzebl001 = 'glaq030' AND dzebl002 = g_dlang
         IF l_glad0182 <>'1' THEN
            IF cl_null(l_glaq030) THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003),
                                      cl_getmsg('agl-00075',g_dlang)
               LET p_ac = p_ac + 1
            END IF
         END IF
         IF NOT cl_null(l_glaq030) THEN
            CALL s_voucher_free_account_chk(l_glad0181,l_glaq030,l_glad0182) RETURNING l_errno
            IF NOT cl_null(l_errno) THEN
               LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00371',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003 ||'|'|| l_glaq019),
                                         cl_getmsg(g_errno,g_dlang)
               LET p_ac = p_ac + 1
            END IF
         END IF
      ELSE
         IF l_glaq030 <> ' ' THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| l_glacl004),
                                      cl_getmsg('agl-00357',g_dlang)
           LET p_ac = p_ac + 1
         END IF
      END IF
      #核算项三
      IF l_glad019 = 'Y'  THEN
         SELECT dzebl003 INTO l_dzebl003 FROM dzebl_t WHERE dzebl001 = 'glaq031' AND dzebl002 = g_dlang
         IF l_glad0192 <>'1'  THEN
            IF cl_null(l_glaq031) THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003),
                                      cl_getmsg('agl-00076',g_dlang)
               LET p_ac = p_ac + 1
            END IF
         END IF
         IF NOT cl_null(l_glaq031) THEN
            CALL s_voucher_free_account_chk(l_glad0191,l_glaq031,l_glad0192) RETURNING l_errno
            IF NOT cl_null(l_errno) THEN
               LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00371',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003 ||'|'|| l_glaq019),
                                         cl_getmsg(g_errno,g_dlang)
               LET p_ac = p_ac + 1
            END IF
         END IF
      ELSE
         IF l_glaq031 <> ' ' THEN
           LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| l_glacl004),
                                     cl_getmsg('agl-00357',g_dlang)
          LET p_ac = p_ac + 1
         END IF
      END IF
      #核算项四
      IF l_glad020 = 'Y' THEN
        SELECT dzebl003 INTO l_dzebl003 FROM dzebl_t WHERE dzebl001 = 'glaq032' AND dzebl002 = g_dlang
         IF l_glad0202 <>'1' THEN
            IF cl_null(l_glaq032) THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003),
                                      cl_getmsg('agl-00077',g_dlang)
               LET p_ac = p_ac + 1
            END IF
         END IF
         IF NOT cl_null(l_glaq032) THEN
            CALL s_voucher_free_account_chk(l_glad0201,l_glaq032,l_glad0202) RETURNING l_errno
            IF NOT cl_null(l_errno) THEN
               LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00371',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003 ||'|'|| l_glaq019),
                                         cl_getmsg(g_errno,g_dlang)
               LET p_ac = p_ac + 1
            END IF
         END IF
      ELSE
         IF l_glaq032 <> ' ' THEN
           LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| l_glacl004),
                                     cl_getmsg('agl-00357',g_dlang)
          LET p_ac = p_ac + 1
         END IF
      END IF
      #核算项五
      IF l_glad021 = 'Y'  THEN
        SELECT dzebl003 INTO l_dzebl003 FROM dzebl_t WHERE dzebl001 = 'glaq033' AND dzebl002 = g_dlang
         IF l_glad0212 <>'1' THEN
            IF cl_null(l_glaq033) THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003),
                                      cl_getmsg('agl-00078',g_dlang)
            LET p_ac = p_ac + 1
            END IF
         END IF
         IF NOT cl_null(l_glaq033) THEN
            CALL s_voucher_free_account_chk(l_glad0211,l_glaq033,l_glad0212) RETURNING l_errno
            IF NOT cl_null(l_errno) THEN
               LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00371',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003 ||'|'|| l_glaq019),
                                         cl_getmsg(g_errno,g_dlang)
               LET p_ac = p_ac + 1
            END IF
         END IF
      ELSE
         IF l_glaq033 <> ' ' THEN
           LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| l_glacl004),
                                     cl_getmsg('agl-00357',g_dlang)
          LET p_ac = p_ac + 1
         END IF
      END IF
       #核算项六
      IF l_glad022 = 'Y'  THEN
        SELECT dzebl003 INTO l_dzebl003 FROM dzebl_t WHERE dzebl001 = 'glaq034' AND dzebl002 = g_dlang
         IF l_glad0222 <>'1' THEN
            IF cl_null(l_glaq034) THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003),
                                      cl_getmsg('agl-00079',g_dlang)
            LET p_ac = p_ac + 1
            END IF
         END IF
         IF NOT cl_null(l_glaq034) THEN
            CALL s_voucher_free_account_chk(l_glad0221,l_glaq034,l_glad0222) RETURNING l_errno
            IF NOT cl_null(l_errno) THEN
               LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00371',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003 ||'|'|| l_glaq019),
                                         cl_getmsg(g_errno,g_dlang)
               LET p_ac = p_ac + 1
            END IF
         END IF
      ELSE
         IF l_glaq034 <> ' ' THEN
           LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| l_glacl004),
                                     cl_getmsg('agl-00357',g_dlang)
          LET p_ac = p_ac + 1
         END IF
      END IF
      #核算项七
      IF l_glad023 = 'Y'  THEN
        SELECT dzebl003 INTO l_dzebl003 FROM dzebl_t WHERE dzebl001 = 'glaq035' AND dzebl002 = g_dlang
         IF l_glad0232 <>'1' THEN
            IF cl_null(l_glaq035) THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003),
                                      cl_getmsg('agl-00080',g_dlang)
            LET p_ac = p_ac + 1
            END IF
         END IF
         IF NOT cl_null(l_glaq035) THEN
            CALL s_voucher_free_account_chk(l_glad0231,l_glaq035,l_glad0232) RETURNING l_errno
            IF NOT cl_null(l_errno) THEN
               LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00371',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003 ||'|'|| l_glaq019),
                                         cl_getmsg(g_errno,g_dlang)
               LET p_ac = p_ac + 1
            END IF
         END IF
      ELSE
         IF l_glaq035 <> ' ' THEN
           LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| l_glacl004),
                                     cl_getmsg('agl-00357',g_dlang)
          LET p_ac = p_ac + 1
         END IF
      END IF
      #核算项八
      IF l_glad024 = 'Y'  THEN
        SELECT dzebl003 INTO l_dzebl003 FROM dzebl_t WHERE dzebl001 = 'glaq036' AND dzebl002 = g_dlang
         IF l_glad0242 <>'1' THEN
            IF cl_null(l_glaq036) THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003),
                                      cl_getmsg('agl-00081',g_dlang)
            LET p_ac = p_ac + 1
            END IF
         END IF
         IF NOT cl_null(l_glaq036) THEN
            CALL s_voucher_free_account_chk(l_glad0241,l_glaq036,l_glad0242) RETURNING l_errno
            IF NOT cl_null(l_errno) THEN
               LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00371',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003 ||'|'|| l_glaq019),
                                         cl_getmsg(g_errno,g_dlang)
               LET p_ac = p_ac + 1
            END IF
         END IF
      ELSE
         IF l_glaq036 <> ' ' THEN
           LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| l_glacl004),
                                     cl_getmsg('agl-00357',g_dlang)
          LET p_ac = p_ac + 1
         END IF
      END IF
      #核算项九
      IF l_glad025 = 'Y'  THEN
        SELECT dzebl003 INTO l_dzebl003 FROM dzebl_t WHERE dzebl001 = 'glaq037' AND dzebl002 = g_dlang
         IF l_glad0252 <>'1' THEN
            IF cl_null(l_glaq037) THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003),
                                      cl_getmsg('agl-00082',g_dlang)
            LET p_ac = p_ac + 1
            END IF
         END IF
         IF NOT cl_null(l_glaq037) THEN
            CALL s_voucher_free_account_chk(l_glad0251,l_glaq037,l_glad0252) RETURNING l_errno
            IF NOT cl_null(l_errno) THEN
               LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00371',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003 ||'|'|| l_glaq019),
                                         cl_getmsg(g_errno,g_dlang)
               LET p_ac = p_ac + 1
            END IF
         END IF
      ELSE
         IF l_glaq037 <> ' ' THEN
           LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| l_glacl004),
                                     cl_getmsg('agl-00357',g_dlang)
          LET p_ac = p_ac + 1
         END IF
      END IF
      #核算项十
      IF l_glad026 = 'Y'  THEN
        SELECT dzebl003 INTO l_dzebl003 FROM dzebl_t WHERE dzebl001 = 'glaq038' AND dzebl002 = g_dlang
         IF l_glad0262 <>'1' THEN
            IF cl_null(l_glaq038) THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003),
                                      cl_getmsg('agl-00083',g_dlang)
            LET p_ac = p_ac + 1
            END IF
         END IF
         IF NOT cl_null(l_glaq038) THEN
            CALL s_voucher_free_account_chk(l_glad0261,l_glaq038,l_glad0262) RETURNING l_errno
            IF NOT cl_null(l_errno) THEN
               LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00371',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| 
                                                                 l_glacl004 ||'|'|| l_dzebl003 ||'|'|| l_glaq019),
                                         cl_getmsg(g_errno,g_dlang)
               LET p_ac = p_ac + 1
            END IF
         END IF
      ELSE
         IF l_glaq038 <> ' ' THEN
           LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00370',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| l_glacl004),
                                     cl_getmsg('agl-00357',g_dlang)
          LET p_ac = p_ac + 1
         END IF
      END IF

      #STEP16.單身科目是否做數量核算檢查
      IF l_glad005 = 'Y' THEN
         IF cl_null(l_glaq007) OR cl_null(l_glaq008) OR cl_null(l_glaq009) OR l_glaq008 = 0 OR l_glaq009 = 0 THEN
              LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00369',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| l_glacl004 ||'|'|| l_glaq005),
                                        cl_getmsg('agl-00385',g_dlang)
              LET p_ac = p_ac + 1
         END IF
      END IF

      #STEP17.單身科目是否不為帳戶類科目檢查
      SELECT glap007 INTO l_glap007 FROM glap_t WHERE glapent = g_enterprise
         AND glapdocno = p_glaqdocno
         AND glapld = g_input.glapld
      IF l_glap007 <> 'CE' AND l_glap007 <> 'YE' THEN
         SELECT glac006 INTO l_glac006 FROM glac_t
          WHERE glacent = g_enterprise
            AND glac001 = g_glaa004
            AND glac002 = l_glaq002
         IF l_glac006 <> '1' THEN
           LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00366',g_dlang,g_input.glapld ||'|'|| p_glaqdocno ||'|'|| l_glaqseq ||'|'|| l_glacl004),
                                     cl_getmsg('agl-00030',g_dlang)
           LET p_ac = p_ac + 1
         END IF
      END IF

   END WHILE


   RETURN p_ac


END FUNCTION

################################################################################
# Descriptions...: 現金變動碼檢核
# Memo...........:
# Usage..........: CALL aglq500_glbc_chk()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq500_glbc_chk(p_glapdocno,p_ac)
   DEFINE p_glapdocno      LIKE glaq_t.glaqdocno
   DEFINE p_ac             LIKE type_t.num5
   DEFINE l_sql            STRING
   DEFINE l_cnt            LIKE type_t.num5
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_glap002        LIKE glap_t.glap002
   DEFINE l_glaq002        LIKE glaq_t.glaq002
   DEFINE l_glap004        LIKE glap_t.glap004
   DEFINE l_glbcseq        LIKE glbc_t.glbcseq
   DEFINE l_glbcseq1       LIKE glbc_t.glbcseq1
   DEFINE l_glbc004        LIKE glbc_t.glbc004
   DEFINE l_nmaistus       LIKE nmai_t.nmaistus
   DEFINE l_amt1           LIKE glaq_t.glaq003
   DEFINE l_amt2           LIKE glaq_t.glaq003
   DEFINE l_amt3           LIKE glaq_t.glaq003
   DEFINE l_sum1           LIKE glaq_t.glaq003
   DEFINE l_sum2           LIKE glaq_t.glaq003
   DEFINE l_sum3           LIKE glaq_t.glaq003

   #檢查現金變動碼設置是否正確
   LET l_amt1=0   LET l_amt2=0   LET l_amt3=0  
   LET l_sum1=0   LET l_sum2=0   LET l_sum3=0  
   SELECT SUM(glaq003+glaq004),SUM(glaq040+glaq041),SUM(glaq043+glaq044) 
     INTO l_amt1,l_amt2,l_amt3
     FROM glaq_t LEFT OUTER JOIN glac_t ON (glaqent=glacent AND glaq002=glac002 AND glac001=g_glaa004) 
    WHERE glaqent=g_enterprise  AND glaqld=g_input.glapld
      AND glaqdocno=p_glapdocno AND glac016='Y'
   IF cl_null(l_amt1) THEN LET l_amt1=0 END IF   
   IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
   IF cl_null(l_amt3) THEN LET l_amt3=0 END IF


   SELECT glap002,glap004 INTO l_glap002,l_glap004 FROM glap_t WHERE glapent = g_enterprise
      AND glapdocno = p_glapdocno
      AND glapld = g_input.glapld

   IF l_amt1<>0 THEN
      SELECT COUNT(*) INTO l_cnt FROM glbc_t
       WHERE glbcent=g_enterprise AND glbcld=g_input.glapld
         AND glbcdocno=p_glapdocno AND glbc001=l_glap002
         AND glbc002=l_glap004
      IF l_cnt=0 THEN
         LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00360',g_dlang,g_input.glapld ||'|'|| p_glapdocno),
                                    cl_getmsg('agl-00221',g_dlang)
         LET p_ac = p_ac + 1
      ELSE
         SELECT SUM(glbc009),SUM(glbc012),SUM(glbc014)
           INTO l_sum1,l_sum2,l_sum3
           FROM glbc_t
          WHERE glbcent=g_enterprise AND glbcld=g_input.glapld
            AND glbcdocno=p_glapdocno AND glbc001=l_glap002
            AND glbc002=l_glap004 
         IF cl_null(l_sum1) THEN LET l_sum1=0 END IF
         IF cl_null(l_sum2) THEN LET l_sum2=0 END IF
         IF cl_null(l_sum3) THEN LET l_sum3=0 END IF
         
         IF l_amt1<>l_sum1 THEN
         LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00360',g_dlang,g_input.glapld ||'|'|| p_glapdocno),
                                    cl_getmsg('agl-00215',g_dlang)
         LET p_ac = p_ac + 1
         END IF
         IF g_glaa015='Y' AND l_amt2<>l_sum2 THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00360',g_dlang,g_input.glapld ||'|'|| p_glapdocno),
                                       cl_getmsg('agl-00219',g_dlang)
         LET p_ac = p_ac + 1
         END IF
         IF g_glaa019='Y' AND l_amt3<>l_sum3 THEN
            LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00360',g_dlang,g_input.glapld ||'|'|| p_glapdocno),
                                       cl_getmsg('agl-00220',g_dlang)
         LET p_ac = p_ac + 1
         END IF
         #判斷現金變動碼設置是否正確
         #現金變動碼參考表號
         LET l_sql = " SELECT glbcseq,glbcseq1,glbc004 FROM glbc_t ",
                     "  WHERE glbcent = ",g_enterprise,
                     "    AND glbcld = '",g_input.glapld,"'",
                     "    AND glbcdocno = '",p_glapdocno,"'",
                     "    AND glbc001=",l_glap002," AND glbc002=",l_glap004
         PREPARE s_voucher_glbc_pre  FROM l_sql
         DECLARE s_voucher_glbc_cs CURSOR FOR s_voucher_glbc_pre
         FOREACH s_voucher_glbc_cs INTO l_glbcseq,l_glbcseq1,l_glbc004
            SELECT glaq002 INTO l_glaq002
              FROM glaq_t WHERE glaqent = g_enterprise AND glaqdocno = p_glapdocno
               AND glaqld = g_input.glapld             AND glaqseq = l_glbcseq

            IF cl_null(l_glbc004) THEN 
               LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00366',g_dlang,g_input.glapld ||'|'|| p_glapdocno ||'|'|| l_glbcseq ||'|'|| l_glaq002),
                                         cl_getmsg('agl-00229',g_dlang)
               LET p_ac = p_ac + 1
            ELSE
               SELECT nmaistus INTO l_nmaistus FROM nmai_t 
                WHERE nmaient=g_enterprise AND nmai001=g_glaa005
                  AND nmai002=l_glbc004 
               IF SQLCA.sqlcode THEN
                  LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00366',g_dlang,g_input.glapld ||'|'|| p_glapdocno ||'|'|| l_glbcseq ||'|'|| l_glaq002),
                                            cl_getmsg('agl-00148',g_dlang)
                  LET p_ac = p_ac + 1
               END IF
               IF l_nmaistus<>'Y' THEN
                  LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00366',g_dlang,g_input.glapld ||'|'|| p_glapdocno ||'|'|| l_glbcseq ||'|'|| l_glaq002),
                                            cl_getmsg('sub-01302',g_dlang) #cl_getmsg('abg-00002',g_dlang) #160318-00005#17 mod
               LET p_ac = p_ac + 1
               END IF 
            END IF
         END FOREACH
      END IF
   END IF

   RETURN p_ac

END FUNCTION

################################################################################
# Descriptions...: 列印未審核憑證
# Memo...........:
# Usage..........: CALL aglq500_b_fill3()
#                  RETURNING ---
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq500_b_fill3()
   DEFINE li_ac           LIKE type_t.num10
   DEFINE l_sql           STRING
   DEFINE l_glap007_desc    LIKE type_t.chr200
   DEFINE l_glapstus_desc   LIKE type_t.chr200
   DEFINE l_glapcrtid_desc  LIKE type_t.chr200
   DEFINE l_glapcnfid_desc  LIKE type_t.chr200

   LET li_ac = 1

   CALL g_detail2.clear()

   #查詢未確認單據
   LET g_sql = "SELECT glapstus,glapdocno,glapdocdt,glap007,glapcrtid,glapcnfid,glap010,glap011 ",
               "  FROM glap_t WHERE glapent = '",g_enterprise,"'",
               "   AND glapld = '",g_input.glapld,"' ",
               "   AND glap002= ",g_input.glap002,
               "   AND glap004= ",g_input.glap004,
               "   AND ",g_wc CLIPPED,
               "   AND glapdocdt BETWEEN '",g_input.sdate,"' AND '",g_input.edate,"'",
               "   AND glapstus = 'N'"


   PREPARE aglq500_b_fill2_prep FROM g_sql
   DECLARE aglq500_b_fill2_curs CURSOR FOR aglq500_b_fill2_prep

   DELETE FROM aglq500_tmp02      #160727-00019#3  Mod  aglq500_prt_status -->aglq500_tmp02

   FOREACH aglq500_b_fill2_curs INTO g_detail2[li_ac].glapstus,g_detail2[li_ac].glapdocno,g_detail2[li_ac].glapdocdt,
                                     g_detail2[li_ac].glap007 ,g_detail2[li_ac].glapcrtid,g_detail2[li_ac].glapcnfid,
                                     g_detail2[li_ac].glap010 ,g_detail2[li_ac].glap011

      LET l_glap007_desc = ""
      SELECT gzcbl004 INTO l_glap007_desc FROM gzcbl_t WHERE gzcbl001 = '8007' AND gzcbl002 = g_detail2[li_ac].glap007
         AND gzcbl003 = g_dlang
      IF NOT cl_null(l_glap007_desc) THEN
         LET l_glap007_desc = g_detail2[li_ac].glap007,":",l_glap007_desc
      END IF

      LET l_glapstus_desc = ""
      SELECT gzcbl004 INTO l_glapstus_desc FROM gzcbl_t WHERE gzcbl001 = '13' AND gzcbl002 = g_detail2[li_ac].glapstus
         AND gzcbl003 = g_dlang
      IF NOT cl_null(l_glapstus_desc) THEN
         LET l_glapstus_desc = g_detail2[li_ac].glapstus,".",l_glapstus_desc
      END IF

      LET l_glapcrtid_desc = ""
      SELECT ooag011 INTO l_glapcrtid_desc FROM ooag_t WHERE ooagent = g_enterprise AND ooag001 = g_detail2[li_ac].glapcrtid
      IF NOT cl_null(l_glapcrtid_desc) THEN
         LET l_glapcrtid_desc = g_detail2[li_ac].glapcrtid,"(",l_glapcrtid_desc,")"
      END IF

      LET l_glapcnfid_desc = ""
      SELECT ooag011 INTO l_glapcnfid_desc FROM ooag_t WHERE ooagent = g_enterprise AND ooag001 = g_detail2[li_ac].glapcnfid
      IF NOT cl_null(l_glapcnfid_desc) THEN
         LET l_glapcnfid_desc = g_detail2[li_ac].glapcnfid,"(",l_glapcnfid_desc,")"
      END IF

      INSERT INTO aglq500_tmp02(glapent,glapld,              #160727-00019#3  Mod  aglq500_prt_status -->aglq500_tmp02
                                glapdocno,glapdocdt,glap007,
                                glapstus, glapcrtid,glapcnfid,
                                glap010,  glap011)
                         VALUES(g_enterprise,g_input.glapld,
                                g_detail2[li_ac].glapdocno,g_detail2[li_ac].glapdocdt,l_glap007_desc,
                                l_glapstus_desc           ,l_glapcrtid_desc        ,l_glapcnfid_desc,
                                g_detail2[li_ac].glap010  ,g_detail2[li_ac].glap011)
        
      LET li_ac = li_ac + 1

   END FOREACH

   CALL g_detail2.deleteElement(g_detail2.getLength())

END FUNCTION

################################################################################
# Descriptions...: 列印憑證缺號清單
# Memo...........:
# Usage..........: CALL aglq500_b_fill4()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq500_b_fill4()
   DEFINE li_ac           LIKE type_t.num10
   DEFINE l_sql           STRING
   DEFINE l_str           STRING
   DEFINE ls_wc           STRING
   DEFINE l_comp          LIKE glaa_t.glaacomp
   DEFINE l_docno         LIKE glap_t.glapdocno
   DEFINE l_glapdocno     LIKE glap_t.glapdocno
   DEFINE l_seq           LIKE glaq_t.glaqseq
   DEFINE l_seq_t         LIKE glaq_t.glaqseq
   DEFINE l_doc_len       LIKE type_t.num5       #單號總長度
   DEFINE l_slip_fla      LIKE type_t.chr1       #單別是否有分隔符
   DEFINE l_slip_sta      LIKE type_t.num5       #單別起始點
   DEFINE l_slip_len      LIKE type_t.num5       #單別長度
   DEFINE l_site_fla      LIKE type_t.chr1       #據點是否有分隔符
   DEFINE l_site_sta      LIKE type_t.num5       #據點起始點
   DEFINE l_site_len      LIKE type_t.num5       #據點長度
   DEFINE l_snum_sta      LIKE type_t.num5       #流水碼起始點
   DEFINE l_oobx007       LIKE oobx_t.oobx007    #所剩流水碼
   DEFINE l_oobf001       LIKE oobf_t.oobf001
   DEFINE l_oobf002       LIKE oobf_t.oobf002
   DEFINE l_oobf003       LIKE oobf_t.oobf003
   DEFINE l_oobf004       LIKE oobf_t.oobf004
   DEFINE l_lost_cou      LIKE type_t.num5
   DEFINE l_ecom0008      LIKE type_t.chr1
   DEFINE li_c            LIKE type_t.num5
   DEFINE l_oobxl003      LIKE oobxl_t.oobxl003
   DEFINE l_oobx005       LIKE oobx_t.oobx005
   DEFINE l_oobx006       LIKE oobx_t.oobx006
   DEFINE l_oobx006_desc  LIKE type_t.chr200

   SELECT glaacomp INTO l_comp FROM glaa_t WHERE glaaent = g_enterprise
      AND glaald = g_input.glapld

   #取得單據流水號總長度
   LET l_doc_len = cl_get_para(g_enterprise,l_comp,'E-COM-0005')
   LET l_slip_len = cl_get_para(g_enterprise,l_comp,'E-COM-0001')   #單別長度
   LET l_site_len = cl_get_para(g_enterprise,l_comp,'E-COM-0003')   #營運據點長度
   LET l_slip_fla = cl_get_para(g_enterprise,l_comp,'E-COM-0002')   #單別是否有區隔符號
   LET l_site_fla = cl_get_para(g_enterprise,l_comp,'E-COM-0004')   #據點是否有區隔符號
   LET l_ecom0008 = cl_get_para(g_enterprise,l_comp,'E-COM-0008')   #取得單據編碼格式   1.據點+單別/2.單別+據點
   IF l_ecom0008 = '1' THEN
      LET l_site_sta  = 1
      LET l_slip_sta  = l_site_len + 1
      IF l_site_fla = 'Y' THEN
         LET l_slip_sta = l_slip_sta + 1
      END IF
      LET l_snum_sta = l_slip_sta + l_slip_len + 1
   ELSE
      LET l_slip_sta  = 1
      LET l_site_sta  = l_slip_len + 1
      IF l_slip_fla = 'Y' THEN
         LET l_site_sta = l_site_sta + 1
      END IF
      LET l_snum_sta = l_site_sta + l_site_len + 1
   END IF

   IF l_site_fla = 'Y' THEN LET l_site_fla = '-' END IF
   IF l_slip_fla = 'Y' THEN LET l_slip_fla = '-' END IF

   LET ls_wc =     " glapent = '",g_enterprise,"'  AND glap002 = ",g_input.glap002,
               " AND glapld = '",g_input.glapld,"' AND glap004 = ",g_input.glap004,
               " AND glapdocdt BETWEEN '",g_input.sdate,"' AND '",g_input.edate,"'",
               " AND ",g_wc CLIPPED

   #取得存在缺號的單別
   LET g_sql = "SELECT oobf001,oobf002,oobf003,oobf004,oobf004 - glapdocno_count
                  FROM (SELECT oobf001,oobf002,oobf003,oobf004 FROM oobf_t
                         WHERE oobfent = '",g_enterprise,"' AND oobf002 IN
                            (SELECT DISTINCT SUBSTR (glapdocno, ",l_slip_sta,", ",l_slip_len,")
                               FROM glap_t WHERE 1=1 AND ",ls_wc,")
                   AND oobf003 IN
                      (SELECT DISTINCT SUBSTR (glapdocno, ",l_snum_sta,", 
                       CASE
                        WHEN oobx006 = '0' THEN 0
                        WHEN oobx006 IN ('7') THEN 3
                        WHEN oobx006 IN ('1','2','8') THEN 4 
                        WHEN oobx006 IN ('4','5','6','9') THEN 6
                        WHEN oobx006 IN ('3') THEN 8 
                       END) FROM glap_t,oobx_t
                        WHERE oobxent = glapent
                          AND oobx001 = SUBSTR (glapdocno, ",l_slip_sta,", ",l_slip_len,")
                          AND ",ls_wc,")),
                       (SELECT SUBSTR (glapdocno, ",l_site_sta,", ",l_site_len,") glapdocno_site,
                               SUBSTR (glapdocno, ",l_slip_sta,", ",l_slip_len,") glapdocno_slip,
                               COUNT (*) glapdocno_count FROM glap_t
                         WHERE 1=1 AND ",ls_wc,"
                      GROUP BY SUBSTR (glapdocno, 1, 3),SUBSTR (glapdocno, 5, 3))
                 WHERE     oobf001 = glapdocno_site
                   AND oobf002 = glapdocno_slip
                   AND oobf004 <> glapdocno_count"

   PREPARE aglq500_b_fill4_prep FROM g_sql
   DECLARE aglq500_b_fill4_curs CURSOR FOR aglq500_b_fill4_prep

   LET l_sql = "SELECT ?||LPAD(?,?,0) FROM DUAL "
   PREPARE aglq500_lost_docno_prep FROM l_sql

   #計算缺號憑證號碼
   # ? 1.據點(單別),分隔符,單別(據點),分隔符,期別
   # ? 2.流水號长度
   # ? 3.最大流水號
   LET g_sql = "SELECT docno,seq FROM (SELECT ?||LPAD(LEVEL,?,0) docno,LEVEL seq FROM DUAL CONNECT BY LEVEL <= ?)
                 WHERE NOT EXISTS (SELECT glapdocno FROM glap_t
                        WHERE 1=1 AND ",ls_wc,"
                   AND glapdocno = docno)
                 ORDER BY docno"
   PREPARE aglq500_docno_prep FROM g_sql
   DECLARE aglq500_docno_curs CURSOR FOR aglq500_docno_prep

   LET li_ac = 0
   CALL g_detail3.clear()
   DELETE FROM aglq500_tmp03       #160727-00019#3  Mod  aglq500_prt_lostno -->aglq500_tmp03

   FOREACH aglq500_b_fill4_curs INTO l_oobf001,l_oobf002,l_oobf003,l_oobf004,l_lost_cou

      SELECT oobx005,oobx006,oobx007 INTO l_oobx005,l_oobx006,l_oobx007
        FROM oobx_t WHERE oobxent = g_enterprise
         AND oobx001 = l_oobf002

      SELECT oobxl003 INTO l_oobxl003 FROM oobxl_t WHERE oobxlent = g_enterprise
         AND oobxl001 = l_oobf002 AND oobxl002 = g_dlang

      #組固定前綴
      IF l_ecom0008 = '1' THEN
         LET l_docno = l_oobf001
         IF l_site_fla = '-' THEN LET l_docno = l_docno,'-' END IF
         LET l_docno = l_docno,l_oobf002
         IF l_slip_fla = '-' THEN LET l_docno = l_docno,'-' END IF
         LET l_docno = l_docno,l_oobf003
      ELSE
         LET l_docno = l_oobf002
         IF l_slip_fla = '-' THEN LET l_docno = l_docno,'-' END IF
         LET l_docno = l_docno,l_oobf001
         IF l_site_fla = '-' THEN LET l_docno = l_docno,'-' END IF
         LET l_docno = l_docno,l_oobf003
      END IF

      #流水號长度
      LET l_str = l_docno
      LET l_oobx007 = l_doc_len - l_str.getLength()
      LET l_seq_t = 0

      FOREACH aglq500_docno_curs USING l_docno,l_oobx007,l_oobf004 INTO l_glapdocno,l_seq

        #第一筆資料或者與上一筆不是連號的情況下需要新增一筆且刷新缺號起始號碼
        IF  l_seq_t = 0 OR (NOT cl_null(l_seq_t) AND l_seq_t + 1 <> l_seq) THEN
           LET li_ac = li_ac + 1
           LET g_detail3[li_ac].oobx001 = l_oobf002
           LET g_detail3[li_ac].oobxl003= l_oobxl003
           LET g_detail3[li_ac].oobx005 = l_oobx005
           LET g_detail3[li_ac].oobx006 = l_oobx006
           LET g_detail3[li_ac].oobx007 = l_oobx007
           LET li_c = l_seq - 1
           EXECUTE aglq500_lost_docno_prep USING l_docno,li_c,l_oobx007 INTO l_glapdocno
           LET g_detail3[li_ac].sdocno = l_glapdocno
           LET g_detail3[li_ac].count = 0
        END IF

        LET li_c = l_seq + 1
        EXECUTE aglq500_lost_docno_prep USING l_docno,li_c,l_oobx007 INTO l_glapdocno
        LET g_detail3[li_ac].edocno = l_glapdocno

        LET g_detail3[li_ac].count = g_detail3[li_ac].count + 1

        LET l_seq_t = l_seq

      END FOREACH

      LET l_str = ''
      LET l_docno = ''
      LET l_oobx007 = 0

   END FOREACH

   FOR l_seq = 1 TO g_detail3.getLength()

      LET l_oobx006_desc = ""
      SELECT gzcbl004 INTO l_oobx006_desc FROM gzcbl_t WHERE gzcbl001 = '14' AND gzcbl002 = g_detail3[l_seq].oobx006
         AND gzcbl003 = g_dlang
      IF NOT cl_null(l_oobx006_desc) THEN
         LET l_oobx006_desc = g_detail3[l_seq].oobx006,".",l_oobx006_desc
      END IF

      INSERT INTO aglq500_tmp03(oobxent,oobx001,oobxl003,    #160727-00019#3  Mod  aglq500_prt_lostno -->aglq500_tmp03
                                oobx005,oobx006,
                                oobx007 ,sdocno,
                                edocno ,count)
                         VALUES(g_enterprise,g_detail3[l_seq].oobx001,g_detail3[l_seq].oobxl003,
                                g_detail3[l_seq].oobx005,l_oobx006_desc,
                                g_detail3[l_seq].oobx007,g_detail3[l_seq].sdocno,
                                g_detail3[l_seq].edocno ,g_detail3[l_seq].count)

   END FOR

END FUNCTION

################################################################################
# Descriptions...: 報表列印
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
PRIVATE FUNCTION aglq500_output()
   DEFINE b_radio      LIKE type_t.chr1

   OPEN WINDOW w_aglq500_s01 WITH FORM cl_ap_formpath("agl","aglq500_s01")

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      INPUT BY NAME b_radio ATTRIBUTE(WITHOUT DEFAULTS)

         BEFORE INPUT
            LET b_radio = '1'

      END INPUT

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

   END DIALOG

   #畫面關閉
   CLOSE WINDOW w_aglq500_s01
   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
   ELSE
      CASE
         WHEN b_radio = '1'
            CALL aglq500_x01(" 1=1","aglq500_tmp01","","")           #160727-00019#3  Mod  aglq500_prt_errno -->aglq500_tmp01
         WHEN b_radio = '2'
            CALL aglq500_x02(" 1=1","aglq500_tmp02","","")           #160727-00019#3  Mod  aglq500_prt_status -->aglq500_tmp02
         WHEN b_radio = '3'
            CALL aglq500_x03(" 1=1","aglq500_tmp03","","")           #160727-00019#3  Mod  aglq500_prt_lostno -->aglq500_tmp03
      END CASE
   END IF

END FUNCTION

################################################################################
# Descriptions...: 串查aglt310
# Memo...........:
# Usage..........: CALL aglq500_open_aglt310(p_docno)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq500_open_aglt310(p_docno)
   DEFINE p_docno     LIKE glap_t.glapdocno
   DEFINE la_param    RECORD
                      prog       STRING,
                      actionid   STRING,
                      background LIKE type_t.chr1,
                      param      DYNAMIC ARRAY OF STRING
                      END RECORD
   DEFINE ls_js       STRING
   DEFINE l_glap001   LIKE glap_t.glap001



   SELECT glap001 INTO l_glap001 FROM glap_t WHERE glapent = g_enterprise
      AND glapdocno = p_docno  AND glapld = g_input.glapld
   CASE
      WHEN l_glap001 = '1'
         LET la_param.prog = "aglt310"
      WHEN l_glap001 = '2'
         LET la_param.prog = "aglt320"
      WHEN l_glap001 = '3'
         LET la_param.prog = "aglt330"
      WHEN l_glap001 = '5'
         LET la_param.prog = "aglt350"
   END CASE
   LET la_param.param[1] = g_input.glapld
   LET la_param.param[2] = p_docno
   LET ls_js = util.JSON.stringify(la_param)
   CALL cl_cmdrun_wait(ls_js)

END FUNCTION

################################################################################
# Descriptions...: 细项立冲账检核
# Memo...........: #170103-00019#19 add
# Usage..........: CALL aglq500_glax_glay_chk(p_glapdocno,p_ac)
#                  RETURNING p_ac
# Input parameter: p_glapdocno    凭证单号
#                : p_ac           序号
# Return code....: 
#                : 
# Date & Author..: 2017/01/16 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq500_glax_glay_chk(p_glapdocno,p_ac)
   DEFINE p_glapdocno        LIKE glap_t.glapdocno
   DEFINE p_ac               LIKE type_t.num10
   DEFINE l_glaqseq          LIKE glaq_t.glaqseq
   DEFINE l_glaq002          LIKE glaq_t.glaq002
   DEFINE l_glaq010          LIKE glaq_t.glaq010
   DEFINE l_glaq003          LIKE glaq_t.glaq003
   DEFINE l_glaq004          LIKE glaq_t.glaq004
   DEFINE l_cnt              LIKE type_t.num5
   DEFINE l_sum              LIKE glay_t.glay003
   DEFINE l_sum1             LIKE glay_t.glay003
   DEFINE l_flag             LIKE type_t.chr1
   DEFINE l_glad003          LIKE glad_t.glad003
   DEFINE l_glad004          LIKE glad_t.glad004
   DEFINE l_osum             LIKE glaq_t.glaq010
   DEFINE l_sql              STRING
   
   #STEP20.细项立冲科目是否应立未立，应冲未冲，冲账金额是否等于单身金额
   LET l_sql = "SELECT UNIQUE glaqseq,glaq002,glaq010,glaq003,glaq004,glad003,glad004 FROM glaq_t",
               " INNER JOIN glap_t ON glapld = glaqld ",
               " AND glapdocno = glaqdocno ",
               " LEFT JOIN glad_t ON gladent=glaqent AND gladld=glaqld AND glad001=glaq002 ",
               " WHERE glaqent='",g_enterprise,"' ",
               "   AND glaqld='",g_input.glapld,"' ",
               "   AND glaqdocno='",p_glapdocno,"' ",
               "   AND glad003 = 'Y' ",
               " ORDER BY glaq_t.glaqseq"
   PREPARE aglq500_glax_chk_pr FROM l_sql
   DECLARE aglq500_glax_chk_cs CURSOR FOR aglq500_glax_chk_pr
   
   FOREACH aglq500_glax_chk_cs INTO l_glaqseq,l_glaq002,l_glaq010,l_glaq003,l_glaq004,
                                    l_glad003,l_glad004
      LET l_flag=''
      IF l_glad003='Y' THEN
         IF l_glad004='1' THEN #借方立帳
            IF l_glaq003>0 THEN #細項立帳
               LET l_flag='x' 
            END IF
            IF l_glaq004>0 THEN #細項沖帳
               LET l_flag='y'
               LET l_sum1=l_glaq004 #沖帳金額
            END IF
         ELSE #貸方立賬
            IF l_glaq003>0 THEN #細項沖帳
               LET l_flag='y'
               LET l_sum1=l_glaq003 #沖帳金額
            END IF
            IF l_glaq004>0 THEN #細項立帳
               LET l_flag='x'
            END IF
         END IF
      END IF
      LET l_cnt = 0 
      CASE
         WHEN l_flag='x'  #檢查細項立帳資料是否產生
            SELECT COUNT(1) INTO l_cnt FROM glax_t 
             WHERE glaxent=g_enterprise AND glaxld=p_glapld
               AND glaxdocno=p_glapdocno AND glaxseq=l_glaqseq
               AND glax002=l_glaq002
            IF l_cnt=0 THEN
               LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00360',g_dlang,g_input.glapld ||'|'|| p_glapdocno),
                                         '+',l_glaqseq USING '<<<<',cl_getmsg('agl-00205',g_dlang)
               LET p_ac = p_ac + 1
            END IF
         WHEN l_flag='y'  #檢查細項沖帳資料是否產生，且產生的總金額是否等於單身金額
            SELECT COUNT(1) INTO l_cnt FROM glay_t
             WHERE glayent=g_enterprise AND glayld=p_glapld
               AND glaydocno=p_glapdocno AND glayseq=l_glaqseq
            IF l_cnt>0 THEN           
               #細項沖帳金額
               LET l_sum=0
               LET l_osum=0
               SELECT SUM(glay003),SUM(glay010) INTO l_sum,l_osum FROM glay_t
                WHERE glayent=g_enterprise AND glayld=p_glapld
                  AND glaydocno=p_glapdocno AND glayseq=l_glaqseq
               IF l_sum<>l_sum1 OR l_glaq010<>l_osum THEN
                  LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00360',g_dlang,g_input.glapld ||'|'|| p_glapdocno),
                                            '+',l_glaqseq USING '<<<<',cl_getmsg('agl-00207',g_dlang)
                  LET p_ac = p_ac + 1
               END IF
            ELSE
               LET l_msg[p_ac].l_errno = cl_getmsg_parm('agl-00360',g_dlang,g_input.glapld ||'|'|| p_glapdocno),
                                         '+',l_glaqseq USING '<<<<',cl_getmsg('agl-00206',g_dlang)
               LET p_ac = p_ac + 1
            END IF
      END CASE
   END FOREACH
   RETURN p_ac
END FUNCTION

 
{</section>}
 
