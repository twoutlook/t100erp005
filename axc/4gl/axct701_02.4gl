#該程式未解開Section, 採用最新樣板產出!
{<section id="axct701_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0017(2014-10-16 11:04:36), PR版次:0017(2017-04-18 18:18:53)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000126
#+ Filename...: axct701_02
#+ Description: 科目及核算項預覽
#+ Creator....: 00537(2014-10-13 14:00:16)
#+ Modifier...: 00537 -SD/PR- 09257
 
{</section>}
 
{<section id="axct701_02.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#160106-00014#1 16/2/27  By lixiang  增加價差量差成本差異分攤的類型 '15' axct716 對應的處理邏輯
#160617-00002#4 16/06/20 By zhujing  axct716 傳入axct701_01參數改為'16', 對應作業代號
#160727-00019#2 16/08/10 By 08742    系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                    Mod  s_voucher_xc_group--> vouc_grp_tmp01
#160816-00041#3 16/08/25 By 02040    增加axct717內部調撥憑證
#160812-00020#1 16/08/25 By 02040    axct706 數量跟金額需乘上-1，讓銷售出庫的數量與金額呈現正數，銷退呈現負數，所以產生憑證時，需再調整回來
#160818-00013#1 16/08/30 By 02040    axct705 在製差異轉出金額數量正負調整
#160907-00003#6 16/09/19 By 02295    增加在製轉出成本與工單入庫標準成本差異憑證 '15' axct715 對應的處理邏輯
#160920-00002#1 16/09/20 By 02295    axct702增加量差科目的處理
#                                    1.金額: 取xccn_t 本期在制转出成本与工单入库标准成本差异档的差異金額总和 SUM(xccn302)
#                                    2.科目: 取axci201後加的量差科目(25工单入库标准成本差异科目)
#                                    3.	量差金額為負數時,置於借方； 量差金額為正數量置於貸方
#170109-00015#1 17/01/09 By 00769    修正本位币二、本位币三不允许红字时分录底稿错误
#170125-00002#1 17/01/25 By 06694    判斷 l_red = 'Y' 時，單別才允許紅字否單別允許紅字。
#170215-00035#1 17/03/01 By 00537    mark160812-00020#1的修改，会导致算出来借贷反掉
#170221-00059#1 17/03/02 By 02111    1. axct706 借貸方金額相反。
#                                    2. 170125-00002#1 調整還原，案例待確認。
#170217-00057#1 17/03/31 By Reanna   增加axct719作業(專案費用分攤帳務作業)
#170411-00031#21 17/04/13 By 09257   整批調整，員工姓名，若抓oofa011顯示的，都改成抓ooag011
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
   glaq044 LIKE type_t.num20_6
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
        glaq038_desc LIKE type_t.chr80
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
DEFINE g_docno          LIKE xcea_t.xceadocno
DEFINE g_ld             LIKE xcea_t.xceald
DEFINE g_wc             STRING
DEFINE g_type           LIKE type_t.chr2 
DEFINE g_glaa121   LIKE glaa_t.glaa121
#end add-point
 
{</section>}
 
{<section id="axct701_02.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION axct701_02(--)
   #add-point:main段變數傳入 name="main.get_var"
   p_ld,p_docno,p_type,p_glaa121
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE p_ld        LIKE xcea_t.xceald
   DEFINE p_docno     LIKE xcea_t.xceadocno
   DEFINE p_type      LIKE type_t.chr2 
   DEFINE p_glaa121   LIKE glaa_t.glaa121
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化 name="main.init"
   LET g_docno = p_docno
   LET g_ld    = p_ld
   LET g_type  = p_type
   LET g_glaa121 = p_glaa121
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
   
   #add-point:main段define_sql name="main.body.define_sql"
   #如果glaa121=Y，启用分录底稿，这个元件的作用只是给临时表插入值而已
   IF g_glaa121 = 'Y' THEN
      IF NOT axct701_02_ins_tmp() THEN
         RETURN
      END IF
      RETURN
   END IF
   #end add-point 
   LET g_forupd_sql = "SELECT glaqdocno,glaqld,glaqseq,glaq001,glaq002,glaq005,glaq006,glaq010,glaq003, 
       glaq004,glaq040,glaq041,glaq043,glaq044 FROM glaq_t WHERE glaqent=? AND glaqld=? AND glaqdocno=?  
       AND glaqseq=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axct701_02_bcl CURSOR FROM g_forupd_sql
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_axct701_02 WITH FORM cl_ap_formpath("axc","axct701_02")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL axct701_02_init()   
 
   #進入選單 Menu (="N")
   CALL axct701_02_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_axct701_02
 
   
   
 
   #add-point:離開前 name="main.exit"
   LET g_action_choice = ''
   DROP TABLE vouc_grp_tmp01            #160727-00019#22 Mod  s_voucher_xc_group--> vouc_grp_tmp01
   #CALL cl_set_act_visible('insert,delete,query,modify,modify_detail',TRUE)
   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axct701_02.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axct701_02_init()
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
   
   CALL axct701_02_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="axct701_02.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION axct701_02_ui_dialog()
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
         CALL axct701_02_init()
      END IF
   
      CALL axct701_02_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_glaq_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display  name="ui_dialog.body.before_display"
               
               #end add-point
               #讓各頁籤能夠同步指到特定資料
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2 name="ui_dialog.body.before_display2"
               CALL axct701_02_b_detail()
               #end add-point
               
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL axct701_02_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   CALL axct701_02_b_detail()
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
            CALL axct701_02_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL axct701_02_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axct701_02_insert()
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
               CALL axct701_02_query()
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
            CALL axct701_02_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axct701_02_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axct701_02_set_pk_array()
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
 
{<section id="axct701_02.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axct701_02_query()
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
          glaq004,glaq040,glaq041,glaq043,glaq044 
 
         FROM s_detail1[1].glaqdocno,s_detail1[1].glaqld,s_detail1[1].glaqseq,s_detail1[1].glaq001,s_detail1[1].glaq002, 
             s_detail1[1].glacl004,s_detail1[1].glaq005,s_detail1[1].glaq006,s_detail1[1].glaq010,s_detail1[1].glaq003, 
             s_detail1[1].glaq004,s_detail1[1].glaq040,s_detail1[1].glaq041,s_detail1[1].glaq043,s_detail1[1].glaq044  
 
      
         
      
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
    
   CALL axct701_02_b_fill(g_wc2)
 
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
 
{<section id="axct701_02.insert" >}
#+ 資料新增
PRIVATE FUNCTION axct701_02_insert()
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
   CALL axct701_02_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axct701_02.modify" >}
#+ 資料修改
PRIVATE FUNCTION axct701_02_modify()
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
 
            CALL axct701_02_b_fill(g_wc2)
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
               IF NOT axct701_02_lock_b("glaq_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axct701_02_bcl INTO g_glaq_d[l_ac].glaqdocno,g_glaq_d[l_ac].glaqld,g_glaq_d[l_ac].glaqseq, 
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
                  CALL axct701_02_glaq_t_mask()
                  LET g_glaq_d_mask_n[l_ac].* =  g_glaq_d[l_ac].*
                  
                  CALL axct701_02_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL axct701_02_set_entry_b(l_cmd)
            CALL axct701_02_set_no_entry_b(l_cmd)
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
            
 
            CALL axct701_02_set_entry_b(l_cmd)
            CALL axct701_02_set_no_entry_b(l_cmd)
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
               CALL axct701_02_insert_b('glaq_t',gs_keys,"'1'")
                           
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
               #CALL axct701_02_b_fill(g_wc2)
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
                  CALL axct701_02_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_glaq_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE axct701_02_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_glaq_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glaq_d_t.glaqld
               LET gs_keys[2] = g_glaq_d_t.glaqdocno
               LET gs_keys[3] = g_glaq_d_t.glaqseq
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axct701_02_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL axct701_02_delete_b('glaq_t',gs_keys,"'1'")
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
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE axct701_02_bcl
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
               CALL axct701_02_glaq_t_mask_restore('restore_mask_o')
 
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
               CALL axct701_02_update_b('glaq_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_glaq_d_t)
                     LET g_log2 = util.JSON.stringify(g_glaq_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axct701_02_glaq_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL axct701_02_unlock_b("glaq_t")
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
 
   CLOSE axct701_02_bcl
   
END FUNCTION
 
{</section>}
 
{<section id="axct701_02.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axct701_02_delete()
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
         IF NOT axct701_02_lock_b("glaq_t") THEN
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
                           CALL axct701_02_delete_b('glaq_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axct701_02_set_pk_array()
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
   CALL axct701_02_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="axct701_02.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axct701_02_b_fill(p_wc2)              #BODY FILL UP
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2            STRING
   DEFINE ls_owndept_list  STRING  #(ver:35) add
   DEFINE ls_ownuser_list  STRING  #(ver:35) add
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE r_success       LIKE type_t.num5
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
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前 name="b_fill.sql_before"
   SELECT glaa015,glaa016,glaa019,glaa020
     INTO l_glaa015,l_glaa016,l_glaa019,l_glaa020
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_ld
      
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

   IF NOT axct701_02_create_tmp_table() THEN
      RETURN
   END IF
   CALL s_transaction_begin()

   CALL axct701_02_ins_tmp() RETURNING r_success

   IF r_success THEN
      CALL s_transaction_end('Y','Y')
   ELSE
      CALL s_transaction_end('N','Y')  
      RETURN       
   END IF
      
   LET g_sql= " SELECT DISTINCT docno,glaqld,seq,glaq001,glaq002,glaq005,glaq006,glaq010,d,c,glaq040,glaq041,glaq043,glaq044 FROM vouc_grp_tmp01 ", #160727-00019#22 Mod  s_voucher_xc_group--> vouc_grp_tmp01
              "  WHERE glaqent = ?",      #增加此段是为了规避下方的：OPEN b_fill_curs USING g_enterprise
              "  ORDER BY d DESC"
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"glaq_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axct701_02_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axct701_02_pb
   
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
      CALL axct701_02_glaq002_desc(g_glaq_d[l_ac].glaq002,g_glaq_d[l_ac].glaqseq) RETURNING l_glaq002,l_str
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
      
      CALL axct701_02_detail_show()      
 
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
      CALL axct701_02_glaq_t_mask()
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
   FREE axct701_02_pb
   
END FUNCTION
 
{</section>}
 
{<section id="axct701_02.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axct701_02_detail_show()
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
 
{<section id="axct701_02.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axct701_02_set_entry_b(p_cmd)                                                  
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
 
{<section id="axct701_02.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axct701_02_set_no_entry_b(p_cmd)                                               
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
 
{<section id="axct701_02.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axct701_02_default_search()
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
 
{<section id="axct701_02.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axct701_02_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="axct701_02.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axct701_02_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="axct701_02.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axct701_02_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="axct701_02.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axct701_02_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL axct701_02_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "glaq_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN axct701_02_bcl USING g_enterprise,
                                       g_glaq_d[g_detail_idx].glaqld,g_glaq_d[g_detail_idx].glaqdocno, 
                                           g_glaq_d[g_detail_idx].glaqseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axct701_02_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axct701_02.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axct701_02_unlock_b(ps_table)
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
      CLOSE axct701_02_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axct701_02.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION axct701_02_modify_detail_chk(ps_record)
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
 
{<section id="axct701_02.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION axct701_02_show_ownid_msg()
   #add-point:show_ownid_msg段define(客製用) name="show_ownid_msg.define_customerization"
   
   #end add-point
   #add-point:show_ownid_msg段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show_ownid_msg.define"
   
   #end add-point
  
 
   
 
END FUNCTION
#(ver:35) --- add end ---
 
{</section>}
 
{<section id="axct701_02.mask_functions" >}
&include "erp/axc/axct701_02_mask.4gl"
 
{</section>}
 
{<section id="axct701_02.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axct701_02_set_pk_array()
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
 
{<section id="axct701_02.state_change" >}
   
 
{</section>}
 
{<section id="axct701_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="axct701_02.other_function" readonly="Y" >}

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
PRIVATE FUNCTION axct701_02_glaq002_desc(p_glaq002,p_seq)
DEFINE p_glaq002           LIKE glaq_t.glaq002
DEFINE p_seq               LIKE glgb_t.glgbseq   #項次
DEFINE l_glaq002_desc      LIKE glacl_t.glacl004
DEFINE r_glaq002           STRING
#DEFINE l_oogf002_desc      LIKE oofa_t.oofa011   #170411-00031#21 by 09257 --mark
DEFINE l_oogf002_desc      LIKE ooag_t.ooag011    #170411-00031#21 by 09257 --add
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
   
   SELECT glaq017,glaq018,glaq019,glaq020,
          glaq021,glaq022,glaq023,glaq024,
          glaq025,glaq027,glaq028,glaq051,
          glaq052,glaq053
     INTO l_glaq.*
     FROM vouc_grp_tmp01            #160727-00019#22 Mod  s_voucher_xc_group--> vouc_grp_tmp01
    WHERE glaqent = g_enterprise
      AND glaq002 = p_glaq002  
      AND docno = g_docno  
      AND seq   = p_seq

   
   #抓取科目名称
   LET l_glaq002_desc = ''
   SELECT glacl004 INTO l_glaq002_desc FROM glacl_t,glaa_t
    WHERE glaaent = glaclent 
      AND glaa004 = glacl001
      AND glaclent = g_enterprise
      AND glaald = g_ld
      AND glacl002 = p_glaq002
      AND glacl003 = g_dlang  


   #组合名称以及核算项
   LET r_glaq002 = ''
   LET r_str = ''
   #營運據點
   IF NOT cl_null(l_glaq.glaq017) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glaq.glaq017
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET r_glaq002 = g_rtn_fields[1]     
      LET r_str = l_glaq.glaq017  
   END IF
   #部门
   IF NOT cl_null(l_glaq.glaq018) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glaq.glaq018
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET r_glaq002 = g_rtn_fields[1]   
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
       #170411-00031#21 by 09257 --mark_s
#      SELECT oofa011 INTO l_oogf002_desc FROM oofa_t
#       WHERE oofaent = g_enterprise
#         AND oofa001 IN (SELECT ooag002 FROM ooag_t
#                          WHERE ooagent = g_enterprise
#                            AND ooag001 = l_glaq.glaq025)
      #170411-00031#21 by 09257 --mark_e

      #170411-00031#21 by 09257 --add_s
      SELECT ooag011 INTO l_oogf002_desc 
        FROM ooag_t
       WHERE ooagent = g_enterprise AND ooag001 = l_glaq.glaq025
      #170411-00031#21 by 09257 --add_e                      
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
PRIVATE FUNCTION axct701_02_b_detail()
   INITIALIZE g_detail_m.* LIKE glaq_t.* 
   
   SELECT glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,
          glaq024,glaq025,glaq027,glaq028,glaq051,glaq052,glaq053,
          glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,
          glaq036,glaq037,glaq038
     INTO g_detail_m.glaq017,g_detail_m.glaq018,g_detail_m.glaq019,g_detail_m.glaq020,g_detail_m.glaq021,
          g_detail_m.glaq022,g_detail_m.glaq023,g_detail_m.glaq024,g_detail_m.glaq025,g_detail_m.glaq027,
          g_detail_m.glaq028,g_detail_m.glaq051,g_detail_m.glaq052,g_detail_m.glaq053,g_detail_m.glaq029,
          g_detail_m.glaq030,g_detail_m.glaq031,g_detail_m.glaq032,g_detail_m.glaq033,g_detail_m.glaq034,
          g_detail_m.glaq035,g_detail_m.glaq036,g_detail_m.glaq037,g_detail_m.glaq038          
     FROM vouc_grp_tmp01           #160727-00019#22 Mod  s_voucher_xc_group--> vouc_grp_tmp01
    WHERE glaqent = g_enterprise
      AND docno = g_docno
      AND glaq002 = g_glaq_d[g_detail_idx].glaq002
      AND seq   = g_glaq_d[g_detail_idx].glaqseq
      
   CALL axct701_02_detail_desc()   
   CALL axct701_02_free_account_desc()
      
   DISPLAY BY NAME 
           g_detail_m.glaq017,g_detail_m.glaq018,g_detail_m.glaq019,g_detail_m.glaq020,g_detail_m.glaq021,
           g_detail_m.glaq022,g_detail_m.glaq023,g_detail_m.glaq024,g_detail_m.glaq025,g_detail_m.glaq027,
           g_detail_m.glaq028,g_detail_m.glaq051,g_detail_m.glaq052,g_detail_m.glaq053,g_detail_m.glaq029,
           g_detail_m.glaq030,g_detail_m.glaq031,g_detail_m.glaq032,g_detail_m.glaq033,g_detail_m.glaq034,
           g_detail_m.glaq035,g_detail_m.glaq036,g_detail_m.glaq037,g_detail_m.glaq038
END FUNCTION
# 固定核算項說明
PRIVATE FUNCTION axct701_02_detail_desc()
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
END FUNCTION
# 自由核算項說明
PRIVATE FUNCTION axct701_02_free_account_desc()
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
     AND  gladld  = g_ld
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
      CALL axct701_02_make_sql_desc(l_glad0171) RETURNING l_sql
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
      CALL axct701_02_make_sql_desc(l_glad0181) RETURNING l_sql
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
      CALL axct701_02_make_sql_desc(l_glad0191) RETURNING l_sql
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
      CALL axct701_02_make_sql_desc(l_glad0201) RETURNING l_sql
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
      CALL axct701_02_make_sql_desc(l_glad0211) RETURNING l_sql
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
      CALL axct701_02_make_sql_desc(l_glad0221) RETURNING l_sql
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
      CALL axct701_02_make_sql_desc(l_glad0231) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail_m.glaq035_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail_m.glaq035
      CALL axct701_02_make_sql_desc(l_glad0241) RETURNING l_sql
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
      CALL axct701_02_make_sql_desc(l_glad0241) RETURNING l_sql
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
      CALL axct701_02_make_sql_desc(l_glad0251) RETURNING l_sql
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
      CALL axct701_02_make_sql_desc(l_glad0261) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_detail_m.glaq038_desc= g_rtn_fields[1]   
   END IF    
END FUNCTION
# 自由核算項說明
PRIVATE FUNCTION axct701_02_make_sql_desc(p_glae001)
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
   PREPARE axct701_02_pr FROM li_sql1
   DECLARE axct701_02_cs CURSOR FOR axct701_02_pr
   FOREACH axct701_02_cs INTO li_main[l_i].dzeb002
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
   PREPARE axct701_02_pr2 FROM li_sql2
   DECLARE axct701_02_cs2 CURSOR FOR axct701_02_pr2
   FOREACH axct701_02_cs2 INTO li_dlang[l_i2].dzeb002
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
   PREPARE axct701_02_make_sql_pre1 FROM l_sql
   DECLARE axct701_02_make_sql_cs1 CURSOR FOR axct701_02_make_sql_pre1
   FOREACH axct701_02_make_sql_cs1 INTO l_dzeb002,l_dzeb006
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
# Usage..........: CALL axct701_02_create_tmp_table()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION axct701_02_create_tmp_table()
   DEFINE r_success       LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   #检查事务中
   IF NOT s_transaction_chk('N',1) THEN
      RETURN r_success
   END IF 
   
   DROP TABLE vouc_grp_tmp01;           #160727-00019#22 Mod  s_voucher_xc_group--> vouc_grp_tmp01
   CREATE TEMP TABLE vouc_grp_tmp01(    #160727-00019#22 Mod  s_voucher_xc_group--> vouc_grp_tmp01
   docno    LIKE glaq_t.glaqdocno,
   docdt    LIKE glap_t.glapdocdt,
   type     LIKE xcea_t.xcea002,   
   sw       LIKE type_t.chr1,   
   glaqent  LIKE glaq_t.glaqent,
   glaqcomp LIKE glaq_t.glaqcomp,
   glaqld   LIKE glaq_t.glaqld,
   glaq001  LIKE glaq_t.glaq001,
   glaq002  LIKE glaq_t.glaq002,
   glaq005  LIKE glaq_t.glaq005,
   glaq006  LIKE glaq_t.glaq006,
   glaq007  LIKE glaq_t.glaq007,  #12
   glaq009  LIKE glaq_t.glaq009,
   glaq010  LIKE glaq_t.glaq010,
   glaq011  LIKE glaq_t.glaq011,
   glaq012  LIKE glaq_t.glaq012,
   glaq013  LIKE glaq_t.glaq013,
   glaq014  LIKE glaq_t.glaq014,
   glaq015  LIKE glaq_t.glaq015,
   glaq016  LIKE glaq_t.glaq016,   
   glaq017  LIKE glaq_t.glaq017,
   glaq018  LIKE glaq_t.glaq018,
   glaq019  LIKE glaq_t.glaq019,
   glaq020  LIKE glaq_t.glaq020,
   glaq021  LIKE glaq_t.glaq021,
   glaq022  LIKE glaq_t.glaq022,
   glaq023  LIKE glaq_t.glaq023,
   glaq024  LIKE glaq_t.glaq024,
   glaq025  LIKE glaq_t.glaq025,
   glaq026  LIKE glaq_t.glaq026,
   glaq027  LIKE glaq_t.glaq027,
   glaq028  LIKE glaq_t.glaq028,
   glaq051  LIKE glaq_t.glaq051,  #經營方式
   glaq052  LIKE glaq_t.glaq052,  #渠道 
   glaq053  LIKE glaq_t.glaq053,  #品牌
   glaq029  LIKE glaq_t.glaq029,
   glaq030  LIKE glaq_t.glaq030,
   glaq031  LIKE glaq_t.glaq031,
   glaq032  LIKE glaq_t.glaq032,
   glaq033  LIKE glaq_t.glaq033,
   glaq034  LIKE glaq_t.glaq034,
   glaq035  LIKE glaq_t.glaq035,
   glaq036  LIKE glaq_t.glaq036,
   glaq037  LIKE glaq_t.glaq037,
   glaq038  LIKE glaq_t.glaq038,
   d        LIKE glaq_t.glaq003,
   c        LIKE glaq_t.glaq004,
   qty      LIKE glaq_t.glaq008,
   sum      LIKE glaq_t.glaq010,
   glaq039  LIKE glaq_t.glaq039,
   glaq040  LIKE glaq_t.glaq040,
   glaq041  LIKE glaq_t.glaq041,
   glaq042  LIKE glaq_t.glaq042,
   glaq043  LIKE glaq_t.glaq043,
   glaq044  LIKE glaq_t.glaq044,
   seq      LIKE glaq_t.glaqseq,
   source   LIKE type_t.chr100,
   glaqseq  LIKE glaq_t.glaqseq    
   );
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axct701_02_ins_tmp()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axct701_02_ins_tmp()
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_glaq005       LIKE glaq_t.glaq005
   DEFINE l_glaq006       LIKE glaq_t.glaq006
   DEFINE l_glaq010       LIKE glaq_t.glaq010
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_slip          LIKE xcea_t.xceadocno
   DEFINE l_red           LIKE type_t.chr1
   #160920-00002#1---add---s
   DEFINE l_sql           STRING 
   DEFINE l_success1      LIKE type_t.num5    
   DEFINE l_xceb101       LIKE xceb_t.xceb101 
   DEFINE l_xceb102       LIKE xceb_t.xceb102 
   DEFINE l_errno         LIKE gzze_t.gzze001 
   DEFINE l_xccn302       LIKE xccn_t.xccn302
   DEFINE l_xccn302_2     LIKE xccn_t.xccn302
   DEFINE l_xccn302_3     LIKE xccn_t.xccn302
   #160920-00002#1---add---e

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
  #IF g_type = '1' OR g_type = '3' OR g_type = '4' OR g_type = '10' OR g_type = '11' OR g_type = '12' OR g_type = '13' OR g_type = '14' THEN   #axct701,axct703,axct704,axct710,axct711,axct712,axct713,axct714
   IF g_type = '3' OR g_type = '4' OR g_type = '10' OR g_type = '11' OR g_type = '12' OR g_type = '13' OR g_type = '14' THEN   #axct703,axct704,axct710,axct711,axct712,axct713,axct714   #mod 160519 160520-00014#4 axct701独立出来
      LET g_sql = " SELECT  UNIQUE xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xceb102,xceb101,",
                  "                '','','',",  #币种汇率原币金额，后续再处理进去
                  " SUM(xceb202a+xceb202b+xceb202c+xceb202d+xceb202e+xceb202f+xceb202g+xceb202h) d1,",
                  " 0 c1,",
                  " SUM(xceb212a+xceb212b+xceb212c+xceb212d+xceb212e+xceb212f+xceb212g+xceb212h) d2,",
                  " 0 c2,",
                  " SUM(xceb222a+xceb222b+xceb222c+xceb222d+xceb222e+xceb222f+xceb222g+xceb222h) d3,",
                  " 0 c3,",
                  " '',xceb108,xceb114,xceb113,xceb111,xceb109,xceb112,xceb117,xceb107,xceb119,xceb120,xceb115,xceb116,xceb118,",
                  " xceb121,xceb122,xceb123,xceb124,xceb125,xceb126,xceb127,xceb128,xceb129,xceb130",
                  "   FROM xcea_t,xceb_t",
                  "  WHERE xceaent = xcebent AND xceadocno = xcebdocno ",
                  "    AND xceaent = '",g_enterprise,"'",
                  "    AND xceadocno = '",g_docno,"' AND xceald = '",g_ld,"'" ,
                  " GROUP BY xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xceb102,xceb101,xceb108,xceb114,xceb113,xceb111,xceb109,xceb112,xceb117,xceb107,xceb119,",
                  "          xceb120,xceb115,xceb116,xceb118, xceb121,xceb122,xceb123,xceb124,xceb125,xceb126,xceb127,xceb128,xceb129,xceb130",
                  " UNION ",
                  " SELECT  UNIQUE xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xcec102,xcec101,",
                  "                '','','',",  #币种汇率原币金额，后续再处理进去
                  " 0,",
                  " SUM(xcec202a+xcec202b+xcec202c+xcec202d+xcec202e+xcec202f+xcec202g+xcec202h),",
                  " 0,",
                  " SUM(xcec212a+xcec212b+xcec212c+xcec212d+xcec212e+xcec212f+xcec212g+xcec212h),",
                  " 0,",
                  " SUM(xcec222a+xcec222b+xcec222c+xcec222d+xcec222e+xcec222f+xcec222g+xcec222h),",
                  " '',xcec108,xcec114,xcec113,xcec111,xcec109,xcec112,xcec117,xcec107,xcec119,xcec120,xcec115,xcec116,xcec118,",
                  " xcec121,xcec122,xcec123,xcec124,xcec125,xcec126,xcec127,xcec128,xcec129,xcec130",
                  "   FROM xcea_t,xcec_t",
                  "  WHERE xceaent = xcecent AND xceadocno = xcecdocno ",
                  "    AND xceaent = '",g_enterprise,"'",
                  "    AND xceadocno = '",g_docno,"' AND xceald = '",g_ld,"'",
                  "    AND xcec004 <> 'DL+OH+SUB' ",
                  "    AND xcec004 <> 'ADJUST' ",  #add 160519 160520-00014#4                  
                  " GROUP BY xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xcec102,xcec101,xcec108,xcec114,xcec113,xcec111,xcec109,xcec112,xcec117,xcec107,xcec119,",
                  "          xcec120,xcec115,xcec116,xcec118, xcec121,xcec122,xcec123,xcec124,xcec125,xcec126,xcec127,xcec128,xcec129,xcec130"
   END IF
   #add 160519 160520-00014#4--s   将axct701独立出来，因为增加了xced的单身给ADJUST
   IF g_type ='1' THEN   #axct701
      LET g_sql = " SELECT  UNIQUE xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xceb102,xceb101,",
                  "                '','','',",  #币种汇率原币金额，后续再处理进去
                  " SUM(xceb202a+xceb202b+xceb202c+xceb202d+xceb202e+xceb202f+xceb202g+xceb202h) d1,",
                  " 0 c1,",
                  " SUM(xceb212a+xceb212b+xceb212c+xceb212d+xceb212e+xceb212f+xceb212g+xceb212h) d2,",
                  " 0 c2,",
                  " SUM(xceb222a+xceb222b+xceb222c+xceb222d+xceb222e+xceb222f+xceb222g+xceb222h) d3,",
                  " 0 c3,",
                  " '',xceb108,xceb114,xceb113,xceb111,xceb109,xceb112,xceb117,xceb107,xceb119,xceb120,xceb115,xceb116,xceb118,",
                  " xceb121,xceb122,xceb123,xceb124,xceb125,xceb126,xceb127,xceb128,xceb129,xceb130",
                  "   FROM xcea_t,xceb_t",
                  "  WHERE xceaent = xcebent AND xceadocno = xcebdocno ",
                  "    AND xceaent = '",g_enterprise,"'",
                  "    AND xceadocno = '",g_docno,"' AND xceald = '",g_ld,"'" ,
                  " GROUP BY xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xceb102,xceb101,xceb108,xceb114,xceb113,xceb111,xceb109,xceb112,xceb117,xceb107,xceb119,",
                  "          xceb120,xceb115,xceb116,xceb118, xceb121,xceb122,xceb123,xceb124,xceb125,xceb126,xceb127,xceb128,xceb129,xceb130",
                  " UNION ",
                  #xcec的排除ADJUST
                  " SELECT  UNIQUE xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xcec102,xcec101,",
                  "                '','','',",  #币种汇率原币金额，后续再处理进去
                  " 0,",
                  " SUM(xcec202a+xcec202b+xcec202c+xcec202d+xcec202e+xcec202f+xcec202g+xcec202h),",
                  " 0,",
                  " SUM(xcec212a+xcec212b+xcec212c+xcec212d+xcec212e+xcec212f+xcec212g+xcec212h),",
                  " 0,",
                  " SUM(xcec222a+xcec222b+xcec222c+xcec222d+xcec222e+xcec222f+xcec222g+xcec222h),",
                  " '',xcec108,xcec114,xcec113,xcec111,xcec109,xcec112,xcec117,xcec107,xcec119,xcec120,xcec115,xcec116,xcec118,",
                  " xcec121,xcec122,xcec123,xcec124,xcec125,xcec126,xcec127,xcec128,xcec129,xcec130",
                  "   FROM xcea_t,xcec_t",
                  "  WHERE xceaent = xcecent AND xceadocno = xcecdocno ",
                  "    AND xceaent = '",g_enterprise,"'",
                  "    AND xceadocno = '",g_docno,"' AND xceald = '",g_ld,"'",
                  "    AND xcec004 <> 'DL+OH+SUB' ",
                  "    AND xcec004 <> 'ADJUST' ",  #add 160519 160520-00014#4 
                  " GROUP BY xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xcec102,xcec101,xcec108,xcec114,xcec113,xcec111,xcec109,xcec112,xcec117,xcec107,xcec119,",
                  "          xcec120,xcec115,xcec116,xcec118, xcec121,xcec122,xcec123,xcec124,xcec125,xcec126,xcec127,xcec128,xcec129,xcec130",
                  #取第二单身的ADJUST,且金额只取直接材料的金额
                  " UNION ",
                  " SELECT  UNIQUE xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xceb102,xceb101,",
                  "                '','','',",  #币种汇率原币金额，后续再处理进去
                  " SUM(xceb202a+xceb202b+xceb202c+xceb202d+xceb202e+xceb202f+xceb202g+xceb202h) d1,",
                  " 0 c1,",
                  " SUM(xceb212a+xceb212b+xceb212c+xceb212d+xceb212e+xceb212f+xceb212g+xceb212h) d2,",
                  " 0 c2,",
                  " SUM(xceb222a+xceb222b+xceb222c+xceb222d+xceb222e+xceb222f+xceb222g+xceb222h) d3,",
                  " 0 c3,",
                  " '',xceb108,xceb114,xceb113,xceb111,xceb109,xceb112,xceb117,xceb107,xceb119,xceb120,xceb115,xceb116,xceb118,",
                  " xceb121,xceb122,xceb123,xceb124,xceb125,xceb126,xceb127,xceb128,xceb129,xceb130",
                  "   FROM xcea_t,xceb_t",
                  "  WHERE xceaent = xcebent AND xceadocno = xcebdocno ",
                  "    AND xceaent = '",g_enterprise,"'",
                  "    AND xceadocno = '",g_docno,"' AND xceald = '",g_ld,"'" ,
                  " GROUP BY xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xceb102,xceb101,xceb108,xceb114,xceb113,xceb111,xceb109,xceb112,xceb117,xceb107,xceb119,",
                  "          xceb120,xceb115,xceb116,xceb118, xceb121,xceb122,xceb123,xceb124,xceb125,xceb126,xceb127,xceb128,xceb129,xceb130",
                  " UNION ",   #xcec的排除ADJUST
                  " SELECT  UNIQUE xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xcec102,xcec101,",
                  "                '','','',",  #币种汇率原币金额，后续再处理进去
                  " 0,",
                  " SUM(xcec202a),",
                  " 0,",
                  " SUM(xcec212a),",
                  " 0,",
                  " SUM(xcec222a),",
                  " '',xcec108,xcec114,xcec113,xcec111,xcec109,xcec112,xcec117,xcec107,xcec119,xcec120,xcec115,xcec116,xcec118,",
                  " xcec121,xcec122,xcec123,xcec124,xcec125,xcec126,xcec127,xcec128,xcec129,xcec130",
                  "   FROM xcea_t,xcec_t",
                  "  WHERE xceaent = xcecent AND xceadocno = xcecdocno ",
                  "    AND xceaent = '",g_enterprise,"'",
                  "    AND xceadocno = '",g_docno,"' AND xceald = '",g_ld,"'",
                  "    AND xcec004 = 'ADJUST' ",
                  " GROUP BY xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xcec102,xcec101,xcec108,xcec114,xcec113,xcec111,xcec109,xcec112,xcec117,xcec107,xcec119,",
                  "          xcec120,xcec115,xcec116,xcec118, xcec121,xcec122,xcec123,xcec124,xcec125,xcec126,xcec127,xcec128,xcec129,xcec130",
                  " UNION ",  #ADJUST对应的分录
                  " SELECT  UNIQUE xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xced102,xced101,", 
                  "                '','','',",  #币种汇率原币金额，后续再处理进去
                  " 0,",
                  " SUM(xced202),",
                  " 0,",
                  " SUM(xced212),",
                  " 0,",
                  " SUM(xced222),",
                  " '',xced108,xced114,xced113,xced111,xced109,xced112,xced117,xced107,xced119,xced120,xced115,xced116,xced118,",
                  " xced121,xced122,xced123,xced124,xced125,xced126,xced127,xced128,xced129,xced130",
                  "   FROM xcea_t,xced_t",
                  "  WHERE xceaent = xcedent AND xceadocno = xceddocno ",
                  "    AND xceaent = '",g_enterprise,"'",
                  "    AND xceadocno = '",g_docno,"' AND xceald = '",g_ld,"'",                        
                  "  GROUP BY xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xced102,xced101,xced108,xced114,xced113,xced111,xced109,xced112,xced117,xced107,xced119,",
                  "           xced120,xced115,xced116,xced118, xced121,xced122,xced123,xced124,xced125,xced126,xced127,xced128,xced129,xced130"
   END IF   
   #add 160519 160520-00014#4--e
   IF g_type ='2' OR g_type ='5' OR g_type ='15' THEN   #axct702 axct705 #160907-00003#6 add 15
      LET g_sql = " SELECT  UNIQUE xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xceb102,xceb101,",
                  "                '','','',",  #币种汇率原币金额，后续再处理进去
                  " SUM(xceb202a+xceb202b+xceb202c+xceb202d+xceb202e+xceb202f+xceb202g+xceb202h) d1,",
                  " 0 c1,",
                  " SUM(xceb212a+xceb212b+xceb212c+xceb212d+xceb212e+xceb212f+xceb212g+xceb212h) d2,",
                  " 0 c2,",
                  " SUM(xceb222a+xceb222b+xceb222c+xceb222d+xceb222e+xceb222f+xceb222g+xceb222h) d3,",
                  " 0 c3,",
                  " '',xceb108,xceb114,xceb113,xceb111,xceb109,xceb112,xceb117,xceb107,xceb119,xceb120,xceb115,xceb116,xceb118,",
                  " xceb121,xceb122,xceb123,xceb124,xceb125,xceb126,xceb127,xceb128,xceb129,xceb130",
                  "   FROM xcea_t,xceb_t",
                  "  WHERE xceaent = xcebent AND xceadocno = xcebdocno ",
                  "    AND xceaent = '",g_enterprise,"'",
                  "    AND xceadocno = '",g_docno,"' AND xceald = '",g_ld,"'" ,
                  " GROUP BY xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xceb102,xceb101,xceb108,xceb114,xceb113,xceb111,xceb109,xceb112,xceb117,xceb107,xceb119,",
                  "          xceb120,xceb115,xceb116,xceb118, xceb121,xceb122,xceb123,xceb124,xceb125,xceb126,xceb127,xceb128,xceb129,xceb130",
                  " UNION ",
                  " SELECT  UNIQUE xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xcec102,xcec101,",
                  "                '','','',",  #币种汇率原币金额，后续再处理进去
                  " 0,",
                  " SUM(xcec202a+xcec202b+xcec202c+xcec202d+xcec202e+xcec202f+xcec202g+xcec202h),",
                  " 0,",
                  " SUM(xcec212a+xcec212b+xcec212c+xcec212d+xcec212e+xcec212f+xcec212g+xcec212h),",
                  " 0,",
                  " SUM(xcec222a+xcec222b+xcec222c+xcec222d+xcec222e+xcec222f+xcec222g+xcec222h),",
                  " '',xcec108,xcec114,xcec113,xcec111,xcec109,xcec112,xcec117,xcec107,xcec119,xcec120,xcec115,xcec116,xcec118,",
                  " xcec121,xcec122,xcec123,xcec124,xcec125,xcec126,xcec127,xcec128,xcec129,xcec130",
                  "   FROM xcea_t,xcec_t",
                  "  WHERE xceaent = xcecent AND xceadocno = xcecdocno ",
                  "    AND xceaent = '",g_enterprise,"'",
                  "    AND xceadocno = '",g_docno,"' AND xceald = '",g_ld,"'",
                  "    AND xcec004 <> 'DL+OH+SUB' ",                  
                  " GROUP BY xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xcec102,xcec101,xcec108,xcec114,xcec113,xcec111,xcec109,xcec112,xcec117,xcec107,xcec119,",
                  "          xcec120,xcec115,xcec116,xcec118, xcec121,xcec122,xcec123,xcec124,xcec125,xcec126,xcec127,xcec128,xcec129,xcec130",
                  " UNION ",  #DL+OH+SUB对应的分录
                  " SELECT  UNIQUE xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xced102,xced101,", 
                  "                '','','',",  #币种汇率原币金额，后续再处理进去
                  " 0,",
                  " SUM(xced202),",
                  " 0,",
                  " SUM(xced212),",
                  " 0,",
                  " SUM(xced222),",
                  " '',xced108,xced114,xced113,xced111,xced109,xced112,xced117,xced107,xced119,xced120,xced115,xced116,xced118,",
                  " xced121,xced122,xced123,xced124,xced125,xced126,xced127,xced128,xced129,xced130",
                  "   FROM xcea_t,xced_t",
                  "  WHERE xceaent = xcedent AND xceadocno = xceddocno ",
                  "    AND xceaent = '",g_enterprise,"'",
                  "    AND xceadocno = '",g_docno,"' AND xceald = '",g_ld,"'",                        
                  "  GROUP BY xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xced102,xced101,xced108,xced114,xced113,xced111,xced109,xced112,xced117,xced107,xced119,",
                  "           xced120,xced115,xced116,xced118, xced121,xced122,xced123,xced124,xced125,xced126,xced127,xced128,xced129,xced130"
      #160920-00002#1---add---s
      IF g_type = '2' THEN
         #抓取25工单入库标准成本差异科目
         CALL s_fin_get_account(g_ld,'60','8912','25') RETURNING l_success,l_xceb101,l_errno
         IF NOT cl_null(l_xceb101) THEN 
            ##摘要#15在制转出成本与工单入库标准成本差异凭证摘要
            SELECT glab010 INTO l_xceb102
              FROM glab_t
             WHERE glabent = g_enterprise
               AND glabld  = g_ld
               AND glab001 = '61'
               AND glab002 = '8925'
               AND glab003 = '15'         
            LET l_sql = " SELECT SUM(xccn302) ",
                        "   FROM xcea_t,xceb_t,xccn_t",
                        "  WHERE xceadocno = xcebdocno AND xceaent = xcebent AND xceald = xcebld",
                        "    AND xccnent = xceaent AND xccnld = xceald AND xccn003 = xcea003 AND xccn004 = xcea004 AND xccn005 = xcea005 AND xccn006 = xceb001",
                        "    AND xceaent = '",g_enterprise,"'",
                        "    AND xceadocno = '",g_docno,"'",            
                        "    AND xceald = '",g_ld,"'",
                        "    AND xccn001 = ? "
            PREPARE axct701_02_get_xccn FROM l_sql
            EXECUTE axct701_02_get_xccn USING '1' INTO l_xccn302                     
            EXECUTE axct701_02_get_xccn USING '2' INTO l_xccn302_2                     
            EXECUTE axct701_02_get_xccn USING '3' INTO l_xccn302_3
            IF cl_null(l_xccn302) THEN LET l_xccn302 = 0 END IF
            IF cl_null(l_xccn302_2) THEN LET l_xccn302_2 = 0 END IF
            IF cl_null(l_xccn302_3) THEN LET l_xccn302_3 = 0 END IF
            FREE axct701_02_get_xccn         
            IF l_xccn302 < 0 THEN
               LET g_sql = g_sql,
                           " UNION ",  #量差科目的處理
                           " SELECT  UNIQUE xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,'",l_xceb102,"','",l_xceb101,"',", 
                           "                '','','',",  #币种汇率原币金额，后续再处理进去
                           " ",l_xccn302,",",  
                           " 0,",
                           " ",l_xccn302_2,",",
                           " 0,",
                           " ",l_xccn302_3,",",
                           " 0,",
                           " '',xceb108,xceb114,xceb113,xceb111,xceb109,xceb112,xceb117,xceb107,xceb119,xceb120,xceb115,xceb116,xceb118,",
                           " xceb121,xceb122,xceb123,xceb124,xceb125,xceb126,xceb127,xceb128,xceb129,xceb130",
                           "   FROM xcea_t,xceb_t",
                           "  WHERE xceaent = xcebent AND xceadocno = xcebdocno ",
                           "    AND xceaent = '",g_enterprise,"'",
                           "    AND xceadocno = '",g_docno,"' AND xceald = '",g_ld,"'" ,
                           " GROUP BY xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xceb102,xceb101,xceb108,xceb114,xceb113,xceb111,xceb109,xceb112,xceb117,xceb107,xceb119,",
                           "          xceb120,xceb115,xceb116,xceb118, xceb121,xceb122,xceb123,xceb124,xceb125,xceb126,xceb127,xceb128,xceb129,xceb130"          
            ELSE
               LET g_sql = g_sql,
                           " UNION ",  #量差科目的處理
                           " SELECT  UNIQUE xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,'",l_xceb102,"','",l_xceb101,"',", 
                           "                '','','',",  #币种汇率原币金额，后续再处理进去
                           " 0,",  
                           " ",l_xccn302,",",
                           " 0,",
                           " ",l_xccn302_2,",",
                           " 0,",
                           " ",l_xccn302_3,",",
                           " '',xcec108,xcec114,xcec113,xcec111,xcec109,xcec112,xcec117,xcec107,xcec119,xcec120,xcec115,xcec116,xcec118,",
                           " xcec121,xcec122,xcec123,xcec124,xcec125,xcec126,xcec127,xcec128,xcec129,xcec130",
                           "   FROM xcea_t,xcec_t",
                           "  WHERE xceaent = xcecent AND xceadocno = xcecdocno ",
                           "    AND xceaent = '",g_enterprise,"'",
                           "    AND xceadocno = '",g_docno,"' AND xceald = '",g_ld,"'",
                           "    AND xcec004 <> 'DL+OH+SUB' ",                  
                           " GROUP BY xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xcec102,xcec101,xcec108,xcec114,xcec113,xcec111,xcec109,xcec112,xcec117,xcec107,xcec119,",
                           "          xcec120,xcec115,xcec116,xcec118, xcec121,xcec122,xcec123,xcec124,xcec125,xcec126,xcec127,xcec128,xcec129,xcec130"               
            END IF
         END IF   
      END IF
      #160920-00002#1---add---e
   END IF   
   #170221-00059#1 add start -----
   IF g_type = '6' THEN
      LET g_sql = " SELECT  UNIQUE xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xceb102,xceb101,",
                  "                '','','',",  #币种汇率原币金额，后续再处理进去
                  " SUM(xceb202a+xceb202b+xceb202c+xceb202d+xceb202e+xceb202f+xceb202g+xceb202h) d1,",  
                  " 0 c1,",
                  " SUM(xceb212a+xceb212b+xceb212c+xceb212d+xceb212e+xceb212f+xceb212g+xceb212h) d2,",
                  " 0 c2,",
                  " SUM(xceb222a+xceb222b+xceb222c+xceb222d+xceb222e+xceb222f+xceb222g+xceb222h) d3,",
                  " 0 c3,",
                  " '',xceb108,xceb114,xceb113,xceb111,xceb109,xceb112,xceb117,xceb107,xceb119,xceb120,xceb115,xceb116,xceb118,",
                  " xceb121,xceb122,xceb123,xceb124,xceb125,xceb126,xceb127,xceb128,xceb129,xceb130",
                  "   FROM xcea_t,xceb_t",
                  "  WHERE xceaent = xcebent AND xceadocno = xcebdocno ",
                  "    AND xceaent = '",g_enterprise,"'",
                  "    AND xceadocno = '",g_docno,"' AND xceald = '",g_ld,"'" ,
                  " GROUP BY xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xceb102,xceb101,xceb108,xceb114,xceb113,xceb111,xceb109,xceb112,xceb117,xceb107,xceb119,",
                  "          xceb120,xceb115,xceb116,xceb118, xceb121,xceb122,xceb123,xceb124,xceb125,xceb126,xceb127,xceb128,xceb129,xceb130",
                  " UNION ",
                  " SELECT  UNIQUE xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xcec102,xcec101,",
                  "                '','','',",  #币种汇率原币金额，后续再处理进去
                  " 0,",
                  " SUM(xcec202a+xcec202b+xcec202c+xcec202d+xcec202e+xcec202f+xcec202g+xcec202h),",
                  " 0,",
                  " SUM(xcec212a+xcec212b+xcec212c+xcec212d+xcec212e+xcec212f+xcec212g+xcec212h),",
                  " 0,",  
                  " SUM(xcec222a+xcec222b+xcec222c+xcec222d+xcec222e+xcec222f+xcec222g+xcec222h),",
                  " '',xcec108,xcec114,xcec113,xcec111,xcec109,xcec112,xcec117,xcec107,xcec119,xcec120,xcec115,xcec116,xcec118,",
                  " xcec121,xcec122,xcec123,xcec124,xcec125,xcec126,xcec127,xcec128,xcec129,xcec130",               
                  "   FROM xcea_t,xcec_t",
                  "  WHERE xceaent = xcecent AND xceadocno = xcecdocno ",
                  "    AND xceaent = '",g_enterprise,"'",
                  "    AND xceadocno = '",g_docno,"' AND xceald = '",g_ld,"'"            
   
      LET g_sql = g_sql, " GROUP BY xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xcec102,xcec101,xcec108,xcec114,xcec113,xcec111,xcec109,xcec112,xcec117,xcec107,xcec119,",
                         "          xcec120,xcec115,xcec116,xcec118, xcec121,xcec122,xcec123,xcec124,xcec125,xcec126,xcec127,xcec128,xcec129,xcec130"  
   END IF
   IF g_type = '7' OR g_type = '8' OR g_type = '17' THEN
   #170221-00059#1 add end   -----
   #IF g_type = '6' OR g_type = '7' OR g_type = '8' OR g_type = '17' THEN   #axct707,axct708,axct706 160816-00041#3 add axct717 #170221-00059#1 mark
      LET g_sql = " SELECT  UNIQUE xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xceb102,xceb101,",
                  "                '','','',",  #币种汇率原币金额，后续再处理进去
                  " 0 d1,",  
                  " SUM(xceb202a+xceb202b+xceb202c+xceb202d+xceb202e+xceb202f+xceb202g+xceb202h) c1,",
                  " 0 d2,",
                  " SUM(xceb212a+xceb212b+xceb212c+xceb212d+xceb212e+xceb212f+xceb212g+xceb212h) c2,",
                  " 0 d3,",
                  " SUM(xceb222a+xceb222b+xceb222c+xceb222d+xceb222e+xceb222f+xceb222g+xceb222h) c3,",
                  " '',xceb108,xceb114,xceb113,xceb111,xceb109,xceb112,xceb117,xceb107,xceb119,xceb120,xceb115,xceb116,xceb118,",
                  " xceb121,xceb122,xceb123,xceb124,xceb125,xceb126,xceb127,xceb128,xceb129,xceb130",
                  "   FROM xcea_t,xceb_t",
                  "  WHERE xceaent = xcebent AND xceadocno = xcebdocno ",
                  "    AND xceaent = '",g_enterprise,"'",
                  "    AND xceadocno = '",g_docno,"' AND xceald = '",g_ld,"'" ,
                  " GROUP BY xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xceb102,xceb101,xceb108,xceb114,xceb113,xceb111,xceb109,xceb112,xceb117,xceb107,xceb119,",
                  "          xceb120,xceb115,xceb116,xceb118, xceb121,xceb122,xceb123,xceb124,xceb125,xceb126,xceb127,xceb128,xceb129,xceb130",
                  " UNION ",
                  " SELECT  UNIQUE xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xcec102,xcec101,",
                  "                '','','',",  #币种汇率原币金额，后续再处理进去
                  " SUM(xcec202a+xcec202b+xcec202c+xcec202d+xcec202e+xcec202f+xcec202g+xcec202h),",
                  " 0,",
                  " SUM(xcec212a+xcec212b+xcec212c+xcec212d+xcec212e+xcec212f+xcec212g+xcec212h),",
                  " 0,",
                  " SUM(xcec222a+xcec222b+xcec222c+xcec222d+xcec222e+xcec222f+xcec222g+xcec222h),",
                  " 0,",  
                  " '',xcec108,xcec114,xcec113,xcec111,xcec109,xcec112,xcec117,xcec107,xcec119,xcec120,xcec115,xcec116,xcec118,",
                  " xcec121,xcec122,xcec123,xcec124,xcec125,xcec126,xcec127,xcec128,xcec129,xcec130",               
                  "   FROM xcea_t,xcec_t",
                  "  WHERE xceaent = xcecent AND xceadocno = xcecdocno ",
                  "    AND xceaent = '",g_enterprise,"'",
                  "    AND xceadocno = '",g_docno,"' AND xceald = '",g_ld,"'"            
   
      LET g_sql = g_sql, " GROUP BY xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xcec102,xcec101,xcec108,xcec114,xcec113,xcec111,xcec109,xcec112,xcec117,xcec107,xcec119,",
                         "          xcec120,xcec115,xcec116,xcec118, xcec121,xcec122,xcec123,xcec124,xcec125,xcec126,xcec127,xcec128,xcec129,xcec130"  
   END IF

   IF g_type = '9' THEN    #axct709
      LET g_sql = " SELECT  UNIQUE xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xceb102,xceb101,",
                  "                '','','',",  #币种汇率原币金额，后续再处理进去
                  " 0 d1,",
                  " SUM(xceb202) c1,",
                  " 0 d2,",
                  " SUM(xceb212) c2,",
                  " 0 d3,",
                  " SUM(xceb222) c3,",
                  " '',xceb108,xceb114,xceb113,xceb111,xceb109,xceb112,xceb117,xceb107,xceb119,xceb120,xceb115,xceb116,xceb118,",
                  " xceb121,xceb122,xceb123,xceb124,xceb125,xceb126,xceb127,xceb128,xceb129,xceb130",
                  "   FROM xcea_t,xceb_t",
                  "  WHERE xceaent = xcebent AND xceadocno = xcebdocno ",
                  "    AND xceaent = '",g_enterprise,"'",
                  "    AND xceadocno = '",g_docno,"' AND xceald = '",g_ld,"'" ,
                     " GROUP BY xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xceb102,xceb101,xceb108,xceb114,xceb113,xceb111,xceb109,xceb112,xceb117,xceb107,xceb119,",
                     "          xceb120,xceb115,xceb116,xceb118, xceb121,xceb122,xceb123,xceb124,xceb125,xceb126,xceb127,xceb128,xceb129,xceb130",
                  " UNION ",
                  " SELECT  UNIQUE xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xcec102,xcec101,",
                  "                '','','',",  #币种汇率原币金额，后续再处理进去
                  " SUM(xcec202),",
                  " 0,",
                  " SUM(xcec212),",
                  " 0,",
                  " SUM(xcec222),",
                  " 0,",
                  " '',xcec108,xcec114,xcec113,xcec111,xcec109,xcec112,xcec117,xcec107,xcec119,xcec120,xcec115,xcec116,xcec118,",
                  " xcec121,xcec122,xcec123,xcec124,xcec125,xcec126,xcec127,xcec128,xcec129,xcec130",
                  "   FROM xcea_t,xcec_t",
                  "  WHERE xceaent = xcecent AND xceadocno = xcecdocno ",
                  "    AND xceaent = '",g_enterprise,"'",
                  "    AND xceadocno = '",g_docno,"' AND xceald = '",g_ld,"'",
                  " GROUP BY xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xcec102,xcec101,xcec108,xcec114,xcec113,xcec111,xcec109,xcec112,xcec117,xcec107,xcec119,",
                  "          xcec120,xcec115,xcec116,xcec118, xcec121,xcec122,xcec123,xcec124,xcec125,xcec126,xcec127,xcec128,xcec129,xcec130"                 
   END IF
   
   #160106-00014#1--add---begin---
   #160617-00002#4 mod-S
#  IF g_type = '15' THEN    #axct716
   #IF g_type = '16' THEN    #axct716 #170217-00057#1 mark
   #160617-00002#4 mod-E
   #170217-00057#1 add ------
   #axct716/axct719
   IF g_type = '16' OR g_type = '18' THEN
   #170217-00057#1 add end---
      LET g_sql = " SELECT  UNIQUE xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xceb102,xceb101,",
                  "                '','','',",  #币种汇率原币金额，后续再处理进去
                  " SUM(xceb202) d1,",
                  " 0 c1,",
                  " SUM(xceb212) d2,",
                  " 0 c2,",
                  " SUM(xceb222) d3,",
                  " 0 c3,",
                  " '',xceb108,xceb114,xceb113,xceb111,xceb109,xceb112,xceb117,xceb107,xceb119,xceb120,xceb115,xceb116,xceb118,",
                  " xceb121,xceb122,xceb123,xceb124,xceb125,xceb126,xceb127,xceb128,xceb129,xceb130",
                  "   FROM xcea_t,xceb_t",
                  "  WHERE xceaent = xcebent AND xceadocno = xcebdocno ",
                  "    AND xceaent = '",g_enterprise,"'",
                  "    AND xceadocno = '",g_docno,"' AND xceald = '",g_ld,"'" ,
                     " GROUP BY xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xceb102,xceb101,xceb108,xceb114,xceb113,xceb111,xceb109,xceb112,xceb117,xceb107,xceb119,",
                     "          xceb120,xceb115,xceb116,xceb118, xceb121,xceb122,xceb123,xceb124,xceb125,xceb126,xceb127,xceb128,xceb129,xceb130",
                  " UNION ",
                  " SELECT  UNIQUE xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xcec102,xcec101,",
                  "                '','','',",  #币种汇率原币金额，后续再处理进去
                  " 0,",
                  " SUM(xcec202),",
                  " 0,",
                  " SUM(xcec212),",
                  " 0,",
                  " SUM(xcec222),",
                  " '',xcec108,xcec114,xcec113,xcec111,xcec109,xcec112,xcec117,xcec107,xcec119,xcec120,xcec115,xcec116,xcec118,",
                  " xcec121,xcec122,xcec123,xcec124,xcec125,xcec126,xcec127,xcec128,xcec129,xcec130",
                  "   FROM xcea_t,xcec_t",
                  "  WHERE xceaent = xcecent AND xceadocno = xcecdocno ",
                  "    AND xceaent = '",g_enterprise,"'",
                  "    AND xceadocno = '",g_docno,"' AND xceald = '",g_ld,"'",
                  " GROUP BY xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xcec102,xcec101,xcec108,xcec114,xcec113,xcec111,xcec109,xcec112,xcec117,xcec107,xcec119,",
               "          xcec120,xcec115,xcec116,xcec118, xcec121,xcec122,xcec123,xcec124,xcec125,xcec126,xcec127,xcec128,xcec129,xcec130"                 
   END IF
   #160106-00014#1--add---end---
   
#加上序号
   LET g_sql = "SELECT ROWNUM,xceaent,xceadocno,xcea001,xcea002,xceald,xceacomp,xceb102,xceb101,                '','','', d1,", 
               "       c1,d2,c2,d3,c3,'',xceb108,xceb114,xceb113,xceb111,xceb109,xceb112,xceb117,xceb107,xceb119,",
               "       xceb120,xceb115,xceb116,xceb118, xceb121,xceb122,xceb123,xceb124,xceb125,xceb126,xceb127,xceb128,xceb129,xceb130 FROM (",g_sql,")"

   #add zhangllc 151227 --begin 
   IF g_type = '95' THEN   #axct950
      #成本类的：(xcjf010=3\4)                
      #借 ： 成本科目   金额     实体利润中心
      #   借：对方科目  －金额   虚拟利润中心
      #收入类：(xcjf010=1\2) 
      #贷： 收入科目   金额     实体利润中心
      #   贷：对方科目 －金额   虚拟利润中心
      #-------------------------------------
      #借 ： 成本科目   金额     实体利润中心
      #                                                       类型                  摘要     科目
      LET g_sql = " SELECT  UNIQUE xcjeent,xcjedocno,xcjedocdt,'95',xcjeld,glaacomp,xcjf030,xcjf028 account,",
                  "                '','','',",  #币种汇率原币金额，后续再处理进去
                  " SUM(xcjf201) d1,",
                  " 0 c1,",
                  " SUM(xcjf211) d2,",
                  " 0 c2,",
                  " SUM(xcjf221) d3,",
                  " 0 c3,",
                  #    部門    实体利润中心   區域 交易對象 帳款對象 客群    品類     人員    項目號   WBS     經營類別 渠道    品牌
                  " '',xcjf031,xcjf013 cost,xcjf033,xcjf034,xcjf035,xcjf036,xcjf037,xcjf041,xcjf042,xcjf043,xcjf038,xcjf039,xcjf040,",
                  # 自由核算項1~10
                  " xcjf044,xcjf045,xcjf046,xcjf047,xcjf048,xcjf049,xcjf050,xcjf051,xcjf052,xcjf053 ",
                  "   FROM xcje_t,xcjf_t,glaa_t",
                  "  WHERE xcjeent = xcjfent AND xcjeld = xcjfld AND xcjedocno = xcjfdocno ",
                  "    AND glaaent = xcjeent AND glaald = xcjeld ",
                  "    AND xcjeent = '",g_enterprise,"'",
                  "    AND xcjedocno = '",g_docno,"' AND xcjeld = '",g_ld,"'" ,
                  "    AND xcjf010 IN ('3','4') ",
                  " GROUP BY xcjeent,xcjedocno,xcjedocdt,'95',xcjeld,glaacomp,xcjf030,xcjf028, ",
                  "          xcjf031,xcjf013,xcjf033,xcjf034,xcjf035,xcjf036,xcjf037,xcjf041,xcjf042,xcjf043,xcjf038,xcjf039,xcjf040, ",
                  "          xcjf044,xcjf045,xcjf046,xcjf047,xcjf048,xcjf049,xcjf050,xcjf051,xcjf052,xcjf053",
                  " UNION ",
      #-------------------------------------
      #   借：对方科目  －金额   虚拟利润中心
                  #                                           类型                  摘要     科目
                  " SELECT  UNIQUE xcjeent,xcjedocno,xcjedocdt,'95',xcjeld,glaacomp,xcjf030,xcjf029,",
                  "                '','','',",  #币种汇率原币金额，后续再处理进去
                  " SUM(xcjf201)*-1,",
                  " 0,",
                  " SUM(xcjf211)*-1,",
                  " 0,",
                  " SUM(xcjf221)*-1,",
                  " 0,",
                  #    部門    虚拟利润中心 區域 交易對象 帳款對象 客群    品類     人員    項目號   WBS     經營類別 渠道    品牌
                  " '',xcjf031,xcjf014,xcjf033,xcjf034,xcjf035,xcjf036,xcjf037,xcjf041,xcjf042,xcjf043,xcjf038,xcjf039,xcjf040,",
                  # 自由核算項1~10
                  " xcjf044,xcjf045,xcjf046,xcjf047,xcjf048,xcjf049,xcjf050,xcjf051,xcjf052,xcjf053 ",
                  "   FROM xcje_t,xcjf_t,glaa_t",
                  "  WHERE xcjeent = xcjfent AND xcjeld = xcjfld AND xcjedocno = xcjfdocno ",
                  "    AND glaaent = xcjeent AND glaald = xcjeld ",
                  "    AND xcjeent = '",g_enterprise,"'",
                  "    AND xcjedocno = '",g_docno,"' AND xcjeld = '",g_ld,"'" ,
                  "    AND xcjf010 IN ('3','4') ",
                  " GROUP BY xcjeent,xcjedocno,xcjedocdt,'95',xcjeld,glaacomp,xcjf030,xcjf029, ",
                  "          xcjf031,xcjf014,xcjf033,xcjf034,xcjf035,xcjf036,xcjf037,xcjf041,xcjf042,xcjf043,xcjf038,xcjf039,xcjf040, ",
                  "          xcjf044,xcjf045,xcjf046,xcjf047,xcjf048,xcjf049,xcjf050,xcjf051,xcjf052,xcjf053",
                  " UNION ",
      #-------------------------------------
      #贷： 收入科目   金额     实体利润中心
                  #                                           类型                  摘要     科目
                  " SELECT  UNIQUE xcjeent,xcjedocno,xcjedocdt,'95',xcjeld,glaacomp,xcjf030,xcjf028,",
                  "                '','','',",  #币种汇率原币金额，后续再处理进去
                  " 0,",
                  " SUM(xcjf201),",
                  " 0,",
                  " SUM(xcjf211),",
                  " 0,",
                  " SUM(xcjf221),",
                  #    部門    实际利润中心 區域 交易對象 帳款對象 客群    品類     人員    項目號   WBS     經營類別 渠道    品牌
                  " '',xcjf031,xcjf013,xcjf033,xcjf034,xcjf035,xcjf036,xcjf037,xcjf041,xcjf042,xcjf043,xcjf038,xcjf039,xcjf040,",
                  # 自由核算項1~10
                  " xcjf044,xcjf045,xcjf046,xcjf047,xcjf048,xcjf049,xcjf050,xcjf051,xcjf052,xcjf053 ",
                  "   FROM xcje_t,xcjf_t,glaa_t",
                  "  WHERE xcjeent = xcjfent AND xcjeld = xcjfld AND xcjedocno = xcjfdocno ",
                  "    AND glaaent = xcjeent AND glaald = xcjeld ",
                  "    AND xcjeent = '",g_enterprise,"'",
                  "    AND xcjedocno = '",g_docno,"' AND xcjeld = '",g_ld,"'" ,
                  "    AND xcjf010 IN ('1','2') ",
                  " GROUP BY xcjeent,xcjedocno,xcjedocdt,'95',xcjeld,glaacomp,xcjf030,xcjf028, ",
                  "          xcjf031,xcjf013,xcjf033,xcjf034,xcjf035,xcjf036,xcjf037,xcjf041,xcjf042,xcjf043,xcjf038,xcjf039,xcjf040, ",
                  "          xcjf044,xcjf045,xcjf046,xcjf047,xcjf048,xcjf049,xcjf050,xcjf051,xcjf052,xcjf053",
                  " UNION ",
      #-------------------------------------
      #   贷：对方科目 －金额   虚拟利润中心
                  #                                           类型                  摘要     科目
                  " SELECT  UNIQUE xcjeent,xcjedocno,xcjedocdt,'95',xcjeld,glaacomp,xcjf030,xcjf029,",
                  "                '','','',",  #币种汇率原币金额，后续再处理进去
                  " 0,",
                  " SUM(xcjf201)*-1,",
                  " 0,",
                  " SUM(xcjf211)*-1,",
                  " 0,",
                  " SUM(xcjf221)*-1,",
                  #    部門    虚拟利润中心 區域 交易對象 帳款對象 客群    品類     人員    項目號   WBS     經營類別 渠道    品牌
                  " '',xcjf031,xcjf014,xcjf033,xcjf034,xcjf035,xcjf036,xcjf037,xcjf041,xcjf042,xcjf043,xcjf038,xcjf039,xcjf040,",
                  " xcjf044,xcjf045,xcjf046,xcjf047,xcjf048,xcjf049,xcjf050,xcjf051,xcjf052,xcjf053",
                  "   FROM xcje_t,xcjf_t,glaa_t",
                  "  WHERE xcjeent = xcjfent AND xcjeld = xcjfld AND xcjedocno = xcjfdocno ",
                  "    AND glaaent = xcjeent AND glaald = xcjeld ",
                  "    AND xcjeent = '",g_enterprise,"'",
                  "    AND xcjedocno = '",g_docno,"' AND xcjeld = '",g_ld,"'",
                  "    AND xcjf010 IN ('1','2') ",
                  " GROUP BY xcjeent,xcjedocno,xcjedocdt,'95',xcjeld,glaacomp,xcjf030,xcjf029, ",
                  "          xcjf031,xcjf014,xcjf033,xcjf034,xcjf035,xcjf036,xcjf037,xcjf041,xcjf042,xcjf043,xcjf038,xcjf039,xcjf040, ",
                  "          xcjf044,xcjf045,xcjf046,xcjf047,xcjf048,xcjf049,xcjf050,xcjf051,xcjf052,xcjf053"
      #加上序号
      #                                                                           摘要     科目编号 交易币别 汇率 计价单位 借方金額 貸方金額 
      LET g_sql = "SELECT ROWNUM,xcjeent,xcjedocno,xcjedocdt,'95',xcjeld,glaacomp,xcjf030,account, '',     '',  '',     d1,c1,d2,c2,d3,c3,", 
      #              營運據點 部門    成本中心 区域    交易客商 帳款客戶 客群    產品類別 人員    專案編號 WBS    經營方式 渠道    品牌
                  "       '',xcjf031,cost   ,xcjf033,xcjf034,xcjf035,xcjf036,xcjf037,xcjf041,xcjf042,xcjf043,xcjf038,xcjf039,xcjf040,",
                  "       xcjf044,xcjf045,xcjf046,xcjf047,xcjf048,xcjf049,xcjf050,xcjf051,xcjf052,xcjf053 FROM (",g_sql,")"

   END IF
   #add zhangllc 151227 --end
   
   LET g_sql = " INSERT INTO vouc_grp_tmp01 ",       #160727-00019#22 Mod  s_voucher_xc_group--> vouc_grp_tmp01
               "        (seq,glaqent,docno,docdt,type,glaqld,glaqcomp,glaq001,glaq002,glaq005,glaq006,glaq010,d,c,glaq040,glaq041,glaq043,glaq044,",   #凭证预览单身
   #                     營運據點 部門    成本中心 区域    交易客商 帳款客戶 客群    產品類別 人員    專案編號 WBS    經營方式 渠道    品牌
               "         glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,glaq024,glaq025,glaq027,glaq028,glaq051,glaq052,glaq053,",   #凭证预览page1 
               "         glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,glaq036,glaq037,glaq038) ",g_sql    #凭证预览page2-自由核算项
   PREPARE axct701_02_ins_tmp_pb FROM g_sql
   EXECUTE axct701_02_ins_tmp_pb

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = g_glaq_d_t.glaqld
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   UPDATE vouc_grp_tmp01 SET c = 0 WHERE c IS NULL                       #160727-00019#22 Mod  s_voucher_xc_group--> vouc_grp_tmp01
   UPDATE vouc_grp_tmp01 SET d = 0 WHERE d IS NULL                       #160727-00019#22 Mod  s_voucher_xc_group--> vouc_grp_tmp01
   UPDATE vouc_grp_tmp01 SET glaq017 = glaqcomp  #營運據點                #160727-00019#22 Mod  s_voucher_xc_group--> vouc_grp_tmp01
   UPDATE vouc_grp_tmp01 SET glaq012 = docdt     #票据日期                #160727-00019#22 Mod  s_voucher_xc_group--> vouc_grp_tmp01
#170215-00035#1  --begin
   #160812-00020#1-s-add
   #因axct706銷貨成本、銷退有做正負數調整，故再產生底稿前，需再將正負數調整回來
#   IF g_type = '6' THEN  
#      UPDATE vouc_grp_tmp01 SET c = c*-1,d = d * -1
#   END IF
   #160812-00020#1-e-add
#170215-00035#1 --end
   #160818-00013#1-s-add
   #因axct705第二單身差異轉數為負數呈程，故這將*-1，才會借貸平衡
   IF g_type = '5' THEN
      UPDATE vouc_grp_tmp01 SET c = c * -1
   END IF
   #160818-00013#1-e-add
   
   #单别允许红字否，若不允许红字,判断借贷方的金额为负数，则放到借贷相反，使金额显示正数
   CALL s_aooi200_fin_get_slip(g_docno) RETURNING l_success,l_slip
   CALL s_fin_get_doc_para(g_ld,'',l_slip,'D-FIN-1002') RETURNING l_red
   IF cl_null(l_red) THEN LET l_red = 'N' END IF
   IF l_red = 'N' THEN       #170125-00002#1 mark #170221-00059#1 remove #
   #IF l_red = 'Y' THEN        #170125-00002#1 add #170221-00059#1 mark
      UPDATE vouc_grp_tmp01 SET d = c*-1,c = 0 WHERE c < 0 AND d = 0                      #160727-00019#22 Mod  s_voucher_xc_group--> vouc_grp_tmp01
      UPDATE vouc_grp_tmp01 SET c = d*-1,d = 0 WHERE d < 0 AND c = 0                      #160727-00019#22 Mod  s_voucher_xc_group--> vouc_grp_tmp01
      ##170109-00015#1 mod --s
      #UPDATE vouc_grp_tmp01 SET glaq040 = glaq041*-1 WHERE glaq041 < 0 AND glaq040 = 0    #160727-00019#22 Mod  s_voucher_xc_group--> vouc_grp_tmp01
      #UPDATE vouc_grp_tmp01 SET glaq041 = glaq040*-1 WHERE glaq040 < 0 AND glaq041 = 0    #160727-00019#22 Mod  s_voucher_xc_group--> vouc_grp_tmp01
      #UPDATE vouc_grp_tmp01 SET glaq043 = glaq044*-1 WHERE glaq044 < 0 AND glaq043 = 0    #160727-00019#22 Mod  s_voucher_xc_group--> vouc_grp_tmp01
      #UPDATE vouc_grp_tmp01 SET glaq044 = glaq043*-1 WHERE glaq043 < 0 AND glaq044 = 0    #160727-00019#22 Mod  s_voucher_xc_group--> vouc_grp_tmp01
      UPDATE vouc_grp_tmp01 SET glaq040 = glaq041*-1,glaq041=0 WHERE glaq041 < 0 AND glaq040 = 0    #160727-00019#22 Mod  s_voucher_xc_group--> vouc_grp_tmp01
      UPDATE vouc_grp_tmp01 SET glaq041 = glaq040*-1,glaq040=0 WHERE glaq040 < 0 AND glaq041 = 0    #160727-00019#22 Mod  s_voucher_xc_group--> vouc_grp_tmp01
      UPDATE vouc_grp_tmp01 SET glaq043 = glaq044*-1,glaq044=0 WHERE glaq044 < 0 AND glaq043 = 0    #160727-00019#22 Mod  s_voucher_xc_group--> vouc_grp_tmp01
      UPDATE vouc_grp_tmp01 SET glaq044 = glaq043*-1,glaq043=0 WHERE glaq043 < 0 AND glaq044 = 0    #160727-00019#22 Mod  s_voucher_xc_group--> vouc_grp_tmp01
      ##170109-00015#1 mod --e
   END IF
   
   #axc没有直接的币种汇率原币金额，所以要另外推算出来再更新进去
   #币别就是账套的主本位币，汇率是1，原币金额＝主本位币金额
   SELECT glaa001 INTO l_glaq005 FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_ld
   
   LET l_glaq006 = 1
   
   UPDATE vouc_grp_tmp01        #160727-00019#22 Mod  s_voucher_xc_group--> vouc_grp_tmp01
      SET glaq005 = l_glaq005,
          glaq006 = l_glaq006,
          glaq010 = c
    WHERE c <> 0 AND d = 0
    
   UPDATE vouc_grp_tmp01        #160727-00019#22 Mod  s_voucher_xc_group--> vouc_grp_tmp01
      SET glaq005 = l_glaq005,
          glaq006 = l_glaq006,
          glaq010 = d
    WHERE d <> 0 AND c = 0
   #借贷方都是0的，本行不显示，所以删除
   DELETE FROM vouc_grp_tmp01 WHERE c = 0 AND d = 0       #160727-00019#22 Mod  s_voucher_xc_group--> vouc_grp_tmp01
   RETURN r_success
END FUNCTION

 
{</section>}
 
