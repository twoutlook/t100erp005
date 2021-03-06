#該程式未解開Section, 採用最新樣板產出!
{<section id="axct310.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0016(2016-12-05 14:25:49), PR版次:0016(2016-12-05 19:42:40)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000307
#+ Filename...: axct310
#+ Description: 本期庫存成本調整作業
#+ Creator....: 01531(2014-04-08 14:00:03)
#+ Modifier...: 05384 -SD/PR- 05384
 
{</section>}
 
{<section id="axct310.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#151224-00025#2   15/12/25    By catmoon  手動輸入特徵碼同步新增inam_t[料件產品特徵明細檔]
#160314-00009#4   16/03/17    By zhujing  各程式增加产品特征是否需要自动开窗的程式段处理
#160318-00005#47  2016/03/28  by pengxin  修正azzi920重复定义之错误讯息
#160513-00016#1   2016/05/18  By 02097    修正单身的“批号”栏栏位开窗不正确问题。
#160802-00020#5   2016/10/12  By 02040    增加帳套權限管控、法人權限管控
#161013-00051#1   2016/10/18  By shiun    整批調整據點組織開窗
#161109-00085#23  2016/11/16  By 08993    整批調整系統星號寫法
#161124-00011#1   2016/12/05  By shiun    增加'拆讓金額批次產生'功能
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
PRIVATE type type_g_xcco_m        RECORD
       xccocomp LIKE xcco_t.xccocomp, 
   xccocomp_desc LIKE type_t.chr80, 
   xcco004 LIKE xcco_t.xcco004, 
   xcco005 LIKE xcco_t.xcco005, 
   xccold LIKE xcco_t.xccold, 
   xccold_desc LIKE type_t.chr80, 
   xcco003 LIKE xcco_t.xcco003, 
   xcco003_desc LIKE type_t.chr80, 
   xcco009 LIKE xcco_t.xcco009, 
   xcco010 LIKE xcco_t.xcco010
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xcco_d        RECORD
       xcco001 LIKE xcco_t.xcco001, 
   xcco006 LIKE xcco_t.xcco006, 
   xcco007 LIKE xcco_t.xcco007, 
   xcco007_desc LIKE type_t.chr500, 
   xcco006_desc LIKE type_t.chr500, 
   xcco006_1_desc LIKE type_t.chr500, 
   imag014 LIKE type_t.chr500, 
   xcco002 LIKE xcco_t.xcco002, 
   xcco002_desc LIKE type_t.chr500, 
   xcco008 LIKE xcco_t.xcco008, 
   xcco011 LIKE xcco_t.xcco011, 
   xcco102a LIKE xcco_t.xcco102a, 
   xcco102b LIKE xcco_t.xcco102b, 
   xcco102c LIKE xcco_t.xcco102c, 
   xcco102d LIKE xcco_t.xcco102d, 
   xcco102e LIKE xcco_t.xcco102e, 
   xcco102f LIKE xcco_t.xcco102f, 
   xcco102g LIKE xcco_t.xcco102g, 
   xcco102h LIKE xcco_t.xcco102h, 
   xcco102 LIKE xcco_t.xcco102
       END RECORD
PRIVATE TYPE type_g_xcco2_d RECORD
       xcco001 LIKE xcco_t.xcco001, 
   xcco006 LIKE xcco_t.xcco006, 
   xcco007 LIKE xcco_t.xcco007, 
   xcco002 LIKE xcco_t.xcco002, 
   xcco008 LIKE xcco_t.xcco008, 
   xccoownid LIKE xcco_t.xccoownid, 
   xccoownid_desc LIKE type_t.chr500, 
   xccoowndp LIKE xcco_t.xccoowndp, 
   xccoowndp_desc LIKE type_t.chr500, 
   xccocrtid LIKE xcco_t.xccocrtid, 
   xccocrtid_desc LIKE type_t.chr500, 
   xccocrtdp LIKE xcco_t.xccocrtdp, 
   xccocrtdp_desc LIKE type_t.chr500, 
   xccocrtdt DATETIME YEAR TO SECOND, 
   xccomodid LIKE xcco_t.xccomodid, 
   xccomodid_desc LIKE type_t.chr500, 
   xccomoddt DATETIME YEAR TO SECOND, 
   xccocnfid LIKE xcco_t.xccocnfid, 
   xccocnfid_desc LIKE type_t.chr500, 
   xccocnfdt DATETIME YEAR TO SECOND, 
   xccopstid LIKE xcco_t.xccopstid, 
   xccopstid_desc LIKE type_t.chr500, 
   xccopstdt LIKE xcco_t.xccopstdt
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#單身 type 宣告
TYPE type_g_xcco1_d  RECORD
     xcco001_1  LIKE xcco_t.xcco001,  
     xcco006_1  LIKE xcco_t.xcco006, 
     xcco007_1  LIKE xcco_t.xcco007,
     xcco007_desc1   LIKE type_t.chr500, 
     xcco006_desc_1  LIKE imaal_t.imaal003,
     xcco006_desc_1_1  LIKE imaal_t.imaal004, 
     imag014_1  LIKE imag_t.imag014,
     xcco002_1  LIKE xcco_t.xcco002, 
     xcco002_desc_1 LIKE xcbfl_t.xcbfl003,
     xcco008_1  LIKE xcco_t.xcco008, 
     xcco102a_1 LIKE xcco_t.xcco102a, 
     xcco102b_1 LIKE xcco_t.xcco102b, 
     xcco102c_1 LIKE xcco_t.xcco102c, 
     xcco102d_1 LIKE xcco_t.xcco102d, 
     xcco102e_1 LIKE xcco_t.xcco102e, 
     xcco102f_1 LIKE xcco_t.xcco102f, 
     xcco102g_1 LIKE xcco_t.xcco102g, 
     xcco102h_1 LIKE xcco_t.xcco102h, 
     xcco102_1  LIKE xcco_t.xcco102  
                     END RECORD
                     
TYPE type_g_xcco3_d  RECORD
     xcco001_3  LIKE xcco_t.xcco001,  
     xcco006_3  LIKE xcco_t.xcco006, 
     xcco007_3  LIKE xcco_t.xcco007,
     xcco007_desc3   LIKE type_t.chr500, 
     xcco006_desc_3  LIKE imaal_t.imaal003,
     xcco006_desc_1_3  LIKE imaal_t.imaal004, 
     imag014_3  LIKE imag_t.imag014,
     xcco002_3  LIKE xcco_t.xcco002, 
     xcco002_desc_3 LIKE xcbfl_t.xcbfl003,
     xcco008_3  LIKE xcco_t.xcco008,  
     xcco102a_3 LIKE xcco_t.xcco102a, 
     xcco102b_3 LIKE xcco_t.xcco102b, 
     xcco102c_3 LIKE xcco_t.xcco102c, 
     xcco102d_3 LIKE xcco_t.xcco102d, 
     xcco102e_3 LIKE xcco_t.xcco102e, 
     xcco102f_3 LIKE xcco_t.xcco102f, 
     xcco102g_3 LIKE xcco_t.xcco102g, 
     xcco102h_3 LIKE xcco_t.xcco102h, 
     xcco102_3  LIKE xcco_t.xcco102  
                     END RECORD  
DEFINE g_xcco1_d          DYNAMIC ARRAY OF type_g_xcco1_d
DEFINE g_xcco1_d_t        type_g_xcco1_d
DEFINE g_xcco3_d          DYNAMIC ARRAY OF type_g_xcco3_d
DEFINE g_xcco3_d_t        type_g_xcco3_d
DEFINE g_glaa001       LIKE glaa_t.glaa001
DEFINE g_glaa015       LIKE glaa_t.glaa015
DEFINE g_glaa016       LIKE glaa_t.glaa016
DEFINE g_glaa018       LIKE glaa_t.glaa018
DEFINE g_glaa019       LIKE glaa_t.glaa019
DEFINE g_glaa020       LIKE glaa_t.glaa020
DEFINE g_glaa022       LIKE glaa_t.glaa022
DEFINE g_wc3           STRING
DEFINE g_bdate      LIKE glav_t.glav004  
DEFINE g_edate      LIKE glav_t.glav004
TYPE   type_g_xcco_s        RECORD
       name LIKE type_t.chr80, 
       dir LIKE type_t.chr80
                            END RECORD
DEFINE g_xcco_s        type_g_xcco_s
#單身 type 宣告
TYPE type_g_xcco_e        RECORD
   xccoent LIKE xcco_t.xccoent,
   xccold LIKE xcco_t.xccold,
   xccocomp LIKE xcco_t.xccocomp,
   xcco001 LIKE xcco_t.xcco001, 
   xcco002 LIKE xcco_t.xcco002, 
   xcco003 LIKE xcco_t.xcco003,
   xcco004 LIKE xcco_t.xcco004,
   xcco005 LIKE xcco_t.xcco005,
   xcco006 LIKE xcco_t.xcco006, 
   xcco007 LIKE xcco_t.xcco007, 
   xcco008 LIKE xcco_t.xcco008,
   xcco009 LIKE xcco_t.xcco009, 
   xcco010 LIKE xcco_t.xcco010, 
   xcco011 LIKE xcco_t.xcco011,
   xcco102a LIKE xcco_t.xcco102a, 
   xcco102b LIKE xcco_t.xcco102b, 
   xcco102c LIKE xcco_t.xcco102c, 
   xcco102d LIKE xcco_t.xcco102d, 
   xcco102e LIKE xcco_t.xcco102e, 
   xcco102f LIKE xcco_t.xcco102f, 
   xcco102g LIKE xcco_t.xcco102g, 
   xcco102h LIKE xcco_t.xcco102h,
   xcco102  LIKE xcco_t.xcco102
       END RECORD
TYPE type_g_xcco4_d        RECORD
   xccoent LIKE xcco_t.xccoent,
   xccold LIKE xcco_t.xccold,
   xccocomp LIKE xcco_t.xccocomp,
   xcco001 LIKE xcco_t.xcco001, 
   xcco002 LIKE xcco_t.xcco002, 
   xcco003 LIKE xcco_t.xcco003,
   xcco004 LIKE xcco_t.xcco004,
   xcco005 LIKE xcco_t.xcco005,
   xcco006 LIKE xcco_t.xcco006, 
   xcco007 LIKE xcco_t.xcco007, 
   xcco008 LIKE xcco_t.xcco008,
   xcco009 LIKE xcco_t.xcco009,
   xcco010 LIKE xcco_t.xcco010,
   xcco011 LIKE xcco_t.xcco011,
   xcco102a LIKE xcco_t.xcco102a, 
   xcco102b LIKE xcco_t.xcco102b, 
   xcco102c LIKE xcco_t.xcco102c, 
   xcco102d LIKE xcco_t.xcco102d, 
   xcco102e LIKE xcco_t.xcco102e, 
   xcco102f LIKE xcco_t.xcco102f, 
   xcco102g LIKE xcco_t.xcco102g, 
   xcco102h LIKE xcco_t.xcco102h,
   xcco102 LIKE xcco_t.xcco102,
   xcco102a_1 LIKE xcco_t.xcco102a, 
   xcco102b_1 LIKE xcco_t.xcco102b, 
   xcco102c_1 LIKE xcco_t.xcco102c, 
   xcco102d_1 LIKE xcco_t.xcco102d, 
   xcco102e_1 LIKE xcco_t.xcco102e, 
   xcco102f_1 LIKE xcco_t.xcco102f, 
   xcco102g_1 LIKE xcco_t.xcco102g, 
   xcco102h_1 LIKE xcco_t.xcco102h,
   xcco102_1 LIKE xcco_t.xcco102,
   xcco102a_2 LIKE xcco_t.xcco102a, 
   xcco102b_2 LIKE xcco_t.xcco102b, 
   xcco102c_2 LIKE xcco_t.xcco102c, 
   xcco102d_2 LIKE xcco_t.xcco102d, 
   xcco102e_2 LIKE xcco_t.xcco102e, 
   xcco102f_2 LIKE xcco_t.xcco102f, 
   xcco102g_2 LIKE xcco_t.xcco102g, 
   xcco102h_2 LIKE xcco_t.xcco102h,
   xcco102_2 LIKE xcco_t.xcco102  
       END RECORD       
       
DEFINE g_xcco_e        type_g_xcco_e       
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

 type type_g_xcco_f        RECORD
        xccocomp LIKE xcco_t.xccocomp, 
        xccocomp_desc LIKE type_t.chr80, 
        xccold LIKE xcco_t.xccold, 
        xccold_desc LIKE type_t.chr80, 
        format LIKE type_t.chr80, 
        char LIKE type_t.chr80, 
        dir LIKE type_t.chr80
       END RECORD
DEFINE g_xcco_f        type_g_xcco_f
DEFINE g_xcco_f_t      type_g_xcco_f
DEFINE g_xcco4_d          DYNAMIC ARRAY OF type_g_xcco4_d
DEFINE w        ui.Window
DEFINE f        ui.Form
DEFINE page     om.DomNode
DEFINE l_success       LIKE type_t.num5
DEFINE  l_inam          DYNAMIC ARRAY OF RECORD   #記錄產品特徵
        inam001      LIKE inam_t.inam001,
        inam002      LIKE inam_t.inam002,
        inam004      LIKE inam_t.inam004
        END RECORD  
#160802-00020#5-s-add
DEFINE g_wc_cs_ld            STRING
DEFINE g_wc_cs_comp          STRING
#160802-00020#5-e-add        
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_xcco_m          type_g_xcco_m
DEFINE g_xcco_m_t        type_g_xcco_m
DEFINE g_xcco_m_o        type_g_xcco_m
DEFINE g_xcco_m_mask_o   type_g_xcco_m #轉換遮罩前資料
DEFINE g_xcco_m_mask_n   type_g_xcco_m #轉換遮罩後資料
 
   DEFINE g_xcco004_t LIKE xcco_t.xcco004
DEFINE g_xcco005_t LIKE xcco_t.xcco005
DEFINE g_xccold_t LIKE xcco_t.xccold
DEFINE g_xcco003_t LIKE xcco_t.xcco003
DEFINE g_xcco009_t LIKE xcco_t.xcco009
 
 
DEFINE g_xcco_d          DYNAMIC ARRAY OF type_g_xcco_d
DEFINE g_xcco_d_t        type_g_xcco_d
DEFINE g_xcco_d_o        type_g_xcco_d
DEFINE g_xcco_d_mask_o   DYNAMIC ARRAY OF type_g_xcco_d #轉換遮罩前資料
DEFINE g_xcco_d_mask_n   DYNAMIC ARRAY OF type_g_xcco_d #轉換遮罩後資料
DEFINE g_xcco2_d   DYNAMIC ARRAY OF type_g_xcco2_d
DEFINE g_xcco2_d_t type_g_xcco2_d
DEFINE g_xcco2_d_o type_g_xcco2_d
DEFINE g_xcco2_d_mask_o   DYNAMIC ARRAY OF type_g_xcco2_d #轉換遮罩前資料
DEFINE g_xcco2_d_mask_n   DYNAMIC ARRAY OF type_g_xcco2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_xccold LIKE xcco_t.xccold,
      b_xcco003 LIKE xcco_t.xcco003,
      b_xcco004 LIKE xcco_t.xcco004,
      b_xcco005 LIKE xcco_t.xcco005,
      b_xcco009 LIKE xcco_t.xcco009
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
 
{<section id="axct310.main" >}
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
   LET g_forupd_sql = " SELECT xccocomp,'',xcco004,xcco005,xccold,'',xcco003,'',xcco009,xcco010", 
                      " FROM xcco_t",
                      " WHERE xccoent= ? AND xccold=? AND xcco003=? AND xcco004=? AND xcco005=? AND  
                          xcco009=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axct310_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xccocomp,t0.xcco004,t0.xcco005,t0.xccold,t0.xcco003,t0.xcco009,t0.xcco010, 
       t1.ooefl003 ,t2.glaal002 ,t3.xcatl003",
               " FROM xcco_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.xccocomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t2 ON t2.glaalent="||g_enterprise||" AND t2.glaalld=t0.xccold AND t2.glaal001='"||g_dlang||"' ",
               " LEFT JOIN xcatl_t t3 ON t3.xcatlent="||g_enterprise||" AND t3.xcatl001=t0.xcco003 AND t3.xcatl002='"||g_dlang||"' ",
 
               " WHERE t0.xccoent = " ||g_enterprise|| " AND t0.xccold = ? AND t0.xcco003 = ? AND t0.xcco004 = ? AND t0.xcco005 = ? AND t0.xcco009 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axct310_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axct310 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axct310_init()   
 
      #進入選單 Menu (="N")
      CALL axct310_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axct310
      
   END IF 
   
   CLOSE axct310_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axct310.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axct310_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('xcco001','8914') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc("xcco001,xcco001_1,xcco001_3,xcco001_2",'8914')
   CALL cl_set_combo_scc("xcco010",'8916')
   CALL cl_set_comp_entry("xcco102,xcco102_1,xcco102_3",FALSE) 
   CALL cl_set_comp_visible("xcco001,xcco001_1,xcco001_3,xcco001_2",FALSE)
   CALL cl_set_comp_entry("xcco006_1,xcco006_desc_1,xcco006_desc_1_1,imag014_1,xcco002_1,xcco007_1",FALSE)
   CALL cl_set_comp_entry("xcco006_3,xcco006_desc_3,xcco006_desc_1_3,imag014_3,xcco002_3,xcco007_3",FALSE)   
   CALL cl_set_comp_entry("xcco010",FALSE)
   
   #特性
   IF cl_get_para(g_enterprise,g_site,'S-FIN-6013') = 'N' THEN
      CALL cl_set_comp_visible('xcco007,xcco007_1,xcco007_3,xcco007_desc,xcco007_desc1,xcco007_desc3',FALSE)
   ELSE
      CALL cl_set_comp_visible('xcco007,xcco007_1,xcco007_3,xcco007_desc,xcco007_desc1,xcco007_desc3',TRUE)
   END IF
   #成本域
   IF cl_get_para(g_enterprise,g_site,'S-FIN-6001') = 'N' THEN
      CALL cl_set_comp_visible('xcco002,xcco002_1,xcco002_3',FALSE)
      CALL cl_set_comp_visible('xcco002_desc,xcco002_desc_1,xcco002_desc_3',FALSE)
   ELSE   
      CALL cl_set_comp_visible('xcco002,xcco002_1,xcco002_3',TRUE)
      CALL cl_set_comp_visible('xcco002_desc,xcco002_desc_1,xcco002_desc_3',TRUE)   
   END IF     
   #160314-00009#4 zhujing add 2016-3-17---(S)
   #判斷據點參數若不使用產品特徵時，則產品特徵需隱藏不可以維護(據點參數:S-BAS-0036)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("xcco007,xcco007_desc",FALSE)
   END IF
   #160314-00009#4 zhujing add 2016-3-17---(E)
   #end add-point
   
   CALL axct310_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axct310.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axct310_ui_dialog()
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
   CALL cl_set_comp_visible("bpage_2,bpage_3",TRUE)

   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_xcco_m.* TO NULL
         CALL g_xcco_d.clear()
         CALL g_xcco2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axct310_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_xcco_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL axct310_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axct310_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body.before_row"
#               CALL axct310_b_fill_1(g_wc3)
#               CALL axct310_b_fill_3(g_wc3)
               IF g_glaa015 = 'Y' THEN 
                     CALL axct310_b_fill_1(g_wc3) #單身填充
                  END IF
                  IF g_glaa019 = 'Y' THEN 
                     CALL axct310_b_fill_3(g_wc3) #單身填充
                  END IF  
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
            LET g_current_page = 1
            #end add-point
               
         END DISPLAY
        
         DISPLAY ARRAY g_xcco2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL axct310_idx_chk()
               CALL axct310_ui_detailshow()
               
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
      DISPLAY ARRAY g_xcco1_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
         
         BEFORE ROW
            LET l_ac = DIALOG.getCurrentRow("s_detail3")
            LET g_detail_idx = l_ac
            DISPLAY g_detail_idx TO FORMONLY.idx
            CALL axct310_ui_detailshow()
               
            #add-point:page1自定義行為
              
            #end add-point
            
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)      
            
            
         
            #add-point:page2自定義行為
            LET l_ac = DIALOG.getCurrentRow("s_detail3")         
            LET g_current_page = 2
            #end add-point
         
      END DISPLAY     
      
      DISPLAY ARRAY g_xcco3_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
         
         BEFORE ROW
            LET l_ac = DIALOG.getCurrentRow("s_detail4")
            LET g_detail_idx = l_ac
            DISPLAY g_detail_idx TO FORMONLY.idx
            CALL axct310_ui_detailshow()
               
            #add-point:page1自定義行為
               
            #end add-point
            
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)      
            
            
         
            #add-point:page2自定義行為
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_current_page = 3
            #end add-point
         
      END DISPLAY  
         #end add-point
         
         
         BEFORE DIALOG
            #先填充browser資料
            CALL axct310_browser_fill("")
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
               CALL axct310_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axct310_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axct310_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct310_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axct310_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct310_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axct310_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct310_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axct310_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct310_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axct310_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct310_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_xcco_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_xcco2_d)
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
               NEXT FIELD xcco001
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
               CALL axct310_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL axct310_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL axct310_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL axct310_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL axct310_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axct310_s01
            LET g_action_choice="open_axct310_s01"
            IF cl_auth_chk_act("open_axct310_s01") THEN
               
               #add-point:ON ACTION open_axct310_s01 name="menu.open_axct310_s01"
               CALL axct310_s01()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION axct320
            LET g_action_choice="axct320"
            IF cl_auth_chk_act("axct320") THEN
               
               #add-point:ON ACTION axct320 name="menu.axct320"
               CALL axct310_generate_xcdo()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL axct310_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axct310_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/axc/axct310_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/axc/axct310_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL axct310_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axct310_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axct310_s02
            LET g_action_choice="open_axct310_s02"
            IF cl_auth_chk_act("open_axct310_s02") THEN
               
               #add-point:ON ACTION open_axct310_s02 name="menu.open_axct310_s02"
               CALL axct310_s02() RETURNING l_success
               IF l_success = TRUE THEN
                  CALL s_transaction_end('Y','1')
                  ERROR "INSERT O.K"
               ELSE
                  CALL s_transaction_end('N','1')
               END IF
               CALL axct310_show()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axct310_01
            LET g_action_choice="open_axct310_01"
            IF cl_auth_chk_act("open_axct310_01") THEN
               
               #add-point:ON ACTION open_axct310_01 name="menu.open_axct310_01"
               CALL axct310_01()   #161124-00011#1-add
               #END add-point
               
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axct310_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axct310_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axct310_set_pk_array()
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
 
