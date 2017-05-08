#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq512.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0020(2016-01-29 11:31:49), PR版次:0020(2017-03-10 17:33:35)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000109
#+ Filename...: axcq512
#+ Description: 銷售成本查詢作業
#+ Creator....: 01258(2014-09-05 00:00:00)
#+ Modifier...: 07024 -SD/PR- 02295
 
{</section>}
 
{<section id="axcq512.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#160113-00011#1   2016/01/13  By dorislai  整單操作action 串出各作業時，需串到下那筆資料，查不到資料也需顯示無資料
#160318-00025#9   2016/04/21  By 07675     將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160419-00042#1   2016/04/29  By xianghui  订单单号抓取时关联字段调整
#160523-00041#4	2016/06/08  By 02097     axcq512 一筆出貨分次立AR單時, 會重覆取值顯示,造成錯誤，更改只取MAX()資料。
#160705-00007#2   2016/07/05  By fengmy    作废单据不显示，否则求和行错误
#160802-00020#4   2016/08/04  By dorislai  增加帳套權限管控
#160802-00020#10  2016/08/11  By dorislai   增加法人權限管控
#160922-00048#1   2016/09/26  By charles4m 統一將 xrca038 在單身迴圈抓第一筆
#161019-00017#5   2016/10/21 By lixiang  调整组织栏位的开窗
#161207-00016#1   2016/12/08  By 00768     需考虑一张出货单分多次立账的时候，关联出货账款重复的情况
#                                          处理方式：将主sql中的立账部分分离出来到明细中取第一笔，类160922-00048的处理方式
#170309-00040#1   2017/03/10  By 02295     抓取应收数据时sql错误,且不需排除'12','17','19'这3种类型
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_xcck_m        RECORD
       xcckcomp LIKE xcck_t.xcckcomp, 
   xcckcomp_desc LIKE type_t.chr80, 
   xcck004 LIKE xcck_t.xcck004, 
   xcck005 LIKE xcck_t.xcck005, 
   xcck001 LIKE xcck_t.xcck001, 
   xcck001_desc LIKE type_t.chr80, 
   xcckld LIKE xcck_t.xcckld, 
   xcckld_desc LIKE type_t.chr80, 
   b_xcck004 LIKE type_t.num5, 
   b_xcck005 LIKE type_t.num5, 
   xcck003 LIKE xcck_t.xcck003, 
   xcck003_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xcck_d        RECORD
       xccksite LIKE xcck_t.xccksite, 
   xccksite_desc LIKE type_t.chr500, 
   xcck002 LIKE xcck_t.xcck002, 
   xcck002_desc LIKE type_t.chr500, 
   xcck006 LIKE xcck_t.xcck006, 
   xcck007 LIKE xcck_t.xcck007, 
   xcck008 LIKE xcck_t.xcck008, 
   xcck009 LIKE xcck_t.xcck009, 
   xcck013 LIKE xcck_t.xcck013, 
   xcck010 LIKE xcck_t.xcck010, 
   xcck010_desc LIKE type_t.chr500, 
   xcck010_desc_1 LIKE type_t.chr500, 
   xrca004 LIKE type_t.chr500, 
   xrca004_desc LIKE type_t.chr500, 
   xmdl003 LIKE type_t.chr500, 
   xrca015 LIKE type_t.chr500, 
   xrca015_desc LIKE type_t.chr500, 
   xrca066 LIKE type_t.chr20, 
   xrca014 LIKE type_t.chr500, 
   imag011 LIKE type_t.chr10, 
   imag011_desc LIKE type_t.chr500, 
   xrca038 LIKE type_t.chr20, 
   xmdl007 LIKE type_t.chr500, 
   xrca058_desc LIKE type_t.chr500, 
   xmdk022 LIKE type_t.chr10, 
   xmdk024_desc LIKE type_t.chr500, 
   imaa009 LIKE type_t.chr500, 
   xrcb024_desc LIKE type_t.chr500, 
   l_xrcb_pmaa007 LIKE type_t.chr500, 
   xmdk009 LIKE type_t.chr500, 
   xmdk009_desc LIKE type_t.chr500, 
   l_xmdk_pmaa007 LIKE type_t.chr500, 
   xmdl050_desc LIKE type_t.chr500, 
   xmdk004 LIKE type_t.chr500, 
   xmdk004_desc LIKE type_t.chr500, 
   xcck011 LIKE xcck_t.xcck011, 
   xcck015 LIKE xcck_t.xcck015, 
   xcck015_desc LIKE type_t.chr500, 
   xcck017 LIKE xcck_t.xcck017, 
   xcck044 LIKE xcck_t.xcck044, 
   xcck044_desc LIKE type_t.chr500, 
   xcck201 LIKE xcck_t.xcck201, 
   xcck282a LIKE xcck_t.xcck282a, 
   xcck282b LIKE xcck_t.xcck282b, 
   xcck282c LIKE xcck_t.xcck282c, 
   xcck282d LIKE xcck_t.xcck282d, 
   xcck282e LIKE xcck_t.xcck282e, 
   xcck282f LIKE xcck_t.xcck282f, 
   xcck282g LIKE xcck_t.xcck282g, 
   xcck282h LIKE xcck_t.xcck282h, 
   xcck282 LIKE xcck_t.xcck282, 
   xcck202a LIKE xcck_t.xcck202a, 
   xcck202b LIKE xcck_t.xcck202b, 
   xcck202c LIKE xcck_t.xcck202c, 
   xcck202d LIKE xcck_t.xcck202d, 
   xcck202e LIKE xcck_t.xcck202e, 
   xcck202f LIKE xcck_t.xcck202f, 
   xcck202g LIKE xcck_t.xcck202g, 
   xcck202h LIKE xcck_t.xcck202h, 
   xcck202 LIKE xcck_t.xcck202
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_para_data           LIKE type_t.chr80     #采用成本域否  #fengmy150123
DEFINE g_para_data1          LIKE type_t.chr80     #采用特性否    #fengmy150123
DEFINE g_sql_tmp             STRING                #临时表所用的sql #dujuan150324
#dujuan150324-----str
 TYPE type_g_glfb_e RECORD
       v          STRING
       END RECORD
DEFINE g_param                     type_g_glfb_e  
#dujuan150324-----end
#150805-00001#10add
DEFINE g_yy1 LIKE type_t.num5
DEFINE g_mm1 LIKE type_t.num5
DEFINE g_yy2 LIKE type_t.num5
DEFINE g_mm2 LIKE type_t.num5
#150805-00001#10add
DEFINE g_wc_cs_ld            STRING                #160802-00020#4-add
DEFINE g_wc_cs_comp          STRING                #160802-00020#10-add
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_xcck_m          type_g_xcck_m
DEFINE g_xcck_m_t        type_g_xcck_m
DEFINE g_xcck_m_o        type_g_xcck_m
DEFINE g_xcck_m_mask_o   type_g_xcck_m #轉換遮罩前資料
DEFINE g_xcck_m_mask_n   type_g_xcck_m #轉換遮罩後資料
 
   DEFINE g_xcck004_t LIKE xcck_t.xcck004
DEFINE g_xcck005_t LIKE xcck_t.xcck005
DEFINE g_xcck001_t LIKE xcck_t.xcck001
DEFINE g_xcckld_t LIKE xcck_t.xcckld
DEFINE g_xcck003_t LIKE xcck_t.xcck003
 
 
DEFINE g_xcck_d          DYNAMIC ARRAY OF type_g_xcck_d
DEFINE g_xcck_d_t        type_g_xcck_d
DEFINE g_xcck_d_o        type_g_xcck_d
DEFINE g_xcck_d_mask_o   DYNAMIC ARRAY OF type_g_xcck_d #轉換遮罩前資料
DEFINE g_xcck_d_mask_n   DYNAMIC ARRAY OF type_g_xcck_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_xcckld LIKE xcck_t.xcckld,
      b_xcck001 LIKE xcck_t.xcck001,
      b_xcck003 LIKE xcck_t.xcck003,
      b_xcck004 LIKE xcck_t.xcck004,
      b_xcck005 LIKE xcck_t.xcck005
       #,rank           LIKE type_t.num10
      END RECORD 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING 
 
 
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
 
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5        
DEFINE g_rec_b               LIKE type_t.num10           
DEFINE l_ac                  LIKE type_t.num10    
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
 
DEFINE g_pagestart           LIKE type_t.num10           
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
 
DEFINE g_detail_cnt          LIKE type_t.num10             #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10             #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10             #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10             #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10             #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10             #Browser目前所在筆數(暫存用)
DEFINE g_current_page        LIKE type_t.num10             #目前所在頁數
DEFINE g_order               STRING                        #查詢排序欄位
DEFINE g_state               STRING                        
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page                    
DEFINE g_current_row         LIKE type_t.num10             #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_add_browse          STRING                        #新增填充用WC
DEFINE g_loc                 LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_master_insert       BOOLEAN                       #確認單頭資料是否寫入(僅用於三階)
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axcq512.main" >}
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
   CALL cl_ap_init("axc","")
 
   #add-point:作業初始化 name="main.init"
   #160802-00020#4-add-(S)
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   #160802-00020#4-add-(E)
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  #160802-00020#10-add
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT xcckcomp,'',xcck004,xcck005,xcck001,'',xcckld,'','','',xcck003,''", 
                      " FROM xcck_t",
                      " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=? AND xcck004=? AND  
                          xcck005=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq512_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xcckcomp,t0.xcck004,t0.xcck005,t0.xcck001,t0.xcckld,t0.xcck003,t1.ooefl003 , 
       t2.ooail003 ,t3.glaal002 ,t4.xcatl003",
               " FROM xcck_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.xcckcomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t2 ON t2.ooailent="||g_enterprise||" AND t2.ooail001=t0.xcck001 AND t2.ooail002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t3 ON t3.glaalent="||g_enterprise||" AND t3.glaalld=t0.xcckld AND t3.glaal001='"||g_dlang||"' ",
               " LEFT JOIN xcatl_t t4 ON t4.xcatlent="||g_enterprise||" AND t4.xcatl001=t0.xcck003 AND t4.xcatl002='"||g_dlang||"' ",
 
               " WHERE t0.xcckent = " ||g_enterprise|| " AND t0.xcckld = ? AND t0.xcck001 = ? AND t0.xcck003 = ? AND t0.xcck004 = ? AND t0.xcck005 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   #150805-00001#10add
   LET g_sql = " SELECT UNIQUE t0.xcckcomp,t0.xcck001,t0.xcckld,t0.xcck003,t1.ooefl003 , 
       t2.ooail003 ,t3.glaal002 ,t4.xcatl003",
               " FROM xcck_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.xcckcomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t2 ON t2.ooailent='"||g_enterprise||"' AND t2.ooail001=t0.xcck001 AND t2.ooail002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t3 ON t3.glaalent='"||g_enterprise||"' AND t3.glaalld=t0.xcckld AND t3.glaal001='"||g_dlang||"' ",
               " LEFT JOIN xcatl_t t4 ON t4.xcatlent='"||g_enterprise||"' AND t4.xcatl001=t0.xcck003 AND t4.xcatl002='"||g_dlang||"' ",
 
               " WHERE t0.xcckent = '" ||g_enterprise|| "' AND t0.xcckld = ? AND t0.xcck001 = ? AND t0.xcck003 = ? "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #end add-point
   PREPARE axcq512_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq512 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq512_init()   
 
      #進入選單 Menu (="N")
      CALL axcq512_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq512
      
   END IF 
   
   CLOSE axcq512_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axcq512.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axcq512_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('xcck001','8914')
   CALL cl_set_combo_scc('xmdl007','2055')   #add--2015/11/10 By shiun
   #fengmy 150123----begin
   #根據參數顯示隱藏成本域 和 料件特性
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1  #采用特性否       
         
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xcck002,xcck002_desc',TRUE)                    
   ELSE                            
      CALL cl_set_comp_visible('xcck002,xcck002_desc',FALSE)                
   END IF   
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xcck011',TRUE)                    
   ELSE                       
      CALL cl_set_comp_visible('xcck011',FALSE)                
   END IF 
   #fengmy 150123----end      
   #end add-point
   
   CALL axcq512_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axcq512.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axcq512_ui_dialog()
   #add-point:ui_dialog段define name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE la_param  RECORD
          prog                  STRING,
          actionid              STRING,
          background            LIKE type_t.chr1,
          param                 DYNAMIC ARRAY OF STRING
                                END RECORD
   DEFINE ls_js                 STRING
   DEFINE li_idx                LIKE type_t.num10
   DEFINE ls_wc                 STRING
   DEFINE lb_first              BOOLEAN
   DEFINE l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
 
   #end add-point  
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET lb_first = TRUE
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   IF cl_null(g_wc) OR g_wc = " 1=1" THEN
      CALL axcq512_query()
   END IF
   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_xcck_m.* TO NULL
         CALL g_xcck_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axcq512_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_xcck_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL axcq512_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axcq512_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body.before_row"
               
               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
    
               #控制stus哪個按鈕可以按
               
               
            
 
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
 
         #end add-point
         
         
         BEFORE DIALOG
            #先填充browser資料
            CALL axcq512_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL g_curr_diag.setSelectionMode("s_detail1",1)         
            LET g_page = "first"
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               LET g_current_idx = g_current_row
            END IF
            LET g_current_row = g_current_idx #目前指標
            LET g_current_sw = TRUE
            
            IF g_current_idx > g_browser.getLength() THEN
               LET g_current_idx = g_browser.getLength()
            END IF 
            
            IF g_current_idx = 0 AND g_browser.getLength() > 0 THEN
               LET g_current_idx = 1 
            END IF
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL axcq512_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axcq512_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            #列印报表功能  20150324 By dujuan---------str 
            ON ACTION output
               LET g_action_choice="output"
               IF cl_auth_chk_act("output") THEN
                  #創建臨時表
                  CALL axcq512_create_temp_table()
                  #為臨時表加數據
                  CALL axcq512_get_date()
                  LET g_param.v = "axcq512_tmp"
                  CALL axcq512_x01(" 1=1",g_param.v)
                  LET g_action_choice = ""
                  EXIT DIALOG
               END IF
            #20150324 By dujuan--------end 
            #151130-00003#13-add----(S)
            #增加二次查詢功能
            ON ACTION filter
               LET g_action_choice="filter"
               CALL axcq512_filter()
            #151130-00003#13-add----(E)
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axcq512_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq512_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axcq512_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq512_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axcq512_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq512_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axcq512_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq512_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axcq512_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq512_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               #browser
               CALL g_export_node.clear()
               IF g_main_hidden = 1 THEN
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
               #非browser
               ELSE
                  LET g_export_node[1] = base.typeInfo.create(g_xcck_d)
                  LET g_export_id[1]   = "s_detail1"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  
                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
          
         ON ACTION close
            LET INT_FLAG=FALSE        
            LET g_action_choice = "exit"
            EXIT DIALOG     
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
          
            
         ON ACTION worksheethidden   #瀏覽頁折疊
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
                CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
            END IF
            IF lb_first THEN
               LET lb_first = FALSE
               NEXT FIELD xcck002
            END IF
       
         ON ACTION controls      #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
            IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("vb_master",0)
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("vb_master",1)
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden     
            END IF
            
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL axcq512_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL axcq512_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL axcq512_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axcq512_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axcq512_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axcq512_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axcq512_set_pk_array()
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
 
{<section id="axcq512.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION axcq512_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq512.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axcq512_browser_fill(ps_page_action)
   #add-point:browser_fill段define name="browser_fill.define_customerization"
   
   #end add-point   
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   #add-point:browser_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_wc1             STRING
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.before_browser_fill"
   
   IF cl_null(g_wc) THEN
      LET g_wc = " xcck055 IN ('303','305','307,'215'')"
      LET g_wc = g_wc," AND (xcck004*12+xcck005 BETWEEN ",g_yy1,"*12+",g_mm1," AND ",g_yy2,"*12+",g_mm2,")"  #150805-00001#10add     
   ELSE
      LET g_wc = g_wc," AND xcck055 IN ('303','305','307','215')"
      LET g_wc = g_wc," AND (xcck004*12+xcck005 BETWEEN ",g_yy1,"*12+",g_mm1," AND ",g_yy2,"*12+",g_mm2,")"  #150805-00001#10add     
   END IF
  
   #end add-point    
 
   LET l_searchcol = "xcckld,xcck001,xcck003,xcck004,xcck005"
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      LET l_wc = " 1=1"
   END IF
   IF cl_null(l_wc2) THEN  #p_wc 查詢條件
      LET l_wc2 = " 1=1"
   END IF
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT xcckld ",
                      ", xcck001 ",
                      ", xcck003 ",
                      ", xcck004 ",
                      ", xcck005 ",
 
                      " FROM xcck_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE xcckent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xcck_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xcckld ",
                      ", xcck001 ",
                      ", xcck003 ",
                      ", xcck004 ",
                      ", xcck005 ",
 
                      " FROM xcck_t ",
                      " ",
                      " ", 
 
 
                      " WHERE xcckent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xcck_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
 
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   #151130-00003#14-add----(S)
   #把條件加在l_wc，這樣二次查詢完再查詢時，g_wc值才不會有g_wc_filter
   IF NOT cl_null(g_wc_filter) THEN
      LET l_wc = l_wc," AND ",g_wc_filter
   END IF
   #151130-00003#14-add----(E)
    #150805-00001#10add
    IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE xcckld ",
                      ", xcck001 ",
                      ", xcck003 ",
                      " FROM xcck_t ",
                      " ",
                      " ",
 
                      " WHERE xcckent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xcck_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE xcckld ",
                      ", xcck001 ",
                      ", xcck003 ",
                      " FROM xcck_t ",
                      " ",
                      " ",
                      " WHERE xcckent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("xcck_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
   #150805-00001#10add   
   #160802-00020#4-add-(S)
   #---增加帳套權限
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql , " AND xcckld IN ",g_wc_cs_ld
    END IF
   #160802-00020#4-add-(E)
   #160802-00020#10-add-(S)
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql," AND xcckcomp IN ",g_wc_cs_comp
   END IF
   #160802-00020#10-add-(E)
   #end add-point
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE header_cnt_pre FROM g_sql
      EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
      FREE header_cnt_pre
   END IF
   
   #若超過最大顯示筆數
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt 
         LET g_errparam.code   = 9035
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
      LET g_browser_cnt = g_max_browse
   END IF
   LET g_error_show = 0
 
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_xcck_m.* TO NULL
      CALL g_xcck_d.clear()        
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xcckld,t0.xcck001,t0.xcck003,t0.xcck004,t0.xcck005 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.xcckld,t0.xcck001,t0.xcck003,t0.xcck004,t0.xcck005",
                " FROM xcck_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.xcckent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xcck_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   #150805-00001#10add
   LET l_searchcol = "xcckld,xcck001,xcck003"
   LET g_sql  = "SELECT DISTINCT t0.xcckld,t0.xcck001,t0.xcck003",
                " FROM xcck_t t0",
                " ",
                " ",
 
                
                " WHERE t0.xcckent = '" ||g_enterprise|| "' AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xcck_t")
   
   #160802-00020#4-add-(S)
   #---增加帳套權限
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql , " AND xcckld IN ",g_wc_cs_ld
    END IF
   #160802-00020#4-add-(E)
   #160802-00020#10-add-(S)
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql," AND xcckcomp IN ",g_wc_cs_comp
   END IF
   #160802-00020#10-add-(E)
   
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
     
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"xcck_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_xcckld,g_browser[g_cnt].b_xcck001,g_browser[g_cnt].b_xcck003, 
          g_browser[g_cnt].b_xcck004,g_browser[g_cnt].b_xcck005 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         
         
         #add-point:browser_fill段reference name="browser_fill.reference"
         
         #end add-point  
      
         
         LET g_cnt = g_cnt + 1
         IF g_cnt > g_max_browse THEN
            EXIT FOREACH
         END IF
      END FOREACH
      FREE browse_pre
   END IF
 
   #清空g_add_browse, 並指定指標位置
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = ""
      CALL g_curr_diag.setCurrentRow("s_browse",g_current_idx)
   END IF
   
   IF cl_null(g_browser[g_cnt].b_xcckld) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_xcck_m.* TO NULL
      CALL g_xcck_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      #160113-00011#1-add----(S)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "-100"
      LET g_errparam.popup  = FALSE
      CALL cl_err()
      #160113-00011#1-add----(E)
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL axcq512_fetch('')
   
   #筆數顯示
   LET g_browser_idx = g_current_idx 
   IF g_browser_cnt > 0 THEN
      DISPLAY g_browser_idx TO FORMONLY.b_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.b_count #總筆數
      DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
      DISPLAY g_detail_idx  TO FORMONLY.idx     #單身當下筆數
      DISPLAY g_detail_cnt  TO FORMONLY.cnt     #單身總筆數
   ELSE
      DISPLAY '' TO FORMONLY.b_index #當下筆數
      DISPLAY '' TO FORMONLY.b_count #總筆數
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
      DISPLAY '' TO FORMONLY.idx     #單身當下筆數
      DISPLAY '' TO FORMONLY.cnt     #單身總筆數
   END IF
    
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
 
   #add-point:browser_fill段結束前 name="browser_fill.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq512.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axcq512_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xcck_m.xcckld = g_browser[g_current_idx].b_xcckld   
   LET g_xcck_m.xcck001 = g_browser[g_current_idx].b_xcck001   
   LET g_xcck_m.xcck003 = g_browser[g_current_idx].b_xcck003   
   LET g_xcck_m.xcck004 = g_browser[g_current_idx].b_xcck004   
   LET g_xcck_m.xcck005 = g_browser[g_current_idx].b_xcck005   
 
   EXECUTE axcq512_master_referesh USING g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004, 
       g_xcck_m.xcck005 INTO g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck001,g_xcck_m.xcckld, 
       g_xcck_m.xcck003,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck001_desc,g_xcck_m.xcckld_desc,g_xcck_m.xcck003_desc 
 
   CALL axcq512_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axcq512.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axcq512_ui_detailshow()
   #add-point:ui_detailshow段define name="ui_detailshow.define_customerization"
   
   #end add-point
   #add-point:ui_detailshow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_detailshow.before"
   
   #end add-point  
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
 
      #add-point:ui_detailshow段more name="ui_detailshow.more"
      
      #end add-point 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq512.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axcq512_ui_browser_refresh()
   #add-point:ui_browser_refresh段define name="ui_browser_refresh.define_customerization"
   
   #end add-point   
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_xcckld = g_xcck_m.xcckld 
         AND g_browser[l_i].b_xcck001 = g_xcck_m.xcck001 
         AND g_browser[l_i].b_xcck003 = g_xcck_m.xcck003 
         AND g_browser[l_i].b_xcck004 = g_xcck_m.xcck004 
         AND g_browser[l_i].b_xcck005 = g_xcck_m.xcck005 
 
         THEN  
         CALL g_browser.deleteElement(l_i)
      END IF
   END FOR
   LET g_browser_cnt = g_browser_cnt - 1
   LET g_header_cnt = g_header_cnt - 1
 
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
      CLEAR FORM
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
 
   DISPLAY g_browser_cnt TO FORMONLY.b_count    #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數的顯示
   
END FUNCTION
 
{</section>}
 
{<section id="axcq512.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axcq512_construct()
   #add-point:cs段define name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清除畫面上相關資料
   CLEAR FORM                 
   INITIALIZE g_xcck_m.* TO NULL
   CALL g_xcck_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xcckcomp,xcck001,xcckld,xcck003
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            CALL axcq512_default()
            #end add-point 
            
                 #Ctrlp:construct.c.xcckcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcckcomp
            #add-point:ON ACTION controlp INFIELD xcckcomp name="construct.c.xcckcomp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160802-00020#10-add-(S)
            #增加法人過濾條件
            IF NOT cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF
            #160802-00020#10-add-(E)
            #CALL q_ooef001()                           #呼叫開窗  #161019-00017#5
            CALL q_ooef001_2()   #161019-00017#5
            DISPLAY g_qryparam.return1 TO xcckcomp  #顯示到畫面上
            NEXT FIELD xcckcomp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcckcomp
            #add-point:BEFORE FIELD xcckcomp name="construct.b.xcckcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcckcomp
            
            #add-point:AFTER FIELD xcckcomp name="construct.a.xcckcomp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck001
            #add-point:BEFORE FIELD xcck001 name="construct.b.xcck001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck001
            
            #add-point:AFTER FIELD xcck001 name="construct.a.xcck001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcck001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck001
            #add-point:ON ACTION controlp INFIELD xcck001 name="construct.c.xcck001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xcckld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcckld
            #add-point:ON ACTION controlp INFIELD xcckld name="construct.c.xcckld"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160802-00020#4-add-(S)
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #160802-00020#4-add-(E)
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcckld  #顯示到畫面上
            NEXT FIELD xcckld                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcckld
            #add-point:BEFORE FIELD xcckld name="construct.b.xcckld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcckld
            
            #add-point:AFTER FIELD xcckld name="construct.a.xcckld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcck003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck003
            #add-point:ON ACTION controlp INFIELD xcck003 name="construct.c.xcck003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck003  #顯示到畫面上
            NEXT FIELD xcck003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck003
            #add-point:BEFORE FIELD xcck003 name="construct.b.xcck003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck003
            
            #add-point:AFTER FIELD xcck003 name="construct.a.xcck003"
            
            #END add-point
            
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON xccksite,xcck002,xcck006,xcck007,xcck008,xcck009,xcck013,xcck010,xrca066, 
          xrca014,imag011,xrca038,xmdl007,xmdk022,xcck011,xcck015,xcck015_desc,xcck017,xcck044,xcck201, 
          xcck282a,xcck282b,xcck282c,xcck282d,xcck282e,xcck282f,xcck282g,xcck282h,xcck282,xcck202a,xcck202b, 
          xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,xcck202h,xcck202
           FROM s_detail1[1].xccksite,s_detail1[1].xcck002,s_detail1[1].xcck006,s_detail1[1].xcck007, 
               s_detail1[1].xcck008,s_detail1[1].xcck009,s_detail1[1].xcck013,s_detail1[1].xcck010,s_detail1[1].xrca066, 
               s_detail1[1].xrca014,s_detail1[1].imag011,s_detail1[1].xrca038,s_detail1[1].xmdl007,s_detail1[1].xmdk022, 
               s_detail1[1].xcck011,s_detail1[1].xcck015,s_detail1[1].xcck015_desc,s_detail1[1].xcck017, 
               s_detail1[1].xcck044,s_detail1[1].xcck201,s_detail1[1].xcck282a,s_detail1[1].xcck282b, 
               s_detail1[1].xcck282c,s_detail1[1].xcck282d,s_detail1[1].xcck282e,s_detail1[1].xcck282f, 
               s_detail1[1].xcck282g,s_detail1[1].xcck282h,s_detail1[1].xcck282,s_detail1[1].xcck202a, 
               s_detail1[1].xcck202b,s_detail1[1].xcck202c,s_detail1[1].xcck202d,s_detail1[1].xcck202e, 
               s_detail1[1].xcck202f,s_detail1[1].xcck202g,s_detail1[1].xcck202h,s_detail1[1].xcck202 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #Ctrlp:construct.c.page1.xccksite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccksite
            #add-point:ON ACTION controlp INFIELD xccksite name="construct.c.page1.xccksite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                           #呼叫開窗  #161019-00017#5
            CALL q_ooef001_1()   #161019-00017#5
            DISPLAY g_qryparam.return1 TO xccksite  #顯示到畫面上
            NEXT FIELD xccksite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccksite
            #add-point:BEFORE FIELD xccksite name="construct.b.page1.xccksite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccksite
            
            #add-point:AFTER FIELD xccksite name="construct.a.page1.xccksite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck002
            #add-point:BEFORE FIELD xcck002 name="construct.b.page1.xcck002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck002
            
            #add-point:AFTER FIELD xcck002 name="construct.a.page1.xcck002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck002
            #add-point:ON ACTION controlp INFIELD xcck002 name="construct.c.page1.xcck002"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcbf001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck002  #顯示到畫面上            
            NEXT FIELD xcck002                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck006
            #add-point:BEFORE FIELD xcck006 name="construct.b.page1.xcck006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck006
            
            #add-point:AFTER FIELD xcck006 name="construct.a.page1.xcck006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck006
            #add-point:ON ACTION controlp INFIELD xcck006 name="construct.c.page1.xcck006"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " xmdkstus = 'S'"
            CALL q_xmdkdocno_1()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck006  #顯示到畫面上            
            NEXT FIELD xcck006                     #返回原欄位
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck007
            #add-point:BEFORE FIELD xcck007 name="construct.b.page1.xcck007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck007
            
            #add-point:AFTER FIELD xcck007 name="construct.a.page1.xcck007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck007
            #add-point:ON ACTION controlp INFIELD xcck007 name="construct.c.page1.xcck007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck008
            #add-point:BEFORE FIELD xcck008 name="construct.b.page1.xcck008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck008
            
            #add-point:AFTER FIELD xcck008 name="construct.a.page1.xcck008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck008
            #add-point:ON ACTION controlp INFIELD xcck008 name="construct.c.page1.xcck008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck009
            #add-point:BEFORE FIELD xcck009 name="construct.b.page1.xcck009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck009
            
            #add-point:AFTER FIELD xcck009 name="construct.a.page1.xcck009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck009
            #add-point:ON ACTION controlp INFIELD xcck009 name="construct.c.page1.xcck009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck013
            #add-point:BEFORE FIELD xcck013 name="construct.b.page1.xcck013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck013
            
            #add-point:AFTER FIELD xcck013 name="construct.a.page1.xcck013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck013
            #add-point:ON ACTION controlp INFIELD xcck013 name="construct.c.page1.xcck013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck010
            #add-point:BEFORE FIELD xcck010 name="construct.b.page1.xcck010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck010
            
            #add-point:AFTER FIELD xcck010 name="construct.a.page1.xcck010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck010
            #add-point:ON ACTION controlp INFIELD xcck010 name="construct.c.page1.xcck010"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_imaf001_15()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck010  #顯示到畫面上
            NEXT FIELD xcck010                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca066
            #add-point:BEFORE FIELD xrca066 name="construct.b.page1.xrca066"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca066
            
            #add-point:AFTER FIELD xrca066 name="construct.a.page1.xrca066"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrca066
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca066
            #add-point:ON ACTION controlp INFIELD xrca066 name="construct.c.page1.xrca066"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca014
            #add-point:BEFORE FIELD xrca014 name="construct.b.page1.xrca014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca014
            
            #add-point:AFTER FIELD xrca014 name="construct.a.page1.xrca014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrca014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca014
            #add-point:ON ACTION controlp INFIELD xrca014 name="construct.c.page1.xrca014"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.imag011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imag011
            #add-point:ON ACTION controlp INFIELD imag011 name="construct.c.page1.imag011"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imag011()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imag011  #顯示到畫面上
            NEXT FIELD imag011                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imag011
            #add-point:BEFORE FIELD imag011 name="construct.b.page1.imag011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imag011
            
            #add-point:AFTER FIELD imag011 name="construct.a.page1.imag011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca038
            #add-point:BEFORE FIELD xrca038 name="construct.b.page1.xrca038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca038
            
            #add-point:AFTER FIELD xrca038 name="construct.a.page1.xrca038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrca038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca038
            #add-point:ON ACTION controlp INFIELD xrca038 name="construct.c.page1.xrca038"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl007
            #add-point:BEFORE FIELD xmdl007 name="construct.b.page1.xmdl007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl007
            
            #add-point:AFTER FIELD xmdl007 name="construct.a.page1.xmdl007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdl007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl007
            #add-point:ON ACTION controlp INFIELD xmdl007 name="construct.c.page1.xmdl007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdk022
            #add-point:BEFORE FIELD xmdk022 name="construct.b.page1.xmdk022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdk022
            
            #add-point:AFTER FIELD xmdk022 name="construct.a.page1.xmdk022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdk022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdk022
            #add-point:ON ACTION controlp INFIELD xmdk022 name="construct.c.page1.xmdk022"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdk022  #顯示到畫面上
            NEXT FIELD xmdk022                     #返回原欄位
    


            #END add-point
 
 
         #Ctrlp:construct.c.page1.xcck011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck011
            #add-point:ON ACTION controlp INFIELD xcck011 name="construct.c.page1.xcck011"
            #此段落由子樣板a08產生
            
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck011
            #add-point:BEFORE FIELD xcck011 name="construct.b.page1.xcck011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck011
            
            #add-point:AFTER FIELD xcck011 name="construct.a.page1.xcck011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck015
            #add-point:BEFORE FIELD xcck015 name="construct.b.page1.xcck015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck015
            
            #add-point:AFTER FIELD xcck015 name="construct.a.page1.xcck015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck015
            #add-point:ON ACTION controlp INFIELD xcck015 name="construct.c.page1.xcck015"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_inaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck015  #顯示到畫面上
            NEXT FIELD xcck015                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck015_desc
            #add-point:BEFORE FIELD xcck015_desc name="construct.b.page1.xcck015_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck015_desc
            
            #add-point:AFTER FIELD xcck015_desc name="construct.a.page1.xcck015_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck015_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck015_desc
            #add-point:ON ACTION controlp INFIELD xcck015_desc name="construct.c.page1.xcck015_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck017
            #add-point:BEFORE FIELD xcck017 name="construct.b.page1.xcck017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck017
            
            #add-point:AFTER FIELD xcck017 name="construct.a.page1.xcck017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck017
            #add-point:ON ACTION controlp INFIELD xcck017 name="construct.c.page1.xcck017"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xcck044
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck044
            #add-point:ON ACTION controlp INFIELD xcck044 name="construct.c.page1.xcck044"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck044  #顯示到畫面上
            NEXT FIELD xcck044                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck044
            #add-point:BEFORE FIELD xcck044 name="construct.b.page1.xcck044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck044
            
            #add-point:AFTER FIELD xcck044 name="construct.a.page1.xcck044"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck201
            #add-point:BEFORE FIELD xcck201 name="construct.b.page1.xcck201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck201
            
            #add-point:AFTER FIELD xcck201 name="construct.a.page1.xcck201"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck201
            #add-point:ON ACTION controlp INFIELD xcck201 name="construct.c.page1.xcck201"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282a
            #add-point:BEFORE FIELD xcck282a name="construct.b.page1.xcck282a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282a
            
            #add-point:AFTER FIELD xcck282a name="construct.a.page1.xcck282a"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck282a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282a
            #add-point:ON ACTION controlp INFIELD xcck282a name="construct.c.page1.xcck282a"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282b
            #add-point:BEFORE FIELD xcck282b name="construct.b.page1.xcck282b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282b
            
            #add-point:AFTER FIELD xcck282b name="construct.a.page1.xcck282b"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck282b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282b
            #add-point:ON ACTION controlp INFIELD xcck282b name="construct.c.page1.xcck282b"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282c
            #add-point:BEFORE FIELD xcck282c name="construct.b.page1.xcck282c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282c
            
            #add-point:AFTER FIELD xcck282c name="construct.a.page1.xcck282c"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck282c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282c
            #add-point:ON ACTION controlp INFIELD xcck282c name="construct.c.page1.xcck282c"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282d
            #add-point:BEFORE FIELD xcck282d name="construct.b.page1.xcck282d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282d
            
            #add-point:AFTER FIELD xcck282d name="construct.a.page1.xcck282d"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck282d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282d
            #add-point:ON ACTION controlp INFIELD xcck282d name="construct.c.page1.xcck282d"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282e
            #add-point:BEFORE FIELD xcck282e name="construct.b.page1.xcck282e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282e
            
            #add-point:AFTER FIELD xcck282e name="construct.a.page1.xcck282e"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck282e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282e
            #add-point:ON ACTION controlp INFIELD xcck282e name="construct.c.page1.xcck282e"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282f
            #add-point:BEFORE FIELD xcck282f name="construct.b.page1.xcck282f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282f
            
            #add-point:AFTER FIELD xcck282f name="construct.a.page1.xcck282f"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck282f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282f
            #add-point:ON ACTION controlp INFIELD xcck282f name="construct.c.page1.xcck282f"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282g
            #add-point:BEFORE FIELD xcck282g name="construct.b.page1.xcck282g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282g
            
            #add-point:AFTER FIELD xcck282g name="construct.a.page1.xcck282g"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck282g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282g
            #add-point:ON ACTION controlp INFIELD xcck282g name="construct.c.page1.xcck282g"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282h
            #add-point:BEFORE FIELD xcck282h name="construct.b.page1.xcck282h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282h
            
            #add-point:AFTER FIELD xcck282h name="construct.a.page1.xcck282h"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck282h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282h
            #add-point:ON ACTION controlp INFIELD xcck282h name="construct.c.page1.xcck282h"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282
            #add-point:BEFORE FIELD xcck282 name="construct.b.page1.xcck282"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282
            
            #add-point:AFTER FIELD xcck282 name="construct.a.page1.xcck282"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck282
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282
            #add-point:ON ACTION controlp INFIELD xcck282 name="construct.c.page1.xcck282"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202a
            #add-point:BEFORE FIELD xcck202a name="construct.b.page1.xcck202a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202a
            
            #add-point:AFTER FIELD xcck202a name="construct.a.page1.xcck202a"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck202a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202a
            #add-point:ON ACTION controlp INFIELD xcck202a name="construct.c.page1.xcck202a"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202b
            #add-point:BEFORE FIELD xcck202b name="construct.b.page1.xcck202b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202b
            
            #add-point:AFTER FIELD xcck202b name="construct.a.page1.xcck202b"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck202b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202b
            #add-point:ON ACTION controlp INFIELD xcck202b name="construct.c.page1.xcck202b"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202c
            #add-point:BEFORE FIELD xcck202c name="construct.b.page1.xcck202c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202c
            
            #add-point:AFTER FIELD xcck202c name="construct.a.page1.xcck202c"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck202c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202c
            #add-point:ON ACTION controlp INFIELD xcck202c name="construct.c.page1.xcck202c"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202d
            #add-point:BEFORE FIELD xcck202d name="construct.b.page1.xcck202d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202d
            
            #add-point:AFTER FIELD xcck202d name="construct.a.page1.xcck202d"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck202d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202d
            #add-point:ON ACTION controlp INFIELD xcck202d name="construct.c.page1.xcck202d"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202e
            #add-point:BEFORE FIELD xcck202e name="construct.b.page1.xcck202e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202e
            
            #add-point:AFTER FIELD xcck202e name="construct.a.page1.xcck202e"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck202e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202e
            #add-point:ON ACTION controlp INFIELD xcck202e name="construct.c.page1.xcck202e"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202f
            #add-point:BEFORE FIELD xcck202f name="construct.b.page1.xcck202f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202f
            
            #add-point:AFTER FIELD xcck202f name="construct.a.page1.xcck202f"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck202f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202f
            #add-point:ON ACTION controlp INFIELD xcck202f name="construct.c.page1.xcck202f"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202g
            #add-point:BEFORE FIELD xcck202g name="construct.b.page1.xcck202g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202g
            
            #add-point:AFTER FIELD xcck202g name="construct.a.page1.xcck202g"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck202g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202g
            #add-point:ON ACTION controlp INFIELD xcck202g name="construct.c.page1.xcck202g"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202h
            #add-point:BEFORE FIELD xcck202h name="construct.b.page1.xcck202h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202h
            
            #add-point:AFTER FIELD xcck202h name="construct.a.page1.xcck202h"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck202h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202h
            #add-point:ON ACTION controlp INFIELD xcck202h name="construct.c.page1.xcck202h"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202
            #add-point:BEFORE FIELD xcck202 name="construct.b.page1.xcck202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202
            
            #add-point:AFTER FIELD xcck202 name="construct.a.page1.xcck202"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202
            #add-point:ON ACTION controlp INFIELD xcck202 name="construct.c.page1.xcck202"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      #150805-00001#10add
      INPUT g_yy1,g_mm1,g_yy2,g_mm2 FROM xcck004,xcck005,b_xcck004,b_xcck005
         AFTER FIELD xcck004 
            IF NOT cl_null(g_yy1) AND NOT cl_null(g_yy2) THEN
                IF g_yy1 > g_yy2 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'acr-00064'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   NEXT FIELD xcck004
                END IF
             END IF
         AFTER FIELD xcck005
            IF NOT cl_null(g_mm1) AND NOT cl_null(g_mm2) THEN
               IF g_yy1 = g_yy2 AND g_mm1 > g_mm2 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00067'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD xcck005
               END IF
            END IF
         AFTER FIELD b_xcck004
            IF NOT cl_null(g_yy1) AND NOT cl_null(g_yy2) THEN
                IF g_yy1 > g_yy2 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'acr-00064'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   NEXT FIELD b_xcck004
                END IF
             END IF
         AFTER FIELD b_xcck005   
            IF NOT cl_null(g_mm1) AND NOT cl_null(g_mm2) THEN
               IF g_yy1 = g_yy2 AND g_mm1 > g_mm2 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00067'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD b_xcck005
               END IF
            END IF     
      END INPUT
      #150805-00001#10add
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog name="cs.before_dialog"
         LET g_wc_t = g_wc
         #end add-point
      
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG
   
   #add-point:cs段after_construct name="cs.after_construct"
   
   #end add-point
   
   #組合g_wc2
   LET g_wc2 = g_wc2_table1
 
 
 
   
   LET g_current_row = 1
 
   IF INT_FLAG THEN
      RETURN
   END IF
   
   LET g_wc_filter = ""
 
END FUNCTION
 
{</section>}
 
{<section id="axcq512.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axcq512_query()
   #add-point:query段define name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="query.befroe_query"
   
   #end add-point 
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF     
   
   LET ls_wc = g_wc
 
   LET INT_FLAG = 0    
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_xcck_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL axcq512_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axcq512_browser_fill(g_wc)
      CALL axcq512_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL axcq512_browser_fill("F")
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||")")
   
   #備份搜尋條件
   LET ls_wc = g_wc
   
   IF g_browser.getLength() = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   ELSE
      CALL axcq512_fetch("F") 
   END IF
   
   CALL axcq512_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="axcq512.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axcq512_fetch(p_flag)
   #add-point:fetch段define name="fetch.define_customerization"
   
   #end add-point   
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fetch.before_fetch"
   #150805-00001#10add
   CASE p_flag
      WHEN 'F' 
         LET g_current_idx = 1
      WHEN 'L' 
         LET g_current_idx = g_header_cnt
         LET g_current_idx = g_browser.getLength()              
      WHEN 'P'
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN 'N'
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN '/'
         IF (NOT g_no_ask) THEN    
            CALL cl_set_act_visible("accept,cancel", TRUE)    
            CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,': ' FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl" 
            END PROMPT
 
            CALL cl_set_act_visible("accept,cancel", FALSE)    
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE  
            END IF
            
         END IF
         
         IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
            LET g_current_idx = g_jump
         END IF
 
         LET g_no_ask = FALSE  
   END CASE    
   
   #若無資料則離開
   IF g_current_idx = 0 THEN
      RETURN
   END IF
     
   LET g_detail_cnt = g_header_cnt                  
   
   #單身筆數顯示
   DISPLAY g_detail_cnt TO FORMONLY.cnt                      #設定page 總筆數 
   IF g_detail_cnt > 0 THEN
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY ' ' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart + g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數
   
   CALL cl_navigator_setting(g_current_idx,g_detail_cnt)
   
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_xcck_m.xcckld = g_browser[g_current_idx].b_xcckld
   LET g_xcck_m.xcck001 = g_browser[g_current_idx].b_xcck001
   LET g_xcck_m.xcck003 = g_browser[g_current_idx].b_xcck003
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axcq512_master_referesh USING g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003 
       INTO g_xcck_m.xcckcomp,g_xcck_m.xcck001,g_xcck_m.xcckld,g_xcck_m.xcck003,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck001_desc,g_xcck_m.xcckld_desc,g_xcck_m.xcck003_desc 

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcck_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_xcck_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_xcck_m_mask_o.* =  g_xcck_m.*
   CALL axcq512_xcck_t_mask()
   LET g_xcck_m_mask_n.* =  g_xcck_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq512_set_act_visible()
   CALL axcq512_set_act_no_visible()
 
   #保存單頭舊值
   LET g_xcck_m_t.* = g_xcck_m.*
   LET g_xcck_m_o.* = g_xcck_m.*
   
   #重新顯示   
   CALL axcq512_show()
   RETURN
   
   #end add-point    
 
   CASE p_flag
      WHEN 'F' 
         LET g_current_idx = 1
      WHEN 'L' 
         LET g_current_idx = g_header_cnt
         LET g_current_idx = g_browser.getLength()              
      WHEN 'P'
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN 'N'
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN '/'
         IF (NOT g_no_ask) THEN    
            CALL cl_set_act_visible("accept,cancel", TRUE)    
            CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,': ' FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl" 
            END PROMPT
 
            CALL cl_set_act_visible("accept,cancel", FALSE)    
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE  
            END IF
            
         END IF
         
         IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
            LET g_current_idx = g_jump
         END IF
 
         LET g_no_ask = FALSE  
   END CASE    
   
   #若無資料則離開
   IF g_current_idx = 0 THEN
      RETURN
   END IF
   
   #CALL axcq512_browser_fill(p_flag)
   
   LET g_detail_cnt = g_header_cnt                  
   
   #單身筆數顯示
   DISPLAY g_detail_cnt TO FORMONLY.cnt                      #設定page 總筆數 
   #LET g_detail_idx = 1
   IF g_detail_cnt > 0 THEN
      #LET g_detail_idx = 1
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY ' ' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart + g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數
   
   CALL cl_navigator_setting(g_current_idx,g_detail_cnt)
   
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_xcck_m.xcckld = g_browser[g_current_idx].b_xcckld
   LET g_xcck_m.xcck001 = g_browser[g_current_idx].b_xcck001
   LET g_xcck_m.xcck003 = g_browser[g_current_idx].b_xcck003
   LET g_xcck_m.xcck004 = g_browser[g_current_idx].b_xcck004
   LET g_xcck_m.xcck005 = g_browser[g_current_idx].b_xcck005
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axcq512_master_referesh USING g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004, 
       g_xcck_m.xcck005 INTO g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck001,g_xcck_m.xcckld, 
       g_xcck_m.xcck003,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck001_desc,g_xcck_m.xcckld_desc,g_xcck_m.xcck003_desc 
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcck_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_xcck_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_xcck_m_mask_o.* =  g_xcck_m.*
   CALL axcq512_xcck_t_mask()
   LET g_xcck_m_mask_n.* =  g_xcck_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq512_set_act_visible()
   CALL axcq512_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_xcck_m_t.* = g_xcck_m.*
   LET g_xcck_m_o.* = g_xcck_m.*
   
   #重新顯示   
   CALL axcq512_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axcq512.insert" >}
#+ 資料新增
PRIVATE FUNCTION axcq512_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_xcck_d.clear()
 
 
   INITIALIZE g_xcck_m.* TO NULL             #DEFAULT 設定
   LET g_xcckld_t = NULL
   LET g_xcck001_t = NULL
   LET g_xcck003_t = NULL
   LET g_xcck004_t = NULL
   LET g_xcck005_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
 
      CALL axcq512_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_xcck_m.* TO NULL
         INITIALIZE g_xcck_d TO NULL
 
         CALL axcq512_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xcck_m.* = g_xcck_m_t.*
         CALL axcq512_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_xcck_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq512_set_act_visible()
   CALL axcq512_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcckld_t = g_xcck_m.xcckld
   LET g_xcck001_t = g_xcck_m.xcck001
   LET g_xcck003_t = g_xcck_m.xcck003
   LET g_xcck004_t = g_xcck_m.xcck004
   LET g_xcck005_t = g_xcck_m.xcck005
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcckent = " ||g_enterprise|| " AND",
                      " xcckld = '", g_xcck_m.xcckld, "' "
                      ," AND xcck001 = '", g_xcck_m.xcck001, "' "
                      ," AND xcck003 = '", g_xcck_m.xcck003, "' "
                      ," AND xcck004 = '", g_xcck_m.xcck004, "' "
                      ," AND xcck005 = '", g_xcck_m.xcck005, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq512_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL axcq512_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axcq512_master_referesh USING g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004, 
       g_xcck_m.xcck005 INTO g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck001,g_xcck_m.xcckld, 
       g_xcck_m.xcck003,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck001_desc,g_xcck_m.xcckld_desc,g_xcck_m.xcck003_desc 
 
   
   #遮罩相關處理
   LET g_xcck_m_mask_o.* =  g_xcck_m.*
   CALL axcq512_xcck_t_mask()
   LET g_xcck_m_mask_n.* =  g_xcck_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck001, 
       g_xcck_m.xcck001_desc,g_xcck_m.xcckld,g_xcck_m.xcckld_desc,g_xcck_m.b_xcck004,g_xcck_m.b_xcck005, 
       g_xcck_m.xcck003,g_xcck_m.xcck003_desc
   
   #功能已完成,通報訊息中心
   CALL axcq512_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axcq512.modify" >}
#+ 資料修改
PRIVATE FUNCTION axcq512_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_xcck_m.xcckld IS NULL
   OR g_xcck_m.xcck001 IS NULL
   OR g_xcck_m.xcck003 IS NULL
   OR g_xcck_m.xcck004 IS NULL
   OR g_xcck_m.xcck005 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_xcckld_t = g_xcck_m.xcckld
   LET g_xcck001_t = g_xcck_m.xcck001
   LET g_xcck003_t = g_xcck_m.xcck003
   LET g_xcck004_t = g_xcck_m.xcck004
   LET g_xcck005_t = g_xcck_m.xcck005
 
   CALL s_transaction_begin()
   
   OPEN axcq512_cl USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq512_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axcq512_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axcq512_master_referesh USING g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004, 
       g_xcck_m.xcck005 INTO g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck001,g_xcck_m.xcckld, 
       g_xcck_m.xcck003,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck001_desc,g_xcck_m.xcckld_desc,g_xcck_m.xcck003_desc 
 
   
   #遮罩相關處理
   LET g_xcck_m_mask_o.* =  g_xcck_m.*
   CALL axcq512_xcck_t_mask()
   LET g_xcck_m_mask_n.* =  g_xcck_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL axcq512_show()
   WHILE TRUE
      LET g_xcckld_t = g_xcck_m.xcckld
      LET g_xcck001_t = g_xcck_m.xcck001
      LET g_xcck003_t = g_xcck_m.xcck003
      LET g_xcck004_t = g_xcck_m.xcck004
      LET g_xcck005_t = g_xcck_m.xcck005
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL axcq512_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xcck_m.* = g_xcck_m_t.*
         CALL axcq512_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_xcck_m.xcckld != g_xcckld_t 
      OR g_xcck_m.xcck001 != g_xcck001_t 
      OR g_xcck_m.xcck003 != g_xcck003_t 
      OR g_xcck_m.xcck004 != g_xcck004_t 
      OR g_xcck_m.xcck005 != g_xcck005_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單頭(偽)修改前 name="modify.b_key_update"
         
         #end add-point
         
         #add-point:單頭(偽)修改中 name="modify.m_key_update"
         
         #end add-point
         
 
         
         #add-point:單頭(偽)修改後 name="modify.a_key_update"
         
         #end add-point
         
      END IF
      
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq512_set_act_visible()
   CALL axcq512_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xcckent = " ||g_enterprise|| " AND",
                      " xcckld = '", g_xcck_m.xcckld, "' "
                      ," AND xcck001 = '", g_xcck_m.xcck001, "' "
                      ," AND xcck003 = '", g_xcck_m.xcck003, "' "
                      ," AND xcck004 = '", g_xcck_m.xcck004, "' "
                      ," AND xcck005 = '", g_xcck_m.xcck005, "' "
 
   #填到對應位置
   CALL axcq512_browser_fill("")
 
   CALL axcq512_idx_chk()
 
   CLOSE axcq512_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axcq512_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="axcq512.input" >}
#+ 資料輸入
PRIVATE FUNCTION axcq512_input(p_cmd)
   #add-point:input段define name="input.define_customerization"
   
   #end add-point   
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_ac_t                LIKE type_t.num10               #未取消的ARRAY CNT 
   DEFINE  l_n                   LIKE type_t.num10               #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10               #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
   DEFINE  l_insert              BOOLEAN
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num10
   DEFINE  li_reproduce_target   LIKE type_t.num10
   DEFINE  ls_keys               DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck001, 
       g_xcck_m.xcck001_desc,g_xcck_m.xcckld,g_xcck_m.xcckld_desc,g_xcck_m.b_xcck004,g_xcck_m.b_xcck005, 
       g_xcck_m.xcck003,g_xcck_m.xcck003_desc
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF  
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT xccksite,xcck002,xcck006,xcck007,xcck008,xcck009,xcck013,xcck010,xcck011, 
       xcck015,xcck017,xcck044,xcck201,xcck282a,xcck282b,xcck282c,xcck282d,xcck282e,xcck282f,xcck282g, 
       xcck282h,xcck282,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,xcck202h,xcck202  
       FROM xcck_t WHERE xcckent=? AND xcckld=? AND xcck001=? AND xcck003=? AND xcck004=? AND xcck005=?  
       AND xcck002=? AND xcck006=? AND xcck007=? AND xcck008=? AND xcck009=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq512_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axcq512_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axcq512_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck001,g_xcck_m.xcckld, 
       g_xcck_m.b_xcck004,g_xcck_m.b_xcck005,g_xcck_m.xcck003
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axcq512.input.head" >}
   
      #單頭段
      INPUT BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck001,g_xcck_m.xcckld, 
          g_xcck_m.b_xcck004,g_xcck_m.b_xcck005,g_xcck_m.xcck003 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:單頭input前 name="input.head.b_input"
            
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcckcomp
            
            #add-point:AFTER FIELD xcckcomp name="input.a.xcckcomp"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_m.xcckcomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_m.xcckcomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_m.xcckcomp_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcckcomp
            #add-point:BEFORE FIELD xcckcomp name="input.b.xcckcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcckcomp
            #add-point:ON CHANGE xcckcomp name="input.g.xcckcomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck004
            #add-point:BEFORE FIELD xcck004 name="input.b.xcck004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck004
            
            #add-point:AFTER FIELD xcck004 name="input.a.xcck004"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcck_m.xcckld) AND NOT cl_null(g_xcck_m.xcck001) AND NOT cl_null(g_xcck_m.xcck003) AND NOT cl_null(g_xcck_m.xcck004) AND NOT cl_null(g_xcck_m.xcck005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t  OR g_xcck_m.xcck001 != g_xcck001_t  OR g_xcck_m.xcck003 != g_xcck003_t  OR g_xcck_m.xcck004 != g_xcck004_t  OR g_xcck_m.xcck005 != g_xcck005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck004
            #add-point:ON CHANGE xcck004 name="input.g.xcck004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck005
            #add-point:BEFORE FIELD xcck005 name="input.b.xcck005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck005
            
            #add-point:AFTER FIELD xcck005 name="input.a.xcck005"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcck_m.xcckld) AND NOT cl_null(g_xcck_m.xcck001) AND NOT cl_null(g_xcck_m.xcck003) AND NOT cl_null(g_xcck_m.xcck004) AND NOT cl_null(g_xcck_m.xcck005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t  OR g_xcck_m.xcck001 != g_xcck001_t  OR g_xcck_m.xcck003 != g_xcck003_t  OR g_xcck_m.xcck004 != g_xcck004_t  OR g_xcck_m.xcck005 != g_xcck005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck005
            #add-point:ON CHANGE xcck005 name="input.g.xcck005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck001
            
            #add-point:AFTER FIELD xcck001 name="input.a.xcck001"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_m.xcck001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_m.xcck001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_m.xcck001_desc

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcck_m.xcckld) AND NOT cl_null(g_xcck_m.xcck001) AND NOT cl_null(g_xcck_m.xcck003) AND NOT cl_null(g_xcck_m.xcck004) AND NOT cl_null(g_xcck_m.xcck005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t  OR g_xcck_m.xcck001 != g_xcck001_t  OR g_xcck_m.xcck003 != g_xcck003_t  OR g_xcck_m.xcck004 != g_xcck004_t  OR g_xcck_m.xcck005 != g_xcck005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck001
            #add-point:BEFORE FIELD xcck001 name="input.b.xcck001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck001
            #add-point:ON CHANGE xcck001 name="input.g.xcck001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcckld
            
            #add-point:AFTER FIELD xcckld name="input.a.xcckld"
            IF NOT cl_null(g_xcck_m.xcckld) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcck_m.xcckld
               #160318-00025#9--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               #160318-00025#9--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_glaald") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_m.xcckld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_m.xcckld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_m.xcckld_desc

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcck_m.xcckld) AND NOT cl_null(g_xcck_m.xcck001) AND NOT cl_null(g_xcck_m.xcck003) AND NOT cl_null(g_xcck_m.xcck004) AND NOT cl_null(g_xcck_m.xcck005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t  OR g_xcck_m.xcck001 != g_xcck001_t  OR g_xcck_m.xcck003 != g_xcck003_t  OR g_xcck_m.xcck004 != g_xcck004_t  OR g_xcck_m.xcck005 != g_xcck005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcckld
            #add-point:BEFORE FIELD xcckld name="input.b.xcckld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcckld
            #add-point:ON CHANGE xcckld name="input.g.xcckld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck004
            #add-point:BEFORE FIELD b_xcck004 name="input.b.b_xcck004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck004
            
            #add-point:AFTER FIELD b_xcck004 name="input.a.b_xcck004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b_xcck004
            #add-point:ON CHANGE b_xcck004 name="input.g.b_xcck004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck005
            #add-point:BEFORE FIELD b_xcck005 name="input.b.b_xcck005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck005
            
            #add-point:AFTER FIELD b_xcck005 name="input.a.b_xcck005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b_xcck005
            #add-point:ON CHANGE b_xcck005 name="input.g.b_xcck005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck003
            
            #add-point:AFTER FIELD xcck003 name="input.a.xcck003"
            IF NOT cl_null(g_xcck_m.xcck003) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcck_m.xcck003
               #160318-00025#9--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00195:sub-01302|axci100|",cl_get_progname("axci100",g_lang,"2"),"|:EXEPROGaxci100"
               #160318-00025#9--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_xcat001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_m.xcck003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_m.xcck003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_m.xcck003_desc

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcck_m.xcckld) AND NOT cl_null(g_xcck_m.xcck001) AND NOT cl_null(g_xcck_m.xcck003) AND NOT cl_null(g_xcck_m.xcck004) AND NOT cl_null(g_xcck_m.xcck005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t  OR g_xcck_m.xcck001 != g_xcck001_t  OR g_xcck_m.xcck003 != g_xcck003_t  OR g_xcck_m.xcck004 != g_xcck004_t  OR g_xcck_m.xcck005 != g_xcck005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck003
            #add-point:BEFORE FIELD xcck003 name="input.b.xcck003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck003
            #add-point:ON CHANGE xcck003 name="input.g.xcck003"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xcckcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcckcomp
            #add-point:ON ACTION controlp INFIELD xcckcomp name="input.c.xcckcomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcck004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck004
            #add-point:ON ACTION controlp INFIELD xcck004 name="input.c.xcck004"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcck005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck005
            #add-point:ON ACTION controlp INFIELD xcck005 name="input.c.xcck005"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcck001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck001
            #add-point:ON ACTION controlp INFIELD xcck001 name="input.c.xcck001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcckld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcckld
            #add-point:ON ACTION controlp INFIELD xcckld name="input.c.xcckld"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcck_m.xcckld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.arg2 = "" #
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xcck_m.xcckld = g_qryparam.return1              

            DISPLAY g_xcck_m.xcckld TO xcckld              #

            NEXT FIELD xcckld                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.b_xcck004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck004
            #add-point:ON ACTION controlp INFIELD b_xcck004 name="input.c.b_xcck004"
            
            #END add-point
 
 
         #Ctrlp:input.c.b_xcck005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck005
            #add-point:ON ACTION controlp INFIELD b_xcck005 name="input.c.b_xcck005"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcck003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck003
            #add-point:ON ACTION controlp INFIELD xcck003 name="input.c.xcck003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcck_m.xcck003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_xcat001()                                #呼叫開窗

            LET g_xcck_m.xcck003 = g_qryparam.return1              

            DISPLAY g_xcck_m.xcck003 TO xcck003              #

            NEXT FIELD xcck003                          #返回原欄位


            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            
            IF s_transaction_chk("N",0) THEN
                CALL s_transaction_begin()
            END IF
            
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
            DISPLAY BY NAME g_xcck_m.xcckld             
                            ,g_xcck_m.xcck001   
                            ,g_xcck_m.xcck003   
                            ,g_xcck_m.xcck004   
                            ,g_xcck_m.xcck005   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL axcq512_xcck_t_mask_restore('restore_mask_o')
            
               UPDATE xcck_t SET (xcckcomp,xcck004,xcck005,xcck001,xcckld,xcck003) = (g_xcck_m.xcckcomp, 
                   g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck001,g_xcck_m.xcckld,g_xcck_m.xcck003) 
 
                WHERE xcckent = g_enterprise AND xcckld = g_xcckld_t
                  AND xcck001 = g_xcck001_t
                  AND xcck003 = g_xcck003_t
                  AND xcck004 = g_xcck004_t
                  AND xcck005 = g_xcck005_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcck_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcck_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcck_m.xcckld
               LET gs_keys_bak[1] = g_xcckld_t
               LET gs_keys[2] = g_xcck_m.xcck001
               LET gs_keys_bak[2] = g_xcck001_t
               LET gs_keys[3] = g_xcck_m.xcck003
               LET gs_keys_bak[3] = g_xcck003_t
               LET gs_keys[4] = g_xcck_m.xcck004
               LET gs_keys_bak[4] = g_xcck004_t
               LET gs_keys[5] = g_xcck_m.xcck005
               LET gs_keys_bak[5] = g_xcck005_t
               LET gs_keys[6] = g_xcck_d[g_detail_idx].xcck002
               LET gs_keys_bak[6] = g_xcck_d_t.xcck002
               LET gs_keys[7] = g_xcck_d[g_detail_idx].xcck006
               LET gs_keys_bak[7] = g_xcck_d_t.xcck006
               LET gs_keys[8] = g_xcck_d[g_detail_idx].xcck007
               LET gs_keys_bak[8] = g_xcck_d_t.xcck007
               LET gs_keys[9] = g_xcck_d[g_detail_idx].xcck008
               LET gs_keys_bak[9] = g_xcck_d_t.xcck008
               LET gs_keys[10] = g_xcck_d[g_detail_idx].xcck009
               LET gs_keys_bak[10] = g_xcck_d_t.xcck009
               CALL axcq512_update_b('xcck_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_xcck_m_t)
                     #LET g_log2 = util.JSON.stringify(g_xcck_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL axcq512_xcck_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axcq512_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_xcckld_t = g_xcck_m.xcckld
           LET g_xcck001_t = g_xcck_m.xcck001
           LET g_xcck003_t = g_xcck_m.xcck003
           LET g_xcck004_t = g_xcck_m.xcck004
           LET g_xcck005_t = g_xcck_m.xcck005
 
           
           IF g_xcck_d.getLength() = 0 THEN
              NEXT FIELD xcck002
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="axcq512.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_xcck_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xcck_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axcq512_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            LET g_current_page = 1
            #add-point:資料輸入前 name="input.body.before_input"
            
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row name="input.body.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq512_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axcq512_cl USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE axcq512_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axcq512_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_xcck_d[l_ac].xcck002 IS NOT NULL
               AND g_xcck_d[l_ac].xcck006 IS NOT NULL
               AND g_xcck_d[l_ac].xcck007 IS NOT NULL
               AND g_xcck_d[l_ac].xcck008 IS NOT NULL
               AND g_xcck_d[l_ac].xcck009 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xcck_d_t.* = g_xcck_d[l_ac].*  #BACKUP
               LET g_xcck_d_o.* = g_xcck_d[l_ac].*  #BACKUP
               CALL axcq512_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL axcq512_set_no_entry_b(l_cmd)
               OPEN axcq512_bcl USING g_enterprise,g_xcck_m.xcckld,
                                                g_xcck_m.xcck001,
                                                g_xcck_m.xcck003,
                                                g_xcck_m.xcck004,
                                                g_xcck_m.xcck005,
 
                                                g_xcck_d_t.xcck002
                                                ,g_xcck_d_t.xcck006
                                                ,g_xcck_d_t.xcck007
                                                ,g_xcck_d_t.xcck008
                                                ,g_xcck_d_t.xcck009
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axcq512_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axcq512_bcl INTO g_xcck_d[l_ac].xccksite,g_xcck_d[l_ac].xcck002,g_xcck_d[l_ac].xcck006, 
                      g_xcck_d[l_ac].xcck007,g_xcck_d[l_ac].xcck008,g_xcck_d[l_ac].xcck009,g_xcck_d[l_ac].xcck013, 
                      g_xcck_d[l_ac].xcck010,g_xcck_d[l_ac].xcck011,g_xcck_d[l_ac].xcck015,g_xcck_d[l_ac].xcck017, 
                      g_xcck_d[l_ac].xcck044,g_xcck_d[l_ac].xcck201,g_xcck_d[l_ac].xcck282a,g_xcck_d[l_ac].xcck282b, 
                      g_xcck_d[l_ac].xcck282c,g_xcck_d[l_ac].xcck282d,g_xcck_d[l_ac].xcck282e,g_xcck_d[l_ac].xcck282f, 
                      g_xcck_d[l_ac].xcck282g,g_xcck_d[l_ac].xcck282h,g_xcck_d[l_ac].xcck282,g_xcck_d[l_ac].xcck202a, 
                      g_xcck_d[l_ac].xcck202b,g_xcck_d[l_ac].xcck202c,g_xcck_d[l_ac].xcck202d,g_xcck_d[l_ac].xcck202e, 
                      g_xcck_d[l_ac].xcck202f,g_xcck_d[l_ac].xcck202g,g_xcck_d[l_ac].xcck202h,g_xcck_d[l_ac].xcck202 
 
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xcck_d_t.xcck002,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xcck_d_mask_o[l_ac].* =  g_xcck_d[l_ac].*
                  CALL axcq512_xcck_t_mask()
                  LET g_xcck_d_mask_n[l_ac].* =  g_xcck_d[l_ac].*
                  
                  CALL axcq512_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            
            #end add-point  
            
 
        
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_xcck_d_t.* TO NULL
            INITIALIZE g_xcck_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xcck_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
            
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_xcck_d_t.* = g_xcck_d[l_ac].*     #新輸入資料
            LET g_xcck_d_o.* = g_xcck_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axcq512_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL axcq512_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xcck_d[li_reproduce_target].* = g_xcck_d[li_reproduce].*
 
               LET g_xcck_d[g_xcck_d.getLength()].xcck002 = NULL
               LET g_xcck_d[g_xcck_d.getLength()].xcck006 = NULL
               LET g_xcck_d[g_xcck_d.getLength()].xcck007 = NULL
               LET g_xcck_d[g_xcck_d.getLength()].xcck008 = NULL
               LET g_xcck_d[g_xcck_d.getLength()].xcck009 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            
            #end add-point  
 
         AFTER INSERT
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
               
            #add-point:單身新增 name="input.body.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM xcck_t 
             WHERE xcckent = g_enterprise AND xcckld = g_xcck_m.xcckld
               AND xcck001 = g_xcck_m.xcck001
               AND xcck003 = g_xcck_m.xcck003
               AND xcck004 = g_xcck_m.xcck004
               AND xcck005 = g_xcck_m.xcck005
 
               AND xcck002 = g_xcck_d[l_ac].xcck002
               AND xcck006 = g_xcck_d[l_ac].xcck006
               AND xcck007 = g_xcck_d[l_ac].xcck007
               AND xcck008 = g_xcck_d[l_ac].xcck008
               AND xcck009 = g_xcck_d[l_ac].xcck009
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO xcck_t
                           (xcckent,
                            xcckcomp,xcck004,xcck005,xcck001,xcckld,xcck003,
                            xcck002,xcck006,xcck007,xcck008,xcck009
                            ,xccksite,xcck013,xcck010,xcck011,xcck015,xcck017,xcck044,xcck201,xcck282a,xcck282b,xcck282c,xcck282d,xcck282e,xcck282f,xcck282g,xcck282h,xcck282,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,xcck202h,xcck202) 
                     VALUES(g_enterprise,
                            g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck001,g_xcck_m.xcckld,g_xcck_m.xcck003,
                            g_xcck_d[l_ac].xcck002,g_xcck_d[l_ac].xcck006,g_xcck_d[l_ac].xcck007,g_xcck_d[l_ac].xcck008, 
                                g_xcck_d[l_ac].xcck009
                            ,g_xcck_d[l_ac].xccksite,g_xcck_d[l_ac].xcck013,g_xcck_d[l_ac].xcck010,g_xcck_d[l_ac].xcck011, 
                                g_xcck_d[l_ac].xcck015,g_xcck_d[l_ac].xcck017,g_xcck_d[l_ac].xcck044, 
                                g_xcck_d[l_ac].xcck201,g_xcck_d[l_ac].xcck282a,g_xcck_d[l_ac].xcck282b, 
                                g_xcck_d[l_ac].xcck282c,g_xcck_d[l_ac].xcck282d,g_xcck_d[l_ac].xcck282e, 
                                g_xcck_d[l_ac].xcck282f,g_xcck_d[l_ac].xcck282g,g_xcck_d[l_ac].xcck282h, 
                                g_xcck_d[l_ac].xcck282,g_xcck_d[l_ac].xcck202a,g_xcck_d[l_ac].xcck202b, 
                                g_xcck_d[l_ac].xcck202c,g_xcck_d[l_ac].xcck202d,g_xcck_d[l_ac].xcck202e, 
                                g_xcck_d[l_ac].xcck202f,g_xcck_d[l_ac].xcck202g,g_xcck_d[l_ac].xcck202h, 
                                g_xcck_d[l_ac].xcck202)
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_xcck_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcck_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cnt
            END IF
            
            #add-point:單身新增後 name="input.body.after_insert"
            
            #end add-point
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   =  -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               IF axcq512_before_delete() THEN 
                  
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_xcck_m.xcckld
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_m.xcck001
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_m.xcck003
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_m.xcck004
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_m.xcck005
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_d_t.xcck002
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_d_t.xcck006
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_d_t.xcck007
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_d_t.xcck008
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_d_t.xcck009
 
 
                  #刪除下層單身
                  IF NOT axcq512_key_delete_b(gs_keys,'xcck_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE axcq512_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axcq512_bcl
               LET l_count = g_xcck_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_xcck_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccksite
            
            #add-point:AFTER FIELD xccksite name="input.a.page1.xccksite"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_d[l_ac].xccksite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_d[l_ac].xccksite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_d[l_ac].xccksite_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccksite
            #add-point:BEFORE FIELD xccksite name="input.b.page1.xccksite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccksite
            #add-point:ON CHANGE xccksite name="input.g.page1.xccksite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck002
            
            #add-point:AFTER FIELD xcck002 name="input.a.page1.xcck002"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcck_m.xcckld IS NOT NULL AND g_xcck_m.xcck001 IS NOT NULL AND g_xcck_m.xcck003 IS NOT NULL AND g_xcck_m.xcck004 IS NOT NULL AND g_xcck_m.xcck005 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck002 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck006 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck007 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck008 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t OR g_xcck_m.xcck001 != g_xcck001_t OR g_xcck_m.xcck003 != g_xcck003_t OR g_xcck_m.xcck004 != g_xcck004_t OR g_xcck_m.xcck005 != g_xcck005_t OR g_xcck_d[g_detail_idx].xcck002 != g_xcck_d_t.xcck002 OR g_xcck_d[g_detail_idx].xcck006 != g_xcck_d_t.xcck006 OR g_xcck_d[g_detail_idx].xcck007 != g_xcck_d_t.xcck007 OR g_xcck_d[g_detail_idx].xcck008 != g_xcck_d_t.xcck008 OR g_xcck_d[g_detail_idx].xcck009 != g_xcck_d_t.xcck009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"' AND "|| "xcck002 = '"||g_xcck_d[g_detail_idx].xcck002 ||"' AND "|| "xcck006 = '"||g_xcck_d[g_detail_idx].xcck006 ||"' AND "|| "xcck007 = '"||g_xcck_d[g_detail_idx].xcck007 ||"' AND "|| "xcck008 = '"||g_xcck_d[g_detail_idx].xcck008 ||"' AND "|| "xcck009 = '"||g_xcck_d[g_detail_idx].xcck009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_d[l_ac].xcck002
            CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_d[l_ac].xcck002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_d[l_ac].xcck002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck002
            #add-point:BEFORE FIELD xcck002 name="input.b.page1.xcck002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck002
            #add-point:ON CHANGE xcck002 name="input.g.page1.xcck002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck006
            #add-point:BEFORE FIELD xcck006 name="input.b.page1.xcck006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck006
            
            #add-point:AFTER FIELD xcck006 name="input.a.page1.xcck006"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcck_m.xcckld IS NOT NULL AND g_xcck_m.xcck001 IS NOT NULL AND g_xcck_m.xcck003 IS NOT NULL AND g_xcck_m.xcck004 IS NOT NULL AND g_xcck_m.xcck005 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck002 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck006 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck007 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck008 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t OR g_xcck_m.xcck001 != g_xcck001_t OR g_xcck_m.xcck003 != g_xcck003_t OR g_xcck_m.xcck004 != g_xcck004_t OR g_xcck_m.xcck005 != g_xcck005_t OR g_xcck_d[g_detail_idx].xcck002 != g_xcck_d_t.xcck002 OR g_xcck_d[g_detail_idx].xcck006 != g_xcck_d_t.xcck006 OR g_xcck_d[g_detail_idx].xcck007 != g_xcck_d_t.xcck007 OR g_xcck_d[g_detail_idx].xcck008 != g_xcck_d_t.xcck008 OR g_xcck_d[g_detail_idx].xcck009 != g_xcck_d_t.xcck009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"' AND "|| "xcck002 = '"||g_xcck_d[g_detail_idx].xcck002 ||"' AND "|| "xcck006 = '"||g_xcck_d[g_detail_idx].xcck006 ||"' AND "|| "xcck007 = '"||g_xcck_d[g_detail_idx].xcck007 ||"' AND "|| "xcck008 = '"||g_xcck_d[g_detail_idx].xcck008 ||"' AND "|| "xcck009 = '"||g_xcck_d[g_detail_idx].xcck009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck006
            #add-point:ON CHANGE xcck006 name="input.g.page1.xcck006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck007
            #add-point:BEFORE FIELD xcck007 name="input.b.page1.xcck007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck007
            
            #add-point:AFTER FIELD xcck007 name="input.a.page1.xcck007"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcck_m.xcckld IS NOT NULL AND g_xcck_m.xcck001 IS NOT NULL AND g_xcck_m.xcck003 IS NOT NULL AND g_xcck_m.xcck004 IS NOT NULL AND g_xcck_m.xcck005 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck002 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck006 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck007 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck008 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t OR g_xcck_m.xcck001 != g_xcck001_t OR g_xcck_m.xcck003 != g_xcck003_t OR g_xcck_m.xcck004 != g_xcck004_t OR g_xcck_m.xcck005 != g_xcck005_t OR g_xcck_d[g_detail_idx].xcck002 != g_xcck_d_t.xcck002 OR g_xcck_d[g_detail_idx].xcck006 != g_xcck_d_t.xcck006 OR g_xcck_d[g_detail_idx].xcck007 != g_xcck_d_t.xcck007 OR g_xcck_d[g_detail_idx].xcck008 != g_xcck_d_t.xcck008 OR g_xcck_d[g_detail_idx].xcck009 != g_xcck_d_t.xcck009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"' AND "|| "xcck002 = '"||g_xcck_d[g_detail_idx].xcck002 ||"' AND "|| "xcck006 = '"||g_xcck_d[g_detail_idx].xcck006 ||"' AND "|| "xcck007 = '"||g_xcck_d[g_detail_idx].xcck007 ||"' AND "|| "xcck008 = '"||g_xcck_d[g_detail_idx].xcck008 ||"' AND "|| "xcck009 = '"||g_xcck_d[g_detail_idx].xcck009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck007
            #add-point:ON CHANGE xcck007 name="input.g.page1.xcck007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck008
            #add-point:BEFORE FIELD xcck008 name="input.b.page1.xcck008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck008
            
            #add-point:AFTER FIELD xcck008 name="input.a.page1.xcck008"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcck_m.xcckld IS NOT NULL AND g_xcck_m.xcck001 IS NOT NULL AND g_xcck_m.xcck003 IS NOT NULL AND g_xcck_m.xcck004 IS NOT NULL AND g_xcck_m.xcck005 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck002 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck006 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck007 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck008 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t OR g_xcck_m.xcck001 != g_xcck001_t OR g_xcck_m.xcck003 != g_xcck003_t OR g_xcck_m.xcck004 != g_xcck004_t OR g_xcck_m.xcck005 != g_xcck005_t OR g_xcck_d[g_detail_idx].xcck002 != g_xcck_d_t.xcck002 OR g_xcck_d[g_detail_idx].xcck006 != g_xcck_d_t.xcck006 OR g_xcck_d[g_detail_idx].xcck007 != g_xcck_d_t.xcck007 OR g_xcck_d[g_detail_idx].xcck008 != g_xcck_d_t.xcck008 OR g_xcck_d[g_detail_idx].xcck009 != g_xcck_d_t.xcck009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"' AND "|| "xcck002 = '"||g_xcck_d[g_detail_idx].xcck002 ||"' AND "|| "xcck006 = '"||g_xcck_d[g_detail_idx].xcck006 ||"' AND "|| "xcck007 = '"||g_xcck_d[g_detail_idx].xcck007 ||"' AND "|| "xcck008 = '"||g_xcck_d[g_detail_idx].xcck008 ||"' AND "|| "xcck009 = '"||g_xcck_d[g_detail_idx].xcck009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck008
            #add-point:ON CHANGE xcck008 name="input.g.page1.xcck008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck009
            #add-point:BEFORE FIELD xcck009 name="input.b.page1.xcck009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck009
            
            #add-point:AFTER FIELD xcck009 name="input.a.page1.xcck009"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcck_m.xcckld IS NOT NULL AND g_xcck_m.xcck001 IS NOT NULL AND g_xcck_m.xcck003 IS NOT NULL AND g_xcck_m.xcck004 IS NOT NULL AND g_xcck_m.xcck005 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck002 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck006 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck007 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck008 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t OR g_xcck_m.xcck001 != g_xcck001_t OR g_xcck_m.xcck003 != g_xcck003_t OR g_xcck_m.xcck004 != g_xcck004_t OR g_xcck_m.xcck005 != g_xcck005_t OR g_xcck_d[g_detail_idx].xcck002 != g_xcck_d_t.xcck002 OR g_xcck_d[g_detail_idx].xcck006 != g_xcck_d_t.xcck006 OR g_xcck_d[g_detail_idx].xcck007 != g_xcck_d_t.xcck007 OR g_xcck_d[g_detail_idx].xcck008 != g_xcck_d_t.xcck008 OR g_xcck_d[g_detail_idx].xcck009 != g_xcck_d_t.xcck009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"' AND "|| "xcck002 = '"||g_xcck_d[g_detail_idx].xcck002 ||"' AND "|| "xcck006 = '"||g_xcck_d[g_detail_idx].xcck006 ||"' AND "|| "xcck007 = '"||g_xcck_d[g_detail_idx].xcck007 ||"' AND "|| "xcck008 = '"||g_xcck_d[g_detail_idx].xcck008 ||"' AND "|| "xcck009 = '"||g_xcck_d[g_detail_idx].xcck009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck009
            #add-point:ON CHANGE xcck009 name="input.g.page1.xcck009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck013
            #add-point:BEFORE FIELD xcck013 name="input.b.page1.xcck013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck013
            
            #add-point:AFTER FIELD xcck013 name="input.a.page1.xcck013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck013
            #add-point:ON CHANGE xcck013 name="input.g.page1.xcck013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck010
            
            #add-point:AFTER FIELD xcck010 name="input.a.page1.xcck010"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_d[l_ac].xcck010
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_d[l_ac].xcck010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_d[l_ac].xcck010_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck010
            #add-point:BEFORE FIELD xcck010 name="input.b.page1.xcck010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck010
            #add-point:ON CHANGE xcck010 name="input.g.page1.xcck010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca066
            #add-point:BEFORE FIELD xrca066 name="input.b.page1.xrca066"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca066
            
            #add-point:AFTER FIELD xrca066 name="input.a.page1.xrca066"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca066
            #add-point:ON CHANGE xrca066 name="input.g.page1.xrca066"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca014
            #add-point:BEFORE FIELD xrca014 name="input.b.page1.xrca014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca014
            
            #add-point:AFTER FIELD xrca014 name="input.a.page1.xrca014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca014
            #add-point:ON CHANGE xrca014 name="input.g.page1.xrca014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imag011
            
            #add-point:AFTER FIELD imag011 name="input.a.page1.imag011"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_d[l_ac].imag011
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND =? ","") RETURNING g_rtn_fields
            LET g_xcck_d[l_ac].imag011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_d[l_ac].imag011_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imag011
            #add-point:BEFORE FIELD imag011 name="input.b.page1.imag011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imag011
            #add-point:ON CHANGE imag011 name="input.g.page1.imag011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca038
            #add-point:BEFORE FIELD xrca038 name="input.b.page1.xrca038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca038
            
            #add-point:AFTER FIELD xrca038 name="input.a.page1.xrca038"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca038
            #add-point:ON CHANGE xrca038 name="input.g.page1.xrca038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl007
            #add-point:BEFORE FIELD xmdl007 name="input.b.page1.xmdl007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl007
            
            #add-point:AFTER FIELD xmdl007 name="input.a.page1.xmdl007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdl007
            #add-point:ON CHANGE xmdl007 name="input.g.page1.xmdl007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdk022
            #add-point:BEFORE FIELD xmdk022 name="input.b.page1.xmdk022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdk022
            
            #add-point:AFTER FIELD xmdk022 name="input.a.page1.xmdk022"
            IF NOT cl_null(g_xcck_d[l_ac].xmdk022) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcck_d[l_ac].xmdk022

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_263") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdk022
            #add-point:ON CHANGE xmdk022 name="input.g.page1.xmdk022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck011
            #add-point:BEFORE FIELD xcck011 name="input.b.page1.xcck011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck011
            
            #add-point:AFTER FIELD xcck011 name="input.a.page1.xcck011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck011
            #add-point:ON CHANGE xcck011 name="input.g.page1.xcck011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck015
            
            #add-point:AFTER FIELD xcck015 name="input.a.page1.xcck015"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck015
            #add-point:BEFORE FIELD xcck015 name="input.b.page1.xcck015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck015
            #add-point:ON CHANGE xcck015 name="input.g.page1.xcck015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck015_desc
            #add-point:BEFORE FIELD xcck015_desc name="input.b.page1.xcck015_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck015_desc
            
            #add-point:AFTER FIELD xcck015_desc name="input.a.page1.xcck015_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck015_desc
            #add-point:ON CHANGE xcck015_desc name="input.g.page1.xcck015_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck017
            #add-point:BEFORE FIELD xcck017 name="input.b.page1.xcck017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck017
            
            #add-point:AFTER FIELD xcck017 name="input.a.page1.xcck017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck017
            #add-point:ON CHANGE xcck017 name="input.g.page1.xcck017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck044
            
            #add-point:AFTER FIELD xcck044 name="input.a.page1.xcck044"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_d[l_ac].xcck044
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_d[l_ac].xcck044_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_d[l_ac].xcck044_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck044
            #add-point:BEFORE FIELD xcck044 name="input.b.page1.xcck044"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck044
            #add-point:ON CHANGE xcck044 name="input.g.page1.xcck044"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck201
            #add-point:BEFORE FIELD xcck201 name="input.b.page1.xcck201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck201
            
            #add-point:AFTER FIELD xcck201 name="input.a.page1.xcck201"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck201
            #add-point:ON CHANGE xcck201 name="input.g.page1.xcck201"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282a
            #add-point:BEFORE FIELD xcck282a name="input.b.page1.xcck282a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282a
            
            #add-point:AFTER FIELD xcck282a name="input.a.page1.xcck282a"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck282a
            #add-point:ON CHANGE xcck282a name="input.g.page1.xcck282a"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282b
            #add-point:BEFORE FIELD xcck282b name="input.b.page1.xcck282b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282b
            
            #add-point:AFTER FIELD xcck282b name="input.a.page1.xcck282b"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck282b
            #add-point:ON CHANGE xcck282b name="input.g.page1.xcck282b"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282c
            #add-point:BEFORE FIELD xcck282c name="input.b.page1.xcck282c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282c
            
            #add-point:AFTER FIELD xcck282c name="input.a.page1.xcck282c"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck282c
            #add-point:ON CHANGE xcck282c name="input.g.page1.xcck282c"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282d
            #add-point:BEFORE FIELD xcck282d name="input.b.page1.xcck282d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282d
            
            #add-point:AFTER FIELD xcck282d name="input.a.page1.xcck282d"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck282d
            #add-point:ON CHANGE xcck282d name="input.g.page1.xcck282d"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282e
            #add-point:BEFORE FIELD xcck282e name="input.b.page1.xcck282e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282e
            
            #add-point:AFTER FIELD xcck282e name="input.a.page1.xcck282e"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck282e
            #add-point:ON CHANGE xcck282e name="input.g.page1.xcck282e"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282f
            #add-point:BEFORE FIELD xcck282f name="input.b.page1.xcck282f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282f
            
            #add-point:AFTER FIELD xcck282f name="input.a.page1.xcck282f"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck282f
            #add-point:ON CHANGE xcck282f name="input.g.page1.xcck282f"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282g
            #add-point:BEFORE FIELD xcck282g name="input.b.page1.xcck282g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282g
            
            #add-point:AFTER FIELD xcck282g name="input.a.page1.xcck282g"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck282g
            #add-point:ON CHANGE xcck282g name="input.g.page1.xcck282g"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282h
            #add-point:BEFORE FIELD xcck282h name="input.b.page1.xcck282h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282h
            
            #add-point:AFTER FIELD xcck282h name="input.a.page1.xcck282h"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck282h
            #add-point:ON CHANGE xcck282h name="input.g.page1.xcck282h"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282
            #add-point:BEFORE FIELD xcck282 name="input.b.page1.xcck282"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282
            
            #add-point:AFTER FIELD xcck282 name="input.a.page1.xcck282"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck282
            #add-point:ON CHANGE xcck282 name="input.g.page1.xcck282"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202a
            #add-point:BEFORE FIELD xcck202a name="input.b.page1.xcck202a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202a
            
            #add-point:AFTER FIELD xcck202a name="input.a.page1.xcck202a"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck202a
            #add-point:ON CHANGE xcck202a name="input.g.page1.xcck202a"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202b
            #add-point:BEFORE FIELD xcck202b name="input.b.page1.xcck202b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202b
            
            #add-point:AFTER FIELD xcck202b name="input.a.page1.xcck202b"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck202b
            #add-point:ON CHANGE xcck202b name="input.g.page1.xcck202b"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202c
            #add-point:BEFORE FIELD xcck202c name="input.b.page1.xcck202c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202c
            
            #add-point:AFTER FIELD xcck202c name="input.a.page1.xcck202c"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck202c
            #add-point:ON CHANGE xcck202c name="input.g.page1.xcck202c"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202d
            #add-point:BEFORE FIELD xcck202d name="input.b.page1.xcck202d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202d
            
            #add-point:AFTER FIELD xcck202d name="input.a.page1.xcck202d"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck202d
            #add-point:ON CHANGE xcck202d name="input.g.page1.xcck202d"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202e
            #add-point:BEFORE FIELD xcck202e name="input.b.page1.xcck202e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202e
            
            #add-point:AFTER FIELD xcck202e name="input.a.page1.xcck202e"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck202e
            #add-point:ON CHANGE xcck202e name="input.g.page1.xcck202e"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202f
            #add-point:BEFORE FIELD xcck202f name="input.b.page1.xcck202f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202f
            
            #add-point:AFTER FIELD xcck202f name="input.a.page1.xcck202f"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck202f
            #add-point:ON CHANGE xcck202f name="input.g.page1.xcck202f"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202g
            #add-point:BEFORE FIELD xcck202g name="input.b.page1.xcck202g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202g
            
            #add-point:AFTER FIELD xcck202g name="input.a.page1.xcck202g"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck202g
            #add-point:ON CHANGE xcck202g name="input.g.page1.xcck202g"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202h
            #add-point:BEFORE FIELD xcck202h name="input.b.page1.xcck202h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202h
            
            #add-point:AFTER FIELD xcck202h name="input.a.page1.xcck202h"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck202h
            #add-point:ON CHANGE xcck202h name="input.g.page1.xcck202h"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202
            #add-point:BEFORE FIELD xcck202 name="input.b.page1.xcck202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202
            
            #add-point:AFTER FIELD xcck202 name="input.a.page1.xcck202"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck202
            #add-point:ON CHANGE xcck202 name="input.g.page1.xcck202"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xccksite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccksite
            #add-point:ON ACTION controlp INFIELD xccksite name="input.c.page1.xccksite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck002
            #add-point:ON ACTION controlp INFIELD xcck002 name="input.c.page1.xcck002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck006
            #add-point:ON ACTION controlp INFIELD xcck006 name="input.c.page1.xcck006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck007
            #add-point:ON ACTION controlp INFIELD xcck007 name="input.c.page1.xcck007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck008
            #add-point:ON ACTION controlp INFIELD xcck008 name="input.c.page1.xcck008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck009
            #add-point:ON ACTION controlp INFIELD xcck009 name="input.c.page1.xcck009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck013
            #add-point:ON ACTION controlp INFIELD xcck013 name="input.c.page1.xcck013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck010
            #add-point:ON ACTION controlp INFIELD xcck010 name="input.c.page1.xcck010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrca066
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca066
            #add-point:ON ACTION controlp INFIELD xrca066 name="input.c.page1.xrca066"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrca014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca014
            #add-point:ON ACTION controlp INFIELD xrca014 name="input.c.page1.xrca014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imag011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imag011
            #add-point:ON ACTION controlp INFIELD imag011 name="input.c.page1.imag011"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcck_d[l_ac].imag011             #給予default值
            LET g_qryparam.default2 = "" #g_xcck_d[l_ac].oocql004 #說明
            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_oocq002()                                #呼叫開窗

            LET g_xcck_d[l_ac].imag011 = g_qryparam.return1              
            #LET g_xcck_d[l_ac].oocql004 = g_qryparam.return2 
            DISPLAY g_xcck_d[l_ac].imag011 TO imag011              #
            #DISPLAY g_xcck_d[l_ac].oocql004 TO oocql004 #說明
            NEXT FIELD imag011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xrca038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca038
            #add-point:ON ACTION controlp INFIELD xrca038 name="input.c.page1.xrca038"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdl007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl007
            #add-point:ON ACTION controlp INFIELD xmdl007 name="input.c.page1.xmdl007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdk022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdk022
            #add-point:ON ACTION controlp INFIELD xmdk022 name="input.c.page1.xmdk022"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcck_d[l_ac].xmdk022             #給予default值
            LET g_qryparam.default2 = "" #g_xcck_d[l_ac].oocql004 #說明
            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_oocq002()                                #呼叫開窗

            LET g_xcck_d[l_ac].xmdk022 = g_qryparam.return1              
            #LET g_xcck_d[l_ac].oocql004 = g_qryparam.return2 
            DISPLAY g_xcck_d[l_ac].xmdk022 TO xmdk022              #
            #DISPLAY g_xcck_d[l_ac].oocql004 TO oocql004 #說明
            NEXT FIELD xmdk022                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck011
            #add-point:ON ACTION controlp INFIELD xcck011 name="input.c.page1.xcck011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck015
            #add-point:ON ACTION controlp INFIELD xcck015 name="input.c.page1.xcck015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck015_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck015_desc
            #add-point:ON ACTION controlp INFIELD xcck015_desc name="input.c.page1.xcck015_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck017
            #add-point:ON ACTION controlp INFIELD xcck017 name="input.c.page1.xcck017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck044
            #add-point:ON ACTION controlp INFIELD xcck044 name="input.c.page1.xcck044"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck201
            #add-point:ON ACTION controlp INFIELD xcck201 name="input.c.page1.xcck201"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck282a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282a
            #add-point:ON ACTION controlp INFIELD xcck282a name="input.c.page1.xcck282a"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck282b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282b
            #add-point:ON ACTION controlp INFIELD xcck282b name="input.c.page1.xcck282b"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck282c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282c
            #add-point:ON ACTION controlp INFIELD xcck282c name="input.c.page1.xcck282c"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck282d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282d
            #add-point:ON ACTION controlp INFIELD xcck282d name="input.c.page1.xcck282d"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck282e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282e
            #add-point:ON ACTION controlp INFIELD xcck282e name="input.c.page1.xcck282e"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck282f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282f
            #add-point:ON ACTION controlp INFIELD xcck282f name="input.c.page1.xcck282f"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck282g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282g
            #add-point:ON ACTION controlp INFIELD xcck282g name="input.c.page1.xcck282g"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck282h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282h
            #add-point:ON ACTION controlp INFIELD xcck282h name="input.c.page1.xcck282h"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck282
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282
            #add-point:ON ACTION controlp INFIELD xcck282 name="input.c.page1.xcck282"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck202a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202a
            #add-point:ON ACTION controlp INFIELD xcck202a name="input.c.page1.xcck202a"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck202b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202b
            #add-point:ON ACTION controlp INFIELD xcck202b name="input.c.page1.xcck202b"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck202c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202c
            #add-point:ON ACTION controlp INFIELD xcck202c name="input.c.page1.xcck202c"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck202d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202d
            #add-point:ON ACTION controlp INFIELD xcck202d name="input.c.page1.xcck202d"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck202e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202e
            #add-point:ON ACTION controlp INFIELD xcck202e name="input.c.page1.xcck202e"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck202f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202f
            #add-point:ON ACTION controlp INFIELD xcck202f name="input.c.page1.xcck202f"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck202g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202g
            #add-point:ON ACTION controlp INFIELD xcck202g name="input.c.page1.xcck202g"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck202h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202h
            #add-point:ON ACTION controlp INFIELD xcck202h name="input.c.page1.xcck202h"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202
            #add-point:ON ACTION controlp INFIELD xcck202 name="input.c.page1.xcck202"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xcck_d[l_ac].* = g_xcck_d_t.*
               CLOSE axcq512_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xcck_d[l_ac].xcck002 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xcck_d[l_ac].* = g_xcck_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL axcq512_xcck_t_mask_restore('restore_mask_o')
         
               UPDATE xcck_t SET (xcckld,xcck001,xcck003,xcck004,xcck005,xccksite,xcck002,xcck006,xcck007, 
                   xcck008,xcck009,xcck013,xcck010,xcck011,xcck015,xcck017,xcck044,xcck201,xcck282a, 
                   xcck282b,xcck282c,xcck282d,xcck282e,xcck282f,xcck282g,xcck282h,xcck282,xcck202a,xcck202b, 
                   xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,xcck202h,xcck202) = (g_xcck_m.xcckld, 
                   g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_d[l_ac].xccksite, 
                   g_xcck_d[l_ac].xcck002,g_xcck_d[l_ac].xcck006,g_xcck_d[l_ac].xcck007,g_xcck_d[l_ac].xcck008, 
                   g_xcck_d[l_ac].xcck009,g_xcck_d[l_ac].xcck013,g_xcck_d[l_ac].xcck010,g_xcck_d[l_ac].xcck011, 
                   g_xcck_d[l_ac].xcck015,g_xcck_d[l_ac].xcck017,g_xcck_d[l_ac].xcck044,g_xcck_d[l_ac].xcck201, 
                   g_xcck_d[l_ac].xcck282a,g_xcck_d[l_ac].xcck282b,g_xcck_d[l_ac].xcck282c,g_xcck_d[l_ac].xcck282d, 
                   g_xcck_d[l_ac].xcck282e,g_xcck_d[l_ac].xcck282f,g_xcck_d[l_ac].xcck282g,g_xcck_d[l_ac].xcck282h, 
                   g_xcck_d[l_ac].xcck282,g_xcck_d[l_ac].xcck202a,g_xcck_d[l_ac].xcck202b,g_xcck_d[l_ac].xcck202c, 
                   g_xcck_d[l_ac].xcck202d,g_xcck_d[l_ac].xcck202e,g_xcck_d[l_ac].xcck202f,g_xcck_d[l_ac].xcck202g, 
                   g_xcck_d[l_ac].xcck202h,g_xcck_d[l_ac].xcck202)
                WHERE xcckent = g_enterprise AND xcckld = g_xcck_m.xcckld 
                 AND xcck001 = g_xcck_m.xcck001 
                 AND xcck003 = g_xcck_m.xcck003 
                 AND xcck004 = g_xcck_m.xcck004 
                 AND xcck005 = g_xcck_m.xcck005 
 
                 AND xcck002 = g_xcck_d_t.xcck002 #項次   
                 AND xcck006 = g_xcck_d_t.xcck006  
                 AND xcck007 = g_xcck_d_t.xcck007  
                 AND xcck008 = g_xcck_d_t.xcck008  
                 AND xcck009 = g_xcck_d_t.xcck009  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcck_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xcck_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcck_m.xcckld
               LET gs_keys_bak[1] = g_xcckld_t
               LET gs_keys[2] = g_xcck_m.xcck001
               LET gs_keys_bak[2] = g_xcck001_t
               LET gs_keys[3] = g_xcck_m.xcck003
               LET gs_keys_bak[3] = g_xcck003_t
               LET gs_keys[4] = g_xcck_m.xcck004
               LET gs_keys_bak[4] = g_xcck004_t
               LET gs_keys[5] = g_xcck_m.xcck005
               LET gs_keys_bak[5] = g_xcck005_t
               LET gs_keys[6] = g_xcck_d[g_detail_idx].xcck002
               LET gs_keys_bak[6] = g_xcck_d_t.xcck002
               LET gs_keys[7] = g_xcck_d[g_detail_idx].xcck006
               LET gs_keys_bak[7] = g_xcck_d_t.xcck006
               LET gs_keys[8] = g_xcck_d[g_detail_idx].xcck007
               LET gs_keys_bak[8] = g_xcck_d_t.xcck007
               LET gs_keys[9] = g_xcck_d[g_detail_idx].xcck008
               LET gs_keys_bak[9] = g_xcck_d_t.xcck008
               LET gs_keys[10] = g_xcck_d[g_detail_idx].xcck009
               LET gs_keys_bak[10] = g_xcck_d_t.xcck009
               CALL axcq512_update_b('xcck_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_xcck_m),util.JSON.stringify(g_xcck_d_t)
                     LET g_log2 = util.JSON.stringify(g_xcck_m),util.JSON.stringify(g_xcck_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axcq512_xcck_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_xcck_m.xcckld
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_m.xcck001
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_m.xcck003
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_m.xcck004
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_m.xcck005
 
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_d_t.xcck002
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_d_t.xcck006
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_d_t.xcck007
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_d_t.xcck008
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_d_t.xcck009
 
               CALL axcq512_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE axcq512_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xcck_d[l_ac].* = g_xcck_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE axcq512_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xcck_d.getLength() = 0 THEN
               NEXT FIELD xcck002
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xcck_d[li_reproduce_target].* = g_xcck_d[li_reproduce].*
 
               LET g_xcck_d[li_reproduce_target].xcck002 = NULL
               LET g_xcck_d[li_reproduce_target].xcck006 = NULL
               LET g_xcck_d[li_reproduce_target].xcck007 = NULL
               LET g_xcck_d[li_reproduce_target].xcck008 = NULL
               LET g_xcck_d[li_reproduce_target].xcck009 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xcck_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xcck_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
 
      
 
      
 
    
      #add-point:input段more_input name="input.more_inputarray"
      
      #end add-point    
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:input段before_dialog name="input.before_dialog"
         
         #end add-point 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD xcckld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xccksite
 
            END CASE
         END IF
   
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controls
         IF g_header_hidden THEN
            CALL gfrm_curr.setElementHidden("vb_master",0)
            CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
            LET g_header_hidden = 0     #visible
         ELSE
            CALL gfrm_curr.setElementHidden("vb_master",1)
            CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
            LET g_header_hidden = 1     #hidden     
         END IF
 
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         LET g_action_choice=""
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
   
   #將畫面指標同步到當下指定的位置上
   CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
 
 
   
   #add-point:input段after_input name="input.after_input"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq512.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axcq512_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_glaa001 LIKE glaa_t.glaa001
   DEFINE l_glaa016 LIKE glaa_t.glaa016
   DEFINE l_glaa020 LIKE glaa_t.glaa020
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL axcq512_b_fill(g_wc2) #第一階單身填充
      CALL axcq512_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axcq512_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   #fengmy 150123----begin
   #根據參數顯示隱藏成本域 和 料件特性
   IF cl_null(g_xcck_m.xcckcomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   ELSE
      CALL cl_get_para(g_enterprise,g_xcck_m.xcckcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_xcck_m.xcckcomp,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   END IF
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xcck002,xcck002_desc',TRUE)                    
   ELSE                            
      CALL cl_set_comp_visible('xcck002,xcck002_desc',FALSE)                
   END IF   
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xcck011',TRUE)                    
   ELSE                       
      CALL cl_set_comp_visible('xcck011',FALSE)                
   END IF 
   #fengmy 150123----end  
   SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_xcck_m.xcckld
      
      
   CASE g_xcck_m.xcck001
      WHEN '1' 
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa001
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_xcck_m.xcck001_desc = '', g_rtn_fields[1] , ''                  
      WHEN '2'
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa016
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_xcck_m.xcck001_desc = '', g_rtn_fields[1] , ''
      WHEN '3'
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa020
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_xcck_m.xcck001_desc = '', g_rtn_fields[1] , ''
   END CASE                             
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck001, 
       g_xcck_m.xcck001_desc,g_xcck_m.xcckld,g_xcck_m.xcckld_desc,g_xcck_m.b_xcck004,g_xcck_m.b_xcck005, 
       g_xcck_m.xcck003,g_xcck_m.xcck003_desc
 
   CALL axcq512_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   #150805-00001#10add
   DISPLAY g_yy1 TO xcck004
   DISPLAY g_mm1 TO xcck005
   DISPLAY g_yy2 TO b_xcck004
   DISPLAY g_mm2 TO b_xcck005
   #150805-00001#10add
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq512.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION axcq512_ref_show()
   #add-point:ref_show段define name="ref_show.define_customerization"
   
   #end add-point 
   DEFINE l_ac_t LIKE type_t.num10 #l_ac暫存用
   #add-point:ref_show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ref_show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="ref_show.pre_function"
   
   #end add-point
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:ref_show段m_reference name="ref_show.head.reference"
   
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_xcck_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
 
      #end add-point
   END FOR
   
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="axcq512.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axcq512_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE xcck_t.xcckld 
   DEFINE l_oldno     LIKE xcck_t.xcckld 
   DEFINE l_newno02     LIKE xcck_t.xcck001 
   DEFINE l_oldno02     LIKE xcck_t.xcck001 
   DEFINE l_newno03     LIKE xcck_t.xcck003 
   DEFINE l_oldno03     LIKE xcck_t.xcck003 
   DEFINE l_newno04     LIKE xcck_t.xcck004 
   DEFINE l_oldno04     LIKE xcck_t.xcck004 
   DEFINE l_newno05     LIKE xcck_t.xcck005 
   DEFINE l_oldno05     LIKE xcck_t.xcck005 
 
   DEFINE l_master    RECORD LIKE xcck_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xcck_t.* #此變數樣板目前無使用
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF     
 
   IF g_xcck_m.xcckld IS NULL
      OR g_xcck_m.xcck001 IS NULL
      OR g_xcck_m.xcck003 IS NULL
      OR g_xcck_m.xcck004 IS NULL
      OR g_xcck_m.xcck005 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_xcckld_t = g_xcck_m.xcckld
   LET g_xcck001_t = g_xcck_m.xcck001
   LET g_xcck003_t = g_xcck_m.xcck003
   LET g_xcck004_t = g_xcck_m.xcck004
   LET g_xcck005_t = g_xcck_m.xcck005
 
   
   LET g_xcck_m.xcckld = ""
   LET g_xcck_m.xcck001 = ""
   LET g_xcck_m.xcck003 = ""
   LET g_xcck_m.xcck004 = ""
   LET g_xcck_m.xcck005 = ""
 
   LET g_master_insert = FALSE
   CALL axcq512_set_entry('a')
   CALL axcq512_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_xcck_m.xcck001_desc = ''
   DISPLAY BY NAME g_xcck_m.xcck001_desc
   LET g_xcck_m.xcckld_desc = ''
   DISPLAY BY NAME g_xcck_m.xcckld_desc
   LET g_xcck_m.xcck003_desc = ''
   DISPLAY BY NAME g_xcck_m.xcck003_desc
 
   
   CALL axcq512_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_xcck_m.* TO NULL
      INITIALIZE g_xcck_d TO NULL
 
      CALL axcq512_show()
      LET INT_FLAG = 0
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN 
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq512_set_act_visible()
   CALL axcq512_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcckld_t = g_xcck_m.xcckld
   LET g_xcck001_t = g_xcck_m.xcck001
   LET g_xcck003_t = g_xcck_m.xcck003
   LET g_xcck004_t = g_xcck_m.xcck004
   LET g_xcck005_t = g_xcck_m.xcck005
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcckent = " ||g_enterprise|| " AND",
                      " xcckld = '", g_xcck_m.xcckld, "' "
                      ," AND xcck001 = '", g_xcck_m.xcck001, "' "
                      ," AND xcck003 = '", g_xcck_m.xcck003, "' "
                      ," AND xcck004 = '", g_xcck_m.xcck004, "' "
                      ," AND xcck005 = '", g_xcck_m.xcck005, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq512_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL axcq512_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL axcq512_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="axcq512.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axcq512_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xcck_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axcq512_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xcck_t
    WHERE xcckent = g_enterprise AND xcckld = g_xcckld_t
    AND xcck001 = g_xcck001_t
    AND xcck003 = g_xcck003_t
    AND xcck004 = g_xcck004_t
    AND xcck005 = g_xcck005_t
 
       INTO TEMP axcq512_detail
   
   #將key修正為調整後   
   UPDATE axcq512_detail 
      #更新key欄位
      SET xcckld = g_xcck_m.xcckld
          , xcck001 = g_xcck_m.xcck001
          , xcck003 = g_xcck_m.xcck003
          , xcck004 = g_xcck_m.xcck004
          , xcck005 = g_xcck_m.xcck005
 
      #更新共用欄位
      
                                       
   #將資料塞回原table   
   INSERT INTO xcck_t SELECT * FROM axcq512_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axcq512_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xcckld_t = g_xcck_m.xcckld
   LET g_xcck001_t = g_xcck_m.xcck001
   LET g_xcck003_t = g_xcck_m.xcck003
   LET g_xcck004_t = g_xcck_m.xcck004
   LET g_xcck005_t = g_xcck_m.xcck005
 
   
   DROP TABLE axcq512_detail
   
END FUNCTION
 
{</section>}
 
{<section id="axcq512.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axcq512_delete()
   #add-point:delete段define name="delete.define_customerization"
   
   #end add-point
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_xcck_m.xcckld IS NULL
   OR g_xcck_m.xcck001 IS NULL
   OR g_xcck_m.xcck003 IS NULL
   OR g_xcck_m.xcck004 IS NULL
   OR g_xcck_m.xcck005 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN axcq512_cl USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq512_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axcq512_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axcq512_master_referesh USING g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004, 
       g_xcck_m.xcck005 INTO g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck001,g_xcck_m.xcckld, 
       g_xcck_m.xcck003,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck001_desc,g_xcck_m.xcckld_desc,g_xcck_m.xcck003_desc 
 
   
   #遮罩相關處理
   LET g_xcck_m_mask_o.* =  g_xcck_m.*
   CALL axcq512_xcck_t_mask()
   LET g_xcck_m_mask_n.* =  g_xcck_m.*
   
   CALL axcq512_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axcq512_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM xcck_t WHERE xcckent = g_enterprise AND xcckld = g_xcck_m.xcckld
                                                               AND xcck001 = g_xcck_m.xcck001
                                                               AND xcck003 = g_xcck_m.xcck003
                                                               AND xcck004 = g_xcck_m.xcck004
                                                               AND xcck005 = g_xcck_m.xcck005
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcck_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
 
      
  
      #add-point:單身刪除後  name="delete.body.a_delete"
      
      #end add-point
      
 
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      #頭先不紀錄
      #IF NOT cl_log_modified_record('','') THEN 
      #   CLOSE axcq512_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_xcck_d.clear() 
 
     
      CALL axcq512_ui_browser_refresh()  
      #CALL axcq512_ui_headershow()  
      #CALL axcq512_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL axcq512_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL axcq512_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE axcq512_cl
 
   #功能已完成,通報訊息中心
   CALL axcq512_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axcq512.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq512_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_sql             STRING
   DEFINE l_xcck202a_sum     LIKE xcck_t.xcck202a
   DEFINE l_xcck202b_sum     LIKE xcck_t.xcck202b
   DEFINE l_xcck202c_sum     LIKE xcck_t.xcck202c
   DEFINE l_xcck202d_sum     LIKE xcck_t.xcck202d
   DEFINE l_xcck202e_sum     LIKE xcck_t.xcck202e
   DEFINE l_xcck202f_sum     LIKE xcck_t.xcck202f
   DEFINE l_xcck202g_sum     LIKE xcck_t.xcck202g
   DEFINE l_xcck202h_sum     LIKE xcck_t.xcck202h
   DEFINE l_xcck202_sum      LIKE xcck_t.xcck202
   DEFINE l_xcck201_sum      LIKE xcck_t.xcck201   #fengmy150703 add
   DEFINE l_xcck202a_total   LIKE xcck_t.xcck202a
   DEFINE l_xcck202b_total   LIKE xcck_t.xcck202b
   DEFINE l_xcck202c_total   LIKE xcck_t.xcck202c
   DEFINE l_xcck202d_total   LIKE xcck_t.xcck202d
   DEFINE l_xcck202e_total   LIKE xcck_t.xcck202e
   DEFINE l_xcck202f_total   LIKE xcck_t.xcck202f
   DEFINE l_xcck202g_total   LIKE xcck_t.xcck202g
   DEFINE l_xcck202h_total   LIKE xcck_t.xcck202h
   DEFINE l_xcck202_total    LIKE xcck_t.xcck202
   DEFINE l_xcck201_total    LIKE xcck_t.xcck201   #fengmy150703 add
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_xcck_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #150805-00001#10add
   CALL axcq512_b_fill_1()
   RETURN
   #150805-00001#10add
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT xccksite,xcck002,xcck006,xcck007,xcck008,xcck009,xcck013,xcck010,xcck011, 
       xcck015,xcck017,xcck044,xcck201,xcck282a,xcck282b,xcck282c,xcck282d,xcck282e,xcck282f,xcck282g, 
       xcck282h,xcck282,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,xcck202h,xcck202, 
       t1.ooefl003 ,t2.xcbfl003 ,t3.imaal003 ,t9.oocal003 FROM xcck_t",   
               "",
               
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=xccksite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN xcbfl_t t2 ON t2.xcbflent="||g_enterprise||" AND t2.xcbfl001=xcck002 AND t2.xcbfl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=xcck010 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t9 ON t9.oocalent="||g_enterprise||" AND t9.oocal001=xcck044 AND t9.oocal002='"||g_dlang||"' ",
 
               " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=? AND xcck004=? AND xcck005=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcck_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
      LET g_sql = "SELECT  UNIQUE xccksite,xcck002,xcck006,xcck007,xcck008,xcck009,xcck013,xcck010,xcck011, 
       xcck015,xcck017,xcck044,xcck201,xcck282a,xcck282b,xcck282c,xcck282d,xcck282e,xcck282f,xcck282g, 
       xcck282h,xcck282,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,xcck202h,xcck202, 
       t1.ooefl003 ,t2.xcbfl003 ,t3.imaal003 ,t6.oocal003 FROM xcck_t",   
               "",
               
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=xccksite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN xcbfl_t t2 ON t2.xcbflent='"||g_enterprise||"' AND t2.xcbfl001=xcck002 AND t2.xcbfl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xcck010 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t6 ON t6.oocalent='"||g_enterprise||"' AND t6.oocal001=xcck044 AND t6.oocal002='"||g_dlang||"' ",
 
               " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=? AND ",g_wc  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcck_t")
   END IF
   
   LET g_sql = g_sql," AND xcck055 IN ('303','305','307','215')"
   LET l_sql = g_sql
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axcq512_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY xcck_t.xcck002,xcck_t.xcck006,xcck_t.xcck007,xcck_t.xcck008,xcck_t.xcck009"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
      LET g_sql = l_sql, " ORDER BY xcck_t.xccksite,xcck_t.xcck002,xcck_t.xcck006,xcck_t.xcck007,xcck_t.xcck008,xcck_t.xcck009"
      LET l_xcck202a_sum = 0
      LET l_xcck202b_sum = 0
      LET l_xcck202c_sum = 0
      LET l_xcck202d_sum = 0
      LET l_xcck202e_sum = 0
      LET l_xcck202f_sum = 0
      LET l_xcck202g_sum = 0
      LET l_xcck202h_sum = 0
      LET l_xcck202_sum  = 0
      LET l_xcck201_sum  = 0
      LET l_xcck202a_total = 0
      LET l_xcck202b_total = 0
      LET l_xcck202c_total = 0
      LET l_xcck202d_total = 0
      LET l_xcck202e_total = 0
      LET l_xcck202f_total = 0
      LET l_xcck202g_total = 0
      LET l_xcck202h_total = 0
      LET l_xcck202_total  = 0
      LET l_xcck201_total  = 0
      LET g_sql_tmp = g_sql  #為insert臨時表用的 #dujuan150324
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axcq512_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axcq512_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004, 
          g_xcck_m.xcck005 INTO g_xcck_d[l_ac].xccksite,g_xcck_d[l_ac].xcck002,g_xcck_d[l_ac].xcck006, 
          g_xcck_d[l_ac].xcck007,g_xcck_d[l_ac].xcck008,g_xcck_d[l_ac].xcck009,g_xcck_d[l_ac].xcck013, 
          g_xcck_d[l_ac].xcck010,g_xcck_d[l_ac].xcck011,g_xcck_d[l_ac].xcck015,g_xcck_d[l_ac].xcck017, 
          g_xcck_d[l_ac].xcck044,g_xcck_d[l_ac].xcck201,g_xcck_d[l_ac].xcck282a,g_xcck_d[l_ac].xcck282b, 
          g_xcck_d[l_ac].xcck282c,g_xcck_d[l_ac].xcck282d,g_xcck_d[l_ac].xcck282e,g_xcck_d[l_ac].xcck282f, 
          g_xcck_d[l_ac].xcck282g,g_xcck_d[l_ac].xcck282h,g_xcck_d[l_ac].xcck282,g_xcck_d[l_ac].xcck202a, 
          g_xcck_d[l_ac].xcck202b,g_xcck_d[l_ac].xcck202c,g_xcck_d[l_ac].xcck202d,g_xcck_d[l_ac].xcck202e, 
          g_xcck_d[l_ac].xcck202f,g_xcck_d[l_ac].xcck202g,g_xcck_d[l_ac].xcck202h,g_xcck_d[l_ac].xcck202, 
          g_xcck_d[l_ac].xccksite_desc,g_xcck_d[l_ac].xcck002_desc,g_xcck_d[l_ac].xcck010_desc,g_xcck_d[l_ac].xcck044_desc  
            #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
         LET g_xcck_d[l_ac].xcck202a = g_xcck_d[l_ac].xcck202a * g_xcck_d[l_ac].xcck009
         LET g_xcck_d[l_ac].xcck202b = g_xcck_d[l_ac].xcck202b * g_xcck_d[l_ac].xcck009
         LET g_xcck_d[l_ac].xcck202c = g_xcck_d[l_ac].xcck202c * g_xcck_d[l_ac].xcck009
         LET g_xcck_d[l_ac].xcck202d = g_xcck_d[l_ac].xcck202d * g_xcck_d[l_ac].xcck009
         LET g_xcck_d[l_ac].xcck202e = g_xcck_d[l_ac].xcck202e * g_xcck_d[l_ac].xcck009
         LET g_xcck_d[l_ac].xcck202f = g_xcck_d[l_ac].xcck202f * g_xcck_d[l_ac].xcck009
         LET g_xcck_d[l_ac].xcck202g = g_xcck_d[l_ac].xcck202g * g_xcck_d[l_ac].xcck009
         LET g_xcck_d[l_ac].xcck202h = g_xcck_d[l_ac].xcck202h * g_xcck_d[l_ac].xcck009
         LET g_xcck_d[l_ac].xcck202  = g_xcck_d[l_ac].xcck202  * g_xcck_d[l_ac].xcck009
         LET g_xcck_d[l_ac].xcck201  = g_xcck_d[l_ac].xcck201  * g_xcck_d[l_ac].xcck009
         
         CALL s_desc_get_stock_desc(g_site,g_xcck_d[l_ac].xcck015) RETURNING g_xcck_d[l_ac].xcck015_desc
 
#成本分群
         SELECT imag011,oocql004 INTO g_xcck_d[l_ac].imag011,g_xcck_d[l_ac].imag011_desc 
           FROM imag_t
           LEFT OUTER JOIN oocql_t ON imagent  = oocqlent AND oocql001 = '206' AND oocql002 = imag011 AND oocql003 = g_dlang
          WHERE imagent  = g_enterprise 
            AND imagsite = g_xcck_m.xcckcomp 
            AND imag001  = g_xcck_d[l_ac].xcck010
            
#部门，销货单-业务部门
         SELECT xmdk004,ooefl003 INTO g_xcck_d[l_ac].xmdk004,g_xcck_d[l_ac].xmdk004_desc
           FROM xmdk_t 
           LEFT OUTER JOIN ooefl_t ON ooeflent = xmdkent AND ooefl001 = xmdk004 AND ooefl002 = g_dlang
          WHERE xmdkent = g_enterprise
            AND xmdkdocno = g_xcck_d[l_ac].xcck006
            
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xcck_d[l_ac].xcck010
         CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xcck_d[l_ac].xcck010_desc = '', g_rtn_fields[1] , ''
         LET g_xcck_d[l_ac].xcck010_desc_1 = '', g_rtn_fields[2] , ''
          
         CALL s_desc_get_unit_desc(g_xcck_d[l_ac].xcck044) RETURNING g_xcck_d[l_ac].xcck044_desc
         
         #依成本域、成本中心小计
         LET l_xcck202a_sum = l_xcck202a_sum + g_xcck_d[l_ac].xcck202a
         LET l_xcck202b_sum = l_xcck202b_sum + g_xcck_d[l_ac].xcck202b
         LET l_xcck202c_sum = l_xcck202c_sum + g_xcck_d[l_ac].xcck202c
         LET l_xcck202d_sum = l_xcck202d_sum + g_xcck_d[l_ac].xcck202d
         LET l_xcck202e_sum = l_xcck202e_sum + g_xcck_d[l_ac].xcck202e
         LET l_xcck202f_sum = l_xcck202f_sum + g_xcck_d[l_ac].xcck202f
         LET l_xcck202g_sum = l_xcck202g_sum + g_xcck_d[l_ac].xcck202g
         LET l_xcck202h_sum = l_xcck202h_sum + g_xcck_d[l_ac].xcck202h
         LET l_xcck202_sum  = l_xcck202_sum  + g_xcck_d[l_ac].xcck202
         LET l_xcck201_sum  = l_xcck201_sum  + g_xcck_d[l_ac].xcck201    #fengmy150703
         LET l_xcck202a_total = l_xcck202a_total + g_xcck_d[l_ac].xcck202a
         LET l_xcck202b_total = l_xcck202b_total + g_xcck_d[l_ac].xcck202b
         LET l_xcck202c_total = l_xcck202c_total + g_xcck_d[l_ac].xcck202c
         LET l_xcck202d_total = l_xcck202d_total + g_xcck_d[l_ac].xcck202d
         LET l_xcck202e_total = l_xcck202e_total + g_xcck_d[l_ac].xcck202e
         LET l_xcck202f_total = l_xcck202f_total + g_xcck_d[l_ac].xcck202f
         LET l_xcck202g_total = l_xcck202g_total + g_xcck_d[l_ac].xcck202g
         LET l_xcck202h_total = l_xcck202h_total + g_xcck_d[l_ac].xcck202h
         LET l_xcck202_total  = l_xcck202_total  + g_xcck_d[l_ac].xcck202
         LET l_xcck201_total  = l_xcck201_total  + g_xcck_d[l_ac].xcck201  #fengmy150703
         IF l_ac > 1 THEN
            IF g_xcck_d[l_ac].xccksite != g_xcck_d[l_ac - 1].xccksite THEN   
               #把当前行下移，并在当前行显示小计
               LET g_xcck_d[l_ac + 1].* = g_xcck_d[l_ac].*  
               INITIALIZE  g_xcck_d[l_ac].* TO NULL              
               #LET g_xcck_d[l_ac].xccksite  = cl_getmsg("axc-00205",g_lang)  #151029-00010#1 151029 By pomelo mark
               LET g_xcck_d[l_ac].xccksite_desc = g_xcck_d[l_ac - 1].xccksite,cl_getmsg("axc-00205",g_lang)  #151029-00010#1 151029 By pomelo add
               LET g_xcck_d[l_ac].xcck202a = l_xcck202a_sum - g_xcck_d[l_ac + 1].xcck202a
               LET g_xcck_d[l_ac].xcck202b = l_xcck202b_sum - g_xcck_d[l_ac + 1].xcck202b
               LET g_xcck_d[l_ac].xcck202c = l_xcck202c_sum - g_xcck_d[l_ac + 1].xcck202c
               LET g_xcck_d[l_ac].xcck202d = l_xcck202d_sum - g_xcck_d[l_ac + 1].xcck202d
               LET g_xcck_d[l_ac].xcck202e = l_xcck202e_sum - g_xcck_d[l_ac + 1].xcck202e
               LET g_xcck_d[l_ac].xcck202f = l_xcck202f_sum - g_xcck_d[l_ac + 1].xcck202f
               LET g_xcck_d[l_ac].xcck202g = l_xcck202g_sum - g_xcck_d[l_ac + 1].xcck202g
               LET g_xcck_d[l_ac].xcck202h = l_xcck202h_sum - g_xcck_d[l_ac + 1].xcck202h
               LET g_xcck_d[l_ac].xcck202  = l_xcck202_sum  - g_xcck_d[l_ac + 1].xcck202
               LET g_xcck_d[l_ac].xcck201  = l_xcck201_sum  - g_xcck_d[l_ac + 1].xcck201   #fengmy150703
               LET l_ac = l_ac + 1
               LET l_xcck202a_sum = g_xcck_d[l_ac].xcck202a
               LET l_xcck202b_sum = g_xcck_d[l_ac].xcck202b
               LET l_xcck202c_sum = g_xcck_d[l_ac].xcck202c
               LET l_xcck202d_sum = g_xcck_d[l_ac].xcck202d
               LET l_xcck202e_sum = g_xcck_d[l_ac].xcck202e
               LET l_xcck202f_sum = g_xcck_d[l_ac].xcck202f
               LET l_xcck202g_sum = g_xcck_d[l_ac].xcck202g
               LET l_xcck202h_sum = g_xcck_d[l_ac].xcck202h
               LET l_xcck202_sum  = g_xcck_d[l_ac].xcck202
               LET l_xcck201_sum  = g_xcck_d[l_ac].xcck201
            END IF
         END IF
               
         #end add-point
      
         #帶出公用欄位reference值
         
         
 
        
         #add-point:單身資料抓取 name="bfill.foreach"
         
         #end add-point
      
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
 
            CALL g_xcck_d.deleteElement(g_xcck_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   #最后一组小计
   #LET g_xcck_d[l_ac].xccksite = cl_getmsg("axc-00205",g_lang)#151029-00010#1 151029 By pomelo mark
   LET g_xcck_d[l_ac].xccksite_desc = g_xcck_d[l_ac - 1].xccksite,cl_getmsg("axc-00205",g_lang)  #151029-00010#1 151029 By pomelo add
   LET g_xcck_d[l_ac].xcck202a = l_xcck202a_sum
   LET g_xcck_d[l_ac].xcck202b = l_xcck202b_sum
   LET g_xcck_d[l_ac].xcck202c = l_xcck202c_sum
   LET g_xcck_d[l_ac].xcck202d = l_xcck202d_sum
   LET g_xcck_d[l_ac].xcck202e = l_xcck202e_sum
   LET g_xcck_d[l_ac].xcck202f = l_xcck202f_sum
   LET g_xcck_d[l_ac].xcck202g = l_xcck202g_sum
   LET g_xcck_d[l_ac].xcck202h = l_xcck202h_sum
   LET g_xcck_d[l_ac].xcck202  = l_xcck202_sum
   LET g_xcck_d[l_ac].xcck201  = l_xcck201_sum
   LET l_ac = l_ac + 1
   #合计
   LET g_xcck_d[l_ac].xccksite = cl_getmsg("axc-00204",g_lang)
   LET g_xcck_d[l_ac].xcck202a = l_xcck202a_total
   LET g_xcck_d[l_ac].xcck202b = l_xcck202b_total
   LET g_xcck_d[l_ac].xcck202c = l_xcck202c_total
   LET g_xcck_d[l_ac].xcck202d = l_xcck202d_total
   LET g_xcck_d[l_ac].xcck202e = l_xcck202e_total
   LET g_xcck_d[l_ac].xcck202f = l_xcck202f_total
   LET g_xcck_d[l_ac].xcck202g = l_xcck202g_total
   LET g_xcck_d[l_ac].xcck202h = l_xcck202h_total
   LET g_xcck_d[l_ac].xcck202  = l_xcck202_total
   LET g_xcck_d[l_ac].xcck201  = l_xcck201_total
   LET l_ac = l_ac + 1
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_xcck_d.getLength()
      LET g_xcck_d_mask_o[l_ac].* =  g_xcck_d[l_ac].*
      CALL axcq512_xcck_t_mask()
      LET g_xcck_d_mask_n[l_ac].* =  g_xcck_d[l_ac].*
   END FOR
   
 
 
   FREE axcq512_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq512.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axcq512_idx_chk()
   #add-point:idx_chk段define name="idx_chk.define_customerization"
   
   #end add-point
   #add-point:idx_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   #判定目前選擇的頁面
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      #確保當下指標的位置未超過上限
      IF g_detail_idx > g_xcck_d.getLength() THEN
         LET g_detail_idx = g_xcck_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_xcck_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xcck_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq512.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq512_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
 
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_xcck_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
 
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axcq512.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION axcq512_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM xcck_t
    WHERE xcckent = g_enterprise AND xcckld = g_xcck_m.xcckld AND
                              xcck001 = g_xcck_m.xcck001 AND
                              xcck003 = g_xcck_m.xcck003 AND
                              xcck004 = g_xcck_m.xcck004 AND
                              xcck005 = g_xcck_m.xcck005 AND
 
          xcck002 = g_xcck_d_t.xcck002
      AND xcck006 = g_xcck_d_t.xcck006
      AND xcck007 = g_xcck_d_t.xcck007
      AND xcck008 = g_xcck_d_t.xcck008
      AND xcck009 = g_xcck_d_t.xcck009
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcck_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE 
   END IF
   
   #add-point:單筆刪除後 name="delete.body.a_single_delete"
   
   #end add-point
 
   LET g_rec_b = g_rec_b-1
   DISPLAY g_rec_b TO FORMONLY.cnt
 
   RETURN TRUE
    
END FUNCTION
 
{</section>}
 
{<section id="axcq512.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axcq512_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define name="delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq512.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axcq512_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define name="insert_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   #add-point:insert_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq512.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axcq512_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define name="update_b.define_customerization"
   
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
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq512.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION axcq512_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_xcck_d[l_ac].xcck002 = g_xcck_d_t.xcck002 
      AND g_xcck_d[l_ac].xcck006 = g_xcck_d_t.xcck006 
      AND g_xcck_d[l_ac].xcck007 = g_xcck_d_t.xcck007 
      AND g_xcck_d[l_ac].xcck008 = g_xcck_d_t.xcck008 
      AND g_xcck_d[l_ac].xcck009 = g_xcck_d_t.xcck009 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq512.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axcq512_key_delete_b(ps_keys_bak,ps_table)
   #add-point:delete_b段define(客製用) name="key_delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table    STRING
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_delete_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_delete_b.pre_function"
   
   #end add-point
   
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axcq512.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axcq512_lock_b(ps_table,ps_page)
   #add-point:lock_b段define name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL axcq512_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq512.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axcq512_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define name="unlock_b.define_customerization"
   
   #end add-point
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
   
 
 
END FUNCTION
 
{</section>}
 
{<section id="axcq512.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axcq512_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xcckld,xcck001,xcck003,xcck004,xcck005",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axcq512.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axcq512_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xcckld,xcck001,xcck003,xcck004,xcck005",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axcq512.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axcq512_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq512.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axcq512_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq512.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axcq512_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq512.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axcq512_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq512.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axcq512_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq512.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axcq512_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq512.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axcq512_default_search()
   #add-point:default_search段define name="default_search.define_customerization"
   
   #end add-point    
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="default_search.pre_function"
   
   #end add-point
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   #add-point:default_search段開始前 name="default_search.before"
 
   #end add-point  
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " xcckld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xcck001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xcck003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " xcck004 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " xcck005 = '", g_argv[05], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   #160113-00011#1-add----(S)
   #法人組織
   IF NOT cl_null(g_argv[06]) THEN
      LET ls_wc = ls_wc, " xcckcomp = '", g_argv[06], "' AND "
   END IF
   #料號
   IF NOT cl_null(g_argv[07]) THEN
      LET ls_wc = ls_wc, " xcck010 = '", g_argv[07], "' AND "
   END IF
   #特性
   IF NOT cl_null(g_argv[08]) THEN
      LET ls_wc = ls_wc, " xcck011 = '", g_argv[08], "' AND "
   END IF
   #批號
   IF NOT cl_null(g_argv[09]) THEN
      LET ls_wc = ls_wc, " xcck017 = '", g_argv[09], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[04]) THEN
      LET g_yy1 = g_argv[04]
      LET g_yy2 = g_argv[04]
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_mm1 = g_argv[05]
      LET g_mm2 = g_argv[05]
   END IF
   #160113-00011#1-add----(E)
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axcq512.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axcq512_fill_chk(ps_idx)
   #add-point:fill_chk段define name="fill_chk.define_customerization"
   
   #end add-point
   DEFINE ps_idx        LIKE type_t.chr10
   DEFINE lst_token     base.StringTokenizer
   DEFINE ls_token      STRING
   #add-point:fill_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fill_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fill_chk.pre_function"
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
   
   #add-point:fill_chk段other name="fill_chk.other"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq512.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION axcq512_modify_detail_chk(ps_record)
   #add-point:modify_detail_chk段define name="modify_detail_chk.define_customerization"
   
   #end add-point
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify_detail_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="modify_detail_chk.before"
   
   #end add-point
   
   CASE ps_record
      WHEN "s_detail1" 
         LET ls_return = "xccksite"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="axcq512.mask_functions" >}
&include "erp/axc/axcq512_mask.4gl"
 
{</section>}
 
{<section id="axcq512.state_change" >}
    
 
{</section>}
 
{<section id="axcq512.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axcq512_set_pk_array()
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
   LET g_pk_array[1].values = g_xcck_m.xcckld
   LET g_pk_array[1].column = 'xcckld'
   LET g_pk_array[2].values = g_xcck_m.xcck001
   LET g_pk_array[2].column = 'xcck001'
   LET g_pk_array[3].values = g_xcck_m.xcck003
   LET g_pk_array[3].column = 'xcck003'
   LET g_pk_array[4].values = g_xcck_m.xcck004
   LET g_pk_array[4].column = 'xcck004'
   LET g_pk_array[5].values = g_xcck_m.xcck005
   LET g_pk_array[5].column = 'xcck005'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axcq512.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axcq512_msgcentre_notify(lc_state)
   #add-point:msgcentre_notify段define name="msgcentre_notify.define_customerization"
   
   #end add-point   
   DEFINE lc_state LIKE type_t.chr80
   #add-point:msgcentre_notify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="msgcentre_notify.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="msgcentre_notify.pre_function"
   
   #end add-point
   
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = lc_state
 
   #PK資料填寫
   CALL axcq512_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xcck_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axcq512.other_function" readonly="Y" >}

#查询时预设条件
PRIVATE FUNCTION axcq512_default()
DEFINE  l_glaa001        LIKE glaa_t.glaa001

   #预设当前site的法人，主账套，年度期别，成本计算类型
   #CALL s_axc_set_site_default() RETURNING g_xcck_m.xcckcomp,g_xcck_m.xcckld,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck003
   #DISPLAY BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcckld,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck003
   #150805-00001#10add
   IF cl_null(g_xcck_m.xcckcomp) AND cl_null(g_xcck_m.xcckld) AND cl_null(g_yy1) AND cl_null(g_mm1) 
             AND cl_null(g_yy2) AND cl_null(g_mm2) AND cl_null(g_xcck_m.xcck003) AND cl_null(g_xcck_m.xcck001) THEN
      CALL s_axc_set_site_default() RETURNING g_xcck_m.xcckcomp,g_xcck_m.xcckld,g_yy2,g_mm2,g_xcck_m.xcck003
      DISPLAY BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcckld,g_xcck_m.xcck003
      LET g_yy1=g_yy2
      LET g_mm1=g_mm2
      DISPLAY g_yy1 TO xcck004
      DISPLAY g_mm1 TO xcck005
      DISPLAY g_yy2 TO b_xcck004
      DISPLAY g_mm2 TO b_xcck005
   END IF
   #150805-00001#10add
   #fengmy 150123----begin
   #根據參數顯示隱藏成本域 和 料件特性
   IF cl_null(g_xcck_m.xcckcomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   ELSE
      CALL cl_get_para(g_enterprise,g_xcck_m.xcckcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_xcck_m.xcckcomp,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   END IF
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xcck002,xcck002_desc',TRUE)                    
   ELSE                            
      CALL cl_set_comp_visible('xcck002,xcck002_desc',FALSE)                
   END IF   
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xcck011',TRUE)                    
   ELSE                       
      CALL cl_set_comp_visible('xcck011',FALSE)                
   END IF 
   #fengmy 150123----end     
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcck_m.xcckcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcck_m.xcckcomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcck_m.xcckcomp_desc 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcck_m.xcckld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcck_m.xcckld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcck_m.xcckld_desc 

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcck_m.xcck003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcck_m.xcck003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcck_m.xcck003_desc
      
   LET g_xcck_m.xcck001 = '1'
   DISPLAY BY NAME g_xcck_m.xcck001
   
   SELECT glaa001 INTO l_glaa001
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_xcck_m.xcckld

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_glaa001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcck_m.xcck001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcck_m.xcck001_desc      
END FUNCTION

################################################################################
# Descriptions...: 描述说明:创建临时表
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者:20150324 By dujuan
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq512_create_temp_table()
   DROP TABLE axcq512_tmp;
    CREATE TEMP TABLE axcq512_tmp(
      xccksite  VARCHAR(10), 
      xccksite_desc  VARCHAR(300), 
      xcck002  VARCHAR(30), 
      xcck002_desc  VARCHAR(300), 
      xcck006  VARCHAR(20), 
      xcck007  INTEGER, 
      xcck008  SMALLINT, 
      xcck009  SMALLINT, 
      xcck013  DATE, 
      xcck010  VARCHAR(40), 
      xcck010_desc  VARCHAR(300), 
      xcck010_desc_1  VARCHAR(300), 
      l_xrca004  VARCHAR(10),          #dorislai-20150918-add----(S)
      l_xrca004_desc  VARCHAR(80),
      l_xmdl003  VARCHAR(20),
      l_xrca015  VARCHAR(10),
      l_xrca015_desc  VARCHAR(500),
      l_xrca066  VARCHAR(20),
      l_xrca014  VARCHAR(255),          #dorislai-20150918-add----(E)
      imag011  VARCHAR(10), 
      imag011_desc  VARCHAR(300), 
      l_xrca038  VARCHAR(20),          #dorislai-20150918-add----(S)
      l_xmdl007_desc  VARCHAR(500),        #add--2015/11/10 By shiun
      l_xrca058_desc  VARCHAR(1000),
      l_xmrdk022   VARCHAR(10),
      l_xmdk024_desc  VARCHAR(1000),
      l_imaa009       VARCHAR(1000),
      l_xrcb024_desc  VARCHAR(10),
      l_xrcb_pmaa007  VARCHAR(10),
      l_xmdk009  VARCHAR(10),
      l_xmdk009_desc  VARCHAR(255),
      l_xmdk_pmaa007  VARCHAR(10),
      l_xmdl050  VARCHAR(500),        #dorislai-20150918-add----(E)
      xmdk004  VARCHAR(10), 
      xmdk004_desc  VARCHAR(300), 
      xcck011  VARCHAR(256), 
      xcck015  VARCHAR(10), 
      xcck015_desc  VARCHAR(300), 
      xcck017  VARCHAR(30),
      xcck044  VARCHAR(10), 
      xcck044_desc  VARCHAR(300), 
      xcck201  DECIMAL(20,6), 
      xcck282a  DECIMAL(20,6), 
      xcck282b  DECIMAL(20,6), 
      xcck282c  DECIMAL(20,6), 
      xcck282d  DECIMAL(20,6), 
      xcck282e  DECIMAL(20,6), 
      xcck282f  DECIMAL(20,6), 
      xcck282g  DECIMAL(20,6),  
      xcck282h  DECIMAL(20,6), 
      xcck282  DECIMAL(20,6), 
      xcck202a  DECIMAL(20,6), 
      xcck202b  DECIMAL(20,6), 
      xcck202c  DECIMAL(20,6), 
      xcck202d  DECIMAL(20,6), 
      xcck202e  DECIMAL(20,6), 
      xcck202f  DECIMAL(20,6), 
      xcck202g  DECIMAL(20,6), 
      xcck202h  DECIMAL(20,6),
      xcck202  DECIMAL(20,6), 
      xcckcomp  VARCHAR(10), 
      xcckcomp_desc  VARCHAR(300), 
      l_xcck004  VARCHAR(10), 
      l_xcck005  VARCHAR(10), 
      xcck001  VARCHAR(1), 
      xcck003  VARCHAR(10), 
      xcckld  VARCHAR(5), 
      xcckld_desc  VARCHAR(300), 
      xcck003_desc  VARCHAR(300), 
      xcck004_desc  VARCHAR(300), 
      xcck005_desc  VARCHAR(300), 
      xcck001_desc  VARCHAR(300), 
      xcck_key  VARCHAR(300)
   );
END FUNCTION

################################################################################
# Descriptions...: 描述说明:临时表加数据
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者:20150324 By dujuan
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq512_get_date()
   DEFINE sr RECORD 
      xccksite LIKE xcck_t.xccksite, 
      xccksite_desc LIKE type_t.chr300, 
      xcck002 LIKE xcck_t.xcck002, 
      xcck002_desc LIKE type_t.chr300, 
      xcck006 LIKE xcck_t.xcck006, 
      xcck007 LIKE xcck_t.xcck007, 
      xcck008 LIKE xcck_t.xcck008, 
      xcck009 LIKE xcck_t.xcck009, 
      xcck013 LIKE xcck_t.xcck013, 
      xcck010 LIKE xcck_t.xcck010, 
      xcck010_desc LIKE type_t.chr300, 
      xcck010_desc_1 LIKE type_t.chr300, 
      l_xrca004 LIKE xrca_t.xrca004,     #dorislai-20150918-add----(S)
      l_xrca004_desc LIKE pmaal_t.pmaal004,
      l_xmdl003 LIKE xmdl_t.xmdl003,
      l_xrca015 LIKE xrca_t.xrca015,
      l_xrca015_desc LIKE ooefl_t.ooefl003,
      l_xrca066 LIKE xrca_t.xrca066,
      l_xrca014 LIKE ooag_t.ooag011,     #dorislai-20150918-add----(E)
      imag011 LIKE imag_t.imag011, 
      imag011_desc LIKE type_t.chr300, 
      l_xrca038 LIKE type_t.chr1000,     #dorislai-20150918-add----(S)
      l_xmdl007_desc LIKE gzcbl_t.gzcbl004,   #add--2015/11/10 By shiun
      l_xrca058_desc LIKE type_t.chr1000,
      l_xmdk022 LIKE xmdk_t.xmdk022,
      l_xmdk024_desc LIKE type_t.chr1000,
      l_imaa009      LIKE type_t.chr1000,
      l_xrcb024_desc LIKE xrcb_t.xrcb024,
      l_xrcb_pmaa007 LIKE pmaa_t.pmaa007,
      l_xmdk009 LIKE xmdk_t.xmdk009,
      l_xmdk009_desc LIKE pmaal_t.pmaal003,
      l_xmdk_pmaa007 LIKE pmaa_t.pmaa007,
      l_xmdl050 LIKE oocql_t.oocql004,   #dorislai-20150918-add----(E)
      xmdk004 LIKE xmdk_t.xmdk004, 
      xmdk004_desc LIKE type_t.chr300, 
      xcck011 LIKE xcck_t.xcck011, 
      xcck015 LIKE xcck_t.xcck015, 
      xcck015_desc LIKE type_t.chr300, 
      xcck017 LIKE xcck_t.xcck017, 
      xcck044 LIKE xcck_t.xcck044, 
      xcck044_desc LIKE type_t.chr300, 
      xcck201 LIKE xcck_t.xcck201, 
      xcck282a LIKE xcck_t.xcck282a, 
      xcck282b LIKE xcck_t.xcck282b, 
      xcck282c LIKE xcck_t.xcck282c, 
      xcck282d LIKE xcck_t.xcck282d, 
      xcck282e LIKE xcck_t.xcck282e, 
      xcck282f LIKE xcck_t.xcck282f, 
      xcck282g LIKE xcck_t.xcck282g, 
      xcck282h LIKE xcck_t.xcck282h, 
      xcck282 LIKE xcck_t.xcck282, 
      xcck202a LIKE xcck_t.xcck202a, 
      xcck202b LIKE xcck_t.xcck202b, 
      xcck202c LIKE xcck_t.xcck202c, 
      xcck202d LIKE xcck_t.xcck202d, 
      xcck202e LIKE xcck_t.xcck202e, 
      xcck202f LIKE xcck_t.xcck202f, 
      xcck202g LIKE xcck_t.xcck202g, 
      xcck202h LIKE xcck_t.xcck202h, 
      xcck202 LIKE xcck_t.xcck202, 
      xcckcomp LIKE xcck_t.xcckcomp, 
      xcckcomp_desc LIKE type_t.chr300, 
      l_xcck004 LIKE type_t.chr10, 
      l_xcck005 LIKE type_t.chr10, 
      xcck001 LIKE xcck_t.xcck001, 
      xcck003 LIKE xcck_t.xcck003, 
      xcckld LIKE xcck_t.xcckld, 
      xcckld_desc LIKE type_t.chr300, 
      xcck003_desc LIKE type_t.chr300, 
      xcck004_desc LIKE type_t.chr300, 
      xcck005_desc LIKE type_t.chr300, 
      xcck001_desc LIKE type_t.chr300, 
      xcck_key LIKE type_t.chr300
    END RECORD
    
    DEFINE l_success  LIKE type_t.num5
    DEFINE l_cnt      LIKE type_t.num5
    DEFINE l_desc     LIKE type_t.chr500  #接說明值 dorislai-20150921-add
    DEFINE l_cnt1     LIKE type_t.num5   #add--2015/11/10 By shiun
    DEFINE l_cnt_str  LIKE type_t.chr10
    
    #刪除臨時表中資料
    DELETE FROM axcq512_tmp
    
    LET l_success = TRUE
#mark--2015/11/10 By shiun--(S)    
#    FOR l_cnt = 1 TO g_browser.getLength()
#      
#      LET sr.xcckld = g_browser[l_cnt].b_xcckld
#      LET sr.xcck001 = g_browser[l_cnt].b_xcck001
#      LET sr.xcck004 = g_browser[l_cnt].b_xcck004
#      LET sr.xcck005 = g_browser[l_cnt].b_xcck005
#      LET sr.xcck003 = g_browser[l_cnt].b_xcck003
#      
#      EXECUTE axcq512_master_referesh USING sr.xcckld,sr.xcck001,sr.xcck003,sr.xcck004,sr.xcck005 
#      #dorislai-20150918-modify----(S)   對應值順序錯誤
##      INTO sr.xcckcomp,sr.xcck004,sr.xcck001,sr.xcckld,sr.xcck005,sr.xcck003,sr.xcckcomp_desc,
##           sr.xcck001_desc,sr.xcckld_desc,sr.xcck003_desc
#      INTO sr.xcckcomp,sr.xcck004,sr.xcck005,sr.xcck001,sr.xcckld,sr.xcck003,sr.xcckcomp_desc,
#           sr.xcck001_desc,sr.xcckld_desc,sr.xcck003_desc
#      #dorislai-20150918-modify----(E)
#      LET sr.xcck004_desc = sr.xcck004
#      LET sr.xcck005_desc = sr.xcck005
#      LET sr.xcck_key = sr.xcckcomp,"-",sr.xcckld,"-",sr.xcck004_desc CLIPPED,"-" CLIPPED,sr.xcck005_desc CLIPPED,"-",sr.xcck001,"-",sr.xcck003 CLIPPED
#      
#      PREPARE axcq512_ins_tmp_pre FROM g_sql_tmp
#      DECLARE axcq512_ins_tmp_cs CURSOR FOR axcq512_ins_tmp_pre
#      
#      #dorislai-20150918-modify----(S)   ?沒那麼多個
##      OPEN axcq512_ins_tmp_cs USING g_enterprise,sr.xcckld,sr.xcck001,sr.xcck003,sr.xcck004,sr.xcck005
##      
##      FOREACH axcq512_ins_tmp_cs INTO sr.xccksite,sr.xcck002,sr.xcck006,sr.xcck007,sr.xcck008,sr.xcck009,sr.xcck013,sr.xcck010, 
##                                      sr.xcck011,sr.xcck015,sr.xcck017,sr.xcck044,sr.xcck201,sr.xcck282a,sr.xcck282b,sr.xcck282c, 
##                                      sr.xcck282d,sr.xcck282e,sr.xcck282f,sr.xcck282g,sr.xcck282h,sr.xcck282,sr.xcck202a,sr.xcck202b,
##                                      sr.xcck202c,sr.xcck202d,sr.xcck202e,sr.xcck202f,sr.xcck202g,sr.xcck202h,sr.xcck202,sr.xccksite_desc, 
##                                      sr.xcck002_desc,sr.xcck010_desc,sr.xcck044_desc        
#      OPEN axcq512_ins_tmp_cs USING g_enterprise,sr.xcckld,sr.xcck001,sr.xcck003
#      FOREACH axcq512_ins_tmp_cs INTO sr.xccksite,sr.xcck002,sr.xcck006,sr.xcck007,sr.xcck008,sr.xcck009,sr.xcck013,sr.xcck010,
#                                      sr.l_xrca004,sr.l_xrca004_desc,sr.l_xmdl003,sr.l_xrca015,sr.l_xrca015_desc,sr.l_xrca066,sr.l_xrca014,      
#                                      sr.xcck011,sr.xcck015,sr.l_xrca038,sr.l_xrca058_desc,sr.l_xmdk022,sr.l_xmdk024_desc,
#                                      sr.l_imaa009,sr.l_xrcb024_desc,sr.l_xrcb_pmaa007,sr.l_xmdk009,sr.l_xmdk009_desc,
#                                      sr.l_xmdk_pmaa007,sr.l_xmdl050,sr.xcck017,sr.xcck044,sr.xcck201,sr.xcck282a,sr.xcck282b,sr.xcck282c,
#                                      sr.xcck282d,sr.xcck282e,sr.xcck282f,sr.xcck282g,sr.xcck282h,sr.xcck282,sr.xcck202a,sr.xcck202b,
#                                      sr.xcck202c,sr.xcck202d,sr.xcck202e,sr.xcck202f,sr.xcck202g,sr.xcck202h,sr.xcck202,sr.xccksite_desc,
#                                      sr.xcck002_desc,sr.xcck010_desc,sr.xcck044_desc 
#      #dorislai-20150918-modify----(E)
#      #dorislai-20150921-add----(S)
#      #銷售分類
#      CALL s_desc_get_acc_desc('295',sr.l_xrca058_desc) RETURNING l_desc
#      CALL axcq512_compose(sr.l_xrca058_desc,l_desc) RETURNING sr.l_xrca058_desc
#      #到達地
#      CALL s_apmi011_location_ref(sr.l_xmdk022,sr.l_xmdk024_desc) RETURNING l_desc
#      CALL axcq512_compose(sr.l_xmdk024_desc,l_desc) RETURNING sr.l_xmdk024_desc
#      #產品分類碼
#      CALL s_desc_get_rtaxl003_desc(sr.l_imaa009) RETURNING l_desc
#      CALL axcq512_compose(sr.l_imaa009,l_desc) RETURNING sr.l_imaa009
#      #區域別
#      CALL s_desc_get_acc_desc('2082',sr.l_xrcb024_desc) RETURNING l_desc
#      CALL axcq512_compose(sr.l_xrcb024_desc,l_desc) RETURNING sr.l_xrcb024_desc
#      #dorislai-20150921-add----(E)
#      CALL s_desc_get_stock_desc(g_site,g_xcck_d[l_ac].xcck015) RETURNING g_xcck_d[l_ac].xcck015_desc
# 
#      #成本分群
#      SELECT imag011,oocql004 INTO sr.imag011,sr.imag011_desc 
#        FROM imag_t
#        LEFT OUTER JOIN oocql_t ON imagent  = oocqlent AND oocql001 = '206' AND oocql002 = imag011 AND oocql003 = g_dlang
#       WHERE imagent  = g_enterprise 
#         AND imagsite = sr.xcckcomp 
#         AND imag001  = sr.xcck010
#            
#      #部门，销货单-业务部门
#      SELECT xmdk004,ooefl003 INTO sr.xmdk004,sr.xmdk004_desc
#        FROM xmdk_t 
#        LEFT OUTER JOIN ooefl_t ON ooeflent = xmdkent AND ooefl001 = xmdk004 AND ooefl002 = g_dlang
#       WHERE xmdkent = g_enterprise
#         AND xmdkdocno = sr.xcck006
#            
#       INITIALIZE g_ref_fields TO NULL
#       LET g_ref_fields[1] = sr.xcck010
#       CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#       LET sr.xcck010_desc = '', g_rtn_fields[1] , ''
#       LET sr.xcck010_desc_1 = '', g_rtn_fields[2] , ''
#
#
#       LET sr.xcck202a = sr.xcck202a * sr.xcck009
#       LET sr.xcck202b = sr.xcck202b * sr.xcck009
#       LET sr.xcck202c = sr.xcck202c * sr.xcck009
#       LET sr.xcck202d = sr.xcck202d * sr.xcck009
#       LET sr.xcck202e = sr.xcck202e * sr.xcck009
#       LET sr.xcck202f = sr.xcck202f * sr.xcck009
#       LET sr.xcck202g = sr.xcck202g * sr.xcck009
#       LET sr.xcck202h = sr.xcck202h * sr.xcck009
#       LET sr.xcck202  = sr.xcck202  * sr.xcck009
#       LET sr.xcck201  = sr.xcck201  * sr.xcck009
#
#mark--2015/11/10 By shiun--(E)
#add--2015/11/10 By shiun--(S)
  #將畫面資料擷取傳至temptable
   FOR l_cnt1 = 1 TO g_rec_b
      
      LET sr.xcckcomp = g_xcck_m.xcckcomp
      LET sr.xcckcomp = g_xcck_m.xcckcomp
      LET sr.l_xcck004  = g_yy1 USING "&&&&","/",g_mm1 USING "&&"
      LET sr.xcck001  = g_xcck_m.xcck001
      LET sr.xcckld   = g_xcck_m.xcckld
      LET sr.l_xcck005  = g_yy2 USING "&&&&","/",g_mm2 USING "&&"
      LET sr.xcck003  = g_xcck_m.xcck003
      
      LET sr.xccksite = g_xcck_d[l_cnt1].xccksite
      LET sr.xcck002 = g_xcck_d[l_cnt1].xcck002
      LET sr.xcck006 = g_xcck_d[l_cnt1].xcck006
      LET sr.xcck007 = g_xcck_d[l_cnt1].xcck007
      LET sr.xcck008 = g_xcck_d[l_cnt1].xcck008
      LET sr.xcck009 = g_xcck_d[l_cnt1].xcck009
      LET sr.xcck013 = g_xcck_d[l_cnt1].xcck013
      LET sr.xcck010 = g_xcck_d[l_cnt1].xcck010
      LET sr.l_xrca004 = g_xcck_d[l_cnt1].xrca004
      LET sr.l_xrca004_desc = g_xcck_d[l_cnt1].xrca004_desc
      LET sr.l_xmdl003 = g_xcck_d[l_cnt1].xmdl003
      LET sr.l_xrca015 = g_xcck_d[l_cnt1].xrca015
      LET sr.l_xrca015_desc = g_xcck_d[l_cnt1].xrca015_desc
      LET sr.l_xrca066 = g_xcck_d[l_cnt1].xrca066
      LET sr.l_xrca014 = g_xcck_d[l_cnt1].xrca014
      LET sr.xcck011 = g_xcck_d[l_cnt1].xcck011
      LET sr.xcck015 = g_xcck_d[l_cnt1].xcck015
      LET sr.l_xrca038 = g_xcck_d[l_cnt1].xrca038
      LET sr.l_xrca058_desc = g_xcck_d[l_cnt1].xrca058_desc
      LET sr.l_xmdk022 = g_xcck_d[l_cnt1].xmdk022
      LET sr.l_xmdk024_desc = g_xcck_d[l_cnt1].xmdk024_desc
      LET sr.l_imaa009 = g_xcck_d[l_cnt1].imaa009
      LET sr.l_xrcb024_desc = g_xcck_d[l_cnt1].xrcb024_desc
      LET sr.l_xrcb_pmaa007 = g_xcck_d[l_cnt1].l_xrcb_pmaa007
      LET sr.l_xmdk009 = g_xcck_d[l_cnt1].xmdk009
      LET sr.l_xmdk009_desc = g_xcck_d[l_cnt1].xmdk009_desc
      LET sr.l_xmdk_pmaa007 = g_xcck_d[l_cnt1].l_xmdk_pmaa007
      LET sr.l_xmdl050 = g_xcck_d[l_cnt1].xmdl050_desc
      LET sr.xcck017 = g_xcck_d[l_cnt1].xcck017
      LET sr.xcck044 = g_xcck_d[l_cnt1].xcck044
      LET sr.xcck201 = g_xcck_d[l_cnt1].xcck201
      LET sr.xcck282a = g_xcck_d[l_cnt1].xcck282a
      LET sr.xcck282b = g_xcck_d[l_cnt1].xcck282b
      LET sr.xcck282c = g_xcck_d[l_cnt1].xcck282c
      LET sr.xcck282d = g_xcck_d[l_cnt1].xcck282d
      LET sr.xcck282e = g_xcck_d[l_cnt1].xcck282e
      LET sr.xcck282f = g_xcck_d[l_cnt1].xcck282f
      LET sr.xcck282g = g_xcck_d[l_cnt1].xcck282g
      LET sr.xcck282h = g_xcck_d[l_cnt1].xcck282h
      LET sr.xcck282 = g_xcck_d[l_cnt1].xcck282
      LET sr.xcck202a = g_xcck_d[l_cnt1].xcck202a
      LET sr.xcck202b = g_xcck_d[l_cnt1].xcck202b
      LET sr.xcck202c = g_xcck_d[l_cnt1].xcck202c
      LET sr.xcck202d = g_xcck_d[l_cnt1].xcck202d
      LET sr.xcck202e = g_xcck_d[l_cnt1].xcck202e
      LET sr.xcck202f = g_xcck_d[l_cnt1].xcck202f
      LET sr.xcck202g = g_xcck_d[l_cnt1].xcck202g
      LET sr.xcck202h = g_xcck_d[l_cnt1].xcck202h
      LET sr.xcck202 = g_xcck_d[l_cnt1].xcck202
      LET sr.xccksite_desc = g_xcck_d[l_cnt1].xccksite_desc
      LET sr.xcck002_desc = g_xcck_d[l_cnt1].xcck002_desc
      LET sr.xcck010_desc = g_xcck_d[l_cnt1].xcck010_desc
      LET sr.xcck044_desc = g_xcck_d[l_cnt1].xcck044_desc
      LET sr.l_xmdl007_desc = g_xcck_d[l_cnt1].xmdl007
      CALL s_desc_gzcbl004_desc('2055',sr.l_xmdl007_desc) RETURNING sr.l_xmdl007_desc
      
      LET l_cnt_str = l_cnt1 USING "&&&&&"
      LET sr.xcck_key = sr.xcckcomp,"-",sr.xcckld,"-",sr.xcck004_desc CLIPPED,"-",
                        sr.xcck005_desc CLIPPED,"-",sr.xcck001,"-",sr.xcck003 CLIPPED,"-",l_cnt_str

#add--2015/11/10 By shiun--(E)
      #dorislai-20160126-add----(S)
      LET sr.imag011 = g_xcck_d[l_cnt1].imag011
      LET sr.imag011_desc = g_xcck_d[l_cnt1].imag011_desc
      #dorislai-20160126-add----(E)
        INSERT INTO axcq512_tmp ( xccksite,xccksite_desc,xcck002,xcck002_desc,xcck006,xcck007,xcck008,xcck009,
                                 xcck013,xcck010,xcck010_desc,xcck010_desc_1,l_xrca004,l_xrca004_desc,l_xmdl003,
                                 l_xrca015,l_xrca015_desc,l_xrca066,l_xrca014,imag011,imag011_desc,l_xrca038,
                                 l_xmdl007_desc,   #add-2015/11/10 By shiun
                                 l_xrca058_desc,l_xmdk024_desc,l_imaa009,l_xrcb024_desc,l_xrcb_pmaa007,
                                 l_xmdk009,l_xmdk009_desc,l_xmdk_pmaa007,l_xmdl050,xmdk004,xmdk004_desc,
                                 xcck011,xcck015,xcck015_desc,xcck017,xcck044,xcck044_desc,xcck201,xcck282a,xcck282b,
                                 xcck282c,xcck282d,xcck282e,xcck282f,xcck282g,xcck282h,xcck282,xcck202a,xcck202b,xcck202c,  
                                 xcck202d,xcck202e,xcck202f,xcck202g,xcck202h,xcck202,xcckcomp,xcckcomp_desc,l_xcck004,l_xcck005,  
                                 xcck001,xcck003,xcckld,xcckld_desc,xcck003_desc,xcck004_desc,xcck005_desc,xcck001_desc,xcck_key)
                        VALUES ( sr.xccksite,sr.xccksite_desc,sr.xcck002,sr.xcck002_desc,sr.xcck006,sr.xcck007,sr.xcck008,
                                 sr.xcck009,sr.xcck013,sr.xcck010,sr.xcck010_desc,sr.xcck010_desc_1,sr.l_xrca004,sr.l_xrca004_desc,
                                 sr.l_xmdl003,sr.l_xrca015,sr.l_xrca015_desc,sr.l_xrca066,sr.l_xrca014,sr.imag011,sr.imag011_desc,
                                 sr.l_xrca038,
                                 sr.l_xmdl007_desc,   #add-2015/11/10 By shiun
                                 sr.l_xrca058_desc,sr.l_xmdk024_desc,sr.l_imaa009,sr.l_xrcb024_desc,sr.l_xrcb_pmaa007,
                                 sr.l_xmdk009,sr.l_xmdk009_desc,sr.l_xmdk_pmaa007,sr.l_xmdl050,sr.xmdk004,sr.xmdk004_desc,sr.xcck011,
                                 sr.xcck015,sr.xcck015_desc,sr.xcck017,sr.xcck044,sr.xcck044_desc,sr.xcck201,sr.xcck282a,sr.xcck282b,
                                 sr.xcck282c,sr.xcck282d,sr.xcck282e,sr.xcck282f,sr.xcck282g,sr.xcck282h,sr.xcck282,sr.xcck202a,
                                 sr.xcck202b,sr.xcck202c,sr.xcck202d,sr.xcck202e,sr.xcck202f,sr.xcck202g,sr.xcck202h,sr.xcck202,
                                 sr.xcckcomp,sr.xcckcomp_desc,sr.l_xcck004,sr.l_xcck005,sr.xcck001,sr.xcck003,sr.xcckld,sr.xcckld_desc,
                                 sr.xcck003_desc,sr.xcck004_desc,sr.xcck005_desc,sr.xcck001_desc,sr.xcck_key)
        #dorislai-20150918modify----(E)
        IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'insert axcq_tmp'
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = FALSE
               CALL cl_err()
               LET l_success = FALSE
          END IF
      
#      END FOREACH
   END FOR
      
      CALL cl_err_collect_show()
      IF l_success = FALSE THEN
        DELETE FROM axcq512_tmp
      END IF
      
#      FREE axcq512_ins_tmp_pre
    
#    END FOR
    
END FUNCTION

################################################################################
# Descriptions...: 替换b_fill
# Date & Author..: #150805-00001#10add
################################################################################
PRIVATE FUNCTION axcq512_b_fill_1()
   DEFINE l_sql             STRING
   DEFINE l_xcck202a_sum     LIKE xcck_t.xcck202a
   DEFINE l_xcck202b_sum     LIKE xcck_t.xcck202b
   DEFINE l_xcck202c_sum     LIKE xcck_t.xcck202c
   DEFINE l_xcck202d_sum     LIKE xcck_t.xcck202d
   DEFINE l_xcck202e_sum     LIKE xcck_t.xcck202e
   DEFINE l_xcck202f_sum     LIKE xcck_t.xcck202f
   DEFINE l_xcck202g_sum     LIKE xcck_t.xcck202g
   DEFINE l_xcck202h_sum     LIKE xcck_t.xcck202h
   DEFINE l_xcck202_sum      LIKE xcck_t.xcck202
   DEFINE l_xcck201_sum      LIKE xcck_t.xcck201   #fengmy150703 add
   #dorilsai-20150925-add----(S)
   DEFINE l_xcck282a_sum     LIKE xcck_t.xcck282a
   DEFINE l_xcck282b_sum     LIKE xcck_t.xcck282b
   DEFINE l_xcck282c_sum     LIKE xcck_t.xcck282c
   DEFINE l_xcck282d_sum     LIKE xcck_t.xcck282d
   DEFINE l_xcck282e_sum     LIKE xcck_t.xcck282e
   DEFINE l_xcck282f_sum     LIKE xcck_t.xcck282f
   DEFINE l_xcck282g_sum     LIKE xcck_t.xcck282g
   DEFINE l_xcck282h_sum     LIKE xcck_t.xcck282h
   DEFINE l_xcck282_sum      LIKE xcck_t.xcck282
   #dorilsai-20150925-add----(E)
   DEFINE l_xcck202a_total   LIKE xcck_t.xcck202a
   DEFINE l_xcck202b_total   LIKE xcck_t.xcck202b
   DEFINE l_xcck202c_total   LIKE xcck_t.xcck202c
   DEFINE l_xcck202d_total   LIKE xcck_t.xcck202d
   DEFINE l_xcck202e_total   LIKE xcck_t.xcck202e
   DEFINE l_xcck202f_total   LIKE xcck_t.xcck202f
   DEFINE l_xcck202g_total   LIKE xcck_t.xcck202g
   DEFINE l_xcck202h_total   LIKE xcck_t.xcck202h
   DEFINE l_xcck202_total    LIKE xcck_t.xcck202
   DEFINE l_xcck201_total    LIKE xcck_t.xcck201   #fengmy150703 add
   #dorilsai-20150925-add----(S)
   DEFINE l_xcck282a_total     LIKE xcck_t.xcck282a
   DEFINE l_xcck282b_total     LIKE xcck_t.xcck282b
   DEFINE l_xcck282c_total     LIKE xcck_t.xcck282c
   DEFINE l_xcck282d_total     LIKE xcck_t.xcck282d
   DEFINE l_xcck282e_total     LIKE xcck_t.xcck282e
   DEFINE l_xcck282f_total     LIKE xcck_t.xcck282f
   DEFINE l_xcck282g_total     LIKE xcck_t.xcck282g
   DEFINE l_xcck282h_total     LIKE xcck_t.xcck282h
   DEFINE l_xcck282_total      LIKE xcck_t.xcck282
   #dorilsai-20150925-add----(E)
   DEFINE l_desc               LIKE type_t.chr500  #接說明值 dorislai-20150921-add
   DEFINE l_xrcastus           LIKE xrca_t.xrcastus#160105-00010 by whitney add
   #160520-00003#1-S
   DEFINE l_xrca058            LIKE type_t.chr500 
   DEFINE l_imaa009            LIKE type_t.chr500
   DEFINE l_xrcb024            LIKE type_t.chr500
   #160520-00003#1-E
   #151130-00003#13-add----(S)
   #增加二次查詢條件
   IF NOT cl_null(g_wc_filter) THEN
      LET g_wc = g_wc CLIPPED," AND ",g_wc_filter
   END IF
   #151130-00003#13-add----(E)
   
   #dorislai-20150918-modify----(S)
#      LET g_sql = "SELECT  UNIQUE xccksite,xcck002,xcck006,xcck007,xcck008,xcck009,xcck013,xcck010,xcck011, 
#       xcck015,xcck017,xcck044,xcck201,xcck282a,xcck282b,xcck282c,xcck282d,xcck282e,xcck282f,xcck282g, 
#       xcck282h,xcck282,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,xcck202h,xcck202, 
#       t1.ooefl003 ,t2.xcbfl003 ,t3.imaal003 ,t6.oocal003 FROM xcck_t",   
#               "",
#               
#                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=xccksite AND t1.ooefl002='"||g_dlang||"' ",
#               " LEFT JOIN xcbfl_t t2 ON t2.xcbflent='"||g_enterprise||"' AND t2.xcbfl001=xcck002 AND t2.xcbfl002='"||g_dlang||"' ",
#               " LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xcck010 AND t3.imaal002='"||g_dlang||"' ",
#               " LEFT JOIN oocal_t t6 ON t6.oocalent='"||g_enterprise||"' AND t6.oocal001=xcck044 AND t6.oocal002='"||g_dlang||"' ",
# 
#               " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=?"  
#160520-00003#2-s mark
#   LET g_sql = "SELECT  UNIQUE xccksite,xcck002,xcck006,xcck007,xcck008,xcck009,xcck013,xcck010,",
#               "xrca004,t7.pmaal004,xmdl003,xrca015,t9.ooefl003,xrca066,t13.ooag011,xcck011,xcck015,xrca038,xrca058,",
#               "xmdk022,xmdk024,imaa009,xrcb024,t11.pmaa007,xmdk009,t8.pmaal003,t12.pmaa007,t10.oocql004,xcck017,",
#               "xcck044,xcck201,xcck282a,xcck282b,xcck282c,xcck282d,xcck282e,xcck282f,xcck282g,xcck282h,",
#               "xcck282,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,xcck202h,xcck202,",
#               "t1.ooefl003,t2.xcbfl003,t3.imaal003,t6.oocal003,xrcastus ",  #160105-00010 by whitney add xrcastus
#               "  FROM xcck_t",   
#               "  LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=xccksite AND t1.ooefl002='"||g_dlang||"' ",
#               "  LEFT JOIN xcbfl_t t2 ON t2.xcbflent='"||g_enterprise||"' AND t2.xcbfl001=xcck002 AND t2.xcbfl002='"||g_dlang||"'  AND t2.xcbflcomp=xcckcomp ",#dorislai-151112-add-" AND t2.xcbflcomp=xcckcomp "
#               "  LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xcck010 AND t3.imaal002='"||g_dlang||"' ",
#               "  LEFT JOIN oocal_t t6 ON t6.oocalent='"||g_enterprise||"' AND t6.oocal001=xcck044 AND t6.oocal002='"||g_dlang||"' ",
#               "  LEFT JOIN xrcb_t ON xrcb_t.xrcbent = xcck_t.xcckent AND xrcb_t.xrcbld = xcck_t.xcckld AND xrcb_t.xrcb002 = xcck_t.xcck006 AND xrcb_t.xrcb003 = xcck_t.xcck007",
#               "  LEFT JOIN xrca_t ON xrca_t.xrcaent = xrcb_t.xrcbent AND xrca_t.xrcald = xrcb_t.xrcbld AND xrca_t.xrcadocno = xrcb_t.xrcbdocno ",
#               "  LEFT JOIN xmdk_t ON xmdk_t.xmdkent = xrcb_t.xrcbent AND xmdk_t.xmdkdocno = xrcb_t.xrcb002 ",
##151201-00016 by whitney modify start
##              "  LEFT JOIN xmdl_t ON xmdl_t.xmdlent = xmdk_t.xmdkent AND xmdl_t.xmdldocno = xmdk_t.xmdkdocno ",
#               #"  LEFT JOIN xmdl_t ON xmdl_t.xmdlent = xmdk_t.xmdkent AND xmdl_t.xmdldocno = xmdk_t.xmdkdocno AND xmdl_t.xmdlseq = xcck_t.xcck007 ",   #160419-00042#1 mark
#               "  LEFT JOIN xmdl_t ON xmdl_t.xmdlent = xcck_t.xcckent AND xmdl_t.xmdldocno = xcck_t.xcck006 AND xmdl_t.xmdlseq = xcck_t.xcck007 ",   #160419-00042#1 add
##151201-00016 by whitney modify end
#               "  LEFT JOIN imaa_t ON imaa_t.imaaent = xcck_t.xcckent AND imaa_t.imaa001 = xcck_t.xcck010 ",
#               "  LEFT JOIN pmaal_t t7 ON t7.pmaalent = '"||g_enterprise||"' AND t7.pmaal001 = xrca_t.xrca004 AND t7.pmaal002 = '"||g_dlang||"' ",
#               "  LEFT JOIN pmaal_t t8 ON t8.pmaalent = '"||g_enterprise||"' AND t8.pmaal001 = xmdk_t.xmdk009 AND t8.pmaal002 = '"||g_dlang||"' ",
#               "  LEFT JOIN ooefl_t t9 ON t9.ooeflent = '"||g_enterprise||"' AND t9.ooefl001 = xrca_t.xrca015 AND t9.ooefl002 = '"||g_dlang||"' ",
#               "  LEFT JOIN oocql_t t10 ON t10.oocqlent = '"||g_enterprise||"' AND t10.oocql001 = '310' AND oocql002 = xmdl_t.xmdl050 AND oocql003='"||g_dlang||"' ",                  
#               "  LEFT JOIN pmaa_t t11 ON t11.pmaaent = xrca_t.xrcaent AND t11.pmaa001 = xrca_t.xrca004 ",
#               "  LEFT JOIN pmaa_t t12 ON t12.pmaaent = xmdk_t.xmdkent AND t12.pmaa001 = xmdk_t.xmdk009 ", 
#               "  LEFT JOIN ooag_t t13 ON t13.ooagent = '"||g_enterprise||"'  AND t13.ooag001 = xrca_t.xrca014 ",            
#               " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=? AND ",g_wc  
#   #dorislai-20150918-modify----(E)
#160520-00003#2-e  mark   
   
#160520-00003#2-s
   LET g_sql = "SELECT  UNIQUE xccksite,xcck002,xcck006,xcck007,xcck008,xcck009,xcck013,xcck010,",
               "xrca004,xmdl003,xrca015,xrca066,xrca014,imag011,xrca038,xmdl007,xrca058,",
               "xmdk022,xmdk024,imaa009,xrcb024,xmdk009,xmdl050_desc,xmdk004,xcck011,xcck015,xcck017,",
               "xcck044,xcck201,xcck282a,xcck282b,xcck282c,xcck282d,xcck282e,xcck282f,xcck282g,xcck282h,",
               "xcck282,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,xcck202h,xcck202,",
               "(SELECT oocql004 FROM oocql_t WHERE oocqlent = '"||g_enterprise||"' AND oocql001 = '206' AND oocql002 = imag011 AND oocql003 = '"||g_dlang||"' ) imag011_desc,",
               "(SELECT ooefl003 FROM ooefl_t WHERE ooefl001 = '"||g_enterprise||"' AND ooefl001 = xmdk004 AND ooefl002 = '"||g_dlang||"' ) xmdk004_desc ,",
               "xccksite_desc,xcck002_desc,xcck010_desc,xcck010_desc_1,xrca004_desc,xrca015_desc,xmdk009_desc,xmdl050_desc,
                xcck015_desc,xcck044_desc,s_xrca058,s_imaa009,s_xrcb024,",
               " xrcastus ",  
               "  FROM ",
               " ( ",
               " SELECT  UNIQUE xccksite,xcck002,xcck006,xcck007,xcck008,xcck009,xcck013,xcck010,",
              #"xrca004,xmdl003,xrca015,xrca066,xrca014,'',xrca038,xrca058,",             ##160523-00041#4 xrca038 --> ' ' #160922-00048#1 mark
              #"xrca004,xmdl003,xrca015,xrca066,xrca014,'' xrca038,xrca058,",             ##160523-00041#4 xrca038 --> ' ' #160922-00048#1 add   #161207-00016#1 mark
               "'' xrca004,xmdl003,'' xrca015,'' xrca066,'' xrca014,'' xrca038,'' xrca058,", ##160523-00041#4 xrca038 --> ' ' #160922-00048#1 add   #161207-00016#1 add
               "xmdk022,xmdk024,imaa009,'' xrcb024,xmdk009,xmdl050,xcck011,xcck015,xcck017,",  #161207-00016#1 mod xrcb024-->''
               "xcck044,(xcck201*xcck009) xcck201,xcck282a,xcck282b,xcck282c,xcck282d,xcck282e,xcck282f,xcck282g,xcck282h,",
               "xcck282,(xcck202a*xcck009) xcck202a,(xcck202b*xcck009) xcck202b,(xcck202c*xcck009) xcck202c,(xcck202d*xcck009) xcck202d,
               (xcck202e*xcck009) xcck202e,(xcck202f*xcck009) xcck202f,(xcck202g*xcck009) xcck202g,(xcck202h*xcck009) xcck202h,(xcck202*xcck009) xcck202,'' xrcastus,",  #161207-00016#1 mod xrcastus-->''
               "(SELECT ooefl003 FROM ooefl_t WHERE ooeflent = xcckent AND ooefl001 = xccksite AND ooefl002 = '"||g_dlang||"') xccksite_desc, ",
               "(SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent = xcckent AND xcbfl001 = xcck002 AND xcbfl002 = '"||g_dlang||"' AND xcbflcomp = xcckcomp) xcck002_desc,",      #160523-00041#4
               "(SELECT imaal003 FROM imaal_t WHERE imaalent = xcckent AND imaal001 = xcck010 AND imaal002 = '"||g_dlang||"') xcck010_desc,",
               "(SELECT imaal004 FROM imaal_t WHERE imaalent = xcckent AND imaal001 = xcck010 AND imaal002 = '"||g_dlang||"') xcck010_desc_1,",
               #"(SELECT pmaal004 FROM pmaal_t WHERE pmaalent = xcckent AND pmaal001 = xrca004 AND pmaal002 = '"||g_dlang||"') xrca004_desc,",  #161207-00016#1 mark
               #"(SELECT ooefl003 FROM ooefl_t WHERE ooeflent = xcckent AND ooefl001 = xrca015 AND ooefl002 = '"||g_dlang||"') xrca015_desc,",  #161207-00016#1 mark
               "(SELECT imag011 FROM imag_t WHERE imagent='"||g_enterprise||"' AND imag001 = xcck010 AND imagsite = xcckcomp) imag011 ,",
               "(SELECT pmaal003 FROM pmaal_t WHERE pmaalent = xmdkent AND pmaal001 = xmdk009 AND pmaal002 = '"||g_dlang||"') xmdk009_desc,",
               "(SELECT oocql004 FROM oocql_t WHERE oocqlent = xmdlent AND oocql001 = '310' AND oocql002 = xmdl050  AND oocql003 = '"||g_dlang||"') xmdl050_desc,",
               "(SELECT xmdk004 FROM xmdk_t WHERE xmdkent = xcckent AND xmdkdocno = xcck006) xmdk004, ",
               "(SELECT UNIQUE xmdl007 FROM xmdl_t WHERE xmdkent = xcckent AND xmdldocno = xcck006 AND xmdlseq = xcck007) xmdl007,",
               "(SELECT inayl003 FROM inayl_t WHERE inaylent = xcckent AND inayl001 = xcck015 AND inayl002 = '"||g_dlang||"') xcck015_desc,",
               "(SELECT oocal003 FROM oocal_t WHERE oocalent = xcckent AND oocal001 = xcck044 AND oocal002 = '"||g_dlang||"') xcck044_desc, ",
               #"(SELECT oocql004 FROM oocql_t WHERE oocqlent = xrcaent AND oocql001 = '295' AND oocql002 = xrca058  AND oocql003 = '"||g_dlang||"') s_xrca058,",  #161207-00016#1 mark
               
               "(SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent = imaaent AND rtaxl001 = imaa009 AND rtaxl002 = '"||g_dlang||"') s_imaa009,",
               #"(SELECT oocql004 FROM oocql_t WHERE oocqlent = t1.xrcaent AND oocql001 = xrcb024 AND oocql002 = '"||g_dlang||"') s_xrcb024",    #160523-00041#4 xrcbent -->xrcaent  #161207-00016#1 mark
               "'' xrca004_desc,'' xrca015_desc,'' s_xrca058,'' s_xrcb024 ",  #161207-00016#1 add

               
               " FROM xcck_t  ",
#161207-00016#1 mark --s
##160523-00041#4#4 --begin
##               "  LEFT JOIN xrcb_t ON xrcb_t.xrcbent = xcck_t.xcckent AND xrcb_t.xrcbld = xcck_t.xcckld AND xrcb_t.xrcb002 = xcck_t.xcck006 AND xrcb_t.xrcb003 = xcck_t.xcck007",
##               "  LEFT JOIN xrca_t ON xrca_t.xrcaent = xrcb_t.xrcbent AND xrca_t.xrcald = xrcb_t.xrcbld AND xrca_t.xrcadocno = xrcb_t.xrcbdocno ",  
#                "  LEFT JOIN (SELECT DISTINCT xrca_t.*,xrcb_t.xrcb002,xrcb_t.xrcb003,xrcb_t.xrcb024 FROM xrca_t,xrcb_t ",
#                "              WHERE xrca_t.xrcaent = xrcb_t.xrcbent AND xrca_t.xrcald = xrcb_t.xrcbld AND xrca_t.xrcadocno = xrcb_t.xrcbdocno AND XRCA001 IN ('12','17','19') AND xrcastus <> 'X') t1 ",   #160705-00007#2 add AND xrcastus <> 'X'
#                "         ON t1.xrcaent = xcck_t.xcckent AND t1.xrcald = xcck_t.xcckld AND t1.xrcb002 = xcck_t.xcck006 AND t1.xrcb003 = xcck_t.xcck007",
##160523-00041#4#4 --end              
#               "  LEFT JOIN xmdk_t ON xmdk_t.xmdkent = t1.xrcaent AND xmdk_t.xmdkdocno = t1.xrcb002 ",         #160523-00041#4#4 xrca_t. >> t1 
#161207-00016#1 mark --e 
               "  LEFT JOIN xmdl_t ON xmdl_t.xmdlent = xcck_t.xcckent AND xmdl_t.xmdldocno = xcck_t.xcck006 AND xmdl_t.xmdlseq = xcck_t.xcck007 ",
               "  LEFT JOIN xmdk_t ON xmdk_t.xmdkent = xmdl_t.xmdlent AND xmdk_t.xmdkdocno = xmdl_t.xmdldocno ",  #161207-00016#1 add
               "  LEFT JOIN imaa_t ON imaa_t.imaaent = xcck_t.xcckent AND imaa_t.imaa001 = xcck_t.xcck010  ",     
                              
               " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=? AND ",g_wc                

#160520-00003#2-e

   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcck_t")
   END IF
   
   LET g_sql = g_sql," AND xcck055 IN ('303','305','307','215')"
   LET g_sql = g_sql," AND (xcck004*12+xcck005 BETWEEN ",g_yy1,"*12+",g_mm1," AND ",g_yy2,"*12+",g_mm2,")"   #wujie 151111
   LET g_sql = g_sql," ) "  #160520-00003#2
   LET l_sql = g_sql
   
   IF axcq512_fill_chk(1) THEN
     #IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN  #150902-00008#1 mark
      IF g_action_choice = 'fetch' OR cl_null(g_action_choice) THEN   #150902-00008#1 mod
         LET g_sql = g_sql, " ORDER BY xcck002,xcck006,xcck007,xcck008,xcck009"
         LET g_sql = l_sql, " ORDER BY xccksite,xcck002,xcck006,xcck007,xcck008,xcck009"
         LET l_xcck202a_sum = 0
         LET l_xcck202b_sum = 0
         LET l_xcck202c_sum = 0
         LET l_xcck202d_sum = 0
         LET l_xcck202e_sum = 0
         LET l_xcck202f_sum = 0
         LET l_xcck202g_sum = 0
         LET l_xcck202h_sum = 0
         LET l_xcck202_sum  = 0
         LET l_xcck201_sum  = 0
         
         LET l_xcck202a_total = 0
         LET l_xcck202b_total = 0
         LET l_xcck202c_total = 0
         LET l_xcck202d_total = 0
         LET l_xcck202e_total = 0
         LET l_xcck202f_total = 0
         LET l_xcck202g_total = 0
         LET l_xcck202h_total = 0
         LET l_xcck202_total  = 0
         LET l_xcck201_total  = 0
         
         LET g_sql_tmp = g_sql  #為insert臨時表用的 #dujuan150324
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axcq512_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR axcq512_pb3
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      LET l_xrcastus = ''  #160105-00010 by whitney add
      
      OPEN b_fill_cs3 USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003
      #dorislai-20150918-modify----(S)                                         
#      FOREACH b_fill_cs3 INTO g_xcck_d[l_ac].xccksite,g_xcck_d[l_ac].xcck002,g_xcck_d[l_ac].xcck006,g_xcck_d[l_ac].xcck007, 
#          g_xcck_d[l_ac].xcck008,g_xcck_d[l_ac].xcck009,g_xcck_d[l_ac].xcck013,g_xcck_d[l_ac].xcck010, 
#          g_xcck_d[l_ac].xcck011,g_xcck_d[l_ac].xcck015,g_xcck_d[l_ac].xcck017,g_xcck_d[l_ac].xcck044, 
#          g_xcck_d[l_ac].xcck201,g_xcck_d[l_ac].xcck282a,g_xcck_d[l_ac].xcck282b,g_xcck_d[l_ac].xcck282c, 
#          g_xcck_d[l_ac].xcck282d,g_xcck_d[l_ac].xcck282e,g_xcck_d[l_ac].xcck282f,g_xcck_d[l_ac].xcck282g, 
#          g_xcck_d[l_ac].xcck282h,g_xcck_d[l_ac].xcck282,g_xcck_d[l_ac].xcck202a,g_xcck_d[l_ac].xcck202b, 
#          g_xcck_d[l_ac].xcck202c,g_xcck_d[l_ac].xcck202d,g_xcck_d[l_ac].xcck202e,g_xcck_d[l_ac].xcck202f, 
#          g_xcck_d[l_ac].xcck202g,g_xcck_d[l_ac].xcck202h,g_xcck_d[l_ac].xcck202,g_xcck_d[l_ac].xccksite_desc, 
#          g_xcck_d[l_ac].xcck002_desc,g_xcck_d[l_ac].xcck010_desc,g_xcck_d[l_ac].xcck044_desc
#160520-00003#2-s
#     FOREACH b_fill_cs3 INTO g_xcck_d[l_ac].xccksite,g_xcck_d[l_ac].xcck002,g_xcck_d[l_ac].xcck006,g_xcck_d[l_ac].xcck007, 
#                             g_xcck_d[l_ac].xcck008,g_xcck_d[l_ac].xcck009,g_xcck_d[l_ac].xcck013,g_xcck_d[l_ac].xcck010, 
#                             g_xcck_d[l_ac].xrca004,g_xcck_d[l_ac].xrca004_desc,g_xcck_d[l_ac].xmdl003,g_xcck_d[l_ac].xrca015,
#                             g_xcck_d[l_ac].xrca015_desc,g_xcck_d[l_ac].xrca066,g_xcck_d[l_ac].xrca014,g_xcck_d[l_ac].xcck011,
#                             g_xcck_d[l_ac].xcck015,g_xcck_d[l_ac].xrca038,g_xcck_d[l_ac].xrca058_desc,g_xcck_d[l_ac].xmdk022,
#                             g_xcck_d[l_ac].xmdk024_desc,g_xcck_d[l_ac].imaa009,g_xcck_d[l_ac].xrcb024_desc,
#                             g_xcck_d[l_ac].l_xrcb_pmaa007,g_xcck_d[l_ac].xmdk009,g_xcck_d[l_ac].xmdk009_desc,
#                             g_xcck_d[l_ac].l_xmdk_pmaa007,g_xcck_d[l_ac].xmdl050_desc,g_xcck_d[l_ac].xcck017,g_xcck_d[l_ac].xcck044,
#                             g_xcck_d[l_ac].xcck201,g_xcck_d[l_ac].xcck282a,g_xcck_d[l_ac].xcck282b,g_xcck_d[l_ac].xcck282c,
#                             g_xcck_d[l_ac].xcck282d,g_xcck_d[l_ac].xcck282e,g_xcck_d[l_ac].xcck282f,g_xcck_d[l_ac].xcck282g,
#                             g_xcck_d[l_ac].xcck282h,g_xcck_d[l_ac].xcck282,g_xcck_d[l_ac].xcck202a,g_xcck_d[l_ac].xcck202b,
#                             g_xcck_d[l_ac].xcck202c,g_xcck_d[l_ac].xcck202d,g_xcck_d[l_ac].xcck202e,g_xcck_d[l_ac].xcck202f,
#                             g_xcck_d[l_ac].xcck202g,g_xcck_d[l_ac].xcck202h,g_xcck_d[l_ac].xcck202,g_xcck_d[l_ac].xccksite_desc,
#                             g_xcck_d[l_ac].xcck002_desc,g_xcck_d[l_ac].xcck010_desc,g_xcck_d[l_ac].xcck044_desc
#                              ,l_xrcastus  #160105-00010 by whitney add



      #160922-00048#1 add start -----
      #LET l_sql = " SELECT xrca038 FROM xrca_t,xrcb_t ",   #161207-00016#1  mark
      LET l_sql = " SELECT unique xrca004,xrca015,xrca066,xrca014,xrca038,xrca058,xrcastus,xrcb024 FROM xrca_t,xrcb_t ", #161207-00016#1 add
                  #"   FROM xrcaent = xrcbent AND xrcald = xrcbld ",   #170309-00040#1 mark
                  "  WHERE xrcaent = xrcbent AND xrcald = xrcbld ",   #170309-00040#1 add
                  "    AND xrcadocno = xrcbdocno AND xrcaent = ? AND xrcbld = ? ",
                  "    AND xrcb002 = ? ",
                  "    AND xrcb003 = ? ",  #161207-00016#1 add
                  #"    AND xrca001 IN ('12','17','19') AND xrcastus <> 'X' "  #161207-00016#1 add  #170309-00040#1 mark
                  "   AND xrcastus <> 'X' "  #170309-00040#1 add
      PREPARE axcq512_xrca038_pre FROM l_sql
      DECLARE axcq512_xrca038_cur SCROLL CURSOR FOR axcq512_xrca038_pre
      #160922-00048#1 add end   -----

      FOREACH b_fill_cs3 INTO g_xcck_d[l_ac].xccksite,g_xcck_d[l_ac].xcck002,g_xcck_d[l_ac].xcck006,g_xcck_d[l_ac].xcck007,
                              g_xcck_d[l_ac].xcck008,g_xcck_d[l_ac].xcck009,g_xcck_d[l_ac].xcck013,g_xcck_d[l_ac].xcck010,
                              g_xcck_d[l_ac].xrca004,g_xcck_d[l_ac].xmdl003,g_xcck_d[l_ac].xrca015,g_xcck_d[l_ac].xrca066,g_xcck_d[l_ac].xrca014,
                              g_xcck_d[l_ac].imag011,g_xcck_d[l_ac].xrca038,g_xcck_d[l_ac].xmdl007,g_xcck_d[l_ac].xrca058_desc,
                              g_xcck_d[l_ac].xmdk022,g_xcck_d[l_ac].xmdk024_desc,g_xcck_d[l_ac].imaa009,g_xcck_d[l_ac].xrcb024_desc,g_xcck_d[l_ac].xmdk009,
                              g_xcck_d[l_ac].xmdl050_desc,g_xcck_d[l_ac].xmdk004,g_xcck_d[l_ac].xcck011,g_xcck_d[l_ac].xcck015,g_xcck_d[l_ac].xcck017,
                              g_xcck_d[l_ac].xcck044,g_xcck_d[l_ac].xcck201,g_xcck_d[l_ac].xcck282a,g_xcck_d[l_ac].xcck282b,g_xcck_d[l_ac].xcck282c,
                              g_xcck_d[l_ac].xcck282d,g_xcck_d[l_ac].xcck282e,g_xcck_d[l_ac].xcck282f,g_xcck_d[l_ac].xcck282g,g_xcck_d[l_ac].xcck282h,
                              g_xcck_d[l_ac].xcck282,g_xcck_d[l_ac].xcck202a,g_xcck_d[l_ac].xcck202b,g_xcck_d[l_ac].xcck202c,g_xcck_d[l_ac].xcck202d,
                              g_xcck_d[l_ac].xcck202e,g_xcck_d[l_ac].xcck202f,g_xcck_d[l_ac].xcck202g,g_xcck_d[l_ac].xcck202h,g_xcck_d[l_ac].xcck202,
                              g_xcck_d[l_ac].imag011_desc,g_xcck_d[l_ac].xmdk004_desc,
                              g_xcck_d[l_ac].xccksite_desc,g_xcck_d[l_ac].xcck002_desc,g_xcck_d[l_ac].xcck010_desc,g_xcck_d[l_ac].xcck010_desc_1,
                              g_xcck_d[l_ac].xrca004_desc,g_xcck_d[l_ac].xrca015_desc,g_xcck_d[l_ac].xmdk009_desc,g_xcck_d[l_ac].xmdl050_desc,
                              g_xcck_d[l_ac].xcck015_desc,g_xcck_d[l_ac].xcck044_desc,
                              l_xrca058,l_imaa009,l_xrcb024,l_xrcastus
#160520-00003#2-e

      #dorislai-20150918-modify----(E)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         #160105-00010 by whitney add start
         IF l_xrcastus = 'X' THEN
            CONTINUE FOREACH
         END IF
         #160105-00010 by whitney add end
         #160520-00003#2-s                    
#         LET g_xcck_d[l_ac].xcck202a = g_xcck_d[l_ac].xcck202a * g_xcck_d[l_ac].xcck009
#         LET g_xcck_d[l_ac].xcck202b = g_xcck_d[l_ac].xcck202b * g_xcck_d[l_ac].xcck009
#         LET g_xcck_d[l_ac].xcck202c = g_xcck_d[l_ac].xcck202c * g_xcck_d[l_ac].xcck009
#         LET g_xcck_d[l_ac].xcck202d = g_xcck_d[l_ac].xcck202d * g_xcck_d[l_ac].xcck009
#         LET g_xcck_d[l_ac].xcck202e = g_xcck_d[l_ac].xcck202e * g_xcck_d[l_ac].xcck009
#         LET g_xcck_d[l_ac].xcck202f = g_xcck_d[l_ac].xcck202f * g_xcck_d[l_ac].xcck009
#         LET g_xcck_d[l_ac].xcck202g = g_xcck_d[l_ac].xcck202g * g_xcck_d[l_ac].xcck009
#         LET g_xcck_d[l_ac].xcck202h = g_xcck_d[l_ac].xcck202h * g_xcck_d[l_ac].xcck009
#         LET g_xcck_d[l_ac].xcck202  = g_xcck_d[l_ac].xcck202  * g_xcck_d[l_ac].xcck009
#         LET g_xcck_d[l_ac].xcck201  = g_xcck_d[l_ac].xcck201  * g_xcck_d[l_ac].xcck009
         #160520-00003#2-e
         
         #160520-00003#2-s
#         CALL s_desc_get_stock_desc(g_site,g_xcck_d[l_ac].xcck015) RETURNING g_xcck_d[l_ac].xcck015_desc
#         #dorislai-20150921-add----(S)
#         #銷售分類
#         CALL s_desc_get_acc_desc('295',g_xcck_d[l_ac].xrca058_desc) RETURNING l_desc
#         CALL axcq512_compose(g_xcck_d[l_ac].xrca058_desc,l_desc) RETURNING g_xcck_d[l_ac].xrca058_desc
         #160520-00003#2-e
         #160922-00048#1 add start -----
          #OPEN axcq512_xrca038_cur USING g_enterprise,g_xcck_m.xcckld,g_xcck_d[l_ac].xcck006  #161207-00016#1 mark
          #FETCH FIRST axcq512_xrca038_cur INTO g_xcck_d[l_ac].xrca038                         #161207-00016#1 mark
          OPEN axcq512_xrca038_cur USING g_enterprise,g_xcck_m.xcckld,g_xcck_d[l_ac].xcck006,g_xcck_d[l_ac].xcck007  #161207-00016#1 add
          FETCH FIRST axcq512_xrca038_cur INTO g_xcck_d[l_ac].xrca004,g_xcck_d[l_ac].xrca015,g_xcck_d[l_ac].xrca066, #161207-00016#1 add
                                               g_xcck_d[l_ac].xrca014,g_xcck_d[l_ac].xrca038,                        #161207-00016#1 add
                                               g_xcck_d[l_ac].xrca058_desc,l_xrcastus,g_xcck_d[l_ac].xrcb024_desc    #161207-00016#1 add
          CLOSE axcq512_xrca038_cur          
         #160922-00048#1 add end   -----
         
         #161207-00016#1 add--s
         SELECT pmaal004 INTO g_xcck_d[l_ac].xrca004_desc FROM pmaal_t
          WHERE pmaalent = g_enterprise AND pmaal001 = g_xcck_d[l_ac].xrca004 AND pmaal002 = g_dlang
         SELECT ooefl003 INTO g_xcck_d[l_ac].xrca015_desc FROM ooefl_t
          WHERE ooeflent = g_enterprise AND ooefl001 = g_xcck_d[l_ac].xrca015 AND ooefl002 = g_dlang
         SELECT oocql004 INTO l_xrca058 FROM oocql_t
          WHERE oocqlent = g_enterprise AND oocql001 = '295' AND oocql002 = g_xcck_d[l_ac].xrca058_desc AND oocql003 = g_dlang
         SELECT oocql004 INTO l_xrcb024 FROM oocql_t
          WHERE oocqlent = g_enterprise AND oocql001 = '287' AND oocql002 = g_xcck_d[l_ac].xrcb024_desc AND oocql003 = g_dlang
         #161207-00016#1 add--e
         
         #到達地
         CALL s_apmi011_location_ref(g_xcck_d[l_ac].xmdk022,g_xcck_d[l_ac].xmdk024_desc) RETURNING l_desc
         CALL axcq512_compose(g_xcck_d[l_ac].xmdk024_desc,l_desc) RETURNING g_xcck_d[l_ac].xmdk024_desc
         #160520-00003#2-s
#         #產品分類碼
#         CALL s_desc_get_rtaxl003_desc(g_xcck_d[l_ac].imaa009) RETURNING l_desc
#         CALL axcq512_compose(g_xcck_d[l_ac].imaa009,l_desc) RETURNING g_xcck_d[l_ac].imaa009
#         #區域別
#         CALL s_desc_get_acc_desc('287',g_xcck_d[l_ac].xrcb024_desc) RETURNING l_desc
#         CALL axcq512_compose(g_xcck_d[l_ac].xrcb024_desc,l_desc) RETURNING g_xcck_d[l_ac].xrcb024_desc
         #160520-00003#2-e
         #dorislai-20150921-add----(E)
         
#160520-00003#2-s         
##成本分群
#         SELECT imag011,oocql004 INTO g_xcck_d[l_ac].imag011,g_xcck_d[l_ac].imag011_desc 
#           FROM imag_t
#           LEFT OUTER JOIN oocql_t ON imagent  = oocqlent AND oocql001 = '206' AND oocql002 = imag011 AND oocql003 = g_dlang
#          WHERE imagent  = g_enterprise 
#            AND imagsite = g_xcck_m.xcckcomp 
#            AND imag001  = g_xcck_d[l_ac].xcck010
#            
##部门，销货单-业务部门
#         SELECT xmdk004,ooefl003 INTO g_xcck_d[l_ac].xmdk004,g_xcck_d[l_ac].xmdk004_desc
#           FROM xmdk_t 
#           LEFT OUTER JOIN ooefl_t ON ooeflent = xmdkent AND ooefl001 = xmdk004 AND ooefl002 = g_dlang
#          WHERE xmdkent = g_enterprise
#            AND xmdkdocno = g_xcck_d[l_ac].xcck006
#            
#         INITIALIZE g_ref_fields TO NULL
#         LET g_ref_fields[1] = g_xcck_d[l_ac].xcck010
#         CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#         LET g_xcck_d[l_ac].xcck010_desc = '', g_rtn_fields[1] , ''
#         LET g_xcck_d[l_ac].xcck010_desc_1 = '', g_rtn_fields[2] , ''
#          
#         CALL s_desc_get_unit_desc(g_xcck_d[l_ac].xcck044) RETURNING g_xcck_d[l_ac].xcck044_desc
#         
#         #add--2015/11/10 By shiun--(S)
#         SELECT xmdl007 INTO g_xcck_d[l_ac].xmdl007
#           FROM xmdl_t
#          WHERE xmdlent = g_enterprise
#           AND xmdldocno = g_xcck_d[l_ac].xcck006
#           AND xmdlseq = g_xcck_d[l_ac].xcck007
         IF NOT cl_null(g_xcck_d[l_ac].imaa009) THEN
            LET g_xcck_d[l_ac].imaa009 = "'",g_xcck_d[l_ac].imaa009,"'",'.',l_imaa009
         ELSE
            LET g_xcck_d[l_ac].imaa009 = ''
         END IF            
         IF NOT cl_null(g_xcck_d[l_ac].xrca058_desc) THEN
            LET g_xcck_d[l_ac].xrca058_desc = "'",g_xcck_d[l_ac].xrca058_desc,"'",'.',l_xrca058
         ELSE
            LET g_xcck_d[l_ac].xrca058_desc = ''         
         END IF
         IF NOT cl_null(g_xcck_d[l_ac].xrcb024_desc) THEN
            LET g_xcck_d[l_ac].xrcb024_desc = "'",g_xcck_d[l_ac].xrcb024_desc,"'",'.',l_xrcb024
         ELSE
            LET g_xcck_d[l_ac].xrcb024_desc = ''          
         END IF   
#160520-00003#2-e
         #add--2015/11/10 By shiun--(E)
         
         #依成本域、成本中心小计
         LET l_xcck202a_sum = l_xcck202a_sum + g_xcck_d[l_ac].xcck202a
         LET l_xcck202b_sum = l_xcck202b_sum + g_xcck_d[l_ac].xcck202b
         LET l_xcck202c_sum = l_xcck202c_sum + g_xcck_d[l_ac].xcck202c
         LET l_xcck202d_sum = l_xcck202d_sum + g_xcck_d[l_ac].xcck202d
         LET l_xcck202e_sum = l_xcck202e_sum + g_xcck_d[l_ac].xcck202e
         LET l_xcck202f_sum = l_xcck202f_sum + g_xcck_d[l_ac].xcck202f
         LET l_xcck202g_sum = l_xcck202g_sum + g_xcck_d[l_ac].xcck202g
         LET l_xcck202h_sum = l_xcck202h_sum + g_xcck_d[l_ac].xcck202h
         LET l_xcck202_sum  = l_xcck202_sum  + g_xcck_d[l_ac].xcck202
         LET l_xcck201_sum  = l_xcck201_sum  + g_xcck_d[l_ac].xcck201    #fengmy150703

         LET l_xcck202a_total = l_xcck202a_total + g_xcck_d[l_ac].xcck202a
         LET l_xcck202b_total = l_xcck202b_total + g_xcck_d[l_ac].xcck202b
         LET l_xcck202c_total = l_xcck202c_total + g_xcck_d[l_ac].xcck202c
         LET l_xcck202d_total = l_xcck202d_total + g_xcck_d[l_ac].xcck202d
         LET l_xcck202e_total = l_xcck202e_total + g_xcck_d[l_ac].xcck202e
         LET l_xcck202f_total = l_xcck202f_total + g_xcck_d[l_ac].xcck202f
         LET l_xcck202g_total = l_xcck202g_total + g_xcck_d[l_ac].xcck202g
         LET l_xcck202h_total = l_xcck202h_total + g_xcck_d[l_ac].xcck202h
         LET l_xcck202_total  = l_xcck202_total  + g_xcck_d[l_ac].xcck202
         LET l_xcck201_total  = l_xcck201_total  + g_xcck_d[l_ac].xcck201  #fengmy150703
         IF l_ac > 1 THEN
            IF g_xcck_d[l_ac].xccksite != g_xcck_d[l_ac - 1].xccksite THEN   
               #把当前行下移，并在当前行显示小计
               LET g_xcck_d[l_ac + 1].* = g_xcck_d[l_ac].*  
               INITIALIZE  g_xcck_d[l_ac].* TO NULL              
               #LET g_xcck_d[l_ac].xccksite  = cl_getmsg("axc-00205",g_lang)#151029-00010#1 151029 By pomelo mark
               LET g_xcck_d[l_ac].xccksite_desc = g_xcck_d[l_ac - 1].xccksite,cl_getmsg("axc-00205",g_lang)  #151029-00010#1 151029 By pomelo add
               LET g_xcck_d[l_ac].xcck202a = l_xcck202a_sum - g_xcck_d[l_ac + 1].xcck202a
               LET g_xcck_d[l_ac].xcck202b = l_xcck202b_sum - g_xcck_d[l_ac + 1].xcck202b
               LET g_xcck_d[l_ac].xcck202c = l_xcck202c_sum - g_xcck_d[l_ac + 1].xcck202c
               LET g_xcck_d[l_ac].xcck202d = l_xcck202d_sum - g_xcck_d[l_ac + 1].xcck202d
               LET g_xcck_d[l_ac].xcck202e = l_xcck202e_sum - g_xcck_d[l_ac + 1].xcck202e
               LET g_xcck_d[l_ac].xcck202f = l_xcck202f_sum - g_xcck_d[l_ac + 1].xcck202f
               LET g_xcck_d[l_ac].xcck202g = l_xcck202g_sum - g_xcck_d[l_ac + 1].xcck202g
               LET g_xcck_d[l_ac].xcck202h = l_xcck202h_sum - g_xcck_d[l_ac + 1].xcck202h
               LET g_xcck_d[l_ac].xcck202  = l_xcck202_sum  - g_xcck_d[l_ac + 1].xcck202
               LET g_xcck_d[l_ac].xcck201  = l_xcck201_sum  - g_xcck_d[l_ac + 1].xcck201   #fengmy150703
               LET l_ac = l_ac + 1
               LET l_xcck202a_sum = g_xcck_d[l_ac].xcck202a
               LET l_xcck202b_sum = g_xcck_d[l_ac].xcck202b
               LET l_xcck202c_sum = g_xcck_d[l_ac].xcck202c
               LET l_xcck202d_sum = g_xcck_d[l_ac].xcck202d
               LET l_xcck202e_sum = g_xcck_d[l_ac].xcck202e
               LET l_xcck202f_sum = g_xcck_d[l_ac].xcck202f
               LET l_xcck202g_sum = g_xcck_d[l_ac].xcck202g
               LET l_xcck202h_sum = g_xcck_d[l_ac].xcck202h
               LET l_xcck202_sum  = g_xcck_d[l_ac].xcck202
               LET l_xcck201_sum  = g_xcck_d[l_ac].xcck201
            END IF
         END IF
       
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
 
            CALL g_xcck_d.deleteElement(g_xcck_d.getLength())
       
   END IF
   #151130-00003#14-add-'l_ac>1 判斷'
   #增加l_ac 的判斷，避免二次查詢查不到資料時，程式整個關閉
   IF l_ac > 1 THEN #151130-00003#14-add

   
      #LET g_xcck_d[l_ac].xccksite = cl_getmsg("axc-00205",g_lang)#151029-00010#1 151029 By pomelo mark
      LET g_xcck_d[l_ac].xccksite_desc = g_xcck_d[l_ac - 1].xccksite,cl_getmsg("axc-00205",g_lang)  #151029-00010#1 151029 By pomelo add
      LET g_xcck_d[l_ac].xcck202a = l_xcck202a_sum
      LET g_xcck_d[l_ac].xcck202b = l_xcck202b_sum
      LET g_xcck_d[l_ac].xcck202c = l_xcck202c_sum
      LET g_xcck_d[l_ac].xcck202d = l_xcck202d_sum
      LET g_xcck_d[l_ac].xcck202e = l_xcck202e_sum
      LET g_xcck_d[l_ac].xcck202f = l_xcck202f_sum
      LET g_xcck_d[l_ac].xcck202g = l_xcck202g_sum
      LET g_xcck_d[l_ac].xcck202h = l_xcck202h_sum
      LET g_xcck_d[l_ac].xcck202  = l_xcck202_sum
      LET g_xcck_d[l_ac].xcck201  = l_xcck201_sum
      LET l_ac = l_ac + 1
      #合计
      LET g_xcck_d[l_ac].xccksite = cl_getmsg("axc-00204",g_lang)
      LET g_xcck_d[l_ac].xcck202a = l_xcck202a_total
      LET g_xcck_d[l_ac].xcck202b = l_xcck202b_total
      LET g_xcck_d[l_ac].xcck202c = l_xcck202c_total
      LET g_xcck_d[l_ac].xcck202d = l_xcck202d_total
      LET g_xcck_d[l_ac].xcck202e = l_xcck202e_total
      LET g_xcck_d[l_ac].xcck202f = l_xcck202f_total
      LET g_xcck_d[l_ac].xcck202g = l_xcck202g_total
      LET g_xcck_d[l_ac].xcck202h = l_xcck202h_total
      LET g_xcck_d[l_ac].xcck202  = l_xcck202_total
      LET g_xcck_d[l_ac].xcck201  = l_xcck201_total
   END IF #151130-00003#14-add
   LET l_ac = l_ac + 1
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_xcck_d.getLength()
      LET g_xcck_d_mask_o[l_ac].* =  g_xcck_d[l_ac].*
      CALL axcq512_xcck_t_mask()
      LET g_xcck_d_mask_n[l_ac].* =  g_xcck_d[l_ac].*
   END FOR
    
   FREE axcq512_pb   
   
END FUNCTION

################################################################################
# Descriptions...: 判斷是否要組成說明(XXX.CCC )
# Memo...........:
# Usage..........: CALL axcq512_compose(p_field,p_desc)
#                  RETURNING r_field_desc
# Input parameter: p_field        欄位值
#                : p_field        說明值
# Return code....: r_field_desc   組合後的值
# Date & Author..: 20150921 By dorislai
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq512_compose(p_field,p_desc)
   DEFINE  p_field  LIKE type_t.chr30
   DEFINE  p_desc   LIKE type_t.chr1000
   DEFINE  r_field_desc  LIKE type_t.chr1000
   IF cl_null(p_desc) THEN
      LET r_field_desc = p_field
   ELSE
      LET r_field_desc = p_field,'.',p_desc
   END IF
   RETURN r_field_desc
END FUNCTION

################################################################################
# Descriptions...: #+ filter過濾功能
# Memo...........:
# Usage..........: CALL axcq512_filter()
# Input parameter: 
# Return code....: 
# Date & Author..: 20151130 By Dorislai (151130-00003#13)
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq512_filter()
   DEFINE  ls_result   STRING

   LET l_ac = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      CONSTRUCT g_wc_filter ON xccksite,xcck002,xcck006,xcck007,xcck008,xcck009,xcck013,xcck010,xcck011,xcck015,
                               xcck017,xcck044,xcck201,xcck282a,xcck282b,xcck282c,xcck282d,xcck282e,xcck282f,xcck282g,xcck282h, 
                               xcck282,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,xcck202h,xcck202
           FROM s_detail1[1].xccksite,s_detail1[1].xcck002,s_detail1[1].xcck006,s_detail1[1].xcck007, 
                s_detail1[1].xcck008,s_detail1[1].xcck009,s_detail1[1].xcck013,s_detail1[1].xcck010,
                s_detail1[1].xcck011,s_detail1[1].xcck015, 
                s_detail1[1].xcck017,s_detail1[1].xcck044,s_detail1[1].xcck201, 
                s_detail1[1].xcck282a,s_detail1[1].xcck282b,s_detail1[1].xcck282c,s_detail1[1].xcck282d, 
                s_detail1[1].xcck282e,s_detail1[1].xcck282f,s_detail1[1].xcck282g,s_detail1[1].xcck282h, 
                s_detail1[1].xcck282,s_detail1[1].xcck202a,s_detail1[1].xcck202b,s_detail1[1].xcck202c, 
                s_detail1[1].xcck202d,s_detail1[1].xcck202e,s_detail1[1].xcck202f,s_detail1[1].xcck202g, 
                s_detail1[1].xcck202h,s_detail1[1].xcck202
         
         BEFORE CONSTRUCT 
            DISPLAY axcq512_filter_parser('xccksite') TO s_detail1[1].xccksite
            DISPLAY axcq512_filter_parser('xcck002') TO s_detail1[1].xcck002
            DISPLAY axcq512_filter_parser('xcck006') TO s_detail1[1].xcck006
            DISPLAY axcq512_filter_parser('xcck007') TO s_detail1[1].xcck007
            DISPLAY axcq512_filter_parser('xcck008') TO s_detail1[1].xcck008
            DISPLAY axcq512_filter_parser('xcck009') TO s_detail1[1].xcck009
            DISPLAY axcq512_filter_parser('xcck013') TO s_detail1[1].xcck013
            DISPLAY axcq512_filter_parser('xcck010') TO s_detail1[1].xcck010
            DISPLAY axcq512_filter_parser('xcck011') TO s_detail1[1].xcck011
            DISPLAY axcq512_filter_parser('xcck015') TO s_detail1[1].xcck015
            DISPLAY axcq512_filter_parser('xcck017') TO s_detail1[1].xcck017
            DISPLAY axcq512_filter_parser('xcck044') TO s_detail1[1].xcck044
            DISPLAY axcq512_filter_parser('xcck201') TO s_detail1[1].xcck201
            DISPLAY axcq512_filter_parser('xcck282a') TO s_detail1[1].xcck282a
            DISPLAY axcq512_filter_parser('xcck282b') TO s_detail1[1].xcck282b
            DISPLAY axcq512_filter_parser('xcck282c') TO s_detail1[1].xcck282c
            DISPLAY axcq512_filter_parser('xcck282d') TO s_detail1[1].xcck282d
            DISPLAY axcq512_filter_parser('xcck282e') TO s_detail1[1].xcck282e
            DISPLAY axcq512_filter_parser('xcck282f') TO s_detail1[1].xcck282f
            DISPLAY axcq512_filter_parser('xcck282g') TO s_detail1[1].xcck282g
            DISPLAY axcq512_filter_parser('xcck282h') TO s_detail1[1].xcck282h
            DISPLAY axcq512_filter_parser('xcck282') TO s_detail1[1].xcck282
            DISPLAY axcq512_filter_parser('xcck202a') TO s_detail1[1].xcck202a
            DISPLAY axcq512_filter_parser('xcck202b') TO s_detail1[1].xcck202b
            DISPLAY axcq512_filter_parser('xcck202c') TO s_detail1[1].xcck202c
            DISPLAY axcq512_filter_parser('xcck202d') TO s_detail1[1].xcck202d
            DISPLAY axcq512_filter_parser('xcck202e') TO s_detail1[1].xcck202e
            DISPLAY axcq512_filter_parser('xcck202f') TO s_detail1[1].xcck202f
            DISPLAY axcq512_filter_parser('xcck202g') TO s_detail1[1].xcck202g
            DISPLAY axcq512_filter_parser('xcck202h') TO s_detail1[1].xcck202h
            DISPLAY axcq512_filter_parser('xcck202') TO s_detail1[1].xcck202

         ON ACTION controlp INFIELD xccksite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                           #呼叫開窗 #161019-00017#5
            CALL q_ooef001_1()   #161019-00017#5
            DISPLAY g_qryparam.return1 TO xccksite  #顯示到畫面上
            NEXT FIELD xccksite                     #返回原欄位

         ON ACTION controlp INFIELD xcck002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcbf001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck002  #顯示到畫面上            
            NEXT FIELD xcck002                     #返回原欄位

         ON ACTION controlp INFIELD xcck006
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " xmdkstus = 'S'"
            CALL q_xmdkdocno_1()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck006  #顯示到畫面上            
            NEXT FIELD xcck006                     #返回原欄位
   
         ON ACTION controlp INFIELD xcck010
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_imaf001_15()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck010  #顯示到畫面上
            NEXT FIELD xcck010                     #返回原欄位

         ON ACTION controlp INFIELD xcck015
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_inaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck015  #顯示到畫面上
            NEXT FIELD xcck015                     #返回原欄位
         
         ON ACTION controlp INFIELD xcck044
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck044  #顯示到畫面上
            NEXT FIELD xcck044                     #返回原欄位         
            
         ON ACTION controlp INFIELD xcck011
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcck011()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck011  #顯示到畫面上
            NEXT FIELD xcck011                     #返回原欄位
            
      END CONSTRUCT
      #add-point:filter段add_cs

      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog

         #end add-point  
 
      ON ACTION accept
         ACCEPT DIALOG 
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
 
   END DIALOG
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
      LET g_wc = g_wc_t
   END IF
    
   CALL axcq512_filter_show('xccksite','xccksite')
   CALL axcq512_filter_show('xcck002','xcck002')
   CALL axcq512_filter_show('xcck006','xcck006')
   CALL axcq512_filter_show('xcck007','xcck007')
   CALL axcq512_filter_show('xcck008','xcck008')
   CALL axcq512_filter_show('xcck009','xcck009')
   CALL axcq512_filter_show('xcck013','xcck013')
   CALL axcq512_filter_show('xcck010','xcck010')
   CALL axcq512_filter_show('xcck011','xcck011')
   CALL axcq512_filter_show('xcck015','xcck015')
   CALL axcq512_filter_show('xcck017','xcck017')
   CALL axcq512_filter_show('xcck044','xcck044')
   CALL axcq512_filter_show('xcck201','xcck201')
   CALL axcq512_filter_show('xcck282a','xcck282a')
   CALL axcq512_filter_show('xcck282b','xcck282b')
   CALL axcq512_filter_show('xcck282c','xcck282c')
   CALL axcq512_filter_show('xcck282d','xcck282d')
   CALL axcq512_filter_show('xcck282e','xcck282e')
   CALL axcq512_filter_show('xcck282f','xcck282f')
   CALL axcq512_filter_show('xcck282g','xcck282g')
   CALL axcq512_filter_show('xcck282h','xcck282h')
   CALL axcq512_filter_show('xcck282','xcck282')
   CALL axcq512_filter_show('xcck202a','xcck202a')
   CALL axcq512_filter_show('xcck202b','xcck202b')
   CALL axcq512_filter_show('xcck202c','xcck202c')
   CALL axcq512_filter_show('xcck202d','xcck202d')
   CALL axcq512_filter_show('xcck202e','xcck202e')
   CALL axcq512_filter_show('xcck202f','xcck202f')
   CALL axcq512_filter_show('xcck202g','xcck202g')
   CALL axcq512_filter_show('xcck202h','xcck202h')
   CALL axcq512_filter_show('xcck202','xcck202')

#   CALL axcq512_b_fill(g_wc2)
   CALL axcq512_browser_fill("")
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
   
END FUNCTION

################################################################################
# Descriptions...: #+ filter欄位解析
# Memo...........:
# Usage..........: CALL axcq512_filter_parser(ps_field)
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/11/30 By Dorislai(151130-00003#13)
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq512_filter_parser(ps_field)
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   
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

################################################################################
# Descriptions...: #+ Browser標題欄位顯示搜尋條件
# Memo...........:
# Usage..........: CALL axcq512_filter_show(ps_field,ps_object)
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/11/30 By Dorislai(151130-00003#13)
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq512_filter_show(ps_field,ps_object)
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
   LET ls_condition = axcq512_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
END FUNCTION

 
{</section>}
 
