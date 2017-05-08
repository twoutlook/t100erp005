#該程式未解開Section, 採用最新樣板產出!
{<section id="aint330_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2016-08-22 10:57:59), PR版次:0005(2017-01-11 15:20:58)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000003
#+ Filename...: aint330_02
#+ Description: 調撥單身整批產生
#+ Creator....: 02097(2016-08-22 10:30:07)
#+ Modifier...: 02097 -SD/PR- 02040
 
{</section>}
 
{<section id="aint330_02.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161007-00012#2   2016/11/23  By  dorislai  撥出/入倉，排除結算倉
#161208-00012#1   2016/12/15  By  dujuan   aint330調撥單，進入單身選擇「依工單整批產生」時，在「調撥單身整批產生」的工單編號開窗中，如果選擇兩個以上不同的工單編號時，在「調撥單身整批產生」畫面中只能產生出一筆工單單號的結果
#161209-00014#1   2016/12/15  By  dujuan   aint330調撥單，進入單身選擇「依工單整批產生」時，在「調撥單身整批產生」的工單編號開窗中，選擇完工單編號後，在「調撥單身整批產生中」，繼續進行至下一步，產生調撥明細時，會提示資料產生成功，但回到調撥單單身的「調撥明細」不會有結果
#161230-00001#1   2017/01/11  By  02040    1.整批產生未產生數據，仍提示成功；2.庫位偖位說明欄位處理
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
PRIVATE TYPE type_g_indd_d RECORD
       indddocno LIKE indd_t.indddocno, 
   inddseq LIKE indd_t.inddseq, 
   sel LIKE type_t.chr500, 
   indd002 LIKE indd_t.indd002, 
   indd002_desc LIKE type_t.chr500, 
   imaal004_desc LIKE type_t.chr500, 
   bmaa002 LIKE type_t.chr500, 
   indd004 LIKE indd_t.indd004, 
   indd006 LIKE indd_t.indd006, 
   indd103 LIKE indd_t.indd103, 
   l_amt01_01 LIKE type_t.num20_6, 
   indd104 LIKE indd_t.indd104, 
   indd105 LIKE indd_t.indd105, 
   l_amt01_02 LIKE type_t.num20_6, 
   indd032 LIKE indd_t.indd032, 
   indd032_desc LIKE type_t.chr500, 
   indd033 LIKE indd_t.indd033, 
   indd033_desc LIKE type_t.chr500
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
PRIVATE TYPE type_g_indd2_d RECORD
   sel1	          LIKE type_t.chr1, 
   b_sfbadocno	    LIKE sfba_t.sfbadocno, 
   b_sfbaseq	    LIKE sfba_t.sfbaseq, 
   b_sfbaseq1	    LIKE sfba_t.sfbaseq1, 
   b_sfba006	    LIKE sfba_t.sfba006, 
   indd002_desc1	 LIKE type_t.chr500, 
   imaal004_desc1  LIKE type_t.chr500, 
   indd0041	       LIKE indd_t.indd004, 
   indd0061	       LIKE indd_t.indd006, 
   l_amt02_01	    LIKE type_t.num20_6, 
   l_amt02_02	    LIKE type_t.num20_6, 
   indd1041	       LIKE indd_t.indd104, 
   l_amt02_03	    LIKE type_t.num20_6, 
   l_amt02_04	    LIKE type_t.num20_6, 
   indd0321	       LIKE indd_t.indd032, 
   indd0321_desc   LIKE type_t.chr500,
   indd0331        LIKE indd_t.indd033, 
   indd0331_desc   LIKE type_t.chr500
       END RECORD
DEFINE g_indd2_d          DYNAMIC ARRAY OF type_g_indd2_d #單身變數
DEFINE g_indd2_d_t        type_g_indd2_d                 #單身備份
DEFINE g_indd2_d_o        type_g_indd2_d                 #單身備份 
TYPE type_g_sfdc02_d        RECORD
         sfdc004              LIKE sfdc_t.sfdc004,     #需求料号
         sfdc004_desc         LIKE type_t.chr80,       #品名
         sfdc004_desc_desc    LIKE type_t.chr80,       #规格
         sfdc005              LIKE sfdc_t.sfdc005,     #特征
         sfdc006              LIKE sfdc_t.sfdc006,     #单位
         sfdc007              LIKE sfdc_t.sfdc007,     #申请数量
         inag008              LIKE inag_t.inag008,     #库存数量
         diff                 LIKE sfdc_t.sfdc007,     #差异数量
         sfdc009              LIKE sfdc_t.sfdc009,     #参考单位
         sfdc010              LIKE sfdc_t.sfdc010,     #参考单位申请数量
         inag025              LIKE inag_t.inag025,     #参考单位库存数量
         diffr                LIKE sfdc_t.sfdc010,     #参考单位差异数量
         sfdc012              LIKE sfdc_t.sfdc012,     #拨入库位
         sfdc013              LIKE sfdc_t.sfdc013,     #拨入储位
         sum_qty              LIKE sfdc_t.sfdc007,     #拟拨入数量合计
         sum_qtyr             LIKE sfdc_t.sfdc010      #拟拨入参考数量合计
                             END RECORD
DEFINE g_sfdc02_d          DYNAMIC ARRAY OF type_g_sfdc02_d
DEFINE g_sfdc02_d_t        type_g_sfdc02_d
DEFINE g_sfdc02_d_o        type_g_sfdc02_d
DEFINE g_sfdc02_l          type_g_sfdc02_d
TYPE type_g_inag_d        RECORD
         sel                  LIKE type_t.chr1,        #选择
         seq                  LIKE type_t.num5,        #项次
         inag004              LIKE inag_t.inag004,     #拨出库位
         inag004_desc         LIKE type_t.chr80,       #库位名称
         inag005              LIKE inag_t.inag005,     #拨出储位
         inag005_desc         LIKE type_t.chr80,       #储位名称
         inag006              LIKE inag_t.inag006,     #拨出批号
         inag003              LIKE inag_t.inag003,     #库存管理特征
         inag007              LIKE inag_t.inag007,     #单位
         inag008              LIKE inag_t.inag008,     #库存数量
         inag024              LIKE inag_t.inag024,     #参考单位
         inag025              LIKE inag_t.inag025,     #参考单位库存数量
         pack                 LIKE imaa_t.imaa001,     #包装容器
         qty                  LIKE inag_t.inag008,     #拨出数量
         qtyr                 LIKE inag_t.inag025      #拨出参考数量
                             END RECORD
DEFINE g_inag_d          DYNAMIC ARRAY OF type_g_inag_d
DEFINE g_inag_d_t        type_g_inag_d
DEFINE g_inag_d_o        type_g_inag_d
DEFINE g_inag_l          type_g_inag_d
TYPE type_g_inai_d        RECORD
         sel                  LIKE type_t.chr1,        #选择
         seq                  LIKE type_t.num5,        #项次
         seq1                 LIKE type_t.num5,        #项序
         inai007              LIKE inai_t.inai007,     #制造序号
         inai008              LIKE inai_t.inai008,     #制造批号
         inai012              LIKE inai_t.inai012,     #制造日期
         inai010              LIKE inai_t.inai010,     #库存数量
         qty                  LIKE inai_t.inai010      #拨出数量
                             END RECORD
DEFINE g_inai_d          DYNAMIC ARRAY OF type_g_inai_d
DEFINE g_inai_d_t          type_g_inai_d
DEFINE g_inai_d_o          type_g_inai_d
DEFINE g_inai_l            type_g_inai_d
DEFINE g_indcdocno         LIKE indc_t.indcdocno
DEFINE g_chr               LIKE type_t.chr1
DEFINE g_chk2              LIKE type_t.chr1
DEFINE g_indc006           LIKE indc_t.indc006
DEFINE g_master_idx2       LIKE type_t.num5
DEFINE g_master_idx3       LIKE type_t.num5
DEFINE g_master_idx5       LIKE type_t.num5
DEFINE g_rec_b2            LIKE type_t.num5
DEFINE g_rec_b3            LIKE type_t.num5
DEFINE g_rec_b5            LIKE type_t.num5
DEFINE g_wc_02             STRING
DEFINE g_step              LIKE type_t.chr1
DEFINE g_bmaa001           LIKE bmaa_t.bmaa001
DEFINE g_bmaa002           LIKE bmaa_t.bmaa002
DEFINE g_type1             LIKE type_t.chr1
DEFINE g_indd032           LIKE indd_t.indd032
DEFINE g_indd033           LIKE indd_t.indd033
DEFINE g_amt1              LIKE type_t.num5
DEFINE g_chk1              LIKE type_t.chr1
#end add-point
 
#模組變數(Module Variables)
DEFINE g_indd_d          DYNAMIC ARRAY OF type_g_indd_d #單身變數
DEFINE g_indd_d_t        type_g_indd_d                  #單身備份
DEFINE g_indd_d_o        type_g_indd_d                  #單身備份
DEFINE g_indd_d_mask_o   DYNAMIC ARRAY OF type_g_indd_d #單身變數
DEFINE g_indd_d_mask_n   DYNAMIC ARRAY OF type_g_indd_d #單身變數
 
      
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
 
{<section id="aint330_02.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION aint330_02(--)
   #add-point:main段變數傳入 name="main.get_var"
   p_indcdocno,p_chr
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE p_indcdocno         LIKE indc_t.indcdocno
   DEFINE p_chr               LIKE type_t.chr1
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化 name="main.init"
   CALL aint330_02_cre_temp()
   LET g_indcdocno = p_indcdocno
   LET g_chr = p_chr
   LET g_step = '1'
   SELECT indc006 INTO g_indc006
     FROM indc_t
    WHERE indcent = g_enterprise AND indcdocno = g_indcdocno
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
   
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT indddocno,inddseq,indd002,indd004,indd006,indd103,indd104,indd105,indd032, 
       indd033 FROM indd_t WHERE inddent=? AND indddocno=? AND inddseq=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint330_02_bcl CURSOR FROM g_forupd_sql
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aint330_02 WITH FORM cl_ap_formpath("ain","aint330_02")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL aint330_02_init()   
 
   #進入選單 Menu (="N")
   CALL aint330_02_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_aint330_02
 
   
   
 
   #add-point:離開前 name="main.exit"
   DROP TABLE aint330_02_tmp01
   DROP TABLE aint330_02_tmp02
   DROP TABLE aint330_02_tmp03
   DROP TABLE aint330_02_tmp04
   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint330_02.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aint330_02_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_sbas0028       LIKE type_t.chr1
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('aint330_02_type1','5452')
   CALL cl_set_combo_scc('aint330_02_type2','5452')
   CALL cl_get_para(g_enterprise,g_indc006,'S-BAS-0028') RETURNING l_sbas0028
   CALL cl_set_comp_visible('indd104,indd105,l_amt01_02',TRUE)                #page1
   CALL cl_set_comp_visible('indd1041,l_amt02_03,l_amt02_04',TRUE)            #page2   
   CALL cl_set_comp_visible('b_indd104,b_indd031_01,b_amt_11,b_amt_12',TRUE)  #page3
   CALL cl_set_comp_visible('b1_indd104,b1_amt_11,b1_indd105',TRUE)
   IF l_sbas0028 = 'N' THEN
      CALL cl_set_comp_visible('indd104,indd105,l_amt01_02',FALSE)               #page1
      CALL cl_set_comp_visible('indd1041,l_amt02_03,l_amt02_04',FALSE)           #page2         
      CALL cl_set_comp_visible('b_indd104,b_indd031_01,b_amt_11,b_amt_12',FALSE) #page3
      CALL cl_set_comp_visible('b1_indd104,b1_amt_11,b1_indd105',FALSE)      
   END IF
   #end add-point
   
   CALL aint330_02_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="aint330_02.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aint330_02_ui_dialog()
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
   CLEAR FORM
   CALL g_indd_d.clear()
   CALL g_sfdc02_d.clear()
   CALL aint330_02_portal()
   CALL g_indd2_d.clear()
   RETURN
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
         CALL g_indd_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL aint330_02_init()
      END IF
   
      CALL aint330_02_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_indd_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
   CALL aint330_02_set_pk_array()
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
            
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL aint330_02_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aint330_02_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL aint330_02_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aint330_02_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL aint330_02_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aint330_02_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aint330_02_insert()
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
         ON ACTION cre_data
            LET g_action_choice="cre_data"
            IF cl_auth_chk_act("cre_data") THEN
               
               #add-point:ON ACTION cre_data name="menu.cre_data"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION cre_stock
            LET g_action_choice="cre_stock"
            IF cl_auth_chk_act("cre_stock") THEN
               
               #add-point:ON ACTION cre_stock name="menu.cre_stock"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION next_step
            LET g_action_choice="next_step"
            IF cl_auth_chk_act("next_step") THEN
               
               #add-point:ON ACTION next_step name="menu.next_step"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aint330_02_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION pre_step
            LET g_action_choice="pre_step"
            IF cl_auth_chk_act("pre_step") THEN
               
               #add-point:ON ACTION pre_step name="menu.pre_step"
               
               #END add-point
               
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_indd_d)
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
            CALL aint330_02_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aint330_02_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aint330_02_set_pk_array()
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
 
{<section id="aint330_02.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aint330_02_query()
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
   CALL g_indd_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON sel,imaal004_desc,bmaa002,l_amt01_01 
 
         FROM s_detail1[1].sel,s_detail1[1].imaal004_desc,s_detail1[1].bmaa002,s_detail1[1].l_amt01_01  
 
      
         
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sel
            #add-point:BEFORE FIELD sel name="query.b.page1.sel"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sel
            
            #add-point:AFTER FIELD sel name="query.a.page1.sel"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sel
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sel
            #add-point:ON ACTION controlp INFIELD sel name="query.c.page1.sel"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaal004_desc
            #add-point:BEFORE FIELD imaal004_desc name="query.b.page1.imaal004_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaal004_desc
            
            #add-point:AFTER FIELD imaal004_desc name="query.a.page1.imaal004_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.imaal004_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaal004_desc
            #add-point:ON ACTION controlp INFIELD imaal004_desc name="query.c.page1.imaal004_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmaa002
            #add-point:BEFORE FIELD bmaa002 name="query.b.page1.bmaa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmaa002
            
            #add-point:AFTER FIELD bmaa002 name="query.a.page1.bmaa002"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.bmaa002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmaa002
            #add-point:ON ACTION controlp INFIELD bmaa002 name="query.c.page1.bmaa002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt01_01
            #add-point:BEFORE FIELD l_amt01_01 name="query.b.page1.l_amt01_01"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt01_01
            
            #add-point:AFTER FIELD l_amt01_01 name="query.a.page1.l_amt01_01"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.l_amt01_01
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt01_01
            #add-point:ON ACTION controlp INFIELD l_amt01_01 name="query.c.page1.l_amt01_01"
            
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
    
   CALL aint330_02_b_fill(g_wc2)
 
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
 
{<section id="aint330_02.insert" >}
#+ 資料新增
PRIVATE FUNCTION aint330_02_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL aint330_02_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aint330_02.modify" >}
#+ 資料修改
PRIVATE FUNCTION aint330_02_modify()
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
      INPUT ARRAY g_indd_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_indd_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aint330_02_b_fill(g_wc2)
            LET g_detail_cnt = g_indd_d.getLength()
         
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
            DISPLAY g_indd_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_indd_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_indd_d[l_ac].indddocno IS NOT NULL
               AND g_indd_d[l_ac].inddseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_indd_d_t.* = g_indd_d[l_ac].*  #BACKUP
               LET g_indd_d_o.* = g_indd_d[l_ac].*  #BACKUP
               IF NOT aint330_02_lock_b("indd_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aint330_02_bcl INTO g_indd_d[l_ac].indddocno,g_indd_d[l_ac].inddseq,g_indd_d[l_ac].indd002, 
                      g_indd_d[l_ac].indd004,g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd103,g_indd_d[l_ac].indd104, 
                      g_indd_d[l_ac].indd105,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_indd_d_t.indddocno,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_indd_d_mask_o[l_ac].* =  g_indd_d[l_ac].*
                  CALL aint330_02_indd_t_mask()
                  LET g_indd_d_mask_n[l_ac].* =  g_indd_d[l_ac].*
                  
                  CALL aint330_02_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL aint330_02_set_entry_b(l_cmd)
            CALL aint330_02_set_no_entry_b(l_cmd)
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
            INITIALIZE g_indd_d_t.* TO NULL
            INITIALIZE g_indd_d_o.* TO NULL
            INITIALIZE g_indd_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值(單身1)
                  LET g_indd_d[l_ac].indd103 = "0"
      LET g_indd_d[l_ac].indd105 = "0"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_indd_d_t.* = g_indd_d[l_ac].*     #新輸入資料
            LET g_indd_d_o.* = g_indd_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_indd_d[li_reproduce_target].* = g_indd_d[li_reproduce].*
 
               LET g_indd_d[g_indd_d.getLength()].indddocno = NULL
               LET g_indd_d[g_indd_d.getLength()].inddseq = NULL
 
            END IF
            
 
            CALL aint330_02_set_entry_b(l_cmd)
            CALL aint330_02_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM indd_t 
             WHERE inddent = g_enterprise AND indddocno = g_indd_d[l_ac].indddocno
                                       AND inddseq = g_indd_d[l_ac].inddseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_indd_d[g_detail_idx].indddocno
               LET gs_keys[2] = g_indd_d[g_detail_idx].inddseq
               CALL aint330_02_insert_b('indd_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_indd_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "indd_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aint330_02_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (indddocno = '", g_indd_d[l_ac].indddocno, "' "
                                  ," AND inddseq = '", g_indd_d[l_ac].inddseq, "' "
 
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
               
               DELETE FROM indd_t
                WHERE inddent = g_enterprise AND 
                      indddocno = g_indd_d_t.indddocno
                      AND inddseq = g_indd_d_t.inddseq
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "indd_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL aint330_02_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_indd_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE aint330_02_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_indd_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_indd_d_t.indddocno
               LET gs_keys[2] = g_indd_d_t.inddseq
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aint330_02_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL aint330_02_delete_b('indd_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_indd_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sel
            #add-point:BEFORE FIELD sel name="input.b.page1.sel"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sel
            
            #add-point:AFTER FIELD sel name="input.a.page1.sel"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sel
            #add-point:ON CHANGE sel name="input.g.page1.sel"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaal004_desc
            #add-point:BEFORE FIELD imaal004_desc name="input.b.page1.imaal004_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaal004_desc
            
            #add-point:AFTER FIELD imaal004_desc name="input.a.page1.imaal004_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaal004_desc
            #add-point:ON CHANGE imaal004_desc name="input.g.page1.imaal004_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmaa002
            #add-point:BEFORE FIELD bmaa002 name="input.b.page1.bmaa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmaa002
            
            #add-point:AFTER FIELD bmaa002 name="input.a.page1.bmaa002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmaa002
            #add-point:ON CHANGE bmaa002 name="input.g.page1.bmaa002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt01_01
            #add-point:BEFORE FIELD l_amt01_01 name="input.b.page1.l_amt01_01"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt01_01
            
            #add-point:AFTER FIELD l_amt01_01 name="input.a.page1.l_amt01_01"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_amt01_01
            #add-point:ON CHANGE l_amt01_01 name="input.g.page1.l_amt01_01"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.sel
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sel
            #add-point:ON ACTION controlp INFIELD sel name="input.c.page1.sel"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imaal004_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaal004_desc
            #add-point:ON ACTION controlp INFIELD imaal004_desc name="input.c.page1.imaal004_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bmaa002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmaa002
            #add-point:ON ACTION controlp INFIELD bmaa002 name="input.c.page1.bmaa002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_amt01_01
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt01_01
            #add-point:ON ACTION controlp INFIELD l_amt01_01 name="input.c.page1.l_amt01_01"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE aint330_02_bcl
               LET INT_FLAG = 0
               LET g_indd_d[l_ac].* = g_indd_d_t.*
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
               LET g_errparam.extend = g_indd_d[l_ac].indddocno 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_indd_d[l_ac].* = g_indd_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aint330_02_indd_t_mask_restore('restore_mask_o')
 
               UPDATE indd_t SET (indddocno,inddseq,indd002,indd004,indd006,indd103,indd104,indd105, 
                   indd032,indd033) = (g_indd_d[l_ac].indddocno,g_indd_d[l_ac].inddseq,g_indd_d[l_ac].indd002, 
                   g_indd_d[l_ac].indd004,g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd103,g_indd_d[l_ac].indd104, 
                   g_indd_d[l_ac].indd105,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033)
                WHERE inddent = g_enterprise AND
                  indddocno = g_indd_d_t.indddocno #項次   
                  AND inddseq = g_indd_d_t.inddseq  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "indd_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "indd_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_indd_d[g_detail_idx].indddocno
               LET gs_keys_bak[1] = g_indd_d_t.indddocno
               LET gs_keys[2] = g_indd_d[g_detail_idx].inddseq
               LET gs_keys_bak[2] = g_indd_d_t.inddseq
               CALL aint330_02_update_b('indd_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_indd_d_t)
                     LET g_log2 = util.JSON.stringify(g_indd_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aint330_02_indd_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL aint330_02_unlock_b("indd_t")
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_indd_d[l_ac].* = g_indd_d_t.*
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
               LET g_indd_d[li_reproduce_target].* = g_indd_d[li_reproduce].*
 
               LET g_indd_d[li_reproduce_target].indddocno = NULL
               LET g_indd_d[li_reproduce_target].inddseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_indd_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_indd_d.getLength()+1
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
               NEXT FIELD indddocno
 
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
      IF INT_FLAG OR cl_null(g_indd_d[g_detail_idx].indddocno) THEN
         CALL g_indd_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_indd_d[g_detail_idx].* = g_indd_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE aint330_02_bcl
   
END FUNCTION
 
{</section>}
 
{<section id="aint330_02.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aint330_02_delete()
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
   FOR li_idx = 1 TO g_indd_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT aint330_02_lock_b("indd_t") THEN
            #已被他人鎖定
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("indd_t","") THEN
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
   
   FOR li_idx = 1 TO g_indd_d.getLength()
      IF g_indd_d[li_idx].indddocno IS NOT NULL
         AND g_indd_d[li_idx].inddseq IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM indd_t
          WHERE inddent = g_enterprise AND 
                indddocno = g_indd_d[li_idx].indddocno
                AND inddseq = g_indd_d[li_idx].inddseq
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "indd_t:",SQLERRMESSAGE 
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
               LET gs_keys[1] = g_indd_d_t.indddocno
               LET gs_keys[2] = g_indd_d_t.inddseq
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL aint330_02_delete_b('indd_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aint330_02_set_pk_array()
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
   CALL aint330_02_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="aint330_02.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aint330_02_b_fill(p_wc2)              #BODY FILL UP
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
   
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.indddocno,t0.inddseq,t0.indd002,t0.indd004,t0.indd006,t0.indd103, 
       t0.indd104,t0.indd105,t0.indd032,t0.indd033 ,t1.imaal003 ,t2.inayl003 ,t3.inab003 FROM indd_t t0", 
 
               "",
                              " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=t0.indd002 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t2 ON t2.inaylent="||g_enterprise||" AND t2.inayl001=t0.indd032 AND t2.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t3 ON t3.inabent="||g_enterprise||" AND t3.inab001=t0.indd032 AND t3.inab002=t0.indd033  ",
 
               " WHERE t0.inddent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
   
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("indd_t"),
                      " ORDER BY t0.indddocno,t0.inddseq"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"indd_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aint330_02_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aint330_02_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_indd_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_indd_d[l_ac].indddocno,g_indd_d[l_ac].inddseq,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004, 
       g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd103,g_indd_d[l_ac].indd104,g_indd_d[l_ac].indd105,g_indd_d[l_ac].indd032, 
       g_indd_d[l_ac].indd033,g_indd_d[l_ac].indd002_desc,g_indd_d[l_ac].indd032_desc,g_indd_d[l_ac].indd033_desc 
 
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
      
      CALL aint330_02_detail_show()      
 
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
   
 
   
   CALL g_indd_d.deleteElement(g_indd_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_indd_d.getLength()
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_indd_d.getLength() THEN
      LET l_ac = g_indd_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_indd_d.getLength()
      LET g_indd_d_mask_o[l_ac].* =  g_indd_d[l_ac].*
      CALL aint330_02_indd_t_mask()
      LET g_indd_d_mask_n[l_ac].* =  g_indd_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_indd_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE aint330_02_pb
   
END FUNCTION
 
{</section>}
 
{<section id="aint330_02.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aint330_02_detail_show()
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
 
{<section id="aint330_02.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aint330_02_set_entry_b(p_cmd)                                                  
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
 
{<section id="aint330_02.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aint330_02_set_no_entry_b(p_cmd)                                               
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
 
{<section id="aint330_02.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aint330_02_default_search()
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
      LET ls_wc = ls_wc, " indddocno = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " inddseq = '", g_argv[02], "' AND "
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
 
{<section id="aint330_02.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aint330_02_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "indd_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'indd_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM indd_t
          WHERE inddent = g_enterprise AND
            indddocno = ps_keys_bak[1] AND inddseq = ps_keys_bak[2]
         
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
         CALL g_indd_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aint330_02.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aint330_02_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "indd_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO indd_t
                  (inddent,
                   indddocno,inddseq
                   ,indd002,indd004,indd006,indd103,indd104,indd105,indd032,indd033) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd103, 
                       g_indd_d[l_ac].indd104,g_indd_d[l_ac].indd105,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033) 
 
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "indd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aint330_02.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aint330_02_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "indd_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "indd_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE indd_t 
         SET (indddocno,inddseq
              ,indd002,indd004,indd006,indd103,indd104,indd105,indd032,indd033) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd103, 
                  g_indd_d[l_ac].indd104,g_indd_d[l_ac].indd105,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033)  
 
         WHERE inddent = g_enterprise AND indddocno = ps_keys_bak[1] AND inddseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "indd_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "indd_t:",SQLERRMESSAGE 
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
 
{<section id="aint330_02.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aint330_02_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL aint330_02_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "indd_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aint330_02_bcl USING g_enterprise,
                                       g_indd_d[g_detail_idx].indddocno,g_indd_d[g_detail_idx].inddseq 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aint330_02_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aint330_02.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aint330_02_unlock_b(ps_table)
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
      CLOSE aint330_02_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aint330_02.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION aint330_02_modify_detail_chk(ps_record)
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
         LET ls_return = "indddocno"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="aint330_02.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION aint330_02_show_ownid_msg()
   #add-point:show_ownid_msg段define(客製用) name="show_ownid_msg.define_customerization"
   
   #end add-point
   #add-point:show_ownid_msg段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show_ownid_msg.define"
   
   #end add-point
  
 
   
 
END FUNCTION
#(ver:35) --- add end ---
 
{</section>}
 
{<section id="aint330_02.mask_functions" >}
&include "erp/ain/aint330_02_mask.4gl"
 
{</section>}
 
{<section id="aint330_02.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aint330_02_set_pk_array()
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
   LET g_pk_array[1].values = g_indd_d[l_ac].indddocno
   LET g_pk_array[1].column = 'indddocno'
   LET g_pk_array[2].values = g_indd_d[l_ac].inddseq
   LET g_pk_array[2].column = 'inddseq'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint330_02.state_change" >}
   
 
{</section>}
 
{<section id="aint330_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aint330_02.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 16/08/26 By 02097
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_02_cre_temp()

   WHENEVER ERROR CONTINUE
   DROP TABLE aint330_02_tmp01
   DROP TABLE aint330_02_tmp02
   DROP TABLE aint330_02_tmp03
   DROP TABLE aint330_02_tmp04

   CREATE TEMP TABLE aint330_02_tmp01(
      sel                  LIKE type_t.chr1,        #选择
      sfdcdocno            LIKE sfdc_t.sfdcdocno,   #发料单号
      sfdcseq              LIKE sfdc_t.sfdcseq,     #项次
      sfdc001              LIKE sfdc_t.sfdc001,     #工单单号
      sfdc002              LIKE sfdc_t.sfdc002,     #工单项次
      sfdc003              LIKE sfdc_t.sfdc003,     #工单项序
      sfdc004              LIKE sfdc_t.sfdc004,     #需求料号
      sfdc005              LIKE sfdc_t.sfdc005,     #特征
      sfdc006              LIKE sfdc_t.sfdc006,     #单位
      sfdc007              LIKE sfdc_t.sfdc007,     #申请数量
      inag008              LIKE inag_t.inag008,     #库存数量
      sfdc009              LIKE sfdc_t.sfdc009,     #参考单位
      sfdc010              LIKE sfdc_t.sfdc010,     #参考单位申请数量
      inag025              LIKE inag_t.inag025,     #参考单位库存数量
      sfdc012              LIKE sfdc_t.sfdc012,     #拨入库位
      sfdc013              LIKE sfdc_t.sfdc013      #拨入储位
      )

   CREATE TEMP TABLE aint330_02_tmp02(
      sfdc004              LIKE sfdc_t.sfdc004,     #需求料号
      sfdc005              LIKE sfdc_t.sfdc005,     #特征
      sfdc006              LIKE sfdc_t.sfdc006,     #单位
      sfdc009              LIKE sfdc_t.sfdc009,     #参考单位
      sfdc012              LIKE sfdc_t.sfdc012,     #拨入库位
      sfdc013              LIKE sfdc_t.sfdc013,     #拨入储位
      sfdc007              LIKE sfdc_t.sfdc007,     #申请数量
      inag008              LIKE inag_t.inag008,     #库存数量
      sfdc010              LIKE sfdc_t.sfdc010,     #参考单位申请数量
      inag025              LIKE inag_t.inag025,     #参考单位库存数量
      sum_qty              LIKE sfdc_t.sfdc007,     #拟拨入数量合计
      sum_qtyr             LIKE sfdc_t.sfdc010      #拟拨入参考数量合计
      )
   
   CREATE UNIQUE INDEX aint330_02_tmp02_01 on aint330_02_tmp02 (sfdc004,sfdc005,sfdc006,sfdc009,sfdc012,sfdc013)
   
   
   CREATE TEMP TABLE aint330_02_tmp03(
      sfdc004              LIKE sfdc_t.sfdc004,     #需求料号  inag001
      sfdc005              LIKE sfdc_t.sfdc005,     #特征      inag002
      sfdc006              LIKE sfdc_t.sfdc006,     #单位
      sfdc009              LIKE sfdc_t.sfdc009,     #参考单位
      sfdc012              LIKE sfdc_t.sfdc012,     #拨入库位
      sfdc013              LIKE sfdc_t.sfdc013,     #拨入储位
      sel                  LIKE type_t.chr1,        #选择
      seq                  LIKE type_t.num5,        #项次
      inag004              LIKE inag_t.inag004,     #拨出库位
      inag005              LIKE inag_t.inag005,     #拨出储位
      inag006              LIKE inag_t.inag006,     #拨出批号
      inag003              LIKE inag_t.inag003,     #库存管理特征
      inag007              LIKE inag_t.inag007,     #单位
      inag008              LIKE inag_t.inag008,     #库存数量
      inag024              LIKE inag_t.inag024,     #参考单位
      inag025              LIKE inag_t.inag025,     #参考单位库存数量
      pack                 LIKE imaa_t.imaa001,     #包装容器
      qty                  LIKE inag_t.inag008,     #拨出数量
      qtyr                 LIKE inag_t.inag025      #拨出参考数量
      )
   
   CREATE UNIQUE INDEX aint330_02_tmp03_01 on aint330_02_tmp03 (sfdc004,sfdc005,sfdc006,sfdc009,sfdc012,sfdc013,seq)

   CREATE TEMP TABLE aint330_02_tmp04(
      sfdc004              LIKE sfdc_t.sfdc004,     #需求料号  inai001
      sfdc005              LIKE sfdc_t.sfdc005,     #特征      inai002
      sfdc006              LIKE sfdc_t.sfdc006,     #单位
      sfdc009              LIKE sfdc_t.sfdc009,     #参考单位
      sfdc012              LIKE sfdc_t.sfdc012,     #拨入库位
      sfdc013              LIKE sfdc_t.sfdc013,     #拨入储位
      sel                  LIKE type_t.chr1,        #选择
      seq                  LIKE type_t.num5,        #项次
      seq1                 LIKE type_t.num5,        #项序
      inai007              LIKE inai_t.inai007,     #制造序号
      inai008              LIKE inai_t.inai008,     #制造批号
      inae010              LIKE inae_t.inae010,     #制造日期
      inai010              LIKE inai_t.inai010,     #库存数量
      qty                  LIKE inai_t.inai010      #拨出数量
      )
   
   CREATE UNIQUE INDEX aint330_02_tmp04_01 on aint330_02_tmp04 (sfdc004,sfdc005,sfdc006,sfdc009,sfdc012,sfdc013,seq,seq1)
   
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_02_portal()

   CALL cl_set_comp_visible('page_1,page_2,page_3',FALSE)
   CALL g_sfdc02_d.clear()
   CALL g_inag_d.clear()
   CALL g_inai_d.clear()

   
   DELETE FROM aint330_02_tmp02
   DELETE FROM aint330_02_tmp03
   DELETE FROM aint330_02_tmp04
   IF g_chr = '1' THEN
      CALL cl_set_comp_visible('page_1',TRUE)
      CALL aint330_02_ui_dialog1()
   ELSE
      CALL cl_set_comp_visible('page_2',TRUE)
      CALL aint330_02_ui_dialog2()
   END IF

END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_02_set_button(p_chr)
DEFINE p_chr         LIKE type_t.chr1

   CALL cl_set_comp_visible('next_step,pre_step,cre_data',FALSE)
   IF p_chr = '3' THEN
      CALL cl_set_comp_visible('pre_step,cre_data',TRUE)
   ELSE
      CALL cl_set_comp_visible('next_step',TRUE)
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_02_ui_dialog1()
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
DEFINE l_cnt            LIKE type_t.num5
DEFINE l_i              LIKE type_t.num5
DEFINE l_j              LIKE type_t.num5
#add--2016/10/27 By shiun--(S)
DEFINE ls_wc            LIKE type_t.chr500
DEFINE ls_return        STRING
DEFINE ls_result        STRING 
DEFINE l_bmaa001        LIKE bmaa_t.bmaa001
DEFINE l_bmaa002        LIKE bmaa_t.bmaa002
DEFINE l_type1          LIKE type_t.chr1
DEFINE l_indd032        LIKE indd_t.indd032
DEFINE l_indd033        LIKE indd_t.indd033
DEFINE l_amt1           LIKE type_t.num5
DEFINE l_chk1           LIKE type_t.chr1
DEFINE l_inaa007        LIKE inaa_t.inaa007
DEFINE r_success        LIKE type_t.num5
DEFINE l_flag           LIKE type_t.chr1
DEFINE l_indd032_desc   LIKE type_t.chr500
DEFINE l_indd033_desc   LIKE type_t.chr500
DEFINE  l_ac_t          LIKE type_t.num10               #未取消的ARRAY CNT 
DEFINE  l_allow_insert  LIKE type_t.num5                #可新增否 
DEFINE  l_allow_delete  LIKE type_t.num5                #可刪除否  
#add--2016/10/27 By shiun--(E)   
#161007-00012#2-s-add
DEFINE l_para_in_2      STRING  #撥入倉(結算倉)
DEFINE l_indd032_type   LIKE type_t.num5
DEFINE l_indd0321_type  LIKE type_t.num5
#161007-00012#2-e-add

   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()      
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   LET g_detail_idx = 1   
   #add--2016/10/27 By shiun--(S)   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete") 
   LET INT_FLAG = FALSE
   #add--2016/10/27 By shiun--(E) 
   
   WHILE TRUE
      
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add--2016/10/27 By shiun--(S)
         INPUT ARRAY g_indd_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS,
                     INSERT ROW = FALSE, 
                     DELETE ROW = FALSE,
                     APPEND ROW = FALSE)
          
            BEFORE ROW
               CALL cl_set_comp_entry("indd002,indd004,indd006,indd103,l_amt01_01,indd104,indd105,l_amt01_02,indd002_desc,imaal004_desc",FALSE)
               #add--2016/10/05 By shiun--(S)
               LET l_ac_t = l_ac 
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               #add--2016/10/05 By shiun--(E)
         
            ON ACTION controlp INFIELD indd032
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = FALSE
                LET g_qryparam.default1 = g_indd_d[l_ac].indd032
                LET g_qryparam.arg1 = g_indc006
                CALL q_inaa001_4()
                LET g_indd_d[l_ac].indd032 = g_qryparam.return1              
                DISPLAY g_indd_d[l_ac].indd032 TO indd032
                NEXT FIELD indd032
            
           AFTER FIELD indd032
             LET g_indd_d[l_ac].indd032_desc = ''
             IF NOT cl_null(g_indd_d[l_ac].indd032) THEN 
                INITIALIZE g_chkparam.* TO NULL
                LET g_chkparam.arg1 = g_indc006
                LET g_chkparam.arg2 = g_indd_d[l_ac].indd032
                LET g_errshow = TRUE
                LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                IF cl_chk_exist("v_inaa001") THEN
                ELSE
                   LET g_indd_d[l_ac].indd032 = ''
                   NEXT FIELD CURRENT   
                END IF
                CALL s_control_chk_doc('7',g_indcdocno,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033,'','','') RETURNING r_success,l_flag
                IF r_success THEN
                   IF NOT l_flag THEN
                      LET g_indd_d[l_ac].indd032 = ''
                      NEXT FIELD CURRENT
                   END IF
                ELSE
                   LET g_indd_d[l_ac].indd032 = ''
                   NEXT FIELD CURRENT
                END IF                                 
             END IF
             CALL s_desc_get_stock_desc(g_indc006,g_indd_d[l_ac].indd032) RETURNING g_indd_d[l_ac].indd032_desc
             DISPLAY BY NAME g_indd_d[l_ac].indd032_desc
         
         ON ACTION controlp INFIELD indd033
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_indd_d[l_ac].indd033
            LET g_qryparam.arg1 = g_indc006
            LET g_qryparam.arg2 = g_indd_d[l_ac].indd033            
            CALL q_inab002_6()
            LET g_indd_d[l_ac].indd033 = g_qryparam.return1
            DISPLAY g_indd_d[l_ac].indd033 TO indd033
            NEXT FIELD indd033
         
         AFTER FIELD indd033
            LET g_indd_d[l_ac].indd033_desc = ''
            DISPLAY BY NAME g_indd_d[l_ac].indd033_desc
            IF NOT cl_null(g_indd_d[l_ac].indd032) THEN 
               SELECT inaa007 INTO l_inaa007 FROM inaa_t
                WHERE inaaent = g_enterprise
                  AND inaasite = g_indc006 AND inaa001 = g_indd_d[l_ac].indd032
               IF l_inaa007 = '1' THEN                  
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_indc006
                  LET g_chkparam.arg2 = g_indd_d[l_ac].indd032
                  LET g_chkparam.arg3 = g_indd_d[l_ac].indd033
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                  IF cl_chk_exist("v_inab002") THEN
                  ELSE
                     LET g_indd_d[l_ac].indd033 = ''
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_control_chk_doc('7',g_indcdocno,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033,'','','') RETURNING r_success,l_flag
               IF r_success THEN
                  IF NOT l_flag THEN
                     LET g_indd_d[l_ac].indd033 = ''
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  LET g_indd_d[l_ac].indd033 = ''
                  NEXT FIELD CURRENT
               END IF               
            END IF 
            CALL s_desc_get_locator_desc(g_indc006,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033) RETURNING g_indd_d[l_ac].indd033_desc
            DISPLAY BY NAME g_indd_d[l_ac].indd033_desc
         
         END INPUT
         
         CONSTRUCT g_wc2 ON l_bmaa001,l_bmaa002 FROM bmaa001,bmaa002
         
            ON ACTION controlp INFIELD bmaa001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = l_bmaa001
               CALL q_imaa001_9()
               LET l_bmaa001 = g_qryparam.return1
               DISPLAY l_bmaa001 TO bmaa001
               NEXT FIELD bmaa001
            
            AFTER FIELD bamm001
               LET l_bmaa001 = GET_FLDBUF(bamm001)
            AFTER FIELD bamm002
               LET l_bmaa001 = GET_FLDBUF(bamm002)
         
         END CONSTRUCT
         
         INPUT l_type1,l_indd032,l_indd033,l_amt1,l_chk1
               FROM aint330_02_type1,l_indd032,l_indd033,amt1,chk1
            
            
            ON ACTION controlp INFIELD l_indd032
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = l_indd032
               LET g_qryparam.arg1 = g_indc006
               #161007-00012#2-s-add
               #--排除結算倉的部分 
               LET l_para_in_2 = cl_get_para(g_enterprise,g_indc006,'S-BAS-0044')           #VMI結算庫位Tag(撥入倉)  
               LET g_qryparam.where = " NOT EXISTS (SELECT inac001 FROM inac_t ",
                                      "              WHERE inacent='",g_enterprise,"' AND inacsite='",g_indc006,"' AND inaa001=inac001 AND inac003='",l_para_in_2,"') "
               #161007-00012#2-e-add
               CALL q_inaa001_4()
               LET l_indd032 = g_qryparam.return1              
               DISPLAY l_indd032 TO indd032
               NEXT FIELD l_indd032
            
            AFTER FIELD l_indd032
               LET l_indd032_desc = ''
               DISPLAY BY NAME l_indd032_desc
               IF NOT cl_null(l_indd032) THEN 
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_indc006
                  LET g_chkparam.arg2 = l_indd032
                  LET g_errshow = TRUE
                  LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  IF cl_chk_exist("v_inaa001") THEN
                  ELSE
                     LET l_indd032 = ''
                     NEXT FIELD CURRENT   
                  END IF
                  CALL s_control_chk_doc('7',g_indcdocno,l_indd032,l_indd033,'','','') RETURNING r_success,l_flag
                  IF r_success THEN
                     IF NOT l_flag THEN
                        LET l_indd032 = ''
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     LET l_indd032 = ''
                     NEXT FIELD CURRENT
                  END IF   
                  #161007-00012#2-s-add
                  CALL s_aint320_vmi_type(g_indc006,l_indd032) RETURNING l_indd032_type  
                  IF l_indd032_type = '2' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code = 'ain-00841'  #庫位：%1，為結算倉，不可輸入！
                     LET g_errparam.replace[1] = l_indd032
                     LET g_errparam.popup = TRUE
                     LET l_indd032 = ''
                     CALL cl_err()         
                     NEXT FIELD CURRENT
                  END IF
                  #161007-00012#2-e-add                  
               END IF
               CALL s_desc_get_stock_desc(g_indc006,l_indd032) RETURNING l_indd032_desc
               DISPLAY BY NAME l_indd032_desc
               
            ON ACTION controlp INFIELD l_indd033
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = l_indd033
               LET g_qryparam.arg1 = g_indc006
               LET g_qryparam.arg2 = l_indd032            
               CALL q_inab002_6()
               LET l_indd033 = g_qryparam.return1
               DISPLAY l_indd033 TO indd033
               NEXT FIELD l_indd033
            
            AFTER FIELD l_indd033
               LET l_indd033_desc = ''
               DISPLAY BY NAME l_indd033_desc
               IF NOT cl_null(l_indd033) THEN 
                  SELECT inaa007 INTO l_inaa007 FROM inaa_t
                   WHERE inaaent = g_enterprise
                     AND inaasite = g_indc006 AND inaa001 = l_indd032
                  IF l_inaa007 = '1' THEN                  
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_indc006
                     LET g_chkparam.arg2 = l_indd032
                     LET g_chkparam.arg3 = l_indd033
                     LET g_errshow = TRUE #是否開窗                   
                     LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                     IF cl_chk_exist("v_inab002") THEN
                     ELSE
                        LET l_indd033 = ''
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  CALL s_control_chk_doc('7',g_indcdocno,l_indd032,l_indd033,'','','') RETURNING r_success,l_flag
                  IF r_success THEN
                     IF NOT l_flag THEN
                        LET l_indd033 = ''
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     LET l_indd033 = ''
                     NEXT FIELD CURRENT
                  END IF               
               END IF 
               CALL s_desc_get_locator_desc(g_indc006,l_indd032,l_indd033) RETURNING l_indd033_desc
               DISPLAY BY NAME l_indd033_desc
            
            ON CHANGE aint330_02_type1
               CALL cl_set_comp_required("l_indd032",FALSE)
               CALL cl_set_comp_entry("l_indd032,l_indd033",FALSE)
               IF l_type1 = '2' THEN
                  CALL cl_set_comp_entry("l_indd032,l_indd033",TRUE)
                  CALL cl_set_comp_required("l_indd032",TRUE)
               END IF
               
            AFTER FIELD amt1
               IF l_amt1 <= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "ade-00016"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()       
                  NEXT FIELD CURRENT               
               END IF
         END INPUT
         #add--2016/10/27 By shiun--(E)
         
#         DISPLAY ARRAY g_indd_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
#      
#            BEFORE DISPLAY 
#               CALL FGL_SET_ARR_CURR(g_detail_idx)
#
#               
#            BEFORE ROW
#               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
#               LET l_ac = g_detail_idx
#               LET g_temp_idx = l_ac
#               DISPLAY g_detail_idx TO FORMONLY.idx
#               CALL cl_show_fld_cont() 
#               CALL aint330_02_set_pk_array()
#               CALL cl_user_overview_set_follow_pic()            
#               
#         END DISPLAY
       
         
         BEFORE DIALOG
            IF g_temp_idx > 0 THEN
               LET l_ac = g_temp_idx
               CALL DIALOG.setCurrentRow("s_detail1",l_ac)
               LET g_temp_idx = 1
            END IF
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            CALL aint330_02_set_button('1')
            #mark--2016/10/27 By shiun--(S)
#            SELECT count(*) INTO l_cnt 
#              FROM aint330_02_tmp01
#            IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
#            IF l_cnt = 0 THEN
#               CALL aint330_02_query1()
#            END IF
            #mark--2016/10/27 By shiun--(E)
            CALL g_curr_diag.setCurrentRow("s_detail1",1)
            #add--2016/10/27 By shiun--(S)
            CALL cl_qbe_init()
            LET l_type1 = 1
            LET l_chk1 = 'N'
            CALL cl_set_comp_required("l_indd032",FALSE)
            CALL cl_set_comp_entry("l_indd032,l_indd033",FALSE)
            #161230-00001#1-s-add            
            LET l_indd032_desc = ''
            LET l_indd033_desc = ''
            DISPLAY BY NAME l_indd032_desc             
            DISPLAY BY NAME l_indd033_desc           
            #161230-00001#1-e-add   
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD indddocno            
            END CASE
            #add--2016/10/27 By shiun--(E)

         #mark--2016/10/27 By shiun--(S)
#         ON ACTION query
#            LET g_action_choice="query"
#            IF cl_auth_chk_act("query") THEN
#               CALL aint330_02_query1()
#               CALL g_curr_diag.setCurrentRow("s_detail1",1)
#            END IF         
# 
#         ON ACTION modify
#            LET g_action_choice="modify"
#            IF cl_auth_chk_act("modify") THEN
#               CALL aint330_02_modify1()
#               CALL g_curr_diag.setCurrentRow("s_detail1",1)
#            END IF
#                  
#         ON ACTION modify_detail
#            LET g_action_choice="modify_detail"
#            IF cl_auth_chk_act("modify") THEN
#               CALL aint330_02_modify1()
#               CALL g_curr_diag.setCurrentRow("s_detail1",1)
#            END IF
         #mark--2016/10/27 By shiun--(E)   
         
         ON ACTION next_step
            LET g_action_choice="next_step"
                      
            #避免資料有異動因此要重寫TEMP
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            DELETE FROM aint330_02_tmp01
            LET l_j = g_indd_d.getLength()
            FOR l_i = 1 TO l_j
               IF g_indd_d[l_i].sel = 'Y' THEN
                  #寫入TEMP
                  IF cl_null(g_indd_d[l_i].indd103)    THEN LET g_indd_d[l_i].indd103    = 0 END IF
                  IF cl_null(g_indd_d[l_i].l_amt01_01) THEN LET g_indd_d[l_i].l_amt01_01 = 0 END IF
                  IF cl_null(g_indd_d[l_i].indd105)    THEN LET g_indd_d[l_i].indd105    = 0 END IF                  
                  IF cl_null(g_indd_d[l_i].l_amt01_02) THEN LET g_indd_d[l_i].l_amt01_02 = 0 END IF
                  #add--2016/10/21 By shiun--(S)
                  IF cl_null(g_indd_d[l_i].indd032) THEN LET g_indd_d[l_i].indd032 = ' ' END IF
                  IF cl_null(g_indd_d[l_i].indd033) THEN LET g_indd_d[l_i].indd033 = ' ' END IF
                  #add--2016/10/21 By shiun--(E)
                  INSERT INTO aint330_02_tmp01(sel    ,sfdc004,sfdc005,sfdc006,sfdc007,
                                               inag008,sfdc009,sfdc010,inag025,sfdc012,
                                               sfdc013)
                                       VALUES('Y'                     ,g_indd_d[l_i].indd002,g_indd_d[l_i].indd004,g_indd_d[l_i].indd006,g_indd_d[l_i].indd103,
                                              g_indd_d[l_i].l_amt01_01,g_indd_d[l_i].indd104,g_indd_d[l_i].indd105,g_indd_d[l_i].l_amt01_02,g_indd_d[l_i].indd032,
                                              g_indd_d[l_i].indd033)
               END IF
            END FOR
            SELECT count(*) INTO l_cnt
              FROM aint330_02_tmp01
            IF l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = -100 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
            ELSE
               CALL cl_set_comp_visible('page_1,page_2',FALSE)
               CALL cl_set_comp_visible('page_3',TRUE)
               CALL aint330_02_set_button('3')
               INSERT INTO aint330_02_tmp02
                     SELECT sfdc004,sfdc005,sfdc006,sfdc009,sfdc012,sfdc013,SUM(sfdc007),inag008,SUM(sfdc010),inag025,0,0
                       FROM aint330_02_tmp01
                      WHERE sel = 'Y'
                      GROUP BY sfdc004,sfdc005,sfdc006,sfdc009,sfdc012,sfdc013,inag008,inag025
               CALL s_transaction_end('Y','0')
               LET g_step = '2'
               EXIT WHILE
            END IF         
            
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice="exit"
            CANCEL DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            CANCEL DIALOG            
         

         ON ACTION related_document
            CALL aint330_02_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aint330_02_set_pk_array()
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aint330_02_set_pk_array()
            CALL cl_user_overview_follow('')
         #add--2016/10/27 By shiun--(S)   
         ON ACTION accept
            IF g_wc2 = " 1=1" THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = s_fin_get_colname("abmm200",'bmaa001')
               LET g_errparam.code = "adz-00255"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CONTINUE DIALOG
            ELSE
               IF cl_null(l_amt1) OR l_amt1 < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = l_amt1
                  LET g_errparam.code = "apm-01103"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG                  
               END IF
               IF l_type1 = '2' AND cl_null(l_indd032) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code = "ain-00822"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG  
               END IF
               LET g_wc2 = cl_replace_str(g_wc2,'l_bmaa001','bmaa001')
               LET g_wc2 = cl_replace_str(g_wc2,'l_bmaa002','bmaa002')
               CALL aint330_02_b_fill1(g_wc2,l_type1,l_indd032,l_indd033,l_amt1,l_chk1)
            END IF
#            ACCEPT DIALOG              
         #add--2016/10/27 By shiun--(E)
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
      
      #add--2016/10/27 By shiun--(S)
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         #還原
         LET g_wc2 = " 1=2"
         RETURN
      ELSE
         LET g_error_show = 1
         LET g_detail_idx = 1
      END IF
      
#      IF g_wc2 = " 1=1" THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.extend = s_fin_get_colname("abmm200",'bmaa001')
#         LET g_errparam.code = "adz-00255"
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#         CALL aint330_02_query1()
#      ELSE
#         LET g_wc2 = cl_replace_str(g_wc2,'l_bmaa001','bmaa001')
#         LET g_wc2 = cl_replace_str(g_wc2,'l_bmaa002','bmaa002')
#         CALL aint330_02_b_fill1(g_wc2,l_type1,l_indd032,l_indd033,l_amt1,l_chk1)
#      END IF
      LET INT_FLAG = FALSE
      #add--2016/10/27 By shiun--(E)
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN

         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
   IF g_step = '2' THEN
      CALL aint330_02_ui_dialog3()
   END IF
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_02_query1()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   DEFINE l_bmaa001  LIKE bmaa_t.bmaa001
   DEFINE l_bmaa002  LIKE bmaa_t.bmaa002
   DEFINE l_type1    LIKE type_t.chr1
   DEFINE l_indd032  LIKE indd_t.indd032
   DEFINE l_indd033  LIKE indd_t.indd033
   DEFINE l_amt1     LIKE type_t.num5
   DEFINE l_chk1     LIKE type_t.chr1
   DEFINE l_inaa007  LIKE inaa_t.inaa007
   DEFINE r_success  LIKE type_t.num5
   DEFINE l_flag     LIKE type_t.chr1
   DEFINE l_indd032_desc   LIKE type_t.chr500
   DEFINE l_indd033_desc   LIKE type_t.chr500
   #161007-00012#2-s-add
   DEFINE l_para_in_2      STRING  #撥入倉(結算倉)
   DEFINE l_indd032_type   LIKE type_t.num5
   #161007-00012#2-e-add
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_indd_d.clear()  
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 

      CONSTRUCT g_wc2 ON l_bmaa001,l_bmaa002 FROM bmaa001,bmaa002
      
         ON ACTION controlp INFIELD bmaa001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = l_bmaa001
            CALL q_imaa001_9()
            LET l_bmaa001 = g_qryparam.return1
            DISPLAY l_bmaa001 TO bmaa001
            NEXT FIELD bmaa001
            
      
      END CONSTRUCT

      INPUT l_type1,l_indd032,l_indd033,l_amt1,l_chk1
            FROM aint330_02_type1,l_indd032,l_indd033,amt1,chk1
         
         
         ON ACTION controlp INFIELD l_indd032
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = l_indd032
            LET g_qryparam.arg1 = g_indc006
            #161007-00012#2-s-add
            #--排除結算倉的部分 
            LET l_para_in_2 = cl_get_para(g_enterprise,g_indc006,'S-BAS-0044')           #VMI結算庫位Tag(撥入倉)  
            LET g_qryparam.where = " NOT EXISTS (SELECT inac001 FROM inac_t ",
                                   "              WHERE inacent='",g_enterprise,"' AND inacsite='",g_indc006,"' AND inaa001=inac001 AND inac003='",l_para_in_2,"') "
            #161007-00012#2-e-add
            CALL q_inaa001_4()
            LET l_indd032 = g_qryparam.return1              
            DISPLAY l_indd032 TO indd032
            NEXT FIELD l_indd032
         
         AFTER FIELD l_indd032
            LET l_indd032_desc = ''
            DISPLAY BY NAME l_indd032_desc
            IF NOT cl_null(l_indd032) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_indc006
               LET g_chkparam.arg2 = l_indd032
               LET g_errshow = TRUE
               LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
               IF cl_chk_exist("v_inaa001") THEN
               ELSE
                  LET l_indd032 = ''
                  NEXT FIELD CURRENT   
               END IF
               CALL s_control_chk_doc('7',g_indcdocno,l_indd032,l_indd033,'','','') RETURNING r_success,l_flag
               IF r_success THEN
                  IF NOT l_flag THEN
                     LET l_indd032 = ''
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  LET l_indd032 = ''
                  NEXT FIELD CURRENT
               END IF        
               #161007-00012#2-s-add
               CALL s_aint320_vmi_type(g_indc006,l_indd032) RETURNING l_indd032_type  
               IF l_indd032_type = '2' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code = 'ain-00841'  #庫位：%1，為結算倉，不可輸入！
                  LET g_errparam.replace[1] = l_indd032
                  LET g_errparam.popup = TRUE
                  LET l_indd032 = ''
                  CALL cl_err()         
                  NEXT FIELD CURRENT
               END IF
               #161007-00012#2-e-add                          
            END IF
            CALL s_desc_get_stock_desc(g_indc006,l_indd032) RETURNING l_indd032_desc
            DISPLAY BY NAME l_indd032_desc
            
         ON ACTION controlp INFIELD l_indd033
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = l_indd033
            LET g_qryparam.arg1 = g_indc006
            LET g_qryparam.arg2 = l_indd032            
            CALL q_inab002_6()
            LET l_indd033 = g_qryparam.return1
            DISPLAY l_indd033 TO indd033
            NEXT FIELD l_indd033
         
         AFTER FIELD l_indd033
            LET l_indd033_desc = ''
            DISPLAY BY NAME l_indd033_desc
            IF NOT cl_null(l_indd033) THEN 
               SELECT inaa007 INTO l_inaa007 FROM inaa_t
                WHERE inaaent = g_enterprise
                  AND inaasite = g_indc006 AND inaa001 = l_indd032
               IF l_inaa007 = '1' THEN                  
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_indc006
                  LET g_chkparam.arg2 = l_indd032
                  LET g_chkparam.arg3 = l_indd033
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                  IF cl_chk_exist("v_inab002") THEN
                  ELSE
                     LET l_indd033 = ''
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_control_chk_doc('7',g_indcdocno,l_indd032,l_indd033,'','','') RETURNING r_success,l_flag
               IF r_success THEN
                  IF NOT l_flag THEN
                     LET l_indd033 = ''
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  LET l_indd033 = ''
                  NEXT FIELD CURRENT
               END IF               
            END IF 
            CALL s_desc_get_locator_desc(g_indc006,l_indd032,l_indd033) RETURNING l_indd033_desc
            DISPLAY BY NAME l_indd033_desc
         
         ON CHANGE aint330_02_type1
            CALL cl_set_comp_required("l_indd032",FALSE)
            CALL cl_set_comp_entry("l_indd032,l_indd033",FALSE)
            IF l_type1 = '2' THEN
               CALL cl_set_comp_entry("l_indd032,l_indd033",TRUE)
               CALL cl_set_comp_required("l_indd032",TRUE)
            END IF
            
         AFTER FIELD amt1
            IF l_amt1 <= 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "ade-00016"
               LET g_errparam.popup = TRUE
               CALL cl_err()       
               NEXT FIELD CURRENT               
            END IF
      END INPUT
  
      BEFORE DIALOG 
         CALL cl_qbe_init()
         LET l_type1 = '1'
         LET l_chk1  = 'N'
         CALL cl_set_comp_required("l_indd032",FALSE)
         CALL cl_set_comp_entry("l_indd032,l_indd033",FALSE)


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
      LET g_wc2 = " 1=2"
      RETURN
   ELSE
      LET g_error_show = 1
      LET g_detail_idx = 1
   END IF
   
   IF g_wc2 = " 1=1" THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = s_fin_get_colname("abmm200",'bmaa001')
      LET g_errparam.code = "adz-00255"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL aint330_02_query1()
   ELSE
      LET g_wc2 = cl_replace_str(g_wc2,'l_bmaa001','bmaa001')
      LET g_wc2 = cl_replace_str(g_wc2,'l_bmaa002','bmaa002')
      CALL aint330_02_b_fill1(g_wc2,l_type1,l_indd032,l_indd033,l_amt1,l_chk1)
   END IF
   LET INT_FLAG = FALSE
   
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_02_modify1()
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
   DEFINE  r_success              LIKE type_t.num5
   DEFINE  l_flag                 LIKE type_t.num5
   DEFINE  l_inaa007              LIKE inaa_t.inaa007
   DEFINE  l_j                     LIKE type_t.num5   #add--2016/10/27 By shiun

 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   
   LET INT_FLAG = FALSE 
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      
      INPUT ARRAY g_indd_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS,
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
       
         BEFORE ROW
            CALL cl_set_comp_entry("indd002,indd004,indd006,indd103,l_amt01_01,indd104,indd105,l_amt01_02,indd002_desc,imaal004_desc",FALSE)
            #add--2016/10/05 By shiun--(S)
            LET l_ac_t = l_ac 
            LET l_ac = DIALOG.getCurrentRow("s_detail1")
            #add--2016/10/05 By shiun--(E)
      
         ON ACTION controlp INFIELD indd032
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'i'
             LET g_qryparam.reqry = FALSE
             LET g_qryparam.default1 = g_indd_d[l_ac].indd032
             LET g_qryparam.arg1 = g_indc006
             CALL q_inaa001_4()
             LET g_indd_d[l_ac].indd032 = g_qryparam.return1              
             DISPLAY g_indd_d[l_ac].indd032 TO indd032
             NEXT FIELD indd032
         
        AFTER FIELD indd032
          LET g_indd_d[l_ac].indd032_desc = ''
          IF NOT cl_null(g_indd_d[l_ac].indd032) THEN 
             INITIALIZE g_chkparam.* TO NULL
             LET g_chkparam.arg1 = g_indc006
             LET g_chkparam.arg2 = g_indd_d[l_ac].indd032
             LET g_errshow = TRUE
             LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
             IF cl_chk_exist("v_inaa001") THEN
             ELSE
                LET g_indd_d[l_ac].indd032 = ''
                NEXT FIELD CURRENT   
             END IF
             CALL s_control_chk_doc('7',g_indcdocno,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033,'','','') RETURNING r_success,l_flag
             IF r_success THEN
                IF NOT l_flag THEN
                   LET g_indd_d[l_ac].indd032 = ''
                   NEXT FIELD CURRENT
                END IF
             ELSE
                LET g_indd_d[l_ac].indd032 = ''
                NEXT FIELD CURRENT
             END IF      
          END IF
          CALL s_desc_get_stock_desc(g_indc006,g_indd_d[l_ac].indd032) RETURNING g_indd_d[l_ac].indd032_desc
          DISPLAY BY NAME g_indd_d[l_ac].indd032_desc
      
      ON ACTION controlp INFIELD indd033
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.default1 = g_indd_d[l_ac].indd033
         LET g_qryparam.arg1 = g_indc006
         LET g_qryparam.arg2 = g_indd_d[l_ac].indd033            
         CALL q_inab002_6()
         LET g_indd_d[l_ac].indd033 = g_qryparam.return1
         DISPLAY g_indd_d[l_ac].indd033 TO indd033
         NEXT FIELD indd033
      
      AFTER FIELD indd033
         LET g_indd_d[l_ac].indd033_desc = ''
         DISPLAY BY NAME g_indd_d[l_ac].indd033_desc
         IF NOT cl_null(g_indd_d[l_ac].indd032) THEN 
            SELECT inaa007 INTO l_inaa007 FROM inaa_t
             WHERE inaaent = g_enterprise
               AND inaasite = g_indc006 AND inaa001 = g_indd_d[l_ac].indd032
            IF l_inaa007 = '1' THEN                  
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_indc006
               LET g_chkparam.arg2 = g_indd_d[l_ac].indd032
               LET g_chkparam.arg3 = g_indd_d[l_ac].indd033
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
               IF cl_chk_exist("v_inab002") THEN
               ELSE
                  LET g_indd_d[l_ac].indd033 = ''
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_control_chk_doc('7',g_indcdocno,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033,'','','') RETURNING r_success,l_flag
            IF r_success THEN
               IF NOT l_flag THEN
                  LET g_indd_d[l_ac].indd033 = ''
                  NEXT FIELD CURRENT
               END IF
            ELSE
               LET g_indd_d[l_ac].indd033 = ''
               NEXT FIELD CURRENT
            END IF               
         END IF 
         CALL s_desc_get_locator_desc(g_indc006,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033) RETURNING g_indd_d[l_ac].indd033_desc
         DISPLAY BY NAME g_indd_d[l_ac].indd033_desc
   
      END INPUT
      
      
      BEFORE DIALOG
         IF g_temp_idx > 0 THEN
            LET l_ac = g_temp_idx
            CALL DIALOG.setCurrentRow("s_detail1",l_ac)
            LET g_temp_idx = 1
         END IF
         CASE g_aw
            WHEN "s_detail1"
               NEXT FIELD indddocno
 
         END CASE
   
      #add--2016/10/27 By shiun--(S)
      ON ACTION next_step
         LET g_action_choice="next_step"
                   
         #避免資料有異動因此要重寫TEMP
         IF s_transaction_chk("N",0) THEN
            CALL s_transaction_begin()
         END IF
         DELETE FROM aint330_02_tmp01
         LET l_j = g_indd_d.getLength()
         FOR l_i = 1 TO l_j
            IF g_indd_d[l_i].sel = 'Y' THEN
               #寫入TEMP
               IF cl_null(g_indd_d[l_i].indd103)    THEN LET g_indd_d[l_i].indd103    = 0 END IF
               IF cl_null(g_indd_d[l_i].l_amt01_01) THEN LET g_indd_d[l_i].l_amt01_01 = 0 END IF
               IF cl_null(g_indd_d[l_i].indd105)    THEN LET g_indd_d[l_i].indd105    = 0 END IF                  
               IF cl_null(g_indd_d[l_i].l_amt01_02) THEN LET g_indd_d[l_i].l_amt01_02 = 0 END IF
               IF cl_null(g_indd_d[l_i].indd032) THEN LET g_indd_d[l_i].indd032 = ' ' END IF
               IF cl_null(g_indd_d[l_i].indd033) THEN LET g_indd_d[l_i].indd033 = ' ' END IF
               INSERT INTO aint330_02_tmp01(sel    ,sfdc004,sfdc005,sfdc006,sfdc007,
                                            inag008,sfdc009,sfdc010,inag025,sfdc012,
                                            sfdc013)
                                    VALUES('Y'                     ,g_indd_d[l_i].indd002,g_indd_d[l_i].indd004,g_indd_d[l_i].indd006,g_indd_d[l_i].indd103,
                                           g_indd_d[l_i].l_amt01_01,g_indd_d[l_i].indd104,g_indd_d[l_i].indd105,g_indd_d[l_i].l_amt01_02,g_indd_d[l_i].indd032,
                                           g_indd_d[l_i].indd033)
            END IF
         END FOR
         SELECT count(*) INTO l_cnt
           FROM aint330_02_tmp01
         IF l_cnt = 0 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "" 
            LET g_errparam.code   = -100 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
            CONTINUE DIALOG
         ELSE
            CALL cl_set_comp_visible('page_1,page_2',FALSE)
            CALL cl_set_comp_visible('page_3',TRUE)
            CALL aint330_02_set_button('3')
            INSERT INTO aint330_02_tmp02
                  SELECT sfdc004,sfdc005,sfdc006,sfdc009,sfdc012,sfdc013,SUM(sfdc007),inag008,SUM(sfdc010),inag025,0,0
                    FROM aint330_02_tmp01
                   WHERE sel = 'Y'
                   GROUP BY sfdc004,sfdc005,sfdc006,sfdc009,sfdc012,sfdc013,inag008,inag025
            CALL s_transaction_end('Y','0')
            LET g_step = '2'
            EXIT DIALOG
#            EXIT WHILE
         END IF             
      #add--2016/10/27 By shiun--(E)
      
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
 
   CLOSE aint330_02_bcl
   #add--2016/10/27 By shiun--(S)
   IF g_step = '2' THEN
      CALL aint330_02_ui_dialog3()
   END IF
#   IF INT_FLAG AND g_step <> '2' THEN
#      CALL aint330_02_query1()
#   END IF
   #add--2016/10/27 By shiun--(E)
   
   
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_02_b_fill1(p_wc,p_aint330_02_type1,p_indd032,p_indd033,p_amt1,p_chk1)
DEFINE p_wc       STRING
DEFINE p_aint330_02_type1     LIKE type_t.chr1
DEFINE p_indd032  LIKE indd_t.indd032
DEFINE p_indd033  LIKE indd_t.indd033
DEFINE p_amt1     LIKE type_t.num5
DEFINE p_chk1     LIKE type_t.chr1
DEFINE l_sql      STRING
DEFINE l_pmdb004  LIKE pmdb_t.pmdb004     #料件編號
DEFINE l_pmdb007  LIKE pmdb_t.pmdb007     #單位
DEFINE l_bmaa002  LIKE bmaa_t.bmaa002     #特性
DEFINE l_inag007  LIKE inag_t.inag007
DEFINE l_inag008  LIKE inag_t.inag008
DEFINE l_success  LIKE type_t.num5
DEFINE l_i        LIKE type_t.num5
DEFINE l_j        LIKE type_t.num5
DEFINE l_k        LIKE type_t.num5
DEFINE l_ac       LIKE type_t.num5
DEFINE l_bmba       DYNAMIC ARRAY OF RECORD #回传数组
         bmba001    LIKE bmba_t.bmba001,        #bom相关资料都可以通过回传的key值抓取
         bmba002    LIKE bmba_t.bmba002,
         bmba003    LIKE bmba_t.bmba003,
         bmba004    LIKE bmba_t.bmba004,
         bmba005    DATETIME YEAR TO SECOND,
         bmba007    LIKE bmba_t.bmba007,
         bmba008    LIKE bmba_t.bmba008,
         bmba035    LIKE bmba_t.bmba035,        #保稅否  #160512-00016#14 20160527 add by ming
         l_bmba011  LIKE bmba_t.bmba011,        #QPA 分子，对应于原始的主件料号
         l_bmba012  LIKE bmba_t.bmba012,        #QPA 分母，对应于原始的主件料号
         l_inam002  LIKE inam_t.inam002         #元件对应特征
                END RECORD

DEFINE l_bmba1      RECORD  #回传数组
         bmba001    LIKE bmba_t.bmba001,     #主件料號 #bom相关资料都可以通过回传的key值抓取
         bmba002    LIKE bmba_t.bmba002,     #特性
         bmba003    LIKE bmba_t.bmba003,     #元件料號
         bmba004    LIKE bmba_t.bmba004,     #部位編號
         bmba005    DATETIME YEAR TO SECOND, #生效日期時間
         bmba007    LIKE bmba_t.bmba007,     #作業編號
         bmba008    LIKE bmba_t.bmba008,     #作業序
         bmba010    LIKE bmba_t.bmba010,     #發料單位
         bmba011    LIKE bmba_t.bmba011,     #組成用量
         bmba012    LIKE bmba_t.bmba012,     #主件底數
         bmba014    LIKE bmba_t.bmba014,     #特徵管理
         bmba028    LIKE bmba_t.bmba028,     #用量公式
         bmba035    LIKE bmba_t.bmba035,     #保稅否
         l_bmba011  LIKE bmba_t.bmba011,     #QPA 分子，对应于原始的主件料号
         l_bmba012  LIKE bmba_t.bmba012,     #QPA 分母，对应于原始的主件料号
         l_inam002  LIKE inam_t.inam002      #元件对应特征
                END RECORD
            
DEFINE l_imaf015     LIKE imaf_t.imaf015     #參考單位
DEFINE l_imaf053     LIKE imaf_t.imaf053     #庫存單位
DEFINE g_vdate       LIKE type_t.chr20
   
   CALL g_indd_d.clear()
   IF p_chk1 = 'Y' THEN    #展尾階  
      LET l_sql = " SELECT UNIQUE bmba001,'','','','',",
               "        '','',bmba010,'','','',",
               "        '',''",
               "  FROM bmaa_t,bmba_t ",
               " WHERE bmaaent =",g_enterprise,
               "   AND bmaaent = bmbaent AND bmaasite = bmbasite AND bmaasite = '",g_indc006,"'",
               "   AND bmaa001 = bmba001 AND bmaa002 = bmba002 ",
               "   AND ",p_wc
   ELSE
      LET l_sql = " SELECT bmba001,bmba002,bmba003,bmba004,bmba005,",
                  "        bmba007,bmba008,bmba010,bmba011,bmba012,bmba014,",
                  "        bmba028,bmba035",
                  "  FROM bmaa_t,bmba_t ",
                  " WHERE bmaaent =",g_enterprise,
                  "   AND bmaaent = bmbaent AND bmaasite = bmbasite AND bmaasite = '",g_indc006,"' AND bmba019 != '2' ",
                  "   AND bmaa001 = bmba001 AND bmaa002 = bmba002 ",
                  "   AND ",p_wc
      LET g_vdate = cl_get_current()
      LET l_sql = l_sql CLIPPED," AND (to_char(bmba005,'yyyy-mm-dd hh24:mi:ss') <='", g_vdate,"')",
                                " AND (to_char(bmba006,'yyyy-mm-dd hh24:mi:ss') >  '",g_vdate,"'"," OR to_char(bmba006,'yyyy-mm-dd hh24:mi:ss') IS NULL )"
   END IF
   
   PREPARE aint330_02_b_fill1_p FROM l_sql
   DECLARE aint330_02_b_fill1_c CURSOR FOR aint330_02_b_fill1_p
   LET l_ac = 1
   FOREACH aint330_02_b_fill1_c INTO l_bmba1.bmba001,l_bmba1.bmba002,l_bmba1.bmba003,l_bmba1.bmba004,l_bmba1.bmba005,
                                     l_bmba1.bmba007,l_bmba1.bmba008,l_bmba1.bmba010,l_bmba1.bmba011,l_bmba1.bmba012,l_bmba1.bmba014,
                                     l_bmba1.bmba028,l_bmba1.bmba035
      
      CALL l_bmba.clear()
      IF p_chk1 = 'Y' THEN    #展尾階         
         CALL s_asft300_02_bom(0,l_bmba1.bmba001,l_bmaa002,l_bmba1.bmba010,1,1,'','Y','','','N','N') 
              RETURNING l_bmba
      ELSE
         LET l_bmba[1].bmba001 = l_bmba1.bmba001
         LET l_bmba[1].bmba002 = l_bmba1.bmba002
         LET l_bmba[1].bmba003 = l_bmba1.bmba003
         LET l_bmba[1].bmba004 = l_bmba1.bmba004
         LET l_bmba[1].bmba005 = l_bmba1.bmba005
         LET l_bmba[1].bmba007 = l_bmba1.bmba007
         LET l_bmba[1].bmba008 = l_bmba1.bmba008
         LET l_bmba[1].bmba035 = l_bmba1.bmba035
         LET l_bmba[1].l_bmba011=l_bmba1.bmba011
         LET l_bmba[1].l_bmba012=l_bmba1.bmba012
      END IF
      LET l_j = l_bmba.getLength()
      FOR l_i = 1 TO l_j
         LET g_indd_d[l_ac].sel = 'N'
         LET g_indd_d[l_ac].indd002 = l_bmba[l_i].bmba003      #料件
         CALL s_desc_get_item_desc(g_indd_d[l_ac].indd002) RETURNING g_indd_d[l_ac].indd002_desc,g_indd_d[l_ac].imaal004_desc
         LET g_indd_d[l_ac].bmaa002 = l_bmba[l_i].bmba002      #特性
         IF p_chk1 = 'Y' THEN    #展尾階    
         ELSE
            LET g_indd_d[l_ac].indd006 = l_bmba1.bmba010
         END IF         
         #組成用量/主件底數
         LET g_indd_d[l_ac].indd103 = l_bmba[l_i].l_bmba011 / l_bmba[l_i].l_bmba012 * p_amt1
         SELECT imaf015,imaf053 INTO l_imaf015,l_imaf053
           FROM imaf_t
          WHERE imafent = g_enterprise 
            AND imafsite= g_indc006 AND imaf001 = l_bmba[l_i].bmba003
         LET g_indd_d[l_ac].indd006 = l_imaf053
         #mark--2016/10/05 By shiun--(S)
#         CALL aint330_02_get_inag008(l_bmba[l_i].bmba003,g_indd_d[l_ac].indd004,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033,l_imaf053)
#              RETURNING g_indd_d[l_ac].l_amt01_01         
         #參考單位
#         LET g_indd_d[l_ac].indd104 = l_imaf015
#         IF NOT cl_null(g_indd_d[l_ac].indd104) THEN
#            CALL s_aooi250_convert_qty(l_bmba[l_i].bmba003,g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd104,g_indd_d[l_ac].indd103)
#                 RETURNING l_success,g_indd_d[l_ac].indd105
#            CALL s_aooi250_convert_qty(l_bmba[l_i].bmba003,g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd104,g_indd_d[l_ac].l_amt01_01)
#                 RETURNING l_success,g_indd_d[l_ac].l_amt01_02
#         END IF
         #mark--2016/10/05 By shiun--(E)
         IF p_aint330_02_type1  = '2' THEN
            LET g_indd_d[l_ac].indd032 = p_indd032
            LET g_indd_d[l_ac].indd033 = p_indd033            
         ELSE
            SELECT imae101,imae102 INTO g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033
              FROM imae_t
             WHERE imaeent = g_enterprise AND imaesite = g_indc006 
               AND imae001 = g_indd_d[l_ac].indd002
         END IF
         CALL s_desc_get_stock_desc(g_indc006,g_indd_d[l_ac].indd032) RETURNING g_indd_d[l_ac].indd032_desc
         CALL s_desc_get_locator_desc(g_indc006,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033) RETURNING g_indd_d[l_ac].indd033_desc   
         IF cl_null(g_indd_d[l_ac].indd004) THEN LET g_indd_d[l_ac].indd004 = ' ' END IF
         #add--2016/10/05 By shiun--(S)
         CALL aint330_02_get_inag008(l_bmba[l_i].bmba003,g_indd_d[l_ac].indd004,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033,l_imaf053)
              RETURNING g_indd_d[l_ac].l_amt01_01
         #參考單位
         LET g_indd_d[l_ac].indd104 = l_imaf015
         IF NOT cl_null(g_indd_d[l_ac].indd104) THEN
            CALL s_aooi250_convert_qty(l_bmba[l_i].bmba003,g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd104,g_indd_d[l_ac].indd103)
                 RETURNING l_success,g_indd_d[l_ac].indd105
            CALL s_aooi250_convert_qty(l_bmba[l_i].bmba003,g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd104,g_indd_d[l_ac].l_amt01_01)
                 RETURNING l_success,g_indd_d[l_ac].l_amt01_02
         END IF
         #add--2016/10/05 By shiun--(E)
         LET l_ac = l_ac + 1
      END FOR 
   END FOREACH
   CALL g_indd_d.deleteElement(l_ac)
   LET l_ac = l_ac -1   
   IF l_ac = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
#      CALL aint330_02_ui_dialog1()   #add--2016/10/27 By shiun
#      RETURN   #add--2016/10/05 By shiun
   END IF
#   CALL aint330_02_ui_dialog1()   #add--2016/10/05 By shiun
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_02_ui_dialog2()
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
DEFINE l_cnt     LIKE type_t.num5
DEFINE l_i       LIKE type_t.num5
DEFINE l_j       LIKE type_t.num5
#add--2016/10/27 By shiun--(S)
DEFINE ls_wc             LIKE type_t.chr500
DEFINE ls_return         STRING
DEFINE ls_result         STRING 
DEFINE l_sfaadocno       STRING    #161208-00012#1----mod----   LIKE bmaa_t.bmaa001  改为 STRING
DEFINE l_sfaa010         LIKE bmaa_t.bmaa002
DEFINE l_type2           LIKE type_t.chr1
DEFINE l_indd0321        LIKE indd_t.indd032
DEFINE l_indd0331        LIKE indd_t.indd033
DEFINE l_inaa007         LIKE inaa_t.inaa007
DEFINE r_success         LIKE type_t.num5
DEFINE l_flag            LIKE type_t.chr1
DEFINE l_indd0321_desc   LIKE type_t.chr500
DEFINE l_indd0331_desc   LIKE type_t.chr500
DEFINE l_ac_t            LIKE type_t.num10               #未取消的ARRAY CNT 
#161007-00012#2-s-add
DEFINE l_para_in_2      STRING  #撥入倉(結算倉)
DEFINE l_indd0321_type  LIKE type_t.num5
#161007-00012#2-e-add

   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()      
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   LET g_detail_idx = 1   
   
   WHILE TRUE
      
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
         #add--2016/10/27 By shiun--(S)
         CONSTRUCT g_wc2 ON l_sfaadocno,l_sfaa010 FROM sfaadocno,sfaa010
            ON ACTION controlp INFIELD sfaadocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = l_sfaadocno
               LET g_qryparam.where = " sfaasite = '",g_indc006,"' AND sfaastus IN ('Y','F') AND (sfba013-sfba016) >0 "
               LET g_qryparam.where = g_qryparam.where , " AND sfba006 IN (SELECT imaf001 FROM imaf_t WHERE imafent = '",g_enterprise,"' AND imafsite = '",g_indc006,"' AND imaf013 = '1' ) "
               CALL q_sfbaseq1_1()
               LET l_sfaadocno = g_qryparam.return1
               DISPLAY l_sfaadocno TO sfaadocno
               NEXT FIELD sfaadocno
               
            ON ACTION controlp INFIELD sfaa010
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = l_sfaa010
               CALL q_imaa001_9()
               LET l_sfaa010 = g_qryparam.return1
               DISPLAY l_sfaa010 TO sfaa010
               NEXT FIELD sfaa010
               
         END CONSTRUCT
         
         INPUT l_type2,l_indd0321,l_indd0331
               FROM aint330_02_type2,l_indd0321,l_indd0331
            
            
            ON ACTION controlp INFIELD l_indd0321
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = l_indd0321
               LET g_qryparam.arg1 = g_indc006
               #161007-00012#2-s-add
               #--排除結算倉的部分 
               LET l_para_in_2 = cl_get_para(g_enterprise,g_indc006,'S-BAS-0044')           #VMI結算庫位Tag(撥入倉)  
               LET g_qryparam.where = " NOT EXISTS (SELECT inac001 FROM inac_t ",
                                      "              WHERE inacent='",g_enterprise,"' AND inacsite='",g_indc006,"' AND inaa001=inac001 AND inac003='",l_para_in_2,"') "
               #161007-00012#2-e-add
               CALL q_inaa001_4()
               LET l_indd0321 = g_qryparam.return1              
               DISPLAY l_indd0321 TO indd0321
               NEXT FIELD l_indd0321
            
            AFTER FIELD l_indd0321
               LET l_indd0321_desc = ''
               DISPLAY BY NAME l_indd0321_desc
               IF NOT cl_null(l_indd0321) THEN 
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_indc006
                  LET g_chkparam.arg2 = l_indd0321
                  LET g_errshow = TRUE
                  LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  IF cl_chk_exist("v_inaa001") THEN
                  ELSE
                     LET l_indd0321 = ''
                     NEXT FIELD CURRENT   
                  END IF
                  CALL s_control_chk_doc('7',g_indcdocno,l_indd0321,l_indd0331,'','','') RETURNING r_success,l_flag
                  IF r_success THEN
                     IF NOT l_flag THEN
                        LET l_indd0321 = ''
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     LET l_indd0321 = ''
                     NEXT FIELD CURRENT
                  END IF      
                  #161007-00012#2-s-add
                  CALL s_aint320_vmi_type(g_indc006,l_indd0321) RETURNING l_indd0321_type  
                  IF l_indd0321_type = '2' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code = 'ain-00841'  #庫位：%1，為結算倉，不可輸入！
                     LET g_errparam.replace[1] = l_indd0321
                     LET g_errparam.popup = TRUE
                     LET l_indd0321 = ''
                     CALL cl_err()         
                     NEXT FIELD CURRENT
                  END IF
                  #161007-00012#2-e-add                    
               END IF
               CALL s_desc_get_stock_desc(g_indc006,l_indd0321) RETURNING l_indd0321_desc
               DISPLAY BY NAME l_indd0321_desc
               
            ON ACTION controlp INFIELD l_indd0331
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = l_indd0331
               LET g_qryparam.arg1 = g_indc006
               LET g_qryparam.arg2 = l_indd0321       
               CALL q_inab002_6()
               LET l_indd0331 = g_qryparam.return1
               DISPLAY l_indd0331 TO indd0331
               NEXT FIELD l_indd0331
            
            AFTER FIELD l_indd0331
               LET l_indd0331_desc = ''
               DISPLAY BY NAME l_indd0331_desc
               IF NOT cl_null(l_indd0331) THEN 
                  SELECT inaa007 INTO l_inaa007 FROM inaa_t
                   WHERE inaaent = g_enterprise
                     AND inaasite = g_indc006 AND inaa001 = l_indd0321
                  IF l_inaa007 = '1' THEN                  
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_indc006
                     LET g_chkparam.arg2 = l_indd0321
                     LET g_chkparam.arg3 = l_indd0331
                     LET g_errshow = TRUE #是否開窗                   
                     LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                     IF cl_chk_exist("v_inab002") THEN
                     ELSE
                        LET l_indd0331 = ''
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  CALL s_control_chk_doc('7',g_indcdocno,l_indd0321,l_indd0331,'','','') RETURNING r_success,l_flag
                  IF r_success THEN
                     IF NOT l_flag THEN
                        LET l_indd0331 = ''
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     LET l_indd0331 = ''
                     NEXT FIELD CURRENT
                  END IF               
               END IF 
               CALL s_desc_get_locator_desc(g_indc006,l_indd0321,l_indd0331) RETURNING l_indd0331_desc
               DISPLAY BY NAME l_indd0331_desc
            
            ON CHANGE aint330_02_type2
               CALL cl_set_comp_required("l_indd0321",FALSE)
               CALL cl_set_comp_entry("l_indd0321,l_indd0331",FALSE)
               IF l_type2 = '2' THEN
                  CALL cl_set_comp_entry("l_indd0321,l_indd0331",TRUE)
                  CALL cl_set_comp_required("l_indd0321",TRUE)
               END IF
               
            
         END INPUT
         
         INPUT ARRAY g_indd2_d FROM s_detail2.*
             ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS,
                     INSERT ROW = FALSE, 
                     DELETE ROW = FALSE,
                     APPEND ROW = FALSE)
          
            BEFORE ROW
               CALL cl_set_comp_entry("sfbadocno,sfbaseq,sfbaseq1,sfba006,indd002_desc1,imaal004_desc1,indd0041,indd0061,l_amt02_01,l_amt02_02,indd1041,l_amt02_03,l_amt02_04,indd032_desc1,indd033_desc1",FALSE)
               #add--2016/10/05 By shiun--(S)
               LET l_ac_t = l_ac 
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               #add--2016/10/05 By shiun--(E)
         
            ON ACTION controlp INFIELD indd0321
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = FALSE
                LET g_qryparam.default1 = g_indd2_d[l_ac].indd0321
                LET g_qryparam.arg1 = g_indc006
                CALL q_inaa001_4()
                LET g_indd2_d[l_ac].indd0321 = g_qryparam.return1              
                DISPLAY g_indd2_d[l_ac].indd0321 TO indd0321
                NEXT FIELD indd0321
            
           AFTER FIELD indd0321
             LET g_indd2_d[l_ac].indd0321_desc = ''
             IF NOT cl_null(g_indd2_d[l_ac].indd0321) THEN 
                INITIALIZE g_chkparam.* TO NULL
                LET g_chkparam.arg1 = g_indc006
                LET g_chkparam.arg2 = g_indd2_d[l_ac].indd0321
                LET g_errshow = TRUE
                LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                IF cl_chk_exist("v_inaa001") THEN
                ELSE
                   LET g_indd2_d[l_ac].indd0321 = ''
                   NEXT FIELD CURRENT   
                END IF
                CALL s_control_chk_doc('7',g_indcdocno,g_indd2_d[l_ac].indd0321,g_indd2_d[l_ac].indd0331,'','','') RETURNING r_success,l_flag
                IF r_success THEN
                   IF NOT l_flag THEN
                      LET g_indd2_d[l_ac].indd0321 = ''
                      NEXT FIELD CURRENT
                   END IF
                ELSE
                   LET g_indd2_d[l_ac].indd0321 = ''
                   NEXT FIELD CURRENT
                END IF               
             END IF
             CALL s_desc_get_stock_desc(g_indc006,g_indd2_d[l_ac].indd0321) RETURNING g_indd2_d[l_ac].indd0321_desc
             DISPLAY BY NAME g_indd2_d[l_ac].indd0321_desc
         
         ON ACTION controlp INFIELD indd0331
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_indd2_d[l_ac].indd0331
            LET g_qryparam.arg1 = g_indc006
            LET g_qryparam.arg2 = g_indd2_d[l_ac].indd0331            
            CALL q_inab002_6()
            LET g_indd2_d[l_ac].indd0331 = g_qryparam.return1
            DISPLAY g_indd2_d[l_ac].indd0331 TO indd0331
            NEXT FIELD indd0331
         
         AFTER FIELD indd0331
            LET g_indd2_d[l_ac].indd0331_desc = ''
            DISPLAY BY NAME g_indd2_d[l_ac].indd0331_desc
            IF NOT cl_null(g_indd2_d[l_ac].indd0321) THEN 
               SELECT inaa007 INTO l_inaa007 FROM inaa_t
                WHERE inaaent = g_enterprise
                  AND inaasite = g_indc006 AND inaa001 = g_indd2_d[l_ac].indd0321
               IF l_inaa007 = '1' THEN                  
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_indc006
                  LET g_chkparam.arg2 = g_indd2_d[l_ac].indd0321
                  LET g_chkparam.arg3 = g_indd2_d[l_ac].indd0331
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                  IF cl_chk_exist("v_inab002") THEN
                  ELSE
                     LET g_indd2_d[l_ac].indd0331 = ''
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_control_chk_doc('7',g_indcdocno,g_indd2_d[l_ac].indd0321,g_indd2_d[l_ac].indd0331,'','','') RETURNING r_success,l_flag
               IF r_success THEN
                  IF NOT l_flag THEN
                     LET g_indd2_d[l_ac].indd0331 = ''
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  LET g_indd2_d[l_ac].indd0331 = ''
                  NEXT FIELD CURRENT
               END IF               
            END IF 
            CALL s_desc_get_locator_desc(g_indc006,g_indd2_d[l_ac].indd0321,g_indd2_d[l_ac].indd0331) RETURNING g_indd2_d[l_ac].indd0331_desc
            DISPLAY BY NAME g_indd2_d[l_ac].indd0331_desc
         
         END INPUT
         #add--2016/10/27 By shiun--(S)
         #mark--2016/10/27 By shiun--(S)
#         DISPLAY ARRAY g_indd2_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt) 
#      
#            BEFORE DISPLAY 
#               CALL FGL_SET_ARR_CURR(g_detail_idx)
#
#               
#            BEFORE ROW
#               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
#               LET l_ac = g_detail_idx
#               LET g_temp_idx = l_ac
#               DISPLAY g_detail_idx TO FORMONLY.idx
#               CALL cl_show_fld_cont() 
#               CALL aint330_02_set_pk_array()
#               CALL cl_user_overview_set_follow_pic()            
#               
#         END DISPLAY
         #mark--2016/10/27 By shiun--(E)
         
         BEFORE DIALOG
            IF g_temp_idx > 0 THEN
               LET l_ac = g_temp_idx
               CALL DIALOG.setCurrentRow("s_detail2",l_ac)
               LET g_temp_idx = 1
            END IF
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail2", 1)
            CALL aint330_02_set_button('1')
            #mark--2016/10/27 By shiun--(S)
#            SELECT count(*) INTO l_cnt 
#              FROM aint330_02_tmp01
#            IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
#            IF l_cnt = 0 THEN
#               CALL aint330_02_query2()
#            END IF
            #mark--2016/10/27 By shiun--(E)
            CALL g_curr_diag.setCurrentRow("s_detail2",1)
            #add--2016/10/27 By shiun--(S)
            CALL cl_qbe_init()
            LET l_type2 = '1'
            CALL cl_set_comp_required("l_indd0321",FALSE)
            CALL cl_set_comp_entry("l_indd0321,l_indd0331",FALSE)
            CASE g_aw
               WHEN "s_detail2"
                  NEXT FIELD indddocno
            
            END CASE
            #add--2016/10/27 By shiun--(E)

         #mark--2016/10/27 By shiun--(S)
#         ON ACTION query
#            LET g_action_choice="query"
#            IF cl_auth_chk_act("query") THEN
#               CALL aint330_02_query2()
#               CALL g_curr_diag.setCurrentRow("s_detail2",1)
#            END IF
# 
#         ON ACTION modify
#            LET g_action_choice="modify"
#            IF cl_auth_chk_act("modify") THEN
#               CALL aint330_02_modify2()
#               CALL g_curr_diag.setCurrentRow("s_detail2",1)
#            END IF
#         
#         ON ACTION modify_detail
#            LET g_action_choice="modify_detail"
#            IF cl_auth_chk_act("modify") THEN
#               CALL aint330_02_modify2()
#               CALL g_curr_diag.setCurrentRow("s_detail2",1)
#            END IF
         #mark--2016/10/27 By shiun--(E)   
         
         ON ACTION next_step
            LET g_action_choice="next_step"
                      
            #避免資料有異動因此要重寫TEMP
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            DELETE FROM aint330_02_tmp01
            LET l_j = g_indd2_d.getLength()
            FOR l_i = 1 TO l_j
               IF g_indd2_d[l_i].sel1 = 'Y' THEN
                  #寫入TEMP
                  IF cl_null(g_indd2_d[l_i].l_amt02_01) THEN LET g_indd2_d[l_i].l_amt02_01 = 0 END IF
                  IF cl_null(g_indd2_d[l_i].l_amt02_02) THEN LET g_indd2_d[l_i].l_amt02_02 = 0 END IF
                  IF cl_null(g_indd2_d[l_i].l_amt02_03) THEN LET g_indd2_d[l_i].l_amt02_03 = 0 END IF
                  IF cl_null(g_indd2_d[l_i].l_amt02_04) THEN LET g_indd2_d[l_i].l_amt02_04 = 0 END IF
                  #add--2016/10/21 By shiun--(S)
                  IF cl_null(g_indd2_d[l_i].indd0321) THEN LET g_indd2_d[l_i].indd0321 = ' ' END IF
                  IF cl_null(g_indd2_d[l_i].indd0331) THEN LET g_indd2_d[l_i].indd0331 = ' ' END IF
                  #add--2016/10/21 By shiun--(E)
                  INSERT INTO aint330_02_tmp01(sel    ,sfdc004,sfdc005,sfdc006,sfdc007,
                                               inag008,sfdc009,sfdc010,inag025,sfdc012,
                                               sfdc013)
                                       VALUES('Y'                      ,g_indd2_d[l_i].b_sfba006,g_indd2_d[l_i].indd0041  ,g_indd2_d[l_i].indd0061  ,g_indd2_d[l_i].l_amt02_01,
                                              g_indd2_d[l_i].l_amt02_02,g_indd2_d[l_i].indd1041 ,g_indd2_d[l_i].l_amt02_03,g_indd2_d[l_i].l_amt02_04,g_indd2_d[l_i].indd0321,
                                              g_indd2_d[l_i].indd0331)
               END IF
            END FOR
            SELECT count(*) INTO l_cnt
              FROM aint330_02_tmp01
            IF l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = -100 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
            ELSE
               CALL cl_set_comp_visible('page_1,page_2',FALSE)
               CALL cl_set_comp_visible('page_3',TRUE)
               CALL aint330_02_set_button('3')
               INSERT INTO aint330_02_tmp02
                     SELECT sfdc004,sfdc005,sfdc006,sfdc009,sfdc012,sfdc013,SUM(sfdc007),inag008,SUM(sfdc010),inag025,0,0
                       FROM aint330_02_tmp01
                      WHERE sel = 'Y'
                      GROUP BY sfdc004,sfdc005,sfdc006,sfdc009,sfdc012,sfdc013,inag008,inag025
               CALL s_transaction_end('Y','0')
               LET g_step = '2'
               EXIT WHILE
            END IF         
         
         ON ACTION accept
            IF l_type2 = '2' AND cl_null(l_indd0321) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code = "ain-00822"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CONTINUE DIALOG  
            END IF
            LET g_wc2 = cl_replace_str(g_wc2,'l_sfaadocno','sfaadocno')
            LET g_wc2 = cl_replace_str(g_wc2,'l_sfaa010','sfaa010')
            CALL aint330_02_b_fill2(g_wc2,l_type2,l_indd0321,l_indd0331)
#            ACCEPT DIALOG              
         #add--2016/10/27 By shiun--(E)
            
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice="exit"
            CANCEL DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            CANCEL DIALOG            
         

         ON ACTION related_document
            CALL aint330_02_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aint330_02_set_pk_array()
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aint330_02_set_pk_array()
            CALL cl_user_overview_follow('')
         
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
      #add--2016/10/27 By shiun--(S)
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         #還原
         LET g_wc2 = " 1=2"
         RETURN
      ELSE
         LET g_error_show = 1
         LET g_detail_idx = 1
      END IF      
      LET INT_FLAG = FALSE
      #add--2016/10/27 By shiun--(E)
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN

         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
   IF g_step = '2' THEN
      CALL aint330_02_ui_dialog3()
   END IF
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_02_query2()
 DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   DEFINE l_sfaadocno  STRING  #161208-00012#1----mod----   LIKE bmaa_t.bmaa001  改为 STRING
   DEFINE l_sfaa010  LIKE bmaa_t.bmaa002
   DEFINE l_type2    LIKE type_t.chr1
   DEFINE l_indd0321 LIKE indd_t.indd032
   DEFINE l_indd0331 LIKE indd_t.indd033
   DEFINE l_inaa007  LIKE inaa_t.inaa007
   DEFINE r_success  LIKE type_t.num5
   DEFINE l_flag     LIKE type_t.chr1
   DEFINE l_indd0321_desc   LIKE type_t.chr500
   DEFINE l_indd0331_desc   LIKE type_t.chr500
   #161007-00012#2-s-add
   DEFINE l_para_in_2      STRING  #撥入倉(結算倉)
   DEFINE l_indd0321_type  LIKE type_t.num5
   #161007-00012#2-e-add
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_indd2_d.clear()  
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON l_sfaadocno,l_sfaa010 FROM sfaadocno,sfaa010
         ON ACTION controlp INFIELD sfaadocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = l_sfaadocno
            LET g_qryparam.where = " sfaasite = '",g_indc006,"' AND sfaastus IN ('Y','F') AND (sfba013-sfba016) >0 "
            LET g_qryparam.where = g_qryparam.where , " AND sfba006 IN (SELECT imaf001 FROM imaf_t WHERE imafent = '",g_enterprise,"' AND imafsite = '",g_indc006,"' AND imaf013 = '1' ) "
            CALL q_sfbaseq1_1()
            LET l_sfaadocno = g_qryparam.return1
            DISPLAY l_sfaadocno TO sfaadocno
            NEXT FIELD sfaadocno
            
         ON ACTION controlp INFIELD sfaa010
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = l_sfaa010
            CALL q_imaa001_9()
            LET l_sfaa010 = g_qryparam.return1
            DISPLAY l_sfaa010 TO sfaa010
            NEXT FIELD sfaa010
            
      END CONSTRUCT

      INPUT l_type2,l_indd0321,l_indd0331
            FROM aint330_02_type2,l_indd0321,l_indd0331
         
         
         ON ACTION controlp INFIELD l_indd0321
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = l_indd0321
            LET g_qryparam.arg1 = g_indc006
            #161007-00012#2-s-add
            #--排除結算倉的部分 
            LET l_para_in_2 = cl_get_para(g_enterprise,g_indc006,'S-BAS-0044')           #VMI結算庫位Tag(撥入倉)  
            LET g_qryparam.where = " NOT EXISTS (SELECT inac001 FROM inac_t ",
                                   "              WHERE inacent='",g_enterprise,"' AND inacsite='",g_indc006,"' AND inaa001=inac001 AND inac003='",l_para_in_2,"') "
            #161007-00012#2-e-add
            CALL q_inaa001_4()
            LET l_indd0321 = g_qryparam.return1              
            DISPLAY l_indd0321 TO indd0321
            NEXT FIELD l_indd0321
         
         AFTER FIELD l_indd0321
            LET l_indd0321_desc = ''
            DISPLAY BY NAME l_indd0321_desc
            IF NOT cl_null(l_indd0321) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_indc006
               LET g_chkparam.arg2 = l_indd0321
               LET g_errshow = TRUE
               LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
               IF cl_chk_exist("v_inaa001") THEN
               ELSE
                  LET l_indd0321 = ''
                  NEXT FIELD CURRENT   
               END IF
               CALL s_control_chk_doc('7',g_indcdocno,l_indd0321,l_indd0331,'','','') RETURNING r_success,l_flag
               IF r_success THEN
                  IF NOT l_flag THEN
                     LET l_indd0321 = ''
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  LET l_indd0321 = ''
                  NEXT FIELD CURRENT
               END IF   
               #161007-00012#2-s-add
               CALL s_aint320_vmi_type(g_indc006,l_indd0321) RETURNING l_indd0321_type  
               IF l_indd0321_type = '2' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code = 'ain-00841'  #庫位：%1，為結算倉，不可輸入！
                  LET g_errparam.replace[1] = l_indd0321
                  LET g_errparam.popup = TRUE
                  LET l_indd0321 = ''
                  CALL cl_err()         
                  NEXT FIELD CURRENT
               END IF
               #161007-00012#2-e-add                
            END IF
            CALL s_desc_get_stock_desc(g_indc006,l_indd0321) RETURNING l_indd0321_desc
            DISPLAY BY NAME l_indd0321_desc
            
         ON ACTION controlp INFIELD l_indd0331
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = l_indd0331
            LET g_qryparam.arg1 = g_indc006
            LET g_qryparam.arg2 = l_indd0321       
            CALL q_inab002_6()
            LET l_indd0331 = g_qryparam.return1
            DISPLAY l_indd0331 TO indd0331
            NEXT FIELD l_indd0331
         
         AFTER FIELD l_indd0331
            LET l_indd0331_desc = ''
            DISPLAY BY NAME l_indd0331_desc
            IF NOT cl_null(l_indd0331) THEN 
               SELECT inaa007 INTO l_inaa007 FROM inaa_t
                WHERE inaaent = g_enterprise
                  AND inaasite = g_indc006 AND inaa001 = l_indd0321
               IF l_inaa007 = '1' THEN                  
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_indc006
                  LET g_chkparam.arg2 = l_indd0321
                  LET g_chkparam.arg3 = l_indd0331
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                  IF cl_chk_exist("v_inab002") THEN
                  ELSE
                     LET l_indd0331 = ''
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_control_chk_doc('7',g_indcdocno,l_indd0321,l_indd0331,'','','') RETURNING r_success,l_flag
               IF r_success THEN
                  IF NOT l_flag THEN
                     LET l_indd0331 = ''
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  LET l_indd0331 = ''
                  NEXT FIELD CURRENT
               END IF               
            END IF 
            CALL s_desc_get_locator_desc(g_indc006,l_indd0321,l_indd0331) RETURNING l_indd0331_desc
            DISPLAY BY NAME l_indd0331_desc
         
         ON CHANGE aint330_02_type2
            CALL cl_set_comp_required("l_indd0321",FALSE)
            CALL cl_set_comp_entry("l_indd0321,l_indd0331",FALSE)
            IF l_type2 = '2' THEN
               CALL cl_set_comp_entry("l_indd0321,l_indd0331",TRUE)
               CALL cl_set_comp_required("l_indd0321",TRUE)
            END IF
            
         
      END INPUT
  
      BEFORE DIALOG 
         CALL cl_qbe_init()
         LET l_type2 = '1'
         CALL cl_set_comp_required("l_indd0321",FALSE)
         CALL cl_set_comp_entry("l_indd0321,l_indd0331",FALSE)


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
      LET g_wc2 = " 1=2"
      RETURN
   ELSE
      LET g_error_show = 1
      LET g_detail_idx = 1
   END IF
   

   LET g_wc2 = cl_replace_str(g_wc2,'l_sfaadocno','sfaadocno')
   LET g_wc2 = cl_replace_str(g_wc2,'l_sfaa010','sfaa010')
   CALL aint330_02_b_fill2(g_wc2,l_type2,l_indd0321,l_indd0331)

   LET INT_FLAG = FALSE
   
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_02_modify2()
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
   DEFINE  r_success              LIKE type_t.num5
   DEFINE  l_flag                 LIKE type_t.num5
   DEFINE  l_inaa007              LIKE inaa_t.inaa007

 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   
   LET INT_FLAG = FALSE 
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      
      INPUT ARRAY g_indd2_d FROM s_detail2.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS,
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
       
         BEFORE ROW
            CALL cl_set_comp_entry("sfbadocno,sfbaseq,sfbaseq1,sfba006,indd002_desc1,imaal004_desc1,indd0041,indd0061,l_amt02_01,l_amt02_02,indd1041,l_amt02_03,l_amt02_04,indd032_desc1,indd033_desc1",FALSE)
            #add--2016/10/05 By shiun--(S)
            LET l_ac_t = l_ac 
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            #add--2016/10/05 By shiun--(E)
      
         ON ACTION controlp INFIELD indd0321
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'i'
             LET g_qryparam.reqry = FALSE
             LET g_qryparam.default1 = g_indd2_d[l_ac].indd0321
             LET g_qryparam.arg1 = g_indc006
             CALL q_inaa001_4()
             LET g_indd2_d[l_ac].indd0321 = g_qryparam.return1              
             DISPLAY g_indd2_d[l_ac].indd0321 TO indd0321
             NEXT FIELD indd0321
         
        AFTER FIELD indd0321
          LET g_indd2_d[l_ac].indd0321_desc = ''
          IF NOT cl_null(g_indd2_d[l_ac].indd0321) THEN 
             INITIALIZE g_chkparam.* TO NULL
             LET g_chkparam.arg1 = g_indc006
             LET g_chkparam.arg2 = g_indd2_d[l_ac].indd0321
             LET g_errshow = TRUE
             LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
             IF cl_chk_exist("v_inaa001") THEN
             ELSE
                LET g_indd2_d[l_ac].indd0321 = ''
                NEXT FIELD CURRENT   
             END IF
             CALL s_control_chk_doc('7',g_indcdocno,g_indd2_d[l_ac].indd0321,g_indd2_d[l_ac].indd0331,'','','') RETURNING r_success,l_flag
             IF r_success THEN
                IF NOT l_flag THEN
                   LET g_indd2_d[l_ac].indd0321 = ''
                   NEXT FIELD CURRENT
                END IF
             ELSE
                LET g_indd2_d[l_ac].indd0321 = ''
                NEXT FIELD CURRENT
             END IF               
          END IF
          CALL s_desc_get_stock_desc(g_indc006,g_indd2_d[l_ac].indd0321) RETURNING g_indd2_d[l_ac].indd0321_desc
          DISPLAY BY NAME g_indd2_d[l_ac].indd0321_desc
      
      ON ACTION controlp INFIELD indd0331
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.default1 = g_indd2_d[l_ac].indd0331
         LET g_qryparam.arg1 = g_indc006
         LET g_qryparam.arg2 = g_indd2_d[l_ac].indd0331            
         CALL q_inab002_6()
         LET g_indd2_d[l_ac].indd0331 = g_qryparam.return1
         DISPLAY g_indd2_d[l_ac].indd0331 TO indd0331
         NEXT FIELD indd0331
      
      AFTER FIELD indd0331
         LET g_indd2_d[l_ac].indd0331_desc = ''
         DISPLAY BY NAME g_indd2_d[l_ac].indd0331_desc
         IF NOT cl_null(g_indd2_d[l_ac].indd0321) THEN 
            SELECT inaa007 INTO l_inaa007 FROM inaa_t
             WHERE inaaent = g_enterprise
               AND inaasite = g_indc006 AND inaa001 = g_indd2_d[l_ac].indd0321
            IF l_inaa007 = '1' THEN                  
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_indc006
               LET g_chkparam.arg2 = g_indd2_d[l_ac].indd0321
               LET g_chkparam.arg3 = g_indd2_d[l_ac].indd0331
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
               IF cl_chk_exist("v_inab002") THEN
               ELSE
                  LET g_indd2_d[l_ac].indd0331 = ''
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_control_chk_doc('7',g_indcdocno,g_indd2_d[l_ac].indd0321,g_indd2_d[l_ac].indd0331,'','','') RETURNING r_success,l_flag
            IF r_success THEN
               IF NOT l_flag THEN
                  LET g_indd2_d[l_ac].indd0331 = ''
                  NEXT FIELD CURRENT
               END IF
            ELSE
               LET g_indd2_d[l_ac].indd0331 = ''
               NEXT FIELD CURRENT
            END IF               
         END IF 
         CALL s_desc_get_locator_desc(g_indc006,g_indd2_d[l_ac].indd0321,g_indd2_d[l_ac].indd0331) RETURNING g_indd2_d[l_ac].indd0331_desc
         DISPLAY BY NAME g_indd2_d[l_ac].indd0331_desc
   
      END INPUT
      
      
      BEFORE DIALOG
         IF g_temp_idx > 0 THEN
            LET l_ac = g_temp_idx
            CALL DIALOG.setCurrentRow("s_detail2",l_ac)
            LET g_temp_idx = 1
         END IF
         CASE g_aw
            WHEN "s_detail2"
               NEXT FIELD indddocno
 
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
 
   CLOSE aint330_02_bcl
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_02_b_fill2(p_wc,p_aint330_02_type2,p_indd032,p_indd033)
DEFINE p_wc       STRING
DEFINE p_aint330_02_type2     LIKE type_t.chr1
DEFINE p_indd032  LIKE indd_t.indd032
DEFINE p_indd033  LIKE indd_t.indd033
DEFINE l_sql      STRING
DEFINE l_pmdb004  LIKE pmdb_t.pmdb004     #料件編號
DEFINE l_pmdb007  LIKE pmdb_t.pmdb007     #單位
DEFINE l_bmaa002  LIKE bmaa_t.bmaa002     #特性
DEFINE l_inag007  LIKE inag_t.inag007
DEFINE l_inag008  LIKE inag_t.inag008
DEFINE l_imaa006  LIKE imaa_t.imaa006
DEFINE l_success  LIKE type_t.num5
DEFINE l_i        LIKE type_t.num5
DEFINE l_j        LIKE type_t.num5
DEFINE l_k        LIKE type_t.num5
DEFINE l_ac       LIKE type_t.num5
DEFINE l_imaf015     LIKE imaf_t.imaf015     #參考單位
DEFINE l_imaf053     LIKE imaf_t.imaf053     #庫存單位

   CALL g_indd2_d.clear()
   LET l_sql = " SELECT 'N',sfbadocno,sfbaseq,sfbaseq1,sfba006,",
               "        sfba021,sfba014,(sfba013-sfba016)",
               "  FROM sfaa_t,sfba_t ",
               " WHERE sfaaent =",g_enterprise,
               "   AND sfaaent = sfbaent AND sfaadocno = sfbadocno ",
               "   AND ",p_wc
   PREPARE aint330_02_b_fill2_p FROM l_sql
   DECLARE aint330_02_b_fill2_c CURSOR FOR aint330_02_b_fill2_p
   LET l_ac = 1
   FOREACH aint330_02_b_fill2_c INTO g_indd2_d[l_ac].sel1,g_indd2_d[l_ac].b_sfbadocno,g_indd2_d[l_ac].b_sfbaseq,g_indd2_d[l_ac].b_sfbaseq1,g_indd2_d[l_ac].b_sfba006,
                                     g_indd2_d[l_ac].indd0041,g_indd2_d[l_ac].indd0061,g_indd2_d[l_ac].l_amt02_01
      CALL s_desc_get_item_desc(g_indd2_d[l_ac].b_sfba006) RETURNING g_indd2_d[l_ac].indd002_desc1,g_indd2_d[l_ac].imaal004_desc1
      
      SELECT imaf015,imaf053 INTO l_imaf015,l_imaf053
        FROM imaf_t
       WHERE imafent = g_enterprise 
         AND imafsite= g_indc006 AND imaf001 = g_indd2_d[l_ac].b_sfba006
      #應發數量
      CALL s_aooi250_convert_qty(g_indd2_d[l_ac].b_sfba006,l_imaf053,g_indd2_d[l_ac].indd0061,g_indd2_d[l_ac].l_amt02_01)
           RETURNING l_success,g_indd2_d[l_ac].l_amt02_01
      #mark--2016/10/05 By shiun--(S)
      #庫存數量
      #asfp370_01_get_inag008
#      CALL aint330_02_get_inag008(g_indd2_d[l_ac].b_sfba006,g_indd2_d[l_ac].indd0041,g_indd2_d[l_ac].indd0321,g_indd2_d[l_ac].indd0331,l_imaf053)
#              RETURNING g_indd2_d[l_ac].l_amt02_02      
      #參考單位
#      LET g_indd2_d[l_ac].indd1041 = l_imaf015
#      IF NOT cl_null(g_indd2_d[l_ac].indd1041) THEN
#         CALL s_aooi250_convert_qty(g_indd2_d[l_ac].b_sfba006,l_imaf053,g_indd2_d[l_ac].indd1041,g_indd2_d[l_ac].l_amt02_01)
#              RETURNING l_success,g_indd2_d[l_ac].l_amt02_03
#         CALL s_aooi250_convert_qty(g_indd2_d[l_ac].b_sfba006,l_imaf053,g_indd2_d[l_ac].indd1041,g_indd2_d[l_ac].l_amt02_02)
#              RETURNING l_success,g_indd2_d[l_ac].l_amt02_04
#      END IF      
      #mark--2016/10/05 By shiun--(E)
      IF p_aint330_02_type2 = '2' THEN
         LET g_indd2_d[l_ac].indd0321 = p_indd032
         LET g_indd2_d[l_ac].indd0331 = p_indd033            
      ELSE
         SELECT imae101,imae102 INTO g_indd2_d[l_ac].indd0321,g_indd2_d[l_ac].indd0331
           FROM imae_t
          WHERE imaeent = g_enterprise AND imaesite = g_indc006 
            AND imae001 = g_indd2_d[l_ac].b_sfba006
      END IF
      CALL s_desc_get_stock_desc(g_indc006,g_indd2_d[l_ac].indd0321) RETURNING g_indd2_d[l_ac].indd0321_desc
      CALL s_desc_get_locator_desc(g_indc006,g_indd2_d[l_ac].indd0321,g_indd2_d[l_ac].indd0331) RETURNING g_indd2_d[l_ac].indd0331_desc   
      #add--2016/10/05 By shiun--(S)
      #庫存數量
      #asfp370_01_get_inag008
      CALL aint330_02_get_inag008(g_indd2_d[l_ac].b_sfba006,g_indd2_d[l_ac].indd0041,g_indd2_d[l_ac].indd0321,g_indd2_d[l_ac].indd0331,l_imaf053)
              RETURNING g_indd2_d[l_ac].l_amt02_02
      #參考單位
      LET g_indd2_d[l_ac].indd1041 = l_imaf015
      IF NOT cl_null(g_indd2_d[l_ac].indd1041) THEN
         CALL s_aooi250_convert_qty(g_indd2_d[l_ac].b_sfba006,l_imaf053,g_indd2_d[l_ac].indd1041,g_indd2_d[l_ac].l_amt02_01)
              RETURNING l_success,g_indd2_d[l_ac].l_amt02_03
         CALL s_aooi250_convert_qty(g_indd2_d[l_ac].b_sfba006,l_imaf053,g_indd2_d[l_ac].indd1041,g_indd2_d[l_ac].l_amt02_02)
              RETURNING l_success,g_indd2_d[l_ac].l_amt02_04
      END IF      
      #add--2016/10/05 By shiun--(E)
      LET l_ac = l_ac + 1
   END FOREACH
   CALL g_indd2_d.deleteElement(l_ac)
   LET l_ac = l_ac -1
   IF l_ac = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
#   CALL aint330_02_modify2()   #add--2016/10/05 By shiun
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_02_ui_dialog3()
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
DEFINE l_cnt     LIKE type_t.num5
DEFINE l_i       LIKE type_t.num5
DEFINE l_j       LIKE type_t.num5
DEFINE g_chk2    LIKE type_t.chr1   #add--2016/10/21 By shiun
#161007-00012#2-s-add
DEFINE l_para_out_2   STRING   #撥出倉(結算倉)    
DEFINE l_inag004      LIKE inag_t.inag004
DEFINE l_inag004_type LIKE type_t.num5 
#161007-00012#2-e-add

   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()      
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   LET g_detail_idx = 1   
   
   WHILE TRUE
      
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

         #add--2016/10/21 By shiun--(S)
         INPUT g_chk2 FROM chk2 ATTRIBUTE(WITHOUT DEFAULTS)
            AFTER FIELD chk2
               IF cl_null(g_chk2) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00006'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
         
                  NEXT FIELD CURRENT
               END IF
               IF g_chk2 NOT MATCHES '[NY]' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00144'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
         
                  NEXT FIELD CURRENT
               END IF
         
         END INPUT
         
         CONSTRUCT g_wc_02 ON inag004,inag005 FROM inag004,inag005

         
            ON ACTION controlp INFIELD inag004  #撥出庫位
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " inaastus ='Y' "
               #161007-00012#2-s-add
               #--排除結算倉的部分 
               LET l_para_out_2 = cl_get_para(g_enterprise,g_site,'S-BAS-0044')           #VMI結算庫位Tag(撥出倉)  
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND NOT EXISTS (SELECT inac001 FROM inac_t ",
                                                               "                  WHERE inacent='",g_enterprise,"' AND inacsite='",g_site,"' AND inaa001=inac001 AND inac003='",l_para_out_2,"') "
               #161007-00012#2-e-add
               CALL q_inaa001_2()
               DISPLAY g_qryparam.return1 TO inag004
               NEXT FIELD inag004
            #161007-00012#2-s-add
            AFTER FIELD inag004
               LET l_inag004 = GET_FLDBUF(inag004)
               IF NOT cl_null(l_inag004) THEN
                  CALL s_aint320_vmi_type(g_site,l_inag004) RETURNING l_inag004_type  
                  IF l_inag004_type = '2' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code = 'ain-00841'  #庫位：%1，為結算倉，不可輸入！
                     LET g_errparam.replace[1] = l_inag004
                     LET g_errparam.popup = TRUE
                     LET l_inag004 = ''
                     DISPLAY l_inag004 TO inag004
                     CALL cl_err()         
                     NEXT FIELD CURRENT
                  END IF
               END IF
            #161007-00012#2-e-add
            
            ON ACTION controlp INFIELD inag005  #撥出儲位
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " inabstus ='Y' "
               CALL q_inab002_1() 
               DISPLAY g_qryparam.return1 TO inag005
               NEXT FIELD inag005            
            
         END CONSTRUCT
         #add--2016/10/21 By shiun--(E)
         
         DISPLAY ARRAY g_sfdc02_d TO s_detail2_02.* ATTRIBUTE(COUNT = g_rec_b2)
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(l_ac)
      
            BEFORE ROW
              LET l_ac = DIALOG.getCurrentRow("s_detail2_02")
              LET g_master_idx2 = l_ac
              CALL aint330_02_b_fill3()
              IF g_rec_b2 = 0 THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code =  'ain-00308'
                 LET g_errparam.extend =  ''
                 LET g_errparam.popup = FALSE
                 CALL cl_err()
              END IF
               
         END DISPLAY
         
         DISPLAY ARRAY g_inag_d TO s_detail3_02.* ATTRIBUTE(COUNT = g_rec_b3)
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(l_ac)
      
            BEFORE ROW
              LET l_ac = DIALOG.getCurrentRow("s_detail3_02")
              LET g_master_idx3 = l_ac
              CALL aint330_02_b_fill5()
      
         END DISPLAY
         
         DISPLAY ARRAY g_inai_d TO s_detail5_02.* ATTRIBUTE(COUNT = g_rec_b5)
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(l_ac)
      
            BEFORE ROW
              LET l_ac = DIALOG.getCurrentRow("s_detail5_02")
              LET g_master_idx5 = l_ac
      
         END DISPLAY
         BEFORE DIALOG
            IF g_temp_idx > 0 THEN
               LET l_ac = g_temp_idx
               CALL DIALOG.setCurrentRow("s_detail2_02",l_ac)
               LET g_temp_idx = 1
            END IF
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail2_02", 1)
            CALL aint330_02_set_button('3')
            IF cl_null(g_chk2) THEN LET g_chk2 = 'N' END IF   #add--2016/10/21 By shiun
            #add--2016/10/05 By shiun--(S)
            IF cl_null(g_action_choice) THEN
               LET g_action_choice = 'reflash'
               CALL aint330_02_b_fill3_1('N')
               EXIT DIALOG
            END IF
            IF g_action_choice = 'reflash' THEN
               LET g_action_choice = ' '
#               CALL aint330_02_query3()
            END IF
            #add--2016/10/05 By shiun--(E)

#         ON ACTION query
#            CALL aint330_02_query3()
            
         ON ACTION modify
            CALL aint330_02_modify3()
 
         ON ACTION modify_detail
            CALL aint330_02_modify3()
            
                  
         ON ACTION cre_stock
            CALL s_transaction_begin()
            CALL aint330_02_sel_ware(g_chk2)
            CALL s_transaction_end('Y','0')
            CALL aint330_02_b_fill3_1('Y')
            
            
         ON ACTION cre_data    
            
           #161230-00001#1-s-add
            LET l_cnt = 0
            SELECT COUNT(1) INTO l_cnt
            FROM aint330_02_tmp03
            IF l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -100
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
            ELSE     
           #161230-00001#1-e-add
               CALL s_transaction_begin() 
               CALL aint330_02_gen_aint330_indd() RETURNING g_sub_success
               IF g_sub_success THEN
                  CALL s_transaction_end('Y','0')   
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  'axm-00088'
                  LET g_errparam.extend =  ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_action_choice = "exit"    
                  CANCEL DIALOG
               ELSE                     #161230-00001#1 add
                  NEXT FIELD CURRENT    #161230-00001#1 add 
               END IF
            END IF                      #161230-00001#1 add   
         ON ACTION pre_step
            LET g_action_choice="pre_step"         
            CALL aint330_02_set_button('1')
            LET g_step = '1'
            EXIT WHILE
            
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice="exit"
            CANCEL DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            CANCEL DIALOG            
         

         ON ACTION related_document
            CALL aint330_02_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aint330_02_set_pk_array()
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aint330_02_set_pk_array()
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
   IF g_step = '1' THEN
      CALL aint330_02_portal()
   END IF
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_02_query3()
DEFINE g_chk2        LIKE type_t.chr1
#161007-00012#2-s-add
DEFINE l_para_out_2   STRING  #撥出倉((結算倉)     
DEFINE l_inag004      LIKE inag_t.inag004
DEFINE l_inag004_type LIKE type_t.num5 
#161007-00012#2-e-add

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      
            
      INPUT g_chk2 FROM chk2 ATTRIBUTE(WITHOUT DEFAULTS)
         AFTER FIELD chk2
            IF cl_null(g_chk2) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aqc-00006'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
      
               NEXT FIELD CURRENT
            END IF
            IF g_chk2 NOT MATCHES '[NY]' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'agl-00144'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
      
               NEXT FIELD CURRENT
            END IF
      
      END INPUT

      CONSTRUCT g_wc_02 ON inag004,inag005 FROM inag004,inag005

         
         ON ACTION controlp INFIELD inag004  #撥出庫位
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " inaastus ='Y' "
            #161007-00012#2-s-add
            #--排除結算倉的部分 
            LET l_para_out_2 = cl_get_para(g_enterprise,g_site,'S-BAS-0044')           #VMI結算庫位Tag(撥出倉)  
            LET g_qryparam.where = g_qryparam.where CLIPPED," AND NOT EXISTS (SELECT inac001 FROM inac_t ",
                                                            "                  WHERE inacent='",g_enterprise,"' AND inacsite='",g_site,"' AND inaa001=inac001 AND inac003='",l_para_out_2,"') "
            #161007-00012#2-e-add
            CALL q_inaa001_2()
            DISPLAY g_qryparam.return1 TO inag004
            NEXT FIELD inag004
            
         #161007-00012#2-s-add
         AFTER FIELD inag004
            LET l_inag004 = GET_FLDBUF(inag004)
            IF NOT cl_null(l_inag004) THEN
               CALL s_aint320_vmi_type(g_site,l_inag004) RETURNING l_inag004_type  
               IF l_inag004_type = '2' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code = 'ain-00841'  #庫位：%1，為結算倉，不可輸入！
                  LET g_errparam.replace[1] = l_inag004
                  LET g_errparam.popup = TRUE
                  LET l_inag004 = ''
                  DISPLAY l_inag004 TO inag004
                  CALL cl_err()         
                  NEXT FIELD CURRENT
               END IF
            END IF
         #161007-00012#2-e-add
          
         ON ACTION controlp INFIELD inag005  #撥出儲位
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " inabstus ='Y' "
            CALL q_inab002_1() 
            DISPLAY g_qryparam.return1 TO inag005
            NEXT FIELD inag005            
         
      END CONSTRUCT
      
      
      BEFORE DIALOG 
         IF cl_null(g_chk2) THEN LET g_chk2 = 'N' END IF

            
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
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_02_modify3()
DEFINE g_chk2     LIKE type_t.chr1
DEFINE l_success  LIKE type_t.num5
DEFINE l_rate     LIKE inaj_t.inaj014  #单位换算率
DEFINE l_cnt      LIKE type_t.num5
DEFINE l_isdiff   LIKE type_t.num5     #是否有差异 true/false 计算调拨最小量 批量用
DEFINE l_qty      LIKE inag_t.inag008  #既满足调拨批量 又满足最小调拨数量 的最小数量
DEFINE l_imaf101  LIKE imaf_t.imaf101  #调拨批量
DEFINE l_imaf102  LIKE imaf_t.imaf102  #最小调拨数量
DEFINE l_string   STRING
DEFINE l_i        LIKE type_t.num10
#add--2016/11/01 By shiun--(S)
DEFINE l_qty_sum  LIKE inag_t.inag008
DEFINE l_qty_o    LIKE inag_t.inag008
#add--2016/11/01 By shiun--(E)

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      INPUT ARRAY g_inag_d FROM s_detail3_02.*
       ATTRIBUTE(COUNT = g_rec_b3,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
               INSERT ROW = FALSE,DELETE ROW = FALSE,APPEND ROW = FALSE)
               
          BEFORE INPUT
             IF g_master_idx2 = 0 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'asf-00355'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()
                
                EXIT DIALOG
             END IF
             
          BEFORE ROW
             LET l_ac = ARR_CURR()
             LET g_master_idx3 = l_ac
             LET g_inag_d_t.* = g_inag_d[l_ac].*
             LET g_inag_d_o.* = g_inag_d[l_ac].*
             CALL aint330_02_b_fill5()
             CALL cl_set_comp_entry("qtyr_02_3",TRUE)
             IF cl_null(g_inag_d[l_ac].inag024) THEN
                CALL cl_set_comp_entry("qtyr_02_3",FALSE)
             END IF
            CALL cl_set_comp_entry("seq_02_3,inag004_02_desc,b1_indd022_desc,inag005_02_3,inag005_02_desc,inag006_02_3,inag003_02_3,inag007_02_3,inag008_02_3,inag024_02_3,inag025_02_3",FALSE)
            CALL cl_set_comp_required("sel_02_3",TRUE)   
            LET l_qty_o = g_inag_d[l_ac].qty
            
          ON CHANGE sel_02_3            
             #不可为空
             IF cl_null(g_inag_d[l_ac].sel) THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'aqc-00006'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()
   
                LET g_inag_d[l_ac].sel = g_inag_d_o.sel
                NEXT FIELD sel_02_3
             END IF
             IF g_inag_d[l_ac].sel NOT MATCHES '[NY]' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'agl-00144'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()
   
                LET g_inag_d[l_ac].sel = g_inag_d_o.sel
                NEXT FIELD sel_02_3
             END IF
             
             #更新临时表
             CALL aint330_02_upd_temp3(l_ac,'Y') RETURNING l_success
             IF NOT l_success THEN
                LET g_inag_d[l_ac].sel = g_inag_d_o.sel
                NEXT FIELD sel_02_3
             END IF
             LET g_inag_d_o.sel = g_inag_d[l_ac].sel
             #刷新单身显示
             #mod--2016/10/21 By shiun--(S)
#             CALL aint330_02_b_fill3_1('Y')
             DISPLAY BY NAME g_inag_d[l_ac].sel
             #mod--2016/10/21 By shiun--(E)
   
          ON CHANGE qty_02_3
             #不可为空
             IF cl_null(g_inag_d[l_ac].qty) THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'aqc-00006'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()
   
                LET g_inag_d[l_ac].qty = g_inag_d_o.qty
                NEXT FIELD qty_02_3
             END IF
             #不可小于0
             IF g_inag_d[l_ac].qty < 0 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'agl-00041'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()
   
                LET g_inag_d[l_ac].qty = g_inag_d_o.qty
                NEXT FIELD qty_02_3
             END IF
             #不可大于库存数量
             IF g_inag_d[l_ac].qty > g_inag_d[l_ac].inag008 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'asf-00369'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()
                
                LET g_inag_d[l_ac].qty = g_inag_d_o.qty
                NEXT FIELD qty_02_3
             END IF
             #add--2016/10/31 By shiun--(S)
             #不可大於撥出數量
             LET l_qty_sum = 0
             FOR l_i = 1 TO g_inag_d.getLength()
                LET l_qty_sum = l_qty_sum + g_inag_d[l_i].qty
             END FOR
             IF l_qty_sum > g_sfdc02_d[g_master_idx2].sfdc007 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'ain-00821'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()              
                LET g_inag_d[l_ac].qty = g_inag_d_o.qty
                NEXT FIELD qty_02_3
             END IF
             LET g_sfdc02_d[g_master_idx2].sum_qty = l_qty_sum
             CALL s_aooi250_convert_qty(g_sfdc02_d[g_master_idx2].sfdc004,g_sfdc02_d[g_master_idx2].sfdc006,g_sfdc02_d[g_master_idx2].sfdc009,l_qty_sum)
                RETURNING l_success,g_sfdc02_d[g_master_idx2].sum_qtyr
             DISPLAY g_sfdc02_d[g_master_idx2].sum_qty  TO s_detail2_02.sum_qty_02
             DISPLAY g_sfdc02_d[g_master_idx2].sum_qtyr TO s_detail2_02.sum_qtyr_02
             #add--2016/10/31 By shiun--(E)
             
            #检查调拨最小数量和批量
             CALL aint330_02_inflate_qty('1',g_sfdc02_d[g_master_idx2].sfdc004,g_inag_d[l_ac].qty) RETURNING l_isdiff,l_qty
             IF l_isdiff THEN
                SELECT imaf101,imaf102 INTO l_imaf101,l_imaf102 FROM imaf_t
                 WHERE imafent = g_enterprise
                   AND imafsite = g_site
                   AND imaf001 = g_sfdc02_d[g_master_idx2].sfdc004
                IF cl_null(l_imaf101) THEN LET l_imaf101 = 0 END IF
                IF cl_null(l_imaf102) THEN LET l_imaf102 = 0 END IF
                #当前数量不符合调拨批量%1和最小调拨量2%，是否继续？
                LET l_string = l_imaf101,"|",l_imaf102
                IF NOT cl_ask_confirm_parm("asf-00420",l_string) THEN
                   LET g_inag_d[l_ac].qty = g_inag_d_o.qty
                   NEXT FIELD qty_02_3
                END IF
             END IF
             
             #总数不可大于拟调拨的差异数量 在aint330_02_upd_temp()中判断，提高操作灵活性
             
             IF g_inag_d[l_ac].qty > 0 THEN
                LET g_inag_d[l_ac].sel = 'Y'  #不用自己再去勾选
             END IF
             
             #计算参考单位数量
             IF NOT cl_null(g_inag_d[l_ac].inag024) THEN
                CALL s_aooi250_convert_qty(g_sfdc02_d[g_master_idx2].sfdc004,g_inag_d[l_ac].inag007,g_inag_d[l_ac].inag024,g_inag_d[l_ac].qty)
                   RETURNING l_success,g_inag_d[l_ac].qtyr
                IF NOT l_success THEN
                   LET g_inag_d[l_ac].qty = g_inag_d_o.qty
                   LET g_inag_d[l_ac].qtyr = g_inag_d_o.qtyr
                   NEXT FIELD qty_02_3
                END IF
                
                IF g_inag_d[l_ac].qtyr> g_inag_d[l_ac].inag025 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'asf-00369'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   
                   LET g_inag_d_o.qty = g_inag_d[l_ac].qty
                   NEXT FIELD qtyr_02_3
                END IF
             END IF
             
             #更新临时表
             CALL aint330_02_upd_temp3(l_ac,'Y') RETURNING l_success
             IF NOT l_success THEN
                LET g_inag_d[l_ac].qty = g_inag_d_o.qty
                NEXT FIELD qty_02_3
             END IF             
             
             
             LET g_inag_d_o.qty = g_inag_d[l_ac].qty
             LET g_inag_d_o.qtyr = g_inag_d[l_ac].qtyr  #add 150101
             #刷新单身显示
#             CALL aint330_02_b_fill('Y')
             CALL aint330_02_b_fill3_1('Y')
             IF l_ac = 0 THEN
                LET l_ac = g_master_idx3
             END IF
          
          ON CHANGE qtyr_02_3
          #AFTER FIELD qtyr_02_3
             #不可为空
             IF cl_null(g_inag_d[l_ac].qtyr) THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'aqc-00006'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()
   
                LET g_inag_d[l_ac].qtyr = g_inag_d_o.qtyr
                NEXT FIELD qtyr_02_3
             END IF
             #不可小于0
             IF g_inag_d[l_ac].qtyr < 0 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'agl-00041'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()
   
                LET g_inag_d[l_ac].qtyr = g_inag_d_o.qtyr
                NEXT FIELD qtyr_02_3
             END IF
             IF NOT cl_null(g_inag_d[l_ac].inag024) THEN
                #不可大于库存数量
                IF g_inag_d[l_ac].qtyr> g_inag_d[l_ac].inag025 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'asf-00369'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   
                   LET g_inag_d[l_ac].qtyr = g_inag_d_o.qtyr
                   NEXT FIELD qtyr_02_3
                END IF
                IF g_inag_d[l_ac].qtyr >0 AND g_inag_d[l_ac].qty=0 THEN #计算单位数量
                   #mark 150101
                   #CALL s_aimi190_get_convert(g_sfdc02_d[g_master_idx2].sfdc004,g_inag_d[l_ac].inag024,g_inag_d[l_ac].inag007) RETURNING l_success,l_rate
                   #IF NOT l_success THEN
                   #   LET g_inag_d[l_ac].qtyr = g_inag_d_o.qtyr
                   #   NEXT FIELD qtyr_02_3
                   #END IF
                   #LET g_inag_d[l_ac].qty = g_inag_d[l_ac].qtyr * l_rate
                   #mark 150101 end
                   #add 150101
                   CALL s_aooi250_convert_qty(g_sfdc02_d[g_master_idx2].sfdc004,g_inag_d[l_ac].inag024,g_inag_d[l_ac].inag007,g_inag_d[l_ac].qtyr)
                      RETURNING l_success,g_inag_d[l_ac].qty
                   IF NOT l_success THEN
                      LET g_inag_d[l_ac].qtyr = g_inag_d_o.qtyr
                      LET g_inag_d[l_ac].qty  = g_inag_d_o.qty
                      NEXT FIELD qtyr_02_3
                   END IF
                   #add 150101 end
                   IF g_inag_d[l_ac].qty > g_inag_d[l_ac].inag008 THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'asf-00369'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      
                      LET g_inag_d_o.qtyr = g_inag_d[l_ac].qtyr
                      NEXT FIELD qty_02_3
                   END IF
                   
                   #add--2016/10/31 By shiun--(S)
                   #不可大於撥出數量
                   LET l_qty_sum = 0
                   FOR l_i = 1 TO g_inag_d.getLength()
                      LET l_qty_sum = l_qty_sum + g_inag_d[l_i].qtyr
                   END FOR
                   IF l_qty_sum > g_sfdc02_d[g_master_idx2].sfdc010 THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'ain-00821'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()              
                      LET g_inag_d[l_ac].qtyr = g_inag_d_o.qtyr
                      NEXT FIELD qtyr_02_3
                   END IF
                   #add--2016/10/31 By shiun--(E)
                  #检查调拨最小数量和批量
                  CALL aint330_02_inflate_qty('1',g_sfdc02_d[g_master_idx2].sfdc004,g_inag_d[l_ac].qty) RETURNING l_isdiff,l_qty
                  IF l_isdiff THEN
                     SELECT imaf101,imaf102 INTO l_imaf101,l_imaf102 FROM imaf_t
                      WHERE imafent = g_enterprise
                        AND imafsite = g_site
                        AND imaf001 = p_item
                     IF cl_null(l_imaf101) THEN LET l_imaf101 = 0 END IF
                     IF cl_null(l_imaf102) THEN LET l_imaf102 = 0 END IF
                      #当前数量不符合调拨批量10和最小调拨量10，是否继续？
                      LET l_string = l_imaf101,"|",l_imaf102
                      IF NOT cl_ask_confirm_parm("asf-00420",l_string) THEN
                         LET g_inag_d[l_ac].qty = g_inag_d_o.qty
                         NEXT FIELD qty_02_3
                      END IF
                  END IF
   
                   IF g_inag_d[l_ac].qty > 0 THEN
                      LET g_inag_d[l_ac].sel = 'Y'  #不用自己再去勾选
                   END IF
                END IF
             END IF
             
             #更新临时表
             CALL aint330_02_upd_temp3(l_ac,'Y') RETURNING l_success
             IF NOT l_success THEN
                LET g_inag_d[l_ac].qtyr = g_inag_d_o.qtyr
                NEXT FIELD qtyr_02_3
             END IF            
             
             LET g_inag_d_o.qtyr = g_inag_d[l_ac].qtyr
             LET g_inag_d_o.qty  = g_inag_d[l_ac].qty  #add 150101
             #刷新单身显示
             CALL aint330_02_b_fill3_1('Y')
   
          ON CHANGE pack_02_3
             #輸入值須存在[T:料件包裝資料檔].[C:包裝容器編號]，錯誤訊息「此料沒有
             IF NOT cl_null(g_inag_d[l_ac].pack) THEN
                INITIALIZE g_chkparam.* TO NULL
                LET g_chkparam.arg1 = g_inag_d[l_ac].pack
                IF NOT cl_chk_exist("v_imaa001_3") THEN
                   LET g_inag_d[l_ac].pack = g_inag_d_o.pack
                   NEXT FIELD pack_02_3
                END IF
             END IF
             #更新临时表
             CALL aint330_02_upd_temp3(l_ac,'N') RETURNING l_success
             IF NOT l_success THEN
                LET g_inag_d[l_ac].pack = g_inag_d_o.pack
                NEXT FIELD pack_02_3
             END IF
             #刷新单身显示
             CALL aint330_02_b_fill3_1('Y')             
      END INPUT
      
      ON ACTION accept
         ACCEPT DIALOG
      
      ON ACTION cancel
         #add--2016/11/01 By shiun--(S)
         LET g_inag_d[l_ac].qty = g_inag_d_t.qty
         CALL s_aooi250_convert_qty(g_sfdc02_d[g_master_idx2].sfdc004,g_sfdc02_d[g_master_idx2].sfdc006,g_sfdc02_d[g_master_idx2].sfdc009,g_inag_d_t.qty)
            RETURNING l_success,g_inag_d[l_ac].qtyr
         LET l_qty_sum = 0
         FOR l_i = 1 TO g_inag_d.getLength()
            LET l_qty_sum = l_qty_sum + g_inag_d[l_i].qty
         END FOR

         LET g_sfdc02_d[g_master_idx2].sum_qty = l_qty_sum
         CALL s_aooi250_convert_qty(g_sfdc02_d[g_master_idx2].sfdc004,g_sfdc02_d[g_master_idx2].sfdc006,g_sfdc02_d[g_master_idx2].sfdc009,l_qty_sum)
            RETURNING l_success,g_sfdc02_d[g_master_idx2].sum_qtyr
         DISPLAY g_sfdc02_d[g_master_idx2].sum_qty  TO s_detail2_02.sum_qty_02
         DISPLAY g_sfdc02_d[g_master_idx2].sum_qtyr TO s_detail2_02.sum_qtyr_02         
#         CALL aint330_02_b_fill3_1('N')
         #add--2016/11/01 By shiun--(E)
         LET INT_FLAG = TRUE 
#         CANCEL DIALOG
         EXIT DIALOG
 
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
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_02_sel_ware(p_chk2)
   DEFINE p_chk2      LIKE type_t.chr1
   DEFINE l_i         LIKE type_t.num5
   DEFINE l_sql       STRING
   DEFINE l_sql2      STRING
   DEFINE l_sql3      STRING
   DEFINE l_sfdc004   LIKE sfdc_t.sfdc004 #需求料号
   DEFINE l_sfdc005   LIKE sfdc_t.sfdc005 #特征
   DEFINE l_sfdc006   LIKE sfdc_t.sfdc006 #单位
   DEFINE l_sfdc009   LIKE sfdc_t.sfdc009 #参考单位
   DEFINE l_sfdc012   LIKE sfdc_t.sfdc012 #拨入库位
   DEFINE l_sfdc013   LIKE sfdc_t.sfdc013 #拨入储位
   DEFINE l_diff      LIKE sfdc_t.sfdc007 #差异数量
   DEFINE l_diffr     LIKE sfdc_t.sfdc007 #参考单位差异数量
   DEFINE l_imaf053   LIKE imaf_t.imaf053 #库存单位
   DEFINE l_imaf054   LIKE imaf_t.imaf054 #多单位
   DEFINE l_imaf091   LIKE imaf_t.imaf091 #预设库位
   DEFINE l_imaf071   LIKE imaf_t.imaf071
   DEFINE l_imaf081   LIKE imaf_t.imaf081
  # DEFINE l_inag      RECORD LIKE inag_t.* #161124-00048#5  16/12/12 By 08734 mark
   #161124-00048#5  16/12/12 By 08734 add(S)
   DEFINE l_inag RECORD  #庫存明細檔
       inagent LIKE inag_t.inagent, #企业编号
       inagsite LIKE inag_t.inagsite, #营运据点
       inag001 LIKE inag_t.inag001, #料件编号
       inag002 LIKE inag_t.inag002, #产品特征
       inag003 LIKE inag_t.inag003, #库存管理特征
       inag004 LIKE inag_t.inag004, #库位编号
       inag005 LIKE inag_t.inag005, #储位编号
       inag006 LIKE inag_t.inag006, #批号
       inag007 LIKE inag_t.inag007, #库存单位
       inag008 LIKE inag_t.inag008, #账面库存数量
       inag009 LIKE inag_t.inag009, #实际库存数量
       inag010 LIKE inag_t.inag010, #库存可用否
       inag011 LIKE inag_t.inag011, #MRP可用否
       inag012 LIKE inag_t.inag012, #成本库否
       inag013 LIKE inag_t.inag013, #拣货优先序
       inag014 LIKE inag_t.inag014, #最近一次盘点日期
       inag015 LIKE inag_t.inag015, #最后异动日期
       inag016 LIKE inag_t.inag016, #呆滞日期
       inag017 LIKE inag_t.inag017, #第一次入库日期
       inag018 LIKE inag_t.inag018, #No Use
       inag019 LIKE inag_t.inag019, #留置否
       inag020 LIKE inag_t.inag020, #留置原因
       inag021 LIKE inag_t.inag021, #备置数量
       inag022 LIKE inag_t.inag022, #No Use
       inag023 LIKE inag_t.inag023, #Tag二进位码
       inag024 LIKE inag_t.inag024, #参考单位
       inag025 LIKE inag_t.inag025, #参考数量
       inag026 LIKE inag_t.inag026, #最近一次检验日期
       inag027 LIKE inag_t.inag027, #下次检验日期
       inag028 LIKE inag_t.inag028, #留置日期
       inag029 LIKE inag_t.inag029, #留置人员
       inag030 LIKE inag_t.inag030, #留置部门
       inag031 LIKE inag_t.inag031, #留置单号
       inag032 LIKE inag_t.inag032, #基础单位
       inag033 LIKE inag_t.inag033 #基础单位数量
END RECORD
#161124-00048#5  16/12/12 By 08734 add(E)
   #DEFINE l_inai      RECORD LIKE inai_t.*  #161124-00048#5  16/12/12 By 08734 mark
   #161124-00048#5  16/12/12 By 08734 add(S)
   DEFINE l_inai RECORD  #製造批序號庫存明細檔
       inaient LIKE inai_t.inaient, #企业编号
       inaisite LIKE inai_t.inaisite, #营运据点
       inai001 LIKE inai_t.inai001, #料件编号
       inai002 LIKE inai_t.inai002, #产品特征
       inai003 LIKE inai_t.inai003, #库存管理特征
       inai004 LIKE inai_t.inai004, #库位编号
       inai005 LIKE inai_t.inai005, #储位编号
       inai006 LIKE inai_t.inai006, #批号
       inai007 LIKE inai_t.inai007, #制造批号
       inai008 LIKE inai_t.inai008, #制造序号
       inai009 LIKE inai_t.inai009, #库存单位
       inai010 LIKE inai_t.inai010, #账面基础单位库存数量
       inai011 LIKE inai_t.inai011, #实际基础单位库存数量
       inai012 LIKE inai_t.inai012, #制造日期
       inai013 LIKE inai_t.inai013, #Tag二进位码
       inai014 LIKE inai_t.inai014 #基础单位
END RECORD
#161124-00048#5  16/12/12 By 08734 add(E)
   DEFINE l_seq       LIKE type_t.num5
   DEFINE l_seq1      LIKE type_t.num5
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_inag007   LIKE inag_t.inag007  #单位
   DEFINE l_inag008   LIKE inag_t.inag008  #库存数量
   DEFINE l_inag024   LIKE inag_t.inag024  #参考单位
   DEFINE l_inag025   LIKE inag_t.inag025  #参考单位库存数量
   DEFINE l_inag004   LIKE inag_t.inag004  #拨出库位
   DEFINE l_qty       LIKE sfdc_t.sfdc007  #分配数量
   DEFINE l_qtyr      LIKE sfdc_t.sfdc007  #分配参考单位数量
   DEFINE l_rate      LIKE inaj_t.inaj014  #单位换算率
   DEFINE l_rate2     LIKE inaj_t.inaj014  #参考单位换算率
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_min_qty   LIKE sfdc_t.sfdc007  #计算调拨最小量 批量用
   DEFINE l_max_qty   LIKE sfdc_t.sfdc007  #计算调拨最小量 批量用
   DEFINE l_rate3     LIKE inaj_t.inaj014  #计算调拨最小量 批量用
   DEFINE l_isdiff    LIKE type_t.num5      #是否有差异 true/false 计算调拨最小量 批量用
   DEFINE l_qty_t     LIKE inag_t.inag008  #数量 临时变量  #add 150101
   DEFINE l_inae010   LIKE inae_t.inae010  #160512-00004#1 by whitney add
   
   WHENEVER ERROR CONTINUE
   
   SELECT COUNT(*) INTO l_cnt FROM aint330_02_tmp03
   IF l_cnt > 0 THEN
      #已存在庫存資料，是否重新產生？
      IF cl_ask_confirm('asf-00370') THEN
         DELETE FROM aint330_02_tmp03
         DELETE FROM aint330_02_tmp04
      ELSE
         RETURN
      END IF
   END IF
   
   IF cl_null(g_wc_02) THEN
      LET g_wc_02 = " 1=1"
   END IF
   
   ########################################################################
   #信息获取
   ########################################################################
   #LET l_sql3 = " SELECT inae010,inai_t.* FROM inai_t ",  #161124-00048#5  16/12/12 By 08734 mark
   LET l_sql3 = " SELECT inae010,inaient,inaisite,inai001,inai002,inai003,inai004,inai005,inai006,inai007,inai008,inai009,inai010,inai011,inai012,inai013,inai014 FROM inai_t ",  #161124-00048#5  16/12/12 By 08734 add
                "   LEFT JOIN inae_t ON inaeent=inaient AND inae001=inai001 AND inaesite=inaisite AND inae002=inai002 AND inae003=inai007 AND inae004=inai008 ",
                "  WHERE inaient = ",g_enterprise,
                "    AND inaisite= '",g_site,"' ",
                "    AND inai001 = ? ", #料号
                "    AND inai002 = ? ", #特征
                "    AND inai003 = ? ", #庫存管理特徵
                "    AND inai004 = ? ", #庫位編號
                "    AND inai005 = ? ", #儲位編號
                "    AND inai006 = ? ", #批號
                "    AND inai009 = ? ", #庫存單位
                " ORDER BY inae010 "
   PREPARE aint330_02_sel_ware_sel3 FROM l_sql3
   DECLARE aint330_02_sel_ware_curs3 CURSOR FOR aint330_02_sel_ware_sel3

   #                    需求料号 特征    单位    参考单位 拨入库位 拨入储位 库存单位 多单位
   LET l_sql = " SELECT sfdc004,sfdc005,sfdc006,sfdc009,sfdc012,sfdc013,imaf053,imaf054,imaf071,imaf081 ",
               "   FROM aint330_02_tmp02 LEFT JOIN imaf_t ON imafent="||g_enterprise||" AND imafsite='"||g_site||"' AND imaf001=sfdc004  "
   PREPARE aint330_02_sel_ware_sel FROM l_sql
   DECLARE aint330_02_sel_ware_curs CURSOR FOR aint330_02_sel_ware_sel
   FOREACH aint330_02_sel_ware_curs INTO l_sfdc004,l_sfdc005,l_sfdc006,l_sfdc009,l_sfdc012,l_sfdc013,l_imaf053,l_imaf054,l_imaf071,l_imaf081
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:aint330_02_sel_ware_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      IF l_imaf054 = 'N' AND cl_null(l_imaf053) THEN  #库存多单位
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'sub-00476'
         LET g_errparam.extend = l_sfdc004
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      #LET l_sql2= " SELECT * FROM inag_t ",  #161124-00048#5  16/12/12 By 08734 mark
      LET l_sql2= " SELECT inagent,inagsite,inag001,inag002,inag003,inag004,inag005,inag006,inag007,inag008,inag009,inag010,inag011,inag012,inag013,inag014,inag015,inag016,inag017,inag018,inag019,inag020,inag021,inag022,inag023,inag024,inag025,inag026,inag027,inag028,inag029,inag030,inag031,inag032,inag033 FROM inag_t ",  #161124-00048#5  16/12/12 By 08734 add
                  "  WHERE inagent = ",g_enterprise,
                  "    AND inagsite= '",g_site,"' ",
                  "    AND inag001 = '",l_sfdc004,"' ", #料号
#                  "    AND inag002 = '",l_sfdc005,"' ", #特征   #mark--2016/10/21 By shiun
                  "    AND ",g_wc_02 CLIPPED
      #add--2016/10/21 By shiun--(S)
      IF NOT cl_null(l_sfdc005) THEN
         LET l_sql2 = l_sql2," AND inag002 = '",l_sfdc005,"' "
      END IF
      #add--2016/10/21 By shiun--(E)
                  
      #N 只能从存储为库存单位的那笔库存资料中出库
      #Y 只能从存储为单据上指定单位的那笔库存资料中
      IF l_imaf054 = 'N' THEN  #库存多单位
         LET l_sql2 = l_sql2 CLIPPED," AND inag007 = '",l_imaf053,"' " #据点库存单位
      END IF
      PREPARE aint330_02_sel_ware_sel2 FROM l_sql2
      DECLARE aint330_02_sel_ware_curs2 CURSOR FOR aint330_02_sel_ware_sel2
      LET l_seq = 0
      FOREACH aint330_02_sel_ware_curs2 INTO l_inag.* 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:aint330_02_sel_ware_curs2"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
         
         #库存不足的不需要产生
         IF l_inag.inag008 <= 0 THEN
            CONTINUE FOREACH
         END IF
         
         #与拨入库储一致的不需要产生
         IF l_inag.inag004 = l_sfdc012 AND l_inag.inag005 = l_sfdc013 THEN
            CONTINUE FOREACH
         END IF
         
         LET l_seq = l_seq + 1
         INSERT INTO aint330_02_tmp03(sfdc004,sfdc005,sfdc006,sfdc009,sfdc012,sfdc013,
                                      sel    ,seq    ,inag004,inag005,inag006,inag003,
                                      inag007,inag008,inag024,inag025,pack   ,qty    ,qtyr   )
            VALUES(l_sfdc004,l_sfdc005,l_sfdc006,l_sfdc009,l_sfdc012,l_sfdc013,
                   'N'      ,l_seq    ,l_inag.inag004,l_inag.inag005,l_inag.inag006,l_inag.inag003,
                   l_inag.inag007,l_inag.inag008,l_inag.inag024,l_inag.inag025,'',0,0
                  )
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins aint330_02_tmp03'
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
        
         IF l_imaf071='1' OR l_imaf081='1' THEN
            LET l_seq1 = 0
            FOREACH aint330_02_sel_ware_curs3 USING l_inag.inag001,l_inag.inag002,l_inag.inag003,l_inag.inag004,l_inag.inag005,l_inag.inag006,l_inag.inag007
                                               INTO l_inae010,l_inai.*
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "FOREACH:aint330_02_sel_ware_curs3"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  EXIT FOREACH
               END IF
            
               IF l_inai.inai010 <= 0 THEN
                  CONTINUE FOREACH
               END IF
               
               LET l_seq1 = l_seq1 + 1
               INSERT INTO aint330_02_tmp04(sfdc004,sfdc005,sfdc006,sfdc009,sfdc012,sfdc013,
                                            sel    ,seq    ,seq1   ,inai007,inai008,inae010,
                                            inai010,qty    )
                  VALUES(l_sfdc004,l_sfdc005,l_sfdc006,l_sfdc009,l_sfdc012,l_sfdc013,
                         'N'      ,l_seq    ,l_seq1   ,l_inai.inai007,l_inai.inai008,l_inae010,
                         l_inai.inai010,0)
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'ins aint330_02_tmp04'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  EXIT FOREACH
               END IF
            END FOREACH
            CLOSE aint330_02_sel_ware_curs3
            FREE aint330_02_sel_ware_sel3
         END IF
         ##--end inai--
      
      END FOREACH
      CLOSE aint330_02_sel_ware_curs2
      FREE aint330_02_sel_ware_sel2
      ##--end inag--
      
   END FOREACH
   CLOSE aint330_02_sel_ware_curs
   FREE aint330_02_sel_ware_sel
   
   ########################################################################
   #数量预设
   ########################################################################
   
   LET l_sql = " SELECT sfdc004,sfdc005,sfdc006,sfdc009,sfdc012,sfdc013,(sfdc007-inag008),(sfdc010-inag025),imaf091 ",
               "   FROM aint330_02_tmp02 LEFT JOIN imaf_t ON imafent="||g_enterprise||" AND imafsite='"||g_site||"' AND imaf001=sfdc004  "
   PREPARE aint330_02_sel_ware_sel20 FROM l_sql
   DECLARE aint330_02_sel_ware_curs20 CURSOR FOR aint330_02_sel_ware_sel20
   FOREACH aint330_02_sel_ware_curs20 INTO l_sfdc004,l_sfdc005,l_sfdc006,l_sfdc009,l_sfdc012,l_sfdc013,l_diff,l_diffr,l_imaf091
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:aint330_02_sel_ware_curs20"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      IF l_diff < 0 THEN LET l_diff = 0 END IF
      IF l_diffr< 0 THEN LET l_diffr= 0 END IF
      IF l_diff = 0 THEN  #不需要调拨
         CONTINUE FOREACH
      END IF

      CALL aint330_02_inflate_qty('1',l_sfdc004,l_diff) RETURNING l_isdiff,l_diff  #计算满足调拨最小量和批量的数量
      
      #--数量预设，第一轮回，处理主要库存--
      #“從料件主要倉庫撥出”勾選:產生資料時主要倉庫對應資料自動勾選aimm212中的预设库位imaf091
      #“從料件主要倉庫撥出”勾選  & 主要仓库非空
      IF p_chk2 = 'Y' AND NOT cl_null(l_imaf091) THEN
         #inag库存-第一轮
         IF l_sfdc009 IS NULL THEN
            LET l_sql2= " SELECT seq,inag004,inag007,inag008,inag024,inag025 ",
                        "   FROM aint330_02_tmp03 ",
                        "  WHERE sfdc004 = '",l_sfdc004,"' ",
                        "    AND sfdc005 = '",l_sfdc005,"' ",
                        "    AND sfdc006 = '",l_sfdc006,"' ",
                        "    AND sfdc009 IS NULL ",
                        "    AND sfdc012 = '",l_sfdc012,"' ",
                        "    AND sfdc013 = '",l_sfdc013,"' "
         ELSE
            LET l_sql2= " SELECT seq,inag004,inag007,inag008,inag024,inag025 ",
                        "   FROM aint330_02_tmp03 ",
                        "  WHERE sfdc004 = '",l_sfdc004,"' ",
                        "    AND sfdc005 = '",l_sfdc005,"' ",
                        "    AND sfdc006 = '",l_sfdc006,"' ",
                        "    AND sfdc009 = '",l_sfdc009,"' ",
                        "    AND sfdc012 = '",l_sfdc012,"' ",
                        "    AND sfdc013 = '",l_sfdc013,"' "
         END IF
         PREPARE aint330_02_sel_ware_sel21 FROM l_sql2
         DECLARE aint330_02_sel_ware_curs21 CURSOR FOR aint330_02_sel_ware_sel21
         FOREACH aint330_02_sel_ware_curs21
                                             INTO l_seq,l_inag004,l_inag007,l_inag008,l_inag024,l_inag025
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "FOREACH:aint330_02_sel_ware_curs21"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            IF l_imaf091 = l_inag004 THEN  #仓库=主要仓库
               CALL s_aooi250_convert_qty(l_sfdc004,l_inag007,l_sfdc006,l_inag008)
                  RETURNING l_success,l_qty_t
               IF NOT l_success THEN
                  CONTINUE FOREACH
               END IF
               IF l_diff > l_qty_t THEN
                  CALL aint330_02_min_qty(l_sfdc004) RETURNING l_min_qty  #最小可发量
                  IF l_inag008 > l_min_qty THEN
                     CALL aint330_02_max_qty(l_sfdc004,l_inag008) RETURNING l_max_qty  #最大可发量
                     LET l_qty   = l_max_qty
                     CALL s_aooi250_convert_qty(l_sfdc004,l_sfdc006,l_sfdc009,l_max_qty) RETURNING l_success,l_qtyr
                     IF NOT l_success THEN
                        CONTINUE FOREACH
                     END IF
                     #l_diff
                     CALL s_aooi250_convert_qty(l_sfdc004,l_inag007,l_sfdc006,l_qty) RETURNING l_success,l_qty_t
                     IF NOT l_success THEN
                        CONTINUE FOREACH
                     END IF
                     LET l_diff  = l_diff  - l_qty_t
                     #l_diffr
                     IF cl_null(l_sfdc009) OR cl_null(l_inag024) THEN
                        LET l_diffr = l_diffr - l_qtyr
                     ELSE
                        CALL s_aooi250_convert_qty(l_sfdc004,l_inag024,l_sfdc009,l_qtyr) RETURNING l_success,l_qty_t
                        IF NOT l_success THEN
                           CONTINUE FOREACH
                        END IF
                        LET l_diffr = l_diffr - l_qty_t
                     END IF
                     #add 150101 end
                  ELSE
                     CONTINUE FOREACH
                  END IF
               ELSE
                  CALL s_aooi250_convert_qty(l_sfdc004,l_sfdc006,l_inag007,l_diff) RETURNING l_success,l_qty
                  IF NOT l_success THEN
                     CONTINUE FOREACH
                  END IF
                  #l_qtyr
                  IF cl_null(l_sfdc009) OR cl_null(l_inag024) THEN
                     LET l_qtyr  = l_diffr
                  ELSE
                     CALL s_aooi250_convert_qty(l_sfdc004,l_sfdc009,l_inag024,l_diffr) RETURNING l_success,l_qtyr
                     IF NOT l_success THEN
                        CONTINUE FOREACH
                     END IF
                  END IF
                  #add 150101 end
                  LET l_diff  = 0
                  LET l_diffr = 0
               END IF
               
               IF l_sfdc009 IS NULL THEN
                  UPDATE aint330_02_tmp03 SET sel = 'Y',
                                              qty = l_qty ,
                                              qtyr= l_qtyr
                   WHERE sfdc004 = l_sfdc004  #料件编号
                     AND sfdc005 = l_sfdc005  #产品特征
                     AND sfdc006 = l_sfdc006  #单位
                     AND sfdc009 IS NULL  #参考单位
                     AND sfdc012 = l_sfdc012  #拨入库位
                     AND sfdc013 = l_sfdc013  #拨入储位

                     AND seq     = l_seq      #项次
               ELSE
                  UPDATE aint330_02_tmp03 SET sel = 'Y',
                                              qty = l_qty ,
                                              qtyr= l_qtyr
                   WHERE sfdc004 = l_sfdc004  #料件编号
                     AND sfdc005 = l_sfdc005  #产品特征
                     AND sfdc006 = l_sfdc006  #单位
                     AND sfdc009 = l_sfdc009  #参考单位
                     AND sfdc012 = l_sfdc012  #拨入库位
                     AND sfdc013 = l_sfdc013  #拨入储位
                     AND seq     = l_seq      #项次
               END IF
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "UPDATE aint330_02_tmp03"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  EXIT FOREACH
               END IF  
               #处理批序号管理
               CALL aint330_02_upd_temp5(l_sfdc004,l_sfdc005,l_sfdc006,l_sfdc009,l_sfdc012,l_sfdc013,l_seq,l_qty)
                  RETURNING l_success
               IF NOT l_success THEN
                  EXIT FOREACH
               END IF             
            END IF
            IF l_diff = 0 THEN
               EXIT FOREACH
            END IF
         END FOREACH
         CLOSE aint330_02_sel_ware_curs21
         FREE aint330_02_sel_ware_sel21
      END IF
      
      #第一轮结束，已分配完，无需做第二轮分配
      IF l_diff = 0 THEN
         CONTINUE FOREACH
      END IF
      
      #--数量预设，第二轮回，处理其他库存--
      ###inag库存-第二轮 排除sel=Y的
      IF l_sfdc009 IS NULL THEN
         LET l_sql2= " SELECT seq,inag007,inag008,inag024,inag025 ",
                     "   FROM aint330_02_tmp03 ",
                     "  WHERE sfdc004 = '",l_sfdc004,"' ",
                     "    AND sfdc005 = '",l_sfdc005,"' ",
                     "    AND sfdc006 = '",l_sfdc006,"' ",
                     "    AND sfdc009 IS NULL ",
                     "    AND sfdc012 = '",l_sfdc012,"' ",
                     "    AND sfdc013 = '",l_sfdc013,"' ",
                     "    AND sel     = 'N' "
      ELSE
         LET l_sql2= " SELECT seq,inag007,inag008,inag024,inag025 ",
                     "   FROM aint330_02_tmp03 ",
                     "  WHERE sfdc004 = '",l_sfdc004,"' ",
                     "    AND sfdc005 = '",l_sfdc005,"' ",
                     "    AND sfdc006 = '",l_sfdc006,"' ",
                     "    AND sfdc009 = '",l_sfdc009,"' ",
                     "    AND sfdc012 = '",l_sfdc012,"' ",
                     "    AND sfdc013 = '",l_sfdc013,"' ",
                     "    AND sel     = 'N' "
      END IF
      PREPARE aint330_02_sel_ware_sel22 FROM l_sql2
      DECLARE aint330_02_sel_ware_curs22 CURSOR FOR aint330_02_sel_ware_sel22
      FOREACH aint330_02_sel_ware_curs22 
                                          INTO l_seq,l_inag007,l_inag008,l_inag024,l_inag025
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:aint330_02_sel_ware_curs22"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
         CALL s_aooi250_convert_qty(l_sfdc004,l_inag007,l_sfdc006,l_inag008)
            RETURNING l_success,l_qty_t
         IF NOT l_success THEN
            CONTINUE FOREACH
         END IF
         IF l_diff > l_qty_t THEN
            CALL aint330_02_min_qty(l_sfdc004) RETURNING l_min_qty  #最小可发量
            IF l_inag008 > l_min_qty THEN
               CALL aint330_02_max_qty(l_sfdc004,l_inag008) RETURNING l_max_qty  #最大可发量
               LET l_qty   = l_max_qty
               #l_qtyr
               CALL s_aooi250_convert_qty(l_sfdc004,l_sfdc006,l_sfdc009,l_max_qty) RETURNING l_success,l_qtyr
               IF NOT l_success THEN
                  CONTINUE FOREACH
               END IF
               #l_diff
               CALL s_aooi250_convert_qty(l_sfdc004,l_inag007,l_sfdc006,l_qty) RETURNING l_success,l_qty_t
               IF NOT l_success THEN
                  CONTINUE FOREACH
               END IF
               LET l_diff  = l_diff  - l_qty_t
               #l_diffr
               IF cl_null(l_sfdc009) OR cl_null(l_inag024) THEN
                  LET l_diffr = l_diffr - l_qtyr
               ELSE
                  CALL s_aooi250_convert_qty(l_sfdc004,l_inag024,l_sfdc009,l_qtyr) RETURNING l_success,l_qty_t
                  IF NOT l_success THEN
                     CONTINUE FOREACH
                  END IF
                  LET l_diffr = l_diffr - l_qty_t
               END IF
               #add 150101 end
            ELSE
               CONTINUE FOREACH
            END IF
         ELSE
            #l_qty
            CALL s_aooi250_convert_qty(l_sfdc004,l_sfdc006,l_inag007,l_diff) RETURNING l_success,l_qty
            IF NOT l_success THEN
               CONTINUE FOREACH
            END IF
            #l_qtyr
            IF cl_null(l_sfdc009) OR cl_null(l_inag024) THEN
               LET l_qtyr  = l_diffr
            ELSE
               CALL s_aooi250_convert_qty(l_sfdc004,l_sfdc009,l_inag024,l_diffr) RETURNING l_success,l_qtyr
               IF NOT l_success THEN
                  CONTINUE FOREACH
               END IF
            END IF
            #add 150101 end
            LET l_diff  = 0
            LET l_diffr = 0
         END IF
         
         IF l_sfdc009 IS NULL THEN
            UPDATE aint330_02_tmp03 SET sel = 'Y',
                                        qty = l_qty ,
                                        qtyr= l_qtyr
             WHERE sfdc004 = l_sfdc004  #料件编号
               AND sfdc005 = l_sfdc005  #产品特征
               AND sfdc006 = l_sfdc006  #单位
               AND sfdc009 IS NULL  #参考单位
               AND sfdc012 = l_sfdc012  #拨入库位
               AND sfdc013 = l_sfdc013  #拨入储位
               AND seq     = l_seq      #项次
         ELSE
            UPDATE aint330_02_tmp03 SET sel = 'Y',
                                        qty = l_qty ,
                                        qtyr= l_qtyr
             WHERE sfdc004 = l_sfdc004  #料件编号
               AND sfdc005 = l_sfdc005  #产品特征
               AND sfdc006 = l_sfdc006  #单位
               AND sfdc009 = l_sfdc009  #参考单位
               AND sfdc012 = l_sfdc012  #拨入库位
               AND sfdc013 = l_sfdc013  #拨入储位
               AND seq     = l_seq      #项次
         END IF
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "UPDATE aint330_02_tmp03"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF   
         #处理批序号管理
         CALL aint330_02_upd_temp5(l_sfdc004,l_sfdc005,l_sfdc006,l_sfdc009,l_sfdc012,l_sfdc013,l_seq,l_qty)
            RETURNING l_success
         IF NOT l_success THEN
            EXIT FOREACH
         END IF   
         
         IF l_diff = 0 THEN
            EXIT FOREACH
         END IF

      END FOREACH
      CLOSE aint330_02_sel_ware_curs22
      FREE aint330_02_sel_ware_sel22

   END FOREACH
   CLOSE aint330_02_sel_ware_curs20
   FREE aint330_02_sel_ware_sel20
   
   #更新temp2
   CALL aint330_02_upd_temp('2') RETURNING l_success
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_02_upd_temp(p_flag)
   DEFINE p_flag       LIKE type_t.chr1   #2:更新temp2  3:更新temp3 0:全更新
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_sql        STRING
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_temp5      RECORD
                       sfdc004        LIKE sfdc_t.sfdc004,     #需求料号  inai001
                       sfdc005        LIKE sfdc_t.sfdc005,     #特征      inai002
                       sfdc006        LIKE sfdc_t.sfdc006,     #单位
                       sfdc009        LIKE sfdc_t.sfdc009,     #参考单位
                       sfdc012        LIKE sfdc_t.sfdc012,     #拨入库位
                       sfdc013        LIKE sfdc_t.sfdc013,     #拨入储位
                       seq            LIKE type_t.num5,        #项次
                       inag007_03     LIKE inag_t.inag007,     #单位
                       inag008_03     LIKE inag_t.inag025,     #库存数量
                       qty_03         LIKE inag_t.inag008,     #已存拨出总数量
                       inag024_03     LIKE inag_t.inag024,     #参考单位
                       inag025_03     LIKE inag_t.inag025,     #参考单位库存数量
                       qtyr_03        LIKE inag_t.inag025,     #拨出参考数量
                       qty            LIKE inai_t.inai010      #拨出数量
                       END RECORD
   DEFINE l_rate       LIKE inaj_t.inaj013
   DEFINE l_temp3      RECORD
                       sfdc004        LIKE sfdc_t.sfdc004,     #需求料号  inai001
                       sfdc005        LIKE sfdc_t.sfdc005,     #特征      inai002
                       sfdc006        LIKE sfdc_t.sfdc006,     #单位
                       sfdc009        LIKE sfdc_t.sfdc009,     #参考单位
                       sfdc012        LIKE sfdc_t.sfdc012,     #拨入库位
                       sfdc013        LIKE sfdc_t.sfdc013,     #拨入储位
                       inag007        LIKE inag_t.inag007,     #单位
                       inag024        LIKE inag_t.inag024,     #参考单位
                       qty            LIKE inag_t.inag008,     #拨出数量
                       qtyr           LIKE inag_t.inag025      #拨出参考数量
                       END RECORD
   DEFINE l_sum_qty    LIKE inag_t.inag008      #拨出数量
   DEFINE l_sum_qtyr   LIKE inag_t.inag025      #拨出参考数量
   DEFINE l_temp2      RECORD
                       sfdc004        LIKE sfdc_t.sfdc004,     #需求料号  inai001
                       sfdc005        LIKE sfdc_t.sfdc005,     #特征      inai002
                       sfdc006        LIKE sfdc_t.sfdc006,     #单位
                       sfdc009        LIKE sfdc_t.sfdc009,     #参考单位
                       sfdc012        LIKE sfdc_t.sfdc012,     #拨入库位
                       sfdc013        LIKE sfdc_t.sfdc013      #拨入储位
                       END RECORD
   DEFINE l_cnt        LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   #temp3与temp5数量的匹配情况
   #更新temp3
   IF p_flag = '3' OR p_flag = '0' THEN
      SELECT aint330_02_tmp04.sfdc004,aint330_02_tmp04.sfdc005,aint330_02_tmp04.sfdc006,aint330_02_tmp04.sfdc009, #key
             aint330_02_tmp04.sfdc012,aint330_02_tmp04.sfdc013,aint330_02_tmp04.seq    , #key
             aint330_02_tmp03.inag007,aint330_02_tmp03.inag008,aint330_02_tmp03.qty    , #temp3表
             aint330_02_tmp03.inag024,aint330_02_tmp03.inag025,aint330_02_tmp03.qtyr   , #temp3表
             SUM(aint330_02_tmp04.qty) 
        INTO l_temp5.*
        FROM aint330_02_tmp04,aint300_02_tmp03 
       WHERE aint330_02_tmp03.sfdc004 = aint330_02_tmp04.sfdc004   #料件编号
         AND aint330_02_tmp03.sfdc005 = aint330_02_tmp04.sfdc005   #产品特征
         AND aint330_02_tmp03.sfdc006 = aint330_02_tmp04.sfdc006   #单位
         AND aint330_02_tmp03.sfdc009 = aint330_02_tmp04.sfdc009   #参考单位
         AND aint330_02_tmp03.sfdc012 = aint330_02_tmp04.sfdc012   #拨入库位
         AND aint330_02_tmp03.sfdc013 = aint330_02_tmp04.sfdc013   #拨入储位
         AND aint330_02_tmp03.seq     = aint330_02_tmp04.seq       #库存资料页签的项次
         AND aint330_02_tmp04.sel = 'Y' 
         AND aint330_02_tmp04.qty > 0 
       GROUP BY aint330_02_tmp04.sfdc004,aint330_02_tmp04.sfdc005,aint330_02_tmp04.sfdc006,aint330_02_tmp04.sfdc009,   #key
                aint330_02_tmp04.sfdc012,aint330_02_tmp04.sfdc013,aint330_02_tmp04.seq    , #key
                aint330_02_tmp03.inag007,aint330_02_tmp03.inag008,aint330_02_tmp03.qty    , #temp3表
                aint330_02_tmp03.inag024,aint330_02_tmp03.inag025,aint330_02_tmp03.qtyr     #temp3表
      IF SQLCA.sqlcode AND SQLCA.sqlcode!=100 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "sel aint330_02_tmp04:qty"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         LET r_success = FALSE
         RETURN r_success
      END IF
      #temp5有都未选的情况，也有不存在temp5数据的情况
      IF cl_null(l_temp5.qty) THEN LET l_temp5.qty=0 END IF
      #不可大于库存量
      IF l_temp5.qty > l_temp5.inag008_03 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00369'
         LET g_errparam.extend = l_temp5.inag008_03
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         LET r_success = FALSE
         RETURN r_success
      END IF
      IF l_temp5.qty != l_temp5.qty_03 THEN
         #计算参考单位
         IF NOT cl_null(l_temp5.inag024_03) THEN
            CALL s_aooi250_convert_qty(l_temp5.sfdc004,l_temp5.inag007_03,l_temp5.inag024_03,l_temp5.qty) RETURNING l_success,l_temp5.qtyr_03
            IF NOT l_success THEN
               LET r_success = FALSE
               RETURN r_success
            END IF
            IF l_temp5.qtyr_03 > l_temp5.inag025_03 THEN
               LET l_temp5.qtyr_03 = l_temp5.inag025_03
            END IF
         ELSE
            LET l_temp5.qtyr_03 = 0
         END IF
         IF l_temp5.sfdc009 IS NULL THEN
            UPDATE aint330_02_tmp03 SET qty = l_temp5.qty,
                                        qtyr= l_temp5.qtyr_03
             WHERE aint330_02_tmp03.sfdc004 = l_temp5.sfdc004   #料件编号
               AND aint330_02_tmp03.sfdc005 = l_temp5.sfdc005   #产品特征
               AND aint330_02_tmp03.sfdc006 = l_temp5.sfdc006   #单位
               AND aint330_02_tmp03.sfdc009 IS NULL   #参考单位
               AND aint330_02_tmp03.sfdc012 = l_temp5.sfdc012   #拨入库位
               AND aint330_02_tmp03.sfdc013 = l_temp5.sfdc013   #拨入储位
               AND aint330_02_tmp03.seq     = l_temp5.seq       #库存资料页签的项次
         ELSE
            UPDATE aint330_02_tmp03 SET qty = l_temp5.qty,
                                        qtyr= l_temp5.qtyr_03
             WHERE aint330_02_tmp03.sfdc004 = l_temp5.sfdc004   #料件编号
               AND aint330_02_tmp03.sfdc005 = l_temp5.sfdc005   #产品特征
               AND aint330_02_tmp03.sfdc006 = l_temp5.sfdc006   #单位
               AND aint330_02_tmp03.sfdc009 = l_temp5.sfdc009   #参考单位
               AND aint330_02_tmp03.sfdc012 = l_temp5.sfdc012   #拨入库位
               AND aint330_02_tmp03.sfdc013 = l_temp5.sfdc013   #拨入储位
               AND aint330_02_tmp03.seq     = l_temp5.seq       #库存资料页签的项次
         END IF
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3]=0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "upd aint330_02_tmp03:qty"
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
   END IF
   
   
   #temp2与temp3数量的匹配情况
   #更新temp2
   IF p_flag = '2' OR p_flag = '0' THEN
      LET l_sql = " SELECT sfdc004,sfdc005,sfdc006,sfdc009,sfdc012,sfdc013 ",
                  "   FROM aint330_02_tmp02  "
      PREPARE aint330_02_upd_temp_sel2 FROM l_sql
      DECLARE aint330_02_upd_temp_curs2 CURSOR FOR aint330_02_upd_temp_sel2
      FOREACH aint330_02_upd_temp_curs2 INTO l_temp2.*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:aint330_02_upd_temp_curs2"
            LET g_errparam.popup = TRUE
            CALL cl_err()
      
            CLOSE aint330_02_upd_temp_curs2
            FREE aint330_02_upd_temp_sel2
            LET r_success = FALSE
            RETURN r_success
         END IF
         
         CALL aint330_02_upd_temp2(l_temp2.sfdc004,l_temp2.sfdc005,
                                   l_temp2.sfdc006,l_temp2.sfdc009,
                                   l_temp2.sfdc012,l_temp2.sfdc013)
            RETURNING l_success
         IF NOT l_success THEN
            CLOSE aint330_02_upd_temp_curs2
            FREE aint330_02_upd_temp_sel2
            LET r_success = FALSE
            RETURN r_success
         END IF
      
      END FOREACH
      CLOSE aint330_02_upd_temp_curs2
      FREE aint330_02_upd_temp_sel2
   END IF
   
   CALL aint330_02_b_fill3_1('Y')
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_02_upd_temp2(p_sfdc004,p_sfdc005,p_sfdc006,p_sfdc009,p_sfdc012,p_sfdc013)
   DEFINE p_sfdc004    LIKE sfdc_t.sfdc004  #料件编号
   DEFINE p_sfdc005    LIKE sfdc_t.sfdc005  #产品特征
   DEFINE p_sfdc006    LIKE sfdc_t.sfdc006  #单位
   DEFINE p_sfdc009    LIKE sfdc_t.sfdc009  #参考单位
   DEFINE p_sfdc012    LIKE sfdc_t.sfdc012  #拨入库位
   DEFINE p_sfdc013    LIKE sfdc_t.sfdc013  #拨入储位
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_sql        STRING
   DEFINE l_inag007    LIKE inag_t.inag007
   DEFINE l_qty        LIKE sfdc_t.sfdc007      #拨入数量
   DEFINE l_inag024    LIKE inag_t.inag024
   DEFINE l_qtyr       LIKE sfdc_t.sfdc010      #拨入参考数量
   DEFINE l_rate       LIKE inaj_t.inaj014      #单位换算率
   DEFINE l_rate2      LIKE inaj_t.inaj014      #参考单位换算率
   DEFINE l_sum_qty    LIKE sfdc_t.sfdc007      #拟拨入数量合计
   DEFINE l_sum_qtyr   LIKE sfdc_t.sfdc010      #拟拨入参考数量合计
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_qty_t      LIKE sfdc_t.sfdc007   #数量 临时周转用 add 150101

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   IF p_sfdc009 IS NULL THEN
      LET l_sql = " SELECT inag007,qty,inag024,qtyr ",
                  "   FROM aint330_02_tmp03  ",
                  "  WHERE sfdc004 = '",p_sfdc004,"' ", #料件编号
                  "    AND sfdc005 = '",p_sfdc005,"' ", #产品特征
                  "    AND sfdc006 = '",p_sfdc006,"' ", #单位
                  "    AND sfdc009 IS NULL ", #参考单位
                  "    AND sfdc012 = '",p_sfdc012,"' ", #拨入库位
                  "    AND sfdc013 = '",p_sfdc013,"' ", #拨入储位
                  "    AND sel = 'Y' "
   ELSE
      LET l_sql = " SELECT inag007,qty,inag024,qtyr ",
                  "   FROM aint330_02_tmp03  ",
                  "  WHERE sfdc004 = '",p_sfdc004,"' ", #料件编号
                  "    AND sfdc005 = '",p_sfdc005,"' ", #产品特征
                  "    AND sfdc006 = '",p_sfdc006,"' ", #单位
                  "    AND sfdc009 = '",p_sfdc009,"' ", #参考单位
                  "    AND sfdc012 = '",p_sfdc012,"' ", #拨入库位
                  "    AND sfdc013 = '",p_sfdc013,"' ", #拨入储位
                  "    AND sel = 'Y' "
   END IF
   PREPARE aint330_02_upd_temp2_sel FROM l_sql
   DECLARE aint330_02_upd_temp2_curs CURSOR FOR aint330_02_upd_temp2_sel
   LET l_sum_qty = 0
   LET l_sum_qtyr= 0
   FOREACH aint330_02_upd_temp2_curs INTO l_inag007,l_qty,l_inag024,l_qtyr
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:aint330_02_upd_temp2_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CLOSE aint330_02_upd_temp2_curs
         FREE aint330_02_upd_temp2_sel
         EXIT FOREACH
      END IF

      CALL s_aooi250_convert_qty(p_sfdc004,l_inag007,p_sfdc006,l_qty) RETURNING l_success,l_qty_t
      IF NOT l_success THEN
         CLOSE aint330_02_upd_temp2_curs
         FREE aint330_02_upd_temp2_sel
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_sum_qty = l_sum_qty + l_qty_t
      
      IF NOT cl_null(p_sfdc009) AND NOT cl_null(l_inag024) THEN
         CALL s_aooi250_convert_qty(p_sfdc004,l_inag024,p_sfdc009,l_qtyr) RETURNING l_success,l_qty_t
         IF NOT l_success THEN
            CLOSE aint330_02_upd_temp2_curs
            FREE aint330_02_upd_temp2_sel
            LET r_success = FALSE
            RETURN r_success
         END IF
         LET l_sum_qtyr = l_sum_qtyr + l_qty_t
      END IF
   END FOREACH
   CLOSE aint330_02_upd_temp2_curs
   FREE aint330_02_upd_temp2_sel
   
   IF p_sfdc009 IS NULL THEN
      UPDATE aint330_02_tmp02  SET sum_qty = l_sum_qty,
                                   sum_qtyr= l_sum_qtyr
       WHERE sfdc004 = p_sfdc004  #料件编号
         AND sfdc005 = p_sfdc005  #产品特征
         AND sfdc006 = p_sfdc006  #单位
         AND sfdc009 IS NULL  #参考单位
         AND sfdc012 = p_sfdc012  #拨入库位
         AND sfdc013 = p_sfdc013  #拨入储位
   ELSE
      UPDATE aint330_02_tmp02  SET sum_qty = l_sum_qty,
                                   sum_qtyr= l_sum_qtyr
       WHERE sfdc004 = p_sfdc004  #料件编号
         AND sfdc005 = p_sfdc005  #产品特征
         AND sfdc006 = p_sfdc006  #单位
         AND sfdc009 = p_sfdc009  #参考单位
         AND sfdc012 = p_sfdc012  #拨入库位
         AND sfdc013 = p_sfdc013  #拨入储位
   END IF
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'upd aint330_02_tmp02'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_02_upd_temp3(p_ac,p_flag)
DEFINE p_ac         LIKE type_t.num5  #更新哪笔
   DEFINE p_flag       LIKE type_t.chr1  #是否更新关联表
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_qty        LIKE sfdc_t.sfdc007  #待分配数量

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   #mod--2016/10/21 By shiun--(S)
#   IF g_sfdc02_d[g_master_idx2].sfdc009 IS NULL THEN
#      UPDATE aint330_02_tmp03 SET sel = g_inag_d[p_ac].sel,
#                                  qty = g_inag_d[p_ac].qty,
#                                  qtyr= g_inag_d[p_ac].qtyr
#       WHERE sfdc004 = g_sfdc02_d[g_master_idx2].sfdc004  #料件编号
#         AND sfdc005 = g_sfdc02_d[g_master_idx2].sfdc005  #产品特征
#         AND sfdc006 = g_sfdc02_d[g_master_idx2].sfdc006  #单位
#         AND inag024 IS NULL  #参考单位
#         AND sfdc012 = g_sfdc02_d[g_master_idx2].sfdc012  #拨入库位
#         AND sfdc013 = g_sfdc02_d[g_master_idx2].sfdc013  #拨入储位
#         AND seq     = g_inag_d[p_ac].seq               #项次
#   ELSE
#      UPDATE aint330_02_tmp03 SET sel = g_inag_d[p_ac].sel,
#                                  qty = g_inag_d[p_ac].qty,
#                                  qtyr= g_inag_d[p_ac].qtyr
#       WHERE sfdc004 = g_sfdc02_d[g_master_idx2].sfdc004  #料件编号
#         AND sfdc005 = g_sfdc02_d[g_master_idx2].sfdc005  #产品特征
#         AND sfdc006 = g_sfdc02_d[g_master_idx2].sfdc006  #单位
#         AND inag024 = g_sfdc02_d[g_master_idx2].sfdc009  #参考单位
#         AND sfdc012 = g_sfdc02_d[g_master_idx2].sfdc012  #拨入库位
#         AND sfdc013 = g_sfdc02_d[g_master_idx2].sfdc013  #拨入储位
#         AND seq     = g_inag_d[p_ac].seq               #项次
#   END IF
   IF g_inag_d[p_ac].inag024 IS NULL THEN
      UPDATE aint330_02_tmp03 SET sel = g_inag_d[p_ac].sel,
                                  qty = g_inag_d[p_ac].qty,
                                  qtyr= g_inag_d[p_ac].qtyr
       WHERE sfdc004 = g_sfdc02_d[g_master_idx2].sfdc004  #料件编号
         AND sfdc005 = g_sfdc02_d[g_master_idx2].sfdc005  #产品特征
         AND sfdc006 = g_sfdc02_d[g_master_idx2].sfdc006  #单位
         AND inag024 IS NULL  #参考单位
         AND sfdc012 = g_sfdc02_d[g_master_idx2].sfdc012  #拨入库位
         AND sfdc013 = g_sfdc02_d[g_master_idx2].sfdc013  #拨入储位
         AND seq     = g_inag_d[p_ac].seq               #项次
   ELSE
      UPDATE aint330_02_tmp03 SET sel = g_inag_d[p_ac].sel,
                                  qty = g_inag_d[p_ac].qty,
                                  qtyr= g_inag_d[p_ac].qtyr
       WHERE sfdc004 = g_sfdc02_d[g_master_idx2].sfdc004  #料件编号
         AND sfdc005 = g_sfdc02_d[g_master_idx2].sfdc005  #产品特征
         AND sfdc006 = g_sfdc02_d[g_master_idx2].sfdc006  #单位
         AND inag024 = g_inag_d[p_ac].inag024  #参考单位
         AND sfdc012 = g_sfdc02_d[g_master_idx2].sfdc012  #拨入库位
         AND sfdc013 = g_sfdc02_d[g_master_idx2].sfdc013  #拨入储位
         AND seq     = g_inag_d[p_ac].seq               #项次
   END IF
   #mod--2016/10/21 By shiun--(E)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'upd aint330_02_tmp03'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF 
   
   IF p_flag='Y' THEN
      #更新拟调拨料号汇总页签
      CALL aint330_02_upd_temp2(g_sfdc02_d[g_master_idx2].sfdc004,g_sfdc02_d[g_master_idx2].sfdc005,
                                g_sfdc02_d[g_master_idx2].sfdc006,g_sfdc02_d[g_master_idx2].sfdc009,
                                g_sfdc02_d[g_master_idx2].sfdc012,g_sfdc02_d[g_master_idx2].sfdc013)
         RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #有作批序号管理的情况，更新批序号资料aint330_02_temp5 
      IF g_inag_d_t.qty != g_inag_d[p_ac].qty OR g_inag_d_t.sel != g_inag_d[p_ac].sel THEN
         IF g_inag_d[p_ac].sel = 'Y' THEN
            LET l_qty = g_inag_d[p_ac].qty
         ELSE
            LET l_qty = 0
         END IF
         CALL aint330_02_upd_temp5(g_sfdc02_d[g_master_idx2].sfdc004,g_sfdc02_d[g_master_idx2].sfdc005,
                                   g_sfdc02_d[g_master_idx2].sfdc006,g_sfdc02_d[g_master_idx2].sfdc009,
                                   g_sfdc02_d[g_master_idx2].sfdc012,g_sfdc02_d[g_master_idx2].sfdc013,
                                   g_inag_d[p_ac].seq               ,l_qty              )
            RETURNING l_success
         IF NOT l_success THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_02_upd_temp5(p_sfdc004,p_sfdc005,p_sfdc006,p_sfdc009,p_sfdc012,p_sfdc013,p_seq,p_qty)
   DEFINE p_sfdc004    LIKE sfdc_t.sfdc004  #料件编号
   DEFINE p_sfdc005    LIKE sfdc_t.sfdc005  #产品特征
   DEFINE p_sfdc006    LIKE sfdc_t.sfdc006  #单位
   DEFINE p_sfdc009    LIKE sfdc_t.sfdc009  #参考单位
   DEFINE p_sfdc012    LIKE sfdc_t.sfdc012  #拨入库位
   DEFINE p_sfdc013    LIKE sfdc_t.sfdc013  #拨入储位
   DEFINE p_seq        LIKE type_t.num5     #项次
   DEFINE p_qty        LIKE sfdc_t.sfdc007  #待分配数量
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_sql        STRING
   DEFINE l_qty        LIKE sfdc_t.sfdc007  #分配数量
   DEFINE l_seq1       LIKE type_t.num5     #项序
   DEFINE l_inai010    LIKE inai_t.inai010  #库存数量
   DEFINE l_imaf071    LIKE imaf_t.imaf071
   DEFINE l_imaf081    LIKE imaf_t.imaf081

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   SELECT imaf071,imaf081
     INTO l_imaf071,l_imaf081
     FROM imaf_t
    WHERE imafent = g_enterprise
      AND imafsite= g_site
      AND imaf001 = p_sfdc004
   IF l_imaf071 != '1' AND l_imaf081 != '1' THEN
      RETURN r_success
   END IF
   
   #先清
   IF p_sfdc009 IS NULL THEN
      UPDATE aint330_02_tmp04 SET sel = 'N',
                                  qty = 0
       WHERE sfdc004 = p_sfdc004  #料件编号
         AND sfdc005 = p_sfdc005  #产品特征
         AND sfdc006 = p_sfdc006  #单位
         AND sfdc009 IS NULL  #参考单位
         AND sfdc012 = p_sfdc012  #拨入库位
         AND sfdc013 = p_sfdc013  #拨入储位
         AND seq     = p_seq      #项次
   ELSE
      UPDATE aint330_02_tmp04 SET sel = 'N',
                                  qty = 0
       WHERE sfdc004 = p_sfdc004  #料件编号
         AND sfdc005 = p_sfdc005  #产品特征
         AND sfdc006 = p_sfdc006  #单位
         AND sfdc009 = p_sfdc009  #参考单位
         AND sfdc012 = p_sfdc012  #拨入库位
         AND sfdc013 = p_sfdc013  #拨入储位
         AND seq     = p_seq      #项次
   END IF
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'upd aint330_02_tmp04'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #后分配:依据拨出数量及制造日期（seq已按此顺序）从前往后顺序自动勾选
   #无数量，无需分配
   IF p_qty = 0 THEN
      RETURN r_success
   END IF
   
   IF p_sfdc009 IS NULL THEN
      LET l_sql = " SELECT seq1,inai010 ",  #项序，库存数量
                  "   FROM aint330_02_tmp04  ",
                  "  WHERE sfdc004 = '",p_sfdc004,"' ", #料件编号
                  "    AND sfdc005 = '",p_sfdc005,"' ", #产品特征
                  "    AND sfdc006 = '",p_sfdc006,"' ", #单位
                  "    AND sfdc009 IS NULL ", #参考单位
                  "    AND sfdc012 = '",p_sfdc012,"' ", #拨入库位
                  "    AND sfdc013 = '",p_sfdc013,"' ", #拨入储位
                  "    AND seq     = ",p_seq,
                  " ORDER BY seq1  "
   ELSE
      LET l_sql = " SELECT seq1,inai010 ",  #项序，库存数量
                  "   FROM aint330_02_tmp04  ",
                  "  WHERE sfdc004 = '",p_sfdc004,"' ", #料件编号
                  "    AND sfdc005 = '",p_sfdc005,"' ", #产品特征
                  "    AND sfdc006 = '",p_sfdc006,"' ", #单位
                  "    AND sfdc009 = '",p_sfdc009,"' ", #参考单位
                  "    AND sfdc012 = '",p_sfdc012,"' ", #拨入库位
                  "    AND sfdc013 = '",p_sfdc013,"' ", #拨入储位
                  "    AND seq     = ",p_seq,
                  " ORDER BY seq1  "
   END IF
   PREPARE aint330_02_upd_temp5_sel FROM l_sql
   DECLARE aint330_02_upd_temp5_curs CURSOR FOR aint330_02_upd_temp5_sel
   FOREACH aint330_02_upd_temp5_curs INTO l_seq1,l_inai010
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:aint330_02_upd_temp5_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CLOSE aint330_02_upd_temp5_curs
         FREE aint330_02_upd_temp5_sel
         EXIT FOREACH
      END IF
      
      #异动数量
      IF p_qty > l_inai010 THEN
         LET l_qty = l_inai010
      ELSE
         LET l_qty = p_qty
      END IF
      #剩余待分配数量
      LET p_qty = p_qty - l_qty
      
      IF p_sfdc009 IS NULL THEN
         UPDATE aint330_02_tmp04 SET sel = 'Y',
                                     qty = l_qty
          WHERE sfdc004 = p_sfdc004  #料件编号
            AND sfdc005 = p_sfdc005  #产品特征
            AND sfdc006 = p_sfdc006  #单位
            AND sfdc009 IS NULL  #参考单位
            AND sfdc012 = p_sfdc012  #拨入库位
            AND sfdc013 = p_sfdc013  #拨入储位
            AND seq     = p_seq      #项次                             
            AND seq1    = l_seq1     #项序
      ELSE
         UPDATE aint330_02_tmp04 SET sel = 'Y',
                                     qty = l_qty
          WHERE sfdc004 = p_sfdc004  #料件编号
            AND sfdc005 = p_sfdc005  #产品特征
            AND sfdc006 = p_sfdc006  #单位
            AND sfdc009 = p_sfdc009  #参考单位
            AND sfdc012 = p_sfdc012  #拨入库位
            AND sfdc013 = p_sfdc013  #拨入储位
            AND seq     = p_seq      #项次                             
            AND seq1    = l_seq1     #项序
      END IF
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'upd aint330_02_tmp04'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CLOSE aint330_02_upd_temp5_curs
         FREE aint330_02_upd_temp5_sel
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      IF p_qty <= 0 THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CLOSE aint330_02_upd_temp5_curs
   FREE aint330_02_upd_temp5_sel
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_02_b_fill3_1(p_flag)
   DEFINE p_flag       LIKE type_t.chr1   #Y展开 N不展开
   DEFINE l_sql        STRING
   DEFINE l_ac_t       LIKE type_t.num5
   DEFINE l_rate       LIKE inaj_t.inaj014  #单位换算率
   DEFINE l_success    LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   CALL g_sfdc02_d.clear()
   
   LET l_sql = "SELECT UNIQUE sfdc004,imaal003,imaal004,sfdc005, ",
               "       sfdc006,sfdc007,inag008,0, ",
               "       sfdc009,sfdc010,inag025,0, ",
               "       sfdc012,sfdc013,sum_qty,sum_qtyr ",
               "  FROM aint330_02_tmp02 LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=sfdc004 AND imaal002='"||g_dlang||"' ",
               " ORDER BY sfdc004"
   PREPARE aint330_02_b_fill_sel FROM l_sql
   DECLARE aint330_02_b_fill_curs CURSOR FOR aint330_02_b_fill_sel
   LET l_ac_t = l_ac
   LET l_ac = 1
   ERROR "Searching!"
   FOREACH aint330_02_b_fill_curs INTO g_sfdc02_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:aint330_02_b_fill_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   
      #计算差异量
      LET g_sfdc02_d[l_ac].diff  = g_sfdc02_d[l_ac].sfdc007 - g_sfdc02_d[l_ac].inag008     #差异数量
      IF g_sfdc02_d[l_ac].diff < 0 THEN
         LET g_sfdc02_d[l_ac].diff = 0
      END IF
      
      #计算参考单位差异量
      LET g_sfdc02_d[l_ac].diffr = g_sfdc02_d[l_ac].sfdc010 - g_sfdc02_d[l_ac].inag025     #参考单位差异数量
      IF g_sfdc02_d[l_ac].diffr < 0 THEN
         LET g_sfdc02_d[l_ac].diffr = 0
      END IF
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ""
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH
   LET g_rec_b2 = l_ac - 1
   CALL g_sfdc02_d.deleteElement(l_ac)
   LET l_ac = l_ac_t
   CLOSE aint330_02_b_fill_curs
   FREE aint330_02_b_fill_sel
   
   IF cl_null(g_master_idx2) OR g_master_idx2 = 0 THEN
      LET g_master_idx2 = 1
   END IF
   
   IF p_flag = 'Y' THEN
      CALL aint330_02_b_fill3()
   END IF
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_02_b_fill3()
   DEFINE l_ac_t      LIKE type_t.num5
   DEFINE l_sql       STRING

   WHENEVER ERROR CONTINUE
   CALL g_inag_d.clear()

   IF cl_null(g_master_idx2) OR g_master_idx2=0 THEN
      RETURN
   END IF
   
   IF g_sfdc02_d[g_master_idx2].sfdc009 IS NULL THEN
      LET l_sql = "SELECT sel    ,seq    ,inag004,inaa002,inag005,inab003, ",
                  "       inag006,inag003,inag007,inag008,inag024,inag025, ",
                  "       pack   ,qty    ,qtyr   ",
                  "  FROM aint330_02_tmp03  LEFT JOIN inaa_t ON inaaent="||g_enterprise||" AND inaasite='"||g_site||"' AND inaa001=inag004  ",
                  "                         LEFT JOIN inab_t ON inabent="||g_enterprise||" AND inabsite='"||g_site||"' AND inab001=inag004 AND inab002=inag005  ",
                  " WHERE sfdc004 = '",g_sfdc02_d[g_master_idx2].sfdc004,"' ",  #料件编号
                  "   AND sfdc005 = '",g_sfdc02_d[g_master_idx2].sfdc005,"' ",  #产品特征
                  "   AND sfdc006 = '",g_sfdc02_d[g_master_idx2].sfdc006,"' ",  #单位
                  "   AND sfdc009 IS NULL ",  #参考单位
                  #mod--2016/10/21 BY shiun--(S)
#                  "   AND sfdc012 = '",g_sfdc02_d[g_master_idx2].sfdc012,"' ",  #拨入库位
#                  "   AND sfdc013 = '",g_sfdc02_d[g_master_idx2].sfdc013,"' ",  #拨入储位
                  "   AND (sfdc012 = '",g_sfdc02_d[g_master_idx2].sfdc012,"' OR sfdc012 IS NULL) ",  #拨入库位
                  "   AND (sfdc013 = '",g_sfdc02_d[g_master_idx2].sfdc013,"' OR sfdc013 IS NULL) ",  #拨入储位
                  #mod--2016/10/21 BY shiun--(E)
                  " ORDER BY seq "
   ELSE
      LET l_sql = "SELECT sel    ,seq    ,inag004,inaa002,inag005,inab003, ",
                  "       inag006,inag003,inag007,inag008,inag024,inag025, ",
                  "       pack   ,qty    ,qtyr   ",
                  "  FROM aint330_02_tmp03  LEFT JOIN inaa_t ON inaaent="||g_enterprise||" AND inaasite='"||g_site||"' AND inaa001=inag004  ",
                  "                         LEFT JOIN inab_t ON inabent="||g_enterprise||" AND inabsite='"||g_site||"' AND inab001=inag004 AND inab002=inag005  ",
                  " WHERE sfdc004 = '",g_sfdc02_d[g_master_idx2].sfdc004,"' ",  #料件编号
                  "   AND sfdc005 = '",g_sfdc02_d[g_master_idx2].sfdc005,"' ",  #产品特征
                  "   AND sfdc006 = '",g_sfdc02_d[g_master_idx2].sfdc006,"' ",  #单位
                  "   AND sfdc009 = '",g_sfdc02_d[g_master_idx2].sfdc009,"' ",  #参考单位
                  #mod--2016/10/21 BY shiun--(S)
#                  "   AND sfdc012 = '",g_sfdc02_d[g_master_idx2].sfdc012,"' ",  #拨入库位
#                  "   AND sfdc013 = '",g_sfdc02_d[g_master_idx2].sfdc013,"' ",  #拨入储位
                  "   AND (sfdc012 = '",g_sfdc02_d[g_master_idx2].sfdc012,"' OR sfdc012 IS NULL) ",  #拨入库位
                  "   AND (sfdc013 = '",g_sfdc02_d[g_master_idx2].sfdc013,"' OR sfdc013 IS NULL) ",  #拨入储位
                  #mod--2016/10/21 BY shiun--(E)
                  " ORDER BY seq "
   END IF
   PREPARE aint330_02_b_fill3_sel FROM l_sql
   DECLARE aint330_02_b_fill3_curs CURSOR FOR aint330_02_b_fill3_sel
   LET l_ac_t = l_ac
   LET l_ac = 1
   FOREACH aint330_02_b_fill3_curs INTO g_inag_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:aint330_02_b_fill3_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ""
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH
   LET g_rec_b3 = l_ac - 1
   CALL g_inag_d.deleteElement(l_ac)
   LET l_ac = l_ac_t
   CLOSE aint330_02_b_fill3_curs
   FREE aint330_02_b_fill3_sel
   
   IF cl_null(g_master_idx3) OR g_master_idx3 = 0 THEN
      LET g_master_idx3 = 1
   END IF
   IF g_rec_b3 > 0 THEN
      CALL aint330_02_b_fill5()
   END IF

END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_02_b_fill5()
   DEFINE l_ac_t      LIKE type_t.num5
   DEFINE l_sql       STRING
   
   WHENEVER ERROR CONTINUE
   CALL g_inai_d.clear()
   
   IF cl_null(g_master_idx2) OR g_master_idx2=0
   OR cl_null(g_master_idx3) OR g_master_idx3=0 THEN
      RETURN
   END IF
   IF cl_null(g_inag_d[g_master_idx3].seq) THEN
      RETURN
   END IF
   
   IF g_sfdc02_d[g_master_idx2].sfdc009 IS NULL THEN
      LET l_sql = "SELECT sel    ,seq    ,seq1   , ",
                  "       inai007,inai008,inae010,inai010,qty ",
                  "  FROM aint330_02_tmp04",
                  " WHERE sfdc004 = '",g_sfdc02_d[g_master_idx2].sfdc004,"' ",  #料件编号
                  "   AND sfdc005 = '",g_sfdc02_d[g_master_idx2].sfdc005,"' ",  #产品特征
                  "   AND sfdc006 = '",g_sfdc02_d[g_master_idx2].sfdc006,"' ",  #单位
                  "   AND sfdc009 IS NULL ",  #参考单位
                  "   AND sfdc012 = '",g_sfdc02_d[g_master_idx2].sfdc012,"' ",  #拨入库位
                  "   AND sfdc013 = '",g_sfdc02_d[g_master_idx2].sfdc013,"' ",  #拨入储位
                  "   AND seq     =  ",g_inag_d[g_master_idx3].seq,   #库存资料页签的项次
                  " ORDER BY seq,seq1 "
   ELSE
      LET l_sql = "SELECT sel    ,seq    ,seq1   , ",
                  "       inai007,inai008,inae010,inai010,qty ",
                  "  FROM aint330_02_tmp04",
                  " WHERE sfdc004 = '",g_sfdc02_d[g_master_idx2].sfdc004,"' ",  #料件编号
                  "   AND sfdc005 = '",g_sfdc02_d[g_master_idx2].sfdc005,"' ",  #产品特征
                  "   AND sfdc006 = '",g_sfdc02_d[g_master_idx2].sfdc006,"' ",  #单位
                  "   AND sfdc009 = '",g_sfdc02_d[g_master_idx2].sfdc009,"' ",  #参考单位
                  "   AND sfdc012 = '",g_sfdc02_d[g_master_idx2].sfdc012,"' ",  #拨入库位
                  "   AND sfdc013 = '",g_sfdc02_d[g_master_idx2].sfdc013,"' ",  #拨入储位
                  "   AND seq     =  ",g_inag_d[g_master_idx3].seq,   #库存资料页签的项次
                  " ORDER BY seq,seq1 "
   END IF
   PREPARE aint330_02_b_fill5_sel FROM l_sql
   DECLARE aint330_02_b_fill5_curs CURSOR FOR aint330_02_b_fill5_sel
   LET l_ac_t = l_ac
   LET l_ac = 1
   FOREACH aint330_02_b_fill5_curs INTO g_inai_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:aint330_02_b_fill5_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ""
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH

   LET g_rec_b5 = l_ac - 1
   CALL g_inai_d.deleteElement(l_ac)
   LET l_ac = l_ac_t
   CLOSE aint330_02_b_fill5_curs
   FREE aint330_02_b_fill5_sel

   IF cl_null(g_master_idx5) OR g_master_idx5 = 0 THEN
      LET g_master_idx5 = 1
   END IF
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_02_min_qty(p_item)
   DEFINE p_item   LIKE imaf_t.imaf001
   DEFINE r_qty    LIKE inag_t.inag008
   DEFINE l_imaf101 LIKE imaf_t.imaf101  #调拨批量
   DEFINE l_imaf102 LIKE imaf_t.imaf102  #最小调拨数量
   DEFINE l_double LIKE type_t.num10

   LET r_qty = 0
   IF cl_null(p_item) THEN
      RETURN r_qty
   END IF

   SELECT imaf101,imaf102 INTO l_imaf101,l_imaf102 FROM imaf_t
    WHERE imafent = g_enterprise
      AND imafsite = g_site
      AND imaf001 = p_item
   IF cl_null(l_imaf101) THEN LET l_imaf101 = 0 END IF
   IF cl_null(l_imaf102) THEN LET l_imaf102 = 0 END IF

   #先取最小调拨数量
   LET r_qty=l_imaf102
   #考虑调拨批量
   IF l_imaf101!=0 THEN
      LET l_double=(r_qty/l_imaf101)+ 0.999999
      LET r_qty=l_double*l_imaf101
   END IF

   RETURN r_qty
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_02_max_qty(p_item,p_qty)
DEFINE p_item   LIKE imaf_t.imaf001
   DEFINE p_qty    LIKE inag_t.inag008
   DEFINE r_qty    LIKE inag_t.inag008
   DEFINE l_qty    LIKE inag_t.inag008   #既满足调拨批量 又满足最小调拨数量 的最小数量
   DEFINE l_imaf101 LIKE imaf_t.imaf101  #调拨批量
   DEFINE l_double LIKE type_t.num10

   LET r_qty = p_qty
   IF cl_null(p_item) OR cl_null(p_qty) THEN
      RETURN r_qty
   END IF
   IF p_qty = 0 THEN
      RETURN r_qty
   END IF

   CALL aint330_02_min_qty(p_item) RETURNING l_qty  #既满足调拨批量 又满足最小调拨数量 的最小数量
   IF l_qty != 0 AND p_qty < l_qty THEN
      LET r_qty=0
      RETURN r_qty
   END IF

   SELECT imaf101 INTO l_imaf101 FROM imaf_t
    WHERE imafent = g_enterprise
      AND imafsite = g_site
      AND imaf001 = p_item
   IF cl_null(l_imaf101) THEN LET l_imaf101 = 0 END IF

   #考虑调拨批量
   IF l_imaf101!=0 THEN
      LET l_double=p_qty/l_imaf101
      LET r_qty=l_double*l_imaf101
   END IF

   RETURN r_qty
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_02_inflate_qty(p_type,p_item,p_qty)
   DEFINE p_type    LIKE type_t.chr1     #1.计算调拨批量
   DEFINE p_item    LIKE imaf_t.imaf001
   DEFINE p_qty     LIKE inag_t.inag008
   DEFINE r_isdiff  LIKE type_t.num5     #是否有差异 true/false
   DEFINE r_qty     LIKE inag_t.inag008
   DEFINE l_imaf101 LIKE imaf_t.imaf101  #调拨批量
   DEFINE l_imaf102 LIKE imaf_t.imaf102  #最小调拨数量
   DEFINE l_double  LIKE type_t.num10
   
   LET r_qty = p_qty
   LET r_isdiff = FALSE
   IF cl_null(p_item) OR cl_null(p_qty) THEN
      RETURN r_isdiff,r_qty
   END IF
   IF p_qty = 0 THEN
      RETURN r_isdiff,r_qty
   END IF

   CASE p_type
      WHEN '1'  #计算调拨批量
           SELECT imaf101,imaf102 INTO l_imaf101,l_imaf102 FROM imaf_t
            WHERE imafent = g_enterprise
              AND imafsite = g_site
              AND imaf001 = p_item
           IF cl_null(l_imaf101) THEN LET l_imaf101 = 0 END IF
           IF cl_null(l_imaf102) THEN LET l_imaf102 = 0 END IF

           #考虑最小调拨数量
           IF l_imaf102 != 0 AND r_qty < l_imaf102 THEN
              LET r_qty=l_imaf102
           END IF
           #考虑调拨批量
           IF l_imaf101!=0 THEN
              LET l_double=(r_qty/l_imaf101)+ 0.999999
              LET r_qty=l_double*l_imaf101
           END IF
      OTHERWISE
           RETURN r_isdiff,r_qty
   END CASE

   IF p_qty! = r_qty THEN
      LET r_isdiff = TRUE
   END IF
   RETURN r_isdiff,r_qty
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..:
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_02_gen_aint330_indd()
DEFINE r_success   LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5
   #DEFINE l_indc      RECORD LIKE indc_t.*  #161124-00048#5  16/12/12 By 08734 mark
   #161124-00048#5  16/12/12 By 08734 add(S)
   DEFINE l_indc RECORD  #調撥單單頭檔
       indcent LIKE indc_t.indcent, #企业编号
       indcsite LIKE indc_t.indcsite, #营运据点
       indcunit LIKE indc_t.indcunit, #应用组织
       indcdocno LIKE indc_t.indcdocno, #调拨单号
       indcdocdt LIKE indc_t.indcdocdt, #调拨日期
       indc000 LIKE indc_t.indc000, #单据性质
       indc001 LIKE indc_t.indc001, #对应调拨单号
       indc002 LIKE indc_t.indc002, #来源类别
       indc003 LIKE indc_t.indc003, #来源单号
       indc004 LIKE indc_t.indc004, #调拨人员
       indc005 LIKE indc_t.indc005, #拨出营运据点
       indc006 LIKE indc_t.indc006, #拨入营运据点
       indc007 LIKE indc_t.indc007, #在途仓
       indc008 LIKE indc_t.indc008, #备注
       indc021 LIKE indc_t.indc021, #拨出审核人员
       indc022 LIKE indc_t.indc022, #拨出审核日期
       indc023 LIKE indc_t.indc023, #拨入审核人员
       indc024 LIKE indc_t.indc024, #拨入审核日期
       indcstus LIKE indc_t.indcstus, #状态码
       indcownid LIKE indc_t.indcownid, #资料所有者
       indcowndp LIKE indc_t.indcowndp, #资料所有部门
       indccrtid LIKE indc_t.indccrtid, #资料录入者
       indccrtdp LIKE indc_t.indccrtdp, #资料录入部门
       indccrtdt LIKE indc_t.indccrtdt, #资料创建日
       indcmodid LIKE indc_t.indcmodid, #资料更改者
       indcmoddt LIKE indc_t.indcmoddt, #最近更改日
       indccnfid LIKE indc_t.indccnfid, #资料审核者
       indccnfdt LIKE indc_t.indccnfdt, #数据审核日
       indcpstid LIKE indc_t.indcpstid, #资料过账者
       indcpstdt LIKE indc_t.indcpstdt, #资料过账日
       indc101 LIKE indc_t.indc101, #调拨部门
       indc102 LIKE indc_t.indc102, #检验方式
       indc103 LIKE indc_t.indc103, #包装单制作
       indc104 LIKE indc_t.indc104, #Invoice制作
       indc105 LIKE indc_t.indc105, #送货地址
       indc106 LIKE indc_t.indc106, #运输方式
       indc107 LIKE indc_t.indc107, #起运地点
       indc108 LIKE indc_t.indc108, #到达地点
       indc109 LIKE indc_t.indc109, #在途非成本库位
       indc151 LIKE indc_t.indc151, #调拨理由
       indcud001 LIKE indc_t.indcud001, #自定义字段(文本)001
       indcud002 LIKE indc_t.indcud002, #自定义字段(文本)002
       indcud003 LIKE indc_t.indcud003, #自定义字段(文本)003
       indcud004 LIKE indc_t.indcud004, #自定义字段(文本)004
       indcud005 LIKE indc_t.indcud005, #自定义字段(文本)005
       indcud006 LIKE indc_t.indcud006, #自定义字段(文本)006
       indcud007 LIKE indc_t.indcud007, #自定义字段(文本)007
       indcud008 LIKE indc_t.indcud008, #自定义字段(文本)008
       indcud009 LIKE indc_t.indcud009, #自定义字段(文本)009
       indcud010 LIKE indc_t.indcud010, #自定义字段(文本)010
       indcud011 LIKE indc_t.indcud011, #自定义字段(数字)011
       indcud012 LIKE indc_t.indcud012, #自定义字段(数字)012
       indcud013 LIKE indc_t.indcud013, #自定义字段(数字)013
       indcud014 LIKE indc_t.indcud014, #自定义字段(数字)014
       indcud015 LIKE indc_t.indcud015, #自定义字段(数字)015
       indcud016 LIKE indc_t.indcud016, #自定义字段(数字)016
       indcud017 LIKE indc_t.indcud017, #自定义字段(数字)017
       indcud018 LIKE indc_t.indcud018, #自定义字段(数字)018
       indcud019 LIKE indc_t.indcud019, #自定义字段(数字)019
       indcud020 LIKE indc_t.indcud020, #自定义字段(数字)020
       indcud021 LIKE indc_t.indcud021, #自定义字段(日期时间)021
       indcud022 LIKE indc_t.indcud022, #自定义字段(日期时间)022
       indcud023 LIKE indc_t.indcud023, #自定义字段(日期时间)023
       indcud024 LIKE indc_t.indcud024, #自定义字段(日期时间)024
       indcud025 LIKE indc_t.indcud025, #自定义字段(日期时间)025
       indcud026 LIKE indc_t.indcud026, #自定义字段(日期时间)026
       indcud027 LIKE indc_t.indcud027, #自定义字段(日期时间)027
       indcud028 LIKE indc_t.indcud028, #自定义字段(日期时间)028
       indcud029 LIKE indc_t.indcud029, #自定义字段(日期时间)029
       indcud030 LIKE indc_t.indcud030, #自定义字段(日期时间)030
       indc199 LIKE indc_t.indc199, #调拨性质
       indc009 LIKE indc_t.indc009, #单一单位库存单位变更
       indc200 LIKE indc_t.indc200, #拨出仓库
       indc201 LIKE indc_t.indc201, #拨入仓库
       indc010 LIKE indc_t.indc010, #调整单号
       indc202 LIKE indc_t.indc202, #操作类型
       indc025 LIKE indc_t.indc025, #前端单号
       indc026 LIKE indc_t.indc026 #前端类型
END RECORD
#161124-00048#5  16/12/12 By 08734 add(E)
   #DEFINE l_indd      RECORD LIKE indd_t.*  #161124-00048#5  16/12/12 By 08734 mark
   #161124-00048#5  16/12/12 By 08734 add(S)
   DEFINE l_indd RECORD  #調撥單單身明細檔
       inddent LIKE indd_t.inddent, #企業編號
       inddsite LIKE indd_t.inddsite, #營運據點
       inddunit LIKE indd_t.inddunit, #應用組織
       indddocno LIKE indd_t.indddocno, #調撥單號
       inddseq LIKE indd_t.inddseq, #項次
       indd001 LIKE indd_t.indd001, #來源項次
       indd002 LIKE indd_t.indd002, #商品編號
       indd003 LIKE indd_t.indd003, #商品條碼
       indd004 LIKE indd_t.indd004, #產品特徵
       indd005 LIKE indd_t.indd005, #經營方式
       indd006 LIKE indd_t.indd006, #庫存單位
       indd007 LIKE indd_t.indd007, #包裝單位
       indd008 LIKE indd_t.indd008, #件裝數
       indd009 LIKE indd_t.indd009, #預調撥量
       indd020 LIKE indd_t.indd020, #撥出件數
       indd021 LIKE indd_t.indd021, #撥出數量
       indd022 LIKE indd_t.indd022, #撥出庫位
       indd023 LIKE indd_t.indd023, #撥出儲位
       indd024 LIKE indd_t.indd024, #撥出批號
       indd030 LIKE indd_t.indd030, #撥入件數
       indd031 LIKE indd_t.indd031, #撥入數量
       indd032 LIKE indd_t.indd032, #撥入庫位
       indd033 LIKE indd_t.indd033, #撥入儲位
       indd034 LIKE indd_t.indd034, #撥入批號
       indd040 LIKE indd_t.indd040, #結案否
       indd101 LIKE indd_t.indd101, #來源單號
       indd102 LIKE indd_t.indd102, #庫存管理特徵
       indd103 LIKE indd_t.indd103, #撥出申請量
       indd104 LIKE indd_t.indd104, #參考單位
       indd105 LIKE indd_t.indd105, #撥出申請參考數量
       indd106 LIKE indd_t.indd106, #撥出合格參考數量
       indd107 LIKE indd_t.indd107, #撥入申請數量
       indd108 LIKE indd_t.indd108, #撥入申請參考數量
       indd109 LIKE indd_t.indd109, #撥入合格參考數量
       indd110 LIKE indd_t.indd110, #差異量
       indd111 LIKE indd_t.indd111, #差異原因
       indd112 LIKE indd_t.indd112, #差異已調整量
       indd151 LIKE indd_t.indd151, #調撥理由
       indd152 LIKE indd_t.indd152, #備註
       inddud001 LIKE indd_t.inddud001, #自定義欄位(文字)001
       inddud002 LIKE indd_t.inddud002, #自定義欄位(文字)002
       inddud003 LIKE indd_t.inddud003, #自定義欄位(文字)003
       inddud004 LIKE indd_t.inddud004, #自定義欄位(文字)004
       inddud005 LIKE indd_t.inddud005, #自定義欄位(文字)005
       inddud006 LIKE indd_t.inddud006, #自定義欄位(文字)006
       inddud007 LIKE indd_t.inddud007, #自定義欄位(文字)007
       inddud008 LIKE indd_t.inddud008, #自定義欄位(文字)008
       inddud009 LIKE indd_t.inddud009, #自定義欄位(文字)009
       inddud010 LIKE indd_t.inddud010, #自定義欄位(文字)010
       inddud011 LIKE indd_t.inddud011, #自定義欄位(數字)011
       inddud012 LIKE indd_t.inddud012, #自定義欄位(數字)012
       inddud013 LIKE indd_t.inddud013, #自定義欄位(數字)013
       inddud014 LIKE indd_t.inddud014, #自定義欄位(數字)014
       inddud015 LIKE indd_t.inddud015, #自定義欄位(數字)015
       inddud016 LIKE indd_t.inddud016, #自定義欄位(數字)016
       inddud017 LIKE indd_t.inddud017, #自定義欄位(數字)017
       inddud018 LIKE indd_t.inddud018, #自定義欄位(數字)018
       inddud019 LIKE indd_t.inddud019, #自定義欄位(數字)019
       inddud020 LIKE indd_t.inddud020, #自定義欄位(數字)020
       inddud021 LIKE indd_t.inddud021, #自定義欄位(日期時間)021
       inddud022 LIKE indd_t.inddud022, #自定義欄位(日期時間)022
       inddud023 LIKE indd_t.inddud023, #自定義欄位(日期時間)023
       inddud024 LIKE indd_t.inddud024, #自定義欄位(日期時間)024
       inddud025 LIKE indd_t.inddud025, #自定義欄位(日期時間)025
       inddud026 LIKE indd_t.inddud026, #自定義欄位(日期時間)026
       inddud027 LIKE indd_t.inddud027, #自定義欄位(日期時間)027
       inddud028 LIKE indd_t.inddud028, #自定義欄位(日期時間)028
       inddud029 LIKE indd_t.inddud029, #自定義欄位(日期時間)029
       inddud030 LIKE indd_t.inddud030, #自定義欄位(日期時間)030
       indd041 LIKE indd_t.indd041, #撥入單位
       indd042 LIKE indd_t.indd042, #專案編號
       indd043 LIKE indd_t.indd043, #WBS
       indd044 LIKE indd_t.indd044, #活動編號
       indd010 LIKE indd_t.indd010, #多庫儲否
       indd025 LIKE indd_t.indd025, #撥出組織庫存數量
       indd035 LIKE indd_t.indd035, #撥入組織庫存數量
       indd045 LIKE indd_t.indd045, #預估單價
       indd046 LIKE indd_t.indd046, #預估金額
       indd047 LIKE indd_t.indd047, #來源需求單號
       indd048 LIKE indd_t.indd048 #來源需求項次
END RECORD
#161124-00048#5  16/12/12 By 08734 add(E)
   #DEFINE l_inao      RECORD LIKE inao_t.*  #161124-00048#5  16/12/12 By 08734 mark
   #161124-00048#5  16/12/12 By 08734 add(S)
   DEFINE l_inao RECORD  #製造批序號庫存異動明細檔
       inaoent LIKE inao_t.inaoent, #企业编号
       inaosite LIKE inao_t.inaosite, #营运据点
       inaodocno LIKE inao_t.inaodocno, #单号
       inaoseq LIKE inao_t.inaoseq, #项次
       inaoseq1 LIKE inao_t.inaoseq1, #项序
       inaoseq2 LIKE inao_t.inaoseq2, #序号
       inao000 LIKE inao_t.inao000, #数据类型
       inao001 LIKE inao_t.inao001, #料件编号
       inao002 LIKE inao_t.inao002, #产品特征
       inao003 LIKE inao_t.inao003, #库存管理特征
       inao004 LIKE inao_t.inao004, #包装容器编号
       inao005 LIKE inao_t.inao005, #库位
       inao006 LIKE inao_t.inao006, #储位
       inao007 LIKE inao_t.inao007, #批号
       inao008 LIKE inao_t.inao008, #制造批号
       inao009 LIKE inao_t.inao009, #制造序号
       inao010 LIKE inao_t.inao010, #制造日期
       inao011 LIKE inao_t.inao011, #有效日期
       inao012 LIKE inao_t.inao012, #数量
       inao013 LIKE inao_t.inao013, #出入库码
       inao014 LIKE inao_t.inao014, #库存单位
       inao020 LIKE inao_t.inao020, #检验合格量
       inao021 LIKE inao_t.inao021, #已入库/出货/签收量
       inao022 LIKE inao_t.inao022, #已验退/签退量
       inao023 LIKE inao_t.inao023, #已仓退/销退量
       inao024 LIKE inao_t.inao024, #已转QC量
       inao025 LIKE inao_t.inao025 #已退品量
END RECORD
#161124-00048#5  16/12/12 By 08734 add(E)
   DEFINE l_sql       STRING
   DEFINE l_temp      RECORD
                      sfdc004   LIKE sfdc_t.sfdc004,  #料号
                      sfdc005   LIKE sfdc_t.sfdc005,  #特征
                      sfdc006   LIKE sfdc_t.sfdc006,  #单位
                      sfdc009   LIKE sfdc_t.sfdc009,  #参考单位
                      sfdc007   LIKE sfdc_t.sfdc007,  #申请数量
                      sfdc010   LIKE sfdc_t.sfdc010,  #参考单位申请数量
                      sfdc012   LIKE sfdc_t.sfdc012,  #拨入库位
                      sfdc013   LIKE sfdc_t.sfdc013,  #拨入储位
                      seq       LIKE type_t.num5,     #项次
                      inag004   LIKE inag_t.inag004,  #拨出库位
                      inag005   LIKE inag_t.inag005,  #拨出储位
                      inag006   LIKE inag_t.inag006,  #拨出批号
                      inag003   LIKE inag_t.inag003,  #库存管理特征
                      inag007   LIKE inag_t.inag007,  #单位
                      inag024   LIKE inag_t.inag024,  #参考单位
                      inag008   LIKE inag_t.inag008,  #库存数量
                      inag025   LIKE inag_t.inag025,  #参考单位库存数量
                      pack      LIKE imaa_t.imaa001,  #包装容器
                      qty       LIKE inag_t.inag008,  #拨出数量
                      qtyr      LIKE inag_t.inag025   #拨出参考数量
                      END RECORD
   DEFINE l_temp2     RECORD
                      seq1      LIKE type_t.num5,     #项序
                      inai007   LIKE inai_t.inai007,  #制造批号
                      inai008   LIKE inai_t.inai008,  #制造序号
                      inae010   LIKE inae_t.inae010,  #制造日期
                      inai010   LIKE inai_t.inai010,  #库存数量
                      qty       LIKE inai_t.inai010   #拨出数量
                      END RECORD
   DEFINE l_inddseq   LIKE indd_t.inddseq  #项次
   DEFINE l_inaoseq2  LIKE inao_t.inaoseq2 #序号
   DEFINE l_rate      LIKE inaj_t.inaj014  #单位换算率  不能被覆写
   DEFINE l_rate2     LIKE inaj_t.inaj014  #参考单位换算率
   DEFINE l_imaf053   LIKE imaf_t.imaf053  #據點庫存單位
   DEFINE l_imaf054   LIKE imaf_t.imaf054  #庫存多單位
   DEFINE l_imaf031   LIKE imaf_t.imaf031  #有效期月數
   DEFINE l_imaf032   LIKE imaf_t.imaf032  #有效期加天數
   DEFINE l_ooca002   LIKE ooca_t.ooca002  #单位-小数位数 不能被覆写
   DEFINE l_ooca004   LIKE ooca_t.ooca004  #单位-舍入类型 不能被覆写
   DEFINE l_ooca002_2 LIKE ooca_t.ooca002  #参考单位-小数位数
   DEFINE l_ooca004_2 LIKE ooca_t.ooca004  #参考单位-舍入类型
   DEFINE l_qty       LIKE inag_t.inag008  #数量  #add 150108
   DEFINE l_ok_cnt    LIKE type_t.num5     #161230-00001#1 add
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   #SELECT * INTO l_indc.* FROM indc_t  #161124-00048#5  16/12/12 By 08734 mark
   SELECT indcent,indcsite,indcunit,indcdocno,indcdocdt,indc000,indc001,indc002,indc003,indc004,indc005,indc006,indc007,indc008,indc021,indc022,indc023,indc024,indcstus,indcownid,indcowndp,indccrtid,indccrtdp,indccrtdt,indcmodid,indcmoddt,indccnfid,indccnfdt,indcpstid,indcpstdt,indc101,indc102,indc103,indc104,indc105,indc106,indc107,indc108,indc109,indc151,indcud001,indcud002,
       indcud003,indcud004,indcud005,indcud006,indcud007,indcud008,indcud009,indcud010,indcud011,indcud012,indcud013,indcud014,indcud015,indcud016,indcud017,indcud018,indcud019,indcud020,indcud021,indcud022,indcud023,indcud024,indcud025,indcud026,indcud027,indcud028,indcud029,indcud030,indc199,indc009,indc200,indc201,indc010,indc202,indc025,indc026   #161124-00048#5  16/12/12 By 08734 add
      INTO l_indc.* FROM indc_t
    WHERE indcent   = g_enterprise
      AND indcdocno = g_indcdocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'sel indc'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   LET l_ok_cnt = 0   #161230-00001#1 add
   LET l_sql = " SELECT UNIQUE aint330_02_tmp02.sfdc004,aint330_02_tmp02.sfdc005, ",  #料号，特征
               "        aint330_02_tmp02.sfdc006,aint330_02_tmp02.sfdc009, ", #单位，参考单位
               "        aint330_02_tmp02.sfdc007,aint330_02_tmp02.sfdc010, ", #申请数量,参考单位申请数量
               "        aint330_02_tmp02.sfdc012,aint330_02_tmp02.sfdc013, ", #拨入库位，拨入储位
               "        aint330_02_tmp03.seq    ,                          ",  #项次
               "        aint330_02_tmp03.inag004,aint330_02_tmp03.inag005, ",  #拨出库位，拨出储位
               "        aint330_02_tmp03.inag006,aint330_02_tmp03.inag003, ",  #拨出批号，库存管理特征
               "        aint330_02_tmp03.inag007,aint330_02_tmp03.inag024, ",  #单位 参考单位
               "        aint330_02_tmp03.inag008,aint330_02_tmp03.inag025, ",  #库存数量 参考单位库存数量
               "        aint330_02_tmp03.pack   ,aint330_02_tmp03.qty    , ",  #包装容器 拨出数量
               "        aint330_02_tmp03.qtyr   ", #拨出参考数量
               "   FROM aint330_02_tmp02,aint330_02_tmp03  ",
               "  WHERE aint330_02_tmp02.sfdc004 = aint330_02_tmp03.sfdc004 ",  #料件编号
               "    AND aint330_02_tmp02.sfdc005 = aint330_02_tmp03.sfdc005 ",  #产品特征
               "    AND aint330_02_tmp02.sfdc006 = aint330_02_tmp03.sfdc006 ",  #单位
               "    AND aint330_02_tmp02.sfdc009 = aint330_02_tmp03.sfdc009 ",  #参考单位
               "    AND aint330_02_tmp02.sfdc012 = aint330_02_tmp03.sfdc012 ",  #拨入库位
               "    AND aint330_02_tmp02.sfdc013 = aint330_02_tmp03.sfdc013 ",  #拨入储位
               "    AND aint330_02_tmp02.sum_qty > 0 ",  #拟拨入数量合计
               "    AND aint330_02_tmp03.sel = 'Y' ",    #已选择的来源库存
               "    AND aint330_02_tmp03.qty > 0 ",      #有拨出量色
               "    AND aint330_02_tmp02.sfdc009 IS NOT NULL ",
               " UNION ",
               " SELECT UNIQUE aint330_02_tmp02.sfdc004,aint330_02_tmp02.sfdc005, ",  #料号，特征
               "        aint330_02_tmp02.sfdc006,aint330_02_tmp02.sfdc009, ", #单位，参考单位
               "        aint330_02_tmp02.sfdc007,aint330_02_tmp02.sfdc010, ", #申请数量,参考单位申请数量
               "        aint330_02_tmp02.sfdc012,aint330_02_tmp02.sfdc013, ", #拨入库位，拨入储位
               "        aint330_02_tmp03.seq    ,                          ",  #项次
               "        aint330_02_tmp03.inag004,aint330_02_tmp03.inag005, ",  #拨出库位，拨出储位
               "        aint330_02_tmp03.inag006,aint330_02_tmp03.inag003, ",  #拨出批号，库存管理特征
               "        aint330_02_tmp03.inag007,aint330_02_tmp03.inag024, ",  #单位 参考单位
               "        aint330_02_tmp03.inag008,aint330_02_tmp03.inag025, ",  #库存数量 参考单位库存数量
               "        aint330_02_tmp03.pack   ,aint330_02_tmp03.qty    , ",  #包装容器 拨出数量
               "        aint330_02_tmp03.qtyr   ", #拨出参考数量
               "   FROM aint330_02_tmp02,aint330_02_tmp03  ",
               "  WHERE aint330_02_tmp02.sfdc004 = aint330_02_tmp03.sfdc004 ",  #料件编号
               "    AND aint330_02_tmp02.sfdc005 = aint330_02_tmp03.sfdc005 ",  #产品特征
               "    AND aint330_02_tmp02.sfdc006 = aint330_02_tmp03.sfdc006 ",  #单位
               "    AND aint330_02_tmp02.sfdc012 = aint330_02_tmp03.sfdc012 ",  #拨入库位
               "    AND aint330_02_tmp02.sfdc013 = aint330_02_tmp03.sfdc013 ",  #拨入储位
               "    AND aint330_02_tmp02.sum_qty > 0 ",  #拟拨入数量合计
               "    AND aint330_02_tmp03.sel = 'Y' ",    #已选择的来源库存
               "    AND aint330_02_tmp03.qty > 0 ",      #有拨出量色
               "    AND aint330_02_tmp02.sfdc009 IS NULL AND aint330_02_tmp03.sfdc009 IS NULL "
   PREPARE gen_aint330_indd_p FROM l_sql
   DECLARE gen_aint330_indd_c CURSOR FOR gen_aint330_indd_p
   FOREACH gen_aint330_indd_c INTO l_temp.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach gen_aint330_indd_c'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF

      #據點庫存單位 庫存多單位 有效期月數 有效期加天數
      SELECT imaf053,imaf054,imaf031,imaf032
        INTO l_imaf053,l_imaf054,l_imaf031,l_imaf032
        FROM imaf_t
       WHERE imafent = l_indc.indcent
         AND imafsite= l_indc.indcsite
         AND imaf001 = l_temp.sfdc004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'sel imaf'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      IF cl_null(l_imaf054) THEN
         #输入的料件没有使用多单位!  不能为空的意思
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ain-00178'
         LET g_errparam.extend = l_temp.sfdc004
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      IF l_imaf054='N' AND cl_null(l_imaf053) THEN
         #此料件不存在对应的据点库存单位！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'sub-00476'
         LET g_errparam.extend = l_temp.sfdc004
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      INITIALIZE l_indd.* TO NULL
	   LET l_indd.inddent   = l_indc.indcent    #企業編號
	   LET l_indd.inddsite  = l_indc.indcsite   #營運據點
	   LET l_indd.inddunit  = l_indc.indcunit   #應用組織
	   LET l_indd.indddocno = l_indc.indcdocno  #調撥單號
	   SELECT MAX(inddseq) + 1 INTO l_indd.inddseq
	     FROM indd_t
	    WHERE inddent = g_enterprise
	      AND indddocno = l_indc.indcdocno
	   IF cl_null(l_indd.inddseq) THEN LET l_indd.inddseq = 1 END IF
	  #LET l_indd.inddseq   = l_inddseq         #項次
	   LET l_indd.indd001   = ''                #來源項次
	   LET l_indd.indd002   = l_temp.sfdc004    #商品編號
	   LET l_indd.indd003   = ''                #商品條碼
	   LET l_indd.indd004   = l_temp.sfdc005    #產品特徵
	   LET l_indd.indd005   = ''                #經營方式
	   LET l_indd.indd007   = ''                #包裝單位
	   LET l_indd.indd008   = ''                #件裝數
	   LET l_indd.indd009   = ''                #預調撥量
	   LET l_indd.indd020   = ''                #撥出件數
	   LET l_indd.indd022   = l_temp.inag004    #撥出庫位
	   LET l_indd.indd023   = l_temp.inag005    #撥出儲位
	   LET l_indd.indd024   = l_temp.inag006    #撥出批號
	   LET l_indd.indd030   = ''                #撥入件數
	   LET l_indd.indd032   = l_temp.sfdc012    #撥入庫位
	   LET l_indd.indd033   = l_temp.sfdc013    #撥入儲位
	   LET l_indd.indd034   = ''                #撥入批號
	   LET l_indd.indd040   = 'N'               #結案否
	   LET l_indd.indd101   = ''                #來源單號
	   LET l_indd.indd102   = l_temp.inag003    #庫存管理特徵
	   LET l_indd.indd151   = ''                #調撥理由
	   LET l_indd.indd152   = 'aint330_02'         #備註
	   
	   ##-----单位-----
      IF l_imaf054='N' THEN  #库存单一单位
	      LET l_indd.indd006   = l_imaf053    #拨出單位
         LET l_indd.indd041   = l_imaf053    #拨入单位add 150108
      ELSE
	      LET l_indd.indd006   = l_temp.inag007    #拨出單位
         LET l_indd.indd041   = l_temp.sfdc006    #拨入单位add 150108
      END IF
      
      #--拨出
      #单位换算率 库存单位->拨出单位
      CALL s_aooi250_convert_qty(l_indd.indd002,l_temp.inag007,l_indd.indd006,l_temp.qty)
         RETURNING l_success,l_qty
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      #單位取位
      LET l_ooca002 = '' #小數位數
      LET l_ooca004 = '' #捨入類型
      CALL s_aooi250_get_msg(l_indd.indd006) RETURNING l_success,l_ooca002,l_ooca004 #抓取单位档中的小数位数和舍入类型
      IF l_success THEN
         CALL s_num_round(l_ooca004,l_qty,l_ooca002) RETURNING l_qty
      END IF
	   LET l_indd.indd103   = l_qty   #撥出申請量
	   LET l_indd.indd021   = l_qty   #撥出合格數量
      
      #--拨入
      #单位换算率 库存单位->拨入单位
      CALL s_aooi250_convert_qty(l_indd.indd002,l_temp.inag007,l_indd.indd041,l_temp.qty)
         RETURNING l_success,l_qty
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      #單位取位
      LET l_ooca002 = '' #小數位數
      LET l_ooca004 = '' #捨入類型
      CALL s_aooi250_get_msg(l_indd.indd041) RETURNING l_success,l_ooca002,l_ooca004 #抓取单位档中的小数位数和舍入类型
      IF l_success THEN
         CALL s_num_round(l_ooca004,l_qty,l_ooca002) RETURNING l_qty
      END IF
	   LET l_indd.indd107   = l_qty   #撥入申請數量
	   LET l_indd.indd031   = l_qty   #撥入數量
      
	   
	   ##-----参考单位-----
	   LET l_indd.indd104   = l_temp.sfdc009    #參考單位
      IF cl_null(l_indd.indd104) THEN
	      LET l_indd.indd105   = 0   #撥出申請參考數量
	      LET l_indd.indd106   = 0   #撥出合格參考數量
	      LET l_indd.indd108   = 0   #撥入申請參考數量
	      LET l_indd.indd109   = 0   #撥入合格參考數量
	   ELSE
         #参考單位取位
         LET l_ooca002_2 = ''
         LET l_ooca004_2 = ''
         CALL s_aooi250_get_msg(l_indd.indd104) RETURNING l_success,l_ooca002_2,l_ooca004_2 #抓取单位档中的小数位数和舍入类型
         IF NOT l_success THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
	      #--拨出
         #参考单位换算率
	      CALL s_aooi250_convert_qty(l_indd.indd002,l_indd.indd006,l_indd.indd104,l_indd.indd103)
            RETURNING l_success,l_qty
         IF NOT l_success THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
         CALL s_num_round(l_ooca004_2,l_qty,l_ooca002_2) RETURNING l_qty #参考單位取位
	      LET l_indd.indd105   = l_qty #撥出申請參考數量
	      LET l_indd.indd106   = l_qty #撥出合格參考數量
	      
	      #--拨入
         #参考单位换算率
	      CALL s_aooi250_convert_qty(l_indd.indd002,l_indd.indd041,l_indd.indd104,l_indd.indd107)
            RETURNING l_success,l_qty
         IF NOT l_success THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
         CALL s_num_round(l_ooca004_2,l_qty,l_ooca002_2) RETURNING l_qty #参考單位取位
	      LET l_indd.indd108   = l_qty   #撥入申請參考數量
	      LET l_indd.indd109   = l_qty   #撥入合格參考數量
	   END IF
	   LET l_indd.indd110   = 0                 #差異量
	   LET l_indd.indd111   = ''                #差異原因
	   LET l_indd.indd112   = 0                 #差異已調整量

      #INSERT INTO indd_t VALUES(l_indd.*)  #161124-00048#5  16/12/12 By 08734 mark 
      INSERT INTO indd_t(inddent,inddsite,inddunit,indddocno,inddseq,
                         indd001,indd002,indd003,indd004,indd005,
                         indd006,indd007,indd008,indd009,indd020,
                         indd021,indd022,indd023,indd024,indd030,
                         indd031,indd032,indd033,indd034,indd040,
                         indd101,indd102,indd103,indd104,indd105,
                         indd106,indd107,indd108,indd109,indd110,
                         indd111,indd112,indd151,indd152,inddud001,
                         inddud002,inddud003,inddud004,inddud005,inddud006,
                         inddud007,inddud008,inddud009,inddud010,inddud011,
                         inddud012,inddud013,inddud014,inddud015,inddud016,
                         inddud017,inddud018,inddud019,inddud020,inddud021,
                         inddud022,inddud023,inddud024,inddud025,inddud026,
                         inddud027,inddud028,inddud029,inddud030,indd041,
                         indd042,indd043,indd044,indd010,indd025,indd035,
                         indd045,indd046,indd047,indd048)
         VALUES(l_indd.inddent,l_indd.inddsite,l_indd.inddunit,l_indd.indddocno,l_indd.inddseq,
                l_indd.indd001,l_indd.indd002,l_indd.indd003,l_indd.indd004,l_indd.indd005,
                l_indd.indd006,l_indd.indd007,l_indd.indd008,l_indd.indd009,l_indd.indd020,
                l_indd.indd021,l_indd.indd022,l_indd.indd023,l_indd.indd024,l_indd.indd030,
                l_indd.indd031,l_indd.indd032,l_indd.indd033,l_indd.indd034,l_indd.indd040,
                l_indd.indd101,l_indd.indd102,l_indd.indd103,l_indd.indd104,l_indd.indd105,  #161209-00014#1------dujuan----mod-----indd102  改为 l_indd.indd102
                l_indd.indd106,l_indd.indd107,l_indd.indd108,l_indd.indd109,l_indd.indd110,
                l_indd.indd111,l_indd.indd112,l_indd.indd151,l_indd.indd152,l_indd.inddud001,
                l_indd.inddud002,l_indd.inddud003,l_indd.inddud004,l_indd.inddud005,l_indd.inddud006,
                l_indd.inddud007,l_indd.inddud008,l_indd.inddud009,l_indd.inddud010,l_indd.inddud011,
                l_indd.inddud012,l_indd.inddud013,l_indd.inddud014,l_indd.inddud015,l_indd.inddud016,
                l_indd.inddud017,l_indd.inddud018,l_indd.inddud019,l_indd.inddud020,l_indd.inddud021,
                l_indd.inddud022,l_indd.inddud023,l_indd.inddud024,l_indd.inddud025,l_indd.inddud026,
                l_indd.inddud027,l_indd.inddud028,l_indd.inddud029,l_indd.inddud030,l_indd.indd041,
                l_indd.indd042,l_indd.indd043,l_indd.indd044,l_indd.indd010,l_indd.indd025,l_indd.indd035,
                l_indd.indd045,l_indd.indd046,l_indd.indd047,l_indd.indd048)  #161124-00048#5  16/12/12 By 08734 add
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
         CALL s_transaction_end('N','0')
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'sub-00034'
         LET g_errparam.extend = 'ins indd'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success             
      END IF
      
      #批序号处理
      LET l_inaoseq2 = 0
      IF l_temp.sfdc009 IS NULL THEN     
         LET l_sql = " SELECT aint330_02_tmp04.seq1   , ", #项序
                     "        aint330_02_tmp04.inai007,aint330_02_tmp04.inai008, ", #制造序号 制造批号
                     "        aint330_02_tmp04.inae010,aint330_02_tmp04.inai010, ", #制造日期 库存数量
                     "        aint330_02_tmp04.qty ",  #拨出数量
                     "  FROM aint330_02_tmp04",
                     " WHERE sfdc004 = '",l_temp.sfdc004,"' ",  #料件编号
                     "   AND sfdc005 = '",l_temp.sfdc005,"' ",  #产品特征
                     "   AND sfdc006 = '",l_temp.sfdc006,"' ",  #单位
                     "   AND sfdc009 IS NULL ",  #参考单位
                     "   AND sfdc012 = '",l_temp.sfdc012,"' ",  #拨入库位
                     "   AND sfdc013 = '",l_temp.sfdc013,"' ",  #拨入储位
                     "   AND seq     = ",l_temp.seq,  #库存资料页签的项次
                     "   AND aint330_02_tmp04.sel = 'Y' ",
                     "   AND aint330_02_tmp04.qty > 0 ",
                     " ORDER BY seq,seq1 "
      ELSE
         LET l_sql = " SELECT aint330_02_tmp04.seq1   , ", #项序
                     "        aint330_02_tmp04.inai007,aint330_02_tmp04.inai008, ", #制造序号 制造批号
                     "        aint330_02_tmp04.inae010,aint330_02_tmp04.inai010, ", #制造日期 库存数量  #160512-00004#1 by whitney modify inai012->inae010
                     "        aint330_02_tmp04.qty ",  #拨出数量
                     "  FROM aint330_02_tmp04",
                     " WHERE sfdc004 = '",l_temp.sfdc004,"' ",  #料件编号
                     "   AND sfdc005 = '",l_temp.sfdc005,"' ",  #产品特征
                     "   AND sfdc006 = '",l_temp.sfdc006,"' ",  #单位
                     "   AND sfdc009 = '",l_temp.sfdc009,"' ",  #参考单位
                     "   AND sfdc012 = '",l_temp.sfdc012,"' ",  #拨入库位
                     "   AND sfdc013 = '",l_temp.sfdc013,"' ",  #拨入储位
                     "   AND seq     = ",l_temp.seq,  #库存资料页签的项次
                     "   AND aint330_02_tmp04.sel = 'Y' ",
                     "   AND aint330_02_tmp04.qty > 0 ",
                     " ORDER BY seq,seq1 "
      END IF
      PREPARE gen_aint330_indd_p2 FROM l_sql
      DECLARE gen_aint330_indd_c2 CURSOR FOR gen_aint330_indd_p2
      FOREACH gen_aint330_indd_c2
         INTO l_temp2.*
         IF SQLCA.sqlcode THEN
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'foreach gen_aint330_indd_c2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH
         END IF
         
         INITIALIZE l_inao.* TO NULL
         LET l_inao.inaoent  = l_indd.inddent   #企業編號
         LET l_inao.inaosite = l_indd.inddsite  #營運據點
         LET l_inao.inaodocno= l_indd.indddocno #單號
         LET l_inao.inaoseq  = l_indd.inddseq   #項次
         LET l_inao.inaoseq1 = 0                #項序
         LET l_inaoseq2 = l_inaoseq2 + 1
         LET l_inao.inaoseq2 = l_inaoseq2       #序號
         LET l_inao.inao000  = '1'              #資料類型:申请 还是应该实际呢？ aint330此功能尚未实现
         LET l_inao.inao001  = l_indd.indd002   #料件編號
         LET l_inao.inao002  = l_indd.indd004   #產品特徵
         LET l_inao.inao003  = l_indd.indd102   #庫存管理特徵
         LET l_inao.inao004  = l_temp.pack      #包裝容器編號
         LET l_inao.inao005  = l_indd.indd022   #庫位
         LET l_inao.inao006  = l_indd.indd023   #儲位
         LET l_inao.inao007  = l_indd.indd024   #批號
         LET l_inao.inao008  = l_temp2.inai007  #製造批號
         LET l_inao.inao009  = l_temp2.inai008  #製造序號
         LET l_inao.inao010  = l_temp2.inae010  #製造日期  #160512-00004#1 by whitney modify inai012->inae010
         #製造日期後自動推算有效日期，推算公式=製造日期+料件設定的有效期限
         CALL s_date_get_date(l_inao.inao010,l_imaf031,l_imaf032)
            RETURNING l_inao.inao011
         CALL s_aooi250_convert_qty(l_indd.indd002,l_temp.inag007,l_indd.indd006,l_temp2.qty)
            RETURNING l_success,l_inao.inao012
         IF NOT l_success THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
         #單位取位
         CALL s_num_round(l_ooca004,l_inao.inao012,l_ooca002) RETURNING l_inao.inao012 
      
         LET l_inao.inao013  = -1               #出入庫碼

         #INSERT INTO inao_t VALUES(l_inao.*)  #161124-00048#5  16/12/12 By 08734 mark
         INSERT INTO inao_t(inaoent,inaosite,inaodocno,inaoseq,inaoseq1,inaoseq2,inao000,inao001,inao002,inao003,inao004,inao005,inao006,inao007,inao008,inao009,inao010,inao011,inao012,inao013,inao014,inao020,inao021,inao022,inao023,inao024,inao025)  #161124-00048#5  16/12/12 By 08734 add
            VALUES(l_inao.inaoent,l_inao.inaosite,l_inao.inaodocno,l_inao.inaoseq,l_inao.inaoseq1,l_inao.inaoseq2,l_inao.inao000,l_inao.inao001,l_inao.inao002,l_inao.inao003,l_inao.inao004,l_inao.inao005,l_inao.inao006,l_inao.inao007,l_inao.inao008,l_inao.inao009,l_inao.inao010,l_inao.inao011,l_inao.inao012,l_inao.inao013,l_inao.inao014,l_inao.inao020,l_inao.inao021,l_inao.inao022,l_inao.inao023,l_inao.inao024,l_inao.inao025)
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'sub-00034'
            LET g_errparam.extend = 'ins inao'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF						

      END FOREACH
      LET l_ok_cnt = l_ok_cnt + 1 #161230-00001#1 add  
   END FOREACH
   CLOSE gen_aint330_indd_c
   FREE gen_aint330_indd_p
  #161230-00001#1-s-add 
   IF l_ok_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axc-00530'  #無資料產生！
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success      
   END IF
  #161230-00001#1-e-add
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_02_get_inag008(p_sfdc004,p_sfdc005,p_sfdc012,p_sfdc013,p_sfdc006)
DEFINE p_sfdc004    LIKE sfdc_t.sfdc004  #料件編號
   DEFINE p_sfdc005    LIKE sfdc_t.sfdc005  #產品特徵
   DEFINE p_sfdc012    LIKE sfdc_t.sfdc012  #庫位編號
   DEFINE p_sfdc013    LIKE sfdc_t.sfdc013  #儲位編號
   DEFINE p_sfdc006    LIKE sfdc_t.sfdc006  #庫存單位
   DEFINE r_inag008    LIKE inag_t.inag008  #库存量
   DEFINE l_sql        STRING
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_qty        LIKE inag_t.inag008
   DEFINE l_inag006    LIKE inag_t.inag006
   DEFINE l_inag003    LIKE inag_t.inag003
   
   DEFINE l_inag004    LIKE inag_t.inag004
   DEFINE l_inag005    LIKE inag_t.inag005
   DEFINE l_inag007    LIKE inag_t.inag007
   DEFINE l_imaf053    LIKE imaf_t.imaf053

   WHENEVER ERROR CONTINUE
   
   LET r_inag008 = 0
   #mod--2016/10/05 By shiun--(S)
   LET l_sql = "SELECT UNIQUE inag006,inag003  ", #批号，库存管理特征
               "  FROM inag_t ",
               " WHERE inagent =",g_enterprise,
               "   AND inagsite= '",g_site,"'",
               "   AND inag001 = '",p_sfdc004,"' ",  #料件編號
               "   AND inag002 = '",p_sfdc005,"' ",  #產品特徵
               "   AND inag004 = '",p_sfdc012,"' ",  #庫位編號
               "   AND inag005 = '",p_sfdc013,"' ",  #儲位編號
               "   AND inag007 = '",p_sfdc006,"' "   #庫存單位
#   LET l_sql = "SELECT UNIQUE inag006,inag003,inag004,inag005,inag007  ", #批号，库存管理特征,庫位編號,儲位編號,庫存單位
#               "  FROM inag_t ",
#               " WHERE inagent =",g_enterprise,
#               "   AND inagsite= '",g_site,"'",
#               "   AND inag001 = '",p_sfdc004,"' "  #料件編號
#   IF cl_null(p_sfdc005) THEN
#      LET l_sql = l_sql," AND inag002 = ' ' "        #產品特徵
#   END IF    
   #mod--2016/10/05 By shiun--(E)
   PREPARE aint330_02_get_inag008_sel FROM l_sql
   DECLARE aint330_02_get_inag008_curs CURSOR FOR aint330_02_get_inag008_sel
   #add--2016/10/05 By shiun--(S)
   SELECT imaf053 INTO l_imaf053 
     FROM imaf_t 
    WHERE imafent = g_enterprise 
      AND imafsite = g_site 
      AND imaf001 = p_sfdc004
   #add--2016/10/05 By shiun--(E)
   FOREACH aint330_02_get_inag008_curs INTO l_inag006,l_inag003#,l_inag004,l_inag005,l_inag007   #mod--2016/10/05 By shiun   新增l_inag004,l_inag005,l_inag007
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:asfp370_01_get_inag008_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      #mod--2016/10/05 By shiun--(S)
      CALL s_inventory_get_inag008_3(g_site,p_sfdc004,p_sfdc005,p_sfdc012,p_sfdc013,l_inag006,l_inag003,p_sfdc006)
#      CALL s_inventory_get_inag008_3(g_site,p_sfdc004,p_sfdc005,l_inag004,l_inag005,l_inag006,l_inag003,l_inag007)
         RETURNING l_success,l_qty
      #mod--2016/10/05 By shiun--(E)
      IF NOT l_success THEN
         EXIT FOREACH
      END IF
      #add--2016/10/05 By shiun--(S)
#      IF l_imaf053 <> l_inag007 AND (NOT cl_null(l_imaf053)) AND (NOT cl_null(l_inag007)) THEN
#         CALL s_aooi250_convert_qty(p_sfdc004,l_inag007,l_imaf053,l_qty)
#             RETURNING l_success,l_qty
#      END IF
      #add--2016/10/05 By shiun--(E)       
      LET r_inag008 = r_inag008 + l_qty
   END FOREACH
   CLOSE aint330_02_get_inag008_curs
   FREE aint330_02_get_inag008_sel
   
   RETURN r_inag008
   
END FUNCTION

 
{</section>}
 