{<section id="axct310.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION axct310_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axct310.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axct310_browser_fill(ps_page_action)
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
 
   LET l_searchcol = "xccold,xcco003,xcco004,xcco005,xcco009"
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
      LET l_sub_sql = " SELECT DISTINCT xccold ",
                      ", xcco003 ",
                      ", xcco004 ",
                      ", xcco005 ",
                      ", xcco009 ",
 
                      " FROM xcco_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE xccoent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xcco_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xccold ",
                      ", xcco003 ",
                      ", xcco004 ",
                      ", xcco005 ",
                      ", xcco009 ",
 
                      " FROM xcco_t ",
                      " ",
                      " ", 
 
 
                      " WHERE xccoent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xcco_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
 
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   #160802-00020#5-s-add
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET l_sub_sql = l_sub_sql , " AND xccold IN ",g_wc_cs_ld
   END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET l_sub_sql = l_sub_sql," AND xccocomp IN ",g_wc_cs_comp
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
      INITIALIZE g_xcco_m.* TO NULL
      CALL g_xcco_d.clear()        
      CALL g_xcco2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xccold,t0.xcco003,t0.xcco004,t0.xcco005,t0.xcco009 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.xccold,t0.xcco003,t0.xcco004,t0.xcco005,t0.xcco009",
                " FROM xcco_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.xccoent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xcco_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   #160802-00020#5-s-add
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql , " AND t0.xccold IN ",g_wc_cs_ld
   END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql," AND t0.xccocomp IN ",g_wc_cs_comp
   END IF  
   #160802-00020#5-e-add
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"xcco_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_xccold,g_browser[g_cnt].b_xcco003,g_browser[g_cnt].b_xcco004, 
          g_browser[g_cnt].b_xcco005,g_browser[g_cnt].b_xcco009 
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
   
   IF cl_null(g_browser[g_cnt].b_xccold) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_xcco_m.* TO NULL
      CALL g_xcco_d.clear()
      CALL g_xcco2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL axct310_fetch('')
   
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
 
{<section id="axct310.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axct310_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xcco_m.xccold = g_browser[g_current_idx].b_xccold   
   LET g_xcco_m.xcco003 = g_browser[g_current_idx].b_xcco003   
   LET g_xcco_m.xcco004 = g_browser[g_current_idx].b_xcco004   
   LET g_xcco_m.xcco005 = g_browser[g_current_idx].b_xcco005   
   LET g_xcco_m.xcco009 = g_browser[g_current_idx].b_xcco009   
 
   EXECUTE axct310_master_referesh USING g_xcco_m.xccold,g_xcco_m.xcco003,g_xcco_m.xcco004,g_xcco_m.xcco005, 
       g_xcco_m.xcco009 INTO g_xcco_m.xccocomp,g_xcco_m.xcco004,g_xcco_m.xcco005,g_xcco_m.xccold,g_xcco_m.xcco003, 
       g_xcco_m.xcco009,g_xcco_m.xcco010,g_xcco_m.xccocomp_desc,g_xcco_m.xccold_desc,g_xcco_m.xcco003_desc 
 
   CALL axct310_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axct310.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axct310_ui_detailshow()
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
 
{<section id="axct310.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axct310_ui_browser_refresh()
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
      IF g_browser[l_i].b_xccold = g_xcco_m.xccold 
         AND g_browser[l_i].b_xcco003 = g_xcco_m.xcco003 
         AND g_browser[l_i].b_xcco004 = g_xcco_m.xcco004 
         AND g_browser[l_i].b_xcco005 = g_xcco_m.xcco005 
         AND g_browser[l_i].b_xcco009 = g_xcco_m.xcco009 
 
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
 
{<section id="axct310.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axct310_construct()
   #add-point:cs段define name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   DEFINE l_imaa005              LIKE imaa_t.imaa005   #150724-00005#1 add
   DEFINE l_success              LIKE type_t.num5      #150724-00005#1 add
   #end add-point 
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清除畫面上相關資料
   CLEAR FORM                 
   INITIALIZE g_xcco_m.* TO NULL
   CALL g_xcco_d.clear()
   CALL g_xcco2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xccocomp,xcco004,xcco005,xccold,xcco003,xcco009,xcco010
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.xccocomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccocomp
            #add-point:ON ACTION controlp INFIELD xccocomp name="construct.c.xccocomp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #查詢時，開窗法人組織且有效的資料
            LET g_qryparam.where = " ooef003 = 'Y' AND ooefstus = 'Y' "
           #160802-00020#5-s-add 
            #增加法人過濾條件
            IF NOT cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = g_qryparam.where," AND ooef001 IN ",g_wc_cs_comp
            END IF
           #160802-00020#5-e-add             
            #mod--161013-00051#1 By shiun--(S)
#            CALL q_ooef001_8()                           #呼叫開窗
            CALL q_ooef001_2()
            #mod--161013-00051#1 By shiun--(E)
            DISPLAY g_qryparam.return1 TO xccocomp  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD xccocomp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccocomp
            #add-point:BEFORE FIELD xccocomp name="construct.b.xccocomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccocomp
            
            #add-point:AFTER FIELD xccocomp name="construct.a.xccocomp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco004
            #add-point:BEFORE FIELD xcco004 name="construct.b.xcco004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco004
            
            #add-point:AFTER FIELD xcco004 name="construct.a.xcco004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcco004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco004
            #add-point:ON ACTION controlp INFIELD xcco004 name="construct.c.xcco004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco005
            #add-point:BEFORE FIELD xcco005 name="construct.b.xcco005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco005
            
            #add-point:AFTER FIELD xcco005 name="construct.a.xcco005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcco005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco005
            #add-point:ON ACTION controlp INFIELD xcco005 name="construct.c.xcco005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xccold
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccold
            #add-point:ON ACTION controlp INFIELD xccold name="construct.c.xccold"
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
            DISPLAY g_qryparam.return1 TO xccold  #顯示到畫面上
            NEXT FIELD xccold                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccold
            #add-point:BEFORE FIELD xccold name="construct.b.xccold"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccold
            
            #add-point:AFTER FIELD xccold name="construct.a.xccold"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcco003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco003
            #add-point:ON ACTION controlp INFIELD xcco003 name="construct.c.xcco003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcco003  #顯示到畫面上
            NEXT FIELD xcco003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco003
            #add-point:BEFORE FIELD xcco003 name="construct.b.xcco003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco003
            
            #add-point:AFTER FIELD xcco003 name="construct.a.xcco003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco009
            #add-point:BEFORE FIELD xcco009 name="construct.b.xcco009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco009
            
            #add-point:AFTER FIELD xcco009 name="construct.a.xcco009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcco009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco009
            #add-point:ON ACTION controlp INFIELD xcco009 name="construct.c.xcco009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco010
            #add-point:BEFORE FIELD xcco010 name="construct.b.xcco010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco010
            
            #add-point:AFTER FIELD xcco010 name="construct.a.xcco010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcco010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco010
            #add-point:ON ACTION controlp INFIELD xcco010 name="construct.c.xcco010"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON xcco001,xcco006,xcco007,xcco002,xcco008,xcco011,xcco102a,xcco102b,xcco102c, 
          xcco102d,xcco102e,xcco102f,xcco102g,xcco102h,xcco102,xccoownid,xccoowndp,xccocrtid,xccocrtdp, 
          xccocrtdt,xccomodid,xccomoddt,xccocnfid,xccocnfdt,xccopstid,xccopstdt
           FROM s_detail1[1].xcco001,s_detail1[1].xcco006,s_detail1[1].xcco007,s_detail1[1].xcco002, 
               s_detail1[1].xcco008,s_detail1[1].xcco011,s_detail1[1].xcco102a,s_detail1[1].xcco102b, 
               s_detail1[1].xcco102c,s_detail1[1].xcco102d,s_detail1[1].xcco102e,s_detail1[1].xcco102f, 
               s_detail1[1].xcco102g,s_detail1[1].xcco102h,s_detail1[1].xcco102,s_detail2[1].xccoownid, 
               s_detail2[1].xccoowndp,s_detail2[1].xccocrtid,s_detail2[1].xccocrtdp,s_detail2[1].xccocrtdt, 
               s_detail2[1].xccomodid,s_detail2[1].xccomoddt,s_detail2[1].xccocnfid,s_detail2[1].xccocnfdt, 
               s_detail2[1].xccopstid,s_detail2[1].xccopstdt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<xccocrtdt>>----
         AFTER FIELD xccocrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<xccomoddt>>----
         AFTER FIELD xccomoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xccocnfdt>>----
         AFTER FIELD xccocnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xccopstdt>>----
         AFTER FIELD xccopstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco001
            #add-point:BEFORE FIELD xcco001 name="construct.b.page1.xcco001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco001
            
            #add-point:AFTER FIELD xcco001 name="construct.a.page1.xcco001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcco001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco001
            #add-point:ON ACTION controlp INFIELD xcco001 name="construct.c.page1.xcco001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xcco006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco006
            #add-point:ON ACTION controlp INFIELD xcco006 name="construct.c.page1.xcco006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcco006  #顯示到畫面上
            NEXT FIELD xcco006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco006
            #add-point:BEFORE FIELD xcco006 name="construct.b.page1.xcco006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco006
            
            #add-point:AFTER FIELD xcco006 name="construct.a.page1.xcco006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcco007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco007
            #add-point:ON ACTION controlp INFIELD xcco007 name="construct.c.page1.xcco007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcco007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcco007  #顯示到畫面上
            NEXT FIELD xcco007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco007
            #add-point:BEFORE FIELD xcco007 name="construct.b.page1.xcco007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco007
            
            #add-point:AFTER FIELD xcco007 name="construct.a.page1.xcco007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcco002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco002
            #add-point:ON ACTION controlp INFIELD xcco002 name="construct.c.page1.xcco002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcbf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcco002  #顯示到畫面上
            NEXT FIELD xcco002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco002
            #add-point:BEFORE FIELD xcco002 name="construct.b.page1.xcco002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco002
            
            #add-point:AFTER FIELD xcco002 name="construct.a.page1.xcco002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcco008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco008
            #add-point:ON ACTION controlp INFIELD xcco008 name="construct.c.page1.xcco008"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaj010()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcco008  #顯示到畫面上
            NEXT FIELD xcco008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco008
            #add-point:BEFORE FIELD xcco008 name="construct.b.page1.xcco008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco008
            
            #add-point:AFTER FIELD xcco008 name="construct.a.page1.xcco008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco011
            #add-point:BEFORE FIELD xcco011 name="construct.b.page1.xcco011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco011
            
            #add-point:AFTER FIELD xcco011 name="construct.a.page1.xcco011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcco011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco011
            #add-point:ON ACTION controlp INFIELD xcco011 name="construct.c.page1.xcco011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco102a
            #add-point:BEFORE FIELD xcco102a name="construct.b.page1.xcco102a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco102a
            
            #add-point:AFTER FIELD xcco102a name="construct.a.page1.xcco102a"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcco102a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco102a
            #add-point:ON ACTION controlp INFIELD xcco102a name="construct.c.page1.xcco102a"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco102b
            #add-point:BEFORE FIELD xcco102b name="construct.b.page1.xcco102b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco102b
            
            #add-point:AFTER FIELD xcco102b name="construct.a.page1.xcco102b"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcco102b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco102b
            #add-point:ON ACTION controlp INFIELD xcco102b name="construct.c.page1.xcco102b"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco102c
            #add-point:BEFORE FIELD xcco102c name="construct.b.page1.xcco102c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco102c
            
            #add-point:AFTER FIELD xcco102c name="construct.a.page1.xcco102c"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcco102c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco102c
            #add-point:ON ACTION controlp INFIELD xcco102c name="construct.c.page1.xcco102c"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco102d
            #add-point:BEFORE FIELD xcco102d name="construct.b.page1.xcco102d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco102d
            
            #add-point:AFTER FIELD xcco102d name="construct.a.page1.xcco102d"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcco102d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco102d
            #add-point:ON ACTION controlp INFIELD xcco102d name="construct.c.page1.xcco102d"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco102e
            #add-point:BEFORE FIELD xcco102e name="construct.b.page1.xcco102e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco102e
            
            #add-point:AFTER FIELD xcco102e name="construct.a.page1.xcco102e"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcco102e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco102e
            #add-point:ON ACTION controlp INFIELD xcco102e name="construct.c.page1.xcco102e"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco102f
            #add-point:BEFORE FIELD xcco102f name="construct.b.page1.xcco102f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco102f
            
            #add-point:AFTER FIELD xcco102f name="construct.a.page1.xcco102f"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcco102f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco102f
            #add-point:ON ACTION controlp INFIELD xcco102f name="construct.c.page1.xcco102f"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco102g
            #add-point:BEFORE FIELD xcco102g name="construct.b.page1.xcco102g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco102g
            
            #add-point:AFTER FIELD xcco102g name="construct.a.page1.xcco102g"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcco102g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco102g
            #add-point:ON ACTION controlp INFIELD xcco102g name="construct.c.page1.xcco102g"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco102h
            #add-point:BEFORE FIELD xcco102h name="construct.b.page1.xcco102h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco102h
            
            #add-point:AFTER FIELD xcco102h name="construct.a.page1.xcco102h"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcco102h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco102h
            #add-point:ON ACTION controlp INFIELD xcco102h name="construct.c.page1.xcco102h"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco102
            #add-point:BEFORE FIELD xcco102 name="construct.b.page1.xcco102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco102
            
            #add-point:AFTER FIELD xcco102 name="construct.a.page1.xcco102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcco102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco102
            #add-point:ON ACTION controlp INFIELD xcco102 name="construct.c.page1.xcco102"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xccoownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccoownid
            #add-point:ON ACTION controlp INFIELD xccoownid name="construct.c.page2.xccoownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccoownid  #顯示到畫面上
            NEXT FIELD xccoownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccoownid
            #add-point:BEFORE FIELD xccoownid name="construct.b.page2.xccoownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccoownid
            
            #add-point:AFTER FIELD xccoownid name="construct.a.page2.xccoownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccoowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccoowndp
            #add-point:ON ACTION controlp INFIELD xccoowndp name="construct.c.page2.xccoowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccoowndp  #顯示到畫面上
            NEXT FIELD xccoowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccoowndp
            #add-point:BEFORE FIELD xccoowndp name="construct.b.page2.xccoowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccoowndp
            
            #add-point:AFTER FIELD xccoowndp name="construct.a.page2.xccoowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccocrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccocrtid
            #add-point:ON ACTION controlp INFIELD xccocrtid name="construct.c.page2.xccocrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccocrtid  #顯示到畫面上
            NEXT FIELD xccocrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccocrtid
            #add-point:BEFORE FIELD xccocrtid name="construct.b.page2.xccocrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccocrtid
            
            #add-point:AFTER FIELD xccocrtid name="construct.a.page2.xccocrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccocrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccocrtdp
            #add-point:ON ACTION controlp INFIELD xccocrtdp name="construct.c.page2.xccocrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccocrtdp  #顯示到畫面上
            NEXT FIELD xccocrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccocrtdp
            #add-point:BEFORE FIELD xccocrtdp name="construct.b.page2.xccocrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccocrtdp
            
            #add-point:AFTER FIELD xccocrtdp name="construct.a.page2.xccocrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccocrtdt
            #add-point:BEFORE FIELD xccocrtdt name="construct.b.page2.xccocrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xccomodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccomodid
            #add-point:ON ACTION controlp INFIELD xccomodid name="construct.c.page2.xccomodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccomodid  #顯示到畫面上
            NEXT FIELD xccomodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccomodid
            #add-point:BEFORE FIELD xccomodid name="construct.b.page2.xccomodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccomodid
            
            #add-point:AFTER FIELD xccomodid name="construct.a.page2.xccomodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccomoddt
            #add-point:BEFORE FIELD xccomoddt name="construct.b.page2.xccomoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xccocnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccocnfid
            #add-point:ON ACTION controlp INFIELD xccocnfid name="construct.c.page2.xccocnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccocnfid  #顯示到畫面上
            NEXT FIELD xccocnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccocnfid
            #add-point:BEFORE FIELD xccocnfid name="construct.b.page2.xccocnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccocnfid
            
            #add-point:AFTER FIELD xccocnfid name="construct.a.page2.xccocnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccocnfdt
            #add-point:BEFORE FIELD xccocnfdt name="construct.b.page2.xccocnfdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xccopstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccopstid
            #add-point:ON ACTION controlp INFIELD xccopstid name="construct.c.page2.xccopstid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccopstid  #顯示到畫面上
            NEXT FIELD xccopstid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccopstid
            #add-point:BEFORE FIELD xccopstid name="construct.b.page2.xccopstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccopstid
            
            #add-point:AFTER FIELD xccopstid name="construct.a.page2.xccopstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccopstdt
            #add-point:BEFORE FIELD xccopstdt name="construct.b.page2.xccopstdt"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog name="cs.before_dialog"
         LET g_xcco_d[1].xcco006 = ""
         DISPLAY ARRAY g_xcco_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
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
 
{<section id="axct310.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axct310_query()
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
   CALL g_xcco_d.clear()
   CALL g_xcco2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL axct310_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axct310_browser_fill(g_wc)
      CALL axct310_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL axct310_browser_fill("F")
   
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
      CALL axct310_fetch("F") 
   END IF
   
   CALL axct310_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="axct310.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axct310_fetch(p_flag)
   #add-point:fetch段define name="fetch.define_customerization"
   
   #end add-point   
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fetch.before_fetch"
   
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
   
   #CALL axct310_browser_fill(p_flag)
   
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
   
   LET g_xcco_m.xccold = g_browser[g_current_idx].b_xccold
   LET g_xcco_m.xcco003 = g_browser[g_current_idx].b_xcco003
   LET g_xcco_m.xcco004 = g_browser[g_current_idx].b_xcco004
   LET g_xcco_m.xcco005 = g_browser[g_current_idx].b_xcco005
   LET g_xcco_m.xcco009 = g_browser[g_current_idx].b_xcco009
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axct310_master_referesh USING g_xcco_m.xccold,g_xcco_m.xcco003,g_xcco_m.xcco004,g_xcco_m.xcco005, 
       g_xcco_m.xcco009 INTO g_xcco_m.xccocomp,g_xcco_m.xcco004,g_xcco_m.xcco005,g_xcco_m.xccold,g_xcco_m.xcco003, 
       g_xcco_m.xcco009,g_xcco_m.xcco010,g_xcco_m.xccocomp_desc,g_xcco_m.xccold_desc,g_xcco_m.xcco003_desc 
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcco_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_xcco_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_xcco_m_mask_o.* =  g_xcco_m.*
   CALL axct310_xcco_t_mask()
   LET g_xcco_m_mask_n.* =  g_xcco_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axct310_set_act_visible()
   CALL axct310_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_xcco_m_t.* = g_xcco_m.*
   LET g_xcco_m_o.* = g_xcco_m.*
   
   #重新顯示   
   CALL axct310_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axct310.insert" >}
#+ 資料新增
PRIVATE FUNCTION axct310_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_xcco_d.clear()
   CALL g_xcco2_d.clear()
 
 
   INITIALIZE g_xcco_m.* TO NULL             #DEFAULT 設定
   LET g_xccold_t = NULL
   LET g_xcco003_t = NULL
   LET g_xcco004_t = NULL
   LET g_xcco005_t = NULL
   LET g_xcco009_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
            LET g_xcco_m.xcco010 = "1"
 
     
      #add-point:單頭預設值 name="insert.default"
      CALL g_xcco1_d.clear()
      CALL g_xcco3_d.clear()
      #end add-point 
 
      CALL axct310_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_xcco_m.* TO NULL
         INITIALIZE g_xcco_d TO NULL
         INITIALIZE g_xcco2_d TO NULL
 
         CALL axct310_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xcco_m.* = g_xcco_m_t.*
         CALL axct310_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_xcco_d.clear()
      #CALL g_xcco2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axct310_set_act_visible()
   CALL axct310_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xccold_t = g_xcco_m.xccold
   LET g_xcco003_t = g_xcco_m.xcco003
   LET g_xcco004_t = g_xcco_m.xcco004
   LET g_xcco005_t = g_xcco_m.xcco005
   LET g_xcco009_t = g_xcco_m.xcco009
 
   
   #組合新增資料的條件
   LET g_add_browse = " xccoent = " ||g_enterprise|| " AND",
                      " xccold = '", g_xcco_m.xccold, "' "
                      ," AND xcco003 = '", g_xcco_m.xcco003, "' "
                      ," AND xcco004 = '", g_xcco_m.xcco004, "' "
                      ," AND xcco005 = '", g_xcco_m.xcco005, "' "
                      ," AND xcco009 = '", g_xcco_m.xcco009, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axct310_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL axct310_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axct310_master_referesh USING g_xcco_m.xccold,g_xcco_m.xcco003,g_xcco_m.xcco004,g_xcco_m.xcco005, 
       g_xcco_m.xcco009 INTO g_xcco_m.xccocomp,g_xcco_m.xcco004,g_xcco_m.xcco005,g_xcco_m.xccold,g_xcco_m.xcco003, 
       g_xcco_m.xcco009,g_xcco_m.xcco010,g_xcco_m.xccocomp_desc,g_xcco_m.xccold_desc,g_xcco_m.xcco003_desc 
 
   
   #遮罩相關處理
   LET g_xcco_m_mask_o.* =  g_xcco_m.*
   CALL axct310_xcco_t_mask()
   LET g_xcco_m_mask_n.* =  g_xcco_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xcco_m.xccocomp,g_xcco_m.xccocomp_desc,g_xcco_m.xcco004,g_xcco_m.xcco005,g_xcco_m.xccold, 
       g_xcco_m.xccold_desc,g_xcco_m.xcco003,g_xcco_m.xcco003_desc,g_xcco_m.xcco009,g_xcco_m.xcco010 
 
   
   #功能已完成,通報訊息中心
   CALL axct310_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axct310.modify" >}
#+ 資料修改
PRIVATE FUNCTION axct310_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_xcco_m.xccold IS NULL
   OR g_xcco_m.xcco003 IS NULL
   OR g_xcco_m.xcco004 IS NULL
   OR g_xcco_m.xcco005 IS NULL
   OR g_xcco_m.xcco009 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_xccold_t = g_xcco_m.xccold
   LET g_xcco003_t = g_xcco_m.xcco003
   LET g_xcco004_t = g_xcco_m.xcco004
   LET g_xcco005_t = g_xcco_m.xcco005
   LET g_xcco009_t = g_xcco_m.xcco009
 
   CALL s_transaction_begin()
   
   OPEN axct310_cl USING g_enterprise,g_xcco_m.xccold,g_xcco_m.xcco003,g_xcco_m.xcco004,g_xcco_m.xcco005,g_xcco_m.xcco009
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axct310_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axct310_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axct310_master_referesh USING g_xcco_m.xccold,g_xcco_m.xcco003,g_xcco_m.xcco004,g_xcco_m.xcco005, 
       g_xcco_m.xcco009 INTO g_xcco_m.xccocomp,g_xcco_m.xcco004,g_xcco_m.xcco005,g_xcco_m.xccold,g_xcco_m.xcco003, 
       g_xcco_m.xcco009,g_xcco_m.xcco010,g_xcco_m.xccocomp_desc,g_xcco_m.xccold_desc,g_xcco_m.xcco003_desc 
 
   
   #遮罩相關處理
   LET g_xcco_m_mask_o.* =  g_xcco_m.*
   CALL axct310_xcco_t_mask()
   LET g_xcco_m_mask_n.* =  g_xcco_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL axct310_show()
   WHILE TRUE
      LET g_xccold_t = g_xcco_m.xccold
      LET g_xcco003_t = g_xcco_m.xcco003
      LET g_xcco004_t = g_xcco_m.xcco004
      LET g_xcco005_t = g_xcco_m.xcco005
      LET g_xcco009_t = g_xcco_m.xcco009
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL axct310_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xcco_m.* = g_xcco_m_t.*
         CALL axct310_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_xcco_m.xccold != g_xccold_t 
      OR g_xcco_m.xcco003 != g_xcco003_t 
      OR g_xcco_m.xcco004 != g_xcco004_t 
      OR g_xcco_m.xcco005 != g_xcco005_t 
      OR g_xcco_m.xcco009 != g_xcco009_t 
 
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
   CALL axct310_set_act_visible()
   CALL axct310_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xccoent = " ||g_enterprise|| " AND",
                      " xccold = '", g_xcco_m.xccold, "' "
                      ," AND xcco003 = '", g_xcco_m.xcco003, "' "
                      ," AND xcco004 = '", g_xcco_m.xcco004, "' "
                      ," AND xcco005 = '", g_xcco_m.xcco005, "' "
                      ," AND xcco009 = '", g_xcco_m.xcco009, "' "
 
   #填到對應位置
   CALL axct310_browser_fill("")
 
   CALL axct310_idx_chk()
 
   CLOSE axct310_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axct310_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="axct310.input" >}
#+ 資料輸入
PRIVATE FUNCTION axct310_input(p_cmd)
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
   DEFINE  l_date                DATE
   DEFINE  l_glaa003             LIKE glaa_t.glaa003
   DEFINE l_rate                 LIKE apca_t.apca101
   DEFINE l_errno            LIKE gzze_t.gzze001
   DEFINE l_imaa005              LIKE imaa_t.imaa005       #150724-00005#1 add
   DEFINE l_success              LIKE type_t.num5          #150724-00005#1 add
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
   DISPLAY BY NAME g_xcco_m.xccocomp,g_xcco_m.xccocomp_desc,g_xcco_m.xcco004,g_xcco_m.xcco005,g_xcco_m.xccold, 
       g_xcco_m.xccold_desc,g_xcco_m.xcco003,g_xcco_m.xcco003_desc,g_xcco_m.xcco009,g_xcco_m.xcco010 
 
   
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
   LET g_forupd_sql = "SELECT xcco001,xcco006,xcco007,xcco002,xcco008,xcco011,xcco102a,xcco102b,xcco102c, 
       xcco102d,xcco102e,xcco102f,xcco102g,xcco102h,xcco102,xcco001,xcco006,xcco007,xcco002,xcco008, 
       xccoownid,xccoowndp,xccocrtid,xccocrtdp,xccocrtdt,xccomodid,xccomoddt,xccocnfid,xccocnfdt,xccopstid, 
       xccopstdt FROM xcco_t WHERE xccoent=? AND xccold=? AND xcco003=? AND xcco004=? AND xcco005=?  
       AND xcco009=? AND xcco001=? AND xcco002=? AND xcco006=? AND xcco007=? AND xcco008=? FOR UPDATE" 
 
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axct310_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axct310_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axct310_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_xcco_m.xccocomp,g_xcco_m.xcco004,g_xcco_m.xcco005,g_xcco_m.xccold,g_xcco_m.xcco003, 
       g_xcco_m.xcco009,g_xcco_m.xcco010
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axct310.input.head" >}
   
      #單頭段
      INPUT BY NAME g_xcco_m.xccocomp,g_xcco_m.xcco004,g_xcco_m.xcco005,g_xcco_m.xccold,g_xcco_m.xcco003, 
          g_xcco_m.xcco009,g_xcco_m.xcco010 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:單頭input前 name="input.head.b_input"
            IF l_cmd_t = 'r' THEN
               LET g_xcco_m.xccold_desc = ""
               LET g_xcco_m.xccocomp_desc = ""
               LET g_xcco_m.xcco003_desc = ""
               DISPLAY BY NAME g_xcco_m.xccold_desc,g_xcco_m.xcco003_desc   
            END IF
            IF p_cmd = 'a' THEN
#fengmy-mark--begin----20150121
#               LET g_xcco_m.xccocomp = g_site
#               CALL s_fin_ld_carry('',g_user) 
#                RETURNING l_success,g_xcco_m.xccold,g_xcco_m.xccocomp,l_errno
#               CALL cl_get_para(g_enterprise,g_xcco_m.xccocomp,'S-FIN-6010') RETURNING g_xcco_m.xcco004
#               CALL cl_get_para(g_enterprise,g_xcco_m.xccocomp,'S-FIN-6011') RETURNING g_xcco_m.xcco005
#               DISPLAY BY NAME g_xcco_m.xcco004,g_xcco_m.xcco005 
#               
#               LET g_xcco_m.xccold = ''
#fengmy-mark--end----20150121
#fengmy---begin----20150121
#预设当前site的法人，主账套，年度期别，成本计算类型
               CALL s_axc_set_site_default() RETURNING g_xcco_m.xccocomp,g_xcco_m.xccold,g_xcco_m.xcco004,g_xcco_m.xcco005,g_xcco_m.xcco003
               DISPLAY BY NAME g_xcco_m.xccocomp,g_xcco_m.xccold,g_xcco_m.xcco004,g_xcco_m.xcco005,g_xcco_m.xcco003
               CALL axct310_get_xcco003_desc()
#fengmy---end------20150121
            #特性
            IF cl_get_para(g_enterprise,g_site,'S-FIN-6013') = 'N' THEN
               CALL cl_set_comp_visible('xcco007,xcco007_1,xcco007_3',FALSE)
            ELSE
               CALL cl_set_comp_visible('xcco007,xcco007_1,xcco007_3',TRUE)
            END IF
            #成本域
            IF cl_get_para(g_enterprise,g_site,'S-FIN-6001') = 'N' THEN
               CALL cl_set_comp_visible('xcco002,xcco002_1,xcco002_3',FALSE)
               CALL cl_set_comp_visible('xcco002_desc,xcco002_desc_1,xcco002_desc_3',FALSE)
            ELSE   
               CALL cl_set_comp_visible('xcco002,xcco002_1,xcco002_3',TRUE)
               CALL cl_set_comp_visible('xcco002_desc,xcco002_desc_1,xcco002_desc_3',TRUE)   
            END IF                  
               
               CALL axct310_get_xccold_desc()
               CALL axct310_get_xccocomp_desc()               
               CALL axct310_page_visible()
            END IF
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccocomp
            
            #add-point:AFTER FIELD xccocomp name="input.a.xccocomp"
            IF NOT cl_null(g_xcco_m.xccocomp) THEN 
               #檢查是否存在 組織基礎資料檔 中
               IF NOT ap_chk_isExist(g_xcco_m.xccocomp,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? ",'aoo-00094',1) THEN
                  LET g_xcco_m.xccocomp = g_xcco_m_t.xccocomp
                  CALL axct310_get_xccocomp_desc()                  
                  NEXT FIELD CURRENT
               END IF    
               
               #檢查是否 有效
#               IF NOT ap_chk_isExist(g_xcco_m.xccocomp,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? AND ooefstus = 'Y'",'aoo-00095',1) THEN   #160318-00005#47  mark
               IF NOT ap_chk_isExist(g_xcco_m.xccocomp,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? AND ooefstus = 'Y'",'sub-01302','aooi125') THEN   #160318-00005#47  add
                  LET g_xcco_m.xccocomp = g_xcco_m_t.xccocomp
                  CALL axct310_get_xccocomp_desc()                  
                  NEXT FIELD CURRENT
               END IF 
               
               #檢查是否為 法人
#               IF NOT ap_chk_isExist(g_xcco_m.xccocomp,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? AND ooefstus = 'Y' AND ooef003 = 'Y'",'aoo-00095',1) THEN   #160318-00005#47  mark
               IF NOT ap_chk_isExist(g_xcco_m.xccocomp,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? AND ooefstus = 'Y' AND ooef003 = 'Y'",'sub-01302','aooi125') THEN   #160318-00005#47  add
                  LET g_xcco_m.xccocomp = g_xcco_m_t.xccocomp
                  CALL axct310_get_xccocomp_desc()                  
                  NEXT FIELD CURRENT
               END IF              

#               #檢查組織類型是否為 法人組織
#               IF NOT ap_chk_isExist(g_xcco_m.xccocomp,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? AND ooefstus = 'Y' AND ooef003 = 'Y'",'apm-00250',1) THEN
#                  LET g_xcco_m.xccocomp = g_xcco_m_t.xccocomp
#                  CALL axct310_get_xccocomp_desc()                  
#                  NEXT FIELD CURRENT
#               END IF  
               
               #帳套不為空時，檢查該法人下是否有此帳套
               IF NOT cl_null(g_xcco_m.xccold) THEN
                  IF NOT ap_chk_isExist(g_xcco_m.xccocomp,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaacomp = ? AND glaastus = 'Y' AND glaald = '" ||g_xcco_m.xccold|| "'",'axc-00224',1) THEN
                     LET g_xcco_m.xccocomp = g_xcco_m_t.xccocomp
                     CALL axct310_get_xccocomp_desc()                  
                     NEXT FIELD CURRENT
                  END IF   
               END IF
            END IF
            
            CALL axct310_get_xccocomp_desc()   
            
            IF p_cmd = 'a' AND NOT cl_null(g_xcco_m.xccocomp) THEN
               CALL cl_get_para(g_enterprise,g_xcco_m.xccocomp,'S-FIN-6010') RETURNING g_xcco_m.xcco004
               CALL cl_get_para(g_enterprise,g_xcco_m.xccocomp,'S-FIN-6011') RETURNING g_xcco_m.xcco005
               DISPLAY BY NAME g_xcco_m.xcco004,g_xcco_m.xcco005
            END IF
            
            #特性
            IF cl_get_para(g_enterprise,g_site,'S-FIN-6013') = 'N' THEN
               CALL cl_set_comp_visible('xcco007,xcco007_1,xcco007_3',FALSE)
            ELSE
               CALL cl_set_comp_visible('xcco007,xcco007_1,xcco007_3',TRUE)
            END IF
            #成本域
            IF cl_get_para(g_enterprise,g_site,'S-FIN-6001') = 'N' THEN
               CALL cl_set_comp_visible('xcco002,xcco002_1,xcco002_3',FALSE)
               CALL cl_set_comp_visible('xcco002_desc,xcco002_desc_1,xcco002_desc_3',FALSE)
            ELSE   
               CALL cl_set_comp_visible('xcco002,xcco002_1,xcco002_3',TRUE)
               CALL cl_set_comp_visible('xcco002_desc,xcco002_desc_1,xcco002_desc_3',TRUE)   
            END IF                   
            
#            IF NOT cl_null(g_xcco_m.xcco004) AND NOT cl_null(g_xcco_m.xccocomp) THEN  
#                  #檢查年度不小於成本關賬日期的年度
#                  CALL cl_get_para(g_enterprise,g_xcco_m.xccocomp,'S-FIN-6012') RETURNING l_date 
#                  IF g_xcco_m.xcco004 < YEAR(l_date) THEN 
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = 'axc-00226'
#                     LET g_errparam.extend = ''
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     NEXT FIELD xcco004
#                  END IF     
#            END IF 

#            IF NOT cl_null(g_xcco_m.xcco005) AND NOT cl_null(g_xcco_m.xccocomp) THEN  
#                  #檢查期別不小於成本關賬日期的月份
#                  CALL cl_get_para(g_enterprise,g_xcco_m.xccocomp,'S-FIN-6012') RETURNING l_date 
#                  IF g_xcco_m.xcco005 <= MONTH(l_date) THEN 
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = 'axc-00226'
#                     LET g_errparam.extend = ''
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     NEXT FIELD xcco005
#                  END IF            
#            END IF
            




            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccocomp
            #add-point:BEFORE FIELD xccocomp name="input.b.xccocomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccocomp
            #add-point:ON CHANGE xccocomp name="input.g.xccocomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco004
            #add-point:BEFORE FIELD xcco004 name="input.b.xcco004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco004
            
            #add-point:AFTER FIELD xcco004 name="input.a.xcco004"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_xcco_m.xccold) AND NOT cl_null(g_xcco_m.xcco003) AND NOT cl_null(g_xcco_m.xcco004) AND NOT cl_null(g_xcco_m.xcco005) AND NOT cl_null(g_xcco_m.xcco009) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcco_m.xccold != g_xccold_t OR g_xcco_m.xcco003 != g_xcco003_t  OR g_xcco_m.xcco004 != g_xcco004_t  OR g_xcco_m.xcco005 != g_xcco005_t  OR g_xcco_m.xcco009 != g_xcco009_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcco_t WHERE "||"xccoent = '" ||g_enterprise|| "' AND "||"xccold = '"||g_xcco_m.xccold ||"' AND "|| "xcco003 = '"||g_xcco_m.xcco003 ||"' AND "|| "xcco004 = '"||g_xcco_m.xcco004 ||"' AND "|| "xcco005 = '"||g_xcco_m.xcco005 ||"' AND "|| "xcco009 = '"||g_xcco_m.xcco009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            IF NOT cl_null(g_xcco_m.xcco004) THEN  
               IF NOT s_fin_date_chk_year(g_xcco_m.xcco004) THEN
                  LET g_xcco_m.xcco004 = g_xcco004_t
                  DISPLAY BY NAME g_xcco_m.xcco004
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00113'
                  LET g_errparam.extend = g_xcco_m.xcco004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT                          
               END IF            
            END IF
            
            IF NOT cl_null(g_xcco_m.xcco004) AND NOT cl_null(g_xcco_m.xccocomp) THEN  
                  #檢查年度不小於成本關賬日期的年度
                  CALL cl_get_para(g_enterprise,g_xcco_m.xccocomp,'S-FIN-6012') RETURNING l_date 
                  IF g_xcco_m.xcco004 < YEAR(l_date) THEN 
                     LET g_xcco_m.xcco004 = g_xcco004_t
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axc-00226'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD CURRENT
                  END IF     
            END IF      

            IF NOT cl_null(g_xcco_m.xcco004) AND NOT cl_null(g_xcco_m.xcco005) AND NOT cl_null(g_xcco_m.xccold) THEN
               SELECT glaa003 INTO l_glaa003 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xcco_m.xccold 
               CALL s_fin_date_get_period_range(l_glaa003,g_xcco_m.xcco004,g_xcco_m.xcco005)
                   RETURNING g_bdate,g_edate               
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcco004
            #add-point:ON CHANGE xcco004 name="input.g.xcco004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco005
            #add-point:BEFORE FIELD xcco005 name="input.b.xcco005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco005
            
            #add-point:AFTER FIELD xcco005 name="input.a.xcco005"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_xcco_m.xccold) AND NOT cl_null(g_xcco_m.xcco003) AND NOT cl_null(g_xcco_m.xcco004) AND NOT cl_null(g_xcco_m.xcco005) AND NOT cl_null(g_xcco_m.xcco009) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcco_m.xccold != g_xccold_t OR g_xcco_m.xcco003 != g_xcco003_t  OR g_xcco_m.xcco004 != g_xcco004_t  OR g_xcco_m.xcco005 != g_xcco005_t  OR g_xcco_m.xcco009 != g_xcco009_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcco_t WHERE "||"xccoent = '" ||g_enterprise|| "' AND "||"xccold = '"||g_xcco_m.xccold ||"' AND "|| "xcco003 = '"||g_xcco_m.xcco003 ||"' AND "|| "xcco004 = '"||g_xcco_m.xcco004 ||"' AND "|| "xcco005 = '"||g_xcco_m.xcco005 ||"' AND "|| "xcco009 = '"||g_xcco_m.xcco009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            IF NOT cl_null(g_xcco_m.xcco005) THEN 
               IF g_xcco_m.xcco005 < 1 OR g_xcco_m.xcco005 > 13 THEN
                  LET g_xcco_m.xcco005 = g_xcco005_t
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00106'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT          
               END IF
            END IF
            IF NOT cl_null(g_xcco_m.xcco005) AND NOT cl_null(g_xcco_m.xccold) THEN  
               SELECT glaa003 INTO l_glaa003 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xcco_m.xccold 
               
               IF NOT s_fin_date_chk_period(l_glaa003,g_xcco_m.xcco004,g_xcco_m.xcco005) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00119'
                  LET g_errparam.extend = g_xcco_m.xcco005
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xcco_m.xcco005 = g_xcco005_t
                  DISPLAY BY NAME g_xcco_m.xcco005
                  NEXT FIELD CURRENT                    
               END IF
            END IF
            
            IF NOT cl_null(g_xcco_m.xcco005) AND NOT cl_null(g_xcco_m.xccocomp) THEN  
                  #檢查期別不小於成本關賬日期的月份
                  CALL cl_get_para(g_enterprise,g_xcco_m.xccocomp,'S-FIN-6012') RETURNING l_date 
                  IF g_xcco_m.xcco004 = YEAR(l_date) THEN   #fengmy150121
                  IF g_xcco_m.xcco005 <= MONTH(l_date) THEN 
                     LET g_xcco_m.xcco005 = g_xcco005_t
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axc-00226'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD CURRENT
                  END IF 
                  END IF       #fengmy150121                  
            END IF
            
            IF NOT cl_null(g_xcco_m.xcco004) AND NOT cl_null(g_xcco_m.xcco005) AND NOT cl_null(g_xcco_m.xccold) THEN
               SELECT glaa003 INTO l_glaa003 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xcco_m.xccold 
               CALL s_fin_date_get_period_range(l_glaa003,g_xcco_m.xcco004,g_xcco_m.xcco005)
                   RETURNING g_bdate,g_edate               
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcco005
            #add-point:ON CHANGE xcco005 name="input.g.xcco005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccold
            
            #add-point:AFTER FIELD xccold name="input.a.xccold"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_xcco_m.xccold) AND NOT cl_null(g_xcco_m.xcco003) AND NOT cl_null(g_xcco_m.xcco004) AND NOT cl_null(g_xcco_m.xcco005) AND NOT cl_null(g_xcco_m.xcco009) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcco_m.xccold != g_xccold_t  OR g_xcco_m.xcco003 != g_xcco003_t  OR g_xcco_m.xcco004 != g_xcco004_t  OR g_xcco_m.xcco005 != g_xcco005_t  OR g_xcco_m.xcco009 != g_xcco009_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcco_t WHERE "||"xccoent = '" ||g_enterprise|| "' AND "||"xccold = '"||g_xcco_m.xccold ||"' AND "|| "xcco003 = '"||g_xcco_m.xcco003 ||"' AND "|| "xcco004 = '"||g_xcco_m.xcco004 ||"' AND "|| "xcco005 = '"||g_xcco_m.xcco005 ||"' AND "|| "xcco009 = '"||g_xcco_m.xcco009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_xcco_m.xccold) THEN
               #檢查是否存在 帳別資料檔 中
               IF NOT ap_chk_isExist(g_xcco_m.xccold,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? ",'agl-00016',1) THEN
                  LET g_xcco_m.xccold = g_xccold_t
                  CALL axct310_get_xccold_desc()                  
                  NEXT FIELD CURRENT
               END IF   
               
               #檢查是否 有效
#               IF NOT ap_chk_isExist(g_xcco_m.xccold,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND glaastus = 'Y'",'agl-00051',1) THEN   #160318-00005#47  mark
               IF NOT ap_chk_isExist(g_xcco_m.xccold,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND glaastus = 'Y'",'sub-01302','agli010') THEN   #160318-00005#47  madd
                  LET g_xcco_m.xccold = g_xccold_t
                  CALL axct310_get_xccold_desc()                  
                  NEXT FIELD CURRENT
               END IF   
               
               #法人不為空時，檢查 帳別編號需為法人組織的下属帳套
               IF NOT cl_null(g_xcco_m.xccocomp) THEN
                  IF NOT ap_chk_isExist(g_xcco_m.xccold,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND glaastus = 'Y' AND glaacomp = '" ||g_xcco_m.xccocomp|| "'",'axc-00225',1) THEN
                     LET g_xcco_m.xccold = g_xccold_t
                     CALL axct310_get_xccold_desc()                  
                     NEXT FIELD CURRENT
                  END IF   
               END IF
               
               #檢查權限
               IF NOT s_ld_chk_authorization(g_user,g_xcco_m.xccold) THEN
                  CALL axct310_get_xccold_desc()
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00165'
                  LET g_errparam.extend = g_xcco_m.xccold
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  CALL axct310_get_xccold_desc()                  
                  NEXT FIELD CURRENT
               END IF
            END IF

            CALL axct310_get_xccold_desc() 
            
            #當輸入了帳套后，法人為空，則自動帶出帳套的歸屬法人
            IF cl_null(g_xcco_m.xccocomp) THEN
               SELECT glaacomp INTO g_xcco_m.xccocomp FROM glaa_t
                WHERE glaaent = g_enterprise
                  AND glaald = g_xcco_m.xccold
               CALL axct310_get_xccocomp_desc()   
               DISPLAY BY NAME g_xcco_m.xccold   
            END IF
            
            IF NOT cl_null(g_xcco_m.xcco005) AND NOT cl_null(g_xcco_m.xccold) THEN  
               SELECT glaa003 INTO l_glaa003 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xcco_m.xccold 
               
               IF NOT s_fin_date_chk_period(l_glaa003,g_xcco_m.xcco004,g_xcco_m.xcco005) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00119'
                  LET g_errparam.extend = g_xcco_m.xcco005
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xcco_m.xcco005 = g_xcco005_t
                  DISPLAY BY NAME g_xcco_m.xcco005
                  NEXT FIELD xcco005                    
               END IF
            END IF
            
            IF p_cmd = 'a' AND NOT cl_null(g_xcco_m.xccocomp) THEN
               CALL cl_get_para(g_enterprise,g_xcco_m.xccocomp,'S-FIN-6010') RETURNING g_xcco_m.xcco004
               CALL cl_get_para(g_enterprise,g_xcco_m.xccocomp,'S-FIN-6011') RETURNING g_xcco_m.xcco005
               DISPLAY BY NAME g_xcco_m.xcco004,g_xcco_m.xcco005
            END IF
            
        
            
            CALL axct310_page_visible()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccold
            #add-point:BEFORE FIELD xccold name="input.b.xccold"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccold
            #add-point:ON CHANGE xccold name="input.g.xccold"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco003
            
            #add-point:AFTER FIELD xcco003 name="input.a.xcco003"

            #此段落由子樣板a05產生
            IF  NOT cl_null(g_xcco_m.xccold) AND NOT cl_null(g_xcco_m.xcco003) AND NOT cl_null(g_xcco_m.xcco004) AND NOT cl_null(g_xcco_m.xcco005) AND NOT cl_null(g_xcco_m.xcco009) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcco_m.xccold != g_xccold_t OR g_xcco_m.xcco003 != g_xcco003_t  OR g_xcco_m.xcco004 != g_xcco004_t  OR g_xcco_m.xcco005 != g_xcco005_t  OR g_xcco_m.xcco009 != g_xcco009_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcco_t WHERE "||"xccoent = '" ||g_enterprise|| "' AND "||"xccold = '"||g_xcco_m.xccold ||"' AND "|| "xcco003 = '"||g_xcco_m.xcco003 ||"' AND "|| "xcco004 = '"||g_xcco_m.xcco004 ||"' AND "|| "xcco005 = '"||g_xcco_m.xcco005 ||"' AND "|| "xcco009 = '"||g_xcco_m.xcco009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_xcco_m.xcco003) THEN 
               #檢查是否存在于 成本類型設置檔 中
               IF NOT ap_chk_isExist(g_xcco_m.xcco003,"SELECT COUNT(*) FROM xcat_t WHERE "||"xcatent = '" ||g_enterprise|| "' AND "||"xcat001 = ? ",'agl-00194',1) THEN
                  LET g_xcco_m.xcco003 = g_xcco003_t
                  CALL axct310_get_xcco003_desc()                  
                  NEXT FIELD CURRENT
               END IF
               
               #檢查是否 有效
#               IF NOT ap_chk_isExist(g_xcco_m.xcco003,"SELECT COUNT(*) FROM xcat_t WHERE "||"xcatent = '" ||g_enterprise|| "' AND "||"xcat001 = ? AND xcatstus = 'Y' ",'agl-00195',1) THEN   #160318-00005#47  mark
               IF NOT ap_chk_isExist(g_xcco_m.xcco003,"SELECT COUNT(*) FROM xcat_t WHERE "||"xcatent = '" ||g_enterprise|| "' AND "||"xcat001 = ? AND xcatstus = 'Y' ",'sub-01302','axci100') THEN   #160318-00005#47  add
                  LET g_xcco_m.xcco003 = g_xcco003_t
                  CALL axct310_get_xcco003_desc()                  
                  NEXT FIELD CURRENT
               END IF            
            END IF
            
            CALL axct310_get_xcco003_desc() 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco003
            #add-point:BEFORE FIELD xcco003 name="input.b.xcco003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcco003
            #add-point:ON CHANGE xcco003 name="input.g.xcco003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco009
            #add-point:BEFORE FIELD xcco009 name="input.b.xcco009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco009
            
            #add-point:AFTER FIELD xcco009 name="input.a.xcco009"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_xcco_m.xccold) AND NOT cl_null(g_xcco_m.xcco003) AND NOT cl_null(g_xcco_m.xcco004) AND NOT cl_null(g_xcco_m.xcco005) AND NOT cl_null(g_xcco_m.xcco009) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcco_m.xccold != g_xccold_t  OR g_xcco_m.xcco003 != g_xcco003_t  OR g_xcco_m.xcco004 != g_xcco004_t  OR g_xcco_m.xcco005 != g_xcco005_t  OR g_xcco_m.xcco009 != g_xcco009_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcco_t WHERE "||"xccoent = '" ||g_enterprise|| "' AND "||"xccold = '"||g_xcco_m.xccold ||"' AND "|| "xcco003 = '"||g_xcco_m.xcco003 ||"' AND "|| "xcco004 = '"||g_xcco_m.xcco004 ||"' AND "|| "xcco005 = '"||g_xcco_m.xcco005 ||"' AND "|| "xcco009 = '"||g_xcco_m.xcco009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcco009
            #add-point:ON CHANGE xcco009 name="input.g.xcco009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco010
            #add-point:BEFORE FIELD xcco010 name="input.b.xcco010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco010
            
            #add-point:AFTER FIELD xcco010 name="input.a.xcco010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcco010
            #add-point:ON CHANGE xcco010 name="input.g.xcco010"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xccocomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccocomp
            #add-point:ON ACTION controlp INFIELD xccocomp name="input.c.xccocomp"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcco_m.xccocomp             #給予default值
           
            #帳套不為空時，法人組織開窗開帳套歸屬法人的法人組織
            IF NOT cl_null(g_xcco_m.xccold) THEN
               LET g_qryparam.where = " ooef017 = (SELECT glaacomp FROM glaa_t",
                                      "  WHERE glaaent = '",g_enterprise,"' AND glaald = '",g_xcco_m.xccold,"' )"
            END IF
            
            #mod--161013-00051#1 By shiun--(S)
#            CALL q_ooef001_8()                                #呼叫開窗
            CALL q_ooef001_2()
            #mod--161013-00051#1 By shiun--(E)

            LET g_xcco_m.xccocomp = g_qryparam.return1              
 
            CALL axct310_get_xccocomp_desc()
 
            DISPLAY g_xcco_m.xccocomp TO xccocomp 
            DISPLAY g_xcco_m.xccocomp_desc TO xccocomp_desc              #
 
            IF p_cmd = 'a' AND NOT cl_null(g_xcco_m.xccocomp) THEN
               CALL cl_get_para(g_enterprise,g_xcco_m.xccocomp,'S-FIN-6010') RETURNING g_xcco_m.xcco004
               CALL cl_get_para(g_enterprise,g_xcco_m.xccocomp,'S-FIN-6011') RETURNING g_xcco_m.xcco005
               DISPLAY BY NAME g_xcco_m.xcco004,g_xcco_m.xcco005
            END IF
            
            LET g_qryparam.where = "" 
   
            NEXT FIELD xccocomp                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcco004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco004
            #add-point:ON ACTION controlp INFIELD xcco004 name="input.c.xcco004"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcco005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco005
            #add-point:ON ACTION controlp INFIELD xcco005 name="input.c.xcco005"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccold
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccold
            #add-point:ON ACTION controlp INFIELD xccold name="input.c.xccold"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcco_m.xccold             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            
            #法人不為空時，帳套開窗開此法人的下屬帳套
            IF NOT cl_null(g_xcco_m.xccocomp) THEN
               LET g_qryparam.where = " glaacomp = '",g_xcco_m.xccocomp,"'"
            END IF
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xcco_m.xccold = g_qryparam.return1              

            CALL axct310_get_xccold_desc()
            
            DISPLAY g_xcco_m.xccold TO xccold
            DISPLAY g_xcco_m.xccold_desc TO xccold_desc              #

            NEXT FIELD xccold                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcco003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco003
            #add-point:ON ACTION controlp INFIELD xcco003 name="input.c.xcco003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcco_m.xcco003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_xcat001()                                #呼叫開窗

            LET g_xcco_m.xcco003 = g_qryparam.return1              

            CALL axct310_get_xcco003_desc()
            DISPLAY g_xcco_m.xcco003 TO xcco003 
            DISPLAY g_xcco_m.xcco003_desc TO xcco003_desc              #

            NEXT FIELD xcco003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcco009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco009
            #add-point:ON ACTION controlp INFIELD xcco009 name="input.c.xcco009"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcco010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco010
            #add-point:ON ACTION controlp INFIELD xcco010 name="input.c.xcco010"
            
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
            DISPLAY BY NAME g_xcco_m.xccold             
                            ,g_xcco_m.xcco003   
                            ,g_xcco_m.xcco004   
                            ,g_xcco_m.xcco005   
                            ,g_xcco_m.xcco009   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               #fengmy150121--begin
               IF NOT cl_null(g_xcco_m.xcco004) AND NOT cl_null(g_xcco_m.xccocomp) AND NOT cl_null(g_xcco_m.xcco005) THEN
                  #檢查年度不小於成本關賬日期的年度
                  CALL cl_get_para(g_enterprise,g_xcco_m.xccocomp,'S-FIN-6012') RETURNING l_date
                  IF g_xcco_m.xcco004 < YEAR(l_date) THEN
                     LET g_xcco_m.xcco004 = g_xcco004_t
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axc-00226'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     NEXT FIELD xcco004
                  ELSE
                     IF g_xcco_m.xcco004 = YEAR(l_date)  THEN   
                        IF g_xcco_m.xcco005 <= MONTH(l_date) THEN
                           LET g_xcco_m.xcco005 = g_xcco005_t
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'axc-00226'
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                     
                           NEXT FIELD xcco005
                        END IF
                     END IF   
                  END IF
               END IF
               #fengmy150121--end
               #end add-point
            
               #將遮罩欄位還原
               CALL axct310_xcco_t_mask_restore('restore_mask_o')
            
               UPDATE xcco_t SET (xccocomp,xcco004,xcco005,xccold,xcco003,xcco009,xcco010) = (g_xcco_m.xccocomp, 
                   g_xcco_m.xcco004,g_xcco_m.xcco005,g_xcco_m.xccold,g_xcco_m.xcco003,g_xcco_m.xcco009, 
                   g_xcco_m.xcco010)
                WHERE xccoent = g_enterprise AND xccold = g_xccold_t
                  AND xcco003 = g_xcco003_t
                  AND xcco004 = g_xcco004_t
                  AND xcco005 = g_xcco005_t
                  AND xcco009 = g_xcco009_t
 
               #add-point:單頭修改中 name="input.head.m_update"
 
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcco_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcco_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcco_m.xccold
               LET gs_keys_bak[1] = g_xccold_t
               LET gs_keys[2] = g_xcco_m.xcco003
               LET gs_keys_bak[2] = g_xcco003_t
               LET gs_keys[3] = g_xcco_m.xcco004
               LET gs_keys_bak[3] = g_xcco004_t
               LET gs_keys[4] = g_xcco_m.xcco005
               LET gs_keys_bak[4] = g_xcco005_t
               LET gs_keys[5] = g_xcco_m.xcco009
               LET gs_keys_bak[5] = g_xcco009_t
               LET gs_keys[6] = g_xcco_d[g_detail_idx].xcco001
               LET gs_keys_bak[6] = g_xcco_d_t.xcco001
               LET gs_keys[7] = g_xcco_d[g_detail_idx].xcco002
               LET gs_keys_bak[7] = g_xcco_d_t.xcco002
               LET gs_keys[8] = g_xcco_d[g_detail_idx].xcco006
               LET gs_keys_bak[8] = g_xcco_d_t.xcco006
               LET gs_keys[9] = g_xcco_d[g_detail_idx].xcco007
               LET gs_keys_bak[9] = g_xcco_d_t.xcco007
               LET gs_keys[10] = g_xcco_d[g_detail_idx].xcco008
               LET gs_keys_bak[10] = g_xcco_d_t.xcco008
               CALL axct310_update_b('xcco_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_xcco_m_t)
                     #LET g_log2 = util.JSON.stringify(g_xcco_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL axct310_xcco_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               #fengmy150121--begin
               IF NOT cl_null(g_xcco_m.xcco004) AND NOT cl_null(g_xcco_m.xccocomp) AND NOT cl_null(g_xcco_m.xcco005) THEN
                  #檢查年度不小於成本關賬日期的年度
                  CALL cl_get_para(g_enterprise,g_xcco_m.xccocomp,'S-FIN-6012') RETURNING l_date
                  IF g_xcco_m.xcco004 < YEAR(l_date) THEN
                     LET g_xcco_m.xcco004 = g_xcco004_t
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axc-00226'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     NEXT FIELD xcco004
                  ELSE
                     IF g_xcco_m.xcco004 = YEAR(l_date)  THEN   
                        IF g_xcco_m.xcco005 <= MONTH(l_date) THEN
                           LET g_xcco_m.xcco005 = g_xcco005_t
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'axc-00226'
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                     
                           NEXT FIELD xcco005
                        END IF
                     END IF   
                  END IF
               END IF
               #fengmy150121--end
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axct310_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_xccold_t = g_xcco_m.xccold
           LET g_xcco003_t = g_xcco_m.xcco003
           LET g_xcco004_t = g_xcco_m.xcco004
           LET g_xcco005_t = g_xcco_m.xcco005
           LET g_xcco009_t = g_xcco_m.xcco009
 
           
           IF g_xcco_d.getLength() = 0 THEN
              NEXT FIELD xcco001
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="axct310.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_xcco_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xcco_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axct310_b_fill(g_wc2) #test 
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
            CALL axct310_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axct310_cl USING g_enterprise,g_xcco_m.xccold,g_xcco_m.xcco003,g_xcco_m.xcco004,g_xcco_m.xcco005,g_xcco_m.xcco009                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE axct310_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axct310_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_xcco_d[l_ac].xcco001 IS NOT NULL
               AND g_xcco_d[l_ac].xcco002 IS NOT NULL
               AND g_xcco_d[l_ac].xcco006 IS NOT NULL
               AND g_xcco_d[l_ac].xcco007 IS NOT NULL
               AND g_xcco_d[l_ac].xcco008 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xcco_d_t.* = g_xcco_d[l_ac].*  #BACKUP
               LET g_xcco_d_o.* = g_xcco_d[l_ac].*  #BACKUP
               CALL axct310_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL axct310_set_no_entry_b(l_cmd)
               OPEN axct310_bcl USING g_enterprise,g_xcco_m.xccold,
                                                g_xcco_m.xcco003,
                                                g_xcco_m.xcco004,
                                                g_xcco_m.xcco005,
                                                g_xcco_m.xcco009,
 
                                                g_xcco_d_t.xcco001
                                                ,g_xcco_d_t.xcco002
                                                ,g_xcco_d_t.xcco006
                                                ,g_xcco_d_t.xcco007
                                                ,g_xcco_d_t.xcco008
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axct310_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axct310_bcl INTO g_xcco_d[l_ac].xcco001,g_xcco_d[l_ac].xcco006,g_xcco_d[l_ac].xcco007, 
                      g_xcco_d[l_ac].xcco002,g_xcco_d[l_ac].xcco008,g_xcco_d[l_ac].xcco011,g_xcco_d[l_ac].xcco102a, 
                      g_xcco_d[l_ac].xcco102b,g_xcco_d[l_ac].xcco102c,g_xcco_d[l_ac].xcco102d,g_xcco_d[l_ac].xcco102e, 
                      g_xcco_d[l_ac].xcco102f,g_xcco_d[l_ac].xcco102g,g_xcco_d[l_ac].xcco102h,g_xcco_d[l_ac].xcco102, 
                      g_xcco2_d[l_ac].xcco001,g_xcco2_d[l_ac].xcco006,g_xcco2_d[l_ac].xcco007,g_xcco2_d[l_ac].xcco002, 
                      g_xcco2_d[l_ac].xcco008,g_xcco2_d[l_ac].xccoownid,g_xcco2_d[l_ac].xccoowndp,g_xcco2_d[l_ac].xccocrtid, 
                      g_xcco2_d[l_ac].xccocrtdp,g_xcco2_d[l_ac].xccocrtdt,g_xcco2_d[l_ac].xccomodid, 
                      g_xcco2_d[l_ac].xccomoddt,g_xcco2_d[l_ac].xccocnfid,g_xcco2_d[l_ac].xccocnfdt, 
                      g_xcco2_d[l_ac].xccopstid,g_xcco2_d[l_ac].xccopstdt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xcco_d_t.xcco001,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xcco_d_mask_o[l_ac].* =  g_xcco_d[l_ac].*
                  CALL axct310_xcco_t_mask()
                  LET g_xcco_d_mask_n[l_ac].* =  g_xcco_d[l_ac].*
                  
                  CALL axct310_ref_show()
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
            INITIALIZE g_xcco_d_t.* TO NULL
            INITIALIZE g_xcco_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xcco_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xcco2_d[l_ac].xccoownid = g_user
      LET g_xcco2_d[l_ac].xccoowndp = g_dept
      LET g_xcco2_d[l_ac].xccocrtid = g_user
      LET g_xcco2_d[l_ac].xccocrtdp = g_dept 
      LET g_xcco2_d[l_ac].xccocrtdt = cl_get_current()
      LET g_xcco2_d[l_ac].xccomodid = g_user
      LET g_xcco2_d[l_ac].xccomoddt = cl_get_current()
 
 
  
            #一般欄位預設值
                  LET g_xcco_d[l_ac].xcco001 = "1"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_xcco_d_t.* = g_xcco_d[l_ac].*     #新輸入資料
            LET g_xcco_d_o.* = g_xcco_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axct310_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL axct310_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xcco_d[li_reproduce_target].* = g_xcco_d[li_reproduce].*
               LET g_xcco2_d[li_reproduce_target].* = g_xcco2_d[li_reproduce].*
 
               LET g_xcco_d[g_xcco_d.getLength()].xcco001 = NULL
               LET g_xcco_d[g_xcco_d.getLength()].xcco002 = NULL
               LET g_xcco_d[g_xcco_d.getLength()].xcco006 = NULL
               LET g_xcco_d[g_xcco_d.getLength()].xcco007 = NULL
               LET g_xcco_d[g_xcco_d.getLength()].xcco008 = NULL
 
            END IF
            
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_xcco_d[l_ac].xcco001 = "1"
            #特性
            IF cl_get_para(g_enterprise,g_site,'S-FIN-6013') = 'N' THEN
               LET g_xcco_d[l_ac].xcco007 = ' '
               LET g_xcco1_d[l_ac].xcco007_1 = ' '
               LET g_xcco3_d[l_ac].xcco007_3 = ' '
            END IF
            #成本域
            IF cl_get_para(g_enterprise,g_site,'S-FIN-6001') = 'N' THEN
               LET g_xcco_d[l_ac].xcco002 = ' '
               LET g_xcco1_d[l_ac].xcco002_1 = ' '
               LET g_xcco3_d[l_ac].xcco002_3 = ' '
            END IF            
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
            SELECT COUNT(1) INTO l_count FROM xcco_t 
             WHERE xccoent = g_enterprise AND xccold = g_xcco_m.xccold
               AND xcco003 = g_xcco_m.xcco003
               AND xcco004 = g_xcco_m.xcco004
               AND xcco005 = g_xcco_m.xcco005
               AND xcco009 = g_xcco_m.xcco009
 
               AND xcco001 = g_xcco_d[l_ac].xcco001
               AND xcco002 = g_xcco_d[l_ac].xcco002
               AND xcco006 = g_xcco_d[l_ac].xcco006
               AND xcco007 = g_xcco_d[l_ac].xcco007
               AND xcco008 = g_xcco_d[l_ac].xcco008
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               IF cl_null(g_xcco_d[l_ac].xcco007) THEN
                  LET g_xcco_d[l_ac].xcco007 = ' '
               END IF
               IF cl_null(g_xcco_d[l_ac].xcco002) THEN
                  LET g_xcco_d[l_ac].xcco002 = ' '
               END IF               
               #end add-point
               INSERT INTO xcco_t
                           (xccoent,
                            xccocomp,xcco004,xcco005,xccold,xcco003,xcco009,xcco010,
                            xcco001,xcco002,xcco006,xcco007,xcco008
                            ,xcco011,xcco102a,xcco102b,xcco102c,xcco102d,xcco102e,xcco102f,xcco102g,xcco102h,xcco102,xccoownid,xccoowndp,xccocrtid,xccocrtdp,xccocrtdt,xccomodid,xccomoddt,xccocnfid,xccocnfdt,xccopstid,xccopstdt) 
                     VALUES(g_enterprise,
                            g_xcco_m.xccocomp,g_xcco_m.xcco004,g_xcco_m.xcco005,g_xcco_m.xccold,g_xcco_m.xcco003,g_xcco_m.xcco009,g_xcco_m.xcco010,
                            g_xcco_d[l_ac].xcco001,g_xcco_d[l_ac].xcco002,g_xcco_d[l_ac].xcco006,g_xcco_d[l_ac].xcco007, 
                                g_xcco_d[l_ac].xcco008
                            ,g_xcco_d[l_ac].xcco011,g_xcco_d[l_ac].xcco102a,g_xcco_d[l_ac].xcco102b, 
                                g_xcco_d[l_ac].xcco102c,g_xcco_d[l_ac].xcco102d,g_xcco_d[l_ac].xcco102e, 
                                g_xcco_d[l_ac].xcco102f,g_xcco_d[l_ac].xcco102g,g_xcco_d[l_ac].xcco102h, 
                                g_xcco_d[l_ac].xcco102,g_xcco2_d[l_ac].xccoownid,g_xcco2_d[l_ac].xccoowndp, 
                                g_xcco2_d[l_ac].xccocrtid,g_xcco2_d[l_ac].xccocrtdp,g_xcco2_d[l_ac].xccocrtdt, 
                                g_xcco2_d[l_ac].xccomodid,g_xcco2_d[l_ac].xccomoddt,g_xcco2_d[l_ac].xccocnfid, 
                                g_xcco2_d[l_ac].xccocnfdt,g_xcco2_d[l_ac].xccopstid,g_xcco2_d[l_ac].xccopstdt) 
 
               #add-point:單身新增中 name="input.body.m_insert"
               CALL axct310_ins_xcco()
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_xcco_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "xcco_t:",SQLERRMESSAGE 
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
               IF axct310_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_xcco_m.xccold
                  LET gs_keys[gs_keys.getLength()+1] = g_xcco_m.xcco003
                  LET gs_keys[gs_keys.getLength()+1] = g_xcco_m.xcco004
                  LET gs_keys[gs_keys.getLength()+1] = g_xcco_m.xcco005
                  LET gs_keys[gs_keys.getLength()+1] = g_xcco_m.xcco009
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xcco_d_t.xcco001
                  LET gs_keys[gs_keys.getLength()+1] = g_xcco_d_t.xcco002
                  LET gs_keys[gs_keys.getLength()+1] = g_xcco_d_t.xcco006
                  LET gs_keys[gs_keys.getLength()+1] = g_xcco_d_t.xcco007
                  LET gs_keys[gs_keys.getLength()+1] = g_xcco_d_t.xcco008
 
 
                  #刪除下層單身
                  IF NOT axct310_key_delete_b(gs_keys,'xcco_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE axct310_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axct310_bcl
               LET l_count = g_xcco_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_xcco_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco001
            #add-point:BEFORE FIELD xcco001 name="input.b.page1.xcco001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco001
            
            #add-point:AFTER FIELD xcco001 name="input.a.page1.xcco001"
            #此段落由子樣板a05產生
#            IF  g_xcco_m.xccold IS NOT NULL AND g_xcco_m.xcco003 IS NOT NULL AND g_xcco_m.xcco004 IS NOT NULL AND g_xcco_m.xcco005 IS NOT NULL AND g_xcco_m.xcco009 IS NOT NULL AND g_xcco_d[g_detail_idx].xcco001 IS NOT NULL AND g_xcco_d[g_detail_idx].xcco002 IS NOT NULL AND g_xcco_d[g_detail_idx].xcco006 IS NOT NULL AND g_xcco_d[g_detail_idx].xcco007 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcco_m.xccold != g_xccold_t OR g_xcco_m.xcco003 != g_xcco003_t OR g_xcco_m.xcco004 != g_xcco004_t OR g_xcco_m.xcco005 != g_xcco005_t OR g_xcco_m.xcco009 != g_xcco009_t OR g_xcco_d[g_detail_idx].xcco001 != g_xcco_d_t.xcco001 OR g_xcco_d[g_detail_idx].xcco002 != g_xcco_d_t.xcco002 OR g_xcco_d[g_detail_idx].xcco006 != g_xcco_d_t.xcco006 OR g_xcco_d[g_detail_idx].xcco007 != g_xcco_d_t.xcco007 )) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcco_t WHERE "||"xccoent = '" ||g_enterprise|| "' AND "||"xccold = '"||g_xcco_m.xccold ||"' AND "|| "xcco003 = '"||g_xcco_m.xcco003 ||"' AND "|| "xcco004 = '"||g_xcco_m.xcco004 ||"' AND "|| "xcco005 = '"||g_xcco_m.xcco005 ||"' AND "|| "xcco009 = '"||g_xcco_m.xcco009 ||"' AND "|| "xcco001 = '"||g_xcco_d[g_detail_idx].xcco001 ||"' AND "|| "xcco002 = '"||g_xcco_d[g_detail_idx].xcco002 ||"' AND "|| "xcco006 = '"||g_xcco_d[g_detail_idx].xcco006 ||"' AND "|| "xcco007 = '"||g_xcco_d[g_detail_idx].xcco007 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
#

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcco001
            #add-point:ON CHANGE xcco001 name="input.g.page1.xcco001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco006
            
            #add-point:AFTER FIELD xcco006 name="input.a.page1.xcco006"
            #此段落由子樣板a05產生
            IF  g_xcco_m.xccold IS NOT NULL AND g_xcco_m.xcco003 IS NOT NULL AND g_xcco_m.xcco004 IS NOT NULL AND g_xcco_m.xcco005 IS NOT NULL AND g_xcco_m.xcco009 IS NOT NULL AND g_xcco_d[g_detail_idx].xcco002 IS NOT NULL AND g_xcco_d[g_detail_idx].xcco006 IS NOT NULL AND g_xcco_d[g_detail_idx].xcco007 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcco_m.xccold != g_xccold_t OR g_xcco_m.xcco003 != g_xcco003_t OR g_xcco_m.xcco004 != g_xcco004_t OR g_xcco_m.xcco005 != g_xcco005_t OR g_xcco_m.xcco009 != g_xcco009_t OR g_xcco_d[g_detail_idx].xcco002 != g_xcco_d_t.xcco002 OR g_xcco_d[g_detail_idx].xcco006 != g_xcco_d_t.xcco006 OR g_xcco_d[g_detail_idx].xcco007 != g_xcco_d_t.xcco007 )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcco_t WHERE "||"xccoent = '" ||g_enterprise|| "' AND "||"xccold = '"||g_xcco_m.xccold ||"' AND "|| "xcco003 = '"||g_xcco_m.xcco003 ||"' AND "|| "xcco004 = '"||g_xcco_m.xcco004 ||"' AND "|| "xcco005 = '"||g_xcco_m.xcco005 ||"' AND "|| "xcco009 = '"||g_xcco_m.xcco009 ||"' AND "|| "xcco002 = '"||g_xcco_d[g_detail_idx].xcco002 ||"' AND "|| "xcco006 = '"||g_xcco_d[g_detail_idx].xcco006 ||"' AND "|| "xcco007 = '"||g_xcco_d[g_detail_idx].xcco007 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
             
            IF NOT cl_null(g_xcco_d[l_ac].xcco006) THEN 
               #檢查是否存在 料件據點財務檔 中
               IF NOT ap_chk_isExist(g_xcco_d[l_ac].xcco006,"SELECT COUNT(*) FROM imag_t WHERE "||"imagent = '" ||g_enterprise|| "' AND "||"imag001 = ? AND imagstus = 'Y' AND imagsite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '" ||g_enterprise|| "'  AND ooef201 = 'Y' AND ooef017 = '" ||g_xcco_m.xccocomp|| "' AND ooef003 = 'Y')",'axc-00119',1) THEN 
                  LET g_xcco_d[l_ac].xcco006 = g_xcco_d_t.xcco006
                  LET g_xcco_d[l_ac].xcco006_desc = g_xcco_d_t.xcco006_desc
                  LET g_xcco_d[l_ac].xcco006_1_desc = g_xcco_d_t.xcco006_1_desc
                  LET g_xcco_d[l_ac].imag014 = g_xcco_d_t.imag014
                  CALL axct310_get_xcco006_desc()
                  CALL axct310_get_imag014()                  
                  NEXT FIELD CURRENT
               END IF

               #檢查是否 已確認
               IF NOT ap_chk_isExist(g_xcco_d[l_ac].xcco006,"SELECT COUNT(*) FROM imag_t WHERE "||"imagent = '" ||g_enterprise|| "' AND "||"imag001 = ? AND imagstus = 'Y' AND imagsite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '" ||g_enterprise|| "'  AND ooef201 = 'Y' AND ooef017 = '" ||g_xcco_m.xccocomp|| "' AND ooef003 = 'Y')",'aim-00101',1) THEN 
                  LET g_xcco_d[l_ac].xcco006 = g_xcco_d_t.xcco006
                  LET g_xcco_d[l_ac].xcco006_desc = g_xcco_d_t.xcco006_desc
                  LET g_xcco_d[l_ac].xcco006_1_desc = g_xcco_d_t.xcco006_1_desc
                  LET g_xcco_d[l_ac].imag014 = g_xcco_d_t.imag014
                  CALL axct310_get_xcco006_desc()
                  CALL axct310_get_imag014()                  
                  NEXT FIELD CURRENT
               END IF                              
            END IF    
            
            IF cl_null(g_xcco_d[l_ac].xcco007) THEN
               LET g_xcco_d[l_ac].xcco007 = ' '
            END IF
            CALL axct310_get_xcco006_desc()  
            CALL axct310_get_imag014()  
            
#150724-00005#1 add---start
            IF cl_null(g_xcco_d[l_ac].xcco007) THEN
               LET g_xcco_d[l_ac].xcco007 = ''
               LET g_xcco_d[l_ac].xcco007_desc = ''
            END IF
            #160314-00009#4   marked by zhujing 2016-3-17-----(S) 元件中有判断
#            SELECT imaa005 INTO l_imaa005 FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = g_xcco_d[l_ac].xcco006   
#            IF NOT cl_null(l_imaa005) THEN
            #160314-00009#4   marked by zhujing 2016-3-17-----(E) 元件中有判断
            IF s_feature_auto_chk(g_xcco_d[l_ac].xcco006) AND cl_null(g_xcco_d[l_ac].xcco007) THEN #160314-00009#4   mod by zhujing 2016-3-17
               CALL cl_set_comp_entry("xcco007",TRUE)
               IF l_cmd = 'a' THEN            
                  CALL l_inam.clear()   
                  CALL s_feature(l_cmd,g_xcco_d[l_ac].xcco006,'','',g_site,' 1') RETURNING l_success,l_inam
                  LET g_xcco_d[l_ac].xcco007 = l_inam[1].inam002
                  DISPLAY BY NAME g_xcco_d[l_ac].xcco007
               END IF
            ELSE   
               CALL cl_set_comp_entry("xcco007",FALSE)
               LET g_xcco_d[l_ac].xcco007 = ' '   
               LET g_xcco_d[l_ac].xcco007_desc = ''              
            END IF 
#150724-00005#1 add---end
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco006
            #add-point:BEFORE FIELD xcco006 name="input.b.page1.xcco006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcco006
            #add-point:ON CHANGE xcco006 name="input.g.page1.xcco006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco007
            
            #add-point:AFTER FIELD xcco007 name="input.a.page1.xcco007"
            #此段落由子樣板a05產生
            IF  g_xcco_m.xccold IS NOT NULL AND g_xcco_m.xcco003 IS NOT NULL AND g_xcco_m.xcco004 IS NOT NULL AND g_xcco_m.xcco005 IS NOT NULL AND g_xcco_m.xcco009 IS NOT NULL AND g_xcco_d[g_detail_idx].xcco002 IS NOT NULL AND g_xcco_d[g_detail_idx].xcco006 IS NOT NULL AND g_xcco_d[g_detail_idx].xcco007 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcco_m.xccold != g_xccold_t OR g_xcco_m.xcco003 != g_xcco003_t OR g_xcco_m.xcco004 != g_xcco004_t OR g_xcco_m.xcco005 != g_xcco005_t OR g_xcco_m.xcco009 != g_xcco009_t OR g_xcco_d[g_detail_idx].xcco002 != g_xcco_d_t.xcco002 OR g_xcco_d[g_detail_idx].xcco006 != g_xcco_d_t.xcco006 OR g_xcco_d[g_detail_idx].xcco007 != g_xcco_d_t.xcco007 )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcco_t WHERE "||"xccoent = '" ||g_enterprise|| "' AND "||"xccold = '"||g_xcco_m.xccold ||"' AND "|| "xcco003 = '"||g_xcco_m.xcco003 ||"' AND "|| "xcco004 = '"||g_xcco_m.xcco004 ||"' AND "|| "xcco005 = '"||g_xcco_m.xcco005 ||"' AND "|| "xcco009 = '"||g_xcco_m.xcco009 ||"' AND "|| "xcco002 = '"||g_xcco_d[g_detail_idx].xcco002 ||"' AND "|| "xcco006 = '"||g_xcco_d[g_detail_idx].xcco006 ||"' AND "|| "xcco007 = '"||g_xcco_d[g_detail_idx].xcco007 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_feature_description(g_xcco_d[l_ac].xcco006,g_xcco_d[l_ac].xcco007) RETURNING l_success,g_xcco_d[l_ac].xcco007_desc   #150724-00005#1 add
            DISPLAY BY NAME g_xcco_d[l_ac].xcco007_desc    #150724-00005#1 add
            IF NOT cl_null(g_xcco_d[l_ac].xcco007) THEN
               IF NOT s_feature_check(g_xcco_d[l_ac].xcco006,g_xcco_d[l_ac].xcco007) THEN
                  LET g_xcco_d[l_ac].xcco007 = g_xcco_d_t.xcco007
                  CALL s_feature_description(g_xcco_d[l_ac].xcco006,g_xcco_d[l_ac].xcco007) RETURNING l_success,g_xcco_d[l_ac].xcco007_desc
                  DISPLAY BY NAME g_xcco_d[l_ac].xcco007_desc
                  NEXT FIELD CURRENT
               END IF
               #151224-00025#2--add--start--
               IF NOT s_feature_direct_input(g_xcco_d[l_ac].xcco006,g_xcco_d[l_ac].xcco007,g_xcco_d_t.xcco007,'',g_site) THEN
                  NEXT FIELD CURRENT
               END IF 
               #151224-00025#2--add--end----
            END IF   
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco007
            #add-point:BEFORE FIELD xcco007 name="input.b.page1.xcco007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcco007
            #add-point:ON CHANGE xcco007 name="input.g.page1.xcco007"
            IF cl_null(g_xcco_d[l_ac].xcco007) THEN 
               LET g_xcco_d[l_ac].xcco007 = ' '
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco002
            
            #add-point:AFTER FIELD xcco002 name="input.a.page1.xcco002"
            #此段落由子樣板a05產生
            IF  g_xcco_m.xccold IS NOT NULL AND g_xcco_m.xcco003 IS NOT NULL AND g_xcco_m.xcco004 IS NOT NULL AND g_xcco_m.xcco005 IS NOT NULL AND g_xcco_m.xcco009 IS NOT NULL AND g_xcco_d[g_detail_idx].xcco002 IS NOT NULL AND g_xcco_d[g_detail_idx].xcco006 IS NOT NULL AND g_xcco_d[g_detail_idx].xcco007 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcco_m.xccold != g_xccold_t OR g_xcco_m.xcco003 != g_xcco003_t OR g_xcco_m.xcco004 != g_xcco004_t OR g_xcco_m.xcco005 != g_xcco005_t OR g_xcco_m.xcco009 != g_xcco009_t OR g_xcco_d[g_detail_idx].xcco002 != g_xcco_d_t.xcco002 OR g_xcco_d[g_detail_idx].xcco006 != g_xcco_d_t.xcco006 OR g_xcco_d[g_detail_idx].xcco007 != g_xcco_d_t.xcco007 )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcco_t WHERE "||"xccoent = '" ||g_enterprise|| "' AND "||"xccold = '"||g_xcco_m.xccold ||"' AND "|| "xcco003 = '"||g_xcco_m.xcco003 ||"' AND "|| "xcco004 = '"||g_xcco_m.xcco004 ||"' AND "|| "xcco005 = '"||g_xcco_m.xcco005 ||"' AND "|| "xcco009 = '"||g_xcco_m.xcco009 ||"' AND "|| "xcco002 = '"||g_xcco_d[g_detail_idx].xcco002 ||"' AND "|| "xcco006 = '"||g_xcco_d[g_detail_idx].xcco006 ||"' AND "|| "xcco007 = '"||g_xcco_d[g_detail_idx].xcco007 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_xcco_d[l_ac].xcco002) THEN 
               #檢查是否存在 成本域範圍設置檔 中
               IF NOT ap_chk_isExist(g_xcco_d[l_ac].xcco002,"SELECT COUNT(*) FROM xcbf_t WHERE "||"xcbfent = '" ||g_enterprise|| "' AND "||"xcbf001 = ?  AND xcbfcomp = '" ||g_xcco_m.xccocomp|| "'",'axc-00222',1) THEN
                  LET g_xcco_d[l_ac].xcco002 = g_xcco_d_t.xcco002
                  CALL axct310_get_xcco002_desc()                  
                  NEXT FIELD CURRENT
               END IF  

               #檢查是否 有效
#               IF NOT ap_chk_isExist(g_xcco_d[l_ac].xcco002,"SELECT COUNT(*) FROM xcbf_t WHERE "||"xcbfent = '" ||g_enterprise|| "' AND "||"xcbf001 = ?  AND xcbfstus = 'Y' AND xcbfcomp = '" ||g_xcco_m.xccocomp|| "'",'axc-00041',1) THEN  #160318-00005#47  mark
               IF NOT ap_chk_isExist(g_xcco_d[l_ac].xcco002,"SELECT COUNT(*) FROM xcbf_t WHERE "||"xcbfent = '" ||g_enterprise|| "' AND "||"xcbf001 = ?  AND xcbfstus = 'Y' AND xcbfcomp = '" ||g_xcco_m.xccocomp|| "'",'sub-01302','aimi007') THEN  #160318-00005#47  add
                  LET g_xcco_d[l_ac].xcco002 = g_xcco_d_t.xcco002
                  CALL axct310_get_xcco002_desc()                  
                  NEXT FIELD CURRENT
               END IF 
            END IF
            
            CALL axct310_get_xcco002_desc()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco002
            #add-point:BEFORE FIELD xcco002 name="input.b.page1.xcco002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcco002
            #add-point:ON CHANGE xcco002 name="input.g.page1.xcco002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco008
            #add-point:BEFORE FIELD xcco008 name="input.b.page1.xcco008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco008
            
            #add-point:AFTER FIELD xcco008 name="input.a.page1.xcco008"
            #此段落由子樣板a05產生
            IF  g_xcco_m.xccold IS NOT NULL  AND g_xcco_m.xcco003 IS NOT NULL AND g_xcco_m.xcco004 IS NOT NULL AND g_xcco_m.xcco005 IS NOT NULL AND g_xcco_m.xcco009 IS NOT NULL AND g_xcco_d[g_detail_idx].xcco002 IS NOT NULL AND g_xcco_d[g_detail_idx].xcco006 IS NOT NULL AND g_xcco_d[g_detail_idx].xcco007 IS NOT NULL AND g_xcco_d[g_detail_idx].xcco008 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcco_m.xccold != g_xccold_t  OR g_xcco_m.xcco003 != g_xcco003_t OR g_xcco_m.xcco004 != g_xcco004_t OR g_xcco_m.xcco005 != g_xcco005_t OR g_xcco_m.xcco009 != g_xcco009_t OR g_xcco_d[g_detail_idx].xcco002 != g_xcco_d_t.xcco002 OR g_xcco_d[g_detail_idx].xcco006 != g_xcco_d_t.xcco006 OR g_xcco_d[g_detail_idx].xcco007 != g_xcco_d_t.xcco007 OR g_xcco_d[g_detail_idx].xcco008 != g_xcco_d_t.xcco008)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcco_t WHERE "||"xccoent = '" ||g_enterprise|| "' AND "||"xccold = '"||g_xcco_m.xccold ||"' AND "|| "xcco003 = '"||g_xcco_m.xcco003 ||"' AND "|| "xcco004 = '"||g_xcco_m.xcco004 ||"' AND "|| "xcco005 = '"||g_xcco_m.xcco005 ||"' AND "|| "xcco009 = '"||g_xcco_m.xcco009 ||"' AND "|| "xcco002 = '"||g_xcco_d[g_detail_idx].xcco002 ||"' AND "|| "xcco006 = '"||g_xcco_d[g_detail_idx].xcco006 ||"' AND "|| "xcco007 = '"||g_xcco_d[g_detail_idx].xcco007 ||"' AND "|| "xcco008 = '"||g_xcco_d[g_detail_idx].xcco008 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
 
            IF NOT cl_null(g_xcco_d[l_ac].xcco008) THEN 
               #檢查是否存在該批號
               IF NOT ap_chk_isExist(g_xcco_d[l_ac].xcco008,"SELECT COUNT(*) FROM inaj_t WHERE "||"inajent = '" ||g_enterprise|| "' AND "||" inaj010 = ?  AND inajsite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '" ||g_enterprise|| "'  AND ooef201 = 'Y' AND ooef017 = '" ||g_xcco_m.xccocomp|| "' AND ooef003 = 'Y')",'axc-00228',1) THEN
                  LET g_xcco_d[l_ac].xcco008 = g_xcco_d_t.xcco008            
                  NEXT FIELD CURRENT
               END IF
               
               IF NOT cl_null(g_xcco_d[l_ac].xcco006) THEN 
                  #檢查在當前料件+營運據點下 是否存在該批號 
                  IF NOT ap_chk_isExist(g_xcco_d[l_ac].xcco008,"SELECT COUNT(*) FROM inaj_t WHERE "||"inajent = '" ||g_enterprise|| "' AND "||" inaj005 = '" ||g_xcco_d[l_ac].xcco006|| "' AND inaj010 = ?  AND inajsite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '" ||g_enterprise|| "'  AND ooef201 = 'Y' AND ooef017 = '" ||g_xcco_m.xccocomp|| "' AND ooef003 = 'Y')",'axc-00227',1) THEN
                     LET g_xcco_d[l_ac].xcco008 = g_xcco_d_t.xcco008                
                     NEXT FIELD CURRENT
                  END IF
               END IF   
            END IF  
            IF cl_null(g_xcco_d[l_ac].xcco008) THEN 
               LET g_xcco_d[l_ac].xcco008 = ' '
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcco008
            #add-point:ON CHANGE xcco008 name="input.g.page1.xcco008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco011
            #add-point:BEFORE FIELD xcco011 name="input.b.page1.xcco011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco011
            
            #add-point:AFTER FIELD xcco011 name="input.a.page1.xcco011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcco011
            #add-point:ON CHANGE xcco011 name="input.g.page1.xcco011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco102a
            #add-point:BEFORE FIELD xcco102a name="input.b.page1.xcco102a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco102a
            
            #add-point:AFTER FIELD xcco102a name="input.a.page1.xcco102a"
#            IF NOT cl_ap_chk_Range(g_xcco_d[l_ac].xcco102a,"0.000000","1","","","azz-00079",1) THEN
#               LET g_xcco_d[l_ac].xcco102a = g_xcco_d_t.xcco102a
#               NEXT FIELD CURRENT
#            END IF
            
            CALL axct310_get_xcco102_sum()
            
            DISPLAY BY NAME g_xcco_d[l_ac].xcco102
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcco102a
            #add-point:ON CHANGE xcco102a name="input.g.page1.xcco102a"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco102b
            #add-point:BEFORE FIELD xcco102b name="input.b.page1.xcco102b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco102b
            
            #add-point:AFTER FIELD xcco102b name="input.a.page1.xcco102b"
#            IF NOT cl_ap_chk_Range(g_xcco_d[l_ac].xcco102b,"0.000000","1","","","azz-00079",1) THEN
#               LET g_xcco_d[l_ac].xcco102b = g_xcco_d_t.xcco102b
#               NEXT FIELD CURRENT
#            END IF
            CALL axct310_get_xcco102_sum()
            DISPLAY BY NAME g_xcco_d[l_ac].xcco102
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcco102b
            #add-point:ON CHANGE xcco102b name="input.g.page1.xcco102b"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco102c
            #add-point:BEFORE FIELD xcco102c name="input.b.page1.xcco102c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco102c
            
            #add-point:AFTER FIELD xcco102c name="input.a.page1.xcco102c"
#            IF NOT cl_ap_chk_Range(g_xcco_d[l_ac].xcco102c,"0.000000","1","","","azz-00079",1) THEN
#               LET g_xcco_d[l_ac].xcco102c = g_xcco_d_t.xcco102c
#               NEXT FIELD CURRENT
#            END IF
            
            CALL axct310_get_xcco102_sum()
            
            DISPLAY BY NAME g_xcco_d[l_ac].xcco102
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcco102c
            #add-point:ON CHANGE xcco102c name="input.g.page1.xcco102c"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco102d
            #add-point:BEFORE FIELD xcco102d name="input.b.page1.xcco102d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco102d
            
            #add-point:AFTER FIELD xcco102d name="input.a.page1.xcco102d"
#            IF NOT cl_ap_chk_Range(g_xcco_d[l_ac].xcco102d,"0.000000","1","","","azz-00079",1) THEN
#               LET g_xcco_d[l_ac].xcco102d = g_xcco_d_t.xcco102d
#               NEXT FIELD CURRENT
#            END IF
            
            CALL axct310_get_xcco102_sum()
            
            DISPLAY BY NAME g_xcco_d[l_ac].xcco102
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcco102d
            #add-point:ON CHANGE xcco102d name="input.g.page1.xcco102d"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco102e
            #add-point:BEFORE FIELD xcco102e name="input.b.page1.xcco102e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco102e
            
            #add-point:AFTER FIELD xcco102e name="input.a.page1.xcco102e"
#            IF NOT cl_ap_chk_Range(g_xcco_d[l_ac].xcco102e,"0.000000","1","","","azz-00079",1) THEN
#               LET g_xcco_d[l_ac].xcco102e = g_xcco_d_t.xcco102e
#               NEXT FIELD CURRENT
#            END IF
            
            CALL axct310_get_xcco102_sum()
            
            DISPLAY BY NAME g_xcco_d[l_ac].xcco102
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcco102e
            #add-point:ON CHANGE xcco102e name="input.g.page1.xcco102e"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco102f
            #add-point:BEFORE FIELD xcco102f name="input.b.page1.xcco102f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco102f
            
            #add-point:AFTER FIELD xcco102f name="input.a.page1.xcco102f"
#            IF NOT cl_ap_chk_Range(g_xcco_d[l_ac].xcco102f,"0.000000","1","","","azz-00079",1) THEN
#               LET g_xcco_d[l_ac].xcco102f = g_xcco_d_t.xcco102f
#               NEXT FIELD CURRENT
#            END IF
            
            CALL axct310_get_xcco102_sum()
            
            DISPLAY BY NAME g_xcco_d[l_ac].xcco102
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcco102f
            #add-point:ON CHANGE xcco102f name="input.g.page1.xcco102f"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco102g
            #add-point:BEFORE FIELD xcco102g name="input.b.page1.xcco102g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco102g
            
            #add-point:AFTER FIELD xcco102g name="input.a.page1.xcco102g"
#            IF NOT cl_ap_chk_Range(g_xcco_d[l_ac].xcco102g,"0.000000","1","","","azz-00079",1) THEN
#               LET g_xcco_d[l_ac].xcco102g = g_xcco_d_t.xcco102g
#               NEXT FIELD CURRENT
#            END IF
            
            CALL axct310_get_xcco102_sum()
            
            DISPLAY BY NAME g_xcco_d[l_ac].xcco102
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcco102g
            #add-point:ON CHANGE xcco102g name="input.g.page1.xcco102g"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco102h
            #add-point:BEFORE FIELD xcco102h name="input.b.page1.xcco102h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco102h
            
            #add-point:AFTER FIELD xcco102h name="input.a.page1.xcco102h"
#            IF NOT cl_ap_chk_Range(g_xcco_d[l_ac].xcco102h,"0.000000","1","","","azz-00079",1) THEN
#               LET g_xcco_d[l_ac].xcco102h = g_xcco_d_t.xcco102h
#               NEXT FIELD CURRENT
#            END IF
            
            CALL axct310_get_xcco102_sum()
            
            DISPLAY BY NAME g_xcco_d[l_ac].xcco102
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcco102h
            #add-point:ON CHANGE xcco102h name="input.g.page1.xcco102h"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcco102
            #add-point:BEFORE FIELD xcco102 name="input.b.page1.xcco102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcco102
            
            #add-point:AFTER FIELD xcco102 name="input.a.page1.xcco102"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcco102
            #add-point:ON CHANGE xcco102 name="input.g.page1.xcco102"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xcco001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco001
            #add-point:ON ACTION controlp INFIELD xcco001 name="input.c.page1.xcco001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcco006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco006
            #add-point:ON ACTION controlp INFIELD xcco006 name="input.c.page1.xcco006"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcco_d[l_ac].xcco006             #給予default值

            #給予arg
            LET g_qryparam.where = " imagsite IN (SELECT ooef001 FROM ooef_t ",
                                   "  WHERE ooefent = '",g_enterprise,"' AND ooef017 = '",g_xcco_m.xccocomp,"' AND ooef003 = 'Y' ",
                                   "    AND ooef201 = 'Y') "   
            
            
            CALL q_imag001_2()                                #呼叫開窗

            LET g_xcco_d[l_ac].xcco006 = g_qryparam.return1              

            CALL axct310_get_xcco006_desc()   #獲取名品規格
            CALL axct310_get_imag014()        #獲取成本單位
    
            DISPLAY g_xcco_d[l_ac].xcco006 TO xcco006              #
            DISPLAY g_xcco_d[l_ac].xcco006_desc TO xcco006_desc
            DISPLAY g_xcco_d[l_ac].xcco006_1_desc TO xcco006_1_desc
            DISPLAY g_xcco_d[l_ac].imag014 TO imag014
            
            LET g_qryparam.where = ''
            NEXT FIELD xcco006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xcco007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco007
            #add-point:ON ACTION controlp INFIELD xcco007 name="input.c.page1.xcco007"
#150724-00005#1 add---start            
            SELECT imaa005 INTO l_imaa005 FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = g_xcco_d[l_ac].xcco006   
            IF NOT cl_null(l_imaa005) THEN
               CALL cl_set_comp_entry("xcco007",TRUE)
               IF l_cmd = 'a' THEN            
                  CALL l_inam.clear()   
                  CALL s_feature(l_cmd,g_xcco_d[l_ac].xcco006,'','',g_site,' 1') RETURNING l_success,l_inam
                  LET g_xcco_d[l_ac].xcco007 = l_inam[1].inam002
                  DISPLAY BY NAME g_xcco_d[l_ac].xcco007
               END IF   
               IF l_cmd = 'u' THEN
                  CALL s_feature_single(g_xcco_d[l_ac].xcco006,g_xcco_d[l_ac].xcco007,g_site,' ')
                     RETURNING l_success,g_xcco_d[l_ac].xcco007
                  DISPLAY BY NAME g_xcco_d[l_ac].xcco007
               END IF
            END IF  
#150724-00005#1 add---end            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcco002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco002
            #add-point:ON ACTION controlp INFIELD xcco002 name="input.c.page1.xcco002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcco_d[l_ac].xcco002             #給予default值

            #給予arg
            LET g_qryparam.where = " xcbfcomp = '",g_xcco_m.xccocomp,"'"
 
            
            CALL q_xcbf001()            #呼叫開窗

            LET g_xcco_d[l_ac].xcco002 = g_qryparam.return1              

            CALL axct310_get_xcco002_desc()   
            DISPLAY g_xcco_d[l_ac].xcco002 TO xcco002
            DISPLAY g_xcco_d[l_ac].xcco002_desc TO xcco002_desc              #
            
            LET g_qryparam.where = ''

            NEXT FIELD xcco002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xcco008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco008
            #add-point:ON ACTION controlp INFIELD xcco008 name="input.c.page1.xcco008"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcco_d[l_ac].xcco008             #給予default值

            #給予arg
            LET g_qryparam.where = " inaj010 IS NOT NULL AND inajsite IN( SELECT ooef001 FROM ooef_t  ",
                                  #"               WHERE ooefent = '",g_enterprise,"' AND ooef003 = 'Y' AND ooef017 = '",g_xcco_m.xccocomp,"' AND ooef201 = 'Y' ) "  #160513-00016#1 mark
                                   "               WHERE ooefent = '",g_enterprise,"' AND ooef017 = '",g_xcco_m.xccocomp,"' AND ooef201 = 'Y' ) "     #160513-00016#1
            IF NOT cl_null(g_xcco_d[l_ac].xcco006) THEN                        
               LET g_qryparam.where =  g_qryparam.where," AND inaj005 = '",g_xcco_d[l_ac].xcco006,"'"
            END IF   

            
            CALL q_inaj010()                                #呼叫開窗

            LET g_xcco_d[l_ac].xcco008 = g_qryparam.return1              

            IF cl_null(g_xcco_d[l_ac].xcco008) THEN 
               LET g_xcco_d[l_ac].xcco008 = ' '
            END IF
            DISPLAY g_xcco_d[l_ac].xcco008 TO xcco008              #

            LET g_qryparam.where = ''
            NEXT FIELD xcco008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xcco011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco011
            #add-point:ON ACTION controlp INFIELD xcco011 name="input.c.page1.xcco011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcco102a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco102a
            #add-point:ON ACTION controlp INFIELD xcco102a name="input.c.page1.xcco102a"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcco102b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco102b
            #add-point:ON ACTION controlp INFIELD xcco102b name="input.c.page1.xcco102b"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcco102c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco102c
            #add-point:ON ACTION controlp INFIELD xcco102c name="input.c.page1.xcco102c"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcco102d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco102d
            #add-point:ON ACTION controlp INFIELD xcco102d name="input.c.page1.xcco102d"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcco102e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco102e
            #add-point:ON ACTION controlp INFIELD xcco102e name="input.c.page1.xcco102e"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcco102f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco102f
            #add-point:ON ACTION controlp INFIELD xcco102f name="input.c.page1.xcco102f"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcco102g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco102g
            #add-point:ON ACTION controlp INFIELD xcco102g name="input.c.page1.xcco102g"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcco102h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco102h
            #add-point:ON ACTION controlp INFIELD xcco102h name="input.c.page1.xcco102h"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcco102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcco102
            #add-point:ON ACTION controlp INFIELD xcco102 name="input.c.page1.xcco102"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xcco_d[l_ac].* = g_xcco_d_t.*
               CLOSE axct310_bcl
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
               LET g_errparam.extend = g_xcco_d[l_ac].xcco001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xcco_d[l_ac].* = g_xcco_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_xcco2_d[l_ac].xccomodid = g_user 
LET g_xcco2_d[l_ac].xccomoddt = cl_get_current()
LET g_xcco2_d[l_ac].xccomodid_desc = cl_get_username(g_xcco2_d[l_ac].xccomodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL axct310_xcco_t_mask_restore('restore_mask_o')
         
               UPDATE xcco_t SET (xccold,xcco003,xcco004,xcco005,xcco009,xcco001,xcco006,xcco007,xcco002, 
                   xcco008,xcco011,xcco102a,xcco102b,xcco102c,xcco102d,xcco102e,xcco102f,xcco102g,xcco102h, 
                   xcco102,xccoownid,xccoowndp,xccocrtid,xccocrtdp,xccocrtdt,xccomodid,xccomoddt,xccocnfid, 
                   xccocnfdt,xccopstid,xccopstdt) = (g_xcco_m.xccold,g_xcco_m.xcco003,g_xcco_m.xcco004, 
                   g_xcco_m.xcco005,g_xcco_m.xcco009,g_xcco_d[l_ac].xcco001,g_xcco_d[l_ac].xcco006,g_xcco_d[l_ac].xcco007, 
                   g_xcco_d[l_ac].xcco002,g_xcco_d[l_ac].xcco008,g_xcco_d[l_ac].xcco011,g_xcco_d[l_ac].xcco102a, 
                   g_xcco_d[l_ac].xcco102b,g_xcco_d[l_ac].xcco102c,g_xcco_d[l_ac].xcco102d,g_xcco_d[l_ac].xcco102e, 
                   g_xcco_d[l_ac].xcco102f,g_xcco_d[l_ac].xcco102g,g_xcco_d[l_ac].xcco102h,g_xcco_d[l_ac].xcco102, 
                   g_xcco2_d[l_ac].xccoownid,g_xcco2_d[l_ac].xccoowndp,g_xcco2_d[l_ac].xccocrtid,g_xcco2_d[l_ac].xccocrtdp, 
                   g_xcco2_d[l_ac].xccocrtdt,g_xcco2_d[l_ac].xccomodid,g_xcco2_d[l_ac].xccomoddt,g_xcco2_d[l_ac].xccocnfid, 
                   g_xcco2_d[l_ac].xccocnfdt,g_xcco2_d[l_ac].xccopstid,g_xcco2_d[l_ac].xccopstdt)
                WHERE xccoent = g_enterprise AND xccold = g_xcco_m.xccold 
                 AND xcco003 = g_xcco_m.xcco003 
                 AND xcco004 = g_xcco_m.xcco004 
                 AND xcco005 = g_xcco_m.xcco005 
                 AND xcco009 = g_xcco_m.xcco009 
 
                 AND xcco001 = g_xcco_d_t.xcco001 #項次   
                 AND xcco002 = g_xcco_d_t.xcco002  
                 AND xcco006 = g_xcco_d_t.xcco006  
                 AND xcco007 = g_xcco_d_t.xcco007  
                 AND xcco008 = g_xcco_d_t.xcco008  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
              UPDATE xcco_t SET xcco102 = g_xcco_d[l_ac].xcco102
               WHERE xccoent = g_enterprise AND xccold = g_xcco_m.xccold 
                 AND xcco003 = g_xcco_m.xcco003 
                 AND xcco004 = g_xcco_m.xcco004 
                 AND xcco005 = g_xcco_m.xcco005 
                 AND xcco009 = g_xcco_m.xcco009 
 
                 AND xcco001 = g_xcco_d_t.xcco001 #項次   
                 AND xcco002 = g_xcco_d_t.xcco002  
                 AND xcco006 = g_xcco_d_t.xcco006  
                 AND xcco007 = g_xcco_d_t.xcco007  
                 AND xcco008 = g_xcco_d_t.xcco008                 

               IF g_glaa015 = 'Y' THEN
                  CALL axct310_get_date()
                  CALL s_aooi160_get_exrate('1',g_xcco_m.xccocomp,g_edate,g_glaa001,
                                                    #目的幣別;  交易金額;              匯類類型
                                                     g_glaa016,0,g_glaa018)
                              RETURNING l_rate
                  LET g_xcco1_d[l_ac].xcco006_1 = g_xcco_d[l_ac].xcco006                         
                  LET g_xcco1_d[l_ac].xcco002_1 = g_xcco_d[l_ac].xcco002
                  LET g_xcco1_d[l_ac].xcco007_1 = g_xcco_d[l_ac].xcco007
                  LET g_xcco1_d[l_ac].xcco008_1 = g_xcco_d[l_ac].xcco008
                  LET g_xcco1_d[l_ac].xcco001_1 = '2'                    
                  LET g_xcco1_d[l_ac].xcco102a_1 = g_xcco_d[l_ac].xcco102a * l_rate  
                  LET g_xcco1_d[l_ac].xcco102b_1 = g_xcco_d[l_ac].xcco102b * l_rate  
                  LET g_xcco1_d[l_ac].xcco102c_1 = g_xcco_d[l_ac].xcco102c * l_rate  
                  LET g_xcco1_d[l_ac].xcco102d_1 = g_xcco_d[l_ac].xcco102d * l_rate  
                  LET g_xcco1_d[l_ac].xcco102e_1 = g_xcco_d[l_ac].xcco102e * l_rate  
                  LET g_xcco1_d[l_ac].xcco102f_1 = g_xcco_d[l_ac].xcco102f * l_rate  
                  LET g_xcco1_d[l_ac].xcco102g_1 = g_xcco_d[l_ac].xcco102g * l_rate  
                  LET g_xcco1_d[l_ac].xcco102h_1 = g_xcco_d[l_ac].xcco102h * l_rate  
                  CALL axct310_get_xcco102_1_sum()
                  UPDATE xcco_t SET (xccold,xcco003,xcco004,xcco005,xcco001,xcco002,xcco006,xcco007,xcco008,
                   xcco102a,xcco102b,xcco102c,xcco102d,xcco102e,xcco102f,xcco102g,xcco102h,xcco102,xccoownid,xccoowndp, 
                   xccocrtid,xccocrtdp,xccocrtdt,xccomodid,xccomoddt,xccocnfid,xccocnfdt,xccopstid,xccopstdt) = (g_xcco_m.xccold, 
                   g_xcco_m.xcco003,g_xcco_m.xcco004,g_xcco_m.xcco005,g_xcco1_d[l_ac].xcco001_1,g_xcco1_d[l_ac].xcco002_1, 
                   g_xcco1_d[l_ac].xcco006_1,g_xcco1_d[l_ac].xcco007_1, g_xcco1_d[l_ac].xcco008_1, 
                   g_xcco1_d[l_ac].xcco102a_1,g_xcco1_d[l_ac].xcco102b_1,g_xcco1_d[l_ac].xcco102c_1,g_xcco1_d[l_ac].xcco102d_1, 
                   g_xcco1_d[l_ac].xcco102e_1,g_xcco1_d[l_ac].xcco102f_1,g_xcco1_d[l_ac].xcco102g_1,g_xcco1_d[l_ac].xcco102h_1,g_xcco1_d[l_ac].xcco102_1,
                   g_xcco2_d[l_ac].xccoownid,g_xcco2_d[l_ac].xccoowndp,g_xcco2_d[l_ac].xccocrtid,g_xcco2_d[l_ac].xccocrtdp, 
                   g_xcco2_d[l_ac].xccocrtdt,g_xcco2_d[l_ac].xccomodid,g_xcco2_d[l_ac].xccomoddt,g_xcco2_d[l_ac].xccocnfid, 
                   g_xcco2_d[l_ac].xccocnfdt,g_xcco2_d[l_ac].xccopstid,g_xcco2_d[l_ac].xccopstdt)
                WHERE xccoent = g_enterprise AND xccold = g_xcco_m.xccold 
                 AND xcco003 = g_xcco_m.xcco003 
                 AND xcco004 = g_xcco_m.xcco004 
                 AND xcco005 = g_xcco_m.xcco005
                 AND xcco009 = g_xcco_m.xcco009
 
                 AND xcco001 = '2'   
                 AND xcco002 = g_xcco_d_t.xcco002 
                 AND xcco006 = g_xcco_d_t.xcco006  
                 AND xcco007 = g_xcco_d_t.xcco007 
                 AND xcco008 = g_xcco_d_t.xcco008                 
                  
               END IF
   
               IF g_glaa019 = 'Y' THEN
                  CALL axct310_get_date()
                  CALL s_aooi160_get_exrate('1',g_xcco_m.xccocomp,g_edate,g_glaa001,
                                                    #目的幣別;  交易金額;              匯類類型
                                                     g_glaa020,0,g_glaa022)
                      RETURNING l_rate
                  LET g_xcco3_d[l_ac].xcco006_3 = g_xcco_d[l_ac].xcco006                         
                  LET g_xcco3_d[l_ac].xcco002_3 = g_xcco_d[l_ac].xcco002
                  LET g_xcco3_d[l_ac].xcco007_3 = g_xcco_d[l_ac].xcco007
                  LET g_xcco3_d[l_ac].xcco008_3 = g_xcco_d[l_ac].xcco008                   
                  LET g_xcco3_d[l_ac].xcco001_3 = '3'                   
                  LET g_xcco3_d[l_ac].xcco102a_3 = g_xcco_d[l_ac].xcco102a * l_rate  
                  LET g_xcco3_d[l_ac].xcco102b_3 = g_xcco_d[l_ac].xcco102b * l_rate  
                  LET g_xcco3_d[l_ac].xcco102c_3 = g_xcco_d[l_ac].xcco102c * l_rate  
                  LET g_xcco3_d[l_ac].xcco102d_3 = g_xcco_d[l_ac].xcco102d * l_rate  
                  LET g_xcco3_d[l_ac].xcco102e_3 = g_xcco_d[l_ac].xcco102e * l_rate  
                  LET g_xcco3_d[l_ac].xcco102f_3 = g_xcco_d[l_ac].xcco102f * l_rate  
                  LET g_xcco3_d[l_ac].xcco102g_3 = g_xcco_d[l_ac].xcco102g * l_rate  
                  LET g_xcco3_d[l_ac].xcco102h_3 = g_xcco_d[l_ac].xcco102h * l_rate  
                  CALL axct310_get_xcco102_3_sum()
                  UPDATE xcco_t SET (xccold,xcco003,xcco004,xcco005,xcco001,xcco002,xcco006,xcco007,xcco008,
                   xcco102a,xcco102b,xcco102c,xcco102d,xcco102e,xcco102f,xcco102g,xcco102h,xcco102,xccoownid,xccoowndp, 
                   xccocrtid,xccocrtdp,xccocrtdt,xccomodid,xccomoddt,xccocnfid,xccocnfdt,xccopstid,xccopstdt) = (g_xcco_m.xccold, 
                   g_xcco_m.xcco003,g_xcco_m.xcco004,g_xcco_m.xcco005,g_xcco3_d[l_ac].xcco001_3,g_xcco3_d[l_ac].xcco002_3, 
                   g_xcco3_d[l_ac].xcco006_3,g_xcco3_d[l_ac].xcco007_3,g_xcco3_d[l_ac].xcco008_3,  
                   g_xcco3_d[l_ac].xcco102a_3,g_xcco3_d[l_ac].xcco102b_3,g_xcco3_d[l_ac].xcco102c_3,g_xcco3_d[l_ac].xcco102d_3, 
                   g_xcco3_d[l_ac].xcco102e_3,g_xcco3_d[l_ac].xcco102f_3,g_xcco3_d[l_ac].xcco102g_3,g_xcco3_d[l_ac].xcco102h_3,g_xcco3_d[l_ac].xcco102_3,
                   g_xcco2_d[l_ac].xccoownid,g_xcco2_d[l_ac].xccoowndp,g_xcco2_d[l_ac].xccocrtid,g_xcco2_d[l_ac].xccocrtdp, 
                   g_xcco2_d[l_ac].xccocrtdt,g_xcco2_d[l_ac].xccomodid,g_xcco2_d[l_ac].xccomoddt,g_xcco2_d[l_ac].xccocnfid, 
                   g_xcco2_d[l_ac].xccocnfdt,g_xcco2_d[l_ac].xccopstid,g_xcco2_d[l_ac].xccopstdt)
                WHERE xccoent = g_enterprise AND xccold = g_xcco_m.xccold 
                 AND xcco003 = g_xcco_m.xcco003 
                 AND xcco004 = g_xcco_m.xcco004 
                 AND xcco005 = g_xcco_m.xcco005
                 AND xcco009 = g_xcco_m.xcco009
 
                 AND xcco001 = '3'   
                 AND xcco002 = g_xcco_d_t.xcco002  
                 AND xcco006 = g_xcco_d_t.xcco006  
                 AND xcco007 = g_xcco_d_t.xcco007
                 AND xcco008 = g_xcco_d_t.xcco008                 
                  
               END IF
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcco_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xcco_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcco_m.xccold
               LET gs_keys_bak[1] = g_xccold_t
               LET gs_keys[2] = g_xcco_m.xcco003
               LET gs_keys_bak[2] = g_xcco003_t
               LET gs_keys[3] = g_xcco_m.xcco004
               LET gs_keys_bak[3] = g_xcco004_t
               LET gs_keys[4] = g_xcco_m.xcco005
               LET gs_keys_bak[4] = g_xcco005_t
               LET gs_keys[5] = g_xcco_m.xcco009
               LET gs_keys_bak[5] = g_xcco009_t
               LET gs_keys[6] = g_xcco_d[g_detail_idx].xcco001
               LET gs_keys_bak[6] = g_xcco_d_t.xcco001
               LET gs_keys[7] = g_xcco_d[g_detail_idx].xcco002
               LET gs_keys_bak[7] = g_xcco_d_t.xcco002
               LET gs_keys[8] = g_xcco_d[g_detail_idx].xcco006
               LET gs_keys_bak[8] = g_xcco_d_t.xcco006
               LET gs_keys[9] = g_xcco_d[g_detail_idx].xcco007
               LET gs_keys_bak[9] = g_xcco_d_t.xcco007
               LET gs_keys[10] = g_xcco_d[g_detail_idx].xcco008
               LET gs_keys_bak[10] = g_xcco_d_t.xcco008
               CALL axct310_update_b('xcco_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_xcco_m),util.JSON.stringify(g_xcco_d_t)
                     LET g_log2 = util.JSON.stringify(g_xcco_m),util.JSON.stringify(g_xcco_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axct310_xcco_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_xcco_m.xccold
               LET ls_keys[ls_keys.getLength()+1] = g_xcco_m.xcco003
               LET ls_keys[ls_keys.getLength()+1] = g_xcco_m.xcco004
               LET ls_keys[ls_keys.getLength()+1] = g_xcco_m.xcco005
               LET ls_keys[ls_keys.getLength()+1] = g_xcco_m.xcco009
 
               LET ls_keys[ls_keys.getLength()+1] = g_xcco_d_t.xcco001
               LET ls_keys[ls_keys.getLength()+1] = g_xcco_d_t.xcco002
               LET ls_keys[ls_keys.getLength()+1] = g_xcco_d_t.xcco006
               LET ls_keys[ls_keys.getLength()+1] = g_xcco_d_t.xcco007
               LET ls_keys[ls_keys.getLength()+1] = g_xcco_d_t.xcco008
 
               CALL axct310_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE axct310_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xcco_d[l_ac].* = g_xcco_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE axct310_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xcco_d.getLength() = 0 THEN
               NEXT FIELD xcco001
            END IF
            #add-point:input段after input  name="input.body.after_input"
            IF cl_null(g_xcco_d[l_ac].xcco007) THEN 
               LET g_xcco_d[l_ac].xcco007 = ' '
            END IF
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xcco_d[li_reproduce_target].* = g_xcco_d[li_reproduce].*
               LET g_xcco2_d[li_reproduce_target].* = g_xcco2_d[li_reproduce].*
 
               LET g_xcco_d[li_reproduce_target].xcco001 = NULL
               LET g_xcco_d[li_reproduce_target].xcco002 = NULL
               LET g_xcco_d[li_reproduce_target].xcco006 = NULL
               LET g_xcco_d[li_reproduce_target].xcco007 = NULL
               LET g_xcco_d[li_reproduce_target].xcco008 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xcco_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xcco_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_xcco2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL axct310_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL axct310_idx_chk()
            CALL axct310_ui_detailshow()
        
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)      
         
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
         
      END DISPLAY
 
      
 
      
 
    
      #add-point:input段more_input name="input.more_inputarray"
      #Page2 預設值產生於此處
      INPUT ARRAY g_xcco1_d FROM s_detail3.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xcco_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
           IF g_glaa015 = 'Y' THEN 
              CALL axct310_b_fill_1(g_wc2) 
           END IF 
#            CALL axct310_b_fill_1(g_wc2) 
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
               OPEN axct310_cl USING g_enterprise
                                                       ,g_xcco_m.xccold
                                                       ,g_xcco_m.xcco003
                                                       ,g_xcco_m.xcco004
                                                       ,g_xcco_m.xcco005
                                                       ,g_xcco_m.xcco009
 
                                               
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  STATUS
                  LET g_errparam.extend = "OPEN axct310_cl:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CLOSE axct310_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            
            IF g_rec_b >= l_ac 
               AND g_xcco1_d[l_ac].xcco001_1 IS NOT NULL
               AND g_xcco1_d[l_ac].xcco002_1 IS NOT NULL
               AND g_xcco1_d[l_ac].xcco006_1 IS NOT NULL
               AND g_xcco1_d[l_ac].xcco007_1 IS NOT NULL
               AND g_xcco1_d[l_ac].xcco008_1 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xcco1_d_t.* = g_xcco1_d[l_ac].*  #BACKUP
               CALL axct310_set_entry_b(l_cmd)
               CALL axct310_set_no_entry_b(l_cmd)
               OPEN axct310_bcl USING g_enterprise,g_xcco_m.xccold,
                                                g_xcco_m.xcco003,
                                                g_xcco_m.xcco004,
                                                g_xcco_m.xcco005,
                                                g_xcco_m.xcco009,   
 
                                                g_xcco1_d_t.xcco001_1
                                                ,g_xcco1_d_t.xcco002_1
                                                ,g_xcco1_d_t.xcco006_1
                                                ,g_xcco1_d_t.xcco007_1
                                                ,g_xcco1_d_t.xcco008_1
 
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  STATUS
                  LET g_errparam.extend = "OPEN axct310_bcl:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw='Y'
               ELSE
#                  FETCH axct310_bcl INTO g_xcco1_d[l_ac].xcco001_1,g_xcco1_d[l_ac].xcco006_1, 
#                      g_xcco1_d[l_ac].xcco006_desc_1,g_xcco1_d[l_ac].xcco006_desc_1_1,g_xcco1_d[l_ac].imag014_1,
#                      g_xcco1_d[l_ac].xcco002_1,g_xcco1_d[l_ac].xcco002_desc_1,g_xcco1_d[l_ac].xcco007_1, 
#                      g_xcco1_d[l_ac].xcco102a_1,g_xcco1_d[l_ac].xcco102b_1,g_xcco1_d[l_ac].xcco102c_1, 
#                      g_xcco1_d[l_ac].xcco102d_1,g_xcco1_d[l_ac].xcco102e_1,g_xcco1_d[l_ac].xcco102f_1,g_xcco1_d[l_ac].xcco102g_1,g_xcco1_d[l_ac].xcco102h_1,g_xcco1_d[l_ac].xcco102_1,
#                      g_xcco2_d[l_ac].xcco001,g_xcco2_d[l_ac].xcco006,g_xcco2_d[l_ac].xcco002,g_xcco2_d[l_ac].xcco007, 
#                      g_xcco2_d[l_ac].xccoownid,g_xcco2_d[l_ac].xccoownid_desc,g_xcco2_d[l_ac].xccoowndp, 
#                      g_xcco2_d[l_ac].xccoowndp_desc,g_xcco2_d[l_ac].xccocrtid,g_xcco2_d[l_ac].xccocrtid_desc, 
#                      g_xcco2_d[l_ac].xccocrtdp,g_xcco2_d[l_ac].xccocrtdp_desc,g_xcco2_d[l_ac].xccocrtdt, 
#                      g_xcco2_d[l_ac].xccomodid,g_xcco2_d[l_ac].xccomodid_desc,g_xcco2_d[l_ac].xccomoddt, 
#                      g_xcco2_d[l_ac].xccocnfid,g_xcco2_d[l_ac].xccocnfid_desc,g_xcco2_d[l_ac].xccocnfdt, 
#                      g_xcco2_d[l_ac].xccopstid,g_xcco2_d[l_ac].xccopstid_desc,g_xcco2_d[l_ac].xccopstdt 
                      
                  FETCH axct310_bcl INTO g_xcco1_d[l_ac].xcco001_1,g_xcco1_d[l_ac].xcco006_1,g_xcco1_d[l_ac].xcco007_1, 
                      g_xcco1_d[l_ac].xcco002_1, g_xcco1_d[l_ac].xcco008_1, 
                      g_xcco1_d[l_ac].xcco102a_1,g_xcco1_d[l_ac].xcco102b_1,g_xcco1_d[l_ac].xcco102c_1, 
                      g_xcco1_d[l_ac].xcco102d_1,g_xcco1_d[l_ac].xcco102e_1,g_xcco1_d[l_ac].xcco102f_1,g_xcco1_d[l_ac].xcco102g_1,g_xcco1_d[l_ac].xcco102h_1,g_xcco1_d[l_ac].xcco102_1,
                      g_xcco2_d[l_ac].xcco001,g_xcco2_d[l_ac].xcco006,g_xcco2_d[l_ac].xcco007,g_xcco2_d[l_ac].xcco002,g_xcco2_d[l_ac].xcco008,  
                      g_xcco2_d[l_ac].xccoownid,g_xcco2_d[l_ac].xccoowndp, 
                      g_xcco2_d[l_ac].xccocrtid,
                      g_xcco2_d[l_ac].xccocrtdp,g_xcco2_d[l_ac].xccocrtdt, 
                      g_xcco2_d[l_ac].xccomodid,g_xcco2_d[l_ac].xccomoddt, 
                      g_xcco2_d[l_ac].xccocnfid,g_xcco2_d[l_ac].xccocnfdt, 
                      g_xcco2_d[l_ac].xccopstid,g_xcco2_d[l_ac].xccopstdt                       

                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = g_xcco1_d_t.xcco001_1
                      LET g_errparam.popup = TRUE
                      CALL cl_err()

                      LET l_lock_sw = "Y"
                  END IF
                  
                  CALL axct310_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            LET g_xcco1_d[l_ac].xcco001_1 = '2'
            #end add-point  
            
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_xcco1_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_xcco1_d.deleteElement(l_ac)
               NEXT FIELD xcco001
            END IF
            IF g_xcco1_d_t.xcco001_1 IS NOT NULL
               AND g_xcco1_d_t.xcco002_1 IS NOT NULL
               AND g_xcco1_d_t.xcco006_1 IS NOT NULL
               AND g_xcco1_d_t.xcco007_1 IS NOT NULL
 
               THEN
               
               #add-point:單身刪除前

               #end add-point
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF
               IF axct310_before_delete() THEN 
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axct310_bcl
               LET l_count = g_xcco1_d.getLength()
            END IF 
            
            #add-point:單身刪除後

            #end add-point
              
         AFTER DELETE 
            #add-point:單身AFTER DELETE 

            #end add-point            
 
         #此段落由子樣板a02產生
         AFTER FIELD xcco102a_1
            
            #add-point:AFTER FIELD xcco102a
#            IF NOT cl_ap_chk_Range(g_xcco1_d[l_ac].xcco102a_1,"0.000000","1","","","azz-00079",1) THEN
#               LET g_xcco1_d[l_ac].xcco102a_1 = g_xcco1_d_t.xcco102a_1
#               NEXT FIELD CURRENT
#            END IF

            CALL axct310_get_xcco102_1_sum()
            #END add-point
            
         #此段落由子樣板a02產生
         AFTER FIELD xcco102b_1
            
            #add-point:AFTER FIELD xcco102b
#            IF NOT cl_ap_chk_Range(g_xcco1_d[l_ac].xcco102b_1,"0.000000","1","","","azz-00079",1) THEN
#               LET g_xcco1_d[l_ac].xcco102b_1 = g_xcco1_d_t.xcco102b_1
#               NEXT FIELD CURRENT
#            END IF

            CALL axct310_get_xcco102_1_sum()
            #END add-point
            
         #此段落由子樣板a02產生
         AFTER FIELD xcco102c_1
            
            #add-point:AFTER FIELD xcco102c
#            IF NOT cl_ap_chk_Range(g_xcco1_d[l_ac].xcco102c_1,"0.000000","1","","","azz-00079",1) THEN
#               LET g_xcco1_d[l_ac].xcco102c_1 = g_xcco1_d_t.xcco102c_1
#               NEXT FIELD CURRENT
#            END IF

            CALL axct310_get_xcco102_1_sum()
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcco102d_1
            
            #add-point:AFTER FIELD xcco102c
#            IF NOT cl_ap_chk_Range(g_xcco1_d[l_ac].xcco102d_1,"0.000000","1","","","azz-00079",1) THEN
#               LET g_xcco1_d[l_ac].xcco102d_1 = g_xcco1_d_t.xcco102d_1
#               NEXT FIELD CURRENT
#            END IF

            CALL axct310_get_xcco102_1_sum()
            #END add-point
           
         #此段落由子樣板a02產生
         AFTER FIELD xcco102e_1
            
            #add-point:AFTER FIELD xcco102c
#            IF NOT cl_ap_chk_Range(g_xcco1_d[l_ac].xcco102e_1,"0.000000","1","","","azz-00079",1) THEN
#               LET g_xcco1_d[l_ac].xcco102e_1 = g_xcco1_d_t.xcco102e_1
#               NEXT FIELD CURRENT
#            END IF

            CALL axct310_get_xcco102_1_sum()
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcco102f_1
            
            #add-point:AFTER FIELD xcco102c
#            IF NOT cl_ap_chk_Range(g_xcco1_d[l_ac].xcco102f_1,"0.000000","1","","","azz-00079",1) THEN
#               LET g_xcco1_d[l_ac].xcco102f_1 = g_xcco1_d_t.xcco102f_1
#               NEXT FIELD CURRENT
#            END IF

            CALL axct310_get_xcco102_1_sum()
            #END add-point
            
         #此段落由子樣板a02產生
         AFTER FIELD xcco102g_1
            
            #add-point:AFTER FIELD xcco102c
#            IF NOT cl_ap_chk_Range(g_xcco1_d[l_ac].xcco102g_1,"0.000000","1","","","azz-00079",1) THEN
#               LET g_xcco1_d[l_ac].xcco102g_1 = g_xcco1_d_t.xcco102g_1
#               NEXT FIELD CURRENT
#            END IF

            CALL axct310_get_xcco102_1_sum()
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcco102h_1
            
            #add-point:AFTER FIELD xcco102c
#            IF NOT cl_ap_chk_Range(g_xcco1_d[l_ac].xcco102h_1,"0.000000","1","","","azz-00079",1) THEN
#               LET g_xcco1_d[l_ac].xcco102h_1 = g_xcco1_d_t.xcco102h_1
#               NEXT FIELD CURRENT
#            END IF

            CALL axct310_get_xcco102_1_sum()
            #END add-point
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_xcco1_d[l_ac].* = g_xcco1_d_t.*
               CLOSE axct310_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_xcco1_d[l_ac].xcco001_1
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_xcco1_d[l_ac].* = g_xcco1_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_xcco2_d[l_ac].xccomodid = g_user 
               LET g_xcco2_d[l_ac].xccomoddt = cl_get_current()
 
            
               #add-point:單身修改前
               LET g_xcco1_d_t.xcco001_1 = '2'
               #end add-point
         
               UPDATE xcco_t SET (xccold,xcco003,xcco004,xcco005,xcco001,xcco002,xcco006,xcco007,xcco008, 
                   xcco102a,xcco102b,xcco102c,xcco102d,xcco102e,xcco102f,xcco102g,xcco102h,xcco102,xccoownid,xccoowndp, 
                   xccocrtid,xccocrtdp,xccocrtdt,xccomodid,xccomoddt,xccocnfid,xccocnfdt,xccopstid,xccopstdt) = (g_xcco_m.xccold, 
                   g_xcco_m.xcco003,g_xcco_m.xcco004,g_xcco_m.xcco005,g_xcco1_d[l_ac].xcco001_1,g_xcco1_d[l_ac].xcco002_1, 
                   g_xcco1_d[l_ac].xcco006_1,g_xcco1_d[l_ac].xcco007_1,g_xcco1_d[l_ac].xcco008_1,
                   g_xcco1_d[l_ac].xcco102a_1,g_xcco1_d[l_ac].xcco102b_1,g_xcco1_d[l_ac].xcco102c_1,g_xcco1_d[l_ac].xcco102d_1, 
                   g_xcco1_d[l_ac].xcco102e_1,g_xcco1_d[l_ac].xcco102f_1,g_xcco1_d[l_ac].xcco102g_1,g_xcco1_d[l_ac].xcco102h_1,g_xcco1_d[l_ac].xcco102_1,
                   g_xcco2_d[l_ac].xccoownid,g_xcco2_d[l_ac].xccoowndp,g_xcco2_d[l_ac].xccocrtid,g_xcco2_d[l_ac].xccocrtdp, 
                   g_xcco2_d[l_ac].xccocrtdt,g_xcco2_d[l_ac].xccomodid,g_xcco2_d[l_ac].xccomoddt,g_xcco2_d[l_ac].xccocnfid, 
                   g_xcco2_d[l_ac].xccocnfdt,g_xcco2_d[l_ac].xccopstid,g_xcco2_d[l_ac].xccopstdt)
                WHERE xccoent = g_enterprise AND xccold = g_xcco_m.xccold 
                 AND xcco003 = g_xcco_m.xcco003 
                 AND xcco004 = g_xcco_m.xcco004 
                 AND xcco005 = g_xcco_m.xcco005
                 AND xcco009 = g_xcco_m.xcco009
 
                 AND xcco001 = g_xcco1_d_t.xcco001_1 #項次   
                 AND xcco002 = g_xcco1_d_t.xcco002_1  
                 AND xcco006 = g_xcco1_d_t.xcco006_1  
                 AND xcco007 = g_xcco1_d_t.xcco007_1
                 AND xcco008 = g_xcco1_d_t.xcco008_1                 
 
                 
               #add-point:單身修改中

               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "xcco_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   CALL cl_err("xcco_t",SQLCA.sqlcode,1)  
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcco_m.xccold
               LET gs_keys_bak[1] = g_xccold_t
               LET gs_keys[2] = g_xcco_m.xcco003
               LET gs_keys_bak[2] = g_xcco003_t
               LET gs_keys[3] = g_xcco_m.xcco004
               LET gs_keys_bak[3] = g_xcco004_t
               LET gs_keys[4] = g_xcco_m.xcco005
               LET gs_keys_bak[4] = g_xcco005_t
               LET gs_keys[5] = g_xcco_m.xcco009
               LET gs_keys_bak[5] = g_xcco009_t
               LET gs_keys[6] = g_xcco1_d[g_detail_idx].xcco001_1
               LET gs_keys_bak[6] = g_xcco1_d_t.xcco001_1
               LET gs_keys[7] = g_xcco1_d[g_detail_idx].xcco002_1
               LET gs_keys_bak[7] = g_xcco1_d_t.xcco002_1
               LET gs_keys[8] = g_xcco1_d[g_detail_idx].xcco006_1
               LET gs_keys_bak[8] = g_xcco1_d_t.xcco006_1
               LET gs_keys[9] = g_xcco1_d[g_detail_idx].xcco007_1
               LET gs_keys_bak[9] = g_xcco1_d_t.xcco007_1
               LET gs_keys[10] = g_xcco1_d[g_detail_idx].xcco008_1
               LET gs_keys_bak[10] = g_xcco1_d_t.xcco008_1
               CALL axct310_update_b('xcco_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
               END CASE
               
               #add-point:單身修改後

               #end add-point
            END IF
 
         AFTER INPUT   
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_xcco1_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_xcco1_d.getLength()+1
            
      END INPUT

       

      #Page3 預設值產生於此處
      INPUT ARRAY g_xcco3_d FROM s_detail4.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xcco_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
#            CALL axct310_b_fill_3(g_wc2) 
           IF g_glaa019 = 'Y' THEN
              CALL axct310_b_fill_3(g_wc2) 
           END IF  
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
            #add-point:資料輸入前

            #end add-point
         
         BEFORE ROW
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail4")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axct310_cl USING g_enterprise
                                                       ,g_xcco_m.xccold
                                                       ,g_xcco_m.xcco003
                                                       ,g_xcco_m.xcco004
                                                       ,g_xcco_m.xcco005
                                                       ,g_xcco_m.xcco009
 
                                               
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  STATUS
                  LET g_errparam.extend = "OPEN axct310_cl:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CLOSE axct310_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            
            IF g_rec_b >= l_ac 
               AND g_xcco3_d[l_ac].xcco001_3 IS NOT NULL
               AND g_xcco3_d[l_ac].xcco002_3 IS NOT NULL
               AND g_xcco3_d[l_ac].xcco006_3 IS NOT NULL
               AND g_xcco3_d[l_ac].xcco007_3 IS NOT NULL
               AND g_xcco3_d[l_ac].xcco008_3 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xcco3_d_t.* = g_xcco3_d[l_ac].*  #BACKUP
               CALL axct310_set_entry_b(l_cmd)
               CALL axct310_set_no_entry_b(l_cmd)
               OPEN axct310_bcl USING g_enterprise,g_xcco_m.xccold,
                                                g_xcco_m.xcco003,
                                                g_xcco_m.xcco004,
                                                g_xcco_m.xcco005,
                                                g_xcco_m.xcco009,   
 
                                                 g_xcco3_d_t.xcco001_3
                                                ,g_xcco3_d_t.xcco002_3
                                                ,g_xcco3_d_t.xcco006_3
                                                ,g_xcco3_d_t.xcco007_3
                                                ,g_xcco3_d_t.xcco008_3
 
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  STATUS
                  LET g_errparam.extend = "OPEN axct310_bcl:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw='Y'
               ELSE
#                  FETCH axct310_bcl INTO g_xcco3_d[l_ac].xcco001_3,g_xcco3_d[l_ac].xcco006_3, 
#                      g_xcco3_d[l_ac].xcco006_desc_3,g_xcco3_d[l_ac].xcco006_desc_1_3,g_xcco3_d[l_ac].imag014_3,
#                      g_xcco3_d[l_ac].xcco002_3,g_xcco3_d[l_ac].xcco002_desc_3,g_xcco3_d[l_ac].xcco007_3, 
#                      g_xcco3_d[l_ac].xcco102a_3,g_xcco3_d[l_ac].xcco102b_3,g_xcco3_d[l_ac].xcco102c_3, 
#                      g_xcco3_d[l_ac].xcco102d_3,g_xcco3_d[l_ac].xcco102e_3,g_xcco3_d[l_ac].xcco102f_3,g_xcco3_d[l_ac].xcco102g_3,g_xcco3_d[l_ac].xcco102h_3,g_xcco3_d[l_ac].xcco102_3,
#                      g_xcco2_d[l_ac].xcco001,g_xcco2_d[l_ac].xcco006,g_xcco2_d[l_ac].xcco002,g_xcco2_d[l_ac].xcco007, 
#                      g_xcco2_d[l_ac].xccoownid,g_xcco2_d[l_ac].xccoownid_desc,g_xcco2_d[l_ac].xccoowndp, 
#                      g_xcco2_d[l_ac].xccoowndp_desc,g_xcco2_d[l_ac].xccocrtid,g_xcco2_d[l_ac].xccocrtid_desc, 
#                      g_xcco2_d[l_ac].xccocrtdp,g_xcco2_d[l_ac].xccocrtdp_desc,g_xcco2_d[l_ac].xccocrtdt, 
#                      g_xcco2_d[l_ac].xccomodid,g_xcco2_d[l_ac].xccomodid_desc,g_xcco2_d[l_ac].xccomoddt, 
#                      g_xcco2_d[l_ac].xccocnfid,g_xcco2_d[l_ac].xccocnfid_desc,g_xcco2_d[l_ac].xccocnfdt, 
#                      g_xcco2_d[l_ac].xccopstid,g_xcco2_d[l_ac].xccopstid_desc,g_xcco2_d[l_ac].xccopstdt 

                  FETCH axct310_bcl INTO g_xcco3_d[l_ac].xcco001_3,g_xcco3_d[l_ac].xcco006_3, 
                      g_xcco3_d[l_ac].xcco007_3,g_xcco3_d[l_ac].xcco002_3,g_xcco3_d[l_ac].xcco008_3, 
                      g_xcco3_d[l_ac].xcco102a_3,g_xcco3_d[l_ac].xcco102b_3,g_xcco3_d[l_ac].xcco102c_3, 
                      g_xcco3_d[l_ac].xcco102d_3,g_xcco3_d[l_ac].xcco102e_3,g_xcco3_d[l_ac].xcco102f_3,g_xcco3_d[l_ac].xcco102g_3,g_xcco3_d[l_ac].xcco102h_3,g_xcco3_d[l_ac].xcco102_3,
                      g_xcco2_d[l_ac].xcco001,g_xcco2_d[l_ac].xcco006,g_xcco2_d[l_ac].xcco007,g_xcco2_d[l_ac].xcco002,g_xcco2_d[l_ac].xcco008,  
                      g_xcco2_d[l_ac].xccoownid,g_xcco2_d[l_ac].xccoowndp, 
                      g_xcco2_d[l_ac].xccocrtid,
                      g_xcco2_d[l_ac].xccocrtdp,g_xcco2_d[l_ac].xccocrtdt, 
                      g_xcco2_d[l_ac].xccomodid,g_xcco2_d[l_ac].xccomoddt, 
                      g_xcco2_d[l_ac].xccocnfid,g_xcco2_d[l_ac].xccocnfdt, 
                      g_xcco2_d[l_ac].xccopstid,g_xcco2_d[l_ac].xccopstdt 

                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = g_xcco3_d_t.xcco001_3
                      LET g_errparam.popup = TRUE
                      CALL cl_err()

                      LET l_lock_sw = "Y"
                  END IF
                  
                  CALL axct310_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            LET g_xcco3_d[l_ac].xcco001_3 = '3'
            #end add-point  
            
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_xcco3_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_xcco3_d.deleteElement(l_ac)
               NEXT FIELD xcco001
            END IF
            IF g_xcco3_d_t.xcco001_3 IS NOT NULL
               AND g_xcco3_d_t.xcco002_3 IS NOT NULL
               AND g_xcco3_d_t.xcco006_3 IS NOT NULL
               AND g_xcco3_d_t.xcco007_3 IS NOT NULL
 
               THEN
               
               #add-point:單身刪除前

               #end add-point
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF
               IF axct310_before_delete() THEN 
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axct310_bcl
               LET l_count = g_xcco3_d.getLength()
            END IF 
            
            #add-point:單身刪除後

            #end add-point
              
         AFTER DELETE 
            #add-point:單身AFTER DELETE 

            #end add-point            
 
         #此段落由子樣板a02產生
         AFTER FIELD xcco102a_3
            
            #add-point:AFTER FIELD xcco102a
#            IF NOT cl_ap_chk_Range(g_xcco3_d[l_ac].xcco102a_3,"0.000000","1","","","azz-00079",1) THEN
#               LET g_xcco3_d[l_ac].xcco102a_3 = g_xcco3_d_t.xcco102a_3
#               NEXT FIELD CURRENT
#            END IF

            CALL axct310_get_xcco102_3_sum()
            #END add-point
            
         #此段落由子樣板a02產生
         AFTER FIELD xcco102b_3
            
            #add-point:AFTER FIELD xcco102b
#            IF NOT cl_ap_chk_Range(g_xcco3_d[l_ac].xcco102b_3,"0.000000","1","","","azz-00079",1) THEN
#               LET g_xcco3_d[l_ac].xcco102b_3 = g_xcco3_d_t.xcco102b_3
#               NEXT FIELD CURRENT
#            END IF

            CALL axct310_get_xcco102_3_sum()
            #END add-point
            
         #此段落由子樣板a02產生
         AFTER FIELD xcco102c_3
            
            #add-point:AFTER FIELD xcco102c
#            IF NOT cl_ap_chk_Range(g_xcco3_d[l_ac].xcco102c_3,"0.000000","1","","","azz-00079",1) THEN
#               LET g_xcco3_d[l_ac].xcco102c_3 = g_xcco3_d_t.xcco102c_3
#               NEXT FIELD CURRENT
#            END IF

            CALL axct310_get_xcco102_3_sum()
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcco102d_3
            
            #add-point:AFTER FIELD xcco102c
#            IF NOT cl_ap_chk_Range(g_xcco3_d[l_ac].xcco102d_3,"0.000000","1","","","azz-00079",1) THEN
#               LET g_xcco3_d[l_ac].xcco102d_3 = g_xcco3_d_t.xcco102d_3
#               NEXT FIELD CURRENT
#            END IF

            CALL axct310_get_xcco102_3_sum()
            #END add-point
           
         #此段落由子樣板a02產生
         AFTER FIELD xcco102e_3
            
            #add-point:AFTER FIELD xcco102c
#            IF NOT cl_ap_chk_Range(g_xcco3_d[l_ac].xcco102e_3,"0.000000","1","","","azz-00079",1) THEN
#               LET g_xcco3_d[l_ac].xcco102e_3 = g_xcco3_d_t.xcco102e_3
#               NEXT FIELD CURRENT
#            END IF

            CALL axct310_get_xcco102_3_sum()
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcco102f_3
            
            #add-point:AFTER FIELD xcco102c
#            IF NOT cl_ap_chk_Range(g_xcco3_d[l_ac].xcco102f_3,"0.000000","1","","","azz-00079",1) THEN
#               LET g_xcco3_d[l_ac].xcco102f_3 = g_xcco3_d_t.xcco102f_3
#               NEXT FIELD CURRENT
#            END IF

            CALL axct310_get_xcco102_3_sum()
            #END add-point
            
         #此段落由子樣板a02產生
         AFTER FIELD xcco102g_3
            
            #add-point:AFTER FIELD xcco102c
#            IF NOT cl_ap_chk_Range(g_xcco3_d[l_ac].xcco102g_3,"0.000000","1","","","azz-00079",1) THEN
#               LET g_xcco3_d[l_ac].xcco102g_3 = g_xcco3_d_t.xcco102g_3
#               NEXT FIELD CURRENT
#            END IF

            CALL axct310_get_xcco102_3_sum()
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcco102h_3
            
            #add-point:AFTER FIELD xcco102c
#            IF NOT cl_ap_chk_Range(g_xcco3_d[l_ac].xcco102h_3,"0.000000","1","","","azz-00079",1) THEN
#               LET g_xcco3_d[l_ac].xcco102h_3 = g_xcco3_d_t.xcco102h_3
#               NEXT FIELD CURRENT
#            END IF

            CALL axct310_get_xcco102_3_sum()
            #END add-point
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_xcco3_d[l_ac].* = g_xcco3_d_t.*
               CLOSE axct310_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_xcco3_d[l_ac].xcco001_3
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_xcco3_d[l_ac].* = g_xcco3_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_xcco2_d[l_ac].xccomodid = g_user 
               LET g_xcco2_d[l_ac].xccomoddt = cl_get_current()
 
            
               #add-point:單身修改前
               LET g_xcco3_d_t.xcco001_3 = '3'
               #end add-point
         
               UPDATE xcco_t SET (xccold,xcco003,xcco004,xcco005,xcco001,xcco002,xcco006,xcco007, xcco008,
                   xcco102a,xcco102b,xcco102c,xcco102d,xcco102e,xcco102f,xcco102g,xcco102h,xcco102,xccoownid,xccoowndp, 
                   xccocrtid,xccocrtdp,xccocrtdt,xccomodid,xccomoddt,xccocnfid,xccocnfdt,xccopstid,xccopstdt) = (g_xcco_m.xccold, 
                   g_xcco_m.xcco003,g_xcco_m.xcco004,g_xcco_m.xcco005,g_xcco3_d[l_ac].xcco001_3,g_xcco3_d[l_ac].xcco002_3, 
                   g_xcco3_d[l_ac].xcco006_3,g_xcco3_d[l_ac].xcco007_3,g_xcco3_d[l_ac].xcco008_3,  
                   g_xcco3_d[l_ac].xcco102a_3,g_xcco3_d[l_ac].xcco102b_3,g_xcco3_d[l_ac].xcco102c_3,g_xcco3_d[l_ac].xcco102d_3, 
                   g_xcco3_d[l_ac].xcco102e_3,g_xcco3_d[l_ac].xcco102f_3,g_xcco3_d[l_ac].xcco102g_3,g_xcco3_d[l_ac].xcco102h_3,g_xcco3_d[l_ac].xcco102_3,
                   g_xcco2_d[l_ac].xccoownid,g_xcco2_d[l_ac].xccoowndp,g_xcco2_d[l_ac].xccocrtid,g_xcco2_d[l_ac].xccocrtdp, 
                   g_xcco2_d[l_ac].xccocrtdt,g_xcco2_d[l_ac].xccomodid,g_xcco2_d[l_ac].xccomoddt,g_xcco2_d[l_ac].xccocnfid, 
                   g_xcco2_d[l_ac].xccocnfdt,g_xcco2_d[l_ac].xccopstid,g_xcco2_d[l_ac].xccopstdt)
                WHERE xccoent = g_enterprise AND xccold = g_xcco_m.xccold 
                 AND xcco003 = g_xcco_m.xcco003 
                 AND xcco004 = g_xcco_m.xcco004 
                 AND xcco005 = g_xcco_m.xcco005
                 AND xcco009 = g_xcco_m.xcco009
 
                 AND xcco001 = g_xcco3_d_t.xcco001_3 #項次   
                 AND xcco002 = g_xcco3_d_t.xcco002_3  
                 AND xcco006 = g_xcco3_d_t.xcco006_3  
                 AND xcco007 = g_xcco3_d_t.xcco007_3 
                 AND xcco008 = g_xcco3_d_t.xcco008_3                  
 
                 
               #add-point:單身修改中

               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "xcco_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   CALL cl_err("xcco_t",SQLCA.sqlcode,1)  
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcco_m.xccold
               LET gs_keys_bak[1] = g_xccold_t
               LET gs_keys[2] = g_xcco_m.xcco003
               LET gs_keys_bak[2] = g_xcco003_t
               LET gs_keys[3] = g_xcco_m.xcco004
               LET gs_keys_bak[3] = g_xcco004_t
               LET gs_keys[4] = g_xcco_m.xcco005
               LET gs_keys_bak[4] = g_xcco005_t
               LET gs_keys[5] = g_xcco_m.xcco009
               LET gs_keys_bak[5] = g_xcco009_t
               LET gs_keys[6] = g_xcco3_d[g_detail_idx].xcco001_3
               LET gs_keys_bak[6] = g_xcco3_d_t.xcco001_3
               LET gs_keys[7] = g_xcco3_d[g_detail_idx].xcco002_3
               LET gs_keys_bak[7] = g_xcco3_d_t.xcco002_3
               LET gs_keys[8] = g_xcco3_d[g_detail_idx].xcco006_3
               LET gs_keys_bak[8] = g_xcco3_d_t.xcco006_3
               LET gs_keys[9] = g_xcco3_d[g_detail_idx].xcco007_3
               LET gs_keys_bak[9] = g_xcco3_d_t.xcco007_3
               LET gs_keys[10] = g_xcco3_d[g_detail_idx].xcco008_3
               LET gs_keys_bak[10] = g_xcco3_d_t.xcco008_3
               CALL axct310_update_b('xcco_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
               END CASE
               
               #add-point:單身修改後

               #end add-point
            END IF
 
         AFTER INPUT   
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_xcco3_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_xcco3_d.getLength()+1
            
      END INPUT

      
      #end add-point    
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:input段before_dialog name="input.before_dialog"
         IF p_cmd = 'a' THEN
            NEXT FIELD xccocomp
        ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xcco001
               WHEN "s_detail2"
                  NEXT FIELD xcco001_2
               WHEN "s_detail3"
                  NEXT FIELD xcco001_1               
               WHEN "s_detail4"
                  NEXT FIELD xcco001_3  
            END CASE
         END IF
  
         #end add-point 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
         CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx)
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD xccold
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xcco001
               WHEN "s_detail2"
                  NEXT FIELD xcco001_2
 
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
 
{<section id="axct310.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axct310_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
DEFINE l_date  DATE
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   IF g_xcco_m.xcco010 = '3' OR g_xcco_m.xcco010 = '4' THEN 
      CALL cl_set_act_visible("modify,modify_detail,delete", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,modify_detail,delete", TRUE)  
   END IF 
   
   CALL cl_get_para(g_enterprise,g_xcco_m.xccocomp,'S-FIN-6012') RETURNING l_date 
   IF g_xcco_m.xcco004 < YEAR(l_date) THEN 
      CALL cl_set_act_visible("modify,modify_detail,delete", FALSE)
   ELSE
      IF g_xcco_m.xcco004 = YEAR(l_date) THEN      #fengmy150202 add
         IF g_xcco_m.xcco005 <= MONTH(l_date) THEN
            CALL cl_set_act_visible("modify,modify_detail,delete", FALSE)
          ELSE
            CALL cl_set_act_visible("modify,modify_detail,delete", TRUE)       
         END IF
      #fengmy150202----begin         
      ELSE
         CALL cl_set_act_visible("modify,modify_detail,delete", TRUE) 
      END IF
      #fengmy150202----end  
   END IF 
   CALL cl_set_comp_entry("xcco010",FALSE)
   
   #特性
   IF cl_get_para(g_enterprise,g_site,'S-FIN-6013') = 'N' THEN
      CALL cl_set_comp_visible('xcco007,xcco007_1,xcco007_3',FALSE)
   ELSE
      CALL cl_set_comp_visible('xcco007,xcco007_1,xcco007_3',TRUE)
   END IF
   #成本域
   IF cl_get_para(g_enterprise,g_site,'S-FIN-6001') = 'N' THEN
      CALL cl_set_comp_visible('xcco002,xcco002_1,xcco002_3',FALSE)
      CALL cl_set_comp_visible('xcco002_desc,xcco002_desc_1,xcco002_desc_3',FALSE)
   ELSE   
      CALL cl_set_comp_visible('xcco002,xcco002_1,xcco002_3',TRUE)
      CALL cl_set_comp_visible('xcco002_desc,xcco002_desc_1,xcco002_desc_3',TRUE)   
   END IF    
   
   IF g_bfill = "Y" THEN
      CALL axct310_b_fill_1(g_wc2) #單身填充
      CALL axct310_b_fill_3(g_wc2) #單身填充
   END IF
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL axct310_b_fill(g_wc2) #第一階單身填充
      CALL axct310_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axct310_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_xcco_m.xccocomp,g_xcco_m.xccocomp_desc,g_xcco_m.xcco004,g_xcco_m.xcco005,g_xcco_m.xccold, 
       g_xcco_m.xccold_desc,g_xcco_m.xcco003,g_xcco_m.xcco003_desc,g_xcco_m.xcco009,g_xcco_m.xcco010 
 
 
   CALL axct310_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
#   CALL axct310_b_fill_1(g_wc3) #單身填充
#   CALL axct310_b_fill_3(g_wc3) #單身填充
   IF g_glaa015 = 'Y' THEN 
      CALL axct310_b_fill_1(g_wc3) #單身填充
   END IF
   IF g_glaa019 = 'Y' THEN 
      CALL axct310_b_fill_3(g_wc3) #單身填充
   END IF
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axct310.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION axct310_ref_show()
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
            CALL axct310_page_visible()
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcco_m.xccocomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcco_m.xccocomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcco_m.xccocomp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcco_m.xccold
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcco_m.xccold_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcco_m.xccold_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcco_m.xcco003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcco_m.xcco003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcco_m.xcco003_desc


   #讀入ref值(單身)
   FOR l_ac = 1 TO g_xcco1_d.getLength()
      #add-point:ref_show段d_reference
      CALL axct310_get_xcco006_1_desc()
      CALL axct310_get_xcco002_1_desc()
      CALL axct310_get_imag014_1()
      #end add-point
   END FOR 

   FOR l_ac = 1 TO g_xcco3_d.getLength()
      #add-point:ref_show段d_reference
      CALL axct310_get_xcco006_3_desc()
      CALL axct310_get_xcco002_3_desc()
      CALL axct310_get_imag014_3()
      #end add-point
   END FOR  
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_xcco_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
            CALL axct310_get_imag014() 
 
            CALL axct310_get_xcco006_desc()
            
            CALL axct310_get_xcco002_desc()

      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_xcco2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
      IF NOT cl_null(g_xcco2_d[l_ac].xccoownid) THEN LET g_xcco2_d[l_ac].xccoownid_desc = cl_get_username(g_xcco2_d[l_ac].xccoownid) END IF
      IF NOT cl_null(g_xcco2_d[l_ac].xccoowndp) THEN LET g_xcco2_d[l_ac].xccoowndp_desc = cl_get_deptname(g_xcco2_d[l_ac].xccoowndp) END IF
      IF NOT cl_null(g_xcco2_d[l_ac].xccocrtid) THEN LET g_xcco2_d[l_ac].xccocrtid_desc = cl_get_username(g_xcco2_d[l_ac].xccocrtid) END IF
      IF NOT cl_null(g_xcco2_d[l_ac].xccocrtdp) THEN LET g_xcco2_d[l_ac].xccocrtdp_desc = cl_get_deptname(g_xcco2_d[l_ac].xccocrtdp) END IF
      IF NOT cl_null(g_xcco2_d[l_ac].xccomodid) THEN LET g_xcco2_d[l_ac].xccomodid_desc = cl_get_username(g_xcco2_d[l_ac].xccomodid) END IF
      IF NOT cl_null(g_xcco2_d[l_ac].xccocnfid) THEN LET g_xcco2_d[l_ac].xccocnfid_desc = cl_get_deptname(g_xcco2_d[l_ac].xccocnfid) END IF
      IF NOT cl_null(g_xcco2_d[l_ac].xccopstid) THEN LET g_xcco2_d[l_ac].xccopstid_desc = cl_get_deptname(g_xcco2_d[l_ac].xccopstid) END IF  
      DISPLAY BY NAME g_xcco2_d[l_ac].xccoownid_desc
      DISPLAY BY NAME g_xcco2_d[l_ac].xccoowndp_desc
      DISPLAY BY NAME g_xcco2_d[l_ac].xccocrtid_desc
      DISPLAY BY NAME g_xcco2_d[l_ac].xccocrtdp_desc
      DISPLAY BY NAME g_xcco2_d[l_ac].xccomodid_desc
      DISPLAY BY NAME g_xcco2_d[l_ac].xccocnfid_desc
      DISPLAY BY NAME g_xcco2_d[l_ac].xccopstid_desc 
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="axct310.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axct310_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE xcco_t.xccold 
   DEFINE l_oldno     LIKE xcco_t.xccold 
   DEFINE l_newno02     LIKE xcco_t.xcco003 
   DEFINE l_oldno02     LIKE xcco_t.xcco003 
   DEFINE l_newno03     LIKE xcco_t.xcco004 
   DEFINE l_oldno03     LIKE xcco_t.xcco004 
   DEFINE l_newno04     LIKE xcco_t.xcco005 
   DEFINE l_oldno04     LIKE xcco_t.xcco005 
   DEFINE l_newno05     LIKE xcco_t.xcco009 
   DEFINE l_oldno05     LIKE xcco_t.xcco009 
 
   DEFINE l_master    RECORD LIKE xcco_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xcco_t.* #此變數樣板目前無使用
 
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
 
   IF g_xcco_m.xccold IS NULL
      OR g_xcco_m.xcco003 IS NULL
      OR g_xcco_m.xcco004 IS NULL
      OR g_xcco_m.xcco005 IS NULL
      OR g_xcco_m.xcco009 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_xccold_t = g_xcco_m.xccold
   LET g_xcco003_t = g_xcco_m.xcco003
   LET g_xcco004_t = g_xcco_m.xcco004
   LET g_xcco005_t = g_xcco_m.xcco005
   LET g_xcco009_t = g_xcco_m.xcco009
 
   
   LET g_xcco_m.xccold = ""
   LET g_xcco_m.xcco003 = ""
   LET g_xcco_m.xcco004 = ""
   LET g_xcco_m.xcco005 = ""
   LET g_xcco_m.xcco009 = ""
 
   LET g_master_insert = FALSE
   CALL axct310_set_entry('a')
   CALL axct310_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_xcco_m.xccocomp = ''
   LET g_xcco_m.xccocomp_desc = ''
   DISPLAY BY NAME g_xcco_m.xccocomp_desc
   LET g_xcco_m.xccold_desc = ''
   DISPLAY BY NAME g_xcco_m.xccold_desc
   LET g_xcco_m.xcco003_desc = ''
   DISPLAY BY NAME g_xcco_m.xcco003_desc
   #end add-point
   
   #清空key欄位的desc
      LET g_xcco_m.xccold_desc = ''
   DISPLAY BY NAME g_xcco_m.xccold_desc
   LET g_xcco_m.xcco003_desc = ''
   DISPLAY BY NAME g_xcco_m.xcco003_desc
 
   
   CALL axct310_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_xcco_m.* TO NULL
      INITIALIZE g_xcco_d TO NULL
      INITIALIZE g_xcco2_d TO NULL
 
      CALL axct310_show()
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
   CALL axct310_set_act_visible()
   CALL axct310_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xccold_t = g_xcco_m.xccold
   LET g_xcco003_t = g_xcco_m.xcco003
   LET g_xcco004_t = g_xcco_m.xcco004
   LET g_xcco005_t = g_xcco_m.xcco005
   LET g_xcco009_t = g_xcco_m.xcco009
 
   
   #組合新增資料的條件
   LET g_add_browse = " xccoent = " ||g_enterprise|| " AND",
                      " xccold = '", g_xcco_m.xccold, "' "
                      ," AND xcco003 = '", g_xcco_m.xcco003, "' "
                      ," AND xcco004 = '", g_xcco_m.xcco004, "' "
                      ," AND xcco005 = '", g_xcco_m.xcco005, "' "
                      ," AND xcco009 = '", g_xcco_m.xcco009, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axct310_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL axct310_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL axct310_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="axct310.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axct310_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xcco_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   DEFINE l_n        LIKE type_t.num5
   DEFINE l_xcco006  LIKE xcco_t.xcco006
   DEFINE l_msg      STRING 
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axct310_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xcco_t
    WHERE xccoent = g_enterprise AND xccold = g_xccold_t
    AND xcco003 = g_xcco003_t
    AND xcco004 = g_xcco004_t
    AND xcco005 = g_xcco005_t
    AND xcco009 = g_xcco009_t
 
       INTO TEMP axct310_detail
   
   #將key修正為調整後   
   UPDATE axct310_detail 
      #更新key欄位
      SET xccold = g_xcco_m.xccold
          , xcco003 = g_xcco_m.xcco003
          , xcco004 = g_xcco_m.xcco004
          , xcco005 = g_xcco_m.xcco005
          , xcco009 = g_xcco_m.xcco009
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , xccoownid = g_user 
       , xccoowndp = g_dept
       , xccocrtid = g_user
       , xccocrtdp = g_dept 
       , xccocrtdt = ld_date
       , xccomodid = g_user
       , xccomoddt = ld_date
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO xcco_t SELECT * FROM axct310_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   UPDATE xcco_t SET xccocomp = g_xcco_m.xccocomp,
                     xcco010 = g_xcco_m.xcco010 
                 WHERE xccoent = g_enterprise AND xccold = g_xcco_m.xccold
                   AND xcco003 = g_xcco_m.xcco003
                   AND xcco004 = g_xcco_m.xcco004
                   AND xcco005 = g_xcco_m.xcco005
                   AND xcco009 = g_xcco_m.xcco009    
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axct310_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
    LET l_xcco006 = ''
    LET l_msg = ''
    LET g_sql = " SELECT DISTINCT xcco006 FROM xcco_t ",
                "  WHERE xccoent = '",g_enterprise,"' AND xccold = '",g_xcco_m.xccold,"'",
                "    AND xcco003 = '",g_xcco_m.xcco003,"'",
                "    AND xcco004 = ",g_xcco_m.xcco004, 
                "    AND xcco005 = ",g_xcco_m.xcco005, 
                "    AND xcco009 = '",g_xcco_m.xcco009,"'"  
     PREPARE axct310_pb_chk FROM g_sql
     DECLARE axct310_cs_chk CURSOR FOR axct310_pb_chk  
     FOREACH axct310_cs_chk INTO l_xcco006
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "axct310_cs_chk"
           LET g_errparam.popup = TRUE
           CALL cl_err()

           RETURN
        END IF   
        
        LET l_n = 0
      
        IF NOT cl_null(l_xcco006) THEN 
           SELECT COUNT(*) INTO l_n FROM imag_t
            WHERE imagent = g_enterprise
              AND imag001 = l_xcco006
              AND imagstus = 'Y'
              AND imagsite IN (SELECT ooef001 FROM ooef_t  
                                WHERE ooef201 = 'Y' AND ooef017 = g_xcco_m.xccocomp AND ooefent = g_enterprise)
           IF l_n = 0 THEN 
              LET l_msg = l_msg,l_xcco006 
#              UPDATE xcco_t SET xcco006 = '',
#                                xcco002 = '',
#                                xcco007 = ''
#                    WHERE xccoent = g_enterprise AND xccold = g_xcco_m.xccold
#                      AND xcco003 = g_xcco_m.xcco003
#                      AND xcco004 = g_xcco_m.xcco004
#                      AND xcco005 = g_xcco_m.xcco005
#                      AND xcco009 = g_xcco_m.xcco009                    
           END IF           
        END IF
     END FOREACH   
     IF NOT cl_null(l_msg) THEN 
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = 'axc-00282'
        LET g_errparam.extend = l_msg
        LET g_errparam.popup = TRUE
        CALL cl_err()

        LET l_msg = ''
     END IF     
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xccold_t = g_xcco_m.xccold
   LET g_xcco003_t = g_xcco_m.xcco003
   LET g_xcco004_t = g_xcco_m.xcco004
   LET g_xcco005_t = g_xcco_m.xcco005
   LET g_xcco009_t = g_xcco_m.xcco009
 
   
   DROP TABLE axct310_detail
   
END FUNCTION
 
{</section>}
 
{<section id="axct310.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axct310_delete()
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
   
   IF g_xcco_m.xccold IS NULL
   OR g_xcco_m.xcco003 IS NULL
   OR g_xcco_m.xcco004 IS NULL
   OR g_xcco_m.xcco005 IS NULL
   OR g_xcco_m.xcco009 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN axct310_cl USING g_enterprise,g_xcco_m.xccold,g_xcco_m.xcco003,g_xcco_m.xcco004,g_xcco_m.xcco005,g_xcco_m.xcco009
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axct310_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axct310_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axct310_master_referesh USING g_xcco_m.xccold,g_xcco_m.xcco003,g_xcco_m.xcco004,g_xcco_m.xcco005, 
       g_xcco_m.xcco009 INTO g_xcco_m.xccocomp,g_xcco_m.xcco004,g_xcco_m.xcco005,g_xcco_m.xccold,g_xcco_m.xcco003, 
       g_xcco_m.xcco009,g_xcco_m.xcco010,g_xcco_m.xccocomp_desc,g_xcco_m.xccold_desc,g_xcco_m.xcco003_desc 
 
   
   #遮罩相關處理
   LET g_xcco_m_mask_o.* =  g_xcco_m.*
   CALL axct310_xcco_t_mask()
   LET g_xcco_m_mask_n.* =  g_xcco_m.*
   
   CALL axct310_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axct310_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM xcco_t WHERE xccoent = g_enterprise AND xccold = g_xcco_m.xccold
                                                               AND xcco003 = g_xcco_m.xcco003
                                                               AND xcco004 = g_xcco_m.xcco004
                                                               AND xcco005 = g_xcco_m.xcco005
                                                               AND xcco009 = g_xcco_m.xcco009
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcco_t:",SQLERRMESSAGE 
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
      #   CLOSE axct310_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_xcco_d.clear() 
      CALL g_xcco2_d.clear()       
 
     
      CALL axct310_ui_browser_refresh()  
      #CALL axct310_ui_headershow()  
      #CALL axct310_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL axct310_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL axct310_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE axct310_cl
 
   #功能已完成,通報訊息中心
   CALL axct310_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axct310.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axct310_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_xcco_d.clear()
   CALL g_xcco2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_wc3 = g_wc2_table1 
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT xcco001,xcco006,xcco007,xcco002,xcco008,xcco011,xcco102a,xcco102b,xcco102c, 
       xcco102d,xcco102e,xcco102f,xcco102g,xcco102h,xcco102,xcco001,xcco006,xcco007,xcco002,xcco008, 
       xccoownid,xccoowndp,xccocrtid,xccocrtdp,xccocrtdt,xccomodid,xccomoddt,xccocnfid,xccocnfdt,xccopstid, 
       xccopstdt,t1.imaal003 ,t2.xcbfl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011 , 
       t8.ooag011 ,t9.ooag011 FROM xcco_t",   
               "",
               
                              " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=xcco006 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN xcbfl_t t2 ON t2.xcbflent="||g_enterprise||" AND t2.xcbflcomp=xccocomp AND t2.xcbfl001=xcco002 AND t2.xcbfl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=xccoownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=xccoowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=xccocrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=xccocrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=xccomodid  ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=xccocnfid  ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=xccopstid  ",
 
               " WHERE xccoent= ? AND xccold=? AND xcco003=? AND xcco004=? AND xcco005=? AND xcco009=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcco_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = g_sql CLIPPED," AND xcco001 = '1' " 
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axct310_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY xcco_t.xcco001,xcco_t.xcco002,xcco_t.xcco006,xcco_t.xcco007,xcco_t.xcco008"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axct310_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axct310_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xcco_m.xccold,g_xcco_m.xcco003,g_xcco_m.xcco004,g_xcco_m.xcco005,g_xcco_m.xcco009   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xcco_m.xccold,g_xcco_m.xcco003,g_xcco_m.xcco004,g_xcco_m.xcco005, 
          g_xcco_m.xcco009 INTO g_xcco_d[l_ac].xcco001,g_xcco_d[l_ac].xcco006,g_xcco_d[l_ac].xcco007, 
          g_xcco_d[l_ac].xcco002,g_xcco_d[l_ac].xcco008,g_xcco_d[l_ac].xcco011,g_xcco_d[l_ac].xcco102a, 
          g_xcco_d[l_ac].xcco102b,g_xcco_d[l_ac].xcco102c,g_xcco_d[l_ac].xcco102d,g_xcco_d[l_ac].xcco102e, 
          g_xcco_d[l_ac].xcco102f,g_xcco_d[l_ac].xcco102g,g_xcco_d[l_ac].xcco102h,g_xcco_d[l_ac].xcco102, 
          g_xcco2_d[l_ac].xcco001,g_xcco2_d[l_ac].xcco006,g_xcco2_d[l_ac].xcco007,g_xcco2_d[l_ac].xcco002, 
          g_xcco2_d[l_ac].xcco008,g_xcco2_d[l_ac].xccoownid,g_xcco2_d[l_ac].xccoowndp,g_xcco2_d[l_ac].xccocrtid, 
          g_xcco2_d[l_ac].xccocrtdp,g_xcco2_d[l_ac].xccocrtdt,g_xcco2_d[l_ac].xccomodid,g_xcco2_d[l_ac].xccomoddt, 
          g_xcco2_d[l_ac].xccocnfid,g_xcco2_d[l_ac].xccocnfdt,g_xcco2_d[l_ac].xccopstid,g_xcco2_d[l_ac].xccopstdt, 
          g_xcco_d[l_ac].xcco006_desc,g_xcco_d[l_ac].xcco002_desc,g_xcco2_d[l_ac].xccoownid_desc,g_xcco2_d[l_ac].xccoowndp_desc, 
          g_xcco2_d[l_ac].xccocrtid_desc,g_xcco2_d[l_ac].xccocrtdp_desc,g_xcco2_d[l_ac].xccomodid_desc, 
          g_xcco2_d[l_ac].xccocnfid_desc,g_xcco2_d[l_ac].xccopstid_desc   #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
         CALL s_feature_description(g_xcco_d[l_ac].xcco006,g_xcco_d[l_ac].xcco007) RETURNING l_success,g_xcco_d[l_ac].xcco007_desc   #150724-00005#1 add
         DISPLAY BY NAME g_xcco_d[l_ac].xcco007_desc    #150724-00005#1 add
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
 
            CALL g_xcco_d.deleteElement(g_xcco_d.getLength())
      CALL g_xcco2_d.deleteElement(g_xcco2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_xcco_d.getLength()
      LET g_xcco_d_mask_o[l_ac].* =  g_xcco_d[l_ac].*
      CALL axct310_xcco_t_mask()
      LET g_xcco_d_mask_n[l_ac].* =  g_xcco_d[l_ac].*
   END FOR
   
   LET g_xcco2_d_mask_o.* =  g_xcco2_d.*
   FOR l_ac = 1 TO g_xcco2_d.getLength()
      LET g_xcco2_d_mask_o[l_ac].* =  g_xcco2_d[l_ac].*
      CALL axct310_xcco_t_mask()
      LET g_xcco2_d_mask_n[l_ac].* =  g_xcco2_d[l_ac].*
   END FOR
 
 
   FREE axct310_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="axct310.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axct310_idx_chk()
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
      IF g_detail_idx > g_xcco_d.getLength() THEN
         LET g_detail_idx = g_xcco_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_xcco_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xcco_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_xcco2_d.getLength() THEN
         LET g_detail_idx = g_xcco2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xcco2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xcco2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axct310.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axct310_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_xcco_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axct310.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION axct310_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM xcco_t
    WHERE xccoent = g_enterprise AND xccold = g_xcco_m.xccold AND
                              xcco003 = g_xcco_m.xcco003 AND
                              xcco004 = g_xcco_m.xcco004 AND
                              xcco005 = g_xcco_m.xcco005 AND
                              xcco009 = g_xcco_m.xcco009 AND
 
          xcco001 = g_xcco_d_t.xcco001
      AND xcco002 = g_xcco_d_t.xcco002
      AND xcco006 = g_xcco_d_t.xcco006
      AND xcco007 = g_xcco_d_t.xcco007
      AND xcco008 = g_xcco_d_t.xcco008
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcco_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE 
   END IF
   
   #add-point:單筆刪除後 name="delete.body.a_single_delete"
   DELETE FROM xcco_t
    WHERE xccoent = g_enterprise AND xccold = g_xcco_m.xccold AND
                              xcco003 = g_xcco_m.xcco003 AND
                              xcco004 = g_xcco_m.xcco004 AND
                              xcco005 = g_xcco_m.xcco005 AND
                              xcco009 = g_xcco_m.xcco009 AND
 
          xcco001 IN ('2','3')
      AND xcco002 = g_xcco_d_t.xcco002
      AND xcco006 = g_xcco_d_t.xcco006
      AND xcco007 = g_xcco_d_t.xcco007
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "xcco_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE 
   END IF
      
   #end add-point
 
   LET g_rec_b = g_rec_b-1
   DISPLAY g_rec_b TO FORMONLY.cnt
 
   RETURN TRUE
    
END FUNCTION
 
{</section>}
 
{<section id="axct310.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axct310_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="axct310.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axct310_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="axct310.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axct310_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="axct310.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION axct310_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_xcco_d[l_ac].xcco001 = g_xcco_d_t.xcco001 
      AND g_xcco_d[l_ac].xcco002 = g_xcco_d_t.xcco002 
      AND g_xcco_d[l_ac].xcco006 = g_xcco_d_t.xcco006 
      AND g_xcco_d[l_ac].xcco007 = g_xcco_d_t.xcco007 
      AND g_xcco_d[l_ac].xcco008 = g_xcco_d_t.xcco008 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="axct310.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axct310_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="axct310.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axct310_lock_b(ps_table,ps_page)
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
   #CALL axct310_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axct310.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axct310_unlock_b(ps_table,ps_page)
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
 
{<section id="axct310.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axct310_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xccold,xcco003,xcco004,xcco005,xcco009",TRUE)
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
 
{<section id="axct310.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axct310_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xccold,xcco003,xcco004,xcco005,xcco009",FALSE)
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
 
{<section id="axct310.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axct310_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   CALL cl_set_comp_entry("xcco006_1,xcco006_desc_1,xcco006_desc_1_1,imag014_1,xcco002_1,xcco007_1",FALSE)
   CALL cl_set_comp_entry("xcco006_3,xcco006_desc_3,xcco006_desc_1_3,imag014_3,xcco002_3,xcco007_3",FALSE)
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axct310.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axct310_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   CALL cl_set_comp_entry("xcco006_1,xcco006_desc_1,xcco006_desc_1_1,imag014_1,xcco002_1,xcco007_1",FALSE)
   CALL cl_set_comp_entry("xcco006_3,xcco006_desc_3,xcco006_desc_1_3,imag014_3,xcco002_3,xcco007_3",FALSE)
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axct310.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axct310_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axct310.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axct310_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axct310.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axct310_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axct310.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axct310_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axct310.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axct310_default_search()
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
      LET ls_wc = ls_wc, " xccold = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xcco003 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xcco004 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " xcco005 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " xcco009 = '", g_argv[05], "' AND "
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
 
{<section id="axct310.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axct310_fill_chk(ps_idx)
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
 
{<section id="axct310.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION axct310_modify_detail_chk(ps_record)
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
         LET ls_return = "xcco001"
      WHEN "s_detail2"
         LET ls_return = "xcco001_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="axct310.mask_functions" >}
&include "erp/axc/axct310_mask.4gl"
 
{</section>}
 
{<section id="axct310.state_change" >}
    
 
{</section>}
 
{<section id="axct310.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axct310_set_pk_array()
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
   LET g_pk_array[1].values = g_xcco_m.xccold
   LET g_pk_array[1].column = 'xccold'
   LET g_pk_array[2].values = g_xcco_m.xcco003
   LET g_pk_array[2].column = 'xcco003'
   LET g_pk_array[3].values = g_xcco_m.xcco004
   LET g_pk_array[3].column = 'xcco004'
   LET g_pk_array[4].values = g_xcco_m.xcco005
   LET g_pk_array[4].column = 'xcco005'
   LET g_pk_array[5].values = g_xcco_m.xcco009
   LET g_pk_array[5].column = 'xcco009'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axct310.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axct310_msgcentre_notify(lc_state)
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
   CALL axct310_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xcco_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axct310.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 獲取法人說明
# Memo...........:
# Usage..........: CALL axct310_get_xccocomp_desc()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/8 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct310_get_xccocomp_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcco_m.xccocomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcco_m.xccocomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcco_m.xccocomp_desc
END FUNCTION

################################################################################
# Descriptions...: 獲取帳套說明
# Memo...........:
# Usage..........: CALL axct310_get_xccold_desc()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/8 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct310_get_xccold_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcco_m.xccold
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcco_m.xccold_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcco_m.xccold_desc
END FUNCTION

################################################################################
# Descriptions...: 獲取料件品名規格
# Memo...........:
# Usage..........: CALL axct310_get_xcco006_desc()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/8 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct310_get_xcco006_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcco_d[l_ac].xcco006
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcco_d[l_ac].xcco006_desc = '', g_rtn_fields[1] , ''
            LET g_xcco_d[l_ac].xcco006_1_desc = '', g_rtn_fields[2] , ''
            DISPLAY BY NAME g_xcco_d[l_ac].xcco006_desc
            DISPLAY BY NAME g_xcco_d[l_ac].xcco006_1_desc
END FUNCTION

################################################################################
# Descriptions...: 獲取成本計算類型說明
# Memo...........:
# Usage..........: CALL axct310_get_xcco003_desc()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/9 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct310_get_xcco003_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcco_m.xcco003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcco_m.xcco003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcco_m.xcco003_desc
END FUNCTION

################################################################################
# Descriptions...: 獲取成本單位
# Memo...........:
# Usage..........: CALL axct310_get_imag014()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/8 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct310_get_imag014()
   
#   SELECT imag014 INTO g_xcco_d[l_ac].imag014 FROM imag_t
#    WHERE imagent = g_enterprise 
#      AND imagsite = g_site
#      AND imag001 = g_xcco_d[l_ac].xcco006
   #變更單位從axci120,xcbb005獲取
   SELECT xcbb005 INTO g_xcco_d[l_ac].imag014 FROM xcbb_t
    WHERE xcbbent  = g_enterprise 
      AND xcbbcomp = g_xcco_m.xccocomp
      AND xcbb001  = g_xcco_m.xcco004
      AND xcbb002  = g_xcco_m.xcco005
      AND xcbb003  = g_xcco_d[l_ac].xcco006
   DISPLAY BY NAME g_xcco_d[l_ac].imag014    
END FUNCTION

################################################################################
# Descriptions...: 獲取成本域說明
# Memo...........:
# Usage..........: CALL axct310_get_xcco002_desc()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/8 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct310_get_xcco002_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcco_m.xccocomp
            LET g_ref_fields[2] = g_xcco_d[l_ac].xcco002
            CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp=? AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcco_d[l_ac].xcco002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcco_d[l_ac].xcco002_desc
END FUNCTION

################################################################################
# Descriptions...: 獲取料件品名規格-功能幣二
# Memo...........:
# Usage..........: CALL axct310_get_xcco006_1_desc()
# Input parameter:  
# Return code....: 
# Date & Author..: 2014/4/11 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct310_get_xcco006_1_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcco1_d[l_ac].xcco006_1
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcco1_d[l_ac].xcco006_desc_1 = '', g_rtn_fields[1] , ''
            LET g_xcco1_d[l_ac].xcco006_desc_1_1 = '', g_rtn_fields[2] , ''
            DISPLAY BY NAME g_xcco1_d[l_ac].xcco006_desc_1
            DISPLAY BY NAME g_xcco1_d[l_ac].xcco006_desc_1_1
END FUNCTION

################################################################################
# Descriptions...: 獲取成本單位-功能幣二
# Memo...........:
# Usage..........: CALL axct310_get_imag014_1()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/11 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct310_get_imag014_1()
#   SELECT imag014 INTO g_xcco1_d[l_ac].imag014_1 FROM imag_t
#    WHERE imagent = g_enterprise 
#      AND imagsite = g_site
#      AND imag001 = g_xcco1_d[l_ac].xcco006_1
   #變更單位從axci120,xcbb005獲取
   SELECT xcbb005 INTO g_xcco1_d[l_ac].imag014_1 FROM xcbb_t
    WHERE xcbbent  = g_enterprise 
      AND xcbbcomp = g_xcco_m.xccocomp
      AND xcbb001  = g_xcco_m.xcco004
      AND xcbb002  = g_xcco_m.xcco005
      AND xcbb003  = g_xcco1_d[l_ac].xcco006_1
   DISPLAY BY NAME g_xcco1_d[l_ac].imag014_1   
END FUNCTION

################################################################################
# Descriptions...: 獲取成本域說明-功能幣二
# Memo...........:
# Usage..........: CALL axct310_get_xcco002_1_desc()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/11 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct310_get_xcco002_1_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcco_m.xccocomp
            LET g_ref_fields[2] = g_xcco1_d[l_ac].xcco002_1
            CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp=? AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcco1_d[l_ac].xcco002_desc_1 = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcco1_d[l_ac].xcco002_desc_1
END FUNCTION

################################################################################
# Descriptions...: 獲取料件品名規格-功能幣三
# Memo...........:
# Usage..........: CALL axct310_get_xcco006_3_desc()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/11 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct310_get_xcco006_3_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcco3_d[l_ac].xcco006_3
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcco3_d[l_ac].xcco006_desc_3 = '', g_rtn_fields[1] , ''
            LET g_xcco3_d[l_ac].xcco006_desc_1_3 = '', g_rtn_fields[2] , ''
            DISPLAY BY NAME g_xcco3_d[l_ac].xcco006_desc_3
            DISPLAY BY NAME g_xcco3_d[l_ac].xcco006_desc_1_3
END FUNCTION

################################################################################
# Descriptions...: 獲取成本單位-功能幣三
# Memo...........:
# Usage..........: CALL axct310_get_imag014_3()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/11 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct310_get_imag014_3()
#   SELECT imag014 INTO g_xcco3_d[l_ac].imag014_3 FROM imag_t
#    WHERE imagent = g_enterprise 
#      AND imagsite = g_site
#      AND imag001 = g_xcco3_d[l_ac].xcco006_3
   #變更單位從axci120,xcbb005獲取
   SELECT xcbb005 INTO g_xcco3_d[l_ac].imag014_3 FROM xcbb_t
    WHERE xcbbent  = g_enterprise 
      AND xcbbcomp = g_xcco_m.xccocomp
      AND xcbb001  = g_xcco_m.xcco004
      AND xcbb002  = g_xcco_m.xcco005
      AND xcbb003  = g_xcco3_d[l_ac].xcco006_3
   DISPLAY BY NAME g_xcco3_d[l_ac].imag014_3
END FUNCTION

################################################################################
# Descriptions...: 獲取成本域說明-功能幣三
# Memo...........:
# Usage..........: CALL axct310_get_xcco002_3_desc()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/11 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct310_get_xcco002_3_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcco_m.xccocomp
            LET g_ref_fields[2] = g_xcco3_d[l_ac].xcco002_3
            CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp=? AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcco3_d[l_ac].xcco002_desc_3 = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcco3_d[l_ac].xcco002_desc_3
END FUNCTION

################################################################################
# Descriptions...: 功能幣二、三頁簽顯示否
# Memo...........:
# Usage..........: CALL axct310_page_visible()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/11 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct310_page_visible()
   SELECT glaa001,glaa015,glaa016,glaa018,glaa019,glaa020,glaa022 
     INTO g_glaa001,g_glaa015,g_glaa016,g_glaa018,g_glaa019,g_glaa020,g_glaa022 
     FROM glaa_t
    WHERE glaaent = g_enterprise 
      AND glaald = g_xcco_m.xccold
      
   IF g_glaa015 = 'Y' THEN
      CALL cl_set_comp_visible("bpage_2",TRUE)
   ELSE
      CALL cl_set_comp_visible("bpage_2",FALSE) 
   END IF
   IF g_glaa019 = 'Y' THEN
      CALL cl_set_comp_visible("bpage_3",TRUE)
   ELSE
      CALL cl_set_comp_visible("bpage_3",FALSE)
   END IF  
END FUNCTION

################################################################################
# Descriptions...: 調整成本
# Memo...........:
# Usage..........: CALL axct310_get_xcco102_sum()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/11 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct310_get_xcco102_sum()
   IF cl_null(g_xcco_d[l_ac].xcco102a) THEN LET g_xcco_d[l_ac].xcco102a = 0 END IF
   IF cl_null(g_xcco_d[l_ac].xcco102b) THEN LET g_xcco_d[l_ac].xcco102b = 0 END IF
   IF cl_null(g_xcco_d[l_ac].xcco102c) THEN LET g_xcco_d[l_ac].xcco102c = 0 END IF
   IF cl_null(g_xcco_d[l_ac].xcco102d) THEN LET g_xcco_d[l_ac].xcco102d = 0 END IF
   IF cl_null(g_xcco_d[l_ac].xcco102e) THEN LET g_xcco_d[l_ac].xcco102e = 0 END IF
   IF cl_null(g_xcco_d[l_ac].xcco102f) THEN LET g_xcco_d[l_ac].xcco102f = 0 END IF
   IF cl_null(g_xcco_d[l_ac].xcco102g) THEN LET g_xcco_d[l_ac].xcco102g = 0 END IF
   IF cl_null(g_xcco_d[l_ac].xcco102h) THEN LET g_xcco_d[l_ac].xcco102h = 0 END IF
   
   LET g_xcco_d[l_ac].xcco102=g_xcco_d[l_ac].xcco102a+g_xcco_d[l_ac].xcco102b+g_xcco_d[l_ac].xcco102c+
                              g_xcco_d[l_ac].xcco102d+g_xcco_d[l_ac].xcco102e+g_xcco_d[l_ac].xcco102f+ 
                              g_xcco_d[l_ac].xcco102g+g_xcco_d[l_ac].xcco102h
   DISPLAY BY NAME g_xcco_d[l_ac].xcco102               
END FUNCTION

################################################################################
# Descriptions...: 調整成本-功能幣二
# Memo...........:
# Usage..........: CALL axct310_get_xcco102_1_sum()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/11 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct310_get_xcco102_1_sum()
   IF cl_null(g_xcco1_d[l_ac].xcco102a_1) THEN LET g_xcco1_d[l_ac].xcco102a_1 = 0 END IF
   IF cl_null(g_xcco1_d[l_ac].xcco102b_1) THEN LET g_xcco1_d[l_ac].xcco102b_1 = 0 END IF
   IF cl_null(g_xcco1_d[l_ac].xcco102c_1) THEN LET g_xcco1_d[l_ac].xcco102c_1 = 0 END IF
   IF cl_null(g_xcco1_d[l_ac].xcco102d_1) THEN LET g_xcco1_d[l_ac].xcco102d_1 = 0 END IF
   IF cl_null(g_xcco1_d[l_ac].xcco102e_1) THEN LET g_xcco1_d[l_ac].xcco102e_1 = 0 END IF
   IF cl_null(g_xcco1_d[l_ac].xcco102f_1) THEN LET g_xcco1_d[l_ac].xcco102f_1 = 0 END IF
   IF cl_null(g_xcco1_d[l_ac].xcco102g_1) THEN LET g_xcco1_d[l_ac].xcco102g_1 = 0 END IF
   IF cl_null(g_xcco1_d[l_ac].xcco102h_1) THEN LET g_xcco1_d[l_ac].xcco102h_1 = 0 END IF
   
   LET g_xcco1_d[l_ac].xcco102_1=g_xcco1_d[l_ac].xcco102a_1+g_xcco1_d[l_ac].xcco102b_1+g_xcco1_d[l_ac].xcco102c_1+
                                 g_xcco1_d[l_ac].xcco102d_1+g_xcco1_d[l_ac].xcco102e_1+g_xcco1_d[l_ac].xcco102f_1+ 
                                 g_xcco1_d[l_ac].xcco102g_1+g_xcco1_d[l_ac].xcco102h_1
   DISPLAY BY NAME g_xcco1_d[l_ac].xcco102_1  
END FUNCTION

################################################################################
# Descriptions...: 調整成本-功能幣三
# Memo...........:
# Usage..........: CALL axct310_get_xcco102_3_sum()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/11 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct310_get_xcco102_3_sum()
   IF cl_null(g_xcco3_d[l_ac].xcco102a_3) THEN LET g_xcco3_d[l_ac].xcco102a_3 = 0 END IF
   IF cl_null(g_xcco3_d[l_ac].xcco102b_3) THEN LET g_xcco3_d[l_ac].xcco102b_3 = 0 END IF
   IF cl_null(g_xcco3_d[l_ac].xcco102c_3) THEN LET g_xcco3_d[l_ac].xcco102c_3 = 0 END IF
   IF cl_null(g_xcco3_d[l_ac].xcco102d_3) THEN LET g_xcco3_d[l_ac].xcco102d_3 = 0 END IF
   IF cl_null(g_xcco3_d[l_ac].xcco102e_3) THEN LET g_xcco3_d[l_ac].xcco102e_3 = 0 END IF
   IF cl_null(g_xcco3_d[l_ac].xcco102f_3) THEN LET g_xcco3_d[l_ac].xcco102f_3 = 0 END IF
   IF cl_null(g_xcco3_d[l_ac].xcco102g_3) THEN LET g_xcco3_d[l_ac].xcco102g_3 = 0 END IF
   IF cl_null(g_xcco3_d[l_ac].xcco102h_3) THEN LET g_xcco3_d[l_ac].xcco102h_3 = 0 END IF
   
   LET g_xcco3_d[l_ac].xcco102_3=g_xcco3_d[l_ac].xcco102a_3+g_xcco3_d[l_ac].xcco102b_3+g_xcco3_d[l_ac].xcco102c_3+
                                 g_xcco3_d[l_ac].xcco102d_3+g_xcco3_d[l_ac].xcco102e_3+g_xcco3_d[l_ac].xcco102f_3+ 
                                 g_xcco3_d[l_ac].xcco102g_3+g_xcco3_d[l_ac].xcco102h_3
   DISPLAY BY NAME g_xcco3_d[l_ac].xcco102_3     
END FUNCTION

################################################################################
# Descriptions...: 功能幣二
# Memo...........:
# Usage..........: CALL axct310_b_fill_1(p_wc2)
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/11 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct310_b_fill_1(p_wc2)
DEFINE p_wc2  STRING
   #add-point:b_fill段define

   #end add-point     
 
   #先清空單身變數內容
   CALL g_xcco1_d.clear()
 
   LET g_sql = "SELECT  UNIQUE xcco001,xcco006,xcco007,'','','',xcco002,'',xcco008,xcco102a,xcco102b,xcco102c,  
               xcco102d,xcco102e,xcco102f,xcco102g,xcco102h,xcco102,xcco001,xcco006,xcco007,xcco002,xcco008,xccoownid, 
          '',xccoowndp,'',xccocrtid,'',xccocrtdp,'',xccocrtdt,xccomodid,'',xccomoddt,xccocnfid,'',xccocnfdt, 
          xccopstid,'',xccopstdt FROM xcco_t",   
                  "",
                  
                  " WHERE xccoent= ? AND xccold=? AND xcco001='2' AND xcco003=? AND xcco004=? AND xcco005=? AND xcco009=?"  
                  
   IF NOT cl_null(g_wc3) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc3 CLIPPED
   END IF
   
   #add-point:b_fill段sql_after

   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axct310_fill_chk(1) THEN
      LET g_sql = g_sql, " ORDER BY xcco_t.xcco001,xcco_t.xcco002,xcco_t.xcco006,xcco_t.xcco007,xcco_t.xcco008"
      
      #add-point:b_fill段fill_before

      #end add-point
      
      PREPARE axct310_pb1 FROM g_sql
      DECLARE b_fill_cs1 CURSOR FOR axct310_pb1
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs1 USING g_enterprise,g_xcco_m.xccold
                                               ,g_xcco_m.xcco003
                                               ,g_xcco_m.xcco004
                                               ,g_xcco_m.xcco005
                                               ,g_xcco_m.xcco009
 
                                               
      FOREACH b_fill_cs1 INTO g_xcco1_d[l_ac].xcco001_1,g_xcco1_d[l_ac].xcco006_1,g_xcco1_d[l_ac].xcco007_1,g_xcco1_d[l_ac].xcco006_desc_1,g_xcco1_d[l_ac].xcco006_desc_1_1,g_xcco1_d[l_ac].imag014_1,
                      g_xcco1_d[l_ac].xcco002_1,g_xcco1_d[l_ac].xcco002_desc_1, 
                      g_xcco1_d[l_ac].xcco008_1, 
                      g_xcco1_d[l_ac].xcco102a_1,g_xcco1_d[l_ac].xcco102b_1,g_xcco1_d[l_ac].xcco102c_1, 
                      g_xcco1_d[l_ac].xcco102d_1,g_xcco1_d[l_ac].xcco102e_1,g_xcco1_d[l_ac].xcco102f_1,g_xcco1_d[l_ac].xcco102g_1,g_xcco1_d[l_ac].xcco102h_1,g_xcco1_d[l_ac].xcco102_1,
                      g_xcco2_d[l_ac].xcco001,g_xcco2_d[l_ac].xcco006,g_xcco2_d[l_ac].xcco007,g_xcco2_d[l_ac].xcco002,g_xcco2_d[l_ac].xcco008, 
                      g_xcco2_d[l_ac].xccoownid,g_xcco2_d[l_ac].xccoownid_desc,g_xcco2_d[l_ac].xccoowndp, 
                      g_xcco2_d[l_ac].xccoowndp_desc,g_xcco2_d[l_ac].xccocrtid,g_xcco2_d[l_ac].xccocrtid_desc, 
                      g_xcco2_d[l_ac].xccocrtdp,g_xcco2_d[l_ac].xccocrtdp_desc,g_xcco2_d[l_ac].xccocrtdt, 
                      g_xcco2_d[l_ac].xccomodid,g_xcco2_d[l_ac].xccomodid_desc,g_xcco2_d[l_ac].xccomoddt, 
                      g_xcco2_d[l_ac].xccocnfid,g_xcco2_d[l_ac].xccocnfid_desc,g_xcco2_d[l_ac].xccocnfdt, 
                      g_xcco2_d[l_ac].xccopstid,g_xcco2_d[l_ac].xccopstid_desc,g_xcco2_d[l_ac].xccopstdt 
 
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH1:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充
         CALL axct310_get_xcco006_1_desc()
         CALL axct310_get_xcco002_1_desc()
         CALL axct310_get_imag014_1()
         #end add-point
      
         #帶出公用欄位reference值
         
         
         #此段落由子樣板a12產生
         IF NOT cl_null(g_xcco2_d[l_ac].xccoownid) THEN LET g_xcco2_d[l_ac].xccoownid_desc = cl_get_username(g_xcco2_d[l_ac].xccoownid) END IF
         IF NOT cl_null(g_xcco2_d[l_ac].xccoowndp) THEN LET g_xcco2_d[l_ac].xccoowndp_desc = cl_get_deptname(g_xcco2_d[l_ac].xccoowndp) END IF
         IF NOT cl_null(g_xcco2_d[l_ac].xccocrtid) THEN LET g_xcco2_d[l_ac].xccocrtid_desc = cl_get_username(g_xcco2_d[l_ac].xccocrtid) END IF
         IF NOT cl_null(g_xcco2_d[l_ac].xccocrtdp) THEN LET g_xcco2_d[l_ac].xccocrtdp_desc = cl_get_deptname(g_xcco2_d[l_ac].xccocrtdp) END IF
         IF NOT cl_null(g_xcco2_d[l_ac].xccomodid) THEN LET g_xcco2_d[l_ac].xccomodid_desc = cl_get_username(g_xcco2_d[l_ac].xccomodid) END IF
         IF NOT cl_null(g_xcco2_d[l_ac].xccocnfid) THEN LET g_xcco2_d[l_ac].xccocnfid_desc = cl_get_deptname(g_xcco2_d[l_ac].xccocnfid) END IF
         IF NOT cl_null(g_xcco2_d[l_ac].xccopstid) THEN LET g_xcco2_d[l_ac].xccopstid_desc = cl_get_deptname(g_xcco2_d[l_ac].xccopstid) END IF
         DISPLAY BY NAME g_xcco2_d[l_ac].xccoownid_desc
         DISPLAY BY NAME g_xcco2_d[l_ac].xccoowndp_desc
         DISPLAY BY NAME g_xcco2_d[l_ac].xccocrtid_desc
         DISPLAY BY NAME g_xcco2_d[l_ac].xccocrtdp_desc
         DISPLAY BY NAME g_xcco2_d[l_ac].xccomodid_desc
         DISPLAY BY NAME g_xcco2_d[l_ac].xccocnfid_desc
         DISPLAY BY NAME g_xcco2_d[l_ac].xccopstid_desc 
      
 
 
 
        
         #add-point:單身資料抓取

         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            EXIT FOREACH
         END IF
         
      END FOREACH
      
      CALL g_xcco1_d.deleteElement(g_xcco1_d.getLength())
      CALL g_xcco2_d.deleteElement(g_xcco2_d.getLength())
 
   END IF
   
   #add-point:b_fill段more

   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   FREE axct310_pb1
END FUNCTION

################################################################################
# Descriptions...: 功能幣三
# Memo...........:
# Usage..........: CALL axct310_b_fill_3(p_wc2)
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/11 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct310_b_fill_3(p_wc2)
DEFINE p_wc2 STRING
   #add-point:b_fill段define

   #end add-point     
 
   #先清空單身變數內容
   CALL g_xcco3_d.clear()
 
   LET g_sql = "SELECT  UNIQUE xcco001,xcco006,xcco007,'','','',xcco002,'',xcco008,xcco102a,xcco102b,xcco102c, 
               xcco102d,xcco102e,xcco102f,xcco102g,xcco102h,xcco102,xcco001,xcco006,xcco007,xcco002,xcco008,xccoownid, 
          '',xccoowndp,'',xccocrtid,'',xccocrtdp,'',xccocrtdt,xccomodid,'',xccomoddt,xccocnfid,'',xccocnfdt, 
          xccopstid,'',xccopstdt FROM xcco_t",   
                  "",
                  
                  " WHERE xccoent= ? AND xccold=? AND xcco001='3' AND xcco003=? AND xcco004=? AND xcco005=? AND xcco009=?"  
                  
   IF NOT cl_null(g_wc3) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc3 CLIPPED
   END IF
   
   #add-point:b_fill段sql_after

   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axct310_fill_chk(1) THEN
      LET g_sql = g_sql, " ORDER BY xcco_t.xcco001,xcco_t.xcco002,xcco_t.xcco006,xcco_t.xcco007,xcco_t.xcco008"
      
      #add-point:b_fill段fill_before

      #end add-point
      
      PREPARE axct310_pb3 FROM g_sql
      DECLARE b_fill_cs3 CURSOR FOR axct310_pb3
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs3 USING g_enterprise,g_xcco_m.xccold
                                               ,g_xcco_m.xcco003
                                               ,g_xcco_m.xcco004
                                               ,g_xcco_m.xcco005
                                               ,g_xcco_m.xcco009
 
                                               
      FOREACH b_fill_cs3 INTO g_xcco3_d[l_ac].xcco001_3,g_xcco3_d[l_ac].xcco006_3,g_xcco3_d[l_ac].xcco007_3,
                      g_xcco3_d[l_ac].xcco006_desc_3,g_xcco3_d[l_ac].xcco006_desc_1_3,g_xcco3_d[l_ac].imag014_3,
                      g_xcco3_d[l_ac].xcco002_3,g_xcco3_d[l_ac].xcco002_desc_3,g_xcco3_d[l_ac].xcco008_3, 
                      g_xcco3_d[l_ac].xcco102a_3,g_xcco3_d[l_ac].xcco102b_3,g_xcco3_d[l_ac].xcco102c_3, 
                      g_xcco3_d[l_ac].xcco102d_3,g_xcco3_d[l_ac].xcco102e_3,g_xcco3_d[l_ac].xcco102f_3,g_xcco3_d[l_ac].xcco102g_3,g_xcco3_d[l_ac].xcco102h_3,g_xcco3_d[l_ac].xcco102_3,
                      g_xcco2_d[l_ac].xcco001,g_xcco2_d[l_ac].xcco006,g_xcco2_d[l_ac].xcco007,g_xcco2_d[l_ac].xcco002,g_xcco2_d[l_ac].xcco008,
                      g_xcco2_d[l_ac].xccoownid,g_xcco2_d[l_ac].xccoownid_desc,g_xcco2_d[l_ac].xccoowndp, 
                      g_xcco2_d[l_ac].xccoowndp_desc,g_xcco2_d[l_ac].xccocrtid,g_xcco2_d[l_ac].xccocrtid_desc, 
                      g_xcco2_d[l_ac].xccocrtdp,g_xcco2_d[l_ac].xccocrtdp_desc,g_xcco2_d[l_ac].xccocrtdt, 
                      g_xcco2_d[l_ac].xccomodid,g_xcco2_d[l_ac].xccomodid_desc,g_xcco2_d[l_ac].xccomoddt, 
                      g_xcco2_d[l_ac].xccocnfid,g_xcco2_d[l_ac].xccocnfid_desc,g_xcco2_d[l_ac].xccocnfdt, 
                      g_xcco2_d[l_ac].xccopstid,g_xcco2_d[l_ac].xccopstid_desc,g_xcco2_d[l_ac].xccopstdt 
 
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH1:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充
         CALL axct310_get_xcco006_3_desc()
         CALL axct310_get_xcco002_3_desc()
         CALL axct310_get_imag014_3()
         #end add-point
      
         #帶出公用欄位reference值
         
         
         #此段落由子樣板a12產生
         IF NOT cl_null(g_xcco2_d[l_ac].xccoownid) THEN LET g_xcco2_d[l_ac].xccoownid_desc = cl_get_username(g_xcco2_d[l_ac].xccoownid) END IF
         IF NOT cl_null(g_xcco2_d[l_ac].xccoowndp) THEN LET g_xcco2_d[l_ac].xccoowndp_desc = cl_get_deptname(g_xcco2_d[l_ac].xccoowndp) END IF
         IF NOT cl_null(g_xcco2_d[l_ac].xccocrtid) THEN LET g_xcco2_d[l_ac].xccocrtid_desc = cl_get_username(g_xcco2_d[l_ac].xccocrtid) END IF
         IF NOT cl_null(g_xcco2_d[l_ac].xccocrtdp) THEN LET g_xcco2_d[l_ac].xccocrtdp_desc = cl_get_deptname(g_xcco2_d[l_ac].xccocrtdp) END IF
         IF NOT cl_null(g_xcco2_d[l_ac].xccomodid) THEN LET g_xcco2_d[l_ac].xccomodid_desc = cl_get_username(g_xcco2_d[l_ac].xccomodid) END IF
         IF NOT cl_null(g_xcco2_d[l_ac].xccocnfid) THEN LET g_xcco2_d[l_ac].xccocnfid_desc = cl_get_deptname(g_xcco2_d[l_ac].xccocnfid) END IF
         IF NOT cl_null(g_xcco2_d[l_ac].xccopstid) THEN LET g_xcco2_d[l_ac].xccopstid_desc = cl_get_deptname(g_xcco2_d[l_ac].xccopstid) END IF
         
               
         DISPLAY BY NAME g_xcco2_d[l_ac].xccoownid_desc
         DISPLAY BY NAME g_xcco2_d[l_ac].xccoowndp_desc
         DISPLAY BY NAME g_xcco2_d[l_ac].xccocrtid_desc
         DISPLAY BY NAME g_xcco2_d[l_ac].xccocrtdp_desc
         DISPLAY BY NAME g_xcco2_d[l_ac].xccomodid_desc
         DISPLAY BY NAME g_xcco2_d[l_ac].xccocnfid_desc
         DISPLAY BY NAME g_xcco2_d[l_ac].xccopstid_desc 
      
 
 
 
        
         #add-point:單身資料抓取

         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            EXIT FOREACH
         END IF
         
      END FOREACH
      
      CALL g_xcco3_d.deleteElement(g_xcco3_d.getLength())
      CALL g_xcco2_d.deleteElement(g_xcco2_d.getLength())
 
   END IF
   
   #add-point:b_fill段more

   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   FREE axct310_pb3
END FUNCTION

################################################################################
# Descriptions...: 新增明細資料后，新增功能幣二、三
# Memo...........:
# Usage..........: CALL axct310_ins_xcco()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/11 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct310_ins_xcco()
DEFINE l_rate             LIKE apca_t.apca101
  

   CALL axct310_page_visible()
   CALL axct310_get_date()

   IF g_glaa015 = 'Y' THEN
      CALL s_aooi160_get_exrate('1',g_xcco_m.xccocomp,g_edate,g_glaa001,
                                        #目的幣別;    交易金額;              匯類類型
                                         g_glaa016,0,g_glaa018)
                  RETURNING l_rate
    
      LET g_xcco1_d[l_ac].xcco102a_1 = g_xcco_d[l_ac].xcco102a * l_rate  
      LET g_xcco1_d[l_ac].xcco102b_1 = g_xcco_d[l_ac].xcco102b * l_rate  
      LET g_xcco1_d[l_ac].xcco102c_1 = g_xcco_d[l_ac].xcco102c * l_rate  
      LET g_xcco1_d[l_ac].xcco102d_1 = g_xcco_d[l_ac].xcco102d * l_rate  
      LET g_xcco1_d[l_ac].xcco102e_1 = g_xcco_d[l_ac].xcco102e * l_rate  
      LET g_xcco1_d[l_ac].xcco102f_1 = g_xcco_d[l_ac].xcco102f * l_rate  
      LET g_xcco1_d[l_ac].xcco102g_1 = g_xcco_d[l_ac].xcco102g * l_rate  
      LET g_xcco1_d[l_ac].xcco102h_1 = g_xcco_d[l_ac].xcco102h * l_rate  
      CALL axct310_get_xcco102_1_sum()
      INSERT INTO xcco_t
             (xccoent,
              xccocomp,xccold,xcco004,xcco005,xcco003,xcco009,xcco010,
              xcco001,xcco002,xcco006,xcco007,xcco008,
              xcco102a,xcco102b,xcco102c,xcco102d,xcco102e,xcco102f,xcco102g,xcco102h,xcco102,
              xccoownid,xccoowndp,xccocrtid,xccocrtdp,xccocrtdt,xccomodid,xccomoddt,xccocnfid,xccocnfdt,xccopstid,xccopstdt) 
       VALUES(g_enterprise,
              g_xcco_m.xccocomp,g_xcco_m.xccold,g_xcco_m.xcco004,g_xcco_m.xcco005,g_xcco_m.xcco003,g_xcco_m.xcco009,g_xcco_m.xcco010,
              '2',g_xcco_d[l_ac].xcco002,g_xcco_d[l_ac].xcco006,g_xcco_d[l_ac].xcco007, g_xcco_d[l_ac].xcco008, 
                  g_xcco1_d[l_ac].xcco102a_1,g_xcco1_d[l_ac].xcco102b_1, 
                  g_xcco1_d[l_ac].xcco102c_1,g_xcco1_d[l_ac].xcco102d_1,g_xcco1_d[l_ac].xcco102e_1, 
                  g_xcco1_d[l_ac].xcco102f_1,g_xcco1_d[l_ac].xcco102g_1,g_xcco1_d[l_ac].xcco102h_1,g_xcco1_d[l_ac].xcco102_1, 
                  g_xcco2_d[l_ac].xccoownid,g_xcco2_d[l_ac].xccoowndp,g_xcco2_d[l_ac].xccocrtid, 
                  g_xcco2_d[l_ac].xccocrtdp,g_xcco2_d[l_ac].xccocrtdt,g_xcco2_d[l_ac].xccomodid, 
                  g_xcco2_d[l_ac].xccomoddt,g_xcco2_d[l_ac].xccocnfid,g_xcco2_d[l_ac].xccocnfdt, 
                  g_xcco2_d[l_ac].xccopstid,g_xcco2_d[l_ac].xccopstdt)
   END IF
   
   IF g_glaa019 = 'Y' THEN
      CALL s_aooi160_get_exrate('1',g_xcco_m.xccocomp,g_edate,g_glaa001,
                                        #目的幣別;  交易金額;              匯類類型
                                         g_glaa020,0,g_glaa022)
          RETURNING l_rate
      LET g_xcco3_d[l_ac].xcco102a_3 = g_xcco_d[l_ac].xcco102a * l_rate  
      LET g_xcco3_d[l_ac].xcco102b_3 = g_xcco_d[l_ac].xcco102b * l_rate  
      LET g_xcco3_d[l_ac].xcco102c_3 = g_xcco_d[l_ac].xcco102c * l_rate  
      LET g_xcco3_d[l_ac].xcco102d_3 = g_xcco_d[l_ac].xcco102d * l_rate  
      LET g_xcco3_d[l_ac].xcco102e_3 = g_xcco_d[l_ac].xcco102e * l_rate  
      LET g_xcco3_d[l_ac].xcco102f_3 = g_xcco_d[l_ac].xcco102f * l_rate  
      LET g_xcco3_d[l_ac].xcco102g_3 = g_xcco_d[l_ac].xcco102g * l_rate  
      LET g_xcco3_d[l_ac].xcco102h_3 = g_xcco_d[l_ac].xcco102h * l_rate  
      CALL axct310_get_xcco102_3_sum()
      INSERT INTO xcco_t
           (xccoent,
              xccocomp,xccold,xcco004,xcco005,xcco003,xcco009,xcco010,
              xcco001,xcco002,xcco006,xcco007,xcco008,
              xcco102a,xcco102b,xcco102c,xcco102d,xcco102e,xcco102f,xcco102g,xcco102h,xcco102,
              xccoownid,xccoowndp,xccocrtid,xccocrtdp,xccocrtdt,xccomodid,xccomoddt,xccocnfid,xccocnfdt,xccopstid,xccopstdt) 
       VALUES(g_enterprise,
              g_xcco_m.xccocomp,g_xcco_m.xccold,g_xcco_m.xcco004,g_xcco_m.xcco005,g_xcco_m.xcco003,g_xcco_m.xcco009,g_xcco_m.xcco010,
             '3',g_xcco_d[l_ac].xcco002,g_xcco_d[l_ac].xcco006,g_xcco_d[l_ac].xcco007,g_xcco_d[l_ac].xcco008,
                  g_xcco3_d[l_ac].xcco102a_3,g_xcco3_d[l_ac].xcco102b_3, 
                  g_xcco3_d[l_ac].xcco102c_3,g_xcco3_d[l_ac].xcco102d_3,g_xcco3_d[l_ac].xcco102e_3, 
                  g_xcco3_d[l_ac].xcco102f_3,g_xcco3_d[l_ac].xcco102g_3,g_xcco3_d[l_ac].xcco102h_3,g_xcco3_d[l_ac].xcco102_3, 
                  g_xcco2_d[l_ac].xccoownid,g_xcco2_d[l_ac].xccoowndp,g_xcco2_d[l_ac].xccocrtid, 
                  g_xcco2_d[l_ac].xccocrtdp,g_xcco2_d[l_ac].xccocrtdt,g_xcco2_d[l_ac].xccomodid, 
                  g_xcco2_d[l_ac].xccomoddt,g_xcco2_d[l_ac].xccocnfid,g_xcco2_d[l_ac].xccocnfdt, 
                  g_xcco2_d[l_ac].xccopstid,g_xcco2_d[l_ac].xccopstdt)
  END IF
END FUNCTION

################################################################################
# Descriptions...: 匯出格式
# Memo...........:
# Usage..........: CALL axct310_s01()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/13 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct310_s01()
DEFINE p_xrad001      LIKE xrad_t.xrad001
DEFINE l_xradl003     LIKE type_t.chr80
DEFINE ls_str          STRING
DEFINE l_chr           LIKE type_t.chr1   
DEFINE l_chr1          LIKE type_t.chr1  
DEFINE l_num           LIKE type_t.num5
   
   OPEN WINDOW w_axct310_s01 WITH FORM cl_ap_formpath("axc","axct310_s01")
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #輸入開始
      INPUT BY NAME g_xcco_s.name,g_xcco_s.dir
         BEFORE INPUT
           


         AFTER INPUT
            

      END INPUT

      DISPLAY ARRAY g_xcco4_d TO s_detail5.* ATTRIBUTES(COUNT=g_rec_b)  

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
         CALL cl_client_browse_dir() RETURNING g_xcco_s.dir
         LET ls_str = g_xcco_s.dir
         #抓取目录斜杆
         LET l_num =ls_str.getIndexOf(':',1)                                    #抓取：后的字符位置
         LET l_chr = ls_str.substring(l_num+1,l_num+1)                          #截取冒号后的字符 
         LET l_chr1 = ls_str.substring(ls_str.getLength(),ls_str.getLength())   #判断是否为根目录
         IF l_chr <> l_chr1  THEN         
            LET g_xcco_s.dir = g_xcco_s.dir||l_chr 
         ELSE
            LET g_xcco_s.dir = g_xcco_s.dir 
         END IF 
         DISPLAY BY NAME g_xcco_s.dir
         
      ON ACTION produce
#         CALL axct310_show_1()
         LET w = ui.Window.getCurrent()
         LET f = w.getForm()
         LET page = f.FindNode("Page","page_5")
         CALL axct310_excelexample(page,base.TypeInfo.create(g_xcco4_d),'Y')
         ACCEPT DIALOG 

      ON ACTION off
         LET INT_FLAG = TRUE
         EXIT DIALOG


   END DIALOG

   



      #畫面關閉
      CLOSE WINDOW w_axct310_s01
END FUNCTION

################################################################################
# Descriptions...: 匯出格式
# Memo...........:
# Usage..........: CALL axct310_excelexample(n,t,p_show_hidden)
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/13 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct310_excelexample(n,t,p_show_hidden)
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
   LET xls_name = g_xcco_s.name CLIPPED,".xls"

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
            IF l_field_name = 'xcco_t.xccoent' OR l_field_name = 'xcco_t.xccold' OR
               l_field_name = 'xcco_t.xccocomp' OR l_field_name = 'xcco_t.xcco001' OR
               l_field_name = 'xcco_t.xcco002' OR l_field_name = 'xcco_t.xcco003' OR
               l_field_name = 'xcco_t.xcco004' OR l_field_name = 'xcco_t.xcco005' OR
               l_field_name = 'xcco_t.xcco006' OR l_field_name = 'xcco_t.xcco007' OR
               l_field_name = 'xcco_t.xcco008' OR l_field_name = 'xcco_t.xcco009' OR
               l_field_name = 'xcco_t.xcco010' OR l_field_name = 'xcco_t.xcco011' OR
               l_field_name = 'xcco_t.xcco102a' OR
               l_field_name = 'xcco_t.xcco102b' OR l_field_name = 'xcco_t.xcco102c' OR
               l_field_name = 'xcco_t.xcco102d' OR l_field_name = 'xcco_t.xcco102e' OR
               l_field_name = 'xcco_t.xcco102f' OR l_field_name = 'xcco_t.xcco102g' OR
               l_field_name = 'xcco_t.xcco102h' OR l_field_name = 'xcco_t.xcco102' OR
               l_field_name = 'formonly.xcco102a_1' OR
               l_field_name = 'formonly.xcco102b_1' OR l_field_name = 'formonly.xcco102c_1' OR
               l_field_name = 'formonly.xcco102d_1' OR l_field_name = 'formonly.xcco102e_1' OR
               l_field_name = 'formonly.xcco102f_1' OR l_field_name = 'formonly.xcco102g_1' OR
               l_field_name = 'formonly.xcco102h_1' OR l_field_name = 'formonly.xcco102_1'  OR
               l_field_name = 'formonly.xcco102a_2' OR
               l_field_name = 'formonly.xcco102b_2' OR l_field_name = 'formonly.xcco102c_2' OR
               l_field_name = 'formonly.xcco102d_2' OR l_field_name = 'formonly.xcco102e_2' OR
               l_field_name = 'formonly.xcco102f_2' OR l_field_name = 'formonly.xcco102g_2' OR
               l_field_name = 'formonly.xcco102h_2' OR l_field_name = 'formonly.xcco102_2'  
               THEN
               LET values = n1_text.getAttribute("text")
               LET l_str = "<td>",axct310_add_span(values),"</td>"
               CALL l_channel.write(l_str CLIPPED)
            END IF
         ELSE
            LET g_hidden[i] = "1"
            LET k = k -1
         END IF
      END FOR
      IF h=1 THEN CALL axct310_get_boday(h,cnt_header,t,combo_arr,l_seq) END IF

   END FOR

   # 使用者的行為模式改到前面判斷，在此僅將前面判斷的結果說明傳至syslog中做紀錄
   IF cl_log_sys_operation("A","G",l_desc) THEN
   END IF
END FUNCTION

################################################################################
# Descriptions...: 匯出格式
# Memo...........:
# Usage..........: CALL axct310_get_boday(p_h,p_cnt_header,s,s_combo_arr,p_seq)
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/13 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct310_get_boday(p_h,p_cnt_header,s,s_combo_arr,p_seq)
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
   LET window_path = g_xcco_s.dir,"\\",xls_name CLIPPED
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
# Descriptions...: 匯出格式
# Memo...........:
# Usage..........: CALL axct310_add_span(p_str)
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/13 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct310_add_span(p_str)
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

################################################################################
# Descriptions...: 整批導入
# Memo...........:
# Usage..........: CALL axct310_s02()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/13 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct310_s02()
DEFINE l_excel         STRING 
DEFINE ls_str          STRING
DEFINE l_chr           LIKE type_t.chr1   
DEFINE l_chr1          LIKE type_t.chr1   
DEFINE l_num           LIKE type_t.num5
DEFINE l_n             LIKE type_t.num5




   #畫面開啟 (identifier)

   OPEN WINDOW w_axct310_s02 WITH FORM cl_ap_formpath("axc","axct310_s02")

   INITIALIZE g_xcco_f.* LIKE xcco_t.*
   
   LET g_xcco_f_t.xccocomp = NULL
   LET g_xcco_f_t.xccold = NULL
   LET g_xcco_f_t.format = NULL
   LET g_xcco_f_t.char = NULL
   LET g_xcco_f_t.dir = NULL
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_xcco_f.xccocomp,g_xcco_f.xccold,g_xcco_f.format,g_xcco_f.char,g_xcco_f.dir ATTRIBUTE(WITHOUT  DEFAULTS)

         BEFORE INPUT
            CALL cl_set_combo_scc('format','8915')
 
         AFTER FIELD xccocomp
            IF NOT cl_null(g_xcco_f.xccocomp) THEN 
               #檢查是否存在 組織基礎資料檔 中
               IF NOT ap_chk_isExist(g_xcco_f.xccocomp,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? ",'aoo-00094',1) THEN
                  LET g_xcco_f.xccocomp = g_xcco_f_t.xccocomp
                  CALL axct310_s02_get_xccocomp_desc()                  
                  NEXT FIELD CURRENT
               END IF    
               
               #檢查是否 有效
#               IF NOT ap_chk_isExist(g_xcco_f.xccocomp,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? AND ooefstus = 'Y'",'aoo-00095',1) THEN   #160318-00005#47  mark
               IF NOT ap_chk_isExist(g_xcco_f.xccocomp,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? AND ooefstus = 'Y'",'sub-01302','aooi125') THEN   #160318-00005#47  add
                  LET g_xcco_f.xccocomp = g_xcco_f_t.xccocomp
                  CALL axct310_s02_get_xccocomp_desc()                  
                  NEXT FIELD CURRENT
               END IF 
               
               #檢查是否為 法人
#               IF NOT ap_chk_isExist(g_xcco_f.xccocomp,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? AND ooefstus = 'Y' AND ooef003 = 'Y'",'aoo-00095',1) THEN   #160318-00005#47  mark
               IF NOT ap_chk_isExist(g_xcco_f.xccocomp,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? AND ooefstus = 'Y' AND ooef003 = 'Y'",'sub-01302','aooi125') THEN   #160318-00005#47  add
                  LET g_xcco_f.xccocomp = g_xcco_f_t.xccocomp
                  CALL axct310_s02_get_xccocomp_desc()                  
                  NEXT FIELD CURRENT
               END IF              

#               #檢查組織類型是否為 法人組織
#               IF NOT ap_chk_isExist(g_xcco_f.xccocomp,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? AND ooefstus = 'Y' AND ooef003 = 'Y'",'apm-00250',1) THEN
#                  LET g_xcco_f.xccocomp = g_xcco_f_t.xccocomp
#                  CALL axct310_s02_get_xccocomp_desc()                  
#                  NEXT FIELD CURRENT
#               END IF  
               
               #帳套不為空時，檢查該法人下是否有此帳套
               IF NOT cl_null(g_xcco_f.xccold) THEN
                  IF NOT ap_chk_isExist(g_xcco_f.xccocomp,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaacomp = ? AND glaastus = 'Y' AND glaald = '" ||g_xcco_f.xccold|| "'",'axc-00224',1) THEN
                     LET g_xcco_f.xccocomp = g_xcco_f_t.xccocomp
                     CALL axct310_s02_get_xccocomp_desc()                  
                     NEXT FIELD CURRENT
                  END IF   
               END IF
            END IF
            
            CALL axct310_s02_get_xccocomp_desc()
 

         AFTER FIELD xccold
            IF NOT cl_null(g_xcco_f.xccold) THEN
               #檢查是否存在 帳別資料檔 中
               IF NOT ap_chk_isExist(g_xcco_f.xccold,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? ",'agl-00016',1) THEN
                  LET g_xcco_f.xccold = g_xccold_t
                  CALL axct310_s02_get_xccold_desc()                  
                  NEXT FIELD CURRENT
               END IF   
               
               #檢查是否 有效
#               IF NOT ap_chk_isExist(g_xcco_f.xccold,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND glaastus = 'Y'",'agl-00051',1) THEN   #160318-00005#47  mark
               IF NOT ap_chk_isExist(g_xcco_f.xccold,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND glaastus = 'Y'",'sub-01302','agli010') THEN   #160318-00005#47  add
                  LET g_xcco_f.xccold = g_xccold_t
                  CALL axct310_s02_get_xccold_desc()                  
                  NEXT FIELD CURRENT
               END IF   
               
               #法人不為空時，檢查 帳別編號需為法人組織的下属帳套
               IF NOT cl_null(g_xcco_f.xccocomp) THEN
                  IF NOT ap_chk_isExist(g_xcco_f.xccold,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND glaastus = 'Y' AND glaacomp = '" ||g_xcco_f.xccocomp|| "'",'axc-00225',1) THEN
                     LET g_xcco_f.xccold = g_xccold_t
                     CALL axct310_s02_get_xccold_desc()                  
                     NEXT FIELD CURRENT
                  END IF   
               END IF
               
               #檢查權限
               IF NOT s_ld_chk_authorization(g_user,g_xcco_f.xccold) THEN
                  CALL axct310_get_xccold_desc()
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00165'
                  LET g_errparam.extend = g_xcco_f.xccold
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  CALL axct310_s02_get_xccold_desc()                  
                  NEXT FIELD CURRENT
               END IF
            END IF

            CALL axct310_s02_get_xccold_desc() 
 
         ON ACTION controlp INFIELD xccocomp
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcco_f.xccocomp             #給予default值
           
            #帳套不為空時，法人組織開窗開帳套歸屬法人的法人組織
            IF NOT cl_null(g_xcco_f.xccold) THEN
               LET g_qryparam.where = " ooef017 = (SELECT glaacomp FROM glaa_t",
                                      "  WHERE glaaent = '",g_enterprise,"' AND glaald = '",g_xcco_f.xccold,"' )"
            END IF
            
            #mod--161013-00051#1 By shiun--(S)
#            CALL q_ooef001_8()                                #呼叫開窗
            CALL q_ooef001_2()
            #mod--161013-00051#1 By shiun--(E)

            LET g_xcco_f.xccocomp = g_qryparam.return1              
 
            CALL axct310_s02_get_xccocomp_desc()
 
            DISPLAY g_xcco_f.xccocomp TO xccocomp 
            DISPLAY g_xcco_f.xccocomp_desc TO xccocomp_desc              #
 
            LET g_qryparam.where = "" 
   
            NEXT FIELD xccocomp                          #返回原欄位

 
         ON ACTION controlp INFIELD xccold
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcco_f.xccold             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            
            #法人不為空時，帳套開窗開此法人的下屬帳套
            IF NOT cl_null(g_xcco_f.xccocomp) THEN
               LET g_qryparam.where = " glaacomp = '",g_xcco_f.xccocomp,"'"
            END IF
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xcco_f.xccold = g_qryparam.return1              

            CALL axct310_s02_get_xccold_desc()
            
            DISPLAY g_xcco_f.xccold TO xccold
            DISPLAY g_xcco_f.xccold_desc TO xccold_desc              #

            NEXT FIELD xccold                          #返回原欄位
 
 
 
         AFTER INPUT
         
            
      END INPUT
    
    
      ON ACTION browser
         CALL cl_client_browse_file() RETURNING g_xcco_f.dir
         LET ls_str = g_xcco_f.dir
         #抓取目录斜杆
         LET l_num =ls_str.getIndexOf(':',1)                                    #抓取：后的字符位置
         LET l_chr = ls_str.substring(l_num+1,l_num+1)                          #截取冒号后的字符 
         LET l_chr1 = ls_str.substring(ls_str.getLength(),ls_str.getLength())   #判断是否为根目录
#         IF l_chr <> l_chr1  THEN         
#            LET g_xcco_f.dir = g_xcco_f.dir||l_chr
#         ELSE
            LET g_xcco_f.dir = g_xcco_f.dir
#         END IF 
         DISPLAY BY NAME g_xcco_f.dir

 
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
   CLOSE WINDOW w_axct310_s02 
   
   CALL axct310_s02_ins_excel(g_xcco_f.dir) RETURNING l_success
   RETURN l_success
 
END FUNCTION

################################################################################
# Descriptions...: 整批導入-獲取法人說明
# Memo...........:
# Usage..........: CALL axct310_s02_get_xccocomp_desc()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/13 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct310_s02_get_xccocomp_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcco_f.xccocomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcco_f.xccocomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcco_f.xccocomp_desc
END FUNCTION

################################################################################
# Descriptions...: 整批導入-excel
# Memo...........:
# Usage..........: CALL axct310_s02_ins_excel(p_excelname)
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/13 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct310_s02_ins_excel(p_excelname)
DEFINE p_excelname LIKE type_t.chr1000  #excel档名
DEFINE r_success   LIKE type_t.num5
DEFINE l_excelname STRING               #excel档名
DEFINE l_count     LIKE type_t.num10
DEFINE li_i        LIKE type_t.num10
DEFINE li_j        LIKE type_t.num10
DEFINE xlapp,iRes,iRow    LIKE type_t.num5
#161109-00085#23-s mod
#DEFINE l_xcco      RECORD LIKE xcco_t.*   #161109-00085#23-s mark
DEFINE l_xcco      RECORD  #本期庫存成本調整檔
       xccoent LIKE xcco_t.xccoent, #企業編號
       xccold LIKE xcco_t.xccold, #帳套
       xccocomp LIKE xcco_t.xccocomp, #法人組織
       xcco001 LIKE xcco_t.xcco001, #帳套本位幣順序
       xcco002 LIKE xcco_t.xcco002, #成本域
       xcco003 LIKE xcco_t.xcco003, #成本計算類型
       xcco004 LIKE xcco_t.xcco004, #年度
       xcco005 LIKE xcco_t.xcco005, #期別
       xcco006 LIKE xcco_t.xcco006, #料件編號
       xcco007 LIKE xcco_t.xcco007, #特性
       xcco008 LIKE xcco_t.xcco008, #批號
       xcco009 LIKE xcco_t.xcco009, #參考單號
       xcco010 LIKE xcco_t.xcco010, #資料來源
       xcco011 LIKE xcco_t.xcco011, #調整說明
       xcco102 LIKE xcco_t.xcco102, #當月調整金額-金額合計
       xcco102a LIKE xcco_t.xcco102a, #當月調整金額-材料
       xcco102b LIKE xcco_t.xcco102b, #當月調整金額-人工
       xcco102c LIKE xcco_t.xcco102c, #當月調整金額-委外加工
       xcco102d LIKE xcco_t.xcco102d, #當月調整金額-制費一
       xcco102e LIKE xcco_t.xcco102e, #當月調整金額-制費二
       xcco102f LIKE xcco_t.xcco102f, #當月調整金額-制費三
       xcco102g LIKE xcco_t.xcco102g, #當月調整金額-制費四
       xcco102h LIKE xcco_t.xcco102h, #當月調整金額-制費五
       xccoownid LIKE xcco_t.xccoownid, #資料所有者
       xccoowndp LIKE xcco_t.xccoowndp, #資料所屬部門
       xccocrtid LIKE xcco_t.xccocrtid, #資料建立者
       xccocrtdp LIKE xcco_t.xccocrtdp, #資料建立部門
       xccocrtdt LIKE xcco_t.xccocrtdt, #資料創建日
       xccomodid LIKE xcco_t.xccomodid, #資料修改者
       xccomoddt LIKE xcco_t.xccomoddt, #最近修改日
       xccocnfid LIKE xcco_t.xccocnfid, #資料確認者
       xccocnfdt LIKE xcco_t.xccocnfdt, #資料確認日
       xccopstid LIKE xcco_t.xccopstid, #資料過帳者
       xccopstdt LIKE xcco_t.xccopstdt, #資料過帳日
       xccostus LIKE xcco_t.xccostus, #狀態碼
       xccoud001 LIKE xcco_t.xccoud001, #自定義欄位(文字)001
       xccoud002 LIKE xcco_t.xccoud002, #自定義欄位(文字)002
       xccoud003 LIKE xcco_t.xccoud003, #自定義欄位(文字)003
       xccoud004 LIKE xcco_t.xccoud004, #自定義欄位(文字)004
       xccoud005 LIKE xcco_t.xccoud005, #自定義欄位(文字)005
       xccoud006 LIKE xcco_t.xccoud006, #自定義欄位(文字)006
       xccoud007 LIKE xcco_t.xccoud007, #自定義欄位(文字)007
       xccoud008 LIKE xcco_t.xccoud008, #自定義欄位(文字)008
       xccoud009 LIKE xcco_t.xccoud009, #自定義欄位(文字)009
       xccoud010 LIKE xcco_t.xccoud010, #自定義欄位(文字)010
       xccoud011 LIKE xcco_t.xccoud011, #自定義欄位(數字)011
       xccoud012 LIKE xcco_t.xccoud012, #自定義欄位(數字)012
       xccoud013 LIKE xcco_t.xccoud013, #自定義欄位(數字)013
       xccoud014 LIKE xcco_t.xccoud014, #自定義欄位(數字)014
       xccoud015 LIKE xcco_t.xccoud015, #自定義欄位(數字)015
       xccoud016 LIKE xcco_t.xccoud016, #自定義欄位(數字)016
       xccoud017 LIKE xcco_t.xccoud017, #自定義欄位(數字)017
       xccoud018 LIKE xcco_t.xccoud018, #自定義欄位(數字)018
       xccoud019 LIKE xcco_t.xccoud019, #自定義欄位(數字)019
       xccoud020 LIKE xcco_t.xccoud020, #自定義欄位(數字)020
       xccoud021 LIKE xcco_t.xccoud021, #自定義欄位(日期時間)021
       xccoud022 LIKE xcco_t.xccoud022, #自定義欄位(日期時間)022
       xccoud023 LIKE xcco_t.xccoud023, #自定義欄位(日期時間)023
       xccoud024 LIKE xcco_t.xccoud024, #自定義欄位(日期時間)024
       xccoud025 LIKE xcco_t.xccoud025, #自定義欄位(日期時間)025
       xccoud026 LIKE xcco_t.xccoud026, #自定義欄位(日期時間)026
       xccoud027 LIKE xcco_t.xccoud027, #自定義欄位(日期時間)027
       xccoud028 LIKE xcco_t.xccoud028, #自定義欄位(日期時間)028
       xccoud029 LIKE xcco_t.xccoud029, #自定義欄位(日期時間)029
       xccoud030 LIKE xcco_t.xccoud030  #自定義欄位(日期時間)030
                 END RECORD
#161109-00085#23-e mod
DEFINE l_today     LIKE type_t.dat       #zll g_today 没有了
DEFINE l_n         LIKE type_t.num5
DEFINE l_xccostus  LIKE xcco_t.xccostus
DEFINE l_xccocrtdt    DATETIME YEAR TO SECOND
#161109-00085#23-s mod
#DEFINE l_xcco1      RECORD LIKE xcco_t.*   #161109-00085#23-s mark
DEFINE l_xcco1      RECORD  #本期庫存成本調整檔
       xccoent LIKE xcco_t.xccoent, #企業編號
       xccold LIKE xcco_t.xccold, #帳套
       xccocomp LIKE xcco_t.xccocomp, #法人組織
       xcco001 LIKE xcco_t.xcco001, #帳套本位幣順序
       xcco002 LIKE xcco_t.xcco002, #成本域
       xcco003 LIKE xcco_t.xcco003, #成本計算類型
       xcco004 LIKE xcco_t.xcco004, #年度
       xcco005 LIKE xcco_t.xcco005, #期別
       xcco006 LIKE xcco_t.xcco006, #料件編號
       xcco007 LIKE xcco_t.xcco007, #特性
       xcco008 LIKE xcco_t.xcco008, #批號
       xcco009 LIKE xcco_t.xcco009, #參考單號
       xcco010 LIKE xcco_t.xcco010, #資料來源
       xcco011 LIKE xcco_t.xcco011, #調整說明
       xcco102 LIKE xcco_t.xcco102, #當月調整金額-金額合計
       xcco102a LIKE xcco_t.xcco102a, #當月調整金額-材料
       xcco102b LIKE xcco_t.xcco102b, #當月調整金額-人工
       xcco102c LIKE xcco_t.xcco102c, #當月調整金額-委外加工
       xcco102d LIKE xcco_t.xcco102d, #當月調整金額-制費一
       xcco102e LIKE xcco_t.xcco102e, #當月調整金額-制費二
       xcco102f LIKE xcco_t.xcco102f, #當月調整金額-制費三
       xcco102g LIKE xcco_t.xcco102g, #當月調整金額-制費四
       xcco102h LIKE xcco_t.xcco102h, #當月調整金額-制費五
       xccoownid LIKE xcco_t.xccoownid, #資料所有者
       xccoowndp LIKE xcco_t.xccoowndp, #資料所屬部門
       xccocrtid LIKE xcco_t.xccocrtid, #資料建立者
       xccocrtdp LIKE xcco_t.xccocrtdp, #資料建立部門
       xccocrtdt LIKE xcco_t.xccocrtdt, #資料創建日
       xccomodid LIKE xcco_t.xccomodid, #資料修改者
       xccomoddt LIKE xcco_t.xccomoddt, #最近修改日
       xccocnfid LIKE xcco_t.xccocnfid, #資料確認者
       xccocnfdt LIKE xcco_t.xccocnfdt, #資料確認日
       xccopstid LIKE xcco_t.xccopstid, #資料過帳者
       xccopstdt LIKE xcco_t.xccopstdt, #資料過帳日
       xccostus LIKE xcco_t.xccostus  #狀態碼
          END RECORD
#161109-00085#23-e mod
#161109-00085#23-s mod
#DEFINE l_xcco2      RECORD LIKE xcco_t.*   #161109-00085#23-s mark
DEFINE l_xcco2      RECORD  #本期庫存成本調整檔
       xccoent LIKE xcco_t.xccoent, #企業編號
       xccold LIKE xcco_t.xccold, #帳套
       xccocomp LIKE xcco_t.xccocomp, #法人組織
       xcco001 LIKE xcco_t.xcco001, #帳套本位幣順序
       xcco002 LIKE xcco_t.xcco002, #成本域
       xcco003 LIKE xcco_t.xcco003, #成本計算類型
       xcco004 LIKE xcco_t.xcco004, #年度
       xcco005 LIKE xcco_t.xcco005, #期別
       xcco006 LIKE xcco_t.xcco006, #料件編號
       xcco007 LIKE xcco_t.xcco007, #特性
       xcco008 LIKE xcco_t.xcco008, #批號
       xcco009 LIKE xcco_t.xcco009, #參考單號
       xcco010 LIKE xcco_t.xcco010, #資料來源
       xcco011 LIKE xcco_t.xcco011, #調整說明
       xcco102 LIKE xcco_t.xcco102, #當月調整金額-金額合計
       xcco102a LIKE xcco_t.xcco102a, #當月調整金額-材料
       xcco102b LIKE xcco_t.xcco102b, #當月調整金額-人工
       xcco102c LIKE xcco_t.xcco102c, #當月調整金額-委外加工
       xcco102d LIKE xcco_t.xcco102d, #當月調整金額-制費一
       xcco102e LIKE xcco_t.xcco102e, #當月調整金額-制費二
       xcco102f LIKE xcco_t.xcco102f, #當月調整金額-制費三
       xcco102g LIKE xcco_t.xcco102g, #當月調整金額-制費四
       xcco102h LIKE xcco_t.xcco102h, #當月調整金額-制費五
       xccoownid LIKE xcco_t.xccoownid, #資料所有者
       xccoowndp LIKE xcco_t.xccoowndp, #資料所屬部門
       xccocrtid LIKE xcco_t.xccocrtid, #資料建立者
       xccocrtdp LIKE xcco_t.xccocrtdp, #資料建立部門
       xccocrtdt LIKE xcco_t.xccocrtdt, #資料創建日
       xccomodid LIKE xcco_t.xccomodid, #資料修改者
       xccomoddt LIKE xcco_t.xccomoddt, #最近修改日
       xccocnfid LIKE xcco_t.xccocnfid, #資料確認者
       xccocnfdt LIKE xcco_t.xccocnfdt, #資料確認日
       xccopstid LIKE xcco_t.xccopstid, #資料過帳者
       xccopstdt LIKE xcco_t.xccopstdt, #資料過帳日
       xccostus LIKE xcco_t.xccostus  #狀態碼
          END RECORD
#161109-00085#23-e mod

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
                INITIALIZE l_xcco.* TO NULL
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',1).Value'],[l_xcco.xccoent])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',2).Value'],[l_xcco.xccold])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',3).Value'],[l_xcco.xccocomp])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',4).Value'],[l_xcco.xcco001])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',5).Value'],[l_xcco.xcco002])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',6).Value'],[l_xcco.xcco003])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',7).Value'],[l_xcco.xcco004])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',8).Value'],[l_xcco.xcco005])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',9).Value'],[l_xcco.xcco006])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',10).Value'],[l_xcco.xcco007])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',11).Value'],[l_xcco.xcco008])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',12).Value'],[l_xcco.xcco009])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',13).Value'],[l_xcco.xcco010])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',14).Value'],[l_xcco.xcco011]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',15).Value'],[l_xcco.xcco102a])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',16).Value'],[l_xcco.xcco102b])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',17).Value'],[l_xcco.xcco102c])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',18).Value'],[l_xcco.xcco102d])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',19).Value'],[l_xcco.xcco102e])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',20).Value'],[l_xcco.xcco102f])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',21).Value'],[l_xcco.xcco102g])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',22).Value'],[l_xcco.xcco102h])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',23).Value'],[l_xcco.xcco102])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',24).Value'],[l_xcco1.xcco102a])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',25).Value'],[l_xcco1.xcco102b])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',26).Value'],[l_xcco1.xcco102c])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',27).Value'],[l_xcco1.xcco102d])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',28).Value'],[l_xcco1.xcco102e])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',29).Value'],[l_xcco1.xcco102f])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',30).Value'],[l_xcco1.xcco102g])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',31).Value'],[l_xcco1.xcco102h])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',32).Value'],[l_xcco1.xcco102])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',33).Value'],[l_xcco2.xcco102a])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',34).Value'],[l_xcco2.xcco102b])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',35).Value'],[l_xcco2.xcco102c])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',36).Value'],[l_xcco2.xcco102d])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',37).Value'],[l_xcco2.xcco102e])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',38).Value'],[l_xcco2.xcco102f])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',39).Value'],[l_xcco2.xcco102g])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',40).Value'],[l_xcco2.xcco102h])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',41).Value'],[l_xcco2.xcco102])                
                
                #如果excel中存在不在畫面上的法人或者帳套CONTINUE
                IF l_xcco.xccold != g_xcco_f.xccold OR l_xcco.xccocomp != g_xcco_f.xccocomp THEN
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
                LET l_xcco.xcco001 = '1'  #本位幣
                LET l_xcco.xcco010 = '2'  #整批导入
                LET l_xcco.xccoownid = g_user
                LET l_xcco.xccoowndp = g_dept
                LET l_xcco.xccocrtid = g_user
                LET l_xcco.xccocrtdp = g_dept 
                LET l_xcco.xccocrtdt = cl_get_current()
                LET l_xcco.xccomodid = ""
                LET l_xcco.xccomoddt = ""
                LET l_xcco.xccocnfid = ""
                LET l_xcco.xccocnfdt = "" 
                LET l_xcco.xccopstid = ""
                LET l_xcco.xccopstdt = "" 
                LET l_xcco.xccostus = "Y"

                IF l_xcco.xcco008 IS NULL THEN  #key值批号可录入为空
                   LET l_xcco.xcco008 = ' '
                END IF
                IF l_xcco.xcco007 IS NULL THEN  #key值特性可录入为空
                   LET l_xcco.xcco007 = ' '
                END IF  
                #fengmy150121--begin
                IF l_xcco.xcco002 IS NULL THEN  #key值成本域可录入为空
                   LET l_xcco.xcco002 = ' '
                END IF
                #fengmy150121--end                
                #本位幣一
                #161109-00085#23-s mod                
