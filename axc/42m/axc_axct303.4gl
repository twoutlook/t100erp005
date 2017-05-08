#該程式未解開Section, 採用最新樣板產出!
{<section id="axct303.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2017-02-22 15:35:23), PR版次:0010(2017-02-22 16:12:04)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000068
#+ Filename...: axct303
#+ Description: 製程在製成本開帳作業
#+ Creator....: 03297(2014-12-05 11:26:31)
#+ Modifier...: 01996 -SD/PR- 01996
 
{</section>}
 
{<section id="axct303.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#12   2016/04/26 By 07675     將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160926-00006#1    2016/09/29 By zhujing   新增时，法人和账套应可以同时清空
#160802-00020#5    2016/10/12 By 02040     增加帳套權限管控、法人權限管控
#160929-00005#4    2016/10/18 By 02295     程式栏位控管检查调整
#161013-00051#1    2016/10/18 By shiun     整批調整據點組織開窗
#161109-00085#22   2016/11/16 By 08993     整批調整系統星號寫法
#161121-00018#11   2017/02/22 By xujing    工單開窗改為單頭的開窗，作業編號開窗改為直接開aeci004，且可以輸入END，元件料號需要可以輸入DL+OH+SUB
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
PRIVATE type type_g_xccv_m        RECORD
       xccvcomp LIKE xccv_t.xccvcomp, 
   xccvcomp_desc LIKE type_t.chr80, 
   xccv004 LIKE xccv_t.xccv004, 
   xccv005 LIKE xccv_t.xccv005, 
   xccvld LIKE xccv_t.xccvld, 
   xccvld_desc LIKE type_t.chr80, 
   xccv003 LIKE xccv_t.xccv003, 
   xccv003_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xccv_d        RECORD
       xccv001 LIKE xccv_t.xccv001, 
   xccv006 LIKE xccv_t.xccv006, 
   xccv007 LIKE xccv_t.xccv007, 
   xccv007_desc LIKE type_t.chr500, 
   xccv008 LIKE xccv_t.xccv008, 
   xccv009 LIKE xccv_t.xccv009, 
   xccv009_desc LIKE type_t.chr500, 
   xccv009_desc_desc LIKE type_t.chr500, 
   xccv010 LIKE xccv_t.xccv010, 
   xccv011 LIKE xccv_t.xccv011, 
   xccv002 LIKE xccv_t.xccv002, 
   xccv002_desc LIKE type_t.chr500, 
   xccv101 LIKE xccv_t.xccv101, 
   xccv102 LIKE xccv_t.xccv102, 
   xccv102a LIKE xccv_t.xccv102a, 
   xccv102b LIKE xccv_t.xccv102b, 
   xccv102c LIKE xccv_t.xccv102c, 
   xccv102d LIKE xccv_t.xccv102d, 
   xccv102e LIKE xccv_t.xccv102e, 
   xccv102f LIKE xccv_t.xccv102f, 
   xccv102g LIKE xccv_t.xccv102g, 
   xccv102h LIKE xccv_t.xccv102h
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_xccv2_d        RECORD
       xccv001 LIKE xccv_t.xccv001, 
   xccv006 LIKE xccv_t.xccv006, 
   xccv007 LIKE xccv_t.xccv007, 
   xccv007_desc LIKE type_t.chr500, 
   xccv008 LIKE xccv_t.xccv008, 
   xccv009 LIKE xccv_t.xccv009, 
   xccv009_desc LIKE type_t.chr500, 
   xccv009_desc_desc LIKE type_t.chr500, 
   xccv010 LIKE xccv_t.xccv010, 
   xccv011 LIKE xccv_t.xccv011, 
   xccv002 LIKE xccv_t.xccv002, 
   xccv002_desc LIKE type_t.chr500, 
   xccv101 LIKE xccv_t.xccv101, 
   xccv102 LIKE xccv_t.xccv102, 
   xccv102a LIKE xccv_t.xccv102a, 
   xccv102b LIKE xccv_t.xccv102b, 
   xccv102c LIKE xccv_t.xccv102c, 
   xccv102d LIKE xccv_t.xccv102d, 
   xccv102e LIKE xccv_t.xccv102e, 
   xccv102f LIKE xccv_t.xccv102f, 
   xccv102g LIKE xccv_t.xccv102g, 
   xccv102h LIKE xccv_t.xccv102h
       END RECORD
DEFINE g_xccv2_d          DYNAMIC ARRAY OF type_g_xccv2_d
DEFINE g_xccv2_d_t        type_g_xccv2_d
DEFINE g_xccv2_d_o        type_g_xccv2_d

 TYPE type_g_xccv3_d        RECORD
       xccv001 LIKE xccv_t.xccv001, 
   xccv006 LIKE xccv_t.xccv006, 
   xccv007 LIKE xccv_t.xccv007, 
   xccv007_desc LIKE type_t.chr500, 
   xccv008 LIKE xccv_t.xccv008, 
   xccv009 LIKE xccv_t.xccv009, 
   xccv009_desc LIKE type_t.chr500, 
   xccv009_desc_desc LIKE type_t.chr500, 
   xccv010 LIKE xccv_t.xccv010, 
   xccv011 LIKE xccv_t.xccv011, 
   xccv002 LIKE xccv_t.xccv002, 
   xccv002_desc LIKE type_t.chr500, 
   xccv101 LIKE xccv_t.xccv101, 
   xccv102 LIKE xccv_t.xccv102, 
   xccv102a LIKE xccv_t.xccv102a, 
   xccv102b LIKE xccv_t.xccv102b, 
   xccv102c LIKE xccv_t.xccv102c, 
   xccv102d LIKE xccv_t.xccv102d, 
   xccv102e LIKE xccv_t.xccv102e, 
   xccv102f LIKE xccv_t.xccv102f, 
   xccv102g LIKE xccv_t.xccv102g, 
   xccv102h LIKE xccv_t.xccv102h
       END RECORD
DEFINE g_xccv3_d          DYNAMIC ARRAY OF type_g_xccv3_d
DEFINE g_xccv3_d_t        type_g_xccv3_d
DEFINE g_xccv3_d_o        type_g_xccv3_d

DEFINE g_para_data        LIKE type_t.chr80     #采用成本域否
DEFINE g_glaa015          LIKE glaa_t.glaa015
DEFINE g_glaa019          LIKE glaa_t.glaa019
DEFINE g_glaa001          LIKE glaa_t.glaa001
DEFINE g_glaa003          LIKE glaa_t.glaa003
DEFINE g_glaa016          LIKE glaa_t.glaa016
DEFINE g_glaa018          LIKE glaa_t.glaa018
DEFINE g_glaa020          LIKE glaa_t.glaa020
DEFINE g_glaa022          LIKE glaa_t.glaa022
DEFINE g_glaa025          LIKE glaa_t.glaa025

 TYPE type_g_xccv5_d        RECORD
   xccvent LIKE xccv_t.xccvent,
   xccvld  LIKE xccv_t.xccvld,
   xccvcomp LIKE xccv_t.xccvcomp, 
   xccv001 LIKE xccv_t.xccv001, 
   xccv002 LIKE xccv_t.xccv002, 
   xccv003 LIKE xccv_t.xccv003,
   xccv004 LIKE xccv_t.xccv004,
   xccv005 LIKE xccv_t.xccv005,   
   xccv006 LIKE xccv_t.xccv006, 
   xccv007 LIKE xccv_t.xccv007,   
   xccv008 LIKE xccv_t.xccv008, 
   xccv009 LIKE xccv_t.xccv009,   
   xccv010 LIKE xccv_t.xccv010, 
   xccv011 LIKE xccv_t.xccv011,   
   xccv101 LIKE xccv_t.xccv101, 
   xccv102 LIKE xccv_t.xccv102, 
   xccv102a LIKE xccv_t.xccv102a, 
   xccv102b LIKE xccv_t.xccv102b, 
   xccv102c LIKE xccv_t.xccv102c, 
   xccv102d LIKE xccv_t.xccv102d, 
   xccv102e LIKE xccv_t.xccv102e, 
   xccv102f LIKE xccv_t.xccv102f, 
   xccv102g LIKE xccv_t.xccv102g, 
   xccv102h LIKE xccv_t.xccv102h,
   xccv102_1 LIKE xccv_t.xccv102, 
   xccv102a_1 LIKE xccv_t.xccv102a, 
   xccv102b_1 LIKE xccv_t.xccv102b, 
   xccv102c_1 LIKE xccv_t.xccv102c, 
   xccv102d_1 LIKE xccv_t.xccv102d, 
   xccv102e_1 LIKE xccv_t.xccv102e, 
   xccv102f_1 LIKE xccv_t.xccv102f, 
   xccv102g_1 LIKE xccv_t.xccv102g, 
   xccv102h_1 LIKE xccv_t.xccv102h,
   xccv102_2 LIKE xccv_t.xccv102, 
   xccv102a_2 LIKE xccv_t.xccv102a, 
   xccv102b_2 LIKE xccv_t.xccv102b, 
   xccv102c_2 LIKE xccv_t.xccv102c, 
   xccv102d_2 LIKE xccv_t.xccv102d, 
   xccv102e_2 LIKE xccv_t.xccv102e, 
   xccv102f_2 LIKE xccv_t.xccv102f, 
   xccv102g_2 LIKE xccv_t.xccv102g, 
   xccv102h_2 LIKE xccv_t.xccv102h
       END RECORD
       
 TYPE type_g_xccv_f        RECORD
        xccvcomp LIKE xccv_t.xccvcomp, 
        xccvcomp_desc LIKE type_t.chr80, 
        xccvld LIKE xccv_t.xccvld, 
        xccvld_desc LIKE type_t.chr80, 
        format LIKE type_t.chr80, 
        char LIKE type_t.chr80, 
        dir LIKE type_t.chr80
       END RECORD
DEFINE g_xccv_f        type_g_xccv_f
DEFINE g_xccv_f_t      type_g_xccv_f
DEFINE g_xccv5_d          DYNAMIC ARRAY OF type_g_xccv5_d
DEFINE w        ui.Window
DEFINE f        ui.Form
DEFINE page     om.DomNode
TYPE   type_g_xccv_s        RECORD
       name LIKE type_t.chr80, 
       dir LIKE type_t.chr80
                            END RECORD
DEFINE g_xccv_s        type_g_xccv_s
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
DEFINE g_sfbaseq        LIKE sfba_t.sfbaseq
DEFINE g_sfbaseq1       LIKE sfba_t.sfbaseq1
#160802-00020#5-s-add
DEFINE g_wc_cs_ld            STRING
DEFINE g_wc_cs_comp          STRING
#160802-00020#5-e-add
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_xccv_m          type_g_xccv_m
DEFINE g_xccv_m_t        type_g_xccv_m
DEFINE g_xccv_m_o        type_g_xccv_m
DEFINE g_xccv_m_mask_o   type_g_xccv_m #轉換遮罩前資料
DEFINE g_xccv_m_mask_n   type_g_xccv_m #轉換遮罩後資料
 
   DEFINE g_xccv004_t LIKE xccv_t.xccv004
DEFINE g_xccv005_t LIKE xccv_t.xccv005
DEFINE g_xccvld_t LIKE xccv_t.xccvld
DEFINE g_xccv003_t LIKE xccv_t.xccv003
 
 
DEFINE g_xccv_d          DYNAMIC ARRAY OF type_g_xccv_d
DEFINE g_xccv_d_t        type_g_xccv_d
DEFINE g_xccv_d_o        type_g_xccv_d
DEFINE g_xccv_d_mask_o   DYNAMIC ARRAY OF type_g_xccv_d #轉換遮罩前資料
DEFINE g_xccv_d_mask_n   DYNAMIC ARRAY OF type_g_xccv_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_xccvld LIKE xccv_t.xccvld,
      b_xccv003 LIKE xccv_t.xccv003,
      b_xccv004 LIKE xccv_t.xccv004,
      b_xccv005 LIKE xccv_t.xccv005
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
 
{<section id="axct303.main" >}
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
   #160802-00020#5-s-add
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  
   #160802-00020#5-e-add 
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT xccvcomp,'',xccv004,xccv005,xccvld,'',xccv003,''", 
                      " FROM xccv_t",
                      " WHERE xccvent= ? AND xccvld=? AND xccv003=? AND xccv004=? AND xccv005=? FOR  
                          UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axct303_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xccvcomp,t0.xccv004,t0.xccv005,t0.xccvld,t0.xccv003,t1.ooefl003 , 
       t2.glaal002 ,t3.xcatl003",
               " FROM xccv_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.xccvcomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t2 ON t2.glaalent="||g_enterprise||" AND t2.glaalld=t0.xccvld AND t2.glaal001='"||g_dlang||"' ",
               " LEFT JOIN xcatl_t t3 ON t3.xcatlent="||g_enterprise||" AND t3.xcatl001=t0.xccv003 AND t3.xcatl002='"||g_dlang||"' ",
 
               " WHERE t0.xccvent = " ||g_enterprise|| " AND t0.xccvld = ? AND t0.xccv003 = ? AND t0.xccv004 = ? AND t0.xccv005 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axct303_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axct303 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axct303_init()   
 
      #進入選單 Menu (="N")
      CALL axct303_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axct303
      
   END IF 
   
   CLOSE axct303_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axct303.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axct303_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('xccv001','8914') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否            
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xccv002,xccv002_desc,xccv002_2,xccv002_2_desc,xccv002_3,xccv002_3_desc',TRUE)                    
   ELSE
      CALL cl_set_comp_visible('xccv002,xccv002_desc,xccv002_2,xccv002_2_desc,xccv002_3,xccv002_3_desc',FALSE)                
   END IF
   #end add-point
   
   CALL axct303_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axct303.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axct303_ui_dialog()
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
   DEFINE l_success       LIKE type_t.num5
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
         INITIALIZE g_xccv_m.* TO NULL
         CALL g_xccv_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axct303_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_xccv_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL axct303_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axct303_ui_detailshow()
               
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
         DISPLAY ARRAY g_xccv2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b) #page2 
         
            BEFORE ROW
               #顯示單身筆數
               CALL axct303_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               CALL axct303_ui_detailshow()
               
               #add-point:page1自定義行為

               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
    
               #控制stus哪個按鈕可以按
               
               
            
 
            #add-point:page1自定義行為

            #end add-point
               
         END DISPLAY
         DISPLAY ARRAY g_xccv3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b) #page2 
         
            BEFORE ROW
               #顯示單身筆數
               CALL axct303_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx
               CALL axct303_ui_detailshow()
               
               #add-point:page1自定義行為

               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
    
               #控制stus哪個按鈕可以按
               
               
            
 
            #add-point:page1自定義行為

            #end add-point
               
         END DISPLAY
         #end add-point
         
         
         BEFORE DIALOG
            #先填充browser資料
            CALL axct303_browser_fill("")
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
               CALL axct303_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axct303_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axct303_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct303_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axct303_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct303_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axct303_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct303_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axct303_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct303_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axct303_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct303_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_xccv_d)
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
               NEXT FIELD xccv001
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
               CALL axct303_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL axct303_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL axct303_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL axct303_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL axct303_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axct303_s01
            LET g_action_choice="open_axct303_s01"
            IF cl_auth_chk_act("open_axct303_s01") THEN
               
               #add-point:ON ACTION open_axct303_s01 name="menu.open_axct303_s01"
               CALL axct303_s01()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL axct303_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axct303_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axct303_s02
            LET g_action_choice="open_axct303_s02"
            IF cl_auth_chk_act("open_axct303_s02") THEN
               
               #add-point:ON ACTION open_axct303_s02 name="menu.open_axct303_s02"
               CALL axct303_s02() RETURNING l_success
               IF l_success = TRUE THEN
                  CALL s_transaction_end('Y','1')
                  ERROR "INSERT O.K"
               ELSE
                  CALL s_transaction_end('N','1')
               END IF
               CALL axct303_show()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/axc/axct303_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/axc/axct303_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL axct303_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION axct328
            LET g_action_choice="axct328"
            IF cl_auth_chk_act("axct328") THEN
               
               #add-point:ON ACTION axct328 name="menu.axct328"
               CALL axct303_generate_xcdv()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axct303_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axct303_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axct303_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axct303_set_pk_array()
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
 
{<section id="axct303.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION axct303_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axct303.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axct303_browser_fill(ps_page_action)
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
   
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.before_browser_fill"
   
   #end add-point    
 
   LET l_searchcol = "xccvld,xccv003,xccv004,xccv005"
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
      LET l_sub_sql = " SELECT DISTINCT xccvld ",
                      ", xccv003 ",
                      ", xccv004 ",
                      ", xccv005 ",
 
                      " FROM xccv_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE xccvent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xccv_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xccvld ",
                      ", xccv003 ",
                      ", xccv004 ",
                      ", xccv005 ",
 
                      " FROM xccv_t ",
                      " ",
                      " ", 
 
 
                      " WHERE xccvent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xccv_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
 
   #add-point:browser_fill,count前 name="browser_fill.before_count"
  #160802-00020#5-s-add  
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET l_sub_sql = l_sub_sql , " AND xccvld IN ",g_wc_cs_ld
   END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET l_sub_sql = l_sub_sql," AND xccvcomp IN ",g_wc_cs_comp
   END IF  
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
  #160802-00020#5-e-add
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
      INITIALIZE g_xccv_m.* TO NULL
      CALL g_xccv_d.clear()        
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xccvld,t0.xccv003,t0.xccv004,t0.xccv005 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.xccvld,t0.xccv003,t0.xccv004,t0.xccv005",
                " FROM xccv_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.xccvent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xccv_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   #160802-00020#5-s-add
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql , " AND t0.xccvld IN ",g_wc_cs_ld
   END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql," AND t0.xccvcomp IN ",g_wc_cs_comp
   END IF  
   #160802-00020#5-e-add
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"xccv_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_xccvld,g_browser[g_cnt].b_xccv003,g_browser[g_cnt].b_xccv004, 
          g_browser[g_cnt].b_xccv005 
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
   
   IF cl_null(g_browser[g_cnt].b_xccvld) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_xccv_m.* TO NULL
      CALL g_xccv_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL axct303_fetch('')
   
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
 
{<section id="axct303.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axct303_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xccv_m.xccvld = g_browser[g_current_idx].b_xccvld   
   LET g_xccv_m.xccv003 = g_browser[g_current_idx].b_xccv003   
   LET g_xccv_m.xccv004 = g_browser[g_current_idx].b_xccv004   
   LET g_xccv_m.xccv005 = g_browser[g_current_idx].b_xccv005   
 
   EXECUTE axct303_master_referesh USING g_xccv_m.xccvld,g_xccv_m.xccv003,g_xccv_m.xccv004,g_xccv_m.xccv005 INTO g_xccv_m.xccvcomp, 
       g_xccv_m.xccv004,g_xccv_m.xccv005,g_xccv_m.xccvld,g_xccv_m.xccv003,g_xccv_m.xccvcomp_desc,g_xccv_m.xccvld_desc, 
       g_xccv_m.xccv003_desc
   CALL axct303_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axct303.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axct303_ui_detailshow()
   #add-point:ui_detailshow段define name="ui_detailshow.define_customerization"
   
   #end add-point
   #add-point:ui_detailshow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_detailshow.before"
 
   #end add-point  
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
 
      #add-point:ui_detailshow段more name="ui_detailshow.more"
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)   
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)   
      #end add-point 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   CALL axct303_show()
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axct303.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axct303_ui_browser_refresh()
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
      IF g_browser[l_i].b_xccvld = g_xccv_m.xccvld 
         AND g_browser[l_i].b_xccv003 = g_xccv_m.xccv003 
         AND g_browser[l_i].b_xccv004 = g_xccv_m.xccv004 
         AND g_browser[l_i].b_xccv005 = g_xccv_m.xccv005 
 
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
 
