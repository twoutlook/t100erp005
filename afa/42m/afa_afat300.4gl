#該程式未解開Section, 採用最新樣板產出!
{<section id="afat300.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2015-03-24 11:04:21), PR版次:0010(2016-11-28 14:52:41)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000075
#+ Filename...: afat300
#+ Description: 資產開帳維護作業
#+ Creator....: 05426(2014-10-17 09:34:00)
#+ Modifier...: 02003 -SD/PR- 01531
 
{</section>}
 
{<section id="afat300.global" >}
#應用 t02 樣板自動產生(Version:46)
#add-point:填寫註解說明 name="global.memo"
#150916-00015#1   2015/12/7   By 07675       1.快捷带出类似科目编号 2.当有账套时，科目检查改为检查是否存在于glad_t中
#160318-00025#5   2016/04/14  By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#161024-00008#2   2016/10/24  By Hans        AFA組織類型與職能開窗清單調整。
#161111-00028#6   2016/11/21  by 06189       标准程式定义采用宣告模式,弃用.*写
#161111-00049#12  2016/11/28  By 01531       二阶段FA问题7~14 调整作业:afat450/afat500/afat501/afat502/afat503/afat504/afat505/afat506
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
PRIVATE TYPE type_g_faah_d RECORD
       faah000 LIKE faah_t.faah000, 
   faah001 LIKE faah_t.faah001, 
   faah003 LIKE faah_t.faah003, 
   faah004 LIKE faah_t.faah004, 
   faah002 LIKE faah_t.faah002, 
   faah005 LIKE faah_t.faah005, 
   faah006 LIKE faah_t.faah006, 
   faah006_desc LIKE type_t.chr500, 
   faah007 LIKE faah_t.faah007, 
   faah007_desc LIKE type_t.chr500, 
   faah008 LIKE faah_t.faah008, 
   faah008_desc LIKE type_t.chr500, 
   faah009 LIKE faah_t.faah009, 
   faah009_desc LIKE type_t.chr500, 
   faah010 LIKE faah_t.faah010, 
   faah010_desc LIKE type_t.chr500, 
   faah011 LIKE faah_t.faah011, 
   faah011_desc LIKE type_t.chr500, 
   faah012 LIKE faah_t.faah012, 
   faah013 LIKE faah_t.faah013, 
   faah014 LIKE faah_t.faah014, 
   faah015 LIKE faah_t.faah015, 
   faah016 LIKE faah_t.faah016, 
   faah017 LIKE faah_t.faah017, 
   faah018 LIKE faah_t.faah018, 
   faah019 LIKE faah_t.faah019, 
   faah020 LIKE faah_t.faah020, 
   faah020_desc LIKE type_t.chr500, 
   faah021 LIKE faah_t.faah021, 
   faah022 LIKE faah_t.faah022, 
   faah023 LIKE faah_t.faah023, 
   faah024 LIKE faah_t.faah024, 
   faah025 LIKE faah_t.faah025, 
   faah025_desc LIKE type_t.chr500, 
   faah026 LIKE faah_t.faah026, 
   faah026_desc LIKE type_t.chr500, 
   faah027 LIKE faah_t.faah027, 
   faah027_desc LIKE type_t.chr500, 
   faah028 LIKE faah_t.faah028, 
   faah029 LIKE faah_t.faah029, 
   faah029_desc LIKE type_t.chr500, 
   faah030 LIKE faah_t.faah030, 
   faah030_desc LIKE type_t.chr500, 
   faah031 LIKE faah_t.faah031, 
   faah031_desc LIKE type_t.chr500, 
   faah032 LIKE faah_t.faah032, 
   faah032_desc LIKE type_t.chr500, 
   faah033 LIKE faah_t.faah033, 
   faah034 LIKE faah_t.faah034, 
   faah035 LIKE faah_t.faah035, 
   faah036 LIKE faah_t.faah036, 
   faah037 LIKE faah_t.faah037, 
   faah038 LIKE faah_t.faah038, 
   faah039 LIKE faah_t.faah039, 
   faah040 LIKE faah_t.faah040, 
   faah041 LIKE faah_t.faah041, 
   faah041_desc LIKE type_t.chr500, 
   faah042 LIKE faah_t.faah042, 
   faah043 LIKE faah_t.faah043, 
   faah044 LIKE faah_t.faah044, 
   faah045 LIKE faah_t.faah045
       END RECORD
PRIVATE TYPE type_g_faah2_d RECORD
       faah000 LIKE faah_t.faah000, 
   faah001 LIKE faah_t.faah001, 
   faah003 LIKE faah_t.faah003, 
   faah004 LIKE faah_t.faah004, 
   faahownid LIKE faah_t.faahownid, 
   faahownid_desc LIKE type_t.chr500, 
   faahowndp LIKE faah_t.faahowndp, 
   faahowndp_desc LIKE type_t.chr500, 
   faahcrtid LIKE faah_t.faahcrtid, 
   faahcrtid_desc LIKE type_t.chr500, 
   faahcrtdp LIKE faah_t.faahcrtdp, 
   faahcrtdp_desc LIKE type_t.chr500, 
   faahcrtdt DATETIME YEAR TO SECOND, 
   faahmodid LIKE faah_t.faahmodid, 
   faahmodid_desc LIKE type_t.chr500, 
   faahmoddt DATETIME YEAR TO SECOND
       END RECORD
PRIVATE TYPE type_g_faah3_d RECORD
       faaiseq LIKE faai_t.faaiseq, 
   faai004 LIKE faai_t.faai004, 
   faai005 LIKE faai_t.faai005, 
   faai006 LIKE faai_t.faai006, 
   faai007 LIKE faai_t.faai007, 
   faai008 LIKE faai_t.faai008, 
   faai009 LIKE faai_t.faai009, 
   faai010 LIKE faai_t.faai010, 
   faai011 LIKE faai_t.faai011, 
   faai012 LIKE faai_t.faai012, 
   faai013 LIKE faai_t.faai013, 
   faai014 LIKE faai_t.faai014, 
   faai015 LIKE faai_t.faai015, 
   faai016 LIKE faai_t.faai016, 
   faai017 LIKE faai_t.faai017, 
   faai018 LIKE faai_t.faai018, 
   faai019 LIKE faai_t.faai019, 
   faai020 LIKE faai_t.faai020, 
   faai021 LIKE faai_t.faai021, 
   faai022 LIKE faai_t.faai022, 
   faai023 LIKE faai_t.faai023
       END RECORD
PRIVATE TYPE type_g_faah4_d RECORD
       faajld LIKE faaj_t.faajld, 
   faajld_desc LIKE type_t.chr500, 
   faaj003 LIKE faaj_t.faaj003, 
   faaj004 LIKE faaj_t.faaj004, 
   faaj005 LIKE faaj_t.faaj005, 
   faaj006 LIKE faaj_t.faaj006, 
   faaj007 LIKE faaj_t.faaj007, 
   faaj008 LIKE faaj_t.faaj008, 
   faaj009 LIKE faaj_t.faaj009, 
   faaj010 LIKE faaj_t.faaj010, 
   faaj011 LIKE faaj_t.faaj011, 
   faaj012 LIKE faaj_t.faaj012, 
   faaj013 LIKE faaj_t.faaj013, 
   faaj014 LIKE faaj_t.faaj014, 
   faaj015 LIKE faaj_t.faaj015, 
   faaj016 LIKE faaj_t.faaj016, 
   faaj017 LIKE faaj_t.faaj017, 
   faaj018 LIKE faaj_t.faaj018, 
   faaj019 LIKE faaj_t.faaj019, 
   faaj020 LIKE faaj_t.faaj020, 
   faaj021 LIKE faaj_t.faaj021, 
   faaj022 LIKE faaj_t.faaj022, 
   faaj023 LIKE faaj_t.faaj023, 
   faaj024 LIKE faaj_t.faaj024, 
   faaj025 LIKE faaj_t.faaj025, 
   faaj026 LIKE faaj_t.faaj026, 
   faaj027 LIKE faaj_t.faaj027, 
   faaj028 LIKE faaj_t.faaj028, 
   faaj029 LIKE faaj_t.faaj029, 
   faaj030 LIKE faaj_t.faaj030, 
   faaj031 LIKE faaj_t.faaj031, 
   faaj032 LIKE faaj_t.faaj032, 
   faaj033 LIKE faaj_t.faaj033, 
   faaj034 LIKE faaj_t.faaj034, 
   faaj035 LIKE faaj_t.faaj035, 
   faaj036 LIKE faaj_t.faaj036, 
   faaj038 LIKE faaj_t.faaj038, 
   faaj039 LIKE faaj_t.faaj039, 
   faaj040 LIKE faaj_t.faaj040, 
   faaj041 LIKE faaj_t.faaj041, 
   faaj042 LIKE faaj_t.faaj042, 
   faaj043 LIKE faaj_t.faaj043, 
   faaj043_desc LIKE type_t.chr500, 
   faaj044 LIKE faaj_t.faaj044, 
   faaj045 LIKE faaj_t.faaj045, 
   faaj046 LIKE faaj_t.faaj046, 
   faaj047 LIKE faaj_t.faaj047, 
   faaj101 LIKE faaj_t.faaj101, 
   faaj102 LIKE faaj_t.faaj102, 
   faaj103 LIKE faaj_t.faaj103, 
   faaj104 LIKE faaj_t.faaj104, 
   faaj105 LIKE faaj_t.faaj105, 
   faaj106 LIKE faaj_t.faaj106, 
   faaj107 LIKE faaj_t.faaj107, 
   faaj108 LIKE faaj_t.faaj108, 
   faaj109 LIKE faaj_t.faaj109, 
   faaj110 LIKE faaj_t.faaj110, 
   faaj111 LIKE faaj_t.faaj111, 
   faaj112 LIKE faaj_t.faaj112, 
   faaj113 LIKE faaj_t.faaj113, 
   faaj114 LIKE faaj_t.faaj114, 
   faaj115 LIKE faaj_t.faaj115, 
   faaj116 LIKE faaj_t.faaj116, 
   faaj117 LIKE faaj_t.faaj117, 
   faaj151 LIKE faaj_t.faaj151, 
   faaj152 LIKE faaj_t.faaj152, 
   faaj153 LIKE faaj_t.faaj153, 
   faaj154 LIKE faaj_t.faaj154, 
   faaj155 LIKE faaj_t.faaj155, 
   faaj156 LIKE faaj_t.faaj156, 
   faaj157 LIKE faaj_t.faaj157, 
   faaj158 LIKE faaj_t.faaj158, 
   faaj159 LIKE faaj_t.faaj159, 
   faaj160 LIKE faaj_t.faaj160, 
   faaj161 LIKE faaj_t.faaj161, 
   faaj162 LIKE faaj_t.faaj162, 
   faaj163 LIKE faaj_t.faaj163, 
   faaj164 LIKE faaj_t.faaj164, 
   faaj165 LIKE faaj_t.faaj165, 
   faaj166 LIKE faaj_t.faaj166, 
   faaj167 LIKE faaj_t.faaj167, 
   faajsite LIKE faaj_t.faajsite
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_g_faah_f        RECORD
        faah032 LIKE faah_t.faah032, 
        format LIKE type_t.chr80, 
        char LIKE type_t.chr80, 
        dir LIKE type_t.chr80,
        inf LIKE type_t.chr5
        
       END RECORD
DEFINE g_faah_f        type_g_faah_f
DEFINE g_faah_f_t      type_g_faah_f

 type type_g_faah_m        RECORD
      faah032       LIKE faah_t.faah032,
      faah032_1_desc  LIKE TYPE_t.chr80
       END RECORD
DEFINE g_faah_m          type_g_faah_m

TYPE   type_g_faah_s        RECORD
       name LIKE type_t.chr80, 
       dir LIKE type_t.chr80,
       inf LIKE type_t.chr80
      
                            END RECORD
DEFINE g_faah_s        type_g_faah_s

DEFINE w        ui.Window
DEFINE f        ui.Form
DEFINE page     om.DomNode

DEFINE  g_hidden        DYNAMIC ARRAY OF LIKE type_t.chr1,
        g_ifchar        DYNAMIC ARRAY OF LIKE type_t.chr1,
        g_mask          DYNAMIC ARRAY OF LIKE type_t.chr1,
        g_quote         STRING
DEFINE xls_name        STRING 
DEFINE  l_channel       base.Channel,
        l_str           STRING,
        l_cmd           STRING,
        l_field_name    STRING,
        cnt_table       LIKE type_t.num10
DEFINE  g_sheet         STRING 
DEFINE  ms_codeset      STRING
DEFINE  ms_locale       STRING
DEFINE  tsconv_cmd      STRING
DEFINE  l_win_name      STRING,              
        cnt_header      LIKE type_t.num10
DEFINE  g_sort          RECORD
         column         LIKE type_t.num5,    #sortColumn
         type           STRING,                 #sortType:排序方式:asc/desc
         name           STRING                  #欄位代號
                        END RECORD
DEFINE g_bufstr         base.StringBuffer  
DEFINE g_para_data        LIKE type_t.chr80     #采用成本域否
DEFINE g_today          DATETIME YEAR TO SECOND
DEFINE g_inf            LIKE type_t.chr5
DEFINE g_ooef017        LIKE ooef_t.ooef017  #161111-00049#12  
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_faah_d
DEFINE g_master_t                   type_g_faah_d
DEFINE g_faah_d          DYNAMIC ARRAY OF type_g_faah_d
DEFINE g_faah_d_t        type_g_faah_d
DEFINE g_faah_d_o        type_g_faah_d
DEFINE g_faah_d_mask_o   DYNAMIC ARRAY OF type_g_faah_d #轉換遮罩前資料
DEFINE g_faah_d_mask_n   DYNAMIC ARRAY OF type_g_faah_d #轉換遮罩後資料
DEFINE g_faah2_d          DYNAMIC ARRAY OF type_g_faah2_d
DEFINE g_faah2_d_t        type_g_faah2_d
DEFINE g_faah2_d_o        type_g_faah2_d
DEFINE g_faah2_d_mask_o   DYNAMIC ARRAY OF type_g_faah2_d #轉換遮罩前資料
DEFINE g_faah2_d_mask_n   DYNAMIC ARRAY OF type_g_faah2_d #轉換遮罩後資料
DEFINE g_faah3_d          DYNAMIC ARRAY OF type_g_faah3_d
DEFINE g_faah3_d_t        type_g_faah3_d
DEFINE g_faah3_d_o        type_g_faah3_d
DEFINE g_faah3_d_mask_o   DYNAMIC ARRAY OF type_g_faah3_d #轉換遮罩前資料
DEFINE g_faah3_d_mask_n   DYNAMIC ARRAY OF type_g_faah3_d #轉換遮罩後資料
DEFINE g_faah4_d          DYNAMIC ARRAY OF type_g_faah4_d
DEFINE g_faah4_d_t        type_g_faah4_d
DEFINE g_faah4_d_o        type_g_faah4_d
DEFINE g_faah4_d_mask_o   DYNAMIC ARRAY OF type_g_faah4_d #轉換遮罩前資料
DEFINE g_faah4_d_mask_n   DYNAMIC ARRAY OF type_g_faah4_d #轉換遮罩後資料
 
      
DEFINE g_wc                 STRING
DEFINE g_wc2                STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10             
DEFINE g_ac_last            LIKE type_t.num10             
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_detail_idx         LIKE type_t.num10             #單身所在筆數(第一階單身)
DEFINE g_detail_idx2        LIKE type_t.num10             #單身所在筆數(第二階單身)
DEFINE g_detail_cnt         LIKE type_t.num10             #單身總筆數 (第一階單身)
DEFINE g_detail_cnt2        LIKE type_t.num10             #單身總筆數 (第二階單身)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_aw                 STRING                        #確定當下點擊的單身
DEFINE g_current_page       LIKE type_t.num10             #判斷單身筆數用
DEFINE g_loc                LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_log1               STRING                        #log用
DEFINE g_log2               STRING                        #log用
 
#多table用wc
DEFINE g_wc_table           STRING
 
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
 
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="afat300.main" >}
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
   CALL cl_ap_init("afa","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
 
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afat300 WITH FORM cl_ap_formpath("afa",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afat300_init()   
 
      #進入選單 Menu (="N")
      CALL afat300_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afat300
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afat300.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION afat300_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_error_show  = 1
   
      CALL cl_set_combo_scc('faah002','9911') 
   CALL cl_set_combo_scc('faah005','9903') 
   CALL cl_set_combo_scc('faah015','9914') 
   CALL cl_set_combo_scc('faah016','9913') 
   CALL cl_set_combo_scc('faah035','9906') 
   CALL cl_set_combo_scc('faah036','9907') 
   CALL cl_set_combo_scc('faah037','9908') 
   CALL cl_set_combo_scc('faah042','9917') 
   CALL cl_set_combo_scc('faaj003','9904') 
   CALL cl_set_combo_scc('faaj006','9912') 
 
   LET l_ac = 1
   
 
 
   
 
 
   
 
   
 
 
   #避免USER直接進入第二單身時無資料
   IF g_faah_d.getLength() > 0 THEN
      LET g_master_t.* = g_faah_d[1].*
      LET g_master.* = g_faah_d[1].*
   END IF
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_comp_entry("insert",FALSE)
   CALL cl_set_combo_scc('faah002','9911') 
   CALL cl_set_combo_scc('faah005','9903')
   CALL cl_set_combo_scc('faah015','9914') 
   CALL cl_set_combo_scc('faah016','9913') 
   CALL cl_set_combo_scc('faah042','9917') 
   CALL cl_set_combo_scc('faah034','9905')
   CALL cl_set_combo_scc('faah035','9906')
   CALL cl_set_combo_scc('faah036','9907')
   CALL cl_set_combo_scc('faah037','9908')
   CALL cl_set_combo_scc('faaj006','9912') 
   CALL cl_set_combo_scc('faaj003','9904') 
   CALL cl_set_combo_scc('faai023','9914')
   CALL cl_set_combo_scc('faaj038','9914')
   #end add-point
   
   CALL afat300_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="afat300.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION afat300_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE la_param  RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE li_idx   LIKE type_t.num10
   DEFINE l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_success       LIKE type_t.num5
   #end add-point 
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm() 
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_faah_d.clear()
         CALL g_faah2_d.clear()
         CALL g_faah3_d.clear()
         CALL g_faah4_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL afat300_init()
      END IF
   
      #add-point:ui_dialog段before while name="ui_dialog.before_while"
      
      #end add-point
   
      CALL afat300_b_fill(g_wc)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_faah_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET g_current_page = 1
      
            BEFORE ROW
               LET g_curr_diag = ui.DIALOG.getCurrent()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               LET g_master.* = g_faah_d[g_detail_idx].*
               CALL cl_show_fld_cont()
               LET g_action_choice = "fetch"
               CALL afat300_fetch()
               CALL afat300_idx_chk('m')
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL afat300_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_faah2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET g_current_page = 2
               
            BEFORE ROW
               LET g_curr_diag = ui.DIALOG.getCurrent()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               LET g_master.* = g_faah_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               LET g_action_choice = "fetch"
               CALL afat300_fetch()
               CALL afat300_idx_chk('m')
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL afat300_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               
            #自訂ACTION(detail_show,page_2)
            
               
         END DISPLAY
 
         
         DISPLAY ARRAY g_faah3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx2)
               END IF
               LET g_loc = 'd'
               LET g_current_page = 3
         
            BEFORE ROW
               LET g_curr_diag = ui.DIALOG.getCurrent()
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               CALL afat300_idx_chk('d')
               LET g_master.* = g_faah_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               
            #自訂ACTION(detail_show,page_3)
            
               
         END DISPLAY
         DISPLAY ARRAY g_faah4_d TO s_detail4.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx2)
               END IF
               LET g_loc = 'd'
               LET g_current_page = 4
         
            BEFORE ROW
               LET g_curr_diag = ui.DIALOG.getCurrent()
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx2
               CALL afat300_idx_chk('d')
               LET g_master.* = g_faah_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               
            #自訂ACTION(detail_show,page_4)
            
               
         END DISPLAY
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
    
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            IF g_detail_idx > 0 THEN
               IF g_detail_idx > g_faah_d.getLength() THEN
                  LET g_detail_idx = g_faah_d.getLength()
               END IF
               CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)
               LET l_ac = g_detail_idx
            END IF 
            LET g_detail_idx = l_ac
            #add-point:ui_dialog段before name="ui_dialog.b_dialog"
            
            #end add-point  
            NEXT FIELD CURRENT
        
         AFTER DIALOG
            #add-point:ui_dialog段after dialog name="ui_dialog.after_dialog"
            
            #end add-point
         
      ON ACTION exporttoexcel
         LET g_action_choice="exporttoexcel"
         IF cl_auth_chk_act("exporttoexcel") THEN
            CALL g_export_node.clear()
            LET g_export_node[1] = base.typeInfo.create(g_faah_d)
            LET g_export_id[1]   = "s_detail1"
            LET g_export_node[2] = base.typeInfo.create(g_faah2_d)
            LET g_export_id[2]   = "s_detail2"
            LET g_export_node[3] = base.typeInfo.create(g_faah3_d)
            LET g_export_id[3]   = "s_detail3"
            LET g_export_node[4] = base.typeInfo.create(g_faah4_d)
            LET g_export_id[4]   = "s_detail4"
 
            #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
            
            #END add-point
            CALL cl_export_to_excel_getpage()
            CALL cl_export_to_excel()
         END IF
         
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL afat300_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL afat300_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afat300_s02
            LET g_action_choice="open_afat300_s02"
            IF cl_auth_chk_act("open_afat300_s02") THEN
               
               #add-point:ON ACTION open_afat300_s02 name="menu.open_afat300_s02"
               CALL afat300_s02() RETURNING l_success
               IF l_success = TRUE THEN
                  CALL s_transaction_end('Y','1')
                  ERROR "INSERT O.K"
               ELSE
                  CALL s_transaction_end('N','1')
               END IF

               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/afa/afat300_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/afa/afat300_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afat300_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afat300_s01
            LET g_action_choice="open_afat300_s01"
            IF cl_auth_chk_act("open_afat300_s01") THEN
               
               #add-point:ON ACTION open_afat300_s01 name="menu.open_afat300_s01"
               CALL afat300_s01() RETURNING l_success
               IF l_success = TRUE THEN
                  CALL s_transaction_end('Y','1')
                  ERROR "INSERT O.K"
               ELSE
                  CALL s_transaction_end('N','1')
               END IF
               #CALL afat300_show()
               #END add-point
               
            END IF
 
 
 
 
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice="exit"
            CANCEL DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            CANCEL DIALOG
           
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL afat300_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afat300_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afat300_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="afat300.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION afat300_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   CALL afat300_query_1()
   RETURN
   #end add-point 
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_faah_d.clear()
   CALL g_faah2_d.clear()
   CALL g_faah3_d.clear()
   CALL g_faah4_d.clear()
 
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc
   LET g_detail_idx = l_ac
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON faah000,faah001,faah003,faah004,faah002,faah005,faah006,faah007,faah008, 
          faah009,faah010,faah011,faah012,faah013,faah014,faah015,faah016,faah017,faah018,faah019,faah020, 
          faah021,faah022,faah023,faah024,faah025,faah026,faah027,faah028,faah029,faah030,faah031,faah032, 
          faah033,faah034,faah035,faah036,faah037,faah038,faah039,faah040,faah041,faah042,faah043,faah044, 
          faah045,faahownid,faahowndp,faahcrtid,faahcrtdp,faahcrtdt,faahmodid,faahmoddt
           FROM s_detail1[1].faah000,s_detail1[1].faah001,s_detail1[1].faah003,s_detail1[1].faah004, 
               s_detail1[1].faah002,s_detail1[1].faah005,s_detail1[1].faah006,s_detail1[1].faah007,s_detail1[1].faah008, 
               s_detail1[1].faah009,s_detail1[1].faah010,s_detail1[1].faah011,s_detail1[1].faah012,s_detail1[1].faah013, 
               s_detail1[1].faah014,s_detail1[1].faah015,s_detail1[1].faah016,s_detail1[1].faah017,s_detail1[1].faah018, 
               s_detail1[1].faah019,s_detail1[1].faah020,s_detail1[1].faah021,s_detail1[1].faah022,s_detail1[1].faah023, 
               s_detail1[1].faah024,s_detail1[1].faah025,s_detail1[1].faah026,s_detail1[1].faah027,s_detail1[1].faah028, 
               s_detail1[1].faah029,s_detail1[1].faah030,s_detail1[1].faah031,s_detail1[1].faah032,s_detail1[1].faah033, 
               s_detail1[1].faah034,s_detail1[1].faah035,s_detail1[1].faah036,s_detail1[1].faah037,s_detail1[1].faah038, 
               s_detail1[1].faah039,s_detail1[1].faah040,s_detail1[1].faah041,s_detail1[1].faah042,s_detail1[1].faah043, 
               s_detail1[1].faah044,s_detail1[1].faah045,s_detail2[1].faahownid,s_detail2[1].faahowndp, 
               s_detail2[1].faahcrtid,s_detail2[1].faahcrtdp,s_detail2[1].faahcrtdt,s_detail2[1].faahmodid, 
               s_detail2[1].faahmoddt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<faahcrtdt>>----
         AFTER FIELD faahcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<faahmoddt>>----
         AFTER FIELD faahmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<faahcnfdt>>----
         
         #----<<faahpstdt>>----
 
 
 
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah000
            #add-point:BEFORE FIELD faah000 name="construct.b.page1.faah000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah000
            
            #add-point:AFTER FIELD faah000 name="construct.a.page1.faah000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah000
            #add-point:ON ACTION controlp INFIELD faah000 name="construct.c.page1.faah000"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.faah001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah001
            #add-point:ON ACTION controlp INFIELD faah001 name="construct.c.page1.faah001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_faah001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah001  #顯示到畫面上
            NEXT FIELD faah001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah001
            #add-point:BEFORE FIELD faah001 name="construct.b.page1.faah001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah001
            
            #add-point:AFTER FIELD faah001 name="construct.a.page1.faah001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah003
            #add-point:ON ACTION controlp INFIELD faah003 name="construct.c.page1.faah003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_faah003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah003  #顯示到畫面上
            NEXT FIELD faah003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah003
            #add-point:BEFORE FIELD faah003 name="construct.b.page1.faah003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah003
            
            #add-point:AFTER FIELD faah003 name="construct.a.page1.faah003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah004
            #add-point:ON ACTION controlp INFIELD faah004 name="construct.c.page1.faah004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_faah004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah004  #顯示到畫面上
            NEXT FIELD faah004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah004
            #add-point:BEFORE FIELD faah004 name="construct.b.page1.faah004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah004
            
            #add-point:AFTER FIELD faah004 name="construct.a.page1.faah004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah002
            #add-point:BEFORE FIELD faah002 name="construct.b.page1.faah002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah002
            
            #add-point:AFTER FIELD faah002 name="construct.a.page1.faah002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah002
            #add-point:ON ACTION controlp INFIELD faah002 name="construct.c.page1.faah002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah005
            #add-point:BEFORE FIELD faah005 name="construct.b.page1.faah005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah005
            
            #add-point:AFTER FIELD faah005 name="construct.a.page1.faah005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah005
            #add-point:ON ACTION controlp INFIELD faah005 name="construct.c.page1.faah005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.faah006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah006
            #add-point:ON ACTION controlp INFIELD faah006 name="construct.c.page1.faah006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_faac001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah006  #顯示到畫面上
            NEXT FIELD faah006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah006
            #add-point:BEFORE FIELD faah006 name="construct.b.page1.faah006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah006
            
            #add-point:AFTER FIELD faah006 name="construct.a.page1.faah006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah007
            #add-point:ON ACTION controlp INFIELD faah007 name="construct.c.page1.faah007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_faad001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah007  #顯示到畫面上
            NEXT FIELD faah007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah007
            #add-point:BEFORE FIELD faah007 name="construct.b.page1.faah007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah007
            
            #add-point:AFTER FIELD faah007 name="construct.a.page1.faah007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah008
            #add-point:ON ACTION controlp INFIELD faah008 name="construct.c.page1.faah008"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah008  #顯示到畫面上
            NEXT FIELD faah008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah008
            #add-point:BEFORE FIELD faah008 name="construct.b.page1.faah008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah008
            
            #add-point:AFTER FIELD faah008 name="construct.a.page1.faah008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah009
            #add-point:ON ACTION controlp INFIELD faah009 name="construct.c.page1.faah009"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah009  #顯示到畫面上
            NEXT FIELD faah009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah009
            #add-point:BEFORE FIELD faah009 name="construct.b.page1.faah009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah009
            
            #add-point:AFTER FIELD faah009 name="construct.a.page1.faah009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah010
            #add-point:ON ACTION controlp INFIELD faah010 name="construct.c.page1.faah010"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah010  #顯示到畫面上
            NEXT FIELD faah010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah010
            #add-point:BEFORE FIELD faah010 name="construct.b.page1.faah010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah010
            
            #add-point:AFTER FIELD faah010 name="construct.a.page1.faah010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah011
            #add-point:ON ACTION controlp INFIELD faah011 name="construct.c.page1.faah011"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooce001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah011  #顯示到畫面上
            NEXT FIELD faah011                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah011
            #add-point:BEFORE FIELD faah011 name="construct.b.page1.faah011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah011
            
            #add-point:AFTER FIELD faah011 name="construct.a.page1.faah011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah012
            #add-point:BEFORE FIELD faah012 name="construct.b.page1.faah012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah012
            
            #add-point:AFTER FIELD faah012 name="construct.a.page1.faah012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah012
            #add-point:ON ACTION controlp INFIELD faah012 name="construct.c.page1.faah012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah013
            #add-point:BEFORE FIELD faah013 name="construct.b.page1.faah013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah013
            
            #add-point:AFTER FIELD faah013 name="construct.a.page1.faah013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah013
            #add-point:ON ACTION controlp INFIELD faah013 name="construct.c.page1.faah013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah014
            #add-point:BEFORE FIELD faah014 name="construct.b.page1.faah014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah014
            
            #add-point:AFTER FIELD faah014 name="construct.a.page1.faah014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah014
            #add-point:ON ACTION controlp INFIELD faah014 name="construct.c.page1.faah014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah015
            #add-point:BEFORE FIELD faah015 name="construct.b.page1.faah015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah015
            
            #add-point:AFTER FIELD faah015 name="construct.a.page1.faah015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah015
            #add-point:ON ACTION controlp INFIELD faah015 name="construct.c.page1.faah015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah016
            #add-point:BEFORE FIELD faah016 name="construct.b.page1.faah016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah016
            
            #add-point:AFTER FIELD faah016 name="construct.a.page1.faah016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah016
            #add-point:ON ACTION controlp INFIELD faah016 name="construct.c.page1.faah016"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.faah017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah017
            #add-point:ON ACTION controlp INFIELD faah017 name="construct.c.page1.faah017"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah017  #顯示到畫面上
            NEXT FIELD faah017                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah017
            #add-point:BEFORE FIELD faah017 name="construct.b.page1.faah017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah017
            
            #add-point:AFTER FIELD faah017 name="construct.a.page1.faah017"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah018
            #add-point:BEFORE FIELD faah018 name="construct.b.page1.faah018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah018
            
            #add-point:AFTER FIELD faah018 name="construct.a.page1.faah018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah018
            #add-point:ON ACTION controlp INFIELD faah018 name="construct.c.page1.faah018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah019
            #add-point:BEFORE FIELD faah019 name="construct.b.page1.faah019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah019
            
            #add-point:AFTER FIELD faah019 name="construct.a.page1.faah019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah019
            #add-point:ON ACTION controlp INFIELD faah019 name="construct.c.page1.faah019"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.faah020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah020
            #add-point:ON ACTION controlp INFIELD faah020 name="construct.c.page1.faah020"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah020  #顯示到畫面上
            NEXT FIELD faah020                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah020
            #add-point:BEFORE FIELD faah020 name="construct.b.page1.faah020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah020
            
            #add-point:AFTER FIELD faah020 name="construct.a.page1.faah020"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah021
            #add-point:BEFORE FIELD faah021 name="construct.b.page1.faah021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah021
            
            #add-point:AFTER FIELD faah021 name="construct.a.page1.faah021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah021
            #add-point:ON ACTION controlp INFIELD faah021 name="construct.c.page1.faah021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah022
            #add-point:BEFORE FIELD faah022 name="construct.b.page1.faah022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah022
            
            #add-point:AFTER FIELD faah022 name="construct.a.page1.faah022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah022
            #add-point:ON ACTION controlp INFIELD faah022 name="construct.c.page1.faah022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah023
            #add-point:BEFORE FIELD faah023 name="construct.b.page1.faah023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah023
            
            #add-point:AFTER FIELD faah023 name="construct.a.page1.faah023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah023
            #add-point:ON ACTION controlp INFIELD faah023 name="construct.c.page1.faah023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah024
            #add-point:BEFORE FIELD faah024 name="construct.b.page1.faah024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah024
            
            #add-point:AFTER FIELD faah024 name="construct.a.page1.faah024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah024
            #add-point:ON ACTION controlp INFIELD faah024 name="construct.c.page1.faah024"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.faah025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah025
            #add-point:ON ACTION controlp INFIELD faah025 name="construct.c.page1.faah025"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah025  #顯示到畫面上
            NEXT FIELD faah025                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah025
            #add-point:BEFORE FIELD faah025 name="construct.b.page1.faah025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah025
            
            #add-point:AFTER FIELD faah025 name="construct.a.page1.faah025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah026
            #add-point:ON ACTION controlp INFIELD faah026 name="construct.c.page1.faah026"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah026  #顯示到畫面上
            NEXT FIELD faah026                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah026
            #add-point:BEFORE FIELD faah026 name="construct.b.page1.faah026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah026
            
            #add-point:AFTER FIELD faah026 name="construct.a.page1.faah026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah027
            #add-point:ON ACTION controlp INFIELD faah027 name="construct.c.page1.faah027"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah027  #顯示到畫面上
            NEXT FIELD faah027                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah027
            #add-point:BEFORE FIELD faah027 name="construct.b.page1.faah027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah027
            
            #add-point:AFTER FIELD faah027 name="construct.a.page1.faah027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah028
            #add-point:ON ACTION controlp INFIELD faah028 name="construct.c.page1.faah028"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah028  #顯示到畫面上
            NEXT FIELD faah028                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah028
            #add-point:BEFORE FIELD faah028 name="construct.b.page1.faah028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah028
            
            #add-point:AFTER FIELD faah028 name="construct.a.page1.faah028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah029
            #add-point:ON ACTION controlp INFIELD faah029 name="construct.c.page1.faah029"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah029  #顯示到畫面上
            NEXT FIELD faah029                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah029
            #add-point:BEFORE FIELD faah029 name="construct.b.page1.faah029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah029
            
            #add-point:AFTER FIELD faah029 name="construct.a.page1.faah029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah030
            #add-point:ON ACTION controlp INFIELD faah030 name="construct.c.page1.faah030"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah030  #顯示到畫面上
            NEXT FIELD faah030                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah030
            #add-point:BEFORE FIELD faah030 name="construct.b.page1.faah030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah030
            
            #add-point:AFTER FIELD faah030 name="construct.a.page1.faah030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah031
            #add-point:ON ACTION controlp INFIELD faah031 name="construct.c.page1.faah031"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef204 = 'Y' "   #161024-00008#2
            CALL q_ooef001()                           #呼叫開窗 
            DISPLAY g_qryparam.return1 TO faah031  #顯示到畫面上
            NEXT FIELD faah031                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah031
            #add-point:BEFORE FIELD faah031 name="construct.b.page1.faah031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah031
            
            #add-point:AFTER FIELD faah031 name="construct.a.page1.faah031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah032
            #add-point:ON ACTION controlp INFIELD faah032 name="construct.c.page1.faah032"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                           #呼叫開窗 #161024-00008#2 
            CALL q_ooef001_2()                                   #161024-00008#2 
            DISPLAY g_qryparam.return1 TO faah032  #顯示到畫面上
            NEXT FIELD faah032                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah032
            #add-point:BEFORE FIELD faah032 name="construct.b.page1.faah032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah032
            
            #add-point:AFTER FIELD faah032 name="construct.a.page1.faah032"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah033
            #add-point:BEFORE FIELD faah033 name="construct.b.page1.faah033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah033
            
            #add-point:AFTER FIELD faah033 name="construct.a.page1.faah033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah033
            #add-point:ON ACTION controlp INFIELD faah033 name="construct.c.page1.faah033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah034
            #add-point:BEFORE FIELD faah034 name="construct.b.page1.faah034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah034
            
            #add-point:AFTER FIELD faah034 name="construct.a.page1.faah034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah034
            #add-point:ON ACTION controlp INFIELD faah034 name="construct.c.page1.faah034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah035
            #add-point:BEFORE FIELD faah035 name="construct.b.page1.faah035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah035
            
            #add-point:AFTER FIELD faah035 name="construct.a.page1.faah035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah035
            #add-point:ON ACTION controlp INFIELD faah035 name="construct.c.page1.faah035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah036
            #add-point:BEFORE FIELD faah036 name="construct.b.page1.faah036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah036
            
            #add-point:AFTER FIELD faah036 name="construct.a.page1.faah036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah036
            #add-point:ON ACTION controlp INFIELD faah036 name="construct.c.page1.faah036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah037
            #add-point:BEFORE FIELD faah037 name="construct.b.page1.faah037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah037
            
            #add-point:AFTER FIELD faah037 name="construct.a.page1.faah037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah037
            #add-point:ON ACTION controlp INFIELD faah037 name="construct.c.page1.faah037"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.faah038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah038
            #add-point:ON ACTION controlp INFIELD faah038 name="construct.c.page1.faah038"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmdldocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah038  #顯示到畫面上
            NEXT FIELD faah038                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah038
            #add-point:BEFORE FIELD faah038 name="construct.b.page1.faah038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah038
            
            #add-point:AFTER FIELD faah038 name="construct.a.page1.faah038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah039
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah039
            #add-point:ON ACTION controlp INFIELD faah039 name="construct.c.page1.faah039"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmdsdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah039  #顯示到畫面上
            NEXT FIELD faah039                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah039
            #add-point:BEFORE FIELD faah039 name="construct.b.page1.faah039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah039
            
            #add-point:AFTER FIELD faah039 name="construct.a.page1.faah039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah040
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah040
            #add-point:ON ACTION controlp INFIELD faah040 name="construct.c.page1.faah040"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_apcadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah040  #顯示到畫面上
            NEXT FIELD faah040                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah040
            #add-point:BEFORE FIELD faah040 name="construct.b.page1.faah040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah040
            
            #add-point:AFTER FIELD faah040 name="construct.a.page1.faah040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah041
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah041
            #add-point:ON ACTION controlp INFIELD faah041 name="construct.c.page1.faah041"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah041  #顯示到畫面上
            NEXT FIELD faah041                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah041
            #add-point:BEFORE FIELD faah041 name="construct.b.page1.faah041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah041
            
            #add-point:AFTER FIELD faah041 name="construct.a.page1.faah041"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah042
            #add-point:BEFORE FIELD faah042 name="construct.b.page1.faah042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah042
            
            #add-point:AFTER FIELD faah042 name="construct.a.page1.faah042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah042
            #add-point:ON ACTION controlp INFIELD faah042 name="construct.c.page1.faah042"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah043
            #add-point:BEFORE FIELD faah043 name="construct.b.page1.faah043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah043
            
            #add-point:AFTER FIELD faah043 name="construct.a.page1.faah043"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah043
            #add-point:ON ACTION controlp INFIELD faah043 name="construct.c.page1.faah043"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah044
            #add-point:BEFORE FIELD faah044 name="construct.b.page1.faah044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah044
            
            #add-point:AFTER FIELD faah044 name="construct.a.page1.faah044"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah044
            #add-point:ON ACTION controlp INFIELD faah044 name="construct.c.page1.faah044"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah045
            #add-point:BEFORE FIELD faah045 name="construct.b.page1.faah045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah045
            
            #add-point:AFTER FIELD faah045 name="construct.a.page1.faah045"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah045
            #add-point:ON ACTION controlp INFIELD faah045 name="construct.c.page1.faah045"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.faahownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faahownid
            #add-point:ON ACTION controlp INFIELD faahownid name="construct.c.page2.faahownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faahownid  #顯示到畫面上
            NEXT FIELD faahownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faahownid
            #add-point:BEFORE FIELD faahownid name="construct.b.page2.faahownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faahownid
            
            #add-point:AFTER FIELD faahownid name="construct.a.page2.faahownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faahowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faahowndp
            #add-point:ON ACTION controlp INFIELD faahowndp name="construct.c.page2.faahowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faahowndp  #顯示到畫面上
            NEXT FIELD faahowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faahowndp
            #add-point:BEFORE FIELD faahowndp name="construct.b.page2.faahowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faahowndp
            
            #add-point:AFTER FIELD faahowndp name="construct.a.page2.faahowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faahcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faahcrtid
            #add-point:ON ACTION controlp INFIELD faahcrtid name="construct.c.page2.faahcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faahcrtid  #顯示到畫面上
            NEXT FIELD faahcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faahcrtid
            #add-point:BEFORE FIELD faahcrtid name="construct.b.page2.faahcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faahcrtid
            
            #add-point:AFTER FIELD faahcrtid name="construct.a.page2.faahcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faahcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faahcrtdp
            #add-point:ON ACTION controlp INFIELD faahcrtdp name="construct.c.page2.faahcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faahcrtdp  #顯示到畫面上
            NEXT FIELD faahcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faahcrtdp
            #add-point:BEFORE FIELD faahcrtdp name="construct.b.page2.faahcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faahcrtdp
            
            #add-point:AFTER FIELD faahcrtdp name="construct.a.page2.faahcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faahcrtdt
            #add-point:BEFORE FIELD faahcrtdt name="construct.b.page2.faahcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.faahmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faahmodid
            #add-point:ON ACTION controlp INFIELD faahmodid name="construct.c.page2.faahmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faahmodid  #顯示到畫面上
            NEXT FIELD faahmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faahmodid
            #add-point:BEFORE FIELD faahmodid name="construct.b.page2.faahmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faahmodid
            
            #add-point:AFTER FIELD faahmodid name="construct.a.page2.faahmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faahmoddt
            #add-point:BEFORE FIELD faahmoddt name="construct.b.page2.faahmoddt"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON faaiseq,faai004,faai005,faai006,faai007,faai008,faai009,faai010,faai011, 
          faai012,faai013,faai014,faai015,faai016,faai017,faai018,faai019,faai020,faai021,faai022,faai023 
 
           FROM s_detail3[1].faaiseq,s_detail3[1].faai004,s_detail3[1].faai005,s_detail3[1].faai006, 
               s_detail3[1].faai007,s_detail3[1].faai008,s_detail3[1].faai009,s_detail3[1].faai010,s_detail3[1].faai011, 
               s_detail3[1].faai012,s_detail3[1].faai013,s_detail3[1].faai014,s_detail3[1].faai015,s_detail3[1].faai016, 
               s_detail3[1].faai017,s_detail3[1].faai018,s_detail3[1].faai019,s_detail3[1].faai020,s_detail3[1].faai021, 
               s_detail3[1].faai022,s_detail3[1].faai023
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaiseq
            #add-point:BEFORE FIELD faaiseq name="construct.b.page3.faaiseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaiseq
            
            #add-point:AFTER FIELD faaiseq name="construct.a.page3.faaiseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.faaiseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaiseq
            #add-point:ON ACTION controlp INFIELD faaiseq name="construct.c.page3.faaiseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai004
            #add-point:BEFORE FIELD faai004 name="construct.b.page3.faai004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai004
            
            #add-point:AFTER FIELD faai004 name="construct.a.page3.faai004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.faai004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai004
            #add-point:ON ACTION controlp INFIELD faai004 name="construct.c.page3.faai004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai005
            #add-point:BEFORE FIELD faai005 name="construct.b.page3.faai005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai005
            
            #add-point:AFTER FIELD faai005 name="construct.a.page3.faai005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.faai005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai005
            #add-point:ON ACTION controlp INFIELD faai005 name="construct.c.page3.faai005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai006
            #add-point:BEFORE FIELD faai006 name="construct.b.page3.faai006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai006
            
            #add-point:AFTER FIELD faai006 name="construct.a.page3.faai006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.faai006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai006
            #add-point:ON ACTION controlp INFIELD faai006 name="construct.c.page3.faai006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai007
            #add-point:BEFORE FIELD faai007 name="construct.b.page3.faai007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai007
            
            #add-point:AFTER FIELD faai007 name="construct.a.page3.faai007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.faai007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai007
            #add-point:ON ACTION controlp INFIELD faai007 name="construct.c.page3.faai007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai008
            #add-point:BEFORE FIELD faai008 name="construct.b.page3.faai008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai008
            
            #add-point:AFTER FIELD faai008 name="construct.a.page3.faai008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.faai008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai008
            #add-point:ON ACTION controlp INFIELD faai008 name="construct.c.page3.faai008"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.faai009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai009
            #add-point:ON ACTION controlp INFIELD faai009 name="construct.c.page3.faai009"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faai009  #顯示到畫面上
            NEXT FIELD faai009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai009
            #add-point:BEFORE FIELD faai009 name="construct.b.page3.faai009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai009
            
            #add-point:AFTER FIELD faai009 name="construct.a.page3.faai009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.faai010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai010
            #add-point:ON ACTION controlp INFIELD faai010 name="construct.c.page3.faai010"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faai010  #顯示到畫面上
            NEXT FIELD faai010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai010
            #add-point:BEFORE FIELD faai010 name="construct.b.page3.faai010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai010
            
            #add-point:AFTER FIELD faai010 name="construct.a.page3.faai010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai011
            #add-point:BEFORE FIELD faai011 name="construct.b.page3.faai011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai011
            
            #add-point:AFTER FIELD faai011 name="construct.a.page3.faai011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.faai011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai011
            #add-point:ON ACTION controlp INFIELD faai011 name="construct.c.page3.faai011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai012
            #add-point:BEFORE FIELD faai012 name="construct.b.page3.faai012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai012
            
            #add-point:AFTER FIELD faai012 name="construct.a.page3.faai012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.faai012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai012
            #add-point:ON ACTION controlp INFIELD faai012 name="construct.c.page3.faai012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai013
            #add-point:BEFORE FIELD faai013 name="construct.b.page3.faai013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai013
            
            #add-point:AFTER FIELD faai013 name="construct.a.page3.faai013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.faai013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai013
            #add-point:ON ACTION controlp INFIELD faai013 name="construct.c.page3.faai013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai014
            #add-point:BEFORE FIELD faai014 name="construct.b.page3.faai014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai014
            
            #add-point:AFTER FIELD faai014 name="construct.a.page3.faai014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.faai014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai014
            #add-point:ON ACTION controlp INFIELD faai014 name="construct.c.page3.faai014"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.faai015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai015
            #add-point:ON ACTION controlp INFIELD faai015 name="construct.c.page3.faai015"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faai015  #顯示到畫面上
            NEXT FIELD faai015                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai015
            #add-point:BEFORE FIELD faai015 name="construct.b.page3.faai015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai015
            
            #add-point:AFTER FIELD faai015 name="construct.a.page3.faai015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.faai016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai016
            #add-point:ON ACTION controlp INFIELD faai016 name="construct.c.page3.faai016"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faai016  #顯示到畫面上
            NEXT FIELD faai016                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai016
            #add-point:BEFORE FIELD faai016 name="construct.b.page3.faai016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai016
            
            #add-point:AFTER FIELD faai016 name="construct.a.page3.faai016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.faai017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai017
            #add-point:ON ACTION controlp INFIELD faai017 name="construct.c.page3.faai017"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faai017  #顯示到畫面上
            NEXT FIELD faai017                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai017
            #add-point:BEFORE FIELD faai017 name="construct.b.page3.faai017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai017
            
            #add-point:AFTER FIELD faai017 name="construct.a.page3.faai017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.faai018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai018
            #add-point:ON ACTION controlp INFIELD faai018 name="construct.c.page3.faai018"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faai018  #顯示到畫面上
            NEXT FIELD faai018                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai018
            #add-point:BEFORE FIELD faai018 name="construct.b.page3.faai018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai018
            
            #add-point:AFTER FIELD faai018 name="construct.a.page3.faai018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.faai019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai019
            #add-point:ON ACTION controlp INFIELD faai019 name="construct.c.page3.faai019"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faai019  #顯示到畫面上
            NEXT FIELD faai019                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai019
            #add-point:BEFORE FIELD faai019 name="construct.b.page3.faai019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai019
            
            #add-point:AFTER FIELD faai019 name="construct.a.page3.faai019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.faai020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai020
            #add-point:ON ACTION controlp INFIELD faai020 name="construct.c.page3.faai020"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faai020  #顯示到畫面上
            NEXT FIELD faai020                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai020
            #add-point:BEFORE FIELD faai020 name="construct.b.page3.faai020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai020
            
            #add-point:AFTER FIELD faai020 name="construct.a.page3.faai020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.faai021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai021
            #add-point:ON ACTION controlp INFIELD faai021 name="construct.c.page3.faai021"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faai021  #顯示到畫面上
            NEXT FIELD faai021                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai021
            #add-point:BEFORE FIELD faai021 name="construct.b.page3.faai021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai021
            
            #add-point:AFTER FIELD faai021 name="construct.a.page3.faai021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.faai022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai022
            #add-point:ON ACTION controlp INFIELD faai022 name="construct.c.page3.faai022"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faai022  #顯示到畫面上
            NEXT FIELD faai022                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai022
            #add-point:BEFORE FIELD faai022 name="construct.b.page3.faai022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai022
            
            #add-point:AFTER FIELD faai022 name="construct.a.page3.faai022"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai023
            #add-point:BEFORE FIELD faai023 name="construct.b.page3.faai023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai023
            
            #add-point:AFTER FIELD faai023 name="construct.a.page3.faai023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.faai023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai023
            #add-point:ON ACTION controlp INFIELD faai023 name="construct.c.page3.faai023"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON faajld,faaj003,faaj004,faaj005,faaj006,faaj007,faaj008,faaj009,faaj010, 
          faaj011,faaj012,faaj013,faaj014,faaj015,faaj016,faaj017,faaj018,faaj019,faaj020,faaj021,faaj022, 
          faaj023,faaj024,faaj025,faaj026,faaj027,faaj028,faaj029,faaj030,faaj031,faaj032,faaj033,faaj034, 
          faaj035,faaj036,faaj038,faaj039,faaj040,faaj041,faaj042,faaj043,faaj044,faaj045,faaj046,faaj047, 
          faaj101,faaj102,faaj103,faaj104,faaj105,faaj106,faaj107,faaj108,faaj109,faaj110,faaj111,faaj112, 
          faaj113,faaj114,faaj115,faaj116,faaj117,faaj151,faaj152,faaj153,faaj154,faaj155,faaj156,faaj157, 
          faaj158,faaj159,faaj160,faaj161,faaj162,faaj163,faaj164,faaj165,faaj166,faaj167,faajsite
           FROM s_detail4[1].faajld,s_detail4[1].faaj003,s_detail4[1].faaj004,s_detail4[1].faaj005,s_detail4[1].faaj006, 
               s_detail4[1].faaj007,s_detail4[1].faaj008,s_detail4[1].faaj009,s_detail4[1].faaj010,s_detail4[1].faaj011, 
               s_detail4[1].faaj012,s_detail4[1].faaj013,s_detail4[1].faaj014,s_detail4[1].faaj015,s_detail4[1].faaj016, 
               s_detail4[1].faaj017,s_detail4[1].faaj018,s_detail4[1].faaj019,s_detail4[1].faaj020,s_detail4[1].faaj021, 
               s_detail4[1].faaj022,s_detail4[1].faaj023,s_detail4[1].faaj024,s_detail4[1].faaj025,s_detail4[1].faaj026, 
               s_detail4[1].faaj027,s_detail4[1].faaj028,s_detail4[1].faaj029,s_detail4[1].faaj030,s_detail4[1].faaj031, 
               s_detail4[1].faaj032,s_detail4[1].faaj033,s_detail4[1].faaj034,s_detail4[1].faaj035,s_detail4[1].faaj036, 
               s_detail4[1].faaj038,s_detail4[1].faaj039,s_detail4[1].faaj040,s_detail4[1].faaj041,s_detail4[1].faaj042, 
               s_detail4[1].faaj043,s_detail4[1].faaj044,s_detail4[1].faaj045,s_detail4[1].faaj046,s_detail4[1].faaj047, 
               s_detail4[1].faaj101,s_detail4[1].faaj102,s_detail4[1].faaj103,s_detail4[1].faaj104,s_detail4[1].faaj105, 
               s_detail4[1].faaj106,s_detail4[1].faaj107,s_detail4[1].faaj108,s_detail4[1].faaj109,s_detail4[1].faaj110, 
               s_detail4[1].faaj111,s_detail4[1].faaj112,s_detail4[1].faaj113,s_detail4[1].faaj114,s_detail4[1].faaj115, 
               s_detail4[1].faaj116,s_detail4[1].faaj117,s_detail4[1].faaj151,s_detail4[1].faaj152,s_detail4[1].faaj153, 
               s_detail4[1].faaj154,s_detail4[1].faaj155,s_detail4[1].faaj156,s_detail4[1].faaj157,s_detail4[1].faaj158, 
               s_detail4[1].faaj159,s_detail4[1].faaj160,s_detail4[1].faaj161,s_detail4[1].faaj162,s_detail4[1].faaj163, 
               s_detail4[1].faaj164,s_detail4[1].faaj165,s_detail4[1].faaj166,s_detail4[1].faaj167,s_detail4[1].faajsite 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page4.faajld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faajld
            #add-point:ON ACTION controlp INFIELD faajld name="construct.c.page4.faajld"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faajld  #顯示到畫面上
            NEXT FIELD faajld                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faajld
            #add-point:BEFORE FIELD faajld name="construct.b.page4.faajld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faajld
            
            #add-point:AFTER FIELD faajld name="construct.a.page4.faajld"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj003
            #add-point:BEFORE FIELD faaj003 name="construct.b.page4.faaj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj003
            
            #add-point:AFTER FIELD faaj003 name="construct.a.page4.faaj003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj003
            #add-point:ON ACTION controlp INFIELD faaj003 name="construct.c.page4.faaj003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj004
            #add-point:BEFORE FIELD faaj004 name="construct.b.page4.faaj004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj004
            
            #add-point:AFTER FIELD faaj004 name="construct.a.page4.faaj004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj004
            #add-point:ON ACTION controlp INFIELD faaj004 name="construct.c.page4.faaj004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj005
            #add-point:BEFORE FIELD faaj005 name="construct.b.page4.faaj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj005
            
            #add-point:AFTER FIELD faaj005 name="construct.a.page4.faaj005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj005
            #add-point:ON ACTION controlp INFIELD faaj005 name="construct.c.page4.faaj005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj006
            #add-point:BEFORE FIELD faaj006 name="construct.b.page4.faaj006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj006
            
            #add-point:AFTER FIELD faaj006 name="construct.a.page4.faaj006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj006
            #add-point:ON ACTION controlp INFIELD faaj006 name="construct.c.page4.faaj006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj007
            #add-point:BEFORE FIELD faaj007 name="construct.b.page4.faaj007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj007
            
            #add-point:AFTER FIELD faaj007 name="construct.a.page4.faaj007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj007
            #add-point:ON ACTION controlp INFIELD faaj007 name="construct.c.page4.faaj007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj008
            #add-point:BEFORE FIELD faaj008 name="construct.b.page4.faaj008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj008
            
            #add-point:AFTER FIELD faaj008 name="construct.a.page4.faaj008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj008
            #add-point:ON ACTION controlp INFIELD faaj008 name="construct.c.page4.faaj008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj009
            #add-point:BEFORE FIELD faaj009 name="construct.b.page4.faaj009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj009
            
            #add-point:AFTER FIELD faaj009 name="construct.a.page4.faaj009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj009
            #add-point:ON ACTION controlp INFIELD faaj009 name="construct.c.page4.faaj009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj010
            #add-point:BEFORE FIELD faaj010 name="construct.b.page4.faaj010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj010
            
            #add-point:AFTER FIELD faaj010 name="construct.a.page4.faaj010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj010
            #add-point:ON ACTION controlp INFIELD faaj010 name="construct.c.page4.faaj010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj011
            #add-point:BEFORE FIELD faaj011 name="construct.b.page4.faaj011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj011
            
            #add-point:AFTER FIELD faaj011 name="construct.a.page4.faaj011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj011
            #add-point:ON ACTION controlp INFIELD faaj011 name="construct.c.page4.faaj011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj012
            #add-point:BEFORE FIELD faaj012 name="construct.b.page4.faaj012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj012
            
            #add-point:AFTER FIELD faaj012 name="construct.a.page4.faaj012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj012
            #add-point:ON ACTION controlp INFIELD faaj012 name="construct.c.page4.faaj012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj013
            #add-point:BEFORE FIELD faaj013 name="construct.b.page4.faaj013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj013
            
            #add-point:AFTER FIELD faaj013 name="construct.a.page4.faaj013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj013
            #add-point:ON ACTION controlp INFIELD faaj013 name="construct.c.page4.faaj013"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.faaj014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj014
            #add-point:ON ACTION controlp INFIELD faaj014 name="construct.c.page4.faaj014"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faaj014  #顯示到畫面上
            NEXT FIELD faaj014                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj014
            #add-point:BEFORE FIELD faaj014 name="construct.b.page4.faaj014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj014
            
            #add-point:AFTER FIELD faaj014 name="construct.a.page4.faaj014"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj015
            #add-point:BEFORE FIELD faaj015 name="construct.b.page4.faaj015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj015
            
            #add-point:AFTER FIELD faaj015 name="construct.a.page4.faaj015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj015
            #add-point:ON ACTION controlp INFIELD faaj015 name="construct.c.page4.faaj015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj016
            #add-point:BEFORE FIELD faaj016 name="construct.b.page4.faaj016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj016
            
            #add-point:AFTER FIELD faaj016 name="construct.a.page4.faaj016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj016
            #add-point:ON ACTION controlp INFIELD faaj016 name="construct.c.page4.faaj016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj017
            #add-point:BEFORE FIELD faaj017 name="construct.b.page4.faaj017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj017
            
            #add-point:AFTER FIELD faaj017 name="construct.a.page4.faaj017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj017
            #add-point:ON ACTION controlp INFIELD faaj017 name="construct.c.page4.faaj017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj018
            #add-point:BEFORE FIELD faaj018 name="construct.b.page4.faaj018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj018
            
            #add-point:AFTER FIELD faaj018 name="construct.a.page4.faaj018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj018
            #add-point:ON ACTION controlp INFIELD faaj018 name="construct.c.page4.faaj018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj019
            #add-point:BEFORE FIELD faaj019 name="construct.b.page4.faaj019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj019
            
            #add-point:AFTER FIELD faaj019 name="construct.a.page4.faaj019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj019
            #add-point:ON ACTION controlp INFIELD faaj019 name="construct.c.page4.faaj019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj020
            #add-point:BEFORE FIELD faaj020 name="construct.b.page4.faaj020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj020
            
            #add-point:AFTER FIELD faaj020 name="construct.a.page4.faaj020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj020
            #add-point:ON ACTION controlp INFIELD faaj020 name="construct.c.page4.faaj020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj021
            #add-point:BEFORE FIELD faaj021 name="construct.b.page4.faaj021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj021
            
            #add-point:AFTER FIELD faaj021 name="construct.a.page4.faaj021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj021
            #add-point:ON ACTION controlp INFIELD faaj021 name="construct.c.page4.faaj021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj022
            #add-point:BEFORE FIELD faaj022 name="construct.b.page4.faaj022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj022
            
            #add-point:AFTER FIELD faaj022 name="construct.a.page4.faaj022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj022
            #add-point:ON ACTION controlp INFIELD faaj022 name="construct.c.page4.faaj022"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.faaj023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj023
            #add-point:ON ACTION controlp INFIELD faaj023 name="construct.c.page4.faaj023"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faaj023  #顯示到畫面上
            NEXT FIELD faaj023                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj023
            #add-point:BEFORE FIELD faaj023 name="construct.b.page4.faaj023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj023
            
            #add-point:AFTER FIELD faaj023 name="construct.a.page4.faaj023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj024
            #add-point:ON ACTION controlp INFIELD faaj024 name="construct.c.page4.faaj024"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faaj024  #顯示到畫面上
            NEXT FIELD faaj024                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj024
            #add-point:BEFORE FIELD faaj024 name="construct.b.page4.faaj024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj024
            
            #add-point:AFTER FIELD faaj024 name="construct.a.page4.faaj024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj025
            #add-point:ON ACTION controlp INFIELD faaj025 name="construct.c.page4.faaj025"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faaj025  #顯示到畫面上
            NEXT FIELD faaj025                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj025
            #add-point:BEFORE FIELD faaj025 name="construct.b.page4.faaj025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj025
            
            #add-point:AFTER FIELD faaj025 name="construct.a.page4.faaj025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj026
            #add-point:ON ACTION controlp INFIELD faaj026 name="construct.c.page4.faaj026"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faaj026  #顯示到畫面上
            NEXT FIELD faaj026                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj026
            #add-point:BEFORE FIELD faaj026 name="construct.b.page4.faaj026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj026
            
            #add-point:AFTER FIELD faaj026 name="construct.a.page4.faaj026"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj027
            #add-point:BEFORE FIELD faaj027 name="construct.b.page4.faaj027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj027
            
            #add-point:AFTER FIELD faaj027 name="construct.a.page4.faaj027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj027
            #add-point:ON ACTION controlp INFIELD faaj027 name="construct.c.page4.faaj027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj028
            #add-point:BEFORE FIELD faaj028 name="construct.b.page4.faaj028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj028
            
            #add-point:AFTER FIELD faaj028 name="construct.a.page4.faaj028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj028
            #add-point:ON ACTION controlp INFIELD faaj028 name="construct.c.page4.faaj028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj029
            #add-point:BEFORE FIELD faaj029 name="construct.b.page4.faaj029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj029
            
            #add-point:AFTER FIELD faaj029 name="construct.a.page4.faaj029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj029
            #add-point:ON ACTION controlp INFIELD faaj029 name="construct.c.page4.faaj029"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.faaj030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj030
            #add-point:ON ACTION controlp INFIELD faaj030 name="construct.c.page4.faaj030"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_faaj030()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faaj030  #顯示到畫面上
            NEXT FIELD faaj030                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj030
            #add-point:BEFORE FIELD faaj030 name="construct.b.page4.faaj030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj030
            
            #add-point:AFTER FIELD faaj030 name="construct.a.page4.faaj030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj031
            #add-point:ON ACTION controlp INFIELD faaj031 name="construct.c.page4.faaj031"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_bgaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faaj031  #顯示到畫面上
            NEXT FIELD faaj031                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj031
            #add-point:BEFORE FIELD faaj031 name="construct.b.page4.faaj031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj031
            
            #add-point:AFTER FIELD faaj031 name="construct.a.page4.faaj031"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj032
            #add-point:BEFORE FIELD faaj032 name="construct.b.page4.faaj032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj032
            
            #add-point:AFTER FIELD faaj032 name="construct.a.page4.faaj032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj032
            #add-point:ON ACTION controlp INFIELD faaj032 name="construct.c.page4.faaj032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj033
            #add-point:BEFORE FIELD faaj033 name="construct.b.page4.faaj033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj033
            
            #add-point:AFTER FIELD faaj033 name="construct.a.page4.faaj033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj033
            #add-point:ON ACTION controlp INFIELD faaj033 name="construct.c.page4.faaj033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj034
            #add-point:BEFORE FIELD faaj034 name="construct.b.page4.faaj034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj034
            
            #add-point:AFTER FIELD faaj034 name="construct.a.page4.faaj034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj034
            #add-point:ON ACTION controlp INFIELD faaj034 name="construct.c.page4.faaj034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj035
            #add-point:BEFORE FIELD faaj035 name="construct.b.page4.faaj035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj035
            
            #add-point:AFTER FIELD faaj035 name="construct.a.page4.faaj035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj035
            #add-point:ON ACTION controlp INFIELD faaj035 name="construct.c.page4.faaj035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj036
            #add-point:BEFORE FIELD faaj036 name="construct.b.page4.faaj036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj036
            
            #add-point:AFTER FIELD faaj036 name="construct.a.page4.faaj036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj036
            #add-point:ON ACTION controlp INFIELD faaj036 name="construct.c.page4.faaj036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj038
            #add-point:BEFORE FIELD faaj038 name="construct.b.page4.faaj038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj038
            
            #add-point:AFTER FIELD faaj038 name="construct.a.page4.faaj038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj038
            #add-point:ON ACTION controlp INFIELD faaj038 name="construct.c.page4.faaj038"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj039
            #add-point:BEFORE FIELD faaj039 name="construct.b.page4.faaj039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj039
            
            #add-point:AFTER FIELD faaj039 name="construct.a.page4.faaj039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj039
            #add-point:ON ACTION controlp INFIELD faaj039 name="construct.c.page4.faaj039"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj040
            #add-point:BEFORE FIELD faaj040 name="construct.b.page4.faaj040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj040
            
            #add-point:AFTER FIELD faaj040 name="construct.a.page4.faaj040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj040
            #add-point:ON ACTION controlp INFIELD faaj040 name="construct.c.page4.faaj040"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj041
            #add-point:BEFORE FIELD faaj041 name="construct.b.page4.faaj041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj041
            
            #add-point:AFTER FIELD faaj041 name="construct.a.page4.faaj041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj041
            #add-point:ON ACTION controlp INFIELD faaj041 name="construct.c.page4.faaj041"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.faaj042
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj042
            #add-point:ON ACTION controlp INFIELD faaj042 name="construct.c.page4.faaj042"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faaj042  #顯示到畫面上
            NEXT FIELD faaj042                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj042
            #add-point:BEFORE FIELD faaj042 name="construct.b.page4.faaj042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj042
            
            #add-point:AFTER FIELD faaj042 name="construct.a.page4.faaj042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj043
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj043
            #add-point:ON ACTION controlp INFIELD faaj043 name="construct.c.page4.faaj043"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faaj043  #顯示到畫面上
            NEXT FIELD faaj043                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj043
            #add-point:BEFORE FIELD faaj043 name="construct.b.page4.faaj043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj043
            
            #add-point:AFTER FIELD faaj043 name="construct.a.page4.faaj043"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj044
            #add-point:BEFORE FIELD faaj044 name="construct.b.page4.faaj044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj044
            
            #add-point:AFTER FIELD faaj044 name="construct.a.page4.faaj044"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj044
            #add-point:ON ACTION controlp INFIELD faaj044 name="construct.c.page4.faaj044"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.faaj045
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj045
            #add-point:ON ACTION controlp INFIELD faaj045 name="construct.c.page4.faaj045"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faaj045  #顯示到畫面上
            NEXT FIELD faaj045                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj045
            #add-point:BEFORE FIELD faaj045 name="construct.b.page4.faaj045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj045
            
            #add-point:AFTER FIELD faaj045 name="construct.a.page4.faaj045"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj046
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj046
            #add-point:ON ACTION controlp INFIELD faaj046 name="construct.c.page4.faaj046"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faaj046  #顯示到畫面上
            NEXT FIELD faaj046                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj046
            #add-point:BEFORE FIELD faaj046 name="construct.b.page4.faaj046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj046
            
            #add-point:AFTER FIELD faaj046 name="construct.a.page4.faaj046"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj047
            #add-point:BEFORE FIELD faaj047 name="construct.b.page4.faaj047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj047
            
            #add-point:AFTER FIELD faaj047 name="construct.a.page4.faaj047"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj047
            #add-point:ON ACTION controlp INFIELD faaj047 name="construct.c.page4.faaj047"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj101
            #add-point:BEFORE FIELD faaj101 name="construct.b.page4.faaj101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj101
            
            #add-point:AFTER FIELD faaj101 name="construct.a.page4.faaj101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj101
            #add-point:ON ACTION controlp INFIELD faaj101 name="construct.c.page4.faaj101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj102
            #add-point:BEFORE FIELD faaj102 name="construct.b.page4.faaj102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj102
            
            #add-point:AFTER FIELD faaj102 name="construct.a.page4.faaj102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj102
            #add-point:ON ACTION controlp INFIELD faaj102 name="construct.c.page4.faaj102"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj103
            #add-point:BEFORE FIELD faaj103 name="construct.b.page4.faaj103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj103
            
            #add-point:AFTER FIELD faaj103 name="construct.a.page4.faaj103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj103
            #add-point:ON ACTION controlp INFIELD faaj103 name="construct.c.page4.faaj103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj104
            #add-point:BEFORE FIELD faaj104 name="construct.b.page4.faaj104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj104
            
            #add-point:AFTER FIELD faaj104 name="construct.a.page4.faaj104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj104
            #add-point:ON ACTION controlp INFIELD faaj104 name="construct.c.page4.faaj104"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj105
            #add-point:BEFORE FIELD faaj105 name="construct.b.page4.faaj105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj105
            
            #add-point:AFTER FIELD faaj105 name="construct.a.page4.faaj105"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj105
            #add-point:ON ACTION controlp INFIELD faaj105 name="construct.c.page4.faaj105"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj106
            #add-point:BEFORE FIELD faaj106 name="construct.b.page4.faaj106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj106
            
            #add-point:AFTER FIELD faaj106 name="construct.a.page4.faaj106"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj106
            #add-point:ON ACTION controlp INFIELD faaj106 name="construct.c.page4.faaj106"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj107
            #add-point:BEFORE FIELD faaj107 name="construct.b.page4.faaj107"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj107
            
            #add-point:AFTER FIELD faaj107 name="construct.a.page4.faaj107"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj107
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj107
            #add-point:ON ACTION controlp INFIELD faaj107 name="construct.c.page4.faaj107"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj108
            #add-point:BEFORE FIELD faaj108 name="construct.b.page4.faaj108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj108
            
            #add-point:AFTER FIELD faaj108 name="construct.a.page4.faaj108"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj108
            #add-point:ON ACTION controlp INFIELD faaj108 name="construct.c.page4.faaj108"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj109
            #add-point:BEFORE FIELD faaj109 name="construct.b.page4.faaj109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj109
            
            #add-point:AFTER FIELD faaj109 name="construct.a.page4.faaj109"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj109
            #add-point:ON ACTION controlp INFIELD faaj109 name="construct.c.page4.faaj109"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj110
            #add-point:BEFORE FIELD faaj110 name="construct.b.page4.faaj110"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj110
            
            #add-point:AFTER FIELD faaj110 name="construct.a.page4.faaj110"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj110
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj110
            #add-point:ON ACTION controlp INFIELD faaj110 name="construct.c.page4.faaj110"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj111
            #add-point:BEFORE FIELD faaj111 name="construct.b.page4.faaj111"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj111
            
            #add-point:AFTER FIELD faaj111 name="construct.a.page4.faaj111"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj111
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj111
            #add-point:ON ACTION controlp INFIELD faaj111 name="construct.c.page4.faaj111"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj112
            #add-point:BEFORE FIELD faaj112 name="construct.b.page4.faaj112"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj112
            
            #add-point:AFTER FIELD faaj112 name="construct.a.page4.faaj112"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj112
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj112
            #add-point:ON ACTION controlp INFIELD faaj112 name="construct.c.page4.faaj112"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj113
            #add-point:BEFORE FIELD faaj113 name="construct.b.page4.faaj113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj113
            
            #add-point:AFTER FIELD faaj113 name="construct.a.page4.faaj113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj113
            #add-point:ON ACTION controlp INFIELD faaj113 name="construct.c.page4.faaj113"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj114
            #add-point:BEFORE FIELD faaj114 name="construct.b.page4.faaj114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj114
            
            #add-point:AFTER FIELD faaj114 name="construct.a.page4.faaj114"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj114
            #add-point:ON ACTION controlp INFIELD faaj114 name="construct.c.page4.faaj114"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj115
            #add-point:BEFORE FIELD faaj115 name="construct.b.page4.faaj115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj115
            
            #add-point:AFTER FIELD faaj115 name="construct.a.page4.faaj115"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj115
            #add-point:ON ACTION controlp INFIELD faaj115 name="construct.c.page4.faaj115"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj116
            #add-point:BEFORE FIELD faaj116 name="construct.b.page4.faaj116"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj116
            
            #add-point:AFTER FIELD faaj116 name="construct.a.page4.faaj116"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj116
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj116
            #add-point:ON ACTION controlp INFIELD faaj116 name="construct.c.page4.faaj116"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj117
            #add-point:BEFORE FIELD faaj117 name="construct.b.page4.faaj117"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj117
            
            #add-point:AFTER FIELD faaj117 name="construct.a.page4.faaj117"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj117
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj117
            #add-point:ON ACTION controlp INFIELD faaj117 name="construct.c.page4.faaj117"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj151
            #add-point:BEFORE FIELD faaj151 name="construct.b.page4.faaj151"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj151
            
            #add-point:AFTER FIELD faaj151 name="construct.a.page4.faaj151"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj151
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj151
            #add-point:ON ACTION controlp INFIELD faaj151 name="construct.c.page4.faaj151"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj152
            #add-point:BEFORE FIELD faaj152 name="construct.b.page4.faaj152"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj152
            
            #add-point:AFTER FIELD faaj152 name="construct.a.page4.faaj152"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj152
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj152
            #add-point:ON ACTION controlp INFIELD faaj152 name="construct.c.page4.faaj152"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj153
            #add-point:BEFORE FIELD faaj153 name="construct.b.page4.faaj153"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj153
            
            #add-point:AFTER FIELD faaj153 name="construct.a.page4.faaj153"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj153
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj153
            #add-point:ON ACTION controlp INFIELD faaj153 name="construct.c.page4.faaj153"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj154
            #add-point:BEFORE FIELD faaj154 name="construct.b.page4.faaj154"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj154
            
            #add-point:AFTER FIELD faaj154 name="construct.a.page4.faaj154"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj154
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj154
            #add-point:ON ACTION controlp INFIELD faaj154 name="construct.c.page4.faaj154"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj155
            #add-point:BEFORE FIELD faaj155 name="construct.b.page4.faaj155"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj155
            
            #add-point:AFTER FIELD faaj155 name="construct.a.page4.faaj155"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj155
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj155
            #add-point:ON ACTION controlp INFIELD faaj155 name="construct.c.page4.faaj155"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj156
            #add-point:BEFORE FIELD faaj156 name="construct.b.page4.faaj156"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj156
            
            #add-point:AFTER FIELD faaj156 name="construct.a.page4.faaj156"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj156
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj156
            #add-point:ON ACTION controlp INFIELD faaj156 name="construct.c.page4.faaj156"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj157
            #add-point:BEFORE FIELD faaj157 name="construct.b.page4.faaj157"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj157
            
            #add-point:AFTER FIELD faaj157 name="construct.a.page4.faaj157"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj157
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj157
            #add-point:ON ACTION controlp INFIELD faaj157 name="construct.c.page4.faaj157"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj158
            #add-point:BEFORE FIELD faaj158 name="construct.b.page4.faaj158"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj158
            
            #add-point:AFTER FIELD faaj158 name="construct.a.page4.faaj158"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj158
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj158
            #add-point:ON ACTION controlp INFIELD faaj158 name="construct.c.page4.faaj158"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj159
            #add-point:BEFORE FIELD faaj159 name="construct.b.page4.faaj159"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj159
            
            #add-point:AFTER FIELD faaj159 name="construct.a.page4.faaj159"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj159
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj159
            #add-point:ON ACTION controlp INFIELD faaj159 name="construct.c.page4.faaj159"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj160
            #add-point:BEFORE FIELD faaj160 name="construct.b.page4.faaj160"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj160
            
            #add-point:AFTER FIELD faaj160 name="construct.a.page4.faaj160"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj160
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj160
            #add-point:ON ACTION controlp INFIELD faaj160 name="construct.c.page4.faaj160"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj161
            #add-point:BEFORE FIELD faaj161 name="construct.b.page4.faaj161"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj161
            
            #add-point:AFTER FIELD faaj161 name="construct.a.page4.faaj161"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj161
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj161
            #add-point:ON ACTION controlp INFIELD faaj161 name="construct.c.page4.faaj161"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj162
            #add-point:BEFORE FIELD faaj162 name="construct.b.page4.faaj162"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj162
            
            #add-point:AFTER FIELD faaj162 name="construct.a.page4.faaj162"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj162
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj162
            #add-point:ON ACTION controlp INFIELD faaj162 name="construct.c.page4.faaj162"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj163
            #add-point:BEFORE FIELD faaj163 name="construct.b.page4.faaj163"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj163
            
            #add-point:AFTER FIELD faaj163 name="construct.a.page4.faaj163"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj163
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj163
            #add-point:ON ACTION controlp INFIELD faaj163 name="construct.c.page4.faaj163"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj164
            #add-point:BEFORE FIELD faaj164 name="construct.b.page4.faaj164"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj164
            
            #add-point:AFTER FIELD faaj164 name="construct.a.page4.faaj164"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj164
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj164
            #add-point:ON ACTION controlp INFIELD faaj164 name="construct.c.page4.faaj164"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj165
            #add-point:BEFORE FIELD faaj165 name="construct.b.page4.faaj165"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj165
            
            #add-point:AFTER FIELD faaj165 name="construct.a.page4.faaj165"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj165
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj165
            #add-point:ON ACTION controlp INFIELD faaj165 name="construct.c.page4.faaj165"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj166
            #add-point:BEFORE FIELD faaj166 name="construct.b.page4.faaj166"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj166
            
            #add-point:AFTER FIELD faaj166 name="construct.a.page4.faaj166"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj166
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj166
            #add-point:ON ACTION controlp INFIELD faaj166 name="construct.c.page4.faaj166"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj167
            #add-point:BEFORE FIELD faaj167 name="construct.b.page4.faaj167"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj167
            
            #add-point:AFTER FIELD faaj167 name="construct.a.page4.faaj167"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.faaj167
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj167
            #add-point:ON ACTION controlp INFIELD faaj167 name="construct.c.page4.faaj167"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.faajsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faajsite
            #add-point:ON ACTION controlp INFIELD faajsite name="construct.c.page4.faajsite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_faab001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faajsite  #顯示到畫面上
            NEXT FIELD faajsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faajsite
            #add-point:BEFORE FIELD faajsite name="construct.b.page4.faajsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faajsite
            
            #add-point:AFTER FIELD faajsite name="construct.a.page4.faajsite"
            
            #END add-point
            
 
 
   
       
      END CONSTRUCT
 
 
  
      #add-point:query段more_construct name="query.more_construct"
      
      #end add-point 
      
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="query.b_dialog"
         
         #end add-point  
 
      ON ACTION qbe_select     #條件查詢
         CALL cl_qbe_list('m') RETURNING ls_wc
 
      ON ACTION qbe_save       #條件儲存
         CALL cl_qbe_save()
      
      ON ACTION accept
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         CANCEL DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
   END DIALOG
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      LET g_wc2 = " 1=2"
      RETURN
   ELSE
      #資料導回第一筆
      LET g_detail_idx  = 1
      LET g_detail_idx2 = 1
   END IF
   
   LET g_wc = g_wc_table 
 
              , " AND ", g_wc2_table2
 
              , " AND ", g_wc2_table3
 
 
        
   LET g_wc2 = " 1=1"
               , " AND ", g_wc2_table2
 
               , " AND ", g_wc2_table3
 
 
        
   #add-point:cs段after_construct name="cs.after_construct"
   
   #end add-point
   
   LET g_error_show = 1
   CALL afat300_b_fill(g_wc)
   LET l_ac = g_detail_idx
   
   CALL afat300_fetch()
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = -100 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   END IF
 
   #資料導回第一筆(假設有資料)
   IF g_faah_d.getLength() > 0 THEN
      DISPLAY g_detail_idx  TO FORMONLY.h_index
   ELSE
      DISPLAY ' ' TO FORMONLY.h_index
   END IF
   IF g_faah3_d.getLength() > 0 THEN
      DISPLAY g_detail_idx2 TO FORMONLY.idx
   ELSE
      DISPLAY ' ' TO FORMONLY.idx
   END IF
   
END FUNCTION
 
{</section>}
 
{<section id="afat300.insert" >}
#+ 資料修改
PRIVATE FUNCTION afat300_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point 
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   RETURN
   #end add-point 
   
   #add-point:Function前置處理  name="insert.before_insert"
   
   #end add-point 
   
   LET g_insert = 'Y'
   CALL afat300_input('a')
   
   #add-point:insert段新增後 name="insert.after_insert"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afat300.modify" >}
#+ 資料新增
PRIVATE FUNCTION afat300_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point 
   DEFINE l_ac_t LIKE type_t.num10
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
 
   #end add-point 
  
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   LET l_ac_t = g_detail_idx
 
   #add-point:modify段新增前 name="modify.before_modify"
   
   #end add-point 
   
   #進入資料輸入段落
   CALL afat300_input('u')
    
   IF INT_FLAG AND g_faah_d.getLength() > 0 THEN
      LET g_detail_idx = l_ac_t
      LET l_ac = l_ac_t
      CALL afat300_b_fill(g_wc)
      CALL afat300_detail_show() 
   END IF
   
   #add-point:modify段新增後 name="modify.after_modify"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afat300.delete" >}
#+ 資料刪除
PRIVATE FUNCTION afat300_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point 
   DEFINE li_ac LIKE type_t.num10
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
 
   #end add-point 
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF NOT cl_ask_delete() THEN
      #不刪除
      RETURN
   END IF
   
   LET li_ac = ARR_CURR()
   LET g_faah_d_t.* = g_faah_d[li_ac].*
   LET g_faah_d_o.* = g_faah_d[li_ac].*
   
   CALL s_transaction_begin()  
   
   #add-point:delete段刪除前 name="delete.before_delete"
   
   #end add-point 
   
   #刪除單頭
   DELETE FROM faah_t 
         WHERE faahent = g_enterprise AND
           faah000 = g_faah_d_t.faah000
           AND faah001 = g_faah_d_t.faah001
           AND faah003 = g_faah_d_t.faah003
           AND faah004 = g_faah_d_t.faah004
 
           
   #add-point:delete段刪除中 name="delete.m_delete"
   
   #end add-point 
           
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "faah_t:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afat300_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove.func"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
    
   
   #add-point:delete段刪除後 name="delete.after_delete"
   
   #end add-point 
   
   #刪除單頭
   #add-point:delete段刪除前 name="delete.before_delete2"
   
   #end add-point 
   DELETE FROM faai_t 
         WHERE faaient = g_enterprise AND
           faai000 = g_faah_d_t.faah000
           AND faai001 = g_faah_d_t.faah001
           AND faai002 = g_faah_d_t.faah003
           AND faai003 = g_faah_d_t.faah004
 
   #add-point:delete段刪除中 name="delete.m_delete2"
   
   #end add-point 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "faai_t:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   ELSE
      CALL s_transaction_end('Y','0')
   END IF
   #add-point:delete段刪除後 name="delete.after_delete2"
   
   #end add-point 
 
   #add-point:delete段刪除前 name="delete.before_delete3"
   
   #end add-point 
   DELETE FROM faaj_t 
         WHERE faajent = g_enterprise AND
           faaj000 = g_faah_d_t.faah000
           AND faaj037 = g_faah_d_t.faah001
           AND faaj001 = g_faah_d_t.faah003
           AND faaj002 = g_faah_d_t.faah004
 
   #add-point:delete段刪除中 name="delete.m_delete3"
   
   #end add-point 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "faaj_t:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   ELSE
      CALL s_transaction_end('Y','0')
   END IF
   #add-point:delete段刪除後 name="delete.after_delete3"
   
   #end add-point 
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="afat300.input" >}
#+ 資料輸入
PRIVATE FUNCTION afat300_input(p_cmd)
   #add-point:input段define(客製用) name="input.define_customerization"
   
   #end add-point 
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_ac_t                LIKE type_t.num10               #未取消的ARRAY CNT 
   DEFINE  l_n                   LIKE type_t.num10               #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10               #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num10
   DEFINE  li_reproduce_target   LIKE type_t.num10
   DEFINE  l_insert              BOOLEAN
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   
   DEFINE l_sql                  STRING
   DEFINE l_glaa004              LIKE  glaa_t.glaa004 
   #end add-point 
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   LET g_action_choice = ""
   
   LET g_qryparam.state = "i"
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT faah000,faah001,faah003,faah004,faah002,faah005,faah006,faah007,faah008, 
       faah009,faah010,faah011,faah012,faah013,faah014,faah015,faah016,faah017,faah018,faah019,faah020, 
       faah021,faah022,faah023,faah024,faah025,faah026,faah027,faah028,faah029,faah030,faah031,faah032, 
       faah033,faah034,faah035,faah036,faah037,faah038,faah039,faah040,faah041,faah042,faah043,faah044, 
       faah045,faah000,faah001,faah003,faah004,faahownid,faahowndp,faahcrtid,faahcrtdp,faahcrtdt,faahmodid, 
       faahmoddt FROM faah_t WHERE faahent=? AND faah000=? AND faah001=? AND faah003=? AND faah004=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE afat300_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
   
 
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point 
   LET g_forupd_sql = "SELECT faaiseq,faai004,faai005,faai006,faai007,faai008,faai009,faai010,faai011, 
       faai012,faai013,faai014,faai015,faai016,faai017,faai018,faai019,faai020,faai021,faai022,faai023  
       FROM faai_t WHERE faaient=? AND faai000=? AND faai001=? AND faai002=? AND faai003=? AND faaiseq=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE afat300_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
   
   #end add-point 
   LET g_forupd_sql = "SELECT faajld,faaj003,faaj004,faaj005,faaj006,faaj007,faaj008,faaj009,faaj010, 
       faaj011,faaj012,faaj013,faaj014,faaj015,faaj016,faaj017,faaj018,faaj019,faaj020,faaj021,faaj022, 
       faaj023,faaj024,faaj025,faaj026,faaj027,faaj028,faaj029,faaj030,faaj031,faaj032,faaj033,faaj034, 
       faaj035,faaj036,faaj038,faaj039,faaj040,faaj041,faaj042,faaj043,faaj044,faaj045,faaj046,faaj047, 
       faaj101,faaj102,faaj103,faaj104,faaj105,faaj106,faaj107,faaj108,faaj109,faaj110,faaj111,faaj112, 
       faaj113,faaj114,faaj115,faaj116,faaj117,faaj151,faaj152,faaj153,faaj154,faaj155,faaj156,faaj157, 
       faaj158,faaj159,faaj160,faaj161,faaj162,faaj163,faaj164,faaj165,faaj166,faaj167,faajsite FROM  
       faaj_t WHERE faajent=? AND faaj000=? AND faaj037=? AND faaj001=? AND faaj002=? AND faajld=? FOR  
       UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE afat300_bcl3 CURSOR FROM g_forupd_sql
 
 
 
   LET lb_reproduce = FALSE
   LET l_insert = FALSE
      
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:input段修改前 name="input.before_input"
   
   #end add-point
 
   LET INT_FLAG = 0
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_faah_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_faah_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            LET g_current_page = 1
            IF p_cmd = 'u' THEN
               CALL afat300_b_fill(g_wc)
            END IF
            LET g_loc = 'm'
            LET g_detail_cnt = g_faah_d.getLength()
            #add-point:資料輸入前 name="input.body.before_input"
            
            #end add-point
            
         BEFORE ROW
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_ac_last = l_ac
            LET l_insert = FALSE
            LET g_detail_idx = l_ac
            LET g_master_t.* = g_faah_d[l_ac].*
            LET g_master.* = g_faah_d[l_ac].*
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            LET g_detail_idx = l_ac
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_faah_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_faah_d[l_ac].faah000 IS NOT NULL
               AND g_faah_d[l_ac].faah001 IS NOT NULL
               AND g_faah_d[l_ac].faah003 IS NOT NULL
               AND g_faah_d[l_ac].faah004 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_faah_d_t.* = g_faah_d[l_ac].*  #BACKUP
               LET g_faah_d_o.* = g_faah_d[l_ac].*  #BACKUP
               IF NOT afat300_lock_b("faah_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afat300_bcl INTO g_faah_d[l_ac].faah000,g_faah_d[l_ac].faah001,g_faah_d[l_ac].faah003, 
                      g_faah_d[l_ac].faah004,g_faah_d[l_ac].faah002,g_faah_d[l_ac].faah005,g_faah_d[l_ac].faah006, 
                      g_faah_d[l_ac].faah007,g_faah_d[l_ac].faah008,g_faah_d[l_ac].faah009,g_faah_d[l_ac].faah010, 
                      g_faah_d[l_ac].faah011,g_faah_d[l_ac].faah012,g_faah_d[l_ac].faah013,g_faah_d[l_ac].faah014, 
                      g_faah_d[l_ac].faah015,g_faah_d[l_ac].faah016,g_faah_d[l_ac].faah017,g_faah_d[l_ac].faah018, 
                      g_faah_d[l_ac].faah019,g_faah_d[l_ac].faah020,g_faah_d[l_ac].faah021,g_faah_d[l_ac].faah022, 
                      g_faah_d[l_ac].faah023,g_faah_d[l_ac].faah024,g_faah_d[l_ac].faah025,g_faah_d[l_ac].faah026, 
                      g_faah_d[l_ac].faah027,g_faah_d[l_ac].faah028,g_faah_d[l_ac].faah029,g_faah_d[l_ac].faah030, 
                      g_faah_d[l_ac].faah031,g_faah_d[l_ac].faah032,g_faah_d[l_ac].faah033,g_faah_d[l_ac].faah034, 
                      g_faah_d[l_ac].faah035,g_faah_d[l_ac].faah036,g_faah_d[l_ac].faah037,g_faah_d[l_ac].faah038, 
                      g_faah_d[l_ac].faah039,g_faah_d[l_ac].faah040,g_faah_d[l_ac].faah041,g_faah_d[l_ac].faah042, 
                      g_faah_d[l_ac].faah043,g_faah_d[l_ac].faah044,g_faah_d[l_ac].faah045,g_faah2_d[l_ac].faah000, 
                      g_faah2_d[l_ac].faah001,g_faah2_d[l_ac].faah003,g_faah2_d[l_ac].faah004,g_faah2_d[l_ac].faahownid, 
                      g_faah2_d[l_ac].faahowndp,g_faah2_d[l_ac].faahcrtid,g_faah2_d[l_ac].faahcrtdp, 
                      g_faah2_d[l_ac].faahcrtdt,g_faah2_d[l_ac].faahmodid,g_faah2_d[l_ac].faahmoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_faah_d_t.faah000,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
 
                  #遮罩相關處理
                  LET g_faah_d_mask_o[l_ac].* =  g_faah_d[l_ac].*
                  CALL afat300_faah_t_mask()
                  LET g_faah_d_mask_n[l_ac].* =  g_faah_d[l_ac].*
                  
                  CALL cl_show_fld_cont()
                  #CALL afat300_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL afat300_set_entry_b(l_cmd)
            CALL afat300_set_no_entry_b(l_cmd)
            #add-point:input段before row name="input.body.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
            #其他table進行lock
            
 
 
            #讀取對應的單身資料
            LET g_action_choice = "fetch"
            CALL afat300_fetch()
            CALL afat300_idx_chk('m')
 
         BEFORE INSERT
            
 
 
            #判斷能否在此頁面進行資料新增
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            #清空下層單身
                        CALL g_faah3_d.clear()
            CALL g_faah4_d.clear()
 
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_faah_d[l_ac].* TO NULL 
            INITIALIZE g_faah_d_t.* TO NULL 
            INITIALIZE g_faah_d_o.* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_faah2_d[l_ac].faahownid = g_user
      LET g_faah2_d[l_ac].faahowndp = g_dept
      LET g_faah2_d[l_ac].faahcrtid = g_user
      LET g_faah2_d[l_ac].faahcrtdp = g_dept 
      LET g_faah2_d[l_ac].faahcrtdt = cl_get_current()
      LET g_faah2_d[l_ac].faahmodid = g_user
      LET g_faah2_d[l_ac].faahmoddt = cl_get_current()
 
 
 
                  LET g_faah_d[l_ac].faah002 = "1"
      LET g_faah_d[l_ac].faah005 = "1"
      LET g_faah_d[l_ac].faah015 = "0"
      LET g_faah_d[l_ac].faah016 = "1"
      LET g_faah_d[l_ac].faah018 = "0"
      LET g_faah_d[l_ac].faah019 = "0"
      LET g_faah_d[l_ac].faah021 = "0"
      LET g_faah_d[l_ac].faah022 = "0"
      LET g_faah_d[l_ac].faah023 = "0"
      LET g_faah_d[l_ac].faah024 = "0"
      LET g_faah_d[l_ac].faah033 = "Y"
      LET g_faah_d[l_ac].faah042 = "1"
      LET g_faah_d[l_ac].faah043 = "0"
      LET g_faah_d[l_ac].faah044 = "0"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_faah_d_t.* = g_faah_d[l_ac].*     #新輸入資料
            LET g_faah_d_o.* = g_faah_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afat300_set_entry_b(l_cmd)
            CALL afat300_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_faah_d[li_reproduce_target].* = g_faah_d[li_reproduce].*
               LET g_faah2_d[li_reproduce_target].* = g_faah2_d[li_reproduce].*
 
               LET g_faah_d[g_faah_d.getLength()].faah000 = NULL
               LET g_faah_d[g_faah_d.getLength()].faah001 = NULL
               LET g_faah_d[g_faah_d.getLength()].faah003 = NULL
               LET g_faah_d[g_faah_d.getLength()].faah004 = NULL
 
            END IF
            #add-point:input段before insert name="input.body.before_insert"
            
            #end add-point  
  
         AFTER INSERT
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
            LET l_insert = FALSE
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM faah_t 
             WHERE faahent = g_enterprise AND faah000 = g_faah_d[l_ac].faah000 
                                       AND faah001 = g_faah_d[l_ac].faah001 
                                       AND faah003 = g_faah_d[l_ac].faah003 
                                       AND faah004 = g_faah_d[l_ac].faah004 
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_faah_d[g_detail_idx].faah000
               LET gs_keys[2] = g_faah_d[g_detail_idx].faah001
               LET gs_keys[3] = g_faah_d[g_detail_idx].faah003
               LET gs_keys[4] = g_faah_d[g_detail_idx].faah004
               CALL afat300_insert_b('faah_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_faah_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "faah_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afat300_b_fill(g_wc)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               LET g_master.* = g_faah_d[l_ac].*
            END IF
              
         BEFORE DELETE  #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身刪除後(=d) name="input.body.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code =  -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point
               
               DELETE FROM faah_t
                WHERE faahent = g_enterprise AND 
                      faah000 = g_faah_d_t.faah000
                      AND faah001 = g_faah_d_t.faah001
                      AND faah003 = g_faah_d_t.faah003
                      AND faah004 = g_faah_d_t.faah004
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "faah_t:",SQLERRMESSAGE  
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  LET g_log1 = util.JSON.stringify(g_faah_d[l_ac])   #(ver:45)
                  IF NOT cl_log_modified_record(g_log1,'') THEN   #(ver:45)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE afat300_bcl
               LET l_count = g_faah_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_faah_d_t.faah000
               LET gs_keys[2] = g_faah_d_t.faah001
               LET gs_keys[3] = g_faah_d_t.faah003
               LET gs_keys[4] = g_faah_d_t.faah004
    
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afat300_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
        
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL afat300_delete_b('faah_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_faah_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah000
            #add-point:BEFORE FIELD faah000 name="input.b.page1.faah000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah000
            
            #add-point:AFTER FIELD faah000 name="input.a.page1.faah000"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_faah_d[g_detail_idx].faah000 IS NOT NULL AND g_faah_d[g_detail_idx].faah001 IS NOT NULL AND g_faah_d[g_detail_idx].faah003 IS NOT NULL AND g_faah_d[g_detail_idx].faah004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_faah_d[g_detail_idx].faah000 != g_faah_d_t.faah000 OR g_faah_d[g_detail_idx].faah001 != g_faah_d_t.faah001 OR g_faah_d[g_detail_idx].faah003 != g_faah_d_t.faah003 OR g_faah_d[g_detail_idx].faah004 != g_faah_d_t.faah004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faah_t WHERE "||"faahent = '" ||g_enterprise|| "' AND "||"faah000 = '"||g_faah_d[g_detail_idx].faah000 ||"' AND "|| "faah001 = '"||g_faah_d[g_detail_idx].faah001 ||"' AND "|| "faah003 = '"||g_faah_d[g_detail_idx].faah003 ||"' AND "|| "faah004 = '"||g_faah_d[g_detail_idx].faah004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah000
            #add-point:ON CHANGE faah000 name="input.g.page1.faah000"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah001
            #add-point:BEFORE FIELD faah001 name="input.b.page1.faah001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah001
            
            #add-point:AFTER FIELD faah001 name="input.a.page1.faah001"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_faah_d[g_detail_idx].faah000 IS NOT NULL AND g_faah_d[g_detail_idx].faah001 IS NOT NULL AND g_faah_d[g_detail_idx].faah003 IS NOT NULL AND g_faah_d[g_detail_idx].faah004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_faah_d[g_detail_idx].faah000 != g_faah_d_t.faah000 OR g_faah_d[g_detail_idx].faah001 != g_faah_d_t.faah001 OR g_faah_d[g_detail_idx].faah003 != g_faah_d_t.faah003 OR g_faah_d[g_detail_idx].faah004 != g_faah_d_t.faah004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faah_t WHERE "||"faahent = '" ||g_enterprise|| "' AND "||"faah000 = '"||g_faah_d[g_detail_idx].faah000 ||"' AND "|| "faah001 = '"||g_faah_d[g_detail_idx].faah001 ||"' AND "|| "faah003 = '"||g_faah_d[g_detail_idx].faah003 ||"' AND "|| "faah004 = '"||g_faah_d[g_detail_idx].faah004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah001
            #add-point:ON CHANGE faah001 name="input.g.page1.faah001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah003
            #add-point:BEFORE FIELD faah003 name="input.b.page1.faah003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah003
            
            #add-point:AFTER FIELD faah003 name="input.a.page1.faah003"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_faah_d[g_detail_idx].faah000 IS NOT NULL AND g_faah_d[g_detail_idx].faah001 IS NOT NULL AND g_faah_d[g_detail_idx].faah003 IS NOT NULL AND g_faah_d[g_detail_idx].faah004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_faah_d[g_detail_idx].faah000 != g_faah_d_t.faah000 OR g_faah_d[g_detail_idx].faah001 != g_faah_d_t.faah001 OR g_faah_d[g_detail_idx].faah003 != g_faah_d_t.faah003 OR g_faah_d[g_detail_idx].faah004 != g_faah_d_t.faah004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faah_t WHERE "||"faahent = '" ||g_enterprise|| "' AND "||"faah000 = '"||g_faah_d[g_detail_idx].faah000 ||"' AND "|| "faah001 = '"||g_faah_d[g_detail_idx].faah001 ||"' AND "|| "faah003 = '"||g_faah_d[g_detail_idx].faah003 ||"' AND "|| "faah004 = '"||g_faah_d[g_detail_idx].faah004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah003
            #add-point:ON CHANGE faah003 name="input.g.page1.faah003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah004
            #add-point:BEFORE FIELD faah004 name="input.b.page1.faah004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah004
            
            #add-point:AFTER FIELD faah004 name="input.a.page1.faah004"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_faah_d[g_detail_idx].faah000 IS NOT NULL AND g_faah_d[g_detail_idx].faah001 IS NOT NULL AND g_faah_d[g_detail_idx].faah003 IS NOT NULL AND g_faah_d[g_detail_idx].faah004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_faah_d[g_detail_idx].faah000 != g_faah_d_t.faah000 OR g_faah_d[g_detail_idx].faah001 != g_faah_d_t.faah001 OR g_faah_d[g_detail_idx].faah003 != g_faah_d_t.faah003 OR g_faah_d[g_detail_idx].faah004 != g_faah_d_t.faah004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faah_t WHERE "||"faahent = '" ||g_enterprise|| "' AND "||"faah000 = '"||g_faah_d[g_detail_idx].faah000 ||"' AND "|| "faah001 = '"||g_faah_d[g_detail_idx].faah001 ||"' AND "|| "faah003 = '"||g_faah_d[g_detail_idx].faah003 ||"' AND "|| "faah004 = '"||g_faah_d[g_detail_idx].faah004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah004
            #add-point:ON CHANGE faah004 name="input.g.page1.faah004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah002
            #add-point:BEFORE FIELD faah002 name="input.b.page1.faah002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah002
            
            #add-point:AFTER FIELD faah002 name="input.a.page1.faah002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah002
            #add-point:ON CHANGE faah002 name="input.g.page1.faah002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah005
            #add-point:BEFORE FIELD faah005 name="input.b.page1.faah005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah005
            
            #add-point:AFTER FIELD faah005 name="input.a.page1.faah005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah005
            #add-point:ON CHANGE faah005 name="input.g.page1.faah005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah006
            
            #add-point:AFTER FIELD faah006 name="input.a.page1.faah006"
            IF NOT cl_null(g_faah_d[l_ac].faah006) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_d[l_ac].faah006
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "afa-00007:sub-01302|afai020|",cl_get_progname("afai020",g_lang,"2"),"|:EXEPROGafai020"
               #160318-00025#5--add--end
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_faac001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah_d[l_ac].faah006
            CALL ap_ref_array2(g_ref_fields,"SELECT faacl003 FROM faacl_t WHERE faaclent='"||g_enterprise||"' AND faacl001=? AND faacl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faah_d[l_ac].faah006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faah_d[l_ac].faah006_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah006
            #add-point:BEFORE FIELD faah006 name="input.b.page1.faah006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah006
            #add-point:ON CHANGE faah006 name="input.g.page1.faah006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah007
            
            #add-point:AFTER FIELD faah007 name="input.a.page1.faah007"
            IF NOT cl_null(g_faah_d[l_ac].faah007) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_d[l_ac].faah007
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "afa-00009:sub-01302|afai030|",cl_get_progname("afai030",g_lang,"2"),"|:EXEPROGafai030"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_faad001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah_d[l_ac].faah007
            CALL ap_ref_array2(g_ref_fields,"SELECT faadl003 FROM faadl_t WHERE faadlent='"||g_enterprise||"' AND faadl001=? AND faadl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faah_d[l_ac].faah007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faah_d[l_ac].faah007_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah007
            #add-point:BEFORE FIELD faah007 name="input.b.page1.faah007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah007
            #add-point:ON CHANGE faah007 name="input.g.page1.faah007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah008
            
            #add-point:AFTER FIELD faah008 name="input.a.page1.faah008"
            IF NOT cl_null(g_faah_d[l_ac].faah008) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_d[l_ac].faah008
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "afa-00011:sub-01302|afai110|",cl_get_progname("afai110",g_lang,"2"),"|:EXEPROGafai110"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_3903") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah_d[l_ac].faah008
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3903' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faah_d[l_ac].faah008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faah_d[l_ac].faah008_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah008
            #add-point:BEFORE FIELD faah008 name="input.b.page1.faah008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah008
            #add-point:ON CHANGE faah008 name="input.g.page1.faah008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah009
            
            #add-point:AFTER FIELD faah009 name="input.a.page1.faah009"
            IF NOT cl_null(g_faah_d[l_ac].faah009) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_d[l_ac].faah009
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "apm-00044:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_2") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah_d[l_ac].faah009
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faah_d[l_ac].faah009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faah_d[l_ac].faah009_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah009
            #add-point:BEFORE FIELD faah009 name="input.b.page1.faah009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah009
            #add-point:ON CHANGE faah009 name="input.g.page1.faah009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah010
            
            #add-point:AFTER FIELD faah010 name="input.a.page1.faah010"
            IF NOT cl_null(g_faah_d[l_ac].faah010) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_d[l_ac].faah010
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "apm-00044:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_2") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah_d[l_ac].faah010
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faah_d[l_ac].faah010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faah_d[l_ac].faah010_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah010
            #add-point:BEFORE FIELD faah010 name="input.b.page1.faah010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah010
            #add-point:ON CHANGE faah010 name="input.g.page1.faah010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah011
            
            #add-point:AFTER FIELD faah011 name="input.a.page1.faah011"
            IF NOT cl_null(g_faah_d[l_ac].faah011) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_d[l_ac].faah011
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00054:sub-01302|aooi010|",cl_get_progname("aooi010",g_lang,"2"),"|:EXEPROGaooi010"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooce001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah_d[l_ac].faah011
            CALL ap_ref_array2(g_ref_fields,"SELECT oocel003 FROM oocel_t WHERE oocelent='"||g_enterprise||"' AND oocel001=? AND oocel002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faah_d[l_ac].faah011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faah_d[l_ac].faah011_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah011
            #add-point:BEFORE FIELD faah011 name="input.b.page1.faah011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah011
            #add-point:ON CHANGE faah011 name="input.g.page1.faah011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah012
            #add-point:BEFORE FIELD faah012 name="input.b.page1.faah012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah012
            
            #add-point:AFTER FIELD faah012 name="input.a.page1.faah012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah012
            #add-point:ON CHANGE faah012 name="input.g.page1.faah012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah013
            #add-point:BEFORE FIELD faah013 name="input.b.page1.faah013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah013
            
            #add-point:AFTER FIELD faah013 name="input.a.page1.faah013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah013
            #add-point:ON CHANGE faah013 name="input.g.page1.faah013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah014
            #add-point:BEFORE FIELD faah014 name="input.b.page1.faah014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah014
            
            #add-point:AFTER FIELD faah014 name="input.a.page1.faah014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah014
            #add-point:ON CHANGE faah014 name="input.g.page1.faah014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah015
            #add-point:BEFORE FIELD faah015 name="input.b.page1.faah015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah015
            
            #add-point:AFTER FIELD faah015 name="input.a.page1.faah015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah015
            #add-point:ON CHANGE faah015 name="input.g.page1.faah015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah016
            #add-point:BEFORE FIELD faah016 name="input.b.page1.faah016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah016
            
            #add-point:AFTER FIELD faah016 name="input.a.page1.faah016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah016
            #add-point:ON CHANGE faah016 name="input.g.page1.faah016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah017
            
            #add-point:AFTER FIELD faah017 name="input.a.page1.faah017"
            IF NOT cl_null(g_faah_d[l_ac].faah017) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_d[l_ac].faah017
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooca001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah017
            #add-point:BEFORE FIELD faah017 name="input.b.page1.faah017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah017
            #add-point:ON CHANGE faah017 name="input.g.page1.faah017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah018
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_faah_d[l_ac].faah018,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD faah018
            END IF 
 
 
 
            #add-point:AFTER FIELD faah018 name="input.a.page1.faah018"
            IF NOT cl_null(g_faah_d[l_ac].faah018) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah018
            #add-point:BEFORE FIELD faah018 name="input.b.page1.faah018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah018
            #add-point:ON CHANGE faah018 name="input.g.page1.faah018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah019
            #add-point:BEFORE FIELD faah019 name="input.b.page1.faah019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah019
            
            #add-point:AFTER FIELD faah019 name="input.a.page1.faah019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah019
            #add-point:ON CHANGE faah019 name="input.g.page1.faah019"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah020
            
            #add-point:AFTER FIELD faah020 name="input.a.page1.faah020"
            IF NOT cl_null(g_faah_d[l_ac].faah020) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_d[l_ac].faah020
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00011:sub-01302|aooi140|",cl_get_progname("aooi140",g_lang,"2"),"|:EXEPROGaooi140"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooai001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah_d[l_ac].faah020
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faah_d[l_ac].faah020_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faah_d[l_ac].faah020_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah020
            #add-point:BEFORE FIELD faah020 name="input.b.page1.faah020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah020
            #add-point:ON CHANGE faah020 name="input.g.page1.faah020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah021
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_faah_d[l_ac].faah021,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD faah021
            END IF 
 
 
 
            #add-point:AFTER FIELD faah021 name="input.a.page1.faah021"
            IF NOT cl_null(g_faah_d[l_ac].faah021) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah021
            #add-point:BEFORE FIELD faah021 name="input.b.page1.faah021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah021
            #add-point:ON CHANGE faah021 name="input.g.page1.faah021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah022
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_faah_d[l_ac].faah022,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD faah022
            END IF 
 
 
 
            #add-point:AFTER FIELD faah022 name="input.a.page1.faah022"
            IF NOT cl_null(g_faah_d[l_ac].faah022) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah022
            #add-point:BEFORE FIELD faah022 name="input.b.page1.faah022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah022
            #add-point:ON CHANGE faah022 name="input.g.page1.faah022"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah023
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_faah_d[l_ac].faah023,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD faah023
            END IF 
 
 
 
            #add-point:AFTER FIELD faah023 name="input.a.page1.faah023"
            IF NOT cl_null(g_faah_d[l_ac].faah023) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah023
            #add-point:BEFORE FIELD faah023 name="input.b.page1.faah023"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah023
            #add-point:ON CHANGE faah023 name="input.g.page1.faah023"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah024
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_faah_d[l_ac].faah024,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD faah024
            END IF 
 
 
 
            #add-point:AFTER FIELD faah024 name="input.a.page1.faah024"
            IF NOT cl_null(g_faah_d[l_ac].faah024) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah024
            #add-point:BEFORE FIELD faah024 name="input.b.page1.faah024"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah024
            #add-point:ON CHANGE faah024 name="input.g.page1.faah024"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah025
            
            #add-point:AFTER FIELD faah025 name="input.a.page1.faah025"
            IF NOT cl_null(g_faah_d[l_ac].faah025) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_d[l_ac].faah025
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah_d[l_ac].faah025
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_faah_d[l_ac].faah025_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faah_d[l_ac].faah025_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah025
            #add-point:BEFORE FIELD faah025 name="input.b.page1.faah025"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah025
            #add-point:ON CHANGE faah025 name="input.g.page1.faah025"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah026
            
            #add-point:AFTER FIELD faah026 name="input.a.page1.faah026"
            IF NOT cl_null(g_faah_d[l_ac].faah026) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_d[l_ac].faah026
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#5--add--end
               #161024-00008#2 ---s---   
               #呼叫檢查存在並帶值的library
               #IF cl_chk_exist("v_ooef001") THEN
               #   #檢查成功時後續處理
               #   #LET  = g_chkparam.return1
               #   #DISPLAY BY NAME 
               #ELSE
               #   #檢查失敗時後續處理
               #   NEXT FIELD CURRENT
               #END IF
               
               CALL s_department_chk(g_faah_d[l_ac].faah026,g_faah_d[l_ac].faah014) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_faah_d[l_ac].faah026    = g_faah_d_t.faah026
                  LET g_faah_d[l_ac].faah026_desc = g_faah_d_t.faah026_desc
                  DISPLAY BY NAME g_faah_d[l_ac].faah026_desc
                  NEXT FIELD CURRENT            
               END IF 
               #161024-00008#2 ---e---
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah_d[l_ac].faah026
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faah_d[l_ac].faah026_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faah_d[l_ac].faah026_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah026
            #add-point:BEFORE FIELD faah026 name="input.b.page1.faah026"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah026
            #add-point:ON CHANGE faah026 name="input.g.page1.faah026"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah027
            
            #add-point:AFTER FIELD faah027 name="input.a.page1.faah027"
            IF NOT cl_null(g_faah_d[l_ac].faah027) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_d[l_ac].faah027

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_3900") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah_d[l_ac].faah027
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3900' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faah_d[l_ac].faah027_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faah_d[l_ac].faah027_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah027
            #add-point:BEFORE FIELD faah027 name="input.b.page1.faah027"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah027
            #add-point:ON CHANGE faah027 name="input.g.page1.faah027"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah028
            
            #add-point:AFTER FIELD faah028 name="input.a.page1.faah028"
            IF NOT cl_null(g_faah_d[l_ac].faah028) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_d[l_ac].faah028
               LET g_chkparam.arg2 = '參數2'
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_faab002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah028
            #add-point:BEFORE FIELD faah028 name="input.b.page1.faah028"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah028
            #add-point:ON CHANGE faah028 name="input.g.page1.faah028"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah029
            
            #add-point:AFTER FIELD faah029 name="input.a.page1.faah029"
            IF NOT cl_null(g_faah_d[l_ac].faah029) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_d[l_ac].faah029
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah_d[l_ac].faah029
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_faah_d[l_ac].faah029_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faah_d[l_ac].faah029_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah029
            #add-point:BEFORE FIELD faah029 name="input.b.page1.faah029"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah029
            #add-point:ON CHANGE faah029 name="input.g.page1.faah029"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah030
            
            #add-point:AFTER FIELD faah030 name="input.a.page1.faah030"
            IF NOT cl_null(g_faah_d[l_ac].faah030) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_d[l_ac].faah030
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               #IF cl_chk_exist("v_ooef001") THEN    #161024-00008#2
                IF cl_chk_exist("v_ooef001_26") THEN #161024-00008#2
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah_d[l_ac].faah030
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faah_d[l_ac].faah030_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faah_d[l_ac].faah030_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah030
            #add-point:BEFORE FIELD faah030 name="input.b.page1.faah030"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah030
            #add-point:ON CHANGE faah030 name="input.g.page1.faah030"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah031
            
            #add-point:AFTER FIELD faah031 name="input.a.page1.faah031"
            IF NOT cl_null(g_faah_d[l_ac].faah031) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_d[l_ac].faah031
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
              # IF cl_chk_exist("v_ooef001") THEN  #161024-00008#2
              IF cl_chk_exist("v_ooef001_23") THEN #161024-00008#2
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah_d[l_ac].faah031
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faah_d[l_ac].faah031_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faah_d[l_ac].faah031_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah031
            #add-point:BEFORE FIELD faah031 name="input.b.page1.faah031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah031
            #add-point:ON CHANGE faah031 name="input.g.page1.faah031"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah032
            
            #add-point:AFTER FIELD faah032 name="input.a.page1.faah032"
            IF NOT cl_null(g_faah_d[l_ac].faah032) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_d[l_ac].faah032
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               #IF cl_chk_exist("v_ooef001") THEN   #161024-00008#2
               IF cl_chk_exist("v_ooef001_1") THEN  #161024-00008#2
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah_d[l_ac].faah032
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faah_d[l_ac].faah032_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faah_d[l_ac].faah032_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah032
            #add-point:BEFORE FIELD faah032 name="input.b.page1.faah032"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah032
            #add-point:ON CHANGE faah032 name="input.g.page1.faah032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah033
            #add-point:BEFORE FIELD faah033 name="input.b.page1.faah033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah033
            
            #add-point:AFTER FIELD faah033 name="input.a.page1.faah033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah033
            #add-point:ON CHANGE faah033 name="input.g.page1.faah033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah034
            #add-point:BEFORE FIELD faah034 name="input.b.page1.faah034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah034
            
            #add-point:AFTER FIELD faah034 name="input.a.page1.faah034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah034
            #add-point:ON CHANGE faah034 name="input.g.page1.faah034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah035
            #add-point:BEFORE FIELD faah035 name="input.b.page1.faah035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah035
            
            #add-point:AFTER FIELD faah035 name="input.a.page1.faah035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah035
            #add-point:ON CHANGE faah035 name="input.g.page1.faah035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah036
            #add-point:BEFORE FIELD faah036 name="input.b.page1.faah036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah036
            
            #add-point:AFTER FIELD faah036 name="input.a.page1.faah036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah036
            #add-point:ON CHANGE faah036 name="input.g.page1.faah036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah037
            #add-point:BEFORE FIELD faah037 name="input.b.page1.faah037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah037
            
            #add-point:AFTER FIELD faah037 name="input.a.page1.faah037"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah037
            #add-point:ON CHANGE faah037 name="input.g.page1.faah037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah038
            #add-point:BEFORE FIELD faah038 name="input.b.page1.faah038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah038
            
            #add-point:AFTER FIELD faah038 name="input.a.page1.faah038"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah038
            #add-point:ON CHANGE faah038 name="input.g.page1.faah038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah039
            #add-point:BEFORE FIELD faah039 name="input.b.page1.faah039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah039
            
            #add-point:AFTER FIELD faah039 name="input.a.page1.faah039"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah039
            #add-point:ON CHANGE faah039 name="input.g.page1.faah039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah040
            #add-point:BEFORE FIELD faah040 name="input.b.page1.faah040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah040
            
            #add-point:AFTER FIELD faah040 name="input.a.page1.faah040"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah040
            #add-point:ON CHANGE faah040 name="input.g.page1.faah040"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah041
            
            #add-point:AFTER FIELD faah041 name="input.a.page1.faah041"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah_d[l_ac].faah041
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faah_d[l_ac].faah041_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faah_d[l_ac].faah041_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah041
            #add-point:BEFORE FIELD faah041 name="input.b.page1.faah041"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah041
            #add-point:ON CHANGE faah041 name="input.g.page1.faah041"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah042
            #add-point:BEFORE FIELD faah042 name="input.b.page1.faah042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah042
            
            #add-point:AFTER FIELD faah042 name="input.a.page1.faah042"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah042
            #add-point:ON CHANGE faah042 name="input.g.page1.faah042"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah043
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_faah_d[l_ac].faah043,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD faah043
            END IF 
 
 
 
            #add-point:AFTER FIELD faah043 name="input.a.page1.faah043"
            IF NOT cl_null(g_faah_d[l_ac].faah043) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah043
            #add-point:BEFORE FIELD faah043 name="input.b.page1.faah043"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah043
            #add-point:ON CHANGE faah043 name="input.g.page1.faah043"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah044
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_faah_d[l_ac].faah044,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD faah044
            END IF 
 
 
 
            #add-point:AFTER FIELD faah044 name="input.a.page1.faah044"
            IF NOT cl_null(g_faah_d[l_ac].faah044) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah044
            #add-point:BEFORE FIELD faah044 name="input.b.page1.faah044"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah044
            #add-point:ON CHANGE faah044 name="input.g.page1.faah044"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah045
            #add-point:BEFORE FIELD faah045 name="input.b.page1.faah045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah045
            
            #add-point:AFTER FIELD faah045 name="input.a.page1.faah045"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah045
            #add-point:ON CHANGE faah045 name="input.g.page1.faah045"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.faah000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah000
            #add-point:ON ACTION controlp INFIELD faah000 name="input.c.page1.faah000"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah001
            #add-point:ON ACTION controlp INFIELD faah001 name="input.c.page1.faah001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah003
            #add-point:ON ACTION controlp INFIELD faah003 name="input.c.page1.faah003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah004
            #add-point:ON ACTION controlp INFIELD faah004 name="input.c.page1.faah004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah002
            #add-point:ON ACTION controlp INFIELD faah002 name="input.c.page1.faah002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah005
            #add-point:ON ACTION controlp INFIELD faah005 name="input.c.page1.faah005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah006
            #add-point:ON ACTION controlp INFIELD faah006 name="input.c.page1.faah006"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_d[l_ac].faah006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_faac001()                                #呼叫開窗

            LET g_faah_d[l_ac].faah006 = g_qryparam.return1              

            DISPLAY g_faah_d[l_ac].faah006 TO faah006              #

            NEXT FIELD faah006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.faah007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah007
            #add-point:ON ACTION controlp INFIELD faah007 name="input.c.page1.faah007"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_d[l_ac].faah007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_faad001()                                #呼叫開窗

            LET g_faah_d[l_ac].faah007 = g_qryparam.return1              

            DISPLAY g_faah_d[l_ac].faah007 TO faah007              #

            NEXT FIELD faah007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.faah008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah008
            #add-point:ON ACTION controlp INFIELD faah008 name="input.c.page1.faah008"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_d[l_ac].faah008             #給予default值
            LET g_qryparam.default2 = "" #g_faah_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_faah_d[l_ac].faah008 = g_qryparam.return1              
            #LET g_faah_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_faah_d[l_ac].faah008 TO faah008              #
            #DISPLAY g_faah_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD faah008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.faah009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah009
            #add-point:ON ACTION controlp INFIELD faah009 name="input.c.page1.faah009"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_d[l_ac].faah009             #給予default值
            LET g_qryparam.default2 = "" #g_faah_d[l_ac].pmaal004 #交易對象簡稱
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pmaa001_10()                                #呼叫開窗

            LET g_faah_d[l_ac].faah009 = g_qryparam.return1              
            #LET g_faah_d[l_ac].pmaal004 = g_qryparam.return2 
            DISPLAY g_faah_d[l_ac].faah009 TO faah009              #
            #DISPLAY g_faah_d[l_ac].pmaal004 TO pmaal004 #交易對象簡稱
            NEXT FIELD faah009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.faah010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah010
            #add-point:ON ACTION controlp INFIELD faah010 name="input.c.page1.faah010"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_d[l_ac].faah010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pmaa001_4()                                #呼叫開窗

            LET g_faah_d[l_ac].faah010 = g_qryparam.return1              

            DISPLAY g_faah_d[l_ac].faah010 TO faah010              #

            NEXT FIELD faah010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.faah011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah011
            #add-point:ON ACTION controlp INFIELD faah011 name="input.c.page1.faah011"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_d[l_ac].faah011             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooce001()                                #呼叫開窗

            LET g_faah_d[l_ac].faah011 = g_qryparam.return1              

            DISPLAY g_faah_d[l_ac].faah011 TO faah011              #

            NEXT FIELD faah011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.faah012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah012
            #add-point:ON ACTION controlp INFIELD faah012 name="input.c.page1.faah012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah013
            #add-point:ON ACTION controlp INFIELD faah013 name="input.c.page1.faah013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah014
            #add-point:ON ACTION controlp INFIELD faah014 name="input.c.page1.faah014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah015
            #add-point:ON ACTION controlp INFIELD faah015 name="input.c.page1.faah015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah016
            #add-point:ON ACTION controlp INFIELD faah016 name="input.c.page1.faah016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah017
            #add-point:ON ACTION controlp INFIELD faah017 name="input.c.page1.faah017"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_d[l_ac].faah017             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooca001_1()                                #呼叫開窗

            LET g_faah_d[l_ac].faah017 = g_qryparam.return1              

            DISPLAY g_faah_d[l_ac].faah017 TO faah017              #

            NEXT FIELD faah017                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.faah018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah018
            #add-point:ON ACTION controlp INFIELD faah018 name="input.c.page1.faah018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah019
            #add-point:ON ACTION controlp INFIELD faah019 name="input.c.page1.faah019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah020
            #add-point:ON ACTION controlp INFIELD faah020 name="input.c.page1.faah020"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_d[l_ac].faah020             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_aooi001_1()                                #呼叫開窗

            LET g_faah_d[l_ac].faah020 = g_qryparam.return1              

            DISPLAY g_faah_d[l_ac].faah020 TO faah020              #

            NEXT FIELD faah020                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.faah021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah021
            #add-point:ON ACTION controlp INFIELD faah021 name="input.c.page1.faah021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah022
            #add-point:ON ACTION controlp INFIELD faah022 name="input.c.page1.faah022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah023
            #add-point:ON ACTION controlp INFIELD faah023 name="input.c.page1.faah023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah024
            #add-point:ON ACTION controlp INFIELD faah024 name="input.c.page1.faah024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah025
            #add-point:ON ACTION controlp INFIELD faah025 name="input.c.page1.faah025"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_d[l_ac].faah025             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001()                                #呼叫開窗

            LET g_faah_d[l_ac].faah025 = g_qryparam.return1              

            DISPLAY g_faah_d[l_ac].faah025 TO faah025              #

            NEXT FIELD faah025                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.faah026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah026
            #add-point:ON ACTION controlp INFIELD faah026 name="input.c.page1.faah026"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_d[l_ac].faah026             #給予default值
            LET g_qryparam.default2 = "" #g_faah_d[l_ac].ooefl003 #說明(簡稱)
            #給予arg
            
           # CALL q_ooef001()                                #呼叫開窗 #161024-00008#2 
            LET g_qryparam.arg1 = g_faah_d[l_ac].faah026            #161024-00008#2
            CALL q_ooeg001_4()                                      #161024-00008#2 

            LET g_faah_d[l_ac].faah026 = g_qryparam.return1              
            #LET g_faah_d[l_ac].ooefl003 = g_qryparam.return2 
            DISPLAY g_faah_d[l_ac].faah026 TO faah026              #
            #DISPLAY g_faah_d[l_ac].ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD faah026                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.faah027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah027
            #add-point:ON ACTION controlp INFIELD faah027 name="input.c.page1.faah027"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_d[l_ac].faah027             #給予default值
            LET g_qryparam.default2 = "" #g_faah_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_faah_d[l_ac].faah027 = g_qryparam.return1              
            #LET g_faah_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_faah_d[l_ac].faah027 TO faah027              #
            #DISPLAY g_faah_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD faah027                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.faah028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah028
            #add-point:ON ACTION controlp INFIELD faah028 name="input.c.page1.faah028"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_d[l_ac].faah028             #給予default值
            LET g_qryparam.default2 = "" #g_faah_d[l_ac].ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooef001()                                #呼叫開窗

            LET g_faah_d[l_ac].faah028 = g_qryparam.return1              
            #LET g_faah_d[l_ac].ooefl003 = g_qryparam.return2 
            DISPLAY g_faah_d[l_ac].faah028 TO faah028              #
            #DISPLAY g_faah_d[l_ac].ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD faah028                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.faah029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah029
            #add-point:ON ACTION controlp INFIELD faah029 name="input.c.page1.faah029"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_d[l_ac].faah029             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001()                                #呼叫開窗

            LET g_faah_d[l_ac].faah029 = g_qryparam.return1              

            DISPLAY g_faah_d[l_ac].faah029 TO faah029              #

            NEXT FIELD faah029                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.faah030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah030
            #add-point:ON ACTION controlp INFIELD faah030 name="input.c.page1.faah030"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_d[l_ac].faah030             #給予default值
            LET g_qryparam.default2 = "" #g_faah_d[l_ac].ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #

            
           # CALL q_ooef001()                                #呼叫開窗  #161024-00008#2 
            CALL q_ooef001_47()                                        #161024-00008#2 
            

            LET g_faah_d[l_ac].faah030 = g_qryparam.return1              
            #LET g_faah_d[l_ac].ooefl003 = g_qryparam.return2 
            DISPLAY g_faah_d[l_ac].faah030 TO faah030              #
            #DISPLAY g_faah_d[l_ac].ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD faah030                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.faah031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah031
            #add-point:ON ACTION controlp INFIELD faah031 name="input.c.page1.faah031"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_d[l_ac].faah031             #給予default值
            LET g_qryparam.default2 = "" #g_faah_d[l_ac].ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #

            LET g_qryparam.where = " ooef204 = 'Y' "        #161024-00008#2
            CALL q_ooef001()                                #呼叫開窗 


            LET g_faah_d[l_ac].faah031 = g_qryparam.return1              
            #LET g_faah_d[l_ac].ooefl003 = g_qryparam.return2 
            DISPLAY g_faah_d[l_ac].faah031 TO faah031              #
            #DISPLAY g_faah_d[l_ac].ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD faah031                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.faah032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah032
            #add-point:ON ACTION controlp INFIELD faah032 name="input.c.page1.faah032"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_d[l_ac].faah032             #給予default值
            LET g_qryparam.default2 = "" #g_faah_d[l_ac].ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            #CALL q_ooef001()                                #呼叫開窗  #161024-00008#2 
            CALL q_ooef001_2()                               #161024-00008#2 

            LET g_faah_d[l_ac].faah032 = g_qryparam.return1              
            #LET g_faah_d[l_ac].ooefl003 = g_qryparam.return2 
            DISPLAY g_faah_d[l_ac].faah032 TO faah032              #
            #DISPLAY g_faah_d[l_ac].ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD faah032                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.faah033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah033
            #add-point:ON ACTION controlp INFIELD faah033 name="input.c.page1.faah033"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah034
            #add-point:ON ACTION controlp INFIELD faah034 name="input.c.page1.faah034"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah035
            #add-point:ON ACTION controlp INFIELD faah035 name="input.c.page1.faah035"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah036
            #add-point:ON ACTION controlp INFIELD faah036 name="input.c.page1.faah036"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah037
            #add-point:ON ACTION controlp INFIELD faah037 name="input.c.page1.faah037"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah038
            #add-point:ON ACTION controlp INFIELD faah038 name="input.c.page1.faah038"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah039
            #add-point:ON ACTION controlp INFIELD faah039 name="input.c.page1.faah039"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah040
            #add-point:ON ACTION controlp INFIELD faah040 name="input.c.page1.faah040"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah041
            #add-point:ON ACTION controlp INFIELD faah041 name="input.c.page1.faah041"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah042
            #add-point:ON ACTION controlp INFIELD faah042 name="input.c.page1.faah042"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah043
            #add-point:ON ACTION controlp INFIELD faah043 name="input.c.page1.faah043"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah044
            #add-point:ON ACTION controlp INFIELD faah044 name="input.c.page1.faah044"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah045
            #add-point:ON ACTION controlp INFIELD faah045 name="input.c.page1.faah045"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_faah_d[l_ac].* = g_faah_d_t.*
               CLOSE afat300_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               CANCEL DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_faah_d[l_ac].faah000 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_faah_d[l_ac].* = g_faah_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身)
               LET g_faah2_d[l_ac].faahmodid = g_user 
LET g_faah2_d[l_ac].faahmoddt = cl_get_current()
LET g_faah2_d[l_ac].faahmodid_desc = cl_get_username(g_faah2_d[l_ac].faahmodid)
               
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL afat300_faah_t_mask_restore('restore_mask_o')
      
               UPDATE faah_t SET (faah000,faah001,faah003,faah004,faah002,faah005,faah006,faah007,faah008, 
                   faah009,faah010,faah011,faah012,faah013,faah014,faah015,faah016,faah017,faah018,faah019, 
                   faah020,faah021,faah022,faah023,faah024,faah025,faah026,faah027,faah028,faah029,faah030, 
                   faah031,faah032,faah033,faah034,faah035,faah036,faah037,faah038,faah039,faah040,faah041, 
                   faah042,faah043,faah044,faah045,faahownid,faahowndp,faahcrtid,faahcrtdp,faahcrtdt, 
                   faahmodid,faahmoddt) = (g_faah_d[l_ac].faah000,g_faah_d[l_ac].faah001,g_faah_d[l_ac].faah003, 
                   g_faah_d[l_ac].faah004,g_faah_d[l_ac].faah002,g_faah_d[l_ac].faah005,g_faah_d[l_ac].faah006, 
                   g_faah_d[l_ac].faah007,g_faah_d[l_ac].faah008,g_faah_d[l_ac].faah009,g_faah_d[l_ac].faah010, 
                   g_faah_d[l_ac].faah011,g_faah_d[l_ac].faah012,g_faah_d[l_ac].faah013,g_faah_d[l_ac].faah014, 
                   g_faah_d[l_ac].faah015,g_faah_d[l_ac].faah016,g_faah_d[l_ac].faah017,g_faah_d[l_ac].faah018, 
                   g_faah_d[l_ac].faah019,g_faah_d[l_ac].faah020,g_faah_d[l_ac].faah021,g_faah_d[l_ac].faah022, 
                   g_faah_d[l_ac].faah023,g_faah_d[l_ac].faah024,g_faah_d[l_ac].faah025,g_faah_d[l_ac].faah026, 
                   g_faah_d[l_ac].faah027,g_faah_d[l_ac].faah028,g_faah_d[l_ac].faah029,g_faah_d[l_ac].faah030, 
                   g_faah_d[l_ac].faah031,g_faah_d[l_ac].faah032,g_faah_d[l_ac].faah033,g_faah_d[l_ac].faah034, 
                   g_faah_d[l_ac].faah035,g_faah_d[l_ac].faah036,g_faah_d[l_ac].faah037,g_faah_d[l_ac].faah038, 
                   g_faah_d[l_ac].faah039,g_faah_d[l_ac].faah040,g_faah_d[l_ac].faah041,g_faah_d[l_ac].faah042, 
                   g_faah_d[l_ac].faah043,g_faah_d[l_ac].faah044,g_faah_d[l_ac].faah045,g_faah2_d[l_ac].faahownid, 
                   g_faah2_d[l_ac].faahowndp,g_faah2_d[l_ac].faahcrtid,g_faah2_d[l_ac].faahcrtdp,g_faah2_d[l_ac].faahcrtdt, 
                   g_faah2_d[l_ac].faahmodid,g_faah2_d[l_ac].faahmoddt)
                WHERE faahent = g_enterprise AND
                  faah000 = g_faah_d_t.faah000 #項次   
                  AND faah001 = g_faah_d_t.faah001  
                  AND faah003 = g_faah_d_t.faah003  
                  AND faah004 = g_faah_d_t.faah004  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     LET g_faah_d[l_ac].* = g_faah_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "faah_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_faah_d[l_ac].* = g_faah_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "faah_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_faah_d[g_detail_idx].faah000
               LET gs_keys_bak[1] = g_faah_d_t.faah000
               LET gs_keys[2] = g_faah_d[g_detail_idx].faah001
               LET gs_keys_bak[2] = g_faah_d_t.faah001
               LET gs_keys[3] = g_faah_d[g_detail_idx].faah003
               LET gs_keys_bak[3] = g_faah_d_t.faah003
               LET gs_keys[4] = g_faah_d[g_detail_idx].faah004
               LET gs_keys_bak[4] = g_faah_d_t.faah004
               CALL afat300_update_b('faah_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL afat300_faah_t_mask_restore('restore_mask_n')
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_faah_d_t)
                     LET g_log2 = util.JSON.stringify(g_faah_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #若Key欄位有變動
               LET g_master.* = g_faah_d[l_ac].*
               CALL afat300_key_update_b()
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL afat300_unlock_b("faah_t")
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_faah_d[l_ac].* = g_faah_d_t.*
               END IF
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               CANCEL DIALOG 
            END IF
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
            IF l_cmd = 'u' AND INT_FLAG THEN
               LET g_faah_d[l_ac].* = g_faah_d_t.*
            END IF
            LET l_cmd = ''
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()      
            #CALL cl_showmsg()            
    
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_faah_d[li_reproduce_target].* = g_faah_d[li_reproduce].*
               LET g_faah2_d[li_reproduce_target].* = g_faah2_d[li_reproduce].*
 
               LET g_faah_d[li_reproduce_target].faah000 = NULL
               LET g_faah_d[li_reproduce_target].faah001 = NULL
               LET g_faah_d[li_reproduce_target].faah003 = NULL
               LET g_faah_d[li_reproduce_target].faah004 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_faah_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_faah_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      #實際單身段落
      INPUT ARRAY g_faah3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #檢查上層單身是否有資料
            IF cl_null(g_faah_d[g_detail_idx].faah000) THEN
               NEXT FIELD faah000
            END IF
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_faah3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            LET g_loc = 'd'
            LET g_detail_cnt = g_faah3_d.getLength()
            LET g_current_page = 3
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
 
         BEFORE INSERT
            IF g_faah_d.getLength() = 0 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 'std-00013' 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               NEXT FIELD faah000
            END IF 
            #判斷能否在此頁面進行資料新增
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_faah3_d[l_ac].* TO NULL 
            INITIALIZE g_faah3_d_t.* TO NULL 
            INITIALIZE g_faah3_d_o.* TO NULL 
            
            #add-point:modify段before備份 name="input.body3.before_bak"
            
            #end add-point
            LET g_faah3_d_t.* = g_faah3_d[l_ac].*     #新輸入資料
            LET g_faah3_d_o.* = g_faah3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afat300_set_entry_b(l_cmd)
            CALL afat300_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_faah3_d[li_reproduce_target].* = g_faah3_d[li_reproduce].*
 
               LET g_faah3_d[li_reproduce_target].faaiseq = NULL
            END IF
            #add-point:input段before insert name="input.body3.before_insert"
            
            #end add-point  
            
         BEFORE ROW 
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET l_insert = FALSE
            LET g_detail_idx2 = l_ac
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            CALL s_transaction_begin()
            LET g_detail_cnt = g_faah3_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_faah3_d[l_ac].faaiseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_faah3_d_t.* = g_faah3_d[l_ac].*  #BACKUP
               LET g_faah3_d_o.* = g_faah3_d[l_ac].*  #BACKUP
               IF NOT afat300_lock_b("faai_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afat300_bcl2 INTO g_faah3_d[l_ac].faaiseq,g_faah3_d[l_ac].faai004,g_faah3_d[l_ac].faai005, 
                      g_faah3_d[l_ac].faai006,g_faah3_d[l_ac].faai007,g_faah3_d[l_ac].faai008,g_faah3_d[l_ac].faai009, 
                      g_faah3_d[l_ac].faai010,g_faah3_d[l_ac].faai011,g_faah3_d[l_ac].faai012,g_faah3_d[l_ac].faai013, 
                      g_faah3_d[l_ac].faai014,g_faah3_d[l_ac].faai015,g_faah3_d[l_ac].faai016,g_faah3_d[l_ac].faai017, 
                      g_faah3_d[l_ac].faai018,g_faah3_d[l_ac].faai019,g_faah3_d[l_ac].faai020,g_faah3_d[l_ac].faai021, 
                      g_faah3_d[l_ac].faai022,g_faah3_d[l_ac].faai023
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_faah3_d_mask_o[l_ac].* =  g_faah3_d[l_ac].*
                  CALL afat300_faai_t_mask()
                  LET g_faah3_d_mask_n[l_ac].* =  g_faah3_d[l_ac].*
                  
                  CALL cl_show_fld_cont()
                  #CALL afat300_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL afat300_set_entry_b(l_cmd)
            CALL afat300_set_no_entry_b(l_cmd)
            #add-point:input段before row name="input.body3.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            CALL afat300_idx_chk('d')
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body3.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body3.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code =  -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身3刪除前 name="input.body3.b_delete"
               
               #end add-point  
               
               DELETE FROM faai_t
                WHERE faaient = g_enterprise AND
                   faai000 = g_master.faah000
                   AND faai001 = g_master.faah001
                   AND faai002 = g_master.faah003
                   AND faai003 = g_master.faah004
                   AND faaiseq = g_faah3_d_t.faaiseq
                   
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point  
                   
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "faai_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
                  #add-point:單身3刪除後 name="input.body3.a_delete"
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE afat300_bcl
               LET l_count = g_faah_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_faah_d[g_detail_idx].faah000
               LET gs_keys[2] = g_faah_d[g_detail_idx].faah001
               LET gs_keys[3] = g_faah_d[g_detail_idx].faah003
               LET gs_keys[4] = g_faah_d[g_detail_idx].faah004
               LET gs_keys[5] = g_faah3_d_t.faaiseq
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body3.after_delete"
               
               #end add-point
                              CALL afat300_delete_b('faai_t',gs_keys,"'3'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_faah3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
    
         AFTER INSERT    
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
            LET l_insert = FALSE   
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM faai_t 
             WHERE faaient = g_enterprise AND
                   faai000 = g_master.faah000
                   AND faai001 = g_master.faah001
                   AND faai002 = g_master.faah003
                   AND faai003 = g_master.faah004
                   AND faaiseq = g_faah3_d[g_detail_idx2].faaiseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_faah_d[g_detail_idx].faah000
               LET gs_keys[2] = g_faah_d[g_detail_idx].faah001
               LET gs_keys[3] = g_faah_d[g_detail_idx].faah003
               LET gs_keys[4] = g_faah_d[g_detail_idx].faah004
               LET gs_keys[5] = g_faah3_d[g_detail_idx2].faaiseq
               CALL afat300_insert_b('faai_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_faah_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "faai_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afat300_b_fill(g_wc)
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body3.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_faah3_d[l_ac].* = g_faah3_d_t.*
               CLOSE afat300_bcl2
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               CANCEL DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_faah3_d[l_ac].* = g_faah3_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身3)
               
               
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL afat300_faai_t_mask_restore('restore_mask_o')
               
               UPDATE faai_t SET (faaiseq,faai004,faai005,faai006,faai007,faai008,faai009,faai010,faai011, 
                   faai012,faai013,faai014,faai015,faai016,faai017,faai018,faai019,faai020,faai021,faai022, 
                   faai023) = (g_faah3_d[l_ac].faaiseq,g_faah3_d[l_ac].faai004,g_faah3_d[l_ac].faai005, 
                   g_faah3_d[l_ac].faai006,g_faah3_d[l_ac].faai007,g_faah3_d[l_ac].faai008,g_faah3_d[l_ac].faai009, 
                   g_faah3_d[l_ac].faai010,g_faah3_d[l_ac].faai011,g_faah3_d[l_ac].faai012,g_faah3_d[l_ac].faai013, 
                   g_faah3_d[l_ac].faai014,g_faah3_d[l_ac].faai015,g_faah3_d[l_ac].faai016,g_faah3_d[l_ac].faai017, 
                   g_faah3_d[l_ac].faai018,g_faah3_d[l_ac].faai019,g_faah3_d[l_ac].faai020,g_faah3_d[l_ac].faai021, 
                   g_faah3_d[l_ac].faai022,g_faah3_d[l_ac].faai023) #自訂欄位頁簽
                WHERE faaient = g_enterprise AND
                   faai000 = g_master.faah000
                   AND faai001 = g_master.faah001
                   AND faai002 = g_master.faah003
                   AND faai003 = g_master.faah004
                   AND faaiseq = g_faah3_d_t.faaiseq
                   
               #add-point:單身修改中 name="input.body3.m_update"
               
               #end add-point
                   
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     LET g_faah3_d[l_ac].* = g_faah3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "faai_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_faah3_d[l_ac].* = g_faah3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "faai_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_faah_d[g_detail_idx].faah000
               LET gs_keys_bak[1] = g_faah_d[g_detail_idx].faah000
               LET gs_keys[2] = g_faah_d[g_detail_idx].faah001
               LET gs_keys_bak[2] = g_faah_d[g_detail_idx].faah001
               LET gs_keys[3] = g_faah_d[g_detail_idx].faah003
               LET gs_keys_bak[3] = g_faah_d[g_detail_idx].faah003
               LET gs_keys[4] = g_faah_d[g_detail_idx].faah004
               LET gs_keys_bak[4] = g_faah_d[g_detail_idx].faah004
               LET gs_keys[5] = g_faah3_d[g_detail_idx2].faaiseq
               LET gs_keys_bak[5] = g_faah3_d_t.faaiseq
               CALL afat300_update_b('faai_t',gs_keys,gs_keys_bak,"'3'")
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL afat300_faai_t_mask_restore('restore_mask_n')
                     #修改歷程記錄(下層修改)
                     LET g_log1 = util.JSON.stringify(g_faah3_d_t)
                     LET g_log2 = util.JSON.stringify(g_faah3_d[l_ac])
                     IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaiseq
            #add-point:BEFORE FIELD faaiseq name="input.b.page3.faaiseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaiseq
            
            #add-point:AFTER FIELD faaiseq name="input.a.page3.faaiseq"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_faah_d[g_detail_idx].faah000 IS NOT NULL AND g_faah_d[g_detail_idx].faah001 IS NOT NULL AND g_faah_d[g_detail_idx].faah003 IS NOT NULL AND g_faah_d[g_detail_idx].faah004 IS NOT NULL AND g_faah3_d[g_detail_idx2].faaiseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_faah_d[g_detail_idx].faah000 != g_faah_d[g_detail_idx].faah000 OR g_faah_d[g_detail_idx].faah001 != g_faah_d[g_detail_idx].faah001 OR g_faah_d[g_detail_idx].faah003 != g_faah_d[g_detail_idx].faah003 OR g_faah_d[g_detail_idx].faah004 != g_faah_d[g_detail_idx].faah004 OR g_faah3_d[g_detail_idx2].faaiseq != g_faah3_d_t.faaiseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faai_t WHERE "||"faaient = '" ||g_enterprise|| "' AND "||"faai000 = '"||g_faah_d[g_detail_idx].faah000 ||"' AND "|| "faai001 = '"||g_faah_d[g_detail_idx].faah001 ||"' AND "|| "faai002 = '"||g_faah_d[g_detail_idx].faah003 ||"' AND "|| "faai003 = '"||g_faah_d[g_detail_idx].faah004 ||"' AND "|| "faaiseq = '"||g_faah3_d[g_detail_idx2].faaiseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaiseq
            #add-point:ON CHANGE faaiseq name="input.g.page3.faaiseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai004
            #add-point:BEFORE FIELD faai004 name="input.b.page3.faai004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai004
            
            #add-point:AFTER FIELD faai004 name="input.a.page3.faai004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faai004
            #add-point:ON CHANGE faai004 name="input.g.page3.faai004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai005
            #add-point:BEFORE FIELD faai005 name="input.b.page3.faai005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai005
            
            #add-point:AFTER FIELD faai005 name="input.a.page3.faai005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faai005
            #add-point:ON CHANGE faai005 name="input.g.page3.faai005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai006
            #add-point:BEFORE FIELD faai006 name="input.b.page3.faai006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai006
            
            #add-point:AFTER FIELD faai006 name="input.a.page3.faai006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faai006
            #add-point:ON CHANGE faai006 name="input.g.page3.faai006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_faah3_d[l_ac].faai007,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD faai007
            END IF 
 
 
 
            #add-point:AFTER FIELD faai007 name="input.a.page3.faai007"
            IF NOT cl_null(g_faah3_d[l_ac].faai007) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai007
            #add-point:BEFORE FIELD faai007 name="input.b.page3.faai007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faai007
            #add-point:ON CHANGE faai007 name="input.g.page3.faai007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai008
            #add-point:BEFORE FIELD faai008 name="input.b.page3.faai008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai008
            
            #add-point:AFTER FIELD faai008 name="input.a.page3.faai008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faai008
            #add-point:ON CHANGE faai008 name="input.g.page3.faai008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai009
            
            #add-point:AFTER FIELD faai009 name="input.a.page3.faai009"
            IF NOT cl_null(g_faah3_d[l_ac].faai009) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah3_d[l_ac].faai009
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "apm-00044:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_2") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai009
            #add-point:BEFORE FIELD faai009 name="input.b.page3.faai009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faai009
            #add-point:ON CHANGE faai009 name="input.g.page3.faai009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai010
            
            #add-point:AFTER FIELD faai010 name="input.a.page3.faai010"
            IF NOT cl_null(g_faah3_d[l_ac].faai010) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah3_d[l_ac].faai010
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "apm-00044:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_2") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai010
            #add-point:BEFORE FIELD faai010 name="input.b.page3.faai010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faai010
            #add-point:ON CHANGE faai010 name="input.g.page3.faai010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai011
            #add-point:BEFORE FIELD faai011 name="input.b.page3.faai011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai011
            
            #add-point:AFTER FIELD faai011 name="input.a.page3.faai011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faai011
            #add-point:ON CHANGE faai011 name="input.g.page3.faai011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai012
            #add-point:BEFORE FIELD faai012 name="input.b.page3.faai012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai012
            
            #add-point:AFTER FIELD faai012 name="input.a.page3.faai012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faai012
            #add-point:ON CHANGE faai012 name="input.g.page3.faai012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai013
            #add-point:BEFORE FIELD faai013 name="input.b.page3.faai013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai013
            
            #add-point:AFTER FIELD faai013 name="input.a.page3.faai013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faai013
            #add-point:ON CHANGE faai013 name="input.g.page3.faai013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai014
            #add-point:BEFORE FIELD faai014 name="input.b.page3.faai014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai014
            
            #add-point:AFTER FIELD faai014 name="input.a.page3.faai014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faai014
            #add-point:ON CHANGE faai014 name="input.g.page3.faai014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai015
            
            #add-point:AFTER FIELD faai015 name="input.a.page3.faai015"
            IF NOT cl_null(g_faah3_d[l_ac].faai015) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah3_d[l_ac].faai015
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai015
            #add-point:BEFORE FIELD faai015 name="input.b.page3.faai015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faai015
            #add-point:ON CHANGE faai015 name="input.g.page3.faai015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai016
            
            #add-point:AFTER FIELD faai016 name="input.a.page3.faai016"
            IF NOT cl_null(g_faah3_d[l_ac].faai016) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah3_d[l_ac].faai016
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai016
            #add-point:BEFORE FIELD faai016 name="input.b.page3.faai016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faai016
            #add-point:ON CHANGE faai016 name="input.g.page3.faai016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai017
            
            #add-point:AFTER FIELD faai017 name="input.a.page3.faai017"
            IF NOT cl_null(g_faah3_d[l_ac].faai017) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah3_d[l_ac].faai017

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_3900") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai017
            #add-point:BEFORE FIELD faai017 name="input.b.page3.faai017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faai017
            #add-point:ON CHANGE faai017 name="input.g.page3.faai017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai018
            
            #add-point:AFTER FIELD faai018 name="input.a.page3.faai018"
            IF NOT cl_null(g_faah3_d[l_ac].faai018) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah3_d[l_ac].faai018
               LET g_chkparam.arg2 = '參數2'
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_faab002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai018
            #add-point:BEFORE FIELD faai018 name="input.b.page3.faai018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faai018
            #add-point:ON CHANGE faai018 name="input.g.page3.faai018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai019
            
            #add-point:AFTER FIELD faai019 name="input.a.page3.faai019"
            IF NOT cl_null(g_faah3_d[l_ac].faai019) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah3_d[l_ac].faai019
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai019
            #add-point:BEFORE FIELD faai019 name="input.b.page3.faai019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faai019
            #add-point:ON CHANGE faai019 name="input.g.page3.faai019"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai020
            
            #add-point:AFTER FIELD faai020 name="input.a.page3.faai020"
            IF NOT cl_null(g_faah3_d[l_ac].faai020) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah3_d[l_ac].faai020
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai020
            #add-point:BEFORE FIELD faai020 name="input.b.page3.faai020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faai020
            #add-point:ON CHANGE faai020 name="input.g.page3.faai020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai021
            
            #add-point:AFTER FIELD faai021 name="input.a.page3.faai021"
            IF NOT cl_null(g_faah3_d[l_ac].faai021) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah3_d[l_ac].faai021
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai021
            #add-point:BEFORE FIELD faai021 name="input.b.page3.faai021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faai021
            #add-point:ON CHANGE faai021 name="input.g.page3.faai021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai022
            
            #add-point:AFTER FIELD faai022 name="input.a.page3.faai022"
            IF NOT cl_null(g_faah3_d[l_ac].faai022) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah3_d[l_ac].faai022
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai022
            #add-point:BEFORE FIELD faai022 name="input.b.page3.faai022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faai022
            #add-point:ON CHANGE faai022 name="input.g.page3.faai022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faai023
            #add-point:BEFORE FIELD faai023 name="input.b.page3.faai023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faai023
            
            #add-point:AFTER FIELD faai023 name="input.a.page3.faai023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faai023
            #add-point:ON CHANGE faai023 name="input.g.page3.faai023"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.faaiseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaiseq
            #add-point:ON ACTION controlp INFIELD faaiseq name="input.c.page3.faaiseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.faai004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai004
            #add-point:ON ACTION controlp INFIELD faai004 name="input.c.page3.faai004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.faai005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai005
            #add-point:ON ACTION controlp INFIELD faai005 name="input.c.page3.faai005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.faai006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai006
            #add-point:ON ACTION controlp INFIELD faai006 name="input.c.page3.faai006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.faai007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai007
            #add-point:ON ACTION controlp INFIELD faai007 name="input.c.page3.faai007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.faai008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai008
            #add-point:ON ACTION controlp INFIELD faai008 name="input.c.page3.faai008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.faai009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai009
            #add-point:ON ACTION controlp INFIELD faai009 name="input.c.page3.faai009"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah3_d[l_ac].faai009             #給予default值
            LET g_qryparam.default2 = "" #g_faah3_d[l_ac].pmaal004 #交易對象簡稱
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pmaa001_10()                                #呼叫開窗

            LET g_faah3_d[l_ac].faai009 = g_qryparam.return1              
            #LET g_faah3_d[l_ac].pmaal004 = g_qryparam.return2 
            DISPLAY g_faah3_d[l_ac].faai009 TO faai009              #
            #DISPLAY g_faah3_d[l_ac].pmaal004 TO pmaal004 #交易對象簡稱
            NEXT FIELD faai009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.faai010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai010
            #add-point:ON ACTION controlp INFIELD faai010 name="input.c.page3.faai010"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah3_d[l_ac].faai010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pmaa001_5()                                #呼叫開窗

            LET g_faah3_d[l_ac].faai010 = g_qryparam.return1              

            DISPLAY g_faah3_d[l_ac].faai010 TO faai010              #

            NEXT FIELD faai010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.faai011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai011
            #add-point:ON ACTION controlp INFIELD faai011 name="input.c.page3.faai011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.faai012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai012
            #add-point:ON ACTION controlp INFIELD faai012 name="input.c.page3.faai012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.faai013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai013
            #add-point:ON ACTION controlp INFIELD faai013 name="input.c.page3.faai013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.faai014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai014
            #add-point:ON ACTION controlp INFIELD faai014 name="input.c.page3.faai014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.faai015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai015
            #add-point:ON ACTION controlp INFIELD faai015 name="input.c.page3.faai015"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah3_d[l_ac].faai015             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001()                                #呼叫開窗

            LET g_faah3_d[l_ac].faai015 = g_qryparam.return1              

            DISPLAY g_faah3_d[l_ac].faai015 TO faai015              #

            NEXT FIELD faai015                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.faai016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai016
            #add-point:ON ACTION controlp INFIELD faai016 name="input.c.page3.faai016"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah3_d[l_ac].faai016             #給予default值
            LET g_qryparam.default2 = "" #g_faah3_d[l_ac].ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooef001()                                #呼叫開窗

            LET g_faah3_d[l_ac].faai016 = g_qryparam.return1              
            #LET g_faah3_d[l_ac].ooefl003 = g_qryparam.return2 
            DISPLAY g_faah3_d[l_ac].faai016 TO faai016              #
            #DISPLAY g_faah3_d[l_ac].ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD faai016                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.faai017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai017
            #add-point:ON ACTION controlp INFIELD faai017 name="input.c.page3.faai017"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah3_d[l_ac].faai017             #給予default值
            LET g_qryparam.default2 = "" #g_faah3_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_faah3_d[l_ac].faai017 = g_qryparam.return1              
            #LET g_faah3_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_faah3_d[l_ac].faai017 TO faai017              #
            #DISPLAY g_faah3_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD faai017                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.faai018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai018
            #add-point:ON ACTION controlp INFIELD faai018 name="input.c.page3.faai018"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah3_d[l_ac].faai018             #給予default值
            LET g_qryparam.default2 = "" #g_faah3_d[l_ac].ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooef001()                                #呼叫開窗

            LET g_faah3_d[l_ac].faai018 = g_qryparam.return1              
            #LET g_faah3_d[l_ac].ooefl003 = g_qryparam.return2 
            DISPLAY g_faah3_d[l_ac].faai018 TO faai018              #
            #DISPLAY g_faah3_d[l_ac].ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD faai018                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.faai019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai019
            #add-point:ON ACTION controlp INFIELD faai019 name="input.c.page3.faai019"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah3_d[l_ac].faai019             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001()                                #呼叫開窗

            LET g_faah3_d[l_ac].faai019 = g_qryparam.return1              

            DISPLAY g_faah3_d[l_ac].faai019 TO faai019              #

            NEXT FIELD faai019                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.faai020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai020
            #add-point:ON ACTION controlp INFIELD faai020 name="input.c.page3.faai020"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah3_d[l_ac].faai020             #給予default值
            LET g_qryparam.default2 = "" #g_faah3_d[l_ac].ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooef001()                                #呼叫開窗

            LET g_faah3_d[l_ac].faai020 = g_qryparam.return1              
            #LET g_faah3_d[l_ac].ooefl003 = g_qryparam.return2 
            DISPLAY g_faah3_d[l_ac].faai020 TO faai020              #
            #DISPLAY g_faah3_d[l_ac].ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD faai020                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.faai021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai021
            #add-point:ON ACTION controlp INFIELD faai021 name="input.c.page3.faai021"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah3_d[l_ac].faai021             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooef001_04()                                #呼叫開窗

            LET g_faah3_d[l_ac].faai021 = g_qryparam.return1              

            DISPLAY g_faah3_d[l_ac].faai021 TO faai021              #

            NEXT FIELD faai021                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.faai022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai022
            #add-point:ON ACTION controlp INFIELD faai022 name="input.c.page3.faai022"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah3_d[l_ac].faai022             #給予default值
            LET g_qryparam.default2 = "" #g_faah3_d[l_ac].ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooef001()                                #呼叫開窗

            LET g_faah3_d[l_ac].faai022 = g_qryparam.return1              
            #LET g_faah3_d[l_ac].ooefl003 = g_qryparam.return2 
            DISPLAY g_faah3_d[l_ac].faai022 TO faai022              #
            #DISPLAY g_faah3_d[l_ac].ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD faai022                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.faai023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faai023
            #add-point:ON ACTION controlp INFIELD faai023 name="input.c.page3.faai023"
            
            #END add-point
 
 
 
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_faah3_d[l_ac].* = g_faah3_d_t.*
               END IF
               CLOSE afat300_bcl2
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               CANCEL DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL afat300_unlock_b("faai_t")
            CALL s_transaction_end('Y','0')
            LET l_cmd = ''
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point   
 
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_faah3_d[li_reproduce_target].* = g_faah3_d[li_reproduce].*
 
               LET g_faah3_d[li_reproduce_target].faaiseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_faah3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_faah3_d.getLength()+1
            END IF
 
      END INPUT
      #實際單身段落
      INPUT ARRAY g_faah4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_4)
         
         
         BEFORE INPUT
            #檢查上層單身是否有資料
            IF cl_null(g_faah_d[g_detail_idx].faah000) THEN
               NEXT FIELD faah000
            END IF
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_faah4_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            LET g_loc = 'd'
            LET g_detail_cnt = g_faah4_d.getLength()
            LET g_current_page = 4
            #add-point:資料輸入前 name="input.body4.before_input"
            
            #end add-point
 
         BEFORE INSERT
            IF g_faah_d.getLength() = 0 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 'std-00013' 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               NEXT FIELD faah000
            END IF 
            #判斷能否在此頁面進行資料新增
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_faah4_d[l_ac].* TO NULL 
            INITIALIZE g_faah4_d_t.* TO NULL 
            INITIALIZE g_faah4_d_o.* TO NULL 
                  LET g_faah4_d[l_ac].faaj011 = "N"
      LET g_faah4_d[l_ac].faaj016 = "0"
      LET g_faah4_d[l_ac].faaj017 = "0"
      LET g_faah4_d[l_ac].faaj018 = "0"
      LET g_faah4_d[l_ac].faaj019 = "0"
      LET g_faah4_d[l_ac].faaj020 = "0"
      LET g_faah4_d[l_ac].faaj021 = "0"
      LET g_faah4_d[l_ac].faaj022 = "0"
      LET g_faah4_d[l_ac].faaj027 = "0"
      LET g_faah4_d[l_ac].faaj028 = "0"
      LET g_faah4_d[l_ac].faaj029 = "0"
      LET g_faah4_d[l_ac].faaj032 = "0"
      LET g_faah4_d[l_ac].faaj033 = "0"
      LET g_faah4_d[l_ac].faaj034 = "0"
      LET g_faah4_d[l_ac].faaj035 = "0"
      LET g_faah4_d[l_ac].faaj103 = "0"
      LET g_faah4_d[l_ac].faaj104 = "0"
      LET g_faah4_d[l_ac].faaj105 = "0"
      LET g_faah4_d[l_ac].faaj106 = "0"
      LET g_faah4_d[l_ac].faaj107 = "0"
      LET g_faah4_d[l_ac].faaj108 = "0"
      LET g_faah4_d[l_ac].faaj109 = "0"
      LET g_faah4_d[l_ac].faaj110 = "0"
      LET g_faah4_d[l_ac].faaj111 = "0"
      LET g_faah4_d[l_ac].faaj112 = "0"
      LET g_faah4_d[l_ac].faaj113 = "0"
      LET g_faah4_d[l_ac].faaj114 = "0"
      LET g_faah4_d[l_ac].faaj115 = "0"
      LET g_faah4_d[l_ac].faaj116 = "0"
      LET g_faah4_d[l_ac].faaj117 = "0"
      LET g_faah4_d[l_ac].faaj153 = "0"
      LET g_faah4_d[l_ac].faaj154 = "0"
      LET g_faah4_d[l_ac].faaj155 = "0"
      LET g_faah4_d[l_ac].faaj156 = "0"
      LET g_faah4_d[l_ac].faaj157 = "0"
      LET g_faah4_d[l_ac].faaj158 = "0"
      LET g_faah4_d[l_ac].faaj159 = "0"
      LET g_faah4_d[l_ac].faaj160 = "0"
      LET g_faah4_d[l_ac].faaj161 = "0"
      LET g_faah4_d[l_ac].faaj162 = "0"
      LET g_faah4_d[l_ac].faaj163 = "0"
      LET g_faah4_d[l_ac].faaj164 = "0"
      LET g_faah4_d[l_ac].faaj165 = "0"
      LET g_faah4_d[l_ac].faaj166 = "0"
      LET g_faah4_d[l_ac].faaj167 = "0"
 
            #add-point:modify段before備份 name="input.body4.before_bak"
            
            #end add-point
            LET g_faah4_d_t.* = g_faah4_d[l_ac].*     #新輸入資料
            LET g_faah4_d_o.* = g_faah4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afat300_set_entry_b(l_cmd)
            CALL afat300_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_faah4_d[li_reproduce_target].* = g_faah4_d[li_reproduce].*
 
               LET g_faah4_d[li_reproduce_target].faajld = NULL
            END IF
            #add-point:input段before insert name="input.body4.before_insert"
            
            #end add-point  
            
         BEFORE ROW 
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET l_insert = FALSE
            LET g_detail_idx2 = l_ac
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            CALL s_transaction_begin()
            LET g_detail_cnt = g_faah4_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_faah4_d[l_ac].faajld IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_faah4_d_t.* = g_faah4_d[l_ac].*  #BACKUP
               LET g_faah4_d_o.* = g_faah4_d[l_ac].*  #BACKUP
               IF NOT afat300_lock_b("faaj_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afat300_bcl3 INTO g_faah4_d[l_ac].faajld,g_faah4_d[l_ac].faaj003,g_faah4_d[l_ac].faaj004, 
                      g_faah4_d[l_ac].faaj005,g_faah4_d[l_ac].faaj006,g_faah4_d[l_ac].faaj007,g_faah4_d[l_ac].faaj008, 
                      g_faah4_d[l_ac].faaj009,g_faah4_d[l_ac].faaj010,g_faah4_d[l_ac].faaj011,g_faah4_d[l_ac].faaj012, 
                      g_faah4_d[l_ac].faaj013,g_faah4_d[l_ac].faaj014,g_faah4_d[l_ac].faaj015,g_faah4_d[l_ac].faaj016, 
                      g_faah4_d[l_ac].faaj017,g_faah4_d[l_ac].faaj018,g_faah4_d[l_ac].faaj019,g_faah4_d[l_ac].faaj020, 
                      g_faah4_d[l_ac].faaj021,g_faah4_d[l_ac].faaj022,g_faah4_d[l_ac].faaj023,g_faah4_d[l_ac].faaj024, 
                      g_faah4_d[l_ac].faaj025,g_faah4_d[l_ac].faaj026,g_faah4_d[l_ac].faaj027,g_faah4_d[l_ac].faaj028, 
                      g_faah4_d[l_ac].faaj029,g_faah4_d[l_ac].faaj030,g_faah4_d[l_ac].faaj031,g_faah4_d[l_ac].faaj032, 
                      g_faah4_d[l_ac].faaj033,g_faah4_d[l_ac].faaj034,g_faah4_d[l_ac].faaj035,g_faah4_d[l_ac].faaj036, 
                      g_faah4_d[l_ac].faaj038,g_faah4_d[l_ac].faaj039,g_faah4_d[l_ac].faaj040,g_faah4_d[l_ac].faaj041, 
                      g_faah4_d[l_ac].faaj042,g_faah4_d[l_ac].faaj043,g_faah4_d[l_ac].faaj044,g_faah4_d[l_ac].faaj045, 
                      g_faah4_d[l_ac].faaj046,g_faah4_d[l_ac].faaj047,g_faah4_d[l_ac].faaj101,g_faah4_d[l_ac].faaj102, 
                      g_faah4_d[l_ac].faaj103,g_faah4_d[l_ac].faaj104,g_faah4_d[l_ac].faaj105,g_faah4_d[l_ac].faaj106, 
                      g_faah4_d[l_ac].faaj107,g_faah4_d[l_ac].faaj108,g_faah4_d[l_ac].faaj109,g_faah4_d[l_ac].faaj110, 
                      g_faah4_d[l_ac].faaj111,g_faah4_d[l_ac].faaj112,g_faah4_d[l_ac].faaj113,g_faah4_d[l_ac].faaj114, 
                      g_faah4_d[l_ac].faaj115,g_faah4_d[l_ac].faaj116,g_faah4_d[l_ac].faaj117,g_faah4_d[l_ac].faaj151, 
                      g_faah4_d[l_ac].faaj152,g_faah4_d[l_ac].faaj153,g_faah4_d[l_ac].faaj154,g_faah4_d[l_ac].faaj155, 
                      g_faah4_d[l_ac].faaj156,g_faah4_d[l_ac].faaj157,g_faah4_d[l_ac].faaj158,g_faah4_d[l_ac].faaj159, 
                      g_faah4_d[l_ac].faaj160,g_faah4_d[l_ac].faaj161,g_faah4_d[l_ac].faaj162,g_faah4_d[l_ac].faaj163, 
                      g_faah4_d[l_ac].faaj164,g_faah4_d[l_ac].faaj165,g_faah4_d[l_ac].faaj166,g_faah4_d[l_ac].faaj167, 
                      g_faah4_d[l_ac].faajsite
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_faah4_d_mask_o[l_ac].* =  g_faah4_d[l_ac].*
                  CALL afat300_faaj_t_mask()
                  LET g_faah4_d_mask_n[l_ac].* =  g_faah4_d[l_ac].*
                  
                  CALL cl_show_fld_cont()
                  #CALL afat300_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL afat300_set_entry_b(l_cmd)
            CALL afat300_set_no_entry_b(l_cmd)
            #add-point:input段before row name="input.body4.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            CALL afat300_idx_chk('d')
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body4.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body4.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code =  -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身4刪除前 name="input.body4.b_delete"
               
               #end add-point  
               
               DELETE FROM faaj_t
                WHERE faajent = g_enterprise AND
                   faaj000 = g_master.faah000
                   AND faaj037 = g_master.faah001
                   AND faaj001 = g_master.faah003
                   AND faaj002 = g_master.faah004
                   AND faajld = g_faah4_d_t.faajld
                   
               #add-point:單身4刪除中 name="input.body4.m_delete"
               
               #end add-point  
                   
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "faaj_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
                  #add-point:單身4刪除後 name="input.body4.a_delete"
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE afat300_bcl
               LET l_count = g_faah_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_faah_d[g_detail_idx].faah000
               LET gs_keys[2] = g_faah_d[g_detail_idx].faah001
               LET gs_keys[3] = g_faah_d[g_detail_idx].faah003
               LET gs_keys[4] = g_faah_d[g_detail_idx].faah004
               LET gs_keys[5] = g_faah4_d_t.faajld
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body4.after_delete"
               
               #end add-point
                              CALL afat300_delete_b('faaj_t',gs_keys,"'4'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_faah4_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
    
         AFTER INSERT    
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
            LET l_insert = FALSE   
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM faaj_t 
             WHERE faajent = g_enterprise AND
                   faaj000 = g_master.faah000
                   AND faaj037 = g_master.faah001
                   AND faaj001 = g_master.faah003
                   AND faaj002 = g_master.faah004
                   AND faajld = g_faah4_d[g_detail_idx2].faajld
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身4新增前 name="input.body4.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_faah_d[g_detail_idx].faah000
               LET gs_keys[2] = g_faah_d[g_detail_idx].faah001
               LET gs_keys[3] = g_faah_d[g_detail_idx].faah003
               LET gs_keys[4] = g_faah_d[g_detail_idx].faah004
               LET gs_keys[5] = g_faah4_d[g_detail_idx2].faajld
               CALL afat300_insert_b('faaj_t',gs_keys,"'4'")
                           
               #add-point:單身新增後4 name="input.body4.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_faah_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "faaj_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afat300_b_fill(g_wc)
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body4.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_faah4_d[l_ac].* = g_faah4_d_t.*
               CLOSE afat300_bcl3
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               CANCEL DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_faah4_d[l_ac].* = g_faah4_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身4)
               
               
               #add-point:單身page4修改前 name="input.body4.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL afat300_faaj_t_mask_restore('restore_mask_o')
               
               UPDATE faaj_t SET (faajld,faaj003,faaj004,faaj005,faaj006,faaj007,faaj008,faaj009,faaj010, 
                   faaj011,faaj012,faaj013,faaj014,faaj015,faaj016,faaj017,faaj018,faaj019,faaj020,faaj021, 
                   faaj022,faaj023,faaj024,faaj025,faaj026,faaj027,faaj028,faaj029,faaj030,faaj031,faaj032, 
                   faaj033,faaj034,faaj035,faaj036,faaj038,faaj039,faaj040,faaj041,faaj042,faaj043,faaj044, 
                   faaj045,faaj046,faaj047,faaj101,faaj102,faaj103,faaj104,faaj105,faaj106,faaj107,faaj108, 
                   faaj109,faaj110,faaj111,faaj112,faaj113,faaj114,faaj115,faaj116,faaj117,faaj151,faaj152, 
                   faaj153,faaj154,faaj155,faaj156,faaj157,faaj158,faaj159,faaj160,faaj161,faaj162,faaj163, 
                   faaj164,faaj165,faaj166,faaj167,faajsite) = (g_faah4_d[l_ac].faajld,g_faah4_d[l_ac].faaj003, 
                   g_faah4_d[l_ac].faaj004,g_faah4_d[l_ac].faaj005,g_faah4_d[l_ac].faaj006,g_faah4_d[l_ac].faaj007, 
                   g_faah4_d[l_ac].faaj008,g_faah4_d[l_ac].faaj009,g_faah4_d[l_ac].faaj010,g_faah4_d[l_ac].faaj011, 
                   g_faah4_d[l_ac].faaj012,g_faah4_d[l_ac].faaj013,g_faah4_d[l_ac].faaj014,g_faah4_d[l_ac].faaj015, 
                   g_faah4_d[l_ac].faaj016,g_faah4_d[l_ac].faaj017,g_faah4_d[l_ac].faaj018,g_faah4_d[l_ac].faaj019, 
                   g_faah4_d[l_ac].faaj020,g_faah4_d[l_ac].faaj021,g_faah4_d[l_ac].faaj022,g_faah4_d[l_ac].faaj023, 
                   g_faah4_d[l_ac].faaj024,g_faah4_d[l_ac].faaj025,g_faah4_d[l_ac].faaj026,g_faah4_d[l_ac].faaj027, 
                   g_faah4_d[l_ac].faaj028,g_faah4_d[l_ac].faaj029,g_faah4_d[l_ac].faaj030,g_faah4_d[l_ac].faaj031, 
                   g_faah4_d[l_ac].faaj032,g_faah4_d[l_ac].faaj033,g_faah4_d[l_ac].faaj034,g_faah4_d[l_ac].faaj035, 
                   g_faah4_d[l_ac].faaj036,g_faah4_d[l_ac].faaj038,g_faah4_d[l_ac].faaj039,g_faah4_d[l_ac].faaj040, 
                   g_faah4_d[l_ac].faaj041,g_faah4_d[l_ac].faaj042,g_faah4_d[l_ac].faaj043,g_faah4_d[l_ac].faaj044, 
                   g_faah4_d[l_ac].faaj045,g_faah4_d[l_ac].faaj046,g_faah4_d[l_ac].faaj047,g_faah4_d[l_ac].faaj101, 
                   g_faah4_d[l_ac].faaj102,g_faah4_d[l_ac].faaj103,g_faah4_d[l_ac].faaj104,g_faah4_d[l_ac].faaj105, 
                   g_faah4_d[l_ac].faaj106,g_faah4_d[l_ac].faaj107,g_faah4_d[l_ac].faaj108,g_faah4_d[l_ac].faaj109, 
                   g_faah4_d[l_ac].faaj110,g_faah4_d[l_ac].faaj111,g_faah4_d[l_ac].faaj112,g_faah4_d[l_ac].faaj113, 
                   g_faah4_d[l_ac].faaj114,g_faah4_d[l_ac].faaj115,g_faah4_d[l_ac].faaj116,g_faah4_d[l_ac].faaj117, 
                   g_faah4_d[l_ac].faaj151,g_faah4_d[l_ac].faaj152,g_faah4_d[l_ac].faaj153,g_faah4_d[l_ac].faaj154, 
                   g_faah4_d[l_ac].faaj155,g_faah4_d[l_ac].faaj156,g_faah4_d[l_ac].faaj157,g_faah4_d[l_ac].faaj158, 
                   g_faah4_d[l_ac].faaj159,g_faah4_d[l_ac].faaj160,g_faah4_d[l_ac].faaj161,g_faah4_d[l_ac].faaj162, 
                   g_faah4_d[l_ac].faaj163,g_faah4_d[l_ac].faaj164,g_faah4_d[l_ac].faaj165,g_faah4_d[l_ac].faaj166, 
                   g_faah4_d[l_ac].faaj167,g_faah4_d[l_ac].faajsite) #自訂欄位頁簽
                WHERE faajent = g_enterprise AND
                   faaj000 = g_master.faah000
                   AND faaj037 = g_master.faah001
                   AND faaj001 = g_master.faah003
                   AND faaj002 = g_master.faah004
                   AND faajld = g_faah4_d_t.faajld
                   
               #add-point:單身修改中 name="input.body4.m_update"
               
               #end add-point
                   
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     LET g_faah4_d[l_ac].* = g_faah4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "faaj_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_faah4_d[l_ac].* = g_faah4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "faaj_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_faah_d[g_detail_idx].faah000
               LET gs_keys_bak[1] = g_faah_d[g_detail_idx].faah000
               LET gs_keys[2] = g_faah_d[g_detail_idx].faah001
               LET gs_keys_bak[2] = g_faah_d[g_detail_idx].faah001
               LET gs_keys[3] = g_faah_d[g_detail_idx].faah003
               LET gs_keys_bak[3] = g_faah_d[g_detail_idx].faah003
               LET gs_keys[4] = g_faah_d[g_detail_idx].faah004
               LET gs_keys_bak[4] = g_faah_d[g_detail_idx].faah004
               LET gs_keys[5] = g_faah4_d[g_detail_idx2].faajld
               LET gs_keys_bak[5] = g_faah4_d_t.faajld
               CALL afat300_update_b('faaj_t',gs_keys,gs_keys_bak,"'4'")
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL afat300_faaj_t_mask_restore('restore_mask_n')
                     #修改歷程記錄(下層修改)
                     LET g_log1 = util.JSON.stringify(g_faah4_d_t)
                     LET g_log2 = util.JSON.stringify(g_faah4_d[l_ac])
                     IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               #add-point:單身page4修改後 name="input.body4.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faajld
            
            #add-point:AFTER FIELD faajld name="input.a.page4.faajld"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_faah_d[g_detail_idx].faah000 IS NOT NULL AND g_faah_d[g_detail_idx].faah001 IS NOT NULL AND g_faah_d[g_detail_idx].faah003 IS NOT NULL AND g_faah_d[g_detail_idx].faah004 IS NOT NULL AND g_faah4_d[g_detail_idx2].faajld IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_faah_d[g_detail_idx].faah000 != g_faah_d[g_detail_idx].faah000 OR g_faah_d[g_detail_idx].faah001 != g_faah_d[g_detail_idx].faah001 OR g_faah_d[g_detail_idx].faah003 != g_faah_d[g_detail_idx].faah003 OR g_faah_d[g_detail_idx].faah004 != g_faah_d[g_detail_idx].faah004 OR g_faah4_d[g_detail_idx2].faajld != g_faah4_d_t.faajld)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faaj_t WHERE "||"faajent = '" ||g_enterprise|| "' AND "||"faaj000 = '"||g_faah_d[g_detail_idx].faah000 ||"' AND "|| "faaj001 = '"||g_faah_d[g_detail_idx].faah001 ||"' AND "|| "faaj002 = '"||g_faah_d[g_detail_idx].faah003 ||"' AND "|| "faaj037 = '"||g_faah_d[g_detail_idx].faah004 ||"' AND "|| "faajld = '"||g_faah4_d[g_detail_idx2].faajld ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            IF NOT cl_null(g_faah4_d[l_ac].faajld) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah4_d[l_ac].faajld
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glaald") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah4_d[l_ac].faajld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faah4_d[l_ac].faajld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faah4_d[l_ac].faajld_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faajld
            #add-point:BEFORE FIELD faajld name="input.b.page4.faajld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faajld
            #add-point:ON CHANGE faajld name="input.g.page4.faajld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj003
            #add-point:BEFORE FIELD faaj003 name="input.b.page4.faaj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj003
            
            #add-point:AFTER FIELD faaj003 name="input.a.page4.faaj003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj003
            #add-point:ON CHANGE faaj003 name="input.g.page4.faaj003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj004
            #add-point:BEFORE FIELD faaj004 name="input.b.page4.faaj004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj004
            
            #add-point:AFTER FIELD faaj004 name="input.a.page4.faaj004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj004
            #add-point:ON CHANGE faaj004 name="input.g.page4.faaj004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj005
            #add-point:BEFORE FIELD faaj005 name="input.b.page4.faaj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj005
            
            #add-point:AFTER FIELD faaj005 name="input.a.page4.faaj005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj005
            #add-point:ON CHANGE faaj005 name="input.g.page4.faaj005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj006
            #add-point:BEFORE FIELD faaj006 name="input.b.page4.faaj006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj006
            
            #add-point:AFTER FIELD faaj006 name="input.a.page4.faaj006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj006
            #add-point:ON CHANGE faaj006 name="input.g.page4.faaj006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj007
            #add-point:BEFORE FIELD faaj007 name="input.b.page4.faaj007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj007
            
            #add-point:AFTER FIELD faaj007 name="input.a.page4.faaj007"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj007
            #add-point:ON CHANGE faaj007 name="input.g.page4.faaj007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj008
            #add-point:BEFORE FIELD faaj008 name="input.b.page4.faaj008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj008
            
            #add-point:AFTER FIELD faaj008 name="input.a.page4.faaj008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj008
            #add-point:ON CHANGE faaj008 name="input.g.page4.faaj008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj009
            #add-point:BEFORE FIELD faaj009 name="input.b.page4.faaj009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj009
            
            #add-point:AFTER FIELD faaj009 name="input.a.page4.faaj009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj009
            #add-point:ON CHANGE faaj009 name="input.g.page4.faaj009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj010
            #add-point:BEFORE FIELD faaj010 name="input.b.page4.faaj010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj010
            
            #add-point:AFTER FIELD faaj010 name="input.a.page4.faaj010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj010
            #add-point:ON CHANGE faaj010 name="input.g.page4.faaj010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj011
            #add-point:BEFORE FIELD faaj011 name="input.b.page4.faaj011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj011
            
            #add-point:AFTER FIELD faaj011 name="input.a.page4.faaj011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj011
            #add-point:ON CHANGE faaj011 name="input.g.page4.faaj011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj012
            #add-point:BEFORE FIELD faaj012 name="input.b.page4.faaj012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj012
            
            #add-point:AFTER FIELD faaj012 name="input.a.page4.faaj012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj012
            #add-point:ON CHANGE faaj012 name="input.g.page4.faaj012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj013
            #add-point:BEFORE FIELD faaj013 name="input.b.page4.faaj013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj013
            
            #add-point:AFTER FIELD faaj013 name="input.a.page4.faaj013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj013
            #add-point:ON CHANGE faaj013 name="input.g.page4.faaj013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj014
            
            #add-point:AFTER FIELD faaj014 name="input.a.page4.faaj014"
            IF NOT cl_null(g_faah4_d[l_ac].faaj014) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah4_d[l_ac].faaj014
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00011:sub-01302|aooi140|",cl_get_progname("aooi140",g_lang,"2"),"|:EXEPROGaooi140"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooai001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj014
            #add-point:BEFORE FIELD faaj014 name="input.b.page4.faaj014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj014
            #add-point:ON CHANGE faaj014 name="input.g.page4.faaj014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj015
            #add-point:BEFORE FIELD faaj015 name="input.b.page4.faaj015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj015
            
            #add-point:AFTER FIELD faaj015 name="input.a.page4.faaj015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj015
            #add-point:ON CHANGE faaj015 name="input.g.page4.faaj015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj016
            #add-point:BEFORE FIELD faaj016 name="input.b.page4.faaj016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj016
            
            #add-point:AFTER FIELD faaj016 name="input.a.page4.faaj016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj016
            #add-point:ON CHANGE faaj016 name="input.g.page4.faaj016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj017
            #add-point:BEFORE FIELD faaj017 name="input.b.page4.faaj017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj017
            
            #add-point:AFTER FIELD faaj017 name="input.a.page4.faaj017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj017
            #add-point:ON CHANGE faaj017 name="input.g.page4.faaj017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj018
            #add-point:BEFORE FIELD faaj018 name="input.b.page4.faaj018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj018
            
            #add-point:AFTER FIELD faaj018 name="input.a.page4.faaj018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj018
            #add-point:ON CHANGE faaj018 name="input.g.page4.faaj018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj019
            #add-point:BEFORE FIELD faaj019 name="input.b.page4.faaj019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj019
            
            #add-point:AFTER FIELD faaj019 name="input.a.page4.faaj019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj019
            #add-point:ON CHANGE faaj019 name="input.g.page4.faaj019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj020
            #add-point:BEFORE FIELD faaj020 name="input.b.page4.faaj020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj020
            
            #add-point:AFTER FIELD faaj020 name="input.a.page4.faaj020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj020
            #add-point:ON CHANGE faaj020 name="input.g.page4.faaj020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj021
            #add-point:BEFORE FIELD faaj021 name="input.b.page4.faaj021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj021
            
            #add-point:AFTER FIELD faaj021 name="input.a.page4.faaj021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj021
            #add-point:ON CHANGE faaj021 name="input.g.page4.faaj021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj022
            #add-point:BEFORE FIELD faaj022 name="input.b.page4.faaj022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj022
            
            #add-point:AFTER FIELD faaj022 name="input.a.page4.faaj022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj022
            #add-point:ON CHANGE faaj022 name="input.g.page4.faaj022"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj023
            
            #add-point:AFTER FIELD faaj023 name="input.a.page4.faaj023"
            IF NOT cl_null(g_faah4_d[l_ac].faaj023) THEN 
         #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511201
              LET l_sql = " "
              IF  s_aglt310_getlike_lc_subject(g_faah4_d[l_ac].faajld,g_faah4_d[l_ac].faaj023,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_faah4_d[l_ac].faajld
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_faah4_d[l_ac].faaj023
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_faah4_d[l_ac].faaj023
                LET g_qryparam.arg3 = g_faah4_d[l_ac].faajld
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
                LET g_faah4_d[l_ac].faaj023 = g_qryparam.return1
                DISPLAY g_faah4_d[l_ac].faaj023 TO faaj023
              END IF
               IF  NOT s_aglt310_lc_subject(g_faah4_d[l_ac].faajld,g_faah4_d[l_ac].faaj023,'N') THEN
                     LET   g_faah4_d[l_ac].faaj023 = g_faah4_d_t.faaj023
                    NEXT FIELD CURRENT
               END IF
          #  150916-00015#1 END
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_faah4_d[l_ac].faaj023
#               LET g_chkparam.arg2 = '參數2'
#                  
               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_glac002_3") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  NEXT FIELD CURRENT
#               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj023
            #add-point:BEFORE FIELD faaj023 name="input.b.page4.faaj023"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj023
            #add-point:ON CHANGE faaj023 name="input.g.page4.faaj023"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj024
            
            #add-point:AFTER FIELD faaj024 name="input.a.page4.faaj024"
            IF NOT cl_null(g_faah4_d[l_ac].faaj024) THEN 
             #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511201
              LET l_sql = " "
              IF  s_aglt310_getlike_lc_subject(g_faah4_d[l_ac].faajld,g_faah4_d[l_ac].faaj024,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_faah4_d[l_ac].faajld
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_faah4_d[l_ac].faaj024
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_faah4_d[l_ac].faaj024
                LET g_qryparam.arg3 = g_faah4_d[l_ac].faajld
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
                LET g_faah4_d[l_ac].faaj024 = g_qryparam.return1
                DISPLAY g_faah4_d[l_ac].faaj024 TO faaj024 
              END IF
               IF  NOT s_aglt310_lc_subject(g_faah4_d[l_ac].faajld,g_faah4_d[l_ac].faaj024,'N') THEN
                     LET   g_faah4_d[l_ac].faaj024 = g_faah4_d_t.faaj024
                    NEXT FIELD CURRENT
               END IF
          #  150916-00015#1 END
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_faah4_d[l_ac].faaj024
#               LET g_chkparam.arg2 = '參數2'
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_glac002_3") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  NEXT FIELD CURRENT
#               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj024
            #add-point:BEFORE FIELD faaj024 name="input.b.page4.faaj024"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj024
            #add-point:ON CHANGE faaj024 name="input.g.page4.faaj024"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj025
            
            #add-point:AFTER FIELD faaj025 name="input.a.page4.faaj025"
            IF NOT cl_null(g_faah4_d[l_ac].faaj025) THEN 
             #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511201
              LET l_sql = " "
              IF  s_aglt310_getlike_lc_subject(g_faah4_d[l_ac].faajld,g_faah4_d[l_ac].faaj025,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_faah4_d[l_ac].faajld
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_faah4_d[l_ac].faaj025
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_faah4_d[l_ac].faaj025
                LET g_qryparam.arg3 = g_faah4_d[l_ac].faajld
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
                LET g_faah4_d[l_ac].faaj025= g_qryparam.return1
                DISPLAY g_faah4_d[l_ac].faaj025 TO faaj025 
              END IF
               IF  NOT s_aglt310_lc_subject(g_faah4_d[l_ac].faajld,g_faah4_d[l_ac].faaj025,'N') THEN
                     LET   g_faah4_d[l_ac].faaj025 = g_faah4_d_t.faaj025
                    NEXT FIELD CURRENT
               END IF
          #  150916-00015#1 END
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_faah4_d[l_ac].faaj025
#               LET g_chkparam.arg2 = '參數2'
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_glac002_3") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  NEXT FIELD CURRENT
#               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj025
            #add-point:BEFORE FIELD faaj025 name="input.b.page4.faaj025"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj025
            #add-point:ON CHANGE faaj025 name="input.g.page4.faaj025"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj026
            
            #add-point:AFTER FIELD faaj026 name="input.a.page4.faaj026"
            IF NOT cl_null(g_faah4_d[l_ac].faaj026) THEN 
                #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511201
              LET l_sql = " "
              IF  s_aglt310_getlike_lc_subject(g_faah4_d[l_ac].faajld,g_faah4_d[l_ac].faaj026,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_faah4_d[l_ac].faajld
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_faah4_d[l_ac].faaj026
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_faah4_d[l_ac].faaj026
                LET g_qryparam.arg3 = g_faah4_d[l_ac].faajld
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
                LET g_faah4_d[l_ac].faaj026 = g_qryparam.return1
                DISPLAY g_faah4_d[l_ac].faaj026 TO faaj026 
              END IF
               IF  NOT s_aglt310_lc_subject(g_faah4_d[l_ac].faajld,g_faah4_d[l_ac].faaj026,'N') THEN
                     LET   g_faah4_d[l_ac].faaj026 = g_faah4_d_t.faaj026
                    NEXT FIELD CURRENT
               END IF
          #  150916-00015#1 END
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_faah4_d[l_ac].faaj026
#               LET g_chkparam.arg2 = '參數2'
#                  
#               #呼叫檢查存在並帶值的library
#              IF cl_chk_exist("v_glac002_3") THEN
#                 #檢查成功時後續處理
#                 #LET  = g_chkparam.return1
#                 #DISPLAY BY NAME 
#              ELSE
#                 #檢查失敗時後續處理
#                 NEXT FIELD CURRENT
#              END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj026
            #add-point:BEFORE FIELD faaj026 name="input.b.page4.faaj026"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj026
            #add-point:ON CHANGE faaj026 name="input.g.page4.faaj026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj027
            #add-point:BEFORE FIELD faaj027 name="input.b.page4.faaj027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj027
            
            #add-point:AFTER FIELD faaj027 name="input.a.page4.faaj027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj027
            #add-point:ON CHANGE faaj027 name="input.g.page4.faaj027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj028
            #add-point:BEFORE FIELD faaj028 name="input.b.page4.faaj028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj028
            
            #add-point:AFTER FIELD faaj028 name="input.a.page4.faaj028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj028
            #add-point:ON CHANGE faaj028 name="input.g.page4.faaj028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj029
            #add-point:BEFORE FIELD faaj029 name="input.b.page4.faaj029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj029
            
            #add-point:AFTER FIELD faaj029 name="input.a.page4.faaj029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj029
            #add-point:ON CHANGE faaj029 name="input.g.page4.faaj029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj030
            #add-point:BEFORE FIELD faaj030 name="input.b.page4.faaj030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj030
            
            #add-point:AFTER FIELD faaj030 name="input.a.page4.faaj030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj030
            #add-point:ON CHANGE faaj030 name="input.g.page4.faaj030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj031
            #add-point:BEFORE FIELD faaj031 name="input.b.page4.faaj031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj031
            
            #add-point:AFTER FIELD faaj031 name="input.a.page4.faaj031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj031
            #add-point:ON CHANGE faaj031 name="input.g.page4.faaj031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj032
            #add-point:BEFORE FIELD faaj032 name="input.b.page4.faaj032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj032
            
            #add-point:AFTER FIELD faaj032 name="input.a.page4.faaj032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj032
            #add-point:ON CHANGE faaj032 name="input.g.page4.faaj032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj033
            #add-point:BEFORE FIELD faaj033 name="input.b.page4.faaj033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj033
            
            #add-point:AFTER FIELD faaj033 name="input.a.page4.faaj033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj033
            #add-point:ON CHANGE faaj033 name="input.g.page4.faaj033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj034
            #add-point:BEFORE FIELD faaj034 name="input.b.page4.faaj034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj034
            
            #add-point:AFTER FIELD faaj034 name="input.a.page4.faaj034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj034
            #add-point:ON CHANGE faaj034 name="input.g.page4.faaj034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj035
            #add-point:BEFORE FIELD faaj035 name="input.b.page4.faaj035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj035
            
            #add-point:AFTER FIELD faaj035 name="input.a.page4.faaj035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj035
            #add-point:ON CHANGE faaj035 name="input.g.page4.faaj035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj036
            #add-point:BEFORE FIELD faaj036 name="input.b.page4.faaj036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj036
            
            #add-point:AFTER FIELD faaj036 name="input.a.page4.faaj036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj036
            #add-point:ON CHANGE faaj036 name="input.g.page4.faaj036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj038
            #add-point:BEFORE FIELD faaj038 name="input.b.page4.faaj038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj038
            
            #add-point:AFTER FIELD faaj038 name="input.a.page4.faaj038"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj038
            #add-point:ON CHANGE faaj038 name="input.g.page4.faaj038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj039
            #add-point:BEFORE FIELD faaj039 name="input.b.page4.faaj039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj039
            
            #add-point:AFTER FIELD faaj039 name="input.a.page4.faaj039"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj039
            #add-point:ON CHANGE faaj039 name="input.g.page4.faaj039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj040
            #add-point:BEFORE FIELD faaj040 name="input.b.page4.faaj040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj040
            
            #add-point:AFTER FIELD faaj040 name="input.a.page4.faaj040"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj040
            #add-point:ON CHANGE faaj040 name="input.g.page4.faaj040"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj041
            #add-point:BEFORE FIELD faaj041 name="input.b.page4.faaj041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj041
            
            #add-point:AFTER FIELD faaj041 name="input.a.page4.faaj041"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj041
            #add-point:ON CHANGE faaj041 name="input.g.page4.faaj041"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj042
            #add-point:BEFORE FIELD faaj042 name="input.b.page4.faaj042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj042
            
            #add-point:AFTER FIELD faaj042 name="input.a.page4.faaj042"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj042
            #add-point:ON CHANGE faaj042 name="input.g.page4.faaj042"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj043
            
            #add-point:AFTER FIELD faaj043 name="input.a.page4.faaj043"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah4_d[l_ac].faaj043
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faah4_d[l_ac].faaj043_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faah4_d[l_ac].faaj043_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj043
            #add-point:BEFORE FIELD faaj043 name="input.b.page4.faaj043"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj043
            #add-point:ON CHANGE faaj043 name="input.g.page4.faaj043"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj044
            #add-point:BEFORE FIELD faaj044 name="input.b.page4.faaj044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj044
            
            #add-point:AFTER FIELD faaj044 name="input.a.page4.faaj044"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj044
            #add-point:ON CHANGE faaj044 name="input.g.page4.faaj044"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj045
            #add-point:BEFORE FIELD faaj045 name="input.b.page4.faaj045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj045
            
            #add-point:AFTER FIELD faaj045 name="input.a.page4.faaj045"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj045
            #add-point:ON CHANGE faaj045 name="input.g.page4.faaj045"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj046
            #add-point:BEFORE FIELD faaj046 name="input.b.page4.faaj046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj046
            
            #add-point:AFTER FIELD faaj046 name="input.a.page4.faaj046"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj046
            #add-point:ON CHANGE faaj046 name="input.g.page4.faaj046"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj047
            #add-point:BEFORE FIELD faaj047 name="input.b.page4.faaj047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj047
            
            #add-point:AFTER FIELD faaj047 name="input.a.page4.faaj047"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj047
            #add-point:ON CHANGE faaj047 name="input.g.page4.faaj047"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj101
            #add-point:BEFORE FIELD faaj101 name="input.b.page4.faaj101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj101
            
            #add-point:AFTER FIELD faaj101 name="input.a.page4.faaj101"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj101
            #add-point:ON CHANGE faaj101 name="input.g.page4.faaj101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj102
            #add-point:BEFORE FIELD faaj102 name="input.b.page4.faaj102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj102
            
            #add-point:AFTER FIELD faaj102 name="input.a.page4.faaj102"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj102
            #add-point:ON CHANGE faaj102 name="input.g.page4.faaj102"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj103
            #add-point:BEFORE FIELD faaj103 name="input.b.page4.faaj103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj103
            
            #add-point:AFTER FIELD faaj103 name="input.a.page4.faaj103"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj103
            #add-point:ON CHANGE faaj103 name="input.g.page4.faaj103"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj104
            #add-point:BEFORE FIELD faaj104 name="input.b.page4.faaj104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj104
            
            #add-point:AFTER FIELD faaj104 name="input.a.page4.faaj104"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj104
            #add-point:ON CHANGE faaj104 name="input.g.page4.faaj104"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj105
            #add-point:BEFORE FIELD faaj105 name="input.b.page4.faaj105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj105
            
            #add-point:AFTER FIELD faaj105 name="input.a.page4.faaj105"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj105
            #add-point:ON CHANGE faaj105 name="input.g.page4.faaj105"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj106
            #add-point:BEFORE FIELD faaj106 name="input.b.page4.faaj106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj106
            
            #add-point:AFTER FIELD faaj106 name="input.a.page4.faaj106"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj106
            #add-point:ON CHANGE faaj106 name="input.g.page4.faaj106"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj107
            #add-point:BEFORE FIELD faaj107 name="input.b.page4.faaj107"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj107
            
            #add-point:AFTER FIELD faaj107 name="input.a.page4.faaj107"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj107
            #add-point:ON CHANGE faaj107 name="input.g.page4.faaj107"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj108
            #add-point:BEFORE FIELD faaj108 name="input.b.page4.faaj108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj108
            
            #add-point:AFTER FIELD faaj108 name="input.a.page4.faaj108"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj108
            #add-point:ON CHANGE faaj108 name="input.g.page4.faaj108"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj109
            #add-point:BEFORE FIELD faaj109 name="input.b.page4.faaj109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj109
            
            #add-point:AFTER FIELD faaj109 name="input.a.page4.faaj109"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj109
            #add-point:ON CHANGE faaj109 name="input.g.page4.faaj109"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj110
            #add-point:BEFORE FIELD faaj110 name="input.b.page4.faaj110"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj110
            
            #add-point:AFTER FIELD faaj110 name="input.a.page4.faaj110"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj110
            #add-point:ON CHANGE faaj110 name="input.g.page4.faaj110"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj111
            #add-point:BEFORE FIELD faaj111 name="input.b.page4.faaj111"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj111
            
            #add-point:AFTER FIELD faaj111 name="input.a.page4.faaj111"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj111
            #add-point:ON CHANGE faaj111 name="input.g.page4.faaj111"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj112
            #add-point:BEFORE FIELD faaj112 name="input.b.page4.faaj112"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj112
            
            #add-point:AFTER FIELD faaj112 name="input.a.page4.faaj112"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj112
            #add-point:ON CHANGE faaj112 name="input.g.page4.faaj112"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj113
            #add-point:BEFORE FIELD faaj113 name="input.b.page4.faaj113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj113
            
            #add-point:AFTER FIELD faaj113 name="input.a.page4.faaj113"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj113
            #add-point:ON CHANGE faaj113 name="input.g.page4.faaj113"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj114
            #add-point:BEFORE FIELD faaj114 name="input.b.page4.faaj114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj114
            
            #add-point:AFTER FIELD faaj114 name="input.a.page4.faaj114"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj114
            #add-point:ON CHANGE faaj114 name="input.g.page4.faaj114"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj115
            #add-point:BEFORE FIELD faaj115 name="input.b.page4.faaj115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj115
            
            #add-point:AFTER FIELD faaj115 name="input.a.page4.faaj115"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj115
            #add-point:ON CHANGE faaj115 name="input.g.page4.faaj115"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj116
            #add-point:BEFORE FIELD faaj116 name="input.b.page4.faaj116"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj116
            
            #add-point:AFTER FIELD faaj116 name="input.a.page4.faaj116"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj116
            #add-point:ON CHANGE faaj116 name="input.g.page4.faaj116"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj117
            #add-point:BEFORE FIELD faaj117 name="input.b.page4.faaj117"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj117
            
            #add-point:AFTER FIELD faaj117 name="input.a.page4.faaj117"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj117
            #add-point:ON CHANGE faaj117 name="input.g.page4.faaj117"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj151
            #add-point:BEFORE FIELD faaj151 name="input.b.page4.faaj151"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj151
            
            #add-point:AFTER FIELD faaj151 name="input.a.page4.faaj151"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj151
            #add-point:ON CHANGE faaj151 name="input.g.page4.faaj151"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj152
            #add-point:BEFORE FIELD faaj152 name="input.b.page4.faaj152"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj152
            
            #add-point:AFTER FIELD faaj152 name="input.a.page4.faaj152"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj152
            #add-point:ON CHANGE faaj152 name="input.g.page4.faaj152"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj153
            #add-point:BEFORE FIELD faaj153 name="input.b.page4.faaj153"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj153
            
            #add-point:AFTER FIELD faaj153 name="input.a.page4.faaj153"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj153
            #add-point:ON CHANGE faaj153 name="input.g.page4.faaj153"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj154
            #add-point:BEFORE FIELD faaj154 name="input.b.page4.faaj154"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj154
            
            #add-point:AFTER FIELD faaj154 name="input.a.page4.faaj154"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj154
            #add-point:ON CHANGE faaj154 name="input.g.page4.faaj154"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj155
            #add-point:BEFORE FIELD faaj155 name="input.b.page4.faaj155"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj155
            
            #add-point:AFTER FIELD faaj155 name="input.a.page4.faaj155"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj155
            #add-point:ON CHANGE faaj155 name="input.g.page4.faaj155"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj156
            #add-point:BEFORE FIELD faaj156 name="input.b.page4.faaj156"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj156
            
            #add-point:AFTER FIELD faaj156 name="input.a.page4.faaj156"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj156
            #add-point:ON CHANGE faaj156 name="input.g.page4.faaj156"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj157
            #add-point:BEFORE FIELD faaj157 name="input.b.page4.faaj157"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj157
            
            #add-point:AFTER FIELD faaj157 name="input.a.page4.faaj157"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj157
            #add-point:ON CHANGE faaj157 name="input.g.page4.faaj157"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj158
            #add-point:BEFORE FIELD faaj158 name="input.b.page4.faaj158"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj158
            
            #add-point:AFTER FIELD faaj158 name="input.a.page4.faaj158"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj158
            #add-point:ON CHANGE faaj158 name="input.g.page4.faaj158"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj159
            #add-point:BEFORE FIELD faaj159 name="input.b.page4.faaj159"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj159
            
            #add-point:AFTER FIELD faaj159 name="input.a.page4.faaj159"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj159
            #add-point:ON CHANGE faaj159 name="input.g.page4.faaj159"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj160
            #add-point:BEFORE FIELD faaj160 name="input.b.page4.faaj160"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj160
            
            #add-point:AFTER FIELD faaj160 name="input.a.page4.faaj160"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj160
            #add-point:ON CHANGE faaj160 name="input.g.page4.faaj160"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj161
            #add-point:BEFORE FIELD faaj161 name="input.b.page4.faaj161"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj161
            
            #add-point:AFTER FIELD faaj161 name="input.a.page4.faaj161"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj161
            #add-point:ON CHANGE faaj161 name="input.g.page4.faaj161"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj162
            #add-point:BEFORE FIELD faaj162 name="input.b.page4.faaj162"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj162
            
            #add-point:AFTER FIELD faaj162 name="input.a.page4.faaj162"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj162
            #add-point:ON CHANGE faaj162 name="input.g.page4.faaj162"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj163
            #add-point:BEFORE FIELD faaj163 name="input.b.page4.faaj163"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj163
            
            #add-point:AFTER FIELD faaj163 name="input.a.page4.faaj163"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj163
            #add-point:ON CHANGE faaj163 name="input.g.page4.faaj163"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj164
            #add-point:BEFORE FIELD faaj164 name="input.b.page4.faaj164"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj164
            
            #add-point:AFTER FIELD faaj164 name="input.a.page4.faaj164"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj164
            #add-point:ON CHANGE faaj164 name="input.g.page4.faaj164"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj165
            #add-point:BEFORE FIELD faaj165 name="input.b.page4.faaj165"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj165
            
            #add-point:AFTER FIELD faaj165 name="input.a.page4.faaj165"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj165
            #add-point:ON CHANGE faaj165 name="input.g.page4.faaj165"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj166
            #add-point:BEFORE FIELD faaj166 name="input.b.page4.faaj166"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj166
            
            #add-point:AFTER FIELD faaj166 name="input.a.page4.faaj166"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj166
            #add-point:ON CHANGE faaj166 name="input.g.page4.faaj166"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj167
            #add-point:BEFORE FIELD faaj167 name="input.b.page4.faaj167"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj167
            
            #add-point:AFTER FIELD faaj167 name="input.a.page4.faaj167"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj167
            #add-point:ON CHANGE faaj167 name="input.g.page4.faaj167"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faajsite
            
            #add-point:AFTER FIELD faajsite name="input.a.page4.faajsite"
            IF NOT cl_null(g_faah4_d[l_ac].faajsite) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah4_d[l_ac].faajsite
               LET g_chkparam.arg2 = '參數2'
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_faab002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faajsite
            #add-point:BEFORE FIELD faajsite name="input.b.page4.faajsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faajsite
            #add-point:ON CHANGE faajsite name="input.g.page4.faajsite"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page4.faajld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faajld
            #add-point:ON ACTION controlp INFIELD faajld name="input.c.page4.faajld"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah4_d[l_ac].faajld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.arg2 = "" #
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_faah4_d[l_ac].faajld = g_qryparam.return1              

            DISPLAY g_faah4_d[l_ac].faajld TO faajld              #

            NEXT FIELD faajld                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj003
            #add-point:ON ACTION controlp INFIELD faaj003 name="input.c.page4.faaj003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj004
            #add-point:ON ACTION controlp INFIELD faaj004 name="input.c.page4.faaj004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj005
            #add-point:ON ACTION controlp INFIELD faaj005 name="input.c.page4.faaj005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj006
            #add-point:ON ACTION controlp INFIELD faaj006 name="input.c.page4.faaj006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj007
            #add-point:ON ACTION controlp INFIELD faaj007 name="input.c.page4.faaj007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj008
            #add-point:ON ACTION controlp INFIELD faaj008 name="input.c.page4.faaj008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj009
            #add-point:ON ACTION controlp INFIELD faaj009 name="input.c.page4.faaj009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj010
            #add-point:ON ACTION controlp INFIELD faaj010 name="input.c.page4.faaj010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj011
            #add-point:ON ACTION controlp INFIELD faaj011 name="input.c.page4.faaj011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj012
            #add-point:ON ACTION controlp INFIELD faaj012 name="input.c.page4.faaj012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj013
            #add-point:ON ACTION controlp INFIELD faaj013 name="input.c.page4.faaj013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj014
            #add-point:ON ACTION controlp INFIELD faaj014 name="input.c.page4.faaj014"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah4_d[l_ac].faaj014             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_aooi001_1()                                #呼叫開窗

            LET g_faah4_d[l_ac].faaj014 = g_qryparam.return1              

            DISPLAY g_faah4_d[l_ac].faaj014 TO faaj014              #

            NEXT FIELD faaj014                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj015
            #add-point:ON ACTION controlp INFIELD faaj015 name="input.c.page4.faaj015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj016
            #add-point:ON ACTION controlp INFIELD faaj016 name="input.c.page4.faaj016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj017
            #add-point:ON ACTION controlp INFIELD faaj017 name="input.c.page4.faaj017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj018
            #add-point:ON ACTION controlp INFIELD faaj018 name="input.c.page4.faaj018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj019
            #add-point:ON ACTION controlp INFIELD faaj019 name="input.c.page4.faaj019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj020
            #add-point:ON ACTION controlp INFIELD faaj020 name="input.c.page4.faaj020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj021
            #add-point:ON ACTION controlp INFIELD faaj021 name="input.c.page4.faaj021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj022
            #add-point:ON ACTION controlp INFIELD faaj022 name="input.c.page4.faaj022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj023
            #add-point:ON ACTION controlp INFIELD faaj023 name="input.c.page4.faaj023"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah4_d[l_ac].faaj023             #給予default值

            #給予arg
             SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_faah4_d[l_ac].faajld
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " glac001 = '",l_glaa004,"' AND  glac003 <>'1' " , #glac003(科目類型)
                                    " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_faah4_d[l_ac].faajld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            
            CALL aglt310_04()                                #呼叫開窗

            LET g_faah4_d[l_ac].faaj023 = g_qryparam.return1              

            DISPLAY g_faah4_d[l_ac].faaj023 TO faaj023              #

            NEXT FIELD faaj023                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj024
            #add-point:ON ACTION controlp INFIELD faaj024 name="input.c.page4.faaj024"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah4_d[l_ac].faaj024             #給予default值

            #給予arg
            SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_faah4_d[l_ac].faajld
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " glac001 = '",l_glaa004,"' AND  glac003 <>'1' " , #glac003(科目類型)
                                    " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_faah4_d[l_ac].faajld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            
            CALL aglt310_04()                                #呼叫開窗

            LET g_faah4_d[l_ac].faaj024 = g_qryparam.return1              

            DISPLAY g_faah4_d[l_ac].faaj024 TO faaj024              #

            NEXT FIELD faaj024                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj025
            #add-point:ON ACTION controlp INFIELD faaj025 name="input.c.page4.faaj025"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah4_d[l_ac].faaj025             #給予default值

            #給予arg
            SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_faah4_d[l_ac].faajld
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " glac001 = '",l_glaa004,"' AND  glac003 <>'1' " , #glac003(科目類型)
                                    " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_faah4_d[l_ac].faajld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            
            CALL aglt310_04()                                #呼叫開窗

            LET g_faah4_d[l_ac].faaj025 = g_qryparam.return1              

            DISPLAY g_faah4_d[l_ac].faaj025 TO faaj025              #

            NEXT FIELD faaj025                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj026
            #add-point:ON ACTION controlp INFIELD faaj026 name="input.c.page4.faaj026"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah4_d[l_ac].faaj026             #給予default值

            #給予arg
            SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_faah4_d[l_ac].faajld
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " glac001 = '",l_glaa004,"' AND  glac003 <>'1' " , #glac003(科目類型)
                                    " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_faah4_d[l_ac].faajld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            
            CALL aglt310_04()                                #呼叫開窗

            LET g_faah4_d[l_ac].faaj026 = g_qryparam.return1              

            DISPLAY g_faah4_d[l_ac].faaj026 TO faaj026              #

            NEXT FIELD faaj026                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj027
            #add-point:ON ACTION controlp INFIELD faaj027 name="input.c.page4.faaj027"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj028
            #add-point:ON ACTION controlp INFIELD faaj028 name="input.c.page4.faaj028"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj029
            #add-point:ON ACTION controlp INFIELD faaj029 name="input.c.page4.faaj029"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj030
            #add-point:ON ACTION controlp INFIELD faaj030 name="input.c.page4.faaj030"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj031
            #add-point:ON ACTION controlp INFIELD faaj031 name="input.c.page4.faaj031"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah4_d[l_ac].faaj031             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_bgaa001()                                #呼叫開窗

            LET g_faah4_d[l_ac].faaj031 = g_qryparam.return1              

            DISPLAY g_faah4_d[l_ac].faaj031 TO faaj031              #

            NEXT FIELD faaj031                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj032
            #add-point:ON ACTION controlp INFIELD faaj032 name="input.c.page4.faaj032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj033
            #add-point:ON ACTION controlp INFIELD faaj033 name="input.c.page4.faaj033"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj034
            #add-point:ON ACTION controlp INFIELD faaj034 name="input.c.page4.faaj034"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj035
            #add-point:ON ACTION controlp INFIELD faaj035 name="input.c.page4.faaj035"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj036
            #add-point:ON ACTION controlp INFIELD faaj036 name="input.c.page4.faaj036"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj038
            #add-point:ON ACTION controlp INFIELD faaj038 name="input.c.page4.faaj038"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj039
            #add-point:ON ACTION controlp INFIELD faaj039 name="input.c.page4.faaj039"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj040
            #add-point:ON ACTION controlp INFIELD faaj040 name="input.c.page4.faaj040"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj041
            #add-point:ON ACTION controlp INFIELD faaj041 name="input.c.page4.faaj041"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj042
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj042
            #add-point:ON ACTION controlp INFIELD faaj042 name="input.c.page4.faaj042"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah4_d[l_ac].faaj042             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pmaa001_5()                                #呼叫開窗

            LET g_faah4_d[l_ac].faaj042 = g_qryparam.return1              

            DISPLAY g_faah4_d[l_ac].faaj042 TO faaj042              #

            NEXT FIELD faaj042                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj043
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj043
            #add-point:ON ACTION controlp INFIELD faaj043 name="input.c.page4.faaj043"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah4_d[l_ac].faaj043             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pmaa001_5()                                #呼叫開窗

            LET g_faah4_d[l_ac].faaj043 = g_qryparam.return1              

            DISPLAY g_faah4_d[l_ac].faaj043 TO faaj043              #

            NEXT FIELD faaj043                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj044
            #add-point:ON ACTION controlp INFIELD faaj044 name="input.c.page4.faaj044"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj045
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj045
            #add-point:ON ACTION controlp INFIELD faaj045 name="input.c.page4.faaj045"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah4_d[l_ac].faaj045             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pjba001()                                #呼叫開窗

            LET g_faah4_d[l_ac].faaj045 = g_qryparam.return1              

            DISPLAY g_faah4_d[l_ac].faaj045 TO faaj045              #

            NEXT FIELD faaj045                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj046
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj046
            #add-point:ON ACTION controlp INFIELD faaj046 name="input.c.page4.faaj046"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah4_d[l_ac].faaj046             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pjbb002_1()                                #呼叫開窗

            LET g_faah4_d[l_ac].faaj046 = g_qryparam.return1              

            DISPLAY g_faah4_d[l_ac].faaj046 TO faaj046              #

            NEXT FIELD faaj046                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj047
            #add-point:ON ACTION controlp INFIELD faaj047 name="input.c.page4.faaj047"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj101
            #add-point:ON ACTION controlp INFIELD faaj101 name="input.c.page4.faaj101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj102
            #add-point:ON ACTION controlp INFIELD faaj102 name="input.c.page4.faaj102"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj103
            #add-point:ON ACTION controlp INFIELD faaj103 name="input.c.page4.faaj103"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj104
            #add-point:ON ACTION controlp INFIELD faaj104 name="input.c.page4.faaj104"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj105
            #add-point:ON ACTION controlp INFIELD faaj105 name="input.c.page4.faaj105"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj106
            #add-point:ON ACTION controlp INFIELD faaj106 name="input.c.page4.faaj106"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj107
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj107
            #add-point:ON ACTION controlp INFIELD faaj107 name="input.c.page4.faaj107"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj108
            #add-point:ON ACTION controlp INFIELD faaj108 name="input.c.page4.faaj108"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj109
            #add-point:ON ACTION controlp INFIELD faaj109 name="input.c.page4.faaj109"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj110
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj110
            #add-point:ON ACTION controlp INFIELD faaj110 name="input.c.page4.faaj110"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj111
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj111
            #add-point:ON ACTION controlp INFIELD faaj111 name="input.c.page4.faaj111"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj112
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj112
            #add-point:ON ACTION controlp INFIELD faaj112 name="input.c.page4.faaj112"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj113
            #add-point:ON ACTION controlp INFIELD faaj113 name="input.c.page4.faaj113"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj114
            #add-point:ON ACTION controlp INFIELD faaj114 name="input.c.page4.faaj114"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj115
            #add-point:ON ACTION controlp INFIELD faaj115 name="input.c.page4.faaj115"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj116
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj116
            #add-point:ON ACTION controlp INFIELD faaj116 name="input.c.page4.faaj116"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj117
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj117
            #add-point:ON ACTION controlp INFIELD faaj117 name="input.c.page4.faaj117"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj151
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj151
            #add-point:ON ACTION controlp INFIELD faaj151 name="input.c.page4.faaj151"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj152
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj152
            #add-point:ON ACTION controlp INFIELD faaj152 name="input.c.page4.faaj152"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj153
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj153
            #add-point:ON ACTION controlp INFIELD faaj153 name="input.c.page4.faaj153"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj154
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj154
            #add-point:ON ACTION controlp INFIELD faaj154 name="input.c.page4.faaj154"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj155
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj155
            #add-point:ON ACTION controlp INFIELD faaj155 name="input.c.page4.faaj155"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj156
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj156
            #add-point:ON ACTION controlp INFIELD faaj156 name="input.c.page4.faaj156"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj157
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj157
            #add-point:ON ACTION controlp INFIELD faaj157 name="input.c.page4.faaj157"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj158
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj158
            #add-point:ON ACTION controlp INFIELD faaj158 name="input.c.page4.faaj158"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj159
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj159
            #add-point:ON ACTION controlp INFIELD faaj159 name="input.c.page4.faaj159"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj160
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj160
            #add-point:ON ACTION controlp INFIELD faaj160 name="input.c.page4.faaj160"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj161
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj161
            #add-point:ON ACTION controlp INFIELD faaj161 name="input.c.page4.faaj161"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj162
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj162
            #add-point:ON ACTION controlp INFIELD faaj162 name="input.c.page4.faaj162"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj163
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj163
            #add-point:ON ACTION controlp INFIELD faaj163 name="input.c.page4.faaj163"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj164
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj164
            #add-point:ON ACTION controlp INFIELD faaj164 name="input.c.page4.faaj164"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj165
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj165
            #add-point:ON ACTION controlp INFIELD faaj165 name="input.c.page4.faaj165"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj166
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj166
            #add-point:ON ACTION controlp INFIELD faaj166 name="input.c.page4.faaj166"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faaj167
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj167
            #add-point:ON ACTION controlp INFIELD faaj167 name="input.c.page4.faaj167"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.faajsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faajsite
            #add-point:ON ACTION controlp INFIELD faajsite name="input.c.page4.faajsite"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah4_d[l_ac].faajsite             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_faab001()                                #呼叫開窗

            LET g_faah4_d[l_ac].faajsite = g_qryparam.return1              

            DISPLAY g_faah4_d[l_ac].faajsite TO faajsite              #

            NEXT FIELD faajsite                          #返回原欄位


            #END add-point
 
 
 
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_faah4_d[l_ac].* = g_faah4_d_t.*
               END IF
               CLOSE afat300_bcl3
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               CANCEL DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL afat300_unlock_b("faaj_t")
            CALL s_transaction_end('Y','0')
            LET l_cmd = ''
 
         AFTER INPUT
            #add-point:input段after input  name="input.body4.after_input"
            
            #end add-point   
 
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_faah4_d[li_reproduce_target].* = g_faah4_d[li_reproduce].*
 
               LET g_faah4_d[li_reproduce_target].faajld = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_faah4_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_faah4_d.getLength()+1
            END IF
 
      END INPUT
 
      
      DISPLAY ARRAY g_faah2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)
            CALL afat300_b_fill(g_wc)
            LET g_current_page = 2
        
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            CALL cl_show_fld_cont() 
            LET g_action_choice = "fetch"
            CALL afat300_fetch()
            CALL afat300_idx_chk('m')
            
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
            
      END DISPLAY
 
    
 
      
      #add-point:input段input_array" name="input.more_inputarray"
      
      #end add-point
      
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         LET g_curr_diag = ui.DIALOG.getCurrent()
         IF g_detail_idx > 0 THEN
            IF g_detail_idx > g_faah_d.getLength() THEN
               LET g_detail_idx = g_faah_d.getLength()
            END IF
            CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)
            LET l_ac = g_detail_idx
         END IF 
         LET g_detail_idx = l_ac
         #add-point:input段input_array" name="input.before_dialog"
         
         #end add-point
         #先確定單頭(第一單身)是否有資料
         IF g_faah_d.getLength() > 0 THEN
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD faah000
               WHEN "s_detail2"
                  NEXT FIELD faah000_2
               WHEN "s_detail3"
                  NEXT FIELD faaiseq
               WHEN "s_detail4"
                  NEXT FIELD faajld
 
            END CASE
         ELSE
            NEXT FIELD faah000
         END IF
            
      ON ACTION accept
         ACCEPT DIALOG
      
      ON ACTION cancel
         LET INT_FLAG = TRUE 
         CANCEL DIALOG
 
      ON ACTION close
         LET INT_FLAG = TRUE 
         CANCEL DIALOG
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) 
              RETURNING g_fld_name,g_frm_name 
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) 
           
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   
   END DIALOG 
   
   CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
   CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx2)
   CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx2)
 
   
   #add-point:input段修改後 name="input.after_input"
   
   #end add-point
 
   CLOSE afat300_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="afat300.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afat300_b_fill(p_wc2)
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2           STRING
   DEFINE l_ac_t          LIKE type_t.num10
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.sql_before"
 
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT t0.faah000,t0.faah001,t0.faah003,t0.faah004,t0.faah002,t0.faah005,t0.faah006, 
       t0.faah007,t0.faah008,t0.faah009,t0.faah010,t0.faah011,t0.faah012,t0.faah013,t0.faah014,t0.faah015, 
       t0.faah016,t0.faah017,t0.faah018,t0.faah019,t0.faah020,t0.faah021,t0.faah022,t0.faah023,t0.faah024, 
       t0.faah025,t0.faah026,t0.faah027,t0.faah028,t0.faah029,t0.faah030,t0.faah031,t0.faah032,t0.faah033, 
       t0.faah034,t0.faah035,t0.faah036,t0.faah037,t0.faah038,t0.faah039,t0.faah040,t0.faah041,t0.faah042, 
       t0.faah043,t0.faah044,t0.faah045,t0.faah000,t0.faah001,t0.faah003,t0.faah004,t0.faahownid,t0.faahowndp, 
       t0.faahcrtid,t0.faahcrtdp,t0.faahcrtdt,t0.faahmodid,t0.faahmoddt ,t1.faacl003 ,t2.faadl003 ,t3.oocql004 , 
       t4.pmaal003 ,t5.pmaal004 ,t6.oocel003 ,t7.ooail003 ,t8.ooag011 ,t9.ooefl003 ,t10.oocql004 ,t11.ooag011 , 
       t12.ooefl003 ,t13.ooefl003 ,t14.ooefl003 ,t15.ooefl003 ,t16.ooag011 ,t17.ooefl003 ,t18.ooag011 , 
       t19.ooefl003 ,t20.ooag011 FROM faah_t t0",
 
               " LEFT JOIN faai_t ON faaient = faahent AND faah000 = faai000 AND faah001 = faai001 AND faah003 = faai002 AND faah004 = faai003",
 
               " LEFT JOIN faaj_t ON faajent = faahent AND faah000 = faaj000 AND faah001 = faaj037 AND faah003 = faaj001 AND faah004 = faaj002",
 
 
               "",
                              " LEFT JOIN faacl_t t1 ON t1.faaclent="||g_enterprise||" AND t1.faacl001=t0.faah006 AND t1.faacl002='"||g_dlang||"' ",
               " LEFT JOIN faadl_t t2 ON t2.faadlent="||g_enterprise||" AND t2.faadl001=t0.faah007 AND t2.faadl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='3903' AND t3.oocql002=t0.faah008 AND t3.oocql003='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t4 ON t4.pmaalent="||g_enterprise||" AND t4.pmaal001=t0.faah009 AND t4.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t5 ON t5.pmaalent="||g_enterprise||" AND t5.pmaal001=t0.faah010 AND t5.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN oocel_t t6 ON t6.oocelent="||g_enterprise||" AND t6.oocel001=t0.faah011 AND t6.oocel002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t7 ON t7.ooailent="||g_enterprise||" AND t7.ooail001=t0.faah020 AND t7.ooail002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.faah025  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.faah026 AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t10 ON t10.oocqlent="||g_enterprise||" AND t10.oocql001='3900' AND t10.oocql002=t0.faah027 AND t10.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.faah029  ",
               " LEFT JOIN ooefl_t t12 ON t12.ooeflent="||g_enterprise||" AND t12.ooefl001=t0.faah030 AND t12.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t13 ON t13.ooeflent="||g_enterprise||" AND t13.ooefl001=t0.faah031 AND t13.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t14 ON t14.ooeflent="||g_enterprise||" AND t14.ooefl001=t0.faah032 AND t14.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t15 ON t15.ooeflent="||g_enterprise||" AND t15.ooefl001=t0.faah041 AND t15.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t16 ON t16.ooagent="||g_enterprise||" AND t16.ooag001=t0.faahownid  ",
               " LEFT JOIN ooefl_t t17 ON t17.ooeflent="||g_enterprise||" AND t17.ooefl001=t0.faahowndp AND t17.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t18 ON t18.ooagent="||g_enterprise||" AND t18.ooag001=t0.faahcrtid  ",
               " LEFT JOIN ooefl_t t19 ON t19.ooeflent="||g_enterprise||" AND t19.ooefl001=t0.faahcrtdp AND t19.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t20 ON t20.ooagent="||g_enterprise||" AND t20.ooag001=t0.faahmodid  ",
 
               " WHERE t0.faahent= ?  AND  1=1 AND (", p_wc2, ") "
   #add-point:b_fill段sql_wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("faah_t"),
                      " ORDER BY t0.faah000,t0.faah001,t0.faah003,t0.faah004"
  
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
  
   #LET g_sql = cl_sql_add_tabid(g_sql,"faah_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料  
   PREPARE afat300_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR afat300_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_faah_d.clear()
   CALL g_faah2_d.clear()   
   CALL g_faah3_d.clear()   
   CALL g_faah4_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_faah_d[l_ac].faah000,g_faah_d[l_ac].faah001,g_faah_d[l_ac].faah003,g_faah_d[l_ac].faah004, 
       g_faah_d[l_ac].faah002,g_faah_d[l_ac].faah005,g_faah_d[l_ac].faah006,g_faah_d[l_ac].faah007,g_faah_d[l_ac].faah008, 
       g_faah_d[l_ac].faah009,g_faah_d[l_ac].faah010,g_faah_d[l_ac].faah011,g_faah_d[l_ac].faah012,g_faah_d[l_ac].faah013, 
       g_faah_d[l_ac].faah014,g_faah_d[l_ac].faah015,g_faah_d[l_ac].faah016,g_faah_d[l_ac].faah017,g_faah_d[l_ac].faah018, 
       g_faah_d[l_ac].faah019,g_faah_d[l_ac].faah020,g_faah_d[l_ac].faah021,g_faah_d[l_ac].faah022,g_faah_d[l_ac].faah023, 
       g_faah_d[l_ac].faah024,g_faah_d[l_ac].faah025,g_faah_d[l_ac].faah026,g_faah_d[l_ac].faah027,g_faah_d[l_ac].faah028, 
       g_faah_d[l_ac].faah029,g_faah_d[l_ac].faah030,g_faah_d[l_ac].faah031,g_faah_d[l_ac].faah032,g_faah_d[l_ac].faah033, 
       g_faah_d[l_ac].faah034,g_faah_d[l_ac].faah035,g_faah_d[l_ac].faah036,g_faah_d[l_ac].faah037,g_faah_d[l_ac].faah038, 
       g_faah_d[l_ac].faah039,g_faah_d[l_ac].faah040,g_faah_d[l_ac].faah041,g_faah_d[l_ac].faah042,g_faah_d[l_ac].faah043, 
       g_faah_d[l_ac].faah044,g_faah_d[l_ac].faah045,g_faah2_d[l_ac].faah000,g_faah2_d[l_ac].faah001, 
       g_faah2_d[l_ac].faah003,g_faah2_d[l_ac].faah004,g_faah2_d[l_ac].faahownid,g_faah2_d[l_ac].faahowndp, 
       g_faah2_d[l_ac].faahcrtid,g_faah2_d[l_ac].faahcrtdp,g_faah2_d[l_ac].faahcrtdt,g_faah2_d[l_ac].faahmodid, 
       g_faah2_d[l_ac].faahmoddt,g_faah_d[l_ac].faah006_desc,g_faah_d[l_ac].faah007_desc,g_faah_d[l_ac].faah008_desc, 
       g_faah_d[l_ac].faah009_desc,g_faah_d[l_ac].faah010_desc,g_faah_d[l_ac].faah011_desc,g_faah_d[l_ac].faah020_desc, 
       g_faah_d[l_ac].faah025_desc,g_faah_d[l_ac].faah026_desc,g_faah_d[l_ac].faah027_desc,g_faah_d[l_ac].faah029_desc, 
       g_faah_d[l_ac].faah030_desc,g_faah_d[l_ac].faah031_desc,g_faah_d[l_ac].faah032_desc,g_faah_d[l_ac].faah041_desc, 
       g_faah2_d[l_ac].faahownid_desc,g_faah2_d[l_ac].faahowndp_desc,g_faah2_d[l_ac].faahcrtid_desc, 
       g_faah2_d[l_ac].faahcrtdp_desc,g_faah2_d[l_ac].faahmodid_desc
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
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
   
 
   CALL g_faah_d.deleteElement(g_faah_d.getLength())   
   CALL g_faah2_d.deleteElement(g_faah2_d.getLength())
   CALL g_faah3_d.deleteElement(g_faah3_d.getLength())
   CALL g_faah4_d.deleteElement(g_faah4_d.getLength())
 
   
   #確定指標無超過上限, 超過則指到最後一筆
   IF g_detail_idx > g_faah_d.getLength() THEN
       IF g_faah_d.getLength() > 0 THEN
          LET g_detail_idx = g_faah_d.getLength()
       ELSE
          LET g_detail_idx = 1
      END IF
   END IF
   
   #將key欄位填到每個page
   LET l_ac_t = g_detail_idx
   FOR g_detail_idx = 1 TO g_faah_d.getLength()
      LET g_faah2_d[g_detail_idx].faah000 = g_faah_d[g_detail_idx].faah000 
      LET g_faah2_d[g_detail_idx].faah001 = g_faah_d[g_detail_idx].faah001 
      LET g_faah2_d[g_detail_idx].faah003 = g_faah_d[g_detail_idx].faah003 
      LET g_faah2_d[g_detail_idx].faah004 = g_faah_d[g_detail_idx].faah004 
      #LET g_faah3_d[g_detail_idx2].faaiseq = g_faah_d[g_detail_idx].faah000 
      #LET g_faah4_d[g_detail_idx2].faajld = g_faah_d[g_detail_idx].faah000 
 
   END FOR
   LET g_detail_idx = l_ac_t
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
    
   LET g_detail_cnt = l_ac - 1
   IF g_detail_cnt > 0 THEN
      DISPLAY g_detail_cnt TO FORMONLY.h_count
   END IF
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE afat300_pb
   
   LET g_loc = 'm'
   CALL afat300_detail_show() 
   
   LET l_ac = 1
   IF g_faah_d.getLength() > 0 THEN
      CALL afat300_fetch()
   END IF
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_faah_d.getLength()
      LET g_faah_d_mask_o[l_ac].* =  g_faah_d[l_ac].*
      CALL afat300_faah_t_mask()
      LET g_faah_d_mask_n[l_ac].* =  g_faah_d[l_ac].*
   END FOR
   
   LET g_faah2_d_mask_o.* =  g_faah2_d.*
   FOR l_ac = 1 TO g_faah2_d.getLength()
      LET g_faah2_d_mask_o[l_ac].* =  g_faah2_d[l_ac].*
      CALL afat300_faah_t_mask()
      LET g_faah2_d_mask_n[l_ac].* =  g_faah2_d[l_ac].*
   END FOR
   LET g_faah3_d_mask_o.* =  g_faah3_d.*
   FOR l_ac = 1 TO g_faah3_d.getLength()
      LET g_faah3_d_mask_o[l_ac].* =  g_faah3_d[l_ac].*
      CALL afat300_faai_t_mask()
      LET g_faah3_d_mask_n[l_ac].* =  g_faah3_d[l_ac].*
   END FOR
   LET g_faah4_d_mask_o.* =  g_faah4_d.*
   FOR l_ac = 1 TO g_faah4_d.getLength()
      LET g_faah4_d_mask_o[l_ac].* =  g_faah4_d[l_ac].*
      CALL afat300_faaj_t_mask()
      LET g_faah4_d_mask_n[l_ac].* =  g_faah4_d[l_ac].*
   END FOR
 
   
   ERROR "" 
   
END FUNCTION
 
{</section>}
 
{<section id="afat300.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afat300_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   #判定單頭是否有資料
   IF g_detail_idx <= 0 OR g_faah_d.getLength() = 0 THEN
      RETURN
   END IF
   
   #CALL g_faah2_d.clear()
   CALL g_faah3_d.clear()
   CALL g_faah4_d.clear()
 
   
   LET li_ac = l_ac 
    
   IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
      
      #end add-point
   THEN
      LET g_sql = "SELECT  DISTINCT t0.faaiseq,t0.faai004,t0.faai005,t0.faai006,t0.faai007,t0.faai008, 
          t0.faai009,t0.faai010,t0.faai011,t0.faai012,t0.faai013,t0.faai014,t0.faai015,t0.faai016,t0.faai017, 
          t0.faai018,t0.faai019,t0.faai020,t0.faai021,t0.faai022,t0.faai023  FROM faai_t t0",    
                  "",
                  
                  " WHERE t0.faaient=?  AND t0. faai000=?  AND t0. faai001=?  AND t0. faai002=?  AND t0. faai003=?"
      #add-point:單身sql wc name="fetch.sql_wc2"
      
      #end add-point
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
      
      LET g_sql = g_sql, " ORDER BY t0.faaiseq" 
                         
      #add-point:單身填充前 name="fetch.before_fill2"
      
      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料    
      PREPARE afat300_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR afat300_pb2
   END IF
   
#  LET l_ac = g_detail_idx   #(ver:45)
#  OPEN b_fill_curs2 USING g_enterprise,g_faah_d[l_ac].faah000,g_faah_d[l_ac].faah001,g_faah_d[l_ac].faah003, 
#    g_faah_d[l_ac].faah004   #(ver:45)
   
   LET l_ac = 1
#  FOREACH b_fill_curs2 USING g_enterprise,g_faah_d[l_ac].faah000,g_faah_d[l_ac].faah001,g_faah_d[l_ac].faah003, 
#    g_faah_d[l_ac].faah004 INTO g_faah3_d[l_ac].faaiseq,g_faah3_d[l_ac].faai004,g_faah3_d[l_ac].faai005, 
#    g_faah3_d[l_ac].faai006,g_faah3_d[l_ac].faai007,g_faah3_d[l_ac].faai008,g_faah3_d[l_ac].faai009, 
#    g_faah3_d[l_ac].faai010,g_faah3_d[l_ac].faai011,g_faah3_d[l_ac].faai012,g_faah3_d[l_ac].faai013, 
#    g_faah3_d[l_ac].faai014,g_faah3_d[l_ac].faai015,g_faah3_d[l_ac].faai016,g_faah3_d[l_ac].faai017, 
#    g_faah3_d[l_ac].faai018,g_faah3_d[l_ac].faai019,g_faah3_d[l_ac].faai020,g_faah3_d[l_ac].faai021, 
#    g_faah3_d[l_ac].faai022,g_faah3_d[l_ac].faai023   #(ver:45) #(ver:46)mark
   FOREACH b_fill_curs2 USING g_enterprise,g_faah_d[g_detail_idx].faah000,g_faah_d[g_detail_idx].faah001, 
       g_faah_d[g_detail_idx].faah003,g_faah_d[g_detail_idx].faah004 INTO g_faah3_d[l_ac].faaiseq,g_faah3_d[l_ac].faai004, 
       g_faah3_d[l_ac].faai005,g_faah3_d[l_ac].faai006,g_faah3_d[l_ac].faai007,g_faah3_d[l_ac].faai008, 
       g_faah3_d[l_ac].faai009,g_faah3_d[l_ac].faai010,g_faah3_d[l_ac].faai011,g_faah3_d[l_ac].faai012, 
       g_faah3_d[l_ac].faai013,g_faah3_d[l_ac].faai014,g_faah3_d[l_ac].faai015,g_faah3_d[l_ac].faai016, 
       g_faah3_d[l_ac].faai017,g_faah3_d[l_ac].faai018,g_faah3_d[l_ac].faai019,g_faah3_d[l_ac].faai020, 
       g_faah3_d[l_ac].faai021,g_faah3_d[l_ac].faai022,g_faah3_d[l_ac].faai023   #(ver:45) #(ver:46) 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充 name="fetch.fill2"
      
      #end add-point
      
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
      LET l_ac = l_ac + 1
      
   END FOREACH
 
   IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.body3.long_sql_if"
      
      #end add-point
   THEN
      LET g_sql = "SELECT  DISTINCT t0.faajld,t0.faaj003,t0.faaj004,t0.faaj005,t0.faaj006,t0.faaj007, 
          t0.faaj008,t0.faaj009,t0.faaj010,t0.faaj011,t0.faaj012,t0.faaj013,t0.faaj014,t0.faaj015,t0.faaj016, 
          t0.faaj017,t0.faaj018,t0.faaj019,t0.faaj020,t0.faaj021,t0.faaj022,t0.faaj023,t0.faaj024,t0.faaj025, 
          t0.faaj026,t0.faaj027,t0.faaj028,t0.faaj029,t0.faaj030,t0.faaj031,t0.faaj032,t0.faaj033,t0.faaj034, 
          t0.faaj035,t0.faaj036,t0.faaj038,t0.faaj039,t0.faaj040,t0.faaj041,t0.faaj042,t0.faaj043,t0.faaj044, 
          t0.faaj045,t0.faaj046,t0.faaj047,t0.faaj101,t0.faaj102,t0.faaj103,t0.faaj104,t0.faaj105,t0.faaj106, 
          t0.faaj107,t0.faaj108,t0.faaj109,t0.faaj110,t0.faaj111,t0.faaj112,t0.faaj113,t0.faaj114,t0.faaj115, 
          t0.faaj116,t0.faaj117,t0.faaj151,t0.faaj152,t0.faaj153,t0.faaj154,t0.faaj155,t0.faaj156,t0.faaj157, 
          t0.faaj158,t0.faaj159,t0.faaj160,t0.faaj161,t0.faaj162,t0.faaj163,t0.faaj164,t0.faaj165,t0.faaj166, 
          t0.faaj167,t0.faajsite ,t21.glaal002 ,t22.pmaal003 FROM faaj_t t0",    
                  "",
                                 " LEFT JOIN glaal_t t21 ON t21.glaalent="||g_enterprise||" AND t21.glaalld=t0.faajld AND t21.glaal001='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t22 ON t22.pmaalent="||g_enterprise||" AND t22.pmaal001=t0.faaj043 AND t22.pmaal002='"||g_dlang||"' ",
 
                  " WHERE t0.faajent=?  AND t0. faaj000=?  AND t0. faaj037=?  AND t0. faaj001=?  AND t0. faaj002=?"
      #add-point:單身sql wc name="fetch.sql_wc3"
      
      #end add-point
      IF NOT cl_null(g_wc2_table3) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
      END IF
      
      LET g_sql = g_sql, " ORDER BY t0.faajld" 
                         
      #add-point:單身填充前 name="fetch.before_fill3"
      
      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料    
      PREPARE afat300_pb3 FROM g_sql
      DECLARE b_fill_curs3 CURSOR FOR afat300_pb3
   END IF
   
#  LET l_ac = g_detail_idx   #(ver:45)
#  OPEN b_fill_curs3 USING g_enterprise,g_faah_d[l_ac].faah000,g_faah_d[l_ac].faah001,g_faah_d[l_ac].faah003, 
#    g_faah_d[l_ac].faah004   #(ver:45)
   
   LET l_ac = 1
#  FOREACH b_fill_curs3 USING g_enterprise,g_faah_d[l_ac].faah000,g_faah_d[l_ac].faah001,g_faah_d[l_ac].faah003, 
#    g_faah_d[l_ac].faah004 INTO g_faah4_d[l_ac].faajld,g_faah4_d[l_ac].faaj003,g_faah4_d[l_ac].faaj004, 
#    g_faah4_d[l_ac].faaj005,g_faah4_d[l_ac].faaj006,g_faah4_d[l_ac].faaj007,g_faah4_d[l_ac].faaj008, 
#    g_faah4_d[l_ac].faaj009,g_faah4_d[l_ac].faaj010,g_faah4_d[l_ac].faaj011,g_faah4_d[l_ac].faaj012, 
#    g_faah4_d[l_ac].faaj013,g_faah4_d[l_ac].faaj014,g_faah4_d[l_ac].faaj015,g_faah4_d[l_ac].faaj016, 
#    g_faah4_d[l_ac].faaj017,g_faah4_d[l_ac].faaj018,g_faah4_d[l_ac].faaj019,g_faah4_d[l_ac].faaj020, 
#    g_faah4_d[l_ac].faaj021,g_faah4_d[l_ac].faaj022,g_faah4_d[l_ac].faaj023,g_faah4_d[l_ac].faaj024, 
#    g_faah4_d[l_ac].faaj025,g_faah4_d[l_ac].faaj026,g_faah4_d[l_ac].faaj027,g_faah4_d[l_ac].faaj028, 
#    g_faah4_d[l_ac].faaj029,g_faah4_d[l_ac].faaj030,g_faah4_d[l_ac].faaj031,g_faah4_d[l_ac].faaj032, 
#    g_faah4_d[l_ac].faaj033,g_faah4_d[l_ac].faaj034,g_faah4_d[l_ac].faaj035,g_faah4_d[l_ac].faaj036, 
#    g_faah4_d[l_ac].faaj038,g_faah4_d[l_ac].faaj039,g_faah4_d[l_ac].faaj040,g_faah4_d[l_ac].faaj041, 
#    g_faah4_d[l_ac].faaj042,g_faah4_d[l_ac].faaj043,g_faah4_d[l_ac].faaj044,g_faah4_d[l_ac].faaj045, 
#    g_faah4_d[l_ac].faaj046,g_faah4_d[l_ac].faaj047,g_faah4_d[l_ac].faaj101,g_faah4_d[l_ac].faaj102, 
#    g_faah4_d[l_ac].faaj103,g_faah4_d[l_ac].faaj104,g_faah4_d[l_ac].faaj105,g_faah4_d[l_ac].faaj106, 
#    g_faah4_d[l_ac].faaj107,g_faah4_d[l_ac].faaj108,g_faah4_d[l_ac].faaj109,g_faah4_d[l_ac].faaj110, 
#    g_faah4_d[l_ac].faaj111,g_faah4_d[l_ac].faaj112,g_faah4_d[l_ac].faaj113,g_faah4_d[l_ac].faaj114, 
#    g_faah4_d[l_ac].faaj115,g_faah4_d[l_ac].faaj116,g_faah4_d[l_ac].faaj117,g_faah4_d[l_ac].faaj151, 
#    g_faah4_d[l_ac].faaj152,g_faah4_d[l_ac].faaj153,g_faah4_d[l_ac].faaj154,g_faah4_d[l_ac].faaj155, 
#    g_faah4_d[l_ac].faaj156,g_faah4_d[l_ac].faaj157,g_faah4_d[l_ac].faaj158,g_faah4_d[l_ac].faaj159, 
#    g_faah4_d[l_ac].faaj160,g_faah4_d[l_ac].faaj161,g_faah4_d[l_ac].faaj162,g_faah4_d[l_ac].faaj163, 
#    g_faah4_d[l_ac].faaj164,g_faah4_d[l_ac].faaj165,g_faah4_d[l_ac].faaj166,g_faah4_d[l_ac].faaj167, 
#    g_faah4_d[l_ac].faajsite,g_faah4_d[l_ac].faajld_desc,g_faah4_d[l_ac].faaj043_desc   #(ver:45) #(ver:46)mark 
 
   FOREACH b_fill_curs3 USING g_enterprise,g_faah_d[g_detail_idx].faah000,g_faah_d[g_detail_idx].faah001, 
       g_faah_d[g_detail_idx].faah003,g_faah_d[g_detail_idx].faah004 INTO g_faah4_d[l_ac].faajld,g_faah4_d[l_ac].faaj003, 
       g_faah4_d[l_ac].faaj004,g_faah4_d[l_ac].faaj005,g_faah4_d[l_ac].faaj006,g_faah4_d[l_ac].faaj007, 
       g_faah4_d[l_ac].faaj008,g_faah4_d[l_ac].faaj009,g_faah4_d[l_ac].faaj010,g_faah4_d[l_ac].faaj011, 
       g_faah4_d[l_ac].faaj012,g_faah4_d[l_ac].faaj013,g_faah4_d[l_ac].faaj014,g_faah4_d[l_ac].faaj015, 
       g_faah4_d[l_ac].faaj016,g_faah4_d[l_ac].faaj017,g_faah4_d[l_ac].faaj018,g_faah4_d[l_ac].faaj019, 
       g_faah4_d[l_ac].faaj020,g_faah4_d[l_ac].faaj021,g_faah4_d[l_ac].faaj022,g_faah4_d[l_ac].faaj023, 
       g_faah4_d[l_ac].faaj024,g_faah4_d[l_ac].faaj025,g_faah4_d[l_ac].faaj026,g_faah4_d[l_ac].faaj027, 
       g_faah4_d[l_ac].faaj028,g_faah4_d[l_ac].faaj029,g_faah4_d[l_ac].faaj030,g_faah4_d[l_ac].faaj031, 
       g_faah4_d[l_ac].faaj032,g_faah4_d[l_ac].faaj033,g_faah4_d[l_ac].faaj034,g_faah4_d[l_ac].faaj035, 
       g_faah4_d[l_ac].faaj036,g_faah4_d[l_ac].faaj038,g_faah4_d[l_ac].faaj039,g_faah4_d[l_ac].faaj040, 
       g_faah4_d[l_ac].faaj041,g_faah4_d[l_ac].faaj042,g_faah4_d[l_ac].faaj043,g_faah4_d[l_ac].faaj044, 
       g_faah4_d[l_ac].faaj045,g_faah4_d[l_ac].faaj046,g_faah4_d[l_ac].faaj047,g_faah4_d[l_ac].faaj101, 
       g_faah4_d[l_ac].faaj102,g_faah4_d[l_ac].faaj103,g_faah4_d[l_ac].faaj104,g_faah4_d[l_ac].faaj105, 
       g_faah4_d[l_ac].faaj106,g_faah4_d[l_ac].faaj107,g_faah4_d[l_ac].faaj108,g_faah4_d[l_ac].faaj109, 
       g_faah4_d[l_ac].faaj110,g_faah4_d[l_ac].faaj111,g_faah4_d[l_ac].faaj112,g_faah4_d[l_ac].faaj113, 
       g_faah4_d[l_ac].faaj114,g_faah4_d[l_ac].faaj115,g_faah4_d[l_ac].faaj116,g_faah4_d[l_ac].faaj117, 
       g_faah4_d[l_ac].faaj151,g_faah4_d[l_ac].faaj152,g_faah4_d[l_ac].faaj153,g_faah4_d[l_ac].faaj154, 
       g_faah4_d[l_ac].faaj155,g_faah4_d[l_ac].faaj156,g_faah4_d[l_ac].faaj157,g_faah4_d[l_ac].faaj158, 
       g_faah4_d[l_ac].faaj159,g_faah4_d[l_ac].faaj160,g_faah4_d[l_ac].faaj161,g_faah4_d[l_ac].faaj162, 
       g_faah4_d[l_ac].faaj163,g_faah4_d[l_ac].faaj164,g_faah4_d[l_ac].faaj165,g_faah4_d[l_ac].faaj166, 
       g_faah4_d[l_ac].faaj167,g_faah4_d[l_ac].faajsite,g_faah4_d[l_ac].faajld_desc,g_faah4_d[l_ac].faaj043_desc  
         #(ver:45) #(ver:46)
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充 name="fetch.fill3"
      
      #end add-point
      
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
      LET l_ac = l_ac + 1
      
   END FOREACH
 
 
 
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point
   
   #CALL g_faah2_d.deleteElement(g_faah2_d.getLength())   
   CALL g_faah3_d.deleteElement(g_faah3_d.getLength())   
   CALL g_faah4_d.deleteElement(g_faah4_d.getLength())   
 
   
   LET g_faah3_d_mask_o.* =  g_faah3_d.*
   FOR l_ac = 1 TO g_faah3_d.getLength()
      LET g_faah3_d_mask_o[l_ac].* =  g_faah3_d[l_ac].*
      CALL afat300_faai_t_mask()
      LET g_faah3_d_mask_n[l_ac].* =  g_faah3_d[l_ac].*
   END FOR
   LET g_faah4_d_mask_o.* =  g_faah4_d.*
   FOR l_ac = 1 TO g_faah4_d.getLength()
      LET g_faah4_d_mask_o[l_ac].* =  g_faah4_d[l_ac].*
      CALL afat300_faaj_t_mask()
      LET g_faah4_d_mask_n[l_ac].* =  g_faah4_d[l_ac].*
   END FOR
 
   
   DISPLAY g_faah3_d.getLength() TO FORMONLY.cnt
   #LET g_loc = 'd'
   CALL afat300_detail_show()
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="afat300.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION afat300_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   DEFINE l_ac_t LIKE type_t.num10
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="detail_show.pre_function"
   
   #end add-point
   
   LET l_ac_t = l_ac
 
   #add-point:detail_show段之前 name="detail_show.before"
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
   #帶出公用欄位reference值page2
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   #帶出公用欄位reference值page3
   
   #帶出公用欄位reference值page4
   
 
   
   IF g_loc = 'm' THEN
      #讀入ref值
      FOR l_ac = 1 TO g_faah_d.getLength()
         #add-point:show段單頭reference name="detail_show.body.reference"
         
         #end add-point
         #add-point:show段單頭reference name="detail_show.body2.reference"
         
         #end add-point
 
      END FOR
   END IF
   
   IF g_loc = 'd' THEN
      FOR l_ac = 1 TO g_faah3_d.getLength()
        #add-point:show段單身reference name="detail_show.body3.reference"
        
        #end add-point
      END FOR
      FOR l_ac = 1 TO g_faah4_d.getLength()
        #add-point:show段單身reference name="detail_show.body4.reference"
        
        #end add-point
      END FOR
 
      
      #add-point:detail_show段之後 name="detail_show.after"
      
      #end add-point
   END IF
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="afat300.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION afat300_set_entry_b(p_cmd)                                                  
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1         
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="set_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry_b段欄位控制 name="set_entry_b.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_entry_b段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
                                                                     
END FUNCTION                                                                    
 
{</section>}
 
{<section id="afat300.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION afat300_set_no_entry_b(p_cmd)                                               
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1           
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
                                                                          
END FUNCTION  
 
{</section>}
 
{<section id="afat300.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION afat300_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization"
   
   #end add-point  
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point  
  
   #add-point:Function前置處理  name="default_search.before"
   
   #end add-point  
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " faah000 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " faah001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " faah003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " faah004 = '", g_argv[04], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET ls_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_wc = ls_wc
   ELSE
      LET g_wc = " 1=2"
   END IF
   
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="afat300.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION afat300_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
  
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "faah_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.before_delete"
      
      #end add-point  
      DELETE FROM faah_t
       WHERE faahent = g_enterprise AND
         faah000 = ps_keys_bak[1] AND faah001 = ps_keys_bak[2] AND faah003 = ps_keys_bak[3] AND faah004 = ps_keys_bak[4]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
      
      #end add-point  
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ":",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:delete_b段刪除後 name="delete_b.after_delete"
      
      #end add-point  
   END IF
   
 
   
   LET ls_group = "faai_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.before_delete2"
      
      #end add-point  
      DELETE FROM faai_t
       WHERE faaient = g_enterprise AND
         faai000 = ps_keys_bak[1] AND faai001 = ps_keys_bak[2] AND faai002 = ps_keys_bak[3] AND faai003 = ps_keys_bak[4] AND faaiseq = ps_keys_bak[5]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point  
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "faai_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:delete_b段刪除後 name="delete_b.after_delete2"
      
      #end add-point  
      RETURN
   END IF
 
   LET ls_group = "faaj_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.before_delete3"
      
      #end add-point  
      DELETE FROM faaj_t
       WHERE faajent = g_enterprise AND
         faaj000 = ps_keys_bak[1] AND faaj037 = ps_keys_bak[2] AND faaj001 = ps_keys_bak[3] AND faaj002 = ps_keys_bak[4] AND faajld = ps_keys_bak[5]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
      
      #end add-point  
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "faaj_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:delete_b段刪除後 name="delete_b.after_delete3"
      
      #end add-point  
      RETURN
   END IF
 
 
   
   #單頭刪除, 連帶刪除單身
   LET ls_group = "faah_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.before_body_delete2"
      
      #end add-point  
      DELETE FROM faai_t
       WHERE faaient = g_enterprise AND
         faai000 = ps_keys_bak[1] AND faai001 = ps_keys_bak[2] AND faai002 = ps_keys_bak[3] AND faai003 = ps_keys_bak[4]
      #add-point:delete_b段刪除中 name="delete_b.m_body_delete2"
      
      #end add-point  
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "faai_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:delete_b段刪除後 name="delete_b.after_body_delete2"
      
      #end add-point  
      RETURN
   END IF
 
   #單頭刪除, 連帶刪除單身
   LET ls_group = "faah_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.before_body_delete3"
      
      #end add-point  
      DELETE FROM faaj_t
       WHERE faajent = g_enterprise AND
         faaj000 = ps_keys_bak[1] AND faaj037 = ps_keys_bak[2] AND faaj001 = ps_keys_bak[3] AND faaj002 = ps_keys_bak[4]
      #add-point:delete_b段刪除中 name="delete_b.m_body_delete3"
      
      #end add-point  
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "faaj_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:delete_b段刪除後 name="delete_b.after_body_delete3"
      
      #end add-point  
      RETURN
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="afat300.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION afat300_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point
  
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "faah_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前 name="insert_b.before_insert"
      
      #end add-point
      INSERT INTO faah_t
                  (faahent,
                   faah000,faah001,faah003,faah004
                   ,faah002,faah005,faah006,faah007,faah008,faah009,faah010,faah011,faah012,faah013,faah014,faah015,faah016,faah017,faah018,faah019,faah020,faah021,faah022,faah023,faah024,faah025,faah026,faah027,faah028,faah029,faah030,faah031,faah032,faah033,faah034,faah035,faah036,faah037,faah038,faah039,faah040,faah041,faah042,faah043,faah044,faah045,faahownid,faahowndp,faahcrtid,faahcrtdp,faahcrtdt,faahmodid,faahmoddt) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_faah_d[g_detail_idx].faah002,g_faah_d[g_detail_idx].faah005,g_faah_d[g_detail_idx].faah006, 
                       g_faah_d[g_detail_idx].faah007,g_faah_d[g_detail_idx].faah008,g_faah_d[g_detail_idx].faah009, 
                       g_faah_d[g_detail_idx].faah010,g_faah_d[g_detail_idx].faah011,g_faah_d[g_detail_idx].faah012, 
                       g_faah_d[g_detail_idx].faah013,g_faah_d[g_detail_idx].faah014,g_faah_d[g_detail_idx].faah015, 
                       g_faah_d[g_detail_idx].faah016,g_faah_d[g_detail_idx].faah017,g_faah_d[g_detail_idx].faah018, 
                       g_faah_d[g_detail_idx].faah019,g_faah_d[g_detail_idx].faah020,g_faah_d[g_detail_idx].faah021, 
                       g_faah_d[g_detail_idx].faah022,g_faah_d[g_detail_idx].faah023,g_faah_d[g_detail_idx].faah024, 
                       g_faah_d[g_detail_idx].faah025,g_faah_d[g_detail_idx].faah026,g_faah_d[g_detail_idx].faah027, 
                       g_faah_d[g_detail_idx].faah028,g_faah_d[g_detail_idx].faah029,g_faah_d[g_detail_idx].faah030, 
                       g_faah_d[g_detail_idx].faah031,g_faah_d[g_detail_idx].faah032,g_faah_d[g_detail_idx].faah033, 
                       g_faah_d[g_detail_idx].faah034,g_faah_d[g_detail_idx].faah035,g_faah_d[g_detail_idx].faah036, 
                       g_faah_d[g_detail_idx].faah037,g_faah_d[g_detail_idx].faah038,g_faah_d[g_detail_idx].faah039, 
                       g_faah_d[g_detail_idx].faah040,g_faah_d[g_detail_idx].faah041,g_faah_d[g_detail_idx].faah042, 
                       g_faah_d[g_detail_idx].faah043,g_faah_d[g_detail_idx].faah044,g_faah_d[g_detail_idx].faah045, 
                       g_faah2_d[g_detail_idx].faahownid,g_faah2_d[g_detail_idx].faahowndp,g_faah2_d[g_detail_idx].faahcrtid, 
                       g_faah2_d[g_detail_idx].faahcrtdp,g_faah2_d[g_detail_idx].faahcrtdt,g_faah2_d[g_detail_idx].faahmodid, 
                       g_faah2_d[g_detail_idx].faahmoddt)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "faah_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.after_insert"
      
      #end add-point
   END IF
   
 
   
   LET ls_group = "faai_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前 name="insert_b.before_insert2"
      
      #end add-point
      INSERT INTO faai_t
                  (faaient,
                   faai000,faai001,faai002,faai003,faaiseq
                   ,faai004,faai005,faai006,faai007,faai008,faai009,faai010,faai011,faai012,faai013,faai014,faai015,faai016,faai017,faai018,faai019,faai020,faai021,faai022,faai023) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5]
                   ,g_faah3_d[g_detail_idx2].faai004,g_faah3_d[g_detail_idx2].faai005,g_faah3_d[g_detail_idx2].faai006, 
                       g_faah3_d[g_detail_idx2].faai007,g_faah3_d[g_detail_idx2].faai008,g_faah3_d[g_detail_idx2].faai009, 
                       g_faah3_d[g_detail_idx2].faai010,g_faah3_d[g_detail_idx2].faai011,g_faah3_d[g_detail_idx2].faai012, 
                       g_faah3_d[g_detail_idx2].faai013,g_faah3_d[g_detail_idx2].faai014,g_faah3_d[g_detail_idx2].faai015, 
                       g_faah3_d[g_detail_idx2].faai016,g_faah3_d[g_detail_idx2].faai017,g_faah3_d[g_detail_idx2].faai018, 
                       g_faah3_d[g_detail_idx2].faai019,g_faah3_d[g_detail_idx2].faai020,g_faah3_d[g_detail_idx2].faai021, 
                       g_faah3_d[g_detail_idx2].faai022,g_faah3_d[g_detail_idx2].faai023)
      #add-point:insert_b段新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         RETURN
      END IF
      #add-point:insert_b段新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
   LET ls_group = "faaj_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前 name="insert_b.before_insert3"
      
      #end add-point
      INSERT INTO faaj_t
                  (faajent,
                   faaj000,faaj037,faaj001,faaj002,faajld
                   ,faaj003,faaj004,faaj005,faaj006,faaj007,faaj008,faaj009,faaj010,faaj011,faaj012,faaj013,faaj014,faaj015,faaj016,faaj017,faaj018,faaj019,faaj020,faaj021,faaj022,faaj023,faaj024,faaj025,faaj026,faaj027,faaj028,faaj029,faaj030,faaj031,faaj032,faaj033,faaj034,faaj035,faaj036,faaj038,faaj039,faaj040,faaj041,faaj042,faaj043,faaj044,faaj045,faaj046,faaj047,faaj101,faaj102,faaj103,faaj104,faaj105,faaj106,faaj107,faaj108,faaj109,faaj110,faaj111,faaj112,faaj113,faaj114,faaj115,faaj116,faaj117,faaj151,faaj152,faaj153,faaj154,faaj155,faaj156,faaj157,faaj158,faaj159,faaj160,faaj161,faaj162,faaj163,faaj164,faaj165,faaj166,faaj167,faajsite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5]
                   ,g_faah4_d[g_detail_idx2].faaj003,g_faah4_d[g_detail_idx2].faaj004,g_faah4_d[g_detail_idx2].faaj005, 
                       g_faah4_d[g_detail_idx2].faaj006,g_faah4_d[g_detail_idx2].faaj007,g_faah4_d[g_detail_idx2].faaj008, 
                       g_faah4_d[g_detail_idx2].faaj009,g_faah4_d[g_detail_idx2].faaj010,g_faah4_d[g_detail_idx2].faaj011, 
                       g_faah4_d[g_detail_idx2].faaj012,g_faah4_d[g_detail_idx2].faaj013,g_faah4_d[g_detail_idx2].faaj014, 
                       g_faah4_d[g_detail_idx2].faaj015,g_faah4_d[g_detail_idx2].faaj016,g_faah4_d[g_detail_idx2].faaj017, 
                       g_faah4_d[g_detail_idx2].faaj018,g_faah4_d[g_detail_idx2].faaj019,g_faah4_d[g_detail_idx2].faaj020, 
                       g_faah4_d[g_detail_idx2].faaj021,g_faah4_d[g_detail_idx2].faaj022,g_faah4_d[g_detail_idx2].faaj023, 
                       g_faah4_d[g_detail_idx2].faaj024,g_faah4_d[g_detail_idx2].faaj025,g_faah4_d[g_detail_idx2].faaj026, 
                       g_faah4_d[g_detail_idx2].faaj027,g_faah4_d[g_detail_idx2].faaj028,g_faah4_d[g_detail_idx2].faaj029, 
                       g_faah4_d[g_detail_idx2].faaj030,g_faah4_d[g_detail_idx2].faaj031,g_faah4_d[g_detail_idx2].faaj032, 
                       g_faah4_d[g_detail_idx2].faaj033,g_faah4_d[g_detail_idx2].faaj034,g_faah4_d[g_detail_idx2].faaj035, 
                       g_faah4_d[g_detail_idx2].faaj036,g_faah4_d[g_detail_idx2].faaj038,g_faah4_d[g_detail_idx2].faaj039, 
                       g_faah4_d[g_detail_idx2].faaj040,g_faah4_d[g_detail_idx2].faaj041,g_faah4_d[g_detail_idx2].faaj042, 
                       g_faah4_d[g_detail_idx2].faaj043,g_faah4_d[g_detail_idx2].faaj044,g_faah4_d[g_detail_idx2].faaj045, 
                       g_faah4_d[g_detail_idx2].faaj046,g_faah4_d[g_detail_idx2].faaj047,g_faah4_d[g_detail_idx2].faaj101, 
                       g_faah4_d[g_detail_idx2].faaj102,g_faah4_d[g_detail_idx2].faaj103,g_faah4_d[g_detail_idx2].faaj104, 
                       g_faah4_d[g_detail_idx2].faaj105,g_faah4_d[g_detail_idx2].faaj106,g_faah4_d[g_detail_idx2].faaj107, 
                       g_faah4_d[g_detail_idx2].faaj108,g_faah4_d[g_detail_idx2].faaj109,g_faah4_d[g_detail_idx2].faaj110, 
                       g_faah4_d[g_detail_idx2].faaj111,g_faah4_d[g_detail_idx2].faaj112,g_faah4_d[g_detail_idx2].faaj113, 
                       g_faah4_d[g_detail_idx2].faaj114,g_faah4_d[g_detail_idx2].faaj115,g_faah4_d[g_detail_idx2].faaj116, 
                       g_faah4_d[g_detail_idx2].faaj117,g_faah4_d[g_detail_idx2].faaj151,g_faah4_d[g_detail_idx2].faaj152, 
                       g_faah4_d[g_detail_idx2].faaj153,g_faah4_d[g_detail_idx2].faaj154,g_faah4_d[g_detail_idx2].faaj155, 
                       g_faah4_d[g_detail_idx2].faaj156,g_faah4_d[g_detail_idx2].faaj157,g_faah4_d[g_detail_idx2].faaj158, 
                       g_faah4_d[g_detail_idx2].faaj159,g_faah4_d[g_detail_idx2].faaj160,g_faah4_d[g_detail_idx2].faaj161, 
                       g_faah4_d[g_detail_idx2].faaj162,g_faah4_d[g_detail_idx2].faaj163,g_faah4_d[g_detail_idx2].faaj164, 
                       g_faah4_d[g_detail_idx2].faaj165,g_faah4_d[g_detail_idx2].faaj166,g_faah4_d[g_detail_idx2].faaj167, 
                       g_faah4_d[g_detail_idx2].faajsite)
      #add-point:insert_b段新增中 name="insert_b.m_insert3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         RETURN
      END IF
      #add-point:insert_b段新增後 name="insert_b.after_insert3"
      
      #end add-point
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="afat300.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION afat300_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define(客製用) name="update_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="update_b.define"
   
   #end add-point     
  
   #add-point:Function前置處理  name="update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR
   
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
   
   #判斷是否是同一群組的table
   LET ls_group = "faah_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "faah_t" THEN
   
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point     
   
      #將遮罩欄位還原
      CALL afat300_faah_t_mask_restore('restore_mask_o')
               
      UPDATE faah_t 
         SET (faah000,faah001,faah003,faah004
              ,faah002,faah005,faah006,faah007,faah008,faah009,faah010,faah011,faah012,faah013,faah014,faah015,faah016,faah017,faah018,faah019,faah020,faah021,faah022,faah023,faah024,faah025,faah026,faah027,faah028,faah029,faah030,faah031,faah032,faah033,faah034,faah035,faah036,faah037,faah038,faah039,faah040,faah041,faah042,faah043,faah044,faah045,faahownid,faahowndp,faahcrtid,faahcrtdp,faahcrtdt,faahmodid,faahmoddt) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_faah_d[g_detail_idx].faah002,g_faah_d[g_detail_idx].faah005,g_faah_d[g_detail_idx].faah006, 
                  g_faah_d[g_detail_idx].faah007,g_faah_d[g_detail_idx].faah008,g_faah_d[g_detail_idx].faah009, 
                  g_faah_d[g_detail_idx].faah010,g_faah_d[g_detail_idx].faah011,g_faah_d[g_detail_idx].faah012, 
                  g_faah_d[g_detail_idx].faah013,g_faah_d[g_detail_idx].faah014,g_faah_d[g_detail_idx].faah015, 
                  g_faah_d[g_detail_idx].faah016,g_faah_d[g_detail_idx].faah017,g_faah_d[g_detail_idx].faah018, 
                  g_faah_d[g_detail_idx].faah019,g_faah_d[g_detail_idx].faah020,g_faah_d[g_detail_idx].faah021, 
                  g_faah_d[g_detail_idx].faah022,g_faah_d[g_detail_idx].faah023,g_faah_d[g_detail_idx].faah024, 
                  g_faah_d[g_detail_idx].faah025,g_faah_d[g_detail_idx].faah026,g_faah_d[g_detail_idx].faah027, 
                  g_faah_d[g_detail_idx].faah028,g_faah_d[g_detail_idx].faah029,g_faah_d[g_detail_idx].faah030, 
                  g_faah_d[g_detail_idx].faah031,g_faah_d[g_detail_idx].faah032,g_faah_d[g_detail_idx].faah033, 
                  g_faah_d[g_detail_idx].faah034,g_faah_d[g_detail_idx].faah035,g_faah_d[g_detail_idx].faah036, 
                  g_faah_d[g_detail_idx].faah037,g_faah_d[g_detail_idx].faah038,g_faah_d[g_detail_idx].faah039, 
                  g_faah_d[g_detail_idx].faah040,g_faah_d[g_detail_idx].faah041,g_faah_d[g_detail_idx].faah042, 
                  g_faah_d[g_detail_idx].faah043,g_faah_d[g_detail_idx].faah044,g_faah_d[g_detail_idx].faah045, 
                  g_faah2_d[g_detail_idx].faahownid,g_faah2_d[g_detail_idx].faahowndp,g_faah2_d[g_detail_idx].faahcrtid, 
                  g_faah2_d[g_detail_idx].faahcrtdp,g_faah2_d[g_detail_idx].faahcrtdt,g_faah2_d[g_detail_idx].faahmodid, 
                  g_faah2_d[g_detail_idx].faahmoddt) 
         WHERE faahent = g_enterprise AND
               faah000 = ps_keys_bak[1] AND faah001 = ps_keys_bak[2] AND faah003 = ps_keys_bak[3] AND faah004 = ps_keys_bak[4]
 
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "faah_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "faah_t:",SQLERRMESSAGE  
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            
      END CASE
 
      #將遮罩欄位進行遮蔽
      CALL afat300_faah_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
   LET ls_group = "faai_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "faai_t" THEN
   
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point    
      
      #將遮罩欄位還原
      CALL afat300_faai_t_mask_restore('restore_mask_o')
      
      UPDATE faai_t 
         SET (faai000,faai001,faai002,faai003,faaiseq
              ,faai004,faai005,faai006,faai007,faai008,faai009,faai010,faai011,faai012,faai013,faai014,faai015,faai016,faai017,faai018,faai019,faai020,faai021,faai022,faai023) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5]
              ,g_faah3_d[g_detail_idx2].faai004,g_faah3_d[g_detail_idx2].faai005,g_faah3_d[g_detail_idx2].faai006, 
                  g_faah3_d[g_detail_idx2].faai007,g_faah3_d[g_detail_idx2].faai008,g_faah3_d[g_detail_idx2].faai009, 
                  g_faah3_d[g_detail_idx2].faai010,g_faah3_d[g_detail_idx2].faai011,g_faah3_d[g_detail_idx2].faai012, 
                  g_faah3_d[g_detail_idx2].faai013,g_faah3_d[g_detail_idx2].faai014,g_faah3_d[g_detail_idx2].faai015, 
                  g_faah3_d[g_detail_idx2].faai016,g_faah3_d[g_detail_idx2].faai017,g_faah3_d[g_detail_idx2].faai018, 
                  g_faah3_d[g_detail_idx2].faai019,g_faah3_d[g_detail_idx2].faai020,g_faah3_d[g_detail_idx2].faai021, 
                  g_faah3_d[g_detail_idx2].faai022,g_faah3_d[g_detail_idx2].faai023) 
         WHERE faaient = g_enterprise AND
               faai000 = ps_keys_bak[1] AND faai001 = ps_keys_bak[2] AND faai002 = ps_keys_bak[3] AND faai003 = ps_keys_bak[4] AND faaiseq = ps_keys_bak[5]
 
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "faai_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "faai_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL afat300_faai_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point 
      
      RETURN
   END IF
 
   LET ls_group = "faaj_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "faaj_t" THEN
   
      #add-point:update_b段修改前 name="update_b.before_update3"
      
      #end add-point    
      
      #將遮罩欄位還原
      CALL afat300_faaj_t_mask_restore('restore_mask_o')
      
      UPDATE faaj_t 
         SET (faaj000,faaj037,faaj001,faaj002,faajld
              ,faaj003,faaj004,faaj005,faaj006,faaj007,faaj008,faaj009,faaj010,faaj011,faaj012,faaj013,faaj014,faaj015,faaj016,faaj017,faaj018,faaj019,faaj020,faaj021,faaj022,faaj023,faaj024,faaj025,faaj026,faaj027,faaj028,faaj029,faaj030,faaj031,faaj032,faaj033,faaj034,faaj035,faaj036,faaj038,faaj039,faaj040,faaj041,faaj042,faaj043,faaj044,faaj045,faaj046,faaj047,faaj101,faaj102,faaj103,faaj104,faaj105,faaj106,faaj107,faaj108,faaj109,faaj110,faaj111,faaj112,faaj113,faaj114,faaj115,faaj116,faaj117,faaj151,faaj152,faaj153,faaj154,faaj155,faaj156,faaj157,faaj158,faaj159,faaj160,faaj161,faaj162,faaj163,faaj164,faaj165,faaj166,faaj167,faajsite) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5]
              ,g_faah4_d[g_detail_idx2].faaj003,g_faah4_d[g_detail_idx2].faaj004,g_faah4_d[g_detail_idx2].faaj005, 
                  g_faah4_d[g_detail_idx2].faaj006,g_faah4_d[g_detail_idx2].faaj007,g_faah4_d[g_detail_idx2].faaj008, 
                  g_faah4_d[g_detail_idx2].faaj009,g_faah4_d[g_detail_idx2].faaj010,g_faah4_d[g_detail_idx2].faaj011, 
                  g_faah4_d[g_detail_idx2].faaj012,g_faah4_d[g_detail_idx2].faaj013,g_faah4_d[g_detail_idx2].faaj014, 
                  g_faah4_d[g_detail_idx2].faaj015,g_faah4_d[g_detail_idx2].faaj016,g_faah4_d[g_detail_idx2].faaj017, 
                  g_faah4_d[g_detail_idx2].faaj018,g_faah4_d[g_detail_idx2].faaj019,g_faah4_d[g_detail_idx2].faaj020, 
                  g_faah4_d[g_detail_idx2].faaj021,g_faah4_d[g_detail_idx2].faaj022,g_faah4_d[g_detail_idx2].faaj023, 
                  g_faah4_d[g_detail_idx2].faaj024,g_faah4_d[g_detail_idx2].faaj025,g_faah4_d[g_detail_idx2].faaj026, 
                  g_faah4_d[g_detail_idx2].faaj027,g_faah4_d[g_detail_idx2].faaj028,g_faah4_d[g_detail_idx2].faaj029, 
                  g_faah4_d[g_detail_idx2].faaj030,g_faah4_d[g_detail_idx2].faaj031,g_faah4_d[g_detail_idx2].faaj032, 
                  g_faah4_d[g_detail_idx2].faaj033,g_faah4_d[g_detail_idx2].faaj034,g_faah4_d[g_detail_idx2].faaj035, 
                  g_faah4_d[g_detail_idx2].faaj036,g_faah4_d[g_detail_idx2].faaj038,g_faah4_d[g_detail_idx2].faaj039, 
                  g_faah4_d[g_detail_idx2].faaj040,g_faah4_d[g_detail_idx2].faaj041,g_faah4_d[g_detail_idx2].faaj042, 
                  g_faah4_d[g_detail_idx2].faaj043,g_faah4_d[g_detail_idx2].faaj044,g_faah4_d[g_detail_idx2].faaj045, 
                  g_faah4_d[g_detail_idx2].faaj046,g_faah4_d[g_detail_idx2].faaj047,g_faah4_d[g_detail_idx2].faaj101, 
                  g_faah4_d[g_detail_idx2].faaj102,g_faah4_d[g_detail_idx2].faaj103,g_faah4_d[g_detail_idx2].faaj104, 
                  g_faah4_d[g_detail_idx2].faaj105,g_faah4_d[g_detail_idx2].faaj106,g_faah4_d[g_detail_idx2].faaj107, 
                  g_faah4_d[g_detail_idx2].faaj108,g_faah4_d[g_detail_idx2].faaj109,g_faah4_d[g_detail_idx2].faaj110, 
                  g_faah4_d[g_detail_idx2].faaj111,g_faah4_d[g_detail_idx2].faaj112,g_faah4_d[g_detail_idx2].faaj113, 
                  g_faah4_d[g_detail_idx2].faaj114,g_faah4_d[g_detail_idx2].faaj115,g_faah4_d[g_detail_idx2].faaj116, 
                  g_faah4_d[g_detail_idx2].faaj117,g_faah4_d[g_detail_idx2].faaj151,g_faah4_d[g_detail_idx2].faaj152, 
                  g_faah4_d[g_detail_idx2].faaj153,g_faah4_d[g_detail_idx2].faaj154,g_faah4_d[g_detail_idx2].faaj155, 
                  g_faah4_d[g_detail_idx2].faaj156,g_faah4_d[g_detail_idx2].faaj157,g_faah4_d[g_detail_idx2].faaj158, 
                  g_faah4_d[g_detail_idx2].faaj159,g_faah4_d[g_detail_idx2].faaj160,g_faah4_d[g_detail_idx2].faaj161, 
                  g_faah4_d[g_detail_idx2].faaj162,g_faah4_d[g_detail_idx2].faaj163,g_faah4_d[g_detail_idx2].faaj164, 
                  g_faah4_d[g_detail_idx2].faaj165,g_faah4_d[g_detail_idx2].faaj166,g_faah4_d[g_detail_idx2].faaj167, 
                  g_faah4_d[g_detail_idx2].faajsite) 
         WHERE faajent = g_enterprise AND
               faaj000 = ps_keys_bak[1] AND faaj037 = ps_keys_bak[2] AND faaj001 = ps_keys_bak[3] AND faaj002 = ps_keys_bak[4] AND faajld = ps_keys_bak[5]
 
      #add-point:update_b段修改中 name="update_b.m_update3"
      
      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "faaj_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "faaj_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL afat300_faaj_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update3"
      
      #end add-point 
      
      RETURN
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="afat300.key_update_b" >}
#+ 單頭key欄位變動後, 連帶修正其他單身table
PRIVATE FUNCTION afat300_key_update_b()
   #add-point:update_b段define(客製用) name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE li_idx           LIKE type_t.num10 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)   #(ver:44)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
  
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變
   LET lb_chk = TRUE
   
   IF g_master.faah000 <> g_master_t.faah000 THEN
      LET lb_chk = FALSE
   END IF
   IF g_master.faah001 <> g_master_t.faah001 THEN
      LET lb_chk = FALSE
   END IF
   IF g_master.faah003 <> g_master_t.faah003 THEN
      LET lb_chk = FALSE
   END IF
   IF g_master.faah004 <> g_master_t.faah004 THEN
      LET lb_chk = FALSE
   END IF
 
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
    
   #add-point:update_b段修改前 name="key_update_b.before_update2"
   
   #end add-point
   
   UPDATE faai_t 
      SET (faai000,faai001,faai002,faai003) 
           = 
          (g_master.faah000,g_master.faah001,g_master.faah003,g_master.faah004) 
      WHERE faaient = g_enterprise AND
           faai000 = g_master_t.faah000
           AND faai001 = g_master_t.faah001
           AND faai002 = g_master_t.faah003
           AND faai003 = g_master_t.faah004
 
           
   #add-point:update_b段修改中 name="key_update_b.m_update2"
   
   #end add-point
           
   CASE
      WHEN SQLCA.SQLCODE #其他錯誤
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "faai_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         
      OTHERWISE
         #若有多語言table資料一同更新
         
   END CASE
   
   #add-point:update_b段修改後 name="key_update_b.after_update2"
   
   #end add-point
 
   #add-point:update_b段修改前 name="key_update_b.before_update3"
   
   #end add-point
   
   UPDATE faaj_t 
      SET (faaj000,faaj037,faaj001,faaj002) 
           = 
          (g_master.faah000,g_master.faah001,g_master.faah003,g_master.faah004) 
      WHERE faajent = g_enterprise AND
           faaj000 = g_master_t.faah000
           AND faaj037 = g_master_t.faah001
           AND faaj001 = g_master_t.faah003
           AND faaj002 = g_master_t.faah004
 
           
   #add-point:update_b段修改中 name="key_update_b.m_update3"
   
   #end add-point
           
   CASE
      WHEN SQLCA.SQLCODE #其他錯誤
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "faaj_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         
      OTHERWISE
         #若有多語言table資料一同更新
         
   END CASE
   
   #add-point:update_b段修改後 name="key_update_b.after_update3"
   
   #end add-point
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="afat300.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION afat300_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point   
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL afat300_b_fill(g_wc)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "faah_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN afat300_bcl USING g_enterprise,
                                       g_faah_d[g_detail_idx].faah000,g_faah_d[g_detail_idx].faah001, 
                                           g_faah_d[g_detail_idx].faah003,g_faah_d[g_detail_idx].faah004 
 
                                       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afat300_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   #鎖定整組table
   #LET ls_group = "faai_t,"
   #僅鎖定自身table
   LET ls_group = "faai_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN afat300_bcl2 USING g_enterprise,
                                             g_master.faah000,g_master.faah001,g_master.faah003,g_master.faah004,
                                             g_faah3_d[g_detail_idx2].faaiseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afat300_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "faaj_t,"
   #僅鎖定自身table
   LET ls_group = "faaj_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN afat300_bcl3 USING g_enterprise,
                                             g_master.faah000,g_master.faah001,g_master.faah003,g_master.faah004,
                                             g_faah4_d[g_detail_idx2].faajld
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afat300_bcl3:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="afat300.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION afat300_unlock_b(ps_table)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
   
   LET ls_group = ""
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE afat300_bcl
   END IF
   
 
    
   LET ls_group = "faai_t,"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE afat300_bcl2
   END IF
 
   LET ls_group = "faaj_t,"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE afat300_bcl3
   END IF
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="afat300.idx_chk" >}
#+ 單身筆數變更
PRIVATE FUNCTION afat300_idx_chk(ps_loc)
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   DEFINE ps_loc   LIKE type_t.chr10
   DEFINE li_idx   LIKE type_t.num10
   DEFINE li_cnt   LIKE type_t.num10
   #add-point:idx_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_faah_d.getLength() THEN
         LET g_detail_idx = g_faah_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_faah_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      LET li_idx = g_detail_idx
      LET li_cnt = g_faah_d.getLength()
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_faah2_d.getLength() THEN
         LET g_detail_idx = g_faah2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_faah2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      LET li_idx = g_detail_idx
      LET li_cnt = g_faah2_d.getLength()
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx2 > g_faah3_d.getLength() THEN
         LET g_detail_idx2 = g_faah3_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_faah3_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      LET li_idx = g_detail_idx2
      LET li_cnt = g_faah3_d.getLength()
   END IF
   IF g_current_page = 4 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx2 > g_faah4_d.getLength() THEN
         LET g_detail_idx2 = g_faah4_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_faah4_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      LET li_idx = g_detail_idx2
      LET li_cnt = g_faah4_d.getLength()
   END IF
 
    
   IF ps_loc = 'm' THEN
      DISPLAY li_idx TO FORMONLY.h_index
      DISPLAY li_cnt TO FORMONLY.h_count
      IF g_faah3_d.getLength() = 0 THEN
         DISPLAY '' TO FORMONLY.idx
         DISPLAY '' TO FORMONLY.cnt
      ELSE
         DISPLAY 1 TO FORMONLY.idx
         DISPLAY g_faah3_d.getLength() TO FORMONLY.cnt
      END IF
      IF g_faah4_d.getLength() = 0 THEN
         DISPLAY '' TO FORMONLY.idx
         DISPLAY '' TO FORMONLY.cnt
      ELSE
         DISPLAY 1 TO FORMONLY.idx
         DISPLAY g_faah4_d.getLength() TO FORMONLY.cnt
      END IF
 
   ELSE
      DISPLAY li_idx TO FORMONLY.idx
      DISPLAY li_cnt TO FORMONLY.cnt
   END IF
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="afat300.mask_functions" >}
&include "erp/afa/afat300_mask.4gl"
 
{</section>}
 
{<section id="afat300.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION afat300_set_pk_array()
   #add-point:set_pk_array段define name="set_pk_array.define_customerization"
   
   #end add-point
   #add-point:set_pk_array段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_pk_array.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="set_pk_array.before"
   
   #end add-point  
   
   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_faah_d[g_detail_idx].faah000
   LET g_pk_array[1].column = 'faah000'
   LET g_pk_array[2].values = g_faah_d[g_detail_idx].faah001
   LET g_pk_array[2].column = 'faah001'
   LET g_pk_array[3].values = g_faah_d[g_detail_idx].faah003
   LET g_pk_array[3].column = 'faah003'
   LET g_pk_array[4].values = g_faah_d[g_detail_idx].faah004
   LET g_pk_array[4].column = 'faah004'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afat300.state_change" >}
    
 
{</section>}
 
{<section id="afat300.func_signature" >}
   
 
{</section>}
 
{<section id="afat300.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="afat300.other_function" readonly="Y" >}

################################################################################
# Descriptions...: Excel獲取數據，插入數據庫
# Memo...........:
# Usage..........: CALL afat300_s01_ins_from_excel (p_excelname)
#                  RETURNING 回传参数
# Input parameter: p_excelname   excel文件名
#                : 传入参数变量2   传入参数变量说明2
# Return code....: l_sucess      成功否
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/10/27 By 劉業明
# Modify.........:
################################################################################
PRIVATE FUNCTION afat300_s01_ins_from_excel(p_excelname)
DEFINE p_excelname LIKE type_t.chr1000  #excel档名
DEFINE r_success   LIKE type_t.num5
DEFINE l_excelname STRING               #excel档名
DEFINE l_count     LIKE type_t.num10
DEFINE li_i        LIKE type_t.num10
DEFINE li_j        LIKE type_t.num10
DEFINE xlapp,iRes,iRow    LIKE type_t.num5
#DEFINE l_xcda      RECORD LIKE xcda_t.*  #mark by geza 20161122 #161111-00028#6
#add by geza 20161122 #161111-00028#6(S)
DEFINE l_xcda RECORD  #期初庫存數量成本要素成本開帳檔
       xcdaent LIKE xcda_t.xcdaent, #企业编号
       xcdald LIKE xcda_t.xcdald, #账套
       xcdacomp LIKE xcda_t.xcdacomp, #法人组织
       xcda001 LIKE xcda_t.xcda001, #账套本位币顺序
       xcda002 LIKE xcda_t.xcda002, #成本域
       xcda003 LIKE xcda_t.xcda003, #成本计算类型
       xcda004 LIKE xcda_t.xcda004, #年度
       xcda005 LIKE xcda_t.xcda005, #期别
       xcda006 LIKE xcda_t.xcda006, #料号
       xcda007 LIKE xcda_t.xcda007, #特性
       xcda008 LIKE xcda_t.xcda008, #批号
       xcda009 LIKE xcda_t.xcda009, #成本次要素
       xcda101 LIKE xcda_t.xcda101, #当月期末数量
       xcda102 LIKE xcda_t.xcda102, #当月期末金额-金额合计
       xcdaownid LIKE xcda_t.xcdaownid, #资料所有者
       xcdaowndp LIKE xcda_t.xcdaowndp, #资料所有部门
       xcdacrtid LIKE xcda_t.xcdacrtid, #资料录入者
       xcdacrtdp LIKE xcda_t.xcdacrtdp, #资料录入部门
       xcdacrtdt LIKE xcda_t.xcdacrtdt, #资料创建日
       xcdamodid LIKE xcda_t.xcdamodid, #资料更改者
       xcdamoddt LIKE xcda_t.xcdamoddt, #最近更改日
       xcdacnfid LIKE xcda_t.xcdacnfid, #资料审核者
       xcdacnfdt LIKE xcda_t.xcdacnfdt, #数据审核日
       xcdapstid LIKE xcda_t.xcdapstid, #资料过账者
       xcdapstdt LIKE xcda_t.xcdapstdt, #资料过账日
       xcdastus LIKE xcda_t.xcdastus  #状态码
END RECORD
#add by geza 20161122 #161111-00028#6(E)
DEFINE l_today     LIKE type_t.dat       #zll g_today 没有了
DEFINE l_n         LIKE type_t.num5
DEFINE l_faahstus  LIKE faah_t.faahstus
DEFINE l_faahcrtdt    DATETIME YEAR TO SECOND
#mark by geza 20161122 #161111-00028#6(S)
#DEFINE l_faah      RECORD LIKE faah_t.*
#DEFINE l_faaj      RECORD LIKE faaj_t.*
#DEFINE l_faai      RECORD LIKE faai_t.*
#mark by geza 20161122 #161111-00028#6(E)
#add by geza 20161122 #161111-00028#6(S)
DEFINE l_faah RECORD  #固定資產基礎資料檔
       faahent LIKE faah_t.faahent, #企业编号
       faah000 LIKE faah_t.faah000, #生成批号
       faah001 LIKE faah_t.faah001, #卡片编号
       faah002 LIKE faah_t.faah002, #型态
       faah003 LIKE faah_t.faah003, #财产编号
       faah004 LIKE faah_t.faah004, #附号
       faah005 LIKE faah_t.faah005, #资产性质
       faah006 LIKE faah_t.faah006, #资产主要类型
       faah007 LIKE faah_t.faah007, #资产次要类型
       faah008 LIKE faah_t.faah008, #资产组
       faah009 LIKE faah_t.faah009, #供应供应商
       faah010 LIKE faah_t.faah010, #制造供应商
       faah011 LIKE faah_t.faah011, #产地
       faah012 LIKE faah_t.faah012, #名称
       faah013 LIKE faah_t.faah013, #规格型号
       faah014 LIKE faah_t.faah014, #取得日期
       faah015 LIKE faah_t.faah015, #资产状态
       faah016 LIKE faah_t.faah016, #取得方式
       faah017 LIKE faah_t.faah017, #单位
       faah018 LIKE faah_t.faah018, #数量
       faah019 LIKE faah_t.faah019, #在外数量
       faah020 LIKE faah_t.faah020, #币种
       faah021 LIKE faah_t.faah021, #原币单价
       faah022 LIKE faah_t.faah022, #原币金额
       faah023 LIKE faah_t.faah023, #本币单价
       faah024 LIKE faah_t.faah024, #本币金额
       faah025 LIKE faah_t.faah025, #保管人员
       faah026 LIKE faah_t.faah026, #保管部门
       faah027 LIKE faah_t.faah027, #存放位置
       faah028 LIKE faah_t.faah028, #存放组织
       faah029 LIKE faah_t.faah029, #负责人员
       faah030 LIKE faah_t.faah030, #管理组织
       faah031 LIKE faah_t.faah031, #核算组织
       faah032 LIKE faah_t.faah032, #归属法人
       faah033 LIKE faah_t.faah033, #直接资本化
       faah034 LIKE faah_t.faah034, #保税
       faah035 LIKE faah_t.faah035, #保险
       faah036 LIKE faah_t.faah036, #免税
       faah037 LIKE faah_t.faah037, #抵押
       faah038 LIKE faah_t.faah038, #采购单号
       faah039 LIKE faah_t.faah039, #收货单号
       faah040 LIKE faah_t.faah040, #账款单号
       faah041 LIKE faah_t.faah041, #来源营运中心
       faah042 LIKE faah_t.faah042, #资产属性
       faah043 LIKE faah_t.faah043, #预计总工作量
       faah044 LIKE faah_t.faah044, #已使用工作量
       faah045 LIKE faah_t.faah045, #账款编号项次
       faahownid LIKE faah_t.faahownid, #资料所有者
       faahowndp LIKE faah_t.faahowndp, #资料所有部门
       faahcrtid LIKE faah_t.faahcrtid, #资料录入者
       faahcrtdp LIKE faah_t.faahcrtdp, #资料录入部门
       faahcrtdt LIKE faah_t.faahcrtdt, #资料创建日
       faahmodid LIKE faah_t.faahmodid, #资料更改者
       faahmoddt LIKE faah_t.faahmoddt, #最近更改日
       faahstus LIKE faah_t.faahstus, #状态码
       faah046 LIKE faah_t.faah046, #备注
       faah047 LIKE faah_t.faah047, #保税机器截取否
       faah048 LIKE faah_t.faah048, #投资抵减状态
       faah049 LIKE faah_t.faah049, #投资抵减合并码
       faah050 LIKE faah_t.faah050, #抵减率
       faah051 LIKE faah_t.faah051, #投资抵减用途
       faah052 LIKE faah_t.faah052, #抵减金额
       faah053 LIKE faah_t.faah053, #已抵减金额
       faah054 LIKE faah_t.faah054, #投资抵减否
       faah055 LIKE faah_t.faah055, #投资抵减年限
       faah056 LIKE faah_t.faah056  #免税状态
END RECORD
DEFINE l_faaj RECORD  #固定資產帳套折舊資訊資料檔
       faajent LIKE faaj_t.faajent, #企业编码
       faajld LIKE faaj_t.faajld, #账套别编码
       faajsite LIKE faaj_t.faajsite, #营运据点
       faaj000 LIKE faaj_t.faaj000, #批号
       faaj001 LIKE faaj_t.faaj001, #财产编号
       faaj002 LIKE faaj_t.faaj002, #附号
       faaj003 LIKE faaj_t.faaj003, #折旧方式
       faaj004 LIKE faaj_t.faaj004, #耐用年限(月数)
       faaj005 LIKE faaj_t.faaj005, #未使用年限(月数)
       faaj006 LIKE faaj_t.faaj006, #分摊方式
       faaj007 LIKE faaj_t.faaj007, #分摊类别
       faaj008 LIKE faaj_t.faaj008, #开始折旧年月
       faaj009 LIKE faaj_t.faaj009, #最近折旧年度
       faaj010 LIKE faaj_t.faaj010, #最近折旧期别
       faaj011 LIKE faaj_t.faaj011, #折毕再提
       faaj012 LIKE faaj_t.faaj012, #折毕再提预留残值
       faaj013 LIKE faaj_t.faaj013, #折毕再提预留年月（数）
       faaj014 LIKE faaj_t.faaj014, #币种
       faaj015 LIKE faaj_t.faaj015, #汇率
       faaj016 LIKE faaj_t.faaj016, #成本
       faaj017 LIKE faaj_t.faaj017, #累折
       faaj018 LIKE faaj_t.faaj018, #本期累折
       faaj019 LIKE faaj_t.faaj019, #预留残值
       faaj020 LIKE faaj_t.faaj020, #调整成本
       faaj021 LIKE faaj_t.faaj021, #已计提减值准备
       faaj022 LIKE faaj_t.faaj022, #年折旧额
       faaj023 LIKE faaj_t.faaj023, #资产科目
       faaj024 LIKE faaj_t.faaj024, #累折科目
       faaj025 LIKE faaj_t.faaj025, #折旧科目
       faaj026 LIKE faaj_t.faaj026, #减值准备科目
       faaj027 LIKE faaj_t.faaj027, #销账减值准备
       faaj028 LIKE faaj_t.faaj028, #未折减额
       faaj029 LIKE faaj_t.faaj029, #第一个月未折减额
       faaj030 LIKE faaj_t.faaj030, #账款编号
       faaj031 LIKE faaj_t.faaj031, #账款编号项次
       faaj032 LIKE faaj_t.faaj032, #本期处置累折
       faaj033 LIKE faaj_t.faaj033, #处置数量
       faaj034 LIKE faaj_t.faaj034, #处置成本
       faaj035 LIKE faaj_t.faaj035, #处置累折
       faaj036 LIKE faaj_t.faaj036, #交易价格差异
       faaj037 LIKE faaj_t.faaj037, #卡片编号
       faaj038 LIKE faaj_t.faaj038, #资产状态
       faaj039 LIKE faaj_t.faaj039, #部门
       faaj040 LIKE faaj_t.faaj040, #利润/成本中心
       faaj041 LIKE faaj_t.faaj041, #区域
       faaj042 LIKE faaj_t.faaj042, #交易客商
       faaj043 LIKE faaj_t.faaj043, #账款客商
       faaj044 LIKE faaj_t.faaj044, #客群
       faaj045 LIKE faaj_t.faaj045, #项目编号
       faaj046 LIKE faaj_t.faaj046, #WBS
       faaj047 LIKE faaj_t.faaj047, #人员
       faaj101 LIKE faaj_t.faaj101, #本位币二币种
       faaj102 LIKE faaj_t.faaj102, #本位币二汇率
       faaj103 LIKE faaj_t.faaj103, #本位币二成本
       faaj104 LIKE faaj_t.faaj104, #本位币二累折
       faaj105 LIKE faaj_t.faaj105, #本位币二预留残值
       faaj106 LIKE faaj_t.faaj106, #本位币二折毕再提预留残值
       faaj107 LIKE faaj_t.faaj107, #本位币二年折旧额
       faaj108 LIKE faaj_t.faaj108, #本位币二未折减额
       faaj109 LIKE faaj_t.faaj109, #本位币二第一月未折减额
       faaj110 LIKE faaj_t.faaj110, #本位币二处置减值准备
       faaj111 LIKE faaj_t.faaj111, #本位币二本年累折
       faaj112 LIKE faaj_t.faaj112, #本位币二已计提减值准备
       faaj113 LIKE faaj_t.faaj113, #本位币二处置成本
       faaj114 LIKE faaj_t.faaj114, #本位币二处置累折
       faaj115 LIKE faaj_t.faaj115, #本位币二本期处置累折
       faaj116 LIKE faaj_t.faaj116, #本位币二交易价格差异
       faaj117 LIKE faaj_t.faaj117, #本位币二调整成本
       faaj151 LIKE faaj_t.faaj151, #本位币三币种
       faaj152 LIKE faaj_t.faaj152, #本位币三汇率
       faaj153 LIKE faaj_t.faaj153, #本位币三成本
       faaj154 LIKE faaj_t.faaj154, #本位币三累折
       faaj155 LIKE faaj_t.faaj155, #本位币三预留残值
       faaj156 LIKE faaj_t.faaj156, #本位币三折毕再提预留残值
       faaj157 LIKE faaj_t.faaj157, #本位币三年折旧额
       faaj158 LIKE faaj_t.faaj158, #本位币三未折减额
       faaj159 LIKE faaj_t.faaj159, #本位币三第一月未折减额
       faaj160 LIKE faaj_t.faaj160, #本位币三处置减值准备
       faaj161 LIKE faaj_t.faaj161, #本位币三本年累折
       faaj162 LIKE faaj_t.faaj162, #本位币三已计提减值准备
       faaj163 LIKE faaj_t.faaj163, #本位币三处置成本
       faaj164 LIKE faaj_t.faaj164, #本位币三处置累折
       faaj165 LIKE faaj_t.faaj165, #本位币三本期处置累折
       faaj166 LIKE faaj_t.faaj166, #本位币三交易价格差异
       faaj167 LIKE faaj_t.faaj167, #本位币三调整成本
       faajownid LIKE faaj_t.faajownid, #资料所有者
       faajowndp LIKE faaj_t.faajowndp, #资料所有部门
       faajcrtid LIKE faaj_t.faajcrtid, #资料录入者
       faajcrtdp LIKE faaj_t.faajcrtdp, #资料录入部门
       faajcrtdt LIKE faaj_t.faajcrtdt, #资料创建日
       faajmodid LIKE faaj_t.faajmodid, #资料更改者
       faajmoddt LIKE faaj_t.faajmoddt, #最近更改日
       faajstus LIKE faaj_t.faajstus, #状态码
       faaj048 LIKE faaj_t.faaj048  #资产分类
END RECORD
DEFINE l_faai RECORD  #固定資產標籤檔
       faaient LIKE faai_t.faaient, #企业编号
       faai000 LIKE faai_t.faai000, #生成批号
       faai001 LIKE faai_t.faai001, #卡片编号
       faai002 LIKE faai_t.faai002, #财产编号
       faai003 LIKE faai_t.faai003, #附号
       faaiseq LIKE faai_t.faaiseq, #项次
       faai004 LIKE faai_t.faai004, #财签条码
       faai005 LIKE faai_t.faai005, #S/N号码
       faai006 LIKE faai_t.faai006, #单位
       faai007 LIKE faai_t.faai007, #数量
       faai008 LIKE faai_t.faai008, #在外数量
       faai009 LIKE faai_t.faai009, #供应供应商
       faai010 LIKE faai_t.faai010, #制造供应商
       faai011 LIKE faai_t.faai011, #产地
       faai012 LIKE faai_t.faai012, #名称
       faai013 LIKE faai_t.faai013, #规格型号
       faai014 LIKE faai_t.faai014, #取得日期
       faai015 LIKE faai_t.faai015, #保管人员
       faai016 LIKE faai_t.faai016, #保管部门
       faai017 LIKE faai_t.faai017, #存放位置
       faai018 LIKE faai_t.faai018, #存放组织
       faai019 LIKE faai_t.faai019, #负责人员
       faai020 LIKE faai_t.faai020, #管理组织
       faai021 LIKE faai_t.faai021, #核算组织
       faai022 LIKE faai_t.faai022, #归属法人
       faai023 LIKE faai_t.faai023  #标签状态
END RECORD
#add by geza 20161122 #161111-00028#6(E)

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   LET l_today= cl_get_current()
   LET l_count = LENGTH(p_excelname CLIPPED)
   #转换路径分隔符
   FOR li_i = 1 TO l_count
       IF p_excelname[li_i,li_i] ="/" THEN
          LET l_excelname = l_excelname CLIPPED,'\\'
       ELSE
          LET l_excelname = l_excelname CLIPPED,p_excelname[li_i,li_i]
       END IF
   END FOR

   CALL ui.interface.frontCall('WinCOM','CreateInstance',
                               ['Excel.Application'],[xlApp])
   IF xlApp <> -1 THEN
      CALL ui.interface.frontCall('WinCOM','CallMethod',
                                  [xlApp,'WorkBooks.Open',l_excelname],[iRes])
      IF iRes <> -1 THEN
         CALL ui.interface.frontCall('WinCOM','GetProperty',
              [xlApp,'ActiveSheet.UsedRange.Rows.Count'],[iRow])
         IF iRow > 1 THEN
            IF g_faah_f.inf='1' THEN #資產明細信息導入
               FOR li_i =2 TO iRow
                   INITIALIZE l_faah.* TO NULL
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',1).Value'],[l_faah.faahent])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',2).Value'],[l_faah.faah000])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',3).Value'],[l_faah.faah001])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',4).Value'],[l_faah.faah002])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',5).Value'],[l_faah.faah003])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',6).Value'],[l_faah.faah004])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',7).Value'],[l_faah.faah005])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',8).Value'],[l_faah.faah006])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',9).Value'],[l_faah.faah007])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',10).Value'],[l_faah.faah008])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',11).Value'],[l_faah.faah009])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',12).Value'],[l_faah.faah010])               
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',13).Value'],[l_faah.faah011])                
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',14).Value'],[l_faah.faah012])                
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',15).Value'],[l_faah.faah013])                
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',16).Value'],[l_faah.faah014])                
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',17).Value'],[l_faah.faah015]) 
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',18).Value'],[l_faah.faah016]) 
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',19).Value'],[l_faah.faah017]) 
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',20).Value'],[l_faah.faah018]) 
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',21).Value'],[l_faah.faah019]) 
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',22).Value'],[l_faah.faah020])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',23).Value'],[l_faah.faah021]) 
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',24).Value'],[l_faah.faah022])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',25).Value'],[l_faah.faah023])  
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',26).Value'],[l_faah.faah024])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',27).Value'],[l_faah.faah025])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',28).Value'],[l_faah.faah026])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',29).Value'],[l_faah.faah027])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',30).Value'],[l_faah.faah028])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',31).Value'],[l_faah.faah029])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',32).Value'],[l_faah.faah030])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',33).Value'],[l_faah.faah031])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',34).Value'],[l_faah.faah032])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',35).Value'],[l_faah.faah033])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',36).Value'],[l_faah.faah034])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',37).Value'],[l_faah.faah035])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',38).Value'],[l_faah.faah036])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',39).Value'],[l_faah.faah037])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',40).Value'],[l_faah.faah038])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',41).Value'],[l_faah.faah039])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',42).Value'],[l_faah.faah040])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',43).Value'],[l_faah.faah041])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',44).Value'],[l_faah.faah042])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',45).Value'],[l_faah.faah043])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',46).Value'],[l_faah.faah044])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',47).Value'],[l_faah.faah045])
                   #如果excel中存在不在畫面上的法人或者帳套CONTINUE
                   IF l_faah.faah032 != g_faah_f.faah032  THEN
                      #CONTINUE FOR
                      #匯出畫面中帳套不一致的，提示檢核訊息，不予新增
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'afa-01002'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = FALSE
                      CALL cl_err()
         
                      LET r_success = FALSE
                      CONTINUE FOR
                   END IF
                   LET l_count=0
                   SELECT COUNT (*) INTO l_count FROM faah_t WHERE faah001=l_faah.faah001 
                   AND faah003=l_faah.faah003 AND faah004=l_faah.faah004 AND faahent=l_faah.faahent
                   IF l_count>0 THEN 
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'afa-00255'
                      LET g_errparam.extend = l_faah.faah003
                      LET g_errparam.popup = FALSE
                      CALL cl_err()
                      LET r_success = FALSE
                      CONTINUE FOR
                   END IF
                      #赋默认值              
                   LET l_faah.faahownid = g_user
                   LET l_faah.faahowndp = g_dept
                   LET l_faah.faahcrtid = g_user
                   LET l_faah.faahcrtdp = g_dept 
                   LET l_faah.faahcrtdt = cl_get_current()
                   LET l_faah.faahmodid = ""
                   LET l_faah.faahmoddt = ""
                   LET l_faah.faahstus = "Y"
      
                   IF l_faah.faah004 IS NULL THEN  #key值批号可录入为空
                      LET l_faah.faah004 = ' '
                   END IF
                   IF l_faah.faah000 IS NULL THEN  #key值特性可录入为空
                      LET l_faah.faah000 = ' '
                   END IF 
                   #INSERT INTO faah_t VALUES l_faah.* #mark by geza 20161122 #161111-00028#6
                   #add by geza 20161122 #161111-00028#6(S)
                   INSERT INTO faah_t
                  (faahent,faah000,faah001,faah002,faah003,faah004,faah005,
                   faah006,faah007,faah008,faah009,faah010,faah011,faah012,
                   faah013,faah014,faah015,faah016,faah017,faah018,faah019,
                   faah020,faah021,faah022,faah023,faah024,faah025,faah026,
                   faah027,faah028,faah029,faah030,faah031,faah032,faah033,
                   faah034,faah035,faah036,faah037,faah038,faah039,faah040,
                   faah041,faah042,faah043,faah044,faah045,faahownid,faahowndp,
                   faahcrtid,faahcrtdp,faahcrtdt,faahmodid,faahmoddt,faahstus,
                   faah046,faah047,faah048,faah049,faah050,faah051,faah052,
                   faah053,faah054,faah055,faah056) 
                  VALUES(l_faah.faahent,l_faah.faah000,l_faah.faah001,l_faah.faah002,l_faah.faah003,l_faah.faah004,l_faah.faah005,
                         l_faah.faah006,l_faah.faah007,l_faah.faah008,l_faah.faah009,l_faah.faah010,l_faah.faah011,l_faah.faah012,
                         l_faah.faah013,l_faah.faah014,l_faah.faah015,l_faah.faah016,l_faah.faah017,l_faah.faah018,l_faah.faah019,
                         l_faah.faah020,l_faah.faah021,l_faah.faah022,l_faah.faah023,l_faah.faah024,l_faah.faah025,l_faah.faah026,
                         l_faah.faah027,l_faah.faah028,l_faah.faah029,l_faah.faah030,l_faah.faah031,l_faah.faah032,l_faah.faah033,
                         l_faah.faah034,l_faah.faah035,l_faah.faah036,l_faah.faah037,l_faah.faah038,l_faah.faah039,l_faah.faah040,
                         l_faah.faah041,l_faah.faah042,l_faah.faah043,l_faah.faah044,l_faah.faah045,l_faah.faahownid,l_faah.faahowndp,
                         l_faah.faahcrtid,l_faah.faahcrtdp,l_faah.faahcrtdt,l_faah.faahmodid,l_faah.faahmoddt,l_faah.faahstus,
                         l_faah.faah046,l_faah.faah047,l_faah.faah048,l_faah.faah049,l_faah.faah050,l_faah.faah051,l_faah.faah052,
                         l_faah.faah053,l_faah.faah054,l_faah.faah055,l_faah.faah056) 
                   #add by geza 20161122 #161111-00028#6(E)
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = 'ins faah'
                      LET g_errparam.popup = FALSE
                      CALL cl_err()
                      LET r_success = FALSE
                      CONTINUE FOR
                   END IF
               END FOR

            END IF
            IF g_faah_f.inf='2' THEN #資產標籤信息導入
               FOR li_i =2 TO iRow
                  INITIALIZE l_faai.* TO NULL   
                  CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',1).Value'],[l_faai.faaient])
                  CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',2).Value'],[l_faai.faai000])
                  CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',3).Value'],[l_faai.faai001])
                  CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',4).Value'],[l_faai.faai002])
                  CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',5).Value'],[l_faai.faai003])
                  CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',6).Value'],[l_faai.faaiseq])
                  CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',7).Value'],[l_faai.faai004])
                  CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',8).Value'],[l_faai.faai005])
                  CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',9).Value'],[l_faai.faai006])
                  CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',10).Value'],[l_faai.faai007])
                  CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',11).Value'],[l_faai.faai008])
                  CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',12).Value'],[l_faai.faai009])
                  CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',13).Value'],[l_faai.faai010])
                  CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',14).Value'],[l_faai.faai011])               
                  CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',15).Value'],[l_faai.faai012])                
                  CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',16).Value'],[l_faai.faai013])                
                  CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',17).Value'],[l_faai.faai014])                
                  CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',18).Value'],[l_faai.faai015])                
                  CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',19).Value'],[l_faai.faai016]) 
                  CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',20).Value'],[l_faai.faai017]) 
                  CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',21).Value'],[l_faai.faai018]) 
                  CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',22).Value'],[l_faai.faai019]) 
                  CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',23).Value'],[l_faai.faai020]) 
                  CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',24).Value'],[l_faai.faai021]) 
                  CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',25).Value'],[l_faai.faai022])
                  CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',26).Value'],[l_faai.faai023])  
                  LET l_count=0
                  SELECT COUNT (*) INTO l_count FROM faai_t WHERE faai001=l_faai.faai001 
                   AND faai003=l_faai.faai003 AND faai002=l_faai.faai002 AND faaient=l_faai.faaient
                  IF l_count>0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-00255'
                     LET g_errparam.extend = l_faai.faai001
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     LET r_success = FALSE
                     CONTINUE FOR
                  END IF
                               
                  #INSERT INTO faai_t VALUES l_faai.* #mark by geza 20161122 #161111-00028#6
                   #add by geza 20161122 #161111-00028#6(S)
                   INSERT INTO faai_t
                  (faaient,faai000,faai001,faai002,faai003,
                   faaiseq,faai004,faai005,faai006,faai007,
                   faai008,faai009,faai010,faai011,faai012,
                   faai013,faai014,faai015,faai016,faai017,
                   faai018,faai019,faai020,faai021,faai022,
                   faai023) 
                  VALUES(l_faai.faaient,l_faai.faai000,l_faai.faai001,l_faai.faai002,l_faai.faai003,
                         l_faai.faaiseq,l_faai.faai004,l_faai.faai005,l_faai.faai006,l_faai.faai007,
                         l_faai.faai008,l_faai.faai009,l_faai.faai010,l_faai.faai011,l_faai.faai012,
                         l_faai.faai013,l_faai.faai014,l_faai.faai015,l_faai.faai016,l_faai.faai017,
                         l_faai.faai018,l_faai.faai019,l_faai.faai020,l_faai.faai021,l_faai.faai022,
                         l_faai.faai023) 
                   #add by geza 20161122 #161111-00028#6(E)
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'ins faai'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET r_success = FALSE
                     CONTINUE FOR
                  END IF
               END FOR                             
            END IF
            IF g_faah_f.inf='3' THEN #資產依帳套折舊信息導入
               FOR li_i =2 TO iRow
                   INITIALIZE l_faaj.* TO NULL
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',1).Value'],[l_faaj.faajent])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',2).Value'],[l_faaj.faajld])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',3).Value'],[l_faaj.faajsite])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',4).Value'],[l_faaj.faaj000])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',5).Value'],[l_faaj.faaj001])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',6).Value'],[l_faaj.faaj002])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',7).Value'],[l_faaj.faaj003])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',8).Value'],[l_faaj.faaj004])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',9).Value'],[l_faaj.faaj005])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',10).Value'],[l_faaj.faaj006])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',11).Value'],[l_faaj.faaj007])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',12).Value'],[l_faaj.faaj008])               
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',13).Value'],[l_faaj.faaj009])                                    
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',14).Value'],[l_faaj.faaj010])                
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',15).Value'],[l_faaj.faaj011])                
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',16).Value'],[l_faaj.faaj012])                
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',17).Value'],[l_faaj.faaj013]) 
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',18).Value'],[l_faaj.faaj014]) 
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',19).Value'],[l_faaj.faaj015]) 
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',20).Value'],[l_faaj.faaj016]) 
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',21).Value'],[l_faaj.faaj017]) 
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',22).Value'],[l_faaj.faaj018]) 
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',23).Value'],[l_faaj.faaj019])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',24).Value'],[l_faaj.faaj020])  
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',25).Value'],[l_faaj.faaj021])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',26).Value'],[l_faaj.faaj022])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',27).Value'],[l_faaj.faaj023])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',28).Value'],[l_faaj.faaj024])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',29).Value'],[l_faaj.faaj025])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',30).Value'],[l_faaj.faaj026])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',31).Value'],[l_faaj.faaj027])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',32).Value'],[l_faaj.faaj028])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',33).Value'],[l_faaj.faaj029])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',34).Value'],[l_faaj.faaj030])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',35).Value'],[l_faaj.faaj031])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',36).Value'],[l_faaj.faaj032])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',37).Value'],[l_faaj.faaj033])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',38).Value'],[l_faaj.faaj034])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',39).Value'],[l_faaj.faaj035])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',40).Value'],[l_faaj.faaj036])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',41).Value'],[l_faaj.faaj037])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',42).Value'],[l_faaj.faaj038])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',43).Value'],[l_faaj.faaj039])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',44).Value'],[l_faaj.faaj040])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',45).Value'],[l_faaj.faaj041])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',46).Value'],[l_faaj.faaj042])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',47).Value'],[l_faaj.faaj043])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',48).Value'],[l_faaj.faaj044])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',59).Value'],[l_faaj.faaj045])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',50).Value'],[l_faaj.faaj046])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',51).Value'],[l_faaj.faaj047])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',52).Value'],[l_faaj.faaj101])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',53).Value'],[l_faaj.faaj102])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',54).Value'],[l_faaj.faaj103])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',55).Value'],[l_faaj.faaj104])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',56).Value'],[l_faaj.faaj105])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',57).Value'],[l_faaj.faaj106])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',58).Value'],[l_faaj.faaj107])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',59).Value'],[l_faaj.faaj108])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',60).Value'],[l_faaj.faaj109])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',61).Value'],[l_faaj.faaj110])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',62).Value'],[l_faaj.faaj111])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',63).Value'],[l_faaj.faaj112])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',64).Value'],[l_faaj.faaj113])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',65).Value'],[l_faaj.faaj114])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',66).Value'],[l_faaj.faaj116])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',67).Value'],[l_faaj.faaj117])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',68).Value'],[l_faaj.faaj151])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',69).Value'],[l_faaj.faaj152])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',70).Value'],[l_faaj.faaj153])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',71).Value'],[l_faaj.faaj154])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',72).Value'],[l_faaj.faaj155])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',73).Value'],[l_faaj.faaj156])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',74).Value'],[l_faaj.faaj157])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',75).Value'],[l_faaj.faaj158])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',76).Value'],[l_faaj.faaj159])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',77).Value'],[l_faaj.faaj160])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',78).Value'],[l_faaj.faaj161])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',79).Value'],[l_faaj.faaj162])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',80).Value'],[l_faaj.faaj163])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',81).Value'],[l_faaj.faaj164])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',82).Value'],[l_faaj.faaj165])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',83).Value'],[l_faaj.faaj166])
                   CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',84).Value'],[l_faaj.faaj167])
                   LET l_count=0
                   SELECT COUNT (*) INTO l_count FROM faaj_t WHERE faaj001=l_faaj.faaj001 
                   AND faaj002=l_faaj.faaj002 AND faaj037=l_faaj.faaj037 AND faajent=l_faaj.faajent
                   IF l_count>0 THEN 
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'afa-00255'
                      LET g_errparam.extend = l_faaj.faaj001
                      LET g_errparam.popup = FALSE
                      CALL cl_err()
                      LET r_success = FALSE
                      CONTINUE FOR
                   END IF
                   LET l_faaj.faajownid = ""
                   LET l_faaj.faajowndp = ""
                   LET l_faaj.faajcrtid = ""
                   LET l_faaj.faajcrtdp = "" 
                   LET l_faaj.faajcrtdt = ""
                   LET l_faaj.faajmodid = ""
                   LET l_faaj.faajmoddt = ""
                   LET l_faaj.faajstus = "Y"
                   IF cl_null(l_faaj.faaj037) THEN
                      LET l_faaj.faaj037=" "
                   END IF
                   IF cl_null(l_faaj.faaj000) THEN
                      LET l_faaj.faaj000=" "
                   END IF
                   IF cl_null(l_faaj.faaj002) THEN
                      LET l_faaj.faaj002=" "
                   END IF
                   #INSERT INTO faaj_t VALUES l_faaj.*#mark by geza 20161122 #161111-00028#6
                   #add by geza 20161122 #161111-00028#6(S)
                   INSERT INTO faaj_t
                  (faajent,faajld,faajsite,faaj000,faaj001,
                   faaj002,faaj003,faaj004,faaj005,faaj006,
                   faaj007,faaj008,faaj009,faaj010,faaj011,
                   faaj012,faaj013,faaj014,faaj015,faaj016,
                   faaj017,faaj018,faaj019,faaj020,faaj021,
                   faaj022,faaj023,faaj024,faaj025,faaj026,
                   faaj027,faaj028,faaj029,faaj030,faaj031,
                   faaj032,faaj033,faaj034,faaj035,faaj036,
                   faaj037,faaj038,faaj039,faaj040,faaj041,
                   faaj042,faaj043,faaj044,faaj045,faaj046,
                   faaj047,faaj101,faaj102,faaj103,faaj104,
                   faaj105,faaj106,faaj107,faaj108,faaj109,
                   faaj110,faaj111,faaj112,faaj113,faaj114,
                   faaj115,faaj116,faaj117,faaj151,faaj152,
                   faaj153,faaj154,faaj155,faaj156,faaj157,
                   faaj158,faaj159,faaj160,faaj161,faaj162,
                   faaj163,faaj164,faaj165,faaj166,faaj167,
                   faajownid,faajowndp,faajcrtid,faajcrtdp,
                   faajcrtdt,faajmodid,faajmoddt,faajstus,
                   faaj048) 
                  VALUES(l_faaj.faajent,l_faaj.faajld,l_faaj.faajsite,l_faaj.faaj000,l_faaj.faaj001,
                         l_faaj.faaj002,l_faaj.faaj003,l_faaj.faaj004,l_faaj.faaj005,l_faaj.faaj006,
                         l_faaj.faaj007,l_faaj.faaj008,l_faaj.faaj009,l_faaj.faaj010,l_faaj.faaj011,
                         l_faaj.faaj012,l_faaj.faaj013,l_faaj.faaj014,l_faaj.faaj015,l_faaj.faaj016,
                         l_faaj.faaj017,l_faaj.faaj018,l_faaj.faaj019,l_faaj.faaj020,l_faaj.faaj021,
                         l_faaj.faaj022,l_faaj.faaj023,l_faaj.faaj024,l_faaj.faaj025,l_faaj.faaj026,
                         l_faaj.faaj027,l_faaj.faaj028,l_faaj.faaj029,l_faaj.faaj030,l_faaj.faaj031,
                         l_faaj.faaj032,l_faaj.faaj033,l_faaj.faaj034,l_faaj.faaj035,l_faaj.faaj036,
                         l_faaj.faaj037,l_faaj.faaj038,l_faaj.faaj039,l_faaj.faaj040,l_faaj.faaj041,
                         l_faaj.faaj042,l_faaj.faaj043,l_faaj.faaj044,l_faaj.faaj045,l_faaj.faaj046,
                         l_faaj.faaj047,l_faaj.faaj101,l_faaj.faaj102,l_faaj.faaj103,l_faaj.faaj104,
                         l_faaj.faaj105,l_faaj.faaj106,l_faaj.faaj107,l_faaj.faaj108,l_faaj.faaj109,
                         l_faaj.faaj110,l_faaj.faaj111,l_faaj.faaj112,l_faaj.faaj113,l_faaj.faaj114,
                         l_faaj.faaj115,l_faaj.faaj116,l_faaj.faaj117,l_faaj.faaj151,l_faaj.faaj152,
                         l_faaj.faaj153,l_faaj.faaj154,l_faaj.faaj155,l_faaj.faaj156,l_faaj.faaj157,
                         l_faaj.faaj158,l_faaj.faaj159,l_faaj.faaj160,l_faaj.faaj161,l_faaj.faaj162,
                         l_faaj.faaj163,l_faaj.faaj164,l_faaj.faaj165,l_faaj.faaj166,l_faaj.faaj167,
                         l_faaj.faajownid,l_faaj.faajowndp,l_faaj.faajcrtid,l_faaj.faajcrtdp,
                         l_faaj.faajcrtdt,l_faaj.faajmodid,l_faaj.faajmoddt,l_faaj.faajstus,
                         l_faaj.faaj048) 
                   #add by geza 20161122 #161111-00028#6(E)
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = 'ins faaj'
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      LET r_success = FALSE
                      CONTINUE FOR
                   END IF
                END FOR 
              
            END IF            
         END IF
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axc-00387'
         LET g_errparam.extend = ''   #NO FILE
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axc-00387'
      LET g_errparam.extend = ''  #NO EXCEL
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF

   CALL ui.interface.frontCall('WinCOM','CallMethod',[xlApp,'Quit'],[iRes])
   CALL ui.interface.frontCall('WinCOM','ReleaseInstance',[xlApp],[iRes])

   RETURN r_success
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION afat300_query_1()
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   DEFINE l_comp_str  STRING  #161111-00049#12 add  
   DEFINE l_ld_str    STRING  #161111-00049#12 add  
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_faah_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc
   LET g_detail_idx = l_ac
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
       CONSTRUCT BY NAME g_wc ON faah032
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
                 #Ctrlp:construct.c.xcdacomp
         AFTER FIELD faah032
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah_m.faah032
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faah_m.faah032_1_desc = '', g_rtn_fields[1] , ''
            DISPLAY  g_faah_m.faah032_1_desc TO faah032_1_desc

         ON ACTION controlp INFIELD faah032
            #add-point:ON ACTION controlp INFIELD xcdacomp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001_8()                           #呼叫開窗
            CALL q_ooef001_2()                                  #161024-00008#2 
            
          
            LET g_faah_m.faah032=g_qryparam.return1
            DISPLAY g_faah_m.faah032 TO faah032  #顯示到畫面上
            
            NEXT FIELD faah032                     #返回原欄位
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah_m.faah032
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faah_m.faah032_1_desc = '', g_rtn_fields[1] , ''
            DISPLAY  g_faah_m.faah032_1_desc TO faah032_1_desc


            #END add-point
         
      END CONSTRUCT

 
   
       

      
      
      
      
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON faah000,faah001,faah003,faah004,faah002,faah005,faah006,faah007,faah008, 
          faah009,faah010,faah011,faah012,faah013,faah014,faah015,faah016,faah017,faah018,faah019,faah020, 
          faah021,faah022,faah023,faah024,faah025,faah026,faah027,faah028,faah029,faah030,faah031,faah032, 
          faah033,faah034,faah035,faah036,faah037,faah038,faah039,faah040,faah041,faah042,faah043,faah044, 
          faah045,faahownid,faahowndp,faahcrtid,faahcrtdp,faahcrtdt,faahmodid,faahmoddt
           FROM s_detail1[1].faah000,s_detail1[1].faah001,s_detail1[1].faah003,s_detail1[1].faah004, 
               s_detail1[1].faah002,s_detail1[1].faah005,s_detail1[1].faah006,s_detail1[1].faah007,s_detail1[1].faah008, 
               s_detail1[1].faah009,s_detail1[1].faah010,s_detail1[1].faah011,s_detail1[1].faah012,s_detail1[1].faah013, 
               s_detail1[1].faah014,s_detail1[1].faah015,s_detail1[1].faah016,s_detail1[1].faah017,s_detail1[1].faah018, 
               s_detail1[1].faah019,s_detail1[1].faah020,s_detail1[1].faah021,s_detail1[1].faah022,s_detail1[1].faah023, 
               s_detail1[1].faah024,s_detail1[1].faah025,s_detail1[1].faah026,s_detail1[1].faah027,s_detail1[1].faah028, 
               s_detail1[1].faah029,s_detail1[1].faah030,s_detail1[1].faah031,s_detail1[1].faah032,s_detail1[1].faah033, 
               s_detail1[1].faah034,s_detail1[1].faah035,s_detail1[1].faah036,s_detail1[1].faah037,s_detail1[1].faah038, 
               s_detail1[1].faah039,s_detail1[1].faah040,s_detail1[1].faah041,s_detail1[1].faah042,s_detail1[1].faah043, 
               s_detail1[1].faah044,s_detail1[1].faah045,s_detail2[1].faahownid,s_detail2[1].faahowndp, 
               s_detail2[1].faahcrtid,s_detail2[1].faahcrtdp,s_detail2[1].faahcrtdt,s_detail2[1].faahmodid, 
               s_detail2[1].faahmoddt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       #此段落由子樣板a11產生
         #共用欄位查詢處理
         ##----<<faahcrtdt>>----
         AFTER FIELD faahcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<faahmoddt>>----
         AFTER FIELD faahmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<faahcnfdt>>----
         
         #----<<faahpstdt>>----
 
 
         
       #單身一般欄位開窗相關處理

         #Ctrlp:construct.c.page1.faah001
         ON ACTION controlp INFIELD faah001
            #add-point:ON ACTION controlp INFIELD faah001
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161111-00049#12 add s---
			   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
			   LET l_comp_str = cl_replace_str(l_comp_str ,"ooef017","faah032")
			   LET g_qryparam.where = " faah032 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"') AND ",l_comp_str             
            #161111-00049#12 add e--- 
            CALL q_faah001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah001  #顯示到畫面上
            NEXT FIELD faah001                     #返回原欄位
    


            #E
         #Ctrlp:construct.c.page1.faah003
         ON ACTION controlp INFIELD faah003
            #add-point:ON ACTION controlp INFIELD faah003
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161111-00049#12 add s---
			   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
			   LET l_comp_str = cl_replace_str(l_comp_str ,"ooef017","faah032")
			   LET g_qryparam.where = " faah032 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"') AND ",l_comp_str             
            #161111-00049#12 add e---             
            CALL q_faah003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah003  #顯示到畫面上
            NEXT FIELD faah003                     #返回原欄位
    


            #END add-point

 
         #Ctrlp:construct.c.page1.faah004
         ON ACTION controlp INFIELD faah004
            #add-point:ON ACTION controlp INFIELD faah004
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161111-00049#12 add s---
			   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
			   LET l_comp_str = cl_replace_str(l_comp_str ,"ooef017","faah032")
			   LET g_qryparam.where = " faah032 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"') AND ",l_comp_str             
            #161111-00049#12 add e---             
            CALL q_faah004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah004  #顯示到畫面上
            NEXT FIELD faah004                     #返回原欄位
    


            #END add-point

         #Ctrlp:construct.c.page1.faah006
         ON ACTION controlp INFIELD faah006
            #add-point:ON ACTION controlp INFIELD faah006
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
			   #161111-00049#12 add s---
			   CALL s_axrt300_get_site(g_user,g_site,'2') RETURNING l_ld_str 
            LET l_ld_str = cl_replace_str(l_ld_str,"glaald","faalld")			   
            LET g_qryparam.where = l_ld_str  
            CALL q_faal001_1() 
            #161111-00049#12 add e---              
            #CALL q_faac001()    #161111-00049#12 Mark
            DISPLAY g_qryparam.return1 TO faah006  #顯示到畫面上
            NEXT FIELD faah006                     #返回原欄位
    


            #END add-point

         #Ctrlp:construct.c.page1.faah007
         ON ACTION controlp INFIELD faah007
            #add-point:ON ACTION controlp INFIELD faah007
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
			   #161111-00049#12 add s---
			   CALL s_axrt300_get_site(g_user,g_site,'2') RETURNING l_ld_str 
            LET l_ld_str = cl_replace_str(l_ld_str,"glaald","faalld")				   
			   LET g_qryparam.where = " faad002 IN (SELECT faal001 FROM faal_t WHERE faalent = ",g_enterprise," AND ",l_ld_str,")"
			   #161111-00049#12 add e---            
            CALL q_faad001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah007  #顯示到畫面上
            NEXT FIELD faah007                     #返回原欄位
    


            #END add-point

 
         #Ctrlp:construct.c.page1.faah008
         ON ACTION controlp INFIELD faah008
            #add-point:ON ACTION controlp INFIELD faah008
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah008  #顯示到畫面上
            NEXT FIELD faah008                     #返回原欄位
    


            #END add-point

         #Ctrlp:construct.c.page1.faah009
         ON ACTION controlp INFIELD faah009
            #add-point:ON ACTION controlp INFIELD faah009
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161111-00049#5 mod s--
            #CALL q_pmaa001_10()              #呼叫開窗                                #呼叫開窗
            LET g_qryparam.arg1 = "('1','3')"
            SELECT ooef017 INTO g_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
            LET g_qryparam.where = " EXISTS(SELECT 1 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmaa001 = pmab001 AND pmabsite ='",g_ooef017,"') "
            CALL q_pmaa001_1()               
            #161111-00049#5 mod e--  
            DISPLAY g_qryparam.return1 TO faah009  #顯示到畫面上
            NEXT FIELD faah009                     #返回原欄位
    


            #END add-point
 

         #Ctrlp:construct.c.page1.faah010
         ON ACTION controlp INFIELD faah010
            #add-point:ON ACTION controlp INFIELD faah010
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_pmaa001_4()                 #呼叫開窗 #161111-00049#5 mark
            #161111-00049#5 mod s--                         
            LET g_qryparam.arg1 = "('2','3')"
            SELECT ooef017 INTO g_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
            LET g_qryparam.where = " EXISTS(SELECT 1 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmaa001 = pmab001 AND pmabsite ='",g_ooef017,"') "
            CALL q_pmaa001_1()               
            #161111-00049#5 mod e--            
            DISPLAY g_qryparam.return1 TO faah010  #顯示到畫面上
            NEXT FIELD faah010                     #返回原欄位
    


            #END add-point

         #Ctrlp:construct.c.page1.faah011
         ON ACTION controlp INFIELD faah011
            #add-point:ON ACTION controlp INFIELD faah011
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooce001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah011  #顯示到畫面上
            NEXT FIELD faah011                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD faah011
            #add-point:BEFORE FIELD faah011

            #END add-point

         #Ctrlp:construct.c.page1.faah017
         ON ACTION controlp INFIELD faah017
            #add-point:ON ACTION controlp INFIELD faah017
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah017  #顯示到畫面上
            NEXT FIELD faah017                     #返回原欄位
    


            #END add-point

         #Ctrlp:construct.c.page1.faah020
         ON ACTION controlp INFIELD faah020
            #add-point:ON ACTION controlp INFIELD faah020
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah020  #顯示到畫面上
            NEXT FIELD faah020                     #返回原欄位
    


            #END add-point
 
         #Ctrlp:construct.c.page1.faah025
         ON ACTION controlp INFIELD faah025
            #add-point:ON ACTION controlp INFIELD faah025
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah025  #顯示到畫面上
            NEXT FIELD faah025                     #返回原欄位
    


            #END add-point
 
         #Ctrlp:construct.c.page1.faah026
         ON ACTION controlp INFIELD faah026
            #add-point:ON ACTION controlp INFIELD faah026
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                           #呼叫開窗    #161024-00008#2 
            CALL q_ooeg001_4()                                      #161024-00008#2 
            DISPLAY g_qryparam.return1 TO faah026  #顯示到畫面上
            NEXT FIELD faah026                     #返回原欄位
    


            #END a 
 
         #Ctrlp:construct.c.page1.faah027
         ON ACTION controlp INFIELD faah027
            #add-point:ON ACTION controlp INFIELD faah027
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161111-00049#12 add s---
            LET g_qryparam.arg1 = '3900'
            LET g_qryparam.where = "( oocq004 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"') OR oocq004 IS NULL)" #161111-00049#5 1116 add             
            #161111-00049#12 add e---
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah027  #顯示到畫面上
            NEXT FIELD faah027                     #返回原欄位
    


            #END add-point
 

 
         #Ctrlp:construct.c.page1.faah028
         ON ACTION controlp INFIELD faah028
            #add-point:ON ACTION controlp INFIELD faah028
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161111-00049#12 add s---  
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
            LET g_qryparam.where = l_comp_str   
            #161111-00049#12 add e---               
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah028  #顯示到畫面上
            NEXT FIELD faah028                     #返回原欄位
    


            #END add-point

         #Ctrlp:construct.c.page1.faah029
         ON ACTION controlp INFIELD faah029
            #add-point:ON ACTION controlp INFIELD faah029
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah029  #顯示到畫面上
            NEXT FIELD faah029                     #返回原欄位
    


            #END add-point

         #Ctrlp:construct.c.page1.faah030
         ON ACTION controlp INFIELD faah030
            #add-point:ON ACTION controlp INFIELD faah030
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
              #CALL q_ooef001()                           #呼叫開窗 #161024-00008#2 
            #161111-00049#12 add s---  
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
            LET g_qryparam.where = l_comp_str   
            #161111-00049#12 add e---            
            CALL q_ooef001_47()                                  #161024-00008#2 
            DISPLAY g_qryparam.return1 TO faah030  #顯示到畫面上
            NEXT FIELD faah030                     #返回原欄位
    


            #END add-point

 
         #Ctrlp:construct.c.page1.faah031
         ON ACTION controlp INFIELD faah031
            #add-point:ON ACTION controlp INFIELD faah031
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef204 = 'Y' "   #161024-00008#2
            #161111-00049#12 add s---  
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
            LET g_qryparam.where = g_qryparam.where," AND ",l_comp_str   
            #161111-00049#12 add e---              
            CALL q_ooef001()                              #呼叫開窗 
            DISPLAY g_qryparam.return1 TO faah031  #顯示到畫面上
            NEXT FIELD faah031                     #返回原欄位
    


            #END add-point

         #Ctrlp:construct.c.page1.faah032
         ON ACTION controlp INFIELD faah032
            #add-point:ON ACTION controlp INFIELD faah032
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                           #呼叫開窗 #161024-00008#2 
            #161111-00049#12 add s---  
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
            LET g_qryparam.where = l_comp_str   
            #161111-00049#12 add e---               
            CALL q_ooef001_2()                                    #161024-00008#2 
            DISPLAY g_qryparam.return1 TO faah032  #顯示到畫面上
            NEXT FIELD faah032                     #返回原欄位
    


            #END add-point

 
         #Ctrlp:construct.c.page1.faah038
         ON ACTION controlp INFIELD faah038
            #add-point:ON ACTION controlp INFIELD faah038
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmdldocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah038  #顯示到畫面上
            NEXT FIELD faah038                     #返回原欄位
    


            #END add-point

 
         #Ctrlp:construct.c.page1.faah039
         ON ACTION controlp INFIELD faah039
            #add-point:ON ACTION controlp INFIELD faah039
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmdsdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah039  #顯示到畫面上
            NEXT FIELD faah039                     #返回原欄位
    


            #END add-point
 

         #Ctrlp:construct.c.page1.faah040
         ON ACTION controlp INFIELD faah040
            #add-point:ON ACTION controlp INFIELD faah040
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_apcadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah040  #顯示到畫面上
            NEXT FIELD faah040                     #返回原欄位
    


            #END add-point
   
 
         #Ctrlp:construct.c.page1.faah041
         ON ACTION controlp INFIELD faah041
            #add-point:ON ACTION controlp INFIELD faah041
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef201 = 'Y' "
            CALL q_ooef001()                           #呼叫開窗 
            DISPLAY g_qryparam.return1 TO faah041  #顯示到畫面上
            NEXT FIELD faah041                     #返回原欄位
    


            #END add-point
 
         #Ctrlp:construct.c.page2.faahownid
         ON ACTION controlp INFIELD faahownid
            #add-point:ON ACTION controlp INFIELD faahownid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faahownid  #顯示到畫面上
            NEXT FIELD faahownid                     #返回原欄位
    


            #END add-point

         #Ctrlp:construct.c.page2.faahowndp
         ON ACTION controlp INFIELD faahowndp
            #add-point:ON ACTION controlp INFIELD faahowndp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faahowndp  #顯示到畫面上
            NEXT FIELD faahowndp                     #返回原欄位
    


            #END add-point

         #Ctrlp:construct.c.page2.faahcrtid
         ON ACTION controlp INFIELD faahcrtid
            #add-point:ON ACTION controlp INFIELD faahcrtid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faahcrtid  #顯示到畫面上
            NEXT FIELD faahcrtid                     #返回原欄位
    


            #END add-point

         #Ctrlp:construct.c.page2.faahcrtdp
         ON ACTION controlp INFIELD faahcrtdp
            #add-point:ON ACTION controlp INFIELD faahcrtdp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faahcrtdp  #顯示到畫面上
            NEXT FIELD faahcrtdp                     #返回原欄位
    


            #END add-point
 

 
         #Ctrlp:construct.c.page2.faahmodid
         ON ACTION controlp INFIELD faahmodid
            #add-point:ON ACTION controlp INFIELD faahmodid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faahmodid  #顯示到畫面上
            NEXT FIELD faahmodid                     #返回原欄位
    


            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON faaiseq,faai004,faai005,faai006,faai007,faai008,faai009,faai010,faai011, 
          faai012,faai013,faai014,faai015,faai016,faai017,faai018,faai019,faai020,faai021,faai022,faai023 

           FROM s_detail3[1].faaiseq,s_detail3[1].faai004,s_detail3[1].faai005,s_detail3[1].faai006, 
               s_detail3[1].faai007,s_detail3[1].faai008,s_detail3[1].faai009,s_detail3[1].faai010,s_detail3[1].faai011, 
               s_detail3[1].faai012,s_detail3[1].faai013,s_detail3[1].faai014,s_detail3[1].faai015,s_detail3[1].faai016, 
               s_detail3[1].faai017,s_detail3[1].faai018,s_detail3[1].faai019,s_detail3[1].faai020,s_detail3[1].faai021, 
               s_detail3[1].faai022,s_detail3[1].faai023
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       

         #Ctrlp:construct.c.page3.faai009
         ON ACTION controlp INFIELD faai009
            #add-point:ON ACTION controlp INFIELD faai009
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faai009  #顯示到畫面上
            NEXT FIELD faai009                     #返回原欄位
    


            #END add-point

         #Ctrlp:construct.c.page3.faai010
         ON ACTION controlp INFIELD faai010
            #add-point:ON ACTION controlp INFIELD faai010
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faai010  #顯示到畫面上
            NEXT FIELD faai010                     #返回原欄位
    


            #END add-point
 

         #Ctrlp:construct.c.page3.faai015
         ON ACTION controlp INFIELD faai015
            #add-point:ON ACTION controlp INFIELD faai015
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faai015  #顯示到畫面上
            NEXT FIELD faai015                     #返回原欄位
    


            #END add-point

            
 
         #Ctrlp:construct.c.page3.faai016
         ON ACTION controlp INFIELD faai016
            #add-point:ON ACTION controlp INFIELD faai016
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faai016  #顯示到畫面上
            NEXT FIELD faai016                     #返回原欄位
    


            #END add-poin
 
         #Ctrlp:construct.c.page3.faai017
         ON ACTION controlp INFIELD faai017
            #add-point:ON ACTION controlp INFIELD faai017
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faai017  #顯示到畫面上
            NEXT FIELD faai017                     #返回原欄位
    


            #END add-point
     
 
         #Ctrlp:construct.c.page3.faai018
         ON ACTION controlp INFIELD faai018
            #add-point:ON ACTION controlp INFIELD faai018
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faai018  #顯示到畫面上
            NEXT FIELD faai018                     #返回原欄位
    


            #END add-point
     
 
         #Ctrlp:construct.c.page3.faai019
         ON ACTION controlp INFIELD faai019
            #add-point:ON ACTION controlp INFIELD faai019
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faai019  #顯示到畫面上
            NEXT FIELD faai019                     #返回原欄位
    


            #END add-point
 

         #Ctrlp:construct.c.page3.faai020
         ON ACTION controlp INFIELD faai020
            #add-point:ON ACTION controlp INFIELD faai020
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faai020  #顯示到畫面上
            NEXT FIELD faai020                     #返回原欄位
    


            #END add-point
 
 
         #Ctrlp:construct.c.page3.faai021
         ON ACTION controlp INFIELD faai021
            #add-point:ON ACTION controlp INFIELD faai021
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faai021  #顯示到畫面上
            NEXT FIELD faai021                     #返回原欄位
    


            #END add-point
 
     
 
         #Ctrlp:construct.c.page3.faai022
         ON ACTION controlp INFIELD faai022
            #add-point:ON ACTION controlp INFIELD faai022
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faai022  #顯示到畫面上
            NEXT FIELD faai022                     #返回原欄位
    


            #END add-point
 

   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON faajld,faaj003,faaj004,faaj005,faaj006,faaj007,faaj008,faaj009,faaj010, 
          faaj011,faaj012,faaj013,faaj014,faaj015,faaj016,faaj017,faaj018,faaj019,faaj020,faaj021,faaj022, 
          faaj023,faaj024,faaj025,faaj026,faaj027,faaj028,faaj029,faaj030,faaj031,faaj032,faaj033,faaj034, 
          faaj035,faaj036,faaj038,faaj039,faaj040,faaj041,faaj042,faaj043,faaj044,faaj045,faaj046,faaj047, 
          faaj101,faaj102,faaj103,faaj104,faaj105,faaj106,faaj107,faaj108,faaj109,faaj110,faaj111,faaj112, 
          faaj113,faaj114,faaj115,faaj116,faaj117,faaj151,faaj152,faaj153,faaj154,faaj155,faaj156,faaj157, 
          faaj158,faaj159,faaj160,faaj161,faaj162,faaj163,faaj164,faaj165,faaj166,faaj167,faajsite
           FROM s_detail4[1].faajld,s_detail4[1].faaj003,s_detail4[1].faaj004,s_detail4[1].faaj005,s_detail4[1].faaj006, 
               s_detail4[1].faaj007,s_detail4[1].faaj008,s_detail4[1].faaj009,s_detail4[1].faaj010,s_detail4[1].faaj011, 
               s_detail4[1].faaj012,s_detail4[1].faaj013,s_detail4[1].faaj014,s_detail4[1].faaj015,s_detail4[1].faaj016, 
               s_detail4[1].faaj017,s_detail4[1].faaj018,s_detail4[1].faaj019,s_detail4[1].faaj020,s_detail4[1].faaj021, 
               s_detail4[1].faaj022,s_detail4[1].faaj023,s_detail4[1].faaj024,s_detail4[1].faaj025,s_detail4[1].faaj026, 
               s_detail4[1].faaj027,s_detail4[1].faaj028,s_detail4[1].faaj029,s_detail4[1].faaj030,s_detail4[1].faaj031, 
               s_detail4[1].faaj032,s_detail4[1].faaj033,s_detail4[1].faaj034,s_detail4[1].faaj035,s_detail4[1].faaj036, 
               s_detail4[1].faaj038,s_detail4[1].faaj039,s_detail4[1].faaj040,s_detail4[1].faaj041,s_detail4[1].faaj042, 
               s_detail4[1].faaj043,s_detail4[1].faaj044,s_detail4[1].faaj045,s_detail4[1].faaj046,s_detail4[1].faaj047, 
               s_detail4[1].faaj101,s_detail4[1].faaj102,s_detail4[1].faaj103,s_detail4[1].faaj104,s_detail4[1].faaj105, 
               s_detail4[1].faaj106,s_detail4[1].faaj107,s_detail4[1].faaj108,s_detail4[1].faaj109,s_detail4[1].faaj110, 
               s_detail4[1].faaj111,s_detail4[1].faaj112,s_detail4[1].faaj113,s_detail4[1].faaj114,s_detail4[1].faaj115, 
               s_detail4[1].faaj116,s_detail4[1].faaj117,s_detail4[1].faaj151,s_detail4[1].faaj152,s_detail4[1].faaj153, 
               s_detail4[1].faaj154,s_detail4[1].faaj155,s_detail4[1].faaj156,s_detail4[1].faaj157,s_detail4[1].faaj158, 
               s_detail4[1].faaj159,s_detail4[1].faaj160,s_detail4[1].faaj161,s_detail4[1].faaj162,s_detail4[1].faaj163, 
               s_detail4[1].faaj164,s_detail4[1].faaj165,s_detail4[1].faaj166,s_detail4[1].faaj167,s_detail4[1].faajsite 

                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page4.faajld
         ON ACTION controlp INFIELD faajld
            #add-point:ON ACTION controlp INFIELD faajld
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faajld  #顯示到畫面上
            NEXT FIELD faajld                     #返回原欄位
    


            #END add-point

         #Ctrlp:construct.c.page4.faaj014
         ON ACTION controlp INFIELD faaj014
            #add-point:ON ACTION controlp INFIELD faaj014
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faaj014  #顯示到畫面上
            NEXT FIELD faaj014                     #返回原欄位
    


            #END add-point
 
         #Ctrlp:construct.c.page4.faaj023
         ON ACTION controlp INFIELD faaj023
            #add-point:ON ACTION controlp INFIELD faaj023
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faaj023  #顯示到畫面上
            NEXT FIELD faaj023                     #返回原欄位
    


            #END add-point
       #Ctrlp:construct.c.page4.faaj024
         ON ACTION controlp INFIELD faaj024
            #add-point:ON ACTION controlp INFIELD faaj024
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faaj024  #顯示到畫面上
            NEXT FIELD faaj024                     #返回原欄位
    


            #END add-point
 
        
 
         #Ctrlp:construct.c.page4.faaj025
         ON ACTION controlp INFIELD faaj025
            #add-point:ON ACTION controlp INFIELD faaj025
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faaj025  #顯示到畫面上
            NEXT FIELD faaj025                     #返回原欄位
    


            #END add-point

         #Ctrlp:construct.c.page4.faaj026
         ON ACTION controlp INFIELD faaj026
            #add-point:ON ACTION controlp INFIELD faaj026
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faaj026  #顯示到畫面上
            NEXT FIELD faaj026                     #返回原欄位
    


            #END add-point
 

 
         #Ctrlp:construct.c.page4.faaj030
         ON ACTION controlp INFIELD faaj030
            #add-point:ON ACTION controlp INFIELD faaj030
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_faaj030()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faaj030  #顯示到畫面上
            NEXT FIELD faaj030                     #返回原欄位
    


            #END add-point
   
 
         #Ctrlp:construct.c.page4.faaj031
         ON ACTION controlp INFIELD faaj031
            #add-point:ON ACTION controlp INFIELD faaj031
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_bgaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faaj031  #顯示到畫面上
            NEXT FIELD faaj031                     #返回原欄位
    


            #END add-point
 

 
         #Ctrlp:construct.c.page4.faaj042
         ON ACTION controlp INFIELD faaj042
            #add-point:ON ACTION controlp INFIELD faaj042
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faaj042  #顯示到畫面上
            NEXT FIELD faaj042                     #返回原欄位
    


            #END add-point
 
  
 
         #Ctrlp:construct.c.page4.faaj043
         ON ACTION controlp INFIELD faaj043
            #add-point:ON ACTION controlp INFIELD faaj043
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faaj043  #顯示到畫面上
            NEXT FIELD faaj043                     #返回原欄位
    


            #END add-point

 
         #Ctrlp:construct.c.page4.faaj045
         ON ACTION controlp INFIELD faaj045
            #add-point:ON ACTION controlp INFIELD faaj045
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faaj045  #顯示到畫面上
            NEXT FIELD faaj045                     #返回原欄位
    


            #END add-point

 
         #Ctrlp:construct.c.page4.faaj046
         ON ACTION controlp INFIELD faaj046
            #add-point:ON ACTION controlp INFIELD faaj046
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faaj046  #顯示到畫面上
            NEXT FIELD faaj046                     #返回原欄位
    

 

 

         ON ACTION controlp INFIELD faajsite
            #add-point:ON ACTION controlp INFIELD faajsite
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_faab001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faajsite  #顯示到畫面上
            NEXT FIELD faajsite                     #返回原欄位
    



            
 
   
       
      END CONSTRUCT
 
 
  
      #add-point:query段more_construct

      #end add-point 
      
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog

         #end add-point  
 
      ON ACTION qbe_select     #條件查詢
         CALL cl_qbe_list('m') RETURNING ls_wc
 
      ON ACTION qbe_save       #條件儲存
         CALL cl_qbe_save()
      
      ON ACTION accept
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         CANCEL DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
   END DIALOG
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = ls_wc
   ELSE
      #資料導回第一筆
      LET g_detail_idx  = 1
      LET g_detail_idx2 = 1
   END IF
   
#   LET g_wc = g_wc_table 
# 
#              , " AND ", g_wc2_table2
# 
#              , " AND ", g_wc2_table3
#              , " AND ", g_wc
 
 
        
   LET g_wc2 = " 1=1"
               , " AND ", g_wc2_table2
 
               , " AND ", g_wc2_table3
 
 
        
   #add-point:cs段after_construct

   #end add-point
   
   LET g_error_show = 1
   CALL afat300_b_fill(g_wc)
   LET l_ac = g_detail_idx
   
   CALL afat300_fetch()
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
 
   #資料導回第一筆(假設有資料)
   IF g_faah_d.getLength() > 0 THEN
      DISPLAY g_detail_idx  TO FORMONLY.h_index
   ELSE
      DISPLAY ' ' TO FORMONLY.h_index
   END IF
   IF g_faah3_d.getLength() > 0 THEN
      DISPLAY g_detail_idx2 TO FORMONLY.idx
   ELSE
      DISPLAY ' ' TO FORMONLY.idx
   END IF
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION afat300_b_fill_1(p_wc2)
   DEFINE p_wc2           STRING
   DEFINE l_ac_t          LIKE type_t.num5

   
   LET g_sql = "SELECT  UNIQUE t0.faah000,t0.faah001,t0.faah003,t0.faah004,t0.faah002,t0.faah005,t0.faah006, 
       t0.faah007,t0.faah008,t0.faah009,t0.faah010,t0.faah011,t0.faah012,t0.faah013,t0.faah014,t0.faah015, 
       t0.faah016,t0.faah017,t0.faah018,t0.faah019,t0.faah020,t0.faah021,t0.faah022,t0.faah023,t0.faah024, 
       t0.faah025,t0.faah026,t0.faah027,t0.faah028,t0.faah029,t0.faah030,t0.faah031,t0.faah032,t0.faah033, 
       t0.faah034,t0.faah035,t0.faah036,t0.faah037,t0.faah038,t0.faah039,t0.faah040,t0.faah041,t0.faah042, 
       t0.faah043,t0.faah044,t0.faah045,t0.faah000,t0.faah001,t0.faah003,t0.faah004,t0.faahownid,t0.faahowndp, 
       t0.faahcrtid,t0.faahcrtdp,t0.faahcrtdt,t0.faahmodid,t0.faahmoddt ,t1.faacl003 ,t2.faadl003 ,t3.oocql004 , 
       t4.pmaal003 ,t5.pmaal004 ,t6.oocel003 ,t7.ooail003 ,t8.ooag011 ,t9.ooefl003 ,t10.oocql004 ,t11.ooag011 , 
       t12.ooefl003 ,t13.ooefl003 ,t14.ooefl003 ,t15.ooefl003 ,t16.ooag011 ,t17.ooefl003 ,t18.ooag011 , 
       t19.ooefl003 ,t20.ooag011,
       t22.faajld,'',t22.faaj003,t22.faaj004,t22.faaj005,t22.faaj006,t22.faaj007,t22.faaj008,t22.faaj009,t22.faaj010,t22.faaj011,t22.faaj012,t22.faaj013,
       t22.faaj014,t22.faaj015,t22.faaj016,t22.faaj017,t22.faaj018,t22.faaj019,t22.faaj020,t22.faaj021,t22.faaj022,t22.faaj023,t22.faaj024,t22.faaj025,t22.faaj026,
       t22.faaj027,t22.faaj028,t22.faaj029,t22.faaj030,t22.faaj031,t22.faaj032,t22.faaj033,t22.faaj034,t22.faaj035,t22.faaj036,t22.faaj038,t22.faaj039,
       t22.faaj040,t22.faaj041,t22.faaj042,t22.faaj043,t4.pmaal003,t22.faaj044,t22.faaj045,t22.faaj046,t22.faaj047,t22.faaj101,t22.faaj102,t22.faaj103,t22.faaj104,
       t22.faaj105,t22.faaj106,t22.faaj107,t22.faaj108,t22.faaj109,t22.faaj110,t22.faaj111,t22.faaj112,t22.faaj113,t22.faaj114,t22.faaj115,t22.faaj116,t22.faaj117,
       t22.faaj151,t22.faaj152,t22.faaj153,t22.faaj154,t22.faaj155,t22.faaj156,t22.faaj157,t22.faaj158,t22.faaj159,t22.faaj160,t22.faaj161,t22.faaj162,t22.faaj163,
       t22.faaj164,t22.faaj165,t22.faaj166,t22.faaj167,
       
       t21.faaiseq,t21.faai004,t21.faai005,t21.faai006,t21.faai007,t21.faai008,t21.faai009,t21.faai010,t21.faai011,t21.faai012,t21.faai013,t21.faai014,t21.faai015,
       t21.faai016,t21.faai017,t21.faai018,t21.faai019,t21.faai020,t21.faai021,t21.faai022,t21.faai023",


               " FROM faah_t t0",
 
               " LEFT JOIN faai_t t21 ON faaient = faahent AND faah000 = faai000 AND faah001 = faai001 AND faah003 = faai002 AND faah004 = faai003",
 
               " LEFT JOIN faaj_t t22 ON faajent = faahent AND faah000 = faaj000 AND faah001 = faaj037 AND faah003 = faaj001 AND faah004 = faaj002",
 
 
               "",
               " LEFT JOIN faacl_t t1 ON t1.faaclent='"||g_enterprise||"' AND t1.faacl001=t0.faah006 AND t1.faacl002='"||g_dlang||"' ",
               " LEFT JOIN faadl_t t2 ON t2.faadlent='"||g_enterprise||"' AND t2.faadl001=t0.faah007 AND t2.faadl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent='"||g_enterprise||"' AND t3.oocql001='3903' AND t3.oocql002=t0.faah008 AND t3.oocql003='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t4 ON t4.pmaalent='"||g_enterprise||"' AND t4.pmaal001=t0.faah009 AND t4.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t5 ON t5.pmaalent='"||g_enterprise||"' AND t5.pmaal001=t0.faah010 AND t5.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN oocel_t t6 ON t6.oocelent='"||g_enterprise||"' AND t6.oocel001=t0.faah011 AND t6.oocel002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t7 ON t7.ooailent='"||g_enterprise||"' AND t7.ooail001=t0.faah020 AND t7.ooail002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent='"||g_enterprise||"' AND t8.ooag001=t0.faah025  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent='"||g_enterprise||"' AND t9.ooefl001=t0.faah026 AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t10 ON t10.oocqlent='"||g_enterprise||"' AND t10.oocql001='3900' AND t10.oocql002=t0.faah027 AND t10.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent='"||g_enterprise||"' AND t11.ooag001=t0.faah029  ",
               " LEFT JOIN ooefl_t t12 ON t12.ooeflent='"||g_enterprise||"' AND t12.ooefl001=t0.faah030 AND t12.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t13 ON t13.ooeflent='"||g_enterprise||"' AND t13.ooefl001=t0.faah031 AND t13.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t14 ON t14.ooeflent='"||g_enterprise||"' AND t14.ooefl001=t0.faah032 AND t14.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t15 ON t15.ooeflent='"||g_enterprise||"' AND t15.ooefl001=t0.faah041 AND t15.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t16 ON t16.ooagent='"||g_enterprise||"' AND t16.ooag001=t0.faahownid  ",
               " LEFT JOIN ooefl_t t17 ON t17.ooeflent='"||g_enterprise||"' AND t17.ooefl001=t0.faahowndp AND t17.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t18 ON t18.ooagent='"||g_enterprise||"' AND t18.ooag001=t0.faahcrtid  ",
               " LEFT JOIN ooefl_t t19 ON t19.ooeflent='"||g_enterprise||"' AND t19.ooefl001=t0.faahcrtdp AND t19.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t20 ON t20.ooagent='"||g_enterprise||"' AND t20.ooag001=t0.faahmodid  ",
               #" LEFT JOIN glaal_t t21 ON t21.glaalent='"||g_enterprise||"' AND t21.glaal001='"||g_dlang||"' AND t21.glaalld=faaj_t.faajld ",
               " WHERE t0.faahent= ?  AND  1=1 AND (", p_wc2, ") "
   #add-point:b_fill段sql_wc

   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("faah_t"),
                      " ORDER BY t0.faah000,t0.faah001,t0.faah003,t0.faah004"
  
   #add-point:b_fill段sql_after

   #end add-point
  
   #LET g_sql = cl_sql_add_tabid(g_sql,"faah_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料  
   PREPARE afat300_pb_1 FROM g_sql
   DECLARE b_fill_curs_1 CURSOR FOR afat300_pb_1
   
   OPEN b_fill_curs_1 USING g_enterprise
 
   CALL g_faah_d.clear()
   CALL g_faah2_d.clear()   
   CALL g_faah3_d.clear()   
   CALL g_faah4_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs_1 INTO g_faah_d[l_ac].faah000,g_faah_d[l_ac].faah001,g_faah_d[l_ac].faah003,g_faah_d[l_ac].faah004, 
       g_faah_d[l_ac].faah002,g_faah_d[l_ac].faah005,g_faah_d[l_ac].faah006,g_faah_d[l_ac].faah007,g_faah_d[l_ac].faah008, 
       g_faah_d[l_ac].faah009,g_faah_d[l_ac].faah010,g_faah_d[l_ac].faah011,g_faah_d[l_ac].faah012,g_faah_d[l_ac].faah013, 
       g_faah_d[l_ac].faah014,g_faah_d[l_ac].faah015,g_faah_d[l_ac].faah016,g_faah_d[l_ac].faah017,g_faah_d[l_ac].faah018, 
       g_faah_d[l_ac].faah019,g_faah_d[l_ac].faah020,g_faah_d[l_ac].faah021,g_faah_d[l_ac].faah022,g_faah_d[l_ac].faah023, 
       g_faah_d[l_ac].faah024,g_faah_d[l_ac].faah025,g_faah_d[l_ac].faah026,g_faah_d[l_ac].faah027,g_faah_d[l_ac].faah028, 
       g_faah_d[l_ac].faah029,g_faah_d[l_ac].faah030,g_faah_d[l_ac].faah031,g_faah_d[l_ac].faah032,g_faah_d[l_ac].faah033, 
       g_faah_d[l_ac].faah034,g_faah_d[l_ac].faah035,g_faah_d[l_ac].faah036,g_faah_d[l_ac].faah037,g_faah_d[l_ac].faah038, 
       g_faah_d[l_ac].faah039,g_faah_d[l_ac].faah040,g_faah_d[l_ac].faah041,g_faah_d[l_ac].faah042,g_faah_d[l_ac].faah043, 
       g_faah_d[l_ac].faah044,g_faah_d[l_ac].faah045,g_faah2_d[l_ac].faah000,g_faah2_d[l_ac].faah001, 
       g_faah2_d[l_ac].faah003,g_faah2_d[l_ac].faah004,g_faah2_d[l_ac].faahownid,g_faah2_d[l_ac].faahowndp, 
       g_faah2_d[l_ac].faahcrtid,g_faah2_d[l_ac].faahcrtdp,g_faah2_d[l_ac].faahcrtdt,g_faah2_d[l_ac].faahmodid, 
       g_faah2_d[l_ac].faahmoddt,g_faah_d[l_ac].faah006_desc,g_faah_d[l_ac].faah007_desc,g_faah_d[l_ac].faah008_desc, 
       g_faah_d[l_ac].faah009_desc,g_faah_d[l_ac].faah010_desc,g_faah_d[l_ac].faah011_desc,g_faah_d[l_ac].faah020_desc, 
       g_faah_d[l_ac].faah025_desc,g_faah_d[l_ac].faah026_desc,g_faah_d[l_ac].faah027_desc,g_faah_d[l_ac].faah029_desc, 
       g_faah_d[l_ac].faah030_desc,g_faah_d[l_ac].faah031_desc,g_faah_d[l_ac].faah032_desc,g_faah_d[l_ac].faah041_desc, 
       g_faah2_d[l_ac].faahownid_desc,g_faah2_d[l_ac].faahowndp_desc,g_faah2_d[l_ac].faahcrtid_desc, 
       g_faah2_d[l_ac].faahcrtdp_desc,g_faah2_d[l_ac].faahmodid_desc,
       g_faah4_d[l_ac].faajld,g_faah4_d[l_ac].faajld_desc,g_faah4_d[l_ac].faaj003,g_faah4_d[l_ac].faaj004,g_faah4_d[l_ac].faaj005,
       g_faah4_d[l_ac].faaj006,g_faah4_d[l_ac].faaj007,g_faah4_d[l_ac].faaj008,g_faah4_d[l_ac].faaj009,g_faah4_d[l_ac].faaj010,
       g_faah4_d[l_ac].faaj011,g_faah4_d[l_ac].faaj012,g_faah4_d[l_ac].faaj013,g_faah4_d[l_ac].faaj014,g_faah4_d[l_ac].faaj015,
       g_faah4_d[l_ac].faaj016,g_faah4_d[l_ac].faaj017,g_faah4_d[l_ac].faaj018,g_faah4_d[l_ac].faaj019,g_faah4_d[l_ac].faaj020,
       g_faah4_d[l_ac].faaj021,g_faah4_d[l_ac].faaj022,g_faah4_d[l_ac].faaj023,g_faah4_d[l_ac].faaj024,g_faah4_d[l_ac].faaj025,
       g_faah4_d[l_ac].faaj026,g_faah4_d[l_ac].faaj027,g_faah4_d[l_ac].faaj028,g_faah4_d[l_ac].faaj029,g_faah4_d[l_ac].faaj030,
       g_faah4_d[l_ac].faaj031,g_faah4_d[l_ac].faaj032,g_faah4_d[l_ac].faaj033,g_faah4_d[l_ac].faaj034,g_faah4_d[l_ac].faaj035,
       g_faah4_d[l_ac].faaj036,g_faah4_d[l_ac].faaj038,g_faah4_d[l_ac].faaj039,g_faah4_d[l_ac].faaj040,
       g_faah4_d[l_ac].faaj041,g_faah4_d[l_ac].faaj042,g_faah4_d[l_ac].faaj043,g_faah4_d[l_ac].faaj043_desc,g_faah4_d[l_ac].faaj044,
       g_faah4_d[l_ac].faaj045,g_faah4_d[l_ac].faaj046,g_faah4_d[l_ac].faaj047,g_faah4_d[l_ac].faaj101,g_faah4_d[l_ac].faaj102,
       g_faah4_d[l_ac].faaj103,g_faah4_d[l_ac].faaj104,g_faah4_d[l_ac].faaj105,g_faah4_d[l_ac].faaj106,g_faah4_d[l_ac].faaj107,
       g_faah4_d[l_ac].faaj108,g_faah4_d[l_ac].faaj109,g_faah4_d[l_ac].faaj110,g_faah4_d[l_ac].faaj111,g_faah4_d[l_ac].faaj112,
       g_faah4_d[l_ac].faaj113,g_faah4_d[l_ac].faaj114,g_faah4_d[l_ac].faaj115,g_faah4_d[l_ac].faaj116,g_faah4_d[l_ac].faaj117,
       g_faah4_d[l_ac].faaj151,g_faah4_d[l_ac].faaj152,g_faah4_d[l_ac].faaj153,g_faah4_d[l_ac].faaj154,g_faah4_d[l_ac].faaj155,
       g_faah4_d[l_ac].faaj156,g_faah4_d[l_ac].faaj157,g_faah4_d[l_ac].faaj158,g_faah4_d[l_ac].faaj159,g_faah4_d[l_ac].faaj160,
       g_faah4_d[l_ac].faaj161,g_faah4_d[l_ac].faaj162,g_faah4_d[l_ac].faaj163,g_faah4_d[l_ac].faaj164,g_faah4_d[l_ac].faaj165,
       g_faah4_d[l_ac].faaj166,g_faah4_d[l_ac].faaj167,
       
       g_faah3_d[l_ac].faaiseq,g_faah3_d[l_ac].faai004,g_faah3_d[l_ac].faai005,g_faah3_d[l_ac].faai006,g_faah3_d[l_ac].faai007,
       g_faah3_d[l_ac].faai008,g_faah3_d[l_ac].faai009,g_faah3_d[l_ac].faai010,g_faah3_d[l_ac].faai011,g_faah3_d[l_ac].faai012,
       g_faah3_d[l_ac].faai013,g_faah3_d[l_ac].faai014,g_faah3_d[l_ac].faai015,g_faah3_d[l_ac].faai016,g_faah3_d[l_ac].faai017,
       g_faah3_d[l_ac].faai018,g_faah3_d[l_ac].faai019,g_faah3_d[l_ac].faai020,g_faah3_d[l_ac].faai021,g_faah3_d[l_ac].faai022,
       g_faah3_d[l_ac].faai023
       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充

      #end add-point
 
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
   
 
   CALL g_faah_d.deleteElement(g_faah_d.getLength())   
   CALL g_faah2_d.deleteElement(g_faah2_d.getLength())
   CALL g_faah3_d.deleteElement(g_faah3_d.getLength())
   CALL g_faah4_d.deleteElement(g_faah4_d.getLength())
 
   
   #確定指標無超過上限, 超過則指到最後一筆
   IF g_detail_idx > g_faah_d.getLength() THEN
      LET g_detail_idx = g_faah_d.getLength()
   END IF
   
   #將key欄位填到每個page
   LET l_ac_t = g_detail_idx
   FOR g_detail_idx = 1 TO g_faah_d.getLength()
      LET g_faah2_d[g_detail_idx].faah000 = g_faah_d[g_detail_idx].faah000 
      LET g_faah2_d[g_detail_idx].faah001 = g_faah_d[g_detail_idx].faah001 
      LET g_faah2_d[g_detail_idx].faah003 = g_faah_d[g_detail_idx].faah003 
      LET g_faah2_d[g_detail_idx].faah004 = g_faah_d[g_detail_idx].faah004 
      #LET g_faah3_d[g_detail_idx2].faaiseq = g_faah_d[g_detail_idx].faah000 
      #LET g_faah4_d[g_detail_idx2].faajld = g_faah_d[g_detail_idx].faah000 
 
   END FOR
   LET g_detail_idx = l_ac_t
   
   #add-point:b_fill段資料填充(其他單身)

   #end add-point
    
   LET g_detail_cnt = l_ac - 1
   IF g_detail_cnt > 0 THEN
      DISPLAY g_detail_cnt TO FORMONLY.h_count
   END IF
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE afat300_pb
   
   LET g_loc = 'm'
   CALL afat300_detail_show() 
   
   LET l_ac = 1
   IF g_faah_d.getLength() > 0 THEN
      CALL afat300_fetch()
   END IF
   
   ERROR "" 
  
END FUNCTION

################################################################################
# Descriptions...: 整批导入
################################################################################
PRIVATE FUNCTION afat300_s01()
DEFINE l_excel         STRING 
DEFINE ls_str          STRING
DEFINE l_chr           LIKE type_t.chr1   
DEFINE l_chr1          LIKE type_t.chr1   
DEFINE l_num           LIKE type_t.num5
DEFINE l_n             LIKE type_t.num5
DEFINE l_success       LIKE type_t.num5
   #畫面開啟 (identifier)

   OPEN WINDOW w_afat300_s01 WITH FORM cl_ap_formpath("afa","afat300_s01")

   INITIALIZE g_faah_f.* LIKE faah_t.*
   
   LET g_faah_f_t.faah032 = NULL
   LET g_faah_f_t.format = NULL
   LET g_faah_f_t.char = NULL
   LET g_faah_f_t.dir = NULL
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_faah_f.faah032,g_faah_f.format,g_faah_f.char,g_faah_f.dir,g_faah_f.inf ATTRIBUTE(WITHOUT  DEFAULTS)

         BEFORE INPUT
            CALL cl_set_combo_scc('format','8915')
         AFTER FIELD faah032
            IF cl_null(g_faah_f.faah032) THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aap-00216'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF   
         AFTER FIELD inf
            IF cl_null(g_faah_f.inf) THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-01003'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF

 
         ON ACTION controlp INFIELD faah032
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_f.faah032             #給予default值
           
            #帳套不為空時，法人組織開窗開帳套歸屬法人的法人組織
            #CALL q_ooef001_8()                                #呼叫開窗 #161024-00008#2 
             CALL q_ooef001_2()                                          #161024-00008#2 

            LET g_faah_f.faah032 = g_qryparam.return1              
            DISPLAY g_faah_f.faah032 TO faah032 
            #DISPLAY g_xcda_f.xcdacomp_desc TO xcdacomp_desc              #
 
            LET g_qryparam.where = "" 
   
            NEXT FIELD faah032                          #返回原欄位

         AFTER INPUT
         
            
      END INPUT
    
    
      ON ACTION browser
         CALL cl_client_browse_file() RETURNING g_faah_f.dir
         LET ls_str = g_faah_f.dir
         #抓取目录斜杆
         LET l_num =ls_str.getIndexOf(':',1)                                    #抓取：后的字符位置
         LET l_chr = ls_str.substring(l_num+1,l_num+1)                          #截取冒号后的字符 
         LET l_chr1 = ls_str.substring(ls_str.getLength(),ls_str.getLength())   #判断是否为根目录

         LET g_faah_f.dir = g_faah_f.dir

         DISPLAY BY NAME g_faah_f.dir

 
      ON ACTION close
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit
         LET INT_FLAG = TRUE 
         EXIT DIALOG
         
      ON ACTION produce
         ACCEPT DIALOG 

      ON ACTION off
         LET INT_FLAG = TRUE
         EXIT DIALOG   
         
   
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
 
   
   
   #畫面關閉
   CLOSE WINDOW w_afat300_s01 
   CALL afat300_s01_ins_from_excel(g_faah_f.dir) RETURNING l_success
   RETURN l_success

END FUNCTION

################################################################################
# Descriptions...: 開賬匯出格式
################################################################################
PRIVATE FUNCTION afat300_s02()
DEFINE p_xrad001      LIKE xrad_t.xrad001
DEFINE l_xradl003     LIKE type_t.chr80
DEFINE ls_str          STRING
DEFINE l_chr           LIKE type_t.chr1   
DEFINE l_chr1          LIKE type_t.chr1  
DEFINE l_num           LIKE type_t.num5
   
   OPEN WINDOW w_afat300_s02 WITH FORM cl_ap_formpath("afa","afat300_s02")
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #輸入開始
      INPUT BY NAME g_faah_s.name,g_faah_s.dir,g_faah_s.inf
         BEFORE INPUT
           LET g_faah_s.inf='1'
           AFTER FIELD inf
              IF cl_null(g_faah_s.inf) THEN 
                 LET g_faah_s.inf='1' 
                 DISPLAY g_faah_s.inf TO inf
              END IF 
              
         AFTER INPUT
            

      END INPUT

      ON ACTION close
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION exit
         LET INT_FLAG = TRUE
         EXIT DIALOG
      
      
      ON ACTION browser1
         CALL cl_client_browse_dir() RETURNING g_faah_s.dir
         LET ls_str = g_faah_s.dir
         #抓取目录斜杆
         LET l_num =ls_str.getIndexOf(':',1)                                    #抓取：后的字符位置
         LET l_chr = ls_str.substring(l_num+1,l_num+1)                          #截取冒号后的字符 
         LET l_chr1 = ls_str.substring(ls_str.getLength(),ls_str.getLength())   #判断是否为根目录
         IF l_chr <> l_chr1  THEN         
            LET g_faah_s.dir = g_faah_s.dir||l_chr 
         ELSE
            LET g_faah_s.dir = g_faah_s.dir 
         END IF 
         DISPLAY BY NAME g_faah_s.dir
         
      ON ACTION produce
         LET g_inf = g_faah_s.inf
         LET w = ui.Window.getCurrent()
         LET f = w.getForm()
         IF g_inf='1' THEN  
            LET page = f.FindNode("Page","page_5")
            CALL afat300_excelexample(page,base.TypeInfo.create(g_faah_d),'Y')
         END IF 
         IF g_inf='2' THEN 
               LET page = f.FindNode("Page","page_6")
               CALL afat300_excelexample(page,base.TypeInfo.create(g_faah3_d),'Y')
         END IF
         IF g_inf='3' THEN       
            LET page = f.FindNode("Page","page_7")
            CALL afat300_excelexample(page,base.TypeInfo.create(g_faah4_d),'Y')
         END IF
       
        ACCEPT DIALOG 

      ON ACTION off
         LET INT_FLAG = TRUE
         EXIT DIALOG


   END DIALOG

   



      #畫面關閉
      CLOSE WINDOW w_afat300_s02
      RETURN TRUE
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
PRIVATE FUNCTION afat300_excelexample(n,t,p_show_hidden)
DEFINE  t,t1,t2,n1_text,n3_text         om.DomNode,
         n,n2,n_child                    om.DomNode,
         p_show_hidden                   LIKE type_t.chr1,    #隱藏欄位是否顯示
         n1,n_table,n3                   om.NodeList,
         i,res,p,q,k                     LIKE type_t.num10,
         h                               LIKE type_t.num10,
         cnt_combo_data,cnt_combo_tot    LIKE type_t.num10,
         cells,values,j,l,sheet,cc       STRING,
         table_name,l_length             STRING,
         l_table_name                    LIKE type_t.chr20,
         l_datatype                      LIKE type_t.chr20,
         l_bufstr                        base.StringBuffer,
         lwin_curr                       ui.Window,
         l_show                          LIKE type_t.chr1,
         l_time                          LIKE type_t.chr8

 DEFINE  combo_arr        DYNAMIC ARRAY OF RECORD
           sheet          LIKE type_t.num10,
           seq            LIKE type_t.num10,
           name           LIKE type_t.chr2,
           text           LIKE type_t.chr50
                          END RECORD
 DEFINE  customize_table  LIKE type_t.chr1
 DEFINE  l_str            STRING
 DEFINE  l_i              LIKE type_t.num5
 DEFINE  buf              base.StringBuffer
 DEFINE  l_dec_point      STRING,
         l_qry_name       LIKE type_t.chr20,
         l_cust           LIKE type_t.chr1
 DEFINE  l_tabIndex       LIKE type_t.num10
 DEFINE  l_seq            DYNAMIC ARRAY OF LIKE type_t.num10
 DEFINE  l_seq2           DYNAMIC ARRAY OF LIKE type_t.num10
 DEFINE  l_j              LIKE type_t.num5
 DEFINE  bFound           LIKE type_t.num5
 DEFINE  l_dbname         STRING
 DEFINE  l_zal09          LIKE type_t.chr1
 DEFINE  l_desc           STRING


   
   WHENEVER ERROR CALL cl_err_msg_log

   LET cnt_table = 1

   LET l_bufstr = base.StringBuffer.create()
#   WHENEVER ERROR CALL cl_err_msg_log
   LET lwin_curr = ui.window.getCurrent()

   LET l_channel = base.Channel.create()
   LET l_time = TIME(CURRENT)
  #LET xls_name = g_prog CLIPPED,l_time CLIPPED,".xls"
   LET xls_name = g_faah_s.name CLIPPED,".xls"

   LET buf = base.StringBuffer.create()
   CALL buf.append(xls_name)
   CALL buf.replace( ":","-", 0)
   LET xls_name = buf.toString()

   # 個資會記錄使用者的行為模式，在此說明excel的檔名及匯出excel的方式
   LET l_desc = xls_name CLIPPED," Using HTML to export the Table to excel."

   IF os.Path.delete(xls_name CLIPPED) THEN END IF
   CALL l_channel.openFile( xls_name CLIPPED, "a" )
   CALL l_channel.setDelimiter("")

   IF ms_codeset.getIndexOf("BIG5", 1) OR
      ( ms_codeset.getIndexOf("GB2312", 1) OR ms_codeset.getIndexOf("GBK", 1) OR ms_codeset.getIndexOf("GB18030", 1) ) THEN
      IF ms_locale = "ZH_TW" AND g_lang = '2' THEN
         LET tsconv_cmd = "big5_to_gb2312"
         LET ms_codeset = "GB2312"
      END IF
      IF ms_locale = "ZH_CN" AND g_lang = '0' THEN
         LET tsconv_cmd = "gb2312_to_big5"
         LET ms_codeset = "BIG5"
      END IF
   END IF

   LET l_str = "<html xmlns:o=",g_quote,"urn:schemas-microsoft-com:office:office",g_quote
   CALL l_channel.write(l_str CLIPPED)
   LET l_str = "<meta http-equiv=Content-Type content=",g_quote,"text/html; charset=",ms_codeset,g_quote,">"
   CALL l_channel.write(l_str CLIPPED)
   LET l_str = "xmlns:x=",g_quote,"urn:schemas-microsoft-com:office:excel",g_quote
   CALL l_channel.write(l_str CLIPPED)
   LET l_str = "xmlns=",g_quote,"http://www.w3.org/TR/REC-html40",g_quote,">"
   CALL l_channel.write(l_str CLIPPED)
   CALL l_channel.write("<head><style><!--")

   IF not ms_codeset.getIndexOf("UTF-8", 1) THEN
      IF g_lang = "0" THEN  #繁體中文
         CALL l_channel.write("td  {font-family:細明體, serif;}")
      ELSE
         IF g_lang = "2" THEN  #簡體中文
            CALL l_channel.write("td  {font-family:新宋体, serif;}")
         ELSE
            CALL l_channel.write("td  {font-family:細明體, serif;}")
         END IF
      END IF
   ELSE
      CALL l_channel.write("td  {font-family:Courier New, serif;}")
   END IF

   LET l_str = ".xl24  {mso-number-format:",g_quote,"\@",g_quote,";}",
               ".xl30 {mso-style-parent:style0; mso-number-format:\"0_ \";} ",
               ".xl31 {mso-style-parent:style0; mso-number-format:\"0\.0_ \";} ",
               ".xl32 {mso-style-parent:style0; mso-number-format:\"0\.00_ \";} ",
               ".xl33 {mso-style-parent:style0; mso-number-format:\"0\.000_ \";} ",
               ".xl34 {mso-style-parent:style0; mso-number-format:\"0\.0000_ \";} ",
               ".xl35 {mso-style-parent:style0; mso-number-format:\"0\.00000_ \";} ",
               ".xl36 {mso-style-parent:style0; mso-number-format:\"0\.000000_ \";} ",
               ".xl37 {mso-style-parent:style0; mso-number-format:\"0\.0000000_ \";} ",
               ".xl38 {mso-style-parent:style0; mso-number-format:\"0\.00000000_ \";} ",
               ".xl39 {mso-style-parent:style0; mso-number-format:\"0\.000000000_ \";} ",
               ".xl40 {mso-style-parent:style0; mso-number-format:\"0\.0000000000_ \";} "
   CALL l_channel.write(l_str CLIPPED)
   CALL l_channel.write("--></style>")
   CALL l_channel.write("<!--[if gte mso 9]><xml>")
   CALL l_channel.write("<x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet>")
   CALL l_channel.write("<x:DefaultRowHeight>330</x:DefaultRowHeight>")
   CALL l_channel.write("</xml><![endif]--></head>")
   CALL l_channel.write("<body><table border=1 cellpadding=0 cellspacing=0 width=432 style='border-collapse: collapse;table-layout:fixed;width:324pt'>")
   CALL l_channel.write("<tr height=22>")

   LET l_win_name = NULL
   LET l_win_name = n.getAttribute("name")

   LET n_table = n.selectByTagName("Table")
   CALL combo_arr.clear()
   FOR h=1 to cnt_table
      CALL g_hidden.clear()
      CALL g_ifchar.clear()
      CALL g_mask.clear()
      LET n2 = n_table.item(h)

      IF l_win_name = "p_dbqry_table" THEN
         LET n1 = n2.selectByPath("//TableColumn[@hidden=\"0\"]")
      ELSE
         LET n1 = n2.selectByTagName("TableColumn")
      END IF

      #抓取 table 是否有進行欄位排序
      INITIALIZE g_sort.* TO NULL
      LET g_sort.column = n2.getAttribute("sortColumn")
      IF g_sort.column >=0 AND g_sort.column IS NOT NULL  THEN
         LET g_sort.column = g_sort.column + 1    #屬性 sortColumn 為 0 開始
         LET g_sort.type = n2.getAttribute("sortType")
      END IF

      LET cnt_header = n1.getLength()
      LET l = h
      LET sheet=g_sheet  CLIPPED,l
      LET k = 0

      CALL l_seq.clear()
      CALL l_seq2.clear()

     #循環Table中的每一個列
     FOR i=1 TO cnt_header
       #得到對應的DomNode節點
       LET n1_text = n1.item(i)
       #得到該列的TabIndex屬性
       LET l_tabIndex = n1_text.getAttribute("tabIndex")

       #如果TabIndex屬性不為空
       IF NOT cl_null(l_tabIndex) THEN
          #初始化一個標志變量（表明是否在數組中找到比當前TabIndex更大的節點）
          LET bFound = FALSE
          #開始在已有的數組中定位比當前tabIndex大的成員
          FOR l_j=1 TO l_seq2.getLength()
              #如果有找到
              IF l_seq2[l_j] > l_tabIndex THEN
                 #設置標志變量
                 LET bFound = TRUE
                 #退出搜尋過程（此時下標j保存的該成員變量的位置）
                 EXIT FOR
              END IF
          END FOR
          #如果始終沒有找到（比如數組根本就是空的）那麼j里面保存的就是當前數組最大下標+1
          #判斷有沒有找到
          IF bFound THEN
             #如果找到則向該數組中插入一個元素（在這個tabIndex比它大的元素前面插入)
             CALL l_seq2.InsertElement(l_j)
             CALL l_seq.InsertElement(l_j)
          END IF
          #把當前的下標（列的位置）和tabIndex填充到這個位置上
          #如果沒有找到，則填充的位置會是整個數組的末尾
          LET l_seq[l_j] = i
          LET l_seq2[l_j] = l_tabIndex
       END IF
     END FOR

      FOR i=1 to cnt_header
         LET n1_text = n1.item(l_seq[i])
         LET k = k + 1
         LET j = k
         LET cells = "R1C" CLIPPED,j
         LET l_field_name = NULL
         LET l_show = n1_text.getAttribute("hidden")
         IF ((p_show_hidden = 'N' OR p_show_hidden IS NULL) AND (l_show = "0" OR l_show IS NULL)) OR p_show_hidden = 'Y' THEN
            LET l_field_name = n1_text.getAttribute("name")
            IF l_field_name = 'faah_t.faahent' OR l_field_name = 'faah_t.faah000' OR
               l_field_name = 'faah_t.faah001' OR l_field_name = 'faah_t.faah002' OR
               l_field_name = 'faah_t.faah003' OR l_field_name = 'faah_t.faah004' OR
               l_field_name = 'faah_t.faah005' OR l_field_name = 'faah_t.faah006' OR
               l_field_name = 'faah_t.faah007' OR l_field_name = 'faah_t.faah008' OR
               l_field_name = 'faah_t.faah009' OR l_field_name = 'faah_t.faah010' OR
               l_field_name = 'faah_t.faah011' OR l_field_name = 'faah_t.faah012' OR
               l_field_name = 'faah_t.faah013' OR l_field_name = 'faah_t.faah014' OR
               l_field_name = 'faah_t.faah015' OR l_field_name = 'faah_t.faah016' OR
               l_field_name = 'faah_t.faah017' OR l_field_name = 'faah_t.faah018' OR
               l_field_name = 'faah_t.faah019' OR l_field_name = 'faah_t.faah020' OR
               l_field_name = 'faah_t.faah021' OR l_field_name = 'faah_t.faah022' OR
               l_field_name = 'faah_t.faah023' OR l_field_name = 'faah_t.faah024' OR
               l_field_name = 'faah_t.faah025' OR l_field_name = 'faah_t.faah026' OR
               l_field_name = 'faah_t.faah027' OR l_field_name = 'faah_t.faah028' OR
               l_field_name = 'faah_t.faah029' OR l_field_name = 'faah_t.faah030' OR
               l_field_name = 'faah_t.faah031' OR l_field_name = 'faah_t.faah032' OR
               l_field_name = 'faah_t.faah033' OR l_field_name = 'faah_t.faah034' OR
               l_field_name = 'faah_t.faah035' OR l_field_name = 'faah_t.faah036' OR
               l_field_name = 'faah_t.faah037' OR l_field_name = 'faah_t.faah038' OR
               l_field_name = 'faah_t.faah039' OR l_field_name = 'faah_t.faah040' OR
               l_field_name = 'faah_t.faah041' OR l_field_name = 'faah_t.faah042' OR
               l_field_name = 'faah_t.faah043' OR l_field_name = 'faah_t.faah044' OR
               l_field_name = 'faah_t.faah045' OR l_field_name = 'faai_t.faaient' OR
               l_field_name = 'faai_t.faai000' OR l_field_name = 'faai_t.faai001' OR
               l_field_name = 'faai_t.faai002' OR l_field_name = 'faai_t.faai003' OR
               l_field_name = 'faai_t.faaiseq' OR l_field_name = 'faai_t.faai004' OR
               l_field_name = 'faai_t.faai005' OR l_field_name = 'faai_t.faai006' OR
               l_field_name = 'faai_t.faai007' OR l_field_name = 'faai_t.faai008' OR
               l_field_name = 'faai_t.faai009' OR l_field_name = 'faai_t.faai010' OR
               l_field_name = 'faai_t.faai011' OR l_field_name = 'faai_t.faai012' OR
               l_field_name = 'faai_t.faai013' OR l_field_name = 'faai_t.faai014' OR
               l_field_name = 'faai_t.faai015' OR l_field_name = 'faai_t.faai016' OR
               l_field_name = 'faai_t.faai017' OR l_field_name = 'faai_t.faai018' OR
               l_field_name = 'faai_t.faai019' OR l_field_name = 'faai_t.faai020' OR
               l_field_name = 'faai_t.faai021' OR l_field_name = 'faai_t.faai022' OR
               l_field_name = 'faai_t.faai023' OR l_field_name = 'faaj_t.faajent' OR 
               l_field_name = 'faaj_t.faajld'  OR l_field_name = 'faaj_t.faajsite' OR 
               l_field_name = 'faaj_t.faaj000' OR l_field_name = 'faaj_t.faaj001' OR
               l_field_name = 'faaj_t.faaj002' OR l_field_name = 'faaj_t.faaj003' OR
               l_field_name = 'faaj_t.faaj004' OR l_field_name = 'faaj_t.faaj005' OR
               l_field_name = 'faaj_t.faaj006' OR l_field_name = 'faaj_t.faaj007' OR
               l_field_name = 'faaj_t.faaj008' OR l_field_name = 'faaj_t.faaj009' OR
               l_field_name = 'faaj_t.faaj010' OR l_field_name = 'faaj_t.faaj011' OR
               l_field_name = 'faaj_t.faaj012' OR l_field_name = 'faaj_t.faaj013' OR
               l_field_name = 'faaj_t.faaj014' OR l_field_name = 'faaj_t.faaj015' OR
               l_field_name = 'faaj_t.faaj016' OR l_field_name = 'faaj_t.faaj017' OR
               l_field_name = 'faaj_t.faaj018' OR l_field_name = 'faaj_t.faaj019' OR
               l_field_name = 'faaj_t.faaj020' OR l_field_name = 'faaj_t.faaj021' OR
               l_field_name = 'faaj_t.faaj022' OR l_field_name = 'faaj_t.faaj023' OR
               l_field_name = 'faaj_t.faaj024' OR l_field_name = 'faaj_t.faaj025' OR
               l_field_name = 'faaj_t.faaj026' OR l_field_name = 'faaj_t.faaj027' OR
               l_field_name = 'faaj_t.faaj028' OR l_field_name = 'faaj_t.faaj029' OR
               l_field_name = 'faaj_t.faaj030' OR l_field_name = 'faaj_t.faaj031' OR
               l_field_name = 'faaj_t.faaj032' OR l_field_name = 'faaj_t.faaj033' OR
               l_field_name = 'faaj_t.faaj034' OR l_field_name = 'faaj_t.faaj035' OR
               l_field_name = 'faaj_t.faaj036' OR l_field_name = 'faaj_t.faaj037' OR
               l_field_name = 'faaj_t.faaj038' OR l_field_name = 'faaj_t.faaj039' OR
               l_field_name = 'faaj_t.faaj040' OR l_field_name = 'faaj_t.faaj041' OR
               l_field_name = 'faaj_t.faaj042' OR l_field_name = 'faaj_t.faaj043' OR
               l_field_name = 'faaj_t.faaj044' OR l_field_name = 'faaj_t.faaj045' OR
               l_field_name = 'faaj_t.faaj046' OR l_field_name = 'faaj_t.faaj047' OR
               l_field_name = 'faaj_t.faaj101' OR l_field_name = 'faaj_t.faaj102' OR
               l_field_name = 'faaj_t.faaj103' OR l_field_name = 'faaj_t.faaj104' OR
               l_field_name = 'faaj_t.faaj105' OR l_field_name = 'faaj_t.faaj106' OR
               l_field_name = 'faaj_t.faaj107' OR l_field_name = 'faaj_t.faaj108' OR
               l_field_name = 'faaj_t.faaj109' OR l_field_name = 'faaj_t.faaj110' OR
               l_field_name = 'faaj_t.faaj111' OR l_field_name = 'faaj_t.faaj112' OR
               l_field_name = 'faaj_t.faaj113' OR l_field_name = 'faaj_t.faaj114' OR
               l_field_name = 'faaj_t.faaj115' OR l_field_name = 'faaj_t.faaj116' OR
               l_field_name = 'faaj_t.faaj117' OR l_field_name = 'faaj_t.faaj151' OR
               l_field_name = 'faaj_t.faaj152' OR l_field_name = 'faaj_t.faaj153' OR
               l_field_name = 'faaj_t.faaj154' OR l_field_name = 'faaj_t.faaj155' OR
               l_field_name = 'faaj_t.faaj156' OR l_field_name = 'faaj_t.faaj157' OR
               l_field_name = 'faaj_t.faaj158' OR l_field_name = 'faaj_t.faaj159' OR
               l_field_name = 'faaj_t.faaj160' OR l_field_name = 'faaj_t.faaj161' OR
               l_field_name = 'faaj_t.faaj162' OR l_field_name = 'faaj_t.faaj163' OR
               l_field_name = 'faaj_t.faaj164' OR l_field_name = 'faaj_t.faaj165' OR
               l_field_name = 'faaj_t.faaj166' OR l_field_name = 'faaj_t.faaj167' 

                 
               THEN
               LET values = n1_text.getAttribute("text")
               LET l_str = "<td>",afat300_add_span(values),"</td>"
               CALL l_channel.write(l_str CLIPPED)
            END IF
         ELSE
            LET g_hidden[i] = "1"
            LET k = k -1
         END IF
      END FOR
      IF h=1 THEN CALL afat300_get_boday(h,cnt_header,t,combo_arr,l_seq) END IF

   END FOR

   # 使用者的行為模式改到前面判斷，在此僅將前面判斷的結果說明傳至syslog中做紀錄
   IF cl_log_sys_operation("A","G",l_desc) THEN
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
PRIVATE FUNCTION afat300_get_boday(p_h,p_cnt_header,s,s_combo_arr,p_seq)
DEFINE  s,n1_text                          om.DomNode,
         n1                                 om.NodeList,
         i,m,k,cnt_body,res,p               LIKE type_t.num10,
         l_hidden_cnt,n,l_last_hidden       LIKE type_t.num10,
         p_h,p_cnt_header,arr_len           LIKE type_t.num10,
         p_null                             LIKE type_t.num10,
         cells,values,j,l,sheet             STRING,
         l_bufstr                           base.StringBuffer

 DEFINE  s_combo_arr    DYNAMIC ARRAY OF RECORD
          sheet         LIKE type_t.num10,       #sheet
          seq           LIKE type_t.num10,       #項次
          name          LIKE type_t.chr2,        #代號
          text          LIKE type_t.chr50        #說明
                        END RECORD
 DEFINE  p_seq          DYNAMIC ARRAY OF LIKE type_t.num10
 DEFINE  l_item         LIKE type_t.num10

 DEFINE  unix_path      STRING,
         window_path    STRING
 DEFINE  l_dom_doc      om.DomDocument,
         r,n_node       om.DomNode
 DEFINE  l_status       LIKE type_t.num5

   LET l_hidden_cnt = 0
   LET l = p_h
   LET sheet=g_sheet CLIPPED,l
   LET l_bufstr = base.StringBuffer.create()
   LET l = 0
   LET i = 0
   LET m = 0

   CALL l_channel.write("</tr></table></body></html>")
   CALL l_channel.close()
  #CALL cl_prt_convert(xls_name)

   LET unix_path = os.Path.join(FGL_GETENV("TEMPDIR"),xls_name CLIPPED)

  #LET window_path = "c:\\TT\\",xls_name CLIPPED
   LET window_path = g_faah_s.dir,"\\",xls_name CLIPPED
   LET status = cl_client_download_file(unix_path, window_path)
   IF status then
      DISPLAY "Download OK!!"
   ELSE
      DISPLAY "Download fail!!"
   END IF

   LET status = cl_client_open_prog("excel",window_path)
   IF status then
      DISPLAY "Open OK!!"
   ELSE
      DISPLAY "Open fail!!"
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
PRIVATE FUNCTION afat300_add_span(p_str)
DEFINE p_str    STRING
DEFINe l_str    STRING


   LET p_str = p_str.trimRight()

   #若字串有空白就必須加上 <span> 屬性，並將空白轉換為 &nbsp;
   IF p_str.getIndexOf(" ",1) > 0 THEN
      LET g_bufstr = base.StringBuffer.create()              
      CALL g_bufstr.clear()
      CALL g_bufstr.append(p_str)
      CALL g_bufstr.replace(" ","&nbsp;",0)
      CALL g_bufstr.replace("<","&lt;",0)    
      LET l_str = g_bufstr.tostring()
      LET l_str = "<span style='mso-spacerun:yes'>", l_str, "</span>"
   ELSE
      LET g_bufstr = base.StringBuffer.create()
      CALL g_bufstr.clear()
      CALL g_bufstr.append(p_str)
      CALL g_bufstr.replace("<","&lt;",0)
      LET l_str = g_bufstr.tostring()
      #LET l_str = p_str    

   END IF

   RETURN l_str
END FUNCTION

 
{</section>}
 
