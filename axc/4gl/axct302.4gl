#該程式未解開Section, 採用最新樣板產出!
{<section id="axct302.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2014-11-12 09:42:43), PR版次:0009(2016-12-01 09:08:37)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000086
#+ Filename...: axct302
#+ Description: 庫存入項成本開帳作業
#+ Creator....: 03297(2014-09-26 11:23:24)
#+ Modifier...: 03297 -SD/PR- 08993
 
{</section>}
 
{<section id="axct302.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#11   2016/04/25 By 07675     將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）s
#160926-00006#1    2016/09/29 By zhujing   新增时，法人和账套应可以同时清空
#160802-00020#5    2016/10/12 By 02040     增加帳套權限管控、法人權限管控
#161013-00051#1    2016/10/18 By shiun     整批調整據點組織開窗
#161109-00085#22   2016/11/16 By 08993     整批調整系統星號寫法
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
PRIVATE type type_g_xccj_m        RECORD
       xccjcomp LIKE xccj_t.xccjcomp, 
   xccjcomp_desc LIKE type_t.chr80, 
   xccj004 LIKE xccj_t.xccj004, 
   xccj005 LIKE xccj_t.xccj005, 
   xccjld LIKE xccj_t.xccjld, 
   xccjld_desc LIKE type_t.chr80, 
   xccj003 LIKE xccj_t.xccj003, 
   xccj003_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xccj_d        RECORD
       xccj001 LIKE xccj_t.xccj001, 
   xccj006 LIKE xccj_t.xccj006, 
   xccj007 LIKE xccj_t.xccj007, 
   xccj008 LIKE xccj_t.xccj008, 
   xccj013 LIKE xccj_t.xccj013, 
   xccj009 LIKE xccj_t.xccj009, 
   xccj010 LIKE xccj_t.xccj010, 
   xccj010_desc LIKE type_t.chr500, 
   xccj010_desc_desc LIKE type_t.chr500, 
   xccj011 LIKE xccj_t.xccj011, 
   xccj015 LIKE xccj_t.xccj015, 
   xccj015_desc LIKE type_t.chr500, 
   xccj016 LIKE xccj_t.xccj016, 
   xccj016_desc LIKE type_t.chr500, 
   xccj017 LIKE xccj_t.xccj017, 
   xccj020 LIKE xccj_t.xccj020, 
   xccj012 LIKE xccj_t.xccj012, 
   xccj002 LIKE xccj_t.xccj002, 
   xccj002_desc LIKE type_t.chr500, 
   xccj101 LIKE xccj_t.xccj101, 
   xccj102 LIKE xccj_t.xccj102, 
   xccj102a LIKE xccj_t.xccj102a, 
   xccj102b LIKE xccj_t.xccj102b, 
   xccj102c LIKE xccj_t.xccj102c, 
   xccj102d LIKE xccj_t.xccj102d, 
   xccj102e LIKE xccj_t.xccj102e, 
   xccj102f LIKE xccj_t.xccj102f, 
   xccj102g LIKE xccj_t.xccj102g, 
   xccj102h LIKE xccj_t.xccj102h
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_xccj2_d        RECORD
       xccj001 LIKE xccj_t.xccj001, 
   xccj006 LIKE xccj_t.xccj006, 
   xccj007 LIKE xccj_t.xccj007, 
   xccj008 LIKE xccj_t.xccj008, 
   xccj013 LIKE xccj_t.xccj013, 
   xccj009 LIKE xccj_t.xccj009, 
   xccj010 LIKE xccj_t.xccj010, 
   xccj010_desc LIKE type_t.chr500, 
   xccj010_desc_desc LIKE type_t.chr500, 
   xccj011 LIKE xccj_t.xccj011, 
   xccj015 LIKE xccj_t.xccj015, 
   xccj015_desc LIKE type_t.chr500, 
   xccj016 LIKE xccj_t.xccj016, 
   xccj016_desc LIKE type_t.chr500, 
   xccj017 LIKE xccj_t.xccj017,    
   xccj012 LIKE xccj_t.xccj012,
   xccj020 LIKE xccj_t.xccj020,    
   xccj002 LIKE xccj_t.xccj002, 
   xccj002_desc LIKE type_t.chr500, 
   xccj101 LIKE xccj_t.xccj101, 
   xccj102 LIKE xccj_t.xccj102, 
   xccj102a LIKE xccj_t.xccj102a, 
   xccj102b LIKE xccj_t.xccj102b, 
   xccj102c LIKE xccj_t.xccj102c, 
   xccj102d LIKE xccj_t.xccj102d, 
   xccj102e LIKE xccj_t.xccj102e, 
   xccj102f LIKE xccj_t.xccj102f, 
   xccj102g LIKE xccj_t.xccj102g, 
   xccj102h LIKE xccj_t.xccj102h
       END RECORD
DEFINE g_xccj2_d          DYNAMIC ARRAY OF type_g_xccj2_d
DEFINE g_xccj2_d_t        type_g_xccj2_d
DEFINE g_xccj2_d_o        type_g_xccj2_d

 TYPE type_g_xccj3_d        RECORD
       xccj001 LIKE xccj_t.xccj001, 
   xccj006 LIKE xccj_t.xccj006, 
   xccj007 LIKE xccj_t.xccj007, 
   xccj008 LIKE xccj_t.xccj008, 
   xccj013 LIKE xccj_t.xccj013, 
   xccj009 LIKE xccj_t.xccj009, 
   xccj010 LIKE xccj_t.xccj010, 
   xccj010_desc LIKE type_t.chr500, 
   xccj010_desc_desc LIKE type_t.chr500, 
   xccj011 LIKE xccj_t.xccj011, 
   xccj015 LIKE xccj_t.xccj015, 
   xccj015_desc LIKE type_t.chr500, 
   xccj016 LIKE xccj_t.xccj016, 
   xccj016_desc LIKE type_t.chr500, 
   xccj017 LIKE xccj_t.xccj017,
   xccj012 LIKE xccj_t.xccj012,   
   xccj020 LIKE xccj_t.xccj020,    
   xccj002 LIKE xccj_t.xccj002, 
   xccj002_desc LIKE type_t.chr500, 
   xccj101 LIKE xccj_t.xccj101, 
   xccj102 LIKE xccj_t.xccj102, 
   xccj102a LIKE xccj_t.xccj102a, 
   xccj102b LIKE xccj_t.xccj102b, 
   xccj102c LIKE xccj_t.xccj102c, 
   xccj102d LIKE xccj_t.xccj102d, 
   xccj102e LIKE xccj_t.xccj102e, 
   xccj102f LIKE xccj_t.xccj102f, 
   xccj102g LIKE xccj_t.xccj102g, 
   xccj102h LIKE xccj_t.xccj102h
       END RECORD
DEFINE g_xccj3_d          DYNAMIC ARRAY OF type_g_xccj3_d
DEFINE g_xccj3_d_t        type_g_xccj3_d
DEFINE g_xccj3_d_o        type_g_xccj3_d
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
DEFINE g_today          DATETIME YEAR TO SECOND

TYPE type_g_xccj5_d        RECORD
   xccjent   LIKE xccj_t.xccjent,
   xccjld    LIKE xccj_t.xccjld,
   xccjcomp  LIKE xccj_t.xccjcomp,   
   xccj001   LIKE xccj_t.xccj001,    
   xccj004   LIKE xccj_t.xccj004, 
   xccj005   LIKE xccj_t.xccj005,
   xccj003   LIKE xccj_t.xccj003,   
   xccj006   LIKE xccj_t.xccj006,
   xccj007   LIKE xccj_t.xccj007, 
   xccj008   LIKE xccj_t.xccj008,
   xccj013   LIKE xccj_t.xccj013,    
   xccj009   LIKE xccj_t.xccj009,
   xccj010   LIKE xccj_t.xccj010, 
   xccj011   LIKE xccj_t.xccj011, 
   xccj015   LIKE xccj_t.xccj015,             
   xccj016   LIKE xccj_t.xccj016,             
   xccj017   LIKE xccj_t.xccj017,
   xccj012   LIKE xccj_t.xccj012,    
   xccj020   LIKE xccj_t.xccj020,   
   xccj002   LIKE xccj_t.xccj002,   
   xccj101   LIKE xccj_t.xccj101, 
   xccj102   LIKE xccj_t.xccj102,
   xccj102a  LIKE xccj_t.xccj102a, 
   xccj102b  LIKE xccj_t.xccj102b, 
   xccj102c  LIKE xccj_t.xccj102c, 
   xccj102d  LIKE xccj_t.xccj102d, 
   xccj102e  LIKE xccj_t.xccj102e, 
   xccj102f  LIKE xccj_t.xccj102f, 
   xccj102g  LIKE xccj_t.xccj102g, 
   xccj102h  LIKE xccj_t.xccj102h,
   xccj102_1 LIKE xccj_t.xccj102,
   xccj102a_1 LIKE xccj_t.xccj102a, 
   xccj102b_1 LIKE xccj_t.xccj102b, 
   xccj102c_1 LIKE xccj_t.xccj102c, 
   xccj102d_1 LIKE xccj_t.xccj102d, 
   xccj102e_1 LIKE xccj_t.xccj102e, 
   xccj102f_1 LIKE xccj_t.xccj102f, 
   xccj102g_1 LIKE xccj_t.xccj102g, 
   xccj102h_1 LIKE xccj_t.xccj102h,
   xccj102_2 LIKE xccj_t.xccj102,
   xccj102a_2 LIKE xccj_t.xccj102a, 
   xccj102b_2 LIKE xccj_t.xccj102b, 
   xccj102c_2 LIKE xccj_t.xccj102c, 
   xccj102d_2 LIKE xccj_t.xccj102d, 
   xccj102e_2 LIKE xccj_t.xccj102e, 
   xccj102f_2 LIKE xccj_t.xccj102f, 
   xccj102g_2 LIKE xccj_t.xccj102g, 
   xccj102h_2 LIKE xccj_t.xccj102h
   END RECORD
TYPE type_g_xccj_f        RECORD
        xccjcomp LIKE xccj_t.xccjcomp, 
        xccjcomp_desc LIKE type_t.chr80, 
        xccjld LIKE xccj_t.xccjld, 
        xccjld_desc LIKE type_t.chr80, 
        format LIKE type_t.chr80, 
        char LIKE type_t.chr80, 
        dir LIKE type_t.chr80
       END RECORD
DEFINE g_xccj_f        type_g_xccj_f
DEFINE g_xccj_f_t      type_g_xccj_f
DEFINE g_xccj5_d          DYNAMIC ARRAY OF type_g_xccj5_d
DEFINE w        ui.Window
DEFINE f        ui.Form
DEFINE page     om.DomNode
TYPE   type_g_xccj_s        RECORD
       name LIKE type_t.chr80, 
       dir LIKE type_t.chr80
                            END RECORD
DEFINE g_xccj_s        type_g_xccj_s
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
DEFINE g_xccj006        LIKE xccj_t.xccj006
#160802-00020#5-s-add
DEFINE g_wc_cs_ld            STRING
DEFINE g_wc_cs_comp          STRING
#160802-00020#5-e-add
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_xccj_m          type_g_xccj_m
DEFINE g_xccj_m_t        type_g_xccj_m
DEFINE g_xccj_m_o        type_g_xccj_m
DEFINE g_xccj_m_mask_o   type_g_xccj_m #轉換遮罩前資料
DEFINE g_xccj_m_mask_n   type_g_xccj_m #轉換遮罩後資料
 
   DEFINE g_xccj004_t LIKE xccj_t.xccj004
DEFINE g_xccj005_t LIKE xccj_t.xccj005
DEFINE g_xccjld_t LIKE xccj_t.xccjld
DEFINE g_xccj003_t LIKE xccj_t.xccj003
 
 
DEFINE g_xccj_d          DYNAMIC ARRAY OF type_g_xccj_d
DEFINE g_xccj_d_t        type_g_xccj_d
DEFINE g_xccj_d_o        type_g_xccj_d
DEFINE g_xccj_d_mask_o   DYNAMIC ARRAY OF type_g_xccj_d #轉換遮罩前資料
DEFINE g_xccj_d_mask_n   DYNAMIC ARRAY OF type_g_xccj_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_xccjld LIKE xccj_t.xccjld,
      b_xccj003 LIKE xccj_t.xccj003,
      b_xccj004 LIKE xccj_t.xccj004,
      b_xccj005 LIKE xccj_t.xccj005
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
 
{<section id="axct302.main" >}
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
   LET g_forupd_sql = " SELECT xccjcomp,'',xccj004,xccj005,xccjld,'',xccj003,''", 
                      " FROM xccj_t",
                      " WHERE xccjent= ? AND xccjld=? AND xccj003=? AND xccj004=? AND xccj005=? FOR  
                          UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axct302_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xccjcomp,t0.xccj004,t0.xccj005,t0.xccjld,t0.xccj003,t1.ooefl003 , 
       t2.glaal002 ,t3.xcatl003",
               " FROM xccj_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.xccjcomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t2 ON t2.glaalent="||g_enterprise||" AND t2.glaalld=t0.xccjld AND t2.glaal001='"||g_dlang||"' ",
               " LEFT JOIN xcatl_t t3 ON t3.xcatlent="||g_enterprise||" AND t3.xcatl001=t0.xccj003 AND t3.xcatl002='"||g_dlang||"' ",
 
               " WHERE t0.xccjent = " ||g_enterprise|| " AND t0.xccjld = ? AND t0.xccj003 = ? AND t0.xccj004 = ? AND t0.xccj005 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axct302_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axct302 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axct302_init()   
 
      #進入選單 Menu (="N")
      CALL axct302_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axct302
      
   END IF 
   
   CLOSE axct302_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axct302.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axct302_init()
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
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否            
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xccj002,xccj002_desc,xccj002_2,xccj002_2_desc,xccj002_3,xccj002_3_desc',TRUE)                    
   ELSE
      CALL cl_set_comp_visible('xccj002,xccj002_desc,xccj002_2,xccj002_2_desc,xccj002_3,xccj002_3_desc',FALSE)                
   END IF
   LET g_today = cl_get_today()
   #end add-point
   
   CALL axct302_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axct302.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axct302_ui_dialog()
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
         INITIALIZE g_xccj_m.* TO NULL
         CALL g_xccj_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axct302_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_xccj_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL axct302_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axct302_ui_detailshow()
               
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
        DISPLAY ARRAY g_xccj2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL axct302_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               CALL axct302_ui_detailshow()
               
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
         DISPLAY ARRAY g_xccj3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL axct302_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx
               CALL axct302_ui_detailshow()
               
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
            CALL axct302_browser_fill("")
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
               CALL axct302_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axct302_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axct302_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct302_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axct302_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct302_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axct302_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct302_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axct302_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct302_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axct302_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct302_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_xccj_d)
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
               NEXT FIELD xccj001
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
               CALL axct302_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL axct302_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL axct302_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL axct302_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL axct302_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION axct306
            LET g_action_choice="axct306"
            IF cl_auth_chk_act("axct306") THEN
               
               #add-point:ON ACTION axct306 name="menu.axct306"
               CALL axct302_generate_xcdj()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL axct302_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axct302_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/axc/axct302_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/axc/axct302_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL axct302_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axct302_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axct302_s01
            LET g_action_choice="open_axct302_s01"
            IF cl_auth_chk_act("open_axct302_s01") THEN
               
               #add-point:ON ACTION open_axct302_s01 name="menu.open_axct302_s01"
               CALL axct302_s01()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axct302_s02
            LET g_action_choice="open_axct302_s02"
            IF cl_auth_chk_act("open_axct302_s02") THEN
               
               #add-point:ON ACTION open_axct302_s02 name="menu.open_axct302_s02"
               CALL axct302_s02() RETURNING l_success
               IF l_success = TRUE THEN
                  CALL s_transaction_end('Y','1')
                  ERROR "INSERT O.K"
               ELSE
                  CALL s_transaction_end('N','1')
               END IF
               CALL axct302_show()
               #END add-point
               
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axct302_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axct302_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axct302_set_pk_array()
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
 
{<section id="axct302.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION axct302_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axct302.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axct302_browser_fill(ps_page_action)
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
 
   LET l_searchcol = "xccjld,xccj003,xccj004,xccj005"
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
      LET l_sub_sql = " SELECT DISTINCT xccjld ",
                      ", xccj003 ",
                      ", xccj004 ",
                      ", xccj005 ",
 
                      " FROM xccj_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE xccjent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xccj_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xccjld ",
                      ", xccj003 ",
                      ", xccj004 ",
                      ", xccj005 ",
 
                      " FROM xccj_t ",
                      " ",
                      " ", 
 
 
                      " WHERE xccjent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xccj_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
 
   #add-point:browser_fill,count前 name="browser_fill.before_count"
  #160802-00020#5-s-add  
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET l_sub_sql = l_sub_sql , " AND xccjld IN ",g_wc_cs_ld
   END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET l_sub_sql = l_sub_sql," AND xccjcomp IN ",g_wc_cs_comp
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
      INITIALIZE g_xccj_m.* TO NULL
      CALL g_xccj_d.clear()        
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xccjld,t0.xccj003,t0.xccj004,t0.xccj005 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.xccjld,t0.xccj003,t0.xccj004,t0.xccj005",
                " FROM xccj_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.xccjent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xccj_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   #160802-00020#5-s-add
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql , " AND t0.xccjld IN ",g_wc_cs_ld
   END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql," AND t0.xccjcomp IN ",g_wc_cs_comp
   END IF  
   #160802-00020#5-e-add
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"xccj_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_xccjld,g_browser[g_cnt].b_xccj003,g_browser[g_cnt].b_xccj004, 
          g_browser[g_cnt].b_xccj005 
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
   
   IF cl_null(g_browser[g_cnt].b_xccjld) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_xccj_m.* TO NULL
      CALL g_xccj_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL axct302_fetch('')
   
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
 
{<section id="axct302.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axct302_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xccj_m.xccjld = g_browser[g_current_idx].b_xccjld   
   LET g_xccj_m.xccj003 = g_browser[g_current_idx].b_xccj003   
   LET g_xccj_m.xccj004 = g_browser[g_current_idx].b_xccj004   
   LET g_xccj_m.xccj005 = g_browser[g_current_idx].b_xccj005   
 
   EXECUTE axct302_master_referesh USING g_xccj_m.xccjld,g_xccj_m.xccj003,g_xccj_m.xccj004,g_xccj_m.xccj005 INTO g_xccj_m.xccjcomp, 
       g_xccj_m.xccj004,g_xccj_m.xccj005,g_xccj_m.xccjld,g_xccj_m.xccj003,g_xccj_m.xccjcomp_desc,g_xccj_m.xccjld_desc, 
       g_xccj_m.xccj003_desc
   CALL axct302_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axct302.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axct302_ui_detailshow()
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
   CALL axct302_show()
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axct302.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axct302_ui_browser_refresh()
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
      IF g_browser[l_i].b_xccjld = g_xccj_m.xccjld 
         AND g_browser[l_i].b_xccj003 = g_xccj_m.xccj003 
         AND g_browser[l_i].b_xccj004 = g_xccj_m.xccj004 
         AND g_browser[l_i].b_xccj005 = g_xccj_m.xccj005 
 
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
 
{<section id="axct302.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axct302_construct()
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
   INITIALIZE g_xccj_m.* TO NULL
   CALL g_xccj_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xccjcomp,xccj004,xccj005,xccjld,xccj003
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.xccjcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccjcomp
            #add-point:ON ACTION controlp INFIELD xccjcomp name="construct.c.xccjcomp"
            #此段落由子樣板a08產生
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
            #mod--161013-00051#1 By shiun--(S)
#            CALL q_ooef001_8()                           #呼叫開窗
            CALL q_ooef001_2()
            #mod--161013-00051#1 By shiun--(E)
            DISPLAY g_qryparam.return1 TO xccjcomp  #顯示到畫面上
            NEXT FIELD xccjcomp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccjcomp
            #add-point:BEFORE FIELD xccjcomp name="construct.b.xccjcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccjcomp
            
            #add-point:AFTER FIELD xccjcomp name="construct.a.xccjcomp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj004
            #add-point:BEFORE FIELD xccj004 name="construct.b.xccj004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj004
            
            #add-point:AFTER FIELD xccj004 name="construct.a.xccj004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccj004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj004
            #add-point:ON ACTION controlp INFIELD xccj004 name="construct.c.xccj004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj005
            #add-point:BEFORE FIELD xccj005 name="construct.b.xccj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj005
            
            #add-point:AFTER FIELD xccj005 name="construct.a.xccj005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccj005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj005
            #add-point:ON ACTION controlp INFIELD xccj005 name="construct.c.xccj005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xccjld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccjld
            #add-point:ON ACTION controlp INFIELD xccjld name="construct.c.xccjld"
            #此段落由子樣板a08產生
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
            DISPLAY g_qryparam.return1 TO xccjld  #顯示到畫面上
            NEXT FIELD xccjld                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccjld
            #add-point:BEFORE FIELD xccjld name="construct.b.xccjld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccjld
            
            #add-point:AFTER FIELD xccjld name="construct.a.xccjld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccj003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj003
            #add-point:ON ACTION controlp INFIELD xccj003 name="construct.c.xccj003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " xcat005 IN ('2','3') "
            CALL q_xcat001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccj003  #顯示到畫面上
            NEXT FIELD xccj003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj003
            #add-point:BEFORE FIELD xccj003 name="construct.b.xccj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj003
            
            #add-point:AFTER FIELD xccj003 name="construct.a.xccj003"
            
            #END add-point
            
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON xccj001,xccj006,xccj007,xccj008,xccj013,xccj009,xccj010,xccj011,xccj015, 
          xccj016,xccj017,xccj020,xccj012,xccj002,xccj101,xccj102,xccj102a,xccj102b,xccj102c,xccj102d, 
          xccj102e,xccj102f,xccj102g,xccj102h
           FROM s_detail1[1].xccj001,s_detail1[1].xccj006,s_detail1[1].xccj007,s_detail1[1].xccj008, 
               s_detail1[1].xccj013,s_detail1[1].xccj009,s_detail1[1].xccj010,s_detail1[1].xccj011,s_detail1[1].xccj015, 
               s_detail1[1].xccj016,s_detail1[1].xccj017,s_detail1[1].xccj020,s_detail1[1].xccj012,s_detail1[1].xccj002, 
               s_detail1[1].xccj101,s_detail1[1].xccj102,s_detail1[1].xccj102a,s_detail1[1].xccj102b, 
               s_detail1[1].xccj102c,s_detail1[1].xccj102d,s_detail1[1].xccj102e,s_detail1[1].xccj102f, 
               s_detail1[1].xccj102g,s_detail1[1].xccj102h
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj001
            #add-point:BEFORE FIELD xccj001 name="construct.b.page1.xccj001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj001
            
            #add-point:AFTER FIELD xccj001 name="construct.a.page1.xccj001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccj001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj001
            #add-point:ON ACTION controlp INFIELD xccj001 name="construct.c.page1.xccj001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xccj006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj006
            #add-point:ON ACTION controlp INFIELD xccj006 name="construct.c.page1.xccj006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaj001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccj006  #顯示到畫面上
            NEXT FIELD xccj006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj006
            #add-point:BEFORE FIELD xccj006 name="construct.b.page1.xccj006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj006
            
            #add-point:AFTER FIELD xccj006 name="construct.a.page1.xccj006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj007
            #add-point:BEFORE FIELD xccj007 name="construct.b.page1.xccj007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj007
            
            #add-point:AFTER FIELD xccj007 name="construct.a.page1.xccj007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccj007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj007
            #add-point:ON ACTION controlp INFIELD xccj007 name="construct.c.page1.xccj007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj008
            #add-point:BEFORE FIELD xccj008 name="construct.b.page1.xccj008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj008
            
            #add-point:AFTER FIELD xccj008 name="construct.a.page1.xccj008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccj008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj008
            #add-point:ON ACTION controlp INFIELD xccj008 name="construct.c.page1.xccj008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj013
            #add-point:BEFORE FIELD xccj013 name="construct.b.page1.xccj013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj013
            
            #add-point:AFTER FIELD xccj013 name="construct.a.page1.xccj013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccj013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj013
            #add-point:ON ACTION controlp INFIELD xccj013 name="construct.c.page1.xccj013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj009
            #add-point:BEFORE FIELD xccj009 name="construct.b.page1.xccj009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj009
            
            #add-point:AFTER FIELD xccj009 name="construct.a.page1.xccj009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccj009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj009
            #add-point:ON ACTION controlp INFIELD xccj009 name="construct.c.page1.xccj009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xccj010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj010
            #add-point:ON ACTION controlp INFIELD xccj010 name="construct.c.page1.xccj010"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccj010  #顯示到畫面上
            NEXT FIELD xccj010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj010
            #add-point:BEFORE FIELD xccj010 name="construct.b.page1.xccj010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj010
            
            #add-point:AFTER FIELD xccj010 name="construct.a.page1.xccj010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccj011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj011
            #add-point:ON ACTION controlp INFIELD xccj011 name="construct.c.page1.xccj011"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_bmaa002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccj011  #顯示到畫面上
            NEXT FIELD xccj011                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj011
            #add-point:BEFORE FIELD xccj011 name="construct.b.page1.xccj011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj011
            
            #add-point:AFTER FIELD xccj011 name="construct.a.page1.xccj011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccj015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj015
            #add-point:ON ACTION controlp INFIELD xccj015 name="construct.c.page1.xccj015"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccj015  #顯示到畫面上
            NEXT FIELD xccj015                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj015
            #add-point:BEFORE FIELD xccj015 name="construct.b.page1.xccj015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj015
            
            #add-point:AFTER FIELD xccj015 name="construct.a.page1.xccj015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccj016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj016
            #add-point:ON ACTION controlp INFIELD xccj016 name="construct.c.page1.xccj016"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inab002_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccj016  #顯示到畫面上
            NEXT FIELD xccj016                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj016
            #add-point:BEFORE FIELD xccj016 name="construct.b.page1.xccj016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj016
            
            #add-point:AFTER FIELD xccj016 name="construct.a.page1.xccj016"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj017
            #add-point:BEFORE FIELD xccj017 name="construct.b.page1.xccj017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj017
            
            #add-point:AFTER FIELD xccj017 name="construct.a.page1.xccj017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccj017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj017
            #add-point:ON ACTION controlp INFIELD xccj017 name="construct.c.page1.xccj017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj020
            #add-point:BEFORE FIELD xccj020 name="construct.b.page1.xccj020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj020
            
            #add-point:AFTER FIELD xccj020 name="construct.a.page1.xccj020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccj020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj020
            #add-point:ON ACTION controlp INFIELD xccj020 name="construct.c.page1.xccj020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj012
            #add-point:BEFORE FIELD xccj012 name="construct.b.page1.xccj012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj012
            
            #add-point:AFTER FIELD xccj012 name="construct.a.page1.xccj012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccj012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj012
            #add-point:ON ACTION controlp INFIELD xccj012 name="construct.c.page1.xccj012"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xccj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj002
            #add-point:ON ACTION controlp INFIELD xccj002 name="construct.c.page1.xccj002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcbf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccj002  #顯示到畫面上
            NEXT FIELD xccj002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj002
            #add-point:BEFORE FIELD xccj002 name="construct.b.page1.xccj002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj002
            
            #add-point:AFTER FIELD xccj002 name="construct.a.page1.xccj002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj101
            #add-point:BEFORE FIELD xccj101 name="construct.b.page1.xccj101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj101
            
            #add-point:AFTER FIELD xccj101 name="construct.a.page1.xccj101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccj101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj101
            #add-point:ON ACTION controlp INFIELD xccj101 name="construct.c.page1.xccj101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj102
            #add-point:BEFORE FIELD xccj102 name="construct.b.page1.xccj102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj102
            
            #add-point:AFTER FIELD xccj102 name="construct.a.page1.xccj102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccj102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj102
            #add-point:ON ACTION controlp INFIELD xccj102 name="construct.c.page1.xccj102"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj102a
            #add-point:BEFORE FIELD xccj102a name="construct.b.page1.xccj102a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj102a
            
            #add-point:AFTER FIELD xccj102a name="construct.a.page1.xccj102a"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccj102a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj102a
            #add-point:ON ACTION controlp INFIELD xccj102a name="construct.c.page1.xccj102a"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj102b
            #add-point:BEFORE FIELD xccj102b name="construct.b.page1.xccj102b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj102b
            
            #add-point:AFTER FIELD xccj102b name="construct.a.page1.xccj102b"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccj102b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj102b
            #add-point:ON ACTION controlp INFIELD xccj102b name="construct.c.page1.xccj102b"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj102c
            #add-point:BEFORE FIELD xccj102c name="construct.b.page1.xccj102c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj102c
            
            #add-point:AFTER FIELD xccj102c name="construct.a.page1.xccj102c"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccj102c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj102c
            #add-point:ON ACTION controlp INFIELD xccj102c name="construct.c.page1.xccj102c"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj102d
            #add-point:BEFORE FIELD xccj102d name="construct.b.page1.xccj102d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj102d
            
            #add-point:AFTER FIELD xccj102d name="construct.a.page1.xccj102d"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccj102d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj102d
            #add-point:ON ACTION controlp INFIELD xccj102d name="construct.c.page1.xccj102d"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj102e
            #add-point:BEFORE FIELD xccj102e name="construct.b.page1.xccj102e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj102e
            
            #add-point:AFTER FIELD xccj102e name="construct.a.page1.xccj102e"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccj102e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj102e
            #add-point:ON ACTION controlp INFIELD xccj102e name="construct.c.page1.xccj102e"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj102f
            #add-point:BEFORE FIELD xccj102f name="construct.b.page1.xccj102f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj102f
            
            #add-point:AFTER FIELD xccj102f name="construct.a.page1.xccj102f"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccj102f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj102f
            #add-point:ON ACTION controlp INFIELD xccj102f name="construct.c.page1.xccj102f"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj102g
            #add-point:BEFORE FIELD xccj102g name="construct.b.page1.xccj102g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj102g
            
            #add-point:AFTER FIELD xccj102g name="construct.a.page1.xccj102g"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccj102g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj102g
            #add-point:ON ACTION controlp INFIELD xccj102g name="construct.c.page1.xccj102g"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj102h
            #add-point:BEFORE FIELD xccj102h name="construct.b.page1.xccj102h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj102h
            
            #add-point:AFTER FIELD xccj102h name="construct.a.page1.xccj102h"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccj102h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj102h
            #add-point:ON ACTION controlp INFIELD xccj102h name="construct.c.page1.xccj102h"
            
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
 
{<section id="axct302.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axct302_query()
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
   CALL g_xccj_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL axct302_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axct302_browser_fill(g_wc)
      CALL axct302_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL axct302_browser_fill("F")
   
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
      CALL axct302_fetch("F") 
   END IF
   
   CALL axct302_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="axct302.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axct302_fetch(p_flag)
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
   
   #CALL axct302_browser_fill(p_flag)
   
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
   
   LET g_xccj_m.xccjld = g_browser[g_current_idx].b_xccjld
   LET g_xccj_m.xccj003 = g_browser[g_current_idx].b_xccj003
   LET g_xccj_m.xccj004 = g_browser[g_current_idx].b_xccj004
   LET g_xccj_m.xccj005 = g_browser[g_current_idx].b_xccj005
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axct302_master_referesh USING g_xccj_m.xccjld,g_xccj_m.xccj003,g_xccj_m.xccj004,g_xccj_m.xccj005 INTO g_xccj_m.xccjcomp, 
       g_xccj_m.xccj004,g_xccj_m.xccj005,g_xccj_m.xccjld,g_xccj_m.xccj003,g_xccj_m.xccjcomp_desc,g_xccj_m.xccjld_desc, 
       g_xccj_m.xccj003_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccj_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_xccj_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_xccj_m_mask_o.* =  g_xccj_m.*
   CALL axct302_xccj_t_mask()
   LET g_xccj_m_mask_n.* =  g_xccj_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axct302_set_act_visible()
   CALL axct302_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_xccj_m_t.* = g_xccj_m.*
   LET g_xccj_m_o.* = g_xccj_m.*
   
   #重新顯示   
   CALL axct302_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axct302.insert" >}
#+ 資料新增
PRIVATE FUNCTION axct302_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_xccj_d.clear()
 
 
   INITIALIZE g_xccj_m.* TO NULL             #DEFAULT 設定
   LET g_xccjld_t = NULL
   LET g_xccj003_t = NULL
   LET g_xccj004_t = NULL
   LET g_xccj005_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      #预设当前site的法人，主账套，年度期别，成本计算类型
      IF cl_null(g_xccj_m.xccjcomp) AND cl_null(g_xccj_m.xccjld) AND cl_null(g_xccj_m.xccj004) AND cl_null(g_xccj_m.xccj005) AND cl_null(g_xccj_m.xccj003) THEN
         CALL s_axc_set_site_default() RETURNING g_xccj_m.xccjcomp,g_xccj_m.xccjld,g_xccj_m.xccj004,g_xccj_m.xccj005,g_xccj_m.xccj003
         DISPLAY BY NAME g_xccj_m.xccjcomp,g_xccj_m.xccjld,g_xccj_m.xccj004,g_xccj_m.xccj005,g_xccj_m.xccj003
         CALL axct302_ref()
      END IF
      #end add-point 
 
      CALL axct302_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_xccj_m.* TO NULL
         INITIALIZE g_xccj_d TO NULL
 
         CALL axct302_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xccj_m.* = g_xccj_m_t.*
         CALL axct302_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_xccj_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axct302_set_act_visible()
   CALL axct302_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xccjld_t = g_xccj_m.xccjld
   LET g_xccj003_t = g_xccj_m.xccj003
   LET g_xccj004_t = g_xccj_m.xccj004
   LET g_xccj005_t = g_xccj_m.xccj005
 
   
   #組合新增資料的條件
   LET g_add_browse = " xccjent = " ||g_enterprise|| " AND",
                      " xccjld = '", g_xccj_m.xccjld, "' "
                      ," AND xccj003 = '", g_xccj_m.xccj003, "' "
                      ," AND xccj004 = '", g_xccj_m.xccj004, "' "
                      ," AND xccj005 = '", g_xccj_m.xccj005, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axct302_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL axct302_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axct302_master_referesh USING g_xccj_m.xccjld,g_xccj_m.xccj003,g_xccj_m.xccj004,g_xccj_m.xccj005 INTO g_xccj_m.xccjcomp, 
       g_xccj_m.xccj004,g_xccj_m.xccj005,g_xccj_m.xccjld,g_xccj_m.xccj003,g_xccj_m.xccjcomp_desc,g_xccj_m.xccjld_desc, 
       g_xccj_m.xccj003_desc
   
   #遮罩相關處理
   LET g_xccj_m_mask_o.* =  g_xccj_m.*
   CALL axct302_xccj_t_mask()
   LET g_xccj_m_mask_n.* =  g_xccj_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xccj_m.xccjcomp,g_xccj_m.xccjcomp_desc,g_xccj_m.xccj004,g_xccj_m.xccj005,g_xccj_m.xccjld, 
       g_xccj_m.xccjld_desc,g_xccj_m.xccj003,g_xccj_m.xccj003_desc
   
   #功能已完成,通報訊息中心
   CALL axct302_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axct302.modify" >}
#+ 資料修改
PRIVATE FUNCTION axct302_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_xccj_m.xccjld IS NULL
   OR g_xccj_m.xccj003 IS NULL
   OR g_xccj_m.xccj004 IS NULL
   OR g_xccj_m.xccj005 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_xccjld_t = g_xccj_m.xccjld
   LET g_xccj003_t = g_xccj_m.xccj003
   LET g_xccj004_t = g_xccj_m.xccj004
   LET g_xccj005_t = g_xccj_m.xccj005
 
   CALL s_transaction_begin()
   
   OPEN axct302_cl USING g_enterprise,g_xccj_m.xccjld,g_xccj_m.xccj003,g_xccj_m.xccj004,g_xccj_m.xccj005
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axct302_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axct302_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axct302_master_referesh USING g_xccj_m.xccjld,g_xccj_m.xccj003,g_xccj_m.xccj004,g_xccj_m.xccj005 INTO g_xccj_m.xccjcomp, 
       g_xccj_m.xccj004,g_xccj_m.xccj005,g_xccj_m.xccjld,g_xccj_m.xccj003,g_xccj_m.xccjcomp_desc,g_xccj_m.xccjld_desc, 
       g_xccj_m.xccj003_desc
   
   #遮罩相關處理
   LET g_xccj_m_mask_o.* =  g_xccj_m.*
   CALL axct302_xccj_t_mask()
   LET g_xccj_m_mask_n.* =  g_xccj_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL axct302_show()
   WHILE TRUE
      LET g_xccjld_t = g_xccj_m.xccjld
      LET g_xccj003_t = g_xccj_m.xccj003
      LET g_xccj004_t = g_xccj_m.xccj004
      LET g_xccj005_t = g_xccj_m.xccj005
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL axct302_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')           
      END IF
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xccj_m.* = g_xccj_m_t.*
         CALL axct302_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_xccj_m.xccjld != g_xccjld_t 
      OR g_xccj_m.xccj003 != g_xccj003_t 
      OR g_xccj_m.xccj004 != g_xccj004_t 
      OR g_xccj_m.xccj005 != g_xccj005_t 
 
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
   CALL axct302_set_act_visible()
   CALL axct302_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xccjent = " ||g_enterprise|| " AND",
                      " xccjld = '", g_xccj_m.xccjld, "' "
                      ," AND xccj003 = '", g_xccj_m.xccj003, "' "
                      ," AND xccj004 = '", g_xccj_m.xccj004, "' "
                      ," AND xccj005 = '", g_xccj_m.xccj005, "' "
 
   #填到對應位置
   CALL axct302_browser_fill("")
 
   CALL axct302_idx_chk()
 
   CLOSE axct302_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axct302_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="axct302.input" >}
#+ 資料輸入
PRIVATE FUNCTION axct302_input(p_cmd)
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
   DISPLAY BY NAME g_xccj_m.xccjcomp,g_xccj_m.xccjcomp_desc,g_xccj_m.xccj004,g_xccj_m.xccj005,g_xccj_m.xccjld, 
       g_xccj_m.xccjld_desc,g_xccj_m.xccj003,g_xccj_m.xccj003_desc
   
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
   LET g_forupd_sql = "SELECT xccj001,xccj006,xccj007,xccj008,xccj013,xccj009,xccj010,xccj011,xccj015, 
       xccj016,xccj017,xccj020,xccj012,xccj002,xccj101,xccj102,xccj102a,xccj102b,xccj102c,xccj102d,xccj102e, 
       xccj102f,xccj102g,xccj102h FROM xccj_t WHERE xccjent=? AND xccjld=? AND xccj003=? AND xccj004=?  
       AND xccj005=? AND xccj001=? AND xccj002=? AND xccj006=? AND xccj007=? AND xccj008=? AND xccj009=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axct302_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axct302_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axct302_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_xccj_m.xccjcomp,g_xccj_m.xccj004,g_xccj_m.xccj005,g_xccj_m.xccjld,g_xccj_m.xccj003 
 
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axct302.input.head" >}
   
      #單頭段
      INPUT BY NAME g_xccj_m.xccjcomp,g_xccj_m.xccj004,g_xccj_m.xccj005,g_xccj_m.xccjld,g_xccj_m.xccj003  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:單頭input前 name="input.head.b_input"
            NEXT FIELD xccjcomp
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccjcomp
            
            #add-point:AFTER FIELD xccjcomp name="input.a.xccjcomp"
            IF NOT cl_null(g_xccj_m.xccjcomp) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xccj_m_t.xccjcomp IS NULL OR g_xccj_m.xccjcomp != g_xccj_m_t.xccjcomp)) THEN
                  IF NOT s_axc_chk_ld_comp(g_xccj_m.xccjcomp,g_xccj_m.xccjld) THEN
                     LET g_xccj_m.xccjcomp = g_xccj_m_t.xccjcomp
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL cl_get_para(g_enterprise,g_xccj_m.xccjcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否            
               IF g_para_data = 'Y' THEN
                  CALL cl_set_comp_visible('xccj002,xccj002_desc,xccj002_2,xccj002_2_desc,xccj002_3,xccj002_3_desc',TRUE)                    
               ELSE
                  CALL cl_set_comp_visible('xccj002,xccj002_desc,xccj002_2,xccj002_2_desc,xccj002_3,xccj002_3_desc',FALSE)                
               END IF
            END IF
#            CALL axct302_ref()     #160926-00006#1 marked
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccj_m.xccjcomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccj_m.xccjcomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccj_m.xccjcomp_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccjcomp
            #add-point:BEFORE FIELD xccjcomp name="input.b.xccjcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccjcomp
            #add-point:ON CHANGE xccjcomp name="input.g.xccjcomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj004
            #add-point:BEFORE FIELD xccj004 name="input.b.xccj004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj004
            
            #add-point:AFTER FIELD xccj004 name="input.a.xccj004"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF NOT cl_null(g_xccj_m.xccj004) THEN
               IF p_cmd ='a' OR (p_cmd ='u' AND (g_xccj_m_t.xccj004 IS NULL OR g_xccj_m.xccj004 != g_xccj_m_t.xccj004)) THEN
                  IF NOT axct302_chk_year_period() THEN
                     LET g_xccj_m.xccj004 = g_xccj_m_t.xccj004
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF  NOT cl_null(g_xccj_m.xccjld) AND NOT cl_null(g_xccj_m.xccj003) AND NOT cl_null(g_xccj_m.xccj004) AND NOT cl_null(g_xccj_m.xccj005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccj_m.xccjld != g_xccjld_t  OR g_xccj_m.xccj003 != g_xccj003_t  OR g_xccj_m.xccj004 != g_xccj004_t  OR g_xccj_m.xccj005 != g_xccj005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccj_t WHERE "||"xccjent = '" ||g_enterprise|| "' AND "||"xccjld = '"||g_xccj_m.xccjld ||"' AND "|| "xccj003 = '"||g_xccj_m.xccj003 ||"' AND "|| "xccj004 = '"||g_xccj_m.xccj004 ||"' AND "|| "xccj005 = '"||g_xccj_m.xccj005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccj004
            #add-point:ON CHANGE xccj004 name="input.g.xccj004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj005
            #add-point:BEFORE FIELD xccj005 name="input.b.xccj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj005
            
            #add-point:AFTER FIELD xccj005 name="input.a.xccj005"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF NOT cl_null(g_xccj_m.xccj005) THEN
               IF p_cmd ='a' OR (p_cmd ='u' AND (g_xccj_m_t.xccj005 IS NULL OR g_xccj_m.xccj005 != g_xccj_m_t.xccj005)) THEN
                  IF NOT axct302_chk_year_period() THEN
                     LET g_xccj_m.xccj005 = g_xccj_m_t.xccj005
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            IF  NOT cl_null(g_xccj_m.xccjld) AND NOT cl_null(g_xccj_m.xccj003) AND NOT cl_null(g_xccj_m.xccj004) AND NOT cl_null(g_xccj_m.xccj005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccj_m.xccjld != g_xccjld_t  OR g_xccj_m.xccj003 != g_xccj003_t  OR g_xccj_m.xccj004 != g_xccj004_t  OR g_xccj_m.xccj005 != g_xccj005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccj_t WHERE "||"xccjent = '" ||g_enterprise|| "' AND "||"xccjld = '"||g_xccj_m.xccjld ||"' AND "|| "xccj003 = '"||g_xccj_m.xccj003 ||"' AND "|| "xccj004 = '"||g_xccj_m.xccj004 ||"' AND "|| "xccj005 = '"||g_xccj_m.xccj005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccj005
            #add-point:ON CHANGE xccj005 name="input.g.xccj005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccjld
            
            #add-point:AFTER FIELD xccjld name="input.a.xccjld"
            IF NOT cl_null(g_xccj_m.xccjld) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xccj_m_t.xccjld IS NULL OR g_xccj_m.xccjld != g_xccj_m_t.xccjld)) THEN
                  IF NOT s_axc_chk_ld_comp(g_xccj_m.xccjcomp,g_xccj_m.xccjld) THEN
                     LET g_xccj_m.xccjld = g_xccj_m_t.xccjld
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF       
           
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccj_m.xccjld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccj_m.xccjld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccj_m.xccjld_desc

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xccj_m.xccjld) AND NOT cl_null(g_xccj_m.xccj003) AND NOT cl_null(g_xccj_m.xccj004) AND NOT cl_null(g_xccj_m.xccj005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccj_m.xccjld != g_xccjld_t  OR g_xccj_m.xccj003 != g_xccj003_t  OR g_xccj_m.xccj004 != g_xccj004_t  OR g_xccj_m.xccj005 != g_xccj005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccj_t WHERE "||"xccjent = '" ||g_enterprise|| "' AND "||"xccjld = '"||g_xccj_m.xccjld ||"' AND "|| "xccj003 = '"||g_xccj_m.xccj003 ||"' AND "|| "xccj004 = '"||g_xccj_m.xccj004 ||"' AND "|| "xccj005 = '"||g_xccj_m.xccj005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

#            CALL axct302_ref()        #160926-00006#1 marked
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
         BEFORE FIELD xccjld
            #add-point:BEFORE FIELD xccjld name="input.b.xccjld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccjld
            #add-point:ON CHANGE xccjld name="input.g.xccjld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj003
            
            #add-point:AFTER FIELD xccj003 name="input.a.xccj003"
            IF NOT cl_null(g_xccj_m.xccj003) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xccj_m.xccj003
               #160318-00025#11--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00195:sub-01302|axci100|",cl_get_progname("axci100",g_lang,"2"),"|:EXEPROGaxci100"
               #160318-00025#11--add--end
                   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_xcat001_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccj_m.xccj003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccj_m.xccj003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccj_m.xccj003_desc

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xccj_m.xccjld) AND NOT cl_null(g_xccj_m.xccj003) AND NOT cl_null(g_xccj_m.xccj004) AND NOT cl_null(g_xccj_m.xccj005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccj_m.xccjld != g_xccjld_t  OR g_xccj_m.xccj003 != g_xccj003_t  OR g_xccj_m.xccj004 != g_xccj004_t  OR g_xccj_m.xccj005 != g_xccj005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccj_t WHERE "||"xccjent = '" ||g_enterprise|| "' AND "||"xccjld = '"||g_xccj_m.xccjld ||"' AND "|| "xccj003 = '"||g_xccj_m.xccj003 ||"' AND "|| "xccj004 = '"||g_xccj_m.xccj004 ||"' AND "|| "xccj005 = '"||g_xccj_m.xccj005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

#            CALL axct302_ref()     #160926-00006#1 marked
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj003
            #add-point:BEFORE FIELD xccj003 name="input.b.xccj003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccj003
            #add-point:ON CHANGE xccj003 name="input.g.xccj003"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xccjcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccjcomp
            #add-point:ON ACTION controlp INFIELD xccjcomp name="input.c.xccjcomp"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccj_m.xccjcomp             #給予default值

            IF NOT cl_null(g_xccj_m.xccjld) THEN
               #給予arg
               LET g_qryparam.arg1 = g_xccj_m.xccjld
              
               CALL q_glaacomp()                #呼叫開窗
            ELSE 
           
            
               #mod--161013-00051#1 By shiun--(S)
#               CALL q_ooef001_8()                           #呼叫開窗
               CALL q_ooef001_2()
               #mod--161013-00051#1 By shiun--(E)
            END IF
            LET g_xccj_m.xccjcomp = g_qryparam.return1              

            DISPLAY g_xccj_m.xccjcomp TO xccjcomp              #

            NEXT FIELD xccjcomp                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xccj004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj004
            #add-point:ON ACTION controlp INFIELD xccj004 name="input.c.xccj004"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccj005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj005
            #add-point:ON ACTION controlp INFIELD xccj005 name="input.c.xccj005"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccjld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccjld
            #add-point:ON ACTION controlp INFIELD xccjld name="input.c.xccjld"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccj_m.xccjld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            IF g_xccj_m.xccjcomp IS NOT NULL THEN
               LET g_qryparam.where = " glaacomp = '",g_xccj_m.xccjcomp,"'"
            END IF          
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xccj_m.xccjld = g_qryparam.return1              

            DISPLAY g_xccj_m.xccjld TO xccjld              #

            NEXT FIELD xccjld                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xccj003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj003
            #add-point:ON ACTION controlp INFIELD xccj003 name="input.c.xccj003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccj_m.xccj003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            LET g_qryparam.where = " xcat005 IN ('2','3') "
            CALL q_xcat001()                                #呼叫開窗

            LET g_xccj_m.xccj003 = g_qryparam.return1              

            DISPLAY g_xccj_m.xccj003 TO xccj003              #

            NEXT FIELD xccj003                          #返回原欄位


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
            DISPLAY BY NAME g_xccj_m.xccjld             
                            ,g_xccj_m.xccj003   
                            ,g_xccj_m.xccj004   
                            ,g_xccj_m.xccj005   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL axct302_xccj_t_mask_restore('restore_mask_o')
            
               UPDATE xccj_t SET (xccjcomp,xccj004,xccj005,xccjld,xccj003) = (g_xccj_m.xccjcomp,g_xccj_m.xccj004, 
                   g_xccj_m.xccj005,g_xccj_m.xccjld,g_xccj_m.xccj003)
                WHERE xccjent = g_enterprise AND xccjld = g_xccjld_t
                  AND xccj003 = g_xccj003_t
                  AND xccj004 = g_xccj004_t
                  AND xccj005 = g_xccj005_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xccj_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xccj_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xccj_m.xccjld
               LET gs_keys_bak[1] = g_xccjld_t
               LET gs_keys[2] = g_xccj_m.xccj003
               LET gs_keys_bak[2] = g_xccj003_t
               LET gs_keys[3] = g_xccj_m.xccj004
               LET gs_keys_bak[3] = g_xccj004_t
               LET gs_keys[4] = g_xccj_m.xccj005
               LET gs_keys_bak[4] = g_xccj005_t
               LET gs_keys[5] = g_xccj_d[g_detail_idx].xccj001
               LET gs_keys_bak[5] = g_xccj_d_t.xccj001
               LET gs_keys[6] = g_xccj_d[g_detail_idx].xccj002
               LET gs_keys_bak[6] = g_xccj_d_t.xccj002
               LET gs_keys[7] = g_xccj_d[g_detail_idx].xccj006
               LET gs_keys_bak[7] = g_xccj_d_t.xccj006
               LET gs_keys[8] = g_xccj_d[g_detail_idx].xccj007
               LET gs_keys_bak[8] = g_xccj_d_t.xccj007
               LET gs_keys[9] = g_xccj_d[g_detail_idx].xccj008
               LET gs_keys_bak[9] = g_xccj_d_t.xccj008
               LET gs_keys[10] = g_xccj_d[g_detail_idx].xccj009
               LET gs_keys_bak[10] = g_xccj_d_t.xccj009
               CALL axct302_update_b('xccj_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_xccj_m_t)
                     #LET g_log2 = util.JSON.stringify(g_xccj_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL axct302_xccj_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axct302_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_xccjld_t = g_xccj_m.xccjld
           LET g_xccj003_t = g_xccj_m.xccj003
           LET g_xccj004_t = g_xccj_m.xccj004
           LET g_xccj005_t = g_xccj_m.xccj005
 
           
           IF g_xccj_d.getLength() = 0 THEN
              NEXT FIELD xccj001
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="axct302.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_xccj_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xccj_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axct302_b_fill(g_wc2) #test 
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
            CALL axct302_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axct302_cl USING g_enterprise,g_xccj_m.xccjld,g_xccj_m.xccj003,g_xccj_m.xccj004,g_xccj_m.xccj005                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE axct302_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axct302_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_xccj_d[l_ac].xccj001 IS NOT NULL
               AND g_xccj_d[l_ac].xccj002 IS NOT NULL
               AND g_xccj_d[l_ac].xccj006 IS NOT NULL
               AND g_xccj_d[l_ac].xccj007 IS NOT NULL
               AND g_xccj_d[l_ac].xccj008 IS NOT NULL
               AND g_xccj_d[l_ac].xccj009 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xccj_d_t.* = g_xccj_d[l_ac].*  #BACKUP
               LET g_xccj_d_o.* = g_xccj_d[l_ac].*  #BACKUP
               CALL axct302_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL axct302_set_no_entry_b(l_cmd)
               OPEN axct302_bcl USING g_enterprise,g_xccj_m.xccjld,
                                                g_xccj_m.xccj003,
                                                g_xccj_m.xccj004,
                                                g_xccj_m.xccj005,
 
                                                g_xccj_d_t.xccj001
                                                ,g_xccj_d_t.xccj002
                                                ,g_xccj_d_t.xccj006
                                                ,g_xccj_d_t.xccj007
                                                ,g_xccj_d_t.xccj008
                                                ,g_xccj_d_t.xccj009
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axct302_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axct302_bcl INTO g_xccj_d[l_ac].xccj001,g_xccj_d[l_ac].xccj006,g_xccj_d[l_ac].xccj007, 
                      g_xccj_d[l_ac].xccj008,g_xccj_d[l_ac].xccj013,g_xccj_d[l_ac].xccj009,g_xccj_d[l_ac].xccj010, 
                      g_xccj_d[l_ac].xccj011,g_xccj_d[l_ac].xccj015,g_xccj_d[l_ac].xccj016,g_xccj_d[l_ac].xccj017, 
                      g_xccj_d[l_ac].xccj020,g_xccj_d[l_ac].xccj012,g_xccj_d[l_ac].xccj002,g_xccj_d[l_ac].xccj101, 
                      g_xccj_d[l_ac].xccj102,g_xccj_d[l_ac].xccj102a,g_xccj_d[l_ac].xccj102b,g_xccj_d[l_ac].xccj102c, 
                      g_xccj_d[l_ac].xccj102d,g_xccj_d[l_ac].xccj102e,g_xccj_d[l_ac].xccj102f,g_xccj_d[l_ac].xccj102g, 
                      g_xccj_d[l_ac].xccj102h
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xccj_d_t.xccj001,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xccj_d_mask_o[l_ac].* =  g_xccj_d[l_ac].*
                  CALL axct302_xccj_t_mask()
                  LET g_xccj_d_mask_n[l_ac].* =  g_xccj_d[l_ac].*
                  
                  CALL axct302_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            IF l_cmd='u' THEN
               IF g_glaa015 = 'Y' THEN
                  OPEN axct302_bcl USING g_enterprise,g_xccj_m.xccjld,
                                                g_xccj_m.xccj003,
                                                g_xccj_m.xccj004,
                                                g_xccj_m.xccj005,
 
                                                '2'
                                                ,g_xccj_d_t.xccj002
                                                ,g_xccj_d_t.xccj006
                                                ,g_xccj_d_t.xccj007
                                                ,g_xccj_d_t.xccj008
                                                ,g_xccj_d_t.xccj009
                                                
                  IF STATUS THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "OPEN axct302_bcl:xccj001=2" 
                     LET g_errparam.code   =  STATUS 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                     LET l_lock_sw='Y'
                  END IF
               END IF
               IF g_glaa019 = 'Y' THEN
                  OPEN axct302_bcl USING g_enterprise,g_xccj_m.xccjld,
                                                g_xccj_m.xccj003,
                                                g_xccj_m.xccj004,
                                                g_xccj_m.xccj005,
 
                                                '3'
                                                ,g_xccj_d_t.xccj002
                                                ,g_xccj_d_t.xccj006
                                                ,g_xccj_d_t.xccj007
                                                ,g_xccj_d_t.xccj008
                                                ,g_xccj_d_t.xccj009
                                               
                  IF STATUS THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "OPEN axct302_bcl:xccj001=3" 
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
            INITIALIZE g_xccj_d_t.* TO NULL
            INITIALIZE g_xccj_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xccj_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_xccj_d[l_ac].xccj101 = "0"
      LET g_xccj_d[l_ac].xccj102 = "0"
      LET g_xccj_d[l_ac].xccj102a = "0"
      LET g_xccj_d[l_ac].xccj102b = "0"
      LET g_xccj_d[l_ac].xccj102c = "0"
      LET g_xccj_d[l_ac].xccj102d = "0"
      LET g_xccj_d[l_ac].xccj102e = "0"
      LET g_xccj_d[l_ac].xccj102f = "0"
      LET g_xccj_d[l_ac].xccj102g = "0"
      LET g_xccj_d[l_ac].xccj102h = "0"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            LET g_xccj_d[l_ac].xccj001 = "1"
            #end add-point
            LET g_xccj_d_t.* = g_xccj_d[l_ac].*     #新輸入資料
            LET g_xccj_d_o.* = g_xccj_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axct302_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL axct302_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xccj_d[li_reproduce_target].* = g_xccj_d[li_reproduce].*
 
               LET g_xccj_d[g_xccj_d.getLength()].xccj001 = NULL
               LET g_xccj_d[g_xccj_d.getLength()].xccj002 = NULL
               LET g_xccj_d[g_xccj_d.getLength()].xccj006 = NULL
               LET g_xccj_d[g_xccj_d.getLength()].xccj007 = NULL
               LET g_xccj_d[g_xccj_d.getLength()].xccj008 = NULL
               LET g_xccj_d[g_xccj_d.getLength()].xccj009 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM xccj_t 
             WHERE xccjent = g_enterprise AND xccjld = g_xccj_m.xccjld
               AND xccj003 = g_xccj_m.xccj003
               AND xccj004 = g_xccj_m.xccj004
               AND xccj005 = g_xccj_m.xccj005
 
               AND xccj001 = g_xccj_d[l_ac].xccj001
               AND xccj002 = g_xccj_d[l_ac].xccj002
               AND xccj006 = g_xccj_d[l_ac].xccj006
               AND xccj007 = g_xccj_d[l_ac].xccj007
               AND xccj008 = g_xccj_d[l_ac].xccj008
               AND xccj009 = g_xccj_d[l_ac].xccj009
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               IF cl_null(g_xccj_d[l_ac].xccj002) THEN LET g_xccj_d[l_ac].xccj002 = ' ' END IF
               IF cl_null(g_xccj_d[l_ac].xccj011) THEN LET g_xccj_d[l_ac].xccj011 = ' ' END IF #fengmy150804
               IF cl_null(g_xccj_d[l_ac].xccj101) THEN LET g_xccj_d[l_ac].xccj101 = 0 END IF
               #end add-point
               INSERT INTO xccj_t
                           (xccjent,
                            xccjcomp,xccj004,xccj005,xccjld,xccj003,
                            xccj001,xccj002,xccj006,xccj007,xccj008,xccj009
                            ,xccj013,xccj010,xccj011,xccj015,xccj016,xccj017,xccj020,xccj012,xccj101,xccj102,xccj102a,xccj102b,xccj102c,xccj102d,xccj102e,xccj102f,xccj102g,xccj102h) 
                     VALUES(g_enterprise,
                            g_xccj_m.xccjcomp,g_xccj_m.xccj004,g_xccj_m.xccj005,g_xccj_m.xccjld,g_xccj_m.xccj003,
                            g_xccj_d[l_ac].xccj001,g_xccj_d[l_ac].xccj002,g_xccj_d[l_ac].xccj006,g_xccj_d[l_ac].xccj007, 
                                g_xccj_d[l_ac].xccj008,g_xccj_d[l_ac].xccj009
                            ,g_xccj_d[l_ac].xccj013,g_xccj_d[l_ac].xccj010,g_xccj_d[l_ac].xccj011,g_xccj_d[l_ac].xccj015, 
                                g_xccj_d[l_ac].xccj016,g_xccj_d[l_ac].xccj017,g_xccj_d[l_ac].xccj020, 
                                g_xccj_d[l_ac].xccj012,g_xccj_d[l_ac].xccj101,g_xccj_d[l_ac].xccj102, 
                                g_xccj_d[l_ac].xccj102a,g_xccj_d[l_ac].xccj102b,g_xccj_d[l_ac].xccj102c, 
                                g_xccj_d[l_ac].xccj102d,g_xccj_d[l_ac].xccj102e,g_xccj_d[l_ac].xccj102f, 
                                g_xccj_d[l_ac].xccj102g,g_xccj_d[l_ac].xccj102h)
               #add-point:單身新增中 name="input.body.m_insert"
               CALL axct302_insert_xccj()
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_xccj_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "xccj_t:",SQLERRMESSAGE 
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
               IF axct302_before_delete() THEN 
                  
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_xccj_m.xccjld
                  LET gs_keys[gs_keys.getLength()+1] = g_xccj_m.xccj003
                  LET gs_keys[gs_keys.getLength()+1] = g_xccj_m.xccj004
                  LET gs_keys[gs_keys.getLength()+1] = g_xccj_m.xccj005
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xccj_d_t.xccj001
                  LET gs_keys[gs_keys.getLength()+1] = g_xccj_d_t.xccj002
                  LET gs_keys[gs_keys.getLength()+1] = g_xccj_d_t.xccj006
                  LET gs_keys[gs_keys.getLength()+1] = g_xccj_d_t.xccj007
                  LET gs_keys[gs_keys.getLength()+1] = g_xccj_d_t.xccj008
                  LET gs_keys[gs_keys.getLength()+1] = g_xccj_d_t.xccj009
 
 
                  #刪除下層單身
                  IF NOT axct302_key_delete_b(gs_keys,'xccj_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE axct302_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axct302_bcl
               LET l_count = g_xccj_d.getLength()
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
            IF l_ac = (g_xccj_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj001
            #add-point:BEFORE FIELD xccj001 name="input.b.page1.xccj001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj001
            
            #add-point:AFTER FIELD xccj001 name="input.a.page1.xccj001"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF g_xccj_d[g_detail_idx].xccj006 <> g_xccj006 THEN 
            IF  g_xccj_m.xccjld IS NOT NULL AND g_xccj_m.xccj003 IS NOT NULL AND g_xccj_m.xccj004 IS NOT NULL AND g_xccj_m.xccj005 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj001 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj002 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj006 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj007 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj008 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj009 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj010 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj011 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccj_m.xccjld != g_xccjld_t OR g_xccj_m.xccj003 != g_xccj003_t OR g_xccj_m.xccj004 != g_xccj004_t OR g_xccj_m.xccj005 != g_xccj005_t OR g_xccj_d[g_detail_idx].xccj001 != g_xccj_d_t.xccj001 OR g_xccj_d[g_detail_idx].xccj002 != g_xccj_d_t.xccj002 OR g_xccj_d[g_detail_idx].xccj006 != g_xccj_d_t.xccj006 OR g_xccj_d[g_detail_idx].xccj007 != g_xccj_d_t.xccj007 OR g_xccj_d[g_detail_idx].xccj008 != g_xccj_d_t.xccj008 OR g_xccj_d[g_detail_idx].xccj009 != g_xccj_d_t.xccj009 OR g_xccj_d[g_detail_idx].xccj010 != g_xccj_d_t.xccj010 OR g_xccj_d[g_detail_idx].xccj011 != g_xccj_d_t.xccj011 OR g_xccj_d[g_detail_idx].xccj012 != g_xccj_d_t.xccj012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccj_t WHERE "||"xccjent = '" ||g_enterprise|| "' AND "||"xccjld = '"||g_xccj_m.xccjld ||"' AND "|| "xccj003 = '"||g_xccj_m.xccj003 ||"' AND "|| "xccj004 = '"||g_xccj_m.xccj004 ||"' AND "|| "xccj005 = '"||g_xccj_m.xccj005 ||"' AND "|| "xccj001 = '"||g_xccj_d[g_detail_idx].xccj001 ||"' AND "|| "xccj002 = '"||g_xccj_d[g_detail_idx].xccj002 ||"' AND "|| "xccj006 = '"||g_xccj_d[g_detail_idx].xccj006 ||"' AND "|| "xccj007 = '"||g_xccj_d[g_detail_idx].xccj007 ||"' AND "|| "xccj008 = '"||g_xccj_d[g_detail_idx].xccj008 ||"' AND "|| "xccj009 = '"||g_xccj_d[g_detail_idx].xccj009 ||"' AND "|| "xccj010 = '"||g_xccj_d[g_detail_idx].xccj010 ||"' AND "|| "xccj011 = '"||g_xccj_d[g_detail_idx].xccj011 ||"' AND "|| "xccj012 = '"||g_xccj_d[g_detail_idx].xccj012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccj001
            #add-point:ON CHANGE xccj001 name="input.g.page1.xccj001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj006
            #add-point:BEFORE FIELD xccj006 name="input.b.page1.xccj006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj006
            
            #add-point:AFTER FIELD xccj006 name="input.a.page1.xccj006"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF g_xccj_d[g_detail_idx].xccj006 <> g_xccj006 THEN 
            IF  g_xccj_m.xccjld IS NOT NULL AND g_xccj_m.xccj003 IS NOT NULL AND g_xccj_m.xccj004 IS NOT NULL AND g_xccj_m.xccj005 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj001 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj002 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj006 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj007 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj008 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj009 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj010 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj011 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccj_m.xccjld != g_xccjld_t OR g_xccj_m.xccj003 != g_xccj003_t OR g_xccj_m.xccj004 != g_xccj004_t OR g_xccj_m.xccj005 != g_xccj005_t OR g_xccj_d[g_detail_idx].xccj001 != g_xccj_d_t.xccj001 OR g_xccj_d[g_detail_idx].xccj002 != g_xccj_d_t.xccj002 OR g_xccj_d[g_detail_idx].xccj006 != g_xccj_d_t.xccj006 OR g_xccj_d[g_detail_idx].xccj007 != g_xccj_d_t.xccj007 OR g_xccj_d[g_detail_idx].xccj008 != g_xccj_d_t.xccj008 OR g_xccj_d[g_detail_idx].xccj009 != g_xccj_d_t.xccj009 OR g_xccj_d[g_detail_idx].xccj010 != g_xccj_d_t.xccj010 OR g_xccj_d[g_detail_idx].xccj011 != g_xccj_d_t.xccj011 OR g_xccj_d[g_detail_idx].xccj012 != g_xccj_d_t.xccj012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccj_t WHERE "||"xccjent = '" ||g_enterprise|| "' AND "||"xccjld = '"||g_xccj_m.xccjld ||"' AND "|| "xccj003 = '"||g_xccj_m.xccj003 ||"' AND "|| "xccj004 = '"||g_xccj_m.xccj004 ||"' AND "|| "xccj005 = '"||g_xccj_m.xccj005 ||"' AND "|| "xccj001 = '"||g_xccj_d[g_detail_idx].xccj001 ||"' AND "|| "xccj002 = '"||g_xccj_d[g_detail_idx].xccj002 ||"' AND "|| "xccj006 = '"||g_xccj_d[g_detail_idx].xccj006 ||"' AND "|| "xccj007 = '"||g_xccj_d[g_detail_idx].xccj007 ||"' AND "|| "xccj008 = '"||g_xccj_d[g_detail_idx].xccj008 ||"' AND "|| "xccj009 = '"||g_xccj_d[g_detail_idx].xccj009 ||"' AND "|| "xccj010 = '"||g_xccj_d[g_detail_idx].xccj010 ||"' AND "|| "xccj011 = '"||g_xccj_d[g_detail_idx].xccj011 ||"' AND "|| "xccj012 = '"||g_xccj_d[g_detail_idx].xccj012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            END IF
            CALL axct302_default_inaj()

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccj006
            #add-point:ON CHANGE xccj006 name="input.g.page1.xccj006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj007
            #add-point:BEFORE FIELD xccj007 name="input.b.page1.xccj007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj007
            
            #add-point:AFTER FIELD xccj007 name="input.a.page1.xccj007"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF g_xccj_d[g_detail_idx].xccj006 <> g_xccj006 THEN #inaj插入单号
               IF  g_xccj_m.xccjld IS NOT NULL AND g_xccj_m.xccj003 IS NOT NULL AND g_xccj_m.xccj004 IS NOT NULL AND g_xccj_m.xccj005 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj001 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj002 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj006 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj007 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj008 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj009 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj010 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj011 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj012 IS NOT NULL THEN 
                  IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccj_m.xccjld != g_xccjld_t OR g_xccj_m.xccj003 != g_xccj003_t OR g_xccj_m.xccj004 != g_xccj004_t OR g_xccj_m.xccj005 != g_xccj005_t OR g_xccj_d[g_detail_idx].xccj001 != g_xccj_d_t.xccj001 OR g_xccj_d[g_detail_idx].xccj002 != g_xccj_d_t.xccj002 OR g_xccj_d[g_detail_idx].xccj006 != g_xccj_d_t.xccj006 OR g_xccj_d[g_detail_idx].xccj007 != g_xccj_d_t.xccj007 OR g_xccj_d[g_detail_idx].xccj008 != g_xccj_d_t.xccj008 OR g_xccj_d[g_detail_idx].xccj009 != g_xccj_d_t.xccj009 OR g_xccj_d[g_detail_idx].xccj010 != g_xccj_d_t.xccj010 OR g_xccj_d[g_detail_idx].xccj011 != g_xccj_d_t.xccj011 OR g_xccj_d[g_detail_idx].xccj012 != g_xccj_d_t.xccj012)) THEN 
                     IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccj_t WHERE "||"xccjent = '" ||g_enterprise|| "' AND "||"xccjld = '"||g_xccj_m.xccjld ||"' AND "|| "xccj003 = '"||g_xccj_m.xccj003 ||"' AND "|| "xccj004 = '"||g_xccj_m.xccj004 ||"' AND "|| "xccj005 = '"||g_xccj_m.xccj005 ||"' AND "|| "xccj001 = '"||g_xccj_d[g_detail_idx].xccj001 ||"' AND "|| "xccj002 = '"||g_xccj_d[g_detail_idx].xccj002 ||"' AND "|| "xccj006 = '"||g_xccj_d[g_detail_idx].xccj006 ||"' AND "|| "xccj007 = '"||g_xccj_d[g_detail_idx].xccj007 ||"' AND "|| "xccj008 = '"||g_xccj_d[g_detail_idx].xccj008 ||"' AND "|| "xccj009 = '"||g_xccj_d[g_detail_idx].xccj009 ||"' AND "|| "xccj010 = '"||g_xccj_d[g_detail_idx].xccj010 ||"' AND "|| "xccj011 = '"||g_xccj_d[g_detail_idx].xccj011 ||"' AND "|| "xccj012 = '"||g_xccj_d[g_detail_idx].xccj012 ||"'",'std-00004',0) THEN 
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccj007
            #add-point:ON CHANGE xccj007 name="input.g.page1.xccj007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj008
            #add-point:BEFORE FIELD xccj008 name="input.b.page1.xccj008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj008
            
            #add-point:AFTER FIELD xccj008 name="input.a.page1.xccj008"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF g_xccj_d[g_detail_idx].xccj006 <> g_xccj006 THEN #inaj插入单号
            IF  g_xccj_m.xccjld IS NOT NULL AND g_xccj_m.xccj003 IS NOT NULL AND g_xccj_m.xccj004 IS NOT NULL AND g_xccj_m.xccj005 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj001 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj002 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj006 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj007 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj008 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj009 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj010 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj011 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccj_m.xccjld != g_xccjld_t OR g_xccj_m.xccj003 != g_xccj003_t OR g_xccj_m.xccj004 != g_xccj004_t OR g_xccj_m.xccj005 != g_xccj005_t OR g_xccj_d[g_detail_idx].xccj001 != g_xccj_d_t.xccj001 OR g_xccj_d[g_detail_idx].xccj002 != g_xccj_d_t.xccj002 OR g_xccj_d[g_detail_idx].xccj006 != g_xccj_d_t.xccj006 OR g_xccj_d[g_detail_idx].xccj007 != g_xccj_d_t.xccj007 OR g_xccj_d[g_detail_idx].xccj008 != g_xccj_d_t.xccj008 OR g_xccj_d[g_detail_idx].xccj009 != g_xccj_d_t.xccj009 OR g_xccj_d[g_detail_idx].xccj010 != g_xccj_d_t.xccj010 OR g_xccj_d[g_detail_idx].xccj011 != g_xccj_d_t.xccj011 OR g_xccj_d[g_detail_idx].xccj012 != g_xccj_d_t.xccj012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccj_t WHERE "||"xccjent = '" ||g_enterprise|| "' AND "||"xccjld = '"||g_xccj_m.xccjld ||"' AND "|| "xccj003 = '"||g_xccj_m.xccj003 ||"' AND "|| "xccj004 = '"||g_xccj_m.xccj004 ||"' AND "|| "xccj005 = '"||g_xccj_m.xccj005 ||"' AND "|| "xccj001 = '"||g_xccj_d[g_detail_idx].xccj001 ||"' AND "|| "xccj002 = '"||g_xccj_d[g_detail_idx].xccj002 ||"' AND "|| "xccj006 = '"||g_xccj_d[g_detail_idx].xccj006 ||"' AND "|| "xccj007 = '"||g_xccj_d[g_detail_idx].xccj007 ||"' AND "|| "xccj008 = '"||g_xccj_d[g_detail_idx].xccj008 ||"' AND "|| "xccj009 = '"||g_xccj_d[g_detail_idx].xccj009 ||"' AND "|| "xccj010 = '"||g_xccj_d[g_detail_idx].xccj010 ||"' AND "|| "xccj011 = '"||g_xccj_d[g_detail_idx].xccj011 ||"' AND "|| "xccj012 = '"||g_xccj_d[g_detail_idx].xccj012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            END IF
           
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccj008
            #add-point:ON CHANGE xccj008 name="input.g.page1.xccj008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj013
            #add-point:BEFORE FIELD xccj013 name="input.b.page1.xccj013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj013
            
            #add-point:AFTER FIELD xccj013 name="input.a.page1.xccj013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccj013
            #add-point:ON CHANGE xccj013 name="input.g.page1.xccj013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj009
            #add-point:BEFORE FIELD xccj009 name="input.b.page1.xccj009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj009
            
            #add-point:AFTER FIELD xccj009 name="input.a.page1.xccj009"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF g_xccj_d[g_detail_idx].xccj006 <> g_xccj006 THEN #inaj插入单号
            IF  g_xccj_m.xccjld IS NOT NULL AND g_xccj_m.xccj003 IS NOT NULL AND g_xccj_m.xccj004 IS NOT NULL AND g_xccj_m.xccj005 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj001 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj002 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj006 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj007 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj008 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj009 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj010 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj011 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccj_m.xccjld != g_xccjld_t OR g_xccj_m.xccj003 != g_xccj003_t OR g_xccj_m.xccj004 != g_xccj004_t OR g_xccj_m.xccj005 != g_xccj005_t OR g_xccj_d[g_detail_idx].xccj001 != g_xccj_d_t.xccj001 OR g_xccj_d[g_detail_idx].xccj002 != g_xccj_d_t.xccj002 OR g_xccj_d[g_detail_idx].xccj006 != g_xccj_d_t.xccj006 OR g_xccj_d[g_detail_idx].xccj007 != g_xccj_d_t.xccj007 OR g_xccj_d[g_detail_idx].xccj008 != g_xccj_d_t.xccj008 OR g_xccj_d[g_detail_idx].xccj009 != g_xccj_d_t.xccj009 OR g_xccj_d[g_detail_idx].xccj010 != g_xccj_d_t.xccj010 OR g_xccj_d[g_detail_idx].xccj011 != g_xccj_d_t.xccj011 OR g_xccj_d[g_detail_idx].xccj012 != g_xccj_d_t.xccj012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccj_t WHERE "||"xccjent = '" ||g_enterprise|| "' AND "||"xccjld = '"||g_xccj_m.xccjld ||"' AND "|| "xccj003 = '"||g_xccj_m.xccj003 ||"' AND "|| "xccj004 = '"||g_xccj_m.xccj004 ||"' AND "|| "xccj005 = '"||g_xccj_m.xccj005 ||"' AND "|| "xccj001 = '"||g_xccj_d[g_detail_idx].xccj001 ||"' AND "|| "xccj002 = '"||g_xccj_d[g_detail_idx].xccj002 ||"' AND "|| "xccj006 = '"||g_xccj_d[g_detail_idx].xccj006 ||"' AND "|| "xccj007 = '"||g_xccj_d[g_detail_idx].xccj007 ||"' AND "|| "xccj008 = '"||g_xccj_d[g_detail_idx].xccj008 ||"' AND "|| "xccj009 = '"||g_xccj_d[g_detail_idx].xccj009 ||"' AND "|| "xccj010 = '"||g_xccj_d[g_detail_idx].xccj010 ||"' AND "|| "xccj011 = '"||g_xccj_d[g_detail_idx].xccj011 ||"' AND "|| "xccj012 = '"||g_xccj_d[g_detail_idx].xccj012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccj009
            #add-point:ON CHANGE xccj009 name="input.g.page1.xccj009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj010
            
            #add-point:AFTER FIELD xccj010 name="input.a.page1.xccj010"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF g_xccj_d[g_detail_idx].xccj006 <> g_xccj006 THEN #inaj插入单号
            IF  g_xccj_m.xccjld IS NOT NULL AND g_xccj_m.xccj003 IS NOT NULL AND g_xccj_m.xccj004 IS NOT NULL AND g_xccj_m.xccj005 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj001 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj002 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj006 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj007 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj008 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj009 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj010 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj011 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccj_m.xccjld != g_xccjld_t OR g_xccj_m.xccj003 != g_xccj003_t OR g_xccj_m.xccj004 != g_xccj004_t OR g_xccj_m.xccj005 != g_xccj005_t OR g_xccj_d[g_detail_idx].xccj001 != g_xccj_d_t.xccj001 OR g_xccj_d[g_detail_idx].xccj002 != g_xccj_d_t.xccj002 OR g_xccj_d[g_detail_idx].xccj006 != g_xccj_d_t.xccj006 OR g_xccj_d[g_detail_idx].xccj007 != g_xccj_d_t.xccj007 OR g_xccj_d[g_detail_idx].xccj008 != g_xccj_d_t.xccj008 OR g_xccj_d[g_detail_idx].xccj009 != g_xccj_d_t.xccj009 OR g_xccj_d[g_detail_idx].xccj010 != g_xccj_d_t.xccj010 OR g_xccj_d[g_detail_idx].xccj011 != g_xccj_d_t.xccj011 OR g_xccj_d[g_detail_idx].xccj012 != g_xccj_d_t.xccj012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccj_t WHERE "||"xccjent = '" ||g_enterprise|| "' AND "||"xccjld = '"||g_xccj_m.xccjld ||"' AND "|| "xccj003 = '"||g_xccj_m.xccj003 ||"' AND "|| "xccj004 = '"||g_xccj_m.xccj004 ||"' AND "|| "xccj005 = '"||g_xccj_m.xccj005 ||"' AND "|| "xccj001 = '"||g_xccj_d[g_detail_idx].xccj001 ||"' AND "|| "xccj002 = '"||g_xccj_d[g_detail_idx].xccj002 ||"' AND "|| "xccj006 = '"||g_xccj_d[g_detail_idx].xccj006 ||"' AND "|| "xccj007 = '"||g_xccj_d[g_detail_idx].xccj007 ||"' AND "|| "xccj008 = '"||g_xccj_d[g_detail_idx].xccj008 ||"' AND "|| "xccj009 = '"||g_xccj_d[g_detail_idx].xccj009 ||"' AND "|| "xccj010 = '"||g_xccj_d[g_detail_idx].xccj010 ||"' AND "|| "xccj011 = '"||g_xccj_d[g_detail_idx].xccj011 ||"' AND "|| "xccj012 = '"||g_xccj_d[g_detail_idx].xccj012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            END IF

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccj_d[l_ac].xccj010
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccj_d[l_ac].xccj010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccj_d[l_ac].xccj010_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj010
            #add-point:BEFORE FIELD xccj010 name="input.b.page1.xccj010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccj010
            #add-point:ON CHANGE xccj010 name="input.g.page1.xccj010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj011
            #add-point:BEFORE FIELD xccj011 name="input.b.page1.xccj011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj011
            
            #add-point:AFTER FIELD xccj011 name="input.a.page1.xccj011"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF g_xccj_d[g_detail_idx].xccj006 <> g_xccj006 THEN #inaj插入单号
            IF  g_xccj_m.xccjld IS NOT NULL AND g_xccj_m.xccj003 IS NOT NULL AND g_xccj_m.xccj004 IS NOT NULL AND g_xccj_m.xccj005 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj001 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj002 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj006 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj007 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj008 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj009 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj010 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj011 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccj_m.xccjld != g_xccjld_t OR g_xccj_m.xccj003 != g_xccj003_t OR g_xccj_m.xccj004 != g_xccj004_t OR g_xccj_m.xccj005 != g_xccj005_t OR g_xccj_d[g_detail_idx].xccj001 != g_xccj_d_t.xccj001 OR g_xccj_d[g_detail_idx].xccj002 != g_xccj_d_t.xccj002 OR g_xccj_d[g_detail_idx].xccj006 != g_xccj_d_t.xccj006 OR g_xccj_d[g_detail_idx].xccj007 != g_xccj_d_t.xccj007 OR g_xccj_d[g_detail_idx].xccj008 != g_xccj_d_t.xccj008 OR g_xccj_d[g_detail_idx].xccj009 != g_xccj_d_t.xccj009 OR g_xccj_d[g_detail_idx].xccj010 != g_xccj_d_t.xccj010 OR g_xccj_d[g_detail_idx].xccj011 != g_xccj_d_t.xccj011 OR g_xccj_d[g_detail_idx].xccj012 != g_xccj_d_t.xccj012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccj_t WHERE "||"xccjent = '" ||g_enterprise|| "' AND "||"xccjld = '"||g_xccj_m.xccjld ||"' AND "|| "xccj003 = '"||g_xccj_m.xccj003 ||"' AND "|| "xccj004 = '"||g_xccj_m.xccj004 ||"' AND "|| "xccj005 = '"||g_xccj_m.xccj005 ||"' AND "|| "xccj001 = '"||g_xccj_d[g_detail_idx].xccj001 ||"' AND "|| "xccj002 = '"||g_xccj_d[g_detail_idx].xccj002 ||"' AND "|| "xccj006 = '"||g_xccj_d[g_detail_idx].xccj006 ||"' AND "|| "xccj007 = '"||g_xccj_d[g_detail_idx].xccj007 ||"' AND "|| "xccj008 = '"||g_xccj_d[g_detail_idx].xccj008 ||"' AND "|| "xccj009 = '"||g_xccj_d[g_detail_idx].xccj009 ||"' AND "|| "xccj010 = '"||g_xccj_d[g_detail_idx].xccj010 ||"' AND "|| "xccj011 = '"||g_xccj_d[g_detail_idx].xccj011 ||"' AND "|| "xccj012 = '"||g_xccj_d[g_detail_idx].xccj012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            END IF
            IF g_xccj_d[g_detail_idx].xccj011 IS NULL THEN LET g_xccj_d[g_detail_idx].xccj011 = ' ' END IF #fengmy150804
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccj011
            #add-point:ON CHANGE xccj011 name="input.g.page1.xccj011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj015
            
            #add-point:AFTER FIELD xccj015 name="input.a.page1.xccj015"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj015
            #add-point:BEFORE FIELD xccj015 name="input.b.page1.xccj015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccj015
            #add-point:ON CHANGE xccj015 name="input.g.page1.xccj015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj016
            
            #add-point:AFTER FIELD xccj016 name="input.a.page1.xccj016"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj016
            #add-point:BEFORE FIELD xccj016 name="input.b.page1.xccj016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccj016
            #add-point:ON CHANGE xccj016 name="input.g.page1.xccj016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj017
            #add-point:BEFORE FIELD xccj017 name="input.b.page1.xccj017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj017
            
            #add-point:AFTER FIELD xccj017 name="input.a.page1.xccj017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccj017
            #add-point:ON CHANGE xccj017 name="input.g.page1.xccj017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj020
            #add-point:BEFORE FIELD xccj020 name="input.b.page1.xccj020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj020
            
            #add-point:AFTER FIELD xccj020 name="input.a.page1.xccj020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccj020
            #add-point:ON CHANGE xccj020 name="input.g.page1.xccj020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj012
            #add-point:BEFORE FIELD xccj012 name="input.b.page1.xccj012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj012
            
            #add-point:AFTER FIELD xccj012 name="input.a.page1.xccj012"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF g_xccj_d[g_detail_idx].xccj006 <> g_xccj006 THEN #inaj插入单号
            IF  g_xccj_m.xccjld IS NOT NULL AND g_xccj_m.xccj003 IS NOT NULL AND g_xccj_m.xccj004 IS NOT NULL AND g_xccj_m.xccj005 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj001 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj002 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj006 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj007 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj008 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj009 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj010 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj011 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccj_m.xccjld != g_xccjld_t OR g_xccj_m.xccj003 != g_xccj003_t OR g_xccj_m.xccj004 != g_xccj004_t OR g_xccj_m.xccj005 != g_xccj005_t OR g_xccj_d[g_detail_idx].xccj001 != g_xccj_d_t.xccj001 OR g_xccj_d[g_detail_idx].xccj002 != g_xccj_d_t.xccj002 OR g_xccj_d[g_detail_idx].xccj006 != g_xccj_d_t.xccj006 OR g_xccj_d[g_detail_idx].xccj007 != g_xccj_d_t.xccj007 OR g_xccj_d[g_detail_idx].xccj008 != g_xccj_d_t.xccj008 OR g_xccj_d[g_detail_idx].xccj009 != g_xccj_d_t.xccj009 OR g_xccj_d[g_detail_idx].xccj010 != g_xccj_d_t.xccj010 OR g_xccj_d[g_detail_idx].xccj011 != g_xccj_d_t.xccj011 OR g_xccj_d[g_detail_idx].xccj012 != g_xccj_d_t.xccj012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccj_t WHERE "||"xccjent = '" ||g_enterprise|| "' AND "||"xccjld = '"||g_xccj_m.xccjld ||"' AND "|| "xccj003 = '"||g_xccj_m.xccj003 ||"' AND "|| "xccj004 = '"||g_xccj_m.xccj004 ||"' AND "|| "xccj005 = '"||g_xccj_m.xccj005 ||"' AND "|| "xccj001 = '"||g_xccj_d[g_detail_idx].xccj001 ||"' AND "|| "xccj002 = '"||g_xccj_d[g_detail_idx].xccj002 ||"' AND "|| "xccj006 = '"||g_xccj_d[g_detail_idx].xccj006 ||"' AND "|| "xccj007 = '"||g_xccj_d[g_detail_idx].xccj007 ||"' AND "|| "xccj008 = '"||g_xccj_d[g_detail_idx].xccj008 ||"' AND "|| "xccj009 = '"||g_xccj_d[g_detail_idx].xccj009 ||"' AND "|| "xccj010 = '"||g_xccj_d[g_detail_idx].xccj010 ||"' AND "|| "xccj011 = '"||g_xccj_d[g_detail_idx].xccj011 ||"' AND "|| "xccj012 = '"||g_xccj_d[g_detail_idx].xccj012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            END IF
            
            SELECT gzcb015 INTO g_xccj_d[g_detail_idx].xccj020 FROM gzcb_t
             WHERE gzcb001 = 24 AND gzcb002 = g_xccj_d[g_detail_idx].xccj012 
            IF g_xccj_d[g_detail_idx].xccj020 IS NULL THEN LET g_xccj_d[g_detail_idx].xccj020 = ' ' END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccj012
            #add-point:ON CHANGE xccj012 name="input.g.page1.xccj012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj002
            
            #add-point:AFTER FIELD xccj002 name="input.a.page1.xccj002"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF g_xccj_d[g_detail_idx].xccj006 <> g_xccj006 THEN #inaj插入单号
            IF  g_xccj_m.xccjld IS NOT NULL AND g_xccj_m.xccj003 IS NOT NULL AND g_xccj_m.xccj004 IS NOT NULL AND g_xccj_m.xccj005 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj001 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj002 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj006 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj007 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj008 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj009 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj010 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj011 IS NOT NULL AND g_xccj_d[g_detail_idx].xccj012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccj_m.xccjld != g_xccjld_t OR g_xccj_m.xccj003 != g_xccj003_t OR g_xccj_m.xccj004 != g_xccj004_t OR g_xccj_m.xccj005 != g_xccj005_t OR g_xccj_d[g_detail_idx].xccj001 != g_xccj_d_t.xccj001 OR g_xccj_d[g_detail_idx].xccj002 != g_xccj_d_t.xccj002 OR g_xccj_d[g_detail_idx].xccj006 != g_xccj_d_t.xccj006 OR g_xccj_d[g_detail_idx].xccj007 != g_xccj_d_t.xccj007 OR g_xccj_d[g_detail_idx].xccj008 != g_xccj_d_t.xccj008 OR g_xccj_d[g_detail_idx].xccj009 != g_xccj_d_t.xccj009 OR g_xccj_d[g_detail_idx].xccj010 != g_xccj_d_t.xccj010 OR g_xccj_d[g_detail_idx].xccj011 != g_xccj_d_t.xccj011 OR g_xccj_d[g_detail_idx].xccj012 != g_xccj_d_t.xccj012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccj_t WHERE "||"xccjent = '" ||g_enterprise|| "' AND "||"xccjld = '"||g_xccj_m.xccjld ||"' AND "|| "xccj003 = '"||g_xccj_m.xccj003 ||"' AND "|| "xccj004 = '"||g_xccj_m.xccj004 ||"' AND "|| "xccj005 = '"||g_xccj_m.xccj005 ||"' AND "|| "xccj001 = '"||g_xccj_d[g_detail_idx].xccj001 ||"' AND "|| "xccj002 = '"||g_xccj_d[g_detail_idx].xccj002 ||"' AND "|| "xccj006 = '"||g_xccj_d[g_detail_idx].xccj006 ||"' AND "|| "xccj007 = '"||g_xccj_d[g_detail_idx].xccj007 ||"' AND "|| "xccj008 = '"||g_xccj_d[g_detail_idx].xccj008 ||"' AND "|| "xccj009 = '"||g_xccj_d[g_detail_idx].xccj009 ||"' AND "|| "xccj010 = '"||g_xccj_d[g_detail_idx].xccj010 ||"' AND "|| "xccj011 = '"||g_xccj_d[g_detail_idx].xccj011 ||"' AND "|| "xccj012 = '"||g_xccj_d[g_detail_idx].xccj012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            END IF

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccj_m.xccjcomp
            LET g_ref_fields[2] = g_xccj_d[l_ac].xccj002
            CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp=? AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccj_d[l_ac].xccj002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccj_d[l_ac].xccj002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj002
            #add-point:BEFORE FIELD xccj002 name="input.b.page1.xccj002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccj002
            #add-point:ON CHANGE xccj002 name="input.g.page1.xccj002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj101
            #add-point:BEFORE FIELD xccj101 name="input.b.page1.xccj101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj101
            
            #add-point:AFTER FIELD xccj101 name="input.a.page1.xccj101"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccj101
            #add-point:ON CHANGE xccj101 name="input.g.page1.xccj101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj102
            #add-point:BEFORE FIELD xccj102 name="input.b.page1.xccj102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj102
            
            #add-point:AFTER FIELD xccj102 name="input.a.page1.xccj102"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccj102
            #add-point:ON CHANGE xccj102 name="input.g.page1.xccj102"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj102a
            #add-point:BEFORE FIELD xccj102a name="input.b.page1.xccj102a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj102a
            
            #add-point:AFTER FIELD xccj102a name="input.a.page1.xccj102a"
            CALL axct302_xccj102_sum_1()
            LET g_xccj_d[l_ac].xccj102a = s_curr_round(g_xccj_m.xccjcomp,g_glaa001,g_xccj_d[l_ac].xccj102a,2)
            LET g_xccj_d[l_ac].xccj102 = s_curr_round(g_xccj_m.xccjcomp,g_glaa001,g_xccj_d[l_ac].xccj102,2)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccj102a
            #add-point:ON CHANGE xccj102a name="input.g.page1.xccj102a"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj102b
            #add-point:BEFORE FIELD xccj102b name="input.b.page1.xccj102b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj102b
            
            #add-point:AFTER FIELD xccj102b name="input.a.page1.xccj102b"
            CALL axct302_xccj102_sum_1()
            LET g_xccj_d[l_ac].xccj102b = s_curr_round(g_xccj_m.xccjcomp,g_glaa001,g_xccj_d[l_ac].xccj102b,2)
            LET g_xccj_d[l_ac].xccj102 = s_curr_round(g_xccj_m.xccjcomp,g_glaa001,g_xccj_d[l_ac].xccj102,2)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccj102b
            #add-point:ON CHANGE xccj102b name="input.g.page1.xccj102b"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj102c
            #add-point:BEFORE FIELD xccj102c name="input.b.page1.xccj102c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj102c
            
            #add-point:AFTER FIELD xccj102c name="input.a.page1.xccj102c"
            CALL axct302_xccj102_sum_1()
            LET g_xccj_d[l_ac].xccj102c = s_curr_round(g_xccj_m.xccjcomp,g_glaa001,g_xccj_d[l_ac].xccj102c,2)
            LET g_xccj_d[l_ac].xccj102 = s_curr_round(g_xccj_m.xccjcomp,g_glaa001,g_xccj_d[l_ac].xccj102,2)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccj102c
            #add-point:ON CHANGE xccj102c name="input.g.page1.xccj102c"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj102d
            #add-point:BEFORE FIELD xccj102d name="input.b.page1.xccj102d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj102d
            
            #add-point:AFTER FIELD xccj102d name="input.a.page1.xccj102d"
            CALL axct302_xccj102_sum_1()
            LET g_xccj_d[l_ac].xccj102d = s_curr_round(g_xccj_m.xccjcomp,g_glaa001,g_xccj_d[l_ac].xccj102d,2)
            LET g_xccj_d[l_ac].xccj102 = s_curr_round(g_xccj_m.xccjcomp,g_glaa001,g_xccj_d[l_ac].xccj102,2)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccj102d
            #add-point:ON CHANGE xccj102d name="input.g.page1.xccj102d"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj102e
            #add-point:BEFORE FIELD xccj102e name="input.b.page1.xccj102e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj102e
            
            #add-point:AFTER FIELD xccj102e name="input.a.page1.xccj102e"
            CALL axct302_xccj102_sum_1()
            LET g_xccj_d[l_ac].xccj102e = s_curr_round(g_xccj_m.xccjcomp,g_glaa001,g_xccj_d[l_ac].xccj102e,2)
            LET g_xccj_d[l_ac].xccj102 = s_curr_round(g_xccj_m.xccjcomp,g_glaa001,g_xccj_d[l_ac].xccj102,2)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccj102e
            #add-point:ON CHANGE xccj102e name="input.g.page1.xccj102e"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj102f
            #add-point:BEFORE FIELD xccj102f name="input.b.page1.xccj102f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj102f
            
            #add-point:AFTER FIELD xccj102f name="input.a.page1.xccj102f"
            CALL axct302_xccj102_sum_1()
            LET g_xccj_d[l_ac].xccj102f = s_curr_round(g_xccj_m.xccjcomp,g_glaa001,g_xccj_d[l_ac].xccj102f,2)
            LET g_xccj_d[l_ac].xccj102 = s_curr_round(g_xccj_m.xccjcomp,g_glaa001,g_xccj_d[l_ac].xccj102,2)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccj102f
            #add-point:ON CHANGE xccj102f name="input.g.page1.xccj102f"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj102g
            #add-point:BEFORE FIELD xccj102g name="input.b.page1.xccj102g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj102g
            
            #add-point:AFTER FIELD xccj102g name="input.a.page1.xccj102g"
            CALL axct302_xccj102_sum_1()
            LET g_xccj_d[l_ac].xccj102g = s_curr_round(g_xccj_m.xccjcomp,g_glaa001,g_xccj_d[l_ac].xccj102g,2)
            LET g_xccj_d[l_ac].xccj102 = s_curr_round(g_xccj_m.xccjcomp,g_glaa001,g_xccj_d[l_ac].xccj102,2)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccj102g
            #add-point:ON CHANGE xccj102g name="input.g.page1.xccj102g"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccj102h
            #add-point:BEFORE FIELD xccj102h name="input.b.page1.xccj102h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccj102h
            
            #add-point:AFTER FIELD xccj102h name="input.a.page1.xccj102h"
            CALL axct302_xccj102_sum_1()
            LET g_xccj_d[l_ac].xccj102h = s_curr_round(g_xccj_m.xccjcomp,g_glaa001,g_xccj_d[l_ac].xccj102h,2)
            LET g_xccj_d[l_ac].xccj102 = s_curr_round(g_xccj_m.xccjcomp,g_glaa001,g_xccj_d[l_ac].xccj102,2)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccj102h
            #add-point:ON CHANGE xccj102h name="input.g.page1.xccj102h"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xccj001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj001
            #add-point:ON ACTION controlp INFIELD xccj001 name="input.c.page1.xccj001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccj006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj006
            #add-point:ON ACTION controlp INFIELD xccj006 name="input.c.page1.xccj006"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccj_d[l_ac].xccj006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_inaj001()                                #呼叫開窗

            LET g_xccj_d[l_ac].xccj006 = g_qryparam.return1              

            DISPLAY g_xccj_d[l_ac].xccj006 TO xccj006              #

            NEXT FIELD xccj006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xccj007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj007
            #add-point:ON ACTION controlp INFIELD xccj007 name="input.c.page1.xccj007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccj008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj008
            #add-point:ON ACTION controlp INFIELD xccj008 name="input.c.page1.xccj008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccj013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj013
            #add-point:ON ACTION controlp INFIELD xccj013 name="input.c.page1.xccj013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccj009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj009
            #add-point:ON ACTION controlp INFIELD xccj009 name="input.c.page1.xccj009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccj010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj010
            #add-point:ON ACTION controlp INFIELD xccj010 name="input.c.page1.xccj010"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccj_d[l_ac].xccj010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_imag001_2()                                #呼叫開窗

            LET g_xccj_d[l_ac].xccj010 = g_qryparam.return1              

            DISPLAY g_xccj_d[l_ac].xccj010 TO xccj010              #

            NEXT FIELD xccj010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xccj011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj011
            #add-point:ON ACTION controlp INFIELD xccj011 name="input.c.page1.xccj011"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccj_d[l_ac].xccj011             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_bmaa002_1()                                #呼叫開窗

            LET g_xccj_d[l_ac].xccj011 = g_qryparam.return1              

            DISPLAY g_xccj_d[l_ac].xccj011 TO xccj011              #

            NEXT FIELD xccj011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xccj015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj015
            #add-point:ON ACTION controlp INFIELD xccj015 name="input.c.page1.xccj015"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccj_d[l_ac].xccj015             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_inaa001()                                #呼叫開窗

            LET g_xccj_d[l_ac].xccj015 = g_qryparam.return1              

            DISPLAY g_xccj_d[l_ac].xccj015 TO xccj015              #

            NEXT FIELD xccj015                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xccj016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj016
            #add-point:ON ACTION controlp INFIELD xccj016 name="input.c.page1.xccj016"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccj_d[l_ac].xccj016             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_inab002_3()                                #呼叫開窗

            LET g_xccj_d[l_ac].xccj016 = g_qryparam.return1              

            DISPLAY g_xccj_d[l_ac].xccj016 TO xccj016              #

            NEXT FIELD xccj016                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xccj017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj017
            #add-point:ON ACTION controlp INFIELD xccj017 name="input.c.page1.xccj017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccj020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj020
            #add-point:ON ACTION controlp INFIELD xccj020 name="input.c.page1.xccj020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccj012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj012
            #add-point:ON ACTION controlp INFIELD xccj012 name="input.c.page1.xccj012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj002
            #add-point:ON ACTION controlp INFIELD xccj002 name="input.c.page1.xccj002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccj_d[l_ac].xccj002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_xcbf001()                                #呼叫開窗

            LET g_xccj_d[l_ac].xccj002 = g_qryparam.return1              

            DISPLAY g_xccj_d[l_ac].xccj002 TO xccj002              #

            NEXT FIELD xccj002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xccj101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj101
            #add-point:ON ACTION controlp INFIELD xccj101 name="input.c.page1.xccj101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccj102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj102
            #add-point:ON ACTION controlp INFIELD xccj102 name="input.c.page1.xccj102"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccj102a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj102a
            #add-point:ON ACTION controlp INFIELD xccj102a name="input.c.page1.xccj102a"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccj102b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj102b
            #add-point:ON ACTION controlp INFIELD xccj102b name="input.c.page1.xccj102b"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccj102c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj102c
            #add-point:ON ACTION controlp INFIELD xccj102c name="input.c.page1.xccj102c"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccj102d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj102d
            #add-point:ON ACTION controlp INFIELD xccj102d name="input.c.page1.xccj102d"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccj102e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj102e
            #add-point:ON ACTION controlp INFIELD xccj102e name="input.c.page1.xccj102e"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccj102f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj102f
            #add-point:ON ACTION controlp INFIELD xccj102f name="input.c.page1.xccj102f"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccj102g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj102g
            #add-point:ON ACTION controlp INFIELD xccj102g name="input.c.page1.xccj102g"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccj102h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccj102h
            #add-point:ON ACTION controlp INFIELD xccj102h name="input.c.page1.xccj102h"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xccj_d[l_ac].* = g_xccj_d_t.*
               CLOSE axct302_bcl
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
               LET g_errparam.extend = g_xccj_d[l_ac].xccj001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xccj_d[l_ac].* = g_xccj_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
            
               #add-point:單身修改前 name="input.body.b_update"
               IF cl_null(g_xccj_d[l_ac].xccj002) THEN LET g_xccj_d[l_ac].xccj002 = ' ' END IF
               IF cl_null(g_xccj_d[l_ac].xccj011) THEN LET g_xccj_d[l_ac].xccj011 = ' ' END IF
               IF cl_null(g_xccj_d[l_ac].xccj101) THEN LET g_xccj_d[l_ac].xccj101 = 0 END IF
               #end add-point
         
               #將遮罩欄位還原
               CALL axct302_xccj_t_mask_restore('restore_mask_o')
         
               UPDATE xccj_t SET (xccjld,xccj003,xccj004,xccj005,xccj001,xccj006,xccj007,xccj008,xccj013, 
                   xccj009,xccj010,xccj011,xccj015,xccj016,xccj017,xccj020,xccj012,xccj002,xccj101,xccj102, 
                   xccj102a,xccj102b,xccj102c,xccj102d,xccj102e,xccj102f,xccj102g,xccj102h) = (g_xccj_m.xccjld, 
                   g_xccj_m.xccj003,g_xccj_m.xccj004,g_xccj_m.xccj005,g_xccj_d[l_ac].xccj001,g_xccj_d[l_ac].xccj006, 
                   g_xccj_d[l_ac].xccj007,g_xccj_d[l_ac].xccj008,g_xccj_d[l_ac].xccj013,g_xccj_d[l_ac].xccj009, 
                   g_xccj_d[l_ac].xccj010,g_xccj_d[l_ac].xccj011,g_xccj_d[l_ac].xccj015,g_xccj_d[l_ac].xccj016, 
                   g_xccj_d[l_ac].xccj017,g_xccj_d[l_ac].xccj020,g_xccj_d[l_ac].xccj012,g_xccj_d[l_ac].xccj002, 
                   g_xccj_d[l_ac].xccj101,g_xccj_d[l_ac].xccj102,g_xccj_d[l_ac].xccj102a,g_xccj_d[l_ac].xccj102b, 
                   g_xccj_d[l_ac].xccj102c,g_xccj_d[l_ac].xccj102d,g_xccj_d[l_ac].xccj102e,g_xccj_d[l_ac].xccj102f, 
                   g_xccj_d[l_ac].xccj102g,g_xccj_d[l_ac].xccj102h)
                WHERE xccjent = g_enterprise AND xccjld = g_xccj_m.xccjld 
                 AND xccj003 = g_xccj_m.xccj003 
                 AND xccj004 = g_xccj_m.xccj004 
                 AND xccj005 = g_xccj_m.xccj005 
 
                 AND xccj001 = g_xccj_d_t.xccj001 #項次   
                 AND xccj002 = g_xccj_d_t.xccj002  
                 AND xccj006 = g_xccj_d_t.xccj006  
                 AND xccj007 = g_xccj_d_t.xccj007  
                 AND xccj008 = g_xccj_d_t.xccj008  
                 AND xccj009 = g_xccj_d_t.xccj009  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               CALL axct302_update_xccj()
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xccj_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xccj_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xccj_m.xccjld
               LET gs_keys_bak[1] = g_xccjld_t
               LET gs_keys[2] = g_xccj_m.xccj003
               LET gs_keys_bak[2] = g_xccj003_t
               LET gs_keys[3] = g_xccj_m.xccj004
               LET gs_keys_bak[3] = g_xccj004_t
               LET gs_keys[4] = g_xccj_m.xccj005
               LET gs_keys_bak[4] = g_xccj005_t
               LET gs_keys[5] = g_xccj_d[g_detail_idx].xccj001
               LET gs_keys_bak[5] = g_xccj_d_t.xccj001
               LET gs_keys[6] = g_xccj_d[g_detail_idx].xccj002
               LET gs_keys_bak[6] = g_xccj_d_t.xccj002
               LET gs_keys[7] = g_xccj_d[g_detail_idx].xccj006
               LET gs_keys_bak[7] = g_xccj_d_t.xccj006
               LET gs_keys[8] = g_xccj_d[g_detail_idx].xccj007
               LET gs_keys_bak[8] = g_xccj_d_t.xccj007
               LET gs_keys[9] = g_xccj_d[g_detail_idx].xccj008
               LET gs_keys_bak[9] = g_xccj_d_t.xccj008
               LET gs_keys[10] = g_xccj_d[g_detail_idx].xccj009
               LET gs_keys_bak[10] = g_xccj_d_t.xccj009
               CALL axct302_update_b('xccj_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_xccj_m),util.JSON.stringify(g_xccj_d_t)
                     LET g_log2 = util.JSON.stringify(g_xccj_m),util.JSON.stringify(g_xccj_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axct302_xccj_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_xccj_m.xccjld
               LET ls_keys[ls_keys.getLength()+1] = g_xccj_m.xccj003
               LET ls_keys[ls_keys.getLength()+1] = g_xccj_m.xccj004
               LET ls_keys[ls_keys.getLength()+1] = g_xccj_m.xccj005
 
               LET ls_keys[ls_keys.getLength()+1] = g_xccj_d_t.xccj001
               LET ls_keys[ls_keys.getLength()+1] = g_xccj_d_t.xccj002
               LET ls_keys[ls_keys.getLength()+1] = g_xccj_d_t.xccj006
               LET ls_keys[ls_keys.getLength()+1] = g_xccj_d_t.xccj007
               LET ls_keys[ls_keys.getLength()+1] = g_xccj_d_t.xccj008
               LET ls_keys[ls_keys.getLength()+1] = g_xccj_d_t.xccj009
 
               CALL axct302_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               CALL s_transaction_end('Y','0') #140909
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE axct302_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xccj_d[l_ac].* = g_xccj_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE axct302_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xccj_d.getLength() = 0 THEN
               NEXT FIELD xccj001
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xccj_d[li_reproduce_target].* = g_xccj_d[li_reproduce].*
 
               LET g_xccj_d[li_reproduce_target].xccj001 = NULL
               LET g_xccj_d[li_reproduce_target].xccj002 = NULL
               LET g_xccj_d[li_reproduce_target].xccj006 = NULL
               LET g_xccj_d[li_reproduce_target].xccj007 = NULL
               LET g_xccj_d[li_reproduce_target].xccj008 = NULL
               LET g_xccj_d[li_reproduce_target].xccj009 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xccj_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xccj_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
 
      
 
      
 
    
      #add-point:input段more_input name="input.more_inputarray"
      INPUT ARRAY g_xccj2_d FROM s_detail2.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = 0,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = 0)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xccj2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axct302_b_fill_2() 
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
            #add-point:資料輸入前
 
            #end add-point
         
         BEFORE ROW
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axct302_cl USING g_enterprise,
                                               g_xccj_m.xccjld
                                               ,g_xccj_m.xccj003
                                               ,g_xccj_m.xccj004
                                               ,g_xccj_m.xccj005
 
                                               
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axct302_cl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CLOSE axct302_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            
            IF g_rec_b >= l_ac 
               AND g_xccj2_d[l_ac].xccj001 IS NOT NULL
               AND g_xccj2_d[l_ac].xccj002 IS NOT NULL
               AND g_xccj2_d[l_ac].xccj006 IS NOT NULL
               AND g_xccj2_d[l_ac].xccj007 IS NOT NULL
               AND g_xccj2_d[l_ac].xccj008 IS NOT NULL
               AND g_xccj2_d[l_ac].xccj009 IS NOT NULL
               AND g_xccj2_d[l_ac].xccj010 IS NOT NULL
               AND g_xccj2_d[l_ac].xccj011 IS NOT NULL
               AND g_xccj2_d[l_ac].xccj012 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xccj2_d_t.* = g_xccj2_d[l_ac].*  #BACKUP
               LET g_xccj2_d_o.* = g_xccj2_d[l_ac].*  #BACKUP
               CALL axct302_set_entry_b(l_cmd)
               #add-point:set_entry_b後

               #end add-point
               CALL axct302_set_no_entry_b(l_cmd)
               OPEN axct302_bcl USING g_enterprise,g_xccj_m.xccjld,
                                                g_xccj_m.xccj003,
                                                g_xccj_m.xccj004,
                                                g_xccj_m.xccj005,
 
                                                g_xccj2_d_t.xccj001
                                                ,g_xccj2_d_t.xccj002
                                                ,g_xccj2_d_t.xccj006
                                                ,g_xccj2_d_t.xccj007
                                                ,g_xccj2_d_t.xccj008
                                                ,g_xccj2_d_t.xccj009
                                                
 
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axct302_bcl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axct302_bcl INTO g_xccj2_d[l_ac].xccj001,g_xccj2_d[l_ac].xccj006,g_xccj2_d[l_ac].xccj007, 
                      g_xccj2_d[l_ac].xccj008,g_xccj2_d[l_ac].xccj013,g_xccj2_d[l_ac].xccj009,g_xccj2_d[l_ac].xccj010, 
                      g_xccj2_d[l_ac].xccj011,g_xccj2_d[l_ac].xccj015,g_xccj2_d[l_ac].xccj016,g_xccj2_d[l_ac].xccj017, 
                      g_xccj2_d[l_ac].xccj020,g_xccj2_d[l_ac].xccj012,g_xccj2_d[l_ac].xccj002,g_xccj2_d[l_ac].xccj101, 
                      g_xccj2_d[l_ac].xccj102,g_xccj2_d[l_ac].xccj102a,g_xccj2_d[l_ac].xccj102b,g_xccj2_d[l_ac].xccj102c, 
                      g_xccj2_d[l_ac].xccj102d,g_xccj2_d[l_ac].xccj102e,g_xccj2_d[l_ac].xccj102f,g_xccj2_d[l_ac].xccj102g, 
                      g_xccj2_d[l_ac].xccj102h
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xccj2_d_t.xccj001 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
 
                      LET l_lock_sw = "Y"
                  END IF
                  
                  CALL axct302_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            IF l_cmd='u' THEN
               
                  OPEN axct302_bcl USING g_enterprise,g_xccj_m.xccjld,
                                                g_xccj_m.xccj003,
                                                g_xccj_m.xccj004,
                                                g_xccj_m.xccj005,
 
                                                '1'
                                                ,g_xccj2_d_t.xccj002
                                                ,g_xccj2_d_t.xccj006
                                                ,g_xccj2_d_t.xccj007
                                                ,g_xccj2_d_t.xccj008
                                                ,g_xccj2_d_t.xccj009
                                                
                  IF STATUS THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "OPEN axct302_bcl:xccj001=1" 
                     LET g_errparam.code   =  STATUS 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                     LET l_lock_sw='Y'
                  END IF
               
               IF g_glaa019 = 'Y' THEN
                  OPEN axct302_bcl USING g_enterprise,g_xccj_m.xccjld,
                                                g_xccj_m.xccj003,
                                                g_xccj_m.xccj004,
                                                g_xccj_m.xccj005,
 
                                                '3'
                                                ,g_xccj2_d_t.xccj002
                                                ,g_xccj2_d_t.xccj006
                                                ,g_xccj2_d_t.xccj007
                                                ,g_xccj2_d_t.xccj008
                                                ,g_xccj2_d_t.xccj009
                                                
                  IF STATUS THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "OPEN axct302_bcl:xccj001=3" 
                     LET g_errparam.code   =  STATUS 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                     LET l_lock_sw='Y'
                  END IF
               END IF
            END IF
            #end add-point  
            
        
         BEFORE INSERT
            
            INITIALIZE g_xccj2_d_t.* TO NULL
            INITIALIZE g_xccj2_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xccj2_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_xccj2_d[l_ac].xccj102 = "0"
      LET g_xccj2_d[l_ac].xccj102a = "0"
      LET g_xccj2_d[l_ac].xccj102b = "0"
      LET g_xccj2_d[l_ac].xccj102c = "0"
      LET g_xccj2_d[l_ac].xccj102d = "0"
      LET g_xccj2_d[l_ac].xccj102e = "0"
      LET g_xccj2_d[l_ac].xccj102f = "0"
      LET g_xccj2_d[l_ac].xccj102g = "0"
      LET g_xccj2_d[l_ac].xccj102h = "0"
 
            
            #add-point:modify段before備份

            #end add-point
            LET g_xccj2_d_t.* = g_xccj2_d[l_ac].*     #新輸入資料
            LET g_xccj2_d_o.* = g_xccj2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axct302_set_entry_b(l_cmd)
            #add-point:set_entry_b後

            #end add-point
            CALL axct302_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xccj2_d[li_reproduce_target].* = g_xccj2_d[li_reproduce].*
 
               LET g_xccj2_d[g_xccj2_d.getLength()].xccj001 = NULL
               LET g_xccj2_d[g_xccj2_d.getLength()].xccj002 = NULL
               LET g_xccj2_d[g_xccj2_d.getLength()].xccj006 = NULL
               LET g_xccj2_d[g_xccj2_d.getLength()].xccj007 = NULL
               LET g_xccj2_d[g_xccj2_d.getLength()].xccj008 = NULL
               LET g_xccj2_d[g_xccj2_d.getLength()].xccj009 = NULL
               LET g_xccj2_d[g_xccj2_d.getLength()].xccj010 = NULL
               LET g_xccj2_d[g_xccj2_d.getLength()].xccj011 = NULL
               LET g_xccj2_d[g_xccj2_d.getLength()].xccj012 = NULL
 
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
            SELECT COUNT(*) INTO l_count FROM xccj_t 
             WHERE xccjent = g_enterprise AND xccjld = g_xccj_m.xccjld
               AND xccj003 = g_xccj_m.xccj003
               AND xccj004 = g_xccj_m.xccj004
               AND xccj005 = g_xccj_m.xccj005
 
               AND xccj001 = g_xccj2_d[l_ac].xccj001
               AND xccj002 = g_xccj2_d[l_ac].xccj002
               AND xccj006 = g_xccj2_d[l_ac].xccj006
               AND xccj007 = g_xccj2_d[l_ac].xccj007
               AND xccj008 = g_xccj2_d[l_ac].xccj008
               AND xccj009 = g_xccj2_d[l_ac].xccj009
               AND xccj010 = g_xccj2_d[l_ac].xccj010
               AND xccj011 = g_xccj2_d[l_ac].xccj011
               AND xccj012 = g_xccj2_d[l_ac].xccj012
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前

               #end add-point
               INSERT INTO xccj_t
                           (xccjent,
                            xccjcomp,xccj004,xccj005,xccjld,xccj003,
                            xccj001,xccj002,xccj006,xccj007,xccj008,xccj009,xccj010,xccj011,xccj012
                            ,xccj013,xccj015,xccj016,xccj017,xccj020,xccj101,xccj102,xccj102a,xccj102b,xccj102c,xccj102d,xccj102e,xccj102f,xccj102g,xccj102h) 
                     VALUES(g_enterprise,
                            g_xccj_m.xccjcomp,g_xccj_m.xccj004,g_xccj_m.xccj005,g_xccj_m.xccjld,g_xccj_m.xccj003,
                            g_xccj2_d[l_ac].xccj001,g_xccj2_d[l_ac].xccj002,g_xccj2_d[l_ac].xccj006,g_xccj2_d[l_ac].xccj007, 
                                g_xccj2_d[l_ac].xccj008,g_xccj2_d[l_ac].xccj009,g_xccj2_d[l_ac].xccj010, 
                                g_xccj2_d[l_ac].xccj011,g_xccj2_d[l_ac].xccj012
                            ,g_xccj2_d[l_ac].xccj013,g_xccj2_d[l_ac].xccj015,g_xccj2_d[l_ac].xccj016,g_xccj2_d[l_ac].xccj017, 
                                g_xccj2_d[l_ac].xccj020,g_xccj2_d[l_ac].xccj101,g_xccj2_d[l_ac].xccj102, 
                                g_xccj2_d[l_ac].xccj102a,g_xccj2_d[l_ac].xccj102b,g_xccj2_d[l_ac].xccj102c, 
                                g_xccj2_d[l_ac].xccj102d,g_xccj2_d[l_ac].xccj102e,g_xccj2_d[l_ac].xccj102f, 
                                g_xccj2_d[l_ac].xccj102g,g_xccj2_d[l_ac].xccj102h)
               #add-point:單身新增中
               
               #end add-point
               LET p_cmd = 'u'
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               INITIALIZE g_xccj2_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xccj_t" 
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
               ERROR "INSERT O.K"
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
               IF axct302_before_delete_2() THEN 
                  
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axct302_bcl
               LET l_count = g_xccj2_d.getLength()
            END IF 
            
            #add-point:單身刪除後

            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE 

               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_xccj2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #此段落由子樣板a01產生
         BEFORE FIELD xccj001
            #add-point:BEFORE FIELD xccj001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj001
            
            #add-point:AFTER FIELD xccj001
            #此段落由子樣板a05產生
            #確認資料無重複
            IF g_xccj_d[g_detail_idx].xccj006 <> g_xccj006 THEN 
            IF  g_xccj_m.xccjld IS NOT NULL AND g_xccj_m.xccj003 IS NOT NULL AND g_xccj_m.xccj004 IS NOT NULL AND g_xccj_m.xccj005 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj001 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj002 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj006 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj007 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj008 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj009 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj010 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj011 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccj_m.xccjld != g_xccjld_t OR g_xccj_m.xccj003 != g_xccj003_t OR g_xccj_m.xccj004 != g_xccj004_t OR g_xccj_m.xccj005 != g_xccj005_t OR g_xccj2_d[g_detail_idx].xccj001 != g_xccj2_d_t.xccj001 OR g_xccj2_d[g_detail_idx].xccj002 != g_xccj2_d_t.xccj002 OR g_xccj2_d[g_detail_idx].xccj006 != g_xccj2_d_t.xccj006 OR g_xccj2_d[g_detail_idx].xccj007 != g_xccj2_d_t.xccj007 OR g_xccj2_d[g_detail_idx].xccj008 != g_xccj2_d_t.xccj008 OR g_xccj2_d[g_detail_idx].xccj009 != g_xccj2_d_t.xccj009 OR g_xccj2_d[g_detail_idx].xccj010 != g_xccj2_d_t.xccj010 OR g_xccj2_d[g_detail_idx].xccj011 != g_xccj2_d_t.xccj011 OR g_xccj2_d[g_detail_idx].xccj012 != g_xccj2_d_t.xccj012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccj_t WHERE "||"xccjent = '" ||g_enterprise|| "' AND "||"xccjld = '"||g_xccj_m.xccjld ||"' AND "|| "xccj003 = '"||g_xccj_m.xccj003 ||"' AND "|| "xccj004 = '"||g_xccj_m.xccj004 ||"' AND "|| "xccj005 = '"||g_xccj_m.xccj005 ||"' AND "|| "xccj001 = '"||g_xccj2_d[g_detail_idx].xccj001 ||"' AND "|| "xccj002 = '"||g_xccj2_d[g_detail_idx].xccj002 ||"' AND "|| "xccj006 = '"||g_xccj2_d[g_detail_idx].xccj006 ||"' AND "|| "xccj007 = '"||g_xccj2_d[g_detail_idx].xccj007 ||"' AND "|| "xccj008 = '"||g_xccj2_d[g_detail_idx].xccj008 ||"' AND "|| "xccj009 = '"||g_xccj2_d[g_detail_idx].xccj009 ||"' AND "|| "xccj010 = '"||g_xccj2_d[g_detail_idx].xccj010 ||"' AND "|| "xccj011 = '"||g_xccj2_d[g_detail_idx].xccj011 ||"' AND "|| "xccj012 = '"||g_xccj2_d[g_detail_idx].xccj012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj001
            #add-point:ON CHANGE xccj001

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj006
            #add-point:BEFORE FIELD xccj006

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj006
            
            #add-point:AFTER FIELD xccj006
            #此段落由子樣板a05產生
            #確認資料無重複
            IF g_xccj_d[g_detail_idx].xccj006 <> g_xccj006 THEN 
            IF  g_xccj_m.xccjld IS NOT NULL AND g_xccj_m.xccj003 IS NOT NULL AND g_xccj_m.xccj004 IS NOT NULL AND g_xccj_m.xccj005 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj001 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj002 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj006 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj007 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj008 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj009 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj010 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj011 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccj_m.xccjld != g_xccjld_t OR g_xccj_m.xccj003 != g_xccj003_t OR g_xccj_m.xccj004 != g_xccj004_t OR g_xccj_m.xccj005 != g_xccj005_t OR g_xccj2_d[g_detail_idx].xccj001 != g_xccj2_d_t.xccj001 OR g_xccj2_d[g_detail_idx].xccj002 != g_xccj2_d_t.xccj002 OR g_xccj2_d[g_detail_idx].xccj006 != g_xccj2_d_t.xccj006 OR g_xccj2_d[g_detail_idx].xccj007 != g_xccj2_d_t.xccj007 OR g_xccj2_d[g_detail_idx].xccj008 != g_xccj2_d_t.xccj008 OR g_xccj2_d[g_detail_idx].xccj009 != g_xccj2_d_t.xccj009 OR g_xccj2_d[g_detail_idx].xccj010 != g_xccj2_d_t.xccj010 OR g_xccj2_d[g_detail_idx].xccj011 != g_xccj2_d_t.xccj011 OR g_xccj2_d[g_detail_idx].xccj012 != g_xccj2_d_t.xccj012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccj_t WHERE "||"xccjent = '" ||g_enterprise|| "' AND "||"xccjld = '"||g_xccj_m.xccjld ||"' AND "|| "xccj003 = '"||g_xccj_m.xccj003 ||"' AND "|| "xccj004 = '"||g_xccj_m.xccj004 ||"' AND "|| "xccj005 = '"||g_xccj_m.xccj005 ||"' AND "|| "xccj001 = '"||g_xccj2_d[g_detail_idx].xccj001 ||"' AND "|| "xccj002 = '"||g_xccj2_d[g_detail_idx].xccj002 ||"' AND "|| "xccj006 = '"||g_xccj2_d[g_detail_idx].xccj006 ||"' AND "|| "xccj007 = '"||g_xccj2_d[g_detail_idx].xccj007 ||"' AND "|| "xccj008 = '"||g_xccj2_d[g_detail_idx].xccj008 ||"' AND "|| "xccj009 = '"||g_xccj2_d[g_detail_idx].xccj009 ||"' AND "|| "xccj010 = '"||g_xccj2_d[g_detail_idx].xccj010 ||"' AND "|| "xccj011 = '"||g_xccj2_d[g_detail_idx].xccj011 ||"' AND "|| "xccj012 = '"||g_xccj2_d[g_detail_idx].xccj012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj006
            #add-point:ON CHANGE xccj006

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj007
            #add-point:BEFORE FIELD xccj007

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj007
            
            #add-point:AFTER FIELD xccj007
            #此段落由子樣板a05產生
            #確認資料無重複
            IF g_xccj_d[g_detail_idx].xccj006 <> g_xccj006 THEN 
            IF  g_xccj_m.xccjld IS NOT NULL AND g_xccj_m.xccj003 IS NOT NULL AND g_xccj_m.xccj004 IS NOT NULL AND g_xccj_m.xccj005 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj001 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj002 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj006 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj007 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj008 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj009 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj010 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj011 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccj_m.xccjld != g_xccjld_t OR g_xccj_m.xccj003 != g_xccj003_t OR g_xccj_m.xccj004 != g_xccj004_t OR g_xccj_m.xccj005 != g_xccj005_t OR g_xccj2_d[g_detail_idx].xccj001 != g_xccj2_d_t.xccj001 OR g_xccj2_d[g_detail_idx].xccj002 != g_xccj2_d_t.xccj002 OR g_xccj2_d[g_detail_idx].xccj006 != g_xccj2_d_t.xccj006 OR g_xccj2_d[g_detail_idx].xccj007 != g_xccj2_d_t.xccj007 OR g_xccj2_d[g_detail_idx].xccj008 != g_xccj2_d_t.xccj008 OR g_xccj2_d[g_detail_idx].xccj009 != g_xccj2_d_t.xccj009 OR g_xccj2_d[g_detail_idx].xccj010 != g_xccj2_d_t.xccj010 OR g_xccj2_d[g_detail_idx].xccj011 != g_xccj2_d_t.xccj011 OR g_xccj2_d[g_detail_idx].xccj012 != g_xccj2_d_t.xccj012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccj_t WHERE "||"xccjent = '" ||g_enterprise|| "' AND "||"xccjld = '"||g_xccj_m.xccjld ||"' AND "|| "xccj003 = '"||g_xccj_m.xccj003 ||"' AND "|| "xccj004 = '"||g_xccj_m.xccj004 ||"' AND "|| "xccj005 = '"||g_xccj_m.xccj005 ||"' AND "|| "xccj001 = '"||g_xccj2_d[g_detail_idx].xccj001 ||"' AND "|| "xccj002 = '"||g_xccj2_d[g_detail_idx].xccj002 ||"' AND "|| "xccj006 = '"||g_xccj2_d[g_detail_idx].xccj006 ||"' AND "|| "xccj007 = '"||g_xccj2_d[g_detail_idx].xccj007 ||"' AND "|| "xccj008 = '"||g_xccj2_d[g_detail_idx].xccj008 ||"' AND "|| "xccj009 = '"||g_xccj2_d[g_detail_idx].xccj009 ||"' AND "|| "xccj010 = '"||g_xccj2_d[g_detail_idx].xccj010 ||"' AND "|| "xccj011 = '"||g_xccj2_d[g_detail_idx].xccj011 ||"' AND "|| "xccj012 = '"||g_xccj2_d[g_detail_idx].xccj012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj007
            #add-point:ON CHANGE xccj007

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj008
            #add-point:BEFORE FIELD xccj008

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj008
            
            #add-point:AFTER FIELD xccj008
            #此段落由子樣板a05產生
            #確認資料無重複
            IF g_xccj_d[g_detail_idx].xccj006 <> g_xccj006 THEN 
            IF  g_xccj_m.xccjld IS NOT NULL AND g_xccj_m.xccj003 IS NOT NULL AND g_xccj_m.xccj004 IS NOT NULL AND g_xccj_m.xccj005 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj001 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj002 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj006 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj007 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj008 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj009 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj010 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj011 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccj_m.xccjld != g_xccjld_t OR g_xccj_m.xccj003 != g_xccj003_t OR g_xccj_m.xccj004 != g_xccj004_t OR g_xccj_m.xccj005 != g_xccj005_t OR g_xccj2_d[g_detail_idx].xccj001 != g_xccj2_d_t.xccj001 OR g_xccj2_d[g_detail_idx].xccj002 != g_xccj2_d_t.xccj002 OR g_xccj2_d[g_detail_idx].xccj006 != g_xccj2_d_t.xccj006 OR g_xccj2_d[g_detail_idx].xccj007 != g_xccj2_d_t.xccj007 OR g_xccj2_d[g_detail_idx].xccj008 != g_xccj2_d_t.xccj008 OR g_xccj2_d[g_detail_idx].xccj009 != g_xccj2_d_t.xccj009 OR g_xccj2_d[g_detail_idx].xccj010 != g_xccj2_d_t.xccj010 OR g_xccj2_d[g_detail_idx].xccj011 != g_xccj2_d_t.xccj011 OR g_xccj2_d[g_detail_idx].xccj012 != g_xccj2_d_t.xccj012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccj_t WHERE "||"xccjent = '" ||g_enterprise|| "' AND "||"xccjld = '"||g_xccj_m.xccjld ||"' AND "|| "xccj003 = '"||g_xccj_m.xccj003 ||"' AND "|| "xccj004 = '"||g_xccj_m.xccj004 ||"' AND "|| "xccj005 = '"||g_xccj_m.xccj005 ||"' AND "|| "xccj001 = '"||g_xccj2_d[g_detail_idx].xccj001 ||"' AND "|| "xccj002 = '"||g_xccj2_d[g_detail_idx].xccj002 ||"' AND "|| "xccj006 = '"||g_xccj2_d[g_detail_idx].xccj006 ||"' AND "|| "xccj007 = '"||g_xccj2_d[g_detail_idx].xccj007 ||"' AND "|| "xccj008 = '"||g_xccj2_d[g_detail_idx].xccj008 ||"' AND "|| "xccj009 = '"||g_xccj2_d[g_detail_idx].xccj009 ||"' AND "|| "xccj010 = '"||g_xccj2_d[g_detail_idx].xccj010 ||"' AND "|| "xccj011 = '"||g_xccj2_d[g_detail_idx].xccj011 ||"' AND "|| "xccj012 = '"||g_xccj2_d[g_detail_idx].xccj012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            END IF

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj008
            #add-point:ON CHANGE xccj008

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj013
            #add-point:BEFORE FIELD xccj013

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj013
            
            #add-point:AFTER FIELD xccj013

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj013
            #add-point:ON CHANGE xccj013

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj009
            #add-point:BEFORE FIELD xccj009

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj009
            
            #add-point:AFTER FIELD xccj009
            #此段落由子樣板a05產生
            #確認資料無重複
            IF g_xccj_d[g_detail_idx].xccj006 <> g_xccj006 THEN 
            IF  g_xccj_m.xccjld IS NOT NULL AND g_xccj_m.xccj003 IS NOT NULL AND g_xccj_m.xccj004 IS NOT NULL AND g_xccj_m.xccj005 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj001 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj002 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj006 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj007 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj008 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj009 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj010 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj011 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccj_m.xccjld != g_xccjld_t OR g_xccj_m.xccj003 != g_xccj003_t OR g_xccj_m.xccj004 != g_xccj004_t OR g_xccj_m.xccj005 != g_xccj005_t OR g_xccj2_d[g_detail_idx].xccj001 != g_xccj2_d_t.xccj001 OR g_xccj2_d[g_detail_idx].xccj002 != g_xccj2_d_t.xccj002 OR g_xccj2_d[g_detail_idx].xccj006 != g_xccj2_d_t.xccj006 OR g_xccj2_d[g_detail_idx].xccj007 != g_xccj2_d_t.xccj007 OR g_xccj2_d[g_detail_idx].xccj008 != g_xccj2_d_t.xccj008 OR g_xccj2_d[g_detail_idx].xccj009 != g_xccj2_d_t.xccj009 OR g_xccj2_d[g_detail_idx].xccj010 != g_xccj2_d_t.xccj010 OR g_xccj2_d[g_detail_idx].xccj011 != g_xccj2_d_t.xccj011 OR g_xccj2_d[g_detail_idx].xccj012 != g_xccj2_d_t.xccj012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccj_t WHERE "||"xccjent = '" ||g_enterprise|| "' AND "||"xccjld = '"||g_xccj_m.xccjld ||"' AND "|| "xccj003 = '"||g_xccj_m.xccj003 ||"' AND "|| "xccj004 = '"||g_xccj_m.xccj004 ||"' AND "|| "xccj005 = '"||g_xccj_m.xccj005 ||"' AND "|| "xccj001 = '"||g_xccj2_d[g_detail_idx].xccj001 ||"' AND "|| "xccj002 = '"||g_xccj2_d[g_detail_idx].xccj002 ||"' AND "|| "xccj006 = '"||g_xccj2_d[g_detail_idx].xccj006 ||"' AND "|| "xccj007 = '"||g_xccj2_d[g_detail_idx].xccj007 ||"' AND "|| "xccj008 = '"||g_xccj2_d[g_detail_idx].xccj008 ||"' AND "|| "xccj009 = '"||g_xccj2_d[g_detail_idx].xccj009 ||"' AND "|| "xccj010 = '"||g_xccj2_d[g_detail_idx].xccj010 ||"' AND "|| "xccj011 = '"||g_xccj2_d[g_detail_idx].xccj011 ||"' AND "|| "xccj012 = '"||g_xccj2_d[g_detail_idx].xccj012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            END IF

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj009
            #add-point:ON CHANGE xccj009

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj010
            
            #add-point:AFTER FIELD xccj010
            #此段落由子樣板a05產生
            #確認資料無重複
            IF g_xccj_d[g_detail_idx].xccj006 <> g_xccj006 THEN 
            IF  g_xccj_m.xccjld IS NOT NULL AND g_xccj_m.xccj003 IS NOT NULL AND g_xccj_m.xccj004 IS NOT NULL AND g_xccj_m.xccj005 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj001 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj002 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj006 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj007 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj008 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj009 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj010 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj011 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccj_m.xccjld != g_xccjld_t OR g_xccj_m.xccj003 != g_xccj003_t OR g_xccj_m.xccj004 != g_xccj004_t OR g_xccj_m.xccj005 != g_xccj005_t OR g_xccj2_d[g_detail_idx].xccj001 != g_xccj2_d_t.xccj001 OR g_xccj2_d[g_detail_idx].xccj002 != g_xccj2_d_t.xccj002 OR g_xccj2_d[g_detail_idx].xccj006 != g_xccj2_d_t.xccj006 OR g_xccj2_d[g_detail_idx].xccj007 != g_xccj2_d_t.xccj007 OR g_xccj2_d[g_detail_idx].xccj008 != g_xccj2_d_t.xccj008 OR g_xccj2_d[g_detail_idx].xccj009 != g_xccj2_d_t.xccj009 OR g_xccj2_d[g_detail_idx].xccj010 != g_xccj2_d_t.xccj010 OR g_xccj2_d[g_detail_idx].xccj011 != g_xccj2_d_t.xccj011 OR g_xccj2_d[g_detail_idx].xccj012 != g_xccj2_d_t.xccj012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccj_t WHERE "||"xccjent = '" ||g_enterprise|| "' AND "||"xccjld = '"||g_xccj_m.xccjld ||"' AND "|| "xccj003 = '"||g_xccj_m.xccj003 ||"' AND "|| "xccj004 = '"||g_xccj_m.xccj004 ||"' AND "|| "xccj005 = '"||g_xccj_m.xccj005 ||"' AND "|| "xccj001 = '"||g_xccj2_d[g_detail_idx].xccj001 ||"' AND "|| "xccj002 = '"||g_xccj2_d[g_detail_idx].xccj002 ||"' AND "|| "xccj006 = '"||g_xccj2_d[g_detail_idx].xccj006 ||"' AND "|| "xccj007 = '"||g_xccj2_d[g_detail_idx].xccj007 ||"' AND "|| "xccj008 = '"||g_xccj2_d[g_detail_idx].xccj008 ||"' AND "|| "xccj009 = '"||g_xccj2_d[g_detail_idx].xccj009 ||"' AND "|| "xccj010 = '"||g_xccj2_d[g_detail_idx].xccj010 ||"' AND "|| "xccj011 = '"||g_xccj2_d[g_detail_idx].xccj011 ||"' AND "|| "xccj012 = '"||g_xccj2_d[g_detail_idx].xccj012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            END IF

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccj2_d[l_ac].xccj010
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccj2_d[l_ac].xccj010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccj2_d[l_ac].xccj010_desc


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj010
            #add-point:BEFORE FIELD xccj010

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xccj010
            #add-point:ON CHANGE xccj010

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj011
            #add-point:BEFORE FIELD xccj011

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj011
            
            #add-point:AFTER FIELD xccj011
            #此段落由子樣板a05產生
            #確認資料無重複
            IF g_xccj_d[g_detail_idx].xccj006 <> g_xccj006 THEN 
            IF  g_xccj_m.xccjld IS NOT NULL AND g_xccj_m.xccj003 IS NOT NULL AND g_xccj_m.xccj004 IS NOT NULL AND g_xccj_m.xccj005 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj001 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj002 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj006 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj007 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj008 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj009 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj010 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj011 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccj_m.xccjld != g_xccjld_t OR g_xccj_m.xccj003 != g_xccj003_t OR g_xccj_m.xccj004 != g_xccj004_t OR g_xccj_m.xccj005 != g_xccj005_t OR g_xccj2_d[g_detail_idx].xccj001 != g_xccj2_d_t.xccj001 OR g_xccj2_d[g_detail_idx].xccj002 != g_xccj2_d_t.xccj002 OR g_xccj2_d[g_detail_idx].xccj006 != g_xccj2_d_t.xccj006 OR g_xccj2_d[g_detail_idx].xccj007 != g_xccj2_d_t.xccj007 OR g_xccj2_d[g_detail_idx].xccj008 != g_xccj2_d_t.xccj008 OR g_xccj2_d[g_detail_idx].xccj009 != g_xccj2_d_t.xccj009 OR g_xccj2_d[g_detail_idx].xccj010 != g_xccj2_d_t.xccj010 OR g_xccj2_d[g_detail_idx].xccj011 != g_xccj2_d_t.xccj011 OR g_xccj2_d[g_detail_idx].xccj012 != g_xccj2_d_t.xccj012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccj_t WHERE "||"xccjent = '" ||g_enterprise|| "' AND "||"xccjld = '"||g_xccj_m.xccjld ||"' AND "|| "xccj003 = '"||g_xccj_m.xccj003 ||"' AND "|| "xccj004 = '"||g_xccj_m.xccj004 ||"' AND "|| "xccj005 = '"||g_xccj_m.xccj005 ||"' AND "|| "xccj001 = '"||g_xccj2_d[g_detail_idx].xccj001 ||"' AND "|| "xccj002 = '"||g_xccj2_d[g_detail_idx].xccj002 ||"' AND "|| "xccj006 = '"||g_xccj2_d[g_detail_idx].xccj006 ||"' AND "|| "xccj007 = '"||g_xccj2_d[g_detail_idx].xccj007 ||"' AND "|| "xccj008 = '"||g_xccj2_d[g_detail_idx].xccj008 ||"' AND "|| "xccj009 = '"||g_xccj2_d[g_detail_idx].xccj009 ||"' AND "|| "xccj010 = '"||g_xccj2_d[g_detail_idx].xccj010 ||"' AND "|| "xccj011 = '"||g_xccj2_d[g_detail_idx].xccj011 ||"' AND "|| "xccj012 = '"||g_xccj2_d[g_detail_idx].xccj012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj011
            #add-point:ON CHANGE xccj011

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj015
            
            #add-point:AFTER FIELD xccj015


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj015
            #add-point:BEFORE FIELD xccj015

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xccj015
            #add-point:ON CHANGE xccj015

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj016
            
            #add-point:AFTER FIELD xccj016


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj016
            #add-point:BEFORE FIELD xccj016

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xccj016
            #add-point:ON CHANGE xccj016

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj017
            #add-point:BEFORE FIELD xccj017

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj017
            
            #add-point:AFTER FIELD xccj017

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj017
            #add-point:ON CHANGE xccj017

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj020
            #add-point:BEFORE FIELD xccj020

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj020
            
            #add-point:AFTER FIELD xccj020

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj020
            #add-point:ON CHANGE xccj020

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj012
            #add-point:BEFORE FIELD xccj012

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj012
            
            #add-point:AFTER FIELD xccj012
            #此段落由子樣板a05產生
            #確認資料無重複
            IF g_xccj_d[g_detail_idx].xccj006 <> g_xccj006 THEN 
            IF  g_xccj_m.xccjld IS NOT NULL AND g_xccj_m.xccj003 IS NOT NULL AND g_xccj_m.xccj004 IS NOT NULL AND g_xccj_m.xccj005 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj001 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj002 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj006 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj007 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj008 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj009 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj010 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj011 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccj_m.xccjld != g_xccjld_t OR g_xccj_m.xccj003 != g_xccj003_t OR g_xccj_m.xccj004 != g_xccj004_t OR g_xccj_m.xccj005 != g_xccj005_t OR g_xccj2_d[g_detail_idx].xccj001 != g_xccj2_d_t.xccj001 OR g_xccj2_d[g_detail_idx].xccj002 != g_xccj2_d_t.xccj002 OR g_xccj2_d[g_detail_idx].xccj006 != g_xccj2_d_t.xccj006 OR g_xccj2_d[g_detail_idx].xccj007 != g_xccj2_d_t.xccj007 OR g_xccj2_d[g_detail_idx].xccj008 != g_xccj2_d_t.xccj008 OR g_xccj2_d[g_detail_idx].xccj009 != g_xccj2_d_t.xccj009 OR g_xccj2_d[g_detail_idx].xccj010 != g_xccj2_d_t.xccj010 OR g_xccj2_d[g_detail_idx].xccj011 != g_xccj2_d_t.xccj011 OR g_xccj2_d[g_detail_idx].xccj012 != g_xccj2_d_t.xccj012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccj_t WHERE "||"xccjent = '" ||g_enterprise|| "' AND "||"xccjld = '"||g_xccj_m.xccjld ||"' AND "|| "xccj003 = '"||g_xccj_m.xccj003 ||"' AND "|| "xccj004 = '"||g_xccj_m.xccj004 ||"' AND "|| "xccj005 = '"||g_xccj_m.xccj005 ||"' AND "|| "xccj001 = '"||g_xccj2_d[g_detail_idx].xccj001 ||"' AND "|| "xccj002 = '"||g_xccj2_d[g_detail_idx].xccj002 ||"' AND "|| "xccj006 = '"||g_xccj2_d[g_detail_idx].xccj006 ||"' AND "|| "xccj007 = '"||g_xccj2_d[g_detail_idx].xccj007 ||"' AND "|| "xccj008 = '"||g_xccj2_d[g_detail_idx].xccj008 ||"' AND "|| "xccj009 = '"||g_xccj2_d[g_detail_idx].xccj009 ||"' AND "|| "xccj010 = '"||g_xccj2_d[g_detail_idx].xccj010 ||"' AND "|| "xccj011 = '"||g_xccj2_d[g_detail_idx].xccj011 ||"' AND "|| "xccj012 = '"||g_xccj2_d[g_detail_idx].xccj012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            END IF

            
            SELECT gzcb015 INTO g_xccj2_d[g_detail_idx].xccj020 FROM gzcb_t
             WHERE gzcb001 = 24 AND gzcb002 = g_xccj2_d[g_detail_idx].xccj012 
            IF g_xccj2_d[g_detail_idx].xccj020 IS NULL THEN LET g_xccj2_d[g_detail_idx].xccj020 = ' ' END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj012
            #add-point:ON CHANGE xccj012

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj002
            
            #add-point:AFTER FIELD xccj002
            #此段落由子樣板a05產生
            #確認資料無重複
            IF g_xccj_d[g_detail_idx].xccj006 <> g_xccj006 THEN 
            IF  g_xccj_m.xccjld IS NOT NULL AND g_xccj_m.xccj003 IS NOT NULL AND g_xccj_m.xccj004 IS NOT NULL AND g_xccj_m.xccj005 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj001 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj002 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj006 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj007 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj008 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj009 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj010 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj011 IS NOT NULL AND g_xccj2_d[g_detail_idx].xccj012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccj_m.xccjld != g_xccjld_t OR g_xccj_m.xccj003 != g_xccj003_t OR g_xccj_m.xccj004 != g_xccj004_t OR g_xccj_m.xccj005 != g_xccj005_t OR g_xccj2_d[g_detail_idx].xccj001 != g_xccj2_d_t.xccj001 OR g_xccj2_d[g_detail_idx].xccj002 != g_xccj2_d_t.xccj002 OR g_xccj2_d[g_detail_idx].xccj006 != g_xccj2_d_t.xccj006 OR g_xccj2_d[g_detail_idx].xccj007 != g_xccj2_d_t.xccj007 OR g_xccj2_d[g_detail_idx].xccj008 != g_xccj2_d_t.xccj008 OR g_xccj2_d[g_detail_idx].xccj009 != g_xccj2_d_t.xccj009 OR g_xccj2_d[g_detail_idx].xccj010 != g_xccj2_d_t.xccj010 OR g_xccj2_d[g_detail_idx].xccj011 != g_xccj2_d_t.xccj011 OR g_xccj2_d[g_detail_idx].xccj012 != g_xccj2_d_t.xccj012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccj_t WHERE "||"xccjent = '" ||g_enterprise|| "' AND "||"xccjld = '"||g_xccj_m.xccjld ||"' AND "|| "xccj003 = '"||g_xccj_m.xccj003 ||"' AND "|| "xccj004 = '"||g_xccj_m.xccj004 ||"' AND "|| "xccj005 = '"||g_xccj_m.xccj005 ||"' AND "|| "xccj001 = '"||g_xccj2_d[g_detail_idx].xccj001 ||"' AND "|| "xccj002 = '"||g_xccj2_d[g_detail_idx].xccj002 ||"' AND "|| "xccj006 = '"||g_xccj2_d[g_detail_idx].xccj006 ||"' AND "|| "xccj007 = '"||g_xccj2_d[g_detail_idx].xccj007 ||"' AND "|| "xccj008 = '"||g_xccj2_d[g_detail_idx].xccj008 ||"' AND "|| "xccj009 = '"||g_xccj2_d[g_detail_idx].xccj009 ||"' AND "|| "xccj010 = '"||g_xccj2_d[g_detail_idx].xccj010 ||"' AND "|| "xccj011 = '"||g_xccj2_d[g_detail_idx].xccj011 ||"' AND "|| "xccj012 = '"||g_xccj2_d[g_detail_idx].xccj012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccj_m.xccjcomp
            LET g_ref_fields[2] = g_xccj2_d[l_ac].xccj002
            CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp=? AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccj2_d[l_ac].xccj002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccj2_d[l_ac].xccj002_desc


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj002
            #add-point:BEFORE FIELD xccj002

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xccj002
            #add-point:ON CHANGE xccj002

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj101
            #add-point:BEFORE FIELD xccj101

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj101
            
            #add-point:AFTER FIELD xccj101

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj101
            #add-point:ON CHANGE xccj101

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj102_2
            #add-point:BEFORE FIELD xccj102

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj102_2
            
            #add-point:AFTER FIELD xccj102

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj102_2
            #add-point:ON CHANGE xccj102

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj102a_2
            #add-point:BEFORE FIELD xccj102a

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj102a_2
            
            #add-point:AFTER FIELD xccj102a
            CALL axct302_xccj102_sum_2()
            LET g_xccj2_d[l_ac].xccj102a = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102a,2)
            LET g_xccj2_d[l_ac].xccj102 = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102,2)
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj102a_2
            #add-point:ON CHANGE xccj102a

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj102b_2
            #add-point:BEFORE FIELD xccj102b

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj102b_2
            
            #add-point:AFTER FIELD xccj102b
            CALL axct302_xccj102_sum_2()
            LET g_xccj2_d[l_ac].xccj102b = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102b,2)
            LET g_xccj2_d[l_ac].xccj102 = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102,2)
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj102b_2
            #add-point:ON CHANGE xccj102b

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj102c_2
            #add-point:BEFORE FIELD xccj102c

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj102c_2
            
            #add-point:AFTER FIELD xccj102c
            CALL axct302_xccj102_sum_2()
            LET g_xccj2_d[l_ac].xccj102c = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102c,2)
            LET g_xccj2_d[l_ac].xccj102 = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102,2)
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj102c_2
            #add-point:ON CHANGE xccj102c

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj102d_2
            #add-point:BEFORE FIELD xccj102d

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj102d_2
            
            #add-point:AFTER FIELD xccj102d
            CALL axct302_xccj102_sum_2()
            LET g_xccj2_d[l_ac].xccj102d = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102d,2)
            LET g_xccj2_d[l_ac].xccj102 = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102,2)
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj102d_2
            #add-point:ON CHANGE xccj102d

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj102e_2
            #add-point:BEFORE FIELD xccj102e

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj102e_2
            
            #add-point:AFTER FIELD xccj102e
            CALL axct302_xccj102_sum_2()
            LET g_xccj2_d[l_ac].xccj102e = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102e,2)
            LET g_xccj2_d[l_ac].xccj102 = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102,2)
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj102e_2
            #add-point:ON CHANGE xccj102e

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj102f_2
            #add-point:BEFORE FIELD xccj102f

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj102f_2
            
            #add-point:AFTER FIELD xccj102f
            CALL axct302_xccj102_sum_2()
            LET g_xccj2_d[l_ac].xccj102f = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102f,2)
            LET g_xccj2_d[l_ac].xccj102 = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102,2)
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj102f_2
            #add-point:ON CHANGE xccj102f

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj102g_2
            #add-point:BEFORE FIELD xccj102g

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj102g_2
            
            #add-point:AFTER FIELD xccj102g
            CALL axct302_xccj102_sum_2()
            LET g_xccj2_d[l_ac].xccj102g = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102g,2)
            LET g_xccj2_d[l_ac].xccj102 = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102,2)
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj102g_2
            #add-point:ON CHANGE xccj102g

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj102h_2
            #add-point:BEFORE FIELD xccj102h

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj102h_2
            
            #add-point:AFTER FIELD xccj102h
            CALL axct302_xccj102_sum_2()
            LET g_xccj2_d[l_ac].xccj102h = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102h,2)
            LET g_xccj2_d[l_ac].xccj102 = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102,2)
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj102h_2
            #add-point:ON CHANGE xccj102h

            #END add-point
 
 
                  #Ctrlp:input.c.page1.xccj001
         ON ACTION controlp INFIELD xccj001
            #add-point:ON ACTION controlp INFIELD xccj001

            #END add-point
 
         #Ctrlp:input.c.page1.xccj006
         ON ACTION controlp INFIELD xccj006
            #add-point:ON ACTION controlp INFIELD xccj006
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccj2_d[l_ac].xccj006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_inaj001()                                #呼叫開窗

            LET g_xccj2_d[l_ac].xccj006 = g_qryparam.return1              

            DISPLAY g_xccj2_d[l_ac].xccj006 TO xccj006              #

            NEXT FIELD xccj006                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xccj007
         ON ACTION controlp INFIELD xccj007
            #add-point:ON ACTION controlp INFIELD xccj007

            #END add-point
 
         #Ctrlp:input.c.page1.xccj008
         ON ACTION controlp INFIELD xccj008
            #add-point:ON ACTION controlp INFIELD xccj008

            #END add-point
 
         #Ctrlp:input.c.page1.xccj013
         ON ACTION controlp INFIELD xccj013
            #add-point:ON ACTION controlp INFIELD xccj013

            #END add-point
 
         #Ctrlp:input.c.page1.xccj009
         ON ACTION controlp INFIELD xccj009
            #add-point:ON ACTION controlp INFIELD xccj009

            #END add-point
 
         #Ctrlp:input.c.page1.xccj010
         ON ACTION controlp INFIELD xccj010
            #add-point:ON ACTION controlp INFIELD xccj010
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccj2_d[l_ac].xccj010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_imag001_2()                                #呼叫開窗

            LET g_xccj2_d[l_ac].xccj010 = g_qryparam.return1              

            DISPLAY g_xccj2_d[l_ac].xccj010 TO xccj010              #

            NEXT FIELD xccj010                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xccj011
         ON ACTION controlp INFIELD xccj011
            #add-point:ON ACTION controlp INFIELD xccj011
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccj2_d[l_ac].xccj011             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_bmaa002_1()                                #呼叫開窗

            LET g_xccj2_d[l_ac].xccj011 = g_qryparam.return1              

            DISPLAY g_xccj2_d[l_ac].xccj011 TO xccj011              #

            NEXT FIELD xccj011                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xccj015
         ON ACTION controlp INFIELD xccj015
            #add-point:ON ACTION controlp INFIELD xccj015
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccj2_d[l_ac].xccj015             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_inaa001()                                #呼叫開窗

            LET g_xccj2_d[l_ac].xccj015 = g_qryparam.return1              

            DISPLAY g_xccj2_d[l_ac].xccj015 TO xccj015              #

            NEXT FIELD xccj015                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xccj016
         ON ACTION controlp INFIELD xccj016
            #add-point:ON ACTION controlp INFIELD xccj016
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccj2_d[l_ac].xccj016             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_inab002_3()                                #呼叫開窗

            LET g_xccj2_d[l_ac].xccj016 = g_qryparam.return1              

            DISPLAY g_xccj2_d[l_ac].xccj016 TO xccj016              #

            NEXT FIELD xccj016                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xccj017
         ON ACTION controlp INFIELD xccj017
            #add-point:ON ACTION controlp INFIELD xccj017

            #END add-point
 
         #Ctrlp:input.c.page1.xccj020
         ON ACTION controlp INFIELD xccj020
            #add-point:ON ACTION controlp INFIELD xccj020

            #END add-point
 
         #Ctrlp:input.c.page1.xccj012
         ON ACTION controlp INFIELD xccj012
            #add-point:ON ACTION controlp INFIELD xccj012

            #END add-point
 
         #Ctrlp:input.c.page1.xccj002
         ON ACTION controlp INFIELD xccj002
            #add-point:ON ACTION controlp INFIELD xccj002
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccj2_d[l_ac].xccj002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_xcbf001()                                #呼叫開窗

            LET g_xccj2_d[l_ac].xccj002 = g_qryparam.return1              

            DISPLAY g_xccj2_d[l_ac].xccj002 TO xccj002              #

            NEXT FIELD xccj002                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xccj101
         ON ACTION controlp INFIELD xccj101
            #add-point:ON ACTION controlp INFIELD xccj101

            #END add-point
 
         #Ctrlp:input.c.page1.xccj102
         ON ACTION controlp INFIELD xccj102
            #add-point:ON ACTION controlp INFIELD xccj102

            #END add-point
 
         #Ctrlp:input.c.page1.xccj102a
         ON ACTION controlp INFIELD xccj102a
            #add-point:ON ACTION controlp INFIELD xccj102a

            #END add-point
 
         #Ctrlp:input.c.page1.xccj102b
         ON ACTION controlp INFIELD xccj102b
            #add-point:ON ACTION controlp INFIELD xccj102b

            #END add-point
 
         #Ctrlp:input.c.page1.xccj102c
         ON ACTION controlp INFIELD xccj102c
            #add-point:ON ACTION controlp INFIELD xccj102c

            #END add-point
 
         #Ctrlp:input.c.page1.xccj102d
         ON ACTION controlp INFIELD xccj102d
            #add-point:ON ACTION controlp INFIELD xccj102d

            #END add-point
 
         #Ctrlp:input.c.page1.xccj102e
         ON ACTION controlp INFIELD xccj102e
            #add-point:ON ACTION controlp INFIELD xccj102e

            #END add-point
 
         #Ctrlp:input.c.page1.xccj102f
         ON ACTION controlp INFIELD xccj102f
            #add-point:ON ACTION controlp INFIELD xccj102f

            #END add-point
 
         #Ctrlp:input.c.page1.xccj102g
         ON ACTION controlp INFIELD xccj102g
            #add-point:ON ACTION controlp INFIELD xccj102g

            #END add-point
 
         #Ctrlp:input.c.page1.xccj102h
         ON ACTION controlp INFIELD xccj102h
            #add-point:ON ACTION controlp INFIELD xccj102h

            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_xccj2_d[l_ac].* = g_xccj2_d_t.*
               CLOSE axct302_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xccj2_d[l_ac].xccj001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               LET g_xccj2_d[l_ac].* = g_xccj2_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
            
               #add-point:單身修改前

               #end add-point
         
               UPDATE xccj_t SET (xccjld,xccj003,xccj004,xccj005,xccj001,xccj006,xccj007,xccj008,xccj013, 
                   xccj009,xccj010,xccj011,xccj015,xccj016,xccj017,xccj020,xccj012,xccj002,xccj101,xccj102, 
                   xccj102a,xccj102b,xccj102c,xccj102d,xccj102e,xccj102f,xccj102g,xccj102h) = (g_xccj_m.xccjld, 
                   g_xccj_m.xccj003,g_xccj_m.xccj004,g_xccj_m.xccj005,g_xccj2_d[l_ac].xccj001,g_xccj2_d[l_ac].xccj006, 
                   g_xccj2_d[l_ac].xccj007,g_xccj2_d[l_ac].xccj008,g_xccj2_d[l_ac].xccj013,g_xccj2_d[l_ac].xccj009, 
                   g_xccj2_d[l_ac].xccj010,g_xccj2_d[l_ac].xccj011,g_xccj2_d[l_ac].xccj015,g_xccj2_d[l_ac].xccj016, 
                   g_xccj2_d[l_ac].xccj017,g_xccj2_d[l_ac].xccj020,g_xccj2_d[l_ac].xccj012,g_xccj2_d[l_ac].xccj002, 
                   g_xccj2_d[l_ac].xccj101,g_xccj2_d[l_ac].xccj102,g_xccj2_d[l_ac].xccj102a,g_xccj2_d[l_ac].xccj102b, 
                   g_xccj2_d[l_ac].xccj102c,g_xccj2_d[l_ac].xccj102d,g_xccj2_d[l_ac].xccj102e,g_xccj2_d[l_ac].xccj102f, 
                   g_xccj2_d[l_ac].xccj102g,g_xccj2_d[l_ac].xccj102h)
                WHERE xccjent = g_enterprise AND xccjld = g_xccj_m.xccjld 
                 AND xccj003 = g_xccj_m.xccj003 
                 AND xccj004 = g_xccj_m.xccj004 
                 AND xccj005 = g_xccj_m.xccj005 
 
                 AND xccj001 = g_xccj2_d_t.xccj001 #項次   
                 AND xccj002 = g_xccj2_d_t.xccj002  
                 AND xccj006 = g_xccj2_d_t.xccj006  
                 AND xccj007 = g_xccj2_d_t.xccj007  
                 AND xccj008 = g_xccj2_d_t.xccj008  
                 AND xccj009 = g_xccj2_d_t.xccj009  
#                 AND xccj010 = g_xccj2_d_t.xccj010  
#                 AND xccj011 = g_xccj2_d_t.xccj011  
#                 AND xccj012 = g_xccj2_d_t.xccj012  
# 
                 
               #add-point:單身修改中
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xccj_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xccj_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
 
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xccj_m.xccjld
               LET gs_keys_bak[1] = g_xccjld_t
               LET gs_keys[2] = g_xccj_m.xccj003
               LET gs_keys_bak[2] = g_xccj003_t
               LET gs_keys[3] = g_xccj_m.xccj004
               LET gs_keys_bak[3] = g_xccj004_t
               LET gs_keys[4] = g_xccj_m.xccj005
               LET gs_keys_bak[4] = g_xccj005_t
               LET gs_keys[5] = g_xccj2_d[g_detail_idx].xccj001
               LET gs_keys_bak[5] = g_xccj2_d_t.xccj001
               LET gs_keys[6] = g_xccj2_d[g_detail_idx].xccj002
               LET gs_keys_bak[6] = g_xccj2_d_t.xccj002
               LET gs_keys[7] = g_xccj2_d[g_detail_idx].xccj006
               LET gs_keys_bak[7] = g_xccj2_d_t.xccj006
               LET gs_keys[8] = g_xccj2_d[g_detail_idx].xccj007
               LET gs_keys_bak[8] = g_xccj2_d_t.xccj007
               LET gs_keys[9] = g_xccj2_d[g_detail_idx].xccj008
               LET gs_keys_bak[9] = g_xccj2_d_t.xccj008
               LET gs_keys[10] = g_xccj2_d[g_detail_idx].xccj009
               LET gs_keys_bak[10] = g_xccj2_d_t.xccj009
               LET gs_keys[11] = g_xccj2_d[g_detail_idx].xccj010
               LET gs_keys_bak[11] = g_xccj2_d_t.xccj010
               LET gs_keys[12] = g_xccj2_d[g_detail_idx].xccj011
               LET gs_keys_bak[12] = g_xccj2_d_t.xccj011
               LET gs_keys[13] = g_xccj2_d[g_detail_idx].xccj012
               LET gs_keys_bak[13] = g_xccj2_d_t.xccj012
               CALL axct302_update_b('xccj_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     LET g_log1 = util.JSON.stringify(g_xccj_m),util.JSON.stringify(g_xccj2_d_t)
                     LET g_log2 = util.JSON.stringify(g_xccj_m),util.JSON.stringify(g_xccj2_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #add-point:單身修改後
               CALL s_transaction_end('Y','0') #140909
               #end add-point
            END IF
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xccj2_d.getLength() = 0 THEN
               NEXT FIELD xccj001
            END IF
            #add-point:input段after input 

            #end add-point    
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_xccj2_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_xccj2_d.getLength()+1
            
      END INPUT
      INPUT ARRAY g_xccj3_d FROM s_detail3.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = 0,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = 0)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xccj3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axct302_b_fill_3() 
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
            #add-point:資料輸入前

            #end add-point
         
         BEFORE ROW
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axct302_cl USING g_enterprise,
                                               g_xccj_m.xccjld
                                               ,g_xccj_m.xccj003
                                               ,g_xccj_m.xccj004
                                               ,g_xccj_m.xccj005
 
                                               
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axct302_cl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CLOSE axct302_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            
            IF g_rec_b >= l_ac 
               AND g_xccj3_d[l_ac].xccj001 IS NOT NULL
               AND g_xccj3_d[l_ac].xccj002 IS NOT NULL
               AND g_xccj3_d[l_ac].xccj006 IS NOT NULL
               AND g_xccj3_d[l_ac].xccj007 IS NOT NULL
               AND g_xccj3_d[l_ac].xccj008 IS NOT NULL
               AND g_xccj3_d[l_ac].xccj009 IS NOT NULL
               AND g_xccj3_d[l_ac].xccj010 IS NOT NULL
               AND g_xccj3_d[l_ac].xccj011 IS NOT NULL
               AND g_xccj3_d[l_ac].xccj012 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xccj3_d_t.* = g_xccj3_d[l_ac].*  #BACKUP
               LET g_xccj3_d_o.* = g_xccj3_d[l_ac].*  #BACKUP
               CALL axct302_set_entry_b(l_cmd)
               #add-point:set_entry_b後

               #end add-point
               CALL axct302_set_no_entry_b(l_cmd)
               OPEN axct302_bcl USING g_enterprise,g_xccj_m.xccjld,
                                                g_xccj_m.xccj003,
                                                g_xccj_m.xccj004,
                                                g_xccj_m.xccj005,
 
                                                g_xccj3_d_t.xccj001
                                                ,g_xccj3_d_t.xccj002
                                                ,g_xccj3_d_t.xccj006
                                                ,g_xccj3_d_t.xccj007
                                                ,g_xccj3_d_t.xccj008
                                                ,g_xccj3_d_t.xccj009
                                                
 
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axct302_bcl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axct302_bcl INTO g_xccj3_d[l_ac].xccj001,g_xccj3_d[l_ac].xccj006,g_xccj3_d[l_ac].xccj007, 
                      g_xccj3_d[l_ac].xccj008,g_xccj3_d[l_ac].xccj013,g_xccj3_d[l_ac].xccj009,g_xccj3_d[l_ac].xccj010, 
                      g_xccj3_d[l_ac].xccj011,g_xccj3_d[l_ac].xccj015,g_xccj3_d[l_ac].xccj016,g_xccj3_d[l_ac].xccj017, 
                      g_xccj3_d[l_ac].xccj020,g_xccj3_d[l_ac].xccj012,g_xccj3_d[l_ac].xccj002,g_xccj3_d[l_ac].xccj101, 
                      g_xccj3_d[l_ac].xccj102,g_xccj3_d[l_ac].xccj102a,g_xccj3_d[l_ac].xccj102b,g_xccj3_d[l_ac].xccj102c, 
                      g_xccj3_d[l_ac].xccj102d,g_xccj3_d[l_ac].xccj102e,g_xccj3_d[l_ac].xccj102f,g_xccj3_d[l_ac].xccj102g, 
                      g_xccj3_d[l_ac].xccj102h
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xccj3_d_t.xccj001 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
 
                      LET l_lock_sw = "Y"
                  END IF
                  
                  CALL axct302_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            IF l_cmd='u' THEN
               
                  OPEN axct302_bcl USING g_enterprise,g_xccj_m.xccjld,
                                                g_xccj_m.xccj003,
                                                g_xccj_m.xccj004,
                                                g_xccj_m.xccj005,
 
                                                '1'
                                                ,g_xccj3_d_t.xccj002
                                                ,g_xccj3_d_t.xccj006
                                                ,g_xccj3_d_t.xccj007
                                                ,g_xccj3_d_t.xccj008
                                                ,g_xccj3_d_t.xccj009
                                                
                  IF STATUS THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "OPEN axct302_bcl:xccj001=1" 
                     LET g_errparam.code   =  STATUS 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                     LET l_lock_sw='Y'
                  END IF
               
               IF g_glaa015 = 'Y' THEN
                  OPEN axct302_bcl USING g_enterprise,g_xccj_m.xccjld,
                                                g_xccj_m.xccj003,
                                                g_xccj_m.xccj004,
                                                g_xccj_m.xccj005,
 
                                                '2'
                                                ,g_xccj3_d_t.xccj002
                                                ,g_xccj3_d_t.xccj006
                                                ,g_xccj3_d_t.xccj007
                                                ,g_xccj3_d_t.xccj008
                                                ,g_xccj3_d_t.xccj009
                                               
                  IF STATUS THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "OPEN axct302_bcl:xccj001=3" 
                     LET g_errparam.code   =  STATUS 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                     LET l_lock_sw='Y'
                  END IF
               END IF
            END IF
            #end add-point  
            
        
         BEFORE INSERT
            
            INITIALIZE g_xccj3_d_t.* TO NULL
            INITIALIZE g_xccj3_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xccj3_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_xccj3_d[l_ac].xccj102 = "0"
      LET g_xccj3_d[l_ac].xccj102a = "0"
      LET g_xccj3_d[l_ac].xccj102b = "0"
      LET g_xccj3_d[l_ac].xccj102c = "0"
      LET g_xccj3_d[l_ac].xccj102d = "0"
      LET g_xccj3_d[l_ac].xccj102e = "0"
      LET g_xccj3_d[l_ac].xccj102f = "0"
      LET g_xccj3_d[l_ac].xccj102g = "0"
      LET g_xccj3_d[l_ac].xccj102h = "0"
 
            
            #add-point:modify段before備份

            #end add-point
            LET g_xccj3_d_t.* = g_xccj3_d[l_ac].*     #新輸入資料
            LET g_xccj3_d_o.* = g_xccj3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axct302_set_entry_b(l_cmd)
            #add-point:set_entry_b後

            #end add-point
            CALL axct302_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xccj3_d[li_reproduce_target].* = g_xccj3_d[li_reproduce].*
 
               LET g_xccj3_d[g_xccj3_d.getLength()].xccj001 = NULL
               LET g_xccj3_d[g_xccj3_d.getLength()].xccj002 = NULL
               LET g_xccj3_d[g_xccj3_d.getLength()].xccj006 = NULL
               LET g_xccj3_d[g_xccj3_d.getLength()].xccj007 = NULL
               LET g_xccj3_d[g_xccj3_d.getLength()].xccj008 = NULL
               LET g_xccj3_d[g_xccj3_d.getLength()].xccj009 = NULL
               LET g_xccj3_d[g_xccj3_d.getLength()].xccj010 = NULL
               LET g_xccj3_d[g_xccj3_d.getLength()].xccj011 = NULL
               LET g_xccj3_d[g_xccj3_d.getLength()].xccj012 = NULL
 
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
            SELECT COUNT(*) INTO l_count FROM xccj_t 
             WHERE xccjent = g_enterprise AND xccjld = g_xccj_m.xccjld
               AND xccj003 = g_xccj_m.xccj003
               AND xccj004 = g_xccj_m.xccj004
               AND xccj005 = g_xccj_m.xccj005
 
               AND xccj001 = g_xccj3_d[l_ac].xccj001
               AND xccj002 = g_xccj3_d[l_ac].xccj002
               AND xccj006 = g_xccj3_d[l_ac].xccj006
               AND xccj007 = g_xccj3_d[l_ac].xccj007
               AND xccj008 = g_xccj3_d[l_ac].xccj008
               AND xccj009 = g_xccj3_d[l_ac].xccj009
               AND xccj010 = g_xccj3_d[l_ac].xccj010
               AND xccj011 = g_xccj3_d[l_ac].xccj011
               AND xccj012 = g_xccj3_d[l_ac].xccj012
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前

               #end add-point
               INSERT INTO xccj_t
                           (xccjent,
                            xccjcomp,xccj004,xccj005,xccjld,xccj003,
                            xccj001,xccj002,xccj006,xccj007,xccj008,xccj009,xccj010,xccj011,xccj012
                            ,xccj013,xccj015,xccj016,xccj017,xccj020,xccj101,xccj102,xccj102a,xccj102b,xccj102c,xccj102d,xccj102e,xccj102f,xccj102g,xccj102h) 
                     VALUES(g_enterprise,
                            g_xccj_m.xccjcomp,g_xccj_m.xccj004,g_xccj_m.xccj005,g_xccj_m.xccjld,g_xccj_m.xccj003,
                            g_xccj3_d[l_ac].xccj001,g_xccj3_d[l_ac].xccj002,g_xccj3_d[l_ac].xccj006,g_xccj3_d[l_ac].xccj007, 
                                g_xccj3_d[l_ac].xccj008,g_xccj3_d[l_ac].xccj009,g_xccj3_d[l_ac].xccj010, 
                                g_xccj3_d[l_ac].xccj011,g_xccj3_d[l_ac].xccj012
                            ,g_xccj3_d[l_ac].xccj013,g_xccj3_d[l_ac].xccj015,g_xccj3_d[l_ac].xccj016,g_xccj3_d[l_ac].xccj017, 
                                g_xccj3_d[l_ac].xccj020,g_xccj3_d[l_ac].xccj101,g_xccj3_d[l_ac].xccj102, 
                                g_xccj3_d[l_ac].xccj102a,g_xccj3_d[l_ac].xccj102b,g_xccj3_d[l_ac].xccj102c, 
                                g_xccj3_d[l_ac].xccj102d,g_xccj3_d[l_ac].xccj102e,g_xccj3_d[l_ac].xccj102f, 
                                g_xccj3_d[l_ac].xccj102g,g_xccj3_d[l_ac].xccj102h)
               #add-point:單身新增中
               
               #end add-point
               LET p_cmd = 'u'
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               INITIALIZE g_xccj3_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xccj_t" 
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
               ERROR "INSERT O.K"
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
               IF axct302_before_delete_3() THEN 
                  
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axct302_bcl
               LET l_count = g_xccj3_d.getLength()
            END IF 
            
            #add-point:單身刪除後

            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE 

               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_xccj3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #此段落由子樣板a01產生
         BEFORE FIELD xccj001
            #add-point:BEFORE FIELD xccj001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj001
            
            #add-point:AFTER FIELD xccj001
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xccj_m.xccjld IS NOT NULL AND g_xccj_m.xccj003 IS NOT NULL AND g_xccj_m.xccj004 IS NOT NULL AND g_xccj_m.xccj005 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj001 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj002 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj006 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj007 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj008 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj009 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj010 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj011 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccj_m.xccjld != g_xccjld_t OR g_xccj_m.xccj003 != g_xccj003_t OR g_xccj_m.xccj004 != g_xccj004_t OR g_xccj_m.xccj005 != g_xccj005_t OR g_xccj3_d[g_detail_idx].xccj001 != g_xccj3_d_t.xccj001 OR g_xccj3_d[g_detail_idx].xccj002 != g_xccj3_d_t.xccj002 OR g_xccj3_d[g_detail_idx].xccj006 != g_xccj3_d_t.xccj006 OR g_xccj3_d[g_detail_idx].xccj007 != g_xccj3_d_t.xccj007 OR g_xccj3_d[g_detail_idx].xccj008 != g_xccj3_d_t.xccj008 OR g_xccj3_d[g_detail_idx].xccj009 != g_xccj3_d_t.xccj009 OR g_xccj3_d[g_detail_idx].xccj010 != g_xccj3_d_t.xccj010 OR g_xccj3_d[g_detail_idx].xccj011 != g_xccj3_d_t.xccj011 OR g_xccj3_d[g_detail_idx].xccj012 != g_xccj3_d_t.xccj012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccj_t WHERE "||"xccjent = '" ||g_enterprise|| "' AND "||"xccjld = '"||g_xccj_m.xccjld ||"' AND "|| "xccj003 = '"||g_xccj_m.xccj003 ||"' AND "|| "xccj004 = '"||g_xccj_m.xccj004 ||"' AND "|| "xccj005 = '"||g_xccj_m.xccj005 ||"' AND "|| "xccj001 = '"||g_xccj3_d[g_detail_idx].xccj001 ||"' AND "|| "xccj002 = '"||g_xccj3_d[g_detail_idx].xccj002 ||"' AND "|| "xccj006 = '"||g_xccj3_d[g_detail_idx].xccj006 ||"' AND "|| "xccj007 = '"||g_xccj3_d[g_detail_idx].xccj007 ||"' AND "|| "xccj008 = '"||g_xccj3_d[g_detail_idx].xccj008 ||"' AND "|| "xccj009 = '"||g_xccj3_d[g_detail_idx].xccj009 ||"' AND "|| "xccj010 = '"||g_xccj3_d[g_detail_idx].xccj010 ||"' AND "|| "xccj011 = '"||g_xccj3_d[g_detail_idx].xccj011 ||"' AND "|| "xccj012 = '"||g_xccj3_d[g_detail_idx].xccj012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj001
            #add-point:ON CHANGE xccj001

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj006
            #add-point:BEFORE FIELD xccj006

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj006
            
            #add-point:AFTER FIELD xccj006
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xccj_m.xccjld IS NOT NULL AND g_xccj_m.xccj003 IS NOT NULL AND g_xccj_m.xccj004 IS NOT NULL AND g_xccj_m.xccj005 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj001 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj002 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj006 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj007 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj008 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj009 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj010 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj011 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccj_m.xccjld != g_xccjld_t OR g_xccj_m.xccj003 != g_xccj003_t OR g_xccj_m.xccj004 != g_xccj004_t OR g_xccj_m.xccj005 != g_xccj005_t OR g_xccj3_d[g_detail_idx].xccj001 != g_xccj3_d_t.xccj001 OR g_xccj3_d[g_detail_idx].xccj002 != g_xccj3_d_t.xccj002 OR g_xccj3_d[g_detail_idx].xccj006 != g_xccj3_d_t.xccj006 OR g_xccj3_d[g_detail_idx].xccj007 != g_xccj3_d_t.xccj007 OR g_xccj3_d[g_detail_idx].xccj008 != g_xccj3_d_t.xccj008 OR g_xccj3_d[g_detail_idx].xccj009 != g_xccj3_d_t.xccj009 OR g_xccj3_d[g_detail_idx].xccj010 != g_xccj3_d_t.xccj010 OR g_xccj3_d[g_detail_idx].xccj011 != g_xccj3_d_t.xccj011 OR g_xccj3_d[g_detail_idx].xccj012 != g_xccj3_d_t.xccj012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccj_t WHERE "||"xccjent = '" ||g_enterprise|| "' AND "||"xccjld = '"||g_xccj_m.xccjld ||"' AND "|| "xccj003 = '"||g_xccj_m.xccj003 ||"' AND "|| "xccj004 = '"||g_xccj_m.xccj004 ||"' AND "|| "xccj005 = '"||g_xccj_m.xccj005 ||"' AND "|| "xccj001 = '"||g_xccj3_d[g_detail_idx].xccj001 ||"' AND "|| "xccj002 = '"||g_xccj3_d[g_detail_idx].xccj002 ||"' AND "|| "xccj006 = '"||g_xccj3_d[g_detail_idx].xccj006 ||"' AND "|| "xccj007 = '"||g_xccj3_d[g_detail_idx].xccj007 ||"' AND "|| "xccj008 = '"||g_xccj3_d[g_detail_idx].xccj008 ||"' AND "|| "xccj009 = '"||g_xccj3_d[g_detail_idx].xccj009 ||"' AND "|| "xccj010 = '"||g_xccj3_d[g_detail_idx].xccj010 ||"' AND "|| "xccj011 = '"||g_xccj3_d[g_detail_idx].xccj011 ||"' AND "|| "xccj012 = '"||g_xccj3_d[g_detail_idx].xccj012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj006
            #add-point:ON CHANGE xccj006

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj007
            #add-point:BEFORE FIELD xccj007

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj007
            
            #add-point:AFTER FIELD xccj007
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xccj_m.xccjld IS NOT NULL AND g_xccj_m.xccj003 IS NOT NULL AND g_xccj_m.xccj004 IS NOT NULL AND g_xccj_m.xccj005 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj001 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj002 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj006 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj007 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj008 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj009 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj010 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj011 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccj_m.xccjld != g_xccjld_t OR g_xccj_m.xccj003 != g_xccj003_t OR g_xccj_m.xccj004 != g_xccj004_t OR g_xccj_m.xccj005 != g_xccj005_t OR g_xccj3_d[g_detail_idx].xccj001 != g_xccj3_d_t.xccj001 OR g_xccj3_d[g_detail_idx].xccj002 != g_xccj3_d_t.xccj002 OR g_xccj3_d[g_detail_idx].xccj006 != g_xccj3_d_t.xccj006 OR g_xccj3_d[g_detail_idx].xccj007 != g_xccj3_d_t.xccj007 OR g_xccj3_d[g_detail_idx].xccj008 != g_xccj3_d_t.xccj008 OR g_xccj3_d[g_detail_idx].xccj009 != g_xccj3_d_t.xccj009 OR g_xccj3_d[g_detail_idx].xccj010 != g_xccj3_d_t.xccj010 OR g_xccj3_d[g_detail_idx].xccj011 != g_xccj3_d_t.xccj011 OR g_xccj3_d[g_detail_idx].xccj012 != g_xccj3_d_t.xccj012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccj_t WHERE "||"xccjent = '" ||g_enterprise|| "' AND "||"xccjld = '"||g_xccj_m.xccjld ||"' AND "|| "xccj003 = '"||g_xccj_m.xccj003 ||"' AND "|| "xccj004 = '"||g_xccj_m.xccj004 ||"' AND "|| "xccj005 = '"||g_xccj_m.xccj005 ||"' AND "|| "xccj001 = '"||g_xccj3_d[g_detail_idx].xccj001 ||"' AND "|| "xccj002 = '"||g_xccj3_d[g_detail_idx].xccj002 ||"' AND "|| "xccj006 = '"||g_xccj3_d[g_detail_idx].xccj006 ||"' AND "|| "xccj007 = '"||g_xccj3_d[g_detail_idx].xccj007 ||"' AND "|| "xccj008 = '"||g_xccj3_d[g_detail_idx].xccj008 ||"' AND "|| "xccj009 = '"||g_xccj3_d[g_detail_idx].xccj009 ||"' AND "|| "xccj010 = '"||g_xccj3_d[g_detail_idx].xccj010 ||"' AND "|| "xccj011 = '"||g_xccj3_d[g_detail_idx].xccj011 ||"' AND "|| "xccj012 = '"||g_xccj3_d[g_detail_idx].xccj012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj007
            #add-point:ON CHANGE xccj007

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj008
            #add-point:BEFORE FIELD xccj008

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj008
            
            #add-point:AFTER FIELD xccj008
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xccj_m.xccjld IS NOT NULL AND g_xccj_m.xccj003 IS NOT NULL AND g_xccj_m.xccj004 IS NOT NULL AND g_xccj_m.xccj005 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj001 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj002 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj006 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj007 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj008 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj009 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj010 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj011 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccj_m.xccjld != g_xccjld_t OR g_xccj_m.xccj003 != g_xccj003_t OR g_xccj_m.xccj004 != g_xccj004_t OR g_xccj_m.xccj005 != g_xccj005_t OR g_xccj3_d[g_detail_idx].xccj001 != g_xccj3_d_t.xccj001 OR g_xccj3_d[g_detail_idx].xccj002 != g_xccj3_d_t.xccj002 OR g_xccj3_d[g_detail_idx].xccj006 != g_xccj3_d_t.xccj006 OR g_xccj3_d[g_detail_idx].xccj007 != g_xccj3_d_t.xccj007 OR g_xccj3_d[g_detail_idx].xccj008 != g_xccj3_d_t.xccj008 OR g_xccj3_d[g_detail_idx].xccj009 != g_xccj3_d_t.xccj009 OR g_xccj3_d[g_detail_idx].xccj010 != g_xccj3_d_t.xccj010 OR g_xccj3_d[g_detail_idx].xccj011 != g_xccj3_d_t.xccj011 OR g_xccj3_d[g_detail_idx].xccj012 != g_xccj3_d_t.xccj012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccj_t WHERE "||"xccjent = '" ||g_enterprise|| "' AND "||"xccjld = '"||g_xccj_m.xccjld ||"' AND "|| "xccj003 = '"||g_xccj_m.xccj003 ||"' AND "|| "xccj004 = '"||g_xccj_m.xccj004 ||"' AND "|| "xccj005 = '"||g_xccj_m.xccj005 ||"' AND "|| "xccj001 = '"||g_xccj3_d[g_detail_idx].xccj001 ||"' AND "|| "xccj002 = '"||g_xccj3_d[g_detail_idx].xccj002 ||"' AND "|| "xccj006 = '"||g_xccj3_d[g_detail_idx].xccj006 ||"' AND "|| "xccj007 = '"||g_xccj3_d[g_detail_idx].xccj007 ||"' AND "|| "xccj008 = '"||g_xccj3_d[g_detail_idx].xccj008 ||"' AND "|| "xccj009 = '"||g_xccj3_d[g_detail_idx].xccj009 ||"' AND "|| "xccj010 = '"||g_xccj3_d[g_detail_idx].xccj010 ||"' AND "|| "xccj011 = '"||g_xccj3_d[g_detail_idx].xccj011 ||"' AND "|| "xccj012 = '"||g_xccj3_d[g_detail_idx].xccj012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj008
            #add-point:ON CHANGE xccj008

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj013
            #add-point:BEFORE FIELD xccj013

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj013
            
            #add-point:AFTER FIELD xccj013

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj013
            #add-point:ON CHANGE xccj013

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj009
            #add-point:BEFORE FIELD xccj009

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj009
            
            #add-point:AFTER FIELD xccj009
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xccj_m.xccjld IS NOT NULL AND g_xccj_m.xccj003 IS NOT NULL AND g_xccj_m.xccj004 IS NOT NULL AND g_xccj_m.xccj005 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj001 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj002 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj006 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj007 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj008 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj009 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj010 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj011 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccj_m.xccjld != g_xccjld_t OR g_xccj_m.xccj003 != g_xccj003_t OR g_xccj_m.xccj004 != g_xccj004_t OR g_xccj_m.xccj005 != g_xccj005_t OR g_xccj3_d[g_detail_idx].xccj001 != g_xccj3_d_t.xccj001 OR g_xccj3_d[g_detail_idx].xccj002 != g_xccj3_d_t.xccj002 OR g_xccj3_d[g_detail_idx].xccj006 != g_xccj3_d_t.xccj006 OR g_xccj3_d[g_detail_idx].xccj007 != g_xccj3_d_t.xccj007 OR g_xccj3_d[g_detail_idx].xccj008 != g_xccj3_d_t.xccj008 OR g_xccj3_d[g_detail_idx].xccj009 != g_xccj3_d_t.xccj009 OR g_xccj3_d[g_detail_idx].xccj010 != g_xccj3_d_t.xccj010 OR g_xccj3_d[g_detail_idx].xccj011 != g_xccj3_d_t.xccj011 OR g_xccj3_d[g_detail_idx].xccj012 != g_xccj3_d_t.xccj012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccj_t WHERE "||"xccjent = '" ||g_enterprise|| "' AND "||"xccjld = '"||g_xccj_m.xccjld ||"' AND "|| "xccj003 = '"||g_xccj_m.xccj003 ||"' AND "|| "xccj004 = '"||g_xccj_m.xccj004 ||"' AND "|| "xccj005 = '"||g_xccj_m.xccj005 ||"' AND "|| "xccj001 = '"||g_xccj3_d[g_detail_idx].xccj001 ||"' AND "|| "xccj002 = '"||g_xccj3_d[g_detail_idx].xccj002 ||"' AND "|| "xccj006 = '"||g_xccj3_d[g_detail_idx].xccj006 ||"' AND "|| "xccj007 = '"||g_xccj3_d[g_detail_idx].xccj007 ||"' AND "|| "xccj008 = '"||g_xccj3_d[g_detail_idx].xccj008 ||"' AND "|| "xccj009 = '"||g_xccj3_d[g_detail_idx].xccj009 ||"' AND "|| "xccj010 = '"||g_xccj3_d[g_detail_idx].xccj010 ||"' AND "|| "xccj011 = '"||g_xccj3_d[g_detail_idx].xccj011 ||"' AND "|| "xccj012 = '"||g_xccj3_d[g_detail_idx].xccj012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj009
            #add-point:ON CHANGE xccj009

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj010
            
            #add-point:AFTER FIELD xccj010
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xccj_m.xccjld IS NOT NULL AND g_xccj_m.xccj003 IS NOT NULL AND g_xccj_m.xccj004 IS NOT NULL AND g_xccj_m.xccj005 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj001 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj002 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj006 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj007 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj008 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj009 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj010 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj011 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccj_m.xccjld != g_xccjld_t OR g_xccj_m.xccj003 != g_xccj003_t OR g_xccj_m.xccj004 != g_xccj004_t OR g_xccj_m.xccj005 != g_xccj005_t OR g_xccj3_d[g_detail_idx].xccj001 != g_xccj3_d_t.xccj001 OR g_xccj3_d[g_detail_idx].xccj002 != g_xccj3_d_t.xccj002 OR g_xccj3_d[g_detail_idx].xccj006 != g_xccj3_d_t.xccj006 OR g_xccj3_d[g_detail_idx].xccj007 != g_xccj3_d_t.xccj007 OR g_xccj3_d[g_detail_idx].xccj008 != g_xccj3_d_t.xccj008 OR g_xccj3_d[g_detail_idx].xccj009 != g_xccj3_d_t.xccj009 OR g_xccj3_d[g_detail_idx].xccj010 != g_xccj3_d_t.xccj010 OR g_xccj3_d[g_detail_idx].xccj011 != g_xccj3_d_t.xccj011 OR g_xccj3_d[g_detail_idx].xccj012 != g_xccj3_d_t.xccj012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccj_t WHERE "||"xccjent = '" ||g_enterprise|| "' AND "||"xccjld = '"||g_xccj_m.xccjld ||"' AND "|| "xccj003 = '"||g_xccj_m.xccj003 ||"' AND "|| "xccj004 = '"||g_xccj_m.xccj004 ||"' AND "|| "xccj005 = '"||g_xccj_m.xccj005 ||"' AND "|| "xccj001 = '"||g_xccj3_d[g_detail_idx].xccj001 ||"' AND "|| "xccj002 = '"||g_xccj3_d[g_detail_idx].xccj002 ||"' AND "|| "xccj006 = '"||g_xccj3_d[g_detail_idx].xccj006 ||"' AND "|| "xccj007 = '"||g_xccj3_d[g_detail_idx].xccj007 ||"' AND "|| "xccj008 = '"||g_xccj3_d[g_detail_idx].xccj008 ||"' AND "|| "xccj009 = '"||g_xccj3_d[g_detail_idx].xccj009 ||"' AND "|| "xccj010 = '"||g_xccj3_d[g_detail_idx].xccj010 ||"' AND "|| "xccj011 = '"||g_xccj3_d[g_detail_idx].xccj011 ||"' AND "|| "xccj012 = '"||g_xccj3_d[g_detail_idx].xccj012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccj3_d[l_ac].xccj010
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccj3_d[l_ac].xccj010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccj3_d[l_ac].xccj010_desc


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj010
            #add-point:BEFORE FIELD xccj010

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xccj010
            #add-point:ON CHANGE xccj010

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj011
            #add-point:BEFORE FIELD xccj011

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj011
            
            #add-point:AFTER FIELD xccj011
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xccj_m.xccjld IS NOT NULL AND g_xccj_m.xccj003 IS NOT NULL AND g_xccj_m.xccj004 IS NOT NULL AND g_xccj_m.xccj005 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj001 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj002 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj006 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj007 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj008 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj009 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj010 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj011 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccj_m.xccjld != g_xccjld_t OR g_xccj_m.xccj003 != g_xccj003_t OR g_xccj_m.xccj004 != g_xccj004_t OR g_xccj_m.xccj005 != g_xccj005_t OR g_xccj3_d[g_detail_idx].xccj001 != g_xccj3_d_t.xccj001 OR g_xccj3_d[g_detail_idx].xccj002 != g_xccj3_d_t.xccj002 OR g_xccj3_d[g_detail_idx].xccj006 != g_xccj3_d_t.xccj006 OR g_xccj3_d[g_detail_idx].xccj007 != g_xccj3_d_t.xccj007 OR g_xccj3_d[g_detail_idx].xccj008 != g_xccj3_d_t.xccj008 OR g_xccj3_d[g_detail_idx].xccj009 != g_xccj3_d_t.xccj009 OR g_xccj3_d[g_detail_idx].xccj010 != g_xccj3_d_t.xccj010 OR g_xccj3_d[g_detail_idx].xccj011 != g_xccj3_d_t.xccj011 OR g_xccj3_d[g_detail_idx].xccj012 != g_xccj3_d_t.xccj012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccj_t WHERE "||"xccjent = '" ||g_enterprise|| "' AND "||"xccjld = '"||g_xccj_m.xccjld ||"' AND "|| "xccj003 = '"||g_xccj_m.xccj003 ||"' AND "|| "xccj004 = '"||g_xccj_m.xccj004 ||"' AND "|| "xccj005 = '"||g_xccj_m.xccj005 ||"' AND "|| "xccj001 = '"||g_xccj3_d[g_detail_idx].xccj001 ||"' AND "|| "xccj002 = '"||g_xccj3_d[g_detail_idx].xccj002 ||"' AND "|| "xccj006 = '"||g_xccj3_d[g_detail_idx].xccj006 ||"' AND "|| "xccj007 = '"||g_xccj3_d[g_detail_idx].xccj007 ||"' AND "|| "xccj008 = '"||g_xccj3_d[g_detail_idx].xccj008 ||"' AND "|| "xccj009 = '"||g_xccj3_d[g_detail_idx].xccj009 ||"' AND "|| "xccj010 = '"||g_xccj3_d[g_detail_idx].xccj010 ||"' AND "|| "xccj011 = '"||g_xccj3_d[g_detail_idx].xccj011 ||"' AND "|| "xccj012 = '"||g_xccj3_d[g_detail_idx].xccj012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj011
            #add-point:ON CHANGE xccj011

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj015
            
            #add-point:AFTER FIELD xccj015


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj015
            #add-point:BEFORE FIELD xccj015

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xccj015
            #add-point:ON CHANGE xccj015

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj016
            
            #add-point:AFTER FIELD xccj016


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj016
            #add-point:BEFORE FIELD xccj016

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xccj016
            #add-point:ON CHANGE xccj016

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj017
            #add-point:BEFORE FIELD xccj017

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj017
            
            #add-point:AFTER FIELD xccj017

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj017
            #add-point:ON CHANGE xccj017

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj020
            #add-point:BEFORE FIELD xccj020

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj020
            
            #add-point:AFTER FIELD xccj020

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj020
            #add-point:ON CHANGE xccj020

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj012
            #add-point:BEFORE FIELD xccj012

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj012
            
            #add-point:AFTER FIELD xccj012
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xccj_m.xccjld IS NOT NULL AND g_xccj_m.xccj003 IS NOT NULL AND g_xccj_m.xccj004 IS NOT NULL AND g_xccj_m.xccj005 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj001 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj002 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj006 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj007 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj008 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj009 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj010 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj011 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccj_m.xccjld != g_xccjld_t OR g_xccj_m.xccj003 != g_xccj003_t OR g_xccj_m.xccj004 != g_xccj004_t OR g_xccj_m.xccj005 != g_xccj005_t OR g_xccj3_d[g_detail_idx].xccj001 != g_xccj3_d_t.xccj001 OR g_xccj3_d[g_detail_idx].xccj002 != g_xccj3_d_t.xccj002 OR g_xccj3_d[g_detail_idx].xccj006 != g_xccj3_d_t.xccj006 OR g_xccj3_d[g_detail_idx].xccj007 != g_xccj3_d_t.xccj007 OR g_xccj3_d[g_detail_idx].xccj008 != g_xccj3_d_t.xccj008 OR g_xccj3_d[g_detail_idx].xccj009 != g_xccj3_d_t.xccj009 OR g_xccj3_d[g_detail_idx].xccj010 != g_xccj3_d_t.xccj010 OR g_xccj3_d[g_detail_idx].xccj011 != g_xccj3_d_t.xccj011 OR g_xccj3_d[g_detail_idx].xccj012 != g_xccj3_d_t.xccj012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccj_t WHERE "||"xccjent = '" ||g_enterprise|| "' AND "||"xccjld = '"||g_xccj_m.xccjld ||"' AND "|| "xccj003 = '"||g_xccj_m.xccj003 ||"' AND "|| "xccj004 = '"||g_xccj_m.xccj004 ||"' AND "|| "xccj005 = '"||g_xccj_m.xccj005 ||"' AND "|| "xccj001 = '"||g_xccj3_d[g_detail_idx].xccj001 ||"' AND "|| "xccj002 = '"||g_xccj3_d[g_detail_idx].xccj002 ||"' AND "|| "xccj006 = '"||g_xccj3_d[g_detail_idx].xccj006 ||"' AND "|| "xccj007 = '"||g_xccj3_d[g_detail_idx].xccj007 ||"' AND "|| "xccj008 = '"||g_xccj3_d[g_detail_idx].xccj008 ||"' AND "|| "xccj009 = '"||g_xccj3_d[g_detail_idx].xccj009 ||"' AND "|| "xccj010 = '"||g_xccj3_d[g_detail_idx].xccj010 ||"' AND "|| "xccj011 = '"||g_xccj3_d[g_detail_idx].xccj011 ||"' AND "|| "xccj012 = '"||g_xccj3_d[g_detail_idx].xccj012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            
            SELECT gzcb015 INTO g_xccj3_d[g_detail_idx].xccj020 FROM gzcb_t
             WHERE gzcb001 = 24 AND gzcb002 = g_xccj3_d[g_detail_idx].xccj012 
            IF g_xccj3_d[g_detail_idx].xccj020 IS NULL THEN LET g_xccj3_d[g_detail_idx].xccj020 = ' ' END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj012
            #add-point:ON CHANGE xccj012

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj002
            
            #add-point:AFTER FIELD xccj002
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xccj_m.xccjld IS NOT NULL AND g_xccj_m.xccj003 IS NOT NULL AND g_xccj_m.xccj004 IS NOT NULL AND g_xccj_m.xccj005 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj001 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj002 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj006 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj007 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj008 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj009 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj010 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj011 IS NOT NULL AND g_xccj3_d[g_detail_idx].xccj012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccj_m.xccjld != g_xccjld_t OR g_xccj_m.xccj003 != g_xccj003_t OR g_xccj_m.xccj004 != g_xccj004_t OR g_xccj_m.xccj005 != g_xccj005_t OR g_xccj3_d[g_detail_idx].xccj001 != g_xccj3_d_t.xccj001 OR g_xccj3_d[g_detail_idx].xccj002 != g_xccj3_d_t.xccj002 OR g_xccj3_d[g_detail_idx].xccj006 != g_xccj3_d_t.xccj006 OR g_xccj3_d[g_detail_idx].xccj007 != g_xccj3_d_t.xccj007 OR g_xccj3_d[g_detail_idx].xccj008 != g_xccj3_d_t.xccj008 OR g_xccj3_d[g_detail_idx].xccj009 != g_xccj3_d_t.xccj009 OR g_xccj3_d[g_detail_idx].xccj010 != g_xccj3_d_t.xccj010 OR g_xccj3_d[g_detail_idx].xccj011 != g_xccj3_d_t.xccj011 OR g_xccj3_d[g_detail_idx].xccj012 != g_xccj3_d_t.xccj012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccj_t WHERE "||"xccjent = '" ||g_enterprise|| "' AND "||"xccjld = '"||g_xccj_m.xccjld ||"' AND "|| "xccj003 = '"||g_xccj_m.xccj003 ||"' AND "|| "xccj004 = '"||g_xccj_m.xccj004 ||"' AND "|| "xccj005 = '"||g_xccj_m.xccj005 ||"' AND "|| "xccj001 = '"||g_xccj3_d[g_detail_idx].xccj001 ||"' AND "|| "xccj002 = '"||g_xccj3_d[g_detail_idx].xccj002 ||"' AND "|| "xccj006 = '"||g_xccj3_d[g_detail_idx].xccj006 ||"' AND "|| "xccj007 = '"||g_xccj3_d[g_detail_idx].xccj007 ||"' AND "|| "xccj008 = '"||g_xccj3_d[g_detail_idx].xccj008 ||"' AND "|| "xccj009 = '"||g_xccj3_d[g_detail_idx].xccj009 ||"' AND "|| "xccj010 = '"||g_xccj3_d[g_detail_idx].xccj010 ||"' AND "|| "xccj011 = '"||g_xccj3_d[g_detail_idx].xccj011 ||"' AND "|| "xccj012 = '"||g_xccj3_d[g_detail_idx].xccj012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccj_m.xccjcomp
            LET g_ref_fields[2] = g_xccj3_d[l_ac].xccj002
            CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp=? AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccj3_d[l_ac].xccj002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccj3_d[l_ac].xccj002_desc


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj002
            #add-point:BEFORE FIELD xccj002

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xccj002
            #add-point:ON CHANGE xccj002

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj101
            #add-point:BEFORE FIELD xccj101

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj101
            
            #add-point:AFTER FIELD xccj101

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj101
            #add-point:ON CHANGE xccj101

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj102_3
            #add-point:BEFORE FIELD xccj102

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj102_3
            
            #add-point:AFTER FIELD xccj102

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj102_3
            #add-point:ON CHANGE xccj102

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj102a_3
            #add-point:BEFORE FIELD xccj102a

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj102a_3
            
            #add-point:AFTER FIELD xccj102a
            CALL axct302_xccj102_sum_3()
            LET g_xccj3_d[l_ac].xccj102a = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102a,2)
            LET g_xccj3_d[l_ac].xccj102 = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102,2)
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj102a_3
            #add-point:ON CHANGE xccj102a

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj102b_3
            #add-point:BEFORE FIELD xccj102b

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj102b_3
            
            #add-point:AFTER FIELD xccj102b
            CALL axct302_xccj102_sum_3()
            LET g_xccj3_d[l_ac].xccj102b = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102b,2)
            LET g_xccj3_d[l_ac].xccj102 = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102,2)
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj102b_3
            #add-point:ON CHANGE xccj102b

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj102c_3
            #add-point:BEFORE FIELD xccj102c

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj102c_3
            
            #add-point:AFTER FIELD xccj102c
            CALL axct302_xccj102_sum_3()
            LET g_xccj3_d[l_ac].xccj102c = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102c,2)
            LET g_xccj3_d[l_ac].xccj102 = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102,2)
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj102c_3
            #add-point:ON CHANGE xccj102c

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj102d_3
            #add-point:BEFORE FIELD xccj102d

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj102d_3
            
            #add-point:AFTER FIELD xccj102d
            CALL axct302_xccj102_sum_3()
            LET g_xccj3_d[l_ac].xccj102d = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102d,2)
            LET g_xccj3_d[l_ac].xccj102 = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102,2)
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj102d_3
            #add-point:ON CHANGE xccj102d

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj102e_3
            #add-point:BEFORE FIELD xccj102e

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj102e_3
            
            #add-point:AFTER FIELD xccj102e
            CALL axct302_xccj102_sum_3()
            LET g_xccj3_d[l_ac].xccj102e = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102e,2)
            LET g_xccj3_d[l_ac].xccj102 = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102,2)
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj102e_3
            #add-point:ON CHANGE xccj102e

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj102f_3
            #add-point:BEFORE FIELD xccj102f

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj102f_3
            
            #add-point:AFTER FIELD xccj102f
            CALL axct302_xccj102_sum_3()
            LET g_xccj3_d[l_ac].xccj102f = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102f,2)
            LET g_xccj3_d[l_ac].xccj102 = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102,2)
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj102f_3
            #add-point:ON CHANGE xccj102f

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj102g_3
            #add-point:BEFORE FIELD xccj102g

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj102g_3
            
            #add-point:AFTER FIELD xccj102g
            CALL axct302_xccj102_sum_3()
            LET g_xccj3_d[l_ac].xccj102g = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102g,2)
            LET g_xccj3_d[l_ac].xccj102 = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102,2)
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj102g_3
            #add-point:ON CHANGE xccj102g

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccj102h_3
            #add-point:BEFORE FIELD xccj102h

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccj102h_3
            
            #add-point:AFTER FIELD xccj102h
            CALL axct302_xccj102_sum_3()
            LET g_xccj3_d[l_ac].xccj102h = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102h,2)
            LET g_xccj3_d[l_ac].xccj102 = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102,2)
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccj102h
            #add-point:ON CHANGE xccj102h

            #END add-point
 
 
                  #Ctrlp:input.c.page1.xccj001
         ON ACTION controlp INFIELD xccj001
            #add-point:ON ACTION controlp INFIELD xccj001

            #END add-point
 
         #Ctrlp:input.c.page1.xccj006
         ON ACTION controlp INFIELD xccj006
            #add-point:ON ACTION controlp INFIELD xccj006
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccj3_d[l_ac].xccj006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_inaj001()                                #呼叫開窗

            LET g_xccj3_d[l_ac].xccj006 = g_qryparam.return1              

            DISPLAY g_xccj3_d[l_ac].xccj006 TO xccj006              #

            NEXT FIELD xccj006                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xccj007
         ON ACTION controlp INFIELD xccj007
            #add-point:ON ACTION controlp INFIELD xccj007

            #END add-point
 
         #Ctrlp:input.c.page1.xccj008
         ON ACTION controlp INFIELD xccj008
            #add-point:ON ACTION controlp INFIELD xccj008

            #END add-point
 
         #Ctrlp:input.c.page1.xccj013
         ON ACTION controlp INFIELD xccj013
            #add-point:ON ACTION controlp INFIELD xccj013

            #END add-point
 
         #Ctrlp:input.c.page1.xccj009
         ON ACTION controlp INFIELD xccj009
            #add-point:ON ACTION controlp INFIELD xccj009

            #END add-point
 
         #Ctrlp:input.c.page1.xccj010
         ON ACTION controlp INFIELD xccj010
            #add-point:ON ACTION controlp INFIELD xccj010
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccj3_d[l_ac].xccj010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_imag001_2()                                #呼叫開窗

            LET g_xccj3_d[l_ac].xccj010 = g_qryparam.return1              

            DISPLAY g_xccj3_d[l_ac].xccj010 TO xccj010              #

            NEXT FIELD xccj010                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xccj011
         ON ACTION controlp INFIELD xccj011
            #add-point:ON ACTION controlp INFIELD xccj011
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccj3_d[l_ac].xccj011             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_bmaa002_1()                                #呼叫開窗

            LET g_xccj3_d[l_ac].xccj011 = g_qryparam.return1              

            DISPLAY g_xccj3_d[l_ac].xccj011 TO xccj011              #

            NEXT FIELD xccj011                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xccj015
         ON ACTION controlp INFIELD xccj015
            #add-point:ON ACTION controlp INFIELD xccj015
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccj3_d[l_ac].xccj015             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_inaa001()                                #呼叫開窗

            LET g_xccj3_d[l_ac].xccj015 = g_qryparam.return1              

            DISPLAY g_xccj3_d[l_ac].xccj015 TO xccj015              #

            NEXT FIELD xccj015                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xccj016
         ON ACTION controlp INFIELD xccj016
            #add-point:ON ACTION controlp INFIELD xccj016
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccj3_d[l_ac].xccj016             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_inab002_3()                                #呼叫開窗

            LET g_xccj3_d[l_ac].xccj016 = g_qryparam.return1              

            DISPLAY g_xccj3_d[l_ac].xccj016 TO xccj016              #

            NEXT FIELD xccj016                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xccj017
         ON ACTION controlp INFIELD xccj017
            #add-point:ON ACTION controlp INFIELD xccj017

            #END add-point
 
         #Ctrlp:input.c.page1.xccj020
         ON ACTION controlp INFIELD xccj020
            #add-point:ON ACTION controlp INFIELD xccj020

            #END add-point
 
         #Ctrlp:input.c.page1.xccj012
         ON ACTION controlp INFIELD xccj012
            #add-point:ON ACTION controlp INFIELD xccj012

            #END add-point
 
         #Ctrlp:input.c.page1.xccj002
         ON ACTION controlp INFIELD xccj002
            #add-point:ON ACTION controlp INFIELD xccj002
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccj3_d[l_ac].xccj002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_xcbf001()                                #呼叫開窗

            LET g_xccj3_d[l_ac].xccj002 = g_qryparam.return1              

            DISPLAY g_xccj3_d[l_ac].xccj002 TO xccj002              #

            NEXT FIELD xccj002                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xccj101
         ON ACTION controlp INFIELD xccj101
            #add-point:ON ACTION controlp INFIELD xccj101

            #END add-point
 
         #Ctrlp:input.c.page1.xccj102
         ON ACTION controlp INFIELD xccj102
            #add-point:ON ACTION controlp INFIELD xccj102

            #END add-point
 
         #Ctrlp:input.c.page1.xccj102a
         ON ACTION controlp INFIELD xccj102a
            #add-point:ON ACTION controlp INFIELD xccj102a

            #END add-point
 
         #Ctrlp:input.c.page1.xccj102b
         ON ACTION controlp INFIELD xccj102b
            #add-point:ON ACTION controlp INFIELD xccj102b

            #END add-point
 
         #Ctrlp:input.c.page1.xccj102c
         ON ACTION controlp INFIELD xccj102c
            #add-point:ON ACTION controlp INFIELD xccj102c

            #END add-point
 
         #Ctrlp:input.c.page1.xccj102d
         ON ACTION controlp INFIELD xccj102d
            #add-point:ON ACTION controlp INFIELD xccj102d

            #END add-point
 
         #Ctrlp:input.c.page1.xccj102e
         ON ACTION controlp INFIELD xccj102e
            #add-point:ON ACTION controlp INFIELD xccj102e

            #END add-point
 
         #Ctrlp:input.c.page1.xccj102f
         ON ACTION controlp INFIELD xccj102f
            #add-point:ON ACTION controlp INFIELD xccj102f

            #END add-point
 
         #Ctrlp:input.c.page1.xccj102g
         ON ACTION controlp INFIELD xccj102g
            #add-point:ON ACTION controlp INFIELD xccj102g

            #END add-point
 
         #Ctrlp:input.c.page1.xccj102h
         ON ACTION controlp INFIELD xccj102h
            #add-point:ON ACTION controlp INFIELD xccj102h

            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_xccj3_d[l_ac].* = g_xccj3_d_t.*
               CLOSE axct302_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xccj3_d[l_ac].xccj001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               LET g_xccj3_d[l_ac].* = g_xccj3_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
            
               #add-point:單身修改前

               #end add-point
         
               UPDATE xccj_t SET (xccjld,xccj003,xccj004,xccj005,xccj001,xccj006,xccj007,xccj008,xccj013, 
                   xccj009,xccj010,xccj011,xccj015,xccj016,xccj017,xccj020,xccj012,xccj002,xccj101,xccj102, 
                   xccj102a,xccj102b,xccj102c,xccj102d,xccj102e,xccj102f,xccj102g,xccj102h) = (g_xccj_m.xccjld, 
                   g_xccj_m.xccj003,g_xccj_m.xccj004,g_xccj_m.xccj005,g_xccj3_d[l_ac].xccj001,g_xccj3_d[l_ac].xccj006, 
                   g_xccj3_d[l_ac].xccj007,g_xccj3_d[l_ac].xccj008,g_xccj3_d[l_ac].xccj013,g_xccj3_d[l_ac].xccj009, 
                   g_xccj3_d[l_ac].xccj010,g_xccj3_d[l_ac].xccj011,g_xccj3_d[l_ac].xccj015,g_xccj3_d[l_ac].xccj016, 
                   g_xccj3_d[l_ac].xccj017,g_xccj3_d[l_ac].xccj020,g_xccj3_d[l_ac].xccj012,g_xccj3_d[l_ac].xccj002, 
                   g_xccj3_d[l_ac].xccj101,g_xccj3_d[l_ac].xccj102,g_xccj3_d[l_ac].xccj102a,g_xccj3_d[l_ac].xccj102b, 
                   g_xccj3_d[l_ac].xccj102c,g_xccj3_d[l_ac].xccj102d,g_xccj3_d[l_ac].xccj102e,g_xccj3_d[l_ac].xccj102f, 
                   g_xccj3_d[l_ac].xccj102g,g_xccj3_d[l_ac].xccj102h)
                WHERE xccjent = g_enterprise AND xccjld = g_xccj_m.xccjld 
                 AND xccj003 = g_xccj_m.xccj003 
                 AND xccj004 = g_xccj_m.xccj004 
                 AND xccj005 = g_xccj_m.xccj005 
 
                 AND xccj001 = g_xccj3_d_t.xccj001 #項次   
                 AND xccj002 = g_xccj3_d_t.xccj002  
                 AND xccj006 = g_xccj3_d_t.xccj006  
                 AND xccj007 = g_xccj3_d_t.xccj007  
                 AND xccj008 = g_xccj3_d_t.xccj008  
                 AND xccj009 = g_xccj3_d_t.xccj009  
#                 AND xccj010 = g_xccj3_d_t.xccj010  
#                 AND xccj011 = g_xccj3_d_t.xccj011  
#                 AND xccj012 = g_xccj3_d_t.xccj012  
 
                 
               #add-point:單身修改中
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xccj_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xccj_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
 
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xccj_m.xccjld
               LET gs_keys_bak[1] = g_xccjld_t
               LET gs_keys[2] = g_xccj_m.xccj003
               LET gs_keys_bak[2] = g_xccj003_t
               LET gs_keys[3] = g_xccj_m.xccj004
               LET gs_keys_bak[3] = g_xccj004_t
               LET gs_keys[4] = g_xccj_m.xccj005
               LET gs_keys_bak[4] = g_xccj005_t
               LET gs_keys[5] = g_xccj3_d[g_detail_idx].xccj001
               LET gs_keys_bak[5] = g_xccj3_d_t.xccj001
               LET gs_keys[6] = g_xccj3_d[g_detail_idx].xccj002
               LET gs_keys_bak[6] = g_xccj3_d_t.xccj002
               LET gs_keys[7] = g_xccj3_d[g_detail_idx].xccj006
               LET gs_keys_bak[7] = g_xccj3_d_t.xccj006
               LET gs_keys[8] = g_xccj3_d[g_detail_idx].xccj007
               LET gs_keys_bak[8] = g_xccj3_d_t.xccj007
               LET gs_keys[9] = g_xccj3_d[g_detail_idx].xccj008
               LET gs_keys_bak[9] = g_xccj3_d_t.xccj008
               LET gs_keys[10] = g_xccj3_d[g_detail_idx].xccj009
               LET gs_keys_bak[10] = g_xccj3_d_t.xccj009
               LET gs_keys[11] = g_xccj3_d[g_detail_idx].xccj010
               LET gs_keys_bak[11] = g_xccj3_d_t.xccj010
               LET gs_keys[12] = g_xccj3_d[g_detail_idx].xccj011
               LET gs_keys_bak[12] = g_xccj3_d_t.xccj011
               LET gs_keys[13] = g_xccj3_d[g_detail_idx].xccj012
               LET gs_keys_bak[13] = g_xccj3_d_t.xccj012
               CALL axct302_update_b('xccj_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     LET g_log1 = util.JSON.stringify(g_xccj_m),util.JSON.stringify(g_xccj3_d_t)
                     LET g_log2 = util.JSON.stringify(g_xccj_m),util.JSON.stringify(g_xccj3_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #add-point:單身修改後
               CALL s_transaction_end('Y','0') #140909
               #end add-point
            END IF
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xccj3_d.getLength() = 0 THEN
               NEXT FIELD xccj001
            END IF
            #add-point:input段after input 

            #end add-point    
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_xccj3_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_xccj3_d.getLength()+1
            
      END INPUT
 
      #end add-point    
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:input段before_dialog name="input.before_dialog"
         IF p_cmd = 'a' THEN
            NEXT FIELD xccjld
        ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xccj001
               WHEN "s_detail2"
                  NEXT FIELD xccj001_2
               WHEN "s_detail3"
                  NEXT FIELD xccj001_3
            END CASE
         END IF
         #end add-point 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD xccjld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xccj001
 
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
 
{<section id="axct302.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axct302_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_date  DATE
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   CALL axct302_ref()
   #檢查年度期別>=關賬日期，則不可修改刪除
   IF cl_null(g_xccj_m.xccjcomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6012') RETURNING l_date
   ELSE
      CALL cl_get_para(g_enterprise,g_xccj_m.xccjcomp,'S-FIN-6012') RETURNING l_date
   END IF
   IF g_xccj_m.xccj004 < YEAR(l_date) THEN
      CALL cl_set_act_visible("modify,modify_detail,delete", FALSE)
   ELSE
      IF g_xccj_m.xccj004 = YEAR(l_date) THEN
         IF g_xccj_m.xccj005 < MONTH(l_date) THEN
            CALL cl_set_act_visible("modify,modify_detail,delete", FALSE)
          ELSE
            CALL cl_set_act_visible("modify,modify_detail,delete", TRUE)
         END IF
      ELSE
         CALL cl_set_act_visible("modify,modify_detail,delete", TRUE)
      END IF
   END IF
   IF cl_null(g_xccj_m.xccjcomp) THEN
       CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否  
    ELSE
       CALL cl_get_para(g_enterprise,g_xccj_m.xccjcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否      
    END IF
      
    IF g_para_data = 'Y' THEN
       CALL cl_set_comp_visible('xccj002,xccj002_desc,xccj002_3,xccj002_3_desc,xccj002_2,xccj002_2_desc',TRUE)                    
    ELSE
       CALL cl_set_comp_visible('xccj002,xccj002_desc,xccj002_3,xccj002_3_desc,xccj002_2,xccj002_2_desc',FALSE)                
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
      CALL axct302_b_fill(g_wc2) #第一階單身填充
      CALL axct302_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axct302_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_xccj_m.xccjcomp,g_xccj_m.xccjcomp_desc,g_xccj_m.xccj004,g_xccj_m.xccj005,g_xccj_m.xccjld, 
       g_xccj_m.xccjld_desc,g_xccj_m.xccj003,g_xccj_m.xccj003_desc
 
   CALL axct302_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axct302.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION axct302_ref_show()
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
   CALL axct302_ref()
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_xccj_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      
      #end add-point
   END FOR
   
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="axct302.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axct302_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE xccj_t.xccjld 
   DEFINE l_oldno     LIKE xccj_t.xccjld 
   DEFINE l_newno02     LIKE xccj_t.xccj003 
   DEFINE l_oldno02     LIKE xccj_t.xccj003 
   DEFINE l_newno03     LIKE xccj_t.xccj004 
   DEFINE l_oldno03     LIKE xccj_t.xccj004 
   DEFINE l_newno04     LIKE xccj_t.xccj005 
   DEFINE l_oldno04     LIKE xccj_t.xccj005 
 
   DEFINE l_master    RECORD LIKE xccj_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xccj_t.* #此變數樣板目前無使用
 
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
 
   IF g_xccj_m.xccjld IS NULL
      OR g_xccj_m.xccj003 IS NULL
      OR g_xccj_m.xccj004 IS NULL
      OR g_xccj_m.xccj005 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_xccjld_t = g_xccj_m.xccjld
   LET g_xccj003_t = g_xccj_m.xccj003
   LET g_xccj004_t = g_xccj_m.xccj004
   LET g_xccj005_t = g_xccj_m.xccj005
 
   
   LET g_xccj_m.xccjld = ""
   LET g_xccj_m.xccj003 = ""
   LET g_xccj_m.xccj004 = ""
   LET g_xccj_m.xccj005 = ""
 
   LET g_master_insert = FALSE
   CALL axct302_set_entry('a')
   CALL axct302_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_xccj_m.xccjld_desc = ''
   DISPLAY BY NAME g_xccj_m.xccjld_desc
   LET g_xccj_m.xccj003_desc = ''
   DISPLAY BY NAME g_xccj_m.xccj003_desc
 
   
   CALL axct302_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_xccj_m.* TO NULL
      INITIALIZE g_xccj_d TO NULL
 
      CALL axct302_show()
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
   CALL axct302_set_act_visible()
   CALL axct302_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xccjld_t = g_xccj_m.xccjld
   LET g_xccj003_t = g_xccj_m.xccj003
   LET g_xccj004_t = g_xccj_m.xccj004
   LET g_xccj005_t = g_xccj_m.xccj005
 
   
   #組合新增資料的條件
   LET g_add_browse = " xccjent = " ||g_enterprise|| " AND",
                      " xccjld = '", g_xccj_m.xccjld, "' "
                      ," AND xccj003 = '", g_xccj_m.xccj003, "' "
                      ," AND xccj004 = '", g_xccj_m.xccj004, "' "
                      ," AND xccj005 = '", g_xccj_m.xccj005, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axct302_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL axct302_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL axct302_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="axct302.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axct302_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xccj_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axct302_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xccj_t
    WHERE xccjent = g_enterprise AND xccjld = g_xccjld_t
    AND xccj003 = g_xccj003_t
    AND xccj004 = g_xccj004_t
    AND xccj005 = g_xccj005_t
 
       INTO TEMP axct302_detail
   
   #將key修正為調整後   
   UPDATE axct302_detail 
      #更新key欄位
      SET xccjld = g_xccj_m.xccjld
          , xccj003 = g_xccj_m.xccj003
          , xccj004 = g_xccj_m.xccj004
          , xccj005 = g_xccj_m.xccj005
 
      #更新共用欄位
      
                                       
   #將資料塞回原table   
   INSERT INTO xccj_t SELECT * FROM axct302_detail
   
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
   DROP TABLE axct302_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xccjld_t = g_xccj_m.xccjld
   LET g_xccj003_t = g_xccj_m.xccj003
   LET g_xccj004_t = g_xccj_m.xccj004
   LET g_xccj005_t = g_xccj_m.xccj005
 
   
   DROP TABLE axct302_detail
   
END FUNCTION
 
{</section>}
 
{<section id="axct302.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axct302_delete()
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
   
   IF g_xccj_m.xccjld IS NULL
   OR g_xccj_m.xccj003 IS NULL
   OR g_xccj_m.xccj004 IS NULL
   OR g_xccj_m.xccj005 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN axct302_cl USING g_enterprise,g_xccj_m.xccjld,g_xccj_m.xccj003,g_xccj_m.xccj004,g_xccj_m.xccj005
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axct302_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axct302_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axct302_master_referesh USING g_xccj_m.xccjld,g_xccj_m.xccj003,g_xccj_m.xccj004,g_xccj_m.xccj005 INTO g_xccj_m.xccjcomp, 
       g_xccj_m.xccj004,g_xccj_m.xccj005,g_xccj_m.xccjld,g_xccj_m.xccj003,g_xccj_m.xccjcomp_desc,g_xccj_m.xccjld_desc, 
       g_xccj_m.xccj003_desc
   
   #遮罩相關處理
   LET g_xccj_m_mask_o.* =  g_xccj_m.*
   CALL axct302_xccj_t_mask()
   LET g_xccj_m_mask_n.* =  g_xccj_m.*
   
   CALL axct302_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axct302_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM xccj_t WHERE xccjent = g_enterprise AND xccjld = g_xccj_m.xccjld
                                                               AND xccj003 = g_xccj_m.xccj003
                                                               AND xccj004 = g_xccj_m.xccj004
                                                               AND xccj005 = g_xccj_m.xccj005
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xccj_t:",SQLERRMESSAGE 
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
      #   CLOSE axct302_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_xccj_d.clear() 
 
     
      CALL axct302_ui_browser_refresh()  
      #CALL axct302_ui_headershow()  
      #CALL axct302_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL axct302_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL axct302_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE axct302_cl
 
   #功能已完成,通報訊息中心
   CALL axct302_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axct302.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axct302_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_xccj_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT xccj001,xccj006,xccj007,xccj008,xccj013,xccj009,xccj010,xccj011,xccj015, 
       xccj016,xccj017,xccj020,xccj012,xccj002,xccj101,xccj102,xccj102a,xccj102b,xccj102c,xccj102d,xccj102e, 
       xccj102f,xccj102g,xccj102h,t1.imaal003 ,t2.imaal004 ,t3.xcbfl003 FROM xccj_t",   
               "",
               
                              " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=xccj010 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=xccj010 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN xcbfl_t t3 ON t3.xcbflent="||g_enterprise||" AND t3.xcbflcomp=xccjcomp AND t3.xcbfl001=xccj002 AND t3.xcbfl002='"||g_dlang||"' ",
 
               " WHERE xccjent= ? AND xccjld=? AND xccj003=? AND xccj004=? AND xccj005=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xccj_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = g_sql CLIPPED, " AND xccj001 = '1' " 
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axct302_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY xccj_t.xccj001,xccj_t.xccj002,xccj_t.xccj006,xccj_t.xccj007,xccj_t.xccj008,xccj_t.xccj009"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
      LET g_sql=cl_replace_str(g_sql," ORDER BY xccj_t.xccj001,xccj_t.xccj002,xccj_t.xccj006,xccj_t.xccj007,xccj_t.xccj008,xccj_t.xccj009,xccj_t.xccj010,xccj_t.xccj011,xccj_t.xccj012"," ORDER BY xccj_t.xccj001,xccj_t.xccj006,xccj_t.xccj007,xccj_t.xccj008,xccj_t.xccj009,xccj_t.xccj010,xccj_t.xccj011,xccj_t.xccj012,xccj_t.xccj002")
      
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axct302_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axct302_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xccj_m.xccjld,g_xccj_m.xccj003,g_xccj_m.xccj004,g_xccj_m.xccj005   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xccj_m.xccjld,g_xccj_m.xccj003,g_xccj_m.xccj004,g_xccj_m.xccj005 INTO g_xccj_d[l_ac].xccj001, 
          g_xccj_d[l_ac].xccj006,g_xccj_d[l_ac].xccj007,g_xccj_d[l_ac].xccj008,g_xccj_d[l_ac].xccj013, 
          g_xccj_d[l_ac].xccj009,g_xccj_d[l_ac].xccj010,g_xccj_d[l_ac].xccj011,g_xccj_d[l_ac].xccj015, 
          g_xccj_d[l_ac].xccj016,g_xccj_d[l_ac].xccj017,g_xccj_d[l_ac].xccj020,g_xccj_d[l_ac].xccj012, 
          g_xccj_d[l_ac].xccj002,g_xccj_d[l_ac].xccj101,g_xccj_d[l_ac].xccj102,g_xccj_d[l_ac].xccj102a, 
          g_xccj_d[l_ac].xccj102b,g_xccj_d[l_ac].xccj102c,g_xccj_d[l_ac].xccj102d,g_xccj_d[l_ac].xccj102e, 
          g_xccj_d[l_ac].xccj102f,g_xccj_d[l_ac].xccj102g,g_xccj_d[l_ac].xccj102h,g_xccj_d[l_ac].xccj010_desc, 
          g_xccj_d[l_ac].xccj010_desc_desc,g_xccj_d[l_ac].xccj002_desc   #(ver:49)
                             
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
 
            CALL g_xccj_d.deleteElement(g_xccj_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   LET g_rec_b=l_ac-1
   LET l_ac = g_cnt
   LET g_cnt = 0 
   FREE axct302_pb  
   RETURN
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_xccj_d.getLength()
      LET g_xccj_d_mask_o[l_ac].* =  g_xccj_d[l_ac].*
      CALL axct302_xccj_t_mask()
      LET g_xccj_d_mask_n[l_ac].* =  g_xccj_d[l_ac].*
   END FOR
   
 
 
   FREE axct302_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="axct302.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axct302_idx_chk()
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
      IF g_detail_idx > g_xccj_d.getLength() THEN
         LET g_detail_idx = g_xccj_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_xccj_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xccj_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      #確保當下指標的位置未超過上限
      IF g_detail_idx > g_xccj2_d.getLength() THEN
         LET g_detail_idx = g_xccj2_d.getLength()
      END IF
      #確保資料位置不小於2
      IF g_detail_idx = 0 AND g_xccj2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xccj2_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      #確保當下指標的位置未超過上限
      IF g_detail_idx > g_xccj3_d.getLength() THEN
         LET g_detail_idx = g_xccj3_d.getLength()
      END IF
      #確保資料位置不小於3
      IF g_detail_idx = 0 AND g_xccj3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xccj3_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
   END IF
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axct302.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axct302_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_xccj_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   IF g_glaa015 = 'Y' THEN
      CALL axct302_b_fill_2()
   END IF
   IF g_glaa019 = 'Y' THEN
      CALL axct302_b_fill_3()
   END IF
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axct302.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION axct302_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   DEFINE l_sql           STRING 
   DEFINE l_xcdj_count    LIKE type_t.num5
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
#   #删除axct306已有资料 
#  LET l_sql = "SELECT COUNT(*) FROM xcdj_t ",
#              " WHERE xcdjent = ? AND xcdjcomp = ? AND xcdjld = ?",
#              "   AND xcdj003 = ? AND xcdj004 = ? AND xcdj005 = ? "              
#  DECLARE axct302_xcdj_count_cs2 CURSOR FROM l_sql 
#  OPEN axct302_xcdj_count_cs2 USING g_enterprise,g_xccj_m.xccjcomp,g_xccj_m.xccjld,
#                                   g_xccj_m.xccj003,g_xccj_m.xccj004,g_xccj_m.xccj005
#                                   
#  FETCH axct302_xcdj_count_cs2 INTO l_xcdj_count
#  IF l_xcdj_count > 0 THEN
#     IF cl_ask_confirm('axc-00388') THEN   
#        LET l_sql = "DELETE FROM xcdj_t ",
#                    " WHERE xcdjent = '",g_enterprise,"'  AND xcdjcomp = '",g_xccj_m.xccjcomp,"'",
#                    "   AND xcdjld = '",g_xccj_m.xccjld,"' AND xcdj003 = '",g_xccj_m.xccj003,"'",
#                    "   AND xcdj004 = '",g_xccj_m.xccj004,"' AND xcdj005 = '",g_xccj_m.xccj005,"'"                   
#                     
#        PREPARE axct302_del_xcdj1 FROM l_sql
#        IF SQLCA.sqlcode THEN
#           INITIALIZE g_errparam TO NULL
#           LET g_errparam.code   = SQLCA.sqlcode
#           LET g_errparam.extend = "PREPARE delete xcdj_t"
#           LET g_errparam.popup  = TRUE
#           CALL cl_err()
#           RETURN 
#        END IF
#        EXECUTE axct302_del_xcdj1 
#        IF SQLCA.sqlcode THEN
#           INITIALIZE g_errparam TO NULL
#           LET g_errparam.code   = SQLCA.sqlcode
#           LET g_errparam.extend = "EXECUTE delete xcdj_t"
#           LET g_errparam.popup  = TRUE
#           CALL cl_err()
#           RETURN 
#        END IF 
#     ELSE 
#        RETURN         
#     END IF  
#  END IF
   #end add-point
   
   DELETE FROM xccj_t
    WHERE xccjent = g_enterprise AND xccjld = g_xccj_m.xccjld AND
                              xccj003 = g_xccj_m.xccj003 AND
                              xccj004 = g_xccj_m.xccj004 AND
                              xccj005 = g_xccj_m.xccj005 AND
 
          xccj001 = g_xccj_d_t.xccj001
      AND xccj002 = g_xccj_d_t.xccj002
      AND xccj006 = g_xccj_d_t.xccj006
      AND xccj007 = g_xccj_d_t.xccj007
      AND xccj008 = g_xccj_d_t.xccj008
      AND xccj009 = g_xccj_d_t.xccj009
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
  IF g_glaa015 = 'Y' OR g_glaa019 = 'Y' THEN  
     DELETE FROM xccj_t
       WHERE xccjent = g_enterprise AND xccjld = g_xccj_m.xccjld AND
                                 xccj003 = g_xccj_m.xccj003 AND
                                 xccj004 = g_xccj_m.xccj004 AND
                                 xccj005 = g_xccj_m.xccj005 
             
         AND xccj002 = g_xccj_d_t.xccj002
         AND xccj006 = g_xccj_d_t.xccj006
         AND xccj007 = g_xccj_d_t.xccj007
         AND xccj008 = g_xccj_d_t.xccj008
         AND xccj009 = g_xccj_d_t.xccj009
#         AND xccj010 = g_xccj_d_t.xccj010
#         AND xccj011 = g_xccj_d_t.xccj011
#         AND xccj012 = g_xccj_d_t.xccj012
   END IF
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccj_t:",SQLERRMESSAGE 
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
 
{<section id="axct302.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axct302_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="axct302.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axct302_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="axct302.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axct302_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="axct302.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION axct302_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_xccj_d[l_ac].xccj001 = g_xccj_d_t.xccj001 
      AND g_xccj_d[l_ac].xccj002 = g_xccj_d_t.xccj002 
      AND g_xccj_d[l_ac].xccj006 = g_xccj_d_t.xccj006 
      AND g_xccj_d[l_ac].xccj007 = g_xccj_d_t.xccj007 
      AND g_xccj_d[l_ac].xccj008 = g_xccj_d_t.xccj008 
      AND g_xccj_d[l_ac].xccj009 = g_xccj_d_t.xccj009 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="axct302.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axct302_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="axct302.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axct302_lock_b(ps_table,ps_page)
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
   #CALL axct302_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axct302.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axct302_unlock_b(ps_table,ps_page)
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
 
{<section id="axct302.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axct302_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xccjld,xccj003,xccj004,xccj005",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("xccjcomp",TRUE)
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axct302.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axct302_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xccjld,xccj003,xccj004,xccj005",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("xccjcomp",FALSE)
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axct302.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axct302_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xccj001,xccj002,xccj006,xccj007,xccj008,xccj009,xccj010,,xccj011,,xccj012",TRUE)       
   END IF
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   CALL cl_set_comp_required('xccj011',FALSE)
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axct302.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axct302_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xccj001,xccj002,xccj006,xccj007,xccj008,xccj009,xccj010,,xccj011,,xccj012",FALSE)  
   END IF
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axct302.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axct302_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axct302.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axct302_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axct302.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axct302_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axct302.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axct302_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axct302.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axct302_default_search()
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
      LET ls_wc = ls_wc, " xccjld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xccj003 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xccj004 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " xccj005 = '", g_argv[04], "' AND "
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
 
{<section id="axct302.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axct302_fill_chk(ps_idx)
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
 
{<section id="axct302.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION axct302_modify_detail_chk(ps_record)
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
         LET ls_return = "xccj001"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="axct302.mask_functions" >}
&include "erp/axc/axct302_mask.4gl"
 
{</section>}
 
{<section id="axct302.state_change" >}
    
 
{</section>}
 
{<section id="axct302.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axct302_set_pk_array()
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
   LET g_pk_array[1].values = g_xccj_m.xccjld
   LET g_pk_array[1].column = 'xccjld'
   LET g_pk_array[2].values = g_xccj_m.xccj003
   LET g_pk_array[2].column = 'xccj003'
   LET g_pk_array[3].values = g_xccj_m.xccj004
   LET g_pk_array[3].column = 'xccj004'
   LET g_pk_array[4].values = g_xccj_m.xccj005
   LET g_pk_array[4].column = 'xccj005'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axct302.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axct302_msgcentre_notify(lc_state)
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
   CALL axct302_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xccj_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axct302.other_function" readonly="Y" >}

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
PRIVATE FUNCTION axct302_b_fill_2()
   
   #先清空單身變數內容
   CALL g_xccj2_d.clear()
 
   LET g_sql = "SELECT  UNIQUE xccj001,xccj006,xccj007,xccj008,xccj013,xccj009,xccj010,xccj011,xccj015, 
       xccj016,xccj017,xccj020,xccj012,xccj002,xccj101,xccj102,xccj102a,xccj102b,xccj102c,xccj102d,xccj102e, 
       xccj102f,xccj102g,xccj102h,t1.imaal003 ,t2.imaal004 ,t3.xcbfl003 FROM xccj_t",   
               "",
               
                              " LEFT JOIN imaal_t t1 ON t1.imaalent='"||g_enterprise||"' AND t1.imaal001=xccj010 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent='"||g_enterprise||"' AND t2.imaal001=xccj010 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN xcbfl_t t3 ON t3.xcbflent='"||g_enterprise||"' AND t3.xcbflcomp=xccjcomp AND t3.xcbfl001=xccj002 AND t3.xcbfl002='"||g_dlang||"' ",
 
               " WHERE xccjent= ? AND xccjld=? AND xccj003=? AND xccj004=? AND xccj005=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xccj_t")
   END IF
   
   #add-point:b_fill段sql_after
   LET g_sql = g_sql CLIPPED, " AND xccj001 = '2' " 
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axct302_fill_chk(1) THEN
      LET g_sql = g_sql, " ORDER BY xccj_t.xccj001,xccj_t.xccj002,xccj_t.xccj006,xccj_t.xccj007,xccj_t.xccj008,xccj_t.xccj009,xccj_t.xccj010,xccj_t.xccj011,xccj_t.xccj012"
      
      #add-point:b_fill段fill_before

      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE axct302_pb2 FROM g_sql
      DECLARE b_fill_cs2 CURSOR FOR axct302_pb2
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs2 USING g_enterprise,g_xccj_m.xccjld,g_xccj_m.xccj003,g_xccj_m.xccj004,g_xccj_m.xccj005
                                               
      FOREACH b_fill_cs2 INTO g_xccj2_d[l_ac].xccj001,g_xccj2_d[l_ac].xccj006,g_xccj2_d[l_ac].xccj007,g_xccj2_d[l_ac].xccj008, 
          g_xccj2_d[l_ac].xccj013,g_xccj2_d[l_ac].xccj009,g_xccj2_d[l_ac].xccj010,g_xccj2_d[l_ac].xccj011, 
          g_xccj2_d[l_ac].xccj015,g_xccj2_d[l_ac].xccj016,g_xccj2_d[l_ac].xccj017,g_xccj2_d[l_ac].xccj020,
          g_xccj2_d[l_ac].xccj012,g_xccj2_d[l_ac].xccj002,g_xccj2_d[l_ac].xccj101,g_xccj2_d[l_ac].xccj102, 
          g_xccj2_d[l_ac].xccj102a,g_xccj2_d[l_ac].xccj102b,g_xccj2_d[l_ac].xccj102c,g_xccj2_d[l_ac].xccj102d, 
          g_xccj2_d[l_ac].xccj102e,g_xccj2_d[l_ac].xccj102f,g_xccj2_d[l_ac].xccj102g,g_xccj2_d[l_ac].xccj102h, 
          g_xccj2_d[l_ac].xccj010_desc,g_xccj2_d[l_ac].xccj010_desc_desc,g_xccj2_d[l_ac].xccj002_desc
                             
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
 
            CALL g_xccj2_d.deleteElement(g_xccj2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more
   
   #end add-point
   
  
 
   FREE axct302_pb2   
   
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
PRIVATE FUNCTION axct302_b_fill_3()
   #先清空單身變數內容
   CALL g_xccj3_d.clear()
 
   LET g_sql = "SELECT  UNIQUE xccj001,xccj006,xccj007,xccj008,xccj013,xccj009,xccj010,xccj011,xccj015, 
       xccj016,xccj017,xccj020,xccj012,xccj002,xccj101,xccj102,xccj102a,xccj102b,xccj102c,xccj102d,xccj102e, 
       xccj102f,xccj102g,xccj102h,t1.imaal003 ,t2.imaal004 ,t3.xcbfl003 FROM xccj_t",   
               "",
               
                              " LEFT JOIN imaal_t t1 ON t1.imaalent='"||g_enterprise||"' AND t1.imaal001=xccj010 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent='"||g_enterprise||"' AND t2.imaal001=xccj010 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN xcbfl_t t3 ON t3.xcbflent='"||g_enterprise||"' AND t3.xcbflcomp=xccjcomp AND t3.xcbfl001=xccj002 AND t3.xcbfl002='"||g_dlang||"' ",
 
               " WHERE xccjent= ? AND xccjld=? AND xccj003=? AND xccj004=? AND xccj005=?"  
   
   #add-point:b_fill段sql_after
   LET g_sql = g_sql CLIPPED, " AND xccj001 = '3' " 
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axct302_fill_chk(1) THEN
      LET g_sql = g_sql, " ORDER BY xccj_t.xccj001,xccj_t.xccj002,xccj_t.xccj006,xccj_t.xccj007,xccj_t.xccj008,xccj_t.xccj009,xccj_t.xccj010,xccj_t.xccj011,xccj_t.xccj012"
      
      #add-point:b_fill段fill_before

      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE axct302_pb3 FROM g_sql
      DECLARE b_fill_cs3 CURSOR FOR axct302_pb3
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs3 USING g_enterprise,g_xccj_m.xccjld,g_xccj_m.xccj003,g_xccj_m.xccj004,g_xccj_m.xccj005
                                               
      FOREACH b_fill_cs3 INTO g_xccj3_d[l_ac].xccj001,g_xccj3_d[l_ac].xccj006,g_xccj3_d[l_ac].xccj007,g_xccj3_d[l_ac].xccj008, 
          g_xccj3_d[l_ac].xccj013,g_xccj3_d[l_ac].xccj009,g_xccj3_d[l_ac].xccj010,g_xccj3_d[l_ac].xccj011, 
          g_xccj3_d[l_ac].xccj015,g_xccj3_d[l_ac].xccj016,g_xccj3_d[l_ac].xccj017,g_xccj3_d[l_ac].xccj020,
          g_xccj3_d[l_ac].xccj012,g_xccj3_d[l_ac].xccj002,g_xccj3_d[l_ac].xccj101,g_xccj3_d[l_ac].xccj102, 
          g_xccj3_d[l_ac].xccj102a,g_xccj3_d[l_ac].xccj102b,g_xccj3_d[l_ac].xccj102c,g_xccj3_d[l_ac].xccj102d, 
          g_xccj3_d[l_ac].xccj102e,g_xccj3_d[l_ac].xccj102f,g_xccj3_d[l_ac].xccj102g,g_xccj3_d[l_ac].xccj102h, 
          g_xccj3_d[l_ac].xccj010_desc,g_xccj3_d[l_ac].xccj010_desc_desc,g_xccj3_d[l_ac].xccj002_desc
                             
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
 
            CALL g_xccj3_d.deleteElement(g_xccj3_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more
   
   #end add-point
   
   
 
   FREE axct302_pb3   
   
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
PRIVATE FUNCTION axct302_chk_ld_comp()
DEFINE r_success        LIKE type_t.num5
   DEFINE l_success        LIKE type_t.num5
   
   LET r_success = TRUE

#只检查法人
   IF g_xccj_m.xccjld IS NULL AND g_xccj_m.xccjcomp IS NOT NULL THEN   
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
      
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_xccj_m.xccjcomp
         
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
   IF g_xccj_m.xccjld IS NOT NULL AND g_xccj_m.xccjcomp IS NULL THEN
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
      
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_xccj_m.xccjld
      #160318-00025#11--add--str
      LET g_errshow = TRUE 
      LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
      #160318-00025#11--add--end    
      #呼叫檢查存在並帶值的library
      IF cl_chk_exist("v_glaald") THEN
         #檢查成功時後續處理
         #LET  = g_chkparam.return1
         #DISPLAY BY NAME 
         CALL s_ld_chk_authorization(g_user,g_xccj_m.xccjld) RETURNING l_success
         IF l_success = FALSE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'axr-00022'
            LET g_errparam.extend = g_xccj_m.xccjld
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
   IF NOT s_ld_chk_comp(g_xccj_m.xccjld,g_xccj_m.xccjcomp) THEN  #v_glaald_5 
      LET g_xccj_m.xccjcomp = g_xccj_m_t.xccjcomp
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
PRIVATE FUNCTION axct302_ref()
   
   IF g_xccj_m.xccjcomp IS NULL THEN     
      
      SELECT glaacomp
        INTO g_xccj_m.xccjcomp
        FROM glaa_t  
       WHERE glaaent = g_enterprise 
         AND glaald = g_xccj_m.xccjld
      DISPLAY BY NAME g_xccj_m.xccjcomp      
      SELECT glaa010,glaa011 INTO g_xccj_m.xccj004,g_xccj_m.xccj005
       FROM glaa_t
       WHERE glaaent  = g_enterprise
         AND glaacomp = g_xccj_m.xccjcomp
         AND glaa014 = 'Y'
      DISPLAY BY NAME g_xccj_m.xccj004,g_xccj_m.xccj005
   ELSE
      IF g_xccj_m.xccjld IS NULL THEN  
         SELECT glaald,glaa010,glaa011 INTO g_xccj_m.xccjld,g_xccj_m.xccj004,g_xccj_m.xccj005
          FROM glaa_t
          WHERE glaaent  = g_enterprise
            AND glaacomp = g_xccj_m.xccjcomp
            AND glaa014 = 'Y'
         DISPLAY BY NAME g_xccj_m.xccjld,g_xccj_m.xccj004,g_xccj_m.xccj005
      END IF
   END IF
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xccj_m.xccjcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccj_m.xccjcomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccj_m.xccjcomp_desc   
       
 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xccj_m.xccjld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccj_m.xccjld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccj_m.xccjld_desc   
   
   
   
   INITIALIZE g_ref_fields TO NULL                                                                                                                                                      
   LET g_ref_fields[1] = g_xccj_m.xccj003                                                                                                                                   
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccj_m.xccj003_desc = '', g_rtn_fields[1] , ''                                                                                                                     
   DISPLAY BY NAME g_xccj_m.xccj003_desc 
   
    SELECT glaa001,glaa003,glaa015,glaa016,glaa018,glaa019,glaa020,glaa022,glaa025 
     INTO g_glaa001,g_glaa003,g_glaa015,g_glaa016,g_glaa018,g_glaa019,g_glaa020,g_glaa022,g_glaa025 
     FROM glaa_t
    WHERE glaaent = g_enterprise 
      AND glaald = g_xccj_m.xccjld
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
PRIVATE FUNCTION axct302_xccj102_sum_1()
   IF cl_null(g_xccj_d[l_ac].xccj102a) THEN LET g_xccj_d[l_ac].xccj102a = 0 END IF
   IF cl_null(g_xccj_d[l_ac].xccj102b) THEN LET g_xccj_d[l_ac].xccj102b = 0 END IF
   IF cl_null(g_xccj_d[l_ac].xccj102c) THEN LET g_xccj_d[l_ac].xccj102c = 0 END IF
   IF cl_null(g_xccj_d[l_ac].xccj102d) THEN LET g_xccj_d[l_ac].xccj102d = 0 END IF
   IF cl_null(g_xccj_d[l_ac].xccj102e) THEN LET g_xccj_d[l_ac].xccj102e = 0 END IF
   IF cl_null(g_xccj_d[l_ac].xccj102f) THEN LET g_xccj_d[l_ac].xccj102f = 0 END IF
   IF cl_null(g_xccj_d[l_ac].xccj102g) THEN LET g_xccj_d[l_ac].xccj102g = 0 END IF
   IF cl_null(g_xccj_d[l_ac].xccj102h) THEN LET g_xccj_d[l_ac].xccj102h = 0 END IF
   
   LET g_xccj_d[l_ac].xccj102=g_xccj_d[l_ac].xccj102a+g_xccj_d[l_ac].xccj102b+g_xccj_d[l_ac].xccj102c
                             +g_xccj_d[l_ac].xccj102d+g_xccj_d[l_ac].xccj102e+g_xccj_d[l_ac].xccj102f 
                             +g_xccj_d[l_ac].xccj102g+g_xccj_d[l_ac].xccj102h    
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
PRIVATE FUNCTION axct302_xccj102_sum_2()
   IF cl_null(g_xccj2_d[l_ac].xccj102a) THEN LET g_xccj2_d[l_ac].xccj102a = 0 END IF
   IF cl_null(g_xccj2_d[l_ac].xccj102b) THEN LET g_xccj2_d[l_ac].xccj102b = 0 END IF
   IF cl_null(g_xccj2_d[l_ac].xccj102c) THEN LET g_xccj2_d[l_ac].xccj102c = 0 END IF
   IF cl_null(g_xccj2_d[l_ac].xccj102d) THEN LET g_xccj2_d[l_ac].xccj102d = 0 END IF
   IF cl_null(g_xccj2_d[l_ac].xccj102e) THEN LET g_xccj2_d[l_ac].xccj102e = 0 END IF
   IF cl_null(g_xccj2_d[l_ac].xccj102f) THEN LET g_xccj2_d[l_ac].xccj102f = 0 END IF
   IF cl_null(g_xccj2_d[l_ac].xccj102g) THEN LET g_xccj2_d[l_ac].xccj102g = 0 END IF
   IF cl_null(g_xccj2_d[l_ac].xccj102h) THEN LET g_xccj2_d[l_ac].xccj102h = 0 END IF
   
   LET g_xccj2_d[l_ac].xccj102=g_xccj2_d[l_ac].xccj102a+g_xccj2_d[l_ac].xccj102b+g_xccj2_d[l_ac].xccj102c
                              +g_xccj2_d[l_ac].xccj102d+g_xccj2_d[l_ac].xccj102e+g_xccj2_d[l_ac].xccj102f 
                              +g_xccj2_d[l_ac].xccj102g+g_xccj2_d[l_ac].xccj102h  
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
PRIVATE FUNCTION axct302_xccj102_sum_3()
   IF cl_null(g_xccj3_d[l_ac].xccj102a) THEN LET g_xccj3_d[l_ac].xccj102a = 0 END IF
   IF cl_null(g_xccj3_d[l_ac].xccj102b) THEN LET g_xccj3_d[l_ac].xccj102b = 0 END IF
   IF cl_null(g_xccj3_d[l_ac].xccj102c) THEN LET g_xccj3_d[l_ac].xccj102c = 0 END IF
   IF cl_null(g_xccj3_d[l_ac].xccj102d) THEN LET g_xccj3_d[l_ac].xccj102d = 0 END IF
   IF cl_null(g_xccj3_d[l_ac].xccj102e) THEN LET g_xccj3_d[l_ac].xccj102e = 0 END IF
   IF cl_null(g_xccj3_d[l_ac].xccj102f) THEN LET g_xccj3_d[l_ac].xccj102f = 0 END IF
   IF cl_null(g_xccj3_d[l_ac].xccj102g) THEN LET g_xccj3_d[l_ac].xccj102g = 0 END IF
   IF cl_null(g_xccj3_d[l_ac].xccj102h) THEN LET g_xccj3_d[l_ac].xccj102h = 0 END IF
   
   LET g_xccj3_d[l_ac].xccj102=g_xccj3_d[l_ac].xccj102a+g_xccj3_d[l_ac].xccj102b+g_xccj3_d[l_ac].xccj102c
                              +g_xccj3_d[l_ac].xccj102d+g_xccj3_d[l_ac].xccj102e+g_xccj3_d[l_ac].xccj102f 
                              +g_xccj3_d[l_ac].xccj102g+g_xccj3_d[l_ac].xccj102h  
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
PRIVATE FUNCTION axct302_insert_xccj()
DEFINE l_rate     LIKE ooan_t.ooan005
DEFINE l_amount   LIKE xccj_t.xccj102
   LET l_amount = 0 
   LET l_rate = 1
   IF g_glaa015 = 'Y' THEN
      CALL s_aooi160_get_exrate('2',g_xccj_m.xccjld,g_today,g_glaa001,g_glaa016,0,g_glaa018)
           RETURNING l_rate
      LET g_xccj2_d[l_ac].xccj102a = g_xccj_d[l_ac].xccj102a * l_rate
      LET g_xccj2_d[l_ac].xccj102b = g_xccj_d[l_ac].xccj102b * l_rate
      LET g_xccj2_d[l_ac].xccj102c = g_xccj_d[l_ac].xccj102c * l_rate
      LET g_xccj2_d[l_ac].xccj102d = g_xccj_d[l_ac].xccj102d * l_rate
      LET g_xccj2_d[l_ac].xccj102e = g_xccj_d[l_ac].xccj102e * l_rate
      LET g_xccj2_d[l_ac].xccj102f = g_xccj_d[l_ac].xccj102f * l_rate
      LET g_xccj2_d[l_ac].xccj102g = g_xccj_d[l_ac].xccj102g * l_rate
      LET g_xccj2_d[l_ac].xccj102h = g_xccj_d[l_ac].xccj102h * l_rate
      CALL axct302_xccj102_sum_2()
      LET g_xccj2_d[l_ac].xccj102a = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102a,2)
      LET g_xccj2_d[l_ac].xccj102b = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102b,2)
      LET g_xccj2_d[l_ac].xccj102c = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102c,2)
      LET g_xccj2_d[l_ac].xccj102d = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102d,2)
      LET g_xccj2_d[l_ac].xccj102e = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102e,2)
      LET g_xccj2_d[l_ac].xccj102f = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102f,2)
      LET g_xccj2_d[l_ac].xccj102g = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102g,2)
      LET g_xccj2_d[l_ac].xccj102h = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102h,2)
      LET g_xccj2_d[l_ac].xccj102 = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102,2)
      
      INSERT INTO xccj_t
            (xccjent,
             xccjcomp,xccj004,xccj005,xccjld,xccj003,
             xccj001,xccj002,xccj006,xccj007,xccj008,xccj009,xccj010,xccj011,xccj012
             ,xccj013,xccj015,xccj016,xccj017,xccj020,xccj101,xccj102,xccj102a,xccj102b,xccj102c,xccj102d,xccj102e,xccj102f,xccj102g,xccj102h) 
      VALUES(g_enterprise,
             g_xccj_m.xccjcomp,g_xccj_m.xccj004,g_xccj_m.xccj005,g_xccj_m.xccjld,g_xccj_m.xccj003,
             '2',g_xccj_d[l_ac].xccj002,g_xccj_d[l_ac].xccj006,g_xccj_d[l_ac].xccj007, 
                 g_xccj_d[l_ac].xccj008,g_xccj_d[l_ac].xccj009,g_xccj_d[l_ac].xccj010, 
                 g_xccj_d[l_ac].xccj011,g_xccj_d[l_ac].xccj012
             ,g_xccj_d[l_ac].xccj013,g_xccj_d[l_ac].xccj015,g_xccj_d[l_ac].xccj016,g_xccj_d[l_ac].xccj017, 
                 g_xccj_d[l_ac].xccj020,g_xccj_d[l_ac].xccj101,g_xccj2_d[l_ac].xccj102, 
                 g_xccj2_d[l_ac].xccj102a,g_xccj2_d[l_ac].xccj102b,g_xccj2_d[l_ac].xccj102c, 
                 g_xccj2_d[l_ac].xccj102d,g_xccj2_d[l_ac].xccj102e,g_xccj2_d[l_ac].xccj102f, 
                 g_xccj2_d[l_ac].xccj102g,g_xccj2_d[l_ac].xccj102h)      
      
   END IF
   LET l_amount = 0 
   LET l_rate = 1
   IF g_glaa019 = 'Y' THEN
      CALL s_aooi160_get_exrate('2',g_xccj_m.xccjld,g_today,g_glaa001,g_glaa020,0,g_glaa022)
           RETURNING l_rate
      LET g_xccj3_d[l_ac].xccj102a = g_xccj_d[l_ac].xccj102a * l_rate
      LET g_xccj3_d[l_ac].xccj102b = g_xccj_d[l_ac].xccj102b * l_rate
      LET g_xccj3_d[l_ac].xccj102c = g_xccj_d[l_ac].xccj102c * l_rate
      LET g_xccj3_d[l_ac].xccj102d = g_xccj_d[l_ac].xccj102d * l_rate
      LET g_xccj3_d[l_ac].xccj102e = g_xccj_d[l_ac].xccj102e * l_rate
      LET g_xccj3_d[l_ac].xccj102f = g_xccj_d[l_ac].xccj102f * l_rate
      LET g_xccj3_d[l_ac].xccj102g = g_xccj_d[l_ac].xccj102g * l_rate
      LET g_xccj3_d[l_ac].xccj102h = g_xccj_d[l_ac].xccj102h * l_rate
      CALL axct302_xccj102_sum_3()
      LET g_xccj3_d[l_ac].xccj102a = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102a,2)
      LET g_xccj3_d[l_ac].xccj102b = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102b,2)
      LET g_xccj3_d[l_ac].xccj102c = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102c,2)
      LET g_xccj3_d[l_ac].xccj102d = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102d,2)
      LET g_xccj3_d[l_ac].xccj102e = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102e,2)
      LET g_xccj3_d[l_ac].xccj102f = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102f,2)
      LET g_xccj3_d[l_ac].xccj102g = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102g,2)
      LET g_xccj3_d[l_ac].xccj102h = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102h,2)
      LET g_xccj3_d[l_ac].xccj102 = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102,2)
      
      INSERT INTO xccj_t
            (xccjent,
             xccjcomp,xccj004,xccj005,xccjld,xccj003,
             xccj001,xccj002,xccj006,xccj007,xccj008,xccj009,xccj010,xccj011,xccj012
             ,xccj013,xccj015,xccj016,xccj017,xccj020,xccj101,xccj102,xccj102a,xccj102b,xccj102c,xccj102d,xccj102e,xccj102f,xccj102g,xccj102h) 
      VALUES(g_enterprise,
             g_xccj_m.xccjcomp,g_xccj_m.xccj004,g_xccj_m.xccj005,g_xccj_m.xccjld,g_xccj_m.xccj003,
             '3',g_xccj_d[l_ac].xccj002,g_xccj_d[l_ac].xccj006,g_xccj_d[l_ac].xccj007, 
                 g_xccj_d[l_ac].xccj008,g_xccj_d[l_ac].xccj009,g_xccj_d[l_ac].xccj010, 
                 g_xccj_d[l_ac].xccj011,g_xccj_d[l_ac].xccj012
             ,g_xccj_d[l_ac].xccj013,g_xccj_d[l_ac].xccj015,g_xccj_d[l_ac].xccj016,g_xccj_d[l_ac].xccj017, 
                 g_xccj_d[l_ac].xccj020,g_xccj_d[l_ac].xccj101,g_xccj3_d[l_ac].xccj102, 
                 g_xccj3_d[l_ac].xccj102a,g_xccj3_d[l_ac].xccj102b,g_xccj3_d[l_ac].xccj102c, 
                 g_xccj3_d[l_ac].xccj102d,g_xccj3_d[l_ac].xccj102e,g_xccj3_d[l_ac].xccj102f, 
                 g_xccj3_d[l_ac].xccj102g,g_xccj3_d[l_ac].xccj102h)
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
PRIVATE FUNCTION axct302_update_xccj()
DEFINE l_rate     LIKE ooan_t.ooan005
DEFINE l_amount   LIKE xccj_t.xccj102
   LET l_amount = 0 
   LET l_rate = 1
   IF g_glaa015 = 'Y' THEN
      CALL s_aooi160_get_exrate('2',g_xccj_m.xccjld,g_today,g_glaa001,g_glaa016,0,g_glaa018)
           RETURNING l_rate
      LET g_xccj2_d[l_ac].xccj102a = g_xccj_d[l_ac].xccj102a * l_rate
      LET g_xccj2_d[l_ac].xccj102b = g_xccj_d[l_ac].xccj102b * l_rate
      LET g_xccj2_d[l_ac].xccj102c = g_xccj_d[l_ac].xccj102c * l_rate
      LET g_xccj2_d[l_ac].xccj102d = g_xccj_d[l_ac].xccj102d * l_rate
      LET g_xccj2_d[l_ac].xccj102e = g_xccj_d[l_ac].xccj102e * l_rate
      LET g_xccj2_d[l_ac].xccj102f = g_xccj_d[l_ac].xccj102f * l_rate
      LET g_xccj2_d[l_ac].xccj102g = g_xccj_d[l_ac].xccj102g * l_rate
      LET g_xccj2_d[l_ac].xccj102h = g_xccj_d[l_ac].xccj102h * l_rate
      CALL axct302_xccj102_sum_2()
      LET g_xccj2_d[l_ac].xccj102a = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102a,2)
      LET g_xccj2_d[l_ac].xccj102b = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102b,2)
      LET g_xccj2_d[l_ac].xccj102c = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102c,2)
      LET g_xccj2_d[l_ac].xccj102d = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102d,2)
      LET g_xccj2_d[l_ac].xccj102e = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102e,2)
      LET g_xccj2_d[l_ac].xccj102f = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102f,2)
      LET g_xccj2_d[l_ac].xccj102g = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102g,2)
      LET g_xccj2_d[l_ac].xccj102h = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102h,2)
      LET g_xccj2_d[l_ac].xccj102 = s_curr_round(g_xccj_m.xccjcomp,g_glaa016,g_xccj2_d[l_ac].xccj102,2)
      
       UPDATE xccj_t SET (xccjld,xccj003,xccj004,xccj005,xccj001,xccj006,xccj007,xccj008,xccj013, 
                   xccj009,xccj010,xccj011,xccj015,xccj016,xccj017,xccj020,xccj012,xccj002,xccj101,xccj102, 
                   xccj102a,xccj102b,xccj102c,xccj102d,xccj102e,xccj102f,xccj102g,xccj102h) = (g_xccj_m.xccjld, 
                   g_xccj_m.xccj003,g_xccj_m.xccj004,g_xccj_m.xccj005,'2',g_xccj_d[l_ac].xccj006, 
                   g_xccj_d[l_ac].xccj007,g_xccj_d[l_ac].xccj008,g_xccj_d[l_ac].xccj013,g_xccj_d[l_ac].xccj009, 
                   g_xccj_d[l_ac].xccj010,g_xccj_d[l_ac].xccj011,g_xccj_d[l_ac].xccj015,g_xccj_d[l_ac].xccj016, 
                   g_xccj_d[l_ac].xccj017,g_xccj_d[l_ac].xccj020,g_xccj_d[l_ac].xccj012,g_xccj_d[l_ac].xccj002, 
                   g_xccj_d[l_ac].xccj101,g_xccj2_d[l_ac].xccj102,g_xccj2_d[l_ac].xccj102a,g_xccj2_d[l_ac].xccj102b, 
                   g_xccj2_d[l_ac].xccj102c,g_xccj2_d[l_ac].xccj102d,g_xccj2_d[l_ac].xccj102e,g_xccj2_d[l_ac].xccj102f, 
                   g_xccj2_d[l_ac].xccj102g,g_xccj2_d[l_ac].xccj102h)
                WHERE xccjent = g_enterprise AND xccjld = g_xccj_m.xccjld 
                 AND xccj003 = g_xccj_m.xccj003 
                 AND xccj004 = g_xccj_m.xccj004 
                 AND xccj005 = g_xccj_m.xccj005 
 
                 AND xccj001 = '2' #項次   
                 AND xccj002 = g_xccj_d_t.xccj002  
                 AND xccj006 = g_xccj_d_t.xccj006  
                 AND xccj007 = g_xccj_d_t.xccj007  
                 AND xccj008 = g_xccj_d_t.xccj008  
                 AND xccj009 = g_xccj_d_t.xccj009  
#                 AND xccj010 = g_xccj_d_t.xccj010  
#                 AND xccj011 = g_xccj_d_t.xccj011  
#                 AND xccj012 = g_xccj_d_t.xccj012       
      
   END IF
   LET l_amount = 0 
   LET l_rate = 1
   IF g_glaa019 = 'Y' THEN
      CALL s_aooi160_get_exrate('2',g_xccj_m.xccjld,g_today,g_glaa001,g_glaa020,0,g_glaa022)
           RETURNING l_rate
      LET g_xccj3_d[l_ac].xccj102a = g_xccj_d[l_ac].xccj102a * l_rate
      LET g_xccj3_d[l_ac].xccj102b = g_xccj_d[l_ac].xccj102b * l_rate
      LET g_xccj3_d[l_ac].xccj102c = g_xccj_d[l_ac].xccj102c * l_rate
      LET g_xccj3_d[l_ac].xccj102d = g_xccj_d[l_ac].xccj102d * l_rate
      LET g_xccj3_d[l_ac].xccj102e = g_xccj_d[l_ac].xccj102e * l_rate
      LET g_xccj3_d[l_ac].xccj102f = g_xccj_d[l_ac].xccj102f * l_rate
      LET g_xccj3_d[l_ac].xccj102g = g_xccj_d[l_ac].xccj102g * l_rate
      LET g_xccj3_d[l_ac].xccj102h = g_xccj_d[l_ac].xccj102h * l_rate
      CALL axct302_xccj102_sum_3()
      LET g_xccj3_d[l_ac].xccj102a = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102a,2)
      LET g_xccj3_d[l_ac].xccj102b = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102b,2)
      LET g_xccj3_d[l_ac].xccj102c = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102c,2)
      LET g_xccj3_d[l_ac].xccj102d = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102d,2)
      LET g_xccj3_d[l_ac].xccj102e = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102e,2)
      LET g_xccj3_d[l_ac].xccj102f = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102f,2)
      LET g_xccj3_d[l_ac].xccj102g = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102g,2)
      LET g_xccj3_d[l_ac].xccj102h = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102h,2)
      LET g_xccj3_d[l_ac].xccj102 = s_curr_round(g_xccj_m.xccjcomp,g_glaa020,g_xccj3_d[l_ac].xccj102,2)
      
      UPDATE xccj_t SET (xccjld,xccj003,xccj004,xccj005,xccj001,xccj006,xccj007,xccj008,xccj013, 
          xccj009,xccj010,xccj011,xccj015,xccj016,xccj017,xccj020,xccj012,xccj002,xccj101,xccj102, 
          xccj102a,xccj102b,xccj102c,xccj102d,xccj102e,xccj102f,xccj102g,xccj102h) = (g_xccj_m.xccjld, 
          g_xccj_m.xccj003,g_xccj_m.xccj004,g_xccj_m.xccj005,'3',g_xccj_d[l_ac].xccj006, 
          g_xccj_d[l_ac].xccj007,g_xccj_d[l_ac].xccj008,g_xccj_d[l_ac].xccj013,g_xccj_d[l_ac].xccj009, 
          g_xccj_d[l_ac].xccj010,g_xccj_d[l_ac].xccj011,g_xccj_d[l_ac].xccj015,g_xccj_d[l_ac].xccj016, 
          g_xccj_d[l_ac].xccj017,g_xccj_d[l_ac].xccj020,g_xccj_d[l_ac].xccj012,g_xccj_d[l_ac].xccj002, 
          g_xccj_d[l_ac].xccj101,g_xccj3_d[l_ac].xccj102,g_xccj3_d[l_ac].xccj102a,g_xccj3_d[l_ac].xccj102b, 
          g_xccj3_d[l_ac].xccj102c,g_xccj3_d[l_ac].xccj102d,g_xccj3_d[l_ac].xccj102e,g_xccj3_d[l_ac].xccj102f, 
          g_xccj3_d[l_ac].xccj102g,g_xccj3_d[l_ac].xccj102h)
       WHERE xccjent = g_enterprise AND xccjld = g_xccj_m.xccjld 
        AND xccj003 = g_xccj_m.xccj003 
        AND xccj004 = g_xccj_m.xccj004 
        AND xccj005 = g_xccj_m.xccj005 
 
        AND xccj001 = '3' #項次   
        AND xccj002 = g_xccj_d_t.xccj002  
        AND xccj006 = g_xccj_d_t.xccj006  
        AND xccj007 = g_xccj_d_t.xccj007  
        AND xccj008 = g_xccj_d_t.xccj008  
        AND xccj009 = g_xccj_d_t.xccj009  
#        AND xccj010 = g_xccj_d_t.xccj010  
#        AND xccj011 = g_xccj_d_t.xccj011  
#        AND xccj012 = g_xccj_d_t.xccj012  
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
PRIVATE FUNCTION axct302_before_delete_2()
 DEFINE l_sql           STRING 
 DEFINE l_xcdj_count    LIKE type_t.num5
# #删除axct306已有资料 
#  LET l_sql = "SELECT COUNT(*) FROM xcdj_t ",
#              " WHERE xcdjent = ? AND xcdjcomp = ? AND xcdjld = ?",
#              "   AND xcdj003 = ? AND xcdj004 = ? AND xcdj005 = ? "              
#  DECLARE axct302_xcdj_count_cs3 CURSOR FROM l_sql 
#  OPEN axct302_xcdj_count_cs3 USING g_enterprise,g_xccj_m.xccjcomp,g_xccj_m.xccjld,
#                                   g_xccj_m.xccj003,g_xccj_m.xccj004,g_xccj_m.xccj005
#                                   
#  FETCH axct302_xcdj_count_cs3 INTO l_xcdj_count
#  IF l_xcdj_count > 0 THEN
#     IF cl_ask_confirm('axc-00388') THEN   
#        LET l_sql = "DELETE FROM xcdj_t ",
#                    " WHERE xcdjent = '",g_enterprise,"'  AND xcdjcomp = '",g_xccj_m.xccjcomp,"'",
#                    "   AND xcdjld = '",g_xccj_m.xccjld,"' AND xcdj003 = '",g_xccj_m.xccj003,"'",
#                    "   AND xcdj004 = '",g_xccj_m.xccj004,"' AND xcdj005 = '",g_xccj_m.xccj005,"'"                   
#                     
#        PREPARE axct302_del_xcdj2 FROM l_sql
#        IF SQLCA.sqlcode THEN
#           INITIALIZE g_errparam TO NULL
#           LET g_errparam.code   = SQLCA.sqlcode
#           LET g_errparam.extend = "PREPARE delete xcdj_t"
#           LET g_errparam.popup  = TRUE
#           CALL cl_err()
#           RETURN 
#        END IF
#        EXECUTE axct302_del_xcdj2 
#        IF SQLCA.sqlcode THEN
#           INITIALIZE g_errparam TO NULL
#           LET g_errparam.code   = SQLCA.sqlcode
#           LET g_errparam.extend = "EXECUTE delete xcdj_t"
#           LET g_errparam.popup  = TRUE
#           CALL cl_err()
#           RETURN 
#        END IF 
#     ELSE 
#        RETURN         
#     END IF  
#  END IF
 
 
 
 DELETE FROM xccj_t
    WHERE xccjent = g_enterprise AND xccjld = g_xccj_m.xccjld AND
                              xccj003 = g_xccj_m.xccj003 AND
                              xccj004 = g_xccj_m.xccj004 AND
                              xccj005 = g_xccj_m.xccj005 AND
 
          xccj001 = g_xccj2_d_t.xccj001
      AND xccj002 = g_xccj2_d_t.xccj002
      AND xccj006 = g_xccj2_d_t.xccj006
      AND xccj007 = g_xccj2_d_t.xccj007
      AND xccj008 = g_xccj2_d_t.xccj008
      AND xccj009 = g_xccj2_d_t.xccj009
      
 
      
   #add-point:單筆刪除中
 
     DELETE FROM xccj_t
       WHERE xccjent = g_enterprise AND xccjld = g_xccj_m.xccjld AND
                                 xccj003 = g_xccj_m.xccj003 AND
                                 xccj004 = g_xccj_m.xccj004 AND
                                 xccj005 = g_xccj_m.xccj005 
             
         AND xccj002 = g_xccj2_d_t.xccj002
         AND xccj006 = g_xccj2_d_t.xccj006
         AND xccj007 = g_xccj2_d_t.xccj007
         AND xccj008 = g_xccj2_d_t.xccj008
         AND xccj009 = g_xccj2_d_t.xccj009
         
  
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccj_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      RETURN FALSE 
   END IF
   
   #add-point:單筆刪除後

   #end add-point
 
   LET g_rec_b = g_rec_b-1
   DISPLAY g_rec_b TO FORMONLY.cnt
 
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
PRIVATE FUNCTION axct302_before_delete_3()
 DEFINE l_sql           STRING 
 DEFINE l_xcdj_count    LIKE type_t.num5
# #删除axct306已有资料 
#  LET l_sql = "SELECT COUNT(*) FROM xcdj_t ",
#              " WHERE xcdjent = ? AND xcdjcomp = ? AND xcdjld = ?",
#              "   AND xcdj003 = ? AND xcdj004 = ? AND xcdj005 = ? "              
#  DECLARE axct302_xcdj_count_cs4 CURSOR FROM l_sql 
#  OPEN axct302_xcdj_count_cs4 USING g_enterprise,g_xccj_m.xccjcomp,g_xccj_m.xccjld,
#                                   g_xccj_m.xccj003,g_xccj_m.xccj004,g_xccj_m.xccj005
#                                   
#  FETCH axct302_xcdj_count_cs4 INTO l_xcdj_count
#  IF l_xcdj_count > 0 THEN
#     IF cl_ask_confirm('axc-00388') THEN   
#        LET l_sql = "DELETE FROM xcdj_t ",
#                    " WHERE xcdjent = '",g_enterprise,"'  AND xcdjcomp = '",g_xccj_m.xccjcomp,"'",
#                    "   AND xcdjld = '",g_xccj_m.xccjld,"' AND xcdj003 = '",g_xccj_m.xccj003,"'",
#                    "   AND xcdj004 = '",g_xccj_m.xccj004,"' AND xcdj005 = '",g_xccj_m.xccj005,"'"                   
#                     
#        PREPARE axct302_del_xcdj3 FROM l_sql
#        IF SQLCA.sqlcode THEN
#           INITIALIZE g_errparam TO NULL
#           LET g_errparam.code   = SQLCA.sqlcode
#           LET g_errparam.extend = "PREPARE delete xcdj_t"
#           LET g_errparam.popup  = TRUE
#           CALL cl_err()
#           RETURN 
#        END IF
#        EXECUTE axct302_del_xcdj3 
#        IF SQLCA.sqlcode THEN
#           INITIALIZE g_errparam TO NULL
#           LET g_errparam.code   = SQLCA.sqlcode
#           LET g_errparam.extend = "EXECUTE delete xcdj_t"
#           LET g_errparam.popup  = TRUE
#           CALL cl_err()
#           RETURN 
#        END IF 
#     ELSE 
#        RETURN         
#     END IF  
#  END IF
 
 
 
 DELETE FROM xccj_t
    WHERE xccjent = g_enterprise AND xccjld = g_xccj_m.xccjld AND
                              xccj003 = g_xccj_m.xccj003 AND
                              xccj004 = g_xccj_m.xccj004 AND
                              xccj005 = g_xccj_m.xccj005 AND
 
          xccj001 = g_xccj3_d_t.xccj001
      AND xccj002 = g_xccj3_d_t.xccj002
      AND xccj006 = g_xccj3_d_t.xccj006
      AND xccj007 = g_xccj3_d_t.xccj007
      AND xccj008 = g_xccj3_d_t.xccj008
      AND xccj009 = g_xccj3_d_t.xccj009
      
 
      
   #add-point:單筆刪除中
 
     DELETE FROM xccj_t
       WHERE xccjent = g_enterprise AND xccjld = g_xccj_m.xccjld AND
                                 xccj003 = g_xccj_m.xccj003 AND
                                 xccj004 = g_xccj_m.xccj004 AND
                                 xccj005 = g_xccj_m.xccj005 
             
         AND xccj002 = g_xccj3_d_t.xccj002
         AND xccj006 = g_xccj3_d_t.xccj006
         AND xccj007 = g_xccj3_d_t.xccj007
         AND xccj008 = g_xccj3_d_t.xccj008
         AND xccj009 = g_xccj3_d_t.xccj009
         
  
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccj_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      RETURN FALSE 
   END IF
   
   #add-point:單筆刪除後

   #end add-point
 
   LET g_rec_b = g_rec_b-1
   DISPLAY g_rec_b TO FORMONLY.cnt
 
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
PRIVATE FUNCTION axct302_s01()
DEFINE p_xrad001      LIKE xrad_t.xrad001
DEFINE l_xradl003     LIKE type_t.chr80
DEFINE ls_str          STRING
DEFINE l_chr           LIKE type_t.chr1   
DEFINE l_chr1          LIKE type_t.chr1  
DEFINE l_num           LIKE type_t.num5
   
   OPEN WINDOW w_axct302_s01 WITH FORM cl_ap_formpath("axc","axct302_s01")
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #輸入開始
      INPUT BY NAME g_xccj_s.name,g_xccj_s.dir
         BEFORE INPUT
           


         AFTER INPUT
            

      END INPUT

      DISPLAY ARRAY g_xccj5_d TO s_detail5.* ATTRIBUTES(COUNT=g_rec_b)  

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
         CALL cl_client_browse_dir() RETURNING g_xccj_s.dir
         LET ls_str = g_xccj_s.dir
         #抓取目录斜杆
         LET l_num =ls_str.getIndexOf(':',1)                                    #抓取：后的字符位置
         LET l_chr = ls_str.substring(l_num+1,l_num+1)                          #截取冒号后的字符 
         LET l_chr1 = ls_str.substring(ls_str.getLength(),ls_str.getLength())   #判断是否为根目录
         IF l_chr <> l_chr1  THEN         
            LET g_xccj_s.dir = g_xccj_s.dir||l_chr 
         ELSE
            LET g_xccj_s.dir = g_xccj_s.dir 
         END IF 
         DISPLAY BY NAME g_xccj_s.dir
         
      ON ACTION produce
#         CALL axct302_show_1()
         LET w = ui.Window.getCurrent()
         LET f = w.getForm()
         LET page = f.FindNode("Page","bpage_1")
         CALL axct302_excelexample(page,base.TypeInfo.create(g_xccj5_d),'Y')
         ACCEPT DIALOG 

      ON ACTION off
         LET INT_FLAG = TRUE
         EXIT DIALOG


   END DIALOG

   



      #畫面關閉
      CLOSE WINDOW w_axct302_s01
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
PRIVATE FUNCTION axct302_excelexample(n,t,p_show_hidden)
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
   LET xls_name = g_xccj_s.name CLIPPED,".xls"

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
            IF l_field_name= 'xccj_t.xccjent' OR l_field_name= 'xccj_t.xccjld' OR
               l_field_name= 'xccj_t.xccjcomp' OR l_field_name= 'xccj_t.xccj001' OR  
               l_field_name= 'xccj_t.xccj004' OR l_field_name= 'xccj_t.xccj005' OR
               l_field_name= 'xccj_t.xccj003' OR l_field_name= 'xccj_t.xccj006' OR
               l_field_name= 'xccj_t.xccj007' OR l_field_name= 'xccj_t.xccj008' OR
               l_field_name= 'xccj_t.xccj013' OR l_field_name= 'xccj_t.xccj009' OR
               l_field_name= 'xccj_t.xccj010' OR l_field_name= 'xccj_t.xccj011' OR
               l_field_name= 'xccj_t.xccj015' OR l_field_name= 'xccj_t.xccj016' OR           
               l_field_name= 'xccj_t.xccj017' OR l_field_name= 'xccj_t.xccj012' OR  
               l_field_name= 'xccj_t.xccj020' OR l_field_name= 'xccj_t.xccj002' OR 
               l_field_name= 'xccj_t.xccj101' OR l_field_name= 'xccj_t.xccj102' OR
               l_field_name= 'xccj_t.xccj102a' OR l_field_name= 'xccj_t.xccj102b' OR
               l_field_name= 'xccj_t.xccj102c' OR l_field_name= 'xccj_t.xccj102d' OR
               l_field_name= 'xccj_t.xccj102e' OR l_field_name= 'xccj_t.xccj102f' OR
               l_field_name= 'xccj_t.xccj102g' OR l_field_name= 'xccj_t.xccj102h' OR
               l_field_name = 'formonly.xccj102_1' OR l_field_name = 'formonly.xccj102a_1' OR
               l_field_name = 'formonly.xccj102b_1' OR l_field_name = 'formonly.xccj102c_1' OR
               l_field_name = 'formonly.xccj102d_1' OR l_field_name = 'formonly.xccj102e_1' OR
               l_field_name = 'formonly.xccj102f_1' OR l_field_name = 'formonly.xccj102g_1' OR
               l_field_name = 'formonly.xccj102h_1' OR l_field_name = 'formonly.xccj102_2' OR
               l_field_name = 'formonly.xccj102a_2' OR l_field_name = 'formonly.xccj102b_2' OR
               l_field_name = 'formonly.xccj102c_2' OR l_field_name = 'formonly.xccj102d_2' OR
               l_field_name = 'formonly.xccj102e_2' OR l_field_name = 'formonly.xccj102f_2' OR
               l_field_name = 'formonly.xccj102g_2' OR l_field_name = 'formonly.xccj102h_2' 
                 
               THEN
               LET values = n1_text.getAttribute("text")
               LET l_str = "<td>",axct302_add_span(values),"</td>"
               CALL l_channel.write(l_str CLIPPED)
            END IF
         ELSE
            LET g_hidden[i] = "1"
            LET k = k -1
         END IF
      END FOR
      IF h=1 THEN CALL axct302_get_boday(h,cnt_header,t,combo_arr,l_seq) END IF

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
PRIVATE FUNCTION axct302_s02()
DEFINE l_excel         STRING 
DEFINE ls_str          STRING
DEFINE l_chr           LIKE type_t.chr1   
DEFINE l_chr1          LIKE type_t.chr1   
DEFINE l_num           LIKE type_t.num5
DEFINE l_n             LIKE type_t.num5
DEFINE l_success       LIKE type_t.num5
   #畫面開啟 (identifier)

   OPEN WINDOW w_axct302_s02 WITH FORM cl_ap_formpath("axc","axct302_s02")

   INITIALIZE g_xccj_f.* LIKE xccj_t.*
   
   LET g_xccj_f_t.xccjcomp = NULL
   LET g_xccj_f_t.xccjld = NULL
   LET g_xccj_f_t.format = NULL
   LET g_xccj_f_t.char = NULL
   LET g_xccj_f_t.dir = NULL
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_xccj_f.xccjcomp,g_xccj_f.xccjld,g_xccj_f.format,g_xccj_f.char,g_xccj_f.dir ATTRIBUTE(WITHOUT  DEFAULTS)

         BEFORE INPUT
            CALL cl_set_combo_scc('format','8915')
 
         AFTER FIELD xccjcomp
            IF NOT cl_null(g_xccj_f.xccjcomp) THEN               
                  IF NOT axct302_s02_chk_ld_comp() THEN
                     LET g_xccj_f.xccjcomp = g_xccj_f_t.xccjcomp
                     NEXT FIELD CURRENT
                  END IF
               END IF
            
             CALL axct302_s02_ref()
            
 

         AFTER FIELD xccjld
            IF NOT cl_null(g_xccj_f.xccjld) THEN
               
                  IF NOT axct302_s02_chk_ld_comp() THEN
                     LET g_xccj_f.xccjld = g_xccj_f_t.xccjld
                     NEXT FIELD CURRENT
                  END IF
               
            END IF
                      
            
            
          CALL axct302_s02_ref()
 
         ON ACTION controlp INFIELD xccjcomp
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccj_f.xccjcomp             #給予default值
           
            #帳套不為空時，法人組織開窗開帳套歸屬法人的法人組織
            IF NOT cl_null(g_xccj_f.xccjld) THEN
               LET g_qryparam.where = " ooef017 = (SELECT glaacomp FROM glaa_t",
                                      "  WHERE glaaent = '",g_enterprise,"' AND glaald = '",g_xccj_f.xccjld,"' )"
            END IF
            
            #mod--161013-00051#1 By shiun--(S)
#            CALL q_ooef001_8()                           #呼叫開窗
            CALL q_ooef001_2()
            #mod--161013-00051#1 By shiun--(E)

            LET g_xccj_f.xccjcomp = g_qryparam.return1              
 
            CALL axct302_s02_ref()
 
            DISPLAY g_xccj_f.xccjcomp TO xccjcomp 
            DISPLAY g_xccj_f.xccjcomp_desc TO xccjcomp_desc              #
 
            LET g_qryparam.where = "" 
   
            NEXT FIELD xccjcomp                          #返回原欄位

 
         ON ACTION controlp INFIELD xccjld
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccj_f.xccjld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            
            #法人不為空時，帳套開窗開此法人的下屬帳套
            IF NOT cl_null(g_xccj_f.xccjcomp) THEN
               LET g_qryparam.where = " glaacomp = '",g_xccj_f.xccjcomp,"'"
            END IF
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xccj_f.xccjld = g_qryparam.return1              

            CALL axct302_s02_ref()
            
            DISPLAY g_xccj_f.xccjld TO xccjld
            DISPLAY g_xccj_f.xccjld_desc TO xccjld_desc              #

            NEXT FIELD xccjld                          #返回原欄位
 
 
 
         AFTER INPUT
         
            
      END INPUT
    
    
      ON ACTION browser
         CALL cl_client_browse_file() RETURNING g_xccj_f.dir
         LET ls_str = g_xccj_f.dir
         #抓取目录斜杆
         LET l_num =ls_str.getIndexOf(':',1)                                    #抓取：后的字符位置
         LET l_chr = ls_str.substring(l_num+1,l_num+1)                          #截取冒号后的字符 
         LET l_chr1 = ls_str.substring(ls_str.getLength(),ls_str.getLength())   #判断是否为根目录

         LET g_xccj_f.dir = g_xccj_f.dir

         DISPLAY BY NAME g_xccj_f.dir

 
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
   CLOSE WINDOW w_axct302_s02 
   
   CALL axct302_s02_ins_excel(g_xccj_f.dir) RETURNING l_success
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
PRIVATE FUNCTION axct302_s02_ins_excel(p_excelname)
DEFINE p_excelname LIKE type_t.chr1000  #excel档名
DEFINE r_success   LIKE type_t.num5
DEFINE l_excelname STRING               #excel档名
DEFINE l_count     LIKE type_t.num10
DEFINE li_i        LIKE type_t.num10
DEFINE li_j        LIKE type_t.num10
DEFINE xlapp,iRes,iRow    LIKE type_t.num5
#161109-00085#22-s mod
#DEFINE l_xccj      RECORD LIKE xccj_t.*   #161109-00085#22-s mark
DEFINE l_xccj      RECORD  #期初料件明細進出成本開帳檔
       xccjent LIKE xccj_t.xccjent, #企業編號
       xccjcomp LIKE xccj_t.xccjcomp, #法人組織
       xccjld LIKE xccj_t.xccjld, #帳套
       xccj001 LIKE xccj_t.xccj001, #帳套本位幣順序
       xccj002 LIKE xccj_t.xccj002, #成本域
       xccj003 LIKE xccj_t.xccj003, #成本計算類型
       xccj004 LIKE xccj_t.xccj004, #年度
       xccj005 LIKE xccj_t.xccj005, #期別
       xccj006 LIKE xccj_t.xccj006, #參考單號
       xccj007 LIKE xccj_t.xccj007, #項次
       xccj008 LIKE xccj_t.xccj008, #項序
       xccj009 LIKE xccj_t.xccj009, #出入庫碼
       xccj010 LIKE xccj_t.xccj010, #料號
       xccj011 LIKE xccj_t.xccj011, #特性
       xccj012 LIKE xccj_t.xccj012, #單據類型
       xccj013 LIKE xccj_t.xccj013, #單據日期
       xccj014 LIKE xccj_t.xccj014, #時間
       xccj015 LIKE xccj_t.xccj015, #倉庫編號
       xccj016 LIKE xccj_t.xccj016, #儲位編號
       xccj017 LIKE xccj_t.xccj017, #批號
       xccj020 LIKE xccj_t.xccj020, #異動類型
       xccj021 LIKE xccj_t.xccj021, #原因碼
       xccj022 LIKE xccj_t.xccj022, #交易對象
       xccj023 LIKE xccj_t.xccj023, #客群
       xccj024 LIKE xccj_t.xccj024, #區域
       xccj025 LIKE xccj_t.xccj025, #成本中心
       xccj026 LIKE xccj_t.xccj026, #經營類別
       xccj027 LIKE xccj_t.xccj027, #通路
       xccj028 LIKE xccj_t.xccj028, #品類
       xccj029 LIKE xccj_t.xccj029, #品牌
       xccj030 LIKE xccj_t.xccj030, #專案號
       xccj031 LIKE xccj_t.xccj031, #WBS
       xccj032 LIKE xccj_t.xccj032, #存貨科目編號
       xccj033 LIKE xccj_t.xccj033, #費用成本科目
       xccj034 LIKE xccj_t.xccj034, #收入科目編號
       xccj040 LIKE xccj_t.xccj040, #交易幣別
       xccj041 LIKE xccj_t.xccj041, #本位幣別
       xccj042 LIKE xccj_t.xccj042, #匯率
       xccj043 LIKE xccj_t.xccj043, #交易單位
       xccj044 LIKE xccj_t.xccj044, #成本單位
       xccj045 LIKE xccj_t.xccj045, #換算率
       xccj046 LIKE xccj_t.xccj046, #交易數量
       xccj047 LIKE xccj_t.xccj047, #工單號碼
       xccj048 LIKE xccj_t.xccj048, #重複性生產-計畫編號
       xccj049 LIKE xccj_t.xccj049, #重複性生產-生產料號
       xccj050 LIKE xccj_t.xccj050, #重複性生產-生產料號BOM特性
       xccj051 LIKE xccj_t.xccj051, #重複性生產-生產料號產品特徵
       xccj055 LIKE xccj_t.xccj055, #xccc類型
       xccj101 LIKE xccj_t.xccj101, #期末結存數量
       xccj102 LIKE xccj_t.xccj102, #期末結存金額
       xccj102a LIKE xccj_t.xccj102a, #期末結存金額-材料
       xccj102b LIKE xccj_t.xccj102b, #期末結存金額-人工
       xccj102c LIKE xccj_t.xccj102c, #期末結存金額-加工費
       xccj102d LIKE xccj_t.xccj102d, #期末結存金額-制費一
       xccj102e LIKE xccj_t.xccj102e, #期末結存金額-制費二
       xccj102f LIKE xccj_t.xccj102f, #期末結存金額-制費三
       xccj102g LIKE xccj_t.xccj102g, #期末結存金額-制費四
       xccj102h LIKE xccj_t.xccj102h, #期末結存金額-制費五
       xccjud001 LIKE xccj_t.xccjud001, #自定義欄位(文字)001
       xccjud002 LIKE xccj_t.xccjud002, #自定義欄位(文字)002
       xccjud003 LIKE xccj_t.xccjud003, #自定義欄位(文字)003
       xccjud004 LIKE xccj_t.xccjud004, #自定義欄位(文字)004
       xccjud005 LIKE xccj_t.xccjud005, #自定義欄位(文字)005
       xccjud006 LIKE xccj_t.xccjud006, #自定義欄位(文字)006
       xccjud007 LIKE xccj_t.xccjud007, #自定義欄位(文字)007
       xccjud008 LIKE xccj_t.xccjud008, #自定義欄位(文字)008
       xccjud009 LIKE xccj_t.xccjud009, #自定義欄位(文字)009
       xccjud010 LIKE xccj_t.xccjud010, #自定義欄位(文字)010
       xccjud011 LIKE xccj_t.xccjud011, #自定義欄位(數字)011
       xccjud012 LIKE xccj_t.xccjud012, #自定義欄位(數字)012
       xccjud013 LIKE xccj_t.xccjud013, #自定義欄位(數字)013
       xccjud014 LIKE xccj_t.xccjud014, #自定義欄位(數字)014
       xccjud015 LIKE xccj_t.xccjud015, #自定義欄位(數字)015
       xccjud016 LIKE xccj_t.xccjud016, #自定義欄位(數字)016
       xccjud017 LIKE xccj_t.xccjud017, #自定義欄位(數字)017
       xccjud018 LIKE xccj_t.xccjud018, #自定義欄位(數字)018
       xccjud019 LIKE xccj_t.xccjud019, #自定義欄位(數字)019
       xccjud020 LIKE xccj_t.xccjud020, #自定義欄位(數字)020
       xccjud021 LIKE xccj_t.xccjud021, #自定義欄位(日期時間)021
       xccjud022 LIKE xccj_t.xccjud022, #自定義欄位(日期時間)022
       xccjud023 LIKE xccj_t.xccjud023, #自定義欄位(日期時間)023
       xccjud024 LIKE xccj_t.xccjud024, #自定義欄位(日期時間)024
       xccjud025 LIKE xccj_t.xccjud025, #自定義欄位(日期時間)025
       xccjud026 LIKE xccj_t.xccjud026, #自定義欄位(日期時間)026
       xccjud027 LIKE xccj_t.xccjud027, #自定義欄位(日期時間)027
       xccjud028 LIKE xccj_t.xccjud028, #自定義欄位(日期時間)028
       xccjud029 LIKE xccj_t.xccjud029, #自定義欄位(日期時間)029
       xccjud030 LIKE xccj_t.xccjud030  #自定義欄位(日期時間)030
                 END RECORD
#161109-00085#22-e mod
DEFINE l_today     LIKE type_t.dat       #zll g_today 没有了
DEFINE l_n         LIKE type_t.num5

DEFINE l_xccjcrtdt    DATETIME YEAR TO SECOND
#161109-00085#22-s mod
#DEFINE l_xccj1      RECORD LIKE xccj_t.*   #161109-00085#22-s mark
DEFINE l_xccj1      RECORD  #期初料件明細進出成本開帳檔
       xccjent LIKE xccj_t.xccjent, #企業編號
       xccjcomp LIKE xccj_t.xccjcomp, #法人組織
       xccjld LIKE xccj_t.xccjld, #帳套
       xccj001 LIKE xccj_t.xccj001, #帳套本位幣順序
       xccj002 LIKE xccj_t.xccj002, #成本域
       xccj003 LIKE xccj_t.xccj003, #成本計算類型
       xccj004 LIKE xccj_t.xccj004, #年度
       xccj005 LIKE xccj_t.xccj005, #期別
       xccj006 LIKE xccj_t.xccj006, #參考單號
       xccj007 LIKE xccj_t.xccj007, #項次
       xccj008 LIKE xccj_t.xccj008, #項序
       xccj009 LIKE xccj_t.xccj009, #出入庫碼
       xccj010 LIKE xccj_t.xccj010, #料號
       xccj011 LIKE xccj_t.xccj011, #特性
       xccj012 LIKE xccj_t.xccj012, #單據類型
       xccj013 LIKE xccj_t.xccj013, #單據日期
       xccj014 LIKE xccj_t.xccj014, #時間
       xccj015 LIKE xccj_t.xccj015, #倉庫編號
       xccj016 LIKE xccj_t.xccj016, #儲位編號
       xccj017 LIKE xccj_t.xccj017, #批號
       xccj020 LIKE xccj_t.xccj020, #異動類型
       xccj021 LIKE xccj_t.xccj021, #原因碼
       xccj022 LIKE xccj_t.xccj022, #交易對象
       xccj023 LIKE xccj_t.xccj023, #客群
       xccj024 LIKE xccj_t.xccj024, #區域
       xccj025 LIKE xccj_t.xccj025, #成本中心
       xccj026 LIKE xccj_t.xccj026, #經營類別
       xccj027 LIKE xccj_t.xccj027, #通路
       xccj028 LIKE xccj_t.xccj028, #品類
       xccj029 LIKE xccj_t.xccj029, #品牌
       xccj030 LIKE xccj_t.xccj030, #專案號
       xccj031 LIKE xccj_t.xccj031, #WBS
       xccj032 LIKE xccj_t.xccj032, #存貨科目編號
       xccj033 LIKE xccj_t.xccj033, #費用成本科目
       xccj034 LIKE xccj_t.xccj034, #收入科目編號
       xccj040 LIKE xccj_t.xccj040, #交易幣別
       xccj041 LIKE xccj_t.xccj041, #本位幣別
       xccj042 LIKE xccj_t.xccj042, #匯率
       xccj043 LIKE xccj_t.xccj043, #交易單位
       xccj044 LIKE xccj_t.xccj044, #成本單位
       xccj045 LIKE xccj_t.xccj045, #換算率
       xccj046 LIKE xccj_t.xccj046, #交易數量
       xccj047 LIKE xccj_t.xccj047, #工單號碼
       xccj048 LIKE xccj_t.xccj048, #重複性生產-計畫編號
       xccj049 LIKE xccj_t.xccj049, #重複性生產-生產料號
       xccj050 LIKE xccj_t.xccj050, #重複性生產-生產料號BOM特性
       xccj051 LIKE xccj_t.xccj051, #重複性生產-生產料號產品特徵
       xccj055 LIKE xccj_t.xccj055, #xccc類型
       xccj101 LIKE xccj_t.xccj101, #期末結存數量
       xccj102 LIKE xccj_t.xccj102, #期末結存金額
       xccj102a LIKE xccj_t.xccj102a, #期末結存金額-材料
       xccj102b LIKE xccj_t.xccj102b, #期末結存金額-人工
       xccj102c LIKE xccj_t.xccj102c, #期末結存金額-加工費
       xccj102d LIKE xccj_t.xccj102d, #期末結存金額-制費一
       xccj102e LIKE xccj_t.xccj102e, #期末結存金額-制費二
       xccj102f LIKE xccj_t.xccj102f, #期末結存金額-制費三
       xccj102g LIKE xccj_t.xccj102g, #期末結存金額-制費四
       xccj102h LIKE xccj_t.xccj102h  #期末結存金額-制費五
          END RECORD
#161109-00085#22-e mod
#161109-00085#22-s mod
#DEFINE l_xccj2      RECORD LIKE xccj_t.*   #161109-00085#22-s mark
DEFINE l_xccj2      RECORD  #期初料件明細進出成本開帳檔
       xccjent LIKE xccj_t.xccjent, #企業編號
       xccjcomp LIKE xccj_t.xccjcomp, #法人組織
       xccjld LIKE xccj_t.xccjld, #帳套
       xccj001 LIKE xccj_t.xccj001, #帳套本位幣順序
       xccj002 LIKE xccj_t.xccj002, #成本域
       xccj003 LIKE xccj_t.xccj003, #成本計算類型
       xccj004 LIKE xccj_t.xccj004, #年度
       xccj005 LIKE xccj_t.xccj005, #期別
       xccj006 LIKE xccj_t.xccj006, #參考單號
       xccj007 LIKE xccj_t.xccj007, #項次
       xccj008 LIKE xccj_t.xccj008, #項序
       xccj009 LIKE xccj_t.xccj009, #出入庫碼
       xccj010 LIKE xccj_t.xccj010, #料號
       xccj011 LIKE xccj_t.xccj011, #特性
       xccj012 LIKE xccj_t.xccj012, #單據類型
       xccj013 LIKE xccj_t.xccj013, #單據日期
       xccj014 LIKE xccj_t.xccj014, #時間
       xccj015 LIKE xccj_t.xccj015, #倉庫編號
       xccj016 LIKE xccj_t.xccj016, #儲位編號
       xccj017 LIKE xccj_t.xccj017, #批號
       xccj020 LIKE xccj_t.xccj020, #異動類型
       xccj021 LIKE xccj_t.xccj021, #原因碼
       xccj022 LIKE xccj_t.xccj022, #交易對象
       xccj023 LIKE xccj_t.xccj023, #客群
       xccj024 LIKE xccj_t.xccj024, #區域
       xccj025 LIKE xccj_t.xccj025, #成本中心
       xccj026 LIKE xccj_t.xccj026, #經營類別
       xccj027 LIKE xccj_t.xccj027, #通路
       xccj028 LIKE xccj_t.xccj028, #品類
       xccj029 LIKE xccj_t.xccj029, #品牌
       xccj030 LIKE xccj_t.xccj030, #專案號
       xccj031 LIKE xccj_t.xccj031, #WBS
       xccj032 LIKE xccj_t.xccj032, #存貨科目編號
       xccj033 LIKE xccj_t.xccj033, #費用成本科目
       xccj034 LIKE xccj_t.xccj034, #收入科目編號
       xccj040 LIKE xccj_t.xccj040, #交易幣別
       xccj041 LIKE xccj_t.xccj041, #本位幣別
       xccj042 LIKE xccj_t.xccj042, #匯率
       xccj043 LIKE xccj_t.xccj043, #交易單位
       xccj044 LIKE xccj_t.xccj044, #成本單位
       xccj045 LIKE xccj_t.xccj045, #換算率
       xccj046 LIKE xccj_t.xccj046, #交易數量
       xccj047 LIKE xccj_t.xccj047, #工單號碼
       xccj048 LIKE xccj_t.xccj048, #重複性生產-計畫編號
       xccj049 LIKE xccj_t.xccj049, #重複性生產-生產料號
       xccj050 LIKE xccj_t.xccj050, #重複性生產-生產料號BOM特性
       xccj051 LIKE xccj_t.xccj051, #重複性生產-生產料號產品特徵
       xccj055 LIKE xccj_t.xccj055, #xccc類型
       xccj101 LIKE xccj_t.xccj101, #期末結存數量
       xccj102 LIKE xccj_t.xccj102, #期末結存金額
       xccj102a LIKE xccj_t.xccj102a, #期末結存金額-材料
       xccj102b LIKE xccj_t.xccj102b, #期末結存金額-人工
       xccj102c LIKE xccj_t.xccj102c, #期末結存金額-加工費
       xccj102d LIKE xccj_t.xccj102d, #期末結存金額-制費一
       xccj102e LIKE xccj_t.xccj102e, #期末結存金額-制費二
       xccj102f LIKE xccj_t.xccj102f, #期末結存金額-制費三
       xccj102g LIKE xccj_t.xccj102g, #期末結存金額-制費四
       xccj102h LIKE xccj_t.xccj102h  #期末結存金額-制費五
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
                INITIALIZE l_xccj.* TO NULL
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',1).Value'],[l_xccj.xccjent])   
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',2).Value'],[l_xccj.xccjld])    
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',3).Value'],[l_xccj.xccjcomp]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',4).Value'],[l_xccj.xccj001])   
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',5).Value'],[l_xccj.xccj004])   
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',6).Value'],[l_xccj.xccj005])   
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',7).Value'],[l_xccj.xccj003])   
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',8).Value'],[l_xccj.xccj006])   
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',9).Value'],[l_xccj.xccj007])   
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',10).Value'],[l_xccj.xccj008])   
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',11).Value'],[l_xccj.xccj013])   
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',12).Value'],[l_xccj.xccj009])                 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',13).Value'],[l_xccj.xccj010])                  
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',14).Value'],[l_xccj.xccj011])                  
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',15).Value'],[l_xccj.xccj015])                   
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',16).Value'],[l_xccj.xccj016])                   
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',17).Value'],[l_xccj.xccj017])   
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',18).Value'],[l_xccj.xccj012])   
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',19).Value'],[l_xccj.xccj020])   
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',20).Value'],[l_xccj.xccj002])   
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',21).Value'],[l_xccj.xccj101])   
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',22).Value'],[l_xccj.xccj102])                 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',23).Value'],[l_xccj.xccj102a])                 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',24).Value'],[l_xccj.xccj102b])                 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',25).Value'],[l_xccj.xccj102c])                  
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',26).Value'],[l_xccj.xccj102d])  
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',27).Value'],[l_xccj.xccj102e])  
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',28).Value'],[l_xccj.xccj102f])  
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',29).Value'],[l_xccj.xccj102g])  
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',30).Value'],[l_xccj.xccj102h])  
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',31).Value'],[l_xccj1.xccj102])  
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',32).Value'],[l_xccj1.xccj102a]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',33).Value'],[l_xccj1.xccj102b]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',34).Value'],[l_xccj1.xccj102c]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',35).Value'],[l_xccj1.xccj102d]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',36).Value'],[l_xccj1.xccj102e]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',37).Value'],[l_xccj1.xccj102f]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',38).Value'],[l_xccj1.xccj102g]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',39).Value'],[l_xccj1.xccj102h]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',40).Value'],[l_xccj2.xccj102])  
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',41).Value'],[l_xccj2.xccj102a]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',42).Value'],[l_xccj2.xccj102b]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',43).Value'],[l_xccj2.xccj102c]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',44).Value'],[l_xccj2.xccj102d]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',45).Value'],[l_xccj2.xccj102e]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',46).Value'],[l_xccj2.xccj102f]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',47).Value'],[l_xccj2.xccj102g]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',48).Value'],[l_xccj2.xccj102h]) 
                
                               
                
                #如果excel中存在不在畫面上的法人或者帳套CONTINUE
                IF l_xccj.xccjld != g_xccj_f.xccjld OR l_xccj.xccjcomp != g_xccj_f.xccjcomp THEN
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
                LET l_xccj.xccj001 = '1'  #本位幣               
                
                

                IF l_xccj.xccj008 IS NULL THEN  #key值批号可录入为空
                   LET l_xccj.xccj008 = ' '
                END IF
                IF l_xccj.xccj007 IS NULL THEN  #key值特性可录入为空
                   LET l_xccj.xccj007 = ' '
                END IF                
                #本位幣一 
                #161109-00085#22-s mod               
#                INSERT INTO xccj_t VALUES l_xccj.*   #161109-00085#22-s mark
                INSERT INTO xccj_t (xccjent,xccjcomp,xccjld,xccj001,xccj002,xccj003,xccj004,xccj005,xccj006,xccj007,
                                    xccj008,xccj009,xccj010,xccj011,xccj012,xccj013,xccj014,xccj015,xccj016,xccj017,
                                    xccj020,xccj021,xccj022,xccj023,xccj024,xccj025,xccj026,xccj027,xccj028,xccj029,
                                    xccj030,xccj031,xccj032,xccj033,xccj034,xccj040,xccj041,xccj042,xccj043,xccj044,
                                    xccj045,xccj046,xccj047,xccj048,xccj049,xccj050,xccj051,xccj055,xccj101,xccj102,
                                    xccj102a,xccj102b,xccj102c,xccj102d,xccj102e,xccj102f,xccj102g,xccj102h,xccjud001,xccjud002,
                                    xccjud003,xccjud004,xccjud005,xccjud006,xccjud007,xccjud008,xccjud009,xccjud010,xccjud011,xccjud012,
                                    xccjud013,xccjud014,xccjud015,xccjud016,xccjud017,xccjud018,xccjud019,xccjud020,xccjud021,xccjud022,
                                    xccjud023,xccjud024,xccjud025,xccjud026,xccjud027,xccjud028,xccjud029,xccjud030)
                            VALUES (l_xccj.xccjent,l_xccj.xccjcomp,l_xccj.xccjld,l_xccj.xccj001,l_xccj.xccj002,
                                    l_xccj.xccj003,l_xccj.xccj004,l_xccj.xccj005,l_xccj.xccj006,l_xccj.xccj007,
                                    l_xccj.xccj008,l_xccj.xccj009,l_xccj.xccj010,l_xccj.xccj011,l_xccj.xccj012,
                                    l_xccj.xccj013,l_xccj.xccj014,l_xccj.xccj015,l_xccj.xccj016,l_xccj.xccj017,
                                    l_xccj.xccj020,l_xccj.xccj021,l_xccj.xccj022,l_xccj.xccj023,l_xccj.xccj024,
                                    l_xccj.xccj025,l_xccj.xccj026,l_xccj.xccj027,l_xccj.xccj028,l_xccj.xccj029,
                                    l_xccj.xccj030,l_xccj.xccj031,l_xccj.xccj032,l_xccj.xccj033,l_xccj.xccj034,
                                    l_xccj.xccj040,l_xccj.xccj041,l_xccj.xccj042,l_xccj.xccj043,l_xccj.xccj044,
                                    l_xccj.xccj045,l_xccj.xccj046,l_xccj.xccj047,l_xccj.xccj048,l_xccj.xccj049,
                                    l_xccj.xccj050,l_xccj.xccj051,l_xccj.xccj055,l_xccj.xccj101,l_xccj.xccj102,
                                    l_xccj.xccj102a,l_xccj.xccj102b,l_xccj.xccj102c,l_xccj.xccj102d,l_xccj.xccj102e,
                                    l_xccj.xccj102f,l_xccj.xccj102g,l_xccj.xccj102h,l_xccj.xccjud001,l_xccj.xccjud002,
                                    l_xccj.xccjud003,l_xccj.xccjud004,l_xccj.xccjud005,l_xccj.xccjud006,l_xccj.xccjud007,
                                    l_xccj.xccjud008,l_xccj.xccjud009,l_xccj.xccjud010,l_xccj.xccjud011,l_xccj.xccjud012,
                                    l_xccj.xccjud013,l_xccj.xccjud014,l_xccj.xccjud015,l_xccj.xccjud016,l_xccj.xccjud017,
                                    l_xccj.xccjud018,l_xccj.xccjud019,l_xccj.xccjud020,l_xccj.xccjud021,l_xccj.xccjud022,
                                    l_xccj.xccjud023,l_xccj.xccjud024,l_xccj.xccjud025,l_xccj.xccjud026,l_xccj.xccjud027,
                                    l_xccj.xccjud028,l_xccj.xccjud029,l_xccj.xccjud030)
                #161109-00085#22-e mod
                IF SQLCA.sqlcode THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = SQLCA.sqlcode
                   LET g_errparam.extend = 'ins xccj'
                   LET g_errparam.popup = FALSE
                   CALL cl_err()

                   LET r_success = FALSE
                   EXIT FOR
                END IF

                SELECT glaa015,glaa019
                  INTO g_glaa015,g_glaa019
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = l_xccj.xccjld
                #本位幣二
                IF g_glaa015 = 'Y' THEN                   
                   IF cl_null(l_xccj1.xccj102)  THEN LET l_xccj1.xccj102  = 0 END IF 
                   IF cl_null(l_xccj1.xccj102a) THEN LET l_xccj1.xccj102a = 0 END IF 
                   IF cl_null(l_xccj1.xccj102b) THEN LET l_xccj1.xccj102b = 0 END IF 
                   IF cl_null(l_xccj1.xccj102c) THEN LET l_xccj1.xccj102c = 0 END IF 
                   IF cl_null(l_xccj1.xccj102d) THEN LET l_xccj1.xccj102d = 0 END IF 
                   IF cl_null(l_xccj1.xccj102e) THEN LET l_xccj1.xccj102e = 0 END IF 
                   IF cl_null(l_xccj1.xccj102f) THEN LET l_xccj1.xccj102f = 0 END IF 
                   IF cl_null(l_xccj1.xccj102g) THEN LET l_xccj1.xccj102g = 0 END IF 
                   IF cl_null(l_xccj1.xccj102h) THEN LET l_xccj1.xccj102h = 0 END IF 
                  
                   INSERT INTO xccj_t(xccjent,xccjld,xccjcomp,xccj001,xccj004,xccj005,xccj003,xccj006,xccj007,
                                      xccj008,xccj013,xccj009,xccj010,xccj011,xccj015,xccj016,xccj017,xccj012, 
                                      xccj020,xccj002,xccj101,xccj102,xccj102a,xccj102b,xccj102c,xccj102d,xccj102e,
                                      xccj102f,xccj102g,xccj102h) 
                               VALUES(l_xccj.xccjent,l_xccj.xccjld,l_xccj.xccjcomp,'2',l_xccj.xccj004,l_xccj.xccj005,l_xccj.xccj003,l_xccj.xccj006,l_xccj.xccj007,
                                      l_xccj.xccj008,l_xccj.xccj013,l_xccj.xccj009,l_xccj.xccj010,l_xccj.xccj011,l_xccj.xccj015,l_xccj.xccj016,l_xccj.xccj017,l_xccj.xccj012, 
                                      l_xccj.xccj020,l_xccj.xccj002,l_xccj.xccj101,l_xccj1.xccj102,l_xccj1.xccj102a,l_xccj1.xccj102b,l_xccj1.xccj102c,l_xccj1.xccj102d,
                                      l_xccj1.xccj102e,l_xccj1.xccj102f,l_xccj1.xccj102g,l_xccj1.xccj102h) 
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'ins xccj 2'
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     LET r_success = FALSE
                     EXIT FOR
                  END IF                                      
                END IF
                #本位幣三
                IF g_glaa019 = 'Y' THEN 
                                  
                   IF cl_null(l_xccj2.xccj102)  THEN LET l_xccj2.xccj102  = 0 END IF 
                   IF cl_null(l_xccj2.xccj102a) THEN LET l_xccj2.xccj102a = 0 END IF 
                   IF cl_null(l_xccj2.xccj102b) THEN LET l_xccj2.xccj102b = 0 END IF 
                   IF cl_null(l_xccj2.xccj102c) THEN LET l_xccj2.xccj102c = 0 END IF 
                   IF cl_null(l_xccj2.xccj102d) THEN LET l_xccj2.xccj102d = 0 END IF 
                   IF cl_null(l_xccj2.xccj102e) THEN LET l_xccj2.xccj102e = 0 END IF 
                   IF cl_null(l_xccj2.xccj102f) THEN LET l_xccj2.xccj102f = 0 END IF 
                   IF cl_null(l_xccj2.xccj102g) THEN LET l_xccj2.xccj102g = 0 END IF 
                   IF cl_null(l_xccj2.xccj102h) THEN LET l_xccj2.xccj102h = 0 END IF 
                  
                   INSERT INTO xccj_t(xccjent,xccjld,xccjcomp,xccj001,xccj004,xccj005,xccj003,xccj006,xccj007,
                                      xccj008,xccj013,xccj009,xccj010,xccj011,xccj015,xccj016,xccj017,xccj012, 
                                      xccj020,xccj002,xccj101,xccj102,xccj102a,xccj102b,xccj102c,xccj102d,xccj102e,
                                      xccj102f,xccj102g,xccj102h) 
                               VALUES(l_xccj.xccjent,l_xccj.xccjld,l_xccj.xccjcomp,'3',l_xccj.xccj004,l_xccj.xccj005,l_xccj.xccj003,l_xccj.xccj006,l_xccj.xccj007,
                                      l_xccj.xccj008,l_xccj.xccj013,l_xccj.xccj009,l_xccj.xccj010,l_xccj.xccj011,l_xccj.xccj015,l_xccj.xccj016,l_xccj.xccj017,l_xccj.xccj012, 
                                      l_xccj.xccj020,l_xccj.xccj002,l_xccj.xccj101,l_xccj2.xccj102,l_xccj2.xccj102a,l_xccj2.xccj102b,l_xccj2.xccj102c,l_xccj2.xccj102d,
                                      l_xccj2.xccj102e,l_xccj2.xccj102f,l_xccj2.xccj102g,l_xccj2.xccj102h) 
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'ins xccj 3'
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
PRIVATE FUNCTION axct302_add_span(p_str)
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
PRIVATE FUNCTION axct302_get_boday(p_h,p_cnt_header,s,s_combo_arr,p_seq)
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
   LET window_path = g_xccj_s.dir,"\\",xls_name CLIPPED
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
PRIVATE FUNCTION axct302_s02_ref()
   IF g_xccj_f.xccjcomp IS NULL THEN     
      SELECT glaacomp
        INTO g_xccj_f.xccjcomp
        FROM glaa_t  
       WHERE glaaent = g_enterprise 
         AND glaald = g_xccj_f.xccjld
      DISPLAY BY NAME g_xccj_f.xccjcomp   
   ELSE
      IF g_xccj_f.xccjld IS NULL THEN
          SELECT glaald INTO g_xccj_f.xccjld
          FROM glaa_t
          WHERE glaaent  = g_enterprise
            AND glaacomp = g_xccj_f.xccjcomp
            AND glaa014 = 'Y'
         DISPLAY BY NAME g_xccj_f.xccjld
      END IF
   END IF
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xccj_f.xccjcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccj_f.xccjcomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccj_f.xccjcomp_desc   
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xccj_f.xccjld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccj_f.xccjld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccj_f.xccjld_desc   
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
PRIVATE FUNCTION axct302_s02_chk_ld_comp()
DEFINE r_success        LIKE type_t.num5
   DEFINE l_success        LIKE type_t.num5
   
   LET r_success = TRUE

#只检查法人
   IF g_xccj_f.xccjld IS NULL AND g_xccj_f.xccjcomp IS NOT NULL THEN   
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
      
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_xccj_f.xccjcomp
         
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
   IF g_xccj_f.xccjld IS NOT NULL AND g_xccj_f.xccjcomp IS NULL THEN
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
      
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_xccj_f.xccjld
      #160318-00025#11--add--str
      LET g_errshow = TRUE 
      LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
      #160318-00025#11--add--end   
      #呼叫檢查存在並帶值的library
      IF cl_chk_exist("v_glaald") THEN
         #檢查成功時後續處理
         #LET  = g_chkparam.return1
         #DISPLAY BY NAME 
         CALL s_ld_chk_authorization(g_user,g_xccj_f.xccjld) RETURNING l_success
         IF l_success = FALSE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'axr-00022'
            LET g_errparam.extend = g_xccj_f.xccjld
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
   IF NOT s_ld_chk_comp(g_xccj_f.xccjld,g_xccj_f.xccjcomp) THEN  #v_glaald_5 
      LET g_xccj_f.xccjcomp = g_xccj_f_t.xccjcomp
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
PRIVATE FUNCTION axct302_generate_xcdj()
#161109-00085#22-s mod
#DEFINE l_xcdj          RECORD LIKE xcdj_t.*   #161109-00085#22-s mark
DEFINE l_xcdj          RECORD  #期初料件明細進出成本要素成本開帳檔
       xcdjent LIKE xcdj_t.xcdjent, #企業編號
       xcdjcomp LIKE xcdj_t.xcdjcomp, #法人組織
       xcdjld LIKE xcdj_t.xcdjld, #帳套
       xcdj001 LIKE xcdj_t.xcdj001, #帳套本位幣順序
       xcdj002 LIKE xcdj_t.xcdj002, #成本域
       xcdj003 LIKE xcdj_t.xcdj003, #成本計算類型
       xcdj004 LIKE xcdj_t.xcdj004, #年度
       xcdj005 LIKE xcdj_t.xcdj005, #期別
       xcdj006 LIKE xcdj_t.xcdj006, #參考單號
       xcdj007 LIKE xcdj_t.xcdj007, #項次
       xcdj008 LIKE xcdj_t.xcdj008, #項序
       xcdj009 LIKE xcdj_t.xcdj009, #出入庫碼
       xcdj010 LIKE xcdj_t.xcdj010, #成本要素
       xcdj011 LIKE xcdj_t.xcdj011, #料號
       xcdj012 LIKE xcdj_t.xcdj012, #特性
       xcdj013 LIKE xcdj_t.xcdj013, #單據類型
       xcdj014 LIKE xcdj_t.xcdj014, #單據日期
       xcdj015 LIKE xcdj_t.xcdj015, #時間
       xcdj016 LIKE xcdj_t.xcdj016, #倉庫編號
       xcdj017 LIKE xcdj_t.xcdj017, #儲位編號
       xcdj018 LIKE xcdj_t.xcdj018, #批號
       xcdj020 LIKE xcdj_t.xcdj020, #異動類型
       xcdj021 LIKE xcdj_t.xcdj021, #原因碼
       xcdj022 LIKE xcdj_t.xcdj022, #交易對象
       xcdj023 LIKE xcdj_t.xcdj023, #客群
       xcdj024 LIKE xcdj_t.xcdj024, #區域
       xcdj025 LIKE xcdj_t.xcdj025, #成本中心
       xcdj026 LIKE xcdj_t.xcdj026, #經營類別
       xcdj027 LIKE xcdj_t.xcdj027, #通路
       xcdj028 LIKE xcdj_t.xcdj028, #品類
       xcdj029 LIKE xcdj_t.xcdj029, #品牌
       xcdj030 LIKE xcdj_t.xcdj030, #專案號
       xcdj031 LIKE xcdj_t.xcdj031, #WBS
       xcdj032 LIKE xcdj_t.xcdj032, #存貨科目
       xcdj033 LIKE xcdj_t.xcdj033, #費用成本科目
       xcdj034 LIKE xcdj_t.xcdj034, #收入科目
       xcdj040 LIKE xcdj_t.xcdj040, #交易幣別
       xcdj041 LIKE xcdj_t.xcdj041, #本位幣別
       xcdj042 LIKE xcdj_t.xcdj042, #匯率
       xcdj043 LIKE xcdj_t.xcdj043, #交易單位
       xcdj044 LIKE xcdj_t.xcdj044, #成本單位
       xcdj045 LIKE xcdj_t.xcdj045, #換算率
       xcdj046 LIKE xcdj_t.xcdj046, #交易數量
       xcdj047 LIKE xcdj_t.xcdj047, #工單號碼
       xcdj048 LIKE xcdj_t.xcdj048, #重複性生產-計畫編號
       xcdj049 LIKE xcdj_t.xcdj049, #重複性生產-生產料號
       xcdj050 LIKE xcdj_t.xcdj050, #重複性生產-生產料號BOM特性
       xcdj051 LIKE xcdj_t.xcdj051, #重複性生產-生產料號產品特徵
       xcdj055 LIKE xcdj_t.xcdj055, #xccc類型
       xcdj101 LIKE xcdj_t.xcdj101, #期末結存數量
       xcdj102 LIKE xcdj_t.xcdj102  #期末結存金額
          END RECORD
#161109-00085#22-e mod
#161109-00085#22-s mod
#DEFINE l_xccj      RECORD LIKE xccj_t.*   #161109-00085#22-s mark
DEFINE l_xccj      RECORD  #期初料件明細進出成本開帳檔
       xccjent LIKE xccj_t.xccjent, #企業編號
       xccjcomp LIKE xccj_t.xccjcomp, #法人組織
       xccjld LIKE xccj_t.xccjld, #帳套
       xccj001 LIKE xccj_t.xccj001, #帳套本位幣順序
       xccj002 LIKE xccj_t.xccj002, #成本域
       xccj003 LIKE xccj_t.xccj003, #成本計算類型
       xccj004 LIKE xccj_t.xccj004, #年度
       xccj005 LIKE xccj_t.xccj005, #期別
       xccj006 LIKE xccj_t.xccj006, #參考單號
       xccj007 LIKE xccj_t.xccj007, #項次
       xccj008 LIKE xccj_t.xccj008, #項序
       xccj009 LIKE xccj_t.xccj009, #出入庫碼
       xccj010 LIKE xccj_t.xccj010, #料號
       xccj011 LIKE xccj_t.xccj011, #特性
       xccj012 LIKE xccj_t.xccj012, #單據類型
       xccj013 LIKE xccj_t.xccj013, #單據日期
       xccj014 LIKE xccj_t.xccj014, #時間
       xccj015 LIKE xccj_t.xccj015, #倉庫編號
       xccj016 LIKE xccj_t.xccj016, #儲位編號
       xccj017 LIKE xccj_t.xccj017, #批號
       xccj020 LIKE xccj_t.xccj020, #異動類型
       xccj021 LIKE xccj_t.xccj021, #原因碼
       xccj022 LIKE xccj_t.xccj022, #交易對象
       xccj023 LIKE xccj_t.xccj023, #客群
       xccj024 LIKE xccj_t.xccj024, #區域
       xccj025 LIKE xccj_t.xccj025, #成本中心
       xccj026 LIKE xccj_t.xccj026, #經營類別
       xccj027 LIKE xccj_t.xccj027, #通路
       xccj028 LIKE xccj_t.xccj028, #品類
       xccj029 LIKE xccj_t.xccj029, #品牌
       xccj030 LIKE xccj_t.xccj030, #專案號
       xccj031 LIKE xccj_t.xccj031, #WBS
       xccj032 LIKE xccj_t.xccj032, #存貨科目編號
       xccj033 LIKE xccj_t.xccj033, #費用成本科目
       xccj034 LIKE xccj_t.xccj034, #收入科目編號
       xccj040 LIKE xccj_t.xccj040, #交易幣別
       xccj041 LIKE xccj_t.xccj041, #本位幣別
       xccj042 LIKE xccj_t.xccj042, #匯率
       xccj043 LIKE xccj_t.xccj043, #交易單位
       xccj044 LIKE xccj_t.xccj044, #成本單位
       xccj045 LIKE xccj_t.xccj045, #換算率
       xccj046 LIKE xccj_t.xccj046, #交易數量
       xccj047 LIKE xccj_t.xccj047, #工單號碼
       xccj048 LIKE xccj_t.xccj048, #重複性生產-計畫編號
       xccj049 LIKE xccj_t.xccj049, #重複性生產-生產料號
       xccj050 LIKE xccj_t.xccj050, #重複性生產-生產料號BOM特性
       xccj051 LIKE xccj_t.xccj051, #重複性生產-生產料號產品特徵
       xccj055 LIKE xccj_t.xccj055, #xccc類型
       xccj101 LIKE xccj_t.xccj101, #期末結存數量
       xccj102 LIKE xccj_t.xccj102, #期末結存金額
       xccj102a LIKE xccj_t.xccj102a, #期末結存金額-材料
       xccj102b LIKE xccj_t.xccj102b, #期末結存金額-人工
       xccj102c LIKE xccj_t.xccj102c, #期末結存金額-加工費
       xccj102d LIKE xccj_t.xccj102d, #期末結存金額-制費一
       xccj102e LIKE xccj_t.xccj102e, #期末結存金額-制費二
       xccj102f LIKE xccj_t.xccj102f, #期末結存金額-制費三
       xccj102g LIKE xccj_t.xccj102g, #期末結存金額-制費四
       xccj102h LIKE xccj_t.xccj102h, #期末結存金額-制費五
       xccjud001 LIKE xccj_t.xccjud001, #自定義欄位(文字)001
       xccjud002 LIKE xccj_t.xccjud002, #自定義欄位(文字)002
       xccjud003 LIKE xccj_t.xccjud003, #自定義欄位(文字)003
       xccjud004 LIKE xccj_t.xccjud004, #自定義欄位(文字)004
       xccjud005 LIKE xccj_t.xccjud005, #自定義欄位(文字)005
       xccjud006 LIKE xccj_t.xccjud006, #自定義欄位(文字)006
       xccjud007 LIKE xccj_t.xccjud007, #自定義欄位(文字)007
       xccjud008 LIKE xccj_t.xccjud008, #自定義欄位(文字)008
       xccjud009 LIKE xccj_t.xccjud009, #自定義欄位(文字)009
       xccjud010 LIKE xccj_t.xccjud010, #自定義欄位(文字)010
       xccjud011 LIKE xccj_t.xccjud011, #自定義欄位(數字)011
       xccjud012 LIKE xccj_t.xccjud012, #自定義欄位(數字)012
       xccjud013 LIKE xccj_t.xccjud013, #自定義欄位(數字)013
       xccjud014 LIKE xccj_t.xccjud014, #自定義欄位(數字)014
       xccjud015 LIKE xccj_t.xccjud015, #自定義欄位(數字)015
       xccjud016 LIKE xccj_t.xccjud016, #自定義欄位(數字)016
       xccjud017 LIKE xccj_t.xccjud017, #自定義欄位(數字)017
       xccjud018 LIKE xccj_t.xccjud018, #自定義欄位(數字)018
       xccjud019 LIKE xccj_t.xccjud019, #自定義欄位(數字)019
       xccjud020 LIKE xccj_t.xccjud020, #自定義欄位(數字)020
       xccjud021 LIKE xccj_t.xccjud021, #自定義欄位(日期時間)021
       xccjud022 LIKE xccj_t.xccjud022, #自定義欄位(日期時間)022
       xccjud023 LIKE xccj_t.xccjud023, #自定義欄位(日期時間)023
       xccjud024 LIKE xccj_t.xccjud024, #自定義欄位(日期時間)024
       xccjud025 LIKE xccj_t.xccjud025, #自定義欄位(日期時間)025
       xccjud026 LIKE xccj_t.xccjud026, #自定義欄位(日期時間)026
       xccjud027 LIKE xccj_t.xccjud027, #自定義欄位(日期時間)027
       xccjud028 LIKE xccj_t.xccjud028, #自定義欄位(日期時間)028
       xccjud029 LIKE xccj_t.xccjud029, #自定義欄位(日期時間)029
       xccjud030 LIKE xccj_t.xccjud030  #自定義欄位(日期時間)030
                 END RECORD
#161109-00085#22-e mod
DEFINE l_sql           STRING
DEFINE l_success       LIKE type_t.chr1
DEFINE l_xcdj_count    LIKE type_t.num5
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
  LET l_sql = "SELECT COUNT(*) FROM xcdj_t ",
              " WHERE xcdjent = ? AND xcdjcomp = ? AND xcdjld = ?",
              "   AND xcdj003 = ? AND xcdj004 = ? AND xcdj005 = ? "              
  DECLARE axct302_xcdj_count_cs1 CURSOR FROM l_sql 
  OPEN axct302_xcdj_count_cs1 USING g_enterprise,g_xccj_m.xccjcomp,g_xccj_m.xccjld,
                                   g_xccj_m.xccj003,g_xccj_m.xccj004,g_xccj_m.xccj005
                                   
  FETCH axct302_xcdj_count_cs1 INTO l_xcdj_count
  IF l_xcdj_count > 0 THEN
     IF cl_ask_confirm('axc-00388') THEN   
        LET l_sql = "DELETE FROM xcdj_t ",
                    " WHERE xcdjent = '",g_enterprise,"'  AND xcdjcomp = '",g_xccj_m.xccjcomp,"'",
                    "   AND xcdjld = '",g_xccj_m.xccjld,"' AND xcdj003 = '",g_xccj_m.xccj003,"'",
                    "   AND xcdj004 = '",g_xccj_m.xccj004,"' AND xcdj005 = '",g_xccj_m.xccj005,"'"                   
                     
        PREPARE axct302_del_xcdj FROM l_sql
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code   = SQLCA.sqlcode
           LET g_errparam.extend = "PREPARE delete xcdj_t"
           LET g_errparam.popup  = TRUE
           CALL cl_err()
           RETURN 
        END IF
        EXECUTE axct302_del_xcdj 
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code   = SQLCA.sqlcode
           LET g_errparam.extend = "EXECUTE delete xcdj_t"
           LET g_errparam.popup  = TRUE
           CALL cl_err()
           RETURN 
        END IF 
     ELSE 
        RETURN         
     END IF  
  END IF
    
  
  #生成axct306资料 
  #161109-00085#22-s mod
#  LET l_sql = "SELECT * ",   #161109-00085#22-s mark
  LET l_sql = "SELECT xccjent,xccjcomp,xccjld,xccj001,xccj002,xccj003,xccj004,xccj005,xccj006,xccj007,
                      xccj008,xccj009,xccj010,xccj011,xccj012,xccj013,xccj014,xccj015,xccj016,xccj017,
                      xccj020,xccj021,xccj022,xccj023,xccj024,xccj025,xccj026,xccj027,xccj028,xccj029,
                      xccj030,xccj031,xccj032,xccj033,xccj034,xccj040,xccj041,xccj042,xccj043,xccj044,
                      xccj045,xccj046,xccj047,xccj048,xccj049,xccj050,xccj051,xccj055,xccj101,xccj102,
                      xccj102a,xccj102b,xccj102c,xccj102d,xccj102e,xccj102f,xccj102g,xccj102h,xccjud001,xccjud002,
                      xccjud003,xccjud004,xccjud005,xccjud006,xccjud007,xccjud008,xccjud009,xccjud010,xccjud011,xccjud012,
                      xccjud013,xccjud014,xccjud015,xccjud016,xccjud017,xccjud018,xccjud019,xccjud020,xccjud021,xccjud022,
                      xccjud023,xccjud024,xccjud025,xccjud026,xccjud027,xccjud028,xccjud029,xccjud030 ",
  #161109-00085#22-e mod
              "  FROM xccj_t WHERE xccjent = ? AND xccjcomp = ? AND xccjld = ?",
                            "  AND xccj003 = ? AND xccj004 = ? AND xccj005 = ? ",              
              "  ORDER BY xccj001"
  DECLARE axct302_xcdj_cs CURSOR FROM l_sql 
  
  FOREACH axct302_xcdj_cs USING g_enterprise,g_xccj_m.xccjcomp,g_xccj_m.xccjld,
                                g_xccj_m.xccj003,g_xccj_m.xccj004,g_xccj_m.xccj005
                          #161109-00085#22-s mod
#                          INTO l_xccj.*   #161109-00085#22-s mark
                          INTO l_xccj.xccjent,l_xccj.xccjcomp,l_xccj.xccjld,l_xccj.xccj001,l_xccj.xccj002,
                               l_xccj.xccj003,l_xccj.xccj004,l_xccj.xccj005,l_xccj.xccj006,l_xccj.xccj007,
                               l_xccj.xccj008,l_xccj.xccj009,l_xccj.xccj010,l_xccj.xccj011,l_xccj.xccj012,
                               l_xccj.xccj013,l_xccj.xccj014,l_xccj.xccj015,l_xccj.xccj016,l_xccj.xccj017,
                               l_xccj.xccj020,l_xccj.xccj021,l_xccj.xccj022,l_xccj.xccj023,l_xccj.xccj024,
                               l_xccj.xccj025,l_xccj.xccj026,l_xccj.xccj027,l_xccj.xccj028,l_xccj.xccj029,
                               l_xccj.xccj030,l_xccj.xccj031,l_xccj.xccj032,l_xccj.xccj033,l_xccj.xccj034,
                               l_xccj.xccj040,l_xccj.xccj041,l_xccj.xccj042,l_xccj.xccj043,l_xccj.xccj044,
                               l_xccj.xccj045,l_xccj.xccj046,l_xccj.xccj047,l_xccj.xccj048,l_xccj.xccj049,
                               l_xccj.xccj050,l_xccj.xccj051,l_xccj.xccj055,l_xccj.xccj101,l_xccj.xccj102,
                               l_xccj.xccj102a,l_xccj.xccj102b,l_xccj.xccj102c,l_xccj.xccj102d,l_xccj.xccj102e,
                               l_xccj.xccj102f,l_xccj.xccj102g,l_xccj.xccj102h,l_xccj.xccjud001,l_xccj.xccjud002,
                               l_xccj.xccjud003,l_xccj.xccjud004,l_xccj.xccjud005,l_xccj.xccjud006,l_xccj.xccjud007,
                               l_xccj.xccjud008,l_xccj.xccjud009,l_xccj.xccjud010,l_xccj.xccjud011,l_xccj.xccjud012,
                               l_xccj.xccjud013,l_xccj.xccjud014,l_xccj.xccjud015,l_xccj.xccjud016,l_xccj.xccjud017,
                               l_xccj.xccjud018,l_xccj.xccjud019,l_xccj.xccjud020,l_xccj.xccjud021,l_xccj.xccjud022,
                               l_xccj.xccjud023,l_xccj.xccjud024,l_xccj.xccjud025,l_xccj.xccjud026,l_xccj.xccjud027,
                               l_xccj.xccjud028,l_xccj.xccjud029,l_xccj.xccjud030      
                          #161109-00085#22-e mod
#fengmy150316---begin
          CASE l_xccj.xccj001
             WHEN 2  IF g_glaa015 = 'N' THEN CONTINUE FOREACH END IF
             WHEN 3  IF g_glaa019 = 'N' THEN CONTINUE FOREACH END IF
             OTHERWISE
          END CASE 
#fengmy150316---end                               
          LET l_xcdj.xcdjent = g_enterprise          
          LET l_xcdj.xcdjcomp = g_xccj_m.xccjcomp
          LET l_xcdj.xcdjld = g_xccj_m.xccjld
          LET l_xcdj.xcdj001 = l_xccj.xccj001
          LET l_xcdj.xcdj002 = l_xccj.xccj002
          LET l_xcdj.xcdj003 = g_xccj_m.xccj003
          LET l_xcdj.xcdj004 = g_xccj_m.xccj004
          LET l_xcdj.xcdj005 = g_xccj_m.xccj005
          LET l_xcdj.xcdj006 = l_xccj.xccj006
          LET l_xcdj.xcdj007 = l_xccj.xccj007
          LET l_xcdj.xcdj008 = l_xccj.xccj008
          LET l_xcdj.xcdj009 = l_xccj.xccj009
          LET l_xcdj.xcdj010 = ' '
          LET l_xcdj.xcdj011 = l_xccj.xccj010
          LET l_xcdj.xcdj012 = l_xccj.xccj011
          LET l_xcdj.xcdj013 = l_xccj.xccj012         
          LET l_xcdj.xcdj014 = l_xccj.xccj013
          LET l_xcdj.xcdj015 = l_xccj.xccj014
          LET l_xcdj.xcdj016 = l_xccj.xccj015
          LET l_xcdj.xcdj017 = l_xccj.xccj016
          LET l_xcdj.xcdj018 = l_xccj.xccj017
          LET l_xcdj.xcdj020 = l_xccj.xccj020
          LET l_xcdj.xcdj021 = l_xccj.xccj021
          LET l_xcdj.xcdj022 = l_xccj.xccj022
          LET l_xcdj.xcdj023 = l_xccj.xccj023
          LET l_xcdj.xcdj024 = l_xccj.xccj024
          LET l_xcdj.xcdj025 = l_xccj.xccj025
          LET l_xcdj.xcdj026 = l_xccj.xccj026
          LET l_xcdj.xcdj027 = l_xccj.xccj027
          LET l_xcdj.xcdj028 = l_xccj.xccj028
          LET l_xcdj.xcdj029 = l_xccj.xccj029
          LET l_xcdj.xcdj030 = l_xccj.xccj030
          LET l_xcdj.xcdj031 = l_xccj.xccj031
          LET l_xcdj.xcdj032 = l_xccj.xccj032
          LET l_xcdj.xcdj033 = l_xccj.xccj033
          LET l_xcdj.xcdj034 = l_xccj.xccj034
          LET l_xcdj.xcdj101 = l_xccj.xccj101
          LET l_xcdj.xcdj102 = l_xccj.xccj102    
#取次要素----fengmy150318--b
          CALL s_axct310_ins(g_xccj_m.xccjld,g_xccj_m.xccjcomp,l_xcdj.xcdj001,l_xcdj.xcdj002,g_xccj_m.xccj003,g_xccj_m.xccj004,g_xccj_m.xccj005,
                             l_xcdj.xcdj011,l_xcdj.xcdj012,l_xcdj.xcdj018,l_xcdj.xcdj102)
               RETURNING l_success1,l_cnt
          IF l_success1 THEN
             LET l_sql =  " SELECT xcam004,amt FROM s_axct310_tmp2 "
             PREPARE s_axct310_tmp2_pb FROM l_sql
             DECLARE s_axct310_tmp2_cs CURSOR FOR s_axct310_tmp2_pb
             IF l_cnt = 1 THEN
                EXECUTE s_axct310_tmp2_pb INTO l_xcdj.xcdj010,l_xcdj.xcdj102
                #161109-00085#22-s mod
#                INSERT INTO xcdj_t VALUES(l_xcdj.*)   #161109-00085#22-s mark
                INSERT INTO xcdj_t(xcdjent,xcdjcomp,xcdjld,xcdj001,xcdj002,xcdj003,xcdj004,xcdj005,xcdj006,xcdj007,
                                   xcdj008,xcdj009,xcdj010,xcdj011,xcdj012,xcdj013,xcdj014,xcdj015,xcdj016,xcdj017,
                                   xcdj018,xcdj020,xcdj021,xcdj022,xcdj023,xcdj024,xcdj025,xcdj026,xcdj027,xcdj028,
                                   xcdj029,xcdj030,xcdj031,xcdj032,xcdj033,xcdj034,xcdj040,xcdj041,xcdj042,xcdj043,
                                   xcdj044,xcdj045,xcdj046,xcdj047,xcdj048,xcdj049,xcdj050,xcdj051,xcdj055,xcdj101,xcdj102) 
                            VALUES(l_xcdj.xcdjent,l_xcdj.xcdjcomp,l_xcdj.xcdjld,l_xcdj.xcdj001,l_xcdj.xcdj002,
                                   l_xcdj.xcdj003,l_xcdj.xcdj004,l_xcdj.xcdj005,l_xcdj.xcdj006,l_xcdj.xcdj007,
                                   l_xcdj.xcdj008,l_xcdj.xcdj009,l_xcdj.xcdj010,l_xcdj.xcdj011,l_xcdj.xcdj012,
                                   l_xcdj.xcdj013,l_xcdj.xcdj014,l_xcdj.xcdj015,l_xcdj.xcdj016,l_xcdj.xcdj017,
                                   l_xcdj.xcdj018,l_xcdj.xcdj020,l_xcdj.xcdj021,l_xcdj.xcdj022,l_xcdj.xcdj023,
                                   l_xcdj.xcdj024,l_xcdj.xcdj025,l_xcdj.xcdj026,l_xcdj.xcdj027,l_xcdj.xcdj028,
                                   l_xcdj.xcdj029,l_xcdj.xcdj030,l_xcdj.xcdj031,l_xcdj.xcdj032,l_xcdj.xcdj033,
                                   l_xcdj.xcdj034,l_xcdj.xcdj040,l_xcdj.xcdj041,l_xcdj.xcdj042,l_xcdj.xcdj043,
                                   l_xcdj.xcdj044,l_xcdj.xcdj045,l_xcdj.xcdj046,l_xcdj.xcdj047,l_xcdj.xcdj048,
                                   l_xcdj.xcdj049,l_xcdj.xcdj050,l_xcdj.xcdj051,l_xcdj.xcdj055,l_xcdj.xcdj101,l_xcdj.xcdj102)
                #161109-00085#22-e mod
                IF SQLCA.SQLCODE AND (NOT cl_err_sql_dup_value(SQLCA.SQLCODE)) THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = SQLCA.sqlcode
                   LET g_errparam.extend = 'ins xcdj_t'
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   LET l_success = 'N' 
                   EXIT FOREACH      
                END IF                           
             ELSE
                FOREACH s_axct310_tmp2_cs INTO l_xcdj.xcdj010,l_xcdj.xcdj102
                   #161109-00085#22-s mod
#                   INSERT INTO xcdj_t VALUES(l_xcdj.*)   #161109-00085#22-s mark
                   INSERT INTO xcdj_t(xcdjent,xcdjcomp,xcdjld,xcdj001,xcdj002,xcdj003,xcdj004,xcdj005,xcdj006,xcdj007,
                                      xcdj008,xcdj009,xcdj010,xcdj011,xcdj012,xcdj013,xcdj014,xcdj015,xcdj016,xcdj017,
                                      xcdj018,xcdj020,xcdj021,xcdj022,xcdj023,xcdj024,xcdj025,xcdj026,xcdj027,xcdj028,
                                      xcdj029,xcdj030,xcdj031,xcdj032,xcdj033,xcdj034,xcdj040,xcdj041,xcdj042,xcdj043,
                                      xcdj044,xcdj045,xcdj046,xcdj047,xcdj048,xcdj049,xcdj050,xcdj051,xcdj055,xcdj101,xcdj102) 
                               VALUES(l_xcdj.xcdjent,l_xcdj.xcdjcomp,l_xcdj.xcdjld,l_xcdj.xcdj001,l_xcdj.xcdj002,
                                      l_xcdj.xcdj003,l_xcdj.xcdj004,l_xcdj.xcdj005,l_xcdj.xcdj006,l_xcdj.xcdj007,
                                      l_xcdj.xcdj008,l_xcdj.xcdj009,l_xcdj.xcdj010,l_xcdj.xcdj011,l_xcdj.xcdj012,
                                      l_xcdj.xcdj013,l_xcdj.xcdj014,l_xcdj.xcdj015,l_xcdj.xcdj016,l_xcdj.xcdj017,
                                      l_xcdj.xcdj018,l_xcdj.xcdj020,l_xcdj.xcdj021,l_xcdj.xcdj022,l_xcdj.xcdj023,
                                      l_xcdj.xcdj024,l_xcdj.xcdj025,l_xcdj.xcdj026,l_xcdj.xcdj027,l_xcdj.xcdj028,
                                      l_xcdj.xcdj029,l_xcdj.xcdj030,l_xcdj.xcdj031,l_xcdj.xcdj032,l_xcdj.xcdj033,
                                      l_xcdj.xcdj034,l_xcdj.xcdj040,l_xcdj.xcdj041,l_xcdj.xcdj042,l_xcdj.xcdj043,
                                      l_xcdj.xcdj044,l_xcdj.xcdj045,l_xcdj.xcdj046,l_xcdj.xcdj047,l_xcdj.xcdj048,
                                      l_xcdj.xcdj049,l_xcdj.xcdj050,l_xcdj.xcdj051,l_xcdj.xcdj055,l_xcdj.xcdj101,l_xcdj.xcdj102)
                   #161109-00085#22-e mod
                   IF SQLCA.SQLCODE AND (NOT cl_err_sql_dup_value(SQLCA.SQLCODE)) THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = 'ins xcdj_t'
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      LET l_success = 'N' 
                      EXIT FOREACH      
                   END IF                     
                END FOREACH        
             END IF
          ELSE
             #161109-00085#22-s mod
#             INSERT INTO xcdj_t VALUES(l_xcdj.*)   #161109-00085#22-s mark
             INSERT INTO xcdj_t(xcdjent,xcdjcomp,xcdjld,xcdj001,xcdj002,xcdj003,xcdj004,xcdj005,xcdj006,xcdj007,
                                xcdj008,xcdj009,xcdj010,xcdj011,xcdj012,xcdj013,xcdj014,xcdj015,xcdj016,xcdj017,
                                xcdj018,xcdj020,xcdj021,xcdj022,xcdj023,xcdj024,xcdj025,xcdj026,xcdj027,xcdj028,
                                xcdj029,xcdj030,xcdj031,xcdj032,xcdj033,xcdj034,xcdj040,xcdj041,xcdj042,xcdj043,
                                xcdj044,xcdj045,xcdj046,xcdj047,xcdj048,xcdj049,xcdj050,xcdj051,xcdj055,xcdj101,xcdj102) 
                         VALUES(l_xcdj.xcdjent,l_xcdj.xcdjcomp,l_xcdj.xcdjld,l_xcdj.xcdj001,l_xcdj.xcdj002,
                                l_xcdj.xcdj003,l_xcdj.xcdj004,l_xcdj.xcdj005,l_xcdj.xcdj006,l_xcdj.xcdj007,
                                l_xcdj.xcdj008,l_xcdj.xcdj009,l_xcdj.xcdj010,l_xcdj.xcdj011,l_xcdj.xcdj012,
                                l_xcdj.xcdj013,l_xcdj.xcdj014,l_xcdj.xcdj015,l_xcdj.xcdj016,l_xcdj.xcdj017,
                                l_xcdj.xcdj018,l_xcdj.xcdj020,l_xcdj.xcdj021,l_xcdj.xcdj022,l_xcdj.xcdj023,
                                l_xcdj.xcdj024,l_xcdj.xcdj025,l_xcdj.xcdj026,l_xcdj.xcdj027,l_xcdj.xcdj028,
                                l_xcdj.xcdj029,l_xcdj.xcdj030,l_xcdj.xcdj031,l_xcdj.xcdj032,l_xcdj.xcdj033,
                                l_xcdj.xcdj034,l_xcdj.xcdj040,l_xcdj.xcdj041,l_xcdj.xcdj042,l_xcdj.xcdj043,
                                l_xcdj.xcdj044,l_xcdj.xcdj045,l_xcdj.xcdj046,l_xcdj.xcdj047,l_xcdj.xcdj048,
                                l_xcdj.xcdj049,l_xcdj.xcdj050,l_xcdj.xcdj051,l_xcdj.xcdj055,l_xcdj.xcdj101,l_xcdj.xcdj102)
             #161109-00085#22-e mod
             IF SQLCA.SQLCODE AND (NOT cl_err_sql_dup_value(SQLCA.SQLCODE)) THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = SQLCA.sqlcode
                LET g_errparam.extend = 'ins xcdj_t'
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
     LET la_param.prog = "axct306"             
     LET la_param.param[1] = g_xccj_m.xccjld
     LET la_param.param[2] = g_xccj_m.xccj003
     LET la_param.param[3] = g_xccj_m.xccj004
     LET la_param.param[4] = g_xccj_m.xccj005              
     LET ls_js = util.JSON.stringify(la_param)
     DISPLAY ls_js
     CALL cl_cmdrun(ls_js)
  END IF 
  CALL s_axct310_drop_tmp_table()    #fengmy150312  



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
PRIVATE FUNCTION axct302_chk_year_period()
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
         AND glaacomp = g_xccj_m.xccjcomp
         AND glaa014  = 'Y'   
   IF g_xccj_m.xccj004 IS NOT NULL  THEN
      IF NOT s_fin_date_chk_year(g_xccj_m.xccj004) THEN  
         LET r_success = FALSE
         RETURN r_success      
      END IF
      SELECT COUNT(*) INTO l_cnt FROM glav_t
      WHERE glavent = g_enterprise
        AND glav001 = l_glaa003
        AND glav002 = g_xccj_m.xccj004
        AND glavstus = 'Y' 
      IF l_cnt = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axc-00581'
         LET g_errparam.extend = g_xccj_m.xccj004
         LET g_errparam.popup = TRUE
         CALL cl_err() 
         LET r_success = FALSE
         RETURN r_success 
      END IF
   END IF
   

   IF g_xccj_m.xccj004 IS NOT NULL AND g_xccj_m.xccj005 IS NOT NULL THEN
      IF NOT s_fin_date_chk_period(l_glaa003,g_xccj_m.xccj004,g_xccj_m.xccj005) THEN
         LET r_success = FALSE
         RETURN r_success      
      END IF
      CALL s_fin_date_get_period_range(l_glaa003,g_xccj_m.xccj004,g_xccj_m.xccj005) RETURNING l_bdate,l_edate
      
      IF NOT s_date_chk_close(l_edate,'2') THEN
         LET r_success = FALSE
         RETURN r_success      
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
PRIVATE FUNCTION axct302_default_inaj()
   DEFINE l_sql STRING
   DEFINE l_cn  LIKE type_t.num5
#   IF NOT cl_null(g_xccj_d[l_ac].xccj006) AND NOT cl_null(g_xccj_d[l_ac].xccj007) 
#      AND NOT cl_null(g_xccj_d[l_ac].xccj008) AND NOT cl_null(g_xccj_d[l_ac].xccj009)
#      THEN 
#      SELECT inaj005,inaj006,inaj015,inaj022,inaj008,inaj009,inaj010,inaj036             
#        INTO g_xccj_d[l_ac].xccj010,g_xccj_d[l_ac].xccj011,g_xccj_d[l_ac].xccj012,
#             g_xccj_d[l_ac].xccj013,g_xccj_d[l_ac].xccj015,g_xccj_d[l_ac].xccj016,
#             g_xccj_d[l_ac].xccj017,g_xccj_d[l_ac].xccj020
#        FROM inaj_t
#       WHERE inajent = g_enterprise #AND inajsite = g_site
#         AND inaj001 = g_xccj_d[l_ac].xccj006
#         AND inaj002 = g_xccj_d[l_ac].xccj007
#         AND inaj003 = g_xccj_d[l_ac].xccj008
#         AND inaj004 = g_xccj_d[l_ac].xccj009
#       DISPLAY BY NAME g_xccj_d[l_ac].xccj010,g_xccj_d[l_ac].xccj011,g_xccj_d[l_ac].xccj012,
#                       g_xccj_d[l_ac].xccj013,g_xccj_d[l_ac].xccj015,g_xccj_d[l_ac].xccj016,
#                       g_xccj_d[l_ac].xccj017,g_xccj_d[l_ac].xccj020
#   END IF
   LET g_xccj006 = ' '   
   LET l_cn = l_ac
   IF NOT cl_null(g_xccj_d[l_ac].xccj006) THEN
      LET g_xccj006 = g_xccj_d[l_ac].xccj006
      CALL s_transaction_begin()   
      LET l_sql = "SELECT inaj002,inaj003,inaj004,inaj005,inaj006,inaj015,
                          inaj022,inaj008,inaj009,inaj010,inaj036,inaj011 ",   

        " FROM inaj_t ",
       " WHERE inajent = '",g_enterprise,"' AND inaj001 = '",g_xccj_d[l_ac].xccj006,"'"
       PREPARE axct302_inaj_pre FROM l_sql
       DECLARE axct302_inaj_cs CURSOR FOR axct302_inaj_pre
       FOREACH axct302_inaj_cs INTO g_xccj_d[l_ac].xccj007,g_xccj_d[l_ac].xccj008,g_xccj_d[l_ac].xccj009,
                                    g_xccj_d[l_ac].xccj010,g_xccj_d[l_ac].xccj011,g_xccj_d[l_ac].xccj012,
                                    g_xccj_d[l_ac].xccj013,g_xccj_d[l_ac].xccj015,g_xccj_d[l_ac].xccj016,
                                    g_xccj_d[l_ac].xccj017,g_xccj_d[l_ac].xccj020,g_xccj_d[l_ac].xccj101
          IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:inaj" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
          LET g_xccj_d[l_ac].xccj006 = g_xccj006
          LET g_xccj_d[l_ac].xccj002 = ' '
          LET g_xccj_d[l_ac].xccj102 = "0"
          LET g_xccj_d[l_ac].xccj102a = "0"
          LET g_xccj_d[l_ac].xccj102b = "0"
          LET g_xccj_d[l_ac].xccj102c = "0"
          LET g_xccj_d[l_ac].xccj102d = "0"
          LET g_xccj_d[l_ac].xccj102e = "0"
          LET g_xccj_d[l_ac].xccj102f = "0"
          LET g_xccj_d[l_ac].xccj102g = "0"
          LET g_xccj_d[l_ac].xccj102h = "0"  
          IF l_ac <> l_cn THEN          
             INSERT INTO xccj_t
                              (xccjent,
                               xccjcomp,xccj004,xccj005,xccjld,xccj003,
                               xccj001,xccj002,xccj006,xccj007,xccj008,xccj009
                               ,xccj013,xccj010,xccj011,xccj015,xccj016,xccj017,xccj020,xccj012,xccj101,
                               xccj102,xccj102a,xccj102b,xccj102c,xccj102d,xccj102e,xccj102f,xccj102g,xccj102h) 
                        VALUES(g_enterprise,
                               g_xccj_m.xccjcomp,g_xccj_m.xccj004,g_xccj_m.xccj005,g_xccj_m.xccjld,g_xccj_m.xccj003,
                               1,g_xccj_d[l_ac].xccj002,g_xccj_d[l_ac].xccj006,g_xccj_d[l_ac].xccj007, 
                                   g_xccj_d[l_ac].xccj008,g_xccj_d[l_ac].xccj009
                               ,g_xccj_d[l_ac].xccj013,g_xccj_d[l_ac].xccj010,g_xccj_d[l_ac].xccj011,g_xccj_d[l_ac].xccj015, 
                                   g_xccj_d[l_ac].xccj016,g_xccj_d[l_ac].xccj017,g_xccj_d[l_ac].xccj020, 
                                   g_xccj_d[l_ac].xccj012,g_xccj_d[l_ac].xccj101,g_xccj_d[l_ac].xccj102, 
                                   g_xccj_d[l_ac].xccj102a,g_xccj_d[l_ac].xccj102b,g_xccj_d[l_ac].xccj102c, 
                                   g_xccj_d[l_ac].xccj102d,g_xccj_d[l_ac].xccj102e,g_xccj_d[l_ac].xccj102f, 
                                   g_xccj_d[l_ac].xccj102g,g_xccj_d[l_ac].xccj102h)
                  
              CALL axct302_insert_xccj()
              IF SQLCA.SQLcode  THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "inaj_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')                    
                  CONTINUE FOREACH
              END IF
          END IF
          LET l_ac = l_ac + 1
       END FOREACH
#       CALL s_transaction_end('Y','0')
   END IF   
   LET l_ac = l_cn
#   CALL axct302_show()
END FUNCTION

 
{</section>}
 
