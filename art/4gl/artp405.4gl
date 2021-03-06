#該程式未解開Section, 採用最新樣板產出!
{<section id="artp405.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2016-04-13 14:00:52), PR版次:0005(2016-11-14 16:30:57)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000039
#+ Filename...: artp405
#+ Description: 商品開帳導入作業
#+ Creator....: 03247(2015-11-27 16:43:05)
#+ Modifier...: 03247 -SD/PR- 02481
 
{</section>}
 
{<section id="artp405.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#48  2016/04/29  By 07959   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#161111-00028#3   2016/11/14  BY 02481    标准程式定义采用宣告模式,弃用.*写法
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
   sel          LIKE type_t.chr1,
   rtdqsite     LIKE rtdq_t.rtdqsite,
   rtdqsite_desc LIKE ooefl_t.ooefl003,
   rtdq001      LIKE rtdq_t.rtdq001,
   rtdq003      LIKE rtdq_t.rtdq003,
   rtdq003_desc LIKE rtaxl_t.rtaxl003,
   rtdq004      LIKE rtdq_t.rtdq004,
   rtdq005      LIKE rtdq_t.rtdq005,
   rtdq006      LIKE rtdq_t.rtdq006,
   rtdq008      LIKE rtdq_t.rtdq008,
   rtdq009      LIKE rtdq_t.rtdq009,
   rtdq036      LIKE rtdq_t.rtdq036,
   rtdq007      LIKE rtdq_t.rtdq007,
   rtdq041      LIKE rtdq_t.rtdq041,
   rtdq002      LIKE rtdq_t.rtdq002,
   rtdq002_desc LIKE rtaxl_t.rtaxl003,
   rtdq010      LIKE rtdq_t.rtdq010,
   rtdq021      LIKE rtdq_t.rtdq021,
   rtdq022      LIKE rtdq_t.rtdq022,
   rtdq028      LIKE rtdq_t.rtdq028,
   rtdq042      LIKE rtdq_t.rtdq042,
   rtdq043      LIKE rtdq_t.rtdq043,
   rtdq013      LIKE rtdq_t.rtdq013,
   rtdq013_desc LIKE oodbl_t.oodbl004,    #20151208 dongsz add
   rtdq011      LIKE rtdq_t.rtdq011,
   rtdq012      LIKE rtdq_t.rtdq012,
   rtdq027      LIKE rtdq_t.rtdq027,
   rtdq027_desc LIKE oodbl_t.oodbl004,    #20151208 dongsz add
   rtdq019      LIKE rtdq_t.rtdq019,
   rtdq020      LIKE rtdq_t.rtdq020,
   rtdq044      LIKE rtdq_t.rtdq044,
   rtdq045      LIKE rtdq_t.rtdq045,
   rtdq046      LIKE rtdq_t.rtdq046,
   rtdq037      LIKE rtdq_t.rtdq037,   #20151031 dongsz add
   rtdq047      LIKE rtdq_t.rtdq047,  
   rtdq030      LIKE rtdq_t.rtdq030,
   rtdq038      LIKE rtdq_t.rtdq038,   #20151031 dongsz add
   rtdq029      LIKE rtdq_t.rtdq029,
   rtdq023      LIKE rtdq_t.rtdq023,
   rtdq024      LIKE rtdq_t.rtdq024,
   rtdq035      LIKE rtdq_t.rtdq035,
   rtdq032      LIKE rtdq_t.rtdq032,
   rtdq033      LIKE rtdq_t.rtdq033,
   rtdq034      LIKE rtdq_t.rtdq034,
   rtdq014      LIKE rtdq_t.rtdq014,
   rtdq015      LIKE rtdq_t.rtdq015,
   rtdq016      LIKE rtdq_t.rtdq016,
   rtdq017      LIKE rtdq_t.rtdq017,
   rtdq018      LIKE rtdq_t.rtdq018,
   rtdq025      LIKE rtdq_t.rtdq025,
   rtdq026      LIKE rtdq_t.rtdq026,
   rtdq031      LIKE rtdq_t.rtdq031
                END RECORD
TYPE type_g_detail_d2 RECORD
   sel1         LIKE type_t.chr1,
   rtdusite     LIKE rtdu_t.rtdusite,
   rtdusite_desc LIKE ooefl_t.ooefl003,
   rtdudocdt    LIKE rtdu_t.rtdudocdt,
   rtdudocno    LIKE rtdu_t.rtdudocno,
   rtdu001      LIKE rtdu_t.rtdu001,
   rtdu001_desc LIKE pmaal_t.pmaal004,
   rtdu002      LIKE rtdu_t.rtdu002,
   rtdu003      LIKE rtdu_t.rtdu003,
   rtdu004      LIKE rtdu_t.rtdu004,
   rtdu012      LIKE rtdu_t.rtdu012,
   rtdu005      LIKE rtdu_t.rtdu005,
   rtdu005_desc LIKE ooefl_t.ooefl003,
   rtdu007      LIKE rtdu_t.rtdu007,
   rtdu007_desc LIKE ooefl_t.ooefl003,
   rtdu011      LIKE rtdu_t.rtdu011,
   rtdu011_desc LIKE ooall_t.ooall004,
   rtdu009      LIKE rtdu_t.rtdu009,
   rtdustus     LIKE rtdu_t.rtdustus
                END RECORD
TYPE type_g_detail_d3 RECORD
   rtdvseq      LIKE rtdv_t.rtdvseq,
   rtdv002      LIKE rtdv_t.rtdv002,
   rtdv001      LIKE rtdv_t.rtdv001,
   imaal003     LIKE imaal_t.imaal003,
   imaal004     LIKE imaal_t.imaal004,
   rtdv018      LIKE rtdv_t.rtdv018,
   rtdv023      LIKE rtdv_t.rtdv023,
   rtdv024      LIKE rtdv_t.rtdv024,
   rtdv025      LIKE rtdv_t.rtdv025,
   rtdv026      LIKE rtdv_t.rtdv026,
   rtdv020      LIKE rtdv_t.rtdv020,
   rtdv021      LIKE rtdv_t.rtdv021,
   rtdv022      LIKE rtdv_t.rtdv022,
   rtdv004      LIKE rtdv_t.rtdv004,
   rtdv004_desc LIKE oodbl_t.oodbl004,
   rtdv006      LIKE rtdv_t.rtdv006,
   rtdv006_desc LIKE oodbl_t.oodbl004,
   rtdv008      LIKE rtdv_t.rtdv008,
   rtdv009      LIKE rtdv_t.rtdv009,
   rtdv009_desc LIKE oocal_t.oocal003,
   rtdv011      LIKE rtdv_t.rtdv011,
   rtdv033      LIKE rtdv_t.rtdv033,
   rtdv033_desc LIKE ooail_t.ooail003,
   rtdv017      LIKE rtdv_t.rtdv017,
   rtdv019      LIKE rtdv_t.rtdv019,
   rtdv031      LIKE rtdv_t.rtdv031,
   rtdv029      LIKE rtdv_t.rtdv029,
   rtdv029_desc LIKE oocal_t.oocal003,
   rtdv040      LIKE rtdv_t.rtdv040,
   rtdv003      LIKE rtdv_t.rtdv003,
   rtdv010      LIKE rtdv_t.rtdv010,
   rtdv010_desc LIKE oocal_t.oocal003,
   rtdv013      LIKE rtdv_t.rtdv013,
   rtdv013_desc LIKE ooag_t.ooag011,
   rtdv014      LIKE rtdv_t.rtdv014,
   rtdv015      LIKE rtdv_t.rtdv015,
   rtdv016      LIKE rtdv_t.rtdv016,
   rtdv034      LIKE rtdv_t.rtdv034,
   rtdv035      LIKE rtdv_t.rtdv035,
   rtdv036      LIKE rtdv_t.rtdv036,
   rtdv037      LIKE rtdv_t.rtdv037,
   rtdv038      LIKE rtdv_t.rtdv038,
   rtdv032      LIKE rtdv_t.rtdv032,
   rtdv032_desc LIKE oocal_t.oocal003,
   rtdv027      LIKE rtdv_t.rtdv027,
   rtdv028      LIKE rtdv_t.rtdv028
                END RECORD
TYPE type_g_detail_d4 RECORD
   rtdw001      LIKE rtdw_t.rtdw001,
   rtdw001_desc LIKE type_t.chr500,
   rtdw002      LIKE rtdw_t.rtdw002,
   rtdw002_desc LIKE type_t.chr500
                END RECORD
DEFINE g_rec_b              LIKE type_t.num5
DEFINE g_detail_idx         LIKE type_t.num5
DEFINE g_detail_idx2        LIKE type_t.num5
DEFINE g_time   LIKE prda_t.prda027
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_loc                 LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_add_browse          STRING                        #新增填充用WC
DEFINE g_update              BOOLEAN                       #確定單頭/身是否異動過
DEFINE g_chk                 LIKE type_t.chr1
DEFINE g_chk1                LIKE type_t.chr1
DEFINE g_chk2                LIKE type_t.chr1
DEFINE g_imaf061             LIKE imaf_t.imaf061
DEFINE g_imaf062             LIKE imaf_t.imaf062
DEFINE g_imaf063             LIKE imaf_t.imaf063
DEFINE g_imaf064             LIKE imaf_t.imaf064
DEFINE g_detail_d_t        type_g_detail_d
DEFINE g_detail_d_o        type_g_detail_d
DEFINE g_detail_d2  DYNAMIC ARRAY OF type_g_detail_d2
DEFINE g_detail_d3  DYNAMIC ARRAY OF type_g_detail_d3
DEFINE g_detail_d4  DYNAMIC ARRAY OF type_g_detail_d4
DEFINE g_flag_wc             LIKE type_t.chr1         #是否点击确定查询
DEFINE g_wc_o                STRING 
DEFINE g_wc1                 STRING
DEFINE g_wc3                 STRING
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="artp405.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
   #add-point:main段define name="main.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("art","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_artp405 WITH FORM cl_ap_formpath("art",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL artp405_init()   
 
      #進入選單 Menu (="N")
      CALL artp405_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      CALL s_aooi500_drop_temp() RETURNING l_success
      CALL artp405_tmp('2') RETURNING l_success       #20151016 dongsz add
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_artp405
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="artp405.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION artp405_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_gzcbl004   LIKE gzcbl_t.gzcbl004
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('imaf061','1012')
   CALL cl_set_combo_scc('imaf064','1014')
   CALL cl_set_combo_scc('b_rtdq028','2002')
   CALL cl_set_combo_scc('b_rtdq042','2003')
   CALL cl_set_combo_scc_part('b_rtdq043','6553','1,4,5')
   CALL cl_set_combo_scc('rtdu003','6013')
   CALL cl_set_combo_scc('rtdu012','6014')
   CALL cl_set_combo_scc_part('rtdustus','13','N,Y,D,R,W,A,X')
   CALL s_life_cycle_display('artm300','b_rtdq047','1')
   CALL s_life_cycle_display('artt405','rtdu009','1')
   CALL cl_set_combo_scc('rtdv034','2025')
   CALL cl_set_combo_scc('rtdv035','2028')
   CALL cl_set_combo_scc('rtdv036','2027')
   
   #栏位名称重新显示
   CALL s_desc_gzcbl004_desc('6899','1') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("b_rtdq044",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','2') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("b_rtdq045",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','3') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("b_rtdq046",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','1') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("rtdv024",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','2') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("rtdv025",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','3') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("rtdv026",l_gzcbl004)
   
   CALL s_aooi500_create_temp() RETURNING l_success
   CALL artp405_tmp('1') RETURNING l_success    #20151016 dongsz add
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="artp405.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION artp405_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE la_param   RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
          END RECORD
   DEFINE ls_js      STRING
   DEFINE l_time     DATETIME YEAR TO SECOND
   DEFINE r_success  LIKE type_t.num5
   DEFINE l_sql      STRING
   DEFINE l_where    STRING
   DEFINE p_cmd      LIKE type_t.chr1
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_loop     LIKE type_t.num5
   DEFINE l_msg      STRING
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET p_cmd = 'a'
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL artp405_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT g_wc1 ON rtdq032,rtdq039,rtdq040,rtdq023,rtdq004 FROM rtdq032,rtdq039,rtdq040,rtdq023,rtdq004
         
            BEFORE CONSTRUCT
               CALL cl_qbe_init()
               LET g_flag_wc = "N"
               LET g_wc3 = " 1=1 "
            
            ON ACTION controlp INFIELD rtdq032
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtdqsite',g_site,'c')
               LET g_qryparam.where = cl_replace_str(g_qryparam.where,'ooef001','rtdqsite')
               IF g_chk = 'Y' THEN
                  LET g_qryparam.where = g_qryparam.where," AND rtdq033 IS NULL "
               END IF
               CALL q_rtdq032()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO rtdq032  #顯示到畫面上
               LET g_qryparam.where = ""
               NEXT FIELD rtdq032 
               
            ON ACTION controlp INFIELD rtdq040
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001_6()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO rtdq040  #顯示到畫面上
               LET g_qryparam.where = ""
               NEXT FIELD rtdq040

            ON ACTION controlp INFIELD rtdq023
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_pmaa001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO rtdq023  #顯示到畫面上
               LET g_qryparam.where = ""
               NEXT FIELD rtdq023
               
            ON ACTION controlp INFIELD rtdq004
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaa001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO rtdq004  #顯示到畫面上
               LET g_qryparam.where = ""
               NEXT FIELD rtdq004
               
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT g_chk,g_chk1,g_chk2,g_imaf061,g_imaf062,g_imaf063,g_imaf064
          FROM chk,chk1,chk2,imaf061,imaf062,imaf063,imaf064
          
            BEFORE INPUT
               LET g_flag_wc = "N"
               LET g_wc3 = " 1=1 "
            
            BEFORE FIELD imaf061
            
            AFTER FIELD imaf061
               IF g_imaf061 = '2' THEN
                  LET g_imaf062 = 'N'
                  LET g_imaf063 = ''
               END IF
               CALL artp405_set_entry(p_cmd)
               CALL artp405_set_no_required(p_cmd)
               CALL artp405_set_required(p_cmd)
               CALL artp405_set_no_entry(p_cmd)
               
            ON CHANGE imaf061
               IF g_imaf061 = '2' THEN
                  LET g_imaf062 = 'N'
                  LET g_imaf063 = ''
               END IF
               CALL artp405_set_entry(p_cmd)
               CALL artp405_set_no_required(p_cmd)
               CALL artp405_set_required(p_cmd)
               CALL artp405_set_no_entry(p_cmd)
               
            BEFORE FIELD imaf062
            
            AFTER FIELD imaf062
               IF g_imaf062 = 'N' THEN
                  LET g_imaf063 = ''
                  #LET g_imaa_m.imaf063_desc = ''
                  #DISPLAY g_imaa_m.imaf063_desc TO imaf063_desc
               END IF
               CALL artp405_set_entry(p_cmd)
               CALL artp405_set_no_required(p_cmd)
               CALL artp405_set_required(p_cmd)
               CALL artp405_set_no_entry(p_cmd)
               
            ON CHANGE imaf062
               IF g_imaf062 = 'N' THEN
                  LET g_imaf063 = ''
                  #LET g_imaa_m.imaf063_desc = ''
                  #DISPLAY g_imaa_m.imaf063_desc TO imaf063_desc
               END IF
               CALL artp405_set_entry(p_cmd)
               CALL artp405_set_no_required(p_cmd)
               CALL artp405_set_required(p_cmd)
               CALL artp405_set_no_entry(p_cmd)
               
            AFTER FIELD imaf063
               IF NOT cl_null(g_imaf063) THEN
                  #應用 a17 樣板自動產生(Version:2)
                  #欄位存在檢查
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
               
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_imaf063
                  #160318-00025#48  2016/04/29  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "apj-00004:sub-01302|aooi390|",cl_get_progname("aooi390",g_lang,"2"),"|:EXEPROGaooi390"
                  #160318-00025#48  2016/04/29  by pengxin  add(E)
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_oofg001_1") THEN
                     #檢查成功時後續處理
                  ELSE
                     #檢查失敗時後續處理
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #INITIALIZE g_ref_fields TO NULL
               #LET g_ref_fields[1] = g_imaa_m.imaf063
               #CALL ap_ref_array2(g_ref_fields,"SELECT oofgl004 FROM oofgl_t WHERE oofglent='"||g_enterprise||"' AND oofgl001=' ' AND oofgl002=? AND oofgl003='"||g_dlang||"'","") RETURNING g_rtn_fields
               #LET g_imaa_m.imaf063_desc = '', g_rtn_fields[1] , ''
               #DISPLAY BY NAME g_imaa_m.imaf063_desc
               
            BEFORE FIELD imaf063
            
            ON CHANGE imaf063
            
            BEFORE FIELD imaf064
            
            AFTER FIELD imaf064
            
            ON CHANGE imaf064
            
            ON ACTION controlp INFIELD imaf063
               #add-point:ON ACTION controlp INFIELD imaf063
               #應用 a07 樣板自動產生(Version:2)
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               
               LET g_qryparam.default1 = g_imaf063             #給予default值
               
               #給予arg
               LET g_qryparam.arg1 = "6" #s
               
               CALL q_oofg001_3()                                #呼叫開窗
               
               LET g_imaf063 = g_qryparam.return1
               
               DISPLAY g_imaf063 TO imaf063              #
               
               NEXT FIELD imaf063                          #返回原欄位
            
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b)
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_cnt = g_detail_d.getLength()
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_detail_cnt TO FORMONLY.h_count
               CALL artp405_fetch()
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               CALL artp405_b_fill()
               
         END DISPLAY
         
         DISPLAY ARRAY g_detail_d2 TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx2 = l_ac
               LET g_detail_cnt = g_detail_d2.getLength()
               DISPLAY g_detail_idx2 TO FORMONLY.h_index
               DISPLAY g_detail_cnt TO FORMONLY.h_count
               CALL artp405_b_fill2()
               CALL artp405_b_fill3()
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx2)
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               #CALL artp405_fetch()
               
         END DISPLAY
         
         DISPLAY ARRAY g_detail_d3 TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_cnt = g_detail_d3.getLength()
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_detail_cnt TO FORMONLY.h_count
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               
         END DISPLAY
         
         DISPLAY ARRAY g_detail_d4 TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx = l_ac
               LET g_detail_cnt = g_detail_d4.getLength()
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_detail_cnt TO FORMONLY.h_count
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               
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
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_chk = 'Y'
            LET g_chk1 = 'Y'
            LET g_chk2 = 'Y'
            LET g_imaf061 = '1'
            LET g_imaf062 = 'Y'
            LET g_imaf063 = ''
            LET g_imaf064 = '1'
            CALL artp405_imaf063_default()
            CALL artp405_set_entry(p_cmd)
            CALL artp405_set_no_required(p_cmd)
            CALL artp405_set_required(p_cmd)
            CALL artp405_set_no_entry(p_cmd)
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            #确定点击的单身
            LET g_aw = g_curr_diag.getCurrentItem()
            CASE g_aw
               WHEN "s_detail1"
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
               UPDATE rtdq_t SET rtdqacti = 'Y'
                WHERE rtdqent = g_enterprise
                  AND rtdqsite = g_detail_d[li_idx].rtdqsite
                  AND rtdq004 = g_detail_d[li_idx].rtdq004
                  AND rtdq032 = g_detail_d[li_idx].rtdq032
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
               WHEN "s_detail2"
                  FOR li_idx = 1 TO g_detail_d2.getLength()
                     LET g_detail_d2[li_idx].sel1 = "Y"
                  END FOR
            END CASE
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone name="ui_dialog.for.onaction_selnone"
               EXIT FOR
               #UPDATE rtdq_t SET rtdqacti = 'N'
               # WHERE rtdqent = g_enterprise
               #   AND rtdqsite = g_detail_d[li_idx].rtdqsite
               #   AND rtdq004 = g_detail_d[li_idx].rtdq004
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            #LET g_detail_d[1].sel = g_detail_d[li_idx].sel
            #确定点击的单身
            LET g_aw = g_curr_diag.getCurrentItem()
            CASE g_aw
               WHEN "s_detail1"           
                  FOR li_idx = 1 TO g_detail_d.getLength()
                     LET g_detail_d[li_idx].sel = "N"
                     UPDATE rtdq_t SET rtdqacti = 'N'
                      WHERE rtdqent = g_enterprise
                        AND rtdqsite = g_detail_d[li_idx].rtdqsite
                        AND rtdq004 = g_detail_d[li_idx].rtdq004
                        AND rtdq032 = g_detail_d[li_idx].rtdq032
                  END FOR
               WHEN "s_detail2"
                  FOR li_idx = 1 TO g_detail_d2.getLength()
                     LET g_detail_d2[li_idx].sel1 = "N"
                  END FOR
            END CASE
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            #FOR li_idx = 1 TO g_detail_d.getLength()
            #   IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
            #      UPDATE rtdq_t SET rtdqacti = 'Y'
            #       WHERE rtdqent = g_enterprise
            #         AND rtdqsite = g_detail_d[li_idx].rtdqsite
            #         AND rtdq004 = g_detail_d[li_idx].rtdq004
            #   END IF
            #END FOR
            #确定点击的单身
            LET g_aw = g_curr_diag.getCurrentItem()
            CASE g_aw
               WHEN "s_detail1"           
                  FOR li_idx = 1 TO g_detail_d.getLength()
                     IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                        LET g_detail_d[li_idx].sel = "Y"
                        UPDATE rtdq_t SET rtdqacti = 'Y'
                         WHERE rtdqent = g_enterprise
                           AND rtdqsite = g_detail_d[li_idx].rtdqsite
                           AND rtdq004 = g_detail_d[li_idx].rtdq004
                           AND rtdq032 = g_detail_d[li_idx].rtdq032
                     END IF
                  END FOR
               WHEN "s_detail2"
                  FOR li_idx = 1 TO g_detail_d2.getLength()
                     IF DIALOG.isRowSelected("s_detail2", li_idx) THEN
                        LET g_detail_d2[li_idx].sel1 = "Y"
                     END IF
                  END FOR
            END CASE
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            #FOR li_idx = 1 TO g_detail_d.getLength()
            #   IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
            #      UPDATE rtdq_t SET rtdqacti = 'N'
            #       WHERE rtdqent = g_enterprise
            #         AND rtdqsite = g_detail_d[li_idx].rtdqsite
            #         AND rtdq004 = g_detail_d[li_idx].rtdq004
            #   END IF
            #END FOR
            #确定点击的单身
            LET g_aw = g_curr_diag.getCurrentItem()
            CASE g_aw
               WHEN "s_detail1"           
                  FOR li_idx = 1 TO g_detail_d.getLength()
                     IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                        LET g_detail_d[li_idx].sel = "N"
                        UPDATE rtdq_t SET rtdqacti = 'N'
                         WHERE rtdqent = g_enterprise
                           AND rtdqsite = g_detail_d[li_idx].rtdqsite
                           AND rtdq004 = g_detail_d[li_idx].rtdq004
                           AND rtdq032 = g_detail_d[li_idx].rtdq032
                     END IF
                  END FOR
               WHEN "s_detail2"
                  FOR li_idx = 1 TO g_detail_d2.getLength()
                     IF DIALOG.isRowSelected("s_detail2", li_idx) THEN
                        LET g_detail_d2[li_idx].sel1 = "N"
                     END IF
                  END FOR
            END CASE
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL artp405_filter()
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
            LET g_flag_wc = "Y"
            #end add-point
            CALL artp405_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            CLEAR FORM
            LET g_wc = NULL
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL artp405_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_confirm
            LET g_action_choice="batch_confirm"
            IF cl_auth_chk_act("batch_confirm") THEN
               CALL cl_progress_bar_no_window(2)   #160225-00040#18 2016/04/13 s983961--add
               IF NOT cl_ask_confirm('art-00745') THEN
                  CONTINUE DIALOG
               END IF
               CALL cl_err_collect_init()
               
               #160225-00040#18 2016/04/13 s983961--add(s)
               LET l_msg = cl_getmsg('ast-00330',g_lang)   
               CALL cl_progress_no_window_ing(l_msg)
               #160225-00040#18 2016/04/13 s983961--add(e)               
               FOR li_idx = 1 TO g_detail_d2.getLength()
                  IF g_detail_d2[li_idx].rtdustus <> 'N' OR g_detail_d2[li_idx].sel1 <> 'Y' THEN
                     CONTINUE FOR
                  END IF
                  LET l_success = TRUE
                  CALL s_artt405_conf_chk(g_detail_d2[li_idx].rtdudocno,"N") RETURNING l_success
                  IF l_success THEN
                     CALL s_transaction_begin()
                     CALL s_artt405_conf_upd(g_detail_d2[li_idx].rtdudocno) RETURNING l_success
                     IF NOT l_success THEN
                        CALL s_transaction_end('N','0')
                     ELSE
                        CALL s_transaction_end('Y','1')
                     END IF
                  END IF
               END FOR
               CALL cl_err_collect_show()
               CALL artp405_b_fill()
               #160225-00040#18 2016/04/13 s983961--add(s)
               LET l_msg = cl_getmsg('std-00012',g_lang)   
               CALL cl_progress_no_window_ing(l_msg)
               #160225-00040#18 2016/04/13 s983961--add(e) 
            END IF
         
         ON ACTION batch_delete
            LET g_action_choice="batch_delete"
            IF cl_auth_chk_act("batch_delete") THEN
               CALL cl_progress_bar_no_window(2)   #160225-00040#18 2016/04/13 s983961--add
               #add-point:ON ACTION del_data
               IF NOT cl_ask_confirm('art-00725') THEN
                  CONTINUE DIALOG
               END IF
               #160225-00040#18 2016/04/13 s983961--add(s)
               LET l_msg = cl_getmsg('ast-00330',g_lang)   
               CALL cl_progress_no_window_ing(l_msg)
               #160225-00040#18 2016/04/13 s983961--add(e) 
               CALL s_transaction_begin()
               LET l_sql = " DELETE FROM rtdq_t ",
                           "  WHERE rtdqent = ",g_enterprise," ",
                           "    AND rtdqacti = 'Y' ",
                           "    AND ",g_wc,
                           "    AND (rtdq033 IS NULL OR rtdq034 IS NULL) "
               PREPARE del_rtdq_pre FROM l_sql
               EXECUTE del_rtdq_pre
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = "del_rtdq"
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  #160225-00040#18 2016/04/13 s983961--add(s)
                  LET l_msg = cl_getmsg('std-00012',g_lang)   
                  CALL cl_progress_no_window_ing(l_msg)
                  #160225-00040#18 2016/04/13 s983961--add(e) 
                  CONTINUE DIALOG
               END IF
               CALL s_transaction_end('Y','0')
               CALL artp405_b_fill()
               #160225-00040#18 2016/04/13 s983961--add(s)
               LET l_msg = cl_getmsg('std-00012',g_lang)   
               CALL cl_progress_no_window_ing(l_msg)
               #160225-00040#18 2016/04/13 s983961--add(e) 
               #END add-point
         
            END IF
         
         ON ACTION excel_example
            LET g_action_choice="excel_example"
            IF cl_auth_chk_act("excel_example") THEN

               #add-point:ON ACTION excel_example
               LET la_param.prog = 'awsp200'
               LET la_param.param[1] = g_prog
               LET la_param.param[2] = "excel_example"
               LET ls_js = util.JSON.stringify( la_param )

               CALL cl_cmdrun_wait(ls_js)
               #END add-point

            END IF
            
         ON ACTION excel_load
            LET g_action_choice="excel_load"
            IF cl_auth_chk_act("excel_load") THEN
               LET l_time = cl_get_current()
               LET g_time = cl_replace_str(l_time,'-','')
               LET g_time = cl_replace_str(g_time,' ','')
               LET g_time = cl_replace_str(g_time,':','')
               #add-point:ON ACTION excel_example
               LET g_etlparam[1].para_id = "g_docno"
               LET g_etlparam[1].type = "string"
               LET g_etlparam[1].value = g_time
               
               LET g_etlparam[2].para_id = "g_date"
               LET g_etlparam[2].type = "date"
               LET g_etlparam[2].value = g_today
               
               LET la_param.prog = 'awsp200'
               LET la_param.param[1] = g_prog
               LET la_param.param[2] = "excel_load"
               LET la_param.param[3] = util.JSON.stringify(g_etlparam)
               LET ls_js = util.JSON.stringify( la_param )

               CALL cl_cmdrun_wait(ls_js)
               #END add-point

            END IF
            UPDATE rtdq_t SET rtdqacti = 'Y',
                                rtdq034 = '',
                                rtdq035 = (SELECT DISTINCT stan001 FROM stan_t,staq_t,stbo_t WHERE stanent = g_enterprise 
                                                AND stanent = staqent AND stan001 = staq001 AND stanent = rtdqent AND staq003 = rtdq003
                                                AND stboent = stanent AND stbo001 = stan001 AND stbo003 = rtdqsite AND stboacti = 'Y'
                                                AND stan005 = rtdq023 AND (stan029 = '2' OR stan029 = '3' OR stan029 = '4') AND ROWNUM = 1)
             WHERE rtdqent = g_enterprise
               AND rtdq032 = g_time
            DISPLAY g_time TO rtdq032
            DISPLAY g_today TO rtdq039
            DISPLAY g_user TO rtdq040
            DISPLAY '' TO rtdq023
            DISPLAY '' TO rtdq004
            LET g_wc1 = " 1=1 "
            LET g_wc3 = " rtdq032 = '",g_time,"' AND rtdq039 = '",g_today,"' AND rtdq040 = '",g_user,"' "
            LET g_wc = g_wc1," AND ",g_wc3
            CALL artp405_b_fill()
            
         ON ACTION ins_T100
            LET g_action_choice="ins_t100"
            IF cl_auth_chk_act("ins_t100") THEN
               LET l_loop = 2
               CALL cl_progress_bar_no_window(l_loop)
               IF g_wc = " 1=1" AND NOT cl_null(g_time) THEN
                  LET g_wc = " rtdq032 = '",g_time,"' "
               END IF
               LET g_wc = g_wc," AND rtdq033 IS NULL "      #20151016 dongsz add
               CALL s_aooi500_sql_where(g_prog,'rtdqsite') RETURNING l_where
               LET g_wc = g_wc," AND ",l_where
               IF NOT artp405_ins_chk() THEN
                  CONTINUE DIALOG
               END IF
               IF NOT artp405_rtdq_chk() THEN
                  CONTINUE DIALOG
               END IF
               IF NOT cl_ask_confirm('abm-00096') THEN
                  CONTINUE DIALOG
               END IF
               CALL s_transaction_begin()
               #20150827--add by dongsz--s
               #更新导入资料
               CALL artp405_upd_rtdq() RETURNING r_success
               IF NOT r_success THEN
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               #20150827--add by dongsz--e
               CALL cl_err_collect_init() 
               LET l_msg = cl_getmsg('art-00751',g_lang)
               CALL cl_progress_no_window_ing(l_msg)
               CALL artp405_ins_artm300() RETURNING r_success
               IF NOT r_success THEN
                  CALL s_transaction_end('N','0')
                  CALL cl_err_collect_show()
                  CONTINUE DIALOG
               END IF
               LET l_msg = cl_getmsg('art-00752',g_lang)
               CALL cl_progress_no_window_ing(l_msg)
               CALL artp405_ins_artt405() RETURNING r_success
               IF NOT r_success THEN
                  CALL s_transaction_end('N','0')
                  CALL cl_err_collect_show()
                  CONTINUE DIALOG
               END IF
               CALL cl_err_collect_show()
               CALL s_transaction_end('Y','0')
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = 'art-00730'
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               CALL artp405_b_fill()
            END IF
            
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               #add-point:ON ACTION modify_detail
               LET g_aw = g_curr_diag.getCurrentItem()
               IF g_aw = "s_detail1" THEN
                  CALL artp405_modify()
               END IF
               #END add-point
               
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
 
{<section id="artp405.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION artp405_query()
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
   CALL artp405_b_fill()
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
 
{<section id="artp405.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION artp405_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_where         STRING
   DEFINE l_ooef019       LIKE ooef_t.ooef019      #20151208 dongsz add
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_wc = g_wc1," AND ",g_wc3
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1 "
   END IF
   CALL s_aooi500_sql_where(g_prog,'rtdqsite') RETURNING l_where
   LET g_wc = g_wc," AND ",l_where
   
   IF cl_null(g_chk) THEN
      LET g_chk = 'Y'
   END IF
   IF g_flag_wc = 'Y' THEN      #点击确定时重新查询
      LET ls_wc = g_wc
      IF g_chk = 'Y' THEN
         LET ls_wc = ls_wc," AND rtdq033 IS NULL "
      END IF
      LET g_wc_o = ls_wc
   ELSE
      LET ls_wc = g_wc_o
   END IF
   LET g_sql = " SELECT rtdqacti,rtdqsite,ooefl003,rtdq001,rtdq003,t1.rtaxl003, ",
               "        rtdq004,rtdq005,rtdq006,rtdq008, ",
               "        rtdq009,rtdq036,rtdq007,rtdq041, ",
               "        rtdq002,t2.rtaxl003,rtdq010,rtdq021,rtdq022, ",
               "        rtdq028,rtdq042,rtdq043,rtdq013, ",
               "        rtdq011,rtdq012,rtdq027,rtdq019, ",
               "        rtdq020,rtdq044,rtdq045,rtdq046, ",
               "        rtdq037,rtdq047,rtdq030,rtdq038, ",
               "        rtdq029,rtdq023,rtdq024,rtdq035, ",
               "        rtdq032,rtdq033,rtdq034,rtdq014, ",
               "        rtdq015,rtdq016,rtdq017,rtdq018, ",
               "        rtdq025,rtdq026,rtdq031 ",
               "   FROM rtdq_t LEFT OUTER JOIN ooefl_t ON ooeflent = rtdqent AND ooefl001 = rtdqsite AND ooefl002 = '",g_dlang,"' ",
               "               LEFT OUTER JOIN rtaxl_t t1 ON t1.rtaxlent = rtdqent AND t1.rtaxl001 = rtdq003 AND t1.rtaxl002 = '",g_dlang,"' ",
               "               LEFT OUTER JOIN rtaxl_t t2 ON t2.rtaxlent = rtdqent AND t2.rtaxl001 = rtdq002 AND t2.rtaxl002 = '",g_dlang,"' ",
               "  WHERE rtdqent = ? ",
               #"    AND rtdq032 = '",g_time,"' ",
               #"    AND (rtdq033 IS NULL OR rtdq034 IS NULL) ",
               "    AND ",ls_wc,
               "  ORDER BY rtdqsite,rtdq003,rtdq004 "
   #end add-point
 
   PREPARE artp405_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR artp405_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   CALL g_detail_d2.clear()
   CALL g_detail_d3.clear()
   CALL g_detail_d4.clear()
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
      g_detail_d[l_ac].sel,g_detail_d[l_ac].rtdqsite,g_detail_d[l_ac].rtdqsite_desc,g_detail_d[l_ac].rtdq001,g_detail_d[l_ac].rtdq003,g_detail_d[l_ac].rtdq003_desc,
      g_detail_d[l_ac].rtdq004,g_detail_d[l_ac].rtdq005,g_detail_d[l_ac].rtdq006,g_detail_d[l_ac].rtdq008,
      g_detail_d[l_ac].rtdq009,g_detail_d[l_ac].rtdq036,g_detail_d[l_ac].rtdq007,g_detail_d[l_ac].rtdq041,
      g_detail_d[l_ac].rtdq002,g_detail_d[l_ac].rtdq002_desc,g_detail_d[l_ac].rtdq010,g_detail_d[l_ac].rtdq021,g_detail_d[l_ac].rtdq022,
      g_detail_d[l_ac].rtdq028,g_detail_d[l_ac].rtdq042,g_detail_d[l_ac].rtdq043,g_detail_d[l_ac].rtdq013,
      g_detail_d[l_ac].rtdq011,g_detail_d[l_ac].rtdq012,g_detail_d[l_ac].rtdq027,g_detail_d[l_ac].rtdq019,
      g_detail_d[l_ac].rtdq020,g_detail_d[l_ac].rtdq044,g_detail_d[l_ac].rtdq045,g_detail_d[l_ac].rtdq046,
      g_detail_d[l_ac].rtdq037,g_detail_d[l_ac].rtdq047,g_detail_d[l_ac].rtdq030,g_detail_d[l_ac].rtdq038,
      g_detail_d[l_ac].rtdq029,g_detail_d[l_ac].rtdq023,g_detail_d[l_ac].rtdq024,g_detail_d[l_ac].rtdq035,
      g_detail_d[l_ac].rtdq032,g_detail_d[l_ac].rtdq033,g_detail_d[l_ac].rtdq034,g_detail_d[l_ac].rtdq014,
      g_detail_d[l_ac].rtdq015,g_detail_d[l_ac].rtdq016,g_detail_d[l_ac].rtdq017,g_detail_d[l_ac].rtdq018,
      g_detail_d[l_ac].rtdq025,g_detail_d[l_ac].rtdq026,g_detail_d[l_ac].rtdq031
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
      #20151208 dongsz add--s
      #税别说明
      SELECT ooef019 INTO l_ooef019 FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_detail_d[l_ac].rtdqsite
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_ooef019
      LET g_ref_fields[2] = g_detail_d[l_ac].rtdq013
      CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail_d[l_ac].rtdq013_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_detail_d[l_ac].rtdq013_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_ooef019
      LET g_ref_fields[2] = g_detail_d[l_ac].rtdq027
      CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail_d[l_ac].rtdq027_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_detail_d[l_ac].rtdq027_desc
      #20151208 dongsz add--e
      #end add-point
      
      CALL artp405_detail_show()      
 
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
   IF l_ac = 1 THEN
      RETURN
   END IF
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE artp405_sel
   
   LET l_ac = 1
   CALL artp405_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="artp405.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION artp405_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   DEFINE l_sql      STRING
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   LET g_detail_idx = l_ac
   CALL g_detail_d2.clear()
   
   LET l_sql = " SELECT 'Y',rtdusite,a.ooefl003,rtdudocdt,rtdudocno, ",
               "        rtdu001,b.pmaal004,rtdu002,rtdu003, ",
               "        rtdu004,rtdu012,rtdu005,c.ooefl003, ",
               "        rtdu007,d.ooefl003,rtdu011,e.ooall004, ",
               "        rtdu009,rtdustus ",
               "   FROM rtdu_t LEFT OUTER JOIN ooefl_t a ON a.ooeflent = rtduent AND a.ooefl001 = rtdusite AND a.ooefl002 = '",g_dlang,"' ",
               "               LEFT OUTER JOIN pmaal_t b ON b.pmaalent = rtduent AND b.pmaal001 = rtdu001 AND b.pmaal002 = '",g_dlang,"' ",
               "               LEFT OUTER JOIN ooefl_t c ON c.ooeflent = rtduent AND c.ooefl001 = rtdu005 AND c.ooefl002 = '",g_dlang,"' ",
               "               LEFT OUTER JOIN ooefl_t d ON d.ooeflent = rtduent AND d.ooefl001 = rtdu007 AND d.ooefl002 = '",g_dlang,"' ",
               "               LEFT OUTER JOIN ooall_t e ON e.ooallent = rtduent AND e.ooall001 = '2' AND e.ooall002 = rtdu011 AND e.ooall003 = '",g_dlang,"' ",
               "  WHERE rtduent = ",g_enterprise," ",
               "    AND rtdudocno IN (SELECT DISTINCT rtdq033 FROM rtdq_t WHERE rtdqent = ",g_enterprise," ",
               #"                         AND rtdqsite = '",g_detail_d[g_detail_idx].rtdqsite,"' ",
               #"                         AND rtdq032 = '",g_detail_d[g_detail_idx].rtdq032,"') ",
               "                         AND ",g_wc_o,") ",
               "  ORDER BY rtdudocdt,rtdudocno "
   PREPARE sel_rtdu_pre FROM l_sql
   DECLARE sel_rtdu_cs  CURSOR FOR sel_rtdu_pre
   LET l_ac = 1
   FOREACH sel_rtdu_cs  INTO g_detail_d2[l_ac].sel1,g_detail_d2[l_ac].rtdusite,g_detail_d2[l_ac].rtdusite_desc,g_detail_d2[l_ac].rtdudocdt,g_detail_d2[l_ac].rtdudocno,
                             g_detail_d2[l_ac].rtdu001,g_detail_d2[l_ac].rtdu001_desc,g_detail_d2[l_ac].rtdu002,g_detail_d2[l_ac].rtdu003,
                             g_detail_d2[l_ac].rtdu004,g_detail_d2[l_ac].rtdu012,g_detail_d2[l_ac].rtdu005,g_detail_d2[l_ac].rtdu005_desc,
                             g_detail_d2[l_ac].rtdu007,g_detail_d2[l_ac].rtdu007_desc,g_detail_d2[l_ac].rtdu011,g_detail_d2[l_ac].rtdu011_desc,
                             g_detail_d2[l_ac].rtdu009,g_detail_d2[l_ac].rtdustus
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
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
   
   CALL g_detail_d2.deleteElement(g_detail_d2.getLength())
   LET l_ac = l_ac - 1
   
   CALL artp405_b_fill2()
   CALL artp405_b_fill3()
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="artp405.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION artp405_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="artp405.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION artp405_filter()
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
   
   CALL artp405_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="artp405.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION artp405_filter_parser(ps_field)
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
 
{<section id="artp405.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION artp405_filter_show(ps_field,ps_object)
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
   LET ls_condition = artp405_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="artp405.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 写入商品主档
# Memo...........:
# Usage..........: CALL artp405_ins_artm300()
# Date & Author..: 20150709 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp405_ins_artm300()
DEFINE l_i         LIKE type_t.num5
#161111-00028#3---modify---begin-----------
#DEFINE l_imaa      RECORD LIKE imaa_t.*
#DEFINE l_imaal     RECORD LIKE imaal_t.*
#DEFINE l_imay      RECORD LIKE imay_t.*
#DEFINE l_imaz      RECORD LIKE imaz_t.*
#DEFINE l_imao      RECORD LIKE imao_t.*
#DEFINE l_prbh      RECORD LIKE prbh_t.*
DEFINE l_imaa RECORD  #料件主檔
       imaaent LIKE imaa_t.imaaent, #企業編號
       imaa001 LIKE imaa_t.imaa001, #料號
       imaa002 LIKE imaa_t.imaa002, #目前版本
       imaa003 LIKE imaa_t.imaa003, #主分群碼
       imaa004 LIKE imaa_t.imaa004, #料件類別
       imaa005 LIKE imaa_t.imaa005, #特徵組別
       imaa006 LIKE imaa_t.imaa006, #基礎單位
       imaa009 LIKE imaa_t.imaa009, #產品分類
       imaa010 LIKE imaa_t.imaa010, #生命週期狀態
       imaa011 LIKE imaa_t.imaa011, #產出類型
       imaa012 LIKE imaa_t.imaa012, #允許副產品
       imaa013 LIKE imaa_t.imaa013, #目錄編號
       imaa014 LIKE imaa_t.imaa014, #產品條碼編號
       imaa016 LIKE imaa_t.imaa016, #毛重
       imaa017 LIKE imaa_t.imaa017, #淨重
       imaa018 LIKE imaa_t.imaa018, #重量單位
       imaa019 LIKE imaa_t.imaa019, #長度
       imaa020 LIKE imaa_t.imaa020, #寬度
       imaa021 LIKE imaa_t.imaa021, #高度
       imaa022 LIKE imaa_t.imaa022, #長度單位
       imaa023 LIKE imaa_t.imaa023, #面積
       imaa024 LIKE imaa_t.imaa024, #面積單位
       imaa025 LIKE imaa_t.imaa025, #體積
       imaa026 LIKE imaa_t.imaa026, #體積單位
       imaa027 LIKE imaa_t.imaa027, #為包裝容器
       imaa028 LIKE imaa_t.imaa028, #容量
       imaa029 LIKE imaa_t.imaa029, #容量單位
       imaa030 LIKE imaa_t.imaa030, #超量容差(%)
       imaa031 LIKE imaa_t.imaa031, #載重量
       imaa032 LIKE imaa_t.imaa032, #載重單位
       imaa033 LIKE imaa_t.imaa033, #超重容差(%)
       imaa034 LIKE imaa_t.imaa034, #料號來源
       imaa035 LIKE imaa_t.imaa035, #來源參考料號
       imaa036 LIKE imaa_t.imaa036, #記錄位置(插件)
       imaa037 LIKE imaa_t.imaa037, #組裝位置須勾稽
       imaa038 LIKE imaa_t.imaa038, #工程料件
       imaa039 LIKE imaa_t.imaa039, #轉正式料號
       imaa040 LIKE imaa_t.imaa040, #轉正式料號時間
       imaa041 LIKE imaa_t.imaa041, #工程圖號
       imaa042 LIKE imaa_t.imaa042, #主要模具編號
       imaa043 LIKE imaa_t.imaa043, #據點研發可調整元件
       imaa044 LIKE imaa_t.imaa044, #AVL控管點
       imaa045 LIKE imaa_t.imaa045, #生產國家地區
       imaa100 LIKE imaa_t.imaa100, #條碼分類
       imaa101 LIKE imaa_t.imaa101, #主供應商
       imaa102 LIKE imaa_t.imaa102, #保質期(月)
       imaa103 LIKE imaa_t.imaa103, #保質期(天)
       imaa104 LIKE imaa_t.imaa104, #庫存單位
       imaa105 LIKE imaa_t.imaa105, #銷售單位
       imaa106 LIKE imaa_t.imaa106, #銷售計價單位
       imaa107 LIKE imaa_t.imaa107, #採購單位
       imaa108 LIKE imaa_t.imaa108, #商品種類
       imaa109 LIKE imaa_t.imaa109, #條碼類型
       imaa110 LIKE imaa_t.imaa110, #季節性商品
       imaa111 LIKE imaa_t.imaa111, #開始日期
       imaa112 LIKE imaa_t.imaa112, #結束日期
       imaa113 LIKE imaa_t.imaa113, #傳秤因子
       imaa114 LIKE imaa_t.imaa114, #計價幣別
       imaa115 LIKE imaa_t.imaa115, #預計進貨價格
       imaa116 LIKE imaa_t.imaa116, #預計銷貨價格
       imaa117 LIKE imaa_t.imaa117, #進銷差率
       imaa118 LIKE imaa_t.imaa118, #試銷期(天)
       imaa119 LIKE imaa_t.imaa119, #試銷金額
       imaa120 LIKE imaa_t.imaa120, #試銷數量
       imaa121 LIKE imaa_t.imaa121, #是否網路經營
       imaa122 LIKE imaa_t.imaa122, #產地分類
       imaa123 LIKE imaa_t.imaa123, #產地說明
       imaa124 LIKE imaa_t.imaa124, #進銷項稅別
       imaa125 LIKE imaa_t.imaa125, #一次性商品
       imaa126 LIKE imaa_t.imaa126, #品牌
       imaa127 LIKE imaa_t.imaa127, #系列
       imaa128 LIKE imaa_t.imaa128, #型別
       imaa129 LIKE imaa_t.imaa129, #功能
       imaa130 LIKE imaa_t.imaa130, #主材
       imaa131 LIKE imaa_t.imaa131, #價格帶
       imaa132 LIKE imaa_t.imaa132, #其他屬性一
       imaa133 LIKE imaa_t.imaa133, #其他屬性二
       imaa134 LIKE imaa_t.imaa134, #其他屬性三
       imaa135 LIKE imaa_t.imaa135, #其他屬性四
       imaa136 LIKE imaa_t.imaa136, #其他屬性五
       imaa137 LIKE imaa_t.imaa137, #其他屬性六
       imaa138 LIKE imaa_t.imaa138, #其他屬性七
       imaa139 LIKE imaa_t.imaa139, #其他屬性八
       imaa140 LIKE imaa_t.imaa140, #其他屬性九
       imaa141 LIKE imaa_t.imaa141, #其他屬性十
       imaa142 LIKE imaa_t.imaa142, #制定組織
       imaa143 LIKE imaa_t.imaa143, #產品組編號
       imaa144 LIKE imaa_t.imaa144, #庫存多單位
       imaa145 LIKE imaa_t.imaa145, #採購計價單位
       imaa146 LIKE imaa_t.imaa146, #成本單位
       imaastus LIKE imaa_t.imaastus, #狀態碼
       imaaownid LIKE imaa_t.imaaownid, #資料所有者
       imaaowndp LIKE imaa_t.imaaowndp, #資料所屬部門
       imaacrtid LIKE imaa_t.imaacrtid, #資料建立者
       imaacrtdp LIKE imaa_t.imaacrtdp, #資料建立部門
       imaacrtdt LIKE imaa_t.imaacrtdt, #資料創建日
       imaamodid LIKE imaa_t.imaamodid, #資料修改者
       imaamoddt LIKE imaa_t.imaamoddt, #最近修改日
       imaacnfid LIKE imaa_t.imaacnfid, #資料確認者
       imaacnfdt LIKE imaa_t.imaacnfdt, #資料確認日
       imaa147 LIKE imaa_t.imaa147, #預設商品臨期比例
       imaa148 LIKE imaa_t.imaa148, #商品臨期天數
       imaa149 LIKE imaa_t.imaa149, #臨期控管方式
       imaa150 LIKE imaa_t.imaa150, #輔材
       imaa151 LIKE imaa_t.imaa151, #等級
       imaa152 LIKE imaa_t.imaa152, #顏色
       imaa153 LIKE imaa_t.imaa153, #型號
       imaa154 LIKE imaa_t.imaa154, #年份
       imaa155 LIKE imaa_t.imaa155, #訂貨季
       imaa156 LIKE imaa_t.imaa156, #性別
       imaa157 LIKE imaa_t.imaa157, #標牌價
       imaa158 LIKE imaa_t.imaa158, #上市日
       imaa159 LIKE imaa_t.imaa159, #每m²克重
       imaa160 LIKE imaa_t.imaa160, #面料幅寬
       imaa161 LIKE imaa_t.imaa161 #觸屏分類編號
       END RECORD
DEFINE l_imaal RECORD  #料件多語言檔
       imaalent LIKE imaal_t.imaalent, #企業編號
       imaal001 LIKE imaal_t.imaal001, #料號
       imaal002 LIKE imaal_t.imaal002, #語系
       imaal003 LIKE imaal_t.imaal003, #品名
       imaal004 LIKE imaal_t.imaal004, #規格
       imaal005 LIKE imaal_t.imaal005 #助記碼
       END RECORD
DEFINE l_imay RECORD  #商品條碼檔
       imayent LIKE imay_t.imayent, #企業編號
       imay001 LIKE imay_t.imay001, #商品編號
       imay002 LIKE imay_t.imay002, #條碼分類
       imay003 LIKE imay_t.imay003, #條碼
       imay004 LIKE imay_t.imay004, #包裝單位
       imay005 LIKE imay_t.imay005, #件裝數
       imay006 LIKE imay_t.imay006, #主條碼否
       imay007 LIKE imay_t.imay007, #陳列規格(深)
       imay008 LIKE imay_t.imay008, #陳列規格(寬)
       imay009 LIKE imay_t.imay009, #陳列規格(高)
       imay010 LIKE imay_t.imay010, #體積
       imay011 LIKE imay_t.imay011, #重量
       imay012 LIKE imay_t.imay012, #計價單位
       imay013 LIKE imay_t.imay013, #計價單位換算率
       imay014 LIKE imay_t.imay014, #庫存單位
       imay015 LIKE imay_t.imay015, #長度單位
       imay016 LIKE imay_t.imay016, #體積單位
       imay017 LIKE imay_t.imay017, #重量單位
       imayownid LIKE imay_t.imayownid, #資料所有者
       imayowndp LIKE imay_t.imayowndp, #資料所屬部門
       imaycrtid LIKE imay_t.imaycrtid, #資料建立者
       imaycrtdp LIKE imay_t.imaycrtdp, #資料建立部門
       imaycrtdt LIKE imay_t.imaycrtdt, #資料創建日
       imaymodid LIKE imay_t.imaymodid, #資料修改者
       imaymoddt LIKE imay_t.imaymoddt, #最近修改日
       imaystus LIKE imay_t.imaystus, #狀態碼
       imay018 LIKE imay_t.imay018, #傳秤因子
       imay019 LIKE imay_t.imay019 #產品特徵
       END RECORD
DEFINE l_imaz RECORD  #商品流通補貨規格檔
       imazent LIKE imaz_t.imazent, #企業編號
       imaz001 LIKE imaz_t.imaz001, #商品編號
       imaz002 LIKE imaz_t.imaz002, #補貨規格
       imaz003 LIKE imaz_t.imaz003, #補貨條碼
       imaz004 LIKE imaz_t.imaz004, #補貨單位
       imaz005 LIKE imaz_t.imaz005, #件裝數
       imaz006 LIKE imaz_t.imaz006  #補貨規格說明
       END RECORD
DEFINE l_imao RECORD  #料件使用單位檔
       imaoent LIKE imao_t.imaoent, #企業編號
       imao001 LIKE imao_t.imao001, #料件編號
       imao002 LIKE imao_t.imao002  #可用交易單位編號
       END RECORD
DEFINE l_prbh RECORD  #PLU碼對照清單表
       prbhent LIKE prbh_t.prbhent, #企業編號
       prbhunit LIKE prbh_t.prbhunit, #應用組織
       prbhsite LIKE prbh_t.prbhsite, #營運據點
       prbh001 LIKE prbh_t.prbh001, #PLU編碼
       prbh002 LIKE prbh_t.prbh002, #PLU說明
       prbh003 LIKE prbh_t.prbh003, #商品編碼
       prbh004 LIKE prbh_t.prbh004, #商品條碼
       prbh005 LIKE prbh_t.prbh005, #商品特征
       prbh006 LIKE prbh_t.prbh006, #包裝單位
       prbh007 LIKE prbh_t.prbh007, #整包件數
       prbh008 LIKE prbh_t.prbh008, #價格因子
       prbh009 LIKE prbh_t.prbh009, #進項稅別
       prbh010 LIKE prbh_t.prbh010, #進價
       prbh011 LIKE prbh_t.prbh011, #銷項稅別
       prbh012 LIKE prbh_t.prbh012, #售價
       prbh013 LIKE prbh_t.prbh013, #會員價1
       prbh014 LIKE prbh_t.prbh014, #會員價2
       prbh015 LIKE prbh_t.prbh015, #會員價3
       prbhstus LIKE prbh_t.prbhstus, #狀態
       prbhownid LIKE prbh_t.prbhownid, #資料所有者
       prbhowndp LIKE prbh_t.prbhowndp, #資料所屬部門
       prbhcrtid LIKE prbh_t.prbhcrtid, #資料建立者
       prbhcrtdp LIKE prbh_t.prbhcrtdp, #資料建立部門
       prbhcrtdt LIKE prbh_t.prbhcrtdt, #資料創建日
       prbhmodid LIKE prbh_t.prbhmodid, #資料修改者
       prbhmoddt LIKE prbh_t.prbhmoddt, #最近修改日
       prbh016 LIKE prbh_t.prbh016, #進價開始日期
       prbh017 LIKE prbh_t.prbh017, #進價結束日期
       prbh018 LIKE prbh_t.prbh018, #售價開始日期
       prbh019 LIKE prbh_t.prbh019  #售價結束日期
       END RECORD
#161111-00028#3---modify---end------------
DEFINE l_ooef016   LIKE ooef_t.ooef016
DEFINE l_n         LIKE type_t.num5
DEFINE l_success   LIKE type_t.num5
DEFINE r_success   LIKE type_t.num5
DEFINE l_ooca001   LIKE ooca_t.ooca001
DEFINE l_rtaj002   LIKE rtaj_t.rtaj002
DEFINE l_rtaj011   LIKE rtaj_t.rtaj011
DEFINE l_rtaj012   LIKE rtaj_t.rtaj012
DEFINE l_imaa108   LIKE imaa_t.imaa108   #20150819--add by dongsz
DEFINE l_str       LIKE type_t.chr5      #20180922--add by dongsz
DEFINE l_cnt       LIKE type_t.num10
#20151208--dongsz add--str
DEFINE l_imay003   STRING
DEFINE l_len       LIKE type_t.num5
DEFINE l_str1      LIKE type_t.chr1
#20151208--dongsz add--end
DEFINE l_exist     LIKE type_t.num10
DEFINE l_oocamoddt DATETIME YEAR TO SECOND

   LET r_success = TRUE
   LET l_cnt = 0
   FOR l_i = 1 TO g_detail_d.getLength()
      DISPLAY 'imaa001:',g_detail_d[l_i].rtdq004
      IF g_detail_d[l_i].sel = "N" THEN
         CONTINUE FOR
      END IF
      
      #20151208--dongsz add--str
      #判断条码只能是纯数字
      LET l_imay003 = g_detail_d[l_i].rtdq005
      LET l_len = l_imay003.getLength()
      FOR l_n=1 TO l_len
         LET l_str1 = l_imay003.subString(l_n,l_n)
         IF l_str1 NOT MATCHES '[0123456789]' THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ""
            LET g_errparam.code   = 'art-00741'
            LET g_errparam.popup  = TRUE
            LET g_errparam.replace[1] = g_detail_d[l_i].rtdq004
            CALL cl_err()
            CALL artp405_ins_tmp(g_detail_d[l_i].rtdqsite,g_detail_d[l_i].rtdq004,g_detail_d[l_i].rtdq032)
            LET r_success = FALSE
            EXIT FOR
         END IF
      END FOR
      IF r_success = FALSE THEN
         EXIT FOR
      END IF
      #判断条码长度只能是8、12、13、18
      IF l_len <> 8 AND l_len <> 12 AND l_len <> 13 AND l_len <> 18 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ""
         LET g_errparam.code   = 'art-00742'
         LET g_errparam.popup  = TRUE
         LET g_errparam.replace[1] = g_detail_d[l_i].rtdq005
         CALL cl_err()
         CALL artp405_ins_tmp(g_detail_d[l_i].rtdqsite,g_detail_d[l_i].rtdq004,g_detail_d[l_i].rtdq032)
         LET r_success = FALSE
         EXIT FOR
      END IF
      #20151208--dongsz add--end
      
      #20151016 dongsz add
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM artp405_tmp
       WHERE tmp_rtdqent = g_enterprise
         AND tmp_rtdqsite = g_detail_d[l_i].rtdqsite
         AND tmp_rtdq004 = g_detail_d[l_i].rtdq004
         AND tmp_rtdq032 = g_detail_d[l_i].rtdq032
      IF l_n > 0 THEN
         CONTINUE FOR
      END IF
      #20151016 dongsz add
      
      #160128-00001#2--dongsz add--str
#      #单位转换
#      SELECT oocal001 INTO l_ooca001
#        FROM oocal_t
#       WHERE oocalent = g_enterprise
#         AND oocal002 = g_dlang
#         AND trim(oocal003) = g_detail_d[l_i].rtdq007
#         AND ROWNUM=1
      #160128-00001#2--dongsz add--end
      
      #【單位不存在時自動新增】打勾，則新增單位資料
      IF g_chk2 = 'Y' THEN
         LET l_exist = 0
         LET l_oocamoddt = cl_get_current()
         SELECT COUNT(*) INTO l_exist FROM ooca_t
          WHERE oocaent = g_enterprise
            AND ooca001 = g_detail_d[l_i].rtdq007
         IF l_exist < 1 THEN
            INSERT INTO ooca_t
                  (oocaent,ooca001,oocastus,ooca002,ooca003,ooca004,ooca005,
                   ooca006,ooca007,oocamodid,oocamoddt,oocaownid,oocaowndp,oocacrtid,oocacrtdp,oocacrtdt)
            VALUES(g_enterprise,g_detail_d[l_i].rtdq007,'Y',0,'1','1','',
                   '','',g_user,l_oocamoddt,g_user,g_dept,g_user,g_dept,l_oocamoddt)
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "ooca_t"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET r_success = FALSE
               EXIT FOR
            END IF
                   
            INSERT INTO oocal_t
                           (oocalent,oocal001,oocal002,oocal003,oocal004)
                     VALUES(g_enterprise,g_detail_d[l_i].rtdq007,g_dlang,g_detail_d[l_i].rtdq041,'')
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "oocal_t"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET r_success = FALSE
               EXIT FOR
            END IF
         END IF
      END IF
      
      LET l_ooca001 = g_detail_d[l_i].rtdq007    #160128-00001#2--dongsz add
      
      INITIALIZE l_imaa.* TO NULL
      LET l_imaa.imaaent = g_enterprise
      LET l_imaa.imaa001 = g_detail_d[l_i].rtdq004
      LET l_imaa.imaa002 = 0
      LET l_imaa.imaa004 = 'M'
      LET l_imaa.imaa006 = l_ooca001
      LET l_imaa.imaa009 = g_detail_d[l_i].rtdq002
      #LET l_imaa.imaa010 = '0'                     #生命周期状态
      LET l_imaa.imaa010 = g_detail_d[l_i].rtdq047        #生命周期状态
      LET l_imaa.imaa014 = g_detail_d[l_i].rtdq005
      #LET l_imaa.imaa100 = '1'
      LET l_imaa.imaa100 = g_detail_d[l_i].rtdq042
      LET l_imaa.imaa101 = g_detail_d[l_i].rtdq023
      LET l_imaa.imaa102 = 0
      #LET l_imaa.imaa103 = 0
      IF cl_null(g_detail_d[l_i].rtdq038) THEN
         LET g_detail_d[l_i].rtdq038 = 0
      END IF
      LET l_imaa.imaa103 = g_detail_d[l_i].rtdq038   #20151031 dongsz add
      LET l_imaa.imaa104 = l_ooca001
      LET l_imaa.imaa105 = l_ooca001
      LET l_imaa.imaa106 = l_ooca001
      LET l_imaa.imaa107 = l_ooca001
      #LET l_imaa.imaa108 = '1'         #20150922 dongsz mark
      #LET l_imaa.imaa109 = '1'         #20150922 dongsz mark
      #20150922--add by dongsz--s
      #LET l_str = g_detail_d[l_i].rtdq005[1,2]
      #IF l_str = '28' THEN
      #   LET l_imaa.imaa108 = '3' 
      #   LET l_imaa.imaa109 = '5'
      #ELSE
      #   LET l_imaa.imaa108 = '1' 
      #   LET l_imaa.imaa109 = '1'
      #END IF
      LET l_imaa.imaa108 = g_detail_d[l_i].rtdq028
      LET l_imaa.imaa109 = g_detail_d[l_i].rtdq043
      #20150922--add by dongsz--e
      LET l_imaa.imaa110 = 'N'     #20160411 dongsz add
      LET l_imaa.imaa113 = g_detail_d[l_i].rtdq030
      #计价币别
      SELECT ooef016 INTO l_ooef016
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_detail_d[l_i].rtdqsite
      LET l_imaa.imaa114 = l_ooef016
      LET l_imaa.imaa115 = g_detail_d[l_i].rtdq011
      LET l_imaa.imaa116 = g_detail_d[l_i].rtdq019
      LET l_imaa.imaa118 = 0
      LET l_imaa.imaa119 = 0
      LET l_imaa.imaa120 = 0
      LET l_imaa.imaa121 = 'N'
      LET l_imaa.imaa123 = g_detail_d[l_i].rtdq010
      LET l_imaa.imaa125 = 'N'
      LET l_imaa.imaa126 = g_detail_d[l_i].rtdq021
      LET l_imaa.imaa142 = g_detail_d[l_i].rtdqsite
      LET l_imaa.imaa144 = 'N'
      LET l_imaa.imaa145 = l_ooca001
      LET l_imaa.imaa146 = l_ooca001        #20150813--add by dongsz
      LET l_imaa.imaa147 = 0
      LET l_imaa.imaa148 = 0
      LET l_imaa.imaa149 = '1'
      LET l_imaa.imaastus = 'Y'
      LET l_imaa.imaaownid = g_user
      LET l_imaa.imaaowndp = g_dept
      LET l_imaa.imaacrtid = g_user
      LET l_imaa.imaacrtdp = g_dept
      LET l_imaa.imaacrtdt = cl_get_current()
      LET l_imaa.imaamodid = g_user
      LET l_imaa.imaamoddt = cl_get_current()
      LET l_imaa.imaacnfid = ''
      LET l_imaa.imaacnfdt = ''
      
      #商品多语言档
      INITIALIZE l_imaal.* TO NULL
      LET l_imaal.imaalent = g_enterprise
      LET l_imaal.imaal001 = g_detail_d[l_i].rtdq004
      LET l_imaal.imaal002 = g_dlang
      LET l_imaal.imaal003 = g_detail_d[l_i].rtdq006
      LET l_imaal.imaal004 = g_detail_d[l_i].rtdq009
      
      #商品条码资料
      INITIALIZE l_imay.* TO NULL
      LET l_imay.imayent = g_enterprise
      LET l_imay.imay001 = g_detail_d[l_i].rtdq004
      LET l_imay.imay002 = '1'
      LET l_imay.imay003 = g_detail_d[l_i].rtdq005
      LET l_imay.imay004 = l_ooca001
      LET l_imay.imay005 = 1
      LET l_imay.imay006 = 'Y'
      LET l_imay.imay012 = l_ooca001
      LET l_imay.imay013 = 100
      LET l_imay.imay014 = l_ooca001
      LET l_imay.imay015 = l_ooca001
      LET l_imay.imay016 = l_ooca001
      LET l_imay.imay017 = l_ooca001
      LET l_imay.imay018 = g_detail_d[l_i].rtdq030
      LET l_imay.imayownid = g_user
      LET l_imay.imayowndp = g_dept
      LET l_imay.imaycrtid = g_user
      LET l_imay.imaycrtdp = g_dept
      LET l_imay.imaycrtdt = cl_get_current()
      LET l_imay.imaymodid = g_user
      LET l_imay.imaymoddt = cl_get_current()
      LET l_imay.imaystus = 'Y'
      
      #商品使用单位资料
      INITIALIZE l_imao.* TO NULL
      LET l_imao.imaoent = g_enterprise
      LET l_imao.imao001 = g_detail_d[l_i].rtdq004
      LET l_imao.imao002 = l_ooca001

      #写入商品档
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM imaa_t
       WHERE imaaent = g_enterprise
         AND imaa001 = l_imaa.imaa001
      IF l_n < 1 THEN
         DISPLAY 'ins_imaa:str',TIME
       # INSERT INTO imaa_t VALUES (l_imaa.*) #161111-00028#3--MARK
       #161111-00028#3---ADD----BEGIN---------
         INSERT INTO imaa_t (imaaent,imaa001,imaa002,imaa003,imaa004,imaa005,imaa006,imaa009,imaa010,imaa011,imaa012,imaa013,
                             imaa014,imaa016,imaa017,imaa018,imaa019,imaa020,imaa021,imaa022,imaa023,imaa024,imaa025,imaa026,
                             imaa027,imaa028,imaa029,imaa030,imaa031,imaa032,imaa033,imaa034,imaa035,imaa036,imaa037,imaa038,
                             imaa039,imaa040,imaa041,imaa042,imaa043,imaa044,imaa045,imaa100,imaa101,imaa102,imaa103,imaa104,
                             imaa105,imaa106,imaa107,imaa108,imaa109,imaa110,imaa111,imaa112,imaa113,imaa114,imaa115,imaa116,
                             imaa117,imaa118,imaa119,imaa120,imaa121,imaa122,imaa123,imaa124,imaa125,imaa126,imaa127,imaa128,
                             imaa129,imaa130,imaa131,imaa132,imaa133,imaa134,imaa135,imaa136,imaa137,imaa138,imaa139,imaa140,
                             imaa141,imaa142,imaa143,imaa144,imaa145,imaa146,imaastus,imaaownid,imaaowndp,imaacrtid,imaacrtdp,
                             imaacrtdt,imaamodid,imaamoddt,imaacnfid,imaacnfdt,
                             imaa147,imaa148,imaa149,imaa150,imaa151,imaa152,imaa153,imaa154,imaa155,imaa156,imaa157,
                             imaa158,imaa159,imaa160,imaa161)
          VALUES (l_imaa.imaaent,l_imaa.imaa001,l_imaa.imaa002,l_imaa.imaa003,l_imaa.imaa004,l_imaa.imaa005,l_imaa.imaa006,l_imaa.imaa009,l_imaa.imaa010,l_imaa.imaa011,l_imaa.imaa012,l_imaa.imaa013,
                             l_imaa.imaa014,l_imaa.imaa016,l_imaa.imaa017,l_imaa.imaa018,l_imaa.imaa019,l_imaa.imaa020,l_imaa.imaa021,l_imaa.imaa022,l_imaa.imaa023,l_imaa.imaa024,l_imaa.imaa025,l_imaa.imaa026,
                             l_imaa.imaa027,l_imaa.imaa028,l_imaa.imaa029,l_imaa.imaa030,l_imaa.imaa031,l_imaa.imaa032,l_imaa.imaa033,l_imaa.imaa034,l_imaa.imaa035,l_imaa.imaa036,l_imaa.imaa037,l_imaa.imaa038,
                             l_imaa.imaa039,l_imaa.imaa040,l_imaa.imaa041,l_imaa.imaa042,l_imaa.imaa043,l_imaa.imaa044,l_imaa.imaa045,l_imaa.imaa100,l_imaa.imaa101,l_imaa.imaa102,l_imaa.imaa103,l_imaa.imaa104,
                             l_imaa.imaa105,l_imaa.imaa106,l_imaa.imaa107,l_imaa.imaa108,l_imaa.imaa109,l_imaa.imaa110,l_imaa.imaa111,l_imaa.imaa112,l_imaa.imaa113,l_imaa.imaa114,l_imaa.imaa115,l_imaa.imaa116,
                             l_imaa.imaa117,l_imaa.imaa118,l_imaa.imaa119,l_imaa.imaa120,l_imaa.imaa121,l_imaa.imaa122,l_imaa.imaa123,l_imaa.imaa124,l_imaa.imaa125,l_imaa.imaa126,l_imaa.imaa127,l_imaa.imaa128,
                             l_imaa.imaa129,l_imaa.imaa130,l_imaa.imaa131,l_imaa.imaa132,l_imaa.imaa133,l_imaa.imaa134,l_imaa.imaa135,l_imaa.imaa136,l_imaa.imaa137,l_imaa.imaa138,l_imaa.imaa139,l_imaa.imaa140,
                             l_imaa.imaa141,l_imaa.imaa142,l_imaa.imaa143,l_imaa.imaa144,l_imaa.imaa145,l_imaa.imaa146,l_imaa.imaastus,l_imaa.imaaownid,l_imaa.imaaowndp,l_imaa.imaacrtid,l_imaa.imaacrtdp,
                             l_imaa.imaacrtdt,l_imaa.imaamodid,l_imaa.imaamoddt,l_imaa.imaacnfid,l_imaa.imaacnfdt,
                             l_imaa.imaa147,l_imaa.imaa148,l_imaa.imaa149,l_imaa.imaa150,l_imaa.imaa151,l_imaa.imaa152,l_imaa.imaa153,l_imaa.imaa154,l_imaa.imaa155,l_imaa.imaa156,l_imaa.imaa157,
                             l_imaa.imaa158,l_imaa.imaa159,l_imaa.imaa160,l_imaa.imaa161)
       #161111-00028#3---ADD----END-----------
         DISPLAY 'ins_imaa:end',TIME
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "ins_imaa"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET r_success = FALSE
            CONTINUE FOR
         END IF
         
         #写入商品据点进销存档
         INSERT INTO imaf_t(imafent,   imafsite,  imaf001,
                            imaf012,   imaf013,   imaf014,   imaf015,
                            imaf016,   imaf017,   imaf018,   imaf021,
                            imaf022,   imaf023,   imaf024,   imaf025,
                            imaf026,   imaf027,   imaf031,   imaf032,
                            imaf033,   imaf034,   imaf035,   imaf051,
                            imaf052,   imaf053,   imaf054,   imaf055,
                            imaf056,   imaf057,   imaf058,   imaf059,
                            imaf061,   imaf062,   imaf063,   imaf064,
                            imaf071,   imaf072,   imaf073,   imaf074,
                            imaf081,   imaf082,   imaf083,   imaf084,
                            imaf091,   imaf092,   imaf093,   imaf094,
                            imaf095,   imaf096,   imaf097,   imaf101,
                            imaf102,   imaf111,   imaf112,   imaf113,
                            imaf114,   imaf115,   imaf116,   imaf117,
                            imaf118,   imaf121,   imaf122,   imaf123,
                            imaf124,   imaf125,   imaf126,   imaf127,
                            imaf128,   imaf141,   imaf142,   imaf143,
                            imaf144,   imaf145,   imaf146,   imaf147,
                            imaf148,   imaf149,   imaf151,   imaf152,
                            imaf153,   imaf154,   imaf155,   imaf156,
                            imaf157,   imaf158,   imaf161,   imaf162,
                            imaf163,   imaf164,   imaf165,   imaf166,
                            imaf171,   imaf172,   imaf173,   imaf174,
                            imaf175,   imaf176,
                            imafownid, imafowndp, imafcrtid, imafcrtdp,
                            imafcrtdt, imafmodid, imafmoddt, imafcnfid,
                            imafcnfdt, imafstus)
         VALUES(g_enterprise,      'ALL',             l_imaa.imaa001,
                '1',               '1',              '1',              '',
                '',                '',               'N',              0,
                0,                 0,                0,                0,
                0,                 0,                l_imaa.imaa102, l_imaa.imaa103,
                '',                'N',              '',               '',
                '',                l_imaa.imaa104, l_imaa.imaa144, '0',
                'N',               'A',              '0',              '1',
                # '1','Y','100','1',
                g_imaf061,g_imaf062,g_imaf063,g_imaf064,
                '2',               'N',              '',               '2',
                '2',               'N',              '',               '2',
                '',                '',               'N',              '',
                '',                '',               '',               0,
                0,                 '',               l_imaa.imaa105, l_imaa.imaa106,
                1,  1, '3', 0,
                0,                 '0',              '0', '',
                0,                 '',               'N',              'N',
                '0',               '',               '',               l_imaa.imaa107,
                l_imaa.imaa145,  '0',              0,                '1',
                0,                  0,               '0',              '0',
                '',                 0,               0,                '0',
                '',                '0',              'N',             'N',
                'N',                0,               0,                0,
                0,                  0,               0,                0,
                0,                 '',
                l_imaa.imaaownid,l_imaa.imaaowndp,l_imaa.imaacrtid,l_imaa.imaacrtdp,
                l_imaa.imaacrtdt,l_imaa.imaamodid,l_imaa.imaamoddt,l_imaa.imaacnfid,
                l_imaa.imaacnfdt,l_imaa.imaastus)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "ins_imaf"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET r_success = FALSE
            CONTINUE FOR
         END IF
         
         DISPLAY 'ins_imaal:str',TIME
      #  INSERT INTO imaal_t VALUES (l_imaal.*)  #161111-00028#3--mark
         #161111-00028#3---add---begin-----------
         INSERT INTO imaal_t (imaalent,imaal001,imaal002,imaal003,imaal004,imaal005)
          VALUES (l_imaal.imaalent,l_imaal.imaal001,l_imaal.imaal002,l_imaal.imaal003,l_imaal.imaal004,l_imaal.imaal005)
         #161111-00028#3---add---end-------------
         DISPLAY 'ins_imaal:end',TIME
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "ins_imaal"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET r_success = FALSE
            CONTINUE FOR
         END IF
         
         #商品流通补货规格资料
         INITIALIZE l_imaz.* TO NULL
         LET l_imaz.imazent = g_enterprise
         LET l_imaz.imaz001 = g_detail_d[l_i].rtdq004
         LET l_imaz.imaz003 = g_detail_d[l_i].rtdq005
         LET l_imaz.imaz004 = l_ooca001
         LET l_imaz.imaz005 = g_detail_d[l_i].rtdq036
         LET l_imaz.imaz006 = g_detail_d[l_i].rtdq009
         #(大)
         LET l_imaz.imaz002 = '1'
        #INSERT INTO imaz_t VALUES (l_imaz.*) #161111-00028#3--mark
        #161111-00028#3--add----begin-------------
         INSERT INTO imaz_t (imazent,imaz001,imaz002,imaz003,imaz004,imaz005,imaz006)
          VALUES (l_imaz.imazent,l_imaz.imaz001,l_imaz.imaz002,l_imaz.imaz003,l_imaz.imaz004,l_imaz.imaz005,l_imaz.imaz006)
        #161111-00028#3--add----end---------------
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "ins_imaz"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET r_success = FALSE
            CONTINUE FOR
         END IF
         #(中)
         LET l_imaz.imaz002 = '2'
        #INSERT INTO imaz_t VALUES (l_imaz.*) #161111-00028#3--mark
        #161111-00028#3--add----begin-------------
         INSERT INTO imaz_t (imazent,imaz001,imaz002,imaz003,imaz004,imaz005,imaz006)
          VALUES (l_imaz.imazent,l_imaz.imaz001,l_imaz.imaz002,l_imaz.imaz003,l_imaz.imaz004,l_imaz.imaz005,l_imaz.imaz006)
        #161111-00028#3--add----end---------------
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "ins_imaz"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET r_success = FALSE
            CONTINUE FOR
         END IF
         #(小)
         LET l_imaz.imaz002 = '3'
        #INSERT INTO imaz_t VALUES (l_imaz.*) #161111-00028#3--mark
        #161111-00028#3--add----begin-------------
         INSERT INTO imaz_t (imazent,imaz001,imaz002,imaz003,imaz004,imaz005,imaz006)
          VALUES (l_imaz.imazent,l_imaz.imaz001,l_imaz.imaz002,l_imaz.imaz003,l_imaz.imaz004,l_imaz.imaz005,l_imaz.imaz006)
        #161111-00028#3--add----end---------------
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "ins_imaz"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET r_success = FALSE
            CONTINUE FOR
         END IF
         #写入商品条码档
         LET l_n = 0
         SELECT COUNT(*) INTO l_n FROM imay_t
          WHERE imayent = g_enterprise
            AND imay003 = l_imay.imay003
         IF l_n < 1 THEN
            #INSERT INTO imay_t VALUES (l_imay.*)
            DISPLAY 'ins_imay:str',TIME
            INSERT INTO imay_t (imayent,imay001,imay002,imay003,imay004,imay005,
                                imay006,imay012,imay013,imay014,imay015,imay016,
                                imay017,imay018,imayownid,imayowndp,imaycrtid,
                                imaycrtdp,imaycrtdt,imaymodid,imaymoddt,imaystus)
            VALUES (l_imay.imayent,l_imay.imay001,l_imay.imay002,l_imay.imay003,l_imay.imay004,l_imay.imay005,
                    l_imay.imay006,l_imay.imay012,l_imay.imay013,l_imay.imay014,l_imay.imay015,l_imay.imay016,
                    l_imay.imay017,l_imay.imay018,l_imay.imayownid,l_imay.imayowndp,l_imay.imaycrtid,
                    l_imay.imaycrtdp,l_imay.imaycrtdt,l_imay.imaymodid,l_imay.imaymoddt,l_imay.imaystus)
            DISPLAY 'ins_imay:end',TIME
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "ins_imay"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET r_success = FALSE
               CONTINUE FOR
            END IF
         END IF
         #写入商品使用单位档
         LET l_n = 0
         SELECT COUNT(*) INTO l_n FROM imao_t
          WHERE imaoent = g_enterprise
            AND imao001 = l_imao.imao001
            AND imao002 = l_imao.imao002
         IF l_n < 1 THEN
           #INSERT INTO imao_t VALUES (l_imao.*) #161111-00028#3--mark
            #161111-00028#3--add----begin-------------
            INSERT INTO imao_t (imaoent,imao001,imao002)
             VALUES (l_imao.imaoent,l_imao.imao001,l_imao.imao002)
           #161111-00028#3--add----end---------------
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "ins_imao"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET r_success = FALSE
               CONTINUE FOR
            END IF
         END IF
      END IF
      #20150806--add by dongsz--s
      #商品主档审核
      DISPLAY 'conf_imaa:str',TIME
      CALL s_artm300_carry_upd(l_imaa.imaa001) RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         CONTINUE FOR
      END IF
      CALL s_artm300_conf_upd('1',l_imaa.imaa001) RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         CONTINUE FOR
      END IF
      DISPLAY 'conf_imaa:end',TIME
      #20150806--add by dongsz--e
      #判断如果是生鲜商品，则写入plu表
      #20150819--mark by dongsz--s
#      LET l_n = 0
#      SELECT COUNT(*) INTO l_n
#        FROM prbs_t
#       WHERE prbsent = g_enterprise
#         AND prbs001 = g_detail_d[l_i].rtdq003
#         AND prbsstus = 'Y'
#      IF l_n > 0 THEN
      #20150819--mark by dongsz--e
      #20150819--add by dongsz--s
      #SELECT imaa108 INTO l_imaa108
      #  FROM imaa_t
      # WHERE imaaent = g_enterprise
      #   AND imaa001 = g_detail_d[l_i].rtdq004
      #IF l_imaa108 = '3' THEN
      ##20150819--add by dongsz--e
      #   INITIALIZE l_prbh.* TO NULL
      #   LET l_prbh.prbhent = g_enterprise
      #   LET l_prbh.prbhunit = g_detail_d[l_i].rtdqsite
      #   LET l_prbh.prbhsite = g_detail_d[l_i].rtdqsite
      #   #取条码的流水号作为plu编码
      #   LET l_rtaj002 = g_detail_d[l_i].rtdq005[2,2]
      #   SELECT rtaj011,rtaj012 INTO l_rtaj011,l_rtaj012
      #     FROM rtaj_t
      #    WHERE rtajent = g_enterprise
      #      AND rtaj002 = l_rtaj002
      #   IF cl_null(l_rtaj011) OR cl_null(l_rtaj012) OR l_rtaj011 = 0 OR l_rtaj012 = 0 THEN
      #      INITIALIZE g_errparam TO NULL
      #      LET g_errparam.extend = ""
      #      LET g_errparam.code   = 'cpr-00392'
      #      LET g_errparam.replace[1] = g_detail_d[l_i].rtdq005
      #      LET g_errparam.popup  = TRUE
      #      CALL cl_err()
      #      LET r_success = FALSE
      #      CONTINUE FOR
      #   END IF
      #   LET l_prbh.prbh001 = g_detail_d[l_i].rtdq005[l_rtaj011,l_rtaj012]
      #   LET l_prbh.prbh002 = g_detail_d[l_i].rtdq005[l_rtaj011,l_rtaj012]
      #   LET l_prbh.prbh003 = g_detail_d[l_i].rtdq004
      #   LET l_prbh.prbh004 = g_detail_d[l_i].rtdq005
      #   LET l_prbh.prbh005 = ' '
      #   LET l_prbh.prbh006 = l_ooca001
      #   LET l_prbh.prbh007 = 1
      #   LET l_prbh.prbh008 = g_detail_d[l_i].rtdq030
      #   LET l_prbh.prbh009 = ''
      #   LET l_prbh.prbh010 = g_detail_d[l_i].rtdq011
      #   LET l_prbh.prbh011 = ''
      #   LET l_prbh.prbh012 = g_detail_d[l_i].rtdq020
      #   LET l_prbh.prbh013 = g_detail_d[l_i].rtdq020
      #   LET l_prbh.prbh014 = g_detail_d[l_i].rtdq020
      #   LET l_prbh.prbh015 = g_detail_d[l_i].rtdq020
      #   LET l_prbh.prbh016 = g_detail_d[l_i].rtdq017
      #   LET l_prbh.prbh017 = '2099/12/31'
      #   LET l_prbh.prbh018 = g_detail_d[l_i].rtdq016
      #   LET l_prbh.prbh019 = '2099/12/31'
      #   LET l_prbh.prbhstus = 'Y'
      #   LET l_prbh.prbhownid = g_user
      #   LET l_prbh.prbhowndp = g_dept
      #   LET l_prbh.prbhcrtid = g_user
      #   LET l_prbh.prbhcrtdp = g_dept
      #   LET l_prbh.prbhcrtdt = cl_get_current()
      #   LET l_prbh.prbhmodid = g_user
      #   LET l_prbh.prbhmoddt = cl_get_current()
      #   
      #   LET l_n = 0
      #   SELECT COUNT(*) INTO l_n FROM prbh_t
      #    WHERE prbhent = g_enterprise
      #      AND prbhsite = l_prbh.prbhsite
      #      AND prbh001 = l_prbh.prbh001
      #   IF l_n < 1 THEN
      #      INSERT INTO prbh_t VALUES (l_prbh.*)
      #      IF SQLCA.sqlcode THEN
      #         INITIALIZE g_errparam TO NULL
      #         LET g_errparam.extend = "ins_prbh"
      #         LET g_errparam.code   = SQLCA.sqlcode
      #         LET g_errparam.popup  = TRUE
      #         CALL cl_err()
      #         LET r_success = FALSE
      #         CONTINUE FOR
      #      END IF
      #   END IF
      #END IF
      LET l_cnt = l_cnt + 1
      DISPLAY 'l_cnt:',l_cnt
   END FOR

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 产生商品引进资料
# Memo...........:
# Usage..........: CALL artp405_ins_artt405()
# Date & Author..: 20150710 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp405_ins_artt405()
DEFINE l_rtdqsite     LIKE rtdq_t.rtdqsite
DEFINE l_rtdq023      LIKE rtdq_t.rtdq023
DEFINE l_stan001        LIKE stan_t.stan001
DEFINE l_rtdudocno      LIKE rtdu_t.rtdudocno
DEFINE l_sql            STRING
DEFINE l_sql1           STRING
DEFINE l_sql2           STRING
DEFINE l_sql3           STRING
DEFINE l_sql4           STRING
DEFINE l_n              LIKE type_t.num5
#DEFINE l_rtdu           RECORD LIKE rtdu_t.*  #161111-00028#3--mark
#161111-00028#3---add----begin-------------
DEFINE l_rtdu RECORD  #自營新商品引進單頭檔
       rtduent LIKE rtdu_t.rtduent, #企業編號
       rtdudocno LIKE rtdu_t.rtdudocno, #單據編號
       rtdudocdt LIKE rtdu_t.rtdudocdt, #單據日期
       rtdu001 LIKE rtdu_t.rtdu001, #供應商
       rtdu002 LIKE rtdu_t.rtdu002, #合約編號
       rtdu003 LIKE rtdu_t.rtdu003, #經營方式
       rtdu004 LIKE rtdu_t.rtdu004, #結算方式
       rtdu005 LIKE rtdu_t.rtdu005, #採購中心
       rtdu006 LIKE rtdu_t.rtdu006, #採購員
       rtdu007 LIKE rtdu_t.rtdu007, #配送中心
       rtdu008 LIKE rtdu_t.rtdu008, #店群
       rtdu009 LIKE rtdu_t.rtdu009, #生命週期
       rtdu010 LIKE rtdu_t.rtdu010, #備註
       rtdustus LIKE rtdu_t.rtdustus, #狀態碼
       rtduownid LIKE rtdu_t.rtduownid, #資料所有者
       rtduowndp LIKE rtdu_t.rtduowndp, #資料所有部門
       rtducrtid LIKE rtdu_t.rtducrtid, #資料建立者
       rtducrtdp LIKE rtdu_t.rtducrtdp, #資料建立部門
       rtducrtdt LIKE rtdu_t.rtducrtdt, #資料創建日
       rtdumodid LIKE rtdu_t.rtdumodid, #資料修改者
       rtdumoddt LIKE rtdu_t.rtdumoddt, #最近修改日
       rtducnfid LIKE rtdu_t.rtducnfid, #資料確認者
       rtducnfdt LIKE rtdu_t.rtducnfdt, #資料確認日
       rtduunit LIKE rtdu_t.rtduunit, #應用組織
       rtdusite LIKE rtdu_t.rtdusite, #營運據點
       rtdu011 LIKE rtdu_t.rtdu011, #稅區別
       rtdu000 LIKE rtdu_t.rtdu000, #作業方式
       rtdu012 LIKE rtdu_t.rtdu012 #採購方式
       END RECORD
#161111-00028#3---add----end---------------
DEFINE l_success        LIKE type_t.num5
DEFINE l_stan007        LIKE stan_t.stan007
DEFINE l_stan017        LIKE stan_t.stan017
DEFINE l_stan018        LIKE stan_t.stan018
DEFINE l_stan031        LIKE stan_t.stan031
DEFINE l_ooef016        LIKE ooef_t.ooef016
DEFINE l_rtdq029      LIKE rtdq_t.rtdq029
DEFINE r_success        LIKE type_t.num5
DEFINE l_stao012        LIKE stao_t.stao012    #20150805--add by dongsz
DEFINE l_ooef019        LIKE ooef_t.ooef019    #20150828 add by dongsz
DEFINE l_rtdvseq        LIKE rtdv_t.rtdvseq
DEFINE l_rtdv001        LIKE rtdv_t.rtdv001
DEFINE l_rtdv039        LIKE rtdv_t.rtdv039 
DEFINE l_rtdw002        LIKE rtdw_t.rtdw002    #20151126 dongsz add

   LET r_success = TRUE
   LET l_sql = " SELECT DISTINCT rtdqsite FROM rtdq_t ",
               "  WHERE rtdqent = ",g_enterprise," ",
               "    AND rtdqacti = 'Y' ",
               "    AND ",g_wc,
               "    AND (rtdq033 IS NULL OR rtdq034 IS NULL) ",
               "    AND NOT EXISTS (SELECT 1 FROM artp405_tmp WHERE tmp_rtdqent = rtdqent AND tmp_rtdqsite = rtdqsite ",
               "                       AND tmp_rtdq004 = rtdq004 AND tmp_rtdq032 = rtdq032) "
   PREPARE sel_rtdq_pre1 FROM l_sql
   DECLARE sel_rtdq_cs1  CURSOR FOR sel_rtdq_pre1
   FOREACH sel_rtdq_cs1  INTO l_rtdqsite
      LET l_sql1 = " SELECT DISTINCT rtdq023 FROM rtdq_t ",
                   "  WHERE rtdqent = ",g_enterprise," ",
                   "    AND rtdqsite = '",l_rtdqsite,"' ",
                   "    AND rtdqacti = 'Y' ",
                   "    AND ",g_wc,
                   "    AND (rtdq033 IS NULL OR rtdq034 IS NULL) ",
                   "    AND NOT EXISTS (SELECT 1 FROM artp405_tmp WHERE tmp_rtdqent = rtdqent AND tmp_rtdqsite = rtdqsite ",
               "                       AND tmp_rtdq004 = rtdq004 AND tmp_rtdq032 = rtdq032) "
      PREPARE sel_rtdq_pre2 FROM l_sql1
      DECLARE sel_rtdq_cs2  CURSOR FOR sel_rtdq_pre2
      FOREACH sel_rtdq_cs2  INTO l_rtdq023
         DISPLAY 'rtdq023:',l_rtdq023
         #LET l_sql2 = " SELECT DISTINCT stan001 FROM stan_t,staq_t,rtdq_t ",
         #             "  WHERE stanent = ",g_enterprise," ",
         #             "    AND stanent = staqent AND stanent = rtdqent ",
         #             "    AND stan001 = staq001 AND staq003 = rtdq003 ",
         #             "    AND rtdqsite = '",l_rtdqsite,"' ",
         #             "    AND rtdqacti = 'Y' ",
         #             "    AND ",g_wc,
         #             "    AND (rtdq033 IS NULL OR rtdq034 IS NULL) ",
         #             "    AND stan005 = rtdq023 ",
         #             "    AND stan005 = '",l_rtdq023,"' ",
         #             "    AND (stan029 = '3' OR stan029 = '4') ",
         #             "    AND ROWNUM = 1 "
         #PREPARE sel_stan_pre FROM l_sql2
         #DECLARE sel_stan_cs  CURSOR FOR sel_stan_pre
         #FOREACH sel_stan_cs  INTO l_stan001
         LET l_sql2 = " SELECT DISTINCT rtdq035,rtdq029 FROM rtdq_t ",
                      "  WHERE rtdqent = ",g_enterprise," ",
                      "    AND rtdqsite = '",l_rtdqsite,"' ",
                      "    AND rtdq023 = '",l_rtdq023,"' ",
                      "    AND rtdqacti = 'Y' ",
                      "    AND ",g_wc,
                      "    AND (rtdq033 IS NULL OR rtdq034 IS NULL) ",
                      "    AND NOT EXISTS (SELECT 1 FROM artp405_tmp WHERE tmp_rtdqent = rtdqent AND tmp_rtdqsite = rtdqsite ",
               "                       AND tmp_rtdq004 = rtdq004 AND tmp_rtdq032 = rtdq032) "
         PREPARE sel_stan_pre FROM l_sql2
         DECLARE sel_stan_cs  CURSOR FOR sel_stan_pre
         FOREACH sel_stan_cs  INTO l_stan001,l_rtdq029
            ##判断门店是否签约
            #LET l_n = 0
            #SELECT COUNT(*) INTO l_n
            #  FROM stbo_t
            # WHERE stboent = g_enterprise
            #   AND stbo001 = l_stan001
            #   AND stbo003 = l_rtdqsite
            #IF l_n < 1 THEN
            #   INITIALIZE g_errparam TO NULL
            #   LET g_errparam.extend = ""
            #   LET g_errparam.code   = 'cpr-00385'
            #   LET g_errparam.replace[1] = l_rtdqsite
            #   LET g_errparam.replace[2] = l_stan001
            #   LET g_errparam.popup  = TRUE
            #   CALL cl_err()
            #   LET r_success = FALSE
            #   CONTINUE FOREACH
            #END IF
            #产生商品引进单单头
            INITIALIZE l_rtdu.* TO NULL
            LET l_rtdu.rtduent = g_enterprise
            #自动编号
            CALL s_arti200_get_def_doc_type(l_rtdqsite,'artt405','2')
               RETURNING l_success,l_rtdudocno
            IF NOT l_success THEN
               LET r_success = FALSE
               CONTINUE FOREACH
            END IF
            CALL s_aooi200_gen_docno(l_rtdqsite,l_rtdudocno,g_today,'artt405')
               RETURNING l_success,l_rtdudocno
            IF NOT l_success THEN
               LET r_success = FALSE
               CONTINUE FOREACH
            END IF
            LET l_rtdu.rtdudocno = l_rtdudocno
            LET l_rtdu.rtdudocdt = g_today
            LET l_rtdu.rtdu001 = l_rtdq023
            LET l_rtdu.rtdu002 = l_stan001
            #根据合同抓取相关栏位
            SELECT stan002,stan007,stan009,stan016,stan017,stan018,stan031
              INTO l_rtdu.rtdu003,l_stan007,l_rtdu.rtdu004,l_rtdu.rtdu005,l_stan017,l_stan018,l_stan031
              FROM stan_t
             WHERE stanent = g_enterprise
               AND stan001 = l_stan001
            LET l_rtdu.rtdu006 = g_user
            LET l_rtdu.rtdu009 = '0'
            LET l_rtdu.rtdu010 = '自动抛转'
            LET l_rtdu.rtdu012 = '0'    #160411 dongsz add #采购方式
            LET l_rtdu.rtdustus = 'N'
            LET l_rtdu.rtduownid = g_user
            LET l_rtdu.rtduowndp = g_dept
            LET l_rtdu.rtducrtid = g_user
            LET l_rtdu.rtducrtdp = g_dept
            LET l_rtdu.rtducrtdt = cl_get_current()
            LET l_rtdu.rtdumodid = g_user
            LET l_rtdu.rtdumoddt = cl_get_current()
            LET l_rtdu.rtducnfid = ''
            LET l_rtdu.rtducnfdt = ''
            LET l_rtdu.rtduunit = l_rtdqsite
            LET l_rtdu.rtdusite = l_rtdqsite
            SELECT ooef019,ooef016 INTO l_rtdu.rtdu011,l_ooef016 FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = l_rtdqsite
            LET l_rtdu.rtdu000 = 'I'
            
           #INSERT INTO rtdu_t VALUES (l_rtdu.*)  #161111-00028#3--mark
           #161111-00028#3--add----begin---------
           INSERT INTO rtdu_t (rtduent,rtdudocno,rtdudocdt,rtdu001,rtdu002,rtdu003,rtdu004,rtdu005,rtdu006,
                               rtdu007,rtdu008,rtdu009,rtdu010,rtdustus,
                               rtduownid,rtduowndp,rtducrtid,rtducrtdp,rtducrtdt,rtdumodid,rtdumoddt,rtducnfid,
                               rtducnfdt,rtduunit,rtdusite,rtdu011,rtdu000,rtdu012)
             VALUES (l_rtdu.rtduent,l_rtdu.rtdudocno,l_rtdu.rtdudocdt,l_rtdu.rtdu001,l_rtdu.rtdu002,l_rtdu.rtdu003,l_rtdu.rtdu004,l_rtdu.rtdu005,l_rtdu.rtdu006,
                     l_rtdu.rtdu007,l_rtdu.rtdu008,l_rtdu.rtdu009,l_rtdu.rtdu010,l_rtdu.rtdustus,
                     l_rtdu.rtduownid,l_rtdu.rtduowndp,l_rtdu.rtducrtid,l_rtdu.rtducrtdp,l_rtdu.rtducrtdt,l_rtdu.rtdumodid,l_rtdu.rtdumoddt,l_rtdu.rtducnfid,
                     l_rtdu.rtducnfdt,l_rtdu.rtduunit,l_rtdu.rtdusite,l_rtdu.rtdu011,l_rtdu.rtdu000,l_rtdu.rtdu012)
           #161111-00028#3--add----end-----------
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "ins_rtdu"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET r_success = FALSE
               CONTINUE FOREACH
            END IF
         
            #写入商品引进单身
            IF NOT cl_null(l_stan031) THEN
               LET l_stan018 = l_stan031
            END IF
            #抓取税区
            SELECT ooef019 INTO l_ooef019
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = l_rtdu.rtdusite
            LET l_sql3 = " INSERT INTO rtdv_t (rtdvent,rtdvdocno,rtdvseq,rtdv001,rtdv002,rtdv003, ",
                         "                     rtdv004,rtdv005,rtdv006,rtdv007,rtdv008,rtdv009,rtdv010, ",
                         "                     rtdv011,rtdv012,rtdv013,rtdv014,rtdv015,rtdv016,rtdv017, ",
                         "                     rtdv018,rtdv019,rtdv020,rtdv021,rtdv022,rtdv023,rtdv024, ",
                         "                     rtdv025,rtdv026,rtdv027,rtdv028,rtdv029,rtdv030,rtdv031, ",
                         "                     rtdv032,rtdv033,rtdv034,rtdv035,rtdv036,rtdv037,rtdv038, ",
                         "                     rtdv039,rtdv040) ",
                         " SELECT ",g_enterprise,",'",l_rtdu.rtdudocno,"',ROWNUM,rtdq004,imaa014,'Y', ",
                         #"        '",l_stan007,"',rtdq013,'",l_stan007,"',rtdq027,rtdq010,oocal001,oocal001, ", #20150828 mark by dongsz
                         #"        '",l_stan007,"',oodb006,'",l_stan007,"',oodb006,rtdq010,imaa107,imay004, ", #20150828 add dongsz
                         #"        t1.oodb002,rtdq013,t2.oodb002,rtdq027,rtdq010,imaa107,imay004, ",        #20151203 dongsz add
                         "        rtdq013,t1.oodb006,rtdq027,t2.oodb006,rtdq010,imaa107,imay004, ",        #20151207 dongsz add
                         "        1,'0','",g_user,"',0,0,0,0, ",
                         "        rtdq011,0,0,'N','',rtdq019,rtdq044, ",
                         "        rtdq045,rtdq046,'",l_stan017,"','",l_stan018,"',imaa105,'Y',0, ",
                         "        imaa145,'",l_ooef016,"','3','0','0','','', ",
                         #"        '','N' ",
                         "        (CASE '",l_rtdu.rtdu003,"' WHEN '3' THEN rtdq037 ELSE CAST('' as number) END),'N' ",  #20151031 dongsz add
                         #"   FROM rtdq_t LEFT JOIN oocal_t ON rtdqent = oocalent AND oocal002 = '",g_dlang,"' AND trim(oocal003) = trim(rtdq007),imaa_t,imay_t ",
                         #"   FROM rtdq_t,imaa_t,imay_t,oodb_t ",
                         ##20151203--dongsz add--str
                         #"    FROM rtdq_t,imaa_t,imay_t, ",
                         #"         (SELECT DISTINCT oodb002,oodb006 FROM (SELECT oodb002,oodb006,row_number() over (partition by oodb006 order by oodb002) num ",
                         #"                                                  FROM oodb_t WHERE oodbent = ",g_enterprise," AND oodb001 = '",l_ooef019,"') ",
                         #"           WHERE num = 1) t1, ",
                         #"         (SELECT DISTINCT oodb002,oodb006 FROM (SELECT oodb002,oodb006,row_number() over (partition by oodb006 order by oodb002) num ",
                         #"                                                  FROM oodb_t WHERE oodbent = ",g_enterprise," AND oodb001 = '",l_ooef019,"') ",
                         #"           WHERE num = 1) t2 ",
                         ##20151203--dongsz add--end
                         #20151207--dongsz add--s
                         "   FROM imaa_t,imay_t, ",
                         "        rtdq_t LEFT JOIN oodb_t t1 ON t1.oodbent = rtdqent AND t1.oodb001 = '",l_ooef019,"' AND t1.oodb002 = rtdq013 ",
                         "                 LEFT JOIN oodb_t t2 ON t2.oodbent = rtdqent AND t2.oodb001 = '",l_ooef019,"' AND t2.oodb002 = rtdq027 ",
                         #20151207--dongsz add--e
                         "  WHERE rtdqent = ",g_enterprise," ",
                         "    AND rtdqent = imaaent AND rtdq004 = imaa001 ",
                         "    AND imaaent = imayent AND imaa001 = imay001 AND imay006 = 'Y' ",   #20150828 add by dongsz
                         #"    AND rtdqent = oodbent AND oodb001 = '",l_ooef019,"' AND oodb002 = '",l_stan007,"' ",  #20150828 add by dongsz
                         #"    AND rtdq013 = t1.oodb006 AND rtdq027 = t2.oodb006 ",         #20151203 dongsz add
                         "    AND rtdqsite = '",l_rtdqsite,"' ",
                         "    AND rtdq023 = '",l_rtdq023,"' ",
                         "    AND ",g_wc,
                         "    AND rtdq002 IN (SELECT rtaw002 FROM rtaw_t WHERE rtawent = ",g_enterprise," ",
                         "                         AND rtaw001 IN (SELECT staq003 FROM staq_t WHERE staqent = ",g_enterprise," ",
                         "                                            AND staq001 = '",l_stan001,"')) ",
                         "    AND rtdqacti = 'Y' ",
                         "    AND (rtdq033 IS NULL OR rtdq034 IS NULL) ",
                         "    AND NOT EXISTS (SELECT 1 FROM artp405_tmp WHERE tmp_rtdqent = rtdqent AND tmp_rtdqsite = rtdqsite ",
                         "                       AND tmp_rtdq004 = rtdq004 AND tmp_rtdq032 = rtdq032) ",
                         "  ORDER BY rtdq004 "
            PREPARE ins_rtdv_pre FROM l_sql3
            EXECUTE ins_rtdv_pre
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "ins_rtdv"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET r_success = FALSE
               CONTINUE FOREACH
            END IF
            
            #20151120--dongsz add--str
            #更新结算扣率字段
            IF l_rtdu.rtdu003 = '3' THEN
               LET l_sql3 = " SELECT rtdvseq,rtdv001 FROM rtdv_t ",
                            "  WHERE rtdvent = ",g_enterprise," ",
                            "    AND rtdvdocno = '",l_rtdu.rtdudocno,"' ",
                            "    AND rtdv039 IS NULL "
               PREPARE sel_rtdv_pre FROM l_sql3
               DECLARE sel_rtdv_cs  CURSOR FOR sel_rtdv_pre
               FOREACH sel_rtdv_cs  INTO l_rtdvseq,l_rtdv001
                  #CALL s_astt313_get_stao029(l_rtdu.rtdusite,l_rtdu.rtdu001,l_rtdv001,l_rtdu.rtdudocdt)
                  CALL s_astt313_get_stao012(l_rtdu.rtdusite,l_stan001,l_rtdv001,l_rtdu.rtdudocdt)
                     RETURNING l_rtdv039
                  UPDATE rtdv_t SET rtdv039 = l_rtdv039
                   WHERE rtdvent = g_enterprise
                     AND rtdvdocno = l_rtdu.rtdudocno
                     AND rtdvseq = l_rtdvseq
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = "upd_rtdv039"
                     LET g_errparam.code   = SQLCA.sqlcode
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET r_success = FALSE
                     CONTINUE FOREACH
                  END IF
               END FOREACH
            END IF
            #20151120--dongsz add--end
            
            #20150902--add by dongsz--s
#            #更新PLU里的税别
#            LET l_sql3 = " UPDATE prbh_t SET prbh009,prbh011 = (SELECT rtdv004,rtdv006 FROM rtdv_t ",
#                         "                                       WHERE rtdvent = prbhent ",
#                         "                                         AND rtdv001 = prbh003 AND rtdv002 = prbh004) ",
#                         "  WHERE prbhent = ",g_enterprise," ",
#                         "    AND prbhsite = '",l_rtdu.rtdusite,"' ",
#                         "    AND EXISTS (SELECT 1 FROM rtdv_t WHERE rtdvent = prbhent ",
#                         "                   AND rtdvdocno = '",l_rtdu.rtdudocno,"' ",
#                         "                   AND rtdv001 = prbh001 AND rtdv002 = prbh004) "
#            PREPARE upd_prbh_pre FROM l_sql3
#            EXECUTE upd_prbh_pre
#            IF SQLCA.sqlcode THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.extend = "upd_prbh"
#               LET g_errparam.code   = SQLCA.sqlcode
#               LET g_errparam.popup  = TRUE
#               CALL cl_err()
#               LET r_success = FALSE
#               CONTINUE FOREACH
#            END IF
            #20150902--add by dongsz--e
            
            #20150806--mark by dongsz--s
#            #更新结算扣率字段
#            #20150805--add by dongsz--s
#            IF l_rtdu.rtdu003 = '3' THEN
#               SELECT stao012 INTO l_stao012
#                 FROM stao_t
#                WHERE staoent = g_enterprise
#                  AND stao001 = l_stan001
#                  AND stao003 = '1113'
#               IF cl_null(l_stao012) THEN
#                  LET l_stao012 = 0
#               END IF
#               LET l_sql3 = " UPDATE rtdv_t SET rtdv039 = ",l_stao012," ",
#                            "  WHERE rtdvent = ",g_enterprise," ",
#                            "    AND rtdvdocno = '",l_rtdu.rtdudocno,"' "
#               PREPARE upd_rtdv_pre FROM l_sql3
#               EXECUTE upd_rtdv_pre
#               IF SQLCA.sqlcode THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.extend = "upd_rtdv"
#                  LET g_errparam.code   = SQLCA.sqlcode
#                  LET g_errparam.popup  = TRUE
#                  CALL cl_err()
#                  LET r_success = FALSE
#                  CONTINUE FOREACH
#               END IF
#            END IF
            #20150805--add by dongsz--e
            #20150806--mark by dongsz--e
            #20150805--mark by dongsz--s
#            LET l_sql3 = " MERGE INTO rtdv_t ",
#                         " USING ( ",
#                         " SELECT stas003,stas025 FROM ",
#                         " (SELECT * FROM stas_t,star_t WHERE stasent=starent AND stassite=starsite AND stas001=star001 ",
#                         "     AND stas018 <= '",g_today,"' AND stas019 >= '",g_today,"') ",
#                         " LEFT JOIN (SELECT * FROM stbh_t,stbi_t WHERE stbhent = stbient AND stbhdocno=stbidocno AND stbh003='3' AND stbhstus='Y') ",
#                         "        ON (stbhent = starent AND stbh001 = star004 AND stbh002 = star003 AND stbisite = stassite AND stbi001=stas003 ", 
#                         "            AND stbi011 <= '",g_today,"' AND stbi012 >= '",g_today,"') ",
#                         "  WHERE starent = ",g_enterprise," AND star003 = '",l_rtdq023,"' AND star004 = '",l_stan001,"' AND star005='3') ",
#                         " ON (stas003 = rtdv001 AND rtdvent = ",g_enterprise," AND rtdvdocno = '",l_rtdu.rtdudocno,"') ",
#                         " WHEN MATCHED THEN ",
#                         " UPDATE SET rtdv039 = stas025 "      #结算扣率
#            PREPARE upd_rtdv_pre FROM l_sql3
#            EXECUTE upd_rtdv_pre
#            IF SQLCA.sqlcode THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.extend = "upd_rtdv"
#               LET g_errparam.code   = SQLCA.sqlcode
#               LET g_errparam.popup  = TRUE
#               CALL cl_err()
#               LET r_success = FALSE
#               CONTINUE FOREACH
#            END IF
            #20150805--mark by dongsz--e
            
            #合同签约门店写入门店范围资料
            #按合同簽約門店引進(Y/N)
            #---Y---取合同的簽約門店寫入引進單門店範圍
            IF g_chk1 = 'Y' THEN
               LET l_sql3 = " INSERT INTO rtdw_t (rtdwent,rtdwdocno,rtdw001,rtdw002) ",
                            " SELECT DISTINCT ",g_enterprise,",'",l_rtdu.rtdudocno,"',stbo003,stbo003||'",l_rtdq029,"' ",
                            #" SELECT DISTINCT ",g_enterprise,",'",l_rtdu.rtdudocno,"',stbo003,'",l_rtdq029,"' ",
                            "   FROM stbo_t ",
                            "  WHERE stboent = ",g_enterprise," AND stbo001 = '",l_stan001,"' "
            #---N---單門店引進
            ELSE
               LET l_sql3 = " INSERT INTO rtdw_t (rtdwent,rtdwdocno,rtdw001,rtdw002) ",
                            " VALUES (",g_enterprise,",'",l_rtdu.rtdudocno,"','",l_rtdqsite,"','",l_rtdqsite,"'||'",l_rtdq029,"') "
                            #" VALUES (",g_enterprise,",'",l_rtdu.rtdudocno,"','",l_rtdqsite,"','",l_rtdq029,"') "
            END IF
            PREPARE ins_rtdw_pre FROM l_sql3
            EXECUTE ins_rtdw_pre
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "ins_rtdw"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET r_success = FALSE
               CONTINUE FOREACH
            END IF
            
            #20151126--dongsz add--s
            #采购中心自动写入门店范围
            IF NOT cl_null(l_rtdu.rtdu005) THEN
               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM rtdw_t
                WHERE rtdwent = g_enterprise
                  AND rtdwdocno = l_rtdu.rtdudocno
                  AND rtdw001 = l_rtdu.rtdu005
               IF l_n < 1 THEN
                  LET l_rtdw002 = l_rtdu.rtdu005 CLIPPED,l_rtdq029 CLIPPED
                  INSERT INTO rtdw_t (rtdwent,rtdwdocno,rtdw001,rtdw002)
                  VALUES (g_enterprise,l_rtdu.rtdudocno,l_rtdu.rtdu005,l_rtdw002)
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = "ins_rtdw"
                     LET g_errparam.code   = SQLCA.sqlcode
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET r_success = FALSE
                     CONTINUE FOREACH
                  END IF
               END IF
            END IF
            #20151126--dongsz add--e
            
            #更新导入档的商品引进单号和项次
            LET l_sql3 = " UPDATE rtdq_t SET rtdq033 = '",l_rtdudocno,"', ",
                         "                     rtdq034 = (SELECT rtdvseq FROM rtdv_t WHERE rtdvent = ",g_enterprise," ",
                         "                                     AND rtdvdocno = '",l_rtdudocno,"' AND rtdv001 = rtdq004) ",
                         "  WHERE rtdqent = ",g_enterprise," ",
                         "    AND rtdqsite = '",l_rtdqsite,"' ",
                         "    AND rtdq023 = '",l_rtdq023,"' ",
                         "    AND ",g_wc,
                         "    AND (rtdq033 IS NULL OR rtdq034 IS NULL) ",
                         "    AND NOT EXISTS (SELECT 1 FROM artp405_tmp WHERE tmp_rtdqent = rtdqent AND tmp_rtdqsite = rtdqsite ",
                         "                       AND tmp_rtdq004 = rtdq004 AND tmp_rtdq032 = rtdq032) ",
                         "    AND rtdqacti = 'Y' "
            PREPARE upd_rtdq_pre FROM l_sql3
            EXECUTE upd_rtdq_pre
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "upd_rtdq"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET r_success = FALSE
               CONTINUE FOREACH
            END IF
         END FOREACH
      END FOREACH
   END FOREACH
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 检查字段值是否存在
# Memo...........:
# Usage..........: CALL artp405_rtdq_chk()
# Date & Author..: 20150710 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp405_rtdq_chk()
DEFINE l_sql          STRING
DEFINE l_rtdqsite   LIKE rtdq_t.rtdqsite
DEFINE l_rtdq002    LIKE rtdq_t.rtdq002
DEFINE l_rtdq004    LIKE rtdq_t.rtdq004
DEFINE l_rtdq005    LIKE rtdq_t.rtdq005
DEFINE l_rtdq007    LIKE rtdq_t.rtdq007
DEFINE l_rtdq022    LIKE rtdq_t.rtdq022
DEFINE l_rtdq023    LIKE rtdq_t.rtdq023
DEFINE l_rtdq032    LIKE rtdq_t.rtdq032   #20151016 dongsz add
DEFINE l_rtdq035    LIKE rtdq_t.rtdq035
DEFINE l_imay001      LIKE imay_t.imay001
DEFINE l_cnt          LIKE type_t.num10
DEFINE r_success      LIKE type_t.num5

   DELETE FROM artp405_tmp            #20151016 dongsz add

   CALL cl_err_collect_init() 
   LET r_success = TRUE
   #20150821--mark by dongsz--s
#   #检查商品是否存在
#   LET l_sql = " SELECT DISTINCT rtdq004 FROM rtdq_t ",
#               "  WHERE rtdqent = ",g_enterprise," ",
#               "    AND rtdqacti = 'Y' ",
#               "    AND ",g_wc,
#               "    AND rtdq004 IN (SELECT imaa001 FROM imaa_t WHERE imaaent = ",g_enterprise,") "
#   PREPARE sel_rtdq_pre8 FROM l_sql
#   DECLARE sel_rtdq_cs8  CURSOR FOR sel_rtdq_pre8
#   FOREACH sel_rtdq_cs8  INTO l_rtdq004
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.extend = ""
#      LET g_errparam.code   = 'crt-00006'
#      LET g_errparam.replace[1] = l_rtdq004
#      LET g_errparam.popup  = TRUE
#      CALL cl_err()
#      LET r_success = FALSE
#      CONTINUE FOREACH
#   END FOREACH
#   
#   #检查条码是否存在
#   LET l_sql = " SELECT DISTINCT rtdq005 FROM rtdq_t ",
#               "  WHERE rtdqent = ",g_enterprise," ",
#               "    AND rtdqacti = 'Y' ",
#               "    AND ",g_wc,
#               "    AND rtdq005 IN (SELECT imay003 FROM imay_t WHERE imayent = ",g_enterprise,") "
#   PREPARE sel_rtdq_pre11 FROM l_sql
#   DECLARE sel_rtdq_cs11  CURSOR FOR sel_rtdq_pre11
#   FOREACH sel_rtdq_cs11  INTO l_rtdq005
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.extend = ""
#      LET g_errparam.code   = 'crt-00011'
#      LET g_errparam.replace[1] = l_rtdq005
#      LET g_errparam.popup  = TRUE
#      CALL cl_err()
#      LET r_success = FALSE
#      CONTINUE FOREACH
#   END FOREACH
   #20150821--mark by dongsz--e
   
   #20151116--dongsz add--str---
   #检查必要字段是否为空
   LET l_cnt = 0
   LET l_sql = " SELECT COUNT(*) FROM rtdq_t ",
               "  WHERE rtdqent = ",g_enterprise," ",
               "    AND rtdqacti = 'Y' ",
               "    AND ",g_wc,
               "    AND (rtdq002 IS NULL OR rtdq007 IS NULL OR rtdq021 IS NULL OR ",
               "         rtdq013 IS NULL OR rtdq027 IS NULL OR ",
               "         rtdq029 IS NULL OR rtdq030 IS NULL OR rtdq036 IS NULL) "
   PREPARE sel_cnt_pre FROM l_sql
   EXECUTE sel_cnt_pre INTO l_cnt
   IF l_cnt > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = 'art-00726'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      
      #写入临时表
      LET l_sql = " SELECT rtdqsite,rtdq004,rtdq032 FROM rtdq_t ",
                  "  WHERE rtdqent = ",g_enterprise," ",
                  "    AND rtdqacti = 'Y' ",
                  "    AND ",g_wc,
                  "    AND (rtdq002 IS NULL OR rtdq007 IS NULL OR rtdq021 IS NULL OR ",
                  "         rtdq013 IS NULL OR rtdq027 IS NULL OR ",
                  "         rtdq029 IS NULL OR rtdq030 IS NULL OR rtdq036 IS NULL) "
      PREPARE sel_rtdq_pre12 FROM l_sql
      DECLARE sel_rtdq_cs12  CURSOR FOR sel_rtdq_pre12
      FOREACH sel_rtdq_cs12  INTO l_rtdqsite,l_rtdq004,l_rtdq032
         CALL artp405_ins_tmp(l_rtdqsite,l_rtdq004,l_rtdq032)
         CONTINUE FOREACH
      END FOREACH
   END IF
   #20151116--dongsz add--end---
   
   #20150821--add by dongsz--s
   #检查自编条码如果存在，则商品必须和系统中条码对应的商品一致
   LET l_sql = " SELECT DISTINCT rtdqsite,rtdq004,rtdq005,rtdq032 FROM rtdq_t ",
               "  WHERE rtdqent = ",g_enterprise," ",
               "    AND rtdqacti = 'Y' ",
               "    AND ",g_wc,
               "    AND rtdq005 IN (SELECT imay003 FROM imay_t WHERE imayent = ",g_enterprise,") ",
               "    AND rtdq005 LIKE '2%' "
   PREPARE sel_rtdq_pre8 FROM l_sql
   DECLARE sel_rtdq_cs8  CURSOR FOR sel_rtdq_pre8
   FOREACH sel_rtdq_cs8  INTO l_rtdqsite,l_rtdq004,l_rtdq005,l_rtdq032
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt FROM imay_t
       WHERE imayent = g_enterprise
         AND imay001 = l_rtdq004
         AND imay003 = l_rtdq005
      IF l_cnt < 1 THEN
         SELECT imay001 INTO l_imay001
           FROM imay_t
          WHERE imayent = g_enterprise
            AND imay003 = l_rtdq005
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ""
         LET g_errparam.code   = 'art-00727'
         LET g_errparam.replace[1] = l_rtdq005
         LET g_errparam.replace[2] = l_imay001
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         #LET r_success = FALSE
         CALL artp405_ins_tmp(l_rtdqsite,l_rtdq004,l_rtdq032)  #20151016 dongsz add
         CONTINUE FOREACH
      END IF
   END FOREACH
   #20150821--add by dongsz--e
   
   #检查门店是否存在
   LET l_sql = " SELECT DISTINCT rtdqsite,rtdq004,rtdq032 FROM rtdq_t ",
               "  WHERE rtdqent = ",g_enterprise," ",
               "    AND rtdqacti = 'Y' ",
               "    AND ",g_wc,
               "    AND rtdqsite NOT IN (SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise,") "
   PREPARE sel_rtdq_pre3 FROM l_sql
   DECLARE sel_rtdq_cs3  CURSOR FOR sel_rtdq_pre3
   FOREACH sel_rtdq_cs3  INTO l_rtdqsite,l_rtdq004,l_rtdq032
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = 'art-00731'
      LET g_errparam.replace[1] = l_rtdqsite
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      #LET r_success = FALSE  
      CALL artp405_ins_tmp(l_rtdqsite,l_rtdq004,l_rtdq032)  #20151016 dongsz add
      CONTINUE FOREACH
   END FOREACH
   
   #检查品类是否存在
   LET l_sql = " SELECT DISTINCT rtdqsite,rtdq002,rtdq004,rtdq032 FROM rtdq_t ",
               "  WHERE rtdqent = ",g_enterprise," ",
               "    AND rtdqacti = 'Y' ",
               "    AND ",g_wc,
               "    AND rtdq002 NOT IN (SELECT rtax001 FROM rtax_t WHERE rtaxent = ",g_enterprise,") "
   PREPARE sel_rtdq_pre4 FROM l_sql
   DECLARE sel_rtdq_cs4  CURSOR FOR sel_rtdq_pre4
   FOREACH sel_rtdq_cs4  INTO l_rtdqsite,l_rtdq002,l_rtdq004,l_rtdq032
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = 'art-00732'
      LET g_errparam.replace[1] = l_rtdq002
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      #LET r_success = FALSE
      CALL artp405_ins_tmp(l_rtdqsite,l_rtdq004,l_rtdq032)  #20151016 dongsz add
      CONTINUE FOREACH
   END FOREACH
   
   #检查单位是否存在(【單位不存在是否自動新增】不打勾時檢查)
   IF g_chk2 = 'N' THEN
      LET l_sql = " SELECT DISTINCT rtdqsite,rtdq004,rtdq007,rtdq032 FROM rtdq_t ",
                  "  WHERE rtdqent = ",g_enterprise," ",
                  "    AND rtdqacti = 'Y' ",
                  "    AND ",g_wc,
                  #"    AND rtdq007 NOT IN (SELECT trim(oocal003) FROM oocal_t WHERE oocalent = ",g_enterprise," AND oocal002 = '",g_dlang,"') "    #160128-00001#2--dongsz mark
                  "    AND rtdq007 NOT IN (SELECT ooca001 FROM ooca_t WHERE oocaent = ",g_enterprise,") "           #160128-00001#2--dongsz add
      PREPARE sel_rtdq_pre5 FROM l_sql
      DECLARE sel_rtdq_cs5  CURSOR FOR sel_rtdq_pre5
      FOREACH sel_rtdq_cs5  INTO l_rtdqsite,l_rtdq004,l_rtdq007,l_rtdq032
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ""
         LET g_errparam.code   = 'art-00733'
         LET g_errparam.replace[1] = l_rtdq007
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         #LET r_success = FALSE
         CALL artp405_ins_tmp(l_rtdqsite,l_rtdq004,l_rtdq032)  #20151016 dongsz add
         CONTINUE FOREACH
      END FOREACH
   END IF
   
   #检查品牌是否存在
   LET l_sql = " SELECT DISTINCT rtdqsite,rtdq004,rtdq022,rtdq032 FROM rtdq_t ",
               "  WHERE rtdqent = ",g_enterprise," ",
               "    AND rtdqacti = 'Y' ",
               "    AND ",g_wc,
               "    AND NOT EXISTS (SELECT 1 FROM oocql_t WHERE oocqlent = rtdqent ",
               "                                 AND oocql001 = '2002' AND oocql003 = '",g_dlang,"' ",
               "                                 AND trim(oocql004) = trim(rtdq022)) "
   PREPARE sel_rtdq_pre6 FROM l_sql
   DECLARE sel_rtdq_cs6  CURSOR FOR sel_rtdq_pre6
   FOREACH sel_rtdq_cs6  INTO l_rtdqsite,l_rtdq004,l_rtdq022,l_rtdq032
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = 'art-00734'
      LET g_errparam.replace[1] = l_rtdq022
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      #LET r_success = FALSE
      CALL artp405_ins_tmp(l_rtdqsite,l_rtdq004,l_rtdq032)  #20151016 dongsz add
      CONTINUE FOREACH
   END FOREACH
   
   #检查供应商是否存在
   LET l_sql = " SELECT DISTINCT rtdqsite,rtdq004,rtdq023,rtdq032 FROM rtdq_t ",
               "  WHERE rtdqent = ",g_enterprise," ",
               "    AND rtdqacti = 'Y' ",
               "    AND ",g_wc,
               "    AND rtdq023 NOT IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise," AND (pmaa002 = '1' OR pmaa002 = '3')) "
   PREPARE sel_rtdq_pre7 FROM l_sql
   DECLARE sel_rtdq_cs7  CURSOR FOR sel_rtdq_pre7
   FOREACH sel_rtdq_cs7  INTO l_rtdqsite,l_rtdq004,l_rtdq023,l_rtdq032
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = 'art-00735'
      LET g_errparam.replace[1] = l_rtdq023
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      #LET r_success = FALSE
      CALL artp405_ins_tmp(l_rtdqsite,l_rtdq004,l_rtdq032)  #20151016 dongsz add
      CONTINUE FOREACH
   END FOREACH
   
   #20151208--dongsz add--str---
   #检查税别编号是否存在
   LET l_sql = " SELECT DISTINCT rtdqsite,rtdq004,rtdq032 FROM rtdq_t ",
               "  WHERE rtdqent = ",g_enterprise," ",
               "    AND rtdqacti = 'Y' ",
               "    AND ",g_wc,
               "    AND (rtdq013 NOT IN (SELECT oodb002 FROM oodb_t,ooef_t WHERE oodbent = ",g_enterprise," AND oodbent = ooefent ",
               "                              AND oodb001 = ooef019 AND ooef001 = '",g_site,"') OR ",
               "         rtdq027 NOT IN (SELECT oodb002 FROM oodb_t,ooef_t WHERE oodbent = ",g_enterprise," AND oodbent = ooefent ",
               "                              AND oodb001 = ooef019 AND ooef001 = '",g_site,"')) "
   PREPARE sel_rtdq_pre13 FROM l_sql
   DECLARE sel_rtdq_cs13  CURSOR FOR sel_rtdq_pre13
   FOREACH sel_rtdq_cs13  INTO l_rtdqsite,l_rtdq004,l_rtdq032
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = 'art-00740'
      LET g_errparam.replace[1] = l_rtdq004
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      CALL artp405_ins_tmp(l_rtdqsite,l_rtdq004,l_rtdq032)
      CONTINUE FOREACH
   END FOREACH
   #20151208--dongsz add--end---
   
   #检查合同是否为空
   LET l_sql = " SELECT DISTINCT rtdqsite,rtdq004,rtdq032 FROM rtdq_t ",
               "  WHERE rtdqent = ",g_enterprise," ",
               "    AND rtdqacti = 'Y' ",
               "    AND ",g_wc,
               "    AND rtdq035 IS NULL "
   PREPARE sel_rtdq_pre9 FROM l_sql
   DECLARE sel_rtdq_cs9  CURSOR FOR sel_rtdq_pre9
   FOREACH sel_rtdq_cs9  INTO l_rtdqsite,l_rtdq004,l_rtdq032
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = 'art-00728'
      LET g_errparam.replace[1] = l_rtdq004
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      #LET r_success = FALSE
      CALL artp405_ins_tmp(l_rtdqsite,l_rtdq004,l_rtdq032)  #20151016 dongsz add
      CONTINUE FOREACH
   END FOREACH
   
   #检查同一合同库区编号是否一样
   LET l_sql = " SELECT DISTINCT rtdqsite,rtdq004,rtdq032,rtdq035,COUNT(DISTINCT rtdq029) FROM rtdq_t ",
               "  WHERE rtdqent = ",g_enterprise," ",
               "    AND rtdqacti = 'Y' ",
               "    AND ",g_wc,
               "  GROUP BY rtdqsite,rtdq004,rtdq032,rtdq035 "
   PREPARE sel_rtdq_pre10 FROM l_sql
   DECLARE sel_rtdq_cs10  CURSOR FOR sel_rtdq_pre10
   FOREACH sel_rtdq_cs10  INTO l_rtdqsite,l_rtdq004,l_rtdq032,l_rtdq035,l_cnt
      IF l_cnt > 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ""
         LET g_errparam.code   = 'art-00729'
         LET g_errparam.replace[1] = l_rtdq035
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         #LET r_success = FALSE
         CALL artp405_ins_tmp(l_rtdqsite,l_rtdq004,l_rtdq032)  #20151016 dongsz add
         CONTINUE FOREACH
      END IF
   END FOREACH
   
   #判断门店是否签约
   LET l_sql = " SELECT DISTINCT rtdqsite,rtdq004,rtdq032,rtdq035 FROM rtdq_t ",
               "  WHERE rtdqent = ",g_enterprise," ",
               "    AND rtdqacti = 'Y' ",
               "    AND ",g_wc,
               "    AND NOT EXISTS (SELECT 1 FROM stbo_t WHERE stboent = rtdqent ",
               "                       AND stbo001 = rtdq035 AND stbo003 = rtdqsite) "
   PREPARE sel_rtdq_pre11 FROM l_sql
   DECLARE sel_rtdq_cs11  CURSOR FOR sel_rtdq_pre11
   LET l_rtdqsite = ''
   LET l_rtdq004 = ''
   LET l_rtdq032 = ''
   LET l_rtdq035 = ''
   FOREACH sel_rtdq_cs11  INTO l_rtdqsite,l_rtdq004,l_rtdq032,l_rtdq035
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = 'art-00736'
      LET g_errparam.replace[1] = l_rtdqsite
      LET g_errparam.replace[2] = l_rtdq035
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      #LET r_success = FALSE
      CALL artp405_ins_tmp(l_rtdqsite,l_rtdq004,l_rtdq032)  #20151016 dongsz add
      CONTINUE FOREACH
   END FOREACH 
             
   CALL cl_err_collect_show()
   RETURN r_success       
END FUNCTION

################################################################################
# Descriptions...: 修改单身
# Memo...........:
# Usage..........: CALL artp405_modify()
# Date & Author..: 20150714 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp405_modify()
DEFINE  l_cmd_t               LIKE type_t.chr1
DEFINE  l_cmd                 LIKE type_t.chr1
DEFINE  l_insert              BOOLEAN
DEFINE  l_n                   LIKE type_t.num10               #檢查重複用  
DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
DEFINE  l_rtax004             LIKE rtax_t.rtax004
DEFINE  l_ooef019             LIKE ooef_t.ooef019      #20151208 dongsz add

   #保存單頭舊值
   #LET g_detail_d_t.* = g_detail_d.*
   #LET g_detail_d_o.* = g_detail_d.*
   
   #IF g_detail_d.rtdq032 IS NULL
   #
   #THEN
   #   INITIALIZE g_errparam TO NULL 
   #   LET g_errparam.extend = "" 
   #   LET g_errparam.code   = "std-00003" 
   #   LET g_errparam.popup  = FALSE 
   #   CALL cl_err()
   #   RETURN
   #END IF
 
   ERROR ""
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      INPUT ARRAY g_detail_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
                  
         BEFORE INPUT
            #add-point:資料輸入前
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_detail_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL artp405_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_detail_d.getLength()
            #add-point:資料輸入前

            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2

            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 1
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            #OPEN artp405_cl USING g_enterprise,g_detail_d[l_ac].rtdq032,g_detail_d[l_ac].rtdq004
            #IF STATUS THEN
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "OPEN artp405_cl:" 
            #   LET g_errparam.code   = STATUS 
            #   LET g_errparam.popup  = TRUE 
            #   CALL cl_err()
            #   CLOSE artp405_cl
            #   CALL s_transaction_end('N','0')
            #   RETURN
            #END IF
            
            LET g_rec_b = g_detail_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_detail_d[l_ac].rtdq032 IS NOT NULL
               AND g_detail_d[l_ac].rtdq004 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_detail_d_t.* = g_detail_d[l_ac].*  #BACKUP
               LET g_detail_d_o.* = g_detail_d[l_ac].*  #BACKUP
               #CALL aprt114_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b
             
               #end add-point  
               #CALL aprt114_set_no_entry_b(l_cmd)
               #IF NOT artp405_lock_b("rtdq_t","'1'") THEN
               #   LET l_lock_sw='Y'
               #ELSE
               #   FETCH artp405_bcl INTO g_detail_d[l_ac].sel,g_detail_d[l_ac].rtdqsite,g_detail_d[l_ac].rtdq001,g_detail_d[l_ac].rtdq002,
               #                          g_detail_d[l_ac].rtdq003,g_detail_d[l_ac].rtdq004,g_detail_d[l_ac].rtdq005,g_detail_d[l_ac].rtdq006,
               #                          g_detail_d[l_ac].rtdq007,g_detail_d[l_ac].rtdq008,g_detail_d[l_ac].rtdq009,g_detail_d[l_ac].rtdq010,
               #                          g_detail_d[l_ac].rtdq011,g_detail_d[l_ac].rtdq012,g_detail_d[l_ac].rtdq013,g_detail_d[l_ac].rtdq014,
               #                          g_detail_d[l_ac].rtdq015,g_detail_d[l_ac].rtdq016,g_detail_d[l_ac].rtdq017,g_detail_d[l_ac].rtdq018,
               #                          g_detail_d[l_ac].rtdq019,g_detail_d[l_ac].rtdq020,g_detail_d[l_ac].rtdq021,g_detail_d[l_ac].rtdq022,
               #                          g_detail_d[l_ac].rtdq023,g_detail_d[l_ac].rtdq024,g_detail_d[l_ac].rtdq035,g_detail_d[l_ac].rtdq025,g_detail_d[l_ac].rtdq026,
               #                          g_detail_d[l_ac].rtdq027,g_detail_d[l_ac].rtdq028,g_detail_d[l_ac].rtdq029,g_detail_d[l_ac].rtdq030,
               #                          g_detail_d[l_ac].rtdq031,g_detail_d[l_ac].rtdq032,g_detail_d[l_ac].rtdq033,g_detail_d[l_ac].rtdq034
               #   IF SQLCA.sqlcode THEN
               #      INITIALIZE g_errparam TO NULL 
               #      LET g_errparam.extend = g_detail_d_t.rtdq004 
               #      LET g_errparam.code   = SQLCA.sqlcode 
               #      LET g_errparam.popup  = TRUE 
               #      CALL cl_err()
               #      LET l_lock_sw = "Y"
               #   END IF
               #   
               #   #LET g_bfill = "N"
               #   #CALL aprt114_show()
               #   #LET g_bfill = "Y"
               #   
               #   CALL cl_show_fld_cont()
               #END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            IF l_cmd = 'a' THEN
               EXIT DIALOG
            END IF
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
         BEFORE FIELD rtdq004
         
         AFTER FIELD rtdq004
         
         ON ACTION controlp INFIELD b_rtdq002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_detail_d[l_ac].rtdq002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_rtax001()                                #呼叫開窗

            LET g_detail_d[l_ac].rtdq002 = g_qryparam.return1              

            DISPLAY g_detail_d[l_ac].rtdq002 TO b_rtdq002              #

            NEXT FIELD b_rtdq002

         ON ACTION controlp INFIELD b_rtdq003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_detail_d[l_ac].rtdq003             #給予default值

            #給予arg
            LET l_rtax004 = cl_get_para(g_enterprise,g_site,'E-CIR-0001')
            LET g_qryparam.arg1 = l_rtax004 #s

            CALL q_rtax001_3()                                #呼叫開窗

            LET g_detail_d[l_ac].rtdq003 = g_qryparam.return1              

            DISPLAY g_detail_d[l_ac].rtdq003 TO b_rtdq003             #

            NEXT FIELD b_rtdq003
            
         ON ACTION controlp INFIELD b_rtdq007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_detail_d[l_ac].rtdq007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooca001_1()                                #呼叫開窗

            LET g_detail_d[l_ac].rtdq007 = g_qryparam.return1              

            DISPLAY g_detail_d[l_ac].rtdq007 TO b_rtdq007              #

            NEXT FIELD b_rtdq007
            
         ON ACTION controlp INFIELD b_rtdq021
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_detail_d[l_ac].rtdq021             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2002" #s


            CALL q_oocq002()                                #呼叫開窗

            LET g_detail_d[l_ac].rtdq021 = g_qryparam.return1              

            DISPLAY g_detail_d[l_ac].rtdq021 TO b_rtdq021              #

            NEXT FIELD b_rtdq021
            
         ON ACTION controlp INFIELD b_rtdq023
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_detail_d[l_ac].rtdq023             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_pmaa001_10()                                #呼叫開窗

            LET g_detail_d[l_ac].rtdq023 = g_qryparam.return1              

            DISPLAY g_detail_d[l_ac].rtdq023 TO b_rtdq023              #

            NEXT FIELD b_rtdq023
            
         ON ACTION controlp INFIELD b_rtdq035
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_detail_d[l_ac].rtdq035            #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where = " stan001 IN (SELECT stan001 FROM stan_t,staq_t WHERE stanent = staqent ",
                                   "                AND stan001 = staq001 AND stan005 = '",g_detail_d[l_ac].rtdq023,"' ",
                                   "                AND stan029 IN ('2','3','4') ",
                                   "                AND staq003 = '",g_detail_d[l_ac].rtdq003,"') "

            CALL q_stan001_2()                                #呼叫開窗

            LET g_detail_d[l_ac].rtdq035 = g_qryparam.return1              

            DISPLAY g_detail_d[l_ac].rtdq035 TO b_rtdq035              #

            NEXT FIELD b_rtdq035
            
         #20151208--dongsz add--str--
         ON ACTION controlp INFIELD b_rtdq013
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_detail_d[l_ac].rtdq013             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_detail_d[l_ac].rtdqsite


            CALL q_oodb002_8()                                #呼叫開窗

            LET g_detail_d[l_ac].rtdq013 = g_qryparam.return1  
            LET g_detail_d[l_ac].rtdq013_desc = g_qryparam.return2            

            DISPLAY g_detail_d[l_ac].rtdq013 TO b_rtdq013              #
            DISPLAY g_detail_d[l_ac].rtdq013_desc TO b_rtdq013_desc 

            NEXT FIELD b_rtdq013
            
         ON ACTION controlp INFIELD b_rtdq027
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_detail_d[l_ac].rtdq027             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_detail_d[l_ac].rtdqsite


            CALL q_oodb002_8()                                #呼叫開窗

            LET g_detail_d[l_ac].rtdq027 = g_qryparam.return1  
            LET g_detail_d[l_ac].rtdq027_desc = g_qryparam.return2            

            DISPLAY g_detail_d[l_ac].rtdq027 TO b_rtdq027             #
            DISPLAY g_detail_d[l_ac].rtdq027_desc TO b_rtdq027_desc 

            NEXT FIELD b_rtdq027
         #20151208--dongsz add--end--
         
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_detail_d[l_ac].* = g_detail_d_t.*
               #CLOSE artp405_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_detail_d[l_ac].rtdq004 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_detail_d[l_ac].* = g_detail_d_t.*
            ELSE
            
               #add-point:單身修改前

               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               #CALL aprt114_rtdq_t_mask_restore('restore_mask_o')
      
               UPDATE rtdq_t SET (rtdqsite,rtdq001,rtdq002,rtdq003,rtdq004,rtdq005,
                                    rtdq006,rtdq007,rtdq008,rtdq009,rtdq036,rtdq010,rtdq011,
                                    rtdq012,rtdq013,rtdq014,rtdq015,rtdq016,rtdq017,
                                    rtdq018,rtdq019,rtdq020,rtdq037,rtdq038,rtdq021,rtdq022,rtdq023,   #20151031 dongsz add rtdq037,rtdq038
                                    rtdq024,rtdq025,rtdq026,rtdq027,rtdq028,rtdq029,
                                    rtdq030,rtdq031,rtdq032,rtdq035,rtdqacti) = 
                                   (g_detail_d[l_ac].rtdqsite,g_detail_d[l_ac].rtdq001,g_detail_d[l_ac].rtdq002,g_detail_d[l_ac].rtdq003,g_detail_d[l_ac].rtdq004,g_detail_d[l_ac].rtdq005,
                                    g_detail_d[l_ac].rtdq006,g_detail_d[l_ac].rtdq007,g_detail_d[l_ac].rtdq008,g_detail_d[l_ac].rtdq009,g_detail_d[l_ac].rtdq036,g_detail_d[l_ac].rtdq010,g_detail_d[l_ac].rtdq011,
                                    g_detail_d[l_ac].rtdq012,g_detail_d[l_ac].rtdq013,g_detail_d[l_ac].rtdq014,g_detail_d[l_ac].rtdq015,g_detail_d[l_ac].rtdq016,g_detail_d[l_ac].rtdq017,
                                    g_detail_d[l_ac].rtdq018,g_detail_d[l_ac].rtdq019,g_detail_d[l_ac].rtdq020,g_detail_d[l_ac].rtdq037,g_detail_d[l_ac].rtdq038,g_detail_d[l_ac].rtdq021,g_detail_d[l_ac].rtdq022,g_detail_d[l_ac].rtdq023,
                                    g_detail_d[l_ac].rtdq024,g_detail_d[l_ac].rtdq025,g_detail_d[l_ac].rtdq026,g_detail_d[l_ac].rtdq027,g_detail_d[l_ac].rtdq028,g_detail_d[l_ac].rtdq029,
                                    g_detail_d[l_ac].rtdq030,g_detail_d[l_ac].rtdq031,g_detail_d[l_ac].rtdq032,g_detail_d[l_ac].rtdq035,g_detail_d[l_ac].sel) 

                WHERE rtdqent = g_enterprise AND rtdq032 = g_detail_d_t.rtdq032  
                  AND rtdq004 = g_detail_d_t.rtdq004
 
                  
               #add-point:單身修改中

               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtdq_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_detail_d[l_ac].* = g_detail_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtdq_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()                   
                     CALL s_transaction_end('N','0')
                     LET g_detail_d[l_ac].* = g_detail_d_t.*  
                  OTHERWISE
                     #資料多語言用-增/改
                     
               END CASE
 
               #將遮罩欄位進行遮蔽
               #CALL aprt114_rtdq_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               #INITIALIZE gs_keys TO NULL
               #IF NOT(g_detail_d[g_detail_idx].rtdqseq = g_detail_d_t.rtdqseq 
               #   AND g_detail_d[g_detail_idx].rtdqseq1 = g_detail_d_t.rtdqseq1 
               #
               #   ) THEN
               #   LET gs_keys[01] = g_detail_d.prbfdocno
               #
               #   LET gs_keys[gs_keys.getLength()+1] = g_detail_d_t.rtdqseq
               #   LET gs_keys[gs_keys.getLength()+1] = g_detail_d_t.rtdqseq1
               #
               #   CALL aprt114_key_update_b(gs_keys,'rtdq_t')
               #END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_detail_d),util.JSON.stringify(g_detail_d_t)
               LET g_log2 = util.JSON.stringify(g_detail_d),util.JSON.stringify(g_detail_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後

               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row

            #end add-point
            #CALL artp405_unlock_b("rtdq_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2

            #end add-point
              
         AFTER INPUT
            CALL artp405_b_fill()
            
      END INPUT
      
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog
         CASE g_aw
            WHEN "s_detail1"
               NEXT FIELD sel  
         END CASE   
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
      
      AFTER DIALOG
         #add-point:input段after_dialog

         #end add-point    
   
      ON ACTION accept
         #add-point:input段accept 

         #end add-point    
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         #add-point:input段cancel

         #end add-point  
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         #LET g_detail_idx2 = 1
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         #add-point:input段close

         #end add-point  
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         #add-point:input段exit

         #end add-point
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
   
END FUNCTION

################################################################################
# Descriptions...: 更新导入资料
# Memo...........:
# Usage..........: CALL artp405_upd_rtdq()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 20150827 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp405_upd_rtdq()
DEFINE l_sql      STRING

   #更新商品编号
   LET l_sql = " UPDATE rtdq_t SET rtdq004 = (SELECT imay001 FROM imay_t WHERE imayent = rtdqent ",
               "                                     AND imay003 = rtdq005) ",
               "  WHERE rtdqent = ",g_enterprise," ",
               "    AND rtdqacti = 'Y' ",
               "    AND ",g_wc,
               "    AND rtdq005 IN (SELECT imay003 FROM imay_t WHERE imayent = ",g_enterprise,") ",
               "    AND rtdq005 NOT LIKE '2%' ",
               "    AND NOT EXISTS (SELECT 1 FROM artp405_tmp WHERE tmp_rtdqent = rtdqent AND tmp_rtdqsite = rtdqsite ",
               "                       AND tmp_rtdq004 = rtdq004 AND tmp_rtdq032 = rtdq032) "
   PREPARE upd_rtdq_pre1 FROM l_sql
   EXECUTE upd_rtdq_pre1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "rtdq004"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF

   #更新品牌编号
   LET l_sql = " UPDATE rtdq_t SET rtdq021 = (SELECT oocql002 FROM (SELECT oocqlent,oocql002,oocql004,row_number() over (partition by trim(oocql004) order by oocql002) num ",
               "                                                          FROM oocql_t WHERE oocqlent = ",g_enterprise," ",
               "                                                           AND oocql001 = '2002' AND oocql003 = '",g_dlang,"') t1 ",
               "                                   WHERE t1.oocqlent = rtdqent AND t1.num = 1 AND trim(t1.oocql004) = trim(rtdq022)) ",
               "  WHERE rtdqent = ",g_enterprise," ",
               "    AND rtdqacti = 'Y' ",
               "    AND ",g_wc,
               "    AND NOT EXISTS (SELECT 1 FROM artp405_tmp WHERE tmp_rtdqent = rtdqent AND tmp_rtdqsite = rtdqsite ",
               "                       AND tmp_rtdq004 = rtdq004 AND tmp_rtdq032 = rtdq032) "
   PREPARE upd_rtdq_pre2 FROM l_sql
   EXECUTE upd_rtdq_pre2
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "rtdq021"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
   
   RETURN TRUE
   
END FUNCTION

################################################################################
# Descriptions...: 建立临时表储存有问题的资料
# Memo...........:
# Usage..........: CALL artp405_tmp(p_type)
# Date & Author..: 20151016 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp405_tmp(p_type)
DEFINE p_type      LIKE type_t.chr1
DEFINE r_success   LIKE type_t.num5

   #遇错继续执行
   WHENEVER ERROR CONTINUE
   
   #初始化
   LET r_success = TRUE
   
   CASE p_type
      WHEN '1'
         DROP TABLE artp405_tmp
         CREATE TEMP TABLE artp405_tmp(
            tmp_rtdqent      LIKE rtdq_t.rtdqent,   #企业编号
            tmp_rtdqsite     LIKE rtdq_t.rtdqsite,  #营运组织
            tmp_rtdq004      LIKE rtdq_t.rtdq004,   #商品编号
            tmp_rtdq032      LIKE rtdq_t.rtdq032)   #任务单号
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'CREATE TABLE artp405_tmp'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN FALSE
         END IF
      WHEN '2'
         DROP TABLE artp405_tmp
   END CASE
   
   RETURN TRUE
   
END FUNCTION

################################################################################
# Descriptions...: 插入临时表资料
# Memo...........:
# Usage..........: CALL artp405_ins_tmp(p_rtdqsite,p_rtdq004,p_rtdq032)
# Date & Author..: 20151016 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp405_ins_tmp(p_rtdqsite,p_rtdq004,p_rtdq032)
DEFINE p_rtdqsite      LIKE rtdq_t.rtdqsite
DEFINE p_rtdq004       LIKE rtdq_t.rtdq004
DEFINE p_rtdq032       LIKE rtdq_t.rtdq032
DEFINE l_n               LIKE type_t.num10
DEFINE l_sql             STRING

   LET l_n = 0
   LET l_sql = " SELECT COUNT(*) FROM artp405_tmp ",
               "  WHERE tmp_rtdqent = ",g_enterprise," ",
               "    AND tmp_rtdqsite = '",p_rtdqsite,"' ",
               "    AND tmp_rtdq004 = '",p_rtdq004,"' ",
               "    AND tmp_rtdq032 = '",p_rtdq032,"' "
   PREPARE sel_tmp_pre FROM l_sql
   EXECUTE sel_tmp_pre INTO l_n
   IF l_n < 1 THEN
      LET l_sql = " INSERT INTO artp405_tmp (tmp_rtdqent,tmp_rtdqsite,tmp_rtdq004,tmp_rtdq032) ",
                  " VALUES (",g_enterprise,",'",p_rtdqsite,"','",p_rtdq004,"','",p_rtdq032,"') "
      PREPARE ins_tmp_pre FROM l_sql
      EXECUTE ins_tmp_pre
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 顯示引進清單商品明細
# Memo...........:
# Usage..........: CALL artp405_b_fill2()
# Date & Author..: 20160218 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp405_b_fill2()
DEFINE l_sql      STRING
DEFINE l_ooef019  LIKE ooef_t.ooef019
DEFINE l_i        LIKE type_t.num5

   CALL g_detail_d3.clear()
   
   LET g_detail_idx2 = l_ac
   IF g_detail_idx2 = 0 THEN
      RETURN
   END IF
   
   LET l_i = l_ac
   
   LET l_sql = " SELECT DISTINCT rtdvseq,rtdv002,rtdv001,imaal003,imaal004, ",
               "        rtdv018,rtdv023,rtdv024,rtdv025,rtdv026,rtdv020, ",
               "        rtdv021,rtdv022,rtdv004,rtdv006, ",
               "        rtdv008,rtdv009,a.oocal003,rtdv011,rtdv033,ooail003, ",
               "        rtdv017,rtdv019,rtdv031,rtdv029,b.oocal003, ",
               "        rtdv040,rtdv003,rtdv010,c.oocal003,rtdv013,ooag011, ",
               "        rtdv014,rtdv015,rtdv016,rtdv034, ",
               "        rtdv035,rtdv036,rtdv037,rtdv038, ",
               "        rtdv032,d.oocal003,rtdv027,rtdv028 ",
               "   FROM rtdv_t LEFT JOIN imaal_t ON imaalent = rtdvent AND imaal001 = rtdv001 AND imaal002 = '",g_dlang,"' ",
               "               LEFT JOIN oocal_t a ON a.oocalent = rtdvent AND a.oocal001 = rtdv009 AND a.oocal002 = '",g_dlang,"' ",
               "               LEFT JOIN ooail_t ON ooailent = rtdvent AND ooail001 = rtdv033 AND ooail002 = '",g_dlang,"' ",
               "               LEFT JOIN oocal_t b ON b.oocalent = rtdvent AND b.oocal001 = rtdv029 AND b.oocal002 = '",g_dlang,"' ",
               "               LEFT JOIN oocal_t c ON c.oocalent = rtdvent AND c.oocal001 = rtdv010 AND c.oocal002 = '",g_dlang,"' ",
               "               LEFT JOIN ooag_t ON ooagent = rtdvent AND ooag001 = rtdv013 ",
               "               LEFT JOIN oocal_t d ON d.oocalent = rtdvent AND d.oocal001 = rtdv032 AND d.oocal002 = '",g_dlang,"' ",
               "  WHERE rtdvent = ",g_enterprise," ",
               "    AND rtdvdocno = '",g_detail_d2[g_detail_idx2].rtdudocno,"' ",
               "  ORDER BY rtdvseq "
   PREPARE sel_rtdv_pre2 FROM l_sql
   DECLARE sel_rtdv_cs2  CURSOR FOR sel_rtdv_pre2
   LET l_ac = 1
   FOREACH sel_rtdv_cs2  INTO g_detail_d3[l_ac].rtdvseq,g_detail_d3[l_ac].rtdv002,g_detail_d3[l_ac].rtdv001,g_detail_d3[l_ac].imaal003,g_detail_d3[l_ac].imaal004,
                             g_detail_d3[l_ac].rtdv018,g_detail_d3[l_ac].rtdv023,g_detail_d3[l_ac].rtdv024,g_detail_d3[l_ac].rtdv025,g_detail_d3[l_ac].rtdv026,g_detail_d3[l_ac].rtdv020,
                             g_detail_d3[l_ac].rtdv021,g_detail_d3[l_ac].rtdv022,g_detail_d3[l_ac].rtdv004,g_detail_d3[l_ac].rtdv006,
                             g_detail_d3[l_ac].rtdv008,g_detail_d3[l_ac].rtdv009,g_detail_d3[l_ac].rtdv009_desc,g_detail_d3[l_ac].rtdv011,g_detail_d3[l_ac].rtdv033,g_detail_d3[l_ac].rtdv033_desc,
                             g_detail_d3[l_ac].rtdv017,g_detail_d3[l_ac].rtdv019,g_detail_d3[l_ac].rtdv031,g_detail_d3[l_ac].rtdv029,g_detail_d3[l_ac].rtdv029_desc,
                             g_detail_d3[l_ac].rtdv040,g_detail_d3[l_ac].rtdv003,g_detail_d3[l_ac].rtdv010,g_detail_d3[l_ac].rtdv010_desc,g_detail_d3[l_ac].rtdv013,g_detail_d3[l_ac].rtdv013_desc,
                             g_detail_d3[l_ac].rtdv014,g_detail_d3[l_ac].rtdv015,g_detail_d3[l_ac].rtdv016,g_detail_d3[l_ac].rtdv034,
                             g_detail_d3[l_ac].rtdv035,g_detail_d3[l_ac].rtdv036,g_detail_d3[l_ac].rtdv037,g_detail_d3[l_ac].rtdv038,
                             g_detail_d3[l_ac].rtdv032,g_detail_d3[l_ac].rtdv032_desc,g_detail_d3[l_ac].rtdv027,g_detail_d3[l_ac].rtdv028
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #税别说明
      SELECT ooef019 INTO l_ooef019 FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_site
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_ooef019
      LET g_ref_fields[2] = g_detail_d3[l_ac].rtdv004
      CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail_d3[l_ac].rtdv004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_detail_d3[l_ac].rtdv004_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_ooef019
      LET g_ref_fields[2] = g_detail_d3[l_ac].rtdv006
      CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail_d3[l_ac].rtdv006_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_detail_d3[l_ac].rtdv006_desc
      
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
   
   CALL g_detail_d3.deleteElement(g_detail_d3.getLength())
   
   LET l_ac = l_i

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL artp405_set_entry(p_cmd)
# Date & Author..: 20160218 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp405_set_entry(p_cmd)
DEFINE p_cmd      LIKE type_t.chr1

   CALL cl_set_comp_entry("imaf062,imaf063,imaf064",TRUE)

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL artp405_set_no_required(p_cmd)
# Date & Author..: 20160218 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp405_set_no_required(p_cmd)
DEFINE p_cmd     LIKE type_t.chr1

   CALL cl_set_comp_required("imaf063",FALSE)

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL artp405_set_required(p_cmd)
# Date & Author..: 20160219 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp405_set_required(p_cmd)
DEFINE p_cmd     LIKE type_t.chr1

   IF g_imaf062 = 'Y' THEN
     CALL cl_set_comp_required("imaf063",TRUE)
     CALL artp405_imaf063_default()
   END IF

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL artp405_set_no_entry(p_cmd)
# Date & Author..: 20160219 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp405_set_no_entry(p_cmd)
DEFINE p_cmd   LIKE type_t.chr1

   IF g_imaf061 = '2' THEN
      CALL cl_set_comp_entry("imaf062,imaf063,imaf064",FALSE)
   END IF
   IF g_imaf062 = 'N' THEN
      CALL cl_set_comp_entry("imaf063",FALSE)
   END IF

END FUNCTION

################################################################################
# Descriptions...: 顯示引進清單門店範圍
# Memo...........:
# Usage..........: CALL artp405_b_fill3()
# Date & Author..: 20160218 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp405_b_fill3()
DEFINE l_sql      STRING
DEFINE l_i        LIKE type_t.num5

   CALL g_detail_d4.clear()
   
   LET g_detail_idx2 = l_ac
   IF g_detail_idx2 = 0 THEN
      RETURN
   END IF
   
   LET l_i = l_ac
   
   LET l_sql = " SELECT DISTINCT rtdw001,ooefl003,rtdw002,inayl003 ",
               "   FROM rtdw_t LEFT OUTER JOIN ooefl_t ON ooeflent = rtdwent AND ooefl001 = rtdw001 AND ooefl002 = '",g_dlang,"' ",
               "               LEFT OUTER JOIN inayl_t ON inaylent = rtdwent AND inayl001 = rtdw002 AND inayl002 = '",g_dlang,"' ",
               "  WHERE rtdwent = ",g_enterprise," ",
               "    AND rtdwdocno = '",g_detail_d2[g_detail_idx2].rtdudocno,"' ",
               "  ORDER BY rtdw001 "
   PREPARE sel_rtdw_pre FROM l_sql
   DECLARE sel_rtdw_cs  CURSOR FOR sel_rtdw_pre
   LET l_ac = 1
   FOREACH sel_rtdw_cs  INTO g_detail_d4[l_ac].rtdw001,g_detail_d4[l_ac].rtdw001_desc,
                             g_detail_d4[l_ac].rtdw002,g_detail_d4[l_ac].rtdw002_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
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
   
   CALL g_detail_d4.deleteElement(g_detail_d4.getLength())
   
   LET l_ac = l_i
END FUNCTION

################################################################################
# Descriptions...: 抓取默认批号编码方式
# Memo...........:
# Usage..........: CALL artp405_imaf063_default()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION artp405_imaf063_default()

   
   SELECT DISTINCT oofg001 INTO g_imaf063
     FROM oofg_t
    WHERE oofgent = g_enterprise
      AND oofg002 = '6'
      AND oofgstus = 'Y'
   IF SQLCA.sqlcode <> 0 THEN
      LET g_imaf063 = ''
   END IF

END FUNCTION

################################################################################
# Descriptions...: 導入資料前檢查
# Memo...........:
# Usage..........: CALL artp405_ins_chk()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION artp405_ins_chk()
DEFINE l_sql      STRING
DEFINE l_cnt      LIKE type_t.num10
DEFINE l_rtdqsite LIKE rtdq_t.rtdqsite
DEFINE l_rtdq023  LIKE rtdq_t.rtdq023
DEFINE l_rtdq004  LIKE rtdq_t.rtdq004
DEFINE l_n        LIKE type_t.num10

   #检查导入条件是否输入完整
   IF g_imaf062 = 'Y' THEN
      IF cl_null(g_imaf063) THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = "art-00754" 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
   
   #检查是否有可导入资料
   LET l_cnt = 0
   LET l_sql = " SELECT COUNT(*) FROM rtdq_t ",
               "  WHERE rtdqent = ",g_enterprise," ",
               "    AND rtdqacti = 'Y' ",
               "    AND ",g_wc,
               "    AND (rtdq033 IS NULL OR rtdq034 IS NULL) "
   PREPARE sel_cnt_rtdq FROM l_sql
   EXECUTE sel_cnt_rtdq INTO l_cnt
   IF l_cnt < 1 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "art-00755" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE
   END IF
   
   #检查门店+供应商+商品不能重复
   CALL cl_err_collect_init() 
   LET l_sql = " SELECT rtdqsite,rtdq023,rtdq004,COUNT(*) FROM rtdq_t ",
               "  WHERE rtdqent = ",g_enterprise," ",
               "    AND rtdqacti = 'Y' ",
               "    AND ",g_wc,
               "    AND (rtdq033 IS NULL OR rtdq034 IS NULL) ",
               "  GROUP BY rtdqsite,rtdq023,rtdq004 ",
               " HAVING COUNT(*) > 1 "
   PREPARE sel_cnt_pre1 FROM l_sql
   DECLARE sel_cnt_cs1  CURSOR FOR sel_cnt_pre1
   LET l_n = 0
   FOREACH sel_cnt_cs1  INTO l_rtdqsite,l_rtdq023,l_rtdq004
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "art-00756" 
      LET g_errparam.replace[1] = l_rtdqsite
      LET g_errparam.replace[2] = l_rtdq023
      LET g_errparam.replace[3] = l_rtdq004
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET l_n = l_n + 1
   END FOREACH
   IF l_n > 0 THEN
      CALL cl_err_collect_show()
      RETURN FALSE
   END IF
   CALL cl_err_collect_show()
   
   RETURN TRUE
END FUNCTION

#end add-point
 
{</section>}
 
