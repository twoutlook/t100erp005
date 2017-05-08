#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq220.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2014-11-19 15:04:30), PR版次:0010(2017-02-18 15:47:13)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000066
#+ Filename...: axcq220
#+ Description: 期初開帳料件庫存與成本數量差異查詢作業
#+ Creator....: 03297(2014-11-17 16:15:19)
#+ Modifier...: 03297 -SD/PR- 07024
 
{</section>}
 
{<section id="axcq220.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#41  2016/04/25  By pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160728-00029#1   2016/08/01  By xianghui 成本域抓不到时要给空格
#160727-00019#20  2016/08/04  By 08742    系统中定义的临时表名称超过15码在执行时会出错,将系统中定义的临时表长度超过15码的改掉
#                                         Mod  axcq220_xcbz_tmp   --> axcq220_tmp01
#                                         Mod  axcq220_head_tmp   --> axcq220_tmp02
#                                         Mod  axcq220_headbz_tmp --> axcq220_tmp03
#                                         Mod  axcq220_xcbz_tmp1  --> axcq220_tmp04
#160802-00020#7   2016/10/06  By shiun    增加帳套權限管控、法人權限管控
#161013-00040#1   2016/10/14  By lixiang  #若参数S-FIN-6013设置不按特性计算成本，单身显示时，除特性栏位外，依其他栏位group 汇总显示金额
#161109-00085#25  2016/11/16  By 08993    整批調整系統星號寫法
#170216-00074#1   2017/02/18  By dorislai 當計價方式=3:批次成本，才要匯總xcbz008(group by xcbz008)，其他的計價方式，group by中，不要加xcbz008的欄位
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
PRIVATE type type_g_xcca_m        RECORD
       xccacomp LIKE xcca_t.xccacomp, 
   xccacomp_desc LIKE type_t.chr80, 
   xcca004 LIKE xcca_t.xcca004, 
   xcca001 LIKE xcca_t.xcca001, 
   xcca001_desc LIKE type_t.chr80, 
   chk LIKE type_t.chr500, 
   xccald LIKE xcca_t.xccald, 
   xccald_desc LIKE type_t.chr80, 
   xcca005 LIKE xcca_t.xcca005, 
   xcca003 LIKE xcca_t.xcca003, 
   xcca003_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xcca_d        RECORD
       xcca002 LIKE xcca_t.xcca002, 
   xcca002_desc LIKE type_t.chr500, 
   xcca006 LIKE xcca_t.xcca006, 
   xcca006_desc LIKE type_t.chr500, 
   xcca006_desc_desc LIKE type_t.chr500, 
   imaa006 LIKE type_t.chr500, 
   imaa006_desc LIKE type_t.chr500, 
   xcca007 LIKE xcca_t.xcca007, 
   xcca008 LIKE xcca_t.xcca008, 
   xcca101 LIKE xcca_t.xcca101, 
   xcbz901 LIKE type_t.num20_6, 
   l_diff LIKE type_t.num20_6
       END RECORD
PRIVATE TYPE type_g_xcca2_d RECORD
       xccaownid LIKE xcca_t.xccaownid, 
   xccaownid_desc LIKE type_t.chr500, 
   xccaowndp LIKE xcca_t.xccaowndp, 
   xccaowndp_desc LIKE type_t.chr500, 
   xccacrtid LIKE xcca_t.xccacrtid, 
   xccacrtid_desc LIKE type_t.chr500, 
   xccacrtdp LIKE xcca_t.xccacrtdp, 
   xccacrtdp_desc LIKE type_t.chr500, 
   xccacrtdt DATETIME YEAR TO SECOND, 
   xccamodid LIKE xcca_t.xccamodid, 
   xccamodid_desc LIKE type_t.chr500, 
   xccamoddt DATETIME YEAR TO SECOND, 
   xccacnfid LIKE xcca_t.xccacnfid, 
   xccacnfid_desc LIKE type_t.chr500, 
   xccacnfdt DATETIME YEAR TO SECOND, 
   xccapstid LIKE xcca_t.xccapstid, 
   xccapstid_desc LIKE type_t.chr500, 
   xccapstdt LIKE xcca_t.xccapstdt, 
   xcca002 LIKE xcca_t.xcca002, 
   xcca006 LIKE xcca_t.xcca006, 
   xcca006_2_desc LIKE type_t.chr500, 
   xcca007 LIKE xcca_t.xcca007, 
   xcca008 LIKE xcca_t.xcca008
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_fin_6001   LIKE type_t.chr80     #采用成本域否
DEFINE g_fin_6002   LIKE type_t.chr80     #成本域类型
DEFINE g_fin_6013   LIKE type_t.chr80     #按料件特性计算成本否
DEFINE g_xcat005    LIKE xcat_t.xcat005
DEFINE g_wc1        STRING
DEFINE g_browser1      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_xccaComp LIKE xcca_t.xccacomp,
          b_xccald LIKE xcca_t.xccald,
      b_xcca001 LIKE xcca_t.xcca001,
      b_xcca003 LIKE xcca_t.xcca003,
      b_xcca004 LIKE xcca_t.xcca004,
      b_xcca005 LIKE xcca_t.xcca005
       #,rank           LIKE type_t.num10
      END RECORD 

DEFINE g_chk         LIKE type_t.chr1
#2015/3/25 liuym -------str--- 
TYPE type_g_xcca_e RECORD
       v          STRING
       END RECORD
DEFINE g_param                     type_g_xcca_e  
#2015/3/25 liuym -------end---
#add--160802-00020#7 By shiun--(S)
DEFINE g_wc_cs_ld            STRING
DEFINE g_wc_cs_comp          STRING
#add--160802-00020#7 By shiun--(E)
DEFINE g_column    LIKE   type_t.chr10  #紀錄xcbz008裡面要放的事欄位or空白   170216-00074#1-add
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_xcca_m          type_g_xcca_m
DEFINE g_xcca_m_t        type_g_xcca_m
DEFINE g_xcca_m_o        type_g_xcca_m
DEFINE g_xcca_m_mask_o   type_g_xcca_m #轉換遮罩前資料
DEFINE g_xcca_m_mask_n   type_g_xcca_m #轉換遮罩後資料
 
   DEFINE g_xcca004_t LIKE xcca_t.xcca004
DEFINE g_xcca001_t LIKE xcca_t.xcca001
DEFINE g_xccald_t LIKE xcca_t.xccald
DEFINE g_xcca005_t LIKE xcca_t.xcca005
DEFINE g_xcca003_t LIKE xcca_t.xcca003
 
 
DEFINE g_xcca_d          DYNAMIC ARRAY OF type_g_xcca_d
DEFINE g_xcca_d_t        type_g_xcca_d
DEFINE g_xcca_d_o        type_g_xcca_d
DEFINE g_xcca_d_mask_o   DYNAMIC ARRAY OF type_g_xcca_d #轉換遮罩前資料
DEFINE g_xcca_d_mask_n   DYNAMIC ARRAY OF type_g_xcca_d #轉換遮罩後資料
DEFINE g_xcca2_d   DYNAMIC ARRAY OF type_g_xcca2_d
DEFINE g_xcca2_d_t type_g_xcca2_d
DEFINE g_xcca2_d_o type_g_xcca2_d
DEFINE g_xcca2_d_mask_o   DYNAMIC ARRAY OF type_g_xcca2_d #轉換遮罩前資料
DEFINE g_xcca2_d_mask_n   DYNAMIC ARRAY OF type_g_xcca2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_xccald LIKE xcca_t.xccald,
      b_xcca001 LIKE xcca_t.xcca001,
      b_xcca003 LIKE xcca_t.xcca003,
      b_xcca004 LIKE xcca_t.xcca004,
      b_xcca005 LIKE xcca_t.xcca005
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
 
{<section id="axcq220.main" >}
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
   #add--160802-00020#7 By shiun--(S)
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  
   #add--160802-00020#7 By shiun--(E)
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT xccacomp,'',xcca004,xcca001,'','',xccald,'',xcca005,xcca003,''", 
                      " FROM xcca_t",
                      " WHERE xccaent= ? AND xccald=? AND xcca001=? AND xcca003=? AND xcca004=? AND  
                          xcca005=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq220_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xccacomp,t0.xcca004,t0.xcca001,t0.xccald,t0.xcca005,t0.xcca003,t1.ooefl003 , 
       t2.glaal002 ,t3.xcatl003",
               " FROM xcca_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.xccacomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t2 ON t2.glaalent="||g_enterprise||" AND t2.glaalld=t0.xccald AND t2.glaal001='"||g_dlang||"' ",
               " LEFT JOIN xcatl_t t3 ON t3.xcatlent="||g_enterprise||" AND t3.xcatl001=t0.xcca003 AND t3.xcatl002='"||g_dlang||"' ",
 
               " WHERE t0.xccaent = " ||g_enterprise|| " AND t0.xccald = ? AND t0.xcca001 = ? AND t0.xcca003 = ? AND t0.xcca004 = ? AND t0.xcca005 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axcq220_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq220 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq220_init()   
 
      #進入選單 Menu (="N")
      CALL axcq220_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq220
      
   END IF 
   
   CLOSE axcq220_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axcq220.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axcq220_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('xcca001','8914') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
   LET g_xcca_m.chk = 'N'   
   #end add-point
   
   CALL axcq220_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axcq220.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axcq220_ui_dialog()
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
   
   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_xcca_m.* TO NULL
         CALL g_xcca_d.clear()
         CALL g_xcca2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axcq220_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_xcca_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL axcq220_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axcq220_ui_detailshow()
               
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
        
         DISPLAY ARRAY g_xcca2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL axcq220_idx_chk()
               CALL axcq220_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body2.before_row"
               
               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'     
               LET g_current_page = 2
            
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         
         BEFORE DIALOG
            #先填充browser資料
            CALL axcq220_browser_fill("")
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
               CALL axcq220_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axcq220_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axcq220_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq220_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axcq220_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq220_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axcq220_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq220_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axcq220_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq220_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axcq220_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq220_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_xcca_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_xcca2_d)
                  LET g_export_id[2]   = "s_detail2"
 
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
               NEXT FIELD xcca002
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
               CALL axcq220_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL axcq220_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL axcq220_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #liuym 2015/3/25 add------str-----        
               IF g_xcca_d.getLength()>0 THEN
                  LET g_param.v = "axcq220_XG_tmp" 
                  CALL axcq220_ins_XG_tmp()
                  CALL axcq220_x01('1=1', g_param.v)
               END IF         
               #liuym 2015/3/25 add------end-----
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #liuym 2015/3/25 add------str-----        
               IF g_xcca_d.getLength()>0 THEN
                  LET g_param.v = "axcq220_XG_tmp" 
                  CALL axcq220_ins_XG_tmp()
                  CALL axcq220_x01('1=1', g_param.v)
               END IF         
               #liuym 2015/3/25 add------end-----
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axcq220_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
               #END add-point
               
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axcq220_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axcq220_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axcq220_set_pk_array()
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
 
{<section id="axcq220.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION axcq220_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq220.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axcq220_browser_fill(ps_page_action)
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
   DEFINE l_sql2            STRING   #add--160802-00020#7 By shiun
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.before_browser_fill"
   LET l_sql2 = ''   #add--160802-00020#7 By shiun
   IF 1=2 THEN
   #end add-point    
 
   LET l_searchcol = "xccald,xcca001,xcca003,xcca004,xcca005"
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
      LET l_sub_sql = " SELECT DISTINCT xccald ",
                      ", xcca001 ",
                      ", xcca003 ",
                      ", xcca004 ",
                      ", xcca005 ",
 
                      " FROM xcca_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE xccaent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xcca_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xccald ",
                      ", xcca001 ",
                      ", xcca003 ",
                      ", xcca004 ",
                      ", xcca005 ",
 
                      " FROM xcca_t ",
                      " ",
                      " ", 
 
 
                      " WHERE xccaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xcca_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
 
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   #add--160802-00020#7 By shiun--(S)
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET l_sub_sql = l_sub_sql ," AND xccald IN ",g_wc_cs_ld
    END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET l_sub_sql = l_sub_sql ," AND xccacomp IN ",g_wc_cs_comp
   END IF
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   #add--160802-00020#7 By shiun--(E)
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
      INITIALIZE g_xcca_m.* TO NULL
      CALL g_xcca_d.clear()        
      CALL g_xcca2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xccald,t0.xcca001,t0.xcca003,t0.xcca004,t0.xcca005 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.xccald,t0.xcca001,t0.xcca003,t0.xcca004,t0.xcca005",
                " FROM xcca_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.xccaent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xcca_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   #add--160802-00020#7 By shiun--(S)
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql ," AND xccald IN ",g_wc_cs_ld
    END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql ," AND xccacomp IN ",g_wc_cs_comp
   END IF
   #add--160802-00020#7 By shiun--(E)
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"xcca_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_xccald,g_browser[g_cnt].b_xcca001,g_browser[g_cnt].b_xcca003, 
          g_browser[g_cnt].b_xcca004,g_browser[g_cnt].b_xcca005 
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
   
   IF cl_null(g_browser[g_cnt].b_xccald) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_xcca_m.* TO NULL
      CALL g_xcca_d.clear()
      CALL g_xcca2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL axcq220_fetch('')
   
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
   ELSE
      LET l_searchcol = "xccald,xcca001,xcca003,xcca004,xcca005"
      LET l_wc  = g_wc.trim() 
      LET l_wc2 = g_wc2.trim()
      IF cl_null(l_wc) THEN  #p_wc 查詢條件
         LET l_wc = " 1=1"
      END IF
      IF cl_null(l_wc2) THEN  #p_wc 查詢條件
         LET l_wc2 = " 1=1"
      END IF
      
      IF l_wc2 <> " 1=1" OR NOT cl_null(l_wc2) THEN
         #單身有輸入搜尋條件                      
         LET l_sub_sql = " SELECT UNIQUE xccald ",
                         ", xcca001 ",
                         ", xcca003 ",
                         ", xcca004 ",
                         ", xcca005 ",
                         ", xccacomp ",
                         " FROM axcq220_tmp02 ",      #160727-00019#20 Mod  axcq220_head_tmp--> axcq220_tmp02
                         " ",
                         " ",
      
                         " WHERE xccaent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xcca_t")
      ELSE
         #單身未輸入搜尋條件
         LET l_sub_sql = " SELECT UNIQUE xccald ",
                         ", xcca001 ",
                         ", xcca003 ",
                         ", xcca004 ",
                         ", xcca005 ",
                         ", xccacomp ",
                         " FROM axcq220_tmp02 ",      #160727-00019#20 Mod  axcq220_head_tmp--> axcq220_tmp02
                         " ",
                         " ",
                         " WHERE xccaent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("xcca_t")
      END IF 
      
      #add--160802-00020#7 By shiun--(S)
      #---增加帳套權限控管
      IF NOT cl_null(g_wc_cs_ld) THEN
         LET l_sub_sql = l_sub_sql ," AND xccald IN ",g_wc_cs_ld
       END IF
      #---增加法人過濾條件
      IF NOT cl_null(g_wc_cs_comp) THEN
         LET l_sub_sql = l_sub_sql ," AND xccacomp IN ",g_wc_cs_comp
      END IF
      #add--160802-00020#7 By shiun--(E)
      LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
      
      #add-point:browser_fill,count前
      
      #end add-point
      
      PREPARE header_cnt_pre1 FROM g_sql
      EXECUTE header_cnt_pre1 INTO g_browser_cnt   #總筆數
      FREE header_cnt_pre
      
      #若超過最大顯示筆數
      IF g_browser_cnt > g_max_browse THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = g_browser_cnt 
            LET g_errparam.code   = 9035
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
      END IF
      LET g_error_show = 0
      
      IF cl_null(g_add_browse) THEN
         #清除畫面
         CLEAR FORM                
         INITIALIZE g_xcca_m.* TO NULL
         CALL g_xcca_d.clear()        
         CALL g_xcca2_d.clear() 
      
         CALL g_browser1.clear()
         LET g_cnt = 1
      ELSE
         LET l_wc  = g_add_browse
         LET l_wc2 = " 1=1" 
         LET g_cnt = g_current_idx
      END IF
      
      #依照t0.xccald,t0.xcca001,t0.xcca003,t0.xcca004,t0.xcca005 Browser欄位定義(取代原本bs_sql功能)
      LET g_sql  = "SELECT DISTINCT t0.xccald,t0.xcca001,t0.xcca003,t0.xcca004,t0.xcca005,t0.xccacomp",
                   " FROM axcq220_tmp02 t0"       #160727-00019#20 Mod  axcq220_head_tmp--> axcq220_tmp02
      
                   
                   
      
      #add-point:browser_fill,sql_rank前
      #add--160802-00020#7 By shiun--(S)
      IF cl_null(l_sql2) THEN
         LET l_sql2 = " WHERE 1=1 "
      END IF
      #---增加帳套權限控管
      IF NOT cl_null(g_wc_cs_ld) THEN
         LET l_sql2 = l_sql2 ," AND xccald IN ",g_wc_cs_ld
       END IF
      #---增加法人過濾條件
      IF NOT cl_null(g_wc_cs_comp) THEN
         LET l_sql2 = l_sql2 ," AND xccacomp IN ",g_wc_cs_comp
      END IF
      LET g_sql = g_sql,l_sql2
      #add--160802-00020#7 By shiun--(E)
      #end add-point
       
      #定義browser_fill sql
      LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                   
      #add-point:browser_fill,pre前
      
      #end add-point
      
      #LET g_sql = cl_sql_add_tabid(g_sql,"xcca_t")             #WC重組
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE browse_pre1 FROM g_sql
      DECLARE browse_cur1 CURSOR FOR browse_pre1
      
      FOREACH browse_cur1 INTO g_browser1[g_cnt].b_xccald,g_browser1[g_cnt].b_xcca001,g_browser1[g_cnt].b_xcca003, 
          g_browser1[g_cnt].b_xcca004,g_browser1[g_cnt].b_xcca005,g_browser1[g_cnt].b_xccacomp 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'Foreach:' 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         
         
         #add-point:browser_fill段reference
      
         #end add-point    
         
         LET g_cnt = g_cnt + 1
         IF g_cnt > g_max_rec THEN
            EXIT FOREACH
         END IF
      END FOREACH
      
      #清空g_add_browse, 並指定指標位置
      IF NOT cl_null(g_add_browse) THEN
         LET g_add_browse = ""
         CALL g_curr_diag.setCurrentRow("s_browse",g_current_idx)
      END IF
      
      IF cl_null(g_browser1[g_cnt].b_xccald) THEN
         CALL g_browser1.deleteElement(g_cnt)
      END IF
      
      IF g_browser1.getLength() = 0 AND l_wc THEN
         INITIALIZE g_xcca_m.* TO NULL
         CALL g_xcca_d.clear()
         CALL g_xcca2_d.clear()
      
         #add-point:browser_fill段after_clear
      
         #end add-point 
         CLEAR FORM
      END IF
      
      LET g_header_cnt = g_browser1.getLength()
      LET g_rec_b = g_cnt - 1
      LET g_detail_cnt = g_rec_b
      LET g_cnt = 0
      
      LET g_browser_cnt = g_browser1.getLength()
      DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
      
      FREE browse_pre1
      
      #若無資料則關閉相關功能
      IF g_browser_cnt = 0 THEN
         CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", FALSE)
      END IF
   END IF
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq220.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axcq220_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xcca_m.xccald = g_browser[g_current_idx].b_xccald   
   LET g_xcca_m.xcca001 = g_browser[g_current_idx].b_xcca001   
   LET g_xcca_m.xcca003 = g_browser[g_current_idx].b_xcca003   
   LET g_xcca_m.xcca004 = g_browser[g_current_idx].b_xcca004   
   LET g_xcca_m.xcca005 = g_browser[g_current_idx].b_xcca005   
 
   EXECUTE axcq220_master_referesh USING g_xcca_m.xccald,g_xcca_m.xcca001,g_xcca_m.xcca003,g_xcca_m.xcca004, 
       g_xcca_m.xcca005 INTO g_xcca_m.xccacomp,g_xcca_m.xcca004,g_xcca_m.xcca001,g_xcca_m.xccald,g_xcca_m.xcca005, 
       g_xcca_m.xcca003,g_xcca_m.xccacomp_desc,g_xcca_m.xccald_desc,g_xcca_m.xcca003_desc
   CALL axcq220_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axcq220.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axcq220_ui_detailshow()
   #add-point:ui_detailshow段define name="ui_detailshow.define_customerization"
   
   #end add-point
   #add-point:ui_detailshow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_detailshow.before"
   
   #end add-point  
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
      #add-point:ui_detailshow段more name="ui_detailshow.more"
      
      #end add-point 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq220.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axcq220_ui_browser_refresh()
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
      IF g_browser[l_i].b_xccald = g_xcca_m.xccald 
         AND g_browser[l_i].b_xcca001 = g_xcca_m.xcca001 
         AND g_browser[l_i].b_xcca003 = g_xcca_m.xcca003 
         AND g_browser[l_i].b_xcca004 = g_xcca_m.xcca004 
         AND g_browser[l_i].b_xcca005 = g_xcca_m.xcca005 
 
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
 
