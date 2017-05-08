#該程式未解開Section, 採用最新樣板產出!
{<section id="armp300.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-12-05 16:11:19), PR版次:0002(2017-02-17 16:43:47)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: armp300
#+ Description: RMA轉覆出作業
#+ Creator....: 05423(2016-11-25 17:06:23)
#+ Modifier...: 05423 -SD/PR- 01996
 
{</section>}
 
{<section id="armp300.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#161129-00054#1    2016/12/05  By zhujing  单身添加库位储位栏位说明
#160711-00040#28   2017/02/16  By xujing T類作業的單別開窗的where條件(找CALL q_ooba002_開頭的)增加如下程式段
#                                        CALL s_control_get_docno_sql(g_user,g_dept) RETURNING l_success,l_sql1
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
   rmdadocno LIKE rmda_t.rmdadocno,
   rmdadocdt LIKE rmda_t.rmdadocdt,
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
     sel LIKE type_t.chr1,
     rmcbdocno LIKE rmcb_t.rmcbdocno,
     rmcbseq LIKE rmcb_t.rmcbseq,
     rmcb001 LIKE rmcb_t.rmcb001,
     rmcb002 LIKE rmcb_t.rmcb002,
     rmcb003 LIKE rmcb_t.rmcb003,
     rmcb004 LIKE rmcb_t.rmcb004,
     rmcb004_desc LIKE type_t.chr80,
     rmcb004_desc_1 LIKE type_t.chr80,
     rmcb005 LIKE rmcb_t.rmcb005,
     rmcb006 LIKE rmcb_t.rmcb006,
     rmcb006_desc LIKE type_t.chr80,
     rmcb007 LIKE rmcb_t.rmcb007,
     rmcb010 LIKE rmcb_t.rmcb010,
     qty LIKE rmcb_t.rmcb010
    END RECORD

TYPE type_g_detail2_d RECORD
     rmdadocno LIKE rmda_t.rmdadocno,
     rmdadocdt LIKE rmda_t.rmdadocdt,
     rmda002 LIKE rmda_t.rmda002,
     rmda003 LIKE rmda_t.rmda003,
     rmda005 LIKE rmda_t.rmda005,
     rmda_no LIKE type_t.num5
     END RECORD
TYPE type_g_detail3_d RECORD
     rmdbseq LIKE rmdb_t.rmdbseq,
     rmdb001 LIKE rmdb_t.rmdb001,
     rmdb002 LIKE rmdb_t.rmdb002,
     rmdb003 LIKE rmdb_t.rmdb003,
     rmdb004 LIKE rmdb_t.rmdb004,
     rmdb005 LIKE rmdb_t.rmdb005,
     rmdb006 LIKE rmdb_t.rmdb006,
     rmdb007 LIKE rmdb_t.rmdb007,
     rmdb007_desc LIKE inayl_t.inayl003,  #161129-00054#1 add
     rmdb008 LIKE rmdb_t.rmdb008,
     rmdb008_desc LIKE inab_t.inab003,    #161129-00054#1 add
     rmdb009 LIKE rmdb_t.rmdb009,
     rmdb010 LIKE rmdb_t.rmdb010,
     rmdb_no LIKE type_t.num5
     END RECORD

DEFINE g_rec_b  LIKE type_t.num5 
DEFINE g_ooef   RECORD LIKE ooef_t.*
DEFINE g_master  type_parameter  
DEFINE g_detail_idx LIKE type_t.num5
DEFINE g_detail_d_t type_g_detail_d
DEFINE g_detail2_d  DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_detail3_d  DYNAMIC ARRAY OF type_g_detail3_d
DEFINE l_ac2        LIKE type_t.num10
DEFINE l_ac3        LIKE type_t.num10
DEFINE g_hidden LIKE type_t.num5
DEFINE g_exe    LIKE type_t.num5
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="armp300.main" >}
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
   CALL cl_ap_init("arm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_armp300 WITH FORM cl_ap_formpath("arm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL armp300_init()   
 
      #進入選單 Menu (="N")
      CALL armp300_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_armp300
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="armp300.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION armp300_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   SELECT * INTO g_ooef.* FROM ooef_t WHERE ooefent= g_enterprise AND ooef001 = g_site
   LET g_hidden = TRUE
   LET g_exe = TRUE
   LET g_master.rmdadocdt = g_today
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="armp300.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION armp300_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_type       LIKE type_t.chr1
   DEFINE l_inaa007    LIKE inaa_t.inaa007
   DEFINE l_ooef004    LIKE ooef_t.ooef004
   DEFINE l_n          LIKE type_t.num5
   DEFINE l_ooba015    LIKE ooba_t.ooba015
   DEFINE l_ooba002    LIKE ooba_t.ooba002
   DEFINE l_acc        LIKE gzcb_t.gzcb007
   DEFINE l_acc2       LIKE gzcb_t.gzcb007
   DEFINE l_flag       LIKE type_t.chr1
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_sql1          STRING            #160711-00040#28 add
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL cl_set_comp_visible('detail2',FALSE)
   LET g_errshow = 1
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL armp300_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_master.wc ON rmcadocno,rmcadocdt,rmca003,rmca004,rmcb001
            BEFORE CONSTRUCT
            ON ACTION controlp INFIELD rmcadocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " rmcastus = 'Y' AND EXISTS (SELECT 1 FROM rmcb_t WHERE rmcbdocno = rmcadocno AND rmcbent = ",g_enterprise," AND rmcbsite = '",g_site,"' AND rmcb009 = '3'  AND rmcb007-rmcb010 > 0 ) " 
               CALL q_rmcadocno()                       
               DISPLAY g_qryparam.return1 TO rmcadocno  
               NEXT FIELD rmcadocno                     

            ON ACTION controlp INFIELD rmca003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                       
               DISPLAY g_qryparam.return1 TO rmca003  
               NEXT FIELD rmca003                     
               
            ON ACTION controlp INFIELD rmca004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_ooeg001_9()                    
               DISPLAY g_qryparam.return1 TO rmca004 
               NEXT FIELD rmca004                    

            ON ACTION controlp INFIELD rmcb001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_rmaadocno()                       
               DISPLAY g_qryparam.return1 TO rmcb001  
               NEXT FIELD rmcb001
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_master.rmdadocno,g_master.rmdadocdt
            ATTRIBUTE(WITHOUT DEFAULTS)        

            AFTER FIELD rmdadocno
               IF NOT cl_null(g_master.rmdadocno) THEN 
                  IF NOT s_aooi200_chk_slip(g_site,'',g_master.rmdadocno,'armt400') THEN
                     LET g_master.rmdadocno = ''
                     NEXT FIELD CURRENT
                  END IF   
               END IF

            ON ACTION controlp INFIELD rmdadocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.rmdadocno 
               LET g_qryparam.arg1 = g_ooef.ooef004
               LET g_qryparam.arg2 = 'armt400'
               #160711-00040#28 add(s)
               CALL s_control_get_docno_sql(g_user,g_dept)
                   RETURNING l_success,l_sql1
               IF NOT cl_null(l_sql1) THEN
                  LET g_qryparam.where = l_sql1
               END IF
               #160711-00040#28 add(e)
               CALL q_ooba002_1()                              
               LET g_master.rmdadocno = g_qryparam.return1              
               NEXT FIELD rmdadocno

         END INPUT
         INPUT ARRAY g_detail_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS,
                     INSERT ROW = FALSE, 
                     DELETE ROW = FALSE,
                     APPEND ROW = FALSE) 
                     
            BEFORE INPUT           
               CALL FGL_SET_ARR_CURR(l_ac)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")            
            
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               DISPLAY l_ac TO FORMONLY.h_index
            
            ON CHANGE b_sel 
               CALL armp300_upd_rmcb()
               
            AFTER FIELD b_qty            
               IF NOT cl_null(g_detail_d[l_ac].qty) THEN 
                  IF NOT cl_ap_chk_range(g_detail_d[l_ac].qty,"0","0","","","azz-00079",1) THEN
                     LET g_detail_d[l_ac].qty = g_detail_d_t.qty 
                     NEXT FIELD CURRENT
                  END IF                
                  IF g_detail_d[l_ac].qty > g_detail_d[l_ac].rmcb007 - g_detail_d[l_ac].rmcb010 THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_detail_d[l_ac].qty 
                     LET g_errparam.code   = "arm-00024"
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()    
                     LET g_detail_d[l_ac].qty = g_detail_d_t.qty                     
                     NEXT FIELD CURRENT
                  END IF
               END IF   
               CALL armp300_upd_rmcb() 
               
            ON ROW CHANGE 
               CALL armp300_upd_rmcb()               
               
         END INPUT
         
         INPUT ARRAY g_detail2_d FROM s_detail2.*
             ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS,
                     INSERT ROW = FALSE, 
                     DELETE ROW = FALSE,
                     APPEND ROW = FALSE) 
                     
            BEFORE INPUT         #here
               CALL armp300_upd_rmdb()    #new          
               CALL armp300_b_fill2()
               LET l_ac2 = g_curr_diag.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac2
               IF g_detail_idx > g_detail2_d.getLength() THEN
                  LET g_detail_idx = g_detail2_d.getLength()
               END IF
               IF g_detail_idx = 0 AND g_detail2_d.getLength() <> 0 THEN
                  LET g_detail_idx = 1
               END IF               
               
            BEFORE ROW
               LET l_ac2 = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac2
               DISPLAY l_ac2 TO FORMONLY.h_index
               CALL armp300_b_fill3()               
            
            AFTER FIELD rmdadocno_1            
               IF NOT cl_null(g_detail2_d[l_ac2].rmdadocno) THEN 
                  IF NOT s_aooi200_chk_slip(g_site,'',g_detail2_d[l_ac2].rmdadocno,'armt400') THEN
                     LET g_detail2_d[l_ac2].rmdadocno = ''
                     NEXT FIELD CURRENT
                  END IF   
               END IF
            ON ACTION controlp INFIELD rmdadocno_1
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail2_d[l_ac2].rmdadocno 
               LET g_qryparam.arg1 = g_ooef.ooef004
               LET g_qryparam.arg2 = 'armt400'
               #160711-00040#28 add(s)
               CALL s_control_get_docno_sql(g_user,g_dept)
                   RETURNING l_success,l_sql1
               IF NOT cl_null(l_sql1) THEN
                  LET g_qryparam.where = l_sql1
               END IF
               #160711-00040#28 add(e)
               CALL q_ooba002_1()                              
               LET g_detail2_d[l_ac2].rmdadocno = g_qryparam.return1              
               NEXT FIELD rmdadocno_1
               
            ON ROW CHANGE
               CALL armp300_upd_rmda() #new
            AFTER ROW  
               CALL armp300_upd_rmda()            
         END INPUT  
         
         INPUT ARRAY g_detail3_d FROM s_detail3.*
             ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS,
                     INSERT ROW = FALSE, 
                     DELETE ROW = FALSE,
                     APPEND ROW = FALSE) 
                     
            BEFORE INPUT 
               CALL armp300_upd_rmda()            
               CALL FGL_SET_ARR_CURR(l_ac3)
               LET l_ac3 = DIALOG.getCurrentRow("s_detail3") 
               
            BEFORE ROW
               LET l_ac3 = DIALOG.getCurrentRow("s_detail3")
               DISPLAY l_ac3 TO FORMONLY.h_index 
               IF NOT cl_null(g_detail3_d[l_ac3].rmdb007) THEN    #库位
                  CALL cl_set_comp_entry("rmdb008",TRUE)
                  IF NOT s_axmt540_inaa007_chk(g_detail3_d[l_ac3].rmdb007) THEN 
                     LET g_detail3_d[l_ac3].rmdb008 = ' '
                     CALL cl_set_comp_entry("rmdb008",FALSE)
                  END IF
               END IF   
            AFTER FIELD rmdb007 
               IF NOT cl_null(g_detail3_d[l_ac3].rmdb007)THEN
                  #得出來源成本庫否
                  CALL s_axmt600_warehouse_cost(g_detail3_d[l_ac3].rmdb001,g_detail3_d[l_ac3].rmdb002)
                  RETURNING l_type                  
                                 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                 
                  #替換錯誤訊息
                  LET g_chkparam.err_str[1] = "axm-00197:axm-00387"
                           
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = g_detail3_d[l_ac3].rmdb007    #庫位
                  LET g_chkparam.arg3 = l_type
                           
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_inaa001_6") THEN
                     LET g_detail3_d[l_ac3].rmdb007 = ''
                     LET g_detail3_d[l_ac3].rmdb007_desc = '' #161129-00054#1 add
                     NEXT FIELD CURRENT
                  END IF
                  #檢核輸入的庫位(From)是否在單據別限制範圍內
                  IF NOT cl_null(g_master.rmdadocno) THEN
                     CALL s_control_chk_doc('6',g_master.rmdadocno,g_detail3_d[l_ac3].rmdb007,'','','','')
                     RETURNING l_success,l_flag
                     IF NOT l_success OR NOT l_flag THEN
                        LET g_detail3_d[l_ac3].rmdb007 = ''
                        LET g_detail3_d[l_ac3].rmdb007_desc = '' #161129-00054#1 add
                        NEXT FIELD CURRENT
                     END IF
                  END IF 
                  IF NOT cl_null(g_detail3_d[l_ac3].rmdb008) THEN                  
                     #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                     INITIALIZE g_chkparam.* TO NULL
                                    
                     #設定g_chkparam.*的參數
                     LET g_chkparam.arg1 = g_site
                     LET g_chkparam.arg2 = g_detail3_d[l_ac3].rmdb007
                     LET g_chkparam.arg3 = g_detail3_d[l_ac3].rmdb008
                    #160318-00025#21  by 07900 --add-str
                     LET g_errshow = TRUE #是否開窗                   
                     LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                     #160318-00025#21  by 07900 --add-end                    
                     #呼叫檢查存在並帶值的library
                     IF NOT cl_chk_exist("v_inab002") THEN
                        LET g_detail3_d[l_ac3].rmdb008 = ''
                        LET g_detail3_d[l_ac3].rmdb008_desc = '' #161129-00054#1 add
                        NEXT FIELD CURRENT
                     END IF    
                  END IF 
                  CALL cl_set_comp_entry("rmdb008",TRUE)
                  IF NOT s_axmt540_inaa007_chk(g_detail3_d[l_ac3].rmdb007) THEN 
                     LET g_detail3_d[l_ac3].rmdb007 = ' '
                     LET g_detail3_d[l_ac3].rmdb008_desc = '' #161129-00054#1 add
                     CALL cl_set_comp_entry("rmdb008",FALSE)
                  END IF
                  #161129-00054#1 add-S
                  INITIALIZE g_ref_fields TO NULL 
                  LET g_ref_fields[1] = g_detail3_d[l_ac3].rmdb007
                  CALL ap_ref_array2(g_ref_fields," SELECT inayl003 FROM inayl_t WHERE inaylent = '"||g_enterprise||"' AND inayl001 = ? AND inayl002 = '"||g_dlang||"' ","") RETURNING g_rtn_fields 
                  LET g_detail3_d[l_ac3].rmdb007_desc = g_rtn_fields[1] 
                  #161129-00054#1 add-E                  
               END IF
               
            AFTER FIELD rmdb008 
               IF NOT cl_null(g_detail3_d[l_ac3].rmdb008) THEN
                  IF cl_null(g_detail3_d[l_ac3].rmdb007) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'sub-00126'    #庫位不可為空
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD CURRENT
                  END IF
               
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                                 
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = g_detail3_d[l_ac3].rmdb007
                  LET g_chkparam.arg3 = g_detail3_d[l_ac3].rmdb008
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                  #160318-00025#21  by 07900 --add-end                   
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_inab002") THEN
                     LET g_detail3_d[l_ac3].rmdb008 = ''
                     LET g_detail3_d[l_ac3].rmdb008_desc = ''  #161129-00054#1 add
                     NEXT FIELD CURRENT
                  END IF    
                  #161129-00054#1 add-S
                  INITIALIZE g_ref_fields TO NULL 
                  LET g_ref_fields[1] = g_detail3_d[l_ac3].rmdb007
                  LET g_ref_fields[2] = g_detail3_d[l_ac3].rmdb008
                  CALL ap_ref_array2(g_ref_fields," SELECT inab003 FROM inab_t WHERE inabent = '"||g_enterprise||"' AND inab001 = ? AND inab002 = ? ","") RETURNING g_rtn_fields 
                  LET g_detail3_d[l_ac3].rmdb008_desc = g_rtn_fields[1] 
                  #161129-00054#1 add-E  
               END IF    
            
            ON ACTION controlp INFIELD rmdb007
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail3_d[l_ac3].rmdb007
               CALL s_axmt600_warehouse_cost(g_detail3_d[l_ac3].rmdb001,g_detail3_d[l_ac3].rmdb002)
                  RETURNING l_type 
               LET g_qryparam.arg1 = g_site
               LET g_qryparam.where = "inaa010 = 'N'"
               CALL q_inaa001_4()                              
               LET g_detail3_d[l_ac3].rmdb007 = g_qryparam.return1              
               NEXT FIELD rmdb007
               
            ON ACTION controlp INFIELD rmdb008
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail3_d[l_ac3].rmdb008 
               LET g_qryparam.arg1 = g_site
               LET g_qryparam.arg2 = g_detail3_d[l_ac3].rmdb007
               CALL q_inab002_8()                              
               LET g_detail3_d[l_ac3].rmdb008= g_qryparam.return1              
               NEXT FIELD rmdb008
               
            ON ROW CHANGE
               CALL armp300_upd_rmdb()               
            AFTER ROW   
               CALL armp300_upd_rmdb()
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
            CALL armp300_filter()
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
            CALL armp300_query()
            NEXT FIELD rmdadocno
            #end add-point
            CALL armp300_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL armp300_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION btn_next
            IF g_detail_d.getLength() = 0 THEN 
               CONTINUE DIALOG
            END IF            
            IF g_hidden THEN 
               CALL cl_set_comp_visible('detail',FALSE)
               CALL cl_set_comp_visible('detail2',TRUE)
               LET g_hidden = FALSE
            END IF
            CALL armp300_upd_rmcb()
            CALL armp300_ins_temp()
            CALL armp300_b_fill2()
            IF g_detail2_d.getLength() <> 0 THEN 
               LET g_detail_idx = 1
            END IF          
            CALL armp300_b_fill3()            
            NEXT FIELD rmdb007
         
         ON ACTION btn_pre
            IF NOT g_hidden THEN 
               CALL cl_set_comp_visible('detail',TRUE)
               CALL cl_set_comp_visible('detail2',FALSE)
               LET g_hidden = TRUE
               LET g_exe = TRUE
            END IF         
            NEXT FIELD rmdadocno
            
         ON ACTION btn_exe
            IF g_exe THEN
               CALL armp300_upd_rmdb()
               CALL armp300_execute() 
               CALL armp300_b_fill2()
               LET g_exe = FALSE
               CALL armp300_display()
            END IF 
            IF NOT g_hidden THEN 
               CALL cl_set_comp_visible('detail',TRUE)
               CALL cl_set_comp_visible('detail2',FALSE)
               LET g_hidden = TRUE
               LET g_exe = TRUE
            END IF             
            EXIT DIALOG            
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
 
