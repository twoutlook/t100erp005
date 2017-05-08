#該程式已解開Section, 不再透過樣板產出!
{<section id="astm601.description" >}
#+ Version..: T100-ERP-1.00.00(版次:1) Build-000275
#+ 
#+ Filename...: astm601
#+ Description: 自營合約維護作業
#+ Creator....: 01533(2013/10/17)
#+ Modifier...: 01533(2013/10/18)
#+ Buildtype..: 應用 t01 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="astm601.global" >}

    
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目
#160318-00005#44  2016/03/26  By pengxin     修正azzi920重复定义之错误讯息
#160318-00025#37  2016/04/19  By pengxin     將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160513-00033#8   2016/05/24  By 02097       增加现金返利
#160905-00007#16  2016/09/05  By 02599       SQL条件增加ent
#161024-00025#2   2016/10/25  By dongsz      stce026开窗where条件改为ooef201='Y'
#161108-00016#1   2016/11/09  by 08742       修改 g_browser_cnt 定义大小
#161111-00028#3   2016/11/15  by 02481       标准程式定义采用宣告模式,弃用.*写法
#161214-00032#1   2016/12/15  by 07900       石狮通达权限设置.freestyle或者是改过section者,需检核规格【资料表关联设定】主表要跟现在程序主表一致;主sql部分要补上cl_sql_add_filter
#170202-00019#1   2017/02/02  by 02749       調整舊值備份變數,帶值與被帶值欄位應使用 g_stce_m_o 備份; t_stce 應改用 g_stce_m_o 
#end add-point
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
{<Module define>}
 
#單頭 type 宣告
PRIVATE type type_g_stce_m        RECORD
   stcesite LIKE stce_t.stcesite,
   stce005 LIKE stce_t.stce005, 
   stce001 LIKE stce_t.stce001, 
   stce002 LIKE stce_t.stce002, 
   stce003 LIKE stce_t.stce003, 
   stce009 LIKE stce_t.stce009, 
   stce009_desc LIKE type_t.chr80,
   stce010 LIKE stce_t.stce010,
   stce010_desc LIKE type_t.chr80,  
   stce011 LIKE stce_t.stce011,
   stce011_desc LIKE type_t.chr80, 
   stce012 LIKE stce_t.stce012,
   stce012_desc LIKE type_t.chr80,
   stce004 LIKE stce_t.stce004, 
   stce004_desc LIKE type_t.chr80, 
   stceunit LIKE stce_t.stceunit, 
   stceunit_desc LIKE type_t.chr80, 
   stce027 LIKE stce_t.stce027,
   stce021 LIKE stce_t.stce021, 
   stce021_desc LIKE type_t.chr80, 
   stce022 LIKE stce_t.stce022, 
   stce022_desc LIKE type_t.chr80, 
   stce023 LIKE stce_t.stce023,
   stce023_desc LIKE type_t.chr80,    
   stce006 LIKE stce_t.stce006, 
   stce006_desc LIKE type_t.chr80, 
   stce007 LIKE stce_t.stce007, 
   stce007_desc LIKE type_t.chr80, 
   stce008      LIKE stce_t.stce008,
   stce024 LIKE stce_t.stce024, 
   stce024_desc LIKE type_t.chr80, 
   stce028 LIKE stce_t.stce028,
   stce028_desc LIKE type_t.chr80,
   stce025 LIKE stce_t.stce025, 
   stce025_desc LIKE type_t.chr80, 
   stce026 LIKE stce_t.stce026,
   stce026_desc LIKE type_t.chr80,    
   stce013 LIKE stce_t.stce013, 
   stce014 LIKE stce_t.stce014, 
   stce014_desc LIKE type_t.chr80, 
   stce015 LIKE stce_t.stce015, 
   stce015_desc LIKE type_t.chr80, 
   stce016 LIKE stce_t.stce016,
   stce016_desc LIKE type_t.chr80, 
   stce017 LIKE stce_t.stce017, 
   stce018 LIKE stce_t.stce018, 
   stce019 LIKE stce_t.stce019, 
   stce020 LIKE stce_t.stce020,
   next_b  LIKE type_t.dat,
   ooff013 LIKE type_t.chr1000,   
   stcestus LIKE stce_t.stcestus, 
   stceownid LIKE stce_t.stceownid, 
   stceownid_desc LIKE type_t.chr80, 
   stceowndp LIKE stce_t.stceowndp, 
   stceowndp_desc LIKE type_t.chr80, 
   stcecrtid LIKE stce_t.stcecrtid, 
   stcecrtid_desc LIKE type_t.chr80, 
   stcecrtdp LIKE stce_t.stcecrtdp, 
   stcecrtdp_desc LIKE type_t.chr80, 
   stcecrtdt DATETIME YEAR TO SECOND, 
   stcemodid LIKE stce_t.stcemodid, 
   stcemodid_desc LIKE type_t.chr80, 
   stcemoddt DATETIME YEAR TO SECOND, 
   stcecnfid LIKE stce_t.stcecnfid, 
   stcecnfid_desc LIKE type_t.chr80, 
   stcecnfdt DATETIME YEAR TO SECOND
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_stcf_d        RECORD
       stcfseq LIKE stcf_t.stcfseq, 
   stcf002 LIKE stcf_t.stcf002, 
   stcf002_desc LIKE type_t.chr500, 
   stcf021 LIKE stcf_t.stcf021,  #160513-00033#8
   stcf003 LIKE stcf_t.stcf003, 
   stcf004 LIKE stcf_t.stcf004, 
   stcf005 LIKE stcf_t.stcf005, 
   stcf006 LIKE stcf_t.stcf006, 
   stcf007 LIKE stcf_t.stcf007, 
   stcf008 LIKE stcf_t.stcf008, 
   stcf008_desc LIKE type_t.chr500, 
   stcf009 LIKE stcf_t.stcf009, 
   stcf009_desc LIKE type_t.chr500, 
   stcf010 LIKE stcf_t.stcf010, 
   stcf011 LIKE stcf_t.stcf011, 
   stcf012 LIKE stcf_t.stcf012, 
   stcf013 LIKE stcf_t.stcf013, 
   stcf014 LIKE stcf_t.stcf014, 
   stcf015 LIKE stcf_t.stcf015, 
   stcf016 LIKE stcf_t.stcf016, 
   stcf017 LIKE stcf_t.stcf017, 
   stcf018 LIKE stcf_t.stcf018,
   stcf019 LIKE stcf_t.stcf019,
   stcf020 LIKE stcf_t.stcf020,
   stcfsite LIKE stcf_t.stcfsite,
   stcfunit LIKE stcf_t.stcfunit
       END RECORD
PRIVATE TYPE type_g_stcf2_d RECORD
       stchseq LIKE stch_t.stchseq, 
   stch002 LIKE stch_t.stch002, 
   stch002_desc LIKE type_t.chr500, 
   stch003 LIKE stch_t.stch003,
   stchsite LIKE stch_t.stchsite,
   stchunit LIKE stch_t.stchunit
       END RECORD
 
 
 
#模組變數(Module Variables)
DEFINE g_stce_m          type_g_stce_m
DEFINE g_stce_m_t        type_g_stce_m
 
   DEFINE g_stce001_t LIKE stce_t.stce001
 
 
DEFINE g_stcf_d          DYNAMIC ARRAY OF type_g_stcf_d
DEFINE g_stcf_d_t        type_g_stcf_d
DEFINE g_stcf2_d   DYNAMIC ARRAY OF type_g_stcf2_d
DEFINE g_stcf2_d_t type_g_stcf2_d
 
 
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位 
         b_statepic     LIKE type_t.chr50,
            b_stce001 LIKE stce_t.stce001,
      b_stce005 LIKE stce_t.stce005,
      b_stce002 LIKE stce_t.stce002,
      b_stce004 LIKE stce_t.stce004,
      b_stce009 LIKE stce_t.stce009,
      b_stce021 LIKE stce_t.stce021,
      b_stce022 LIKE stce_t.stce022,
      b_stce023 LIKE stce_t.stce023,
      b_stce006 LIKE stce_t.stce006,
      b_stce007 LIKE stce_t.stce007,
      b_stce026 LIKE stce_t.stce026,
      b_stce013 LIKE stce_t.stce013,
      b_stce014 LIKE stce_t.stce014,
      b_stce015 LIKE stce_t.stce015,
      b_stce024 LIKE stce_t.stce024,
      b_stce025 LIKE stce_t.stce025,
      b_stce017 LIKE stce_t.stce017,
      b_stce018 LIKE stce_t.stce018,
      b_stce019 LIKE stce_t.stce019,
      b_stce020 LIKE stce_t.stce020,
      b_stce003 LIKE stce_t.stce003,
      b_stceunit LIKE stce_t.stceunit
         #,rank           LIKE type_t.num10
      END RECORD 
      
DEFINE g_browser_f  RECORD    #資料瀏覽之欄位 
         b_statepic     LIKE type_t.chr50,
            b_stce001 LIKE stce_t.stce001,
      b_stce005 LIKE stce_t.stce005,
      b_stce002 LIKE stce_t.stce002,
      b_stce004 LIKE stce_t.stce004,
      b_stce009 LIKE stce_t.stce009,
      b_stce021 LIKE stce_t.stce021,
      b_stce022 LIKE stce_t.stce022,
      b_stce023 LIKE stce_t.stce023,
      b_stce006 LIKE stce_t.stce006,
      b_stce007 LIKE stce_t.stce007,
      b_stce026 LIKE stce_t.stce026,
      b_stce013 LIKE stce_t.stce013,
      b_stce014 LIKE stce_t.stce014,
      b_stce015 LIKE stce_t.stce015,
      b_stce024 LIKE stce_t.stce024,
      b_stce025 LIKE stce_t.stce025,
      b_stce017 LIKE stce_t.stce017,
      b_stce018 LIKE stce_t.stce018,
      b_stce019 LIKE stce_t.stce019,
      b_stce020 LIKE stce_t.stce020,
      b_stce003 LIKE stce_t.stce003,
      b_stceunit LIKE stce_t.stceunit
         #,rank           LIKE type_t.num10
      END RECORD 
      
#無單頭append欄位定義
#無單身append欄位定義
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
 
 
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
 
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5        
#DEFINE g_rec_b               LIKE type_t.num5             #單身筆數   #161108-00016#1   2016/11/09  by 08742 mark                      
DEFINE g_rec_b               LIKE type_t.num10             #單身筆數    #161108-00016#1   2016/11/09  by 08742 add          
#DEFINE l_ac                  LIKE type_t.num5             #161108-00016#1   2016/11/09  by 08742 mark       
DEFINE l_ac                  LIKE type_t.num10             #161108-00016#1   2016/11/09  by 08742 add      
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
    
#DEFINE g_pagestart           LIKE type_t.num5             #page起始筆數#161108-00016#1   2016/11/09  by 08742 mark 
DEFINE g_pagestart           LIKE type_t.num10             #page起始筆數#161108-00016#1   2016/11/09  by 08742 add            
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_state               STRING       
 
#161108-00016#1   2016/11/09  by 08742 -S
#DEFINE g_detail_cnt          LIKE type_t.num5             #單身總筆數 
#DEFINE g_detail_idx          LIKE type_t.num5             #單身目前所在筆數
#DEFINE g_detail_idx2         LIKE type_t.num5             #單身2目前所在筆數
#DEFINE g_browser_cnt         LIKE type_t.num5             #Browser總筆數
#DEFINE g_browser_idx         LIKE type_t.num5             #Browser目前所在筆數
#DEFINE g_temp_idx            LIKE type_t.num5             #Browser目前所在筆數(暫存用)
DEFINE g_detail_cnt          LIKE type_t.num10             #單身總筆數  
DEFINE g_detail_idx          LIKE type_t.num10             #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10             #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10             
DEFINE g_browser_idx         LIKE type_t.num10             #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10             #Browser目前所在筆數(暫存用)
#161108-00016#1   2016/11/09  by 08742 -E
 
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序欄位
                                                        
#DEFINE g_current_row         LIKE type_t.num5             #Browser 所在筆數(暫存用) #161108-00016#1   2016/11/09  by 08742 mark
DEFINE g_current_row         LIKE type_t.num10             #Browser 所在筆數(暫存用) #161108-00016#1   2016/11/09  by 08742 add
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
#DEFINE g_current_page        LIKE type_t.num5             #目前所在頁數 #161108-00016#1   2016/11/09  by 08742 mark
DEFINE g_current_page        LIKE type_t.num10             #目前所在頁數 #161108-00016#1   2016/11/09  by 08742 add
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
DEFINE g_error_show          LIKE type_t.num5              #
 
DEFINE g_wc_frozen           STRING                        #凍結欄位使用
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_aw                  STRING                        #確定當下點擊的單身
  
{</Module define>}
 
#add-point:自定義模組變數(Module Variable)
 TYPE type_g_stcg_d        RECORD
    stcgseq2 LIKE stcg_t.stcgseq2, 
    stcg002 LIKE stcg_t.stcg002, 
    stcg003 LIKE stcg_t.stcg003, 
    stcg004 LIKE stcg_t.stcg004,
    stcgsite LIKE stcg_t.stcgsite,
    stcgunit LIKE stcg_t.stcgunit
       END RECORD
DEFINE g_stcg_d        DYNAMIC ARRAY OF type_g_stcg_d  
DEFINE g_stcg_d_t      type_g_stcg_d
DEFINE l_ac3           LIKE type_t.num5
DEFINE g_rec_b3        LIKE type_t.num5
DEFINE g_detail_idx3   LIKE type_t.num5
DEFINE g_wc2_table3          STRING
DEFINE g_stcf_d_o        type_g_stcf_d

TYPE type_g_stcw_d        RECORD
    stcwsite LIKE stcw_t.stcwsite,
    stcwunit LIKE stcw_t.stcwunit,
    stcwseq LIKE stcw_t.stcwseq, 
    stcw002 LIKE stcw_t.stcw002, 
    stcw003 LIKE stcw_t.stcw003, 
    stcw004 LIKE stcw_t.stcw004,
    stcw005 LIKE stcw_t.stcw005,
    stcw006 LIKE stcw_t.stcw006
       END RECORD
DEFINE g_stcw_d        DYNAMIC ARRAY OF type_g_stcw_d  
DEFINE g_stcw_d_t      type_g_stcw_d

DEFINE g_wc2_table4          STRING   
DEFINE g_stce_m_o        type_g_stce_m
#DEFINE t_stce            type_g_stce_m   #170202-00019#1 170202 by 02749 add
DEFINE g_site_flag   LIKE type_t.num5
#160513-00033#8--(S)
 TYPE type_g_stcl_d        RECORD
   stclseq LIKE stcl_t.stclseq, 
   stcl002 LIKE stcl_t.stcl002, 
   stcl002_desc LIKE type_t.chr500, 
   stcl003 LIKE stcl_t.stcl003, 
   imaal003 LIKE imaal_t.imaal003,
   imaal004 LIKE imaal_t.imaal004,
   stcl004 LIKE stcl_t.stcl004, 
   stcl005 LIKE stcl_t.stcl005, 
   stcl006 LIKE stcl_t.stcl006, 
   stcl007 LIKE stcl_t.stcl007, 
   stcl008 LIKE stcl_t.stcl008, 
   stcl009 LIKE stcl_t.stcl009, 
   stcl010 LIKE stcl_t.stcl010, 
   stcl010_desc LIKE type_t.chr500,
   stcl011 LIKE stcl_t.stcl011, 
   stcl012 LIKE stcl_t.stcl012, 
   stcl013 LIKE stcl_t.stcl013, 
   stcl014 LIKE stcl_t.stcl014, 
   stcl014_desc LIKE type_t.chr500
       END RECORD
DEFINE g_stcl_d          DYNAMIC ARRAY OF type_g_stcl_d
DEFINE g_stcl_d_t        type_g_stcl_d
DEFINE g_stcl_d_o        type_g_stcl_d
DEFINE g_wc2_table5      STRING
DEFINE l_ac5             LIKE type_t.num5
DEFINE g_rec_b5          LIKE type_t.num5
DEFINE g_detail_idx5     LIKE type_t.num5
#160513-00033#8--(E)
#end add-point
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="astm601.main" >}
#test
#+ 此段落由子樣板a26產生
#OPTIONS SHORT CIRCUIT
#+ 作業開始 
MAIN
   #add-point:main段define
   DEFINE l_success LIKE type_t.num5  
   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ast","")
 
   #add-point:作業初始化
   CALL s_aooi390_cre_tmp_table() RETURNING l_success   #add--2015/03/20 By shiun
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = "SELECT stce005,stce001,stce002,stce003,stce009,'',stce004,'',stceunit,'',stce021, 
       '',stce022,'',stce023,'',stce006,'',stce007,'',stce024,'',stce025,'',stce026,stce013,stce014,'', 
       stce015,'',stce017,stce018,stce019,stce020,stcestus,stceownid,'',stceowndp,'',stcecrtid,'',stcecrtdp, 
       '',stcecrtdt,stcemodid,'',stcemoddt,stcecnfid,'',stcecnfdt FROM stce_t WHERE stceent= ? AND stce001=?  
       FOR UPDATE"
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   DECLARE astm601_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call
      
      #end add-point
 
   ELSE
      
      #畫面開啟 (identifier)
      OPEN WINDOW w_astm601 WITH FORM cl_ap_formpath("ast",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL astm601_init()   
 
      #進入選單 Menu (="N")
      CALL astm601_ui_dialog() 
	  
      #add-point:畫面關閉前
      CALL s_aooi500_drop_temp() RETURNING l_success
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_astm601
      
   END IF 
   
   CLOSE astm601_cl
   
   
 
   #add-point:作業離開前
   CALL s_aooi390_drop_tmp_table()   #add--2015/03/20 By shiun      
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="astm601.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION astm601_init()
   #add-point:init段define
   DEFINE l_success LIKE type_t.num5  
   DEFINE l_ecir0064 LIKE type_t.chr1     #160513-00033#8
   #end add-point    
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_error_show  = 1
      CALL cl_set_combo_scc_part('stcestus','50','N,X,Y')
 
      CALL cl_set_combo_scc('stce005','6013') 
   CALL cl_set_combo_scc('stcf004','6006') 
   CALL cl_set_combo_scc('stcf005','6007') 
   CALL cl_set_combo_scc('stcf006','6008') 
   CALL cl_set_combo_scc('stcf007','6009') 
   CALL cl_set_combo_scc('stcf012','6010') 
   CALL cl_set_combo_scc('stcf015','6011') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
 
   #add-point:畫面資料初始化

   CALL cl_set_combo_scc_part('b_stce005','6013',"11,12,13")
   CALL cl_set_combo_scc_part('stcf004','6006',"1,2") 
   CALL cl_set_combo_scc_part('stce005','6013',"11,12,13") 
   CALL s_aooi500_create_temp() RETURNING l_success
   #160513-00033#8--(S)
   CALL cl_get_para(g_enterprise,'','E-CIR-0064') RETURNING l_ecir0064 
   CALL cl_set_combo_scc('stcl004','6096')
   CALL cl_set_combo_scc('stcl005','6097')
   CALL cl_set_combo_scc('stcl011','6098')
   IF l_ecir0064 = '1' THEN      
      CALL cl_set_comp_visible('stcl003,imaal003,imaal004',FALSE)    #依单据隐藏商品
   ELSE
      CALL cl_set_comp_visible('stcl002,stcl002_desc',FALSE)         #依商品隐藏摘要
   END IF
   #160513-00033#8--(E)
   #end add-point
   
   CALL astm601_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="astm601.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION astm601_ui_dialog()
   {<Local define>}
   DEFINE li_idx  LIKE type_t.num5
   {</Local define>}
   #add-point:ui_dialog段define
   
   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   CALL gfrm_curr.setElementImage("logo","logo/applogo.png") 
   IF g_wc.trim() <> "1=1" THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   ELSE
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF
   
   #add-point:ui_dialog段before dialog 
   
   #end add-point
   
   WHILE TRUE 
   
      CALL astm601_browser_fill("")
      CALL lib_cl_dlg.cl_dlg_before_display()
      CALL cl_notice()
            
      #判斷前一個動作是否為新增, 若是的話切換到新增的筆數
      IF g_state = "Y" THEN
         FOR li_idx = 1 TO g_browser.getLength()
            IF g_browser[li_idx].b_stce001 = g_stce001_t
 
               THEN
               LET g_current_row = li_idx
               LET g_current_idx = li_idx
               EXIT FOR
            END IF
         END FOR
         LET g_state = ""
      END IF
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
         #INPUT g_searchstr,g_searchcol FROM formonly.searchstr,formonly.cbo_searchcol
         #
         #   BEFORE INPUT
         #   
         #END INPUT
 
         #左側瀏覽頁簽
         DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTES(COUNT=g_header_cnt)
 
            BEFORE ROW
               #回歸舊筆數位置 (回到當時異動的筆數)
               LET g_current_idx = DIALOG.getCurrentRow("s_browse")
               IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
                  CALL DIALOG.setCurrentRow("s_browse",g_current_row)
                  LET g_current_idx = g_current_row
               END IF
               LET g_current_row = g_current_idx #目前指標
               LET g_current_sw = TRUE
 
               IF g_current_idx > g_browser.getLength() THEN
                  LET g_current_idx = g_browser.getLength()
               END IF 
               
               CALL astm601_fetch('') # reload data
               LET l_ac = 1
               CALL astm601_ui_detailshow() #Setting the current row 
      
               CALL astm601_idx_chk()
               #NEXT FIELD stcfseq
         
         END DISPLAY
        
         DISPLAY ARRAY g_stcf_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               CALL astm601_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               
               #add-point:page1, before row動作
                              CALL astm601_b3_fill()
               CALL astm601_reflesh()
               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               CALL astm601_idx_chk()
               #add-point:page1自定義行為
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
 
 
         ON ACTION detail_qrystr
 
            LET g_action_choice="detail_qrystr"
            IF cl_auth_chk_act("detail_qrystr") THEN 
               MENU "" ATTRIBUTE(STYLE="popup")
 
                  ON ACTION asti203
 
                     LET g_action_choice="asti203"
                     IF cl_auth_chk_act("asti203") THEN 
                        #add-point:ON ACTION asti203
                        CALL cl_cmdrun_wait("asti203")
                        #END add-point
                        
                     END IF
 
 
                  ON ACTION asti205
 
                     LET g_action_choice="asti205"
                     IF cl_auth_chk_act("asti205") THEN 
                        #add-point:ON ACTION asti205
                        CALL cl_cmdrun_wait("asti205")
                        #END add-point
                        
                     END IF
 
               END MENU
               #add-point:ON ACTION detail_qrystr
               
               #END add-point
               EXIT DIALOG
            END IF
 
               
            #add-point:page1自定義行為
            
            #end add-point
               
         END DISPLAY
        
         DISPLAY ARRAY g_stcf2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               CALL astm601_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               
               #add-point:page2, before row動作
               
               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               CALL astm601_idx_chk()
               #add-point:page2自定義行為
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為
            
            #end add-point
         
         END DISPLAY
 
 
         
         #add-point:ui_dialog段自定義display array
          DISPLAY ARRAY g_stcg_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b3) #page1  
    
            BEFORE ROW
               CALL astm601_idx_chk()
               LET l_ac3 = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx3 = l_ac3
               
               #add-point:page1, before row動作

               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx3)
               LET l_ac3 = DIALOG.getCurrentRow("s_detail3")
               CALL astm601_idx_chk()
               LET g_current_page = 3
               
            #自訂ACTION(detail_show,page_1)
            

            #add-point:page1自定義行為
            
            #end add-point
               
         END DISPLAY
         
         DISPLAY ARRAY g_stcw_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               CALL astm601_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx = l_ac
               
               #add-point:page2, before row動作
               
               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_current_page = 4
               CALL astm601_idx_chk()
               #add-point:page2自定義行為
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為
            
            #end add-point
         
         END DISPLAY
         #160513-00033#8--(S)
         DISPLAY ARRAY g_stcl_d TO s_detail5.* ATTRIBUTES(COUNT=g_rec_b5)
    
            BEFORE ROW
               CALL astm601_idx_chk()
               LET l_ac3 = DIALOG.getCurrentRow("s_detail5")
               LET g_detail_idx5 = l_ac5
               
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx5)
               LET l_ac3 = DIALOG.getCurrentRow("s_detail5")
               CALL astm601_idx_chk()
               LET g_current_page = 5
               
               
         END DISPLAY
         #160513-00033#8--(E)
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_page = "first"
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_idx = DIALOG.getCurrentRow("s_browse")
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               LET g_current_idx = g_current_row
            END IF
            LET g_current_row = g_current_idx #目前指標
            IF g_current_idx = 0 THEN
               LET g_current_idx = 1
            END IF
            LET g_current_sw = TRUE
            
            IF g_current_idx > g_browser.getLength() THEN
               LEt g_current_idx = g_browser.getLength()
            END IF 
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL astm601_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL astm601_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL astm601_idx_chk()
            
            #add-point:ui_dialog段before_dialog2
            ##150424-00018#2 150827 by s983961 add(s) 因應需求:一律只能從 申請作業 做新增/刪除/修改  MARK & ADD(E)
            #IF cl_get_para(g_enterprise,g_site,"E-CIR-0021") = 'Y' THEN
            #   CALL cl_set_act_visible("insert,modify,modify_detail,reproduce,delete,statechange", FALSE)
            #END IF         
            ##150424-00018#2 150827 by s983961 add(e) 因應需求:一律只能從 申請作業 做新增/刪除/修改  MARK & ADD(E)
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
                  LET g_export_node[1] = base.typeInfo.create(g_stcf_d)
                  LET g_export_id[1]   = "s_detail1"
             
                  LET g_export_node[2] = base.typeInfo.create(g_stcg_d)
                  LET g_export_id[2]   = "s_detail3"
             
                  LET g_export_node[3] = base.typeInfo.create(g_stcf2_d)
                  LET g_export_id[3]   = "s_detail2"
                  
                  LET g_export_node[4] = base.typeInfo.create(g_stcw_d)
                  LET g_export_id[4]   = "s_detail4"
                  
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
            #end add-point
            
            #NEXT FIELD stcfseq
        
         ON ACTION statechange
            CALL astm601_statechange()
            LET g_action_choice = "statechange"
            EXIT DIALOG
      
         
          
         #ACTION表單列
         ON ACTION filter
            CALL astm601_filter()
            EXIT DIALOG
         
         ON ACTION first
            CALL astm601_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL astm601_idx_chk()
            
         ON ACTION previous
            CALL astm601_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL astm601_idx_chk()
            
         ON ACTION jump
            CALL astm601_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL astm601_idx_chk()
            
         ON ACTION next
            CALL astm601_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL astm601_idx_chk()
            
         ON ACTION last
            CALL astm601_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL astm601_idx_chk()
            
         ON ACTION close
            LET INT_FLAG = FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
      
         ON ACTION mainhidden       #主頁摺疊
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
            END IF
            
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
       
         ON ACTION controls      #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
            IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("worksheet_detail",0)
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("worksheet_detail",1)
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden     
            END IF
    
         
 
         ON ACTION delete
 
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN 
               CALL astm601_delete()
               #add-point:ON ACTION delete
               
               #END add-point
            END IF
 
 
         ON ACTION insert
 
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN 
               CALL astm601_insert()
               #add-point:ON ACTION insert
               
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION modify
 
            LET g_aw = ''
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN 
               CALL astm601_modify()
               #add-point:ON ACTION modify
               
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION modify_detail
 
            LET g_aw = g_curr_diag.getCurrentItem()
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN 
               CALL astm601_modify()
               #add-point:ON ACTION modify_detail
               
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION output
 
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN 
               #add-point:ON ACTION output
               
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION query
 
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN 
               CALL astm601_query()
               #add-point:ON ACTION query
               
               #END add-point
            END IF
 
 
         ON ACTION reproduce
 
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN 
               CALL astm601_reproduce()
               #add-point:ON ACTION reproduce
               
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION prog_stce009
 
            LET g_action_choice="prog_stce009"
            IF cl_auth_chk_act("prog_stce009") THEN 
               CALL cl_cmdrun_wait("adbm200")
               #add-point:ON ACTION prog_stce009
               
               #END add-point
               EXIT DIALOG
            END IF
 
           ON ACTION prog_stce010
 
            LET g_action_choice="prog_stce010"
            IF cl_auth_chk_act("prog_stce010") THEN 
               CALL cl_cmdrun_wait("adbm201")
               #add-point:ON ACTION prog_stce009
               
               #END add-point
               EXIT DIALOG
            END IF
 
         ON ACTION prog_stce004
 
            LET g_action_choice="prog_stce004"
            IF cl_auth_chk_act("prog_stce004") THEN 
               CALL cl_cmdrun_wait("astm201")
               #add-point:ON ACTION prog_stce004
               
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION prog_stce021
 
            LET g_action_choice="prog_stce021"
            IF cl_auth_chk_act("prog_stce021") THEN 
               CALL cl_cmdrun_wait("aooi140")
               #add-point:ON ACTION prog_stce021
               
               #END add-point
               EXIT DIALOG
            END IF
            
          ON ACTION prog_stce022
 
            LET g_action_choice="prog_stce022"
            IF cl_auth_chk_act("prog_stce022") THEN 
               CALL cl_cmdrun_wait("aooi610")
               #add-point:ON ACTION prog_stce021
               
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION prog_stce007
 
            LET g_action_choice="prog_stce007"
            IF cl_auth_chk_act("prog_stce007") THEN 
               CALL cl_cmdrun_wait("aooi610")
               #add-point:ON ACTION prog_stce007

               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION prog_stce006
 
            LET g_action_choice="prog_stce006"
            IF cl_auth_chk_act("prog_stce006") THEN 
               CALL cl_cmdrun_wait("asti201")
               #add-point:ON ACTION prog_stce006
               
               #END add-point
               EXIT DIALOG
            END IF
 
         
         #主選單用ACTION
         &include "main_menu.4gl"
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
 
{<section id="astm601.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION astm601_browser_fill(ps_page_action)
   {<Local define>}
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   {</Local define>}
   #add-point:browser_fill段define
      CALL g_stcg_d.clear()
      CALL g_stcl_d.clear()   #160513-00033#8
   #end add-point    
 
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_stce_m.* TO NULL
   CALL g_stcf_d.clear()        
   CALL g_stcf2_d.clear() 
 
 
   CALL g_browser.clear()
   
   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = '0' THEN
      LET l_searchcol = "stce001"
 
   ELSE
      LET l_searchcol = g_searchcol
   END IF
   
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      RETURN
   END IF
   
   #add-point:browser_fill,foreach前
   LET l_wc = l_wc CLIPPED," AND stce005 IN ('11','12','13') "
   LET g_wc = g_wc CLIPPED," AND stce005 IN ('11','12','13') "
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE stce001 ",
 
                        " FROM stce_t ",
                              " ",
                              " LEFT JOIN stcf_t ON stcfent = stceent AND stce001 = stcf001 ",
                              " LEFT JOIN stch_t ON stchent = stceent AND stce001 = stch001", 
 
 
 
                              " ", 
                              " ", 
                       " WHERE stceent = '" ||g_enterprise|| "' AND stcfent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2
 
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE stce001 ",
 
                        " FROM stce_t ", 
                              " ",
                              " ",
                        "WHERE stceent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED
 
   END IF
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前
      IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE stce001 ",

                        " FROM stce_t ",
                              " ",
                              " LEFT JOIN stcf_t ON stcfent = stceent AND stce001 = stcf001 ",
                               " LEFT JOIN stcg_t ON stcgent = stcfent AND stcf001 = stcg001 AND stcfseq = stcgseq1",
                              " LEFT JOIN stch_t ON stchent = stceent AND stce001 = stch001",
                              " LEFT JOIN stcw_t ON stcwent = stceent AND stce001 = stcw001",                              
                              " LEFT JOIN stcl_t ON stclent = stceent AND stce001 = stcl001",      #160513-00033#8
                              " ", 
                              " ", 
                       " WHERE stceent = '" ||g_enterprise|| "' AND stcfent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2 CLIPPED,cl_sql_add_filter("stce_t")  #161214-00032#1 add  CLIPPED,cl_sql_add_filter("stce_t") 
 
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE stce001 ",

                        " FROM stce_t ", 
                              " ",
                              " ",
                        "WHERE stceent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED,cl_sql_add_filter("stce_t")  #161214-00032#1 add ,cl_sql_add_filter("stce_t") 
 
   END IF
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
   #end add-point
   
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
   FREE header_cnt_pre
 
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
   
   #LET g_page_action = ps_page_action          # Keep Action
   
   IF ps_page_action = "F" OR
      ps_page_action = "P" OR
      ps_page_action = "N" OR
      ps_page_action = "L" THEN
      LET g_page_action = ps_page_action
   END IF
   
   CASE ps_page_action
      WHEN "F" 
         LET g_pagestart = 1
          
      WHEN "P"  
         LET g_pagestart = g_pagestart - g_max_browse
         IF g_pagestart < 1 THEN
            LET g_pagestart = 1
         END IF
          
      WHEN "N"  
         LET g_pagestart = g_pagestart + g_max_browse
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = g_browser_cnt - (g_browser_cnt mod g_max_browse) + 1
            WHILE g_pagestart > g_browser_cnt 
               LET g_pagestart = g_pagestart - g_max_browse
            END WHILE
         END IF
      
      WHEN "L"  
         LET g_pagestart = g_browser_cnt - (g_browser_cnt mod g_max_browse) + 1
         WHILE g_pagestart > g_browser_cnt 
            LET g_pagestart = g_pagestart - g_max_browse
         END WHILE
         
      WHEN '/'
         LET g_pagestart = g_jump
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = 1
         END IF
         
   END CASE
  
   #單身有輸入查詢條件且非null
   IF g_wc2 <> " 1=1" AND NOT cl_null(g_wc2) THEN 
      #依照stce001,stce005,stce002,stce004,stce009,stce021,stce022,stce023,stce006,stce007,stce026,stce013,stce014,stce015,stce024,stce025,stce017,stce018,stce019,stce020,stce003,stceunit Browser欄位定義(取代原本bs_sql功能)
      LET l_sql_rank = "SELECT DISTINCT stcestus,stce001,stce005,stce002,stce004,stce009,stce021,stce022, 
          stce023,stce006,stce007,stce026,stce013,stce014,stce015,stce024,stce025,stce017,stce018,stce019, 
          stce020,stce003,stceunit,DENSE_RANK() OVER(ORDER BY stce001 ",g_order,") AS RANK ",
                        " FROM stce_t ",
                              " ",
                              " LEFT JOIN stcf_t ON stcfent = stceent AND stce001 = stcf001 ",
                              " LEFT JOIN stch_t ON stchent = stceent AND stce001 = stch001",
 
 
 
                              " ",
                              " ",
                       " ",
                       " WHERE stceent = '" ||g_enterprise|| "' AND ",g_wc," AND ",g_wc2
   ELSE
      #單身無輸入資料
      LET l_sql_rank = "SELECT DISTINCT stcestus,stce001,stce005,stce002,stce004,stce009,stce021,stce022, 
          stce023,stce006,stce007,stce026,stce013,stce014,stce015,stce024,stce025,stce017,stce018,stce019, 
          stce020,stce003,stceunit,DENSE_RANK() OVER(ORDER BY stce001 ",g_order,") AS RANK ",
                       " FROM stce_t ",
                            "  ",
                            "  ",
                       " WHERE stceent = '" ||g_enterprise|| "' AND ", g_wc
   END IF
   
   #定義翻頁CURSOR
   LET g_sql= "SELECT stcestus,stce001,stce005,stce002,stce004,stce009,stce021,stce022,stce023,stce006, 
       stce007,stce026,stce013,stce014,stce015,stce024,stce025,stce017,stce018,stce019,stce020,stce003, 
       stceunit FROM (",l_sql_rank,") WHERE ",
              " RANK >= ",1," AND RANK<",1+g_max_browse,
              " ORDER BY ",l_searchcol," ",g_order
               
   #add-point:browser_fill,before_prepare
      IF g_wc2 <> " 1=1" AND NOT cl_null(g_wc2) THEN 
      #依照stce001,stce005,stce002,stce004,stce009,stce021,stce022,stce023,stce006,stce007,stce026,stce013,stce014,stce015,stce024,stce025,stce017,stce018,stce019,stce020,stce003,stceunit Browser欄位定義(取代原本bs_sql功能)
      LET l_sql_rank = "SELECT DISTINCT stcestus,stce001,stce005,stce002,stce004,stce009,stce021,stce022,stce023,stce006,stce007,stce026,stce013,stce014,stce015,stce024,stce025,stce017,stce018,stce019,stce020,stce003,stceunit,DENSE_RANK() OVER(ORDER BY stce001 ",g_order,") AS RANK ",
                        " FROM stce_t ",
                              " ",
                              " LEFT JOIN stcf_t ON stcfent = stceent AND stce001 = stcf001 ",
                              " LEFT JOIN stcg_t ON stcgent = stcfent AND stcf001 = stcg001 AND stcfseq = stcgseq1",
                              " LEFT JOIN stch_t ON stchent = stceent AND stce001 = stch001",
                              " LEFT JOIN stcw_t ON stcwent = stceent AND stce001 = stcw001",
                              " LEFT JOIN stcl_t ON stclent = stceent AND stce001 = stcl001",      #160513-00033#8
                              " ",
                              " ",
                       " ",
                       " WHERE stceent = '" ||g_enterprise|| "' AND ",g_wc," AND ",g_wc2 CLIPPED,cl_sql_add_filter("stce_t")  #161214-00032#1 add ,cl_sql_add_filter("stce_t") 
   ELSE
      #單身無輸入資料
      LET l_sql_rank = "SELECT DISTINCT stcestus,stce001,stce005,stce002,stce004,stce009,stce021,stce022,stce023,stce006,stce007,stce026,stce013,stce014,stce015,stce024,stce025,stce017,stce018,stce019,stce020,stce003,stceunit,DENSE_RANK() OVER(ORDER BY stce001 ",g_order,") AS RANK ",
                       " FROM stce_t ",
                            "  ",
                            "  ",
                       " WHERE stceent = '" ||g_enterprise|| "' AND ", g_wc CLIPPED,cl_sql_add_filter("stce_t")  #161214-00032#1 add ,cl_sql_add_filter("stce_t") 
   END IF
   
   #定義翻頁CURSOR
   LET g_sql= "SELECT stcestus,stce001,stce005,stce002,stce004,stce009,stce021,stce022,stce023,stce006,stce007,stce026,stce013,stce014,stce015,stce024,stce025,stce017,stce018,stce019,stce020,stce003,stceunit FROM (",l_sql_rank,") WHERE ",
              " RANK >= ",1," AND RANK<",1+g_max_browse,
              " ORDER BY ",l_searchcol," ",g_order 
   #end add-point
               
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
   
   #add-point:browser_fill,open
   
   #end add-point
 
   CALL g_browser.clear()
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_stce001,g_browser[g_cnt].b_stce005, 
       g_browser[g_cnt].b_stce002,g_browser[g_cnt].b_stce004,g_browser[g_cnt].b_stce009,g_browser[g_cnt].b_stce021, 
       g_browser[g_cnt].b_stce007,g_browser[g_cnt].b_stce023,g_browser[g_cnt].b_stce006,g_browser[g_cnt].b_stce007, 
       g_browser[g_cnt].b_stce026,g_browser[g_cnt].b_stce013,g_browser[g_cnt].b_stce014,g_browser[g_cnt].b_stce015, 
       g_browser[g_cnt].b_stce024,g_browser[g_cnt].b_stce025,g_browser[g_cnt].b_stce017,g_browser[g_cnt].b_stce018, 
       g_browser[g_cnt].b_stce019,g_browser[g_cnt].b_stce020,g_browser[g_cnt].b_stce003,g_browser[g_cnt].b_stceunit 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         EXIT FOREACH
      END IF
  
      
  
      #add-point:browser_fill段reference
      
      #end add-point
  
            #此段落由子樣板a24產生
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/open.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/void.png"
 
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/valid.png"
 
 
         
      END CASE
 
 
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9035
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
   END FOREACH
 
   CALL g_browser.deleteElement(g_cnt)
   LET g_header_cnt = g_browser.getLength()
 
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   FREE browse_pre
   
   #add-point:browser_fill段結束前
   
   #end add-point
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
   ELSE
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   END IF
   
END FUNCTION
 
{</section>}
 
{<section id="astm601.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION astm601_ui_headershow()
   #add-point:ui_headershow段define
   
   #end add-point    
   
   LET g_stce_m.stce001 = g_browser[g_current_idx].b_stce001   
 
    SELECT UNIQUE stce005,stce001,stce002,stce003,stce009,stce010,stce011,stce012,stce004,stceunit,stcesite,stce027,stce021,stce022,stce023,stce006, 
        stce007,stce024,stce028,stce025,stce026,stce013,stce014,stce015,stce016,stce017,stce018,stce019,stce020,stcestus, 
        stceownid,stceowndp,stcecrtid,stcecrtdp,stcecrtdt,stcemodid,stcemoddt,stcecnfid,stcecnfdt
 INTO g_stce_m.stce005,g_stce_m.stce001,g_stce_m.stce002,g_stce_m.stce003,g_stce_m.stce009,g_stce_m.stce010,g_stce_m.stce011,g_stce_m.stce012,g_stce_m.stce004, 
     g_stce_m.stceunit, g_stce_m.stcesite,g_stce_m.stce027,g_stce_m.stce021,g_stce_m.stce022,g_stce_m.stce023,g_stce_m.stce006,g_stce_m.stce007, 
     g_stce_m.stce024,g_stce_m.stce028,g_stce_m.stce025,g_stce_m.stce026,g_stce_m.stce013,g_stce_m.stce014,g_stce_m.stce015,g_stce_m.stce016, 
     g_stce_m.stce017,g_stce_m.stce018,g_stce_m.stce019,g_stce_m.stce020,g_stce_m.stcestus,g_stce_m.stceownid, 
     g_stce_m.stceowndp,g_stce_m.stcecrtid,g_stce_m.stcecrtdp,g_stce_m.stcecrtdt,g_stce_m.stcemodid, 
     g_stce_m.stcemoddt,g_stce_m.stcecnfid,g_stce_m.stcecnfdt
 FROM stce_t
 WHERE stceent = g_enterprise AND stce001 = g_stce_m.stce001
   CALL astm601_show()
   
END FUNCTION
 
{</section>}
 
{<section id="astm601.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION astm601_ui_detailshow()
   #add-point:ui_detailshow段define
   
   #end add-point    
   
   #add-point:ui_detailshow段before
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
 
   END IF
   
   #add-point:ui_detailshow段after
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="astm601.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION astm601_ui_browser_refresh()
   {<Local define>}
   DEFINE l_i  LIKE type_t.num10
   {</Local define>}
   #add-point:ui_browser_refresh段define
   
   #end add-point    
   
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_stce001 = g_stce_m.stce001 
 
         THEN  
         CALL g_browser.deleteElement(l_i)
         LET g_header_cnt = g_header_cnt - 1
      END IF
   END FOR
 
   LET g_browser_cnt = g_browser_cnt - 1
   IF g_current_row > g_browser_cnt THEN        #確定browse 筆數指在同一筆
      LET g_current_row = g_browser_cnt
   END IF
 
   #DISPLAY g_browser_cnt TO FORMONLY.b_count    #總筆數的顯示
   
END FUNCTION
 
{</section>}
 
{<section id="astm601.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION astm601_construct()
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define
   DEFINE  l_sys                 LIKE type_t.num5 
 
   #end add-point    
 
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_stce_m.* TO NULL
   CALL g_stcf_d.clear()        
   CALL g_stcf2_d.clear() 
 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前
   CALL g_stcg_d.clear()
   CALL g_stcl_d.clear()   #160513-00033#8   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON stceunit,stce001,stce002,stce003,stce009,stce010,stce011,stce012,stce004,stce005,stce027,stce021,stce022, 
          stce023,stce006,stce007,stce024,stce028,stce025,stce026,stce013,stce014,stce015,stce016,stce017,stce018,stce019, 
          stce020,stcestus,stceownid,stceowndp,stcecrtid,stcecrtdp,stcecrtdt,stcemodid,stcemoddt,stcecnfid, 
          stcecnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #此段落由子樣板a11產生
         ##----<<stceownid>>----
         #ON ACTION controlp INFIELD stceownid
         #   CALL q_common('stce_t','stceownid',TRUE,FALSE,g_stce_m.stceownid) RETURNING ls_return
         #   DISPLAY ls_return TO stceownid
         #   NEXT FIELD stceownid  
         #
         ##----<<stceowndp>>----
         #ON ACTION controlp INFIELD stceowndp
         #   CALL q_common('stce_t','stceowndp',TRUE,FALSE,g_stce_m.stceowndp) RETURNING ls_return
         #   DISPLAY ls_return TO stceowndp
         #   NEXT FIELD stceowndp
         #
         ##----<<stcecrtid>>----
         #ON ACTION controlp INFIELD stcecrtid
         #   CALL q_common('stce_t','stcecrtid',TRUE,FALSE,g_stce_m.stcecrtid) RETURNING ls_return
         #   DISPLAY ls_return TO stcecrtid
         #   NEXT FIELD stcecrtid
         #
         ##----<<stcecrtdp>>----
         #ON ACTION controlp INFIELD stcecrtdp
         #   CALL q_common('stce_t','stcecrtdp',TRUE,FALSE,g_stce_m.stcecrtdp) RETURNING ls_return
         #   DISPLAY ls_return TO stcecrtdp
         #   NEXT FIELD stcecrtdp
         #
         ##----<<stcemodid>>----
         #ON ACTION controlp INFIELD stcemodid
         #   CALL q_common('stce_t','stcemodid',TRUE,FALSE,g_stce_m.stcemodid) RETURNING ls_return
         #   DISPLAY ls_return TO stcemodid
         #   NEXT FIELD stcemodid
         #
         ##----<<stcecnfid>>----
         #ON ACTION controlp INFIELD stcecnfid
         #   CALL q_common('stce_t','stcecnfid',TRUE,FALSE,g_stce_m.stcecnfid) RETURNING ls_return
         #   DISPLAY ls_return TO stcecnfid
         #   NEXT FIELD stcecnfid
         #
         ##----<<stanpstid>>----
         ##ON ACTION controlp INFIELD stanpstid
         ##   CALL q_common('stce_t','stanpstid',TRUE,FALSE,g_stce_m.stanpstid) RETURNING ls_return
         ##   DISPLAY ls_return TO stanpstid
         ##   NEXT FIELD stanpstid
         
         ##----<<stcecrtdt>>----
         AFTER FIELD stcecrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<stcemoddt>>----
         AFTER FIELD stcemoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<stcecnfdt>>----
         AFTER FIELD stcecnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<stanpstdt>>----
         #AFTER FIELD stanpstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
            
         #一般欄位開窗相關處理    
         #---------------------------<  Master  >---------------------------
         #----<<stceunit>>----
         #Ctrlp:construct.c.stceunit
         ON ACTION controlp INFIELD stceunit
            #add-point:ON ACTION controlp INFIELD stceunit
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
#			  LET g_qryparam.where = "ooef201 = 'Y'"
#            CALL q_ooef001()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'stceunit',g_site,'c')
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO stceunit  #顯示到畫面上

            NEXT FIELD stceunit                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stceunit
            #add-point:BEFORE FIELD stceunit
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stceunit
            
            #add-point:AFTER FIELD stceunit
            
            #END add-point
            
 
         #----<<stce005>>----
         #此段落由子樣板a01產生
      #  BEFORE FIELD stce005
      #     #add-point:BEFORE FIELD stce005
            
      #     #END add-point
      #
      #  #此段落由子樣板a02產生
      #  AFTER FIELD stce005
      #     
      #     #add-point:AFTER FIELD stce005
            
      #     #END add-point
      #     
      #
      #  #Ctrlp:construct.c.stce005
      #  ON ACTION controlp INFIELD stce005
      #     #add-point:ON ACTION controlp INFIELD stce005
            
      #     #END add-point
 
         #----<<stce001>>----
         #Ctrlp:construct.c.stce001
         ON ACTION controlp INFIELD stce001
            #add-point:ON ACTION controlp INFIELD stce001
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_stce001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stce001  #顯示到畫面上

            NEXT FIELD stce001                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stce001
            #add-point:BEFORE FIELD stce001
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stce001
            
            #add-point:AFTER FIELD stce001
            
            #END add-point
            
 
         #----<<stce002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stce002
            #add-point:BEFORE FIELD stce002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stce002
            
            #add-point:AFTER FIELD stce002
            
            #END add-point
            
 
         #Ctrlp:construct.c.stce002
         ON ACTION controlp INFIELD stce002
            #add-point:ON ACTION controlp INFIELD stce002
            
            #END add-point
 
         #----<<stce003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stce003
            #add-point:BEFORE FIELD stce003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stce003
            
            #add-point:AFTER FIELD stce003
            
            #END add-point
            
 
         #Ctrlp:construct.c.stce003
         ON ACTION controlp INFIELD stce003
            #add-point:ON ACTION controlp INFIELD stce003
            
            #END add-point
 
         #----<<stce009>>----
         #Ctrlp:construct.c.stce009
         ON ACTION controlp INFIELD stce009
            #add-point:ON ACTION controlp INFIELD stce009
                        #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c'
		      LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_21()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stce009  #顯示到畫面上

            NEXT FIELD stce009                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stce009
            #add-point:BEFORE FIELD stce009
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stce009
            
            #add-point:AFTER FIELD stce009
            
            #END add-point
            
          #----<<stce009>>----
         #Ctrlp:construct.c.stce010
         ON ACTION controlp INFIELD stce010
            #add-point:ON ACTION controlp INFIELD stce010
                        #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c'
		      LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_18()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stce010  #顯示到畫面上
 
            NEXT FIELD stce010                     #返回原欄位
 
 
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stce010
            #add-point:BEFORE FIELD stce009
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stce010
            
            #add-point:AFTER FIELD stce010
            
            #END add-point
            
         ON ACTION controlp INFIELD stce011
            #add-point:ON ACTION controlp INFIELD stce011
                        #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		      LET g_qryparam.reqry = FALSE
		      LET g_qryparam.arg1 = '281'
            CALL q_oocq002()                            #呼叫開窗
            DISPLAY g_qryparam.return1 TO stce011  #顯示到畫面上
 
            NEXT FIELD stce011                     #返回原欄位
 
         ON ACTION controlp INFIELD stce012
            #add-point:ON ACTION controlp INFIELD stce011
                        #此段落由子樣板a08產生
            #開窗c段
			  # INITIALIZE g_qryparam.* TO NULL
           #  LET g_qryparam.state = 'c'
		     # LET g_qryparam.reqry = FALSE
		     # LET g_qryparam.arg1 = '2035'
           # CALL q_oocq002()                           #呼叫開窗
           # DISPLAY g_qryparam.return1 TO stce012  #顯示到畫面上
           #
           # NEXT FIELD stce012                     #返回原欄位
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "1"
            CALL q_oojd001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stce012  #顯示到畫面上
 
            NEXT FIELD stce012                    #返回原欄位  
 
         #----<<stce004>>----
         #Ctrlp:construct.c.stce004
         ON ACTION controlp INFIELD stce004
            #add-point:ON ACTION controlp INFIELD stce004
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	         LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " stag002 IN ('11','12','13')"
            CALL q_stag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stce004  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO stagl003 #說明 

            NEXT FIELD stce004                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stce004
            #add-point:BEFORE FIELD stce004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stce004
            
            #add-point:AFTER FIELD stce004
            
            
            
        ON ACTION controlp INFIELD stce027

		     INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'c'
			  LET g_qryparam.reqry = FALSE
            CALL q_stce001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stce027  #顯示到畫面上

            NEXT FIELD stce027                     #返回原欄位

            #END add-point
            
 
         #----<<stce021>>----
         #Ctrlp:construct.c.stce021
         ON ACTION controlp INFIELD stce021
            #add-point:ON ACTION controlp INFIELD stce021
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stce021  #顯示到畫面上

            NEXT FIELD stce021                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stce021
            #add-point:BEFORE FIELD stce021
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stce021
            
            #add-point:AFTER FIELD stce021
            
            #END add-point
            
 
         #----<<stce0227>>----
         #Ctrlp:construct.c.stce022
         ON ACTION controlp INFIELD stce022
            #add-point:ON ACTION controlp INFIELD stce022
               #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = g_site #
            CALL q_oodb002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stce022  #顯示到畫面上

            NEXT FIELD stce022                     #返回原欄位
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stce022
            #add-point:BEFORE FIELD stce022

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stce022
            
            #add-point:AFTER FIELD stce022

            #END add-point
            
 
         #----<<stce023>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stce023
            #add-point:BEFORE FIELD stce023
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stce023
            
            #add-point:AFTER FIELD stce023
            
            #END add-point
            
 
         #Ctrlp:construct.c.stce023
         ON ACTION controlp INFIELD stce023
            #add-point:ON ACTION controlp INFIELD stce023
               #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		      LET g_qryparam.reqry = FALSE
            CALL q_ooib002_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stce023  #顯示到畫面上

            NEXT FIELD stce023                    #返回原欄位 
            #END add-point
 
         #----<<stce006>>----
         #Ctrlp:construct.c.stce006
         ON ACTION controlp INFIELD stce006
            #add-point:ON ACTION controlp INFIELD stce006
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_staa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stce006  #顯示到畫面上

            NEXT FIELD stce006                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stce006
            #add-point:BEFORE FIELD stce006
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stce006
            
            #add-point:AFTER FIELD stce006
            
            #END add-point
            
 
         #----<<stce007>>----
         #Ctrlp:construct.c.stce007
         ON ACTION controlp INFIELD stce007
            #add-point:ON ACTION controlp INFIELD stce007
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = "2060"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stce007  #顯示到畫面上

            NEXT FIELD stce007                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stce007
            #add-point:BEFORE FIELD stce007
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stce007
            
            #add-point:AFTER FIELD stce007
            
            #END add-point
            
 
         #----<<stce024>>----
         #Ctrlp:construct.c.stce024
         ON ACTION controlp INFIELD stce024
            #add-point:ON ACTION controlp INFIELD stce024
                        #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   #LET g_qryparam.arg1 ='A' 
#			   LET g_qryparam.where = "ooef212 = 'Y'"
#            CALL q_ooef001()                     #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'stce024') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stce024',g_site,'c')
               CALL q_ooef001_24() 
            ELSE
               LET g_qryparam.where = "ooef212 = 'Y'"
               CALL q_ooef001() 
            END IF
            DISPLAY g_qryparam.return1 TO stce024  #顯示到畫面上

            NEXT FIELD stce024                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stce024
            #add-point:BEFORE FIELD stce024
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stce024
            
            #add-point:AFTER FIELD stce024
          


         ON ACTION controlp INFIELD stce028
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE

	         CALL q_dbbc001()                      #呼叫開窗
            DISPLAY g_qryparam.return1 TO stce028  #顯示到畫面上

            NEXT FIELD stce028                     #返回原欄位

            #END add-point
            
 
         #----<<stce025>>----
         #Ctrlp:construct.c.stce025
         ON ACTION controlp INFIELD stce025
            #add-point:ON ACTION controlp INFIELD stce025
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			#LET g_qryparam.arg1 = '2'
#			LET g_qryparam.where = "ooef208 = 'Y'"
#			CALL q_ooef001()                      #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'stce025') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stce025',g_site,'c')
               CALL q_ooef001_24() 
            ELSE
               LET g_qryparam.where = "ooef208 = 'Y'"
               CALL q_ooef001() 
            END IF
            DISPLAY g_qryparam.return1 TO stce025  #顯示到畫面上

            NEXT FIELD stce025                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stce025
            #add-point:BEFORE FIELD stce025
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stce025
            
            #add-point:AFTER FIELD stce025
            
            #END add-point
            
 
         #----<<stce026>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stce026
            #add-point:BEFORE FIELD stce026
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stce026
            
            #add-point:AFTER FIELD stce026
            
            #END add-point
            
 
         #Ctrlp:construct.c.stce026
         ON ACTION controlp INFIELD stce026
            #add-point:ON ACTION controlp INFIELD stce026
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
		      #LET g_qryparam.arg1 = '2'
#		      LET g_qryparam.where = "ooef208 = 'Y'"
#			   CALL q_ooef001()                      #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'stce026') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stce026',g_site,'c')
               CALL q_ooef001_24() 
            ELSE
               #LET g_qryparam.where = "ooef208 = 'Y'"      #161024-00025#2 mark
               LET g_qryparam.where = "ooef201 = 'Y'"       #161024-00025#2 add
               CALL q_ooef001() 
            END IF
            DISPLAY g_qryparam.return1 TO stce026  #顯示到畫面上

            NEXT FIELD stce026                     #返回原欄位
            #END add-point
 
         #----<<stce013>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stce013
            #add-point:BEFORE FIELD stce013
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stce013
            
            #add-point:AFTER FIELD stce013
            
            #END add-point
            
 
         #Ctrlp:construct.c.stce013
         ON ACTION controlp INFIELD stce013
            #add-point:ON ACTION controlp INFIELD stce013
            
            #END add-point
 
         #----<<stce014>>----
         #Ctrlp:construct.c.stce014
         ON ACTION controlp INFIELD stce014
            #add-point:ON ACTION controlp INFIELD stce014
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			#LET g_qryparam.arg1 = '1'
#			 LET g_qryparam.where = "ooef003 = 'Y'"
#            CALL q_ooef001()                           #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'stce014') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stce014',g_site,'c')
               CALL q_ooef001_24() 
            ELSE
               LET g_qryparam.where = "ooef003 = 'Y'"
               CALL q_ooef001() 
            END IF
            DISPLAY g_qryparam.return1 TO stce014  #顯示到畫面上

            NEXT FIELD stce014                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stce014
            #add-point:BEFORE FIELD stce014
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stce014
            
            #add-point:AFTER FIELD stce014
            
            #END add-point
            
 
         #----<<stce015>>----
         #Ctrlp:construct.c.stce015
         ON ACTION controlp INFIELD stce015
            #add-point:ON ACTION controlp INFIELD stce015
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stce015  #顯示到畫面上

            NEXT FIELD stce015                     #返回原欄位



          ON ACTION controlp INFIELD stce016
		      INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		      LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stce016  #顯示到畫面上

            NEXT FIELD stce016                   #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stce015
            #add-point:BEFORE FIELD stce015
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stce015
            
            #add-point:AFTER FIELD stce015
            
            #END add-point
            
 
         #----<<stce017>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stce017
            #add-point:BEFORE FIELD stce017
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stce017
            
            #add-point:AFTER FIELD stce017
            
            #END add-point
            
 
         #Ctrlp:construct.c.stce017
         ON ACTION controlp INFIELD stce017
            #add-point:ON ACTION controlp INFIELD stce017
            
            #END add-point
 
         #----<<stce018>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stce018
            #add-point:BEFORE FIELD stce018
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stce018
            
            #add-point:AFTER FIELD stce018
            
            #END add-point
            
 
         #Ctrlp:construct.c.stce018
         ON ACTION controlp INFIELD stce018
            #add-point:ON ACTION controlp INFIELD stce018
            
            #END add-point
 
         #----<<stce019>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stce019
            #add-point:BEFORE FIELD stce019
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stce019
            
            #add-point:AFTER FIELD stce019
            
            #END add-point
            
 
         #Ctrlp:construct.c.stce019
         ON ACTION controlp INFIELD stce019
            #add-point:ON ACTION controlp INFIELD stce019
            
            #END add-point
 
         #----<<stce020>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stce020
            #add-point:BEFORE FIELD stce020
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stce020
            
            #add-point:AFTER FIELD stce020
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
            #END add-point
            
 
         #Ctrlp:construct.c.stce020
         ON ACTION controlp INFIELD stce020
            #add-point:ON ACTION controlp INFIELD stce020
            
            #END add-point
 
         #----<<stcestus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcestus
            #add-point:BEFORE FIELD stcestus
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcestus
            
            #add-point:AFTER FIELD stcestus
            
            #END add-point
            
 
         #Ctrlp:construct.c.stcestus
         ON ACTION controlp INFIELD stcestus
            #add-point:ON ACTION controlp INFIELD stcestus
            
            #END add-point
 
         #----<<stceownid>>----
         #Ctrlp:construct.c.stceownid
         ON ACTION controlp INFIELD stceownid
            #add-point:ON ACTION controlp INFIELD stceownid
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stceownid  #顯示到畫面上

            NEXT FIELD stceownid                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stceownid
            #add-point:BEFORE FIELD stceownid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stceownid
            
            #add-point:AFTER FIELD stceownid
            
            #END add-point
            
 
         #----<<stceowndp>>----
         #Ctrlp:construct.c.stceowndp
         ON ACTION controlp INFIELD stceowndp
            #add-point:ON ACTION controlp INFIELD stceowndp
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stceowndp  #顯示到畫面上

            NEXT FIELD stceowndp                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stceowndp
            #add-point:BEFORE FIELD stceowndp
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stceowndp
            
            #add-point:AFTER FIELD stceowndp
            
            #END add-point
            
 
         #----<<stcecrtid>>----
         #Ctrlp:construct.c.stcecrtid
         ON ACTION controlp INFIELD stcecrtid
            #add-point:ON ACTION controlp INFIELD stcecrtid
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stcecrtid  #顯示到畫面上

            NEXT FIELD stcecrtid                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stcecrtid
            #add-point:BEFORE FIELD stcecrtid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcecrtid
            
            #add-point:AFTER FIELD stcecrtid
            
            #END add-point
            
 
         #----<<stcecrtdp>>----
         #Ctrlp:construct.c.stcecrtdp
         ON ACTION controlp INFIELD stcecrtdp
            #add-point:ON ACTION controlp INFIELD stcecrtdp
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stcecrtdp  #顯示到畫面上

            NEXT FIELD stcecrtdp                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stcecrtdp
            #add-point:BEFORE FIELD stcecrtdp
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcecrtdp
            
            #add-point:AFTER FIELD stcecrtdp
            
            #END add-point
            
 
         #----<<stcecrtdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcecrtdt
            #add-point:BEFORE FIELD stcecrtdt
            
            #END add-point
 
         #----<<stcemodid>>----
         #Ctrlp:construct.c.stcemodid
         ON ACTION controlp INFIELD stcemodid
            #add-point:ON ACTION controlp INFIELD stcemodid
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stcemodid  #顯示到畫面上

            NEXT FIELD stcemodid                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stcemodid
            #add-point:BEFORE FIELD stcemodid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcemodid
            
            #add-point:AFTER FIELD stcemodid
            
            #END add-point
            
 
         #----<<stcemoddt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcemoddt
            #add-point:BEFORE FIELD stcemoddt
            
            #END add-point
 
         #----<<stcecnfid>>----
         #Ctrlp:construct.c.stcecnfid
         ON ACTION controlp INFIELD stcecnfid
            #add-point:ON ACTION controlp INFIELD stcecnfid
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stcecnfid  #顯示到畫面上

            NEXT FIELD stcecnfid                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stcecnfid
            #add-point:BEFORE FIELD stcecnfid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcecnfid
            
            #add-point:AFTER FIELD stcecnfid
            
            #END add-point
            
 
         #----<<stcecnfdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcecnfdt
            #add-point:BEFORE FIELD stcecnfdt
            
            #END add-point
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON stcfseq,stcf002,stcf021,stcf003,stcf004,stcf005,stcf006,stcf007,stcf008,stcf009, 
          stcf010,stcf011,stcf012,stcf013,stcf014,stcf015,stcf016,stcf017,stcf018,stcf019,stcf020
           FROM s_detail1[1].stcfseq,s_detail1[1].stcf002,s_detail1[1].stcf021,s_detail1[1].stcf003,s_detail1[1].stcf004, 
               s_detail1[1].stcf005,s_detail1[1].stcf006,s_detail1[1].stcf007,s_detail1[1].stcf008,s_detail1[1].stcf009, 
               s_detail1[1].stcf010,s_detail1[1].stcf011,s_detail1[1].stcf012,s_detail1[1].stcf013,s_detail1[1].stcf014, 
               s_detail1[1].stcf015,s_detail1[1].stcf016,s_detail1[1].stcf017,s_detail1[1].stcf018,s_detail1[1].stcf019,s_detail1[1].stcf020
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
       #---------------------<  Detail: page1  >---------------------
         #----<<stcfseq>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcfseq
            #add-point:BEFORE FIELD stcfseq
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcfseq
            
            #add-point:AFTER FIELD stcfseq
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.stcfseq
         ON ACTION controlp INFIELD stcfseq
            #add-point:ON ACTION controlp INFIELD stcfseq
            
            #END add-point
 
         #----<<stcf002>>----
         #Ctrlp:construct.c.page1.stcf002
         ON ACTION controlp INFIELD stcf002
            #add-point:ON ACTION controlp INFIELD stcf002
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_stae001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stcf002  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO stael003 #說明 
               #DISPLAY g_qryparam.return3 TO stae001 #費用編號 

            NEXT FIELD stcf002                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stcf002
            #add-point:BEFORE FIELD stcf002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcf002
            
            #add-point:AFTER FIELD stcf002
            
            #END add-point
            
 
         #----<<stcf003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcf003
            #add-point:BEFORE FIELD stcf003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcf003
            
            #add-point:AFTER FIELD stcf003
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.stcf003
         ON ACTION controlp INFIELD stcf003
            #add-point:ON ACTION controlp INFIELD stcf003
            
            #END add-point
 
         #----<<stcf004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcf004
            #add-point:BEFORE FIELD stcf004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcf004
            
            #add-point:AFTER FIELD stcf004
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.stcf004
         ON ACTION controlp INFIELD stcf004
            #add-point:ON ACTION controlp INFIELD stcf004
            
            #END add-point
 
         #----<<stcf005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcf005
            #add-point:BEFORE FIELD stcf005
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcf005
            
            #add-point:AFTER FIELD stcf005
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.stcf005
         ON ACTION controlp INFIELD stcf005
            #add-point:ON ACTION controlp INFIELD stcf005
            
            #END add-point
 
         #----<<stcf006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcf006
            #add-point:BEFORE FIELD stcf006
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcf006
            
            #add-point:AFTER FIELD stcf006
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.stcf006
         ON ACTION controlp INFIELD stcf006
            #add-point:ON ACTION controlp INFIELD stcf006
            
            #END add-point
 
         #----<<stcf007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcf007
            #add-point:BEFORE FIELD stcf007
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcf007
            
            #add-point:AFTER FIELD stcf007
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.stcf007
         ON ACTION controlp INFIELD stcf007
            #add-point:ON ACTION controlp INFIELD stcf007
            
            #END add-point
 
         #----<<stcf008>>----
         #Ctrlp:construct.c.page1.stcf008
         ON ACTION controlp INFIELD stcf008
            #add-point:ON ACTION controlp INFIELD stcf008
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
             LET g_qryparam.arg1 = g_stce_m.stce005
            LET g_qryparam.arg2 = g_stce_m.stce007
            CALL q_stab001_3()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO stcf008  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO stabl003 #說明 
               #DISPLAY g_qryparam.return3 TO stabl004 #助記碼 

            NEXT FIELD stcf008                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stcf008
            #add-point:BEFORE FIELD stcf008
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcf008
            
            #add-point:AFTER FIELD stcf008
            
            #END add-point
            
 
         #----<<stcf009>>----
         #Ctrlp:construct.c.page1.stcf009
         ON ACTION controlp INFIELD stcf009
            #add-point:ON ACTION controlp INFIELD stcf009
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_stce_m.stce005
            LET g_qryparam.arg2 = g_stce_m.stce007
            CALL q_stab001_3()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO stcf009  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO stabl003 #說明 
               #DISPLAY g_qryparam.return3 TO stabl004 #助記碼 

            NEXT FIELD stcf009                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stcf009
            #add-point:BEFORE FIELD stcf009
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcf009
            
            #add-point:AFTER FIELD stcf009
            
            #END add-point
            
 
         #----<<stcf010>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcf010
            #add-point:BEFORE FIELD stcf010
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcf010
            
            #add-point:AFTER FIELD stcf010
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.stcf010
         ON ACTION controlp INFIELD stcf010
            #add-point:ON ACTION controlp INFIELD stcf010
            
            #END add-point
 
         #----<<stcf011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcf011
            #add-point:BEFORE FIELD stcf011
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcf011
            
            #add-point:AFTER FIELD stcf011
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.stcf011
         ON ACTION controlp INFIELD stcf011
            #add-point:ON ACTION controlp INFIELD stcf011
            
            #END add-point
 
         #----<<stcf012>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcf012
            #add-point:BEFORE FIELD stcf012
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcf012
            
            #add-point:AFTER FIELD stcf012
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.stcf012
         ON ACTION controlp INFIELD stcf012
            #add-point:ON ACTION controlp INFIELD stcf012
            
            #END add-point
 
         #----<<stcf013>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcf013
            #add-point:BEFORE FIELD stcf013
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcf013
            
            #add-point:AFTER FIELD stcf013
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.stcf013
         ON ACTION controlp INFIELD stcf013
            #add-point:ON ACTION controlp INFIELD stcf013
            
            #END add-point
 
         #----<<stcf014>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcf014
            #add-point:BEFORE FIELD stcf014
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcf014
            
            #add-point:AFTER FIELD stcf014
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.stcf014
         ON ACTION controlp INFIELD stcf014
            #add-point:ON ACTION controlp INFIELD stcf014
            
            #END add-point
 
         #----<<stcf015>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcf015
            #add-point:BEFORE FIELD stcf015
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcf015
            
            #add-point:AFTER FIELD stcf015
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.stcf015
         ON ACTION controlp INFIELD stcf015
            #add-point:ON ACTION controlp INFIELD stcf015
            
            #END add-point
 
         #----<<stcf016>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcf016
            #add-point:BEFORE FIELD stcf016
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcf016
            
            #add-point:AFTER FIELD stcf016
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.stcf016
         ON ACTION controlp INFIELD stcf016
            #add-point:ON ACTION controlp INFIELD stcf016
            
            #END add-point
 
         #----<<stcf017>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcf017
            #add-point:BEFORE FIELD stcf017
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcf017
            
            #add-point:AFTER FIELD stcf017
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.stcf017
         ON ACTION controlp INFIELD stcf017
            #add-point:ON ACTION controlp INFIELD stcf017
            
            #END add-point
 
         #----<<stcf018>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcf018
            #add-point:BEFORE FIELD stcf018
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcf018
            
            #add-point:AFTER FIELD stcf018
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.stcf018
         ON ACTION controlp INFIELD stcf018
            #add-point:ON ACTION controlp INFIELD stcf018
            
            #END add-point
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON stchseq,stch002,stch003
           FROM s_detail2[1].stchseq,s_detail2[1].stch002,s_detail2[1].stch003
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
       #---------------------<  Detail: page2  >---------------------
         #----<<stchseq>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stchseq
            #add-point:BEFORE FIELD stchseq
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stchseq
            
            #add-point:AFTER FIELD stchseq
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.stchseq
         ON ACTION controlp INFIELD stchseq
            #add-point:ON ACTION controlp INFIELD stchseq
            
            #END add-point
 
         #----<<stch002>>----
         #Ctrlp:construct.c.page2.stch002
         ON ACTION controlp INFIELD stch002
            #add-point:ON ACTION controlp INFIELD stch002
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			#LET g_qryparam.reqry = FALSE
			#CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys
        #   #給予arg
        #   LET g_qryparam.arg1 = l_sys 
        #   CALL q_rtax001_3()                           #呼叫開窗
            CALL q_dbbb003() 
            DISPLAY g_qryparam.return1 TO stch002  #顯示到畫面上

            NEXT FIELD stch002                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stch002
            #add-point:BEFORE FIELD stch002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stch002
            
            #add-point:AFTER FIELD stch002
            
            #END add-point
            
 
         #----<<stch003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stch003
            #add-point:BEFORE FIELD stch003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stch003
            
            #add-point:AFTER FIELD stch003
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.stch003
         ON ACTION controlp INFIELD stch003
            #add-point:ON ACTION controlp INFIELD stch003
            
            #END add-point
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令)
      #160513-00033#8--(S)
      CONSTRUCT g_wc2_table5 ON stclseq,stcl002,stcl003,stcl004,stcl005,
                                stcl006,stcl007,stcl008,stcl009,stcl010,
                                stcl011,stcl012,stcl013,stcl014
           FROM s_detail5[1].stclseq,s_detail5[1].stcl002,s_detail5[1].stcl003,s_detail5[1].stcl004,s_detail5[1].stcl005,
                s_detail5[1].stcl006,s_detail5[1].stcl007,s_detail5[1].stcl008,s_detail5[1].stcl009,s_detail5[1].stcl010,
                s_detail5[1].stcl011,s_detail5[1].stcl012,s_detail5[1].stcl013,s_detail5[1].stcl014
                      
         ON ACTION controlp INFIELD stcl002
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
   			LET g_qryparam.reqry = FALSE
   			LET g_qryparam.arg1 = '2147'
            CALL q_oocq002()                     
            DISPLAY g_qryparam.return1 TO stcl002
            NEXT FIELD stcl002 
         
         ON ACTION controlp INFIELD stcl003
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
   			LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                     
            DISPLAY g_qryparam.return1 TO stcl003
            NEXT FIELD stcl003 
         
         ON ACTION controlp INFIELD stcl010
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
   			LET g_qryparam.reqry = FALSE
   			LET g_qryparam.where = " stat001 = '11'"
            CALL q_stab001_3()                     
            DISPLAY g_qryparam.return1 TO stcl010
            NEXT FIELD stcl010 
         
         ON ACTION controlp INFIELD stcl014
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
   			LET g_qryparam.reqry = FALSE
   			LET g_qryparam.arg1 = '2146'
            CALL q_oocq002()                     
            DISPLAY g_qryparam.return1 TO stcl014
            NEXT FIELD stcl014 
            
      END CONSTRUCT
      #160513-00033#8--(E)
      CONSTRUCT g_wc2_table3 ON stcgseq2,stcg002,stcg003,stcg004
           FROM s_detail3[1].stcgseq2, s_detail3[1].stcg002, s_detail3[1].stcg003, s_detail3[1].stcg004
                      
         BEFORE CONSTRUCT
        

      END CONSTRUCT
      
      
       CONSTRUCT g_wc2_table4 ON stcwseq,stcw002,stcw003,stcw004,stcw005,stcw006
           FROM s_detail4[1].stcwseq,s_detail4[1].stcw002,s_detail4[1].stcw003,s_detail4[1].stcw004,s_detail4[1].stcw005,s_detail4[1].stcw006
                      
         BEFORE CONSTRUCT

       
      END CONSTRUCT
 
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog
         #DISPLAY '11' TO stce005
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
   
   #組合g_wc2
   LET g_wc2 = g_wc2_table1
   IF g_wc2_table2 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
   END IF
 
 
 
 
   
   #add-point:cs段結束前
   IF g_wc2_table3 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
   END IF
   IF g_wc2_table4 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
   END IF
   #160513-00033#8--(S)
   IF cl_null(g_wc2_table5) THEN LET g_wc2_table5 = " 1=1" END IF
   IF g_wc2_table5 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
   END IF
   #160513-00033#8--(E)
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="astm601.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION astm601_filter()
   #add-point:filter段define
   DEFINE ls_result   STRING
   #end add-point   
 
   #切換畫面
   IF NOT g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF   
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON stce001,stce002,stce004,stce009,stce021,stce022,stce023,stce006, 
          stce007,stce026,stce013,stce014,stce015,stce024,stce025,stce017,stce018,stce019,stce020,stce003, 
          stceunit
                          FROM s_browse[1].b_stce001,s_browse[1].b_stce002,s_browse[1].b_stce004, 
                              s_browse[1].b_stce009,s_browse[1].b_stce021,s_browse[1].b_stce022,s_browse[1].b_stce023, 
                              s_browse[1].b_stce006,s_browse[1].b_stce007,s_browse[1].b_stce026,s_browse[1].b_stce013, 
                              s_browse[1].b_stce014,s_browse[1].b_stce015,s_browse[1].b_stce024,s_browse[1].b_stce025, 
                              s_browse[1].b_stce017,s_browse[1].b_stce018,s_browse[1].b_stce019,s_browse[1].b_stce020, 
                              s_browse[1].b_stce003,s_browse[1].b_stceunit
 
         BEFORE CONSTRUCT
               DISPLAY astm601_filter_parser('stce001') TO s_browse[1].b_stce001
            DISPLAY '11' TO s_browse[1].b_stce005
            DISPLAY astm601_filter_parser('stce002') TO s_browse[1].b_stce002
            DISPLAY astm601_filter_parser('stce004') TO s_browse[1].b_stce004
            DISPLAY astm601_filter_parser('stce009') TO s_browse[1].b_stce009
            DISPLAY astm601_filter_parser('stce021') TO s_browse[1].b_stce021
            DISPLAY astm601_filter_parser('stce022') TO s_browse[1].b_stce022
            DISPLAY astm601_filter_parser('stce023') TO s_browse[1].b_stce023
            DISPLAY astm601_filter_parser('stce006') TO s_browse[1].b_stce006
            DISPLAY astm601_filter_parser('stce007') TO s_browse[1].b_stce007
            DISPLAY astm601_filter_parser('stce026') TO s_browse[1].b_stce026
            DISPLAY astm601_filter_parser('stce013') TO s_browse[1].b_stce013
            DISPLAY astm601_filter_parser('stce014') TO s_browse[1].b_stce014
            DISPLAY astm601_filter_parser('stce015') TO s_browse[1].b_stce015
            DISPLAY astm601_filter_parser('stce024') TO s_browse[1].b_stce024
            DISPLAY astm601_filter_parser('stce025') TO s_browse[1].b_stce025
            DISPLAY astm601_filter_parser('stce017') TO s_browse[1].b_stce017
            DISPLAY astm601_filter_parser('stce018') TO s_browse[1].b_stce018
            DISPLAY astm601_filter_parser('stce019') TO s_browse[1].b_stce019
            DISPLAY astm601_filter_parser('stce020') TO s_browse[1].b_stce020
            DISPLAY astm601_filter_parser('stce003') TO s_browse[1].b_stce003
            DISPLAY astm601_filter_parser('stceunit') TO s_browse[1].b_stceunit
      
                            #add-point:filter段cs_ctrl
            AFTER FIELD b_stce020
               CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
               IF NOT cl_null(ls_result) THEN
                  IF NOT cl_chk_date_symbol(ls_result) THEN
                     LET ls_result = cl_add_date_extra_cond(ls_result)
                  END IF
               END IF
               CALL FGL_DIALOG_SETBUFFER(ls_result)
                            #end add-point
      
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
      LET g_wc_filter = "   AND   ", g_wc_filter, "   "
      LET g_wc = g_wc , g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
      LET g_wc = g_wc_t
   END IF
 
      CALL astm601_filter_show('stce001')
   CALL astm601_filter_show('stce005')
   CALL astm601_filter_show('stce002')
   CALL astm601_filter_show('stce004')
   CALL astm601_filter_show('stce009')
   CALL astm601_filter_show('stce021')
   CALL astm601_filter_show('stce022')
   CALL astm601_filter_show('stce023')
   CALL astm601_filter_show('stce006')
   CALL astm601_filter_show('stce007')
   CALL astm601_filter_show('stce026')
   CALL astm601_filter_show('stce013')
   CALL astm601_filter_show('stce014')
   CALL astm601_filter_show('stce015')
   CALL astm601_filter_show('stce024')
   CALL astm601_filter_show('stce025')
   CALL astm601_filter_show('stce017')
   CALL astm601_filter_show('stce018')
   CALL astm601_filter_show('stce019')
   CALL astm601_filter_show('stce020')
   CALL astm601_filter_show('stce003')
   CALL astm601_filter_show('stceunit')
 
END FUNCTION
 
{</section>}
 
{<section id="astm601.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION astm601_filter_parser(ps_field)
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}
   #add-point:filter段define
   
   #end add-point    
 
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
 
{</section>}
 
{<section id="astm601.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION astm601_filter_show(ps_field)
   DEFINE ps_field         STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
     
   LET ls_name = "formonly.b_", ps_field
   
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
   
   #顯示資料組合
   LET ls_condition = astm601_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
   
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
   
END FUNCTION
 
{</section>}
 
{<section id="astm601.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION astm601_query()
   {<Local define>}
   DEFINE ls_wc STRING
   {</Local define>}
   #add-point:query段define
      CALL g_stcg_d.clear()
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
   CALL g_stcf_d.clear()
   CALL g_stcf2_d.clear()
 
 
   
   #add-point:query段other
   CALL cl_set_comp_visible('page_1',TRUE)
   CALL g_stcl_d.clear()   #160513-00033#8
   #end add-point   
   
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL astm601_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL astm601_browser_fill("")
      CALL astm601_fetch("")
      RETURN
   END IF
   
   #搜尋後資料初始化
   LET g_detail_cnt = 0
   LET g_current_idx = 1
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET l_ac = 1
   LET g_wc_filter = ""
   CALL FGL_SET_ARR_CURR(1)
      CALL astm601_filter_show('stce001')
   CALL astm601_filter_show('stce005')
   CALL astm601_filter_show('stce002')
   CALL astm601_filter_show('stce004')
   CALL astm601_filter_show('stce009')
   CALL astm601_filter_show('stce021')
   CALL astm601_filter_show('stce022')
   CALL astm601_filter_show('stce023')
   CALL astm601_filter_show('stce006')
   CALL astm601_filter_show('stce007')
   CALL astm601_filter_show('stce026')
   CALL astm601_filter_show('stce013')
   CALL astm601_filter_show('stce014')
   CALL astm601_filter_show('stce015')
   CALL astm601_filter_show('stce024')
   CALL astm601_filter_show('stce025')
   CALL astm601_filter_show('stce017')
   CALL astm601_filter_show('stce018')
   CALL astm601_filter_show('stce019')
   CALL astm601_filter_show('stce020')
   CALL astm601_filter_show('stce003')
   CALL astm601_filter_show('stceunit')
   LET g_error_show = 1
   CALL astm601_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "-100"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
   ELSE
      CALL astm601_fetch("F") 
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="astm601.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION astm601_fetch(p_flag)
   {<Local define>}
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   {</Local define>}
   #add-point:fetch段define
   
   #end add-point    
   
   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
   
   CASE p_flag
      WHEN 'F' LET g_current_idx = 1
      WHEN 'L' LET g_current_idx = g_header_cnt        
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
 
            PROMPT ls_msg CLIPPED,':' FOR g_jump
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
   
   
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
   
   LET g_detail_cnt = g_header_cnt                  
   
   #單身總筆數顯示
   #LET g_detail_idx = 1
   IF g_detail_cnt > 0 THEN
      #LET g_detail_idx = 1
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY ' ' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_current_idx, g_browser_cnt )
   
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_stce_m.stce001 = g_browser[g_current_idx].b_stce001
 
   
   #重讀DB,因TEMP有不被更新特性
    SELECT UNIQUE stce005,stce001,stce002,stce003,stce009,stce010,stce011,stce012,stce004,stceunit,stcesite,stce027,stce021,stce022,stce023,stce006, 
        stce007,stce008,stce024,stce028,stce025,stce026,stce013,stce014,stce015,stce016,stce017,stce018,stce019,stce020,stcestus, 
        stceownid,stceowndp,stcecrtid,stcecrtdp,stcecrtdt,stcemodid,stcemoddt,stcecnfid,stcecnfdt
 INTO g_stce_m.stce005,g_stce_m.stce001,g_stce_m.stce002,g_stce_m.stce003,g_stce_m.stce009,g_stce_m.stce010,g_stce_m.stce011,g_stce_m.stce012,g_stce_m.stce004, 
     g_stce_m.stceunit,g_stce_m.stcesite,g_stce_m.stce027,g_stce_m.stce021,g_stce_m.stce022,g_stce_m.stce023,g_stce_m.stce006,g_stce_m.stce007,g_stce_m.stce008, 
     g_stce_m.stce024,g_stce_m.stce028,g_stce_m.stce025,g_stce_m.stce026,g_stce_m.stce013,g_stce_m.stce014,g_stce_m.stce015, g_stce_m.stce016,
     g_stce_m.stce017,g_stce_m.stce018,g_stce_m.stce019,g_stce_m.stce020,g_stce_m.stcestus,g_stce_m.stceownid, 
     g_stce_m.stceowndp,g_stce_m.stcecrtid,g_stce_m.stcecrtdp,g_stce_m.stcecrtdt,g_stce_m.stcemodid, 
     g_stce_m.stcemoddt,g_stce_m.stcecnfid,g_stce_m.stcecnfdt
 FROM stce_t
 WHERE stceent = g_enterprise AND stce001 = g_stce_m.stce001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "stce_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      INITIALIZE g_stce_m.* TO NULL
      RETURN
   END IF
   
   #add-point:fetch段action控制
   #s983961 因應需求:一律只能從 申請作業 做新增/刪除/修改  MARK & ADD(S)
   #IF g_stce_m.stcestus = 'N' THEN
   #   CALL cl_set_act_visible("modify,delete,modify_detail",TRUE)
   #ELSE
   #   CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)
   #END IF  
   CALL cl_set_act_visible("insert,modify,delete,reproduce,modify_detail,statechange", FALSE)  
   CALL astm601_set_visible()  
   #s983961 因應需求:一律只能從 申請作業 做新增/刪除/修改  MARK & ADD(E)
   #end add-point  
   
   
   
   #add-point:fetch結束前
   
   #end add-point
   
   #LET g_data_owner =       
   #LET g_data_group =   
   
   #重新顯示   
   CALL astm601_show()
 
END FUNCTION
 
{</section>}
 
{<section id="astm601.insert" >}
#+ 資料新增
PRIVATE FUNCTION astm601_insert()
   #add-point:insert段define
   DEFINE l_insert      LIKE type_t.num5
   CALL g_stcl_d.clear()   #160513-00033#8
   #end add-point    
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_stcf_d.clear()   
   CALL g_stcf2_d.clear()  
   CALL g_stcg_d.clear() 
   CALL g_stcw_d.clear() 
 
   INITIALIZE g_stce_m.* LIKE stce_t.*             #DEFAULT 設定
   
   LET g_stce001_t = NULL
 
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #此段落由子樣板a14產生    
      LET g_stce_m.stceownid = g_user
      LET g_stce_m.stceowndp = g_dept
      LET g_stce_m.stcecrtid = g_user
      LET g_stce_m.stcecrtdp = g_dept 
      LET g_stce_m.stcecrtdt = cl_get_current()
      LET g_stce_m.stcemodid = ""
      LET g_stce_m.stcemoddt = ""
      #LET g_stce_m.stcestus = ""
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_stce_m.stce005 = "11"
 
 
  
      #add-point:單頭預設值
      CALL g_stcl_d.clear()   #160513-00033#8
       LET g_stce_m.stce002 = ""
      LET g_stce_m.stcestus = "N"   
      LET g_stce_m.stce013 = cl_get_current()
      #LET g_stce_m.stcesite = g_site #150320-00008#1 mark by ken 150323 stcesite改為no use後不使用
#      LET g_stce_m.stceunit = g_site
      LET g_site_flag = FALSE
      CALL s_aooi500_default(g_prog,'stceunit',g_stce_m.stceunit)
         RETURNING l_insert,g_stce_m.stceunit
      IF NOT l_insert THEN
         RETURN
      END IF
      CALL astm601_stceunit_ref()
      LET g_stce_m.stce008 = '1'
      SELECT ooef017 INTO g_stce_m.stce014 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_stce_m.stceunit
      CALL astm601_stce014_ref()
     # LET g_stce_m.stce017 = cl_get_current()
     # LET g_stce_m.stce018 = g_stce_m.stce017+1
      LET g_stce_m.stce015 = g_user
      CALL astm601_stce015_ref()
      LET g_stce_m.stce016 = g_dept
      CALL astm601_stce016_ref()
     # IF NOT s_date_chk_lastday(g_stce_m.stce017) THEN
     #    LET g_stce_m.next_b = g_stce_m.stce018
     # ELSE
     #    LET g_stce_m.next_b = g_stce_m.stce017
     # END IF
      DISPLAY g_stce_m.next_b TO next_b
      LET g_stce_m_t.* = g_stce_m.*
      LET g_stce_m_o.* = g_stce_m.*
      #end add-point 
     
      CALL astm601_input("a")
      
      #add-point:單頭輸入後
      CALL g_stcg_d.clear()
      LET g_rec_b3 = 0
    
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_stce_m.* = g_stce_m_t.*
         CALL astm601_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         EXIT WHILE
      END IF
      
      CALL g_stcf_d.clear()
      CALL g_stcf2_d.clear()
 
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   LET g_state = "Y"
   
   LET g_stce001_t = g_stce_m.stce001
 
   
   LET g_wc = g_wc,  
              " OR ( stceent = '" ||g_enterprise|| "' AND",
              " stce001 = '", g_stce_m.stce001 CLIPPED, "' "
 
              , ") "
   
   CLOSE astm601_cl
   
END FUNCTION
 
{</section>}
 
{<section id="astm601.modify" >}
#+ 資料修改
PRIVATE FUNCTION astm601_modify()
   {<Local define>}
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:modify段define
   
   #end add-point    
   
   IF g_stce_m.stce001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      RETURN
   END IF
   
    SELECT UNIQUE stce005,stce001,stce002,stce003,stce009,stce010,stce011,stce012,stce004,stceunit,stcesite,stce027,stce021,stce022,stce023,stce006, 
        stce007,stce024,stce028,stce025,stce026,stce013,stce014,stce015,stce016,stce017,stce018,stce019,stce020,stcestus, 
        stceownid,stceowndp,stcecrtid,stcecrtdp,stcecrtdt,stcemodid,stcemoddt,stcecnfid,stcecnfdt
 INTO g_stce_m.stce005,g_stce_m.stce001,g_stce_m.stce002,g_stce_m.stce003,g_stce_m.stce009,g_stce_m.stce010,g_stce_m.stce011,g_stce_m.stce012,g_stce_m.stce004, 
     g_stce_m.stceunit,g_stce_m.stcesite,g_stce_m.stce027,g_stce_m.stce021,g_stce_m.stce022,g_stce_m.stce023,g_stce_m.stce006,g_stce_m.stce007, 
     g_stce_m.stce024,g_stce_m.stce028,g_stce_m.stce025,g_stce_m.stce026,g_stce_m.stce013,g_stce_m.stce014,g_stce_m.stce015,g_stce_m.stce016,
     g_stce_m.stce017,g_stce_m.stce018,g_stce_m.stce019,g_stce_m.stce020,g_stce_m.stcestus,g_stce_m.stceownid, 
     g_stce_m.stceowndp,g_stce_m.stcecrtid,g_stce_m.stcecrtdp,g_stce_m.stcecrtdt,g_stce_m.stcemodid, 
     g_stce_m.stcemoddt,g_stce_m.stcecnfid,g_stce_m.stcecnfdt
 FROM stce_t
 WHERE stceent = g_enterprise AND stce001 = g_stce_m.stce001
 
   ERROR ""
  
   LET g_stce001_t = g_stce_m.stce001
 
   CALL s_transaction_begin()
   
   OPEN astm601_cl USING g_enterprise,g_stce_m.stce001
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN astm601_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      CLOSE astm601_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH astm601_cl INTO g_stce_m.stce005,g_stce_m.stce001,g_stce_m.stce002,g_stce_m.stce003,g_stce_m.stce009, 
       g_stce_m.stce009_desc,g_stce_m.stce004,g_stce_m.stce004_desc,g_stce_m.stceunit,g_stce_m.stceunit_desc, 
       g_stce_m.stce021,g_stce_m.stce021_desc,g_stce_m.stce022,g_stce_m.stce022_desc,g_stce_m.stce023,g_stce_m.stce023_desc, 
       g_stce_m.stce006,g_stce_m.stce006_desc,g_stce_m.stce007,g_stce_m.stce007_desc,g_stce_m.stce024, 
       g_stce_m.stce024_desc,g_stce_m.stce025,g_stce_m.stce025_desc,g_stce_m.stce026,g_stce_m.stce013, 
       g_stce_m.stce014,g_stce_m.stce014_desc,g_stce_m.stce015,g_stce_m.stce015_desc,g_stce_m.stce017, 
       g_stce_m.stce018,g_stce_m.stce019,g_stce_m.stce020,g_stce_m.stcestus,g_stce_m.stceownid,g_stce_m.stceownid_desc, 
       g_stce_m.stceowndp,g_stce_m.stceowndp_desc,g_stce_m.stcecrtid,g_stce_m.stcecrtid_desc,g_stce_m.stcecrtdp, 
       g_stce_m.stcecrtdp_desc,g_stce_m.stcecrtdt,g_stce_m.stcemodid,g_stce_m.stcemodid_desc,g_stce_m.stcemoddt, 
       g_stce_m.stcecnfid,g_stce_m.stcecnfid_desc,g_stce_m.stcecnfdt
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_stce_m.stce001
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      CLOSE astm601_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   
 
   CALL astm601_show()
   WHILE TRUE
      LET g_stce001_t = g_stce_m.stce001
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_stce_m.stcemodid = g_user 
LET g_stce_m.stcemoddt = cl_get_current()
 
      
      #add-point:modify段修改前
      
      #end add-point
      
      CALL astm601_input("u")     #欄位更改
 
      #add-point:modify段修改後
 
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_stce_m.* = g_stce_m_t.*
         CALL astm601_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更
      IF g_stce_m.stce001 != g_stce001_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前
         
         #end add-point
         
         #更新單身key值
         UPDATE stcf_t SET stcf001 = g_stce_m.stce001
 
          WHERE stcfent = g_enterprise AND stcf001 = g_stce001_t
 
            
         #add-point:單身fk修改中
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "stcf_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stcf_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後
         
         #end add-point
         
         #更新單身key值
         #add-point:單身fk修改前
         
         #end add-point
         UPDATE stch_t
            SET stch001 = g_stce_m.stce001
 
          WHERE stchent = g_enterprise AND
                stch001 = g_stce001_t
 
         #add-point:單身fk修改中
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "stch_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stch_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後
         
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
 
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #修改歷程記錄
   IF NOT cl_log_modified_record(g_stce_m.stce001,g_site) THEN 
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE astm601_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-U
   CALL cl_flow_notify(g_stce_m.stce001,'U')
 
END FUNCTION   
 
{</section>}
 
{<section id="astm601.input" >}
#+ 資料輸入
PRIVATE FUNCTION astm601_input(p_cmd)
   {<Local define>}
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_ac_t                LIKE type_t.num5                #未取消的ARRAY CNT 
   DEFINE  l_n                   LIKE type_t.num5                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num5                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num5
   DEFINE  l_i                   LIKE type_t.num5
   DEFINE  l_insert              BOOLEAN
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num5
   DEFINE  li_reproduce_target   LIKE type_t.num5
   {</Local define>}
   #add-point:input段define
   DEFINE  l_stag002             LIKE stag_t.stag002
  #DEFINE  t_stce004             LIKE stce_t.stce004    #170202-00019#1 170202 by 02749 mark
   DEFINE  l_flag                LIKE type_t.chr1
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_sys                 LIKE type_t.num5
   DEFINE  l_sys_1               LIKE type_t.chr1 
   DEFINE  l_stce017             LIKE stce_t.stce017
   DEFINE  l_stce018             LIKE stce_t.stce018
   DEFINE  l_ac1                 LIKE type_t.num5
   DEFINE  l_dbba002             LIKE dbba_t.dbba002
   DEFINE  l_dbbc004             LIKE dbbc_t.dbbc004
   DEFINE  l_errno               LIKE type_t.chr10
   DEFINE  l_ooef019             LIKE ooef_t.ooef019
   #add--2015/05/08 By shiun--(S)
   DEFINE l_oofg_return    DYNAMIC ARRAY OF RECORD
                   oofg019     LIKE oofg_t.oofg019,   #field
                   oofg020     LIKE oofg_t.oofg020    #value
                           END RECORD
   #add--2015/05/08 By shiun--(E)
   #end add-point  
 
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql
   LET g_forupd_sql = "SELECT stcgseq2,stcg002,stcg003,stcg004 FROM stcg_t WHERE stcgent=? AND stcg001=? AND stcgseq1=? AND stcgseq2 = ? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE astm601_bcl3 CURSOR FROM g_forupd_sql
   
   #end add-point 
   LET g_forupd_sql = "SELECT stcfseq,stcf002,'',stcf003,stcf004,stcf005,stcf006,stcf007,stcf008,'', 
       stcf009,'',stcf010,stcf011,stcf012,stcf013,stcf014,stcf015,stcf016,stcf017,stcf018,stcf019 FROM stcf_t  
       WHERE stcfent=? AND stcf001=? AND stcfseq=? FOR UPDATE"
   #add-point:input段define_sql
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE astm601_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql
   
   #end add-point    
   LET g_forupd_sql = "SELECT stchseq,stch002,'',stch003 FROM stch_t WHERE stchent=? AND stch001=? AND  
       stchseq=? FOR UPDATE"
   #add-point:input段define_sql
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE astm601_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql
    LET g_forupd_sql = "SELECT stcwsite,stcwunit,stcwseq,stcw002,stcw003,stcw004,stcw005,stcw006 FROM stcw_t WHERE stcwent=? AND stcw001=? AND  
       stcwseq=? FOR UPDATE"
    LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE astm601_bcl4 CURSOR FROM g_forupd_sql     
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL astm601_set_entry(p_cmd)
   #add-point:set_entry後
   
   #end add-point
   CALL astm601_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_stce_m.stce005,g_stce_m.stce001,g_stce_m.stce002,g_stce_m.stce003,g_stce_m.stce009, 
       g_stce_m.stce004,g_stce_m.stceunit,g_stce_m.stcesite,g_stce_m.stce021,g_stce_m.stce022,g_stce_m.stce023,g_stce_m.stce006, 
       g_stce_m.stce007,g_stce_m.stce024,g_stce_m.stce025,g_stce_m.stce026,g_stce_m.stce013,g_stce_m.stce014, 
       g_stce_m.stce015,g_stce_m.stce017,g_stce_m.stce018,g_stce_m.stce019,g_stce_m.stce020,g_stce_m.stcestus 
 
   
   LET lb_reproduce = FALSE
   
   #add-point:資料輸入前
    DISPLAY BY NAME g_stce_m.stce005
   #LET t_stce004 =  g_stce_m.stce004    #170202-00019#1 170202 by 02749 mark
    LET l_success = FALSE
   #LET t_stce.* = g_stce_m.*            #170202-00019#1 170202 by 02749 mark
    LET g_stce_m_o.* = g_stce_m.*        #170202-00019#1 170202 by 02749 add
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
 
{</section>}
 
{<section id="astm601.input.head" >}
      #單頭段
      INPUT BY NAME g_stce_m.stce005,g_stce_m.stce001,g_stce_m.stce002,g_stce_m.stce003,g_stce_m.stce009,g_stce_m.stce010,g_stce_m.stce012,  
          g_stce_m.stce004,g_stce_m.stceunit,g_stce_m.stce027,g_stce_m.stce021,g_stce_m.stce022,g_stce_m.stce023,g_stce_m.stce006, 
          g_stce_m.stce007,g_stce_m.stce024,g_stce_m.stce028,g_stce_m.stce025,g_stce_m.stce026,g_stce_m.stce013,g_stce_m.stce014, 
          g_stce_m.stce015,g_stce_m.stce016,g_stce_m.stce017,g_stce_m.stce018,g_stce_m.next_b,g_stce_m.stce019,g_stce_m.stce020,
          g_stce_m.ooff013,g_stce_m.stcestus  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:資料輸入前
           
            #end add-point
 
         #---------------------------<  Master  >---------------------------
         #----<<stce005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stce005
            #add-point:BEFORE FIELD stce005
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stce005
            
            #add-point:AFTER FIELD stce005
            #170202-00019#1 170202 by 02749 mod---(E)
            #IF NOT cl_null(g_stce_m.stce004) THEN
            #    SELECT stag002 INTO l_stag002 FROM stag_t WHERE stagent = g_enterprise AND stag001 = g_stce_m.stce004
            #    IF l_stag002 <> g_stce_m.stce005 THEN
            #       INITIALIZE g_errparam TO NULL
            #       LET g_errparam.code = 'ast-00023'
            #       LET g_errparam.extend = ''
            #       LET g_errparam.popup = TRUE
            #       CALL cl_err()
            #
            #       LET g_stce_m.stce005 = g_stce_m_t.stce005
            #       NEXT FIELD stce005   
            #    END IF
            #END IF
            #
            ##IF NOT cl_null(g_stce_m.stce009) AND NOT cl_null(g_stce_m.stce005)         
            ##    AND NOT cl_null(g_stce_m.stce017) AND NOT cl_null(g_stce_m.stce018) THEN
            ##      IF NOT astm601_interval_chk(p_cmd) THEN
            ##         LET g_stce_m.stce005 = g_stce_m_t.stce005
            ##         NEXT FIELD stce005   
            ##      END IF                
            ##END IF  
            # 
            #IF NOT cl_null(g_stce_m.stce010) AND NOT cl_null(g_stce_m.stce027) THEN
            #   IF t_stce.stce005 <> g_stce_m.stce005 AND  NOT cl_null(t_stce.stce005) THEN
            #       INITIALIZE g_errparam TO NULL
            #       LET g_errparam.code = 'ast-00118'
            #       LET g_errparam.extend = ''
            #       LET g_errparam.popup = TRUE
            #       CALL cl_err()
            #       LET g_stce_m.stce005 = g_stce_m_t.stce005
            #       NEXT FIELD stce005  
            #   END IF        
            #END IF
            #LET t_stce.stce005 = g_stce_m.stce005
              
            IF NOT cl_null(g_stce_m.stce005) THEN
               IF g_stce_m.stce005 <> g_stce_m_o.stce005 OR cl_null(g_stce_m_o.stce005) THEN
                  IF NOT cl_null(g_stce_m.stce004) THEN
                       SELECT stag002 INTO l_stag002 
                         FROM stag_t 
                        WHERE stagent = g_enterprise AND stag001 = g_stce_m.stce004
                        
                       IF l_stag002 <> g_stce_m.stce005 THEN
                          INITIALIZE g_errparam TO NULL
                          LET g_errparam.code = 'ast-00023'
                          LET g_errparam.extend = ''
                          LET g_errparam.popup = TRUE
                          CALL cl_err()
                  
                          LET g_stce_m.stce005 = g_stce_m_o.stce005
                          NEXT FIELD stce005   
                       END IF
                  END IF               
                  
                  IF NOT cl_null(g_stce_m.stce010) AND NOT cl_null(g_stce_m.stce027) THEN
                     IF NOT cl_null(g_stce_m_o.stce005) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'ast-00118'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_stce_m.stce005 = g_stce_m_o.stce005
                        NEXT FIELD stce005 
                     END IF
                  END IF                  
               END IF
            END IF
            
            LET g_stce_m_o.stce005 = g_stce_m.stce005
            #170202-00019#1 170202 by 02749 mod---(E)
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stce005
            #add-point:ON CHANGE stce005
            IF NOT astm601_b_chk() THEN          
               LET g_stce_m.stce005 = g_stce_m_t.stce005
               NEXT FIELD stce005 
            END IF
            #END add-point
 
         #----<<stce001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stce001
            #add-point:BEFORE FIELD stce001
            CALL cl_get_para(g_enterprise,g_site,'E-CIR-0010') RETURNING l_sys_1
            IF l_sys_1 = 'Y' THEN
               IF p_cmd = 'a' AND cl_null(g_stce_m.stce001) THEN
#                 CALL s_aooi390('26') RETURNING l_success,g_stce_m.stce001 
                  CALL s_aooi390_gen('26') RETURNING l_success,g_stce_m.stce001,l_oofg_return   #add--2015/05/08 By shiun
                 IF NOT cl_null(g_stce_m.stce001) THEN               
                    IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM stce_t WHERE "||"stceent = '" ||g_enterprise|| "' AND "||"stce001 = '"||g_stce_m.stce001 ||"'",'std-00004',0) THEN 
                       LET g_stce_m.stce001 = ''
                    END IF   
                 END IF                            
              END IF
            END IF
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stce001
            
            #add-point:AFTER FIELD stce001
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_stce_m.stce001) THEN 
              #IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_stce_m.stce001 != g_stce001_t ))) THEN   #150427-00012#7 20160104 mark by beckxie
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_stce_m.stce001 != g_stce001_t OR cl_null(g_stce001_t ))) THEN   #150427-00012#7 20160104 add by beckxie
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM stce_t WHERE "||"stceent = '" ||g_enterprise|| "' AND "||"stce001 = '"||g_stce_m.stce001 ||"'",'std-00004',0) THEN 
                    #LET g_stce_m.stce001 =  g_stce_m_t.stce001   #170202-00019#1 170202 by 02749 mark
                     LET g_stce_m.stce001 =  g_stce_m_o.stce001   #170202-00019#1 170202 by 02749 add
                      DISPLAY BY NAME g_stce_m.stce001            #170202-00019#1 170202 by 02749 add
                     NEXT FIELD CURRENT
                  END IF
                  #add--2015/05/08 By shiun--(S)
                  IF NOT s_aooi390_chk('26',g_stce_m.stce001) THEN
                    #LET g_stce_m.stce001 =  g_stce_m_t.stce001   #170202-00019#1 170202 by 02749 mark
                     LET g_stce_m.stce001 =  g_stce_m_o.stce001   #170202-00019#1 170202 by 02749 add
                     DISPLAY BY NAME g_stce_m.stce001
                     NEXT FIELD CURRENT
                  END IF
                  #add--2015/05/08 By shiun--(E)
               END IF
               #网点为空。结算编号 = 当前合约编号
               IF cl_null(g_stce_m.stce010) THEN
                  LET g_stce_m.stce027 = g_stce_m.stce001
                  DISPLAY BY NAME g_stce_m.stce027
               END IF
            END IF
            
            LET g_stce_m_o.stce001 = g_stce_m.stce001   #170202-00019#1 170202 by 02749 add
            LET g_stce_m_o.stce027 = g_stce_m.stce027   #170202-00019#1 170202 by 02749 add
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stce001
            #add-point:ON CHANGE stce001
            
            #END add-point
 
         #----<<stce002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stce002
            #add-point:BEFORE FIELD stce002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stce002
            
            #add-point:AFTER FIELD stce002
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stce002
            #add-point:ON CHANGE stce002
            
            #END add-point
 
         #----<<stce003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stce003
            #add-point:BEFORE FIELD stce003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stce003
            
            #add-point:AFTER FIELD stce003
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stce003
            #add-point:ON CHANGE stce003
            
            #END add-point
 
         #----<<stce009>>----
         #此段落由子樣板a02產生
         AFTER FIELD stce009
            
            #add-point:AFTER FIELD stce009
            LET g_stce_m.stce009_desc = ''
            DISPLAY BY NAME g_stce_m.stce009_desc
            IF NOT cl_null(g_stce_m.stce009) THEN
               IF g_stce_m.stce009 <> g_stce_m_o.stce009 OR cl_null(g_stce_m_o.stce009) THEN   #170202-00019#1 170202 by 02749 add            
                  IF NOT astm601_stce009_chk(g_stce_m.stce009) THEN
                    #LET g_stce_m.stce009 = g_stce_m_t.stce009   #170202-00019#1 170202 by 02749 mark
                     LET g_stce_m.stce009 = g_stce_m_o.stce009   #170202-00019#1 170202 by 02749 add
                     DISPLAY BY NAME g_stce_m.stce009            #170202-00019#1 170202 by 02749 add
                     CALL astm601_stce009_ref()
                     NEXT FIELD stce009
                  END IF     
                                 
                  IF NOT cl_null(g_stce_m.stce010) THEN
                     IF NOT astm601_stce009_stce010_chk(g_stce_m.stce009,g_stce_m.stce010) THEN
                       #LET g_stce_m.stce009 = g_stce_m_t.stce009   #170202-00019#1 170202 by 02749 mark
                        LET g_stce_m.stce009 = g_stce_m_o.stce009   #170202-00019#1 170202 by 02749 add
                        DISPLAY BY NAME g_stce_m.stce009            #170202-00019#1 170202 by 02749 add
                        CALL astm601_stce009_ref()
                        NEXT FIELD stce009 
                     END IF
                   # IF NOT cl_null(g_stce_m.stce017) AND NOT cl_null(g_stce_m.stce018) THEN
                   #    IF NOT astm601_interval_chk(p_cmd) THEN
                   #       LET g_stce_m.stce009 = g_stce_m_t.stce009
                   #       CALL astm601_stce009_ref()
                   #       NEXT FIELD stce009
                   #    END IF        
                   # END IF
                   
                   #經銷商沒有簽訂合約的報錯
                     SELECT COUNT(*) INTO l_n FROM stce_t 
                      WHERE stceent = g_enterprise AND stce009 = g_stce_m.stce009 AND stce005 = g_stce_m.stce005 AND stcestus = 'Y'
                     IF l_n = 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'ast-00112'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                  
                       #LET g_stce_m.stce009 = g_stce_m_t.stce009   #170202-00019#1 170202 by 02749 mark
                        LET g_stce_m.stce009 = g_stce_m_o.stce009   #170202-00019#1 170202 by 02749 add
                        DISPLAY BY NAME g_stce_m.stce009            #170202-00019#1 170202 by 02749 add
                        NEXT FIELD stce009
                     ELSE
                         #經銷商簽訂合約失效的報錯
                         SELECT COUNT(*) INTO l_n FROM stce_t 
                          WHERE stceent = g_enterprise AND stce009 = g_stce_m.stce009 AND stce005 = g_stce_m.stce005 AND  stce018 >= g_today AND stcestus = 'Y'
                         IF l_n = 0 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'ast-00117'
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                         
                          #LET g_stce_m.stce009 = g_stce_m_t.stce009   #170202-00019#1 170202 by 02749 mark
                           LET g_stce_m.stce009 = g_stce_m_o.stce009   #170202-00019#1 170202 by 02749 add
                           DISPLAY BY NAME g_stce_m.stce009            #170202-00019#1 170202 by 02749 add
                           NEXT FIELD stce009
                        END IF      
                     END IF
                     
                     #结算合同不为空
                     IF NOT cl_null(g_stce_m.stce027 ) THEN
                        #结算合同对应的经销商和当前经销商不一致报错
                        SELECT COUNT(*) INTO l_n FROM stce_t 
                         WHERE stceent = g_enterprise AND stce001 = g_stce_m.stce027 AND stce009 =g_stce_m.stce009
                        IF l_n = 0 THEN
                            INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'ast-00128'
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                         
                          #LET g_stce_m.stce009 = g_stce_m_t.stce009   #170202-00019#1 170202 by 02749 mark
                           LET g_stce_m.stce009 = g_stce_m_o.stce009   #170202-00019#1 170202 by 02749 add
                           DISPLAY BY NAME g_stce_m.stce009            #170202-00019#1 170202 by 02749 add
                           NEXT FIELD stce009
                           
                        ELSE  #结算合同对应的经营方式和当前经营方式不一致！
                            SELECT COUNT(*) INTO l_n FROM stce_t 
                             WHERE stceent = g_enterprise AND stce001 = g_stce_m.stce027 AND stce009 =g_stce_m.stce009 AND stce005 =g_stce_m.stce005 
                            IF l_n = 0 THEN
                               INITIALIZE g_errparam TO NULL
                               LET g_errparam.code = 'ast-00195'
                               LET g_errparam.extend = ''
                               LET g_errparam.popup = TRUE
                               CALL cl_err()     
                              #LET g_stce_m.stce009 = g_stce_m_t.stce009   #170202-00019#1 170202 by 02749 mark
                               LET g_stce_m.stce009 = g_stce_m_o.stce009   #170202-00019#1 170202 by 02749 add
                               DISPLAY BY NAME g_stce_m.stce009            #170202-00019#1 170202 by 02749 add
                               NEXT FIELD stce009
                            END IF
                        END IF                       
                     END IF                             
                     LET g_stce_m.stce008 = '2'
                  ELSE
                     LET g_stce_m.stce008 = '1'
                  END IF
                 #IF (p_cmd = 'a' AND cl_null(t_stce.stce009))  OR ( NOT cl_null(t_stce.stce009) AND g_stce_m.stce009 <> t_stce.stce009 ) THEN
                       CALL astm601_stce009_other()        #170202-00019#1 170202 by 02749 remark
                 #END IF   
                 #LET t_stce.stce009 = g_stce_m.stce009    #170202-00019#1 170202 by 02749 mark
               END IF                                      #170202-00019#1 170202 by 02749 add                  
            END IF
            
            CALL astm601_stce009_ref()
            
            LET g_stce_m_o.stce009 = g_stce_m.stce009     #170202-00019#1 170202 by 02749 add  
            LET g_stce_m_o.stce008 = g_stce_m.stce008     #170202-00019#1 170202 by 02749 add  
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD stce009
            #add-point:BEFORE FIELD stce009
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE stce009
            #add-point:ON CHANGE stce009
       


         AFTER FIELD stce010
            LET g_stce_m.stce010_desc = ''
            DISPLAY BY NAME g_stce_m.stce010_desc
            IF NOT cl_null(g_stce_m.stce010) THEN 
               IF g_stce_m.stce010 <> g_stce_m_o.stce010 OR g_stce_m_o.stce010 IS NULL THEN   #170202-00019#1 170202 by 02749 add
                  IF NOT astm601_stce010_chk(g_stce_m.stce010) THEN
                    #LET g_stce_m.stce010 = g_stce_m_t.stce010   #170202-00019#1 170202 by 02749 mark
                     LET g_stce_m.stce010 = g_stce_m_o.stce010   #170202-00019#1 170202 by 02749 add
                     DISPLAY BY NAME g_stce_m.stce010            #170202-00019#1 170202 by 02749 add
                     CALL astm601_stce010_ref()
                     NEXT FIELD stce010
                  END IF
                  
                  IF NOT cl_null(g_stce_m.stce009) THEN
                    IF NOT astm601_stce009_stce010_chk(g_stce_m.stce009,g_stce_m.stce010) THEN
                      #LET g_stce_m.stce010 = g_stce_m_t.stce010   #170202-00019#1 170202 by 02749 mark
                       LET g_stce_m.stce010 = g_stce_m_o.stce010   #170202-00019#1 170202 by 02749 add
                       DISPLAY BY NAME g_stce_m.stce010            #170202-00019#1 170202 by 02749 add
                       CALL astm601_stce010_ref()
                       NEXT FIELD stce010
                    END IF
                  #  IF NOT cl_null(g_stce_m.stce017) AND NOT cl_null(g_stce_m.stce018) THEN
                  #    IF NOT astm601_interval_chk(p_cmd) THEN
                  #       LET g_stce_m.stce010 = g_stce_m_t.stce010
                  #       CALL astm601_stce010_ref()
                  #       NEXT FIELD stce010
                  #    END IF        
                  #  END IF                
                    
                    #經銷商沒有簽訂合約的報錯
                    SELECT COUNT(*) INTO l_n FROM stce_t 
                     WHERE stceent = g_enterprise AND stce009 = g_stce_m.stce009 AND stce005 =g_stce_m.stce005 AND stcestus = 'Y'
                    IF l_n = 0 THEN
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.code = 'ast-00112'
                       LET g_errparam.extend = ''
                       LET g_errparam.popup = TRUE
                       CALL cl_err()
                 
                       LET g_stce_m.stce010 = ''                   #170202-00019#1 170202 by 02749 mark
                       DISPLAY BY NAME g_stce_m.stce010            #170202-00019#1 170202 by 02749 add
                       NEXT FIELD stce010
                    ELSE
                        #經銷商簽訂合約失效的報錯
                        SELECT COUNT(*) INTO l_n FROM stce_t 
                         WHERE stceent = g_enterprise AND stce009 = g_stce_m.stce009 AND stce005 =g_stce_m.stce005  AND stce018 >= g_today AND stcestus = 'Y'
                        IF l_n = 0 THEN
                          INITIALIZE g_errparam TO NULL
                          LET g_errparam.code = 'ast-00117'
                          LET g_errparam.extend = ''
                          LET g_errparam.popup = TRUE
                          CALL cl_err()
                        
                          LET g_stce_m.stce009 = g_stce_m_t.stce009   #170202-00019#1 170202 by 02749 mark
                          #170202-00019#1 170202 by 02749 add---(S)
                          LET g_stce_m.stce009 = g_stce_m_o.stce009
                          LET g_stce_m.stce010 = g_stce_m_o.stce010   
                          DISPLAY BY NAME g_stce_m.stce009,g_stce_m.stce010            
                          #170202-00019#1 170202 by 02749 add---(E)
                          NEXT FIELD stce009
                       END IF
                    END IF
                   
                   #170202-00019#1 170202 by 02749 mark---(S)                   
                   #IF ((NOT cl_null(t_stce.stce010) AND  g_stce_m.stce010 <> t_stce.stce010) OR cl_null(t_stce.stce010)) THEN   
                   #   CALL astm601_stce009_other()
                   #END IF  
                   #170202-00019#1 170202 by 02749 mark---(E)
                  END IF                            
                  
                  CALL astm601_stcf005_chk(0) RETURNING l_success,l_ac1
                  IF NOT l_success THEN
                    #LET g_stce_m.stce010 = g_stce_m_t.stce010   #170202-00019#1 170202 by 02749 mark
                     LET g_stce_m.stce010 = g_stce_m_o.stce010   #170202-00019#1 170202 by 02749 add
                     DISPLAY BY NAME g_stce_m.stce010            #170202-00019#1 170202 by 02749 add
                     CALL astm601_stce010_ref()
                     NEXT FIELD stce010
                  END IF
                  
                  LET g_stce_m.stce008 = '2'
               END IF   #170202-00019#1 170202 by 02749 add
            ELSE      
               LET g_stce_m.stce008 = '1'
               LET g_stce_m.stce027 = g_stce_m.stce001
               DISPLAY BY NAME g_stce_m.stce027 
            END IF
            
           #LET t_stce.stce010 = g_stce_m.stce010     #170202-00019#1 170202 by 02749 mark
           
            #170202-00019#1 170202 by 02749 add---(S)
            LET g_stce_m_o.stce010 = g_stce_m.stce010
            LET g_stce_m_o.stce009 = g_stce_m.stce009             
            LET g_stce_m_o.stce008 = g_stce_m.stce008
            LET g_stce_m_o.stce027 = g_stce_m.stce027
            #170202-00019#1 170202 by 02749 add---(E)
            
            CALL astm601_stce010_ref() 
            CALL astm601_set_entry(p_cmd)
            CALL astm601_set_no_entry(p_cmd)
            CALL astm601_set_visible()
            
            
         AFTER FIELD stce012
            IF NOT cl_null(g_stce_m.stce012) THEN 
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_stce_m.stce012 != g_stce_m_t.stce012 OR g_stce_m_t.stce012 IS NULL )) THEN    #150427-00012#7 20150707 mark by beckxie
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_stce_m.stce012 != g_stce_m_t.stce012 OR cl_null(g_stce_m_t.stce012) )) THEN   #150427-00012#7 20150707 add by beckxie     #170202-00019#1 170202 by 02749 mark
                IF g_stce_m.stce012 != g_stce_m_o.stce012 OR cl_null(g_stce_m_o.stce012) THEN   #170202-00019#1 170202 by 02749 add               
                  #此段落由子樣板a19產生
                  #校驗代值
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_stce_m.stce012
                  LET g_chkparam.arg2 = '1'
                     
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_oojd001") THEN
                     #檢查失敗時後續處理
                    #LET g_stce_m_t.stce012 = g_stce_m_t.stce012   #170202-00019#1 170202 by 02749 mark
                     LET g_stce_m_t.stce012 = g_stce_m_o.stce012   #170202-00019#1 170202 by 02749 add
                     DISPLAY BY NAME g_stce_m.stce012              #170202-00019#1 170202 by 02749 add
                     
                     CALL s_desc_get_oojdl003_desc(g_stce_m.stce012) RETURNING g_stce_m.stce012_desc
                     DISPLAY BY NAME g_stce_m.stce012_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF

            END IF 
            CALL s_desc_get_oojdl003_desc(g_stce_m.stce012) RETURNING g_stce_m.stce012_desc
            DISPLAY BY NAME g_stce_m.stce012_desc       
         
            LET g_stce_m_o.stce012 = g_stce_m_t.stce012   #170202-00019#1 170202 by 02749 add
            #END add-point
 
         #----<<stce004>>----
         #此段落由子樣板a02產生
         AFTER FIELD stce004
            
            #add-point:AFTER FIELD stce004
            LET g_stce_m.stce004_desc = ''
            DISPLAY BY NAME  g_stce_m.stce004_desc
            IF NOT cl_null(g_stce_m.stce004) THEN
               IF g_stce_m.stce004 <> g_stce_m_o.stce004 OR cl_null(g_stce_m_o.stce004) THEN   #170202-00019#1 170202 by 02749 
                   IF NOT astm601_stce004_chk(g_stce_m.stce004) THEN
                     #LET g_stce_m.stce004 = g_stce_m_t.stce004   #170202-00019#1 170202 by 02749 mark
                      LET g_stce_m.stce004 = g_stce_m_o.stce004   #170202-00019#1 170202 by 02749 add
                      DISPLAY BY NAME g_stce_m.stce004            #170202-00019#1 170202 by 02749 add
                      CALL astm601_stce004_ref()
                      NEXT FIELD stce004
                   END IF 
                   IF NOT cl_null(g_stce_m.stce005) THEN
                      SELECT stag002 INTO l_stag002 FROM stag_t WHERE stagent = g_enterprise AND stag001 = g_stce_m.stce004
                      IF l_stag002 <> g_stce_m.stce005 THEN
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.code = 'ast-00023'
                         LET g_errparam.extend = ''
                         LET g_errparam.popup = TRUE
                         CALL cl_err()
                   
                        #LET g_stce_m.stce004 = g_stce_m_t.stce004   #170202-00019#1 170202 by 02749 mark
                         LET g_stce_m.stce004 = g_stce_m_o.stce004   #170202-00019#1 170202 by 02749 add
                         DISPLAY BY NAME g_stce_m.stce004            #170202-00019#1 170202 by 02749 add
                         CALL astm601_stce004_ref()
                         NEXT FIELD stce004   
                      END IF
                   END IF
                END IF   #170202-00019#1 170202 by 02749 add   
            END IF
            
            CALL astm601_stce004_ref()
            
            #170202-00019#1 170202 by 02749 mark---(S)
            #IF (g_stce_m.stce004 <>t_stce004 OR  t_stce004 is null) AND cl_null(g_stce_m.stce010) THEN
            #   CALL astm601_stce004_other()
            #END IF
            #LET t_stce004 =  g_stce_m.stce004
            #170202-00019#1 170202 by 02749 mark---(E)
            
            LET g_stce_m_o.stce004 = g_stce_m.stce004   #170202-00019#1 170202 by 02749 add
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD stce004
            #add-point:BEFORE FIELD stce004
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE stce004
            #add-point:ON CHANGE stce004
            
            #END add-point
 
         #----<<stceunit>>----
         #此段落由子樣板a02產生
         AFTER FIELD stceunit
            
            #add-point:AFTER FIELD stceunit
            IF NOT cl_null(g_stce_m.stceunit) THEN    
               IF s_aooi500_setpoint(g_prog,'stceunit') THEN
                  CALL s_aooi500_chk(g_prog,'stceunit',g_stce_m.stceunit,g_site) RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_stce_m.stceunit
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     
                     LET g_stce_m.stceunit = g_stce_m_t.stceunit
                     CALL s_desc_get_department_desc(g_stce_m.stceunit) RETURNING g_stce_m.stceunit_desc
                     DISPLAY BY NAME g_stce_m.stceunit,g_stce_m.stceunit_desc
                     NEXT FIELD CURRENT
                  END IF 
               END IF
            #sakura---add---str
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'axc-00120'
               LET g_errparam.popup  = TRUE
               CALL cl_err()            
               
               LET g_stce_m.stceunit = g_stce_m_t.stceunit
               CALL s_desc_get_department_desc(g_stce_m.stceunit) RETURNING g_stce_m.stceunit_desc
               DISPLAY BY NAME g_stce_m.stceunit,g_stce_m.stceunit_desc
               NEXT FIELD CURRENT            
            #sakura---add---end
            END IF
            LET g_site_flag = TRUE
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stce_m.stceunit
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stce_m.stceunit_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stce_m.stceunit_desc
            CALL astm601_set_entry(p_cmd)
            CALL astm601_set_no_entry(p_cmd)                           

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD stceunit
            #add-point:BEFORE FIELD stceunit
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE stceunit
            #add-point:ON CHANGE stceunit
            
            
            
         AFTER FIELD stce027
            IF NOT cl_null(g_stce_m.stce027) THEN
              #IF p_cmd = 'a' OR (p_cmd = 'u' AND g_stce_m.stce027 <>t_stce.stce027) THEN   #170202-00019#1 170202 by 02749 mark
               IF g_stce_m.stce027 <> g_stce_m_o.stce027 OR cl_null(g_stce_m_o.stce027) THEN   #170202-00019#1 170202 by 02749 add
                  IF NOT astm601_stce027_chk() THEN
                    #LET g_stce_m.stce027 = t_stce.stce027       #170202-00019#1 170202 by 02749 mark
                     LET g_stce_m.stce027 = g_stce_m_o.stce027   #170202-00019#1 170202 by 02749 add
                     NEXT FIELD stce027
                  END IF
                  CALL astm601_stce027_other()                  
               END IF
            END IF
           
            LET g_stce_m_o.stce027 = g_stce_m.stce027   #170202-00019#1 170202 by 02749 add
            #END add-point
 
         #----<<stce021>>----
         #此段落由子樣板a02產生
         AFTER FIELD stce021
            
            #add-point:AFTER FIELD stce021
            LET g_stce_m.stce021_desc = ''
            DISPLAY BY NAME g_stce_m.stce021_desc
            IF NOT cl_null(g_stce_m.stce021) THEN
               IF g_stce_m.stce021 <> g_stce_m_o.stce021 OR cl_null(g_stce_m_o.stce021) THEN   #170202-00019#1 170202 by 02749 add
                  IF NOT astm601_stce021_chk(g_stce_m.stce021) THEN
                    #LET g_stce_m.stce021 = g_stce_m_t.stce021   #170202-00019#1 170202 by 02749 mark
                     LET g_stce_m.stce021 = g_stce_m_o.stce021   #170202-00019#1 170202 by 02749 add
                     DISPLAY BY NAME g_stce_m.stce021            #170202-00019#1 170202 by 02749 add
                     CALL astm601_stce021_ref()
                     NEXT FIELD stce021
                  END IF   
               END IF   #170202-00019#1 170202 by 02749 add   
            END IF
            CALL astm601_stce021_ref() 
            
            LET g_stce_m_o.stce021 = g_stce_m.stce021   #170202-00019#1 170202 by 02749 add
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD stce021
            #add-point:BEFORE FIELD stce021
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE stce021
            #add-point:ON CHANGE stce021
            
            #END add-point
 
         #----<<stce022>>----
         #此段落由子樣板a02產生
         AFTER FIELD stce022
            
            #add-point:AFTER FIELD stce022
            LET g_stce_m.stce022_desc = ''
            DISPLAY BY NAME g_stce_m.stce022_desc
            IF NOT cl_null(g_stce_m.stce022) THEN
               IF g_stce_m.stce022 <> g_stce_m_o.stce022 OR cl_null(g_stce_m_o.stce022) THEN   #170202-00019#1 170202 by 02749 add
                  IF NOT astm601_stce022_chk(g_stce_m.stce022) THEN
                    #LET g_stce_m.stce022 = g_stce_m_t.stce022   #170202-00019#1 170202 by 02749 mark
                     LET g_stce_m.stce022 = g_stce_m_o.stce022   #170202-00019#1 170202 by 02749 add
                     DISPLAY BY NAME g_stce_m.stce022            #170202-00019#1 170202 by 02749 add
                     CALL astm601_stce022_ref()
                     NEXT FIELD stce022
                  END IF 
                  CALL astm601_stce022_ref()     
               END IF   #170202-00019#1 170202 by 02749 add                  
            ELSE
               LET g_stce_m.stce022_desc = ''
               DISPLAY BY NAME g_stce_m.stce022_desc
            END IF

            LET g_stce_m_o.stce022 = g_stce_m.stce022   #170202-00019#1 170202 by 02749 add
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD stce022
            #add-point:BEFORE FIELD stce022

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE stce022
            #add-point:ON CHANGE stce022

            #END add-point
 
         #----<<stce023>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stce023
            #add-point:BEFORE FIELD stce023
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stce023
            
            #add-point:AFTER FIELD stce023
            LET g_stce_m.stce023_desc = ''
            DISPLAY BY NAME  g_stce_m.stce023_desc
            IF NOT cl_null(g_stce_m.stce023) THEN
               IF g_stce_m.stce023 <> g_stce_m_o.stce023 OR cl_null(g_stce_m_o.stce023) THEN   #170202-00019#1 170202 by 02749 add
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = '1'
                  LET g_chkparam.arg1 = g_stce_m.stce023
                  
                  #160318-00025#37  2016/04/19  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "apm-00184:sub-01302|aooi714|",cl_get_progname("aooi714",g_lang,"2"),"|:EXEPROGaooi714"
                  #160318-00025#37  2016/04/19  by pengxin  add(E)
                  
                  IF NOT cl_chk_exist("v_ooib002_1") THEN
                    #LET g_stce_m.stce023 = g_stce_m_t.stce023   #170202-00019#1 170202 by 02749 mark
                     LET g_stce_m.stce023 = g_stce_m_o.stce023   #170202-00019#1 170202 by 02749 add
                     DISPLAY BY NAME g_stce_m.stce023            #170202-00019#1 170202 by 02749 add
                     CALL astm601_stce023_ref()
                     NEXT FIELD stce023
                  END IF
               END IF   #170202-00019#1 170202 by 02749 add   
            END IF
            CALL astm601_stce023_ref()
            
            LET g_stce_m_o.stce023 = g_stce_m.stce023   #170202-00019#1 170202 by 02749 add
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stce023
            #add-point:ON CHANGE stce023
            
            #END add-point
 
         #----<<stce006>>----
         #此段落由子樣板a02產生
         AFTER FIELD stce006
            
            #add-point:AFTER FIELD stce006
            LET g_stce_m.stce006_desc = ''
            DISPLAY BY NAME g_stce_m.stce006_desc
            IF NOT cl_null(g_stce_m.stce006) THEN
               IF g_stce_m.stce006 <> g_stce_m_o.stce006 OR cl_null(g_stce_m_o.stce006) THEN   #170202-00019#1 170202 by 02749 add
                 IF NOT astm601_stce006_chk(g_stce_m.stce006)THEN 
                   #LET g_stce_m.stce006 = g_stce_m_t.stce006   #170202-00019#1 170202 by 02749 mark
                    LET g_stce_m.stce006 = g_stce_m_o.stce006   #170202-00019#1 170202 by 02749 add
                    DISPLAY BY NAME g_stce_m.stce006            #170202-00019#1 170202 by 02749 add
                    
                    CALL astm601_stce006_ref()
                    NEXT FIELD stce006
                 END IF   
                  #计算下次计算日
                 IF NOT astm601_stce017_018_chk(p_cmd,'stce006') THEN
                   #LET g_stce_m.stce017 = g_stce_m_t.stce017   #170202-00019#1 170202 by 02749 mark
                    LET g_stce_m.stce017 = g_stce_m_o.stce017   #170202-00019#1 170202 by 02749 add
                    DISPLAY BY NAME g_stce_m.stce017            #170202-00019#1 170202 by 02749 add
                    NEXT FIELD stce017
                 END IF               
              END IF   #170202-00019#1 170202 by 02749 add   
            END IF
            CALL astm601_stce006_ref()
            
            LET g_stce_m_o.stce006 = g_stce_m.stce006   #170202-00019#1 170202 by 02749 add
            LET g_stce_m_o.stce017 = g_stce_m.stce017   #170202-00019#1 170202 by 02749 add
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD stce006
            #add-point:BEFORE FIELD stce006
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE stce006
            #add-point:ON CHANGE stce006
            
            #END add-point
 
         #----<<stce007>>----
         #此段落由子樣板a02產生
         AFTER FIELD stce007
            
            #add-point:AFTER FIELD stce007
            IF NOT cl_null(g_stce_m.stce007) THEN
               IF NOT astm601_stce007_chk(g_stce_m.stce007)THEN 
                  LET g_stce_m.stce007 = g_stce_m_t.stce007
                  CALL astm601_stce007_ref()
                  NEXT FIELD stce007
               END IF
               IF NOT astm601_b_chk() THEN
                  LET g_stce_m.stce007 = g_stce_m_t.stce007
                  CALL astm601_stce007_ref()
                  NEXT FIELD stce007
               END IF
            END IF
            CALL astm601_stce007_ref()

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD stce007
            #add-point:BEFORE FIELD stce007
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE stce007
            #add-point:ON CHANGE stce007
            
            #END add-point
 
         #----<<stce024>>----
         #此段落由子樣板a02產生
         AFTER FIELD stce024
            
            #add-point:AFTER FIELD stce024
            IF NOT cl_null(g_stce_m.stce024) THEN
               IF g_stce_m.stce024 <> g_stce_m_o.stce024 OR cl_null(g_stce_m_o.stce024) THEN   #170202-00019#1 170202 by 02749 add
                  #IF NOT astm601_stce024_chk(g_stce_m.stce024)THEN 
                  #   LET g_stce_m.stce024 = g_stce_m_t.stce024
                  #   CALL astm601_stce024_ref()
                  #   NEXT FIELD stce024
                  #END IF
                  IF s_aooi500_setpoint(g_prog,'stce024') THEN
                     CALL s_aooi500_chk(g_prog,'stce024',g_stce_m.stce024,g_site) RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = g_stce_m.stce024
                        LET g_errparam.code   = l_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        
                       #LET g_stce_m.stce024 = g_stce_m_t.stce024   #170202-00019#1 170202 by 02749 mark
                        LET g_stce_m.stce024 = g_stce_m_o.stce024   #170202-00019#1 170202 by 02749 add 
                        CALL s_desc_get_department_desc(g_stce_m.stce024) RETURNING g_stce_m.stce024_desc
                        DISPLAY BY NAME g_stce_m.stce024,g_stce_m.stce024_desc
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     IF NOT astm601_stce024_chk(g_stce_m.stce024)THEN 
                       #LET g_stce_m.stce024 = g_stce_m_t.stce024   #170202-00019#1 170202 by 02749 mark
                        LET g_stce_m.stce024 = g_stce_m_o.stce024   #170202-00019#1 170202 by 02749 add 
                        DISPLAY BY NAME g_stce_m.stce024            #170202-00019#1 170202 by 02749 add 
                        CALL astm601_stce024_ref()
                        NEXT FIELD stce024
                     END IF
                  END IF 
               END IF   #170202-00019#1 170202 by 02749 add   
            END IF
            CALL astm601_stce024_ref()
 
            LET g_stce_m_o.stce024 = g_stce_m.stce024   #170202-00019#1 170202 by 02749 add 
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD stce024
            #add-point:BEFORE FIELD stce024
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE stce024
            #add-point:ON CHANGE stce024
            
            
         AFTER FIELD stce028  
            IF NOT cl_null(g_stce_m.stce028) THEN
              #IF NOT cl_null(t_stce.stce028) AND t_stce.stce028 <> g_stce_m.stce028 THEN           #170202-00019#1 170202 by 02749 mark
               IF NOT cl_null(g_stce_m_o.stce028) AND g_stce_m.stce028 <> g_stce_m_o.stce028 THEN   #170202-00019#1 170202 by 02749 add
                  #单身经营范围不为空，不可更改
                  SELECT COUNT(*) INTO l_n  FROM stch_t 
                   WHERE stchent = g_enterprise AND stch001 = g_stce_m.stce001 
                  IF l_n > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ast-00217'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_stce_m.stce028 = t_stce.stce028       #170202-00019#1 170202 by 02749 mark
                     LET g_stce_m.stce028 = g_stce_m_o.stce028   #170202-00019#1 170202 by 02749 add
                     DISPLAY BY NAME g_stce_m.stce028            #170202-00019#1 170202 by 02749 add 
                     CALL astm601_stce028_ref()                  #170202-00019#1 170202 by 02749 add 
                     NEXT FIELD stce028
                  END IF 

                  #170202-00019#1 170202 by 02749 add---(S)
                  IF NOT astm601_stce028_chk() THEN
                     LET g_stce_m.stce028 = g_stce_m_o.stce028  
                     DISPLAY BY NAME g_stce_m.stce028           
                     CALL astm601_stce028_ref()
                     NEXT FIELD stce028
                  END IF
                  #170202-00019#1 170202 by 02749 add---(E)
               END IF
               
               #170202-00019#1 170202 by 02749 mark---(S)
               #納入新舊值不相等時才做校驗
               #IF NOT astm601_stce028_chk() THEN
               #   LET g_stce_m.stce028 = g_stce_m_t.stce028   
               #   CALL astm601_stce028_ref()
               #   NEXT FIELD stce028
               #END IF
               #LET t_stce.stce028 = g_stce_m.stce028    
               #170202-00019#1 170202 by 02749 mark---(E)
            END IF
            CALL astm601_stce028_ref()   

            LET g_stce_m_o.stce028 = g_stce_m.stce028   #170202-00019#1 170202 by 02749 add
            #END add-point
 
         #----<<stce025>>----
         #此段落由子樣板a02產生
         AFTER FIELD stce025
            
            #add-point:AFTER FIELD stce025
            IF NOT cl_null(g_stce_m.stce025) THEN
               IF g_stce_m.stce025 <> g_stce_m_o.stce025 OR cl_null(g_stce_m_o.stce025) THEN   #170202-00019#1 170202 by 02749 add
                  #IF NOT astm601_stce025_chk(g_stce_m.stce025)THEN 
                  #   LET g_stce_m.stce025 = g_stce_m_t.stce025
                  #   CALL astm601_stce025_ref()
                  #   NEXT FIELD stce025
                  #END IF
                  IF s_aooi500_setpoint(g_prog,'stce025') THEN
                     CALL s_aooi500_chk(g_prog,'stce025',g_stce_m.stce025,g_site) RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = g_stce_m.stce025
                        LET g_errparam.code   = l_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        
                       #LET g_stce_m.stce025 = g_stce_m_t.stce025   #170202-00019#1 170202 by 02749 mark
                        LET g_stce_m.stce025 = g_stce_m_o.stce025   #170202-00019#1 170202 by 02749 add
                        CALL s_desc_get_department_desc(g_stce_m.stce025) RETURNING g_stce_m.stce025_desc
                        DISPLAY BY NAME g_stce_m.stce025,g_stce_m.stce025_desc
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     IF NOT astm601_stce025_chk(g_stce_m.stce025)THEN 
                       #LET g_stce_m.stce025 = g_stce_m_t.stce025   #170202-00019#1 170202 by 02749 mark
                        LET g_stce_m.stce025 = g_stce_m_o.stce025   #170202-00019#1 170202 by 02749 add
                        DISPLAY BY NAME g_stce_m.stce025            #170202-00019#1 170202 by 02749 add
                        CALL astm601_stce025_ref()
                        NEXT FIELD stce025
                     END IF
                  END IF 
               END IF   #170202-00019#1 170202 by 02749 add   
            END IF
            CALL astm601_stce025_ref()

            LET g_stce_m_o.stce025 = g_stce_m.stce025   #170202-00019#1 170202 by 02749 add   
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD stce025
            #add-point:BEFORE FIELD stce025
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE stce025
            #add-point:ON CHANGE stce025
            
            #END add-point
 
         #----<<stce026>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stce026
            #add-point:BEFORE FIELD stce026
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stce026
            
            #add-point:AFTER FIELD stce026
            IF NOT cl_null(g_stce_m.stce026) THEN
               IF g_stce_m.stce026 <> g_stce_m_o.stce026 OR cl_null(g_stce_m_o.stce026) THEN   #170202-00019#1 170202 by 02749 add
                  #IF NOT astm601_stce026_chk(g_stce_m.stce026)THEN 
                  #   LET g_stce_m.stce026 = g_stce_m_t.stce026
                  #   CALL astm601_stce026_ref()
                  #   NEXT FIELD stce026
                  #END IF
                  IF s_aooi500_setpoint(g_prog,'stce026') THEN
                     CALL s_aooi500_chk(g_prog,'stce026',g_stce_m.stce026,g_site) RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = g_stce_m.stce026 
                        LET g_errparam.code   = l_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        
                       #LET g_stce_m.stce026 = g_stce_m_t.stce026   #170202-00019#1 170202 by 02749 mark
                        LET g_stce_m.stce026 = g_stce_m_o.stce026   #170202-00019#1 170202 by 02749 add
                        CALL s_desc_get_department_desc(g_stce_m.stce026) RETURNING g_stce_m.stce026_desc
                        DISPLAY BY NAME g_stce_m.stce026,g_stce_m.stce026_desc
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     IF NOT astm601_stce026_chk(g_stce_m.stce026)THEN 
                       #LET g_stce_m.stce026 = g_stce_m_t.stce026   #170202-00019#1 170202 by 02749 mark
                        LET g_stce_m.stce026 = g_stce_m_o.stce026   #170202-00019#1 170202 by 02749 add
                        DISPLAY BY NAME g_stce_m.stce026            #170202-00019#1 170202 by 02749 add
                        CALL astm601_stce026_ref()
                        NEXT FIELD stce026
                     END IF
                  END IF
               END IF   #170202-00019#1 170202 by 02749 add   
            END IF
            CALL astm601_stce026_ref()   
            
            LET g_stce_m_o.stce026 = g_stce_m.stce026   #170202-00019#1 170202 by 02749 add
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stce026
            #add-point:ON CHANGE stce026
            
            #END add-point
 
         #----<<stce013>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stce013
            #add-point:BEFORE FIELD stce013
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stce013
            
            #add-point:AFTER FIELD stce013
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stce013
            #add-point:ON CHANGE stce013
            
            #END add-point
 
         #----<<stce014>>----
         #此段落由子樣板a02產生
         AFTER FIELD stce014
            
            #add-point:AFTER FIELD stce014
            LET g_stce_m.stce014_desc = ''
            DISPLAY BY NAME g_stce_m.stce014_desc
            IF NOT cl_null(g_stce_m.stce014) THEN
#               IF NOT astm601_stce014_chk(g_stce_m.stce014) THEN
#                  LET g_stce_m.stce014 = g_stce_m_t.stce014
#                  CALL astm601_stce014_ref()
#                  NEXT FIELD stce014
#               END IF
               IF s_aooi500_setpoint(g_prog,'stce014') THEN
                  CALL s_aooi500_chk(g_prog,'stce014',g_stce_m.stce014,g_site) RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_stce_m.stce014
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     
                     LET g_stce_m.stce014 = g_stce_m_t.stce014
                     CALL s_desc_get_department_desc(g_stce_m.stce014) RETURNING g_stce_m.stce014_desc
                     DISPLAY BY NAME g_stce_m.stce014,g_stce_m.stce014_desc
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  IF NOT astm601_stce014_chk(g_stce_m.stce014) THEN
                     LET g_stce_m.stce014 = g_stce_m_t.stce014
                     CALL astm601_stce014_ref()
                     NEXT FIELD stce014
                  END IF
               END IF 
            END IF
            CALL astm601_stce014_ref()
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD stce014
            #add-point:BEFORE FIELD stce014
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE stce014
            #add-point:ON CHANGE stce014
            
            #END add-point
 
         #----<<stce015>>----
         #此段落由子樣板a02產生
         AFTER FIELD stce015
            
            #add-point:AFTER FIELD stce015
                        LET g_stce_m.stce015_desc = ''
            DISPLAY BY NAME g_stce_m.stce015_desc 
            IF NOT cl_null(g_stce_m.stce015) THEN
               IF NOT astm601_stce015_chk(g_stce_m.stce015) THEN
                  LET g_stce_m.stce015 = g_stce_m_t.stce015
                  CALL astm601_stce015_ref()
                  NEXT FIELD stce015
               END IF
            END IF
            CALL astm601_stce015_ref()

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD stce015
            #add-point:BEFORE FIELD stce015
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE stce015
            #add-point:ON CHANGE stce015
            
            #END add-point
 
 
         AFTER FIELD stce016
            LET g_stce_m.stce016_desc = ''
            DISPLAY BY NAME g_stce_m.stce016_desc
            IF NOT cl_null(g_stce_m.stce016) THEN
       
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_stce_m.stce016
               LET g_chkparam.arg2 = g_stce_m.stce013
 
               #160318-00025#37  2016/04/19  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#37  2016/04/19  by pengxin  add(E)
 
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooeg001") THEN
                  LET g_stce_m.stce016 = g_stce_m_t.stce016
                  CALL astm601_stce016_ref()
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
 
            END IF
            CALL astm601_stce016_ref()
 
           
           
         #----<<stce017>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stce017
            #add-point:BEFORE FIELD stce017
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stce017
            
            #add-point:AFTER FIELD stce017
            IF NOT cl_null(g_stce_m.stce017) THEN
               IF g_stce_m.stce017 <> g_stce_m_o.stce017 OR cl_null(g_stce_m_o.stce017) THEN   #170202-00019#1 170202 by 02749 add
                 IF NOT astm601_stce017_018_chk(p_cmd,"stce017") THEN
                   #LET g_stce_m.stce017 = g_stce_m_t.stce017   #170202-00019#1 170202 by 02749 mark
                    LET g_stce_m.stce017 = g_stce_m_o.stce017   #170202-00019#1 170202 by 02749 add
                    DISPLAY BY NAME g_stce_m.stce017            #170202-00019#1 170202 by 02749 add
                    NEXT FIELD stce017
                 END IF
                 
                #IF NOT cl_null(g_stce_m.next_b) AND cl_null(g_stce_m.stce010)  THEN
                #   IF g_stce_m.stce017 > g_stce_m.next_b THEN
                #      INITIALIZE g_errparam TO NULL
                #      LET g_errparam.code = 'ast-00126'
                #      LET g_errparam.extend = ''
                #      LET g_errparam.popup = TRUE
                #      CALL cl_err()
                #      LET g_stce_m.stce017 = g_stce_m_t.stce017
                #      NEXT FIELD stce017
                #   END IF
                #END IF
                # IF NOT cl_null(g_stce_m.stce009) AND NOT cl_null(g_stce_m.stce018) THEN
                #    IF NOT astm601_interval_chk(p_cmd) THEN
                #        LET g_stce_m.stce017 = g_stce_m_t.stce017
                #        NEXT FIELD stce017
                #    END IF        
                # END IF 
                 
                #IF NOT cl_null(g_stce_m.stce018) AND p_cmd = 'a' THEN
                #   IF s_date_get_last_date(g_stce_m.stce017) >= g_stce_m.stce018 THEN
                #      LET g_stce_m.next_b = g_stce_m.stce018
                #   ELSE
                #      LET g_stce_m.next_b = s_date_get_last_date(g_stce_m.stce017)
                #   END IF
                #   DISPLAY g_stce_m.next_b TO next_b
                #END IF
               END IF   #170202-00019#1 170202 by 02749 add  
            END IF
            
            LET g_stce_m_o.stce017 = g_stce_m.stce017   #170202-00019#1 170202 by 02749 add
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stce017
            #add-point:ON CHANGE stce017
            
            #END add-point
 
         #----<<stce018>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stce018
            #add-point:BEFORE FIELD stce018
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stce018
            
            #add-point:AFTER FIELD stce018
            IF NOT cl_null(g_stce_m.stce018) THEN
               IF g_stce_m.stce018 <> g_stce_m_o.stce018 OR cl_null(g_stce_m_o.stce018) THEN   #170202-00019#1 170202 by 02749 add
                 IF NOT astm601_stce017_018_chk(p_cmd,"stce018") THEN
                   #LET g_stce_m.stce018 = g_stce_m_t.stce018   #170202-00019#1 170202 by 02749 mark
                    LET g_stce_m.stce018 = g_stce_m_o.stce018   #170202-00019#1 170202 by 02749 add
                    DISPLAY BY NAME g_stce_m.stce018            #170202-00019#1 170202 by 02749 add 
                    NEXT FIELD stce018
                 END IF
                #IF NOT cl_null(g_stce_m.next_b) AND cl_null(g_stce_m.stce010) THEN
                #   IF g_stce_m.stce018 < g_stce_m.next_b THEN
                #      INITIALIZE g_errparam TO NULL
                #      LET g_errparam.code = 'ast-00127'
                #      LET g_errparam.extend = ''
                #      LET g_errparam.popup = TRUE
                #      CALL cl_err()
                #      LET g_stce_m.stce018 = g_stce_m_t.stce018
                #      NEXT FIELD stce018
                #   END IF
                #END IF
                # IF NOT cl_null(g_stce_m.stce009) AND NOT cl_null(g_stce_m.stce017) THEN
                #    IF NOT astm601_interval_chk(p_cmd) THEN
                #        LET g_stce_m.stce018 = g_stce_m_t.stce018
                #        NEXT FIELD stce018
                #    END IF        
                # END IF   
                #IF NOT cl_null(g_stce_m.stce017) AND p_cmd = 'a' THEN
                #   IF s_date_get_last_date(g_stce_m.stce017) >= g_stce_m.stce018 THEN
                #      LET g_stce_m.next_b = g_stce_m.stce018
                #   ELSE
                #      LET g_stce_m.next_b = s_date_get_last_date(g_stce_m.stce017)
                #   END IF
                #   DISPLAY g_stce_m.next_b TO next_b
                #END IF
               END IF   #170202-00019#1 170202 by 02749 add
            END IF
            
            LET g_stce_m_o.stce018 = g_stce_m.stce018   #170202-00019#1 170202 by 02749 add
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stce018
            #add-point:ON CHANGE stce018
            
            #END add-point
 
         BEFORE FIELD next_b
         
         
         
         AFTER FIELD next_b
           IF NOT cl_null(g_stce_m.next_b) THEN
              IF g_stce_m.next_b < g_stce_m.stce017 OR g_stce_m.next_b > g_stce_m.stce018 THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'ast-00047'
                 LET g_errparam.extend = ''
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
 
                 LET g_stce_m.next_b = g_stce_m_t.next_b  
                 NEXT FIELD next_b
              END IF
              
              #IF NOT cl_null(g_stce_m.stce001) AND NOT cl_null(g_stce_m.stce017) AND NOT cl_null(g_stce_m.stce018)  AND NOT cl_null(g_stce_m.stce006) AND NOT cl_null(g_stce_m.stcesite) AND NOT cl_null(g_stce_m.stceunit)
              #          AND (g_stce_m.next_b <> t_stce.next_b AND NOT cl_null(t_stce.next_b))   THEN
              #   SELECT COUNT(*) INTO l_n FROM stcw_t WHERE stcwent = g_enterprise AND stcw001 = g_stce_m.stce001 AND stcw005 = 'N'
              #   IF l_n > 0 THEN
              #      IF cl_ask_confirm('ast-00097') THEN
              #         IF NOT s_astm601_cal_period(g_stce_m.stce001,g_stce_m.stce017,g_stce_m.stce018,g_stce_m.stce006,g_stce_m.next_b,g_stce_m.stcesite,g_stce_m.stceunit) THEN
              #             INITIALIZE g_errparam TO NULL
              #             LET g_errparam.code = 'ast-00049'
              #             LET g_errparam.extend = ''
              #             LET g_errparam.popup = TRUE
              #             CALL cl_err()
              #
              #             LET g_stce_m.next_b = g_stce_m_t.next_b                   
              #         ELSE
              #             CALL astm601_b_fill()
              #         END IF
              #      ELSE
              #         LET g_stce_m.next_b = g_stce_m_t.next_b
              #         NEXT FIELD next_b
              #      END IF
              #   END IF                 
              #END IF
              #LET t_stce.next_b = g_stce_m.next_b         
           END IF
 
 
         #----<<stce019>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stce019
            #add-point:BEFORE FIELD stce019
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stce019
            
            #add-point:AFTER FIELD stce019
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stce019
            #add-point:ON CHANGE stce019
            
            #END add-point
 
         #----<<stce020>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stce020
            #add-point:BEFORE FIELD stce020
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stce020
            
            #add-point:AFTER FIELD stce020
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stce020
            #add-point:ON CHANGE stce020
            
            #END add-point
 
         #----<<stcestus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcestus
            #add-point:BEFORE FIELD stcestus
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcestus
            
            #add-point:AFTER FIELD stcestus
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stcestus
            #add-point:ON CHANGE stcestus
            
            #END add-point
 
         #----<<stceownid>>----
         #----<<stceowndp>>----
         #----<<stcecrtid>>----
         #----<<stcecrtdp>>----
         #----<<stcecrtdt>>----
         #----<<stcemodid>>----
         #----<<stcemoddt>>----
         #----<<stcecnfid>>----
         #----<<stcecnfdt>>----
 #欄位檢查
         #---------------------------<  Master  >---------------------------
         #----<<stce005>>----
         #Ctrlp:input.c.stce005
         ON ACTION controlp INFIELD stce005
            #add-point:ON ACTION controlp INFIELD stce005
            
            #END add-point
 
         #----<<stce001>>----
         #Ctrlp:input.c.stce001
         ON ACTION controlp INFIELD stce001
            #add-point:ON ACTION controlp INFIELD stce001
            
            #END add-point
 
         #----<<stce002>>----
         #Ctrlp:input.c.stce002
         ON ACTION controlp INFIELD stce002
            #add-point:ON ACTION controlp INFIELD stce002
            
            #END add-point
 
         #----<<stce003>>----
         #Ctrlp:input.c.stce003
         ON ACTION controlp INFIELD stce003
            #add-point:ON ACTION controlp INFIELD stce003
            
            #END add-point
 
         #----<<stce009>>----
         #Ctrlp:input.c.stce009
         ON ACTION controlp INFIELD stce009
            #add-point:ON ACTION controlp INFIELD stce009
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stce_m.stce009             #給予default值

            CALL q_pmaa001_21()                                #呼叫開窗

            LET g_stce_m.stce009 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_stce_m.stce009 TO stce009              #顯示到畫面上
            CALL astm601_stce009_ref()
            NEXT FIELD stce009                          #返回原欄位


           
      
         ON ACTION controlp INFIELD stce010
            #add-point:ON ACTION controlp INFIELD stce010
            #此段落由子樣板a07產生            
            #開窗i段
		      INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stce_m.stce010             #給予default值
            IF cl_null(g_stce_m.stce009) THEN
               CALL q_pmaa001_18()               #呼叫開窗
            ELSE
               LET g_qryparam.arg1 = g_stce_m.stce009
               CALL q_pmaa001_22() 
            END IF   

            LET g_stce_m.stce010 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_stce_m.stce010 TO stce010              #顯示到畫面上
            CALL astm601_stce010_ref()
            NEXT FIELD stce010                          #返回原欄位


          ON ACTION controlp INFIELD stce012
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stce_m.stce012             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "1"
            CALL q_oojd001_1()                                #呼叫開窗

            LET g_stce_m.stce012 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_stce_m.stce012 TO pmaa231              #顯示到畫面上
            CALL s_desc_get_oojdl003_desc(g_stce_m.stce012) RETURNING g_stce_m.stce012_desc
            DISPLAY BY NAME g_stce_m.stce012_desc
            NEXT FIELD stce012                          #返回原欄位
            #END add-point
 
 
         #----<<stce004>>----
         #Ctrlp:input.c.stce004
         ON ACTION controlp INFIELD stce004
            #add-point:ON ACTION controlp INFIELD stce004
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stce_m.stce004             #給予default值
            LET g_qryparam.default2 = "" #g_stce_m.stagl003 #說明
            LET g_qryparam.where = " stag002 IN ('11','12','13')"
            #給予arg

            CALL q_stag001()                                #呼叫開窗
            LET g_qryparam.where = '' 
            LET g_stce_m.stce004 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_stce_m.stagl003 = g_qryparam.return2 #說明

            DISPLAY g_stce_m.stce004 TO stce004              #顯示到畫面上
            #DISPLAY g_stce_m.stagl003 TO stagl003 #說明
            CALL astm601_stce004_ref()
            NEXT FIELD stce004                          #返回原欄位


            #END add-point
 
         #----<<stceunit>>----
         #Ctrlp:input.c.stceunit
         ON ACTION controlp INFIELD stceunit
            #add-point:ON ACTION controlp INFIELD stceunit
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stce_m.stceunit              #給予default值

            #給予arg

            LET g_qryparam.where = s_aooi500_q_where(g_prog,'stceunit',g_site,'i')
            CALL q_ooef001_24()                                #呼叫開窗

            LET g_stce_m.stceunit = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_stce_m.stceunit TO stceunit              #顯示到畫面上
            CALL s_desc_get_department_desc(g_stce_m.stceunit)
               RETURNING g_stce_m.stceunit_desc
            DISPLAY BY NAME g_stce_m.stceunit_desc

            NEXT FIELD stceunit
            
            
         ON ACTION controlp INFIELD stce027
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stce_m.stce027 
            IF NOT cl_null(g_stce_m.stce005) THEN 
               LET g_qryparam.where = " stce005 = '",g_stce_m.stce005,"'"              
            END IF 
            IF NOT cl_null(g_stce_m.stce009) THEN 
               LET g_qryparam.where = " stce009 = '",g_stce_m.stce009,"'"     
            END IF            
            CALL q_stce001_4()                                #呼叫開窗

            LET g_stce_m.stce027 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_stce_m.stce027 TO stce027             #顯示到畫面上

            NEXT FIELD stce027                          #返回原欄位
         
         
            #END add-point
 
         #----<<stce021>>----
         #Ctrlp:input.c.stce021
         ON ACTION controlp INFIELD stce021
            #add-point:ON ACTION controlp INFIELD stce021
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stce_m.stce021             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_site
            CALL q_ooaj002_1()                                #呼叫開窗

            LET g_stce_m.stce021 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_stce_m.stce021 TO stce021              #顯示到畫面上
            CALL astm601_stce021_ref()
            NEXT FIELD stce021                          #返回原欄位


            #END add-point
 
         #----<<stce022>>----
         #Ctrlp:input.c.stce022
         ON ACTION controlp INFIELD stce022
            #add-point:ON ACTION controlp INFIELD stce022
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stce_m.stce022             

            #給予arg
            LET g_qryparam.arg1 = g_site #

            CALL q_oodb002_1()                                #呼叫開窗

            LET g_stce_m.stce022 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_stce_m.stce022 TO stce022             #顯示到畫面上
            CALL astm601_stce022_ref()
            NEXT FIELD stce022                          #返回原欄位
            #END add-point
 
         #----<<stce023>>----
         #Ctrlp:input.c.stce023
         ON ACTION controlp INFIELD stce023
            #add-point:ON ACTION controlp INFIELD stce023
             INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stce_m.stce023            

            CALL q_ooib002_2()                               #呼叫開窗

            LET g_stce_m.stce023 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_stce_m.stce023 TO stce023             #顯示到畫面上
            CALL astm601_stce023_ref()
            NEXT FIELD stce023                         #返回原欄位
            #END add-point
 
         #----<<stce006>>----
         #Ctrlp:input.c.stce006
         ON ACTION controlp INFIELD stce006
            #add-point:ON ACTION controlp INFIELD stce006
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stce_m.stce006             #給予default值

            #給予arg

            CALL q_staa001()                                #呼叫開窗

            LET g_stce_m.stce006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_stce_m.stce006 TO stce006              #顯示到畫面上
            CALL astm601_stce006_ref()
            NEXT FIELD stce006                          #返回原欄位


            #END add-point
 
         #----<<stce007>>----
         #Ctrlp:input.c.stce007
         ON ACTION controlp INFIELD stce007
            #add-point:ON ACTION controlp INFIELD stce007
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stce_m.stce007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2060" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_stce_m.stce007 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_stce_m.stce007 TO stce007              #顯示到畫面上
            CALL astm601_stce007_ref()
            NEXT FIELD stce007                          #返回原欄位


            #END add-point
 
         #----<<stce024>>----
         #Ctrlp:input.c.stce024
         ON ACTION controlp INFIELD stce024
            #add-point:ON ACTION controlp INFIELD stce024
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stce_m.stce024             #給予default值

            #給予arg    
            #LET g_qryparam.arg1 = 'A'
#            LET g_qryparam.where = "ooef212 = 'Y'"
#            CALL q_ooef001()                                #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'stce024') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stce024',g_site,'i')
               CALL q_ooef001_24() 
            ELSE
               LET g_qryparam.where = "ooef212 = 'Y'"
               CALL q_ooef001() 
            END IF

            LET g_stce_m.stce024 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_stce_m.stce024 TO stce024              #顯示到畫面上
            CALL astm601_stce024_ref()
            NEXT FIELD stce024                          #返回原欄位


          ON ACTION controlp INFIELD stce028
            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stce_m.stce028             #給予default值
            
            CALL q_dbbc001()                                #呼叫開窗

            LET g_stce_m.stce028 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_stce_m.stce028 TO stce028              #顯示到畫面上
            CALL astm601_stce028_ref()
            NEXT FIELD stce028                          #返回原欄位            


            #END add-point
 
         #----<<stce025>>----
         #Ctrlp:input.c.stce025
         ON ACTION controlp INFIELD stce025
            #add-point:ON ACTION controlp INFIELD stce025
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		    	LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_stce_m.stce025             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = '2'  
#            LET g_qryparam.where = "ooef208 = 'Y'"
#            CALL q_ooef001()                                #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'stce025') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stce025',g_site,'i')
               CALL q_ooef001_24() 
            ELSE
               LET g_qryparam.where = "ooef208 = 'Y'"
               CALL q_ooef001() 
            END IF
            LET g_stce_m.stce025 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_stce_m.stce025 TO stce025              #顯示到畫面上
            CALL astm601_stce025_ref()
            NEXT FIELD stce025                          #返回原欄位


            #END add-point
 
         #----<<stce026>>----
         #Ctrlp:input.c.stce026
         ON ACTION controlp INFIELD stce026
            #add-point:ON ACTION controlp INFIELD stce026
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stce_m.stce026             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = '2'  
#            LET g_qryparam.where = "ooef208 = 'Y'"
#            CALL q_ooef001()                                #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'stce026') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stce026',g_site,'i')
               CALL q_ooef001_24() 
            ELSE
               #LET g_qryparam.where = "ooef208 = 'Y'"   #161024-00025#2 mark
               LET g_qryparam.where = "ooef201 = 'Y'"    #161024-00025#2 add               
               CALL q_ooef001() 
            END IF
            LET g_stce_m.stce026 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_stce_m.stce026 TO stce026              #顯示到畫面上
            CALL astm601_stce026_ref()
            NEXT FIELD stce026                          #返回原欄位
            #END add-point
 
         #----<<stce013>>----
         #Ctrlp:input.c.stce013
         ON ACTION controlp INFIELD stce013
            #add-point:ON ACTION controlp INFIELD stce013
            
            #END add-point
 
         #----<<stce014>>----
         #Ctrlp:input.c.stce014
         ON ACTION controlp INFIELD stce014
            #add-point:ON ACTION controlp INFIELD stce014
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stce_m.stce014             #給予default值

            #給予arg
           # LET g_qryparam.arg1 = '1'
#            LET g_qryparam.where = "ooef003 = 'Y'"
#            CALL q_ooef001()                                #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'stce014') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stce014',g_site,'i')
               CALL q_ooef001_24() 
            ELSE
               LET g_qryparam.where = "ooef003 = 'Y'"
               CALL q_ooef001() 
            END IF

            LET g_stce_m.stce014 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_stce_m.stce014 TO stce014              #顯示到畫面上
            CALL astm601_stce014_ref()
            NEXT FIELD stce014                          #返回原欄位


            #END add-point
 
         #----<<stce015>>----
         #Ctrlp:input.c.stce015
         ON ACTION controlp INFIELD stce015
            #add-point:ON ACTION controlp INFIELD stce015
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stce_m.stce015             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_stce_m.stce015 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_stce_m.stce015 TO stce015              #顯示到畫面上
            CALL astm601_stce015_ref()
            NEXT FIELD stce015                          #返回原欄位


       ON ACTION controlp INFIELD stce016
            #add-point:ON ACTION controlp INFIELD stce015
            #此段落由子樣板a07產生            
             #開窗i段
		      INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stce_m.stce016             #給予default值
            LET g_qryparam.arg1 = g_stce_m.stce013
            #給予arg

            CALL q_ooeg001()                                 #呼叫開窗

            LET g_stce_m.stce016 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_stce_m.stce016 TO stce016              #顯示到畫面上
            CALL astm601_stce016_ref()
            NEXT FIELD stce016                          #返回原欄位



            #END add-point
 
         #----<<stce017>>----
         #Ctrlp:input.c.stce017
         ON ACTION controlp INFIELD stce017
            #add-point:ON ACTION controlp INFIELD stce017
            
            #END add-point
 
         #----<<stce018>>----
         #Ctrlp:input.c.stce018
         ON ACTION controlp INFIELD stce018
            #add-point:ON ACTION controlp INFIELD stce018
            
            #END add-point
 
         #----<<stce019>>----
         #Ctrlp:input.c.stce019
         ON ACTION controlp INFIELD stce019
            #add-point:ON ACTION controlp INFIELD stce019
            
            #END add-point
 
         #----<<stce020>>----
         #Ctrlp:input.c.stce020
         ON ACTION controlp INFIELD stce020
            #add-point:ON ACTION controlp INFIELD stce020
            
            #END add-point
 
         #----<<stcestus>>----
         #Ctrlp:input.c.stcestus
         ON ACTION controlp INFIELD stcestus
            #add-point:ON ACTION controlp INFIELD stcestus
            
            #END add-point
 
         #----<<stceownid>>----
         #----<<stceowndp>>----
         #----<<stcecrtid>>----
         #----<<stcecrtdp>>----
         #----<<stcecrtdt>>----
         #----<<stcemodid>>----
         #----<<stcemoddt>>----
         #----<<stcecnfid>>----
         #----<<stcecnfdt>>----
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            CALL cl_showmsg()      #錯誤訊息統整顯示
            DISPLAY BY NAME g_stce_m.stce001             
 
                            
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前
               IF l_cmd_t = 'r' THEN 
                  LET  g_stce_m.stceunit = g_site
               END IF
               
               IF NOT astm601_interval_chk(p_cmd) THEN
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF
              
               #网点不为空，检查生失效日是否在结算生效期内
               IF NOT cl_null( g_stce_m.stce010) AND NOT cl_null(g_stce_m.stce027)  THEN
                  SELECT stce017,stce018 INTO l_stce017,l_stce018 FROM stce_t
                   WHERE stceent = g_enterprise AND stce001 = g_stce_m.stce027
                  IF NOT (l_stce017 <= g_stce_m.stce017 AND l_stce018 >=  g_stce_m.stce018) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ast-00119"
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     NEXT FIELD stce017
                  END IF                 
               END IF
              
              
               IF cl_null(g_stce_m.stce010) THEN
                  IF NOT astm601_upd_stcw(p_cmd) THEN
                     CALL s_transaction_end('N','0')
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #add--2015/07/02 By shiun--(S)
               CALL s_aooi390_get_auto_no('26',g_stce_m.stce001) RETURNING l_success,g_stce_m.stce001
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF   
               DISPLAY BY NAME g_stce_m.stce001
               #add--2015/07/02 By shiun--(E)
               CALL s_aooi390_oofi_upd('26',g_stce_m.stce001) RETURNING l_success  #add--2015/05/08 By shiun 增加編碼功能
               #end add-point
               
               INSERT INTO stce_t (stceent,stce005,stce001,stce002,stce003,stce009,stce010,stce011,stce012,stce004,stceunit,stcesite, 
                   stce027,stce021,stce022,stce023,stce006,stce007,stce008,stce024,stce028,stce025,stce026,stce013,stce014,stce015, stce016,
                   stce017,stce018,stce019,stce020,stcestus,stceownid,stceowndp,stcecrtid,stcecrtdp, 
                   stcecrtdt,stcemodid,stcemoddt,stcecnfid,stcecnfdt)
               VALUES (g_enterprise,g_stce_m.stce005,g_stce_m.stce001,g_stce_m.stce002,g_stce_m.stce003, 
                   g_stce_m.stce009,g_stce_m.stce010,g_stce_m.stce011,g_stce_m.stce012,g_stce_m.stce004,g_stce_m.stceunit,g_site,g_stce_m.stce027,g_stce_m.stce021,g_stce_m.stce022, 
                   g_stce_m.stce023,g_stce_m.stce006,g_stce_m.stce007,g_stce_m.stce008,g_stce_m.stce024,g_stce_m.stce028,g_stce_m.stce025, 
                   g_stce_m.stce026,g_stce_m.stce013,g_stce_m.stce014,g_stce_m.stce015,g_stce_m.stce016,g_stce_m.stce017, 
                   g_stce_m.stce018,g_stce_m.stce019,g_stce_m.stce020,g_stce_m.stcestus,g_stce_m.stceownid, 
                   g_stce_m.stceowndp,g_stce_m.stcecrtid,g_stce_m.stcecrtdp,g_stce_m.stcecrtdt,g_stce_m.stcemodid, 
                   g_stce_m.stcemoddt,g_stce_m.stcecnfid,g_stce_m.stcecnfdt) 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "g_stce_m"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               
               #add-point:單頭新增中
               IF NOT cl_null(g_stce_m.ooff013) THEN
                     LET l_success = ''
                     CALL s_aooi360_gen('2',g_stce_m.stce001,'','','','','','','','','','4',g_stce_m.ooff013) RETURNING l_success
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "ooff_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        CONTINUE DIALOG
                     END IF
                  ELSE
                     CALL s_aooi360_del('2',g_stce_m.stce001,'','','','','','','','','','4') RETURNING l_success
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "ooff_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        CONTINUE DIALOG
                     END IF
                  END IF
               IF l_cmd_t <> 'r' THEN 
                 IF NOT cl_null(g_stce_m.stce004) THEN
                    CALL astm601_stce004_genb()
                    CALL astm601_b_fill()
                    LET l_ac3 = 1
                    CALL astm601_b3_fill()
                    CALL astm601_reflesh()
                 END IF
               END IF
              
              
               #end add-point
               
               
               
               CALL s_transaction_end('Y','0') 
               
               #add-point:單頭新增後
                             
               #end add-point
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL astm601_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
 
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前
               IF NOT astm601_interval_chk(p_cmd) THEN
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF
               
                #网点不为空，检查生失效日是否在结算生效期内
               IF NOT cl_null( g_stce_m.stce010) AND NOT cl_null(g_stce_m.stce027)  THEN
                  SELECT stce017,stce018 INTO l_stce017,l_stce018 FROM stce_t
                   WHERE stceent = g_enterprise AND stce001 = g_stce_m.stce027
                  IF NOT (l_stce017 <= g_stce_m.stce017 AND l_stce018 >=  g_stce_m.stce018) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ast-00119"
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     NEXT FIELD stce017
                  END IF                 
               END IF
               
               
            #   IF NOT cl_null(g_stce_m.stce001) AND NOT cl_null(g_stce_m.stce006) AND NOT cl_null(g_stce_m.stce017) AND NOT cl_null(g_stce_m.stce018)  AND NOT cl_null(g_stce_m.next_b) AND NOT cl_null(g_stce_m.stcesite) AND NOT cl_null(g_stce_m.stceunit)
            #       AND (g_stce_m.stce006 <> g_stce_m_t.stce006 OR g_stce_m.stce017 <> g_stce_m_t.stce017 OR g_stce_m.stce018 <> g_stce_m_t.stce018 OR g_stce_m.next_b<>g_stce_m_t.next_b )   THEN
            #      SELECT COUNT(*) INTO l_n FROM stcw_t WHERE stcwent = g_enterprise AND stcw001 = g_stce_m.stce001 AND stcw005 = 'N'
            #      IF l_n > 0 THEN
            #         IF cl_ask_confirm('ast-00097') THEN
            #            IF NOT s_astm601_cal_period(g_stce_m.stce001,g_stce_m.stce017,g_stce_m.stce018,g_stce_m.stce006,g_stce_m.next_b,g_stce_m.stcesite,g_stce_m.stceunit) THEN
            #                INITIALIZE g_errparam TO NULL
            #                LET g_errparam.code = 'ast-00049'
            #                LET g_errparam.extend = ''
            #                LET g_errparam.popup = TRUE
            #                CALL cl_err()              
            #                LET g_stce_m.stce006 = g_stce_m_t.stce006
            #                LET g_stce_m.stce017 = g_stce_m_t.stce017
            #                LET g_stce_m.stce018 = g_stce_m_t.stce018
            #                LET g_stce_m.next_b = g_stce_m_t.next_b
            #            ELSE
            #                CALL astm601_b_fill()
            #            END IF
            #         ELSE
            #            LET g_stce_m.stce006 = g_stce_m_t.stce006
            #            LET g_stce_m.stce017 = g_stce_m_t.stce017
            #            LET g_stce_m.stce018 = g_stce_m_t.stce018
            #            LET g_stce_m.next_b = g_stce_m_t.next_b
            #         END IF
            #      END IF                 
            #   END IF
               IF cl_null(g_stce_m.stce010) THEN
                  IF NOT astm601_upd_stcw(p_cmd) THEN
                     CALL s_transaction_end('N','0')
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
               IF cl_null(g_stce_m.stce002) THEN
                  LET g_stce_m.stce002 = 1
               END IF
               LET g_stce_m.stce002 =  g_stce_m.stce002+1
               LET g_stce_m.stce002 =  g_stce_m.stce002 USING "<<<<<<<<<#"
               
               
               
               #end add-point
               
               UPDATE stce_t SET (stce005,stce001,stce002,stce003,stce009,stce010,stce011,stce012,stce004,stceunit,stce027,stce021,stce022, 
                   stce023,stce006,stce007,stce008,stce024,stce028,stce025,stce026,stce013,stce014,stce015,stce016,stce017,stce018, 
                   stce019,stce020,stcestus,stceownid,stceowndp,stcecrtid,stcecrtdp,stcecrtdt,stcemodid, 
                   stcemoddt,stcecnfid,stcecnfdt) = (g_stce_m.stce005,g_stce_m.stce001,g_stce_m.stce002, 
                   g_stce_m.stce003,g_stce_m.stce009,g_stce_m.stce010,g_stce_m.stce011,g_stce_m.stce012,g_stce_m.stce004,g_stce_m.stceunit,g_stce_m.stce027,g_stce_m.stce021, 
                   g_stce_m.stce022,g_stce_m.stce023,g_stce_m.stce006,g_stce_m.stce007,g_stce_m.stce008,g_stce_m.stce024,g_stce_m.stce028,
                   g_stce_m.stce025,g_stce_m.stce026,g_stce_m.stce013,g_stce_m.stce014,g_stce_m.stce015, g_stce_m.stce016,
                   g_stce_m.stce017,g_stce_m.stce018,g_stce_m.stce019,g_stce_m.stce020,g_stce_m.stcestus, 
                   g_stce_m.stceownid,g_stce_m.stceowndp,g_stce_m.stcecrtid,g_stce_m.stcecrtdp,g_stce_m.stcecrtdt, 
                   g_stce_m.stcemodid,g_stce_m.stcemoddt,g_stce_m.stcecnfid,g_stce_m.stcecnfdt)
                WHERE stceent = g_enterprise AND stce001 = g_stce001_t
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "stce_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               
               #add-point:單頭修改中
                IF NOT cl_null(g_stce_m.ooff013) THEN
                     LET l_success = ''
                     CALL s_aooi360_gen('2',g_stce_m.stce001,'','','','','','','','','','4',g_stce_m.ooff013) RETURNING l_success
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "ooff_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        CONTINUE DIALOG
                     END IF
                  ELSE
                     CALL s_aooi360_del('2',g_stce_m.stce001,'','','','','','','','','','4') RETURNING l_success
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "ooff_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        CONTINUE DIALOG
                     END IF
                  END IF
                 IF g_stce_m.stce004 <> g_stce_m_t.stce004 AND p_cmd = 'u' THEN
                    IF NOT cl_null(g_stce_m.stce004) THEN
                       CALL astm601_stce004_genb()
                       CALL astm601_b_fill()
                       LET l_ac3 = 1
                       CALL astm601_b3_fill()
                       CALL astm601_reflesh()
                    END IF
                 END IF
               #end add-point
               
               
               
               CALL s_transaction_end('Y','0')
               
               #add-point:單頭修改後
               
               #end add-point
            END IF
            
            LET g_stce001_t = g_stce_m.stce001
 
            #controlp
            
      END INPUT
   
 
{</section>}
 
{<section id="astm601.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_stcf_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_stcf_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL astm601_b_fill()
            LET g_rec_b = g_stcf_d.getLength()
            #add-point:資料輸入前
            CALL astm601_stcf005_chk(0) RETURNING l_success,l_ac1    
            IF NOT l_success THEN
               CALL FGL_SET_ARR_CURR(l_ac1) 
               NEXT FIELD stcf005
            END IF    
            #end add-point
         
         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN astm601_cl USING g_enterprise,g_stce_m.stce001
 
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN astm601_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               CLOSE astm601_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_stcf_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_stcf_d[l_ac].stcfseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_stcf_d_t.* = g_stcf_d[l_ac].*  #BACKUP
               CALL astm601_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b
               
               #end add-point  
               CALL astm601_set_no_entry_b(l_cmd)
               IF NOT astm601_lock_b("stcf_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH astm601_bcl INTO g_stcf_d[l_ac].stcfseq,g_stcf_d[l_ac].stcf002,g_stcf_d[l_ac].stcf002_desc, 
                      g_stcf_d[l_ac].stcf003,g_stcf_d[l_ac].stcf004,g_stcf_d[l_ac].stcf005,g_stcf_d[l_ac].stcf006, 
                      g_stcf_d[l_ac].stcf007,g_stcf_d[l_ac].stcf008,g_stcf_d[l_ac].stcf008_desc,g_stcf_d[l_ac].stcf009, 
                      g_stcf_d[l_ac].stcf009_desc,g_stcf_d[l_ac].stcf010,g_stcf_d[l_ac].stcf011,g_stcf_d[l_ac].stcf012, 
                      g_stcf_d[l_ac].stcf013,g_stcf_d[l_ac].stcf014,g_stcf_d[l_ac].stcf015,g_stcf_d[l_ac].stcf016, 
                      g_stcf_d[l_ac].stcf017,g_stcf_d[l_ac].stcf018,g_stcf_d[l_ac].stcf019
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_stcf_d_t.stcfseq
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL astm601_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
                          IF l_cmd = 'u' THEN
                 CALL astm601_b3_fill()
                 CALL astm601_reflesh()
             END IF 
  
             CALL astm601_set_entry_b(l_cmd)
             CALL astm601_set_no_required_b(l_cmd)
             CALL astm601_set_required_b(l_cmd)
             CALL astm601_set_no_entry_b(l_cmd)
             LET g_stcf_d_t.* = g_stcf_d[l_ac].* 
             LET g_stcf_d_o.* = g_stcf_d[l_ac].* 
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_stcf_d[l_ac].* TO NULL 
                  LET g_stcf_d[l_ac].stcf012 = "1"
      LET g_stcf_d[l_ac].stcf015 = "1"
 
 
            LET g_stcf_d_t.* = g_stcf_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL astm601_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b
            
            #end add-point
            CALL astm601_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_stcf_d[li_reproduce_target].* = g_stcf_d[li_reproduce].*
 
               LET g_stcf_d[li_reproduce_target].stcfseq = NULL
 
            END IF
            #公用欄位給值(單身)
            
            
            #add-point:modify段before insert
             LET g_insert = 'Y'
             CALL g_stcg_d.clear()
             
            SELECT MAX(stcfseq)+1 INTO  g_stcf_d[l_ac].stcfseq FROM stcf_t
             WHERE stcfent = g_enterprise AND stcf001 = g_stce_m.stce001
            IF cl_null( g_stcf_d[l_ac].stcfseq ) THEN             
               LET g_stcf_d[l_ac].stcfseq = 1
            END IF
            IF NOT cl_null(g_stce_m.stce010) THEN
               LET g_stcf_d[l_ac].stcf005 = '2'
            ELSE
               LET g_stcf_d[l_ac].stcf005 = '1'
            END IF
            #LET g_stcf_d[l_ac].stcfsite = g_stce_m.stcesite  #150320-00008#1 mark by ken 150323 stcesite改為no use後不使用
            LET g_stcf_d[l_ac].stcfunit = g_stce_m.stceunit 
            LET g_stcf_d[l_ac].stcf016 = g_stce_m.stce017
            LET g_stcf_d[l_ac].stcf017 = g_stce_m.stce018
            CALL astm601_set_entry_b(l_cmd)
            CALL astm601_set_no_required_b(l_cmd)
            CALL astm601_set_required_b(l_cmd)
            CALL astm601_set_no_entry_b(l_cmd)
            #end add-point  
  
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM stcf_t 
             WHERE stcfent = g_enterprise AND stcf001 = g_stce_m.stce001
 
               AND stcfseq = g_stcf_d[l_ac].stcfseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stce_m.stce001
               LET gs_keys[2] = g_stcf_d[g_detail_idx].stcfseq
               CALL astm601_insert_b('stcf_t',gs_keys,"'1'")
                           
               #add-point:單身新增後
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               INITIALIZE g_stcf_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stcf_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL astm601_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_stcf_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_stcf_d.deleteElement(l_ac)
               NEXT FIELD stcfseq
            END IF
         
            IF g_stcf_d[l_ac].stcfseq IS NOT NULL
 
               THEN 
               
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
               
               #add-point:單身刪除前
                              DELETE FROM stcg_t
                WHERE stcgent = g_enterprise AND stcg001 = g_stce_m.stce001 AND

                      stcgseq1 = g_stcf_d_t.stcfseq
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "stcg_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE 
               END IF   
               #end add-point 
               
               DELETE FROM stcf_t
                WHERE stcfent = g_enterprise AND stcf001 = g_stce_m.stce001 AND
 
                      stcfseq = g_stcf_d_t.stcfseq
 
                  
               #add-point:單身刪除中
               
               #end add-point 
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stcf_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  
                  #add-point:單身刪除後
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE astm601_bcl
               LET l_count = g_stcf_d.getLength()
            END IF 
            
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stce_m.stce001
               LET gs_keys[2] = g_stcf_d[g_detail_idx].stcfseq
 
              
         AFTER DELETE 
            #add-point:單身刪除後2
            
            #end add-point
                           CALL astm601_delete_b('stcf_t',gs_keys,"'1'")
 
         #---------------------<  Detail: page1  >---------------------
         #----<<stcfseq>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcfseq
            #add-point:BEFORE FIELD stcfseq
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcfseq
            
            #add-point:AFTER FIELD stcfseq
                        #此段落由子樣板a05產生
            IF  NOT cl_null(g_stce_m.stce001) AND NOT cl_null(g_stcf_d[g_detail_idx].stcfseq) THEN 
               #150427-00012#7 150527 mark by beckxie
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_stce_m.stce001 != g_stce001_t OR g_stcf_d[g_detail_idx].stcfseq != g_stcf_d_t.stcfseq))) 
               #150427-00012#7 160104 mark by beckxie---S
               #IF g_stce_m.stce001 != g_stce001_t OR g_stcf_d[g_detail_idx].stcfseq != g_stcf_d_t.stcfseq THEN     #150427-00012#7 150527 add by beckxie
               #150427-00012#7 160104 mark by beckxie---E
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_stce_m.stce001 != g_stce001_t OR g_stcf_d[g_detail_idx].stcfseq != g_stcf_d_t.stcfseq)) THEN #150427-00012#7 160104 add by beckxie
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM stcf_t WHERE "||"stcfent = '" ||g_enterprise|| "' AND "||"stcf001 = '"||g_stce_m.stce001 ||"' AND "|| "stcfseq = '"||g_stcf_d[g_detail_idx].stcfseq ||"'",'std-00004',0) THEN #150427-00012#7 150527 add by beckxie
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_stcf_d_o.stcfseq = g_stcf_d[l_ac].stcfseq

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stcfseq
            #add-point:ON CHANGE stcfseq
            
            #END add-point
 
         #----<<stcf002>>----
         #此段落由子樣板a02產生
         AFTER FIELD stcf002
            
            #add-point:AFTER FIELD stcf002
           LET g_stcf_d[l_ac].stcf002_desc = ''
           DISPLAY BY NAME g_stcf_d[l_ac].stcf002_desc           
           IF NOT cl_null(g_stcf_d[l_ac].stcf002) THEN
              IF NOT astm601_stcf002_chk(g_stcf_d[l_ac].stcf002 ) THEN
                 LET g_stcf_d[l_ac].stcf002 = g_stcf_d_t.stcf002
                 CALL astm601_stcf002_ref() 
                 SELECT stae006 INTO  g_stcf_d[l_ac].stcf004 FROM stae_t WHERE staeent = g_enterprise AND stae001 = g_stcf_d[l_ac].stcf002
                 DISPLAY BY NAME g_stcf_d[l_ac].stcf004 
               
                 NEXT FIELD stcf002
              END IF
       
              
               
              IF g_stcf_d[l_ac].stcf002 <> g_stcf_d_o.stcf002 AND NOT cl_null(g_stcf_d_o.stcf002) THEN
                # SELECT COUNT(*) INTO l_n FROM staf_t
                #  WHERE stafent = g_enterprise AND staf001= g_stcf_d[l_ac].stcf002 AND staf002 = g_stce_m.stce005
                #    AND staf003 = 'stao016' AND staf004 = 'N'
                # IF l_n> 0 THEN
                #     IF cl_ask_confirm('ast-00024') THEN
                #        DELETE FROM stcg_t
                #         WHERE stcgent = g_enterprise AND stcg001 = g_stce_m.stce001 AND
                #               stcgseq1 = g_stcf_d_t.stcfseq
                #         CALL g_stcg_d.clear()
                #     ELSE
                #         LET g_stcf_d[l_ac].stcf002 = g_stcf_d_t.stcf002
                #         CALL astm601_stcf002_ref() 
                #         NEXT FIELD stcf002
                #     END IF
                # END IF
                 IF l_cmd = 'u' AND g_stcg_d.getlength() > 0 THEN
                     IF cl_ask_confirm('ast-00018') THEN
                        DELETE FROM stcg_t
                         WHERE stcgent = g_enterprise AND stcg001 = g_stce_m.stce001 AND
                               stcgseq1 = g_stcf_d_t.stcfseq
                         CALL g_stcg_d.clear()
                     ELSE
                         LET g_stcf_d[l_ac].stcf002 = g_stcf_d_t.stcf002
                         CALL astm601_stcf002_ref() 
                         NEXT FIELD stcf002
                     END IF  
                 END IF 
               END IF   
       
               IF (g_stcf_d[l_ac].stcf002 <> g_stcf_d_o.stcf002 AND NOT cl_null(g_stcf_d_o.stcf002)) OR (l_cmd = 'a' AND cl_null(g_stcf_d_o.stcf002)) THEN         
                 LET g_stcf_d_o.stcfseq = g_stcf_d[l_ac].stcfseq
                 LET g_stcf_d_o.stcf002 = g_stcf_d[l_ac].stcf002
                 INITIALIZE g_stcf_d[l_ac].* TO NULL
                 #LET g_stcf_d[l_ac].stcfsite = g_stce_m.stcesite #150320-00008#1 mark by ken 150323 stcesite改為no use後不使用
                 LET g_stcf_d[l_ac].stcfunit = g_stce_m.stceunit 
                 LET g_stcf_d[l_ac].stcf012 = "1"
                 LET g_stcf_d[l_ac].stcf015 = "1"
                 LET g_stcf_d[l_ac].stcf016 = g_stce_m.stce017
                 LET g_stcf_d[l_ac].stcf017 = g_stce_m.stce018
                 LET g_stcf_d[l_ac].stcfseq = g_stcf_d_o.stcfseq
                 LET g_stcf_d[l_ac].stcf002 =  g_stcf_d_o.stcf002 
                  #帶出費用編號預設
                 SELECT stae006 INTO  g_stcf_d[l_ac].stcf004 FROM stae_t WHERE staeent = g_enterprise AND stae001 = g_stcf_d[l_ac].stcf002
                   DISPLAY BY NAME g_stcf_d[l_ac].stcf002_desc,g_stcf_d[l_ac].stcf004 
                 IF g_stcf_d[l_ac].stcf004 = '3' THEN
                    LET g_stcf_d[l_ac].stcf004 = ''
                 END IF                 
                   
                #費用合約設定asti204
                 CALL astm601_default(g_stce_m.stce005,g_stcf_d[l_ac].stcf002) 
               END IF
               
               IF NOT cl_null(g_stcf_d[l_ac].stcf016) AND NOT cl_null(g_stcf_d[l_ac].stcf017) AND NOT cl_null(g_stcf_d[l_ac].stcfseq) THEN
                  IF NOT astm601_stcf016_017_chk() THEN               
                     NEXT FIELD stcf016
                  END IF
               END IF
               CALL astm601_stcf002_ref()
              #SELECT stae006 INTO  g_stcf_d[l_ac].stcf004 FROM stae_t WHERE staeent = g_enterprise AND stae001 = g_stcf_d[l_ac].stcf002
           ELSE
              LET g_stcf_d[l_ac].stcf002_desc = ''
              LET g_stcf_d[l_ac].stcf004 = ''
           END IF
           
           LET g_stcf_d_o.stcf002 = g_stcf_d[l_ac].stcf002
              CALL astm601_set_entry_b(l_cmd)
              CALL astm601_set_no_required_b(l_cmd)
              CALL astm601_set_required_b(l_cmd)
              CALL astm601_set_no_entry_b(l_cmd)

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD stcf002
            #add-point:BEFORE FIELD stcf002
                        IF cl_null(g_stcf_d[l_ac].stcfseq) THEN
               NEXT FIELD stcfseq
            END IF
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE stcf002
            #add-point:ON CHANGE stcf002
            
            #END add-point
 
         #----<<stcf003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcf003
            #add-point:BEFORE FIELD stcf003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcf003
            
            #add-point:AFTER FIELD stcf003
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stcf003
            #add-point:ON CHANGE stcf003
            
            #END add-point
 
         #----<<stcf004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcf004
            #add-point:BEFORE FIELD stcf004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcf004
            
            #add-point:AFTER FIELD stcf004
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stcf004
            #add-point:ON CHANGE stcf004
            
            #END add-point
 
         #----<<stcf005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcf005
            #add-point:BEFORE FIELD stcf005
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcf005
            
            #add-point:AFTER FIELD stcf005
                         CALL astm601_set_entry_b(l_cmd)
             CALL astm601_set_no_required_b(l_cmd)
             CALL astm601_set_required_b(l_cmd)
             CALL astm601_set_no_entry_b(l_cmd)
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stcf005
            #add-point:ON CHANGE stcf005
            IF NOT cl_null(g_stcf_d[l_ac].stcf005) THEN
               CALL astm601_stcf005_chk(l_ac) RETURNING l_success,l_ac1
               IF NOT l_success THEN
                  LET g_stcf_d[l_ac].stcf005 = g_stcf_d_t.stcf005
                  NEXT FIELD stcf005
               END IF
            END IF
            #END add-point
 
         #----<<stcf006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcf006
            #add-point:BEFORE FIELD stcf006
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcf006
            
            #add-point:AFTER FIELD stcf006
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stcf006
            #add-point:ON CHANGE stcf006
  
            IF NOT cl_null(g_stcf_d[l_ac].stcf006) AND NOT cl_null(g_stcf_d[l_ac].stcf007)  AND NOT cl_null(g_stcf_d[l_ac].stcf016) AND NOT cl_null(g_stcf_d[l_ac].stcf017) THEN    
               CALL s_astm601_cal_nextd(g_stcf_d[l_ac].stcf006,g_stcf_d[l_ac].stcf007,g_stcf_d[l_ac].stcf016,g_stcf_d[l_ac].stcf017,'','') RETURNING g_stcf_d[l_ac].stcf018,g_stcf_d[l_ac].stcf019,g_stcf_d[l_ac].stcf020
            END IF
            #END add-point
 
         #----<<stcf007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcf007
            #add-point:BEFORE FIELD stcf007
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcf007
            
            #add-point:AFTER FIELD stcf007
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stcf007
            #add-point:ON CHANGE stcf007
           
            IF NOT cl_null(g_stcf_d[l_ac].stcf006) AND NOT cl_null(g_stcf_d[l_ac].stcf007)  AND NOT cl_null(g_stcf_d[l_ac].stcf016) AND NOT cl_null(g_stcf_d[l_ac].stcf017) THEN    
               CALL s_astm601_cal_nextd(g_stcf_d[l_ac].stcf006,g_stcf_d[l_ac].stcf007,g_stcf_d[l_ac].stcf016,g_stcf_d[l_ac].stcf017,'','') RETURNING g_stcf_d[l_ac].stcf018,g_stcf_d[l_ac].stcf019,g_stcf_d[l_ac].stcf020
            END IF  
            #END add-point
 
         #----<<stcf008>>----
         #此段落由子樣板a02產生
         AFTER FIELD stcf008
            
            #add-point:AFTER FIELD stcf008
            LET g_stcf_d[l_ac].stcf008_desc = ''
            IF NOT cl_null(g_stcf_d[l_ac].stcf008) THEN
               IF NOT astm601_stcf008_chk(g_stcf_d[l_ac].stcf008) THEN
                  LET g_stcf_d[l_ac].stcf008 = g_stcf_d_t.stcf008
                  CALL astm601_stcf008_ref()
                  NEXT FIELD stcf008
               END IF
            END IF
            CALL astm601_stcf008_ref()
            CALL astm601_set_entry_b(l_cmd)
            CALL astm601_set_no_required_b(l_cmd)
            CALL astm601_set_required_b(l_cmd)
            CALL astm601_set_no_entry_b(l_cmd)
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD stcf008
            #add-point:BEFORE FIELD stcf008
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE stcf008
            #add-point:ON CHANGE stcf008
            
            #END add-point
 
         #----<<stcf009>>----
         #此段落由子樣板a02產生
         AFTER FIELD stcf009
            
            #add-point:AFTER FIELD stcf009
                       LET g_stcf_d[l_ac].stcf009_desc = ''
           IF NOT cl_null(g_stcf_d[l_ac].stcf009) THEN
               IF NOT astm601_stcf008_chk(g_stcf_d[l_ac].stcf009) THEN
                  LET g_stcf_d[l_ac].stcf009 = g_stcf_d_t.stcf009
                  CALL astm601_stcf009_ref()
                  NEXT FIELD stcf009
               END IF
            END IF
            CALL astm601_stcf009_ref()
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD stcf009
            #add-point:BEFORE FIELD stcf009
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE stcf009
            #add-point:ON CHANGE stcf009
            
            #END add-point
 
         #----<<stcf010>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcf010
            #add-point:BEFORE FIELD stcf010
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcf010
            
            #add-point:AFTER FIELD stcf010
                        IF NOT cl_null(g_stcf_d[l_ac].stcf010) THEN
               IF g_stcf_d[l_ac].stcf010 <=0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-32406'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_stcf_d[l_ac].stcf010 = g_stcf_d_t.stcf010
                  NEXT FIELD stcf010
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stcf010
            #add-point:ON CHANGE stcf010
            
            #END add-point
 
         #----<<stcf011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcf011
            #add-point:BEFORE FIELD stcf011
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcf011
            
            #add-point:AFTER FIELD stcf011
                         IF NOT cl_null( g_stcf_d[l_ac].stcf011) THEN
               IF g_stcf_d[l_ac].stcf011 <=0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-32406'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_stcf_d[l_ac].stcf011 = g_stcf_d_t.stcf011
                  NEXT FIELD stcf011
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stcf011
            #add-point:ON CHANGE stcf011
            
            #END add-point
 
         #----<<stcf012>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcf012
            #add-point:BEFORE FIELD stcf012
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcf012
            
            #add-point:AFTER FIELD stcf012
                        CALL astm601_set_entry_b(l_cmd)
             CALL astm601_set_no_required_b(l_cmd)
             CALL astm601_set_required_b(l_cmd)
             CALL astm601_set_no_entry_b(l_cmd)
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stcf012
            #add-point:ON CHANGE stcf012
            
            #END add-point
 
         #----<<stcf013>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcf013
            #add-point:BEFORE FIELD stcf013
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcf013
            
            #add-point:AFTER FIELD stcf013
                        IF NOT cl_null(g_stcf_d[l_ac].stcf013) THEN
               IF g_stcf_d[l_ac].stcf013 <=0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-32406'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_stcf_d[l_ac].stcf013 = g_stcf_d_t.stcf013
                  NEXT FIELD stcf013
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stcf013
            #add-point:ON CHANGE stcf013
            
            #END add-point
 
         #----<<stcf014>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcf014
            #add-point:BEFORE FIELD stcf014
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcf014
            
            #add-point:AFTER FIELD stcf014
                        IF NOT cl_null(g_stcf_d[l_ac].stcf014) THEN
               IF g_stcf_d[l_ac].stcf014 <=0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-32406'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_stcf_d[l_ac].stcf014 = g_stcf_d_t.stcf014
                  NEXT FIELD stcf014
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stcf014
            #add-point:ON CHANGE stcf014
            
            #END add-point
 
         #----<<stcf015>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcf015
            #add-point:BEFORE FIELD stcf015
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcf015
            
            #add-point:AFTER FIELD stcf015
                        CALL astm601_set_entry_b(l_cmd)
             CALL astm601_set_no_required_b(l_cmd)
             CALL astm601_set_required_b(l_cmd)
             CALL astm601_set_no_entry_b(l_cmd)
             IF g_stcf_d[l_ac].stcf015 = '1' AND g_stcg_d.getlength() > 0 THEN
                IF cl_ask_confirm('ast-00018') THEN
                   DELETE FROM stcg_t
                    WHERE stcgent = g_enterprise AND stcg001 = g_stce_m.stce001 AND
                          stcgseq1 = g_stcf_d_t.stcfseq
                    CALL g_stcg_d.clear()
                ELSE
                   LET g_stcf_d[l_ac].stcf015 =  g_stcf_d_t.stcf015
                END IF  
             END IF 
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stcf015
            #add-point:ON CHANGE stcf015
            
            #END add-point
 
         #----<<stcf016>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcf016
            #add-point:BEFORE FIELD stcf016
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcf016
            
            #add-point:AFTER FIELD stcf016
            IF NOT cl_null(g_stcf_d[l_ac].stcf016) THEN  
               IF NOT astm601_stcf016_017_chk() THEN
                  LET g_stcf_d[l_ac].stcf016 =g_stcf_d_t.stcf016
                  NEXT FIELD CURRENT
               END IF  
            END IF
            
            IF NOT cl_null(g_stcf_d[l_ac].stcf006) AND NOT cl_null(g_stcf_d[l_ac].stcf007)  AND NOT cl_null(g_stcf_d[l_ac].stcf016) AND NOT cl_null(g_stcf_d[l_ac].stcf017) THEN    
                CALL s_astm601_cal_nextd(g_stcf_d[l_ac].stcf006,g_stcf_d[l_ac].stcf007,g_stcf_d[l_ac].stcf016,g_stcf_d[l_ac].stcf017,'','') RETURNING g_stcf_d[l_ac].stcf018,g_stcf_d[l_ac].stcf019,g_stcf_d[l_ac].stcf020
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stcf016
            #add-point:ON CHANGE stcf016
            
            #END add-point
 
         #----<<stcf017>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcf017
            #add-point:BEFORE FIELD stcf017
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcf017
            
            #add-point:AFTER FIELD stcf017
            IF NOT cl_null(g_stcf_d[l_ac].stcf017) THEN     
               IF NOT astm601_stcf016_017_chk() THEN
                  LET g_stcf_d[l_ac].stcf017 =g_stcf_d_t.stcf017
                  NEXT FIELD CURRENT
               END IF
            END IF
            
            IF NOT cl_null(g_stcf_d[l_ac].stcf006) AND NOT cl_null(g_stcf_d[l_ac].stcf007)  AND NOT cl_null(g_stcf_d[l_ac].stcf016) AND NOT cl_null(g_stcf_d[l_ac].stcf017) THEN    
               CALL s_astm601_cal_nextd(g_stcf_d[l_ac].stcf006,g_stcf_d[l_ac].stcf007,g_stcf_d[l_ac].stcf016,g_stcf_d[l_ac].stcf017,'','') RETURNING g_stcf_d[l_ac].stcf018,g_stcf_d[l_ac].stcf019,g_stcf_d[l_ac].stcf020
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stcf017
            #add-point:ON CHANGE stcf017
            
            #END add-point
 
         #----<<stcf018>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stcf018
            #add-point:BEFORE FIELD stcf018
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stcf018
            
            #add-point:AFTER FIELD stcf018
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stcf018
            #add-point:ON CHANGE stcf018
            
            #END add-point
 
 
         #---------------------<  Detail: page1  >---------------------
         #----<<stcfseq>>----
         #Ctrlp:input.c.page1.stcfseq
         ON ACTION controlp INFIELD stcfseq
            #add-point:ON ACTION controlp INFIELD stcfseq
            
            #END add-point
 
         #----<<stcf002>>----
         #Ctrlp:input.c.page1.stcf002
         ON ACTION controlp INFIELD stcf002
            #add-point:ON ACTION controlp INFIELD stcf002
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stcf_d[l_ac].stcf002             #給予default值
            LET g_qryparam.default2 = "" #g_stcf_d[l_ac].stael003 #說明
            LET g_qryparam.default3 = "" #g_stcf_d[l_ac].stae001 #費用編號

            #給予arg
             SELECT ooef019 INTO l_ooef019 FROM ooef_t 
             WHERE ooefent = g_enterprise AND ooef001 = g_stce_m.stce014
            LET g_qryparam.where = " (stae009 = 'N' OR stae010 IN (SELECT oodb002 FROM oodb_t WHERE oodbent = '",g_enterprise,"' AND oodb001 = '",l_ooef019,"'))"
                                                            
            CALL q_stae001_3()                                #呼叫開窗

            LET g_stcf_d[l_ac].stcf002 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_stcf_d[l_ac].stael003 = g_qryparam.return2 #說明
            #LET g_stcf_d[l_ac].stae001 = g_qryparam.return3 #費用編號

            DISPLAY g_stcf_d[l_ac].stcf002 TO stcf002              #顯示到畫面上
            #DISPLAY g_stcf_d[l_ac].stael003 TO stael003 #說明
            #DISPLAY g_stcf_d[l_ac].stae001 TO stae001 #費用編號
            CALL astm601_stcf002_ref()
            NEXT FIELD stcf002                          #返回原欄位


            #END add-point
 
         #----<<stcf003>>----
         #Ctrlp:input.c.page1.stcf003
         ON ACTION controlp INFIELD stcf003
            #add-point:ON ACTION controlp INFIELD stcf003
            
            #END add-point
 
         #----<<stcf004>>----
         #Ctrlp:input.c.page1.stcf004
         ON ACTION controlp INFIELD stcf004
            #add-point:ON ACTION controlp INFIELD stcf004
            
            #END add-point
 
         #----<<stcf005>>----
         #Ctrlp:input.c.page1.stcf005
         ON ACTION controlp INFIELD stcf005
            #add-point:ON ACTION controlp INFIELD stcf005
            
            #END add-point
 
         #----<<stcf006>>----
         #Ctrlp:input.c.page1.stcf006
         ON ACTION controlp INFIELD stcf006
            #add-point:ON ACTION controlp INFIELD stcf006
            
            #END add-point
 
         #----<<stcf007>>----
         #Ctrlp:input.c.page1.stcf007
         ON ACTION controlp INFIELD stcf007
            #add-point:ON ACTION controlp INFIELD stcf007
            
            #END add-point
 
         #----<<stcf008>>----
         #Ctrlp:input.c.page1.stcf008
         ON ACTION controlp INFIELD stcf008
            #add-point:ON ACTION controlp INFIELD stcf008
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stcf_d[l_ac].stcf008             #給予default值
            LET g_qryparam.default2 = "" #g_stcf_d[l_ac].stabl003 #說明
            LET g_qryparam.default3 = "" #g_stcf_d[l_ac].stabl004 #助記碼

            #給予arg
            LET g_qryparam.arg1 = g_stce_m.stce005
            LET g_qryparam.arg2 = g_stce_m.stce007
            CALL q_stab001_3()                                #呼叫開窗

            LET g_stcf_d[l_ac].stcf008 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_stcf_d[l_ac].stabl003 = g_qryparam.return2 #說明
            #LET g_stcf_d[l_ac].stabl004 = g_qryparam.return3 #助記碼

            DISPLAY g_stcf_d[l_ac].stcf008 TO stcf008              #顯示到畫面上
            #DISPLAY g_stcf_d[l_ac].stabl003 TO stabl003 #說明
            #DISPLAY g_stcf_d[l_ac].stabl004 TO stabl004 #助記碼
            CALL astm601_stcf008_ref()
            NEXT FIELD stcf008                          #返回原欄位


            #END add-point
 
         #----<<stcf009>>----
         #Ctrlp:input.c.page1.stcf009
         ON ACTION controlp INFIELD stcf009
            #add-point:ON ACTION controlp INFIELD stcf009
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stcf_d[l_ac].stcf009             #給予default值
            LET g_qryparam.default2 = "" #g_stcf_d[l_ac].stabl003 #說明
            LET g_qryparam.default3 = "" #g_stcf_d[l_ac].stabl004 #助記碼

            #給予arg
            LET g_qryparam.arg1 = g_stce_m.stce005
            LET g_qryparam.arg2 = g_stce_m.stce007 
            CALL q_stab001_3()                                #呼叫開窗

            LET g_stcf_d[l_ac].stcf009 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_stcf_d[l_ac].stabl003 = g_qryparam.return2 #說明
            #LET g_stcf_d[l_ac].stabl004 = g_qryparam.return3 #助記碼

            DISPLAY g_stcf_d[l_ac].stcf009 TO stcf009              #顯示到畫面上
            #DISPLAY g_stcf_d[l_ac].stabl003 TO stabl003 #說明
            #DISPLAY g_stcf_d[l_ac].stabl004 TO stabl004 #助記碼
            CALL astm601_stcf009_ref() 
            NEXT FIELD stcf009                          #返回原欄位


            #END add-point
 
         #----<<stcf010>>----
         #Ctrlp:input.c.page1.stcf010
         ON ACTION controlp INFIELD stcf010
            #add-point:ON ACTION controlp INFIELD stcf010
            
            #END add-point
 
         #----<<stcf011>>----
         #Ctrlp:input.c.page1.stcf011
         ON ACTION controlp INFIELD stcf011
            #add-point:ON ACTION controlp INFIELD stcf011
            
            #END add-point
 
         #----<<stcf012>>----
         #Ctrlp:input.c.page1.stcf012
         ON ACTION controlp INFIELD stcf012
            #add-point:ON ACTION controlp INFIELD stcf012
            
            #END add-point
 
         #----<<stcf013>>----
         #Ctrlp:input.c.page1.stcf013
         ON ACTION controlp INFIELD stcf013
            #add-point:ON ACTION controlp INFIELD stcf013
            
            #END add-point
 
         #----<<stcf014>>----
         #Ctrlp:input.c.page1.stcf014
         ON ACTION controlp INFIELD stcf014
            #add-point:ON ACTION controlp INFIELD stcf014
            
            #END add-point
 
         #----<<stcf015>>----
         #Ctrlp:input.c.page1.stcf015
         ON ACTION controlp INFIELD stcf015
            #add-point:ON ACTION controlp INFIELD stcf015
            
            #END add-point
 
         #----<<stcf016>>----
         #Ctrlp:input.c.page1.stcf016
         ON ACTION controlp INFIELD stcf016
            #add-point:ON ACTION controlp INFIELD stcf016
            
            #END add-point
 
         #----<<stcf017>>----
         #Ctrlp:input.c.page1.stcf017
         ON ACTION controlp INFIELD stcf017
            #add-point:ON ACTION controlp INFIELD stcf017
            
            #END add-point
 
         #----<<stcf018>>----
         #Ctrlp:input.c.page1.stcf018
         ON ACTION controlp INFIELD stcf018
            #add-point:ON ACTION controlp INFIELD stcf018
            
            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_stcf_d[l_ac].* = g_stcf_d_t.*
               CLOSE astm601_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_stcf_d[l_ac].stcfseq
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               LET g_stcf_d[l_ac].* = g_stcf_d_t.*
            ELSE
            
               #add-point:單身修改前
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               UPDATE stcf_t SET (stcf001,stcfseq,stcf002,stcf003,stcf004,stcf005,stcf006,stcf007,stcf008, 
                   stcf009,stcf010,stcf011,stcf012,stcf013,stcf014,stcf015,stcf016,stcf017,stcf018,stcf019,stcf020) = (g_stce_m.stce001, 
                   g_stcf_d[l_ac].stcfseq,g_stcf_d[l_ac].stcf002,g_stcf_d[l_ac].stcf003,g_stcf_d[l_ac].stcf004, 
                   g_stcf_d[l_ac].stcf005,g_stcf_d[l_ac].stcf006,g_stcf_d[l_ac].stcf007,g_stcf_d[l_ac].stcf008, 
                   g_stcf_d[l_ac].stcf009,g_stcf_d[l_ac].stcf010,g_stcf_d[l_ac].stcf011,g_stcf_d[l_ac].stcf012, 
                   g_stcf_d[l_ac].stcf013,g_stcf_d[l_ac].stcf014,g_stcf_d[l_ac].stcf015,g_stcf_d[l_ac].stcf016, 
                   g_stcf_d[l_ac].stcf017,g_stcf_d[l_ac].stcf018,g_stcf_d[l_ac].stcf019,g_stcf_d[l_ac].stcf020)
                WHERE stcfent = g_enterprise AND stcf001 = g_stce_m.stce001 
 
                  AND stcfseq = g_stcf_d_t.stcfseq #項次   
 
                  
               #add-point:單身修改中
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "stcf_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                     LET g_stcf_d[l_ac].* = g_stcf_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stcf_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
                     LET g_stcf_d[l_ac].* = g_stcf_d_t.*                     
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stce_m.stce001
               LET gs_keys_bak[1] = g_stce001_t
               LET gs_keys[2] = g_stcf_d[g_detail_idx].stcfseq
               LET gs_keys_bak[2] = g_stcf_d_t.stcfseq
               CALL astm601_update_b('stcf_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
               END CASE
               
               #add-point:單身修改後
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row
            CALL astm601_stcf005_chk(l_ac) RETURNING l_success,l_ac1    
            IF NOT l_success THEN
               NEXT FIELD stcf005
            END IF 
            #end add-point
            CALL astm601_unlock_b("stcf_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
              
         AFTER INPUT
            #add-point:input段after input 

            CALL astm601_stcf005_chk(0) RETURNING l_success,l_ac1    
            IF NOT l_success THEN
               CALL FGL_SET_ARR_CURR(l_ac1) 
               NEXT FIELD stcf005
            END IF            
            #end add-point 
 
         ON ACTION controlo    
            CALL FGL_SET_ARR_CURR(g_stcf_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_stcf_d.getLength()+1
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_stcf2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_stcf2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL astm601_b_fill()
            LET g_rec_b = g_stcf2_d.getLength()
            #add-point:資料輸入前
            
            #end add-point
            
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_stcf2_d[l_ac].* TO NULL 
                  LET g_stcf2_d[l_ac].stch003 = "Y"
 
 
            LET g_stcf2_d_t.* = g_stcf2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL astm601_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b
            
            #end add-point
            CALL astm601_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_stcf2_d[li_reproduce_target].* = g_stcf2_d[li_reproduce].*
 
               LET g_stcf2_d[li_reproduce_target].stchseq = NULL
            END IF
            #公用欄位給值(單身2)
            
            
            #add-point:modify段before insert
            SELECT MAX(stchseq)+1 INTO  g_stcf2_d[l_ac].stchseq FROM stch_t
             WHERE stchent = g_enterprise AND stch001 = g_stce_m.stce001  
            IF cl_null(  g_stcf2_d[l_ac].stchseq ) THEN             
               LET   g_stcf2_d[l_ac].stchseq = 1
            END IF
            #LET g_stcf2_d[l_ac].stchsite = g_stce_m.stcesite  #150320-00008#1 mark by ken 150323 stcesite改為no use後不使用
            LET g_stcf2_d[l_ac].stchunit = g_stce_m.stceunit
            #end add-point  
            
         BEFORE ROW     
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN astm601_cl USING g_enterprise,g_stce_m.stce001
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN astm601_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               CLOSE astm601_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_stcf2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_stcf2_d[l_ac].stchseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_stcf2_d_t.* = g_stcf2_d[l_ac].*  #BACKUP
               CALL astm601_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b
               
               #end add-point  
               CALL astm601_set_no_entry_b(l_cmd)
               IF NOT astm601_lock_b("stch_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH astm601_bcl2 INTO g_stcf2_d[l_ac].stchseq,g_stcf2_d[l_ac].stch002,g_stcf2_d[l_ac].stch002_desc, 
                      g_stcf2_d[l_ac].stch003
                   IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL astm601_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_stcf2_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_stcf2_d.deleteElement(l_ac)
               NEXT FIELD stchseq
            END IF
         
            IF g_stcf2_d[l_ac].stchseq IS NOT NULL
            THEN
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
               
               #add-point:單身2刪除前
               
               #end add-point    
               
               DELETE FROM stch_t
                WHERE stchent = g_enterprise AND stch001 = g_stce_m.stce001 AND
                      stchseq = g_stcf2_d_t.stchseq
                  
               #add-point:單身2刪除中
               
               #end add-point    
                  
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stcf_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  
                  #add-point:單身2刪除後
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE astm601_bcl
               LET l_count = g_stcf_d.getLength()
            END IF 
            
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stce_m.stce001
               LET gs_keys[2] = g_stcf2_d[g_detail_idx].stchseq
 
            
         AFTER DELETE 
            #add-point:單身AFTER DELETE 
            
            #end add-point
                           CALL astm601_delete_b('stch_t',gs_keys,"'2'")
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身2新增前
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM stch_t 
             WHERE stchent = g_enterprise AND stch001 = g_stce_m.stce001
               AND stchseq = g_stcf2_d[l_ac].stchseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stce_m.stce001
               LET gs_keys[2] = g_stcf2_d[g_detail_idx].stchseq
               CALL astm601_insert_b('stch_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               INITIALIZE g_stcf_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stch_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL astm601_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_stcf2_d[l_ac].* = g_stcf2_d_t.*
               CLOSE astm601_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               LET g_stcf2_d[l_ac].* = g_stcf2_d_t.*
            ELSE
               #add-point:單身page2修改前
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               UPDATE stch_t SET (stch001,stchseq,stch002,stch003) = (g_stce_m.stce001,g_stcf2_d[l_ac].stchseq, 
                   g_stcf2_d[l_ac].stch002,g_stcf2_d[l_ac].stch003) #自訂欄位頁簽
                WHERE stchent = g_enterprise AND stch001 = g_stce_m.stce001
                  AND stchseq = g_stcf2_d_t.stchseq #項次 
                  
               #add-point:單身page2修改中
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "stch_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                     LET g_stcf2_d[l_ac].* = g_stcf2_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stch_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                     LET g_stcf2_d[l_ac].* = g_stcf2_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stce_m.stce001
               LET gs_keys_bak[1] = g_stce001_t
               LET gs_keys[2] = g_stcf2_d[g_detail_idx].stchseq
               LET gs_keys_bak[2] = g_stcf2_d_t.stchseq
               CALL astm601_update_b('stch_t',gs_keys,gs_keys_bak,"'2'")
                     #資料多語言用-增/改
                     
               END CASE
               #add-point:單身page2修改後
               
               #end add-point
            END IF
         
         #---------------------<  Detail: page2  >---------------------
         #----<<stchseq>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stchseq
            #add-point:BEFORE FIELD stchseq
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stchseq
            
            #add-point:AFTER FIELD stchseq
                        #此段落由子樣板a05產生
            IF  NOT cl_null(g_stce_m.stce001) AND NOT cl_null(g_stcf2_d[g_detail_idx].stchseq) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_stce_m.stce001 != g_stce001_t OR g_stcf2_d[g_detail_idx].stchseq != g_stcf2_d_t.stchseq))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM stch_t WHERE "||"stchent = '" ||g_enterprise|| "' AND "||"stch001 = '"||g_stce_m.stce001 ||"' AND "|| "stchseq = '"||g_stcf2_d[g_detail_idx].stchseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stchseq
            #add-point:ON CHANGE stchseq
            
            #END add-point
 
         #----<<stch002>>----
         #此段落由子樣板a02產生
         AFTER FIELD stch002
            
            #add-point:AFTER FIELD stch002
           LET g_stcf2_d[l_ac].stch002_desc = ''
           IF NOT cl_null(g_stcf2_d[l_ac].stch002) THEN
              IF NOT astm601_stch002_chk(l_cmd,g_stcf2_d[l_ac].stch002) THEN
                 LET g_stcf2_d[l_ac].stch002 = g_stcf2_d_t.stch002
                 CALL astm601_stch002_ref()
                 NEXT FIELD  stch002                
              END IF
              IF l_cmd = 'a' THEN
                SELECT COUNT(*) INTO l_n FROM stch_t
                 WHERE stchent = g_enterprise AND stch001= g_stce_m.stce001 
                   AND stch002 =g_stcf2_d[l_ac].stch002 AND stchseq <> g_stcf2_d[l_ac].stchseq
              ELSE
                 SELECT COUNT(*) INTO l_n FROM stch_t
                 WHERE stchent = g_enterprise AND stch001= g_stce_m.stce001 
                   AND stch002 =g_stcf2_d[l_ac].stch002 AND stchseq <> g_stcf2_d_t.stchseq 
              END IF
              IF l_n > 0 THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'ast-00025'
                 LET g_errparam.extend = ''
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET g_stcf2_d[l_ac].stch002 = g_stcf2_d_t.stch002
                 CALL astm601_stch002_ref()  
                 NEXT FIELD  stch002 
              END IF
             
           END IF
           CALL astm601_stch002_ref()
       
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD stch002
            #add-point:BEFORE FIELD stch002
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE stch002
            #add-point:ON CHANGE stch002
            
            #END add-point
 
         #----<<stch003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stch003
            #add-point:BEFORE FIELD stch003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stch003
            
            #add-point:AFTER FIELD stch003
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stch003
            #add-point:ON CHANGE stch003
            
            #END add-point
 
 
         #---------------------<  Detail: page2  >---------------------
         #----<<stchseq>>----
         #Ctrlp:input.c.page2.stchseq
         ON ACTION controlp INFIELD stchseq
            #add-point:ON ACTION controlp INFIELD stchseq
            
            #END add-point
 
         #----<<stch002>>----
         #Ctrlp:input.c.page2.stch002
         ON ACTION controlp INFIELD stch002
            #add-point:ON ACTION controlp INFIELD stch002
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		   	LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stcf2_d[l_ac].stch002             #給予default值
            
           SELECT dbbc004,dbba002 INTO l_dbbc004,l_dbba002 FROM  dbba_t,dbbc_t
            WHERE dbbaent = dbbcent AND dbbc001 = g_stce_m.stce028
              AND dbbc004 = dbba001 AND dbbaent = g_enterprise 
          
           LET g_qryparam.arg1 = l_dbbc004
           IF l_dbba002 = '1' THEN         
             #CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys
             ##給予arg
             #LET g_qryparam.arg1 = l_sys 
             #
             #CALL q_rtax001_3()                               #呼叫開窗
              CALL q_dbbb003_1()
           ELSE
             #CALL q_oocq002_2002()
              CALL q_dbbb003_2()
           END IF

            LET g_stcf2_d[l_ac].stch002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_stcf2_d[l_ac].stch002 TO stch002              #顯示到畫面上
            CALL astm601_stch002_ref()
            NEXT FIELD stch002                          #返回原欄位


            #END add-point
 
         #----<<stch003>>----
         #Ctrlp:input.c.page2.stch003
         ON ACTION controlp INFIELD stch003
            #add-point:ON ACTION controlp INFIELD stch003
            
            #END add-point
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row
            
            #end add-point
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_stcf2_d[l_ac].* = g_stcf2_d_t.*
               END IF
               CLOSE astm601_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL astm601_unlock_b("stch_t","'2'")
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input 
            
            #end add-point   
    
         ON ACTION controlo
            CALL FGL_SET_ARR_CURR(g_stcf2_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_stcf2_d.getLength()+1
 
      END INPUT
 
 
      
 
      
 
      
 
      
 
{</section>}
 
{<section id="astm601.input.other" >}
      
      #add-point:自定義input
            INPUT ARRAY g_stcg_d FROM s_detail3.*
          ATTRIBUTE(COUNT = g_rec_b3,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 

         BEFORE INPUT
            IF g_stcf_d[l_ac].stcf015 = '1' OR cl_null(g_stcf_d[l_ac].stcf015) THEN
               NEXT FIELD stcfseq
            END IF
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_stcg_d.getLength()+1) 
              LET g_insert = 'N' 
            END IF 

            CALL astm601_b3_fill()
            LET g_rec_b3 = g_stcg_d.getLength()

            
         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac3 = ARR_CURR()
            LET g_detail_idx3 = l_ac3
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac3 TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN astm601_cl USING g_enterprise,g_stce_m.stce001

            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN astm601_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE astm601_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
         
            
            LET g_rec_b3 = g_stcg_d.getLength()
            
            IF g_rec_b3 >= l_ac3 
               AND NOT cl_null(g_stcg_d[l_ac3].stcgseq2) 

            THEN
               LET l_cmd='u'
               LET g_stcg_d_t.* = g_stcg_d[l_ac3].*  #BACKUP
               CALL astm601_set_entry_b(l_cmd)
               CALL astm601_set_no_entry_b(l_cmd)
               IF NOT astm601_lock_b("stcg_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH astm601_bcl3 INTO g_stcg_d[l_ac3].stcgseq2,  g_stcg_d[l_ac3].stcg002,g_stcg_d[l_ac3].stcg003,g_stcg_d[l_ac3].stcg004
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_stcg_d_t.stcgseq2
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL astm601_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
      
            #其他table資料備份(確定是否更改用)
             
            #其他table進行lock
            
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_stcg_d[l_ac3].* TO NULL 
            
            LET g_stcg_d_t.* = g_stcg_d[l_ac3].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL astm601_set_entry_b(l_cmd)
            CALL astm601_set_no_entry_b(l_cmd)
            #公用欄位給值(單身)
            
            #LET g_stcg_d[l_ac3].stcgsite = g_stce_m.stcesite #150320-00008#1 mark by ken 150323 stcesite改為no use後不使用
            LET g_stcg_d[l_ac3].stcgunit = g_stce_m.stceunit
   
            SELECT MAX(stcgseq2)+1 INTO  g_stcg_d[l_ac3].stcgseq2 FROM stcg_t
             WHERE stcgent = g_enterprise AND stcg001 = g_stce_m.stce001 AND stcgseq1 =g_stcf_d[l_ac].stcfseq  
            IF cl_null(  g_stcg_d[l_ac3].stcgseq2 ) THEN             
               LET  g_stcg_d[l_ac3].stcgseq2 = 1
            END IF
            
            SELECT MAX(stcg003)+1 INTO  g_stcg_d[l_ac3].stcg002 FROM stcg_t
             WHERE stcgent = g_enterprise AND stcg001 = g_stce_m.stce001 AND stcgseq1 =g_stcf_d[l_ac].stcfseq  
            IF cl_null(  g_stcg_d[l_ac3].stcg002 ) THEN             
               LET  g_stcg_d[l_ac3].stcgseq2 = 1
            END IF
        
  
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增

            #end add-point
			   
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM stcg_t 
             WHERE stcgent = g_enterprise AND stcg001 = g_stce_m.stce001

               AND stcgseq1 = g_stcf_d[l_ac].stcfseq AND stcgseq2 = g_stcg_d[l_ac3].stcgseq2

                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前

               #end add-point
            
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stce_m.stce001
               LET gs_keys[2] = g_stcf_d[l_ac].stcfseq
               CALL astm601_insert_b('stcg_t',gs_keys,"'3'")
                           
               #add-point:單身新增後

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_stcg_d[l_ac3].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stcg_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
              
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b3 = g_rec_b3 + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_stcg_d[l_ac3].stcgseq2) 

               THEN 
               
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
               
               #add-point:單身刪除前

               #end add-point 
               
               DELETE FROM stcg_t
                WHERE stcgent = g_enterprise AND stcg001 = g_stce_m.stce001 AND

                      stcgseq1 = g_stcf_d[l_ac].stcfseq AND stcgseq2 =  g_stcg_d_t.stcgseq2

                  
               #add-point:單身刪除中

               #end add-point 
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stcg_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b3 = g_rec_b3-1
                  
                  #add-point:單身刪除後

                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE astm601_bcl3
               LET l_count = g_stcg_d.getLength()
            END IF 
            
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stce_m.stce001
               LET gs_keys[2] = g_stcf_d[l_ac].stcfseq



         
         AFTER FIELD stcg002,stcg003
            IF NOT cl_null(g_stcg_d[l_ac3].stcg002) THEN
               IF g_stcg_d[l_ac3].stcg002 <=0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-32406'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_stcg_d[l_ac3].stcg002 = g_stcg_d_t.stcg002
                  NEXT FIELD stcg002
               END IF
            END IF
            IF NOT cl_null(g_stcg_d[l_ac3].stcg003) THEN
               IF g_stcg_d[l_ac3].stcg003 <=0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-32406'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_stcg_d[l_ac3].stcg003 = g_stcg_d_t.stcg003
                  NEXT FIELD stcg003
               END IF
            END IF
            IF NOT cl_null(g_stcg_d[l_ac3].stcg002) AND NOT cl_null(g_stcg_d[l_ac3].stcg003) THEN
               IF g_stcg_d[l_ac3].stcg003 < g_stcg_d[l_ac3].stcg002 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ast-00017'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
            
               SELECT COUNT(*) INTO l_n FROM stcg_t
                WHERE stcgent = g_enterprise AND stcg001 = g_stce_m.stce001 
                  AND stcgseq1 = g_stcf_d[l_ac].stcfseq
                  AND ((stcg002 between g_stcg_d[l_ac3].stcg002 AND g_stcg_d[l_ac3].stcg003)
                      OR (stcg003 between g_stcg_d[l_ac3].stcg002 AND g_stcg_d[l_ac3].stcg003)
                      OR (g_stcg_d[l_ac3].stcg002  between stcg002 AND stcg003)
                      OR (g_stcg_d[l_ac3].stcg003  between stcg002 AND stcg003))
                  AND stcgseq2 <> g_stcg_d[l_ac3].stcgseq2
               IF l_n > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ast-00016'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
             
            END IF
         
     
         
         
         AFTER FIELD stcg004
            IF NOT cl_null(g_stcg_d[l_ac3].stcg004) THEN
               IF g_stcg_d[l_ac3].stcg004<= 0 THEN
                 INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-32406'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                 LET g_stcg_d[l_ac3].stcg004 = g_stcg_d_t.stcg004
                 NEXT FIELD stcg004
               END IF
            END IF
         
     
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_stcg_d[l_ac3].* = g_stcg_d_t.*
               CLOSE astm601_bcl3
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_stcg_d[l_ac3].stcgseq2
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_stcg_d[l_ac3].* = g_stcg_d_t.*
            ELSE
            
               #add-point:單身修改前

               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               UPDATE stcg_t SET (stcgseq2,stcg002,stcg003,stcg004) = (g_stcg_d[l_ac3].stcgseq2,g_stcg_d[l_ac3].stcg002,g_stcg_d[l_ac3].stcg003,g_stcg_d[l_ac3].stcg004)
                WHERE stcgent = g_enterprise AND stcg001 = g_stce_m.stce001 
                  AND stcgseq1 = g_stcf_d[l_ac].stcfseq #項次   
                  AND stcgseq2 = g_stcg_d_t.stcgseq2
                  
               #add-point:單身修改中

               #end add-point
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stcg_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
   
                  LET g_stcg_d[l_ac3].* = g_stcg_d_t.*
             
                  
               END IF
               
               #add-point:單身修改後

               #end add-point
 
            END IF
            
         AFTER ROW
            CALL astm601_unlock_b("stcg_t","'3'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
              
         AFTER INPUT
            #add-point:input段after input 

            #end add-point   
              
     
                 
      END INPUT    

      INPUT ARRAY g_stcw_d FROM s_detail4.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 

         BEFORE INPUT      
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_stcw_d.getLength()+1) 
              LET g_insert = 'N' 
            END IF 

            LET g_rec_b = g_stcw_d.getLength()

            
         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN astm601_cl USING g_enterprise,g_stce_m.stce001

            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN astm601_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE astm601_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
         
            
            LET g_rec_b = g_stcw_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND NOT cl_null(g_stcw_d[l_ac].stcwseq) 

            THEN
               LET l_cmd='u'
               LET g_stcw_d_t.* = g_stcw_d[l_ac].*  #BACKUP
               CALL astm601_set_entry_b(l_cmd)
               CALL astm601_set_no_entry_b(l_cmd)
               IF NOT astm601_lock_b("stcw_t","'4'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH astm601_bcl4 INTO g_stcw_d[l_ac].stcwsite,g_stcw_d[l_ac].stcwunit,g_stcw_d[l_ac].stcwseq,  g_stcw_d[l_ac].stcw002,g_stcw_d[l_ac].stcw003,g_stcw_d[l_ac].stcw004,g_stcw_d[l_ac].stcw005,g_stcw_d[l_ac].stcw006
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_stcw_d_t.stcwseq
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL astm601_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
      
            #其他table資料備份(確定是否更改用)
             
            #其他table進行lock
            
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_stcw_d[l_ac].* TO NULL 
            
            LET g_stcw_d_t.* = g_stcw_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL astm601_set_entry_b(l_cmd)
            CALL astm601_set_no_entry_b(l_cmd)
            #公用欄位給值(單身)
            
            #LET g_stcw_d[l_ac].stcwsite = g_stce_m.stcesite #150320-00008#1 mark by ken 150323 stcesite改為no use後不使用
            LET g_stcw_d[l_ac].stcwunit = g_stce_m.stceunit
   
     
  
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增

            #end add-point
			   
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM stcw_t 
             WHERE stcwent = g_enterprise AND stcw001 = g_stce_m.stce001

               AND stcwseq = g_stcw_d[l_ac].stcwseq 

                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前

               #end add-point
            
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stce_m.stce001
               LET gs_keys[2] = g_stcw_d[l_ac].stcwseq
               CALL astm601_insert_b('stcw_t',gs_keys,"'4'")
                           
               #add-point:單身新增後

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_stcw_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stcw_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
              
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_stcw_d[l_ac].stcwseq) 

               THEN 
               
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
               
               #add-point:單身刪除前

               #end add-point 
               
               DELETE FROM stcw_t
                WHERE stcwent = g_enterprise AND stcw001 = g_stce_m.stce001 AND

                      stcwseq = g_stcw_d_t.stcwseq 

                  
               #add-point:單身刪除中

               #end add-point 
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stcw_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  
                  #add-point:單身刪除後

                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE astm601_bcl4
               LET l_count = g_stcw_d.getLength()
            END IF 
            
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stce_m.stce001
               LET gs_keys[2] = g_stcw_d[l_ac].stcwseq



         
       
     
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_stcw_d[l_ac].* = g_stcw_d_t.*
               CLOSE astm601_bcl4
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_stcw_d[l_ac].stcwseq
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_stcw_d[l_ac].* = g_stcw_d_t.*
            ELSE
            
               #add-point:單身修改前

               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               UPDATE stcw_t SET (stcwseq,stcw002,stcw003,stcw004) = (g_stcw_d[l_ac].stcwseq,g_stcw_d[l_ac].stcw002,g_stcw_d[l_ac].stcw003,g_stcw_d[l_ac].stcw004)
                WHERE stcwent = g_enterprise AND stcw001 = g_stce_m.stce001   
                  AND stcwseq = g_stcw_d_t.stcwseq
                  
               #add-point:單身修改中

               #end add-point
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stcw_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
   
                  LET g_stcw_d[l_ac].* = g_stcw_d_t.*
             
                  
               END IF
               
               #add-point:單身修改後

               #end add-point
 
            END IF
            
         AFTER ROW
            CALL astm601_unlock_b("stcw_t","'4'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
              
         AFTER INPUT
            #add-point:input段after input 

            #end add-point   
              
     
                 
      END INPUT   
      #end add-point
      
      BEFORE DIALOG 
         #add-point:input段before dialog
         IF p_cmd = 'a' THEN
            NEXT FIELD stceunit
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD stcfseq
               WHEN "s_detail2"
                  NEXT FIELD stchseq
 
 
            END CASE
         END IF
         #end add-point    
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD stce001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD stcfseq
               WHEN "s_detail2"
                  NEXT FIELD stchseq
 
 
            END CASE
         END IF
    
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controls
         CALL cl_set_head_visible("","AUTO")
 
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
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
    
   #add-point:input段after input 
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="astm601.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION astm601_show()
   {<Local define>}
   DEFINE l_ac_t    LIKE type_t.num5
   {</Local define>}
   #add-point:show段define
   DEFINE l_success LIKE type_t.num5
   #end add-point  
 
   #add-point:show段之前
   LET g_stce_m_o.* = g_stce_m.*
   #end add-point
   
   
   
   LET g_stce_m_t.* = g_stce_m.*      #保存單頭舊值
   
   IF g_bfill = "Y" THEN
      CALL astm601_b_fill() #單身填充
      CALL astm601_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #此段落由子樣板a12產生
      #LET g_stce_m.stceownid_desc = cl_get_username(g_stce_m.stceownid)
      #LET g_stce_m.stceowndp_desc = cl_get_deptname(g_stce_m.stceowndp)
      #LET g_stce_m.stcecrtid_desc = cl_get_username(g_stce_m.stcecrtid)
      #LET g_stce_m.stcecrtdp_desc = cl_get_deptname(g_stce_m.stcecrtdp)
      #LET g_stce_m.stcemodid_desc = cl_get_username(g_stce_m.stcemodid)
      #LET g_stce_m.stcecnfid_desc = cl_get_deptname(g_stce_m.stcecnfid)
      ##LET g_stce_m.stanpstid_desc = cl_get_deptname(g_stce_m.stanpstid)
      
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference
             

    CALL astm601_stce009_ref()
    CALL astm601_stce004_ref()
    CALL astm601_stce021_ref()
    CALL astm601_stce007_ref()
    CALL astm601_stce006_ref()
    CALL astm601_stce007_ref()
    CALL astm601_stce024_ref()
    CALL astm601_stce028_ref()
    CALL astm601_stce025_ref()
    CALL astm601_stce026_ref()
    CALL astm601_stce014_ref()
    CALL astm601_stce015_ref()
    CALL astm601_stce016_ref()
    CALL astm601_stceunit_ref()       
    CALL astm601_stce009_ref()
    CALL astm601_stce010_ref() 
    CALL astm601_stce011_ref()
    CALL astm601_stce012_ref()
    CALL astm601_stce022_ref()
    CALL astm601_stce023_ref()
     
    SELECT stcw004 INTO g_stce_m.next_b FROM ( SELECT * FROM stcw_t
     WHERE stcwent = g_enterprise AND  stcw001 = g_stce_m.stce001 AND stcw005= 'N' ORDER BY stcwseq) WHERE rownum = 1
     
    DISPLAY g_stce_m.next_b TO next_b
    
    IF NOT cl_null(g_stce_m.stce001) THEN
       CALL s_aooi360_sel('2',g_stce_m.stce001,'','','','','','','','','','4') RETURNING l_success,g_stce_m.ooff013
    END IF
    DISPLAY BY NAME g_stce_m.ooff013
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stce_m.stceownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_stce_m.stceownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stce_m.stceownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stce_m.stceowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stce_m.stceowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stce_m.stceowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stce_m.stcecrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_stce_m.stcecrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stce_m.stcecrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stce_m.stcecrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stce_m.stcecrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stce_m.stcecrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stce_m.stcemodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_stce_m.stcemodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stce_m.stcemodid_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stce_m.stcecnfid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_stce_m.stcecnfid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stce_m.stcecnfid_desc

   CALL astm601_set_visible()
   DISPLAY BY NAME g_stce_m.stce027
   #160513-00033#8--(S)
   IF g_stce_m.stce005 = '11' THEN
      CALL cl_set_comp_visible('page_1',TRUE)
       CALL cl_set_comp_visible('stcf021',TRUE)
   ELSE
      CALL cl_set_comp_visible('page_1',FALSE)
       CALL cl_set_comp_visible('stcf021',FALSE)
   END IF
   #160513-00033#8--(E)
   #end add-point
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_stce_m.stce005,g_stce_m.stce001,g_stce_m.stce002,g_stce_m.stce003,g_stce_m.stce009, 
       g_stce_m.stce009_desc,g_stce_m.stce010,g_stce_m.stce010_desc,g_stce_m.stce011,g_stce_m.stce011_desc,g_stce_m.stce012,g_stce_m.stce012_desc,g_stce_m.stce004,g_stce_m.stce004_desc,g_stce_m.stceunit,g_stce_m.stceunit_desc, 
       g_stce_m.stce021,g_stce_m.stce021_desc,g_stce_m.stce022,g_stce_m.stce022_desc,g_stce_m.stce023,g_stce_m.stce023_desc, 
       g_stce_m.stce006,g_stce_m.stce006_desc,g_stce_m.stce007,g_stce_m.stce007_desc,g_stce_m.stce024, 
       g_stce_m.stce024_desc,g_stce_m.stce028,g_stce_m.stce028_desc,g_stce_m.stce025,g_stce_m.stce025_desc,g_stce_m.stce026,g_stce_m.stce013, 
       g_stce_m.stce014,g_stce_m.stce014_desc,g_stce_m.stce015,g_stce_m.stce015_desc,g_stce_m.stce016,g_stce_m.stce016_desc,g_stce_m.stce017, 
       g_stce_m.stce018,g_stce_m.stce019,g_stce_m.stce020,g_stce_m.stcestus,g_stce_m.stceownid,g_stce_m.stceownid_desc, 
       g_stce_m.stceowndp,g_stce_m.stceowndp_desc,g_stce_m.stcecrtid,g_stce_m.stcecrtid_desc,g_stce_m.stcecrtdp, 
       g_stce_m.stcecrtdp_desc,g_stce_m.stcecrtdt,g_stce_m.stcemodid,g_stce_m.stcemodid_desc,g_stce_m.stcemoddt, 
       g_stce_m.stcecnfid,g_stce_m.stcecnfid_desc,g_stce_m.stcecnfdt
   
   #顯示狀態(stus)圖片
         #此段落由子樣板a21產生
      CASE g_stce_m.stcestus
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
 
 
         
      END CASE
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_stcf_d.getLength()
      #帶出公用欄位reference值
      
      #add-point:show段單身reference
                  INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stcf_d[l_ac].stcf002
            CALL ap_ref_array2(g_ref_fields,"SELECT stael003 FROM stael_t WHERE staelent='"||g_enterprise||"' AND stael001=? AND stael002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stcf_d[l_ac].stcf002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stcf_d[l_ac].stcf002_desc

            CALL astm601_stcf008_ref()
            CALL astm601_stcf009_ref()            
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_stcf2_d.getLength()
      #帶出公用欄位reference值
      
      #add-point:show段單身reference
                 CALL astm601_stch002_ref()

      #end add-point
   END FOR
 
 
   
    
   
   #add-point:show段other
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL astm601_detail_show()
   
   #add-point:show段之後
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="astm601.detail_show" >}
#+ 單身reference detail_show
PRIVATE FUNCTION astm601_detail_show()
   {<Local define>}
   DEFINE l_ac_t    LIKE type_t.num5
   {</Local define>}
   #add-point:detail_show段define
   
   #end add-point  
 
   #add-point:detail_show段之前
   
   #end add-point
   
   LET l_ac_t = l_ac
 
   LET l_ac = l_ac_t
   
   #add-point:detail_show段之後
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="astm601.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION astm601_reproduce()
   {<Local define>}
   DEFINE l_newno     LIKE stce_t.stce001 
   DEFINE l_oldno     LIKE stce_t.stce001 
 
   DEFINE l_master    RECORD LIKE stce_t.*
   DEFINE l_detail    RECORD LIKE stcf_t.*
   DEFINE l_detail2    RECORD LIKE stch_t.*
 
 
 
   DEFINE l_cnt       LIKE type_t.num5
   {</Local define>}
   #add-point:reproduce段define
   DEFINE l_insert      LIKE type_t.num5
   #end add-point   
 
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   IF g_stce_m.stce001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      RETURN
   END IF
    
   LET g_stce001_t = g_stce_m.stce001
 
    
   LET g_stce_m.stce001 = ""
 
    
   CALL astm601_set_entry('a')
   CALL astm601_set_no_entry('a')
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #此段落由子樣板a14產生    
      LET g_stce_m.stceownid = g_user
      LET g_stce_m.stceowndp = g_dept
      LET g_stce_m.stcecrtid = g_user
      LET g_stce_m.stcecrtdp = g_dept 
      LET g_stce_m.stcecrtdt = cl_get_current()
      LET g_stce_m.stcemodid = ""
      LET g_stce_m.stcemoddt = ""
      #LET g_stce_m.stcestus = ""
 
 
   
   #add-point:複製輸入前
      LET g_stce_m.stce002 = ''
#      LET g_stce_m.stceunit = g_site
      LET g_site_flag = FALSE
      CALL s_aooi500_default(g_prog,'stceunit',g_stce_m.stceunit)
         RETURNING l_insert,g_stce_m.stceunit
      IF NOT l_insert THEN
         RETURN
      END IF
        CALL astm601_stceunit_ref()
        LET g_stce_m.stce001 = ''
      LET g_stce_m.stcecnfid = ""
      LET g_stce_m.stcecnfdt = ""
      LET g_stce_m.stcestus = 'N'
      LET g_stce_m.stcecnfid_desc = ''
      LET g_stce_m.stcemodid_desc = ''
      DISPLAY BY NAME g_stce_m.*        
   #end add-point
   
   CALL astm601_input("r")
   
   
   
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN
   END IF
 
   LET g_state = "Y"
   
   LET g_wc = g_wc,  
              " OR (",
              " stce001 = '", g_stce_m.stce001 CLIPPED, "' "
 
              , ") "
   
   #add-point:完成複製段落後
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="astm601.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION astm601_detail_reproduce()
   {<Local define>}
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE stcf_t.*
   DEFINE l_detail2    RECORD LIKE stch_t.*
 
 
 
   {</Local define>}
   #add-point:delete段define
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE astm601_detail
   
   #add-point:單身複製前1
   
   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE astm601_detail AS ",
                "SELECT * FROM stcf_t "
   PREPARE repro_tbl FROM ls_sql
   EXECUTE repro_tbl
   FREE repro_tbl
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO astm601_detail SELECT * FROM stcf_t 
                                         WHERE stcfent = g_enterprise AND stcf001 = g_stce001_t
 
   
   #將key修正為調整後   
   UPDATE astm601_detail 
      #更新key欄位
      SET stcf001 = g_stce_m.stce001
 
      #更新共用欄位
      
                                       
  
   #將資料塞回原table   
   INSERT INTO stcf_t SELECT * FROM astm601_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "reproduce"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      RETURN
   END IF
   
   #add-point:單身複製中1
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE astm601_detail
   
   #add-point:單身複製後1
       LET ls_sql = 
      "CREATE GLOBAL TEMPORARY TABLE astm601_detail AS ",
      "SELECT * FROM stcg_t "
   PREPARE repro_tbl3 FROM ls_sql
   EXECUTE repro_tbl3
   FREE repro_tbl3
   
    #將符合條件的資料丟入TEMP TABLE
   INSERT INTO astm601_detail SELECT * FROM stcg_t
                                         WHERE stcgent = g_enterprise AND stcg001 = g_stce001_t
                                         
    #將key修正為調整後   
   UPDATE astm601_detail SET stcg001 = g_stce_m.stce001
 
  
   #將資料塞回原table   
   INSERT INTO stcg_t SELECT * FROM astm601_detail
     
    
   #end add-point
 
   #add-point:單身複製前
       #刪除TEMP TABLE
   DROP TABLE astm601_detail
   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = 
      "CREATE GLOBAL TEMPORARY TABLE astm601_detail AS ",
      "SELECT * FROM stch_t "
   PREPARE repro_tbl2 FROM ls_sql
   EXECUTE repro_tbl2
   FREE repro_tbl2
      
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO astm601_detail SELECT * FROM stch_t
                                         WHERE stchent = g_enterprise AND stch001 = g_stce001_t
 
 
   #將key修正為調整後   
   UPDATE astm601_detail SET stch001 = g_stce_m.stce001
 
  
   #將資料塞回原table   
   INSERT INTO stch_t SELECT * FROM astm601_detail
   
   #add-point:單身複製中
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE astm601_detail
   
   #add-point:單身複製後
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_stce001_t = g_stce_m.stce001
 
   
   DROP TABLE astm601_detail
   
END FUNCTION
 
{</section>}
 
{<section id="astm601.delete" >}
#+ 資料刪除
PRIVATE FUNCTION astm601_delete()
   {<Local define>}
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:delete段define
   
   #end add-point     
   
   IF g_stce_m.stce001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      RETURN
   END IF
 
    SELECT UNIQUE stce005,stce001,stce002,stce003,stce009,stce010,stce011,stce012,stce004,stceunit,stcesite,stce027,stce021,stce022,stce023,stce006, 
        stce007,stce024,stce028,stce025,stce026,stce013,stce014,stce015,stce017,stce018,stce019,stce020,stcestus, 
        stceownid,stceowndp,stcecrtid,stcecrtdp,stcecrtdt,stcemodid,stcemoddt,stcecnfid,stcecnfdt
 INTO g_stce_m.stce005,g_stce_m.stce001,g_stce_m.stce002,g_stce_m.stce003,g_stce_m.stce009,g_stce_m.stce010,g_stce_m.stce011,g_stce_m.stce012,g_stce_m.stce004, 
     g_stce_m.stceunit,g_stce_m.stcesite,g_stce_m.stce027,g_stce_m.stce021,g_stce_m.stce022,g_stce_m.stce023,g_stce_m.stce006,g_stce_m.stce007, 
     g_stce_m.stce024,g_stce_m.stce028,g_stce_m.stce025,g_stce_m.stce026,g_stce_m.stce013,g_stce_m.stce014,g_stce_m.stce015,g_stce_m.stce016, 
     g_stce_m.stce017,g_stce_m.stce018,g_stce_m.stce019,g_stce_m.stce020,g_stce_m.stcestus,g_stce_m.stceownid, 
     g_stce_m.stceowndp,g_stce_m.stcecrtid,g_stce_m.stcecrtdp,g_stce_m.stcecrtdt,g_stce_m.stcemodid, 
     g_stce_m.stcemoddt,g_stce_m.stcecnfid,g_stce_m.stcecnfdt
 FROM stce_t
 WHERE stceent = g_enterprise AND stce001 = g_stce_m.stce001
   
   
 
   CALL astm601_show()
   
   CALL s_transaction_begin()
 
   OPEN astm601_cl USING g_enterprise,g_stce_m.stce001
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN astm601_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      CLOSE astm601_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   FETCH astm601_cl INTO g_stce_m.stce005,g_stce_m.stce001,g_stce_m.stce002,g_stce_m.stce003,g_stce_m.stce009, 
       g_stce_m.stce009_desc,g_stce_m.stce004,g_stce_m.stce004_desc,g_stce_m.stceunit,g_stce_m.stceunit_desc, 
       g_stce_m.stce021,g_stce_m.stce021_desc,g_stce_m.stce022,g_stce_m.stce022_desc,g_stce_m.stce023,g_stce_m.stce023_desc, 
       g_stce_m.stce006,g_stce_m.stce006_desc,g_stce_m.stce007,g_stce_m.stce007_desc,g_stce_m.stce024, 
       g_stce_m.stce024_desc,g_stce_m.stce025,g_stce_m.stce025_desc,g_stce_m.stce026,g_stce_m.stce013, 
       g_stce_m.stce014,g_stce_m.stce014_desc,g_stce_m.stce015,g_stce_m.stce015_desc,g_stce_m.stce017, 
       g_stce_m.stce018,g_stce_m.stce019,g_stce_m.stce020,g_stce_m.stcestus,g_stce_m.stceownid,g_stce_m.stceownid_desc, 
       g_stce_m.stceowndp,g_stce_m.stceowndp_desc,g_stce_m.stcecrtid,g_stce_m.stcecrtid_desc,g_stce_m.stcecrtdp, 
       g_stce_m.stcecrtdp_desc,g_stce_m.stcecrtdt,g_stce_m.stcemodid,g_stce_m.stcemodid_desc,g_stce_m.stcemoddt, 
       g_stce_m.stcecnfid,g_stce_m.stcecnfid_desc,g_stce_m.stcecnfdt              #鎖住將被更改或取消的資料 
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_stce_m.stce001
      LET g_errparam.popup = FALSE
      CALL cl_err()
          #資料被他人LOCK
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #IF NOT cl_ask_delete() THEN             #確認一下
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前
      
      #end add-point   
      
      INITIALIZE g_doc.* TO NULL         
      LET g_doc.column1 = "stce001"       
      LET g_doc.value1 = g_stce_m.stce001     
      CALL cl_doc_remove() 
 
      #資料備份
      LET g_stce001_t = g_stce_m.stce001
 
 
      DELETE FROM stce_t
       WHERE stceent = g_enterprise AND stce001 = g_stce_m.stce001
 
       
      #add-point:單頭刪除中
      
      #end add-point
       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_stce_m.stce001
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      #add-point:單頭刪除後
      
      #end add-point
  
      #add-point:單身刪除前
            DELETE FROM stcg_t
       WHERE stcgent = g_enterprise AND stcg001 = g_stce_m.stce001
       IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "stcg_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
       END IF   
      CALL g_stcg_d.clear()
      CALL g_stcl_d.clear()   #160513-00033#8
      #end add-point
      
      DELETE FROM stcf_t
       WHERE stcfent = g_enterprise AND stcf001 = g_stce_m.stce001
 
 
      #add-point:單身刪除中
      
      #end add-point
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "stcf_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF    
 
      #add-point:單身刪除後
      
      #end add-point
      
            
                                                               
      #add-point:單身刪除前
      
      #end add-point
      DELETE FROM stch_t
       WHERE stchent = g_enterprise AND
             stch001 = g_stce_m.stce001
      #add-point:單身刪除中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "stch_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF      
 
      #add-point:單身刪除後
      CALL g_stcl_d.clear()   #160513-00033#8
      #end add-point
 
 
 
 
                                                               
      CLEAR FORM
      CALL g_stcf_d.clear() 
      CALL g_stcf2_d.clear()       
 
 
     
      CALL astm601_ui_browser_refresh()  
      CALL astm601_ui_headershow()  
      CALL astm601_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL astm601_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
      ELSE
         LET g_wc = " 1=1"
         CALL astm601_browser_fill("F")
      END IF
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
 
 
   
   END IF
 
   CALL s_transaction_end('Y','0')
   
   CLOSE astm601_cl
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_stce_m.stce001,'D')
    
END FUNCTION
 
{</section>}
 
{<section id="astm601.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION astm601_b_fill()
   {<Local define>}
   DEFINE p_wc2      STRING
   {</Local define>}
   #add-point:b_fill段define
   
   #end add-point     
 
   CALL g_stcf_d.clear()    #g_stcf_d 單頭及單身 
   CALL g_stcf2_d.clear()
 
 
 
   #add-point:b_fill段sql_before
   CALL g_stcw_d.clear()
   CALL g_stcl_d.clear()   #160513-00033#8
   #end add-point
   
   #判斷是否填充
   IF astm601_fill_chk(1) THEN
   
      LET g_sql = "SELECT  UNIQUE stcfseq,stcf002,'',stcf021,stcf003,stcf004,stcf005,stcf006,stcf007,stcf008,  
          '',stcf009,'',stcf010,stcf011,stcf012,stcf013,stcf014,stcf015,stcf016,stcf017,stcf018,stcfsite,stcfunit FROM stcf_t", 
             
                  " INNER JOIN stce_t ON stce001 = stcf001 ",
 
                  #"",
                  
                  "",
                  " WHERE stcfent=? AND stcf001=?"
      #add-point:b_fill段sql_before
      
      #end add-point
      IF NOT cl_null(g_wc2_table1) THEN
         LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY stcf_t.stcfseq"
      
      #add-point:單身填充控制
            LET g_sql = "SELECT  UNIQUE stcfseq,stcf002,'',stcf021,stcf003,stcf004,stcf005,stcf006,stcf007,stcf008,'',stcf009,'',stcf010,stcf011,stcf012,stcf013,stcf014,stcf015,stcf016,stcf017,stcf018,stcf019,stcf020,stcfsite,stcfunit FROM stcf_t",   
                  " INNER JOIN stce_t ON stce001 = stcf001 ",
                  " LEFT JOIN stcg_t ON stcgent = stcfent AND stcf001 = stcg001 AND stcfseq = stcgseq1 ",      
               
                  " WHERE stcfent=? AND stcf001=?"
      
      IF NOT cl_null(g_wc2_table1) THEN
         LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
      END IF
      IF NOT cl_null(g_wc2_table3) THEN
         LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table3 CLIPPED
      END IF
   
      LET g_sql = g_sql, " ORDER BY stcf_t.stcfseq"
      #end add-point
      
      PREPARE astm601_pb FROM g_sql
      DECLARE b_fill_cs CURSOR FOR astm601_pb
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs USING g_enterprise,g_stce_m.stce001
 
                                               
      FOREACH b_fill_cs INTO g_stcf_d[l_ac].stcfseq,g_stcf_d[l_ac].stcf002,g_stcf_d[l_ac].stcf002_desc,g_stcf_d[l_ac].stcf021,  
          g_stcf_d[l_ac].stcf003,g_stcf_d[l_ac].stcf004,g_stcf_d[l_ac].stcf005,g_stcf_d[l_ac].stcf006, 
          g_stcf_d[l_ac].stcf007,g_stcf_d[l_ac].stcf008,g_stcf_d[l_ac].stcf008_desc,g_stcf_d[l_ac].stcf009, 
          g_stcf_d[l_ac].stcf009_desc,g_stcf_d[l_ac].stcf010,g_stcf_d[l_ac].stcf011,g_stcf_d[l_ac].stcf012, 
          g_stcf_d[l_ac].stcf013,g_stcf_d[l_ac].stcf014,g_stcf_d[l_ac].stcf015,g_stcf_d[l_ac].stcf016, 
          g_stcf_d[l_ac].stcf017,g_stcf_d[l_ac].stcf018,g_stcf_d[l_ac].stcf019,g_stcf_d[l_ac].stcf020,g_stcf_d[l_ac].stcfsite,g_stcf_d[l_ac].stcfunit
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充
                  CALL astm601_stcf002_ref() 
         CALL astm601_stcf008_ref()
         CALL astm601_stcf009_ref()
         IF cl_null(g_stcf_d[l_ac].stcf021) THEN LET g_stcf_d[l_ac].stcf021 = 'N' END IF  #160513-00033#8
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec AND g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            EXIT FOREACH
         END IF
         
      END FOREACH
      LET g_error_show = 0
   
   END IF
   
   #判斷是否填充
   IF astm601_fill_chk(2) THEN
      LET g_sql = "SELECT  UNIQUE stchseq,stch002,'',stch003,stchsite,stchunit FROM stch_t",   
                  " INNER JOIN stce_t ON stce001 = stch001 ",
 
                  "",
                  
                  " WHERE stchent=? AND stch001=?"   
      #add-point:b_fill段sql_before
      
      #end add-point
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY stch_t.stchseq"
      
      #add-point:單身填充控制
      
      #end add-point
      
      PREPARE astm601_pb2 FROM g_sql
      DECLARE b_fill_cs2 CURSOR FOR astm601_pb2
      
      LET l_ac = 1
      
      OPEN b_fill_cs2 USING g_enterprise,g_stce_m.stce001
 
                                               
      FOREACH b_fill_cs2 INTO g_stcf2_d[l_ac].stchseq,g_stcf2_d[l_ac].stch002,g_stcf2_d[l_ac].stch002_desc, 
          g_stcf2_d[l_ac].stch003,g_stcf2_d[l_ac].stchsite,g_stcf2_d[l_ac].stchunit
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充
               CALL astm601_stch002_ref()
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = FALSE
            CALL cl_err()
 
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
 
   
   #add-point:browser_fill段其他table處理
    IF astm601_fill_chk(4) THEN
      LET g_sql = "SELECT  UNIQUE stcwsite,stcwunit,stcwseq,stcw002,stcw003,stcw004,stcw005,stcw006 FROM stcw_t",   
                  " INNER JOIN stce_t ON stce001 = stcw001 AND stceent = stcwent ",
 
                  "",
                  
                  " WHERE stcwent=? AND stcw001=?"   
      #add-point:b_fill段sql_before
      
      #end add-point
      IF NOT cl_null(g_wc2_table4) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY stcw_t.stcwseq"
      
      #add-point:單身填充控制
      
      #end add-point
      
      PREPARE astm601_pb4 FROM g_sql
      DECLARE b_fill_cs4 CURSOR FOR astm601_pb4
      
      LET l_ac = 1
      
      OPEN b_fill_cs4 USING g_enterprise,g_stce_m.stce001
 
                                               
      FOREACH b_fill_cs4 INTO g_stcw_d[l_ac].stcwsite,g_stcw_d[l_ac].stcwunit,g_stcw_d[l_ac].stcwseq, g_stcw_d[l_ac].stcw002, 
          g_stcw_d[l_ac].stcw003,g_stcw_d[l_ac].stcw004,g_stcw_d[l_ac].stcw005,g_stcw_d[l_ac].stcw006
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
    
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = FALSE
            CALL cl_err()

            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
   CALL g_stcw_d.deleteElement(g_stcw_d.getLength())
   #160513-00033#8--(S)
   LET g_sql = "SELECT UNIQUE stclseq,stcl002,stcl003,stcl004,stcl005 ",
               "             ,stcl006,stcl007,stcl008,stcl009,stcl010 ",
               "             ,stcl011,stcl012,stcl013,stcl014 ",
               "  FROM stcl_t",
               " WHERE stclent = ? AND stcl001 = ?",
               " ORDER BY stclseq"
   PREPARE astm601_pb5 FROM g_sql
   DECLARE b_fill_cs5 CURSOR FOR astm601_pb5      
   LET l_ac = 1   
   OPEN b_fill_cs5 USING g_enterprise,g_stce_m.stce001
   FOREACH b_fill_cs5 INTO g_stcl_d[l_ac].stclseq,g_stcl_d[l_ac].stcl002,g_stcl_d[l_ac].stcl003,g_stcl_d[l_ac].stcl004,g_stcl_d[l_ac].stcl005 
                          ,g_stcl_d[l_ac].stcl006,g_stcl_d[l_ac].stcl007,g_stcl_d[l_ac].stcl008,g_stcl_d[l_ac].stcl009,g_stcl_d[l_ac].stcl010 
                          ,g_stcl_d[l_ac].stcl011,g_stcl_d[l_ac].stcl012,g_stcl_d[l_ac].stcl013,g_stcl_d[l_ac].stcl014 
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      CALL s_desc_get_acc_desc('2147',g_stcl_d[l_ac].stcl002) RETURNING g_stcl_d[l_ac].stcl002_desc
      CALL s_desc_get_item_desc(g_stcl_d[l_ac].stcl003) RETURNING g_stcl_d[l_ac].imaal003,g_stcl_d[l_ac].imaal004
      SELECT stabl003 INTO g_stcl_d[l_ac].stcl010_desc
        FROM stabl_t 
       WHERE stablent = g_enterprise AND stabl001 = g_stcl_d[l_ac].stcl010 AND stabl002 = g_lang
      CALL s_desc_get_acc_desc('2146',g_stcl_d[l_ac].stcl014) RETURNING g_stcl_d[l_ac].stcl014_desc
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
   END FOREACH
   #160513-00033#8--(E)
   #end add-point
   
   CALL g_stcf_d.deleteElement(g_stcf_d.getLength())
   CALL g_stcf2_d.deleteElement(g_stcf2_d.getLength())
 
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE astm601_pb
   FREE astm601_pb2
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="astm601.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION astm601_delete_b(ps_table,ps_keys_bak,ps_page)
   {<Local define>}
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:delete_b段define
   
   #end add-point     
 
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point    
      DELETE FROM stcf_t
       WHERE stcfent = g_enterprise AND
         stcf001 = ps_keys_bak[1] AND stcfseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中
      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
      END IF
      #add-point:delete_b段刪除後
      
      #end add-point   
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point    
      DELETE FROM stch_t
       WHERE stchent = g_enterprise AND
         stch001 = ps_keys_bak[1] AND stchseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中
      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "stch_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
      END IF
      #add-point:delete_b段刪除後
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="astm601.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION astm601_insert_b(ps_table,ps_keys,ps_page)
   {<Local define>}
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   {</Local define>}
   #add-point:insert_b段define
      LET ls_group = "'3',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前

      #end add-point 
      INSERT INTO stcg_t
                  (stcgent,stcg001,stcgseq1,stcgseq2,stcg002,stcg003,stcg004,stcgsite,stcgunit)
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],
                   g_stcg_d[l_ac3].stcgseq2,g_stcg_d[l_ac3].stcg002,g_stcg_d[l_ac3].stcg003,g_stcg_d[l_ac3].stcg004,
                   g_stcg_d[l_ac3].stcgsite,g_stcg_d[l_ac3].stcgunit)
      #add-point:insert_b段資料新增中

      #end add-point 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "stcg_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
 
   END IF
   
       LET ls_group = "'4',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前

      #end add-point 
      INSERT INTO stcw_t
                  (stcwent,stcwsite,stcwunit,stcwseq,stcw001,stcw002,stcw003,stcw004,stcw005,stcw006)
            VALUES(g_enterprise,g_stcw_d[l_ac].stcwsite,g_stcw_d[l_ac].stcwunit,
                   ps_keys[2],ps_keys[1],
                   g_stcw_d[l_ac].stcw002,g_stcw_d[l_ac].stcw003,g_stcw_d[l_ac].stcw004,g_stcw_d[l_ac].stcw005,
                   g_stcw_d[l_ac].stcw006)
      #add-point:insert_b段資料新增中

      #end add-point 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "stcw_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:insert_b段資料新增後

      #end add-point 
   END IF
   #end add-point     
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前
      
      #end add-point 
      INSERT INTO stcf_t
                  (stcfent,
                   stcf001,
                   stcfseq
                   ,stcf002,stcf003,stcf004,stcf005,stcf006,stcf007,stcf008,stcf009,stcf010,stcf011,stcf012,stcf013,stcf014,stcf015,stcf016,stcf017,stcf018,stcf019,stcf020,stcfsite,stcfunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_stcf_d[g_detail_idx].stcf002,g_stcf_d[g_detail_idx].stcf003,g_stcf_d[g_detail_idx].stcf004, 
                       g_stcf_d[g_detail_idx].stcf005,g_stcf_d[g_detail_idx].stcf006,g_stcf_d[g_detail_idx].stcf007, 
                       g_stcf_d[g_detail_idx].stcf008,g_stcf_d[g_detail_idx].stcf009,g_stcf_d[g_detail_idx].stcf010, 
                       g_stcf_d[g_detail_idx].stcf011,g_stcf_d[g_detail_idx].stcf012,g_stcf_d[g_detail_idx].stcf013, 
                       g_stcf_d[g_detail_idx].stcf014,g_stcf_d[g_detail_idx].stcf015,g_stcf_d[g_detail_idx].stcf016, 
                       g_stcf_d[g_detail_idx].stcf017,g_stcf_d[g_detail_idx].stcf018,g_stcf_d[g_detail_idx].stcf019,g_stcf_d[g_detail_idx].stcf020,g_stcf_d[g_detail_idx].stcfsite,g_stcf_d[g_detail_idx].stcfunit)
      #add-point:insert_b段資料新增中
      
      #end add-point 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "stcf_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
      END IF
      #add-point:insert_b段資料新增後
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前
      
      #end add-point 
      INSERT INTO stch_t
                  (stchent,
                   stch001,
                   stchseq
                   ,stch002,stch003,stchsite,stchunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_stcf2_d[g_detail_idx].stch002,g_stcf2_d[g_detail_idx].stch003,g_stcf2_d[g_detail_idx].stchsite,g_stcf2_d[g_detail_idx].stchunit)
      #add-point:insert_b段資料新增中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "stch_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
      END IF
      #add-point:insert_b段資料新增後
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="astm601.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION astm601_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   {<Local define>}
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num5 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:update_b段define
   
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
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "stcf_t" THEN
      #add-point:update_b段修改前
      
      #end add-point     
      UPDATE stcf_t 
         SET (stcf001,
              stcfseq
              ,stcf002,stcf003,stcf004,stcf005,stcf006,stcf007,stcf008,stcf009,stcf010,stcf011,stcf012,stcf013,stcf014,stcf015,stcf016,stcf017,stcf018,stcf019) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_stcf_d[g_detail_idx].stcf002,g_stcf_d[g_detail_idx].stcf003,g_stcf_d[g_detail_idx].stcf004, 
                  g_stcf_d[g_detail_idx].stcf005,g_stcf_d[g_detail_idx].stcf006,g_stcf_d[g_detail_idx].stcf007, 
                  g_stcf_d[g_detail_idx].stcf008,g_stcf_d[g_detail_idx].stcf009,g_stcf_d[g_detail_idx].stcf010, 
                  g_stcf_d[g_detail_idx].stcf011,g_stcf_d[g_detail_idx].stcf012,g_stcf_d[g_detail_idx].stcf013, 
                  g_stcf_d[g_detail_idx].stcf014,g_stcf_d[g_detail_idx].stcf015,g_stcf_d[g_detail_idx].stcf016, 
                  g_stcf_d[g_detail_idx].stcf017,g_stcf_d[g_detail_idx].stcf018,g_stcf_d[g_detail_idx].stcf019) 
         WHERE stcfent = g_enterprise AND stcf001 = ps_keys_bak[1] AND stcfseq = ps_keys_bak[2]
      #add-point:update_b段修改中
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "stcf_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "stcf_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後
      
      #end add-point  
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "stch_t" THEN
      #add-point:update_b段修改前
      
      #end add-point     
      UPDATE stch_t 
         SET (stch001,
              stchseq
              ,stch002,stch003) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_stcf2_d[g_detail_idx].stch002,g_stcf2_d[g_detail_idx].stch003) 
         WHERE stchent = g_enterprise AND stch001 = ps_keys_bak[1] AND stchseq = ps_keys_bak[2]
      #add-point:update_b段修改中
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "stch_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "stch_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後
      
      #end add-point  
   END IF
 
 
   
 
   
 
   
   #add-point:update_b段other
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="astm601.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION astm601_lock_b(ps_table,ps_page)
   {<Local define>}
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:lock_b段define
      IF ps_table = "stcg_t" THEN
      OPEN astm601_bcl3 USING g_enterprise,
                                       g_stce_m.stce001,g_stcf_d[l_ac].stcfseq,g_stcg_d[l_ac3].stcgseq2
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "astm601_bcl3"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF
   
   IF ps_table = "stcw_t" THEN
      OPEN astm601_bcl4 USING g_enterprise,
                                       g_stce_m.stce001,g_stcw_d[l_ac].stcwseq
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "astm601_bcl4"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF
   #end add-point   
   
   #先刷新資料
   #CALL astm601_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "stcf_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN astm601_bcl USING g_enterprise,
                                       g_stce_m.stce001,g_stcf_d[g_detail_idx].stcfseq
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "astm601_bcl"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         RETURN FALSE
      END IF
   
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "stch_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN astm601_bcl2 USING g_enterprise,
                                             g_stce_m.stce001,g_stcf2_d[g_detail_idx].stchseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "astm601_bcl2"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         RETURN FALSE
      END IF
   END IF
 
 
   
 
   
   #add-point:lock_b段other
   
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="astm601.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION astm601_unlock_b(ps_table,ps_page)
   {<Local define>}
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:unlock_b段define
 
   #end add-point  
   
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE astm601_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE astm601_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,3) THEN
      CLOSE astm601_bcl3
   END IF
   LET ls_group = "'4',"
   
   IF ls_group.getIndexOf(ps_page,4) THEN
      CLOSE astm601_bcl4
   END IF
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="astm601.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION astm601_set_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1  
   {</Local define>}
   #add-point:set_entry段define
   
   #end add-point       
 
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("stce001",TRUE)
      #add-point:set_entry段欄位控制
      CALL cl_set_comp_entry("stce004",TRUE)
      CALL cl_set_comp_entry("stceunit",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後
   IF cl_null(g_stce_m.stce010) THEN
      CALL cl_set_comp_entry("stce027",FALSE)
      CALL cl_set_comp_entry("stce021,stce022,stce023,stce024,stce026",TRUE) 
   ELSE
      CALL cl_set_comp_entry("stce027",TRUE)
      CALL cl_set_comp_entry("stce021,stce022,stce023,stce024,stce026",FALSE)
   END IF


   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="astm601.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION astm601_set_no_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1   
   {</Local define>}
   #add-point:set_no_entry段define
   DEFINE l_n     LIKE type_t.num5
   #end add-point     
 
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("stce001",FALSE)
      #add-point:set_no_entry段欄位控制
      CALL cl_set_comp_entry("stce004",FALSE)
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後
   
   SELECT COUNT(*) INTO l_n FROM stcw_t
    WHERE stcwent = g_enterprise AND stcw001 = g_stce_m.stce001 AND stcw005 = 'Y'
   IF l_n > 0 THEN
      CALL cl_set_comp_entry("stce017",FALSE)
   ELSE
      CALL cl_set_comp_entry("stce017",TRUE)
   END IF
   IF NOT s_aooi500_comp_entry(g_prog,'stceunit') OR g_site_flag THEN
      CALL cl_set_comp_entry("stceunit",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="astm601.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION astm601_set_entry_b(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1   
   {</Local define>}
   #add-point:set_entry_b段define
      DEFINE l_n     LIKE type_t.num5
   DEFINE l_staf003 LIKE staf_t.staf003
   DEFINE l_staf004 LIKE staf_t.staf004
   DEFINE l_staf005 LIKE staf_t.staf005
   DEFINE l_stcf004 LIKE stcf_t.stcf004
   #end add-point     
   #add-point:set_entry_b段
      CALL astm601_init_entry(p_cmd)
   IF NOT cl_null(g_stcf_d[l_ac].stcf002) THEN
      #檢查費用編號+經營方式是否存在asti204
      
      SELECT COUNT(*) INTO l_n FROM staf_t
       WHERE stafent = g_enterprise AND staf001= g_stcf_d[l_ac].stcf002 AND staf002 = g_stce_m.stce005
      IF l_n > 0 THEN
         DECLARE sel_staf CURSOR FOR 
          SELECT staf003,staf004,staf005 FROM staf_t
           WHERE  stafent = g_enterprise AND staf001= g_stcf_d[l_ac].stcf002 AND staf002 = g_stce_m.stce005
         FOREACH sel_staf INTO l_staf003,l_staf004,l_staf005
             LET l_staf003 = cl_str_replace(l_staf003,"stao","stcf")
             CALL astm601_convert(l_staf003)  RETURNING l_staf003
            IF l_staf004 = 'Y' THEN
               CALL cl_set_comp_entry(l_staf003,TRUE)
            END IF
         END FOREACH 
      ELSE
         IF g_stcf_d[l_ac].stcf005 = '1' THEN    #變動
            IF g_stcf_d[l_ac].stcf015 = '1' THEN      
               CALL cl_set_comp_entry('stcf011',TRUE)
            END IF
            CALL cl_set_comp_entry('stcf008,stcf009',TRUE)
            CALL cl_set_comp_entry('stcf012,stcf013,stcf014,stcf015',TRUE)
         ELSE                                    #固定
            CALL cl_set_comp_entry('stcf010',TRUE)
         END IF
         IF g_stcf_d[l_ac].stcf012 <> '1' THEN    #保底

            CALL cl_set_comp_entry('stcf013,stcf014',TRUE)
         END IF
         
          #抓取价款类型
          SELECT stae006 INTO  l_stcf004 FROM stae_t WHERE staeent = g_enterprise AND stae001 = g_stcf_d[l_ac].stcf002
          IF l_stcf004 = '3' THEN
             CALL cl_set_comp_entry('stcf004',TRUE)
          ELSE
             CALL cl_set_comp_entry('stcf004',FALSE)
          END IF     
      END IF    
   ELSE
      IF g_stcf_d[l_ac].stcf005 = '1' THEN    #變動
         IF g_stcf_d[l_ac].stcf015 = '1' THEN      
            CALL cl_set_comp_entry('stcf011',TRUE)
         END IF
         CALL cl_set_comp_entry('stcf008,stcf009',TRUE)
         CALL cl_set_comp_entry('stcf012,stcf013,stcf014,stcf015',TRUE)
      ELSE                                    #固定
         CALL cl_set_comp_entry('stcf010',TRUE)
      END IF
      IF g_stcf_d[l_ac].stcf012 <> '1' THEN    #保底
 
         CALL cl_set_comp_entry('stcf013,stcf014',TRUE)
      END IF
   END IF   
  
  ##费用编号不为空
  #IF NOT cl_null(g_stcf_d[l_ac].stcf002) THEN
  #   #抓取价款类型
  #   SELECT stae006 INTO  l_stcf004 FROM stae_t WHERE staeent = g_enterprise AND stae001 = g_stcf_d[l_ac].stcf002
  #   IF l_stcf004 = '3' THEN
  #      CALL cl_set_comp_entry('stcf004',TRUE)
  #   ELSE
  #      CALL cl_set_comp_entry('stcf004',FALSE)
  #   END IF       
  #END IF
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="astm601.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION astm601_set_no_entry_b(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1   
   {</Local define>}
   #add-point:set_no_entry_b段define
      DEFINE l_n     LIKE type_t.num5
   DEFINE l_staf003 LIKE staf_t.staf003
   DEFINE l_staf004 LIKE staf_t.staf004
   DEFINE l_staf005 LIKE staf_t.staf005
   #end add-point    
   #add-point:set_no_entry_b段
       
   
    
    IF NOT cl_null(g_stcf_d[l_ac].stcf002) THEN
      #檢查費用編號+經營方式是否存在asti204
      
      SELECT COUNT(*) INTO l_n FROM staf_t
       WHERE stafent = g_enterprise AND staf001= g_stcf_d[l_ac].stcf002 AND staf002 = g_stce_m.stce005
      IF l_n > 0 THEN
         DECLARE sel_staf_ne CURSOR FOR 
          SELECT staf003,staf004,staf005 FROM staf_t
           WHERE  stafent = g_enterprise AND staf001= g_stcf_d[l_ac].stcf002 AND staf002 = g_stce_m.stce005
 
         FOREACH sel_staf_ne INTO l_staf003,l_staf004,l_staf005
            LET l_staf003 = cl_str_replace(l_staf003,"stao","stcf")
            CALL astm601_convert(l_staf003)  RETURNING l_staf003
            IF l_staf004 = 'N' THEN
               CALL cl_set_comp_entry(l_staf003,FALSE)
            END IF
         END FOREACH 
      ELSE
         IF g_stcf_d[l_ac].stcf005 = '1' THEN    #變動
            IF g_stcf_d[l_ac].stcf015 <> '1' THEN      
               LET g_stcf_d[l_ac].stcf011 = ''
               CALL cl_set_comp_entry('stcf011',FALSE)
            END IF
         ELSE                                    #固定
            LET g_stcf_d[l_ac].stcf008 = ''
            LET g_stcf_d[l_ac].stcf008_desc = ''
            LET g_stcf_d[l_ac].stcf009 = ''
            LET g_stcf_d[l_ac].stcf009_desc = ''
            LET g_stcf_d[l_ac].stcf011 = ''
            LET g_stcf_d[l_ac].stcf012 = '1'
            LET g_stcf_d[l_ac].stcf013 = ''
            LET g_stcf_d[l_ac].stcf014 = ''
            LET g_stcf_d[l_ac].stcf015 = '1'
            CALL cl_set_comp_entry('stcf008,stcf009,stcf011',FALSE)
            CALL cl_set_comp_entry('stcf012,stcf013,stcf014,stcf015',FALSE)
   
         END IF
         
         IF g_stcf_d[l_ac].stcf012 = '1' THEN    #保底
            LET g_stcf_d[l_ac].stcf013 = ''
            LET g_stcf_d[l_ac].stcf014 = ''
            CALL cl_set_comp_entry('stcf013,stcf014',FALSE)
         END IF
      END IF  
   ELSE
      IF g_stcf_d[l_ac].stcf005 = '1' THEN    #變動
         IF g_stcf_d[l_ac].stcf015 <> '1' THEN      
            LET g_stcf_d[l_ac].stcf011 = ''
            CALL cl_set_comp_entry('stcf011',FALSE)
         END IF
      ELSE                                    #固定
         LET g_stcf_d[l_ac].stcf011 = ''
         CALL cl_set_comp_entry('stcf011',FALSE)
      END IF
      
      IF g_stcf_d[l_ac].stcf012 = '1' THEN    #保底
         LET g_stcf_d[l_ac].stcf013 = ''
         LET g_stcf_d[l_ac].stcf014 = ''
         CALL cl_set_comp_entry('stcf013,stcf014',FALSE)
      END IF   
   END IF   
  
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="astm601.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION astm601_default_search()
   {<Local define>}
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   {</Local define>}
   #add-point:default_search段define
   
   #end add-point  
   
   #add-point:default_search段開始前
   
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " stce001 = '", g_argv[1], "' AND "
   END IF
   
 
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
   ELSE
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF
   
   #add-point:default_search段結束前
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="astm601.state_change" >}
   #+ 此段落由子樣板a09產生
#+ 確認碼變更
PRIVATE FUNCTION astm601_statechange()
   {<Local define>}
   DEFINE lc_state LIKE type_t.chr5
   {</Local define>}
   #add-point:statechange段define
      DEFINE l_success      LIKE type_t.num5 
   #end add-point  
   
   #add-point:statechange段開始前
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_stce_m.stce001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      RETURN
   END IF
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         CASE g_stce_m.stcestus
            WHEN "N"
               HIDE OPTION "open"
            WHEN "X"
               HIDE OPTION "void"
 
            WHEN "Y"
               HIDE OPTION "valid"
 
 
            
         END CASE
     
      #add-point:menu前
               CASE g_stce_m.stcestus
            WHEN "Y"
               HIDE OPTION "void"
            WHEN "X"
               HIDE OPTION "valid"
         END CASE
      #end add-point
      
      ON ACTION open
         LET lc_state = "N"
         #add-point:action控制
         
         #end add-point
         EXIT MENU
      ON ACTION void
         LET lc_state = "X"
         #add-point:action控制
         
         #end add-point
         EXIT MENU
 
      ON ACTION valid
         LET lc_state = "Y"
         #add-point:action控制
         
         #end add-point
         EXIT MENU
 
 
      
      
      
      #add-point:stus控制
      
      #end add-point
      
   END MENU
   
   IF (lc_state <> "N" 
      AND lc_state <> "X"
 
      AND lc_state <> "Y"
 
 
      ) OR 
      cl_null(lc_state) THEN
      RETURN
   END IF
   
   #add-point:stus修改前
      LET l_success = TRUE
   CASE 
      WHEN lc_state = 'Y' AND g_stce_m.stcestus = 'N'
         CALL s_astm601_conf_chk(g_stce_m.stce001) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('aim-00108') THEN
               CALL s_transaction_begin()
               CALL s_astm601_conf_upd(g_stce_m.stce001) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               RETURN
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_stce_m.stce001
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN
         END IF
         
      WHEN lc_state = 'X' AND g_stce_m.stcestus = 'N'
         CALL s_astm601_void_chk(g_stce_m.stce001) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('art-00039') THEN
               CALL s_transaction_begin()
               CALL s_astm601_void_upd(g_stce_m.stce001) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               RETURN 
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_stce_m.stce001
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN
         END IF   
         
       WHEN lc_state = 'N' AND g_stce_m.stcestus = 'X'
         
             CALL s_astm601_void_chk(g_stce_m.stce001) RETURNING l_success,g_errno
             IF l_success THEN
                IF cl_ask_confirm('art-00038') THEN                
                  CALL s_transaction_begin()
                  CALL s_astm601_void_upd(g_stce_m.stce001) RETURNING l_success
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                     RETURN
                  ELSE
                     CALL s_transaction_end('Y','1')
                  END IF
               ELSE
                  RETURN 
               END IF
            ELSE
               INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_stce_m.stce001
            LET g_errparam.popup = TRUE
            CALL cl_err()

               RETURN
            END IF
       WHEN lc_state = 'N' AND g_stce_m.stcestus = 'Y'       
             CALL s_astm601_unconf_chk(g_stce_m.stce001) RETURNING l_success,g_errno
             IF l_success THEN
               IF cl_ask_confirm('aim-00110') THEN
                  CALL s_transaction_begin()
                  CALL s_astm601_unconf_upd(g_stce_m.stce001) RETURNING l_success
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                     RETURN
                  ELSE
                     CALL s_transaction_end('Y','1')
                  END IF
               ELSE 
                  RETURN
               END IF
             ELSE
                INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_stce_m.stce001
            LET g_errparam.popup = TRUE
            CALL cl_err()

                RETURN
             END IF   
                 
     END CASE   
   #end add-point
      
   UPDATE stce_t SET stcestus = lc_state 
    WHERE stceent = g_enterprise AND stce001 = g_stce_m.stce001
 
  
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
 
 
         
      END CASE
      LET g_stce_m.stcestus = lc_state
      DISPLAY BY NAME g_stce_m.stcestus
   END IF
 
   #add-point:stus修改後
      
 
   #end add-point
 
   #add-point:statechange段結束前
   
   #end add-point  
 
END FUNCTION
 
 
 
{</section>}
 
{<section id="astm601.idx_chk" >}
#+ 單身筆數變更
PRIVATE FUNCTION astm601_idx_chk()
   #add-point:idx_chk段define
      IF g_current_page = 3 THEN
      LET g_detail_idx3 = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx3 > g_stcg_d.getLength() THEN
         LET g_detail_idx3 = g_stcg_d.getLength()
      END IF
      IF g_detail_idx3 = 0 AND g_stcg_d.getLength() <> 0 THEN
         LET g_detail_idx3 = 1
      END IF
      DISPLAY g_detail_idx3 TO FORMONLY.idx
      DISPLAY g_stcg_d.getLength() TO FORMONLY.cnt
   END IF
   #end add-point  
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_stcf_d.getLength() THEN
         LET g_detail_idx = g_stcf_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_stcf_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_stcf_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_stcf2_d.getLength() THEN
         LET g_detail_idx = g_stcf2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_stcf2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_stcf2_d.getLength() TO FORMONLY.cnt
   END IF
 
 
   
   #add-point:idx_chk段other
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="astm601.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION astm601_b_fill2(pi_idx)
   {<Local define>}
   DEFINE pi_idx          LIKE type_t.num5
   DEFINE li_ac           LIKE type_t.num5
   DEFINE ls_chk          LIKE type_t.chr1
   {</Local define>}
   #add-point:b_fill2段define
   
   #end add-point
   
   LET li_ac = l_ac 
   
 
      
   #add-point:單身填充後
      CALL astm601_b3_fill()
   CALL astm601_reflesh()
   #end add-point
    
   LET l_ac = li_ac
   
   CALL astm601_detail_show()
   
END FUNCTION
 
{</section>}
 
{<section id="astm601.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION astm601_fill_chk(ps_idx)
   {<Local define>}
   DEFINE ps_idx        LIKE type_t.chr10
   {</Local define>}
   #add-point:fill_chk段define
   
   #end add-point
   
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1')  AND 
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1')  AND
      (cl_null(g_wc2_table4) OR g_wc2_table4.trim() = '1=1') THEN
      #add-point:fill_chk段define
      
      #end add-point
      RETURN TRUE
   END IF
   
   #第一單身
   IF ps_idx = 1 AND
      ((NOT cl_null(g_wc2_table1) AND g_wc2_table1.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF
   
   #根據wc判定是否需要填充
   IF ps_idx = 2 AND
      ((NOT cl_null(g_wc2_table2) AND g_wc2_table2.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF
 
   #根據wc判定是否需要填充
   IF ps_idx = 4 AND
      ((NOT cl_null(g_wc2_table4) AND g_wc2_table4.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF
 
   RETURN FALSE
 
END FUNCTION
 
{</section>}
 
{<section id="astm601.signature" >}
   
 
{</section>}
 
{<section id="astm601.set_pk_array" >}
 
 
{</section>}
 
{<section id="astm601.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="astm601.other_function" readonly="Y" >}
   
#+
PUBLIC FUNCTION astm601_b3_fill()
DEFINE p_wc2      STRING
 DEFINE l_a      LIKE type_t.num5
 
   CALL g_stcg_d.clear()   
   
   LET g_sql = "SELECT  UNIQUE stcgseq2,stcg002,stcg003,stcg004,stcgsite,stcgunit FROM stcg_t",    
               "",
               " WHERE stcgent=? AND stcg001=? AND stcgseq1 = ?"
 
   IF NOT cl_null(g_wc2_table3) THEN
      LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table3 CLIPPED
   END IF
 
   LET g_sql = g_sql, " ORDER BY stcg_t.stcg001,stcg_t.stcgseq1,stcg_t.stcgseq2"
 
   #add-point:單身填充控制

   #end add-point
   
   PREPARE astm601_pb3 FROM g_sql
   DECLARE b_fill_cs3 CURSOR FOR astm601_pb3
 
   LET g_cnt = l_a
   LET l_a = 1
   IF cl_null(l_ac) OR l_ac = 0 THEN
      LET l_ac = 1
   END IF
   OPEN b_fill_cs3 USING g_enterprise,g_stce_m.stce001,g_stcf_d[l_ac].stcfseq

                                            
   FOREACH b_fill_cs3 INTO g_stcg_d[l_a].stcgseq2,g_stcg_d[l_a].stcg002,g_stcg_d[l_a].stcg003,g_stcg_d[l_a].stcg004,
                           g_stcg_d[l_a].stcgsite,g_stcg_d[l_a].stcgunit
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
     
      #add-point:b_fill段資料填充

      #end add-point
 
      LET l_a = l_a + 1
      IF l_a > g_max_rec AND g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
   
   CALL g_stcg_d.deleteElement(g_stcg_d.getLength())

   LET l_a = g_cnt
   LET g_cnt = 0  
   
   FREE astm601_pb3
END FUNCTION
#+
PUBLIC FUNCTION astm601_reflesh()
  DISPLAY ARRAY g_stcf_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b)
     BEFORE DISPLAY
         EXIT DISPLAY
  END DISPLAY 
  DISPLAY ARRAY g_stcg_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b3)
       BEFORE DISPLAY
         EXIT DISPLAY
    END DISPLAY
END FUNCTION
#+
PUBLIC FUNCTION astm601_stcf002_ref()
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = g_stcf_d[l_ac].stcf002
    CALL ap_ref_array2(g_ref_fields,"SELECT stael003 FROM stael_t WHERE staelent='"||g_enterprise||"' AND stael001=? AND stael002='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_stcf_d[l_ac].stcf002_desc = '', g_rtn_fields[1] , ''  
    DISPLAY BY NAME g_stcf_d[l_ac].stcf002_desc
END FUNCTION
#+
PUBLIC FUNCTION astm601_set_no_required_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   DEFINE l_n     LIKE type_t.num5
   DEFINE l_staf003 LIKE staf_t.staf003
   DEFINE l_staf004 LIKE staf_t.staf004
   DEFINE l_staf005 LIKE staf_t.staf005


  
   CALL astm601_init_required(p_cmd)
   IF NOT cl_null(g_stcf_d[l_ac].stcf002) THEN
      #檢查費用編號+經營方式是否存在asti204
      
      SELECT COUNT(*) INTO l_n FROM staf_t
       WHERE stafent = g_enterprise AND staf001= g_stcf_d[l_ac].stcf002 AND staf002 = g_stce_m.stce005
      IF l_n > 0 THEN
         DECLARE sel_staf_nq CURSOR FOR 
          SELECT staf003,staf004,staf005 FROM staf_t
           WHERE  stafent = g_enterprise AND staf001= g_stcf_d[l_ac].stcf002 AND staf002 = g_stce_m.stce005
         FOREACH sel_staf_nq INTO l_staf003,l_staf004,l_staf005
            LET l_staf003 = cl_str_replace(l_staf003,"stao","stcf")
            CALL astm601_convert(l_staf003)  RETURNING l_staf003
            IF l_staf005 = 'N' THEN
               CALL cl_set_comp_required(l_staf003,FALSE)
            END IF
         END FOREACH 
      ELSE
          IF g_stcf_d[l_ac].stcf005 = '1' THEN    #變動
             CALL cl_set_comp_required('stcf008',FALSE)
             IF cl_null(g_stcf_d[l_ac].stcf008) THEN
                CALL cl_set_comp_required('stcf010',FALSE)
             END IF
             IF g_stcf_d[l_ac].stcf015 <> '1' THEN      
                LET g_stcf_d[l_ac].stcf011 = ''
                CALL cl_set_comp_required('stcf011',FALSE)
             END IF            
          ELSE                                    #固定
             CALL cl_set_comp_required('stcf009',FALSE) 
             LET g_stcf_d[l_ac].stcf011 = ''
             CALL cl_set_comp_required('stcf011',FALSE) 
          END IF   
          IF g_stcf_d[l_ac].stcf012 = '1' THEN    #保底
             CALL cl_set_comp_required('stcf013,stcf014',FALSE)
          END IF
       END IF 
   ELSE
      IF g_stcf_d[l_ac].stcf005 = '1' THEN    #變動
         CALL cl_set_comp_required('stcf008',FALSE)
         IF cl_null(g_stcf_d[l_ac].stcf008) THEN
              CALL cl_set_comp_required('stcf010',FALSE)
         END IF
         IF g_stcf_d[l_ac].stcf015 <> '1' THEN      
            LET g_stcf_d[l_ac].stcf011 = ''
            CALL cl_set_comp_required('stcf011',FALSE)           
         END IF
        
      ELSE                                    #固定
         CALL cl_set_comp_required('stcf009',FALSE) 
         LET g_stcf_d[l_ac].stcf011 = ''
         CALL cl_set_comp_required('stcf011',FALSE) 
      END IF   
      IF g_stcf_d[l_ac].stcf012 = '1' THEN    #保底
         CALL cl_set_comp_required('stcf013,stcf014',FALSE)
      END IF   
   END IF  
   
END FUNCTION
#+
PUBLIC FUNCTION astm601_set_required_b(p_cmd)
DEFINE p_cmd   LIKE type_t.chr1   
DEFINE l_n     LIKE type_t.num5
DEFINE l_staf003 LIKE staf_t.staf003
DEFINE l_staf004 LIKE staf_t.staf004
DEFINE l_staf005 LIKE staf_t.staf005

   
  
    
   IF NOT cl_null(g_stcf_d[l_ac].stcf002) THEN
      #檢查費用編號+經營方式是否存在asti204
      
      SELECT COUNT(*) INTO l_n FROM staf_t
       WHERE stafent = g_enterprise AND staf001= g_stcf_d[l_ac].stcf002 AND staf002 = g_stce_m.stce005
      IF l_n > 0 THEN
         DECLARE sel_staf_q CURSOR FOR 
          SELECT staf003,staf004,staf005 FROM staf_t
           WHERE  stafent = g_enterprise AND staf001= g_stcf_d[l_ac].stcf002 AND staf002 = g_stce_m.stce005
         FOREACH sel_staf_q INTO l_staf003,l_staf004,l_staf005
            LET l_staf003 = cl_str_replace(l_staf003,"stao","stcf")
            CALL astm601_convert(l_staf003)  RETURNING l_staf003
            IF l_staf005 = 'Y' THEN
               CALL cl_set_comp_required(l_staf003,TRUE)
            END IF
         END FOREACH 
      ELSE
          IF g_stcf_d[l_ac].stcf005 = '1' THEN    #變動
             CALL cl_set_comp_required('stcf008',FALSE)
             IF NOT cl_null(g_stcf_d[l_ac].stcf008) THEN
                CALL cl_set_comp_required('stcf010',TRUE)
             END IF
             CALL cl_set_comp_required('stcf009',TRUE)
             IF g_stcf_d[l_ac].stcf015 = '1' THEN      
                CALL cl_set_comp_required('stcf011',TRUE) 
             END IF
          ELSE                                    #固定
             CALL cl_set_comp_required('stcf010',TRUE)
          END IF   
          IF g_stcf_d[l_ac].stcf012 <> '1' THEN    #保底
             CALL cl_set_comp_required('stcf013,stcf014',TRUE)
          END IF
      END IF  
   ELSE
      IF g_stcf_d[l_ac].stcf005 = '1' THEN    #變動
         IF NOT cl_null(g_stcf_d[l_ac].stcf008) THEN
            CALL cl_set_comp_required('stcf010',TRUE)
         END IF
         CALL cl_set_comp_required('stcf009',TRUE)
         IF g_stcf_d[l_ac].stcf015 = '1' THEN      
            CALL cl_set_comp_required('stcf011',TRUE) 
         END IF
      ELSE                                    #固定
         CALL cl_set_comp_required('stcf010',TRUE)
      END IF   
      IF g_stcf_d[l_ac].stcf012 <> '1' THEN    #保底
         CALL cl_set_comp_required('stcf013,stcf014',TRUE)
      END IF   
   END IF 
  
END FUNCTION
#+
PUBLIC FUNCTION astm601_stcf008_chk(p_stab001)
DEFINE p_stab001   LIKE stab_t.stab001
DEFINE l_n         LIKE type_t.num5

   LET g_errshow = '1'
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = p_stab001
   IF NOT cl_chk_exist("v_stab001_1") THEN
      RETURN FALSE
   END IF
      
   SELECT COUNT(*) INTO l_n FROM stab_t LEFT OUTER JOIN stat_t ON stabent = statent AND stab001 = stat003
     WHERE  stabent = 99 AND stab001= p_stab001 AND stat001 = g_stce_m.stce005 AND stat002 = g_stce_m.stce007 
   IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ast-00108'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
  
   RETURN TRUE
END FUNCTION
#+
PUBLIC FUNCTION astm601_stcf002_chk(p_stae001)
DEFINE p_stae001  LIKE stae_t.stae001
DEFINE l_staestus LIKE stae_t.staestus
DEFINE l_stae010  LIKE stae_t.stae010
DEFINE l_n        LIKE type_t.num5
DEFINE l_ooef019  LIKE ooef_t.ooef019

   INITIALIZE g_chkparam.* TO NULL
   LET g_errshow = '1'
   LET g_chkparam.arg1 = p_stae001
   IF NOT cl_chk_exist("v_stae001_1") THEN
      RETURN FALSE
   END IF
   
    #税别要存在于签订法人税区里面的税别
   SELECT stae010 INTO l_stae010 FROM stae_t WHERE staeent = g_enterprise AND stae001 = p_stae001
   SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_stce_m.stce014
   
   IF NOT cl_null(l_stae010) THEN
      SELECT COUNT(*) INTO l_n FROM oodb_t WHERE oodbent = g_enterprise AND oodb001 = l_ooef019 AND oodb002 = l_stae010
      IF l_n = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ast-00224'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF    
   END IF
   
   RETURN TRUE
END FUNCTION
#+
PUBLIC FUNCTION astm601_stce009_ref()

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stce_m.stce009
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stce_m.stce009_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stce_m.stce009_desc
   

END FUNCTION
#+
PUBLIC FUNCTION astm601_stce009_chk(p_pmaa001)
DEFINE p_pmaa001   LIKE pmaa_t.pmaa001

    LET g_errshow = '1'
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = p_pmaa001
   
   #160318-00025#37  2016/04/19  by pengxin  add(S)
   LET g_errshow = TRUE #是否開窗 
   LET g_chkparam.err_str[1] = "apm-00638:sub-01302|adbm200|",cl_get_progname("adbm200",g_lang,"2"),"|:EXEPROGadbm200"
   #160318-00025#37  2016/04/19  by pengxin  add(E)
   
   IF NOT cl_chk_exist("v_pmaa001_17") THEN
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION
#+
PUBLIC FUNCTION astm601_stce004_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stce_m.stce004
   CALL ap_ref_array2(g_ref_fields,"SELECT stagl003 FROM stagl_t WHERE staglent='"||g_enterprise||"' AND stagl001=? AND stagl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stce_m.stce004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stce_m.stce004_desc
END FUNCTION
#+
PUBLIC FUNCTION astm601_stce004_chk(p_stag001)
DEFINE p_stag001  LIKE stag_t.stag001
DEFINE l_stagstus LIKE stag_t.stagstus

  SELECT stagstus INTO l_stagstus FROM stag_t
   WHERE stagent = g_enterprise AND stag001 = p_stag001
  IF STATUS = 100 OR cl_null(l_stagstus) THEN
    INITIALIZE g_errparam TO NULL
    LET g_errparam.code = 'ast-00019'
    LET g_errparam.extend = ''
    LET g_errparam.popup = TRUE
    CALL cl_err()

    RETURN FALSE
  ELSE
    IF l_stagstus = 'N' THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = 'ast-00020'
       LET g_errparam.extend = ''
       LET g_errparam.popup = TRUE
       CALL cl_err()

       RETURN FALSE
    END IF
    IF l_stagstus = 'X' THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = 'ast-00021'
       LET g_errparam.extend = ''
       LET g_errparam.popup = TRUE
       CALL cl_err()

       RETURN FALSE
    END IF
  END IF  
  RETURN TRUE 
END FUNCTION
#+
PUBLIC FUNCTION astm601_stce021_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stce_m.stce021
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stce_m.stce021_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stce_m.stce021_desc
END FUNCTION
#+
PUBLIC FUNCTION astm601_stce021_chk(p_stce021)
DEFINE p_stce021  LIKE stce_t.stce021
  
   LET g_errshow = '1'
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = g_site
   LET g_chkparam.arg2 = p_stce021
   #160318-00025#37  2016/04/19  by pengxin  add(S)
   LET g_errshow = TRUE #是否開窗 
   LET g_chkparam.err_str[1] = "aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
   #160318-00025#37  2016/04/19  by pengxin  add(E)
   IF NOT cl_chk_exist("v_ooaj002") THEN
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION
#+
PUBLIC FUNCTION astm601_stce006_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stce_m.stce006
   CALL ap_ref_array2(g_ref_fields,"SELECT staal003 FROM staal_t WHERE staalent='"||g_enterprise||"' AND staal001=? AND staal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stce_m.stce006_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stce_m.stce006_desc
END FUNCTION
#+
PUBLIC FUNCTION astm601_stce007_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stce_m.stce007
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '2060' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stce_m.stce007_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stce_m.stce007_desc
END FUNCTION
#+
PUBLIC FUNCTION astm601_stce007_chk(p_stce007)
DEFINE p_stce007  LIKE stce_t.stce007
DEFINE l_oocqstus LIKE oocq_t.oocqstus


   SELECT oocqstus INTO l_oocqstus FROM oocq_t
    WHERE oocqent =  g_enterprise AND oocq001 = '2060' AND oocq002 = p_stce007
    
   IF STATUS = 100 OR cl_null(l_oocqstus) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ast-00005'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   ELSE
      IF l_oocqstus = 'N' THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'ast-00006'
          LET g_errparam.extend = ''
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN FALSE
      END IF
   END IF
   
 
   
   RETURN TRUE
END FUNCTION
#+
PUBLIC FUNCTION astm601_stce006_chk(p_stce006)
DEFINE p_stce006  LIKE stce_t.stce006
DEFINE l_staastus LIKE staa_t.staastus

  
   SELECT staastus INTO l_staastus FROM staa_t 
     WHERE staaent = g_enterprise AND staa001 = p_stce006
     
   IF STATUS = 100 OR cl_null(l_staastus) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ast-00003'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   ELSE
      IF l_staastus = 'N' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ast-00004'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION
#+
PUBLIC FUNCTION astm601_stce024_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stce_m.stce024
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stce_m.stce024_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stce_m.stce024_desc
END FUNCTION
#+
PUBLIC FUNCTION astm601_stce024_chk(p_stce024)
DEFINE p_stce024  LIKE stce_t.stce024


  INITIALIZE g_chkparam.* TO NULL
  LET g_errshow = '1'
  LET g_chkparam.arg1 = p_stce024
  #LET g_chkparam.arg2 = 'A'
  IF NOT cl_chk_exist("v_ooef001_31") THEN
     RETURN FALSE
  END IF
  RETURN TRUE
    
END FUNCTION
#+
PUBLIC FUNCTION astm601_stce025_ref()
  INITIALIZE g_ref_fields TO NULL
  LET g_ref_fields[1] = g_stce_m.stce025
  CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
  LET g_stce_m.stce025_desc = '', g_rtn_fields[1] , ''
  DISPLAY BY NAME g_stce_m.stce025_desc
END FUNCTION
#+
PUBLIC FUNCTION astm601_stce025_chk(p_stce025)
DEFINE p_stce025  LIKE stce_t.stce025

  
  INITIALIZE g_chkparam.* TO NULL
  LET g_errshow = '1'
  LET g_chkparam.arg1 = p_stce025
  #LET g_chkparam.arg2 = '2'
  IF NOT cl_chk_exist("v_ooef001_27") THEN
     RETURN FALSE
  END IF
   RETURN TRUE
    
END FUNCTION
#+
PUBLIC FUNCTION astm601_stce004_other()
   SELECT stag003,stag004,stag005,stag006,stag007
     INTO g_stce_m.stce023,g_stce_m.stce006,g_stce_m.stce007,g_stce_m.stce021,g_stce_m.stce022
     FROM stag_t
    WHERE stagent = g_enterprise AND stag001 = g_stce_m.stce004
    
   #LET g_stce_m_t.* = g_stce_m.*
   DISPLAY BY NAME g_stce_m.stce023,g_stce_m.stce006,g_stce_m.stce007,g_stce_m.stce021,g_stce_m.stce022,g_stce_m.stceunit
   
   CALL astm601_stce023_ref()
   CALL astm601_stce006_ref()
   CALL astm601_stce007_ref()
   CALL astm601_stce021_ref()
   CALL astm601_stce007_ref()
  #LET t_stce.* = g_stce_m.*       #170202-00019#1 170202 by 02749 mark
   #170202-00019#1 170202 by 02749 add---(S)
   LET g_stce_m_o.stce023 = g_stce_m.stce023
   LET g_stce_m_o.stce006 = g_stce_m.stce006
   LET g_stce_m_o.stce007 = g_stce_m.stce007
   LET g_stce_m_o.stce021 = g_stce_m.stce021
   LET g_stce_m_o.stce022 = g_stce_m.stce022
   #170202-00019#1 170202 by 02749 add---(E)   
END FUNCTION
#+
PUBLIC FUNCTION astm601_stce004_genb()
DEFINE l_sql    STRING
#DEFINE l_stah   RECORD LIKE stah_t.* #161111-00028#3--mark
#161111-00028#3--add----begin---------
DEFINE l_stah RECORD  #自營合約模板費用設定檔
       stahent LIKE stah_t.stahent, #企業編號
       stah001 LIKE stah_t.stah001, #模板編號
       stah002 LIKE stah_t.stah002, #序號
       stah003 LIKE stah_t.stah003, #費用編號
       stah004 LIKE stah_t.stah004, #會計期間
       stah005 LIKE stah_t.stah005, #價款類別
       stah006 LIKE stah_t.stah006, #計算類型
       stah007 LIKE stah_t.stah007, #費用週期
       stah008 LIKE stah_t.stah008, #費用週期方式
       stah009 LIKE stah_t.stah009, #條件基準
       stah010 LIKE stah_t.stah010, #計算基準
       stah011 LIKE stah_t.stah011, #費用淨額
       stah012 LIKE stah_t.stah012, #費用比率
       stah013 LIKE stah_t.stah013, #保底
       stah014 LIKE stah_t.stah014, #保底金額
       stah015 LIKE stah_t.stah015, #保底扣率
       stah016 LIKE stah_t.stah016, #分量扣點
       stah017 LIKE stah_t.stah017  #是否參與現金折扣
       END RECORD
#161111-00028#3--add----end-----------
DEFINE l_next_b LIKE type_t.dat
DEFINE l_stcf018 LIKE stcf_t.stcf018
DEFINE l_stcf019 LIKE stcf_t.stcf019
DEFINE l_stcf020 LIKE stcf_t.stcf020
DEFINE l_flag    LIKE type_t.chr1

    LET l_flag = 'N'
    DECLARE  sel_stah CURSOR FOR SELECT stahent,stah001,stah002,stah003,stah004,stah005,stah006,stah007,stah008,stah009,
                                        stah010,stah011,stah012,stah013,stah014,stah015,stah016,stah017   ##161111-00028#3--add stah017
     FROM stah_t 
    WHERE stahent = g_enterprise AND stah001 =g_stce_m.stce004 
   
   FOREACH sel_stah INTO l_stah.*
      IF NOT cl_null(g_stce_m.stce010) AND l_stah.stah006 = '1' THEN
         LET l_flag = 'Y'
         CONTINUE FOREACH
      END IF
      #推算下次计算日 .结算开始。结算截止
      #150320-00008#1 modify-S by ken 150323 stcesite改為no use後不使用
      CALL s_astm601_cal_nextd(l_stah.stah007,l_stah.stah008,g_stce_m.stce017,g_stce_m.stce018,'','') RETURNING l_stcf018,l_stcf019,l_stcf020
      INSERT INTO stcf_t (stcfent,stcfunit,stcfseq,stcf001,stcf002,stcf003,stcf004,stcf005,stcf006,stcf007,
                       stcf008,stcf009,stcf010,stcf011,stcf012,stcf013,stcf014,stcf015,stcf016,stcf017,stcf018,stcf019,stcf020) 
            VALUES (l_stah.stahent,g_stce_m.stceunit,l_stah.stah002,g_stce_m.stce001,l_stah.stah003,l_stah.stah004,l_stah.stah005,
                    l_stah.stah006,l_stah.stah007,l_stah.stah008,l_stah.stah009,l_stah.stah010,l_stah.stah011,l_stah.stah012,
                    l_stah.stah013,l_stah.stah014,l_stah.stah015,l_stah.stah016,g_stce_m.stce017,g_stce_m.stce018,l_stcf018,l_stcf019,l_stcf020)            
      #INSERT INTO stcf_t (stcfent,stcfsite,stcfunit,stcfseq,stcf001,stcf002,stcf003,stcf004,stcf005,stcf006,stcf007,
      #                 stcf008,stcf009,stcf010,stcf011,stcf012,stcf013,stcf014,stcf015,stcf016,stcf017,stcf018,stcf019,stcf020)                     
            #VALUES (l_stah.stahent,g_stce_m.stcesite,g_stce_m.stceunit,l_stah.stah002,g_stce_m.stce001,l_stah.stah003,l_stah.stah004,l_stah.stah005,
            #        l_stah.stah006,l_stah.stah007,l_stah.stah008,l_stah.stah009,l_stah.stah010,l_stah.stah011,l_stah.stah012,
            #        l_stah.stah013,l_stah.stah014,l_stah.stah015,l_stah.stah016,g_stce_m.stce017,g_stce_m.stce018,l_stcf018,l_stcf019,l_stcf020)
      #modify-E                             
   END FOREACH 

   IF l_flag = 'Y' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ast-00198'
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF
   
   #150320-00008#1 modify-S by ken 150323 stcesite改為no use後不使用
   LET l_sql = " INSERT INTO stcg_t(stcgent,stcgunit,stcgseq1,stcgseq2,stcg001,stcg002,stcg003,stcg004)",
               "  SELECT staient,'",g_stce_m.stceunit,"',stai002,stai003,'",g_stce_m.stce001,"',stai004,stai005,stai006 ",
               "  FROM stai_t ",
               " WHERE staient = '",g_enterprise,"' AND stai001 = '",g_stce_m.stce004,"'" 
   #LET l_sql = " INSERT INTO stcg_t(stcgent,stcgsite,stcgunit,stcgseq1,stcgseq2,stcg001,stcg002,stcg003,stcg004)",
   #            "  SELECT staient,'",g_stce_m.stcesite,"','",g_stce_m.stceunit,"',stai002,stai003,'",g_stce_m.stce001,"',stai004,stai005,stai006 ",
   #            "  FROM stai_t ",
   #            " WHERE staient = '",g_enterprise,"' AND stai001 = '",g_stce_m.stce004,"'"   
   #modify-E
   IF NOT cl_null(g_stce_m.stce010) THEN
      LET l_sql = l_sql," AND  stai002 IN (SELECT stah002 FROM stah_t WHERE stahent ='",g_enterprise,"' AND stah001 = '",g_stce_m.stce004,"' AND stah006 ='2' ) "
   END IF  
   PREPARE ins_stcg FROM l_sql
   EXECUTE  ins_stcg 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF 
    
    

END FUNCTION
#+
PUBLIC FUNCTION astm601_stch002_ref()
DEFINE l_dbba002   LIKE dbba_t.dbba002

   IF cl_null(g_stcf2_d[l_ac].stch002) THEN
      LET g_stcf2_d[l_ac].stch002_desc = ''
      DISPLAY BY NAME g_stcf2_d[l_ac].stch002_desc
      RETURN 
   END IF

    SELECT dbba002 INTO l_dbba002 FROM  dbba_t,dbbc_t
       WHERE dbbaent = dbbcent AND dbbc001 = g_stce_m.stce028
         AND dbbc004 = dbba001 AND dbbaent = g_enterprise 
   
   IF l_dbba002 = '1' THEN   
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_stcf2_d[l_ac].stch002
      CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_stcf2_d[l_ac].stch002_desc = '', g_rtn_fields[1] , ''
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_stcf2_d[l_ac].stch002
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '2002' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_stcf2_d[l_ac].stch002_desc = '', g_rtn_fields[1] , ''
   END IF
   DISPLAY BY NAME g_stcf2_d[l_ac].stch002_desc
END FUNCTION
#+
PUBLIC FUNCTION astm601_stch002_chk(p_cmd,p_stch002)
DEFINE p_cmd      LIKE type_t.chr1
DEFINE p_stch002  LIKE stch_t.stch002
DEFINE l_sys      LIKE type_t.num5
DEFINE l_n        LIKE type_t.num5
DEFINE l_dbba001  LIKE dbba_t.dbba001
DEFINE l_dbba002  LIKE dbba_t.dbba002
DEFINE l_dbbbstus LIKE dbbb_t.dbbbstus

  #IF p_cmd = 'a' THEN
  #   SELECT COUNT(*) INTO l_n FROM stch_t
  #   WHERE stchent = g_enterprise AND stch001 =  g_stce_m.stce001 AND stch002 = 'ALL'  
  #ELSE
  #    SELECT COUNT(*) INTO l_n FROM stch_t
  #   WHERE stchent = g_enterprise AND stch001 =  g_stce_m.stce001 AND stch002 = 'ALL' AND stchseq <> g_stcf2_d[l_ac].stchseq 
  #END IF
  #IF l_n > 0 THEN
  #   INITIALIZE g_errparam TO NULL
  #   LET g_errparam.code = 'ast-00114'
  #   LET g_errparam.extend = ''
  #   LET g_errparam.popup = FALSE
  #   CALL cl_err()
  #   RETURN FALSE
  #END IF
  # 
  #IF p_stch002 <> "ALL" THEN 
      LET g_errshow = '1'
      SELECT dbba001,dbba002 INTO l_dbba001,l_dbba002 FROM  dbba_t,dbbc_t
       WHERE dbbaent = dbbcent AND dbbc001 = g_stce_m.stce028
         AND dbbc004 = dbba001 AND dbbaent = g_enterprise 
         
      IF l_dbba002 = '1' THEN     
         INITIALIZE g_chkparam.* TO NULL
         LET g_chkparam.arg1 = p_stch002
         CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys
         LET g_chkparam.arg2 = l_sys
         
         #160318-00025#37  2016/04/19  by pengxin  add(S)
         LET g_errshow = TRUE #是否開窗 
         LET g_chkparam.err_str[1] = "ast-00215:sub-01302|arti202|",cl_get_progname("arti202",g_lang,"2"),"|:EXEPROGarti202"
         #160318-00025#37  2016/04/19  by pengxin  add(E)
         
         #呼叫檢查存在並帶值的library
         IF NOT cl_chk_exist("v_rtax001_2") THEN
            RETURN FALSE
         END IF   
      ELSE
         INITIALIZE g_chkparam.* TO NULL
         LET g_chkparam.arg1 = p_stch002
           
         #呼叫檢查存在並帶值的library
         IF NOT cl_chk_exist("v_oocq002_2002") THEN
            RETURN FALSE     
         END IF   
      
      END IF   
      #检查是否存在对应销售范围的产品组
      SELECT COUNT(*) INTO l_n FROM dbbb_t
       WHERE dbbbent = g_enterprise AND dbbb001 = l_dbba001 AND dbbb003 = p_stch002
      IF l_n = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ast-00216'
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
         RETURN FALSE
      END IF      
      #检查是否无效
     SELECT dbbbstus INTO l_dbbbstus FROM dbbb_t
      WHERE dbbbent = g_enterprise AND dbbb001 = l_dbba001 AND dbbb003 = p_stch002
     IF l_dbbbstus = 'N' THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = 'ast-00218'
        LET g_errparam.extend = ''
        LET g_errparam.popup = FALSE
        CALL cl_err()
        RETURN FALSE
     END IF
  #ELSE
  #   #单身是否有其它资料
  #   SELECT COUNT(*) INTO l_n FROM stch_t
  #    WHERE stchent = g_enterprise AND stch001 =  g_stce_m.stce001 AND  stch002 <> 'ALL' AND stchseq <> g_stcf2_d[l_ac].stchseq 
  #   IF l_n > 0 THEN
  #      INITIALIZE g_errparam TO NULL
  #      LET g_errparam.code = 'ast-00121'
  #      LET g_errparam.extend = ''
  #      LET g_errparam.popup = FALSE
  #      CALL cl_err()
  #      RETURN FALSE
  #   END IF      
  #END IF  
   RETURN TRUE
END FUNCTION
#+
PUBLIC FUNCTION astm601_stce014_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stce_m.stce014
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stce_m.stce014_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stce_m.stce014_desc
END FUNCTION
#+
PUBLIC FUNCTION astm601_stce015_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stce_m.stce015
   CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003=? ","") RETURNING g_rtn_fields
   LET g_stce_m.stce015_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stce_m.stce015_desc
END FUNCTION
#+
PUBLIC FUNCTION astm601_stce014_chk(p_stce014)
DEFINE p_stce014  LIKE stce_t.stce014
    
   INITIALIZE g_chkparam.* TO NULL
   LET g_errshow = '1'
   LET g_chkparam.arg1 = p_stce014
   LET g_chkparam.arg2 = '1'
   IF NOT cl_chk_exist("v_ooef001_1") THEN
      RETURN FALSE
   END IF
   RETURN TRUE

END FUNCTION
#+
PUBLIC FUNCTION astm601_stce015_chk(p_stce015)
DEFINE p_stce015  LIKE stce_t.stce015
DEFINE l_ooagstus LIKE ooag_t.ooagstus

   LET g_errshow = '1'
   SELECT ooagstus INTO l_ooagstus FROM ooag_t
    WHERE ooagent = g_enterprise AND ooag001 = p_stce015
    
   IF status = 100 OR cl_null(l_ooagstus) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aoo-00074'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   ELSE
      IF l_ooagstus = 'N' THEN
         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = 'aoo-00071'  #160318-00005#44  mark
         LET g_errparam.code = 'sub-01302'   #160318-00005#44  add
         LET g_errparam.extend = ''
         #160318-00005#44 --s add
         LET g_errparam.replace[1] = 'aooi130'
         LET g_errparam.replace[2] = cl_get_progname('aooi130',g_lang,"2")
         LET g_errparam.exeprog = 'aooi130'
         #160318-00005#44 --e add
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL astm601_default(p_stce005,p_stcf002)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION astm601_default(p_stce005,p_stcf002)
DEFINE p_stce005 LIKE stce_t.stce005
DEFINE p_stcf002 LIKE stcf_t.stcf002
DEFINE l_staf003 LIKE staf_t.staf003
DEFINE l_staf006 LIKE staf_t.staf006
DEFINE l_replace LIKE staf_t.staf003

    DECLARE sel_staf_d CURSOR FOR 
     SELECT staf003,staf006 FROM staf_t
      WHERE  stafent = g_enterprise AND staf001= p_stcf002 AND staf002 = p_stce005
   FOREACH sel_staf_d INTO l_staf003,l_staf006
      LET l_staf003 = cl_str_replace(l_staf003,"stao","stcf")
      CALL astm601_convert(l_staf003)  RETURNING l_staf003
      CASE l_staf003
          WHEN 'stcf003'
             LET g_stcf_d[l_ac].stcf003 = l_staf006
          WHEN 'stcf004'
             IF NOT cl_null(l_staf006) THEN
                LET g_stcf_d[l_ac].stcf004 = l_staf006
             END IF
          WHEN 'stcf005'
             LET g_stcf_d[l_ac].stcf005 = l_staf006
          WHEN 'stcf006'
             LET g_stcf_d[l_ac].stcf006 = l_staf006
          WHEN 'stcf007'
             LET g_stcf_d[l_ac].stcf007 = l_staf006
          WHEN 'stcf008'
             LET g_stcf_d[l_ac].stcf008 = l_staf006
             CALL astm601_stcf008_ref()
          WHEN 'stcf009'
             LET g_stcf_d[l_ac].stcf009 = l_staf006
             CALL astm601_stcf009_ref()
          WHEN 'stcf010'
             LET g_stcf_d[l_ac].stcf010 = l_staf006
          WHEN 'stcf011'
             LET g_stcf_d[l_ac].stcf011 = l_staf006
          WHEN 'stcf012'
             LET g_stcf_d[l_ac].stcf012 = l_staf006
          WHEN 'stcf013'
             LET g_stcf_d[l_ac].stcf013 = l_staf006
          WHEN 'stcf014'
             LET g_stcf_d[l_ac].stcf014 = l_staf006
          WHEN 'stcf015'
             LET g_stcf_d[l_ac].stcf015 = l_staf006
          WHEN 'stcf016'
             LET g_stcf_d[l_ac].stcf016 = l_staf006
          WHEN 'stcf017'
             LET g_stcf_d[l_ac].stcf017 = l_staf006
      END CASE

      IF NOT cl_null(g_stcf_d[l_ac].stcf006) AND NOT cl_null(g_stcf_d[l_ac].stcf007)  AND NOT cl_null(g_stcf_d[l_ac].stcf016) AND NOT cl_null(g_stcf_d[l_ac].stcf017) THEN    
         CALL s_astm601_cal_nextd(g_stcf_d[l_ac].stcf006,g_stcf_d[l_ac].stcf007,g_stcf_d[l_ac].stcf016,g_stcf_d[l_ac].stcf017,'','') RETURNING g_stcf_d[l_ac].stcf018,g_stcf_d[l_ac].stcf019,g_stcf_d[l_ac].stcf020
      END IF


   END FOREACH 
   DISPLAY BY NAME g_stcf_d[l_ac].stcf003,g_stcf_d[l_ac].stcf004,g_stcf_d[l_ac].stcf005,
                  g_stcf_d[l_ac].stcf006,g_stcf_d[l_ac].stcf007,g_stcf_d[l_ac].stcf008,g_stcf_d[l_ac].stcf008_desc,
                  g_stcf_d[l_ac].stcf009,g_stcf_d[l_ac].stcf009_desc,g_stcf_d[l_ac].stcf010,g_stcf_d[l_ac].stcf011,
                  g_stcf_d[l_ac].stcf012,g_stcf_d[l_ac].stcf013,g_stcf_d[l_ac].stcf014,
                  g_stcf_d[l_ac].stcf015,g_stcf_d[l_ac].stcf016,g_stcf_d[l_ac].stcf017,g_stcf_d[l_ac].stcf018,g_stcf_d[l_ac].stcf019,g_stcf_d[l_ac].stcf020

   
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
PUBLIC FUNCTION astm601_stcf008_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stcf_d[l_ac].stcf008
   CALL ap_ref_array2(g_ref_fields,"SELECT stabl003 FROM stabl_t WHERE stablent='"||g_enterprise||"' AND stabl001=? AND stabl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stcf_d[l_ac].stcf008_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stcf_d[l_ac].stcf008_desc
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
PUBLIC FUNCTION astm601_stcf009_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stcf_d[l_ac].stcf009
   CALL ap_ref_array2(g_ref_fields,"SELECT stabl003 FROM stabl_t WHERE stablent='"||g_enterprise||"' AND stabl001=? AND stabl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stcf_d[l_ac].stcf009_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stcf_d[l_ac].stcf009_desc
  
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
PUBLIC FUNCTION astm601_stcf016_017_chk()
DEFINE l_n    LIKE type_t.num5
DEFINE l_staf004_stao017   LIKE staf_t.staf004
DEFINE l_staf004_stao018   LIKE staf_t.staf004

   #费用编号不为空的话 检查asti204是否设置日期为noentry
   IF NOT cl_null( g_stcf_d[l_ac].stcf002) THEN
      SELECT staf004 INTO l_staf004_stao017 FROM staf_t
       WHERE stafent = g_enterprise AND staf001 =  g_stcf_d[l_ac].stcf002 AND staf002 = g_stce_m.stce005
         AND staf003 = 'stao017'
   
      SELECT staf004 INTO l_staf004_stao018 FROM staf_t
       WHERE stafent = g_enterprise AND staf001 =  g_stcf_d[l_ac].stcf002 AND staf002 = g_stce_m.stce005
         AND staf003 = 'stao018'
         
      IF l_staf004_stao017 = 'N' AND l_staf004_stao017 = 'N' THEN
         RETURN TRUE
      END IF
   END IF
   
   
   LET l_n = 0
   IF g_stcf_d[l_ac].stcf016 < g_stce_m.stce017 OR g_stcf_d[l_ac].stcf016 > g_stce_m.stce018 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ast-00032'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   
   IF g_stcf_d[l_ac].stcf017 < g_stce_m.stce017 OR g_stcf_d[l_ac].stcf017 > g_stce_m.stce018 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ast-00032'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   
   IF NOT cl_null(g_stcf_d[l_ac].stcf016) AND NOT cl_null(g_stcf_d[l_ac].stcf017) THEN
      IF g_stcf_d[l_ac].stcf016 > g_stcf_d[l_ac].stcf017 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aoo-00122'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF
   
  ##先不判断
  #IF NOT cl_null(g_stcf_d[l_ac].stcf016) AND NOT cl_null(g_stcf_d[l_ac].stcf017) AND NOT cl_null(g_stcf_d[l_ac].stcfseq) AND NOT cl_null(g_stcf_d[l_ac].stcf002)THEN
  #  SELECT COUNT(*) INTO l_n FROM stcf_t 
  #   WHERE stcf001 = g_stce_m.stce001
  #     AND stcf002 = g_stcf_d[l_ac].stcf002
  #     AND stcfseq <> g_stcf_d[l_ac].stcfseq
  #     AND ((stcf016 between g_stcf_d[l_ac].stcf016 AND g_stcf_d[l_ac].stcf017)
  #      OR (stcf017 between g_stcf_d[l_ac].stcf016 AND g_stcf_d[l_ac].stcf017)
  #      OR (g_stcf_d[l_ac].stcf016 between stcf016 AND stcf017  )
  #      OR (g_stcf_d[l_ac].stcf017 between stcf016 AND stcf017  ))         
  #END IF      
  #IF l_n > 0 THEN
  #   INITIALIZE g_errparam TO NULL
  #   LET g_errparam.code = 'ast-00031'
  #   LET g_errparam.extend = ''
  #   LET g_errparam.popup = TRUE
  #   CALL cl_err()
  #
  #   RETURN FALSE
  #ELSE
  #   RETURN TRUE 
  #END IF
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
PUBLIC FUNCTION astm601_stce017_018_chk(p_cmd,p_field)
DEFINE p_cmd       LIKE type_t.chr1
DEFINE p_field     STRING
DEFINE l_cnt       LIKE type_t.num5
DEFINE l_stcw003   LIKE stcw_t.stcw003

   #判断生效日期不可大于失效日期
   IF NOT cl_null(g_stce_m.stce017) AND NOT cl_null(g_stce_m.stce018) THEN
      IF g_stce_m.stce017 >g_stce_m.stce018 THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'aoo-00122'
          LET g_errparam.extend = ''
          LET g_errparam.popup = TRUE
          CALL cl_err()
   
          RETURN FALSE
      END IF
   END IF
   #
   #IF NOT cl_null(g_stce_m.stce017) OR NOT cl_null(g_stce_m.stce018) THEN
   #   FOR i=1 TO g_stcf_d.getLength()
   #      IF (g_stce_m.stce017 > g_stcf_d[i].stcf016) OR (g_stce_m.stce018 < g_stcf_d[i].stcf017)  THEN
   #         INITIALIZE g_errparam TO NULL
   #         LET g_errparam.code = 'ast-00032'
   #         LET g_errparam.extend = ''
   #         LET g_errparam.popup = TRUE
   #         CALL cl_err()
   #
   #         RETURN FALSE
   #      END IF
   #   END FOR
   #END IF
   #RETURN TRUE
   
   
   
   #判断生效日期，不可大于单身的生效日期
   IF p_field = 'stce017' THEN
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt
        FROM stcf_t
       WHERE stcfent = g_enterprise
         AND stcf001 = g_stce_m.stce001
         AND stcf016 < g_stce_m.stce017
      IF l_cnt > 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ast-00032'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF
   
   #判断失效日期，不可小于单身的失效日期
   IF p_field = 'stca018' THEN
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt
        FROM stcf_t
       WHERE stcfent = g_enterprise
         AND stcf001 = g_stce_m.stce001
         AND stcf017 > g_stce_m.stce018
      IF l_cnt > 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ast-00032'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF

  
   #如果生效/失效日期/结算方式有修改，自动算下次计算日（网点为NULL时）
   IF cl_null(g_stce_m.stce010) THEN
      IF NOT cl_null(g_stce_m.stce017) AND NOT cl_NULL(g_stce_m.stce018) AND NOT cl_null(g_stce_m.stce006) THEN
         IF cl_null(g_stce_m_o.stce017) OR 
            g_stce_m.stce017 <> g_stce_m_o.stce017 OR g_stce_m.stce018 <> g_stce_m_o.stce018 OR
            g_stce_m.stce006 <> g_stce_m_o.stce006 THEN
            
            LET g_stce_m.next_b = astm601_get_nextdate(g_stce_m.stce006,g_stce_m.stce017,g_stce_m.stce018)
         END IF
         DISPLAY g_stce_m.next_b TO next_b
         LET g_stce_m_o.stce017 = g_stce_m.stce017
         LET g_stce_m_o.stce018 = g_stce_m.stce018
         LET g_stce_m_o.stce006 = g_stce_m.stce006
      END IF
   ELSE
      #网点不为空，对网点的合同，不设置帐期
      LET g_stce_m.next_b = NULL
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
PUBLIC FUNCTION astm601_stceunit_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stce_m.stceunit
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stce_m.stceunit_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stce_m.stceunit_desc
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
PUBLIC FUNCTION astm601_init_required(p_cmd)
DEFINE p_cmd   LIKE type_t.chr1
   CALL cl_set_comp_required("stcf004,stcf005,stcf006,stcf007,stcf008,stcf009,stcf010,stcf012,stcf015,stcf016,stcf017",TRUE)
   CALL cl_set_comp_required("stcf003,stcf011,stcf013,stcf014",FALSE)
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
PUBLIC FUNCTION astm601_init_entry(p_cmd)
DEFINE p_cmd   LIKE type_t.chr1

   CALL cl_set_comp_entry("stcf003,stcf004,stcf005,stcf006,stcf007,stcf008,stcf009,stcf010,stcf011,stcf012,stcf013,stcf014,stcf015,stcf016,stcf017",TRUE)
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
PUBLIC FUNCTION astm601_interval_chk(p_cmd)
DEFINE p_cmd     LIKE type_t.chr1
DEFINE l_n       LIKE type_t.num5


   IF p_cmd = 'a' OR  p_cmd = 'r' THEN 
   
      IF NOT cl_null(g_stce_m.stce010) THEN
         SELECT COUNT(*) INTO l_n FROM stce_t
          WHERE stceent = g_enterprise AND stce005 = g_stce_m.stce005 
            AND stce009 = g_stce_m.stce009 AND stce010 = g_stce_m.stce010
            AND stce006 = g_stce_m.stce006
            AND (stce017 BETWEEN g_stce_m.stce017 AND g_stce_m.stce018
                 OR stce018 BETWEEN g_stce_m.stce017 AND g_stce_m.stce018
                 OR g_stce_m.stce017 BETWEEN stce017 AND stce018
                 OR g_stce_m.stce018 BETWEEN stce017 AND stce018)
            AND stcestus = 'Y'
      ELSE
         SELECT COUNT(*) INTO l_n FROM stce_t
          WHERE stceent = g_enterprise AND stce005 = g_stce_m.stce005 
            AND stce009 = g_stce_m.stce009 AND stce010 IS NULL
            AND stce006 = g_stce_m.stce006
            AND (stce017 BETWEEN g_stce_m.stce017 AND g_stce_m.stce018
                 OR stce018 BETWEEN g_stce_m.stce017 AND g_stce_m.stce018
                 OR g_stce_m.stce017 BETWEEN stce017 AND stce018
                 OR g_stce_m.stce018 BETWEEN stce017 AND stce018)
            AND stcestus = 'Y' 
      END IF
       
   ELSE
      IF NOT cl_null(g_stce_m.stce010) THEN
         SELECT COUNT(*) INTO l_n FROM stce_t
          WHERE stceent = g_enterprise AND stce005 = g_stce_m.stce005 
            AND stce009 = g_stce_m.stce009 AND stce010 = g_stce_m.stce010
            AND stce006 = g_stce_m.stce006
            AND (stce017 BETWEEN g_stce_m.stce017 AND g_stce_m.stce018
                 OR stce018 BETWEEN g_stce_m.stce017 AND g_stce_m.stce018
                 OR g_stce_m.stce017 BETWEEN stce017 AND stce018
                 OR g_stce_m.stce018 BETWEEN stce017 AND stce018) 
            AND stce001 <>  g_stce_m.stce001
            AND stcestus = 'Y'   
      ELSE
          SELECT COUNT(*) INTO l_n FROM stce_t
          WHERE stceent = g_enterprise AND stce005 = g_stce_m.stce005 
            AND stce009 = g_stce_m.stce009 AND stce010 IS NULL
            AND stce006 = g_stce_m.stce006
            AND (stce017 BETWEEN g_stce_m.stce017 AND g_stce_m.stce018
                 OR stce018 BETWEEN g_stce_m.stce017 AND g_stce_m.stce018
                 OR g_stce_m.stce017 BETWEEN stce017 AND stce018
                 OR g_stce_m.stce018 BETWEEN stce017 AND stce018) 
            AND stce001 <>  g_stce_m.stce001
            AND stcestus = 'Y'   
      END IF      
   END IF
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ast-00050'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
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
PUBLIC FUNCTION astm601_stce010_ref()
    INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stce_m.stce010
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stce_m.stce010_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stce_m.stce010_desc
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
PUBLIC FUNCTION astm601_stce010_chk(p_stce010)
DEFINE p_stce010 LIKE stce_t.stce010

   INITIALIZE g_chkparam.* TO NULL
   LET g_errshow = '1'
   LET g_chkparam.arg1 = p_stce010
   
   #160318-00025#37  2016/04/19  by pengxin  add(S)
   LET g_errshow = TRUE #是否開窗 
   LET g_chkparam.err_str[1] = "adb-00285:sub-01302|adbm201|",cl_get_progname("adbm201",g_lang,"2"),"|:EXEPROGadbm201"
   #160318-00025#37  2016/04/19  by pengxin  add(E)
   
   IF NOT cl_chk_exist("v_pmaa001_21") THEN
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
PUBLIC FUNCTION astm601_stce009_stce010_chk(p_stce009,p_stce010)
DEFINE p_stce009 LIKE stce_t.stce009
DEFINE p_stce010 LIKE stce_t.stce010
DEFINE l_n       LIKE type_t.num5

  SELECT COUNT(*) INTO l_n FROM pmaa_t 
   WHERE pmaaent = g_enterprise AND pmaa001 = p_stce010 AND pmaa006 = p_stce009
  
  IF l_n =0 THEN
     INITIALIZE g_errparam TO NULL
     LET g_errparam.code = 'ast-00043'
     LET g_errparam.extend = ''
     LET g_errparam.popup = TRUE
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
PUBLIC FUNCTION astm601_stce011_ref()
    INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stce_m.stce011
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '281' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stce_m.stce011_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stce_m.stce011_desc
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
PUBLIC FUNCTION astm601_stce012_ref()
   # INITIALIZE g_ref_fields TO NULL
   #LET g_ref_fields[1] = g_stce_m.stce012
   #CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '2035' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   #LET g_stce_m.stce012_desc = '', g_rtn_fields[1] , ''
   #DISPLAY BY NAME g_stce_m.stce012_desc
   
   CALL s_desc_get_oojdl003_desc(g_stce_m.stce012) RETURNING g_stce_m.stce012_desc
   DISPLAY BY NAME g_stce_m.stce012_desc
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
PUBLIC FUNCTION astm601_stce026_ref()

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stce_m.stce026
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stce_m.stce026_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stce_m.stce026_desc

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
PUBLIC FUNCTION astm601_stce026_chk(p_stce026)
DEFINE p_stce026  LIKE stce_t.stce026

  
  INITIALIZE g_chkparam.* TO NULL
  LET g_errshow = '1'
  LET g_chkparam.arg1 = p_stce026
  #LET g_chkparam.arg2 = '2'
  IF NOT cl_chk_exist("v_ooef001_20") THEN
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
PUBLIC FUNCTION astm601_stce016_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stce_m.stce016
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stce_m.stce016_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stce_m.stce016_desc
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
PUBLIC FUNCTION astm601_stce022_ref()
 SELECT oodbl004 INTO g_stce_m.stce022_desc
    FROM oodbl_t,ooef_t
  WHERE oodblent = g_enterprise AND oodbl001 = ooef019 
    AND oodbl002 = g_stce_m.stce022 AND oodbl003 = g_dlang
    AND ooefent = g_enterprise AND ooef001 = g_site
  DISPLAY  BY NAME g_stce_m.stce022_desc
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
PUBLIC FUNCTION astm601_stce022_chk(p_stce022)
DEFINE  p_stce022    LIKE stce_t.stce007
DEFINE  l_oodcstus   LIKE oodc_t.oodcstus


   LET g_errno = ''
   SELECT oodbstus INTO l_oodcstus
     FROM oodb_t,ooef_t
    WHERE oodbent = g_enterprise AND oodb001 = ooef019 AND oodb002 = p_stce022 AND oodb004 = '1'
      AND ooefent = g_enterprise AND ooef001 = g_site
   CASE
      WHEN SQLCA.sqlcode = 100 LET g_errno = 'ast-00009' #稅目不存在
                               LET g_stce_m.stce007_desc = ''
      WHEN l_oodcstus <> 'Y'   LET g_errno = 'ast-00010' #稅目已無效
                               LET  g_stce_m.stce007_desc = ''
   END CASE
   IF cl_null(g_errno) THEN
      RETURN TRUE
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = g_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
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
PUBLIC FUNCTION astm601_convert(p_stcf003)
DEFINE p_stcf003   LIKE stcf_t.stcf003
DEFINE l_num       LIKE type_t.num5
DEFINE l_str       STRING

   LET l_str = p_stcf003
   LET l_str = l_str.subString(5,7)
   LET l_num = l_str-1   
   LET l_str = l_num USING "&&&"
   LET l_str = p_stcf003[1,4]||l_str
   
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
PUBLIC FUNCTION astm601_stce009_other()

   SELECT pmaa090,pmaa231 INTO g_stce_m.stce011,g_stce_m.stce012 FROM pmaa_t
    WHERE pmaaent = g_enterprise AND pmaa001 = g_stce_m.stce009
   DISPLAY BY NAME  g_stce_m.stce011,g_stce_m.stce012 
   CALL astm601_stce011_ref()
   CALL astm601_stce012_ref()
      
   #抓取合约编号预设到结算合约编号
   SELECT stce001 INTO g_stce_m.stce027 FROM stce_t
    WHERE stceent = g_enterprise AND stce009 = g_stce_m.stce009 
      AND stce005 = g_stce_m.stce005
      AND stce008 = '1' AND stce018 >= g_today AND stcestus = 'Y' AND  rownum = 1
   DISPLAY BY NAME  g_stce_m.stce027
   
   CALL astm601_stce027_other()
  #LET t_stce.* = g_stce_m.*       #170202-00019#1 170202 by 02749 mark
  
  #170202-00019#1 170202 by 02749 add---(S)
  LET g_stce_m_o.stce011 = g_stce_m.stce011
  LET g_stce_m_o.stce012 = g_stce_m.stce012
  LET g_stce_m_o.stce027 = g_stce_m.stce027
  #170202-00019#1 170202 by 02749 add---(E)

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
PUBLIC FUNCTION astm601_stce027_chk()
DEFINE l_n       LIKE type_t.num5
DEFINE l_stce005 LIKE stce_t.stce005
DEFINE l_stce009 LIKE stce_t.stce009

   SELECT COUNT(*) INTO l_n FROM stce_t
     WHERE stceent = g_enterprise AND stce001 = g_stce_m.stce027 AND stcestus = 'Y'
   IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ast-00113'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
   
   SELECT COUNT(*) INTO l_n FROM stce_t
     WHERE stceent = g_enterprise AND stce001 = g_stce_m.stce027 AND stce008 = '2' AND stcestus = 'Y'
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ast-00132'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   ELSE
      SELECT stce005,stce009 INTO l_stce005,l_stce009 FROM stce_t
       WHERE stceent = g_enterprise AND stce001 = g_stce_m.stce027
      IF l_stce005 <> g_stce_m.stce005 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ast-00118'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF  
      IF l_stce009 <> g_stce_m.stce009 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ast-00128'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF
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
PUBLIC FUNCTION astm601_stce027_other()

   SELECT stce006,stce021,stce022,stce023,stce024,stce028,stce025,stce026,stce017,stce018 
      INTO g_stce_m.stce006,g_stce_m.stce021, g_stce_m.stce022, g_stce_m.stce023, g_stce_m.stce024,
           g_stce_m.stce028,g_stce_m.stce025, g_stce_m.stce026, g_stce_m.stce017, g_stce_m.stce018
      FROM stce_t WHERE stceent=g_enterprise AND stce001 = g_stce_m.stce027
      
   CALL astm601_stce021_ref()
   CALL astm601_stce022_ref()
   CALL astm601_stce024_ref()
   CALL astm601_stce028_ref()
   CALL astm601_stce025_ref()
   CALL astm601_stce026_ref()
   DISPLAY BY NAME g_stce_m.stce006,g_stce_m.stce021, g_stce_m.stce022, g_stce_m.stce023, g_stce_m.stce024,
                   g_stce_m.stce028,g_stce_m.stce025, g_stce_m.stce026, g_stce_m.stce017, g_stce_m.stce018
   
   #170202-00019#1 170202 by 02749 add---(S)
   LET g_stce_m_o.stce006 = g_stce_m.stce006
   LET g_stce_m_o.stce021 = g_stce_m.stce021
   LET g_stce_m_o.stce022 = g_stce_m.stce022
   LET g_stce_m_o.stce023 = g_stce_m.stce023
   LET g_stce_m_o.stce024 = g_stce_m.stce024
   LET g_stce_m_o.stce028 = g_stce_m.stce028
   LET g_stce_m_o.stce025 = g_stce_m.stce025
   LET g_stce_m_o.stce026 = g_stce_m.stce026
   LET g_stce_m_o.stce017 = g_stce_m.stce017
   LET g_stce_m_o.stce018 = g_stce_m.stce018
   #170202-00019#1 170202 by 02749 add---(E)
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
PUBLIC FUNCTION astm601_set_visible()

   IF g_stce_m.stce008 = '2' OR NOT cl_null(g_stce_m.stce010) THEN
      CALL cl_set_comp_visible("next_b,page_period",FALSE)
   ELSE
      CALL cl_set_comp_visible("next_b,page_period",TRUE)
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
PUBLIC FUNCTION astm601_upd_stcw(p_cmd)
DEFINE p_cmd       LIKE type_t.chr1
DEFINE r_success   LIKE type_t.num5
DEFINE l_cnt       LIKE type_t.num5
DEFINE l_stce006   LIKE stce_t.stce006
DEFINE l_stce017   LIKE stce_t.stce017
DEFINE l_stce018   LIKE stce_t.stce018
DEFINE l_stcw004   LIKE stcw_t.stcw004

   LET r_success = TRUE
   #如果结算方式、生失效日期、下次计算日有异动才提示是否删除为结算帐期，重新产生帐期
 
   IF p_cmd = 'u'  THEN
      IF g_stce_m.stce006 <> g_stce_m_t.stce006 OR g_stce_m.stce017 <> g_stce_m_t.stce017 OR 
         g_stce_m.stce018 <> g_stce_m_t.stce018 OR g_stce_m.next_b <> g_stce_m_t.next_b THEN
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM stcw_t
          WHERE stcwent = g_enterprise AND stcw001 = g_stce_m.stce001
            AND stcw005 = 'Y'
         IF l_cnt > 0 THEN
            IF NOT cl_ask_confirm('ast-00097') THEN
               LET r_success = FALSE
            END IF
         ELSE
            IF NOT cl_ask_confirm('ast-00146') THEN
               LET r_success = FALSE
            END IF
         END IF
      ELSE
         #没有变，不用更新单身帐期
         RETURN TRUE
      END IF
   END IF
   
   IF r_success THEN
      #150320-00008#1 modify-S by ken 150323 stcesite改為no use後不使用
      #IF NOT s_astm601_cal_period(g_stce_m.stce001,g_stce_m.stce017,g_stce_m.stce018,g_stce_m.stce006,g_stce_m.next_b,g_stce_m.stcesite,g_stce_m.stceunit) THEN
      IF NOT s_astm601_cal_period(g_stce_m.stce001,g_stce_m.stce017,g_stce_m.stce018,g_stce_m.stce006,g_stce_m.next_b,'',g_stce_m.stceunit) THEN      
      # modify-E
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ast-00049'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
   END IF
   
   IF r_success = FALSE THEN
      LET g_stce_m.stce006 = g_stce_m_t.stce006
      LET g_stce_m.stce017 = g_stce_m_t.stce017
      LET g_stce_m.stce018 = g_stce_m_t.stce018
      LET g_stce_m.next_b = g_stce_m_t.next_b     
   ELSE
      CALL astm601_b_fill()
   END IF
   DISPLAY BY NAME g_stce_m.stce006,g_stce_m.stce017,g_stce_m.stce018,g_stce_m.next_b
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
PUBLIC FUNCTION astm601_get_nextdate(p_stce006,p_date1,p_date2)
DEFINE p_stce006   LIKE stce_t.stce006
DEFINE p_date1     LIKE stce_t.stce017
DEFINE p_date2     LIKE stce_t.stce018
DEFINE r_nextdate  LIKE stce_t.stce017
DEFINE l_staa002   LIKE staa_t.staa002
DEFINE l_staa003   LIKE staa_t.staa003
DEFINE l_staa004   LIKE staa_t.staa004
DEFINE l_date      LIKE type_t.dat

   IF cl_null(p_stce006) OR cl_null(p_date1) OR cl_null(p_date2) THEN
      RETURN ''
   END IF
   
   SELECT staa002,staa003,staa004 INTO l_staa002,l_staa003,l_staa004
     FROM staa_t
    WHERE staa001 = p_stce006
      AND staaent = g_enterprise #160905-00007#16 add
   IF cl_null(l_staa002) THEN LET l_staa002 = 0 END IF
   IF cl_null(l_staa003) THEN LET l_staa003 = 0 END IF
   IF l_staa002 = 0 AND l_staa003 = 0 THEN RETURN '' END IF
   
   LET l_date = p_date1
   IF l_staa002 > 0 THEN
      IF l_staa004 = '1' THEN
         LET r_nextdate = s_date_get_date(p_date1,l_staa002,0)
      ELSE
         LET r_nextdate = s_date_get_date(p_date1,l_staa002-1,0)
      END IF
      LET l_date = r_nextdate
   END IF

   IF l_staa004 = '1' THEN
      LET r_nextdate = s_date_get_date(l_date,0,l_staa003-1)
   ELSE
      IF l_staa003 > 0 THEN
         LET r_nextdate = s_date_get_date(l_date,0,l_staa003-1)
      END IF
   END IF
   IF l_staa004 = '2' THEN
      LET r_nextdate = s_date_get_last_date(r_nextdate)   
   END IF
   IF r_nextdate > p_date2 THEN LET r_nextdate = p_date2 END IF
   RETURN r_nextdate
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
PUBLIC FUNCTION astm601_stce023_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stce_m.stce023
   CALL ap_ref_array2(g_ref_fields,"SELECT ooibl004 FROM ooibl_t WHERE ooiblent='"||g_enterprise||"' AND ooibl002=? AND ooibl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stce_m.stce023_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stce_m.stce023_desc
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
PUBLIC FUNCTION astm601_b_chk()
DEFINE l_n1        LIKE type_t.num5
DEFINE l_n2        LIKE type_t.num5

  #单身条件基准 和单头的结算类型不符合就报错
     SELECT COUNT(*) INTO l_n1 FROM stcf_t 
       WHERE stcfent = g_enterprise AND stcf001 = g_stce_m.stce001 AND stcf008 IS NOT NULL
         AND NOT EXISTS (SELECT 1 FROM stab_t LEFT OUTER JOIN stat_t ON stabent = statent AND stab001 = stat003
              WHERE stab001 = stcf008 AND stat001 = g_stce_m.stce005 AND stat002 = g_stce_m.stce007)

    SELECT COUNT(*) INTO l_n2 FROM stcf_t 
       WHERE stcfent = g_enterprise AND stcf001 = g_stce_m.stce001 AND stcf009 IS NOT NULL
         AND NOT EXISTS (SELECT 1 FROM stab_t LEFT OUTER JOIN stat_t ON stabent = statent AND stab001 = stat003
              WHERE stab001 = stcf009 AND stat001 = g_stce_m.stce005 AND stat002 = g_stce_m.stce007) 
   
   IF l_n1 > 0 OR l_n2 > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ast-00110'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
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
PUBLIC FUNCTION astm601_stcf005_chk(p_ac)
DEFINE p_ac  LIKE type_t.num5
DEFINE l_n   LIKE type_t.num5
DEFINE r_ac  LIKE type_t.num5

  IF p_ac > 0 THEN     #检查单笔
     IF NOT cl_null(g_stce_m.stce010) AND g_stcf_d[l_ac].stcf005 <> '2' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ast-00191'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_ac = p_ac
         RETURN FALSE,r_ac
     END IF
  ELSE                  #检查单身多笔
     IF g_stcf_d.getLength() > 0 THEN
        FOR l_n = 1 TO g_stcf_d.getLength()
            IF NOT cl_null(g_stce_m.stce010) AND  g_stcf_d[l_n].stcf005 <> '2' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ast-00191'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_ac = l_n
               RETURN FALSE,r_ac
            END IF
        END FOR
     END IF    
  END IF
  RETURN TRUE,''
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
PUBLIC FUNCTION astm601_stce028_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stce_m.stce028
   CALL ap_ref_array2(g_ref_fields,"SELECT dbbcl003 FROM dbbcl_t WHERE dbbclent='"||g_enterprise||"' AND dbbcl001=? AND dbbcl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stce_m.stce028_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stce_m.stce028_desc
   CALL astm601_stce028_other()
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
PUBLIC FUNCTION astm601_stce028_other()

   SELECT dbbc002,dbbc003 INTO g_stce_m.stce025,g_stce_m.stce012 FROM dbbc_t
    WHERE dbbcent = g_enterprise AND dbbc001 = g_stce_m.stce028
   DISPLAY BY NAME g_stce_m.stce025,g_stce_m.stce012
   CALL astm601_stce025_ref()
   CALL astm601_stce012_ref()
   
   LET g_stce_m_o.stce025 = g_stce_m.stce025   #170202-00019#1 170202 by 02749 add
   LET g_stce_m_o.stce012 = g_stce_m.stce012   #170202-00019#1 170202 by 02749 add
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
PUBLIC FUNCTION astm601_stce028_chk()
  
  INITIALIZE g_chkparam.* TO NULL
  LET g_errshow = '1'
  LET g_chkparam.arg1 = g_stce_m.stce028

  IF NOT cl_chk_exist("v_dbbc001") THEN
     RETURN FALSE
  END IF
   RETURN TRUE
END FUNCTION

 
{</section>}
 