#                INSERT INTO xcco_t VALUES l_xcco.*   #161109-00085#23-s mark
                INSERT INTO xcco_t (xccoent,xccold,xccocomp,xcco001,xcco002,xcco003,xcco004,xcco005,xcco006,xcco007,
                                    xcco008,xcco009,xcco010,xcco011,xcco102,xcco102a,xcco102b,xcco102c,xcco102d,xcco102e,
                                    xcco102f,xcco102g,xcco102h,xccoownid,xccoowndp,xccocrtid,xccocrtdp,xccocrtdt,xccomodid,xccomoddt,
                                    xccocnfid,xccocnfdt,xccopstid,xccopstdt,xccostus,xccoud001,xccoud002,xccoud003,xccoud004,xccoud005,
                                    xccoud006,xccoud007,xccoud008,xccoud009,xccoud010,xccoud011,xccoud012,xccoud013,xccoud014,xccoud015,
                                    xccoud016,xccoud017,xccoud018,xccoud019,xccoud020,xccoud021,xccoud022,xccoud023,xccoud024,xccoud025,
                                    xccoud026,xccoud027,xccoud028,xccoud029,xccoud030) 
                            VALUES (l_xcco.xccoent,l_xcco.xccold,l_xcco.xccocomp,l_xcco.xcco001,l_xcco.xcco002,
                                    l_xcco.xcco003,l_xcco.xcco004,l_xcco.xcco005,l_xcco.xcco006,l_xcco.xcco007,
                                    l_xcco.xcco008,l_xcco.xcco009,l_xcco.xcco010,l_xcco.xcco011,l_xcco.xcco102,
                                    l_xcco.xcco102a,l_xcco.xcco102b,l_xcco.xcco102c,l_xcco.xcco102d,l_xcco.xcco102e,
                                    l_xcco.xcco102f,l_xcco.xcco102g,l_xcco.xcco102h,l_xcco.xccoownid,l_xcco.xccoowndp,
                                    l_xcco.xccocrtid,l_xcco.xccocrtdp,l_xcco.xccocrtdt,l_xcco.xccomodid,l_xcco.xccomoddt,
                                    l_xcco.xccocnfid,l_xcco.xccocnfdt,l_xcco.xccopstid,l_xcco.xccopstdt,l_xcco.xccostus,
                                    l_xcco.xccoud001,l_xcco.xccoud002,l_xcco.xccoud003,l_xcco.xccoud004,l_xcco.xccoud005,
                                    l_xcco.xccoud006,l_xcco.xccoud007,l_xcco.xccoud008,l_xcco.xccoud009,l_xcco.xccoud010,
                                    l_xcco.xccoud011,l_xcco.xccoud012,l_xcco.xccoud013,l_xcco.xccoud014,l_xcco.xccoud015,
                                    l_xcco.xccoud016,l_xcco.xccoud017,l_xcco.xccoud018,l_xcco.xccoud019,l_xcco.xccoud020,
                                    l_xcco.xccoud021,l_xcco.xccoud022,l_xcco.xccoud023,l_xcco.xccoud024,l_xcco.xccoud025,
                                    l_xcco.xccoud026,l_xcco.xccoud027,l_xcco.xccoud028,l_xcco.xccoud029,l_xcco.xccoud030) 
                #161109-00085#23-e mod
                IF SQLCA.sqlcode THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = SQLCA.sqlcode
                   LET g_errparam.extend = 'ins xcco'
                   LET g_errparam.popup = FALSE
                   CALL cl_err()

                   LET r_success = FALSE
                   EXIT FOR
                END IF

                SELECT glaa015,glaa019
                  INTO g_glaa015,g_glaa019
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = l_xcco.xccold
                #本位幣二
                IF g_glaa015 = 'Y' THEN
                   IF cl_null(l_xcco1.xcco102a) THEN LET l_xcco1.xcco102a = 0 END IF  
                   IF cl_null(l_xcco1.xcco102b) THEN LET l_xcco1.xcco102b = 0 END IF 
                   IF cl_null(l_xcco1.xcco102c) THEN LET l_xcco1.xcco102c = 0 END IF 
                   IF cl_null(l_xcco1.xcco102d) THEN LET l_xcco1.xcco102d = 0 END IF 
                   IF cl_null(l_xcco1.xcco102e) THEN LET l_xcco1.xcco102e = 0 END IF 
                   IF cl_null(l_xcco1.xcco102f) THEN LET l_xcco1.xcco102f = 0 END IF 
                   IF cl_null(l_xcco1.xcco102g) THEN LET l_xcco1.xcco102g = 0 END IF 
                   IF cl_null(l_xcco1.xcco102h) THEN LET l_xcco1.xcco102h = 0 END IF 
                   IF cl_null(l_xcco1.xcco102)  THEN LET l_xcco1.xcco102  = 0 END IF                    
                  
                   INSERT INTO xcco_t(xccoent,xccold,xccocomp,xcco001,xcco002,xcco003,xcco004,xcco005,xcco006,xcco007,xcco008,xcco009,xcco010,xcco011,
                                      xcco102a,xcco102b,xcco102c,xcco102d,xcco102e,xcco102f,xcco102g,xcco102h,xcco102,
                                      xccoownid,xccoowndp,xccocrtid,xccocrtdp,xccocrtdt,xccomodid,xccomoddt,xccocnfid,xccocnfdt,xccopstid,xccopstdt,xccostus) 
                               VALUES(l_xcco.xccoent,l_xcco.xccold,l_xcco.xccocomp,'2',l_xcco.xcco002,l_xcco.xcco003,l_xcco.xcco004,l_xcco.xcco005,
                                      l_xcco.xcco006,l_xcco.xcco007,l_xcco.xcco008,l_xcco.xcco009,l_xcco.xcco010,l_xcco.xcco011,
                                      l_xcco1.xcco102a,l_xcco1.xcco102b,l_xcco1.xcco102c,l_xcco1.xcco102d,l_xcco1.xcco102e,l_xcco1.xcco102f,l_xcco1.xcco102g,l_xcco1.xcco102h,l_xcco1.xcco102,
                                      l_xcco.xccoownid,l_xcco.xccoowndp,l_xcco.xccocrtid,l_xcco.xccocrtdp,l_xcco.xccocrtdt,"","","","","","","Y")  
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'ins xcco 2'
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     LET r_success = FALSE
                     EXIT FOR
                  END IF                                      
                END IF
                #本位幣三
                IF g_glaa019 = 'Y' THEN 
                   IF cl_null(l_xcco2.xcco102a) THEN LET l_xcco2.xcco102a = 0 END IF  
                   IF cl_null(l_xcco2.xcco102b) THEN LET l_xcco2.xcco102b = 0 END IF 
                   IF cl_null(l_xcco2.xcco102c) THEN LET l_xcco2.xcco102c = 0 END IF 
                   IF cl_null(l_xcco2.xcco102d) THEN LET l_xcco2.xcco102d = 0 END IF 
                   IF cl_null(l_xcco2.xcco102e) THEN LET l_xcco2.xcco102e = 0 END IF 
                   IF cl_null(l_xcco2.xcco102f) THEN LET l_xcco2.xcco102f = 0 END IF 
                   IF cl_null(l_xcco2.xcco102g) THEN LET l_xcco2.xcco102g = 0 END IF 
                   IF cl_null(l_xcco2.xcco102h) THEN LET l_xcco2.xcco102h = 0 END IF 
                   IF cl_null(l_xcco2.xcco102)  THEN LET l_xcco2.xcco102  = 0 END IF  
                   INSERT INTO xcco_t(xccoent,xccold,xccocomp,xcco001,xcco002,xcco003,xcco004,xcco005,xcco006,xcco007,xcco008,xcco009,xcco010,xcco011,
                                      xcco102a,xcco102b,xcco102c,xcco102d,xcco102e,xcco102f,xcco102g,xcco102h,xcco102,
                                      xccoownid,xccoowndp,xccocrtid,xccocrtdp,xccocrtdt,xccomodid,xccomoddt,xccocnfid,xccocnfdt,xccopstid,xccopstdt,xccostus) 
                               VALUES(l_xcco.xccoent,l_xcco.xccold,l_xcco.xccocomp,'3',l_xcco.xcco002,l_xcco.xcco003,l_xcco.xcco004,l_xcco.xcco005,
                                      l_xcco.xcco006,l_xcco.xcco007,l_xcco.xcco008,l_xcco.xcco009,l_xcco.xcco010,l_xcco.xcco011,
                                      l_xcco2.xcco102a,l_xcco2.xcco102b,l_xcco2.xcco102c,l_xcco2.xcco102d,l_xcco2.xcco102e,l_xcco2.xcco102f,l_xcco2.xcco102g,l_xcco2.xcco102h,l_xcco2.xcco102,
                                      l_xcco.xccoownid,l_xcco.xccoowndp,l_xcco.xccocrtid,l_xcco.xccocrtdp,l_xcco.xccocrtdt,"","","","","","","Y")  
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'ins xcco 3'
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
# Descriptions...: 整批導入-獲取帳套說明
# Memo...........:
# Usage..........: CALL axct310_s02_get_xccold_desc()
# Input parameter:  
# Return code....: 
# Date & Author..: 2014/4/13 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct310_s02_get_xccold_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcco_f.xccold
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcco_f.xccold_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcco_f.xccold_desc
END FUNCTION

