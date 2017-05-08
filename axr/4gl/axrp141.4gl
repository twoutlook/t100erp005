#該程式未解開Section, 採用最新樣板產出!
{<section id="axrp141.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0014(2015-11-30 10:54:34), PR版次:0014(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000058
#+ Filename...: axrp141
#+ Description: 集團銷售多角帳款產生作業
#+ Creator....: 02114(2015-04-20 11:24:58)
#+ Modifier...: 02114 -SD/PR- 00000
 
{</section>}
 
{<section id="axrp141.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#151125-00006#1   2015/12/07  By 06862    生成單據后立即審核，立即拋轉傳票
#160318-00005#51  2016/03/29  By 07959    將重複內容的錯誤訊息置換為公用錯誤訊息
#160401-00009#2   2016/04/01  By 02114    1.採購多角可立帳的採購單性質判斷更改。依據azzi600 SCC_2060有設定可產生帳者
#                                           列為QBE下拉選項,作為串連條件pmds000的依據
#                                         2.批次產生時, 若有一筆帳款產生不成功，則過程中的單據處理，必須回滾刪除。
#160714-00029#2   2016/07/25  By 02114    多角財務帳款產生應付憑單時，取設定的[應付帳款類別]  apca007=icae020
#160727-00019#33   2016/08/11 By 08742     系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉
#                                          Mod axrp133_xmdk_tmp --> axrp133_tmp01
#161024-00034#1   161031      By albireo   s_axrp133修改傳出參數,但漏改多角axrp141 aapp141
#161123-00048#1   161124      By 08729     開窗增加過濾據點 
#161227-00049#1   2016/12/27  By 01531     多角拋單問題_立帳資料錯誤
#170104-00022#1   2017/01/04  By 02114     不應該呈現走出貨簽收的出貨單
#170110-00009#1   2017/01/10  By 02114     单身2也不應該呈現走出貨簽收的出貨單
#170116-00036#1   2017/01/16  By 02114     用户无组织无权限时,产生账款失败后,不会把执行成功的单据删除
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
        icaa012          LIKE icaa_t.icaa012,
        date             LIKE xrca_t.xrcadocdt,
        comb             LIKE type_t.chr1,
        icab005          LIKE icab_t.icab005,      #141114-00010#2 add lujh
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
      sel               LIKE type_t.chr1,
      xmdkdocno         LIKE xmdk_t.xmdkdocno,
      xmdkdocdt         LIKE xmdk_t.xmdkdocdt,
      xmdk007           LIKE xmdk_t.xmdk007,
      xmdk007_desc      LIKE type_t.chr500,
      xmdk009           LIKE xmdk_t.xmdk009,
      xmdk009_desc      LIKE type_t.chr500,
      xmdk008           LIKE xmdk_t.xmdk008,
      xmdk008_desc      LIKE type_t.chr500,
      xmdk003           LIKE xmdk_t.xmdk003,
      xmdk003_desc      LIKE type_t.chr500,
      xmdk004           LIKE xmdk_t.xmdk004,
      xmdk004_desc      LIKE type_t.chr500,
      xmdk002           LIKE xmdk_t.xmdk002,
      xmdk035           LIKE xmdk_t.xmdk035,
      invoice           LIKE type_t.chr500,
      xmdk044           LIKE xmdk_t.xmdk044
                     END RECORD
DEFINE g_detail_d_t     type_g_detail_d

TYPE type_g_detail2_d RECORD
      l_icab002         LIKE icab_t.icab002,
      l_xmdksite        LIKE xmdk_t.xmdksite,
      l_xmdksite_desc   LIKE type_t.chr80,
      l_xmdk000         LIKE xmdk_t.xmdk000,
      l_xmdkdocno       LIKE xmdk_t.xmdkdocno,
      l_xmdk008         LIKE xmdk_t.xmdk008,
      l_xmdk008_desc    LIKE type_t.chr80,
      l_xmdk016         LIKE xmdk_t.xmdk016,
      l_xmdk051         LIKE xmdk_t.xmdk051,
      l_xmdk053         LIKE xmdk_t.xmdk053,
      l_xmdk052         LIKE xmdk_t.xmdk052,
      l_xmdk010         LIKE xmdk_t.xmdk010,
      l_xmdk010_desc    LIKE type_t.chr80,
      l_xmdk012         LIKE xmdk_t.xmdk012,
      l_xmdk012_desc    LIKE type_t.chr80,
      l_xmdk015         LIKE xmdk_t.xmdk015,
      l_xmdk015_desc    LIKE type_t.chr80,
      l_xmdk032         LIKE xmdk_t.xmdk032,
      l_xmdk035         LIKE xmdk_t.xmdk035,
      l_xmdk044         LIKE xmdk_t.xmdk044
                      END RECORD
DEFINE g_detail2_d      DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_detail2_cnt    LIKE type_t.num5
DEFINE g_rec_b          LIKE type_t.num5
                      
TYPE type_g_detail3_d RECORD
      docno_s           STRING,
      icab002           LIKE icab_t.icab002,
      site              LIKE xmdk_t.xmdksite,
      site_desc         LIKE type_t.chr80,
      docno             LIKE xmdk_t.xmdkdocno,
      xrca047           LIKE xrca_t.xrca047,
      xrca108           LIKE xrca_t.xrca108
                      END RECORD
DEFINE g_detail3_d      DYNAMIC ARRAY OF type_g_detail3_d
DEFINE g_detail3_cnt    LIKE type_t.num5

TYPE type_g_detail4_d RECORD
      docno_f           STRING,
      icab002_f         LIKE icab_t.icab002,
      site_f            LIKE xmdk_t.xmdksite,
      site_f_desc       LIKE type_t.chr80,
      gzze001           LIKE gzze_t.gzze001,
      gzze003           LIKE gzze_t.gzze003  
                      END RECORD
DEFINE g_detail4_d      DYNAMIC ARRAY OF type_g_detail4_d
DEFINE g_detail4_cnt    LIKE type_t.num5

DEFINE g_success_cnt    LIKE type_t.num5
DEFINE g_fail_cnt       LIKE type_t.num5

DEFINE g_xmdk000        LIKE xmdk_t.xmdk000
DEFINE g_input          type_parameter
TYPE type_xmdk RECORD
               order       LIKE type_t.chr200,
               xmdldocno   LIKE xmdl_t.xmdldocno,
               xmdlseq     LIKE xmdl_t.xmdlseq,
               xrcb007     LIKE xrcb_t.xrcb007,
               xmdk047     LIKE xmdk_t.xmdk047   #161024-00034#1 add
               END RECORD
DEFINE g_xmdk_d DYNAMIC ARRAY OF type_xmdk

TYPE type_xmdk2 RECORD
                docno       LIKE xmdk_t.xmdkdocno, 
                xmdk000     LIKE xmdk_t.xmdk000,
                xmdk035     LIKE xmdk_t.xmdk035,
                xmdk044     LIKE xmdk_t.xmdk044
                END RECORD
DEFINE g_xmdk2_d DYNAMIC ARRAY OF type_xmdk2

TYPE type_xmdk3 RECORD
                xmdk035     LIKE xmdk_t.xmdk035,
                xmdk044     LIKE xmdk_t.xmdk044,
                xmdk008     LIKE xmdk_t.xmdk008
                END RECORD
DEFINE g_xmdk3_d DYNAMIC ARRAY OF type_xmdk3

TYPE type_icab RECORD
                icab002     LIKE icab_t.icab002, 
                icab003     LIKE icab_t.icab003,
                icab001     LIKE icab_t.icab001       #141114-00010#2 add lujh
                END RECORD
DEFINE g_icab_d DYNAMIC ARRAY OF type_icab
DEFINE g_sql_ctrl           STRING                    #161123-00048#1-add
DEFINE g_comp               LIKE glaa_t.glaacomp      #161123-00048#1-add
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axrp141.main" >}
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
   CALL cl_ap_init("axr","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   CALL axrp141_create_temp_table()
   
   IF NOT cl_null(g_argv[1]) THEN
      LET g_bgjob = 'Y'
   END IF
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      IF NOT cl_null(g_argv[1]) THEN
         LET g_wc = " xmdkdocno = '",g_argv[1],"' "
         CALL axrp141_query()
         UPDATE axrp141_tmp 
            SET sel = 'Y'
         CALL axrp141_process()
      END IF
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrp141 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrp141_init()   
 
      #進入選單 Menu (="N")
      CALL axrp141_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axrp141
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   DROP TABLE axrp141_tmp;
   DROP TABLE axrp141_tmp1;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axrp141.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axrp141_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   DEFINE l_success       LIKE type_t.num5
   #160401-00009#2--add--str--lujh
   DEFINE l_sql           STRING
   DEFINE l_str           STRING
   DEFINE l_gzcb002       LIKE gzcb_t.gzcb002
   #160401-00009#2--add--end--lujh
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   #CALL cl_set_combo_scc_part('xmdk000','2077','1,2,6')     #160401-00009#2 mark lujh
   #160401-00009#2--add--str--lujh
   LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '2077' AND gzcb003 = 'Y'"
   PREPARE axrp141_xmdk000_prep FROM l_sql
   DECLARE axrp141_xmdk000_curs CURSOR FOR axrp141_xmdk000_prep
   LET l_str = Null
   LET l_gzcb002 = Null
   FOREACH axrp141_xmdk000_curs INTO l_gzcb002
      IF cl_null(l_str) THEN LET l_str = l_gzcb002 CONTINUE FOREACH END IF
      LET l_str = l_str,",",l_gzcb002
   END FOREACH
   CALL cl_set_combo_scc_part('xmdk000','2077',l_str)
   #160401-00009#2--add--end--lujh
   
   CALL cl_set_combo_scc_part('xrde002','8306',l_str)
   CALL cl_set_combo_scc_part('xmdk002','2063','1,2,3,4')
   CALL cl_set_combo_scc('b_xmdk002','2063')
   CALL cl_set_combo_scc('icaa012','2507')
   CALL cl_set_combo_scc('l_xmdk000','2508')  
   CALL s_axrp133_create_tmp() RETURNING l_success  
   CALL s_axrp133_create_success_tmp() RETURNING l_success  
   CALL s_aapp131_cre_tmp()
   CALL s_voucher_cre_ar_tmp_table() RETURNING l_success
   CALL s_fin_create_account_center_tmp()    #帳務中心   
   
   LET g_errshow = 1
   IF cl_null(g_bgjob) THEN
      LET g_bgjob = 'N'
   END IF
   #161123-00048#1-add
   SELECT ooef017 INTO g_comp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_comp) RETURNING g_sub_success,g_sql_ctrl
   #161123-00048#1-add
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axrp141.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrp141_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_gzcbl004   LIKE gzcbl_t.gzcbl004
   DEFINE l_cnt        LIKE type_t.num5
   DEFINE ls_scc       STRING    #170104-00022#1 add lujh
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_wc = "1=1"
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axrp141_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         INPUT g_xmdk000 FROM xmdk000
            BEFORE INPUT
               
         END INPUT  
         
         
         CONSTRUCT BY NAME g_wc ON xmdkdocno,xmdkdocdt,xmdk007,xmdk009,xmdk008,xmdk003,xmdk004,   
                                   xmdk002,xmdk035,xmdkownid,xmdkcrtid
         
            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD xmdkdocno
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_xmdk000
               LET g_qryparam.where = "  xmdk035 IS NOT NULL"    #20151215 add lujh
               #161123-00048#1-add(s)
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_qryparam.where," AND EXISTS (SELECT 1 FROM pmaa_t ",
                                                          "              WHERE pmaaent = ",g_enterprise,
                                                          "                AND ",g_sql_ctrl,
                                                          "                AND pmaaent = xmdkent ",
                                                          "                AND pmaa001 = xmdk007 )"
               END IF
               #161123-00048#1-add(e)
               #170104-00022#1--add--str--lujh
               CALL s_axrp133_get_scc('xmdk000','2077') RETURNING ls_scc   
               LET g_qryparam.where = g_qryparam.where," AND ",ls_scc CLIPPED  
               #170104-00022#1--add--end--lujh
               CALL q_xmdkdocno_2()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdkdocno  #顯示到畫面上
               NEXT FIELD xmdkdocno                     #返回原欄位 
               
            ON ACTION controlp INFIELD xmdk007
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_site
               #161123-00048#1-add(s)
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_sql_ctrl
               END IF
               #161123-00048#1-add(e)
               CALL q_pmaa001_6()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk007    #顯示到畫面上
               NEXT FIELD xmdk007                       #返回原欄位                
            
            ON ACTION controlp INFIELD xmdk009
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_site
               #161123-00048#1-add(s)
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_sql_ctrl
               END IF
               #161123-00048#1-add(e)
               CALL q_pmaa001_6()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk009    #顯示到畫面上
               NEXT FIELD xmdk009                       #返回原欄位  
               
            ON ACTION controlp INFIELD xmdk008
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_site
               #161123-00048#1-add(s)
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_sql_ctrl
               END IF
               #161123-00048#1-add(e)
               CALL q_pmaa001_6()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk008    #顯示到畫面上
               NEXT FIELD xmdk008   

            ON ACTION controlp INFIELD xmdk003
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk003    #顯示到畫面上
               NEXT FIELD xmdk003
               
            ON ACTION controlp INFIELD xmdk004
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooeg001()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk004    #顯示到畫面上
               NEXT FIELD xmdk004      
               
            ON ACTION controlp INFIELD xmdk035
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_xmdk000   #151203-00018#1 add lujh
               CALL q_xmdk035()                  #151203-00018#1 add lujh
               #CALL q_icaa001()                       #呼叫開窗    #151203-00018#1 mark lujh
               DISPLAY g_qryparam.return1 TO xmdk035    #顯示到畫面上
               NEXT FIELD xmdk035
               
            ON ACTION controlp INFIELD xmdkownid
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdkownid  #顯示到畫面上
               NEXT FIELD xmdkownid
               
            ON ACTION controlp INFIELD xmdkcrtid
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdkcrtid  #顯示到畫面上
               NEXT FIELD xmdkcrtid        
               
         END CONSTRUCT
           
         INPUT BY NAME g_input.icaa012,g_input.date,g_input.comb,g_input.icab005     #141114-00010#2 add g_input.icab005 lujh
               ATTRIBUTE(WITHOUT DEFAULTS)

            BEFORE INPUT

            ON CHANGE icaa012
               IF g_input.icaa012 = '1' THEN 
                   CALL cl_set_comp_required('date',FALSE)
               ELSE
                   CALL cl_set_comp_required('date',TRUE)
               END IF
  
         END INPUT 
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT ARRAY g_detail_d FROM s_detail1.*
            ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                      INSERT ROW = FALSE,
                      DELETE ROW = FALSE,
                      APPEND ROW = FALSE)
                      
            BEFORE INPUT
               IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN
                  CALL FGL_SET_ARR_CURR(g_detail_d.getLength()+1)
                  LET g_insert = 'N'
               END IF
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_master_idx = l_ac
               DISPLAY l_ac TO FORMONLY.h_index
               CALL axrp141_fetch()
               LET g_detail_d_t.* = g_detail_d[l_ac].*
               LET g_errshow = '1'

            ON CHANGE b_sel
               #更新Temp_table
               UPDATE axrp141_tmp
                  SET sel = g_detail_d[l_ac].sel
                WHERE xmdkdocno = g_detail_d[l_ac].xmdkdocno

               
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_detail2_d TO s_detail2.* ATTRIBUTE(COUNT = g_detail2_cnt)
            
             BEFORE DISPLAY
             
             BEFORE ROW
                LET l_ac = DIALOG.getCurrentROW("s_detail2")
                DISPLAY l_ac TO FORMONLY.idx
                
         END DISPLAY
         
         DISPLAY ARRAY g_detail3_d TO s_detail3.* ATTRIBUTE(COUNT = g_detail3_cnt)
            
             BEFORE DISPLAY            
             
             BEFORE ROW
                LET l_ac = DIALOG.getCurrentRow("s_detail3")
                DISPLAY l_ac TO FORMONLY.h_index
                
         END DISPLAY

         DISPLAY ARRAY g_detail4_d TO s_detail4.* ATTRIBUTE(COUNT = g_detail4_cnt)
            
             BEFORE DISPLAY            

             BEFORE ROW
                LET l_ac = DIALOG.getCurrentRow("s_detail4")
                DISPLAY l_ac TO FORMONLY.h_index
                
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
            CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
            CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            
            #IF g_detail_d.getLength() <= 0 THEN
            #   NEXT FIELD xmda005
            #END IF
            #141114-00010#2--add--str--lujh
            CALL g_detail2_d.clear()
            LET g_wc = " 1=1 "    
            LET g_input.icab005 = 'N'  
            #141114-00010#2--add--end--lujh
            LET g_xmdk000 = '1'
            LET g_input.icaa012 = '1'
            LET g_input.date = g_today
            LET g_input.comb = '2'
            CALL cl_set_comp_required('date',FALSE)
            DISPLAY g_input.icaa012 TO icaa012
            DISPLAY g_input.date TO date
            DISPLAY g_input.comb TO comb
            DISPLAY g_input.icab005 TO icab005   #141114-00010#2 add lujh
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
            UPDATE axrp141_tmp
               SET sel = 'Y'
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
            UPDATE axrp141_tmp
               SET sel = 'N'
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  UPDATE axrp141_tmp
                     SET sel = 'Y'
                   WHERE xmdkdocno = g_detail_d[li_idx].xmdkdocno
               END IF
            END FOR
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  UPDATE axrp141_tmp
                     SET sel = 'N'
                   WHERE xmdkdocno = g_detail_d[li_idx].xmdkdocno
               END IF
            END FOR
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axrp141_filter()
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
            CALL axrp141_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL axrp141_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            CALL g_detail3_d.clear()
            CALL g_detail4_d.clear()
            
            IF g_input.icaa012 = '2' AND cl_null(g_input.date) THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00323'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CONTINUE DIALOG
            END IF
            
            LET l_cnt = ''
            SELECT COUNT(*) INTO l_cnt
              FROM axrp141_tmp
             WHERE sel = 'Y'
             
            IF cl_null(l_cnt) OR l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = '-400'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
            ELSE
               CALL axrp141_process()
               LET INT_FLAG = TRUE   
               CALL axrp141_query()
               LET INT_FLAG = FALSE  
            END IF

            CONTINUE WHILE

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
 
{<section id="axrp141.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axrp141_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   DEFINE ls_scc     STRING      #170104-00022#1 add lujh
   
   DELETE FROM axrp141_tmp;
   
   CALL s_axrp133_get_scc('xmdk000','2077') RETURNING ls_scc   #170104-00022#1 add lujh
   
   LET g_sql = "INSERT INTO axrp141_tmp ",
               "SELECT DISTINCT xmdkent,'N',xmdkdocno,xmdkdocdt,xmdk007,'',xmdk009,'',xmdk008,'',",
               "       xmdk003,'',xmdk004,'',xmdk002,xmdk035,'',xmdk044 ",
               "  FROM xmdk_t,xmdl_t",
               " WHERE xmdkent = ",g_enterprise,
               "   AND xmdkent = xmdlent ",
               "   AND xmdkdocno = xmdldocno ",
               "   AND xmdk000 = '",g_xmdk000,"'",
               "   AND ",g_wc,
               "   AND ",ls_scc CLIPPED,  #170104-00022#1 add lujh
               "   AND xmdkstus = 'S'",
               "   AND xmdksite = '",g_site,"'",   #141114-00010#2 mark lujh     #170110-00009#1 unmark lujh
               "   AND xmdl038 = 0 ",
               "   AND xmdk035 IS NOT NULL ",
               #141114-00010#2--mark--str--lujh
               #"   AND xmdk044 IN (SELECT icaa001",
               #"                     FROM icaa_t,icab_t",
               #"                    WHERE icaaent = icabent AND icaaent = ",g_enterprise,
               #"                      AND icaa001 = icab001",
               #"                      AND icaastus = 'Y'",
               #"                      AND icab002 = 0",
               #"                      AND icab003 = '",g_site,"')"
               #141114-00010#2--mark--end--lujh
               
               #151125-00018#2--add--str--lujh
               "   AND xmdk044 IN (SELECT icaa001",
               "                     FROM icaa_t,icab_t",
               "                    WHERE icaaent = icabent AND icaaent = ",g_enterprise,
               "                      AND icaa001 = icab001",
               "                      AND icaastus = 'Y'",
               "                      AND icab003 = '",g_site,"')"
               #151125-00018#2--add--end--lujh

   #151125-00018#2--mark--str--lujh
   ##141114-00010#2--add--str--lujh
   #IF g_input.icab005 = 'N' THEN 
   #   LET g_sql = g_sql,"   AND xmdk044 IN (SELECT icaa001",
   #                     "  FROM icaa_t,icab_t",
   #                     " WHERE icaaent = icabent AND icaaent = ",g_enterprise,
   #                     "   AND icaa001 = icab001",
   #                     "   AND icaastus = 'Y'",
   #                     "   AND icab002 = 0",
   #                     "   AND icab003 = '",g_site,"')"
   #ELSE
   #   LET g_sql = g_sql,"   AND xmdk044 IN (SELECT icaa001",
   #                     "  FROM icaa_t,icab_t",
   #                     " WHERE icaaent = icabent AND icaaent = ",g_enterprise,
   #                     "   AND icaa001 = icab001",
   #                     "   AND icaastus = 'Y'",
   #                     "   AND icab005 = 'Y' ",
   #                     "   AND icab003 = '",g_site,"')"
   #END IF
   ##141114-00010#2--add--end--lujh
   #151125-00018#2--mark--end--lujh
   
   PREPARE tmp_ins_pre FROM g_sql
   EXECUTE tmp_ins_pre
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'INSERT'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   
   LET g_wc_filter = " 1=1"
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   
   #end add-point
        
   LET g_error_show = 1
   CALL axrp141_b_fill()
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
 
{<section id="axrp141.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrp141_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   #141114-00010#2--add--str--lujh
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_xmdksite      LIKE xmdk_t.xmdksite
   DEFINE l_icab002       LIKE icab_t.icab002
   DEFINE l_icab003       LIKE icab_t.icab003
   DEFINE l_icab008       LIKE icab_t.icab008
   #141114-00010#2--add--end--lujh
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_sql = "SELECT DISTINCT 'N',xmdkdocno,xmdkdocdt,xmdk007,'',xmdk009,'',xmdk008,'',",
               "       xmdk003,'',xmdk004,'',xmdk002,xmdk035,'',xmdk044 ",
               "  FROM axrp141_tmp",
               " WHERE xmdkent = ?",
               "   AND ",g_wc_filter,
               " ORDER BY xmdkdocno,xmdkdocdt"
   #end add-point
 
   PREPARE axrp141_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axrp141_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   CALL g_detail2_d.clear()
   
   LET g_master_idx = 1
   CALL FGL_SET_ARR_CURR(g_master_idx)
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].sel,            
   g_detail_d[l_ac].xmdkdocno,      
   g_detail_d[l_ac].xmdkdocdt,         
   g_detail_d[l_ac].xmdk007,           
   g_detail_d[l_ac].xmdk007_desc,      
   g_detail_d[l_ac].xmdk009,           
   g_detail_d[l_ac].xmdk009_desc,      
   g_detail_d[l_ac].xmdk008,           
   g_detail_d[l_ac].xmdk008_desc,      
   g_detail_d[l_ac].xmdk003,           
   g_detail_d[l_ac].xmdk003_desc,      
   g_detail_d[l_ac].xmdk004,           
   g_detail_d[l_ac].xmdk004_desc,      
   g_detail_d[l_ac].xmdk002,           
   g_detail_d[l_ac].xmdk035,           
   g_detail_d[l_ac].invoice,
   g_detail_d[l_ac].xmdk044   
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
      #151125-00018#2--mark--str--lujh
      ##141114-00010#2--add--str--lujh
      #SELECT xmdksite INTO l_xmdksite
      #  FROM xmdk_t
      # WHERE xmdkdocno = g_detail_d[l_ac].xmdkdocno
      #   
      ##查找是否有设置中断点
      #SELECT COUNT(*) INTO l_n 
      #  FROM icab_t
      # WHERE icabent = g_enterprise
      #   AND icab001 = g_detail_d[l_ac].xmdk044
      #   AND icab005 = 'Y'
      #   
      #IF l_n > 0 THEN    #有设置中断点
      #   SELECT icab002,icab003,icab008
      #     INTO l_icab002,l_icab003,l_icab008
      #     FROM icab_t
      #    WHERE icabent = g_enterprise
      #      AND icab001 = g_detail_d[l_ac].xmdk044
      #      AND icab005 = 'Y'
      #   
      #   #如果不是实体库存,本站不会有出货单,找下一站的据点
      #   IF l_icab008 = 'N' THEN 
      #      SELECT icab003 INTO l_icab003 
      #        FROM icab_t
      #       WHERE icabent = g_enterprise
      #         AND icab001 = g_detail_d[l_ac].xmdk044 
      #         AND icab002 = l_icab002 + 1
      #   END IF
      #   
      #   IF g_input.icab005 = 'N' THEN 
      #      IF l_xmdksite <> l_icab003 THEN 
      #         CONTINUE FOREACH
      #      END IF
      #   ELSE
      #      IF l_xmdksite <> g_site THEN 
      #         CONTINUE FOREACH
      #      END IF
      #   END IF
      #ELSE
      #   #如果没有设置中断点,以当前site做筛选条件
      #   #IF g_input.icab005 = 'N' THEN 
      #      IF l_xmdksite <> g_site THEN 
      #         CONTINUE FOREACH
      #      END IF
      #   #END IF
      #END IF
      ##141114-00010#2--add--str--lujh 
      #151125-00018#2--mark--end--lujh      

      #xmdk007_desc,xmdk009_desc,xmdk008_desc
      CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].xmdk007) RETURNING g_detail_d[l_ac].xmdk007_desc
      CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].xmdk009) RETURNING g_detail_d[l_ac].xmdk009_desc
      CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].xmdk008) RETURNING g_detail_d[l_ac].xmdk008_desc
      #xmdk003_desc
      CALL s_desc_get_person_desc(g_detail_d[l_ac].xmdk003) RETURNING g_detail_d[l_ac].xmdk003_desc
      #xmdk004_desc
      CALL s_desc_get_department_desc(g_detail_d[l_ac].xmdk004) RETURNING g_detail_d[l_ac].xmdk004_desc
      #end add-point
      
      CALL axrp141_detail_show()      
 
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
   CALL g_detail_d.deleteElement(g_detail_d.getLength())
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE axrp141_sel
   
   LET l_ac = 1
   CALL axrp141_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrp141.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrp141_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   #141114-00010#2--add--str--lujh
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_icab002       LIKE icab_t.icab002
   DEFINE l_icab008       LIKE icab_t.icab008
   #141114-00010#2--add--end--lujh
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   CALL g_detail2_d.clear()
   IF g_detail_d.getLength() <= 0 THEN
      RETURN
   END IF
   
   LET l_ac = 1
   
   CALL axrp141_sql(g_detail_d[g_master_idx].xmdkdocno,g_detail_d[g_master_idx].xmdk035,g_detail_d[g_master_idx].xmdk044) 
   RETURNING g_sql
   
   PREPARE axrp141_pre FROM g_sql
   DECLARE axrp141_cs CURSOR FOR axrp141_pre
   
   FOREACH axrp141_cs INTO g_detail2_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'FOREACH:'
         LET g_errparam.popup = TRUE
         CALL cl_err()
   
         EXIT FOREACH
      END IF
      
      #151125-00018#2--mark--str--lujh
      ##141114-00010#2--add--str--lujh
      ##查找是否有设置中断点
      #SELECT COUNT(*) INTO l_n 
      #  FROM icab_t
      # WHERE icabent = g_enterprise
      #   AND icab001 = g_detail_d[g_master_idx].xmdk044
      #   AND icab005 = 'Y'
      #   
      ##只有逆抛会设置中断点,所以如果有中断点,说明是逆抛   
      #IF l_n > 0 THEN 
      #   SELECT icab002,icab008
      #     INTO l_icab002,l_icab008
      #     FROM icab_t
      #    WHERE icabent = g_enterprise
      #      AND icab001 = g_detail_d[g_master_idx].xmdk044
      #      AND icab005 = 'Y' 
      #   
      #   #如果不是实体库存,则从中断点的下一站点开始
      #   IF l_icab008 = 'N' THEN 
      #      LET l_icab002 = l_icab002 + 1
      #   END IF
      #
      #   #如果条件是中断点否为'N',则应该查出中断点之后站点的立账单据
      #   IF g_input.icab005 = 'N' THEN 
      #      #如果抓出的站点小于中断点站或者中断点的下一站,则退出         
      #      IF g_detail2_d[l_ac].l_icab002 <  l_icab002 THEN 
      #         CONTINUE FOREACH 
      #      END IF
      #   ELSE
      #   #如果条件是中断点否为'Y',则应该查出中断点之前站点的立账单据
      #      #如果抓出的站点小于中断点站或者中断点的下一站,则退出         
      #      IF g_detail2_d[l_ac].l_icab002 >=  l_icab002 THEN 
      #         CONTINUE FOREACH 
      #      END IF
      #   END IF
      #END IF
      ##141114-00010#2--add--end--lujh
      #151125-00018#2--mark--end--lujh
      
      #營運據點
      CALL s_desc_get_department_desc(g_detail2_d[l_ac].l_xmdksite) RETURNING g_detail2_d[l_ac].l_xmdksite_desc
      #账款对象
      CALL s_desc_get_trading_partner_abbr_desc(g_detail2_d[l_ac].l_xmdk008) RETURNING g_detail2_d[l_ac].l_xmdk008_desc
      #收/付款條件
      CALL s_desc_get_ooib002_desc(g_detail2_d[l_ac].l_xmdk010) RETURNING g_detail2_d[l_ac].l_xmdk010_desc
      #稅別
      CALL s_desc_get_tax_desc1(g_detail2_d[l_ac].l_xmdksite,g_detail2_d[l_ac].l_xmdk012) RETURNING g_detail2_d[l_ac].l_xmdk012_desc
      #發票類型
      CALL s_desc_get_invoice_type_desc1(g_detail2_d[l_ac].l_xmdksite,g_detail2_d[l_ac].l_xmdk015) RETURNING g_detail2_d[l_ac].l_xmdk015_desc
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = '9035'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
   
         END IF
         EXIT FOREACH
      END IF
   END FOREACH
   
   CALL g_detail2_d.deleteElement(g_detail2_d.getLength())
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axrp141.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axrp141_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrp141.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axrp141_filter()
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
   
   CALL axrp141_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="axrp141.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axrp141_filter_parser(ps_field)
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
 
