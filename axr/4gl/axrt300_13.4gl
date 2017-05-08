#該程式未解開Section, 採用最新樣板產出!
{<section id="axrt300_13.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0012(2016-02-01 11:23:36), PR版次:0012(2016-12-12 17:37:10)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000164
#+ Filename...: axrt300_13
#+ Description: 傳票預覽
#+ Creator....: 01727(2014-03-17 14:38:53)
#+ Modifier...: 02291 -SD/PR- 01531
 
{</section>}
 
{<section id="axrt300_13.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#150429-00010#14   2015/05/09 By Reanna 增加afmt570
#140804-00008#15   2015/05/27 By Reanna 增加afmt565
#140804-00008#9    2015/05/27 By Reanna 增加afmt535
#151001-00005#1    2015/10/08 By yangtt 臨時表afap280_01_fa_group名稱太長，只能為18碼,改成afap280_01_group
#150413-00021#24   2015/12/21 By yangtt 增加afmt145,afmt185,afmt175
#151008-00009#4    2016/01/28 By Jessy  增加axrt470
#                  2016/03/15 By yangtt afmt075,afmt090作业废弃，mark相关逻辑
#160727-00019#2   2016/08/01 By 08742     系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                         Mod   afap280_01_group -->afap280_tmp02
#160727-00019#33   2016/08/10 By 08742     系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 
#                                          Mod   s_afmt145_fm_tmp -->afmt145_tmp01
#                                          Mod   s_axrt920_ar_group -->axrt920_tmp02
#160802-00033#1    2016/08/10 By 01531  当账套没有勾选子系统采用分录底稿功能(glaa121=N)审核时对凭证的检核不完整,需要检核金额是否平衡/科目是否都有/科目的核算项是否都有值且有效
#160727-00019#35   16/08/11 By 08734    临时表长度超过15码的减少到15码以下 s_voucher_ar1_tmp ——> s_vr_tmp02
#160727-00019#33   2016/08/15 By 08742    系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 
#                                          Mod   s_anmt820_nm_tmp--> anmt820_tmp01  ,  s_anmt820_nm_group--> anmt820_tmp02
#                                          Mod   s_anmt821_ar_group--> anmt821_tmp02   ，  s_anmt822_ar_group --> anmt822_tmp02
#160727-00019#36   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_voucher_ar_group ——> s_vr_tmp05
#160727-00019#38   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_voucher_nm_tmp ——> s_vr_tmp06,s_voucher_fm_tmp ——> s_vr_tmp08
#161013-00011#1    16/10/15 By 01531      石狮通达正式区nmt311单号SN311-16100004凭证预览为空,agli010未启用"子模块产生分录底稿“
#161212-00032#1    16/12/12 By 01531      anmt820凭证预览时，现金变动码未显示
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS   #(ver:36) add
   DEFINE mc_data_owner_check LIKE type_t.num5   #(ver:36) add
END GLOBALS   #(ver:36) add
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_glaq_d RECORD
       glaqdocno LIKE glaq_t.glaqdocno, 
   glaqld LIKE glaq_t.glaqld, 
   glaqseq LIKE glaq_t.glaqseq, 
   glaq001 LIKE glaq_t.glaq001, 
   glaq002 LIKE glaq_t.glaq002, 
   glacl004 LIKE type_t.chr500, 
   glaq005 LIKE glaq_t.glaq005, 
   glaq006 LIKE glaq_t.glaq006, 
   glaq010 LIKE glaq_t.glaq010, 
   glaq003 LIKE glaq_t.glaq003, 
   glaq004 LIKE glaq_t.glaq004, 
   glaq040 LIKE type_t.num20_6, 
   glaq041 LIKE type_t.num20_6, 
   glaq043 LIKE type_t.num20_6, 
   glaq044 LIKE type_t.num20_6, 
   seq LIKE type_t.chr500, 
   seq2 LIKE type_t.chr500, 
   state LIKE type_t.chr500
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 type type_g_detail_m        RECORD
        glaq017 LIKE glaq_t.glaq017, 
        glaq017_desc LIKE type_t.chr80, 
        glaq018 LIKE glaq_t.glaq018, 
        glaq018_desc LIKE type_t.chr80, 
        glaq019 LIKE glaq_t.glaq019, 
        glaq019_desc LIKE type_t.chr80, 
        glaq020 LIKE glaq_t.glaq020, 
        glaq020_desc LIKE type_t.chr80, 
        glaq021 LIKE glaq_t.glaq021, 
        glaq021_desc LIKE type_t.chr80, 
        glaq022 LIKE glaq_t.glaq022, 
        glaq022_desc LIKE type_t.chr80, 
        glaq023 LIKE glaq_t.glaq023, 
        glaq023_desc LIKE type_t.chr80, 
        glaq024 LIKE glaq_t.glaq024, 
        glaq024_desc LIKE type_t.chr80, 
        glaq025 LIKE glaq_t.glaq025, 
        glaq025_desc LIKE type_t.chr80, 
        glaq027 LIKE glaq_t.glaq027, 
        glaq027_desc LIKE type_t.chr80, 
        glaq028 LIKE glaq_t.glaq028, 
        glaq028_desc LIKE type_t.chr80,
        glaq051 LIKE glaq_t.glaq051, 
        glaq051_desc LIKE type_t.chr80,
        glaq052 LIKE glaq_t.glaq052, 
        glaq052_desc LIKE type_t.chr80,
        glaq053 LIKE glaq_t.glaq053, 
        glaq053_desc LIKE type_t.chr80,
        glaq029 LIKE glaq_t.glaq029, 
        glaq029_desc LIKE type_t.chr80,
        glaq030 LIKE glaq_t.glaq030, 
        glaq030_desc LIKE type_t.chr80,
        glaq031 LIKE glaq_t.glaq031, 
        glaq031_desc LIKE type_t.chr80,
        glaq032 LIKE glaq_t.glaq032, 
        glaq032_desc LIKE type_t.chr80,
        glaq033 LIKE glaq_t.glaq033, 
        glaq033_desc LIKE type_t.chr80,
        glaq034 LIKE glaq_t.glaq034, 
        glaq034_desc LIKE type_t.chr80,
        glaq035 LIKE glaq_t.glaq035, 
        glaq035_desc LIKE type_t.chr80,
        glaq036 LIKE glaq_t.glaq036, 
        glaq036_desc LIKE type_t.chr80,
        glaq037 LIKE glaq_t.glaq037, 
        glaq037_desc LIKE type_t.chr80,
        glaq038 LIKE glaq_t.glaq038, 
        glaq038_desc LIKE type_t.chr80,
        glbc004 LIKE glbc_t.glbc004,
        glbc004_desc LIKE type_t.chr80
        END RECORD
DEFINE g_detail_m          type_g_detail_m
#end add-point
 
#模組變數(Module Variables)
DEFINE g_glaq_d          DYNAMIC ARRAY OF type_g_glaq_d #單身變數
DEFINE g_glaq_d_t        type_g_glaq_d                  #單身備份
DEFINE g_glaq_d_o        type_g_glaq_d                  #單身備份
DEFINE g_glaq_d_mask_o   DYNAMIC ARRAY OF type_g_glaq_d #單身變數
DEFINE g_glaq_d_mask_n   DYNAMIC ARRAY OF type_g_glaq_d #單身變數
 
      
DEFINE g_wc2                STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_temp_idx           LIKE type_t.num10             #單身 所在筆數(暫存用)
DEFINE g_detail_idx         LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail_cnt         LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_chk                BOOLEAN
DEFINE g_aw                 STRING                        #確定當下點擊的單身
DEFINE g_log1               STRING                        #log用
DEFINE g_log2               STRING                        #log用
 
#多table用wc
DEFINE g_wc_table           STRING
 
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"
DEFINE g_sys            LIKE type_t.chr2 
DEFINE g_xrcadocno      LIKE xrca_t.xrcadocno
DEFINE g_xrcald         LIKE xrca_t.xrcald
DEFINE g_wc             STRING
DEFINE g_type           LIKE type_t.chr10
DEFINE g_glaa005        LIKE glaa_t.glaa005
#重評價參數
GLOBALS
DEFINE g_year           LIKE type_t.num5  #年度 
DEFINE g_month          LIKE type_t.num5  #期別
END GLOBALS
#end add-point
 
{</section>}
 
{<section id="axrt300_13.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION axrt300_13(--)
   #add-point:main段變數傳入 name="main.get_var"
   p_sys,p_ld,p_docno,p_type
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE p_sys       LIKE type_t.chr2 
   DEFINE p_ld        LIKE xrca_t.xrcald
   DEFINE p_docno     LIKE xrca_t.xrcadocno
   DEFINE l_xrca038   LIKE xrca_t.xrca038
   DEFINE p_type      LIKE type_t.chr10
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_slip      LIKE xrca_t.xrcadocno
   DEFINE l_glaa024   LIKE glaa_t.glaa024
   DEFINE l_ooac004   LIKE ooac_t.ooac004
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化 name="main.init"
   LET g_sys       = p_sys
   LET g_xrcadocno = p_docno
   LET g_xrcald    = p_ld
   LET g_type      = p_type
   
   IF g_sys <> 'GL' THEN  #2014/12/8--add
   CALL s_aooi200_get_slip(p_docno)
   RETURNING l_success,l_slip
   END IF  #2014/12/8--add
   SELECT glaa005,glaa024 INTO g_glaa005,l_glaa024
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_ld
   
   #是否抛傳票    
   SELECT ooac004 INTO l_ooac004
     FROM ooac_t
    WHERE ooacent = g_enterprise
      AND ooac001 = l_glaa024
      AND ooac002 = l_slip
      AND ooac003 = 'D-FIN-0030'
      
   IF l_ooac004 = 'N' THEN 
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = l_slip
      LET g_errparam.code   = 'axr-00225' 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN 
   END IF
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
   
   #add-point:main段define_sql name="main.body.define_sql"
   SELECT xrca038 INTO l_xrca038 FROM xrca_t WHERE xrcaent = g_enterprise
     AND xrcadocno = g_xrcadocno AND xrcald = g_xrcald
   IF NOT cl_null(l_xrca038) THEN RETURN END IF
   #end add-point 
   LET g_forupd_sql = "SELECT glaqdocno,glaqld,glaqseq,glaq001,glaq002,glaq005,glaq006,glaq010,glaq003, 
       glaq004,glaq040,glaq041,glaq043,glaq044 FROM glaq_t WHERE glaqent=? AND glaqld=? AND glaqdocno=?  
       AND glaqseq=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrt300_13_bcl CURSOR FROM g_forupd_sql
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_axrt300_13 WITH FORM cl_ap_formpath("axr","axrt300_13")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL axrt300_13_init()   
 
   #進入選單 Menu (="N")
   CALL axrt300_13_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_axrt300_13
 
   
   
 
   #add-point:離開前 name="main.exit"
   LET g_action_choice = ''
   #CALL cl_set_act_visible('insert,delete,query,modify,modify_detail',TRUE)
   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axrt300_13.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axrt300_13_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   #CALL cl_set_act_visible('insert,delete,query,modify,modify_detail',FALSE)
   #end add-point
   
   CALL axrt300_13_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="axrt300_13.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION axrt300_13_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_idx   LIKE type_t.num10
   DEFINE la_param  RECORD #串查用
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()      
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   LET g_detail_idx = 1
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
 
   #end add-point
   
   WHILE TRUE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_glaq_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL axrt300_13_init()
      END IF
   
      CALL axrt300_13_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_glaq_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display  name="ui_dialog.body.before_display"
               
               #end add-point
               #讓各頁籤能夠同步指到特定資料
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2 name="ui_dialog.body.before_display2"
               CALL axrt300_13_b_detail()
               #end add-point
               
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL axrt300_13_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   CALL axrt300_13_b_detail()
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
    
         BEFORE DIALOG
            IF g_temp_idx > 0 THEN
               LET l_ac = g_temp_idx
               CALL DIALOG.setCurrentRow("s_detail1",l_ac)
               LET g_temp_idx = 1
            END IF
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail1", 1)
 
            #add-point:ui_dialog段before name="ui_dialog.b_dialog"
            
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL axrt300_13_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL axrt300_13_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axrt300_13_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
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
               CALL axrt300_13_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_glaq_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
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
            CALL axrt300_13_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axrt300_13_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axrt300_13_set_pk_array()
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
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="axrt300_13.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axrt300_13_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   RETURN
   #end add-point 
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_glaq_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON glaqdocno,glaqld,glaqseq,glaq001,glaq002,glacl004,glaq005,glaq006,glaq010,glaq003, 
          glaq004,glaq040,glaq041,glaq043,glaq044,seq2,state 
 
         FROM s_detail1[1].glaqdocno,s_detail1[1].glaqld,s_detail1[1].glaqseq,s_detail1[1].glaq001,s_detail1[1].glaq002, 
             s_detail1[1].glacl004,s_detail1[1].glaq005,s_detail1[1].glaq006,s_detail1[1].glaq010,s_detail1[1].glaq003, 
             s_detail1[1].glaq004,s_detail1[1].glaq040,s_detail1[1].glaq041,s_detail1[1].glaq043,s_detail1[1].glaq044, 
             s_detail1[1].seq2,s_detail1[1].state 
      
         
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaqdocno
            #add-point:BEFORE FIELD glaqdocno name="query.b.page1.glaqdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaqdocno
            
            #add-point:AFTER FIELD glaqdocno name="query.a.page1.glaqdocno"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaqdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaqdocno
            #add-point:ON ACTION controlp INFIELD glaqdocno name="query.c.page1.glaqdocno"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaqld
            #add-point:BEFORE FIELD glaqld name="query.b.page1.glaqld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaqld
            
            #add-point:AFTER FIELD glaqld name="query.a.page1.glaqld"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaqld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaqld
            #add-point:ON ACTION controlp INFIELD glaqld name="query.c.page1.glaqld"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaqseq
            #add-point:BEFORE FIELD glaqseq name="query.b.page1.glaqseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaqseq
            
            #add-point:AFTER FIELD glaqseq name="query.a.page1.glaqseq"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaqseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaqseq
            #add-point:ON ACTION controlp INFIELD glaqseq name="query.c.page1.glaqseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.glaq001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq001
            #add-point:ON ACTION controlp INFIELD glaq001 name="construct.c.page1.glaq001"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq001
            #add-point:BEFORE FIELD glaq001 name="query.b.page1.glaq001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq001
            
            #add-point:AFTER FIELD glaq001 name="query.a.page1.glaq001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glaq002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq002
            #add-point:ON ACTION controlp INFIELD glaq002 name="construct.c.page1.glaq002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_glac002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq002  #顯示到畫面上
            NEXT FIELD glaq002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq002
            #add-point:BEFORE FIELD glaq002 name="query.b.page1.glaq002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq002
            
            #add-point:AFTER FIELD glaq002 name="query.a.page1.glaq002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glacl004
            #add-point:BEFORE FIELD glacl004 name="query.b.page1.glacl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glacl004
            
            #add-point:AFTER FIELD glacl004 name="query.a.page1.glacl004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glacl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glacl004
            #add-point:ON ACTION controlp INFIELD glacl004 name="query.c.page1.glacl004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.glaq005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq005
            #add-point:ON ACTION controlp INFIELD glaq005 name="construct.c.page1.glaq005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq005  #顯示到畫面上
            NEXT FIELD glaq005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq005
            #add-point:BEFORE FIELD glaq005 name="query.b.page1.glaq005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq005
            
            #add-point:AFTER FIELD glaq005 name="query.a.page1.glaq005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq006
            #add-point:BEFORE FIELD glaq006 name="query.b.page1.glaq006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq006
            
            #add-point:AFTER FIELD glaq006 name="query.a.page1.glaq006"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq006
            #add-point:ON ACTION controlp INFIELD glaq006 name="query.c.page1.glaq006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq010
            #add-point:BEFORE FIELD glaq010 name="query.b.page1.glaq010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq010
            
            #add-point:AFTER FIELD glaq010 name="query.a.page1.glaq010"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq010
            #add-point:ON ACTION controlp INFIELD glaq010 name="query.c.page1.glaq010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq003
            #add-point:BEFORE FIELD glaq003 name="query.b.page1.glaq003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq003
            
            #add-point:AFTER FIELD glaq003 name="query.a.page1.glaq003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq003
            #add-point:ON ACTION controlp INFIELD glaq003 name="query.c.page1.glaq003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq004
            #add-point:BEFORE FIELD glaq004 name="query.b.page1.glaq004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq004
            
            #add-point:AFTER FIELD glaq004 name="query.a.page1.glaq004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq004
            #add-point:ON ACTION controlp INFIELD glaq004 name="query.c.page1.glaq004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq040
            #add-point:BEFORE FIELD glaq040 name="query.b.page1.glaq040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq040
            
            #add-point:AFTER FIELD glaq040 name="query.a.page1.glaq040"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq040
            #add-point:ON ACTION controlp INFIELD glaq040 name="query.c.page1.glaq040"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq041
            #add-point:BEFORE FIELD glaq041 name="query.b.page1.glaq041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq041
            
            #add-point:AFTER FIELD glaq041 name="query.a.page1.glaq041"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq041
            #add-point:ON ACTION controlp INFIELD glaq041 name="query.c.page1.glaq041"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq043
            #add-point:BEFORE FIELD glaq043 name="query.b.page1.glaq043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq043
            
            #add-point:AFTER FIELD glaq043 name="query.a.page1.glaq043"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq043
            #add-point:ON ACTION controlp INFIELD glaq043 name="query.c.page1.glaq043"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq044
            #add-point:BEFORE FIELD glaq044 name="query.b.page1.glaq044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq044
            
            #add-point:AFTER FIELD glaq044 name="query.a.page1.glaq044"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq044
            #add-point:ON ACTION controlp INFIELD glaq044 name="query.c.page1.glaq044"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD seq
            #add-point:BEFORE FIELD seq name="query.b.page1.seq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD seq
            
            #add-point:AFTER FIELD seq name="query.a.page1.seq"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.seq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD seq
            #add-point:ON ACTION controlp INFIELD seq name="query.c.page1.seq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD seq2
            #add-point:BEFORE FIELD seq2 name="query.b.page1.seq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD seq2
            
            #add-point:AFTER FIELD seq2 name="query.a.page1.seq2"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.seq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD seq2
            #add-point:ON ACTION controlp INFIELD seq2 name="query.c.page1.seq2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD state
            #add-point:BEFORE FIELD state name="query.b.page1.state"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD state
            
            #add-point:AFTER FIELD state name="query.a.page1.state"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.state
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD state
            #add-point:ON ACTION controlp INFIELD state name="query.c.page1.state"
            
            #END add-point
 
 
  
         
 
      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point 
      
      END CONSTRUCT
  
      #add-point:query段more_construct name="query.more_construct"
      
      #end add-point 
  
      BEFORE DIALOG 
         CALL cl_qbe_init()
         #add-point:query段before_dialog name="query.before_dialog"
         
         #end add-point 
      
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
      
      ON ACTION qbe_save
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
 
   #add-point:query段after_construct name="query.after_construct"
   
   #end add-point
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      #LET g_wc2 = ls_wc
      LET g_wc2 = " 1=2"
      RETURN
   ELSE
      LET g_error_show = 1
      LET g_detail_idx = 1
   END IF
    
   CALL axrt300_13_b_fill(g_wc2)
 
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   
   LET INT_FLAG = FALSE
   
END FUNCTION
 
{</section>}
 
{<section id="axrt300_13.insert" >}
#+ 資料新增
PRIVATE FUNCTION axrt300_13_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   RETURN
   #end add-point
   
   LET g_insert = 'Y'
   CALL axrt300_13_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrt300_13.modify" >}
#+ 資料修改
PRIVATE FUNCTION axrt300_13_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   DEFINE  l_cmd                  LIKE type_t.chr1
   DEFINE  l_ac_t                 LIKE type_t.num10               #未取消的ARRAY CNT 
   DEFINE  l_n                    LIKE type_t.num10               #檢查重複用  
   DEFINE  l_cnt                  LIKE type_t.num10               #檢查重複用  
   DEFINE  l_lock_sw              LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert         LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete         LIKE type_t.num5                #可刪除否  
   DEFINE  l_count                LIKE type_t.num10
   DEFINE  l_i                    LIKE type_t.num10
   DEFINE  ls_return              STRING
   DEFINE  l_var_keys             DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys           DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                 DYNAMIC ARRAY OF STRING
   DEFINE  l_fields               DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak         DYNAMIC ARRAY OF STRING
   DEFINE  li_reproduce           LIKE type_t.num10
   DEFINE  li_reproduce_target    LIKE type_t.num10
   DEFINE  lb_reproduce           BOOLEAN
   DEFINE  l_insert               BOOLEAN
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
#  LET g_action_choice = ""   #(ver:35) mark
   
   LET g_qryparam.state = "i"
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #add-point:modify開始前 name="modify.define_sql"
   
   #end add-point
   
   LET INT_FLAG = FALSE
   LET lb_reproduce = FALSE
   LET l_insert = FALSE
 
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
 
   #add-point:modify段修改前 name="modify.before_input"
   
   #end add-point
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_glaq_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_glaq_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axrt300_13_b_fill(g_wc2)
            LET g_detail_cnt = g_glaq_d.getLength()
         
         BEFORE ROW
            #add-point:modify段before row name="input.body.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_glaq_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_glaq_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_glaq_d[l_ac].glaqld IS NOT NULL
               AND g_glaq_d[l_ac].glaqdocno IS NOT NULL
               AND g_glaq_d[l_ac].glaqseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_glaq_d_t.* = g_glaq_d[l_ac].*  #BACKUP
               LET g_glaq_d_o.* = g_glaq_d[l_ac].*  #BACKUP
               IF NOT axrt300_13_lock_b("glaq_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axrt300_13_bcl INTO g_glaq_d[l_ac].glaqdocno,g_glaq_d[l_ac].glaqld,g_glaq_d[l_ac].glaqseq, 
                      g_glaq_d[l_ac].glaq001,g_glaq_d[l_ac].glaq002,g_glaq_d[l_ac].glaq005,g_glaq_d[l_ac].glaq006, 
                      g_glaq_d[l_ac].glaq010,g_glaq_d[l_ac].glaq003,g_glaq_d[l_ac].glaq004,g_glaq_d[l_ac].glaq040, 
                      g_glaq_d[l_ac].glaq041,g_glaq_d[l_ac].glaq043,g_glaq_d[l_ac].glaq044
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_glaq_d_t.glaqld,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_glaq_d_mask_o[l_ac].* =  g_glaq_d[l_ac].*
                  CALL axrt300_13_glaq_t_mask()
                  LET g_glaq_d_mask_n[l_ac].* =  g_glaq_d[l_ac].*
                  
                  CALL axrt300_13_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL axrt300_13_set_entry_b(l_cmd)
            CALL axrt300_13_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_glaq_d_t.* TO NULL
            INITIALIZE g_glaq_d_o.* TO NULL
            INITIALIZE g_glaq_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值(單身1)
            
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_glaq_d_t.* = g_glaq_d[l_ac].*     #新輸入資料
            LET g_glaq_d_o.* = g_glaq_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_glaq_d[li_reproduce_target].* = g_glaq_d[li_reproduce].*
 
               LET g_glaq_d[g_glaq_d.getLength()].glaqld = NULL
               LET g_glaq_d[g_glaq_d.getLength()].glaqdocno = NULL
               LET g_glaq_d[g_glaq_d.getLength()].glaqseq = NULL
 
            END IF
            
 
            CALL axrt300_13_set_entry_b(l_cmd)
            CALL axrt300_13_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body.before_insert"
            
            #end add-point  
  
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
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM glaq_t 
             WHERE glaqent = g_enterprise AND glaqld = g_glaq_d[l_ac].glaqld
                                       AND glaqdocno = g_glaq_d[l_ac].glaqdocno
                                       AND glaqseq = g_glaq_d[l_ac].glaqseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glaq_d[g_detail_idx].glaqld
               LET gs_keys[2] = g_glaq_d[g_detail_idx].glaqdocno
               LET gs_keys[3] = g_glaq_d[g_detail_idx].glaqseq
               CALL axrt300_13_insert_b('glaq_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_glaq_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "glaq_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axrt300_13_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (glaqld = '", g_glaq_d[l_ac].glaqld, "' "
                                  ," AND glaqdocno = '", g_glaq_d[l_ac].glaqdocno, "' "
                                  ," AND glaqseq = '", g_glaq_d[l_ac].glaqseq, "' "
 
                                  ,")"
            END IF                
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除ask前 name="input.body.b_delete_ask"
               
               #end add-point   
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point   
               
               DELETE FROM glaq_t
                WHERE glaqent = g_enterprise AND 
                      glaqld = g_glaq_d_t.glaqld
                      AND glaqdocno = g_glaq_d_t.glaqdocno
                      AND glaqseq = g_glaq_d_t.glaqseq
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "glaq_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL axrt300_13_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_glaq_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE axrt300_13_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_glaq_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glaq_d_t.glaqld
               LET gs_keys[2] = g_glaq_d_t.glaqdocno
               LET gs_keys[3] = g_glaq_d_t.glaqseq
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axrt300_13_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL axrt300_13_delete_b('glaq_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_glaq_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaqdocno
            #add-point:BEFORE FIELD glaqdocno name="input.b.page1.glaqdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaqdocno
            
            #add-point:AFTER FIELD glaqdocno name="input.a.page1.glaqdocno"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaqdocno
            #add-point:ON CHANGE glaqdocno name="input.g.page1.glaqdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaqld
            #add-point:BEFORE FIELD glaqld name="input.b.page1.glaqld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaqld
            
            #add-point:AFTER FIELD glaqld name="input.a.page1.glaqld"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaqld
            #add-point:ON CHANGE glaqld name="input.g.page1.glaqld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaqseq
            #add-point:BEFORE FIELD glaqseq name="input.b.page1.glaqseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaqseq
            
            #add-point:AFTER FIELD glaqseq name="input.a.page1.glaqseq"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaqseq
            #add-point:ON CHANGE glaqseq name="input.g.page1.glaqseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq001
            #add-point:BEFORE FIELD glaq001 name="input.b.page1.glaq001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq001
            
            #add-point:AFTER FIELD glaq001 name="input.a.page1.glaq001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq001
            #add-point:ON CHANGE glaq001 name="input.g.page1.glaq001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq002
            #add-point:BEFORE FIELD glaq002 name="input.b.page1.glaq002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq002
            
            #add-point:AFTER FIELD glaq002 name="input.a.page1.glaq002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq002
            #add-point:ON CHANGE glaq002 name="input.g.page1.glaq002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glacl004
            #add-point:BEFORE FIELD glacl004 name="input.b.page1.glacl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glacl004
            
            #add-point:AFTER FIELD glacl004 name="input.a.page1.glacl004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glacl004
            #add-point:ON CHANGE glacl004 name="input.g.page1.glacl004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq005
            #add-point:BEFORE FIELD glaq005 name="input.b.page1.glaq005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq005
            
            #add-point:AFTER FIELD glaq005 name="input.a.page1.glaq005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq005
            #add-point:ON CHANGE glaq005 name="input.g.page1.glaq005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq006
            #add-point:BEFORE FIELD glaq006 name="input.b.page1.glaq006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq006
            
            #add-point:AFTER FIELD glaq006 name="input.a.page1.glaq006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq006
            #add-point:ON CHANGE glaq006 name="input.g.page1.glaq006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq010
            #add-point:BEFORE FIELD glaq010 name="input.b.page1.glaq010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq010
            
            #add-point:AFTER FIELD glaq010 name="input.a.page1.glaq010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq010
            #add-point:ON CHANGE glaq010 name="input.g.page1.glaq010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq003
            #add-point:BEFORE FIELD glaq003 name="input.b.page1.glaq003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq003
            
            #add-point:AFTER FIELD glaq003 name="input.a.page1.glaq003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq003
            #add-point:ON CHANGE glaq003 name="input.g.page1.glaq003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq004
            #add-point:BEFORE FIELD glaq004 name="input.b.page1.glaq004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq004
            
            #add-point:AFTER FIELD glaq004 name="input.a.page1.glaq004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq004
            #add-point:ON CHANGE glaq004 name="input.g.page1.glaq004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq040
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_glaq_d[l_ac].glaq040,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD glaq040
            END IF 
 
 
 
            #add-point:AFTER FIELD glaq040 name="input.a.page1.glaq040"
            IF NOT cl_null(g_glaq_d[l_ac].glaq040) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq040
            #add-point:BEFORE FIELD glaq040 name="input.b.page1.glaq040"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq040
            #add-point:ON CHANGE glaq040 name="input.g.page1.glaq040"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq041
            #add-point:BEFORE FIELD glaq041 name="input.b.page1.glaq041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq041
            
            #add-point:AFTER FIELD glaq041 name="input.a.page1.glaq041"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq041
            #add-point:ON CHANGE glaq041 name="input.g.page1.glaq041"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq043
            #add-point:BEFORE FIELD glaq043 name="input.b.page1.glaq043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq043
            
            #add-point:AFTER FIELD glaq043 name="input.a.page1.glaq043"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq043
            #add-point:ON CHANGE glaq043 name="input.g.page1.glaq043"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq044
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_glaq_d[l_ac].glaq044,"0.000","1","10.000","1","azz-00087",1) THEN 
 
               NEXT FIELD glaq044
            END IF 
 
 
 
            #add-point:AFTER FIELD glaq044 name="input.a.page1.glaq044"
            IF NOT cl_null(g_glaq_d[l_ac].glaq044) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq044
            #add-point:BEFORE FIELD glaq044 name="input.b.page1.glaq044"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq044
            #add-point:ON CHANGE glaq044 name="input.g.page1.glaq044"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD seq
            #add-point:BEFORE FIELD seq name="input.b.page1.seq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD seq
            
            #add-point:AFTER FIELD seq name="input.a.page1.seq"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE seq
            #add-point:ON CHANGE seq name="input.g.page1.seq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD seq2
            #add-point:BEFORE FIELD seq2 name="input.b.page1.seq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD seq2
            
            #add-point:AFTER FIELD seq2 name="input.a.page1.seq2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE seq2
            #add-point:ON CHANGE seq2 name="input.g.page1.seq2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD state
            #add-point:BEFORE FIELD state name="input.b.page1.state"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD state
            
            #add-point:AFTER FIELD state name="input.a.page1.state"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE state
            #add-point:ON CHANGE state name="input.g.page1.state"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.glaqdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaqdocno
            #add-point:ON ACTION controlp INFIELD glaqdocno name="input.c.page1.glaqdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaqld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaqld
            #add-point:ON ACTION controlp INFIELD glaqld name="input.c.page1.glaqld"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaqseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaqseq
            #add-point:ON ACTION controlp INFIELD glaqseq name="input.c.page1.glaqseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq001
            #add-point:ON ACTION controlp INFIELD glaq001 name="input.c.page1.glaq001"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq002
            #add-point:ON ACTION controlp INFIELD glaq002 name="input.c.page1.glaq002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaq_d[l_ac].glaq002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_glac002()                                #呼叫開窗

            LET g_glaq_d[l_ac].glaq002 = g_qryparam.return1              

            DISPLAY g_glaq_d[l_ac].glaq002 TO glaq002              #

            NEXT FIELD glaq002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.glacl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glacl004
            #add-point:ON ACTION controlp INFIELD glacl004 name="input.c.page1.glacl004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq005
            #add-point:ON ACTION controlp INFIELD glaq005 name="input.c.page1.glaq005"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaq_d[l_ac].glaq005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooai001()                                #呼叫開窗

            LET g_glaq_d[l_ac].glaq005 = g_qryparam.return1              

            DISPLAY g_glaq_d[l_ac].glaq005 TO glaq005              #

            NEXT FIELD glaq005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq006
            #add-point:ON ACTION controlp INFIELD glaq006 name="input.c.page1.glaq006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq010
            #add-point:ON ACTION controlp INFIELD glaq010 name="input.c.page1.glaq010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq003
            #add-point:ON ACTION controlp INFIELD glaq003 name="input.c.page1.glaq003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq004
            #add-point:ON ACTION controlp INFIELD glaq004 name="input.c.page1.glaq004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq040
            #add-point:ON ACTION controlp INFIELD glaq040 name="input.c.page1.glaq040"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq041
            #add-point:ON ACTION controlp INFIELD glaq041 name="input.c.page1.glaq041"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq043
            #add-point:ON ACTION controlp INFIELD glaq043 name="input.c.page1.glaq043"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq044
            #add-point:ON ACTION controlp INFIELD glaq044 name="input.c.page1.glaq044"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.seq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD seq
            #add-point:ON ACTION controlp INFIELD seq name="input.c.page1.seq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.seq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD seq2
            #add-point:ON ACTION controlp INFIELD seq2 name="input.c.page1.seq2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.state
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD state
            #add-point:ON ACTION controlp INFIELD state name="input.c.page1.state"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE axrt300_13_bcl
               LET INT_FLAG = 0
               LET g_glaq_d[l_ac].* = g_glaq_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               #add-point:單身取消時 name="input.body.cancel"
               
               #end add-point
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_glaq_d[l_ac].glaqld 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_glaq_d[l_ac].* = g_glaq_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL axrt300_13_glaq_t_mask_restore('restore_mask_o')
 
               UPDATE glaq_t SET (glaqdocno,glaqld,glaqseq,glaq001,glaq002,glaq005,glaq006,glaq010,glaq003, 
                   glaq004,glaq040,glaq041,glaq043,glaq044) = (g_glaq_d[l_ac].glaqdocno,g_glaq_d[l_ac].glaqld, 
                   g_glaq_d[l_ac].glaqseq,g_glaq_d[l_ac].glaq001,g_glaq_d[l_ac].glaq002,g_glaq_d[l_ac].glaq005, 
                   g_glaq_d[l_ac].glaq006,g_glaq_d[l_ac].glaq010,g_glaq_d[l_ac].glaq003,g_glaq_d[l_ac].glaq004, 
                   g_glaq_d[l_ac].glaq040,g_glaq_d[l_ac].glaq041,g_glaq_d[l_ac].glaq043,g_glaq_d[l_ac].glaq044) 
 
                WHERE glaqent = g_enterprise AND
                  glaqld = g_glaq_d_t.glaqld #項次   
                  AND glaqdocno = g_glaq_d_t.glaqdocno  
                  AND glaqseq = g_glaq_d_t.glaqseq  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glaq_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glaq_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glaq_d[g_detail_idx].glaqld
               LET gs_keys_bak[1] = g_glaq_d_t.glaqld
               LET gs_keys[2] = g_glaq_d[g_detail_idx].glaqdocno
               LET gs_keys_bak[2] = g_glaq_d_t.glaqdocno
               LET gs_keys[3] = g_glaq_d[g_detail_idx].glaqseq
               LET gs_keys_bak[3] = g_glaq_d_t.glaqseq
               CALL axrt300_13_update_b('glaq_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_glaq_d_t)
                     LET g_log2 = util.JSON.stringify(g_glaq_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axrt300_13_glaq_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL axrt300_13_unlock_b("glaq_t")
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_glaq_d[l_ac].* = g_glaq_d_t.*
               END IF
               #add-point:單身after row name="input.body.a_close"
               
               #end add-point
            ELSE
            END IF
            #其他table進行unlock
            
             #add-point:單身after row name="input.body.a_row"
            
            #end add-point
            
         AFTER INPUT
            #add-point:單身input後 name="input.body.a_input"
            
            #end add-point
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_glaq_d[li_reproduce_target].* = g_glaq_d[li_reproduce].*
 
               LET g_glaq_d[li_reproduce_target].glaqld = NULL
               LET g_glaq_d[li_reproduce_target].glaqdocno = NULL
               LET g_glaq_d[li_reproduce_target].glaqseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_glaq_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_glaq_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
 
      
      #add-point:before_more_input name="input.more_input"
      
      #end add-point
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()      
         IF g_temp_idx > 0 THEN
            LET l_ac = g_temp_idx
            CALL DIALOG.setCurrentRow("s_detail1",l_ac)
            LET g_temp_idx = 1
         END IF
         #LET g_curr_diag = ui.DIALOG.getCurrent()
         #add-point:before_dialog name="input.before_dialog"
         
         #end add-point
         CASE g_aw
            WHEN "s_detail1"
               NEXT FIELD glaqdocno
 
         END CASE
   
      ON ACTION accept
         ACCEPT DIALOG
      
      ON ACTION cancel
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
    
   #新增後取消
   IF l_cmd = 'a' THEN
      #當取消或無輸入資料按確定時刪除對應資料
      IF INT_FLAG OR cl_null(g_glaq_d[g_detail_idx].glaqld) THEN
         CALL g_glaq_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_glaq_d[g_detail_idx].* = g_glaq_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE axrt300_13_bcl
   
END FUNCTION
 
{</section>}
 
{<section id="axrt300_13.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axrt300_13_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point
   DEFINE li_idx          LIKE type_t.num10
   DEFINE li_ac_t         LIKE type_t.num10
   DEFINE li_detail_tmp   LIKE type_t.num10
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.before_delete"
   RETURN
   #end add-point
   
   CALL s_transaction_begin()
   
   LET li_ac_t = l_ac
   
   LET li_detail_tmp = g_detail_idx
    
   #lock所有所選資料
   FOR li_idx = 1 TO g_glaq_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT axrt300_13_lock_b("glaq_t") THEN
            #已被他人鎖定
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("glaq_t","") THEN
            IF NOT cl_auth_chk_act_permission("delete") THEN
               #有目前權限無法刪除的資料
               RETURN
            END IF
         END IF
         #(ver:35) --- add end ---
      END IF
   END FOR
   
   #add-point:單身刪除詢問前 name="delete.body.b_delete_ask"
   
   #end add-point  
   
   #詢問是否確定刪除所選資料
   IF NOT cl_ask_del_detail() THEN
      RETURN
   END IF
   
   FOR li_idx = 1 TO g_glaq_d.getLength()
      IF g_glaq_d[li_idx].glaqld IS NOT NULL
         AND g_glaq_d[li_idx].glaqdocno IS NOT NULL
         AND g_glaq_d[li_idx].glaqseq IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM glaq_t
          WHERE glaqent = g_enterprise AND 
                glaqld = g_glaq_d[li_idx].glaqld
                AND glaqdocno = g_glaq_d[li_idx].glaqdocno
                AND glaqseq = g_glaq_d[li_idx].glaqseq
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "glaq_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            RETURN
         ELSE
            LET g_detail_cnt = g_detail_cnt-1
            LET l_ac = li_idx
            
 
 
            
 
 
            #add-point:單身同步刪除前(同層table) name="delete.body.a_delete"
            
            #end add-point
            LET g_detail_idx = li_idx
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glaq_d_t.glaqld
               LET gs_keys[2] = g_glaq_d_t.glaqdocno
               LET gs_keys[3] = g_glaq_d_t.glaqseq
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL axrt300_13_delete_b('glaq_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axrt300_13_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove.func"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            
         END IF 
      END IF 
    
   END FOR
   
   LET g_detail_idx = li_detail_tmp
            
   #add-point:單身刪除後 name="delete.after"
   
   #end add-point  
   
   LET l_ac = li_ac_t
   
   #刷新資料
   CALL axrt300_13_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="axrt300_13.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrt300_13_b_fill(p_wc2)              #BODY FILL UP
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2            STRING
   DEFINE ls_owndept_list  STRING  #(ver:35) add
   DEFINE ls_ownuser_list  STRING  #(ver:35) add
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE r_success       LIKE type_t.num5
   DEFINE r_start_no      LIKE glap_t.glapdocno
   DEFINE r_end_no        LIKE glap_t.glapdocno
   DEFINE l_glaa015       LIKE glaa_t.glaa015
   DEFINE l_glaa016       LIKE glaa_t.glaa016
   DEFINE l_glaa019       LIKE glaa_t.glaa019
   DEFINE l_glaa020       LIKE glaa_t.glaa020
   DEFINE l_glaq002       STRING
   DEFINE l_str           STRING 
   DEFINE l_str1          STRING
   DEFINE l_str2          STRING
   DEFINE l_str3          STRING
   DEFINE l_str4          STRING
   DEFINE l_msg1          STRING
   DEFINE l_msg2          STRING
   DEFINE l_msg3          STRING
   DEFINE l_msg4          STRING
   DEFINE l_xrem006       LIKE xrem_t.xrem006
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前 name="b_fill.sql_before"
   IF g_sys = 'NM' OR g_sys = 'FM' THEN   #ANM,AFM 模組跳轉 axrt300_13_b_fill1()處理
      CALL axrt300_13_b_fill1(p_wc2)
      RETURN 
   END IF
   
   IF g_sys = 'FA' THEN   #AFA 模組跳轉 axrt300_13_b_fill2()處理
      CALL axrt300_13_b_fill2(p_wc2)
      RETURN 
   END IF
   
   SELECT glaa015,glaa016,glaa019,glaa020
     INTO l_glaa015,l_glaa016,l_glaa019,l_glaa020
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_xrcald
      
   LET l_str1 = cl_getmsg("axr-00090",g_lang)     #借方金額(
   LET l_str2 = cl_getmsg("axr-00091",g_lang)     #貸方金額(
   LET l_str3 = cl_getmsg("axr-00092",g_lang)     #)(本位幣二)
   LET l_str4 = cl_getmsg("axr-00093",g_lang)     #)(本位幣三)
   
   LET l_msg1 = l_str1 CLIPPED,l_glaa016 CLIPPED,l_str3
   LET l_msg2 = l_str2 CLIPPED,l_glaa016 CLIPPED,l_str3
   LET l_msg3 = l_str1 CLIPPED,l_glaa020 CLIPPED,l_str4
   LET l_msg4 = l_str2 CLIPPED,l_glaa020 CLIPPED,l_str4
      
   IF l_glaa015 = 'Y' THEN 
      CALL cl_set_comp_visible('glaq040,glaq041',TRUE)
      CALL cl_set_comp_att_text('glaq040',l_msg1)
      CALL cl_set_comp_att_text('glaq041',l_msg2)
   ELSE
      CALL cl_set_comp_visible('glaq040,glaq041',FALSE)
   END IF
      
   IF l_glaa019 = 'Y' THEN 
      CALL cl_set_comp_visible('glaq043,glaq044',TRUE)
      CALL cl_set_comp_att_text('glaq043',l_msg3)
      CALL cl_set_comp_att_text('glaq044',l_msg4)
   ELSE
      CALL cl_set_comp_visible('glaq043,glaq044',FALSE)
   END IF
   #2014/12/8--add--str--
   IF g_sys = 'GL' THEN   #AGL 模組跳轉 axrt300_13_b_fill3()處理
      CALL axrt300_13_b_fill3(p_wc2)
      RETURN 
   END IF
   #2014/12/8--add--end
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.glaqdocno,t0.glaqld,t0.glaqseq,t0.glaq001,t0.glaq002,t0.glaq005, 
       t0.glaq006,t0.glaq010,t0.glaq003,t0.glaq004,t0.glaq040,t0.glaq041,t0.glaq043,t0.glaq044  FROM glaq_t t0", 
 
               "",
               
               " WHERE t0.glaqent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
   
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("glaq_t"),
                      " ORDER BY t0.glaqld,t0.glaqdocno,t0.glaqseq"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   CALL s_transaction_begin()

   IF g_sys = 'AR' THEN 
      IF g_type = '1' THEN 
         LET g_wc = "xrcadocno = '",g_xrcadocno,"'"
         CALL s_voucher_gen_ar(1,g_xrcald,'','',1,g_wc,'Y') RETURNING r_success,r_start_no,r_end_no
      END IF
      
      IF g_type = '2' THEN 
         LET g_wc = "xrdadocno = '",g_xrcadocno,"'"
         CALL s_voucher_gen_ar(2,g_xrcald,'','',1,g_wc,'Y') RETURNING r_success,r_start_no,r_end_no
      END IF
      
      #1031 add--str--
      #重評價
      IF g_type = '3' THEN 
         LET g_wc = "xregdocno = '",g_xrcadocno,"'"
         CALL s_axrt920_gen_ar(3,g_xrcald,'','',1,g_wc,'Y') RETURNING r_success,r_start_no,r_end_no
      END IF
      #1131 add--end--     
      #2014/11/02--add--str--
      #帳齡及壞帳提列 axrt940
      IF g_type = '4' THEN 
         LET g_wc = "xrejdocno = '",g_xrcadocno,"'"
         CALL s_axrt940_gen_ar(4,g_xrcald,'','',1,g_wc,'Y') RETURNING r_success,r_start_no,r_end_no
      END IF
      #2014/11/02--add--end--  
      #2014/11/04--add--str--
      #期初暫估沖回axrt930/axrt931
      IF g_type = '5' THEN 
         SELECT xrem006 INTO l_xrem006 FROM xrem_t 
          WHERE xrement=g_enterprise AND xremdocno=g_xrcadocno
         LET g_wc = "xremdocno = '",g_xrcadocno,"'"
         IF l_xrem006 = '1' THEN
            CALL s_axrt940_gen_ar(5,g_xrcald,'','',1,g_wc,'Y') RETURNING r_success,r_start_no,r_end_no
         ELSE
            CALL s_axrt940_gen_ar(6,g_xrcald,'','',1,g_wc,'Y') RETURNING r_success,r_start_no,r_end_no
         END IF
      END IF
      #2014/11/04--add--end--  

      #151008-00009#4 --s add
      #遞延沖轉axrt470
      IF g_type = 'axrt470' THEN 
         LET g_wc = "xrepdocno = '",g_xrcadocno,"'"
         CALL s_voucher_gen_ar1('1',g_xrcald,'','',0,g_wc,'Y','axrt470') RETURNING r_success,r_start_no,r_end_no
      END IF
      #151008-00009#4 --e add
   END IF
   
   IF r_success THEN
      CALL s_transaction_end('Y','Y')
   ELSE
      CALL s_transaction_end('N','Y')  
      RETURN       
   END IF
   
   IF g_sys = 'AR' THEN   
      IF g_type <> '3' THEN
         IF g_type <> 'axrt470' THEN  #151008-00009#4 add
            LET g_sql= " SELECT DISTINCT docno,glaqld,glaqseq,glaq001,glaq002,glaq005,glaq006,sum,d,c,",
                       "                 glaq040,glaq041,glaq043,glaq044 FROM s_vr_tmp05 ",  #160727-00019#36   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_voucher_ar_group ——> s_vr_tmp05
                       "  WHERE glaqent = ?",      #增加此段是为了规避下方的：OPEN b_fill_curs USING g_enterprise
                       "  ORDER BY d DESC"
         #151008-00009#4 --s add
         ELSE
            LET g_sql = " SELECT DISTINCT docno,glaqld,glaqseq,glaq001,glaq002,glaq005,glaq006,glaq010,d,c,",
                        "                 glaq040,glaq041,glaq043,glaq044,seq FROM s_vr_tmp02 ",  #160727-00019#35   16/08/11 By 08734    临时表长度超过15码的减少到15码以下 s_voucher_ar1_tmp ——> s_vr_tmp02
                        " WHERE glaqent = ?",
                        " ORDER BY d desc,c  "
         END IF
         #151008-00009#4 --e add
      ELSE
         LET g_sql= " SELECT DISTINCT docno,glaqld,glaqseq,glaq001,glaq002,glaq005,glaq006,sum,d,c,",
                    "                 glaq040,glaq041,glaq043,glaq044 FROM axrt920_tmp02 ",    #160727-00019#33 Mod   s_axrt920_ar_group -->axrt920_tmp02
                    "  WHERE glaqent = ?",      #增加此段是为了规避下方的：OPEN b_fill_curs USING g_enterprise
                    "  ORDER BY d DESC"   
      END IF
   END IF
   #1102 --add--end--   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"glaq_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axrt300_13_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axrt300_13_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_glaq_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_glaq_d[l_ac].glaqdocno,g_glaq_d[l_ac].glaqld,g_glaq_d[l_ac].glaqseq,g_glaq_d[l_ac].glaq001, 
       g_glaq_d[l_ac].glaq002,g_glaq_d[l_ac].glaq005,g_glaq_d[l_ac].glaq006,g_glaq_d[l_ac].glaq010,g_glaq_d[l_ac].glaq003, 
       g_glaq_d[l_ac].glaq004,g_glaq_d[l_ac].glaq040,g_glaq_d[l_ac].glaq041,g_glaq_d[l_ac].glaq043,g_glaq_d[l_ac].glaq044 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      CALL axrt300_13_glaq002_desc(g_glaq_d[l_ac].glaq002,g_glaq_d[l_ac].glaqseq,g_glaq_d[l_ac].seq2,'','') RETURNING l_glaq002,l_str
      LET g_glaq_d[l_ac].glacl004 = g_glaq_d[l_ac].glaq002,l_str,'\n',l_glaq002
      IF g_glaq_d[l_ac].glaq003 = 0 THEN 
         LET g_glaq_d[l_ac].glaq003 = ''
      END IF
      
      IF g_glaq_d[l_ac].glaq004 = 0 THEN 
         LET g_glaq_d[l_ac].glaq004 = ''
      END IF
      
      IF g_glaq_d[l_ac].glaq040 = 0 THEN 
         LET g_glaq_d[l_ac].glaq040 = ''
      END IF
      
      IF g_glaq_d[l_ac].glaq041 = 0 THEN 
         LET g_glaq_d[l_ac].glaq041 = ''
      END IF
      
      IF g_glaq_d[l_ac].glaq043 = 0 THEN 
         LET g_glaq_d[l_ac].glaq043 = ''
      END IF
      
      IF g_glaq_d[l_ac].glaq044 = 0 THEN 
         LET g_glaq_d[l_ac].glaq044 = ''
      END IF
      #end add-point
      
      CALL axrt300_13_detail_show()      
 
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
 
      LET l_ac = l_ac + 1
      
   END FOREACH
 
   LET g_error_show = 0
   
 
   
   CALL g_glaq_d.deleteElement(g_glaq_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_glaq_d.getLength()
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_glaq_d.getLength() THEN
      LET l_ac = g_glaq_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_glaq_d.getLength()
      LET g_glaq_d_mask_o[l_ac].* =  g_glaq_d[l_ac].*
      CALL axrt300_13_glaq_t_mask()
      LET g_glaq_d_mask_n[l_ac].* =  g_glaq_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
 
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_glaq_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE axrt300_13_pb
   
END FUNCTION
 
{</section>}
 
{<section id="axrt300_13.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axrt300_13_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="detail_show.before"
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
 
   
   #讀入ref值
   #add-point:show段單身reference name="detail_show.reference"
 
   #end add-point
   
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrt300_13.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axrt300_13_set_entry_b(p_cmd)                                                  
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1         
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point
 
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry_b段欄位控制 name="set_entry_b.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_entry_b段control name="set_entry_b.set_entry_b"
   
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                 
 
{</section>}
 
{<section id="axrt300_13.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axrt300_13_set_no_entry_b(p_cmd)                                               
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point   
   DEFINE p_cmd   LIKE type_t.chr1           
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
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
   
   #add-point:set_no_entry_b段control name="set_no_entry_b.set_no_entry_b"
   
   #end add-point       
                                                                                
END FUNCTION
 
{</section>}
 
{<section id="axrt300_13.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axrt300_13_default_search()
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
      LET ls_wc = ls_wc, " glaqld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " glaqdocno = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " glaqseq = '", g_argv[03], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET ls_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_wc2 = ls_wc
   ELSE
      LET g_wc2 = " 1=1"
      #預設查詢條件
      LET g_wc2 = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc2) THEN
         LET g_wc2 = " 1=1"
      END IF
   END IF
 
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="axrt300_13.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axrt300_13_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "glaq_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'glaq_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM glaq_t
          WHERE glaqent = g_enterprise AND
            glaqld = ps_keys_bak[1] AND glaqdocno = ps_keys_bak[2] AND glaqseq = ps_keys_bak[3]
         
         #add-point:delete_b段刪除中 name="delete_b.m_delete"
         
         #end add-point  
            
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = ":",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = FALSE 
            CALL cl_err()
         END IF
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_glaq_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axrt300_13.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axrt300_13_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "glaq_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO glaq_t
                  (glaqent,
                   glaqld,glaqdocno,glaqseq
                   ,glaq001,glaq002,glaq005,glaq006,glaq010,glaq003,glaq004,glaq040,glaq041,glaq043,glaq044) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_glaq_d[l_ac].glaq001,g_glaq_d[l_ac].glaq002,g_glaq_d[l_ac].glaq005,g_glaq_d[l_ac].glaq006, 
                       g_glaq_d[l_ac].glaq010,g_glaq_d[l_ac].glaq003,g_glaq_d[l_ac].glaq004,g_glaq_d[l_ac].glaq040, 
                       g_glaq_d[l_ac].glaq041,g_glaq_d[l_ac].glaq043,g_glaq_d[l_ac].glaq044)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "glaq_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axrt300_13.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axrt300_13_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define(客製用) name="update_b.define_customerization"
   
   #end add-point
   DEFINE ps_page          STRING
   DEFINE ps_table         STRING
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
   
   #比對新舊值, 判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR
   
   #若key無變動, 不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
    
   #若key有變動, 則連動其他table的資料   
   #判斷是否是同一群組的table
   LET ls_group = "glaq_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "glaq_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE glaq_t 
         SET (glaqld,glaqdocno,glaqseq
              ,glaq001,glaq002,glaq005,glaq006,glaq010,glaq003,glaq004,glaq040,glaq041,glaq043,glaq044) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_glaq_d[l_ac].glaq001,g_glaq_d[l_ac].glaq002,g_glaq_d[l_ac].glaq005,g_glaq_d[l_ac].glaq006, 
                  g_glaq_d[l_ac].glaq010,g_glaq_d[l_ac].glaq003,g_glaq_d[l_ac].glaq004,g_glaq_d[l_ac].glaq040, 
                  g_glaq_d[l_ac].glaq041,g_glaq_d[l_ac].glaq043,g_glaq_d[l_ac].glaq044) 
         WHERE glaqent = g_enterprise AND glaqld = ps_keys_bak[1] AND glaqdocno = ps_keys_bak[2] AND glaqseq = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "glaq_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "glaq_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後 name="update_b.a_update"
      
      #end add-point 
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axrt300_13.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axrt300_13_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL axrt300_13_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "glaq_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN axrt300_13_bcl USING g_enterprise,
                                       g_glaq_d[g_detail_idx].glaqld,g_glaq_d[g_detail_idx].glaqdocno, 
                                           g_glaq_d[g_detail_idx].glaqseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axrt300_13_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axrt300_13.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axrt300_13_unlock_b(ps_table)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
   
   LET ls_group = ""
   
   #IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE axrt300_13_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axrt300_13.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION axrt300_13_modify_detail_chk(ps_record)
   #add-point:modify_detail_chk段define(客製用) name="modify_detail_chk.define_customerization"
   
   #end add-point
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify_detail_chk.define"
   
   #end add-point
   
   #add-point:modify_detail_chk段開始前 name="modify_detail_chk.before"
   
   #end add-point
   
   #根據sr名稱確定該page第一個欄位的名稱
   CASE ps_record
      WHEN "s_detail1" 
         LET ls_return = "glaqdocno"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="axrt300_13.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION axrt300_13_show_ownid_msg()
   #add-point:show_ownid_msg段define(客製用) name="show_ownid_msg.define_customerization"
   
   #end add-point
   #add-point:show_ownid_msg段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show_ownid_msg.define"
   
   #end add-point
  
 
   
 
END FUNCTION
#(ver:35) --- add end ---
 
{</section>}
 
{<section id="axrt300_13.mask_functions" >}
&include "erp/axr/axrt300_13_mask.4gl"
 
{</section>}
 
{<section id="axrt300_13.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axrt300_13_set_pk_array()
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
   LET g_pk_array[1].values = g_glaq_d[l_ac].glaqld
   LET g_pk_array[1].column = 'glaqld'
   LET g_pk_array[2].values = g_glaq_d[l_ac].glaqdocno
   LET g_pk_array[2].column = 'glaqdocno'
   LET g_pk_array[3].values = g_glaq_d[l_ac].glaqseq
   LET g_pk_array[3].column = 'glaqseq'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axrt300_13.state_change" >}
   
 
{</section>}
 
{<section id="axrt300_13.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="axrt300_13.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axrt300_13_glaq002_desc(p_glaq002,p_seq,p_seq2,p_state,p_docno)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt300_13_glaq002_desc(p_glaq002,p_seq,p_seq2,p_state,p_docno)
DEFINE p_glaq002           LIKE glaq_t.glaq002   #帳套
DEFINE p_seq               LIKE glaq_t.glaqseq   #項次一
DEFINE p_seq2              LIKE glaq_t.glaqseq   #項次二
DEFINE p_state             LIKE type_t.chr1      #單據狀態
DEFINE p_docno             LIKE type_t.chr20     #單據編號
DEFINE l_glaq002_desc      LIKE glacl_t.glacl004
DEFINE r_glaq002           STRING
DEFINE l_oogf002_desc      LIKE oofa_t.oofa011
DEFINE r_str               STRING
DEFINE l_glaq      RECORD 
         glaq017   LIKE glaq_t.glaq017,
         glaq018   LIKE glaq_t.glaq018,
         glaq019   LIKE glaq_t.glaq019,
         glaq020   LIKE glaq_t.glaq020,
         glaq021   LIKE glaq_t.glaq021,
         glaq022   LIKE glaq_t.glaq022,
         glaq023   LIKE glaq_t.glaq023,
         glaq024   LIKE glaq_t.glaq024,
         glaq025   LIKE glaq_t.glaq025,
         glaq027   LIKE glaq_t.glaq027,
         glaq028   LIKE glaq_t.glaq028,
         glaq051   LIKE glaq_t.glaq051,  #經營方式
         glaq052   LIKE glaq_t.glaq052,  #渠道 
         glaq053   LIKE glaq_t.glaq053   #品牌         
                   END RECORD
   
   INITIALIZE l_glaq.* TO NULL
   IF cl_null(p_glaq002) THEN
      LET r_glaq002 = ''
      LET r_str = ''
      RETURN r_glaq002,r_str       
   END IF
   
   IF g_sys = 'AR' THEN 
      IF g_type = '1' OR g_type = '2' THEN #1102 add
         SELECT glaq017,glaq018,glaq019,glaq020,
                glaq021,glaq022,glaq023,glaq024,
                glaq025,glaq027,glaq028,glaq051,
                glaq052,glaq053
           INTO l_glaq.*
           FROM s_vr_tmp05   #160727-00019#36   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_voucher_ar_group ——> s_vr_tmp05
          WHERE glaqent = g_enterprise
            AND glaq002 = p_glaq002  
            AND docno = g_xrcadocno
            AND glaqseq = p_seq
      END IF
#1102 --add--str--
      IF g_type = '3' THEN  
         SELECT glaq017,glaq018,glaq019,glaq020,
                glaq021,glaq022,glaq023,glaq024,
                glaq025,glaq027,glaq028,glaq051,
                glaq052,glaq053
           INTO l_glaq.*
           FROM axrt920_tmp02        #160727-00019#33 Mod   s_axrt920_ar_group -->axrt920_tmp02
          WHERE glaqent = g_enterprise
            AND glaq002 = p_glaq002  
            AND docno = g_xrcadocno
            AND glaqseq = p_seq
      END IF
#1102 --add--end---
   END IF         


    IF g_sys = 'NM' THEN    #ANM  模組
       IF g_type = '1' THEN
          SELECT glaq017,glaq018,glaq019,glaq020,
                 glaq021,glaq022,glaq023,glaq024,
                 glaq025,glaq027,glaq028,glaq051,
                 glaq052,glaq053
            INTO l_glaq.*
            FROM s_vr_tmp06  #160727-00019#38   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_voucher_nm_tmp ——> s_vr_tmp06
           WHERE glaqent = g_enterprise
             AND glaqld = g_xrcald
             AND docno = g_xrcadocno
             AND seq = p_seq
             AND seq2 = p_seq2
      END IF  
      IF g_type = '2' THEN
          SELECT glaq017,glaq018,glaq019,glaq020,
                glaq021,glaq022,glaq023,glaq024,
                glaq025,glaq027,glaq028,glaq051,
                glaq052,glaq053
           INTO l_glaq.*
           FROM anmt821_tmp02            #160727-00019#33 Mod  s_anmt821_ar_group--> anmt821_tmp02
          WHERE glaqent = g_enterprise
            AND glaq002 = p_glaq002  
            AND docno = g_xrcadocno
            AND glaqseq = p_seq
      END IF  
      IF g_type = '3' THEN
          SELECT glaq017,glaq018,glaq019,glaq020,
                glaq021,glaq022,glaq023,glaq024,
                glaq025,glaq027,glaq028,glaq051,
                glaq052,glaq053
           INTO l_glaq.*
           FROM anmt822_tmp02          #160727-00019#33 Mod  s_anmt822_ar_group --> anmt822_tmp02
          WHERE glaqent = g_enterprise
            AND glaq002 = p_glaq002  
            AND docno = g_xrcadocno
            AND glaqseq = p_seq
      END IF  
      #2015/01/04---add---by qiull
       IF g_type = 'anmt820' THEN
          SELECT glaq017,glaq018,glaq019,glaq020,
                 glaq021,glaq022,glaq023,glaq024,
                 glaq025,glaq027,glaq028
            INTO l_glaq.*
            FROM anmt820_tmp01            #160727-00019#33 Mod  s_anmt820_nm_tmp--> anmt820_tmp01
           WHERE glaqent = g_enterprise
             AND glaqld = g_xrcald
             AND seq = p_seq
       END IF 
       #2015/01/04---add---by qiull
   END IF   
   
   IF g_sys = 'FA' THEN    #AFA  模組,afat509無單據編號
      IF cl_null(g_xrcadocno) THEN
         SELECT glaq017,glaq018,glaq019,glaq020,
                glaq021,glaq022,glaq023,glaq024,
                glaq025,glaq027,glaq028,glaq051,
                glaq052,glaq053
           INTO l_glaq.*
           FROM afat509_faam_tmp
          WHERE glaqent = g_enterprise
            AND glaqld = g_xrcald
      ELSE
         SELECT glaq017,glaq018,glaq019,glaq020,
                glaq021,glaq022,glaq023,glaq024,
                glaq025,glaq027,glaq028,glaq051,
                glaq052,glaq053
           INTO l_glaq.*
          #FROM afap280_01_fa_group  #151001-00005#1
          #FROM afap280_01_group  #151001-00005#1 #160727-00019#2 mark
           FROM afap280_tmp02  #160727-00019#2 Mod   afap280_01_group -->afap280_tmp02
          WHERE glaqent = g_enterprise
            AND glaqld = g_xrcald
            AND docno = g_xrcadocno
            AND seq = p_seq
      END IF
   END IF 
   
#yangtt--2016/03/15--mark--str--
#  IF g_sys = 'FM'  AND g_type = 'afmt075' THEN    #AFM  模組
#      SELECT glaq017,glaq018,glaq019,glaq020,
#             glaq021,glaq022,glaq023,glaq024,
#             glaq025,glaq027,glaq028,glaq051,
#             glaq052,glaq053
#        INTO l_glaq.*
#        FROM s_voucher_fm_tmp
#     WHERE glaqent = g_enterprise
#       AND glaqld = g_xrcald
#       AND docno = g_xrcadocno
#       AND seq = p_seq
#       AND seq2 = p_seq2
#   END IF  

#   IF g_sys = 'FM'  AND g_type = 'afmt090' THEN    #AFM  模組 重評價
#      SELECT glaq017,glaq018,glaq019,glaq020,
#             glaq021,glaq022,glaq023,glaq024,
#             glaq025,glaq027,glaq028,glaq051,
#             glaq052,glaq053
#        INTO l_glaq.*
#        FROM s_voucher_fm_tmp
#     WHERE glaqent = g_enterprise
#       AND glaqld = g_xrcald  #帳套
#       AND year1 = g_year     #年度
#       AND month1 = g_month   #期別 
#       AND docno = p_docno    #單號
#       AND seq = p_seq        #項次一
#       AND seq2 = p_seq2      #項次二
#       
#   END IF  
#yangtt--2016/03/15--mark--end--   
   
   #150413-00021#24---add---str
   IF g_sys = 'FM' AND (g_type = 'afmt145' OR g_type = 'afmt185' OR g_type = 'afmt175') THEN   #AFM 融资到账账务,计提利息账务,偿还本息账务
      SELECT glaq017,glaq018,glaq019,glaq020,
             glaq021,glaq022,glaq023,glaq024,
             glaq025,glaq027,glaq028,glaq051,
             glaq052,glaq053
        INTO l_glaq.*
        FROM afmt145_tmp01           #160727-00019#33 Mod   s_afmt145_fm_tmp -->afmt145_tmp01
     WHERE glaqent = g_enterprise
       AND glaqld = g_xrcald  #帳套
       AND docno = p_docno    #單號
       AND seq = p_seq        #項次一
   END IF
   #150413-00021#24---add---end
   
   #2014/12/8--add--str--
   IF g_sys = 'GL' THEN
      SELECT glaq017,glaq018,glaq019,glaq020,
             glaq021,glaq022,glaq023,glaq024,
             glaq025,glaq027,glaq028,glaq051,
             glaq052,glaq053
        INTO l_glaq.*
        FROM s_vr_tmp05  #160727-00019#36   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_voucher_ar_group ——> s_vr_tmp05
       WHERE glaqent = g_enterprise
         AND glaq002 = p_glaq002  
         AND glaqseq = p_seq
   END IF
   #2014/12/8--add--end
   
   #抓取科目名称
   LET l_glaq002_desc = ''
   SELECT glacl004 INTO l_glaq002_desc FROM glacl_t,glaa_t
    WHERE glaaent = glaclent 
      AND glaa004 = glacl001
      AND glaclent = g_enterprise
      AND glaald = g_xrcald
      AND glacl002 = p_glaq002
      AND glacl003 = g_dlang  


   #组合名称以及核算项
   LET r_glaq002 = ''
   LET r_str = ''
   #營運據點
   #IF NOT cl_null(l_glaq.glaq017) THEN
   #   INITIALIZE g_ref_fields TO NULL
   #   LET g_ref_fields[1] = l_glaq.glaq017
   #   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   #   LET r_glaq002 = g_rtn_fields[1]     
   #   LET r_str = l_glaq.glaq017  
   #END IF
   #部门
   IF NOT cl_null(l_glaq.glaq018) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glaq.glaq018
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_rtn_fields[1]
      ELSE
         LET r_glaq002 = g_rtn_fields[1]
      END IF 
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_glaq.glaq018
      ELSE
         LET r_str=l_glaq.glaq018
      END IF   
   END IF 
   #成本利润中心
   IF NOT cl_null(l_glaq.glaq019) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glaq.glaq019
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_rtn_fields[1]
      ELSE
         LET r_glaq002 = g_rtn_fields[1]
      END IF   
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_glaq.glaq019
      ELSE
         LET r_str=l_glaq.glaq019
      END IF      
   END IF 
   
   #区域
   IF NOT cl_null(l_glaq.glaq020) THEN 
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = '287'
      LET g_ref_fields[2] = l_glaq.glaq020
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields  
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_rtn_fields[1]
      ELSE
         LET r_glaq002 = g_rtn_fields[1]
      END IF   
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_glaq.glaq020
      ELSE
         LET r_str=l_glaq.glaq020
      END IF       
   END IF 
   #交易客商
   IF NOT cl_null(l_glaq.glaq021) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glaq.glaq021
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_rtn_fields[1] 
      ELSE
         LET r_glaq002 = g_rtn_fields[1] 
      END IF    
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_glaq.glaq021
      ELSE
         LET r_str=l_glaq.glaq021
      END IF       
   END IF 
   #帐款客商
   IF NOT cl_null(l_glaq.glaq022) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glaq.glaq022
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_rtn_fields[1]
      ELSE
         LET r_glaq002 = g_rtn_fields[1]
      END IF     
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_glaq.glaq022
      ELSE
         LET r_str=l_glaq.glaq022
      END IF        
   END IF 
   #客群
   IF NOT cl_null(l_glaq.glaq023) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = '281'
      LET g_ref_fields[2] = l_glaq.glaq023
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_rtn_fields[1]
      ELSE
         LET r_glaq002 = g_rtn_fields[1]
      END IF  
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_glaq.glaq023
      ELSE
         LET r_str=l_glaq.glaq023
      END IF        
   END IF 
   
   #产品分类
   IF NOT cl_null(l_glaq.glaq024) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glaq.glaq024
      CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_rtn_fields[1]
      ELSE
         LET r_glaq002 = g_rtn_fields[1]
      END IF 
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_glaq.glaq024
      ELSE
         LET r_str=l_glaq.glaq024
      END IF        
   END IF 
   #人员
   IF NOT cl_null(l_glaq.glaq025) THEN
      LET  l_oogf002_desc = ''
      SELECT oofa011 INTO l_oogf002_desc FROM oofa_t
       WHERE oofaent = g_enterprise
         AND oofa001 IN (SELECT ooag002 FROM ooag_t
                          WHERE ooagent = g_enterprise
                            AND ooag001 = l_glaq.glaq025)
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_oogf002_desc
      ELSE
         LET r_glaq002 = l_oogf002_desc
      END IF     
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_glaq.glaq025
      ELSE
         LET r_str=l_glaq.glaq025
      END IF       
   END IF 

   #专案编号
   IF NOT cl_null(l_glaq.glaq027) THEN
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_glaq.glaq027
      ELSE
         LET r_glaq002 = l_glaq.glaq027
      END IF   
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_glaq.glaq027
      ELSE
         LET r_str=l_glaq.glaq027
      END IF          
   END IF 
   #WBS
   IF NOT cl_null(l_glaq.glaq028) THEN
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_glaq.glaq028
      ELSE
         LET r_glaq002 = l_glaq.glaq028
      END IF   
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_glaq.glaq028
      ELSE
         LET r_str=l_glaq.glaq028
      END IF       
   END IF 
   #經營方式
   IF NOT cl_null(l_glaq.glaq051) THEN
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_glaq.glaq051
      ELSE
         LET r_glaq002 = l_glaq.glaq051
      END IF   
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_glaq.glaq051
      ELSE
         LET r_str=l_glaq.glaq051
      END IF       
   END IF 
   #渠道
   IF NOT cl_null(l_glaq.glaq052) THEN
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_glaq.glaq052
      ELSE
         LET r_glaq002 = l_glaq.glaq052
      END IF   
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_glaq.glaq052
      ELSE
         LET r_str=l_glaq.glaq052
      END IF       
   END IF 
   #品牌
   IF NOT cl_null(l_glaq.glaq053) THEN
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_glaq.glaq053
      ELSE
         LET r_glaq002 = l_glaq.glaq053
      END IF   
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_glaq.glaq053
      ELSE
         LET r_str=l_glaq.glaq053
      END IF       
   END IF
   
   #组合科目名称以及核算项
   LET r_glaq002 = l_glaq002_desc,'\n',
                   r_glaq002
   IF NOT cl_null(r_str) THEN
      LET r_str="(",r_str,")"
   END IF  
   RETURN r_glaq002,r_str 
END FUNCTION
# 點擊單身資料顯示其固定核算項信息
PRIVATE FUNCTION axrt300_13_b_detail()
 

   INITIALIZE g_detail_m.* LIKE glaq_t.* 
   
   
   IF g_sys = 'AR' THEN  #AXR模組
      IF g_type = '1' OR g_type = '2' THEN #1102 add
         SELECT glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,
                glaq024,glaq025,glaq027,glaq028,glaq051,glaq052,glaq053,
                glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,
                glaq036,glaq037,glaq038,glbc004
           INTO g_detail_m.glaq017,g_detail_m.glaq018,g_detail_m.glaq019,g_detail_m.glaq020,g_detail_m.glaq021,
                g_detail_m.glaq022,g_detail_m.glaq023,g_detail_m.glaq024,g_detail_m.glaq025,g_detail_m.glaq027,
                g_detail_m.glaq028,g_detail_m.glaq051,g_detail_m.glaq052,g_detail_m.glaq053,g_detail_m.glaq029,
                g_detail_m.glaq030,g_detail_m.glaq031,g_detail_m.glaq032,g_detail_m.glaq033,g_detail_m.glaq034,
                g_detail_m.glaq035,g_detail_m.glaq036,g_detail_m.glaq037,g_detail_m.glaq038,g_detail_m.glbc004          
           FROM s_vr_tmp05  #160727-00019#36   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_voucher_ar_group ——> s_vr_tmp05
          WHERE glaqent = g_enterprise
            AND docno = g_xrcadocno
            AND glaq002 = g_glaq_d[g_detail_idx].glaq002
            AND glaqseq = g_glaq_d[g_detail_idx].glaqseq
      END IF
      #1102 add--str--
      IF g_type = '3' THEN  
         SELECT glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,
                glaq024,glaq025,glaq027,glaq028,glaq051,glaq052,glaq053,
                glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,
                glaq036,glaq037,glaq038,''
           INTO g_detail_m.glaq017,g_detail_m.glaq018,g_detail_m.glaq019,g_detail_m.glaq020,g_detail_m.glaq021,
                g_detail_m.glaq022,g_detail_m.glaq023,g_detail_m.glaq024,g_detail_m.glaq025,g_detail_m.glaq027,
                g_detail_m.glaq028,g_detail_m.glaq051,g_detail_m.glaq052,g_detail_m.glaq053,g_detail_m.glaq029,
                g_detail_m.glaq030,g_detail_m.glaq031,g_detail_m.glaq032,g_detail_m.glaq033,g_detail_m.glaq034,
                g_detail_m.glaq035,g_detail_m.glaq036,g_detail_m.glaq037,g_detail_m.glaq038,g_detail_m.glbc004   
           FROM axrt920_tmp02        #160727-00019#33 Mod   s_axrt920_ar_group -->axrt920_tmp02
          WHERE glaqent = g_enterprise
            AND docno = g_xrcadocno
            AND glaq002 = g_glaq_d[g_detail_idx].glaq002
            AND glaqseq = g_glaq_d[g_detail_idx].glaqseq
      END IF      
      #1102 add--end--
      
      #151008-00009#4 --s add
      IF g_type = 'axrt470' THEN  
         SELECT glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,
                glaq024,glaq025,glaq027,glaq028,glaq051,glaq052,glaq053,
                glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,
                glaq036,glaq037,glaq038,''
           INTO g_detail_m.glaq017,g_detail_m.glaq018,g_detail_m.glaq019,g_detail_m.glaq020,g_detail_m.glaq021,
                g_detail_m.glaq022,g_detail_m.glaq023,g_detail_m.glaq024,g_detail_m.glaq025,g_detail_m.glaq027,
                g_detail_m.glaq028,g_detail_m.glaq051,g_detail_m.glaq052,g_detail_m.glaq053,g_detail_m.glaq029,
                g_detail_m.glaq030,g_detail_m.glaq031,g_detail_m.glaq032,g_detail_m.glaq033,g_detail_m.glaq034,
                g_detail_m.glaq035,g_detail_m.glaq036,g_detail_m.glaq037,g_detail_m.glaq038,g_detail_m.glbc004          
            FROM s_vr_tmp02  #160727-00019#35   16/08/11 By 08734    临时表长度超过15码的减少到15码以下 s_voucher_ar1_tmp ——> s_vr_tmp02
           WHERE glaqent = g_enterprise
             AND glaqld = g_xrcald
             AND docno = g_xrcadocno
             AND seq = g_glaq_d[g_detail_idx].seq
      END IF  
      #151008-00009#4 --e add
   END IF
   
   IF g_sys = 'NM' THEN   #ANM 模組
      IF g_type = '1' THEN
         SELECT glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,
                glaq024,glaq025,glaq027,glaq028,glaq051,glaq052,glaq053,
                glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,
                glaq036,glaq037,glaq038,''      
                
           INTO g_detail_m.glaq017,g_detail_m.glaq018,g_detail_m.glaq019,g_detail_m.glaq020,g_detail_m.glaq021,
                g_detail_m.glaq022,g_detail_m.glaq023,g_detail_m.glaq024,g_detail_m.glaq025,g_detail_m.glaq027,
                g_detail_m.glaq028,g_detail_m.glaq051,g_detail_m.glaq052,g_detail_m.glaq053,g_detail_m.glaq029,
                g_detail_m.glaq030,g_detail_m.glaq031,g_detail_m.glaq032,g_detail_m.glaq033,g_detail_m.glaq034,
                g_detail_m.glaq035,g_detail_m.glaq036,g_detail_m.glaq037,g_detail_m.glaq038,g_detail_m.glbc004          
#160802-00033#1 mod s---            
#            FROM s_voucher_nm_tmp   
#           WHERE glaqent = g_enterprise
#             AND glaqld = g_xrcald
#             AND docno = g_xrcadocno
#             AND seq = g_glaq_d[g_detail_idx].seq
#             AND seq2 = g_glaq_d[g_detail_idx].seq2 
           #FROM s_voucher_nm_group  #161013-00011#1 mark
           FROM s_vr_tmp07 #161013-00011#1 add
          WHERE glaqent = g_enterprise
            AND docno = g_xrcadocno
            AND glaq002 = g_glaq_d[g_detail_idx].glaq002
            AND glaqseq = g_glaq_d[g_detail_idx].glaqseq
#160802-00033#1 mod s---              
      END IF  
      IF g_type = '2' THEN  
         SELECT glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,
                glaq024,glaq025,glaq027,glaq028,glaq051,glaq052,glaq053,
                glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,
                glaq036,glaq037,glaq038,''
           INTO g_detail_m.glaq017,g_detail_m.glaq018,g_detail_m.glaq019,g_detail_m.glaq020,g_detail_m.glaq021,
                g_detail_m.glaq022,g_detail_m.glaq023,g_detail_m.glaq024,g_detail_m.glaq025,g_detail_m.glaq027,
                g_detail_m.glaq028,g_detail_m.glaq051,g_detail_m.glaq052,g_detail_m.glaq053,g_detail_m.glaq029,
                g_detail_m.glaq030,g_detail_m.glaq031,g_detail_m.glaq032,g_detail_m.glaq033,g_detail_m.glaq034,
                g_detail_m.glaq035,g_detail_m.glaq036,g_detail_m.glaq037,g_detail_m.glaq038,g_detail_m.glbc004          
           FROM anmt821_tmp02          #160727-00019#33 Mod  s_anmt821_ar_group--> anmt821_tmp02
          WHERE glaqent = g_enterprise
            AND docno = g_xrcadocno
            AND glaq002 = g_glaq_d[g_detail_idx].glaq002
            AND glaqseq = g_glaq_d[g_detail_idx].glaqseq
      END IF       
      IF g_type = '3' THEN  
         SELECT glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,
                glaq024,glaq025,glaq027,glaq028,glaq051,glaq052,glaq053,
                glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,
                glaq036,glaq037,glaq038,''
           INTO g_detail_m.glaq017,g_detail_m.glaq018,g_detail_m.glaq019,g_detail_m.glaq020,g_detail_m.glaq021,
                g_detail_m.glaq022,g_detail_m.glaq023,g_detail_m.glaq024,g_detail_m.glaq025,g_detail_m.glaq027,
                g_detail_m.glaq028,g_detail_m.glaq051,g_detail_m.glaq052,g_detail_m.glaq053,g_detail_m.glaq029,
                g_detail_m.glaq030,g_detail_m.glaq031,g_detail_m.glaq032,g_detail_m.glaq033,g_detail_m.glaq034,
                g_detail_m.glaq035,g_detail_m.glaq036,g_detail_m.glaq037,g_detail_m.glaq038,g_detail_m.glbc004          
           FROM anmt822_tmp02          #160727-00019#33 Mod  s_anmt822_ar_group --> anmt822_tmp02
          WHERE glaqent = g_enterprise
            AND docno = g_xrcadocno
            AND glaq002 = g_glaq_d[g_detail_idx].glaq002
            AND glaqseq = g_glaq_d[g_detail_idx].glaqseq
      END IF  
      #2015/01/04---add---by qiull
      IF g_type = 'anmt820' THEN
         SELECT glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,
                glaq024,glaq025,glaq027,glaq028,glaq051,glaq052,glaq053,glaq029,glaq030,glaq031,  #161212-00032#1 add glaq051,glaq052,glaq053
                #glaq032,glaq033,glaq034,glaq035,glaq036,glaq037,glaq038,''      #161212-00032#1 mark
                glaq032,glaq033,glaq034,glaq035,glaq036,glaq037,glaq038,glgb055 #161212-00032#1 add
           INTO g_detail_m.glaq017,g_detail_m.glaq018,g_detail_m.glaq019,g_detail_m.glaq020,g_detail_m.glaq021,
                g_detail_m.glaq022,g_detail_m.glaq023,g_detail_m.glaq024,g_detail_m.glaq025,g_detail_m.glaq027,
                g_detail_m.glaq028,g_detail_m.glaq051,g_detail_m.glaq052,g_detail_m.glaq053,g_detail_m.glaq029,
                g_detail_m.glaq030,g_detail_m.glaq031,g_detail_m.glaq032,g_detail_m.glaq033,g_detail_m.glaq034,
                g_detail_m.glaq035,g_detail_m.glaq036,g_detail_m.glaq037,g_detail_m.glaq038,g_detail_m.glbc004          
            FROM anmt820_tmp01           #160727-00019#33 Mod  s_anmt820_nm_tmp--> anmt820_tmp01
           WHERE glaqent = g_enterprise
             AND glaqld = g_xrcald
             AND seq = g_glaq_d[g_detail_idx].seq
      END IF 
      #2015/01/04---add---by qiull       
   END IF
      
#yangtt--2016/03/15--mark--str--
#   IF g_sys = 'FM' AND g_type = 'afmt075' THEN   #AFM 模組
#      SELECT glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,
#             glaq024,glaq025,glaq027,glaq028,glaq051,glaq052,glaq053,
#             glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,
#             glaq036,glaq037,glaq038,''
#        INTO g_detail_m.glaq017,g_detail_m.glaq018,g_detail_m.glaq019,g_detail_m.glaq020,g_detail_m.glaq021,
#             g_detail_m.glaq022,g_detail_m.glaq023,g_detail_m.glaq024,g_detail_m.glaq025,g_detail_m.glaq027,
#             g_detail_m.glaq028,g_detail_m.glaq051,g_detail_m.glaq052,g_detail_m.glaq053,g_detail_m.glaq029,
#             g_detail_m.glaq030,g_detail_m.glaq031,g_detail_m.glaq032,g_detail_m.glaq033,g_detail_m.glaq034,
#             g_detail_m.glaq035,g_detail_m.glaq036,g_detail_m.glaq037,g_detail_m.glaq038,g_detail_m.glbc004          
#         FROM s_voucher_fm_tmp
#    WHERE glaqent = g_enterprise
#       AND glaqld = g_xrcald
#       AND docno = g_xrcadocno
#       AND seq = g_glaq_d[g_detail_idx].seq
#       AND seq2 = g_glaq_d[g_detail_idx].seq2 
#   END IF

#   IF g_sys = 'FM' AND g_type = 'afmt090' THEN   #AFM 重評價
#      SELECT glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,
#             glaq024,glaq025,glaq027,glaq028,glaq051,glaq052,glaq053,
#             glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,
#             glaq036,glaq037,glaq038,''
#        INTO g_detail_m.glaq017,g_detail_m.glaq018,g_detail_m.glaq019,g_detail_m.glaq020,g_detail_m.glaq021,
#             g_detail_m.glaq022,g_detail_m.glaq023,g_detail_m.glaq024,g_detail_m.glaq025,g_detail_m.glaq027,
#             g_detail_m.glaq028,g_detail_m.glaq051,g_detail_m.glaq052,g_detail_m.glaq053,g_detail_m.glaq029,
#             g_detail_m.glaq030,g_detail_m.glaq031,g_detail_m.glaq032,g_detail_m.glaq033,g_detail_m.glaq034,
#             g_detail_m.glaq035,g_detail_m.glaq036,g_detail_m.glaq037,g_detail_m.glaq038,g_detail_m.glbc004          
#         FROM s_voucher_fm_tmp
#    WHERE glaqent = g_enterprise
#       AND glaqld = g_xrcald
#       AND docno = g_glaq_d[g_detail_idx].glaqdocno
#       AND year1 = g_year
#       AND month1 = g_month
#       AND state = g_glaq_d[g_detail_idx].state
#       AND seq = g_glaq_d[g_detail_idx].seq
#       AND seq2 = g_glaq_d[g_detail_idx].seq2 
#       
#   END IF
   #yangtt--2016/03/15--mark--end--
   
   #150429-00010#14 add ------
   IF g_sys = 'FM' THEN   #AFM 模組
      SELECT glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,
             glaq024,glaq025,glaq027,glaq028,glaq051,glaq052,glaq053,
             glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,
             glaq036,glaq037,glaq038,''
        INTO g_detail_m.glaq017,g_detail_m.glaq018,g_detail_m.glaq019,g_detail_m.glaq020,g_detail_m.glaq021,
             g_detail_m.glaq022,g_detail_m.glaq023,g_detail_m.glaq024,g_detail_m.glaq025,g_detail_m.glaq027,
             g_detail_m.glaq028,g_detail_m.glaq051,g_detail_m.glaq052,g_detail_m.glaq053,g_detail_m.glaq029,
             g_detail_m.glaq030,g_detail_m.glaq031,g_detail_m.glaq032,g_detail_m.glaq033,g_detail_m.glaq034,
             g_detail_m.glaq035,g_detail_m.glaq036,g_detail_m.glaq037,g_detail_m.glaq038,g_detail_m.glbc004          
         FROM s_vr_tmp08  #160727-00019#38   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_voucher_fm_tmp ——> s_vr_tmp08
    WHERE glaqent = g_enterprise
       AND glaqld = g_xrcald
       AND docno = g_xrcadocno
       AND seq = g_glaq_d[g_detail_idx].seq
   END IF
   #150429-00010#14 add end---
   
   #150413-00021#24---add---str
   IF g_sys = 'FM' AND (g_type = 'afmt145' OR g_type = 'afmt185' OR g_type = 'afmt175') THEN   #AFM 融资到账账务,计提利息账务,偿还本息账务
      SELECT glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,
             glaq024,glaq025,glaq027,glaq028,glaq051,glaq052,glaq053,
             glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,
             glaq036,glaq037,glaq038,''
        INTO g_detail_m.glaq017,g_detail_m.glaq018,g_detail_m.glaq019,g_detail_m.glaq020,g_detail_m.glaq021,
             g_detail_m.glaq022,g_detail_m.glaq023,g_detail_m.glaq024,g_detail_m.glaq025,g_detail_m.glaq027,
             g_detail_m.glaq028,g_detail_m.glaq051,g_detail_m.glaq052,g_detail_m.glaq053,g_detail_m.glaq029,
             g_detail_m.glaq030,g_detail_m.glaq031,g_detail_m.glaq032,g_detail_m.glaq033,g_detail_m.glaq034,
             g_detail_m.glaq035,g_detail_m.glaq036,g_detail_m.glaq037,g_detail_m.glaq038,g_detail_m.glbc004          
         FROM afmt145_tmp01           #160727-00019#33 Mod   s_afmt145_fm_tmp -->afmt145_tmp01
    WHERE glaqent = g_enterprise
       AND glaqld = g_xrcald
       AND docno = g_xrcadocno
       AND seq = g_glaq_d[g_detail_idx].seq
   END IF
   #150413-00021#24---add---end
   
   IF g_sys = 'FA' THEN  #AFA模組,afat509 無單據編號
      IF cl_null(g_xrcadocno) THEN
         SELECT glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,
                glaq024,glaq025,glaq027,glaq028,glaq051,glaq052,glaq053,
                glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,
                glaq036,glaq037,glaq038,''
           INTO g_detail_m.glaq017,g_detail_m.glaq018,g_detail_m.glaq019,g_detail_m.glaq020,g_detail_m.glaq021,
                g_detail_m.glaq022,g_detail_m.glaq023,g_detail_m.glaq024,g_detail_m.glaq025,g_detail_m.glaq027,
                g_detail_m.glaq028,g_detail_m.glaq051,g_detail_m.glaq052,g_detail_m.glaq053,g_detail_m.glaq029,
                g_detail_m.glaq030,g_detail_m.glaq031,g_detail_m.glaq032,g_detail_m.glaq033,g_detail_m.glaq034,
                g_detail_m.glaq035,g_detail_m.glaq036,g_detail_m.glaq037,g_detail_m.glaq038,g_detail_m.glbc004          
           FROM afat509_faam_tmp
          WHERE glaqent = g_enterprise
            AND glaq002 = g_glaq_d[g_detail_idx].glaq002
        ELSE
            SELECT glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,
                glaq024,glaq025,glaq027,glaq028,glaq051,glaq052,glaq053,
                glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,
                glaq036,glaq037,glaq038,''
           INTO g_detail_m.glaq017,g_detail_m.glaq018,g_detail_m.glaq019,g_detail_m.glaq020,g_detail_m.glaq021,
                g_detail_m.glaq022,g_detail_m.glaq023,g_detail_m.glaq024,g_detail_m.glaq025,g_detail_m.glaq027,
                g_detail_m.glaq028,g_detail_m.glaq051,g_detail_m.glaq052,g_detail_m.glaq053,g_detail_m.glaq029,
                g_detail_m.glaq030,g_detail_m.glaq031,g_detail_m.glaq032,g_detail_m.glaq033,g_detail_m.glaq034,
                g_detail_m.glaq035,g_detail_m.glaq036,g_detail_m.glaq037,g_detail_m.glaq038,g_detail_m.glbc004          
          #FROM afap280_01_fa_group   #151001-00005#1
          #FROM afap280_01_group   #151001-00005#1  #160727-00019#2 mark
           FROM afap280_tmp02  #160727-00019#2 Mod   afap280_01_group -->afap280_tmp02
          WHERE glaqent = g_enterprise
            AND glaq002 = g_glaq_d[g_detail_idx].glaq002
            AND docno = g_xrcadocno
            AND seq = g_glaq_d[g_detail_idx].seq
      END IF
   END IF   
   #2014/12/26--add--str--
   IF g_sys = 'GL' THEN #总账，aglt420
      SELECT glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,
             glaq024,glaq025,glaq027,glaq028,glaq051,glaq052,glaq053,
             glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,
             glaq036,glaq037,glaq038,''
        INTO g_detail_m.glaq017,g_detail_m.glaq018,g_detail_m.glaq019,g_detail_m.glaq020,g_detail_m.glaq021,
             g_detail_m.glaq022,g_detail_m.glaq023,g_detail_m.glaq024,g_detail_m.glaq025,g_detail_m.glaq027,
             g_detail_m.glaq028,g_detail_m.glaq051,g_detail_m.glaq052,g_detail_m.glaq053,g_detail_m.glaq029,
             g_detail_m.glaq030,g_detail_m.glaq031,g_detail_m.glaq032,g_detail_m.glaq033,g_detail_m.glaq034,
             g_detail_m.glaq035,g_detail_m.glaq036,g_detail_m.glaq037,g_detail_m.glaq038,g_detail_m.glbc004          
        FROM s_vr_tmp05   #160727-00019#36   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_voucher_ar_group ——> s_vr_tmp05
       WHERE glaqent = g_enterprise
         AND glaq002 = g_glaq_d[g_detail_idx].glaq002
         AND glaqseq = g_glaq_d[g_detail_idx].glaqseq
   END IF
   #2014/12/26--add--end
   CALL axrt300_13_detail_desc()   
   CALL axrt300_13_free_account_desc()
      
   DISPLAY BY NAME 
           g_detail_m.glaq017,g_detail_m.glaq018,g_detail_m.glaq019,g_detail_m.glaq020,g_detail_m.glaq021,
           g_detail_m.glaq022,g_detail_m.glaq023,g_detail_m.glaq024,g_detail_m.glaq025,g_detail_m.glaq027,
           g_detail_m.glaq028,g_detail_m.glaq051,g_detail_m.glaq052,g_detail_m.glaq053,g_detail_m.glaq029,
           g_detail_m.glaq030,g_detail_m.glaq031,g_detail_m.glaq032,g_detail_m.glaq033,g_detail_m.glaq034,
           g_detail_m.glaq035,g_detail_m.glaq036,g_detail_m.glaq037,g_detail_m.glaq038,g_detail_m.glbc004
END FUNCTION
# 固定核算項說明
PRIVATE FUNCTION axrt300_13_detail_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_m.glaq017
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_detail_m.glaq017_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_detail_m.glaq017_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_m.glaq018
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_detail_m.glaq018_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_detail_m.glaq018_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_m.glaq019
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_detail_m.glaq019_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_detail_m.glaq019_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_m.glaq020
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='287' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_detail_m.glaq020_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_detail_m.glaq020_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_m.glaq021
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_detail_m.glaq021_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_detail_m.glaq021_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_m.glaq022
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_detail_m.glaq022_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_detail_m.glaq022_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_m.glaq023
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='281' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_detail_m.glaq023_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_detail_m.glaq023_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_m.glaq024
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_detail_m.glaq024_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_detail_m.glaq024_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_m.glaq025
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_detail_m.glaq025_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_detail_m.glaq025_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_m.glaq027
   CALL ap_ref_array2(g_ref_fields,"SELECT pjbal003 FROM pjbal_t WHERE pjbalent='"||g_enterprise||"' AND pjbal001=? AND pjbal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_detail_m.glaq027_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_detail_m.glaq027_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_m.glaq027
   LET g_ref_fields[2] = g_detail_m.glaq028
   CALL ap_ref_array2(g_ref_fields,"SELECT pjbbl004 FROM pjbbl_t WHERE pjbblent='"||g_enterprise||"' AND pjbbl001=? AND pjbbl002=? AND pjbbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_detail_m.glaq028_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_detail_m.glaq028_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = '6013'
   LET g_ref_fields[2] = g_detail_m.glaq051
   CALL ap_ref_array2(g_ref_fields,"SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001=? AND gzcbl002=? AND gzcbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_detail_m.glaq051_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_detail_m.glaq051_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_m.glaq052
   CALL ap_ref_array2(g_ref_fields,"SELECT oojdl003 FROM oojdl_t WHERE oojdlent='"||g_enterprise||"' AND oojdl001=? AND oojdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_detail_m.glaq052_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_detail_m.glaq052_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_m.glaq053
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2002' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_detail_m.glaq053_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_detail_m.glaq053_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glaa005 
   LET g_ref_fields[2] = g_detail_m.glbc004
   CALL ap_ref_array2(g_ref_fields,"SELECT nmail004 FROM nmail_t WHERE nmailent='"||g_enterprise||"'AND nmail001=? AND nmail002=? AND nmail003='"||g_lang||"'","") RETURNING g_rtn_fields
   LET g_detail_m.glbc004_desc =  g_rtn_fields[1]
   DISPLAY BY NAME g_detail_m.glbc004_desc
END FUNCTION
# 自由核算項說明
PRIVATE FUNCTION axrt300_13_free_account_desc()
   DEFINE l_glae002     LIKE glae_t.glae002     #资料来源
   DEFINE l_sql         STRING                  #组的抓取资料的sql
   DEFINE l_glad0171    LIKE glad_t.glad0171 
   DEFINE l_glad0181    LIKE glad_t.glad0181
   DEFINE l_glad0191    LIKE glad_t.glad0191
   DEFINE l_glad0201    LIKE glad_t.glad0201
   DEFINE l_glad0211    LIKE glad_t.glad0211
   DEFINE l_glad0221    LIKE glad_t.glad0221
   DEFINE l_glad0231    LIKE glad_t.glad0231
   DEFINE l_glad0241    LIKE glad_t.glad0241
   DEFINE l_glad0251    LIKE glad_t.glad0251
   DEFINE l_glad0261    LIKE glad_t.glad0261

   
   SELECT glad0171,glad0181,glad0191,glad0201,
          glad0211,glad0221,glad0231,glad0221,
          glad0251,glad0261
    INTO  l_glad0171,l_glad0181,l_glad0191,l_glad0201,
          l_glad0211,l_glad0221,l_glad0231,l_glad0241,
          l_glad0251,l_glad0261
    FROM  glad_t
   WHERE  gladent = g_enterprise
     AND  gladld  = g_xrcald
     AND  glad001 = g_glaq_d[g_detail_idx].glaq002
   
   #核算项一
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = l_glad0171
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glad0171
      LET g_ref_fields[2] = g_detail_m.glaq029
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail_m.glaq029_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail_m.glaq029
      CALL axrt300_13_make_sql_desc(l_glad0171) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_detail_m.glaq029_desc= g_rtn_fields[1]
   END IF 
   #核算项二
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = l_glad0181
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glad0181
      LET g_ref_fields[2] = g_detail_m.glaq030     
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail_m.glaq030_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail_m.glaq030
      CALL axrt300_13_make_sql_desc(l_glad0181) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_detail_m.glaq030_desc= g_rtn_fields[1]
   END IF       
   #核算项三
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = l_glad0191
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glad0191
      LET g_ref_fields[2] = g_detail_m.glaq031
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail_m.glaq031_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail_m.glaq031
      CALL axrt300_13_make_sql_desc(l_glad0191) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_detail_m.glaq031_desc= g_rtn_fields[1]   
   END IF      
   #核算项四
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = l_glad0201
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glad0201
      LET g_ref_fields[2] = g_detail_m.glaq032
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail_m.glaq032_desc= g_rtn_fields[1]
    ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail_m.glaq032
      CALL axrt300_13_make_sql_desc(l_glad0201) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_detail_m.glaq032_desc= g_rtn_fields[1]   
   END IF        
   #核算项五
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = l_glad0211
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glad0211
      LET g_ref_fields[2] = g_detail_m.glaq033
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail_m.glaq033_desc= g_rtn_fields[1]  
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail_m.glaq033
      CALL axrt300_13_make_sql_desc(l_glad0211) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_detail_m.glaq033_desc= g_rtn_fields[1]   
   END IF        
   #核算项六
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = l_glad0221
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glad0221
      LET g_ref_fields[2] = g_detail_m.glaq034
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail_m.glaq034_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail_m.glaq034
      CALL axrt300_13_make_sql_desc(l_glad0221) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_detail_m.glaq034_desc= g_rtn_fields[1]   
   END IF        
   #核算项七
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = l_glad0231
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glad0231
      LET g_ref_fields[2] = g_detail_m.glaq035
      CALL axrt300_13_make_sql_desc(l_glad0231) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail_m.glaq035_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail_m.glaq035
      CALL axrt300_13_make_sql_desc(l_glad0241) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_detail_m.glaq035_desc= g_rtn_fields[1]   
   END IF           
   #核算项八
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = l_glad0241
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glad0241
      LET g_ref_fields[2] = g_detail_m.glaq036
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail_m.glaq036_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail_m.glaq036
      CALL axrt300_13_make_sql_desc(l_glad0241) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_detail_m.glaq036_desc= g_rtn_fields[1]   
   END IF        
   #核算项九
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = l_glad0251
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glad0251
      LET g_ref_fields[2] = g_detail_m.glaq037
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail_m.glaq037_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail_m.glaq037
      CALL axrt300_13_make_sql_desc(l_glad0251) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_detail_m.glaq037_desc= g_rtn_fields[1]   
   END IF        
   #核算项十
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = l_glad0261
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glad0261
      LET g_ref_fields[2] = g_detail_m.glaq038
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail_m.glaq038_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail_m.glaq038
      CALL axrt300_13_make_sql_desc(l_glad0261) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_detail_m.glaq038_desc= g_rtn_fields[1]   
   END IF    
END FUNCTION
# 自由核算項說明
PRIVATE FUNCTION axrt300_13_make_sql_desc(p_glae001)
   DEFINE p_glae001   LIKE glae_t.glae001   #核算项类型
   DEFINE r_sql       STRING
   DEFINE l_glae003   LIKE glae_t.glae003   #来源档案
   DEFINE l_glae004   LIKE glae_t.glae004   #来源编号栏位
   DEFINE l_glae005   LIKE glae_t.glae005   #来源说明档案
   DEFINE l_glae006   LIKE glae_t.glae006   #来源说明栏位  
   DEFINE l_dzeb002   LIKE dzeb_t.dzeb002   #栏位代号
   DEFINE l_dzeb006   LIKE dzeb_t.dzeb002   #栏位属性    
   DEFINE l_sql     STRING
   DEFINE li_sql1   STRING    #抓主档表的key
   DEFINE li_sql2   STRING    #抓对应多语言表的key 
   #抓取主表的key放入数组
   DEFINE li_main    DYNAMIC ARRAY OF RECORD
          dzeb002    LIKE dzeb_t.dzeb002       
   END RECORD 
   #抓取多语言表的key放入数组
   DEFINE li_dlang    DYNAMIC ARRAY OF RECORD
          dzeb002    LIKE dzeb_t.dzeb002       
   END RECORD 
   DEFINE l_where   STRING    #组出的对应的抓取说明的where条件    
   DEFINE l_i,l_i2,l_i3       LIKE type_t.num5
   
   #初始化
   CALL li_main.clear()
   CALL li_dlang.clear()
   
   #抓取来源档案，来源说明档案，来源说明栏位
   SELECT glae003,glae004,glae005,glae006 INTO l_glae003,l_glae004,l_glae005,l_glae006 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = p_glae001
      
   #抓取主档key
   LET l_i = 1
   LET li_sql1 = " SELECT dzeb002 FROM dzeb_t ",
                 "  WHERE dzeb001 = '",l_glae003,"'",
                 "    AND dzeb004 = 'Y'", 
                 "  ORDER BY dzeb021 " 
   PREPARE axrt300_13_pr FROM li_sql1
   DECLARE axrt300_13_cs CURSOR FOR axrt300_13_pr
   FOREACH axrt300_13_cs INTO li_main[l_i].dzeb002
       LET l_i = l_i +1
   END FOREACH
   #真实数组长度
   LET l_i = l_i -1  
   
   #抓取多语言档key
   LET l_i2 = 1
   LET li_sql2 = " SELECT dzeb002 FROM dzeb_t ",
                 " WHERE dzeb001 = '",l_glae005,"'" ,
                  "  AND dzeb004 = 'Y'",
                 " ORDER BY dzeb021 "
   PREPARE axrt300_13_pr2 FROM li_sql2
   DECLARE axrt300_13_cs2 CURSOR FOR axrt300_13_pr2
   FOREACH axrt300_13_cs2 INTO li_dlang[l_i2].dzeb002
       LET l_i2 = l_i2 +1
   END FOREACH
   #真实数组长度
   LET l_i2 = l_i2 -1  

   
   #组合where条件 
   LET l_where = '1=1'
   FOR  l_i3 = 1 TO  l_i 
       LET l_where = l_where," AND ", li_main[l_i3].dzeb002, " = " ,li_dlang[l_i3].dzeb002
   END FOR    
   
   #组出的基础sql   
   LET r_sql = " SELECT ", l_glae006 ," FROM ",l_glae005 ,',',l_glae003,
               " WHERE " , l_glae004," = ?",
               "   AND " ,l_where
   #组sql               
   LET l_sql = "SELECT dzeb002,dzeb006 FROM dzeb_t ",
               " WHERE dzeb001 = '",l_glae005,"'",
               "   AND dzeb004 = 'Y'"
   PREPARE axrt300_13_make_sql_pre1 FROM l_sql
   DECLARE axrt300_13_make_sql_cs1 CURSOR FOR axrt300_13_make_sql_pre1
   FOREACH axrt300_13_make_sql_cs1 INTO l_dzeb002,l_dzeb006
      #判断是否有ent栏位
      IF l_dzeb006 = 'N802' THEN
         LET r_sql = r_sql CLIPPED," AND ",l_dzeb002 ," ='",g_enterprise,"' "
      END IF 
      
      IF l_dzeb006 = 'C800' THEN
         LET r_sql = r_sql CLIPPED," AND ",l_dzeb002 ," ='",g_dlang,"' "
      END IF

   END FOREACH
   RETURN r_sql
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axrt300_13_b_fill1(p_wc2)
#                  RETURNING 回传参数
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt300_13_b_fill1(p_wc2)
   DEFINE p_wc2    STRING
   DEFINE r_success       LIKE type_t.num5
   DEFINE r_start_no      LIKE glap_t.glapdocno
   DEFINE r_end_no        LIKE glap_t.glapdocno
   DEFINE l_glaa015       LIKE glaa_t.glaa015
   DEFINE l_glaa016       LIKE glaa_t.glaa016
   DEFINE l_glaa019       LIKE glaa_t.glaa019
   DEFINE l_glaa020       LIKE glaa_t.glaa020
   DEFINE l_glaq002       STRING
   DEFINE l_nmbs003       LIKE nmbs_t.nmbs003
   DEFINE l_fmay007       LIKE fmay_t.fmay007    #帳別
   DEFINE l_fmbb006       LIKE fmbb_t.fmbb006    #重評價
   DEFINE l_docno         LIKE glap_t.glapdocno  #150429-00010#14
   DEFINE l_str           STRING 
   DEFINE l_str1          STRING
   DEFINE l_str2          STRING
   DEFINE l_str3          STRING
   DEFINE l_str4          STRING
   DEFINE l_msg1          STRING
   DEFINE l_msg2          STRING
   DEFINE l_msg3          STRING
   DEFINE l_msg4          STRING
   DEFINE l_type1         LIKE type_t.chr2    #150413-00021#24
   
   
  IF cl_null(p_wc2) THEN
     LET p_wc2 = " 1=1"
  END IF
  
  SELECT glaa015,glaa016,glaa019,glaa020
     INTO l_glaa015,l_glaa016,l_glaa019,l_glaa020
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_xrcald
      
   LET l_str1 = cl_getmsg("axr-00090",g_lang)     #借方金額(
   LET l_str2 = cl_getmsg("axr-00091",g_lang)     #貸方金額(
   LET l_str3 = cl_getmsg("axr-00092",g_lang)     #)(本位幣二)
   LET l_str4 = cl_getmsg("axr-00093",g_lang)     #)(本位幣三)
   
   LET l_msg1 = l_str1 CLIPPED,l_glaa016 CLIPPED,l_str3
   LET l_msg2 = l_str2 CLIPPED,l_glaa016 CLIPPED,l_str3
   LET l_msg3 = l_str1 CLIPPED,l_glaa020 CLIPPED,l_str4
   LET l_msg4 = l_str2 CLIPPED,l_glaa020 CLIPPED,l_str4
      
   IF l_glaa015 = 'Y' THEN 
      CALL cl_set_comp_visible('glaq040,glaq041',TRUE)
      CALL cl_set_comp_att_text('glaq040',l_msg1)
      CALL cl_set_comp_att_text('glaq041',l_msg2)
   ELSE
      CALL cl_set_comp_visible('glaq040,glaq041',FALSE)
   END IF
      
   IF l_glaa019 = 'Y' THEN 
      CALL cl_set_comp_visible('glaq043,glaq044',TRUE)
      CALL cl_set_comp_att_text('glaq043',l_msg3)
      CALL cl_set_comp_att_text('glaq044',l_msg4)
   ELSE
      CALL cl_set_comp_visible('glaq043,glaq044',FALSE)
   END IF
   
   #ANM 模組調用
   IF g_sys = 'NM' THEN
      IF g_type = '1' THEN
#160802-00033#1 mark s---      
#         SELECT nmbs003 INTO l_nmbs003 FROM nmbs_t WHERE nmbsent = g_enterprise 
#                                                     AND nmbsld = g_xrcald 
#                                                     AND nmbsdocno = g_xrcadocno
#          #添加幣別，匯率，原币金額 
#         IF cl_null(l_nmbs003) THEN 
#160802-00033#1 mark e---  
#160802-00033#1 mod s---  
#            LET g_sql= " SELECT DISTINCT docno,glaqld,glaqseq,glaq001,glaq002,glaq005,glaq006,glaq010,d,c,glaq040,glaq041,glaq043,glaq044,seq,seq2 FROM s_voucher_nm_tmp ",    
#                       "  WHERE docno = '",g_xrcadocno,"'",            
#                       "  ORDER BY d desc,c  " 
            LET g_sql= " SELECT DISTINCT docno,glaqld,glaqseq,glaq001,glaq002,glaq005,glaq006,sum,d,c,",
                       #"                 glaq040,glaq041,glaq043,glaq044 FROM s_voucher_nm_group ",    #161013-00011#1 mark
                       "                 glaq040,glaq041,glaq043,glaq044 FROM s_vr_tmp07 ",     #161013-00011#1 add                      
                       "  ORDER BY d desc,c  " 
#160802-00033#1 mod e---                         
                       
#160802-00033#1 mark s---  
#         ELSE
#            LET g_sql= " SELECT DISTINCT '',glaqld,glaqseq,glaq001,glaq002,glaq005,glaq006,glaq010,glaq003,glaq004,glaq040,glaq041,glaq043,glaq044,seq,seq2 FROM glaq_t ",
#                       "  WHERE glaqent = '",g_enterprise,"'",
#                       "    AND glaqld = '",g_xrcald,"'",
#                       "    AND glaqdocno = '",l_nmbs003,"'",
#                       "  ORDER BY d desc,c  "
#160802-00033#1 mark e---  
         #END IF #160802-00033#1 mark
      END IF  
      IF g_type = '2' THEN
         LET g_sql= " SELECT DISTINCT docno,glaqld,glaqseq,glaq001,glaq002,glaq005,glaq006,sum,d,c,glaq040,glaq041,glaq043,glaq044,seq,xrca039,'' FROM anmt821_tmp02 ",  #160727-00019#33 Mod  s_anmt821_ar_group--> anmt821_tmp02
                       "  ORDER BY d desc,c  "
      END IF
      IF g_type = '3' THEN
         LET g_sql= " SELECT DISTINCT docno,glaqld,glaqseq,glaq001,glaq002,glaq005,glaq006,sum,d,c,glaq040,glaq041,glaq043,glaq044,seq,xrca039,'' FROM anmt822_tmp02 ",   #160727-00019#33 Mod  s_anmt822_ar_group --> anmt822_tmp02
                       "  ORDER BY d desc,c  "
      END IF
      #2015/01/04---add---by qiull
      IF g_type = 'anmt820' THEN
         LET g_sql= " SELECT DISTINCT '',glaqld,glaqseq,glaq001,glaq002,glaq005,glaq006,sum,d,c,glaq040,glaq041,glaq043,glaq044,seq,xrca039,'' FROM anmt820_tmp02 ",    #160727-00019#33 Mod  s_anmt820_nm_group--> anmt820_tmp02  
                       "  ORDER BY d desc,c  "
      END IF 
      #2015/01/04---add---by qiull      
   END IF                                               
#fengmy160516---begin
      IF g_type = 'anmt820' THEN
         #LET g_sql= " SELECT DISTINCT '',glaqld,glaqseq,glaq001,glaq002,glaq005,glaq006,sum,d,c,glaq040,glaq041,glaq043,glaq044,seq,xrca039,'' FROM s_anmt820_nm_tmp ",                        "  ORDER BY d desc,c  "
         LET g_sql= " SELECT DISTINCT '',glaqld,glaqseq,glaq001,glaq002,glaq005,glaq006,sum,d,c,glaq040,glaq041,glaq043,glaq044,seq,xrca039,'' FROM anmt820_tmp01 ",                        "  ORDER BY d desc,c  "   
                   
         #160727-00019#33 Mod  s_anmt820_nm_tmp--> anmt820_tmp01 
      END IF 
#fengmy160516---end           
   #AFM 模組調用       
   #yangtt--2016/03/15--mark--str--
#   IF g_sys = 'FM' AND g_type = 'afmt075' THEN
#      SELECT fmay007 INTO l_fmay007 FROM fmay_t WHERE fmayent = g_enterprise 
#                                                  AND fmay003 = g_xrcald 
#                                                  AND fmay002 = g_xrcadocno    
#      #添加幣別，匯率，原币金額
#      IF cl_null(l_fmay007) THEN 
#         LET g_sql= " SELECT DISTINCT docno,glaqld,glaqseq,glaq001,glaq002,glaq005,glaq006,glaq010,d,c,glaq040,glaq041,glaq043,glaq044,seq,seq2 FROM s_voucher_fm_tmp ",
#                    "  WHERE docno = '",g_xrcadocno,"'",
#                    "  ORDER BY d desc,c  "
#      ELSE
#         LET g_sql= " SELECT DISTINCT '',glaqld,glaqseq,glaq001,glaq002,glaq005,glaq006,glaq010,glaq003,glaq004,glaq040,glaq041,glaq043,glaq044,seq,seq2 FROM glaq_t ",
#                    "  WHERE glaqent = '",g_enterprise,"'",
#                    "    AND glaqld = '",g_xrcald,"'",
#                    "    AND glaqdocno = '",l_fmay007,"'",
#                    "  ORDER BY d desc,c  "
#      END IF
#   END IF  
   
    
#    IF g_sys = 'FM' AND g_type = 'afmt090' THEN
#      SELECT DISTINCT fmbb006 INTO l_fmbb006 FROM fmbb_t WHERE fmbbent = g_enterprise 
#                                                           AND fmbb003 = g_xrcald  #帳套
#                                                           AND fmbb004 = g_year    #年度
#                                                           AND fmbb005 = g_month   #期別   
#      #添加幣別，匯率，原币金額
#      IF cl_null(l_fmbb006) THEN 
#         LET g_sql= " SELECT DISTINCT docno,glaqld,glaqseq,glaq001,glaq002,glaq005,glaq006,glaq010,d,c,glaq040,glaq041,glaq043,glaq044,seq,seq2,state FROM s_voucher_fm_tmp ",
#                    "  WHERE glaqld = '",g_xrcald,"'",
#                    "    AND year1 = '",g_year,"'",
#                    "    AND month1 = '",g_month,"'",
#                    "  ORDER BY d desc,c  "
#      ELSE
#         LET g_sql= " SELECT DISTINCT '',glaqld,glaqseq,glaq001,glaq002,glaq005,glaq006,glaq010,glaq003,glaq004,glaq040,glaq041,glaq043,glaq044,seq,seq2,'' FROM glaq_t ",
#                    "  WHERE glaqent = '",g_enterprise,"'",
#                    "    AND glaqld = '",g_xrcald,"'",
#                    "    AND glaqdocno = '",l_fmbb006,"'",
#                    "  ORDER BY d desc,c  "
#      END IF
#   END IF  
   #yangtt--2016/03/15--mark--end--
   
   #150413-00021#24---add---str
   IF g_sys = 'FM' AND (g_type = 'afmt145' OR g_type = 'afmt185' OR g_type = 'afmt175') THEN   #AFM 融资到账账务,计提利息账务，偿还本息
      #先產生暫存檔
      CALL s_transaction_begin()
      LET g_wc =" fmctdocno = '",g_xrcadocno,"' "
      
      CASE g_type
         WHEN 'afmt145' LET l_type1 = '14'
         WHEN 'afmt185' LET l_type1 = '18'
         WHEN 'afmt175' LET l_type1 = '17'
      END CASE
      
      CALL s_afmt145_gen_fm(l_type1,g_xrcald,'','','0',g_wc,'Y',g_type)
        RETURNING r_success,r_start_no,r_end_no
   
      IF r_success THEN
         CALL s_transaction_end('Y','Y')
      ELSE
         CALL s_transaction_end('N','Y')  
         RETURN       
      END IF
      
      SELECT DISTINCT fmct002 INTO l_docno
        FROM fmct_t
       WHERE fmctent   = g_enterprise
         AND fmctdocno = g_xrcadocno
         AND fmctld    = g_xrcald
         
      IF cl_null(l_docno) THEN 
         LET g_sql= " SELECT DISTINCT docno,glaqld,glaqseq,glaq001,glaq002,glaq005,glaq006,sum,d,c,glaq040,glaq041,glaq043,glaq044,seq,'','' FROM afmt145_tmp01 ",           #160727-00019#33 Mod   s_afmt145_fm_tmp -->afmt145_tmp01
                    "  WHERE glaqld = '",g_xrcald,"'",
                    "    AND docno = '",g_xrcadocno,"'",
                    "  ORDER BY d desc,c  "
      ELSE
         LET g_sql= " SELECT DISTINCT '',glaqld,glaqseq,glaq001,glaq002,",
                    "                 glaq005,glaq006,sum,glaq003,glaq004,",
                    "                 glaq040,glaq041,glaq043,glaq044,'',",
                    "                 '',''",
                    "   FROM glaq_t ",
                    "  WHERE glaqent = '",g_enterprise,"'",
                    "    AND glaqld = '",g_xrcald,"'",
                    "    AND glaqdocno = '",l_docno,"'",
                    "  ORDER BY glaq003 desc,glaq004"
      END IF
   END IF
   #150413-00021#24---add---end
   
   #150429-00010#14 add ------
   IF g_sys = 'FM' AND g_type[1,5] = 'afmt5' THEN
      #先產生暫存檔
      CALL s_transaction_begin()
      CASE g_type
         WHEN 'afmt570'
            LET g_wc =" fmnadocno = '",g_xrcadocno,"' "
            CALL s_voucher_gen_fm('3',g_xrcald,'','','0',g_wc,'Y',g_type)
              RETURNING r_success,r_start_no,r_end_no
         WHEN 'afmt555'
            LET g_wc =" fmmqdocno = '",g_xrcadocno,"' "
            CALL s_voucher_gen_fm('4',g_xrcald,'','','0',g_wc,'Y',g_type)
              RETURNING r_success,r_start_no,r_end_no
          
         WHEN 'afmt595'
            LET g_wc =" fmnedocno = '",g_xrcadocno,"' "
            CALL s_voucher_gen_fm('5',g_xrcald,'','','0',g_wc,'Y',g_type)
              RETURNING r_success,r_start_no,r_end_no                  
              
         WHEN 'afmt555'
            LET g_wc =" fmmwdocno = '",g_xrcadocno,"' "
            CALL s_voucher_gen_fm('6',g_xrcald,'','','0',g_wc,'Y',g_type)
              RETURNING r_success,r_start_no,r_end_no
        
         #140804-00008#15 add ------
         WHEN 'afmt565'
            LET g_wc =" fmmudocno = '",g_xrcadocno,"' "
            CALL s_voucher_gen_fm('7',g_xrcald,'','','0',g_wc,'Y',g_type)
              RETURNING r_success,r_start_no,r_end_no
         #140804-00008#15 add end---
         
         #140804-00008#9 add ------
         WHEN 'afmt535'
            LET g_wc =" fmmldocno = '",g_xrcadocno,"' "
            CALL s_voucher_gen_fm('8',g_xrcald,'','','0',g_wc,'Y',g_type)
              RETURNING r_success,r_start_no,r_end_no
         #140804-00008#9 add end---

         OTHERWISE
            LET g_wc =" 1=1"
      END CASE
  
      IF r_success THEN
         CALL s_transaction_end('Y','Y')
      ELSE
         CALL s_transaction_end('N','Y')  
         RETURN       
      END IF
      
      #撈看看有沒有傳票號碼
      CASE g_type
         WHEN 'afmt570'
            SELECT DISTINCT fmna005 INTO l_docno
              FROM fmna_t
             WHERE fmnaent   = g_enterprise
               AND fmnadocno = g_xrcadocno
               AND fmna001   = g_xrcald
               
         WHEN 'afmt555'
            SELECT DISTINCT fmmq004 INTO l_docno
              FROM fmmq_t
             WHERE fmmqent   = g_enterprise
               AND fmmqdocno = g_xrcadocno
               AND fmmq001   = g_xrcald
         
         WHEN 'afmt595'
            SELECT DISTINCT fmne004 INTO l_docno
              FROM fmne_t
             WHERE fmneent   = g_enterprise
               AND fmnedocno = g_xrcadocno
               AND fmne001   = g_xrcald
         
         WHEN 'afmt585'
            SELECT DISTINCT fmmx004 INTO l_docno
              FROM fmmx_t
             WHERE fmmxent   = g_enterprise
               AND fmmxdocno = g_xrcadocno
               AND fmmx001   = g_xrcald
         
         #140804-00008#15 add ------
         WHEN 'afmt565'
            SELECT DISTINCT fmmu004 INTO l_docno
              FROM fmmu_t
             WHERE fmmuent   = g_enterprise
               AND fmmudocno = g_xrcadocno
               AND fmmu001   = g_xrcald
         #140804-00008#15 add end---
         
         #140804-00008#9 add ------
         WHEN 'afmt535'
            SELECT DISTINCT fmml007 INTO l_docno
              FROM fmml_t
             WHERE fmmlent   = g_enterprise
               AND fmmldocno = g_xrcadocno
               AND fmml003   = g_xrcald
         #140804-00008#9 add end---
      END CASE
      
      IF cl_null(l_docno) THEN
         LET g_sql= " SELECT DISTINCT docno,glaqld,glaqseq,glaq001,glaq002,",
                    "                 glaq005,glaq006,glaq010,d,c,",
                    "                 glaq040,glaq041,glaq043,glaq044,seq,",
                    "                 seq2,state",
                    "   FROM s_vr_tmp08 ",  #160727-00019#38   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_voucher_fm_tmp ——> s_vr_tmp08
                    "  WHERE glaqld = '",g_xrcald,"'",
                    "    AND docno = '",g_xrcadocno,"'",
                    "  ORDER BY d desc,c  "
      ELSE
         LET g_sql= " SELECT DISTINCT '',glaqld,glaqseq,glaq001,glaq002,",
                    "                 glaq005,glaq006,glaq010,glaq003,glaq004,",
                    "                 glaq040,glaq041,glaq043,glaq044,'',",
                    "                 '',''",
                    "   FROM glaq_t ",
                    "  WHERE glaqent = '",g_enterprise,"'",
                    "    AND glaqld = '",g_xrcald,"'",
                    "    AND glaqdocno = '",l_docno,"'",
                    "  ORDER BY glaq003 desc,glaq004"
      END IF
   END IF   
   #150429-00010#14 add end---
   
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axrt300_13_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR axrt300_13_pb1
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_glaq_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs1 INTO g_glaq_d[l_ac].glaqdocno,g_glaq_d[l_ac].glaqld,g_glaq_d[l_ac].glaqseq,g_glaq_d[l_ac].glaq001, 
       g_glaq_d[l_ac].glaq002,g_glaq_d[l_ac].glaq005,g_glaq_d[l_ac].glaq006,g_glaq_d[l_ac].glaq010,g_glaq_d[l_ac].glaq003,
       g_glaq_d[l_ac].glaq004,g_glaq_d[l_ac].glaq040,g_glaq_d[l_ac].glaq041, g_glaq_d[l_ac].glaq043,g_glaq_d[l_ac].glaq044,
       g_glaq_d[l_ac].seq,g_glaq_d[l_ac].seq2,g_glaq_d[l_ac].state
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
  
      IF g_glaq_d[l_ac].glaq003 = 0 AND g_glaq_d[l_ac].glaq004 = 0 THEN
         CONTINUE FOREACH
      END IF   
      #add-point:b_fill段資料填充
   #  IF cl_null(l_nmbs003) THEN 
      #   LET g_glaq_d[l_ac].glaqseq = l_ac #160802-00033#1  
   #   ELSE
   #      LET g_glaq_d[l_ac].glaqdocno = g_xrcadocno
   #   END IF
      
     #CALL axrt300_13_glaq002_desc(g_glaq_d[l_ac].glaq002,g_glaq_d[l_ac].seq,g_glaq_d[l_ac].seq2,g_glaq_d[l_ac].glaqdocno,g_glaq_d[l_ac].state) RETURNING l_glaq002,l_str
      CALL axrt300_13_glaq002_desc(g_glaq_d[l_ac].glaq002,g_glaq_d[l_ac].seq,g_glaq_d[l_ac].seq2,g_glaq_d[l_ac].state,g_glaq_d[l_ac].glaqdocno) RETURNING l_glaq002,l_str 
      LET g_glaq_d[l_ac].glacl004 = g_glaq_d[l_ac].glaq002,l_str,'\n',l_glaq002
      IF g_glaq_d[l_ac].glaq003 = 0 THEN 
         LET g_glaq_d[l_ac].glaq003 = ''
      END IF
      
      IF g_glaq_d[l_ac].glaq004 = 0 THEN 
         LET g_glaq_d[l_ac].glaq004 = ''
      END IF
      
      IF g_glaq_d[l_ac].glaq040 = 0 THEN 
         LET g_glaq_d[l_ac].glaq040 = ''
      END IF
      
      IF g_glaq_d[l_ac].glaq041 = 0 THEN 
         LET g_glaq_d[l_ac].glaq041 = ''
      END IF
      
      IF g_glaq_d[l_ac].glaq043 = 0 THEN 
         LET g_glaq_d[l_ac].glaq043 = ''
      END IF
      
      IF g_glaq_d[l_ac].glaq044 = 0 THEN 
         LET g_glaq_d[l_ac].glaq044 = ''
      END IF
      #end add-point
      
      CALL axrt300_13_detail_show()        
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   IF l_ac > g_max_rec THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9035
         LET g_errparam.extend = "nmbs_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

      END IF
   END IF 
   LET g_error_show = 0
   
 
   
   CALL g_glaq_d.deleteElement(g_glaq_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_glaq_d.getLength()
 
   END FOR
   
   IF g_cnt > g_glaq_d.getLength() THEN
      LET l_ac = g_glaq_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #add-point:b_fill段資料填充(其他單身)

   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_glaq_d.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs1
   FREE axrt300_13_pb1
   
   
END FUNCTION

################################################################################
# Descriptions...: 固定資產預覽
################################################################################
PRIVATE FUNCTION axrt300_13_b_fill2(p_wc2)
   DEFINE p_wc2    STRING
   DEFINE r_success       LIKE type_t.num5
   DEFINE r_start_no      LIKE glap_t.glapdocno
   DEFINE r_end_no        LIKE glap_t.glapdocno
   DEFINE l_glaa015       LIKE glaa_t.glaa015
   DEFINE l_glaa016       LIKE glaa_t.glaa016
   DEFINE l_glaa019       LIKE glaa_t.glaa019
   DEFINE l_glaa020       LIKE glaa_t.glaa020
   DEFINE l_glaq002       STRING
   DEFINE l_nmbs003       LIKE nmbs_t.nmbs003
   DEFINE l_str           STRING 
   DEFINE l_str1          STRING
   DEFINE l_str2          STRING
   DEFINE l_str3          STRING
   DEFINE l_str4          STRING
   DEFINE l_msg1          STRING
   DEFINE l_msg2          STRING
   DEFINE l_msg3          STRING
   DEFINE l_msg4          STRING
   DEFINE l_docno              LIKE glaq_t.glaqld
   DEFINE l_n             LIKE type_t.num5
   
   
  IF cl_null(p_wc2) THEN
     LET p_wc2 = " 1=1"
  END IF
  
  SELECT glaa015,glaa016,glaa019,glaa020
     INTO l_glaa015,l_glaa016,l_glaa019,l_glaa020
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_xrcald
      
   LET l_str1 = cl_getmsg("axr-00090",g_lang)     #借方金額(
   LET l_str2 = cl_getmsg("axr-00091",g_lang)     #貸方金額(
   LET l_str3 = cl_getmsg("axr-00092",g_lang)     #)(本位幣二)
   LET l_str4 = cl_getmsg("axr-00093",g_lang)     #)(本位幣三)
   
   LET l_msg1 = l_str1 CLIPPED,l_glaa016 CLIPPED,l_str3
   LET l_msg2 = l_str2 CLIPPED,l_glaa016 CLIPPED,l_str3
   LET l_msg3 = l_str1 CLIPPED,l_glaa020 CLIPPED,l_str4
   LET l_msg4 = l_str2 CLIPPED,l_glaa020 CLIPPED,l_str4
      
   IF l_glaa015 = 'Y' THEN 
      CALL cl_set_comp_visible('glaq040,glaq041',TRUE)
      CALL cl_set_comp_att_text('glaq040',l_msg1)
      CALL cl_set_comp_att_text('glaq041',l_msg2)
   ELSE
      CALL cl_set_comp_visible('glaq040,glaq041',FALSE)
   END IF
      
   IF l_glaa019 = 'Y' THEN 
      CALL cl_set_comp_visible('glaq043,glaq044',TRUE)
      CALL cl_set_comp_att_text('glaq043',l_msg3)
      CALL cl_set_comp_att_text('glaq044',l_msg4)
   ELSE
      CALL cl_set_comp_visible('glaq043,glaq044',FALSE)
   END IF
   
   IF cl_null(g_xrcadocno) THEN
      LET g_sql= " SELECT DISTINCT '',glaqld,0,glaq001,glaq002,glaq005,glaq006,glaq010,glaq003,glaq004,glaq040,glaq041,glaq043,glaq044 FROM afat509_faam_tmp ",
                 "  WHERE glaqent = '",g_enterprise,"'",
                 "    AND glaqld = '",g_xrcald,"'",
                 "  ORDER BY glaq003 desc,glaq004  "
   ELSE 
     #LET g_sql= " SELECT DISTINCT '',glaqld,0,glaq001,glaq002,glaq005,glaq006,sum,d,c,glaq040,glaq041,glaq043,glaq044,seq FROM afap280_01_fa_group ",   #151001-00005#1
     #LET g_sql= " SELECT DISTINCT '',glaqld,0,glaq001,glaq002,glaq005,glaq006,sum,d,c,glaq040,glaq041,glaq043,glaq044,seq FROM afap280_01_group ",   #151001-00005#1 #160727-00019#2 mark
      LET g_sql= " SELECT DISTINCT '',glaqld,0,glaq001,glaq002,glaq005,glaq006,sum,d,c,glaq040,glaq041,glaq043,glaq044,seq FROM afap280_tmp02 ",      #160727-00019#2 Mod   afap280_01_group -->afap280_tmp02
                 "  WHERE glaqent = '",g_enterprise,"'",
                 "    AND glaqld = '",g_xrcald,"'",
                 "    AND docno = '",g_xrcadocno,"'",
                 "  ORDER BY d DESC  "
   END IF
   
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axrt300_13_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR axrt300_13_pb2
 
   CALL g_glaq_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs2 INTO g_glaq_d[l_ac].glaqdocno,g_glaq_d[l_ac].glaqld,g_glaq_d[l_ac].glaqseq,g_glaq_d[l_ac].glaq001, 
       g_glaq_d[l_ac].glaq002,g_glaq_d[l_ac].glaq005,g_glaq_d[l_ac].glaq006,g_glaq_d[l_ac].glaq010,g_glaq_d[l_ac].glaq003,
       g_glaq_d[l_ac].glaq004,g_glaq_d[l_ac].glaq040,g_glaq_d[l_ac].glaq041, g_glaq_d[l_ac].glaq043,g_glaq_d[l_ac].glaq044,
       g_glaq_d[l_ac].seq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充
      LET l_str = ''
      LET l_glaq002 = ''
      CALL axrt300_13_glaq002_desc(g_glaq_d[l_ac].glaq002,g_glaq_d[l_ac].seq,'','','') RETURNING l_glaq002,l_str
      LET g_glaq_d[l_ac].glacl004 = g_glaq_d[l_ac].glaq002,l_str,'\n',l_glaq002
      IF g_glaq_d[l_ac].glaq003 = 0 THEN 
         LET g_glaq_d[l_ac].glaq003 = ''
      END IF
      
      IF g_glaq_d[l_ac].glaq004 = 0 THEN 
         LET g_glaq_d[l_ac].glaq004 = ''
      END IF
      
      IF g_glaq_d[l_ac].glaq040 = 0 THEN 
         LET g_glaq_d[l_ac].glaq040 = ''
      END IF
      
      IF g_glaq_d[l_ac].glaq041 = 0 THEN 
         LET g_glaq_d[l_ac].glaq041 = ''
      END IF
      
      IF g_glaq_d[l_ac].glaq043 = 0 THEN 
         LET g_glaq_d[l_ac].glaq043 = ''
      END IF
      
      IF g_glaq_d[l_ac].glaq044 = 0 THEN 
         LET g_glaq_d[l_ac].glaq044 = ''
      END IF
      #end add-point
      
      CALL axrt300_13_detail_show()        
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   IF l_ac > g_max_rec THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9035
         LET g_errparam.extend = "faam_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

      END IF
   END IF 
   LET g_error_show = 0
   
 
   
   CALL g_glaq_d.deleteElement(g_glaq_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_glaq_d.getLength()
 
   END FOR
   
   IF g_cnt > g_glaq_d.getLength() THEN
      LET l_ac = g_glaq_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #add-point:b_fill段資料填充(其他單身)

   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_glaq_d.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs2
   FREE axrt300_13_pb2
END FUNCTION

################################################################################
# Descriptions...: AGL传票预览
# Memo...........:
# Usage..........: CALL axrt300_13_b_fill3(p_wc2)
# Date & Author..: 2014/12/8 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt300_13_b_fill3(p_wc2)
   DEFINE p_wc2           STRING
   DEFINE r_success       LIKE type_t.num5
   DEFINE r_start_no      LIKE glap_t.glapdocno
   DEFINE r_end_no        LIKE glap_t.glapdocno
   DEFINE l_glaq002       STRING
   DEFINE l_str           STRING
   
   CALL s_transaction_begin()

   IF g_type = '1' THEN 
      LET g_wc = "glce001 = ",g_xrcadocno
      CALL s_aglt420_gen_ar(1,g_xrcald,'','',1,g_wc,'Y') RETURNING r_success,r_start_no,r_end_no
   END IF

   IF r_success THEN
      CALL s_transaction_end('Y','Y')
   ELSE
      CALL s_transaction_end('N','Y')  
      RETURN       
   END IF
   
   LET g_sql= " SELECT DISTINCT docno,glaqld,glaqseq,glaq001,glaq002,glaq005,glaq006,sum,d,c,",
              "                 glaq040,glaq041,glaq043,glaq044 FROM s_vr_tmp05 ",   #160727-00019#36   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_voucher_ar_group ——> s_vr_tmp05
              "  WHERE glaqent = ?",      #增加此段是为了规避下方的：OPEN b_fill_curs USING g_enterprise
              "  ORDER BY d DESC"

   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axrt300_13_pb3 FROM g_sql
   DECLARE b_fill_curs3 CURSOR FOR axrt300_13_pb3
   
   OPEN b_fill_curs3 USING g_enterprise
 
   CALL g_glaq_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs3 INTO g_glaq_d[l_ac].glaqdocno,g_glaq_d[l_ac].glaqld,g_glaq_d[l_ac].glaqseq,g_glaq_d[l_ac].glaq001, 
       g_glaq_d[l_ac].glaq002,g_glaq_d[l_ac].glaq005,g_glaq_d[l_ac].glaq006,g_glaq_d[l_ac].glaq010,g_glaq_d[l_ac].glaq003, 
       g_glaq_d[l_ac].glaq004,g_glaq_d[l_ac].glaq040,g_glaq_d[l_ac].glaq041,g_glaq_d[l_ac].glaq043,g_glaq_d[l_ac].glaq044 

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充
      CALL axrt300_13_glaq002_desc(g_glaq_d[l_ac].glaq002,g_glaq_d[l_ac].glaqseq,g_glaq_d[l_ac].seq2,'','') RETURNING l_glaq002,l_str
      LET g_glaq_d[l_ac].glacl004 = g_glaq_d[l_ac].glaq002,l_str,'\n',l_glaq002
      IF g_glaq_d[l_ac].glaq003 = 0 THEN 
         LET g_glaq_d[l_ac].glaq003 = ''
      END IF
      
      IF g_glaq_d[l_ac].glaq004 = 0 THEN 
         LET g_glaq_d[l_ac].glaq004 = ''
      END IF
      
      IF g_glaq_d[l_ac].glaq040 = 0 THEN 
         LET g_glaq_d[l_ac].glaq040 = ''
      END IF
      
      IF g_glaq_d[l_ac].glaq041 = 0 THEN 
         LET g_glaq_d[l_ac].glaq041 = ''
      END IF
      
      IF g_glaq_d[l_ac].glaq043 = 0 THEN 
         LET g_glaq_d[l_ac].glaq043 = ''
      END IF
      
      IF g_glaq_d[l_ac].glaq044 = 0 THEN 
         LET g_glaq_d[l_ac].glaq044 = ''
      END IF
      #end add-point
      
      CALL axrt300_13_detail_show()      
 
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
 
      LET l_ac = l_ac + 1
      
   END FOREACH
 
   LET g_error_show = 0
   
 
   
   CALL g_glaq_d.deleteElement(g_glaq_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_glaq_d.getLength()
 
   END FOR
   
   IF g_cnt > g_glaq_d.getLength() THEN
      LET l_ac = g_glaq_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #add-point:b_fill段資料填充(其他單身)

   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_glaq_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs3
   FREE axrt300_13_pb3
END FUNCTION

 
{</section>}
 