{<section id="axcq220.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axcq220_construct()
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
   INITIALIZE g_xcca_m.* TO NULL
   CALL g_xcca_d.clear()
   CALL g_xcca2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xccacomp,xcca004,xccald,xcca005
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.xccacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccacomp
            #add-point:ON ACTION controlp INFIELD xccacomp name="construct.c.xccacomp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #add--160802-00020#7 By shiun--(S)
      	   #增加法人過濾條件
            IF NOT cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF
            #add--160802-00020#7 By shiun--(S)
            CALL q_ooef001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccacomp  #顯示到畫面上
            NEXT FIELD xccacomp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccacomp
            #add-point:BEFORE FIELD xccacomp name="construct.b.xccacomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccacomp
            
            #add-point:AFTER FIELD xccacomp name="construct.a.xccacomp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcca004
            #add-point:BEFORE FIELD xcca004 name="construct.b.xcca004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcca004
            
            #add-point:AFTER FIELD xcca004 name="construct.a.xcca004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcca004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcca004
            #add-point:ON ACTION controlp INFIELD xcca004 name="construct.c.xcca004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xccald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccald
            #add-point:ON ACTION controlp INFIELD xccald name="construct.c.xccald"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #add--160802-00020#7 By shiun--(S)
            #增加帳套權限控制
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #add--160802-00020#7 By shiun--(E)
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccald  #顯示到畫面上
            NEXT FIELD xccald                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccald
            #add-point:BEFORE FIELD xccald name="construct.b.xccald"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccald
            
            #add-point:AFTER FIELD xccald name="construct.a.xccald"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcca005
            #add-point:BEFORE FIELD xcca005 name="construct.b.xcca005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcca005
            
            #add-point:AFTER FIELD xcca005 name="construct.a.xcca005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcca005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcca005
            #add-point:ON ACTION controlp INFIELD xcca005 name="construct.c.xcca005"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON xccaownid,xccaowndp,xccacrtid,xccacrtdp,xccacrtdt,xccamodid,xccamoddt, 
          xccacnfid,xccacnfdt,xccapstid,xccapstdt
           FROM s_detail2[1].xccaownid,s_detail2[1].xccaowndp,s_detail2[1].xccacrtid,s_detail2[1].xccacrtdp, 
               s_detail2[1].xccacrtdt,s_detail2[1].xccamodid,s_detail2[1].xccamoddt,s_detail2[1].xccacnfid, 
               s_detail2[1].xccacnfdt,s_detail2[1].xccapstid,s_detail2[1].xccapstdt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<xccacrtdt>>----
         AFTER FIELD xccacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<xccamoddt>>----
         AFTER FIELD xccamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xccacnfdt>>----
         AFTER FIELD xccacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xccapstdt>>----
         AFTER FIELD xccapstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
           
         #單身一般欄位開窗相關處理
                  #Ctrlp:construct.c.page2.xccaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccaownid
            #add-point:ON ACTION controlp INFIELD xccaownid name="construct.c.page2.xccaownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccaownid  #顯示到畫面上
            NEXT FIELD xccaownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccaownid
            #add-point:BEFORE FIELD xccaownid name="construct.b.page2.xccaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccaownid
            
            #add-point:AFTER FIELD xccaownid name="construct.a.page2.xccaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccaowndp
            #add-point:ON ACTION controlp INFIELD xccaowndp name="construct.c.page2.xccaowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccaowndp  #顯示到畫面上
            NEXT FIELD xccaowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccaowndp
            #add-point:BEFORE FIELD xccaowndp name="construct.b.page2.xccaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccaowndp
            
            #add-point:AFTER FIELD xccaowndp name="construct.a.page2.xccaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccacrtid
            #add-point:ON ACTION controlp INFIELD xccacrtid name="construct.c.page2.xccacrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccacrtid  #顯示到畫面上
            NEXT FIELD xccacrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccacrtid
            #add-point:BEFORE FIELD xccacrtid name="construct.b.page2.xccacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccacrtid
            
            #add-point:AFTER FIELD xccacrtid name="construct.a.page2.xccacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccacrtdp
            #add-point:ON ACTION controlp INFIELD xccacrtdp name="construct.c.page2.xccacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccacrtdp  #顯示到畫面上
            NEXT FIELD xccacrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccacrtdp
            #add-point:BEFORE FIELD xccacrtdp name="construct.b.page2.xccacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccacrtdp
            
            #add-point:AFTER FIELD xccacrtdp name="construct.a.page2.xccacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccacrtdt
            #add-point:BEFORE FIELD xccacrtdt name="construct.b.page2.xccacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xccamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccamodid
            #add-point:ON ACTION controlp INFIELD xccamodid name="construct.c.page2.xccamodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccamodid  #顯示到畫面上
            NEXT FIELD xccamodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccamodid
            #add-point:BEFORE FIELD xccamodid name="construct.b.page2.xccamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccamodid
            
            #add-point:AFTER FIELD xccamodid name="construct.a.page2.xccamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccamoddt
            #add-point:BEFORE FIELD xccamoddt name="construct.b.page2.xccamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xccacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccacnfid
            #add-point:ON ACTION controlp INFIELD xccacnfid name="construct.c.page2.xccacnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccacnfid  #顯示到畫面上
            NEXT FIELD xccacnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccacnfid
            #add-point:BEFORE FIELD xccacnfid name="construct.b.page2.xccacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccacnfid
            
            #add-point:AFTER FIELD xccacnfid name="construct.a.page2.xccacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccacnfdt
            #add-point:BEFORE FIELD xccacnfdt name="construct.b.page2.xccacnfdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xccapstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccapstid
            #add-point:ON ACTION controlp INFIELD xccapstid name="construct.c.page2.xccapstid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccapstid  #顯示到畫面上
            NEXT FIELD xccapstid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccapstid
            #add-point:BEFORE FIELD xccapstid name="construct.b.page2.xccapstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccapstid
            
            #add-point:AFTER FIELD xccapstid name="construct.a.page2.xccapstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccapstdt
            #add-point:BEFORE FIELD xccapstdt name="construct.b.page2.xccapstdt"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      CONSTRUCT BY NAME g_wc1 ON xcca001,xcca003
      #此段落由子樣板a01產生
         BEFORE FIELD xcca001
            #add-point:BEFORE FIELD xcca001
       
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD xcca001

            #add-point:AFTER FIELD xcca001

            #END add-point


         #Ctrlp:construct.c.xcca001
         ON ACTION controlp INFIELD xcca001
            #add-point:ON ACTION controlp INFIELD xcca001

            #END add-point
            
            
           #Ctrlp:construct.c.xcca003
         ON ACTION controlp INFIELD xcca003
            #add-point:ON ACTION controlp INFIELD xcca003
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcca003  #顯示到畫面上
            NEXT FIELD xcca003                     #返回原欄位



            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD xcca003
            #add-point:BEFORE FIELD xcca003

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD xcca003

            #add-point:AFTER FIELD xcca003

            #END add-point


      END CONSTRUCT

      INPUT BY NAME g_xcca_m.chk 
         ATTRIBUTE(WITHOUT DEFAULTS)
        
        AFTER FIELD chk
          LET g_chk = g_xcca_m.chk        
        
      END INPUT
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog name="cs.before_dialog"
         CALL axcq220_default()
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
   CALL axcq220_insert_head()
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
 
{<section id="axcq220.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axcq220_query()
   #add-point:query段define name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="query.befroe_query"
   CALL axcq220_create_tmp()
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
   CALL g_browser1.clear()       
   CALL g_xcca_d.clear()
   CALL g_xcca2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL axcq220_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL axcq220_browser_fill(g_wc)
      CALL axcq220_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL axcq220_browser_fill("F")
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||")")
   
   #備份搜尋條件
   LET ls_wc = g_wc
   
   IF g_browser1.getLength() = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   ELSE
      CALL axcq220_fetch("F") 
   END IF
   
   CALL axcq220_idx_chk()
   
   LET g_wc_filter = ""
   RETURN
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
   CALL g_xcca_d.clear()
   CALL g_xcca2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL axcq220_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axcq220_browser_fill(g_wc)
      CALL axcq220_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL axcq220_browser_fill("F")
   
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
      CALL axcq220_fetch("F") 
   END IF
   
   CALL axcq220_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="axcq220.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axcq220_fetch(p_flag)
   #add-point:fetch段define name="fetch.define_customerization"
   
   #end add-point   
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fetch.before_fetch"
   CALL axcq220_fetch1(p_flag)
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
   
   #CALL axcq220_browser_fill(p_flag)
   
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
   
   LET g_xcca_m.xccald = g_browser[g_current_idx].b_xccald
   LET g_xcca_m.xcca001 = g_browser[g_current_idx].b_xcca001
   LET g_xcca_m.xcca003 = g_browser[g_current_idx].b_xcca003
   LET g_xcca_m.xcca004 = g_browser[g_current_idx].b_xcca004
   LET g_xcca_m.xcca005 = g_browser[g_current_idx].b_xcca005
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axcq220_master_referesh USING g_xcca_m.xccald,g_xcca_m.xcca001,g_xcca_m.xcca003,g_xcca_m.xcca004, 
       g_xcca_m.xcca005 INTO g_xcca_m.xccacomp,g_xcca_m.xcca004,g_xcca_m.xcca001,g_xcca_m.xccald,g_xcca_m.xcca005, 
       g_xcca_m.xcca003,g_xcca_m.xccacomp_desc,g_xcca_m.xccald_desc,g_xcca_m.xcca003_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcca_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_xcca_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_xcca_m_mask_o.* =  g_xcca_m.*
   CALL axcq220_xcca_t_mask()
   LET g_xcca_m_mask_n.* =  g_xcca_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq220_set_act_visible()
   CALL axcq220_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_xcca_m_t.* = g_xcca_m.*
   LET g_xcca_m_o.* = g_xcca_m.*
   
   #重新顯示   
   CALL axcq220_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axcq220.insert" >}
#+ 資料新增
PRIVATE FUNCTION axcq220_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_xcca_d.clear()
   CALL g_xcca2_d.clear()
 
 
   INITIALIZE g_xcca_m.* TO NULL             #DEFAULT 設定
   LET g_xccald_t = NULL
   LET g_xcca001_t = NULL
   LET g_xcca003_t = NULL
   LET g_xcca004_t = NULL
   LET g_xcca005_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
            LET g_xcca_m.xcca001 = "1"
      LET g_xcca_m.xcca003 = "1"
 
     
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
 
      CALL axcq220_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_xcca_m.* TO NULL
         INITIALIZE g_xcca_d TO NULL
         INITIALIZE g_xcca2_d TO NULL
 
         CALL axcq220_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xcca_m.* = g_xcca_m_t.*
         CALL axcq220_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_xcca_d.clear()
      #CALL g_xcca2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq220_set_act_visible()
   CALL axcq220_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xccald_t = g_xcca_m.xccald
   LET g_xcca001_t = g_xcca_m.xcca001
   LET g_xcca003_t = g_xcca_m.xcca003
   LET g_xcca004_t = g_xcca_m.xcca004
   LET g_xcca005_t = g_xcca_m.xcca005
 
   
   #組合新增資料的條件
   LET g_add_browse = " xccaent = " ||g_enterprise|| " AND",
                      " xccald = '", g_xcca_m.xccald, "' "
                      ," AND xcca001 = '", g_xcca_m.xcca001, "' "
                      ," AND xcca003 = '", g_xcca_m.xcca003, "' "
                      ," AND xcca004 = '", g_xcca_m.xcca004, "' "
                      ," AND xcca005 = '", g_xcca_m.xcca005, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq220_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL axcq220_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axcq220_master_referesh USING g_xcca_m.xccald,g_xcca_m.xcca001,g_xcca_m.xcca003,g_xcca_m.xcca004, 
       g_xcca_m.xcca005 INTO g_xcca_m.xccacomp,g_xcca_m.xcca004,g_xcca_m.xcca001,g_xcca_m.xccald,g_xcca_m.xcca005, 
       g_xcca_m.xcca003,g_xcca_m.xccacomp_desc,g_xcca_m.xccald_desc,g_xcca_m.xcca003_desc
   
   #遮罩相關處理
   LET g_xcca_m_mask_o.* =  g_xcca_m.*
   CALL axcq220_xcca_t_mask()
   LET g_xcca_m_mask_n.* =  g_xcca_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xcca_m.xccacomp,g_xcca_m.xccacomp_desc,g_xcca_m.xcca004,g_xcca_m.xcca001,g_xcca_m.xcca001_desc, 
       g_xcca_m.chk,g_xcca_m.xccald,g_xcca_m.xccald_desc,g_xcca_m.xcca005,g_xcca_m.xcca003,g_xcca_m.xcca003_desc 
 
   
   #功能已完成,通報訊息中心
   CALL axcq220_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axcq220.modify" >}
#+ 資料修改
PRIVATE FUNCTION axcq220_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_xcca_m.xccald IS NULL
   OR g_xcca_m.xcca001 IS NULL
   OR g_xcca_m.xcca003 IS NULL
   OR g_xcca_m.xcca004 IS NULL
   OR g_xcca_m.xcca005 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_xccald_t = g_xcca_m.xccald
   LET g_xcca001_t = g_xcca_m.xcca001
   LET g_xcca003_t = g_xcca_m.xcca003
   LET g_xcca004_t = g_xcca_m.xcca004
   LET g_xcca005_t = g_xcca_m.xcca005
 
   CALL s_transaction_begin()
   
   OPEN axcq220_cl USING g_enterprise,g_xcca_m.xccald,g_xcca_m.xcca001,g_xcca_m.xcca003,g_xcca_m.xcca004,g_xcca_m.xcca005
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq220_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axcq220_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axcq220_master_referesh USING g_xcca_m.xccald,g_xcca_m.xcca001,g_xcca_m.xcca003,g_xcca_m.xcca004, 
       g_xcca_m.xcca005 INTO g_xcca_m.xccacomp,g_xcca_m.xcca004,g_xcca_m.xcca001,g_xcca_m.xccald,g_xcca_m.xcca005, 
       g_xcca_m.xcca003,g_xcca_m.xccacomp_desc,g_xcca_m.xccald_desc,g_xcca_m.xcca003_desc
   
   #遮罩相關處理
   LET g_xcca_m_mask_o.* =  g_xcca_m.*
   CALL axcq220_xcca_t_mask()
   LET g_xcca_m_mask_n.* =  g_xcca_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL axcq220_show()
   WHILE TRUE
      LET g_xccald_t = g_xcca_m.xccald
      LET g_xcca001_t = g_xcca_m.xcca001
      LET g_xcca003_t = g_xcca_m.xcca003
      LET g_xcca004_t = g_xcca_m.xcca004
      LET g_xcca005_t = g_xcca_m.xcca005
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL axcq220_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xcca_m.* = g_xcca_m_t.*
         CALL axcq220_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_xcca_m.xccald != g_xccald_t 
      OR g_xcca_m.xcca001 != g_xcca001_t 
      OR g_xcca_m.xcca003 != g_xcca003_t 
      OR g_xcca_m.xcca004 != g_xcca004_t 
      OR g_xcca_m.xcca005 != g_xcca005_t 
 
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
   CALL axcq220_set_act_visible()
   CALL axcq220_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xccaent = " ||g_enterprise|| " AND",
                      " xccald = '", g_xcca_m.xccald, "' "
                      ," AND xcca001 = '", g_xcca_m.xcca001, "' "
                      ," AND xcca003 = '", g_xcca_m.xcca003, "' "
                      ," AND xcca004 = '", g_xcca_m.xcca004, "' "
                      ," AND xcca005 = '", g_xcca_m.xcca005, "' "
 
   #填到對應位置
   CALL axcq220_browser_fill("")
 
   CALL axcq220_idx_chk()
 
   CLOSE axcq220_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axcq220_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="axcq220.input" >}