{<section id="axct303.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axct303_construct()
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
   INITIALIZE g_xccv_m.* TO NULL
   CALL g_xccv_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xccvcomp,xccv004,xccv005,xccvld,xccv003
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.xccvcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccvcomp
            #add-point:ON ACTION controlp INFIELD xccvcomp name="construct.c.xccvcomp"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160802-00020#5-s-add 
            #增加法人過濾條件
            IF NOT cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF
            #160802-00020#5-e-add             
            #--161013-00051#1 By shiun--(S)
#            CALL q_ooef001_8()                           #呼叫開窗
            CALL q_ooef001_2()
            #--161013-00051#1 By shiun--(E)
            DISPLAY g_qryparam.return1 TO xccvcomp  #顯示到畫面上
            NEXT FIELD xccvcomp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccvcomp
            #add-point:BEFORE FIELD xccvcomp name="construct.b.xccvcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccvcomp
            
            #add-point:AFTER FIELD xccvcomp name="construct.a.xccvcomp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv004
            #add-point:BEFORE FIELD xccv004 name="construct.b.xccv004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv004
            
            #add-point:AFTER FIELD xccv004 name="construct.a.xccv004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccv004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv004
            #add-point:ON ACTION controlp INFIELD xccv004 name="construct.c.xccv004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv005
            #add-point:BEFORE FIELD xccv005 name="construct.b.xccv005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv005
            
            #add-point:AFTER FIELD xccv005 name="construct.a.xccv005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccv005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv005
            #add-point:ON ACTION controlp INFIELD xccv005 name="construct.c.xccv005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xccvld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccvld
            #add-point:ON ACTION controlp INFIELD xccvld name="construct.c.xccvld"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #160802-00020#5-s-add
            #增加帳套權限控制
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #160802-00020#5-e-add             
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccvld  #顯示到畫面上
            NEXT FIELD xccvld                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccvld
            #add-point:BEFORE FIELD xccvld name="construct.b.xccvld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccvld
            
            #add-point:AFTER FIELD xccvld name="construct.a.xccvld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccv003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv003
            #add-point:ON ACTION controlp INFIELD xccv003 name="construct.c.xccv003"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " xcat005 IN ('2','3') "
            CALL q_xcat001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccv003  #顯示到畫面上
            NEXT FIELD xccv003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv003
            #add-point:BEFORE FIELD xccv003 name="construct.b.xccv003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv003
            
            #add-point:AFTER FIELD xccv003 name="construct.a.xccv003"
            
            #END add-point
            
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON xccv001,xccv006,xccv007,xccv008,xccv009,xccv010,xccv011,xccv002,xccv101, 
          xccv102,xccv102a,xccv102b,xccv102c,xccv102d,xccv102e,xccv102f,xccv102g,xccv102h
           FROM s_detail1[1].xccv001,s_detail1[1].xccv006,s_detail1[1].xccv007,s_detail1[1].xccv008, 
               s_detail1[1].xccv009,s_detail1[1].xccv010,s_detail1[1].xccv011,s_detail1[1].xccv002,s_detail1[1].xccv101, 
               s_detail1[1].xccv102,s_detail1[1].xccv102a,s_detail1[1].xccv102b,s_detail1[1].xccv102c, 
               s_detail1[1].xccv102d,s_detail1[1].xccv102e,s_detail1[1].xccv102f,s_detail1[1].xccv102g, 
               s_detail1[1].xccv102h
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv001
            #add-point:BEFORE FIELD xccv001 name="construct.b.page1.xccv001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv001
            
            #add-point:AFTER FIELD xccv001 name="construct.a.page1.xccv001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccv001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv001
            #add-point:ON ACTION controlp INFIELD xccv001 name="construct.c.page1.xccv001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xccv006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv006
            #add-point:ON ACTION controlp INFIELD xccv006 name="construct.c.page1.xccv006"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            CALL q_sfbadocno()                           #呼叫開窗   #161121-00018#11 mark
            CALL q_sfaadocno_4()         #161121-00018#11 add
            DISPLAY g_qryparam.return1 TO xccv006  #顯示到畫面上
            NEXT FIELD xccv006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv006
            #add-point:BEFORE FIELD xccv006 name="construct.b.page1.xccv006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv006
            
            #add-point:AFTER FIELD xccv006 name="construct.a.page1.xccv006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccv007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv007
            #add-point:ON ACTION controlp INFIELD xccv007 name="construct.c.page1.xccv007"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfba003_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccv007  #顯示到畫面上
            NEXT FIELD xccv007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv007
            #add-point:BEFORE FIELD xccv007 name="construct.b.page1.xccv007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv007
            
            #add-point:AFTER FIELD xccv007 name="construct.a.page1.xccv007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccv008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv008
            #add-point:ON ACTION controlp INFIELD xccv008 name="construct.c.page1.xccv008"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfba003_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccv008  #顯示到畫面上
            NEXT FIELD xccv008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv008
            #add-point:BEFORE FIELD xccv008 name="construct.b.page1.xccv008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv008
            
            #add-point:AFTER FIELD xccv008 name="construct.a.page1.xccv008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccv009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv009
            #add-point:ON ACTION controlp INFIELD xccv009 name="construct.c.page1.xccv009"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE  
#            CALL q_imag001()                           #呼叫開窗   #161121-00018#11 mark
            CALL q_imag001_2()  #161121-00018#11 add
            DISPLAY g_qryparam.return1 TO xccv009  #顯示到畫面上
            NEXT FIELD xccv009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv009
            #add-point:BEFORE FIELD xccv009 name="construct.b.page1.xccv009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv009
            
            #add-point:AFTER FIELD xccv009 name="construct.a.page1.xccv009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccv010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv010
            #add-point:ON ACTION controlp INFIELD xccv010 name="construct.c.page1.xccv010"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_bmaa002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccv010  #顯示到畫面上
            NEXT FIELD xccv010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv010
            #add-point:BEFORE FIELD xccv010 name="construct.b.page1.xccv010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv010
            
            #add-point:AFTER FIELD xccv010 name="construct.a.page1.xccv010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccv011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv011
            #add-point:ON ACTION controlp INFIELD xccv011 name="construct.c.page1.xccv011"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaj010()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccv011  #顯示到畫面上
            NEXT FIELD xccv011                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv011
            #add-point:BEFORE FIELD xccv011 name="construct.b.page1.xccv011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv011
            
            #add-point:AFTER FIELD xccv011 name="construct.a.page1.xccv011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccv002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv002
            #add-point:ON ACTION controlp INFIELD xccv002 name="construct.c.page1.xccv002"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcbf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccv002  #顯示到畫面上
            NEXT FIELD xccv002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv002
            #add-point:BEFORE FIELD xccv002 name="construct.b.page1.xccv002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv002
            
            #add-point:AFTER FIELD xccv002 name="construct.a.page1.xccv002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv101
            #add-point:BEFORE FIELD xccv101 name="construct.b.page1.xccv101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv101
            
            #add-point:AFTER FIELD xccv101 name="construct.a.page1.xccv101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccv101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv101
            #add-point:ON ACTION controlp INFIELD xccv101 name="construct.c.page1.xccv101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv102
            #add-point:BEFORE FIELD xccv102 name="construct.b.page1.xccv102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv102
            
            #add-point:AFTER FIELD xccv102 name="construct.a.page1.xccv102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccv102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv102
            #add-point:ON ACTION controlp INFIELD xccv102 name="construct.c.page1.xccv102"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv102a
            #add-point:BEFORE FIELD xccv102a name="construct.b.page1.xccv102a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv102a
            
            #add-point:AFTER FIELD xccv102a name="construct.a.page1.xccv102a"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccv102a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv102a
            #add-point:ON ACTION controlp INFIELD xccv102a name="construct.c.page1.xccv102a"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv102b
            #add-point:BEFORE FIELD xccv102b name="construct.b.page1.xccv102b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv102b
            
            #add-point:AFTER FIELD xccv102b name="construct.a.page1.xccv102b"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccv102b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv102b
            #add-point:ON ACTION controlp INFIELD xccv102b name="construct.c.page1.xccv102b"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv102c
            #add-point:BEFORE FIELD xccv102c name="construct.b.page1.xccv102c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv102c
            
            #add-point:AFTER FIELD xccv102c name="construct.a.page1.xccv102c"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccv102c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv102c
            #add-point:ON ACTION controlp INFIELD xccv102c name="construct.c.page1.xccv102c"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv102d
            #add-point:BEFORE FIELD xccv102d name="construct.b.page1.xccv102d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv102d
            
            #add-point:AFTER FIELD xccv102d name="construct.a.page1.xccv102d"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccv102d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv102d
            #add-point:ON ACTION controlp INFIELD xccv102d name="construct.c.page1.xccv102d"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv102e
            #add-point:BEFORE FIELD xccv102e name="construct.b.page1.xccv102e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv102e
            
            #add-point:AFTER FIELD xccv102e name="construct.a.page1.xccv102e"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccv102e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv102e
            #add-point:ON ACTION controlp INFIELD xccv102e name="construct.c.page1.xccv102e"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv102f
            #add-point:BEFORE FIELD xccv102f name="construct.b.page1.xccv102f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv102f
            
            #add-point:AFTER FIELD xccv102f name="construct.a.page1.xccv102f"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccv102f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv102f
            #add-point:ON ACTION controlp INFIELD xccv102f name="construct.c.page1.xccv102f"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv102g
            #add-point:BEFORE FIELD xccv102g name="construct.b.page1.xccv102g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv102g
            
            #add-point:AFTER FIELD xccv102g name="construct.a.page1.xccv102g"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccv102g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv102g
            #add-point:ON ACTION controlp INFIELD xccv102g name="construct.c.page1.xccv102g"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv102h
            #add-point:BEFORE FIELD xccv102h name="construct.b.page1.xccv102h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv102h
            
            #add-point:AFTER FIELD xccv102h name="construct.a.page1.xccv102h"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccv102h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv102h
            #add-point:ON ACTION controlp INFIELD xccv102h name="construct.c.page1.xccv102h"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog name="cs.before_dialog"
         
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
 
{<section id="axct303.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axct303_query()
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
   CALL g_xccv_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL axct303_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axct303_browser_fill(g_wc)
      CALL axct303_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL axct303_browser_fill("F")
   
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
      CALL axct303_fetch("F") 
   END IF
   
   CALL axct303_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="axct303.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axct303_fetch(p_flag)
   #add-point:fetch段define name="fetch.define_customerization"
   
   #end add-point   
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fetch.before_fetch"
   CALL cl_set_act_visible("modify,modify_detail,delete", TRUE)
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
   
   #CALL axct303_browser_fill(p_flag)
   
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
   
   LET g_xccv_m.xccvld = g_browser[g_current_idx].b_xccvld
   LET g_xccv_m.xccv003 = g_browser[g_current_idx].b_xccv003
   LET g_xccv_m.xccv004 = g_browser[g_current_idx].b_xccv004
   LET g_xccv_m.xccv005 = g_browser[g_current_idx].b_xccv005
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axct303_master_referesh USING g_xccv_m.xccvld,g_xccv_m.xccv003,g_xccv_m.xccv004,g_xccv_m.xccv005 INTO g_xccv_m.xccvcomp, 
       g_xccv_m.xccv004,g_xccv_m.xccv005,g_xccv_m.xccvld,g_xccv_m.xccv003,g_xccv_m.xccvcomp_desc,g_xccv_m.xccvld_desc, 
       g_xccv_m.xccv003_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccv_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_xccv_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_xccv_m_mask_o.* =  g_xccv_m.*
   CALL axct303_xccv_t_mask()
   LET g_xccv_m_mask_n.* =  g_xccv_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axct303_set_act_visible()
   CALL axct303_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_xccv_m_t.* = g_xccv_m.*
   LET g_xccv_m_o.* = g_xccv_m.*
   
   #重新顯示   
   CALL axct303_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axct303.insert" >}
#+ 資料新增
PRIVATE FUNCTION axct303_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_xccv_d.clear()
 
 
   INITIALIZE g_xccv_m.* TO NULL             #DEFAULT 設定
   LET g_xccvld_t = NULL
   LET g_xccv003_t = NULL
   LET g_xccv004_t = NULL
   LET g_xccv005_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      #150115  fengmy--begin
      #预设当前site的法人，主账套，年度期别，成本计算类型
      CALL s_axc_set_site_default() RETURNING g_xccv_m.xccvcomp,g_xccv_m.xccvld,g_xccv_m.xccv004,g_xccv_m.xccv005,g_xccv_m.xccv003
      DISPLAY BY NAME g_xccv_m.xccvcomp,g_xccv_m.xccvld,g_xccv_m.xccv004,g_xccv_m.xccv005,g_xccv_m.xccv003
      CALL axct303_ref()
      #150115  fengmy--end
      #end add-point 
 
      CALL axct303_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_xccv_m.* TO NULL
         INITIALIZE g_xccv_d TO NULL
 
         CALL axct303_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xccv_m.* = g_xccv_m_t.*
         CALL axct303_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_xccv_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axct303_set_act_visible()
   CALL axct303_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xccvld_t = g_xccv_m.xccvld
   LET g_xccv003_t = g_xccv_m.xccv003
   LET g_xccv004_t = g_xccv_m.xccv004
   LET g_xccv005_t = g_xccv_m.xccv005
 
   
   #組合新增資料的條件
   LET g_add_browse = " xccvent = " ||g_enterprise|| " AND",
                      " xccvld = '", g_xccv_m.xccvld, "' "
                      ," AND xccv003 = '", g_xccv_m.xccv003, "' "
                      ," AND xccv004 = '", g_xccv_m.xccv004, "' "
                      ," AND xccv005 = '", g_xccv_m.xccv005, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axct303_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL axct303_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axct303_master_referesh USING g_xccv_m.xccvld,g_xccv_m.xccv003,g_xccv_m.xccv004,g_xccv_m.xccv005 INTO g_xccv_m.xccvcomp, 
       g_xccv_m.xccv004,g_xccv_m.xccv005,g_xccv_m.xccvld,g_xccv_m.xccv003,g_xccv_m.xccvcomp_desc,g_xccv_m.xccvld_desc, 
       g_xccv_m.xccv003_desc
   
   #遮罩相關處理
   LET g_xccv_m_mask_o.* =  g_xccv_m.*
   CALL axct303_xccv_t_mask()
   LET g_xccv_m_mask_n.* =  g_xccv_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xccv_m.xccvcomp,g_xccv_m.xccvcomp_desc,g_xccv_m.xccv004,g_xccv_m.xccv005,g_xccv_m.xccvld, 
       g_xccv_m.xccvld_desc,g_xccv_m.xccv003,g_xccv_m.xccv003_desc
   
   #功能已完成,通報訊息中心
   CALL axct303_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axct303.modify" >}
#+ 資料修改
PRIVATE FUNCTION axct303_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_xccv_m.xccvld IS NULL
   OR g_xccv_m.xccv003 IS NULL
   OR g_xccv_m.xccv004 IS NULL
   OR g_xccv_m.xccv005 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_xccvld_t = g_xccv_m.xccvld
   LET g_xccv003_t = g_xccv_m.xccv003
   LET g_xccv004_t = g_xccv_m.xccv004
   LET g_xccv005_t = g_xccv_m.xccv005
 
   CALL s_transaction_begin()
   
   OPEN axct303_cl USING g_enterprise,g_xccv_m.xccvld,g_xccv_m.xccv003,g_xccv_m.xccv004,g_xccv_m.xccv005
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axct303_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axct303_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axct303_master_referesh USING g_xccv_m.xccvld,g_xccv_m.xccv003,g_xccv_m.xccv004,g_xccv_m.xccv005 INTO g_xccv_m.xccvcomp, 
       g_xccv_m.xccv004,g_xccv_m.xccv005,g_xccv_m.xccvld,g_xccv_m.xccv003,g_xccv_m.xccvcomp_desc,g_xccv_m.xccvld_desc, 
       g_xccv_m.xccv003_desc
   
   #遮罩相關處理
   LET g_xccv_m_mask_o.* =  g_xccv_m.*
   CALL axct303_xccv_t_mask()
   LET g_xccv_m_mask_n.* =  g_xccv_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL axct303_show()
   WHILE TRUE
      LET g_xccvld_t = g_xccv_m.xccvld
      LET g_xccv003_t = g_xccv_m.xccv003
      LET g_xccv004_t = g_xccv_m.xccv004
      LET g_xccv005_t = g_xccv_m.xccv005
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL axct303_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xccv_m.* = g_xccv_m_t.*
         CALL axct303_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_xccv_m.xccvld != g_xccvld_t 
      OR g_xccv_m.xccv003 != g_xccv003_t 
      OR g_xccv_m.xccv004 != g_xccv004_t 
      OR g_xccv_m.xccv005 != g_xccv005_t 
 
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
   CALL axct303_set_act_visible()
   CALL axct303_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xccvent = " ||g_enterprise|| " AND",
                      " xccvld = '", g_xccv_m.xccvld, "' "
                      ," AND xccv003 = '", g_xccv_m.xccv003, "' "
                      ," AND xccv004 = '", g_xccv_m.xccv004, "' "
                      ," AND xccv005 = '", g_xccv_m.xccv005, "' "
 
   #填到對應位置
   CALL axct303_browser_fill("")
 
   CALL axct303_idx_chk()
 
   CLOSE axct303_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axct303_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="axct303.input" >}
#+ 資料輸入
PRIVATE FUNCTION axct303_input(p_cmd)
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
   DISPLAY BY NAME g_xccv_m.xccvcomp,g_xccv_m.xccvcomp_desc,g_xccv_m.xccv004,g_xccv_m.xccv005,g_xccv_m.xccvld, 
       g_xccv_m.xccvld_desc,g_xccv_m.xccv003,g_xccv_m.xccv003_desc
   
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
   LET g_forupd_sql = "SELECT xccv001,xccv006,xccv007,xccv008,xccv009,xccv010,xccv011,xccv002,xccv101, 
       xccv102,xccv102a,xccv102b,xccv102c,xccv102d,xccv102e,xccv102f,xccv102g,xccv102h FROM xccv_t WHERE  
       xccvent=? AND xccvld=? AND xccv003=? AND xccv004=? AND xccv005=? AND xccv001=? AND xccv002=?  
       AND xccv006=? AND xccv007=? AND xccv008=? AND xccv009=? AND xccv010=? AND xccv011=? FOR UPDATE" 
 
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axct303_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axct303_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axct303_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_xccv_m.xccvcomp,g_xccv_m.xccv004,g_xccv_m.xccv005,g_xccv_m.xccvld,g_xccv_m.xccv003 
 
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   LET g_errshow = 1 #161121-00018#11 add
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axct303.input.head" >}
   
      #單頭段
      INPUT BY NAME g_xccv_m.xccvcomp,g_xccv_m.xccv004,g_xccv_m.xccv005,g_xccv_m.xccvld,g_xccv_m.xccv003  
 
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
         AFTER FIELD xccvcomp
            
            #add-point:AFTER FIELD xccvcomp name="input.a.xccvcomp"
            IF NOT cl_null(g_xccv_m.xccvcomp) THEN 
#應用 a19 樣板自動產生(Version:1)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xccv_m.xccvcomp

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_15") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
               IF NOT cl_null(g_xccv_m.xccvld) THEN 
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM glaa_t 
                   WHERE glaaent = g_enterprise AND glaald = g_xccv_m.xccvld
                     AND glaacomp = g_xccv_m.xccvcomp
                  IF l_n = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axc-00224'
                     LET g_errparam.extend = g_xccv_m_t.xccvcomp
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                   
                     NEXT FIELD xcvvcomp
                  END IF               
               END IF
            END IF 

            IF NOT cl_null(g_xccv_m.xccvcomp) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xccv_m_t.xccvcomp IS NULL OR g_xccv_m.xccvcomp != g_xccv_m_t.xccvcomp)) THEN
                  IF NOT s_axc_chk_ld_comp(g_xccv_m.xccvcomp,g_xccv_m.xccvld) THEN
                     LET g_xccv_m.xccvcomp = g_xccv_m_t.xccvcomp
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL cl_get_para(g_enterprise,g_xccv_m.xccvcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否            
               IF g_para_data = 'Y' THEN
                  CALL cl_set_comp_visible('xccv002,xccv002_desc,xccv002_2,xccv002_2_desc,xccv002_3,xccv002_3_desc',TRUE)                    
               ELSE
                  CALL cl_set_comp_visible('xccv002,xccv002_desc,xccv002_2,xccv002_2_desc,xccv002_3,xccv002_3_desc',FALSE)                
               END IF
            END IF
#            CALL axct303_ref()     #160926-00006#1 marked
            
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccvcomp
            #add-point:BEFORE FIELD xccvcomp name="input.b.xccvcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccvcomp
            #add-point:ON CHANGE xccvcomp name="input.g.xccvcomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv004
            #add-point:BEFORE FIELD xccv004 name="input.b.xccv004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv004
            
            #add-point:AFTER FIELD xccv004 name="input.a.xccv004"
            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF NOT cl_null(g_xccv_m.xccv004) THEN
               IF p_cmd ='a' OR (p_cmd ='u' AND (g_xccv_m_t.xccv004 IS NULL OR g_xccv_m.xccv004 != g_xccv_m_t.xccv004)) THEN
                  IF NOT axct303_chk_year_period() THEN
                     LET g_xccv_m.xccv004 = g_xccv_m_t.xccv004
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF  NOT cl_null(g_xccv_m.xccvld) AND NOT cl_null(g_xccv_m.xccv003) AND NOT cl_null(g_xccv_m.xccv004) AND NOT cl_null(g_xccv_m.xccv005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccv_m.xccvld != g_xccvld_t  OR g_xccv_m.xccv003 != g_xccv003_t  OR g_xccv_m.xccv004 != g_xccv004_t  OR g_xccv_m.xccv005 != g_xccv005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccv_t WHERE "||"xccvent = '" ||g_enterprise|| "' AND "||"xccvld = '"||g_xccv_m.xccvld ||"' AND "|| "xccv003 = '"||g_xccv_m.xccv003 ||"' AND "|| "xccv004 = '"||g_xccv_m.xccv004 ||"' AND "|| "xccv005 = '"||g_xccv_m.xccv005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccv004
            #add-point:ON CHANGE xccv004 name="input.g.xccv004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv005
            #add-point:BEFORE FIELD xccv005 name="input.b.xccv005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv005
            
            #add-point:AFTER FIELD xccv005 name="input.a.xccv005"
            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF NOT cl_null(g_xccv_m.xccv005) THEN
               IF p_cmd ='a' OR (p_cmd ='u' AND (g_xccv_m_t.xccv005 IS NULL OR g_xccv_m.xccv005 != g_xccv_m_t.xccv005)) THEN
                  IF NOT axct303_chk_year_period() THEN
                     LET g_xccv_m.xccv005 = g_xccv_m_t.xccv005
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            IF  NOT cl_null(g_xccv_m.xccvld) AND NOT cl_null(g_xccv_m.xccv003) AND NOT cl_null(g_xccv_m.xccv004) AND NOT cl_null(g_xccv_m.xccv005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccv_m.xccvld != g_xccvld_t  OR g_xccv_m.xccv003 != g_xccv003_t  OR g_xccv_m.xccv004 != g_xccv004_t  OR g_xccv_m.xccv005 != g_xccv005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccv_t WHERE "||"xccvent = '" ||g_enterprise|| "' AND "||"xccvld = '"||g_xccv_m.xccvld ||"' AND "|| "xccv003 = '"||g_xccv_m.xccv003 ||"' AND "|| "xccv004 = '"||g_xccv_m.xccv004 ||"' AND "|| "xccv005 = '"||g_xccv_m.xccv005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccv005
            #add-point:ON CHANGE xccv005 name="input.g.xccv005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccvld
            
            #add-point:AFTER FIELD xccvld name="input.a.xccvld"
            IF NOT cl_null(g_xccv_m.xccvld) THEN 
#應用 a19 樣板自動產生(Version:1)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xccv_m.xccvld
               #160318-00025#12--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               #160318-00025#12--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glaald") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
               IF NOT cl_null(g_xccv_m.xccvcomp) THEN 
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM glaa_t 
                   WHERE glaaent = g_enterprise AND glaald = g_xccv_m.xccvld
                     AND glaacomp = g_xccv_m.xccvcomp
                  IF l_n = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axc-00224'
                     LET g_errparam.extend = g_xccv_m_t.xccvld
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                   
                     NEXT FIELD xccvld
                  END IF               
               END IF            
               IF NOT s_ld_chk_authorization(g_user,g_xccv_m.xccvld) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00165'
                  LET g_errparam.extend = g_xccv_m.xccvld
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD xccvld
               END IF
            END IF 

            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF NOT cl_null(g_xccv_m.xccvld) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xccv_m_t.xccvld IS NULL OR g_xccv_m.xccvld != g_xccv_m_t.xccvld)) THEN
                  IF NOT s_axc_chk_ld_comp(g_xccv_m.xccvcomp,g_xccv_m.xccvld) THEN
                     LET g_xccv_m.xccvld = g_xccv_m_t.xccvld
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #160929-00005#4---add---s            
            IF NOT s_ld_chk_authorization(g_user,g_xccv_m.xccvld) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'agl-00165'
               LET g_errparam.extend = g_xccv_m.xccvld
               LET g_errparam.popup = FALSE
               CALL cl_err()
               LET g_xccv_m.xccvld = g_xccv_m_t.xccvld
               NEXT FIELD xccald
            END IF           
            #160929-00005#4---add---e           
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccv_m.xccvld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccv_m.xccvld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccv_m.xccvld_desc
            
            IF  NOT cl_null(g_xccv_m.xccvld) AND NOT cl_null(g_xccv_m.xccv003) AND NOT cl_null(g_xccv_m.xccv004) AND NOT cl_null(g_xccv_m.xccv005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccv_m.xccvld != g_xccvld_t  OR g_xccv_m.xccv003 != g_xccv003_t  OR g_xccv_m.xccv004 != g_xccv004_t  OR g_xccv_m.xccv005 != g_xccv005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccv_t WHERE "||"xccvent = '" ||g_enterprise|| "' AND "||"xccvld = '"||g_xccv_m.xccvld ||"' AND "|| "xccv003 = '"||g_xccv_m.xccv003 ||"' AND "|| "xccv004 = '"||g_xccv_m.xccv004 ||"' AND "|| "xccv005 = '"||g_xccv_m.xccv005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

#            CALL axct303_ref()     #160926-00006#1 marked
            IF g_glaa015 = 'Y' THEN
               CALL cl_set_comp_visible("page_3",TRUE)
            ELSE
               CALL cl_set_comp_visible("page_3",FALSE) 
            END IF
            IF g_glaa019 = 'Y' THEN
               CALL cl_set_comp_visible("page_4",TRUE)
            ELSE
               CALL cl_set_comp_visible("page_4",FALSE)
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccvld
            #add-point:BEFORE FIELD xccvld name="input.b.xccvld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccvld
            #add-point:ON CHANGE xccvld name="input.g.xccvld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv003
            
            #add-point:AFTER FIELD xccv003 name="input.a.xccv003"
            IF NOT cl_null(g_xccv_m.xccv003) THEN 
#應用 a19 樣板自動產生(Version:1)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xccv_m.xccv003
               #160318-00025#12--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00195:sub-01302|axci100|",cl_get_progname("axci100",g_lang,"2"),"|:EXEPROGaxci100"
               #160318-00025#12--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_xcat001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF  NOT cl_null(g_xccv_m.xccvld) AND NOT cl_null(g_xccv_m.xccv003) AND NOT cl_null(g_xccv_m.xccv004) AND NOT cl_null(g_xccv_m.xccv005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccv_m.xccvld != g_xccvld_t  OR g_xccv_m.xccv003 != g_xccv003_t  OR g_xccv_m.xccv004 != g_xccv004_t  OR g_xccv_m.xccv005 != g_xccv005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccv_t WHERE "||"xccvent = '" ||g_enterprise|| "' AND "||"xccvld = '"||g_xccv_m.xccvld ||"' AND "|| "xccv003 = '"||g_xccv_m.xccv003 ||"' AND "|| "xccv004 = '"||g_xccv_m.xccv004 ||"' AND "|| "xccv005 = '"||g_xccv_m.xccv005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

#            CALL axct303_ref()     #160926-00006#1 marked
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv003
            #add-point:BEFORE FIELD xccv003 name="input.b.xccv003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccv003
            #add-point:ON CHANGE xccv003 name="input.g.xccv003"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xccvcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccvcomp
            #add-point:ON ACTION controlp INFIELD xccvcomp name="input.c.xccvcomp"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccv_m.xccvcomp             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            #帳套不為空時，法人組織開窗開帳套歸屬法人的法人組織
            IF NOT cl_null(g_xccv_m.xccvld) THEN
               LET g_qryparam.where = " ooef017 = (SELECT glaacomp FROM glaa_t",
                                      "  WHERE glaaent = '",g_enterprise,"' AND glaald = '",g_xccv_m.xccvld,"' ) AND ooef003 = 'Y' "
            END IF
            
            #--161013-00051#1 By shiun--(S)
#            CALL q_ooef001_8()                                #呼叫開窗
            CALL q_ooef001_2()
            #--161013-00051#1 By shiun--(E)

            LET g_xccv_m.xccvcomp = g_qryparam.return1              

            DISPLAY g_xccv_m.xccvcomp TO xccvcomp              #

            NEXT FIELD xccvcomp                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xccv004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv004
            #add-point:ON ACTION controlp INFIELD xccv004 name="input.c.xccv004"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccv005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv005
            #add-point:ON ACTION controlp INFIELD xccv005 name="input.c.xccv005"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccvld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccvld
            #add-point:ON ACTION controlp INFIELD xccvld name="input.c.xccvld"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccv_m.xccvld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #法人不為空時，帳套開窗開此法人的下屬帳套
            IF NOT cl_null(g_xccv_m.xccvcomp) THEN
               LET g_qryparam.where = " glaacomp = '",g_xccv_m.xccvcomp,"'"
            END IF
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xccv_m.xccvld = g_qryparam.return1              

            DISPLAY g_xccv_m.xccvld TO xccvld              #

            NEXT FIELD xccvld                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xccv003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv003
            #add-point:ON ACTION controlp INFIELD xccv003 name="input.c.xccv003"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccv_m.xccv003             #給予default值

            #給予arg
            LET g_qryparam.where = " xcat005 IN ('2','3') "

            
            CALL q_xcat001()                                #呼叫開窗

            LET g_xccv_m.xccv003 = g_qryparam.return1              

            DISPLAY g_xccv_m.xccv003 TO xccv003              #

            NEXT FIELD xccv003                          #返回原欄位


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
            DISPLAY BY NAME g_xccv_m.xccvld             
                            ,g_xccv_m.xccv003   
                            ,g_xccv_m.xccv004   
                            ,g_xccv_m.xccv005   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL axct303_xccv_t_mask_restore('restore_mask_o')
            
               UPDATE xccv_t SET (xccvcomp,xccv004,xccv005,xccvld,xccv003) = (g_xccv_m.xccvcomp,g_xccv_m.xccv004, 
                   g_xccv_m.xccv005,g_xccv_m.xccvld,g_xccv_m.xccv003)
                WHERE xccvent = g_enterprise AND xccvld = g_xccvld_t
                  AND xccv003 = g_xccv003_t
                  AND xccv004 = g_xccv004_t
                  AND xccv005 = g_xccv005_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xccv_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xccv_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xccv_m.xccvld
               LET gs_keys_bak[1] = g_xccvld_t
               LET gs_keys[2] = g_xccv_m.xccv003
               LET gs_keys_bak[2] = g_xccv003_t
               LET gs_keys[3] = g_xccv_m.xccv004
               LET gs_keys_bak[3] = g_xccv004_t
               LET gs_keys[4] = g_xccv_m.xccv005
               LET gs_keys_bak[4] = g_xccv005_t
               LET gs_keys[5] = g_xccv_d[g_detail_idx].xccv001
               LET gs_keys_bak[5] = g_xccv_d_t.xccv001
               LET gs_keys[6] = g_xccv_d[g_detail_idx].xccv002
               LET gs_keys_bak[6] = g_xccv_d_t.xccv002
               LET gs_keys[7] = g_xccv_d[g_detail_idx].xccv006
               LET gs_keys_bak[7] = g_xccv_d_t.xccv006
               LET gs_keys[8] = g_xccv_d[g_detail_idx].xccv007
               LET gs_keys_bak[8] = g_xccv_d_t.xccv007
               LET gs_keys[9] = g_xccv_d[g_detail_idx].xccv008
               LET gs_keys_bak[9] = g_xccv_d_t.xccv008
               LET gs_keys[10] = g_xccv_d[g_detail_idx].xccv009
               LET gs_keys_bak[10] = g_xccv_d_t.xccv009
               LET gs_keys[11] = g_xccv_d[g_detail_idx].xccv010
               LET gs_keys_bak[11] = g_xccv_d_t.xccv010
               LET gs_keys[12] = g_xccv_d[g_detail_idx].xccv011
               LET gs_keys_bak[12] = g_xccv_d_t.xccv011
               CALL axct303_update_b('xccv_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_xccv_m_t)
                     #LET g_log2 = util.JSON.stringify(g_xccv_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL axct303_xccv_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axct303_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_xccvld_t = g_xccv_m.xccvld
           LET g_xccv003_t = g_xccv_m.xccv003
           LET g_xccv004_t = g_xccv_m.xccv004
           LET g_xccv005_t = g_xccv_m.xccv005
 
           
           IF g_xccv_d.getLength() = 0 THEN
              NEXT FIELD xccv001
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="axct303.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_xccv_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xccv_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axct303_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            LET g_current_page = 1
            #add-point:資料輸入前 name="input.body.before_input"
            LET g_current_page = 1
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
            CALL axct303_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axct303_cl USING g_enterprise,g_xccv_m.xccvld,g_xccv_m.xccv003,g_xccv_m.xccv004,g_xccv_m.xccv005                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE axct303_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axct303_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_xccv_d[l_ac].xccv001 IS NOT NULL
               AND g_xccv_d[l_ac].xccv002 IS NOT NULL
               AND g_xccv_d[l_ac].xccv006 IS NOT NULL
               AND g_xccv_d[l_ac].xccv007 IS NOT NULL
               AND g_xccv_d[l_ac].xccv008 IS NOT NULL
               AND g_xccv_d[l_ac].xccv009 IS NOT NULL
               AND g_xccv_d[l_ac].xccv010 IS NOT NULL
               AND g_xccv_d[l_ac].xccv011 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xccv_d_t.* = g_xccv_d[l_ac].*  #BACKUP
               LET g_xccv_d_o.* = g_xccv_d[l_ac].*  #BACKUP
               CALL axct303_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL axct303_set_no_entry_b(l_cmd)
               OPEN axct303_bcl USING g_enterprise,g_xccv_m.xccvld,
                                                g_xccv_m.xccv003,
                                                g_xccv_m.xccv004,
                                                g_xccv_m.xccv005,
 
                                                g_xccv_d_t.xccv001
                                                ,g_xccv_d_t.xccv002
                                                ,g_xccv_d_t.xccv006
                                                ,g_xccv_d_t.xccv007
                                                ,g_xccv_d_t.xccv008
                                                ,g_xccv_d_t.xccv009
                                                ,g_xccv_d_t.xccv010
                                                ,g_xccv_d_t.xccv011
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axct303_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axct303_bcl INTO g_xccv_d[l_ac].xccv001,g_xccv_d[l_ac].xccv006,g_xccv_d[l_ac].xccv007, 
                      g_xccv_d[l_ac].xccv008,g_xccv_d[l_ac].xccv009,g_xccv_d[l_ac].xccv010,g_xccv_d[l_ac].xccv011, 
                      g_xccv_d[l_ac].xccv002,g_xccv_d[l_ac].xccv101,g_xccv_d[l_ac].xccv102,g_xccv_d[l_ac].xccv102a, 
                      g_xccv_d[l_ac].xccv102b,g_xccv_d[l_ac].xccv102c,g_xccv_d[l_ac].xccv102d,g_xccv_d[l_ac].xccv102e, 
                      g_xccv_d[l_ac].xccv102f,g_xccv_d[l_ac].xccv102g,g_xccv_d[l_ac].xccv102h
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xccv_d_t.xccv001,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xccv_d_mask_o[l_ac].* =  g_xccv_d[l_ac].*
                  CALL axct303_xccv_t_mask()
                  LET g_xccv_d_mask_n[l_ac].* =  g_xccv_d[l_ac].*
                  
                  CALL axct303_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            IF l_cmd='u' THEN
               IF g_glaa015 = 'Y' THEN
                  OPEN axct303_bcl USING g_enterprise,g_xccv_m.xccvld,
                                                g_xccv_m.xccv003,
                                                g_xccv_m.xccv004,
                                                g_xccv_m.xccv005,
 
                                                '2'
                                                ,g_xccv_d_t.xccv002
                                                ,g_xccv_d_t.xccv006
                                                ,g_xccv_d_t.xccv007
                                                ,g_xccv_d_t.xccv008
                                                ,g_xccv_d_t.xccv009
                                                ,g_xccv_d_t.xccv010
                                                ,g_xccv_d_t.xccv011
 
                  IF STATUS THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "OPEN axct303_bcl:xccv001=2" 
                     LET g_errparam.code   =  STATUS 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw='Y'
                  END IF   
               END IF
               IF g_glaa019 = 'Y' THEN
                  OPEN axct303_bcl USING g_enterprise,g_xccv_m.xccvld,
                                                g_xccv_m.xccv003,
                                                g_xccv_m.xccv004,
                                                g_xccv_m.xccv005,
 
                                                '3'
                                                ,g_xccv_d_t.xccv002
                                                ,g_xccv_d_t.xccv006
                                                ,g_xccv_d_t.xccv007
                                                ,g_xccv_d_t.xccv008
                                                ,g_xccv_d_t.xccv009
                                                ,g_xccv_d_t.xccv010
                                                ,g_xccv_d_t.xccv011
 
                  IF STATUS THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "OPEN axct303_bcl:xccv001=2" 
                     LET g_errparam.code   =  STATUS 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw='Y'
                  END IF   
               END IF
            END IF
            #end add-point  
            
 
        
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_xccv_d_t.* TO NULL
            INITIALIZE g_xccv_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xccv_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_xccv_d[l_ac].xccv001 = "1"
      LET g_xccv_d[l_ac].xccv101 = "0"
      LET g_xccv_d[l_ac].xccv102 = "0"
      LET g_xccv_d[l_ac].xccv102a = "0"
      LET g_xccv_d[l_ac].xccv102b = "0"
      LET g_xccv_d[l_ac].xccv102c = "0"
      LET g_xccv_d[l_ac].xccv102d = "0"
      LET g_xccv_d[l_ac].xccv102e = "0"
      LET g_xccv_d[l_ac].xccv102f = "0"
      LET g_xccv_d[l_ac].xccv102g = "0"
      LET g_xccv_d[l_ac].xccv102h = "0"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_xccv_d_t.* = g_xccv_d[l_ac].*     #新輸入資料
            LET g_xccv_d_o.* = g_xccv_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axct303_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL axct303_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xccv_d[li_reproduce_target].* = g_xccv_d[li_reproduce].*
 
               LET g_xccv_d[g_xccv_d.getLength()].xccv001 = NULL
               LET g_xccv_d[g_xccv_d.getLength()].xccv002 = NULL
               LET g_xccv_d[g_xccv_d.getLength()].xccv006 = NULL
               LET g_xccv_d[g_xccv_d.getLength()].xccv007 = NULL
               LET g_xccv_d[g_xccv_d.getLength()].xccv008 = NULL
               LET g_xccv_d[g_xccv_d.getLength()].xccv009 = NULL
               LET g_xccv_d[g_xccv_d.getLength()].xccv010 = NULL
               LET g_xccv_d[g_xccv_d.getLength()].xccv011 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM xccv_t 
             WHERE xccvent = g_enterprise AND xccvld = g_xccv_m.xccvld
               AND xccv003 = g_xccv_m.xccv003
               AND xccv004 = g_xccv_m.xccv004
               AND xccv005 = g_xccv_m.xccv005
 
               AND xccv001 = g_xccv_d[l_ac].xccv001
               AND xccv002 = g_xccv_d[l_ac].xccv002
               AND xccv006 = g_xccv_d[l_ac].xccv006
               AND xccv007 = g_xccv_d[l_ac].xccv007
               AND xccv008 = g_xccv_d[l_ac].xccv008
               AND xccv009 = g_xccv_d[l_ac].xccv009
               AND xccv010 = g_xccv_d[l_ac].xccv010
               AND xccv011 = g_xccv_d[l_ac].xccv011
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               IF cl_null(g_xccv_d[l_ac].xccv002) THEN LET g_xccv_d[l_ac].xccv002 = ' ' END IF
               IF cl_null(g_xccv_d[l_ac].xccv008) THEN LET g_xccv_d[l_ac].xccv008 = ' ' END IF
               IF cl_null(g_xccv_d[l_ac].xccv010) THEN LET g_xccv_d[l_ac].xccv010 = ' ' END IF
               IF cl_null(g_xccv_d[l_ac].xccv011) THEN LET g_xccv_d[l_ac].xccv011 = ' ' END IF
               IF cl_null(g_xccv_d[l_ac].xccv101) THEN LET g_xccv_d[l_ac].xccv101 = 0 END IF
               #end add-point
               INSERT INTO xccv_t
                           (xccvent,
                            xccvcomp,xccv004,xccv005,xccvld,xccv003,
                            xccv001,xccv002,xccv006,xccv007,xccv008,xccv009,xccv010,xccv011
                            ,xccv101,xccv102,xccv102a,xccv102b,xccv102c,xccv102d,xccv102e,xccv102f,xccv102g,xccv102h) 
                     VALUES(g_enterprise,
                            g_xccv_m.xccvcomp,g_xccv_m.xccv004,g_xccv_m.xccv005,g_xccv_m.xccvld,g_xccv_m.xccv003,
                            g_xccv_d[l_ac].xccv001,g_xccv_d[l_ac].xccv002,g_xccv_d[l_ac].xccv006,g_xccv_d[l_ac].xccv007, 
                                g_xccv_d[l_ac].xccv008,g_xccv_d[l_ac].xccv009,g_xccv_d[l_ac].xccv010, 
                                g_xccv_d[l_ac].xccv011
                            ,g_xccv_d[l_ac].xccv101,g_xccv_d[l_ac].xccv102,g_xccv_d[l_ac].xccv102a,g_xccv_d[l_ac].xccv102b, 
                                g_xccv_d[l_ac].xccv102c,g_xccv_d[l_ac].xccv102d,g_xccv_d[l_ac].xccv102e, 
                                g_xccv_d[l_ac].xccv102f,g_xccv_d[l_ac].xccv102g,g_xccv_d[l_ac].xccv102h) 
 
               #add-point:單身新增中 name="input.body.m_insert"
               CALL axct303_insert_xccv()
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_xccv_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "xccv_t:",SQLERRMESSAGE 
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
               IF axct303_before_delete() THEN 
                  
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_xccv_m.xccvld
                  LET gs_keys[gs_keys.getLength()+1] = g_xccv_m.xccv003
                  LET gs_keys[gs_keys.getLength()+1] = g_xccv_m.xccv004
                  LET gs_keys[gs_keys.getLength()+1] = g_xccv_m.xccv005
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xccv_d_t.xccv001
                  LET gs_keys[gs_keys.getLength()+1] = g_xccv_d_t.xccv002
                  LET gs_keys[gs_keys.getLength()+1] = g_xccv_d_t.xccv006
                  LET gs_keys[gs_keys.getLength()+1] = g_xccv_d_t.xccv007
                  LET gs_keys[gs_keys.getLength()+1] = g_xccv_d_t.xccv008
                  LET gs_keys[gs_keys.getLength()+1] = g_xccv_d_t.xccv009
                  LET gs_keys[gs_keys.getLength()+1] = g_xccv_d_t.xccv010
                  LET gs_keys[gs_keys.getLength()+1] = g_xccv_d_t.xccv011
 
 
                  #刪除下層單身
                  IF NOT axct303_key_delete_b(gs_keys,'xccv_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE axct303_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axct303_bcl
               LET l_count = g_xccv_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               IF g_rec_b = 0 THEN                  
                  RETURN
               END IF 
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_xccv_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv001
            #add-point:BEFORE FIELD xccv001 name="input.b.page1.xccv001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv001
            
            #add-point:AFTER FIELD xccv001 name="input.a.page1.xccv001"
            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF  g_xccv_m.xccvld IS NOT NULL AND g_xccv_m.xccv003 IS NOT NULL AND g_xccv_m.xccv004 IS NOT NULL AND g_xccv_m.xccv005 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv001 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv002 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv006 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv007 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv008 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv009 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv010 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv011 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccv_m.xccvld != g_xccvld_t OR g_xccv_m.xccv003 != g_xccv003_t OR g_xccv_m.xccv004 != g_xccv004_t OR g_xccv_m.xccv005 != g_xccv005_t OR g_xccv_d[g_detail_idx].xccv001 != g_xccv_d_t.xccv001 OR g_xccv_d[g_detail_idx].xccv002 != g_xccv_d_t.xccv002 OR g_xccv_d[g_detail_idx].xccv006 != g_xccv_d_t.xccv006 OR g_xccv_d[g_detail_idx].xccv007 != g_xccv_d_t.xccv007 OR g_xccv_d[g_detail_idx].xccv008 != g_xccv_d_t.xccv008 OR g_xccv_d[g_detail_idx].xccv009 != g_xccv_d_t.xccv009 OR g_xccv_d[g_detail_idx].xccv010 != g_xccv_d_t.xccv010 OR g_xccv_d[g_detail_idx].xccv011 != g_xccv_d_t.xccv011)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccv_t WHERE "||"xccvent = '" ||g_enterprise|| "' AND "||"xccvld = '"||g_xccv_m.xccvld ||"' AND "|| "xccv003 = '"||g_xccv_m.xccv003 ||"' AND "|| "xccv004 = '"||g_xccv_m.xccv004 ||"' AND "|| "xccv005 = '"||g_xccv_m.xccv005 ||"' AND "|| "xccv001 = '"||g_xccv_d[g_detail_idx].xccv001 ||"' AND "|| "xccv002 = '"||g_xccv_d[g_detail_idx].xccv002 ||"' AND "|| "xccv006 = '"||g_xccv_d[g_detail_idx].xccv006 ||"' AND "|| "xccv007 = '"||g_xccv_d[g_detail_idx].xccv007 ||"' AND "|| "xccv008 = '"||g_xccv_d[g_detail_idx].xccv008 ||"' AND "|| "xccv009 = '"||g_xccv_d[g_detail_idx].xccv009 ||"' AND "|| "xccv010 = '"||g_xccv_d[g_detail_idx].xccv010 ||"' AND "|| "xccv011 = '"||g_xccv_d[g_detail_idx].xccv011 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccv001
            #add-point:ON CHANGE xccv001 name="input.g.page1.xccv001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv006
            #add-point:BEFORE FIELD xccv006 name="input.b.page1.xccv006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv006
            
            #add-point:AFTER FIELD xccv006 name="input.a.page1.xccv006"
            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF  g_xccv_m.xccvld IS NOT NULL AND g_xccv_m.xccv003 IS NOT NULL AND g_xccv_m.xccv004 IS NOT NULL AND g_xccv_m.xccv005 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv001 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv002 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv006 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv007 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv008 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv009 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv010 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv011 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccv_m.xccvld != g_xccvld_t OR g_xccv_m.xccv003 != g_xccv003_t OR g_xccv_m.xccv004 != g_xccv004_t OR g_xccv_m.xccv005 != g_xccv005_t OR g_xccv_d[g_detail_idx].xccv001 != g_xccv_d_t.xccv001 OR g_xccv_d[g_detail_idx].xccv002 != g_xccv_d_t.xccv002 OR g_xccv_d[g_detail_idx].xccv006 != g_xccv_d_t.xccv006 OR g_xccv_d[g_detail_idx].xccv007 != g_xccv_d_t.xccv007 OR g_xccv_d[g_detail_idx].xccv008 != g_xccv_d_t.xccv008 OR g_xccv_d[g_detail_idx].xccv009 != g_xccv_d_t.xccv009 OR g_xccv_d[g_detail_idx].xccv010 != g_xccv_d_t.xccv010 OR g_xccv_d[g_detail_idx].xccv011 != g_xccv_d_t.xccv011)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccv_t WHERE "||"xccvent = '" ||g_enterprise|| "' AND "||"xccvld = '"||g_xccv_m.xccvld ||"' AND "|| "xccv003 = '"||g_xccv_m.xccv003 ||"' AND "|| "xccv004 = '"||g_xccv_m.xccv004 ||"' AND "|| "xccv005 = '"||g_xccv_m.xccv005 ||"' AND "|| "xccv001 = '"||g_xccv_d[g_detail_idx].xccv001 ||"' AND "|| "xccv002 = '"||g_xccv_d[g_detail_idx].xccv002 ||"' AND "|| "xccv006 = '"||g_xccv_d[g_detail_idx].xccv006 ||"' AND "|| "xccv007 = '"||g_xccv_d[g_detail_idx].xccv007 ||"' AND "|| "xccv008 = '"||g_xccv_d[g_detail_idx].xccv008 ||"' AND "|| "xccv009 = '"||g_xccv_d[g_detail_idx].xccv009 ||"' AND "|| "xccv010 = '"||g_xccv_d[g_detail_idx].xccv010 ||"' AND "|| "xccv011 = '"||g_xccv_d[g_detail_idx].xccv011 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_xccv_d[l_ac].xccv006) THEN
               LET l_n = 0 
               SELECT COUNT(*) INTO l_n FROM sfba_t
                WHERE sfbaent = g_enterprise  
                  AND sfbadocno = g_xccv_d[l_ac].xccv006 
               IF l_n = 0 THEN
                  LET g_xccv_d[l_ac].xccv006 = g_xccv_d_t.xccv006
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axc-00232'
                  LET g_errparam.extend = g_xccv_d[l_ac].xccv006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD xccv006
               END IF
               LET l_n = 0 
               SELECT COUNT(*) INTO l_n FROM sfaa_t
                WHERE sfaaent = g_enterprise  
                  AND sfaadocno = g_xccv_d[l_ac].xccv006  AND sfaastus NOT IN('C','E','M','X')
               IF l_n = 0 THEN
                  LET g_xccv_d[l_ac].xccv006 = g_xccv_d_t.xccv006
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axc-00233'
                  LET g_errparam.extend = g_xccv_d[l_ac].xccv006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD xccv006
               END IF
               IF NOT cl_null(g_xccv_d[l_ac].xccv009) THEN
                  LET l_n = 0 
                  SELECT COUNT(*) INTO l_n FROM sfba_t,sfaa_t
                   WHERE sfaaent = sfbaent AND sfbadocno = sfaadocno 
                     AND sfbaent = g_enterprise AND sfba006 = g_xccv_d[l_ac].xccv009 
                     AND sfaastus NOT IN('C','E','M','X')
                     AND sfbadocno = g_xccv_d[l_ac].xccv006
                  IF l_n = 0 THEN
                     LET g_xccv_d[l_ac].xccv006 = g_xccv_d_t.xccv006
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axc-00234'
                     LET g_errparam.extend = g_xccv_d[l_ac].xccv006
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                 
                     NEXT FIELD xccv006
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccv006
            #add-point:ON CHANGE xccv006 name="input.g.page1.xccv006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv007
            
            #add-point:AFTER FIELD xccv007 name="input.a.page1.xccv007"
            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF  g_xccv_m.xccvld IS NOT NULL AND g_xccv_m.xccv003 IS NOT NULL AND g_xccv_m.xccv004 IS NOT NULL AND g_xccv_m.xccv005 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv001 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv002 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv006 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv007 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv008 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv009 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv010 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv011 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccv_m.xccvld != g_xccvld_t OR g_xccv_m.xccv003 != g_xccv003_t OR g_xccv_m.xccv004 != g_xccv004_t OR g_xccv_m.xccv005 != g_xccv005_t OR g_xccv_d[g_detail_idx].xccv001 != g_xccv_d_t.xccv001 OR g_xccv_d[g_detail_idx].xccv002 != g_xccv_d_t.xccv002 OR g_xccv_d[g_detail_idx].xccv006 != g_xccv_d_t.xccv006 OR g_xccv_d[g_detail_idx].xccv007 != g_xccv_d_t.xccv007 OR g_xccv_d[g_detail_idx].xccv008 != g_xccv_d_t.xccv008 OR g_xccv_d[g_detail_idx].xccv009 != g_xccv_d_t.xccv009 OR g_xccv_d[g_detail_idx].xccv010 != g_xccv_d_t.xccv010 OR g_xccv_d[g_detail_idx].xccv011 != g_xccv_d_t.xccv011)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccv_t WHERE "||"xccvent = '" ||g_enterprise|| "' AND "||"xccvld = '"||g_xccv_m.xccvld ||"' AND "|| "xccv003 = '"||g_xccv_m.xccv003 ||"' AND "|| "xccv004 = '"||g_xccv_m.xccv004 ||"' AND "|| "xccv005 = '"||g_xccv_m.xccv005 ||"' AND "|| "xccv001 = '"||g_xccv_d[g_detail_idx].xccv001 ||"' AND "|| "xccv002 = '"||g_xccv_d[g_detail_idx].xccv002 ||"' AND "|| "xccv006 = '"||g_xccv_d[g_detail_idx].xccv006 ||"' AND "|| "xccv007 = '"||g_xccv_d[g_detail_idx].xccv007 ||"' AND "|| "xccv008 = '"||g_xccv_d[g_detail_idx].xccv008 ||"' AND "|| "xccv009 = '"||g_xccv_d[g_detail_idx].xccv009 ||"' AND "|| "xccv010 = '"||g_xccv_d[g_detail_idx].xccv010 ||"' AND "|| "xccv011 = '"||g_xccv_d[g_detail_idx].xccv011 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #160929-00005#4---add---s
#            IF NOT cl_null(g_xccv_d[l_ac].xccv007)  THEN  #161121-00018#11 mark
            IF NOT cl_null(g_xccv_d[l_ac].xccv007) AND g_xccv_d[l_ac].xccv007 !='END' THEN   #161121-00018#11 add
               IF NOT s_azzi650_chk_exist('221',g_xccv_d[l_ac].xccv007) THEN
                  LET　g_xccv_d[l_ac].xccv007 = g_xccv_d[l_ac].xccv007
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_desc_get_acc_desc('221',g_xccv_d[l_ac].xccv007) RETURNING g_xccv_d[l_ac].xccv007_desc
            DISPLAY BY NAME g_xccv_d[l_ac].xccv007_desc
            #160929-00005#4---add---e
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv007
            #add-point:BEFORE FIELD xccv007 name="input.b.page1.xccv007"
            #160929-00005#4---add---s
            CALL s_desc_get_acc_desc('221',g_xccv_d[l_ac].xccv007) RETURNING g_xccv_d[l_ac].xccv007_desc
            DISPLAY BY NAME g_xccv_d[l_ac].xccv007_desc
            #160929-00005#4---add---e
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccv007
            #add-point:ON CHANGE xccv007 name="input.g.page1.xccv007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv008
            #add-point:BEFORE FIELD xccv008 name="input.b.page1.xccv008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv008
            
            #add-point:AFTER FIELD xccv008 name="input.a.page1.xccv008"
            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF  g_xccv_m.xccvld IS NOT NULL AND g_xccv_m.xccv003 IS NOT NULL AND g_xccv_m.xccv004 IS NOT NULL AND g_xccv_m.xccv005 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv001 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv002 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv006 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv007 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv008 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv009 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv010 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv011 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccv_m.xccvld != g_xccvld_t OR g_xccv_m.xccv003 != g_xccv003_t OR g_xccv_m.xccv004 != g_xccv004_t OR g_xccv_m.xccv005 != g_xccv005_t OR g_xccv_d[g_detail_idx].xccv001 != g_xccv_d_t.xccv001 OR g_xccv_d[g_detail_idx].xccv002 != g_xccv_d_t.xccv002 OR g_xccv_d[g_detail_idx].xccv006 != g_xccv_d_t.xccv006 OR g_xccv_d[g_detail_idx].xccv007 != g_xccv_d_t.xccv007 OR g_xccv_d[g_detail_idx].xccv008 != g_xccv_d_t.xccv008 OR g_xccv_d[g_detail_idx].xccv009 != g_xccv_d_t.xccv009 OR g_xccv_d[g_detail_idx].xccv010 != g_xccv_d_t.xccv010 OR g_xccv_d[g_detail_idx].xccv011 != g_xccv_d_t.xccv011)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccv_t WHERE "||"xccvent = '" ||g_enterprise|| "' AND "||"xccvld = '"||g_xccv_m.xccvld ||"' AND "|| "xccv003 = '"||g_xccv_m.xccv003 ||"' AND "|| "xccv004 = '"||g_xccv_m.xccv004 ||"' AND "|| "xccv005 = '"||g_xccv_m.xccv005 ||"' AND "|| "xccv001 = '"||g_xccv_d[g_detail_idx].xccv001 ||"' AND "|| "xccv002 = '"||g_xccv_d[g_detail_idx].xccv002 ||"' AND "|| "xccv006 = '"||g_xccv_d[g_detail_idx].xccv006 ||"' AND "|| "xccv007 = '"||g_xccv_d[g_detail_idx].xccv007 ||"' AND "|| "xccv008 = '"||g_xccv_d[g_detail_idx].xccv008 ||"' AND "|| "xccv009 = '"||g_xccv_d[g_detail_idx].xccv009 ||"' AND "|| "xccv010 = '"||g_xccv_d[g_detail_idx].xccv010 ||"' AND "|| "xccv011 = '"||g_xccv_d[g_detail_idx].xccv011 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccv008
            #add-point:ON CHANGE xccv008 name="input.g.page1.xccv008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv009
            
            #add-point:AFTER FIELD xccv009 name="input.a.page1.xccv009"
            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF  g_xccv_m.xccvld IS NOT NULL AND g_xccv_m.xccv003 IS NOT NULL AND g_xccv_m.xccv004 IS NOT NULL AND g_xccv_m.xccv005 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv001 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv002 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv006 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv007 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv008 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv009 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv010 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv011 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccv_m.xccvld != g_xccvld_t OR g_xccv_m.xccv003 != g_xccv003_t OR g_xccv_m.xccv004 != g_xccv004_t OR g_xccv_m.xccv005 != g_xccv005_t OR g_xccv_d[g_detail_idx].xccv001 != g_xccv_d_t.xccv001 OR g_xccv_d[g_detail_idx].xccv002 != g_xccv_d_t.xccv002 OR g_xccv_d[g_detail_idx].xccv006 != g_xccv_d_t.xccv006 OR g_xccv_d[g_detail_idx].xccv007 != g_xccv_d_t.xccv007 OR g_xccv_d[g_detail_idx].xccv008 != g_xccv_d_t.xccv008 OR g_xccv_d[g_detail_idx].xccv009 != g_xccv_d_t.xccv009 OR g_xccv_d[g_detail_idx].xccv010 != g_xccv_d_t.xccv010 OR g_xccv_d[g_detail_idx].xccv011 != g_xccv_d_t.xccv011)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccv_t WHERE "||"xccvent = '" ||g_enterprise|| "' AND "||"xccvld = '"||g_xccv_m.xccvld ||"' AND "|| "xccv003 = '"||g_xccv_m.xccv003 ||"' AND "|| "xccv004 = '"||g_xccv_m.xccv004 ||"' AND "|| "xccv005 = '"||g_xccv_m.xccv005 ||"' AND "|| "xccv001 = '"||g_xccv_d[g_detail_idx].xccv001 ||"' AND "|| "xccv002 = '"||g_xccv_d[g_detail_idx].xccv002 ||"' AND "|| "xccv006 = '"||g_xccv_d[g_detail_idx].xccv006 ||"' AND "|| "xccv007 = '"||g_xccv_d[g_detail_idx].xccv007 ||"' AND "|| "xccv008 = '"||g_xccv_d[g_detail_idx].xccv008 ||"' AND "|| "xccv009 = '"||g_xccv_d[g_detail_idx].xccv009 ||"' AND "|| "xccv010 = '"||g_xccv_d[g_detail_idx].xccv010 ||"' AND "|| "xccv011 = '"||g_xccv_d[g_detail_idx].xccv011 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #160929-00005#4---add---s
            IF NOT cl_null(g_xccv_d[l_ac].xccv009) AND g_xccv_d[l_ac].xccv009 <> 'DL+OH+SUB' THEN  #161121-00018#11 add
    
               #應用 a19 樣板自動產生(Version:1)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xccv_d[l_ac].xccv009
               
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_imaa001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_xccv_d[l_ac].xccv009 = g_xccv_d_t.xccv009
                  NEXT FIELD CURRENT
               END IF

                 #161121-00018#11 add(s)
                 LET l_n = 0 
                 SELECT COUNT(*) INTO l_n FROM sfba_t,imaa_t
                  WHERE sfbaent = imaaent AND sfba006 = imaa001 AND sfbaent = g_enterprise  
                    AND sfba006 = g_xccv_d[l_ac].xccv009 AND imaastus = 'Y'
                 IF l_n = 0 THEN
                    LET g_xccv_d[l_ac].xccv009 = g_xccv_d_t.xccv009
                    CALL s_desc_get_item_desc(g_xccv_d[l_ac].xccv009) 
                         RETURNING g_xccv_d[l_ac].xccv009_desc,g_xccv_d[l_ac].xccv009_desc_desc
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'ain-00300'
                    LET g_errparam.extend = g_xccv_d[l_ac].xccv009
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                  
                    NEXT FIELD xccv009
                 END IF
                 
                 IF NOT cl_null(g_xccv_d[l_ac].xccv006) THEN
                    LET l_n = 0 
                    SELECT COUNT(*) INTO l_n FROM sfba_t,sfaa_t
                     WHERE sfaaent = sfbaent AND sfbadocno = sfaadocno 
                       AND sfbaent = g_enterprise AND sfba006 = g_xccv_d[l_ac].xccv009 
                       AND sfaastus NOT IN('C','E','M','X')
                       AND sfbadocno = g_xccv_d[l_ac].xccv006
                    IF l_n = 0 THEN
                       LET g_xccv_d[l_ac].xccv009 = g_xccv_d_t.xccv009
                       CALL s_desc_get_item_desc(g_xccv_d[l_ac].xccv009) 
                           RETURNING g_xccv_d[l_ac].xccv009_desc,g_xccv_d[l_ac].xccv009_desc_desc
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.code = 'axc-00231'
                       LET g_errparam.extend = g_xccv_d[l_ac].xccv009
                       LET g_errparam.popup = TRUE
                       CALL cl_err()
                  
                       NEXT FIELD xccv009
                    END IF
                 END IF
                 IF g_xccv_d[l_ac].xccv010 IS NULL THEN
                    LET g_xccv_d[l_ac].xccv010 = ' '
                 END IF
                 #161121-00018#11add(e)
            END IF             
            #160929-00005#4---add---s
            CALL s_desc_get_item_desc(g_xccv_d[l_ac].xccv009) 
                RETURNING g_xccv_d[l_ac].xccv009_desc,g_xccv_d[l_ac].xccv009_desc_desc
            DISPLAY BY NAME g_xccv_d[l_ac].xccv009_desc,g_xccv_d[l_ac].xccv009_desc_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv009
            #add-point:BEFORE FIELD xccv009 name="input.b.page1.xccv009"
            #160929-00005#4---add---s
            CALL s_desc_get_item_desc(g_xccv_d[l_ac].xccv009) 
                RETURNING g_xccv_d[l_ac].xccv009_desc,g_xccv_d[l_ac].xccv009_desc_desc
            DISPLAY BY NAME g_xccv_d[l_ac].xccv009_desc,g_xccv_d[l_ac].xccv009_desc_desc            
            #160929-00005#4---add---e
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccv009
            #add-point:ON CHANGE xccv009 name="input.g.page1.xccv009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv010
            #add-point:BEFORE FIELD xccv010 name="input.b.page1.xccv010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv010
            
            #add-point:AFTER FIELD xccv010 name="input.a.page1.xccv010"
            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF  g_xccv_m.xccvld IS NOT NULL AND g_xccv_m.xccv003 IS NOT NULL AND g_xccv_m.xccv004 IS NOT NULL AND g_xccv_m.xccv005 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv001 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv002 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv006 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv007 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv008 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv009 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv010 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv011 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccv_m.xccvld != g_xccvld_t OR g_xccv_m.xccv003 != g_xccv003_t OR g_xccv_m.xccv004 != g_xccv004_t OR g_xccv_m.xccv005 != g_xccv005_t OR g_xccv_d[g_detail_idx].xccv001 != g_xccv_d_t.xccv001 OR g_xccv_d[g_detail_idx].xccv002 != g_xccv_d_t.xccv002 OR g_xccv_d[g_detail_idx].xccv006 != g_xccv_d_t.xccv006 OR g_xccv_d[g_detail_idx].xccv007 != g_xccv_d_t.xccv007 OR g_xccv_d[g_detail_idx].xccv008 != g_xccv_d_t.xccv008 OR g_xccv_d[g_detail_idx].xccv009 != g_xccv_d_t.xccv009 OR g_xccv_d[g_detail_idx].xccv010 != g_xccv_d_t.xccv010 OR g_xccv_d[g_detail_idx].xccv011 != g_xccv_d_t.xccv011)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccv_t WHERE "||"xccvent = '" ||g_enterprise|| "' AND "||"xccvld = '"||g_xccv_m.xccvld ||"' AND "|| "xccv003 = '"||g_xccv_m.xccv003 ||"' AND "|| "xccv004 = '"||g_xccv_m.xccv004 ||"' AND "|| "xccv005 = '"||g_xccv_m.xccv005 ||"' AND "|| "xccv001 = '"||g_xccv_d[g_detail_idx].xccv001 ||"' AND "|| "xccv002 = '"||g_xccv_d[g_detail_idx].xccv002 ||"' AND "|| "xccv006 = '"||g_xccv_d[g_detail_idx].xccv006 ||"' AND "|| "xccv007 = '"||g_xccv_d[g_detail_idx].xccv007 ||"' AND "|| "xccv008 = '"||g_xccv_d[g_detail_idx].xccv008 ||"' AND "|| "xccv009 = '"||g_xccv_d[g_detail_idx].xccv009 ||"' AND "|| "xccv010 = '"||g_xccv_d[g_detail_idx].xccv010 ||"' AND "|| "xccv011 = '"||g_xccv_d[g_detail_idx].xccv011 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF cl_null(g_xccv_d[l_ac].xccv010) THEN LET g_xccv_d[l_ac].xccv010 = ' ' END IF   #fengmy150804
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccv010
            #add-point:ON CHANGE xccv010 name="input.g.page1.xccv010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv011
            #add-point:BEFORE FIELD xccv011 name="input.b.page1.xccv011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv011
            
            #add-point:AFTER FIELD xccv011 name="input.a.page1.xccv011"
            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF  g_xccv_m.xccvld IS NOT NULL AND g_xccv_m.xccv003 IS NOT NULL AND g_xccv_m.xccv004 IS NOT NULL AND g_xccv_m.xccv005 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv001 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv002 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv006 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv007 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv008 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv009 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv010 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv011 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccv_m.xccvld != g_xccvld_t OR g_xccv_m.xccv003 != g_xccv003_t OR g_xccv_m.xccv004 != g_xccv004_t OR g_xccv_m.xccv005 != g_xccv005_t OR g_xccv_d[g_detail_idx].xccv001 != g_xccv_d_t.xccv001 OR g_xccv_d[g_detail_idx].xccv002 != g_xccv_d_t.xccv002 OR g_xccv_d[g_detail_idx].xccv006 != g_xccv_d_t.xccv006 OR g_xccv_d[g_detail_idx].xccv007 != g_xccv_d_t.xccv007 OR g_xccv_d[g_detail_idx].xccv008 != g_xccv_d_t.xccv008 OR g_xccv_d[g_detail_idx].xccv009 != g_xccv_d_t.xccv009 OR g_xccv_d[g_detail_idx].xccv010 != g_xccv_d_t.xccv010 OR g_xccv_d[g_detail_idx].xccv011 != g_xccv_d_t.xccv011)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccv_t WHERE "||"xccvent = '" ||g_enterprise|| "' AND "||"xccvld = '"||g_xccv_m.xccvld ||"' AND "|| "xccv003 = '"||g_xccv_m.xccv003 ||"' AND "|| "xccv004 = '"||g_xccv_m.xccv004 ||"' AND "|| "xccv005 = '"||g_xccv_m.xccv005 ||"' AND "|| "xccv001 = '"||g_xccv_d[g_detail_idx].xccv001 ||"' AND "|| "xccv002 = '"||g_xccv_d[g_detail_idx].xccv002 ||"' AND "|| "xccv006 = '"||g_xccv_d[g_detail_idx].xccv006 ||"' AND "|| "xccv007 = '"||g_xccv_d[g_detail_idx].xccv007 ||"' AND "|| "xccv008 = '"||g_xccv_d[g_detail_idx].xccv008 ||"' AND "|| "xccv009 = '"||g_xccv_d[g_detail_idx].xccv009 ||"' AND "|| "xccv010 = '"||g_xccv_d[g_detail_idx].xccv010 ||"' AND "|| "xccv011 = '"||g_xccv_d[g_detail_idx].xccv011 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccv011
            #add-point:ON CHANGE xccv011 name="input.g.page1.xccv011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv002
            
            #add-point:AFTER FIELD xccv002 name="input.a.page1.xccv002"
            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF  g_xccv_m.xccvld IS NOT NULL AND g_xccv_m.xccv003 IS NOT NULL AND g_xccv_m.xccv004 IS NOT NULL AND g_xccv_m.xccv005 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv001 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv002 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv006 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv007 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv008 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv009 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv010 IS NOT NULL AND g_xccv_d[g_detail_idx].xccv011 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccv_m.xccvld != g_xccvld_t OR g_xccv_m.xccv003 != g_xccv003_t OR g_xccv_m.xccv004 != g_xccv004_t OR g_xccv_m.xccv005 != g_xccv005_t OR g_xccv_d[g_detail_idx].xccv001 != g_xccv_d_t.xccv001 OR g_xccv_d[g_detail_idx].xccv002 != g_xccv_d_t.xccv002 OR g_xccv_d[g_detail_idx].xccv006 != g_xccv_d_t.xccv006 OR g_xccv_d[g_detail_idx].xccv007 != g_xccv_d_t.xccv007 OR g_xccv_d[g_detail_idx].xccv008 != g_xccv_d_t.xccv008 OR g_xccv_d[g_detail_idx].xccv009 != g_xccv_d_t.xccv009 OR g_xccv_d[g_detail_idx].xccv010 != g_xccv_d_t.xccv010 OR g_xccv_d[g_detail_idx].xccv011 != g_xccv_d_t.xccv011)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccv_t WHERE "||"xccvent = '" ||g_enterprise|| "' AND "||"xccvld = '"||g_xccv_m.xccvld ||"' AND "|| "xccv003 = '"||g_xccv_m.xccv003 ||"' AND "|| "xccv004 = '"||g_xccv_m.xccv004 ||"' AND "|| "xccv005 = '"||g_xccv_m.xccv005 ||"' AND "|| "xccv001 = '"||g_xccv_d[g_detail_idx].xccv001 ||"' AND "|| "xccv002 = '"||g_xccv_d[g_detail_idx].xccv002 ||"' AND "|| "xccv006 = '"||g_xccv_d[g_detail_idx].xccv006 ||"' AND "|| "xccv007 = '"||g_xccv_d[g_detail_idx].xccv007 ||"' AND "|| "xccv008 = '"||g_xccv_d[g_detail_idx].xccv008 ||"' AND "|| "xccv009 = '"||g_xccv_d[g_detail_idx].xccv009 ||"' AND "|| "xccv010 = '"||g_xccv_d[g_detail_idx].xccv010 ||"' AND "|| "xccv011 = '"||g_xccv_d[g_detail_idx].xccv011 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_xccv_d[l_ac].xccv002) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_xccv_d[l_ac].xccv002
                  #160318-00025#12--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "axc-00041:sub-01302|aimi007|",cl_get_progname("aimi007",g_lang,"2"),"|:EXEPROGaimi007"
                  #160318-00025#12--add--end

                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_xcbf001") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME
                  ELSE
                     #檢查失敗時後續處理
                     LET g_xccv_d[l_ac].xccv002 = g_xccv_d_t.xccv002
                     NEXT FIELD CURRENT
                  END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccv_m.xccvcomp
            LET g_ref_fields[2] = g_xccv_d[l_ac].xccv002
            CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp=? AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccv_d[l_ac].xccv002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccv_d[l_ac].xccv002_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv002
            #add-point:BEFORE FIELD xccv002 name="input.b.page1.xccv002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccv002
            #add-point:ON CHANGE xccv002 name="input.g.page1.xccv002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv101
            #add-point:BEFORE FIELD xccv101 name="input.b.page1.xccv101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv101
            
            #add-point:AFTER FIELD xccv101 name="input.a.page1.xccv101"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccv101
            #add-point:ON CHANGE xccv101 name="input.g.page1.xccv101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv102
            #add-point:BEFORE FIELD xccv102 name="input.b.page1.xccv102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv102
            
            #add-point:AFTER FIELD xccv102 name="input.a.page1.xccv102"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccv102
            #add-point:ON CHANGE xccv102 name="input.g.page1.xccv102"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv102a
            #add-point:BEFORE FIELD xccv102a name="input.b.page1.xccv102a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv102a
            
            #add-point:AFTER FIELD xccv102a name="input.a.page1.xccv102a"
            CALL axct303_xccv102_sum_1()
            LET g_xccv_d[l_ac].xccv102a = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv_d[l_ac].xccv102a,2)
            LET g_xccv_d[l_ac].xccv102 = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv_d[l_ac].xccv102,2)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccv102a
            #add-point:ON CHANGE xccv102a name="input.g.page1.xccv102a"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv102b
            #add-point:BEFORE FIELD xccv102b name="input.b.page1.xccv102b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv102b
            
            #add-point:AFTER FIELD xccv102b name="input.a.page1.xccv102b"
            CALL axct303_xccv102_sum_1()
            LET g_xccv_d[l_ac].xccv102b = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv_d[l_ac].xccv102b,2)
            LET g_xccv_d[l_ac].xccv102 = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv_d[l_ac].xccv102,2)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccv102b
            #add-point:ON CHANGE xccv102b name="input.g.page1.xccv102b"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv102c
            #add-point:BEFORE FIELD xccv102c name="input.b.page1.xccv102c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv102c
            
            #add-point:AFTER FIELD xccv102c name="input.a.page1.xccv102c"
            CALL axct303_xccv102_sum_1()
            LET g_xccv_d[l_ac].xccv102c = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv_d[l_ac].xccv102c,2)
            LET g_xccv_d[l_ac].xccv102 = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv_d[l_ac].xccv102,2)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccv102c
            #add-point:ON CHANGE xccv102c name="input.g.page1.xccv102c"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv102d
            #add-point:BEFORE FIELD xccv102d name="input.b.page1.xccv102d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv102d
            
            #add-point:AFTER FIELD xccv102d name="input.a.page1.xccv102d"
            CALL axct303_xccv102_sum_1()
            LET g_xccv_d[l_ac].xccv102d = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv_d[l_ac].xccv102d,2)
            LET g_xccv_d[l_ac].xccv102 = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv_d[l_ac].xccv102,2)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccv102d
            #add-point:ON CHANGE xccv102d name="input.g.page1.xccv102d"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv102e
            #add-point:BEFORE FIELD xccv102e name="input.b.page1.xccv102e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv102e
            
            #add-point:AFTER FIELD xccv102e name="input.a.page1.xccv102e"
            CALL axct303_xccv102_sum_1()
            LET g_xccv_d[l_ac].xccv102e = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv_d[l_ac].xccv102e,2)
            LET g_xccv_d[l_ac].xccv102 = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv_d[l_ac].xccv102,2)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccv102e
            #add-point:ON CHANGE xccv102e name="input.g.page1.xccv102e"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv102f
            #add-point:BEFORE FIELD xccv102f name="input.b.page1.xccv102f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv102f
            
            #add-point:AFTER FIELD xccv102f name="input.a.page1.xccv102f"
            CALL axct303_xccv102_sum_1()
            LET g_xccv_d[l_ac].xccv102f = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv_d[l_ac].xccv102f,2)
            LET g_xccv_d[l_ac].xccv102 = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv_d[l_ac].xccv102,2)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccv102f
            #add-point:ON CHANGE xccv102f name="input.g.page1.xccv102f"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv102g
            #add-point:BEFORE FIELD xccv102g name="input.b.page1.xccv102g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv102g
            
            #add-point:AFTER FIELD xccv102g name="input.a.page1.xccv102g"
            CALL axct303_xccv102_sum_1()
            LET g_xccv_d[l_ac].xccv102g = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv_d[l_ac].xccv102g,2)
            LET g_xccv_d[l_ac].xccv102 = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv_d[l_ac].xccv102,2)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccv102g
            #add-point:ON CHANGE xccv102g name="input.g.page1.xccv102g"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccv102h
            #add-point:BEFORE FIELD xccv102h name="input.b.page1.xccv102h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccv102h
            
            #add-point:AFTER FIELD xccv102h name="input.a.page1.xccv102h"
            CALL axct303_xccv102_sum_1()
            LET g_xccv_d[l_ac].xccv102h = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv_d[l_ac].xccv102h,2)
            LET g_xccv_d[l_ac].xccv102 = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv_d[l_ac].xccv102,2)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccv102h
            #add-point:ON CHANGE xccv102h name="input.g.page1.xccv102h"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xccv001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv001
            #add-point:ON ACTION controlp INFIELD xccv001 name="input.c.page1.xccv001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccv006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv006
            #add-point:ON ACTION controlp INFIELD xccv006 name="input.c.page1.xccv006"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccv_d[l_ac].xccv006             #給予default值
            LET g_qryparam.default2 = "" #g_xccv_d[l_ac].sfbaseq1 #项序
            LET g_qryparam.default3 = "" #g_xccv_d[l_ac].sfaadocno #单号
            #給予arg
            LET g_qryparam.arg1 = "" #s
            IF NOT cl_null(g_xccv_d[l_ac].xccv009) THEN
               LET g_qryparam.where = " sfaastus NOT IN('C','E','M','X') AND sfba006 = '",g_xccv_d[l_ac].xccv009,"'"
            ELSE
               LET g_qryparam.where = " sfaastus NOT IN('C','E','M','X') "            
            END IF