################################################################################
# Descriptions...:
# Memo...........:
# Usage..........: CALL axct310_get_date()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/7/7 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct310_get_date()
DEFINE l_glaa003 LIKE glaa_t.glaa003

            IF NOT cl_null(g_xcco_m.xcco004) AND NOT cl_null(g_xcco_m.xcco005) AND NOT cl_null(g_xcco_m.xccold) THEN
               SELECT glaa003 INTO l_glaa003 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xcco_m.xccold 
               CALL s_fin_date_get_period_range(l_glaa003,g_xcco_m.xcco004,g_xcco_m.xcco005)
                   RETURNING g_bdate,g_edate               
            END IF
END FUNCTION

################################################################################
# Descriptions...: 匯出格式顯示 
# Memo...........:
# Usage..........: CALL axct310_show_1()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/7/11 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axct310_show_1()
      DISPLAY ARRAY g_xcco4_d TO s_detail5.* ATTRIBUTES(COUNT=g_rec_b)  

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
PRIVATE FUNCTION axct310_generate_xcdo()
#161109-00085#23-s mod
#DEFINE l_xcdo          RECORD LIKE xcdo_t.*   #161109-00085#23-s mark
DEFINE l_xcdo          RECORD  #本期庫存成本要素成本調整檔
       xcdoent LIKE xcdo_t.xcdoent, #企業編號
       xcdold LIKE xcdo_t.xcdold, #帳套
       xcdocomp LIKE xcdo_t.xcdocomp, #法人組織
       xcdo001 LIKE xcdo_t.xcdo001, #帳套本位幣順序
       xcdo002 LIKE xcdo_t.xcdo002, #成本域
       xcdo003 LIKE xcdo_t.xcdo003, #成本計算類型
       xcdo004 LIKE xcdo_t.xcdo004, #年度
       xcdo005 LIKE xcdo_t.xcdo005, #期別
       xcdo006 LIKE xcdo_t.xcdo006, #成本要素
       xcdo007 LIKE xcdo_t.xcdo007, #料件編號
       xcdo008 LIKE xcdo_t.xcdo008, #特性
       xcdo009 LIKE xcdo_t.xcdo009, #批號
       xcdo010 LIKE xcdo_t.xcdo010, #參考單號
       xcdo011 LIKE xcdo_t.xcdo011, #資料來源
       xcdo012 LIKE xcdo_t.xcdo012, #調整說明
       xcdo102 LIKE xcdo_t.xcdo102, #當月調整金額
       xcdoownid LIKE xcdo_t.xcdoownid, #資料所有者
       xcdoowndp LIKE xcdo_t.xcdoowndp, #資料所屬部門
       xcdocrtid LIKE xcdo_t.xcdocrtid, #資料建立者
       xcdocrtdp LIKE xcdo_t.xcdocrtdp, #資料建立部門
       xcdocrtdt LIKE xcdo_t.xcdocrtdt, #資料創建日
       xcdomodid LIKE xcdo_t.xcdomodid, #資料修改者
       xcdomoddt LIKE xcdo_t.xcdomoddt, #最近修改日
       xcdocnfid LIKE xcdo_t.xcdocnfid, #資料確認者
       xcdocnfdt LIKE xcdo_t.xcdocnfdt, #資料確認日
       xcdopstid LIKE xcdo_t.xcdopstid, #資料過帳者
       xcdopstdt LIKE xcdo_t.xcdopstdt, #資料過帳日
       xcdostus LIKE xcdo_t.xcdostus, #狀態碼
       xcdoud001 LIKE xcdo_t.xcdoud001, #自定義欄位(文字)001
       xcdoud002 LIKE xcdo_t.xcdoud002, #自定義欄位(文字)002
       xcdoud003 LIKE xcdo_t.xcdoud003, #自定義欄位(文字)003
       xcdoud004 LIKE xcdo_t.xcdoud004, #自定義欄位(文字)004
       xcdoud005 LIKE xcdo_t.xcdoud005, #自定義欄位(文字)005
       xcdoud006 LIKE xcdo_t.xcdoud006, #自定義欄位(文字)006
       xcdoud007 LIKE xcdo_t.xcdoud007, #自定義欄位(文字)007
       xcdoud008 LIKE xcdo_t.xcdoud008, #自定義欄位(文字)008
       xcdoud009 LIKE xcdo_t.xcdoud009, #自定義欄位(文字)009
       xcdoud010 LIKE xcdo_t.xcdoud010, #自定義欄位(文字)010
       xcdoud011 LIKE xcdo_t.xcdoud011, #自定義欄位(數字)011
       xcdoud012 LIKE xcdo_t.xcdoud012, #自定義欄位(數字)012
       xcdoud013 LIKE xcdo_t.xcdoud013, #自定義欄位(數字)013
       xcdoud014 LIKE xcdo_t.xcdoud014, #自定義欄位(數字)014
       xcdoud015 LIKE xcdo_t.xcdoud015, #自定義欄位(數字)015
       xcdoud016 LIKE xcdo_t.xcdoud016, #自定義欄位(數字)016
       xcdoud017 LIKE xcdo_t.xcdoud017, #自定義欄位(數字)017
       xcdoud018 LIKE xcdo_t.xcdoud018, #自定義欄位(數字)018
       xcdoud019 LIKE xcdo_t.xcdoud019, #自定義欄位(數字)019
       xcdoud020 LIKE xcdo_t.xcdoud020, #自定義欄位(數字)020
       xcdoud021 LIKE xcdo_t.xcdoud021, #自定義欄位(日期時間)021
       xcdoud022 LIKE xcdo_t.xcdoud022, #自定義欄位(日期時間)022
       xcdoud023 LIKE xcdo_t.xcdoud023, #自定義欄位(日期時間)023
       xcdoud024 LIKE xcdo_t.xcdoud024, #自定義欄位(日期時間)024
       xcdoud025 LIKE xcdo_t.xcdoud025, #自定義欄位(日期時間)025
       xcdoud026 LIKE xcdo_t.xcdoud026, #自定義欄位(日期時間)026
       xcdoud027 LIKE xcdo_t.xcdoud027, #自定義欄位(日期時間)027
       xcdoud028 LIKE xcdo_t.xcdoud028, #自定義欄位(日期時間)028
       xcdoud029 LIKE xcdo_t.xcdoud029, #自定義欄位(日期時間)029
       xcdoud030 LIKE xcdo_t.xcdoud030  #自定義欄位(日期時間)030
                 END RECORD