#+ 資料輸入
PRIVATE FUNCTION axcq220_input(p_cmd)
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
   DISPLAY BY NAME g_xcca_m.xccacomp,g_xcca_m.xccacomp_desc,g_xcca_m.xcca004,g_xcca_m.xcca001,g_xcca_m.xcca001_desc, 
       g_xcca_m.chk,g_xcca_m.xccald,g_xcca_m.xccald_desc,g_xcca_m.xcca005,g_xcca_m.xcca003,g_xcca_m.xcca003_desc 
 
   
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
   LET g_forupd_sql = "SELECT xcca002,xcca006,xcca007,xcca008,xcca101,xccaownid,xccaowndp,xccacrtid, 
       xccacrtdp,xccacrtdt,xccamodid,xccamoddt,xccacnfid,xccacnfdt,xccapstid,xccapstdt,xcca002,xcca006, 
       xcca007,xcca008 FROM xcca_t WHERE xccaent=? AND xccald=? AND xcca001=? AND xcca003=? AND xcca004=?  
       AND xcca005=? AND xcca002=? AND xcca006=? AND xcca007=? AND xcca008=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq220_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axcq220_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axcq220_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_xcca_m.xccacomp,g_xcca_m.xcca004,g_xcca_m.xcca001,g_xcca_m.chk,g_xcca_m.xccald, 
       g_xcca_m.xcca005,g_xcca_m.xcca003
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axcq220.input.head" >}
   
      #單頭段
      INPUT BY NAME g_xcca_m.xccacomp,g_xcca_m.xcca004,g_xcca_m.xcca001,g_xcca_m.chk,g_xcca_m.xccald, 
          g_xcca_m.xcca005,g_xcca_m.xcca003 
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
         AFTER FIELD xccacomp
            
            #add-point:AFTER FIELD xccacomp name="input.a.xccacomp"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcca_m.xccacomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcca_m.xccacomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcca_m.xccacomp_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccacomp
            #add-point:BEFORE FIELD xccacomp name="input.b.xccacomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccacomp
            #add-point:ON CHANGE xccacomp name="input.g.xccacomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcca004
            #add-point:BEFORE FIELD xcca004 name="input.b.xcca004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcca004
            
            #add-point:AFTER FIELD xcca004 name="input.a.xcca004"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcca_m.xccald) AND NOT cl_null(g_xcca_m.xcca001) AND NOT cl_null(g_xcca_m.xcca003) AND NOT cl_null(g_xcca_m.xcca004) AND NOT cl_null(g_xcca_m.xcca005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcca_m.xccald != g_xccald_t  OR g_xcca_m.xcca001 != g_xcca001_t  OR g_xcca_m.xcca003 != g_xcca003_t  OR g_xcca_m.xcca004 != g_xcca004_t  OR g_xcca_m.xcca005 != g_xcca005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcca_t WHERE "||"xccaent = '" ||g_enterprise|| "' AND "||"xccald = '"||g_xcca_m.xccald ||"' AND "|| "xcca001 = '"||g_xcca_m.xcca001 ||"' AND "|| "xcca003 = '"||g_xcca_m.xcca003 ||"' AND "|| "xcca004 = '"||g_xcca_m.xcca004 ||"' AND "|| "xcca005 = '"||g_xcca_m.xcca005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcca004
            #add-point:ON CHANGE xcca004 name="input.g.xcca004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcca001
            
            #add-point:AFTER FIELD xcca001 name="input.a.xcca001"

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcca_m.xccald) AND NOT cl_null(g_xcca_m.xcca001) AND NOT cl_null(g_xcca_m.xcca003) AND NOT cl_null(g_xcca_m.xcca004) AND NOT cl_null(g_xcca_m.xcca005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcca_m.xccald != g_xccald_t  OR g_xcca_m.xcca001 != g_xcca001_t  OR g_xcca_m.xcca003 != g_xcca003_t  OR g_xcca_m.xcca004 != g_xcca004_t  OR g_xcca_m.xcca005 != g_xcca005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcca_t WHERE "||"xccaent = '" ||g_enterprise|| "' AND "||"xccald = '"||g_xcca_m.xccald ||"' AND "|| "xcca001 = '"||g_xcca_m.xcca001 ||"' AND "|| "xcca003 = '"||g_xcca_m.xcca003 ||"' AND "|| "xcca004 = '"||g_xcca_m.xcca004 ||"' AND "|| "xcca005 = '"||g_xcca_m.xcca005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcca001
            #add-point:BEFORE FIELD xcca001 name="input.b.xcca001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcca001
            #add-point:ON CHANGE xcca001 name="input.g.xcca001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chk
            #add-point:BEFORE FIELD chk name="input.b.chk"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chk
            
            #add-point:AFTER FIELD chk name="input.a.chk"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE chk
            #add-point:ON CHANGE chk name="input.g.chk"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccald
            
            #add-point:AFTER FIELD xccald name="input.a.xccald"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcca_m.xccald
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcca_m.xccald_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcca_m.xccald_desc

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcca_m.xccald) AND NOT cl_null(g_xcca_m.xcca001) AND NOT cl_null(g_xcca_m.xcca003) AND NOT cl_null(g_xcca_m.xcca004) AND NOT cl_null(g_xcca_m.xcca005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcca_m.xccald != g_xccald_t  OR g_xcca_m.xcca001 != g_xcca001_t  OR g_xcca_m.xcca003 != g_xcca003_t  OR g_xcca_m.xcca004 != g_xcca004_t  OR g_xcca_m.xcca005 != g_xcca005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcca_t WHERE "||"xccaent = '" ||g_enterprise|| "' AND "||"xccald = '"||g_xcca_m.xccald ||"' AND "|| "xcca001 = '"||g_xcca_m.xcca001 ||"' AND "|| "xcca003 = '"||g_xcca_m.xcca003 ||"' AND "|| "xcca004 = '"||g_xcca_m.xcca004 ||"' AND "|| "xcca005 = '"||g_xcca_m.xcca005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccald
            #add-point:BEFORE FIELD xccald name="input.b.xccald"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccald
            #add-point:ON CHANGE xccald name="input.g.xccald"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcca005
            #add-point:BEFORE FIELD xcca005 name="input.b.xcca005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcca005
            
            #add-point:AFTER FIELD xcca005 name="input.a.xcca005"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcca_m.xccald) AND NOT cl_null(g_xcca_m.xcca001) AND NOT cl_null(g_xcca_m.xcca003) AND NOT cl_null(g_xcca_m.xcca004) AND NOT cl_null(g_xcca_m.xcca005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcca_m.xccald != g_xccald_t  OR g_xcca_m.xcca001 != g_xcca001_t  OR g_xcca_m.xcca003 != g_xcca003_t  OR g_xcca_m.xcca004 != g_xcca004_t  OR g_xcca_m.xcca005 != g_xcca005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcca_t WHERE "||"xccaent = '" ||g_enterprise|| "' AND "||"xccald = '"||g_xcca_m.xccald ||"' AND "|| "xcca001 = '"||g_xcca_m.xcca001 ||"' AND "|| "xcca003 = '"||g_xcca_m.xcca003 ||"' AND "|| "xcca004 = '"||g_xcca_m.xcca004 ||"' AND "|| "xcca005 = '"||g_xcca_m.xcca005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcca005
            #add-point:ON CHANGE xcca005 name="input.g.xcca005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcca003
            
            #add-point:AFTER FIELD xcca003 name="input.a.xcca003"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcca_m.xcca003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcca_m.xcca003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcca_m.xcca003_desc

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcca_m.xccald) AND NOT cl_null(g_xcca_m.xcca001) AND NOT cl_null(g_xcca_m.xcca003) AND NOT cl_null(g_xcca_m.xcca004) AND NOT cl_null(g_xcca_m.xcca005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcca_m.xccald != g_xccald_t  OR g_xcca_m.xcca001 != g_xcca001_t  OR g_xcca_m.xcca003 != g_xcca003_t  OR g_xcca_m.xcca004 != g_xcca004_t  OR g_xcca_m.xcca005 != g_xcca005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcca_t WHERE "||"xccaent = '" ||g_enterprise|| "' AND "||"xccald = '"||g_xcca_m.xccald ||"' AND "|| "xcca001 = '"||g_xcca_m.xcca001 ||"' AND "|| "xcca003 = '"||g_xcca_m.xcca003 ||"' AND "|| "xcca004 = '"||g_xcca_m.xcca004 ||"' AND "|| "xcca005 = '"||g_xcca_m.xcca005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcca003
            #add-point:BEFORE FIELD xcca003 name="input.b.xcca003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcca003
            #add-point:ON CHANGE xcca003 name="input.g.xcca003"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xccacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccacomp
            #add-point:ON ACTION controlp INFIELD xccacomp name="input.c.xccacomp"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcca_m.xccacomp             #給予default值
            LET g_qryparam.default2 = "" #g_xcca_m.ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #

            #add--160802-00020#7 By shiun--(S)
      	   #增加法人過濾條件
            IF NOT cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF
            #add--160802-00020#7 By shiun--(S)
            CALL q_ooef001()                                #呼叫開窗

            LET g_xcca_m.xccacomp = g_qryparam.return1              
            #LET g_xcca_m.ooefl003 = g_qryparam.return2 
            DISPLAY g_xcca_m.xccacomp TO xccacomp              #
            #DISPLAY g_xcca_m.ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD xccacomp                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcca004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcca004
            #add-point:ON ACTION controlp INFIELD xcca004 name="input.c.xcca004"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcca001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcca001
            #add-point:ON ACTION controlp INFIELD xcca001 name="input.c.xcca001"
            
            #END add-point
 
 
         #Ctrlp:input.c.chk
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chk
            #add-point:ON ACTION controlp INFIELD chk name="input.c.chk"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccald
            #add-point:ON ACTION controlp INFIELD xccald name="input.c.xccald"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcca_m.xccald             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #add--160802-00020#7 By shiun--(S)
            #增加帳套權限控制
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #add--160802-00020#7 By shiun--(S)
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xcca_m.xccald = g_qryparam.return1              

            DISPLAY g_xcca_m.xccald TO xccald              #

            NEXT FIELD xccald                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcca005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcca005
            #add-point:ON ACTION controlp INFIELD xcca005 name="input.c.xcca005"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcca003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcca003
            #add-point:ON ACTION controlp INFIELD xcca003 name="input.c.xcca003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcca_m.xcca003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL q_xcat001()                                #呼叫開窗

            LET g_xcca_m.xcca003 = g_qryparam.return1              

            DISPLAY g_xcca_m.xcca003 TO xcca003              #

            NEXT FIELD xcca003                          #返回原欄位


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
            DISPLAY BY NAME g_xcca_m.xccald             
                            ,g_xcca_m.xcca001   
                            ,g_xcca_m.xcca003   
                            ,g_xcca_m.xcca004   
                            ,g_xcca_m.xcca005   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL axcq220_xcca_t_mask_restore('restore_mask_o')
            
               UPDATE xcca_t SET (xccacomp,xcca004,xcca001,xccald,xcca005,xcca003) = (g_xcca_m.xccacomp, 
                   g_xcca_m.xcca004,g_xcca_m.xcca001,g_xcca_m.xccald,g_xcca_m.xcca005,g_xcca_m.xcca003) 
 
                WHERE xccaent = g_enterprise AND xccald = g_xccald_t
                  AND xcca001 = g_xcca001_t
                  AND xcca003 = g_xcca003_t
                  AND xcca004 = g_xcca004_t
                  AND xcca005 = g_xcca005_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcca_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcca_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcca_m.xccald
               LET gs_keys_bak[1] = g_xccald_t
               LET gs_keys[2] = g_xcca_m.xcca001
               LET gs_keys_bak[2] = g_xcca001_t
               LET gs_keys[3] = g_xcca_m.xcca003
               LET gs_keys_bak[3] = g_xcca003_t
               LET gs_keys[4] = g_xcca_m.xcca004
               LET gs_keys_bak[4] = g_xcca004_t
               LET gs_keys[5] = g_xcca_m.xcca005
               LET gs_keys_bak[5] = g_xcca005_t
               LET gs_keys[6] = g_xcca_d[g_detail_idx].xcca002
               LET gs_keys_bak[6] = g_xcca_d_t.xcca002
               LET gs_keys[7] = g_xcca_d[g_detail_idx].xcca006
               LET gs_keys_bak[7] = g_xcca_d_t.xcca006
               LET gs_keys[8] = g_xcca_d[g_detail_idx].xcca007
               LET gs_keys_bak[8] = g_xcca_d_t.xcca007
               LET gs_keys[9] = g_xcca_d[g_detail_idx].xcca008
               LET gs_keys_bak[9] = g_xcca_d_t.xcca008
               CALL axcq220_update_b('xcca_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_xcca_m_t)
                     #LET g_log2 = util.JSON.stringify(g_xcca_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL axcq220_xcca_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axcq220_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_xccald_t = g_xcca_m.xccald
           LET g_xcca001_t = g_xcca_m.xcca001
           LET g_xcca003_t = g_xcca_m.xcca003
           LET g_xcca004_t = g_xcca_m.xcca004
           LET g_xcca005_t = g_xcca_m.xcca005
 
           
           IF g_xcca_d.getLength() = 0 THEN
              NEXT FIELD xcca002
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="axcq220.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_xcca_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xcca_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axcq220_b_fill(g_wc2) #test 
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
            CALL axcq220_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axcq220_cl USING g_enterprise,g_xcca_m.xccald,g_xcca_m.xcca001,g_xcca_m.xcca003,g_xcca_m.xcca004,g_xcca_m.xcca005                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE axcq220_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axcq220_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_xcca_d[l_ac].xcca002 IS NOT NULL
               AND g_xcca_d[l_ac].xcca006 IS NOT NULL
               AND g_xcca_d[l_ac].xcca007 IS NOT NULL
               AND g_xcca_d[l_ac].xcca008 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xcca_d_t.* = g_xcca_d[l_ac].*  #BACKUP
               LET g_xcca_d_o.* = g_xcca_d[l_ac].*  #BACKUP
               CALL axcq220_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL axcq220_set_no_entry_b(l_cmd)
               OPEN axcq220_bcl USING g_enterprise,g_xcca_m.xccald,
                                                g_xcca_m.xcca001,
                                                g_xcca_m.xcca003,
                                                g_xcca_m.xcca004,
                                                g_xcca_m.xcca005,
 
                                                g_xcca_d_t.xcca002
                                                ,g_xcca_d_t.xcca006
                                                ,g_xcca_d_t.xcca007
                                                ,g_xcca_d_t.xcca008
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axcq220_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axcq220_bcl INTO g_xcca_d[l_ac].xcca002,g_xcca_d[l_ac].xcca006,g_xcca_d[l_ac].xcca007, 
                      g_xcca_d[l_ac].xcca008,g_xcca_d[l_ac].xcca101,g_xcca2_d[l_ac].xccaownid,g_xcca2_d[l_ac].xccaowndp, 
                      g_xcca2_d[l_ac].xccacrtid,g_xcca2_d[l_ac].xccacrtdp,g_xcca2_d[l_ac].xccacrtdt, 
                      g_xcca2_d[l_ac].xccamodid,g_xcca2_d[l_ac].xccamoddt,g_xcca2_d[l_ac].xccacnfid, 
                      g_xcca2_d[l_ac].xccacnfdt,g_xcca2_d[l_ac].xccapstid,g_xcca2_d[l_ac].xccapstdt, 
                      g_xcca2_d[l_ac].xcca002,g_xcca2_d[l_ac].xcca006,g_xcca2_d[l_ac].xcca007,g_xcca2_d[l_ac].xcca008 
 
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xcca_d_t.xcca002,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xcca_d_mask_o[l_ac].* =  g_xcca_d[l_ac].*
                  CALL axcq220_xcca_t_mask()
                  LET g_xcca_d_mask_n[l_ac].* =  g_xcca_d[l_ac].*
                  
                  CALL axcq220_ref_show()
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
            INITIALIZE g_xcca_d_t.* TO NULL
            INITIALIZE g_xcca_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xcca_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xcca2_d[l_ac].xccaownid = g_user
      LET g_xcca2_d[l_ac].xccaowndp = g_dept
      LET g_xcca2_d[l_ac].xccacrtid = g_user
      LET g_xcca2_d[l_ac].xccacrtdp = g_dept 
      LET g_xcca2_d[l_ac].xccacrtdt = cl_get_current()
      LET g_xcca2_d[l_ac].xccamodid = g_user
      LET g_xcca2_d[l_ac].xccamoddt = cl_get_current()
 
 
  
            #一般欄位預設值
            
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_xcca_d_t.* = g_xcca_d[l_ac].*     #新輸入資料
            LET g_xcca_d_o.* = g_xcca_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axcq220_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL axcq220_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xcca_d[li_reproduce_target].* = g_xcca_d[li_reproduce].*
               LET g_xcca2_d[li_reproduce_target].* = g_xcca2_d[li_reproduce].*
 
               LET g_xcca_d[g_xcca_d.getLength()].xcca002 = NULL
               LET g_xcca_d[g_xcca_d.getLength()].xcca006 = NULL
               LET g_xcca_d[g_xcca_d.getLength()].xcca007 = NULL
               LET g_xcca_d[g_xcca_d.getLength()].xcca008 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM xcca_t 
             WHERE xccaent = g_enterprise AND xccald = g_xcca_m.xccald
               AND xcca001 = g_xcca_m.xcca001
               AND xcca003 = g_xcca_m.xcca003
               AND xcca004 = g_xcca_m.xcca004
               AND xcca005 = g_xcca_m.xcca005
 
               AND xcca002 = g_xcca_d[l_ac].xcca002
               AND xcca006 = g_xcca_d[l_ac].xcca006
               AND xcca007 = g_xcca_d[l_ac].xcca007
               AND xcca008 = g_xcca_d[l_ac].xcca008
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO xcca_t
                           (xccaent,
                            xccacomp,xcca004,xcca001,xccald,xcca005,xcca003,
                            xcca002,xcca006,xcca007,xcca008
                            ,xcca101,xccaownid,xccaowndp,xccacrtid,xccacrtdp,xccacrtdt,xccamodid,xccamoddt,xccacnfid,xccacnfdt,xccapstid,xccapstdt) 
                     VALUES(g_enterprise,
                            g_xcca_m.xccacomp,g_xcca_m.xcca004,g_xcca_m.xcca001,g_xcca_m.xccald,g_xcca_m.xcca005,g_xcca_m.xcca003,
                            g_xcca_d[l_ac].xcca002,g_xcca_d[l_ac].xcca006,g_xcca_d[l_ac].xcca007,g_xcca_d[l_ac].xcca008 
 
                            ,g_xcca_d[l_ac].xcca101,g_xcca2_d[l_ac].xccaownid,g_xcca2_d[l_ac].xccaowndp, 
                                g_xcca2_d[l_ac].xccacrtid,g_xcca2_d[l_ac].xccacrtdp,g_xcca2_d[l_ac].xccacrtdt, 
                                g_xcca2_d[l_ac].xccamodid,g_xcca2_d[l_ac].xccamoddt,g_xcca2_d[l_ac].xccacnfid, 
                                g_xcca2_d[l_ac].xccacnfdt,g_xcca2_d[l_ac].xccapstid,g_xcca2_d[l_ac].xccapstdt) 
 
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_xcca_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "xcca_t:",SQLERRMESSAGE 
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
               IF axcq220_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_xcca_m.xccald
                  LET gs_keys[gs_keys.getLength()+1] = g_xcca_m.xcca001
                  LET gs_keys[gs_keys.getLength()+1] = g_xcca_m.xcca003
                  LET gs_keys[gs_keys.getLength()+1] = g_xcca_m.xcca004
                  LET gs_keys[gs_keys.getLength()+1] = g_xcca_m.xcca005
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xcca_d_t.xcca002
                  LET gs_keys[gs_keys.getLength()+1] = g_xcca_d_t.xcca006
                  LET gs_keys[gs_keys.getLength()+1] = g_xcca_d_t.xcca007
                  LET gs_keys[gs_keys.getLength()+1] = g_xcca_d_t.xcca008
 
 
                  #刪除下層單身
                  IF NOT axcq220_key_delete_b(gs_keys,'xcca_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE axcq220_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axcq220_bcl
               LET l_count = g_xcca_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_xcca_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcca002
            
            #add-point:AFTER FIELD xcca002 name="input.a.page1.xcca002"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcca_m.xccald IS NOT NULL AND g_xcca_m.xcca001 IS NOT NULL AND g_xcca_m.xcca003 IS NOT NULL AND g_xcca_m.xcca004 IS NOT NULL AND g_xcca_m.xcca005 IS NOT NULL AND g_xcca_d[g_detail_idx].xcca002 IS NOT NULL AND g_xcca_d[g_detail_idx].xcca006 IS NOT NULL AND g_xcca_d[g_detail_idx].xcca007 IS NOT NULL AND g_xcca_d[g_detail_idx].xcca008 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcca_m.xccald != g_xccald_t OR g_xcca_m.xcca001 != g_xcca001_t OR g_xcca_m.xcca003 != g_xcca003_t OR g_xcca_m.xcca004 != g_xcca004_t OR g_xcca_m.xcca005 != g_xcca005_t OR g_xcca_d[g_detail_idx].xcca002 != g_xcca_d_t.xcca002 OR g_xcca_d[g_detail_idx].xcca006 != g_xcca_d_t.xcca006 OR g_xcca_d[g_detail_idx].xcca007 != g_xcca_d_t.xcca007 OR g_xcca_d[g_detail_idx].xcca008 != g_xcca_d_t.xcca008)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcca_t WHERE "||"xccaent = '" ||g_enterprise|| "' AND "||"xccald = '"||g_xcca_m.xccald ||"' AND "|| "xcca001 = '"||g_xcca_m.xcca001 ||"' AND "|| "xcca003 = '"||g_xcca_m.xcca003 ||"' AND "|| "xcca004 = '"||g_xcca_m.xcca004 ||"' AND "|| "xcca005 = '"||g_xcca_m.xcca005 ||"' AND "|| "xcca002 = '"||g_xcca_d[g_detail_idx].xcca002 ||"' AND "|| "xcca006 = '"||g_xcca_d[g_detail_idx].xcca006 ||"' AND "|| "xcca007 = '"||g_xcca_d[g_detail_idx].xcca007 ||"' AND "|| "xcca008 = '"||g_xcca_d[g_detail_idx].xcca008 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcca_m.xccacomp
            LET g_ref_fields[2] = g_xcca_d[l_ac].xcca002
            CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp=? AND xcbfl001=? AND xcfbl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcca_d[l_ac].xcca002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcca_d[l_ac].xcca002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcca002
            #add-point:BEFORE FIELD xcca002 name="input.b.page1.xcca002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcca002
            #add-point:ON CHANGE xcca002 name="input.g.page1.xcca002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcca006
            
            #add-point:AFTER FIELD xcca006 name="input.a.page1.xcca006"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcca_m.xccald IS NOT NULL AND g_xcca_m.xcca001 IS NOT NULL AND g_xcca_m.xcca003 IS NOT NULL AND g_xcca_m.xcca004 IS NOT NULL AND g_xcca_m.xcca005 IS NOT NULL AND g_xcca_d[g_detail_idx].xcca002 IS NOT NULL AND g_xcca_d[g_detail_idx].xcca006 IS NOT NULL AND g_xcca_d[g_detail_idx].xcca007 IS NOT NULL AND g_xcca_d[g_detail_idx].xcca008 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcca_m.xccald != g_xccald_t OR g_xcca_m.xcca001 != g_xcca001_t OR g_xcca_m.xcca003 != g_xcca003_t OR g_xcca_m.xcca004 != g_xcca004_t OR g_xcca_m.xcca005 != g_xcca005_t OR g_xcca_d[g_detail_idx].xcca002 != g_xcca_d_t.xcca002 OR g_xcca_d[g_detail_idx].xcca006 != g_xcca_d_t.xcca006 OR g_xcca_d[g_detail_idx].xcca007 != g_xcca_d_t.xcca007 OR g_xcca_d[g_detail_idx].xcca008 != g_xcca_d_t.xcca008)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcca_t WHERE "||"xccaent = '" ||g_enterprise|| "' AND "||"xccald = '"||g_xcca_m.xccald ||"' AND "|| "xcca001 = '"||g_xcca_m.xcca001 ||"' AND "|| "xcca003 = '"||g_xcca_m.xcca003 ||"' AND "|| "xcca004 = '"||g_xcca_m.xcca004 ||"' AND "|| "xcca005 = '"||g_xcca_m.xcca005 ||"' AND "|| "xcca002 = '"||g_xcca_d[g_detail_idx].xcca002 ||"' AND "|| "xcca006 = '"||g_xcca_d[g_detail_idx].xcca006 ||"' AND "|| "xcca007 = '"||g_xcca_d[g_detail_idx].xcca007 ||"' AND "|| "xcca008 = '"||g_xcca_d[g_detail_idx].xcca008 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcca_d[l_ac].xcca006
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaalent.imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcca_d[l_ac].xcca006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcca_d[l_ac].xcca006_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcca006
            #add-point:BEFORE FIELD xcca006 name="input.b.page1.xcca006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcca006
            #add-point:ON CHANGE xcca006 name="input.g.page1.xcca006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa006
            
            #add-point:AFTER FIELD imaa006 name="input.a.page1.imaa006"
            IF NOT cl_null(g_xcca_d[l_ac].imaa006) THEN 
#應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcca_d[l_ac].imaa006

               #160318-00025#41  2016/04/25  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#41  2016/04/25  by pengxin  add(E)
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_ooca001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcca_d[l_ac].imaa006
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcca_d[l_ac].imaa006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcca_d[l_ac].imaa006_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa006
            #add-point:BEFORE FIELD imaa006 name="input.b.page1.imaa006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa006
            #add-point:ON CHANGE imaa006 name="input.g.page1.imaa006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcca007
            #add-point:BEFORE FIELD xcca007 name="input.b.page1.xcca007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcca007
            
            #add-point:AFTER FIELD xcca007 name="input.a.page1.xcca007"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcca_m.xccald IS NOT NULL AND g_xcca_m.xcca001 IS NOT NULL AND g_xcca_m.xcca003 IS NOT NULL AND g_xcca_m.xcca004 IS NOT NULL AND g_xcca_m.xcca005 IS NOT NULL AND g_xcca_d[g_detail_idx].xcca002 IS NOT NULL AND g_xcca_d[g_detail_idx].xcca006 IS NOT NULL AND g_xcca_d[g_detail_idx].xcca007 IS NOT NULL AND g_xcca_d[g_detail_idx].xcca008 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcca_m.xccald != g_xccald_t OR g_xcca_m.xcca001 != g_xcca001_t OR g_xcca_m.xcca003 != g_xcca003_t OR g_xcca_m.xcca004 != g_xcca004_t OR g_xcca_m.xcca005 != g_xcca005_t OR g_xcca_d[g_detail_idx].xcca002 != g_xcca_d_t.xcca002 OR g_xcca_d[g_detail_idx].xcca006 != g_xcca_d_t.xcca006 OR g_xcca_d[g_detail_idx].xcca007 != g_xcca_d_t.xcca007 OR g_xcca_d[g_detail_idx].xcca008 != g_xcca_d_t.xcca008)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcca_t WHERE "||"xccaent = '" ||g_enterprise|| "' AND "||"xccald = '"||g_xcca_m.xccald ||"' AND "|| "xcca001 = '"||g_xcca_m.xcca001 ||"' AND "|| "xcca003 = '"||g_xcca_m.xcca003 ||"' AND "|| "xcca004 = '"||g_xcca_m.xcca004 ||"' AND "|| "xcca005 = '"||g_xcca_m.xcca005 ||"' AND "|| "xcca002 = '"||g_xcca_d[g_detail_idx].xcca002 ||"' AND "|| "xcca006 = '"||g_xcca_d[g_detail_idx].xcca006 ||"' AND "|| "xcca007 = '"||g_xcca_d[g_detail_idx].xcca007 ||"' AND "|| "xcca008 = '"||g_xcca_d[g_detail_idx].xcca008 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcca007
            #add-point:ON CHANGE xcca007 name="input.g.page1.xcca007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcca008
            #add-point:BEFORE FIELD xcca008 name="input.b.page1.xcca008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcca008
            
            #add-point:AFTER FIELD xcca008 name="input.a.page1.xcca008"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcca_m.xccald IS NOT NULL AND g_xcca_m.xcca001 IS NOT NULL AND g_xcca_m.xcca003 IS NOT NULL AND g_xcca_m.xcca004 IS NOT NULL AND g_xcca_m.xcca005 IS NOT NULL AND g_xcca_d[g_detail_idx].xcca002 IS NOT NULL AND g_xcca_d[g_detail_idx].xcca006 IS NOT NULL AND g_xcca_d[g_detail_idx].xcca007 IS NOT NULL AND g_xcca_d[g_detail_idx].xcca008 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcca_m.xccald != g_xccald_t OR g_xcca_m.xcca001 != g_xcca001_t OR g_xcca_m.xcca003 != g_xcca003_t OR g_xcca_m.xcca004 != g_xcca004_t OR g_xcca_m.xcca005 != g_xcca005_t OR g_xcca_d[g_detail_idx].xcca002 != g_xcca_d_t.xcca002 OR g_xcca_d[g_detail_idx].xcca006 != g_xcca_d_t.xcca006 OR g_xcca_d[g_detail_idx].xcca007 != g_xcca_d_t.xcca007 OR g_xcca_d[g_detail_idx].xcca008 != g_xcca_d_t.xcca008)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcca_t WHERE "||"xccaent = '" ||g_enterprise|| "' AND "||"xccald = '"||g_xcca_m.xccald ||"' AND "|| "xcca001 = '"||g_xcca_m.xcca001 ||"' AND "|| "xcca003 = '"||g_xcca_m.xcca003 ||"' AND "|| "xcca004 = '"||g_xcca_m.xcca004 ||"' AND "|| "xcca005 = '"||g_xcca_m.xcca005 ||"' AND "|| "xcca002 = '"||g_xcca_d[g_detail_idx].xcca002 ||"' AND "|| "xcca006 = '"||g_xcca_d[g_detail_idx].xcca006 ||"' AND "|| "xcca007 = '"||g_xcca_d[g_detail_idx].xcca007 ||"' AND "|| "xcca008 = '"||g_xcca_d[g_detail_idx].xcca008 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcca008
            #add-point:ON CHANGE xcca008 name="input.g.page1.xcca008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcca101
            #add-point:BEFORE FIELD xcca101 name="input.b.page1.xcca101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcca101
            
            #add-point:AFTER FIELD xcca101 name="input.a.page1.xcca101"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcca101
            #add-point:ON CHANGE xcca101 name="input.g.page1.xcca101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbz901
            #add-point:BEFORE FIELD xcbz901 name="input.b.page1.xcbz901"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbz901
            
            #add-point:AFTER FIELD xcbz901 name="input.a.page1.xcbz901"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbz901
            #add-point:ON CHANGE xcbz901 name="input.g.page1.xcbz901"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_diff
            #add-point:BEFORE FIELD l_diff name="input.b.page1.l_diff"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_diff
            
            #add-point:AFTER FIELD l_diff name="input.a.page1.l_diff"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_diff
            #add-point:ON CHANGE l_diff name="input.g.page1.l_diff"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xcca002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcca002
            #add-point:ON ACTION controlp INFIELD xcca002 name="input.c.page1.xcca002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcca_d[l_ac].xcca002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL q_xcbf001()                                #呼叫開窗

            LET g_xcca_d[l_ac].xcca002 = g_qryparam.return1              

            DISPLAY g_xcca_d[l_ac].xcca002 TO xcca002              #

            NEXT FIELD xcca002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xcca006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcca006
            #add-point:ON ACTION controlp INFIELD xcca006 name="input.c.page1.xcca006"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcca_d[l_ac].xcca006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL q_imag001_1()                                #呼叫開窗

            LET g_xcca_d[l_ac].xcca006 = g_qryparam.return1              

            DISPLAY g_xcca_d[l_ac].xcca006 TO xcca006              #

            NEXT FIELD xcca006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.imaa006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa006
            #add-point:ON ACTION controlp INFIELD imaa006 name="input.c.page1.imaa006"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcca_d[l_ac].imaa006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooca001_1()                                #呼叫開窗

            LET g_xcca_d[l_ac].imaa006 = g_qryparam.return1              

            DISPLAY g_xcca_d[l_ac].imaa006 TO imaa006              #

            NEXT FIELD imaa006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xcca007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcca007
            #add-point:ON ACTION controlp INFIELD xcca007 name="input.c.page1.xcca007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcca008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcca008
            #add-point:ON ACTION controlp INFIELD xcca008 name="input.c.page1.xcca008"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcca_d[l_ac].xcca008             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL q_inag006_2()                                #呼叫開窗

            LET g_xcca_d[l_ac].xcca008 = g_qryparam.return1              

            DISPLAY g_xcca_d[l_ac].xcca008 TO xcca008              #

            NEXT FIELD xcca008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xcca101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcca101
            #add-point:ON ACTION controlp INFIELD xcca101 name="input.c.page1.xcca101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbz901
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbz901
            #add-point:ON ACTION controlp INFIELD xcbz901 name="input.c.page1.xcbz901"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_diff
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_diff
            #add-point:ON ACTION controlp INFIELD l_diff name="input.c.page1.l_diff"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xcca_d[l_ac].* = g_xcca_d_t.*
               CLOSE axcq220_bcl
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
               LET g_errparam.extend = g_xcca_d[l_ac].xcca002 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xcca_d[l_ac].* = g_xcca_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_xcca2_d[l_ac].xccamodid = g_user 
LET g_xcca2_d[l_ac].xccamoddt = cl_get_current()
LET g_xcca2_d[l_ac].xccamodid_desc = cl_get_username(g_xcca2_d[l_ac].xccamodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL axcq220_xcca_t_mask_restore('restore_mask_o')
         
               UPDATE xcca_t SET (xccald,xcca001,xcca003,xcca004,xcca005,xcca002,xcca006,xcca007,xcca008, 
                   xcca101,xccaownid,xccaowndp,xccacrtid,xccacrtdp,xccacrtdt,xccamodid,xccamoddt,xccacnfid, 
                   xccacnfdt,xccapstid,xccapstdt) = (g_xcca_m.xccald,g_xcca_m.xcca001,g_xcca_m.xcca003, 
                   g_xcca_m.xcca004,g_xcca_m.xcca005,g_xcca_d[l_ac].xcca002,g_xcca_d[l_ac].xcca006,g_xcca_d[l_ac].xcca007, 
                   g_xcca_d[l_ac].xcca008,g_xcca_d[l_ac].xcca101,g_xcca2_d[l_ac].xccaownid,g_xcca2_d[l_ac].xccaowndp, 
                   g_xcca2_d[l_ac].xccacrtid,g_xcca2_d[l_ac].xccacrtdp,g_xcca2_d[l_ac].xccacrtdt,g_xcca2_d[l_ac].xccamodid, 
                   g_xcca2_d[l_ac].xccamoddt,g_xcca2_d[l_ac].xccacnfid,g_xcca2_d[l_ac].xccacnfdt,g_xcca2_d[l_ac].xccapstid, 
                   g_xcca2_d[l_ac].xccapstdt)
                WHERE xccaent = g_enterprise AND xccald = g_xcca_m.xccald 
                 AND xcca001 = g_xcca_m.xcca001 
                 AND xcca003 = g_xcca_m.xcca003 
                 AND xcca004 = g_xcca_m.xcca004 
                 AND xcca005 = g_xcca_m.xcca005 
 
                 AND xcca002 = g_xcca_d_t.xcca002 #項次   
                 AND xcca006 = g_xcca_d_t.xcca006  
                 AND xcca007 = g_xcca_d_t.xcca007  
                 AND xcca008 = g_xcca_d_t.xcca008  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcca_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xcca_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcca_m.xccald
               LET gs_keys_bak[1] = g_xccald_t
               LET gs_keys[2] = g_xcca_m.xcca001
               LET gs_keys_bak[2] = g_xcca001_t
               LET gs_keys[3] = g_xcca_m.xcca003
               LET gs_keys_bak[3] = g_xcca003_t
               LET gs_keys[4] = g_xcca_m.xcca004
               LET gs_keys_bak[4] = g_xcca004_t
               LET gs_keys[5] = g_xcca_m.xcca005
               LET gs_keys_bak[5] = g_xcca005_t
               LET gs_keys[6] = g_xcca_d[g_detail_idx].xcca002
               LET gs_keys_bak[6] = g_xcca_d_t.xcca002
               LET gs_keys[7] = g_xcca_d[g_detail_idx].xcca006
               LET gs_keys_bak[7] = g_xcca_d_t.xcca006
               LET gs_keys[8] = g_xcca_d[g_detail_idx].xcca007
               LET gs_keys_bak[8] = g_xcca_d_t.xcca007
               LET gs_keys[9] = g_xcca_d[g_detail_idx].xcca008
               LET gs_keys_bak[9] = g_xcca_d_t.xcca008
               CALL axcq220_update_b('xcca_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_xcca_m),util.JSON.stringify(g_xcca_d_t)
                     LET g_log2 = util.JSON.stringify(g_xcca_m),util.JSON.stringify(g_xcca_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axcq220_xcca_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_xcca_m.xccald
               LET ls_keys[ls_keys.getLength()+1] = g_xcca_m.xcca001
               LET ls_keys[ls_keys.getLength()+1] = g_xcca_m.xcca003
               LET ls_keys[ls_keys.getLength()+1] = g_xcca_m.xcca004
               LET ls_keys[ls_keys.getLength()+1] = g_xcca_m.xcca005
 
               LET ls_keys[ls_keys.getLength()+1] = g_xcca_d_t.xcca002
               LET ls_keys[ls_keys.getLength()+1] = g_xcca_d_t.xcca006
               LET ls_keys[ls_keys.getLength()+1] = g_xcca_d_t.xcca007
               LET ls_keys[ls_keys.getLength()+1] = g_xcca_d_t.xcca008
 
               CALL axcq220_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE axcq220_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xcca_d[l_ac].* = g_xcca_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE axcq220_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xcca_d.getLength() = 0 THEN
               NEXT FIELD xcca002
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xcca_d[li_reproduce_target].* = g_xcca_d[li_reproduce].*
               LET g_xcca2_d[li_reproduce_target].* = g_xcca2_d[li_reproduce].*
 
               LET g_xcca_d[li_reproduce_target].xcca002 = NULL
               LET g_xcca_d[li_reproduce_target].xcca006 = NULL
               LET g_xcca_d[li_reproduce_target].xcca007 = NULL
               LET g_xcca_d[li_reproduce_target].xcca008 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xcca_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xcca_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_xcca2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL axcq220_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL axcq220_idx_chk()
            CALL axcq220_ui_detailshow()
        
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)      
         
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
         
      END DISPLAY
 
      
 
      
 
    
      #add-point:input段more_input name="input.more_inputarray"
      
      #end add-point    
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:input段before_dialog name="input.before_dialog"
         
         #end add-point 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
         CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx)
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD xccald
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xcca002
               WHEN "s_detail2"
                  NEXT FIELD xccaownid
 
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
   CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
 
   
   #add-point:input段after_input name="input.after_input"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq220.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axcq220_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   CALL axcq220_ref()
   CALL axcq220_visible()
   IF g_xcca_m.chk IS NULL THEN
      LET g_xcca_m.chk = g_chk
      DISPLAY BY NAME g_xcca_m.chk
   END IF
   #特性
   IF cl_get_para(g_enterprise,g_xcca_m.xccacomp,'S-FIN-6013') = 'N' THEN
      CALL cl_set_comp_visible('xcca007',FALSE)
   ELSE
      CALL cl_set_comp_visible('xcca007',TRUE)
   END IF
   #成本域
   IF cl_get_para(g_enterprise,g_xcca_m.xccacomp,'S-FIN-6001') = 'N' THEN
      CALL cl_set_comp_visible('xcca002,xcca002_desc',FALSE)
   ELSE
      CALL cl_set_comp_visible('xcca002,xcca002_desc',TRUE)
   END IF 
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL axcq220_b_fill(g_wc2) #第一階單身填充
      CALL axcq220_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axcq220_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_xcca_m.xccacomp,g_xcca_m.xccacomp_desc,g_xcca_m.xcca004,g_xcca_m.xcca001,g_xcca_m.xcca001_desc, 
       g_xcca_m.chk,g_xcca_m.xccald,g_xcca_m.xccald_desc,g_xcca_m.xcca005,g_xcca_m.xcca003,g_xcca_m.xcca003_desc 
 
 
   CALL axcq220_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq220.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION axcq220_ref_show()
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
   FOR l_ac = 1 TO g_xcca_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"

   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_xcca_m.xccald
   LET g_ref_fields[2] = g_xcca_m.xcca001
   LET g_ref_fields[3] = g_xcca_m.xcca003
   LET g_ref_fields[4] = g_xcca_m.xcca004
   LET g_ref_fields[5] = g_xcca_m.xcca005
   LET g_ref_fields[6] = g_xcca_d[l_ac].xcca002
   LET g_ref_fields[7] = g_xcca_d[l_ac].xcca006
   LET g_ref_fields[8] = g_xcca_d[l_ac].xcca007
   LET g_ref_fields[9] = g_xcca_d[l_ac].xcca008
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_xcca2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
      
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="axcq220.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axcq220_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE xcca_t.xccald 
   DEFINE l_oldno     LIKE xcca_t.xccald 
   DEFINE l_newno02     LIKE xcca_t.xcca001 
   DEFINE l_oldno02     LIKE xcca_t.xcca001 
   DEFINE l_newno03     LIKE xcca_t.xcca003 
   DEFINE l_oldno03     LIKE xcca_t.xcca003 
   DEFINE l_newno04     LIKE xcca_t.xcca004 
   DEFINE l_oldno04     LIKE xcca_t.xcca004 
   DEFINE l_newno05     LIKE xcca_t.xcca005 
   DEFINE l_oldno05     LIKE xcca_t.xcca005 
 
   DEFINE l_master    RECORD LIKE xcca_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xcca_t.* #此變數樣板目前無使用
 
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
 
   IF g_xcca_m.xccald IS NULL
      OR g_xcca_m.xcca001 IS NULL
      OR g_xcca_m.xcca003 IS NULL
      OR g_xcca_m.xcca004 IS NULL
      OR g_xcca_m.xcca005 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_xccald_t = g_xcca_m.xccald
   LET g_xcca001_t = g_xcca_m.xcca001
   LET g_xcca003_t = g_xcca_m.xcca003
   LET g_xcca004_t = g_xcca_m.xcca004
   LET g_xcca005_t = g_xcca_m.xcca005
 
   
   LET g_xcca_m.xccald = ""
   LET g_xcca_m.xcca001 = ""
   LET g_xcca_m.xcca003 = ""
   LET g_xcca_m.xcca004 = ""
   LET g_xcca_m.xcca005 = ""
 
   LET g_master_insert = FALSE
   CALL axcq220_set_entry('a')
   CALL axcq220_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_xcca_m.xcca001_desc = ''
   DISPLAY BY NAME g_xcca_m.xcca001_desc
   LET g_xcca_m.xccald_desc = ''
   DISPLAY BY NAME g_xcca_m.xccald_desc
   LET g_xcca_m.xcca003_desc = ''
   DISPLAY BY NAME g_xcca_m.xcca003_desc
 
   
   CALL axcq220_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_xcca_m.* TO NULL
      INITIALIZE g_xcca_d TO NULL
      INITIALIZE g_xcca2_d TO NULL
 
      CALL axcq220_show()
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
   CALL axcq220_set_act_visible()
   CALL axcq220_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xccald_t = g_xcca_m.xccald
   LET g_xcca001_t = g_xcca_m.xcca001
   LET g_xcca003_t = g_xcca_m.xcca003
   LET g_xcca004_t = g_xcca_m.xcca004
   LET g_xcca005_t = g_xcca_m.xcca005
 
   
   #組合新增資料的條件
   LET g_add_browse = " xccaent = " ||g_enterprise|| " AND",
                      " xccald = '", g_xcca_m.xccald, "' "
                      ," AND xcca001 = '", g_xcca_m.xcca001, "' "
                      ," AND xcca003 = '", g_xcca_m.xcca003, "' "
                      ," AND xcca004 = '", g_xcca_m.xcca004, "' "
                      ," AND xcca005 = '", g_xcca_m.xcca005, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq220_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL axcq220_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL axcq220_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="axcq220.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axcq220_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xcca_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axcq220_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xcca_t
    WHERE xccaent = g_enterprise AND xccald = g_xccald_t
    AND xcca001 = g_xcca001_t
    AND xcca003 = g_xcca003_t
    AND xcca004 = g_xcca004_t
    AND xcca005 = g_xcca005_t
 
       INTO TEMP axcq220_detail
   
   #將key修正為調整後   
   UPDATE axcq220_detail 
      #更新key欄位
      SET xccald = g_xcca_m.xccald
          , xcca001 = g_xcca_m.xcca001
          , xcca003 = g_xcca_m.xcca003
          , xcca004 = g_xcca_m.xcca004
          , xcca005 = g_xcca_m.xcca005
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , xccaownid = g_user 
       , xccaowndp = g_dept
       , xccacrtid = g_user
       , xccacrtdp = g_dept 
       , xccacrtdt = ld_date
       , xccamodid = g_user
       , xccamoddt = ld_date
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO xcca_t SELECT * FROM axcq220_detail
   
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
   DROP TABLE axcq220_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xccald_t = g_xcca_m.xccald
   LET g_xcca001_t = g_xcca_m.xcca001
   LET g_xcca003_t = g_xcca_m.xcca003
   LET g_xcca004_t = g_xcca_m.xcca004
   LET g_xcca005_t = g_xcca_m.xcca005
 
   
   DROP TABLE axcq220_detail
   
END FUNCTION
 
{</section>}
 
{<section id="axcq220.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axcq220_delete()
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
   
   IF g_xcca_m.xccald IS NULL
   OR g_xcca_m.xcca001 IS NULL
   OR g_xcca_m.xcca003 IS NULL
   OR g_xcca_m.xcca004 IS NULL
   OR g_xcca_m.xcca005 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN axcq220_cl USING g_enterprise,g_xcca_m.xccald,g_xcca_m.xcca001,g_xcca_m.xcca003,g_xcca_m.xcca004,g_xcca_m.xcca005
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq220_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axcq220_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axcq220_master_referesh USING g_xcca_m.xccald,g_xcca_m.xcca001,g_xcca_m.xcca003,g_xcca_m.xcca004, 
       g_xcca_m.xcca005 INTO g_xcca_m.xccacomp,g_xcca_m.xcca004,g_xcca_m.xcca001,g_xcca_m.xccald,g_xcca_m.xcca005, 
       g_xcca_m.xcca003,g_xcca_m.xccacomp_desc,g_xcca_m.xccald_desc,g_xcca_m.xcca003_desc
   
   #遮罩相關處理
   LET g_xcca_m_mask_o.* =  g_xcca_m.*
   CALL axcq220_xcca_t_mask()
   LET g_xcca_m_mask_n.* =  g_xcca_m.*
   
   CALL axcq220_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axcq220_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM xcca_t WHERE xccaent = g_enterprise AND xccald = g_xcca_m.xccald
                                                               AND xcca001 = g_xcca_m.xcca001
                                                               AND xcca003 = g_xcca_m.xcca003
                                                               AND xcca004 = g_xcca_m.xcca004
                                                               AND xcca005 = g_xcca_m.xcca005
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcca_t:",SQLERRMESSAGE 
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
      #   CLOSE axcq220_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_xcca_d.clear() 
      CALL g_xcca2_d.clear()       
 
     
      CALL axcq220_ui_browser_refresh()  
      #CALL axcq220_ui_headershow()  
      #CALL axcq220_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL axcq220_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL axcq220_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE axcq220_cl
 
   #功能已完成,通報訊息中心
   CALL axcq220_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axcq220.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq220_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_xcca_d.clear()
   CALL g_xcca2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL cl_err_collect_init()
   CALL axcq220_insert_tmp()
   CALL cl_err_collect_show()
   IF 1=2 THEN
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT xcca002,xcca006,xcca007,xcca008,xcca101,xccaownid,xccaowndp,xccacrtid, 
       xccacrtdp,xccacrtdt,xccamodid,xccamoddt,xccacnfid,xccacnfdt,xccapstid,xccapstdt,xcca002,xcca006, 
       xcca007,xcca008,t1.xcbfl003 ,t2.imaal003 ,t3.imaal004 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 , 
       t8.ooag011 ,t9.ooag011 ,t10.ooag011 FROM xcca_t",   
               "",
               
                              " LEFT JOIN xcbfl_t t1 ON t1.xcbflent="||g_enterprise||" AND t1.xcbflcomp=xccacomp AND t1.xcbfl001=xcca002 AND t1.xcbfl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=xcca006 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=xcca006 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=xccaownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=xccaowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=xccacrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=xccacrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=xccamodid  ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=xccacnfid  ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=xccapstid  ",
 
               " WHERE xccaent= ? AND xccald=? AND xcca001=? AND xcca003=? AND xcca004=? AND xcca005=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcca_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axcq220_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY xcca_t.xcca002,xcca_t.xcca006,xcca_t.xcca007,xcca_t.xcca008"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axcq220_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axcq220_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xcca_m.xccald,g_xcca_m.xcca001,g_xcca_m.xcca003,g_xcca_m.xcca004,g_xcca_m.xcca005   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xcca_m.xccald,g_xcca_m.xcca001,g_xcca_m.xcca003,g_xcca_m.xcca004, 
          g_xcca_m.xcca005 INTO g_xcca_d[l_ac].xcca002,g_xcca_d[l_ac].xcca006,g_xcca_d[l_ac].xcca007, 
          g_xcca_d[l_ac].xcca008,g_xcca_d[l_ac].xcca101,g_xcca2_d[l_ac].xccaownid,g_xcca2_d[l_ac].xccaowndp, 
          g_xcca2_d[l_ac].xccacrtid,g_xcca2_d[l_ac].xccacrtdp,g_xcca2_d[l_ac].xccacrtdt,g_xcca2_d[l_ac].xccamodid, 
          g_xcca2_d[l_ac].xccamoddt,g_xcca2_d[l_ac].xccacnfid,g_xcca2_d[l_ac].xccacnfdt,g_xcca2_d[l_ac].xccapstid, 
          g_xcca2_d[l_ac].xccapstdt,g_xcca2_d[l_ac].xcca002,g_xcca2_d[l_ac].xcca006,g_xcca2_d[l_ac].xcca007, 
          g_xcca2_d[l_ac].xcca008,g_xcca_d[l_ac].xcca002_desc,g_xcca_d[l_ac].xcca006_desc,g_xcca_d[l_ac].xcca006_desc_desc, 
          g_xcca2_d[l_ac].xccaownid_desc,g_xcca2_d[l_ac].xccaowndp_desc,g_xcca2_d[l_ac].xccacrtid_desc, 
          g_xcca2_d[l_ac].xccacrtdp_desc,g_xcca2_d[l_ac].xccamodid_desc,g_xcca2_d[l_ac].xccacnfid_desc, 
          g_xcca2_d[l_ac].xccapstid_desc   #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
         SELECT SUM(xcbz901) INTO g_xcca_d[l_ac].xcbz901 FROM xcbz_t 
          WHERE xcbzent = g_enterprise
            AND xcbzld = g_xcca_m.xccald
            AND xcbz001 = g_xcca_m.xcca004
            AND xcbz002 = g_xcca_m.xcca005
            AND xcbz003 = g_xcca_d[l_ac].xcca006
            AND xcbz004 = g_xcca_d[l_ac].xcca007
            AND xcbz008 = g_xcca_d[l_ac].xcca008
         LET  g_xcca_d[l_ac].l_diff = g_xcca_d[l_ac].xcca101 - g_xcca_d[l_ac].xcbz901
         #end add-point
      
         #帶出公用欄位reference值
         
         
         #應用 a12 樣板自動產生(Version:4)
 
 
 
 
        
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
 
            CALL g_xcca_d.deleteElement(g_xcca_d.getLength())
      CALL g_xcca2_d.deleteElement(g_xcca2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   ELSE
      CALL axcq220_b_fill_1()
   END IF
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_xcca_d.getLength()
      LET g_xcca_d_mask_o[l_ac].* =  g_xcca_d[l_ac].*
      CALL axcq220_xcca_t_mask()
      LET g_xcca_d_mask_n[l_ac].* =  g_xcca_d[l_ac].*
   END FOR
   
   LET g_xcca2_d_mask_o.* =  g_xcca2_d.*
   FOR l_ac = 1 TO g_xcca2_d.getLength()
      LET g_xcca2_d_mask_o[l_ac].* =  g_xcca2_d[l_ac].*
      CALL axcq220_xcca_t_mask()
      LET g_xcca2_d_mask_n[l_ac].* =  g_xcca2_d[l_ac].*
   END FOR
 
 
   FREE axcq220_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq220.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axcq220_idx_chk()
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
      IF g_detail_idx > g_xcca_d.getLength() THEN
         LET g_detail_idx = g_xcca_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_xcca_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xcca_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_xcca2_d.getLength() THEN
         LET g_detail_idx = g_xcca2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xcca2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xcca2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq220.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq220_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_xcca_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axcq220.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION axcq220_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM xcca_t
    WHERE xccaent = g_enterprise AND xccald = g_xcca_m.xccald AND
                              xcca001 = g_xcca_m.xcca001 AND
                              xcca003 = g_xcca_m.xcca003 AND
                              xcca004 = g_xcca_m.xcca004 AND
                              xcca005 = g_xcca_m.xcca005 AND
 
          xcca002 = g_xcca_d_t.xcca002
      AND xcca006 = g_xcca_d_t.xcca006
      AND xcca007 = g_xcca_d_t.xcca007
      AND xcca008 = g_xcca_d_t.xcca008
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcca_t:",SQLERRMESSAGE 
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
 
{<section id="axcq220.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axcq220_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="axcq220.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axcq220_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="axcq220.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axcq220_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="axcq220.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION axcq220_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_xcca_d[l_ac].xcca002 = g_xcca_d_t.xcca002 
      AND g_xcca_d[l_ac].xcca006 = g_xcca_d_t.xcca006 
      AND g_xcca_d[l_ac].xcca007 = g_xcca_d_t.xcca007 
      AND g_xcca_d[l_ac].xcca008 = g_xcca_d_t.xcca008 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq220.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axcq220_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="axcq220.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axcq220_lock_b(ps_table,ps_page)
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
   #CALL axcq220_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq220.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axcq220_unlock_b(ps_table,ps_page)
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
 
{<section id="axcq220.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axcq220_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xccald,xcca001,xcca003,xcca004,xcca005",TRUE)
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
 
{<section id="axcq220.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axcq220_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xccald,xcca001,xcca003,xcca004,xcca005",FALSE)
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
 
{<section id="axcq220.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axcq220_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq220.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axcq220_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq220.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axcq220_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq220.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axcq220_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq220.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axcq220_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq220.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axcq220_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq220.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axcq220_default_search()
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
      LET ls_wc = ls_wc, " xccald = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xcca001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xcca003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " xcca004 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " xcca005 = '", g_argv[05], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
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
 
{<section id="axcq220.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axcq220_fill_chk(ps_idx)
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
 
{<section id="axcq220.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION axcq220_modify_detail_chk(ps_record)
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
         LET ls_return = "xcca002"
      WHEN "s_detail2"
         LET ls_return = "xccaownid"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="axcq220.mask_functions" >}
&include "erp/axc/axcq220_mask.4gl"
 
{</section>}
 
{<section id="axcq220.state_change" >}
    
 
{</section>}
 
{<section id="axcq220.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axcq220_set_pk_array()
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
   LET g_pk_array[1].values = g_xcca_m.xccald
   LET g_pk_array[1].column = 'xccald'
   LET g_pk_array[2].values = g_xcca_m.xcca001
   LET g_pk_array[2].column = 'xcca001'
   LET g_pk_array[3].values = g_xcca_m.xcca003
   LET g_pk_array[3].column = 'xcca003'
   LET g_pk_array[4].values = g_xcca_m.xcca004
   LET g_pk_array[4].column = 'xcca004'
   LET g_pk_array[5].values = g_xcca_m.xcca005
   LET g_pk_array[5].column = 'xcca005'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axcq220.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axcq220_msgcentre_notify(lc_state)
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
   CALL axcq220_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xcca_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axcq220.other_function" readonly="Y" >}

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
PRIVATE FUNCTION axcq220_default()
   DEFINE  l_glaa001        LIKE glaa_t.glaa001

   #预设当前site的法人，主账套，年度期别，成本计算类型
   CALL s_axc_set_site_default() RETURNING g_xcca_m.xccacomp,g_xcca_m.xccald,g_xcca_m.xcca004,g_xcca_m.xcca005,g_xcca_m.xcca003
   DISPLAY BY NAME g_xcca_m.xccacomp,g_xcca_m.xccald,g_xcca_m.xcca004,g_xcca_m.xcca005,g_xcca_m.xcca003
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcca_m.xccacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcca_m.xccacomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcca_m.xccacomp_desc 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcca_m.xccald
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcca_m.xccald_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcca_m.xccald_desc 

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcca_m.xcca003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcca_m.xcca003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcca_m.xcca003_desc
      
   LET g_xcca_m.xcca001 = '1'
   DISPLAY BY NAME g_xcca_m.xcca001
   
   SELECT glaa001 INTO l_glaa001
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_xcca_m.xccald

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_glaa001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcca_m.xcca001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcca_m.xcca001_desc  
   
   LET g_xcca_m.chk = 'N'
   LET g_chk = 'N'
   DISPLAY BY NAME g_xcca_m.chk   
   
   #特性
   IF cl_get_para(g_enterprise,g_xcca_m.xccacomp,'S-FIN-6013') = 'N' THEN
      CALL cl_set_comp_visible('xcca007',FALSE)
   ELSE
      CALL cl_set_comp_visible('xcca007',TRUE)
   END IF
   #成本域
   IF cl_get_para(g_enterprise,g_xcca_m.xccacomp,'S-FIN-6001') = 'N' THEN
      CALL cl_set_comp_visible('xcca002,xcca002_desc',FALSE)
   ELSE
      CALL cl_set_comp_visible('xcca002,xcca002_desc',TRUE)
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
PRIVATE FUNCTION axcq220_ref()
   DEFINE  l_glaa001        LIKE glaa_t.glaa001
  
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcca_m.xccacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcca_m.xccacomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcca_m.xccacomp_desc 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcca_m.xccald
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcca_m.xccald_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcca_m.xccald_desc 

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcca_m.xcca003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcca_m.xcca003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcca_m.xcca003_desc
      
  LET l_glaa001 = ' '
   CASE g_xcca_m.xcca001
      WHEN '1'
         SELECT glaa001 INTO l_glaa001
          FROM glaa_t
         WHERE glaaent = g_enterprise
           AND glaald  = g_xcca_m.xccald
      WHEN '2'
         SELECT glaa016 INTO l_glaa001
          FROM glaa_t
         WHERE glaaent = g_enterprise
           AND glaald  = g_xcca_m.xccald
      WHEN '3'
         SELECT glaa020 INTO l_glaa001
          FROM glaa_t
         WHERE glaaent = g_enterprise
           AND glaald  = g_xcca_m.xccald
   END CASE
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_glaa001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcca_m.xcca001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcca_m.xcca001_desc
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
PRIVATE FUNCTION axcq220_create_tmp()
   DROP TABLE axcq220_tmp
   CREATE TEMP TABLE axcq220_tmp(
      xcca002   VARCHAR(30),
      xcca006   VARCHAR(40),
      xcca007   VARCHAR(256),
      xcca008   VARCHAR(30),
      xcca101   DECIMAL(20,6),
      xcbz901   DECIMAL(20,6)
      );
   DROP TABLE axcq220_tmp01            #160727-00019#20 Mod  axcq220_xcbz_tmp--> axcq220_tmp01
   CREATE TEMP TABLE axcq220_tmp01(    #160727-00019#20 Mod  axcq220_xcbz_tmp--> axcq220_tmp01
      xcbf001   VARCHAR(10),
      xcbz003   VARCHAR(40),
      xcbz004   VARCHAR(256),
      xcbz008   VARCHAR(30),
      xcbz901   DECIMAL(20,6)
      );
   
   DROP TABLE axcq220_tmp02              #160727-00019#20 Mod  axcq220_head_tmp--> axcq220_tmp02
   CREATE TEMP TABLE axcq220_tmp02(      #160727-00019#20 Mod  axcq220_head_tmp--> axcq220_tmp02
      xccaent   SMALLINT,
      xccacomp  VARCHAR(10),
      xccald    VARCHAR(5),
      xcca001   VARCHAR(1),
      xcca003   VARCHAR(10),
      xcca004   SMALLINT,
      xcca005   SMALLINT
      );   
   DROP TABLE axcq220_tmp03            #160727-00019#20 Mod  axcq220_headbz_tmp--> axcq220_tmp03
   CREATE TEMP TABLE axcq220_tmp03(    #160727-00019#20 Mod  axcq220_headbz_tmp--> axcq220_tmp03
      xcbzent   SMALLINT,
      xcbzcomp  VARCHAR(10),
      xcbzld    VARCHAR(5),      
      xcbz001   SMALLINT,
      xcbz002   SMALLINT
      );   

   DROP TABLE axcq220_tmp04    #用来把xcbz的数量从库存单位xcbz009转换为基础单位imaa006  #160727-00019#20 Mod  axcq220_xcbz_tmp1--> axcq220_tmp04
   CREATE TEMP TABLE axcq220_tmp04(         #160727-00019#20 Mod  axcq220_xcbz_tmp1--> axcq220_tmp04
      xcbzent     SMALLINT,
      xcbzcomp    VARCHAR(10),
      xcbzld      VARCHAR(5),
      xcbzsite    VARCHAR(10),
      xcbz001     SMALLINT,
      xcbz002     SMALLINT,
      xcbz003     VARCHAR(40),
      xcbz004     VARCHAR(256),
      xcbz005     VARCHAR(30),
      xcbz006     VARCHAR(10),
      xcbz007     VARCHAR(10),
      xcbz008     VARCHAR(30),
      xcbz009     VARCHAR(10),
      xcbz101     DECIMAL(20,6),
      xcbz201     DECIMAL(20,6),
      xcbz202     DECIMAL(20,6),
      xcbz203     DECIMAL(20,6),
      xcbz204     DECIMAL(20,6),
      xcbz205     DECIMAL(20,6),
      xcbz206     DECIMAL(20,6),
      xcbz207     DECIMAL(20,6),
      xcbz208     DECIMAL(20,6),
      xcbz209     DECIMAL(20,6),
      xcbz301     DECIMAL(20,6),
      xcbz302     DECIMAL(20,6),
      xcbz303     DECIMAL(20,6),
      xcbz304     DECIMAL(20,6),
      xcbz305     DECIMAL(20,6),
      xcbz306     DECIMAL(20,6),
      xcbz901     DECIMAL(20,6)
      );
      #2015/3/25 liuym add-------str     
      DROP TABLE axcq220_XG_tmp
      CREATE TEMP TABLE axcq220_XG_tmp( 
      xccaent         SMALLINT,
      xccacomp        VARCHAR(10),
      xccald          VARCHAR(5),
      xcca001         VARCHAR(1),
      xcca003         VARCHAR(10),
      xcca004         SMALLINT,
      xcca005         SMALLINT,
      xcca002         VARCHAR(30),
      xcca006         VARCHAR(40),
      xcca007         VARCHAR(256),
      xcca008         VARCHAR(30),
      xcca101         DECIMAL(20,6),
      xcbz901         DECIMAL(20,6),
      diff            DECIMAL(20,6)
      );
      #2015/3/25 liuym add-------end           
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
PRIVATE FUNCTION axcq220_insert_tmp()
   DEFINE l_sql  STRING
   DEFINE l_sql1 STRING
   #liuym 2015/3/25 --add-----str---
   TYPE type_l_xcca_d   RECORD
      xcca002        LIKE xcca_t.xcca002,
      xcca006        LIKE xcca_t.xcca006,
      xcca007        LIKE xcca_t.xcca007,
      xcca008        LIKE xcca_t.xcca008,
      xcca101        LIKE xcca_t.xcca101,
      xcbz901        LIKE xcbz_t.xcbz901,
      diff           LIKE xcbz_t.xcbz901      
      END RECORD
    DEFINE l_xcca_d     type_l_xcca_d
   #liuym 2015/3/25 --add-----end      
   DELETE FROM axcq220_tmp
   DELETE FROM axcq220_tmp01      #160727-00019#20 Mod  axcq220_xcbz_tmp--> axcq220_tmp01
   DELETE FROM axcq220_tmp04     #160727-00019#20 Mod  axcq220_xcbz_tmp1--> axcq220_tmp04

   IF NOT axcq220_convert_xcbz() THEN  #先把xcbz的数量转换成和xccc一个单位的
      RETURN
   END IF
   
   IF cl_null(g_xcca_m.xcca001) AND cl_null(g_xcca_m.xcca003) THEN  #只有xcbz,没有xcca
      IF g_fin_6001 = 'Y' THEN
         CASE g_fin_6002
            WHEN 1
               #170216-00074#1-s-mod
               #LET l_sql = " INSERT INTO axcq220_tmp ",
               #            #" SELECT xcbf001,xcbz003,xcbz004,xcbz008,0,SUM(xcbz901) ",    #160728-00029#1
               #            " SELECT COALESCE(xcbf001,' '),xcbz003,xcbz004,xcbz008,0,SUM(xcbz901) ",    #160728-00029#1
               #            "   FROM axcq220_tmp04 ",            #160727-00019#20 Mod  axcq220_xcbz_tmp1--> axcq220_tmp04
               #            " LEFT JOIN xcbf_t ON xcbfent = xcbzent AND xcbfcomp = xcbzcomp ",
               #            "                     AND xcbf002 = xcbzsite AND xcbf003 = '1' ",
               #            "  WHERE xcbzent = ? AND xcbzcomp = ? AND xcbzld = ? ",
               #            "    AND xcbz001 = ? AND xcbz002 = ?  ",
               #            "  GROUP BY xcbf001,xcbz003,xcbz004,xcbz008 "
               #先前的修改，請看↑
               LET l_sql = " INSERT INTO axcq220_tmp ",
                           " SELECT COALESCE(xcbf001,' '),xcbz003,xcbz004,",g_column,",0,SUM(xcbz901) ", 
                           "   FROM axcq220_tmp04 ",   
                           " LEFT JOIN xcbf_t ON xcbfent = xcbzent AND xcbfcomp = xcbzcomp ",
                           "                     AND xcbf002 = xcbzsite AND xcbf003 = '1' ",
                           "  WHERE xcbzent = ? AND xcbzcomp = ? AND xcbzld = ? ",
                           "    AND xcbz001 = ? AND xcbz002 = ?  ",
                           "  GROUP BY xcbf001,xcbz003,xcbz004 "
               IF g_xcat005 = '3' THEN
                  LET l_sql = l_sql CLIPPED,",xcbz008 "
               END IF
               #170216-00074#1-e-mod
               PREPARE axcq220_xcbz_pre12 FROM l_sql  
               EXECUTE axcq220_xcbz_pre12 USING g_enterprise,g_xcca_m.xccacomp,g_xcca_m.xccald,
                                               g_xcca_m.xcca004,g_xcca_m.xcca005
            WHEN 2
               #170216-00074#1-s-mod
               #LET l_sql = " INSERT INTO axcq220_tmp ",
               #            #" SELECT xcbf001,xcbz003,xcbz004,xcbz008,0,SUM(xcbz901) ",   #160728-00029#1 mark
               #            " SELECT COALESCE(xcbf001,' '),xcbz003,xcbz004,xcbz008,0,SUM(xcbz901) ",   #160728-00029#1 add
               #            "   FROM axcq220_tmp04 ",           #160727-00019#20 Mod  axcq220_xcbz_tmp1--> axcq220_tmp04
               #            " LEFT JOIN xcbf_t ON xcbfent = xcbzent AND xcbfcomp = xcbzcomp ",
               #            "                     AND xcbf002 = xcbz006 AND xcbf003 = '2' ",
               #            "  WHERE xcbzent = ? AND xcbzcomp = ? AND xcbzld = ? ",
               #            "    AND xcbz001 = ? AND xcbz002 = ?  ",
               #            "  GROUP BY xcbf001,xcbz003,xcbz004,xcbz008 "
               #先前的修改，請看↑
               LET l_sql = " INSERT INTO axcq220_tmp ",
                           " SELECT COALESCE(xcbf001,' '),xcbz003,xcbz004,",g_column,",0,SUM(xcbz901) ", 
                           "   FROM axcq220_tmp04 ",  
                           " LEFT JOIN xcbf_t ON xcbfent = xcbzent AND xcbfcomp = xcbzcomp ",
                           "                     AND xcbf002 = xcbz006 AND xcbf003 = '2' ",
                           "  WHERE xcbzent = ? AND xcbzcomp = ? AND xcbzld = ? ",
                           "    AND xcbz001 = ? AND xcbz002 = ?  ",
                           "  GROUP BY xcbf001,xcbz003,xcbz004 "
               IF g_xcat005 = '3' THEN
                  LET l_sql = l_sql CLIPPED,",xcbz008 "
               END IF            
               #170216-00074#1-e-mod
               PREPARE axcq220_xcbz_pre22 FROM l_sql  
               EXECUTE axcq220_xcbz_pre22 USING g_enterprise,g_xcca_m.xccacomp,g_xcca_m.xccald,
                                               g_xcca_m.xcca004,g_xcca_m.xcca005
         END CASE
         
      ELSE
         #170216-00074#1-s-mod
         #LET l_sql = " INSERT INTO axcq220_tmp ",
         #            " SELECT '',xcbz003,xcbz004,xcbz008,0,SUM(xcbz901) ",
         #            "   FROM axcq220_tmp04 ",          #160727-00019#20 Mod  axcq220_xcbz_tmp1--> axcq220_tmp04
         #            "  WHERE xcbzent = ? AND xcbzcomp = ? AND xcbzld = ? ",
         #            "    AND xcbz001 = ? AND xcbz002 = ?  ",
         #            "  GROUP BY xcbz003,xcbz004,xcbz008 "    
         #先前的修改，請看↑
         LET l_sql = " INSERT INTO axcq220_tmp ",
                     " SELECT '',xcbz003,xcbz004,",g_column,",0,SUM(xcbz901) ",
                     "   FROM axcq220_tmp04 ",          #160727-00019#20 Mod  axcq220_xcbz_tmp1--> axcq220_tmp04
                     "  WHERE xcbzent = ? AND xcbzcomp = ? AND xcbzld = ? ",
                     "    AND xcbz001 = ? AND xcbz002 = ?  ",
                     "  GROUP BY xcbz003,xcbz004 "
         IF g_xcat005 = '3' THEN
            LET l_sql = l_sql CLIPPED,",xcbz008 "
         END IF
         #170216-00074#1-e-mod
         PREPARE axcq220_xcbz_pre32 FROM l_sql  
         EXECUTE axcq220_xcbz_pre32 USING g_enterprise,g_xcca_m.xccacomp,g_xcca_m.xccald,
                                        g_xcca_m.xcca004,g_xcca_m.xcca005      
         
      END IF
   ELSE
      LET l_sql = " INSERT INTO axcq220_tmp ",
                   " SELECT xcca002,xcca006,xcca007,xcca008,xcca101,0 ",
                   "   FROM xcca_t ",
                   "  WHERE xccaent = ? AND xccacomp = ? AND xccald = ? ",
                   "    AND xcca004 = ? AND xcca005 = ? AND xcca001 = ? AND xcca003 = ? "
       PREPARE axcq220_xcca_pre FROM l_sql  
       EXECUTE axcq220_xcca_pre USING g_enterprise,g_xcca_m.xccacomp,g_xcca_m.xccald,
                                      g_xcca_m.xcca004,g_xcca_m.xcca005,g_xcca_m.xcca001,g_xcca_m.xcca003  
       IF g_fin_6001 = 'Y' THEN
          CASE g_fin_6002
             WHEN 1
                #170216-00074#1-s-mod
                #LET l_sql = " INSERT INTO axcq220_tmp01 ",          #160727-00019#20 Mod  axcq220_xcbz_tmp--> axcq220_tmp01
                #            #" SELECT xcbf001,xcbz003,xcbz004,xcbz008,SUM(xcbz901) ",     #160728-00029#1 mark
                #            " SELECT COALESCE(xcbf001,' '),xcbz003,xcbz004,xcbz008,SUM(xcbz901) ",     #160728-00029#1 mark
                #            "   FROM axcq220_tmp04 ",        #160727-00019#20 Mod  axcq220_xcbz_tmp1--> axcq220_tmp04
                #            " LEFT JOIN xcbf_t ON xcbfent = xcbzent AND xcbfcomp = xcbzcomp ",
                #            "                     AND xcbf002 = xcbzsite AND xcbf003 = '1' ",
                #            "  WHERE xcbzent = ? AND xcbzcomp = ? AND xcbzld = ? ",
                #            "    AND xcbz001 = ? AND xcbz002 = ?  ",
                #            "  GROUP BY xcbf001,xcbz003,xcbz004,xcbz008 "
                ##先前的修改，請看↑
                LET l_sql = " INSERT INTO axcq220_tmp01 ",
                            " SELECT COALESCE(xcbf001,' '),xcbz003,xcbz004,",g_column,",SUM(xcbz901) ",
                            "   FROM axcq220_tmp04 ",   
                            " LEFT JOIN xcbf_t ON xcbfent = xcbzent AND xcbfcomp = xcbzcomp ",
                            "                     AND xcbf002 = xcbzsite AND xcbf003 = '1' ",
                            "  WHERE xcbzent = ? AND xcbzcomp = ? AND xcbzld = ? ",
                            "    AND xcbz001 = ? AND xcbz002 = ?  ",
                            "  GROUP BY xcbf001,xcbz003,xcbz004 "
                IF g_xcat005 = '3' THEN
                  LET l_sql = l_sql CLIPPED,",xcbz008 "
               END IF
                #170216-00074#1-e-mod
                PREPARE axcq220_xcbz_pre1 FROM l_sql  
                EXECUTE axcq220_xcbz_pre1 USING g_enterprise,g_xcca_m.xccacomp,g_xcca_m.xccald,
                                                g_xcca_m.xcca004,g_xcca_m.xcca005
             WHEN 2
                #170216-00074#1-s-mod
                #LET l_sql = " INSERT INTO axcq220_tmp01 ",          #160727-00019#20 Mod  axcq220_xcbz_tmp--> axcq220_tmp01
                #            #" SELECT xcbf001,xcbz003,xcbz004,xcbz008,SUM(xcbz901) ",    #160728-00029#1 mark
                #            " SELECT COALESCE(xcbf001,' '),xcbz003,xcbz004,xcbz008,SUM(xcbz901) ",    #160728-00029#1 mark
                #            "   FROM axcq220_tmp04 ",    #160727-00019#20 Mod  axcq220_xcbz_tmp1--> axcq220_tmp04
                #            " LEFT JOIN xcbf_t ON xcbfent = xcbzent AND xcbfcomp = xcbzcomp ",
                #            "                     AND xcbf002 = xcbz006 AND xcbf003 = '2' ",
                #            "  WHERE xcbzent = ? AND xcbzcomp = ? AND xcbzld = ? ",
                #            "    AND xcbz001 = ? AND xcbz002 = ?  ",
                #            "  GROUP BY xcbf001,xcbz003,xcbz004,xcbz008 "
                #先前的修改，請看↑
                LET l_sql = " INSERT INTO axcq220_tmp01 ",  
                            " SELECT COALESCE(xcbf001,' '),xcbz003,xcbz004,",g_column,",SUM(xcbz901) ",   
                            "   FROM axcq220_tmp04 ", 
                            " LEFT JOIN xcbf_t ON xcbfent = xcbzent AND xcbfcomp = xcbzcomp ",
                            "                     AND xcbf002 = xcbz006 AND xcbf003 = '2' ",
                            "  WHERE xcbzent = ? AND xcbzcomp = ? AND xcbzld = ? ",
                            "    AND xcbz001 = ? AND xcbz002 = ?  ",
                            "  GROUP BY xcbf001,xcbz003,xcbz004 "
                IF g_xcat005 = '3' THEN
                   LET l_sql = l_sql CLIPPED,",xcbz008 "
                END IF
                #170216-00074#1-e-mod
                PREPARE axcq220_xcbz_pre2 FROM l_sql  
                EXECUTE axcq220_xcbz_pre2 USING g_enterprise,g_xcca_m.xccacomp,g_xcca_m.xccald,
                                                g_xcca_m.xcca004,g_xcca_m.xcca005
          END CASE
          LET l_sql1 ="MERGE INTO axcq220_tmp t0 ",
                      "      USING (SELECT xcbf001,xcbz003,xcbz004,xcbz008,xcbz901 FROM axcq220_tmp01) t1  ",       #160727-00019#20 Mod  axcq220_xcbz_tmp--> axcq220_tmp01
                      "         ON (t0.xcca002 = t1.xcbf001 AND t0.xcca006 = t1.xcbz003 AND t0.xcca007 = t1.xcbz004 AND t0.xcca008 = t1.xcbz008 )  ",    
                      " WHEN MATCHED THEN ",
                      "      UPDATE SET t0.xcbz901 = t1.xcbz901 ",
                      " WHEN NOT MATCHED THEN ",
                      "      INSERT VALUES (t1.xcbf001,t1.xcbz003,t1.xcbz004,t1.xcbz008,0,t1.xcbz901)"    
           PREPARE axcq220_merge1 FROM l_sql1
           EXECUTE axcq220_merge1
       ELSE
          #170216-00074#1-s-mod
          #LET l_sql = " INSERT INTO axcq220_tmp01 ",       #160727-00019#20 Mod  axcq220_xcbz_tmp--> axcq220_tmp01
          #            " SELECT '',xcbz003,xcbz004,xcbz008,SUM(xcbz901) ",
          #            "   FROM axcq220_tmp04 ",        #160727-00019#20 Mod  axcq220_xcbz_tmp1--> axcq220_tmp04
          #            "  WHERE xcbzent = ? AND xcbzcomp = ? AND xcbzld = ? ",
          #            "    AND xcbz001 = ? AND xcbz002 = ?  ",
          #            "  GROUP BY xcbz003,xcbz004,xcbz008 "
          #先前的修改，請看↑
          LET l_sql = " INSERT INTO axcq220_tmp01 ",
                      " SELECT '',xcbz003,xcbz004,",g_column,",SUM(xcbz901) ",
                      "   FROM axcq220_tmp04 ",     
                      "  WHERE xcbzent = ? AND xcbzcomp = ? AND xcbzld = ? ",
                      "    AND xcbz001 = ? AND xcbz002 = ?  ",
                      "  GROUP BY xcbz003,xcbz004 "
          IF g_xcat005 = '3' THEN
             LET l_sql = l_sql CLIPPED,",xcbz008 "
          END IF
          #170216-00074#1-e-mod
          PREPARE axcq220_xcbz_pre FROM l_sql  
          EXECUTE axcq220_xcbz_pre USING g_enterprise,g_xcca_m.xccacomp,g_xcca_m.xccald,
                                         g_xcca_m.xcca004,g_xcca_m.xcca005
       
          LET l_sql1 ="MERGE INTO axcq220_tmp t0 ",
                      "      USING (SELECT xcbf001,xcbz003,xcbz004,xcbz008,xcbz901 FROM axcq220_tmp01) t1  ",      #160727-00019#20 Mod  axcq220_xcbz_tmp--> axcq220_tmp01
       #               "         ON (t0.xcca002 = t1.xcbz002 AND t0.xcca006 = t1.xcbz003 AND t0.xcca007 = t1.xcbz004 AND t0.xcca008 = t1.xcbz008 )  ",
                      "         ON (t0.xcca006 = t1.xcbz003 AND t0.xcca007 = t1.xcbz004 AND t0.xcca008 = t1.xcbz008 )  ",
                      " WHEN MATCHED THEN ",
                      "      UPDATE SET t0.xcbz901 = t1.xcbz901 ",
                      " WHEN NOT MATCHED THEN ",
                      "      INSERT VALUES (t1.xcbf001,t1.xcbz003,t1.xcbz004,t1.xcbz008,0,t1.xcbz901)"    
           PREPARE axcq220_merge FROM l_sql1
           EXECUTE axcq220_merge    
       END IF
   END IF
   #将单头数据+单身数据存放到XG临时表中 liuym 2015/3/25------str-----
   LET l_sql="SELECT UNIQUE xcca002,xcca006,xcca007,xcca008,xcca101,xcbz901,xcca101-xcbz901  FROM axcq220_tmp"
   PREPARE axcq220_XG_pre FROM l_sql
   DECLARE axcq220_XG_cs CURSOR FOR axcq220_XG_pre
   FOREACH axcq220_XG_cs INTO l_xcca_d.xcca002,l_xcca_d.xcca006,l_xcca_d.xcca007,l_xcca_d.xcca008,l_xcca_d.xcca101,l_xcca_d.xcbz901,l_xcca_d.diff
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH XG_tmp:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      INSERT INTO axcq220_XG_tmp  (xccaent,xccacomp,xccald,xcca001,xcca003,xcca004,xcca005,
                                xcca002,xcca006,xcca007,xcca008,xcca101,xcbz901,diff )
                        VALUES (g_enterprise,g_xcca_m.xccacomp,g_xcca_m.xccald,g_xcca_m.xcca001,g_xcca_m.xcca003,g_xcca_m.xcca004,g_xcca_m.xcca005,
                                l_xcca_d.xcca002,l_xcca_d.xcca006,l_xcca_d.xcca007,l_xcca_d.xcca008,l_xcca_d.xcca101,l_xcca_d.xcbz901,l_xcca_d.diff)
      
   END FOREACH
   FREE axcq220_XG_pre
   #liuym 2015/3/25------end-----                                
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
PRIVATE FUNCTION axcq220_b_fill_1()
   CALL g_xcca_d.clear()
   #161013-00040#1---s
   #若不按特性计算成本，则按其他条件group显示
   #LET g_sql = "SELECT  UNIQUE xcca002,xcca006,xcca007,xcca008,xcca101,xcbz901,xcca101-xcbz901,
   #             t1.xcbfl003 ,t2.imaal003 ,t3.imaal004,t4.imaa006 FROM axcq220_tmp", 
   #       
   #            "",
   #            
   #                           " LEFT JOIN xcbfl_t t1 ON t1.xcbflent='"||g_enterprise||"' AND t1.xcbflcomp='"||g_xcca_m.xccacomp||"' AND t1.xcbfl001=xcca002 AND t1.xcbfl002='"||g_dlang||"' ",
   #            " LEFT JOIN imaal_t t2 ON t2.imaalent='"||g_enterprise||"' AND t2.imaal001=xcca006 AND t2.imaal002='"||g_dlang||"' ",
   #            " LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xcca006 AND t3.imaal002='"||g_dlang||"' ",
   #            " LEFT JOIN imaa_t t4 ON t4.imaaent='"||g_enterprise||"' AND t4.imaa001=xcca006  "
 
   IF cl_get_para(g_enterprise,g_xcca_m.xccacomp,'S-FIN-6013') = 'N' THEN
      LET g_sql = "SELECT  UNIQUE xcca002,xcca006,' ',xcca008,SUM(xcca101),SUM(xcbz901),SUM(xcca101-xcbz901),
                   t1.xcbfl003 ,t2.imaal003 ,t3.imaal004,t4.imaa006 FROM axcq220_tmp", 
             
                  "",
                  
                                 " LEFT JOIN xcbfl_t t1 ON t1.xcbflent='"||g_enterprise||"' AND t1.xcbflcomp='"||g_xcca_m.xccacomp||"' AND t1.xcbfl001=xcca002 AND t1.xcbfl002='"||g_dlang||"' ",
                  " LEFT JOIN imaal_t t2 ON t2.imaalent='"||g_enterprise||"' AND t2.imaal001=xcca006 AND t2.imaal002='"||g_dlang||"' ",
                  " LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xcca006 AND t3.imaal002='"||g_dlang||"' ",
                  " LEFT JOIN imaa_t t4 ON t4.imaaent='"||g_enterprise||"' AND t4.imaa001=xcca006  "   
   ELSE
      LET g_sql = "SELECT  UNIQUE xcca002,xcca006,xcca007,xcca008,xcca101,xcbz901,xcca101-xcbz901,
                   t1.xcbfl003 ,t2.imaal003 ,t3.imaal004,t4.imaa006 FROM axcq220_tmp", 
             
                  "",
                  
                                 " LEFT JOIN xcbfl_t t1 ON t1.xcbflent='"||g_enterprise||"' AND t1.xcbflcomp='"||g_xcca_m.xccacomp||"' AND t1.xcbfl001=xcca002 AND t1.xcbfl002='"||g_dlang||"' ",
                  " LEFT JOIN imaal_t t2 ON t2.imaalent='"||g_enterprise||"' AND t2.imaal001=xcca006 AND t2.imaal002='"||g_dlang||"' ",
                  " LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xcca006 AND t3.imaal002='"||g_dlang||"' ",
                  " LEFT JOIN imaa_t t4 ON t4.imaaent='"||g_enterprise||"' AND t4.imaa001=xcca006  " 
   END IF               
   #161013-00040#1---e
   
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcca_t")
   END IF
   
   #add-point:b_fill段sql_after
   #161013-00040#1---s
   IF cl_get_para(g_enterprise,g_xcca_m.xccacomp,'S-FIN-6013') = 'N' THEN
      LET g_sql = g_sql CLIPPED," GROUP BY xcca002,xcca006,' ',xcca008,t1.xcbfl003 ,t2.imaal003 ,t3.imaal004,t4.imaa006 "
   END IF   
   #161013-00040#1---e
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axcq220_fill_chk(1) THEN
      #161013-00040#1---s
      #LET g_sql = g_sql, " ORDER BY xcca002,xcca006,xcca007,xcca008"
      IF cl_get_para(g_enterprise,g_xcca_m.xccacomp,'S-FIN-6013') = 'N' THEN
         LET g_sql = g_sql, " ORDER BY xcca002,xcca006,xcca008"
      ELSE
         LET g_sql = g_sql, " ORDER BY xcca002,xcca006,xcca007,xcca008"
      END IF     
      #161013-00040#1---e
      
      #add-point:b_fill段fill_before

      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE axcq220_pb1 FROM g_sql
      DECLARE b_fill_cs1 CURSOR FOR axcq220_pb1
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
     
                                               
      FOREACH b_fill_cs1 INTO g_xcca_d[l_ac].xcca002,g_xcca_d[l_ac].xcca006,g_xcca_d[l_ac].xcca007,g_xcca_d[l_ac].xcca008, 
          g_xcca_d[l_ac].xcca101,g_xcca_d[l_ac].xcbz901,g_xcca_d[l_ac].l_diff,
          g_xcca_d[l_ac].xcca002_desc,g_xcca_d[l_ac].xcca006_desc,g_xcca_d[l_ac].xcca006_desc_desc,g_xcca_d[l_ac].imaa006

                             
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
      
         #帶出公用欄位reference值
         
         
 
        
         #add-point:單身資料抓取
         IF g_xcca_m.chk = 'Y' AND g_xcca_d[l_ac].l_diff = 0 THEN
            CALL g_xcca_d.deleteElement(l_ac)
            CONTINUE FOREACH
         END IF
         CALL s_desc_get_unit_desc(g_xcca_d[l_ac].imaa006)
         RETURNING g_xcca_d[l_ac].imaa006_desc
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
 
            CALL g_xcca_d.deleteElement(g_xcca_d.getLength())
 
      
   END IF
   FREE axcq220_pb1
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
PRIVATE FUNCTION axcq220_visible()
   CALL cl_get_para(g_enterprise,g_xcca_m.xccacomp,'S-FIN-6001') RETURNING g_fin_6001   #采用成本域否
   CALL cl_get_para(g_enterprise,g_xcca_m.xccacomp,'S-FIN-6002') RETURNING g_fin_6002   #成本域类型
   CALL cl_get_para(g_enterprise,g_xcca_m.xccacomp,'S-FIN-6013') RETURNING g_fin_6013   #按料件特性计算成本否
   #成本域显示
   IF g_fin_6001 = 'Y' THEN
      CALL cl_set_comp_visible('xcca002,xcca002_desc',TRUE)
   ELSE
      CALL cl_set_comp_visible('xcca002,xcca002_desc',FALSE)
   END IF
   #特性显示
   IF g_fin_6013 = 'Y' THEN
      CALL cl_set_comp_visible('xcca007',TRUE)
   ELSE
      CALL cl_set_comp_visible('xcca007',FALSE)
   END IF
   #批号显示
   SELECT xcat005 INTO g_xcat005 
     FROM xcat_t 
     WHERE xcatent = g_enterprise AND xcat001 = g_xcca_m.xcca003
   #xcat005='3'時，給xcbz008，其他的給空白，後面組欄位會用到  #170216-00074#1-add
   IF g_xcat005 = '3' THEN
      LET g_column = 'xcbz008' #170216-00074#1-add
      CALL cl_set_comp_visible('xcca008',TRUE)
   ELSE
      LET g_column = "' '"  #170216-00074#1-add
      CALL cl_set_comp_visible('xcca008',FALSE)
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
PRIVATE FUNCTION axcq220_insert_head()
   DEFINE l_sql STRING
   DEFINE l_wc1 STRING
   LET l_wc1 = g_wc   
   LET l_wc1 = cl_replace_str(l_wc1,"xccacomp","xcbzcomp")
   LET l_wc1 = cl_replace_str(l_wc1,"xccald","xcbzld")
   LET l_wc1 = cl_replace_str(l_wc1,"xcca004","xcbz001")
   LET l_wc1 = cl_replace_str(l_wc1,"xcca005","xcbz002")
   LET l_sql = 
   " INSERT INTO axcq220_tmp02 ",           #160727-00019#20 Mod  axcq220_head_tmp--> axcq220_tmp02
   " SELECT DISTINCT xccaent,xccacomp,xccald,xcca001,xcca003,xcca004,xcca005 ",
   "   FROM xcca_t WHERE xccaent = '",g_enterprise,"' AND ",g_wc," AND ",g_wc1
   PREPARE axcq220_head_pre FROM l_sql  
   EXECUTE axcq220_head_pre 
   
   LET l_sql =   
   " INSERT INTO axcq220_tmp03 ",    #160727-00019#20 Mod  axcq220_headbz_tmp--> axcq220_tmp03
   " SELECT DISTINCT xcbzent,xcbzcomp,xcbzld,xcbz001,xcbz002 ",
   "   FROM xcbz_t ",
   "  WHERE xcbzent = '",g_enterprise,"' AND ",l_wc1
   PREPARE axcq220_head_xcbz_pre FROM l_sql  
   EXECUTE axcq220_head_xcbz_pre 
   LET l_sql = 
   "MERGE INTO axcq220_tmp02 t0 ",           #160727-00019#20 Mod  axcq220_head_tmp--> axcq220_tmp02
   "      USING (SELECT xcbzent,xcbzcomp,xcbzld,xcbz001,xcbz002 FROM axcq220_tmp03) t1 ",        #160727-00019#20 Mod  axcq220_headbz_tmp--> axcq220_tmp03
   "      ON (t0.xccacomp = t1.xcbzcomp AND t0.xccald = t1.xcbzld AND t0.xcca004 = t1.xcbz001 AND t0.xcca005 = t1.xcbz002) "
#   IF cl_null(g_wc1) THEN
      LET l_sql = l_sql CLIPPED,"WHEN NOT MATCHED THEN  INSERT VALUES(t1.xcbzent,t1.xcbzcomp,t1.xcbzld,'','',t1.xcbz001,t1.xcbz002) "    
#   END IF
   PREPARE axcq220_head_merge FROM l_sql  
   EXECUTE axcq220_head_merge  
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
PRIVATE FUNCTION axcq220_fetch1(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   CASE p_flag
      WHEN 'F' 
         LET g_current_idx = 1
      WHEN 'L' 
         LET g_current_idx = g_header_cnt
         LET g_current_idx = g_browser1.getLength()              
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
         
         IF g_jump > 0 AND g_jump <= g_browser1.getLength() THEN
            LET g_current_idx = g_jump
         END IF
 
         LET g_no_ask = FALSE  
   END CASE    
   
   #若無資料則離開
   IF g_current_idx = 0 THEN
      RETURN
   END IF
   
   #CALL axcq220_browser_fill(p_flag)
   
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
   IF g_current_idx = 0 OR g_browser1.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_browser1.getLength() THEN
      LET g_current_idx = g_browser1.getLength()
   END IF
   LET g_xcca_m.xccacomp = g_browser1[g_current_idx].b_xccacomp
   LET g_xcca_m.xccald = g_browser1[g_current_idx].b_xccald
   LET g_xcca_m.xcca001 = g_browser1[g_current_idx].b_xcca001
   LET g_xcca_m.xcca003 = g_browser1[g_current_idx].b_xcca003
   LET g_xcca_m.xcca004 = g_browser1[g_current_idx].b_xcca004
   LET g_xcca_m.xcca005 = g_browser1[g_current_idx].b_xcca005
 
   
   #重讀DB,因TEMP有不被更新特性
#   EXECUTE axcq220_master_referesh USING g_xcca_m.xccald,g_xcca_m.xcca001,g_xcca_m.xcca003,g_xcca_m.xcca004, 
#       g_xcca_m.xcca005 INTO g_xcca_m.xccacomp,g_xcca_m.xcca004,g_xcca_m.xcca001,g_xcca_m.xccald,g_xcca_m.xcca005, 
#       g_xcca_m.xcca003,g_xcca_m.xccacomp_desc,g_xcca_m.xccald_desc,g_xcca_m.xcca003_desc
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "xcca_t" 
#      LET g_errparam.code   = SQLCA.sqlcode 
#      LET g_errparam.popup  = TRUE 
#      CALL cl_err()
#      INITIALIZE g_xcca_m.* TO NULL
#      RETURN
#   END IF
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq220_set_act_visible()
   CALL axcq220_set_act_no_visible()
 
   #保存單頭舊值
   LET g_xcca_m_t.* = g_xcca_m.*
   LET g_xcca_m_o.* = g_xcca_m.*
   

   #重新顯示   
   CALL axcq220_show()
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
PRIVATE FUNCTION axcq220_convert_xcbz()
   DEFINE l_sql     STRING
   DEFINE r_success LIKE type_t.num5
   DEFINE l_success LIKE type_t.num5
   #161109-00085#25-s mod
#   DEFINE l_xcbz    RECORD LIKE xcbz_t.*   #161109-00085#25-s mark
   DEFINE l_xcbz    RECORD  #料件庫存量按帳套期統計檔
       xcbzent LIKE xcbz_t.xcbzent, #企業編號
       xcbzcomp LIKE xcbz_t.xcbzcomp, #法人組織
       xcbzld LIKE xcbz_t.xcbzld, #帳套
       xcbzsite LIKE xcbz_t.xcbzsite, #營運據點
       xcbz001 LIKE xcbz_t.xcbz001, #年度
       xcbz002 LIKE xcbz_t.xcbz002, #期別
       xcbz003 LIKE xcbz_t.xcbz003, #料件編號
       xcbz004 LIKE xcbz_t.xcbz004, #特性
       xcbz005 LIKE xcbz_t.xcbz005, #庫存管理特徵
       xcbz006 LIKE xcbz_t.xcbz006, #倉庫編碼
       xcbz007 LIKE xcbz_t.xcbz007, #儲位編號
       xcbz008 LIKE xcbz_t.xcbz008, #批號
       xcbz009 LIKE xcbz_t.xcbz009, #單位
       xcbz101 LIKE xcbz_t.xcbz101, #上期結存數量
       xcbz201 LIKE xcbz_t.xcbz201, #本期採購入庫數量
       xcbz202 LIKE xcbz_t.xcbz202, #本期委外入庫數量
       xcbz203 LIKE xcbz_t.xcbz203, #本期工單入庫數量
       xcbz204 LIKE xcbz_t.xcbz204, #本期重工領出數量
       xcbz205 LIKE xcbz_t.xcbz205, #本期重工入庫數量
       xcbz206 LIKE xcbz_t.xcbz206, #本期雜項入庫數量
       xcbz207 LIKE xcbz_t.xcbz207, #本期調整入庫數量
       xcbz208 LIKE xcbz_t.xcbz208, #本期銷退入庫數量
       xcbz209 LIKE xcbz_t.xcbz209, #本期其他入庫數量
       xcbz301 LIKE xcbz_t.xcbz301, #本期工單領用數量
       xcbz302 LIKE xcbz_t.xcbz302, #本期銷貨數量
       xcbz303 LIKE xcbz_t.xcbz303, #本期銷退數量
       xcbz304 LIKE xcbz_t.xcbz304, #本期雜發數量
       xcbz305 LIKE xcbz_t.xcbz305, #本期盤盈虧數量
       xcbz306 LIKE xcbz_t.xcbz306, #本期其他出庫數量
       xcbz901 LIKE xcbz_t.xcbz901  #期末結存數量
          END RECORD
   #161109-00085#25-e mod
   DEFINE l_qty     LIKE xcbz_t.xcbz901
   DEFINE l_imaa006 LIKE imaa_t.imaa006
   DEFINE l_xcat005 LIKE xcat_t.xcat005
   
   INITIALIZE l_xcbz.* TO NULL
   LET r_success = TRUE
   LET l_sql = " INSERT INTO axcq220_tmp04 ",       #160727-00019#20 Mod  axcq220_xcbz_tmp1--> axcq220_tmp04
               #161109-00085#25-s mod
#               " SELECT xcbz_t.* FROM xcbz_t,inaa_t ",   #161109-00085#25-s mark
               " SELECT xcbz_t.xcbzent,xcbz_t.xcbzcomp,xcbz_t.xcbzld,xcbz_t.xcbzsite,xcbz_t.xcbz001,xcbz_t.xcbz002,
                        xcbz_t.xcbz003,xcbz_t.xcbz004,xcbz_t.xcbz005,xcbz_t.xcbz006,xcbz_t.xcbz007,xcbz_t.xcbz008,
                        xcbz_t.xcbz009,xcbz_t.xcbz101,xcbz_t.xcbz201,xcbz_t.xcbz202,xcbz_t.xcbz203,xcbz_t.xcbz204,
                        xcbz_t.xcbz205,xcbz_t.xcbz206,xcbz_t.xcbz207,xcbz_t.xcbz208,xcbz_t.xcbz209,xcbz_t.xcbz301,
                        xcbz_t.xcbz302,xcbz_t.xcbz303,xcbz_t.xcbz304,xcbz_t.xcbz305,xcbz_t.xcbz306,xcbz_t.xcbz901 
                    FROM xcbz_t,inaa_t ",
               #161109-00085#25-e mod
               "  WHERE xcbzent = ? AND xcbzcomp = ? AND xcbzld = ? ",
               "    AND xcbz001 = ? AND xcbz002 = ?  ",
               "    AND inaaent  = xcbzent ",
               "    AND inaasite = xcbzsite ",
               "    AND inaa001  = xcbz006 ",
               "    AND inaa010  = 'Y' "

   PREPARE axcq220_ins_xcbz_pre FROM l_sql
   EXECUTE axcq220_ins_xcbz_pre USING g_enterprise,g_xcca_m.xccacomp,g_xcca_m.xccald,
                                   g_xcca_m.xcca004,g_xcca_m.xcca005

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins axcq220_tmp04'          #160727-00019#20 Mod  axcq220_xcbz_tmp1--> axcq220_tmp04
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = 'N'
      RETURN r_success
   END IF
   #161109-00085#25-s mod
#   LET l_sql = " SELECT * FROM axcq220_tmp04 "            #160727-00019#20 Mod  axcq220_xcbz_tmp1--> axcq220_tmp04   #161109-00085#25-s mark
   LET l_sql = " SELECT xcbzent,xcbzcomp,xcbzld,xcbzsite,xcbz001,xcbz002,xcbz003,xcbz004,  
                        xcbz005,xcbz006,xcbz007,xcbz008,xcbz009,xcbz101,xcbz201,  
                        xcbz202,xcbz203,xcbz204,xcbz205,xcbz206,xcbz207,xcbz208,  
                        xcbz209,xcbz301,xcbz302,xcbz303,xcbz304,xcbz305,xcbz306,xcbz901   
                    FROM axcq220_tmp04 "
   #161109-00085#25-e mod
   PREPARE axcq220_sel_xcbz_pre FROM l_sql
   DECLARE axcq220_sel_xcbz_cs CURSOR FOR axcq220_sel_xcbz_pre
   
   #161109-00085#25-s mod
#   FOREACH axcq220_sel_xcbz_cs INTO l_xcbz.*   #161109-00085#25-s mark
   FOREACH axcq220_sel_xcbz_cs INTO l_xcbz.xcbzent,l_xcbz.xcbzcomp,l_xcbz.xcbzld,l_xcbz.xcbzsite,l_xcbz.xcbz001,
                                    l_xcbz.xcbz002,l_xcbz.xcbz003,l_xcbz.xcbz004,l_xcbz.xcbz005,l_xcbz.xcbz006,
                                    l_xcbz.xcbz007,l_xcbz.xcbz008,l_xcbz.xcbz009,l_xcbz.xcbz101,l_xcbz.xcbz201,
                                    l_xcbz.xcbz202,l_xcbz.xcbz203,l_xcbz.xcbz204,l_xcbz.xcbz205,l_xcbz.xcbz206,
                                    l_xcbz.xcbz207,l_xcbz.xcbz208,l_xcbz.xcbz209,l_xcbz.xcbz301,l_xcbz.xcbz302,
                                    l_xcbz.xcbz303,l_xcbz.xcbz304,l_xcbz.xcbz305,l_xcbz.xcbz306,l_xcbz.xcbz901
   #161109-00085#25-e mod
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:axcq220_sel_xcbz_cs"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = 'N'
         RETURN r_success
      END IF

 #先抓出imaa006
      LET l_imaa006 = ''
      SELECT imaa006 INTO l_imaa006 FROM imaa_t
       WHERE imaaent = g_enterprise
         AND imaa001 = l_xcbz.xcbz003

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "convert xcbz|sel imaa006"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = 'N'
         RETURN r_success
      END IF

      IF l_imaa006 = l_xcbz.xcbz009 THEN
         CONTINUE FOREACH
      END IF

      IF l_xcbz.xcbz901 IS NULL THEN LET l_xcbz.xcbz901 = 0 END IF
      CALL s_aooi250_convert_qty(l_xcbz.xcbz003,l_xcbz.xcbz009,l_imaa006,l_xcbz.xcbz901)
         RETURNING l_success,l_qty
      IF l_success THEN
         LET l_xcbz.xcbz901 = l_qty
      ELSE
         LET l_xcbz.xcbz901 = 0   #表示有异常
      END IF

      UPDATE axcq220_tmp04 SET xcbz901 = l_xcbz.xcbz901      #160727-00019#20 Mod  axcq220_xcbz_tmp1--> axcq220_tmp04
       WHERE xcbzent  = g_enterprise
         AND xcbzld   = l_xcbz.xcbzld
         AND xcbzsite = l_xcbz.xcbzsite
         AND xcbz001  = l_xcbz.xcbz001
         AND xcbz002  = l_xcbz.xcbz002
         AND xcbz003  = l_xcbz.xcbz003
         AND xcbz004  = l_xcbz.xcbz004
         AND xcbz005  = l_xcbz.xcbz005
         AND xcbz006  = l_xcbz.xcbz006
         AND xcbz007  = l_xcbz.xcbz007
         AND xcbz008  = l_xcbz.xcbz008
         AND xcbz009  = l_xcbz.xcbz009

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "upd axcq220_tmp04"        #160727-00019#20 Mod  axcq220_xcbz_tmp1--> axcq220_tmp04
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = 'N'
         RETURN r_success
      END IF

   END FOREACH
   FREE axcq220_sel_xcbz_cs
   
   #判断成本计算方式的，计价方式 xcat005 = 3，分批成本，则把批号update成空格
   #特性也可以放这里做
   LET l_xcat005 = NULL
   SELECT xcat005 INTO l_xcat005 FROM xcat_t 
    WHERE xcatent = g_enterprise
      AND xcat001 = g_xcca_m.xcca003
      
   IF l_xcat005 <> '3' THEN
      UPDATE axcq220_tmp04 SET xcbz008 = ' '       #160727-00019#20 Mod  axcq220_xcbz_tmp1--> axcq220_tmp04
   END IF

   
   RETURN r_success
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
# Date & Author..: 2015/3/25  By liuym
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq220_ins_XG_tmp()
DEFINE l_li       LIKE type_t.num5
   DELETE FROM axcq220_tmp
   DELETE FROM axcq220_XG_tmp
   FOR l_li=1 TO g_browser1.getLength()
      LET g_xcca_m.xccacomp = g_browser1[l_li].b_xccacomp
      LET g_xcca_m.xccald   = g_browser1[l_li].b_xccald
      LET g_xcca_m.xcca001 = g_browser1[l_li].b_xcca001
      LET g_xcca_m.xcca003 = g_browser1[l_li].b_xcca003
      LET g_xcca_m.xcca004 = g_browser1[l_li].b_xcca004
      LET g_xcca_m.xcca005 = g_browser1[l_li].b_xcca005
      CALL axcq220_insert_tmp()
   END FOR
END FUNCTION

 
{</section>}
 