#            CALL q_sfbadocno()                                #呼叫開窗 #161121-00018#11 mark
            CALL q_sfaadocno_4()             #161121-00018#11 add
            LET g_xccv_d[l_ac].xccv006 = g_qryparam.return1     
            #161121-00018#11 mark(s)            
#            LET g_sfbaseq = g_qryparam.return2                   
#            LET g_sfbaseq1 = g_qryparam.return3 
#            CALL axct303_insert_default_sfba()
             #161121-00018#11 mark(e)
            DISPLAY g_xccv_d[l_ac].xccv006 TO xccv006              #
            #DISPLAY g_xccv_d[l_ac].sfbaseq1 TO sfbaseq1 #项序
            #DISPLAY g_xccv_d[l_ac].sfaadocno TO sfaadocno #单号
            NEXT FIELD xccv006                          #返回原欄位

            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccv007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv007
            #add-point:ON ACTION controlp INFIELD xccv007 name="input.c.page1.xccv007"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccv_d[l_ac].xccv007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "221" #s  #161121-00018#11 add

            CALL q_oocq002()  #161121-00018#11 add
#            CALL q_sfba003()                                #呼叫開窗  #161121-00018#11 mark

            LET g_xccv_d[l_ac].xccv007 = g_qryparam.return1              

            DISPLAY g_xccv_d[l_ac].xccv007 TO xccv007              #

            NEXT FIELD xccv007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xccv008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv008
            #add-point:ON ACTION controlp INFIELD xccv008 name="input.c.page1.xccv008"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccv_d[l_ac].xccv008             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL q_sfba004()                                #呼叫開窗

            LET g_xccv_d[l_ac].xccv008 = g_qryparam.return1              

            DISPLAY g_xccv_d[l_ac].xccv008 TO xccv008              #

            NEXT FIELD xccv008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xccv009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv009
            #add-point:ON ACTION controlp INFIELD xccv009 name="input.c.page1.xccv009"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccv_d[l_ac].xccv009             #給予default值

            #給予arg
            #161121-00018#11 mark(s)
