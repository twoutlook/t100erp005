#該程式未解開Section, 採用最新樣板產出!
{<section id="aicp120.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2015-03-24 11:48:32), PR版次:0005(2016-10-18 10:33:12)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000074
#+ Filename...: aicp120
#+ Description: 訂單分配拋轉作業
#+ Creator....: 02749(2014-11-11 09:46:56)
#+ Modifier...: 02040 -SD/PR- 05384
 
{</section>}
 
{<section id="aicp120.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#14 2016/04/18 By 07673        將重複內容的錯誤訊息置換為公用錯誤訊息
#160902-00048#1  2016/09/05 By dorislai     修正SQL少ent的問題
#161013-00051#1  2016/10/18 By shiun        整批調整據點組織開窗
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
 
#模組變數(Module Variables)
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
DEFINE l_ac_d               LIKE type_t.num10             #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num10             #目前所在頁數
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num10
 
TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable) name="global.parameter"
   
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
   sel               LIKE type_t.chr1,
   xmdadocdt         LIKE  xmda_t.xmdadocdt,       
   xmda004           LIKE  xmda_t.xmda004  ,     
   xmda004_desc      LIKE  pmaal_t.pmaal003,
   xmda002           LIKE  xmda_t.xmda002  ,     
   xmda002_desc      LIKE  ooag_t.ooag011  ,
   xmda003           LIKE  xmda_t.xmda003  ,     
   xmda003_desc      LIKE  ooefl_t.ooefl003,  
   xmdadocno         LIKE  xmda_t.xmdadocno,     
   xmddseq           LIKE  xmdd_t.xmddseq  ,     
   xmddseq1          LIKE  xmdd_t.xmddseq1 ,     
   xmddseq2          LIKE  xmdd_t.xmddseq2 ,     
   xmdd001           LIKE  xmdd_t.xmdd001  ,     
   xmdd001_desc      LIKE  imaal_t.imaal003,  
   xmdd001_desc_1    LIKE  imaal_t.imaal004,
   xmdd002           LIKE  xmdd_t.xmdd002  ,     
   xmdcunit          LIKE  xmdc_t.xmdcunit ,     
   xmdcunit_desc     LIKE  ooefl_t.ooefl002,
   xmdd006           LIKE  xmdd_t.xmdd006  ,   
   xmdd011           LIKE  xmdd_t.xmdd011  ,     
   xmdd035           LIKE  xmdd_t.xmdd035  
                     END RECORD
                     
TYPE type_g_detail2_d RECORD
   icaj006            LIKE icaj_t.icaj006  ,  
   icaj006_desc       LIKE icaal_t.icaal003,
   icab003            LIKE icab_t.icab003  ,
   icab003_desc       LIKE ooefl_t.ooefl003,
   icaj005            LIKE icaj_t.icaj005  ,
   icaj007            LIKE icaj_t.icaj007  ,
   l_icaj007_desc     STRING,
   icaj008            LIKE icaj_t.icaj008  ,
   icaj009            LIKE icaj_t.icaj009  ,
   icaj010            LIKE icaj_t.icaj010  ,
   icaj011            LIKE icaj_t.icaj011  ,
   icaj001            LIKE icaj_t.icaj001  ,
   icaj002            LIKE icaj_t.icaj002  ,
   icaj003            LIKE icaj_t.icaj003  ,
   icaj004            LIKE icaj_t.icaj004  ,
   icajsite           LIKE icaj_t.icajsite ,
   seq                LIKE type_t.num5                   #20150323 POLLY ADD
                      END RECORD
                      
TYPE type_g_detail3_d RECORD
   l_xmdadocdt        LIKE  xmda_t.xmdadocdt,       
   l_xmda004          LIKE  xmda_t.xmda004  ,     
   l_xmda004_desc     LIKE  pmaal_t.pmaal003,
   l_xmda002          LIKE  xmda_t.xmda002  ,     
   l_xmda002_desc     LIKE  ooag_t.ooag011  ,
   l_xmda003          LIKE  xmda_t.xmda003  ,     
   l_xmda003_desc     LIKE  ooefl_t.ooefl003,  
   l_xmdadocno        LIKE  xmda_t.xmdadocno,     
   l_xmdcunit         LIKE  xmdc_t.xmdcunit ,     
   l_xmdcunit_desc    LIKE  ooefl_t.ooefl002, 
   l_xmdd011          LIKE  xmdd_t.xmdd011  , 
   l_icaj006          LIKE icaj_t.icaj006   ,  
   l_icaj006_desc     LIKE icaal_t.icaal003    
                      END RECORD
                      
TYPE type_g_detail4_d RECORD
   l_xmdadocdt_1      LIKE  xmda_t.xmdadocdt,       
   l_xmda004_1        LIKE  xmda_t.xmda004  ,     
   l_xmda004_1_desc   LIKE  pmaal_t.pmaal003,
   l_xmda002_1        LIKE  xmda_t.xmda002  ,     
   l_xmda002_1_desc   LIKE  ooag_t.ooag011  ,
   l_xmda003_1        LIKE  xmda_t.xmda003  ,     
   l_xmda003_1_desc   LIKE  ooefl_t.ooefl003,  
   l_xmdadocno1_      LIKE  xmda_t.xmdadocno,     
   l_xmdcunit_1       LIKE  xmdc_t.xmdcunit ,     
   l_xmdcunit_1_desc  LIKE  ooefl_t.ooefl002, 
   l_xmdd011_1        LIKE  xmdd_t.xmdd011  , 
   l_icaj006_1        LIKE  icaj_t.icaj006  ,  
   l_icaj006_1_desc   LIKE  icaal_t.icaal003, 
   l_errmsg           STRING  
                      END RECORD

DEFINE g_detail2_d          DYNAMIC ARRAY OF type_g_detail2_d 
DEFINE g_detail2_d_t        type_g_detail2_d
DEFINE g_detail3_d          DYNAMIC ARRAY OF type_g_detail3_d 
DEFINE g_detail4_d          DYNAMIC ARRAY OF type_g_detail4_d 
DEFINE g_detail_idx         LIKE type_t.num5
DEFINE g_detail_idx2        LIKE type_t.num5
DEFINE g_detail_idx3        LIKE type_t.num5
DEFINE g_detail_idx4        LIKE type_t.num5
DEFINE g_detail2_cnt        LIKE type_t.num5
DEFINE g_detail3_cnt        LIKE type_t.num5
DEFINE g_detail4_cnt        LIKE type_t.num5
DEFINE g_process     DYNAMIC ARRAY OF RECORD
         process     LIKE type_t.chr1,
         xmdadocdt   LIKE xmda_t.xmdadocdt,
         xmda004     LIKE xmda_t.xmda004,
         xmda002     LIKE xmda_t.xmda002,
         xmda003     LIKE xmda_t.xmda003,
         xmdadocno   LIKE xmda_t.xmdadocno,
         xmdcunit    LIKE xmdc_t.xmdcunit,
         xmdd011     LIKE xmdd_t.xmdd011,
         icaj006     LIKE icaj_t.icaj006,
         errmsg      STRING
                     END RECORD
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aicp120.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
   #add-point:main段define name="main.define"
   
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aic","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aicp120 WITH FORM cl_ap_formpath("aic",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aicp120_init()   
 
      #進入選單 Menu (="N")
      CALL aicp120_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aicp120
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aicp120.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aicp120_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   LET g_errshow = 1
   CALL s_aicp120_drop_tmp() 
   CALL s_aicp120_create_tmp()
   CALL s_tax_recount_tmp()              #20150331 POLLY ADD
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aicp120.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aicp120_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE l_allow_delete        LIKE type_t.num5                #可刪除否
   DEFINE l_cnt                 LIKE type_t.num5   
   DEFINE l_i                   LIKE type_t.num5 
   DEFINE l_cmd                 LIKE type_t.chr10
   DEFINE l_sql                 STRING
   DEFINE l_icab003             LIKE icab_t.icab003
   DEFINE l_ooef004             LIKE ooef_t.ooef004
   DEFINE l_qty                 LIKE type_t.num5
   DEFINE l_success             LIKE type_t.num5  
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
  #--20150324--POLLY-MARK--(S)
  #LET g_forupd_sql = "SELECT icajent,icaj001,icaj002,icaj003,icaj004, ",
  #                   "       icaj005,icaj006,icaj007,icaj008,icaj009, ",
  #                   "       icaj010,icaj011 ",
  #                   "  FROM aicp120_tmp ",
  #                   " WHERE icajent = ? AND icaj001 = ? AND icaj002 = ? ",
  #                   "   AND icaj003 = ? AND icaj004 = ? FOR UPDATE "
  #LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
  #LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql) 
  #DECLARE aicp120_bcl CURSOR FROM g_forupd_sql
  #
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
  #--20150324--POLLY-MARK--(E)
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aicp120_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc ON xmdadocdt,xmda004,xmda002,xmda003,xmdadocno,
                                   xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002,
                                   xmdcunit,xmdd011,xmda005,xmda006,xmda030
         
            BEFORE CONSTRUCT
               CALL cl_set_act_visible("filter",FALSE)
               IF NOT aicp120_requery_chk() THEN
                  ACCEPT DIALOG
               END IF
               
            ON ACTION controlp 
               CASE
                  WHEN INFIELD(xmda004)   #客戶編號
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     LET g_qryparam.arg1 = g_site
                     CALL q_pmaa001_6()
                     DISPLAY g_qryparam.return1 TO xmda004 
                     NEXT FIELD CURRENT                  
                  WHEN INFIELD(xmda002)   #業務人員
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     CALL q_ooag001()
                     DISPLAY g_qryparam.return1 TO xmda002 
                     NEXT FIELD CURRENT                     
                  WHEN INFIELD(xmda003)   #業務部門
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     CALL q_ooeg001()
                     DISPLAY g_qryparam.return1 TO xmda003 
                     NEXT FIELD CURRENT                   
                  WHEN INFIELD(xmdadocno) #訂單單號
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     CALL q_xmdadocno()
                     DISPLAY g_qryparam.return1 TO xmdadocno 
                     NEXT FIELD CURRENT                  
                  WHEN INFIELD(xmdd001)   #料件編號
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     CALL q_imaa001()
                     DISPLAY g_qryparam.return1 TO xmdd001 
                     NEXT FIELD CURRENT                  
                  WHEN INFIELD(xmdcunit)  #出貨據點
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     #mod--161013-00051#1 By shiun--(S)
#                     CALL q_ooef001()
                     CALL q_ooef001_1()
                     #mod--161013-00051#1 By shiun--(E)
                     DISPLAY g_qryparam.return1 TO xmdcunit 
                     NEXT FIELD CURRENT                   
               END CASE   
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT ARRAY g_detail2_d FROM s_detail2.* ATTRIBUTES(COUNT=g_detail2_cnt,WITHOUT DEFAULTS,
                                                             INSERT ROW = l_allow_insert,
                                                             DELETE ROW = l_allow_delete,
                                                             APPEND ROW = l_allow_insert)
            BEFORE INPUT
               IF g_detail_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.code   = 'aic-00108' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD xmdadocdt
               ELSE
                  LET g_current_page = 2
                  CALL cl_set_act_visible("filter",FALSE)               
               END IF
               
            BEFORE ROW
               #CALL s_transaction_begin()
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_cmd = ''
               LET l_ac = ARR_CURR()
               
               IF l_ac > g_detail2_d.getLength() THEN
                  LET l_cmd = 'a'
               ELSE
                  #--20150331--POLLY--ADD--(S)
                  IF NOT cl_null(g_detail2_d[l_ac].icaj008) THEN
                     LET l_cnt = l_ac + 1
                     CALL FGL_SET_ARR_CURR(l_cnt)
                  ELSE
                     LET l_cmd = 'u'                  
                     LET g_detail2_d_t.* = g_detail2_d[l_ac].*       
                  END IF
                  #--20150331--POLLY--ADD--(E)  

               END IF 

               
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               DISPLAY g_detail2_d.getLength() TO FORMONLY.cnt
               
            BEFORE INSERT
               INITIALIZE g_detail2_d[l_ac].* TO NULL                         #20150323 POLLY ADD
               LET g_detail2_d[l_ac].icaj001 = g_detail_d[g_detail_idx].xmdadocno
               LET g_detail2_d[l_ac].icaj002 = g_detail_d[g_detail_idx].xmddseq
               LET g_detail2_d[l_ac].icaj003 = g_detail_d[g_detail_idx].xmddseq1
               LET g_detail2_d[l_ac].icaj004 = g_detail_d[g_detail_idx].xmddseq2    
              
               #20150323--POLLY--ADD--(S)
               SELECT MAX(seq) + 1 INTO g_detail2_d[l_ac].seq
                 FROM aicp120_tmp  
               IF cl_null(g_detail2_d[l_ac].seq) OR g_detail2_d[l_ac].seq = 0 THEN
                  LET g_detail2_d[l_ac].seq = 1
               END IF                
               CALL s_aicp120_allocation_chk(g_detail2_d[l_ac].icaj001,g_detail2_d[l_ac].icaj002,
                                             g_detail2_d[l_ac].icaj003,g_detail2_d[l_ac].icaj004,
                                             g_detail2_d[l_ac].icaj006,g_detail2_d[l_ac].seq)
                 RETURNING l_qty   
               IF l_qty = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aic-00126'               
                  LET g_errparam.extend = g_detail2_d[l_ac].icaj001
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  CANCEL INSERT
               ELSE    
                  LET g_detail2_d[l_ac].icajsite = g_site               
                  LET g_detail2_d_t.* = g_detail2_d[l_ac].*                
               END IF         
                
               #20150323--POLLY--ADD--(E)

               
            AFTER FIELD icaj006
               LET g_detail2_d[l_ac].icaj006_desc = ''
               IF NOT cl_null(g_detail2_d[l_ac].icaj006) THEN
                  IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_detail2_d[l_ac].icaj006 != g_detail2_d_t.icaj006 OR g_detail2_d_t.icaj006 IS NULL )) THEN
                     LET l_sql = "SELECT COUNT(*) ",
                                 "  FROM (SELECT icajent,icaj001,icaj002,icaj003,icaj004,icaj006 FROM icaj_t ",
                                 "         UNION ",
                                 "        SELECT icajent,icaj001,icaj002,icaj003,icaj004,icaj006 FROM aicp120_tmp) ", 
                                 " WHERE icajent = ",g_enterprise,
                                 "   AND icaj001 = '",g_detail_d[g_detail_idx].xmdadocno,"' ",
                                 "   AND icaj002 = ",g_detail_d[g_detail_idx].xmddseq,
                                 "   AND icaj003 = ",g_detail_d[g_detail_idx].xmddseq1,
                                 "   AND icaj004 = ",g_detail_d[g_detail_idx].xmddseq2,
                                 "   AND icaj006 = '",g_detail2_d[l_ac].icaj006,"'"
                     PREPARE aicp120_sel_icaj FROM l_sql
                     EXECUTE aicp120_sel_icaj INTO l_cnt
                     IF l_cnt > 0 THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.code   = 'std-00004'
                        LET g_errparam.popup  = FALSE 
                        CALL cl_err()                        
                        LET g_detail2_d[l_ac].icaj006 = g_detail2_d_t.icaj006
                        LET g_detail2_d[l_ac].icaj006_desc = s_desc_get_icaa001_desc(g_detail2_d[l_ac].icaj006)
                        NEXT FIELD CURRENT
                     END IF
                     
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_detail2_d[l_ac].icaj006
                     LET g_chkparam.arg2 = '2'
                     LET g_chkparam.arg3 = '0'
                     LET g_chkparam.arg4 = g_site
                     LET g_errshow = TRUE   #160318-00025#14
                     LET g_chkparam.err_str[1] = "aic-00012:sub-01302|aici100|",cl_get_progname("aici100",g_lang,"2"),"|:EXEPROGaici100"    #160318-00025#14   
                     IF NOT cl_chk_exist("v_icaa001_1") THEN
                        LET g_detail2_d[l_ac].icaj006 = g_detail2_d_t.icaj006
                        LET g_detail2_d[l_ac].icaj006_desc = s_desc_get_icaa001_desc(g_detail2_d[l_ac].icaj006)
                        NEXT FIELD CURRENT
                     END IF
                     
                     #150917-00001#4 151124 earl s
                     #製造批序號檢查
                     IF NOT s_aic_carry_lot_chk(g_detail2_d[l_ac].icaj006) THEN
                        LET g_detail2_d[l_ac].icaj006 = g_detail2_d_t.icaj006
                        LET g_detail2_d[l_ac].icaj006_desc = s_desc_get_icaa001_desc(g_detail2_d[l_ac].icaj006)
                        NEXT FIELD CURRENT
                     END IF
                     #150917-00001#4 151124 earl e
                     
                     #151229 earl add s
                     #多角製造批序號檢查
                     IF NOT s_apmt500_inao_chk(g_detail2_d[l_ac].icaj001,g_detail2_d[l_ac].icaj006,g_detail_d[g_detail_idx].xmdd001) THEN
                        LET g_detail2_d[l_ac].icaj006 = g_detail2_d_t.icaj006
                        LET g_detail2_d[l_ac].icaj006_desc = s_desc_get_icaa001_desc(g_detail2_d[l_ac].icaj006)
                        NEXT FIELD CURRENT   
                     END IF
                     #151229 earl add e
                     
                     
                     IF NOT aicp120_icaj006_default() THEN
                        LET g_detail2_d[l_ac].icaj006 = g_detail2_d_t.icaj006
                        LET g_detail2_d[l_ac].icaj006_desc = s_desc_get_icaa001_desc(g_detail2_d[l_ac].icaj006)
                        NEXT FIELD CURRENT
                     END IF

                  END IF
                  LET g_detail2_d_t.icaj006 = g_detail2_d[l_ac].icaj006     #150323 POLLY ADD
               END IF
               LET g_detail2_d[l_ac].icaj006_desc = s_desc_get_icaa001_desc(g_detail2_d[l_ac].icaj006)

            BEFORE FIELD icaj005
               IF cl_null(g_detail2_d[l_ac].icaj006) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.code   = 'aic-00110'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()                  
                  NEXT FIELD icaj006
               END IF
               
            AFTER FIELD icaj005
               IF NOT cl_null(g_detail2_d[l_ac].icaj005) THEN
                  IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_detail2_d[l_ac].icaj005 != g_detail2_d_t.icaj005 OR g_detail2_d_t.icaj005 IS NULL )) THEN
                    #20150323--POLLY---(S)
                    #IF NOT s_aicp120_allocation_chk(g_detail2_d[l_ac].icaj001,g_detail2_d[l_ac].icaj002,
                    #                                g_detail2_d[l_ac].icaj003,g_detail2_d[l_ac].icaj004,
                    #                                g_detail2_d[l_ac].icaj006,g_detail2_d[l_ac].icaj005,
                    #                                TRUE) THEN
                     CALL s_aicp120_allocation_chk(g_detail2_d[l_ac].icaj001,g_detail2_d[l_ac].icaj002,
                                                   g_detail2_d[l_ac].icaj003,g_detail2_d[l_ac].icaj004,
                                                   g_detail2_d[l_ac].icaj006,g_detail2_d[l_ac].seq)
                        RETURNING l_qty                                               
                     IF g_detail2_d[l_ac].icaj005 > l_qty THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code =  'aic-00109'
                        LET g_errparam.replace[1] = l_qty
                        LET g_errparam.popup = TRUE
                        CALL cl_err()                   
                        LET g_detail2_d[l_ac].icaj005 = g_detail2_d_t.icaj005
                        NEXT FIELD CURRENT
                     END IF
                    #20150323--POLLY---(E)
                  END IF
                  LET g_detail2_d_t.icaj005 = g_detail2_d[l_ac].icaj005    #150323 POLLY ADD
               END IF
            
            BEFORE FIELD icaj007
               IF cl_null(g_detail2_d[l_ac].icaj006) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.code   = 'aic-00110'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()                  
                  NEXT FIELD icaj006
               END IF
            
            AFTER FIELD icaj007
               LET l_icab003 = ''
               LET l_ooef004 = ''
               CALL aicp120_get_ooef004() RETURNING l_icab003,l_ooef004
               
               LET g_detail2_d[l_ac].l_icaj007_desc  = ''
               DISPLAY BY NAME g_detail2_d[l_ac].l_icaj007_desc 
               IF NOT cl_null(g_detail2_d[l_ac].icaj007) THEN
                  IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_detail2_d[l_ac].icaj007 != g_detail2_d_t.icaj007 OR g_detail2_d_t.icaj007 IS NULL )) THEN
                     IF NOT s_aooi200_chk_slip(l_icab003,'',g_detail2_d[l_ac].icaj007,'apmt500') THEN
                        LET g_detail2_d[l_ac].icaj007 = g_detail2_d_t.icaj007
                        LET g_detail2_d[l_ac].l_icaj007_desc = s_aooi200_get_slip_desc(g_detail2_d[l_ac].icaj007)
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  LET g_detail2_d_t.icaj007 = g_detail2_d[l_ac].icaj007     #150323 POLLY ADD
               END IF
               LET g_detail2_d[l_ac].l_icaj007_desc = s_aooi200_get_slip_desc(g_detail2_d[l_ac].icaj007)
               
            ON ACTION controlp
               CASE
                  WHEN INFIELD(icaj006)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'i'
                     LET g_qryparam.reqry = FALSE
                     LET g_qryparam.arg1 = '2'
                     LET g_qryparam.arg2 = '0'
                     CALL q_icaa001_1()
                     LET g_detail2_d[l_ac].icaj006 = g_qryparam.return1
                     LET g_detail2_d[l_ac].icaj006_desc = s_desc_get_icaa001_desc(g_detail2_d[l_ac].icaj006)
                     NEXT FIELD CURRENT         
                  WHEN INFIELD(icaj007)
                     LET l_icab003 = ''
                     LET l_ooef004 = ''
                     CALL aicp120_get_ooef004() RETURNING l_icab003,l_ooef004
                     
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'i'
                     LET g_qryparam.reqry = FALSE
                     LET g_qryparam.arg1 = l_ooef004
                     LET g_qryparam.arg2 = 'apmt500'
                     CALL q_ooba002_1()
                     LET g_detail2_d[l_ac].icaj007 = g_qryparam.return1
                     LET g_detail2_d[l_ac].l_icaj007_desc = s_aooi200_get_slip_desc(g_detail2_d[l_ac].icaj007)
               END CASE
               
            AFTER INSERT
               IF INT_FLAG THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = 9001 
                  LET g_errparam.popup  = FALSE 
                  CALL cl_err()
               
                  LET INT_FLAG = 0
                  CANCEL INSERT
               END IF   
               
               LET l_cnt = 0 
               SELECT COUNT(*) INTO l_cnt
                 FROM icaj_t
                WHERE icajent = g_enterprise
                  AND icaj001 = g_detail_d[g_detail_idx].xmdadocno
                  AND icaj002 = g_detail_d[g_detail_idx].xmddseq
                  AND icaj003 = g_detail_d[g_detail_idx].xmddseq1
                  AND icaj004 = g_detail_d[g_detail_idx].xmddseq2
                  AND icaj006 = g_detail2_d[l_ac].icaj006
               
               IF l_cnt = 0 THEN               
                  INSERT INTO aicp120_tmp(icajent,icaj001,icaj002,icaj003,icaj004, 
                                          icaj005,icaj006,icaj007,icajsite,chk_process,seq)
                       VALUES(g_enterprise,
                              g_detail2_d[l_ac].icaj001,g_detail2_d[l_ac].icaj002,g_detail2_d[l_ac].icaj003, 
                              g_detail2_d[l_ac].icaj004,g_detail2_d[l_ac].icaj005,g_detail2_d[l_ac].icaj006, 
                              g_detail2_d[l_ac].icaj007,g_detail2_d[l_ac].icajsite,'Y',g_detail2_d[l_ac].seq)   #20150324 POLLY ADD icaj007,seq
                   IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "icaj_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()                     
                     #CALL s_transaction_end('N','0')                    
                     CANCEL INSERT
                  END IF                
                  #CALL s_transaction_end('Y',0)
               ELSE
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'INSERT' 
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()                  
                  INITIALIZE g_detail2_d[l_ac].* TO NULL
                  #CALL s_transaction_end('N','0')
                  CANCEL INSERT               
               END IF
               
            BEFORE DELETE
               IF NOT cl_null(g_detail2_d[l_ac].icaj008) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_detail2_d[l_ac].icaj006
                  LET g_errparam.code   = "aic-00106" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()                  
                  CANCEL DELETE                  
               ELSE
                 #--20150324--POLLY--MARK-(S) 
                 #OPEN aicp120_bcl USING g_enterprise,
                 #                       g_detail_d[g_detail_idx].xmdadocno,
                 #                       g_detail_d[g_detail_idx].xmddseq,
                 #                       g_detail_d[g_detail_idx].xmddseq1,
                 #                       g_detail_d[g_detail_idx].xmddseq2               
                 #IF SQLCA.sqlcode THEN
                 #   INITIALIZE g_errparam TO NULL 
                 #   LET g_errparam.extend = "adbt540_bcl" 
                 #   LET g_errparam.code   = SQLCA.sqlcode 
                 #   LET g_errparam.popup  = TRUE 
                 #   CALL cl_err()                  
                 #   LET g_detail2_d[l_ac].* = g_detail2_d_t.*
                 #   #CALL s_transaction_end('N','0')
                 #   CANCEL DELETE
                 #ELSE        
                 #--20150324--POLLY--MARK-(E)
                     DELETE FROM aicp120_tmp
                           WHERE icajent = g_enterprise
                             AND icaj001 = g_detail2_d[l_ac].icaj001
                             AND icaj002 = g_detail2_d[l_ac].icaj002
                             AND icaj003 = g_detail2_d[l_ac].icaj003
                             AND icaj004 = g_detail2_d[l_ac].icaj004 
                             AND icaj006 = g_detail2_d[l_ac].icaj006                         
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "icaj_t" 
                        LET g_errparam.code   = SQLCA.sqlcode 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()                        
                        #CALL s_transaction_end('N','0')
                        CANCEL DELETE                        
                     END IF                   
                     #CALL s_transaction_end('Y',0)
                  #END IF                             #20150324 POLLY MARK   
               END IF
               
            ON ROW CHANGE               
               IF INT_FLAG THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = 9001 
                  LET g_errparam.popup  = FALSE 
                  CALL cl_err()              
                  LET INT_FLAG = 0
                  LET g_detail2_d[l_ac].* = g_detail2_d_t.*
                  EXIT DIALOG 
               END IF  
               #--20150324--POLLY--MARK-(S)
               #OPEN aicp120_bcl USING g_enterprise,
               #                       g_detail_d[g_detail_idx].xmdadocno,
               #                       g_detail_d[g_detail_idx].xmddseq,
               #                       g_detail_d[g_detail_idx].xmddseq1,
               #                       g_detail_d[g_detail_idx].xmddseq2               
               #IF SQLCA.sqlcode THEN
               #   INITIALIZE g_errparam TO NULL 
               #   LET g_errparam.extend = "adbt540_bcl" 
               #   LET g_errparam.code   = SQLCA.sqlcode 
               #   LET g_errparam.popup  = TRUE 
               #   CALL cl_err()               
               #   LET g_detail2_d[l_ac].* = g_detail2_d_t.*
               #ELSE
               #--20150324--POLLY--MARK-(E)
                  UPDATE aicp120_tmp
                     SET icaj005 = g_detail2_d[l_ac].icaj005,
                         icaj006 = g_detail2_d[l_ac].icaj006,
                         icaj007 = g_detail2_d[l_ac].icaj007
                    WHERE icajent = g_enterprise
                      AND icaj001 = g_detail2_d[l_ac].icaj001
                      AND icaj002 = g_detail2_d[l_ac].icaj002
                      AND icaj003 = g_detail2_d[l_ac].icaj003
                      AND icaj004 = g_detail2_d[l_ac].icaj004       

                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "icaj_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()                     
                     #CALL s_transaction_end('N','0')   
                  END IF                
                  #CALL s_transaction_end('Y',0)
               #END IF                                      #20150324 POLLY MARK

            AFTER INPUT  
            
         END INPUT         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 1
               CALL cl_set_act_visible("filter",FALSE)
               
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_detail_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
               CALL aicp120_fetch()
         END DISPLAY
         
         #DISPLAY ARRAY g_detail2_d TO s_detail2.* ATTRIBUTES(COUNT=g_detail2_cnt)
         #   BEFORE DISPLAY
         #      LET g_current_page = 2
         #      CALL cl_set_act_visible("filter",FALSE)
         #      
         #   BEFORE ROW
         #      LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
         #      LET l_ac = g_detail_idx2
         #      DISPLAY g_detail_idx2 TO FORMONLY.idx
         #      DISPLAY g_detail2_d.getLength() TO FORMONLY.cnt
         #END DISPLAY

         DISPLAY ARRAY g_detail3_d TO s_detail3.* ATTRIBUTES(COUNT=g_detail3_cnt)
            BEFORE DISPLAY
               LET g_current_page = 3
               CALL cl_set_act_visible("filter",FALSE)
               
            BEFORE ROW
               LET g_detail_idx3 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx3
               DISPLAY g_detail_idx3 TO FORMONLY.idx
               DISPLAY g_detail3_d.getLength() TO FORMONLY.cnt
         END DISPLAY
         
         DISPLAY ARRAY g_detail4_d TO s_detail4.* ATTRIBUTES(COUNT=g_detail4_cnt)
            BEFORE DISPLAY
               LET g_current_page = 4
               CALL cl_set_act_visible("filter",FALSE)
               
            BEFORE ROW
               LET g_detail_idx4 = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx4
               DISPLAY g_detail_idx4 TO FORMONLY.idx
               DISPLAY g_detail4_d.getLength() TO FORMONLY.cnt
         END DISPLAY         
         #end add-point
 
         BEFORE DIALOG
            IF g_detail_d.getLength() > 0 THEN
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
            ELSE
               CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            END IF
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            CALL cl_set_comp_visible("sel",FALSE)
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
               
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone name="ui_dialog.for.onaction_selnone"
               
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aicp120_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION accept
            #add-point:ui_dialog段accept之前 name="menu.filter"
            
            #end add-point
            CALL aicp120_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL aicp120_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            IF aicp120_execute_chk() THEN                        #20150324 POLLY ADD
              CALL s_transaction_begin()
              CALL s_aicp120() RETURNING l_success,g_process
              IF l_success THEN
                 CALL s_transaction_end('Y',0)
              ELSE
                 CALL s_transaction_end('N',0)
              END IF              
              #150326--POLLY--ADD(S)
              CALL cl_ask_confirm3("aic-00130","")
              DELETE FROM aicp120_tmp  
              CALL aicp120_b_fill()
              CALL aicp120_fetch()
              CALL aicp120_process_fetch()
              EXIT DIALOG
               #150326--POLLY--ADD(E)
            END IF                                               #20150324 POLLY ADD
         #end add-point
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      #(ver:22) ---start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:22) --- end ---
 
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #(ver:22) ---start---
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         #(ver:22) --- end ---
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="aicp120.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aicp120_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   IF NOT aicp120_requery_chk() THEN
      RETURN
   END IF
   #end add-point
        
   LET g_error_show = 1
   CALL aicp120_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
   #add-point:cs段after_query name="query.cs_after_query"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aicp120.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aicp120_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(g_wc) THEN
      LEt g_wc = " 1=1 "
   END IF
   
   LET g_sql = "SELECT 'N',xmdadocdt,xmda004,pmaal003,xmda002,ooag011, ",   
               "       xmda003,t2.ooefl003,xmdadocno,xmddseq,xmddseq1, ",       
               "       xmddseq2,xmdd001,imaal003,imaal004,xmdd002, ",        
               "       xmdcunit,t1.ooefl003,xmdd006,xmdd011,xmdd035 ",
               "  FROM xmdd_t ",
               "          LEFT OUTER JOIN imaal_t ON imaalent = xmddent AND imaal001 = xmdd001 ",
               "       ,xmdc_t ",
               "          LEFT OUTER JOIN ooefl_t t1 ON ooeflent = xmdcent AND ooefl001 = xmdcunit AND ooefl002 = '",g_dlang,"' ",
               "       ,xmda_t ",
               "          LEFT OUTER JOIN pmaal_t ON pmaalent = xmdaent AND pmaal001 = xmda004 AND pmaal002 = '",g_dlang,"' ",
               "          LEFT OUTER JOIN ooag_t ON ooagent = xmdaent AND ooag001 = xmda002 ",
               "          LEFT OUTER JOIN ooefl_t t2 ON ooeflent = xmdaent AND ooefl001 = xmda003 AND ooefl002 = '",g_dlang,"' ",
               " WHERE xmddent = xmdcent AND xmdddocno = xmdcdocno AND xmddseq = xmdcseq ",
               "   AND xmdcent = xmdaent AND xmdcdocno = xmdadocno ",
               "   AND xmdaent = ? AND xmdasite = '",g_site,"' ",
               "   AND xmda005 = '1' AND xmda006 = '1' AND xmda030 = 'N' AND xmdastus = 'Y' ",
               "   AND COALESCE(xmdd006,0) - COALESCE(xmdd035,0) > 0 ",
               "   AND ",g_wc CLIPPED,
               " ORDER BY xmdadocdt,xmda004,xmda002,xmdadocno "

   DISPLAY "Source sql: ",g_sql
   #end add-point
 
   PREPARE aicp120_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aicp120_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   CALL g_detail2_d.clear()
   CALL g_detail3_d.clear()
   CALL g_detail4_d.clear()
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
      g_detail_d[l_ac].sel         ,
      g_detail_d[l_ac].xmdadocdt   ,g_detail_d[l_ac].xmda004       ,g_detail_d[l_ac].xmda004_desc,   
      g_detail_d[l_ac].xmda002     ,g_detail_d[l_ac].xmda002_desc  ,g_detail_d[l_ac].xmda003,        
      g_detail_d[l_ac].xmda003_desc,g_detail_d[l_ac].xmdadocno     ,g_detail_d[l_ac].xmddseq,        
      g_detail_d[l_ac].xmddseq1    ,g_detail_d[l_ac].xmddseq2      ,g_detail_d[l_ac].xmdd001,        
      g_detail_d[l_ac].xmdd001_desc,g_detail_d[l_ac].xmdd001_desc_1,g_detail_d[l_ac].xmdd002,        
      g_detail_d[l_ac].xmdcunit    ,g_detail_d[l_ac].xmdcunit_desc ,g_detail_d[l_ac].xmdd006,        
      g_detail_d[l_ac].xmdd011     ,g_detail_d[l_ac].xmdd035        
   #end add-point
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充 name="b_fill.foreach_iside"
      
      #end add-point
      
      CALL aicp120_detail_show()      
 
      LET l_ac = l_ac + 1
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
      
   END FOREACH
   LET g_error_show = 0
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.other_table"
   
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aicp120_sel
   
   LET l_ac = 1
   CALL aicp120_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp120.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aicp120_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   DEFINE l_success       LIKE type_t.num5
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   CALL g_detail2_d.clear()
   IF g_detail_idx = 0 THEN
      LET g_detail_idx = 1
   END IF
   
   LET g_sql = "SELECT icaj006,icaal003,icaj005, ",  
               "       icaj007,icaj008,icaj009,icaj010,icaj011, ",      
               "       icaj001,icaj002,icaj003,icaj004,icajsite ",
               "  FROM (SELECT icajent,icaj001,icaj002,icaj003,icaj004, ",
               "               icaj005,icaj006,icaj007,icaj008,icaj009, ",
               "               icaj010,icaj011,icajsite ",
               "          FROM icaj_t ",
               "         UNION ALL ",
               "        SELECT icajent,icaj001,icaj002,icaj003,icaj004, ",
               "               icaj005,icaj006,icaj007,icaj008,icaj009, ",
               "               icaj010,icaj011,icajsite ",
               "          FROM aicp120_tmp) ",
               "          LEFT OUTER JOIN icaal_t ON icaalent = icajent AND icaal001 = icaj006 AND icaal002 = '",g_dlang,"' ",
               " WHERE icajent = ",g_enterprise,
               "   AND icaj001 = '",g_detail_d[g_detail_idx].xmdadocno,"' ",
               "   AND icaj002 = ",g_detail_d[g_detail_idx].xmddseq,
               "   AND icaj003 = ",g_detail_d[g_detail_idx].xmddseq1,
               "   AND icaj004 = ",g_detail_d[g_detail_idx].xmddseq2,
               " ORDER BY icaj006,icaj008 "
   
   PREPARE aicp120_b_fill_pre2 FROM g_sql
   DECLARE aicp120_b_fill_cur2 CURSOR FOR aicp120_b_fill_pre2
   
   LET l_ac = 1
   FOREACH aicp120_b_fill_cur2 INTO g_detail2_d[l_ac].icaj006,g_detail2_d[l_ac].icaj006_desc,g_detail2_d[l_ac].icaj005,     
                                    g_detail2_d[l_ac].icaj007,g_detail2_d[l_ac].icaj008     ,g_detail2_d[l_ac].icaj009,      
                                    g_detail2_d[l_ac].icaj010,g_detail2_d[l_ac].icaj011     ,g_detail2_d[l_ac].icaj001,     
                                    g_detail2_d[l_ac].icaj002,g_detail2_d[l_ac].icaj003     ,g_detail2_d[l_ac].icaj004,      
                                    g_detail2_d[l_ac].icajsite     


      #取icab003,icab003_desc
      CALL aicp120_icaj006_default() RETURNING l_success
      
      LET g_detail2_d[l_ac].l_icaj007_desc = s_aooi200_get_slip_desc(g_detail2_d[l_ac].icaj007)

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
   CALL g_detail2_d.deleteElement(l_ac)
   LET g_detail2_cnt = l_ac - 1 
   DISPLAY g_detail2_cnt TO FORMONLY.cnt   
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aicp120.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aicp120_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp120.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aicp120_filter()
   #add-point:filter段define(客製用) name="filter.define_customerization"
   
   #end add-point    
   #add-point:filter段define name="filter.define"
   
   #end add-point
   
   DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
      ON UPDATE
 
   END DISPLAY
 
   LET l_ac = 1
   LET g_detail_cnt = 1
   #add-point:filter段define name="filter.detail_cnt"
   
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL aicp120_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="aicp120.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aicp120_filter_parser(ps_field)
   #add-point:filter段define(客製用) name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define name="filter_parser.define"
   
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
 