#161109-00085#23-e mod
DEFINE l_sql           STRING
DEFINE l_success       LIKE type_t.chr1
DEFINE l_success1      LIKE type_t.num5
DEFINE l_xcdo_count    LIKE type_t.num5
DEFINE l_xcdo_count1   LIKE type_t.num5
DEFINE la_param  RECORD
                 prog   STRING,
                 param  DYNAMIC ARRAY OF STRING
                 END RECORD
DEFINE ls_js     STRING
DEFINE l_cnt     LIKE type_t.num5      #成本次要素个数     #fengmy150312

#fengmy150316--begin
IF NOT s_axct310_cre_tmp_table() THEN
   RETURN
END IF
#fengmy150316--end
CALL s_transaction_begin()
  LET l_success = 'Y'
  #fengmy 140930 begin-----mark------
  #axct320已审核或已作废资料不能再抛过去
#  LET l_sql = "SELECT COUNT(*) FROM xcdo_t ",
#              " WHERE xcdoent = ? AND xcdocomp = ? AND xcdold = ?",
#              "   AND xcdo003 = ? AND xcdo004 = ? AND xcdo005 = ? ",
#              "   AND xcdo010 = ? AND xcdo011 = ? AND xcdostus <> 'N'"
#  DECLARE axct310_xcdo_count_cs CURSOR FROM l_sql 
#  OPEN axct310_xcdo_count_cs USING g_enterprise,g_xcco_m.xccocomp,g_xcco_m.xccold,
#                                   g_xcco_m.xcco003,g_xcco_m.xcco004,g_xcco_m.xcco005,
#                                   g_xcco_m.xcco009,g_xcco_m.xcco010
#  FETCH axct310_xcdo_count_cs INTO l_xcdo_count
#  IF l_xcdo_count > 0 THEN
#     INITIALIZE g_errparam TO NULL
#     LET g_errparam.code = 'axc-00534'
#     LET g_errparam.extend = ''
#     LET g_errparam.popup = TRUE
#     CALL cl_err()
#     RETURN  
#  END IF 
  #fengmy 140930 end-----mark------
  #删除axct320已有资料 
  LET l_sql = "SELECT COUNT(*) FROM xcdo_t ",
              " WHERE xcdoent = ? AND xcdocomp = ? AND xcdold = ?",
              "   AND xcdo003 = ? AND xcdo004 = ? AND xcdo005 = ? ",
             #"   AND xcdo010 = ? AND xcdo011 = ? AND xcdostus = 'N'"  #fengmy mark 140930
              "   AND xcdo010 = ? AND xcdo011 = ? "                    #fengmy 140930 
  DECLARE axct310_xcdo_count_cs1 CURSOR FROM l_sql 
  OPEN axct310_xcdo_count_cs1 USING g_enterprise,g_xcco_m.xccocomp,g_xcco_m.xccold,
                                   g_xcco_m.xcco003,g_xcco_m.xcco004,g_xcco_m.xcco005,
                                   g_xcco_m.xcco009,g_xcco_m.xcco010
  FETCH axct310_xcdo_count_cs1 INTO l_xcdo_count1
  IF l_xcdo_count1 > 0 THEN
     IF cl_ask_confirm('axc-00386') THEN
        LET l_sql = "DELETE FROM xcdo_t ",
                    " WHERE xcdoent = '",g_enterprise,"'  AND xcdocomp = '",g_xcco_m.xccocomp,"'",
                    "   AND xcdold = '",g_xcco_m.xccold,"' AND xcdo003 = '",g_xcco_m.xcco003,"'",
                    "   AND xcdo004 = '",g_xcco_m.xcco004,"' AND xcdo005 = '",g_xcco_m.xcco005,"'",
                    "   AND xcdo010 = '",g_xcco_m.xcco009,"' AND xcdo011 = '",g_xcco_m.xcco010,"'"
                     
        PREPARE axct310_del_xcdo FROM l_sql
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code   = SQLCA.sqlcode
           LET g_errparam.extend = "PREPARE delete xcdo_t"
           LET g_errparam.popup  = TRUE
           CALL cl_err()
           RETURN 
        END IF
        EXECUTE axct310_del_xcdo 
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code   = SQLCA.sqlcode
           LET g_errparam.extend = "EXECUTE delete xcdo_t"
           LET g_errparam.popup  = TRUE
           CALL cl_err()
           RETURN 
        END IF 
     ELSE 
        RETURN         
     END IF  
  END IF
  
  
  #生成axct320资料
  LET l_sql = "SELECT xcco001,xcco002,xcco006,xcco007,xcco008,xcco011,xcco102",
              "  FROM xcco_t WHERE xccoent = ? AND xccocomp = ? AND xccold = ?",
              "  AND xcco003 = ? AND xcco004 = ? AND xcco005 = ? AND xcco009 = ?",
              "  AND xcco010 = ?",
              "  ORDER BY xcco001"
  DECLARE axct310_xcdo_cs CURSOR FROM l_sql 
  
  FOREACH axct310_xcdo_cs USING g_enterprise,g_xcco_m.xccocomp,g_xcco_m.xccold,
                                g_xcco_m.xcco003,g_xcco_m.xcco004,g_xcco_m.xcco005,
                                g_xcco_m.xcco009,g_xcco_m.xcco010
                          INTO l_xcdo.xcdo001,l_xcdo.xcdo002,l_xcdo.xcdo007,l_xcdo.xcdo008,
                               l_xcdo.xcdo009,l_xcdo.xcdo012,l_xcdo.xcdo102
          
          CASE l_xcdo.xcdo001
             WHEN 2  IF g_glaa015 = 'N' THEN CONTINUE FOREACH END IF
             WHEN 3  IF g_glaa019 = 'N' THEN CONTINUE FOREACH END IF
             OTHERWISE
          END CASE


          LET l_xcdo.xcdoent = g_enterprise
          LET l_xcdo.xcdocomp = g_xcco_m.xccocomp
          LET l_xcdo.xcdold = g_xcco_m.xccold
          LET l_xcdo.xcdo003 = g_xcco_m.xcco003
          LET l_xcdo.xcdo004 = g_xcco_m.xcco004
          LET l_xcdo.xcdo005 = g_xcco_m.xcco005
          LET l_xcdo.xcdo006 = ' '
          LET l_xcdo.xcdo010 = g_xcco_m.xcco009
          LET l_xcdo.xcdo011 = g_xcco_m.xcco010          
         #LET l_xcdo.xcdostus = 'N'  #fengmy mark 140930
          LET l_xcdo.xcdostus = 'Y'  #fengmy  140930
          LET l_xcdo.xcdoownid = g_user
          LET l_xcdo.xcdoowndp = g_dept
          LET l_xcdo.xcdocrtid = g_user
          LET l_xcdo.xcdocrtdp = g_dept 
          LET l_xcdo.xcdocrtdt = cl_get_current()
          LET l_xcdo.xcdomodid = ""
          LET l_xcdo.xcdomoddt = ""