#            LET g_qryparam.arg1 = g_site #s
#
#            
#            CALL q_imag001()                                #呼叫開窗
            #161121-00018#11 mark(e)
            #161121-00018#11 add(s)
            IF NOT cl_null(g_xccv_d[l_ac].xccv006) THEN
               LET g_qryparam.where = " sfbadocno = '",g_xccv_d[l_ac].xccv006,"'"  
            END IF
            CALL q_sfba006_1()                                
            LET g_xccv_d[l_ac].xccv010 = g_qryparam.return2  
            DISPLAY g_xccv_d[l_ac].xccv010 TO xccv010                 
            #161121-00018#11 add(e)
            LET g_xccv_d[l_ac].xccv009 = g_qryparam.return1              
     
            DISPLAY g_xccv_d[l_ac].xccv009 TO xccv009              #

            NEXT FIELD xccv009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xccv010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv010
            #add-point:ON ACTION controlp INFIELD xccv010 name="input.c.page1.xccv010"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccv_d[l_ac].xccv010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL q_bmaa002_1()                                #呼叫開窗

            LET g_xccv_d[l_ac].xccv010 = g_qryparam.return1              

            DISPLAY g_xccv_d[l_ac].xccv010 TO xccv010              #

            NEXT FIELD xccv010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xccv011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv011
            #add-point:ON ACTION controlp INFIELD xccv011 name="input.c.page1.xccv011"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccv_d[l_ac].xccv011             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL q_inaj010()                                #呼叫開窗

            LET g_xccv_d[l_ac].xccv011 = g_qryparam.return1              

            DISPLAY g_xccv_d[l_ac].xccv011 TO xccv011              #

            NEXT FIELD xccv011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xccv002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv002
            #add-point:ON ACTION controlp INFIELD xccv002 name="input.c.page1.xccv002"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccv_d[l_ac].xccv002             #給予default值
            LET g_qryparam.where = " xcbfcomp = '",g_xccv_m.xccvcomp,"'"  #fengmy 150112
            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL q_xcbf001()                                #呼叫開窗

            LET g_xccv_d[l_ac].xccv002 = g_qryparam.return1              

            DISPLAY g_xccv_d[l_ac].xccv002 TO xccv002              #

            NEXT FIELD xccv002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xccv101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv101
            #add-point:ON ACTION controlp INFIELD xccv101 name="input.c.page1.xccv101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccv102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv102
            #add-point:ON ACTION controlp INFIELD xccv102 name="input.c.page1.xccv102"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccv102a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv102a
            #add-point:ON ACTION controlp INFIELD xccv102a name="input.c.page1.xccv102a"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccv102b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv102b
            #add-point:ON ACTION controlp INFIELD xccv102b name="input.c.page1.xccv102b"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccv102c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv102c
            #add-point:ON ACTION controlp INFIELD xccv102c name="input.c.page1.xccv102c"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccv102d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv102d
            #add-point:ON ACTION controlp INFIELD xccv102d name="input.c.page1.xccv102d"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccv102e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv102e
            #add-point:ON ACTION controlp INFIELD xccv102e name="input.c.page1.xccv102e"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccv102f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv102f
            #add-point:ON ACTION controlp INFIELD xccv102f name="input.c.page1.xccv102f"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccv102g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv102g
            #add-point:ON ACTION controlp INFIELD xccv102g name="input.c.page1.xccv102g"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccv102h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccv102h
            #add-point:ON ACTION controlp INFIELD xccv102h name="input.c.page1.xccv102h"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xccv_d[l_ac].* = g_xccv_d_t.*
               CLOSE axct303_bcl
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
               LET g_errparam.extend = g_xccv_d[l_ac].xccv001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xccv_d[l_ac].* = g_xccv_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
            
               #add-point:單身修改前 name="input.body.b_update"
               IF cl_null(g_xccv_d[l_ac].xccv010) THEN LET g_xccv_d[l_ac].xccv010 = ' ' END IF
               IF cl_null(g_xccv_d[l_ac].xccv101) THEN LET g_xccv_d[l_ac].xccv101 = 0 END IF
               #end add-point
         
               #將遮罩欄位還原
               CALL axct303_xccv_t_mask_restore('restore_mask_o')
         
               UPDATE xccv_t SET (xccvld,xccv003,xccv004,xccv005,xccv001,xccv006,xccv007,xccv008,xccv009, 
                   xccv010,xccv011,xccv002,xccv101,xccv102,xccv102a,xccv102b,xccv102c,xccv102d,xccv102e, 
                   xccv102f,xccv102g,xccv102h) = (g_xccv_m.xccvld,g_xccv_m.xccv003,g_xccv_m.xccv004, 
                   g_xccv_m.xccv005,g_xccv_d[l_ac].xccv001,g_xccv_d[l_ac].xccv006,g_xccv_d[l_ac].xccv007, 
                   g_xccv_d[l_ac].xccv008,g_xccv_d[l_ac].xccv009,g_xccv_d[l_ac].xccv010,g_xccv_d[l_ac].xccv011, 
                   g_xccv_d[l_ac].xccv002,g_xccv_d[l_ac].xccv101,g_xccv_d[l_ac].xccv102,g_xccv_d[l_ac].xccv102a, 
                   g_xccv_d[l_ac].xccv102b,g_xccv_d[l_ac].xccv102c,g_xccv_d[l_ac].xccv102d,g_xccv_d[l_ac].xccv102e, 
                   g_xccv_d[l_ac].xccv102f,g_xccv_d[l_ac].xccv102g,g_xccv_d[l_ac].xccv102h)
                WHERE xccvent = g_enterprise AND xccvld = g_xccv_m.xccvld 
                 AND xccv003 = g_xccv_m.xccv003 
                 AND xccv004 = g_xccv_m.xccv004 
                 AND xccv005 = g_xccv_m.xccv005 
 
                 AND xccv001 = g_xccv_d_t.xccv001 #項次   
                 AND xccv002 = g_xccv_d_t.xccv002  
                 AND xccv006 = g_xccv_d_t.xccv006  
                 AND xccv007 = g_xccv_d_t.xccv007  
                 AND xccv008 = g_xccv_d_t.xccv008  
                 AND xccv009 = g_xccv_d_t.xccv009  
                 AND xccv010 = g_xccv_d_t.xccv010  
                 AND xccv011 = g_xccv_d_t.xccv011  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               CALL axct303_update_xccv()
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xccv_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xccv_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xccv_m.xccvld
               LET gs_keys_bak[1] = g_xccvld_t
               LET gs_keys[2] = g_xccv_m.xccv003
               LET gs_keys_bak[2] = g_xccv003_t
               LET gs_keys[3] = g_xccv_m.xccv004
               LET gs_keys_bak[3] = g_xccv004_t
               LET gs_keys[4] = g_xccv_m.xccv005
               LET gs_keys_bak[4] = g_xccv005_t
               LET gs_keys[5] = g_xccv_d[g_detail_idx].xccv001
               LET gs_keys_bak[5] = g_xccv_d_t.xccv001
               LET gs_keys[6] = g_xccv_d[g_detail_idx].xccv002
               LET gs_keys_bak[6] = g_xccv_d_t.xccv002
               LET gs_keys[7] = g_xccv_d[g_detail_idx].xccv006
               LET gs_keys_bak[7] = g_xccv_d_t.xccv006
               LET gs_keys[8] = g_xccv_d[g_detail_idx].xccv007
               LET gs_keys_bak[8] = g_xccv_d_t.xccv007
               LET gs_keys[9] = g_xccv_d[g_detail_idx].xccv008
               LET gs_keys_bak[9] = g_xccv_d_t.xccv008
               LET gs_keys[10] = g_xccv_d[g_detail_idx].xccv009
               LET gs_keys_bak[10] = g_xccv_d_t.xccv009
               LET gs_keys[11] = g_xccv_d[g_detail_idx].xccv010
               LET gs_keys_bak[11] = g_xccv_d_t.xccv010
               LET gs_keys[12] = g_xccv_d[g_detail_idx].xccv011
               LET gs_keys_bak[12] = g_xccv_d_t.xccv011
               CALL axct303_update_b('xccv_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_xccv_m),util.JSON.stringify(g_xccv_d_t)
                     LET g_log2 = util.JSON.stringify(g_xccv_m),util.JSON.stringify(g_xccv_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axct303_xccv_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_xccv_m.xccvld
               LET ls_keys[ls_keys.getLength()+1] = g_xccv_m.xccv003
               LET ls_keys[ls_keys.getLength()+1] = g_xccv_m.xccv004
               LET ls_keys[ls_keys.getLength()+1] = g_xccv_m.xccv005
 
               LET ls_keys[ls_keys.getLength()+1] = g_xccv_d_t.xccv001
               LET ls_keys[ls_keys.getLength()+1] = g_xccv_d_t.xccv002
               LET ls_keys[ls_keys.getLength()+1] = g_xccv_d_t.xccv006
               LET ls_keys[ls_keys.getLength()+1] = g_xccv_d_t.xccv007
               LET ls_keys[ls_keys.getLength()+1] = g_xccv_d_t.xccv008
               LET ls_keys[ls_keys.getLength()+1] = g_xccv_d_t.xccv009
               LET ls_keys[ls_keys.getLength()+1] = g_xccv_d_t.xccv010
               LET ls_keys[ls_keys.getLength()+1] = g_xccv_d_t.xccv011
 
               CALL axct303_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               CALL s_transaction_end('Y','0') 
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE axct303_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xccv_d[l_ac].* = g_xccv_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE axct303_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xccv_d.getLength() = 0 THEN
               NEXT FIELD xccv001
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xccv_d[li_reproduce_target].* = g_xccv_d[li_reproduce].*
 
               LET g_xccv_d[li_reproduce_target].xccv001 = NULL
               LET g_xccv_d[li_reproduce_target].xccv002 = NULL
               LET g_xccv_d[li_reproduce_target].xccv006 = NULL
               LET g_xccv_d[li_reproduce_target].xccv007 = NULL
               LET g_xccv_d[li_reproduce_target].xccv008 = NULL
               LET g_xccv_d[li_reproduce_target].xccv009 = NULL
               LET g_xccv_d[li_reproduce_target].xccv010 = NULL
               LET g_xccv_d[li_reproduce_target].xccv011 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xccv_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xccv_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
 
      
 
      
 
    
      #add-point:input段more_input name="input.more_inputarray"
      INPUT ARRAY g_xccv2_d FROM s_detail2.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = 0,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = 0)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xccv2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axct303_b_fill_2() #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            #add-point:資料輸入前
            LET g_current_page = 2
            #end add-point
         
         BEFORE ROW
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct303_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axct303_cl USING g_enterprise,g_xccv_m.xccvld,g_xccv_m.xccv003,g_xccv_m.xccv004,g_xccv_m.xccv005                          
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axct303_cl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLOSE axct303_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            
            IF g_rec_b >= l_ac 
               AND g_xccv2_d[l_ac].xccv001 IS NOT NULL
               AND g_xccv2_d[l_ac].xccv002 IS NOT NULL
               AND g_xccv2_d[l_ac].xccv006 IS NOT NULL
               AND g_xccv2_d[l_ac].xccv007 IS NOT NULL
               AND g_xccv2_d[l_ac].xccv008 IS NOT NULL
               AND g_xccv2_d[l_ac].xccv009 IS NOT NULL
               AND g_xccv2_d[l_ac].xccv010 IS NOT NULL
               AND g_xccv2_d[l_ac].xccv011 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xccv2_d_t.* = g_xccv2_d[l_ac].*  #BACKUP
               LET g_xccv2_d_o.* = g_xccv2_d[l_ac].*  #BACKUP
               CALL axct303_set_entry_b(l_cmd)
               #add-point:set_entry_b後

               #end add-point
               CALL axct303_set_no_entry_b(l_cmd)
               OPEN axct303_bcl USING g_enterprise,g_xccv_m.xccvld,
                                                g_xccv_m.xccv003,
                                                g_xccv_m.xccv004,
                                                g_xccv_m.xccv005,
 
                                                g_xccv2_d_t.xccv001
                                                ,g_xccv2_d_t.xccv002
                                                ,g_xccv2_d_t.xccv006
                                                ,g_xccv2_d_t.xccv007
                                                ,g_xccv2_d_t.xccv008
                                                ,g_xccv2_d_t.xccv009
                                                ,g_xccv2_d_t.xccv010
                                                ,g_xccv2_d_t.xccv011
 
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axct303_bcl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axct303_bcl INTO g_xccv2_d[l_ac].xccv001,g_xccv2_d[l_ac].xccv006,g_xccv2_d[l_ac].xccv007, 
                      g_xccv2_d[l_ac].xccv008,g_xccv2_d[l_ac].xccv009,g_xccv2_d[l_ac].xccv010,g_xccv2_d[l_ac].xccv011, 
                      g_xccv2_d[l_ac].xccv002,g_xccv2_d[l_ac].xccv101,g_xccv2_d[l_ac].xccv102,g_xccv2_d[l_ac].xccv102a, 
                      g_xccv2_d[l_ac].xccv102b,g_xccv2_d[l_ac].xccv102c,g_xccv2_d[l_ac].xccv102d,g_xccv2_d[l_ac].xccv102e, 
                      g_xccv2_d[l_ac].xccv102f,g_xccv2_d[l_ac].xccv102g,g_xccv2_d[l_ac].xccv102h
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xccv2_d_t.xccv001 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  CALL axct303_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            IF l_cmd='u' THEN
               
                  OPEN axct303_bcl USING g_enterprise,g_xccv_m.xccvld,
                                                g_xccv_m.xccv003,
                                                g_xccv_m.xccv004,
                                                g_xccv_m.xccv005,
 
                                                '1'
                                                ,g_xccv2_d_t.xccv002
                                                ,g_xccv2_d_t.xccv006
                                                ,g_xccv2_d_t.xccv007
                                                ,g_xccv2_d_t.xccv008
                                                ,g_xccv2_d_t.xccv009
                                                ,g_xccv2_d_t.xccv010
                                                ,g_xccv2_d_t.xccv011
 
                  IF STATUS THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "OPEN axct303_bcl:xccv001=1" 
                     LET g_errparam.code   =  STATUS 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw='Y'
                  END IF   
               
               IF g_glaa019 = 'Y' THEN
                  OPEN axct303_bcl USING g_enterprise,g_xccv_m.xccvld,
                                                g_xccv_m.xccv003,
                                                g_xccv_m.xccv004,
                                                g_xccv_m.xccv005,
 
                                                '3'
                                                ,g_xccv2_d_t.xccv002
                                                ,g_xccv2_d_t.xccv006
                                                ,g_xccv2_d_t.xccv007
                                                ,g_xccv2_d_t.xccv008
                                                ,g_xccv2_d_t.xccv009
                                                ,g_xccv2_d_t.xccv010
                                                ,g_xccv2_d_t.xccv011
 
                  IF STATUS THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "OPEN axct303_bcl:xccv001=2" 
                     LET g_errparam.code   =  STATUS 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw='Y'
                  END IF   
               END IF
            END IF
            #end add-point  
            
        
         BEFORE INSERT
            
            INITIALIZE g_xccv2_d_t.* TO NULL
            INITIALIZE g_xccv2_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xccv2_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_xccv2_d[l_ac].xccv001 = "1"
      LET g_xccv2_d[l_ac].xccv101 = "0"
      LET g_xccv2_d[l_ac].xccv102 = "0"
      LET g_xccv2_d[l_ac].xccv102a = "0"
      LET g_xccv2_d[l_ac].xccv102b = "0"
      LET g_xccv2_d[l_ac].xccv102c = "0"
      LET g_xccv2_d[l_ac].xccv102d = "0"
      LET g_xccv2_d[l_ac].xccv102e = "0"
      LET g_xccv2_d[l_ac].xccv102f = "0"
      LET g_xccv2_d[l_ac].xccv102g = "0"
      LET g_xccv2_d[l_ac].xccv102h = "0"
 
            
            #add-point:modify段before備份

            #end add-point
            LET g_xccv2_d_t.* = g_xccv2_d[l_ac].*     #新輸入資料
            LET g_xccv2_d_o.* = g_xccv2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axct303_set_entry_b(l_cmd)
            #add-point:set_entry_b後

            #end add-point
            CALL axct303_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xccv2_d[li_reproduce_target].* = g_xccv2_d[li_reproduce].*
 
               LET g_xccv2_d[g_xccv2_d.getLength()].xccv001 = NULL
               LET g_xccv2_d[g_xccv2_d.getLength()].xccv002 = NULL
               LET g_xccv2_d[g_xccv2_d.getLength()].xccv006 = NULL
               LET g_xccv2_d[g_xccv2_d.getLength()].xccv007 = NULL
               LET g_xccv2_d[g_xccv2_d.getLength()].xccv008 = NULL
               LET g_xccv2_d[g_xccv2_d.getLength()].xccv009 = NULL
               LET g_xccv2_d[g_xccv2_d.getLength()].xccv010 = NULL
               LET g_xccv2_d[g_xccv2_d.getLength()].xccv011 = NULL
 
            END IF
            
            #add-point:modify段before insert

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
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM xccv_t 
             WHERE xccvent = g_enterprise AND xccvld = g_xccv_m.xccvld
               AND xccv003 = g_xccv_m.xccv003
               AND xccv004 = g_xccv_m.xccv004
               AND xccv005 = g_xccv_m.xccv005
 
               AND xccv001 = g_xccv2_d[l_ac].xccv001
               AND xccv002 = g_xccv2_d[l_ac].xccv002
               AND xccv006 = g_xccv2_d[l_ac].xccv006
               AND xccv007 = g_xccv2_d[l_ac].xccv007
               AND xccv008 = g_xccv2_d[l_ac].xccv008
               AND xccv009 = g_xccv2_d[l_ac].xccv009
               AND xccv010 = g_xccv2_d[l_ac].xccv010
               AND xccv011 = g_xccv2_d[l_ac].xccv011
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前
               IF cl_null(g_xccv2_d[l_ac].xccv002) THEN LET g_xccv2_d[l_ac].xccv002 = ' ' END IF
               IF cl_null(g_xccv2_d[l_ac].xccv101) THEN LET g_xccv2_d[l_ac].xccv101 = 0 END IF
               #end add-point
               INSERT INTO xccv_t
                           (xccvent,
                            xccvcomp,xccv004,xccv005,xccvld,xccv003,
                            xccv001,xccv002,xccv006,xccv007,xccv008,xccv009,xccv010,xccv011
                            ,xccv101,xccv102,xccv102a,xccv102b,xccv102c,xccv102d,xccv102e,xccv102f,xccv102g,xccv102h) 
                     VALUES(g_enterprise,
                            g_xccv_m.xccvcomp,g_xccv_m.xccv004,g_xccv_m.xccv005,g_xccv_m.xccvld,g_xccv_m.xccv003,
                            g_xccv2_d[l_ac].xccv001,g_xccv2_d[l_ac].xccv002,g_xccv2_d[l_ac].xccv006,g_xccv2_d[l_ac].xccv007, 
                                g_xccv2_d[l_ac].xccv008,g_xccv2_d[l_ac].xccv009,g_xccv2_d[l_ac].xccv010, 
                                g_xccv2_d[l_ac].xccv011
                            ,g_xccv2_d[l_ac].xccv101,g_xccv2_d[l_ac].xccv102,g_xccv2_d[l_ac].xccv102a,g_xccv2_d[l_ac].xccv102b, 
                                g_xccv2_d[l_ac].xccv102c,g_xccv2_d[l_ac].xccv102d,g_xccv2_d[l_ac].xccv102e, 
                                g_xccv2_d[l_ac].xccv102f,g_xccv2_d[l_ac].xccv102g,g_xccv2_d[l_ac].xccv102h) 

               #add-point:單身新增中
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_xccv2_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xccv_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #資料多語言用-增/改
               
               #add-point:input段-after_insert

               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cnt
            END IF
            
            #add-point:單身新增後

            #end add-point
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除前

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
               IF axct303_before_delete_2() THEN 
                  
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axct303_bcl
               LET l_count = g_xccv2_d.getLength()
            END IF 
            
            #add-point:單身刪除後

            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE 

               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_xccv2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv001
            #add-point:BEFORE FIELD xccv001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv001
            
            #add-point:AFTER FIELD xccv001
            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF  g_xccv_m.xccvld IS NOT NULL AND g_xccv_m.xccv003 IS NOT NULL AND g_xccv_m.xccv004 IS NOT NULL AND g_xccv_m.xccv005 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv001 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv002 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv006 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv007 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv008 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv009 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv010 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv011 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccv_m.xccvld != g_xccvld_t OR g_xccv_m.xccv003 != g_xccv003_t OR g_xccv_m.xccv004 != g_xccv004_t OR g_xccv_m.xccv005 != g_xccv005_t OR g_xccv2_d[g_detail_idx].xccv001 != g_xccv2_d_t.xccv001 OR g_xccv2_d[g_detail_idx].xccv002 != g_xccv2_d_t.xccv002 OR g_xccv2_d[g_detail_idx].xccv006 != g_xccv2_d_t.xccv006 OR g_xccv2_d[g_detail_idx].xccv007 != g_xccv2_d_t.xccv007 OR g_xccv2_d[g_detail_idx].xccv008 != g_xccv2_d_t.xccv008 OR g_xccv2_d[g_detail_idx].xccv009 != g_xccv2_d_t.xccv009 OR g_xccv2_d[g_detail_idx].xccv010 != g_xccv2_d_t.xccv010 OR g_xccv2_d[g_detail_idx].xccv011 != g_xccv2_d_t.xccv011)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccv_t WHERE "||"xccvent = '" ||g_enterprise|| "' AND "||"xccvld = '"||g_xccv_m.xccvld ||"' AND "|| "xccv003 = '"||g_xccv_m.xccv003 ||"' AND "|| "xccv004 = '"||g_xccv_m.xccv004 ||"' AND "|| "xccv005 = '"||g_xccv_m.xccv005 ||"' AND "|| "xccv001 = '"||g_xccv2_d[g_detail_idx].xccv001 ||"' AND "|| "xccv002 = '"||g_xccv2_d[g_detail_idx].xccv002 ||"' AND "|| "xccv006 = '"||g_xccv2_d[g_detail_idx].xccv006 ||"' AND "|| "xccv007 = '"||g_xccv2_d[g_detail_idx].xccv007 ||"' AND "|| "xccv008 = '"||g_xccv2_d[g_detail_idx].xccv008 ||"' AND "|| "xccv009 = '"||g_xccv2_d[g_detail_idx].xccv009 ||"' AND "|| "xccv010 = '"||g_xccv2_d[g_detail_idx].xccv010 ||"' AND "|| "xccv011 = '"||g_xccv2_d[g_detail_idx].xccv011 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv001
            #add-point:ON CHANGE xccv001

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv006
            #add-point:BEFORE FIELD xccv006

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv006
            
            #add-point:AFTER FIELD xccv006
            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF  g_xccv_m.xccvld IS NOT NULL AND g_xccv_m.xccv003 IS NOT NULL AND g_xccv_m.xccv004 IS NOT NULL AND g_xccv_m.xccv005 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv001 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv002 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv006 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv007 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv008 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv009 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv010 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv011 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccv_m.xccvld != g_xccvld_t OR g_xccv_m.xccv003 != g_xccv003_t OR g_xccv_m.xccv004 != g_xccv004_t OR g_xccv_m.xccv005 != g_xccv005_t OR g_xccv2_d[g_detail_idx].xccv001 != g_xccv2_d_t.xccv001 OR g_xccv2_d[g_detail_idx].xccv002 != g_xccv2_d_t.xccv002 OR g_xccv2_d[g_detail_idx].xccv006 != g_xccv2_d_t.xccv006 OR g_xccv2_d[g_detail_idx].xccv007 != g_xccv2_d_t.xccv007 OR g_xccv2_d[g_detail_idx].xccv008 != g_xccv2_d_t.xccv008 OR g_xccv2_d[g_detail_idx].xccv009 != g_xccv2_d_t.xccv009 OR g_xccv2_d[g_detail_idx].xccv010 != g_xccv2_d_t.xccv010 OR g_xccv2_d[g_detail_idx].xccv011 != g_xccv2_d_t.xccv011)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccv_t WHERE "||"xccvent = '" ||g_enterprise|| "' AND "||"xccvld = '"||g_xccv_m.xccvld ||"' AND "|| "xccv003 = '"||g_xccv_m.xccv003 ||"' AND "|| "xccv004 = '"||g_xccv_m.xccv004 ||"' AND "|| "xccv005 = '"||g_xccv_m.xccv005 ||"' AND "|| "xccv001 = '"||g_xccv2_d[g_detail_idx].xccv001 ||"' AND "|| "xccv002 = '"||g_xccv2_d[g_detail_idx].xccv002 ||"' AND "|| "xccv006 = '"||g_xccv2_d[g_detail_idx].xccv006 ||"' AND "|| "xccv007 = '"||g_xccv2_d[g_detail_idx].xccv007 ||"' AND "|| "xccv008 = '"||g_xccv2_d[g_detail_idx].xccv008 ||"' AND "|| "xccv009 = '"||g_xccv2_d[g_detail_idx].xccv009 ||"' AND "|| "xccv010 = '"||g_xccv2_d[g_detail_idx].xccv010 ||"' AND "|| "xccv011 = '"||g_xccv2_d[g_detail_idx].xccv011 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv006
            #add-point:ON CHANGE xccv006

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv007
            
            #add-point:AFTER FIELD xccv007
            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF  g_xccv_m.xccvld IS NOT NULL AND g_xccv_m.xccv003 IS NOT NULL AND g_xccv_m.xccv004 IS NOT NULL AND g_xccv_m.xccv005 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv001 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv002 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv006 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv007 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv008 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv009 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv010 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv011 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccv_m.xccvld != g_xccvld_t OR g_xccv_m.xccv003 != g_xccv003_t OR g_xccv_m.xccv004 != g_xccv004_t OR g_xccv_m.xccv005 != g_xccv005_t OR g_xccv2_d[g_detail_idx].xccv001 != g_xccv2_d_t.xccv001 OR g_xccv2_d[g_detail_idx].xccv002 != g_xccv2_d_t.xccv002 OR g_xccv2_d[g_detail_idx].xccv006 != g_xccv2_d_t.xccv006 OR g_xccv2_d[g_detail_idx].xccv007 != g_xccv2_d_t.xccv007 OR g_xccv2_d[g_detail_idx].xccv008 != g_xccv2_d_t.xccv008 OR g_xccv2_d[g_detail_idx].xccv009 != g_xccv2_d_t.xccv009 OR g_xccv2_d[g_detail_idx].xccv010 != g_xccv2_d_t.xccv010 OR g_xccv2_d[g_detail_idx].xccv011 != g_xccv2_d_t.xccv011)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccv_t WHERE "||"xccvent = '" ||g_enterprise|| "' AND "||"xccvld = '"||g_xccv_m.xccvld ||"' AND "|| "xccv003 = '"||g_xccv_m.xccv003 ||"' AND "|| "xccv004 = '"||g_xccv_m.xccv004 ||"' AND "|| "xccv005 = '"||g_xccv_m.xccv005 ||"' AND "|| "xccv001 = '"||g_xccv2_d[g_detail_idx].xccv001 ||"' AND "|| "xccv002 = '"||g_xccv2_d[g_detail_idx].xccv002 ||"' AND "|| "xccv006 = '"||g_xccv2_d[g_detail_idx].xccv006 ||"' AND "|| "xccv007 = '"||g_xccv2_d[g_detail_idx].xccv007 ||"' AND "|| "xccv008 = '"||g_xccv2_d[g_detail_idx].xccv008 ||"' AND "|| "xccv009 = '"||g_xccv2_d[g_detail_idx].xccv009 ||"' AND "|| "xccv010 = '"||g_xccv2_d[g_detail_idx].xccv010 ||"' AND "|| "xccv011 = '"||g_xccv2_d[g_detail_idx].xccv011 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv007
            #add-point:BEFORE FIELD xccv007

            #END add-point
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv007
            #add-point:ON CHANGE xccv007

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv008
            #add-point:BEFORE FIELD xccv008

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv008
            
            #add-point:AFTER FIELD xccv008
            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF  g_xccv_m.xccvld IS NOT NULL AND g_xccv_m.xccv003 IS NOT NULL AND g_xccv_m.xccv004 IS NOT NULL AND g_xccv_m.xccv005 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv001 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv002 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv006 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv007 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv008 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv009 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv010 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv011 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccv_m.xccvld != g_xccvld_t OR g_xccv_m.xccv003 != g_xccv003_t OR g_xccv_m.xccv004 != g_xccv004_t OR g_xccv_m.xccv005 != g_xccv005_t OR g_xccv2_d[g_detail_idx].xccv001 != g_xccv2_d_t.xccv001 OR g_xccv2_d[g_detail_idx].xccv002 != g_xccv2_d_t.xccv002 OR g_xccv2_d[g_detail_idx].xccv006 != g_xccv2_d_t.xccv006 OR g_xccv2_d[g_detail_idx].xccv007 != g_xccv2_d_t.xccv007 OR g_xccv2_d[g_detail_idx].xccv008 != g_xccv2_d_t.xccv008 OR g_xccv2_d[g_detail_idx].xccv009 != g_xccv2_d_t.xccv009 OR g_xccv2_d[g_detail_idx].xccv010 != g_xccv2_d_t.xccv010 OR g_xccv2_d[g_detail_idx].xccv011 != g_xccv2_d_t.xccv011)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccv_t WHERE "||"xccvent = '" ||g_enterprise|| "' AND "||"xccvld = '"||g_xccv_m.xccvld ||"' AND "|| "xccv003 = '"||g_xccv_m.xccv003 ||"' AND "|| "xccv004 = '"||g_xccv_m.xccv004 ||"' AND "|| "xccv005 = '"||g_xccv_m.xccv005 ||"' AND "|| "xccv001 = '"||g_xccv2_d[g_detail_idx].xccv001 ||"' AND "|| "xccv002 = '"||g_xccv2_d[g_detail_idx].xccv002 ||"' AND "|| "xccv006 = '"||g_xccv2_d[g_detail_idx].xccv006 ||"' AND "|| "xccv007 = '"||g_xccv2_d[g_detail_idx].xccv007 ||"' AND "|| "xccv008 = '"||g_xccv2_d[g_detail_idx].xccv008 ||"' AND "|| "xccv009 = '"||g_xccv2_d[g_detail_idx].xccv009 ||"' AND "|| "xccv010 = '"||g_xccv2_d[g_detail_idx].xccv010 ||"' AND "|| "xccv011 = '"||g_xccv2_d[g_detail_idx].xccv011 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv008
            #add-point:ON CHANGE xccv008

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv009
            
            #add-point:AFTER FIELD xccv009
            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF  g_xccv_m.xccvld IS NOT NULL AND g_xccv_m.xccv003 IS NOT NULL AND g_xccv_m.xccv004 IS NOT NULL AND g_xccv_m.xccv005 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv001 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv002 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv006 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv007 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv008 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv009 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv010 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv011 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccv_m.xccvld != g_xccvld_t OR g_xccv_m.xccv003 != g_xccv003_t OR g_xccv_m.xccv004 != g_xccv004_t OR g_xccv_m.xccv005 != g_xccv005_t OR g_xccv2_d[g_detail_idx].xccv001 != g_xccv2_d_t.xccv001 OR g_xccv2_d[g_detail_idx].xccv002 != g_xccv2_d_t.xccv002 OR g_xccv2_d[g_detail_idx].xccv006 != g_xccv2_d_t.xccv006 OR g_xccv2_d[g_detail_idx].xccv007 != g_xccv2_d_t.xccv007 OR g_xccv2_d[g_detail_idx].xccv008 != g_xccv2_d_t.xccv008 OR g_xccv2_d[g_detail_idx].xccv009 != g_xccv2_d_t.xccv009 OR g_xccv2_d[g_detail_idx].xccv010 != g_xccv2_d_t.xccv010 OR g_xccv2_d[g_detail_idx].xccv011 != g_xccv2_d_t.xccv011)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccv_t WHERE "||"xccvent = '" ||g_enterprise|| "' AND "||"xccvld = '"||g_xccv_m.xccvld ||"' AND "|| "xccv003 = '"||g_xccv_m.xccv003 ||"' AND "|| "xccv004 = '"||g_xccv_m.xccv004 ||"' AND "|| "xccv005 = '"||g_xccv_m.xccv005 ||"' AND "|| "xccv001 = '"||g_xccv2_d[g_detail_idx].xccv001 ||"' AND "|| "xccv002 = '"||g_xccv2_d[g_detail_idx].xccv002 ||"' AND "|| "xccv006 = '"||g_xccv2_d[g_detail_idx].xccv006 ||"' AND "|| "xccv007 = '"||g_xccv2_d[g_detail_idx].xccv007 ||"' AND "|| "xccv008 = '"||g_xccv2_d[g_detail_idx].xccv008 ||"' AND "|| "xccv009 = '"||g_xccv2_d[g_detail_idx].xccv009 ||"' AND "|| "xccv010 = '"||g_xccv2_d[g_detail_idx].xccv010 ||"' AND "|| "xccv011 = '"||g_xccv2_d[g_detail_idx].xccv011 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv009
            #add-point:BEFORE FIELD xccv009

            #END add-point
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv009
            #add-point:ON CHANGE xccv009

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv010
            #add-point:BEFORE FIELD xccv010

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv010
            
            #add-point:AFTER FIELD xccv010
            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF  g_xccv_m.xccvld IS NOT NULL AND g_xccv_m.xccv003 IS NOT NULL AND g_xccv_m.xccv004 IS NOT NULL AND g_xccv_m.xccv005 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv001 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv002 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv006 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv007 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv008 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv009 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv010 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv011 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccv_m.xccvld != g_xccvld_t OR g_xccv_m.xccv003 != g_xccv003_t OR g_xccv_m.xccv004 != g_xccv004_t OR g_xccv_m.xccv005 != g_xccv005_t OR g_xccv2_d[g_detail_idx].xccv001 != g_xccv2_d_t.xccv001 OR g_xccv2_d[g_detail_idx].xccv002 != g_xccv2_d_t.xccv002 OR g_xccv2_d[g_detail_idx].xccv006 != g_xccv2_d_t.xccv006 OR g_xccv2_d[g_detail_idx].xccv007 != g_xccv2_d_t.xccv007 OR g_xccv2_d[g_detail_idx].xccv008 != g_xccv2_d_t.xccv008 OR g_xccv2_d[g_detail_idx].xccv009 != g_xccv2_d_t.xccv009 OR g_xccv2_d[g_detail_idx].xccv010 != g_xccv2_d_t.xccv010 OR g_xccv2_d[g_detail_idx].xccv011 != g_xccv2_d_t.xccv011)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccv_t WHERE "||"xccvent = '" ||g_enterprise|| "' AND "||"xccvld = '"||g_xccv_m.xccvld ||"' AND "|| "xccv003 = '"||g_xccv_m.xccv003 ||"' AND "|| "xccv004 = '"||g_xccv_m.xccv004 ||"' AND "|| "xccv005 = '"||g_xccv_m.xccv005 ||"' AND "|| "xccv001 = '"||g_xccv2_d[g_detail_idx].xccv001 ||"' AND "|| "xccv002 = '"||g_xccv2_d[g_detail_idx].xccv002 ||"' AND "|| "xccv006 = '"||g_xccv2_d[g_detail_idx].xccv006 ||"' AND "|| "xccv007 = '"||g_xccv2_d[g_detail_idx].xccv007 ||"' AND "|| "xccv008 = '"||g_xccv2_d[g_detail_idx].xccv008 ||"' AND "|| "xccv009 = '"||g_xccv2_d[g_detail_idx].xccv009 ||"' AND "|| "xccv010 = '"||g_xccv2_d[g_detail_idx].xccv010 ||"' AND "|| "xccv011 = '"||g_xccv2_d[g_detail_idx].xccv011 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv010
            #add-point:ON CHANGE xccv010

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv011
            #add-point:BEFORE FIELD xccv011

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv011
            
            #add-point:AFTER FIELD xccv011
            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF  g_xccv_m.xccvld IS NOT NULL AND g_xccv_m.xccv003 IS NOT NULL AND g_xccv_m.xccv004 IS NOT NULL AND g_xccv_m.xccv005 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv001 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv002 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv006 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv007 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv008 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv009 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv010 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv011 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccv_m.xccvld != g_xccvld_t OR g_xccv_m.xccv003 != g_xccv003_t OR g_xccv_m.xccv004 != g_xccv004_t OR g_xccv_m.xccv005 != g_xccv005_t OR g_xccv2_d[g_detail_idx].xccv001 != g_xccv2_d_t.xccv001 OR g_xccv2_d[g_detail_idx].xccv002 != g_xccv2_d_t.xccv002 OR g_xccv2_d[g_detail_idx].xccv006 != g_xccv2_d_t.xccv006 OR g_xccv2_d[g_detail_idx].xccv007 != g_xccv2_d_t.xccv007 OR g_xccv2_d[g_detail_idx].xccv008 != g_xccv2_d_t.xccv008 OR g_xccv2_d[g_detail_idx].xccv009 != g_xccv2_d_t.xccv009 OR g_xccv2_d[g_detail_idx].xccv010 != g_xccv2_d_t.xccv010 OR g_xccv2_d[g_detail_idx].xccv011 != g_xccv2_d_t.xccv011)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccv_t WHERE "||"xccvent = '" ||g_enterprise|| "' AND "||"xccvld = '"||g_xccv_m.xccvld ||"' AND "|| "xccv003 = '"||g_xccv_m.xccv003 ||"' AND "|| "xccv004 = '"||g_xccv_m.xccv004 ||"' AND "|| "xccv005 = '"||g_xccv_m.xccv005 ||"' AND "|| "xccv001 = '"||g_xccv2_d[g_detail_idx].xccv001 ||"' AND "|| "xccv002 = '"||g_xccv2_d[g_detail_idx].xccv002 ||"' AND "|| "xccv006 = '"||g_xccv2_d[g_detail_idx].xccv006 ||"' AND "|| "xccv007 = '"||g_xccv2_d[g_detail_idx].xccv007 ||"' AND "|| "xccv008 = '"||g_xccv2_d[g_detail_idx].xccv008 ||"' AND "|| "xccv009 = '"||g_xccv2_d[g_detail_idx].xccv009 ||"' AND "|| "xccv010 = '"||g_xccv2_d[g_detail_idx].xccv010 ||"' AND "|| "xccv011 = '"||g_xccv2_d[g_detail_idx].xccv011 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv011
            #add-point:ON CHANGE xccv011

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv002
            
            #add-point:AFTER FIELD xccv002
            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF  g_xccv_m.xccvld IS NOT NULL AND g_xccv_m.xccv003 IS NOT NULL AND g_xccv_m.xccv004 IS NOT NULL AND g_xccv_m.xccv005 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv001 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv002 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv006 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv007 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv008 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv009 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv010 IS NOT NULL AND g_xccv2_d[g_detail_idx].xccv011 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccv_m.xccvld != g_xccvld_t OR g_xccv_m.xccv003 != g_xccv003_t OR g_xccv_m.xccv004 != g_xccv004_t OR g_xccv_m.xccv005 != g_xccv005_t OR g_xccv2_d[g_detail_idx].xccv001 != g_xccv2_d_t.xccv001 OR g_xccv2_d[g_detail_idx].xccv002 != g_xccv2_d_t.xccv002 OR g_xccv2_d[g_detail_idx].xccv006 != g_xccv2_d_t.xccv006 OR g_xccv2_d[g_detail_idx].xccv007 != g_xccv2_d_t.xccv007 OR g_xccv2_d[g_detail_idx].xccv008 != g_xccv2_d_t.xccv008 OR g_xccv2_d[g_detail_idx].xccv009 != g_xccv2_d_t.xccv009 OR g_xccv2_d[g_detail_idx].xccv010 != g_xccv2_d_t.xccv010 OR g_xccv2_d[g_detail_idx].xccv011 != g_xccv2_d_t.xccv011)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccv_t WHERE "||"xccvent = '" ||g_enterprise|| "' AND "||"xccvld = '"||g_xccv_m.xccvld ||"' AND "|| "xccv003 = '"||g_xccv_m.xccv003 ||"' AND "|| "xccv004 = '"||g_xccv_m.xccv004 ||"' AND "|| "xccv005 = '"||g_xccv_m.xccv005 ||"' AND "|| "xccv001 = '"||g_xccv2_d[g_detail_idx].xccv001 ||"' AND "|| "xccv002 = '"||g_xccv2_d[g_detail_idx].xccv002 ||"' AND "|| "xccv006 = '"||g_xccv2_d[g_detail_idx].xccv006 ||"' AND "|| "xccv007 = '"||g_xccv2_d[g_detail_idx].xccv007 ||"' AND "|| "xccv008 = '"||g_xccv2_d[g_detail_idx].xccv008 ||"' AND "|| "xccv009 = '"||g_xccv2_d[g_detail_idx].xccv009 ||"' AND "|| "xccv010 = '"||g_xccv2_d[g_detail_idx].xccv010 ||"' AND "|| "xccv011 = '"||g_xccv2_d[g_detail_idx].xccv011 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv002
            #add-point:BEFORE FIELD xccv002

            #END add-point
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv002
            #add-point:ON CHANGE xccv002

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv101
            #add-point:BEFORE FIELD xccv101

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv101
            
            #add-point:AFTER FIELD xccv101

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv101
            #add-point:ON CHANGE xccv101

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv102_2
            #add-point:BEFORE FIELD xccv102

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv102_2
            
            #add-point:AFTER FIELD xccv102

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv102_2
            #add-point:ON CHANGE xccv102

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv102a_2
            #add-point:BEFORE FIELD xccv102a_2

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv102a_2
            
            #add-point:AFTER FIELD xccv102a_2
            CALL axct303_xccv102_sum_2()
            LET g_xccv2_d[l_ac].xccv102a = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv2_d[l_ac].xccv102a,2)
            LET g_xccv2_d[l_ac].xccv102 = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv2_d[l_ac].xccv102,2)
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv102a_2
            #add-point:ON CHANGE xccv102a_2

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv102b_2
            #add-point:BEFORE FIELD xccv102b_2

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv102b_2
            
            #add-point:AFTER FIELD xccv102b_2
            CALL axct303_xccv102_sum_2()
            LET g_xccv2_d[l_ac].xccv102b = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv2_d[l_ac].xccv102b,2)
            LET g_xccv2_d[l_ac].xccv102 = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv2_d[l_ac].xccv102,2)
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv102b_2
            #add-point:ON CHANGE xccv102b_2

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv102c_2
            #add-point:BEFORE FIELD xccv102c_2

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv102c_2
            
            #add-point:AFTER FIELD xccv102c_2
            CALL axct303_xccv102_sum_2()
            LET g_xccv2_d[l_ac].xccv102c = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv2_d[l_ac].xccv102c,2)
            LET g_xccv2_d[l_ac].xccv102 = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv2_d[l_ac].xccv102,2)
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv102c_2
            #add-point:ON CHANGE xccv102c_2

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv102d_2
            #add-point:BEFORE FIELD xccv102d_2

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv102d_2
            
            #add-point:AFTER FIELD xccv102d_2
            CALL axct303_xccv102_sum_2()
            LET g_xccv2_d[l_ac].xccv102d = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv2_d[l_ac].xccv102d,2)
            LET g_xccv2_d[l_ac].xccv102 = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv2_d[l_ac].xccv102,2)
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv102d_2
            #add-point:ON CHANGE xccv102d_2

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv102e_2
            #add-point:BEFORE FIELD xccv102e_2

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv102e_2
            
            #add-point:AFTER FIELD xccv102e_2
            CALL axct303_xccv102_sum_2()
            LET g_xccv2_d[l_ac].xccv102e = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv2_d[l_ac].xccv102e,2)
            LET g_xccv2_d[l_ac].xccv102 = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv2_d[l_ac].xccv102,2)
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv102e_2
            #add-point:ON CHANGE xccv102e_2

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv102f_2
            #add-point:BEFORE FIELD xccv102f_2

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv102f_2
            
            #add-point:AFTER FIELD xccv102f_2
            CALL axct303_xccv102_sum_2()
            LET g_xccv2_d[l_ac].xccv102f = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv2_d[l_ac].xccv102f,2)
            LET g_xccv2_d[l_ac].xccv102 = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv2_d[l_ac].xccv102,2)
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv102f_2
            #add-point:ON CHANGE xccv102f_2

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv102g_2
            #add-point:BEFORE FIELD xccv102g_2

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv102g_2
            
            #add-point:AFTER FIELD xccv102g_2
            CALL axct303_xccv102_sum_2()
            LET g_xccv2_d[l_ac].xccv102g = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv2_d[l_ac].xccv102g,2)
            LET g_xccv2_d[l_ac].xccv102 = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv2_d[l_ac].xccv102,2)
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv102g_2
            #add-point:ON CHANGE xccv102g_2

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv102h_2_2
            #add-point:BEFORE FIELD xccv102h_2_2

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv102h_2_2
            
            #add-point:AFTER FIELD xccv102h_2_2
            CALL axct303_xccv102_sum_2()
            LET g_xccv2_d[l_ac].xccv102h = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv2_d[l_ac].xccv102h,2)
            LET g_xccv2_d[l_ac].xccv102 = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv2_d[l_ac].xccv102,2)
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv102h_2
            #add-point:ON CHANGE xccv102h_2

            #END add-point
 
 
                  #Ctrlp:input.c.page1.xccv001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv001
            #add-point:ON ACTION controlp INFIELD xccv001

            #END add-point
 
         #Ctrlp:input.c.page1.xccv006
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv006
            #add-point:ON ACTION controlp INFIELD xccv006
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccv2_d[l_ac].xccv006             #給予default值
            LET g_qryparam.default2 = "" #g_xccv2_d[l_ac].sfbaseq1 #项序
            LET g_qryparam.default3 = "" #g_xccv2_d[l_ac].sfaadocno #单号
            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL q_sfbadocno()                                #呼叫開窗

            LET g_xccv2_d[l_ac].xccv006 = g_qryparam.return1              
            #LET g_xccv2_d[l_ac].sfbaseq1 = g_qryparam.return2 
            #LET g_xccv2_d[l_ac].sfaadocno = g_qryparam.return3 
            DISPLAY g_xccv2_d[l_ac].xccv006 TO xccv006              #
            #DISPLAY g_xccv2_d[l_ac].sfbaseq1 TO sfbaseq1 #项序
            #DISPLAY g_xccv2_d[l_ac].sfaadocno TO sfaadocno #单号
            NEXT FIELD xccv006                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xccv007
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv007
            #add-point:ON ACTION controlp INFIELD xccv007
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccv2_d[l_ac].xccv007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL q_sfba003()                                #呼叫開窗

            LET g_xccv2_d[l_ac].xccv007 = g_qryparam.return1              

            DISPLAY g_xccv2_d[l_ac].xccv007 TO xccv007              #

            NEXT FIELD xccv007                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xccv008
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv008
            #add-point:ON ACTION controlp INFIELD xccv008
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccv2_d[l_ac].xccv008             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL q_sfba004()                                #呼叫開窗

            LET g_xccv2_d[l_ac].xccv008 = g_qryparam.return1              

            DISPLAY g_xccv2_d[l_ac].xccv008 TO xccv008              #

            NEXT FIELD xccv008                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xccv009
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv009
            #add-point:ON ACTION controlp INFIELD xccv009
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccv2_d[l_ac].xccv009             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_site #s

            
            CALL q_imag001()                                #呼叫開窗

            LET g_xccv2_d[l_ac].xccv009 = g_qryparam.return1              

            DISPLAY g_xccv2_d[l_ac].xccv009 TO xccv009              #

            NEXT FIELD xccv009                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xccv010
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv010
            #add-point:ON ACTION controlp INFIELD xccv010
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccv2_d[l_ac].xccv010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL q_bmaa002_1()                                #呼叫開窗

            LET g_xccv2_d[l_ac].xccv010 = g_qryparam.return1              

            DISPLAY g_xccv2_d[l_ac].xccv010 TO xccv010              #

            NEXT FIELD xccv010                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xccv011
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv011
            #add-point:ON ACTION controlp INFIELD xccv011
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccv2_d[l_ac].xccv011             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL q_inaj010()                                #呼叫開窗

            LET g_xccv2_d[l_ac].xccv011 = g_qryparam.return1              

            DISPLAY g_xccv2_d[l_ac].xccv011 TO xccv011              #

            NEXT FIELD xccv011                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xccv002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv002
            #add-point:ON ACTION controlp INFIELD xccv002
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccv2_d[l_ac].xccv002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL q_xcbf001()                                #呼叫開窗

            LET g_xccv2_d[l_ac].xccv002 = g_qryparam.return1              

            DISPLAY g_xccv2_d[l_ac].xccv002 TO xccv002              #

            NEXT FIELD xccv002                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xccv101
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv101
            #add-point:ON ACTION controlp INFIELD xccv101

            #END add-point
 
         #Ctrlp:input.c.page1.xccv102
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv102
            #add-point:ON ACTION controlp INFIELD xccv102

            #END add-point
 
         #Ctrlp:input.c.page1.xccv102a
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv102a_2
            #add-point:ON ACTION controlp INFIELD xccv102a_2

            #END add-point
 
         #Ctrlp:input.c.page1.xccv102b
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv102b_2
            #add-point:ON ACTION controlp INFIELD xccv102b_2

            #END add-point
 
         #Ctrlp:input.c.page1.xccv102c
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv102c_2
            #add-point:ON ACTION controlp INFIELD xccv102c_2

            #END add-point
 
         #Ctrlp:input.c.page1.xccv102d
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv102d_2
            #add-point:ON ACTION controlp INFIELD xccv102d_2

            #END add-point
 
         #Ctrlp:input.c.page1.xccv102e
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv102e_2
            #add-point:ON ACTION controlp INFIELD xccv102e_2

            #END add-point
 
         #Ctrlp:input.c.page1.xccv102f
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv102f_2
            #add-point:ON ACTION controlp INFIELD xccv102f_2

            #END add-point
 
         #Ctrlp:input.c.page1.xccv102g
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv102g_2
            #add-point:ON ACTION controlp INFIELD xccv102g_2

            #END add-point
 
         #Ctrlp:input.c.page1.xccv102h
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv102h_2_2
            #add-point:ON ACTION controlp INFIELD xccv102h_2_2

            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_xccv2_d[l_ac].* = g_xccv2_d_t.*
               CLOSE axct303_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xccv2_d[l_ac].xccv001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xccv2_d[l_ac].* = g_xccv2_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
            
               #add-point:單身修改前
               
               #end add-point
         
               UPDATE xccv_t SET (xccvld,xccv003,xccv004,xccv005,xccv001,xccv006,xccv007,xccv008,xccv009, 
                   xccv010,xccv011,xccv002,xccv101,xccv102,xccv102a,xccv102b,xccv102c,xccv102d,xccv102e, 
                   xccv102f,xccv102g,xccv102h) = (g_xccv_m.xccvld,g_xccv_m.xccv003,g_xccv_m.xccv004, 
                   g_xccv_m.xccv005,g_xccv2_d[l_ac].xccv001,g_xccv2_d[l_ac].xccv006,g_xccv2_d[l_ac].xccv007, 
                   g_xccv2_d[l_ac].xccv008,g_xccv2_d[l_ac].xccv009,g_xccv2_d[l_ac].xccv010,g_xccv2_d[l_ac].xccv011, 
                   g_xccv2_d[l_ac].xccv002,g_xccv2_d[l_ac].xccv101,g_xccv2_d[l_ac].xccv102,g_xccv2_d[l_ac].xccv102a, 
                   g_xccv2_d[l_ac].xccv102b,g_xccv2_d[l_ac].xccv102c,g_xccv2_d[l_ac].xccv102d,g_xccv2_d[l_ac].xccv102e, 
                   g_xccv2_d[l_ac].xccv102f,g_xccv2_d[l_ac].xccv102g,g_xccv2_d[l_ac].xccv102h)
                WHERE xccvent = g_enterprise AND xccvld = g_xccv_m.xccvld 
                 AND xccv003 = g_xccv_m.xccv003 
                 AND xccv004 = g_xccv_m.xccv004 
                 AND xccv005 = g_xccv_m.xccv005 
 
                 AND xccv001 = g_xccv2_d_t.xccv001 #項次   
                 AND xccv002 = g_xccv2_d_t.xccv002  
                 AND xccv006 = g_xccv2_d_t.xccv006  
                 AND xccv007 = g_xccv2_d_t.xccv007  
                 AND xccv008 = g_xccv2_d_t.xccv008  
                 AND xccv009 = g_xccv2_d_t.xccv009  
                 AND xccv010 = g_xccv2_d_t.xccv010  
                 AND xccv011 = g_xccv2_d_t.xccv011  
 
                 
               #add-point:單身修改中
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xccv_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xccv_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xccv_m.xccvld
               LET gs_keys_bak[1] = g_xccvld_t
               LET gs_keys[2] = g_xccv_m.xccv003
               LET gs_keys_bak[2] = g_xccv003_t
               LET gs_keys[3] = g_xccv_m.xccv004
               LET gs_keys_bak[3] = g_xccv004_t
               LET gs_keys[4] = g_xccv_m.xccv005
               LET gs_keys_bak[4] = g_xccv005_t
               LET gs_keys[5] = g_xccv2_d[g_detail_idx].xccv001
               LET gs_keys_bak[5] = g_xccv2_d_t.xccv001
               LET gs_keys[6] = g_xccv2_d[g_detail_idx].xccv002
               LET gs_keys_bak[6] = g_xccv2_d_t.xccv002
               LET gs_keys[7] = g_xccv2_d[g_detail_idx].xccv006
               LET gs_keys_bak[7] = g_xccv2_d_t.xccv006
               LET gs_keys[8] = g_xccv2_d[g_detail_idx].xccv007
               LET gs_keys_bak[8] = g_xccv2_d_t.xccv007
               LET gs_keys[9] = g_xccv2_d[g_detail_idx].xccv008
               LET gs_keys_bak[9] = g_xccv2_d_t.xccv008
               LET gs_keys[10] = g_xccv2_d[g_detail_idx].xccv009
               LET gs_keys_bak[10] = g_xccv2_d_t.xccv009
               LET gs_keys[11] = g_xccv2_d[g_detail_idx].xccv010
               LET gs_keys_bak[11] = g_xccv2_d_t.xccv010
               LET gs_keys[12] = g_xccv2_d[g_detail_idx].xccv011
               LET gs_keys_bak[12] = g_xccv2_d_t.xccv011
               CALL axct303_update_b('xccv_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     LET g_log1 = util.JSON.stringify(g_xccv_m),util.JSON.stringify(g_xccv2_d_t)
                     LET g_log2 = util.JSON.stringify(g_xccv_m),util.JSON.stringify(g_xccv2_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #若Key欄位有變動
               LET ls_keys[01] = g_xccv_m.xccvld
               LET ls_keys[ls_keys.getLength()+1] = g_xccv_m.xccv003
               LET ls_keys[ls_keys.getLength()+1] = g_xccv_m.xccv004
               LET ls_keys[ls_keys.getLength()+1] = g_xccv_m.xccv005
 
               LET ls_keys[ls_keys.getLength()+1] = g_xccv2_d_t.xccv001
               LET ls_keys[ls_keys.getLength()+1] = g_xccv2_d_t.xccv002
               LET ls_keys[ls_keys.getLength()+1] = g_xccv2_d_t.xccv006
               LET ls_keys[ls_keys.getLength()+1] = g_xccv2_d_t.xccv007
               LET ls_keys[ls_keys.getLength()+1] = g_xccv2_d_t.xccv008
               LET ls_keys[ls_keys.getLength()+1] = g_xccv2_d_t.xccv009
               LET ls_keys[ls_keys.getLength()+1] = g_xccv2_d_t.xccv010
               LET ls_keys[ls_keys.getLength()+1] = g_xccv2_d_t.xccv011
 
               CALL axct303_key_update_b(ls_keys)
               
               #add-point:單身修改後
               CALL s_transaction_end('Y','0') 
               #end add-point
            END IF
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xccv2_d[l_ac].* = g_xccv2_d_t.*
               END IF
               CLOSE axct303_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
 
            CLOSE axct303_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xccv2_d.getLength() = 0 THEN
               NEXT FIELD xccv001
            END IF
            #add-point:input段after input 

            #end add-point    
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_xccv2_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_xccv2_d.getLength()+1
            
      END INPUT
      
      INPUT ARRAY g_xccv3_d FROM s_detail3.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = 0,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = 0)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xccv3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axct303_b_fill_3() #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            #add-point:資料輸入前
            LET g_current_page = 3
            #end add-point
         
         BEFORE ROW
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct303_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axct303_cl USING g_enterprise,g_xccv_m.xccvld,g_xccv_m.xccv003,g_xccv_m.xccv004,g_xccv_m.xccv005                          
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axct303_cl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLOSE axct303_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            
            IF g_rec_b >= l_ac 
               AND g_xccv3_d[l_ac].xccv001 IS NOT NULL
               AND g_xccv3_d[l_ac].xccv002 IS NOT NULL
               AND g_xccv3_d[l_ac].xccv006 IS NOT NULL
               AND g_xccv3_d[l_ac].xccv007 IS NOT NULL
               AND g_xccv3_d[l_ac].xccv008 IS NOT NULL
               AND g_xccv3_d[l_ac].xccv009 IS NOT NULL
               AND g_xccv3_d[l_ac].xccv010 IS NOT NULL
               AND g_xccv3_d[l_ac].xccv011 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xccv3_d_t.* = g_xccv3_d[l_ac].*  #BACKUP
               LET g_xccv3_d_o.* = g_xccv3_d[l_ac].*  #BACKUP
               CALL axct303_set_entry_b(l_cmd)
               #add-point:set_entry_b後

               #end add-point
               CALL axct303_set_no_entry_b(l_cmd)
               OPEN axct303_bcl USING g_enterprise,g_xccv_m.xccvld,
                                                g_xccv_m.xccv003,
                                                g_xccv_m.xccv004,
                                                g_xccv_m.xccv005,
 
                                                g_xccv3_d_t.xccv001
                                                ,g_xccv3_d_t.xccv002
                                                ,g_xccv3_d_t.xccv006
                                                ,g_xccv3_d_t.xccv007
                                                ,g_xccv3_d_t.xccv008
                                                ,g_xccv3_d_t.xccv009
                                                ,g_xccv3_d_t.xccv010
                                                ,g_xccv3_d_t.xccv011
 
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axct303_bcl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axct303_bcl INTO g_xccv3_d[l_ac].xccv001,g_xccv3_d[l_ac].xccv006,g_xccv3_d[l_ac].xccv007, 
                      g_xccv3_d[l_ac].xccv008,g_xccv3_d[l_ac].xccv009,g_xccv3_d[l_ac].xccv010,g_xccv3_d[l_ac].xccv011, 
                      g_xccv3_d[l_ac].xccv002,g_xccv3_d[l_ac].xccv101,g_xccv3_d[l_ac].xccv102,g_xccv3_d[l_ac].xccv102a, 
                      g_xccv3_d[l_ac].xccv102b,g_xccv3_d[l_ac].xccv102c,g_xccv3_d[l_ac].xccv102d,g_xccv3_d[l_ac].xccv102e, 
                      g_xccv3_d[l_ac].xccv102f,g_xccv3_d[l_ac].xccv102g,g_xccv3_d[l_ac].xccv102h
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xccv3_d_t.xccv001 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  CALL axct303_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            IF l_cmd='u' THEN
               IF g_glaa015 = 'Y' THEN
                  OPEN axct303_bcl USING g_enterprise,g_xccv_m.xccvld,
                                                g_xccv_m.xccv003,
                                                g_xccv_m.xccv004,
                                                g_xccv_m.xccv005,
 
                                                '2'
                                                ,g_xccv3_d_t.xccv002
                                                ,g_xccv3_d_t.xccv006
                                                ,g_xccv3_d_t.xccv007
                                                ,g_xccv3_d_t.xccv008
                                                ,g_xccv3_d_t.xccv009
                                                ,g_xccv3_d_t.xccv010
                                                ,g_xccv3_d_t.xccv011
 
                  IF STATUS THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "OPEN axct303_bcl:xccv001=2" 
                     LET g_errparam.code   =  STATUS 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw='Y'
                  END IF   
               END IF
               
                  OPEN axct303_bcl USING g_enterprise,g_xccv_m.xccvld,
                                                g_xccv_m.xccv003,
                                                g_xccv_m.xccv004,
                                                g_xccv_m.xccv005,
 
                                                '1'
                                                ,g_xccv3_d_t.xccv002
                                                ,g_xccv3_d_t.xccv006
                                                ,g_xccv3_d_t.xccv007
                                                ,g_xccv3_d_t.xccv008
                                                ,g_xccv3_d_t.xccv009
                                                ,g_xccv3_d_t.xccv010
                                                ,g_xccv3_d_t.xccv011
 
                  IF STATUS THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "OPEN axct303_bcl:xccv001=1" 
                     LET g_errparam.code   =  STATUS 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw='Y'
                  END IF   
               
            END  IF
            #end add-point  
            
        
         BEFORE INSERT
            
            INITIALIZE g_xccv3_d_t.* TO NULL
            INITIALIZE g_xccv3_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xccv3_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_xccv3_d[l_ac].xccv001 = "1"
      LET g_xccv3_d[l_ac].xccv101 = "0"
      LET g_xccv3_d[l_ac].xccv102 = "0"
      LET g_xccv3_d[l_ac].xccv102a = "0"
      LET g_xccv3_d[l_ac].xccv102b = "0"
      LET g_xccv3_d[l_ac].xccv102c = "0"
      LET g_xccv3_d[l_ac].xccv102d = "0"
      LET g_xccv3_d[l_ac].xccv102e = "0"
      LET g_xccv3_d[l_ac].xccv102f = "0"
      LET g_xccv3_d[l_ac].xccv102g = "0"
      LET g_xccv3_d[l_ac].xccv102h = "0"
 
            
            #add-point:modify段before備份

            #end add-point
            LET g_xccv3_d_t.* = g_xccv3_d[l_ac].*     #新輸入資料
            LET g_xccv3_d_o.* = g_xccv3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axct303_set_entry_b(l_cmd)
            #add-point:set_entry_b後

            #end add-point
            CALL axct303_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xccv3_d[li_reproduce_target].* = g_xccv3_d[li_reproduce].*
 
               LET g_xccv3_d[g_xccv3_d.getLength()].xccv001 = NULL
               LET g_xccv3_d[g_xccv3_d.getLength()].xccv002 = NULL
               LET g_xccv3_d[g_xccv3_d.getLength()].xccv006 = NULL
               LET g_xccv3_d[g_xccv3_d.getLength()].xccv007 = NULL
               LET g_xccv3_d[g_xccv3_d.getLength()].xccv008 = NULL
               LET g_xccv3_d[g_xccv3_d.getLength()].xccv009 = NULL
               LET g_xccv3_d[g_xccv3_d.getLength()].xccv010 = NULL
               LET g_xccv3_d[g_xccv3_d.getLength()].xccv011 = NULL
 
            END IF
            
            #add-point:modify段before insert

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
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM xccv_t 
             WHERE xccvent = g_enterprise AND xccvld = g_xccv_m.xccvld
               AND xccv003 = g_xccv_m.xccv003
               AND xccv004 = g_xccv_m.xccv004
               AND xccv005 = g_xccv_m.xccv005
 
               AND xccv001 = g_xccv3_d[l_ac].xccv001
               AND xccv002 = g_xccv3_d[l_ac].xccv002
               AND xccv006 = g_xccv3_d[l_ac].xccv006
               AND xccv007 = g_xccv3_d[l_ac].xccv007
               AND xccv008 = g_xccv3_d[l_ac].xccv008
               AND xccv009 = g_xccv3_d[l_ac].xccv009
               AND xccv010 = g_xccv3_d[l_ac].xccv010
               AND xccv011 = g_xccv3_d[l_ac].xccv011
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前
               
               #end add-point
               INSERT INTO xccv_t
                           (xccvent,
                            xccvcomp,xccv004,xccv005,xccvld,xccv003,
                            xccv001,xccv002,xccv006,xccv007,xccv008,xccv009,xccv010,xccv011
                            ,xccv101,xccv102,xccv102a,xccv102b,xccv102c,xccv102d,xccv102e,xccv102f,xccv102g,xccv102h) 
                     VALUES(g_enterprise,
                            g_xccv_m.xccvcomp,g_xccv_m.xccv004,g_xccv_m.xccv005,g_xccv_m.xccvld,g_xccv_m.xccv003,
                            g_xccv3_d[l_ac].xccv001,g_xccv3_d[l_ac].xccv002,g_xccv3_d[l_ac].xccv006,g_xccv3_d[l_ac].xccv007, 
                                g_xccv3_d[l_ac].xccv008,g_xccv3_d[l_ac].xccv009,g_xccv3_d[l_ac].xccv010, 
                                g_xccv3_d[l_ac].xccv011
                            ,g_xccv3_d[l_ac].xccv101,g_xccv3_d[l_ac].xccv102,g_xccv3_d[l_ac].xccv102a,g_xccv3_d[l_ac].xccv102b, 
                                g_xccv3_d[l_ac].xccv102c,g_xccv3_d[l_ac].xccv102d,g_xccv3_d[l_ac].xccv102e, 
                                g_xccv3_d[l_ac].xccv102f,g_xccv3_d[l_ac].xccv102g,g_xccv3_d[l_ac].xccv102h) 

               #add-point:單身新增中
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_xccv3_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xccv_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #資料多語言用-增/改
               
               #add-point:input段-after_insert

               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cnt
            END IF
            
            #add-point:單身新增後

            #end add-point
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除前

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
               IF axct303_before_delete_3() THEN 
                  
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axct303_bcl
               LET l_count = g_xccv3_d.getLength()
            END IF 
            
            #add-point:單身刪除後

            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE 

               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_xccv3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv001
            #add-point:BEFORE FIELD xccv001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv001
            
            #add-point:AFTER FIELD xccv001
            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF  g_xccv_m.xccvld IS NOT NULL AND g_xccv_m.xccv003 IS NOT NULL AND g_xccv_m.xccv004 IS NOT NULL AND g_xccv_m.xccv005 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv001 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv002 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv006 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv007 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv008 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv009 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv010 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv011 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccv_m.xccvld != g_xccvld_t OR g_xccv_m.xccv003 != g_xccv003_t OR g_xccv_m.xccv004 != g_xccv004_t OR g_xccv_m.xccv005 != g_xccv005_t OR g_xccv3_d[g_detail_idx].xccv001 != g_xccv3_d_t.xccv001 OR g_xccv3_d[g_detail_idx].xccv002 != g_xccv3_d_t.xccv002 OR g_xccv3_d[g_detail_idx].xccv006 != g_xccv3_d_t.xccv006 OR g_xccv3_d[g_detail_idx].xccv007 != g_xccv3_d_t.xccv007 OR g_xccv3_d[g_detail_idx].xccv008 != g_xccv3_d_t.xccv008 OR g_xccv3_d[g_detail_idx].xccv009 != g_xccv3_d_t.xccv009 OR g_xccv3_d[g_detail_idx].xccv010 != g_xccv3_d_t.xccv010 OR g_xccv3_d[g_detail_idx].xccv011 != g_xccv3_d_t.xccv011)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccv_t WHERE "||"xccvent = '" ||g_enterprise|| "' AND "||"xccvld = '"||g_xccv_m.xccvld ||"' AND "|| "xccv003 = '"||g_xccv_m.xccv003 ||"' AND "|| "xccv004 = '"||g_xccv_m.xccv004 ||"' AND "|| "xccv005 = '"||g_xccv_m.xccv005 ||"' AND "|| "xccv001 = '"||g_xccv3_d[g_detail_idx].xccv001 ||"' AND "|| "xccv002 = '"||g_xccv3_d[g_detail_idx].xccv002 ||"' AND "|| "xccv006 = '"||g_xccv3_d[g_detail_idx].xccv006 ||"' AND "|| "xccv007 = '"||g_xccv3_d[g_detail_idx].xccv007 ||"' AND "|| "xccv008 = '"||g_xccv3_d[g_detail_idx].xccv008 ||"' AND "|| "xccv009 = '"||g_xccv3_d[g_detail_idx].xccv009 ||"' AND "|| "xccv010 = '"||g_xccv3_d[g_detail_idx].xccv010 ||"' AND "|| "xccv011 = '"||g_xccv3_d[g_detail_idx].xccv011 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv001
            #add-point:ON CHANGE xccv001

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv006
            #add-point:BEFORE FIELD xccv006

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv006
            
            #add-point:AFTER FIELD xccv006
            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF  g_xccv_m.xccvld IS NOT NULL AND g_xccv_m.xccv003 IS NOT NULL AND g_xccv_m.xccv004 IS NOT NULL AND g_xccv_m.xccv005 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv001 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv002 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv006 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv007 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv008 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv009 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv010 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv011 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccv_m.xccvld != g_xccvld_t OR g_xccv_m.xccv003 != g_xccv003_t OR g_xccv_m.xccv004 != g_xccv004_t OR g_xccv_m.xccv005 != g_xccv005_t OR g_xccv3_d[g_detail_idx].xccv001 != g_xccv3_d_t.xccv001 OR g_xccv3_d[g_detail_idx].xccv002 != g_xccv3_d_t.xccv002 OR g_xccv3_d[g_detail_idx].xccv006 != g_xccv3_d_t.xccv006 OR g_xccv3_d[g_detail_idx].xccv007 != g_xccv3_d_t.xccv007 OR g_xccv3_d[g_detail_idx].xccv008 != g_xccv3_d_t.xccv008 OR g_xccv3_d[g_detail_idx].xccv009 != g_xccv3_d_t.xccv009 OR g_xccv3_d[g_detail_idx].xccv010 != g_xccv3_d_t.xccv010 OR g_xccv3_d[g_detail_idx].xccv011 != g_xccv3_d_t.xccv011)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccv_t WHERE "||"xccvent = '" ||g_enterprise|| "' AND "||"xccvld = '"||g_xccv_m.xccvld ||"' AND "|| "xccv003 = '"||g_xccv_m.xccv003 ||"' AND "|| "xccv004 = '"||g_xccv_m.xccv004 ||"' AND "|| "xccv005 = '"||g_xccv_m.xccv005 ||"' AND "|| "xccv001 = '"||g_xccv3_d[g_detail_idx].xccv001 ||"' AND "|| "xccv002 = '"||g_xccv3_d[g_detail_idx].xccv002 ||"' AND "|| "xccv006 = '"||g_xccv3_d[g_detail_idx].xccv006 ||"' AND "|| "xccv007 = '"||g_xccv3_d[g_detail_idx].xccv007 ||"' AND "|| "xccv008 = '"||g_xccv3_d[g_detail_idx].xccv008 ||"' AND "|| "xccv009 = '"||g_xccv3_d[g_detail_idx].xccv009 ||"' AND "|| "xccv010 = '"||g_xccv3_d[g_detail_idx].xccv010 ||"' AND "|| "xccv011 = '"||g_xccv3_d[g_detail_idx].xccv011 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv006
            #add-point:ON CHANGE xccv006

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv007
            
            #add-point:AFTER FIELD xccv007
            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF  g_xccv_m.xccvld IS NOT NULL AND g_xccv_m.xccv003 IS NOT NULL AND g_xccv_m.xccv004 IS NOT NULL AND g_xccv_m.xccv005 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv001 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv002 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv006 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv007 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv008 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv009 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv010 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv011 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccv_m.xccvld != g_xccvld_t OR g_xccv_m.xccv003 != g_xccv003_t OR g_xccv_m.xccv004 != g_xccv004_t OR g_xccv_m.xccv005 != g_xccv005_t OR g_xccv3_d[g_detail_idx].xccv001 != g_xccv3_d_t.xccv001 OR g_xccv3_d[g_detail_idx].xccv002 != g_xccv3_d_t.xccv002 OR g_xccv3_d[g_detail_idx].xccv006 != g_xccv3_d_t.xccv006 OR g_xccv3_d[g_detail_idx].xccv007 != g_xccv3_d_t.xccv007 OR g_xccv3_d[g_detail_idx].xccv008 != g_xccv3_d_t.xccv008 OR g_xccv3_d[g_detail_idx].xccv009 != g_xccv3_d_t.xccv009 OR g_xccv3_d[g_detail_idx].xccv010 != g_xccv3_d_t.xccv010 OR g_xccv3_d[g_detail_idx].xccv011 != g_xccv3_d_t.xccv011)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccv_t WHERE "||"xccvent = '" ||g_enterprise|| "' AND "||"xccvld = '"||g_xccv_m.xccvld ||"' AND "|| "xccv003 = '"||g_xccv_m.xccv003 ||"' AND "|| "xccv004 = '"||g_xccv_m.xccv004 ||"' AND "|| "xccv005 = '"||g_xccv_m.xccv005 ||"' AND "|| "xccv001 = '"||g_xccv3_d[g_detail_idx].xccv001 ||"' AND "|| "xccv002 = '"||g_xccv3_d[g_detail_idx].xccv002 ||"' AND "|| "xccv006 = '"||g_xccv3_d[g_detail_idx].xccv006 ||"' AND "|| "xccv007 = '"||g_xccv3_d[g_detail_idx].xccv007 ||"' AND "|| "xccv008 = '"||g_xccv3_d[g_detail_idx].xccv008 ||"' AND "|| "xccv009 = '"||g_xccv3_d[g_detail_idx].xccv009 ||"' AND "|| "xccv010 = '"||g_xccv3_d[g_detail_idx].xccv010 ||"' AND "|| "xccv011 = '"||g_xccv3_d[g_detail_idx].xccv011 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv007
            #add-point:BEFORE FIELD xccv007

            #END add-point
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv007
            #add-point:ON CHANGE xccv007

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv008
            #add-point:BEFORE FIELD xccv008

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv008
            
            #add-point:AFTER FIELD xccv008
            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF  g_xccv_m.xccvld IS NOT NULL AND g_xccv_m.xccv003 IS NOT NULL AND g_xccv_m.xccv004 IS NOT NULL AND g_xccv_m.xccv005 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv001 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv002 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv006 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv007 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv008 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv009 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv010 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv011 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccv_m.xccvld != g_xccvld_t OR g_xccv_m.xccv003 != g_xccv003_t OR g_xccv_m.xccv004 != g_xccv004_t OR g_xccv_m.xccv005 != g_xccv005_t OR g_xccv3_d[g_detail_idx].xccv001 != g_xccv3_d_t.xccv001 OR g_xccv3_d[g_detail_idx].xccv002 != g_xccv3_d_t.xccv002 OR g_xccv3_d[g_detail_idx].xccv006 != g_xccv3_d_t.xccv006 OR g_xccv3_d[g_detail_idx].xccv007 != g_xccv3_d_t.xccv007 OR g_xccv3_d[g_detail_idx].xccv008 != g_xccv3_d_t.xccv008 OR g_xccv3_d[g_detail_idx].xccv009 != g_xccv3_d_t.xccv009 OR g_xccv3_d[g_detail_idx].xccv010 != g_xccv3_d_t.xccv010 OR g_xccv3_d[g_detail_idx].xccv011 != g_xccv3_d_t.xccv011)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccv_t WHERE "||"xccvent = '" ||g_enterprise|| "' AND "||"xccvld = '"||g_xccv_m.xccvld ||"' AND "|| "xccv003 = '"||g_xccv_m.xccv003 ||"' AND "|| "xccv004 = '"||g_xccv_m.xccv004 ||"' AND "|| "xccv005 = '"||g_xccv_m.xccv005 ||"' AND "|| "xccv001 = '"||g_xccv3_d[g_detail_idx].xccv001 ||"' AND "|| "xccv002 = '"||g_xccv3_d[g_detail_idx].xccv002 ||"' AND "|| "xccv006 = '"||g_xccv3_d[g_detail_idx].xccv006 ||"' AND "|| "xccv007 = '"||g_xccv3_d[g_detail_idx].xccv007 ||"' AND "|| "xccv008 = '"||g_xccv3_d[g_detail_idx].xccv008 ||"' AND "|| "xccv009 = '"||g_xccv3_d[g_detail_idx].xccv009 ||"' AND "|| "xccv010 = '"||g_xccv3_d[g_detail_idx].xccv010 ||"' AND "|| "xccv011 = '"||g_xccv3_d[g_detail_idx].xccv011 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv008
            #add-point:ON CHANGE xccv008

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv009
            
            #add-point:AFTER FIELD xccv009
            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF  g_xccv_m.xccvld IS NOT NULL AND g_xccv_m.xccv003 IS NOT NULL AND g_xccv_m.xccv004 IS NOT NULL AND g_xccv_m.xccv005 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv001 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv002 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv006 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv007 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv008 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv009 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv010 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv011 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccv_m.xccvld != g_xccvld_t OR g_xccv_m.xccv003 != g_xccv003_t OR g_xccv_m.xccv004 != g_xccv004_t OR g_xccv_m.xccv005 != g_xccv005_t OR g_xccv3_d[g_detail_idx].xccv001 != g_xccv3_d_t.xccv001 OR g_xccv3_d[g_detail_idx].xccv002 != g_xccv3_d_t.xccv002 OR g_xccv3_d[g_detail_idx].xccv006 != g_xccv3_d_t.xccv006 OR g_xccv3_d[g_detail_idx].xccv007 != g_xccv3_d_t.xccv007 OR g_xccv3_d[g_detail_idx].xccv008 != g_xccv3_d_t.xccv008 OR g_xccv3_d[g_detail_idx].xccv009 != g_xccv3_d_t.xccv009 OR g_xccv3_d[g_detail_idx].xccv010 != g_xccv3_d_t.xccv010 OR g_xccv3_d[g_detail_idx].xccv011 != g_xccv3_d_t.xccv011)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccv_t WHERE "||"xccvent = '" ||g_enterprise|| "' AND "||"xccvld = '"||g_xccv_m.xccvld ||"' AND "|| "xccv003 = '"||g_xccv_m.xccv003 ||"' AND "|| "xccv004 = '"||g_xccv_m.xccv004 ||"' AND "|| "xccv005 = '"||g_xccv_m.xccv005 ||"' AND "|| "xccv001 = '"||g_xccv3_d[g_detail_idx].xccv001 ||"' AND "|| "xccv002 = '"||g_xccv3_d[g_detail_idx].xccv002 ||"' AND "|| "xccv006 = '"||g_xccv3_d[g_detail_idx].xccv006 ||"' AND "|| "xccv007 = '"||g_xccv3_d[g_detail_idx].xccv007 ||"' AND "|| "xccv008 = '"||g_xccv3_d[g_detail_idx].xccv008 ||"' AND "|| "xccv009 = '"||g_xccv3_d[g_detail_idx].xccv009 ||"' AND "|| "xccv010 = '"||g_xccv3_d[g_detail_idx].xccv010 ||"' AND "|| "xccv011 = '"||g_xccv3_d[g_detail_idx].xccv011 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv009
            #add-point:BEFORE FIELD xccv009

            #END add-point
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv009
            #add-point:ON CHANGE xccv009

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv010
            #add-point:BEFORE FIELD xccv010

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv010
            
            #add-point:AFTER FIELD xccv010
            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF  g_xccv_m.xccvld IS NOT NULL AND g_xccv_m.xccv003 IS NOT NULL AND g_xccv_m.xccv004 IS NOT NULL AND g_xccv_m.xccv005 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv001 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv002 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv006 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv007 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv008 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv009 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv010 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv011 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccv_m.xccvld != g_xccvld_t OR g_xccv_m.xccv003 != g_xccv003_t OR g_xccv_m.xccv004 != g_xccv004_t OR g_xccv_m.xccv005 != g_xccv005_t OR g_xccv3_d[g_detail_idx].xccv001 != g_xccv3_d_t.xccv001 OR g_xccv3_d[g_detail_idx].xccv002 != g_xccv3_d_t.xccv002 OR g_xccv3_d[g_detail_idx].xccv006 != g_xccv3_d_t.xccv006 OR g_xccv3_d[g_detail_idx].xccv007 != g_xccv3_d_t.xccv007 OR g_xccv3_d[g_detail_idx].xccv008 != g_xccv3_d_t.xccv008 OR g_xccv3_d[g_detail_idx].xccv009 != g_xccv3_d_t.xccv009 OR g_xccv3_d[g_detail_idx].xccv010 != g_xccv3_d_t.xccv010 OR g_xccv3_d[g_detail_idx].xccv011 != g_xccv3_d_t.xccv011)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccv_t WHERE "||"xccvent = '" ||g_enterprise|| "' AND "||"xccvld = '"||g_xccv_m.xccvld ||"' AND "|| "xccv003 = '"||g_xccv_m.xccv003 ||"' AND "|| "xccv004 = '"||g_xccv_m.xccv004 ||"' AND "|| "xccv005 = '"||g_xccv_m.xccv005 ||"' AND "|| "xccv001 = '"||g_xccv3_d[g_detail_idx].xccv001 ||"' AND "|| "xccv002 = '"||g_xccv3_d[g_detail_idx].xccv002 ||"' AND "|| "xccv006 = '"||g_xccv3_d[g_detail_idx].xccv006 ||"' AND "|| "xccv007 = '"||g_xccv3_d[g_detail_idx].xccv007 ||"' AND "|| "xccv008 = '"||g_xccv3_d[g_detail_idx].xccv008 ||"' AND "|| "xccv009 = '"||g_xccv3_d[g_detail_idx].xccv009 ||"' AND "|| "xccv010 = '"||g_xccv3_d[g_detail_idx].xccv010 ||"' AND "|| "xccv011 = '"||g_xccv3_d[g_detail_idx].xccv011 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv010
            #add-point:ON CHANGE xccv010

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv011
            #add-point:BEFORE FIELD xccv011

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv011
            
            #add-point:AFTER FIELD xccv011
            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF  g_xccv_m.xccvld IS NOT NULL AND g_xccv_m.xccv003 IS NOT NULL AND g_xccv_m.xccv004 IS NOT NULL AND g_xccv_m.xccv005 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv001 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv002 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv006 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv007 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv008 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv009 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv010 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv011 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccv_m.xccvld != g_xccvld_t OR g_xccv_m.xccv003 != g_xccv003_t OR g_xccv_m.xccv004 != g_xccv004_t OR g_xccv_m.xccv005 != g_xccv005_t OR g_xccv3_d[g_detail_idx].xccv001 != g_xccv3_d_t.xccv001 OR g_xccv3_d[g_detail_idx].xccv002 != g_xccv3_d_t.xccv002 OR g_xccv3_d[g_detail_idx].xccv006 != g_xccv3_d_t.xccv006 OR g_xccv3_d[g_detail_idx].xccv007 != g_xccv3_d_t.xccv007 OR g_xccv3_d[g_detail_idx].xccv008 != g_xccv3_d_t.xccv008 OR g_xccv3_d[g_detail_idx].xccv009 != g_xccv3_d_t.xccv009 OR g_xccv3_d[g_detail_idx].xccv010 != g_xccv3_d_t.xccv010 OR g_xccv3_d[g_detail_idx].xccv011 != g_xccv3_d_t.xccv011)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccv_t WHERE "||"xccvent = '" ||g_enterprise|| "' AND "||"xccvld = '"||g_xccv_m.xccvld ||"' AND "|| "xccv003 = '"||g_xccv_m.xccv003 ||"' AND "|| "xccv004 = '"||g_xccv_m.xccv004 ||"' AND "|| "xccv005 = '"||g_xccv_m.xccv005 ||"' AND "|| "xccv001 = '"||g_xccv3_d[g_detail_idx].xccv001 ||"' AND "|| "xccv002 = '"||g_xccv3_d[g_detail_idx].xccv002 ||"' AND "|| "xccv006 = '"||g_xccv3_d[g_detail_idx].xccv006 ||"' AND "|| "xccv007 = '"||g_xccv3_d[g_detail_idx].xccv007 ||"' AND "|| "xccv008 = '"||g_xccv3_d[g_detail_idx].xccv008 ||"' AND "|| "xccv009 = '"||g_xccv3_d[g_detail_idx].xccv009 ||"' AND "|| "xccv010 = '"||g_xccv3_d[g_detail_idx].xccv010 ||"' AND "|| "xccv011 = '"||g_xccv3_d[g_detail_idx].xccv011 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv011
            #add-point:ON CHANGE xccv011

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv002
            
            #add-point:AFTER FIELD xccv002
            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF  g_xccv_m.xccvld IS NOT NULL AND g_xccv_m.xccv003 IS NOT NULL AND g_xccv_m.xccv004 IS NOT NULL AND g_xccv_m.xccv005 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv001 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv002 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv006 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv007 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv008 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv009 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv010 IS NOT NULL AND g_xccv3_d[g_detail_idx].xccv011 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccv_m.xccvld != g_xccvld_t OR g_xccv_m.xccv003 != g_xccv003_t OR g_xccv_m.xccv004 != g_xccv004_t OR g_xccv_m.xccv005 != g_xccv005_t OR g_xccv3_d[g_detail_idx].xccv001 != g_xccv3_d_t.xccv001 OR g_xccv3_d[g_detail_idx].xccv002 != g_xccv3_d_t.xccv002 OR g_xccv3_d[g_detail_idx].xccv006 != g_xccv3_d_t.xccv006 OR g_xccv3_d[g_detail_idx].xccv007 != g_xccv3_d_t.xccv007 OR g_xccv3_d[g_detail_idx].xccv008 != g_xccv3_d_t.xccv008 OR g_xccv3_d[g_detail_idx].xccv009 != g_xccv3_d_t.xccv009 OR g_xccv3_d[g_detail_idx].xccv010 != g_xccv3_d_t.xccv010 OR g_xccv3_d[g_detail_idx].xccv011 != g_xccv3_d_t.xccv011)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccv_t WHERE "||"xccvent = '" ||g_enterprise|| "' AND "||"xccvld = '"||g_xccv_m.xccvld ||"' AND "|| "xccv003 = '"||g_xccv_m.xccv003 ||"' AND "|| "xccv004 = '"||g_xccv_m.xccv004 ||"' AND "|| "xccv005 = '"||g_xccv_m.xccv005 ||"' AND "|| "xccv001 = '"||g_xccv3_d[g_detail_idx].xccv001 ||"' AND "|| "xccv002 = '"||g_xccv3_d[g_detail_idx].xccv002 ||"' AND "|| "xccv006 = '"||g_xccv3_d[g_detail_idx].xccv006 ||"' AND "|| "xccv007 = '"||g_xccv3_d[g_detail_idx].xccv007 ||"' AND "|| "xccv008 = '"||g_xccv3_d[g_detail_idx].xccv008 ||"' AND "|| "xccv009 = '"||g_xccv3_d[g_detail_idx].xccv009 ||"' AND "|| "xccv010 = '"||g_xccv3_d[g_detail_idx].xccv010 ||"' AND "|| "xccv011 = '"||g_xccv3_d[g_detail_idx].xccv011 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv002
            #add-point:BEFORE FIELD xccv002

            #END add-point
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv002
            #add-point:ON CHANGE xccv002

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv101
            #add-point:BEFORE FIELD xccv101

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv101
            
            #add-point:AFTER FIELD xccv101

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv101
            #add-point:ON CHANGE xccv101

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv102_3
            #add-point:BEFORE FIELD xccv102

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv102_3
            
            #add-point:AFTER FIELD xccv102

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv102_3
            #add-point:ON CHANGE xccv102

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv102a_3
            #add-point:BEFORE FIELD xccv102a_3

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv102a_3
            
            #add-point:AFTER FIELD xccv102a_3
            CALL axct303_xccv102_sum_3()
            LET g_xccv3_d[l_ac].xccv102a = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv3_d[l_ac].xccv102a,2)
            LET g_xccv3_d[l_ac].xccv102 = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv3_d[l_ac].xccv102,2)
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv102a_3
            #add-point:ON CHANGE xccv102a_3

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv102b_3
            #add-point:BEFORE FIELD xccv102b_3

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv102b_3
            
            #add-point:AFTER FIELD xccv102b_3
            CALL axct303_xccv102_sum_3()
            LET g_xccv3_d[l_ac].xccv102b = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv3_d[l_ac].xccv102b,2)
            LET g_xccv3_d[l_ac].xccv102 = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv3_d[l_ac].xccv102,2)
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv102b_3
            #add-point:ON CHANGE xccv102b_3

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv102c_3
            #add-point:BEFORE FIELD xccv102c_3

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv102c_3
            
            #add-point:AFTER FIELD xccv102c_3
            CALL axct303_xccv102_sum_3()
            LET g_xccv3_d[l_ac].xccv102c = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv3_d[l_ac].xccv102c,2)
            LET g_xccv3_d[l_ac].xccv102 = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv3_d[l_ac].xccv102,2)
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv102c_3
            #add-point:ON CHANGE xccv102c_3

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv102d_3
            #add-point:BEFORE FIELD xccv102d_3

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv102d_3
            
            #add-point:AFTER FIELD xccv102d_3
            CALL axct303_xccv102_sum_3()
            LET g_xccv3_d[l_ac].xccv102d = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv3_d[l_ac].xccv102d,2)
            LET g_xccv3_d[l_ac].xccv102 = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv3_d[l_ac].xccv102,2)
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv102d_3
            #add-point:ON CHANGE xccv102d_3

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv102e_3
            #add-point:BEFORE FIELD xccv102e_3

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv102e_3
            
            #add-point:AFTER FIELD xccv102e_3
            CALL axct303_xccv102_sum_3()
            LET g_xccv3_d[l_ac].xccv102e = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv3_d[l_ac].xccv102e,2)
            LET g_xccv3_d[l_ac].xccv102 = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv3_d[l_ac].xccv102,2)
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv102e_3
            #add-point:ON CHANGE xccv102e_3

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv102f_3
            #add-point:BEFORE FIELD xccv102f_3

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv102f_3
            
            #add-point:AFTER FIELD xccv102f_3
            CALL axct303_xccv102_sum_3()
            LET g_xccv3_d[l_ac].xccv102f = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv3_d[l_ac].xccv102f,2)
            LET g_xccv3_d[l_ac].xccv102 = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv3_d[l_ac].xccv102,2)
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv102f_3
            #add-point:ON CHANGE xccv102f_3

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv102g_3
            #add-point:BEFORE FIELD xccv102g_3

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv102g_3
            
            #add-point:AFTER FIELD xccv102g_3
            CALL axct303_xccv102_sum_3()
            LET g_xccv3_d[l_ac].xccv102g = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv3_d[l_ac].xccv102g,2)
            LET g_xccv3_d[l_ac].xccv102 = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv3_d[l_ac].xccv102,2)
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv102g_3
            #add-point:ON CHANGE xccv102g_3

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccv102h_3
            #add-point:BEFORE FIELD xccv102h_3_2

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccv102h_3
            
            #add-point:AFTER FIELD xccv102h_3_2
            CALL axct303_xccv102_sum_3()
            LET g_xccv3_d[l_ac].xccv102h = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv3_d[l_ac].xccv102h,2)
            LET g_xccv3_d[l_ac].xccv102 = s_curr_round(g_xccv_m.xccvcomp,g_glaa001,g_xccv3_d[l_ac].xccv102,2)
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE xccv102h_3
            #add-point:ON CHANGE xccv102h_3

            #END add-point
 
 
                  #Ctrlp:input.c.page1.xccv001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv001
            #add-point:ON ACTION controlp INFIELD xccv001

            #END add-point
 
         #Ctrlp:input.c.page1.xccv006
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv006
            #add-point:ON ACTION controlp INFIELD xccv006
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccv3_d[l_ac].xccv006             #給予default值
            LET g_qryparam.default2 = "" #g_xccv3_d[l_ac].sfbaseq1 #项序
            LET g_qryparam.default3 = "" #g_xccv3_d[l_ac].sfaadocno #单号
            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL q_sfbadocno()                                #呼叫開窗

            LET g_xccv3_d[l_ac].xccv006 = g_qryparam.return1              
            #LET g_xccv3_d[l_ac].sfbaseq1 = g_qryparam.return2 
            #LET g_xccv3_d[l_ac].sfaadocno = g_qryparam.return3 
            DISPLAY g_xccv3_d[l_ac].xccv006 TO xccv006              #
            #DISPLAY g_xccv3_d[l_ac].sfbaseq1 TO sfbaseq1 #项序
            #DISPLAY g_xccv3_d[l_ac].sfaadocno TO sfaadocno #单号
            NEXT FIELD xccv006                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xccv007
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv007
            #add-point:ON ACTION controlp INFIELD xccv007
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccv3_d[l_ac].xccv007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL q_sfba003()                                #呼叫開窗

            LET g_xccv3_d[l_ac].xccv007 = g_qryparam.return1              

            DISPLAY g_xccv3_d[l_ac].xccv007 TO xccv007              #

            NEXT FIELD xccv007                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xccv008
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv008
            #add-point:ON ACTION controlp INFIELD xccv008
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccv3_d[l_ac].xccv008             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL q_sfba004()                                #呼叫開窗

            LET g_xccv3_d[l_ac].xccv008 = g_qryparam.return1              

            DISPLAY g_xccv3_d[l_ac].xccv008 TO xccv008              #

            NEXT FIELD xccv008                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xccv009
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv009
            #add-point:ON ACTION controlp INFIELD xccv009
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccv3_d[l_ac].xccv009             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_site#s

            
            CALL q_imag001()                                #呼叫開窗

            LET g_xccv3_d[l_ac].xccv009 = g_qryparam.return1              

            DISPLAY g_xccv3_d[l_ac].xccv009 TO xccv009              #

            NEXT FIELD xccv009                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xccv010
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv010
            #add-point:ON ACTION controlp INFIELD xccv010
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccv3_d[l_ac].xccv010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL q_bmaa002_1()                                #呼叫開窗

            LET g_xccv3_d[l_ac].xccv010 = g_qryparam.return1              

            DISPLAY g_xccv3_d[l_ac].xccv010 TO xccv010              #

            NEXT FIELD xccv010                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xccv011
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv011
            #add-point:ON ACTION controlp INFIELD xccv011
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccv3_d[l_ac].xccv011             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL q_inaj010()                                #呼叫開窗

            LET g_xccv3_d[l_ac].xccv011 = g_qryparam.return1              

            DISPLAY g_xccv3_d[l_ac].xccv011 TO xccv011              #

            NEXT FIELD xccv011                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xccv002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv002
            #add-point:ON ACTION controlp INFIELD xccv002
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccv3_d[l_ac].xccv002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL q_xcbf001()                                #呼叫開窗

            LET g_xccv3_d[l_ac].xccv002 = g_qryparam.return1              

            DISPLAY g_xccv3_d[l_ac].xccv002 TO xccv002              #

            NEXT FIELD xccv002                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xccv101
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv101
            #add-point:ON ACTION controlp INFIELD xccv101

            #END add-point
 
         #Ctrlp:input.c.page1.xccv102
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv102
            #add-point:ON ACTION controlp INFIELD xccv102

            #END add-point
 
         #Ctrlp:input.c.page1.xccv102a
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv102a_3
            #add-point:ON ACTION controlp INFIELD xccv102a_3

            #END add-point
 
         #Ctrlp:input.c.page1.xccv102b
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv102b_3
            #add-point:ON ACTION controlp INFIELD xccv102b_3

            #END add-point
 
         #Ctrlp:input.c.page1.xccv102c
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv102c_3
            #add-point:ON ACTION controlp INFIELD xccv102c_3

            #END add-point
 
         #Ctrlp:input.c.page1.xccv102d
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv102d_3
            #add-point:ON ACTION controlp INFIELD xccv102d_3

            #END add-point
 
         #Ctrlp:input.c.page1.xccv102e
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv102e_3
            #add-point:ON ACTION controlp INFIELD xccv102e_3

            #END add-point
 
         #Ctrlp:input.c.page1.xccv102f
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv102f_3
            #add-point:ON ACTION controlp INFIELD xccv102f_3

            #END add-point
 
         #Ctrlp:input.c.page1.xccv102g
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv102g_3
            #add-point:ON ACTION controlp INFIELD xccv102g_3

            #END add-point
 
         #Ctrlp:input.c.page1.xccv102h
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccv102h_3_2
            #add-point:ON ACTION controlp INFIELD xccv102h_3_2

            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_xccv3_d[l_ac].* = g_xccv3_d_t.*
               CLOSE axct303_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xccv3_d[l_ac].xccv001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xccv3_d[l_ac].* = g_xccv3_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
            
               #add-point:單身修改前
               
               #end add-point
         
               UPDATE xccv_t SET (xccvld,xccv003,xccv004,xccv005,xccv001,xccv006,xccv007,xccv008,xccv009, 
                   xccv010,xccv011,xccv002,xccv101,xccv102,xccv102a,xccv102b,xccv102c,xccv102d,xccv102e, 
                   xccv102f,xccv102g,xccv102h) = (g_xccv_m.xccvld,g_xccv_m.xccv003,g_xccv_m.xccv004, 
                   g_xccv_m.xccv005,g_xccv3_d[l_ac].xccv001,g_xccv3_d[l_ac].xccv006,g_xccv3_d[l_ac].xccv007, 
                   g_xccv3_d[l_ac].xccv008,g_xccv3_d[l_ac].xccv009,g_xccv3_d[l_ac].xccv010,g_xccv3_d[l_ac].xccv011, 
                   g_xccv3_d[l_ac].xccv002,g_xccv3_d[l_ac].xccv101,g_xccv3_d[l_ac].xccv102,g_xccv3_d[l_ac].xccv102a, 
                   g_xccv3_d[l_ac].xccv102b,g_xccv3_d[l_ac].xccv102c,g_xccv3_d[l_ac].xccv102d,g_xccv3_d[l_ac].xccv102e, 
                   g_xccv3_d[l_ac].xccv102f,g_xccv3_d[l_ac].xccv102g,g_xccv3_d[l_ac].xccv102h)
                WHERE xccvent = g_enterprise AND xccvld = g_xccv_m.xccvld 
                 AND xccv003 = g_xccv_m.xccv003 
                 AND xccv004 = g_xccv_m.xccv004 
                 AND xccv005 = g_xccv_m.xccv005 
 
                 AND xccv001 = g_xccv3_d_t.xccv001 #項次   
                 AND xccv002 = g_xccv3_d_t.xccv002  
                 AND xccv006 = g_xccv3_d_t.xccv006  
                 AND xccv007 = g_xccv3_d_t.xccv007  
                 AND xccv008 = g_xccv3_d_t.xccv008  
                 AND xccv009 = g_xccv3_d_t.xccv009  
                 AND xccv010 = g_xccv3_d_t.xccv010  
                 AND xccv011 = g_xccv3_d_t.xccv011  
 
                 
               #add-point:單身修改中
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xccv_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xccv_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xccv_m.xccvld
               LET gs_keys_bak[1] = g_xccvld_t
               LET gs_keys[2] = g_xccv_m.xccv003
               LET gs_keys_bak[2] = g_xccv003_t
               LET gs_keys[3] = g_xccv_m.xccv004
               LET gs_keys_bak[3] = g_xccv004_t
               LET gs_keys[4] = g_xccv_m.xccv005
               LET gs_keys_bak[4] = g_xccv005_t
               LET gs_keys[5] = g_xccv3_d[g_detail_idx].xccv001
               LET gs_keys_bak[5] = g_xccv3_d_t.xccv001
               LET gs_keys[6] = g_xccv3_d[g_detail_idx].xccv002
               LET gs_keys_bak[6] = g_xccv3_d_t.xccv002
               LET gs_keys[7] = g_xccv3_d[g_detail_idx].xccv006
               LET gs_keys_bak[7] = g_xccv3_d_t.xccv006
               LET gs_keys[8] = g_xccv3_d[g_detail_idx].xccv007
               LET gs_keys_bak[8] = g_xccv3_d_t.xccv007
               LET gs_keys[9] = g_xccv3_d[g_detail_idx].xccv008
               LET gs_keys_bak[9] = g_xccv3_d_t.xccv008
               LET gs_keys[10] = g_xccv3_d[g_detail_idx].xccv009
               LET gs_keys_bak[10] = g_xccv3_d_t.xccv009
               LET gs_keys[11] = g_xccv3_d[g_detail_idx].xccv010
               LET gs_keys_bak[11] = g_xccv3_d_t.xccv010
               LET gs_keys[12] = g_xccv3_d[g_detail_idx].xccv011
               LET gs_keys_bak[12] = g_xccv3_d_t.xccv011
               CALL axct303_update_b('xccv_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     LET g_log1 = util.JSON.stringify(g_xccv_m),util.JSON.stringify(g_xccv3_d_t)
                     LET g_log2 = util.JSON.stringify(g_xccv_m),util.JSON.stringify(g_xccv3_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #若Key欄位有變動
               LET ls_keys[01] = g_xccv_m.xccvld
               LET ls_keys[ls_keys.getLength()+1] = g_xccv_m.xccv003
               LET ls_keys[ls_keys.getLength()+1] = g_xccv_m.xccv004
               LET ls_keys[ls_keys.getLength()+1] = g_xccv_m.xccv005
 
               LET ls_keys[ls_keys.getLength()+1] = g_xccv3_d_t.xccv001
               LET ls_keys[ls_keys.getLength()+1] = g_xccv3_d_t.xccv002
               LET ls_keys[ls_keys.getLength()+1] = g_xccv3_d_t.xccv006
               LET ls_keys[ls_keys.getLength()+1] = g_xccv3_d_t.xccv007
               LET ls_keys[ls_keys.getLength()+1] = g_xccv3_d_t.xccv008
               LET ls_keys[ls_keys.getLength()+1] = g_xccv3_d_t.xccv009
               LET ls_keys[ls_keys.getLength()+1] = g_xccv3_d_t.xccv010
               LET ls_keys[ls_keys.getLength()+1] = g_xccv3_d_t.xccv011
 
               CALL axct303_key_update_b(ls_keys)
               
               #add-point:單身修改後
               CALL s_transaction_end('Y','0') 
               #end add-point
            END IF
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xccv3_d[l_ac].* = g_xccv3_d_t.*
               END IF
               CLOSE axct303_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
 
            CLOSE axct303_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xccv3_d.getLength() = 0 THEN
               NEXT FIELD xccv001
            END IF
            #add-point:input段after input 

            #end add-point    
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_xccv3_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_xccv3_d.getLength()+1
            
      END INPUT
      #end add-point    
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:input段before_dialog name="input.before_dialog"
          CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
          CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx)
          CALL DIALOG.setCurrentRow("s_detail3",g_detail_idx)
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD xccvcomp
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xccv001
                WHEN "s_detail2"
                  NEXT FIELD xccv001_2
                 WHEN "s_detail3"
                  NEXT FIELD xccv001_3
 
            END CASE
         END IF
         #end add-point 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD xccvld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xccv001
 
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
 
{<section id="axct303.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axct303_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_date  DATE
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   CALL axct303_ref()   
   #檢查年度期別>=關賬日期，則不可修改刪除
   IF cl_null(g_xccv_m.xccvcomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6012') RETURNING l_date
   ELSE
      CALL cl_get_para(g_enterprise,g_xccv_m.xccvcomp,'S-FIN-6012') RETURNING l_date
   END IF
   IF g_xccv_m.xccv004 < YEAR(l_date) THEN
      CALL cl_set_act_visible("modify,modify_detail,delete", FALSE)
   ELSE
      IF g_xccv_m.xccv004 = YEAR(l_date) THEN
         IF g_xccv_m.xccv005 < MONTH(l_date) THEN
            CALL cl_set_act_visible("modify,modify_detail,delete", FALSE)
          ELSE
            CALL cl_set_act_visible("modify,modify_detail,delete", TRUE)
         END IF
      ELSE
         CALL cl_set_act_visible("modify,modify_detail,delete", TRUE)
      END IF
   END IF
   IF cl_null(g_xccv_m.xccvcomp) THEN
       CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否  
    ELSE
       CALL cl_get_para(g_enterprise,g_xccv_m.xccvcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否      
    END IF
      
    IF g_para_data = 'Y' THEN
       CALL cl_set_comp_visible('xccv002,xccv002_desc,xccv002_3,xccv002_3_desc,xccv002_2,xccv002_2_desc',TRUE) 
          
    ELSE
       CALL cl_set_comp_visible('xccv002,xccv002_desc,xccv002_3,xccv002_3_desc,xccv002_2,xccv002_2_desc',FALSE) 
             
    END IF
   IF g_glaa015 = 'Y' THEN
      CALL cl_set_comp_visible("page_3",TRUE)
   ELSE
      CALL cl_set_comp_visible("page_3",FALSE) 
   END IF
   IF g_glaa019 = 'Y' THEN
      CALL cl_set_comp_visible("page_4",TRUE)
   ELSE
      CALL cl_set_comp_visible("page_4",FALSE)
   END IF
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL axct303_b_fill(g_wc2) #第一階單身填充
      CALL axct303_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axct303_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_xccv_m.xccvcomp,g_xccv_m.xccvcomp_desc,g_xccv_m.xccv004,g_xccv_m.xccv005,g_xccv_m.xccvld, 
       g_xccv_m.xccvld_desc,g_xccv_m.xccv003,g_xccv_m.xccv003_desc
 
   CALL axct303_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axct303.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION axct303_ref_show()
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
   CALL axct303_ref()
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_xccv_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = g_xccv_m.xccvcomp
       LET g_ref_fields[2] = g_xccv_d[l_ac].xccv002
       CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp=? AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET g_xccv_d[l_ac].xccv002_desc = '', g_rtn_fields[1] , ''
       DISPLAY BY NAME g_xccv_d[l_ac].xccv002_desc
      #end add-point
   END FOR
   
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="axct303.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axct303_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE xccv_t.xccvld 
   DEFINE l_oldno     LIKE xccv_t.xccvld 
   DEFINE l_newno02     LIKE xccv_t.xccv003 
   DEFINE l_oldno02     LIKE xccv_t.xccv003 
   DEFINE l_newno03     LIKE xccv_t.xccv004 
   DEFINE l_oldno03     LIKE xccv_t.xccv004 
   DEFINE l_newno04     LIKE xccv_t.xccv005 
   DEFINE l_oldno04     LIKE xccv_t.xccv005 
 
   DEFINE l_master    RECORD LIKE xccv_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xccv_t.* #此變數樣板目前無使用
 
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
 
   IF g_xccv_m.xccvld IS NULL
      OR g_xccv_m.xccv003 IS NULL
      OR g_xccv_m.xccv004 IS NULL
      OR g_xccv_m.xccv005 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_xccvld_t = g_xccv_m.xccvld
   LET g_xccv003_t = g_xccv_m.xccv003
   LET g_xccv004_t = g_xccv_m.xccv004
   LET g_xccv005_t = g_xccv_m.xccv005
 
   
   LET g_xccv_m.xccvld = ""
   LET g_xccv_m.xccv003 = ""
   LET g_xccv_m.xccv004 = ""
   LET g_xccv_m.xccv005 = ""
 
   LET g_master_insert = FALSE
   CALL axct303_set_entry('a')
   CALL axct303_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_xccv_m.xccvld_desc = ''
   DISPLAY BY NAME g_xccv_m.xccvld_desc
   LET g_xccv_m.xccv003_desc = ''
   DISPLAY BY NAME g_xccv_m.xccv003_desc
 
   
   CALL axct303_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_xccv_m.* TO NULL
      INITIALIZE g_xccv_d TO NULL
 
      CALL axct303_show()
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
   CALL axct303_set_act_visible()
   CALL axct303_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xccvld_t = g_xccv_m.xccvld
   LET g_xccv003_t = g_xccv_m.xccv003
   LET g_xccv004_t = g_xccv_m.xccv004
   LET g_xccv005_t = g_xccv_m.xccv005
 
   
   #組合新增資料的條件
   LET g_add_browse = " xccvent = " ||g_enterprise|| " AND",
                      " xccvld = '", g_xccv_m.xccvld, "' "
                      ," AND xccv003 = '", g_xccv_m.xccv003, "' "
                      ," AND xccv004 = '", g_xccv_m.xccv004, "' "
                      ," AND xccv005 = '", g_xccv_m.xccv005, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axct303_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL axct303_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL axct303_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="axct303.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axct303_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xccv_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axct303_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xccv_t
    WHERE xccvent = g_enterprise AND xccvld = g_xccvld_t
    AND xccv003 = g_xccv003_t
    AND xccv004 = g_xccv004_t
    AND xccv005 = g_xccv005_t
 
       INTO TEMP axct303_detail
   
   #將key修正為調整後   
   UPDATE axct303_detail 
      #更新key欄位
      SET xccvld = g_xccv_m.xccvld
          , xccv003 = g_xccv_m.xccv003
          , xccv004 = g_xccv_m.xccv004
          , xccv005 = g_xccv_m.xccv005
 
      #更新共用欄位
      
                                       
   #將資料塞回原table   
   INSERT INTO xccv_t SELECT * FROM axct303_detail
   
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
   DROP TABLE axct303_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xccvld_t = g_xccv_m.xccvld
   LET g_xccv003_t = g_xccv_m.xccv003
   LET g_xccv004_t = g_xccv_m.xccv004
   LET g_xccv005_t = g_xccv_m.xccv005
 
   
   DROP TABLE axct303_detail
   
END FUNCTION
 
{</section>}
 
{<section id="axct303.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axct303_delete()
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
   
   IF g_xccv_m.xccvld IS NULL
   OR g_xccv_m.xccv003 IS NULL
   OR g_xccv_m.xccv004 IS NULL
   OR g_xccv_m.xccv005 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN axct303_cl USING g_enterprise,g_xccv_m.xccvld,g_xccv_m.xccv003,g_xccv_m.xccv004,g_xccv_m.xccv005
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axct303_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axct303_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axct303_master_referesh USING g_xccv_m.xccvld,g_xccv_m.xccv003,g_xccv_m.xccv004,g_xccv_m.xccv005 INTO g_xccv_m.xccvcomp, 
       g_xccv_m.xccv004,g_xccv_m.xccv005,g_xccv_m.xccvld,g_xccv_m.xccv003,g_xccv_m.xccvcomp_desc,g_xccv_m.xccvld_desc, 
       g_xccv_m.xccv003_desc
   
   #遮罩相關處理
   LET g_xccv_m_mask_o.* =  g_xccv_m.*
   CALL axct303_xccv_t_mask()
   LET g_xccv_m_mask_n.* =  g_xccv_m.*
   
   CALL axct303_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axct303_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM xccv_t WHERE xccvent = g_enterprise AND xccvld = g_xccv_m.xccvld
                                                               AND xccv003 = g_xccv_m.xccv003
                                                               AND xccv004 = g_xccv_m.xccv004
                                                               AND xccv005 = g_xccv_m.xccv005
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xccv_t:",SQLERRMESSAGE 
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
      #   CLOSE axct303_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_xccv_d.clear() 
 
     
      CALL axct303_ui_browser_refresh()  
      #CALL axct303_ui_headershow()  
      #CALL axct303_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL axct303_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL axct303_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE axct303_cl
 
   #功能已完成,通報訊息中心
   CALL axct303_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axct303.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axct303_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_xccv_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT xccv001,xccv006,xccv007,xccv008,xccv009,xccv010,xccv011,xccv002,xccv101, 
       xccv102,xccv102a,xccv102b,xccv102c,xccv102d,xccv102e,xccv102f,xccv102g,xccv102h,t1.oocql004 , 
       t2.imaal003 ,t3.imaal004 ,t4.xcbfl003 FROM xccv_t",   
               "",
               
                              " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='221' AND t1.oocql002=xccv007 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=xccv009 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=xccv009 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN xcbfl_t t4 ON t4.xcbflent="||g_enterprise||" AND t4.xcbflcomp=xccvcomp AND t4.xcbfl001=xccv002 AND t4.xcbfl002='"||g_dlang||"' ",
 
               " WHERE xccvent= ? AND xccvld=? AND xccv003=? AND xccv004=? AND xccv005=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xccv_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = g_sql CLIPPED, " AND xccv001 = '1' " 
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axct303_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY xccv_t.xccv001,xccv_t.xccv002,xccv_t.xccv006,xccv_t.xccv007,xccv_t.xccv008,xccv_t.xccv009,xccv_t.xccv010,xccv_t.xccv011"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axct303_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axct303_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xccv_m.xccvld,g_xccv_m.xccv003,g_xccv_m.xccv004,g_xccv_m.xccv005   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xccv_m.xccvld,g_xccv_m.xccv003,g_xccv_m.xccv004,g_xccv_m.xccv005 INTO g_xccv_d[l_ac].xccv001, 
          g_xccv_d[l_ac].xccv006,g_xccv_d[l_ac].xccv007,g_xccv_d[l_ac].xccv008,g_xccv_d[l_ac].xccv009, 
          g_xccv_d[l_ac].xccv010,g_xccv_d[l_ac].xccv011,g_xccv_d[l_ac].xccv002,g_xccv_d[l_ac].xccv101, 
          g_xccv_d[l_ac].xccv102,g_xccv_d[l_ac].xccv102a,g_xccv_d[l_ac].xccv102b,g_xccv_d[l_ac].xccv102c, 
          g_xccv_d[l_ac].xccv102d,g_xccv_d[l_ac].xccv102e,g_xccv_d[l_ac].xccv102f,g_xccv_d[l_ac].xccv102g, 
          g_xccv_d[l_ac].xccv102h,g_xccv_d[l_ac].xccv007_desc,g_xccv_d[l_ac].xccv009_desc,g_xccv_d[l_ac].xccv009_desc_desc, 
          g_xccv_d[l_ac].xccv002_desc   #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
        
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
 
            CALL g_xccv_d.deleteElement(g_xccv_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   LET g_rec_b=l_ac-1
   FREE axct303_pb 
   RETURN
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_xccv_d.getLength()
      LET g_xccv_d_mask_o[l_ac].* =  g_xccv_d[l_ac].*
      CALL axct303_xccv_t_mask()
      LET g_xccv_d_mask_n[l_ac].* =  g_xccv_d[l_ac].*
   END FOR
   
 
 
   FREE axct303_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="axct303.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axct303_idx_chk()
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
      IF g_detail_idx > g_xccv_d.getLength() THEN
         LET g_detail_idx = g_xccv_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_xccv_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xccv_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      #確保當下指標的位置未超過上限
      IF g_detail_idx > g_xccv2_d.getLength() THEN
         LET g_detail_idx = g_xccv2_d.getLength()
      END IF
      #確保資料位置不小於2
      IF g_detail_idx = 0 AND g_xccv2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xccv2_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      #確保當下指標的位置未超過上限
      IF g_detail_idx > g_xccv3_d.getLength() THEN
         LET g_detail_idx = g_xccv3_d.getLength()
      END IF
      #確保資料位置不小於3
      IF g_detail_idx = 0 AND g_xccv3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xccv3_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
   END IF
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axct303.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axct303_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_xccv_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   IF g_glaa015 = 'Y' THEN
      CALL axct303_b_fill_2()
   END IF
   IF g_glaa019 = 'Y' THEN
      CALL axct303_b_fill_3()
   END IF
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axct303.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION axct303_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM xccv_t
    WHERE xccvent = g_enterprise AND xccvld = g_xccv_m.xccvld AND
                              xccv003 = g_xccv_m.xccv003 AND
                              xccv004 = g_xccv_m.xccv004 AND
                              xccv005 = g_xccv_m.xccv005 AND
 
          xccv001 = g_xccv_d_t.xccv001
      AND xccv002 = g_xccv_d_t.xccv002
      AND xccv006 = g_xccv_d_t.xccv006
      AND xccv007 = g_xccv_d_t.xccv007
      AND xccv008 = g_xccv_d_t.xccv008
      AND xccv009 = g_xccv_d_t.xccv009
      AND xccv010 = g_xccv_d_t.xccv010
      AND xccv011 = g_xccv_d_t.xccv011
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   IF g_glaa015 = 'Y' OR g_glaa019 = 'Y' THEN  
      DELETE FROM xccv_t
       WHERE xccvent = g_enterprise AND xccvld = g_xccv_m.xccvld AND
                                 xccv003 = g_xccv_m.xccv003 AND
                                 xccv004 = g_xccv_m.xccv004 AND
                                 xccv005 = g_xccv_m.xccv005 
         AND xccv002 = g_xccv_d_t.xccv002
         AND xccv006 = g_xccv_d_t.xccv006
         AND xccv007 = g_xccv_d_t.xccv007
         AND xccv008 = g_xccv_d_t.xccv008
         AND xccv009 = g_xccv_d_t.xccv009
         AND xccv010 = g_xccv_d_t.xccv010
         AND xccv011 = g_xccv_d_t.xccv011
   END IF
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccv_t:",SQLERRMESSAGE 
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
 
{<section id="axct303.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axct303_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="axct303.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axct303_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="axct303.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axct303_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="axct303.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION axct303_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_xccv_d[l_ac].xccv001 = g_xccv_d_t.xccv001 
      AND g_xccv_d[l_ac].xccv002 = g_xccv_d_t.xccv002 
      AND g_xccv_d[l_ac].xccv006 = g_xccv_d_t.xccv006 
      AND g_xccv_d[l_ac].xccv007 = g_xccv_d_t.xccv007 
      AND g_xccv_d[l_ac].xccv008 = g_xccv_d_t.xccv008 
      AND g_xccv_d[l_ac].xccv009 = g_xccv_d_t.xccv009 
      AND g_xccv_d[l_ac].xccv010 = g_xccv_d_t.xccv010 
      AND g_xccv_d[l_ac].xccv011 = g_xccv_d_t.xccv011 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="axct303.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axct303_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="axct303.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axct303_lock_b(ps_table,ps_page)
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
   #CALL axct303_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axct303.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axct303_unlock_b(ps_table,ps_page)
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
 
{<section id="axct303.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axct303_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xccvld,xccv003,xccv004,xccv005",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("xccvcomp",TRUE)
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axct303.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axct303_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xccvld,xccv003,xccv004,xccv005",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("xccvcomp",FALSE)
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axct303.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axct303_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   CALL cl_set_comp_required('xccv011',FALSE)
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axct303.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axct303_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axct303.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axct303_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axct303.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axct303_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axct303.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axct303_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axct303.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axct303_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axct303.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axct303_default_search()
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
      LET ls_wc = ls_wc, " xccvld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xccv003 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xccv004 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " xccv005 = '", g_argv[04], "' AND "
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
 
{<section id="axct303.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axct303_fill_chk(ps_idx)
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
 
{<section id="axct303.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION axct303_modify_detail_chk(ps_record)
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
         LET ls_return = "xccv001"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="axct303.mask_functions" >}
&include "erp/axc/axct303_mask.4gl"
 
{</section>}
 
{<section id="axct303.state_change" >}
    
 
{</section>}
 
{<section id="axct303.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axct303_set_pk_array()
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
   LET g_pk_array[1].values = g_xccv_m.xccvld
   LET g_pk_array[1].column = 'xccvld'
   LET g_pk_array[2].values = g_xccv_m.xccv003
   LET g_pk_array[2].column = 'xccv003'
   LET g_pk_array[3].values = g_xccv_m.xccv004
   LET g_pk_array[3].column = 'xccv004'
   LET g_pk_array[4].values = g_xccv_m.xccv005
   LET g_pk_array[4].column = 'xccv005'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axct303.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axct303_msgcentre_notify(lc_state)
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
   CALL axct303_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xccv_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axct303.other_function" readonly="Y" >}

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
PRIVATE FUNCTION axct303_insert_xccv()
   DEFINE l_rate     LIKE ooan_t.ooan005
DEFINE l_amount   LIKE xccv_t.xccv102
   LET l_amount = 0 
   LET l_rate = 1
   IF g_glaa015 = 'Y' THEN
      CALL s_aooi160_get_exrate('2',g_xccv_m.xccvld,g_today,g_glaa001,g_glaa016,0,g_glaa018)
           RETURNING l_rate
      LET g_xccv2_d[l_ac].xccv102a = g_xccv_d[l_ac].xccv102a * l_rate
      LET g_xccv2_d[l_ac].xccv102b = g_xccv_d[l_ac].xccv102b * l_rate
      LET g_xccv2_d[l_ac].xccv102c = g_xccv_d[l_ac].xccv102c * l_rate
      LET g_xccv2_d[l_ac].xccv102d = g_xccv_d[l_ac].xccv102d * l_rate
      LET g_xccv2_d[l_ac].xccv102e = g_xccv_d[l_ac].xccv102e * l_rate
      LET g_xccv2_d[l_ac].xccv102f = g_xccv_d[l_ac].xccv102f * l_rate
      LET g_xccv2_d[l_ac].xccv102g = g_xccv_d[l_ac].xccv102g * l_rate
      LET g_xccv2_d[l_ac].xccv102h = g_xccv_d[l_ac].xccv102h * l_rate
      CALL axct303_xccv102_sum_2()
      LET g_xccv2_d[l_ac].xccv102a = s_curr_round(g_xccv_m.xccvcomp,g_glaa016,g_xccv2_d[l_ac].xccv102a,2)
      LET g_xccv2_d[l_ac].xccv102b = s_curr_round(g_xccv_m.xccvcomp,g_glaa016,g_xccv2_d[l_ac].xccv102b,2)
      LET g_xccv2_d[l_ac].xccv102c = s_curr_round(g_xccv_m.xccvcomp,g_glaa016,g_xccv2_d[l_ac].xccv102c,2)
      LET g_xccv2_d[l_ac].xccv102d = s_curr_round(g_xccv_m.xccvcomp,g_glaa016,g_xccv2_d[l_ac].xccv102d,2)
      LET g_xccv2_d[l_ac].xccv102e = s_curr_round(g_xccv_m.xccvcomp,g_glaa016,g_xccv2_d[l_ac].xccv102e,2)
      LET g_xccv2_d[l_ac].xccv102f = s_curr_round(g_xccv_m.xccvcomp,g_glaa016,g_xccv2_d[l_ac].xccv102f,2)
      LET g_xccv2_d[l_ac].xccv102g = s_curr_round(g_xccv_m.xccvcomp,g_glaa016,g_xccv2_d[l_ac].xccv102g,2)
      LET g_xccv2_d[l_ac].xccv102h = s_curr_round(g_xccv_m.xccvcomp,g_glaa016,g_xccv2_d[l_ac].xccv102h,2)
      LET g_xccv2_d[l_ac].xccv102 = s_curr_round(g_xccv_m.xccvcomp,g_glaa016,g_xccv2_d[l_ac].xccv102,2)
      
      INSERT INTO xccv_t
            (xccvent,
             xccvcomp,xccv004,xccv005,xccvld,xccv003,
             xccv001,xccv002,xccv006,xccv007,xccv008,xccv009,xccv010,xccv011,
             xccv101,xccv102,xccv102a,xccv102b,xccv102c,xccv102d,xccv102e,xccv102f,xccv102g,xccv102h) 
      VALUES(g_enterprise,
             g_xccv_m.xccvcomp,g_xccv_m.xccv004,g_xccv_m.xccv005,g_xccv_m.xccvld,g_xccv_m.xccv003,
             '2',g_xccv_d[l_ac].xccv002,g_xccv_d[l_ac].xccv006,g_xccv_d[l_ac].xccv007, 
                 g_xccv_d[l_ac].xccv008,g_xccv_d[l_ac].xccv009,g_xccv_d[l_ac].xccv010, 
                 g_xccv_d[l_ac].xccv011,
                 g_xccv_d[l_ac].xccv101,g_xccv2_d[l_ac].xccv102, 
                 g_xccv2_d[l_ac].xccv102a,g_xccv2_d[l_ac].xccv102b,g_xccv2_d[l_ac].xccv102c, 
                 g_xccv2_d[l_ac].xccv102d,g_xccv2_d[l_ac].xccv102e,g_xccv2_d[l_ac].xccv102f, 
                 g_xccv2_d[l_ac].xccv102g,g_xccv2_d[l_ac].xccv102h)      
      
   END IF
   LET l_amount = 0 
   LET l_rate = 1
   IF g_glaa019 = 'Y' THEN
      CALL s_aooi160_get_exrate('2',g_xccv_m.xccvld,g_today,g_glaa001,g_glaa020,0,g_glaa022)
           RETURNING l_rate
      LET g_xccv3_d[l_ac].xccv102a = g_xccv_d[l_ac].xccv102a * l_rate
      LET g_xccv3_d[l_ac].xccv102b = g_xccv_d[l_ac].xccv102b * l_rate
      LET g_xccv3_d[l_ac].xccv102c = g_xccv_d[l_ac].xccv102c * l_rate
      LET g_xccv3_d[l_ac].xccv102d = g_xccv_d[l_ac].xccv102d * l_rate
      LET g_xccv3_d[l_ac].xccv102e = g_xccv_d[l_ac].xccv102e * l_rate
      LET g_xccv3_d[l_ac].xccv102f = g_xccv_d[l_ac].xccv102f * l_rate
      LET g_xccv3_d[l_ac].xccv102g = g_xccv_d[l_ac].xccv102g * l_rate
      LET g_xccv3_d[l_ac].xccv102h = g_xccv_d[l_ac].xccv102h * l_rate
      CALL axct303_xccv102_sum_3()
      LET g_xccv3_d[l_ac].xccv102a = s_curr_round(g_xccv_m.xccvcomp,g_glaa020,g_xccv3_d[l_ac].xccv102a,2)
      LET g_xccv3_d[l_ac].xccv102b = s_curr_round(g_xccv_m.xccvcomp,g_glaa020,g_xccv3_d[l_ac].xccv102b,2)
      LET g_xccv3_d[l_ac].xccv102c = s_curr_round(g_xccv_m.xccvcomp,g_glaa020,g_xccv3_d[l_ac].xccv102c,2)
      LET g_xccv3_d[l_ac].xccv102d = s_curr_round(g_xccv_m.xccvcomp,g_glaa020,g_xccv3_d[l_ac].xccv102d,2)
      LET g_xccv3_d[l_ac].xccv102e = s_curr_round(g_xccv_m.xccvcomp,g_glaa020,g_xccv3_d[l_ac].xccv102e,2)
      LET g_xccv3_d[l_ac].xccv102f = s_curr_round(g_xccv_m.xccvcomp,g_glaa020,g_xccv3_d[l_ac].xccv102f,2)
      LET g_xccv3_d[l_ac].xccv102g = s_curr_round(g_xccv_m.xccvcomp,g_glaa020,g_xccv3_d[l_ac].xccv102g,2)
      LET g_xccv3_d[l_ac].xccv102h = s_curr_round(g_xccv_m.xccvcomp,g_glaa020,g_xccv3_d[l_ac].xccv102h,2)
      LET g_xccv3_d[l_ac].xccv102 = s_curr_round(g_xccv_m.xccvcomp,g_glaa020,g_xccv3_d[l_ac].xccv102,2)
      
      INSERT INTO xccv_t
            (xccvent,
             xccvcomp,xccv004,xccv005,xccvld,xccv003,
             xccv001,xccv002,xccv006,xccv007,xccv008,xccv009,xccv010,xccv011,
             xccv101,xccv102,xccv102a,xccv102b,xccv102c,xccv102d,xccv102e,xccv102f,xccv102g,xccv102h) 
      VALUES(g_enterprise,
             g_xccv_m.xccvcomp,g_xccv_m.xccv004,g_xccv_m.xccv005,g_xccv_m.xccvld,g_xccv_m.xccv003,
             '3',g_xccv_d[l_ac].xccv002,g_xccv_d[l_ac].xccv006,g_xccv_d[l_ac].xccv007, 
                 g_xccv_d[l_ac].xccv008,g_xccv_d[l_ac].xccv009,g_xccv_d[l_ac].xccv010, 
                 g_xccv_d[l_ac].xccv011,
                 g_xccv_d[l_ac].xccv101,g_xccv3_d[l_ac].xccv102, 
                 g_xccv3_d[l_ac].xccv102a,g_xccv3_d[l_ac].xccv102b,g_xccv3_d[l_ac].xccv102c, 
                 g_xccv3_d[l_ac].xccv102d,g_xccv3_d[l_ac].xccv102e,g_xccv3_d[l_ac].xccv102f, 
                 g_xccv3_d[l_ac].xccv102g,g_xccv3_d[l_ac].xccv102h)
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
PRIVATE FUNCTION axct303_xccv102_sum_2()
   IF cl_null(g_xccv2_d[l_ac].xccv102a) THEN LET g_xccv2_d[l_ac].xccv102a = 0 END IF
   IF cl_null(g_xccv2_d[l_ac].xccv102b) THEN LET g_xccv2_d[l_ac].xccv102b = 0 END IF
   IF cl_null(g_xccv2_d[l_ac].xccv102c) THEN LET g_xccv2_d[l_ac].xccv102c = 0 END IF
   IF cl_null(g_xccv2_d[l_ac].xccv102d) THEN LET g_xccv2_d[l_ac].xccv102d = 0 END IF
   IF cl_null(g_xccv2_d[l_ac].xccv102e) THEN LET g_xccv2_d[l_ac].xccv102e = 0 END IF
   IF cl_null(g_xccv2_d[l_ac].xccv102f) THEN LET g_xccv2_d[l_ac].xccv102f = 0 END IF
   IF cl_null(g_xccv2_d[l_ac].xccv102g) THEN LET g_xccv2_d[l_ac].xccv102g = 0 END IF
   IF cl_null(g_xccv2_d[l_ac].xccv102h) THEN LET g_xccv2_d[l_ac].xccv102h = 0 END IF
   
   LET g_xccv2_d[l_ac].xccv102=g_xccv2_d[l_ac].xccv102a+g_xccv2_d[l_ac].xccv102b+g_xccv2_d[l_ac].xccv102c
                              +g_xccv2_d[l_ac].xccv102d+g_xccv2_d[l_ac].xccv102e+g_xccv2_d[l_ac].xccv102f 
                              +g_xccv2_d[l_ac].xccv102g+g_xccv2_d[l_ac].xccv102h
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
PRIVATE FUNCTION axct303_xccv102_sum_3()
   IF cl_null(g_xccv3_d[l_ac].xccv102a) THEN LET g_xccv3_d[l_ac].xccv102a = 0 END IF
   IF cl_null(g_xccv3_d[l_ac].xccv102b) THEN LET g_xccv3_d[l_ac].xccv102b = 0 END IF
   IF cl_null(g_xccv3_d[l_ac].xccv102c) THEN LET g_xccv3_d[l_ac].xccv102c = 0 END IF
   IF cl_null(g_xccv3_d[l_ac].xccv102d) THEN LET g_xccv3_d[l_ac].xccv102d = 0 END IF
   IF cl_null(g_xccv3_d[l_ac].xccv102e) THEN LET g_xccv3_d[l_ac].xccv102e = 0 END IF
   IF cl_null(g_xccv3_d[l_ac].xccv102f) THEN LET g_xccv3_d[l_ac].xccv102f = 0 END IF
   IF cl_null(g_xccv3_d[l_ac].xccv102g) THEN LET g_xccv3_d[l_ac].xccv102g = 0 END IF
   IF cl_null(g_xccv3_d[l_ac].xccv102h) THEN LET g_xccv3_d[l_ac].xccv102h = 0 END IF
   
   LET g_xccv3_d[l_ac].xccv102=g_xccv3_d[l_ac].xccv102a+g_xccv3_d[l_ac].xccv102b+g_xccv3_d[l_ac].xccv102c
                              +g_xccv3_d[l_ac].xccv102d+g_xccv3_d[l_ac].xccv102e+g_xccv3_d[l_ac].xccv102f 
                              +g_xccv3_d[l_ac].xccv102g+g_xccv3_d[l_ac].xccv102h
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
PRIVATE FUNCTION axct303_xccv102_sum_1()
   IF cl_null(g_xccv_d[l_ac].xccv102a) THEN LET g_xccv_d[l_ac].xccv102a = 0 END IF
   IF cl_null(g_xccv_d[l_ac].xccv102b) THEN LET g_xccv_d[l_ac].xccv102b = 0 END IF
   IF cl_null(g_xccv_d[l_ac].xccv102c) THEN LET g_xccv_d[l_ac].xccv102c = 0 END IF
   IF cl_null(g_xccv_d[l_ac].xccv102d) THEN LET g_xccv_d[l_ac].xccv102d = 0 END IF
   IF cl_null(g_xccv_d[l_ac].xccv102e) THEN LET g_xccv_d[l_ac].xccv102e = 0 END IF
   IF cl_null(g_xccv_d[l_ac].xccv102f) THEN LET g_xccv_d[l_ac].xccv102f = 0 END IF
   IF cl_null(g_xccv_d[l_ac].xccv102g) THEN LET g_xccv_d[l_ac].xccv102g = 0 END IF
   IF cl_null(g_xccv_d[l_ac].xccv102h) THEN LET g_xccv_d[l_ac].xccv102h = 0 END IF
   
   LET g_xccv_d[l_ac].xccv102=g_xccv_d[l_ac].xccv102a+g_xccv_d[l_ac].xccv102b+g_xccv_d[l_ac].xccv102c
                             +g_xccv_d[l_ac].xccv102d+g_xccv_d[l_ac].xccv102e+g_xccv_d[l_ac].xccv102f 
                             +g_xccv_d[l_ac].xccv102g+g_xccv_d[l_ac].xccv102h 
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
PRIVATE FUNCTION axct303_update_xccv()
   DEFINE l_rate     LIKE ooan_t.ooan005
DEFINE l_amount   LIKE xccv_t.xccv102
   LET l_amount = 0 
   LET l_rate = 1
   IF g_glaa015 = 'Y' THEN
      CALL s_aooi160_get_exrate('2',g_xccv_m.xccvld,g_today,g_glaa001,g_glaa016,0,g_glaa018)
           RETURNING l_rate
      LET g_xccv2_d[l_ac].xccv102a = g_xccv_d[l_ac].xccv102a * l_rate
      LET g_xccv2_d[l_ac].xccv102b = g_xccv_d[l_ac].xccv102b * l_rate
      LET g_xccv2_d[l_ac].xccv102c = g_xccv_d[l_ac].xccv102c * l_rate
      LET g_xccv2_d[l_ac].xccv102d = g_xccv_d[l_ac].xccv102d * l_rate
      LET g_xccv2_d[l_ac].xccv102e = g_xccv_d[l_ac].xccv102e * l_rate
      LET g_xccv2_d[l_ac].xccv102f = g_xccv_d[l_ac].xccv102f * l_rate
      LET g_xccv2_d[l_ac].xccv102g = g_xccv_d[l_ac].xccv102g * l_rate
      LET g_xccv2_d[l_ac].xccv102h = g_xccv_d[l_ac].xccv102h * l_rate
      CALL axct303_xccv102_sum_2()
      LET g_xccv2_d[l_ac].xccv102a = s_curr_round(g_xccv_m.xccvcomp,g_glaa016,g_xccv2_d[l_ac].xccv102a,2)
      LET g_xccv2_d[l_ac].xccv102b = s_curr_round(g_xccv_m.xccvcomp,g_glaa016,g_xccv2_d[l_ac].xccv102b,2)
      LET g_xccv2_d[l_ac].xccv102c = s_curr_round(g_xccv_m.xccvcomp,g_glaa016,g_xccv2_d[l_ac].xccv102c,2)
      LET g_xccv2_d[l_ac].xccv102d = s_curr_round(g_xccv_m.xccvcomp,g_glaa016,g_xccv2_d[l_ac].xccv102d,2)
      LET g_xccv2_d[l_ac].xccv102e = s_curr_round(g_xccv_m.xccvcomp,g_glaa016,g_xccv2_d[l_ac].xccv102e,2)
      LET g_xccv2_d[l_ac].xccv102f = s_curr_round(g_xccv_m.xccvcomp,g_glaa016,g_xccv2_d[l_ac].xccv102f,2)
      LET g_xccv2_d[l_ac].xccv102g = s_curr_round(g_xccv_m.xccvcomp,g_glaa016,g_xccv2_d[l_ac].xccv102g,2)
      LET g_xccv2_d[l_ac].xccv102h = s_curr_round(g_xccv_m.xccvcomp,g_glaa016,g_xccv2_d[l_ac].xccv102h,2)
      LET g_xccv2_d[l_ac].xccv102 = s_curr_round(g_xccv_m.xccvcomp,g_glaa016,g_xccv2_d[l_ac].xccv102,2)
      
       UPDATE xccv_t SET (xccvld,xccv003,xccv004,xccv005,xccv001,xccv006,xccv007,xccv008,xccv009,
                   xccv010,xccv011,xccv002,xccv101,xccv102, 
                   xccv102a,xccv102b,xccv102c,xccv102d,xccv102e,xccv102f,xccv102g,xccv102h) = (g_xccv_m.xccvld, 
                   g_xccv_m.xccv003,g_xccv_m.xccv004,g_xccv_m.xccv005,'2',g_xccv_d[l_ac].xccv006, 
                   g_xccv_d[l_ac].xccv007,g_xccv_d[l_ac].xccv008,g_xccv_d[l_ac].xccv009, 
                   g_xccv_d[l_ac].xccv010,g_xccv_d[l_ac].xccv011,g_xccv_d[l_ac].xccv002, 
                   g_xccv_d[l_ac].xccv101,g_xccv2_d[l_ac].xccv102,g_xccv2_d[l_ac].xccv102a,g_xccv2_d[l_ac].xccv102b, 
                   g_xccv2_d[l_ac].xccv102c,g_xccv2_d[l_ac].xccv102d,g_xccv2_d[l_ac].xccv102e,g_xccv2_d[l_ac].xccv102f, 
                   g_xccv2_d[l_ac].xccv102g,g_xccv2_d[l_ac].xccv102h)
                WHERE xccvent = g_enterprise AND xccvld = g_xccv_m.xccvld 
                 AND xccv003 = g_xccv_m.xccv003 
                 AND xccv004 = g_xccv_m.xccv004 
                 AND xccv005 = g_xccv_m.xccv005 
 
                 AND xccv001 = '2' #項次   
                 AND xccv002 = g_xccv_d_t.xccv002  
                 AND xccv006 = g_xccv_d_t.xccv006  
                 AND xccv007 = g_xccv_d_t.xccv007  
                 AND xccv008 = g_xccv_d_t.xccv008  
                 AND xccv009 = g_xccv_d_t.xccv009  
                 AND xccv010 = g_xccv_d_t.xccv010  
                 AND xccv011 = g_xccv_d_t.xccv011  
     
      
   END IF
   LET l_amount = 0 
   LET l_rate = 1
   IF g_glaa019 = 'Y' THEN
      CALL s_aooi160_get_exrate('2',g_xccv_m.xccvld,g_today,g_glaa001,g_glaa020,0,g_glaa022)
           RETURNING l_rate
      LET g_xccv3_d[l_ac].xccv102a = g_xccv_d[l_ac].xccv102a * l_rate
      LET g_xccv3_d[l_ac].xccv102b = g_xccv_d[l_ac].xccv102b * l_rate
      LET g_xccv3_d[l_ac].xccv102c = g_xccv_d[l_ac].xccv102c * l_rate
      LET g_xccv3_d[l_ac].xccv102d = g_xccv_d[l_ac].xccv102d * l_rate
      LET g_xccv3_d[l_ac].xccv102e = g_xccv_d[l_ac].xccv102e * l_rate
      LET g_xccv3_d[l_ac].xccv102f = g_xccv_d[l_ac].xccv102f * l_rate
      LET g_xccv3_d[l_ac].xccv102g = g_xccv_d[l_ac].xccv102g * l_rate
      LET g_xccv3_d[l_ac].xccv102h = g_xccv_d[l_ac].xccv102h * l_rate
      CALL axct303_xccv102_sum_3()
      LET g_xccv3_d[l_ac].xccv102a = s_curr_round(g_xccv_m.xccvcomp,g_glaa020,g_xccv3_d[l_ac].xccv102a,2)
      LET g_xccv3_d[l_ac].xccv102b = s_curr_round(g_xccv_m.xccvcomp,g_glaa020,g_xccv3_d[l_ac].xccv102b,2)
      LET g_xccv3_d[l_ac].xccv102c = s_curr_round(g_xccv_m.xccvcomp,g_glaa020,g_xccv3_d[l_ac].xccv102c,2)
      LET g_xccv3_d[l_ac].xccv102d = s_curr_round(g_xccv_m.xccvcomp,g_glaa020,g_xccv3_d[l_ac].xccv102d,2)
      LET g_xccv3_d[l_ac].xccv102e = s_curr_round(g_xccv_m.xccvcomp,g_glaa020,g_xccv3_d[l_ac].xccv102e,2)
      LET g_xccv3_d[l_ac].xccv102f = s_curr_round(g_xccv_m.xccvcomp,g_glaa020,g_xccv3_d[l_ac].xccv102f,2)
      LET g_xccv3_d[l_ac].xccv102g = s_curr_round(g_xccv_m.xccvcomp,g_glaa020,g_xccv3_d[l_ac].xccv102g,2)
      LET g_xccv3_d[l_ac].xccv102h = s_curr_round(g_xccv_m.xccvcomp,g_glaa020,g_xccv3_d[l_ac].xccv102h,2)
      LET g_xccv3_d[l_ac].xccv102 = s_curr_round(g_xccv_m.xccvcomp,g_glaa020,g_xccv3_d[l_ac].xccv102,2)
      
      UPDATE xccv_t SET (xccvld,xccv003,xccv004,xccv005,xccv001,xccv006,xccv007,xccv008,
          xccv009,xccv010,xccv011,xccv002,xccv101,xccv102, 
          xccv102a,xccv102b,xccv102c,xccv102d,xccv102e,xccv102f,xccv102g,xccv102h) = (g_xccv_m.xccvld, 
          g_xccv_m.xccv003,g_xccv_m.xccv004,g_xccv_m.xccv005,'3',g_xccv_d[l_ac].xccv006, 
          g_xccv_d[l_ac].xccv007,g_xccv_d[l_ac].xccv008,g_xccv_d[l_ac].xccv009, 
          g_xccv_d[l_ac].xccv010,g_xccv_d[l_ac].xccv011,g_xccv_d[l_ac].xccv002, 
          g_xccv_d[l_ac].xccv101,g_xccv3_d[l_ac].xccv102,g_xccv3_d[l_ac].xccv102a,g_xccv3_d[l_ac].xccv102b, 
          g_xccv3_d[l_ac].xccv102c,g_xccv3_d[l_ac].xccv102d,g_xccv3_d[l_ac].xccv102e,g_xccv3_d[l_ac].xccv102f, 
          g_xccv3_d[l_ac].xccv102g,g_xccv3_d[l_ac].xccv102h)
       WHERE xccvent = g_enterprise AND xccvld = g_xccv_m.xccvld 
        AND xccv003 = g_xccv_m.xccv003 
        AND xccv004 = g_xccv_m.xccv004 
        AND xccv005 = g_xccv_m.xccv005 
 
        AND xccv001 = '3' #項次   
        AND xccv002 = g_xccv_d_t.xccv002  
        AND xccv006 = g_xccv_d_t.xccv006  
        AND xccv007 = g_xccv_d_t.xccv007  
        AND xccv008 = g_xccv_d_t.xccv008  
        AND xccv009 = g_xccv_d_t.xccv009  
        AND xccv010 = g_xccv_d_t.xccv010  
        AND xccv011 = g_xccv_d_t.xccv011 

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
PRIVATE FUNCTION axct303_b_fill_2()
   #先清空單身變數內容
   CALL g_xccv2_d.clear()
 
 
   #add-point:b_fill段sql_before

   #end add-point
   
   LET g_sql = "SELECT  UNIQUE xccv001,xccv006,xccv007,xccv008,xccv009,xccv010,xccv011,xccv002,xccv101, 
       xccv102,xccv102a,xccv102b,xccv102c,xccv102d,xccv102e,xccv102f,xccv102g,xccv102h,t1.oocql004 , 
       t2.imaal003 ,t3.imaal004 ,t4.xcbfl003 FROM xccv_t",   
               "",
               
                              " LEFT JOIN oocql_t t1 ON t1.oocqlent='"||g_enterprise||"' AND t1.oocql001='221' AND t1.oocql002=xccv007 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent='"||g_enterprise||"' AND t2.imaal001=xccv009 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xccv009 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN xcbfl_t t4 ON t4.xcbflent='"||g_enterprise||"' AND t4.xcbflcomp='"||g_xccv_m.xccvcomp||"' AND t4.xcbfl001=xccv002 AND t4.xcbfl002='"||g_dlang||"' ",
 
               " WHERE xccvent= ? AND xccvld=? AND xccv003=? AND xccv004=? AND xccv005=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xccv_t")
   END IF
   
   #add-point:b_fill段sql_after
   LET g_sql = g_sql CLIPPED, " AND xccv001 = '2' " 
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axct303_fill_chk(1) THEN
      IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
         LET g_sql = g_sql, " ORDER BY xccv_t.xccv001,xccv_t.xccv002,xccv_t.xccv006,xccv_t.xccv007,xccv_t.xccv008,xccv_t.xccv009,xccv_t.xccv010,xccv_t.xccv011"
         #add-point:b_fill段fill_before

         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axct303_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR axct303_pb2
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs2 USING g_enterprise,g_xccv_m.xccvld,g_xccv_m.xccv003,g_xccv_m.xccv004,g_xccv_m.xccv005
                                               
      FOREACH b_fill_cs2 INTO g_xccv2_d[l_ac].xccv001,g_xccv2_d[l_ac].xccv006,g_xccv2_d[l_ac].xccv007,g_xccv2_d[l_ac].xccv008, 
          g_xccv2_d[l_ac].xccv009,g_xccv2_d[l_ac].xccv010,g_xccv2_d[l_ac].xccv011,g_xccv2_d[l_ac].xccv002, 
          g_xccv2_d[l_ac].xccv101,g_xccv2_d[l_ac].xccv102,g_xccv2_d[l_ac].xccv102a,g_xccv2_d[l_ac].xccv102b, 
          g_xccv2_d[l_ac].xccv102c,g_xccv2_d[l_ac].xccv102d,g_xccv2_d[l_ac].xccv102e,g_xccv2_d[l_ac].xccv102f, 
          g_xccv2_d[l_ac].xccv102g,g_xccv2_d[l_ac].xccv102h,g_xccv2_d[l_ac].xccv007_desc,g_xccv2_d[l_ac].xccv009_desc, 
          g_xccv2_d[l_ac].xccv009_desc_desc,g_xccv2_d[l_ac].xccv002_desc
                             
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
 
            CALL g_xccv2_d.deleteElement(g_xccv2_d.getLength())
 
      
   END IF
   
  
   FREE axct303_pb2   

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
PRIVATE FUNCTION axct303_b_fill_3()
   #先清空單身變數內容
   CALL g_xccv3_d.clear()
 
 
   #add-point:b_fill段sql_before

   #end add-point
   
   LET g_sql = "SELECT  UNIQUE xccv001,xccv006,xccv007,xccv008,xccv009,xccv010,xccv011,xccv002,xccv101, 
       xccv102,xccv102a,xccv102b,xccv102c,xccv102d,xccv102e,xccv102f,xccv102g,xccv102h,t1.oocql004 , 
       t2.imaal003 ,t3.imaal004 ,t4.xcbfl003 FROM xccv_t",   
               "",
               
                              " LEFT JOIN oocql_t t1 ON t1.oocqlent='"||g_enterprise||"' AND t1.oocql001='221' AND t1.oocql002=xccv007 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent='"||g_enterprise||"' AND t2.imaal001=xccv009 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xccv009 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN xcbfl_t t4 ON t4.xcbflent='"||g_enterprise||"' AND t4.xcbflcomp='"||g_xccv_m.xccvcomp||"' AND t4.xcbfl001=xccv002 AND t4.xcbfl002='"||g_dlang||"' ",
 
               " WHERE xccvent= ? AND xccvld=? AND xccv003=? AND xccv004=? AND xccv005=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xccv_t")
   END IF
   
   #add-point:b_fill段sql_after
   LET g_sql = g_sql CLIPPED, " AND xccv001 = '3' " 
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axct303_fill_chk(1) THEN
      IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
         LET g_sql = g_sql, " ORDER BY xccv_t.xccv001,xccv_t.xccv002,xccv_t.xccv006,xccv_t.xccv007,xccv_t.xccv008,xccv_t.xccv009,xccv_t.xccv010,xccv_t.xccv011"
         #add-point:b_fill段fill_before

         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axct303_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR axct303_pb3
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs3 USING g_enterprise,g_xccv_m.xccvld,g_xccv_m.xccv003,g_xccv_m.xccv004,g_xccv_m.xccv005
                                               
      FOREACH b_fill_cs3 INTO g_xccv3_d[l_ac].xccv001,g_xccv3_d[l_ac].xccv006,g_xccv3_d[l_ac].xccv007,g_xccv3_d[l_ac].xccv008, 
          g_xccv3_d[l_ac].xccv009,g_xccv3_d[l_ac].xccv010,g_xccv3_d[l_ac].xccv011,g_xccv3_d[l_ac].xccv002, 
          g_xccv3_d[l_ac].xccv101,g_xccv3_d[l_ac].xccv102,g_xccv3_d[l_ac].xccv102a,g_xccv3_d[l_ac].xccv102b, 
          g_xccv3_d[l_ac].xccv102c,g_xccv3_d[l_ac].xccv102d,g_xccv3_d[l_ac].xccv102e,g_xccv3_d[l_ac].xccv102f, 
          g_xccv3_d[l_ac].xccv102g,g_xccv3_d[l_ac].xccv102h,g_xccv3_d[l_ac].xccv007_desc,g_xccv3_d[l_ac].xccv009_desc, 
          g_xccv3_d[l_ac].xccv009_desc_desc,g_xccv3_d[l_ac].xccv002_desc
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xccv_m.xccvcomp
         LET g_ref_fields[2] = g_xccv3_d[l_ac].xccv002
         CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp=? AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xccv3_d[l_ac].xccv002_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_xccv3_d[l_ac].xccv002_desc
         #end add-point
      
         #帶出公用欄位reference值
         
         
 
        
         #add-point:單身資料抓取

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
 
            CALL g_xccv3_d.deleteElement(g_xccv3_d.getLength())
 
      
   END IF
   
  
   FREE axct303_pb3   

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
PRIVATE FUNCTION axct303_chk_ld_comp()
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_success        LIKE type_t.num5
   
   LET r_success = TRUE

#只检查法人
   IF g_xccv_m.xccvld IS NULL AND g_xccv_m.xccvcomp IS NOT NULL THEN   
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
      
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_xccv_m.xccvcomp
         
      #呼叫檢查存在並帶值的library
      IF cl_chk_exist("v_ooef001_1") THEN
         #檢查成功時後續處理
         #LET  = g_chkparam.return1
         #DISPLAY BY NAME 
      ELSE
         #檢查失敗時後續處理
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF

#只检查账套
   IF g_xccv_m.xccvld IS NOT NULL AND g_xccv_m.xccvcomp IS NULL THEN
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
      
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_xccv_m.xccvld
      #160318-00025#12--add--str
      LET g_errshow = TRUE 
      LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
      #160318-00025#12--add--end   
      #呼叫檢查存在並帶值的library
      IF cl_chk_exist("v_glaald") THEN
         #檢查成功時後續處理
         #LET  = g_chkparam.return1
         #DISPLAY BY NAME 
         CALL s_ld_chk_authorization(g_user,g_xccv_m.xccvld) RETURNING l_success
         IF l_success = FALSE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'axr-00022'
            LET g_errparam.extend = g_xccv_m.xccvld
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF 
      ELSE
         #檢查失敗時後續處理
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF

#法人账套都存在，检查他们的关系
   IF NOT s_ld_chk_comp(g_xccv_m.xccvld,g_xccv_m.xccvcomp) THEN  #v_glaald_5 
      LET g_xccv_m.xccvcomp = g_xccv_m_t.xccvcomp
      LET r_success = FALSE
      RETURN r_success
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
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axct303_ref()
    IF g_xccv_m.xccvcomp IS NULL THEN     
      
      SELECT glaacomp
        INTO g_xccv_m.xccvcomp
        FROM glaa_t  
       WHERE glaaent = g_enterprise 
         AND glaald = g_xccv_m.xccvld
      DISPLAY BY NAME g_xccv_m.xccvcomp      
      SELECT glaa010,glaa011 INTO g_xccv_m.xccv004,g_xccv_m.xccv005
       FROM glaa_t
       WHERE glaaent  = g_enterprise
         AND glaacomp = g_xccv_m.xccvcomp
         AND glaa014 = 'Y'
      DISPLAY BY NAME g_xccv_m.xccv004,g_xccv_m.xccv005
   ELSE
      IF g_xccv_m.xccvld IS NULL THEN  
         SELECT glaald,glaa010,glaa011 INTO g_xccv_m.xccvld,g_xccv_m.xccv004,g_xccv_m.xccv005
          FROM glaa_t
          WHERE glaaent  = g_enterprise
            AND glaacomp = g_xccv_m.xccvcomp
            AND glaa014 = 'Y'
         DISPLAY BY NAME g_xccv_m.xccvld,g_xccv_m.xccv004,g_xccv_m.xccv005
      END IF
   END IF
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xccv_m.xccvcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccv_m.xccvcomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccv_m.xccvcomp_desc   
       
 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xccv_m.xccvld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccv_m.xccvld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccv_m.xccvld_desc   
   
   
   
   INITIALIZE g_ref_fields TO NULL                                                                                                                                                      
   LET g_ref_fields[1] = g_xccv_m.xccv003                                                                                                                                   
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccv_m.xccv003_desc = '', g_rtn_fields[1] , ''                                                                                                                     
   DISPLAY BY NAME g_xccv_m.xccv003_desc 
   
    SELECT glaa001,glaa003,glaa015,glaa016,glaa018,glaa019,glaa020,glaa022,glaa025 
     INTO g_glaa001,g_glaa003,g_glaa015,g_glaa016,g_glaa018,g_glaa019,g_glaa020,g_glaa022,g_glaa025 
     FROM glaa_t
    WHERE glaaent = g_enterprise 
      AND glaald = g_xccv_m.xccvld
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
PRIVATE FUNCTION axct303_before_delete_2()
   
      
   #add-point:單筆刪除中
   
      DELETE FROM xccv_t
       WHERE xccvent = g_enterprise AND xccvld = g_xccv_m.xccvld AND
                                 xccv003 = g_xccv_m.xccv003 AND
                                 xccv004 = g_xccv_m.xccv004 AND
                                 xccv005 = g_xccv_m.xccv005 
         AND xccv002 = g_xccv2_d_t.xccv002
         AND xccv006 = g_xccv2_d_t.xccv006
         AND xccv007 = g_xccv2_d_t.xccv007
         AND xccv008 = g_xccv2_d_t.xccv008
         AND xccv009 = g_xccv2_d_t.xccv009
         AND xccv010 = g_xccv2_d_t.xccv010
         AND xccv011 = g_xccv2_d_t.xccv011
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccv_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE 
   END IF
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
PRIVATE FUNCTION axct303_before_delete_3()
   DELETE FROM xccv_t
       WHERE xccvent = g_enterprise AND xccvld = g_xccv_m.xccvld AND
                                 xccv003 = g_xccv_m.xccv003 AND
                                 xccv004 = g_xccv_m.xccv004 AND
                                 xccv005 = g_xccv_m.xccv005 
         AND xccv002 = g_xccv3_d_t.xccv002
         AND xccv006 = g_xccv3_d_t.xccv006
         AND xccv007 = g_xccv3_d_t.xccv007
         AND xccv008 = g_xccv3_d_t.xccv008
         AND xccv009 = g_xccv3_d_t.xccv009
         AND xccv010 = g_xccv3_d_t.xccv010
         AND xccv011 = g_xccv3_d_t.xccv011
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccv_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE 
   END IF
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
PRIVATE FUNCTION axct303_s01()
DEFINE p_xrad001      LIKE xrad_t.xrad001
DEFINE l_xradl003     LIKE type_t.chr80
DEFINE ls_str          STRING
DEFINE l_chr           LIKE type_t.chr1   
DEFINE l_chr1          LIKE type_t.chr1  
DEFINE l_num           LIKE type_t.num5
   
   OPEN WINDOW w_axct303_s01 WITH FORM cl_ap_formpath("axc","axct303_s01")
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #輸入開始
      INPUT BY NAME g_xccv_s.name,g_xccv_s.dir
         BEFORE INPUT
           


         AFTER INPUT
            

      END INPUT

      DISPLAY ARRAY g_xccv5_d TO s_detail5.* ATTRIBUTES(COUNT=g_rec_b)  

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail5")
               LET l_ac = g_detail_idx
               
               #add-point:page1自定義行為

               #end add-point
            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               
               LET g_current_page = 5
               
         
         END DISPLAY  
         
      ON ACTION close
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION exit
         LET INT_FLAG = TRUE
         EXIT DIALOG
      
      
      ON ACTION browser1
         CALL cl_client_browse_dir() RETURNING g_xccv_s.dir
         LET ls_str = g_xccv_s.dir
         #抓取目录斜杆
         LET l_num =ls_str.getIndexOf(':',1)                                    #抓取：后的字符位置
         LET l_chr = ls_str.substring(l_num+1,l_num+1)                          #截取冒号后的字符 
         LET l_chr1 = ls_str.substring(ls_str.getLength(),ls_str.getLength())   #判断是否为根目录
         IF l_chr <> l_chr1  THEN         
            LET g_xccv_s.dir = g_xccv_s.dir||l_chr 
         ELSE
            LET g_xccv_s.dir = g_xccv_s.dir 
         END IF 
         DISPLAY BY NAME g_xccv_s.dir
         
      ON ACTION produce
         LET w = ui.Window.getCurrent()
         LET f = w.getForm()
         LET page = f.FindNode("Page","bpage_1")
         CALL axct303_excelexample(page,base.TypeInfo.create(g_xccv5_d),'Y')
         ACCEPT DIALOG 

      ON ACTION off
         LET INT_FLAG = TRUE
         EXIT DIALOG


   END DIALOG

   



      #畫面關閉
      CLOSE WINDOW w_axct303_s01
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
PRIVATE FUNCTION axct303_excelexample(n,t,p_show_hidden)
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
   LET xls_name = g_xccv_s.name CLIPPED,".xls"

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
            IF l_field_name= 'xccv_t.xccvent' OR l_field_name= 'xccv_t.xccvld' OR
               l_field_name= 'xccv_t.xccvcomp' OR l_field_name= 'xccv_t.xccv001' OR  
               l_field_name= 'xccv_t.xccv004' OR l_field_name= 'xccv_t.xccv005' OR
               l_field_name= 'xccv_t.xccv003' OR l_field_name= 'xccv_t.xccv006' OR
               l_field_name= 'xccv_t.xccv007' OR l_field_name= 'xccv_t.xccv008' OR
               l_field_name= 'xccv_t.xccv009' OR l_field_name= 'xccv_t.xccv002' OR
               l_field_name= 'xccv_t.xccv010' OR l_field_name= 'xccv_t.xccv011' OR 
               l_field_name= 'xccv_t.xccv101' OR l_field_name= 'xccv_t.xccv102' OR
               l_field_name= 'xccv_t.xccv102a' OR l_field_name= 'xccv_t.xccv102b' OR
               l_field_name= 'xccv_t.xccv102c' OR l_field_name= 'xccv_t.xccv102d' OR
               l_field_name= 'xccv_t.xccv102e' OR l_field_name= 'xccv_t.xccv102f' OR
               l_field_name= 'xccv_t.xccv102g' OR l_field_name= 'xccv_t.xccv102h' OR
               l_field_name = 'formonly.xccv102_1' OR l_field_name = 'formonly.xccv102a_1' OR
               l_field_name = 'formonly.xccv102b_1' OR l_field_name = 'formonly.xccv102c_1' OR
               l_field_name = 'formonly.xccv102d_1' OR l_field_name = 'formonly.xccv102e_1' OR
               l_field_name = 'formonly.xccv102f_1' OR l_field_name = 'formonly.xccv102g_1' OR
               l_field_name = 'formonly.xccv102h_1' OR l_field_name = 'formonly.xccv102_2' OR
               l_field_name = 'formonly.xccv102a_2' OR l_field_name = 'formonly.xccv102b_2' OR
               l_field_name = 'formonly.xccv102c_2' OR l_field_name = 'formonly.xccv102d_2' OR
               l_field_name = 'formonly.xccv102e_2' OR l_field_name = 'formonly.xccv102f_2' OR
               l_field_name = 'formonly.xccv102g_2' OR l_field_name = 'formonly.xccv102h_2' 
                 
               THEN
               LET values = n1_text.getAttribute("text")
               LET l_str = "<td>",axct303_add_span(values),"</td>"
               CALL l_channel.write(l_str CLIPPED)
            END IF
         ELSE
            LET g_hidden[i] = "1"
            LET k = k -1
         END IF
      END FOR
      IF h=1 THEN CALL axct303_get_boday(h,cnt_header,t,combo_arr,l_seq) END IF

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
PRIVATE FUNCTION axct303_s02()
DEFINE l_excel         STRING 
DEFINE ls_str          STRING
DEFINE l_chr           LIKE type_t.chr1   
DEFINE l_chr1          LIKE type_t.chr1   
DEFINE l_num           LIKE type_t.num5
DEFINE l_n             LIKE type_t.num5
DEFINE l_success       LIKE type_t.num5
   #畫面開啟 (identifier)

   OPEN WINDOW w_axct303_s02 WITH FORM cl_ap_formpath("axc","axct303_s02")

   INITIALIZE g_xccv_f.* LIKE xccv_t.*
   
   LET g_xccv_f_t.xccvcomp = NULL
   LET g_xccv_f_t.xccvld = NULL
   LET g_xccv_f_t.format = NULL
   LET g_xccv_f_t.char = NULL
   LET g_xccv_f_t.dir = NULL
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_xccv_f.xccvcomp,g_xccv_f.xccvld,g_xccv_f.format,g_xccv_f.char,g_xccv_f.dir ATTRIBUTE(WITHOUT  DEFAULTS)

         BEFORE INPUT
            CALL cl_set_combo_scc('format','8915')
 
         AFTER FIELD xccvcomp
            IF NOT cl_null(g_xccv_f.xccvcomp) THEN               
                  IF NOT axct303_s02_chk_ld_comp() THEN
                     LET g_xccv_f.xccvcomp = g_xccv_f_t.xccvcomp
                     NEXT FIELD CURRENT
                  END IF
               END IF
            
             CALL axct303_s02_ref()
            
 

         AFTER FIELD xccvld
            IF NOT cl_null(g_xccv_f.xccvld) THEN
               
                  IF NOT axct303_s02_chk_ld_comp() THEN
                     LET g_xccv_f.xccvld = g_xccv_f_t.xccvld
                     NEXT FIELD CURRENT
                  END IF
               
            END IF
                      
            
            
          CALL axct303_s02_ref()
 
         ON ACTION controlp INFIELD xccvcomp
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccv_f.xccvcomp             #給予default值
           
            #帳套不為空時，法人組織開窗開帳套歸屬法人的法人組織
            IF NOT cl_null(g_xccv_f.xccvld) THEN
               LET g_qryparam.where = " ooef017 = (SELECT glaacomp FROM glaa_t",
                                      "  WHERE glaaent = '",g_enterprise,"' AND glaald = '",g_xccv_f.xccvld,"' ) AND ooef003 = 'Y' "
            END IF
            
            #--161013-00051#1 By shiun--(S)
#            CALL q_ooef001_8()                                #呼叫開窗
            CALL q_ooef001_2()
            #--161013-00051#1 By shiun--(E)

            LET g_xccv_f.xccvcomp = g_qryparam.return1              
 
            CALL axct303_s02_ref()
 
            DISPLAY g_xccv_f.xccvcomp TO xccvcomp 
            DISPLAY g_xccv_f.xccvcomp_desc TO xccvcomp_desc              #
 
            LET g_qryparam.where = "" 
   
            NEXT FIELD xccvcomp                          #返回原欄位

 
         ON ACTION controlp INFIELD xccvld
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccv_f.xccvld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            
            #法人不為空時，帳套開窗開此法人的下屬帳套
            IF NOT cl_null(g_xccv_f.xccvcomp) THEN
               LET g_qryparam.where = " glaacomp = '",g_xccv_f.xccvcomp,"'"
            END IF
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xccv_f.xccvld = g_qryparam.return1              

            CALL axct303_s02_ref()
            
            DISPLAY g_xccv_f.xccvld TO xccvld
            DISPLAY g_xccv_f.xccvld_desc TO xccvld_desc              #

            NEXT FIELD xccvld                          #返回原欄位
 
 
 
         AFTER INPUT
         
            
      END INPUT
    
    
      ON ACTION browser
         CALL cl_client_browse_file() RETURNING g_xccv_f.dir
         LET ls_str = g_xccv_f.dir
         #抓取目录斜杆
         LET l_num =ls_str.getIndexOf(':',1)                                    #抓取：后的字符位置
         LET l_chr = ls_str.substring(l_num+1,l_num+1)                          #截取冒号后的字符 
         LET l_chr1 = ls_str.substring(ls_str.getLength(),ls_str.getLength())   #判断是否为根目录

         LET g_xccv_f.dir = g_xccv_f.dir

         DISPLAY BY NAME g_xccv_f.dir

 
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
   CLOSE WINDOW w_axct303_s02 
   
   CALL axct303_s02_ins_excel(g_xccv_f.dir) RETURNING l_success
   RETURN l_success
 
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
PRIVATE FUNCTION axct303_s02_ins_excel(p_excelname)
   DEFINE p_excelname LIKE type_t.chr1000  #excel档名
DEFINE r_success   LIKE type_t.num5
DEFINE l_excelname STRING               #excel档名
DEFINE l_count     LIKE type_t.num10
DEFINE li_i        LIKE type_t.num10
DEFINE li_j        LIKE type_t.num10
DEFINE xlapp,iRes,iRow    LIKE type_t.num5
#161109-00085#22-s mod
#DEFINE l_xccv      RECORD LIKE xccv_t.*   #161109-00085#22-s mark
DEFINE l_xccv      RECORD  #在製元件製程成本期初開帳檔
       xccvent LIKE xccv_t.xccvent, #企業編號
       xccvcomp LIKE xccv_t.xccvcomp, #法人組織
       xccvld LIKE xccv_t.xccvld, #帳套
       xccv001 LIKE xccv_t.xccv001, #帳套本位幣順序
       xccv002 LIKE xccv_t.xccv002, #成本域
       xccv003 LIKE xccv_t.xccv003, #成本計算類型
       xccv004 LIKE xccv_t.xccv004, #年度
       xccv005 LIKE xccv_t.xccv005, #期別
       xccv006 LIKE xccv_t.xccv006, #工單編號/在製編號
       xccv007 LIKE xccv_t.xccv007, #作業編號
       xccv008 LIKE xccv_t.xccv008, #作業序
       xccv009 LIKE xccv_t.xccv009, #料號
       xccv010 LIKE xccv_t.xccv010, #特性
       xccv011 LIKE xccv_t.xccv011, #批號
       xccv020 LIKE xccv_t.xccv020, #核算幣別
       xccv101 LIKE xccv_t.xccv101, #期末結存數量
       xccv102 LIKE xccv_t.xccv102, #期末結存金額
       xccv102a LIKE xccv_t.xccv102a, #期末結存金額-材料
       xccv102b LIKE xccv_t.xccv102b, #期末結存金額-人工
       xccv102c LIKE xccv_t.xccv102c, #期末結存金額-加工
       xccv102d LIKE xccv_t.xccv102d, #期末結存金額-制費一
       xccv102e LIKE xccv_t.xccv102e, #期末結存金額-制費二
       xccv102f LIKE xccv_t.xccv102f, #期末結存金額-制費三
       xccv102g LIKE xccv_t.xccv102g, #期末結存金額-制費四
       xccv102h LIKE xccv_t.xccv102h  #期末結存金額-制費五
          END RECORD
#161109-00085#22-e mod
DEFINE l_today     LIKE type_t.dat       #zll g_today 没有了
DEFINE l_n         LIKE type_t.num5

DEFINE l_xccvcrtdt    DATETIME YEAR TO SECOND
#161109-00085#22-s mod
#DEFINE l_xccv1      RECORD LIKE xccv_t.*   #161109-00085#22-s mark
DEFINE l_xccv1      RECORD  #在製元件製程成本期初開帳檔
       xccvent LIKE xccv_t.xccvent, #企業編號
       xccvcomp LIKE xccv_t.xccvcomp, #法人組織
       xccvld LIKE xccv_t.xccvld, #帳套
       xccv001 LIKE xccv_t.xccv001, #帳套本位幣順序
       xccv002 LIKE xccv_t.xccv002, #成本域
       xccv003 LIKE xccv_t.xccv003, #成本計算類型
       xccv004 LIKE xccv_t.xccv004, #年度
       xccv005 LIKE xccv_t.xccv005, #期別
       xccv006 LIKE xccv_t.xccv006, #工單編號/在製編號
       xccv007 LIKE xccv_t.xccv007, #作業編號
       xccv008 LIKE xccv_t.xccv008, #作業序
       xccv009 LIKE xccv_t.xccv009, #料號
       xccv010 LIKE xccv_t.xccv010, #特性
       xccv011 LIKE xccv_t.xccv011, #批號
       xccv020 LIKE xccv_t.xccv020, #核算幣別
       xccv101 LIKE xccv_t.xccv101, #期末結存數量
       xccv102 LIKE xccv_t.xccv102, #期末結存金額
       xccv102a LIKE xccv_t.xccv102a, #期末結存金額-材料
       xccv102b LIKE xccv_t.xccv102b, #期末結存金額-人工
       xccv102c LIKE xccv_t.xccv102c, #期末結存金額-加工
       xccv102d LIKE xccv_t.xccv102d, #期末結存金額-制費一
       xccv102e LIKE xccv_t.xccv102e, #期末結存金額-制費二
       xccv102f LIKE xccv_t.xccv102f, #期末結存金額-制費三
       xccv102g LIKE xccv_t.xccv102g, #期末結存金額-制費四
       xccv102h LIKE xccv_t.xccv102h  #期末結存金額-制費五
          END RECORD
#161109-00085#22-e mod
#161109-00085#22-s mod
#DEFINE l_xccv2      RECORD LIKE xccv_t.*   #161109-00085#22-s mark
DEFINE l_xccv2      RECORD  #在製元件製程成本期初開帳檔
       xccvent LIKE xccv_t.xccvent, #企業編號
       xccvcomp LIKE xccv_t.xccvcomp, #法人組織
       xccvld LIKE xccv_t.xccvld, #帳套
       xccv001 LIKE xccv_t.xccv001, #帳套本位幣順序
       xccv002 LIKE xccv_t.xccv002, #成本域
       xccv003 LIKE xccv_t.xccv003, #成本計算類型
       xccv004 LIKE xccv_t.xccv004, #年度
       xccv005 LIKE xccv_t.xccv005, #期別
       xccv006 LIKE xccv_t.xccv006, #工單編號/在製編號
       xccv007 LIKE xccv_t.xccv007, #作業編號
       xccv008 LIKE xccv_t.xccv008, #作業序
       xccv009 LIKE xccv_t.xccv009, #料號
       xccv010 LIKE xccv_t.xccv010, #特性
       xccv011 LIKE xccv_t.xccv011, #批號
       xccv020 LIKE xccv_t.xccv020, #核算幣別
       xccv101 LIKE xccv_t.xccv101, #期末結存數量
       xccv102 LIKE xccv_t.xccv102, #期末結存金額
       xccv102a LIKE xccv_t.xccv102a, #期末結存金額-材料
       xccv102b LIKE xccv_t.xccv102b, #期末結存金額-人工
       xccv102c LIKE xccv_t.xccv102c, #期末結存金額-加工
       xccv102d LIKE xccv_t.xccv102d, #期末結存金額-制費一
       xccv102e LIKE xccv_t.xccv102e, #期末結存金額-制費二
       xccv102f LIKE xccv_t.xccv102f, #期末結存金額-制費三
       xccv102g LIKE xccv_t.xccv102g, #期末結存金額-制費四
       xccv102h LIKE xccv_t.xccv102h  #期末結存金額-制費五
          END RECORD
#161109-00085#22-e mod

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
            FOR li_i = 2 TO iRow
                INITIALIZE l_xccv.* TO NULL
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',1).Value'],[l_xccv.xccvent])   
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',2).Value'],[l_xccv.xccvld])    
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',3).Value'],[l_xccv.xccvcomp]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',4).Value'],[l_xccv.xccv001])  
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',5).Value'],[l_xccv.xccv002])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',6).Value'],[l_xccv.xccv003]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',7).Value'],[l_xccv.xccv004])   
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',8).Value'],[l_xccv.xccv005])        
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',9).Value'],[l_xccv.xccv006])   
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',10).Value'],[l_xccv.xccv007])   
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',11).Value'],[l_xccv.xccv008])                   
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',12).Value'],[l_xccv.xccv009])                 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',13).Value'],[l_xccv.xccv010])                  
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',14).Value'],[l_xccv.xccv011])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',15).Value'],[l_xccv.xccv101])   
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',16).Value'],[l_xccv.xccv102])                 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',17).Value'],[l_xccv.xccv102a])                 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',18).Value'],[l_xccv.xccv102b])                 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',19).Value'],[l_xccv.xccv102c])                  
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',20).Value'],[l_xccv.xccv102d])  
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',21).Value'],[l_xccv.xccv102e])  
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',22).Value'],[l_xccv.xccv102f])  
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',23).Value'],[l_xccv.xccv102g])  
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',24).Value'],[l_xccv.xccv102h])  
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',25).Value'],[l_xccv1.xccv102])  
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',26).Value'],[l_xccv1.xccv102a]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',27).Value'],[l_xccv1.xccv102b]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',28).Value'],[l_xccv1.xccv102c]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',29).Value'],[l_xccv1.xccv102d]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',30).Value'],[l_xccv1.xccv102e]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',31).Value'],[l_xccv1.xccv102f]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',32).Value'],[l_xccv1.xccv102g]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',33).Value'],[l_xccv1.xccv102h]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',34).Value'],[l_xccv2.xccv102])  
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',35).Value'],[l_xccv2.xccv102a]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',36).Value'],[l_xccv2.xccv102b]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',37).Value'],[l_xccv2.xccv102c]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',38).Value'],[l_xccv2.xccv102d]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',39).Value'],[l_xccv2.xccv102e]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',40).Value'],[l_xccv2.xccv102f]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',41).Value'],[l_xccv2.xccv102g]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',42).Value'],[l_xccv2.xccv102h]) 
                
                               
                
                #如果excel中存在不在畫面上的法人或者帳套CONTINUE
                IF l_xccv.xccvld != g_xccv_f.xccvld OR l_xccv.xccvcomp != g_xccv_f.xccvcomp THEN
                  #CONTINUE FOR
                  #匯出畫面中帳套不一致的，提示檢核訊息，不予新增
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'axc-00514'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()

                   LET r_success = FALSE
                   EXIT FOR
                END IF
                

                #赋默认值
                LET l_xccv.xccv001 = '1'  #本位幣               
                
                

                IF l_xccv.xccv008 IS NULL THEN  #key值批号可录入为空
                   LET l_xccv.xccv008 = ' '
                END IF
                IF l_xccv.xccv007 IS NULL THEN  #key值特性可录入为空
                   LET l_xccv.xccv007 = ' '
                END IF 
                IF l_xccv.xccv002 IS NULL THEN 
                   LET l_xccv.xccv002 = ' '
                END IF
                IF l_xccv.xccv010 IS NULL THEN  
                   LET l_xccv.xccv010 = ' '
                END IF
                IF l_xccv.xccv011 IS NULL THEN  
                   LET l_xccv.xccv011 = ' '
                END IF                
                #本位幣一 
                #161109-00085#22-s mod                
