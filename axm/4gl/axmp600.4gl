#該程式未解開Section, 採用最新樣板產出!
{<section id="axmp600.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2015-07-06 11:27:24), PR版次:0005(2017-02-06 10:55:10)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000040
#+ Filename...: axmp600
#+ Description: 銷退折讓批次產生作業
#+ Creator....: 00593(2015-06-04 15:02:39)
#+ Modifier...: 00593 -SD/PR- 08532
 
{</section>}
 
{<section id="axmp600.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#151118-00012#1  2015/11/19 By shiun        新增s_axmt540_get_exchange傳入參數
#160318-00005#48 2016/03/29 By pengxin      將重複內容的錯誤訊息置換為公用錯誤訊息
#160318-00025#38 2016/04/20 By pengxin      將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160727-00019#25  2016/08/5 By 08742        系统中定义的临时表名称超过15码在执行时会出错,将系统中定义的临时表长度超过15码的改掉
#                                           Mod  axmp600_xmdk_tmp--> axmp600_tmp01
#                                           Mod  axmp600_xmdk_tmp--> axmp600_tmp01
#170203-00010#1  2017/02/06 By 08532        資料匯總時不需有取價方式
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
GLOBALS "../../../com/sub/4gl/s_apmm101.inc"
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
       sel                 LIKE type_t.chr1,
       b_xmdlent           LIKE xmdl_t.xmdlent,
       b_xmdldocno         LIKE xmdl_t.xmdldocno,
       b_xmdkdocdt         LIKE xmdk_t.xmdkdocdt,
       b_xmdlseq           LIKE xmdl_t.xmdlseq,
       b_xmdl008           LIKE xmdl_t.xmdl008,
       b_xmdl008_desc      LIKE type_t.chr500,
       b_xmdl008_desc1     LIKE type_t.chr500,
       b_xmdl009           LIKE xmdl_t.xmdl009,
       b_xmdl009_desc      LIKE type_t.chr500,
       b_xmdl049           LIKE xmdl_t.xmdl049,
       b_xmdl028           LIKE xmdl_t.xmdl028,
       b_sum_xmdl028       LIKE xmdl_t.xmdl028,
       b_sale_return_amt   LIKE xmdl_t.xmdl028,
       b_xmdlamt           LIKE xmdl_t.xmdl028
END RECORD

TYPE type_g_input1        RECORD
       xmdkdocno         LIKE xmdk_t.xmdkdocno,   #銷退單號
       xmdkdocno_desc    LIKE type_t.chr80,       #單別說明
       xmdk007           LIKE xmdk_t.xmdk007,     #客戶編號
       xmdk007_desc      LIKE type_t.chr80,       #客戶名稱
       xmdkdocdt         LIKE xmdk_t.xmdkdocdt,   #單據日期
       xmdk003           LIKE xmdk_t.xmdk003,     #業務人員
       xmdk003_desc      LIKE type_t.chr80,       #人員名稱
       xmdk004           LIKE xmdk_t.xmdk004,     #業務部門
       xmdk004_desc      LIKE type_t.chr80,       #部門名稱
       xmdk016           LIKE xmdk_t.xmdk016,     #幣別
       xmdk016_desc      LIKE type_t.chr80,       #幣別名稱
       l_total_amt       LIKE xmdl_t.xmdl028      #本次銷退金額
END RECORD

TYPE type_g_input2       RECORD
       l_exrate_source   LIKE type_t.chr1,        #匯率來源
       l_exrate          LIKE xmdk_t.xmdk017,     #目前匯率
       l_apportion_type  LIKE type_t.chr1,        #預設分攤方式
       l_percent         LIKE type_t.num20_6,     #比例
       l_amt             LIKE type_t.num20_6,     #金額
       l_apportion_order LIKE type_t.chr1         #預設分攤順序
END RECORD

TYPE type_g_qbe          RECORD
       xmdkdocno_1       LIKE xmdk_t.xmdkdocno, 
       xmdkdocdt_1       LIKE xmdk_t.xmdkdocdt, 
       xmdk003_1         LIKE xmdk_t.xmdk003, 
       xmdl008_1         LIKE xmdl_t.xmdl008
END RECORD

DEFINE g_input1          type_g_input1   #INPUT條件
DEFINE g_input1_o        type_g_input1   #INPUT條件
DEFINE g_input2          type_g_input2   #INPUT條件
DEFINE g_input2_o        type_g_input2   #INPUT條件
DEFINE g_qbe             type_g_qbe      #QBE條件

TYPE type_g_xmdk_m       RECORD
       xmdk000   LIKE xmdk_t.xmdk000, 
       xmdksite  LIKE xmdk_t.xmdksite, 
       xmdkdocno LIKE xmdk_t.xmdkdocno, 
       xmdkdocdt LIKE xmdk_t.xmdkdocdt, 
       xmdk001   LIKE xmdk_t.xmdk001, 
       xmdk003   LIKE xmdk_t.xmdk003, 
       xmdk004   LIKE xmdk_t.xmdk004, 
       xmdkstus  LIKE xmdk_t.xmdkstus, 
       xmdk005   LIKE xmdk_t.xmdk005, 
       xmdk006   LIKE xmdk_t.xmdk006, 
       xmdk007   LIKE xmdk_t.xmdk007, 
       xmdk009   LIKE xmdk_t.xmdk009, 
       xmdk008   LIKE xmdk_t.xmdk008, 
       xmdk202   LIKE xmdk_t.xmdk202, 
       xmdk045   LIKE xmdk_t.xmdk045, 
       xmdk082   LIKE xmdk_t.xmdk082, 
       xmdk030   LIKE xmdk_t.xmdk030, 
       xmdk054   LIKE xmdk_t.xmdk054, 
       xmdk010   LIKE xmdk_t.xmdk010, 
       xmdk011   LIKE xmdk_t.xmdk011, 
       xmdk012   LIKE xmdk_t.xmdk012, 
       xmdk013   LIKE xmdk_t.xmdk013, 
       xmdk014   LIKE xmdk_t.xmdk014, 
       xmdk015   LIKE xmdk_t.xmdk015, 
       xmdk016   LIKE xmdk_t.xmdk016, 
       xmdk017   LIKE xmdk_t.xmdk017, 
       xmdk084   LIKE xmdk_t.xmdk084, 
       xmdk018   LIKE xmdk_t.xmdk018, 
       xmdk041   LIKE xmdk_t.xmdk041, 
       xmdk037   LIKE xmdk_t.xmdk037, 
       xmdk042   LIKE xmdk_t.xmdk042, 
       xmdk043   LIKE xmdk_t.xmdk043, 
       xmdk031   LIKE xmdk_t.xmdk031, 
       xmdk033   LIKE xmdk_t.xmdk033, 
       xmdk085   LIKE xmdk_t.xmdk085, 
       xmdk086   LIKE xmdk_t.xmdk086, 
       xmdk044   LIKE xmdk_t.xmdk044, 
       xmdk035   LIKE xmdk_t.xmdk035, 
       xmdk036   LIKE xmdk_t.xmdk036, 
       xmdk083   LIKE xmdk_t.xmdk083, 
       xmdkownid LIKE xmdk_t.xmdkownid, 
       xmdkowndp LIKE xmdk_t.xmdkowndp, 
       xmdkcrtid LIKE xmdk_t.xmdkcrtid, 
       xmdkcrtdp LIKE xmdk_t.xmdkcrtdp, 
       xmdkcrtdt LIKE xmdk_t.xmdkcrtdt, 
       xmdkmodid LIKE xmdk_t.xmdkmodid, 
       xmdkmoddt LIKE xmdk_t.xmdkmoddt, 
       xmdkcnfid LIKE xmdk_t.xmdkcnfid, 
       xmdkcnfdt LIKE xmdk_t.xmdkcnfdt, 
       xmdkpstid LIKE xmdk_t.xmdkpstid, 
       xmdkpstdt LIKE xmdk_t.xmdkpstdt
       END RECORD

TYPE type_g_xmdl_d       RECORD
       xmdlsite LIKE xmdl_t.xmdlsite, 
       xmdlseq  LIKE xmdl_t.xmdlseq, 
       xmdl001  LIKE xmdl_t.xmdl001, 
       xmdl002  LIKE xmdl_t.xmdl002, 
       xmdl003  LIKE xmdl_t.xmdl003, 
       xmdl004  LIKE xmdl_t.xmdl004, 
       xmdl005  LIKE xmdl_t.xmdl005, 
       xmdl006  LIKE xmdl_t.xmdl006, 
       xmda033  LIKE type_t.chr500, 
       xmdl007  LIKE xmdl_t.xmdl007, 
       xmdl008  LIKE xmdl_t.xmdl008, 
       xmdl009  LIKE xmdl_t.xmdl009, 
       xmdl033  LIKE xmdl_t.xmdl033, 
       xmdl011  LIKE xmdl_t.xmdl011, 
       xmdl012  LIKE xmdl_t.xmdl012, 
       xmdl050  LIKE xmdl_t.xmdl050, 
       xmdl094  LIKE xmdl_t.xmdl094, 
       xmdl095  LIKE xmdl_t.xmdl095, 
       xmdl017  LIKE xmdl_t.xmdl017, 
       xmdl018  LIKE xmdl_t.xmdl018, 
       xmdl019  LIKE xmdl_t.xmdl019, 
       xmdl020  LIKE xmdl_t.xmdl020, 
       xmdl010  LIKE xmdl_t.xmdl010, 
       xmdl013  LIKE xmdl_t.xmdl013, 
       xmdl014  LIKE xmdl_t.xmdl014, 
       xmdl015  LIKE xmdl_t.xmdl015, 
       xmdl016  LIKE xmdl_t.xmdl016, 
       xmdl052  LIKE xmdl_t.xmdl052, 
       xmdl021  LIKE xmdl_t.xmdl021, 
       xmdl022  LIKE xmdl_t.xmdl022, 
       xmdl023  LIKE xmdl_t.xmdl023, 
       xmdl041  LIKE xmdl_t.xmdl041,
       xmdl030  LIKE xmdl_t.xmdl030,
       xmdl031  LIKE xmdl_t.xmdl031,
       xmdl032  LIKE xmdl_t.xmdl032,
       xmdl051  LIKE xmdl_t.xmdl051, 
       xmdl088  LIKE xmdl_t.xmdl088
       END RECORD

TYPE type_g_xmdl2_d     RECORD
       xmdlseq  LIKE xmdl_t.xmdlseq, 
       xmdl048  LIKE xmdl_t.xmdl048, 
       xmdl049  LIKE xmdl_t.xmdl049, 
       xmdl0071 LIKE type_t.chr500, 
       xmdl0081 LIKE type_t.chr500, 
       xmdl0091 LIKE type_t.chr500, 
       xmdl0111 LIKE type_t.chr500, 
       xmdl0121 LIKE type_t.chr500, 
       xmdl0171 LIKE type_t.chr500, 
       xmdl0181 LIKE type_t.num20_6, 
       xmdl0211 LIKE type_t.chr500, 
       xmdl0221 LIKE type_t.num20_6, 
       xmdl024  LIKE xmdl_t.xmdl024, 
       xmdl025  LIKE xmdl_t.xmdl025, 
       xmdl026  LIKE xmdl_t.xmdl026, 
       xmdl027  LIKE xmdl_t.xmdl027, 
       xmdl028  LIKE xmdl_t.xmdl028, 
       xmdl029  LIKE xmdl_t.xmdl029, 
       xmdl042  LIKE xmdl_t.xmdl042, 
       xmdl043  LIKE xmdl_t.xmdl043, 
       xmdl044  LIKE xmdl_t.xmdl044, 
       xmdl045  LIKE xmdl_t.xmdl045, 
       xmdl046  LIKE xmdl_t.xmdl046, 
       xmdl087  LIKE xmdl_t.xmdl087
       END RECORD

TYPE type_g_xmdl3_d      RECORD
       xmdmsite LIKE xmdm_t.xmdmsite, 
       xmdmseq  LIKE xmdm_t.xmdmseq, 
       xmdmseq1 LIKE xmdm_t.xmdmseq1, 
       xmdm001  LIKE xmdm_t.xmdm001, 
       xmdm002  LIKE xmdm_t.xmdm002, 
       xmdm003  LIKE xmdm_t.xmdm003, 
       xmdm004  LIKE xmdm_t.xmdm004, 
       xmdm005  LIKE xmdm_t.xmdm005, 
       xmdm006  LIKE xmdm_t.xmdm006, 
       xmdm007  LIKE xmdm_t.xmdm007, 
       xmdm033  LIKE xmdm_t.xmdm033, 
       xmdm008  LIKE xmdm_t.xmdm008, 
       xmdm009  LIKE xmdm_t.xmdm009, 
       xmdm010  LIKE xmdm_t.xmdm010, 
       xmdm011  LIKE xmdm_t.xmdm011
       END RECORD
       
DEFINE g_xmdk_m          type_g_xmdk_m          #銷退單單頭
DEFINE g_xmdl_d          type_g_xmdl_d          #銷退明細單身
DEFINE g_xmdl2_d         type_g_xmdl2_d         #價格資訊
DEFINE g_xmdl3_d         type_g_xmdl3_d         #多倉儲批明細

DEFINE g_rec_b           LIKE type_t.num5
DEFINE g_rec_b2          LIKE type_t.num5
DEFINE g_detail_idx      LIKE type_t.num5
DEFINE g_detail_idx2     LIKE type_t.num5

DEFINE g_where           STRING                 #組合過濾前後置單據資料SQL(出貨單&無訂單出貨單&簽收單)
DEFINE g_sum_xmdlamt     LIKE xmdl_t.xmdl028    #紀錄單身累加的本次銷退金額
DEFINE g_xmdk042         LIKE xmdk_t.xmdk042    #內外銷
DEFINE g_b_xmdlamt_t     LIKE xmdl_t.xmdl028
DEFINE g_success         LIKE type_t.num5
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axmp600.main" >}
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
   CALL cl_ap_init("axm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axmp600 WITH FORM cl_ap_formpath("axm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axmp600_init()   
 
      #進入選單 Menu (="N")
      CALL axmp600_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axmp600
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   DROP TABLE axmp600_tmp01         #160727-00019#25 Mod  axmp600_xmdk_tmp--> axmp600_tmp01
   DROP TABLE axmp600_tmp02         #160727-00019#25 Mod  axmp600_xmdl_tmp--> axmp600_tmp02
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axmp600.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axmp600_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
 
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL axmp600_create_tmp_table()
   
   #INPUT1欄位預設值
   LET g_input1.xmdkdocdt = g_today
   LET g_input1.xmdk003 = g_user
   LET g_input1.xmdk004 = g_dept
   CALL s_desc_get_person_desc(g_input1.xmdk003)
        RETURNING g_input1.xmdk003_desc   
   CALL s_desc_get_department_desc(g_input1.xmdk004)
        RETURNING g_input1.xmdk004_desc
   DISPLAY BY NAME g_input1.xmdk003_desc,g_input1.xmdk004_desc
   
   LET g_where = " 1=1"
   #QBE變數預設值
   LET g_wc = " 1=1"
   #INPUT2欄位預設值
   LET g_input2.l_exrate_source = '1'
   LET g_input2.l_apportion_type = '1'
   LET g_input2.l_apportion_order = '1'
   LET g_input2.l_percent = '50'
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axmp600.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmp600_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_success              LIKE type_t.num5
   DEFINE l_flag                 LIKE type_t.num5
   DEFINE l_controlno            LIKE ooha_t.ooha001    #控制組編號
   DEFINE l_ooef004              LIKE ooef_t.ooef004    #單據別參照表號
   DEFINE l_where                STRING                 #單據別過濾sql條件
   DEFINE l_errno                LIKE gzze_t.gzze001
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_errshow = '1'
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axmp600_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
 
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_input1.xmdkdocno,g_input1.xmdk007,g_input1.xmdkdocdt,
                       g_input1.xmdk003,g_input1.xmdk004,g_input1.xmdk016,g_input1.l_total_amt
               ATTRIBUTE(WITHOUT DEFAULTS)
             
            AFTER FIELD xmdkdocno   #銷退單別
               CALL s_aooi200_get_slip_desc(g_input1.xmdkdocno)
                    RETURNING g_input1.xmdkdocno_desc
               DISPLAY BY NAME g_input1.xmdkdocno_desc
               
               IF cl_null(g_input1.xmdkdocno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-00324'   #單號欄位不可為空！
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                  NEXT FIELD CURRENT
               ELSE
                  #組合過濾前後置單據資料SQL(出貨單&無訂單出貨單)
                  CALL s_aooi210_get_check_sql(g_site,'',g_input1.xmdkdocno,'2','axmt540','xmdkdocno')
                       RETURNING l_success,l_where
                  IF l_success THEN
                     LET g_where = g_where," AND ((xmdk000 = '1' AND ",l_where,") OR ",
                                           "      (xmdk000 = '2' AND ",l_where,")"

                     #組合過濾前後置單據資料SQL(簽收單)
                     CALL s_aooi210_get_check_sql(g_site,'',g_input1.xmdkdocno,'2','axmt580','xmdkdocno')
                          RETURNING l_success,l_where
                     IF l_success THEN
                        LET g_where = g_where," OR (xmdk000 = '4' AND ",l_where,"))"
                     END IF
                  END IF                  
               END IF
               
               IF g_input1.xmdkdocno <> g_input1_o.xmdkdocno OR cl_null(g_input1_o.xmdkdocno) THEN
                  #檢查單別
                  IF NOT s_aooi200_chk_slip(g_site,'',g_input1.xmdkdocno,'axmt600') THEN
                     LET g_input1.xmdkdocno = g_input1_o.xmdkdocno
                
                     CALL s_aooi200_get_slip_desc(g_input1.xmdkdocno)
                          RETURNING g_input1.xmdkdocno_desc
                     DISPLAY BY NAME g_input1.xmdkdocno_desc
                
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
               #檢核輸入的單據別是否可以被key人員對應的控制組使用,'2' 為銷售控制組類型
               CALL s_control_chk_doc('1',g_input1.xmdkdocno,'2',g_user,g_dept,'','')
                    RETURNING l_success,l_flag
               IF NOT l_success OR NOT l_flag THEN
                  LET g_input1.xmdkdocno = g_input1_o.xmdkdocno
             
                  CALL s_aooi200_get_slip_desc(g_input1.xmdkdocno)
                       RETURNING g_input1.xmdkdocno_desc
                  DISPLAY BY NAME g_input1.xmdkdocno_desc
             
                  NEXT FIELD CURRENT
               END IF
               
               LET g_input1_o.xmdkdocno = g_input1.xmdkdocno
               
            AFTER FIELD xmdk007   #客戶編號
               CALL s_desc_get_trading_partner_abbr_desc(g_input1.xmdk007)
                    RETURNING g_input1.xmdk007_desc
               DISPLAY BY NAME g_input1.xmdk007_desc
               
               IF NOT s_axmt540_client_chk(g_input1.xmdkdocno,'1',g_input1.xmdk007,'') THEN
                  LET g_input1.xmdk007 = ''
                  LET g_input1.xmdk007_desc = ''                  
                  DISPLAY BY NAME g_input1.xmdk007,g_input1.xmdk007_desc
                  
                  NEXT FIELD CURRENT
               END IF
               
               #幣別的預設值
               #(1)先抓訂單控制組客戶預設條件(axmi111)裡的慣用交易幣別,慣用內外銷(後面抓匯率用的到)
               CALL s_control_get_group('2',g_user,g_dept)
                    RETURNING l_success,l_controlno
               LET g_input1.xmdk016 = ''
               LET g_xmdk042 = ''
               SELECT xmae003,xmae023 INTO g_input1.xmdk016,g_xmdk042
                 FROM xmae_t
                WHERE xmaeent = g_enterprise
                  AND xmae001 = g_input1.xmdk007
                  AND xmae002 = l_controlno
               #(2)抓不到的話再抓客戶據點預設條件(axmm202)裡的慣用交易幣別,慣用內外銷(後面抓匯率用的到)
               IF cl_null(g_input1.xmdk016) THEN
                  SELECT pmab083,pmab107 INTO g_input1.xmdk016,g_xmdk042
                    FROM pmab_t
                   WHERE pmabent = g_enterprise
                     AND pmabsite = g_site
                     AND pmab001 = g_input1.xmdk007
               END IF
               CALL s_desc_get_currency_desc(g_input1.xmdk016)
                    RETURNING g_input1.xmdk016_desc
               DISPLAY BY NAME g_input1.xmdk016_desc
               LET g_input1_o.xmdk016 = g_input1.xmdk016               
               LET g_input1_o.xmdk007 = g_input1.xmdk007
                  
            AFTER FIELD xmdk003   #業務人員
               CALL s_desc_get_person_desc(g_input1.xmdk003)
                    RETURNING g_input1.xmdk003_desc
               DISPLAY BY NAME g_input1.xmdk003_desc
               
               IF NOT cl_null(g_input1.xmdk003) THEN
                  IF g_input1.xmdk003 <> g_input1_o.xmdk003 OR cl_null(g_input1_o.xmdk003) THEN               
   
                     IF NOT s_employee_chk(g_input1.xmdk003) THEN
                        LET g_input1.xmdk003 = g_input1_o.xmdk003
   
                        CALL s_desc_get_person_desc(g_input1.xmdk003)
                             RETURNING g_input1.xmdk003_desc
                        DISPLAY BY NAME g_input1.xmdk003_desc
   
                        NEXT FIELD CURRENT
                     END IF
                     
                     #抓取業務人員歸屬部門(ooag003)
                     CALL s_employee_get_dept(g_input1.xmdk003)
                          RETURNING l_success,l_errno,g_input1.xmdk004,g_input1.xmdk004_desc
                     IF cl_null(g_input1.xmdk004) THEN
                        LET g_input1.xmdk004 = g_dept
                        CALL s_desc_get_department_desc(g_input1.xmdk004)
                             RETURNING g_input1.xmdk004_desc
                        DISPLAY BY NAME g_input1.xmdk004_desc
                     END IF
                     LET g_input1_o.xmdk004 = g_input1.xmdk004
                     DISPLAY BY NAME g_input1.xmdk004,g_input1.xmdk004_desc
                  END IF
               END IF   
               LET g_input1_o.xmdk003 = g_input1.xmdk003
   
            AFTER FIELD xmdk004   #業務部門
               CALL s_desc_get_department_desc(g_input1.xmdk004)
                    RETURNING g_input1.xmdk004_desc
               DISPLAY BY NAME g_input1.xmdk004_desc
      
               IF NOT cl_null(g_input1.xmdk004) THEN 
                  IF g_input1.xmdk004 <> g_input1_o.xmdk004 OR cl_null(g_input1_o.xmdk004) THEN
   
                     IF NOT s_department_chk(g_input1.xmdk004,g_input1.xmdkdocdt) THEN
                        LET g_input1.xmdk004 = g_input1_o.xmdk004
   
                        CALL s_desc_get_department_desc(g_input1.xmdk004)
                             RETURNING g_input1.xmdk004_desc
                        DISPLAY BY NAME g_input1.xmdk004_desc
   
                        NEXT FIELD CURRENT
                     END IF               
                  END IF
               END IF   
               LET g_input1_o.xmdk004 = g_input1.xmdk004
   
            AFTER FIELD xmdk016   #幣別
               CALL s_desc_get_currency_desc(g_input1.xmdk016)
                    RETURNING g_input1.xmdk016_desc
               DISPLAY BY NAME g_input1.xmdk016_desc
                           
               IF NOT cl_null(g_input1.xmdk016) THEN      
                  IF g_input1.xmdk016 <> g_input1_o.xmdk016 OR cl_null(g_input1_o.xmdk016) THEN                     
                     #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                     INITIALIZE g_chkparam.* TO NULL                  
                     #設定g_chkparam.*的參數
                     LET g_chkparam.arg1 = g_site               
                     LET g_chkparam.arg2 = g_input1.xmdk016                     
                     #160318-00025#38  2016/04/20  by pengxin  add(S)
                     LET g_errshow = TRUE #是否開窗 
                     LET g_chkparam.err_str[1] = "aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
                     #160318-00025#38  2016/04/20  by pengxin  add(E)
                     #呼叫檢查存在並帶值的library
                     IF NOT cl_chk_exist("v_ooaj002") THEN
                        LET g_input1.xmdk016 = g_input1_o.xmdk016
                        
                        CALL s_desc_get_currency_desc(g_input1.xmdk016)
                             RETURNING g_input1.xmdk016_desc
                        DISPLAY BY NAME g_input1.xmdk016_desc                     
                        
                        NEXT FIELD CURRENT
                     END IF   
                  END IF
               END IF               
               LET g_input1_o.xmdk016 = g_input1.xmdk016

            AFTER FIELD l_total_amt   #本次銷退金額
               IF g_input1.l_total_amt < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00224'   #輸入金額不可小於等於0！
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                  NEXT FIELD CURRENT
               END IF
            
            ON ACTION controlp INFIELD xmdkdocno   #銷退單別
            	INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
      			LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input1.xmdkdocno     #給予default值               
               CALL s_aooi100_sel_ooef004(g_site)
                    RETURNING l_success,l_ooef004
               LET g_qryparam.arg1 = l_ooef004
               LET g_qryparam.arg2 = 'axmt600'
               CALL q_ooba002_1()                               #呼叫開窗
               LET g_input1.xmdkdocno = g_qryparam.return1      #將開窗取得的值回傳到變數
               DISPLAY g_input1.xmdkdocno TO xmdkdocno          #顯示到畫面上
               CALL s_aooi200_get_slip_desc(g_input1.xmdkdocno)
                    RETURNING g_input1.xmdkdocno_desc
               DISPLAY BY NAME g_input1.xmdkdocno_desc
               NEXT FIELD CURRENT                               #返回原欄位

            ON ACTION controlp INFIELD xmdk007     #客戶編號
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input1.xmdk007       #給予default值
   			   #單據別是否設置限用的資料
               CALL s_control_get_customer_sql('2',g_site,g_user,g_dept,g_input1.xmdkdocno)
                    RETURNING l_success,l_where
               IF l_success THEN
                  LET g_qryparam.where = l_where
               END IF 
               LET g_qryparam.arg1 = g_site
               CALL q_pmaa001_6()                               #呼叫開窗
               LET g_input1.xmdk007 = g_qryparam.return1        #將開窗取得的值回傳到變數
               DISPLAY g_input1.xmdk007 TO xmdk007              #顯示到畫面上
               CALL s_desc_get_trading_partner_abbr_desc(g_input1.xmdk007) RETURNING g_input1.xmdk007_desc
               DISPLAY BY NAME g_input1.xmdk007_desc
               NEXT FIELD CURRENT                               #返回原欄位

            ON ACTION controlp INFIELD xmdk003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input1.xmdk003       #給予default值
               CALL q_ooag001()                                 #呼叫開窗
               LET g_input1.xmdk003 = g_qryparam.return1        #將開窗取得的值回傳到變數
               DISPLAY g_input1.xmdk003 TO xmdk003              #顯示到畫面上
               CALL s_desc_get_person_desc(g_input1.xmdk003) RETURNING g_input1.xmdk003_desc
               DISPLAY BY NAME g_input1.xmdk003_desc
               NEXT FIELD CURRENT                               #返回原欄位
   
            ON ACTION controlp INFIELD xmdk004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input1.xmdk004       #給予default值
               IF NOT cl_null(g_input1.xmdkdocdt) THEN
                  LET g_qryparam.arg1 = g_input1.xmdkdocdt
               ELSE
                  LET g_qryparam.arg1 = g_today
               END IF
               CALL q_ooeg001()                                 #呼叫開窗
               LET g_input1.xmdk004 = g_qryparam.return1        #將開窗取得的值回傳到變數
               DISPLAY g_input1.xmdk004 TO xmdk004              #顯示到畫面上
               CALL s_desc_get_department_desc(g_input1.xmdk004) RETURNING g_input1.xmdk004_desc
               DISPLAY BY NAME g_input1.xmdk004_desc
               NEXT FIELD CURRENT                               #返回原欄位

            ON ACTION controlp INFIELD xmdk016
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input1.xmdk016        #給予default值
               LET g_qryparam.arg1 = g_site
               CALL q_ooaj002_1()                                #呼叫開窗
               LET g_input1.xmdk016 = g_qryparam.return1         #將開窗取得的值回傳到變數
               DISPLAY g_input1.xmdk016 TO xmdk016               #顯示到畫面上
               CALL s_desc_get_currency_desc(g_input1.xmdk016) RETURNING g_input1.xmdk016_desc
               DISPLAY BY NAME g_input1.xmdk016_desc            
               NEXT FIELD CURRENT                               #返回原欄位
            
            AFTER INPUT
            
         END INPUT

         CONSTRUCT BY NAME g_wc ON xmdkdocno_1,xmdkdocdt_1,xmdk003_1,xmdl008_1
            BEFORE CONSTRUCT
               CALL cl_qbe_init()
               
            ON ACTION controlp INFIELD xmdkdocno_1   #出貨單號
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #依客戶編號、幣別篩選符合之出貨單資料
               LET g_qryparam.where = " xmdk007 = '",g_input1.xmdk007,"' AND ",
                                      " xmdk016 = '",g_input1.xmdk016,"' AND ",
                                      g_where CLIPPED
               CALL q_xmdkdocno_7()                        #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdkdocno_1   #顯示到畫面上
               NEXT FIELD xmdkdocno_1                      #返回原欄位

            ON ACTION controlp INFIELD xmdk003_1   #業務人員
   		   	INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
   			   LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                             #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk003_1      #顯示到畫面上   
               NEXT FIELD xmdk003_1                         #返回原欄位
               
            ON ACTION controlp INFIELD xmdl008_1   #料件編號
   			   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
   			   LET g_qryparam.reqry = FALSE
               CALL q_imaf001_15()                          #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdl008_1      #顯示到畫面上   
               NEXT FIELD xmdl008_1                         #返回原欄位
               
            AFTER CONSTRUCT

            
         END CONSTRUCT
         
         INPUT BY NAME g_input2.l_exrate_source,g_input2.l_exrate,
                       g_input2.l_apportion_type,g_input2.l_percent,g_input2.l_amt,
                       g_input2.l_apportion_order
               ATTRIBUTE(WITHOUT DEFAULTS)
             
           ON CHANGE l_exrate_source   #匯率來源
               IF g_input2.l_exrate_source = '2' THEN   #2.目前匯率
                  CALL s_axmt540_get_exchange(g_xmdk042,g_input1.xmdk016,g_input1.xmdkdocdt)   #modify--151118-00012#1 By shiun   新增傳入參數g_input1.xmdkdocdt
                       RETURNING g_input2.l_exrate
               ELSE   #不是2的時候把目前匯率清空
                  LET g_input2.l_exrate = NULL                  
               END IF
               DISPLAY BY NAME g_input2.l_exrate
               CALL axmp600_set_entry()
               CALL axmp600_set_no_required()
               CALL axmp600_set_required()
               CALL axmp600_set_no_entry()

            AFTER FIELD l_exrate
               #確認欄位值在特定區間內(>0)
               IF NOT cl_ap_chk_range(g_input2.l_exrate,"0","0","","","azz-00079",1) THEN
                  NEXT FIELD l_exrate
               END IF 

            ON CHANGE l_apportion_type   #預設分攤方式
               CASE g_input2.l_apportion_type
                  WHEN '1'   #1.依原出貨金額比例
                     LET g_input2.l_percent = 50
                     LET g_input2.l_amt = NULL
                  WHEN '2'   #2.固定出貨剩餘金額
                     LET g_input2.l_percent = NULL
                     LET g_input2.l_amt = 0
                  WHEN '3'   #3.全數折抵
                     LET g_input2.l_percent = NULL
                     LET g_input2.l_amt = NULL
               END CASE
               DISPLAY BY NAME g_input2.l_percent,g_input2.l_amt
               CALL axmp600_set_entry()
               CALL axmp600_set_no_required()
               CALL axmp600_set_required()
               CALL axmp600_set_no_entry()
               
            AFTER FIELD l_percent
               #確認欄位值在特定區間內(>=1,<=100)
               IF NOT cl_ap_chk_range(g_input2.l_percent,"1","1","100","1","azz-00087",1) THEN
                  NEXT FIELD l_percent
               END IF

            AFTER FIELD l_amt
               #確認欄位值在特定區間內(>=0)
               IF NOT cl_ap_chk_range(g_input2.l_amt,"0","1","","","azz-00079",1) THEN
                  NEXT FIELD l_amt
               END IF 
            
            AFTER INPUT
               
         END INPUT
         
         INPUT ARRAY g_detail_d FROM s_detail1.*
            ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                      INSERT ROW = FALSE,
                      DELETE ROW = FALSE,
                      APPEND ROW = FALSE)
                      
            BEFORE INPUT
               CALL FGL_SET_ARR_CURR(g_master_idx)
               LET g_master_idx = DIALOG.getCurrentRow("s_detail1")

            BEFORE ROW
               LET g_master_idx = DIALOG.getCurrentRow("s_detail1")
               CALL cl_set_comp_entry("b_xmdlamt",TRUE)
               DISPLAY g_master_idx TO FORMONLY.h_index
               
            ON CHANGE sel
               IF g_detail_d[g_master_idx].sel = 'Y' THEN
                  #本次銷退金額
                  CALL axmp600_cal_xmdlamt(g_master_idx)
                       RETURNING g_detail_d[g_master_idx].b_xmdlamt                  
                  CALL cl_set_comp_entry("b_xmdlamt",TRUE)
               ELSE
                  LET g_detail_d[g_master_idx].b_xmdlamt = 0
                  CALL cl_set_comp_entry("b_xmdlamt",FALSE)                  
               END IF
               LET g_b_xmdlamt_t = g_detail_d[g_master_idx].b_xmdlamt
               DISPLAY BY NAME g_detail_d[g_master_idx].b_xmdlamt
               #更新axmp600_tmp02資料 & 顯示勾選的累計本次銷退金額
               CALL axmp600_upd_xmdl_tmp(g_master_idx)

            BEFORE FIELD b_xmdlamt
               IF g_detail_d[g_master_idx].sel = "N" THEN
                  CALL cl_set_comp_entry("b_xmdlamt",FALSE)
               END IF
               IF cl_null(g_b_xmdlamt_t) THEN
                  LET g_b_xmdlamt_t = 0
               END IF

            AFTER FIELD b_xmdlamt
               IF g_detail_d[g_master_idx].b_xmdlamt < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00224'   #輸入金額不可小於等於0！
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_detail_d[g_master_idx].b_xmdlamt = g_b_xmdlamt_t
                  NEXT FIELD CURRENT
               END IF
               IF g_detail_d[g_master_idx].b_xmdlamt > g_input1.l_total_amt THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axm-00690'   #輸入金額%1超過銷退資料的本次銷退金額%2
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = g_detail_d[g_master_idx].b_xmdlamt
                  LET g_errparam.replace[2] = g_input1.l_total_amt
                  CALL cl_err()                  
                  LET g_detail_d[g_master_idx].b_xmdlamt = g_b_xmdlamt_t
                  NEXT FIELD CURRENT
               END IF
               IF g_detail_d[g_master_idx].b_xmdlamt > g_detail_d[g_master_idx].b_sale_return_amt THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axm-00691'   #輸入金額%1超過可銷退金額%2
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = g_detail_d[g_master_idx].b_xmdlamt
                  LET g_errparam.replace[2] = g_detail_d[g_master_idx].b_sale_return_amt
                  CALL cl_err()
                  LET g_detail_d[g_master_idx].b_xmdlamt = g_b_xmdlamt_t
                  NEXT FIELD CURRENT
               END IF
               IF g_detail_d[g_master_idx].b_xmdlamt = 0 THEN
                  LET g_detail_d[g_master_idx].sel = 'N'
               END IF
               #更新axmp600_tmp02資料 & 顯示勾選的累計本次銷退金額
               CALL axmp600_upd_xmdl_tmp(g_master_idx)
               IF g_sum_xmdlamt > g_input1.l_total_amt THEN
                  INITIALIZE g_errparam TO NULL
                  #銷退資料的本次銷退金額%1與折讓明細的本次銷退金額加總%2不一致！請調整
                  LET g_errparam.code = 'axm-00677'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = g_input1.l_total_amt
                  LET g_errparam.replace[2] = g_sum_xmdlamt
                  CALL cl_err()
                  LET g_detail_d[g_master_idx].b_xmdlamt = g_b_xmdlamt_t
                  NEXT FIELD CURRENT
               END IF

               LET g_b_xmdlamt_t = g_detail_d[g_master_idx].b_xmdlamt
               
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
 
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
 
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
 
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
               #本次銷退金額
               CALL axmp600_cal_xmdlamt(li_idx) RETURNING g_detail_d[li_idx].b_xmdlamt
               #更新axmp600_tmp02資料 & 顯示勾選的累計本次銷退金額
               CALL axmp600_upd_xmdl_tmp(li_idx)
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
               LET g_detail_d[li_idx].b_xmdlamt = 0
               #更新axmp600_tmp02資料 & 顯示勾選的累計本次銷退金額
               CALL axmp600_upd_xmdl_tmp(li_idx)
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
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  IF g_detail_d[li_idx].sel = "Y" THEN
                     #本次銷退金額
                     CALL axmp600_cal_xmdlamt(li_idx) RETURNING g_detail_d[li_idx].b_xmdlamt
                  END IF
                  #更新axmp600_tmp02資料 & 顯示勾選的累計本次銷退金額
                  CALL axmp600_upd_xmdl_tmp(li_idx)
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
               IF g_detail_d[li_idx].sel = "N" THEN
                  LET g_detail_d[li_idx].b_xmdlamt = 0
               END IF
               #更新axmp600_tmp02資料 & 顯示勾選的累計本次銷退金額
               CALL axmp600_upd_xmdl_tmp(li_idx)
            END FOR
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axmp600_filter()
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
            CALL axmp600_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            CALL axmp600_qbeclear()
            NEXT FIELD xmdkdocno
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL axmp600_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION generate_data   #產生折讓明細
            CALL axmp600_generate_data() RETURNING l_success               
            CONTINUE DIALOG
         
         ON ACTION batch_execute   #產生銷退單
            CALL axmp600_process()
           #CALL axmp600_qbeclear()
            NEXT FIELD xmdkdocno
            CONTINUE DIALOG
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
 
{<section id="axmp600.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axmp600_query()
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
   CALL axmp600_b_fill()
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
 
{<section id="axmp600.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axmp600_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_success       LIKE type_t.num5   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_sql = "SELECT sel,xmdlent,xmdldocno,xmdkdocdt,xmdlseq,xmdl008,'','',xmdl009,'',",
               "           xmdl049,xmdl028,sum_xmdl028,sale_return_amt,xmdlamt",
               "  FROM axmp600_tmp02",     #160727-00019#25 Mod  axmp600_xmdl_tmp--> axmp600_tmp02
               " INNER JOIN xmdk_t ON xmdlent=xmdkent AND xmdldocno=xmdkdocno",
               " WHERE xmdlent=?"
   #依據預設分攤順序做資料排序,方便後面計算本次銷退金額
   CASE g_input2.l_apportion_order
      WHEN '1'   #依出貨日期由近到遠
         LET g_sql = g_sql," ORDER BY xmdkdocdt DESC,xmdldocno,xmdlseq"
      WHEN '2'   #依出貨日期由遠到近
         LET g_sql = g_sql," ORDER BY xmdkdocdt,xmdldocno,xmdlseq"
      WHEN '3'   #依出貨金額由大至小
         LET g_sql = g_sql," ORDER BY xmdl028 DESC,xmdldocno,xmdlseq"
      WHEN '4'   #依出貨金額由小至大
         LET g_sql = g_sql," ORDER BY xmdl028,xmdldocno,xmdlseq"
      WHEN '5'   #依勾選資料分攤
         LET g_sql = g_sql," ORDER BY xmdldocno,xmdlseq"
   END CASE 
   #end add-point
 
   PREPARE axmp600_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axmp600_sel
   
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
      #料件品名、規格
      CALL s_desc_get_item_desc(g_detail_d[l_ac].b_xmdl008)
           RETURNING g_detail_d[l_ac].b_xmdl008_desc,g_detail_d[l_ac].b_xmdl008_desc1
           
      #產品特徵說明
      CALL s_feature_description(g_detail_d[l_ac].b_xmdl008,g_detail_d[l_ac].b_xmdl009)
           RETURNING l_success,g_detail_d[l_ac].b_xmdl009_desc 
      #end add-point
      
      CALL axmp600_detail_show()      
 
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
   FREE axmp600_sel
   
   LET l_ac = 1
   CALL axmp600_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axmp600.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axmp600_fetch()
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
 
{<section id="axmp600.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axmp600_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axmp600.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axmp600_filter()
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
   
   CALL axmp600_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="axmp600.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axmp600_filter_parser(ps_field)
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
 
{<section id="axmp600.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axmp600_filter_show(ps_field,ps_object)
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
   LET ls_condition = axmp600_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axmp600.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: INPUT欄位開啟
# Memo...........:
# Usage..........: CALL axmp600_set_entry()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 15/06/10 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp600_set_entry()

   CALL cl_set_comp_entry("l_exrate",TRUE)
   CALL cl_set_comp_entry("l_percent",TRUE)
   CALL cl_set_comp_entry("l_amt",TRUE)
   
END FUNCTION

################################################################################
# Descriptions...: INPUT欄位關閉
# Memo...........:
# Usage..........: CALL axmp600_set_no_entry()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 15/06/10 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp600_set_no_entry()

   #當選擇2時,可依幣別抓取當前匯率,可修改 =>表示選擇1時要關閉
   IF g_input2.l_exrate_source = '1' THEN
      CALL cl_set_comp_entry("l_exrate",FALSE)
   END IF
   
   #當選擇1時,可維護比例欄位;當選擇2時,可維護金額欄位
   CASE g_input2.l_apportion_type
      WHEN '1'
         CALL cl_set_comp_entry("l_amt",FALSE)
      WHEN '2'
         CALL cl_set_comp_entry("l_percent",FALSE)
      WHEN '3'
         CALL cl_set_comp_entry("l_amt",FALSE)
         CALL cl_set_comp_entry("l_percent",FALSE)
   END CASE
   
END FUNCTION

################################################################################
# Descriptions...: INPUT欄位設定成必輸
# Memo...........:
# Usage..........: CALL axmp600_set_required()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 15/06/10 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp600_set_required()

   IF g_xmdk_m.xmdk045 = '2' OR 
      g_xmdk_m.xmdk045 = '3' THEN  #2:銷售多角,3:统销统收
      
      CALL cl_set_comp_required("xmdk044",TRUE)
   END IF

   IF g_input2.l_exrate_source = '2' THEN
      CALL cl_set_comp_required("l_exrate",TRUE)
   END IF

   CASE g_input2.l_apportion_type
      WHEN '1'
         CALL cl_set_comp_required("l_percent",TRUE)
      WHEN '2'
         CALL cl_set_comp_required("l_amt",TRUE)
   END CASE
   
END FUNCTION

################################################################################
# Descriptions...: INPUT欄位設定成非必輸
# Memo...........:
# Usage..........: CALL axmp600_set_no_required()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 15/06/10 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp600_set_no_required()

   CALL cl_set_comp_required("l_exrate",FALSE)
   CALL cl_set_comp_required("l_percent",FALSE)
   CALL cl_set_comp_required("l_amt",FALSE)
   
END FUNCTION

################################################################################
# Descriptions...: 畫面回到剛執行的狀態
# Memo...........:
# Usage..........: CALL axmp600_qbeclear()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 15/06/10 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp600_qbeclear()

   CLEAR FORM
   CALL g_detail_d.clear()
   INITIALIZE g_input1.*   TO NULL
   INITIALIZE g_input2.*   TO NULL
   INITIALIZE g_input1_o.* TO NULL
   INITIALIZE g_input2_o.* TO NULL
   INITIALIZE g_qbe.*      TO NULL
   INITIALIZE g_wc         TO NULL
   INITIALIZE g_where      TO NULL
   INITIALIZE g_xmdk_m.*   TO NULL
   INITIALIZE g_xmdl_d.*   TO NULL
   INITIALIZE g_xmdl2_d.*  TO NULL
   INITIALIZE g_xmdl3_d.*  TO NULL
  
   CALL axmp600_init()
   DISPLAY BY NAME g_input2.*
   
   CALL axmp600_set_entry()
   CALL axmp600_set_no_required()
   CALL axmp600_set_required()
   CALL axmp600_set_no_entry()
     
END FUNCTION

################################################################################
# Descriptions...: 建立暫存表
# Memo...........:
# Usage..........: CALL axmp600_create_tmp_table()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 15/06/16 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp600_create_tmp_table()

   #銷退單頭資訊
   #依客戶、收款客戶、收貨客戶、收款條件、交易條件、稅別、發票類型、幣別、匯率、取價方式、
   #內外銷、多角性質、發票客戶分別產生不同銷退單(單頭的temp table就放這些欄位)
   CREATE TEMP TABLE axmp600_tmp01(          #160727-00019#25 Mod  axmp600_xmdk_tmp--> axmp600_tmp01
      xmdkdocno  LIKE xmdk_t.xmdkdocno,
      xmdk007    LIKE xmdk_t.xmdk007,
      xmdk009    LIKE xmdk_t.xmdk009,
      xmdk010    LIKE xmdk_t.xmdk010,
      xmdk011    LIKE xmdk_t.xmdk011,
      xmdk012    LIKE xmdk_t.xmdk012,
      xmdk015    LIKE xmdk_t.xmdk015,       
      xmdk016    LIKE xmdk_t.xmdk016,
      xmdk017    LIKE xmdk_t.xmdk017,
      xmdk018    LIKE xmdk_t.xmdk018,
      xmdk042    LIKE xmdk_t.xmdk042,
      xmdk045    LIKE xmdk_t.xmdk045,
      xmdk202    LIKE xmdk_t.xmdk202)
       
   #銷退單身資訊
   CREATE TEMP TABLE axmp600_tmp02(           #160727-00019#25 Mod  axmp600_xmdl_tmp--> axmp600_tmp02
      sel               LIKE type_t.chr1,
      xmdlent           LIKE xmdl_t.xmdlent,
      xmdldocno         LIKE xmdl_t.xmdldocno,
      xmdkdocdt         LIKE xmdk_t.xmdkdocdt,
      xmdlseq           LIKE xmdl_t.xmdlseq,
      xmdl008           LIKE xmdl_t.xmdl008,
      xmdl009           LIKE xmdl_t.xmdl009,
      xmdl049           LIKE xmdl_t.xmdl049,
      xmdl028           LIKE xmdl_t.xmdl028,
      sum_xmdl028       LIKE xmdl_t.xmdl028,
      sale_return_amt   LIKE xmdl_t.xmdl028,
      xmdlamt           LIKE xmdl_t.xmdl028)

END FUNCTION

################################################################################
# Descriptions...: 計算本次銷退金額
# Memo...........:
# Usage..........: CALL axmp600_cal_xmdlamt(p_ac)
# Input parameter: p_ac       第幾筆折讓單身
# Return code....: r_xmdlamt  本次銷退金額
# Date & Author..: 15/06/16 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp600_cal_xmdlamt(p_ac)
   DEFINE p_ac        LIKE type_t.num10  
   DEFINE r_xmdlamt   LIKE xmdl_t.xmdl028
   
   #依據預設分攤方式,預設本次銷退金額
   CASE g_input2.l_apportion_type
      WHEN '1'   #依原出貨金額比例 = (出貨金額 * 比例 / 100) - 已銷退金額
         LET r_xmdlamt = (g_detail_d[p_ac].b_xmdl028 * g_input2.l_percent / 100)
                       - g_detail_d[p_ac].b_sum_xmdl028
      WHEN '2'   #固定出貨剩餘金額 = 出貨金額 - 剩餘金額 - 已銷退金額
         LET r_xmdlamt = g_detail_d[p_ac].b_xmdl028 - g_input2.l_amt
                       - g_detail_d[p_ac].b_sum_xmdl028
      WHEN '3'   #全數折抵 = 出貨金額 - 已銷退金額
         LET r_xmdlamt = g_detail_d[p_ac].b_xmdl028
                       - g_detail_d[p_ac].b_sum_xmdl028
   END CASE
   IF r_xmdlamt <= 0 THEN
      LET r_xmdlamt = 0
   END IF
   
   #如果算出來的本次銷退金額 > 批次作業單頭設定的本次銷退金額,那 r_xmdlamt = 批次作業單頭設定的本次銷退金額
   IF r_xmdlamt > g_input1.l_total_amt THEN
      LET r_xmdlamt = g_input1.l_total_amt
   END IF
   
   #如果算出來的本次銷退金額 > 來源單據的可銷退金額,那 r_xmdlamt = 來源單據的可銷退金額
   IF r_xmdlamt > g_detail_d[p_ac].b_sale_return_amt THEN
      LET r_xmdlamt = g_detail_d[p_ac].b_sale_return_amt
   END IF
   
   #若累計本次銷退金額 + 算出來的本次銷退金額 > 批次作業單頭設定的本次銷退金額,那 r_xmdlamt = 剩下可銷退的金額
   IF g_sum_xmdlamt + r_xmdlamt > g_input1.l_total_amt THEN
      LET r_xmdlamt = g_input1.l_total_amt - g_sum_xmdlamt
   END IF
      
   RETURN r_xmdlamt
   
END FUNCTION

################################################################################
# Descriptions...: 更新axmp600_xmdl_tmp資料 & 顯示勾選的累計本次銷退金額
# Memo...........:
# Usage..........: CALL axmp600_upd_xmdl_tmp(p_ac)
# Input parameter: p_ac       第幾筆折讓單身
# Return code....: 無
# Date & Author..: 15/07/02 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp600_upd_xmdl_tmp(p_ac)
   DEFINE p_ac        LIKE type_t.num10  

   #將資料更新進Temptable       
   UPDATE axmp600_tmp02            #160727-00019#25 Mod  axmp600_xmdl_tmp--> axmp600_tmp02
      SET sel = g_detail_d[p_ac].sel,
          xmdlamt = g_detail_d[p_ac].b_xmdlamt
    WHERE xmdldocno = g_detail_d[p_ac].b_xmdldocno
      AND xmdlseq = g_detail_d[p_ac].b_xmdlseq
      
   #加總勾選的本次銷退金額,並顯示到畫面上
   LET g_sum_xmdlamt = 0
   SELECT SUM(xmdlamt) INTO g_sum_xmdlamt
     FROM axmp600_tmp02            #160727-00019#25 Mod  axmp600_xmdl_tmp--> axmp600_tmp02
   DISPLAY g_sum_xmdlamt TO l_sum
   
END FUNCTION

################################################################################
# Descriptions...: 轉換g_wc中的日期值格式
# Memo...........:
# Usage..........: CALL axmp600_convert_date_str()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 15/07/01 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp600_convert_date_str()
   DEFINE l_post       LIKE type_t.num5  #xmdkdocdt字串的起始位置
   DEFINE l_post1      LIKE type_t.num5  #xmdkdocdt之後的第一個單引號位置
   DEFINE l_post2      LIKE type_t.num5  #xmdkdocdt之後的第二個單引號位置
   DEFINE l_length     LIKE type_t.num5  #g_wc字串長度
   DEFINE l_str        STRING            #日期條件值
   DEFINE l_wc1        STRING            #從第1碼到日期條件值前單引號前面的字串
   DEFINE l_wc2        STRING            #從日期條件值後單引號後面的字串

#例如g_wc="xmdkdocno in ('CTC-AAA-15070001') and xmdkdocdt>='15/01/31' and xmdk003='00001'"
#l_wc1="xmdkdocno in ('CTC-AAA-15070001') and xmdkdocdt>="
#l_wc2=" and xmdk003='00001'"
#轉換完的g_wc="xmdkdocno in ('CTC-AAA-15070001') and xmdkdocdt>=TO_DATE('2015/01/31','YYYY/MM/DD') and xmdk003='00001'"

   LET l_wc1= ""
   LET l_wc2= ""
   
   #獲取xmdkdocdt的字串起始位置
   LET l_post  = g_wc.getIndexOf("xmdkdocdt",1)
   IF l_post = 0 THEN   #找不到xmdkdocdt,則不需要進行轉換,直接RETURN
      RETURN
   END IF
   
   #g_wc字串長度
   LET l_length= g_wc.getLength()   
   #找xmdkdocdt之後的第一個單引號
   LET l_post1 = g_wc.getIndexOf("'",l_post)
   #找xmdkdocdt之後的第二個單引號
   LET l_post2 = g_wc.getIndexOf("'",l_post1+1)
   #獲取xmdkdocdt的日期條件值
   LET l_str = g_wc.subString(l_post1+1,l_post2-1)   
   #從第1碼到日期條件值前單引號前面的字串
   LET l_wc1 = g_wc.subString(1,l_post1-1)
   #從日期條件值後單引號後面的字串
   LET l_wc2 = g_wc.subString(l_post2+1,l_length)
   
   #處理日期原始字串
   #判斷字串長度做不同處理：一般為長度6(150131)或長度8(20150131)-->2015/01/31
   CASE l_str.getLength()
      WHEN 6   #150601
           LET l_str='20',l_str.subString(1,2),'/',l_str.subString(3,4),'/',l_str.subString(5,6)
      WHEN 8   #20150601
           LET l_str=l_str.subString(1,4),'/',l_str.subString(5,6),'/',l_str.subString(7,8)
   END CASE
   #xmdkdocdt>=TO_DATE('2015/01/01','YYYY/MM/DD')
   LET l_str = "TO_DATE('",l_str,"','YYYY/MM/DD')"
   LET g_wc  = l_wc1,l_str,l_wc2

END FUNCTION

################################################################################
# Descriptions...: g_wc的轉換處理
# Memo...........:
# Usage..........: CALL axmp600_qbe_replace()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 15/07/02 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp600_qbe_replace()
   
   LET g_wc = cl_replace_str(g_wc, 'xmdkdocno_1', 'xmdkdocno')
   LET g_wc = cl_replace_str(g_wc, 'xmdkdocdt_1', 'xmdkdocdt')
   LET g_wc = cl_replace_str(g_wc, 'xmdk003_1', 'xmdk003')
   LET g_wc = cl_replace_str(g_wc, 'xmdl008_1', 'xmdl008')
   
   #轉換g_wc中的日期條件
   CALL axmp600_convert_date_str()   
   
END FUNCTION

################################################################################
# Descriptions...: 取得單據別設定帶出單頭預設值
# Memo...........: 參照axmt600_doc_default()
# Usage..........: axmp600_doc_default()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 15/06/12 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp600_doc_default()
   DEFINE  l_success    LIKE type_t.num5
   DEFINE  l_oodbl004   LIKE oodbl_t.oodbl004  #稅別名稱
   DEFINE  l_oodb005    LIKE oodb_t.oodb005    #含稅否
   DEFINE  l_oodb006    LIKE oodb_t.oodb006    #稅率
   DEFINE  l_oodb011    LIKE oodb_t.oodb011    #取得稅別類型1:正常稅率2:依料件設定

   LET g_xmdk_m.xmdk001 = s_aooi200_get_doc_default(g_site,'1',g_input1.xmdkdocno,'xmdk001',g_xmdk_m.xmdk001)
   LET g_xmdk_m.xmdk003 = s_aooi200_get_doc_default(g_site,'1',g_input1.xmdkdocno,'xmdk003',g_xmdk_m.xmdk003)
   LET g_xmdk_m.xmdk004 = s_aooi200_get_doc_default(g_site,'1',g_input1.xmdkdocno,'xmdk004',g_xmdk_m.xmdk004)

   LET g_xmdk_m.xmdk007 = s_aooi200_get_doc_default(g_site,'1',g_input1.xmdkdocno,'xmdk007',g_xmdk_m.xmdk007)
   LET g_xmdk_m.xmdk008 = s_aooi200_get_doc_default(g_site,'1',g_input1.xmdkdocno,'xmdk008',g_xmdk_m.xmdk008)
   LET g_xmdk_m.xmdk009 = s_aooi200_get_doc_default(g_site,'1',g_input1.xmdkdocno,'xmdk009',g_xmdk_m.xmdk009)
   LET g_xmdk_m.xmdk010 = s_aooi200_get_doc_default(g_site,'1',g_input1.xmdkdocno,'xmdk010',g_xmdk_m.xmdk010)   
   LET g_xmdk_m.xmdk011 = s_aooi200_get_doc_default(g_site,'1',g_input1.xmdkdocno,'xmdk011',g_xmdk_m.xmdk011)
   LET g_xmdk_m.xmdk012 = s_aooi200_get_doc_default(g_site,'1',g_input1.xmdkdocno,'xmdk012',g_xmdk_m.xmdk012)
   
   LET g_xmdk_m.xmdk015 = s_aooi200_get_doc_default(g_site,'1',g_input1.xmdkdocno,'xmdk015',g_xmdk_m.xmdk015)
   LET g_xmdk_m.xmdk016 = s_aooi200_get_doc_default(g_site,'1',g_input1.xmdkdocno,'xmdk016',g_xmdk_m.xmdk016)
   
   LET g_xmdk_m.xmdk018 = s_aooi200_get_doc_default(g_site,'1',g_input1.xmdkdocno,'xmdk018',g_xmdk_m.xmdk018)
   
   LET g_xmdk_m.xmdk030 = s_aooi200_get_doc_default(g_site,'1',g_input1.xmdkdocno,'xmdk030',g_xmdk_m.xmdk030)
   LET g_xmdk_m.xmdk031 = s_aooi200_get_doc_default(g_site,'1',g_input1.xmdkdocno,'xmdk031',g_xmdk_m.xmdk031)

   LET g_xmdk_m.xmdk033 = s_aooi200_get_doc_default(g_site,'1',g_input1.xmdkdocno,'xmdk033',g_xmdk_m.xmdk033)

   LET g_xmdk_m.xmdk042 = s_aooi200_get_doc_default(g_site,'1',g_input1.xmdkdocno,'xmdk042',g_xmdk_m.xmdk042)
   LET g_xmdk_m.xmdk043 = s_aooi200_get_doc_default(g_site,'1',g_input1.xmdkdocno,'xmdk043',g_xmdk_m.xmdk043)
   LET g_xmdk_m.xmdk044 = s_aooi200_get_doc_default(g_site,'1',g_input1.xmdkdocno,'xmdk044',g_xmdk_m.xmdk044)
   LET g_xmdk_m.xmdk045 = s_aooi200_get_doc_default(g_site,'1',g_input1.xmdkdocno,'xmdk045',g_xmdk_m.xmdk045)
   LET g_xmdk_m.xmdk054 = s_aooi200_get_doc_default(g_site,'1',g_input1.xmdkdocno,'xmdk054',g_xmdk_m.xmdk054)   

   LET g_xmdk_m.xmdk202 = s_aooi200_get_doc_default(g_site,'1',g_input1.xmdkdocno,'xmdk202',g_xmdk_m.xmdk202)
   
   IF NOT cl_null(g_xmdk_m.xmdk012) THEN                   
      #檢查、取得稅別、單價含稅否
      CALL s_tax_chk(g_site,g_xmdk_m.xmdk012)
           RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011      
      LET g_xmdk_m.xmdk013 = l_oodb006
      LET g_xmdk_m.xmdk014 = l_oodb005
   END IF
   
   IF NOT cl_null(g_xmdk_m.xmdk042) AND NOT cl_null(g_xmdk_m.xmdk016) THEN
      #帶出匯率
      CALL s_axmt540_get_exchange(g_xmdk_m.xmdk042,g_xmdk_m.xmdk016,g_xmdk_m.xmdkdocdt) RETURNING g_xmdk_m.xmdk017   #modify--151118-00012#1 By shiun   新增傳入參數g_xmdk_m.xmdkdocdt
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 客戶編號帶值
# Memo...........: 參照axmt600_xmdk007_default(p_xmdk007)
# Usage..........: CALL axmp600_xmdk007_default
# Input parameter: p_xmdk007   客戶編號
# Return code....: 無
# Date & Author..: 15/06/12 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp600_xmdk007_default(p_xmdk007)
   DEFINE p_xmdk007       LIKE xmdk_t.xmdk007    #客戶編號
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_controlno     LIKE ooha_t.ooha001    #控制組編號 
   DEFINE l_oodbl004      LIKE oodbl_t.oodbl004
   DEFINE l_oodb005       LIKE oodb_t.oodb005
   DEFINE l_oodb006       LIKE oodb_t.oodb006
   DEFINE l_oodb011       LIKE oodb_t.oodb011
    
   IF NOT cl_null(p_xmdk007) THEN
      LET g_xmdk_m.xmdk007 = p_xmdk007
      
      #取得銷售控制组編號
      CALL s_control_get_group('2',g_user,g_dept)
           RETURNING l_success,l_controlno
      #抓取交易對象預設資料
      CALL s_apmm101_default_pmab('2',l_controlno,g_site,g_xmdk_m.xmdk007)
           RETURNING g_pmab.*
      
      LET g_xmdk_m.xmdk003 = g_pmab.pmab031   #業務人員
      LET g_xmdk_m.xmdk004 = g_pmab.pmab059   #業務人員
      LET g_xmdk_m.xmdk030 = g_pmab.pmab038   #銷售通路

      LET g_xmdk_m.xmdk010 = g_pmab.pmab037   #收款條件
      LET g_xmdk_m.xmdk011 = g_pmab.pmab053   #交易條件
      LET g_xmdk_m.xmdk012 = g_pmab.pmab034   #稅別

      LET g_xmdk_m.xmdk015 = g_pmab.pmab056   #發票類型

      LET g_xmdk_m.xmdk018 = g_pmab.pmab054   #取價方式
      LET g_xmdk_m.xmdk042 = g_pmab.pmab057   #內外銷
      LET g_xmdk_m.xmdk043 = g_pmab.pmab058   #匯率計算基準

      LET g_xmdk_m.xmdk031 = g_pmab.pmab039   #銷售分類

      #帶出收款客戶            
      CALL s_axmt540_client_partner(g_xmdk_m.xmdkdocno,g_xmdk_m.xmdk007,'1')
           RETURNING g_xmdk_m.xmdk008
                              
      #帶出收貨客戶
      CALL s_axmt540_client_partner(g_xmdk_m.xmdkdocno,g_xmdk_m.xmdk007,'2')
           RETURNING g_xmdk_m.xmdk009

      #帶出發票客戶
      CALL s_axmt540_client_partner(g_xmdk_m.xmdkdocno,g_xmdk_m.xmdk007,'3')
           RETURNING g_xmdk_m.xmdk202

      #檢查收款條件
      IF NOT s_axmt540_receive_condition_chk(g_xmdk_m.xmdk007,g_xmdk_m.xmdk010) THEN
         LET g_xmdk_m.xmdk010 = ''
      END IF

      #取得稅別、單價含稅否
      CALL s_tax_chk(g_site,g_xmdk_m.xmdk012)
           RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011
      LET g_xmdk_m.xmdk013 = l_oodb006
      LET g_xmdk_m.xmdk014 = l_oodb005
   END IF
      
END FUNCTION

################################################################################
# Descriptions...: 寫入銷退單單頭檔
# Memo...........:
# Usage..........: CALL axmp600_insert_xmdk(p_xmdk)
#                :      RETURNING r_success,r_xmdkdocno
# Input parameter: p_xmdk       出貨/簽收單頭欄位集合
# Return code....: 1_success    執行結果(TRUE:新增成功 FALSE:新增失敗)
#                : r_xmdkdocno  新增成功的銷退單號
# Date & Author..: 15/06/12 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp600_insert_xmdk(p_xmdk)
   DEFINE p_xmdk         RECORD          
          xmdk007        LIKE xmdk_t.xmdk007,     #客戶編號
          xmdk009        LIKE xmdk_t.xmdk009,     #收款客戶
          xmdk010        LIKE xmdk_t.xmdk010,     #收款條件
          xmdk011        LIKE xmdk_t.xmdk011,     #交易條件
          xmdk012        LIKE xmdk_t.xmdk012,     #稅別
          xmdk015        LIKE xmdk_t.xmdk015,     #發票類型
          xmdk016        LIKE xmdk_t.xmdk016,     #幣別
          xmdk017        LIKE xmdk_t.xmdk017,     #匯率
          xmdk018        LIKE xmdk_t.xmdk018,     #取價方式
          xmdk042        LIKE xmdk_t.xmdk042,     #內外銷
          xmdk045        LIKE xmdk_t.xmdk045,     #多角性質
          xmdk202        LIKE xmdk_t.xmdk202      #發票客戶
                         END RECORD
   DEFINE l_success      LIKE type_t.num5

   #將畫面上INPUT條件帶入
   LET g_xmdk_m.xmdkdocno = g_input1.xmdkdocno
   LET g_xmdk_m.xmdk007 = g_input1.xmdk007
   LET g_xmdk_m.xmdkdocdt = g_input1.xmdkdocdt
   LET g_xmdk_m.xmdk003 = g_input1.xmdk003
   LET g_xmdk_m.xmdk004 = g_input1.xmdk004
   LET g_xmdk_m.xmdk016 = g_input1.xmdk016

   #單頭欄位預設值(參照axmt600_insert中給的欄位預設值)
   LET g_xmdk_m.xmdkownid = g_user
   LET g_xmdk_m.xmdkowndp = g_dept
   LET g_xmdk_m.xmdkcrtid = g_user
   LET g_xmdk_m.xmdkcrtdp = g_dept
   LET g_xmdk_m.xmdkcrtdt = cl_get_current()
   LET g_xmdk_m.xmdkmodid = g_user
   LET g_xmdk_m.xmdkmoddt = cl_get_current()
   LET g_xmdk_m.xmdkstus = 'N'
   LET g_xmdk_m.xmdk000 = "6"
   LET g_xmdk_m.xmdk045 = "1"   
   LET g_xmdk_m.xmdk014 = "N"
   LET g_xmdk_m.xmdk084 = "1"
   LET g_xmdk_m.xmdk042 = "1"
   LET g_xmdk_m.xmdk043 = "1"
   LET g_xmdk_m.xmdk085 = "1"
   LET g_xmdk_m.xmdk083 = "N"
   LET g_xmdk_m.xmdksite = g_site
   LET g_xmdk_m.xmdk001 = g_today

   #產生之銷退單，銷退方式為"純折讓"
   LET g_xmdk_m.xmdk082 = "4"   #4.銷貨折讓(純金額折價)

   #單據別預設欄位
   CALL axmp600_doc_default()
   
   #自動帶出客戶預設資料
   CALL axmp600_xmdk007_default(g_xmdk_m.xmdk007)

   #將傳進來的p_xmdk的值傳入g_xmdk_m變數中   
   LET g_xmdk_m.xmdk007 = p_xmdk.xmdk007      #客戶編號
   IF NOT cl_null(p_xmdk.xmdk009) THEN
      LET g_xmdk_m.xmdk009 = p_xmdk.xmdk009   #收款客戶
   END IF
   IF NOT cl_null(p_xmdk.xmdk010) THEN
      LET g_xmdk_m.xmdk010 = p_xmdk.xmdk010   #收款條件
   END IF
   IF NOT cl_null(p_xmdk.xmdk011) THEN
      LET g_xmdk_m.xmdk011 = p_xmdk.xmdk011   #交易條件
   END IF
   IF NOT cl_null(p_xmdk.xmdk012) THEN
      LET g_xmdk_m.xmdk012 = p_xmdk.xmdk012   #稅別
   END IF
   IF NOT cl_null(p_xmdk.xmdk015) THEN
      LET g_xmdk_m.xmdk015 = p_xmdk.xmdk015   #發票類型
   END IF
   IF NOT cl_null(p_xmdk.xmdk016) THEN
      LET g_xmdk_m.xmdk016 = p_xmdk.xmdk016   #幣別
   END IF
   IF NOT cl_null(p_xmdk.xmdk017) THEN
      LET g_xmdk_m.xmdk017 = p_xmdk.xmdk017   #匯率
   END IF
   IF NOT cl_null(p_xmdk.xmdk018) THEN
      LET g_xmdk_m.xmdk018 = p_xmdk.xmdk018   #取價方式
   END IF
   IF NOT cl_null(p_xmdk.xmdk042) THEN
      LET g_xmdk_m.xmdk042 = p_xmdk.xmdk042   #內外銷
   END IF
   IF NOT cl_null(p_xmdk.xmdk045) THEN
      LET g_xmdk_m.xmdk045 = p_xmdk.xmdk045   #多角性質
   END IF
   IF NOT cl_null(p_xmdk.xmdk202) THEN
      LET g_xmdk_m.xmdk202 = p_xmdk.xmdk202   #發票客戶
   END IF
   IF cl_null(g_xmdk_m.xmdk003) THEN   #業務人員
      LET g_xmdk_m.xmdk003 = g_user
   END IF
   IF cl_null(g_xmdk_m.xmdk004) THEN   #業務部門
      LET g_xmdk_m.xmdk004 = g_dept
   END IF


   #自動產生單號
   LET l_success = TRUE   
   CALL s_aooi200_gen_docno(g_site,g_xmdk_m.xmdkdocno,g_xmdk_m.xmdkdocdt,'axmt600')
        RETURNING l_success,g_xmdk_m.xmdkdocno
   IF l_success = FALSE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00003'
      LET g_errparam.extend = g_xmdk_m.xmdkdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN l_success,g_xmdk_m.xmdkdocno
   END IF
   
   INSERT INTO xmdk_t (xmdkent,xmdk000,xmdksite,xmdkdocno,xmdkdocdt,xmdk001,xmdk003,xmdk004, 
                       xmdkstus,xmdk005,xmdk006,xmdk007,xmdk009,xmdk008,xmdk202,xmdk045,xmdk082,xmdk030, 
                       xmdk054,xmdk010,xmdk011,xmdk012,xmdk013,xmdk014,xmdk015,xmdk016,xmdk017,xmdk084,xmdk018, 
                       xmdk041,xmdk037,xmdk042,xmdk043,xmdk031,xmdk033,xmdk085,xmdk086,xmdk044,xmdk035,xmdk036, 
                       xmdk083,xmdkownid,xmdkowndp,xmdkcrtid,xmdkcrtdp,xmdkcrtdt,xmdkmodid,xmdkmoddt,xmdkcnfid, 
                       xmdkcnfdt,xmdkpstid,xmdkpstdt)
   VALUES (g_enterprise,g_xmdk_m.xmdk000,g_xmdk_m.xmdksite,g_xmdk_m.xmdkdocno,g_xmdk_m.xmdkdocdt, 
           g_xmdk_m.xmdk001,g_xmdk_m.xmdk003,g_xmdk_m.xmdk004,g_xmdk_m.xmdkstus,g_xmdk_m.xmdk005, 
           g_xmdk_m.xmdk006,g_xmdk_m.xmdk007,g_xmdk_m.xmdk009,g_xmdk_m.xmdk008,g_xmdk_m.xmdk202, 
           g_xmdk_m.xmdk045,g_xmdk_m.xmdk082,g_xmdk_m.xmdk030,g_xmdk_m.xmdk054,g_xmdk_m.xmdk010, 
           g_xmdk_m.xmdk011,g_xmdk_m.xmdk012,g_xmdk_m.xmdk013,g_xmdk_m.xmdk014,g_xmdk_m.xmdk015, 
           g_xmdk_m.xmdk016,g_xmdk_m.xmdk017,g_xmdk_m.xmdk084,g_xmdk_m.xmdk018,g_xmdk_m.xmdk041, 
           g_xmdk_m.xmdk037,g_xmdk_m.xmdk042,g_xmdk_m.xmdk043,g_xmdk_m.xmdk031,g_xmdk_m.xmdk033, 
           g_xmdk_m.xmdk085,g_xmdk_m.xmdk086,g_xmdk_m.xmdk044,g_xmdk_m.xmdk035,g_xmdk_m.xmdk036, 
           g_xmdk_m.xmdk083,g_xmdk_m.xmdkownid,g_xmdk_m.xmdkowndp,g_xmdk_m.xmdkcrtid,g_xmdk_m.xmdkcrtdp, 
           g_xmdk_m.xmdkcrtdt,g_xmdk_m.xmdkmodid,g_xmdk_m.xmdkmoddt,g_xmdk_m.xmdkcnfid,g_xmdk_m.xmdkcnfdt, 
           g_xmdk_m.xmdkpstid,g_xmdk_m.xmdkpstdt) 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "g_xmdk_m" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE      
      CALL cl_err()
      
      LET l_success = FALSE      

      RETURN l_success,g_xmdk_m.xmdkdocno
   END IF

   RETURN l_success,g_xmdk_m.xmdkdocno

END FUNCTION

################################################################################
# Descriptions...: 寫入銷退單單身明細檔
# Memo...........:
# Usage..........: CALL axmp600_insert_xmdl(p_xmdkdocno,p_xmdl001,p_xmdl002)
#                :      RETURNING r_success
# Input parameter: p_xmdkdocno  新增後的銷退單單號
#                : p_xmdk      　折讓明細欄位集合
# Return code....: r_success    執行結果(TRUE:新增成功 FALSE:新增失敗)
# Date & Author..: 15/06/12 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp600_insert_xmdl(p_xmdkdocno,p_xmdl)
   DEFINE p_xmdkdocno      LIKE xmdk_t.xmdkdocno
   DEFINE p_xmdl           RECORD
          sel              LIKE type_t.chr1,
          xmdlent          LIKE xmdl_t.xmdlent,
          xmdldocno        LIKE xmdl_t.xmdldocno,
          xmdkdocdt        LIKE xmdk_t.xmdkdocdt,
          xmdlseq          LIKE xmdl_t.xmdlseq,
          xmdl008          LIKE xmdl_t.xmdl008,
          xmdl009          LIKE xmdl_t.xmdl009,
          xmdl049          LIKE xmdl_t.xmdl049,
          xmdl028          LIKE xmdl_t.xmdl028,
          sum_xmdl028      LIKE xmdl_t.xmdl028,
          sale_return_amt  LIKE xmdl_t.xmdl028,
          xmdlamt          LIKE xmdl_t.xmdl028
                           END RECORD
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_success        LIKE type_t.num5
   
   LET r_success = TRUE
   
   #帶出來源單據欄位預設值
   CALL axmp600_xmdl001_xmdl002_default(p_xmdl.xmdldocno,p_xmdl.xmdlseq)

   #項次
   SELECT MAX(xmdlseq)+1 INTO g_xmdl_d.xmdlseq
     FROM xmdl_t
    WHERE xmdlent = g_enterprise
      AND xmdldocno = p_xmdkdocno
   IF cl_null(g_xmdl_d.xmdlseq) THEN
      LET g_xmdl_d.xmdlseq = 1
   END IF
   
   #出貨/簽收單號(xmdl001) & 出貨/簽收項次(xmdl002)
   LET g_xmdl_d.xmdl001 = p_xmdl.xmdldocno
   LET g_xmdl_d.xmdl002 = p_xmdl.xmdlseq
   
   #銷退數量(xmdl018) = 1 & 參考數量(xmdl020) &計價數量(xmdl022)
   LET g_xmdl_d.xmdl018 = 1
   IF NOT cl_null(g_xmdl_d.xmdl019) THEN   
      LET g_xmdl_d.xmdl020 = 1
   ELSE
      LET g_xmdl_d.xmdl020 = ''
   END IF
   IF NOT cl_null(g_xmdl_d.xmdl021) THEN   
      LET g_xmdl_d.xmdl022 = 1
   ELSE
      LET g_xmdl_d.xmdl022 = ''
   END IF

   #單價(xmdl024) = 本次銷退金額
   LET g_xmdl2_d.xmdl024 = p_xmdl.xmdlamt

   #含稅金額(xmdl028) & 未稅金額(xmdl027) & 稅額(xmdl029)
   CALL s_axmt540_tax_count('',p_xmdkdocno,g_xmdl_d.xmdlseq,g_site,g_xmdl2_d.xmdl025,
                            g_xmdl_d.xmdl022,g_xmdl2_d.xmdl024,g_xmdk_m.xmdk016,g_xmdk_m.xmdk017,
                            g_xmdl_d.xmdl003,g_xmdl_d.xmdl004,g_xmdl_d.xmdl018)
        RETURNING g_xmdl2_d.xmdl027,g_xmdl2_d.xmdl028,g_xmdl2_d.xmdl029

   INSERT INTO xmdl_t
              (xmdlent,xmdldocno,xmdlseq,xmdlsite,
               xmdl001,xmdl002,
               xmdl003,xmdl004,xmdl005,
               xmdl006,xmdl007,xmdl008,
               xmdl009,xmdl033,xmdl011,
               xmdl012,xmdl050,xmdl094,
               xmdl095,xmdl017,xmdl018,
               xmdl019,xmdl020,xmdl010,
               xmdl013,xmdl014,xmdl015,
               xmdl016,xmdl052,xmdl021,
               xmdl022,xmdl023,xmdl041,
               xmdl030,xmdl031,xmdl032,
               xmdl051,xmdl088,
               xmdl048,xmdl049,xmdl024,
               xmdl025,xmdl026,xmdl027,
               xmdl028,xmdl029,xmdl042,
               xmdl043,xmdl044,xmdl045,
               xmdl046,xmdl087)
   VALUES (g_enterprise,p_xmdkdocno,g_xmdl_d.xmdlseq,g_site,
           g_xmdl_d.xmdl001, g_xmdl_d.xmdl002, 
           g_xmdl_d.xmdl003, g_xmdl_d.xmdl004, g_xmdl_d.xmdl005,
           g_xmdl_d.xmdl006, g_xmdl_d.xmdl007, g_xmdl_d.xmdl008,
           g_xmdl_d.xmdl009, g_xmdl_d.xmdl033, g_xmdl_d.xmdl011,
           g_xmdl_d.xmdl012, g_xmdl_d.xmdl050, g_xmdl_d.xmdl094,
           g_xmdl_d.xmdl095, g_xmdl_d.xmdl017, g_xmdl_d.xmdl018,
           g_xmdl_d.xmdl019, g_xmdl_d.xmdl020, g_xmdl_d.xmdl010,
           g_xmdl_d.xmdl013, g_xmdl_d.xmdl014, g_xmdl_d.xmdl015,
           g_xmdl_d.xmdl016, g_xmdl_d.xmdl052, g_xmdl_d.xmdl021,
           g_xmdl_d.xmdl022, g_xmdl_d.xmdl023, g_xmdl_d.xmdl041,
           g_xmdl_d.xmdl030, g_xmdl_d.xmdl031, g_xmdl_d.xmdl032,
           g_xmdl_d.xmdl051, g_xmdl_d.xmdl088,
           g_xmdl2_d.xmdl048,g_xmdl2_d.xmdl049,g_xmdl2_d.xmdl024,
           g_xmdl2_d.xmdl025,g_xmdl2_d.xmdl026,g_xmdl2_d.xmdl027,
           g_xmdl2_d.xmdl028,g_xmdl2_d.xmdl029,g_xmdl2_d.xmdl042,
           g_xmdl2_d.xmdl043,g_xmdl2_d.xmdl044,g_xmdl2_d.xmdl045,
           g_xmdl2_d.xmdl046,g_xmdl2_d.xmdl087)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "xmdl_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()      
      LET r_success = FALSE
      RETURN r_success               
   END IF
   
   #寫入銷退單單身多倉儲明細檔
   CALL axmt540_01_xmdm_modify('6',g_xmdl_d.xmdlseq,g_site,p_xmdkdocno,g_xmdl_d.xmdlseq,
                               g_xmdl_d.xmdl008,g_xmdl_d.xmdl009,g_xmdl_d.xmdl011,g_xmdl_d.xmdl012,
                               g_xmdl_d.xmdl014,g_xmdl_d.xmdl015,g_xmdl_d.xmdl016,g_xmdl_d.xmdl052,
                               g_xmdl_d.xmdl017,g_xmdl_d.xmdl018,g_xmdl_d.xmdl019,g_xmdl_d.xmdl020,
                               '','') RETURNING l_success                 

   IF NOT l_success THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "xmdl_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()      
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 依據出貨/簽收單號+項次帶出單身欄位預設值
# Memo...........: 參照axmt600_xmdl001_xmdl002_default()
# Usage..........: CALL axmp600_xmdl001_xmdl002_default(p_xmdl001,p_xmdl002)
# Input parameter: p_xmdl001    出貨/簽收單號
#                : p_xmdl002    出貨/簽收項次
# Return code....: 無
# Date & Author..: 15/06/16 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp600_xmdl001_xmdl002_default(p_xmdl001,p_xmdl002)
   DEFINE p_xmdl001     LIKE xmdl_t.xmdl001
   DEFINE p_xmdl002     LIKE xmdl_t.xmdl002
   DEFINE l_xmdk000     LIKE xmdk_t.xmdk000
   DEFINE l_xmdl001     LIKE xmdl_t.xmdl001
   DEFINE l_xmdl002     LIKE xmdl_t.xmdl002

   IF NOT cl_null(p_xmdl001) AND NOT cl_null(p_xmdl002) THEN
      LET g_xmdl_d.xmdl013 = 'N'  #多庫儲批
      LET g_xmdl_d.xmdl014 = ''   #庫位
      LET g_xmdl_d.xmdl015 = ''   #儲位
      
      SELECT xmdk000,
             xmdl003,xmdl004,xmdl005,
             xmdl006,xmdl007,xmdl008,
             xmdl009,xmdl010,                                       
             xmdl011,xmdl012,
             xmdl016,xmdl017,xmdl019,
             xmdl021,xmdl023,
             xmdl033,xmdl052,
             xmdl041,xmdl051,xmdl088,
             #價格資訊頁籤
             xmdl024,xmdl025,xmdl026,
             xmdl042,xmdl043,xmdl044,xmdl045,
             xmdl046,xmdl048,xmdl049,             
             xmdl087             
        INTO l_xmdk000,
             g_xmdl_d.xmdl003,g_xmdl_d.xmdl004,g_xmdl_d.xmdl005,
             g_xmdl_d.xmdl006,g_xmdl_d.xmdl007,g_xmdl_d.xmdl008,
             g_xmdl_d.xmdl009,g_xmdl_d.xmdl010,
             g_xmdl_d.xmdl011,g_xmdl_d.xmdl012,
             g_xmdl_d.xmdl016,g_xmdl_d.xmdl017,g_xmdl_d.xmdl019,
             g_xmdl_d.xmdl021,g_xmdl_d.xmdl023,
             g_xmdl_d.xmdl033,g_xmdl_d.xmdl052,
             g_xmdl_d.xmdl041,g_xmdl_d.xmdl051,g_xmdl_d.xmdl088,
             #價格資訊頁籤
             g_xmdl2_d.xmdl024,g_xmdl2_d.xmdl025,g_xmdl2_d.xmdl026,
             g_xmdl2_d.xmdl042,g_xmdl2_d.xmdl043,g_xmdl2_d.xmdl044,g_xmdl2_d.xmdl045,
             g_xmdl2_d.xmdl046,g_xmdl2_d.xmdl048,g_xmdl2_d.xmdl049,
             g_xmdl2_d.xmdl087
        FROM xmdk_t,xmdl_t
       WHERE xmdkent = xmdlent AND xmdkdocno = xmdldocno
         AND xmdlent = g_enterprise
         AND xmdldocno = p_xmdl001
         AND xmdlseq = p_xmdl002

      #來源為簽收單
      IF l_xmdk000 <> '1' AND l_xmdk000 <> '2' THEN
         #抓出貨單
         LET l_xmdl001 = ''
         LET l_xmdl002 = ''
         SELECT xmdl001,xmdl002 INTO l_xmdl001,l_xmdl002
           FROM xmdl_t
          WHERE xmdlent = g_enterprise
            AND xmdldocno = p_xmdl001
            AND xmdlseq = p_xmdl002
      
         SELECT xmdl023,xmdl041,xmdl087
           INTO g_xmdl_d.xmdl023,g_xmdl_d.xmdl041,g_xmdl2_d.xmdl087
           FROM xmdl_t
          WHERE xmdlent = g_enterprise
            AND xmdldocno = l_xmdl001
            AND xmdlseq = l_xmdl002
      END IF     
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 將資料寫入暫存檔
# Memo...........:
# Usage..........: CALL axmp600_generate_data()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success  處理狀況(TRUE:成功  FALSE:失敗)
# Date & Author..: 15/06/16 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp600_generate_data()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5  
   DEFINE l_xmdl        RECORD
      sel               LIKE type_t.chr1,
      xmdlent           LIKE xmdl_t.xmdlent,
      xmdldocno         LIKE xmdl_t.xmdldocno,
      xmdkdocdt         LIKE xmdk_t.xmdkdocdt,
      xmdlseq           LIKE xmdl_t.xmdlseq,
      xmdl008           LIKE xmdl_t.xmdl008,
      xmdl009           LIKE xmdl_t.xmdl009,
      xmdl049           LIKE xmdl_t.xmdl049,
      xmdl028           LIKE xmdl_t.xmdl028,
      sum_xmdl028       LIKE xmdl_t.xmdl028,
      sale_return_amt   LIKE xmdl_t.xmdl028,
      xmdlamt           LIKE xmdl_t.xmdl028
                        END RECORD
   DEFINE o_xmdlamt     LIKE xmdl_t.xmdl028
   
   LET r_success = TRUE
   
   ##清空Temp Table
   DELETE FROM　axmp600_tmp01          #160727-00019#25 Mod  axmp600_xmdk_tmp--> axmp600_tmp01
   DELETE FROM　axmp600_tmp02          #160727-00019#25 Mod  axmp600_xmdl_tmp--> axmp600_tmp02
   CALL g_detail_d.clear()
   
   #g_wc的轉換處理
   CALL axmp600_qbe_replace()
      
   ##依據INPUT與QBE條件，將符合的出貨/簽收單身資料寫入axmp600_tmp02
   LET g_sql = "INSERT INTO axmp600_tmp02 ",        #160727-00019#25 Mod  axmp600_xmdl_tmp--> axmp600_tmp02
               "(sel,xmdlent,xmdldocno,xmdkdocdt,xmdlseq,xmdl008,xmdl009,",
               " xmdl049,xmdl028,sum_xmdl028,sale_return_amt,xmdlamt) ",
               "SELECT 'N',xmdlent,xmdldocno,xmdkdocdt,xmdlseq,xmdl008,xmdl009,",
               "       xmdl049,xmdl028,0,0,0 ",
               "  FROM xmdl_t",
               " INNER JOIN xmdk_t ON xmdlent = xmdkent AND xmdldocno = xmdkdocno",
               " WHERE xmdlent = ",g_enterprise,
               "   AND xmdk000 IN ('1','2','4')",           #出貨、無訂單出貨、簽收
               "   AND xmdk007 = '",g_input1.xmdk007,"'",   #客戶編號
               "   AND xmdk016 = '",g_input1.xmdk016,"'",   #幣別
               "   AND ",g_where CLIPPED,       #組合過濾前後置單據資料SQL(出貨單&無訂單出貨單&簽收單)
               "   AND ",g_wc CLIPPED           #QBE條件
   PREPARE insert_xmdl_pre FROM g_sql
   EXECUTE insert_xmdl_pre
      IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = 'ins xmdl tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
   LET g_sql = "SELECT * FROM axmp600_tmp02"             #160727-00019#25 Mod  axmp600_xmdl_tmp--> axmp600_tmp02
   #依據預設分攤順序做資料排序,方便後面計算本次銷退金額
   CASE g_input2.l_apportion_order
      WHEN '1'   #依出貨日期由近到遠
         LET g_sql = g_sql," ORDER BY xmdkdocdt DESC,xmdldocno,xmdlseq"
      WHEN '2'   #依出貨日期由遠到近
         LET g_sql = g_sql," ORDER BY xmdkdocdt,xmdldocno,xmdlseq"
      WHEN '3'   #依出貨金額由大至小
         LET g_sql = g_sql," ORDER BY xmdl028 DESC,xmdldocno,xmdlseq"
      WHEN '4'   #依出貨金額由小至大
         LET g_sql = g_sql," ORDER BY xmdl028,xmdldocno,xmdlseq"
      WHEN '5'   #依勾選資料分攤
         LET g_sql = g_sql," ORDER BY xmdldocno,xmdlseq"
   END CASE 

   LET g_sum_xmdlamt = 0
   LET o_xmdlamt = 0
   LET l_ac = 1
   PREPARE axmp600_tmp_xmdl_pre FROM g_sql
   DECLARE axmp600_tmp_xmdl_curs CURSOR FOR axmp600_tmp_xmdl_pre
   FOREACH axmp600_tmp_xmdl_curs INTO l_xmdl.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         
         LET r_success = FALSE
         
         EXIT FOREACH
      END IF
      
      #已銷退金額(用出貨單號xmdldocno+項次xmdlseq到銷退單抓取未作廢(xmdk000='6' AND xmdkstus<>'X')的金額加總
      SELECT SUM(xmdl028) INTO l_xmdl.sum_xmdl028
        FROM xmdl_t
       INNER JOIN xmdk_t ON xmdlent = xmdkent AND xmdldocno = xmdkdocno
                        AND xmdk000 = '6'     AND xmdkstus <> 'X'
       WHERE xmdlent = g_enterprise
         AND xmdl001 = l_xmdl.xmdldocno    #出貨/簽收單號
         AND xmdl002 = l_xmdl.xmdlseq      #出貨項次
      IF cl_null(l_xmdl.sum_xmdl028) THEN
         LET l_xmdl.sum_xmdl028 = 0
      END IF
      
      #可銷退金額=出貨金額-已銷退金額
      LET l_xmdl.sale_return_amt = l_xmdl.xmdl028 - l_xmdl.sum_xmdl028
      IF cl_null(l_xmdl.sale_return_amt) THEN
         LET l_xmdl.sale_return_amt = 0
      END IF

      #如果可銷退金額=0表示這筆資料不可再產生銷退單了,從折讓明細單身中去除
      IF l_xmdl.sale_return_amt <= 0 THEN
         #刪除暫存檔中的這筆資料         
         DELETE FROM axmp600_tmp02                  #160727-00019#25 Mod  axmp600_xmdl_tmp--> axmp600_tmp02
          WHERE xmdldocno = l_xmdl.xmdldocno AND xmdlseq = l_xmdl.xmdlseq
         
         CONTINUE FOREACH
      END IF
      
      #預設分攤順序不是5的先不進行分攤
      IF g_input2.l_apportion_order <> '5' THEN
      
         #本次銷退金額
         #---若單身累加的本次銷退金額還沒有超過單頭的本次銷退金額,則表示可以繼續分攤
         IF g_sum_xmdlamt < g_input1.l_total_amt THEN
            #依據預設分攤方式,預設本次銷退金額
            CASE g_input2.l_apportion_type
               WHEN '1'   #依原出貨金額比例 = (出貨金額 * 比例 / 100) - 已銷退金額
                  LET l_xmdl.xmdlamt = (l_xmdl.xmdl028 * g_input2.l_percent / 100) - l_xmdl.sum_xmdl028
               WHEN '2'   #固定出貨剩餘金額 = (出貨金額 - 剩餘金額) - 已銷退金額
                  LET l_xmdl.xmdlamt = (l_xmdl.xmdl028 - g_input2.l_amt) - l_xmdl.sum_xmdl028
               WHEN '3'   #全數折抵 = 出貨金額 - 已銷退金額
                  LET l_xmdl.xmdlamt = l_xmdl.xmdl028 - l_xmdl.sum_xmdl028
            END CASE
            #如果計算出來的本次銷退金額<0,則本筆資料不做銷退
            IF l_xmdl.xmdlamt <= 0 THEN
               LET l_xmdl.xmdlamt = 0
            ELSE
               #累加折讓明細的本次銷退金額
               LET g_sum_xmdlamt = g_sum_xmdlamt + l_xmdl.xmdlamt
      
               #如果單身累加的本次銷退金額超過單頭的本次銷退金額,則後面不再分攤
               IF g_sum_xmdlamt > g_input1.l_total_amt THEN
                  #備份舊職
                  LET o_xmdlamt = l_xmdl.xmdlamt
               
                  #最後一筆就分攤剩下的金額
                  LET l_xmdl.xmdlamt = l_xmdl.xmdlamt - (g_sum_xmdlamt - g_input1.l_total_amt)

                  #累加折讓明細的本次銷退金額
                  LET g_sum_xmdlamt = g_sum_xmdlamt - o_xmdlamt + l_xmdl.xmdlamt
               END IF
               LET l_xmdl.sel = 'Y'   #有分攤的資料將選擇改為'Y'
            END IF
         END IF
      
      END IF
      
      
      ######
      LET g_detail_d[l_ac].sel=l_xmdl.sel
      LET g_detail_d[l_ac].b_xmdlent=l_xmdl.xmdlent
      LET g_detail_d[l_ac].b_xmdldocno=l_xmdl.xmdldocno
      LET g_detail_d[l_ac].b_xmdkdocdt=l_xmdl.xmdkdocdt
      LET g_detail_d[l_ac].b_xmdlseq=l_xmdl.xmdlseq
      LET g_detail_d[l_ac].b_xmdl008=l_xmdl.xmdl008
      #料件品名、規格
      CALL s_desc_get_item_desc(g_detail_d[l_ac].b_xmdl008)
           RETURNING g_detail_d[l_ac].b_xmdl008_desc,g_detail_d[l_ac].b_xmdl008_desc1
      LET g_detail_d[l_ac].b_xmdl009=l_xmdl.xmdl009
      #產品特徵說明
      CALL s_feature_description(g_detail_d[l_ac].b_xmdl008,g_detail_d[l_ac].b_xmdl009)
           RETURNING l_success,g_detail_d[l_ac].b_xmdl009_desc 
      LET g_detail_d[l_ac].b_xmdl049=l_xmdl.xmdl049
      LET g_detail_d[l_ac].b_xmdl028=l_xmdl.xmdl028
      LET g_detail_d[l_ac].b_sum_xmdl028=l_xmdl.sum_xmdl028
      LET g_detail_d[l_ac].b_sale_return_amt=l_xmdl.sale_return_amt
      LET g_detail_d[l_ac].b_xmdlamt=l_xmdl.xmdlamt
      LET l_ac = l_ac + 1
      ######
      
      
      #將資料更新進Temptable       
      UPDATE axmp600_tmp02               #160727-00019#25 Mod  axmp600_xmdl_tmp--> axmp600_tmp02
         SET sel = l_xmdl.sel,
             sum_xmdl028 = l_xmdl.sum_xmdl028,
             sale_return_amt = l_xmdl.sale_return_amt,
             xmdlamt = l_xmdl.xmdlamt
       WHERE xmdldocno = l_xmdl.xmdldocno AND xmdlseq = l_xmdl.xmdlseq
   END FOREACH
   
   #將累計本次銷退金額顯示到畫面上
   DISPLAY g_sum_xmdlamt TO l_sum
   
   LET l_ac = l_ac - 1
   DISPLAY l_ac TO FORMONLY.h_count
   
   #將符合的出貨/簽收單號寫入axmp600_tmp01
   LET g_sql = "INSERT INTO axmp600_tmp01 ",             #160727-00019#25 Mod  axmp600_xmdk_tmp--> axmp600_tmp01
               "(xmdkdocno,xmdk007,xmdk009,xmdk010,xmdk011,",
               " xmdk012,  xmdk015,xmdk016,xmdk017,xmdk018,",
               " xmdk042,  xmdk045,xmdk202) ",
               "SELECT DISTINCT xmdkdocno,xmdk007,xmdk009,xmdk010,xmdk011,",
               "       xmdk012,xmdk015,xmdk016,xmdk017,xmdk018,",
               "       COALESCE(xmdk042,' '),COALESCE(xmdk045,' '),COALESCE(xmdk202,' ')",
               "  FROM xmdk_t,axmp600_tmp02 a",        #160727-00019#25 Mod  axmp600_xmdl_tmp--> axmp600_tmp02
               " WHERE xmdkdocno = a.xmdldocno",
               "   AND xmdkent = a.xmdlent",
               "   AND xmdkent = ",g_enterprise
   PREPARE insert_xmdk_pre FROM g_sql
   EXECUTE insert_xmdk_pre
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = 'ins xmdk tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
   #若匯率來源是選擇2.目前匯率,則將axmp600_tmp01中的匯率值更新為l_exrate
   IF g_input2.l_exrate_source = '2' THEN
      UPDATE axmp600_tmp01 SET xmdk017 = g_input2.l_exrate             #160727-00019#25 Mod  axmp600_xmdk_tmp--> axmp600_tmp01
   END IF
   
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 執行
# Memo...........:
# Usage..........: CALL axmp600_process()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 15/06/12 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp600_process()
   DEFINE l_sql            STRING
   DEFINE l_where          STRING
   DEFINE l_xmdk           RECORD
          xmdk007          LIKE xmdk_t.xmdk007,     #客戶編號
          xmdk009          LIKE xmdk_t.xmdk009,     #收款客戶
          xmdk010          LIKE xmdk_t.xmdk010,     #收款條件
          xmdk011          LIKE xmdk_t.xmdk011,     #交易條件
          xmdk012          LIKE xmdk_t.xmdk012,     #稅別
          xmdk015          LIKE xmdk_t.xmdk015,     #發票類型
          xmdk016          LIKE xmdk_t.xmdk016,     #幣別
          xmdk017          LIKE xmdk_t.xmdk017,     #匯率
          xmdk018          LIKE xmdk_t.xmdk018,     #取價方式
          xmdk042          LIKE xmdk_t.xmdk042,     #內外銷
          xmdk045          LIKE xmdk_t.xmdk045,     #多角性質
          xmdk202          LIKE xmdk_t.xmdk202      #發票客戶
                           END RECORD
   DEFINE l_xmdl           RECORD
          sel              LIKE type_t.chr1,
          xmdlent          LIKE xmdl_t.xmdlent,
          xmdldocno        LIKE xmdl_t.xmdldocno,
          xmdkdocdt        LIKE xmdk_t.xmdkdocdt,
          xmdlseq          LIKE xmdl_t.xmdlseq,
          xmdl008          LIKE xmdl_t.xmdl008,
          xmdl009          LIKE xmdl_t.xmdl009,
          xmdl049          LIKE xmdl_t.xmdl049,
          xmdl028          LIKE xmdl_t.xmdl028,
          sum_xmdl028      LIKE xmdl_t.xmdl028,
          sale_return_amt  LIKE xmdl_t.xmdl028,
          xmdlamt          LIKE xmdl_t.xmdl028
                           END RECORD
   DEFINE l_success        LIKE type_t.num5
   DEFINE r_success        LIKE type_t.num5
   DEFINE r_xmdkdocno      LIKE xmdk_t.xmdkdocno    #銷退單號
   DEFINE l_xmdkdocno      LIKE xmdk_t.xmdkdocno
   DEFINE l_strno          LIKE xmdk_t.xmdkdocno
   DEFINE l_endno          LIKE xmdk_t.xmdkdocno
   
   LET g_success = TRUE
   LET l_strno = ''
   LET l_endno = ''

   #1.檢查單頭的本次銷退金額 與 單身的本次銷退金額加總 兩者相等
   IF g_input1.l_total_amt <> g_sum_xmdlamt THEN
      INITIALIZE g_errparam TO NULL
      #銷退資料的本次銷退金額%1與折讓明細的本次銷退金額加總%2不一致！請調整
      LET g_errparam.code = 'axm-00677'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = g_input1.l_total_amt
      LET g_errparam.replace[2] = g_sum_xmdlamt
      CALL cl_err()
      LET g_success = FALSE
      RETURN
   END IF
  
   #--------------------------------------------------------------------------------
   #匯總資料時，錯誤訊息先匯總後再顯示
   CALL cl_err_collect_init()
   #--------------------------------------------------------------------------------

   CALL s_transaction_begin() 
   
   #2.單身選擇="Y"的出貨單明細資料，
   #  依「客戶、收款客戶、收貨客戶、收款條件、交易條件、稅別、發票類型、幣別、匯率、
   #  取價方式、內外銷、多角性質、發票客戶」等欄位分別產生不同銷退單
   ##將勾選的出貨/簽收單彙總,看會產生幾筆銷退單的資料,將這些資料寫入暫存檔
   LET l_sql = "SELECT DISTINCT xmdk007,xmdk009,xmdk010,xmdk011,xmdk012,xmdk015,",
               "                xmdk016,xmdk017,xmdk018,xmdk042,xmdk045,xmdk202",
               "  FROM axmp600_tmp01",          #160727-00019#25 Mod  axmp600_xmdk_tmp--> axmp600_tmp01
               " WHERE xmdkdocno IN",
               " (SELECT xmdldocno FROM axmp600_tmp02 WHERE sel='Y' AND xmdlamt > 0)",       #160727-00019#25 Mod  axmp600_xmdl_tmp--> axmp600_tmp02   
               " ORDER BY xmdk007,xmdk009,xmdk010,xmdk011,xmdk012,xmdk015,",
               "          xmdk016,xmdk017,xmdk018,xmdk042,xmdk045,xmdk202"
   PREPARE axmp600_execute_pre FROM l_sql
   DECLARE axmp600_execute_curs CURSOR FOR axmp600_execute_pre
      
   LET l_sql = "SELECT * FROM axmp600_tmp02",             #160727-00019#25 Mod  axmp600_xmdl_tmp--> axmp600_tmp02
               " WHERE sel = 'Y' AND xmdlamt > 0 ",
               "   AND xmdldocno IN ",
               "(SELECT xmdkdocno FROM axmp600_tmp01",        #160727-00019#25 Mod  axmp600_xmdk_tmp--> axmp600_tmp01
               "  WHERE xmdk007=? AND xmdk009=? AND xmdk010=? AND xmdk011=?",
               "    AND xmdk012=? AND xmdk015=? AND xmdk016=? AND xmdk017=?",
               "    AND xmdk042=? AND xmdk045=? AND xmdk202=?)",      #170203-00010#1 remove 'AND xmdk018=? '
               " ORDER BY xmdldocno,xmdlseq"
   PREPARE axmp600_execute_b_pre FROM l_sql
   DECLARE axmp600_execute_b_curs CURSOR FOR axmp600_execute_b_pre
      
   FOREACH axmp600_execute_curs INTO l_xmdk.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET g_success = FALSE
         CALL s_transaction_end('N','0')
         EXIT FOREACH
      END IF
      #寫入銷退單單頭檔
      CALL axmp600_insert_xmdk(l_xmdk.*)
           RETURNING r_success,r_xmdkdocno
      IF r_success THEN
         IF cl_null(l_strno) THEN LET l_strno = r_xmdkdocno END IF
         LET l_endno = r_xmdkdocno   
         FOREACH axmp600_execute_b_curs
           USING l_xmdk.xmdk007,l_xmdk.xmdk009,l_xmdk.xmdk010,l_xmdk.xmdk011,
                 l_xmdk.xmdk012,l_xmdk.xmdk015,l_xmdk.xmdk016,l_xmdk.xmdk017,
                 l_xmdk.xmdk042,l_xmdk.xmdk045,l_xmdk.xmdk202       #170203-00010#1 remove l_xmdk.xmdk018
            INTO l_xmdl.*
            #寫入銷退單單身檔
            CALL axmp600_insert_xmdl(r_xmdkdocno,l_xmdl.*)
                 RETURNING r_success
            IF NOT r_success THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
#               LET g_errparam.extend = l_xmdl.xmdldocno," ",cl_getmsg('axm-00008',g_lang),l_xmdl.xmdlseq   #160318-00005#48  mark
               LET g_errparam.extend = l_xmdl.xmdldocno," ",cl_getmsg('anm-00225',g_lang),l_xmdl.xmdlseq    #160318-00005#48  add
               LET g_errparam.code   = 'adz-00217'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = FALSE
               CALL s_transaction_end('N','0')
               CONTINUE FOREACH
            END IF  
         END FOREACH
      ELSE
         SELECT xmdkdocno INTO l_xmdkdocno FROM axmp600_tmp01         #160727-00019#25 Mod  axmp600_xmdk_tmp--> axmp600_tmp01
          WHERE xmdk007=l_xmdk.xmdk007 AND xmdk009=l_xmdk.xmdk009
            AND xmdk010=l_xmdk.xmdk010 AND xmdk011=l_xmdk.xmdk011
            AND xmdk012=l_xmdk.xmdk012 AND xmdk015=l_xmdk.xmdk015
            AND xmdk016=l_xmdk.xmdk016 AND xmdk017=l_xmdk.xmdk017
            AND xmdk018=l_xmdk.xmdk018 AND xmdk042=l_xmdk.xmdk042
            AND xmdk045=l_xmdk.xmdk045 AND xmdk202=l_xmdk.xmdk202
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = l_xmdkdocno
         LET g_errparam.code   = 'adz-00217'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = FALSE
         CALL s_transaction_end('N','0')
         CONTINUE FOREACH
      END IF
   END FOREACH
   
   #3.產生成功、失敗的訊息以匯總方式呈現
   #--------------------------------------------------------------------------------
   #匯總資料時，錯誤訊息先匯總後再顯示
   CALL cl_err_collect_show()
   #--------------------------------------------------------------------------------
   
   IF g_bgjob = 'N' THEN
      IF g_success THEN
         CALL s_transaction_end('Y','0')
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00251'
         LET g_errparam.replace[1] = l_strno
         LET g_errparam.replace[2] = l_endno
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aap-00187'   #單據產生失敗
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
   ELSE
      IF g_success THEN
         CALL s_transaction_end('Y','0')
         CALL cl_ask_pressanykey("adz-00217")   #執行成功
      ELSE
         CALL cl_ask_pressanykey("adz-00218")   #執行失敗
      END IF
   END IF
   
END FUNCTION

#end add-point
 
{</section>}
 