{<section id="axrp141.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axrp141_filter_show(ps_field,ps_object)
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
   LET ls_condition = axrp141_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axrp141.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 資料拋轉流程
# Memo...........:
# Usage..........: CALL axrp141_process()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 2015/04/20 By lujh
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp141_process()
   DEFINE l_sql           STRING
   DEFINE l_xmdkdocno     LIKE xmdk_t.xmdkdocno
   DEFINE l_xmdk035       LIKE xmdk_t.xmdk035
   DEFINE l_xmdk044       LIKE xmdk_t.xmdk044
   DEFINE l_xmdk008       LIKE xmdk_t.xmdk008
   DEFINE l_icab002       LIKE icab_t.icab002
   DEFINE l_icab003       LIKE icab_t.icab003
   DEFINE l_docno         LIKE xmdk_t.xmdkdocno
   DEFINE l_xmdk000       LIKE xmdk_t.xmdk000
   DEFINE l_icae003       LIKE icae_t.icae003
   DEFINE l_icae004       LIKE icae_t.icae004
   DEFINE l_icae007       LIKE icae_t.icae007
   DEFINE l_icae008       LIKE icae_t.icae008
   DEFINE l_icae016       LIKE icae_t.icae016
   DEFINE l_icae018       LIKE icae_t.icae018
   DEFINE l_icae020       LIKE icae_t.icae020      #160714-00029#2 add lujh
   DEFINE l_xrcadocno     LIKE xrca_t.xrcadocno
   DEFINE l_tot_success   LIKE type_t.num5
   DEFINE l_start_no      LIKE xrca_t.xrcadocno
   DEFINE l_style         LIKE type_t.chr10          
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_ld            LIKE glaa_t.glaald
   DEFINE l_wc            STRING
   DEFINE l_str           STRING
   DEFINE l_success       LIKE type_t.num5
   DEFINE la_param        RECORD
          prog            STRING,
          param           DYNAMIC ARRAY OF STRING
                          END RECORD
   DEFINE ls_js           STRING
   DEFINE l_type          LIKE type_t.chr10    #多角流程类型  '1'訂單/採購單
                                               #             '2'出貨通知單
                                               #             '3'Invoice/Packing
                                               #             '4'出貨/收貨入庫
                                               #             '5'應收/付立帳
                                               #             '6'銷退/倉退
                                               #             '7'應收/付折讓
   DEFINE l_xrca047       LIKE xrca_t.xrca047
   DEFINE l_apcadocno     LIKE apca_t.apcadocno
   DEFINE l_group         LIKE type_t.chr1  
   DEFINE l_sql_cnt       STRING
   DEFINE l_cnt           LIKE type_t.num5   
   DEFINE l_ac            LIKE type_t.num5
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_d             LIKE type_t.num5
   DEFINE li_idx          LIKE type_t.num5
   DEFINE l_length        LIKE type_t.num5
   DEFINE l_icab005       LIKE icab_t.icab005      #141114-00010#2 add lujh
   DEFINE l_no            LIKE xrca_t.xrca047      #141114-00010#2 add lujh   #多角流程序号
   DEFINE l_source        LIKE type_t.chr1         #160401-00009#2 add lujh
   
   CALL cl_err_collect_init()
   
   LET l_no = ''   #141114-00010#2 add lujh
   
   #遍歷勾選的資料
   LET l_sql = "SELECT xmdkdocno,xmdk035,xmdk044 FROM axrp141_tmp WHERE sel = 'Y' "
   PREPARE axrp141_pre1 FROM l_sql
   DECLARE axrp141_cs1 CURSOR FOR axrp141_pre1
   
   DELETE FROM axrp141_tmp1
   FOREACH axrp141_cs1 INTO l_xmdkdocno,l_xmdk035,l_xmdk044
      #先將每個站點的單據放到臨時表里
      CALL axrp141_ins_tmp(l_xmdkdocno,l_xmdk035,l_xmdk044)
   END FOREACH 
   
   #遍歷站點
   LET l_sql = "SELECT DISTINCT icab002,xmdksite,xmdk044 FROM axrp141_tmp1 ORDER BY icab002"   #141114-00010#2 add xmdk044 lujh
   PREPARE axrp141_pre3 FROM l_sql
   DECLARE axrp141_cs3 CURSOR FOR axrp141_pre3   
   
   IF g_bgjob = 'N' THEN
      DISPLAY '' ,0 TO stagenow,stagecomplete
      LET l_sql_cnt = "SELECT COUNT(*) FROM axrp141_tmp1 "
      PREPARE axrp141_cnt_pre FROM l_sql_cnt
      DECLARE axrp141_cnt_cs SCROLL CURSOR FOR axrp141_cnt_pre
      OPEN axrp141_cnt_cs
      FETCH axrp141_cnt_cs INTO l_cnt
      IF cl_null(l_cnt)THEN LET l_cnt = 0 END IF
      CALL cl_progress_bar_no_window(l_cnt)
      CLOSE axrp141_cnt_cs
   END IF 
   
   LET l_ac = 1
   FOREACH axrp141_cs3 INTO g_icab_d[l_ac].*
      LET l_ac = l_ac + 1
   END FOREACH 
   
   CALL g_icab_d.deleteElement(l_ac)
   
   #FOREACH axrp141_cs3 INTO l_icab002,l_icab003
   FOR li_idx = 1 TO g_icab_d.getLength()
      #141114-00010#2--add--str--lujh
      #SELECT icab005 INTO l_icab005
      #  FROM icab_t
      # WHERE icabent = g_enterprise
      #   AND icab001 = g_icab_d[li_idx].icab001
      #   AND icab002 = g_icab_d[li_idx].icab002
      #
      ##如果中斷點立帳否為'N',則執行到中斷點的站點時就結束了
      ##如果中斷點立帳否為'Y',則是從中斷點開始執行,所以中斷點為'Y'依然執行下去(已確認一個流程代碼只會有一個中斷點)
      #IF g_input.icab005 = 'N' AND l_icab005 = 'Y' THEN 
      #   EXIT FOR
      #END IF
      
      #多角流程序号每个站点应该是一样的,所以第一步先产生一个序号
      #呼叫產生多角流程序號元件(wait)
      IF g_xmdk000 = '6' THEN 
         LET l_type = '7'      #應收/付折讓
      ELSE
         LET l_type = '5'      #應收/付立帳
      END IF
      IF cl_null(l_no) THEN 
         CALL s_transaction_begin()
         CALL s_aic_carry_gettrino(g_icab_d[li_idx].icab001,l_type,g_today,g_icab_d[li_idx].icab003)
         RETURNING l_success,l_no
         CALL s_transaction_end('Y','0')
      END IF
      
      #IF NOT l_success THEN
      #   CALL s_axrp133_success_tmp_ins('','',0,0,'axr-00331','N')
      #   CALL axrp141_fail('','','','',g_icab_d[li_idx].icab002,g_icab_d[li_idx].icab003,g_input.icaa012)
      #   CONTINUE FOR  
      #END IF
      #141114-00010#2--add--end--lujh
   
      IF g_input.icaa012 = '1' THEN     #依多角流程序号
         #出货/销退立账
         LET l_sql = "SELECT docno,xmdk000,xmdk035,xmdk044 ",
                     "  FROM axrp141_tmp1 ",
                     " WHERE icab002 = '",g_icab_d[li_idx].icab002,"'",
                     "   AND xmdksite = '",g_icab_d[li_idx].icab003,"'",
                     "   AND xmdk000 IN ('8','13','17','18') ",
                     " ORDER BY docno "
         PREPARE axrp141_pre4 FROM l_sql
         DECLARE axrp141_cs4 CURSOR FOR axrp141_pre4
         
         LET l_ac = 1
         FOREACH axrp141_cs4 INTO g_xmdk2_d[l_ac].*
            LET l_ac = l_ac + 1
         END FOREACH 
         
         CALL g_xmdk2_d.deleteElement(l_ac)
         
         FOR l_i = 1 TO g_xmdk2_d.getLength()
         
            DELETE FROM axrp133_s_tmp;
            DELETE FROM axrp133_tmp01;          #160727-00019#33  mod axrp133_xmdk_tmp --> axrp133_tmp01
            #抓取站点对应的设置
            CALL axrp141_icae_get(g_icab_d[li_idx].icab002,g_xmdk2_d[l_i].xmdk044)
            RETURNING l_icae003,l_icae004,l_icae007,l_icae008,l_icae016,l_icae018,l_ld,l_icae020   #160714-00029#2 add l_icae020 lujh
            
            LET l_wc = " xmdkdocno IN ('",g_xmdk2_d[l_i].docno,"')"
            
            #出货/销退分开立账            
            IF g_xmdk2_d[l_i].xmdk000 = '8' OR g_xmdk2_d[l_i].xmdk000 = '17' THEN   #出货
              LET l_style = 'axrt300'                                               #出货单应收立账
              LET l_xrcadocno = l_icae003                                           #应收单别
              LET l_type = '4'                                                      #多角流程类型 出貨  
            END IF
            IF g_xmdk2_d[l_i].xmdk000 = '13' OR g_xmdk2_d[l_i].xmdk000 = '18' THEN  #销退
               LET l_style = 'axrt340'                                              #销退单应收抵扣
               LET l_xrcadocno = l_icae007                                          #应收折让单别
               LET l_type = '7'                                                     #多角流程类型 應收折讓  
            END IF
            
            #调用axrp133的立账逻辑
            CALL axrp141_call_axrp133(l_wc,l_ld,g_xmdk2_d[l_i].docno,g_icab_d[li_idx].icab002,g_icab_d[li_idx].icab003,g_input.date,
                                      g_input.comb,g_input.icaa012,l_style,l_xrcadocno,
                                      l_icae018,g_xmdk2_d[l_i].xmdk035,g_xmdk2_d[l_i].xmdk044,'',l_no,l_icae016)  #141114-00010#2 change l_type to l_no lujh
         
         END FOR
         
         CALL g_xmdk2_d.clear()
         
         #入库/仓退立账
         LET l_sql = "SELECT docno,xmdk000,xmdk035,xmdk044 ",
                     "  FROM axrp141_tmp1 ",
                     " WHERE icab002 = '",g_icab_d[li_idx].icab002,"'",
                     "   AND xmdksite = '",g_icab_d[li_idx].icab003,"'",
                     "   AND xmdk000 IN ('10','14') ",
                     " ORDER BY docno "
         PREPARE axrp141_pre8 FROM l_sql
         DECLARE axrp141_cs8 CURSOR FOR axrp141_pre8
         
         LET l_ac = 1
         FOREACH axrp141_cs8 INTO g_xmdk2_d[l_ac].*
            LET l_ac = l_ac + 1
         END FOREACH 
         
         CALL g_xmdk2_d.deleteElement(l_ac)
         
         FOR l_i = 1 TO g_xmdk2_d.getLength() 
            DELETE FROM axrp133_s_tmp;
            DELETE FROM s_aapp131_tmp_g;
            #抓取站点对应的设置
            CALL axrp141_icae_get(g_icab_d[li_idx].icab002,g_xmdk2_d[l_i].xmdk044)
            RETURNING l_icae003,l_icae004,l_icae007,l_icae008,l_icae016,l_icae018,l_ld,l_icae020   #160714-00029#2 add l_icae020 lujh
            
            LET l_wc = " pmdsdocno IN ('",g_xmdk2_d[l_i].docno,"')"
            
            #入库/仓退分开立账            
            IF g_xmdk2_d[l_i].xmdk000 = '10' THEN   #入库
              LET l_style = '3'              #入库应付立账
              LET l_apcadocno = l_icae004    #应付单别
              LET l_type = '4'               #多角流程类型 入库  
            END IF
            IF g_xmdk2_d[l_i].xmdk000 = '14' THEN   #仓退
               LET l_style = '6'             #仓退待抵立账  
               LET l_apcadocno = l_icae008   #应付折让单别
               LET l_type = '7'              #多角流程类型 應付折讓  
            END IF
            
            #汇总方式
            LET l_group = '2'   #入库单号
            
            #调用aapp133的立账逻辑
            CALL axrp141_call_aapp133(l_wc,l_icae016,l_ld,l_style,l_apcadocno,l_icae020,g_input.date,        #160714-00029#2 change l_icae018 to l_icae020 lujh
                                      g_input.comb,l_group,g_xmdk2_d[l_i].docno,g_icab_d[li_idx].icab002,g_icab_d[li_idx].icab003,
                                      g_xmdk2_d[l_i].xmdk035,g_xmdk2_d[l_i].xmdk044,'',l_no,g_input.icaa012)  #141114-00010#2 change l_type to l_no lujh
         END FOR 
         
         CALL g_xmdk2_d.clear()

      ELSE   #依多角流程代码+客户/厂商
         #先依多角流程代码+客商分组
         LET l_sql = "SELECT DISTINCT xmdk035,xmdk044,xmdk008 ",
                     "  FROM axrp141_tmp1 ",
                     " WHERE icab002 = '",g_icab_d[li_idx].icab002,"'",
                     "   AND xmdksite = '",g_icab_d[li_idx].icab003,"'"
         PREPARE axrp141_pre5 FROM l_sql
         DECLARE axrp141_cs5 CURSOR FOR axrp141_pre5
         
         LET l_ac = 1
         FOREACH axrp141_cs5 INTO g_xmdk3_d[l_ac].*
            LET l_ac = l_ac + 1
         END FOREACH 
         
         CALL g_xmdk3_d.deleteElement(l_ac)
         
         #FOREACH axrp141_cs5 INTO l_xmdk044,l_xmdk008 
         FOR l_i = 1 TO g_xmdk3_d.getLength() 
            #抓取站点对应的设置
            CALL axrp141_icae_get(g_icab_d[li_idx].icab002,g_xmdk3_d[l_i].xmdk044)
            RETURNING l_icae003,l_icae004,l_icae007,l_icae008,l_icae016,l_icae018,l_ld,l_icae020   #160714-00029#2 add l_icae020 lujh
  
            #查出这一组多角流程代码+客商对应的单号
            #axrp133是出货/销退分开立账,所以分开抓取
            #出货立账   
            DELETE FROM axrp133_s_tmp;
            DELETE FROM axrp133_tmp01;           #160727-00019#33  mod axrp133_xmdk_tmp --> axrp133_tmp01
            LET l_sql = "SELECT docno FROM axrp141_tmp1 ",
                        " WHERE icab002 = '",g_icab_d[li_idx].icab002,"'",
                        "   AND xmdksite = '",g_icab_d[li_idx].icab003,"'",
                        "   AND xmdk044 = '",g_xmdk3_d[l_i].xmdk044,"'",
                        "   AND xmdk008 = '",g_xmdk3_d[l_i].xmdk008,"'",
                        "   AND xmdk000 IN ('8','17') ",
                        " ORDER BY docno "
            PREPARE axrp141_pre6 FROM l_sql
            DECLARE axrp141_cs6 CURSOR FOR axrp141_pre6
            
            #将单号组成字符串,以便传给立账作业
            LET l_str = ''
            LET l_wc = ''
            LET l_docno = ''
            FOREACH axrp141_cs6 INTO l_docno
               LET l_str = "'",l_docno,"'"
               IF cl_null(l_wc) THEN 
                  LET l_wc = l_str
               ELSE
                  LET l_wc = l_wc,",",l_str
               END IF
            END FOREACH 
            
            #如果有单号字串,传给axrp133
            IF NOT cl_null(l_wc) THEN 
               LET l_wc = " xmdkdocno IN (",l_wc,")"
               
               LET l_style = 'axrt300'         #出货单应收立账
               LET l_xrcadocno = l_icae003     #应收单别
               LET l_type = '4'                #多角流程类型 出貨  

               #调用axrp133的立账逻辑
               CALL axrp141_call_axrp133(l_wc,l_ld,'',g_icab_d[li_idx].icab002,g_icab_d[li_idx].icab003,g_input.date,
                                         g_input.comb,g_input.icaa012,l_style,l_xrcadocno,
                                         l_icae018,g_xmdk3_d[l_i].xmdk035,g_xmdk3_d[l_i].xmdk044,
                                         g_xmdk3_d[l_i].xmdk008,l_no,l_icae016)   #141114-00010#2 change l_type to l_no lujh
            END IF
            
            #销退立账   
            DELETE FROM axrp133_s_tmp;
            DELETE FROM axrp133_tmp01;         #160727-00019#33  mod axrp133_xmdk_tmp --> axrp133_tmp01
            LET l_sql = "SELECT docno FROM axrp141_tmp1 ",
                        " WHERE icab002 = '",g_icab_d[li_idx].icab002,"'",
                        "   AND xmdksite = '",g_icab_d[li_idx].icab003,"'",
                        "   AND xmdk044 = '",g_xmdk3_d[l_i].xmdk044,"'",
                        "   AND xmdk008 = '",g_xmdk3_d[l_i].xmdk008,"'",
                        "   AND xmdk000 IN ('13','18') ",
                        " ORDER BY docno "
            PREPARE axrp141_pre7 FROM l_sql
            DECLARE axrp141_cs7 CURSOR FOR axrp141_pre7
            
            #将单号组成字符串,以便传给立账作业
            LET l_str = ''
            LET l_wc = ''
            LET l_docno = ''
            FOREACH axrp141_cs7 INTO l_docno
               LET l_str = "'",l_docno,"'"
               IF cl_null(l_wc) THEN 
                  LET l_wc = l_str
               ELSE
                  LET l_wc = l_wc,",",l_str
               END IF
            END FOREACH 
            
            IF NOT cl_null(l_wc) THEN  
               LET l_wc = " xmdkdocno IN (",l_wc,")"
               
               LET l_style = 'axrt340'            #销退单应收抵扣
               LET l_xrcadocno = l_icae007        #应收折让单别
               LET l_type = '7'                   #多角流程类型 應收折讓  
               
               #调用axrp133的立账逻辑
               CALL axrp141_call_axrp133(l_wc,l_ld,'',g_icab_d[li_idx].icab002,g_icab_d[li_idx].icab003,g_input.date,
                                         g_input.comb,g_input.icaa012,l_style,l_xrcadocno,
                                         l_icae018,g_xmdk3_d[l_i].xmdk035,g_xmdk3_d[l_i].xmdk044,
                                         g_xmdk3_d[l_i].xmdk008,l_no,l_icae016)   #141114-00010#2 change l_type to l_no lujh
            END IF
            
            #aapp133是入库/仓退分开立账,所以分开抓取
            #入库立账
            DELETE FROM axrp133_s_tmp;
            DELETE FROM s_aapp131_tmp_g;
            LET l_sql = "SELECT docno FROM axrp141_tmp1 ",
                        " WHERE icab002 = '",g_icab_d[li_idx].icab002,"'",
                        "   AND xmdksite = '",g_icab_d[li_idx].icab003,"'",
                        "   AND xmdk044 = '",g_xmdk3_d[l_i].xmdk044,"'",
                        "   AND xmdk008 = '",g_xmdk3_d[l_i].xmdk008,"'",
                        "   AND xmdk000 IN ('10') ",
                        " ORDER BY docno "
            PREPARE axrp141_pre9 FROM l_sql
            DECLARE axrp141_cs9 CURSOR FOR axrp141_pre9
            
            #将单号组成字符串,以便传给立账作业
            LET l_str = ''
            LET l_wc = ''
            LET l_docno = ''
            FOREACH axrp141_cs9 INTO l_docno
               LET l_str = "'",l_docno,"'"
               IF cl_null(l_wc) THEN 
                  LET l_wc = l_str
               ELSE
                  LET l_wc = l_wc,",",l_str
               END IF
            END FOREACH 
            
            #如果有单号字串,传给aapp133
            IF NOT cl_null(l_wc) THEN 
               LET l_wc = " pmdsdocno IN (",l_wc,")"
               
               LET l_style = '3'              #入库应付立账
               LET l_apcadocno = l_icae004    #应付单别
               LET l_type = '4'               #多角流程类型 入库  
               
               #汇总方式
               LET l_group = '1'   #交易对象
               
               #调用aapp133的立账逻辑
               CALL axrp141_call_aapp133(l_wc,l_icae016,l_ld,l_style,l_apcadocno,l_icae020,g_input.date,      #160714-00029#2 change l_icae018 to l_icae020 lujh
                                         g_input.comb,l_group,'',g_icab_d[li_idx].icab002,g_icab_d[li_idx].icab003,
                                         g_xmdk3_d[l_i].xmdk035,g_xmdk3_d[l_i].xmdk044,
                                         g_xmdk3_d[l_i].xmdk008,l_no,g_input.icaa012)   #141114-00010#2 change l_type to l_no lujh
            END IF
            
            #仓退立账  
            DELETE FROM axrp133_s_tmp;
            DELETE FROM s_aapp131_tmp_g;            
            LET l_sql = "SELECT docno FROM axrp141_tmp1 ",
                        " WHERE icab002 = '",g_icab_d[li_idx].icab002,"'",
                        "   AND xmdksite = '",g_icab_d[li_idx].icab003,"'",
                        "   AND xmdk044 = '",g_xmdk3_d[l_i].xmdk044,"'",
                        "   AND xmdk008 = '",g_xmdk3_d[l_i].xmdk008,"'",
                        "   AND xmdk000 IN ('14') ",
                        " ORDER BY docno "
            PREPARE axrp141_pre10 FROM l_sql
            DECLARE axrp141_cs10 CURSOR FOR axrp141_pre10
            
            #将单号组成字符串,以便传给立账作业
            LET l_str = ''
            LET l_wc = ''
            LET l_docno = ''
            FOREACH axrp141_cs10 INTO l_docno
               LET l_str = "'",l_docno,"'"
               IF cl_null(l_wc) THEN 
                  LET l_wc = l_str
               ELSE
                  LET l_wc = l_wc,",",l_str
               END IF
            END FOREACH 
            
            IF NOT cl_null(l_wc) THEN  
               LET l_wc = " pmdsdocno IN (",l_wc,")"
               
               LET l_style = '6'             #仓退待抵立账  
               LET l_apcadocno = l_icae008   #应付折让单别
               LET l_type = '7'              #多角流程类型 應付折讓
               
               LET l_style = '6'             #仓退待抵立账  
               LET l_apcadocno = l_icae008   #应付折让单别
               LET l_type = '7'              #多角流程类型 應付折讓    
               
               #汇总方式
               LET l_group = '1'   #交易对象
               
               #调用aapp133的立账逻辑
               CALL axrp141_call_aapp133(l_wc,l_icae016,l_ld,l_style,l_apcadocno,l_icae020,g_input.date,     #160714-00029#2 change l_icae018 to l_icae020 lujh
                                         g_input.comb,l_group,'',g_icab_d[li_idx].icab002,g_icab_d[li_idx].icab003,
                                         g_xmdk3_d[l_i].xmdk035,g_xmdk3_d[l_i].xmdk044,
                                         g_xmdk3_d[l_i].xmdk008,l_no,g_input.icaa012)       #141114-00010#2 change l_type to l_no lujh
            END IF
            
#160401-00009#2--mark--str--lujh            
#            #依多角流程代码+客户/厂商汇总产生时,只要有一笔立账失败,当前站点已经产生的单据则全部删除
#            SELECT COUNT(*) INTO l_n FROM axrp133_s_tmp WHERE success = 'N'
#            IF l_n > 0 THEN     
#               #查询此站点已经产生的应收单据
#               LET l_sql = "SELECT docno,xrca047,style FROM axrp141_tmp2 WHERE source = '1' AND icab002 = '",g_icab_d[li_idx].icab002,"'"
#               PREPARE axrp141_tmp2_pre FROM l_sql
#               DECLARE axrp141_tmp2_cs CURSOR FOR axrp141_tmp2_pre
#               LET l_str = ''
#               LET l_wc = ''
#               LET l_docno = ''
#               LET l_xrca047 = ''
#               LET l_style = ''
#               LET l_type = ''
#               FOREACH axrp141_tmp2_cs INTO l_docno,l_xrca047,l_style
#                  LET l_str = "'",l_docno,"'"
#                  IF cl_null(l_wc) THEN 
#                     LET l_wc = l_str
#                  ELSE
#                     LET l_wc = l_wc,",",l_str
#                  END IF
#                  
#                  #将此站点执行成功的数组删掉
#                  FOR l_d = 1 TO g_detail3_d.getLength() 
#                     IF g_detail3_d[l_d].docno = l_docno THEN 
#                        CALL g_detail3_d.deleteElement(l_d)
#                        
#                        #刪除多角流程流水號
#                        CALL s_transaction_begin()
#                        IF l_style = 'axrt300' THEN 
#                           LET l_type = '4' 
#                        ELSE
#                           LET l_type = '7' 
#                        END IF
#                        CALL s_aic_carry_deletetrino(l_xrca047,l_type) RETURNING l_success
#                        IF l_success = TRUE THEN
#                           CALL s_transaction_end('Y','0')
#                        ELSE
#                           CALL s_transaction_end('N','0')
#                        END IF
#                     END IF
#                  END FOR 
#               END FOREACH 
#               
#               IF NOT cl_null(l_wc) THEN 
#                  LET l_wc = " xrcadocno IN (",l_wc,")"
#                  
#                  LET la_param.prog = "axrp135"
#                  LET la_param.param[1] = 'Y'
#                  LET la_param.param[2] = l_icae016
#                  LET la_param.param[3] = l_ld
#                  LET la_param.param[4] = l_wc
#                  LET ls_js = util.JSON.stringify(la_param)
#                  CALL cl_cmdrun_wait(ls_js)
#               END IF
#               
#               #查询此站点已经产生的应付单据
#               LET l_sql = "SELECT docno FROM axrp141_tmp2 WHERE source = '2' AND icab002 = '",g_icab_d[li_idx].icab002,"'"
#               PREPARE axrp141_tmp2_pre1 FROM l_sql
#               DECLARE axrp141_tmp2_cs1 CURSOR FOR axrp141_tmp2_pre1
#               LET l_str = ''
#               LET l_wc = ''
#               LET l_docno = ''
#               FOREACH axrp141_tmp2_cs1 INTO l_docno
#                  LET l_str = "'",l_docno,"'"
#                  IF cl_null(l_wc) THEN 
#                     LET l_wc = l_str
#                  ELSE
#                     LET l_wc = l_wc,",",l_str
#                  END IF
#               END FOREACH 
#               IF NOT cl_null(l_wc) THEN 
#                  LET l_wc = " apcadocno IN (",l_wc,")"
#                  
#                  LET la_param.prog = "aapp135"
#                  LET la_param.param[1] = 'Y'
#                  LET la_param.param[2] = l_icae016
#                  LET la_param.param[3] = l_ld
#                  LET la_param.param[4] = l_wc
#                  LET ls_js = util.JSON.stringify(la_param)
#                  CALL cl_cmdrun_wait(ls_js)
#               END IF
#            END IF
#160401-00009#2--mark--end--lujh
         END FOR 
         #END FOREACH 
      END IF
   END FOR      
   #END FOREACH 
   
   #160401-00009#2--add--str--lujh
   LET l_length = g_detail4_d.getLength()
   IF l_length > 0 THEN     
      LET l_wc = ''
      LET l_xrca047 = ''
      LET l_style = ''
      LET l_type = ''
      FOR l_i = 1 TO g_detail3_d.getLength()
         LET l_wc = "'",g_detail3_d[l_i].docno,"'"
         SELECT style,source INTO l_style,l_source FROM aapp141_tmp2 WHERE docno = g_detail3_d[l_i].docno
         
         IF l_source = '1' THEN    #已经产生的应收单据
            SELECT xrcasite,xrcald INTO l_icae016,l_ld
              FROM xrca_t
             WHERE xrcaent = g_enterprise
               AND xrcadocno = g_detail3_d[l_i].docno
            
            IF NOT cl_null(l_wc) THEN 
               LET l_wc = " xrcadocno IN (",l_wc,")"
               
               CALL s_axrp135_ar_rollback(l_wc,l_icae016,l_ld)
            END IF
            
            #刪除多角流程流水號
            CALL s_transaction_begin()
            IF l_style = 'axrt300' THEN 
               LET l_type = '4' 
            ELSE
               LET l_type = '7' 
            END IF
            CALL s_aic_carry_deletetrino(g_detail3_d[l_i].xrca047,l_type) RETURNING l_success
            IF l_success = TRUE THEN
               CALL s_transaction_end('Y','0')
            ELSE
               CALL s_transaction_end('N','0')
            END IF 
         ELSE        #已经产生的应付单据
            SELECT apcasite,apcald INTO l_icae016,l_ld
              FROM apca_t
             WHERE apcaent = g_enterprise
               AND apcadocno = g_detail3_d[l_i].docno
            
            IF NOT cl_null(l_wc) THEN 
               LET l_wc = " apcadocno IN (",l_wc,")"
               
               CALL s_aapp135_process(l_wc,l_ld)
            END IF
            #刪除多角流程流水號
            CALL s_transaction_begin()
            IF l_style = '3' THEN 
               LET l_type = '4' 
            ELSE
               LET l_type = '7' 
            END IF
            
            CALL s_aic_carry_deletetrino(g_detail3_d[l_i].xrca047,l_type) RETURNING l_success
            IF l_success = TRUE THEN
               CALL s_transaction_end('Y','0')
            ELSE
               CALL s_transaction_end('N','0')
            END IF 
         END IF
      END FOR 
   END IF
   #160401-00009#2--add--end--lujh

   CALL cl_ask_pressanykey("std-00012")
   DISPLAY '' ,0 TO stagenow,stagecomplete
END FUNCTION

################################################################################
# Descriptions...: 顯示失敗頁籤
# Memo...........:
# Usage..........: CALL axrp141_fail(p_docno,p_xmdk035,p_xmdk044,p_xmdk008,p_icab002,p_site,p_type)
#                  
# Input parameter: p_docno            出货单号
#                : p_xmdk035          多角序号
#                : p_xmdk044          多角流程代码
#                : p_xmdk008          账款客户
#                : p_icab002          站点
#                : p_site             营运据点
#                : p_type             产生方式   1.依多角流程序号
#                                               2.依多角流程代码+客户/厂商
# Return code....: 
# Date & Author..: 2015/04/24 By lujh
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp141_fail(p_docno,p_xmdk035,p_xmdk044,p_xmdk008,p_icab002,p_site,p_type)
   DEFINE p_docno          LIKE xmdk_t.xmdkdocno
   DEFINE p_xmdk035        LIKE xmdk_t.xmdk035
   DEFINE p_xmdk044        LIKE xmdk_t.xmdk044
   DEFINE p_xmdk008        LIKE xmdk_t.xmdk008
   DEFINE p_icab002        LIKE icab_t.icab002
   DEFINE p_site           LIKE xmdk_t.xmdksite
   DEFINE p_type           LIKE type_t.chr1
   DEFINE l_sql            STRING
   DEFINE l_ac             LIKE type_t.num5
   DEFINE l_docno_s        LIKE xmdk_t.xmdkdocno
   DEFINE l_seq            LIKE xmdl_t.xmdlseq
   DEFINE l_gzze001        LIKE gzze_t.gzze001
   DEFINE l_gzze003        LIKE gzze_t.gzze003
   DEFINE l_seq_str        STRING
   DEFINE l_msg            STRING
   DEFINE l_length         LIKE type_t.num5
   
   LET l_length = g_detail4_d.getLength()
   
   LET l_sql = "SELECT docno_s,seq,gzze001,gzze003 FROM axrp133_s_tmp WHERE success = 'N' "
   PREPARE axrp141_fail_pre FROM l_sql
   DECLARE axrp141_fail_cs CURSOR FOR axrp141_fail_pre
   
   IF l_length = 0 THEN 
      LET l_ac = 1
   ELSE
      LET l_ac = l_length + 1
   END IF
   FOREACH axrp141_fail_cs INTO l_docno_s,l_seq,l_gzze001,l_gzze003
      LET l_seq_str = l_seq
#      LET l_msg = cl_getmsg('axm-00008',g_lang) CLIPPED,l_seq_str   #160318-00005#51  mark
      LET l_msg = cl_getmsg('anm-00225',g_lang) CLIPPED,l_seq_str    #160318-00005#51  add
      IF p_type = '1' THEN    
         IF l_seq <> 0 THEN   #如果记录了项次,把项次也显示出来
            LET g_detail4_d[l_ac].docno_f = p_docno,'/' CLIPPED,l_msg CLIPPED,'/' CLIPPED,p_xmdk035
         ELSE
            LET g_detail4_d[l_ac].docno_f = p_docno,'/' CLIPPED,p_xmdk035
         END IF
      ELSE
         IF NOT cl_null(l_docno_s) AND l_seq <> 0 THEN   #如果记录了项次,把项次也显示出来
            LET g_detail4_d[l_ac].docno_f = l_docno_s,'/' CLIPPED,l_msg CLIPPED,'/' CLIPPED,p_xmdk044,'/' CLIPPED,p_xmdk008
         ELSE
            IF NOT cl_null(l_docno_s) THEN 
               LET g_detail4_d[l_ac].docno_f = l_docno_s,'/' CLIPPED,p_xmdk044,'/' CLIPPED,p_xmdk008
            ELSE
               LET g_detail4_d[l_ac].docno_f = p_xmdk044,'/' CLIPPED,p_xmdk008
            END IF
         END IF
      END IF
      LET g_detail4_d[l_ac].icab002_f = p_icab002
      LET g_detail4_d[l_ac].site_f = p_site
      CALL s_desc_get_department_desc(g_detail4_d[l_ac].site_f) RETURNING g_detail4_d[l_ac].site_f_desc
      LET g_detail4_d[l_ac].gzze001 = l_gzze001
      LET g_detail4_d[l_ac].gzze003 = l_gzze003
      
      LET l_ac = l_ac + 1
   END FOREACH 
   
   #CALL g_detail4_d.deleteElement(g_detail4_d.getLength())
   LET l_length = l_ac - 1
END FUNCTION

################################################################################
# Descriptions...: 顯示成功頁籤
# Memo...........:
# Usage..........: CALL axrp141_success(p_docno,p_xmdk035,p_xmdk044,p_xmdk008,p_icab002,p_site,p_type,p_xrca047,p_source,p_style)
#                  
# Input parameter: p_docno            出货单号
#                : p_xmdk035          多角序号
#                : p_xmdk044          多角流程代码
#                : p_xmdk008          账款客户
#                : p_icab002          站点
#                : p_site             营运据点
#                : p_type             产生方式   1.依多角流程序号
#                                               2.依多角流程代码+客户/厂商
#                : p_xrca047          多角序号
#                : p_source           产生单据的来源  1.应收
#                :                                   2.应付 
#                : p_style            立账方式  AR axrt300    出货单应收立账
#                :                                axrt340    销退单应收抵扣
#                :                             AP 3(aapt300) 入库应付立账
#                :                                6(aapt340) 仓退待抵立账  
# Return code....:                                
# Date & Author..: 2015/04/24 By lujh
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp141_success(p_docno,p_xmdk035,p_xmdk044,p_xmdk008,p_icab002,p_site,p_type,p_xrca047,p_source,p_style)
   DEFINE p_docno          LIKE xmdk_t.xmdkdocno
   DEFINE p_xmdk035        LIKE xmdk_t.xmdk035
   DEFINE p_xmdk044        LIKE xmdk_t.xmdk044
   DEFINE p_xmdk008        LIKE xmdk_t.xmdk008
   DEFINE p_icab002        LIKE icab_t.icab002
   DEFINE p_site           LIKE xmdk_t.xmdksite
   DEFINE p_type           LIKE type_t.chr1
   DEFINE p_xrca047        LIKE xrca_t.xrca047
   DEFINE p_source         LIKE type_t.chr10
   DEFINE p_style          LIKE type_t.chr10
   DEFINE l_sql            STRING
   DEFINE l_ac             LIKE type_t.num5
   DEFINE l_xrcadocno      LIKE xrca_t.xrcadocno
   DEFINE l_xrca108        LIKE xrca_t.xrca108
   DEFINE l_length         LIKE type_t.num5
   
   LET l_length = g_detail3_d.getLength()
   
   LET l_sql = "SELECT docno,amt FROM axrp133_s_tmp WHERE success = 'Y' "
   PREPARE axrp141_success_pre FROM l_sql
   DECLARE axrp141_success_cs CURSOR FOR axrp141_success_pre
   
   IF l_length = 0 THEN 
      LET l_ac = 1
   ELSE
      LET l_ac = l_length + 1
   END IF
   FOREACH axrp141_success_cs INTO l_xrcadocno,l_xrca108
      IF p_type = '1' THEN    
         LET g_detail3_d[l_ac].docno_s = p_docno,'/' CLIPPED,p_xmdk035
      ELSE
         LET g_detail3_d[l_ac].docno_s = p_xmdk044,'/' CLIPPED,p_xmdk008
      END IF
      LET g_detail3_d[l_ac].icab002 = p_icab002
      LET g_detail3_d[l_ac].site = p_site
      CALL s_desc_get_department_desc(g_detail3_d[l_ac].site) RETURNING g_detail3_d[l_ac].site_desc
      LET g_detail3_d[l_ac].docno = l_xrcadocno
      LET g_detail3_d[l_ac].xrca047 = p_xrca047
      LET g_detail3_d[l_ac].xrca108 = l_xrca108
      
      INSERT INTO axrp141_tmp2 VALUES(p_icab002,l_xrcadocno,p_xrca047,p_source,p_style)
      
      LET l_ac = l_ac + 1
   END FOREACH 
   
   #CALL g_detail3_d.deleteElement(g_detail3_d.getLength())
   LET l_length = l_ac - 1
END FUNCTION

#Temp table
PRIVATE FUNCTION axrp141_create_temp_table()
   
   #记录满足QBE条件的出货单
   DROP TABLE axrp141_tmp;
   CREATE TEMP TABLE axrp141_tmp(
      xmdkent           LIKE xmdk_t.xmdkent,
      sel               LIKE type_t.chr1,
      xmdkdocno         LIKE xmdk_t.xmdkdocno,
      xmdkdocdt         LIKE xmdk_t.xmdkdocdt,
      xmdk007           LIKE xmdk_t.xmdk007,
      xmdk007_desc      LIKE type_t.chr500,
      xmdk009           LIKE xmdk_t.xmdk009,
      xmdk009_desc      LIKE type_t.chr500,
      xmdk008           LIKE xmdk_t.xmdk008,
      xmdk008_desc      LIKE type_t.chr500,
      xmdk003           LIKE xmdk_t.xmdk003,
      xmdk003_desc      LIKE type_t.chr500,
      xmdk004           LIKE xmdk_t.xmdk004,
      xmdk004_desc      LIKE type_t.chr500,
      xmdk002           LIKE xmdk_t.xmdk002,
      xmdk035           LIKE xmdk_t.xmdk035,
      invoice           LIKE type_t.chr500,
      xmdk044           LIKE xmdk_t.xmdk044
      );
   
   #记录每个站点的单据信息   
   DROP TABLE axrp141_tmp1;
   CREATE TEMP TABLE axrp141_tmp1(
      icab002         LIKE icab_t.icab002,
      xmdksite        LIKE xmdk_t.xmdksite,
      xmdksite_desc   LIKE type_t.chr80,
      xmdk000         LIKE xmdk_t.xmdk000,
      docno           LIKE xmdk_t.xmdkdocno,
      xmdk008         LIKE xmdk_t.xmdk008,
      xmdk008_desc    LIKE type_t.chr80,
      xmdk016         LIKE xmdk_t.xmdk016,
      xmdk051         LIKE xmdk_t.xmdk051,
      xmdk053         LIKE xmdk_t.xmdk053,
      xmdk052         LIKE xmdk_t.xmdk052,
      xmdk010         LIKE xmdk_t.xmdk010,
      xmdk010_desc    LIKE type_t.chr80,
      xmdk012         LIKE xmdk_t.xmdk012,
      xmdk012_desc    LIKE type_t.chr80,
      xmdk015         LIKE xmdk_t.xmdk015,
      xmdk015_desc    LIKE type_t.chr80,
      xmdk032         LIKE xmdk_t.xmdk032,
      xmdk035         LIKE xmdk_t.xmdk035,
      xmdk044         LIKE xmdk_t.xmdk044
      );
    
    #记录产生成功的立账单据    
    DROP TABLE axrp141_tmp2;
    CREATE TEMP TABLE axrp141_tmp2 (
       icab002       LIKE icab_t.icab002,
       docno         LIKE xrca_t.xrcadocno,
       xrca047       LIKE xrca_t.xrca047,
       source        LIKE type_t.chr10,
       style         LIKE type_t.chr10
    );

END FUNCTION
# 將每一站的單據放到臨時表里
PRIVATE FUNCTION axrp141_ins_tmp(p_xmdkdocno,p_xmdk035,p_xmdk044)
   DEFINE p_xmdkdocno     LIKE xmdk_t.xmdkdocno    #出貨單號
   DEFINE p_xmdk035       LIKE xmdk_t.xmdk035      #多角流程序號
   DEFINE p_xmdk044       LIKE xmdk_t.xmdk034      #多角流程代碼
   #141114-00010#2--add--str--lujh
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_icab002       LIKE icab_t.icab002
   DEFINE l_icab008       LIKE icab_t.icab008
   #141114-00010#2--add--end--lujh
   DEFINE l_tmp           RECORD
                          icab002         LIKE icab_t.icab002,
                          xmdksite        LIKE xmdk_t.xmdksite,
                          xmdksite_desc   LIKE type_t.chr80,
                          xmdk000         LIKE xmdk_t.xmdk000,
                          docno           LIKE xmdk_t.xmdkdocno,
                          xmdk008         LIKE xmdk_t.xmdk008,
                          xmdk008_desc    LIKE type_t.chr80,
                          xmdk016         LIKE xmdk_t.xmdk016,
                          xmdk051         LIKE xmdk_t.xmdk051,
                          xmdk053         LIKE xmdk_t.xmdk053,
                          xmdk052         LIKE xmdk_t.xmdk052,
                          xmdk010         LIKE xmdk_t.xmdk010,
                          xmdk010_desc    LIKE type_t.chr80,
                          xmdk012         LIKE xmdk_t.xmdk012,
                          xmdk012_desc    LIKE type_t.chr80,
                          xmdk015         LIKE xmdk_t.xmdk015,
                          xmdk015_desc    LIKE type_t.chr80,
                          xmdk032         LIKE xmdk_t.xmdk032,
                          xmdk035         LIKE xmdk_t.xmdk035,
                          xmdk044         LIKE xmdk_t.xmdk044
                          END RECORD
   
   CALL axrp141_sql(p_xmdkdocno,p_xmdk035,p_xmdk044) RETURNING g_sql
   PREPARE axrp141_pre2 FROM g_sql
   DECLARE axrp141_cs2 CURSOR FOR axrp141_pre2
   FOREACH axrp141_cs2 INTO l_tmp.*
      #151125-00018#2--mark--str--lujh
      ##141114-00010#2--add--str--lujh
      ##查找是否有设置中断点
      #SELECT COUNT(*) INTO l_n 
      #  FROM icab_t
      # WHERE icabent = g_enterprise
      #   AND icab001 = p_xmdk044
      #   AND icab005 = 'Y'
      #   
      ##只有逆抛会设置中断点,所以如果有中断点,说明是逆抛   
      #IF l_n > 0 THEN 
      #   SELECT icab002,icab008
      #     INTO l_icab002,l_icab008
      #     FROM icab_t
      #    WHERE icabent = g_enterprise
      #      AND icab001 = p_xmdk044
      #      AND icab005 = 'Y' 
      #   
      #   #如果不是实体库存,则从中断点的下一站点开始
      #   IF l_icab008 = 'N' THEN 
      #      LET l_icab002 = l_icab002 + 1
      #   END IF
      #
      #   #如果条件是中断点否为'N',则应该查出中断点之后站点的立账单据
      #   IF g_input.icab005 = 'N' THEN 
      #      #如果抓出的站点小于中断点站或者中断点的下一站,则退出         
      #      IF l_tmp.icab002 <  l_icab002 THEN 
      #         CONTINUE FOREACH 
      #      END IF
      #   ELSE
      #   #如果条件是中断点否为'Y',则应该查出中断点之前站点的立账单据
      #      #如果抓出的站点小于中断点站或者中断点的下一站,则退出         
      #      IF l_tmp.icab002 >=  l_icab002 THEN 
      #         CONTINUE FOREACH 
      #      END IF
      #   END IF
      #END IF
      ##141114-00010#2--add--end--lujh
      #151125-00018#2--mark--end--lujh
      
      #151125-00018#2--add--str--lujh
      SELECT COUNT(*) INTO l_n
        FROM axrp141_tmp1
       WHERE docno = l_tmp.docno
         AND xmdk035 = l_tmp.xmdk035
         
      IF l_n > 0 THEN 
         CONTINUE FOREACH
      END IF
      #151125-00018#2--add--end--lujh
   
      INSERT INTO axrp141_tmp1 VALUES(l_tmp.*)
   END FOREACH 
END FUNCTION
# 組查詢每個站點單據的g_sql
PRIVATE FUNCTION axrp141_sql(p_xmdkdocno,p_xmdk035,p_xmdk044)
   DEFINE p_xmdkdocno     LIKE xmdk_t.xmdkdocno    #出貨單號
   DEFINE p_xmdk035       LIKE xmdk_t.xmdk035      #多角流程序號
   DEFINE p_xmdk044       LIKE xmdk_t.xmdk034      #多角流程代碼
   DEFINE l_xmdl_sql      STRING
   DEFINE l_pmds_sql      STRING
   DEFINE l_xmdk003_sql   STRING
   DEFINE ls_scc          STRING      #170110-00009#1 add lujh
   DEFINE r_sql           STRING
   
   CALL s_axrp133_get_scc('xmdk000','2077') RETURNING ls_scc       #170110-00009#1 add lujh
   
   #查询出货单单身订单
   LET l_xmdk003_sql = "(SELECT xmdl003 FROM xmdl_t ",
                       "  WHERE xmdlent = '",g_enterprise,"'",
                       "    AND xmdldocno = '",p_xmdkdocno,"')"
   
   #訂單
   #訂單 -> 出貨 -> 簽收 -> 簽退
   #訂單 -> 出貨 -> 銷退
   #訂單 -> 出貨 -> 簽收-> 銷退
   LET l_xmdl_sql = " AND EXISTS (SELECT t1.xmdk035",
                    "              FROM (SELECT DISTINCT xmdk035",  #出貨 簽收 簽退 銷退
                    "                      FROM xmdk_t",
                    "                      LEFT OUTER JOIN xmdl_t ON xmdlent = xmdkent AND xmdldocno = xmdkdocno",
                    "                     WHERE xmdkent = ",g_enterprise,
                    "                       AND xmdkstus != 'X'",
                    "                       AND xmdl003 IN ",l_xmdk003_sql,
                    "                    UNION ALL",
                    "                    SELECT xmdo055",           #Invoice
                    "                      FROM xmdo_t",
                    "                      LEFT OUTER JOIN xmdp_t ON xmdoent = xmdpent AND xmdodocno = xmdpdocno",
                    "                     WHERE xmdoent = ",g_enterprise,
                    "                       AND xmdostus != 'X'",
                    "                       AND xmdp003 IN ",l_xmdk003_sql,
                    "                   )  t1",
                    "             WHERE t1.xmdk035 = "
      
   #採購單
   #採購 -> 收貨單 -> 入庫單
   #收貨單 單號, 入庫單 多角流程序號
   LET l_pmds_sql = " OR EXISTS (SELECT 1",
                    "              FROM (SELECT t1.pmds053, t1.pmds041",
                    "                      FROM pmds_t t1,",   --入庫
                    "                           pmds_t t2 ",   --收貨
                    "                     WHERE t1.pmdsent = t2.pmdsent",
                    "                       AND t1.pmds006 = t2.pmdsdocno",
                    "                       AND t2.pmdsent = ",g_enterprise,
                    "                       AND t2.pmds006 IN ",l_xmdk003_sql,
                    "                       AND t1.pmdsstus != 'X'",
                    "                       AND t2.pmdsstus != 'X'",
                    "                    UNION ALL",
                    "                    SELECT t1.pmds053, t1.pmds041",
                    "                      FROM pmds_t t1,",   --倉退
                    "                           pmds_t t2,",   --入庫
                    "                           pmds_t t3 ",   --收貨
                    "                     WHERE t1.pmdsent = t2.pmdsent",
                    "                       AND t1.pmdsdocno = t2.pmds006",
                    "                       AND t2.pmdsent = t3.pmdsent",
                    "                       AND t2.pmds006 = t3.pmdsdocno",
                    "                       AND t1.pmdsstus != 'X'",
                    "                       AND t2.pmdsstus != 'X'",
                    "                       AND t3.pmdsstus != 'X'",
                    "                       AND t3.pmdsent = ",g_enterprise,
                    "                       AND t3.pmds006 IN ",l_xmdk003_sql,
                    "                    UNION ALL",
                    "                    SELECT t1.pmds053,t1.pmds041",
                    "                      FROM pmds_t t1,",  --倉退
                    "                           pmds_t t2 ",  --收貨入庫
                    "                     WHERE t1.pmdsent = t2.pmdsent",
                    "                       AND t1.pmds006 = t2.pmdsdocno",
                    "                       AND t1.pmdsstus != 'X'",
                    "                       AND t2.pmdsstus != 'X'",
                    "                       AND t2.pmdsent = ",g_enterprise,
                    "                       AND t2.pmds006 IN ",l_xmdk003_sql,
                    "           ) c",
                    "             WHERE c.pmds041 = d.pmds041 and c.pmds053 = d.pmds053)"
   
      
  
   #Invoice單
               #站别/营运据点/据点名称/单据性质/单据号码/账款对象/对象名称/币别/总未税金额/总税额/总含税金额
   LET r_sql = "SELECT DISTINCT icab002,icab003,'','6',xmdodocno,xmdo008,'',xmdo016,xmdo050,xmdo052,xmdo051,",
               #收款条件/收款条件名称/税别/税别名称/发票类型/发票类型名称/结关日期/多角序号/多角流程代碼
               "       xmdo010,'',xmdo012,'',xmdo015,'',xmdodocdt,xmdo055,xmdo056",
               "  FROM icab_t,xmdo_t",
               "  LEFT OUTER JOIN xmdp_t ON xmdoent = xmdpent AND xmdodocno = xmdpdocno",
               " WHERE xmdoent = icabent",
               "   AND xmdosite = icab003",
               "   AND xmdostus != 'X'",
               "   AND xmdoent = ",g_enterprise,
               "   AND icab001 = '",p_xmdk044,"'",     #多角流程代碼
               "   AND xmdo056 = '",p_xmdk044,"'",     #多角流程代碼
#               "   AND (xmdo055 = '",p_xmdk035,"'",    #多角流程序號  #161227-00049#1 mark
#               "    OR xmdp003 IN ",l_xmdk003_sql,    #161227-00049#1 mark
#                       l_xmdl_sql,"xmdo055))"         #161227-00049#1 mark
               "   AND xmdo005 = '",p_xmdkdocno,"'"    #161227-00049#1 add                       
               #161227-00049#1 add
   #出貨單 銷退單 簽收單 簽退單
   LET r_sql = r_sql," UNION ALL ",
               #站别/营运据点/据点名称
               "SELECT DISTINCT icab002,icab003,'',",
               #单据性质
               "       CASE xmdk000 WHEN '1' THEN '8'",
               "                    WHEN '2' THEN '8'",     #151209-00008#1 add lujh
               "                    WHEN '4' THEN '17'",
               "                    WHEN '5' THEN '18'",
               "                    WHEN '6' THEN '13' END,",
               #单据号码/账款对象/对象名称/币别/总未税金额/总税额/总含税金额
               "       xmdkdocno,xmdk008,'',xmdk016,xmdk051,xmdk053,xmdk052,",
               #收款条件/收款条件名称/税别/税别名称/发票类型/发票类型名称/结关日期/多角序号/#多角流程代碼
               "       xmdk010,'',xmdk012,'',xmdk015,'',xmdk032,xmdk035,xmdk044",
               "  FROM icab_t,xmdk_t ", 
               "  LEFT OUTER JOIN xmdl_t ON xmdkent = xmdlent AND xmdkdocno = xmdldocno",
               " WHERE xmdkent = icabent",
               "   AND xmdksite = icab003",
               "   AND xmdkstus != 'X'",
               "   AND xmdl038 = 0 ",             #141114-00010#2 add lujh
               "   AND xmdkent = ",g_enterprise,
               "   AND icab001 = '",p_xmdk044,"'",     #多角流程代碼
               "   AND xmdk044 = '",p_xmdk044,"'",     #多角流程序號
               "   AND (xmdk035 = '",p_xmdk035,"'",    #多角流程序號
               #"    OR xmdl003 IN ",l_xmdk003_sql,    #161227-00049#1 mark
                       l_xmdl_sql,"xmdk035))"
   #160105-00016#2--add--str--lujh
   IF g_xmdk000 MATCHES '[12]' THEN 
      LET r_sql = r_sql," AND xmdk000 IN ('1','2','4') AND ",ls_scc   #170110-00009#1 add ls_scc lujh
   ELSE
      LET r_sql = r_sql," AND xmdk000 IN ('5','6') AND ",ls_scc       #170110-00009#1 add ls_scc lujh
   END IF
   #160105-00016#2--add--str--lujh
                      
   #收貨單 入庫單 倉退單
   LET r_sql = r_sql," UNION ALL ",
               #站别/营运据点/据点名称
               "SELECT DISTINCT icab002,icab003,'',",
               #单据性质
               "       CASE d.pmds000 WHEN '3' THEN '10'",
               "                      WHEN '4' THEN '10'",  #151209-00008#1 add lujh
               "                      WHEN '6' THEN '10'",
               "                      WHEN '20' THEN '10'",
               "                      WHEN '1' THEN '9'",     #151201-00009#1 add lujh
               "                      WHEN '7' THEN '14' END,",
               #单据号码/账款对象/对象名称/币别/总未税金额/总税额/总含税金额
               "       d.pmdsdocno,d.pmds008,'',d.pmds037,d.pmds043,d.pmds046,d.pmds044,",
               #收款条件/收款条件名称/税别/税别名称/发票类型/发票类型名称/结关日期/多角序号/多角流程代碼
               "       d.pmds031,'',d.pmds033,'','','',d.pmds001,d.pmds041,d.pmds053",
               "  FROM icab_t,pmds_t d ",     
               "  LEFT OUTER JOIN pmdt_t ON d.pmdsent = pmdtent AND d.pmdsdocno = pmdtdocno",
               " WHERE d.pmdsent = icabent",
               "   AND d.pmdssite = icab003",
               "   AND d.pmdsstus != 'X'",
               "   AND pmdt056 = 0 ",                #141114-00010#2 add lujh
               "   AND d.pmdsent = ",g_enterprise,
               "   AND icab001 = '",p_xmdk044,"'",       #多角流程代碼
               "   AND (d.pmds041 = '",p_xmdk035,"'",    #多角流程序號
                       l_pmds_sql,")"
   #160105-00016#2--add--str--lujh
   IF g_xmdk000 MATCHES '[12]' THEN 
      LET r_sql = r_sql," AND pmds000 IN ('1','3','4','6','20')"
   ELSE
      LET r_sql = r_sql," AND pmds000 IN ('7')"
   END IF
   #160105-00016#2--add--str--lujh                    
                       
   LET r_sql = cl_sql_add_mask(r_sql)              #遮蔽特定資料
   
   LET r_sql = r_sql," ORDER BY icab002" 
   
   RETURN r_sql
END FUNCTION
# 抓取站点对应的设置
PRIVATE FUNCTION axrp141_icae_get(p_icab002,p_xmdk044)
   DEFINE p_icab002          LIKE icab_t.icab002
   DEFINE p_xmdk044          LIKE xmdk_t.xmdk044
   DEFINE r_icae003          LIKE icae_t.icae003
   DEFINE r_icae004          LIKE icae_t.icae004
   DEFINE r_icae007          LIKE icae_t.icae007
   DEFINE r_icae008          LIKE icae_t.icae008
   DEFINE r_icae016          LIKE icae_t.icae016
   DEFINE r_icae018          LIKE icae_t.icae018
   DEFINE r_icae020          LIKE icae_t.icae020    #160714-00029#2 add lujh  
   DEFINE l_site_str         STRING                 #170116-00036#1 add lujh
   DEFINE r_ld               LIKE glaa_t.glaald
   DEFINE l_comp             LIKE glaa_t.glaacomp
   DEFINE l_success          LIKE type_t.num5
   DEFINE l_icab003          LIKE icab_t.icab003
   
   #应收单别/应付单别/应收折让单别/应付折让单别/账务中心/账款类别
   SELECT icae003,icae004,icae007,icae008,icae016,icae018,icae020                   #160714-00029#2 add icae020 lujh  
     INTO r_icae003,r_icae004,r_icae007,r_icae008,r_icae016,r_icae018,r_icae020     #160714-00029#2 add r_icae020 lujh  
     FROM icae_t
    WHERE icaeent = g_enterprise
      AND icae001 = p_xmdk044
      AND icae002 = p_icab002
    
   #150724-00007#1--by--02599--mod--str--  
   #帐套改取站点归属法人的主账套
   SELECT icab003 INTO l_icab003 FROM icab_t
    WHERE icabent = g_enterprise
      AND icab001 = p_xmdk044
      AND icab002 = p_icab002
      
   #170116-00036#1--add--str--lujh   
   CALL s_axrt300_get_site(g_user,'','1') RETURNING l_site_str   
   IF s_chr_get_index_of(l_site_str,l_icab003,1) = 0 THEN
      CALL s_axrp133_success_tmp_ins('','',0,0,'afa-01118','N')
   END IF   
   #170116-00036#1--add--end--lujh   
      
   #账务中心对应的主账套
#   CALL s_fin_orga_get_comp_ld(r_icae016) RETURNING l_success,g_errno,l_comp,r_ld 
   CALL s_fin_orga_get_comp_ld(l_icab003) RETURNING l_success,g_errno,l_comp,r_ld  
   #150724-00007#1--by--02599--mod--end  
   RETURN r_icae003,r_icae004,r_icae007,r_icae008,r_icae016,r_icae018,r_ld,r_icae020   
END FUNCTION

################################################################################
# Descriptions...: 调用axrp133的立账逻辑产生账款
# Memo...........:
# Usage..........: CALL axrp141_call_axrp133(p_wc,p_ld,p_docno,p_icab002,p_icab003,p_date,p_comb1,p_comb2,p_style,p_xrcadocno,p_xmdk035,p_xmdk044,p_xmdk008,p_no,p_icae016)
# Input parameter: p_wc           出货/销退单号字符串
#                : p_ld           账套
#                : p_docno        出货/销退单号
#                : p_icab002      站点 
#                : p_icab003      营运据点
#                : p_date         账款日期
#                : p_comb1        汇率基准
#                : p_comb2        产生方式
#                : p_style        立账依据
#                : p_xrcadocno    立账单别
#                : p_icae018      账款类别
#                : p_xmdk035      多角序号
#                : p_xmdk044      多角代码
#                : p_xmdk008      账款对象
#                : p_no           多角流程序号 
#                : p_icae016      账务中心
# Date & Author..: 2015/04/24 By lujh
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp141_call_axrp133(p_wc,p_ld,p_docno,p_icab002,p_icab003,p_date,p_comb1,p_comb2,p_style,p_xrcadocno,p_icae018,p_xmdk035,p_xmdk044,p_xmdk008,p_no,p_icae016)
   DEFINE p_wc              STRING 
   DEFINE p_ld              LIKE glaa_t.glaald 
   DEFINE p_docno           LIKE xmdk_t.xmdkdocno
   DEFINE p_icab002         LIKE icab_t.icab002
   DEFINE p_icab003         LIKE icab_t.icab003
   DEFINE p_date            LIKE xrca_t.xrcadocdt
   DEFINE p_comb1           LIKE type_t.chr10
   DEFINE p_comb2           LIKE type_t.chr10
   DEFINE p_style           LIKE type_t.chr10
   DEFINE p_xrcadocno       LIKE xrca_t.xrcadocno
   DEFINE p_icae018         LIKE icae_t.icae018
   DEFINE p_xmdk035         LIKE xmdk_t.xmdk035
   DEFINE p_xmdk044         LIKE xmdk_t.xmdk044
   DEFINE p_xmdk008         LIKE xmdk_t.xmdk008
   DEFINE p_type            LIKE type_t.chr10    
   DEFINE p_no              LIKE xrca_t.xrca047        #141114-00010#2 add lujh  
   DEFINE p_icae016         LIKE icae_t.icae016
   DEFINE l_n               LIKE type_t.num5
   DEFINE l_xrca047         LIKE xrca_t.xrca047
   DEFINE l_tot_success     LIKE type_t.num5
   DEFINE l_start_no        LIKE xrca_t.xrcadocno
   DEFINE l_end_no          LIKE xrca_t.xrcadocno
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_sql             STRING
   DEFINE l_comp            LIKE xrca_t.xrcacomp   #151125-00006#1--add aiqq
   
   #调用axrp133的立账逻辑
   CALL s_axrp133_get_data(p_wc,p_ld,p_icae016,p_date,p_style,p_comb1,p_comb2)
   RETURNING g_xmdk_d
   
   IF g_success = 'Y' THEN
      CALL s_axrt300_create_tmp()
  
      CALL s_axrp133_get_ar(p_ld,p_xrcadocno,p_date,p_style,p_icae016,p_icae018,p_comb1,p_comb2,
                            'N','N','N','N','N','N',g_xmdk_d,l_xrca047)
      RETURNING l_tot_success,l_start_no,l_end_no
      
      IF NOT cl_null(l_start_no) THEN 
         CALL s_transaction_begin()
         
         #141114-00010#2--mark--str--lujh
         ##呼叫產生多角流程序號元件(wait)
         #CALL s_aic_carry_gettrino(p_xmdk044,p_type,g_today,p_icab003)
         #RETURNING l_success,l_xrca047
         #
         #IF NOT l_success THEN
         #   CALL s_axrp133_success_tmp_ins('','',0,0,'axr-00331','N')
         #   CALL axrp141_fail(p_docno,p_xmdk035,p_xmdk044,'',p_icab002,p_icab003,p_comb2)
         #   CALL s_transaction_end('N','0')
         #   RETURN 
         #ELSE
         #141114-00010#2--mark--end--lujh
            LET l_sql = "UPDATE xrca_t SET xrca047 = '",p_no,"'",    #141114-00010#2 change l_xrca047 to p_no lujh
                        " WHERE xrcaent = '",g_enterprise,"'",
                        "   AND xrcald = '",p_ld,"'",
                        "   AND xrcadocno BETWEEN '",l_start_no,"' AND '",l_end_no,"'"
            PREPARE axrp141_upd_pre FROM l_sql 
            EXECUTE axrp141_upd_pre     
            
            CALL s_transaction_end('Y','0') 
         #END IF  #141114-00010#2 mark lujh
      END IF          
      
   END IF
   #axrp133的立账逻辑结束
   
   #判断是否有执行错误的资料                                        
   SELECT COUNT(*) INTO l_n FROM axrp133_s_tmp WHERE success = 'N'
   IF l_n > 0 THEN 
      #将执行有误的资料显示出来
      CALL axrp141_fail(p_docno,p_xmdk035,p_xmdk044,p_xmdk008,p_icab002,p_icab003,p_comb2)
   END IF
   
   #判断是否有执行成功的资料
   SELECT COUNT(*) INTO l_n FROM axrp133_s_tmp WHERE success = 'Y'
   IF l_n > 0 THEN 
      #将执行成功的资料显示出来
      CALL axrp141_success(p_docno,p_xmdk035,p_xmdk044,p_xmdk008,p_icab002,p_icab003,'1',p_no,'1',p_style)   #141114-00010#2 change l_xrca047 to p_no lujh
   END IF  
END FUNCTION

################################################################################
# Descriptions...: 调用aapp133的立账逻辑产生账款
# Memo...........:
# Usage..........: CALL axrp141_call_aapp133(p_wc,p_site,p_apcald,p_sel1,p_slip1,p_apca007,p_docdt,p_rate1,p_sel2,p_docno,p_icab002,p_icab003,p_xmdk035,p_xmdk044,p_xmdk008,p_no,p_comb2)
# Input parameter: p_wc           入库/仓退单号字符串
#                : p_site         账务中心
#                : p_apcald       账套
#                : p_sel1         立账方式
#                : p_slip1        账款单别
#                : p_apca007      账款类别
#                : p_docdt        立账日期
#                : p_rate1        汇率基准
#                : p_sel2         汇总条件 
#                : p_docno        入库/仓退单号
#                : p_icab002      站点
#                : p_icab003      营运据点
#                : p_xmdk035      多角序号
#                : p_xmdk044      多角代码
#                : p_xmdk008      账款对象
#                : p_no           多角流程序号
#                : p_comb2        汇总方式
# Date & Author..: 2015/04/25 By lujh
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp141_call_aapp133(p_wc,p_site,p_apcald,p_sel1,p_slip1,p_apca007,p_docdt,p_rate1,p_sel2,p_docno,p_icab002,p_icab003,p_xmdk035,p_xmdk044,p_xmdk008,p_no,p_comb2)
   DEFINE p_wc               STRING
   DEFINE p_site             LIKE apca_t.apcasite
   DEFINE p_apcald           LIKE apca_t.apcald
   DEFINE p_sel1             LIKE type_t.chr1
   DEFINE p_slip1            LIKE apca_t.apcadocno
   DEFINE p_apca007          LIKE apca_t.apca007
   DEFINE p_docdt            LIKE apca_t.apcadocno
   DEFINE p_rate1            LIKE type_t.chr1
   DEFINE p_sel2             LIKE type_t.chr1
   DEFINE p_docno            LIKE pmdt_t.pmdtdocno
   DEFINE p_icab002          LIKE icab_t.icab002 
   DEFINE p_icab003          LIKE icab_t.icab003
   DEFINE p_xmdk035          LIKE xmdk_t.xmdk035
   DEFINE p_xmdk044          LIKE xmdk_t.xmdk044
   DEFINE p_xmdk008          LIKE xmdk_t.xmdk008
   DEFINE p_type             LIKE type_t.chr10
   DEFINE p_no               LIKE apca_t.apca047        #141114-00010#2 add lujh  
   DEFINE p_comb2            LIKE type_t.chr10
   DEFINE l_wc2              STRING
   DEFINE l_wc_apcasite      STRING
   DEFINE l_success          LIKE type_t.num5
   DEFINE l_n                LIKE type_t.num5
   DEFINE l_apca047          LIKE apca_t.apca047
   DEFINE l_strno            LIKE apca_t.apcadocno
   DEFINE l_endno            LIKE apca_t.apcadocno
   DEFINE l_sql              STRING
   
   LET l_wc2 = " 1=1 "
   
   CALL s_fin_account_center_sons_query('3',p_site,g_today,'1')
   #取得帳務中心底下之組織範圍
   CALL s_fin_account_center_sons_str() RETURNING l_wc_apcasite
   IF cl_null(l_wc_apcasite) THEN LET l_wc_apcasite = p_site END IF
   CALL s_fin_get_wc_str(l_wc_apcasite) RETURNING l_wc_apcasite
   
   
   #调用axrp133的立账逻辑
   CALL s_aapp133_process(p_wc,p_site,p_apcald,p_sel1,p_slip1,p_apca007,p_docdt,
                          '','',p_rate1,p_sel2,'N','N','N','N','N','N',l_wc2,l_wc_apcasite,l_apca047)
   RETURNING l_strno,l_endno
   
   IF NOT cl_null(l_strno) THEN 
      CALL s_transaction_begin()  
      
      #141114-00010#2--mark--str--lujh
      ##呼叫產生多角流程序號元件(wait)
      #CALL s_aic_carry_gettrino(p_xmdk044,p_type,g_today,p_site)
      #RETURNING l_success,l_apca047
      #
      #IF NOT l_success THEN
      #   CALL s_axrp133_success_tmp_ins('','',0,0,'axr-00331','N')
      #   CALL axrp141_fail(p_docno,p_xmdk035,p_xmdk044,'',p_icab002,p_icab003,p_comb2)
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #ELSE
      #141114-00010#2--mark--end--lujh
         LET l_sql = "UPDATE apca_t SET apca047 = '",p_no,"'",     #141114-00010#2 change l_apca047 to p_no lujh
                     " WHERE apcaent = '",g_enterprise,"'",
                     "   AND apcald = '",p_apcald,"'",
                     "   AND apcadocno BETWEEN '",l_strno,"' AND '",l_endno,"'"
         PREPARE axrp141_upd_pre1 FROM l_sql 
         EXECUTE axrp141_upd_pre1 
         CALL s_transaction_end('Y','0')
      #END IF    #141114-00010#2 mark lujh
   END  IF
                     
   #判断是否有执行错误的资料                                        
   SELECT COUNT(*) INTO l_n FROM axrp133_s_tmp WHERE success = 'N'
   IF l_n > 0 THEN 
      #将执行有误的资料显示出来
      CALL axrp141_fail(p_docno,p_xmdk035,p_xmdk044,p_xmdk008,p_icab002,p_icab003,p_comb2)
   END IF
   
   #判断是否有执行成功的资料
   SELECT COUNT(*) INTO l_n FROM axrp133_s_tmp WHERE success = 'Y'
   IF l_n > 0 THEN 
      #将执行成功的资料显示出来
      CALL axrp141_success(p_docno,p_xmdk035,p_xmdk044,p_xmdk008,p_icab002,p_icab003,'1',p_no,'2',p_sel1)  #141114-00010#2 change l_apca047 to p_no lujh
   END IF                    
END FUNCTION

#end add-point
 
{</section>}
 