#                INSERT INTO xccv_t VALUES l_xccv.*   #161109-00085#22-s mark
                INSERT INTO xccv_t (xccvent,xccvcomp,xccvld,xccv001,xccv002,xccv003,xccv004,xccv005,xccv006,
                                    xccv007,xccv008,xccv009,xccv010,xccv011,xccv020,xccv101,xccv102,xccv102a,
                                    xccv102b,xccv102c,xccv102d,xccv102e,xccv102f,xccv102g,xccv102h)
                            VALUES (l_xccv.xccvent,l_xccv.xccvcomp,l_xccv.xccvld,l_xccv.xccv001,l_xccv.xccv002,
                                    l_xccv.xccv003,l_xccv.xccv004,l_xccv.xccv005,l_xccv.xccv006,l_xccv.xccv007,
                                    l_xccv.xccv008,l_xccv.xccv009,l_xccv.xccv010,l_xccv.xccv011,l_xccv.xccv020,
                                    l_xccv.xccv101,l_xccv.xccv102,l_xccv.xccv102a,l_xccv.xccv102b,l_xccv.xccv102c,
                                    l_xccv.xccv102d,l_xccv.xccv102e,l_xccv.xccv102f,l_xccv.xccv102g,l_xccv.xccv102h)
                #161109-00085#22-e mod
                IF SQLCA.sqlcode THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = SQLCA.sqlcode
                   LET g_errparam.extend = 'ins xccv'
                   LET g_errparam.popup = FALSE
                   CALL cl_err()

                   LET r_success = FALSE
                   EXIT FOR
                END IF

                SELECT glaa015,glaa019
                  INTO g_glaa015,g_glaa019
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = l_xccv.xccvld
                #本位幣二
                IF g_glaa015 = 'Y' THEN                   
                   IF cl_null(l_xccv1.xccv102)  THEN LET l_xccv1.xccv102  = 0 END IF 
                   IF cl_null(l_xccv1.xccv102a) THEN LET l_xccv1.xccv102a = 0 END IF 
                   IF cl_null(l_xccv1.xccv102b) THEN LET l_xccv1.xccv102b = 0 END IF 
                   IF cl_null(l_xccv1.xccv102c) THEN LET l_xccv1.xccv102c = 0 END IF 
                   IF cl_null(l_xccv1.xccv102d) THEN LET l_xccv1.xccv102d = 0 END IF 
                   IF cl_null(l_xccv1.xccv102e) THEN LET l_xccv1.xccv102e = 0 END IF 
                   IF cl_null(l_xccv1.xccv102f) THEN LET l_xccv1.xccv102f = 0 END IF 
                   IF cl_null(l_xccv1.xccv102g) THEN LET l_xccv1.xccv102g = 0 END IF 
                   IF cl_null(l_xccv1.xccv102h) THEN LET l_xccv1.xccv102h = 0 END IF 
                  
                   INSERT INTO xccv_t(xccvent,xccvld,xccvcomp,xccv001,xccv004,xccv005,xccv003,xccv006,xccv007,
                                      xccv008,xccv009,xccv010,xccv011,xccv002,xccv101,xccv102,
                                      xccv102a,xccv102b,xccv102c,xccv102d,xccv102e,
                                      xccv102f,xccv102g,xccv102h) 
                               VALUES(l_xccv.xccvent,l_xccv.xccvld,l_xccv.xccvcomp,'2',l_xccv.xccv004,l_xccv.xccv005,l_xccv.xccv003,l_xccv.xccv006,l_xccv.xccv007,
                                      l_xccv.xccv008,l_xccv.xccv009,l_xccv.xccv010,l_xccv.xccv011,l_xccv.xccv002,l_xccv.xccv101,l_xccv1.xccv102,
                                      l_xccv1.xccv102a,l_xccv1.xccv102b,l_xccv1.xccv102c,l_xccv1.xccv102d,
                                      l_xccv1.xccv102e,l_xccv1.xccv102f,l_xccv1.xccv102g,l_xccv1.xccv102h) 
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'ins xccv 2'
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     LET r_success = FALSE
                     EXIT FOR
                  END IF                                      
                END IF
                #本位幣三
                IF g_glaa019 = 'Y' THEN 
                                  
                   IF cl_null(l_xccv2.xccv102)  THEN LET l_xccv2.xccv102  = 0 END IF 
                   IF cl_null(l_xccv2.xccv102a) THEN LET l_xccv2.xccv102a = 0 END IF 
                   IF cl_null(l_xccv2.xccv102b) THEN LET l_xccv2.xccv102b = 0 END IF 
                   IF cl_null(l_xccv2.xccv102c) THEN LET l_xccv2.xccv102c = 0 END IF 
                   IF cl_null(l_xccv2.xccv102d) THEN LET l_xccv2.xccv102d = 0 END IF 
                   IF cl_null(l_xccv2.xccv102e) THEN LET l_xccv2.xccv102e = 0 END IF 
                   IF cl_null(l_xccv2.xccv102f) THEN LET l_xccv2.xccv102f = 0 END IF 
                   IF cl_null(l_xccv2.xccv102g) THEN LET l_xccv2.xccv102g = 0 END IF 
                   IF cl_null(l_xccv2.xccv102h) THEN LET l_xccv2.xccv102h = 0 END IF 
                  
                   INSERT INTO xccv_t(xccvent,xccvld,xccvcomp,xccv001,xccv004,xccv005,xccv003,xccv006,xccv007,
                                      xccv008,xccv009,xccv010,xccv011,xccv002,xccv101,xccv102,xccv102a,
                                      xccv102b,xccv102c,xccv102d,xccv102e,
                                      xccv102f,xccv102g,xccv102h) 
                               VALUES(l_xccv.xccvent,l_xccv.xccvld,l_xccv.xccvcomp,'3',l_xccv.xccv004,l_xccv.xccv005,l_xccv.xccv003,l_xccv.xccv006,l_xccv.xccv007,
                                      l_xccv.xccv008,l_xccv.xccv009,l_xccv.xccv010,l_xccv.xccv011,l_xccv.xccv002,l_xccv.xccv101,l_xccv2.xccv102,
                                      l_xccv2.xccv102a,l_xccv2.xccv102b,l_xccv2.xccv102c,l_xccv2.xccv102d,
                                      l_xccv2.xccv102e,l_xccv2.xccv102f,l_xccv2.xccv102g,l_xccv2.xccv102h) 
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'ins xccv 3'
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     LET r_success = FALSE
                     EXIT FOR
                  END IF                  
                END IF
            END FOR
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
PRIVATE FUNCTION axct303_add_span(p_str)
   DEFINE p_str    STRING
