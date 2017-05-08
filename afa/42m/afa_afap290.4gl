#該程式未解開Section, 採用最新樣板產出!
{<section id="afap290.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0011(2014-09-20 21:13:18), PR版次:0011(2017-01-13 09:33:41)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000123
#+ Filename...: afap290
#+ Description: 資產傳票拋轉總帳還原作業
#+ Creator....: 02599(2014-08-10 00:00:00)
#+ Modifier...: 02599 -SD/PR- 07900
 
{</section>}
 
{<section id="afap290.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#7   2016/04/20 By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160426-00014#10  2016/07/25 By 01531       单据性质增加39调整
#160125-00005#7   2016/08/09 By 01531       查詢時加上帳套人員權限條件過濾
#160913-00017#1   2016/09/23 By 07900       AFA模组调整交易客商开窗
#160426-00014#45  2016/10/31 By 02114       增加afat517的逻辑
#160426-00014#44  2016/11/03 By 02114       增加afat510的逻辑
#161215-00044#1   2016/12/15 by 02481       标准程式定义采用宣告模式,弃用.*写
#170103-00019#11  2017/01/04 By 02599       1.凭证还原时，同步更新细项立冲账资料；2.当'S-COM-0002'=Y限定单据连号时, 采用凭证作废处理
#170106-00029#1   2017/01/13 By 07900       来源类型加上23盘盈、24盘亏
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
        glaald          LIKE glaa_t.glaald,
        glaald_desc     LIKE type_t.chr80,
        glaacomp        LIKE glaa_t.glaacomp,
        glaacomp_desc   LIKE type_t.chr80,
        fabg005         LIKE fabg_t.fabg005,
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
     sel           LIKE type_t.chr1,
     glapld        LIKE glap_t.glapld,
     glapdocno     LIKE glap_t.glapdocno,
     glapdocdt     LIKE glap_t.glapdocdt,
     glap010       LIKE glap_t.glap010,
     glap011       LIKE glap_t.glap011,
     glapstus      LIKE glap_t.glapstus,
     glap012       LIKE glap_t.glap012
     END RECORD
     
TYPE type_g_detail2_d RECORD
#add-point:自定義模組變數(Module Variable)
     b_type        LIKE type_t.chr100,
     fabgld        LIKE fabg_t.fabgld,
     fabgdocno     LIKE fabg_t.fabgdocno,
     fabgdocdt     LIKE fabg_t.fabgdocdt,
     fabh004       LIKE fabh_t.fabh004,
     fabh010       LIKE fabh_t.fabh010,
     fabh012       LIKE fabh_t.fabh012,
     fabh019       LIKE fabh_t.fabh019,
     fabo010       LIKE fabo_t.fabo010,
     fabo012       LIKE fabo_t.fabo012,
     fabo013       LIKE fabo_t.fabo013,
     fabo014       LIKE fabo_t.fabo014,
     fabo015       LIKE fabo_t.fabo015,
     fabo016       LIKE fabo_t.fabo016,
     fabo017       LIKE fabo_t.fabo017
     END RECORD     
               
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
DEFINE g_detail2_d    DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_input        type_parameter
DEFINE g_rec_b        LIKE type_t.num5 
DEFINE l_cnt          LIKE type_t.num5
DEFINE g_detail_idx   LIKE type_t.num5
DEFINE la_param  RECORD
          prog   STRING,
          param  DYNAMIC ARRAY OF STRING
                 END RECORD
DEFINE ls_js     STRING
DEFINE g_glaald          LIKE glaa_t.glaald
DEFINE g_fabgdocno_p     LIKE fabg_t.fabgdocno
#161215-00044#1---modify----begin-----------------
#DEFINE g_glaa        RECORD LIKE glaa_t.*
DEFINE g_glaa RECORD  #帳套資料檔
       glaaent LIKE glaa_t.glaaent, #企業編號
       glaaownid LIKE glaa_t.glaaownid, #資料所有者
       glaaowndp LIKE glaa_t.glaaowndp, #資料所屬部門
       glaacrtid LIKE glaa_t.glaacrtid, #資料建立者
       glaacrtdp LIKE glaa_t.glaacrtdp, #資料建立部門
       glaacrtdt LIKE glaa_t.glaacrtdt, #資料創建日
       glaamodid LIKE glaa_t.glaamodid, #資料修改者
       glaamoddt LIKE glaa_t.glaamoddt, #最近修改日
       glaastus LIKE glaa_t.glaastus, #狀態碼
       glaald LIKE glaa_t.glaald, #帳套編號
       glaacomp LIKE glaa_t.glaacomp, #歸屬法人
       glaa001 LIKE glaa_t.glaa001, #使用幣別
       glaa002 LIKE glaa_t.glaa002, #匯率參照表號
       glaa003 LIKE glaa_t.glaa003, #會計週期參照表號
       glaa004 LIKE glaa_t.glaa004, #會計科目參照表號
       glaa005 LIKE glaa_t.glaa005, #現金變動參照表號
       glaa006 LIKE glaa_t.glaa006, #月結方式
       glaa007 LIKE glaa_t.glaa007, #年結方式
       glaa008 LIKE glaa_t.glaa008, #平行記帳否
       glaa009 LIKE glaa_t.glaa009, #傳票登入方式
       glaa010 LIKE glaa_t.glaa010, #現行年度
       glaa011 LIKE glaa_t.glaa011, #現行期別
       glaa012 LIKE glaa_t.glaa012, #最後過帳日期
       glaa013 LIKE glaa_t.glaa013, #關帳日期
       glaa014 LIKE glaa_t.glaa014, #主帳套
       glaa015 LIKE glaa_t.glaa015, #啟用本位幣二
       glaa016 LIKE glaa_t.glaa016, #本位幣二
       glaa017 LIKE glaa_t.glaa017, #本位幣二換算基準
       glaa018 LIKE glaa_t.glaa018, #本位幣二匯率採用
       glaa019 LIKE glaa_t.glaa019, #啟用本位幣三
       glaa020 LIKE glaa_t.glaa020, #本位幣三
       glaa021 LIKE glaa_t.glaa021, #本位幣三換算基準
       glaa022 LIKE glaa_t.glaa022, #本位幣三匯率採用
       glaa023 LIKE glaa_t.glaa023, #次帳套帳務產生時機
       glaa024 LIKE glaa_t.glaa024, #單據別參照表號
       glaa025 LIKE glaa_t.glaa025, #本位幣一匯率採用
       glaa026 LIKE glaa_t.glaa026, #幣別參照表號
       glaa100 LIKE glaa_t.glaa100, #傳票輸入時自動按缺號產生
       glaa101 LIKE glaa_t.glaa101, #傳票總號輸入時機
       glaa102 LIKE glaa_t.glaa102, #傳票成立時,借貸不平衡的處理方式
       glaa103 LIKE glaa_t.glaa103, #未列印的傳票可否進行過帳
       glaa111 LIKE glaa_t.glaa111, #應計調整單別
       glaa112 LIKE glaa_t.glaa112, #期末結轉單別
       glaa113 LIKE glaa_t.glaa113, #年底結轉單別
       glaa120 LIKE glaa_t.glaa120, #成本計算類型
       glaa121 LIKE glaa_t.glaa121, #子模組啟用分錄底稿
       glaa122 LIKE glaa_t.glaa122, #總帳可維護資金異動明細
       glaa027 LIKE glaa_t.glaa027, #單據據點編號
       glaa130 LIKE glaa_t.glaa130, #合併帳套否
       glaa131 LIKE glaa_t.glaa131, #分層合併
       glaa132 LIKE glaa_t.glaa132, #平均匯率計算方式
       glaa133 LIKE glaa_t.glaa133, #非T100公司匯入餘額類型
       glaa134 LIKE glaa_t.glaa134, #合併科目轉換依據異動碼設定值
       glaa135 LIKE glaa_t.glaa135, #現流表間接法群組參照表號
       glaa136 LIKE glaa_t.glaa136, #應收帳款核銷限定己立帳傳票
       glaa137 LIKE glaa_t.glaa137, #應付帳款核銷限定已立帳傳票
       glaa138 LIKE glaa_t.glaa138, #合併報表編制期別
       glaa139 LIKE glaa_t.glaa139, #遞延收入(負債)管理產生否
       glaa140 LIKE glaa_t.glaa140, #無原出貨單的遞延負債減項者,是否仍立遞延收入管理?
       glaa123 LIKE glaa_t.glaa123, #應收帳款核銷可維護資金異動明細
       glaa124 LIKE glaa_t.glaa124, #應付帳款核銷可維護資金異動明細
       glaa028 LIKE glaa_t.glaa028  #匯率來源
       END RECORD

#161215-00044#1---modify----end-----------------
DEFINE l_success     LIKE type_t.num5
DEFINE g_wc_cs_ld    STRING      #160125-00005#7
#end add-point
 
{</section>}
 
{<section id="afap290.main" >}
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
   CALL cl_ap_init("afa","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afap290 WITH FORM cl_ap_formpath("afa",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afap290_init()   
 
      #進入選單 Menu (="N")
      CALL afap290_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_afap290
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   DROP TABLE afap290_tmp;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="afap290.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION afap290_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   DEFINE l_success   LIKE type_t.num5
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
  #CALL cl_set_combo_scc_part('fabg005','9910','0,1,4,6,7,8,14')
   CALL cl_set_combo_scc_part('fabg005','9910','0,1,4,6,8,9,14,21,23,24,31,39,43,44')   #150417-00007#65 add '31'  #160426-00014#10 add '39'  #160426-00014#45 add 43 lujh #160426-00014#44 add 44 lujh  #170106-00029#1 add 23,24
   CALL cl_set_combo_scc_part('glapstus','50','N,Y,S')
   CALL afap290_default_search()
   IF NOT cl_null(g_argv[1]) THEN
      LET g_glaald=g_argv[1]
   END IF
   IF NOT cl_null(g_argv[02]) THEN
      LET g_fabgdocno_p=g_argv[02]
      DISPLAY g_fabgdocno_p TO fabgdocno
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_input.fabg005=g_argv[03]
      DISPLAY g_input.fabg005 TO fabg005
   END IF
   IF cl_null(g_glaald) THEN
      #抓取预设帐别
      CALL s_ld_bookno() RETURNING l_success,g_glaald
      IF l_success = FALSE THEN
         LET g_glaald=NULL
         RETURN
      END IF
      CALL s_ld_chk_authorization(g_user,g_glaald) RETURNING l_success
      IF l_success = FALSE THEN
         LET g_glaald=NULL
         RETURN
      END IF
   END IF
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afap290.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afap290_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_slip         LIKE fabg_t.fabgdocno
   DEFINE l_oobx004      LIKE oobx_t.oobx004  
   DEFINE l_n            LIKE type_t.num5
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CLEAR FORM 
   DISPLAY BY NAME g_input.glaald,g_input.glaald_desc,g_input.glaacomp,g_input.glaacomp_desc,g_input.fabg005
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL afap290_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_input.glaald,g_input.glaald_desc,g_input.glaacomp,g_input.glaacomp_desc,g_input.fabg005
               ATTRIBUTE(WITHOUT DEFAULTS)
           
             BEFORE INPUT
               #帳套
               IF cl_null(g_input.glaald) THEN 
                  LET g_input.glaald=g_glaald
               END IF
               CALL afap290_glaald_desc()
               #來源類型
#               IF cl_null(g_input.fabg005) OR g_input.fabg005=0 THEN   #mark by yangxf
                IF cl_null(g_input.fabg005) THEN                        #add by yangxf
                  LET g_input.fabg005 = ''
                  DISPLAY BY NAME g_input.fabg005
               END IF
               CALL cl_set_comp_visible("folder_2",TRUE)
               CALL cl_set_comp_visible("fabgdocno,fabgdocdt,fabg006",TRUE) 
               IF g_input.fabg005 <> '4' THEN
#                  IF g_input.fabg005 = '0' THEN      #mark by yangxf
                  IF cl_null(g_input.fabg005) THEN    #add by yangxf
                     CALL cl_set_comp_visible("folder_2",FALSE)
                     CALL cl_set_comp_visible("fabgdocno,fabgdocdt,fabg006",FALSE) 
                  ELSE
                     CALL cl_set_comp_visible("fabh004,fabh010,fabh012,fabh019",TRUE)
                     CALL cl_set_comp_visible("fabo010,fabo012,fabo013,fabo014,fabo015,fabo016,fabo017",FALSE)
                  END IF
               ELSE
                  CALL cl_set_comp_visible("fabh004,fabh010,fabh012,fabh019",FALSE)
                  CALL cl_set_comp_visible("fabo010,fabo012,fabo013,fabo014,fabo015,fabo016,fabo017",TRUE)
               END IF 
               IF NOT cl_null(g_fabgdocno_p) THEN
                  DISPLAY g_fabgdocno_p TO fabgdocno
               END IF
               
            AFTER FIELD glaald
               CALL afap290_glaald_desc()
               IF NOT cl_null(g_input.glaald) THEN 
#此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_input.glaald
                  #160318-00025#7--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
                  #160318-00025#7--add--end   
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_glaald_1") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                     #检查使用者是否有权限使用当前账别
                     CALL s_ld_chk_authorization(g_user,g_input.glaald) RETURNING l_success
                     IF l_success = FALSE THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'axr-00022'
                        LET g_errparam.extend = g_input.glaald
                        LET g_errparam.popup = FALSE
                        CALL cl_err()
                    
                        LET g_input.glaald = ''
                        NEXT FIELD glaald
                     END IF
                  ELSE
                     #檢查失敗時後續處理
                     LET g_input.glaald = ''
                     CALL afap290_glaald_desc()
                     NEXT FIELD CURRENT
                  END IF

               END IF
            ON CHANGE fabg005
               CALL cl_set_comp_visible("folder_2",TRUE)
               CALL cl_set_comp_visible("fabgdocno,fabgdocdt,fabg006",TRUE) 
               IF g_input.fabg005 <> '4' THEN
                  IF g_input.fabg005 = '0' THEN
                     CALL cl_set_comp_visible("fabgdocno,fabgdocdt,fabg006",FALSE) 
                     CALL cl_set_comp_visible("folder_2",FALSE)
                  ELSE
                     CALL cl_set_comp_visible("fabh004,fabh010,fabh012,fabh019",TRUE)
                     CALL cl_set_comp_visible("fabo010,fabo012,fabo013,fabo014,fabo015,fabo016,fabo017",FALSE)
                  END IF
               ELSE
                  CALL cl_set_comp_visible("fabh004,fabh010,fabh012,fabh019",FALSE)
                  CALL cl_set_comp_visible("fabo010,fabo012,fabo013,fabo014,fabo015,fabo016,fabo017",TRUE)
               END IF               
               
               
            ON ACTION controlp INFIELD glaald
      			INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
      			LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.glaald                    #給予default值
               LET g_qryparam.arg1 = g_user                                 #人員權限
               LET g_qryparam.arg2 = g_dept                                 #部門權限
               #160125-00005#7--add--str
               #账套范围
               CALL s_axrt300_get_site(g_user,'','2')  RETURNING g_wc_cs_ld 
               IF NOT cl_null(g_wc_cs_ld) THEN   
                  LET g_qryparam.where = g_wc_cs_ld
               END IF
               #160125-00005#7--add--end                             
               CALL q_authorised_ld()                                       #呼叫開窗
               LET g_input.glaald = g_qryparam.return1                     #將開窗取得的值回傳到變數
               CALL afap290_glaald_desc()
               NEXT FIELD glaald                                            #返回原欄位
               
         END INPUT
         
         #查詢QBE
         CONSTRUCT BY NAME g_wc ON fabgdocno,fabgdocdt,fabg006,fabg008,glapcrtid

            BEFORE CONSTRUCT
               CALL cl_qbe_init()
            
            AFTER CONSTRUCT
               #呼叫P次作業
               
            ON ACTION controlp INFIELD fabgdocno
   	         INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
   	         LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " fabg005='",g_input.fabg005,"'"
   	         CALL q_fabgdocno()
               DISPLAY g_qryparam.return1 TO fabgdocno  #顯示到畫面上  
               NEXT FIELD fabgdocno                     #返回原欄位  
               
            ON ACTION controlp INFIELD fabg006
   	         INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #CALL q_pmaa001()    #160913-00017#1  mark               #呼叫開窗
               CALL q_pmaa001_25() #160913-00017#1  add 
               DISPLAY g_qryparam.return1 TO fabg006  #顯示到畫面上
               NEXT FIELD fabg006                     #返回原欄位 
   
            ON ACTION controlp INFIELD fabg008
   	         INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
   	         LET g_qryparam.reqry = FALSE
   	         IF g_input.fabg005 = '0' THEN  #若為折舊，則抓faam024的資料
   	            CALL q_faam024()
   	         ELSE
   	            CALL q_fabg008()
   	         END IF
               DISPLAY g_qryparam.return1 TO fabg008  #顯示到畫面上  
               NEXT FIELD fabg008                     #返回原欄位  
               
            ON ACTION controlp INFIELD glapcrtid
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO glapcrtid  #顯示到畫面上

               NEXT FIELD glapcrtid                     #返回原欄位
               
         END CONSTRUCT
         
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
               LET l_ac = ARR_CURR()
               LET g_master_idx = l_ac
               DISPLAY l_ac TO FORMONLY.h_index
               CALL afap290_fetch() 
               IF l_ac>0 THEN
                  CALL afap290_fabg_fill()
               END IF                  
               
            ON CHANGE sel
               IF g_detail_d[l_ac].glapstus = 'Y' OR g_detail_d[l_ac].glapstus = 'S' THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = 'axr-00153'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  
                  LET g_detail_d[l_ac].sel = 'N'
                  EXIT DIALOG
               END IF
               UPDATE afap290_tmp 
                  SET sel = g_detail_d[l_ac].sel 
                WHERE glapdocno = g_detail_d[l_ac].glapdocno 
            
            ON ACTION modify_detail
               LET la_param.prog = 'aglt310'
               LET la_param.param[1] = g_input.glaald
               LET la_param.param[2] = g_detail_d[l_ac].glapdocno
               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun(ls_js)           
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_detail2_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_cnt = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_detail2_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_cnt

            ON ACTION modify_detail
#               CALL s_aooi200_get_slip(g_detail2_d[l_cnt].fabgdocno)           #mark by yangxf
               CALL s_aooi200_fin_get_slip_desc(g_detail2_d[l_cnt].fabgdocno)   #add by yangxf
               RETURNING l_success,l_slip
               SELECT oobx004 INTO l_oobx004 FROM oobx_t WHERE oobxent = g_enterprise AND oobx001 = l_slip
               IF l_oobx004 = 'MULTI' THEN 
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.arg1 = l_slip
                  CALL q_oobl002()                                
                  LET l_oobx004 = g_qryparam.return1           
               END IF
               
               LET la_param.prog = l_oobx004
               LET la_param.param[1] = g_detail2_d[l_cnt].fabgld
               LET la_param.param[2] = g_detail2_d[l_cnt].fabgdocno
               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun(ls_js)
            #自訂ACTION(detail_show,page_1)
            
               
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
            NEXT FIELD glaald
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
               IF g_detail_d[li_idx].glapstus = 'Y' OR g_detail_d[li_idx].glapstus = 'S' THEN 
                  LET g_detail_d[li_idx].sel = 'N'
               END IF
               IF g_detail_d[li_idx].sel = "Y" THEN
                  UPDATE afap290_tmp 
                     SET sel = g_detail_d[li_idx].sel 
                   WHERE glapdocno = g_detail_d[li_idx].glapdocno
               END IF
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
            UPDATE afap290_tmp SET sel = "N" 
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
                  IF g_detail_d[li_idx].glapstus = 'Y' OR g_detail_d[li_idx].glapstus = 'S' THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = 'axr-00153'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                     LET g_detail_d[li_idx].sel = 'N'
                  ELSE
                     LET g_detail_d[li_idx].sel = "Y"
                     UPDATE afap290_tmp 
                        SET sel = g_detail_d[li_idx].sel 
                      WHERE glapdocno = g_detail_d[li_idx].glapdocno
                  END IF
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
                  LET g_detail_d[li_idx].sel = "N"
                  UPDATE afap290_tmp 
                        SET sel = g_detail_d[li_idx].sel 
                      WHERE glapdocno = g_detail_d[li_idx].glapdocno
               END IF
            END FOR
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL afap290_filter()
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
            CALL afap290_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL afap290_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            SELECT COUNT(*) INTO l_n
              FROM afap290_tmp
             WHERE sel = 'Y'
            IF l_n = 0 THEN 
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = 'axr-00159' 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               
               EXIT DIALOG
            END IF
            
            CALL afap290_p()
            CALL afap290_b_fill()
            #20141106 add--str--
            #傳入g_argv[03]，判斷是否從其他程序調用，若是從其他程序調用，那麼還原成功后，關閉所有窗體，回到主畫面
            IF NOT cl_null(g_argv[03]) THEN
               LET INT_FLAG=FALSE         
               LET g_action_choice = "exit"
               EXIT DIALOG
            END IF   
            #20141106 add--end--            
                     
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
 
{<section id="afap290.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION afap290_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   
   #end add-point
        
   LET g_error_show = 1
   CALL afap290_b_fill()
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
 
{<section id="afap290.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afap290_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_success       LIKE type_t.num5
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   IF cl_null(g_wc) THEN 
      LET g_wc = "1=1"
   END IF
   
   CALL afap290_create_tmp() RETURNING l_success
   DELETE FROM afap290_tmp
#mark by yangxf
#   IF g_input.fabg005 = '0' THEN
#      LET g_wc = cl_replace_str(g_wc,'fabg008','faam024')
#      LET g_sql = "SELECT DISTINCT 'N',glapld,glapdocno,glapdocdt,glap010,glap011,glapstus,glap012 ",
#                  "  FROM glap_t,faam_t ",
#                  " WHERE faament = glapent AND glapent = ? ",
#                  "   AND glapld = '",g_input.glaald,"'",
#                  "   AND glapld = faamld AND faam024 = glapdocno "
#      IF cl_null(g_argv[1]) THEN
#         LET g_sql = g_sql CLIPPED," AND ",g_wc
#      ELSE
#         LET g_sql = g_sql CLIPPED
#      END IF
#   ELSE
#mark by yangxf
      LET g_wc = cl_replace_str(g_wc,'faam024','fabg008')
      LET g_sql = "SELECT DISTINCT 'N',glapld,glapdocno,glapdocdt,glap010,glap011,glapstus,glap012 ",
                  "  FROM glap_t,fabg_t ",
                  " WHERE glapent = ? ",
                  "   AND glapld = '",g_input.glaald,"'",
                  "   AND fabg008 = glapdocno ",
                  "   AND fabg005 = '",g_input.fabg005,"'",
                  "   AND ",g_wc
#   END IF   #mark by yangxf
   
   #end add-point
 
   PREPARE afap290_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR afap290_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].*
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
      INSERT INTO afap290_tmp VALUES(g_detail_d[l_ac].*)
      #end add-point
      
      CALL afap290_detail_show()      
 
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
   FREE afap290_sel
   
   LET l_ac = 1
   CALL afap290_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   IF g_detail_d.getLength()>0 THEN
      CALL afap290_fabg_fill()
   ELSE
      CALL g_detail2_d.clear()
   END IF 
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afap290.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afap290_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="afap290.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION afap290_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afap290.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION afap290_filter()
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
   
   CALL afap290_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="afap290.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION afap290_filter_parser(ps_field)
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
 
{<section id="afap290.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION afap290_filter_show(ps_field,ps_object)
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
   LET ls_condition = afap290_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="afap290.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
# 帳套帶值
PRIVATE FUNCTION afap290_glaald_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_input.glaald
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_input.glaald_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_input.glaald_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_input.glaald
   CALL ap_ref_array2(g_ref_fields,"SELECT glaacomp,glaa001 FROM glaa_t WHERE glaaent='"||g_enterprise||"' AND glaald=? ","") RETURNING g_rtn_fields
   LET g_input.glaacomp = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_input.glaacomp
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_input.glaacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_input.glaacomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_input.glaacomp_desc
END FUNCTION
# 單身二資料填充
PRIVATE FUNCTION afap290_fabg_fill()
   CALL g_detail2_d.clear()
   IF g_input.fabg005<>'4' THEN
      LET g_sql = "SELECT fabg005,fabgld,fabgdocno,fabgdocdt,fabh004,fabh010,fabh012,fabh019,",
                  "       '','','','','','','' ",
                  "  FROM fabg_t,fabh_t ",
                  " WHERE fabgent=fabhent AND fabgld=fabhld AND fabgdocno=fabhdocno "
   ELSE
      LET g_sql = "SELECT fabg005,fabgld,fabgdocno,fabgdocdt,'','','','',",
                  "       fabo010,fabo012,fabo013,fabo014,fabo015,fabo016,fabo017 ",
                  "  FROM fabg_t,fabo_t ",
                  " WHERE fabgent=faboent AND fabgld=fabold AND fabgdocno=fabodocno "
   END IF
   LET g_sql=g_sql,"   AND fabgent = '",g_enterprise,"'",
                   "   AND fabgld = '",g_detail_d[l_ac].glapld,"'",
                   "   AND fabg008 = '",g_detail_d[l_ac].glapdocno,"'",
                   "   AND fabg005 = '",g_input.fabg005,"'"
   
   PREPARE fabg_pre FROM g_sql
   DECLARE fabg_cur CURSOR FOR fabg_pre
   LET l_cnt = 1
   FOREACH fabg_cur INTO g_detail2_d[l_cnt].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         
         EXIT FOREACH
      END IF
      
      IF cl_null(g_detail2_d[l_cnt].fabh004) THEN LET g_detail2_d[l_cnt].fabh004 = 0 END IF
      IF cl_null(g_detail2_d[l_cnt].fabh010) THEN LET g_detail2_d[l_cnt].fabh010 = 0 END IF
      IF cl_null(g_detail2_d[l_cnt].fabh012) THEN LET g_detail2_d[l_cnt].fabh012 = 0 END IF
      IF cl_null(g_detail2_d[l_cnt].fabh019) THEN LET g_detail2_d[l_cnt].fabh019 = 0 END IF
      
      LET l_cnt = l_cnt + 1
      IF l_cnt > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "std-00002"
         LET g_errparam.extend = "Max_Row:"||g_max_rec USING "<<<<<"
         LET g_errparam.popup = FALSE
         CALL cl_err()
         
         EXIT FOREACH
      END IF
   END FOREACH 
   
   CALL g_detail2_d.deleteElement(l_cnt)
    
   FREE fabg_pre
END FUNCTION
# 創建臨時表
PRIVATE FUNCTION afap290_create_tmp()
   DEFINE r_success       LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   
   DROP TABLE afap290_tmp;
   CREATE TEMP TABLE afap290_tmp(
     sel            VARCHAR(1),
     glapld         VARCHAR(5),
     glapdocno      VARCHAR(20),
     glapdocdt      DATE,
     glap010        DECIMAL(20,6),
     glap011        DECIMAL(20,6),
     glapstus       VARCHAR(10),
     glap012        SMALLINT
   );
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "create" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      
      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION
#
PRIVATE FUNCTION afap290_p()
   DEFINE l_glapdocno        LIKE glap_t.glapdocno
   DEFINE l_docno            LIKE fabg_t.fabgdocno
   DEFINE l_glapstus         LIKE glap_t.glapstus
   DEFINE l_cate             LIKE type_t.chr10 
   DEFINE l_wc               STRING
   DEFINE l_success          LIKE type_t.num5
   DEFINE l_slip             LIKE type_t.chr100     #20150129 add by chenying
   DEFINE l_glapdocdt        LIKE glap_t.glapdocdt  #20150129 add by chenying
   DEFINE l_scom0002         LIKE type_t.chr10      #170103-00019#11 add
   
   #开启事务
   CALL s_transaction_begin()
   #错误信息汇总初始化
   CALL cl_err_collect_init() #20150130 mod
   LET g_success = TRUE  #20150129
   LET l_success = TRUE  #20150129
   
#mark by yangxf
#   IF g_input.fabg005 = '0' THEN
#      LET g_sql = "SELECT UNIQUE faam024 ",
#                  "  FROM faam_t ",
#                  " WHERE faament = '",g_enterprise,"'",
#                  "   AND faamld = '",g_input.glaald,"'",
#                  "   AND faam024 IN (",
#                  "SELECT glapdocno FROM afap290_tmp ",
#                  " WHERE sel = 'Y' )"
#                   
#      PREPARE afap290_pre1 FROM g_sql
#      DECLARE afap290_cur1 CURSOR FOR afap290_pre1
#      
#      FOREACH afap290_cur1 INTO l_glapdocno
#         IF SQLCA.sqlcode THEN
#            INITIALIZE g_errparam TO NULL 
#            LET g_errparam.extend = "FOREACH:" 
#            LET g_errparam.code   = SQLCA.sqlcode 
#            LET g_errparam.popup  = TRUE 
#            CALL cl_err()
#            
#            EXIT FOREACH
#         END IF
#         
#         SELECT glapstus INTO l_glapstus
#           FROM glap_t
#          WHERE glapent = g_enterprise
#            AND glapld = g_input.glaald
#            AND glapdocno = l_glapdocno
#            
#         IF l_glapstus = 'Y' OR l_glapstus = 'S' THEN 
#            CALL cl_errmsg('',l_glapdocno,'','axr-00076',1)
#            LET g_success = 'N' 
#         END IF 
#         
#         CALL afap290_delete_gl(l_glapdocno)
#
#         UPDATE faam_t SET faam024 = NULL,faam025=NULL
#          WHERE faament = g_enterprise
#            AND faamld = g_input.glaald
#            AND faam024 = l_glapdocno 
#         
#         IF SQLCA.SQLCODE THEN
#            CALL cl_errmsg('update fabg_t',l_glapdocno,'',SQLCA.SQLCODE,1)
#            LET g_success = 'N' 
#         END IF                               
#      END FOREACH 
#   ELSE
#mark by yangxf
#      LET g_sql = "SELECT UNIQUE fabg008 ",          #20150129 mark by chenying
      LET g_sql = "SELECT UNIQUE fabg008,fabg009 ",   #20150129 add by chenying      
                  "  FROM fabg_t ",
                  " WHERE fabgent = '",g_enterprise,"'",
                  "   AND fabgld = '",g_input.glaald,"'",
                  "   AND fabg008 IN (",
                  "SELECT glapdocno FROM afap290_tmp ",
                  " WHERE sel = 'Y' )" ,
                  " ORDER BY fabg008  " #20150129 add by chenying
                  
                   
      PREPARE afap290_pre FROM g_sql
      DECLARE afap290_cur CURSOR FOR afap290_pre
      
      CALL cl_get_para(g_enterprise,g_input.glaacomp,'S-COM-0002') RETURNING l_scom0002 #170103-00019#11 add
      
#      FOREACH afap290_cur INTO l_glapdocno                         #20150129 mark by chenying
      FOREACH afap290_cur INTO l_glapdocno,l_glapdocdt  #20150129 add by chenying                       
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            
            EXIT FOREACH
         END IF
         
         SELECT glapstus INTO l_glapstus
           FROM glap_t
          WHERE glapent = g_enterprise
            AND glapld = g_input.glaald
            AND glapdocno = l_glapdocno
            
         IF l_glapstus = 'Y' OR l_glapstus = 'S' THEN 
#            CALL cl_errmsg('',l_glapdocno,'','axr-00076',1) #20150130 mod
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_glapdocno
            LET g_errparam.code   = 'axr-00076'
            LET g_errparam.popup  = TRUE 
            CALL cl_err() 
            LET g_success = FALSE #20150129 mod
         END IF 
         
         #170103-00019#11--add--str--
         #更新相关的细项立冲账资料
         LET l_success = TRUE
         CALL s_pre_voucher_delete_glax(g_input.glaald,l_glapdocno,'',l_scom0002) RETURNING l_success
         IF l_success = FALSE THEN
            LET g_success = FALSE 
         END IF
         
         IF l_scom0002 = 'Y' THEN
         #凭证作废处理
            UPDATE glap_t SET glapstus = 'X'
             WHERE glapent = g_enterprise
               AND glapld = g_input.glaald
               AND glapdocno = l_glapdocno 
                  
               
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'UPDATE glap_t',l_glapdocno
               LET g_errparam.code   = SQLCA.SQLCODE
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_success = FALSE
            END IF
         ELSE
         #删除凭证   
         #170103-00019#11--add--end      
         CALL afap290_delete_gl(l_glapdocno)   
         #20150129 add by chenying
#         #取得單據別所代表的程式代碼
#         CALL s_aooi200_fin_get_slip(l_glapdocno) RETURNING l_success,l_slip
#         SELECT oobx004 INTO g_prog
#           FROM oobx_t
#          WHERE oobxent = g_enterprise
#            AND oobx001 = l_slip
         LET g_prog = 'aglt310'
        #2015/02/14 By 01727 ---(S)---
         SELECT glapdocdt INTO l_glapdocdt FROM glap_t
          WHERE flapld = g_input.glaald
            AND flapdocno = l_glapdocno
            AND flapent = g_ebterprise
        #2015/02/14 By 01727 ---(E)---
         CALL s_aooi200_fin_del_docno(g_input.glaald,l_glapdocno,l_glapdocdt) RETURNING l_success
         IF l_success = FALSE THEN   
            LET g_success = FALSE  
         END IF      
         LET g_prog  = 'afap290'  
      END IF #170103-00019#11 add          
         #20150129 add by chenying   
#2015/07/08--by--02599--mark--str--
#         #當類型不為‘4’出售時更新fabh_t，否則更新fabo_t
#         IF g_input.fabg005 <> '4' THEN    
#             UPDATE fabh_t SET fabh038 = NULL,
#                               fabh039 = NULL 
#             WHERE fabhent = g_enterprise
#               AND fabhld  = g_input.glaald   
#               AND fabhdocno IN (SELECT fabgdocno FROM fabg_t WHERE fabgent = g_enterprise 
#                                    AND fabgld = g_input.glaald AND fabg008 = l_glapdocno)  
#            IF SQLCA.SQLCODE THEN
##               CALL cl_errmsg('update fabh_t',l_glapdocno,'',SQLCA.SQLCODE,1) #20150130
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = sqlca.sqlcode
#               LET g_errparam.extend = l_glapdocno
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#               LET g_success = FALSE #20150129 mod
#            END IF 
#         ELSE
#             UPDATE fabo_t SET fabo025 = NULL,
#                              fabo026 = NULL 
#             WHERE faboent = g_enterprise
#               AND fabold  = g_input.glaald   
#               AND fabodocno IN (SELECT fabgdocno FROM fabg_t WHERE fabgent = g_enterprise 
#                                    AND fabgld = g_input.glaald AND fabg008 = l_glapdocno)  
#            IF SQLCA.SQLCODE THEN
##               CALL cl_errmsg('update fabo_t',l_glapdocno,'',SQLCA.SQLCODE,1) #20150130
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = sqlca.sqlcode
#               LET g_errparam.extend = l_glapdocno
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#               LET g_success = FALSE #20150129 mod
#            END IF 
#         END IF         
#2015/07/08--by--02599--mark--end            


         #20150112 add by chenying
         IF g_input.fabg005 = '0' OR g_input.fabg005 = '4' OR g_input.fabg005 = '6' OR
            g_input.fabg005 = '8' OR g_input.fabg005 = '14' OR g_input.fabg005 = '21' OR
            g_input.fabg005 = '9' OR g_input.fabg005 = '31' THEN       #150417-00007#65  add '31'
            CASE g_input.fabg005 
               WHEN '0'
                  LET l_cate =  'F30'  
               WHEN '4'
                  LET l_cate =  'F40'  
               WHEN '6'
                  LET l_cate =  'F50'  
               WHEN '8'
                  LET l_cate =  'F50' 
               WHEN '14'
                  LET l_cate =  'F50'  
               WHEN '21'
                  LET l_cate =  'F50'
               WHEN '9'
                  LET l_cate =  'F50'    
               WHEN '31'   #150417-00007#65  add '31'
                  LET l_cate =  'F50'
            END CASE           
            #161215-00044#1---modify----begin-----------------
            #SELECT * INTO g_glaa.* 
            SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,
            glaald,glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,
            glaa011,glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,
            glaa023,glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,
            glaa121,glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,
            glaa139,glaa140,glaa123,glaa124,glaa028 INTO g_glaa.*
            #161215-00044#1---modify----end----------------- 
            FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_input.glaald
            IF g_glaa.glaa121 = 'Y' THEN 
               LET l_wc =" glgadocno IN ((SELECT fabgdocno FROM fabg_t ",
                         "                WHERE fabgent = '",g_enterprise,"'",
                         "                  AND fabgld = '",g_input.glaald,"'",
                         "                  AND fabg008 = '",l_glapdocno,"'))"
               CALL s_pre_voucher_upd('FA',l_cate,g_input.glaald,'','','',l_wc) RETURNING l_success
               
               IF l_success = FALSE THEN 
                  LET g_success = FALSE #20150129 mod
               END IF
            END IF
         END IF   
         #20150112 add by chenying
         
         UPDATE fabg_t SET fabg008 = NULL,fabg009=NULL
          WHERE fabgent = g_enterprise
            AND fabgld = g_input.glaald
            AND fabg008 = l_glapdocno 
     
         IF SQLCA.SQLCODE THEN
#            CALL cl_errmsg('update fabg_t',l_glapdocno,'',SQLCA.SQLCODE,1) #20150130
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = sqlca.sqlcode
            LET g_errparam.extend = l_glapdocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE #20150129 mod
         END IF            
      END FOREACH 
#   END IF #mark by yangxf
   
   IF g_success = FALSE THEN      #20150129 mod
      CALL cl_err_collect_show()  #20150130 mod
      CALL s_transaction_end('N','1') 
   ELSE
      CALL cl_err_collect_init()  #20150130 mod
      CALL cl_err_collect_show()  #20150130 mod    
      CALL s_transaction_end('Y','1')
   END IF
END FUNCTION
# 刪除總賬資料
PRIVATE FUNCTION afap290_delete_gl(p_glapdocno)
   DEFINE p_glapdocno      LIKE glap_t.glapdocno
   
   DELETE FROM glap_t 
       WHERE glapent = g_enterprise
         AND glapld = g_input.glaald
         AND glapdocno = p_glapdocno 
         
      
   IF SQLCA.SQLCODE THEN
#      CALL cl_errmsg('DELETE glap_t',p_glapdocno,'',SQLCA.SQLCODE,1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = sqlca.sqlcode
      LET g_errparam.extend = p_glapdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = FALSE #20150129 mod
      RETURN
   END IF
   
   DELETE FROM glaq_t 
    WHERE glaqent = g_enterprise
      AND glaqld = g_input.glaald
      AND glaqdocno = p_glapdocno 
   
   IF SQLCA.SQLCODE THEN
#      CALL cl_errmsg('DELETE glaq_t',p_glapdocno,'',SQLCA.SQLCODE,1) #20150130
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = sqlca.sqlcode
      LET g_errparam.extend = p_glapdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = FALSE #20150129 mod
      RETURN
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
PRIVATE FUNCTION afap290_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " fabgld = '", g_argv[1], "' AND "
   END IF

   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " fabgdocno = '", g_argv[02], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " fabg005 = '", g_argv[03], "' AND "
   END IF



   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
   ELSE
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF

   #add-point:default_search段結束前
   #end add-point
END FUNCTION

#end add-point
 
{</section>}
 
