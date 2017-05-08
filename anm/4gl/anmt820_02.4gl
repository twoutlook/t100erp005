#該程式未解開Section, 採用最新樣板產出!
{<section id="anmt820_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2014-08-22 17:12:35), PR版次:0009(2016-12-14 14:54:27)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000086
#+ Filename...: anmt820_02
#+ Description: 匯差科目核算項維護
#+ Creator....: 01531(2014-08-18 10:08:06)
#+ Modifier...: 01531 -SD/PR- 02481
 
{</section>}
 
{<section id="anmt820_02.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#150729-00002#1 150729 By Jessy anmt* Bug 修正 (一進畫面預帶資料/反灰不需要的ACTION/執行就當出)
#160318-00005#29 2016/03/25 By 07900   重复错误信息修改
#160318-00025#13 2016/04/15 By 07673   將重複內容的錯誤訊息置換為公用錯誤訊息
#160627-00016#1  2016/06/27 By 01531   anmt820维护核算项报错
#160727-00019#33   2016/08/15 By 08742    系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 
#                                          Mod   s_anmt820_nm_tmp--> anmt820_tmp01
#161110-00001#2  2016/11/28 By 07900     ANM模組使用ooea_t/ooeaf_t的需替換ooef_t/ooefl_t
#161212-00005#2  2016/12/14  by 02481    标准程式定义采用宣告模式,弃用.*写法
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
PRIVATE TYPE type_g_nmde_d RECORD
       nmde001 LIKE nmde_t.nmde001, 
   nmde002 LIKE nmde_t.nmde002, 
   nmde004 LIKE nmde_t.nmde004, 
   nmdeld LIKE nmde_t.nmdeld, 
   nmdeld_desc LIKE type_t.chr500, 
   glab005 LIKE type_t.chr500, 
   glab005_desc LIKE type_t.chr500, 
   nmde106_desc LIKE type_t.num20_6, 
   nmde006 LIKE nmde_t.nmde006, 
   nmde006_desc LIKE type_t.chr500, 
   nmde007 LIKE nmde_t.nmde007, 
   nmde007_desc LIKE type_t.chr500, 
   nmde005 LIKE nmde_t.nmde005, 
   nmde005_desc LIKE type_t.chr500, 
   nmde010 LIKE nmde_t.nmde010, 
   nmde010_desc LIKE type_t.chr500, 
   nmde013 LIKE nmde_t.nmde013, 
   nmde013_desc LIKE type_t.chr500, 
   nmde014 LIKE nmde_t.nmde014, 
   nmde014_desc LIKE type_t.chr500, 
   glaq029 LIKE type_t.chr500, 
   glaq029_desc LIKE type_t.chr500, 
   glaq030 LIKE type_t.chr500, 
   glaq030_desc LIKE type_t.chr500, 
   glaq031 LIKE type_t.chr500, 
   glaq031_desc LIKE type_t.chr500, 
   glaq032 LIKE type_t.chr500, 
   glaq032_desc LIKE type_t.chr500, 
   glaq033 LIKE type_t.chr500, 
   glaq033_desc LIKE type_t.chr500, 
   glaq034 LIKE type_t.chr500, 
   glaq034_desc LIKE type_t.chr500, 
   glaq035 LIKE type_t.chr500, 
   glaq035_desc LIKE type_t.chr500, 
   glaq036 LIKE type_t.chr500, 
   glaq036_desc LIKE type_t.chr500, 
   glaq037 LIKE type_t.chr500, 
   glaq037_desc LIKE type_t.chr500, 
   glaq038 LIKE type_t.chr500, 
   glaq038_desc LIKE type_t.chr500
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glae009            LIKE glae_t.glae009
DEFINE g_glae002            LIKE glae_t.glae002
DEFINE g_nmdeld             LIKE nmde_t.nmdeld
DEFINE g_nmde001            LIKE nmde_t.nmde001
DEFINE g_nmde002            LIKE nmde_t.nmde002
#161212-00005#2---modify-----begin-------------
#DEFINE g_glad               RECORD LIKE glad_t.*
DEFINE g_glad RECORD  #帳套科目管理設定檔
       gladent LIKE glad_t.gladent, #企業編號
       gladownid LIKE glad_t.gladownid, #資料所有者
       gladowndp LIKE glad_t.gladowndp, #資料所屬部門
       gladcrtid LIKE glad_t.gladcrtid, #資料建立者
       gladcrtdp LIKE glad_t.gladcrtdp, #資料建立部門
       gladcrtdt LIKE glad_t.gladcrtdt, #資料創建日
       gladmodid LIKE glad_t.gladmodid, #資料修改者
       gladmoddt LIKE glad_t.gladmoddt, #最近修改日
       gladstus LIKE glad_t.gladstus, #狀態碼
       gladld LIKE glad_t.gladld, #帳套
       glad001 LIKE glad_t.glad001, #會計科目編號
       glad002 LIKE glad_t.glad002, #是否按餘額類型產生分錄
       glad003 LIKE glad_t.glad003, #啟用傳票項次細項立沖
       glad004 LIKE glad_t.glad004, #傳票項次異動別
       glad005 LIKE glad_t.glad005, #是否啟用數量金額式
       glad006 LIKE glad_t.glad006, #借方現金變動碼
       glad007 LIKE glad_t.glad007, #啟用部門管理
       glad008 LIKE glad_t.glad008, #啟用利潤成本管理
       glad009 LIKE glad_t.glad009, #啟用區域管理
       glad010 LIKE glad_t.glad010, #啟用收付款客商管理
       glad011 LIKE glad_t.glad011, #啟用客群管理
       glad012 LIKE glad_t.glad012, #啟用產品類別管理
       glad013 LIKE glad_t.glad013, #啟用人員管理
       glad014 LIKE glad_t.glad014, #no use
       glad015 LIKE glad_t.glad015, #啟用專案管理
       glad016 LIKE glad_t.glad016, #啟用WBS管理
       glad017 LIKE glad_t.glad017, #啟用自由核算項一
       glad0171 LIKE glad_t.glad0171, #自由核算項一類型編號
       glad0172 LIKE glad_t.glad0172, #自由核算項一控制方式
       glad018 LIKE glad_t.glad018, #啟用自由核算項二
       glad0181 LIKE glad_t.glad0181, #自由核算項二類型編號
       glad0182 LIKE glad_t.glad0182, #自由核算項二控制方式
       glad019 LIKE glad_t.glad019, #啟用自由核算項三
       glad0191 LIKE glad_t.glad0191, #自由核算項三類型編號
       glad0192 LIKE glad_t.glad0192, #自由核算項三控制方式
       glad020 LIKE glad_t.glad020, #啟用自由核算項四
       glad0201 LIKE glad_t.glad0201, #自由核算項四類型編號
       glad0202 LIKE glad_t.glad0202, #自由核算項四控制方式
       glad021 LIKE glad_t.glad021, #啟用自由核算項五
       glad0211 LIKE glad_t.glad0211, #自由核算項五類型編號
       glad0212 LIKE glad_t.glad0212, #自由核算項五控制方式
       glad022 LIKE glad_t.glad022, #啟用自由核算項六
       glad0221 LIKE glad_t.glad0221, #自由核算項六類型編號
       glad0222 LIKE glad_t.glad0222, #自由核算項六控制方式
       glad023 LIKE glad_t.glad023, #啟用自由核算項七
       glad0231 LIKE glad_t.glad0231, #自由核算項七類型編號
       glad0232 LIKE glad_t.glad0232, #自由核算項七控制方式
       glad024 LIKE glad_t.glad024, #啟用自由核算項八
       glad0241 LIKE glad_t.glad0241, #自由核算項八類型編號
       glad0242 LIKE glad_t.glad0242, #自由核算項八控制方式
       glad025 LIKE glad_t.glad025, #啟用自由核算項九
       glad0251 LIKE glad_t.glad0251, #自由核算項九類型編號
       glad0252 LIKE glad_t.glad0252, #自由核算項九控制方式
       glad026 LIKE glad_t.glad026, #啟用自由核算項十
       glad0261 LIKE glad_t.glad0261, #自由核算項十類型編號
       glad0262 LIKE glad_t.glad0262, #自由核算項十控制方式
       glad027 LIKE glad_t.glad027, #啟用帳款客商管理
       glad030 LIKE glad_t.glad030, #是否進行預算管控
       glad031 LIKE glad_t.glad031, #啟用經營方式管理
       glad032 LIKE glad_t.glad032, #啟用通路管理
       glad033 LIKE glad_t.glad033, #啟用品牌管理
       glad034 LIKE glad_t.glad034, #科目做多幣別管理
       gladud001 LIKE glad_t.gladud001, #自定義欄位(文字)001
       gladud002 LIKE glad_t.gladud002, #自定義欄位(文字)002
       gladud003 LIKE glad_t.gladud003, #自定義欄位(文字)003
       gladud004 LIKE glad_t.gladud004, #自定義欄位(文字)004
       gladud005 LIKE glad_t.gladud005, #自定義欄位(文字)005
       gladud006 LIKE glad_t.gladud006, #自定義欄位(文字)006
       gladud007 LIKE glad_t.gladud007, #自定義欄位(文字)007
       gladud008 LIKE glad_t.gladud008, #自定義欄位(文字)008
       gladud009 LIKE glad_t.gladud009, #自定義欄位(文字)009
       gladud010 LIKE glad_t.gladud010, #自定義欄位(文字)010
       gladud011 LIKE glad_t.gladud011, #自定義欄位(數字)011
       gladud012 LIKE glad_t.gladud012, #自定義欄位(數字)012
       gladud013 LIKE glad_t.gladud013, #自定義欄位(數字)013
       gladud014 LIKE glad_t.gladud014, #自定義欄位(數字)014
       gladud015 LIKE glad_t.gladud015, #自定義欄位(數字)015
       gladud016 LIKE glad_t.gladud016, #自定義欄位(數字)016
       gladud017 LIKE glad_t.gladud017, #自定義欄位(數字)017
       gladud018 LIKE glad_t.gladud018, #自定義欄位(數字)018
       gladud019 LIKE glad_t.gladud019, #自定義欄位(數字)019
       gladud020 LIKE glad_t.gladud020, #自定義欄位(數字)020
       gladud021 LIKE glad_t.gladud021, #自定義欄位(日期時間)021
       gladud022 LIKE glad_t.gladud022, #自定義欄位(日期時間)022
       gladud023 LIKE glad_t.gladud023, #自定義欄位(日期時間)023
       gladud024 LIKE glad_t.gladud024, #自定義欄位(日期時間)024
       gladud025 LIKE glad_t.gladud025, #自定義欄位(日期時間)025
       gladud026 LIKE glad_t.gladud026, #自定義欄位(日期時間)026
       gladud027 LIKE glad_t.gladud027, #自定義欄位(日期時間)027
       gladud028 LIKE glad_t.gladud028, #自定義欄位(日期時間)028
       gladud029 LIKE glad_t.gladud029, #自定義欄位(日期時間)029
       gladud030 LIKE glad_t.gladud030, #自定義欄位(日期時間)030
       glad035 LIKE glad_t.glad035, #是否是子系統科目
       glad036 LIKE glad_t.glad036  #貸方現金變動碼
       END RECORD
#161212-00005#2---modify-----bend-------------
#end add-point
 
#模組變數(Module Variables)
DEFINE g_nmde_d          DYNAMIC ARRAY OF type_g_nmde_d #單身變數
DEFINE g_nmde_d_t        type_g_nmde_d                  #單身備份
DEFINE g_nmde_d_o        type_g_nmde_d                  #單身備份
DEFINE g_nmde_d_mask_o   DYNAMIC ARRAY OF type_g_nmde_d #單身變數
DEFINE g_nmde_d_mask_n   DYNAMIC ARRAY OF type_g_nmde_d #單身變數
 
      
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

#end add-point
 
{</section>}
 
{<section id="anmt820_02.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION anmt820_02(--)
   #add-point:main段變數傳入 name="main.get_var"
   p_nmdeld,p_nmde001,p_nmde002 
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE p_nmdeld   LIKE nmde_t.nmdeld   #帳套
   DEFINE p_nmde001  LIKE nmde_t.nmde001  #年度
   DEFINE p_nmde002  LIKE nmde_t.nmde002  #期別 
   DEFINE l_8318_11       LIKE gzcb_t.gzcb002      #重評價匯兌收益科目
   DEFINE l_8318_12       LIKE gzcb_t.gzcb002      #重評價匯兌損失科目
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化 name="main.init"
   LET g_nmdeld  = p_nmdeld
   LET g_nmde001  = p_nmde001
   LET g_nmde002  = p_nmde002
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
   
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT nmde001,nmde002,nmde004,nmdeld,nmde006,nmde007,nmde005,nmde010,nmde013, 
       nmde014 FROM nmde_t WHERE nmdeent=? AND nmdeld=? AND nmde001=? AND nmde002=? AND nmde004=? FOR  
       UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmt820_02_bcl CURSOR FROM g_forupd_sql
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_anmt820_02 WITH FORM cl_ap_formpath("anm","anmt820_02")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL anmt820_02_init()   
 
   #進入選單 Menu (="N")
   CALL anmt820_02_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_anmt820_02
 
   
   
 
   #add-point:離開前 name="main.exit"
   
   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmt820_02.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION anmt820_02_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_act_visible("query",FALSE)
   CALL cl_set_act_visible("insert",FALSE)
   #end add-point
   
   CALL anmt820_02_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="anmt820_02.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION anmt820_02_ui_dialog()
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
         CALL g_nmde_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL anmt820_02_init()
      END IF
   
      CALL anmt820_02_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_nmde_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display  name="ui_dialog.body.before_display"
               
               #end add-point
               #讓各頁籤能夠同步指到特定資料
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2 name="ui_dialog.body.before_display2"
               
               #end add-point
               
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL anmt820_02_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
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
            CALL cl_set_act_visible("logistics,insert,delete,modify,output,reproduce,query", FALSE) #150729-00002#1 隱藏ACTION
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL anmt820_02_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL anmt820_02_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL anmt820_02_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL anmt820_02_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
 
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL anmt820_02_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL anmt820_02_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL anmt820_02_insert()
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
               CALL anmt820_02_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_nmde_d)
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
            CALL anmt820_02_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL anmt820_02_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL anmt820_02_set_pk_array()
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
         LET g_action_choice = ""
         #end add-point
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="anmt820_02.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION anmt820_02_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_nmde_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON nmde001,nmde002,nmde004,nmdeld,glab005,glab005_desc,nmde106_desc,nmde006,nmde006_desc, 
          nmde007,nmde007_desc,nmde005,nmde005_desc,nmde010,nmde010_desc,nmde013,nmde013_desc,nmde014, 
          nmde014_desc,glaq029,glaq029_desc,glaq030,glaq030_desc,glaq031,glaq031_desc,glaq032,glaq032_desc, 
          glaq033,glaq033_desc,glaq034,glaq034_desc,glaq035,glaq035_desc,glaq036,glaq036_desc,glaq037, 
          glaq037_desc,glaq038,glaq038_desc 
 
         FROM s_detail1[1].nmde001,s_detail1[1].nmde002,s_detail1[1].nmde004,s_detail1[1].nmdeld,s_detail1[1].glab005, 
             s_detail1[1].glab005_desc,s_detail1[1].nmde106_desc,s_detail1[1].nmde006,s_detail1[1].nmde006_desc, 
             s_detail1[1].nmde007,s_detail1[1].nmde007_desc,s_detail1[1].nmde005,s_detail1[1].nmde005_desc, 
             s_detail1[1].nmde010,s_detail1[1].nmde010_desc,s_detail1[1].nmde013,s_detail1[1].nmde013_desc, 
             s_detail1[1].nmde014,s_detail1[1].nmde014_desc,s_detail1[1].glaq029,s_detail1[1].glaq029_desc, 
             s_detail1[1].glaq030,s_detail1[1].glaq030_desc,s_detail1[1].glaq031,s_detail1[1].glaq031_desc, 
             s_detail1[1].glaq032,s_detail1[1].glaq032_desc,s_detail1[1].glaq033,s_detail1[1].glaq033_desc, 
             s_detail1[1].glaq034,s_detail1[1].glaq034_desc,s_detail1[1].glaq035,s_detail1[1].glaq035_desc, 
             s_detail1[1].glaq036,s_detail1[1].glaq036_desc,s_detail1[1].glaq037,s_detail1[1].glaq037_desc, 
             s_detail1[1].glaq038,s_detail1[1].glaq038_desc 
      
         
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde001
            #add-point:BEFORE FIELD nmde001 name="query.b.page1.nmde001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde001
            
            #add-point:AFTER FIELD nmde001 name="query.a.page1.nmde001"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.nmde001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde001
            #add-point:ON ACTION controlp INFIELD nmde001 name="query.c.page1.nmde001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde002
            #add-point:BEFORE FIELD nmde002 name="query.b.page1.nmde002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde002
            
            #add-point:AFTER FIELD nmde002 name="query.a.page1.nmde002"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.nmde002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde002
            #add-point:ON ACTION controlp INFIELD nmde002 name="query.c.page1.nmde002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde004
            #add-point:BEFORE FIELD nmde004 name="query.b.page1.nmde004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde004
            
            #add-point:AFTER FIELD nmde004 name="query.a.page1.nmde004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.nmde004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde004
            #add-point:ON ACTION controlp INFIELD nmde004 name="query.c.page1.nmde004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdeld
            #add-point:BEFORE FIELD nmdeld name="query.b.page1.nmdeld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdeld
            
            #add-point:AFTER FIELD nmdeld name="query.a.page1.nmdeld"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.nmdeld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdeld
            #add-point:ON ACTION controlp INFIELD nmdeld name="query.c.page1.nmdeld"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.glab005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab005
            #add-point:ON ACTION controlp INFIELD glab005 name="construct.c.page1.glab005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_glac002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glab005  #顯示到畫面上
            NEXT FIELD glab005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab005
            #add-point:BEFORE FIELD glab005 name="query.b.page1.glab005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab005
            
            #add-point:AFTER FIELD glab005 name="query.a.page1.glab005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab005_desc
            #add-point:BEFORE FIELD glab005_desc name="query.b.page1.glab005_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab005_desc
            
            #add-point:AFTER FIELD glab005_desc name="query.a.page1.glab005_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glab005_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab005_desc
            #add-point:ON ACTION controlp INFIELD glab005_desc name="query.c.page1.glab005_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde106_desc
            #add-point:BEFORE FIELD nmde106_desc name="query.b.page1.nmde106_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde106_desc
            
            #add-point:AFTER FIELD nmde106_desc name="query.a.page1.nmde106_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.nmde106_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde106_desc
            #add-point:ON ACTION controlp INFIELD nmde106_desc name="query.c.page1.nmde106_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde006
            #add-point:BEFORE FIELD nmde006 name="query.b.page1.nmde006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde006
            
            #add-point:AFTER FIELD nmde006 name="query.a.page1.nmde006"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.nmde006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde006
            #add-point:ON ACTION controlp INFIELD nmde006 name="query.c.page1.nmde006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde006_desc
            #add-point:BEFORE FIELD nmde006_desc name="query.b.page1.nmde006_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde006_desc
            
            #add-point:AFTER FIELD nmde006_desc name="query.a.page1.nmde006_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.nmde006_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde006_desc
            #add-point:ON ACTION controlp INFIELD nmde006_desc name="query.c.page1.nmde006_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde007
            #add-point:BEFORE FIELD nmde007 name="query.b.page1.nmde007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde007
            
            #add-point:AFTER FIELD nmde007 name="query.a.page1.nmde007"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.nmde007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde007
            #add-point:ON ACTION controlp INFIELD nmde007 name="query.c.page1.nmde007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde007_desc
            #add-point:BEFORE FIELD nmde007_desc name="query.b.page1.nmde007_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde007_desc
            
            #add-point:AFTER FIELD nmde007_desc name="query.a.page1.nmde007_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.nmde007_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde007_desc
            #add-point:ON ACTION controlp INFIELD nmde007_desc name="query.c.page1.nmde007_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde005
            #add-point:BEFORE FIELD nmde005 name="query.b.page1.nmde005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde005
            
            #add-point:AFTER FIELD nmde005 name="query.a.page1.nmde005"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.nmde005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde005
            #add-point:ON ACTION controlp INFIELD nmde005 name="query.c.page1.nmde005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde005_desc
            #add-point:BEFORE FIELD nmde005_desc name="query.b.page1.nmde005_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde005_desc
            
            #add-point:AFTER FIELD nmde005_desc name="query.a.page1.nmde005_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.nmde005_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde005_desc
            #add-point:ON ACTION controlp INFIELD nmde005_desc name="query.c.page1.nmde005_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde010
            #add-point:BEFORE FIELD nmde010 name="query.b.page1.nmde010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde010
            
            #add-point:AFTER FIELD nmde010 name="query.a.page1.nmde010"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.nmde010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde010
            #add-point:ON ACTION controlp INFIELD nmde010 name="query.c.page1.nmde010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde010_desc
            #add-point:BEFORE FIELD nmde010_desc name="query.b.page1.nmde010_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde010_desc
            
            #add-point:AFTER FIELD nmde010_desc name="query.a.page1.nmde010_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.nmde010_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde010_desc
            #add-point:ON ACTION controlp INFIELD nmde010_desc name="query.c.page1.nmde010_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde013
            #add-point:BEFORE FIELD nmde013 name="query.b.page1.nmde013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde013
            
            #add-point:AFTER FIELD nmde013 name="query.a.page1.nmde013"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.nmde013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde013
            #add-point:ON ACTION controlp INFIELD nmde013 name="query.c.page1.nmde013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde013_desc
            #add-point:BEFORE FIELD nmde013_desc name="query.b.page1.nmde013_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde013_desc
            
            #add-point:AFTER FIELD nmde013_desc name="query.a.page1.nmde013_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.nmde013_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde013_desc
            #add-point:ON ACTION controlp INFIELD nmde013_desc name="query.c.page1.nmde013_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde014
            #add-point:BEFORE FIELD nmde014 name="query.b.page1.nmde014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde014
            
            #add-point:AFTER FIELD nmde014 name="query.a.page1.nmde014"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.nmde014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde014
            #add-point:ON ACTION controlp INFIELD nmde014 name="query.c.page1.nmde014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde014_desc
            #add-point:BEFORE FIELD nmde014_desc name="query.b.page1.nmde014_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde014_desc
            
            #add-point:AFTER FIELD nmde014_desc name="query.a.page1.nmde014_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.nmde014_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde014_desc
            #add-point:ON ACTION controlp INFIELD nmde014_desc name="query.c.page1.nmde014_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq029
            #add-point:BEFORE FIELD glaq029 name="query.b.page1.glaq029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq029
            
            #add-point:AFTER FIELD glaq029 name="query.a.page1.glaq029"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq029
            #add-point:ON ACTION controlp INFIELD glaq029 name="query.c.page1.glaq029"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq029_desc
            #add-point:BEFORE FIELD glaq029_desc name="query.b.page1.glaq029_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq029_desc
            
            #add-point:AFTER FIELD glaq029_desc name="query.a.page1.glaq029_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq029_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq029_desc
            #add-point:ON ACTION controlp INFIELD glaq029_desc name="query.c.page1.glaq029_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq030
            #add-point:BEFORE FIELD glaq030 name="query.b.page1.glaq030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq030
            
            #add-point:AFTER FIELD glaq030 name="query.a.page1.glaq030"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq030
            #add-point:ON ACTION controlp INFIELD glaq030 name="query.c.page1.glaq030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq030_desc
            #add-point:BEFORE FIELD glaq030_desc name="query.b.page1.glaq030_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq030_desc
            
            #add-point:AFTER FIELD glaq030_desc name="query.a.page1.glaq030_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq030_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq030_desc
            #add-point:ON ACTION controlp INFIELD glaq030_desc name="query.c.page1.glaq030_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq031
            #add-point:BEFORE FIELD glaq031 name="query.b.page1.glaq031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq031
            
            #add-point:AFTER FIELD glaq031 name="query.a.page1.glaq031"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq031
            #add-point:ON ACTION controlp INFIELD glaq031 name="query.c.page1.glaq031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq031_desc
            #add-point:BEFORE FIELD glaq031_desc name="query.b.page1.glaq031_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq031_desc
            
            #add-point:AFTER FIELD glaq031_desc name="query.a.page1.glaq031_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq031_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq031_desc
            #add-point:ON ACTION controlp INFIELD glaq031_desc name="query.c.page1.glaq031_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq032
            #add-point:BEFORE FIELD glaq032 name="query.b.page1.glaq032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq032
            
            #add-point:AFTER FIELD glaq032 name="query.a.page1.glaq032"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq032
            #add-point:ON ACTION controlp INFIELD glaq032 name="query.c.page1.glaq032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq032_desc
            #add-point:BEFORE FIELD glaq032_desc name="query.b.page1.glaq032_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq032_desc
            
            #add-point:AFTER FIELD glaq032_desc name="query.a.page1.glaq032_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq032_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq032_desc
            #add-point:ON ACTION controlp INFIELD glaq032_desc name="query.c.page1.glaq032_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq033
            #add-point:BEFORE FIELD glaq033 name="query.b.page1.glaq033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq033
            
            #add-point:AFTER FIELD glaq033 name="query.a.page1.glaq033"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq033
            #add-point:ON ACTION controlp INFIELD glaq033 name="query.c.page1.glaq033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq033_desc
            #add-point:BEFORE FIELD glaq033_desc name="query.b.page1.glaq033_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq033_desc
            
            #add-point:AFTER FIELD glaq033_desc name="query.a.page1.glaq033_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq033_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq033_desc
            #add-point:ON ACTION controlp INFIELD glaq033_desc name="query.c.page1.glaq033_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq034
            #add-point:BEFORE FIELD glaq034 name="query.b.page1.glaq034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq034
            
            #add-point:AFTER FIELD glaq034 name="query.a.page1.glaq034"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq034
            #add-point:ON ACTION controlp INFIELD glaq034 name="query.c.page1.glaq034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq034_desc
            #add-point:BEFORE FIELD glaq034_desc name="query.b.page1.glaq034_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq034_desc
            
            #add-point:AFTER FIELD glaq034_desc name="query.a.page1.glaq034_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq034_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq034_desc
            #add-point:ON ACTION controlp INFIELD glaq034_desc name="query.c.page1.glaq034_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq035
            #add-point:BEFORE FIELD glaq035 name="query.b.page1.glaq035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq035
            
            #add-point:AFTER FIELD glaq035 name="query.a.page1.glaq035"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq035
            #add-point:ON ACTION controlp INFIELD glaq035 name="query.c.page1.glaq035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq035_desc
            #add-point:BEFORE FIELD glaq035_desc name="query.b.page1.glaq035_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq035_desc
            
            #add-point:AFTER FIELD glaq035_desc name="query.a.page1.glaq035_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq035_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq035_desc
            #add-point:ON ACTION controlp INFIELD glaq035_desc name="query.c.page1.glaq035_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq036
            #add-point:BEFORE FIELD glaq036 name="query.b.page1.glaq036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq036
            
            #add-point:AFTER FIELD glaq036 name="query.a.page1.glaq036"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq036
            #add-point:ON ACTION controlp INFIELD glaq036 name="query.c.page1.glaq036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq036_desc
            #add-point:BEFORE FIELD glaq036_desc name="query.b.page1.glaq036_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq036_desc
            
            #add-point:AFTER FIELD glaq036_desc name="query.a.page1.glaq036_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq036_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq036_desc
            #add-point:ON ACTION controlp INFIELD glaq036_desc name="query.c.page1.glaq036_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq037
            #add-point:BEFORE FIELD glaq037 name="query.b.page1.glaq037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq037
            
            #add-point:AFTER FIELD glaq037 name="query.a.page1.glaq037"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq037
            #add-point:ON ACTION controlp INFIELD glaq037 name="query.c.page1.glaq037"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq037_desc
            #add-point:BEFORE FIELD glaq037_desc name="query.b.page1.glaq037_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq037_desc
            
            #add-point:AFTER FIELD glaq037_desc name="query.a.page1.glaq037_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq037_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq037_desc
            #add-point:ON ACTION controlp INFIELD glaq037_desc name="query.c.page1.glaq037_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq038
            #add-point:BEFORE FIELD glaq038 name="query.b.page1.glaq038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq038
            
            #add-point:AFTER FIELD glaq038 name="query.a.page1.glaq038"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq038
            #add-point:ON ACTION controlp INFIELD glaq038 name="query.c.page1.glaq038"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq038_desc
            #add-point:BEFORE FIELD glaq038_desc name="query.b.page1.glaq038_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq038_desc
            
            #add-point:AFTER FIELD glaq038_desc name="query.a.page1.glaq038_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq038_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq038_desc
            #add-point:ON ACTION controlp INFIELD glaq038_desc name="query.c.page1.glaq038_desc"
            
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
    
   CALL anmt820_02_b_fill(g_wc2)
 
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
 
{<section id="anmt820_02.insert" >}
#+ 資料新增
PRIVATE FUNCTION anmt820_02_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL anmt820_02_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmt820_02.modify" >}
#+ 資料修改
PRIVATE FUNCTION anmt820_02_modify()
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
   DEFINE  l_errno                LIKE type_t.chr10
   DEFINE  l_glaa004              LIKE glaa_t.glaa004
   #end add-point 
   
   #add-point:Function前置處理  name="modify.pre_function"
   CALL anmt820_02_modify_1()  #160627-00016#1
   RETURN                      #160627-00016#1
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
      INPUT ARRAY g_nmde_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_nmde_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL anmt820_02_b_fill(g_wc2)
            LET g_detail_cnt = g_nmde_d.getLength()
         
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
            DISPLAY g_nmde_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_nmde_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_nmde_d[l_ac].nmdeld IS NOT NULL
               AND g_nmde_d[l_ac].nmde001 IS NOT NULL
               AND g_nmde_d[l_ac].nmde002 IS NOT NULL
               AND g_nmde_d[l_ac].nmde004 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_nmde_d_t.* = g_nmde_d[l_ac].*  #BACKUP
               LET g_nmde_d_o.* = g_nmde_d[l_ac].*  #BACKUP
               IF NOT anmt820_02_lock_b("nmde_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH anmt820_02_bcl INTO g_nmde_d[l_ac].nmde001,g_nmde_d[l_ac].nmde002,g_nmde_d[l_ac].nmde004, 
                      g_nmde_d[l_ac].nmdeld,g_nmde_d[l_ac].nmde006,g_nmde_d[l_ac].nmde007,g_nmde_d[l_ac].nmde005, 
                      g_nmde_d[l_ac].nmde010,g_nmde_d[l_ac].nmde013,g_nmde_d[l_ac].nmde014
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_nmde_d_t.nmdeld,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_nmde_d_mask_o[l_ac].* =  g_nmde_d[l_ac].*
                  CALL anmt820_02_nmde_t_mask()
                  LET g_nmde_d_mask_n[l_ac].* =  g_nmde_d[l_ac].*
                  
                  CALL anmt820_02_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL anmt820_02_set_entry_b(l_cmd)
            CALL anmt820_02_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
#            IF g_detail_cnt >= l_ac AND g_nmde_d[l_ac].glaq005 IS NOT NULL THEN
#               LET l_cmd='u'
#               LET g_nmde_d_t.* = g_nmde_d[l_ac].*  #BACKUP
#               SELECT * INTO g_glad.* FROM glad_t
#                WHERE gladent = g_enterprise AND gladld  = g_nmdeld 
#                  AND glad001 = g_nmde_d[l_ac].glaq005
#            ELSE
#               RETURN
#            END IF
            #160627-00016#1 add s---
            IF g_detail_cnt >= l_ac AND g_nmde_d[l_ac].glab005 IS NOT NULL THEN
               LET l_cmd='u'
               LET g_nmde_d_t.* = g_nmde_d[l_ac].*  #BACKUP
            ELSE
               RETURN
            END IF
            #160627-00016#1 add e---
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
            INITIALIZE g_nmde_d_t.* TO NULL
            INITIALIZE g_nmde_d_o.* TO NULL
            INITIALIZE g_nmde_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值(單身1)
            
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_nmde_d_t.* = g_nmde_d[l_ac].*     #新輸入資料
            LET g_nmde_d_o.* = g_nmde_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_nmde_d[li_reproduce_target].* = g_nmde_d[li_reproduce].*
 
               LET g_nmde_d[g_nmde_d.getLength()].nmdeld = NULL
               LET g_nmde_d[g_nmde_d.getLength()].nmde001 = NULL
               LET g_nmde_d[g_nmde_d.getLength()].nmde002 = NULL
               LET g_nmde_d[g_nmde_d.getLength()].nmde004 = NULL
 
            END IF
            
 
            CALL anmt820_02_set_entry_b(l_cmd)
            CALL anmt820_02_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body.before_insert"
            #150729-00002#1-----s
            #將傳入參數給到陣列中
            LET g_nmde_d[l_ac].nmdeld = g_nmdeld
            LET g_nmde_d[l_ac].nmde001 = g_nmde001
            LET g_nmde_d[l_ac].nmde002 = g_nmde002
            #150729-00002#1-----e
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
            SELECT COUNT(1) INTO l_count FROM nmde_t 
             WHERE nmdeent = g_enterprise AND nmdeld = g_nmde_d[l_ac].nmdeld
                                       AND nmde001 = g_nmde_d[l_ac].nmde001
                                       AND nmde002 = g_nmde_d[l_ac].nmde002
                                       AND nmde004 = g_nmde_d[l_ac].nmde004
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmde_d[g_detail_idx].nmdeld
               LET gs_keys[2] = g_nmde_d[g_detail_idx].nmde001
               LET gs_keys[3] = g_nmde_d[g_detail_idx].nmde002
               LET gs_keys[4] = g_nmde_d[g_detail_idx].nmde004
               CALL anmt820_02_insert_b('nmde_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_nmde_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "nmde_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL anmt820_02_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (nmdeld = '", g_nmde_d[l_ac].nmdeld, "' "
                                  ," AND nmde001 = '", g_nmde_d[l_ac].nmde001, "' "
                                  ," AND nmde002 = '", g_nmde_d[l_ac].nmde002, "' "
                                  ," AND nmde004 = '", g_nmde_d[l_ac].nmde004, "' "
 
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
               
               DELETE FROM nmde_t
                WHERE nmdeent = g_enterprise AND 
                      nmdeld = g_nmde_d_t.nmdeld
                      AND nmde001 = g_nmde_d_t.nmde001
                      AND nmde002 = g_nmde_d_t.nmde002
                      AND nmde004 = g_nmde_d_t.nmde004
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "nmde_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL anmt820_02_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_nmde_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE anmt820_02_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_nmde_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmde_d_t.nmdeld
               LET gs_keys[2] = g_nmde_d_t.nmde001
               LET gs_keys[3] = g_nmde_d_t.nmde002
               LET gs_keys[4] = g_nmde_d_t.nmde004
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL anmt820_02_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL anmt820_02_delete_b('nmde_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_nmde_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde001
            #add-point:BEFORE FIELD nmde001 name="input.b.page1.nmde001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde001
            
            #add-point:AFTER FIELD nmde001 name="input.a.page1.nmde001"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_nmde_d[g_detail_idx].nmdeld IS NOT NULL AND g_nmde_d[g_detail_idx].nmde001 IS NOT NULL AND g_nmde_d[g_detail_idx].nmde002 IS NOT NULL AND g_nmde_d[g_detail_idx].nmde004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_nmde_d[g_detail_idx].nmdeld != g_nmde_d_t.nmdeld OR g_nmde_d[g_detail_idx].nmde001 != g_nmde_d_t.nmde001 OR g_nmde_d[g_detail_idx].nmde002 != g_nmde_d_t.nmde002 OR g_nmde_d[g_detail_idx].nmde004 != g_nmde_d_t.nmde004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmde_t WHERE "||"nmdeent = '" ||g_enterprise|| "' AND "||"nmdeld = '"||g_nmde_d[g_detail_idx].nmdeld ||"' AND "|| "nmde001 = '"||g_nmde_d[g_detail_idx].nmde001 ||"' AND "|| "nmde002 = '"||g_nmde_d[g_detail_idx].nmde002 ||"' AND "|| "nmde004 = '"||g_nmde_d[g_detail_idx].nmde004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde001
            #add-point:ON CHANGE nmde001 name="input.g.page1.nmde001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde002
            #add-point:BEFORE FIELD nmde002 name="input.b.page1.nmde002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde002
            
            #add-point:AFTER FIELD nmde002 name="input.a.page1.nmde002"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_nmde_d[g_detail_idx].nmdeld IS NOT NULL AND g_nmde_d[g_detail_idx].nmde001 IS NOT NULL AND g_nmde_d[g_detail_idx].nmde002 IS NOT NULL AND g_nmde_d[g_detail_idx].nmde004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_nmde_d[g_detail_idx].nmdeld != g_nmde_d_t.nmdeld OR g_nmde_d[g_detail_idx].nmde001 != g_nmde_d_t.nmde001 OR g_nmde_d[g_detail_idx].nmde002 != g_nmde_d_t.nmde002 OR g_nmde_d[g_detail_idx].nmde004 != g_nmde_d_t.nmde004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmde_t WHERE "||"nmdeent = '" ||g_enterprise|| "' AND "||"nmdeld = '"||g_nmde_d[g_detail_idx].nmdeld ||"' AND "|| "nmde001 = '"||g_nmde_d[g_detail_idx].nmde001 ||"' AND "|| "nmde002 = '"||g_nmde_d[g_detail_idx].nmde002 ||"' AND "|| "nmde004 = '"||g_nmde_d[g_detail_idx].nmde004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde002
            #add-point:ON CHANGE nmde002 name="input.g.page1.nmde002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde004
            #add-point:BEFORE FIELD nmde004 name="input.b.page1.nmde004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde004
            
            #add-point:AFTER FIELD nmde004 name="input.a.page1.nmde004"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_nmde_d[g_detail_idx].nmdeld IS NOT NULL AND g_nmde_d[g_detail_idx].nmde001 IS NOT NULL AND g_nmde_d[g_detail_idx].nmde002 IS NOT NULL AND g_nmde_d[g_detail_idx].nmde004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_nmde_d[g_detail_idx].nmdeld != g_nmde_d_t.nmdeld OR g_nmde_d[g_detail_idx].nmde001 != g_nmde_d_t.nmde001 OR g_nmde_d[g_detail_idx].nmde002 != g_nmde_d_t.nmde002 OR g_nmde_d[g_detail_idx].nmde004 != g_nmde_d_t.nmde004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmde_t WHERE "||"nmdeent = '" ||g_enterprise|| "' AND "||"nmdeld = '"||g_nmde_d[g_detail_idx].nmdeld ||"' AND "|| "nmde001 = '"||g_nmde_d[g_detail_idx].nmde001 ||"' AND "|| "nmde002 = '"||g_nmde_d[g_detail_idx].nmde002 ||"' AND "|| "nmde004 = '"||g_nmde_d[g_detail_idx].nmde004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde004
            #add-point:ON CHANGE nmde004 name="input.g.page1.nmde004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdeld
            
            #add-point:AFTER FIELD nmdeld name="input.a.page1.nmdeld"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_nmde_d[g_detail_idx].nmdeld IS NOT NULL AND g_nmde_d[g_detail_idx].nmde001 IS NOT NULL AND g_nmde_d[g_detail_idx].nmde002 IS NOT NULL AND g_nmde_d[g_detail_idx].nmde004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_nmde_d[g_detail_idx].nmdeld != g_nmde_d_t.nmdeld OR g_nmde_d[g_detail_idx].nmde001 != g_nmde_d_t.nmde001 OR g_nmde_d[g_detail_idx].nmde002 != g_nmde_d_t.nmde002 OR g_nmde_d[g_detail_idx].nmde004 != g_nmde_d_t.nmde004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmde_t WHERE "||"nmdeent = '" ||g_enterprise|| "' AND "||"nmdeld = '"||g_nmde_d[g_detail_idx].nmdeld ||"' AND "|| "nmde001 = '"||g_nmde_d[g_detail_idx].nmde001 ||"' AND "|| "nmde002 = '"||g_nmde_d[g_detail_idx].nmde002 ||"' AND "|| "nmde004 = '"||g_nmde_d[g_detail_idx].nmde004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmde_d[l_ac].nmdeld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_nmde_d[l_ac].nmdeld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmde_d[l_ac].nmdeld_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdeld
            #add-point:BEFORE FIELD nmdeld name="input.b.page1.nmdeld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmdeld
            #add-point:ON CHANGE nmdeld name="input.g.page1.nmdeld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab005
            
            #add-point:AFTER FIELD glab005 name="input.a.page1.glab005"
            IF NOT cl_null(g_nmde_d[l_ac].glab005) THEN 
            
            # 开窗模糊查询 150916-00015#1 --add                      
               IF s_aglt310_getlike_lc_subject(g_nmde_d[g_detail_idx].nmdeld,g_nmde_d[l_ac].glab005,"")  THEN            
                  
                  SELECT glaa004 INTO l_glaa004
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald  = g_nmde_d[g_detail_idx].nmdeld
                  
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = 'FALSE'
                  LET g_qryparam.default1 = g_nmde_d[l_ac].glab005
                                
                  LET g_qryparam.arg1 = l_glaa004
                  LET g_qryparam.arg2 = g_nmde_d[l_ac].glab005
                  LET g_qryparam.arg3 = g_nmde_d[g_detail_idx].nmdeld
                  LET g_qryparam.arg4 = " 1"
                  CALL q_glac002_6()
                  LET  g_nmde_d[l_ac].glab005 = g_qryparam.return1                 
               END IF
               # 150916-00015#1 --end
               
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmde_d[l_ac].glab005
               LET g_chkparam.arg2 = '參數2'
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"    #160318-00025#13   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_glac002_3") THEN
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
         BEFORE FIELD glab005
            #add-point:BEFORE FIELD glab005 name="input.b.page1.glab005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab005
            #add-point:ON CHANGE glab005 name="input.g.page1.glab005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab005_desc
            #add-point:BEFORE FIELD glab005_desc name="input.b.page1.glab005_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab005_desc
            
            #add-point:AFTER FIELD glab005_desc name="input.a.page1.glab005_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab005_desc
            #add-point:ON CHANGE glab005_desc name="input.g.page1.glab005_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde106_desc
            #add-point:BEFORE FIELD nmde106_desc name="input.b.page1.nmde106_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde106_desc
            
            #add-point:AFTER FIELD nmde106_desc name="input.a.page1.nmde106_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde106_desc
            #add-point:ON CHANGE nmde106_desc name="input.g.page1.nmde106_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde006
            #add-point:BEFORE FIELD nmde006 name="input.b.page1.nmde006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde006
            
            #add-point:AFTER FIELD nmde006 name="input.a.page1.nmde006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde006
            #add-point:ON CHANGE nmde006 name="input.g.page1.nmde006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde006_desc
            #add-point:BEFORE FIELD nmde006_desc name="input.b.page1.nmde006_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde006_desc
            
            #add-point:AFTER FIELD nmde006_desc name="input.a.page1.nmde006_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde006_desc
            #add-point:ON CHANGE nmde006_desc name="input.g.page1.nmde006_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde007
            #add-point:BEFORE FIELD nmde007 name="input.b.page1.nmde007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde007
            
            #add-point:AFTER FIELD nmde007 name="input.a.page1.nmde007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde007
            #add-point:ON CHANGE nmde007 name="input.g.page1.nmde007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde007_desc
            #add-point:BEFORE FIELD nmde007_desc name="input.b.page1.nmde007_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde007_desc
            
            #add-point:AFTER FIELD nmde007_desc name="input.a.page1.nmde007_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde007_desc
            #add-point:ON CHANGE nmde007_desc name="input.g.page1.nmde007_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde005
            #add-point:BEFORE FIELD nmde005 name="input.b.page1.nmde005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde005
            
            #add-point:AFTER FIELD nmde005 name="input.a.page1.nmde005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde005
            #add-point:ON CHANGE nmde005 name="input.g.page1.nmde005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde005_desc
            #add-point:BEFORE FIELD nmde005_desc name="input.b.page1.nmde005_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde005_desc
            
            #add-point:AFTER FIELD nmde005_desc name="input.a.page1.nmde005_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde005_desc
            #add-point:ON CHANGE nmde005_desc name="input.g.page1.nmde005_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde010
            #add-point:BEFORE FIELD nmde010 name="input.b.page1.nmde010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde010
            
            #add-point:AFTER FIELD nmde010 name="input.a.page1.nmde010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde010
            #add-point:ON CHANGE nmde010 name="input.g.page1.nmde010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde010_desc
            #add-point:BEFORE FIELD nmde010_desc name="input.b.page1.nmde010_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde010_desc
            
            #add-point:AFTER FIELD nmde010_desc name="input.a.page1.nmde010_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde010_desc
            #add-point:ON CHANGE nmde010_desc name="input.g.page1.nmde010_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde013
            #add-point:BEFORE FIELD nmde013 name="input.b.page1.nmde013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde013
            
            #add-point:AFTER FIELD nmde013 name="input.a.page1.nmde013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde013
            #add-point:ON CHANGE nmde013 name="input.g.page1.nmde013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde013_desc
            #add-point:BEFORE FIELD nmde013_desc name="input.b.page1.nmde013_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde013_desc
            
            #add-point:AFTER FIELD nmde013_desc name="input.a.page1.nmde013_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde013_desc
            #add-point:ON CHANGE nmde013_desc name="input.g.page1.nmde013_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde014
            #add-point:BEFORE FIELD nmde014 name="input.b.page1.nmde014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde014
            
            #add-point:AFTER FIELD nmde014 name="input.a.page1.nmde014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde014
            #add-point:ON CHANGE nmde014 name="input.g.page1.nmde014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde014_desc
            #add-point:BEFORE FIELD nmde014_desc name="input.b.page1.nmde014_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde014_desc
            
            #add-point:AFTER FIELD nmde014_desc name="input.a.page1.nmde014_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde014_desc
            #add-point:ON CHANGE nmde014_desc name="input.g.page1.nmde014_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq029
            #add-point:BEFORE FIELD glaq029 name="input.b.page1.glaq029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq029
            
            #add-point:AFTER FIELD glaq029 name="input.a.page1.glaq029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq029
            #add-point:ON CHANGE glaq029 name="input.g.page1.glaq029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq029_desc
            #add-point:BEFORE FIELD glaq029_desc name="input.b.page1.glaq029_desc"
          LET g_nmde_d[l_ac].glaq029_desc = g_nmde_d[l_ac].glaq029
          #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
          LET g_glae002 = ''
          LET g_glae009 = ''
          SELECT glae002 INTO g_glae002 FROM glae_t WHERE glaeent = g_enterprise
             AND glae001 = g_glad.glad0171
           IF g_glae002 = '1' THEN
              SELECT glae009 INTO g_glae009 FROM glae_t WHERE glaeent = g_enterprise
                 AND glae001 = g_glad.glad0171
           END IF
           IF g_glae002 = '2' THEN LET g_glae009 = 'q_glaf002' END IF

           IF g_glae002 = '3' THEN LET g_glae009 = '' END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq029_desc
            
            #add-point:AFTER FIELD glaq029_desc name="input.a.page1.glaq029_desc"
            LET g_nmde_d[l_ac].glaq029 = g_nmde_d[l_ac].glaq029_desc
            DISPLAY '' TO glaq029_desc
            IF NOT cl_null(g_nmde_d[l_ac].glaq029) THEN
               CALL anmt820_02_free_account_chk(g_glad.glad0171,g_nmde_d[l_ac].glaq029,g_glad.glad0172) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_nmde_d[l_ac].glaq029
                  #160318-00005#29 by 07900 --add--str
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname("agli041",g_lang,"2")
                  LET g_errparam.exeprog ='agli041'
                  #160318-00005#29 by 07900 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmde_d[l_ac].glaq029 = g_nmde_d_t.glaq029
                  LET g_nmde_d[l_ac].glaq029_desc = g_nmde_d_t.glaq029_desc
                  CALL anmt820_02_free_account_desc('1')
                  DISPLAY g_nmde_d[l_ac].glaq029_desc TO s_detail1[l_ac].glaq029_desc
                  NEXT FIELD glaq029_desc
               END IF
            END IF
            CALL anmt820_02_free_account_desc('1')
            DISPLAY g_nmde_d[l_ac].glaq029_desc TO s_detail1[l_ac].glaq029_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq029_desc
            #add-point:ON CHANGE glaq029_desc name="input.g.page1.glaq029_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq030
            #add-point:BEFORE FIELD glaq030 name="input.b.page1.glaq030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq030
            
            #add-point:AFTER FIELD glaq030 name="input.a.page1.glaq030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq030
            #add-point:ON CHANGE glaq030 name="input.g.page1.glaq030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq030_desc
            #add-point:BEFORE FIELD glaq030_desc name="input.b.page1.glaq030_desc"
          LET g_nmde_d[l_ac].glaq030_desc = g_nmde_d[l_ac].glaq030
          #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
          LET g_glae002 = ''
          LET g_glae009 = ''
          SELECT glae002 INTO g_glae002 FROM glae_t WHERE glaeent = g_enterprise
             AND glae001 = g_glad.glad0181
           IF g_glae002 = '1' THEN
              SELECT glae009 INTO g_glae009 FROM glae_t WHERE glaeent = g_enterprise
                 AND glae001 = g_glad.glad0181
           END IF
           IF g_glae002 = '2' THEN LET g_glae009 = 'q_glaf002' END IF

           IF g_glae002 = '3' THEN LET g_glae009 = '' END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq030_desc
            
            #add-point:AFTER FIELD glaq030_desc name="input.a.page1.glaq030_desc"
            LET g_nmde_d[l_ac].glaq030 = g_nmde_d[l_ac].glaq030_desc
            DISPLAY '' TO glaq030_descesc
            IF NOT cl_null(g_nmde_d[l_ac].glaq030) THEN
               CALL anmt820_02_free_account_chk(g_glad.glad0181,g_nmde_d[l_ac].glaq030,g_glad.glad0182) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_nmde_d[l_ac].glaq030
                  #160318-00005#29 by 07900 --add--str
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname("agli041",g_lang,"2")
                  LET g_errparam.exeprog ='agli041'
                  #160318-00005#29 by 07900 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmde_d[l_ac].glaq030 = g_nmde_d_t.glaq030
                  LET g_nmde_d[l_ac].glaq030_desc = g_nmde_d_t.glaq030_desc
                  CALL anmt820_02_free_account_desc('2')
                  DISPLAY g_nmde_d[l_ac].glaq030_desc TO s_detail1[l_ac].glaq030_desc
                  NEXT FIELD glaq030_desc
               END IF
            END IF
            CALL anmt820_02_free_account_desc('2')
            DISPLAY g_nmde_d[l_ac].glaq030_desc TO s_detail1[l_ac].glaq030_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq030_desc
            #add-point:ON CHANGE glaq030_desc name="input.g.page1.glaq030_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq031
            #add-point:BEFORE FIELD glaq031 name="input.b.page1.glaq031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq031
            
            #add-point:AFTER FIELD glaq031 name="input.a.page1.glaq031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq031
            #add-point:ON CHANGE glaq031 name="input.g.page1.glaq031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq031_desc
            #add-point:BEFORE FIELD glaq031_desc name="input.b.page1.glaq031_desc"
          LET g_nmde_d[l_ac].glaq031_desc = g_nmde_d[l_ac].glaq031
          #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
          LET g_glae002 = ''
          LET g_glae009 = ''
          SELECT glae002 INTO g_glae002 FROM glae_t WHERE glaeent = g_enterprise
             AND glae001 = g_glad.glad0191
           IF g_glae002 = '1' THEN
              SELECT glae009 INTO g_glae009 FROM glae_t WHERE glaeent = g_enterprise
                 AND glae001 = g_glad.glad0191
           END IF
           IF g_glae002 = '2' THEN LET g_glae009 = 'q_glaf002' END IF

           IF g_glae002 = '3' THEN LET g_glae009 = '' END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq031_desc
            
            #add-point:AFTER FIELD glaq031_desc name="input.a.page1.glaq031_desc"
            LET g_nmde_d[l_ac].glaq031 = g_nmde_d[l_ac].glaq031_desc
            DISPLAY '' TO glaq031_desc
            IF NOT cl_null(g_nmde_d[l_ac].glaq031) THEN
               CALL anmt820_02_free_account_chk(g_glad.glad0191,g_nmde_d[l_ac].glaq031,g_glad.glad0192) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_nmde_d[l_ac].glaq031
                  #160318-00005#29 by 07900 --add--str
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname("agli041",g_lang,"2")
                  LET g_errparam.exeprog ='agli041'
                  #160318-00005#29 by 07900 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmde_d[l_ac].glaq031 = g_nmde_d_t.glaq031
                  LET g_nmde_d[l_ac].glaq031_desc = g_nmde_d_t.glaq031_desc
                  CALL anmt820_02_free_account_desc('3')
                  DISPLAY g_nmde_d[l_ac].glaq031_desc TO s_detail1[l_ac].glaq031_desc
                  NEXT FIELD glaq031_desc
               END IF
            END IF
            CALL anmt820_02_free_account_desc('3')
            DISPLAY g_nmde_d[l_ac].glaq031_desc TO s_detail1[l_ac].glaq031_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq031_desc
            #add-point:ON CHANGE glaq031_desc name="input.g.page1.glaq031_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq032
            #add-point:BEFORE FIELD glaq032 name="input.b.page1.glaq032"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq032
            
            #add-point:AFTER FIELD glaq032 name="input.a.page1.glaq032"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq032
            #add-point:ON CHANGE glaq032 name="input.g.page1.glaq032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq032_desc
            #add-point:BEFORE FIELD glaq032_desc name="input.b.page1.glaq032_desc"
            LET g_nmde_d[l_ac].glaq032_desc = g_nmde_d[l_ac].glaq032
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET g_glae002 = ''
            LET g_glae009 = ''
            SELECT glae002 INTO g_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = g_glad0201
             IF g_glae002 = '1' THEN
                SELECT glae009 INTO g_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad0201
             END IF 
             IF g_glae002 = '2' THEN
                LET g_glae009 = 'q_glaf002'
             END IF 
             
             IF g_glae002 = '3' THEN
                LET g_glae009 = ''
             END IF 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq032_desc
            
            #add-point:AFTER FIELD glaq032_desc name="input.a.page1.glaq032_desc"
            LET g_nmde_d[l_ac].glaq032 = g_nmde_d[l_ac].glaq032_desc
            DISPLAY '' TO glaq032_desc
            IF NOT cl_null(g_nmde_d[l_ac].glaq032) THEN
               CALL anmt820_02_free_account_chk(g_glad.glad0201,g_nmde_d[l_ac].glaq032,g_glad.glad0202) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_nmde_d[l_ac].glaq032
                  #160318-00005#29 by 07900 --add--str
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname("agli041",g_lang,"2")
                  LET g_errparam.exeprog ='agli041'
                  #160318-00005#29 by 07900 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmde_d[l_ac].glaq032 = g_nmde_d_t.glaq032
                  LET g_nmde_d[l_ac].glaq032_desc = g_nmde_d_t.glaq032_desc
                  CALL anmt820_02_free_account_desc('4')
                  DISPLAY g_nmde_d[l_ac].glaq032_desc TO s_detail1[l_ac].glaq032_desc
                  NEXT FIELD glaq032_desc
               END IF
            END IF
            CALL anmt820_02_free_account_desc('4')
            DISPLAY g_nmde_d[l_ac].glaq032_desc TO s_detail1[l_ac].glaq032_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq032_desc
            #add-point:ON CHANGE glaq032_desc name="input.g.page1.glaq032_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq033
            #add-point:BEFORE FIELD glaq033 name="input.b.page1.glaq033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq033
            
            #add-point:AFTER FIELD glaq033 name="input.a.page1.glaq033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq033
            #add-point:ON CHANGE glaq033 name="input.g.page1.glaq033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq033_desc
            #add-point:BEFORE FIELD glaq033_desc name="input.b.page1.glaq033_desc"
          LET g_nmde_d[l_ac].glaq033_desc = g_nmde_d[l_ac].glaq033
          #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
          LET g_glae002 = ''
          LET g_glae009 = ''
          SELECT glae002 INTO g_glae002 FROM glae_t WHERE glaeent = g_enterprise
             AND glae001 = g_glad.glad0211
           IF g_glae002 = '1' THEN
              SELECT glae009 INTO g_glae009 FROM glae_t WHERE glaeent = g_enterprise
                 AND glae001 = g_glad.glad0211
           END IF
           IF g_glae002 = '2' THEN LET g_glae009 = 'q_glaf002' END IF

           IF g_glae002 = '3' THEN LET g_glae009 = '' END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq033_desc
            
            #add-point:AFTER FIELD glaq033_desc name="input.a.page1.glaq033_desc"
            LET g_nmde_d[l_ac].glaq033 = g_nmde_d[l_ac].glaq033_desc
            DISPLAY '' TO glaq033_desc
            IF NOT cl_null(g_nmde_d[l_ac].glaq033) THEN
               CALL anmt820_02_free_account_chk(g_glad.glad0211,g_nmde_d[l_ac].glaq033,g_glad.glad0212) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_nmde_d[l_ac].glaq033
                  #160318-00005#29 by 07900 --add--str
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname("agli041",g_lang,"2")
                  LET g_errparam.exeprog ='agli041'
                  #160318-00005#29 by 07900 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmde_d[l_ac].glaq033 = g_nmde_d_t.glaq033
                  LET g_nmde_d[l_ac].glaq033_desc = g_nmde_d_t.glaq033_desc
                  CALL anmt820_02_free_account_desc('5')
                  DISPLAY g_nmde_d[l_ac].glaq033_desc TO s_detail1[l_ac].glaq033_desc
                  NEXT FIELD glaq033_desc
               END IF
            END IF
            CALL anmt820_02_free_account_desc('5')
            DISPLAY g_nmde_d[l_ac].glaq033_desc TO s_detail1[l_ac].glaq033_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq033_desc
            #add-point:ON CHANGE glaq033_desc name="input.g.page1.glaq033_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq034
            #add-point:BEFORE FIELD glaq034 name="input.b.page1.glaq034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq034
            
            #add-point:AFTER FIELD glaq034 name="input.a.page1.glaq034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq034
            #add-point:ON CHANGE glaq034 name="input.g.page1.glaq034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq034_desc
            #add-point:BEFORE FIELD glaq034_desc name="input.b.page1.glaq034_desc"
          LET g_nmde_d[l_ac].glaq034_desc = g_nmde_d[l_ac].glaq034
          #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
          LET g_glae002 = ''
          LET g_glae009 = ''
          SELECT glae002 INTO g_glae002 FROM glae_t WHERE glaeent = g_enterprise
             AND glae001 = g_glad.glad0221
           IF g_glae002 = '1' THEN
              SELECT glae009 INTO g_glae009 FROM glae_t WHERE glaeent = g_enterprise
                 AND glae001 = g_glad.glad0221
           END IF
           IF g_glae002 = '2' THEN LET g_glae009 = 'q_glaf002' END IF

           IF g_glae002 = '3' THEN LET g_glae009 = '' END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq034_desc
            
            #add-point:AFTER FIELD glaq034_desc name="input.a.page1.glaq034_desc"
            LET g_nmde_d[l_ac].glaq034 = g_nmde_d[l_ac].glaq034_desc
            DISPLAY '' TO glaq034_desc
            IF NOT cl_null(g_nmde_d[l_ac].glaq034) THEN
               CALL anmt820_02_free_account_chk(g_glad.glad0221,g_nmde_d[l_ac].glaq034,g_glad.glad0222) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_nmde_d[l_ac].glaq034
                  #160318-00005#29 by 07900 --add--str
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname("agli041",g_lang,"2")
                  LET g_errparam.exeprog ='agli041'
                  #160318-00005#29 by 07900 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmde_d[l_ac].glaq034 = g_nmde_d_t.glaq034
                  LET g_nmde_d[l_ac].glaq034_desc = g_nmde_d_t.glaq034_desc
                  CALL anmt820_02_free_account_desc('6')
                  DISPLAY g_nmde_d[l_ac].glaq034_desc TO s_detail1[l_ac].glaq034_desc
                  NEXT FIELD glaq034_desc
               END IF
            END IF
            CALL anmt820_02_free_account_desc('6')
            DISPLAY g_nmde_d[l_ac].glaq034_desc TO s_detail1[l_ac].glaq034_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq034_desc
            #add-point:ON CHANGE glaq034_desc name="input.g.page1.glaq034_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq035
            #add-point:BEFORE FIELD glaq035 name="input.b.page1.glaq035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq035
            
            #add-point:AFTER FIELD glaq035 name="input.a.page1.glaq035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq035
            #add-point:ON CHANGE glaq035 name="input.g.page1.glaq035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq035_desc
            #add-point:BEFORE FIELD glaq035_desc name="input.b.page1.glaq035_desc"
          LET g_nmde_d[l_ac].glaq035_desc = g_nmde_d[l_ac].glaq035
          #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
          LET g_glae002 = ''
          LET g_glae009 = ''
          SELECT glae002 INTO g_glae002 FROM glae_t WHERE glaeent = g_enterprise
             AND glae001 = g_glad.glad0231
           IF g_glae002 = '1' THEN
              SELECT glae009 INTO g_glae009 FROM glae_t WHERE glaeent = g_enterprise
                 AND glae001 = g_glad.glad0231
           END IF
           IF g_glae002 = '2' THEN LET g_glae009 = 'q_glaf002' END IF

           IF g_glae002 = '3' THEN LET g_glae009 = '' END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq035_desc
            
            #add-point:AFTER FIELD glaq035_desc name="input.a.page1.glaq035_desc"
            LET g_nmde_d[l_ac].glaq035 = g_nmde_d[l_ac].glaq035_desc
            DISPLAY '' TO glaq035_desc
            IF NOT cl_null(g_nmde_d[l_ac].glaq035) THEN
               CALL anmt820_02_free_account_chk(g_glad.glad0231,g_nmde_d[l_ac].glaq035,g_glad.glad0232) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_nmde_d[l_ac].glaq035
                  #160318-00005#29 by 07900 --add--str
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname("agli041",g_lang,"2")
                  LET g_errparam.exeprog ='agli041'
                  #160318-00005#29 by 07900 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmde_d[l_ac].glaq035 = g_nmde_d_t.glaq035
                  LET g_nmde_d[l_ac].glaq035_desc = g_nmde_d_t.glaq035_desc
                  CALL anmt820_02_free_account_desc('7')
                  DISPLAY g_nmde_d[l_ac].glaq035_desc TO s_detail1[l_ac].glaq035_desc
                  NEXT FIELD glaq035_desc
               END IF
            END IF
            CALL anmt820_02_free_account_desc('7')
            DISPLAY g_nmde_d[l_ac].glaq035_desc TO s_detail1[l_ac].glaq035_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq035_desc
            #add-point:ON CHANGE glaq035_desc name="input.g.page1.glaq035_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq036
            #add-point:BEFORE FIELD glaq036 name="input.b.page1.glaq036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq036
            
            #add-point:AFTER FIELD glaq036 name="input.a.page1.glaq036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq036
            #add-point:ON CHANGE glaq036 name="input.g.page1.glaq036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq036_desc
            #add-point:BEFORE FIELD glaq036_desc name="input.b.page1.glaq036_desc"
          LET g_nmde_d[l_ac].glaq036_desc = g_nmde_d[l_ac].glaq036
          #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
          LET g_glae002 = ''
          LET g_glae009 = ''
          SELECT glae002 INTO g_glae002 FROM glae_t WHERE glaeent = g_enterprise
             AND glae001 = g_glad.glad0241
           IF g_glae002 = '1' THEN
              SELECT glae009 INTO g_glae009 FROM glae_t WHERE glaeent = g_enterprise
                 AND glae001 = g_glad.glad0241
           END IF
           IF g_glae002 = '2' THEN LET g_glae009 = 'q_glaf002' END IF

           IF g_glae002 = '3' THEN LET g_glae009 = '' END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq036_desc
            
            #add-point:AFTER FIELD glaq036_desc name="input.a.page1.glaq036_desc"
            LET g_nmde_d[l_ac].glaq036 = g_nmde_d[l_ac].glaq036_desc
            DISPLAY '' TO glaq036_desc
            IF NOT cl_null(g_nmde_d[l_ac].glaq036) THEN
               CALL anmt820_02_free_account_chk(g_glad.glad0241,g_nmde_d[l_ac].glaq036,g_glad.glad0242) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_nmde_d[l_ac].glaq036
                  #160318-00005#29 by 07900 --add--str
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname("agli041",g_lang,"2")
                  LET g_errparam.exeprog ='agli041'
                  #160318-00005#29 by 07900 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmde_d[l_ac].glaq036 = g_nmde_d_t.glaq036
                  LET g_nmde_d[l_ac].glaq036_desc = g_nmde_d_t.glaq036_desc
                  CALL anmt820_02_free_account_desc('8')
                  DISPLAY g_nmde_d[l_ac].glaq036_desc TO s_detail1[l_ac].glaq036_desc
                  NEXT FIELD glaq036_desc
               END IF
            END IF
            CALL anmt820_02_free_account_desc('8')
            DISPLAY g_nmde_d[l_ac].glaq036_desc TO s_detail1[l_ac].glaq036_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq036_desc
            #add-point:ON CHANGE glaq036_desc name="input.g.page1.glaq036_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq037
            #add-point:BEFORE FIELD glaq037 name="input.b.page1.glaq037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq037
            
            #add-point:AFTER FIELD glaq037 name="input.a.page1.glaq037"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq037
            #add-point:ON CHANGE glaq037 name="input.g.page1.glaq037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq037_desc
            #add-point:BEFORE FIELD glaq037_desc name="input.b.page1.glaq037_desc"
          LET g_nmde_d[l_ac].glaq037_desc = g_nmde_d[l_ac].glaq037
          #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
          LET g_glae002 = ''
          LET g_glae009 = ''
          SELECT glae002 INTO g_glae002 FROM glae_t WHERE glaeent = g_enterprise
             AND glae001 = g_glad.glad0251
           IF g_glae002 = '1' THEN
              SELECT glae009 INTO g_glae009 FROM glae_t WHERE glaeent = g_enterprise
                 AND glae001 = g_glad.glad0251
           END IF
           IF g_glae002 = '2' THEN LET g_glae009 = 'q_glaf002' END IF

           IF g_glae002 = '3' THEN LET g_glae009 = '' END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq037_desc
            
            #add-point:AFTER FIELD glaq037_desc name="input.a.page1.glaq037_desc"
            LET g_nmde_d[l_ac].glaq037 = g_nmde_d[l_ac].glaq037_desc
            DISPLAY '' TO glaq037_desc
            IF NOT cl_null(g_nmde_d[l_ac].glaq037) THEN
               CALL anmt820_02_free_account_chk(g_glad.glad0251,g_nmde_d[l_ac].glaq037,g_glad.glad0252) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_nmde_d[l_ac].glaq037
                  #160318-00005#29 by 07900 --add--str
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname("agli041",g_lang,"2")
                  LET g_errparam.exeprog ='agli041'
                  #160318-00005#29 by 07900 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmde_d[l_ac].glaq037 = g_nmde_d_t.glaq037
                  LET g_nmde_d[l_ac].glaq037_desc = g_nmde_d_t.glaq037_desc
                  CALL anmt820_02_free_account_desc('9')
                  DISPLAY g_nmde_d[l_ac].glaq037_desc TO s_detail1[l_ac].glaq037_desc
                  NEXT FIELD glaq037_desc
               END IF
            END IF
            CALL anmt820_02_free_account_desc('9')
            DISPLAY g_nmde_d[l_ac].glaq037_desc TO s_detail1[l_ac].glaq037_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq037_desc
            #add-point:ON CHANGE glaq037_desc name="input.g.page1.glaq037_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq038
            #add-point:BEFORE FIELD glaq038 name="input.b.page1.glaq038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq038
            
            #add-point:AFTER FIELD glaq038 name="input.a.page1.glaq038"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq038
            #add-point:ON CHANGE glaq038 name="input.g.page1.glaq038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq038_desc
            #add-point:BEFORE FIELD glaq038_desc name="input.b.page1.glaq038_desc"
          LET g_nmde_d[l_ac].glaq038_desc = g_nmde_d[l_ac].glaq038
          #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
          LET g_glae002 = ''
          LET g_glae009 = ''
          SELECT glae002 INTO g_glae002 FROM glae_t WHERE glaeent = g_enterprise
             AND glae001 = g_glad.glad0261
           IF g_glae002 = '1' THEN
              SELECT glae009 INTO g_glae009 FROM glae_t WHERE glaeent = g_enterprise
                 AND glae001 = g_glad.glad0261
           END IF
           IF g_glae002 = '2' THEN LET g_glae009 = 'q_glaf002' END IF

           IF g_glae002 = '3' THEN LET g_glae009 = '' END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq038_desc
            
            #add-point:AFTER FIELD glaq038_desc name="input.a.page1.glaq038_desc"
            LET g_nmde_d[l_ac].glaq038 = g_nmde_d[l_ac].glaq038_desc
            DISPLAY '' TO glaq038_desc
            IF NOT cl_null(g_nmde_d[l_ac].glaq038) THEN
               CALL anmt820_02_free_account_chk(g_glad.glad0261,g_nmde_d[l_ac].glaq038,g_glad.glad0262) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_nmde_d[l_ac].glaq038
                  #160318-00005#29 by 07900 --add--str
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname("agli041",g_lang,"2")
                  LET g_errparam.exeprog ='agli041'
                  #160318-00005#29 by 07900 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmde_d[l_ac].glaq038 = g_nmde_d_t.glaq038
                  LET g_nmde_d[l_ac].glaq038_desc = g_nmde_d_t.glaq038_desc
                  CALL anmt820_02_free_account_desc('10')
                  DISPLAY g_nmde_d[l_ac].glaq038_desc TO s_detail1[l_ac].glaq038_desc
                  NEXT FIELD glaq038_desc
               END IF
            END IF
            CALL anmt820_02_free_account_desc('10')
            DISPLAY g_nmde_d[l_ac].glaq038_desc TO s_detail1[l_ac].glaq038_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq038_desc
            #add-point:ON CHANGE glaq038_desc name="input.g.page1.glaq038_desc"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.nmde001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde001
            #add-point:ON ACTION controlp INFIELD nmde001 name="input.c.page1.nmde001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde002
            #add-point:ON ACTION controlp INFIELD nmde002 name="input.c.page1.nmde002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde004
            #add-point:ON ACTION controlp INFIELD nmde004 name="input.c.page1.nmde004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmdeld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdeld
            #add-point:ON ACTION controlp INFIELD nmdeld name="input.c.page1.nmdeld"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glab005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab005
            #add-point:ON ACTION controlp INFIELD glab005 name="input.c.page1.glab005"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmde_d[l_ac].glab005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_glac002()                                #呼叫開窗

            LET g_nmde_d[l_ac].glab005 = g_qryparam.return1              

            DISPLAY g_nmde_d[l_ac].glab005 TO glab005              #

            NEXT FIELD glab005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.glab005_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab005_desc
            #add-point:ON ACTION controlp INFIELD glab005_desc name="input.c.page1.glab005_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde106_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde106_desc
            #add-point:ON ACTION controlp INFIELD nmde106_desc name="input.c.page1.nmde106_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde006
            #add-point:ON ACTION controlp INFIELD nmde006 name="input.c.page1.nmde006"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmde_d[l_ac].nmde006        #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001()                                         #呼叫開窗
            LET g_nmde_d[l_ac].nmde006 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_nmde_d[l_ac].nmde006 TO nmde006              #顯示到畫面上
            NEXT FIELD nmde006                  
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde006_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde006_desc
            #add-point:ON ACTION controlp INFIELD nmde006_desc name="input.c.page1.nmde006_desc"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmde_d[l_ac].nmde006        #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001()                                         #呼叫開窗
            LET g_nmde_d[l_ac].nmde006 = g_qryparam.return1        #將開窗取得的值回傳到變數
            CALL anmt820_02_nmde006_desc(g_nmde_d[l_ac].nmde006) RETURNING g_nmde_d[l_ac].nmde006_desc
            DISPLAY g_nmde_d[l_ac].nmde007_desc TO nmde007_desc             #顯示到畫面上
            NEXT FIELD nmde006  
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde007
            #add-point:ON ACTION controlp INFIELD nmde007 name="input.c.page1.nmde007"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmde_d[l_ac].nmde007               #給予default值
            LET g_qryparam.where = " (ooeg003 = '2' OR ooeg003 = '3')"
            #給予arg
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001()                                        #呼叫開窗
            LET g_nmde_d[l_ac].nmde007 = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_nmde_d[l_ac].nmde007 TO nmde007            #顯示到畫面上
            NEXT FIELD nmde007  
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde007_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde007_desc
            #add-point:ON ACTION controlp INFIELD nmde007_desc name="input.c.page1.nmde007_desc"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmde_d[l_ac].nmde007               #給予default值
            LET g_qryparam.where = " (ooeg003 = '2' OR ooeg003 = '3')"
            #給予arg
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001()                                        #呼叫開窗
            LET g_nmde_d[l_ac].nmde007 = g_qryparam.return1       #將開窗取得的值回傳到變數
            CALL anmt820_02_nmde007_desc(g_nmde_d[l_ac].nmde007) RETURNING g_nmde_d[l_ac].nmde007_desc
            DISPLAY g_nmde_d[l_ac].nmde007_desc TO nmde007_desc            #顯示到畫面上
            NEXT FIELD nmde007_desc  
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde005
            #add-point:ON ACTION controlp INFIELD nmde005 name="input.c.page1.nmde005"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmde_d[l_ac].nmde005            #給予default值
            
            #給予arg
            LET g_qryparam.arg1 = '3'
            CALL q_ooef001_04()                                #呼叫開窗

            LET g_nmde_d[l_ac].nmde005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_nmde_d[l_ac].nmde005 TO nmde005             #顯示到畫面上

            NEXT FIELD nmde005                         #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde005_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde005_desc
            #add-point:ON ACTION controlp INFIELD nmde005_desc name="input.c.page1.nmde005_desc"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmde_d[l_ac].nmde005            #給予default值
            
            #給予arg
            LET g_qryparam.arg1 = '3'
            CALL q_ooef001_04()                                #呼叫開窗

            LET g_nmde_d[l_ac].nmde005 = g_qryparam.return1              #將開窗取得的值回傳到變數              
            CALL anmt820_02_nmde005_desc()
            DISPLAY g_nmde_d[l_ac].nmde005_desc TO nmde005_desc             #顯示到畫面上
            
            NEXT FIELD nmde005_desc                         #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde010
            #add-point:ON ACTION controlp INFIELD nmde010 name="input.c.page1.nmde010"
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmde_d[l_ac].nmde010           #給予default值
            #給予arg
            CALL q_rtax001_1()                                       #呼叫開窗
            LET g_nmde_d[l_ac].nmde010 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_nmde_d[l_ac].nmde010 TO nmde010              #顯示到畫面上
            NEXT FIELD nmde010
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde010_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde010_desc
            #add-point:ON ACTION controlp INFIELD nmde010_desc name="input.c.page1.nmde010_desc"
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmde_d[l_ac].nmde010           #給予default值
            #給予arg
            CALL q_rtax001_1()                                       #呼叫開窗
            LET g_nmde_d[l_ac].nmde010 = g_qryparam.return1        #將開窗取得的值回傳到變數
            CALL anmt820_02_nmde010_desc()
            DISPLAY g_nmde_d[l_ac].nmde010_desc TO nmde010_desc              #顯示到畫面上
            NEXT FIELD nmde010_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde013
            #add-point:ON ACTION controlp INFIELD nmde013 name="input.c.page1.nmde013"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmde_d[l_ac].nmde013       #給予default值
            #給予arg
            CALL q_pjba001()                                         #呼叫開窗
            LET g_nmde_d[l_ac].nmde013 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_nmde_d[l_ac].nmde013 TO nmde13              #顯示到畫面上
            NEXT FIELD nmde013    
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde013_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde013_desc
            #add-point:ON ACTION controlp INFIELD nmde013_desc name="input.c.page1.nmde013_desc"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmde_d[l_ac].nmde013       #給予default值
            #給予arg
            CALL q_pjba001()                                         #呼叫開窗
            LET g_nmde_d[l_ac].nmde013 = g_qryparam.return1        #將開窗取得的值回傳到變數
            CALL anmt820_02_nmde013_desc()
            DISPLAY g_nmde_d[l_ac].nmde013_desc TO nmde13_desc              #顯示到畫面上
            NEXT FIELD nmde013_desc  
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde014
            #add-point:ON ACTION controlp INFIELD nmde014 name="input.c.page1.nmde014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde014_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde014_desc
            #add-point:ON ACTION controlp INFIELD nmde014_desc name="input.c.page1.nmde014_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq029
            #add-point:ON ACTION controlp INFIELD glaq029 name="input.c.page1.glaq029"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq029_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq029_desc
            #add-point:ON ACTION controlp INFIELD glaq029_desc name="input.c.page1.glaq029_desc"
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmde_d[l_ac].glaq029             #給予default值

               #給予arg
               IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0171,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                                #呼叫開窗

               LET g_nmde_d[l_ac].glaq029 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL anmt820_02_free_account_desc('1')
               DISPLAY g_nmde_d[l_ac].glaq029_desc TO s_detail1[l_ac].glaq029_desc    #說明
               LET g_qryparam.where = ''
               NEXT FIELD glaq029_desc                          #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq030
            #add-point:ON ACTION controlp INFIELD glaq030 name="input.c.page1.glaq030"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq030_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq030_desc
            #add-point:ON ACTION controlp INFIELD glaq030_desc name="input.c.page1.glaq030_desc"
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmde_d[l_ac].glaq030             #給予default值

               #給予arg
               IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0181,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                                #呼叫開窗

               LET g_nmde_d[l_ac].glaq030 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL anmt820_02_free_account_desc('2')
               DISPLAY g_nmde_d[l_ac].glaq030_desc TO s_detail1[l_ac].glaq030_desc    #說明
               LET g_qryparam.where = '2'
               NEXT FIELD glaq030_desc                          #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq031
            #add-point:ON ACTION controlp INFIELD glaq031 name="input.c.page1.glaq031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq031_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq031_desc
            #add-point:ON ACTION controlp INFIELD glaq031_desc name="input.c.page1.glaq031_desc"
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmde_d[l_ac].glaq031             #給予default值

               #給予arg
               IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0191,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                                #呼叫開窗

               LET g_nmde_d[l_ac].glaq031 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL anmt820_02_free_account_desc('3')
               DISPLAY g_nmde_d[l_ac].glaq031_desc TO s_detail1[l_ac].glaq031_desc    #說明
               LET g_qryparam.where = '3'
               NEXT FIELD glaq031_desc                          #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq032
            #add-point:ON ACTION controlp INFIELD glaq032 name="input.c.page1.glaq032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq032_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq032_desc
            #add-point:ON ACTION controlp INFIELD glaq032_desc name="input.c.page1.glaq032_desc"
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmde_d[l_ac].glaq032             #給予default值

               #給予arg
               IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0201,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                                #呼叫開窗

               LET g_nmde_d[l_ac].glaq032 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL anmt820_02_free_account_desc('4')
               DISPLAY g_nmde_d[l_ac].glaq032_desc TO s_detail1[l_ac].glaq032_desc    #說明
               LET g_qryparam.where = '4'
               NEXT FIELD glaq032_desc                          #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq033
            #add-point:ON ACTION controlp INFIELD glaq033 name="input.c.page1.glaq033"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq033_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq033_desc
            #add-point:ON ACTION controlp INFIELD glaq033_desc name="input.c.page1.glaq033_desc"
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmde_d[l_ac].glaq033             #給予default值

               #給予arg
               IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0211,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                                #呼叫開窗

               LET g_nmde_d[l_ac].glaq033 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL anmt820_02_free_account_desc('5')
               DISPLAY g_nmde_d[l_ac].glaq033_desc TO s_detail1[l_ac].glaq033_desc    #說明
               LET g_qryparam.where = '5'
               NEXT FIELD glaq033_desc                          #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq034
            #add-point:ON ACTION controlp INFIELD glaq034 name="input.c.page1.glaq034"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq034_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq034_desc
            #add-point:ON ACTION controlp INFIELD glaq034_desc name="input.c.page1.glaq034_desc"
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmde_d[l_ac].glaq034             #給予default值

               #給予arg
               IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0221,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                                #呼叫開窗

               LET g_nmde_d[l_ac].glaq034 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL anmt820_02_free_account_desc('6')
               DISPLAY g_nmde_d[l_ac].glaq034_desc TO s_detail1[l_ac].glaq034_desc    #說明
               LET g_qryparam.where = '6'
               NEXT FIELD glaq034_desc                          #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq035
            #add-point:ON ACTION controlp INFIELD glaq035 name="input.c.page1.glaq035"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq035_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq035_desc
            #add-point:ON ACTION controlp INFIELD glaq035_desc name="input.c.page1.glaq035_desc"
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmde_d[l_ac].glaq035             #給予default值

               #給予arg
               IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0231,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                                #呼叫開窗

               LET g_nmde_d[l_ac].glaq035 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL anmt820_02_free_account_desc('7')
               DISPLAY g_nmde_d[l_ac].glaq035_desc TO s_detail1[l_ac].glaq035_desc    #說明
               LET g_qryparam.where = '7'
               NEXT FIELD glaq035_desc                          #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq036
            #add-point:ON ACTION controlp INFIELD glaq036 name="input.c.page1.glaq036"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq036_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq036_desc
            #add-point:ON ACTION controlp INFIELD glaq036_desc name="input.c.page1.glaq036_desc"
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmde_d[l_ac].glaq036             #給予default值

               #給予arg
               IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0241,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                                #呼叫開窗

               LET g_nmde_d[l_ac].glaq036 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL anmt820_02_free_account_desc('8')
               DISPLAY g_nmde_d[l_ac].glaq036_desc TO s_detail1[l_ac].glaq036_desc    #說明
               LET g_qryparam.where = '8'
               NEXT FIELD glaq036_desc                          #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq037
            #add-point:ON ACTION controlp INFIELD glaq037 name="input.c.page1.glaq037"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq037_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq037_desc
            #add-point:ON ACTION controlp INFIELD glaq037_desc name="input.c.page1.glaq037_desc"
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmde_d[l_ac].glaq037             #給予default值

               #給予arg
               IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0251,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                                #呼叫開窗

               LET g_nmde_d[l_ac].glaq037 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL anmt820_02_free_account_desc('9')
               DISPLAY g_nmde_d[l_ac].glaq037_desc TO s_detail1[l_ac].glaq037_desc    #說明
               LET g_qryparam.where = '9'
               NEXT FIELD glaq037_desc                          #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq038
            #add-point:ON ACTION controlp INFIELD glaq038 name="input.c.page1.glaq038"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq038_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq038_desc
            #add-point:ON ACTION controlp INFIELD glaq038_desc name="input.c.page1.glaq038_desc"
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmde_d[l_ac].glaq038             #給予default值

               #給予arg
               IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0261,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                                #呼叫開窗

               LET g_nmde_d[l_ac].glaq038 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL anmt820_02_free_account_desc('10')
               DISPLAY g_nmde_d[l_ac].glaq038_desc TO s_detail1[l_ac].glaq038_desc    #說明
               LET g_qryparam.where = '10'
               NEXT FIELD glaq038_desc                          #返回原欄位
            END IF
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE anmt820_02_bcl
               LET INT_FLAG = 0
               LET g_nmde_d[l_ac].* = g_nmde_d_t.*
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
               LET g_errparam.extend = g_nmde_d[l_ac].nmdeld 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_nmde_d[l_ac].* = g_nmde_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL anmt820_02_nmde_t_mask_restore('restore_mask_o')
 
               UPDATE nmde_t SET (nmde001,nmde002,nmde004,nmdeld,nmde006,nmde007,nmde005,nmde010,nmde013, 
                   nmde014) = (g_nmde_d[l_ac].nmde001,g_nmde_d[l_ac].nmde002,g_nmde_d[l_ac].nmde004, 
                   g_nmde_d[l_ac].nmdeld,g_nmde_d[l_ac].nmde006,g_nmde_d[l_ac].nmde007,g_nmde_d[l_ac].nmde005, 
                   g_nmde_d[l_ac].nmde010,g_nmde_d[l_ac].nmde013,g_nmde_d[l_ac].nmde014)
                WHERE nmdeent = g_enterprise AND
                  nmdeld = g_nmde_d_t.nmdeld #項次   
                  AND nmde001 = g_nmde_d_t.nmde001  
                  AND nmde002 = g_nmde_d_t.nmde002  
                  AND nmde004 = g_nmde_d_t.nmde004  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
 
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmde_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmde_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmde_d[g_detail_idx].nmdeld
               LET gs_keys_bak[1] = g_nmde_d_t.nmdeld
               LET gs_keys[2] = g_nmde_d[g_detail_idx].nmde001
               LET gs_keys_bak[2] = g_nmde_d_t.nmde001
               LET gs_keys[3] = g_nmde_d[g_detail_idx].nmde002
               LET gs_keys_bak[3] = g_nmde_d_t.nmde002
               LET gs_keys[4] = g_nmde_d[g_detail_idx].nmde004
               LET gs_keys_bak[4] = g_nmde_d_t.nmde004
               CALL anmt820_02_update_b('nmde_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_nmde_d_t)
                     LET g_log2 = util.JSON.stringify(g_nmde_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL anmt820_02_nmde_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL anmt820_02_unlock_b("nmde_t")
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_nmde_d[l_ac].* = g_nmde_d_t.*
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
               LET g_nmde_d[li_reproduce_target].* = g_nmde_d[li_reproduce].*
 
               LET g_nmde_d[li_reproduce_target].nmdeld = NULL
               LET g_nmde_d[li_reproduce_target].nmde001 = NULL
               LET g_nmde_d[li_reproduce_target].nmde002 = NULL
               LET g_nmde_d[li_reproduce_target].nmde004 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_nmde_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_nmde_d.getLength()+1
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
               NEXT FIELD nmde001
 
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
      IF INT_FLAG OR cl_null(g_nmde_d[g_detail_idx].nmdeld) THEN
         CALL g_nmde_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_nmde_d[g_detail_idx].* = g_nmde_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE anmt820_02_bcl
   
END FUNCTION
 
{</section>}
 
{<section id="anmt820_02.delete" >}
#+ 資料刪除
PRIVATE FUNCTION anmt820_02_delete()
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
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET li_ac_t = l_ac
   
   LET li_detail_tmp = g_detail_idx
    
   #lock所有所選資料
   FOR li_idx = 1 TO g_nmde_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT anmt820_02_lock_b("nmde_t") THEN
            #已被他人鎖定
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("nmde_t","") THEN
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
   
   FOR li_idx = 1 TO g_nmde_d.getLength()
      IF g_nmde_d[li_idx].nmdeld IS NOT NULL
         AND g_nmde_d[li_idx].nmde001 IS NOT NULL
         AND g_nmde_d[li_idx].nmde002 IS NOT NULL
         AND g_nmde_d[li_idx].nmde004 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM nmde_t
          WHERE nmdeent = g_enterprise AND 
                nmdeld = g_nmde_d[li_idx].nmdeld
                AND nmde001 = g_nmde_d[li_idx].nmde001
                AND nmde002 = g_nmde_d[li_idx].nmde002
                AND nmde004 = g_nmde_d[li_idx].nmde004
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "nmde_t:",SQLERRMESSAGE 
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
               LET gs_keys[1] = g_nmde_d_t.nmdeld
               LET gs_keys[2] = g_nmde_d_t.nmde001
               LET gs_keys[3] = g_nmde_d_t.nmde002
               LET gs_keys[4] = g_nmde_d_t.nmde004
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL anmt820_02_delete_b('nmde_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL anmt820_02_set_pk_array()
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
   CALL anmt820_02_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="anmt820_02.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmt820_02_b_fill(p_wc2)              #BODY FILL UP
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2            STRING
   DEFINE ls_owndept_list  STRING  #(ver:35) add
   DEFINE ls_ownuser_list  STRING  #(ver:35) add
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前 name="b_fill.sql_before"
   CALL anmt820_02_b_fill_1(p_wc2)
   RETURN
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.nmde001,t0.nmde002,t0.nmde004,t0.nmdeld,t0.nmde006,t0.nmde007,t0.nmde005, 
       t0.nmde010,t0.nmde013,t0.nmde014 ,t1.glaal002 FROM nmde_t t0",
               "",
                              " LEFT JOIN glaal_t t1 ON t1.glaalent="||g_enterprise||" AND t1.glaalld=t0.nmdeld AND t1.glaal001='"||g_dlang||"' ",
 
               " WHERE t0.nmdeent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
   
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("nmde_t"),
                      " ORDER BY t0.nmdeld,t0.nmde001,t0.nmde002,t0.nmde004"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"nmde_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE anmt820_02_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR anmt820_02_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_nmde_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_nmde_d[l_ac].nmde001,g_nmde_d[l_ac].nmde002,g_nmde_d[l_ac].nmde004,g_nmde_d[l_ac].nmdeld, 
       g_nmde_d[l_ac].nmde006,g_nmde_d[l_ac].nmde007,g_nmde_d[l_ac].nmde005,g_nmde_d[l_ac].nmde010,g_nmde_d[l_ac].nmde013, 
       g_nmde_d[l_ac].nmde014,g_nmde_d[l_ac].nmdeld_desc
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
      
      CALL anmt820_02_detail_show()      
 
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
   
 
   
   CALL g_nmde_d.deleteElement(g_nmde_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_nmde_d.getLength()
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_nmde_d.getLength() THEN
      LET l_ac = g_nmde_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_nmde_d.getLength()
      LET g_nmde_d_mask_o[l_ac].* =  g_nmde_d[l_ac].*
      CALL anmt820_02_nmde_t_mask()
      LET g_nmde_d_mask_n[l_ac].* =  g_nmde_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_nmde_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE anmt820_02_pb
   
END FUNCTION
 
{</section>}
 
{<section id="anmt820_02.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION anmt820_02_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   DEFINE l_glaa004         LIKE glaa_t.glaa004
   #end add-point
   
   #add-point:Function前置處理  name="detail_show.before"
   CALL cl_set_act_visible('delete,delete_detail',FALSE)
   CALL cl_set_act_visible('insert,insert_detail',FALSE)
   CALL cl_set_act_visible('query,query_detail',FALSE)   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
 
   
   #讀入ref值
   #add-point:show段單身reference name="detail_show.reference"

   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_nmde_d[l_ac].nmdeld
   LET g_ref_fields[2] = g_nmde_d[l_ac].nmde001
   LET g_ref_fields[3] = g_nmde_d[l_ac].nmde002
   LET g_ref_fields[4] = g_nmde_d[l_ac].nmde004
   
   #匯差科目
   SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_nmdeld
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmde_d[l_ac].glab005
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001 = '"||l_glaa004||"' AND glacl002 = ? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmde_d[l_ac].glab005_desc = g_nmde_d[l_ac].glab005,' ', g_rtn_fields[1] 

   #固定核算項
   #部門
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmde_d[l_ac].nmde006
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmde_d[l_ac].nmde006_desc = g_nmde_d[l_ac].nmde006,' ', g_rtn_fields[1] 

   #責任中心
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmde_d[l_ac].nmde007
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmde_d[l_ac].nmde007_desc = g_nmde_d[l_ac].nmde007,' ', g_rtn_fields[1] 

   #核算組織
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmde_d[l_ac].nmde005
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmde_d[l_ac].nmde005_desc = g_nmde_d[l_ac].nmde005,' ', g_rtn_fields[1] 

   #產品類別
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmde_d[l_ac].nmde010
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmde_d[l_ac].nmde010_desc = g_nmde_d[l_ac].nmde010,' ', g_rtn_fields[1] 

   #專案代號
   #LET g_nmde_d[l_ac].nmde013_desc = g_nmde_d[l_ac].nmde013 #160627-00016#1
   CALL anmt820_02_nmde013_desc()  #160627-00016#1
   #WBS編號
   #LET g_nmde_d[l_ac].nmde014_desc = g_nmde_d[l_ac].nmde014 #160627-00016#1
   
   CALL s_desc_get_wbs_desc(g_nmde_d[l_ac].nmde013,g_nmde_d[l_ac].nmde014) RETURNING g_nmde_d[l_ac].nmde014_desc #160627-00016#1
   LET g_nmde_d[l_ac].nmde014_desc = g_nmde_d[l_ac].nmde014 ,' ',g_nmde_d[l_ac].nmde014_desc                  #160627-00016#1

   #自由核算項
   CALL anmt820_02_free_account_desc('')
   #end add-point
   
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmt820_02.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION anmt820_02_set_entry_b(p_cmd)                                                  
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
 
{<section id="anmt820_02.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION anmt820_02_set_no_entry_b(p_cmd)                                               
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
 
{<section id="anmt820_02.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION anmt820_02_default_search()
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
      LET ls_wc = ls_wc, " nmdeld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " nmde001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " nmde002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " nmde004 = '", g_argv[04], "' AND "
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
 
{<section id="anmt820_02.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION anmt820_02_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "nmde_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'nmde_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM nmde_t
          WHERE nmdeent = g_enterprise AND
            nmdeld = ps_keys_bak[1] AND nmde001 = ps_keys_bak[2] AND nmde002 = ps_keys_bak[3] AND nmde004 = ps_keys_bak[4]
         
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
         CALL g_nmde_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="anmt820_02.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION anmt820_02_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "nmde_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO nmde_t
                  (nmdeent,
                   nmdeld,nmde001,nmde002,nmde004
                   ,nmde006,nmde007,nmde005,nmde010,nmde013,nmde014) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_nmde_d[l_ac].nmde006,g_nmde_d[l_ac].nmde007,g_nmde_d[l_ac].nmde005,g_nmde_d[l_ac].nmde010, 
                       g_nmde_d[l_ac].nmde013,g_nmde_d[l_ac].nmde014)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "nmde_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="anmt820_02.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION anmt820_02_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   CALL anmt820_02_update_b_1()
   RETURN
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
   LET ls_group = "nmde_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "nmde_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE nmde_t 
         SET (nmdeld,nmde001,nmde002,nmde004
              ,nmde006,nmde007,nmde005,nmde010,nmde013,nmde014) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_nmde_d[l_ac].nmde006,g_nmde_d[l_ac].nmde007,g_nmde_d[l_ac].nmde005,g_nmde_d[l_ac].nmde010, 
                  g_nmde_d[l_ac].nmde013,g_nmde_d[l_ac].nmde014) 
         WHERE nmdeent = g_enterprise AND nmdeld = ps_keys_bak[1] AND nmde001 = ps_keys_bak[2] AND nmde002 = ps_keys_bak[3] AND nmde004 = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "nmde_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "nmde_t:",SQLERRMESSAGE 
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
 
{<section id="anmt820_02.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION anmt820_02_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL anmt820_02_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "nmde_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN anmt820_02_bcl USING g_enterprise,
                                       g_nmde_d[g_detail_idx].nmdeld,g_nmde_d[g_detail_idx].nmde001, 
                                           g_nmde_d[g_detail_idx].nmde002,g_nmde_d[g_detail_idx].nmde004 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "anmt820_02_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="anmt820_02.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION anmt820_02_unlock_b(ps_table)
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
      CLOSE anmt820_02_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="anmt820_02.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION anmt820_02_modify_detail_chk(ps_record)
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
         LET ls_return = "nmde001"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="anmt820_02.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION anmt820_02_show_ownid_msg()
   #add-point:show_ownid_msg段define(客製用) name="show_ownid_msg.define_customerization"
   
   #end add-point
   #add-point:show_ownid_msg段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show_ownid_msg.define"
   
   #end add-point
  
 
   
 
END FUNCTION
#(ver:35) --- add end ---
 
{</section>}
 
{<section id="anmt820_02.mask_functions" >}
&include "erp/anm/anmt820_02_mask.4gl"
 
{</section>}
 
{<section id="anmt820_02.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION anmt820_02_set_pk_array()
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
   LET g_pk_array[1].values = g_nmde_d[l_ac].nmdeld
   LET g_pk_array[1].column = 'nmdeld'
   LET g_pk_array[2].values = g_nmde_d[l_ac].nmde001
   LET g_pk_array[2].column = 'nmde001'
   LET g_pk_array[3].values = g_nmde_d[l_ac].nmde002
   LET g_pk_array[3].column = 'nmde002'
   LET g_pk_array[4].values = g_nmde_d[l_ac].nmde004
   LET g_pk_array[4].column = 'nmde004'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmt820_02.state_change" >}
   
 
{</section>}
 
{<section id="anmt820_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="anmt820_02.other_function" readonly="Y" >}

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmt820_02_free_account_chk(p_glaf001,p_glaf002,p_ctrl)
# Input parameter:  
# Date & Author..: 2014/8/18 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt820_02_free_account_chk(p_glaf001,p_glaf002,p_ctrl)
   DEFINE p_glaf001      LIKE glaf_t.glaf001
   DEFINE p_glaf002      LIKE glaf_t.glaf002
   DEFINE p_ctrl         LIKE type_t.chr5       #控制方式1.1.允许空白，2：必输不需检查或，3：必输需要检查
   DEFINE r_errno        LIKE type_t.chr10      #错误编号
   DEFINE l_glafstus     LIKE glaf_t.glafstus
   DEFINE l_glae002      LIKE glae_t.glae002
   DEFINE l_glae003      LIKE glae_t.glae003
   DEFINE l_glae004      LIKE glae_t.glae004
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_sql          STRING
   
      LET r_errno = ''
      LET l_glae002 = ''
      LET l_glae003 = ''
      LET l_glae004 = ''
      #.抓出該类型对应的资料来源，来源档案，来源编号栏位
      SELECT glae002,glae003,glae004 INTO l_glae002,l_glae003,l_glae004 FROM glae_t
       WHERE glaeent = g_enterprise
         AND glae001 = p_glaf001
      #来源类型为1.‘基本资料’，則檢核來源編號欄位是否存在,並依核算项类型对应的控制方式，檢核核算项值的合理性
      IF l_glae002 = '1' THEN
         SELECT count(*) INTO l_cnt FROM dzeb_t
          WHERE dzeb001 = l_glae003
            AND dzeb002 = l_glae004
         IF l_cnt = 0  THEN
            LET r_errno = 'agl-00073'
            RETURN r_errno
         END IF
         #控制方式3：必输必检查
         IF p_ctrl = '3'  THEN
            #1.检查资料的有效存在
             LET l_cnt = 0
             CALL anmt820_02_make_sql(l_glae003,l_glae004,p_glaf002) RETURNING l_sql
             PREPARE anmt820_02_03_chk  FROM l_sql
             EXECUTE anmt820_02_03_chk INTO l_cnt             
             IF  l_cnt = 0  THEN
                 LET r_errno = 'agl-00099'
                 RETURN r_errno
             END IF
             #IF  l_glafstus = 'N'  THEN
             #    LET g_errno = 'agl-00063'
             #    RETURN r_errno
             #END IF
         END IF
      END IF
      #来源类型为2.预设值，則輸入值應檢核是否存在自由核算項資料檔,並依核算项类型对应的控制方式，檢核核算项值的合理性
      IF l_glae002 = '2' THEN
         SELECT glafstus INTO l_glafstus FROM glaf_t
             WHERE glafent = g_enterprise
               AND glaf001 = p_glaf001
               AND glaf002 = p_glaf002
         IF SQLCA.SQLCODE = 100  THEN
            LET r_errno = 'agl-00062'
            RETURN r_errno
          END IF
          IF p_ctrl = '3'  THEN
             IF l_glafstus = 'N'  THEN
                LET g_errno = 'sub-01302'   #agl-00063   #160318-00005#29 by 07900 --mod  
                RETURN r_errno
             END IF
          END IF
      END IF
      #若来源类型为3.'自行輸入'則user可任意輸入且不需檢核
      RETURN r_errno
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmt820_02_free_account_desc(p_chr)
# Input parameter:  
# Date & Author..: 2014/8/18 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt820_02_free_account_desc(p_chr)
   DEFINE p_chr         LIKE type_t.chr1
   DEFINE l_glae002     LIKE glae_t.glae002     #资料来源
   DEFINE l_sql         STRING                  #组的抓取资料的sql
   
   IF cl_null(p_chr) OR p_chr = '1' THEN
      #核算项一
      LET l_glae002 = ''   LET l_sql = ''
      SELECT glae002 INTO l_glae002 FROM glae_t WHERE glaeent = g_enterprise AND glae001 = g_glad.glad0171
      IF l_glae002 = '2' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] =g_glad.glad0171
         LET g_ref_fields[2] =g_nmde_d[l_ac].glaq029
         CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","")
            RETURNING g_rtn_fields
         LET g_nmde_d[l_ac].glaq029_desc= g_rtn_fields[1]
      ELSE
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_nmde_d[l_ac].glaq029
         CALL anmt820_02_make_sql_desc(g_glad.glad0171) RETURNING l_sql
         CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
         LET g_nmde_d[l_ac].glaq029_desc= g_rtn_fields[1]
      END IF 
      LET g_nmde_d[l_ac].glaq029_desc = g_nmde_d[l_ac].glaq029 CLIPPED ,' ',g_nmde_d[l_ac].glaq029_desc
   END IF

   IF cl_null(p_chr) OR p_chr = '2' THEN
      #核算项二
      LET l_glae002 = ''   LET l_sql = ''
      SELECT glae002 INTO l_glae002 FROM glae_t WHERE glaeent = g_enterprise AND glae001 = g_glad.glad0181
      IF l_glae002 = '2' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] =g_glad.glad0181
         LET g_ref_fields[2] =g_nmde_d[l_ac].glaq030     
         CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","")
            RETURNING g_rtn_fields
         LET g_nmde_d[l_ac].glaq030_desc= g_rtn_fields[1]
      ELSE
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_nmde_d[l_ac].glaq030
         CALL anmt820_02_make_sql_desc(g_glad.glad0181) RETURNING l_sql
         CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
         LET g_nmde_d[l_ac].glaq030_desc= g_rtn_fields[1]
      END IF   
      LET g_nmde_d[l_ac].glaq030_desc = g_nmde_d[l_ac].glaq030 CLIPPED ,' ',g_nmde_d[l_ac].glaq030_desc   
   END IF

   IF cl_null(p_chr) OR p_chr = '3' THEN
      #核算项三
      LET l_glae002 = ''   LET l_sql = ''
      SELECT glae002 INTO l_glae002 FROM glae_t WHERE glaeent = g_enterprise AND glae001 = g_glad.glad0191
      IF l_glae002 = '2' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] =g_glad.glad0191
         LET g_ref_fields[2] =g_nmde_d[l_ac].glaq031
         CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_nmde_d[l_ac].glaq031_desc= g_rtn_fields[1]
      ELSE
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_nmde_d[l_ac].glaq031
         CALL anmt820_02_make_sql_desc(g_glad.glad0191) RETURNING l_sql
         CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
         LET g_nmde_d[l_ac].glaq031_desc= g_rtn_fields[1]   
      END IF     
      LET g_nmde_d[l_ac].glaq031_desc = g_nmde_d[l_ac].glaq031 CLIPPED ,' ',g_nmde_d[l_ac].glaq031_desc   
   END IF

   IF cl_null(p_chr) OR p_chr = '4' THEN
      #核算项四
      LET l_glae002 = ''   LET l_sql = ''
      SELECT glae002 INTO l_glae002 FROM glae_t WHERE glaeent = g_enterprise AND glae001 = g_glad.glad0201
      IF l_glae002 = '2' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] =g_glad.glad0201
         LET g_ref_fields[2] =g_nmde_d[l_ac].glaq032
         CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","")
            RETURNING g_rtn_fields
         LET g_nmde_d[l_ac].glaq032_desc= g_rtn_fields[1]
       ELSE
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_nmde_d[l_ac].glaq032
         CALL anmt820_02_make_sql_desc(g_glad.glad0201) RETURNING l_sql
         CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
         LET g_nmde_d[l_ac].glaq032_desc= g_rtn_fields[1]   
      END IF   
      LET g_nmde_d[l_ac].glaq032_desc = g_nmde_d[l_ac].glaq032 CLIPPED ,' ',g_nmde_d[l_ac].glaq032_desc  
   END IF

   IF cl_null(p_chr) OR p_chr = '5' THEN  
      #核算项五
      LET l_glae002 = '' LET l_sql = ''
      SELECT glae002 INTO l_glae002 FROM glae_t WHERE glaeent = g_enterprise AND glae001 = g_glad.glad0211
      IF l_glae002 = '2' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] =g_glad.glad0211
         LET g_ref_fields[2] =g_nmde_d[l_ac].glaq033
         CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","")
            RETURNING g_rtn_fields
         LET g_nmde_d[l_ac].glaq033_desc= g_rtn_fields[1]  
      ELSE
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_nmde_d[l_ac].glaq033
         CALL anmt820_02_make_sql_desc(g_glad.glad0211) RETURNING l_sql
         CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
         LET g_nmde_d[l_ac].glaq033_desc= g_rtn_fields[1]   
      END IF    
      LET g_nmde_d[l_ac].glaq033_desc = g_nmde_d[l_ac].glaq033 CLIPPED ,' ',g_nmde_d[l_ac].glaq033_desc     
   END IF

   IF cl_null(p_chr) OR p_chr = '6' THEN
      #核算项六
      LET l_glae002 = ''   LET l_sql = ''
      SELECT glae002 INTO l_glae002 FROM glae_t WHERE glaeent = g_enterprise AND glae001 = g_glad.glad0221
      IF l_glae002 = '2' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] =g_glad.glad0221
         LET g_ref_fields[2] =g_nmde_d[l_ac].glaq034
         CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","")
            RETURNING g_rtn_fields
         LET g_nmde_d[l_ac].glaq034_desc= g_rtn_fields[1]
      ELSE
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_nmde_d[l_ac].glaq034
         CALL anmt820_02_make_sql_desc(g_glad.glad0221) RETURNING l_sql
         CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
         LET g_nmde_d[l_ac].glaq034_desc= g_rtn_fields[1]   
      END IF    
      LET g_nmde_d[l_ac].glaq034_desc = g_nmde_d[l_ac].glaq034 CLIPPED ,' ',g_nmde_d[l_ac].glaq034_desc     
   END IF

   IF cl_null(p_chr) OR p_chr = '7' THEN
      #核算项七
      LET l_glae002 = ''   LET l_sql = ''
      SELECT glae002 INTO l_glae002 FROM glae_t WHERE glaeent = g_enterprise AND glae001 = g_glad.glad0231
      IF l_glae002 = '2' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] =g_glad.glad0231
         LET g_ref_fields[2] =g_nmde_d[l_ac].glaq035
         CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","")
            RETURNING g_rtn_fields
         LET g_nmde_d[l_ac].glaq035_desc= g_rtn_fields[1]
      ELSE
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_nmde_d[l_ac].glaq035
         CALL anmt820_02_make_sql_desc(g_glad.glad0241) RETURNING l_sql
         CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
         LET g_nmde_d[l_ac].glaq035_desc= g_rtn_fields[1]   
      END IF     
      LET g_nmde_d[l_ac].glaq035_desc = g_nmde_d[l_ac].glaq035 CLIPPED ,' ',g_nmde_d[l_ac].glaq035_desc     
   END IF

   IF cl_null(p_chr) OR p_chr = '8' THEN
      #核算项八
      LET l_glae002 = ''   LET l_sql = ''
      SELECT glae002 INTO l_glae002 FROM glae_t WHERE glaeent = g_enterprise AND glae001 = g_glad.glad0241
      IF l_glae002 = '2' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] =g_glad.glad0241
         LET g_ref_fields[2] =g_nmde_d[l_ac].glaq036
         CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","")
            RETURNING g_rtn_fields
         LET g_nmde_d[l_ac].glaq036_desc= g_rtn_fields[1]
      ELSE
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_nmde_d[l_ac].glaq036
         CALL anmt820_02_make_sql_desc(g_glad.glad0241) RETURNING l_sql
         CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
         LET g_nmde_d[l_ac].glaq036_desc= g_rtn_fields[1]   
      END IF     
      LET g_nmde_d[l_ac].glaq036_desc = g_nmde_d[l_ac].glaq036 CLIPPED ,' ',g_nmde_d[l_ac].glaq036_desc    
   END IF

   IF cl_null(p_chr) OR p_chr = '9' THEN 
      #核算项九
      LET l_glae002 = ''   LET l_sql = ''
      SELECT glae002 INTO l_glae002 FROM glae_t WHERE glaeent = g_enterprise AND glae001 = g_glad.glad0251
      IF l_glae002 = '2' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] =g_glad.glad0251
         LET g_ref_fields[2] =g_nmde_d[l_ac].glaq037
         CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","")
            RETURNING g_rtn_fields
         LET g_nmde_d[l_ac].glaq037_desc= g_rtn_fields[1]
      ELSE
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_nmde_d[l_ac].glaq037
         CALL anmt820_02_make_sql_desc(g_glad.glad0251) RETURNING l_sql
         CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
         LET g_nmde_d[l_ac].glaq037_desc= g_rtn_fields[1]   
      END IF  
      LET g_nmde_d[l_ac].glaq037_desc = g_nmde_d[l_ac].glaq037 CLIPPED ,' ',g_nmde_d[l_ac].glaq037_desc     
   END IF

   IF cl_null(p_chr) OR p_chr = '10' THEN
      #核算项十
      LET l_glae002 = ''   LET l_sql = ''
      SELECT glae002 INTO l_glae002 FROM glae_t WHERE glaeent = g_enterprise AND glae001 = g_glad.glad0261
      IF l_glae002 = '2' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] =g_glad.glad0261
         LET g_ref_fields[2] =g_nmde_d[l_ac].glaq038
         CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","")
            RETURNING g_rtn_fields
         LET g_nmde_d[l_ac].glaq038_desc= g_rtn_fields[1]
      ELSE
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_nmde_d[l_ac].glaq038
         CALL anmt820_02_make_sql_desc(g_glad.glad0261) RETURNING l_sql
         CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
         LET g_nmde_d[l_ac].glaq038_desc= g_rtn_fields[1]   
      END IF  
      LET g_nmde_d[l_ac].glaq038_desc = g_nmde_d[l_ac].glaq038 CLIPPED ,' ',g_nmde_d[l_ac].glaq038_desc  
   END IF
 
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Usage..........: CALL anmt820_02_b_fill_1(p_wc2)
# Input parameter:  
# Date & Author..: 2014/8/19 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt820_02_b_fill_1(p_wc2)
   DEFINE p_wc2           STRING
   DEFINE l_8318_11       LIKE gzcb_t.gzcb002      #重評價匯兌收益科目
   DEFINE l_8318_12       LIKE gzcb_t.gzcb002      #重評價匯兌損失科目
   DEFINE l_count         LIKE type_t.num5

   SELECT glab005 INTO l_8318_11 FROM glab_t WHERE glabent = g_enterprise
      AND glab002 = '8318'
      AND glab003 = '8318_11'
      AND glabld  = g_nmdeld

   SELECT glab005 INTO l_8318_12 FROM glab_t WHERE glabent = g_enterprise
      AND glab002 = '8318'
      AND glab003 = '8318_12'
      AND glabld  = g_nmdeld


   #SELECT COUNT(*) INTO l_count FROM s_anmt820_nm_group #160627-00016#1
   SELECT COUNT(*) INTO l_count FROM anmt820_tmp01    #160627-00016#1    #160727-00019#33 Mod  s_anmt820_nm_tmp--> anmt820_tmp01
   DISPLAY '筆數: ',l_count

   #LET g_sql = "  SELECT docno,glaq018,glaq019,glaq017,glaq024,glaq027,glaq028,",  #作為Key值    #160627-00016#1
   LET g_sql = "  SELECT nmde004,glaq018,glaq019,glaq017,glaq024,glaq027,glaq028,",  #作為Key值   #160627-00016#1
               "         glaq002,SUM(d + c),                             ",  #科目+金額
               "         glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,",  #自由核算項
               "         glaq035,glaq036,glaq037,glaq038                 ",  #自由核算項
               #"    FROM s_anmt820_nm_group ", #160627-00016#1
               "    FROM anmt820_tmp01 ",  #160627-00016#1   #160727-00019#33 Mod  s_anmt820_nm_tmp--> anmt820_tmp01
               "   WHERE glaq002 IN( '",l_8318_11,"','",l_8318_12,"')    ",
               #"GROUP BY docno,glaq018,glaq019,glaq017,glaq024,glaq027,glaq028,",   #160627-00016#1
               "GROUP BY nmde004,glaq018,glaq019,glaq017,glaq024,glaq027,glaq028,",  #160627-00016#1
               "         glaq002,glaq029,glaq030,glaq031,glaq032,glaq033,", 
               "         glaq034,glaq035,glaq036,glaq037,glaq038         "
   PREPARE anmt820_02_pb_1 FROM g_sql
   DECLARE b_fill_curs_1 CURSOR FOR anmt820_02_pb_1

   OPEN b_fill_curs_1

   CALL g_nmde_d.clear()

   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
   
   FOREACH b_fill_curs_1 INTO g_nmde_d[l_ac].nmde004,g_nmde_d[l_ac].nmde006,  g_nmde_d[l_ac].nmde007,       g_nmde_d[l_ac].nmde005,
                            g_nmde_d[l_ac].nmde010,  g_nmde_d[l_ac].nmde013,       g_nmde_d[l_ac].nmde014,
                            g_nmde_d[l_ac].glab005,  g_nmde_d[l_ac].nmde106_desc,  g_nmde_d[l_ac].glaq029,
                            g_nmde_d[l_ac].glaq030,  g_nmde_d[l_ac].glaq031,       g_nmde_d[l_ac].glaq032,
                            g_nmde_d[l_ac].glaq033,  g_nmde_d[l_ac].glaq034,       g_nmde_d[l_ac].glaq035,
                            g_nmde_d[l_ac].glaq036,  g_nmde_d[l_ac].glaq037,       g_nmde_d[l_ac].glaq038

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      #161212-00005#2---modify-----begin-------------
      #SELECT * INTO g_glad.* 
      SELECT gladent,gladownid,gladowndp,gladcrtid,gladcrtdp,gladcrtdt,gladmodid,gladmoddt,gladstus,gladld,
      glad001,glad002,glad003,glad004,glad005,glad006,glad007,glad008,glad009,glad010,glad011,glad012,glad013,
      glad014,glad015,glad016,glad017,glad0171,glad0172,glad018,glad0181,glad0182,glad019,glad0191,glad0192,
      glad020,glad0201,glad0202,glad021,glad0211,glad0212,glad022,glad0221,glad0222,glad023,glad0231,glad0232,
      glad024,glad0241,glad0242,glad025,glad0251,glad0252,glad026,glad0261,glad0262,glad027,glad030,glad031,
      glad032,glad033,glad034,gladud001,gladud002,gladud003,gladud004,gladud005,gladud006,gladud007,gladud008,
      gladud009,gladud010,gladud011,gladud012,gladud013,gladud014,gladud015,gladud016,gladud017,gladud018,
      gladud019,gladud020,gladud021,gladud022,gladud023,gladud024,gladud025,gladud026,gladud027,gladud028,
      gladud029,gladud030,glad035,glad036 INTO g_glad.* 
      #161212-00005#2---modify-----end-------------
      FROM glad_t
       WHERE gladent = g_enterprise AND gladld  = g_nmdeld AND glad001 = g_nmde_d[l_ac].glab005

      CALL anmt820_02_detail_show()      

      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF

   END FOREACH

   IF l_ac > g_max_rec THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9035
         LET g_errparam.extend = "nmde_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

      END IF
   END IF 
   LET g_error_show = 0

   CALL g_nmde_d.deleteElement(g_nmde_d.getLength())   
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_nmde_d.getLength()

   END FOR

   LET g_detail_cnt = l_ac - 1
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   LET l_ac = g_cnt
   LET g_cnt = 0

   CLOSE b_fill_curs_1
   FREE anmt820_02_pb_1   
      
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmt820_02_update_b_1()
# Input parameter:  
# Date & Author..: 2014/8/19 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt820_02_update_b_1()
   DEFINE l_sql           STRING
   DEFINE l_key1,l_key2   STRING
   DEFINE l_key3,l_key4   STRING
   DEFINE l_key5,l_key6   STRING
   #160627-00016#1 add s---
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
   #160627-00016#1 add e---
   IF g_nmde_d[l_ac].nmde006 IS NULL THEN LET l_key1 = "IS NULL" ELSE LET l_key1 = "= '",g_nmde_d[l_ac].nmde006,"'" END IF
   IF g_nmde_d[l_ac].nmde007 IS NULL THEN LET l_key2 = "IS NULL" ELSE LET l_key2 = "= '",g_nmde_d[l_ac].nmde007,"'" END IF
   IF g_nmde_d[l_ac].nmde005 IS NULL THEN LET l_key3 = "IS NULL" ELSE LET l_key3 = "= '",g_nmde_d[l_ac].nmde005,"'" END IF
   IF g_nmde_d[l_ac].nmde010 IS NULL THEN LET l_key4 = "IS NULL" ELSE LET l_key4 = "= '",g_nmde_d[l_ac].nmde010,"'" END IF
   IF g_nmde_d[l_ac].nmde013 IS NULL THEN LET l_key5 = "IS NULL" ELSE LET l_key5 = "= '",g_nmde_d[l_ac].nmde013,"'" END IF
   IF g_nmde_d[l_ac].nmde014 IS NULL THEN LET l_key6 = "IS NULL" ELSE LET l_key6 = "= '",g_nmde_d[l_ac].nmde014,"'" END IF

   #LET l_sql = " UPDATE s_anmt820_nm_group SET glaq029 = '",g_nmde_d[l_ac].glaq029,"',",  #160627-00016#1
   LET l_sql = " UPDATE anmt820_tmp01 SET      glaq029 = '",g_nmde_d[l_ac].glaq029,"',",   #160627-00016#1         #160727-00019#33 Mod  s_anmt820_nm_tmp--> anmt820_tmp01
               "                               glaq030 = '",g_nmde_d[l_ac].glaq030,"',",
               "                               glaq031 = '",g_nmde_d[l_ac].glaq031,"',",
               "                               glaq032 = '",g_nmde_d[l_ac].glaq032,"',",
               "                               glaq033 = '",g_nmde_d[l_ac].glaq033,"',",
               "                               glaq034 = '",g_nmde_d[l_ac].glaq034,"',",
               "                               glaq035 = '",g_nmde_d[l_ac].glaq035,"',",
               "                               glaq036 = '",g_nmde_d[l_ac].glaq036,"',",
               "                               glaq037 = '",g_nmde_d[l_ac].glaq037,"',",
               "                               glaq038 = '",g_nmde_d[l_ac].glaq038,"' ",
               " WHERE glaq002 = '",g_nmde_d[l_ac].glab005,"'",
               "   AND glaq018 ",l_key1,
               "   AND glaq019 ",l_key2,
               "   AND glaq017 ",l_key3, 
               "   AND glaq024 ",l_key4, 
               "   AND glaq027 ",l_key5,
               "   AND glaq028 ",l_key6
   PREPARE anmt820_02_update FROM l_sql
   EXECUTE anmt820_02_update
   
 
    
    
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmt820_02_make_sql_desc(p_glae001)
# Input parameter:  
# Date & Author..: 2014/8/19 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt820_02_make_sql_desc(p_glae001)
   DEFINE p_glae001   LIKE glae_t.glae001   #核算项类型
   #DEFINE p_field_value   LIKE glaf_t.glaf002   #核算项值
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
   PREPARE anmt820_02_pr FROM li_sql1
   DECLARE anmt820_02_cs1 CURSOR FOR anmt820_02_pr
   FOREACH anmt820_02_cs1 INTO li_main[l_i].dzeb002
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
   PREPARE anmt820_02_pr2 FROM li_sql2
   DECLARE anmt820_02_cs2 CURSOR FOR anmt820_02_pr2
   FOREACH anmt820_02_cs2 INTO li_dlang[l_i2].dzeb002
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
   PREPARE anmt820_02_make_sql_pre1 FROM l_sql
   DECLARE anmt820_02_make_sql_cs1 CURSOR FOR anmt820_02_make_sql_pre1
   FOREACH anmt820_02_make_sql_cs1 INTO l_dzeb002,l_dzeb006
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
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmt820_02_make_sql(p_glae003,p_glae004,p_glaf002)
# Input parameter:  
# Date & Author..: 2014/8/19 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt820_02_make_sql(p_glae003,p_glae004,p_glaf002)
   DEFINE p_glae003 LIKE glae_t.glae003    #来源档案
   DEFINE p_glae004 LIKE glae_t.glae004    #来源编号栏位
   DEFINE p_glaf002 LIKE glaf_t.glaf002    #核算项值
   DEFINE l_dzeb002 LIKE dzeb_t.dzeb002
   DEFINE l_dzeb006 LIKE dzeb_t.dzeb006
   DEFINE l_sql     STRING
   DEFINE r_sql     STRING

   LET r_sql = " SELECT count(*) FROM ",p_glae003 ,
               "  WHERE ", p_glae004," = '",p_glaf002,"'"
               
   LET l_sql = "SELECT dzeb002,dzeb006 FROM dzeb_t ",
               " WHERE dzeb001 = '", p_glae003,"'"
   PREPARE anmt820_02_make_sql_pre FROM l_sql
   DECLARE anmt820_02_make_sql_cs CURSOR FOR anmt820_02_make_sql_pre
   FOREACH anmt820_02_make_sql_cs INTO l_dzeb002,l_dzeb006
      #判断是否有ent栏位
      IF l_dzeb006 = 'N802' THEN
         LET r_sql = r_sql CLIPPED," AND ",l_dzeb002 ," ='",g_enterprise,"' "
      END IF
      #判断是否有stus栏位
      IF l_dzeb002 LIKE '%stus'  THEN
         LET r_sql = r_sql CLIPPED," AND ",l_dzeb002 ," ='Y'"
      END IF
   END FOREACH
   RETURN r_sql
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........: #161110-00001#2 mod p_ooea001 -> p_ooef001
# Usage..........: CALL anmt820_02_nmde007_desc(p_ooea001)
# Date & Author..: 2014/8/21 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt820_02_nmde007_desc(p_ooef001)
#  DEFINE p_ooea001  LIKE ooea_t.ooea001    #161110-00001#2 MARK
   DEFINE p_ooef001  LIKE ooef_t.ooef001    #161110-00001#2 ADD   
   DEFINE r_ooefl003 LIKE ooefl_t.ooefl003
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_ooef001         #161110-00001#2 mod p_ooea001 -> p_ooef001 
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_ooefl003 = g_rtn_fields[1] 
   LET r_ooefl003 = g_nmde_d[l_ac].nmde007 CLIPPED,r_ooefl003
   RETURN r_ooefl003
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:#161110-00001#2 mod p_ooea001 -> p_ooef001
# Usage..........: CALL anmt820_02_nmde006_desc(p_ooea001)
#                 
# Date & Author..: 2014/8/21 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt820_02_nmde006_desc(p_ooef001)
#DEFINE p_ooea001  LIKE ooea_t.ooea001    #161110-00001#2 MARK
 DEFINE p_ooef001  LIKE ooef_t.ooef001    #161110-00001#2 ADD   
 DEFINE r_ooefl003 LIKE ooefl_t.ooefl003
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_ooef001        #161110-00001#2 mod p_ooea001 -> p_ooef001 
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_ooefl003 = g_rtn_fields[1] 
   LET r_ooefl003 = g_nmde_d[l_ac].nmde006 CLIPPED,r_ooefl003
   RETURN r_ooefl003
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Usage..........: CALL anmt820_02_nmde010_desc()
# Input parameter:  
# Date & Author..: 2014/8/21 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt820_02_nmde010_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmde_d[l_ac].nmde010
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmde_d[l_ac].nmde010_desc = '', g_rtn_fields[1] , ''
   LET g_nmde_d[l_ac].nmde010_desc = g_nmde_d[l_ac].nmde010 CLIPPED,g_nmde_d[l_ac].nmde010_desc
   DISPLAY g_nmde_d[l_ac].nmde010_desc TO g_nmde_d[l_ac].nmde010_desc
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Usage..........: CALL anmt820_02_nmde013_desc()
# Input parameter:  
# Date & Author..: 2014/8/21 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt820_02_nmde013_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmde_d[l_ac].nmde013
   CALL ap_ref_array2(g_ref_fields,"SELECT pjbal003 FROM pjbal_t WHERE pjbalent='"||g_enterprise||"' AND pjbal001=? AND pjbal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmde_d[l_ac].nmde013_desc = '', g_rtn_fields[1] , ''
   LET g_nmde_d[l_ac].nmde013_desc = g_nmde_d[l_ac].nmde013 CLIPPED,g_nmde_d[l_ac].nmde013_desc
   DISPLAY g_nmde_d[l_ac].nmde013_desc TO g_nmde_d[l_ac].nmde013_desc
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmt820_02_nmde005_desc()
# Input parameter:  
# Date & Author..: 2014/8/21 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt820_02_nmde005_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmde_d[l_ac].nmde005
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmde_d[l_ac].nmde005_desc = '', g_rtn_fields[1] , ''
   LET g_nmde_d[l_ac].nmde005_desc = g_nmde_d[l_ac].nmde005 CLIPPED,g_nmde_d[l_ac].nmde005_desc
   DISPLAY BY NAME g_nmde_d[l_ac].nmde005_desc
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmt820_02_modify_1()
# Date & Author..: 20160627 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt820_02_modify_1()
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
   DEFINE  l_errno                LIKE type_t.chr10
   DEFINE  l_glaa004              LIKE glaa_t.glaa004
   #end add-point 
   
   #add-point:Function前置處理  name="modify.pre_function"

   #end add-point
   
   LET g_action_choice = ""
   
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
      INPUT ARRAY g_nmde_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_nmde_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL anmt820_02_b_fill(g_wc2)
            LET g_detail_cnt = g_nmde_d.getLength()
         
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
            DISPLAY g_nmde_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_nmde_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_nmde_d[l_ac].nmdeld IS NOT NULL
               AND g_nmde_d[l_ac].nmde001 IS NOT NULL
               AND g_nmde_d[l_ac].nmde002 IS NOT NULL
               AND g_nmde_d[l_ac].nmde004 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_nmde_d_t.* = g_nmde_d[l_ac].*  #BACKUP
               LET g_nmde_d_o.* = g_nmde_d[l_ac].*  #BACKUP
               IF NOT anmt820_02_lock_b("nmde_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH anmt820_02_bcl INTO g_nmde_d[l_ac].nmde001,g_nmde_d[l_ac].nmde002,g_nmde_d[l_ac].nmde004, 
                      g_nmde_d[l_ac].nmdeld,g_nmde_d[l_ac].nmde006,g_nmde_d[l_ac].nmde007,g_nmde_d[l_ac].nmde005, 
                      g_nmde_d[l_ac].nmde010,g_nmde_d[l_ac].nmde013,g_nmde_d[l_ac].nmde014
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_nmde_d_t.nmdeld,":",SQLERRMESSAGE  
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_nmde_d_mask_o[l_ac].* =  g_nmde_d[l_ac].*
                  CALL anmt820_02_nmde_t_mask()
                  LET g_nmde_d_mask_n[l_ac].* =  g_nmde_d[l_ac].*
                  
                  CALL anmt820_02_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL anmt820_02_set_entry_b(l_cmd)
            CALL anmt820_02_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
#            IF g_detail_cnt >= l_ac AND g_nmde_d[l_ac].glaq005 IS NOT NULL THEN
#               LET l_cmd='u'
#               LET g_nmde_d_t.* = g_nmde_d[l_ac].*  #BACKUP
#               SELECT * INTO g_glad.* FROM glad_t
#                WHERE gladent = g_enterprise AND gladld  = g_nmdeld 
#                  AND glad001 = g_nmde_d[l_ac].glaq005
#            ELSE
#               RETURN
#            END IF
            #160627-00016#1 add s---
            IF g_detail_cnt >= l_ac AND g_nmde_d[l_ac].glab005 IS NOT NULL THEN
               LET l_cmd='u'
               LET g_nmde_d_t.* = g_nmde_d[l_ac].*  #BACKUP
            ELSE
               RETURN
            END IF
            #160627-00016#1 add e---
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
            INITIALIZE g_nmde_d_t.* TO NULL
            INITIALIZE g_nmde_d_o.* TO NULL
            INITIALIZE g_nmde_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值(單身1)
            
            #add-point:modify段before備份 name="input.body.before_bak"

            #end add-point
            LET g_nmde_d_t.* = g_nmde_d[l_ac].*     #新輸入資料
            LET g_nmde_d_o.* = g_nmde_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_nmde_d[li_reproduce_target].* = g_nmde_d[li_reproduce].*
 
               LET g_nmde_d[g_nmde_d.getLength()].nmdeld = NULL
               LET g_nmde_d[g_nmde_d.getLength()].nmde001 = NULL
               LET g_nmde_d[g_nmde_d.getLength()].nmde002 = NULL
               LET g_nmde_d[g_nmde_d.getLength()].nmde004 = NULL
 
            END IF
            
            #add-point:modify段before insert name="input.body.before_insert"
            #150729-00002#1-----s
            #將傳入參數給到陣列中
            LET g_nmde_d[l_ac].nmdeld = g_nmdeld
            LET g_nmde_d[l_ac].nmde001 = g_nmde001
            LET g_nmde_d[l_ac].nmde002 = g_nmde002
            #150729-00002#1-----e
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
            SELECT COUNT(1) INTO l_count FROM nmde_t 
             WHERE nmdeent = g_enterprise AND nmdeld = g_nmde_d[l_ac].nmdeld
                                       AND nmde001 = g_nmde_d[l_ac].nmde001
                                       AND nmde002 = g_nmde_d[l_ac].nmde002
                                       AND nmde004 = g_nmde_d[l_ac].nmde004
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"

               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmde_d[g_detail_idx].nmdeld
               LET gs_keys[2] = g_nmde_d[g_detail_idx].nmde001
               LET gs_keys[3] = g_nmde_d[g_detail_idx].nmde002
               LET gs_keys[4] = g_nmde_d[g_detail_idx].nmde004
               CALL anmt820_02_insert_b('nmde_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_nmde_d[l_ac].* TO NULL
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "nmde_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL anmt820_02_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"

               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (nmdeld = '", g_nmde_d[l_ac].nmdeld, "' "
                                  ," AND nmde001 = '", g_nmde_d[l_ac].nmde001, "' "
                                  ," AND nmde002 = '", g_nmde_d[l_ac].nmde002, "' "
                                  ," AND nmde004 = '", g_nmde_d[l_ac].nmde004, "' "
 
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
               
               DELETE FROM nmde_t
                WHERE nmdeent = g_enterprise AND 
                      nmdeld = g_nmde_d_t.nmdeld
                      AND nmde001 = g_nmde_d_t.nmde001
                      AND nmde002 = g_nmde_d_t.nmde002
                      AND nmde004 = g_nmde_d_t.nmde004
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"

               #end add-point  
                      
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "nmde_t:",SQLERRMESSAGE 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
                  #add-point:單身刪除後 name="input.body.a_delete"

                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL anmt820_02_set_pk_array()
                  IF NOT cl_log_modified_record('','') THEN 
                  ELSE
                  END IF
               END IF 
               CLOSE anmt820_02_bcl
               #add-point:單身關閉bcl name="input.body.close"

               #end add-point
               LET l_count = g_nmde_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmde_d_t.nmdeld
               LET gs_keys[2] = g_nmde_d_t.nmde001
               LET gs_keys[3] = g_nmde_d_t.nmde002
               LET gs_keys[4] = g_nmde_d_t.nmde004
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL anmt820_02_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"

      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"

               #end add-point
                              CALL anmt820_02_delete_b('nmde_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_nmde_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"

            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde001
            #add-point:BEFORE FIELD nmde001 name="input.b.page1.nmde001"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde001
            
            #add-point:AFTER FIELD nmde001 name="input.a.page1.nmde001"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_nmde_d[g_detail_idx].nmdeld IS NOT NULL AND g_nmde_d[g_detail_idx].nmde001 IS NOT NULL AND g_nmde_d[g_detail_idx].nmde002 IS NOT NULL AND g_nmde_d[g_detail_idx].nmde004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_nmde_d[g_detail_idx].nmdeld != g_nmde_d_t.nmdeld OR g_nmde_d[g_detail_idx].nmde001 != g_nmde_d_t.nmde001 OR g_nmde_d[g_detail_idx].nmde002 != g_nmde_d_t.nmde002 OR g_nmde_d[g_detail_idx].nmde004 != g_nmde_d_t.nmde004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmde_t WHERE "||"nmdeent = '" ||g_enterprise|| "' AND "||"nmdeld = '"||g_nmde_d[g_detail_idx].nmdeld ||"' AND "|| "nmde001 = '"||g_nmde_d[g_detail_idx].nmde001 ||"' AND "|| "nmde002 = '"||g_nmde_d[g_detail_idx].nmde002 ||"' AND "|| "nmde004 = '"||g_nmde_d[g_detail_idx].nmde004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde001
            #add-point:ON CHANGE nmde001 name="input.g.page1.nmde001"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde002
            #add-point:BEFORE FIELD nmde002 name="input.b.page1.nmde002"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde002
            
            #add-point:AFTER FIELD nmde002 name="input.a.page1.nmde002"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_nmde_d[g_detail_idx].nmdeld IS NOT NULL AND g_nmde_d[g_detail_idx].nmde001 IS NOT NULL AND g_nmde_d[g_detail_idx].nmde002 IS NOT NULL AND g_nmde_d[g_detail_idx].nmde004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_nmde_d[g_detail_idx].nmdeld != g_nmde_d_t.nmdeld OR g_nmde_d[g_detail_idx].nmde001 != g_nmde_d_t.nmde001 OR g_nmde_d[g_detail_idx].nmde002 != g_nmde_d_t.nmde002 OR g_nmde_d[g_detail_idx].nmde004 != g_nmde_d_t.nmde004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmde_t WHERE "||"nmdeent = '" ||g_enterprise|| "' AND "||"nmdeld = '"||g_nmde_d[g_detail_idx].nmdeld ||"' AND "|| "nmde001 = '"||g_nmde_d[g_detail_idx].nmde001 ||"' AND "|| "nmde002 = '"||g_nmde_d[g_detail_idx].nmde002 ||"' AND "|| "nmde004 = '"||g_nmde_d[g_detail_idx].nmde004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde002
            #add-point:ON CHANGE nmde002 name="input.g.page1.nmde002"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde004
            #add-point:BEFORE FIELD nmde004 name="input.b.page1.nmde004"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde004
            
            #add-point:AFTER FIELD nmde004 name="input.a.page1.nmde004"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_nmde_d[g_detail_idx].nmdeld IS NOT NULL AND g_nmde_d[g_detail_idx].nmde001 IS NOT NULL AND g_nmde_d[g_detail_idx].nmde002 IS NOT NULL AND g_nmde_d[g_detail_idx].nmde004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_nmde_d[g_detail_idx].nmdeld != g_nmde_d_t.nmdeld OR g_nmde_d[g_detail_idx].nmde001 != g_nmde_d_t.nmde001 OR g_nmde_d[g_detail_idx].nmde002 != g_nmde_d_t.nmde002 OR g_nmde_d[g_detail_idx].nmde004 != g_nmde_d_t.nmde004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmde_t WHERE "||"nmdeent = '" ||g_enterprise|| "' AND "||"nmdeld = '"||g_nmde_d[g_detail_idx].nmdeld ||"' AND "|| "nmde001 = '"||g_nmde_d[g_detail_idx].nmde001 ||"' AND "|| "nmde002 = '"||g_nmde_d[g_detail_idx].nmde002 ||"' AND "|| "nmde004 = '"||g_nmde_d[g_detail_idx].nmde004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde004
            #add-point:ON CHANGE nmde004 name="input.g.page1.nmde004"

            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdeld
            
            #add-point:AFTER FIELD nmdeld name="input.a.page1.nmdeld"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_nmde_d[g_detail_idx].nmdeld IS NOT NULL AND g_nmde_d[g_detail_idx].nmde001 IS NOT NULL AND g_nmde_d[g_detail_idx].nmde002 IS NOT NULL AND g_nmde_d[g_detail_idx].nmde004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_nmde_d[g_detail_idx].nmdeld != g_nmde_d_t.nmdeld OR g_nmde_d[g_detail_idx].nmde001 != g_nmde_d_t.nmde001 OR g_nmde_d[g_detail_idx].nmde002 != g_nmde_d_t.nmde002 OR g_nmde_d[g_detail_idx].nmde004 != g_nmde_d_t.nmde004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmde_t WHERE "||"nmdeent = '" ||g_enterprise|| "' AND "||"nmdeld = '"||g_nmde_d[g_detail_idx].nmdeld ||"' AND "|| "nmde001 = '"||g_nmde_d[g_detail_idx].nmde001 ||"' AND "|| "nmde002 = '"||g_nmde_d[g_detail_idx].nmde002 ||"' AND "|| "nmde004 = '"||g_nmde_d[g_detail_idx].nmde004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmde_d[l_ac].nmdeld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_nmde_d[l_ac].nmdeld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmde_d[l_ac].nmdeld_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdeld
            #add-point:BEFORE FIELD nmdeld name="input.b.page1.nmdeld"

            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmdeld
            #add-point:ON CHANGE nmdeld name="input.g.page1.nmdeld"

            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab005
            
            #add-point:AFTER FIELD glab005 name="input.a.page1.glab005"
            IF NOT cl_null(g_nmde_d[l_ac].glab005) THEN 
            
            # 开窗模糊查询 150916-00015#1 --add                      
               IF s_aglt310_getlike_lc_subject(g_nmde_d[g_detail_idx].nmdeld,g_nmde_d[l_ac].glab005,"")  THEN            
                  
                  SELECT glaa004 INTO l_glaa004
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald  = g_nmde_d[g_detail_idx].nmdeld
                  
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = 'FALSE'
                  LET g_qryparam.default1 = g_nmde_d[l_ac].glab005
                                
                  LET g_qryparam.arg1 = l_glaa004
                  LET g_qryparam.arg2 = g_nmde_d[l_ac].glab005
                  LET g_qryparam.arg3 = g_nmde_d[g_detail_idx].nmdeld
                  LET g_qryparam.arg4 = " 1"
                  CALL q_glac002_6()
                  LET  g_nmde_d[l_ac].glab005 = g_qryparam.return1                 
               END IF
               # 150916-00015#1 --end
               
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmde_d[l_ac].glab005
               LET g_chkparam.arg2 = '參數2'
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"    #160318-00025#13   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_glac002_3") THEN
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
         BEFORE FIELD glab005
            #add-point:BEFORE FIELD glab005 name="input.b.page1.glab005"

            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab005
            #add-point:ON CHANGE glab005 name="input.g.page1.glab005"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab005_desc
            #add-point:BEFORE FIELD glab005_desc name="input.b.page1.glab005_desc"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab005_desc
            
            #add-point:AFTER FIELD glab005_desc name="input.a.page1.glab005_desc"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab005_desc
            #add-point:ON CHANGE glab005_desc name="input.g.page1.glab005_desc"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde106_desc
            #add-point:BEFORE FIELD nmde106_desc name="input.b.page1.nmde106_desc"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde106_desc
            
            #add-point:AFTER FIELD nmde106_desc name="input.a.page1.nmde106_desc"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde106_desc
            #add-point:ON CHANGE nmde106_desc name="input.g.page1.nmde106_desc"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde006
            #add-point:BEFORE FIELD nmde006 name="input.b.page1.nmde006"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde006
            
            #add-point:AFTER FIELD nmde006 name="input.a.page1.nmde006"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde006
            #add-point:ON CHANGE nmde006 name="input.g.page1.nmde006"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde006_desc
            #add-point:BEFORE FIELD nmde006_desc name="input.b.page1.nmde006_desc"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde006_desc
            
            #add-point:AFTER FIELD nmde006_desc name="input.a.page1.nmde006_desc"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde006_desc
            #add-point:ON CHANGE nmde006_desc name="input.g.page1.nmde006_desc"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde007
            #add-point:BEFORE FIELD nmde007 name="input.b.page1.nmde007"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde007
            
            #add-point:AFTER FIELD nmde007 name="input.a.page1.nmde007"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde007
            #add-point:ON CHANGE nmde007 name="input.g.page1.nmde007"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde007_desc
            #add-point:BEFORE FIELD nmde007_desc name="input.b.page1.nmde007_desc"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde007_desc
            
            #add-point:AFTER FIELD nmde007_desc name="input.a.page1.nmde007_desc"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde007_desc
            #add-point:ON CHANGE nmde007_desc name="input.g.page1.nmde007_desc"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde005
            #add-point:BEFORE FIELD nmde005 name="input.b.page1.nmde005"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde005
            
            #add-point:AFTER FIELD nmde005 name="input.a.page1.nmde005"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde005
            #add-point:ON CHANGE nmde005 name="input.g.page1.nmde005"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde005_desc
            #add-point:BEFORE FIELD nmde005_desc name="input.b.page1.nmde005_desc"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde005_desc
            
            #add-point:AFTER FIELD nmde005_desc name="input.a.page1.nmde005_desc"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde005_desc
            #add-point:ON CHANGE nmde005_desc name="input.g.page1.nmde005_desc"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde010
            #add-point:BEFORE FIELD nmde010 name="input.b.page1.nmde010"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde010
            
            #add-point:AFTER FIELD nmde010 name="input.a.page1.nmde010"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde010
            #add-point:ON CHANGE nmde010 name="input.g.page1.nmde010"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde010_desc
            #add-point:BEFORE FIELD nmde010_desc name="input.b.page1.nmde010_desc"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde010_desc
            
            #add-point:AFTER FIELD nmde010_desc name="input.a.page1.nmde010_desc"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde010_desc
            #add-point:ON CHANGE nmde010_desc name="input.g.page1.nmde010_desc"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde013
            #add-point:BEFORE FIELD nmde013 name="input.b.page1.nmde013"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde013
            
            #add-point:AFTER FIELD nmde013 name="input.a.page1.nmde013"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde013
            #add-point:ON CHANGE nmde013 name="input.g.page1.nmde013"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde013_desc
            #add-point:BEFORE FIELD nmde013_desc name="input.b.page1.nmde013_desc"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde013_desc
            
            #add-point:AFTER FIELD nmde013_desc name="input.a.page1.nmde013_desc"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde013_desc
            #add-point:ON CHANGE nmde013_desc name="input.g.page1.nmde013_desc"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde014
            #add-point:BEFORE FIELD nmde014 name="input.b.page1.nmde014"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde014
            
            #add-point:AFTER FIELD nmde014 name="input.a.page1.nmde014"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde014
            #add-point:ON CHANGE nmde014 name="input.g.page1.nmde014"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde014_desc
            #add-point:BEFORE FIELD nmde014_desc name="input.b.page1.nmde014_desc"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde014_desc
            
            #add-point:AFTER FIELD nmde014_desc name="input.a.page1.nmde014_desc"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde014_desc
            #add-point:ON CHANGE nmde014_desc name="input.g.page1.nmde014_desc"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq029
            #add-point:BEFORE FIELD glaq029 name="input.b.page1.glaq029"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq029
            
            #add-point:AFTER FIELD glaq029 name="input.a.page1.glaq029"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq029
            #add-point:ON CHANGE glaq029 name="input.g.page1.glaq029"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq029_desc
            #add-point:BEFORE FIELD glaq029_desc name="input.b.page1.glaq029_desc"
          LET g_nmde_d[l_ac].glaq029_desc = g_nmde_d[l_ac].glaq029
          #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
          LET g_glae002 = ''
          LET g_glae009 = ''
          SELECT glae002 INTO g_glae002 FROM glae_t WHERE glaeent = g_enterprise
             AND glae001 = g_glad.glad0171
           IF g_glae002 = '1' THEN
              SELECT glae009 INTO g_glae009 FROM glae_t WHERE glaeent = g_enterprise
                 AND glae001 = g_glad.glad0171
           END IF
           IF g_glae002 = '2' THEN LET g_glae009 = 'q_glaf002' END IF

           IF g_glae002 = '3' THEN LET g_glae009 = '' END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq029_desc
            
            #add-point:AFTER FIELD glaq029_desc name="input.a.page1.glaq029_desc"
            LET g_nmde_d[l_ac].glaq029 = g_nmde_d[l_ac].glaq029_desc
            DISPLAY '' TO glaq029_desc
            IF NOT cl_null(g_nmde_d[l_ac].glaq029) THEN
               CALL anmt820_02_free_account_chk(g_glad.glad0171,g_nmde_d[l_ac].glaq029,g_glad.glad0172) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_nmde_d[l_ac].glaq029
                  #160318-00005#29 by 07900 --add--str
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname("agli041",g_lang,"2")
                  LET g_errparam.exeprog ='agli041'
                  #160318-00005#29 by 07900 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmde_d[l_ac].glaq029 = g_nmde_d_t.glaq029
                  LET g_nmde_d[l_ac].glaq029_desc = g_nmde_d_t.glaq029_desc
                  CALL anmt820_02_free_account_desc('1')
                  DISPLAY g_nmde_d[l_ac].glaq029_desc TO s_detail1[l_ac].glaq029_desc
                  NEXT FIELD glaq029_desc
               END IF
            END IF
            CALL anmt820_02_free_account_desc('1')
            DISPLAY g_nmde_d[l_ac].glaq029_desc TO s_detail1[l_ac].glaq029_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq029_desc
            #add-point:ON CHANGE glaq029_desc name="input.g.page1.glaq029_desc"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq030
            #add-point:BEFORE FIELD glaq030 name="input.b.page1.glaq030"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq030
            
            #add-point:AFTER FIELD glaq030 name="input.a.page1.glaq030"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq030
            #add-point:ON CHANGE glaq030 name="input.g.page1.glaq030"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq030_desc
            #add-point:BEFORE FIELD glaq030_desc name="input.b.page1.glaq030_desc"
          LET g_nmde_d[l_ac].glaq030_desc = g_nmde_d[l_ac].glaq030
          #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
          LET g_glae002 = ''
          LET g_glae009 = ''
          SELECT glae002 INTO g_glae002 FROM glae_t WHERE glaeent = g_enterprise
             AND glae001 = g_glad.glad0181
           IF g_glae002 = '1' THEN
              SELECT glae009 INTO g_glae009 FROM glae_t WHERE glaeent = g_enterprise
                 AND glae001 = g_glad.glad0181
           END IF
           IF g_glae002 = '2' THEN LET g_glae009 = 'q_glaf002' END IF

           IF g_glae002 = '3' THEN LET g_glae009 = '' END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq030_desc
            
            #add-point:AFTER FIELD glaq030_desc name="input.a.page1.glaq030_desc"
            LET g_nmde_d[l_ac].glaq030 = g_nmde_d[l_ac].glaq030_desc
            DISPLAY '' TO glaq030_descesc
            IF NOT cl_null(g_nmde_d[l_ac].glaq030) THEN
               CALL anmt820_02_free_account_chk(g_glad.glad0181,g_nmde_d[l_ac].glaq030,g_glad.glad0182) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_nmde_d[l_ac].glaq030
                  #160318-00005#29 by 07900 --add--str
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname("agli041",g_lang,"2")
                  LET g_errparam.exeprog ='agli041'
                  #160318-00005#29 by 07900 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmde_d[l_ac].glaq030 = g_nmde_d_t.glaq030
                  LET g_nmde_d[l_ac].glaq030_desc = g_nmde_d_t.glaq030_desc
                  CALL anmt820_02_free_account_desc('2')
                  DISPLAY g_nmde_d[l_ac].glaq030_desc TO s_detail1[l_ac].glaq030_desc
                  NEXT FIELD glaq030_desc
               END IF
            END IF
            CALL anmt820_02_free_account_desc('2')
            DISPLAY g_nmde_d[l_ac].glaq030_desc TO s_detail1[l_ac].glaq030_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq030_desc
            #add-point:ON CHANGE glaq030_desc name="input.g.page1.glaq030_desc"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq031
            #add-point:BEFORE FIELD glaq031 name="input.b.page1.glaq031"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq031
            
            #add-point:AFTER FIELD glaq031 name="input.a.page1.glaq031"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq031
            #add-point:ON CHANGE glaq031 name="input.g.page1.glaq031"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq031_desc
            #add-point:BEFORE FIELD glaq031_desc name="input.b.page1.glaq031_desc"
          LET g_nmde_d[l_ac].glaq031_desc = g_nmde_d[l_ac].glaq031
          #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
          LET g_glae002 = ''
          LET g_glae009 = ''
          SELECT glae002 INTO g_glae002 FROM glae_t WHERE glaeent = g_enterprise
             AND glae001 = g_glad.glad0191
           IF g_glae002 = '1' THEN
              SELECT glae009 INTO g_glae009 FROM glae_t WHERE glaeent = g_enterprise
                 AND glae001 = g_glad.glad0191
           END IF
           IF g_glae002 = '2' THEN LET g_glae009 = 'q_glaf002' END IF

           IF g_glae002 = '3' THEN LET g_glae009 = '' END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq031_desc
            
            #add-point:AFTER FIELD glaq031_desc name="input.a.page1.glaq031_desc"
            LET g_nmde_d[l_ac].glaq031 = g_nmde_d[l_ac].glaq031_desc
            DISPLAY '' TO glaq031_desc
            IF NOT cl_null(g_nmde_d[l_ac].glaq031) THEN
               CALL anmt820_02_free_account_chk(g_glad.glad0191,g_nmde_d[l_ac].glaq031,g_glad.glad0192) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_nmde_d[l_ac].glaq031
                  #160318-00005#29 by 07900 --add--str
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname("agli041",g_lang,"2")
                  LET g_errparam.exeprog ='agli041'
                  #160318-00005#29 by 07900 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmde_d[l_ac].glaq031 = g_nmde_d_t.glaq031
                  LET g_nmde_d[l_ac].glaq031_desc = g_nmde_d_t.glaq031_desc
                  CALL anmt820_02_free_account_desc('3')
                  DISPLAY g_nmde_d[l_ac].glaq031_desc TO s_detail1[l_ac].glaq031_desc
                  NEXT FIELD glaq031_desc
               END IF
            END IF
            CALL anmt820_02_free_account_desc('3')
            DISPLAY g_nmde_d[l_ac].glaq031_desc TO s_detail1[l_ac].glaq031_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq031_desc
            #add-point:ON CHANGE glaq031_desc name="input.g.page1.glaq031_desc"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq032
            #add-point:BEFORE FIELD glaq032 name="input.b.page1.glaq032"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq032
            
            #add-point:AFTER FIELD glaq032 name="input.a.page1.glaq032"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq032
            #add-point:ON CHANGE glaq032 name="input.g.page1.glaq032"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq032_desc
            #add-point:BEFORE FIELD glaq032_desc name="input.b.page1.glaq032_desc"
            LET g_nmde_d[l_ac].glaq032_desc = g_nmde_d[l_ac].glaq032
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET g_glae002 = ''
            LET g_glae009 = ''
            SELECT glae002 INTO g_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = g_glad0201
             IF g_glae002 = '1' THEN
                SELECT glae009 INTO g_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad0201
             END IF 
             IF g_glae002 = '2' THEN
                LET g_glae009 = 'q_glaf002'
             END IF 
             
             IF g_glae002 = '3' THEN
                LET g_glae009 = ''
             END IF 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq032_desc
            
            #add-point:AFTER FIELD glaq032_desc name="input.a.page1.glaq032_desc"
            LET g_nmde_d[l_ac].glaq032 = g_nmde_d[l_ac].glaq032_desc
            DISPLAY '' TO glaq032_desc
            IF NOT cl_null(g_nmde_d[l_ac].glaq032) THEN
               CALL anmt820_02_free_account_chk(g_glad.glad0201,g_nmde_d[l_ac].glaq032,g_glad.glad0202) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_nmde_d[l_ac].glaq032
                  #160318-00005#29 by 07900 --add--str
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname("agli041",g_lang,"2")
                  LET g_errparam.exeprog ='agli041'
                  #160318-00005#29 by 07900 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmde_d[l_ac].glaq032 = g_nmde_d_t.glaq032
                  LET g_nmde_d[l_ac].glaq032_desc = g_nmde_d_t.glaq032_desc
                  CALL anmt820_02_free_account_desc('4')
                  DISPLAY g_nmde_d[l_ac].glaq032_desc TO s_detail1[l_ac].glaq032_desc
                  NEXT FIELD glaq032_desc
               END IF
            END IF
            CALL anmt820_02_free_account_desc('4')
            DISPLAY g_nmde_d[l_ac].glaq032_desc TO s_detail1[l_ac].glaq032_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq032_desc
            #add-point:ON CHANGE glaq032_desc name="input.g.page1.glaq032_desc"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq033
            #add-point:BEFORE FIELD glaq033 name="input.b.page1.glaq033"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq033
            
            #add-point:AFTER FIELD glaq033 name="input.a.page1.glaq033"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq033
            #add-point:ON CHANGE glaq033 name="input.g.page1.glaq033"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq033_desc
            #add-point:BEFORE FIELD glaq033_desc name="input.b.page1.glaq033_desc"
          LET g_nmde_d[l_ac].glaq033_desc = g_nmde_d[l_ac].glaq033
          #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
          LET g_glae002 = ''
          LET g_glae009 = ''
          SELECT glae002 INTO g_glae002 FROM glae_t WHERE glaeent = g_enterprise
             AND glae001 = g_glad.glad0211
           IF g_glae002 = '1' THEN
              SELECT glae009 INTO g_glae009 FROM glae_t WHERE glaeent = g_enterprise
                 AND glae001 = g_glad.glad0211
           END IF
           IF g_glae002 = '2' THEN LET g_glae009 = 'q_glaf002' END IF

           IF g_glae002 = '3' THEN LET g_glae009 = '' END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq033_desc
            
            #add-point:AFTER FIELD glaq033_desc name="input.a.page1.glaq033_desc"
            LET g_nmde_d[l_ac].glaq033 = g_nmde_d[l_ac].glaq033_desc
            DISPLAY '' TO glaq033_desc
            IF NOT cl_null(g_nmde_d[l_ac].glaq033) THEN
               CALL anmt820_02_free_account_chk(g_glad.glad0211,g_nmde_d[l_ac].glaq033,g_glad.glad0212) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_nmde_d[l_ac].glaq033
                  #160318-00005#29 by 07900 --add--str
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname("agli041",g_lang,"2")
                  LET g_errparam.exeprog ='agli041'
                  #160318-00005#29 by 07900 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmde_d[l_ac].glaq033 = g_nmde_d_t.glaq033
                  LET g_nmde_d[l_ac].glaq033_desc = g_nmde_d_t.glaq033_desc
                  CALL anmt820_02_free_account_desc('5')
                  DISPLAY g_nmde_d[l_ac].glaq033_desc TO s_detail1[l_ac].glaq033_desc
                  NEXT FIELD glaq033_desc
               END IF
            END IF
            CALL anmt820_02_free_account_desc('5')
            DISPLAY g_nmde_d[l_ac].glaq033_desc TO s_detail1[l_ac].glaq033_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq033_desc
            #add-point:ON CHANGE glaq033_desc name="input.g.page1.glaq033_desc"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq034
            #add-point:BEFORE FIELD glaq034 name="input.b.page1.glaq034"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq034
            
            #add-point:AFTER FIELD glaq034 name="input.a.page1.glaq034"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq034
            #add-point:ON CHANGE glaq034 name="input.g.page1.glaq034"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq034_desc
            #add-point:BEFORE FIELD glaq034_desc name="input.b.page1.glaq034_desc"
          LET g_nmde_d[l_ac].glaq034_desc = g_nmde_d[l_ac].glaq034
          #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
          LET g_glae002 = ''
          LET g_glae009 = ''
          SELECT glae002 INTO g_glae002 FROM glae_t WHERE glaeent = g_enterprise
             AND glae001 = g_glad.glad0221
           IF g_glae002 = '1' THEN
              SELECT glae009 INTO g_glae009 FROM glae_t WHERE glaeent = g_enterprise
                 AND glae001 = g_glad.glad0221
           END IF
           IF g_glae002 = '2' THEN LET g_glae009 = 'q_glaf002' END IF

           IF g_glae002 = '3' THEN LET g_glae009 = '' END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq034_desc
            
            #add-point:AFTER FIELD glaq034_desc name="input.a.page1.glaq034_desc"
            LET g_nmde_d[l_ac].glaq034 = g_nmde_d[l_ac].glaq034_desc
            DISPLAY '' TO glaq034_desc
            IF NOT cl_null(g_nmde_d[l_ac].glaq034) THEN
               CALL anmt820_02_free_account_chk(g_glad.glad0221,g_nmde_d[l_ac].glaq034,g_glad.glad0222) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_nmde_d[l_ac].glaq034
                  #160318-00005#29 by 07900 --add--str
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname("agli041",g_lang,"2")
                  LET g_errparam.exeprog ='agli041'
                  #160318-00005#29 by 07900 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmde_d[l_ac].glaq034 = g_nmde_d_t.glaq034
                  LET g_nmde_d[l_ac].glaq034_desc = g_nmde_d_t.glaq034_desc
                  CALL anmt820_02_free_account_desc('6')
                  DISPLAY g_nmde_d[l_ac].glaq034_desc TO s_detail1[l_ac].glaq034_desc
                  NEXT FIELD glaq034_desc
               END IF
            END IF
            CALL anmt820_02_free_account_desc('6')
            DISPLAY g_nmde_d[l_ac].glaq034_desc TO s_detail1[l_ac].glaq034_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq034_desc
            #add-point:ON CHANGE glaq034_desc name="input.g.page1.glaq034_desc"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq035
            #add-point:BEFORE FIELD glaq035 name="input.b.page1.glaq035"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq035
            
            #add-point:AFTER FIELD glaq035 name="input.a.page1.glaq035"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq035
            #add-point:ON CHANGE glaq035 name="input.g.page1.glaq035"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq035_desc
            #add-point:BEFORE FIELD glaq035_desc name="input.b.page1.glaq035_desc"
          LET g_nmde_d[l_ac].glaq035_desc = g_nmde_d[l_ac].glaq035
          #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
          LET g_glae002 = ''
          LET g_glae009 = ''
          SELECT glae002 INTO g_glae002 FROM glae_t WHERE glaeent = g_enterprise
             AND glae001 = g_glad.glad0231
           IF g_glae002 = '1' THEN
              SELECT glae009 INTO g_glae009 FROM glae_t WHERE glaeent = g_enterprise
                 AND glae001 = g_glad.glad0231
           END IF
           IF g_glae002 = '2' THEN LET g_glae009 = 'q_glaf002' END IF

           IF g_glae002 = '3' THEN LET g_glae009 = '' END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq035_desc
            
            #add-point:AFTER FIELD glaq035_desc name="input.a.page1.glaq035_desc"
            LET g_nmde_d[l_ac].glaq035 = g_nmde_d[l_ac].glaq035_desc
            DISPLAY '' TO glaq035_desc
            IF NOT cl_null(g_nmde_d[l_ac].glaq035) THEN
               CALL anmt820_02_free_account_chk(g_glad.glad0231,g_nmde_d[l_ac].glaq035,g_glad.glad0232) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_nmde_d[l_ac].glaq035
                  #160318-00005#29 by 07900 --add--str
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname("agli041",g_lang,"2")
                  LET g_errparam.exeprog ='agli041'
                  #160318-00005#29 by 07900 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmde_d[l_ac].glaq035 = g_nmde_d_t.glaq035
                  LET g_nmde_d[l_ac].glaq035_desc = g_nmde_d_t.glaq035_desc
                  CALL anmt820_02_free_account_desc('7')
                  DISPLAY g_nmde_d[l_ac].glaq035_desc TO s_detail1[l_ac].glaq035_desc
                  NEXT FIELD glaq035_desc
               END IF
            END IF
            CALL anmt820_02_free_account_desc('7')
            DISPLAY g_nmde_d[l_ac].glaq035_desc TO s_detail1[l_ac].glaq035_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq035_desc
            #add-point:ON CHANGE glaq035_desc name="input.g.page1.glaq035_desc"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq036
            #add-point:BEFORE FIELD glaq036 name="input.b.page1.glaq036"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq036
            
            #add-point:AFTER FIELD glaq036 name="input.a.page1.glaq036"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq036
            #add-point:ON CHANGE glaq036 name="input.g.page1.glaq036"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq036_desc
            #add-point:BEFORE FIELD glaq036_desc name="input.b.page1.glaq036_desc"
          LET g_nmde_d[l_ac].glaq036_desc = g_nmde_d[l_ac].glaq036
          #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
          LET g_glae002 = ''
          LET g_glae009 = ''
          SELECT glae002 INTO g_glae002 FROM glae_t WHERE glaeent = g_enterprise
             AND glae001 = g_glad.glad0241
           IF g_glae002 = '1' THEN
              SELECT glae009 INTO g_glae009 FROM glae_t WHERE glaeent = g_enterprise
                 AND glae001 = g_glad.glad0241
           END IF
           IF g_glae002 = '2' THEN LET g_glae009 = 'q_glaf002' END IF

           IF g_glae002 = '3' THEN LET g_glae009 = '' END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq036_desc
            
            #add-point:AFTER FIELD glaq036_desc name="input.a.page1.glaq036_desc"
            LET g_nmde_d[l_ac].glaq036 = g_nmde_d[l_ac].glaq036_desc
            DISPLAY '' TO glaq036_desc
            IF NOT cl_null(g_nmde_d[l_ac].glaq036) THEN
               CALL anmt820_02_free_account_chk(g_glad.glad0241,g_nmde_d[l_ac].glaq036,g_glad.glad0242) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_nmde_d[l_ac].glaq036
                  #160318-00005#29 by 07900 --add--str
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname("agli041",g_lang,"2")
                  LET g_errparam.exeprog ='agli041'
                  #160318-00005#29 by 07900 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmde_d[l_ac].glaq036 = g_nmde_d_t.glaq036
                  LET g_nmde_d[l_ac].glaq036_desc = g_nmde_d_t.glaq036_desc
                  CALL anmt820_02_free_account_desc('8')
                  DISPLAY g_nmde_d[l_ac].glaq036_desc TO s_detail1[l_ac].glaq036_desc
                  NEXT FIELD glaq036_desc
               END IF
            END IF
            CALL anmt820_02_free_account_desc('8')
            DISPLAY g_nmde_d[l_ac].glaq036_desc TO s_detail1[l_ac].glaq036_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq036_desc
            #add-point:ON CHANGE glaq036_desc name="input.g.page1.glaq036_desc"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq037
            #add-point:BEFORE FIELD glaq037 name="input.b.page1.glaq037"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq037
            
            #add-point:AFTER FIELD glaq037 name="input.a.page1.glaq037"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq037
            #add-point:ON CHANGE glaq037 name="input.g.page1.glaq037"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq037_desc
            #add-point:BEFORE FIELD glaq037_desc name="input.b.page1.glaq037_desc"
          LET g_nmde_d[l_ac].glaq037_desc = g_nmde_d[l_ac].glaq037
          #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
          LET g_glae002 = ''
          LET g_glae009 = ''
          SELECT glae002 INTO g_glae002 FROM glae_t WHERE glaeent = g_enterprise
             AND glae001 = g_glad.glad0251
           IF g_glae002 = '1' THEN
              SELECT glae009 INTO g_glae009 FROM glae_t WHERE glaeent = g_enterprise
                 AND glae001 = g_glad.glad0251
           END IF
           IF g_glae002 = '2' THEN LET g_glae009 = 'q_glaf002' END IF

           IF g_glae002 = '3' THEN LET g_glae009 = '' END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq037_desc
            
            #add-point:AFTER FIELD glaq037_desc name="input.a.page1.glaq037_desc"
            LET g_nmde_d[l_ac].glaq037 = g_nmde_d[l_ac].glaq037_desc
            DISPLAY '' TO glaq037_desc
            IF NOT cl_null(g_nmde_d[l_ac].glaq037) THEN
               CALL anmt820_02_free_account_chk(g_glad.glad0251,g_nmde_d[l_ac].glaq037,g_glad.glad0252) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_nmde_d[l_ac].glaq037
                  #160318-00005#29 by 07900 --add--str
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname("agli041",g_lang,"2")
                  LET g_errparam.exeprog ='agli041'
                  #160318-00005#29 by 07900 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmde_d[l_ac].glaq037 = g_nmde_d_t.glaq037
                  LET g_nmde_d[l_ac].glaq037_desc = g_nmde_d_t.glaq037_desc
                  CALL anmt820_02_free_account_desc('9')
                  DISPLAY g_nmde_d[l_ac].glaq037_desc TO s_detail1[l_ac].glaq037_desc
                  NEXT FIELD glaq037_desc
               END IF
            END IF
            CALL anmt820_02_free_account_desc('9')
            DISPLAY g_nmde_d[l_ac].glaq037_desc TO s_detail1[l_ac].glaq037_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq037_desc
            #add-point:ON CHANGE glaq037_desc name="input.g.page1.glaq037_desc"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq038
            #add-point:BEFORE FIELD glaq038 name="input.b.page1.glaq038"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq038
            
            #add-point:AFTER FIELD glaq038 name="input.a.page1.glaq038"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq038
            #add-point:ON CHANGE glaq038 name="input.g.page1.glaq038"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq038_desc
            #add-point:BEFORE FIELD glaq038_desc name="input.b.page1.glaq038_desc"
          LET g_nmde_d[l_ac].glaq038_desc = g_nmde_d[l_ac].glaq038
          #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
          LET g_glae002 = ''
          LET g_glae009 = ''
          SELECT glae002 INTO g_glae002 FROM glae_t WHERE glaeent = g_enterprise
             AND glae001 = g_glad.glad0261
           IF g_glae002 = '1' THEN
              SELECT glae009 INTO g_glae009 FROM glae_t WHERE glaeent = g_enterprise
                 AND glae001 = g_glad.glad0261
           END IF
           IF g_glae002 = '2' THEN LET g_glae009 = 'q_glaf002' END IF

           IF g_glae002 = '3' THEN LET g_glae009 = '' END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq038_desc
            
            #add-point:AFTER FIELD glaq038_desc name="input.a.page1.glaq038_desc"
            LET g_nmde_d[l_ac].glaq038 = g_nmde_d[l_ac].glaq038_desc
            DISPLAY '' TO glaq038_desc
            IF NOT cl_null(g_nmde_d[l_ac].glaq038) THEN
               CALL anmt820_02_free_account_chk(g_glad.glad0261,g_nmde_d[l_ac].glaq038,g_glad.glad0262) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_nmde_d[l_ac].glaq038
                  #160318-00005#29 by 07900 --add--str
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname("agli041",g_lang,"2")
                  LET g_errparam.exeprog ='agli041'
                  #160318-00005#29 by 07900 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmde_d[l_ac].glaq038 = g_nmde_d_t.glaq038
                  LET g_nmde_d[l_ac].glaq038_desc = g_nmde_d_t.glaq038_desc
                  CALL anmt820_02_free_account_desc('10')
                  DISPLAY g_nmde_d[l_ac].glaq038_desc TO s_detail1[l_ac].glaq038_desc
                  NEXT FIELD glaq038_desc
               END IF
            END IF
            CALL anmt820_02_free_account_desc('10')
            DISPLAY g_nmde_d[l_ac].glaq038_desc TO s_detail1[l_ac].glaq038_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq038_desc
            #add-point:ON CHANGE glaq038_desc name="input.g.page1.glaq038_desc"

            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.nmde001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde001
            #add-point:ON ACTION controlp INFIELD nmde001 name="input.c.page1.nmde001"

            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde002
            #add-point:ON ACTION controlp INFIELD nmde002 name="input.c.page1.nmde002"

            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde004
            #add-point:ON ACTION controlp INFIELD nmde004 name="input.c.page1.nmde004"

            #END add-point
 
 
         #Ctrlp:input.c.page1.nmdeld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdeld
            #add-point:ON ACTION controlp INFIELD nmdeld name="input.c.page1.nmdeld"

            #END add-point
 
 
         #Ctrlp:input.c.page1.glab005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab005
            #add-point:ON ACTION controlp INFIELD glab005 name="input.c.page1.glab005"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmde_d[l_ac].glab005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_glac002()                                #呼叫開窗

            LET g_nmde_d[l_ac].glab005 = g_qryparam.return1              

            DISPLAY g_nmde_d[l_ac].glab005 TO glab005              #

            NEXT FIELD glab005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.glab005_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab005_desc
            #add-point:ON ACTION controlp INFIELD glab005_desc name="input.c.page1.glab005_desc"

            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde106_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde106_desc
            #add-point:ON ACTION controlp INFIELD nmde106_desc name="input.c.page1.nmde106_desc"

            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde006
            #add-point:ON ACTION controlp INFIELD nmde006 name="input.c.page1.nmde006"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmde_d[l_ac].nmde006        #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001()                                         #呼叫開窗
            LET g_nmde_d[l_ac].nmde006 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_nmde_d[l_ac].nmde006 TO nmde006              #顯示到畫面上
            NEXT FIELD nmde006                  
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde006_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde006_desc
            #add-point:ON ACTION controlp INFIELD nmde006_desc name="input.c.page1.nmde006_desc"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmde_d[l_ac].nmde006        #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001()                                         #呼叫開窗
            LET g_nmde_d[l_ac].nmde006 = g_qryparam.return1        #將開窗取得的值回傳到變數
            CALL anmt820_02_nmde006_desc(g_nmde_d[l_ac].nmde006) RETURNING g_nmde_d[l_ac].nmde006_desc
            DISPLAY g_nmde_d[l_ac].nmde007_desc TO nmde007_desc             #顯示到畫面上
            NEXT FIELD nmde006  
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde007
            #add-point:ON ACTION controlp INFIELD nmde007 name="input.c.page1.nmde007"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmde_d[l_ac].nmde007               #給予default值
            LET g_qryparam.where = " (ooeg003 = '2' OR ooeg003 = '3')"
            #給予arg
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001()                                        #呼叫開窗
            LET g_nmde_d[l_ac].nmde007 = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_nmde_d[l_ac].nmde007 TO nmde007            #顯示到畫面上
            NEXT FIELD nmde007  
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde007_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde007_desc
            #add-point:ON ACTION controlp INFIELD nmde007_desc name="input.c.page1.nmde007_desc"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmde_d[l_ac].nmde007               #給予default值
            LET g_qryparam.where = " (ooeg003 = '2' OR ooeg003 = '3')"
            #給予arg
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001()                                        #呼叫開窗
            LET g_nmde_d[l_ac].nmde007 = g_qryparam.return1       #將開窗取得的值回傳到變數
            CALL anmt820_02_nmde007_desc(g_nmde_d[l_ac].nmde007) RETURNING g_nmde_d[l_ac].nmde007_desc
            DISPLAY g_nmde_d[l_ac].nmde007_desc TO nmde007_desc            #顯示到畫面上
            NEXT FIELD nmde007_desc  
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde005
            #add-point:ON ACTION controlp INFIELD nmde005 name="input.c.page1.nmde005"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmde_d[l_ac].nmde005            #給予default值
            
            #給予arg
            LET g_qryparam.arg1 = '3'
            CALL q_ooef001_04()                                #呼叫開窗

            LET g_nmde_d[l_ac].nmde005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_nmde_d[l_ac].nmde005 TO nmde005             #顯示到畫面上

            NEXT FIELD nmde005                         #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde005_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde005_desc
            #add-point:ON ACTION controlp INFIELD nmde005_desc name="input.c.page1.nmde005_desc"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmde_d[l_ac].nmde005            #給予default值
            
            #給予arg
            LET g_qryparam.arg1 = '3'
            CALL q_ooef001_04()                                #呼叫開窗

            LET g_nmde_d[l_ac].nmde005 = g_qryparam.return1              #將開窗取得的值回傳到變數              
            CALL anmt820_02_nmde005_desc()
            DISPLAY g_nmde_d[l_ac].nmde005_desc TO nmde005_desc             #顯示到畫面上
            
            NEXT FIELD nmde005_desc                         #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde010
            #add-point:ON ACTION controlp INFIELD nmde010 name="input.c.page1.nmde010"
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmde_d[l_ac].nmde010           #給予default值
            #給予arg
            CALL q_rtax001_1()                                       #呼叫開窗
            LET g_nmde_d[l_ac].nmde010 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_nmde_d[l_ac].nmde010 TO nmde010              #顯示到畫面上
            NEXT FIELD nmde010
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde010_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde010_desc
            #add-point:ON ACTION controlp INFIELD nmde010_desc name="input.c.page1.nmde010_desc"
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmde_d[l_ac].nmde010           #給予default值
            #給予arg
            CALL q_rtax001_1()                                       #呼叫開窗
            LET g_nmde_d[l_ac].nmde010 = g_qryparam.return1        #將開窗取得的值回傳到變數
            CALL anmt820_02_nmde010_desc()
            DISPLAY g_nmde_d[l_ac].nmde010_desc TO nmde010_desc              #顯示到畫面上
            NEXT FIELD nmde010_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde013
            #add-point:ON ACTION controlp INFIELD nmde013 name="input.c.page1.nmde013"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmde_d[l_ac].nmde013       #給予default值
            #給予arg
            CALL q_pjba001()                                         #呼叫開窗
            LET g_nmde_d[l_ac].nmde013 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_nmde_d[l_ac].nmde013 TO nmde13              #顯示到畫面上
            NEXT FIELD nmde013    
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde013_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde013_desc
            #add-point:ON ACTION controlp INFIELD nmde013_desc name="input.c.page1.nmde013_desc"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmde_d[l_ac].nmde013       #給予default值
            #給予arg
            CALL q_pjba001()                                         #呼叫開窗
            LET g_nmde_d[l_ac].nmde013 = g_qryparam.return1        #將開窗取得的值回傳到變數
            CALL anmt820_02_nmde013_desc()
            DISPLAY g_nmde_d[l_ac].nmde013_desc TO nmde13_desc              #顯示到畫面上
            NEXT FIELD nmde013_desc  
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde014
            #add-point:ON ACTION controlp INFIELD nmde014 name="input.c.page1.nmde014"

            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde014_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde014_desc
            #add-point:ON ACTION controlp INFIELD nmde014_desc name="input.c.page1.nmde014_desc"
			   #160627-00016#1 add s---
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmde_d[l_ac].nmde014       #給予default值
            #給予arg
            IF NOT cl_null(g_nmde_d[l_ac].nmde013) THEN
               LET g_qryparam.where = "pjbb012='1' AND pjbb001='",g_nmde_d[l_ac].nmde013,"'"
            ELSE
               LET g_qryparam.where = "pjbb012='1'"
            END IF
            CALL q_pjbb002()                                         #呼叫開窗
            LET g_nmde_d[l_ac].nmde014 = g_qryparam.return1        #將開窗取得的值回傳到變數
            CALL s_desc_get_wbs_desc(g_nmde_d[l_ac].nmde013,g_nmde_d[l_ac].nmde014) RETURNING g_nmde_d[l_ac].nmde014_desc
            LET g_nmde_d[l_ac].nmde014_desc = g_nmde_d[l_ac].nmde014 CLIPPED,g_nmde_d[l_ac].nmde014_desc
            DISPLAY g_nmde_d[l_ac].nmde014_desc TO nmde14_desc              #顯示到畫面上
            NEXT FIELD nmde014_desc 
            #160627-00016#1 add e---
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq029
            #add-point:ON ACTION controlp INFIELD glaq029 name="input.c.page1.glaq029"

            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq029_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq029_desc
            #add-point:ON ACTION controlp INFIELD glaq029_desc name="input.c.page1.glaq029_desc"
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmde_d[l_ac].glaq029             #給予default值

               #給予arg
               IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0171,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                                #呼叫開窗

               LET g_nmde_d[l_ac].glaq029 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL anmt820_02_free_account_desc('1')
               DISPLAY g_nmde_d[l_ac].glaq029_desc TO s_detail1[l_ac].glaq029_desc    #說明
               LET g_qryparam.where = ''
               NEXT FIELD glaq029_desc                          #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq030
            #add-point:ON ACTION controlp INFIELD glaq030 name="input.c.page1.glaq030"

            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq030_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq030_desc
            #add-point:ON ACTION controlp INFIELD glaq030_desc name="input.c.page1.glaq030_desc"
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmde_d[l_ac].glaq030             #給予default值

               #給予arg
               IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0181,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                                #呼叫開窗

               LET g_nmde_d[l_ac].glaq030 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL anmt820_02_free_account_desc('2')
               DISPLAY g_nmde_d[l_ac].glaq030_desc TO s_detail1[l_ac].glaq030_desc    #說明
               LET g_qryparam.where = '2'
               NEXT FIELD glaq030_desc                          #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq031
            #add-point:ON ACTION controlp INFIELD glaq031 name="input.c.page1.glaq031"

            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq031_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq031_desc
            #add-point:ON ACTION controlp INFIELD glaq031_desc name="input.c.page1.glaq031_desc"
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmde_d[l_ac].glaq031             #給予default值

               #給予arg
               IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0191,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                                #呼叫開窗

               LET g_nmde_d[l_ac].glaq031 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL anmt820_02_free_account_desc('3')
               DISPLAY g_nmde_d[l_ac].glaq031_desc TO s_detail1[l_ac].glaq031_desc    #說明
               LET g_qryparam.where = '3'
               NEXT FIELD glaq031_desc                          #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq032
            #add-point:ON ACTION controlp INFIELD glaq032 name="input.c.page1.glaq032"

            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq032_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq032_desc
            #add-point:ON ACTION controlp INFIELD glaq032_desc name="input.c.page1.glaq032_desc"
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmde_d[l_ac].glaq032             #給予default值

               #給予arg
               IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0201,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                                #呼叫開窗

               LET g_nmde_d[l_ac].glaq032 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL anmt820_02_free_account_desc('4')
               DISPLAY g_nmde_d[l_ac].glaq032_desc TO s_detail1[l_ac].glaq032_desc    #說明
               LET g_qryparam.where = '4'
               NEXT FIELD glaq032_desc                          #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq033
            #add-point:ON ACTION controlp INFIELD glaq033 name="input.c.page1.glaq033"

            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq033_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq033_desc
            #add-point:ON ACTION controlp INFIELD glaq033_desc name="input.c.page1.glaq033_desc"
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmde_d[l_ac].glaq033             #給予default值

               #給予arg
               IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0211,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                                #呼叫開窗

               LET g_nmde_d[l_ac].glaq033 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL anmt820_02_free_account_desc('5')
               DISPLAY g_nmde_d[l_ac].glaq033_desc TO s_detail1[l_ac].glaq033_desc    #說明
               LET g_qryparam.where = '5'
               NEXT FIELD glaq033_desc                          #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq034
            #add-point:ON ACTION controlp INFIELD glaq034 name="input.c.page1.glaq034"

            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq034_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq034_desc
            #add-point:ON ACTION controlp INFIELD glaq034_desc name="input.c.page1.glaq034_desc"
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmde_d[l_ac].glaq034             #給予default值

               #給予arg
               IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0221,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                                #呼叫開窗

               LET g_nmde_d[l_ac].glaq034 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL anmt820_02_free_account_desc('6')
               DISPLAY g_nmde_d[l_ac].glaq034_desc TO s_detail1[l_ac].glaq034_desc    #說明
               LET g_qryparam.where = '6'
               NEXT FIELD glaq034_desc                          #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq035
            #add-point:ON ACTION controlp INFIELD glaq035 name="input.c.page1.glaq035"

            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq035_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq035_desc
            #add-point:ON ACTION controlp INFIELD glaq035_desc name="input.c.page1.glaq035_desc"
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmde_d[l_ac].glaq035             #給予default值

               #給予arg
               IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0231,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                                #呼叫開窗

               LET g_nmde_d[l_ac].glaq035 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL anmt820_02_free_account_desc('7')
               DISPLAY g_nmde_d[l_ac].glaq035_desc TO s_detail1[l_ac].glaq035_desc    #說明
               LET g_qryparam.where = '7'
               NEXT FIELD glaq035_desc                          #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq036
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq036
            #add-point:ON ACTION controlp INFIELD glaq036 name="input.c.page1.glaq036"

            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq036_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq036_desc
            #add-point:ON ACTION controlp INFIELD glaq036_desc name="input.c.page1.glaq036_desc"
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmde_d[l_ac].glaq036             #給予default值

               #給予arg
               IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0241,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                                #呼叫開窗

               LET g_nmde_d[l_ac].glaq036 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL anmt820_02_free_account_desc('8')
               DISPLAY g_nmde_d[l_ac].glaq036_desc TO s_detail1[l_ac].glaq036_desc    #說明
               LET g_qryparam.where = '8'
               NEXT FIELD glaq036_desc                          #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq037
            #add-point:ON ACTION controlp INFIELD glaq037 name="input.c.page1.glaq037"

            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq037_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq037_desc
            #add-point:ON ACTION controlp INFIELD glaq037_desc name="input.c.page1.glaq037_desc"
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmde_d[l_ac].glaq037             #給予default值

               #給予arg
               IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0251,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                                #呼叫開窗

               LET g_nmde_d[l_ac].glaq037 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL anmt820_02_free_account_desc('9')
               DISPLAY g_nmde_d[l_ac].glaq037_desc TO s_detail1[l_ac].glaq037_desc    #說明
               LET g_qryparam.where = '9'
               NEXT FIELD glaq037_desc                          #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq038
            #add-point:ON ACTION controlp INFIELD glaq038 name="input.c.page1.glaq038"

            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq038_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq038_desc
            #add-point:ON ACTION controlp INFIELD glaq038_desc name="input.c.page1.glaq038_desc"
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmde_d[l_ac].glaq038             #給予default值

               #給予arg
               IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0261,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                                #呼叫開窗

               LET g_nmde_d[l_ac].glaq038 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL anmt820_02_free_account_desc('10')
               DISPLAY g_nmde_d[l_ac].glaq038_desc TO s_detail1[l_ac].glaq038_desc    #說明
               LET g_qryparam.where = '10'
               NEXT FIELD glaq038_desc                          #返回原欄位
            END IF
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_nmde_d[l_ac].* = g_nmde_d_t.*
               CLOSE anmt820_02_bcl
               #add-point:單身取消時 name="input.body.cancel"

               #end add-point
               EXIT DIALOG 
            END IF
#160627-00016#1 mod s---              
#            IF l_lock_sw = 'Y' THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = g_nmde_d[l_ac].nmdeld 
#               LET g_errparam.code   = -263 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
#               LET g_nmde_d[l_ac].* = g_nmde_d_t.*
#            ELSE
#               #寫入修改者/修改日期資訊(單身)
#               
#            
#               #add-point:單身修改前 name="input.body.b_update"
#
#               #end add-point
#               
#               #將遮罩欄位還原
#               CALL anmt820_02_nmde_t_mask_restore('restore_mask_o')
# 
#               UPDATE nmde_t SET (nmde001,nmde002,nmde004,nmdeld,nmde006,nmde007,nmde005,nmde010,nmde013, 
#                   nmde014) = (g_nmde_d[l_ac].nmde001,g_nmde_d[l_ac].nmde002,g_nmde_d[l_ac].nmde004, 
#                   g_nmde_d[l_ac].nmdeld,g_nmde_d[l_ac].nmde006,g_nmde_d[l_ac].nmde007,g_nmde_d[l_ac].nmde005, 
#                   g_nmde_d[l_ac].nmde010,g_nmde_d[l_ac].nmde013,g_nmde_d[l_ac].nmde014)
#                WHERE nmdeent = g_enterprise AND
#                  nmdeld = g_nmde_d_t.nmdeld #項次   
#                  AND nmde001 = g_nmde_d_t.nmde001  
#                  AND nmde002 = g_nmde_d_t.nmde002  
#                  AND nmde004 = g_nmde_d_t.nmde004   
#               #add-point:單身修改中 name="input.body.m_update"
# 
# 
# 
#               #end add-point
#                  
#               CASE
#                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "nmde_t" 
#                     LET g_errparam.code   = "std-00009" 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
#                    WHEN SQLCA.sqlcode #其他錯誤
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "nmde_t:",SQLERRMESSAGE 
#                     LET g_errparam.code   = SQLCA.sqlcode 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
#                  OTHERWISE
#                                    INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_nmde_d[g_detail_idx].nmdeld
#               LET gs_keys_bak[1] = g_nmde_d_t.nmdeld
#               LET gs_keys[2] = g_nmde_d[g_detail_idx].nmde001
#               LET gs_keys_bak[2] = g_nmde_d_t.nmde001
#               LET gs_keys[3] = g_nmde_d[g_detail_idx].nmde002
#               LET gs_keys_bak[3] = g_nmde_d_t.nmde002
#               LET gs_keys[4] = g_nmde_d[g_detail_idx].nmde004
#               LET gs_keys_bak[4] = g_nmde_d_t.nmde004
#               CALL anmt820_02_update_b('nmde_t',gs_keys,gs_keys_bak,"'1'")
#                     #資料多語言用-增/改
#                     
#                     #修改歷程記錄(修改)
#                     LET g_log1 = util.JSON.stringify(g_nmde_d_t)
#                     LET g_log2 = util.JSON.stringify(g_nmde_d[l_ac])
#                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
#                     END IF
#               END CASE
#               
#               #將遮罩欄位進行遮蔽
#               CALL anmt820_02_nmde_t_mask_restore('restore_mask_n')
#              
#               #add-point:單身修改後 name="input.body.a_update"
#
#               #end add-point
# 
#            END IF
#160627-00016#1 mode e---             
         AFTER ROW
            CALL anmt820_02_unlock_b("nmde_t")
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_nmde_d[l_ac].* = g_nmde_d_t.*
               END IF
               #add-point:單身after row name="input.body.a_close"

               #end add-point
            ELSE
            END IF
            #其他table進行unlock
            
             #add-point:單身after row name="input.body.a_row"
             #160627-00016#1 add s--- 
             IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_nmde_d[l_ac].nmdeld 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_nmde_d[l_ac].* = g_nmde_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               
            
               #add-point:單身修改前 name="input.body.b_update"

               #end add-point
               
               #將遮罩欄位還原
               CALL anmt820_02_nmde_t_mask_restore('restore_mask_o')
 
 
               #add-point:單身修改中 name="input.body.m_update"
 
               UPDATE nmde_t SET nmde006 = g_nmde_d[l_ac].nmde006,
                                 nmde007 = g_nmde_d[l_ac].nmde007,
                                 nmde005 = g_nmde_d[l_ac].nmde005,
                                 nmde010 = g_nmde_d[l_ac].nmde010,
                                 nmde013 = g_nmde_d[l_ac].nmde013, 
                                 nmde014 = g_nmde_d[l_ac].nmde014
                WHERE nmdeent = g_enterprise AND
                  nmdeld = g_nmdeld     
                  AND nmde001 = g_nmde001  
                  AND nmde002 = g_nmde002  
                  AND nmde004 = g_nmde_d_t.nmde004  
 
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmde_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                    WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmde_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmde_d[g_detail_idx].nmdeld
               LET gs_keys_bak[1] = g_nmde_d_t.nmdeld
               LET gs_keys[2] = g_nmde_d[g_detail_idx].nmde001
               LET gs_keys_bak[2] = g_nmde_d_t.nmde001
               LET gs_keys[3] = g_nmde_d[g_detail_idx].nmde002
               LET gs_keys_bak[3] = g_nmde_d_t.nmde002
               LET gs_keys[4] = g_nmde_d[g_detail_idx].nmde004
               LET gs_keys_bak[4] = g_nmde_d_t.nmde004
               CALL anmt820_02_update_b('nmde_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_nmde_d_t)
                     LET g_log2 = util.JSON.stringify(g_nmde_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL anmt820_02_nmde_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"

               #end add-point
 
            END IF
            #160627-00016#1 add e---
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
               LET g_nmde_d[li_reproduce_target].* = g_nmde_d[li_reproduce].*
 
               LET g_nmde_d[li_reproduce_target].nmdeld = NULL
               LET g_nmde_d[li_reproduce_target].nmde001 = NULL
               LET g_nmde_d[li_reproduce_target].nmde002 = NULL
               LET g_nmde_d[li_reproduce_target].nmde004 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_nmde_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_nmde_d.getLength()+1
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
               NEXT FIELD nmde001
 
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
      IF INT_FLAG OR cl_null(g_nmde_d[g_detail_idx].nmdeld) THEN
         CALL g_nmde_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_nmde_d[g_detail_idx].* = g_nmde_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"

   #end add-point
 
   CLOSE anmt820_02_bcl
END FUNCTION

 
{</section>}
 