DEFINE l_str    STRING


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
PRIVATE FUNCTION axct303_get_boday(p_h,p_cnt_header,s,s_combo_arr,p_seq)
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
   LET window_path = g_xccv_s.dir,"\\",xls_name CLIPPED
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
PRIVATE FUNCTION axct303_s02_ref()
   IF g_xccv_f.xccvcomp IS NULL THEN     
      SELECT glaacomp
        INTO g_xccv_f.xccvcomp
        FROM glaa_t  
       WHERE glaaent = g_enterprise 
         AND glaald = g_xccv_f.xccvld
      DISPLAY BY NAME g_xccv_f.xccvcomp   
   ELSE
      IF g_xccv_f.xccvld IS NULL THEN
          SELECT glaald INTO g_xccv_f.xccvld
          FROM glaa_t
          WHERE glaaent  = g_enterprise
            AND glaacomp = g_xccv_f.xccvcomp
            AND glaa014 = 'Y'
         DISPLAY BY NAME g_xccv_f.xccvld
      END IF
   END IF
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xccv_f.xccvcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccv_f.xccvcomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccv_f.xccvcomp_desc   
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xccv_f.xccvld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccv_f.xccvld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccv_f.xccvld_desc   
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
PRIVATE FUNCTION axct303_s02_chk_ld_comp()
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_success        LIKE type_t.num5
   
   LET r_success = TRUE