#取次要素----fengmy150318--b
     CALL s_axct310_ins(g_xcco_m.xccold,g_xcco_m.xccocomp,l_xcdo.xcdo001,l_xcdo.xcdo002,g_xcco_m.xcco003,g_xcco_m.xcco004,g_xcco_m.xcco005,
                                        l_xcdo.xcdo007,l_xcdo.xcdo008,l_xcdo.xcdo009,l_xcdo.xcdo102)
          RETURNING l_success1,l_cnt
     IF l_success1 THEN
        LET l_sql =  " SELECT xcam004,amt FROM s_axct310_tmp2 "
        PREPARE s_axct310_tmp2_pb FROM l_sql
        DECLARE s_axct310_tmp2_cs CURSOR FOR s_axct310_tmp2_pb
        IF l_cnt = 1 THEN
           EXECUTE s_axct310_tmp2_pb INTO l_xcdo.xcdo006,l_xcdo.xcdo102
           #161109-00085#23-s mod
#           INSERT INTO xcdo_t VALUES(l_xcdo.*)   #161109-00085#23-s mark
           INSERT INTO xcdo_t(xcdoent,xcdold,xcdocomp,xcdo001,xcdo002,xcdo003,xcdo004,xcdo005,xcdo006,xcdo007,
                              xcdo008,xcdo009,xcdo010,xcdo011,xcdo012,xcdo102,xcdoownid,xcdoowndp,xcdocrtid,xcdocrtdp,
                              xcdocrtdt,xcdomodid,xcdomoddt,xcdocnfid,xcdocnfdt,xcdopstid,xcdopstdt,xcdostus,xcdoud001,xcdoud002,
                              xcdoud003,xcdoud004,xcdoud005,xcdoud006,xcdoud007,xcdoud008,xcdoud009,xcdoud010,xcdoud011,xcdoud012,
                              xcdoud013,xcdoud014,xcdoud015,xcdoud016,xcdoud017,xcdoud018,xcdoud019,xcdoud020,xcdoud021,xcdoud022,
                              xcdoud023,xcdoud024,xcdoud025,xcdoud026,xcdoud027,xcdoud028,xcdoud029,xcdoud030) 
                       VALUES(l_xcdo.xcdoent,l_xcdo.xcdold,l_xcdo.xcdocomp,l_xcdo.xcdo001,l_xcdo.xcdo002,
                              l_xcdo.xcdo003,l_xcdo.xcdo004,l_xcdo.xcdo005,l_xcdo.xcdo006,l_xcdo.xcdo007,
                              l_xcdo.xcdo008,l_xcdo.xcdo009,l_xcdo.xcdo010,l_xcdo.xcdo011,l_xcdo.xcdo012,
                              l_xcdo.xcdo102,l_xcdo.xcdoownid,l_xcdo.xcdoowndp,l_xcdo.xcdocrtid,l_xcdo.xcdocrtdp,
                              l_xcdo.xcdocrtdt,l_xcdo.xcdomodid,l_xcdo.xcdomoddt,l_xcdo.xcdocnfid,l_xcdo.xcdocnfdt,
                              l_xcdo.xcdopstid,l_xcdo.xcdopstdt,l_xcdo.xcdostus,l_xcdo.xcdoud001,l_xcdo.xcdoud002,
                              l_xcdo.xcdoud003,l_xcdo.xcdoud004,l_xcdo.xcdoud005,l_xcdo.xcdoud006,l_xcdo.xcdoud007,
                              l_xcdo.xcdoud008,l_xcdo.xcdoud009,l_xcdo.xcdoud010,l_xcdo.xcdoud011,l_xcdo.xcdoud012,
                              l_xcdo.xcdoud013,l_xcdo.xcdoud014,l_xcdo.xcdoud015,l_xcdo.xcdoud016,l_xcdo.xcdoud017,
                              l_xcdo.xcdoud018,l_xcdo.xcdoud019,l_xcdo.xcdoud020,l_xcdo.xcdoud021,l_xcdo.xcdoud022,
                              l_xcdo.xcdoud023,l_xcdo.xcdoud024,l_xcdo.xcdoud025,l_xcdo.xcdoud026,l_xcdo.xcdoud027,
                              l_xcdo.xcdoud028,l_xcdo.xcdoud029,l_xcdo.xcdoud030)
           #161109-00085#23-e mod
           IF SQLCA.SQLCODE AND (NOT cl_err_sql_dup_value(SQLCA.SQLCODE)) THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = SQLCA.sqlcode
              LET g_errparam.extend = 'ins xcdo_t'
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET l_success = 'N' 
              EXIT FOREACH      
           END IF                           
        ELSE
           FOREACH s_axct310_tmp2_cs INTO l_xcdo.xcdo006,l_xcdo.xcdo102
              #161109-00085#23-s mod
