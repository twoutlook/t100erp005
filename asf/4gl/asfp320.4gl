#該程式未解開Section, 採用最新樣板產出!
{<section id="asfp320.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-09-08 18:50:47), PR版次:0002(2016-12-30 16:41:44)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000008
#+ Filename...: asfp320
#+ Description: 模具領料分配作業
#+ Creator....: 01534(2016-09-01 17:05:35)
#+ Modifier...: 01534 -SD/PR- 08992
 
{</section>}
 
{<section id="asfp320.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161109-00085#40 2016/11/17 By lienjunqi    整批調整系統星號寫法
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
      sel             LIKE type_t.chr1,
      seq1            LIKE sfdc_t.sfdcseq,
      sfdcdocno       LIKE sfdc_t.sfdcdocno,
      sfdcseq         LIKE sfdc_t.sfdcseq,
      sfdc004         LIKE sfdc_t.sfdc004,      
      sfdc004_desc    LIKE type_t.chr500,
      sfdc004_desc_1  LIKE type_t.chr500,
      sfdc005         LIKE sfdc_t.sfdc005,
      sfdc005_desc    LIKE type_t.chr500,
      sfdc006         LIKE sfdc_t.sfdc006,
      sfdc006_desc    LIKE type_t.chr500,
      sfdc007         LIKE sfdc_t.sfdc007,
      sfdc008         LIKE sfdc_t.sfdc008,
      allot           LIKE sfdc_t.sfdc008,
      sfdc009         LIKE sfdc_t.sfdc009,
      sfdc009_desc    LIKE type_t.chr500, 
      sfdc010         LIKE sfdc_t.sfdc010,
      sfdc011         LIKE sfdc_t.sfdc011,
      ck_allot        LIKE sfdc_t.sfdc011,
      sfdc012         LIKE sfdc_t.sfdc012,
      sfdc012_desc    LIKE type_t.chr500,       
      sfdc013         LIKE sfdc_t.sfdc013,
      sfdc013_desc    LIKE type_t.chr500, 
      sfdc014         LIKE sfdc_t.sfdc014,
      sfdc015         LIKE sfdc_t.sfdc015,
      sfdc015_desc    LIKE type_t.chr500, 
      sfdc016         LIKE sfdc_t.sfdc016     
                     END RECORD

TYPE type_g_sfaa_d  RECORD 
      sel02                  LIKE type_t.chr1,
      sfaadocno              LIKE sfaa_t.sfaadocno,
      sfaa021                LIKE sfaa_t.sfaa021,
      sfaa025                LIKE sfaa_t.sfaa025,
      sfaa010                LIKE sfaa_t.sfaa010,
      sfaa010_desc           LIKE type_t.chr500, 
      sfaa010_desc_1         LIKE type_t.chr500, 
      sfaa012                LIKE sfaa_t.sfaa012,
      sfaa049                LIKE sfaa_t.sfaa049,
      sfdd006_2              LIKE sfdd_t.sfdd006,
      sfdd006_2_desc         LIKE type_t.chr500
                    END RECORD 
                    
TYPE type_g_sfdd_d  RECORD 
      sel                    LIKE type_t.chr1,
      lockd                  LIKE type_t.chr1,
      rowno                  LIKE sfdd_t.sfddseq,
      sfdddocno              LIKE sfdd_t.sfdddocno,
      sfddseq                LIKE sfdd_t.sfddseq,
      sfddseq1               LIKE sfdd_t.sfddseq1,
      sfaadocno              LIKE sfaa_t.sfaadocno,
      sfaa010                LIKE sfaa_t.sfaa010,
      sfdd001                LIKE sfdd_t.sfdd001,
      sfdd001_desc           LIKE type_t.chr500, 
      sfdd001_desc_1         LIKE type_t.chr500, 
      sfdd013                LIKE sfdd_t.sfdd013,
      sfdd013_desc           LIKE type_t.chr500,
      sfdd006                LIKE sfdd_t.sfdd006,
      sfdd006_desc           LIKE type_t.chr500, 
      sfba023                LIKE sfba_t.sfba023,
      sfba016                LIKE sfba_t.sfba016,
      nosend                 LIKE sfba_t.sfba016,
      sfdd007                LIKE sfdd_t.sfdd007,
      sfdd008                LIKE sfdd_t.sfdd008,
      sfdd008_desc           LIKE type_t.chr500,
      sfdd009                LIKE sfdd_t.sfdd009,
      sfdd003                LIKE sfdd_t.sfdd003,
      sfdd003_desc           LIKE type_t.chr500,
      sfdd004                LIKE sfdd_t.sfdd004,
      sfdd004_desc           LIKE type_t.chr500,
      sfdd005                LIKE sfdd_t.sfdd005,
      sfdd010                LIKE sfdd_t.sfdd010,
      sfba009                LIKE sfba_t.sfba009
                    END RECORD 
                    
TYPE type_g_inao_d RECORD  
      inaodocno       LIKE inao_t.inaoseq,
      inaoseq         LIKE inao_t.inaoseq,
      inaoseq1        LIKE inao_t.inaoseq1,
      inaoseq2        LIKE inao_t.inaoseq2,
      inao001         LIKE inao_t.inao001,
      inao001_desc         LIKE type_t.chr500, 
      inao001_desc_1       LIKE type_t.chr500, 
      inao008         LIKE inao_t.inao008,
      inao009         LIKE inao_t.inao009,
      inao010         LIKE inao_t.inao010,
      inao012         LIKE inao_t.inao012
                   END RECORD
                   
TYPE type_g_inao_d2 RECORD  
      l_inaodocno            LIKE inao_t.inaoseq,
      l_inaoseq              LIKE inao_t.inaoseq,
      l_inaoseq1             LIKE inao_t.inaoseq1,
      l_inaoseq2             LIKE inao_t.inaoseq2,
      l_inao001              LIKE inao_t.inao001,
      l_inao001_desc         LIKE type_t.chr500, 
      l_inao001_desc_1       LIKE type_t.chr500, 
      l_inao008              LIKE inao_t.inao008,
      l_inao009              LIKE inao_t.inao009,
      l_inao010              LIKE inao_t.inao010,
      l_inao012              LIKE inao_t.inao012
                    END RECORD                   
                   
#DEFINE  g_sfdadocno          LIKE sfda_t.sfdadocno
#DEFINE  g_sfdadocno_2        LIKE sfda_t.sfdadocno
DEFINE  g_sfdadocno          LIKE sfba_t.sfba002
DEFINE  g_sfdadocno_2        LIKE sfba_t.sfba002
DEFINE  g_sfdadocno_key      LIKE sfda_t.sfdadocno
DEFINE  g_detail_cnt2        LIKE type_t.num10
DEFINE  g_detail_cnt3        LIKE type_t.num10  
DEFINE  l_ac2                LIKE type_t.num10   
DEFINE  l_ac3                LIKE type_t.num10   
DEFINE  g_sfaa_d      DYNAMIC ARRAY OF type_g_sfaa_d
DEFINE  g_sfdd_d      DYNAMIC ARRAY OF type_g_sfdd_d
DEFINE  g_inao_d      DYNAMIC ARRAY OF type_g_inao_d
DEFINE  g_inao_d2     DYNAMIC ARRAY OF type_g_inao_d2
DEFINE  g_detail_d_t  type_g_detail_d
DEFINE  g_sfaa_d_t    type_g_sfaa_d
DEFINE  g_sfdd_d_t    type_g_sfdd_d
DEFINE  l_allow_insert  LIKE type_t.num5                #可新增否
DEFINE  l_allow_delete  LIKE type_t.num5                #可刪除否
DEFINE  l_ac_t                LIKE type_t.num10
DEFINE  l_insert              BOOLEAN  
DEFINE  g_detail_idx          LIKE type_t.num10
DEFINE  g_detail_idx2         LIKE type_t.num10
DEFINE  g_detail_idx3         LIKE type_t.num10
DEFINE  g_para                LIKE type_t.chr80 
DEFINE  g_flag                LIKE type_t.chr1
DEFINE  g_cnt2                LIKE type_t.num10 
DEFINE  g_cnt3                LIKE type_t.num10 
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="asfp320.main" >}
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
   CALL cl_ap_init("asf","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_asfp320 WITH FORM cl_ap_formpath("asf",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL asfp320_init()   
 
      #進入選單 Menu (="N")
      CALL asfp320_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_asfp320
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   CALL asfp320_drop_tmp()
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="asfp320.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION asfp320_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   DEFINE  l_success   LIKE type_t.num5
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_comp_visible("page_1,page_4",FALSE)
   #參考單位
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'N' THEN   
      CALL cl_set_comp_visible("b_sfdc009,b_sfdc009_desc,b_sfdc010,b_sfdc011,ck_allot,b_sfdd008,b_sfdd008_desc,b_sfdd009",FALSE)   
   END IF
   #產品特徵   
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN   
      CALL cl_set_comp_visible("b_sfdc005,b_sfdc005_desc,b_sfdd013_desc,b_sfdd013",FALSE)
   END IF   
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   #创建临时表，创建失败离开作业
   CALL asfp320_create_tmp() RETURNING l_success
   IF NOT l_success THEN
      CLOSE WINDOW w_asfp320
      CALL cl_ap_exitprogram("0")
   END IF   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="asfp320.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfp320_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_ooef004       LIKE ooef_t.ooef004
   DEFINE l_flag2         LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_sfdc008       LIKE sfdc_t.sfdc008
   DEFINE l_n_sfdc008     LIKE type_t.num20
   DEFINE l_imae082       LIKE imae_t.imae082
   DEFINE l_imae083       LIKE imae_t.imae083
   DEFINE l_imae084       LIKE imae_t.imae084
   DEFINE l_msg           STRING
   DEFINE l_cmd           LIKE type_t.chr1
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_cnt2          LIKE type_t.num5
   DEFINE l_flag          LIKE type_t.chr1
   DEFINE s_sfdd007       LIKE sfdd_t.sfdd007
   DEFINE l_sfdc_new      type_g_detail_d
   DEFINE l_sel_new       LIKE type_t.chr1
   DEFINE l_lockd_new     LIKE type_t.chr1
   DEFINE l_sfdd007_new   LIKE sfdd_t.sfdd007
   DEFINE l_sfdd009_new   LIKE sfdd_t.sfdd009
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL asfp320_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc ON imaf001
            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD imaf001 
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaf001_6()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaf001  #顯示到畫面上
               NEXT FIELD imaf001                     #返回原欄位  
               
         END CONSTRUCT
         
         CONSTRUCT BY NAME g_wc2 ON sfaadocno,sfaa010
         
            BEFORE CONSTRUCT
               LET g_wc2 = ''   
               
            ON ACTION controlp INFIELD sfaadocno 
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_sfaadocno_16()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO sfaadocno  #顯示到畫面上
               NEXT FIELD sfaadocno                     #返回原欄位    

            ON ACTION controlp INFIELD sfaa010 
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaf001_6()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO sfaa010  #顯示到畫面上
               NEXT FIELD sfaa010                     #返回原欄位  
               
         END CONSTRUCT         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT g_sfdadocno,g_sfdadocno_2 FROM sfdadocno,sfdadocno_2
         
            BEFORE INPUT
               #DISPLAY g_sfdadocno,g_sfdadocno_2 TO sfdadocno,sfdadocno_2
               LET l_cnt = 0
               SELECT COUNT(1) INTO l_cnt FROM asfp320_sfdd_tmp
                WHERE sel = 'Y'
               IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
               IF l_cnt > 0 THEN
                  CALL cl_set_comp_required("sfdadocno,sfdadocno_2",TRUE)
               ELSE
                  CALL cl_set_comp_required("sfdadocno,sfdadocno_2",FALSE)               
               END IF  
               
            AFTER FIELD sfdadocno
               IF NOT cl_null(g_sfdadocno) THEN
                  CALL s_aooi200_chk_slip(g_site,'',g_sfdadocno,'asft311')
                     RETURNING l_success
                  IF NOT l_success THEN
                     NEXT FIELD CURRENT
                  END IF
                  
                  #檢核輸入的單據別是否可以被key人員對應的控制組使用,'6' 為生管控制組類型
                  CALL s_control_chk_doc('1',g_sfdadocno,'6',g_user,g_dept,'','')
                       RETURNING l_success,l_flag2
                  IF l_success THEN
                     IF NOT l_flag2 THEN
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     NEXT FIELD CURRENT
                  END IF
               END IF            
            
            
            AFTER FIELD sfdadocno_2
            
               IF NOT cl_null(g_sfdadocno_2) THEN
                  CALL s_aooi200_chk_slip(g_site,'',g_sfdadocno_2,'asft314')
                     RETURNING l_success
                  IF NOT l_success THEN
                     NEXT FIELD CURRENT
                  END IF
                  
                  #檢核輸入的單據別是否可以被key人員對應的控制組使用,'6' 為生管控制組類型
                  CALL s_control_chk_doc('1',g_sfdadocno_2,'6',g_user,g_dept,'','')
                       RETURNING l_success,l_flag2
                  IF l_success THEN
                     IF NOT l_flag2 THEN
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     NEXT FIELD CURRENT
                  END IF
               END IF    


            
            ON ACTION controlp INFIELD sfdadocno
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL  
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_sfdadocno             #給予default值
               #給予arg
               SELECT ooef004 INTO l_ooef004
                 FROM ooef_t
                WHERE ooef001 = g_site
                  AND ooefent  = g_enterprise
               LET g_qryparam.arg1 = l_ooef004 #參照表編號
               LET g_qryparam.arg2 = 'asft311'    #作业代号
               CALL q_ooba002_1()                                #呼叫開窗
               LET g_sfdadocno = g_qryparam.return1              #將開窗取得的值回傳到變數
               DISPLAY g_sfdadocno  TO sfdadocno              #顯示到畫面上
               NEXT FIELD sfdadocno                          #返回原欄位

            ON ACTION controlp INFIELD sfdadocno_2
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_sfdadocno_2            #給予default值
               #給予arg
               SELECT ooef004 INTO l_ooef004
                 FROM ooef_t
                WHERE ooef001 = g_site
                  AND ooefent  = g_enterprise
               LET g_qryparam.arg1 = l_ooef004 #參照表編號
               LET g_qryparam.arg2 = 'asft314'    #作业代号
               CALL q_ooba002_1()                                #呼叫開窗
               LET g_sfdadocno_2 = g_qryparam.return1              #將開窗取得的值回傳到變數
               DISPLAY g_sfdadocno_2  TO sfdadocno_2              #顯示到畫面上
               NEXT FIELD sfdadocno_2                          #返回原欄位
               
         END INPUT
         
         
         
         INPUT ARRAY g_detail_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         
            BEFORE INPUT
               #CALL asfp320_b_fill()
               LET g_detail_cnt = g_detail_d.getLength()
               IF g_detail_d.getLength() > 0 THEN
                  CALL gfrm_curr.setFieldHidden("formonly.sel01", TRUE)
                  CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
               ELSE
                  CALL gfrm_curr.setFieldHidden("formonly.sel01", FALSE)
                  CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
               END IF   
               CALL cl_set_comp_visible("sel01",TRUE)  
               
            BEFORE ROW
               LET l_cmd = ''
               LET l_ac = ARR_CURR() 
               LET l_ac = DIALOG.getCurrentRow("s_detail1")                
               LET g_detail_idx = l_ac                
               LET g_detail_cnt = g_detail_d.getLength()
               IF g_detail_cnt >= l_ac AND g_detail_d[l_ac].sfdc004 IS NOT NULL THEN
                  LET l_cmd='u'
                  LET g_detail_d_t.* = g_detail_d[l_ac].*  #BACKUP
               ELSE
                  LET l_cmd='a'
                  INITIALIZE g_detail_d_t.* TO NULL                         
               END IF               
               CALL asfp320_set_entry_sfdc()  
               CALL asfp320_set_no_required()
               CALL asfp320_set_required()
               CALL asfp320_set_no_entry_sfdc()
               #CALL s_transaction_begin()
               
            BEFORE INSERT            
#               IF s_transaction_chk("N",0) THEN
#                  CALL s_transaction_begin()
#               END IF  
               SELECT MAX(seq1)+1 INTO g_detail_d[l_ac].seq1 FROM asfp320_sfdc_tmp
               IF cl_null(g_detail_d[l_ac].seq1) THEN LET g_detail_d[l_ac].seq1 = 1 END IF
               LET l_cmd = 'a'
               INITIALIZE g_detail_d[l_ac].* TO NULL
               LET g_detail_d[l_ac].allot = 0
               LET g_detail_d_t.* = g_detail_d[l_ac].*     #新輸入資料
               CALL cl_show_fld_cont()
               LET g_detail_d[l_ac].sel = 'N'   
               CALL asfp320_set_entry_sfdc()  
               CALL asfp320_set_no_required()
               CALL asfp320_set_required()
               CALL asfp320_set_no_entry_sfdc()

            AFTER INSERT
            #资料写入临时表            
               LET l_insert = FALSE
               IF INT_FLAG THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = 9001 
                  LET g_errparam.popup  = FALSE 
                  CALL cl_err()
                  LET INT_FLAG = 0
                  CANCEL INSERT
               END IF            
               LET l_count = 1
               IF cl_null(g_detail_d[l_ac].sfdc005) THEN
                  LET g_detail_d[l_ac].sfdc005 = ' '
               END IF
               SELECT COUNT(1) INTO l_count FROM asfp320_sfdc_tmp
                WHERE sfdc004 = g_detail_d[l_ac].sfdc004
                  AND sfdc005 = g_detail_d[l_ac].sfdc005
                  AND sfdc012 = g_detail_d[l_ac].sfdc012
               #資料未重複, 插入新增資料
               IF l_count = 0 THEN                
                  INSERT INTO asfp320_sfdc_tmp (sel,seq1,sfdcdocno,sfdcseq,sfdc004,sfdc004_desc,sfdc004_desc_1,                 
                                                sfdc005,sfdc005_desc,sfdc006,sfdc006_desc,sfdc007,sfdc008,  
                                                allot,sfdc009,sfdc009_desc,sfdc010,sfdc011,ck_allot,sfdc012,sfdc012_desc, 
                                                sfdc013,sfdc013_desc,sfdc014,sfdc015,sfdc015_desc,sfdc016)
                                        VALUES (g_detail_d[l_ac].sel,g_detail_d[l_ac].seq1,g_detail_d[l_ac].sfdcdocno,g_detail_d[l_ac].sfdcseq,g_detail_d[l_ac].sfdc004,g_detail_d[l_ac].sfdc004_desc,g_detail_d[l_ac].sfdc004_desc_1,                 
                                                g_detail_d[l_ac].sfdc005,g_detail_d[l_ac].sfdc005_desc,g_detail_d[l_ac].sfdc006,g_detail_d[l_ac].sfdc006_desc,g_detail_d[l_ac].sfdc007,g_detail_d[l_ac].sfdc008,  
                                                g_detail_d[l_ac].allot,g_detail_d[l_ac].sfdc009,g_detail_d[l_ac].sfdc009_desc,g_detail_d[l_ac].sfdc010,g_detail_d[l_ac].sfdc011,g_detail_d[l_ac].ck_allot,g_detail_d[l_ac].sfdc012,g_detail_d[l_ac].sfdc012_desc, 
                                                g_detail_d[l_ac].sfdc013,g_detail_d[l_ac].sfdc013_desc,g_detail_d[l_ac].sfdc014,g_detail_d[l_ac].sfdc015,g_detail_d[l_ac].sfdc015_desc,g_detail_d[l_ac].sfdc016) 
                  IF SQLCA.SQLcode  THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "ins asfp320_sfdc_tmp"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     INITIALIZE g_detail_d[l_ac].* TO NULL
                     #CALL s_transaction_end('N','0')
                     CANCEL INSERT
                  ELSE
                     #CALL s_transaction_end('Y','0')
                     LET g_detail_cnt = g_detail_cnt + 1                     
                  END IF   
               ELSE
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'INSERT' 
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  INITIALIZE g_detail_d[l_ac].* TO NULL
                  #CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL INSERT               
               END IF
               
               
            BEFORE DELETE
            
               IF l_cmd = 'a' THEN
                  CALL FGL_SET_ARR_CURR(l_ac - 1)
                  CALL g_detail_d.deleteElement(l_ac)
                  NEXT FIELD sfdc004
               END IF

               IF g_detail_d[l_ac].sfdc004 IS NOT NULL THEN
                  IF NOT cl_ask_del_detail() THEN
                     CANCEL DELETE
                  END IF
               
                  DELETE FROM asfp320_sfdc_tmp
                   WHERE sfdc004 = g_detail_d_t.sfdc004
                     AND sfdc005 = g_detail_d_t.sfdc005
                     AND sfdc012 = g_detail_d_t.sfdc012
                     
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "del asfp320_sfdc_tmp"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #CALL s_transaction_end('N','0') 
                     CANCEL DELETE
                  ELSE
                     #CALL s_transaction_end('Y','0')
                     LET g_detail_cnt = g_detail_cnt - 1
                  END IF
               END IF            
            
            
            AFTER DELETE
            
               #如果是最後一筆
               IF l_ac = (g_detail_d.getLength() + 1) THEN
                  CALL FGL_SET_ARR_CURR(l_ac-1)
               END IF
               
            ON CHANGE sel01
               IF l_ac > 0 THEN
                  UPDATE asfp320_sfdc_tmp SET sel = g_detail_d[l_ac].sel
                   WHERE seq1 = g_detail_d[l_ac].seq1
                  CALL asfp320_set_entry_sfdc()  
                  CALL asfp320_set_no_required()
                  CALL asfp320_set_required()
                  CALL asfp320_set_no_entry_sfdc()
               ELSE
                  CALL cl_set_comp_required("b_sfdc004,b_sfdc012,b_sfdc005,b_sfdc016,b_sfdc007,b_sfdc008,sfdadocno,sfdadocno_2",FALSE)                 
               END IF
               
            AFTER FIELD b_sfdc004
               IF l_ac > 0 THEN
               CALL s_desc_get_item_desc(g_detail_d[l_ac].sfdc004) 
                    RETURNING g_detail_d[l_ac].sfdc004_desc,g_detail_d[l_ac].sfdc004_desc_1            
               IF NOT cl_null(g_detail_d[l_ac].sfdc004) THEN
                  IF g_detail_d[l_ac].sfdc004 <> g_detail_d_t.sfdc004 OR g_detail_d_t.sfdc004 IS NULL THEN  
                     IF NOT asfp320_key_chk(g_detail_d[l_ac].sfdc004,g_detail_d[l_ac].sfdc005,g_detail_d[l_ac].sfdc012) THEN
                        NEXT FIELD b_sfdc004
                     END IF                     
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_detail_d[l_ac].sfdc004
                     IF NOT cl_chk_exist("v_imaf001_4") THEN
                        LET g_detail_d[l_ac].sfdc004 = g_detail_d_t.sfdc004
                        CALL s_desc_get_item_desc(g_detail_d[l_ac].sfdc004) 
                             RETURNING g_detail_d[l_ac].sfdc004_desc,g_detail_d[l_ac].sfdc004_desc_1
                        NEXT FIELD CURRENT
                     END IF
                     CALL asfp320_default_sfdc()
                     
                     UPDATE asfp320_sfdc_tmp SET (seq1,sfdcdocno,sfdcseq,sfdc004,sfdc004_desc,sfdc004_desc_1,                 
                                                  sfdc005,sfdc005_desc,sfdc006,sfdc006_desc,sfdc007,sfdc008,  
                                                  allot,sfdc009,sfdc009_desc,sfdc010,sfdc011,ck_allot,sfdc012,sfdc012_desc, 
                                                  sfdc013,sfdc013_desc,sfdc014,sfdc015,sfdc015_desc,sfdc016)
                                               = (g_detail_d[l_ac].seq1,g_detail_d[l_ac].sfdcdocno,g_detail_d[l_ac].sfdcseq,g_detail_d[l_ac].sfdc004,g_detail_d[l_ac].sfdc004_desc,g_detail_d[l_ac].sfdc004_desc_1,                 
                                                  g_detail_d[l_ac].sfdc005,g_detail_d[l_ac].sfdc005_desc,g_detail_d[l_ac].sfdc006,g_detail_d[l_ac].sfdc006_desc,g_detail_d[l_ac].sfdc007,g_detail_d[l_ac].sfdc008,  
                                                  g_detail_d[l_ac].allot,g_detail_d[l_ac].sfdc009,g_detail_d[l_ac].sfdc009_desc,g_detail_d[l_ac].sfdc010,g_detail_d[l_ac].sfdc011,g_detail_d[l_ac].ck_allot,g_detail_d[l_ac].sfdc012,g_detail_d[l_ac].sfdc012_desc, 
                                                  g_detail_d[l_ac].sfdc013,g_detail_d[l_ac].sfdc013_desc,g_detail_d[l_ac].sfdc014,g_detail_d[l_ac].sfdc015,g_detail_d[l_ac].sfdc015_desc,g_detail_d[l_ac].sfdc016)       
                       WHERE seq1 = g_detail_d[l_ac].seq1 
                 
                  END IF   
               END IF
               CALL s_desc_get_item_desc(g_detail_d[l_ac].sfdc004) 
                    RETURNING g_detail_d[l_ac].sfdc004_desc,g_detail_d[l_ac].sfdc004_desc_1               
               CALL asfp320_set_entry_sfdc()  
               CALL asfp320_set_no_required()
               CALL asfp320_set_required()
               CALL asfp320_set_no_entry_sfdc()
               LET g_detail_d_t.sfdc004 = g_detail_d[l_ac].sfdc004               
               END IF

            AFTER FIELD b_sfdc005
               IF l_ac > 0 THEN
               CALL s_feature_description(g_detail_d[l_ac].sfdc004,g_detail_d[l_ac].sfdc005)
                    RETURNING r_success,g_detail_d[l_ac].sfdc005_desc 
                    
               IF NOT cl_null(g_detail_d[l_ac].sfdc005) THEN    
                  IF g_detail_d[l_ac].sfdc005 <> g_detail_d_t.sfdc005 OR g_detail_d_t.sfdc005 IS NULL THEN  
                     IF NOT asfp320_key_chk(g_detail_d[l_ac].sfdc004,g_detail_d[l_ac].sfdc005,g_detail_d[l_ac].sfdc012) THEN
                        NEXT FIELD b_sfdc005
                     END IF               
                     IF NOT s_feature_check(g_detail_d[l_ac].sfdc004,g_detail_d[l_ac].sfdc005) THEN  
                        LET g_detail_d[l_ac].sfdc005 = g_detail_d_t.sfdc005
                        CALL s_feature_description(g_detail_d[l_ac].sfdc004,g_detail_d[l_ac].sfdc005)
                             RETURNING r_success,g_detail_d[l_ac].sfdc005_desc             
                        NEXT FIELD CURRENT            
                     END IF 
                   UPDATE asfp320_sfdc_tmp SET (seq1,sfdcdocno,sfdcseq,sfdc004,sfdc004_desc,sfdc004_desc_1,                 
                                                sfdc005,sfdc005_desc,sfdc006,sfdc006_desc,sfdc007,sfdc008,  
                                                allot,sfdc009,sfdc009_desc,sfdc010,sfdc011,ck_allot,sfdc012,sfdc012_desc, 
                                                sfdc013,sfdc013_desc,sfdc014,sfdc015,sfdc015_desc,sfdc016)
                                             = (g_detail_d[l_ac].seq1,g_detail_d[l_ac].sfdcdocno,g_detail_d[l_ac].sfdcseq,g_detail_d[l_ac].sfdc004,g_detail_d[l_ac].sfdc004_desc,g_detail_d[l_ac].sfdc004_desc_1,                 
                                                g_detail_d[l_ac].sfdc005,g_detail_d[l_ac].sfdc005_desc,g_detail_d[l_ac].sfdc006,g_detail_d[l_ac].sfdc006_desc,g_detail_d[l_ac].sfdc007,g_detail_d[l_ac].sfdc008,  
                                                g_detail_d[l_ac].allot,g_detail_d[l_ac].sfdc009,g_detail_d[l_ac].sfdc009_desc,g_detail_d[l_ac].sfdc010,g_detail_d[l_ac].sfdc011,g_detail_d[l_ac].ck_allot,g_detail_d[l_ac].sfdc012,g_detail_d[l_ac].sfdc012_desc, 
                                                g_detail_d[l_ac].sfdc013,g_detail_d[l_ac].sfdc013_desc,g_detail_d[l_ac].sfdc014,g_detail_d[l_ac].sfdc015,g_detail_d[l_ac].sfdc015_desc,g_detail_d[l_ac].sfdc016)       
                     WHERE seq1 = g_detail_d[l_ac].seq1                        
                  END IF                  
               END IF
               LET g_detail_d_t.sfdc005 = g_detail_d[l_ac].sfdc005
               CALL s_feature_description(g_detail_d[l_ac].sfdc004,g_detail_d[l_ac].sfdc005)
                    RETURNING r_success,g_detail_d[l_ac].sfdc005_desc 
               END IF
               
            BEFORE FIELD b_sfdc007
               CALL DIALOG.setFieldTouched("s_detail1.b_sfdc007",TRUE)
            
            AFTER FIELD b_sfdc007  #申請數量  
            #ON CHANGE b_sfdc007  #申請數量             
               #確認欄位值在特定區間內
               IF l_ac > 0 THEN
               IF NOT cl_ap_chk_range(g_detail_d[l_ac].sfdc007,"0","0","","","azz-00079",1) THEN
                  NEXT FIELD b_sfdc007
               END IF       
               IF NOT cl_null(g_detail_d[l_ac].sfdc007) THEN               
                  IF g_detail_d_t.sfdc007 <> g_detail_d[l_ac].sfdc007 OR cl_null(g_detail_d_t.sfdc007) THEN 
                  
                     #單位換算
                     IF NOT cl_null(g_detail_d[l_ac].sfdc009) THEN
                        CALL s_aooi250_convert_qty(g_detail_d[l_ac].sfdc004,g_detail_d[l_ac].sfdc006,
                                                   g_detail_d[l_ac].sfdc009,g_detail_d[l_ac].sfdc007) 
                             RETURNING l_success,g_detail_d[l_ac].sfdc010    
                     END IF     
                     #依发料料号发料控管方式控制
                     LET l_sfdc008 = g_detail_d[l_ac].sfdc007             
                     SELECT imae082,imae083,imae084 INTO l_imae082,l_imae083,l_imae084 FROM imae_t
                      WHERE imaeent = g_enterprise AND imaesite = g_site AND imae001 = g_detail_d[l_ac].sfdc004
                     IF NOT cl_null(l_imae083) THEN
                        IF g_detail_d[l_ac].sfdc007 < l_imae083 THEN
                           LET l_sfdc008 = l_imae083
                        ELSE
                           LET l_sfdc008 = g_detail_d[l_ac].sfdc007
                        END IF
                     ELSE
                        LET l_sfdc008 = g_detail_d[l_ac].sfdc007
                     END IF                  
                     IF NOT cl_null(l_imae082) AND l_imae082 != 0 THEN
                        LET l_n_sfdc008 = l_sfdc008 / l_imae082
                        IF l_sfdc008  != l_imae082 * l_n_sfdc008 THEN
                           IF l_sfdc008 > l_imae082 * l_n_sfdc008 THEN
                              LET l_sfdc008 = l_imae082 * (l_n_sfdc008 + 1)
                           ELSE
                              LET l_sfdc008 = l_imae082 * l_n_sfdc008
                           END IF
                        END IF
                     END IF   
                     LET g_detail_d[l_ac].sfdc008 = l_sfdc008   
                     #单位取位
                     IF NOT cl_null(g_detail_d[l_ac].sfdc006) THEN
                        CALL s_aooi250_take_decimals(g_detail_d[l_ac].sfdc006,g_detail_d[l_ac].sfdc008)
                             RETURNING l_success,g_detail_d[l_ac].sfdc008
                     END IF  
                     
                     #检核已分配数量是否大于调整后发料数量
                     SELECT SUM(sfdd007) INTO s_sfdd007 FROM asfp320_sfdd_tmp
                      WHERE sfdd001 = g_detail_d[l_ac].sfdc004
                        AND sfdd013 = g_detail_d[l_ac].sfdc005
                        AND sfdd003 = g_detail_d[l_ac].sfdc012
                     IF cl_null(s_sfdd007) THEN LET s_sfdd007 = 0 END IF
                                                                   
                     IF s_sfdd007 > g_detail_d[l_ac].sfdc008 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code   = 'asf-00800'
                        LET g_errparam.extend = ""
                        LET g_errparam.replace[1] = g_detail_d[l_ac].sfdc004
                        LET g_errparam.replace[2] = g_detail_d[l_ac].sfdc005
                        LET g_errparam.replace[3] = g_detail_d[l_ac].sfdc012
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()              
                        NEXT FIELD b_sfdc008
                     ELSE
                        UPDATE asfp320_sfdc_tmp SET allot = s_sfdd007
                         WHERE sfdc004 = g_detail_d[l_ac].sfdc004
                           AND sfdc005 = g_detail_d[l_ac].sfdc005
                           AND sfdc012 = g_detail_d[l_ac].sfdc012                
                     END IF
                     
                     #單位換算
                     IF NOT cl_null(g_detail_d[l_ac].sfdc009) THEN
                        CALL s_aooi250_convert_qty(g_detail_d[l_ac].sfdc004,g_detail_d[l_ac].sfdc006,
                                                   g_detail_d[l_ac].sfdc009,g_detail_d[l_ac].sfdc008) 
                             RETURNING l_success,g_detail_d[l_ac].sfdc011    
                     END IF 

                     UPDATE asfp320_sfdc_tmp SET (seq1,sfdcdocno,sfdcseq,sfdc004,sfdc004_desc,sfdc004_desc_1,                 
                                                  sfdc005,sfdc005_desc,sfdc006,sfdc006_desc,sfdc007,sfdc008,  
                                                  allot,sfdc009,sfdc009_desc,sfdc010,sfdc011,ck_allot,sfdc012,sfdc012_desc, 
                                                  sfdc013,sfdc013_desc,sfdc014,sfdc015,sfdc015_desc,sfdc016)
                                               = (g_detail_d[l_ac].seq1,g_detail_d[l_ac].sfdcdocno,g_detail_d[l_ac].sfdcseq,g_detail_d[l_ac].sfdc004,g_detail_d[l_ac].sfdc004_desc,g_detail_d[l_ac].sfdc004_desc_1,                 
                                                  g_detail_d[l_ac].sfdc005,g_detail_d[l_ac].sfdc005_desc,g_detail_d[l_ac].sfdc006,g_detail_d[l_ac].sfdc006_desc,g_detail_d[l_ac].sfdc007,g_detail_d[l_ac].sfdc008,  
                                                  g_detail_d[l_ac].allot,g_detail_d[l_ac].sfdc009,g_detail_d[l_ac].sfdc009_desc,g_detail_d[l_ac].sfdc010,g_detail_d[l_ac].sfdc011,g_detail_d[l_ac].ck_allot,g_detail_d[l_ac].sfdc012,g_detail_d[l_ac].sfdc012_desc, 
                                                  g_detail_d[l_ac].sfdc013,g_detail_d[l_ac].sfdc013_desc,g_detail_d[l_ac].sfdc014,g_detail_d[l_ac].sfdc015,g_detail_d[l_ac].sfdc015_desc,g_detail_d[l_ac].sfdc016)       
                       WHERE seq1 = g_detail_d[l_ac].seq1   
                 
                  END IF   
               END IF 
               DISPLAY g_detail_d[l_ac].sfdc007 TO b_sfdc007               
               LET g_detail_d_t.sfdc007 = g_detail_d[l_ac].sfdc007
               END IF
            #AFTER FIELD b_sfdc007  #申請數量 
            #AFTER FIELD b_sfdc008  #調整后申請數量

            BEFORE FIELD b_sfdc008
               CALL DIALOG.setFieldTouched("s_detail1.b_sfdc008",TRUE)
               
            AFTER FIELD b_sfdc008  #調整后申請數量
            #ON CHANGE b_sfdc008  #調整后申請數量 
               IF l_ac > 0 THEN
               IF NOT cl_ap_chk_Range(g_detail_d[l_ac].sfdc008,"0","1","","","azz-00079",1) THEN
                  LET g_detail_d[l_ac].sfdc008 = g_detail_d_t.sfdc008
                  NEXT FIELD sfba024
               END IF               
               IF NOT cl_null(g_detail_d[l_ac].sfdc008) AND (g_detail_d[l_ac].sfdc008 != g_detail_d_t.sfdc008 OR cl_null(g_detail_d_t.sfdc008)) THEN
                  #单位取位
                  IF NOT cl_null(g_detail_d[l_ac].sfdc006) THEN
                     CALL s_aooi250_take_decimals(g_detail_d[l_ac].sfdc006,g_detail_d[l_ac].sfdc008)
                          RETURNING l_success,g_detail_d[l_ac].sfdc008
                  END IF            
                  #依发料料号发料控管方式控制
                  LET l_sfdc008 = g_detail_d[l_ac].sfdc008             
                  SELECT imae082,imae083,imae084 INTO l_imae082,l_imae083,l_imae084 FROM imae_t
                   WHERE imaeent = g_enterprise AND imaesite = g_site AND imae001 = g_detail_d[l_ac].sfdc004
                  IF NOT cl_null(l_imae083) THEN
                     IF g_detail_d[l_ac].sfdc008 < l_imae083 THEN
                        LET l_sfdc008 = l_imae083
                     ELSE
                        LET l_sfdc008 = g_detail_d[l_ac].sfdc008
                     END IF
                  ELSE
                     LET l_sfdc008 = g_detail_d[l_ac].sfdc008
                  END IF                  
                  IF NOT cl_null(l_imae082) AND l_imae082 != 0 THEN
                     LET l_n_sfdc008 = l_sfdc008 / l_imae082
                     IF l_sfdc008  != l_imae082 * l_n_sfdc008 THEN
                        IF l_sfdc008 > l_imae082 * l_n_sfdc008 THEN
                           LET l_sfdc008 = l_imae082 * (l_n_sfdc008 + 1)
                        ELSE
                           LET l_sfdc008 = l_imae082 * l_n_sfdc008
                        END IF
                     END IF
                  END IF                  
                  IF l_sfdc008 != g_detail_d[l_ac].sfdc008 AND NOT cl_null(l_imae084) AND l_imae084 != '3' THEN
                     IF l_imae084 = '1' THEN
                        LET l_msg = cl_getmsg('asf-00465',g_lang),l_sfdc008 USING '---,---,---,--&.&&&'
                        IF cl_ask_promp(l_msg) THEN
                           LET g_detail_d[l_ac].sfdc008 = l_sfdc008
                        END IF
                     END IF
                     IF l_imae084 = '2' THEN
                        LET l_msg = cl_getmsg('asf-00466',g_lang),l_sfdc008 USING '---,---,---,--&.&&&'
                        IF cl_ask_promp(l_msg) THEN
                           LET g_detail_d[l_ac].sfdc008 = l_sfdc008
                        ELSE
                           LET g_detail_d[l_ac].sfdc008 = g_detail_d_t.sfdc008
                           NEXT FIELD b_sfdc008
                        END IF
                     END IF
                     
                     UPDATE asfp320_sfdc_tmp SET (seq1,sfdcdocno,sfdcseq,sfdc004,sfdc004_desc,sfdc004_desc_1,                 
                                                  sfdc005,sfdc005_desc,sfdc006,sfdc006_desc,sfdc007,sfdc008,  
                                                  allot,sfdc009,sfdc009_desc,sfdc010,sfdc011,ck_allot,sfdc012,sfdc012_desc, 
                                                  sfdc013,sfdc013_desc,sfdc014,sfdc015,sfdc015_desc,sfdc016)
                                               = (g_detail_d[l_ac].seq1,g_detail_d[l_ac].sfdcdocno,g_detail_d[l_ac].sfdcseq,g_detail_d[l_ac].sfdc004,g_detail_d[l_ac].sfdc004_desc,g_detail_d[l_ac].sfdc004_desc_1,                 
                                                  g_detail_d[l_ac].sfdc005,g_detail_d[l_ac].sfdc005_desc,g_detail_d[l_ac].sfdc006,g_detail_d[l_ac].sfdc006_desc,g_detail_d[l_ac].sfdc007,g_detail_d[l_ac].sfdc008,  
                                                  g_detail_d[l_ac].allot,g_detail_d[l_ac].sfdc009,g_detail_d[l_ac].sfdc009_desc,g_detail_d[l_ac].sfdc010,g_detail_d[l_ac].sfdc011,g_detail_d[l_ac].ck_allot,g_detail_d[l_ac].sfdc012,g_detail_d[l_ac].sfdc012_desc, 
                                                  g_detail_d[l_ac].sfdc013,g_detail_d[l_ac].sfdc013_desc,g_detail_d[l_ac].sfdc014,g_detail_d[l_ac].sfdc015,g_detail_d[l_ac].sfdc015_desc,g_detail_d[l_ac].sfdc016)       
                       WHERE seq1 = g_detail_d[l_ac].seq1   
                 
                  END IF
                  #單位換算
                  IF NOT cl_null(g_detail_d[l_ac].sfdc009) THEN
                     CALL s_aooi250_convert_qty(g_detail_d[l_ac].sfdc004,g_detail_d[l_ac].sfdc006,
                                                g_detail_d[l_ac].sfdc009,g_detail_d[l_ac].sfdc008) 
                          RETURNING l_success,g_detail_d[l_ac].sfdc011    
                  END IF     

                  #检核已分配数量是否大于调整后发料数量
                  SELECT SUM(sfdd007) INTO s_sfdd007 FROM asfp320_sfdd_tmp
                   WHERE sfdd001 = g_detail_d[l_ac].sfdc004
                     AND sfdd013 = g_detail_d[l_ac].sfdc005
                     AND sfdd003 = g_detail_d[l_ac].sfdc012
                  IF cl_null(s_sfdd007) THEN LET s_sfdd007 = 0 END IF
                                                                
                  IF s_sfdd007 > g_detail_d[l_ac].sfdc008 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code   = 'asf-00788'
                     LET g_errparam.extend = ""
                     LET g_errparam.replace[1] = g_detail_d[l_ac].sfdc004
                     LET g_errparam.replace[2] = g_detail_d[l_ac].sfdc005
                     LET g_errparam.replace[3] = g_detail_d[l_ac].sfdc012
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()              
                     NEXT FIELD b_sfdc008
                  ELSE
                     UPDATE asfp320_sfdc_tmp SET allot = s_sfdd007
                      WHERE sfdc004 = g_detail_d[l_ac].sfdc004
                        AND sfdc005 = g_detail_d[l_ac].sfdc005
                        AND sfdc012 = g_detail_d[l_ac].sfdc012                
                  END IF
               END IF     
               DISPLAY g_detail_d[l_ac].sfdc008 TO b_sfdc008             
               LET g_detail_d_t.sfdc008 = g_detail_d[l_ac].sfdc008
               END IF
               
            AFTER FIELD b_sfdc010  #參考申請數量 

            #ON CHANGE b_sfdc010  #參考申請數量             
               #確認欄位值在特定區間內
               IF l_ac > 0 THEN
               IF NOT cl_ap_chk_range(g_detail_d[l_ac].sfdc010,"0","0","","","azz-00079",1) THEN
                  NEXT FIELD b_sfdc010
               END IF 
      
               IF NOT cl_null(g_detail_d[l_ac].sfdc010) THEN
                  UPDATE asfp320_sfdc_tmp SET (seq1,sfdcdocno,sfdcseq,sfdc004,sfdc004_desc,sfdc004_desc_1,                 
                                               sfdc005,sfdc005_desc,sfdc006,sfdc006_desc,sfdc007,sfdc008,  
                                               allot,sfdc009,sfdc009_desc,sfdc010,sfdc011,ck_allot,sfdc012,sfdc012_desc, 
                                               sfdc013,sfdc013_desc,sfdc014,sfdc015,sfdc015_desc,sfdc016)
                                            = (g_detail_d[l_ac].seq1,g_detail_d[l_ac].sfdcdocno,g_detail_d[l_ac].sfdcseq,g_detail_d[l_ac].sfdc004,g_detail_d[l_ac].sfdc004_desc,g_detail_d[l_ac].sfdc004_desc_1,                 
                                               g_detail_d[l_ac].sfdc005,g_detail_d[l_ac].sfdc005_desc,g_detail_d[l_ac].sfdc006,g_detail_d[l_ac].sfdc006_desc,g_detail_d[l_ac].sfdc007,g_detail_d[l_ac].sfdc008,  
                                               g_detail_d[l_ac].allot,g_detail_d[l_ac].sfdc009,g_detail_d[l_ac].sfdc009_desc,g_detail_d[l_ac].sfdc010,g_detail_d[l_ac].sfdc011,g_detail_d[l_ac].ck_allot,g_detail_d[l_ac].sfdc012,g_detail_d[l_ac].sfdc012_desc, 
                                               g_detail_d[l_ac].sfdc013,g_detail_d[l_ac].sfdc013_desc,g_detail_d[l_ac].sfdc014,g_detail_d[l_ac].sfdc015,g_detail_d[l_ac].sfdc015_desc,g_detail_d[l_ac].sfdc016)       
                    WHERE seq1 = g_detail_d[l_ac].seq1                  
               END IF        
               LET g_detail_d_t.sfdc010 = g_detail_d[l_ac].sfdc010
               END IF
               
            AFTER FIELD b_sfdc011  #參考调整后申請數量  

            #ON CHANGE b_sfdc011  #參考调整后申請數量   
               IF l_ac > 0 THEN
               #確認欄位值在特定區間內
               IF NOT cl_ap_chk_range(g_detail_d[l_ac].sfdc011,"0","0","","","azz-00079",1) THEN
                  NEXT FIELD b_sfdc011
               END IF 
      
               IF NOT cl_null(g_detail_d[l_ac].sfdc011) THEN
                  UPDATE asfp320_sfdc_tmp SET (seq1,sfdcdocno,sfdcseq,sfdc004,sfdc004_desc,sfdc004_desc_1,                 
                                               sfdc005,sfdc005_desc,sfdc006,sfdc006_desc,sfdc007,sfdc008,  
                                               allot,sfdc009,sfdc009_desc,sfdc010,sfdc011,ck_allot,sfdc012,sfdc012_desc, 
                                               sfdc013,sfdc013_desc,sfdc014,sfdc015,sfdc015_desc,sfdc016)
                                            = (g_detail_d[l_ac].seq1,g_detail_d[l_ac].sfdcdocno,g_detail_d[l_ac].sfdcseq,g_detail_d[l_ac].sfdc004,g_detail_d[l_ac].sfdc004_desc,g_detail_d[l_ac].sfdc004_desc_1,                 
                                               g_detail_d[l_ac].sfdc005,g_detail_d[l_ac].sfdc005_desc,g_detail_d[l_ac].sfdc006,g_detail_d[l_ac].sfdc006_desc,g_detail_d[l_ac].sfdc007,g_detail_d[l_ac].sfdc008,  
                                               g_detail_d[l_ac].allot,g_detail_d[l_ac].sfdc009,g_detail_d[l_ac].sfdc009_desc,g_detail_d[l_ac].sfdc010,g_detail_d[l_ac].sfdc011,g_detail_d[l_ac].ck_allot,g_detail_d[l_ac].sfdc012,g_detail_d[l_ac].sfdc012_desc, 
                                               g_detail_d[l_ac].sfdc013,g_detail_d[l_ac].sfdc013_desc,g_detail_d[l_ac].sfdc014,g_detail_d[l_ac].sfdc015,g_detail_d[l_ac].sfdc015_desc,g_detail_d[l_ac].sfdc016)       
                    WHERE seq1 = g_detail_d[l_ac].seq1                  
               END IF   
               LET g_detail_d_t.sfdc011 = g_detail_d[l_ac].sfdc011
               END IF
               
            AFTER FIELD b_sfdc012  #庫位
            #ON CHANGE b_sfdc012  #庫位 
               IF l_ac > 0 THEN
               CALL s_desc_get_stock_desc(g_site,g_detail_d[l_ac].sfdc012) RETURNING g_detail_d[l_ac].sfdc012_desc
               IF NOT cl_null(g_detail_d[l_ac].sfdc012) THEN 
                  IF g_detail_d[l_ac].sfdc012 <> g_detail_d_t.sfdc012 OR g_detail_d_t.sfdc012 IS NULL THEN  
                     IF NOT asfp320_key_chk(g_detail_d[l_ac].sfdc004,g_detail_d[l_ac].sfdc005,g_detail_d[l_ac].sfdc012) THEN
                        NEXT FIELD b_sfdc005
                     END IF                 
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_detail_d[l_ac].sfdc012                 
                     LET g_errshow = TRUE 
                     LET g_chkparam.err_str[1] = "aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"                 
                     IF NOT cl_chk_exist("v_inaa001_2") THEN
                        LET g_detail_d[l_ac].sfdc012 = g_detail_d_t.sfdc012
                        LET g_detail_d[l_ac].sfdc012_desc = s_desc_get_stock_desc(g_site,g_detail_d[l_ac].sfdc012)
                        NEXT FIELD sfdc012
                     END IF     
                  END IF
                  
                  UPDATE asfp320_sfdc_tmp SET (seq1,sfdcdocno,sfdcseq,sfdc004,sfdc004_desc,sfdc004_desc_1,                 
                                               sfdc005,sfdc005_desc,sfdc006,sfdc006_desc,sfdc007,sfdc008,  
                                               allot,sfdc009,sfdc009_desc,sfdc010,sfdc011,ck_allot,sfdc012,sfdc012_desc, 
                                               sfdc013,sfdc013_desc,sfdc014,sfdc015,sfdc015_desc,sfdc016)
                                            = (g_detail_d[l_ac].seq1,g_detail_d[l_ac].sfdcdocno,g_detail_d[l_ac].sfdcseq,g_detail_d[l_ac].sfdc004,g_detail_d[l_ac].sfdc004_desc,g_detail_d[l_ac].sfdc004_desc_1,                 
                                               g_detail_d[l_ac].sfdc005,g_detail_d[l_ac].sfdc005_desc,g_detail_d[l_ac].sfdc006,g_detail_d[l_ac].sfdc006_desc,g_detail_d[l_ac].sfdc007,g_detail_d[l_ac].sfdc008,  
                                               g_detail_d[l_ac].allot,g_detail_d[l_ac].sfdc009,g_detail_d[l_ac].sfdc009_desc,g_detail_d[l_ac].sfdc010,g_detail_d[l_ac].sfdc011,g_detail_d[l_ac].ck_allot,g_detail_d[l_ac].sfdc012,g_detail_d[l_ac].sfdc012_desc, 
                                               g_detail_d[l_ac].sfdc013,g_detail_d[l_ac].sfdc013_desc,g_detail_d[l_ac].sfdc014,g_detail_d[l_ac].sfdc015,g_detail_d[l_ac].sfdc015_desc,g_detail_d[l_ac].sfdc016)       
                    WHERE seq1 = g_detail_d[l_ac].seq1                     
               ELSE
                  LET g_detail_d[l_ac].sfdc012_desc = ''
               END IF
               CALL s_desc_get_stock_desc(g_site,g_detail_d[l_ac].sfdc012) RETURNING g_detail_d[l_ac].sfdc012_desc
               LET g_detail_d_t.sfdc012 = g_detail_d[l_ac].sfdc012
               END IF
            
            #ON CHANGE b_sfdc013  #儲位
            AFTER FIELD b_sfdc013  #儲位
               IF l_ac > 0 THEN
               IF NOT cl_null(g_detail_d[l_ac].sfdc013) THEN
                  #LET g_detail_d[l_ac].sfdc013_desc = s_desc_get_locator_desc(g_site,g_detail_d[l_ac].sfdc012,g_detail_d[l_ac].sfdc013)
                  CALL s_desc_get_locator_desc(g_site,g_detail_d[l_ac].sfdc012,g_detail_d[l_ac].sfdc013) RETURNING g_detail_d[l_ac].sfdc013_desc
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = g_detail_d[l_ac].sfdc012
                  LET g_chkparam.arg3 = g_detail_d[l_ac].sfdc013
                  #160318-00025#4--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                  #160318-00025#4--add--end
                  IF NOT cl_chk_exist("v_inab002") THEN
                     LET g_detail_d[l_ac].sfdc013 = g_detail_d_t.sfdc013
                     #LET g_detail_d[l_ac].sfdc013_desc = s_desc_get_locator_desc(g_site,g_detail_d[l_ac].sfdc012,g_detail_d[l_ac].sfdc013)
                     CALL s_desc_get_locator_desc(g_site,g_detail_d[l_ac].sfdc012,g_detail_d[l_ac].sfdc013) RETURNING g_detail_d[l_ac].sfdc013_desc
                     NEXT FIELD sfba020
                  END IF 
                  UPDATE asfp320_sfdc_tmp SET (seq1,sfdcdocno,sfdcseq,sfdc004,sfdc004_desc,sfdc004_desc_1,                 
                                              sfdc005,sfdc005_desc,sfdc006,sfdc006_desc,sfdc007,sfdc008,  
                                              allot,sfdc009,sfdc009_desc,sfdc010,sfdc011,ck_allot,sfdc012,sfdc012_desc, 
                                              sfdc013,sfdc013_desc,sfdc014,sfdc015,sfdc015_desc,sfdc016)
                                           = (g_detail_d[l_ac].seq1,g_detail_d[l_ac].sfdcdocno,g_detail_d[l_ac].sfdcseq,g_detail_d[l_ac].sfdc004,g_detail_d[l_ac].sfdc004_desc,g_detail_d[l_ac].sfdc004_desc_1,                 
                                              g_detail_d[l_ac].sfdc005,g_detail_d[l_ac].sfdc005_desc,g_detail_d[l_ac].sfdc006,g_detail_d[l_ac].sfdc006_desc,g_detail_d[l_ac].sfdc007,g_detail_d[l_ac].sfdc008,  
                                              g_detail_d[l_ac].allot,g_detail_d[l_ac].sfdc009,g_detail_d[l_ac].sfdc009_desc,g_detail_d[l_ac].sfdc010,g_detail_d[l_ac].sfdc011,g_detail_d[l_ac].ck_allot,g_detail_d[l_ac].sfdc012,g_detail_d[l_ac].sfdc012_desc, 
                                              g_detail_d[l_ac].sfdc013,g_detail_d[l_ac].sfdc013_desc,g_detail_d[l_ac].sfdc014,g_detail_d[l_ac].sfdc015,g_detail_d[l_ac].sfdc015_desc,g_detail_d[l_ac].sfdc016)       
                   WHERE seq1 = g_detail_d[l_ac].seq1                     
               END IF            
               #LET g_detail_d[l_ac].sfdc013_desc = s_desc_get_locator_desc(g_site,g_detail_d[l_ac].sfdc012,g_detail_d[l_ac].sfdc013)
               CALL s_desc_get_locator_desc(g_site,g_detail_d[l_ac].sfdc012,g_detail_d[l_ac].sfdc013) RETURNING g_detail_d[l_ac].sfdc013_desc 
               DISPLAY BY NAME g_detail_d[l_ac].sfdc013_desc  
               LET g_detail_d_t.sfdc013 = g_detail_d[l_ac].sfdc013
               END IF
               
            AFTER FIELD b_sfdc014
            #ON CHANGE b_sfdc014
               IF l_ac > 0 THEN
               IF g_detail_d[l_ac].sfdc014 <> g_detail_d_t.sfdc014 OR g_detail_d_t.sfdc014 IS NULL THEN
                  UPDATE asfp320_sfdc_tmp SET (seq1,sfdcdocno,sfdcseq,sfdc004,sfdc004_desc,sfdc004_desc_1,                 
                                              sfdc005,sfdc005_desc,sfdc006,sfdc006_desc,sfdc007,sfdc008,  
                                              allot,sfdc009,sfdc009_desc,sfdc010,sfdc011,ck_allot,sfdc012,sfdc012_desc, 
                                              sfdc013,sfdc013_desc,sfdc014,sfdc015,sfdc015_desc,sfdc016)
                                           = (g_detail_d[l_ac].seq1,g_detail_d[l_ac].sfdcdocno,g_detail_d[l_ac].sfdcseq,g_detail_d[l_ac].sfdc004,g_detail_d[l_ac].sfdc004_desc,g_detail_d[l_ac].sfdc004_desc_1,                 
                                              g_detail_d[l_ac].sfdc005,g_detail_d[l_ac].sfdc005_desc,g_detail_d[l_ac].sfdc006,g_detail_d[l_ac].sfdc006_desc,g_detail_d[l_ac].sfdc007,g_detail_d[l_ac].sfdc008,  
                                              g_detail_d[l_ac].allot,g_detail_d[l_ac].sfdc009,g_detail_d[l_ac].sfdc009_desc,g_detail_d[l_ac].sfdc010,g_detail_d[l_ac].sfdc011,g_detail_d[l_ac].ck_allot,g_detail_d[l_ac].sfdc012,g_detail_d[l_ac].sfdc012_desc, 
                                              g_detail_d[l_ac].sfdc013,g_detail_d[l_ac].sfdc013_desc,g_detail_d[l_ac].sfdc014,g_detail_d[l_ac].sfdc015,g_detail_d[l_ac].sfdc015_desc,g_detail_d[l_ac].sfdc016)       
                   WHERE seq1 = g_detail_d[l_ac].seq1                   
               END IF
               LET g_detail_d_t.sfdc014 = g_detail_d[l_ac].sfdc014
               END IF
               
            AFTER FIELD b_sfdc016
            #ON CHANGE b_sfdc016
               IF l_ac > 0 THEN
               IF g_detail_d[l_ac].sfdc016 <> g_detail_d_t.sfdc016 OR g_detail_d_t.sfdc016 IS NULL THEN
                  UPDATE asfp320_sfdc_tmp SET (seq1,sfdcdocno,sfdcseq,sfdc004,sfdc004_desc,sfdc004_desc_1,                 
                                              sfdc005,sfdc005_desc,sfdc006,sfdc006_desc,sfdc007,sfdc008,  
                                              allot,sfdc009,sfdc009_desc,sfdc010,sfdc011,ck_allot,sfdc012,sfdc012_desc, 
                                              sfdc013,sfdc013_desc,sfdc014,sfdc015,sfdc015_desc,sfdc016)
                                           = (g_detail_d[l_ac].seq1,g_detail_d[l_ac].sfdcdocno,g_detail_d[l_ac].sfdcseq,g_detail_d[l_ac].sfdc004,g_detail_d[l_ac].sfdc004_desc,g_detail_d[l_ac].sfdc004_desc_1,                 
                                              g_detail_d[l_ac].sfdc005,g_detail_d[l_ac].sfdc005_desc,g_detail_d[l_ac].sfdc006,g_detail_d[l_ac].sfdc006_desc,g_detail_d[l_ac].sfdc007,g_detail_d[l_ac].sfdc008,  
                                              g_detail_d[l_ac].allot,g_detail_d[l_ac].sfdc009,g_detail_d[l_ac].sfdc009_desc,g_detail_d[l_ac].sfdc010,g_detail_d[l_ac].sfdc011,g_detail_d[l_ac].ck_allot,g_detail_d[l_ac].sfdc012,g_detail_d[l_ac].sfdc012_desc, 
                                              g_detail_d[l_ac].sfdc013,g_detail_d[l_ac].sfdc013_desc,g_detail_d[l_ac].sfdc014,g_detail_d[l_ac].sfdc015,g_detail_d[l_ac].sfdc015_desc,g_detail_d[l_ac].sfdc016)       
                   WHERE seq1 = g_detail_d[l_ac].seq1                   
               END IF
               LET g_detail_d_t.sfdc016 = g_detail_d[l_ac].sfdc016               
               END IF
               
            ON ROW CHANGE
               IF INT_FLAG THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 9001
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  #CALL s_transaction_end('N','0') 
                  LET INT_FLAG = 0
                  NEXT FIELD b_sfdc004  #是否重新开启事务
               END IF
               IF NOT asfp320_get_imaa005(g_detail_d[l_ac].sfdc004) THEN
                  IF cl_null(g_detail_d[l_ac].sfdc005) THEN
                     LET g_detail_d[l_ac].sfdc005 = ' '
                  END IF 
               END IF               
               UPDATE asfp320_sfdc_tmp SET (seq1,sfdcdocno,sfdcseq,sfdc004,sfdc004_desc,sfdc004_desc_1,                 
                                            sfdc005,sfdc005_desc,sfdc006,sfdc006_desc,sfdc007,sfdc008,  
                                            allot,sfdc009,sfdc009_desc,sfdc010,sfdc011,ck_allot,sfdc012,sfdc012_desc, 
                                            sfdc013,sfdc013_desc,sfdc014,sfdc015,sfdc015_desc,sfdc016)
                                         = (g_detail_d[l_ac].seq1,g_detail_d[l_ac].sfdcdocno,g_detail_d[l_ac].sfdcseq,g_detail_d[l_ac].sfdc004,g_detail_d[l_ac].sfdc004_desc,g_detail_d[l_ac].sfdc004_desc_1,                 
                                            g_detail_d[l_ac].sfdc005,g_detail_d[l_ac].sfdc005_desc,g_detail_d[l_ac].sfdc006,g_detail_d[l_ac].sfdc006_desc,g_detail_d[l_ac].sfdc007,g_detail_d[l_ac].sfdc008,  
                                            g_detail_d[l_ac].allot,g_detail_d[l_ac].sfdc009,g_detail_d[l_ac].sfdc009_desc,g_detail_d[l_ac].sfdc010,g_detail_d[l_ac].sfdc011,g_detail_d[l_ac].ck_allot,g_detail_d[l_ac].sfdc012,g_detail_d[l_ac].sfdc012_desc, 
                                            g_detail_d[l_ac].sfdc013,g_detail_d[l_ac].sfdc013_desc,g_detail_d[l_ac].sfdc014,g_detail_d[l_ac].sfdc015,g_detail_d[l_ac].sfdc015_desc,g_detail_d[l_ac].sfdc016)       
                 WHERE seq1 = g_detail_d[l_ac].seq1                                           
#                WHERE sfdc004 = g_detail_d_t.sfdc004
#                  AND sfdc005 = g_detail_d_t.sfdc005
#                  AND sfdc012 = g_detail_d_t.sfdc012

               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "upd asfp320_sfdc_tmp"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #CALL s_transaction_end('N','0') 
                     LET g_detail_d[l_ac].* = g_detail_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "upd asfp320_sfdc_tmp"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #CALL s_transaction_end('N','0')  
                     LET g_detail_d[l_ac].* = g_detail_d_t.*
                  OTHERWISE
               END CASE               
     
            AFTER ROW
               #CALL s_transaction_end('Y','0')
            
            ON ACTION controlp INFIELD b_sfdc004           
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail_d[l_ac].sfdc004            #給予default值
               #給予arg
               #LET g_qryparam.arg1 = g_site
               CALL q_imaf001_6()                              #呼叫開窗
               LET g_detail_d[l_ac].sfdc004 = g_qryparam.return1              #將開窗取得的值回傳到變數
               DISPLAY g_detail_d[l_ac].sfdc004  TO b_sfdc004           #顯示到畫面上
               NEXT FIELD b_sfdc004                     #返回原欄位            

            ON ACTION controlp INFIELD b_sfdc005            
               LET g_detail_d_t.sfdc005 = g_detail_d[l_ac].sfdc005
               CALL s_feature_single(g_detail_d[l_ac].sfdc004,g_detail_d[l_ac].sfdc005,'ALL','') 
                  RETURNING r_success,g_detail_d[l_ac].sfdc005
               IF cl_null(g_detail_d[l_ac].sfdc005) THEN 
                  LET g_detail_d[l_ac].sfdc005 = g_detail_d_t.sfdc005
               END IF   
               DISPLAY g_detail_d[l_ac].sfdc005 TO b_sfdc005       


            ON ACTION controlp INFIELD b_sfdc012  

               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
            
               LET g_qryparam.default1 = g_detail_d[l_ac].sfdc012             #給予default值
               LET g_qryparam.default2 = g_detail_d[l_ac].sfdc013
               LET g_qryparam.default3 = g_detail_d[l_ac].sfdc014
               LET g_qryparam.default4 = g_detail_d[l_ac].sfdc016
               
               LET g_qryparam.where = " 1=1"  
               LET g_qryparam.arg1 = g_detail_d[l_ac].sfdc004
               IF cl_null(g_detail_d[l_ac].sfdc005) THEN
                  LET g_detail_d[l_ac].sfdc005 = ' '
               END IF
               LET g_qryparam.arg2 = g_detail_d[l_ac].sfdc005
               IF NOT cl_null(g_detail_d[l_ac].sfdc016) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag003 = '",g_detail_d[l_ac].sfdc016,"'"
               END IF  
               IF NOT cl_null(g_detail_d[l_ac].sfdc012) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag004 = '",g_detail_d[l_ac].sfdc012,"'"
               END IF 
               IF NOT cl_null(g_detail_d[l_ac].sfdc013) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag005 = '",g_detail_d[l_ac].sfdc013,"'"
               END IF   
#               IF NOT cl_null(g_indd_d[l_ac].indd006) THEN
#                  LET g_qryparam.where = g_qryparam.where," AND inag007 = '",g_indd_d[l_ac].indd006,"'"
#               END IF    
               
               CALL q_inag004_13()                              #呼叫開窗
            
               LET g_detail_d[l_ac].sfdc012 = g_qryparam.return1              
               LET g_detail_d[l_ac].sfdc013 = g_qryparam.return2 
               LET g_detail_d[l_ac].sfdc014 = g_qryparam.return3 
               LET g_detail_d[l_ac].sfdc016 = g_qryparam.return4
               CALL s_desc_get_locator_desc(g_site,g_detail_d[l_ac].sfdc012,g_detail_d[l_ac].sfdc013) RETURNING g_detail_d[l_ac].sfdc013_desc 
               DISPLAY BY NAME g_detail_d[l_ac].sfdc013_desc  
               CALL s_desc_get_stock_desc(g_site,g_detail_d[l_ac].sfdc012) RETURNING g_detail_d[l_ac].sfdc012_desc 
               DISPLAY BY NAME g_detail_d[l_ac].sfdc012_desc               
               DISPLAY g_detail_d[l_ac].sfdc012 TO b_sfdc012             #
               DISPLAY g_detail_d[l_ac].sfdc013 TO b_sfdc013
               DISPLAY g_detail_d[l_ac].sfdc014 TO b_sfdc014
               DISPLAY g_detail_d[l_ac].sfdc016 TO b_sfdc016
               

            ON ACTION controlp INFIELD b_sfdc013  

               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
            
               LET g_qryparam.default1 = g_detail_d[l_ac].sfdc012             #給予default值
               LET g_qryparam.default2 = g_detail_d[l_ac].sfdc013
               LET g_qryparam.default3 = g_detail_d[l_ac].sfdc014
               LET g_qryparam.default4 = g_detail_d[l_ac].sfdc016
               
               LET g_qryparam.where = " 1=1"  
               LET g_qryparam.arg1 = g_detail_d[l_ac].sfdc004
               IF cl_null(g_detail_d[l_ac].sfdc005) THEN
                  LET g_detail_d[l_ac].sfdc005 = ' '
               END IF
               LET g_qryparam.arg2 = g_detail_d[l_ac].sfdc005
               IF NOT cl_null(g_detail_d[l_ac].sfdc016) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag003 = '",g_detail_d[l_ac].sfdc016,"'"
               END IF  
               IF NOT cl_null(g_detail_d[l_ac].sfdc012) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag004 = '",g_detail_d[l_ac].sfdc012,"'"
               END IF 
               IF NOT cl_null(g_detail_d[l_ac].sfdc013) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag005 = '",g_detail_d[l_ac].sfdc013,"'"
               END IF                   
               CALL q_inag004_13()                              #呼叫開窗            
               LET g_detail_d[l_ac].sfdc012 = g_qryparam.return1              
               LET g_detail_d[l_ac].sfdc013 = g_qryparam.return2 
               LET g_detail_d[l_ac].sfdc014 = g_qryparam.return3 
               LET g_detail_d[l_ac].sfdc016 = g_qryparam.return4
               CALL s_desc_get_locator_desc(g_site,g_detail_d[l_ac].sfdc012,g_detail_d[l_ac].sfdc013) RETURNING g_detail_d[l_ac].sfdc013_desc 
               DISPLAY BY NAME g_detail_d[l_ac].sfdc013_desc  
               CALL s_desc_get_stock_desc(g_site,g_detail_d[l_ac].sfdc012) RETURNING g_detail_d[l_ac].sfdc012_desc 
               DISPLAY BY NAME g_detail_d[l_ac].sfdc012_desc                
               DISPLAY g_detail_d[l_ac].sfdc012 TO b_sfdc012             #
               DISPLAY g_detail_d[l_ac].sfdc013 TO b_sfdc013
               DISPLAY g_detail_d[l_ac].sfdc014 TO b_sfdc014
               DISPLAY g_detail_d[l_ac].sfdc016 TO b_sfdc016
               
            AFTER INPUT
    
         END INPUT

         INPUT ARRAY g_sfaa_d FROM s_detail2.*
             ATTRIBUTE(COUNT = g_detail_cnt2,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         
            BEFORE INPUT
               #CALL asfp320_b_fill_sfaa()
               LET g_detail_cnt2 = g_sfaa_d.getLength()
#               IF g_sfaa_d.getLength() > 0 THEN
#                  CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
#                  CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
#               ELSE
#                  CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
#                  CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
#               END IF   
#               CALL cl_set_comp_visible("sel",TRUE)   
               
            BEFORE ROW
               LET l_cmd = ''
               LET l_ac2 = ARR_CURR()
               LET g_detail_idx2 = l_ac2
               LET g_detail_cnt2 = g_sfaa_d.getLength()
               IF g_detail_cnt2 >= l_ac2 AND g_sfaa_d[l_ac2].sfaadocno IS NOT NULL THEN
                  LET l_cmd ='u'
                  LET g_sfaa_d_t.* = g_sfaa_d[l_ac2].*  #BACKUP
               ELSE
                  LET l_cmd='a'
                  INITIALIZE g_sfaa_d_t.* TO NULL                         
               END IF               
               #CALL s_transaction_begin()
               
            BEFORE INSERT
#               IF s_transaction_chk("N",0) THEN
#                  CALL s_transaction_begin()
#               END IF            
               LET l_cmd = 'a'
               INITIALIZE g_sfaa_d[l_ac2].* TO NULL
               LET g_sfaa_d_t.* = g_sfaa_d[l_ac2].*     #新輸入資料
               CALL cl_show_fld_cont()   


            AFTER INSERT
            #资料写入临时表
               LET l_insert = FALSE
               IF INT_FLAG THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = 9001 
                  LET g_errparam.popup  = FALSE 
                  CALL cl_err()
                  LET INT_FLAG = 0
                  CANCEL INSERT
               END IF            
               LET l_count = 1

               SELECT COUNT(1) INTO l_count FROM asfp320_sfaa_tmp
                WHERE sfaadocno = g_sfaa_d[l_ac2].sfaadocno

               #資料未重複, 插入新增資料
               IF l_count = 0 THEN                     
                  INSERT INTO asfp320_sfaa_tmp (sel02,sfaadocno,sfaa021,sfaa025,sfaa010,sfaa010_desc,sfaa010_desc_1,
                                                sfaa012,sfaa049,sfdd006_2,sfdd006_2_desc)
                                        VALUES (g_sfaa_d[l_ac2].sel02,g_sfaa_d[l_ac2].sfaadocno,g_sfaa_d[l_ac2].sfaa021,g_sfaa_d[l_ac2].sfaa025,g_sfaa_d[l_ac2].sfaa010,g_sfaa_d[l_ac2].sfaa010_desc,g_sfaa_d[l_ac2].sfaa010_desc_1,
                                                g_sfaa_d[l_ac2].sfaa012,g_sfaa_d[l_ac2].sfaa049,g_sfaa_d[l_ac2].sfdd006_2,g_sfaa_d[l_ac2].sfdd006_2_desc) 
                  IF SQLCA.SQLcode  THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "ins asfp320_sfaa_tmp"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     INITIALIZE g_sfaa_d[l_ac2].* TO NULL
                     #CALL s_transaction_end('N','0')
                     CANCEL INSERT
                  ELSE
                     #CALL s_transaction_end('Y','0')
                     LET g_detail_cnt2 = g_detail_cnt2 + 1                     
                  END IF   
               ELSE
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'INSERT' 
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  INITIALIZE g_sfaa_d[l_ac2].* TO NULL
                  #CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL INSERT               
               END IF            
                       
            
            BEFORE DELETE
            
               IF l_cmd = 'a' THEN
                  CALL FGL_SET_ARR_CURR(l_ac2 - 1)
                  CALL g_sfaa_d.deleteElement(l_ac2)
                  NEXT FIELD sfaadocno
               END IF

               IF g_sfaa_d[l_ac2].sfaadocno IS NOT NULL THEN
                  IF NOT cl_ask_del_detail() THEN
                     CANCEL DELETE
                  END IF
               
                  DELETE FROM asfp320_sfaa_tmp
                   WHERE sfaadocno = g_sfaa_d_t.sfaadocno

                     
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "del asfp320_sfaa_tmp"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #CALL s_transaction_end('N','0')
                     CANCEL DELETE
                  ELSE
                     #CALL s_transaction_end('Y','0')
                     LET g_detail_cnt2 = g_detail_cnt2 - 1
                  END IF
               END IF              
            
            
            AFTER DELETE
               #如果是最後一筆
               IF l_ac2 = (g_sfaa_d.getLength() + 1) THEN
                  CALL FGL_SET_ARR_CURR(l_ac2-1)
               END IF            

            ON CHANGE sel02
               UPDATE asfp320_sfaa_tmp SET sel02 = g_sfaa_d[l_ac2].sel02
           
                WHERE sfaadocno = g_sfaa_d_t.sfaadocno            
               
            AFTER FIELD b_sfaadocno
            
               IF NOT cl_null(g_sfaa_d[l_ac2].sfaadocno) THEN
                  IF g_sfaa_d_t.sfaadocno <> g_sfaa_d[l_ac2].sfaadocno OR g_sfaa_d_t.sfaadocno IS NULL THEN
                     #是否重複
                     LET l_cnt = 0 
                     SELECT COUNT(1) INTO l_cnt FROM asfp320_sfaa_tmp
                      WHERE sfaadocno = g_sfaa_d[l_ac2].sfaadocno
                     IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                     IF l_cnt > 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'asf-00791'
                        LET g_errparam.extend = g_sfaa_d[l_ac2].sfaadocno
                        LET g_errparam.popup = TRUE
                        CALL cl_err()  
                        LET g_sfaa_d[l_ac2].sfaadocno = g_sfaa_d_t.sfaadocno
                        NEXT FIELD b_sfaadocno                       
                     END IF                     
                     #工单是否符合条件
                     INITIALIZE g_chkparam.* TO NULL
                     
                     #設定g_chkparam.*的參數
                     LET g_chkparam.arg1 = g_sfaa_d[l_ac2].sfaadocno
                     
                     #呼叫檢查存在並帶值的library
                     IF NOT cl_chk_exist("v_sfaadocno_6") THEN
                        LET g_sfaa_d[l_ac2].sfaadocno = g_sfaa_d_t.sfaadocno
                        CALL asfp320_default_sfaa()
                        NEXT FIELD CURRENT 
                     END IF                  
                  END IF
               END IF
               CALL asfp320_default_sfaa()
               LET g_sfaa_d_t.sfaadocno = g_sfaa_d[l_ac2].sfaadocno
            
            ON ROW CHANGE
               IF INT_FLAG THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 9001
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  #CALL s_transaction_end('N','0')
                  LET INT_FLAG = 0
                  NEXT FIELD b_sfaadocno
               END IF
               UPDATE asfp320_sfaa_tmp SET (sfaadocno,sfaa021,sfaa025,sfaa010,sfaa010_desc,sfaa010_desc_1,
                                            sfaa012,sfaa049,sfdd006_2,sfdd006_2_desc)
                                         = (g_sfaa_d[l_ac2].sfaadocno,g_sfaa_d[l_ac2].sfaa021,g_sfaa_d[l_ac2].sfaa025,g_sfaa_d[l_ac2].sfaa010,g_sfaa_d[l_ac2].sfaa010_desc,g_sfaa_d[l_ac2].sfaa010_desc_1,
                                            g_sfaa_d[l_ac2].sfaa012,g_sfaa_d[l_ac2].sfaa049,g_sfaa_d[l_ac2].sfdd006_2,g_sfaa_d[l_ac2].sfdd006_2_desc  )                
                WHERE sfaadocno = g_sfaa_d_t.sfaadocno

               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "upd asfp320_sfaa_tmp"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #CALL s_transaction_end('N','0') 
                     LET g_sfaa_d[l_ac2].* = g_sfaa_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "upd asfp320_sfaa_tmp"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #CALL s_transaction_end('N','0')  
                     LET g_sfaa_d[l_ac2].* = g_sfaa_d_t.*
                  OTHERWISE
               END CASE    

            AFTER ROW            
               #CALL s_transaction_end('Y','0')
               
            AFTER INPUT
 
            ON ACTION controlp INFIELD b_sfaadocno
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL  
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_sfaa_d[l_ac2].sfaadocno  #給予default值
               #給予arg
               CALL q_sfaadocno_15()                                #呼叫開窗
               LET g_sfaa_d[l_ac2].sfaadocno = g_qryparam.return1   #將開窗取得的值回傳到變數
               LET g_sfaa_d[l_ac2].sfaa021 = g_qryparam.return2             
               LET g_sfaa_d[l_ac2].sfaa025 = g_qryparam.return3             
               LET g_sfaa_d[l_ac2].sfaa010 = g_qryparam.return4             
               LET g_sfaa_d[l_ac2].sfaa010_desc = g_qryparam.return5       
               LET g_sfaa_d[l_ac2].sfaa010_desc_1  = g_qryparam.return6      
               LET g_sfaa_d[l_ac2].sfaa012 = g_qryparam.return7              
               LET g_sfaa_d[l_ac2].sfaa049 = g_qryparam.return8             
               LET g_sfaa_d[l_ac2].sfdd006_2 = g_qryparam.return9           
               LET g_sfaa_d[l_ac2].sfdd006_2_desc = g_qryparam.return10                  
               DISPLAY BY NAME g_sfaa_d[l_ac2].sfaa021,g_sfaa_d[l_ac2].sfaa025,g_sfaa_d[l_ac2].sfaa010,g_sfaa_d[l_ac2].sfaa012,g_sfaa_d[l_ac2].sfaa049,
                               g_sfaa_d[l_ac2].sfaa010_desc,g_sfaa_d[l_ac2].sfaa010_desc_1,g_sfaa_d[l_ac2].sfdd006_2,g_sfaa_d[l_ac2].sfdd006_2_desc
               NEXT FIELD b_sfaadocno                           #返回原欄位 
            
         END INPUT  
         
         INPUT ARRAY g_sfdd_d FROM s_detail3.*
             ATTRIBUTE(COUNT = g_detail_cnt3,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         
            BEFORE INPUT
               #CALL asfp320_b_fill_sfdd()
               LET g_detail_cnt3 = g_sfdd_d.getLength()
#               IF g_sfdd_d.getLength() > 0 THEN
#                  CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
#                  CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
#               ELSE
#                  CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
#                  CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
#               END IF   
               CALL cl_set_comp_visible("sel",TRUE)   
               CALL FGL_SET_ARR_CURR(l_ac3)
               
            BEFORE ROW
               LET l_cmd = 'u'
               LET l_ac3 = DIALOG.getCurrentRow("s_detail3")               
               LET l_ac3 = ARR_CURR()
               LET g_detail_idx3 = l_ac3
               CALL FGL_SET_ARR_CURR(l_ac3)
               LET g_detail_cnt3 = g_sfdd_d.getLength()
               LET g_sfdd_d_t.* = g_sfdd_d[l_ac3].*  #BACKUP             
               #CALL s_transaction_begin()               

            ON CHANGE sel            
               UPDATE asfp320_sfdd_tmp SET sel = g_sfdd_d[l_ac3].sel                
                WHERE sfaadocno = g_sfdd_d_t.sfaadocno
                  AND sfdd001 = g_sfdd_d_t.sfdd001  
                  AND rowno = g_sfdd_d_t.rowno  
               DISPLAY BY NAME g_sfdd_d[l_ac3].sel 
                               
            ON CHANGE lockd
               UPDATE asfp320_sfdd_tmp SET lockd = g_sfdd_d[l_ac3].lockd                
                WHERE sfaadocno = g_sfdd_d_t.sfaadocno
                  AND sfdd001 = g_sfdd_d_t.sfdd001  
                  AND rowno = g_sfdd_d_t.rowno   
               IF SQLCA.sqlerrd[3] = 0 THEN #更新不到的處理
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "std-00009"
                  LET g_errparam.extend = "upd asfp320_sfdd_tmp"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()   
               END IF
               DISPLAY BY NAME g_sfdd_d[l_ac3].lockd  
               
            AFTER FIELD b_sfdd007
               IF NOT cl_null(g_sfdd_d[l_ac3].sfdd007) THEN             
                  #更新需求党已分配数量
                  SELECT SUM(sfdd007) INTO s_sfdd007 FROM asfp320_sfdd_tmp
                   WHERE sfdd001 = g_sfdd_d[l_ac3].sfdd001
                     AND sfdd013 = g_sfdd_d[l_ac3].sfdd013
                     AND sfdd003 = g_sfdd_d[l_ac3].sfdd003
                     AND rowno <> g_sfdd_d[l_ac3].rowno
                     
                  IF cl_null(s_sfdd007) THEN LET s_sfdd007 = 0 END IF
                                                                
                  IF s_sfdd007 + g_sfdd_d[l_ac3].sfdd007 > l_sfdc008 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code   = 'asf-00787'
                     LET g_errparam.extend = ""
                     LET g_errparam.replace[1] = g_sfdd_d[l_ac3].sfdd001
                     LET g_errparam.replace[2] = g_sfdd_d[l_ac3].sfdd013
                     LET g_errparam.replace[3] = g_sfdd_d[l_ac3].sfdd003
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()              
                     NEXT FIELD b_sfdd007
                  ELSE
                     UPDATE asfp320_sfdc_tmp SET allot = s_sfdd007 + g_sfdd_d[l_ac3].sfdd007
                      WHERE sfdc004 = g_sfdd_d[l_ac3].sfdd001
                        AND sfdc005 = g_sfdd_d[l_ac3].sfdd013
                        AND sfdc012 = g_sfdd_d[l_ac3].sfdd003                
                  END IF   
                  UPDATE asfp320_sfdd_tmp SET sfdd007 = g_sfdd_d[l_ac3].sfdd007                
                   WHERE sfaadocno = g_sfdd_d_t.sfaadocno
                     AND sfdd001 = g_sfdd_d_t.sfdd001  
                     AND rowno = g_sfdd_d_t.rowno                    
               END IF
               
            ON ROW CHANGE
               IF INT_FLAG THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 9001
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  #CALL s_transaction_end('N','0')
                  LET INT_FLAG = 0
                  NEXT FIELD sel
               END IF
               UPDATE asfp320_sfdd_tmp SET (sel,lockd,sfdd007,sfdd009)
                                         = (g_sfdd_d[l_ac3].sel,g_sfdd_d[l_ac3].lockd,g_sfdd_d[l_ac3].sfdd007,g_sfdd_d[l_ac3].sfdd009)                
                WHERE sfaadocno = g_sfdd_d_t.sfaadocno
                  AND sfdd001 = g_sfdd_d_t.sfdd001  
                  AND rowno = g_sfdd_d_t.rowno                  

 
                  
            AFTER ROW               
               #CALL s_transaction_end('Y','0') 
               
            AFTER INPUT
            
#               SELECT SUM(sfdd007) INTO s_sfdd007 FROM asfp320_sfdd_tmp
#                WHERE sfdd001 = g_sfdd_d[l_ac3].sfdd001
#                  AND sfdd013 = g_sfdd_d[l_ac3].sfdd013
#                  AND sfdd003 = g_sfdd_d[l_ac3].sfdd003
#               IF cl_null(s_sfdd007) THEN LET s_sfdd007 = 0 END IF
#               
#               SELECT sfdc008 INTO l_sfdc008 FROM asfp320_sfdc_tmp 
#                WHERE sfdc004 = g_sfdd_d[l_ac3].sfdd001
#                  AND sfdc005 = g_sfdd_d[l_ac3].sfdd013
#                  AND sfdc012 = g_sfdd_d[l_ac3].sfdd003  
#                                 
#               UPDATE asfp320_sfdc_tmp SET allot = s_sfdd007
#                WHERE sfdc004 = g_sfdd_d[l_ac3].sfdd001
#                  AND sfdc005 = g_sfdd_d[l_ac3].sfdd013
#                  AND sfdc012 = g_sfdd_d[l_ac3].sfdd003               
#               IF s_sfdd007 <> l_sfdc008 THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code   = 'asf-00781'
#                  LET g_errparam.extend = ""
#                  LET g_errparam.replace[1] = g_sfdd_d[l_ac3].sfdd001
#                  LET g_errparam.replace[2] = g_sfdd_d[l_ac3].sfdd013
#                  LET g_errparam.replace[3] = g_sfdd_d[l_ac3].sfdd003
#                  LET g_errparam.popup  = TRUE
#                  CALL cl_err()              
#                  NEXT FIELD b_sfdd007
#               END IF               
            
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
               CALL asfp320_set_entry_sfdc()  
               CALL asfp320_set_no_required()
               CALL asfp320_set_required()
               CALL asfp320_set_no_entry_sfdc()             
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            UPDATE asfp320_sfdc_tmp SET sel = 'Y'
             WHERE 1=1
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone name="ui_dialog.for.onaction_selnone"
               CALL asfp320_set_entry_sfdc()  
               CALL asfp320_set_no_required()
               CALL asfp320_set_required()
               CALL asfp320_set_no_entry_sfdc()
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            UPDATE asfp320_sfdc_tmp SET sel = 'N'
             WHERE 1=1
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
#         ON ACTION cancel      #在dialog button (放棄)
#            #add-point:input段cancel name="input.cancel"
#        
#            #end add-point  
#            LET INT_FLAG = TRUE 
#            LET g_detail_idx  = 1
#            LET g_detail_idx2 = 1
#            #各個page指標        
#            CALL g_curr_diag.setCurrentRow("s_detail1",1)    
#        
#            EXIT DIALOG
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL asfp320_filter()
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
            CALL asfp320_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL asfp320_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"

         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               
            END IF
            
         ON ACTION batch_execute         
            LET g_action_choice="batch_execute"
            IF cl_auth_chk_act("batch_execute") THEN
               CALL cl_err_collect_init()
               CALL asfp320_process()
               CALL cl_err_collect_show()
#               IF r_success THEN 
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'asf-00782'  #产生成功
#                  LET g_errparam.extend = ''
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()  
#                  #刷新发料底稿
#                  CALL asfp320_b_fill_sfdd()                  
#               ELSE
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'asf-00778'
#                  LET g_errparam.extend = ''
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()                  
#               END IF
            END IF          
         ON ACTION delete_draft
            LET g_action_choice="delete_draft"
            IF cl_auth_chk_act("delete_draft") THEN
               CALL asfp320_delete_draft()
            END IF
            
         ON ACTION gen_draft
            LET g_action_choice="gen_draft"
            IF cl_auth_chk_act("gen_draft") THEN                    
               LET l_flag = 'Y' 
               LET l_cnt = 0
               SELECT COUNT(1) INTO l_cnt FROM asfp320_sfdc_tmp 
                WHERE sel = 'Y'
               IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF    
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = 'asf-00797'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()  
                  LET l_flag = 'N'       
               END IF             
               LET l_cnt = 0 
               SELECT COUNT(1) INTO l_cnt FROM asfp320_sfaa_tmp
                WHERE sel02 = 'Y'
               IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF 
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = 'asf-00798'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()   
                  LET l_flag = 'N'      
               END IF 
                 
               IF l_flag = 'Y' THEN 
                  INITIALIZE l_sfdc_new.* TO NULL
                  LET l_sfdd007_new = ''
                  LET l_sel_new = ''
                  LET l_lockd_new = ''
                  LET l_sfdc_new.seq1 = GET_FLDBUF(seq1)
                  LET l_sfdc_new.sfdc007 = GET_FLDBUF(b_sfdc007)
                  LET l_sfdc_new.sfdc008 = GET_FLDBUF(b_sfdc008)
                  LET l_sfdc_new.sfdc010 = GET_FLDBUF(b_sfdc010)
                  LET l_sfdc_new.sfdc011 = GET_FLDBUF(b_sfdc011)
                  LET l_sfdc_new.sfdc012 = GET_FLDBUF(b_sfdc012)
                  IF NOT cl_null(l_sfdc_new.sfdc012) THEN
                     CALL s_desc_get_stock_desc(g_site,l_sfdc_new.sfdc012) RETURNING l_sfdc_new.sfdc012_desc
                  END IF
                  IF NOT cl_null(l_sfdc_new.sfdc013) THEN
                     CALL s_desc_get_locator_desc(g_site,l_sfdc_new.sfdc012,l_sfdc_new.sfdc013) RETURNING l_sfdc_new.sfdc013_desc
                  END IF               
                  LET l_sfdc_new.sfdc013 = GET_FLDBUF(b_sfdc013)
                  LET l_sfdc_new.sfdc014 = GET_FLDBUF(b_sfdc014)
                  LET l_sfdc_new.sfdc016 = GET_FLDBUF(b_sfdc016)
               
                  UPDATE asfp320_sfdc_tmp SET (seq1,sfdc007,sfdc008,  
                                               sfdc010,sfdc011,sfdc012,sfdc012_desc, 
                                               sfdc013,sfdc013_desc,sfdc014,sfdc016)
                                            = (l_sfdc_new.seq1,l_sfdc_new.sfdc007,l_sfdc_new.sfdc008,  
                                               l_sfdc_new.sfdc010,l_sfdc_new.sfdc011,l_sfdc_new.sfdc012,l_sfdc_new.sfdc012_desc, 
                                               l_sfdc_new.sfdc013,l_sfdc_new.sfdc013_desc,l_sfdc_new.sfdc014,l_sfdc_new.sfdc016)       
                    WHERE seq1 = g_detail_d[l_ac].seq1
                  LET l_sfdd007_new = GET_FLDBUF(b_sfdd007) 
                  LET l_sfdd009_new = GET_FLDBUF(b_sfdd009)
                  LET l_sel_new = GET_FLDBUF(sel)
                  LET l_lockd_new = GET_FLDBUF(lockd)
                  IF l_sfdd007_new <> 0 THEN
                     UPDATE asfp320_sfdd_tmp SET (sel,lockd,sfdd007,sfdd009)
                                               = (l_sel_new,l_lockd_new,l_sfdd007_new,l_sfdd009_new)                
                      WHERE rowno = g_sfdd_d[l_ac3].rowno                   
                  END IF
                  CALL cl_err_collect_init()
                  CALL asfp320_gen_draft() RETURNING r_success
                  CALL cl_err_collect_show()
                  LET l_cnt = 0
                  SELECT COUNT(1) INTO l_cnt FROM asfp320_sfdd_tmp
                   WHERE lockd = 'N'  #排除锁定的资料
                  IF r_success AND g_flag = 'Y' AND l_cnt > 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'asf-00782'  #产生成功
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()  
                     #刷新发料底稿
                     CALL asfp320_b_fill_sfdd()
                     CALL asfp320_b_fill_sfdc()                  
                  ELSE 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'asf-00792'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()                  
                  END IF
               END IF
            END IF         
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
 
{<section id="asfp320.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION asfp320_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_cnt2     LIKE type_t.num5
   DEFINE li_tmp     LIKE type_t.num10
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   
   LET li_tmp = g_wc2.getIndexOf('sfaa',1)   
   IF li_tmp > 0 THEN 
   ELSE
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = 'asf-00796'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()      
      RETURN   
   END IF
   
   LET l_cnt = 0
   SELECT COUNT(1) INTO l_cnt FROM asfp320_sfdc_tmp 
    WHERE 1=1
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF 
   
   LET l_cnt2 = 0 
   SELECT COUNT(1) INTO l_cnt2 FROM asfp320_sfaa_tmp
    WHERE 1=1
   IF cl_null(l_cnt2) THEN LET l_cnt2 = 0 END IF   

   IF l_cnt > 0 OR l_cnt2 > 0 THEN
      IF NOT cl_ask_confirm('asf-00234') THEN
         RETURN 
      ELSE
#         DELETE FROM asfp320_sfdd_tmp
#         CALL g_sfdd_d.clear()         
      END IF
   END IF
   IF cl_null(g_wc2) THEN
      RETURN    
   END IF 
   
   #end add-point
        
   LET g_error_show = 1
   CALL asfp320_b_fill()
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
 
{<section id="asfp320.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION asfp320_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_sql           STRING
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   DELETE FROM asfp320_sfdc_tmp;
   IF cl_null(g_wc) THEN LET g_wc = " 1=1"  END IF
   LET g_sql = " SELECT DISTINCT 'N','','','',imaf001,imaal003,imaal004,'','',imae081,oocal003,'','','','','','','',",
               "        '','','','','','','','','' FROM imaf_t ",
               "   LEFT OUTER JOIN imaal_t ON imafent = imaalent AND imaf001 = imaal001 AND imaal002 = '",g_dlang,"'",
               "   LEFT OUTER JOIN imae_t ON imafent = imaeent AND imaf001 = imae001 AND imafsite = imaesite ",
               "   LEFT OUTER JOIN oocal_t ON imaeent = oocalent AND imae081 = oocal001 AND oocal002 = '",g_dlang,"'",
               "  WHERE imafent = ? ",
               "    AND imafsite = '",g_site,"'",
               "    AND ",g_wc,
               "  ORDER BY imaf001"
#   LET g_sql = " SELECT imaf001 FROM imaf_t ",
#               "  WHERE imafent = ?",
#               "    AND imafsite = '",g_site,"'",
#               "    AND ",g_wc
   #end add-point
 
   PREPARE asfp320_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR asfp320_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
                  
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"

           g_detail_d[l_ac].sel,g_detail_d[l_ac].seq1,g_detail_d[l_ac].sfdcdocno,g_detail_d[l_ac].sfdcseq,g_detail_d[l_ac].sfdc004,                              
           g_detail_d[l_ac].sfdc004_desc,g_detail_d[l_ac].sfdc004_desc_1,g_detail_d[l_ac].sfdc005,g_detail_d[l_ac].sfdc005_desc,                      
           g_detail_d[l_ac].sfdc006,g_detail_d[l_ac].sfdc006_desc,g_detail_d[l_ac].sfdc007,g_detail_d[l_ac].sfdc008,g_detail_d[l_ac].allot,                        
           g_detail_d[l_ac].sfdc009,g_detail_d[l_ac].sfdc009_desc,g_detail_d[l_ac].sfdc010,g_detail_d[l_ac].sfdc011,g_detail_d[l_ac].ck_allot,                     
           g_detail_d[l_ac].sfdc012,g_detail_d[l_ac].sfdc012_desc,g_detail_d[l_ac].sfdc013,g_detail_d[l_ac].sfdc013_desc,g_detail_d[l_ac].sfdc014,                          
           g_detail_d[l_ac].sfdc015,g_detail_d[l_ac].sfdc015_desc,g_detail_d[l_ac].sfdc016 
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
      SELECT MAX(seq1)+1 INTO g_detail_d[l_ac].seq1 FROM asfp320_sfdc_tmp
      IF cl_null(g_detail_d[l_ac].seq1) THEN LET g_detail_d[l_ac].seq1 = 1 END IF
      IF NOT asfp320_get_imaa005(g_detail_d[l_ac].sfdc004) THEN
         IF g_detail_d[l_ac].sfdc005 IS NULL THEN
            LET g_detail_d[l_ac].sfdc005 = ' '
         END IF
      END IF      
      LET g_detail_d[l_ac].allot = 0 
      CALL asfp320_default_sfdc()     
      INSERT INTO asfp320_sfdc_tmp (sel,seq1,sfdcdocno,sfdcseq,sfdc004,sfdc004_desc,sfdc004_desc_1,                 
                                    sfdc005,sfdc005_desc,sfdc006,sfdc006_desc,sfdc007,sfdc008,  
                                    allot,sfdc009,sfdc009_desc,sfdc010,sfdc011,ck_allot,sfdc012,sfdc012_desc, 
                                    sfdc013,sfdc013_desc,sfdc014,sfdc015,sfdc015_desc,sfdc016)
                            VALUES (g_detail_d[l_ac].sel,g_detail_d[l_ac].seq1,g_detail_d[l_ac].sfdcdocno,g_detail_d[l_ac].sfdcseq,g_detail_d[l_ac].sfdc004,g_detail_d[l_ac].sfdc004_desc,g_detail_d[l_ac].sfdc004_desc_1,                 
                                    g_detail_d[l_ac].sfdc005,g_detail_d[l_ac].sfdc005_desc,g_detail_d[l_ac].sfdc006,g_detail_d[l_ac].sfdc006_desc,g_detail_d[l_ac].sfdc007,g_detail_d[l_ac].sfdc008,  
                                    g_detail_d[l_ac].allot,g_detail_d[l_ac].sfdc009,g_detail_d[l_ac].sfdc009_desc,g_detail_d[l_ac].sfdc010,g_detail_d[l_ac].sfdc011,g_detail_d[l_ac].ck_allot,g_detail_d[l_ac].sfdc012,g_detail_d[l_ac].sfdc012_desc, 
                                    g_detail_d[l_ac].sfdc013,g_detail_d[l_ac].sfdc013_desc,g_detail_d[l_ac].sfdc014,g_detail_d[l_ac].sfdc015,g_detail_d[l_ac].sfdc015_desc,g_detail_d[l_ac].sfdc016) 
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins asfp320_sfdc_tmp"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF        
      #end add-point
      
      CALL asfp320_detail_show()      
 
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
   CALL g_detail_d.deleteElement(l_ac)
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE asfp320_sel
   
   LET l_ac = 1
   CALL asfp320_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   IF l_ac = 0 THEN 
      LET l_ac = 1
   END IF
   CALL asfp320_b_fill_sfaa()
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asfp320.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION asfp320_fetch()
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
 
{<section id="asfp320.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION asfp320_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asfp320.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION asfp320_filter()
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
   
   CALL asfp320_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="asfp320.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION asfp320_filter_parser(ps_field)
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
 
{<section id="asfp320.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION asfp320_filter_show(ps_field,ps_object)
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
   LET ls_condition = asfp320_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="asfp320.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL asfp320_set_no_entry_sfdc()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp320_set_no_entry_sfdc()
DEFINE  l_imaa005   LIKE imaa_t.imaa005   
DEFINE  l_imaf055   LIKE imaf_t.imaf055

   IF l_ac > 0 THEN   
      IF NOT cl_null(g_detail_d[l_ac].sfdc004) THEN
         LET l_imaa005 = ''
         SELECT imaa005 INTO l_imaa005 FROM imaa_t
          WHERE imaaent = g_enterprise
            AND imaa001 = g_detail_d[l_ac].sfdc004
         IF cl_null(l_imaa005) THEN
            CALL cl_set_comp_entry("b_sfdc005",FALSE)    
            LET g_detail_d[l_ac].sfdc005 = ' ' 
            LET g_detail_d[l_ac].sfdc005_desc = ' '             
         END IF 
         LET l_imaf055 = ''
         SELECT imaf055 INTO l_imaf055 FROM imaf_t
          WHERE imafent = g_enterprise
            AND imafsite = g_site
            AND imaf001 = g_detail_d[l_ac].sfdc004
         IF l_imaf055 = '2' THEN
            CALL cl_set_comp_entry("b_sfdc016",FALSE)  
            LET g_detail_d[l_ac].sfdc016 = ' ' 
         END IF         
      END IF
      IF g_detail_d[l_ac].sel = 'N' THEN
         CALL cl_set_comp_entry("b_sfdc007,b_sfdc008,b_sfdc009,b_sfdc010,b_sfdc011,b_sfdc012,b_sfdc013,b_sfdc014,b_sfdc016",FALSE)
      END IF      
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL asfp320_set_entry_sfdc()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp320_set_entry_sfdc()
   CALL cl_set_comp_entry("b_sfdc005,b_sfdc016",TRUE)
   CALL cl_set_comp_entry("b_sfdc007,b_sfdc008,b_sfdc010,b_sfdc011,b_sfdc012,b_sfdc013,b_sfdc014",TRUE)
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL asfp320_default_sfdc()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp320_default_sfdc()
DEFINE  l_cnt   LIKE type_t.num5   
   
   IF l_ac > 0 THEN
      SELECT imae081 INTO g_detail_d[l_ac].sfdc006 FROM imae_t
       WHERE imaeent = g_enterprise
         AND imaesite = g_site
         AND imae001 = g_detail_d[l_ac].sfdc004
      CALL s_desc_get_unit_desc(g_detail_d[l_ac].sfdc006)  RETURNING g_detail_d[l_ac].sfdc006_desc   
      
      SELECT imaf015 INTO g_detail_d[l_ac].sfdc009 FROM imaf_t
       WHERE imafent = g_enterprise
         AND imafsite = g_site
         AND imaf001 = g_detail_d[l_ac].sfdc004
      CALL s_desc_get_unit_desc(g_detail_d[l_ac].sfdc009)  RETURNING g_detail_d[l_ac].sfdc009_desc
      #是否存在备料档
      IF NOT cl_null(g_detail_d[l_ac].sfdc004) AND NOT cl_null(g_detail_d[l_ac].sfdc012) THEN
#         LET l_cnt = 0 
#         SELECT COUNT(*) INTO l_cnt FROM sfaa_t,sfba_t
#          WHERE sfbaent = g_enterprise
#            AND sfba006 = g_detail_d[l_ac].sfdc004
#            AND sfba019 = g_detail_d[l_ac].sfdc012
#            AND sfaa
#         IF l_cnt > 0 THEN  #存在备料档
#         END IF          
      END IF
   END IF   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL asfp320_default_sfaa()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp320_default_sfaa()

   IF l_ac2 > 0 THEN
      IF NOT cl_null(g_sfaa_d[l_ac2].sfaadocno) THEN
         SELECT sfaa021,sfaa025,sfaa010,sfaa012,sfaa049,sfaa013 
           INTO g_sfaa_d[l_ac2].sfaa021,g_sfaa_d[l_ac2].sfaa025,g_sfaa_d[l_ac2].sfaa010,g_sfaa_d[l_ac2].sfaa012,g_sfaa_d[l_ac2].sfaa049,g_sfaa_d[l_ac2].sfdd006_2
           FROM sfaa_t
          WHERE sfaaent = g_enterprise
            AND sfaadocno = g_sfaa_d[l_ac2].sfaadocno  
         CALL s_desc_get_item_desc(g_sfaa_d[l_ac2].sfaa010) RETURNING g_sfaa_d[l_ac2].sfaa010_desc,g_sfaa_d[l_ac2].sfaa010_desc_1  
         CALL s_desc_get_unit_desc(g_sfaa_d[l_ac2].sfdd006_2) RETURNING g_sfaa_d[l_ac2].sfdd006_2_desc             
      ELSE
         LET g_sfaa_d[l_ac2].sfaa021 = ''
         LET g_sfaa_d[l_ac2].sfaa025 = ''
         LET g_sfaa_d[l_ac2].sfaa010 = ''
         LET g_sfaa_d[l_ac2].sfaa012 = ''
         LET g_sfaa_d[l_ac2].sfaa049 = ''
         LET g_sfaa_d[l_ac2].sfaa010_desc = ''
         LET g_sfaa_d[l_ac2].sfaa010_desc_1 = ''
         LET g_sfaa_d[l_ac2].sfdd006_2 = ''
         LET g_sfaa_d[l_ac2].sfdd006_2_desc = ''
      END IF
#      DISPLAY BY NAME g_sfaa_d[l_ac2].sfaa021,g_sfaa_d[l_ac2].sfaa025,g_sfaa_d[l_ac2].sfaa010,g_sfaa_d[l_ac2].sfaa012,g_sfaa_d[l_ac2].sfaa049,
#                      g_sfaa_d[l_ac2].sfaa010_desc,g_sfaa_d[l_ac2].sfaa010_desc_1,g_sfaa_d[l_ac2].sfdd006_2,g_sfaa_d[l_ac2].sfdd006_2_desc
       
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL asfp320_sfdc012_chk(p_sfaadocno,p_sfdadocno,p_sfdc)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp320_sfdc012_chk(p_sfaadocno,p_sfdadocno,p_sfdc)
DEFINE  p_sfdadocno  LIKE sfda_t.sfdadocno
DEFINE  p_sfaadocno  LIKE sfaa_t.sfaadocno
DEFINE  p_sfdc       type_g_detail_d
DEFINE  r_success    LIKE type_t.num5
DEFINE  l_success    LIKE type_t.num5
DEFINE  l_flag       LIKE type_t.num5
DEFINE  l_para       LIKE type_t.chr80
DEFINE  l_para2      LIKE type_t.chr80
DEFINE  l_imaf034    LIKE imaf_t.imaf034
DEFINE  l_inaa015    LIKE inaa_t.inaa015
DEFINE  l_inaa010    LIKE inaa_t.inaa010

   LET r_success = TRUE
   IF l_ac > 0 THEN
      #檢核輸入的庫位是否在單據別限制範圍內，若不在限制內則不允許使用此庫位
      CALL s_control_chk_doc('6',p_sfdadocno,p_sfdc.sfdc012,'','','','')
           RETURNING l_success,l_flag
      IF NOT l_success OR NOT l_flag THEN
         #控制组检查错误,请检查单别设定的相关内容
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00122'
         LET g_errparam.extend = p_sfdc.sfdc012
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   
   END IF
   #参数：生產非保稅料號，可由保稅倉發料
   CALL cl_get_doc_para(g_enterprise,g_site,p_sfdadocno,'D-MFG-0031') RETURNING l_para
   #生产料号保税否
   LET l_imaf034 = ''
   SELECT imaf034 INTO l_imaf034
     FROM imaf_t,sfaa_t
    WHERE imafent  = sfaaent
      AND imafsite = g_site
      AND imaf001  = sfaa010
      AND sfaaent  = g_enterprise
      AND sfaadocno= p_sfaadocno
   IF cl_null(l_imaf034) THEN LET l_imaf034 = 'N' END IF
   #當工單的生產料號=非保稅料，不可由保稅倉發料。
   IF l_imaf034='N' AND l_inaa015='Y' AND l_para MATCHES '[12]' THEN #拒绝或警告
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asr-00008'
      LET g_errparam.extend = p_sfdc.sfdc012
      LET g_errparam.popup = TRUE
      CALL cl_err()
      IF l_para = '1' THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   #參數：客供料可由成本倉料領料
   CALL cl_get_doc_para(g_enterprise,g_site,p_sfdadocno,'D-MFG-0052') RETURNING l_para2
   #1.拒絕時，只可輸入非成本倉。(2為警告)
#   IF p_sfdc.sfba028='Y' AND l_inaa010='Y' AND l_para2 MATCHES '[12]' THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = 'asf-00048'
#      LET g_errparam.extend = p_sfdc.sfdc012
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#      IF l_para2 = '1' THEN  #拒绝
#         LET r_success = FALSE
#         RETURN r_success
#      END IF
#   END IF
   
   #发料单做在捡量的检查
   IF g_prog[1,6]='asft31' AND NOT cl_null(p_sfdc.sfdc007) AND NOT cl_null(p_sfdc.sfdc012) THEN  #在捡数量 库位
      IF cl_null(p_sfdc.sfdc016) THEN LET p_sfdc.sfdc016= ' ' END IF  #库存管理特征
      IF cl_null(p_sfdc.sfdc013) THEN LET p_sfdc.sfdc013= ' ' END IF  #储位
      IF cl_null(p_sfdc.sfdc014) THEN LET p_sfdc.sfdc014= ' ' END IF  #批号
      #指定庫位、儲位、批號時，判斷參數是否檢查在檢量，如需檢查在檢量，在庫存數-在檢數不足申請數量時不允許輸入
      #                           据点   料件编号                产品特征                库存管理特征
      CALL s_inventory_check_inan(g_site,p_sfdc.sfdc004,p_sfdc.sfdc005,p_sfdc.sfdc016,
      #                           库位                   储位                    批号
                                  p_sfdc.sfdc012,p_sfdc.sfdc013,p_sfdc.sfdc014,
      #                           交易单位                在捡数量
                                  p_sfdc.sfdc006,p_sfdc.sfdc007,
      #                           单据编号            项次                   项序
                                  '','','0',
      #                           工單單號                 工單項次 
                                  '','') #160408-00035#9-add
           RETURNING l_success,l_flag
      IF NOT l_flag THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF

   RETURN r_success  
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL asfp320_set_required()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp320_set_required()
DEFINE  l_imaf055   LIKE imaf_t.imaf055
DEFINE  l_imaa005   LIKE imaa_t.imaa005

   IF l_ac > 0 THEN  
      IF g_detail_d[l_ac].sel = 'Y' THEN   #勾選
         CALL cl_set_comp_required("b_sfdc012,b_sfdc004,b_sfdc007,b_sfdc008,sfdadocno,sfdadocno_2",TRUE)
         IF NOT cl_null(g_detail_d[l_ac].sfdc004) THEN   
            LET l_imaf055 = ''
            SELECT imaf055 INTO l_imaf055 FROM imaf_t
             WHERE imafent = g_enterprise
               AND imafsite = g_site
               AND imaf001 = g_detail_d[l_ac].sfdc004
            IF l_imaf055 = '1' THEN
               CALL cl_set_comp_required("b_sfdc016",TRUE)
            END IF  
            LET l_imaa005 = ''
            SELECT imaa005 INTO l_imaa005 FROM imaa_t
             WHERE imaaent = g_enterprise
               AND imaa001 = g_detail_d[l_ac].sfdc004
            IF NOT cl_null(l_imaa005) THEN   
               CALL cl_set_comp_required("b_sfdc005",TRUE)  
               IF cl_null(g_detail_d[l_ac].sfdc005) THEN
                  LET g_detail_d[l_ac].sfdc005 = ''
               END IF               
            END IF             
         END IF
      END IF 
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL asfp320_set_no_required()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp320_set_no_required()
   CALL cl_set_comp_required("b_sfdc004,b_sfdc012,b_sfdc005,b_sfdc016,b_sfdc007,b_sfdc008,sfdadocno,sfdadocno_2",FALSE)
END FUNCTION

################################################################################
# Descriptions...: 發料料號+產品特徵+庫位不可重複
# Memo...........:
# Usage..........: CALL asfp320_key_chk(p_sfdc004,p_sfdc005,p_sfdc012) 
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp320_key_chk(p_sfdc004,p_sfdc005,p_sfdc012)
DEFINE  p_sfdc004   LIKE sfdc_t.sfdc004
DEFINE  p_sfdc005   LIKE sfdc_t.sfdc005
DEFINE  p_sfdc012   LIKE sfdc_t.sfdc012
DEFINE  l_cnt       LIKE type_t.num5
DEFINE  r_success   LIKE type_t.num5

   LET r_success = TRUE
   IF cl_null(p_sfdc005) THEN LET p_sfdc005 = ' ' END IF
   IF NOT cl_null(p_sfdc004) AND NOT cl_null(p_sfdc012) AND p_sfdc005 IS NOT NULL THEN
      LET l_cnt = 0
      SELECT COUNT(1) INTO l_cnt FROM asf320_sfdc_tmp
       WHERE sfdc004 = p_sfdc004
         AND sfdc005 = p_sfdc005
         AND sfdc012 = p_sfdc012
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      IF l_cnt > 0 THEN  #key 重复
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00790'
         LET g_errparam.extend = ""
         LET g_errparam.replace[1] = p_sfdc004
         LET g_errparam.replace[2] = p_sfdc005
         LET g_errparam.replace[3] = p_sfdc012         
         LET g_errparam.popup = TRUE
         CALL cl_err()      
         LET r_success = FALSE
      END IF
   ELSE
      LET r_success = TRUE  
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 創建臨時表
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp320_create_tmp()
DEFINE  r_success    LIKE type_t.num5

   LET r_success = FALSE
   CALL asfp320_drop_tmp()
   CREATE TEMP TABLE asfp320_sfdc_tmp(
      sel             LIKE type_t.chr1,
      seq1            LIKE sfdc_t.sfdcseq,
      sfdcdocno       LIKE sfdc_t.sfdcdocno,
      sfdcseq         LIKE sfdc_t.sfdcseq,
      sfdc004         LIKE sfdc_t.sfdc004,      
      sfdc004_desc    LIKE type_t.chr500,
      sfdc004_desc_1  LIKE type_t.chr500,
      sfdc005         LIKE sfdc_t.sfdc005,
      sfdc005_desc    LIKE type_t.chr500,
      sfdc006         LIKE sfdc_t.sfdc006,
      sfdc006_desc    LIKE type_t.chr500,
      sfdc007         LIKE sfdc_t.sfdc007,
      sfdc008         LIKE sfdc_t.sfdc008,
      allot           LIKE sfdc_t.sfdc008,
      sfdc009         LIKE sfdc_t.sfdc009,
      sfdc009_desc    LIKE type_t.chr500, 
      sfdc010         LIKE sfdc_t.sfdc010,
      sfdc011         LIKE sfdc_t.sfdc011,
      ck_allot        LIKE sfdc_t.sfdc011,
      sfdc012         LIKE sfdc_t.sfdc012,
      sfdc012_desc    LIKE type_t.chr500,       
      sfdc013         LIKE sfdc_t.sfdc013,
      sfdc013_desc    LIKE type_t.chr500, 
      sfdc014         LIKE sfdc_t.sfdc014,
      sfdc015         LIKE sfdc_t.sfdc015,
      sfdc015_desc    LIKE type_t.chr500, 
      sfdc016         LIKE sfdc_t.sfdc016   
      );  #add seq1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'asfp320_sfdc_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   
   CREATE UNIQUE INDEX asfp320_sfdc_tmp_01 ON asfp320_sfdc_tmp (seq1,sfdc004,sfdc005,sfdc012)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create index'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   
   CREATE TEMP TABLE asfp320_sfaa_tmp(
      sel02                  LIKE type_t.chr1,
      sfaadocno              LIKE sfaa_t.sfaadocno,
      sfaa021                LIKE sfaa_t.sfaa021,
      sfaa025                LIKE sfaa_t.sfaa025,
      sfaa010                LIKE sfaa_t.sfaa010,
      sfaa010_desc           LIKE type_t.chr500, 
      sfaa010_desc_1         LIKE type_t.chr500, 
      sfaa012                LIKE sfaa_t.sfaa012,
      sfaa049                LIKE sfaa_t.sfaa049,
      sfdd006_2              LIKE sfdd_t.sfdd006,
      sfdd006_2_desc         LIKE type_t.chr500      
      );

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'asfp320_sfaa_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   CREATE UNIQUE INDEX asfp320_sfaa_tmp_01 ON asfp320_sfaa_tmp (sfaadocno)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create index asfp320_sfaa_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   
   CREATE TEMP TABLE asfp320_sfdd_tmp(
      sel                    LIKE type_t.chr1,
      lockd                  LIKE type_t.chr1,
      rowno                  LIKE sfdd_t.sfddseq,
      sfdddocno              LIKE sfdd_t.sfdddocno,
      sfddseq                LIKE sfdd_t.sfddseq,
      sfddseq1               LIKE sfdd_t.sfddseq1,
      sfaadocno            LIKE sfaa_t.sfaadocno,
      l_sfaa010              LIKE sfaa_t.sfaa010,
      sfdd001                LIKE sfdd_t.sfdd001,
      sfdd001_desc           LIKE type_t.chr500, 
      sfdd001_desc_1         LIKE type_t.chr500, 
      sfdd013                LIKE sfdd_t.sfdd013,
      sfdd013_desc           LIKE type_t.chr500,
      sfdd006                LIKE sfdd_t.sfdd006,
      sfdd006_desc           LIKE type_t.chr500, 
      sfba023                LIKE sfba_t.sfba023,
      sfba016                LIKE sfba_t.sfba016,
      nosend                 LIKE sfba_t.sfba016,
      sfdd007                LIKE sfdd_t.sfdd007,
      sfdd008                LIKE sfdd_t.sfdd008,
      sfdd008_desc           LIKE type_t.chr500,
      sfdd009                LIKE sfdd_t.sfdd009,
      sfdd003                LIKE sfdd_t.sfdd003,
      sfdd003_desc           LIKE type_t.chr500,
      sfdd004                LIKE sfdd_t.sfdd004,
      sfdd004_desc           LIKE type_t.chr500,
      sfdd005                LIKE sfdd_t.sfdd005,
      sfdd010                LIKE sfdd_t.sfdd010,
      sfba009                LIKE sfba_t.sfba009      
      );  #add seq1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'asfp320_sfdd_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF   
   
   CREATE UNIQUE INDEX asfp320_sfdd_tmp_01 ON asfp320_sfdd_tmp (rowno,sfaadocno,sfdd001)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create index asfp320_sfdd_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF  
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: drop tmpe table
# Memo...........:
# Usage..........: CALL asfp320_drop_tmp()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp320_drop_tmp()
   WHENEVER ERROR CONTINUE
   DROP TABLE asfp320_sfdc_tmp;
   DROP TABLE asfp320_sfaa_tmp;
   DROP TABLE asfp320_sfdd_tmp;
END FUNCTION

################################################################################
# Descriptions...: 產生底稿
# Memo...........:
# Usage..........: CALL asfp320_gen_draft()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp320_gen_draft()
DEFINE   l_sfdc        type_g_detail_d
DEFINE   l_sfaa        type_g_sfaa_d
DEFINE   l_sfdd        type_g_sfdd_d 
DEFINE   l_cnt         LIKE type_t.num5
DEFINE   l_cnt2        LIKE type_t.num5
DEFINE   l_sum_sfdd007 LIKE sfdd_t.sfdd007
DEFINE   l_count       LIKE type_t.num5
DEFINE   l_sfaa_count  LIKE type_t.num5
DEFINE   l_lock_count  LIKE type_t.num5
DEFINE   l_max_nosend  LIKE sfdd_t.sfdd007
DEFINE   l_sfaadocno_max     LIKE sfaa_t.sfaadocno
DEFINE   l_sfaa004     LIKE sfaa_t.sfaa004
DEFINE   s_sfdd007     LIKE sfdd_t.sfdd007
DEFINE   r_success     LIKE type_t.num5
DEFINE   l_success     LIKE type_t.num5
DEFINE   l_ooba002     LIKE ooba_t.ooba002
DEFINE   l_tz_num      LIKE sfdd_t.sfdd007
DEFINE   l_num         LIKE type_t.num10
DEFINE   l_sql         STRING
DEFINE   l_sql2        STRING

   LET g_flag = 'N'
   LET r_success = TRUE

   IF cl_null(g_sfdadocno) OR cl_null(g_sfdadocno_2) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00789'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()   
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   LET l_sql = " SELECT * FROM asfp320_sfaa_tmp ",
               "  WHERE 1 = 1",
               "    AND sel02 = 'Y'",
               "  ORDER BY sfaadocno"
   PREPARE asfp320_sel_sfaa_pre FROM l_sql
   DECLARE asfp320_sel_sfaa_cus CURSOR FOR asfp320_sel_sfaa_pre  
   
   LET l_sql2 = " SELECT * FROM asfp320_sfdc_tmp ",
                "  WHERE 1 = 1",
                "    AND sel = 'Y'",
                "  ORDER BY sfdc004,sfdc005,sfdc012"   
   PREPARE asfp320_sel_sfdc_pre FROM l_sql2
   DECLARE asfp320_sel_sfdc_cus CURSOR FOR asfp320_sel_sfdc_pre 
      
   #产生底稿之前删除资料
   DELETE FROM asfp320_sfdd_tmp
         WHERE lockd = 'N'
         
   #依工单单号，发料料号依次遍历
   FOREACH asfp320_sel_sfaa_cus INTO l_sfaa.*
      LET g_para = ''
      #检查参数D-MFG-0050工單指定發料庫儲，發料時允許修改
      CALL s_aooi200_get_slip(l_sfaa.sfaadocno) RETURNING l_success,l_ooba002
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      CALL cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-MFG-0050')
         RETURNING g_para  #工單指定發料庫儲，發料時允許修改  
         
      SELECT sfaa004 INTO l_sfaa004 FROM sfaa_t
       WHERE sfaaent = g_enterprise
         AND sfaadocno = l_sfaa.sfaadocno
         

      FOREACH asfp320_sel_sfdc_cus INTO l_sfdc.*    
         LET g_flag = 'Y'      
         SELECT MAX(rowno)+1 INTO l_sfdd.rowno FROM asfp320_sfdd_tmp
           WHERE 1 =1 
         IF cl_null(l_sfdd.rowno) THEN LET l_sfdd.rowno = 1 END IF  
         #是否存在底稿
         LET l_cnt = 0                 
         SELECT COUNT(1) INTO l_cnt FROM asfp320_sfdd_tmp
          WHERE sfaadocno = l_sfaa.sfaadocno
            AND sfdd001 = l_sfdc.sfdc004
            AND sfdd013 = l_sfdc.sfdc005
            AND sfdd003 = l_sfdc.sfdc012  
         IF l_cnt > 0 THEN
            CONTINUE FOREACH
         END IF
         #檢查倉庫是否符合條件,工单是预先发料OR倒扣料
         IF l_sfaa004 = '1' THEN  #预先发料
            IF NOT asfp320_sfdc012_chk(l_sfaa.sfaadocno,g_sfdadocno,l_sfdc.*) THEN
               CONTINUE FOREACH
            END IF
            LET l_sfdd.sfba009 = 'N'
         END IF
         IF l_sfaa004 = '2' THEN  #倒扣料
            IF NOT asfp320_sfdc012_chk(l_sfaa.sfaadocno,g_sfdadocno_2,l_sfdc.*) THEN
               CONTINUE FOREACH
            END IF 
            LET l_sfdd.sfba009 = 'Y'            
         END IF
         #欄位賦值          
         LET l_sfdd.sel = 'N'
         LET l_sfdd.lockd = 'N'
         LET l_sfdd.sfaadocno = l_sfaa.sfaadocno
         LET l_sfdd.sfdd001 = l_sfdc.sfdc004
         LET l_sfdd.sfdd001_desc = l_sfdc.sfdc004_desc
         LET l_sfdd.sfdd001_desc_1 = l_sfdc.sfdc004_desc_1
         LET l_sfdd.sfdd013 = l_sfdc.sfdc005
         LET l_sfdd.sfdd013_desc = l_sfdc.sfdc005_desc
         LET l_sfdd.sfdd006 = l_sfdc.sfdc006
         LET l_sfdd.sfdd006_desc = l_sfdc.sfdc006_desc    
          
         IF g_para = 'N' THEN   # 仓库不允许修改             
            LET l_cnt = 0
            SELECT COUNT(1) INTO l_cnt FROM sfba_t
             WHERE sfbaent = g_enterprise
               AND sfbadocno = l_sfaa.sfaadocno
               AND sfba006 = l_sfdc.sfdc004
               AND sfba021 = l_sfdc.sfdc005
            IF l_cnt > 0 THEN  #有备料
               LET l_cnt2 = 0 
               #有备料仓库没有指定
               SELECT COUNT(1) INTO l_cnt2 FROM sfba_t
                WHERE sfbaent = g_enterprise
                  AND sfbadocno = l_sfaa.sfaadocno
                  AND sfba006 = l_sfdc.sfdc004
                  AND sfba021 = l_sfdc.sfdc005
                  AND (sfba019 IS NULL OR sfba019 = ' ')

               IF l_cnt2 > 0 THEN  #有备料且仓库没有指定，更新
                  SELECT DISTINCT sfba013,sfba016,sfba009 INTO l_sfdd.sfba023,l_sfdd.sfba016,l_sfdd.sfba009 FROM sfba_t
                   WHERE sfbaent = g_enterprise
                     AND sfbadocno = l_sfaa.sfaadocno
                     AND sfba006 = l_sfdc.sfdc004
                     AND sfba021 = l_sfdc.sfdc005
                  #未发数量            应发数量          已发数量 
                  LET l_sfdd.nosend = l_sfdd.sfba023 - l_sfdd.sfba016 
                  #事先發料控管不可以大於未發數量
                  IF l_sfdd.nosend <= 0 THEN
                  END IF                  
               ELSE
                  LET l_cnt = 0
                  SELECT COUNT(1) INTO l_cnt FROM sfba_t
                   WHERE sfbaent = g_enterprise
                     AND sfbadocno = l_sfaa.sfaadocno
                     AND sfba006 = l_sfdc.sfdc004
                     AND sfba021 = l_sfdc.sfdc005
                     AND sfba019 = l_sfdc.sfdc012 
                  IF l_cnt > 0 THEN  #现仓库与指定库位相符
                     SELECT DISTINCT sfba013,sfba016,sfba009 INTO l_sfdd.sfba023,l_sfdd.sfba016,l_sfdd.sfba009 FROM sfba_t
                      WHERE sfbaent = g_enterprise
                        AND sfbadocno = l_sfaa.sfaadocno
                        AND sfba006 = l_sfdc.sfdc004
                        AND sfba021 = l_sfdc.sfdc005
                        AND sfba019 = l_sfdc.sfdc012 
                     #未发数量            应发数量          已发数量 
                     LET l_sfdd.nosend = l_sfdd.sfba023 - l_sfdd.sfba016  
                  ELSE
                     #现仓库与指定库位不相符
                     #CONTINUE FOREACH
                  END IF 
               END IF  
            ELSE               
               #不存在工单备料
               LET l_sfdd.sfba023 = 0
               LET l_sfdd.sfba016 = 0
               LET l_sfdd.nosend = 0             
            END IF            
         ELSE
            LET l_cnt = 0
            SELECT COUNT(1) INTO l_cnt FROM sfba_t
             WHERE sfbaent = g_enterprise
               AND sfbadocno = l_sfaa.sfaadocno
               AND sfba006 = l_sfdc.sfdc004
               AND sfba021 = l_sfdc.sfdc005
               
            IF l_cnt > 0 THEN  #有备料更新
               SELECT DISTINCT sfba013,sfba016,sfba009 INTO l_sfdd.sfba023,l_sfdd.sfba016,l_sfdd.sfba009 FROM sfba_t
                WHERE sfbaent = g_enterprise
                  AND sfbadocno = l_sfaa.sfaadocno
                  AND sfba006 = l_sfdc.sfdc004
                  AND sfba021 = l_sfdc.sfdc005
               #未发数量            应发数量          已发数量 
               LET l_sfdd.nosend = l_sfdd.sfba023 - l_sfdd.sfba016      
            ELSE
               #不存在工单备料
               LET l_sfdd.sfba023 = 0
               LET l_sfdd.sfba016 = 0
               LET l_sfdd.nosend = 0             
            END IF          
         
         END IF
         #LET l_sfdd.sfdd007 = 0
         LET l_sfdd.sfdd008 = l_sfdc.sfdc009
         LET l_sfdd.sfdd008_desc = l_sfdc.sfdc009_desc
         #分配数量
         #待分配量計算
         SELECT SUM(sfdd007) INTO l_sum_sfdd007 FROM asfp320_sfdd_tmp
          WHERE sfdd003 = l_sfdc.sfdc012
            AND sfdd001 = l_sfdc.sfdc004
            AND sfdd013 = l_sfdc.sfdc005
            AND lockd = 'Y'
         IF cl_null(l_sum_sfdd007) THEN LET l_sum_sfdd007 = 0 END IF
         
         SELECT COUNT(sfdd007) INTO l_lock_count FROM asfp320_sfdd_tmp
          WHERE sfdd003 = l_sfdc.sfdc012
            AND sfdd001 = l_sfdc.sfdc004
            AND sfdd013 = l_sfdc.sfdc005
            AND lockd = 'Y'
         IF cl_null(l_lock_count) THEN LET l_lock_count = 0 END IF            
         
         SELECT COUNT(1) INTO l_sfaa_count FROM asfp320_sfaa_tmp
          WHERE sel02 = 'Y'
         IF cl_null(l_sfaa_count) THEN LET l_sfaa_count = 0 END IF          
         #每张工单待分配量
         LET l_sfdd.sfdd007 = (l_sfdc.sfdc008 - l_sum_sfdd007)/(l_sfaa_count - l_lock_count)
         #批序号取整
         #IF s_lot_batch_number(l_sfdc.sfdc004,g_site) THEN  #走批序号管理         
            CALL s_num_round(3,l_sfdd.sfdd007,'') RETURNING l_num
            LET l_sfdd.sfdd007 = l_num
         #END IF
         #單位換算       
         IF NOT cl_null(l_sfdd.sfdd008) THEN
            CALL s_aooi250_convert_qty(l_sfdd.sfdd001,l_sfdd.sfdd006,
                                       l_sfdd.sfdd008,l_sfdd.sfdd007) 
                 RETURNING l_success,l_sfdd.sfdd009   
         END IF 
         #仓储批          
         LET l_sfdd.sfdd003 = l_sfdc.sfdc012
         LET l_sfdd.sfdd003_desc = l_sfdc.sfdc012_desc
         LET l_sfdd.sfdd004 = l_sfdc.sfdc013
         LET l_sfdd.sfdd004_desc = l_sfdc.sfdc013_desc 
         LET l_sfdd.sfdd005 = l_sfdc.sfdc014
         LET l_sfdd.sfdd010 = l_sfdc.sfdc016
         LET l_sfdd.sfaa010 = l_sfaa.sfaa010
         IF l_sfdd.sfdd013 IS NULL THEN
            LET l_sfdd.sfdd013 = ' '
         END IF
         #寫入底稿臨時表
         IF cl_null(l_sfdd.sfba023) THEN               
            LET l_sfdd.sfba023 = 0
         END IF
         IF cl_null(l_sfdd.sfba016) THEN         
            LET l_sfdd.sfba016 = 0
         END IF 
         IF cl_null(l_sfdd.nosend) THEN         
            LET l_sfdd.nosend = 0 
         END IF               
         INSERT INTO asfp320_sfdd_tmp (sel,lockd,rowno,sfdddocno,sfddseq,sfddseq1,sfaadocno,l_sfaa010,sfdd001,sfdd001_desc,sfdd001_desc_1,sfdd013,                 
                                       sfdd013_desc,sfdd006,sfdd006_desc,sfba023,sfba016,nosend,sfdd007,sfdd008,sfdd008_desc,sfdd009,
                                       sfdd003,sfdd003_desc,sfdd004,sfdd004_desc,sfdd005,sfdd010,sfba009)
                                VALUES (l_sfdd.sel,l_sfdd.lockd,l_sfdd.rowno,l_sfdd.sfdddocno,l_sfdd.sfddseq,l_sfdd.sfddseq1,l_sfdd.sfaadocno,l_sfdd.sfaa010,l_sfdd.sfdd001,l_sfdd.sfdd001_desc,l_sfdd.sfdd001_desc_1,l_sfdd.sfdd013,                 
                                       l_sfdd.sfdd013_desc,l_sfdd.sfdd006,l_sfdd.sfdd006_desc,l_sfdd.sfba023,l_sfdd.sfba016,l_sfdd.nosend,l_sfdd.sfdd007,l_sfdd.sfdd008,l_sfdd.sfdd008_desc,l_sfdd.sfdd009,
                                       l_sfdd.sfdd003,l_sfdd.sfdd003_desc,l_sfdd.sfdd004,l_sfdd.sfdd004_desc,l_sfdd.sfdd005,l_sfdd.sfdd010,l_sfdd.sfba009)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "ins asfp320_sfdd_tmp" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()            
            LET r_success = FALSE
         END IF     
      END FOREACH
     
   END FOREACH
   
   LET l_sql = " SELECT * FROM asfp320_sfdc_tmp ",
               "  WHERE 1 =1 ",
               "    AND sel = 'Y' ",
               "  ORDER BY sfdc004,sfdc005,sfdc012 "
   PREPARE asfp320_sel_sfdc_pre2 FROM l_sql
   DECLARE asfp320_sel_sfdc_cus2 CURSOR FOR asfp320_sel_sfdc_pre2 
   

   FOREACH asfp320_sel_sfdc_cus2 INTO l_sfdc.*
      IF l_sfdc.sfdc005 IS NULL THEN
         LET l_sfdc.sfdc005 = ' '
      END IF
      SELECT SUM(sfdd007) INTO s_sfdd007 FROM asfp320_sfdd_tmp
       WHERE sfdd001 = l_sfdc.sfdc004
         AND sfdd013 = l_sfdc.sfdc005
         AND sfdd003 = l_sfdc.sfdc012

      IF cl_null(s_sfdd007) THEN
         LET s_sfdd007 = 0
      END IF
      LET l_tz_num = l_sfdc.sfdc008 - s_sfdd007
      
      #存在差异
      IF l_tz_num <> 0 THEN
         #全部分配完後若已分配數量與調整後申請數量有小數尾差，將數量最大的一筆做調整，使調整後申請數量與已分配數量相同
         SELECT MAX(nosend) INTO l_max_nosend FROM  asfp320_sfdd_tmp     
          WHERE sfdd001 = l_sfdc.sfdc004
            AND sfdd013 = l_sfdc.sfdc005
            AND sfdd003 = l_sfdc.sfdc012 
            AND lockd = 'N'            
          GROUP BY sfdd001,sfdd013,sfdd003  
          
         SELECT DISTINCT sfaadocno INTO l_sfaadocno_max FROM asfp320_sfdd_tmp   
          WHERE sfdd001 = l_sfdc.sfdc004
            AND sfdd013 = l_sfdc.sfdc005
            AND sfdd003 = l_sfdc.sfdc012 
            AND nosend = l_max_nosend
            AND lockd = 'N'     
         #更新   
         UPDATE asfp320_sfdd_tmp SET sfdd007 = l_sfdd.sfdd007 + l_tz_num
          WHERE sfdd001 = l_sfdc.sfdc004
            AND sfdd013 = l_sfdc.sfdc005
            AND sfdd003 = l_sfdc.sfdc012 
            AND sfaadocno = l_sfaadocno_max
            AND nosend = l_max_nosend
            AND lockd = 'N'  
            AND ROWNUM = 1
      END IF
      #更新需求页签分配数量
      UPDATE asfp320_sfdc_tmp SET allot = l_sfdc.sfdc008
       WHERE sfdc004 = l_sfdc.sfdc004
         AND sfdc005 = l_sfdc.sfdc005
         AND sfdc012 = l_sfdc.sfdc012      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "upd asfp320_sfdc_tmp" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()            
         LET r_success = FALSE
      END IF            
   END FOREACH
   
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 删除底稿
# Memo...........:
# Usage..........: CALL asfp320_delete_draft()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp320_delete_draft()
   IF cl_ask_confirm('asf-00776') THEN
      DELETE FROM asfp320_sfdd_tmp 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00778'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()       
      ELSE
         #删除成功
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00777'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err() 
         CALL g_sfdd_d.clear()         
      END IF      
   END IF    
END FUNCTION

################################################################################
# Descriptions...: 批處理
# Memo...........:
# Usage..........: CALL asfp320_process()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp320_process()
DEFINE  r_success  LIKE type_t.num5
DEFINE  l_success  LIKE type_t.num5
DEFINE  l_cnt      LIKE type_t.num5
DEFINE  l_i        LIKE type_t.num5

   IF cl_null(g_sfdadocno) OR cl_null(g_sfdadocno_2) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00789'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()   
      RETURN 
   END IF
   LET l_cnt = 0
   SELECT COUNT(1) INTO l_cnt FROM asfp320_sfdd_tmp
    WHERE 1=1
   IF cl_null(l_cnt) THEN 
      LET l_cnt = 0
   END IF
   IF l_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00794'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()   
      RETURN 
   END IF
   #檢核分配總量=調整后申請數量
   #CALL cl_err_collect_init() 
   CALL asfp320_send_chk() RETURNING l_success
   #CALL cl_err_collect_show()   
   IF NOT l_success THEN 
      RETURN 
   END IF
   ##插入需处理的资料，同时检查是否有选择产生资料
   #检查是否有选择产生资料
   LET l_cnt = 0
   FOR l_i = 1 TO g_sfdd_d.getLength()
       IF g_sfdd_d[l_i].sel = 'Y' THEN
          LET l_cnt = l_cnt + 1
          EXIT FOR
       END IF
   END FOR
#   CALL g_sfdd_d.deleteElement(l_i)
#   LET l_i = l_i - 1
   IF l_cnt = 0 THEN
      #无可产生的数据，请先选择数据
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00242'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   
   #產生發料資料
   CALL asfp320_gen_asft310()  
END FUNCTION

################################################################################
# Descriptions...: 工單資訊頁簽填充
# Memo...........:
# Usage..........: CALL asfp320_b_fill_sfaa()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp320_b_fill_sfaa()
DEFINE  l_sfaa       type_g_sfaa_d
DEFINE  l_sfaa004    LIKE sfaa_t.sfaa004
DEFINE  l_sfaa050    LIKE sfaa_t.sfaa050
DEFINE  li_tmp       LIKE type_t.num10
DEFINE  l_sql        STRING
      
   DELETE FROM asfp320_sfaa_tmp;      
   IF cl_null(g_wc2) THEN LET g_wc2 = " 1=1" END IF 
   LET li_tmp = g_wc2.getIndexOf('sfaa',1)   
   IF li_tmp > 0 THEN 
   ELSE
      RETURN   
   END IF
   LET l_sql = " SELECT sfaadocno,sfaa021,sfaa025,sfaa010,t1.imaal003,t1.imaal004,sfaa012,sfaa049,sfaa013,t2.oocal003,sfaa004,sfaa050 ",
               "   FROM sfaa_t ",
               "   LEFT OUTER JOIN imaal_t t1 ON sfaaent = t1.imaalent AND sfaa010 = t1.imaal001 AND t1.imaal002 = '",g_dlang,"'",
               "   LEFT OUTER JOIN oocal_t t2 ON sfaaent = t2.oocalent AND sfaa013 = t2.oocal001 AND t2.oocal002 = '",g_dlang,"'",
               "  WHERE sfaaent = ",g_enterprise,
               "    AND sfaasite = '",g_site,"'",
               "    AND sfaa003 = '5'",
               "    AND sfaastus ='F'",
               #"    AND sfaa065 NOT IN ('1','2') ", #未结案
               "    AND (sfaa065 IS NULL OR sfaa065 = '0')",
               "    AND ",g_wc2
   PREPARE asfp320_fill_sfaa_pre FROM l_sql
   DECLARE asfp320_fill_sfaa_cus CURSOR FOR asfp320_fill_sfaa_pre   
   
   CALL g_sfaa_d.clear()
   LET l_ac2 = 1   
   
   FOREACH asfp320_fill_sfaa_cus INTO g_sfaa_d[l_ac2].sfaadocno,g_sfaa_d[l_ac2].sfaa021,g_sfaa_d[l_ac2].sfaa025,g_sfaa_d[l_ac2].sfaa010,g_sfaa_d[l_ac2].sfaa010_desc,                                                      
                                      g_sfaa_d[l_ac2].sfaa010_desc_1,g_sfaa_d[l_ac2].sfaa012,g_sfaa_d[l_ac2].sfaa049,
                                      g_sfaa_d[l_ac2].sfdd006_2,g_sfaa_d[l_ac2].sfdd006_2_desc,l_sfaa004,l_sfaa050                                   
                                                      
#      #工单是否符合条件
#      INITIALIZE g_chkparam.* TO NULL      
#      #設定g_chkparam.*的參數
#      LET g_chkparam.arg1 = g_sfaa_d[l_ac2].sfaadocno      
#      #呼叫檢查存在並帶值的library
#      IF NOT cl_chk_exist("v_sfaadocno_6") THEN
#         CONTINUE FOREACH
#      END IF 
      #工單是否為倒扣料
#      IF l_sfaa004 = '2' THEN  #倒扣料
#         #必須有入庫資料
#         IF l_sfaa050 <= 0 THEN
#            CONTINUE FOREACH
#         END IF         
#      END IF
      LET g_sfaa_d[l_ac2].sel02 = 'N'               
      INSERT INTO asfp320_sfaa_tmp (sel02,sfaadocno,sfaa021,sfaa025,sfaa010,sfaa010_desc,sfaa010_desc_1,
                                    sfaa012,sfaa049,sfdd006_2,sfdd006_2_desc)
                            VALUES (g_sfaa_d[l_ac2].sel02,g_sfaa_d[l_ac2].sfaadocno,g_sfaa_d[l_ac2].sfaa021,g_sfaa_d[l_ac2].sfaa025,g_sfaa_d[l_ac2].sfaa010,g_sfaa_d[l_ac2].sfaa010_desc,g_sfaa_d[l_ac2].sfaa010_desc_1,
                                    g_sfaa_d[l_ac2].sfaa012,g_sfaa_d[l_ac2].sfaa049,g_sfaa_d[l_ac2].sfdd006_2,g_sfaa_d[l_ac2].sfdd006_2_desc) 
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins asfp320_sfaa_tmp"
         LET g_errparam.popup = TRUE
         CALL cl_err()                                                    
      END IF                     
      LET l_ac2 = l_ac2 + 1
   END FOREACH
   CALL g_sfaa_d.deleteElement(l_ac2)
   LET l_ac2 = l_ac2 - 1   
END FUNCTION

################################################################################
# Descriptions...: 显示发料底稿
# Memo...........:
# Usage..........: CALL asfp320_b_fill_sfdd()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp320_b_fill_sfdd()
DEFINE  l_sql    STRING
   
   CALL g_sfdd_d.clear()
   LET l_sql = " SELECT * FROM asfp320_sfdd_tmp ",
               "  WHERE 1= 1",
               "  ORDER BY rowno "
   PREPARE asfp320_sel_sfdd_pre FROM l_sql
   DECLARE asfp320_sel_sfdd_cur CURSOR FOR asfp320_sel_sfdd_pre  
   LET g_cnt3 = l_ac3
   LET l_ac3 = 1
   FOREACH asfp320_sel_sfdd_cur INTO g_sfdd_d[l_ac3].*
      
      LET l_ac3 = l_ac3 + 1
   END FOREACH
   CALL g_sfdd_d.deleteElement(l_ac3)
   #LET l_ac3 = l_ac3 - 1
   LET l_ac3 = g_cnt3
END FUNCTION

################################################################################
# Descriptions...: 分配数量与申请调整后数量是否相等
# Memo...........:
# Usage..........: CALL asfp320_send_chk()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp320_send_chk()
DEFINE  l_sql       STRING   
DEFINE  l_sfdc      type_g_detail_d 
DEFINE  r_success   LIKE type_t.num5
DEFINE  s_sfdd007   LIKE sfdd_t.sfdd007


   LET r_success = TRUE
   LET l_sql = " SELECT * FROM asfp320_sfdc_tmp ",
               "  WHERE 1 =1 ",
               "  ORDER BY sfdc004,sfdc005,sfdc012 "
   PREPARE asfp320_sel_sfdc_pre3 FROM l_sql
   DECLARE asfp320_sel_sfdc_cus3 CURSOR FOR asfp320_sel_sfdc_pre3 
   

   FOREACH asfp320_sel_sfdc_cus3 INTO l_sfdc.*
      SELECT SUM(sfdd007) INTO s_sfdd007 FROM asfp320_sfdd_tmp
       WHERE sfdd001 = l_sfdc.sfdc004
         AND sfdd013 = l_sfdc.sfdc005
         AND sfdd003 = l_sfdc.sfdc012

      IF cl_null(s_sfdd007) THEN
         LET s_sfdd007 = 0
      END IF
      #存在差异
      IF l_sfdc.sfdc008 <> s_sfdd007  THEN      
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.code   = 'asf-00781'
         LET g_errparam.replace[1] = l_sfdc.sfdc004
         LET g_errparam.replace[2] = l_sfdc.sfdc005
         LET g_errparam.replace[3] = l_sfdc.sfdc012
         LET g_errparam.popup  = TRUE 
         CALL cl_err()            
         LET r_success = FALSE
      END IF            
   END FOREACH

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 产生发料单
# Memo...........:
# Usage..........: CALL asfp320_gen_asft310()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp320_gen_asft310()
DEFINE  r_success      LIKE type_t.num5
DEFINE  l_success      LIKE type_t.num5
DEFINE  l_sfdd         type_g_sfdd_d
#161109-00085#40-s
#DEFINE  l_sfba         RECORD LIKE sfba_t.*
DEFINE l_sfba RECORD  #工單備料單身檔
       sfbaent LIKE sfba_t.sfbaent, #企業編號
       sfbasite LIKE sfba_t.sfbasite, #營運據點
       sfbadocno LIKE sfba_t.sfbadocno, #單號
       sfbaseq LIKE sfba_t.sfbaseq, #項次
       sfbaseq1 LIKE sfba_t.sfbaseq1, #項序
       sfba001 LIKE sfba_t.sfba001, #上階料號
       sfba002 LIKE sfba_t.sfba002, #部位
       sfba003 LIKE sfba_t.sfba003, #作業編號
       sfba004 LIKE sfba_t.sfba004, #作業序
       sfba005 LIKE sfba_t.sfba005, #BOM料號
       sfba006 LIKE sfba_t.sfba006, #發料料號
       sfba007 LIKE sfba_t.sfba007, #投料時距
       sfba008 LIKE sfba_t.sfba008, #必要特性
       sfba009 LIKE sfba_t.sfba009, #倒扣料
       sfba010 LIKE sfba_t.sfba010, #標準QPA分子
       sfba011 LIKE sfba_t.sfba011, #標準QPA分母
       sfba012 LIKE sfba_t.sfba012, #允許誤差率
       sfba013 LIKE sfba_t.sfba013, #應發數量
       sfba014 LIKE sfba_t.sfba014, #單位
       sfba015 LIKE sfba_t.sfba015, #委外代買數量
       sfba016 LIKE sfba_t.sfba016, #已發數量
       sfba017 LIKE sfba_t.sfba017, #報廢數量
       sfba018 LIKE sfba_t.sfba018, #盤虧數量
       sfba019 LIKE sfba_t.sfba019, #指定發料倉庫
       sfba020 LIKE sfba_t.sfba020, #指定發料儲位
       sfba021 LIKE sfba_t.sfba021, #產品特徵
       sfba022 LIKE sfba_t.sfba022, #替代率
       sfba023 LIKE sfba_t.sfba023, #標準應發數量
       sfba024 LIKE sfba_t.sfba024, #調整應發數量
       sfba025 LIKE sfba_t.sfba025, #超領數量
       sfba026 LIKE sfba_t.sfba026, #SET替代狀態
       sfba027 LIKE sfba_t.sfba027, #SET替代群組
       sfba028 LIKE sfba_t.sfba028, #客供料
       sfba029 LIKE sfba_t.sfba029, #指定發料批號
       sfba030 LIKE sfba_t.sfba030, #指定庫存管理特徵
       sfba031 LIKE sfba_t.sfba031, #備置量
       sfba032 LIKE sfba_t.sfba032, #備置理由碼
       sfba033 LIKE sfba_t.sfba033, #保稅否
       sfba034 LIKE sfba_t.sfba034, #SET被替代群組
       sfba035 LIKE sfba_t.sfba035  #SET替代套數
END RECORD
#161109-00085#40-e
DEFINE  l_sfaadocno_t  LIKE sfaa_t.sfaadocno
DEFINE  l_sql          STRING
DEFINE  l_sql2         STRING
DEFINE  l_flag         LIKE type_t.chr1
DEFINE  l_ooba002      LIKE ooba_t.ooba002
DEFINE  l_cnt          LIKE type_t.num5
DEFINE  l_sfaa004      LIKE sfaa_t.sfaa004
DEFINE  l_para         LIKE type_t.chr80 
DEFINE  l_sfaastus     LIKE sfaa_t.sfaastus
DEFINE  l_sfaa010      LIKE sfaa_t.sfaa010 
DEFINE  l_slip         LIKE ooba_t.ooba002
DEFINE  l_count        LIKE type_t.num5
DEFINE  l_sys          LIKE type_t.num5
DEFINE  ls_sql         STRING   
DEFINE  la_param   RECORD
        prog       STRING,
        actionid   STRING,
        background LIKE type_t.chr1,
        param      DYNAMIC ARRAY OF STRING
        END RECORD
DEFINE  ls_js      STRING
DEFINE  l_sfba009_t  LIKE sfba_t.sfba009
   
    LET l_sql = " SELECT * FROM asfp320_sfdd_tmp ",
                "  WHERE sel = 'Y' ",
                "  ORDER BY sfaadocno,sfba009,sfdd001,sfdd013,sfdd003 "
                
   PREPARE asfp320_sel_sfdd_pre2 FROM l_sql
   DECLARE asfp320_sel_sfdd_cus2 CURSOR WITH HOLD FOR asfp320_sel_sfdd_pre2 
   
   LET l_sql2 = " SELECT COUNT(1) FROM sfba_t",
                "  WHERE sfbaent = ",g_enterprise,
                "    AND sfbadocno = ? ",
                "    AND sfba006 = ? "
                
   LET l_sfaadocno_t = ''
   LET l_sfba009_t = ''
   LET r_success = TRUE
   LET l_count = 0
   LET ls_sql = ''
   FOREACH asfp320_sel_sfdd_cus2 INTO l_sfdd.*
      IF l_sfdd.sfdd007 = 0  THEN   #分配数量为0不产生发料单
         CONTINUE FOREACH 
      END IF      
      IF l_sfdd.sfaadocno <> l_sfaadocno_t OR cl_null(l_sfaadocno_t) OR l_sfdd.sfba009 <> l_sfba009_t OR cl_null(l_sfba009_t) THEN 
         LET l_sfaadocno_t = l_sfdd.sfaadocno
         LET l_sfba009_t = l_sfdd.sfba009
         LET r_success = TRUE
         IF NOT cl_null(g_sfdadocno_key) THEN 
            IF r_success THEN 
               CALL s_transaction_end('Y','0')               
               LET l_count = l_count + 1
               IF cl_null(ls_sql) THEN
                  LET ls_sql = " sfdadocno IN ('",g_sfdadocno_key,"'"
               ELSE
                  LET ls_sql = ls_sql,",","'",g_sfdadocno_key,"'"        
               END IF                 
            ELSE
               CALL s_transaction_end('N','0') 
            END IF               

            #模具领料单是否自动确认&自动过账
            SELECT sfaastus INTO l_sfaastus FROM sfaa_t 
             WHERE sfaaent = g_enterprise
               AND sfaadocno = l_sfdd.sfaadocno
            IF l_sfaastus = 'F' THEN #工單已發放                
               LET l_para = ''
               CALL s_aooi200_get_slip(g_sfdadocno_key) RETURNING l_success,l_slip
               CALL cl_get_doc_para(g_enterprise,g_site,l_slip,'D-MFG-0082') RETURNING l_para  #模具領料單自動確認
               IF l_para = 'Y' THEN  #自動確認
                  CALL s_transaction_begin()   
#                  CALL s_asft310_confirm(g_sfdadocno_key)
#                       RETURNING l_success
                  CALL s_asft310_confirm_chk(g_sfdadocno_key) RETURNING r_success
                  IF r_success = FALSE THEN
                     LET l_success = FALSE
                  END IF
                 
                  CALL s_asft310_confirm_upd(g_sfdadocno_key) RETURNING r_success
                  IF r_success = FALSE THEN
                     LET l_success = FALSE
                  END IF
                  IF NOT l_success THEN
                     CALL s_transaction_end('N',0)
                  ELSE
                     CALL s_transaction_end('Y',0)   
                    #確認後判斷D-BAS-0083參數=Y則自動過帳
                     CALL s_aooi200_get_slip(g_sfdadocno_key) RETURNING l_success,l_slip
                     IF cl_get_doc_para(g_enterprise,g_site,l_slip,'D-BAS-0083') = 'Y' THEN
                        #底下段落參考s_asft310_post(),但不詢問是否執行過帳
                        IF s_asft310_upd_sfcb_cre_tmp_table() THEN
                           CALL s_transaction_begin()   
                           CALL s_asft310_post_chk(g_sfdadocno_key) RETURNING l_success
                           IF l_success THEN
#                              CALL s_asft310_post_input(g_sfdadocno_key)
#                                   RETURNING l_success,g_sfda_m.sfda001
#                              IF l_success THEN
                                 CALL s_asft310_post_upd(g_sfdadocno_key,g_today)
                                      RETURNING l_success
#                              END IF
                           END IF
                           IF NOT l_success THEN
                              CALL s_transaction_end('N',0)
                           ELSE                     
                              CALL s_transaction_end('Y',0)
                           END IF
                           CALL s_asft310_upd_sfcb_drop_tmp_table()
                        END IF
                     END IF
                  END IF            
               
               END IF 
            END IF
         END IF
         CALL s_transaction_begin()         
         LET g_para = ''
         #检查参数D-MFG-0050工單指定發料庫儲，發料時允許修改
         CALL s_aooi200_get_slip(l_sfdd.sfaadocno) RETURNING l_success,l_ooba002
         IF NOT l_success THEN
            LET r_success = FALSE
         END IF
         CALL cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-MFG-0050')
            RETURNING g_para  #工單指定發料庫儲，發料時允許修改  
         
         #产生单头资料
         CALL asfp320_ins_sfda_sfdb(l_sfdd.*) RETURNING l_success
         IF NOT l_success THEN
            LET r_success = FALSE
            CONTINUE FOREACH
         END IF         
      END IF
      IF NOT cl_null(l_sfdd.sfdd013) THEN 
         LET l_sql2 = l_sql2," AND sfba021 = '",l_sfdd.sfdd013,"'"
      END IF      
      IF g_para = 'N' THEN  #指定仓库
         LET l_sql2 = l_sql2," AND sfba019 = '",l_sfdd.sfdd003,"'"
      END IF
      
      PREPARE asfp320_sel_sfba FROM l_sql2
      EXECUTE asfp320_sel_sfba USING l_sfdd.sfaadocno,l_sfdd.sfdd001 INTO l_cnt
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
         #更新工單，有備料更新無備料新增
         IF l_cnt > 0 THEN  #存在备料档=>更新
            IF g_para = 'N' THEN  #指定仓库 
#               UPDATE sfba_t SET sfba024 = sfba024 + l_sfdd.sfdd007,
#                                 sfba013 = sfba013 + l_sfdd.sfdd007
#                WHERE sfbaent = g_enterprise
#                  AND sfbadocno = l_sfdd.sfaadocno
#                  AND sfba006 = l_sfdd.sfdd001
#                  AND sfba021 = l_sfdd.sfdd013
#                  AND sfba019 = l_sfdd.sfdd003
#                  AND ROWNUM = 1   
#               IF SQLCA.sqlcode THEN
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = "UPDATE sfba_t01" 
#                  LET g_errparam.code   = SQLCA.sqlcode 
#                  LET g_errparam.popup  = FALSE 
#                  CALL cl_err()
#                  LET r_success = FALSE
#               END IF                    
               SELECT sfbaseq INTO l_sfba.sfbaseq FROM sfba_t     
                WHERE sfbaent = g_enterprise
                  AND sfbadocno = l_sfdd.sfaadocno
                  AND sfba006 = l_sfdd.sfdd001
                  AND sfba021 = l_sfdd.sfdd013
                  AND sfba019 = l_sfdd.sfdd003
                  AND ROWNUM = 1                 
            ELSE
#               UPDATE sfba_t SET sfba024 = sfba024 + l_sfdd.sfdd007,
#                                 sfba013 = sfba013 + l_sfdd.sfdd007
#                WHERE sfbaent = g_enterprise
#                  AND sfbadocno = l_sfdd.sfaadocno
#                  AND sfba006 = l_sfdd.sfdd001
#                  AND sfba021 = l_sfdd.sfdd013
#                  AND ROWNUM = 1  
#               IF SQLCA.sqlcode THEN
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = "UPDATE sfba_t02" 
#                  LET g_errparam.code   = SQLCA.sqlcode 
#                  LET g_errparam.popup  = FALSE 
#                  CALL cl_err()
#                  LET r_success = FALSE
#               END IF                     
               SELECT sfbaseq INTO l_sfba.sfbaseq FROM sfba_t     
                WHERE sfbaent = g_enterprise
                  AND sfbadocno = l_sfdd.sfaadocno
                  AND sfba006 = l_sfdd.sfdd001
                  AND sfba021 = l_sfdd.sfdd013
                  AND ROWNUM = 1                    
            END IF             
         ELSE
            LET l_sfba.sfbadocno = l_sfdd.sfaadocno 
            SELECT MAX(sfbaseq) INTO l_sfba.sfbaseq FROM sfba_t
             WHERE sfbaent = g_enterprise
               AND sfbasite = g_site
               AND sfbadocno = l_sfdd.sfaadocno
               
            CALL s_aooi200_get_slip(l_sfdd.sfaadocno) RETURNING l_success,l_ooba002
            CALL cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-MFG-0049')  RETURNING l_sys
            IF cl_null(l_sys) OR l_sys = 0 THEN LET l_sys = 1 END IF
            IF cl_null(l_sfba.sfbaseq) THEN
               LET l_sfba.sfbaseq = l_sys
            ELSE
               LET l_sfba.sfbaseq = l_sfba.sfbaseq+l_sys
            END IF            
            #IF cl_null(l_sfba.sfbaseq) THEN LET l_sfba.sfbaseq = 1 END IF
            LET l_sfba.sfbaseq1 = 0
            LET l_sfba.sfba005 = l_sfdd.sfdd001
            LET l_sfba.sfba006 = l_sfdd.sfdd001   
            LET l_sfba.sfba007 = 0     
            LET l_sfba.sfba008 = '3' #间接材料
            SELECT sfaa004,sfaa010 INTO l_sfaa004,l_sfaa010 FROM sfaa_t
             WHERE sfaaent = g_enterprise
               AND sfaadocno = l_sfdd.sfaadocno
            IF l_sfaa004 = '2' THEN   
               LET l_sfba.sfba009 = 'Y' #倒扣料
            ELSE
               LET l_sfba.sfba009 = 'N' #倒扣料
               #有备料根据备料带值
            END IF    
            LET l_sfba.sfba010 = 1
            LET l_sfba.sfba011 = 1
            LET l_sfba.sfba012 = 0
            LET l_sfba.sfba013 = l_sfdd.sfdd007
            LET l_sfba.sfba014 = l_sfdd.sfdd006
            LET l_sfba.sfba019 = l_sfdd.sfdd003
            LET l_sfba.sfba020 = l_sfdd.sfdd004
            LET l_sfba.sfba022 = 1
            LET l_sfba.sfba029 = l_sfdd.sfdd005
            LET l_sfba.sfba026 = '1'
            LET l_sfba.sfba028 = 'N'
            LET l_sfba.sfba030 = l_sfdd.sfdd010
            LET l_sfba.sfba021 = l_sfdd.sfdd013
            LET l_sfba.sfba023 = l_sfdd.sfdd007
            LET l_sfba.sfba024 = 0
            LET l_sfba.sfba013 = l_sfdd.sfdd007
            LET l_sfba.sfba033 = 'N'
            LET l_sfba.sfba015 = 0
            LET l_sfba.sfba025 = 0
            LET l_sfba.sfba017 = 0
            LET l_sfba.sfba018 = 0
            LET l_sfba.sfba001 = l_sfaa010
            LET l_sfba.sfba016 = 0
            INSERT INTO sfba_t
                        (sfbaent,sfbasite,sfbadocno,sfbaseq,sfbaseq1,
                         sfba002,sfba003,sfba004,sfba005,sfba022,sfba006,sfba033,sfba021,sfba007,sfba008, 
                         sfba009,sfba010,sfba011,sfba012,sfba023,sfba024,sfba013,sfba014,sfba015,sfba016,
                         sfba025,sfba017,sfba018,sfba019,sfba020,sfba029,sfba030,sfba028,sfba001,sfba026,
                         sfba027)
                  VALUES(g_enterprise,g_site,l_sfba.sfbadocno,l_sfba.sfbaseq,l_sfba.sfbaseq1,
                         l_sfba.sfba002,l_sfba.sfba003,l_sfba.sfba004,l_sfba.sfba005,l_sfba.sfba022,
                         l_sfba.sfba006,l_sfba.sfba033,l_sfba.sfba021,l_sfba.sfba007,l_sfba.sfba008,  
                         l_sfba.sfba009,l_sfba.sfba010,l_sfba.sfba011,l_sfba.sfba012,l_sfba.sfba023,
                         l_sfba.sfba024,l_sfba.sfba013,l_sfba.sfba014,l_sfba.sfba015,l_sfba.sfba016,
                         l_sfba.sfba025,l_sfba.sfba017,l_sfba.sfba018,l_sfba.sfba019,l_sfba.sfba020,
                         l_sfba.sfba029,l_sfba.sfba030,l_sfba.sfba028,l_sfba.sfba001,l_sfba.sfba026,
                         l_sfba.sfba027)
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "sfba_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET r_success = FALSE
            END IF      
         END IF  
         
      #产生单身资料sfdc_t
      CALL asfp320_ins_sfdc(l_sfdd.*,l_sfba.sfbaseq) RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         CONTINUE FOREACH
      END IF      
      LET l_flag = 'Y'
   END FOREACH
   IF l_flag  = 'Y' AND r_success THEN
      LET l_count = l_count + 1
      CALL s_transaction_end('Y','0')
      IF cl_null(ls_sql) THEN
         LET ls_sql = " sfdadocno IN ('",g_sfdadocno_key,"'"
      ELSE
         LET ls_sql = ls_sql,",","'",g_sfdadocno_key,"'"        
      END IF       
      #模具领料单是否自动确认&自动过账
      SELECT sfaastus INTO l_sfaastus FROM sfaa_t 
       WHERE sfaaent = g_enterprise
         AND sfaadocno = l_sfdd.sfaadocno
      IF l_sfaastus = 'F' THEN #工單已發放                
         LET l_para = ''
         CALL s_aooi200_get_slip(g_sfdadocno_key) RETURNING l_success,l_slip
         CALL cl_get_doc_para(g_enterprise,g_site,l_slip,'D-MFG-0082') RETURNING l_para  #模具領料單自動確認         
         IF l_para = 'Y' THEN  #自動確認
            CALL s_transaction_begin()   
#            CALL s_asft310_confirm(g_sfdadocno_key)
#                 RETURNING l_success
            CALL s_asft310_confirm_chk(g_sfdadocno_key) RETURNING r_success
            IF r_success = FALSE THEN
               LET l_success = FALSE
            END IF
           
            CALL s_asft310_confirm_upd(g_sfdadocno_key) RETURNING r_success
            IF r_success = FALSE THEN
               LET l_success = FALSE
            END IF
   
            IF NOT l_success THEN
               CALL s_transaction_end('N',0)
            ELSE
               CALL s_transaction_end('Y',0)   
              #確認後判斷D-BAS-0083參數=Y則自動過帳
               CALL s_aooi200_get_slip(g_sfdadocno_key) RETURNING l_success,l_slip
               IF cl_get_doc_para(g_enterprise,g_site,l_slip,'D-BAS-0083') = 'Y' THEN
                  #底下段落參考s_asft310_post(),但不詢問是否執行過帳
                  IF s_asft310_upd_sfcb_cre_tmp_table() THEN
                     CALL s_transaction_begin()   
                     CALL s_asft310_post_chk(g_sfdadocno_key) RETURNING l_success
                     IF l_success THEN
                        CALL s_asft310_post_upd(g_sfdadocno_key,g_today)
                             RETURNING l_success
                     END IF
                     IF NOT l_success THEN
                        CALL s_transaction_end('N',0)
                     ELSE                     
                        CALL s_transaction_end('Y',0)
                     END IF
                     CALL s_asft310_upd_sfcb_drop_tmp_table()
                  END IF
               END IF
            END IF                     
         END IF 
      END IF      
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
   
   IF NOT cl_null(ls_sql) THEN
      LET ls_sql = ls_sql,")"
   END IF  
   
   #资料拋转成功！（拋转笔数：%1笔）
   IF l_count > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00394'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_count
      CALL cl_err()
      
      INITIALIZE la_param.* TO NULL
      LET la_param.prog     = 'asft310'
      LET la_param.param[1] =  ''
      LET la_param.param[2] = ls_sql
      LET ls_js = util.JSON.stringify(la_param)
      CALL cl_cmdrun(ls_js)   
    
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00395'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()        
   END IF   
   
   #CALL asfp320_b_fill_sfdd()
END FUNCTION

################################################################################
# Descriptions...: 產生發料單單頭
# Memo...........:
# Usage..........: CALL asfp320_gen_sfda_sfdb(p_sfdd)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp320_ins_sfda_sfdb(p_sfdd)
DEFINE  p_sfdd     type_g_sfdd_d
#161109-00085#40-s
#DEFINE  l_sfda     RECORD LIKE sfda_t.*
DEFINE l_sfda RECORD  #發退料單頭檔
       sfdaent LIKE sfda_t.sfdaent, #企業編號
       sfdasite LIKE sfda_t.sfdasite, #營運據點
       sfdadocno LIKE sfda_t.sfdadocno, #發退料單號
       sfdadocdt LIKE sfda_t.sfdadocdt, #單據日期
       sfda001 LIKE sfda_t.sfda001, #過帳日期
       sfda002 LIKE sfda_t.sfda002, #發退料類別
       sfda003 LIKE sfda_t.sfda003, #生產部門
       sfda004 LIKE sfda_t.sfda004, #申請人
       sfda005 LIKE sfda_t.sfda005, #PBI編號
       sfda006 LIKE sfda_t.sfda006, #生產料號
       sfda007 LIKE sfda_t.sfda007, #BOM特性
       sfda008 LIKE sfda_t.sfda008, #產品特徵
       sfda009 LIKE sfda_t.sfda009, #生產控制組
       sfda010 LIKE sfda_t.sfda010, #作業編號
       sfda011 LIKE sfda_t.sfda011, #作業序
       sfda012 LIKE sfda_t.sfda012, #庫位
       sfda013 LIKE sfda_t.sfda013, #套數
       sfda014 LIKE sfda_t.sfda014, #來源單號
       sfda015 LIKE sfda_t.sfda015, #來源類型
       sfdaownid LIKE sfda_t.sfdaownid, #資料所有者
       sfdaowndp LIKE sfda_t.sfdaowndp, #資料所屬部門
       sfdacrtid LIKE sfda_t.sfdacrtid, #資料建立者
       sfdacrtdp LIKE sfda_t.sfdacrtdp, #資料建立部門
       sfdacrtdt LIKE sfda_t.sfdacrtdt, #資料創建日
       sfdamodid LIKE sfda_t.sfdamodid, #資料修改者
       sfdamoddt LIKE sfda_t.sfdamoddt, #最近修改日
       sfdacnfid LIKE sfda_t.sfdacnfid, #資料確認者
       sfdacnfdt LIKE sfda_t.sfdacnfdt, #資料確認日
       sfdapstid LIKE sfda_t.sfdapstid, #資料過帳者
       sfdapstdt LIKE sfda_t.sfdapstdt, #資料過帳日
       sfdastus LIKE sfda_t.sfdastus  #狀態碼
END RECORD
#161109-00085#40-e
#161109-00085#40-s
#DEFINE  l_sfdb     RECORD LIKE sfdb_t.*
DEFINE l_sfdb RECORD  #發退料套數檔
       sfdbent LIKE sfdb_t.sfdbent, #企業編號
       sfdbsite LIKE sfdb_t.sfdbsite, #營運據點
       sfdbdocno LIKE sfdb_t.sfdbdocno, #發退料單號
       sfdb001 LIKE sfdb_t.sfdb001, #工單單號
       sfdb002 LIKE sfdb_t.sfdb002, #Run Card
       sfdb003 LIKE sfdb_t.sfdb003, #部位
       sfdb004 LIKE sfdb_t.sfdb004, #作業
       sfdb005 LIKE sfdb_t.sfdb005, #作業序
       sfdb006 LIKE sfdb_t.sfdb006, #預計套數
       sfdb007 LIKE sfdb_t.sfdb007, #實際套數
       sfdb008 LIKE sfdb_t.sfdb008  #正負
END RECORD
#161109-00085#40-e
DEFINE  l_ooba002  LIKE ooba_t.ooba002
DEFINE  l_sfaa004  LIKE sfaa_t.sfaa004
DEFINE  r_success  LIKE type_t.num5
DEFINE  l_success  LIKE type_t.num5
DEFINE  l_cnt      LIKE type_t.num5
DEFINE  l_cnt2     LIKE type_t.num5

   LET r_success = TRUE
   LET g_sfdadocno_key = ''
   SELECT sfaa004 INTO l_sfaa004 FROM sfaa_t
    WHERE sfaaent = g_enterprise
      AND sfaadocno = p_sfdd.sfaadocno
   IF l_sfaa004 = '1' THEN  #事先发料
      CALL s_aooi200_gen_docno(g_site,g_sfdadocno,g_today,'asft311')
           RETURNING r_success,g_sfdadocno_key
      LET l_sfda.sfdadocno = g_sfdadocno_key   
      LET l_sfda.sfda002 = '11'           
   END IF
   IF l_sfaa004 = '2' THEN  #倒扣料
      CALL s_aooi200_gen_docno(g_site,g_sfdadocno_2,g_today,'asft314')
           RETURNING r_success,g_sfdadocno_key
      LET l_sfda.sfdadocno = g_sfdadocno_key
      LET l_sfda.sfda002 = '14'           
   END IF   
   LET l_sfda.sfdadocdt = g_today
   LET l_sfda.sfda001 = g_today
   
   LET l_sfda.sfda003 = g_dept
   LET l_sfda.sfda004 = g_user
   LET l_sfda.sfda015 = '01'  #人工输入
   LET l_sfda.sfdaownid = g_user
   LET l_sfda.sfdaowndp = g_dept
   LET l_sfda.sfdacrtid = g_user
   LET l_sfda.sfdacrtdp = g_dept
   LET l_sfda.sfdacrtdt = cl_get_current()
   LET l_sfda.sfdamodid = ""
   LET l_sfda.sfdamoddt = ""   
   LET l_sfda.sfdastus = 'N'   

   #新增發料單單頭 
   INSERT INTO sfda_t (sfdaent,sfdasite,sfdadocno,sfdadocdt,sfda001,sfda002,sfda003,sfda004,sfda014,sfda015,
                       sfdaownid,sfdaowndp,sfdacrtid,sfdacrtdp,sfdacrtdt,sfdamodid,sfdamoddt,sfdastus)   
               VALUES (g_enterprise,g_site,l_sfda.sfdadocno,l_sfda.sfdadocdt,l_sfda.sfda001,l_sfda.sfda002,l_sfda.sfda003,
                       l_sfda.sfda004,l_sfda.sfda014,l_sfda.sfda015,l_sfda.sfdaownid,l_sfda.sfdaowndp,l_sfda.sfdacrtid,
                       l_sfda.sfdacrtdp,l_sfda.sfdacrtdt,l_sfda.sfdamodid,l_sfda.sfdamoddt,l_sfda.sfdastus) 

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "ins sfda_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()            
      LET r_success = FALSE
   END IF   
   
   #新增發料单身
   LET l_sfdb.sfdbent = g_enterprise
   LET l_sfdb.sfdbsite = g_site
   LET l_sfdb.sfdbdocno = l_sfda.sfdadocno
   LET l_sfdb.sfdb001 = p_sfdd.sfaadocno
   LET l_sfdb.sfdb002 = 0
   
   LET g_para = ''
   #检查参数D-MFG-0050工單指定發料庫儲，發料時允許修改
   CALL s_aooi200_get_slip(p_sfdd.sfaadocno) RETURNING l_success,l_ooba002
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   CALL cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-MFG-0050')
      RETURNING g_para  #工單指定發料庫儲，發料時允許修改  
      
   IF g_para = 'N' THEN
      #是否存在備料檔
      LET l_cnt = 0
      SELECT COUNT(1) INTO l_cnt FROM sfba_t 
       WHERE sfbaent = g_enterprise
         AND sfbasite = g_site
         AND sfbadocno = p_sfdd.sfaadocno
         AND sfba006 = p_sfdd.sfdd001
         AND sfba021 = p_sfdd.sfdd013
         #AND sfba019 = p_sfdd.sfdd003
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF   
      IF l_cnt > 0 THEN   #存在备料档
         LET l_cnt2 = 0
         SELECT COUNT(1) INTO l_cnt2 FROM sfba_t 
          WHERE sfbaent = g_enterprise
            AND sfbasite = g_site
            AND sfbadocno = p_sfdd.sfaadocno
            AND sfba006 = p_sfdd.sfdd001
            AND sfba021 = p_sfdd.sfdd013
            AND (sfba019 = ' ' OR sfba019 IS NULL)
            #AND sfba019 = p_sfdd.sfdd003
         IF cl_null(l_cnt2) THEN LET l_cnt2 = 0 END IF 
         IF l_cnt2 > 0 THEN          
            SELECT DISTINCT sfba002,sfba003,sfba004 INTO l_sfdb.sfdb003,l_sfdb.sfdb004,l_sfdb.sfdb005 FROM sfba_t
             WHERE sfbaent = g_enterprise
               AND sfbasite = g_site
               AND sfbadocno = p_sfdd.sfaadocno
               AND sfba006 = p_sfdd.sfdd001
               AND sfba021 = p_sfdd.sfdd013  
               #AND sfba019 = p_sfdd.sfdd003  
         ELSE
            SELECT DISTINCT sfba002,sfba003,sfba004 INTO l_sfdb.sfdb003,l_sfdb.sfdb004,l_sfdb.sfdb005 FROM sfba_t
             WHERE sfbaent = g_enterprise
               AND sfbasite = g_site
               AND sfbadocno = p_sfdd.sfaadocno
               AND sfba006 = p_sfdd.sfdd001
               AND sfba021 = p_sfdd.sfdd013  
               AND sfba019 = p_sfdd.sfdd003         
         END IF               
      END IF         
   ELSE
      #是否存在備料檔
      LET l_cnt = 0
      SELECT COUNT(1) INTO l_cnt FROM sfba_t 
       WHERE sfbaent = g_enterprise
         AND sfbasite = g_site
         AND sfbadocno = p_sfdd.sfaadocno
         AND sfba006 = p_sfdd.sfdd001
         AND sfba021 = p_sfdd.sfdd013
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF   
      IF l_cnt > 0 THEN   #存在备料档
         SELECT DISTINCT sfba002,sfba003,sfba004 INTO l_sfdb.sfdb003,l_sfdb.sfdb004,l_sfdb.sfdb005 FROM sfba_t
          WHERE sfbaent = g_enterprise
            AND sfbasite = g_site
            AND sfbadocno = p_sfdd.sfaadocno
            AND sfba006 = p_sfdd.sfdd001
            AND sfba021 = p_sfdd.sfdd013      
      END IF           
   END IF
   IF l_sfdb.sfdb003 IS NULL THEN
      LET l_sfdb.sfdb003 = ' '
   END IF
   IF l_sfdb.sfdb004 IS NULL THEN
      LET l_sfdb.sfdb004 = ' '
   END IF   
   IF l_sfdb.sfdb005 IS NULL THEN
      LET l_sfdb.sfdb005 = ' '
   END IF    
   LET l_sfdb.sfdb006 = 0  #預計套數
   LET l_sfdb.sfdb007 = 0  #實際套數
   LET l_sfdb.sfdb008 = -1
   #發料確認時需檢查單身是否有資料
   INSERT INTO sfdb_t (sfdbent,sfdbsite,sfdbdocno,sfdb001,sfdb002,sfdb003,sfdb004,sfdb005,sfdb006,sfdb007,sfdb008)
               VALUES (l_sfdb.sfdbent,l_sfdb.sfdbsite,l_sfdb.sfdbdocno,l_sfdb.sfdb001,l_sfdb.sfdb002,l_sfdb.sfdb003,
                       l_sfdb.sfdb004,l_sfdb.sfdb005,l_sfdb.sfdb006,l_sfdb.sfdb007,l_sfdb.sfdb008)                   #新增發料单身
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "ins sfdb_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()            
      LET r_success = FALSE
   END IF     
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 产生sfdc_t
# Memo...........:
# Usage..........: CALL asfp320_gen_sfdc(p_sfdd,p_sfbaseq)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp320_ins_sfdc(p_sfdd,p_sfbaseq)
DEFINE  p_sfdd     type_g_sfdd_d
DEFINE  p_sfbaseq  LIKE sfba_t.sfbaseq
#161109-00085#40-s
#DEFINE  l_sfdc     RECORD LIKE sfdc_t.*
DEFINE l_sfdc RECORD  #發退料需求檔
       sfdcent LIKE sfdc_t.sfdcent, #企業編號
       sfdcsite LIKE sfdc_t.sfdcsite, #營運據點
       sfdcdocno LIKE sfdc_t.sfdcdocno, #發退料單號
       sfdcseq LIKE sfdc_t.sfdcseq, #項次
       sfdc001 LIKE sfdc_t.sfdc001, #工單單號
       sfdc002 LIKE sfdc_t.sfdc002, #工單項次
       sfdc003 LIKE sfdc_t.sfdc003, #工單項序
       sfdc004 LIKE sfdc_t.sfdc004, #需求料號
       sfdc005 LIKE sfdc_t.sfdc005, #產品特徵
       sfdc006 LIKE sfdc_t.sfdc006, #單位
       sfdc007 LIKE sfdc_t.sfdc007, #申請數量
       sfdc008 LIKE sfdc_t.sfdc008, #實際數量
       sfdc009 LIKE sfdc_t.sfdc009, #參考單位
       sfdc010 LIKE sfdc_t.sfdc010, #參考單位需求數量
       sfdc011 LIKE sfdc_t.sfdc011, #參考單位實際數量
       sfdc012 LIKE sfdc_t.sfdc012, #指定庫位
       sfdc013 LIKE sfdc_t.sfdc013, #指定儲位
       sfdc014 LIKE sfdc_t.sfdc014, #指定批號
       sfdc015 LIKE sfdc_t.sfdc015, #理由碼
       sfdc016 LIKE sfdc_t.sfdc016, #庫存管理特徴
       sfdc017 LIKE sfdc_t.sfdc017 #正負
END RECORD
#161109-00085#40-e
#161109-00085#40-s
#DEFINE  l_inai     RECORD LIKE inai_t.*
DEFINE l_inai RECORD  #製造批序號庫存明細檔
       inaient LIKE inai_t.inaient, #企業編號
       inaisite LIKE inai_t.inaisite, #營運據點
       inai001 LIKE inai_t.inai001, #料件編號
       inai002 LIKE inai_t.inai002, #產品特徵
       inai003 LIKE inai_t.inai003, #庫存管理特徵
       inai004 LIKE inai_t.inai004, #庫位編號
       inai005 LIKE inai_t.inai005, #儲位編號
       inai006 LIKE inai_t.inai006, #批號
       inai007 LIKE inai_t.inai007, #製造批號
       inai008 LIKE inai_t.inai008, #製造序號
       inai009 LIKE inai_t.inai009, #庫存單位
       inai010 LIKE inai_t.inai010, #帳面基礎單位庫存數量
       inai011 LIKE inai_t.inai011, #實際基礎單位庫存數量
       inai012 LIKE inai_t.inai012, #NO USE
       inai013 LIKE inai_t.inai013, #Tag二進位碼
       inai014 LIKE inai_t.inai014  #基礎單位
END RECORD
#161109-00085#40-e
DEFINE  l_inae010  LIKE inae_t.inae010
DEFINE  l_inae011  LIKE inae_t.inae011
#161109-00085#40-s
#DEFINE  l_inao     RECORD LIKE inao_t.*
DEFINE l_inao RECORD  #製造批序號庫存異動明細檔
       inaoent LIKE inao_t.inaoent, #企業編號
       inaosite LIKE inao_t.inaosite, #營運據點
       inaodocno LIKE inao_t.inaodocno, #單號
       inaoseq LIKE inao_t.inaoseq, #項次
       inaoseq1 LIKE inao_t.inaoseq1, #項序
       inaoseq2 LIKE inao_t.inaoseq2, #序號
       inao000 LIKE inao_t.inao000, #資料類型
       inao001 LIKE inao_t.inao001, #料件編號
       inao002 LIKE inao_t.inao002, #產品特徵
       inao003 LIKE inao_t.inao003, #庫存管理特徵
       inao004 LIKE inao_t.inao004, #包裝容器編號
       inao005 LIKE inao_t.inao005, #庫位
       inao006 LIKE inao_t.inao006, #儲位
       inao007 LIKE inao_t.inao007, #批號
       inao008 LIKE inao_t.inao008, #製造批號
       inao009 LIKE inao_t.inao009, #製造序號
       inao010 LIKE inao_t.inao010, #製造日期
       inao011 LIKE inao_t.inao011, #有效日期
       inao012 LIKE inao_t.inao012, #數量
       inao013 LIKE inao_t.inao013, #出入庫碼
       inao014 LIKE inao_t.inao014, #庫存單位
       inao020 LIKE inao_t.inao020, #檢驗合格量
       inao021 LIKE inao_t.inao021, #已入庫/出貨/簽收量
       inao022 LIKE inao_t.inao022, #已驗退/簽退量
       inao023 LIKE inao_t.inao023, #已倉退/銷退量
       inao024 LIKE inao_t.inao024, #已轉QC量
       inao025 LIKE inao_t.inao025  #已退品量
END RECORD
#161109-00085#40-e
DEFINE  s_inao012  LIKE inao_t.inao012
#161109-00085#40-s
#DEFINE  l_sfdc2    RECORD LIKE sfdc_t.*
DEFINE l_sfdc2 RECORD  #發退料需求檔
       sfdcent LIKE sfdc_t.sfdcent, #企業編號
       sfdcsite LIKE sfdc_t.sfdcsite, #營運據點
       sfdcdocno LIKE sfdc_t.sfdcdocno, #發退料單號
       sfdcseq LIKE sfdc_t.sfdcseq, #項次
       sfdc001 LIKE sfdc_t.sfdc001, #工單單號
       sfdc002 LIKE sfdc_t.sfdc002, #工單項次
       sfdc003 LIKE sfdc_t.sfdc003, #工單項序
       sfdc004 LIKE sfdc_t.sfdc004, #需求料號
       sfdc005 LIKE sfdc_t.sfdc005, #產品特徵
       sfdc006 LIKE sfdc_t.sfdc006, #單位
       sfdc007 LIKE sfdc_t.sfdc007, #申請數量
       sfdc008 LIKE sfdc_t.sfdc008, #實際數量
       sfdc009 LIKE sfdc_t.sfdc009, #參考單位
       sfdc010 LIKE sfdc_t.sfdc010, #參考單位需求數量
       sfdc011 LIKE sfdc_t.sfdc011, #參考單位實際數量
       sfdc012 LIKE sfdc_t.sfdc012, #指定庫位
       sfdc013 LIKE sfdc_t.sfdc013, #指定儲位
       sfdc014 LIKE sfdc_t.sfdc014, #指定批號
       sfdc015 LIKE sfdc_t.sfdc015, #理由碼
       sfdc016 LIKE sfdc_t.sfdc016, #庫存管理特徴
       sfdc017 LIKE sfdc_t.sfdc017 #正負
END RECORD
#161109-00085#40-e
DEFINE  r_success  LIKE type_t.num5
DEFINE  l_success  LIKE type_t.num5
DEFINE  l_sql      STRING
   
   INITIALIZE l_sfdc.* TO NULL
   LET r_success = TRUE
   #新增發料需求檔   
   LET l_sfdc.sfdcdocno = g_sfdadocno_key                   
   SELECT MAX(sfdcseq)+1 INTO l_sfdc.sfdcseq FROM sfdc_t
    WHERE sfdcent = g_enterprise
      AND sfdcsite = g_site
      AND sfdcdocno = l_sfdc.sfdcdocno
   IF cl_null(l_sfdc.sfdcseq) THEN LET l_sfdc.sfdcseq = 1 END IF
   LET l_sfdc.sfdc001 = p_sfdd.sfaadocno
   LET l_sfdc.sfdc002 = p_sfbaseq 
   LET l_sfdc.sfdc003 = 0
   LET l_sfdc.sfdc004 = p_sfdd.sfdd001
   LET l_sfdc.sfdc005 = p_sfdd.sfdd013
   LET l_sfdc.sfdc006 = p_sfdd.sfdd006
   LET l_sfdc.sfdc007 = p_sfdd.sfdd007
   LET l_sfdc.sfdc008 = p_sfdd.sfdd007
   LET l_sfdc.sfdc009 = p_sfdd.sfdd008
   LET l_sfdc.sfdc010 = p_sfdd.sfdd009
   LET l_sfdc.sfdc011 = p_sfdd.sfdd009
   LET l_sfdc.sfdc012 = p_sfdd.sfdd003
   LET l_sfdc.sfdc013 = p_sfdd.sfdd004
   LET l_sfdc.sfdc014 = p_sfdd.sfdd005
   LET l_sfdc.sfdc016 = p_sfdd.sfdd010
   LET l_sfdc.sfdc017 = -1
   
   IF cl_null(l_sfdc.sfdc012) THEN LET l_sfdc.sfdc012 = ' ' END IF
   IF cl_null(l_sfdc.sfdc013) THEN LET l_sfdc.sfdc013 = ' ' END IF
   IF cl_null(l_sfdc.sfdc014) THEN LET l_sfdc.sfdc014 = ' ' END IF
   IF cl_null(l_sfdc.sfdc016) THEN LET l_sfdc.sfdc016 = ' ' END IF  
   IF cl_null(l_sfdc.sfdc005) THEN LET l_sfdc.sfdc005 = ' ' END IF
   IF cl_null(l_sfdc.sfdc009) THEN LET l_sfdc.sfdc009 = ' ' END IF 
   IF cl_null(l_sfdc.sfdc015) THEN LET l_sfdc.sfdc015 = ' ' END IF
   IF cl_null(l_sfdc.sfdc010) THEN LET l_sfdc.sfdc010 = 0 END IF
   IF cl_null(l_sfdc.sfdc011) THEN LET l_sfdc.sfdc011 = 0 END IF  
   
   INSERT INTO sfdc_t
               (sfdcent,sfdcsite,sfdcdocno,sfdcseq,
                sfdc001,sfdc002,sfdc003,sfdc004,sfdc005,sfdc006,sfdc007,sfdc008,sfdc009,sfdc010,
                sfdc011,sfdc012,sfdc013,sfdc014,sfdc015,sfdc016,sfdc017)
         VALUES(g_enterprise,g_site,l_sfdc.sfdcdocno,l_sfdc.sfdcseq,l_sfdc.sfdc001,l_sfdc.sfdc002,l_sfdc.sfdc003,
                l_sfdc.sfdc004,l_sfdc.sfdc005,l_sfdc.sfdc006,l_sfdc.sfdc007,l_sfdc.sfdc008,l_sfdc.sfdc009,l_sfdc.sfdc010,
                l_sfdc.sfdc011,l_sfdc.sfdc012,l_sfdc.sfdc013,l_sfdc.sfdc014,l_sfdc.sfdc015,l_sfdc.sfdc016,l_sfdc.sfdc017)                                  
   IF SQLCA.sqlerrd[3] = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'insert into sfdc_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF   

   #匯總資料
   #将有指定库位的资料产生到需求页签
   #LET l_sql = "SELECT * FROM sfdc_t WHERE sfdcent = '",g_enterprise,"' AND sfdcsite = '",g_site,"' AND sfdcdocno = '",l_sfdc.sfdcdocno,"'",
   #161109-00085#40 MARK
   #161109-00085#40-s
   LET l_sql = "SELECT sfdcent,sfdcsite,sfdcdocno,sfdcseq,
                       sfdc001,sfdc002,sfdc003,sfdc004,sfdc005,
                       sfdc006,sfdc007,sfdc008,sfdc009,sfdc010,
                       sfdc011,sfdc012,sfdc013,sfdc014,sfdc015,
                       sfdc016,sfdc017
                  FROM sfdc_t 
                 WHERE sfdcent = '",g_enterprise,"' AND sfdcsite = '",g_site,"' AND sfdcdocno = '",l_sfdc.sfdcdocno,"'",
   #161109-00085#40-e
               "   AND sfdc012 IS NOT NULL AND sfdc012 != ' ' "  #库位为空的不产生出来
   PREPARE asfp320_gen_p2 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'prepare asfp320_gen_p2 err'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      FREE asfp320_gen_p2
   END IF
   DECLARE asfp320_gen_c2 CURSOR FOR asfp320_gen_p2
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'declare asfp320_gen_c2 err'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      FREE asfp320_gen_c2
   END IF
   #FOREACH asfp320_gen_c2 INTO l_sfdc2.*  #161109-00085#40 MARK
   #161109-00085#40-s
   FOREACH asfp320_gen_c2 INTO l_sfdc2.sfdcent,l_sfdc2.sfdcsite,l_sfdc2.sfdcdocno,l_sfdc2.sfdcseq,
                               l_sfdc2.sfdc001,l_sfdc2.sfdc002,l_sfdc2.sfdc003,l_sfdc2.sfdc004,l_sfdc2.sfdc005,
                               l_sfdc2.sfdc006,l_sfdc2.sfdc007,l_sfdc2.sfdc008,l_sfdc2.sfdc009,l_sfdc2.sfdc010,
                               l_sfdc2.sfdc011,l_sfdc2.sfdc012,l_sfdc2.sfdc013,l_sfdc2.sfdc014,l_sfdc2.sfdc015,
                               l_sfdc2.sfdc016,l_sfdc2.sfdc017
   #161109-00085#40-e                            
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach asfp320_gen_c2 err'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF                                
      CALL asfp320_ins_sfdd_sfde(l_sfdc2.sfdcdocno,l_sfdc2.sfdcseq) RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
      END IF
   END FOREACH

   #產生批序號資料   
   IF s_lot_batch_number(l_sfdc.sfdc004,g_site) THEN  #走批序号管理
      IF cl_null(p_sfdd.sfdd004) THEN LET p_sfdd.sfdd004 = ' ' END IF
      IF cl_null(p_sfdd.sfdd005) THEN LET p_sfdd.sfdd005 = ' ' END IF
      #161109-00085#40-s
      #LET l_sql = " SELECT DISTINCT * FROM inai_t ",
      LET l_sql = " SELECT DISTINCT inaient,inaisite,inai001,inai002,inai003,
                                    inai004,inai005,inai006,inai007,inai008,
                                    inai009,inai010,inai011,inai012,inai013,
                                    inai014,inae010,inae011
                      FROM inai_t ",
      #161109-00085#40-s
                  "   LEFT JOIN inae_t ON inaeent=inaient AND inae001=inai001 AND inaesite=inaisite AND inae002=inai002 AND inae003=inai007 AND inae004=inai008 ",
                  "  WHERE inaient = ",g_enterprise," AND inaisite = '",g_site,"' ",
                  "    AND inai001 = '",p_sfdd.sfdd001,"' AND inai002 = '",p_sfdd.sfdd013,"' ",
                  "    AND inai004 = '",p_sfdd.sfdd003,"' ",
                  "    AND inai005 = '",p_sfdd.sfdd004,"' AND inai006 = '",p_sfdd.sfdd005,"' ",
                  "    AND inai009 = '",p_sfdd.sfdd006,"' ",           
                  "  ORDER BY inai007,inai008,inae010 "   
      PREPARE asfp320_inai_pre FROM l_sql
      DECLARE asfp320_inai_cus CURSOR FOR asfp320_inai_pre
      
      LET s_inao012 = 0
      #161109-00085#40-s
      #FOREACH asfp320_inai_cus INTO l_inai.*,l_inae010,l_inae011
      FOREACH asfp320_inai_cus 
      INTO l_inai.inaient,l_inai.inaisite,l_inai.inai001,l_inai.inai002,l_inai.inai003,
           l_inai.inai004,l_inai.inai005,l_inai.inai006,l_inai.inai007,l_inai.inai008,
           l_inai.inai009,l_inai.inai010,l_inai.inai011,l_inai.inai012,l_inai.inai013,
           l_inai.inai014,l_inae010,l_inae011
      #161109-00085#40-e
         IF s_inao012 + l_inai.inai010 <= p_sfdd.sfdd007 THEN
            LET l_inao.inao012 = l_inai.inai010
         ELSE
            LET l_inao.inao012 = p_sfdd.sfdd007 - s_inao012
         END IF
         SELECT MAX(inaoseq2)+1 INTO l_inao.inaoseq2 FROM inao_t
          WHERE inaoent = g_enterprise
            AND inao000 = 1   #申请
            AND inaodocno = l_sfdc.sfdcdocno
            AND inaoseq = l_sfdc.sfdcseq
            AND inaoseq1 = 1
            AND inao013 = -1  #出库
         IF cl_null(l_inao.inaoseq2) THEN LET l_inao.inaoseq2 = 1 END IF         
         LET l_inao.inaodocno = l_sfdc.sfdcdocno
         LET l_inao.inaoseq = l_sfdc.sfdcseq
         LET l_inao.inaoseq1 = 1
         LET l_inao.inao000 = 1 
         LET l_inao.inao013 = -1
         LET l_inao.inao001 = p_sfdd.sfdd001
         LET l_inao.inao002 = p_sfdd.sfdd013
         LET l_inao.inao003 = p_sfdd.sfdd010
         LET l_inao.inao005 = p_sfdd.sfdd003
         LET l_inao.inao006 = p_sfdd.sfdd004
         LET l_inao.inao007 = p_sfdd.sfdd005
         LET l_inao.inao008 = l_inai.inai007
         LET l_inao.inao009 = l_inai.inai008
         LET l_inao.inao010 = l_inae010  #製造日期
         LET l_inao.inao011 = l_inae011  #有效日期
         LET l_inao.inao014 = l_inai.inai009
         LET l_inao.inao020 = 0
         LET l_inao.inao021 = 0
         LET l_inao.inao022 = 0
         LET l_inao.inao023 = 0
         LET l_inao.inao024 = 0            
         INSERT INTO inao_t(inaoent,inaosite,inaodocno,inaoseq,inaoseq1,
                            inaoseq2,inao000,inao001,inao002,inao003,
                            inao004,inao005,inao006,inao007,inao008,
                            inao009,inao010,inao011,inao012,inao013,
                            inao014,inao020,inao021,inao022,inao023,inao024)
                     VALUES(g_enterprise,g_site,l_inao.inaodocno,l_inao.inaoseq,l_inao.inaoseq1,
                            l_inao.inaoseq2,l_inao.inao000,l_inao.inao001,l_inao.inao002,l_inao.inao003,
                            l_inao.inao004,l_inao.inao005,l_inao.inao006,l_inao.inao007,l_inao.inao008,
                            l_inao.inao009,l_inao.inao010,l_inao.inao011,l_inao.inao012,l_inao.inao013,
                            l_inao.inao014,l_inao.inao020,l_inao.inao021,l_inao.inao022,l_inao.inao023,l_inao.inao024)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins inao'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
         END IF                             
         IF s_inao012 + l_inao.inao012 = p_sfdd.sfdd007 THEN 
            EXIT FOREACH
         END IF   
         LET s_inao012 = s_inao012 + l_inao.inao012
      END FOREACH
      
   END IF 
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 新增sfdd_t/sfde_t
# Memo...........:
# Usage..........: CALL asfp320_ins_sfdd_sfde(p_sfdcdocno,p_sfdcseq)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp320_ins_sfdd_sfde(p_sfdcdocno,p_sfdcseq)
DEFINE  p_sfdcdocno    LIKE sfdc_t.sfdcdocno
DEFINE  p_sfdcseq      LIKE sfdc_t.sfdcseq
DEFINE  r_success      LIKE type_t.num5
DEFINE  l_success      LIKE type_t.num5

   LET r_success = TRUE      
   #同步新增sfdd
   CALL s_asft310_chg_sfdd_f_sfdc_ins(p_sfdcdocno,p_sfdcseq) RETURNING l_success
   IF NOT l_success THEN
      LET r_success = FALSE
   END IF
   #新增或更新sfde('Y'代表新增或更新sfdf) 
   CALL s_asft310_chg_sfde_f_sfdc_ins(p_sfdcdocno,p_sfdcseq,'Y') RETURNING l_success
   IF NOT l_success THEN
      LET r_success = FALSE
   END IF
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 需求页签填充
# Memo...........:
# Usage..........: CALL asfp320_b_fill_sfdc()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp320_b_fill_sfdc()
DEFINE   l_sql     STRING

   LET l_sql = " SELECT * FROM asfp320_sfdc_tmp ",
               "  WHERE 1=1  ",
               "  ORDER BY seq1"
 
   PREPARE asfp320_sel2 FROM l_sql
   DECLARE b_fill_curs2 CURSOR FOR asfp320_sel2
   
   CALL g_detail_d.clear()
   LET g_cnt2 = l_ac
   LET l_ac = 1
   FOREACH b_fill_curs2 INTO g_detail_d[l_ac].sel,g_detail_d[l_ac].seq1,g_detail_d[l_ac].sfdcdocno,g_detail_d[l_ac].sfdcseq,g_detail_d[l_ac].sfdc004,                              
                             g_detail_d[l_ac].sfdc004_desc,g_detail_d[l_ac].sfdc004_desc_1,g_detail_d[l_ac].sfdc005,g_detail_d[l_ac].sfdc005_desc,                      
                             g_detail_d[l_ac].sfdc006,g_detail_d[l_ac].sfdc006_desc,g_detail_d[l_ac].sfdc007,g_detail_d[l_ac].sfdc008,g_detail_d[l_ac].allot,                        
                             g_detail_d[l_ac].sfdc009,g_detail_d[l_ac].sfdc009_desc,g_detail_d[l_ac].sfdc010,g_detail_d[l_ac].sfdc011,g_detail_d[l_ac].ck_allot,                     
                             g_detail_d[l_ac].sfdc012,g_detail_d[l_ac].sfdc012_desc,g_detail_d[l_ac].sfdc013,g_detail_d[l_ac].sfdc013_desc,g_detail_d[l_ac].sfdc014,                          
                             g_detail_d[l_ac].sfdc015,g_detail_d[l_ac].sfdc015_desc,g_detail_d[l_ac].sfdc016 
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF 
      IF g_detail_d[l_ac].sfdc005 IS NULL THEN
         LET g_detail_d[l_ac].sfdc005 = ' '
      END IF
      LET l_ac = l_ac + 1
   END FOREACH
   CALL g_detail_d.deleteElement(l_ac)
    
   LET g_detail_cnt = l_ac - 1 
   #LET l_ac = l_ac - 1
   LET l_ac = g_cnt2
   IF l_ac = 0 THEN
      LET l_ac = 1
   END IF
   DISPLAY g_detail_cnt TO FORMONLY.h_count   
END FUNCTION

################################################################################
# Descriptions...: 產品特徵
# Memo...........:
# Usage..........: CALL asfp320_get_imaa005(p_imaa001)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp320_get_imaa005(p_imaa001)
DEFINE  p_imaa001    LIKE imaa_t.imaa001
DEFINE  l_imaa005    LIKE imaa_t.imaa005
DEFINE  r_success    LIKE type_t.num5

   LET l_imaa005 = ''
   LET r_success = TRUE
   SELECT imaa005 INTO l_imaa005 FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = p_imaa001
   IF cl_null(l_imaa005) THEN
      LET r_success = FALSE
   END IF
   RETURN r_success
   
END FUNCTION

#end add-point
 
{</section>}
 