#只检查法人
   IF g_xccv_f.xccvld IS NULL AND g_xccv_f.xccvcomp IS NOT NULL THEN   
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
      
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_xccv_f.xccvcomp
         
      #呼叫檢查存在並帶值的library
      IF cl_chk_exist("v_ooef001_1") THEN
         #檢查成功時後續處理
         #LET  = g_chkparam.return1
         #DISPLAY BY NAME 
      ELSE
         #檢查失敗時後續處理
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF

#只检查账套
   IF g_xccv_f.xccvld IS NOT NULL AND g_xccv_f.xccvcomp IS NULL THEN
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
      
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_xccv_f.xccvld
      #160318-00025#12--add--str
      LET g_errshow = TRUE 
      LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
      #160318-00025#12--add--end   
      #呼叫檢查存在並帶值的library
      IF cl_chk_exist("v_glaald") THEN
         #檢查成功時後續處理
         #LET  = g_chkparam.return1
         #DISPLAY BY NAME 
         CALL s_ld_chk_authorization(g_user,g_xccv_f.xccvld) RETURNING l_success
         IF l_success = FALSE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'axr-00022'
            LET g_errparam.extend = g_xccv_f.xccvld
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF 
      ELSE
         #檢查失敗時後續處理
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF

#法人账套都存在，检查他们的关系
   IF NOT s_ld_chk_comp(g_xccv_f.xccvld,g_xccv_f.xccvcomp) THEN  #v_glaald_5 
      LET g_xccv_f.xccvcomp = g_xccv_f_t.xccvcomp
      LET r_success = FALSE
      RETURN r_success
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
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axct303_chk_year_period()
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_bdate          LIKE type_t.dat    #起始年度+期別對應的起始截止日期
   DEFINE l_edate          LIKE type_t.dat
   DEFINE l_glaa003        LIKE glaa_t.glaa003
   DEFINE l_date  DATE
   DEFINE l_cnt            LIKE type_t.num5
   LET r_success = TRUE 
   #抓出会计周期参考表号  glaa003
   SELECT glaa003 INTO l_glaa003
        FROM glaa_t
       WHERE glaaent  = g_enterprise
         AND glaacomp = g_xccv_m.xccvcomp
         AND glaa014  = 'Y'   
   IF g_xccv_m.xccv004 IS NOT NULL  THEN
      IF NOT s_fin_date_chk_year(g_xccv_m.xccv004) THEN  
         LET r_success = FALSE
         RETURN r_success      
      END IF
      SELECT COUNT(*) INTO l_cnt FROM glav_t
      WHERE glavent = g_enterprise
        AND glav001 = l_glaa003
        AND glav002 = g_xccv_m.xccv004
        AND glavstus = 'Y' 
      IF l_cnt = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axc-00581'
         LET g_errparam.extend = g_xccv_m.xccv004
         LET g_errparam.popup = TRUE
         CALL cl_err() 
         LET r_success = FALSE
         RETURN r_success 
      END IF
   END IF
   

   IF g_xccv_m.xccv004 IS NOT NULL AND g_xccv_m.xccv005 IS NOT NULL THEN
      IF NOT s_fin_date_chk_period(l_glaa003,g_xccv_m.xccv004,g_xccv_m.xccv005) THEN
         LET r_success = FALSE
         RETURN r_success      
      END IF
      CALL s_fin_date_get_period_range(l_glaa003,g_xccv_m.xccv004,g_xccv_m.xccv005) RETURNING l_bdate,l_edate
      
      IF NOT s_date_chk_close(l_edate,'2') THEN
         LET r_success = FALSE
         RETURN r_success      
      END IF
   END IF
   
   IF NOT cl_null(g_xccv_m.xccv004) AND NOT cl_null(g_xccv_m.xccvcomp) THEN
      #檢查年度不小於成本關賬日期的年度
      CALL cl_get_para(g_enterprise,g_xccv_m.xccvcomp,'S-FIN-6012') RETURNING l_date
      IF g_xccv_m.xccv004 < YEAR(l_date) THEN
         LET g_xccv_m.xccv004 = g_xccv_m_t.xccv004
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axc-00226'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      IF NOT cl_null(g_xccv_m.xccv005) THEN
         #檢查期別不小於成本關賬日期的月份
         IF g_xccv_m.xccv004 = YEAR(l_date)  THEN  
            IF g_xccv_m.xccv005 <= MONTH(l_date) THEN
               LET g_xccv_m.xccv005 = g_xccv_m_t.xccv005
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axc-00226'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success
            END IF
         END IF     
      END IF        
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
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axct303_insert_default_sfba()
   IF NOT cl_null(g_xccv_d[l_ac].xccv006) THEN
      
      SELECT DISTINCT  sfba003,sfba004,sfba006,sfba021,sfba029,sfba016 
        INTO g_xccv_d[l_ac].xccv007,g_xccv_d[l_ac].xccv008,g_xccv_d[l_ac].xccv009,
             g_xccv_d[l_ac].xccv010,g_xccv_d[l_ac].xccv011,g_xccv_d[l_ac].xccv101     
        FROM  sfba_t     
      WHERE sfbaent=g_enterprise AND sfbadocno=g_xccv_d[l_ac].xccv006 
       AND sfbaseq=g_sfbaseq AND sfbaseq1=g_sfbaseq1
   END IF
   CALL s_desc_get_item_desc(g_xccv_d[l_ac].xccv009) 
         RETURNING g_xccv_d[l_ac].xccv009_desc,g_xccv_d[l_ac].xccv009_desc_desc
         
   INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                                
   LET g_ref_fields[1] = g_xccv_d[l_ac].xccv007
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccv_d[l_ac].xccv007_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccv_d[l_ac].xccv007_desc
   
   DISPLAY BY NAME g_xccv_d[l_ac].xccv007,g_xccv_d[l_ac].xccv008,g_xccv_d[l_ac].xccv009,
                   g_xccv_d[l_ac].xccv010,g_xccv_d[l_ac].xccv011,g_xccv_d[l_ac].xccv101,   
                   g_xccv_d[l_ac].xccv009_desc,g_xccv_d[l_ac].xccv009_desc_desc
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
PRIVATE FUNCTION axct303_generate_xcdv()
#161109-00085#22-s mod 
#DEFINE l_xcdv          RECORD LIKE xcdv_t.*   #161109-00085#22-s mark 
DEFINE l_xcdv          RECORD  #在製元件製程成本次要素期初開帳檔
       xcdvent LIKE xcdv_t.xcdvent, #企業編號
       xcdvcomp LIKE xcdv_t.xcdvcomp, #法人組織
       xcdvld LIKE xcdv_t.xcdvld, #帳套
       xcdv001 LIKE xcdv_t.xcdv001, #帳套本位幣順序
       xcdv002 LIKE xcdv_t.xcdv002, #成本域
       xcdv003 LIKE xcdv_t.xcdv003, #成本計算類型
       xcdv004 LIKE xcdv_t.xcdv004, #年度
       xcdv005 LIKE xcdv_t.xcdv005, #期別
       xcdv006 LIKE xcdv_t.xcdv006, #工單編號/在製編號
       xcdv007 LIKE xcdv_t.xcdv007, #作業編號
       xcdv008 LIKE xcdv_t.xcdv008, #作業序
       xcdv009 LIKE xcdv_t.xcdv009, #料號
       xcdv010 LIKE xcdv_t.xcdv010, #特性
       xcdv011 LIKE xcdv_t.xcdv011, #批號
       xcdv012 LIKE xcdv_t.xcdv012, #次要素
       xcdv020 LIKE xcdv_t.xcdv020, #核算幣別
       xcdv101 LIKE xcdv_t.xcdv101, #期末結存數量
       xcdv102 LIKE xcdv_t.xcdv102  #期末結存金額
          END RECORD