{<section id="aicp120.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aicp120_filter_show(ps_field,ps_object)
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.", ps_object
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = aicp120_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aicp120.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 多角流程代碼帶值
# Memo...........: 帶值：最終站據點,採購單別
# Usage..........: CALL aicp120_icaj006_default()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 2014/11/13 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp120_icaj006_default()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_icab002   LIKE icab_t.icab002
   DEFINE l_icab003   LIKE icab_t.icab003
   DEFINE l_icac010   LIKE icac_t.icac010
   
   LET r_success = TRUE
   LET l_icab002 = ''
   LET l_icab003 = ''
   LET l_icac010 = ''
   
   SELECT icab002,icab003 INTO l_icab002,l_icab003
     FROM icab_t
    WHERE icabent = g_enterprise
      AND icab001 = g_detail2_d[l_ac].icaj006
      AND icab002 = (SELECT MAX(icab002)
                       FROM icab_t t2
                      WHERE icabent = g_enterprise
                        AND icab001 = g_detail2_d[l_ac].icaj006)
   IF SQLCA.sqlcode THEN                     
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success  
   END IF  
   
   IF cl_null(l_icab002) THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  'aic-00107'
      LET g_errparam.extend =  g_detail2_d[l_ac].icaj006
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success      
   ELSE
      LET g_detail2_d[l_ac].icab003 = l_icab003
      LET g_detail2_d[l_ac].icab003_desc = s_desc_get_department_desc(l_icab003)
      IF cl_null(g_detail2_d[l_ac].icaj007) AND cl_null(g_detail2_d[l_ac].icaj008)  THEN  #20150414  POLLY ADD
         #預設採購單別為第0站的採購單別
         SELECT icac010 INTO l_icac010
           FROM icac_t
          WHERE icacent = g_enterprise
            AND icac001 = g_detail2_d[l_ac].icaj006
            AND icac002 = '0'
         #IF SQLCA.sqlcode THEN                     
         #   LET r_success = FALSE
         #   INITIALIZE g_errparam TO NULL
         #   LET g_errparam.code =  SQLCA.sqlcode
         #   LET g_errparam.popup = TRUE
         #   CALL cl_err()
         #   RETURN r_success  
         #END IF       
         LET g_detail2_d[l_ac].icaj007 = l_icac010
         LET g_detail2_d[l_ac].l_icaj007_desc = s_aooi200_get_slip_desc(g_detail2_d[l_ac].icaj007)
      END IF                                       #20150414  POLLY ADD    
   END IF   
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 取多角流程第0站據點及據點的單據別參照表號
# Memo...........:
# Usage..........: CALL aicp120_get_ooef004()
#                  RETURNING r_icab003,r_ooef004
# Return code....: r_ooef003   據點編號
#                  r_ooef004   單據別參照表
# Date & Author..: 2014/11/14 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp120_get_ooef004()
    DEFINE r_icab003   LIKE icab_t.icab003
    DEFINE r_ooef004   LIKE ooef_t.ooef004
    
    LET r_icab003 = ''
    LET r_ooef004 = ''
    
    SELECT icab003 INTO r_icab003
      FROM icab_t 
     WHERE icabent = g_enterprise
       AND icab001 = g_detail2_d[l_ac].icaj006
       AND icab002 = '0'
    
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = r_icab003
    #160902-00048#1-s-mod
    #CALL ap_ref_array2(g_ref_fields,"SELECT ooef004,ooef019 FROM ooef_t WHERE ooef001=? ","") RETURNING g_rtn_fields
    CALL ap_ref_array2(g_ref_fields,"SELECT ooef004,ooef019 FROM ooef_t WHERE ooefent='"||g_enterprise||"' AND ooef001=? ","") RETURNING g_rtn_fields
    #160902-00048#1-e-mod
    LET r_ooef004 = g_rtn_fields[1]
    
    RETURN r_icab003,r_ooef004
END FUNCTION

################################################################################
# Descriptions...: 重新查詢前檢查有無輸入分配資訊
# Memo...........: 如有輸入分配資訊則詢問是否重查
# Usage..........: CALL aicp120_requery_chk()
#                  RETURNING r_success
# Return code....: r_success  檢查結果,TRUE則不需要且繼續執行查詢,FALSE表示需要保留暫存檔資料
# Date & Author..: 2014/11/14 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp120_requery_chk()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_cnt       LIKE type_t.num5
   
   LET r_success = TRUE
   LET l_cnt = 0
  
   #--20150331--POLLY--ADD--(S)  
   SELECT COUNT(*) INTO l_cnt
     FROM aicp120_tmp
   #--20150331--POLLY--ADD--(E)
   IF l_cnt > 0 THEN
      IF cl_ask_confirm("aic-00105") THEN
         DELETE FROM aicp120_tmp                  
      ELSE
         LET r_success = FALSE
      END IF
   ELSE
      IF g_detail_idx2 > 0 THEN
         #IF NOT cl_null(g_detail2_d[g_detail_idx2].icaj006) THEN                                                  #20150331 POLLY MARK
         IF NOT cl_null(g_detail2_d[g_detail_idx2].icaj006) AND cl_null(g_detail2_d[g_detail_idx2].icaj008) THEN   #20150331 POLLY ADD
            IF cl_ask_confirm("aic-00105") THEN
               DELETE FROM aicp120_tmp
            ELSE   
               LET r_success = FALSE          
            END IF        
         END IF           
      END IF      
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 將處理結果顯示在畫面上
# Memo...........:
# Usage..........: CALL aicp120_process_fetch()
# Date & Author..: 2014/11/18 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp120_process_fetch()
   DEFINE l_ac_s  LIKE type_t.num5
   DEFINE l_ac_e  LIKE type_t.num5
   
   CALL g_detail3_d.clear()
   CALL g_detail4_d.clear()
   
   LET l_ac_s = 0
   LET l_ac_e = 0
   
   FOR l_ac = 1 TO g_process.getLength()
      IF g_process[l_ac].process = 'Y' THEN
         LET l_ac_s = l_ac_s + 1
         LET g_detail3_d[l_ac_s].l_xmdadocdt     = g_process[l_ac].xmdadocdt       
         LET g_detail3_d[l_ac_s].l_xmda004       = g_process[l_ac].xmda004    
         LET g_detail3_d[l_ac_s].l_xmda004_desc  = s_desc_get_trading_partner_full_desc(g_process[l_ac].xmda004) 
         LET g_detail3_d[l_ac_s].l_xmda002       = g_process[l_ac].xmda002    
         LET g_detail3_d[l_ac_s].l_xmda002_desc  = s_desc_get_person_desc(g_process[l_ac].xmda002)
         LET g_detail3_d[l_ac_s].l_xmda003       = g_process[l_ac].xmda003   
         LET g_detail3_d[l_ac_s].l_xmda003_desc  = s_desc_get_department_desc(g_process[l_ac].xmda003)
         LET g_detail3_d[l_ac_s].l_xmdadocno     = g_process[l_ac].xmdadocno  
         LET g_detail3_d[l_ac_s].l_xmdcunit      = g_process[l_ac].xmdcunit   
         LET g_detail3_d[l_ac_s].l_xmdcunit_desc = s_desc_get_department_desc(g_process[l_ac].xmdcunit)
         LET g_detail3_d[l_ac_s].l_xmdd011       = g_process[l_ac].xmdd011
         LET g_detail3_d[l_ac_s].l_icaj006       = g_process[l_ac].icaj006
         LET g_detail3_d[l_ac_s].l_icaj006_desc  = s_desc_get_icaa001_desc(g_process[l_ac].icaj006)        
      ELSE
         LET l_ac_e = l_ac_e + 1
         LET g_detail4_d[l_ac_e].l_xmdadocdt_1     = g_process[l_ac].xmdadocdt        
         LET g_detail4_d[l_ac_e].l_xmda004_1       = g_process[l_ac].xmda004     
         LET g_detail4_d[l_ac_e].l_xmda004_1_desc  = s_desc_get_trading_partner_full_desc(g_process[l_ac].xmda004)   
         LET g_detail4_d[l_ac_e].l_xmda002_1       = g_process[l_ac].xmda002     
         LET g_detail4_d[l_ac_e].l_xmda002_1_desc  = s_desc_get_person_desc(g_process[l_ac].xmda002) 
         LET g_detail4_d[l_ac_e].l_xmda003_1       = g_process[l_ac].xmda003    
         LET g_detail4_d[l_ac_e].l_xmda003_1_desc  = s_desc_get_department_desc(g_process[l_ac].xmda003) 
         LET g_detail4_d[l_ac_e].l_xmdadocno1_     = g_process[l_ac].xmdadocno   
         LET g_detail4_d[l_ac_e].l_xmdcunit_1      = g_process[l_ac].xmdcunit    
         LET g_detail4_d[l_ac_e].l_xmdcunit_1_desc = s_desc_get_department_desc(g_process[l_ac].xmdcunit) 
         LET g_detail4_d[l_ac_e].l_xmdd011_1       = g_process[l_ac].xmdd011 
         LET g_detail4_d[l_ac_e].l_icaj006_1       = g_process[l_ac].icaj006 
         LET g_detail4_d[l_ac_e].l_icaj006_1_desc  = s_desc_get_icaa001_desc(g_process[l_ac].icaj006)         
         LET g_detail4_d[l_ac_e].l_errmsg          = g_process[l_ac].errmsg  
      END IF
   END FOR   
END FUNCTION

################################################################################
# Descriptions...: 執行前檢查
# Memo...........: 因按執行時，不會走AFTR ROW 、ON ROW CHANGE 段無法即時寫入TEMP TABLE
# Usage..........: CALL aicp120_execute_chk()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success    TRUE/FALSE
#                : 
# Date & Author..: 20150324 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp120_execute_chk()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_icab003   LIKE icab_t.icab003
   DEFINE l_ooef004   LIKE ooef_t.ooef004
   DEFINE l_qty       LIKE type_t.num5  
   
       LET r_success = TRUE

       #因按執行時，不會走AFTR ROW 、ON ROW CHANGE 段無法即時寫入TEMP TABLE，所以在此段做處理   
       IF g_detail_idx2 > 0 THEN
          #檢查
          IF cl_null(g_detail2_d[g_detail_idx2].icaj005) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'acr-00015'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()
             LET r_success = FALSE
             RETURN r_success
          ELSE
             CALL s_aicp120_allocation_chk(g_detail2_d[g_detail_idx2].icaj001,g_detail2_d[g_detail_idx2].icaj002,
                                           g_detail2_d[g_detail_idx2].icaj003,g_detail2_d[g_detail_idx2].icaj004,
                                           g_detail2_d[g_detail_idx2].icaj006,g_detail2_d[g_detail_idx2].seq)
                RETURNING l_qty                                               
             IF g_detail2_d[g_detail_idx2].icaj005 > l_qty THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code =  'aic-00109'
                LET g_errparam.replace[1] = l_qty
                LET g_errparam.popup = TRUE
                CALL cl_err()                   
                LET g_detail2_d[g_detail_idx2].icaj005 = g_detail2_d_t.icaj005
                LET r_success = FALSE
                RETURN r_success
             END IF        
          END IF
          IF cl_null(g_detail2_d[g_detail_idx2].icaj007) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'acr-00015'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()
             LET r_success = FALSE
             RETURN r_success
          ELSE
             LET l_icab003 = ''
             LET l_ooef004 = ''
             CALL aicp120_get_ooef004() RETURNING l_icab003,l_ooef004
             IF NOT s_aooi200_chk_slip(l_icab003,'',g_detail2_d[g_detail_idx2].icaj007,'apmt500') THEN
                LET g_detail2_d[g_detail_idx2].icaj007 = g_detail2_d_t.icaj007
                LET g_detail2_d[g_detail_idx2].l_icaj007_desc = s_aooi200_get_slip_desc(g_detail2_d[g_detail_idx2].icaj007)
                LET r_success = FALSE
                RETURN r_success
             END IF          
          END IF
          LET l_cnt = 0
          SELECT COUNT(*) INTO l_cnt
            FROM aicp120_tmp
           WHERE icaj001 = g_detail2_d[g_detail_idx2].icaj001
             AND icaj002 = g_detail2_d[g_detail_idx2].icaj002
             AND icaj003 = g_detail2_d[g_detail_idx2].icaj003
             AND icaj004 = g_detail2_d[g_detail_idx2].icaj004
             AND seq = g_detail2_d[g_detail_idx2].seq
      
           IF l_cnt = 0 THEN
             INSERT INTO aicp120_tmp(icajent,icaj001,icaj002,icaj003,icaj004,
                                     icaj005,icaj006,icaj007,icajsite,chk_process,seq)
                  VALUES(g_enterprise,
                         g_detail2_d[g_detail_idx2].icaj001,g_detail2_d[g_detail_idx2].icaj002,g_detail2_d[g_detail_idx2].icaj003,
                         g_detail2_d[g_detail_idx2].icaj004,g_detail2_d[g_detail_idx2].icaj005,g_detail2_d[g_detail_idx2].icaj006,
                         g_detail2_d[g_detail_idx2].icaj007,g_detail2_d[g_detail_idx2].icajsite,'Y',g_detail2_d[g_detail_idx2].seq)                  
              IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = "INSERT aicp120_tmp"
                LET g_errparam.code   = SQLCA.sqlcode
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                LET r_success = FALSE
             END IF
          ELSE
             UPDATE aicp120_tmp
                SET icaj005 = g_detail2_d[g_detail_idx2].icaj005,
                    icaj006 = g_detail2_d[g_detail_idx2].icaj006,
                    icaj007 = g_detail2_d[g_detail_idx2].icaj007
               WHERE icajent = g_enterprise
                 AND icaj001 = g_detail2_d[g_detail_idx2].icaj001
                 AND icaj002 = g_detail2_d[g_detail_idx2].icaj002
                 AND icaj003 = g_detail2_d[g_detail_idx2].icaj003
                 AND icaj004 = g_detail2_d[g_detail_idx2].icaj004
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = "UPDATE aicp120_tmp"
                LET g_errparam.code   = SQLCA.sqlcode
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                LET r_success = FALSE
             END IF
          END IF      
       END IF
       LET l_cnt = 0
       SELECT COUNT(*) INTO l_cnt
         FROM aicp120_tmp
       IF l_cnt = 0 THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'abm-00059'
          LET g_errparam.extend = ''
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET r_success = FALSE
          RETURN r_success                 
       END IF
       RETURN r_success 
END FUNCTION

#end add-point
 
{</section>}
 