#              INSERT INTO xcdo_t VALUES(l_xcdo.*)   #161109-00085#23-s mark
              INSERT INTO xcdo_t(xcdoent,xcdold,xcdocomp,xcdo001,xcdo002,xcdo003,xcdo004,xcdo005,xcdo006,xcdo007,
                                 xcdo008,xcdo009,xcdo010,xcdo011,xcdo012,xcdo102,xcdoownid,xcdoowndp,xcdocrtid,xcdocrtdp,
                                 xcdocrtdt,xcdomodid,xcdomoddt,xcdocnfid,xcdocnfdt,xcdopstid,xcdopstdt,xcdostus,xcdoud001,xcdoud002,
                                 xcdoud003,xcdoud004,xcdoud005,xcdoud006,xcdoud007,xcdoud008,xcdoud009,xcdoud010,xcdoud011,xcdoud012,
                                 xcdoud013,xcdoud014,xcdoud015,xcdoud016,xcdoud017,xcdoud018,xcdoud019,xcdoud020,xcdoud021,xcdoud022,
                                 xcdoud023,xcdoud024,xcdoud025,xcdoud026,xcdoud027,xcdoud028,xcdoud029,xcdoud030) 
                          VALUES(l_xcdo.xcdoent,l_xcdo.xcdold,l_xcdo.xcdocomp,l_xcdo.xcdo001,l_xcdo.xcdo002,
                                 l_xcdo.xcdo003,l_xcdo.xcdo004,l_xcdo.xcdo005,l_xcdo.xcdo006,l_xcdo.xcdo007,
                                 l_xcdo.xcdo008,l_xcdo.xcdo009,l_xcdo.xcdo010,l_xcdo.xcdo011,l_xcdo.xcdo012,
                                 l_xcdo.xcdo102,l_xcdo.xcdoownid,l_xcdo.xcdoowndp,l_xcdo.xcdocrtid,l_xcdo.xcdocrtdp,
                                 l_xcdo.xcdocrtdt,l_xcdo.xcdomodid,l_xcdo.xcdomoddt,l_xcdo.xcdocnfid,l_xcdo.xcdocnfdt,
                                 l_xcdo.xcdopstid,l_xcdo.xcdopstdt,l_xcdo.xcdostus,l_xcdo.xcdoud001,l_xcdo.xcdoud002,
                                 l_xcdo.xcdoud003,l_xcdo.xcdoud004,l_xcdo.xcdoud005,l_xcdo.xcdoud006,l_xcdo.xcdoud007,
                                 l_xcdo.xcdoud008,l_xcdo.xcdoud009,l_xcdo.xcdoud010,l_xcdo.xcdoud011,l_xcdo.xcdoud012,
                                 l_xcdo.xcdoud013,l_xcdo.xcdoud014,l_xcdo.xcdoud015,l_xcdo.xcdoud016,l_xcdo.xcdoud017,
                                 l_xcdo.xcdoud018,l_xcdo.xcdoud019,l_xcdo.xcdoud020,l_xcdo.xcdoud021,l_xcdo.xcdoud022,
                                 l_xcdo.xcdoud023,l_xcdo.xcdoud024,l_xcdo.xcdoud025,l_xcdo.xcdoud026,l_xcdo.xcdoud027,
                                 l_xcdo.xcdoud028,l_xcdo.xcdoud029,l_xcdo.xcdoud030)
              #161109-00085#23-e mod
              IF SQLCA.SQLCODE AND (NOT cl_err_sql_dup_value(SQLCA.SQLCODE)) THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = 'ins xcdo_t'
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET l_success = 'N' 
                 EXIT FOREACH      
              END IF                     
           END FOREACH        
        END IF
     ELSE
        #161109-00085#23-s mod