#161109-00085#22-e mod 
#161109-00085#22-s mod
#DEFINE l_xccv      RECORD LIKE xccv_t.*   #161109-00085#22-s mark
DEFINE l_xccv      RECORD  #在製元件製程成本期初開帳檔
       xccvent LIKE xccv_t.xccvent, #企業編號
       xccvcomp LIKE xccv_t.xccvcomp, #法人組織
       xccvld LIKE xccv_t.xccvld, #帳套
       xccv001 LIKE xccv_t.xccv001, #帳套本位幣順序
       xccv002 LIKE xccv_t.xccv002, #成本域
       xccv003 LIKE xccv_t.xccv003, #成本計算類型
       xccv004 LIKE xccv_t.xccv004, #年度
       xccv005 LIKE xccv_t.xccv005, #期別
       xccv006 LIKE xccv_t.xccv006, #工單編號/在製編號
       xccv007 LIKE xccv_t.xccv007, #作業編號
       xccv008 LIKE xccv_t.xccv008, #作業序
       xccv009 LIKE xccv_t.xccv009, #料號
       xccv010 LIKE xccv_t.xccv010, #特性
       xccv011 LIKE xccv_t.xccv011, #批號
       xccv020 LIKE xccv_t.xccv020, #核算幣別
       xccv101 LIKE xccv_t.xccv101, #期末結存數量
       xccv102 LIKE xccv_t.xccv102, #期末結存金額
       xccv102a LIKE xccv_t.xccv102a, #期末結存金額-材料
       xccv102b LIKE xccv_t.xccv102b, #期末結存金額-人工
       xccv102c LIKE xccv_t.xccv102c, #期末結存金額-加工
       xccv102d LIKE xccv_t.xccv102d, #期末結存金額-制費一
       xccv102e LIKE xccv_t.xccv102e, #期末結存金額-制費二
       xccv102f LIKE xccv_t.xccv102f, #期末結存金額-制費三
       xccv102g LIKE xccv_t.xccv102g, #期末結存金額-制費四
       xccv102h LIKE xccv_t.xccv102h  #期末結存金額-制費五
          END RECORD
#161109-00085#22-e mod
DEFINE l_sql           STRING
DEFINE l_success       LIKE type_t.chr1
DEFINE l_xcdv_count    LIKE type_t.num5
DEFINE la_param  RECORD
                 prog   STRING,
                 param  DYNAMIC ARRAY OF STRING
                 END RECORD
DEFINE ls_js     STRING
DEFINE l_cnt     LIKE type_t.num5      #成本次要素个数     #fengmy150312
DEFINE l_success1      LIKE type_t.num5

#fengmy150312---begin
IF NOT s_axct310_cre_tmp_table() THEN
   RETURN
END IF
#fengmy150312---end
CALL s_transaction_begin()
  LET l_success = 'Y'
  #删除axct306已有资料 
  LET l_sql = "SELECT COUNT(*) FROM xcdv_t ",
              " WHERE xcdvent = ? AND xcdvcomp = ? AND xcdvld = ?",
              "   AND xcdv003 = ? AND xcdv004 = ? AND xcdv005 = ? "              
  DECLARE axct303_xcdv_count_cs1 CURSOR FROM l_sql 
  OPEN axct303_xcdv_count_cs1 USING g_enterprise,g_xccv_m.xccvcomp,g_xccv_m.xccvld,
                                   g_xccv_m.xccv003,g_xccv_m.xccv004,g_xccv_m.xccv005
                                   
  FETCH axct303_xcdv_count_cs1 INTO l_xcdv_count
  IF l_xcdv_count > 0 THEN
     IF cl_ask_confirm('axc-00604') THEN   
        LET l_sql = "DELETE FROM xcdv_t ",
                    " WHERE xcdvent = '",g_enterprise,"'  AND xcdvcomp = '",g_xccv_m.xccvcomp,"'",
                    "   AND xcdvld = '",g_xccv_m.xccvld,"' AND xcdv003 = '",g_xccv_m.xccv003,"'",
                    "   AND xcdv004 = '",g_xccv_m.xccv004,"' AND xcdv005 = '",g_xccv_m.xccv005,"'"                   
                     
        PREPARE axct303_del_xcdv FROM l_sql
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code   = SQLCA.sqlcode
           LET g_errparam.extend = "PREPARE delete xcdv_t"
           LET g_errparam.popup  = TRUE
           CALL cl_err()
           RETURN 
        END IF
        EXECUTE axct303_del_xcdv 
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code   = SQLCA.sqlcode
           LET g_errparam.extend = "EXECUTE delete xcdv_t"
           LET g_errparam.popup  = TRUE
           CALL cl_err()
           RETURN 
        END IF 
     ELSE 
        RETURN         
     END IF  
  END IF
    
  
  #生成axct328资料 
  #161109-00085#22-s mod
#  LET l_sql = "SELECT *",   #161109-00085#22-s mark
  LET l_sql = "SELECT xccvent,xccvcomp,xccvld,xccv001,xccv002,xccv003,xccv004,xccv005,
                      xccv006,xccv007,xccv008,xccv009,xccv010,xccv011,xccv020,xccv101,
                      xccv102,xccv102a,xccv102b,xccv102c,xccv102d,xccv102e,xccv102f,xccv102g,xccv102h ",
  #161109-00085#22-e mod
              "  FROM xccv_t WHERE xccvent = ? AND xccvcomp = ? AND xccvld = ?",
                            "  AND xccv003 = ? AND xccv004 = ? AND xccv005 = ? ",              
              "  ORDER BY xccv001"
  DECLARE axct303_xcdv_cs CURSOR FROM l_sql 
  
  FOREACH axct303_xcdv_cs USING g_enterprise,g_xccv_m.xccvcomp,g_xccv_m.xccvld,
                                g_xccv_m.xccv003,g_xccv_m.xccv004,g_xccv_m.xccv005                                
                          #161109-00085#22-s mod
#                          INTO l_xccv.*   #161109-00085#22-s mark
                          INTO l_xccv.xccvent,l_xccv.xccvcomp,l_xccv.xccvld,l_xccv.xccv001,l_xccv.xccv002,
                               l_xccv.xccv003,l_xccv.xccv004,l_xccv.xccv005,l_xccv.xccv006,l_xccv.xccv007,
                               l_xccv.xccv008,l_xccv.xccv009,l_xccv.xccv010,l_xccv.xccv011,l_xccv.xccv020,
                               l_xccv.xccv101,l_xccv.xccv102,l_xccv.xccv102a,l_xccv.xccv102b,l_xccv.xccv102c,
                               l_xccv.xccv102d,l_xccv.xccv102e,l_xccv.xccv102f,l_xccv.xccv102g,l_xccv.xccv102h
                          #161109-00085#22-e mod
#fengmy150316--begin
          CASE l_xccv.xccv001
             WHEN 2  IF g_glaa015 = 'N' THEN CONTINUE FOREACH END IF
             WHEN 3  IF g_glaa019 = 'N' THEN CONTINUE FOREACH END IF
             OTHERWISE
          END CASE 
#fengmy150316--end

          LET l_xcdv.xcdvent = g_enterprise          
          LET l_xcdv.xcdvcomp = g_xccv_m.xccvcomp
          LET l_xcdv.xcdvld = g_xccv_m.xccvld
          LET l_xcdv.xcdv001 = l_xccv.xccv001
          LET l_xcdv.xcdv002 = l_xccv.xccv002
          LET l_xcdv.xcdv003 = g_xccv_m.xccv003
          LET l_xcdv.xcdv004 = g_xccv_m.xccv004
          LET l_xcdv.xcdv005 = g_xccv_m.xccv005
          LET l_xcdv.xcdv006 = l_xccv.xccv006
          LET l_xcdv.xcdv007 = l_xccv.xccv007
          LET l_xcdv.xcdv008 = l_xccv.xccv008
          LET l_xcdv.xcdv009 = l_xccv.xccv009
          LET l_xcdv.xcdv010 = l_xccv.xccv010
          LET l_xcdv.xcdv011 = l_xccv.xccv011
          LET l_xcdv.xcdv012 = ' '          
          LET l_xcdv.xcdv020 = l_xccv.xccv020          
          LET l_xcdv.xcdv101 = l_xccv.xccv101
          LET l_xcdv.xcdv102 = l_xccv.xccv102 

#取次要素----fengmy150318--b
          CALL s_axct310_ins(g_xccv_m.xccvld,g_xccv_m.xccvcomp,l_xcdv.xcdv001,l_xcdv.xcdv002,g_xccv_m.xccv003,g_xccv_m.xccv004,g_xccv_m.xccv005,
                             l_xcdv.xcdv009,l_xcdv.xcdv010,l_xcdv.xcdv011,l_xcdv.xcdv102)
               RETURNING l_success1,l_cnt
          IF l_success1 THEN
             LET l_sql =  " SELECT xcam004,amt FROM s_axct310_tmp2 "
             PREPARE s_axct310_tmp2_pb FROM l_sql
             DECLARE s_axct310_tmp2_cs CURSOR FOR s_axct310_tmp2_pb
             IF l_cnt = 1 THEN
                EXECUTE s_axct310_tmp2_pb INTO l_xcdv.xcdv012,l_xcdv.xcdv102
                #161109-00085#22-s mod 
#                INSERT INTO xcdv_t VALUES(l_xcdv.*)   #161109-00085#22-s mark
                INSERT INTO xcdv_t(xcdvent,xcdvcomp,xcdvld,xcdv001,xcdv002,xcdv003,xcdv004,xcdv005,xcdv006,
                                   xcdv007,xcdv008,xcdv009,xcdv010,xcdv011,xcdv012,xcdv020,xcdv101,xcdv102) 
                            VALUES(l_xcdv.xcdvent,l_xcdv.xcdvcomp,l_xcdv.xcdvld,l_xcdv.xcdv001,l_xcdv.xcdv002,
                                   l_xcdv.xcdv003,l_xcdv.xcdv004,l_xcdv.xcdv005,l_xcdv.xcdv006,l_xcdv.xcdv007,
                                   l_xcdv.xcdv008,l_xcdv.xcdv009,l_xcdv.xcdv010,l_xcdv.xcdv011,l_xcdv.xcdv012,
                                   l_xcdv.xcdv020,l_xcdv.xcdv101,l_xcdv.xcdv102)
                #161109-00085#22-e mod 
                IF SQLCA.SQLCODE AND (NOT cl_err_sql_dup_value(SQLCA.SQLCODE)) THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = SQLCA.sqlcode
                   LET g_errparam.extend = 'ins xcdv_t'
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   LET l_success = 'N' 
                   EXIT FOREACH      
                END IF                           
             ELSE
                FOREACH s_axct310_tmp2_cs INTO l_xcdv.xcdv012,l_xcdv.xcdv102
                   #161109-00085#22-s mod 
#                  INSERT INTO xcdv_t VALUES(l_xcdv.*)   #161109-00085#22-s mark
                   INSERT INTO xcdv_t(xcdvent,xcdvcomp,xcdvld,xcdv001,xcdv002,xcdv003,xcdv004,xcdv005,xcdv006,
                                      xcdv007,xcdv008,xcdv009,xcdv010,xcdv011,xcdv012,xcdv020,xcdv101,xcdv102) 
                               VALUES(l_xcdv.xcdvent,l_xcdv.xcdvcomp,l_xcdv.xcdvld,l_xcdv.xcdv001,l_xcdv.xcdv002,
                                      l_xcdv.xcdv003,l_xcdv.xcdv004,l_xcdv.xcdv005,l_xcdv.xcdv006,l_xcdv.xcdv007,
                                      l_xcdv.xcdv008,l_xcdv.xcdv009,l_xcdv.xcdv010,l_xcdv.xcdv011,l_xcdv.xcdv012,
                                      l_xcdv.xcdv020,l_xcdv.xcdv101,l_xcdv.xcdv102)
                   #161109-00085#22-e mod 
                   IF SQLCA.SQLCODE AND (NOT cl_err_sql_dup_value(SQLCA.SQLCODE)) THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = 'ins xcdv_t'
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      LET l_success = 'N' 
                      EXIT FOREACH      
                   END IF                     
                END FOREACH        
             END IF
          ELSE
             #161109-00085#22-s mod 
#             INSERT INTO xcdv_t VALUES(l_xcdv.*)   #161109-00085#22-s mark
             INSERT INTO xcdv_t(xcdvent,xcdvcomp,xcdvld,xcdv001,xcdv002,xcdv003,xcdv004,xcdv005,xcdv006,
                                xcdv007,xcdv008,xcdv009,xcdv010,xcdv011,xcdv012,xcdv020,xcdv101,xcdv102) 
                         VALUES(l_xcdv.xcdvent,l_xcdv.xcdvcomp,l_xcdv.xcdvld,l_xcdv.xcdv001,l_xcdv.xcdv002,
                                l_xcdv.xcdv003,l_xcdv.xcdv004,l_xcdv.xcdv005,l_xcdv.xcdv006,l_xcdv.xcdv007,
                                l_xcdv.xcdv008,l_xcdv.xcdv009,l_xcdv.xcdv010,l_xcdv.xcdv011,l_xcdv.xcdv012,
                                l_xcdv.xcdv020,l_xcdv.xcdv101,l_xcdv.xcdv102)
             #161109-00085#22-e mod 
             IF SQLCA.SQLCODE AND (NOT cl_err_sql_dup_value(SQLCA.SQLCODE)) THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = SQLCA.sqlcode
                LET g_errparam.extend = 'ins xcdv_t'
                LET g_errparam.popup = TRUE
                CALL cl_err()
                LET l_success = 'N' 
                EXIT FOREACH      
             END IF                          
          END IF
#fengmy150318---e
  END FOREACH
  IF l_success = 'N' THEN
     #CALL cl_err_showmsg() 
      CALL s_transaction_end('N','0') 
   ELSE  
      
      CALL s_transaction_end('Y','0')
   END IF  
  
  IF l_success = 'Y' THEN
     INITIALIZE la_param.* TO NULL     
     LET la_param.prog = "axct328"             
     LET la_param.param[1] = g_xccv_m.xccvld
     LET la_param.param[2] = g_xccv_m.xccv003
     LET la_param.param[3] = g_xccv_m.xccv004
     LET la_param.param[4] = g_xccv_m.xccv005              
     LET ls_js = util.JSON.stringify(la_param)
     DISPLAY ls_js
     CALL cl_cmdrun(ls_js)
  END IF 
  CALL s_axct310_drop_tmp_table()    #fengmy150312  
END FUNCTION

 
{</section>}
 