{<section id="armp300.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION armp300_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   DEFINE l_sql STRING 
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   CALL cl_set_comp_visible('detail',TRUE)
   CALL cl_set_comp_visible('detail2',FALSE)
   LET g_hidden = TRUE   
   LET g_exe = TRUE 
   CALL armp300_drop_table()
   CALL armp300_create_table()
   IF cl_null(g_master.wc) THEN 
      LET g_master.wc = '1=1'
   END IF 
   LET l_sql = " INSERT INTO p300_rmcb ",
               " SELECT 'N',rmcbdocno,rmcbseq,rmcb001,rmcb002, ",
               "        rmcb003,rmcb004,rmcb005,rmcb006,",
               "        rmcb007,rmcb010,rmcb007-rmcb010 ",
               "   FROM rmca_t,rmcb_t ",
               "  WHERE rmcaent = rmcbent AND rmcadocno = rmcbdocno ",
               "    AND rmcaent = '",g_enterprise,"'",
               "    AND rmcasite = '",g_site,"'",
               "    AND rmcb009 = '3' ",        #直接覆出
               "    AND rmcastus = 'Y'",
               "    AND rmcb007-rmcb010 > 0 ",
               "    AND ",g_master.wc
   PREPARE p300_ins_rmcb FROM l_sql
   EXECUTE p300_ins_rmcb 
   #end add-point
        
   LET g_error_show = 1
   CALL armp300_b_fill()
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
 
{<section id="armp300.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION armp300_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
 
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #add-point:b_fill段sql_before
   LET g_sql = "SELECT 'N',rmcbdocno,rmcbseq,rmcb001,rmcb002,rmcb003,rmcb004, ",
               "        imaal003,imaal004,rmcb005,rmcb006,oocal003,",
               "        rmcb007,rmcb010,qty ",
               "   FROM p300_rmcb ",
               "        LEFT OUTER JOIN imaal_t ON imaalent = '",g_enterprise,"' AND rmcb004=imaal001 AND imaal002='",g_dlang,"'",
               "        LEFT OUTER JOIN oocal_t ON oocalent = ? AND rmcb006=oocal001 AND oocal002='",g_dlang,"'"  
   #end add-point
 
   PREPARE armp300_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR armp300_sel
   
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
      
      #end add-point
      
      CALL armp300_detail_show()      
 
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
   FREE armp300_sel
   
   LET l_ac = 1
   CALL armp300_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   CALL g_detail_d.deleteElement(g_detail_d.getLength())
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="armp300.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION armp300_fetch()
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
 
{<section id="armp300.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION armp300_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="armp300.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION armp300_filter()
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
   
   CALL armp300_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="armp300.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION armp300_filter_parser(ps_field)
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
 
{<section id="armp300.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION armp300_filter_show(ps_field,ps_object)
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
   LET ls_condition = armp300_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="armp300.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION armp300_create_table()
   
   WHENEVER ERROR CONTINUE     

   CREATE TEMP TABLE p300_rmcb(
     sel  VARCHAR(1),
     rmcbdocno  VARCHAR(20),
     rmcbseq  INTEGER,
     rmcb001  VARCHAR(20),
     rmcb002  INTEGER,
     rmcb003  INTEGER,
     rmcb004  VARCHAR(40),
     rmcb005  VARCHAR(256),
     rmcb006  VARCHAR(10),
     rmcb007  DECIMAL(20,6),
     rmcb010  DECIMAL(20,6),
     qty  DECIMAL(20,6));

   #覆出单单头
   CREATE TEMP TABLE p300_rmda(
     rmdadocno  VARCHAR(20),
     rmdadocdt  DATE,
     rmda002  VARCHAR(20),
     rmda003  VARCHAR(10),
     rmda005  VARCHAR(10),
     rmda004  VARCHAR(20),
     rmda_no  SMALLINT);
    
   #覆出单单身    
   CREATE TEMP TABLE p300_rmdb(
     rmdbseq  INTEGER,
     rmdb001  VARCHAR(20),
     rmdb002  INTEGER,
     rmdb003  VARCHAR(40),
     rmdb004  VARCHAR(256),
     rmdb005  VARCHAR(10),
     rmdb006  DECIMAL(20,6),
     rmdb007  VARCHAR(10),
     rmdb008  VARCHAR(10),
     rmdb009  VARCHAR(30),
     rmdb010  VARCHAR(30),     
     rmdb013  DECIMAL(20,6),           #计价数量
     rmdb015  DECIMAL(20,6),           #单价
     rmdb016  DECIMAL(20,6),           #税前金额
     rmdb017  DECIMAL(20,6),           #含税金额
     rmdb_no  SMALLINT);
   
END FUNCTION

PRIVATE FUNCTION armp300_drop_table()
   DROP TABLE p300_rmcb;
   DROP TABLE p300_rmda;
   DROP TABLE p300_rmdb;
END FUNCTION

PRIVATE FUNCTION armp300_upd_rmcb()
   IF cl_null(l_ac) OR l_ac = 0 THEN RETURN END IF 
  
   UPDATE p300_rmcb
      SET sel = g_detail_d[l_ac].sel, 
          qty = g_detail_d[l_ac].qty
    WHERE rmcbdocno = g_detail_d[l_ac].rmcbdocno
      AND rmcbseq = g_detail_d[l_ac].rmcbseq 
END FUNCTION

PRIVATE FUNCTION armp300_ins_temp()
DEFINE l_sql STRING
DEFINE l_success LIKE type_t.num5
DEFINE l_cnt LIKE type_t.num5
DEFINE l_rmcb RECORD
     rmcbdocno LIKE rmcb_t.rmcbdocno,
     rmcbseq LIKE rmcb_t.rmcbseq,
     rmcb001 LIKE rmcb_t.rmcb001,
     rmcb002 LIKE rmcb_t.rmcb002,
     rmcb003 LIKE rmcb_t.rmcb003,
     rmcb004 LIKE rmcb_t.rmcb004,
     rmcb005 LIKE rmcb_t.rmcb005,
     rmcb006 LIKE rmcb_t.rmcb006,
     rmcb007 LIKE rmcb_t.rmcb007,
     rmcb010 LIKE rmcb_t.rmcb010,
     qty LIKE rmcb_t.rmcb010
    END RECORD
DEFINE l_rmda RECORD
     rmdadocno LIKE rmda_t.rmdadocno,
     rmdadocdt LIKE rmda_t.rmdadocdt,
     rmda002 LIKE rmda_t.rmda002,
     rmda003 LIKE rmda_t.rmda003,
     rmda005 LIKE rmda_t.rmda005,
     rmda004 LIKE rmda_t.rmda004,
     rmda_no LIKE type_t.num5
     END RECORD
DEFINE l_rmdb RECORD
     rmdbseq LIKE rmdb_t.rmdbseq,
     rmdb001 LIKE rmdb_t.rmdb001,
     rmdb002 LIKE rmdb_t.rmdb002,
     rmdb003 LIKE rmdb_t.rmdb003,
     rmdb004 LIKE rmdb_t.rmdb004,
     rmdb005 LIKE rmdb_t.rmdb005,
     rmdb006 LIKE rmdb_t.rmdb006,
     rmdb007 LIKE rmdb_t.rmdb007,
     rmdb008 LIKE rmdb_t.rmdb008,
     rmdb009 LIKE rmdb_t.rmdb009,
     rmdb010 LIKE rmdb_t.rmdb010,     
     rmdb013 LIKE rmdb_t.rmdb013,      #计价数量
     rmdb015 LIKE rmdb_t.rmdb015,      #单价
     rmdb016 LIKE rmdb_t.rmdb016,      #税前金额
     rmdb017 LIKE rmdb_t.rmdb017,      #含税金额
     rmdb_no LIKE type_t.num5
     END RECORD
DEFINE l_rmda005_t   LIKE rmda_t.rmda005     #客户编号
DEFINE l_rmba006     LIKE rmba_t.rmba006     #税种
DEFINE l_rmba010     LIKE rmba_t.rmba010     #币种
DEFINE l_rmba011     LIKE rmba_t.rmba011     #汇率
DEFINE l_tax         LIKE rmdb_t.rmdb017     #税额

   DELETE FROM p300_rmda;
   DELETE FROM p300_rmdb;
   
   
   LET l_rmda005_t = ''
   LET l_cnt = 1  
   LET l_sql = " SELECT rmcbdocno,rmcbseq,rmcb001,rmcb002,rmcb003,",
               "        rmcb004,rmcb005,rmcb006,rmcb007,rmcb010,qty ",
               "   FROM p300_rmcb ",
               "  WHERE sel = 'Y' ",
               "  ORDER BY rmcb001 "
   PREPARE p300_rmcb_pre FROM l_sql
   DECLARE p300_rmcb_cur CURSOR FOR p300_rmcb_pre
   FOREACH p300_rmcb_cur INTO l_rmcb.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      SELECT rmaa001 INTO l_rmda.rmda005
        FROM rmaa_t
       WHERE rmaaent = g_enterprise
         AND rmaadocno = l_rmcb.rmcb001
         
      IF cl_null(l_rmda005_t) OR l_rmda005_t <> l_rmda.rmda005 THEN 
         LET l_cnt  = l_cnt + 1
         LET l_rmda.rmdadocno = g_master.rmdadocno
         LET l_rmda.rmdadocdt = g_master.rmdadocdt
         LET l_rmda.rmda002 = g_user
         LET l_rmda.rmda003 = g_dept
         LET l_rmda.rmda004 = l_rmcb.rmcb001
         SELECT rmaa001 INTO l_rmda.rmda005
           FROM rmaa_t
          WHERE rmaaent = g_enterprise
            AND rmaadocno = l_rmcb.rmcb001  
         LET l_rmda.rmda_no = l_cnt
         INSERT INTO p300_rmda VALUES (l_rmda.*) 

        LET l_rmda005_t = l_rmda.rmda005
      END IF
      
      ##新增備料明細
      SELECT MAX(rmdbseq) INTO l_rmdb.rmdbseq
        FROM p300_rmdb
       WHERE rmdb_no = l_cnt 
      IF cl_null(l_rmdb.rmdbseq) THEN 
         LET l_rmdb.rmdbseq = 1
      ELSE
         LET l_rmdb.rmdbseq = l_rmdb.rmdbseq + 1      
      END IF
      
      LET l_rmdb.rmdb001 = l_rmcb.rmcb001   
      LET l_rmdb.rmdb002 = l_rmcb.rmcb002   
      LET l_rmdb.rmdb003 = l_rmcb.rmcb004    #料号
      LET l_rmdb.rmdb004 = l_rmcb.rmcb005    #产品特征
      LET l_rmdb.rmdb005 = l_rmcb.rmcb006    #单位
      #库位、储位带单别参数值
      LET l_rmdb.rmdb007 = cl_get_doc_para(g_enterprise,g_site,g_master.rmdadocno,'E-MFG-0042')
      
      SELECT rmac004,rmac005                 #批号、库存特征
        INTO l_rmdb.rmdb009,l_rmdb.rmdb010
        FROM rmac_t
       WHERE rmacent = g_enterprise
         AND rmacdocno = l_rmcb.rmcb001
         AND rmacseq = l_rmcb.rmcb002
         AND rmacseq1 = l_rmcb.rmcb003
      
      #计价数量带覆出数量
      LET l_rmdb.rmdb006 = l_rmcb.qty
      LET l_rmdb.rmdb013 = l_rmcb.qty
      LET l_rmdb.rmdb_no = l_cnt 
      #单价、税前金额、含税金额
      IF NOT cl_null(l_rmdb.rmdb001) OR NOT cl_null(l_rmdb.rmdb002) THEN 
         SELECT rmba006,rmba010,rmba011 INTO l_rmba006,l_rmba010,l_rmba011
           FROM rmba_t
          WHERE rmbadocno = l_rmdb.rmdb001
            AND rmbasite = g_site
            AND rmbaent = g_enterprise
          ORDER BY rmba000 DESC
         LET l_rmdb.rmdb015 = 0 
         CALL s_axmt500_get_amount(l_rmdb.rmdb001,l_rmdb.rmdb002,l_rmdb.rmdb013,l_rmdb.rmdb015,l_rmba006,l_rmba010,l_rmba011)
            RETURNING l_rmdb.rmdb016,l_rmdb.rmdb017,l_tax
         IF cl_null(l_rmdb.rmdb016) THEN LET l_rmdb.rmdb016 = 0 END IF
         IF cl_null(l_rmdb.rmdb017) THEN LET l_rmdb.rmdb017 = 0 END IF
      END IF

      INSERT INTO p300_rmdb VALUES(l_rmdb.*)
   END FOREACH   
END FUNCTION

PRIVATE FUNCTION armp300_execute()
DEFINE l_sql STRING
DEFINE l_success LIKE type_t.num5
DEFINE l_rmda RECORD  #RMA覆出單單頭檔
       rmdaent    LIKE rmda_t.rmdaent, #企业编号
       rmdasite   LIKE rmda_t.rmdasite, #营运据点
       rmdadocno  LIKE rmda_t.rmdadocno, #覆出单号
       rmdadocdt  LIKE rmda_t.rmdadocdt, #覆出日期
       rmda_no LIKE type_t.num5,
       rmda001 LIKE rmda_t.rmda001, #扣账日期
       rmda002 LIKE rmda_t.rmda002, #业务人员
       rmda003 LIKE rmda_t.rmda003, #业务部门
       rmda004 LIKE rmda_t.rmda004, #RMA单号
       rmda005 LIKE rmda_t.rmda005, #客户编号
       rmda006 LIKE rmda_t.rmda006, #收货客户
       rmda007 LIKE rmda_t.rmda007, #账款客户
       rmda008 LIKE rmda_t.rmda008, #发票客户
       rmda009 LIKE rmda_t.rmda009, #包装单制作
       rmda010 LIKE rmda_t.rmda010, #invoice制作
       rmda011 LIKE rmda_t.rmda011, #送货地址
       rmda012 LIKE rmda_t.rmda012, #运输方式
       rmda013 LIKE rmda_t.rmda013, #起运地
       rmda014 LIKE rmda_t.rmda014, #目的地
       rmda015 LIKE rmda_t.rmda015, #送货供应商
       rmda016 LIKE rmda_t.rmda016, #航班/船班/车号
       rmda017 LIKE rmda_t.rmda017, #起运日期
       rmda018 LIKE rmda_t.rmda018, #唛头编号
       rmda019 LIKE rmda_t.rmda019, #运输状态
       rmdaownid LIKE rmda_t.rmdaownid, #资料所有者
       rmdaowndp LIKE rmda_t.rmdaowndp, #资料所有部门
       rmdacrtid LIKE rmda_t.rmdacrtid, #资料录入者
       rmdacrtdp LIKE rmda_t.rmdacrtdp, #资料录入部门
       rmdacrtdt LIKE rmda_t.rmdacrtdt, #资料创建日
       rmdamodid LIKE rmda_t.rmdamodid, #资料更改者
       rmdamoddt LIKE rmda_t.rmdamoddt, #最近更改日
       rmdastus LIKE rmda_t.rmdastus, #状态码
       rmdacnfid LIKE rmda_t.rmdacnfid, #资料审核者
       rmdacnfdt LIKE rmda_t.rmdacnfdt, #数据审核日
       rmdapstid LIKE rmda_t.rmdapstid, #资料过账者
       rmdapstdt LIKE rmda_t.rmdapstdt  #资料过账日
END RECORD
DEFINE l_rmdb RECORD  #RMA覆出單單身檔
       rmdbent LIKE rmdb_t.rmdbent, #企业编号
       rmdbsite LIKE rmdb_t.rmdbsite, #营运据点
       rmdbdocno LIKE rmdb_t.rmdbdocno, #单据单号
       rmdb_no  LIKE type_t.num5,
       rmdbseq LIKE rmdb_t.rmdbseq, #项次
       rmdb001 LIKE rmdb_t.rmdb001, #RMA单号
       rmdb002 LIKE rmdb_t.rmdb002, #RMA项次
       rmdb003 LIKE rmdb_t.rmdb003, #料号
       rmdb004 LIKE rmdb_t.rmdb004, #产品特征
       rmdb005 LIKE rmdb_t.rmdb005, #单位
       rmdb006 LIKE rmdb_t.rmdb006, #覆出数量
       rmdb007 LIKE rmdb_t.rmdb007, #库位
       rmdb008 LIKE rmdb_t.rmdb008, #储位
       rmdb009 LIKE rmdb_t.rmdb009, #批号
       rmdb010 LIKE rmdb_t.rmdb010, #库存特征
       rmdb011 LIKE rmdb_t.rmdb011, #备注
       rmdb012 LIKE rmdb_t.rmdb012, #多库储批出货
       rmdb013 LIKE rmdb_t.rmdb013, #计价数量
       rmdb014 LIKE rmdb_t.rmdb014, #覆出类型
       rmdb015 LIKE rmdb_t.rmdb015, #单价
       rmdb016 LIKE rmdb_t.rmdb016, #税前金额
       rmdb017 LIKE rmdb_t.rmdb017  #含税金额
END RECORD
DEFINE l_slip       LIKE ooba_t.ooba001
#160816-00066#5 add-S
DEFINE l_stano    LIKE rmda_t.rmdadocno   
DEFINE l_endno    LIKE rmda_t.rmdadocno   
DEFINE l_cnt      LIKE type_t.num10       
DEFINE l_str      STRING                  
DEFINE ls_wc      STRING
DEFINE la_param   RECORD
       prog       STRING,
       actionid   STRING,
       background LIKE type_t.chr1,
       param      DYNAMIC ARRAY OF STRING
       END RECORD
DEFINE ls_js      STRING
#160816-00066#5 add-E

   CALL s_transaction_begin() 
   CALL cl_err_collect_init()
   LET l_sql = " INSERT INTO rmda_t(rmdaent,rmdasite,rmdadocno,rmdadocdt,rmda001,", 
               "                    rmda002,rmda003,rmda004,rmda005,rmda006,",  
               "                    rmda007,rmda008,rmda009,rmda010,rmda011,",   
               "                    rmda012,rmda013,rmda014,rmda015,rmda016,rmda017,",
               "                    rmda018,rmda019,rmdaownid,rmdaowndp,rmdacrtid,",   
               "                    rmdacrtdp,rmdacrtdt,rmdamodid,rmdamoddt,rmdastus,", 
               "                    rmdacnfid,rmdacnfdt,rmdapstid,rmdapstdt) ",
               "  VALUES(?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,?,  ?,?,?,?,?,",
               "         ?,?,?,?,?,  ?,?,?,? )"      
   PREPARE rmda_ins FROM l_sql 

   LET l_sql = " INSERT INTO rmdb_t(rmdbent,rmdbsite,rmdbdocno,rmdbseq,rmdb001,",
               "                    rmdb002,rmdb003,rmdb004,rmdb005,rmdb006,",
               "                    rmdb007,rmdb008,rmdb009,rmdb010,rmdb012,",
               "                    rmdb013,rmdb014,rmdb015,rmdb016,rmdb017 ) ",
               " SELECT '",g_enterprise,"','",g_site,"',?,rmdbseq,rmdb001,",
               "                  rmdb002,rmdb003,rmdb004,rmdb005,rmdb006,",
               "                  rmdb007,rmdb008,rmdb009,rmdb010,'N',",
               "                  rmdb013,'3',rmdb015,rmdb016,rmdb017 ",
               "   FROM p300_rmdb WHERE rmdb_no = ?"
   PREPARE rmdb_ins FROM l_sql  
   
   LET l_sql = " INSERT INTO rmdc_t(rmdcent,rmdcsite,rmdcdocno,rmdcseq,rmdcseq1,",
               "                    rmdc001,rmdc002,rmdc003,rmdc004,rmdc005,",
               "                    rmdc006,rmdc007,rmdc008 ) ",
               " SELECT '",g_enterprise,"','",g_site,"',?,rmdbseq,'1',",
               "                  rmdb003,rmdb004,rmdb005,rmdb006,rmdb007,",
               "                  rmdb008,rmdb009,rmdb010 ",
               "   FROM p300_rmdb WHERE rmdb_no = ?"
   PREPARE rmdc_ins FROM l_sql  
   
   LET l_success = TRUE
   LET l_sql = "SELECT DISTINCT rmdadocno,rmdadocdt,rmda002,rmda003,rmda005,rmda004,rmda_no ",
               "  FROM p300_rmda "
   PREPARE armp300_rmda_p FROM l_sql
   DECLARE armp300_rmda_c CURSOR FOR armp300_rmda_p
   LET l_cnt = 1     #160816-00066#5 add
   FOREACH armp300_rmda_c INTO l_rmda.rmdadocno,l_rmda.rmdadocdt,l_rmda.rmda002,
                               l_rmda.rmda003,l_rmda.rmda005,l_rmda.rmda004,l_rmda.rmda_no
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF   
      #产生覆出单单头
      CALL s_aooi200_gen_docno(g_site,l_rmda.rmdadocno,l_rmda.rmdadocdt,'armt400') 
         RETURNING l_success,l_rmda.rmdadocno
      
      LET l_rmda.rmda001 = l_rmda.rmdadocdt
      LET l_rmda.rmda006 = l_rmda.rmda005
      LET l_rmda.rmda007 = l_rmda.rmda005
      LET l_rmda.rmda008 = l_rmda.rmda005
      LET l_rmda.rmda009 = 'N'
      LET l_rmda.rmda010 = 'N'
      LET l_rmda.rmda019 = '1'
      LET l_rmda.rmdastus = 'N'
      SELECT pmab090,pmab091,pmab092
        INTO l_rmda.rmda012,l_rmda.rmda013,l_rmda.rmda014
        FROM pmab_t
       WHERE pmabent = g_enterprise            
         AND pmabsite = g_site
         AND pmab001 = l_rmda.rmda005
      
      LET l_rmda.rmdaownid = g_user
      LET l_rmda.rmdaowndp = g_dept
      LET l_rmda.rmdacrtid = g_user
      LET l_rmda.rmdacrtdp = g_dept
      LET l_rmda.rmdacrtdt = cl_get_current()
      LET l_rmda.rmdamodid = g_user
      LET l_rmda.rmdamoddt = cl_get_current()
      
      EXECUTE rmda_ins USING g_enterprise,g_site,l_rmda.rmdadocno,l_rmda.rmdadocdt,l_rmda.rmda001,
                             l_rmda.rmda002,l_rmda.rmda003,l_rmda.rmda004,l_rmda.rmda005,l_rmda.rmda006,
                             l_rmda.rmda007,l_rmda.rmda008,l_rmda.rmda009,l_rmda.rmda010,l_rmda.rmda011,
                             l_rmda.rmda012,l_rmda.rmda013,l_rmda.rmda014,l_rmda.rmda015,l_rmda.rmda016,l_rmda.rmda017,
                             l_rmda.rmda018,l_rmda.rmda019,l_rmda.rmdaownid,l_rmda.rmdaowndp,l_rmda.rmdacrtid,
                             l_rmda.rmdacrtdp,l_rmda.rmdacrtdt,l_rmda.rmdamodid,l_rmda.rmdamoddt,l_rmda.rmdastus,
                             l_rmda.rmdacnfid,l_rmda.rmdacnfdt,l_rmda.rmdapstid,l_rmda.rmdapstdt
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ins_rmda" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF  

      UPDATE p300_rmda
         SET rmdadocno = l_rmda.rmdadocno
       WHERE rmda_no = l_rmda.rmda_no 
      IF l_cnt = 1 THEN    
         LET l_stano = l_rmda.rmdadocno
      END IF
      LET l_cnt = l_cnt + 1 
       
      EXECUTE rmdb_ins USING l_rmda.rmdadocno,l_rmda.rmda_no
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ins_rmdb" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF 
      
      EXECUTE rmdc_ins USING l_rmda.rmdadocno,l_rmda.rmda_no
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ins_rmdc" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF 
      LET g_prog = 'armt400'
      CALL s_armt400_conf_chk(l_rmda.rmdadocno) RETURNING l_success
      IF NOT l_success THEN
         LET l_success = FALSE
         EXIT FOREACH
      ELSE
         CALL s_armt400_conf_upd(l_rmda.rmdadocno) RETURNING l_success
         IF NOT l_success THEN
            LET l_success = FALSE
            EXIT FOREACH
         END IF
      END IF
      LET g_prog = 'armp300' 
        
   END FOREACH
   
   IF l_success THEN 
      LET l_sql = "UPDATE rmcb_t a",
                  "   SET a.rmcb010 = a.rmcb010 + (SELECT b.qty FROM p300_rmcb b WHERE a.rmcbdocno = b.rmcbdocno AND a.rmcbseq = b.rmcbseq AND b.sel = 'Y')",
                  " WHERE a.rmcbent = '",g_enterprise,"' AND a.rmcbsite = '",g_site,"'",
                  "   AND EXISTS(SELECT * FROM p300_rmcb b WHERE a.rmcbdocno = b.rmcbdocno AND a.rmcbseq = b.rmcbseq AND b.sel = 'Y')"
      PREPARE upd_rmcb FROM l_sql
      EXECUTE upd_rmcb   
      LET l_sql = "UPDATE rmab_t a",
                  "   SET a.rmab016 = a.rmab016 + (SELECT SUM(b.qty) FROM p300_rmcb b WHERE a.rmabdocno = b.rmcb001 AND a.rmabseq = b.rmcb002 AND b.sel = 'Y')",
                  " WHERE a.rmabent = '",g_enterprise,"' AND a.rmabsite = '",g_site,"'",
                  "   AND EXISTS(SELECT * FROM p300_rmcb b WHERE a.rmabdocno = b.rmcb001 AND a.rmabseq = b.rmcb002 AND b.sel = 'Y')"
      PREPARE upd_rmab FROM l_sql
      EXECUTE upd_rmab       
   END IF   
   CALL cl_err_collect_show()
   IF l_success THEN
      #160816-00066#5 add-S
      LET l_endno = l_rmda.rmdadocno
      #160816-00066#5 add-E
      CALL s_transaction_end('Y','0')
      #160816-00066#5 add-S         #成功产生覆出单，单据范围：%1，是否开启单据进行查看？
      IF l_stano <> l_endno THEN
         LET l_str = l_stano CLIPPED,'~',l_endno CLIPPED
      ELSE 
         LET l_str = l_stano CLIPPED
      END IF
      IF cl_ask_confirm_parm('arm-00069',l_str) THEN
         IF l_stano <> l_endno THEN
            LET l_str = " (rmdadocno BETWEEN '",l_stano CLIPPED,"' AND '",l_endno CLIPPED,"' )"
         ELSE 
            LET l_str = " rmdadocno = '",l_stano CLIPPED,"' "
         END IF        
         LET la_param.prog = 'armt400' #
         LET la_param.param[2] = l_str
         LET ls_js = util.JSON.stringify(la_param)
         CALL cl_cmdrun(ls_js)
      END IF
      #160816-00066#4 add-E
   ELSE
      CALL s_transaction_end('N','0')
   END IF
END FUNCTION

PRIVATE FUNCTION armp300_b_fill2()
DEFINE l_sql STRING 
DEFINE l_cnt LIKE type_t.num10

   CALL g_detail2_d.clear()
   CALL g_detail3_d.clear()
   LET l_cnt = 1
   LET l_sql = "SELECT rmdadocno,rmdadocdt,rmda002,rmda003,rmda005,rmda_no ",
               "  FROM p300_rmda "
   PREPARE armp300_rmda_pre FROM l_sql
   DECLARE armp300_rmda_cur CURSOR FOR armp300_rmda_pre
   FOREACH armp300_rmda_cur INTO g_detail2_d[l_cnt].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_cnt = l_cnt + 1
      IF l_cnt > g_max_rec THEN
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
   CALL g_detail2_d.deleteElement(g_detail2_d.getLength())
END FUNCTION

PRIVATE FUNCTION armp300_b_fill3()
DEFINE l_sql STRING 
DEFINE l_cnt LIKE type_t.num10

   IF cl_null(g_detail_idx) OR g_detail_idx = 0 THEN 
      RETURN
   END IF

   CALL g_detail3_d.clear()
   LET l_cnt = 1
   LET l_sql = " SELECT rmdbseq,rmdb001,rmdb002,rmdb003,rmdb004,",
               #161129-00054#1 mod-S
#               "        rmdb005,rmdb006,rmdb007,rmdb008,rmdb009,",
               "        rmdb005,rmdb006,rmdb007,",
               "        (SELECT inayl003 FROM inayl_t WHERE inayl001 = rmdb007 AND inayl002 = '",g_dlang,"' AND inaylent = ",g_enterprise,") inayl003, ",
               "        rmdb008,",
               "        (SELECT inab003 FROM inab_t WHERE inab001 = rmdb007 AND inab002 = rmdb008 AND inabsite = '",g_site,"' AND inabent = ",g_enterprise,") inab003, ",
               "        rmdb009,",
               #161129-00054#1 mod-S
               "        rmdb010,rmdb_no",
               "   FROM p300_rmdb ",
               "  WHERE rmdb_no = ",g_detail2_d[g_detail_idx].rmda_no
   PREPARE armp300_rmdb_pre FROM l_sql
   DECLARE armp300_rmdb_cur CURSOR FOR armp300_rmdb_pre
   FOREACH armp300_rmdb_cur INTO g_detail3_d[l_cnt].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_cnt = l_cnt + 1
      IF l_cnt > g_max_rec THEN
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
   CALL g_detail3_d.deleteElement(g_detail3_d.getLength())
END FUNCTION

PRIVATE FUNCTION armp300_upd_rmda()
   IF cl_null(l_ac2) OR l_ac2 = 0 THEN RETURN END IF 
  
   UPDATE p300_rmda
      SET rmdadocno = g_detail2_d[l_ac2].rmdadocno
    WHERE rmda_no = g_detail2_d[l_ac2].rmda_no 
END FUNCTION

PRIVATE FUNCTION armp300_upd_rmdb()
   IF cl_null(l_ac3) OR l_ac3 = 0 THEN RETURN END IF 
  
   UPDATE p300_rmdb
      SET rmdb007 = g_detail3_d[l_ac3].rmdb007,
          rmdb008 = g_detail3_d[l_ac3].rmdb008
    WHERE rmdb_no = g_detail3_d[l_ac3].rmdb_no 
      AND rmdbseq = g_detail3_d[l_ac3].rmdbseq
END FUNCTION

PRIVATE FUNCTION armp300_display()
DEFINE l_type       LIKE type_t.chr1
DEFINE l_inaa007    LIKE inaa_t.inaa007
DEFINE l_ooef004    LIKE ooef_t.ooef004
DEFINE l_n          LIKE type_t.num5
DEFINE l_ooba015    LIKE ooba_t.ooba015
DEFINE l_ooba002    LIKE ooba_t.ooba002
DEFINE l_acc        LIKE gzcb_t.gzcb007
DEFINE l_acc2       LIKE gzcb_t.gzcb007
DEFINE l_flag       LIKE type_t.chr1
DEFINE l_success    LIKE type_t.num5   
DEFINE l_sql1          STRING            #160711-00040#28 add

   IF g_detail2_d.getlength() > 0 THEN 
      LET g_detail_idx = 1              
      CALL armp300_b_fill3() 
   END IF 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      DISPLAY ARRAY g_detail2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)
         BEFORE DISPLAY 
            LET l_ac2 = g_curr_diag.getCurrentRow("s_detail2")
            LET g_detail_idx = l_ac2              
            CALL armp300_b_fill3() 
            
         BEFORE ROW
            LET l_ac2 = DIALOG.getCurrentRow("s_detail2")
            LET g_detail_idx = l_ac2
            CALL armp300_b_fill3()        
          
      END DISPLAY
      DISPLAY ARRAY g_detail3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)
         
      END DISPLAY      
      CONSTRUCT BY NAME g_master.wc ON rmcadocno,rmcadocdt,rmca003,rmca004,rmcb001
         BEFORE CONSTRUCT
                   
         ON ACTION controlp INFIELD rmcadocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " rmcastus = 'Y' AND EXISTS (SELECT 1 FROM rmcb_t WHERE rmcbdocno = rmcadocno AND rmcbent = ",g_enterprise," AND rmcbsite = '",g_site,"' AND rmcb009 = '3'  AND rmcb007-rmcb010 > 0 ) "
            CALL q_rmcadocno()                       
            DISPLAY g_qryparam.return1 TO rmcadocno  
            NEXT FIELD rmcadocno                     
       
         ON ACTION controlp INFIELD rmca003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                       
            DISPLAY g_qryparam.return1 TO rmca003  
            NEXT FIELD rmca003                     
            
         ON ACTION controlp INFIELD rmca004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                    
            DISPLAY g_qryparam.return1 TO rmca004 
            NEXT FIELD rmca004                    
       
         ON ACTION controlp INFIELD rmcb001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rmaadocno()                       
            DISPLAY g_qryparam.return1 TO rmcb001  
            NEXT FIELD rmcb001
      END CONSTRUCT
      #end add-point
      #add-point:ui_dialog段input
      INPUT BY NAME g_master.rmdadocno,g_master.rmdadocdt
         ATTRIBUTE(WITHOUT DEFAULTS)        
       
         AFTER FIELD rmdadocno
            IF NOT cl_null(g_master.rmdadocno) THEN 
               IF NOT s_aooi200_chk_slip(g_site,'',g_master.rmdadocno,'armt400') THEN
                  LET g_master.rmdadocno = ''
                  NEXT FIELD CURRENT
               END IF   
            END IF
       
       
         ON ACTION controlp INFIELD rmdadocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.rmdadocno
            LET g_qryparam.arg1 = g_ooef.ooef004
            LET g_qryparam.arg2 = 'armt400'
            #160711-00040#28 add(s)
            CALL s_control_get_docno_sql(g_user,g_dept)
                RETURNING l_success,l_sql1
            IF NOT cl_null(l_sql1) THEN
               LET g_qryparam.where = l_sql1
            END IF
            #160711-00040#28 add(e)
            CALL q_ooba002_1()                              
            LET g_master.rmdadocno = g_qryparam.return1              
            NEXT FIELD rmdadocno
                    
      END INPUT     
         
      ON ACTION close 
         LET g_action_choice="exit"      
         EXIT DIALOG
      
      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DIALOG

      ON ACTION accept
         CALL armp300_query()
         EXIT DIALOG
         
      #主選單用ACTION
      &include "main_menu_exit_dialog.4gl"
      &include "relating_action.4gl"
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG         
   END DIALOG            
END FUNCTION

#end add-point
 
{</section>}
 