#        INSERT INTO xcdo_t VALUES(l_xcdo.*)   #161109-00085#23-s mark
        INSERT INTO xcdo_t(xcdoent,xcdold,xcdocomp,xcdo001,xcdo002,xcdo003,xcdo004,xcdo005,xcdo006,xcdo007,
                           xcdo008,xcdo009,xcdo010,xcdo011,xcdo012,xcdo102,xcdoownid,xcdoowndp,xcdocrtid,xcdocrtdp,
                           xcdocrtdt,xcdomodid,xcdomoddt,xcdocnfid,xcdocnfdt,xcdopstid,xcdopstdt,xcdostus,xcdoud001,xcdoud002,
                           xcdoud003,xcdoud004,xcdoud005,xcdoud006,xcdoud007,xcdoud008,xcdoud009,xcdoud010,xcdoud011,xcdoud012,
                           xcdoud013,xcdoud014,xcdoud015,xcdoud016,xcdoud017,xcdoud018,xcdoud019,xcdoud020,xcdoud021,xcdoud022,
                           xcdoud023,xcdoud024,xcdoud025,xcdoud026,xcdoud027,xcdoud028,xcdoud029,xcdoud030) 
                    VALUES(l_xcdo.xcdoent,l_xcdo.xcdold,l_xcdo.xcdocomp,l_xcdo.xcdo001,l_xcdo.xcdo002,
                           l_xcdo.xcdo003,l_xcdo.xcdo004,l_xcdo.xcdo005,l_xcdo.xcdo006,l_xcdo.xcdo007,
                           l_xcdo.xcdo008,l_xcdo.xcdo009,l_xcdo.xcdo010,l_xcdo.xcdo011,l_xcdo.xcdo012,
                           l_xcdo.xcdo102,l_xcdo.xcdoownid,l_xcdo.xcdoowndp,l_xcdo.xcdocrtid,l_xcdo.xcdocrtdp,
                           l_xcdo.xcdocrtdt,l_xcdo.xcdomodid,l_xcdo.xcdomoddt,l_xcdo.xcdocnfid,l_xcdo.xcdocnfdt,
                           l_xcdo.xcdopstid,l_xcdo.xcdopstdt,l_xcdo.xcdostus,l_xcdo.xcdoud001,l_xcdo.xcdoud002,
                           l_xcdo.xcdoud003,l_xcdo.xcdoud004,l_xcdo.xcdoud005,l_xcdo.xcdoud006,l_xcdo.xcdoud007,
                           l_xcdo.xcdoud008,l_xcdo.xcdoud009,l_xcdo.xcdoud010,l_xcdo.xcdoud011,l_xcdo.xcdoud012,
                           l_xcdo.xcdoud013,l_xcdo.xcdoud014,l_xcdo.xcdoud015,l_xcdo.xcdoud016,l_xcdo.xcdoud017,
                           l_xcdo.xcdoud018,l_xcdo.xcdoud019,l_xcdo.xcdoud020,l_xcdo.xcdoud021,l_xcdo.xcdoud022,
                           l_xcdo.xcdoud023,l_xcdo.xcdoud024,l_xcdo.xcdoud025,l_xcdo.xcdoud026,l_xcdo.xcdoud027,
                           l_xcdo.xcdoud028,l_xcdo.xcdoud029,l_xcdo.xcdoud030)
        #161109-00085#23-e mod
        IF SQLCA.SQLCODE AND (NOT cl_err_sql_dup_value(SQLCA.SQLCODE)) THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = 'ins xcdo_t'
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
CALL s_axct310_drop_tmp_table()    #fengmy150316 
  IF l_success = 'Y' THEN
     INITIALIZE la_param.* TO NULL
     LET la_param.prog = "axct320"               
     LET la_param.param[1] = g_xcco_m.xccold
     LET la_param.param[2] = g_xcco_m.xcco003
     LET la_param.param[3] = g_xcco_m.xcco004
     LET la_param.param[4] = g_xcco_m.xcco005
     LET la_param.param[5] = g_xcco_m.xcco009                            
     LET ls_js = util.JSON.stringify(la_param)
     DISPLAY ls_js
     CALL cl_cmdrun(ls_js)
  END IF

END FUNCTION

 
{</section>}
 
