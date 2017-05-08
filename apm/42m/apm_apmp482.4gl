#該程式未解開Section, 採用最新樣板產出!
{<section id="apmp482.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2015-03-13 18:16:15), PR版次:0004(2017-02-20 10:22:27)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000052
#+ Filename...: apmp482
#+ Description: 採購合約差異金額調整作業
#+ Creator....: 02295(2015-03-06 17:10:18)
#+ Modifier...: 02295 -SD/PR- 01996
 
{</section>}
 
{<section id="apmp482.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160816-00001#7   2016/08/17   By 08742  抓取理由碼改CALL sub
#161207-00033#20  2016/12/20   By lixh   一次性交易對象顯示說明，所有的客戶/供應商欄位都應該處理
#160711-00040#24  2017/02/20   By xujing   T類作業的單別開窗的where條件(找CALL q_ooba002_開頭的)增加如下程式段
#                                          CALL s_control_get_docno_sql(g_user,g_dept) RETURNING l_success,l_sql1
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
     sel LIKE type_t.chr1,
     pmeo001 LIKE pmeo_t.pmeo001,
     pmeo002 LIKE pmeo_t.pmeo002,
     pmeo005 LIKE pmeo_t.pmeo005,
     pmdx004 LIKE pmdx_t.pmdx004,
     pmdx004_desc LIKE pmaal_t.pmaal004,
     pmeo006 LIKE pmeo_t.pmeo006,
     pmeo006_desc LIKE imaal_t.imaal003,
     pmeo006_desc_1 LIKE imaal_t.imaal004,
     pmeo007 LIKE pmeo_t.pmeo007,
     pmeo007_desc LIKE type_t.chr500,
     pmeo003 LIKE pmeo_t.pmeo003,
     pmeo004 LIKE pmeo_t.pmeo004,
     pmeo017 LIKE pmeo_t.pmeo017,
     pmeo018 LIKE pmeo_t.pmeo018,
     pmeo019 LIKE pmeo_t.pmeo019,
     pmeo021 LIKE pmeo_t.pmeo021,
     pmeo020 LIKE pmeo_t.pmeo020,
     pmeo014 LIKE pmeo_t.pmeo014,
     pmeo015 LIKE pmeo_t.pmeo015,
     pmeo016 LIKE pmeo_t.pmeo016,
     pmeo010 LIKE pmeo_t.pmeo010,
     pmeo011 LIKE pmeo_t.pmeo011,
     pmeo012 LIKE pmeo_t.pmeo012,
     pmeo013 LIKE pmeo_t.pmeo013
    END RECORD

 TYPE type_master RECORD
   pmeo026 LIKE pmeo_t.pmeo026, 
   pmdsdocno LIKE pmds_t.pmdsdocno, 
   pmdt051 LIKE pmdt_t.pmdt051, 
   imaf001 LIKE imaf_t.imaf001, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
DEFINE g_master type_master

TYPE type_g_detail2_d RECORD
   pmds007 LIKE pmds_t.pmds007,
   pmds007_desc LIKE type_t.chr500,   
   pmds031 LIKE pmds_t.pmds031, 
   pmds032 LIKE pmds_t.pmds032, 
   pmds033 LIKE pmds_t.pmds033, 
   pmds034 LIKE pmds_t.pmds034,
   pmds035 LIKE pmds_t.pmds035,
   pmds037 LIKE pmds_t.pmds037,
   pmds038 LIKE pmds_t.pmds038,
   pmds055 LIKE pmds_t.pmds055
       END RECORD
DEFINE g_detail2_d  DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_detail2_idx LIKE type_t.num5

TYPE type_g_detail3_d RECORD
   pmdtseq LIKE pmdt_t.pmdtseq,
   pmdt006 LIKE pmdt_t.pmdt006,
   pmdt006_desc LIKE type_t.chr500,
   pmdt006_desc_1 LIKE type_t.chr500,   
   pmdt007 LIKE pmdt_t.pmdt007, 
   pmdt007_desc LIKE type_t.chr500, 
   pmdt019 LIKE pmdt_t.pmdt019, 
   pmdt020 LIKE pmdt_t.pmdt020, 
   pmdt021 LIKE pmdt_t.pmdt021,
   pmdt022 LIKE pmdt_t.pmdt022,
   pmdt023 LIKE pmdt_t.pmdt023,
   pmdt024 LIKE pmdt_t.pmdt024,
   pmdt046 LIKE pmdt_t.pmdt046,
   pmdt037 LIKE pmdt_t.pmdt037,
   pmdt036 LIKE pmdt_t.pmdt036,
   pmdt038 LIKE pmdt_t.pmdt038,
   pmdt039 LIKE pmdt_t.pmdt039,
   pmdt047 LIKE pmdt_t.pmdt047,
   pmdt051 LIKE pmdt_t.pmdt051,
   pmdt051_desc LIKE oocql_t.oocql004,
   pmdt070 LIKE pmdt_t.pmdt070,
   pmdt071 LIKE pmdt_t.pmdt071
       END RECORD
DEFINE g_detail3_d  DYNAMIC ARRAY OF type_g_detail3_d
DEFINE g_detail3_d_o   type_g_detail3_d
DEFINE g_detail3_d_t   type_g_detail3_d
DEFINE g_acc          LIKE gzcb_t.gzcb007
DEFINE g_ooef004      LIKE ooef_t.ooef004
DEFINE g_rec_b        LIKE type_t.num5
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
 
#end add-point
 
{</section>}
 
{<section id="apmp482.main" >}
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
   CALL cl_ap_init("apm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmp482 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmp482_init()   
 
      #進入選單 Menu (="N")
      CALL apmp482_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apmp482
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   CALL s_apmp482_drop_table()
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apmp482.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION apmp482_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc("pmeo026",'4056')
   #抓取[T:系統分類值檔].[C:系統分類碼]=24且[T:系統分類值檔].[C:系統分類碼]=g_prog 的[T:系統分類值檔].[C:參考欄位]
   #SELECT gzcb004 INTO g_acc FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = 'apmt580' #160816-00001#7 mark
   LET g_acc = s_fin_get_scc_value('24','apmt580','2')  #160816-00001#7  Add
   
   SELECT ooef004 INTO g_ooef004 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
   CALL s_apmp482_create_table()
   LET g_master.pmeo026 = '1'
   CALL cl_set_comp_required("imaf001",TRUE)  
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apmp482.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmp482_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_xrcd113          LIKE xrcd_t.xrcd113
   DEFINE l_xrcd114          LIKE xrcd_t.xrcd114
   DEFINE l_xrcd115          LIKE xrcd_t.xrcd115
   DEFINE l_success          LIKE type_t.num5
   DEFINE l_flag             LIKE type_t.num5
   DEFINE l_where            STRING
   DEFINE l_pmds007 LIKE pmds_t.pmds007,
          l_pmds037 LIKE pmds_t.pmds037,
          l_pmds038 LIKE pmds_t.pmds038
   DEFINE l_chr LIKE type_t.chr1   

   DEFINE ls_result   STRING 
   DEFINE l_pmdsdocno LIKE pmds_t.pmdsdocno
   DEFINE l_sql1          STRING     #160711-00040#24 add
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_errshow=1
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apmp482_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc ON pmdxdocno,pmdx004,pmdy002,imaa009,pmdx002,pmdx003,imaf141,pmdx015,pmeo005
            BEFORE CONSTRUCT
            
                      
            ON ACTION controlp INFIELD pmdxdocno
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_pmdxdocno()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdxdocno  #顯示到畫面上
               NEXT FIELD pmdxdocno                     #返回原欄位
               
            ON ACTION controlp INFIELD pmdx004
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_pmaa001_3()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdx004  #顯示到畫面上
               NEXT FIELD pmdx004                     #返回原欄位
   
            ON ACTION controlp INFIELD pmdy002
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_imaa001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdy002  #顯示到畫面上
               NEXT FIELD pmdy002                     #返回原欄位
               
            ON ACTION controlp INFIELD imaa009
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_rtax001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上
               NEXT FIELD imaa009                     #返回原欄位
   
            ON ACTION controlp INFIELD imaf141
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_imce141()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaf141  #顯示到畫面上
               NEXT FIELD imaf141                     #返回原欄位
               
            ON ACTION controlp INFIELD pmdx002
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdx002  #顯示到畫面上
               NEXT FIELD pmdx002                     #返回原欄位 
   
            ON ACTION controlp INFIELD pmdx003
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_ooeg001_3()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdx003  #顯示到畫面上
               NEXT FIELD pmdx003                     #返回原欄位 
           
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_master.pmeo026,g_master.pmdsdocno,g_master.pmdt051,g_master.imaf001  

            ATTRIBUTE(WITHOUT DEFAULTS)

            ON CHANGE pmeo026
               IF g_master.pmeo026 = '1' THEN 
                  CALL cl_set_comp_required("imaf001",TRUE)
               ELSE
                  CALL cl_set_comp_required("imaf001",FALSE)
               END IF
            
            ON ACTION controlp INFIELD pmdsdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.pmdsdocno
               LET g_qryparam.arg1 = g_ooef004
               LET g_qryparam.arg2 = 'apmt580'
               #160711-00040#24 add(s)
               CALL s_control_get_docno_sql(g_user,g_dept)
                   RETURNING l_success,l_sql1
               IF NOT cl_null(l_sql1) THEN
                  LET g_qryparam.where = l_sql1
               END IF
               #160711-00040#24 add(e)
               CALL q_ooba002_1()
               LET g_master.pmdsdocno = g_qryparam.return1
               DISPLAY BY NAME g_master.pmdsdocno
#               CALL s_aooi200_get_slip_desc(g_master.pmdsdocno)
#                    RETURNING l_docno_desc
#               DISPLAY l_docno_desc TO docno_desc
               NEXT FIELD pmdsdocno
               
            ON ACTION controlp INFIELD pmdt051 
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
         
               LET g_qryparam.default1 = g_master.pmdt051             #給予default值
               LET g_qryparam.default2 = "" #g_master.oocq002 #應用分類碼
               #給予arg
               LET g_qryparam.arg1 = g_acc #s
               CALL q_oocq002()                                #呼叫開窗
               LET g_master.pmdt051 = g_qryparam.return1              
               DISPLAY g_master.pmdt051 TO pmdt051              #
               NEXT FIELD pmdt051                          #返回原欄位
         
            ON ACTION controlp INFIELD imaf001 
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
         
               LET g_qryparam.default1 = g_master.imaf001             #給予default值
               CALL s_control_get_item_sql('2',g_site,g_user,g_dept,g_master.pmdsdocno)
                    RETURNING l_success,l_where
               IF l_success THEN
                  LET g_qryparam.where = l_where
               END IF
               #給予arg
               CALL q_imaf001_17()                                #呼叫開窗
               LET g_master.imaf001 = g_qryparam.return1              
               DISPLAY g_master.imaf001 TO imaf001              
               NEXT FIELD imaf001                          #返回原欄位
            
         END INPUT 
         
         INPUT ARRAY g_detail_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS,
                     INSERT ROW = FALSE, 
                     DELETE ROW = FALSE,
                     APPEND ROW = FALSE) 
                     
            BEFORE INPUT
               CALL apmp482_chk() RETURNING l_chr
               CASE l_chr
                  WHEN '1'
                     NEXT FIELD pmdsdocno
                  WHEN '2'
                     NEXT FIELD pmdt051
                  WHEN '3'
                    NEXT FIELD imaf001
               END CASE            
               CALL FGL_SET_ARR_CURR(l_ac)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")            
            
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               DISPLAY l_ac TO FORMONLY.h_index
               
            ON CHANGE b_sel
               IF cl_null(l_ac) OR l_ac = 0 THEN
                  LET l_ac = DIALOG.getCurrentRow("s_detail1")
               END IF   
                  CALL s_apmp482_upd_pmds(g_detail_d[l_ac].sel,g_detail_d[l_ac].pmeo001,
                                          g_detail_d[l_ac].pmeo002,g_detail_d[l_ac].pmeo003,
                                          g_detail_d[l_ac].pmeo004,g_detail_d[l_ac].pmeo006,
                                          g_detail_d[l_ac].pmeo017,g_detail_d[l_ac].pmeo018,
                                          g_master.pmeo026,g_master.imaf001,g_master.pmdt051)                      
               #CALL apmp482_fill2()
         END INPUT
         
         DISPLAY ARRAY g_detail2_d TO s_detail2.*

            BEFORE DISPLAY             
               CALL apmp482_fill2()
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail2_idx = l_ac
               DISPLAY l_ac TO FORMONLY.h_index
               CALL apmp482_fill3()
               
         END DISPLAY
         
         INPUT ARRAY g_detail3_d FROM s_detail3.*
            ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                      INSERT ROW = FALSE,
                      DELETE ROW = FALSE,
                      APPEND ROW = FALSE)
                      
            BEFORE INPUT
               CALL FGL_SET_ARR_CURR(l_ac)
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               IF cl_null(l_ac) OR l_ac = 0 THEN
                  NEXT FIELD b_sel
               END IF
               IF g_master.pmeo026 = '2' THEN
                  CALL cl_set_comp_entry("pmdt006",TRUE)
               ELSE
                  CALL cl_set_comp_entry("pmdt006",FALSE)
               END IF  
               
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail3_d_o.* = g_detail3_d[l_ac].*
               LET g_detail3_d_t.* = g_detail3_d[l_ac].* 
               
               
            BEFORE FIELD pmdt006   
               CALL s_desc_get_item_desc(g_detail3_d[l_ac].pmdt006)
                    RETURNING g_detail3_d[l_ac].pmdt006_desc,g_detail3_d[l_ac].pmdt006_desc_1
            AFTER FIELD pmdt006
               IF NOT cl_null(g_detail3_d[l_ac].pmdt006) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_detail3_d[l_ac].pmdt006
                  IF NOT cl_chk_exist("v_imaf001_16") THEN
                     LET g_detail3_d[l_ac].pmdt006 = g_detail3_d_t.pmdt006
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
            AFTER FIELD pmdt036
               IF NOT cl_null(g_detail3_d[l_ac].pmdt036) THEN
                  IF g_detail3_d[l_ac].pmdt036 <> g_detail3_d_o.pmdt036 OR cl_null(g_detail3_d_o.pmdt036) THEN
#                     IF NOT cl_ap_chk_range(g_detail3_d[l_ac].pmdt036,"0","1","","","azz-00079",1) THEN
#                        LET g_detail3_d[l_ac].pmdt036 = g_detail3_d_o.pmdt036
#                        NEXT FIELD CURRENT
#                     END IF
                     #匯率
                     LET l_pmds007 = ''
                     LET l_pmds037 = ''
                     SELECT pmdx004,pmdx005 INTO l_pmds007,l_pmds037
                       FROM pmdx_t
                      WHERE pmdxent = g_enterprise
                        AND pmdxdocno = g_detail3_d[l_ac].pmdt070
                     CALL s_axmp441_get_exchange(l_pmds007,l_pmds037)
                          RETURNING l_pmds038
                     CALL s_tax_count(g_site,g_detail3_d[l_ac].pmdt046,g_detail3_d[l_ac].pmdt036,1,l_pmds037,l_pmds038)
                          RETURNING g_detail3_d[l_ac].pmdt038,g_detail3_d[l_ac].pmdt047,g_detail3_d[l_ac].pmdt039,l_xrcd113,l_xrcd114,l_xrcd115
                  END IF
               END IF
               LET g_detail3_d_o.pmdt036 = g_detail3_d[l_ac].pmdt036

            BEFORE FIELD pmdt051
               CALL apmp482_oocql_desc(g_acc,g_detail3_d[l_ac].pmdt051) RETURNING g_detail3_d[l_ac].pmdt051_desc
            AFTER FIELD pmdt051
               IF NOT cl_null(g_detail3_d[l_ac].pmdt051) THEN 
                  IF NOT s_azzi650_chk_exist(g_acc,g_detail3_d[l_ac].pmdt051) THEN
                     LET g_detail3_d[l_ac].pmdt051 = g_detail3_d_t.pmdt051
                     NEXT FIELD pmdt051
                  END IF
                  #檢核輸入的理由碼是否在單據別限制範圍內
                  CALL s_control_chk_doc('8',g_master.pmdsdocno,g_detail3_d[l_ac].pmdt051,'','','','')
                       RETURNING l_success,l_flag
                  IF NOT l_success OR NOT l_flag THEN
                     LET g_detail3_d[l_ac].pmdt051 = g_detail3_d_t.pmdt051
                     NEXT FIELD CURRENT
                  END IF                     
               END IF
               
            ON ACTION controlp INFIELD pmdt006   
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail3_d[l_ac].pmdt006
               CALL s_control_get_item_sql('2',g_site,g_user,g_dept,g_master.pmdsdocno)
                    RETURNING l_success,l_where
               IF l_success THEN
                  LET g_qryparam.where = l_where
               END IF
               CALL q_imaf001_17()
               LET g_detail3_d[l_ac].pmdt006 = g_qryparam.return1
               NEXT FIELD pmdt006
               
            ON ACTION controlp INFIELD pmdt051
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail3_d[l_ac].pmdt051
               CALL s_control_get_doc_sql('oocq002',g_master.pmdsdocno,'8')
                    RETURNING l_success,l_where
               IF l_success THEN
                  LET g_qryparam.where = l_where
               END IF
               LET g_qryparam.arg1 = g_acc
               CALL q_oocq002()
               LET g_detail3_d[l_ac].pmdt051 = g_qryparam.return1
               NEXT FIELD pmdt051
               
            ON ROW CHANGE
               UPDATE apmp482_d_pmdt  #151111 mod by Sarah
                  SET pmdt006 = g_detail3_d[l_ac].pmdt006,
                      pmdt036 = g_detail3_d[l_ac].pmdt036,
                      pmdt036 = g_detail3_d[l_ac].pmdt036,
                      pmdt039 = g_detail3_d[l_ac].pmdt039,
                      pmdt047 = g_detail3_d[l_ac].pmdt047,
                      pmdt051 = g_detail3_d[l_ac].pmdt051
                WHERE pmdtseq = g_detail3_d[l_ac].pmdtseq
                  AND pmdt070 = g_detail3_d[l_ac].pmdt070
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
            CALL apmp482_filter()
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
            CALL apmp482_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL apmp482_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            CALL apmp482_chk() RETURNING l_chr
            CASE l_chr
               WHEN '1'
                  NEXT FIELD pmdsdocno
               WHEN '2'
                  NEXT FIELD pmdt051
               WHEN '3'
                 NEXT FIELD imaf001
            END CASE
            CALL s_apmp482(g_master.pmdsdocno,'2') RETURNING l_pmdsdocno
            CALL apmp482_query()
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
 
{<section id="apmp482.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION apmp482_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   DELETE FROM apmp482_pmeo;
   DELETE FROM apmp482_d_pmds;  #151111 mod by Sarah
   DELETE FROM apmp482_d_pmdt;  #151111 mod by Sarah
   #end add-point
        
   LET g_error_show = 1
   CALL apmp482_b_fill()
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
 
{<section id="apmp482.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apmp482_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_success  LIKE type_t.num5
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(g_wc) THEN 
      LET g_wc = " 1=1"
   END IF
   
   LET g_sql = " SELECT 'N',pmeo001,pmeo002,pmeo005,pmdx004,pmaal004,pmeo006,imaal003,imaal004,",
               "        pmeo007,'',pmeo003,pmeo004,pmeo017,pmeo018,pmeo019,pmeo021,pmeo020,",
               "        pmeo014,pmeo015,pmeo016,pmeo010,pmeo011,pmeo012,pmeo013 ",
               "   FROM pmeo_t ",
               "        INNER JOIN pmdx_t ON pmeoent=pmdxent AND pmdxdocno=pmeo001 ",
               "        INNER JOIN pmdy_t ON pmeoent=pmdxent AND pmdydocno=pmeo001 AND pmeo002=pmdyseq ",
               "        LEFT OUTER JOIN pmaal_t ON pmdxent=pmaalent AND pmdx004=pmaal001 AND pmaal002='",g_dlang,"'",
               "        LEFT OUTER JOIN imaal_t ON pmeoent=imaalent AND pmeo006=imaal001 AND imaal002='",g_dlang,"'",
               "        INNER JOIN imaf_t ON imafent=pmeoent AND imafsite=pmeosite AND imaf001=pmeo006 ",
               "  WHERE pmeoent = ? AND pmeosite = '",g_site,"' AND ",g_wc,
               "    AND pmeo025 = '1' ",
               "  ORDER BY pmeo001,pmeo002,pmeo005"           
   #end add-point
 
   PREPARE apmp482_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apmp482_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   CALL g_detail2_d.clear()
   CALL g_detail3_d.clear()
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
    g_detail_d[l_ac].sel,g_detail_d[l_ac].pmeo001,g_detail_d[l_ac].pmeo002,g_detail_d[l_ac].pmeo005,
    g_detail_d[l_ac].pmdx004,g_detail_d[l_ac].pmdx004_desc,
    g_detail_d[l_ac].pmeo006,g_detail_d[l_ac].pmeo006_desc,g_detail_d[l_ac].pmeo006_desc_1,
    g_detail_d[l_ac].pmeo007,g_detail_d[l_ac].pmeo007_desc,g_detail_d[l_ac].pmeo003,g_detail_d[l_ac].pmeo004,
    g_detail_d[l_ac].pmeo017,g_detail_d[l_ac].pmeo018,g_detail_d[l_ac].pmeo019,g_detail_d[l_ac].pmeo021,
    g_detail_d[l_ac].pmeo020,g_detail_d[l_ac].pmeo014,g_detail_d[l_ac].pmeo015,g_detail_d[l_ac].pmeo016,
    g_detail_d[l_ac].pmeo010,g_detail_d[l_ac].pmeo011,g_detail_d[l_ac].pmeo012,g_detail_d[l_ac].pmeo013
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
      CALL s_feature_description(g_detail_d[l_ac].pmeo006,g_detail_d[l_ac].pmeo007) RETURNING l_success,g_detail_d[l_ac].pmeo007_desc
      #end add-point
      
      CALL apmp482_detail_show()      
 
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
   FREE apmp482_sel
   
   LET l_ac = 1
   CALL apmp482_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmp482.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apmp482_fetch()
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
 
{<section id="apmp482.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apmp482_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmp482.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION apmp482_filter()
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
   CALL g_detail_d.clear()
   CALL g_detail2_d.clear()
   CALL g_detail3_d.clear()

   CONSTRUCT g_wc_filter ON pmeo001,pmeo002,pmeo005,pmeo004,pmeo006,pmeo007,pmeo003,pmeo004,pmeo017,pmeo018,
                            pmeo019,pmeo021,pmeo020,pmeo014,pmeo015,pmeo016,pmeo010,pmeo011,pmeo012,pmeo013
        FROM s_detail1[1].b_pmeo001,s_detail1[1].b_pmeo002,s_detail1[1].b_pmeo005,s_detail1[1].b_pmeo004,s_detail1[1].b_pmeo006,
             s_detail1[1].b_pmeo007,s_detail1[1].b_pmeo003,s_detail1[1].b_pmeo004,s_detail1[1].b_pmeo017,s_detail1[1].b_pmeo018,
             s_detail1[1].b_pmeo019,s_detail1[1].b_pmeo021,s_detail1[1].b_pmeo020,s_detail1[1].b_pmeo014,s_detail1[1].b_pmeo015,
             s_detail1[1].b_pmeo016,s_detail1[1].b_pmeo010,s_detail1[1].b_pmeo011,s_detail1[1].b_pmeo012,s_detail1[1].b_pmeo013
           
      BEFORE CONSTRUCT
      
         ON ACTION controlp INFIELD b_pmeo001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xmdxdocno()
            DISPLAY g_qryparam.return1 TO b_pmeo001
            NEXT FIELD b_pmeo001
            
         ON ACTION controlp INFIELD b_pmeo004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_3()
            DISPLAY g_qryparam.return1 TO b_pmeo004
            NEXT FIELD b_pmeo004
            
         ON ACTION controlp INFIELD b_pmeo006
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001()
            DISPLAY g_qryparam.return1 TO b_pmeo006
            NEXT FIELD b_pmeo006
   
         ON ACTION controlp INFIELD b_pmeo003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg2 = g_site
            CALL q_pmeo003()
            DISPLAY g_qryparam.return1 TO b_pmeo003
            NEXT FIELD b_pmeo003

   END CONSTRUCT
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL apmp482_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="apmp482.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION apmp482_filter_parser(ps_field)
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
 
{<section id="apmp482.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION apmp482_filter_show(ps_field,ps_object)
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
   LET ls_condition = apmp482_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apmp482.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION apmp482_create_table()
 DROP TABLE apmp482_d_pmds;  #151111 mod by Sarah
 CREATE TEMP TABLE apmp482_d_pmds(
   pmds007  VARCHAR(10),   
   pmds031  VARCHAR(10), 
   pmds032  VARCHAR(10), 
   pmds033  VARCHAR(10), 
   pmds034  DECIMAL(5,2),
   pmds035  VARCHAR(1),
   pmds037  VARCHAR(10),
   pmds038  DECIMAL(20,10),
   pmdt043  VARCHAR(20)
 );
 DROP TABLE apmp482_d_pmdt;  #151111 mod by Sarah
 CREATE TEMP TABLE apmp482_d_pmdt( 
   pmdtseq  INTEGER,
   pmdt006  VARCHAR(40), 
   pmdt007  VARCHAR(256), 
   pmdt019  VARCHAR(10), 
   pmdt020  DECIMAL(20,6), 
   pmdt021  VARCHAR(10),
   pmdt022  DECIMAL(20,6),
   pmdt023  VARCHAR(10),
   pmdt024  DECIMAL(20,6),
   pmdt046  VARCHAR(10),
   pmdt037  DECIMAL(5,2),
   pmdt036  DECIMAL(20,6),
   pmdt038  DECIMAL(20,6),
   pmdt039  DECIMAL(20,6),
   pmdt047  DECIMAL(20,6),
   pmdt051  VARCHAR(10),
   pmdt043  VARCHAR(20)
 );   
END FUNCTION

PRIVATE FUNCTION apmp482_fill2()
DEFINE l_i          LIKE type_t.num5
DEFINE l_cnt        LIKE type_t.num5
DEFINE l_pmds028    LIKE pmds_t.pmds028 #161207-00033#20

   LET g_sql = "SELECT pmds007,pmaal004,pmds031,pmds032,pmds033,",
               "        pmds034,pmds035,pmds037,pmds038,pmds055,pmds028 ",  #161207-00033#20 add pmds028
               "  FROM apmp482_d_pmds ",  #151111 mod by Sarah
               "       LEFT OUTER JOIN pmaal_t ON pmaalent='",g_enterprise,"' AND pmaal001=pmds007 AND pmaal002='",g_dlang,"'",
               " ORDER BY pmds007 "
   PREPARE apmp482_sel2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR apmp482_sel2
   
   CALL g_detail2_d.clear()
   CALL g_detail3_d.clear()
   LET l_cnt = 1   
   FOREACH b_fill_curs2 INTO g_detail2_d[l_cnt].pmds007,g_detail2_d[l_cnt].pmds007_desc,g_detail2_d[l_cnt].pmds031, 
                             g_detail2_d[l_cnt].pmds032,g_detail2_d[l_cnt].pmds033,g_detail2_d[l_cnt].pmds034,
                             g_detail2_d[l_cnt].pmds035,g_detail2_d[l_cnt].pmds037,g_detail2_d[l_cnt].pmds038,
                             g_detail2_d[l_cnt].pmds055,l_pmds028
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF    
      #161207-00033#20-S
      IF NOT cl_null(l_pmds028) THEN
         CALL s_desc_get_oneturn_guest_desc(l_pmds028) RETURNING g_detail2_d[l_cnt].pmds007_desc 
      END IF
      #161207-00033#20-E
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
   #CALL apmp482_fill3()
END FUNCTION

PRIVATE FUNCTION apmp482_oocql_desc(p_oocql001,p_oocql002)
DEFINE p_oocql001 LIKE oocql_t.oocql001,
       p_oocql002 LIKE oocql_t.oocql002,
       r_oocql004 LIKE oocql_t.oocql004
       
   LET r_oocql004 = ''
   SELECT oocql004 INTO r_oocql004
     FROM oocql_t
    WHERE oocqlent = g_enterprise
      AND oocql001 = p_oocql001
      AND oocql002 = p_oocql002
      AND oocql003 = g_dlang
   RETURN r_oocql004       
END FUNCTION

PRIVATE FUNCTION apmp482_fill3()
DEFINE l_cnt LIKE type_t.num5   
   
   
   IF g_detail2_idx = 0 OR cl_null(g_detail2_idx) THEN 
      RETURN
   END IF
   LET g_sql = "SELECT pmdtseq,pmdt006,imaal003,imaal004,pmdt007,'',pmdt019,pmdt020,pmdt021,pmdt022,pmdt023,pmdt024,",
               "       pmdt046,pmdt037,pmdt036,pmdt038,pmdt039,pmdt047,pmdt051,oocql004,pmdt070,pmdt071",
               "  FROM apmp482_d_pmdt ",  #151111 mod by Sarah
               "       LEFT OUTER JOIN imaal_t ON imaalent='",g_enterprise,"' AND imaal001=pmdt006 AND imaal002='",g_dlang,"'",
               "       LEFT OUTER JOIN oocql_t ON oocqlent='",g_enterprise,"' AND oocql001='",g_acc,"' AND oocql002=pmdt051 AND oocql003='",g_dlang,"'",
               " WHERE pmdt070 = '",g_detail2_d[g_detail2_idx].pmds055,"'",
               " ORDER BY pmdtseq "
   PREPARE apmp482_sel3 FROM g_sql
   DECLARE b_fill_curs3 CURSOR FOR apmp482_sel3
   
   CALL g_detail3_d.clear()
   LET l_cnt = 1   
   FOREACH b_fill_curs3 INTO g_detail3_d[l_cnt].pmdtseq,g_detail3_d[l_cnt].pmdt006,
                             g_detail3_d[l_cnt].pmdt006_desc,g_detail3_d[l_cnt].pmdt006_desc_1,
                             g_detail3_d[l_cnt].pmdt007,g_detail3_d[l_cnt].pmdt007_desc,
                             g_detail3_d[l_cnt].pmdt019,g_detail3_d[l_cnt].pmdt020,
                             g_detail3_d[l_cnt].pmdt021,g_detail3_d[l_cnt].pmdt022,g_detail3_d[l_cnt].pmdt023,
                             g_detail3_d[l_cnt].pmdt024,g_detail3_d[l_cnt].pmdt046,g_detail3_d[l_cnt].pmdt037,
                             g_detail3_d[l_cnt].pmdt036,g_detail3_d[l_cnt].pmdt038,g_detail3_d[l_cnt].pmdt039,
                             g_detail3_d[l_cnt].pmdt047,g_detail3_d[l_cnt].pmdt051,g_detail3_d[l_cnt].pmdt051_desc,
                             g_detail3_d[l_cnt].pmdt070,g_detail3_d[l_cnt].pmdt071
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

PRIVATE FUNCTION apmp482_chk()
DEFINE r_chr LIKE type_t.chr1

   LET r_chr = '0'
   IF cl_null(g_master.pmdsdocno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00532'
      LET g_errparam.popup = FALSE
      CALL cl_err()
      LET r_chr = '1'
      RETURN r_chr
   END IF
   IF cl_null(g_master.pmdt051) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axm-00622'
      LET g_errparam.popup = FALSE
      CALL cl_err()
      LET r_chr = '2'
      RETURN r_chr      
   END IF
   IF g_master.pmeo026 = '1' AND cl_null(g_master.imaf001) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00847'
      LET g_errparam.popup = FALSE
      CALL cl_err()
      LET r_chr = '3'
      RETURN r_chr      
   END IF
   RETURN r_chr
END FUNCTION

#end add-point
 
{</section>}
 
