#該程式未解開Section, 採用最新樣板產出!
{<section id="artt100.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0017(2016-03-30 11:12:38), PR版次:0017(2016-12-15 10:03:56)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000243
#+ Filename...: artt100
#+ Description: 門店基本資料異動申請作業
#+ Creator....: 03079(2014-03-27 17:07:11)
#+ Modifier...: 06815 -SD/PR- 07900
 
{</section>}
 
{<section id="artt100.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#14  2016/04/18 by 07673   將重複內容的錯誤訊息置換為公用錯誤訊息
#160421-00013#1   2016/04/22 by 08172   面积显示格式
#160705-00042#6   2016/07/12 by sakura  查詢程式段q_ooba002_1開窗，呼叫開窗前的g_qryparam.arg若是要傳入程式代號，要改傳入g_prog
#160818-00017#34  2016-08-22 by 08734   删除修改未重新判断状态码
#160913-00034#5   2016/09/14 by 08742   q_pmaa001開窗改成 q_pmaa001_1 抓类型= 1,2,3，同时修改栏位控管
#161024-00025#4   2016/10/24 by 08172   组织调整
#161024-00025#1   2016/10/24 by dongsz  rtbc105,rtbc106增加aooi500管控
#161024-00025#3   2016/10/26 by dongsz  rtbc001开窗替换q_ooef001_24,增加ooef304=Y条件
#161108-00016#1   2016/11/09 by 08742   修改 g_browser_cnt 定义大小
#160824-00007#158 2016/11/25 by 06814   新舊值處理
#161214-00032#1   2016/12/15 by 07900   石狮通达权限设置.freestyle或者是改过section者,需检核规格【资料表关联设定】主表要跟现在程序主表一致;主sql部分要补上cl_sql_add_filter
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT util
IMPORT FGL aoo_aooi350_01
IMPORT FGL aoo_aooi350_02
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
GLOBALS "../../aoo/4gl/aooi350_01.inc"  
GLOBALS "../../aoo/4gl/aooi350_02.inc" 

 TYPE type_g_rtbc_m RECORD
   rtbcunit       LIKE rtbc_t.rtbcunit,
   rtbcunit_desc  LIKE type_t.chr80,
   rtbcdocdt      LIKE rtbc_t.rtbcdocdt,
   rtbcdocno      LIKE rtbc_t.rtbcdocno,
   rtbc000        LIKE rtbc_t.rtbc000,
   rtbc001        LIKE rtbc_t.rtbc001,
   rtbcl002       LIKE rtbcl_t.rtbcl002,
   rtbcl003       LIKE rtbcl_t.rtbcl003,
   rtbcl004       LIKE rtbcl_t.rtbcl004,
   rtbcstus       LIKE rtbc_t.rtbcstus,
   rtbc017        LIKE rtbc_t.rtbc017,
   rtbc017_desc   LIKE type_t.chr80,
   rtbc101        LIKE rtbc_t.rtbc101,
   rtbc105        LIKE rtbc_t.rtbc105,
   rtbc105_desc   LIKE type_t.chr80,
   rtbc102        LIKE rtbc_t.rtbc102,
   rtbc103        LIKE rtbc_t.rtbc103,
   rtbc100        LIKE rtbc_t.rtbc100,
   rtbc104        LIKE rtbc_t.rtbc104,
   rtbc104_desc   LIKE type_t.chr80,
   rtbc106        LIKE rtbc_t.rtbc106,
   rtbc106_desc   LIKE type_t.chr80,
   rtbc108        LIKE rtbc_t.rtbc108,
   rtbc108_desc   LIKE type_t.chr80,
   rtbc107        LIKE rtbc_t.rtbc107,
   rtbc115        LIKE rtbc_t.rtbc115,
   rtbc116        LIKE rtbc_t.rtbc116,
   rtbc109        LIKE rtbc_t.rtbc109,
   rtbc110        LIKE rtbc_t.rtbc110,
   rtbc111        LIKE rtbc_t.rtbc111, 
   rtbc112        LIKE rtbc_t.rtbc112,
   rtbc113        LIKE rtbc_t.rtbc113,
   rtbc114        LIKE rtbc_t.rtbc114,
   rtbc120        LIKE rtbc_t.rtbc120,
   rtbc121        LIKE rtbc_t.rtbc121,
   rtbc122        LIKE rtbc_t.rtbc122,
   rtbc123        LIKE rtbc_t.rtbc123,  
   rtbc123_desc   LIKE type_t.chr80,    
   rtbc124        LIKE rtbc_t.rtbc124,  
   rtbc124_desc   LIKE type_t.chr80,    
   rtbc125        LIKE rtbc_t.rtbc125,  
   rtbc125_desc   LIKE type_t.chr80,    
   rtbc126        LIKE rtbc_t.rtbc126,  #s983961--add  
   rtbc126_desc   LIKE type_t.chr80,    #s983961--add
   rtbc127        LIKE rtbc_t.rtbc127,  #s983961--add
   rtbc127_desc   LIKE type_t.chr80,    #s983961--add
   rtbc128        LIKE rtbc_t.rtbc128,  #s983961--add
   rtbc128_desc   LIKE type_t.chr80,    #s983961--add
   rtbcownid      LIKE rtbc_t.rtbcownid,
   rtbcownid_desc LIKE type_t.chr80,
   rtbcowndp      LIKE rtbc_t.rtbcowndp,
   rtbcowndp_desc LIKE type_t.chr80,
   rtbccrtid      LIKE rtbc_t.rtbccrtid,
   rtbccrtid_desc LIKE type_t.chr80,
   rtbccrtdp LIKE rtbc_t.rtbccrtdp,
   rtbccrtdp_desc LIKE type_t.chr80,
   rtbccrtdt DATETIME YEAR TO SECOND,
   rtbcmodid LIKE rtbc_t.rtbcmodid,
   rtbcmodid_desc LIKE type_t.chr80,
   rtbcmoddt DATETIME YEAR TO SECOND,
   rtbccnfid LIKE rtbc_t.rtbccnfid,
   rtbccnfid_desc LIKE type_t.chr80,
   rtbccnfdt DATETIME YEAR TO SECOND,
   rtbc014 LIKE rtbc_t.rtbc014,
   rtbc014_desc LIKE type_t.chr80,
   rtbc016 LIKE rtbc_t.rtbc016, 
   rtbc016_desc LIKE type_t.chr80,
   rtbc004 LIKE rtbc_t.rtbc004,
   rtbc004_desc LIKE type_t.chr80,
   rtbc005 LIKE rtbc_t.rtbc005,
   rtbc015 LIKE rtbc_t.rtbc015,
   rtbc015_desc LIKE type_t.chr80,
   rtbc006 LIKE rtbc_t.rtbc006,
   rtbc006_desc LIKE type_t.chr80,
   rtbc018 LIKE rtbc_t.rtbc018,
   rtbc018_desc LIKE type_t.chr80,
   rtbc019 LIKE rtbc_t.rtbc019,
   rtbc019_desc LIKE type_t.chr80,
   rtbc007 LIKE rtbc_t.rtbc007,
   rtbc020 LIKE rtbc_t.rtbc020,
   rtbc022 LIKE rtbc_t.rtbc022,
   rtbc008 LIKE rtbc_t.rtbc008,
   rtbc008_desc LIKE type_t.chr80,
   rtbc010 LIKE rtbc_t.rtbc010,
   rtbc011 LIKE rtbc_t.rtbc011,
   rtbc013 LIKE rtbc_t.rtbc013,
   rtbc023 LIKE rtbc_t.rtbc023,
   rtbc024 LIKE rtbc_t.rtbc024,
   rtbc024_desc LIKE type_t.chr80,
   rtbc025 LIKE rtbc_t.rtbc025,
   rtbc026 LIKE rtbc_t.rtbc026,        #dongsz add
   rtbc026_desc LIKE type_t.chr80,     #dongsz add
   rtbc021 LIKE rtbc_t.rtbc021,
   rtbc150 LIKE rtbc_t.rtbc150,
   rtbc150_desc LIKE type_t.chr80,
   rtbc151 LIKE rtbc_t.rtbc151,
   rtbc151_desc LIKE type_t.chr80,
   rtbc152 LIKE rtbc_t.rtbc152, 
   rtbc152_desc LIKE type_t.chr80,
   rtbc153 LIKE rtbc_t.rtbc153,
   rtbc153_desc LIKE type_t.chr80,
   rtbc154 LIKE rtbc_t.rtbc154,
   rtbc154_desc LIKE type_t.chr80,
   rtbc155 LIKE rtbc_t.rtbc155,
   rtbc155_desc LIKE type_t.chr80,
   rtbc156 LIKE rtbc_t.rtbc156,
   rtbc156_desc LIKE type_t.chr80,
   rtbc157 LIKE rtbc_t.rtbc157,
   rtbc157_desc LIKE type_t.chr80,
   rtbc158 LIKE rtbc_t.rtbc158,
   rtbc158_desc LIKE type_t.chr80,
   rtbc159 LIKE rtbc_t.rtbc159,
   rtbc159_desc LIKE type_t.chr80,
   rtbc160 LIKE rtbc_t.rtbc160,
   rtbc160_desc LIKE type_t.chr80,
   rtbc161 LIKE rtbc_t.rtbc161,
   rtbc161_desc LIKE type_t.chr80,
   rtbc162 LIKE rtbc_t.rtbc162,
   rtbc162_desc LIKE type_t.chr80,
   rtbc163 LIKE rtbc_t.rtbc163,
   rtbc163_desc LIKE type_t.chr80,
   rtbc164 LIKE rtbc_t.rtbc164,
   rtbc164_desc LIKE type_t.chr80,
   rtbc165 LIKE rtbc_t.rtbc165,
   rtbc165_desc LIKE type_t.chr80,
   rtbc166 LIKE rtbc_t.rtbc166,
   rtbc166_desc LIKE type_t.chr80,
   rtbc002 LIKE rtbc_t.rtbc002, 
   rtbc003 LIKE rtbc_t.rtbc003,
   rtbc009 LIKE rtbc_t.rtbc009,
   rtbc012 LIKE rtbc_t.rtbc012,
   rtbcsite LIKE rtbc_t.rtbcsite,
   rtbcsite_desc LIKE type_t.chr80, #ken---add 需求單號：141208-00001 項次：10
   rtbcacti LIKE rtbc_t.rtbcacti
       END RECORD
       
DEFINE g_rtbc_m        type_g_rtbc_m
DEFINE g_rtbc_m_t      type_g_rtbc_m                #備份舊值
DEFINE g_rtbc_m_o      type_g_rtbc_m                #其他用途
   DEFINE g_rtbcdocno_t LIKE rtbc_t.rtbcdocno


DEFINE g_browser    DYNAMIC ARRAY OF RECORD                   #資料瀏覽之欄位  
         b_statepic     LIKE type_t.chr50,
         #ken---add---s 需求單號：141208-00001 項次：10
         b_rtbcsite     LIKE rtbc_t.rtbcsite,
         b_rtbcsite_desc  LIKE type_t.chr80,
         #ken---add---e
            b_rtbcunit LIKE rtbc_t.rtbcunit,
   b_rtbcunit_desc LIKE type_t.chr80,
      b_rtbcdocdt LIKE rtbc_t.rtbcdocdt,
      b_rtbcdocno LIKE rtbc_t.rtbcdocno,
      b_rtbc000 LIKE rtbc_t.rtbc000,
      b_rtbc001 LIKE rtbc_t.rtbc001,
      b_rtbc001_desc LIKE rtbcl_t.rtbcl002,
      b_rtbc001_desc_desc LIKE rtbcl_t.rtbcl003
         #,rank           LIKE type_t.num10
      END RECORD

DEFINE g_master_multi_table_t    RECORD
      rtbcldocno LIKE rtbcl_t.rtbcldocno,
      rtbcl002 LIKE rtbcl_t.rtbcl002,
      rtbcl003 LIKE rtbcl_t.rtbcl003,
      rtbcl004 LIKE rtbcl_t.rtbcl004
      END RECORD

DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
DEFINE g_wc2                 STRING 
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL    
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_jump                LIKE type_t.num10             #查詢指定的筆數 
DEFINE g_no_ask              LIKE type_t.num5              #是否開啟指定筆視窗 
#DEFINE g_rec_b               LIKE type_t.num5              #單身筆數    #161108-00016#1   2016/11/09  by 08742 mark   
DEFINE g_rec_b               LIKE type_t.num10             #單身筆數   #161108-00016#1   2016/11/09  by 08742 add    
DEFINE l_ac                  LIKE type_t.num5              #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
#DEFINE g_pagestart           LIKE type_t.num5             #page起始筆數#161108-00016#1   2016/11/09  by 08742 mark 
DEFINE g_pagestart           LIKE type_t.num10             #page起始筆數#161108-00016#1   2016/11/09  by 08742 add 
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_state               STRING
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_aw                  STRING             #確定當下點擊的單身

#快速搜尋用
DEFINE g_searchcol           STRING             #查詢欄位代碼
DEFINE g_searchstr           STRING             #查詢欄位字串
DEFINE g_order               STRING             #查詢排序模式

#Browser用
DEFINE g_current_idx         LIKE type_t.num5   #Browser 所在筆數(當下page)
DEFINE g_current_cnt         LIKE type_t.num10  #Browser 總筆數(當下page)

#161108-00016#1   2016/11/09  by 08742 -S
#DEFINE g_current_row         LIKE type_t.num5  #Browser 所在筆數(暫存用) 
#DEFINE g_browser_idx         LIKE type_t.num5   #Browser 所在筆數(所有資料)
#DEFINE g_browser_cnt         LIKE type_t.num5   #Browser 總筆數(所有資料)
DEFINE g_browser_idx         LIKE type_t.num10   #Browser 所在筆數(所有資料)
DEFINE g_current_row         LIKE type_t.num10  #Browser 所在筆數(暫存用) 
DEFINE g_browser_cnt         LIKE type_t.num10   
#161108-00016#1   2016/11/09  by 08742 -E

DEFINE g_tmp_page            LIKE type_t.num5 
DEFINE g_row_index           LIKE type_t.num5
DEFINE g_chk                 BOOLEAN
DEFINE g_default             BOOLEAN            #是否有外部參數查詢
#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_ooef004             LIKE ooef_t.ooef004
DEFINE g_site_flag    LIKE type_t.num5 #ken---add 需求單號：141208-00001 項次：10

#GLOBALS
#   DEFINE g_detail_insert   LIKE type_t.num5   #單身的新增權限
#   DEFINE g_detail_delete   LIKE type_t.num5   #單身的刪除權限
#   DEFINE g_wc2_i35001      STRING             #聯絡地址QBE條件
#   DEFINE g_wc2_i35002      STRING             #通訊方式QBE條件
#   DEFINE g_d_idx_i35001    LIKE type_t.num5   #聯絡地址所在筆數
#   DEFINE g_d_cnt_i35001    LIKE type_t.num5   #聯絡地址總筆數
#   DEFINE g_d_idx_i35002    LIKE type_t.num5   #通訊方式所在筆數
#   DEFINE g_d_cnt_i35002    LIKE type_t.num5   #通訊方式總筆數
#   DEFINE g_pmaa027_d       LIKE pmaa_t.pmaa027
#   DEFINE g_appoint_idx     LIKE type_t.num5   #指定進入單身行數
#END GLOBALS
DEFINE g_detail_id          STRING             #紀錄停留在聯絡地址, 通訊方式或不在此兩個Page
DEFINE g_ooef012            LIKE ooef_t.ooef012

#ken---add---s 需求單號：150107-00009 項次：5
GLOBALS
 TYPE type_g_oofb_d        RECORD
       oofbstus LIKE oofb_t.oofbstus,
   oofb001 LIKE oofb_t.oofb001,
   oofb019 LIKE oofb_t.oofb019,
   oofb011 LIKE oofb_t.oofb011,
   oofb008 LIKE oofb_t.oofb008,
   oofb009 LIKE oofb_t.oofb009,
   oofb009_desc LIKE type_t.chr500,
   oofb010 LIKE oofb_t.oofb010,
   oofb012 LIKE oofb_t.oofb012,
   oofb012_desc LIKE type_t.chr500,
   oofb013 LIKE oofb_t.oofb013,
   oofb014 LIKE oofb_t.oofb014,
   oofb014_desc LIKE type_t.chr500,
   oofb015 LIKE oofb_t.oofb015,
   oofb015_desc LIKE type_t.chr500,
   oofb016 LIKE oofb_t.oofb016,
   oofb016_desc LIKE type_t.chr500,
   oofb017 LIKE oofb_t.oofb017,
   oofb022 LIKE oofb_t.oofb022,
   oofb022_desc LIKE type_t.chr500,
   oofb020 LIKE oofb_t.oofb020,
   oofb021 LIKE oofb_t.oofb021,
   oofb018 LIKE oofb_t.oofb018
       END RECORD
DEFINE g_pmba_d          DYNAMIC ARRAY OF type_g_oofb_d

 TYPE type_g_oofc_d        RECORD
       oofcstus LIKE oofc_t.oofcstus,
   oofc001 LIKE oofc_t.oofc001,
   oofc008 LIKE oofc_t.oofc008,
   oofc009 LIKE oofc_t.oofc009,
   oofc009_desc LIKE type_t.chr500,
   oofc012 LIKE oofc_t.oofc012,
   oofc010 LIKE oofc_t.oofc010,
   oofc014 LIKE oofc_t.oofc014,
   oofc011 LIKE oofc_t.oofc011,
   oofc015 LIKE oofc_t.oofc015,
   oofc013 LIKE oofc_t.oofc013
       END RECORD
DEFINE g_pmba2_d          DYNAMIC ARRAY OF type_g_oofc_d
END GLOBALS
#ken---add---e
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="artt100.main" >}
#+ 作業開始
MAIN
   #add-point:main段define name="main.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#5  By benson 150309
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #end add-point    
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("art","")
 
   #add-point:作業初始化 name="main.init"
   #150424-00018#3 150529 by s983961 add(s) 
   IF cl_get_para(g_enterprise,g_site,'E-CIR-0018') ='N' THEN 
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'art-00580'
          LET g_errparam.extend = ''
          LET g_errparam.popup = TRUE
          CALL cl_err()    
          CALL cl_ap_exitprogram("0")      
   END IF       
   #150424-00018#3 150529 by s983961 add(e) 
   #end add-point
 
   #add-point:SQL_define name="main.define_sql"

   LET g_forupd_sql = "SELECT rtbcunit,'',rtbcdocdt,rtbcdocno,rtbc000,rtbc001,'','','',rtbcstus,rtbc017,", 
                      "       '',rtbc101,rtbc105,'',rtbc102,rtbc103,rtbc100,rtbc104,'',rtbc106,'',rtbc108,'',", 
                      "       rtbc107,rtbc115,rtbc116,rtbc109,rtbc110,rtbc111,rtbc112,rtbc113,rtbc114,rtbc120,rtbc121,", 
                      "       rtbc122,rtbc123,'',rtbc124,'',rtbc125,'', ",
                      "       rtbc126,'',rtbc127,'',rtbc128,'', ",  #160324-00019#3 s983961--add
                      "       rtbcownid,'',rtbcowndp,'',rtbccrtid,'',", 
                      "       rtbccrtdp,'',rtbccrtdt,rtbcmodid,'',rtbcmoddt,rtbccnfid,'',rtbccnfdt,rtbc014,'',", 
                      "       rtbc016,'',rtbc004,'',rtbc005,rtbc015,'',rtbc006,'',rtbc018,'',rtbc019,'',rtbc007,",
                      "       rtbc020,rtbc022,rtbc008,'',rtbc010,rtbc011,rtbc013,rtbc023,rtbc024,'',rtbc025,rtbc026,'',",
                      "       rtbc021,rtbc150,'',rtbc151,'',rtbc152,'',rtbc153,'',rtbc154,'',rtbc155,'',rtbc156,'',", 
                      "       rtbc157,'',rtbc158,'',rtbc159,'',rtbc160,'',rtbc161,'',rtbc162,'',rtbc163,'',rtbc164,", 
                      "       '',rtbc165,'',rtbc166,'',rtbc002,rtbc003,rtbc009,rtbc012,rtbcsite,rtbcacti ", 
                      "  FROM rtbc_t WHERE rtbcent= ? AND rtbcdocno=? FOR UPDATE"
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE artt100_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_artt100 WITH FORM cl_ap_formpath("art",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL artt100_init()
 
      #進入選單 Menu (='N')
      CALL artt100_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_artt100
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CLOSE artt100_cl
   CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#5  By benson 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="artt100.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION artt100_init()
   DEFINE l_success LIKE type_t.num5      #150308-00001#5  By benson 150309
   
   CALL cl_set_combo_scc_part('rtbcstus','13','N,Y,X')

   CALL cl_set_combo_scc('rtbc000','32')
   CALL cl_set_combo_scc('rtbc101','6540')
   CALL cl_set_combo_scc('rtbc102','6201')
   CALL cl_set_combo_scc('rtbc103','6541')
   CALL cl_set_combo_scc('rtbc100','6542')
   CALL cl_set_combo_scc('rtbc010','25')
   CALL cl_set_combo_scc('rtbc011','27')
   CALL cl_set_combo_scc('rtbc013','10')
   CALL cl_set_combo_scc('rtbc023','49')
   CALL cl_set_combo_scc("rtbc003",42)

   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()

   CALL cl_set_combo_scc('b_rtbc000','32')
   
   CALL cl_ui_replace_sub_window(cl_ap_formpath("aoo", "aooi350_01"), "grid_2", "Table", "s_detail1_aooi350_01")
   CALL cl_set_combo_scc('oofb008','9')   #地址類型
   CALL cl_ui_replace_sub_window(cl_ap_formpath("aoo", "aooi350_02"), "grid_3", "Table", "s_detail1_aooi350_02")
   CALL cl_set_combo_scc('oofc008','6')   #通訊類型
   CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#5  By benson 150309
   CALL cl_set_combo_lang("rtbc116") #150429-00001#1  By geza 150506
   CALL artt100_default_search()
   #160421-00013#1
   CALL s_asti800_set_comp_format("rtbc111",g_rtbc_m.rtbcsite,'2')
   CALL s_asti800_set_comp_format("rtbc112",g_rtbc_m.rtbcsite,'2')
   CALL s_asti800_set_comp_format("rtbc113",g_rtbc_m.rtbcsite,'2')

END FUNCTION

PRIVATE FUNCTION artt100_ui_dialog()
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num5
   DEFINE ls_wc     STRING
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING

   LET li_exit = FALSE
   LET g_current_row = 0
   LET g_current_idx = 1
   CALL gfrm_curr.setElementImage("logo","logo/applogo.png")

   IF g_default THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   ELSE
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF

   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL artt100_insert()

         END IF

      OTHERWISE

   END CASE

   WHILE li_exit = FALSE

      CALL artt100_browser_fill(g_wc,"")
      CALL lib_cl_dlg.cl_dlg_before_display()
      CALL cl_notice()

      #判斷前一個動作是否為新增, 若是的話切換到新增的筆數
      IF g_state = "Y" THEN
         FOR li_idx = 1 TO g_browser.getLength()
            IF g_browser[li_idx].b_rtbcdocno = g_rtbcdocno_t THEN
               LET g_current_row = li_idx
               EXIT FOR
            END IF
         END FOR
         LET g_state = ""
      END IF

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

         #左側瀏覽頁簽
         DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTE(COUNT=g_rec_b)

            BEFORE ROW
               #回歸舊筆數位置 (回到當時異動的筆數)
               LET g_current_idx = DIALOG.getCurrentRow("s_browse")
               IF g_current_idx = 0 THEN
                  LET g_current_idx = 1
               END IF
               LET g_current_row = g_current_idx  #目前指標
               LET g_current_sw = TRUE
               CALL cl_show_fld_cont()

               #當每次點任一筆資料都會需要用到
               CALL artt100_fetch("")


            ON COLLAPSE (g_row_index)
               #樹關閉

         END DISPLAY

         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps

         SUBDIALOG aoo_aooi350_01.aooi350_01_display
         SUBDIALOG aoo_aooi350_02.aooi350_02_display

         BEFORE DIALOG
            CALL cl_navigator_setting(g_current_idx, g_current_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            #LET g_page = "first"
            #還原為原本指定筆數
            IF g_current_row > 1 THEN
               #當刪除最後一筆資料時可能產生錯誤, 進行額外判斷
               IF g_current_row > g_browser.getLength() THEN
                  LET g_current_row = g_browser.getLength()
               END IF
               LET g_current_idx = g_current_row
               CALL DIALOG.setCurrentRow("s_browse",g_current_idx)
            END IF

            #當每次點任一筆資料都會需要用到
            IF g_browser_cnt > 0 THEN
               CALL artt100_fetch("")
            END IF

         AFTER DIALOG

         ON ACTION statechange
            CALL artt100_statechange()
            LET g_action_choice="statechange"
            EXIT DIALOG 
         
         ON ACTION bpm_status
            #查詢簽核狀況, 統一建立HyperLink
            CALL cl_bpm_status()

         ON ACTION filter
            CALL artt100_filter()
            EXIT DIALOG

         ON ACTION first
            CALL artt100_fetch("F")
            LET g_current_row = g_current_idx

         ON ACTION next
            CALL artt100_fetch("N")
            LET g_current_row = g_current_idx

         ON ACTION jump
            CALL artt100_fetch("/")
            LET g_current_row = g_current_idx

         ON ACTION previous
            CALL artt100_fetch("P")
            LET g_current_row = g_current_idx

         ON ACTION last
            CALL artt100_fetch("L")
            #CALL cl_navigator_setting(g_current_idx, g_current_cnt)
            #CALL fgl_set_arr_curr(g_current_idx)
            LET g_current_row = g_current_idx

         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG

         ON ACTION close
            LET li_exit = TRUE
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
            EXIT DIALOG

         #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
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

         #快速搜尋

         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL artt100_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF

         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL artt100_browser_fill(g_wc,"F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "-100"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CLEAR FORM
               ELSE
                  CALL artt100_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()

         ON ACTION delete

            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL artt100_delete()

            END IF


         ON ACTION insert

            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL artt100_insert()

               EXIT DIALOG
            END IF


         ON ACTION modify

            LET g_aw = ''
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               CALL artt100_modify()

               EXIT DIALOG
            END IF

         ON ACTION modify_detail
            LET g_aw = g_curr_diag.getCurrentItem()
            LET g_action_choice = "modify_detail"
            IF cl_auth_chk_act("modify") THEN
               CALL artt100_modify()
            END IF

         ON ACTION output

            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN

               EXIT DIALOG
            END IF


         ON ACTION query

            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL artt100_query()

            END IF


         ON ACTION reproduce

            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL artt100_reproduce()

               EXIT DIALOG
            END IF
         
         #ken---add---s 需求單號：150107-00009 項次：5
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
                  LET g_export_node[1] = base.typeInfo.create(g_pmba_d)
                  LET g_export_id[1]   = "s_detail1_aooi350_01"
                  LET g_export_node[2] = base.typeInfo.create(g_pmba2_d)
                  LET g_export_id[2]   = "s_detail1_aooi350_02"

                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF            
         #ken---add---e   
            

         #新增相關文件
         ON ACTION related_document
            IF cl_auth_chk_act("related_document") THEN   #151027-00016#2 20151111 add by beckxie
               CALL g_pk_array.clear()
               LET g_pk_array[1].values = g_rtbc_m.rtbcdocno
               LET g_pk_array[1].column = 'rtbcdocno'
               
               IF cl_auth_chk_act("related_document") THEN
               
                  CALL cl_doc()
               END IF
            END IF   #151027-00016#2 20151111 add by beckxie

         ON ACTION agendum
               CALL g_pk_array.clear()
               LET g_pk_array[1].values = g_rtbc_m.rtbcdocno
               LET g_pk_array[1].column = 'rtbcdocno'
               
               CALL cl_user_overview()
            
         ON ACTION followup 
               CALL g_pk_array.clear()
               LET g_pk_array[1].values = g_rtbc_m.rtbcdocno
               LET g_pk_array[1].column = 'rtbcdocno'
               
               CALL cl_user_overview_follow(cl_get_today())
               CALL cl_user_overview_set_follow_pic()

         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"

      END DIALOG

   END WHILE

END FUNCTION

PRIVATE FUNCTION artt100_browser_fill(p_wc,ps_page_action)
   DEFINE p_wc              STRING
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_where           STRING #ken---add 需求單號：141208-00001 項次：10

   CLEAR FORM
   INITIALIZE g_rtbc_m.* TO NULL
   INITIALIZE g_wc TO NULL
   CALL g_browser.clear()
   
   CALL aooi350_01_clear_detail()
   CALL aooi350_02_clear_detail()

   CALL s_aooi500_sql_where(g_prog,'rtbcsite') RETURNING l_where #ken---add 需求單號：141208-00001 項次：10     
   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = "0" THEN
      LET l_searchcol = "rtbcdocno"
   ELSE
      LET l_searchcol = g_searchcol
   END IF

   LET l_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   LET l_wc2 = g_wc2.trim()
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 "
   END IF

   IF g_wc2 <> " 1=1" THEN
      LET l_sub_sql = " SELECT UNIQUE rtbcdocno FROM rtbc_t ",
                  "  ",
                  "  LEFT JOIN rtbcl_t ON rtbcdocno = rtbcldocno AND rtbcl001 = '",g_lang,"' ",
                  "  LEFT JOIN oofb_t ON oofbent = rtbcent AND rtbc012 = oofb002",
                  "  LEFT JOIN oofc_t ON oofcent = rtbcent AND rtbc012 = oofc002",
                  " WHERE rtbcent = '" ||g_enterprise|| "' AND ",
                  l_wc CLIPPED, " AND ", l_wc2
   ELSE
      LET l_sub_sql = " SELECT UNIQUE rtbcdocno FROM rtbc_t ",
                  "  ",
                  "  LEFT JOIN rtbcl_t ON rtbcdocno = rtbcldocno AND rtbcl001 = '",g_lang,"' ",
                  " WHERE rtbcent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED
   END IF
   LET l_sub_sql = l_sub_sql," AND ", l_where CLIPPED ,cl_sql_add_filter("rtbc_t") #ken---add 需求單號：141208-00001 項次：10    #161214-00032#1 add CLIPPED ,cl_sql_add_filter("rtbc_t")
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
				
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt
   FREE header_cnt_pre

   #若超過最大顯示筆數
   IF g_browser_cnt > g_max_browse AND g_error_show = 1 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = '9035'
      LET g_errparam.extend = g_browser_cnt
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF

      LET g_error_show = 0

   DISPLAY g_browser_cnt TO FORMONLY.b_count
   DISPLAY g_browser_cnt TO FORMONLY.h_count

   LET g_wc = p_wc
   #LET g_page_action = ps_page_action          # Keep Action

   IF ps_page_action = "F" OR
      ps_page_action = "P"  OR
      ps_page_action = "N"  OR
      ps_page_action = "L"  THEN
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
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'azz-998'
            LET g_errparam.extend = g_jump
            LET g_errparam.popup = FALSE
            CALL cl_err()

         END IF

      OTHERWISE

   END CASE

   IF g_wc2 <> " 1=1" AND NOT cl_null(g_wc2) THEN
      #LET l_sql_rank = "SELECT UNIQUE rtbcstus,rtbcunit,'',rtbcdocdt,rtbcdocno,rtbc000,rtbc001,'','',RANK() OVER(ORDER BY rtbcdocno ", #ken_mark
     LET l_sql_rank = "SELECT UNIQUE rtbcstus,rtbcsite,'',rtbcunit,'',rtbcdocdt,rtbcdocno,rtbc000,rtbc001,'','',RANK() OVER(ORDER BY rtbcdocno ", #ken---add 加上rtbcsite,rtbcsite_desc 需求單號：141208-00001 項次：10 
     
                       g_order,
                       ") AS RANK ",
                       " FROM rtbc_t ",
                       "  ",
                       "  LEFT JOIN rtbcl_t ON rtbcdocno = rtbcldocno AND rtbcl001 = '",g_lang,"' ",
                       "  LEFT JOIN oofb_t ON oofbent = rtbcent AND rtbc012 = oofb002",
                       "  LEFT JOIN oofc_t ON oofcent = rtbcent AND rtbc012 = oofc002",
                       " WHERE rtbcent = '" ||g_enterprise|| "' AND ", l_wc ," AND ",l_wc2
   ELSE
      #LET l_sql_rank = "SELECT UNIQUE rtbcstus,rtbcunit,'',rtbcdocdt,rtbcdocno,rtbc000,rtbc001,'','',RANK() OVER(ORDER BY rtbcdocno ", #ken_mark
      LET l_sql_rank = "SELECT UNIQUE rtbcstus,rtbcsite,'',rtbcunit,'',rtbcdocdt,rtbcdocno,rtbc000,rtbc001,'','',RANK() OVER(ORDER BY rtbcdocno ", #ken---add 加上rtbcsite,rtbcsite_desc 需求單號：141208-00001 項次：10

                       g_order,
                       ") AS RANK ",
                       " FROM rtbc_t ",
                       "  ",
                       "  LEFT JOIN rtbcl_t ON rtbcdocno = rtbcldocno AND rtbcl001 = '",g_lang,"' ",
                       " WHERE rtbcent = '" ||g_enterprise|| "' AND ", l_wc
   END IF

   LET l_sql_rank = l_sql_rank," AND ", l_where CLIPPED ,cl_sql_add_filter("rtbc_t") #ken---add 需求單號：141208-00001 項次：10   #161214-00032#1 add CLIPPED ,cl_sql_add_filter("rtbc_t")
   #定義翻頁CURSOR
   #LET g_sql= " SELECT rtbcstus,rtbcunit,'',rtbcdocdt,rtbcdocno,rtbc000,rtbc001,'','' FROM (",l_sql_rank,") ", #ken_mark
   LET g_sql= " SELECT rtbcstus,rtbcsite,'',rtbcunit,'',rtbcdocdt,rtbcdocno,rtbc000,rtbc001,'','' FROM (",l_sql_rank,") ", #ken---add 加上rtbsite,rtbcsite_desc 需求單號：141208-00001 項次：10
              "  WHERE RANK >= ", g_pagestart,
              "    AND RANK <  ", (g_pagestart + g_max_browse) ,
              "  ORDER BY ",l_searchcol," ",g_order

   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre

   CALL g_browser.clear()
   LET g_cnt = 1
   #FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_rtbcunit,g_browser[g_cnt].b_rtbcunit_desc, #ken_mark
   FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_rtbcsite,g_browser[g_cnt].b_rtbcsite_desc,g_browser[g_cnt].b_rtbcunit,g_browser[g_cnt].b_rtbcunit_desc, #ken---add 加上rtbcsite,rtbcsite_desc 需求單號：141208-00001 項次：10
       g_browser[g_cnt].b_rtbcdocdt,g_browser[g_cnt].b_rtbcdocno,g_browser[g_cnt].b_rtbc000,g_browser[g_cnt].b_rtbc001,
       g_browser[g_cnt].b_rtbc001_desc,g_browser[g_cnt].b_rtbc001_desc_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      #ken---add---s
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_rtbcsite
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_lang||"'",
          "") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_rtbcsite_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_rtbcsite_desc
      #ken---add---e
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_rtbcunit
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_lang||"'",
          "") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_rtbcunit_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_rtbcunit_desc

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_rtbcdocno
      CALL ap_ref_array2(g_ref_fields,"SELECT rtbcl002 FROM rtbcl_t WHERE rtbclent='"||g_enterprise||"' AND rtbcldocno=? AND rtbcl001='"||g_lang||"'",
          "") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_rtbc001_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_rtbc001_desc

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_rtbcdocno
      CALL ap_ref_array2(g_ref_fields,"SELECT rtbcl003 FROM rtbcl_t WHERE rtbclent='"||g_enterprise||"' AND rtbcldocno=? AND rtbcl001='"||g_lang||"'",
          "") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_rtbc001_desc_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_rtbc001_desc_desc


      #LET g_browser[g_cnt].b_statepic = cl_get_actipic(g_browser[g_cnt].b_statepic) 
      
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"         
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
         WHEN "W"
            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/invalid.png"   
      END CASE
      
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "std-00002"
         LET g_errparam.extend = "Max_Row:"||g_max_rec USING "<<<<<"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH

   CALL g_browser.deleteElement(g_cnt)
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_current_cnt = g_rec_b
   LET g_cnt = 0

   CALL artt100_fetch("")

   FREE browse_pre

   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
   ELSE
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   END IF

END FUNCTION

PRIVATE FUNCTION artt100_construct()
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING
   DEFINE ls_wc          STRING


   CLEAR FORM
   INITIALIZE g_rtbc_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1

   LET g_qryparam.state = "c"

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON rtbcunit,rtbcdocdt,rtbcdocno,rtbc000,rtbc001,rtbcl002,rtbcl003,rtbcl004,
          rtbcstus,rtbc017,rtbc101,rtbc105,rtbc102,rtbc103,rtbc100,rtbc104,rtbc106,rtbc108,rtbc107,rtbc115,rtbc116,
          rtbc109,rtbc110,rtbc111,rtbc112,rtbc113,rtbc114,rtbc120,rtbc121,rtbc122,rtbc123,rtbc124,rtbc125,
          rtbc126,rtbc127,rtbc128,   #160324-00019#3 s983961--add  
          rtbcownid,rtbcowndp,rtbccrtid,rtbccrtdp,rtbccrtdt,rtbcmodid,rtbcmoddt,rtbccnfid,rtbccnfdt,
          rtbc014,rtbc016,rtbc004,rtbc005,rtbc015,rtbc006,rtbc018,rtbc019,rtbc007,rtbc020,rtbc022,rtbc008,
          rtbc010,rtbc011,rtbc013,rtbc023,rtbc024,rtbc025,rtbc026,rtbc021,rtbc150,rtbc151,rtbc152,rtbc153,rtbc154,
          rtbc155,rtbc156,rtbc157,rtbc158,rtbc159,rtbc160,rtbc161,rtbc162,rtbc163,rtbc164,rtbc165,rtbc166,
          rtbc002,rtbc003,rtbc009,rtbc012,rtbcsite,rtbcacti

         BEFORE CONSTRUCT

         AFTER FIELD rtbccrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)

         AFTER FIELD rtbcmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)

         AFTER FIELD rtbccnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)

         #一般欄位
         ON ACTION controlp INFIELD rtbcunit
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            LET g_qryparam.arg2 = '8'
            CALL q_ooed004_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbcunit  #顯示到畫面上
            NEXT FIELD rtbcunit                     #返回原欄位

         BEFORE FIELD rtbcunit

         AFTER FIELD rtbcunit
         
      
         BEFORE FIELD rtbcdocdt

         AFTER FIELD rtbcdocdt 
         
         ON ACTION controlp INFIELD rtbcdocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtbcdocno()
            DISPLAY g_qryparam.return1 TO rtbcdocno
            NEXT FIELD rtbcdocno

         BEFORE FIELD rtbcdocno

         AFTER FIELD rtbcdocno

         BEFORE FIELD rtbc000

         AFTER FIELD rtbc000
         
         ON ACTION controlp INFIELD rtbc001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef304 = 'Y' "
            #CALL q_ooef001_15()            #161024-00025#3 mark
            CALL q_ooef001_24()             #161024-00025#3 add
            DISPLAY g_qryparam.return1 TO rtbc001
            NEXT FIELD rtbc001

         BEFORE FIELD rtbc001

         AFTER FIELD rtbc001

         BEFORE FIELD rtbcl002

         AFTER FIELD rtbcl002

         BEFORE FIELD rtbcl003

         AFTER FIELD rtbcl003

         BEFORE FIELD rtbcl004

         AFTER FIELD rtbcl004

         BEFORE FIELD rtbcstus

         AFTER FIELD rtbcstus

         BEFORE FIELD rtbc017

         AFTER FIELD rtbc017

         ON ACTION controlp INFIELD rtbc017
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE 
#            LET g_qryparam.arg1 = '1'
            #161024-00025#4 -s by 08172
            LET g_qryparam.where = " ooef003='Y'"
            CALL q_ooef001_24()
#            CALL q_ooef001_2()                         #呼叫開窗
            #161024-00025#4 -e by 08172
            DISPLAY g_qryparam.return1 TO rtbc017      #顯示到畫面上
            NEXT FIELD rtbc017                         #返回原欄位

         BEFORE FIELD rtbc101

         AFTER FIELD rtbc101

         BEFORE FIELD rtbc105

         AFTER FIELD rtbc105

         ON ACTION controlp INFIELD rtbc105
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE 
#            LET g_qryparam.arg1 = "F" 
            #161024-00025#1--mark--s
#            LET g_qryparam.where = " ooef304 = 'Y'"
#            CALL q_ooef001()                         #呼叫開窗
            #161024-00025#1--mark--e
            #161024-00025#1--add--s
            IF s_aooi500_setpoint(g_prog,'rtbc105') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtbc105',g_site,'c') 
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef304 = 'Y'"
               CALL q_ooef001()                         #呼叫開窗
            END IF
            #161024-00025#1--add--e
            DISPLAY g_qryparam.return1 TO rtbc105      #顯示到畫面上
            NEXT FIELD rtbc105                         #返回原欄位
            
         BEFORE FIELD rtbc102

         AFTER FIELD rtbc102

         BEFORE FIELD rtbc103

         AFTER FIELD rtbc103

         BEFORE FIELD rtbc100

         AFTER FIELD rtbc100

         ON ACTION controlp INFIELD rtbc104

            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2076"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbc104  #顯示到畫面上
            NEXT FIELD rtbc104                     #返回原欄位

         BEFORE FIELD rtbc104

         AFTER FIELD rtbc104

         ON ACTION controlp INFIELD rtbc106
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.arg1 = 'F'
            #161024-00025#1--mark--s
#            LET g_qryparam.where = " ooef304 = 'Y'"
#            CALL q_ooef001()                           #呼叫開窗
            #161024-00025#1--mark--e
            #161024-00025#1--add--s
            IF s_aooi500_setpoint(g_prog,'rtbc106') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtbc106',g_site,'c') 
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef304 = 'Y'"
               CALL q_ooef001()                         #呼叫開窗
            END IF
            #161024-00025#1--add--e
            DISPLAY g_qryparam.return1 TO rtbc106  #顯示到畫面上
            NEXT FIELD rtbc106                     #返回原欄位

         BEFORE FIELD rtbc106

         AFTER FIELD rtbc106 
         
         ON ACTION controlp INFIELD rtbc108
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "pmaa230 = '1' AND pmaa092 = '1' " #150504-00022#1 Add By Ken 150506
            CALL q_pmaa001_15()
            DISPLAY g_qryparam.return1 TO rtbc108
            NEXT FIELD rtbc108

         BEFORE FIELD rtbc108

         AFTER FIELD rtbc108

         BEFORE FIELD rtbc107

         AFTER FIELD rtbc107
         
         BEFORE FIELD rtbc115

         AFTER FIELD rtbc115
         
         BEFORE FIELD rtbc116

         AFTER FIELD rtbc116
         
         BEFORE FIELD rtbc109

         AFTER FIELD rtbc109

         BEFORE FIELD rtbc110

         AFTER FIELD rtbc110

         BEFORE FIELD rtbc111

         AFTER FIELD rtbc111

         BEFORE FIELD rtbc112

         AFTER FIELD rtbc112

         BEFORE FIELD rtbc113

         AFTER FIELD rtbc113

         BEFORE FIELD rtbc114

         AFTER FIELD rtbc114

         BEFORE FIELD rtbc120

         AFTER FIELD rtbc120

         BEFORE FIELD rtbc121

         AFTER FIELD rtbc121

         BEFORE FIELD rtbc122

         AFTER FIELD rtbc122

         BEFORE FIELD rtbc123

         AFTER FIELD rtbc123

         ON ACTION controlp INFIELD rtbc123
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "inaa010 = 'Y' " 
            CALL q_inaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbc123        #顯示到畫面上
            NEXT FIELD rtbc123                           #返回原欄位
         
         BEFORE FIELD rtbc126

         AFTER FIELD rtbc126

         ON ACTION controlp INFIELD rtbc126
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "inaa010 = 'N' " 
            CALL q_inaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbc126        #顯示到畫面上
            NEXT FIELD rtbc126                           #返回原欄位
        
         BEFORE FIELD rtbc124

         AFTER FIELD rtbc124

         ON ACTION controlp INFIELD rtbc124
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "inaa010 = 'Y' " 
            CALL q_inaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbc124        #顯示到畫面上
            NEXT FIELD rtbc124                           #返回原欄位
         
         BEFORE FIELD rtbc127

         AFTER FIELD rtbc127

         ON ACTION controlp INFIELD rtbc127
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "inaa010 = 'N' " 
            CALL q_inaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbc127        #顯示到畫面上
            NEXT FIELD rtbc127                           #返回原欄位
         
         BEFORE FIELD rtbc125

         AFTER FIELD rtbc125

         ON ACTION controlp INFIELD rtbc125
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "inaa010 = 'Y' " 
            CALL q_inaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbc125        #顯示到畫面上
            NEXT FIELD rtbc125                           #返回原欄位
            
         #160324-00019#3 s983961--add(s)

         BEFORE FIELD rtbc128

         AFTER FIELD rtbc128

         ON ACTION controlp INFIELD rtbc128
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "inaa010 = 'N' " 
            CALL q_inaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbc128        #顯示到畫面上
            NEXT FIELD rtbc128                           #返回原欄位
         #160324-00019#3 s983961--add(e)    

         ON ACTION controlp INFIELD rtbcownid
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbcownid  #顯示到畫面上
            NEXT FIELD rtbcownid                     #返回原欄位

         BEFORE FIELD rtbcownid

         AFTER FIELD rtbcownid

         ON ACTION controlp INFIELD rtbcowndp
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbcowndp  #顯示到畫面上
            NEXT FIELD rtbcowndp                     #返回原欄位

         BEFORE FIELD rtbcowndp

         AFTER FIELD rtbcowndp

         ON ACTION controlp INFIELD rtbccrtid
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbccrtid  #顯示到畫面上
            NEXT FIELD rtbccrtid                     #返回原欄位

         BEFORE FIELD rtbccrtid

         AFTER FIELD rtbccrtid

         ON ACTION controlp INFIELD rtbccrtdp
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbccrtdp  #顯示到畫面上
            NEXT FIELD rtbccrtdp                     #返回原欄位

         BEFORE FIELD rtbccrtdp

         AFTER FIELD rtbccrtdp

         BEFORE FIELD rtbccrtdt

         ON ACTION controlp INFIELD rtbcmodid
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbcmodid  #顯示到畫面上
            NEXT FIELD rtbcmodid                     #返回原欄位

         BEFORE FIELD rtbcmodid

         AFTER FIELD rtbcmodid

         BEFORE FIELD rtbcmoddt

         ON ACTION controlp INFIELD rtbccnfid
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbccnfid  #顯示到畫面上
            NEXT FIELD rtbccnfid                     #返回原欄位

         BEFORE FIELD rtbccnfid

         AFTER FIELD rtbccnfid

         BEFORE FIELD rtbccnfdt

         ON ACTION controlp INFIELD rtbc014
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '10'
            CALL q_ooal002_0()
            DISPLAY g_qryparam.return1 TO rtbc014  #顯示到畫面上
            NEXT FIELD rtbc014                     #返回原欄位

         BEFORE FIELD rtbc014

         AFTER FIELD rtbc014
         
         ON ACTION controlp INFIELD rtbc016
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbc016  #顯示到畫面上
            NEXT FIELD rtbc016                     #返回原欄位

         BEFORE FIELD rtbc016

         AFTER FIELD rtbc016

         ON ACTION controlp INFIELD rtbc004
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '3'
            CALL q_ooal002_0()
            DISPLAY g_qryparam.return1 TO rtbc004  #顯示到畫面上
            NEXT FIELD rtbc004                     #返回原欄位

         BEFORE FIELD rtbc004

         AFTER FIELD rtbc004

         BEFORE FIELD rtbc005

         AFTER FIELD rtbc005

         ON ACTION controlp INFIELD rtbc015
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooal002_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbc015  #顯示到畫面上
            NEXT FIELD rtbc015                     #返回原欄位

         BEFORE FIELD rtbc015

         AFTER FIELD rtbc015

         ON ACTION controlp INFIELD rtbc006
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocg001()
            #CALL q_oocg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbc006  #顯示到畫面上
            NEXT FIELD rtbc006                     #返回原欄位

         BEFORE FIELD rtbc006

         AFTER FIELD rtbc006

         ON ACTION controlp INFIELD rtbc018
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_gzot001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbc018  #顯示到畫面上
            NEXT FIELD rtbc018                     #返回原欄位

         BEFORE FIELD rtbc018

         AFTER FIELD rtbc018

         ON ACTION controlp INFIELD rtbc019
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooal002_11()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbc019  #顯示到畫面上
            NEXT FIELD rtbc019                     #返回原欄位

         BEFORE FIELD rtbc019

         AFTER FIELD rtbc019

         BEFORE FIELD rtbc007

         AFTER FIELD rtbc007

         BEFORE FIELD rtbc020

         AFTER FIELD rtbc020

         BEFORE FIELD rtbc022

         AFTER FIELD rtbc022


         ON ACTION controlp INFIELD rtbc008
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooal002_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbc008  #顯示到畫面上
            NEXT FIELD rtbc008                     #返回原欄位

         BEFORE FIELD rtbc008

         AFTER FIELD rtbc008

         BEFORE FIELD rtbc010

         AFTER FIELD rtbc010

         BEFORE FIELD rtbc011

         AFTER FIELD rtbc011

         BEFORE FIELD rtbc013

         AFTER FIELD rtbc013

         BEFORE FIELD rtbc023

         AFTER FIELD rtbc023

         ON ACTION controlp INFIELD rtbc024
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160913-00034#5 -S
            #CALL q_pmaa001()                           #呼叫開窗            
            LET g_qryparam.arg1 = "('1','2','3')"            
            CALL q_pmaa001_1()                          #呼叫開窗
            #160913-00034#5 -E
            DISPLAY g_qryparam.return1 TO rtbc024  #顯示到畫面上
            NEXT FIELD rtbc024                     #返回原欄位

         BEFORE FIELD rtbc024

         AFTER FIELD rtbc024

         BEFORE FIELD rtbc025

         AFTER FIELD rtbc025
         
         #dongsz--add--str---
         ON ACTION controlp INFIELD rtbc026
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_nmas002_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbc026  #顯示到畫面上
            NEXT FIELD rtbc026                     #返回原欄位

         BEFORE FIELD rtbc026

         AFTER FIELD rtbc026
         #dongsz--add--end---

         BEFORE FIELD rtbc021

         AFTER FIELD rtbc021


         ON ACTION controlp INFIELD rtbc150
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2077'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbc150  #顯示到畫面上
            NEXT FIELD rtbc150                     #返回原欄位

         BEFORE FIELD rtbc150

         AFTER FIELD rtbc150

         ON ACTION controlp INFIELD rtbc151
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.arg1 = '2078'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbc151  #顯示到畫面上
            NEXT FIELD rtbc151                     #返回原欄位

         BEFORE FIELD rtbc151

         AFTER FIELD rtbc151

         ON ACTION controlp INFIELD rtbc152
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.arg1 = '2079'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbc152  #顯示到畫面上
            NEXT FIELD rtbc152                     #返回原欄位

         BEFORE FIELD rtbc152

         AFTER FIELD rtbc152

         ON ACTION controlp INFIELD rtbc153
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.arg1 = '2080'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbc153  #顯示到畫面上
            NEXT FIELD rtbc153                     #返回原欄位

         BEFORE FIELD rtbc153

         AFTER FIELD rtbc153

         ON ACTION controlp INFIELD rtbc154
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.arg1 = '2081'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbc154  #顯示到畫面上
            NEXT FIELD rtbc154                     #返回原欄位

         BEFORE FIELD rtbc154

         AFTER FIELD rtbc154

         ON ACTION controlp INFIELD rtbc155
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.arg1 = '2082'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbc155  #顯示到畫面上
            NEXT FIELD rtbc155                     #返回原欄位

         BEFORE FIELD rtbc155

         AFTER FIELD rtbc155

         ON ACTION controlp INFIELD rtbc156
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   CALL q_dbac001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbc156  #顯示到畫面上
            
         BEFORE FIELD rtbc156

         AFTER FIELD rtbc156

         ON ACTION controlp INFIELD rtbc157
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.arg1 = '2084'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbc157  #顯示到畫面上
            NEXT FIELD rtbc157                     #返回原欄位

         BEFORE FIELD rtbc157

         AFTER FIELD rtbc157

         ON ACTION controlp INFIELD rtbc158
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.arg1 = '2085'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbc158  #顯示到畫面上
            NEXT FIELD rtbc158                     #返回原欄位

         BEFORE FIELD rtbc158

         AFTER FIELD rtbc158

         ON ACTION controlp INFIELD rtbc159
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.arg1 = '2086'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbc159  #顯示到畫面上
            NEXT FIELD rtbc159                     #返回原欄位

         BEFORE FIELD rtbc159

         AFTER FIELD rtbc159

         ON ACTION controlp INFIELD rtbc160
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.arg1 = '2087'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbc160  #顯示到畫面上
            NEXT FIELD rtbc160                     #返回原欄位

         BEFORE FIELD rtbc160

         AFTER FIELD rtbc160

         ON ACTION controlp INFIELD rtbc161
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.arg1 = '2088'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbc161  #顯示到畫面上
            NEXT FIELD rtbc161                     #返回原欄位

         BEFORE FIELD rtbc161

         AFTER FIELD rtbc161

         ON ACTION controlp INFIELD rtbc162
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.arg1 = '2089'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbc162  #顯示到畫面上
            NEXT FIELD rtbc162                     #返回原欄位

         BEFORE FIELD rtbc162

         AFTER FIELD rtbc162

         ON ACTION controlp INFIELD rtbc163
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.arg1 = '2090'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbc163  #顯示到畫面上
            NEXT FIELD rtbc163                     #返回原欄位
            
         BEFORE FIELD rtbc163

         AFTER FIELD rtbc163

         ON ACTION controlp INFIELD rtbc164
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.arg1 = '2091'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbc164  #顯示到畫面上
            NEXT FIELD rtbc164                     #返回原欄位

         BEFORE FIELD rtbc164

         AFTER FIELD rtbc164

         ON ACTION controlp INFIELD rtbc165
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.arg1 = '2092'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbc165  #顯示到畫面上
            NEXT FIELD rtbc165                     #返回原欄位

         BEFORE FIELD rtbc165

         AFTER FIELD rtbc165

         ON ACTION controlp INFIELD rtbc166
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.arg1 = '2093'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbc166  #顯示到畫面上
            NEXT FIELD rtbc166                     #返回原欄位

         BEFORE FIELD rtbc166

         AFTER FIELD rtbc166

         BEFORE FIELD rtbc002

         AFTER FIELD rtbc002

         BEFORE FIELD rtbc003

         AFTER FIELD rtbc003

         BEFORE FIELD rtbc009

         AFTER FIELD rtbc009

         BEFORE FIELD rtbc012

         AFTER FIELD rtbc012

         #ken---add---s 需求單號：141208-00001 項次：10
         #一般欄位
         ON ACTION controlp INFIELD rtbcsite
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtbcsite',g_site,'c')   #150308-00001#5  By benson add 'c'
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbcsite  #顯示到畫面上
            NEXT FIELD rtbcsite                     #返回原欄位
         #ken---add---e
         
         BEFORE FIELD rtbcsite

         AFTER FIELD rtbcsite

      END CONSTRUCT

      SUBDIALOG aoo_aooi350_01.aooi350_01_construct
      SUBDIALOG aoo_aooi350_02.aooi350_02_construct

      BEFORE DIALOG
         CALL cl_qbe_init()

      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG

      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc

      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG

   LET g_wc2= ''
   IF g_wc2_i35001 <> " 1=1" THEN      
      LET g_wc2 = g_wc2_i35001
   END IF
   
   IF g_wc2_i35002 <> " 1=1" THEN
      IF cl_null(g_wc2) THEN
         LET g_wc2 = g_wc2_i35002
      ELSE
         LET g_wc2 = g_wc2 ," AND ", g_wc2_i35002
      END IF
   END IF

   #LET g_wc = g_wc CLIPPED,cl_get_extra_cond("", "")

END FUNCTION

PRIVATE FUNCTION artt100_filter()
   LET INT_FLAG = 0

   LET g_qryparam.state = 'c'

   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc

   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')

   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單頭
      CONSTRUCT g_wc_filter ON rtbcunit,rtbcdocdt,rtbcdocno,rtbc000
                          FROM s_browse[1].b_rtbcunit,s_browse[1].b_rtbcdocdt,s_browse[1].b_rtbcdocno,
                              s_browse[1].b_rtbc000

         BEFORE CONSTRUCT
               DISPLAY artt100_filter_parser('rtbcunit') TO s_browse[1].b_rtbcunit
            DISPLAY artt100_filter_parser('rtbcdocdt') TO s_browse[1].b_rtbcdocdt
            DISPLAY artt100_filter_parser('rtbcdocno') TO s_browse[1].b_rtbcdocno
            DISPLAY artt100_filter_parser('rtbc000') TO s_browse[1].b_rtbc000

      END CONSTRUCT


      BEFORE DIALOG

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

END FUNCTION

PRIVATE FUNCTION artt100_filter_parser(ps_field)
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

PRIVATE FUNCTION artt100_query()
   DEFINE ls_wc STRING


   LET INT_FLAG = 0
   LET ls_wc = g_wc

   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF

   CALL g_browser.clear()

   IF g_worksheet_hidden THEN  #browser panel折疊
      CALL gfrm_curr.setElementHidden("worksheet_vbox",0)
      CALL gfrm_curr.setElementImage("worksheethidden","worksheethidden-24.png")
      LET g_worksheet_hidden = 0
   END IF
   IF g_header_hidden THEN    #單頭折疊
      CALL gfrm_curr.setElementHidden("vb_master",0)
      CALL gfrm_curr.setElementImage("controls","headerhidden-24")
      LET g_header_hidden = 0
   END IF

   INITIALIZE g_rtbc_m.* TO NULL
   ERROR ""

   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL artt100_construct()

   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL artt100_browser_fill(g_wc,"F")
      CALL artt100_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF

   LET g_error_show = 1
   CALL artt100_browser_fill(g_wc,"F")   # 移到第一頁

   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||")")

   #備份搜尋條件
   LET ls_wc = g_wc

   IF g_browser.getLength() = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "-100"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

   ELSE
      CALL artt100_fetch("F")
   END IF

   LET g_wc_filter = ""

END FUNCTION

PRIVATE FUNCTION artt100_fetch(p_fl)
   DEFINE p_fl       LIKE type_t.chr1
   DEFINE ls_msg     STRING


   CASE p_fl
      WHEN "F" LET g_current_idx = 1
      WHEN "P"
         IF g_current_idx > 1 THEN
            LET g_current_idx = g_current_idx - 1
         END IF
      WHEN "N"
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF
      WHEN "L"
         LET g_current_idx = g_header_cnt
      WHEN "/"
         IF (NOT g_no_ask) THEN
            CALL cl_getmsg("fetch", g_lang) RETURNING ls_msg
            LET INT_FLAG = 0

            PROMPT ls_msg CLIPPED,": " FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl"
            END PROMPT

            IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE
            END IF
         END IF
         IF g_jump > 0 THEN
            LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE
   END CASE

   LET g_browser_cnt = g_browser.getLength()

   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index        #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.b_count        #總筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index        #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count        #總筆數
   CALL ui.Interface.refresh()

   #單頭筆數顯示
   #DISPLAY g_browser_idx TO FORMONLY.idx            #當下筆數
   #DISPLAY g_browser_cnt TO FORMONLY.cnt            #總筆數



   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF

   # 設定browse索引
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx)

   CALL cl_navigator_setting(g_browser_idx, g_current_cnt)

   #代表沒有資料, 無需做後續資料撈取之動作
   IF g_current_idx = 0 THEN
      RETURN
   END IF

   LET g_rtbc_m.rtbcdocno = g_browser[g_current_idx].b_rtbcdocno


   #重讀DB,因TEMP有不被更新特性
    SELECT UNIQUE rtbcunit,rtbcdocdt,rtbcdocno,rtbc000,rtbc001,rtbcstus,rtbc017,rtbc101,rtbc105,rtbc102,
        rtbc103,rtbc100,rtbc104,rtbc106,rtbc108,rtbc107,rtbc115,rtbc116,rtbc109,rtbc110,rtbc111,rtbc112,rtbc113,
        rtbc114,rtbc120,rtbc121,rtbc122,rtbc123,rtbc124,rtbc125,
        rtbc126,rtbc127,rtbc128,   #160324-00019#3 s983961--add   
        rtbcownid,rtbcowndp,rtbccrtid,rtbccrtdp,
        rtbccrtdt,rtbcmodid,rtbcmoddt,rtbccnfid,rtbccnfdt,rtbc014,rtbc016,rtbc004,rtbc005,rtbc015,rtbc006,
        rtbc018,rtbc019,rtbc007,rtbc020,rtbc022,rtbc008,rtbc010,rtbc011,rtbc013,rtbc023,rtbc024,rtbc025,rtbc026,
        rtbc021,rtbc150,rtbc151,rtbc152,rtbc153,rtbc154,rtbc155,rtbc156,rtbc157,rtbc158,rtbc159,rtbc160,
        rtbc161,rtbc162,rtbc163,rtbc164,rtbc165,rtbc166,rtbc002,rtbc003,rtbc009,rtbc012,rtbcsite,rtbcacti
 INTO g_rtbc_m.rtbcunit,g_rtbc_m.rtbcdocdt,g_rtbc_m.rtbcdocno,g_rtbc_m.rtbc000,g_rtbc_m.rtbc001,g_rtbc_m.rtbcstus,
     g_rtbc_m.rtbc017,g_rtbc_m.rtbc101,g_rtbc_m.rtbc105,g_rtbc_m.rtbc102,g_rtbc_m.rtbc103,g_rtbc_m.rtbc100,
     g_rtbc_m.rtbc104,g_rtbc_m.rtbc106,g_rtbc_m.rtbc108,g_rtbc_m.rtbc107,g_rtbc_m.rtbc115,g_rtbc_m.rtbc116,g_rtbc_m.rtbc109,
     g_rtbc_m.rtbc110,g_rtbc_m.rtbc111,g_rtbc_m.rtbc112,g_rtbc_m.rtbc113,g_rtbc_m.rtbc114,g_rtbc_m.rtbc120,
     g_rtbc_m.rtbc121,g_rtbc_m.rtbc122,g_rtbc_m.rtbc123,g_rtbc_m.rtbc124,g_rtbc_m.rtbc125,
     g_rtbc_m.rtbc126,g_rtbc_m.rtbc127,g_rtbc_m.rtbc128,   #160324-00019#3 s983961--add 
     g_rtbc_m.rtbcownid,
     g_rtbc_m.rtbcowndp,g_rtbc_m.rtbccrtid,g_rtbc_m.rtbccrtdp,g_rtbc_m.rtbccrtdt,g_rtbc_m.rtbcmodid,
     g_rtbc_m.rtbcmoddt,g_rtbc_m.rtbccnfid,g_rtbc_m.rtbccnfdt,g_rtbc_m.rtbc014,g_rtbc_m.rtbc016,g_rtbc_m.rtbc004,
     g_rtbc_m.rtbc005,g_rtbc_m.rtbc015,g_rtbc_m.rtbc006,g_rtbc_m.rtbc018,g_rtbc_m.rtbc019,g_rtbc_m.rtbc007,
     g_rtbc_m.rtbc020,g_rtbc_m.rtbc022,g_rtbc_m.rtbc008,g_rtbc_m.rtbc010,g_rtbc_m.rtbc011,g_rtbc_m.rtbc013,
     g_rtbc_m.rtbc023,g_rtbc_m.rtbc024,g_rtbc_m.rtbc025,g_rtbc_m.rtbc026,g_rtbc_m.rtbc021,g_rtbc_m.rtbc150,g_rtbc_m.rtbc151,
     g_rtbc_m.rtbc152,g_rtbc_m.rtbc153,g_rtbc_m.rtbc154,g_rtbc_m.rtbc155,g_rtbc_m.rtbc156,g_rtbc_m.rtbc157,
     g_rtbc_m.rtbc158,g_rtbc_m.rtbc159,g_rtbc_m.rtbc160,g_rtbc_m.rtbc161,g_rtbc_m.rtbc162,g_rtbc_m.rtbc163,
     g_rtbc_m.rtbc164,g_rtbc_m.rtbc165,g_rtbc_m.rtbc166,g_rtbc_m.rtbc002,g_rtbc_m.rtbc003,g_rtbc_m.rtbc009,
     g_rtbc_m.rtbc012,g_rtbc_m.rtbcsite,g_rtbc_m.rtbcacti
 FROM rtbc_t
 WHERE rtbcent = g_enterprise AND rtbcdocno = g_rtbc_m.rtbcdocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "rtbc_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()

      INITIALIZE g_rtbc_m.* TO NULL
      RETURN
   END IF
   
   #IF g_rtbc_m.rtbcstus = 'N' THEN 
   IF g_rtbc_m.rtbcstus MATCHES "[NDR]" THEN 
      CALL cl_set_act_visible("modify,delete,modify_detail",TRUE)
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)
   END IF
   
   IF g_rtbc_m.rtbcstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF

   IF NOT cl_bpm_chk() THEN    #此單據不需提交至BPM，則隱藏按鈕 
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
   
   #重新顯示
   CALL artt100_show()

END FUNCTION

PRIVATE FUNCTION artt100_insert()
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_doctype     LIKE rtai_t.rtai004
   DEFINE l_insert      LIKE type_t.num5 #ken---add

   CLEAR FORM #清畫面欄位內容

   INITIALIZE g_rtbc_m.* LIKE rtbc_t.*             #DEFAULT 設定
   LET g_rtbcdocno_t = NULL


   CALL s_transaction_begin()

   WHILE TRUE
      #六階樹狀給值


      #公用欄位給值
      #此段落由子樣板a14產生
      LET g_rtbc_m.rtbcownid = g_user
      LET g_rtbc_m.rtbcowndp = g_dept
      LET g_rtbc_m.rtbccrtid = g_user
      LET g_rtbc_m.rtbccrtdp = g_dept
      LET g_rtbc_m.rtbccrtdt = cl_get_current()
      LET g_rtbc_m.rtbcmodid = ""
      LET g_rtbc_m.rtbcmoddt = ""
      #LET g_rtbc_m.rtbcstus = ""



      #append欄位給值


      #一般欄位給值

      LET g_rtbc_m.rtbcstus = 'N'              #預設未確認
      LET g_rtbc_m.rtbcdocdt = g_today         #預設系統日期

      #預設制定組織
      #LET g_rtbc_m.rtbcunit = g_site
      #CALL artt100_rtbcunit_ref()
      #LET g_rtbc_m.rtbcsite = g_site
      #CALL artt100_get_ooef004()  
      #ken---add---str 需求單號：141208-00001 項次：10
      LET g_site_flag = FALSE
      CALL s_aooi500_default(g_prog,'rtbcsite',g_rtbc_m.rtbcsite)
         RETURNING l_insert,g_rtbc_m.rtbcsite
      IF NOT l_insert THEN
         RETURN
      END IF
      LET g_rtbc_m.rtbcunit = g_rtbc_m.rtbcsite
      CALL artt100_rtbcunit_ref()
      CALL artt100_rtbcsite_ref()
      #ken---add---e
      #預設單據的單別
      LET r_success = ''
      LET r_doctype = ''
      CALL s_arti200_get_def_doc_type(g_rtbc_m.rtbcunit,g_prog,'1')
           RETURNING r_success,r_doctype
      LET g_rtbc_m.rtbcdocno = r_doctype

      LET g_rtbc_m.rtbc000 = 'I'
      LET g_rtbc_m.rtbc101 = '4'
      LET g_rtbc_m.rtbc102 = '1'
      LET g_rtbc_m.rtbc103 = '1'
      LET g_rtbc_m.rtbc100 = '1'
      LET g_rtbc_m.rtbc115 = 'Y'
      LET g_rtbc_m.rtbc010 = '1'
      LET g_rtbc_m.rtbc011 = '0'
      LET g_rtbc_m.rtbc023 = '1'
      #先給預設語言別 简体    # add by geza 20150506
      #LET g_rtbc_m.rtbc116 = "zh_CN"     #160303-00028#24 dongsz mark
      LET g_rtbc_m.rtbc116 = g_dlang      #160303-00028#24 dongsz add   #默认当前语言别
      
      LET g_rtbc_m.rtbc003 = 'N'    #法人預設為N
      LET g_rtbc_m.rtbcacti = 'Y'
      LET g_rtbc_m_t.* = g_rtbc_m.*
      LET g_rtbc_m_o.* = g_rtbc_m.*
      INITIALIZE g_pmaa027_d TO NULL
      CALL aooi350_01_clear_detail()
      CALL aooi350_02_clear_detail()

      CALL artt100_input("a")

      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_rtbc_m.* = g_rtbc_m_t.*
         CALL artt100_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT WHILE
      END IF

      LET g_rec_b = 0
      EXIT WHILE
   END WHILE

   LET g_rtbcdocno_t = g_rtbc_m.rtbcdocno


   LET g_state = "Y"

   LET g_wc = g_wc,
              " OR ( rtbcent = '" ||g_enterprise|| "' AND",
              " rtbcdocno = '", g_rtbc_m.rtbcdocno CLIPPED, "' "

              , ") "

END FUNCTION

PRIVATE FUNCTION artt100_modify()
   IF g_rtbc_m.rtbcdocno IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF
   
   #檢查是否允許此動作
   IF NOT artt100_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF

    SELECT UNIQUE rtbcunit,rtbcdocdt,rtbcdocno,rtbc000,rtbc001,rtbcstus,rtbc017,rtbc101,rtbc105,rtbc102,
        rtbc103,rtbc100,rtbc104,rtbc106,rtbc108,rtbc107,rtbc115,rtbc116,rtbc109,rtbc110,rtbc111,rtbc112,rtbc113,
        rtbc114,rtbc120,rtbc121,rtbc122,rtbc123,rtbc124,rtbc125,
        rtbc126,rtbc127,rtbc128,   #160324-00019#3 s983961--add   
        rtbcownid,rtbcowndp,rtbccrtid,rtbccrtdp,
        rtbccrtdt,rtbcmodid,rtbcmoddt,rtbccnfid,rtbccnfdt,rtbc014,rtbc016,rtbc004,rtbc005,rtbc015,rtbc006,
        rtbc018,rtbc019,rtbc007,rtbc020,rtbc022,rtbc008,rtbc010,rtbc011,rtbc013,rtbc023,rtbc024,rtbc025,rtbc026,
        rtbc021,rtbc150,rtbc151,rtbc152,rtbc153,rtbc154,rtbc155,rtbc156,rtbc157,rtbc158,rtbc159,rtbc160,
        rtbc161,rtbc162,rtbc163,rtbc164,rtbc165,rtbc166,rtbc002,rtbc003,rtbc009,rtbc012,rtbcsite
 INTO g_rtbc_m.rtbcunit,g_rtbc_m.rtbcdocdt,g_rtbc_m.rtbcdocno,g_rtbc_m.rtbc000,g_rtbc_m.rtbc001,g_rtbc_m.rtbcstus,
     g_rtbc_m.rtbc017,g_rtbc_m.rtbc101,g_rtbc_m.rtbc105,g_rtbc_m.rtbc102,g_rtbc_m.rtbc103,g_rtbc_m.rtbc100,
     g_rtbc_m.rtbc104,g_rtbc_m.rtbc106,g_rtbc_m.rtbc108,g_rtbc_m.rtbc107,g_rtbc_m.rtbc115,g_rtbc_m.rtbc116,g_rtbc_m.rtbc109,
     g_rtbc_m.rtbc110,g_rtbc_m.rtbc111,g_rtbc_m.rtbc112,g_rtbc_m.rtbc113,g_rtbc_m.rtbc114,g_rtbc_m.rtbc120,
     g_rtbc_m.rtbc121,g_rtbc_m.rtbc122,g_rtbc_m.rtbc123,g_rtbc_m.rtbc124,g_rtbc_m.rtbc125,
     g_rtbc_m.rtbc126,g_rtbc_m.rtbc127,g_rtbc_m.rtbc128,   #160324-00019#3 s983961--add 
     g_rtbc_m.rtbcownid,
     g_rtbc_m.rtbcowndp,g_rtbc_m.rtbccrtid,g_rtbc_m.rtbccrtdp,g_rtbc_m.rtbccrtdt,g_rtbc_m.rtbcmodid,
     g_rtbc_m.rtbcmoddt,g_rtbc_m.rtbccnfid,g_rtbc_m.rtbccnfdt,g_rtbc_m.rtbc014,g_rtbc_m.rtbc016,g_rtbc_m.rtbc004,
     g_rtbc_m.rtbc005,g_rtbc_m.rtbc015,g_rtbc_m.rtbc006,g_rtbc_m.rtbc018,g_rtbc_m.rtbc019,g_rtbc_m.rtbc007,
     g_rtbc_m.rtbc020,g_rtbc_m.rtbc022,g_rtbc_m.rtbc008,g_rtbc_m.rtbc010,g_rtbc_m.rtbc011,g_rtbc_m.rtbc013,
     g_rtbc_m.rtbc023,g_rtbc_m.rtbc024,g_rtbc_m.rtbc025,g_rtbc_m.rtbc026,g_rtbc_m.rtbc021,g_rtbc_m.rtbc150,g_rtbc_m.rtbc151,
     g_rtbc_m.rtbc152,g_rtbc_m.rtbc153,g_rtbc_m.rtbc154,g_rtbc_m.rtbc155,g_rtbc_m.rtbc156,g_rtbc_m.rtbc157,
     g_rtbc_m.rtbc158,g_rtbc_m.rtbc159,g_rtbc_m.rtbc160,g_rtbc_m.rtbc161,g_rtbc_m.rtbc162,g_rtbc_m.rtbc163,
     g_rtbc_m.rtbc164,g_rtbc_m.rtbc165,g_rtbc_m.rtbc166,g_rtbc_m.rtbc002,g_rtbc_m.rtbc003,g_rtbc_m.rtbc009,
     g_rtbc_m.rtbc012,g_rtbc_m.rtbcsite
 FROM rtbc_t
 WHERE rtbcent = g_enterprise AND rtbcdocno = g_rtbc_m.rtbcdocno

   ERROR ""

   LET g_rtbcdocno_t = g_rtbc_m.rtbcdocno


   CALL s_transaction_begin()

   OPEN artt100_cl USING g_enterprise,g_rtbc_m.rtbcdocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN artt100_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE artt100_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #鎖住將被更改或取消的資料
   FETCH artt100_cl INTO g_rtbc_m.rtbcunit,g_rtbc_m.rtbcunit_desc,g_rtbc_m.rtbcdocdt,g_rtbc_m.rtbcdocno,
       g_rtbc_m.rtbc000,g_rtbc_m.rtbc001,g_rtbc_m.rtbcl002,g_rtbc_m.rtbcl003,g_rtbc_m.rtbcl004,g_rtbc_m.rtbcstus,
       g_rtbc_m.rtbc017,g_rtbc_m.rtbc017_desc,g_rtbc_m.rtbc101,g_rtbc_m.rtbc105,g_rtbc_m.rtbc105_desc,
       g_rtbc_m.rtbc102,g_rtbc_m.rtbc103,g_rtbc_m.rtbc100,g_rtbc_m.rtbc104,g_rtbc_m.rtbc104_desc,g_rtbc_m.rtbc106,
       g_rtbc_m.rtbc106_desc,g_rtbc_m.rtbc108,g_rtbc_m.rtbc108_desc,g_rtbc_m.rtbc107,g_rtbc_m.rtbc115,g_rtbc_m.rtbc116,
       g_rtbc_m.rtbc109,g_rtbc_m.rtbc110,g_rtbc_m.rtbc111,g_rtbc_m.rtbc112,g_rtbc_m.rtbc113,g_rtbc_m.rtbc114,
       g_rtbc_m.rtbc120,g_rtbc_m.rtbc121,g_rtbc_m.rtbc122,g_rtbc_m.rtbc123,g_rtbc_m.rtbc123_desc,g_rtbc_m.rtbc124,
       g_rtbc_m.rtbc124_desc,g_rtbc_m.rtbc125,g_rtbc_m.rtbc125_desc,
       g_rtbc_m.rtbc126,g_rtbc_m.rtbc126_desc,g_rtbc_m.rtbc127,g_rtbc_m.rtbc127_desc,g_rtbc_m.rtbc128,g_rtbc_m.rtbc128_desc,   #160324-00019#3 s983961--add                  
       g_rtbc_m.rtbcownid,g_rtbc_m.rtbcownid_desc,
       g_rtbc_m.rtbcowndp,g_rtbc_m.rtbcowndp_desc,g_rtbc_m.rtbccrtid,g_rtbc_m.rtbccrtid_desc,g_rtbc_m.rtbccrtdp,
       g_rtbc_m.rtbccrtdp_desc,g_rtbc_m.rtbccrtdt,g_rtbc_m.rtbcmodid,g_rtbc_m.rtbcmodid_desc,g_rtbc_m.rtbcmoddt,
       g_rtbc_m.rtbccnfid,g_rtbc_m.rtbccnfid_desc,g_rtbc_m.rtbccnfdt,g_rtbc_m.rtbc014,g_rtbc_m.rtbc014_desc,
       g_rtbc_m.rtbc016,g_rtbc_m.rtbc016_desc,g_rtbc_m.rtbc004,g_rtbc_m.rtbc004_desc,g_rtbc_m.rtbc005,
       g_rtbc_m.rtbc015,g_rtbc_m.rtbc015_desc,g_rtbc_m.rtbc006,g_rtbc_m.rtbc006_desc,g_rtbc_m.rtbc018,
       g_rtbc_m.rtbc018_desc,g_rtbc_m.rtbc019,g_rtbc_m.rtbc019_desc,g_rtbc_m.rtbc007,g_rtbc_m.rtbc020,
       g_rtbc_m.rtbc022,g_rtbc_m.rtbc008,g_rtbc_m.rtbc008_desc,g_rtbc_m.rtbc010,g_rtbc_m.rtbc011,g_rtbc_m.rtbc013,
       g_rtbc_m.rtbc023,g_rtbc_m.rtbc024,g_rtbc_m.rtbc024_desc,g_rtbc_m.rtbc025,g_rtbc_m.rtbc026,g_rtbc_m.rtbc026_desc,g_rtbc_m.rtbc021,g_rtbc_m.rtbc150,
       g_rtbc_m.rtbc150_desc,g_rtbc_m.rtbc151,g_rtbc_m.rtbc151_desc,g_rtbc_m.rtbc152,g_rtbc_m.rtbc152_desc,
       g_rtbc_m.rtbc153,g_rtbc_m.rtbc153_desc,g_rtbc_m.rtbc154,g_rtbc_m.rtbc154_desc,g_rtbc_m.rtbc155,
       g_rtbc_m.rtbc155_desc,g_rtbc_m.rtbc156,g_rtbc_m.rtbc156_desc,g_rtbc_m.rtbc157,g_rtbc_m.rtbc157_desc,
       g_rtbc_m.rtbc158,g_rtbc_m.rtbc158_desc,g_rtbc_m.rtbc159,g_rtbc_m.rtbc159_desc,g_rtbc_m.rtbc160,
       g_rtbc_m.rtbc160_desc,g_rtbc_m.rtbc161,g_rtbc_m.rtbc161_desc,g_rtbc_m.rtbc162,g_rtbc_m.rtbc162_desc,
       g_rtbc_m.rtbc163,g_rtbc_m.rtbc163_desc,g_rtbc_m.rtbc164,g_rtbc_m.rtbc164_desc,g_rtbc_m.rtbc165,
       g_rtbc_m.rtbc165_desc,g_rtbc_m.rtbc166,g_rtbc_m.rtbc166_desc,g_rtbc_m.rtbc002,g_rtbc_m.rtbc003,
       g_rtbc_m.rtbc009,g_rtbc_m.rtbc012,g_rtbc_m.rtbcsite,g_rtbc_m.rtbcacti

   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "rtbc_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()

      CLOSE artt100_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF



   CALL artt100_show()

   WHILE TRUE
      LET g_rtbc_m.rtbcdocno = g_rtbcdocno_t


      #寫入修改者/修改日期資訊
      LET g_rtbc_m.rtbcmodid = g_user
      LET g_rtbc_m.rtbcmoddt = cl_get_current()

      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」 
      IF g_rtbc_m.rtbcstus MATCHES "[DR]" THEN
         LET g_rtbc_m.rtbcstus = 'N'
      END IF 

      CALL artt100_input("u")     #欄位更改


      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_rtbc_m.* = g_rtbc_m_t.*
         CALL artt100_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT WHILE
      END IF

      EXIT WHILE

   END WHILE

   #修改歷程記錄
   IF NOT cl_log_modified_record(g_rtbc_m.rtbcdocno,g_site) THEN
      CALL s_transaction_end('N','0')
   END IF

   CLOSE artt100_cl
   CALL s_transaction_end('Y','0')

   #流程通知預埋點-U
   CALL cl_flow_notify(g_rtbc_m.rtbcdocno,"U")

   LET g_worksheet_hidden = 0

END FUNCTION

PRIVATE FUNCTION artt100_input(p_cmd)
   DEFINE p_cmd           LIKE type_t.chr1
   DEFINE l_ac_t          LIKE type_t.num5        #未取消的ARRAY CNT
   DEFINE l_n             LIKE type_t.num5        #檢查重複用
   DEFINE l_cnt           LIKE type_t.num5        #檢查重複用
   DEFINE l_lock_sw       LIKE type_t.chr1        #單身鎖住否
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   DEFINE ls_return       STRING
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   
   DEFINE l_flag          LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_oofa001       LIKE oofa_t.oofa001
   DEFINE l_len           LIKE type_t.num5
   DEFINE l_len1          LIKE type_t.num5
   DEFINE l_rtbc005       STRING
   DEFINE l_rtbc000_o     LIKE rtbc_t.rtbc000
   DEFINE l_ooefstus      LIKE ooef_t.ooefstus
   DEFINE l_bkdocno       LIKE rtbc_t.rtbcdocno   #160704-00026#1 20160711 add by beckxie
   DEFINE  l_errno        LIKE type_t.chr10  #ken---add 需求單號：141208-00001 項次：10

   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF

   CALL cl_set_head_visible("","YES")

   IF p_cmd = 'r' THEN
      #此段落的r動作等同於a
      LET p_cmd = 'a'
   END IF

   LET l_insert = FALSE
   LET g_action_choice = ""

   LET g_qryparam.state = "i"

   #控制key欄位可否輸入
   CALL artt100_set_entry(p_cmd)

   CALL artt100_set_no_entry(p_cmd)

   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_detail_insert = l_allow_insert
   LET g_detail_delete = l_allow_delete

   DISPLAY BY NAME g_rtbc_m.rtbcunit,g_rtbc_m.rtbcdocdt,g_rtbc_m.rtbcdocno,g_rtbc_m.rtbc000,g_rtbc_m.rtbc001,
       g_rtbc_m.rtbcl002,g_rtbc_m.rtbcl003,g_rtbc_m.rtbcl004,g_rtbc_m.rtbcstus,g_rtbc_m.rtbc017,g_rtbc_m.rtbc101,
       g_rtbc_m.rtbc105,g_rtbc_m.rtbc102,g_rtbc_m.rtbc103,g_rtbc_m.rtbc100,g_rtbc_m.rtbc104,g_rtbc_m.rtbc106,
       g_rtbc_m.rtbc108,g_rtbc_m.rtbc107,g_rtbc_m.rtbc115,g_rtbc_m.rtbc116,g_rtbc_m.rtbc109,g_rtbc_m.rtbc110,g_rtbc_m.rtbc111,
       g_rtbc_m.rtbc112,g_rtbc_m.rtbc113,g_rtbc_m.rtbc114,g_rtbc_m.rtbc120,g_rtbc_m.rtbc121,g_rtbc_m.rtbc122,
       g_rtbc_m.rtbc123,g_rtbc_m.rtbc124,g_rtbc_m.rtbc125,
       g_rtbc_m.rtbc126,g_rtbc_m.rtbc127,g_rtbc_m.rtbc128,   #160324-00019#3 s983961--add          
       g_rtbc_m.rtbc014,g_rtbc_m.rtbc016,g_rtbc_m.rtbc004,
       g_rtbc_m.rtbc005,g_rtbc_m.rtbc015,g_rtbc_m.rtbc006,g_rtbc_m.rtbc018,g_rtbc_m.rtbc019,g_rtbc_m.rtbc007,
       g_rtbc_m.rtbc020,g_rtbc_m.rtbc022,g_rtbc_m.rtbc008,g_rtbc_m.rtbc010,g_rtbc_m.rtbc011,g_rtbc_m.rtbc013,
       g_rtbc_m.rtbc023,g_rtbc_m.rtbc024,g_rtbc_m.rtbc025,g_rtbc_m.rtbc026,g_rtbc_m.rtbc021,g_rtbc_m.rtbc150,g_rtbc_m.rtbc151,
       g_rtbc_m.rtbc152,g_rtbc_m.rtbc153,g_rtbc_m.rtbc154,g_rtbc_m.rtbc155,g_rtbc_m.rtbc156,g_rtbc_m.rtbc157,
       g_rtbc_m.rtbc158,g_rtbc_m.rtbc159,g_rtbc_m.rtbc160,g_rtbc_m.rtbc161,g_rtbc_m.rtbc162,g_rtbc_m.rtbc163,
       g_rtbc_m.rtbc164,g_rtbc_m.rtbc165,g_rtbc_m.rtbc166,g_rtbc_m.rtbc002,g_rtbc_m.rtbc003,g_rtbc_m.rtbc009,
       g_rtbc_m.rtbc012,g_rtbc_m.rtbcsite,g_rtbc_m.rtbcacti

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單頭段
      INPUT BY NAME g_rtbc_m.rtbcunit,g_rtbc_m.rtbcdocdt,g_rtbc_m.rtbcdocno,g_rtbc_m.rtbc000,g_rtbc_m.rtbc001,
          g_rtbc_m.rtbcl002,g_rtbc_m.rtbcl003,g_rtbc_m.rtbcl004,g_rtbc_m.rtbcstus,g_rtbc_m.rtbc017,g_rtbc_m.rtbc101,
          g_rtbc_m.rtbc105,g_rtbc_m.rtbc102,g_rtbc_m.rtbc103,g_rtbc_m.rtbc100,g_rtbc_m.rtbc104,g_rtbc_m.rtbc106,
          g_rtbc_m.rtbc108,g_rtbc_m.rtbc107,g_rtbc_m.rtbc115,g_rtbc_m.rtbc116,g_rtbc_m.rtbc109,g_rtbc_m.rtbc110,g_rtbc_m.rtbc111,
          g_rtbc_m.rtbc112,g_rtbc_m.rtbc113,g_rtbc_m.rtbc114,g_rtbc_m.rtbc120,g_rtbc_m.rtbc121,g_rtbc_m.rtbc122,
          g_rtbc_m.rtbc123,g_rtbc_m.rtbc124,g_rtbc_m.rtbc125,
          g_rtbc_m.rtbc126,g_rtbc_m.rtbc127,g_rtbc_m.rtbc128,   #160324-00019#3 s983961--add  
          g_rtbc_m.rtbc014,g_rtbc_m.rtbc016,g_rtbc_m.rtbc004,
          g_rtbc_m.rtbc005,g_rtbc_m.rtbc015,g_rtbc_m.rtbc006,g_rtbc_m.rtbc018,g_rtbc_m.rtbc019,g_rtbc_m.rtbc007,
          g_rtbc_m.rtbc020,g_rtbc_m.rtbc022,g_rtbc_m.rtbc008,g_rtbc_m.rtbc010,g_rtbc_m.rtbc011,g_rtbc_m.rtbc013,
          g_rtbc_m.rtbc023,g_rtbc_m.rtbc024,g_rtbc_m.rtbc025,g_rtbc_m.rtbc026,g_rtbc_m.rtbc021,g_rtbc_m.rtbc150,g_rtbc_m.rtbc151,
          g_rtbc_m.rtbc152,g_rtbc_m.rtbc153,g_rtbc_m.rtbc154,g_rtbc_m.rtbc155,g_rtbc_m.rtbc156,g_rtbc_m.rtbc157,
          g_rtbc_m.rtbc158,g_rtbc_m.rtbc159,g_rtbc_m.rtbc160,g_rtbc_m.rtbc161,g_rtbc_m.rtbc162,g_rtbc_m.rtbc163,
          g_rtbc_m.rtbc164,g_rtbc_m.rtbc165,g_rtbc_m.rtbc166,g_rtbc_m.rtbc002,g_rtbc_m.rtbc003,g_rtbc_m.rtbc009,
          g_rtbc_m.rtbc012,g_rtbc_m.rtbcsite,g_rtbc_m.rtbcacti
         ATTRIBUTE(WITHOUT DEFAULTS)

         #自訂ACTION(master_input)


         ON ACTION update_item
            IF cl_auth_chk_act("update_item") THEN   #151027-00016#2 20151111 add by beckxie
               IF NOT cl_null(g_rtbc_m.rtbcdocno) THEN
                  CALL n_rtbcl(g_rtbc_m.rtbcdocno)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_rtbc_m.rtbcdocno
                  CALL ap_ref_array2(g_ref_fields," SELECT rtbcl002,rtbcl003,rtbcl004 FROM rtbcl_t WHERE rtbclent = '"||g_enterprise||"' AND rtbcldocno = ?  AND rtbcl001 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_rtbc_m.rtbcl002 = g_rtn_fields[1]
                  LET g_rtbc_m.rtbcl003 = g_rtn_fields[2]
                  LET g_rtbc_m.rtbcl004 = g_rtn_fields[3]
                  DISPLAY BY NAME g_rtbc_m.rtbc002
                  DISPLAY BY NAME g_rtbc_m.rtbc003
                  DISPLAY BY NAME g_rtbc_m.rtbc004
               END IF 
            END IF   #151027-00016#2 20151111 add by beckxie


         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)
            LET g_master_multi_table_t.rtbcldocno = g_rtbc_m.rtbcdocno
            LET g_master_multi_table_t.rtbcl002 = g_rtbc_m.rtbcl002
            LET g_master_multi_table_t.rtbcl003 = g_rtbc_m.rtbcl003
            LET g_master_multi_table_t.rtbcl004 = g_rtbc_m.rtbcl004
            CALL artt100_upd_rtbc156()
            CALL artt100_set_entry(p_cmd)
            CALL artt100_set_no_entry(p_cmd)
            #NEXT FIELD rtbcunit #ken_mark
            NEXT FIELD rtbcsite #ken---add 需求單號：141208-00001 項次：10

         AFTER FIELD rtbcunit

            LET g_rtbc_m.rtbcunit_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbcunit_desc 
            
            IF cl_null(g_rtbc_m.rtbcunit) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'adb-00012'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
    #制定組織未輸入！ 
               NEXT FIELD CURRENT
            END IF

            IF NOT cl_null(g_rtbc_m.rtbcunit) THEN
               #此段落由子樣板a19產生
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbcunit != g_rtbc_m_t.rtbcunit OR g_rtbc_m_t.rtbcunit IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               #160824-00007#158 20161125 modify by beckxie---S
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbcunit != g_rtbc_m_t.rtbcunit OR cl_null(g_rtbc_m_t.rtbcunit))) THEN   #150427-00012#6 20150707 add by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbcunit != g_rtbc_m_o.rtbcunit OR cl_null(g_rtbc_m_o.rtbcunit))) THEN   #150427-00012#6 20150707 add by beckxie
               #160824-00007#158 20161125 modify  by beckxie---E
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_rtbc_m.rtbcunit
                  LET g_chkparam.arg2 = '8'
                  LET g_chkparam.arg3 = g_site

                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooed004") THEN
                     #檢查失敗時後續處理
                     #LET g_rtbc_m.rtbcunit = g_rtbc_m_t.rtbcunit   #160824-00007#158 20161125 mark by beckxie
                     #160824-00007#158 20161125 add by beckxie---S
                     LET g_rtbc_m.rtbcunit = g_rtbc_m_o.rtbcunit   
                     LET g_rtbc_m.rtbcsite = g_rtbc_m_o.rtbcsite   
                     LET g_rtbc_m.rtbcsite_desc = g_rtbc_m_o.rtbcsite_desc   
                     #160824-00007#158 20161125 add by beckxie---E
                     CALL artt100_rtbcunit_ref()
                     NEXT FIELD CURRENT
                  END IF
                  
                  CALL artt100_get_ooef004()

                  LET g_rtbc_m.rtbcsite = g_rtbc_m.rtbcunit
               END IF

            END IF

            CALL artt100_rtbcunit_ref()
            LET g_rtbc_m_o.* = g_rtbc_m.* #160824-00007#158 20161125 add by beckxie

         BEFORE FIELD rtbcunit

         ON CHANGE rtbcunit
         
         BEFORE FIELD rtbcdocdt

         AFTER FIELD rtbcdocdt

         ON CHANGE rtbcdocdt

         BEFORE FIELD rtbcdocno

         AFTER FIELD rtbcdocno
            #IF NOT s_aooi200_chk_slip(g_rtbc_m.rtbcunit,'',g_rtbc_m.rtbcdocno,g_prog)  THEN #ken_mark
            IF NOT s_aooi200_chk_slip(g_rtbc_m.rtbcsite,'',g_rtbc_m.rtbcdocno,g_prog)  THEN #ken---add 需求單號：141208-00001 項次：10
               LET g_rtbc_m.rtbcdocno = g_rtbc_m_t.rtbcdocno
               NEXT FIELD CURRENT
            END IF

         ON CHANGE rtbcdocno

         BEFORE FIELD rtbc000

         AFTER FIELD rtbc000
            IF g_rtbc_m.rtbc000 = 'I' THEN
               LET g_rtbc_m.rtbcacti = 'Y'
               DISPLAY BY NAME g_rtbc_m.rtbcacti
            END IF
            IF g_rtbc_m.rtbc000 != l_rtbc000_o THEN
               LET g_rtbc_m.rtbc001 = ''
               DISPLAY BY NAME g_rtbc_m.rtbc001
            END IF
            LET l_rtbc000_o = g_rtbc_m.rtbc000
            
           
         ON CHANGE rtbc000
            CALL artt100_set_entry(p_cmd)
            CALL artt100_set_no_entry(p_cmd)

         BEFORE FIELD rtbc001

         AFTER FIELD rtbc001
            IF NOT cl_null(g_rtbc_m.rtbc001) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc001 != g_rtbc_m_t.rtbc001 OR g_rtbc_m_t.rtbc001 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               #160824-00007#158 20161125 modify by beckxie---S
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc001 != g_rtbc_m_t.rtbc001 OR cl_null(g_rtbc_m_t.rtbc001))) THEN   #150427-00012#6 20150707 add by beckxie
               IF g_rtbc_m.rtbc001 != g_rtbc_m_o.rtbc001 OR cl_null(g_rtbc_m_o.rtbc001) THEN   #150427-00012#6 20150707 add by beckxie
               #160824-00007#158 20161125 modify by beckxie---E
                  CASE g_rtbc_m.rtbc000
                     WHEN 'I'
                        LET l_count = 0
                        SELECT COUNT(*) INTO l_count
                          FROM ooef_t
                         WHERE ooefent = g_enterprise
                           AND ooef001 = g_rtbc_m.rtbc001
                        IF cl_null(l_count) THEN
                           LET l_count = 0
                        END IF
                        IF l_count > 0 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'art-00308'
                           LET g_errparam.extend = g_rtbc_m.rtbc001
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
   #此門店資料已存在！
                           #LET g_rtbc_m.rtbc001 = g_rtbc_m_t.rtbc001   #160824-00007#158 20161125 mark by beckxie
                           LET g_rtbc_m.rtbc001 = g_rtbc_m_o.rtbc001   #160824-00007#158 20161125 add by beckxie
                           NEXT FIELD CURRENT
                        END IF
                        SELECT COUNT(*) INTO l_count
                          FROM rtbc_t
                         WHERE rtbcent = g_enterprise
                           AND rtbc001 = g_rtbc_m.rtbc001
                           AND rtbcdocno != g_rtbc_m.rtbcdocno
                           AND rtbcstus = 'N'
                        IF l_count > 0 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'art-00309'
                           LET g_errparam.extend = g_rtbc_m.rtbc001
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                           #LET g_rtbc_m.rtbc001 = g_rtbc_m_t.rtbc001   #160824-00007#158 20161125 mark by beckxie
                           LET g_rtbc_m.rtbc001 = g_rtbc_m_t.rtbc001   #160824-00007#158 20161125 add by beckxie
                           NEXT FIELD CURRENT
                        END IF

                     WHEN 'U'
                        #檢查資料是否有存在於組織資料檔
#                        SELECT COUNT(*) INTO l_count FROM ooef_t,ooee_t
#                         WHERE ooefent = g_enterprise
#                           AND ooef001 = g_rtbc_m.rtbc001
#                           AND ooeeent = ooefent
#                           AND ooee001 = ooef001
#                           AND ooee002 = '2'
#                           AND ooee003 = 'F'
                        SELECT COUNT(*) INTO l_count FROM ooef_t
                         WHERE ooefent = g_enterprise
                           AND ooef001 = g_rtbc_m.rtbc001
                           AND ooef304 = 'Y'
                        IF l_count = 0 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'art-00062'
                           LET g_errparam.extend = g_rtbc_m.rtbc001
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
    #已存在未確認的門店資料
                           #LET g_rtbc_m.rtbc001 = g_rtbc_m_t.rtbc001   #160824-00007#158 20161125 mark by beckxie
                           #160824-00007#158 20161125 add by beckxie---S
                           LET g_rtbc_m.rtbc001 = g_rtbc_m_o.rtbc001
                           LET g_rtbc_m.rtbc002 =  g_rtbc_m_o.rtbc002 
                           LET g_rtbc_m.rtbc003 =  g_rtbc_m_o.rtbc003 
                           LET g_rtbc_m.rtbc004 =  g_rtbc_m_o.rtbc004 
                           LET g_rtbc_m.rtbc005 =  g_rtbc_m_o.rtbc005 
                           LET g_rtbc_m.rtbc006 =  g_rtbc_m_o.rtbc006 
                           LET g_rtbc_m.rtbc007 =  g_rtbc_m_o.rtbc007 
                           LET g_rtbc_m.rtbc008 =  g_rtbc_m_o.rtbc008 
                           LET g_rtbc_m.rtbc009 =  g_rtbc_m_o.rtbc009 
                           LET g_rtbc_m.rtbc010 =  g_rtbc_m_o.rtbc010 
                           LET g_rtbc_m.rtbc011 =  g_rtbc_m_o.rtbc011 
                           LET g_rtbc_m.rtbc012 =  g_rtbc_m_o.rtbc012 
                           LET g_rtbc_m.rtbc013 =  g_rtbc_m_o.rtbc013 
                           LET g_rtbc_m.rtbc014 =  g_rtbc_m_o.rtbc014 
                           LET g_rtbc_m.rtbc015 =  g_rtbc_m_o.rtbc015 
                           LET g_rtbc_m.rtbc016 =  g_rtbc_m_o.rtbc016 
                           LET g_rtbc_m.rtbc017 =  g_rtbc_m_o.rtbc017 
                           LET g_rtbc_m.rtbc018 =  g_rtbc_m_o.rtbc018 
                           LET g_rtbc_m.rtbc019 =  g_rtbc_m_o.rtbc019 
                           LET g_rtbc_m.rtbc020 =  g_rtbc_m_o.rtbc020 
                           LET g_rtbc_m.rtbc021 =  g_rtbc_m_o.rtbc021 
                           LET g_rtbc_m.rtbc022 =  g_rtbc_m_o.rtbc022 
                           LET g_rtbc_m.rtbc023 =  g_rtbc_m_o.rtbc023 
                           LET g_rtbc_m.rtbc024 =  g_rtbc_m_o.rtbc024 
                           LET g_rtbc_m.rtbc025 =  g_rtbc_m_o.rtbc025 
                           LET g_rtbc_m.rtbc026 =  g_rtbc_m_o.rtbc026 
                           LET g_rtbc_m.rtbc100 =  g_rtbc_m_o.rtbc100 
                           LET g_rtbc_m.rtbc101 =  g_rtbc_m_o.rtbc101 
                           LET g_rtbc_m.rtbc102 =  g_rtbc_m_o.rtbc102 
                           LET g_rtbc_m.rtbc103 =  g_rtbc_m_o.rtbc103 
                           LET g_rtbc_m.rtbc104 =  g_rtbc_m_o.rtbc104 
                           LET g_rtbc_m.rtbc105 =  g_rtbc_m_o.rtbc105 
                           LET g_rtbc_m.rtbc106 =  g_rtbc_m_o.rtbc106 
                           LET g_rtbc_m.rtbc107 =  g_rtbc_m_o.rtbc107 
                           LET g_rtbc_m.rtbc108 =  g_rtbc_m_o.rtbc108 
                           LET g_rtbc_m.rtbc109 =  g_rtbc_m_o.rtbc109 
                           LET g_rtbc_m.rtbc110 =  g_rtbc_m_o.rtbc110 
                           LET g_rtbc_m.rtbc111 =  g_rtbc_m_o.rtbc111 
                           LET g_rtbc_m.rtbc112 =  g_rtbc_m_o.rtbc112 
                           LET g_rtbc_m.rtbc113 =  g_rtbc_m_o.rtbc113 
                           LET g_rtbc_m.rtbc114 =  g_rtbc_m_o.rtbc114 
                           LET g_rtbc_m.rtbc115 =  g_rtbc_m_o.rtbc115 
                           LET g_rtbc_m.rtbc116 =  g_rtbc_m_o.rtbc116 
                           LET g_rtbc_m.rtbc120 =  g_rtbc_m_o.rtbc120 
                           LET g_rtbc_m.rtbc121 =  g_rtbc_m_o.rtbc121 
                           LET g_rtbc_m.rtbc122 =  g_rtbc_m_o.rtbc122 
                           LET g_rtbc_m.rtbc123 =  g_rtbc_m_o.rtbc123 
                           LET g_rtbc_m.rtbc124 =  g_rtbc_m_o.rtbc124 
                           LET g_rtbc_m.rtbc125 =  g_rtbc_m_o.rtbc125 
                           LET g_rtbc_m.rtbc126 =  g_rtbc_m_o.rtbc126 
                           LET g_rtbc_m.rtbc127 =  g_rtbc_m_o.rtbc127 
                           LET g_rtbc_m.rtbc128 =  g_rtbc_m_o.rtbc128 
                           LET g_rtbc_m.rtbc150 =  g_rtbc_m_o.rtbc150 
                           LET g_rtbc_m.rtbc151 =  g_rtbc_m_o.rtbc151 
                           LET g_rtbc_m.rtbc152 =  g_rtbc_m_o.rtbc152 
                           LET g_rtbc_m.rtbc153 =  g_rtbc_m_o.rtbc153 
                           LET g_rtbc_m.rtbc154 =  g_rtbc_m_o.rtbc154 
                           LET g_rtbc_m.rtbc155 =  g_rtbc_m_o.rtbc155 
                           LET g_rtbc_m.rtbc156 =  g_rtbc_m_o.rtbc156 
                           LET g_rtbc_m.rtbc157 =  g_rtbc_m_o.rtbc157 
                           LET g_rtbc_m.rtbc158 =  g_rtbc_m_o.rtbc158 
                           LET g_rtbc_m.rtbc159 =  g_rtbc_m_o.rtbc159 
                           LET g_rtbc_m.rtbc160 =  g_rtbc_m_o.rtbc160 
                           LET g_rtbc_m.rtbc161 =  g_rtbc_m_o.rtbc161 
                           LET g_rtbc_m.rtbc162 =  g_rtbc_m_o.rtbc162 
                           LET g_rtbc_m.rtbc163 =  g_rtbc_m_o.rtbc163 
                           LET g_rtbc_m.rtbc164 =  g_rtbc_m_o.rtbc164 
                           LET g_rtbc_m.rtbc165 =  g_rtbc_m_o.rtbc165 
                           LET g_rtbc_m.rtbc166 =  g_rtbc_m_o.rtbc166 
                           LET g_rtbc_m.rtbcacti = g_rtbc_m_o.rtbcacti 
                           CALL artt100_rtbc017_ref()
                           CALL artt100_rtbc105_ref()
                           CALL artt100_rtbc104_ref()
                           CALL artt100_rtbc106_ref()
                           CALL artt100_rtbc108_ref()
                           CALL artt100_rtbc123_ref()
                           CALL artt100_rtbc124_ref()
                           CALL artt100_rtbc125_ref()
                           CALL artt100_rtbc126_ref()
                           CALL artt100_rtbc127_ref()
                           CALL artt100_rtbc128_ref()    
                           CALL artt100_rtbc014_ref()
                           CALL artt100_rtbc016_ref()
                           CALL artt100_rtbc004_ref()
                           CALL artt100_rtbc015_ref()
                           CALL artt100_rtbc006_ref()
                           CALL artt100_rtbc018_ref()
                           CALL artt100_rtbc019_ref()
                           CALL artt100_rtbc008_ref()
                           CALL artt100_rtbc024_ref()
                           CALL artt100_rtbc026_ref()
                           CALL artt100_rtbc150_ref()
                           CALL artt100_rtbc151_ref()
                           CALL artt100_rtbc152_ref()
                           CALL artt100_rtbc153_ref()
                           CALL artt100_rtbc154_ref()
                           CALL artt100_rtbc155_ref()
                           CALL artt100_rtbc156_ref()
                           CALL artt100_rtbc157_ref()
                           CALL artt100_rtbc158_ref()
                           CALL artt100_rtbc159_ref()
                           CALL artt100_rtbc160_ref()
                           CALL artt100_rtbc161_ref()
                           CALL artt100_rtbc162_ref()
                           CALL artt100_rtbc163_ref()
                           CALL artt100_rtbc164_ref()
                           CALL artt100_rtbc165_ref()
                           CALL artt100_rtbc166_ref()
                           #160824-00007#158 20161125 add by beckxie---E
                           NEXT FIELD CURRENT 
                        ELSE
                           SELECT ooefstus INTO l_ooefstus
                             FROM ooef_t
                            WHERE ooefent = g_enterprise
                              AND ooef001 = g_rtbc_m.rtbc001
                           IF l_ooefstus <> 'Y' THEN
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = 'art-00069'
                              LET g_errparam.extend = g_rtbc_m.rtbc001
                              LET g_errparam.popup = TRUE
                              CALL cl_err()
                              #LET g_rtbc_m.rtbc001 = g_rtbc_m_t.rtbc001   #160824-00007#158 20161125 mark by beckxie
                              #160824-00007#158 20161125 add by beckxie---S
                              LET g_rtbc_m.rtbc001 = g_rtbc_m_o.rtbc001
                              LET g_rtbc_m.rtbc002 =  g_rtbc_m_o.rtbc002 
                              LET g_rtbc_m.rtbc003 =  g_rtbc_m_o.rtbc003 
                              LET g_rtbc_m.rtbc004 =  g_rtbc_m_o.rtbc004 
                              LET g_rtbc_m.rtbc005 =  g_rtbc_m_o.rtbc005 
                              LET g_rtbc_m.rtbc006 =  g_rtbc_m_o.rtbc006 
                              LET g_rtbc_m.rtbc007 =  g_rtbc_m_o.rtbc007 
                              LET g_rtbc_m.rtbc008 =  g_rtbc_m_o.rtbc008 
                              LET g_rtbc_m.rtbc009 =  g_rtbc_m_o.rtbc009 
                              LET g_rtbc_m.rtbc010 =  g_rtbc_m_o.rtbc010 
                              LET g_rtbc_m.rtbc011 =  g_rtbc_m_o.rtbc011 
                              LET g_rtbc_m.rtbc012 =  g_rtbc_m_o.rtbc012 
                              LET g_rtbc_m.rtbc013 =  g_rtbc_m_o.rtbc013 
                              LET g_rtbc_m.rtbc014 =  g_rtbc_m_o.rtbc014 
                              LET g_rtbc_m.rtbc015 =  g_rtbc_m_o.rtbc015 
                              LET g_rtbc_m.rtbc016 =  g_rtbc_m_o.rtbc016 
                              LET g_rtbc_m.rtbc017 =  g_rtbc_m_o.rtbc017 
                              LET g_rtbc_m.rtbc018 =  g_rtbc_m_o.rtbc018 
                              LET g_rtbc_m.rtbc019 =  g_rtbc_m_o.rtbc019 
                              LET g_rtbc_m.rtbc020 =  g_rtbc_m_o.rtbc020 
                              LET g_rtbc_m.rtbc021 =  g_rtbc_m_o.rtbc021 
                              LET g_rtbc_m.rtbc022 =  g_rtbc_m_o.rtbc022 
                              LET g_rtbc_m.rtbc023 =  g_rtbc_m_o.rtbc023 
                              LET g_rtbc_m.rtbc024 =  g_rtbc_m_o.rtbc024 
                              LET g_rtbc_m.rtbc025 =  g_rtbc_m_o.rtbc025 
                              LET g_rtbc_m.rtbc026 =  g_rtbc_m_o.rtbc026 
                              LET g_rtbc_m.rtbc100 =  g_rtbc_m_o.rtbc100 
                              LET g_rtbc_m.rtbc101 =  g_rtbc_m_o.rtbc101 
                              LET g_rtbc_m.rtbc102 =  g_rtbc_m_o.rtbc102 
                              LET g_rtbc_m.rtbc103 =  g_rtbc_m_o.rtbc103 
                              LET g_rtbc_m.rtbc104 =  g_rtbc_m_o.rtbc104 
                              LET g_rtbc_m.rtbc105 =  g_rtbc_m_o.rtbc105 
                              LET g_rtbc_m.rtbc106 =  g_rtbc_m_o.rtbc106 
                              LET g_rtbc_m.rtbc107 =  g_rtbc_m_o.rtbc107 
                              LET g_rtbc_m.rtbc108 =  g_rtbc_m_o.rtbc108 
                              LET g_rtbc_m.rtbc109 =  g_rtbc_m_o.rtbc109 
                              LET g_rtbc_m.rtbc110 =  g_rtbc_m_o.rtbc110 
                              LET g_rtbc_m.rtbc111 =  g_rtbc_m_o.rtbc111 
                              LET g_rtbc_m.rtbc112 =  g_rtbc_m_o.rtbc112 
                              LET g_rtbc_m.rtbc113 =  g_rtbc_m_o.rtbc113 
                              LET g_rtbc_m.rtbc114 =  g_rtbc_m_o.rtbc114 
                              LET g_rtbc_m.rtbc115 =  g_rtbc_m_o.rtbc115 
                              LET g_rtbc_m.rtbc116 =  g_rtbc_m_o.rtbc116 
                              LET g_rtbc_m.rtbc120 =  g_rtbc_m_o.rtbc120 
                              LET g_rtbc_m.rtbc121 =  g_rtbc_m_o.rtbc121 
                              LET g_rtbc_m.rtbc122 =  g_rtbc_m_o.rtbc122 
                              LET g_rtbc_m.rtbc123 =  g_rtbc_m_o.rtbc123 
                              LET g_rtbc_m.rtbc124 =  g_rtbc_m_o.rtbc124 
                              LET g_rtbc_m.rtbc125 =  g_rtbc_m_o.rtbc125 
                              LET g_rtbc_m.rtbc126 =  g_rtbc_m_o.rtbc126 
                              LET g_rtbc_m.rtbc127 =  g_rtbc_m_o.rtbc127 
                              LET g_rtbc_m.rtbc128 =  g_rtbc_m_o.rtbc128 
                              LET g_rtbc_m.rtbc150 =  g_rtbc_m_o.rtbc150 
                              LET g_rtbc_m.rtbc151 =  g_rtbc_m_o.rtbc151 
                              LET g_rtbc_m.rtbc152 =  g_rtbc_m_o.rtbc152 
                              LET g_rtbc_m.rtbc153 =  g_rtbc_m_o.rtbc153 
                              LET g_rtbc_m.rtbc154 =  g_rtbc_m_o.rtbc154 
                              LET g_rtbc_m.rtbc155 =  g_rtbc_m_o.rtbc155 
                              LET g_rtbc_m.rtbc156 =  g_rtbc_m_o.rtbc156 
                              LET g_rtbc_m.rtbc157 =  g_rtbc_m_o.rtbc157 
                              LET g_rtbc_m.rtbc158 =  g_rtbc_m_o.rtbc158 
                              LET g_rtbc_m.rtbc159 =  g_rtbc_m_o.rtbc159 
                              LET g_rtbc_m.rtbc160 =  g_rtbc_m_o.rtbc160 
                              LET g_rtbc_m.rtbc161 =  g_rtbc_m_o.rtbc161 
                              LET g_rtbc_m.rtbc162 =  g_rtbc_m_o.rtbc162 
                              LET g_rtbc_m.rtbc163 =  g_rtbc_m_o.rtbc163 
                              LET g_rtbc_m.rtbc164 =  g_rtbc_m_o.rtbc164 
                              LET g_rtbc_m.rtbc165 =  g_rtbc_m_o.rtbc165 
                              LET g_rtbc_m.rtbc166 =  g_rtbc_m_o.rtbc166 
                              LET g_rtbc_m.rtbcacti = g_rtbc_m_o.rtbcacti 
                              CALL artt100_rtbc017_ref()
                              CALL artt100_rtbc105_ref()
                              CALL artt100_rtbc104_ref()
                              CALL artt100_rtbc106_ref()
                              CALL artt100_rtbc108_ref()
                              CALL artt100_rtbc123_ref()
                              CALL artt100_rtbc124_ref()
                              CALL artt100_rtbc125_ref()
                              CALL artt100_rtbc126_ref()
                              CALL artt100_rtbc127_ref()
                              CALL artt100_rtbc128_ref()    
                              CALL artt100_rtbc014_ref()
                              CALL artt100_rtbc016_ref()
                              CALL artt100_rtbc004_ref()
                              CALL artt100_rtbc015_ref()
                              CALL artt100_rtbc006_ref()
                              CALL artt100_rtbc018_ref()
                              CALL artt100_rtbc019_ref()
                              CALL artt100_rtbc008_ref()
                              CALL artt100_rtbc024_ref()
                              CALL artt100_rtbc026_ref()
                              CALL artt100_rtbc150_ref()
                              CALL artt100_rtbc151_ref()
                              CALL artt100_rtbc152_ref()
                              CALL artt100_rtbc153_ref()
                              CALL artt100_rtbc154_ref()
                              CALL artt100_rtbc155_ref()
                              CALL artt100_rtbc156_ref()
                              CALL artt100_rtbc157_ref()
                              CALL artt100_rtbc158_ref()
                              CALL artt100_rtbc159_ref()
                              CALL artt100_rtbc160_ref()
                              CALL artt100_rtbc161_ref()
                              CALL artt100_rtbc162_ref()
                              CALL artt100_rtbc163_ref()
                              CALL artt100_rtbc164_ref()
                              CALL artt100_rtbc165_ref()
                              CALL artt100_rtbc166_ref()
                              #160824-00007#158 20161125 add by beckxie---E
                              NEXT FIELD CURRENT 
                           END IF
                        END IF
                        
                        
                        #先檢查是否有其他未確認的rtbc_t有此門店資料
                        #有的話要報錯
                        LET l_count = 0
                        SELECT COUNT(*) INTO l_count
                          FROM rtbc_t
                         WHERE rtbcent = g_enterprise
                           AND rtbcstus = 'N'
                           AND rtbc001 = g_rtbc_m.rtbc001
                           AND rtbcdocno != g_rtbc_m.rtbcdocno
                        IF cl_null(l_count) THEN
                           LET l_count = 0
                        END IF
                        IF l_count > 0 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'art-00309'
                           LET g_errparam.extend = g_rtbc_m.rtbc001
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
    #已存在未確認的門店資料
                           #LET g_rtbc_m.rtbc001 = g_rtbc_m_t.rtbc001   #160824-00007#158 20161125 mark by beckxie
                           #160824-00007#158 20161125 add by beckxie---S
                           LET g_rtbc_m.rtbc001 = g_rtbc_m_o.rtbc001
                           LET g_rtbc_m.rtbc002 =  g_rtbc_m_o.rtbc002 
                           LET g_rtbc_m.rtbc003 =  g_rtbc_m_o.rtbc003 
                           LET g_rtbc_m.rtbc004 =  g_rtbc_m_o.rtbc004 
                           LET g_rtbc_m.rtbc005 =  g_rtbc_m_o.rtbc005 
                           LET g_rtbc_m.rtbc006 =  g_rtbc_m_o.rtbc006 
                           LET g_rtbc_m.rtbc007 =  g_rtbc_m_o.rtbc007 
                           LET g_rtbc_m.rtbc008 =  g_rtbc_m_o.rtbc008 
                           LET g_rtbc_m.rtbc009 =  g_rtbc_m_o.rtbc009 
                           LET g_rtbc_m.rtbc010 =  g_rtbc_m_o.rtbc010 
                           LET g_rtbc_m.rtbc011 =  g_rtbc_m_o.rtbc011 
                           LET g_rtbc_m.rtbc012 =  g_rtbc_m_o.rtbc012 
                           LET g_rtbc_m.rtbc013 =  g_rtbc_m_o.rtbc013 
                           LET g_rtbc_m.rtbc014 =  g_rtbc_m_o.rtbc014 
                           LET g_rtbc_m.rtbc015 =  g_rtbc_m_o.rtbc015 
                           LET g_rtbc_m.rtbc016 =  g_rtbc_m_o.rtbc016 
                           LET g_rtbc_m.rtbc017 =  g_rtbc_m_o.rtbc017 
                           LET g_rtbc_m.rtbc018 =  g_rtbc_m_o.rtbc018 
                           LET g_rtbc_m.rtbc019 =  g_rtbc_m_o.rtbc019 
                           LET g_rtbc_m.rtbc020 =  g_rtbc_m_o.rtbc020 
                           LET g_rtbc_m.rtbc021 =  g_rtbc_m_o.rtbc021 
                           LET g_rtbc_m.rtbc022 =  g_rtbc_m_o.rtbc022 
                           LET g_rtbc_m.rtbc023 =  g_rtbc_m_o.rtbc023 
                           LET g_rtbc_m.rtbc024 =  g_rtbc_m_o.rtbc024 
                           LET g_rtbc_m.rtbc025 =  g_rtbc_m_o.rtbc025 
                           LET g_rtbc_m.rtbc026 =  g_rtbc_m_o.rtbc026 
                           LET g_rtbc_m.rtbc100 =  g_rtbc_m_o.rtbc100 
                           LET g_rtbc_m.rtbc101 =  g_rtbc_m_o.rtbc101 
                           LET g_rtbc_m.rtbc102 =  g_rtbc_m_o.rtbc102 
                           LET g_rtbc_m.rtbc103 =  g_rtbc_m_o.rtbc103 
                           LET g_rtbc_m.rtbc104 =  g_rtbc_m_o.rtbc104 
                           LET g_rtbc_m.rtbc105 =  g_rtbc_m_o.rtbc105 
                           LET g_rtbc_m.rtbc106 =  g_rtbc_m_o.rtbc106 
                           LET g_rtbc_m.rtbc107 =  g_rtbc_m_o.rtbc107 
                           LET g_rtbc_m.rtbc108 =  g_rtbc_m_o.rtbc108 
                           LET g_rtbc_m.rtbc109 =  g_rtbc_m_o.rtbc109 
                           LET g_rtbc_m.rtbc110 =  g_rtbc_m_o.rtbc110 
                           LET g_rtbc_m.rtbc111 =  g_rtbc_m_o.rtbc111 
                           LET g_rtbc_m.rtbc112 =  g_rtbc_m_o.rtbc112 
                           LET g_rtbc_m.rtbc113 =  g_rtbc_m_o.rtbc113 
                           LET g_rtbc_m.rtbc114 =  g_rtbc_m_o.rtbc114 
                           LET g_rtbc_m.rtbc115 =  g_rtbc_m_o.rtbc115 
                           LET g_rtbc_m.rtbc116 =  g_rtbc_m_o.rtbc116 
                           LET g_rtbc_m.rtbc120 =  g_rtbc_m_o.rtbc120 
                           LET g_rtbc_m.rtbc121 =  g_rtbc_m_o.rtbc121 
                           LET g_rtbc_m.rtbc122 =  g_rtbc_m_o.rtbc122 
                           LET g_rtbc_m.rtbc123 =  g_rtbc_m_o.rtbc123 
                           LET g_rtbc_m.rtbc124 =  g_rtbc_m_o.rtbc124 
                           LET g_rtbc_m.rtbc125 =  g_rtbc_m_o.rtbc125 
                           LET g_rtbc_m.rtbc126 =  g_rtbc_m_o.rtbc126 
                           LET g_rtbc_m.rtbc127 =  g_rtbc_m_o.rtbc127 
                           LET g_rtbc_m.rtbc128 =  g_rtbc_m_o.rtbc128 
                           LET g_rtbc_m.rtbc150 =  g_rtbc_m_o.rtbc150 
                           LET g_rtbc_m.rtbc151 =  g_rtbc_m_o.rtbc151 
                           LET g_rtbc_m.rtbc152 =  g_rtbc_m_o.rtbc152 
                           LET g_rtbc_m.rtbc153 =  g_rtbc_m_o.rtbc153 
                           LET g_rtbc_m.rtbc154 =  g_rtbc_m_o.rtbc154 
                           LET g_rtbc_m.rtbc155 =  g_rtbc_m_o.rtbc155 
                           LET g_rtbc_m.rtbc156 =  g_rtbc_m_o.rtbc156 
                           LET g_rtbc_m.rtbc157 =  g_rtbc_m_o.rtbc157 
                           LET g_rtbc_m.rtbc158 =  g_rtbc_m_o.rtbc158 
                           LET g_rtbc_m.rtbc159 =  g_rtbc_m_o.rtbc159 
                           LET g_rtbc_m.rtbc160 =  g_rtbc_m_o.rtbc160 
                           LET g_rtbc_m.rtbc161 =  g_rtbc_m_o.rtbc161 
                           LET g_rtbc_m.rtbc162 =  g_rtbc_m_o.rtbc162 
                           LET g_rtbc_m.rtbc163 =  g_rtbc_m_o.rtbc163 
                           LET g_rtbc_m.rtbc164 =  g_rtbc_m_o.rtbc164 
                           LET g_rtbc_m.rtbc165 =  g_rtbc_m_o.rtbc165 
                           LET g_rtbc_m.rtbc166 =  g_rtbc_m_o.rtbc166 
                           LET g_rtbc_m.rtbcacti = g_rtbc_m_o.rtbcacti 
                           CALL artt100_rtbc017_ref()
                           CALL artt100_rtbc105_ref()
                           CALL artt100_rtbc104_ref()
                           CALL artt100_rtbc106_ref()
                           CALL artt100_rtbc108_ref()
                           CALL artt100_rtbc123_ref()
                           CALL artt100_rtbc124_ref()
                           CALL artt100_rtbc125_ref()
                           CALL artt100_rtbc126_ref()
                           CALL artt100_rtbc127_ref()
                           CALL artt100_rtbc128_ref()    
                           CALL artt100_rtbc014_ref()
                           CALL artt100_rtbc016_ref()
                           CALL artt100_rtbc004_ref()
                           CALL artt100_rtbc015_ref()
                           CALL artt100_rtbc006_ref()
                           CALL artt100_rtbc018_ref()
                           CALL artt100_rtbc019_ref()
                           CALL artt100_rtbc008_ref()
                           CALL artt100_rtbc024_ref()
                           CALL artt100_rtbc026_ref()
                           CALL artt100_rtbc150_ref()
                           CALL artt100_rtbc151_ref()
                           CALL artt100_rtbc152_ref()
                           CALL artt100_rtbc153_ref()
                           CALL artt100_rtbc154_ref()
                           CALL artt100_rtbc155_ref()
                           CALL artt100_rtbc156_ref()
                           CALL artt100_rtbc157_ref()
                           CALL artt100_rtbc158_ref()
                           CALL artt100_rtbc159_ref()
                           CALL artt100_rtbc160_ref()
                           CALL artt100_rtbc161_ref()
                           CALL artt100_rtbc162_ref()
                           CALL artt100_rtbc163_ref()
                           CALL artt100_rtbc164_ref()
                           CALL artt100_rtbc165_ref()
                           CALL artt100_rtbc166_ref()
                           #160824-00007#158 20161125 add by beckxie---E
                           NEXT FIELD CURRENT
                        END IF

                        SELECT ooef002,ooef003,ooef004,ooef005,ooef006,ooef007,
                               ooef008,ooef009,ooef010,ooef011,ooef012,ooef013,
                               ooef014,ooef015,ooef016,ooef017,ooef018,ooef019,
                               ooef020,ooef021,ooef022,ooef023,ooef024,ooef025,ooef026,
                               ooef100,ooef101,ooef102,ooef103,ooef104,ooef105,
                               ooef106,ooef107,ooef108,ooef109,ooef110,ooef111,
                               ooef112,ooef113,ooef114,ooef115,ooef116,ooef120,ooef121,
                               ooef122,ooef123,ooef124,ooef125,
                               ooef126,ooef127,ooef128,                              #160324-00019#3 s983961--add  
                               ooef150,ooef151,
                               ooef152,ooef153,ooef154,ooef155,ooef156,ooef157,
                               ooef158,ooef159,ooef160,ooef161,ooef162,ooef163,
                               ooef164,ooef165,ooef166,ooefstus
                          INTO g_rtbc_m.rtbc002,g_rtbc_m.rtbc003,g_rtbc_m.rtbc004,
                               g_rtbc_m.rtbc005,g_rtbc_m.rtbc006,g_rtbc_m.rtbc007,
                               g_rtbc_m.rtbc008,g_rtbc_m.rtbc009,g_rtbc_m.rtbc010,
                               g_rtbc_m.rtbc011,g_rtbc_m.rtbc012,g_rtbc_m.rtbc013,
                               g_rtbc_m.rtbc014,g_rtbc_m.rtbc015,g_rtbc_m.rtbc016,
                               g_rtbc_m.rtbc017,g_rtbc_m.rtbc018,g_rtbc_m.rtbc019,
                               g_rtbc_m.rtbc020,g_rtbc_m.rtbc021,g_rtbc_m.rtbc022,
                               g_rtbc_m.rtbc023,g_rtbc_m.rtbc024,g_rtbc_m.rtbc025,g_rtbc_m.rtbc026,
                               g_rtbc_m.rtbc100,g_rtbc_m.rtbc101,g_rtbc_m.rtbc102,
                               g_rtbc_m.rtbc103,g_rtbc_m.rtbc104,g_rtbc_m.rtbc105,
                               g_rtbc_m.rtbc106,g_rtbc_m.rtbc107,g_rtbc_m.rtbc108,
                               g_rtbc_m.rtbc109,g_rtbc_m.rtbc110,g_rtbc_m.rtbc111,
                               g_rtbc_m.rtbc112,g_rtbc_m.rtbc113,g_rtbc_m.rtbc114,
                               g_rtbc_m.rtbc115,g_rtbc_m.rtbc116,g_rtbc_m.rtbc120,g_rtbc_m.rtbc121,
                               g_rtbc_m.rtbc122,g_rtbc_m.rtbc123,g_rtbc_m.rtbc124,
                               g_rtbc_m.rtbc125,
                               g_rtbc_m.rtbc126,g_rtbc_m.rtbc127,g_rtbc_m.rtbc128,   #160324-00019#3 s983961--add  
                               g_rtbc_m.rtbc150,g_rtbc_m.rtbc151,
                               g_rtbc_m.rtbc152,g_rtbc_m.rtbc153,g_rtbc_m.rtbc154,
                               g_rtbc_m.rtbc155,g_rtbc_m.rtbc156,g_rtbc_m.rtbc157,
                               g_rtbc_m.rtbc158,g_rtbc_m.rtbc159,g_rtbc_m.rtbc160,
                               g_rtbc_m.rtbc161,g_rtbc_m.rtbc162,g_rtbc_m.rtbc163,
                               g_rtbc_m.rtbc164,g_rtbc_m.rtbc165,g_rtbc_m.rtbc166,
                               g_rtbc_m.rtbcacti
                          FROM ooef_t
                         WHERE ooefent = g_enterprise
                           AND ooef001 = g_rtbc_m.rtbc001
                           
                        LET g_ooef012 = g_rtbc_m.rtbc012
                        LET g_rtbc_m.rtbc012 = ''
                        
                        #取得多語言資料
                        SELECT ooefl003,ooefl004,ooefl005
                          INTO g_rtbc_m.rtbcl002,g_rtbc_m.rtbcl003,g_rtbc_m.rtbcl004
                          FROM ooefl_t
                         WHERE ooeflent = g_enterprise
                           AND ooefl001 = g_rtbc_m.rtbc001
                           AND ooefl002 = g_dlang
                        DISPLAY BY NAME g_rtbc_m.rtbcl002,g_rtbc_m.rtbcl003,g_rtbc_m.rtbc005

                         DISPLAY BY NAME g_rtbc_m.rtbc002,g_rtbc_m.rtbc003,g_rtbc_m.rtbc004,
                                         g_rtbc_m.rtbc005,g_rtbc_m.rtbc006,g_rtbc_m.rtbc007,
                                         g_rtbc_m.rtbc008,g_rtbc_m.rtbc009,g_rtbc_m.rtbc010,
                                         g_rtbc_m.rtbc011,g_rtbc_m.rtbc012,g_rtbc_m.rtbc013,
                                         g_rtbc_m.rtbc014,g_rtbc_m.rtbc015,g_rtbc_m.rtbc016,
                                         g_rtbc_m.rtbc017,g_rtbc_m.rtbc018,g_rtbc_m.rtbc019,
                                         g_rtbc_m.rtbc020,g_rtbc_m.rtbc021,g_rtbc_m.rtbc022,
                                         g_rtbc_m.rtbc023,g_rtbc_m.rtbc024,g_rtbc_m.rtbc025,g_rtbc_m.rtbc026,
                                         g_rtbc_m.rtbc100,g_rtbc_m.rtbc101,g_rtbc_m.rtbc102,
                                         g_rtbc_m.rtbc103,g_rtbc_m.rtbc104,g_rtbc_m.rtbc105,
                                         g_rtbc_m.rtbc106,g_rtbc_m.rtbc107,g_rtbc_m.rtbc108,
                                         g_rtbc_m.rtbc109,g_rtbc_m.rtbc110,g_rtbc_m.rtbc111,
                                         g_rtbc_m.rtbc112,g_rtbc_m.rtbc113,g_rtbc_m.rtbc114,
                                         g_rtbc_m.rtbc115,g_rtbc_m.rtbc116,g_rtbc_m.rtbc120,g_rtbc_m.rtbc121,
                                         g_rtbc_m.rtbc122,g_rtbc_m.rtbc123,g_rtbc_m.rtbc124,
                                         g_rtbc_m.rtbc125,
                                         g_rtbc_m.rtbc126,g_rtbc_m.rtbc127,g_rtbc_m.rtbc128,   #160324-00019#3 s983961--add 
                                         g_rtbc_m.rtbc150,g_rtbc_m.rtbc151,
                                         g_rtbc_m.rtbc152,g_rtbc_m.rtbc153,g_rtbc_m.rtbc154,
                                         g_rtbc_m.rtbc155,g_rtbc_m.rtbc156,g_rtbc_m.rtbc157,
                                         g_rtbc_m.rtbc158,g_rtbc_m.rtbc159,g_rtbc_m.rtbc160,
                                         g_rtbc_m.rtbc161,g_rtbc_m.rtbc162,g_rtbc_m.rtbc163,
                                         g_rtbc_m.rtbc164,g_rtbc_m.rtbc165,g_rtbc_m.rtbc166,
                                         g_rtbc_m.rtbcacti
                        #ming 把取到的資料放到各欄位之中

                        #顯示參考欄位的資料
                        CALL artt100_rtbc017_ref()
                        CALL artt100_rtbc105_ref()
                        CALL artt100_rtbc104_ref()
                        CALL artt100_rtbc106_ref()
                        CALL artt100_rtbc108_ref()
                        CALL artt100_rtbc123_ref()
                        CALL artt100_rtbc124_ref()
                        CALL artt100_rtbc125_ref()
                        #160324-00019#3 s983961--add(s)     
                        CALL artt100_rtbc126_ref()
                        CALL artt100_rtbc127_ref()
                        CALL artt100_rtbc128_ref()
                        #160324-00019#3 s983961--add(e)     
                        CALL artt100_rtbc014_ref()
                        CALL artt100_rtbc016_ref()
                        CALL artt100_rtbc004_ref()
                        CALL artt100_rtbc015_ref()
                        CALL artt100_rtbc006_ref()
                        CALL artt100_rtbc018_ref()
                        CALL artt100_rtbc019_ref()
                        CALL artt100_rtbc008_ref()
                        CALL artt100_rtbc024_ref()
                        CALL artt100_rtbc026_ref()   #dongsz add

                        CALL artt100_rtbc150_ref()
                        CALL artt100_rtbc151_ref()
                        CALL artt100_rtbc152_ref()
                        CALL artt100_rtbc153_ref()
                        CALL artt100_rtbc154_ref()
                        CALL artt100_rtbc155_ref()
                        CALL artt100_rtbc156_ref()
                        CALL artt100_rtbc157_ref()
                        CALL artt100_rtbc158_ref()
                        CALL artt100_rtbc159_ref()
                        CALL artt100_rtbc160_ref()
                        CALL artt100_rtbc161_ref()
                        CALL artt100_rtbc162_ref()
                        CALL artt100_rtbc163_ref()
                        CALL artt100_rtbc164_ref()
                        CALL artt100_rtbc165_ref()
                        CALL artt100_rtbc166_ref()
                        
                        
                  END CASE
               END IF
            END IF
            LET g_rtbc_m_o.* = g_rtbc_m.*   #160824-00007#158 20161125 add by beckxie
            CALL artt100_set_entry(p_cmd)
            CALL artt100_set_no_entry(p_cmd)
            
         ON CHANGE rtbc001

         BEFORE FIELD rtbcl002

         AFTER FIELD rtbcl002

         ON CHANGE rtbcl002

         BEFORE FIELD rtbcl003

         AFTER FIELD rtbcl003

         ON CHANGE rtbcl003

         BEFORE FIELD rtbcl004

         AFTER FIELD rtbcl004

         ON CHANGE rtbcl004

         BEFORE FIELD rtbcstus

         AFTER FIELD rtbcstus

         ON CHANGE rtbcstus

         AFTER FIELD rtbc017
            LET g_rtbc_m.rtbc017_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc017_desc

            IF NOT cl_null(g_rtbc_m.rtbc017) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND(g_rtbc_m.rtbc017 != g_rtbc_m_t.rtbc017 OR g_rtbc_m_t.rtbc017 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               #160824-00007#158 20161125 modify by beckxie---S
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND(g_rtbc_m.rtbc017 != g_rtbc_m_t.rtbc017 OR cl_null(g_rtbc_m_t.rtbc017))) THEN   #150427-00012#6 20150707 add by beckxie
               IF g_rtbc_m.rtbc017 != g_rtbc_m_o.rtbc017 OR cl_null(g_rtbc_m_o.rtbc017) THEN   #150427-00012#6 20150707 add by beckxie
               #160824-00007#158 20161125 modify by beckxie---E
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_rtbc_m.rtbc017
#                  LET g_chkparam.arg2 = '1'

                  IF NOT cl_chk_exist("v_ooef001_1") THEN
                     #LET g_rtbc_m.rtbc017 = g_rtbc_m_t.rtbc017   #160824-00007#158 20161125 mark by beckxie
                     #160824-00007#158 20161125 add by beckxie---S
                     LET g_rtbc_m.rtbc017 = g_rtbc_m_o.rtbc017   
                     LET g_rtbc_m.rtbc002 = g_rtbc_m_o.rtbc002
                     LET g_rtbc_m.rtbc007 = g_rtbc_m_o.rtbc007
                     LET g_rtbc_m.rtbc020 = g_rtbc_m_o.rtbc020
                     LET g_rtbc_m.rtbc021 = g_rtbc_m_o.rtbc021
                     LET g_rtbc_m.rtbc022 = g_rtbc_m_o.rtbc022
                     LET g_rtbc_m.rtbc011 = g_rtbc_m_o.rtbc011
                     LET g_rtbc_m.rtbc013 = g_rtbc_m_o.rtbc013
                     LET g_rtbc_m.rtbc023 = g_rtbc_m_o.rtbc023
                     LET g_rtbc_m.rtbc014 = g_rtbc_m_o.rtbc014
                     LET g_rtbc_m.rtbc016 = g_rtbc_m_o.rtbc016
                     LET g_rtbc_m.rtbc015 = g_rtbc_m_o.rtbc015
                     LET g_rtbc_m.rtbc006 = g_rtbc_m_o.rtbc006
                     LET g_rtbc_m.rtbc018 = g_rtbc_m_o.rtbc018
                     LET g_rtbc_m.rtbc019 = g_rtbc_m_o.rtbc019
                     LET g_rtbc_m.rtbc014_desc = g_rtbc_m_o.rtbc014_desc
                     LET g_rtbc_m.rtbc016_desc = g_rtbc_m_o.rtbc016_desc
                     LET g_rtbc_m.rtbc015_desc = g_rtbc_m_o.rtbc015_desc
                     LET g_rtbc_m.rtbc006_desc = g_rtbc_m_o.rtbc006_desc
                     LET g_rtbc_m.rtbc018_desc = g_rtbc_m_o.rtbc018_desc
                     LET g_rtbc_m.rtbc019_desc = g_rtbc_m_o.rtbc019_desc
                     #160824-00007#158 20161125 add by beckxie---E
                     CALL artt100_rtbc017_ref()
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT artt100_rtbc017_chk(g_rtbc_m.rtbc017) THEN
                  #   LET g_rtbc_m.rtbc017 = g_rtbc_m_t.rtbc017
                  #   #CALL artt100_rtbc017_ref()
                  #   NEXT FIELD CURRENT
                  #END IF
               END IF
               #dongsz--add--str---
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m_o.rtbc017 != g_rtbc_m.rtbc017 OR cl_null(g_rtbc_m_o.rtbc017))) THEN
                  CALL artt100_rtbc017_default()
               END IF
               #dongsz--add--end---
            END IF
            LET g_rtbc_m_o.rtbc017 = g_rtbc_m.rtbc017
            CALL artt100_rtbc017_ref()
            LET g_rtbc_m_o.* = g_rtbc_m.*   #160824-00007#158 20161125 add by beckxie
            
         BEFORE FIELD rtbc017

         ON CHANGE rtbc017

         BEFORE FIELD rtbc101

         AFTER FIELD rtbc101

         ON CHANGE rtbc101

         AFTER FIELD rtbc105
            LET g_rtbc_m.rtbc105_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc105_desc

            IF NOT cl_null(g_rtbc_m.rtbc105) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc105 != g_rtbc_m_t.rtbc105 OR g_rtbc_m_t.rtbc105 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc105 != g_rtbc_m_t.rtbc105 OR cl_null(g_rtbc_m_t.rtbc105))) THEN   #150427-00012#6 20150707 add by beckxie
                  #161024-00025#1--mark-s
#                  INITIALIZE g_chkparam.* TO NULL
#                  LET g_chkparam.arg1 = g_rtbc_m.rtbc105
##                  LET g_chkparam.arg2 = 'F'
#                  IF NOT cl_chk_exist("v_ooef001_35") THEN
#                     LET g_rtbc_m.rtbc105 = g_rtbc_m_t.rtbc105
#                     CALL artt100_rtbc105_ref()
#                     NEXT FIELD CURRENT
#                  END IF
                  #161024-00025#1--mark--e
                  #161024-00025#1--dongsz add--s
                  IF s_aooi500_setpoint(g_prog,'rtbc105') THEN
                     CALL s_aooi500_chk(g_prog,'rtbc105',g_rtbc_m.rtbc105,g_rtbc_m.rtbcsite)
                        RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = l_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        LET g_rtbc_m.rtbc105 = g_rtbc_m_t.rtbc105
                        CALL artt100_rtbc105_ref()
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_rtbc_m.rtbc105
#                     LET g_chkparam.arg2 = 'F'
                     IF NOT cl_chk_exist("v_ooef001_35") THEN
                        LET g_rtbc_m.rtbc105 = g_rtbc_m_t.rtbc105
                        CALL artt100_rtbc105_ref()
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #161024-00025#1--dongsz add--e
               END IF
            END IF

            CALL artt100_rtbc105_ref()

         BEFORE FIELD rtbc105

         ON CHANGE rtbc105

         BEFORE FIELD rtbc102

         AFTER FIELD rtbc102

         ON CHANGE rtbc102

         BEFORE FIELD rtbc103

         AFTER FIELD rtbc103
         
         ON CHANGE rtbc103

         BEFORE FIELD rtbc100

         AFTER FIELD rtbc100

         ON CHANGE rtbc100

         AFTER FIELD rtbc104
            LET g_rtbc_m.rtbc104_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc104_desc

            IF NOT cl_null(g_rtbc_m.rtbc104) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc104 != g_rtbc_m_t.rtbc104 OR g_rtbc_m_t.rtbc104 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc104 != g_rtbc_m_t.rtbc104 OR cl_null(g_rtbc_m_t.rtbc104))) THEN   #150427-00012#6 20150707 add by beckxie
                  IF NOT s_azzi650_chk_exist('2076',g_rtbc_m.rtbc104) THEN
                     LET g_rtbc_m.rtbc104 = g_rtbc_m_t.rtbc104
                     CALL artt100_rtbc104_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            CALL artt100_rtbc104_ref()

         BEFORE FIELD rtbc104

         ON CHANGE rtbc104

         AFTER FIELD rtbc106
            LET g_rtbc_m.rtbc106_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc106_desc

            IF NOT cl_null(g_rtbc_m.rtbc106) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc106 != g_rtbc_m_t.rtbc106 OR g_rtbc_m_t.rtbc106 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc106 != g_rtbc_m_t.rtbc106 OR cl_null(g_rtbc_m_t.rtbc106))) THEN   #150427-00012#6 20150707 add by beckxie
                  #161024-00025#1--mark-s
#                  INITIALIZE g_chkparam.* TO NULL
#                  LET g_chkparam.arg1 = g_rtbc_m.rtbc106
##                  LET g_chkparam.arg2 = 'F'
#                  IF NOT cl_chk_exist("v_ooef001_35") THEN 
#                     LET g_rtbc_m.rtbc106 = g_rtbc_m_t.rtbc106
#                     CALL artt100_rtbc106_ref()
#                     NEXT FIELD CURRENT
#                  END IF
                  #161024-00025#1--mark-e
                  #161024-00025#1--dongsz add--s
                  IF s_aooi500_setpoint(g_prog,'rtbc106') THEN
                     CALL s_aooi500_chk(g_prog,'rtbc106',g_rtbc_m.rtbc106,g_rtbc_m.rtbcsite)
                        RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = l_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        LET g_rtbc_m.rtbc106 = g_rtbc_m_t.rtbc106
                        CALL artt100_rtbc106_ref()
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_rtbc_m.rtbc106
#                     LET g_chkparam.arg2 = 'F'
                     IF NOT cl_chk_exist("v_ooef001_35") THEN 
                        LET g_rtbc_m.rtbc106 = g_rtbc_m_t.rtbc106
                        CALL artt100_rtbc106_ref()
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #161024-00025#1--dongsz add--e
               END IF
            END IF

            CALL artt100_rtbc106_ref()

         BEFORE FIELD rtbc106

         ON CHANGE rtbc106

         AFTER FIELD rtbc108
            LET g_rtbc_m.rtbc108_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc108_desc

            IF NOT cl_null(g_rtbc_m.rtbc108) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc108 != g_rtbc_m_t.rtbc108 OR g_rtbc_m_t.rtbc108 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc108 != g_rtbc_m_t.rtbc108 OR cl_null(g_rtbc_m_t.rtbc108))) THEN   #150427-00012#6 20150707 add by beckxie
                  CALL artt100_chk_rtbc108()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_rtbc_m.rtbc108
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_rtbc_m.rtbc108 = g_rtbc_m_t.rtbc108
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            CALL artt100_rtbc108_ref()

         BEFORE FIELD rtbc108

         ON CHANGE rtbc108

         BEFORE FIELD rtbc107

         AFTER FIELD rtbc107

         ON CHANGE rtbc107

         BEFORE FIELD rtbc115

         AFTER FIELD rtbc115

         ON CHANGE rtbc115
         
         BEFORE FIELD rtbc116

         AFTER FIELD rtbc116

         ON CHANGE rtbc116
         
         BEFORE FIELD rtbc109

         AFTER FIELD rtbc109
            IF NOT cl_null(g_rtbc_m.rtbc109) THEN
               IF NOT cl_null(g_rtbc_m.rtbc110) THEN
                  IF g_rtbc_m.rtbc110 < g_rtbc_m.rtbc109 THEN
                     LET g_rtbc_m.rtbc109 = g_rtbc_m_t.rtbc109
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'art-00316'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
        #閉店日期不可小於開業日期！  
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

         ON CHANGE rtbc109

         BEFORE FIELD rtbc110

         AFTER FIELD rtbc110
            IF NOT cl_null(g_rtbc_m.rtbc110) THEN
               IF NOT cl_null(g_rtbc_m.rtbc109) THEN
                  IF g_rtbc_m.rtbc110 < g_rtbc_m.rtbc109 THEN
                     LET g_rtbc_m.rtbc110 = g_rtbc_m_t.rtbc110
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'art-00316'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
        #閉店日期不可小於開業日期！  
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

         ON CHANGE rtbc110

         BEFORE FIELD rtbc111

         AFTER FIELD rtbc111
            

            IF NOT cl_ap_chk_Range(g_rtbc_m.rtbc111,"0","0","","","azz-00079",1) THEN
               LET g_rtbc_m.rtbc111 = g_rtbc_m_t.rtbc111
               NEXT FIELD CURRENT
            END IF

         ON CHANGE rtbc111

         BEFORE FIELD rtbc112

         AFTER FIELD rtbc112
            IF NOT cl_ap_chk_Range(g_rtbc_m.rtbc112,"0","0","","","azz-00079",1) THEN
               LET g_rtbc_m.rtbc112 = g_rtbc_m_t.rtbc112
               NEXT FIELD CURRENT
            END IF

         ON CHANGE rtbc112

         BEFORE FIELD rtbc113

         AFTER FIELD rtbc113
            IF NOT cl_ap_chk_Range(g_rtbc_m.rtbc113,"0","0","","","azz-00079",1) THEN
               LET g_rtbc_m.rtbc113 = g_rtbc_m_t.rtbc113
               NEXT FIELD CURRENT
            END IF

         ON CHANGE rtbc113

         BEFORE FIELD rtbc114

         AFTER FIELD rtbc114 
            IF NOT cl_ap_chk_Range(g_rtbc_m.rtbc114,"0","0","","","azz-00079",1) THEN
               LET g_rtbc_m.rtbc114 = g_rtbc_m_t.rtbc114
               NEXT FIELD CURRENT
            END IF

         ON CHANGE rtbc114

         BEFORE FIELD rtbc120

         AFTER FIELD rtbc120
            IF NOT cl_ap_chk_Range(g_rtbc_m.rtbc120,"0","1","100","1","azz-00087",1) THEN
               LET g_rtbc_m.rtbc120 = g_rtbc_m_t.rtbc120
               NEXT FIELD CURRENT
            END IF
            
         ON CHANGE rtbc120

         BEFORE FIELD rtbc121

         AFTER FIELD rtbc121
            IF NOT cl_ap_chk_Range(g_rtbc_m.rtbc121,"0","1","100","1","azz-00087",1) THEN
               LET g_rtbc_m.rtbc121 = g_rtbc_m_t.rtbc121
               NEXT FIELD CURRENT
            END IF
            
            
         ON CHANGE rtbc121

         BEFORE FIELD rtbc122

         AFTER FIELD rtbc122 
            IF NOT cl_ap_chk_Range(g_rtbc_m.rtbc122,"0","1","100","1","azz-00087",1) THEN
               LET g_rtbc_m.rtbc122 = g_rtbc_m_t.rtbc122
               NEXT FIELD CURRENT
            END IF

         ON CHANGE rtbc122

         AFTER FIELD rtbc123
            LET g_rtbc_m.rtbc123_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc123_desc

            IF NOT cl_null(g_rtbc_m.rtbc123) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc123 != g_rtbc_m_t.rtbc123 OR g_rtbc_m_t.rtbc123 IS NULL)) THEN   #150427-00012#6 20150707 add by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc123 != g_rtbc_m_t.rtbc123 OR cl_null(g_rtbc_m_t.rtbc123))) THEN   #150427-00012#6 20150707 add by beckxie
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_rtbc_m.rtbc001
                  LET g_chkparam.arg2 = g_rtbc_m.rtbc123

                  #IF NOT cl_chk_exist("v_inaa001") THEN    #160324-00019#3 s983961--mark 
                  IF NOT cl_chk_exist("v_inaa001_14") THEN  #160324-00019#3 s983961--add 
                     LET g_rtbc_m.rtbc123 = g_rtbc_m_t.rtbc123
                     CALL artt100_rtbc123_ref()
                     NEXT FIELD CURRENT
                  END IF

               END IF
            END IF

            CALL artt100_rtbc123_ref()

         BEFORE FIELD rtbc123

         ON CHANGE rtbc123

         AFTER FIELD rtbc126
            LET g_rtbc_m.rtbc126_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc126_desc

            IF NOT cl_null(g_rtbc_m.rtbc126) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc126 != g_rtbc_m_t.rtbc126 OR cl_null(g_rtbc_m_t.rtbc126))) THEN   #150427-00012#6 20150707 add by beckxie
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_rtbc_m.rtbc001
                  LET g_chkparam.arg2 = g_rtbc_m.rtbc126

                  IF NOT cl_chk_exist("v_inaa001_15") THEN
                     LET g_rtbc_m.rtbc126 = g_rtbc_m_t.rtbc126
                     CALL artt100_rtbc126_ref()
                     NEXT FIELD CURRENT
                  END IF

               END IF
            END IF

            CALL artt100_rtbc126_ref()

         BEFORE FIELD rtbc126

         ON CHANGE rtbc126

         AFTER FIELD rtbc124
            LET g_rtbc_m.rtbc124_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc124_desc

            IF NOT cl_null(g_rtbc_m.rtbc124) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc124 != g_rtbc_m_t.rtbc124 OR g_rtbc_m_t.rtbc124 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc124 != g_rtbc_m_t.rtbc124 OR cl_null(g_rtbc_m_t.rtbc124))) THEN   #150427-00012#6 20150707 add by beckxie
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_chkparam.arg1 = g_rtbc_m.rtbc001
                  LET g_chkparam.arg2 = g_rtbc_m.rtbc124

                  #IF NOT cl_chk_exist("v_inaa001") THEN    #160324-00019#3 s983961--mark 
                  IF NOT cl_chk_exist("v_inaa001_14") THEN  #160324-00019#3 s983961--add 
                     LET g_rtbc_m.rtbc124 = g_rtbc_m_t.rtbc124
                     CALL artt100_rtbc124_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            CALL artt100_rtbc124_ref()

         BEFORE FIELD rtbc124

         ON CHANGE rtbc124

         AFTER FIELD rtbc127
            LET g_rtbc_m.rtbc127_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc127_desc

            IF NOT cl_null(g_rtbc_m.rtbc127) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc124 != g_rtbc_m_t.rtbc124 OR g_rtbc_m_t.rtbc124 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc127 != g_rtbc_m_t.rtbc127 OR cl_null(g_rtbc_m_t.rtbc127))) THEN   #150427-00012#6 20150707 add by beckxie
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_chkparam.arg1 = g_rtbc_m.rtbc001
                  LET g_chkparam.arg2 = g_rtbc_m.rtbc127

                  IF NOT cl_chk_exist("v_inaa001_15") THEN
                     LET g_rtbc_m.rtbc127 = g_rtbc_m_t.rtbc127
                     CALL artt100_rtbc127_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            CALL artt100_rtbc127_ref()

         BEFORE FIELD rtbc127

         ON CHANGE rtbc127
         
         AFTER FIELD rtbc125
            LET g_rtbc_m.rtbc125_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc125_desc

            IF NOT cl_null(g_rtbc_m.rtbc125) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc125 != g_rtbc_m_t.rtbc125 OR g_rtbc_m_t.rtbc125 IS NULL )) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc125 != g_rtbc_m_t.rtbc125 OR cl_null(g_rtbc_m_t.rtbc125) )) THEN   #150427-00012#6 20150707 add by beckxie
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_rtbc_m.rtbc001
                  LET g_chkparam.arg2 = g_rtbc_m.rtbc125

                  #IF NOT cl_chk_exist("v_inaa001") THEN    #160324-00019#3 s983961--mark 
                  IF NOT cl_chk_exist("v_inaa001_14") THEN  #160324-00019#3 s983961--add 
                     LET g_rtbc_m.rtbc125 = g_rtbc_m_t.rtbc125
                     CALL artt100_rtbc125_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            CALL artt100_rtbc125_ref()

         BEFORE FIELD rtbc125

         ON CHANGE rtbc125
         
         #160324-00019#3 s983961--add(S)            
         AFTER FIELD rtbc128
            LET g_rtbc_m.rtbc128_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc128_desc

            IF NOT cl_null(g_rtbc_m.rtbc128) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc128 != g_rtbc_m_t.rtbc128 OR cl_null(g_rtbc_m_t.rtbc128) )) THEN   
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_rtbc_m.rtbc001
                  LET g_chkparam.arg2 = g_rtbc_m.rtbc128

                  IF NOT cl_chk_exist("v_inaa001_15") THEN
                     LET g_rtbc_m.rtbc128 = g_rtbc_m_t.rtbc128
                     CALL artt100_rtbc128_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            CALL artt100_rtbc128_ref()

         BEFORE FIELD rtbc128

         ON CHANGE rtbc128
         #160324-00019#3 s983961--add(E)   
  
         AFTER FIELD rtbc014
            LET g_rtbc_m.rtbc014_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc014_desc
            IF NOT cl_null(g_rtbc_m.rtbc014) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc014 <> g_rtbc_m_t.rtbc014 OR g_rtbc_m_t.rtbc014 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc014 <> g_rtbc_m_t.rtbc014 OR cl_null(g_rtbc_m_t.rtbc014))) THEN   #150427-00012#6 20150707 add by beckxie
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_rtbc_m.rtbc014

                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooal002_10") THEN
                     #檢查失敗時後續處理
                     LET g_rtbc_m.rtbc014 = g_rtbc_m_t.rtbc014
                     CALL artt100_rtbc014_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF

            END IF

            CALL artt100_rtbc014_ref()
            
         BEFORE FIELD rtbc014

         ON CHANGE rtbc014

         AFTER FIELD rtbc016
            LET g_rtbc_m.rtbc016_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc016_desc
            IF NOT cl_null(g_rtbc_m.rtbc016) THEN
               #此段落由子樣板a19產生
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc016 != g_rtbc_m_t.rtbc016 OR g_rtbc_m_t.rtbc016 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc016 != g_rtbc_m_t.rtbc016 OR cl_null(g_rtbc_m_t.rtbc016))) THEN   #150427-00012#6 20150707 add by beckxie
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_rtbc_m.rtbc014
                  LET g_chkparam.arg2 = g_rtbc_m.rtbc016
                  LET g_errshow = TRUE   #160318-00025#14
                  LET g_chkparam.err_str[1] = "aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"    #160318-00025#14  
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooaj002_1") THEN
                     LET g_rtbc_m.rtbc016 = g_rtbc_m_t.rtbc016
                     CALL artt100_rtbc016_ref()
                     NEXT FIELD CURRENT
                  END IF

               END IF
            END IF

            CALL artt100_rtbc016_ref()

         BEFORE FIELD rtbc016

         ON CHANGE rtbc016

         AFTER FIELD rtbc004
            LET g_rtbc_m.rtbc004_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc004_desc
            IF NOT cl_null(g_rtbc_m.rtbc004) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc004 != g_rtbc_m_t.rtbc004 OR g_rtbc_m_t.rtbc004 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc004 != g_rtbc_m_t.rtbc004 OR cl_null(g_rtbc_m_t.rtbc004))) THEN   #150427-00012#6 20150707 add by beckxie
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_rtbc_m.rtbc004
                  LET g_errshow = TRUE   #160318-00025#14
                  LET g_chkparam.err_str[1] = "aoo-00170:sub-01324|aooi073|",cl_get_progname("aooi073",g_lang,"2"),"|:EXEPROGaooi073"    #160318-00025#14
                  LET g_chkparam.err_str[2] = "aoo-00171:sub-01302|aooi073|",cl_get_progname("aooi073",g_lang,"2"),"|:EXEPROGaooi073"    #160318-00025#14
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooal002_3") THEN
                     LET g_rtbc_m.rtbc004 = g_rtbc_m_t.rtbc004
                     CALL artt100_rtbc004_ref()
                     NEXT FIELD CURRENT
                  END IF

               END IF

            END IF

            CALL artt100_rtbc004_ref()

         BEFORE FIELD rtbc004

         ON CHANGE rtbc004

         BEFORE FIELD rtbc005

         AFTER FIELD rtbc005 
            IF NOT cl_null(g_rtbc_m.rtbc005) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc005 != g_rtbc_m_t.rtbc005 OR g_rtbc_m_t.rtbc005 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc005 != g_rtbc_m_t.rtbc005 OR cl_null(g_rtbc_m_t.rtbc005))) THEN   #150427-00012#6 20150707 add by beckxie
                 #SELECT UPPER(g_rtbc_m.rtbc005) INTO g_rtbc_m.rtbc005
                 #  FROM DUAL
                 #DISPLAY BY NAME g_rtbc_m.rtbc005
                 
                  #依參數設定，對輸入值長度判斷
                  LET l_len = 0
                  LET l_len1 = 0
                  LET l_len = cl_get_para(g_enterprise,g_site,'E-COM-0003')
                  LET l_rtbc005 = g_rtbc_m.rtbc005  #轉換成STRING類型
                  LET l_len1 = Length(l_rtbc005)
                  IF l_len1 > l_len THEN            #輸入值大於設定的長度
                     LET l_rtbc005 = l_rtbc005.subString(1,l_len)
                     LET g_rtbc_m.rtbc005 = l_rtbc005
                     DISPLAY BY NAME g_rtbc_m.rtbc005
                  END IF
                  
                  #輸入值不可重複
                  CALL artt100_chk_rtbc005()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_rtbc_m.rtbc005
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_rtbc_m.rtbc005 = g_rtbc_m_t.rtbc005
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
            END IF

         ON CHANGE rtbc005

         AFTER FIELD rtbc015

            LET g_rtbc_m.rtbc015_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc015_desc

            IF NOT cl_null(g_rtbc_m.rtbc015) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc015 != g_rtbc_m_t.rtbc015 OR g_rtbc_m_t.rtbc015 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc015 != g_rtbc_m_t.rtbc015 OR cl_null(g_rtbc_m_t.rtbc015))) THEN   #150427-00012#6 20150707 add by beckxie
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_rtbc_m.rtbc015
                  LET g_errshow = TRUE   #160318-00025#14
                  LET g_chkparam.err_str[1] = "aoo-00128:sub-01302|aooi071|",cl_get_progname("aooi071",g_lang,"2"),"|:EXEPROGaooi071"    #160318-00025#14
                  LET g_chkparam.err_str[2] = "agl-00008:sub-01305|aooi071|",cl_get_progname("aooi071",g_lang,"2"),"|:EXEPROGaooi071"    #160318-00025#14
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooal002_1") THEN
                     LET g_rtbc_m.rtbc015 = g_rtbc_m_t.rtbc015
                     CALL artt100_rtbc015_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF

            END IF

            CALL artt100_rtbc015_ref()

         BEFORE FIELD rtbc015

         ON CHANGE rtbc015

         AFTER FIELD rtbc006
            LET g_rtbc_m.rtbc006_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc016_desc
            IF NOT cl_null(g_rtbc_m.rtbc006) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc006 != g_rtbc_m_t.rtbc006 OR g_rtbc_m_t.rtbc006 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc006 != g_rtbc_m_t.rtbc006 OR cl_null(g_rtbc_m_t.rtbc006))) THEN   #150427-00012#6 20150707 add by beckxie
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_rtbc_m.rtbc006

                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_oocg001") THEN
                     LET g_rtbc_m.rtbc006 = g_rtbc_m_t.rtbc006
                     CALL artt100_rtbc006_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF

            END IF

            CALL artt100_rtbc006_ref()

         BEFORE FIELD rtbc006

         ON CHANGE rtbc006

         AFTER FIELD rtbc018

            LET g_rtbc_m.rtbc018_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc018_desc
            IF NOT cl_null(g_rtbc_m.rtbc018) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc018 != g_rtbc_m_t.rtbc018 OR g_rtbc_m_t.rtbc018 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc018 != g_rtbc_m_t.rtbc018 OR cl_null(g_rtbc_m_t.rtbc018))) THEN   #150427-00012#6 20150707 add by beckxie
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_rtbc_m.rtbc018
                  LET g_errshow = TRUE   #160318-00025#14
                  LET g_chkparam.err_str[1] = "aoo-00160:sub-01302|azzi040|",cl_get_progname("azzi040",g_lang,"2"),"|:EXEPROGazzi040"    #160318-00025#14
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_gzot001") THEN
                     LET g_rtbc_m.rtbc018 = g_rtbc_m_t.rtbc018
                     CALL artt100_rtbc018_ref()
                     NEXT FIELD CURRENT
                  END IF

               END IF
            END IF

            CALL artt100_rtbc018_ref()

         BEFORE FIELD rtbc018

         ON CHANGE rtbc018

         AFTER FIELD rtbc019
            LET g_rtbc_m.rtbc019_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc019_desc
            IF NOT cl_null(g_rtbc_m.rtbc019) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc019 != g_rtbc_m_t.rtbc019 OR g_rtbc_m_t.rtbc019 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc019 != g_rtbc_m_t.rtbc019 OR cl_null(g_rtbc_m_t.rtbc019))) THEN   #150427-00012#6 20150707 add by beckxie
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_rtbc_m.rtbc019

                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooal002_2") THEN
                     LET g_rtbc_m.rtbc019 = g_rtbc_m_t.rtbc019
                     CALL artt100_rtbc019_ref()
                     NEXT FIELD CURRENT
                  END IF

               END IF
            END IF

            CALL artt100_rtbc019_ref()

         BEFORE FIELD rtbc019

         ON CHANGE rtbc019

         BEFORE FIELD rtbc007

         AFTER FIELD rtbc007

         ON CHANGE rtbc007

         BEFORE FIELD rtbc020

         AFTER FIELD rtbc020

         ON CHANGE rtbc020

         BEFORE FIELD rtbc022

         AFTER FIELD rtbc022

         ON CHANGE rtbc022

         AFTER FIELD rtbc008
            LET g_rtbc_m.rtbc008_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc008_desc
            IF NOT cl_null(g_rtbc_m.rtbc008) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc008 != g_rtbc_m_t.rtbc008 OR g_rtbc_m_t.rtbc008 IS NULL )) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc008 != g_rtbc_m_t.rtbc008 OR cl_null(g_rtbc_m_t.rtbc008) )) THEN   #150427-00012#6 20150707 add by beckxie
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_rtbc_m.rtbc008
                  LET g_errshow = TRUE   #160318-00025#14
                  LET g_chkparam.err_str[1] = "aoo-00124:sub-01302|aooi074|",cl_get_progname("aooi074",g_lang,"2"),"|:EXEPROGaooi074"    #160318-00025#14
                  LET g_chkparam.err_str[2] = "aoo-00125:sub-01305|aooi074|",cl_get_progname("aooi074",g_lang,"2"),"|:EXEPROGaooi074"    #160318-00025#14
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooal002_4") THEN
                     LET g_rtbc_m.rtbc008 = g_rtbc_m_t.rtbc008
                     CALL artt100_rtbc008_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF

            END IF

            CALL artt100_rtbc008_ref()

         BEFORE FIELD rtbc008

         ON CHANGE rtbc008

         BEFORE FIELD rtbc010

         AFTER FIELD rtbc010

         ON CHANGE rtbc010

         BEFORE FIELD rtbc011

         AFTER FIELD rtbc011

         ON CHANGE rtbc011

         BEFORE FIELD rtbc013

         AFTER FIELD rtbc013

         ON CHANGE rtbc013

         BEFORE FIELD rtbc023

         AFTER FIELD rtbc023

         ON CHANGE rtbc023

         AFTER FIELD rtbc024
            LET g_rtbc_m.rtbc024_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc024_desc
            IF NOT cl_null(g_rtbc_m.rtbc024) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc024 != g_rtbc_m_t.rtbc024 OR g_rtbc_m_t.rtbc024 IS NULL )) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc024 != g_rtbc_m_t.rtbc024 OR cl_null(g_rtbc_m_t.rtbc024) )) THEN   #150427-00012#6 20150707 add by beckxie
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_rtbc_m.rtbc024			

                  #呼叫檢查存在並帶值的library
                  LET g_errshow = TRUE   #160318-00025#14
                  LET g_chkparam.err_str[1] = "apm-00029:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"    #160318-00025#14
                  IF NOT cl_chk_exist("v_pmaa001_6") THEN
                     LET g_rtbc_m.rtbc024 = g_rtbc_m_t.rtbc024
                     CALL artt100_rtbc024_ref()
                     NEXT FIELD CURRENT
                  END IF

               END IF
            END IF

            CALL artt100_rtbc024_ref() 
            
#            NEXT FIELD oofbstus 

         BEFORE FIELD rtbc024

         ON CHANGE rtbc024

         BEFORE FIELD rtbc025

         AFTER FIELD rtbc025

         ON CHANGE rtbc025
         
         #dongsz--add--str---
         AFTER FIELD rtbc026
            LET g_rtbc_m.rtbc026_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc026_desc
            IF NOT cl_null(g_rtbc_m.rtbc026) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc026 != g_rtbc_m_t.rtbc026 OR g_rtbc_m_t.rtbc026 IS NULL )) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc026 != g_rtbc_m_t.rtbc026 OR cl_null(g_rtbc_m_t.rtbc026) )) THEN   #150427-00012#6 20150707 add by beckxie
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_rtbc_m.rtbc001
                  LET g_chkparam.arg2 = g_rtbc_m.rtbc026	                  

                  #呼叫檢查存在並帶值的library

                  IF NOT cl_chk_exist("v_nmas002_2") THEN
                     LET g_rtbc_m.rtbc026 = g_rtbc_m_t.rtbc026
                     CALL artt100_rtbc026_ref()
                     NEXT FIELD CURRENT
                  END IF

               END IF
            END IF

            CALL artt100_rtbc026_ref() 
            
            NEXT FIELD oofbstus 

         BEFORE FIELD rtbc026

         ON CHANGE rtbc026
         #dongsz--add--end---

         BEFORE FIELD rtbc021

         AFTER FIELD rtbc021

         ON CHANGE rtbc021

         AFTER FIELD rtbc150
            LET g_rtbc_m.rtbc150_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc150_desc

            IF NOT cl_null(g_rtbc_m.rtbc150) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc150 != g_rtbc_m_t.rtbc150 OR g_rtbc_m_t.rtbc150 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc150 != g_rtbc_m_t.rtbc150 OR cl_null(g_rtbc_m_t.rtbc150))) THEN   #150427-00012#6 20150707 add by beckxie
                  IF NOT s_azzi650_chk_exist('2077',g_rtbc_m.rtbc150) THEN
                     LET g_rtbc_m.rtbc150 = g_rtbc_m_t.rtbc150
                     CALL artt100_rtbc150_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            CALL artt100_rtbc150_ref()
            
         BEFORE FIELD rtbc150

         ON CHANGE rtbc150

         AFTER FIELD rtbc151
            LET g_rtbc_m.rtbc151_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc151_desc

            IF NOT cl_null(g_rtbc_m.rtbc151) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc151 != g_rtbc_m_t.rtbc151 OR g_rtbc_m_t.rtbc151 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc151 != g_rtbc_m_t.rtbc151 OR cl_null(g_rtbc_m_t.rtbc151))) THEN   #150427-00012#6 20150707 add by beckxie
                  IF NOT s_azzi650_chk_exist('2078',g_rtbc_m.rtbc151) THEN
                     LET g_rtbc_m.rtbc151 = g_rtbc_m_t.rtbc151
                     CALL artt100_rtbc151_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            CALL artt100_rtbc151_ref()
            
         BEFORE FIELD rtbc151

         ON CHANGE rtbc151

         AFTER FIELD rtbc152
            LET g_rtbc_m.rtbc152_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc152_desc
            IF NOT cl_null(g_rtbc_m.rtbc152) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc152 != g_rtbc_m_t.rtbc152 OR g_rtbc_m_t.rtbc152 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc152 != g_rtbc_m_t.rtbc152 OR cl_null(g_rtbc_m_t.rtbc152))) THEN   #150427-00012#6 20150707 add by beckxie
                  IF NOT s_azzi650_chk_exist('2079',g_rtbc_m.rtbc152) THEN
                     LET g_rtbc_m.rtbc152 = g_rtbc_m_t.rtbc152
                     CALL artt100_rtbc152_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            CALL artt100_rtbc152_ref()

         BEFORE FIELD rtbc152

         ON CHANGE rtbc152

         AFTER FIELD rtbc153
            LET g_rtbc_m.rtbc153_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc153_desc

            IF NOT cl_null(g_rtbc_m.rtbc153) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc153 != g_rtbc_m_t.rtbc153 OR g_rtbc_m_t.rtbc153 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc153 != g_rtbc_m_t.rtbc153 OR cl_null(g_rtbc_m_t.rtbc153))) THEN   #150427-00012#6 20150707 add by beckxie
                 IF NOT s_azzi650_chk_exist('2080',g_rtbc_m.rtbc153) THEN
                     LET g_rtbc_m.rtbc153 = g_rtbc_m_t.rtbc153
                     CALL artt100_rtbc153_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            CALL artt100_rtbc153_ref()

         BEFORE FIELD rtbc153

         ON CHANGE rtbc153

         AFTER FIELD rtbc154
            LET g_rtbc_m.rtbc154_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc154_desc

            IF NOT cl_null(g_rtbc_m.rtbc154) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc154 != g_rtbc_m_t.rtbc154 OR g_rtbc_m_t.rtbc154 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc154 != g_rtbc_m_t.rtbc154 OR cl_null(g_rtbc_m_t.rtbc154))) THEN   #150427-00012#6 20150707 add by beckxie
                  IF NOT s_azzi650_chk_exist('2081',g_rtbc_m.rtbc154) THEN
                     LET g_rtbc_m.rtbc154 = g_rtbc_m_t.rtbc154
                     CALL artt100_rtbc154_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            CALL artt100_rtbc154_ref()

         BEFORE FIELD rtbc154

         ON CHANGE rtbc154

         AFTER FIELD rtbc155
            LET g_rtbc_m.rtbc155_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc155_desc

            IF NOT cl_null(g_rtbc_m.rtbc155) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc155 != g_rtbc_m_t.rtbc155 OR g_rtbc_m_t.rtbc155 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc155 != g_rtbc_m_t.rtbc155 OR cl_null(g_rtbc_m_t.rtbc155))) THEN   #150427-00012#6 20150707 add by beckxie
                  IF NOT s_azzi650_chk_exist('2082',g_rtbc_m.rtbc155) THEN
                     LET g_rtbc_m.rtbc155 = g_rtbc_m_t.rtbc155
                     CALL artt100_rtbc155_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            CALL artt100_rtbc155_ref()

         BEFORE FIELD rtbc155

         ON CHANGE rtbc155

         AFTER FIELD rtbc156
            LET g_rtbc_m.rtbc156_desc = ''
            DISPLAY BY NAME g_rtbc_m.rtbc156_desc
            IF NOT cl_null(g_rtbc_m.rtbc156) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc156 != g_rtbc_m_t.rtbc156 OR g_rtbc_m_t.rtbc156 IS NULL )) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc156 != g_rtbc_m_t.rtbc156 OR cl_null(g_rtbc_m_t.rtbc156) )) THEN   #150427-00012#6 20150707 add by beckxie
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_rtbc_m.rtbc156
                  IF NOT cl_chk_exist("v_dbac001") THEN
                     LET g_rtbc_m.rtbc156 = g_rtbc_m_t.rtbc156
                     LET g_rtbc_m.rtbc156_desc = s_desc_get_dbad002_desc(g_rtbc_m.rtbc156)
                     DISPLAY BY NAME g_rtbc_m.rtbc156,g_rtbc_m.rtbc156_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_rtbc_m.rtbc156_desc = s_desc_get_dbad002_desc(g_rtbc_m.rtbc156)
            DISPLAY BY NAME g_rtbc_m.rtbc156,g_rtbc_m.rtbc156_desc

         BEFORE FIELD rtbc156

         ON CHANGE rtbc156

         AFTER FIELD rtbc157
            LET g_rtbc_m.rtbc157_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc157_desc

            IF NOT cl_null(g_rtbc_m.rtbc157) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc157 != g_rtbc_m_t.rtbc157 OR g_rtbc_m.rtbc157 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc157 != g_rtbc_m_t.rtbc157 OR cl_null(g_rtbc_m.rtbc157))) THEN   #150427-00012#6 20150707 add by beckxie
                  IF NOT s_azzi650_chk_exist('2084',g_rtbc_m.rtbc157) THEN
                     LET g_rtbc_m.rtbc157 = g_rtbc_m_t.rtbc157
                     CALL artt100_rtbc157_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            CALL artt100_rtbc157_ref()
            
         BEFORE FIELD rtbc157

         ON CHANGE rtbc157

         AFTER FIELD rtbc158
            LET g_rtbc_m.rtbc158_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc158_desc

            IF NOT cl_null(g_rtbc_m.rtbc158) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc158 != g_rtbc_m_t.rtbc158 OR g_rtbc_m_t.rtbc158 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc158 != g_rtbc_m_t.rtbc158 OR cl_null(g_rtbc_m_t.rtbc158))) THEN   #150427-00012#6 20150707 add by beckxie
                  IF NOT s_azzi650_chk_exist('2085',g_rtbc_m.rtbc158) THEN
                     LET g_rtbc_m.rtbc158 = g_rtbc_m_t.rtbc158
                     CALL artt100_rtbc158_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            CALL artt100_rtbc158_ref()


         BEFORE FIELD rtbc158

         ON CHANGE rtbc158

         AFTER FIELD rtbc159
            LET g_rtbc_m.rtbc159_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc159_desc

            IF NOT cl_null(g_rtbc_m.rtbc159) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc159 != g_rtbc_m_t.rtbc159 OR g_rtbc_m_t.rtbc159 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc159 != g_rtbc_m_t.rtbc159 OR cl_null(g_rtbc_m_t.rtbc159))) THEN   #150427-00012#6 20150707 add by beckxie
                  IF NOT s_azzi650_chk_exist('2086',g_rtbc_m.rtbc159) THEN
                     LET g_rtbc_m.rtbc159 = g_rtbc_m_t.rtbc159
                     CALL artt100_rtbc159_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            CALL artt100_rtbc159_ref()

         BEFORE FIELD rtbc159

         ON CHANGE rtbc159

         AFTER FIELD rtbc160
            LET g_rtbc_m.rtbc160_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc160_desc

            IF NOT cl_null(g_rtbc_m.rtbc160) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc160 != g_rtbc_m_t.rtbc160 OR g_rtbc_m_t.rtbc160 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc160 != g_rtbc_m_t.rtbc160 OR cl_null(g_rtbc_m_t.rtbc160))) THEN   #150427-00012#6 20150707 add by beckxie
                  IF NOT s_azzi650_chk_exist('2087',g_rtbc_m.rtbc160) THEN
                     LET g_rtbc_m.rtbc160 = g_rtbc_m_t.rtbc160
                     CALL artt100_rtbc160_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            CALL artt100_rtbc160_ref()

         BEFORE FIELD rtbc160

         ON CHANGE rtbc160


         AFTER FIELD rtbc161
            LET g_rtbc_m.rtbc161_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc161_desc

            IF NOT cl_null(g_rtbc_m.rtbc161) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc161 != g_rtbc_m_t.rtbc161 OR g_rtbc_m_t.rtbc161 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc161 != g_rtbc_m_t.rtbc161 OR cl_null(g_rtbc_m_t.rtbc161))) THEN   #150427-00012#6 20150707 add by beckxie
                  IF NOT s_azzi650_chk_exist('2088',g_rtbc_m.rtbc161) THEN
                     LET g_rtbc_m.rtbc161 = g_rtbc_m_t.rtbc161
                     CALL artt100_rtbc161_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            CALL artt100_rtbc161_ref()

         BEFORE FIELD rtbc161

         ON CHANGE rtbc161

         AFTER FIELD rtbc162
            LET g_rtbc_m.rtbc162_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc162_desc

            IF NOT cl_null(g_rtbc_m.rtbc162) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc162 != g_rtbc_m_t.rtbc162 OR g_rtbc_m_t.rtbc162 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc162 != g_rtbc_m_t.rtbc162 OR cl_null(g_rtbc_m_t.rtbc162))) THEN   #150427-00012#6 20150707 add by beckxie
                  IF NOT s_azzi650_chk_exist('2089',g_rtbc_m.rtbc162) THEN
                     LET g_rtbc_m.rtbc162 = g_rtbc_m_t.rtbc162
                     CALL artt100_rtbc162_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            CALL artt100_rtbc162_ref()

         BEFORE FIELD rtbc162

         ON CHANGE rtbc162

         AFTER FIELD rtbc163
            LET g_rtbc_m.rtbc163_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc163_desc

            IF NOT cl_null(g_rtbc_m.rtbc163) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc163 != g_rtbc_m_t.rtbc163 OR g_rtbc_m_t.rtbc163 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc163 != g_rtbc_m_t.rtbc163 OR cl_null(g_rtbc_m_t.rtbc163))) THEN   #150427-00012#6 20150707 add by beckxie
                  IF NOT s_azzi650_chk_exist('2090',g_rtbc_m.rtbc163) THEN
                     LET g_rtbc_m.rtbc163 = g_rtbc_m_t.rtbc163
                     CALL artt100_rtbc163_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            CALL artt100_rtbc163_ref()

         BEFORE FIELD rtbc163

         ON CHANGE rtbc163

         AFTER FIELD rtbc164
            LET g_rtbc_m.rtbc164_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc164_desc

            IF NOT cl_null(g_rtbc_m.rtbc164) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc164 != g_rtbc_m_t.rtbc164 OR g_rtbc_m_t.rtbc164 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc164 != g_rtbc_m_t.rtbc164 OR cl_null(g_rtbc_m_t.rtbc164))) THEN   #150427-00012#6 20150707 add by beckxie
                  IF NOT s_azzi650_chk_exist('2091',g_rtbc_m.rtbc164) THEN
                     LET g_rtbc_m.rtbc164 = g_rtbc_m_t.rtbc164
                     CALL artt100_rtbc164_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            CALL artt100_rtbc164_ref()

         BEFORE FIELD rtbc164

         ON CHANGE rtbc164

         AFTER FIELD rtbc165
            LET g_rtbc_m.rtbc165_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc165_desc

            IF NOT cl_null(g_rtbc_m.rtbc165) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc165 != g_rtbc_m_t.rtbc165 OR g_rtbc_m_t.rtbc165 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc165 != g_rtbc_m_t.rtbc165 OR cl_null(g_rtbc_m_t.rtbc165))) THEN   #150427-00012#6 20150707 add by beckxie
                  IF NOT s_azzi650_chk_exist('2092',g_rtbc_m.rtbc165) THEN
                     LET g_rtbc_m.rtbc165 = g_rtbc_m_t.rtbc165
                     CALL artt100_rtbc165_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            CALL artt100_rtbc165_ref()

         BEFORE FIELD rtbc165

         ON CHANGE rtbc165

         AFTER FIELD rtbc166
            LET g_rtbc_m.rtbc166_desc = ' '
            DISPLAY BY NAME g_rtbc_m.rtbc166_desc

            IF NOT cl_null(g_rtbc_m.rtbc166) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc166 != g_rtbc_m_t.rtbc166 OR g_rtbc_m_t.rtbc166 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbc_m.rtbc166 != g_rtbc_m_t.rtbc166 OR cl_null(g_rtbc_m_t.rtbc166))) THEN   #150427-00012#6 20150707 add by beckxie
                  IF NOT s_azzi650_chk_exist('2093',g_rtbc_m.rtbc166) THEN
                     LET g_rtbc_m.rtbc166 = g_rtbc_m_t.rtbc166
                     CALL artt100_rtbc166_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            CALL artt100_rtbc166_ref()

         BEFORE FIELD rtbc166

         ON CHANGE rtbc166

         BEFORE FIELD rtbc002

         AFTER FIELD rtbc002

         ON CHANGE rtbc002

         BEFORE FIELD rtbc003

         AFTER FIELD rtbc003

         ON CHANGE rtbc003
            #dongsz--add--str---
            CALL artt100_set_entry(p_cmd)
            CALL artt100_set_no_entry(p_cmd)
            IF g_rtbc_m.rtbc003 = 'N' THEN
               IF NOT artt100_chk_rtbc003() THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "art-00400"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  
                  CALL cl_err()
                  LET g_rtbc_m.rtbc003 = g_rtbc_m_t.rtbc003
                  DISPLAY BY NAME g_rtbc_m.rtbc003
                  NEXT FIELD rtbc003
               END IF
               CALL artt100_rtbc017_empty()
            END IF
            #dongsz--add--end---

         BEFORE FIELD rtbc009

         AFTER FIELD rtbc009

         ON CHANGE rtbc009

         BEFORE FIELD rtbc012

         AFTER FIELD rtbc012

         ON CHANGE rtbc012

         BEFORE FIELD rtbcsite

         AFTER FIELD rtbcsite
         #ken---add---str 需求單號：141208-00001 項次：10
            IF NOT cl_null(g_rtbc_m.rtbcsite) THEN
               CALL s_aooi500_chk(g_prog,'rtbcsite',g_rtbc_m.rtbcsite,g_rtbc_m.rtbcsite)
                  RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
            
                  LET g_rtbc_m.rtbcsite = g_rtbc_m_t.rtbcsite
                  CALL s_desc_get_department_desc(g_rtbc_m.rtbcsite)
                     RETURNING g_rtbc_m.rtbcsite_desc
                  DISPLAY BY NAME g_rtbc_m.rtbcsite,g_rtbc_m.rtbcsite_desc
                  NEXT FIELD CURRENT
               END IF
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'axc-00120'
               LET g_errparam.popup  = TRUE
               CALL cl_err()

               LET g_rtbc_m.rtbcsite = g_rtbc_m_t.rtbcsite
               CALL s_desc_get_department_desc(g_rtbc_m.rtbcsite) RETURNING g_rtbc_m.rtbcsite_desc
               DISPLAY BY NAME g_rtbc_m.rtbcsite_desc
               NEXT FIELD CURRENT
            END IF              
            
            LET g_site_flag = TRUE
            CALL artt100_set_entry(p_cmd)
            CALL artt100_set_no_entry(p_cmd)
            CALL s_desc_get_department_desc(g_rtbc_m.rtbcsite)
               RETURNING g_rtbc_m.rtbcsite_desc
            DISPLAY BY NAME g_rtbc_m.rtbcsite,g_rtbc_m.rtbcsite_desc             
            #ken---add---end
            
         ON CHANGE rtbcsite

         ON ACTION controlp INFIELD rtbcunit
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbc_m.rtbcunit             #給予default值
            LET g_qryparam.default2 = "" #g_rtbc_m.ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = g_site
            LET g_qryparam.arg2 = '8'

            CALL q_ooed004_3()                                #呼叫開窗

            LET g_rtbc_m.rtbcunit = g_qryparam.return1
            #LET g_rtbc_m.ooefl003 = g_qryparam.return2
            DISPLAY g_rtbc_m.rtbcunit TO rtbcunit              #
            #DISPLAY g_rtbc_m.ooefl003 TO ooefl003 #說明(簡稱)
            CALL artt100_rtbcunit_ref()
            NEXT FIELD rtbcunit                          #返回原欄位

            #ken---add---s 需求單號：141208-00001 項次：10
         ON ACTION controlp INFIELD rtbcsite
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbc_m.rtbcsite             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #

            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtbcsite',g_rtbc_m.rtbcsite,'i')   #150308-00001#5  By benson add 'i'
            CALL q_ooef001_24()                                #呼叫開窗

            LET g_rtbc_m.rtbcsite = g_qryparam.return1              

            DISPLAY g_rtbc_m.rtbcsite TO rtbcsite              #

            NEXT FIELD rtbcsite                          #返回原欄位
            #ken---add---e 

         ON ACTION controlp INFIELD rtbcdocno
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbc_m.rtbcdocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_ooef004     #參照表編號
            #LET g_qryparam.arg2 = "artt100"     #對應程式代號   #160705-00042#6 160712 by sakura mark
            LET g_qryparam.arg2 = g_prog         #160705-00042#6 160712 by sakura add

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_rtbc_m.rtbcdocno = g_qryparam.return1

            DISPLAY g_rtbc_m.rtbcdocno TO rtbcdocno              #

            NEXT FIELD rtbcdocno                          #返回原欄位
            
         ON ACTION controlp INFIELD rtbc001
            IF g_rtbc_m.rtbc000 = 'U' THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_rtbc_m.rtbc001
               LET g_qryparam.where = " ooef304 = 'Y' AND ooefstus = 'Y' "
               #CALL q_ooef001_15()               #161024-00025#3 mark
               CALL q_ooef001_24()                #161024-00025#3 add
               LET g_rtbc_m.rtbc001 = g_qryparam.return1
               DISPLAY g_rtbc_m.rtbc001 TO rtbc001
               NEXT FIELD rtbc001
            END IF

         ON ACTION controlp INFIELD rtbc017
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtbc_m.rtbc017

#            LET g_qryparam.arg1 = '1'
            #161024-00025#4 -s by 08172
            LET g_qryparam.where = " ooef003='Y'"
            CALL q_ooef001_24()
#            CALL q_ooef001_2()
            #161024-00025#4 -e by 08172
            LET g_rtbc_m.rtbc017 = g_qryparam.return1
            DISPLAY BY NAME g_rtbc_m.rtbc017
            CALL artt100_rtbc017_ref()
            NEXT FIELD rtbc017

         ON ACTION controlp INFIELD rtbc105
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.default1 = g_rtbc_m.rtbc105

#            LET g_qryparam.arg1 = 'F'
            #161024-00025#1--mark--s
#            LET g_qryparam.where = " ooef304 = 'Y'"
#            CALL q_ooef001()
            #161024-00025#1--mark--e
            #161024-00025#1--add--s
            IF s_aooi500_setpoint(g_prog,'rtbc105') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtbc105',g_rtbc_m.rtbcsite,'i') 
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef304 = 'Y'"
               CALL q_ooef001()                         #呼叫開窗
            END IF
            #161024-00025#1--add--e
            LET g_rtbc_m.rtbc105 = g_qryparam.return1
            DISPLAY BY NAME g_rtbc_m.rtbc105
            CALL artt100_rtbc105_ref()
            NEXT FIELD rtbc105

         ON ACTION controlp INFIELD rtbc104
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbc_m.rtbc104             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2076" #
            CALL q_oocq002()                                #呼叫開窗

            LET g_rtbc_m.rtbc104 = g_qryparam.return1

            DISPLAY g_rtbc_m.rtbc104 TO rtbc104              #
            CALL artt100_rtbc104_ref()
            NEXT FIELD rtbc104                          #返回原欄位

         ON ACTION controlp INFIELD rtbc106
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbc_m.rtbc106             #給予default值

            #給予arg
#            LET g_qryparam.arg1 = "F" #
            #161024-00025#1--mark--s
#            LET g_qryparam.where = " ooef304 = 'Y'"
#            CALL q_ooef001()                                #呼叫開窗
            #161024-00025#1--mark--e
            #161024-00025#1--add--s
            IF s_aooi500_setpoint(g_prog,'rtbc106') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtbc106',g_rtbc_m.rtbcsite,'i') 
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef304 = 'Y'"
               CALL q_ooef001()                         #呼叫開窗
            END IF
            #161024-00025#1--add--e

            LET g_rtbc_m.rtbc106 = g_qryparam.return1

            DISPLAY g_rtbc_m.rtbc106 TO rtbc106              #
            CALL artt100_rtbc106_ref()
            NEXT FIELD rtbc106                          #返回原欄位

         ON ACTION controlp INFIELD rtbc108
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtbc_m.rtbc108
            LET g_qryparam.where = "pmaa230 = '1' AND pmaa092 = '1' " #150504-00022#1 Add By Ken 150506
            CALL q_pmaa001_15()
            LET g_rtbc_m.rtbc108 = g_qryparam.return1
            DISPLAY g_rtbc_m.rtbc108 TO rtbc108
            CALL artt100_rtbc108_ref()
            NEXT FIELD rtbc108

         ON ACTION controlp INFIELD rtbc123
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtbc_m.rtbc123
            LET g_qryparam.arg1 = g_rtbc_m.rtbc001
            LET g_qryparam.where = "inaa010 = 'Y' " #160324-00019#3 s983961--add
            CALL q_inaa001_6()
            LET g_rtbc_m.rtbc123 = g_qryparam.return1

            DISPLAY g_rtbc_m.rtbc123 TO rtbc123
            CALL artt100_rtbc123_ref()
            NEXT FIELD rtbc123

         ON ACTION controlp INFIELD rtbc124
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtbc_m.rtbc124
            LET g_qryparam.arg1 = g_rtbc_m.rtbc001
            LET g_qryparam.where = "inaa010 = 'Y' " #160324-00019#3 s983961--add
            CALL q_inaa001_6()
            LET g_rtbc_m.rtbc124 = g_qryparam.return1
            DISPLAY g_rtbc_m.rtbc124 TO rtbc124
            CALL artt100_rtbc124_ref()
            NEXT FIELD rtbc124

         ON ACTION controlp INFIELD rtbc125
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtbc_m.rtbc125
            LET g_qryparam.arg1 = g_rtbc_m.rtbc001
            LET g_qryparam.where = "inaa010 = 'Y' " #160324-00019#3 s983961--add
            CALL q_inaa001_6()
            LET g_rtbc_m.rtbc125 = g_qryparam.return1
            DISPLAY g_rtbc_m.rtbc125 TO rtbc125
            CALL artt100_rtbc125_ref()
            NEXT FIELD rtbc125            
            
         #160324-00019#3 s983961--add(s)   
         ON ACTION controlp INFIELD rtbc126
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtbc_m.rtbc126
            LET g_qryparam.arg1 = g_rtbc_m.rtbc001
            LET g_qryparam.where = "inaa010 = 'N' " 
            CALL q_inaa001_6()
            LET g_rtbc_m.rtbc126 = g_qryparam.return1

            DISPLAY g_rtbc_m.rtbc126 TO rtbc126
            CALL artt100_rtbc126_ref()
            NEXT FIELD rtbc126

         ON ACTION controlp INFIELD rtbc127
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtbc_m.rtbc127
            LET g_qryparam.arg1 = g_rtbc_m.rtbc001
            LET g_qryparam.where = "inaa010 = 'N' " 
            CALL q_inaa001_6()
            LET g_rtbc_m.rtbc127 = g_qryparam.return1
            DISPLAY g_rtbc_m.rtbc127 TO rtbc127
            CALL artt100_rtbc127_ref()
            NEXT FIELD rtbc127

         ON ACTION controlp INFIELD rtbc128
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtbc_m.rtbc128
            LET g_qryparam.arg1 = g_rtbc_m.rtbc001
            LET g_qryparam.where = "inaa010 = 'N' " 
            CALL q_inaa001_6()
            LET g_rtbc_m.rtbc128 = g_qryparam.return1
            DISPLAY g_rtbc_m.rtbc128 TO rtbc128
            CALL artt100_rtbc128_ref()
            NEXT FIELD rtbc128
         #160324-00019#3 s983961--add(e)          

         ON ACTION controlp INFIELD rtbc014
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtbc_m.rtbc014        #給予default值
            #給予arg
            LET g_qryparam.arg1 = "10" #
            CALL q_ooal002_0()                                #呼叫開窗
            LET g_rtbc_m.rtbc014 = g_qryparam.return1
            DISPLAY g_rtbc_m.rtbc014 TO rtbc014             
            CALL artt100_rtbc014_ref()
            NEXT FIELD rtbc014                          #返回原欄位

         ON ACTION controlp INFIELD rtbc016
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtbc_m.rtbc016                  #給予default值
            LET g_qryparam.where = " ooaj001 = '",g_rtbc_m.rtbc014,"' " #幣別參照表編號
            CALL q_ooaj002()                                            #呼叫開窗
            LET g_rtbc_m.rtbc016 = g_qryparam.return1
            DISPLAY g_rtbc_m.rtbc016 TO rtbc016              #
            CALL artt100_rtbc016_ref()
            NEXT FIELD rtbc016                          #返回原欄位

         ON ACTION controlp INFIELD rtbc004
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbc_m.rtbc004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_ooal002_2()                                #呼叫開窗

            LET g_rtbc_m.rtbc004 = g_qryparam.return1

            DISPLAY g_rtbc_m.rtbc004 TO rtbc004              #
            CALL artt100_rtbc004_ref()
            NEXT FIELD rtbc004                          #返回原欄位

         ON ACTION controlp INFIELD rtbc015
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbc_m.rtbc015             #給予default值

            #給予arg

            CALL q_ooal002_3()                                #呼叫開窗

            LET g_rtbc_m.rtbc015 = g_qryparam.return1

            DISPLAY g_rtbc_m.rtbc015 TO rtbc015              #
            CALL artt100_rtbc015_ref()
            NEXT FIELD rtbc015                          #返回原欄位

         ON ACTION controlp INFIELD rtbc006
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbc_m.rtbc006             #給予default值

            #給予arg

            CALL q_oocg001()                                #呼叫開窗

            LET g_rtbc_m.rtbc006 = g_qryparam.return1

            DISPLAY g_rtbc_m.rtbc006 TO rtbc006              #
            CALL artt100_rtbc006_ref()
            NEXT FIELD rtbc006                          #返回原欄位

         ON ACTION controlp INFIELD rtbc018
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtbc_m.rtbc018        #給予default值
            CALL q_gzot001_1()                                #呼叫開窗
            LET g_rtbc_m.rtbc018 = g_qryparam.return1
            DISPLAY g_rtbc_m.rtbc018 TO rtbc018             
            CALL artt100_rtbc018_ref()
            NEXT FIELD rtbc018                          #返回原欄位

         ON ACTION controlp INFIELD rtbc019
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbc_m.rtbc019             #給予default值


            CALL q_ooal002_11()                                #呼叫開窗

            LET g_rtbc_m.rtbc019 = g_qryparam.return1

            DISPLAY g_rtbc_m.rtbc019 TO rtbc019              #
            CALL artt100_rtbc019_ref()
            NEXT FIELD rtbc019                          #返回原欄位

         ON ACTION controlp INFIELD rtbc008
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbc_m.rtbc008             #給予default值

            CALL q_ooal002_5()                                #呼叫開窗

            LET g_rtbc_m.rtbc008 = g_qryparam.return1

            DISPLAY g_rtbc_m.rtbc008 TO rtbc008              #
            CALL artt100_rtbc008_ref()
            NEXT FIELD rtbc008                          #返回原欄位

         ON ACTION controlp INFIELD rtbc024
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbc_m.rtbc024             #給予default值


            #160913-00034#5 -S
            #CALL q_pmaa001()                           #呼叫開窗            
            LET g_qryparam.arg1 = "('1','2','3')"            
            CALL q_pmaa001_1()                          #呼叫開窗
            #160913-00034#5 -E

            LET g_rtbc_m.rtbc024 = g_qryparam.return1

            DISPLAY g_rtbc_m.rtbc024 TO rtbc024              #
            CALL artt100_rtbc024_ref()
            NEXT FIELD rtbc024                          #返回原欄位
            
         #dongsz--add--str---
         ON ACTION controlp INFIELD rtbc026
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbc_m.rtbc026             #給予default值
            LET g_qryparam.default2 = g_rtbc_m.rtbc026_desc        #給予default值
            
            LET g_qryparam.arg1 = g_rtbc_m.rtbc001             #給予default值

            CALL q_nmas002_3()                                #呼叫開窗

            LET g_rtbc_m.rtbc026 = g_qryparam.return1
            LET g_rtbc_m.rtbc026_desc = g_qryparam.return2

            DISPLAY g_rtbc_m.rtbc026 TO rtbc026              #
            DISPLAY g_rtbc_m.rtbc026_desc TO rtbc026_desc
            CALL artt100_rtbc026_ref()
            NEXT FIELD rtbc026                          #返回原欄位
         #dongsz--add--end---

         ON ACTION controlp INFIELD rtbc150
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbc_m.rtbc150             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2077" #


            CALL q_oocq002()                                #呼叫開窗

            LET g_rtbc_m.rtbc150 = g_qryparam.return1

            DISPLAY g_rtbc_m.rtbc150 TO rtbc150              #
            CALL artt100_rtbc150_ref()
            NEXT FIELD rtbc150                          #返回原欄位

         ON ACTION controlp INFIELD rtbc151
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbc_m.rtbc151             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2078" #

            CALL q_oocq002()

            LET g_rtbc_m.rtbc151 = g_qryparam.return1

            DISPLAY g_rtbc_m.rtbc151 TO rtbc151              #
            CALL artt100_rtbc151_ref()
            NEXT FIELD rtbc151                          #返回原欄位
            
         ON ACTION controlp INFIELD rtbc152
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbc_m.rtbc152             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2079" #


            CALL q_oocq002()                                #呼叫開窗

            LET g_rtbc_m.rtbc152 = g_qryparam.return1

            DISPLAY g_rtbc_m.rtbc152 TO rtbc152              #
            CALL artt100_rtbc152_ref()
            NEXT FIELD rtbc152                          #返回原欄位

         ON ACTION controlp INFIELD rtbc153
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbc_m.rtbc153             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2080" #

            CALL q_oocq002()

            LET g_rtbc_m.rtbc153 = g_qryparam.return1

            DISPLAY g_rtbc_m.rtbc153 TO rtbc153              #
            CALL artt100_rtbc153_ref()
            NEXT FIELD rtbc153                          #返回原欄位

         ON ACTION controlp INFIELD rtbc154
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbc_m.rtbc154             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2081" #

            CALL q_oocq002()

            LET g_rtbc_m.rtbc154 = g_qryparam.return1

            DISPLAY g_rtbc_m.rtbc154 TO rtbc154              #
            CALL artt100_rtbc154_ref()
            NEXT FIELD rtbc154                          #返回原欄位

         ON ACTION controlp INFIELD rtbc155
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbc_m.rtbc155             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2082" #

            CALL q_oocq002()

            LET g_rtbc_m.rtbc155 = g_qryparam.return1

            DISPLAY g_rtbc_m.rtbc155 TO rtbc155              #
            CALL artt100_rtbc155_ref()
            NEXT FIELD rtbc155                          #返回原欄位

         ON ACTION controlp INFIELD rtbc156
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbc_m.rtbc156      #給予default值
            CALL q_dbac001()                                #呼叫開窗

            LET g_rtbc_m.rtbc156 = g_qryparam.return1       #將開窗取得的值回傳到變數

            DISPLAY g_rtbc_m.rtbc156 TO rtbc156             #顯示到畫面上
            LET g_rtbc_m.rtbc156_desc = s_desc_get_dbad002_desc(g_rtbc_m.rtbc156)
            DISPLAY BY NAME g_rtbc_m.rtbc156_desc
            NEXT FIELD rtbc156                          #返回原欄位

         ON ACTION controlp INFIELD rtbc157
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbc_m.rtbc157             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2084" #

            CALL q_oocq002()

            LET g_rtbc_m.rtbc157 = g_qryparam.return1

            DISPLAY g_rtbc_m.rtbc157 TO rtbc157              #
            CALL artt100_rtbc157_ref()
            NEXT FIELD rtbc157                          #返回原欄位

         ON ACTION controlp INFIELD rtbc158
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbc_m.rtbc158             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2085" #

            CALL q_oocq002()

            LET g_rtbc_m.rtbc158 = g_qryparam.return1

            DISPLAY g_rtbc_m.rtbc158 TO rtbc158              #
            CALL artt100_rtbc158_ref()
            NEXT FIELD rtbc158                          #返回原欄位

         ON ACTION controlp INFIELD rtbc159
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbc_m.rtbc159             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2086" #

            CALL q_oocq002()

            LET g_rtbc_m.rtbc159 = g_qryparam.return1

            DISPLAY g_rtbc_m.rtbc159 TO rtbc159              #
            CALL artt100_rtbc159_ref()
            NEXT FIELD rtbc159                          #返回原欄位

         ON ACTION controlp INFIELD rtbc160
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbc_m.rtbc160             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2087" #

            CALL q_oocq002()

            LET g_rtbc_m.rtbc160 = g_qryparam.return1

            DISPLAY g_rtbc_m.rtbc160 TO rtbc160              #
            CALL artt100_rtbc160_ref()
            NEXT FIELD rtbc160                          #返回原欄位

         ON ACTION controlp INFIELD rtbc161
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbc_m.rtbc161             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2088" #

            CALL q_oocq002()
            LET g_rtbc_m.rtbc161 = g_qryparam.return1

            DISPLAY g_rtbc_m.rtbc161 TO rtbc161              #
            CALL artt100_rtbc161_ref()
            NEXT FIELD rtbc161                          #返回原欄位

         ON ACTION controlp INFIELD rtbc162
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbc_m.rtbc162             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2089" #

            CALL q_oocq002()

            LET g_rtbc_m.rtbc162 = g_qryparam.return1

            DISPLAY g_rtbc_m.rtbc162 TO rtbc162              #
            CALL artt100_rtbc162_ref()
            NEXT FIELD rtbc162                          #返回原欄位

         ON ACTION controlp INFIELD rtbc163
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbc_m.rtbc163             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2090" #

            CALL q_oocq002()

            LET g_rtbc_m.rtbc163 = g_qryparam.return1

            DISPLAY g_rtbc_m.rtbc163 TO rtbc163              #
            CALL artt100_rtbc163_ref()
            NEXT FIELD rtbc163                          #返回原欄位

         ON ACTION controlp INFIELD rtbc164
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbc_m.rtbc164             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2091" #

            CALL q_oocq002()

            LET g_rtbc_m.rtbc164 = g_qryparam.return1

            DISPLAY g_rtbc_m.rtbc164 TO rtbc164              #
            CALL artt100_rtbc164_ref()
            NEXT FIELD rtbc164                          #返回原欄位


         ON ACTION controlp INFIELD rtbc165
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbc_m.rtbc165             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2092" #

            CALL q_oocq002()

            LET g_rtbc_m.rtbc165 = g_qryparam.return1

            DISPLAY g_rtbc_m.rtbc165 TO rtbc165              #
            CALL artt100_rtbc165_ref()
            NEXT FIELD rtbc165                          #返回原欄位

         ON ACTION controlp INFIELD rtbc166
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbc_m.rtbc166             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2093" #

            CALL q_oocq002()

            LET g_rtbc_m.rtbc166 = g_qryparam.return1

            DISPLAY g_rtbc_m.rtbc166 TO rtbc166              #
            CALL artt100_rtbc166_ref()
            NEXT FIELD rtbc166                          #返回原欄位

         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF

            #CALL cl_showmsg()   #錯誤訊息統整顯示

            IF p_cmd <> "u" THEN
               CALL s_transaction_begin()
               
               #add-point:單頭新增前
               #IF NOT s_aooi200_chk_slip(g_rtbc_m.rtbcunit,'',g_rtbc_m.rtbcdocno,g_prog)  THEN #ken_mark
               IF NOT s_aooi200_chk_slip(g_rtbc_m.rtbcsite,'',g_rtbc_m.rtbcdocno,g_prog)  THEN #ken---add 需求單號：141208-00001 項次：10
                  NEXT FIELD rtbcdocno
               END IF
               #160704-00026#1 20160711 add by beckxie---S
               #備份單據別
               LET l_bkdocno = g_rtbc_m.rtbcdocno
               #160704-00026#1 20160711 add by beckxie---E
               
               #CALL s_aooi200_gen_docno(g_rtbc_m.rtbcunit,g_rtbc_m.rtbcdocno,g_rtbc_m.rtbcdocdt,g_prog) #ken_mark
               CALL s_aooi200_gen_docno(g_rtbc_m.rtbcsite,g_rtbc_m.rtbcdocno,g_rtbc_m.rtbcdocdt,g_prog) #ken---add 需求單號：141208-00001 項次：10
                    RETURNING l_flag,g_rtbc_m.rtbcdocno
               IF NOT l_flag THEN
                  NEXT FIELD rtbcdocno
               END IF
               
               #160704-00026#1 20160711 add by beckxie---S
               #更新開窗維護多語言單號key值 
               UPDATE rtbcl_t SET rtbcldocno = g_rtbc_m.rtbcdocno
                WHERE rtbclent = g_enterprise
                  AND rtbcldocno = l_bkdocno
               LET g_master_multi_table_t.rtbcldocno = g_rtbc_m.rtbcdocno
               #160704-00026#1 20160711 add by beckxie---E
               
               #當申請類別為'U'修改時,有可能會本來就有 聯絡對象識別碼的資料了
               IF cl_null(g_rtbc_m.rtbc012) THEN
                  LET l_success = ''
                  LET l_oofa001 = ''
                  CALL s_aooi350_ins_oofa('1',g_rtbc_m.rtbcdocno,'') RETURNING l_success,g_rtbc_m.rtbc012
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "oofa_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CONTINUE DIALOG
                  END IF
               END IF
               
               IF cl_null(g_rtbc_m.rtbc009) AND g_rtbc_m.rtbc000 = 'I' THEN
                  LET g_rtbc_m.rtbc009 = g_rtbc_m.rtbc010 
               END IF
               LET g_rtbc_m.rtbcunit = g_rtbc_m.rtbcsite #ken---add 需求單號：141208-00001 項次：10
               #end add-point

               INSERT INTO rtbc_t (rtbcent,rtbcunit,rtbcdocdt,rtbcdocno,rtbc000,rtbc001,rtbcstus,
                   rtbc017,rtbc101,rtbc105,rtbc102,rtbc103,rtbc100,rtbc104,rtbc106,rtbc108,rtbc107,
                   rtbc115,rtbc116,rtbc109,rtbc110,rtbc111,rtbc112,rtbc113,rtbc114,rtbc120,rtbc121,rtbc122,
                   rtbc123,rtbc124,rtbc125,
                   rtbc126,rtbc127,rtbc128,   #160324-00019#3 s983961--add 
                   rtbcownid,rtbcowndp,rtbccrtid,rtbccrtdp,rtbccrtdt,rtbcmodid,
                   rtbcmoddt,rtbccnfid,rtbccnfdt,rtbc014,rtbc016,rtbc004,rtbc005,rtbc015,rtbc006,
                   rtbc018,rtbc019,rtbc007,rtbc020,rtbc022,rtbc008,rtbc010,rtbc011,rtbc013,rtbc023,
                   rtbc024,rtbc025,rtbc026,rtbc021,rtbc150,rtbc151,rtbc152,rtbc153,rtbc154,rtbc155,rtbc156,
                   rtbc157,rtbc158,rtbc159,rtbc160,rtbc161,rtbc162,rtbc163,rtbc164,rtbc165,rtbc166,
                   rtbc002,rtbc003,rtbc009,rtbc012,rtbcsite,rtbcacti)
               VALUES (g_enterprise,g_rtbc_m.rtbcunit,g_rtbc_m.rtbcdocdt,g_rtbc_m.rtbcdocno,g_rtbc_m.rtbc000,
                   g_rtbc_m.rtbc001,g_rtbc_m.rtbcstus,g_rtbc_m.rtbc017,g_rtbc_m.rtbc101,g_rtbc_m.rtbc105,
                   g_rtbc_m.rtbc102,g_rtbc_m.rtbc103,g_rtbc_m.rtbc100,g_rtbc_m.rtbc104,g_rtbc_m.rtbc106,
                   g_rtbc_m.rtbc108,g_rtbc_m.rtbc107,g_rtbc_m.rtbc115,g_rtbc_m.rtbc116,g_rtbc_m.rtbc109,g_rtbc_m.rtbc110,
                   g_rtbc_m.rtbc111,g_rtbc_m.rtbc112,g_rtbc_m.rtbc113,g_rtbc_m.rtbc114,g_rtbc_m.rtbc120,
                   g_rtbc_m.rtbc121,g_rtbc_m.rtbc122,g_rtbc_m.rtbc123,g_rtbc_m.rtbc124,g_rtbc_m.rtbc125,
                   g_rtbc_m.rtbc126,g_rtbc_m.rtbc127,g_rtbc_m.rtbc128,   #160324-00019#3 s983961--add 
                   g_rtbc_m.rtbcownid,g_rtbc_m.rtbcowndp,g_rtbc_m.rtbccrtid,g_rtbc_m.rtbccrtdp,g_rtbc_m.rtbccrtdt,
                   g_rtbc_m.rtbcmodid,g_rtbc_m.rtbcmoddt,g_rtbc_m.rtbccnfid,g_rtbc_m.rtbccnfdt,g_rtbc_m.rtbc014,
                   g_rtbc_m.rtbc016,g_rtbc_m.rtbc004,g_rtbc_m.rtbc005,g_rtbc_m.rtbc015,g_rtbc_m.rtbc006,
                   g_rtbc_m.rtbc018,g_rtbc_m.rtbc019,g_rtbc_m.rtbc007,g_rtbc_m.rtbc020,g_rtbc_m.rtbc022,
                   g_rtbc_m.rtbc008,g_rtbc_m.rtbc010,g_rtbc_m.rtbc011,g_rtbc_m.rtbc013,g_rtbc_m.rtbc023,
                   g_rtbc_m.rtbc024,g_rtbc_m.rtbc025,g_rtbc_m.rtbc026,g_rtbc_m.rtbc021,g_rtbc_m.rtbc150,g_rtbc_m.rtbc151,
                   g_rtbc_m.rtbc152,g_rtbc_m.rtbc153,g_rtbc_m.rtbc154,g_rtbc_m.rtbc155,g_rtbc_m.rtbc156,
                   g_rtbc_m.rtbc157,g_rtbc_m.rtbc158,g_rtbc_m.rtbc159,g_rtbc_m.rtbc160,g_rtbc_m.rtbc161,
                   g_rtbc_m.rtbc162,g_rtbc_m.rtbc163,g_rtbc_m.rtbc164,g_rtbc_m.rtbc165,g_rtbc_m.rtbc166,
                   g_rtbc_m.rtbc002,g_rtbc_m.rtbc003,g_rtbc_m.rtbc009,g_rtbc_m.rtbc012,g_rtbc_m.rtbcsite,
                   g_rtbc_m.rtbcacti)

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "rtbc_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CONTINUE DIALOG
               END IF

               #資料多語言用-增/改
               INITIALIZE l_var_keys TO NULL
               INITIALIZE l_field_keys TO NULL
               INITIALIZE l_vars TO NULL
               INITIALIZE l_fields TO NULL
               IF g_rtbc_m.rtbcdocno = g_master_multi_table_t.rtbcldocno AND
                  g_rtbc_m.rtbcl002  = g_master_multi_table_t.rtbcl002   AND
                  g_rtbc_m.rtbcl003  = g_master_multi_table_t.rtbcl003   AND
                  g_rtbc_m.rtbcl004  = g_master_multi_table_t.rtbcl004   THEN
               ELSE
                  LET l_var_keys[01] = g_rtbc_m.rtbcdocno
                  LET l_field_keys[01] = 'rtbcldocno'
                  LET l_var_keys_bak[01] = g_master_multi_table_t.rtbcldocno
                  LET l_var_keys[02] = g_dlang
                  LET l_field_keys[02] = 'rtbcl001'
                  LET l_var_keys_bak[02] = g_dlang
                  LET l_vars[01] = g_rtbc_m.rtbcl002
                  LET l_fields[01] = 'rtbcl002'
                  LET l_vars[02] = g_rtbc_m.rtbcl003
                  LET l_fields[02] = 'rtbcl003'
                  LET l_vars[03] = g_rtbc_m.rtbcl004
                  LET l_fields[03] = 'rtbcl004'
                  LET l_vars[04] = g_enterprise
                  LET l_fields[04] = 'rtbclent'
                  CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'rtbcl_t')
               END IF

               #add-point:單頭新增後
               LET g_pmaa027_d = g_rtbc_m.rtbc012 

               CALL s_transaction_end('Y','0')

               LET g_rtbcdocno_t = g_rtbc_m.rtbcdocno
               
               IF g_rtbc_m.rtbc000 = 'U' THEN
                  CALL artt100_carry_detail()
                  IF NOT cl_null(g_errno) THEN
                     CALL s_transaction_end('N','0')
                     CONTINUE DIALOG
                  END IF
               END IF
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
               
               UPDATE rtbc_t SET (rtbcunit,rtbcdocdt,rtbcdocno,rtbc000,rtbc001,rtbcstus,rtbc017,rtbc101,
                   rtbc105,rtbc102,rtbc103,rtbc100,rtbc104,rtbc106,rtbc108,rtbc107,rtbc115,rtbc116,rtbc109,rtbc110,
                   rtbc111,rtbc112,rtbc113,rtbc114,rtbc120,rtbc121,rtbc122,rtbc123,rtbc124,rtbc125,
                   rtbc126,rtbc127,rtbc128,  #160324-00019#3 s983961--add 
                   rtbcownid,
                   rtbcowndp,rtbccrtid,rtbccrtdp,rtbccrtdt,rtbcmodid,rtbcmoddt,rtbccnfid,rtbccnfdt,rtbc014,
                   rtbc016,rtbc004,rtbc005,rtbc015,rtbc006,rtbc018,rtbc019,rtbc007,rtbc020,rtbc022,rtbc008,
                   rtbc010,rtbc011,rtbc013,rtbc023,rtbc024,rtbc025,rtbc026,rtbc021,rtbc150,rtbc151,rtbc152,rtbc153,
                   rtbc154,rtbc155,rtbc156,rtbc157,rtbc158,rtbc159,rtbc160,rtbc161,rtbc162,rtbc163,rtbc164,
                   rtbc165,rtbc166,rtbc002,rtbc003,rtbc009,rtbc012,rtbcsite,rtbcacti ) = (g_rtbc_m.rtbcunit,g_rtbc_m.rtbcdocdt,
                   g_rtbc_m.rtbcdocno,g_rtbc_m.rtbc000,g_rtbc_m.rtbc001,g_rtbc_m.rtbcstus,g_rtbc_m.rtbc017,
                   g_rtbc_m.rtbc101,g_rtbc_m.rtbc105,g_rtbc_m.rtbc102,g_rtbc_m.rtbc103,g_rtbc_m.rtbc100,
                   g_rtbc_m.rtbc104,g_rtbc_m.rtbc106,g_rtbc_m.rtbc108,g_rtbc_m.rtbc107,g_rtbc_m.rtbc115,g_rtbc_m.rtbc116,
                   g_rtbc_m.rtbc109,g_rtbc_m.rtbc110,g_rtbc_m.rtbc111,g_rtbc_m.rtbc112,g_rtbc_m.rtbc113,
                   g_rtbc_m.rtbc114,g_rtbc_m.rtbc120,g_rtbc_m.rtbc121,g_rtbc_m.rtbc122,g_rtbc_m.rtbc123,
                   g_rtbc_m.rtbc124,g_rtbc_m.rtbc125,
                   g_rtbc_m.rtbc126,g_rtbc_m.rtbc127,g_rtbc_m.rtbc128,   #160324-00019#3 s983961--add 
                   g_rtbc_m.rtbcownid,g_rtbc_m.rtbcowndp,g_rtbc_m.rtbccrtid,
                   g_rtbc_m.rtbccrtdp,g_rtbc_m.rtbccrtdt,g_rtbc_m.rtbcmodid,g_rtbc_m.rtbcmoddt,g_rtbc_m.rtbccnfid,
                   g_rtbc_m.rtbccnfdt,g_rtbc_m.rtbc014,g_rtbc_m.rtbc016,g_rtbc_m.rtbc004,g_rtbc_m.rtbc005,
                   g_rtbc_m.rtbc015,g_rtbc_m.rtbc006,g_rtbc_m.rtbc018,g_rtbc_m.rtbc019,g_rtbc_m.rtbc007,
                   g_rtbc_m.rtbc020,g_rtbc_m.rtbc022,g_rtbc_m.rtbc008,g_rtbc_m.rtbc010,g_rtbc_m.rtbc011,
                   g_rtbc_m.rtbc013,g_rtbc_m.rtbc023,g_rtbc_m.rtbc024,g_rtbc_m.rtbc025,g_rtbc_m.rtbc026,g_rtbc_m.rtbc021,
                   g_rtbc_m.rtbc150,g_rtbc_m.rtbc151,g_rtbc_m.rtbc152,g_rtbc_m.rtbc153,g_rtbc_m.rtbc154,
                   g_rtbc_m.rtbc155,g_rtbc_m.rtbc156,g_rtbc_m.rtbc157,g_rtbc_m.rtbc158,g_rtbc_m.rtbc159,
                   g_rtbc_m.rtbc160,g_rtbc_m.rtbc161,g_rtbc_m.rtbc162,g_rtbc_m.rtbc163,g_rtbc_m.rtbc164,
                   g_rtbc_m.rtbc165,g_rtbc_m.rtbc166,g_rtbc_m.rtbc002,g_rtbc_m.rtbc003,g_rtbc_m.rtbc009,
                   g_rtbc_m.rtbc012,g_rtbc_m.rtbcsite,g_rtbc_m.rtbcacti)
                WHERE rtbcent = g_enterprise AND rtbcdocno = g_rtbcdocno_t #

               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "rtbc_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "rtbc_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                     CALL s_transaction_end('N','0')
                  OTHERWISE

                     #資料多語言用-增/改
                     INITIALIZE l_var_keys TO NULL
                     INITIALIZE l_field_keys TO NULL
                     INITIALIZE l_vars TO NULL
                     INITIALIZE l_fields TO NULL
                     IF g_rtbc_m.rtbcdocno = g_master_multi_table_t.rtbcldocno AND
                     g_rtbc_m.rtbcl002 = g_master_multi_table_t.rtbcl002 AND
                     g_rtbc_m.rtbcl003 = g_master_multi_table_t.rtbcl003 AND
                     g_rtbc_m.rtbcl004 = g_master_multi_table_t.rtbcl004  THEN
                     ELSE
                        LET l_var_keys[01] = g_rtbc_m.rtbcdocno
                        LET l_field_keys[01] = 'rtbcldocno'
                        LET l_var_keys_bak[01] = g_master_multi_table_t.rtbcldocno
                        LET l_var_keys[02] = g_dlang
                        LET l_field_keys[02] = 'rtbcl001'
                        LET l_var_keys_bak[02] = g_dlang
                        LET l_vars[01] = g_rtbc_m.rtbcl002
                        LET l_fields[01] = 'rtbcl002'
                        LET l_vars[02] = g_rtbc_m.rtbcl003
                        LET l_fields[02] = 'rtbcl003'
                        LET l_vars[03] = g_rtbc_m.rtbcl004
                        LET l_fields[03] = 'rtbcl004'
                        LET l_vars[04] = g_enterprise
                        LET l_fields[04] = 'rtbclent'
                        CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'rtbcl_t')
                     END IF
                     
                     IF g_rtbc_m.rtbc000 = 'U' THEN
                        CALL artt100_carry_detail()
                        IF NOT cl_null(g_errno) THEN
                           CALL s_transaction_end('N','0')
                           CONTINUE DIALOG
                        END IF
                     END IF
                     CALL s_transaction_end('Y','0')
               END CASE
            END IF
            IF NOT cl_null(g_rtbc_m.rtbc012) THEN
               LET g_pmaa027_d = g_rtbc_m.rtbc012
               CALL aooi350_01_b_fill(g_pmaa027_d)
               CALL aooi350_02_b_fill(g_pmaa027_d)
            END IF
            
      END INPUT

      SUBDIALOG aoo_aooi350_01.aooi350_01_input
      SUBDIALOG aoo_aooi350_02.aooi350_02_input

      BEFORE DIALOG
         #為了修改功能doubleClick可以直接進入單身,需指定要進入哪一個單身
         IF NOT cl_null(p_cmd) AND p_cmd != 'a' THEN
            CASE g_aw
               WHEN "s_detail1_aooi350_01"
                  NEXT FIELD oofbstus
               WHEN "s_detail1_aooi350_02"
                  NEXT FIELD oofcstus
            END CASE
         END IF

         IF p_cmd = 'a' THEN
            NEXT FIELD rtbc001
         ELSE
           #CASE g_aw
           #   WHEN "s_detail1"
           #      NEXT FIELD pmae002
           #END CASE
         END IF

     AFTER DIALOG 
         CALL s_transaction_begin()
         CALL artt100_upd_rtbc156()
         CALL s_transaction_end('Y',0)
         
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name, g_fld_name, g_lang)

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

END FUNCTION

PRIVATE FUNCTION artt100_reproduce()
   DEFINE l_newno     LIKE rtbc_t.rtbcdocno
   DEFINE l_oldno     LIKE rtbc_t.rtbcdocno

   DEFINE l_master    RECORD LIKE rtbc_t.*
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_doctype     LIKE rtai_t.rtai004
   DEFINE l_insert    LIKE type_t.num5 #ken---add 需求單號：141208-00001 項次：10
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF

   IF g_rtbc_m.rtbcdocno IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

   LET g_rtbcdocno_t = g_rtbc_m.rtbcdocno


   LET g_rtbc_m.rtbcdocno = ""


   CALL artt100_set_entry("a")
   CALL artt100_set_no_entry("a")

   #公用欄位給予預設值
   #此段落由子樣板a14產生
   LET g_rtbc_m.rtbcownid = g_user
   LET g_rtbc_m.rtbcowndp = g_dept
   LET g_rtbc_m.rtbccrtid = g_user
   LET g_rtbc_m.rtbccrtdp = g_dept
   LET g_rtbc_m.rtbccrtdt = cl_get_current()
   LET g_rtbc_m.rtbcmodid = ""
   LET g_rtbc_m.rtbcmoddt = ""
   #LET g_rtbc_m.rtbcstus = ""
  
   LET g_rtbc_m.rtbc001 = ''
   LET g_rtbc_m.rtbc005 = ''
   CALL artt100_get_ooef004()
   LET g_rtbc_m.rtbc000 = 'I'
   LET g_rtbc_m.rtbcstus = 'N'
   LET g_rtbc_m.rtbccnfid = ''
   LET g_rtbc_m.rtbccnfdt = ''
   LET g_rtbc_m.rtbcdocdt = g_today
   #LET g_rtbc_m.rtbcunit = g_site
   #CALL artt100_rtbcunit_ref()
   #LET g_rtbc_m.rtbcsite = g_site
   
   #ken---add---str 需求單號：141208-00001 項次：10
   CALL s_aooi500_default(g_prog,'rtbcsite',g_rtbc_m.rtbcsite)
      RETURNING l_insert,g_rtbc_m.rtbcsite
   IF NOT l_insert THEN
      RETURN
   END IF
   CALL artt100_rtbcsite_ref()
   #ken---add---end   
   
   LET r_success = ''
   LET r_doctype = ''
   CALL s_arti200_get_def_doc_type(g_rtbc_m.rtbcunit,g_prog,'1')
        RETURNING r_success,r_doctype
   LET g_rtbc_m.rtbcdocno = r_doctype

   LET g_rtbc_m.rtbcacti = 'Y'
   LET g_rtbc_m.rtbc012= ''
   
   INITIALIZE g_pmaa027_d TO NULL
   CALL aooi350_01_clear_detail()
   CALL aooi350_02_clear_detail()
   LET g_rtbc_m_t.* = g_rtbc_m.*
   LET g_rtbc_m_o.* = g_rtbc_m.*

   CALL artt100_input("r")



   IF INT_FLAG  THEN
      LET INT_FLAG = 0
      RETURN
   END IF

   CALL s_transaction_begin()

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "rtbc_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CALL s_transaction_end('N','0')
      RETURN
   END IF

   CALL s_transaction_end('Y','0')

   LET g_state = "Y"

   LET g_wc = g_wc,
              " OR (",
              " rtbcdocno = '", g_rtbc_m.rtbcdocno CLIPPED, "' "

              , ") "

   LET g_rtbcdocno_t = g_rtbc_m.rtbcdocno

END FUNCTION

PRIVATE FUNCTION artt100_show()
   LET g_rtbc_m_t.* = g_rtbc_m.*      #保存單頭舊值
   LET g_rtbc_m_o.* = g_rtbc_m.*

   #在browser 移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()

   #帶出公用欄位reference值
   #此段落由子樣板a12產生
      #LET g_rtbc_m.rtbcownid_desc = cl_get_username(g_rtbc_m.rtbcownid)
      #LET g_rtbc_m.rtbcowndp_desc = cl_get_deptname(g_rtbc_m.rtbcowndp)
      #LET g_rtbc_m.rtbccrtid_desc = cl_get_username(g_rtbc_m.rtbccrtid)
      #LET g_rtbc_m.rtbccrtdp_desc = cl_get_deptname(g_rtbc_m.rtbccrtdp)
      #LET g_rtbc_m.rtbcmodid_desc = cl_get_username(g_rtbc_m.rtbcmodid)
      #LET g_rtbc_m.rtbccnfid_desc = cl_get_deptname(g_rtbc_m.rtbccnfid)
      ##LET g_rtbc_m.rtbcpstid_desc = cl_get_deptname(g_rtbc_m.rtbcpstid)




   #讀入ref值(單頭)
   #add-point:show段reference

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbcdocno
   CALL ap_ref_array2(g_ref_fields," SELECT rtbcl002,rtbcl003,rtbcl004 FROM rtbcl_t WHERE rtbclent = '"||g_enterprise||"' AND rtbcldocno = ? AND rtbcl001 = '"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtbc_m.rtbcl002 = g_rtn_fields[1]
   LET g_rtbc_m.rtbcl003 = g_rtn_fields[2]
   LET g_rtbc_m.rtbcl004 = g_rtn_fields[3]
   DISPLAY g_rtbc_m.rtbcl002,g_rtbc_m.rtbcl003,g_rtbc_m.rtbcl004 TO rtbcl002,rtbcl003,rtbcl004

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbcownid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_rtbc_m.rtbcownid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbcownid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbcowndp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtbc_m.rtbcowndp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbcowndp_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbccrtid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_rtbc_m.rtbccrtid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbccrtid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbccrtdp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtbc_m.rtbccrtdp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbccrtdp_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbcmodid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_rtbc_m.rtbcmodid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbcmodid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbccnfid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_rtbc_m.rtbccnfid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbccnfid_desc

   CALL artt100_rtbcsite_ref() #ken---add 需求單號：141208-00001 項次：10
   CALL artt100_rtbcunit_ref()
   CALL artt100_rtbc017_ref()
   CALL artt100_rtbc014_ref()
   CALL artt100_rtbc016_ref()
   CALL artt100_rtbc004_ref()
   CALL artt100_rtbc015_ref()
   CALL artt100_rtbc006_ref()
   CALL artt100_rtbc018_ref()
   CALL artt100_rtbc019_ref()
   CALL artt100_rtbc008_ref()
   CALL artt100_rtbc024_ref()
   CALL artt100_rtbc026_ref()
   
   CALL artt100_rtbc105_ref()
   CALL artt100_rtbc104_ref()
   CALL artt100_rtbc106_ref()
   CALL artt100_rtbc108_ref()
   CALL artt100_rtbc123_ref()
   CALL artt100_rtbc124_ref()
   CALL artt100_rtbc125_ref()   
   CALL artt100_rtbc126_ref()   #160324-00019#3 s983961--add(s)
   CALL artt100_rtbc127_ref()
   CALL artt100_rtbc128_ref()   #160324-00019#3 s983961--add(e)       
   CALL artt100_rtbc150_ref()
   CALL artt100_rtbc151_ref()
   CALL artt100_rtbc152_ref()
   CALL artt100_rtbc153_ref()
   CALL artt100_rtbc154_ref()
   CALL artt100_rtbc155_ref()
   CALL artt100_rtbc156_ref()
   CALL artt100_rtbc157_ref()
   CALL artt100_rtbc158_ref()
   CALL artt100_rtbc159_ref()
   CALL artt100_rtbc160_ref()
   CALL artt100_rtbc161_ref()
   CALL artt100_rtbc162_ref()
   CALL artt100_rtbc163_ref()
   CALL artt100_rtbc164_ref()
   CALL artt100_rtbc165_ref()
   CALL artt100_rtbc166_ref()

   #將資料輸出到畫面上
   DISPLAY BY NAME g_rtbc_m.rtbcunit,g_rtbc_m.rtbcunit_desc,g_rtbc_m.rtbcdocdt,g_rtbc_m.rtbcdocno,g_rtbc_m.rtbc000,
       g_rtbc_m.rtbc001,g_rtbc_m.rtbcl002,g_rtbc_m.rtbcl003,g_rtbc_m.rtbcl004,g_rtbc_m.rtbcstus,g_rtbc_m.rtbc017,
       g_rtbc_m.rtbc017_desc,g_rtbc_m.rtbc101,g_rtbc_m.rtbc105,g_rtbc_m.rtbc105_desc,g_rtbc_m.rtbc102,
       g_rtbc_m.rtbc103,g_rtbc_m.rtbc100,g_rtbc_m.rtbc104,g_rtbc_m.rtbc104_desc,g_rtbc_m.rtbc106,g_rtbc_m.rtbc106_desc,
       g_rtbc_m.rtbc108,g_rtbc_m.rtbc108_desc,g_rtbc_m.rtbc107,g_rtbc_m.rtbc115,g_rtbc_m.rtbc116,g_rtbc_m.rtbc109,g_rtbc_m.rtbc110,
       g_rtbc_m.rtbc111,g_rtbc_m.rtbc112,g_rtbc_m.rtbc113,g_rtbc_m.rtbc114,g_rtbc_m.rtbc120,g_rtbc_m.rtbc121,
       g_rtbc_m.rtbc122,g_rtbc_m.rtbc123,g_rtbc_m.rtbc123_desc,g_rtbc_m.rtbc124,g_rtbc_m.rtbc124_desc,
       g_rtbc_m.rtbc125,g_rtbc_m.rtbc125_desc,
       g_rtbc_m.rtbc126,g_rtbc_m.rtbc126_desc,g_rtbc_m.rtbc127,g_rtbc_m.rtbc127_desc,g_rtbc_m.rtbc128,g_rtbc_m.rtbc128_desc,   #160324-00019#3 s983961--add 
       g_rtbc_m.rtbcownid,g_rtbc_m.rtbcownid_desc,g_rtbc_m.rtbcowndp,
       g_rtbc_m.rtbcowndp_desc,g_rtbc_m.rtbccrtid,g_rtbc_m.rtbccrtid_desc,g_rtbc_m.rtbccrtdp,g_rtbc_m.rtbccrtdp_desc,
       g_rtbc_m.rtbccrtdt,g_rtbc_m.rtbcmodid,g_rtbc_m.rtbcmodid_desc,g_rtbc_m.rtbcmoddt,g_rtbc_m.rtbccnfid,
       g_rtbc_m.rtbccnfid_desc,g_rtbc_m.rtbccnfdt,g_rtbc_m.rtbc014,g_rtbc_m.rtbc014_desc,g_rtbc_m.rtbc016,
       g_rtbc_m.rtbc016_desc,g_rtbc_m.rtbc004,g_rtbc_m.rtbc004_desc,g_rtbc_m.rtbc005,g_rtbc_m.rtbc015,
       g_rtbc_m.rtbc015_desc,g_rtbc_m.rtbc006,g_rtbc_m.rtbc006_desc,g_rtbc_m.rtbc018,g_rtbc_m.rtbc018_desc,
       g_rtbc_m.rtbc019,g_rtbc_m.rtbc019_desc,g_rtbc_m.rtbc007,g_rtbc_m.rtbc020,g_rtbc_m.rtbc022,g_rtbc_m.rtbc008,
       g_rtbc_m.rtbc008_desc,g_rtbc_m.rtbc010,g_rtbc_m.rtbc011,g_rtbc_m.rtbc013,g_rtbc_m.rtbc023,g_rtbc_m.rtbc024,
       g_rtbc_m.rtbc024_desc,g_rtbc_m.rtbc025,g_rtbc_m.rtbc026,g_rtbc_m.rtbc026_desc,g_rtbc_m.rtbc021,g_rtbc_m.rtbc150,g_rtbc_m.rtbc150_desc,
       g_rtbc_m.rtbc151,g_rtbc_m.rtbc151_desc,g_rtbc_m.rtbc152,g_rtbc_m.rtbc152_desc,g_rtbc_m.rtbc153,
       g_rtbc_m.rtbc153_desc,g_rtbc_m.rtbc154,g_rtbc_m.rtbc154_desc,g_rtbc_m.rtbc155,g_rtbc_m.rtbc155_desc,
       g_rtbc_m.rtbc156,g_rtbc_m.rtbc156_desc,g_rtbc_m.rtbc157,g_rtbc_m.rtbc157_desc,g_rtbc_m.rtbc158,
       g_rtbc_m.rtbc158_desc,g_rtbc_m.rtbc159,g_rtbc_m.rtbc159_desc,g_rtbc_m.rtbc160,g_rtbc_m.rtbc160_desc,
       g_rtbc_m.rtbc161,g_rtbc_m.rtbc161_desc,g_rtbc_m.rtbc162,g_rtbc_m.rtbc162_desc,g_rtbc_m.rtbc163,
       g_rtbc_m.rtbc163_desc,g_rtbc_m.rtbc164,g_rtbc_m.rtbc164_desc,g_rtbc_m.rtbc165,g_rtbc_m.rtbc165_desc,
       g_rtbc_m.rtbc166,g_rtbc_m.rtbc166_desc,g_rtbc_m.rtbc002,g_rtbc_m.rtbc003,g_rtbc_m.rtbc009,g_rtbc_m.rtbc012,
       g_rtbc_m.rtbcsite,g_rtbc_m.rtbcacti

   #顯示狀態(stus)圖片
         #此段落由子樣板a21產生
      CASE g_rtbc_m.rtbcstus
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")         
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")   
      END CASE


   IF NOT cl_null(g_rtbc_m.rtbc012) THEN
      LET g_pmaa027_d = g_rtbc_m.rtbc012
      CALL aooi350_01_b_fill(g_pmaa027_d)
      CALL aooi350_02_b_fill(g_pmaa027_d)
   END IF

END FUNCTION

PRIVATE FUNCTION artt100_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING


   IF g_rtbc_m.rtbcdocno IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF
   
   #檢查是否允許此動作
   IF NOT artt100_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   CALL artt100_show()

   CALL s_transaction_begin()

   LET g_rtbcdocno_t = g_rtbc_m.rtbcdocno


   LET g_master_multi_table_t.rtbcldocno = g_rtbc_m.rtbcdocno
LET g_master_multi_table_t.rtbcl002 = g_rtbc_m.rtbcl002
LET g_master_multi_table_t.rtbcl003 = g_rtbc_m.rtbcl003
LET g_master_multi_table_t.rtbcl004 = g_rtbc_m.rtbcl004


   OPEN artt100_cl USING g_enterprise,
                           g_rtbc_m.rtbcdocno

   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN artt100_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE artt100_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   FETCH artt100_cl INTO g_rtbc_m.rtbcunit,g_rtbc_m.rtbcunit_desc,g_rtbc_m.rtbcdocdt,g_rtbc_m.rtbcdocno,
       g_rtbc_m.rtbc000,g_rtbc_m.rtbc001,g_rtbc_m.rtbcl002,g_rtbc_m.rtbcl003,g_rtbc_m.rtbcl004,g_rtbc_m.rtbcstus,
       g_rtbc_m.rtbc017,g_rtbc_m.rtbc017_desc,g_rtbc_m.rtbc101,g_rtbc_m.rtbc105,g_rtbc_m.rtbc105_desc,
       g_rtbc_m.rtbc102,g_rtbc_m.rtbc103,g_rtbc_m.rtbc100,g_rtbc_m.rtbc104,g_rtbc_m.rtbc104_desc,g_rtbc_m.rtbc106,
       g_rtbc_m.rtbc106_desc,g_rtbc_m.rtbc108,g_rtbc_m.rtbc108_desc,g_rtbc_m.rtbc107,g_rtbc_m.rtbc115,g_rtbc_m.rtbc116,
       g_rtbc_m.rtbc109,g_rtbc_m.rtbc110,g_rtbc_m.rtbc111,g_rtbc_m.rtbc112,g_rtbc_m.rtbc113,g_rtbc_m.rtbc114,
       g_rtbc_m.rtbc120,g_rtbc_m.rtbc121,g_rtbc_m.rtbc122,g_rtbc_m.rtbc123,g_rtbc_m.rtbc123_desc,g_rtbc_m.rtbc124,
       g_rtbc_m.rtbc124_desc,g_rtbc_m.rtbc125,g_rtbc_m.rtbc125_desc,
       g_rtbc_m.rtbc126,g_rtbc_m.rtbc126_desc,g_rtbc_m.rtbc127,g_rtbc_m.rtbc127_desc,g_rtbc_m.rtbc128,g_rtbc_m.rtbc128_desc,   #160324-00019#3 s983961--add  
       g_rtbc_m.rtbcownid,g_rtbc_m.rtbcownid_desc,
       g_rtbc_m.rtbcowndp,g_rtbc_m.rtbcowndp_desc,g_rtbc_m.rtbccrtid,g_rtbc_m.rtbccrtid_desc,g_rtbc_m.rtbccrtdp,
       g_rtbc_m.rtbccrtdp_desc,g_rtbc_m.rtbccrtdt,g_rtbc_m.rtbcmodid,g_rtbc_m.rtbcmodid_desc,g_rtbc_m.rtbcmoddt,
       g_rtbc_m.rtbccnfid,g_rtbc_m.rtbccnfid_desc,g_rtbc_m.rtbccnfdt,g_rtbc_m.rtbc014,g_rtbc_m.rtbc014_desc,
       g_rtbc_m.rtbc016,g_rtbc_m.rtbc016_desc,g_rtbc_m.rtbc004,g_rtbc_m.rtbc004_desc,g_rtbc_m.rtbc005,
       g_rtbc_m.rtbc015,g_rtbc_m.rtbc015_desc,g_rtbc_m.rtbc006,g_rtbc_m.rtbc006_desc,g_rtbc_m.rtbc018,
       g_rtbc_m.rtbc018_desc,g_rtbc_m.rtbc019,g_rtbc_m.rtbc019_desc,g_rtbc_m.rtbc007,g_rtbc_m.rtbc020,
       g_rtbc_m.rtbc022,g_rtbc_m.rtbc008,g_rtbc_m.rtbc008_desc,g_rtbc_m.rtbc010,g_rtbc_m.rtbc011,g_rtbc_m.rtbc013,
       g_rtbc_m.rtbc023,g_rtbc_m.rtbc024,g_rtbc_m.rtbc024_desc,g_rtbc_m.rtbc025,g_rtbc_m.rtbc026,g_rtbc_m.rtbc026_desc,g_rtbc_m.rtbc021,g_rtbc_m.rtbc150,
       g_rtbc_m.rtbc150_desc,g_rtbc_m.rtbc151,g_rtbc_m.rtbc151_desc,g_rtbc_m.rtbc152,g_rtbc_m.rtbc152_desc,
       g_rtbc_m.rtbc153,g_rtbc_m.rtbc153_desc,g_rtbc_m.rtbc154,g_rtbc_m.rtbc154_desc,g_rtbc_m.rtbc155,
       g_rtbc_m.rtbc155_desc,g_rtbc_m.rtbc156,g_rtbc_m.rtbc156_desc,g_rtbc_m.rtbc157,g_rtbc_m.rtbc157_desc,
       g_rtbc_m.rtbc158,g_rtbc_m.rtbc158_desc,g_rtbc_m.rtbc159,g_rtbc_m.rtbc159_desc,g_rtbc_m.rtbc160,
       g_rtbc_m.rtbc160_desc,g_rtbc_m.rtbc161,g_rtbc_m.rtbc161_desc,g_rtbc_m.rtbc162,g_rtbc_m.rtbc162_desc,
       g_rtbc_m.rtbc163,g_rtbc_m.rtbc163_desc,g_rtbc_m.rtbc164,g_rtbc_m.rtbc164_desc,g_rtbc_m.rtbc165,
       g_rtbc_m.rtbc165_desc,g_rtbc_m.rtbc166,g_rtbc_m.rtbc166_desc,g_rtbc_m.rtbc002,g_rtbc_m.rtbc003,
       g_rtbc_m.rtbc009,g_rtbc_m.rtbc012,g_rtbc_m.rtbcsite
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_rtbc_m.rtbcdocno
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

   IF cl_ask_delete() THEN

      #刪除相關文件
      CALL g_pk_array.clear()
      LET g_pk_array[1].values = g_rtbc_m.rtbcdocno
      LET g_pk_array[1].column = 'rtbcdocno'

      CALL cl_doc_remove()

      DELETE FROM rtbc_t
       WHERE rtbcent = g_enterprise AND rtbcdocno = g_rtbc_m.rtbcdocno


      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "rtbc_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
      END IF

      INITIALIZE l_var_keys_bak TO NULL
      INITIALIZE l_field_keys   TO NULL
      LET l_var_keys_bak[01] = g_master_multi_table_t.rtbcldocno
      LET l_field_keys[01] = 'rtbcldocno'
      LET l_var_keys_bak[02] = g_dlang
      LET l_field_keys[02] = 'rtbcl001'
      CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'rtbcl_t')

      IF g_rtbc_m.rtbc000 = 'I' AND NOT cl_null(g_rtbc_m.rtbc012) THEN
         IF NOT s_aooi350_del(g_rtbc_m.rtbc012) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "oofa_t"
            LET g_errparam.popup = FALSE
            CALL cl_err()

            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
      
      IF NOT s_aooi200_del_docno(g_rtbc_m.rtbcdocno,g_rtbc_m.rtbcdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF

      CLEAR FORM
      CALL artt100_ui_browser_refresh()
      IF g_browser_cnt > 0 THEN
         CALL artt100_fetch("P")
      ELSE
         CALL artt100_browser_fill(" 1=1 ","F")
      END IF

   END IF

   CLOSE artt100_cl
   CALL s_transaction_end('Y','0')

   #流程通知預埋點-D
   CALL cl_flow_notify(g_rtbc_m.rtbcdocno,"D")

END FUNCTION

PRIVATE FUNCTION artt100_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10

   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_rtbcdocno = g_rtbc_m.rtbcdocno THEN
         CALL g_browser.deleteElement(l_i)
         LET g_header_cnt = g_header_cnt - 1
       END IF
   END FOR

   DISPLAY g_header_cnt TO FORMONLY.b_count     #page count
   DISPLAY g_header_cnt TO FORMONLY.h_count     #page count
   LET g_browser_cnt = g_browser_cnt-1
   IF g_current_idx > g_browser_cnt THEN        #確定browse 筆數指在同一筆
      LET g_current_idx = g_browser_cnt
   END IF

END FUNCTION

PRIVATE FUNCTION artt100_set_entry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1


   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("rtbcdocno",TRUE)
      CALL cl_set_comp_entry("rtbcunit,rtbcdocdt",TRUE)
      CALL cl_set_comp_entry("rtbcsite",TRUE)#ken---add 需求單號：141208-00001 項次：10
   END IF
  
   CALL cl_set_comp_entry("rtbcacti",TRUE)
   CALL cl_set_comp_entry("rtbc123,rtbc124,rtbc125",TRUE)
   CALL cl_set_comp_entry("rtbc126,rtbc127,rtbc128",TRUE)    #160324-00019#3 s983961--add   
   CALL cl_set_comp_entry("rtbc022,rtbc017",TRUE)
   CALL cl_set_comp_entry("rtbc002,rtbc007,rtbc020,rtbc021,rtbc022,rtbc011,rtbc013,rtbc023,rtbc014,rtbc016,rtbc015,rtbc006,rtbc018,rtbc019", TRUE)
   CALL cl_set_comp_entry("rtbc156",TRUE)
END FUNCTION

PRIVATE FUNCTION artt100_set_no_entry(p_cmd)
   DEFINE p_cmd       LIKE type_t.chr1
   DEFINE l_n         LIKE type_t.num5
   DEFINE l_ooef012   LIKE ooef_t.ooef012
   
   IF p_cmd = "u" THEN
      CALL cl_set_comp_entry("rtbcdocno",FALSE) 
      CALL cl_set_comp_entry("rtbcunit,rtbcdocdt",FALSE)
      CALL cl_set_comp_entry("rtbcsite",FALSE) #ken---add 需求單號：141208-00001 項次：10
   END IF

   IF g_rtbc_m.rtbc000 = 'I' THEN
      CALL cl_set_comp_entry("rtbc123,rtbc124,rtbc125,rtbcacti",FALSE)
       CALL cl_set_comp_entry("rtbc126,rtbc127,rtbc128",FALSE) #160324-00019#3 s983961--add   
   END IF
   IF g_rtbc_m.rtbc003 = 'Y' THEN
      CALL cl_set_comp_entry("rtbc017",FALSE)
      LET g_rtbc_m.rtbc017 = g_rtbc_m.rtbc001
      DISPLAY BY NAME g_rtbc_m.rtbc017
      LET g_rtbc_m_o.rtbc017 = g_rtbc_m.rtbc017
      CALL artt100_rtbc017_ref()
   ELSE
      CALL cl_set_comp_entry("rtbc022",FALSE)
      CALL cl_set_comp_entry("rtbc002,rtbc007,rtbc020,rtbc021,rtbc022,rtbc011,rtbc013,rtbc023,rtbc014,rtbc016,rtbc015,rtbc006,rtbc018,rtbc019",FALSE)
   END IF
   
   IF g_rtbc_m.rtbc000 = 'I' THEN   
      LET l_ooef012 = g_rtbc_m.rtbc012
   ELSE
      LET l_ooef012 = g_ooef012
   END IF   
   LET l_n = 0 
   SELECT COUNT(*) INTO l_n
     FROM oofb_t
    WHERE oofbent = g_enterprise
      AND oofb002 = l_ooef012
      AND oofb008 = '3'
      AND oofb010 = 'Y'
      AND oofbstus = 'Y'
      AND COALESCE(oofb022,'-1') <> '-1'    #取代IS NOT NULL 的寫法
   IF l_n > 0 THEN
      CALL cl_set_comp_entry("rtbc156",FALSE)
   END IF  
   
   #ken---add---str 需求單號：141208-00001 項次：10
   IF NOT s_aooi500_comp_entry(g_prog,'rtbcsite') OR g_site_flag THEN
      CALL cl_set_comp_entry("rtbcsite",FALSE)
   END IF 
   #ken---add---end
END FUNCTION

PRIVATE FUNCTION artt100_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING

   LET g_pagestart = 1
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " rtbcdocno = '", g_argv[1], "' AND "
   END IF



   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF

END FUNCTION

PRIVATE FUNCTION artt100_statechange()
   DEFINE lc_state LIKE type_t.chr5

   DEFINE l_success     LIKE type_t.num5

   IF g_rtbc_m.rtbcstus != 'N' THEN
      RETURN
   END IF

   ERROR ""     #清空畫面右下側ERROR區塊

   IF g_rtbc_m.rtbcdocno IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF
   
   #檢查是否允許此動作
   IF NOT artt100_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_rtbc_m.rtbcstus
            WHEN "N"
               HIDE OPTION "unconfirmed"           
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "W"
               HIDE OPTION "signing"
            WHEN "X"
               HIDE OPTION "invalid"   
         END CASE
         
         CALL cl_set_act_visible("signing,withdraw",FALSE)

         CASE g_rtbc_m.rtbcstus
            WHEN "N"
               CALL cl_set_act_visible("unconfirmed,HOLD",FALSE)
               #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
               IF cl_bpm_chk() THEN
                   CALL cl_set_act_visible("signing",TRUE)
                   CALL cl_set_act_visible("confirmed",FALSE)
               END IF
          
            WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
               CALL cl_set_act_visible("confirmed,unconfirmed,HOLD",FALSE)
          
            WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
               CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)
          
            WHEN "X"
               CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)
          
            WHEN "Y"
               CALL cl_set_act_visible("invalid,confirmed,hold",FALSE)
          
            WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
               CALL cl_set_act_visible("withdraw",TRUE)
               CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE) 
                
            WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
               CALL cl_set_act_visible("confirmed ",TRUE)
               CALL cl_set_act_visible("unconfirmed,invalid,hold",FALSE)

         END CASE

      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN   #151027-00016#2 20151111 add by beckxie
            LET lc_state = "N"
         END IF   #151027-00016#2 20151111 add by beckxie
         EXIT MENU
         
     
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN   #151027-00016#2 20151111 add by beckxie
            LET lc_state = "Y"
         END IF   #151027-00016#2 20151111 add by beckxie

         EXIT MENU

      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT artt100_send() THEN
              RETURN
            END IF
         END IF
         LET lc_state = 'W'
         EXIT MENU

      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT artt100_draw_out() THEN
               RETURN
            END IF
         END IF
         LET lc_state = 'D'
         EXIT MENU
         
        ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN   #151027-00016#2 20151111 add by beckxie
            LET lc_state = "X"
         END IF   #151027-00016#2 20151111 add by beckxie
         EXIT MENU  
   END MENU

   IF (lc_state <> "Y" AND 
       lc_state <> "N" AND      
       lc_state <> "A" AND 
       lc_state <> "D" AND 
       lc_state <> "R" AND 
       lc_state <> "W" AND
       lc_state <> "X"  
      ) OR
      cl_null(lc_state) THEN
      RETURN
   END IF

   CALL s_transaction_begin()

   IF lc_state = 'Y' THEN
      CALL s_artt100_conf_chk(g_rtbc_m.rtbcdocno) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00108') THEN
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            CALL s_artt100_conf_upd(g_rtbc_m.rtbcdocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               #準備拋轉資料到ooef_t,ooefl_t 
               CALL s_artt100_carry_chk(g_rtbc_m.rtbcdocno) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_artt100_carry_upd(g_rtbc_m.rtbcdocno) RETURNING l_success
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                     RETURN
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF
            END IF
         END IF
      END IF
   END IF

   IF lc_state = 'X' THEN
      CALL s_artt100_void_chk(g_rtbc_m.rtbcdocno) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            CALL s_artt100_void_upd(g_rtbc_m.rtbcdocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
         END IF
      END IF
   END IF

   UPDATE rtbc_t SET rtbcstus = lc_state
    WHERE rtbcent = g_enterprise AND rtbcdocno = g_rtbc_m.rtbcdocno


   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

   ELSE
      CASE lc_state                 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")    
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")    
      END CASE
      LET g_rtbc_m.rtbcstus = lc_state
      DISPLAY BY NAME g_rtbc_m.rtbcstus
   END IF


END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbcunit_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbcunit_ref()
   DEFINE l_ooefl003     LIKE ooefl_t.ooefl003

   LET l_ooefl003 = ''
   SELECT ooefl003 INTO l_ooefl003
     FROM ooefl_t
    WHERE ooeflent = g_enterprise
      AND ooefl001 = g_rtbc_m.rtbcunit
      AND ooefl002 = g_dlang

   LET g_rtbc_m.rtbcunit_desc = l_ooefl003
   DISPLAY BY NAME g_rtbc_m.rtbcunit_desc

END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_get_ooef004()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_get_ooef004()
   DEFINE l_ooef004     LIKE ooef_t.ooef004

   LET l_ooef004 = ''
   SELECT ooef004 INTO l_ooef004
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_rtbc_m.rtbcunit

   LET g_ooef004 = l_ooef004

END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc004_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc004_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbc004
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='3' AND ooall002=? AND ooall003='"||g_dlang||"'",      
                      "")  
        RETURNING g_rtn_fields 
   LET g_rtbc_m.rtbc004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbc004_desc

END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc006_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc006_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbc006
   CALL ap_ref_array2(g_ref_fields, 
                      "SELECT oocgl003 FROM oocgl_t WHERE oocglent='"||g_enterprise||"' AND oocgl001=? AND oocgl002='"||g_dlang||"'",
                      "")  
        RETURNING g_rtn_fields 
   LET g_rtbc_m.rtbc006_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbc006_desc

END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc008_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc008_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbc008
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='4' AND ooall002=? AND ooall003='"||g_dlang||"'",
                      "")
        RETURNING g_rtn_fields
   LET g_rtbc_m.rtbc008_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbc008_desc

END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc014_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc014_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbc014
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='10' AND ooall002=? AND ooall003='"||g_dlang||"'",     
                      "") 
        RETURNING g_rtn_fields 
   LET g_rtbc_m.rtbc014_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbc014_desc

END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc015_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc015_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbc015
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='1' AND ooall002=? AND ooall003='"||g_dlang||"'",      
                      "")  
        RETURNING g_rtn_fields 
   LET g_rtbc_m.rtbc015_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbc015_desc

END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc016_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc016_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbc016
   CALL ap_ref_array2(g_ref_fields, 
                      "SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'",
                      "")  
        RETURNING g_rtn_fields
   LET g_rtbc_m.rtbc016_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbc016_desc

END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc017_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc017_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbc017
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'",
                      "")
        RETURNING g_rtn_fields
   LET g_rtbc_m.rtbc017_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbc017_desc

END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位說明
# Memo...........:
# Usage..........: CALL artt100_rtbc018_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc018_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbc018
   CALL ap_ref_array2(g_ref_fields,"SELECT gzot002 FROM gzot_t WHERE gzot001=? ","")
        RETURNING g_rtn_fields
   LET g_rtbc_m.rtbc018_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbc018_desc

END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc019_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc019_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbc019
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='2' AND ooall002=? AND ooall003='"||g_dlang||"'",
                      "")
        RETURNING g_rtn_fields
   LET g_rtbc_m.rtbc019_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbc019_desc

END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc024_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/07 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc024_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbc024
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'",
                      "")
        RETURNING g_rtn_fields
   LET g_rtbc_m.rtbc024_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbc024_desc
END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc104_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc104_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbc104
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2076' AND oocql002=? AND oocql003='"||g_dlang||"'",   
                      "")  
        RETURNING g_rtn_fields 
   LET g_rtbc_m.rtbc104_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbc104_desc

END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc105_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc105_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbc105
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'",
                      "")
        RETURNING g_rtn_fields
   LET g_rtbc_m.rtbc105_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbc105_desc

END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc106_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc106_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbc106
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'",
                      "")
        RETURNING g_rtn_fields
   LET g_rtbc_m.rtbc106_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbc106_desc

END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc108_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc108_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbc108
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'",
                      "")
        RETURNING g_rtn_fields
   LET g_rtbc_m.rtbc108_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbc108_desc

END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc123_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc123_ref()
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_rtbc_m.rtbc123
#   CALL ap_ref_array2(g_ref_fields,
#                      "SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ",
#                      "")
#        RETURNING g_rtn_fields
#   LET g_rtbc_m.rtbc123_desc = '', g_rtn_fields[1] , ''
#   DISPLAY BY NAME g_rtbc_m.rtbc123_desc
   CALL s_desc_get_stock_desc(g_rtbc_m.rtbc001,g_rtbc_m.rtbc123) RETURNING g_rtbc_m.rtbc123_desc
   DISPLAY BY NAME g_rtbc_m.rtbc123_desc

END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc124_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc124_ref()
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_rtbc_m.rtbc124
#   CALL ap_ref_array2(g_ref_fields,
#                      "SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ",
#                      "")
#        RETURNING g_rtn_fields
#   LET g_rtbc_m.rtbc124_desc = '', g_rtn_fields[1] , ''
#   DISPLAY BY NAME g_rtbc_m.rtbc124_desc
   CALL s_desc_get_stock_desc(g_rtbc_m.rtbc001,g_rtbc_m.rtbc124) RETURNING g_rtbc_m.rtbc124_desc
   DISPLAY BY NAME g_rtbc_m.rtbc124_desc

END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc125_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc125_ref()
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_rtbc_m.rtbc125
#   CALL ap_ref_array2(g_ref_fields,
#                      "SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ",
#                      "")
#        RETURNING g_rtn_fields
#   LET g_rtbc_m.rtbc125_desc = '', g_rtn_fields[1] , ''
#   DISPLAY BY NAME g_rtbc_m.rtbc125_desc
   CALL s_desc_get_stock_desc(g_rtbc_m.rtbc001,g_rtbc_m.rtbc125) RETURNING g_rtbc_m.rtbc125_desc
   DISPLAY BY NAME g_rtbc_m.rtbc125_desc

END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc150_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc150_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbc150
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2077' AND oocql002=? AND oocql003='"||g_dlang||"'",
                      "")
        RETURNING g_rtn_fields
   LET g_rtbc_m.rtbc150_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbc150_desc

END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc151_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc151_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbc151
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2078' AND oocql002=? AND oocql003='"||g_dlang||"'",
                      "")
        RETURNING g_rtn_fields
   LET g_rtbc_m.rtbc151_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbc151_desc

END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc152_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc152_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbc152
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2079' AND oocql002=? AND oocql003='"||g_dlang||"'",
                      "")
        RETURNING g_rtn_fields
   LET g_rtbc_m.rtbc152_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbc152_desc

END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc153_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc153_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbc153
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2080' AND oocql002=? AND oocql003='"||g_dlang||"'",
                      "")
        RETURNING g_rtn_fields
   LET g_rtbc_m.rtbc153_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbc153_desc

END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc154_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc154_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbc154
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2081' AND oocql002=? AND oocql003='"||g_dlang||"'",
                      "")
        RETURNING g_rtn_fields
   LET g_rtbc_m.rtbc154_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbc154_desc

END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc155_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc155_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbc155
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2082' AND oocql002=? AND oocql003='"||g_dlang||"'",
                      "")
        RETURNING g_rtn_fields
   LET g_rtbc_m.rtbc155_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbc155_desc

END FUNCTION

################################################################################
# Descriptions...: 無
# Memo...........:
# Usage..........: CALL artt100_rtbc156_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc156_ref()
   #lori522612  150127  add ----------------------(S)
   #INITIALIZE g_ref_fields TO NULL
   #LET g_ref_fields[1] = g_rtbc_m.rtbc156
   #CALL ap_ref_array2(g_ref_fields,
   #                   "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2083' AND oocql002=? AND oocql003='"||g_dlang||"'",
   #                   "")
   #     RETURNING g_rtn_fields
   #LET g_rtbc_m.rtbc156_desc = '', g_rtn_fields[1] , ''
   #片區來源調整為片區基本資料維護作業
   LET g_rtbc_m.rtbc156_desc = s_desc_get_dbad002_desc(g_rtbc_m.rtbc156)
   #lori522612  150127  add ----------------------(E)

   DISPLAY BY NAME g_rtbc_m.rtbc156_desc

END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc157_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc157_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbc157
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2084' AND oocql002=? AND oocql003='"||g_dlang||"'",
                      "")
        RETURNING g_rtn_fields
   LET g_rtbc_m.rtbc157_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbc157_desc

END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc158_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc158_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbc158
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2085' AND oocql002=? AND oocql003='"||g_dlang||"'",
                      "")
        RETURNING g_rtn_fields
   LET g_rtbc_m.rtbc158_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbc158_desc

END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc159_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc159_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbc159
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2086' AND oocql002=? AND oocql003='"||g_dlang||"'",
                      "")
        RETURNING g_rtn_fields
   LET g_rtbc_m.rtbc159_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbc159_desc

END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位說明
# Memo...........:
# Usage..........: CALL artt100_rtbc160_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc160_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbc160
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2087' AND oocql002=? AND oocql003='"||g_dlang||"'",
                      "")
        RETURNING g_rtn_fields
   LET g_rtbc_m.rtbc160_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbc160_desc

END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc161_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc161_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbc161
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2088' AND oocql002=? AND oocql003='"||g_dlang||"'",
                      "")
        RETURNING g_rtn_fields
   LET g_rtbc_m.rtbc161_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbc161_desc

END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc162_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc162_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbc162
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2089' AND oocql002=? AND oocql003='"||g_dlang||"'",
                      "")
        RETURNING g_rtn_fields
   LET g_rtbc_m.rtbc162_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbc162_desc

END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc163_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc163_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbc163
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2090' AND oocql002=? AND oocql003='"||g_dlang||"'",
                      "")
        RETURNING g_rtn_fields
   LET g_rtbc_m.rtbc163_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbc163_desc

END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc164_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc164_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbc164
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2091' AND oocql002=? AND oocql003='"||g_dlang||"'",
                      "")
        RETURNING g_rtn_fields
   LET g_rtbc_m.rtbc164_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbc164_desc

END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc165_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc165_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbc165
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2092' AND oocql002=? AND oocql003='"||g_dlang||"'",
                      "")
        RETURNING g_rtn_fields
   LET g_rtbc_m.rtbc165_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbc165_desc

END FUNCTION
#檢查單據據點代號不可重複
PRIVATE FUNCTION artt100_chk_rtbc005()
   DEFINE l_cnt     LIKE type_t.num5
   
   LET g_errno = ''
   LET l_cnt = 0
   
   CASE g_rtbc_m.rtbc000 
      WHEN 'I'
         SELECT COUNT(*) INTO l_cnt FROM ooef_t
          WHERE ooefent = g_enterprise
            AND ooef005 = g_rtbc_m.rtbc005
         IF l_cnt > 0 THEN
            LET g_errno = 'aoo-00277'
         ELSE
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt FROM rtbc_t
             WHERE rtbcent = g_enterprise
               AND rtbcstus = 'N'
               AND rtbc005 = g_rtbc_m.rtbc005
               AND rtbcdocno != g_rtbc_m.rtbcdocno
            IF l_cnt > 0 THEN
               LET g_errno = 'art-00342'            
            END IF            
         END IF
         
      WHEN 'U'
         SELECT COUNT(*) INTO l_cnt FROM ooef_t
          WHERE ooefent = g_enterprise
            AND ooef005 = g_rtbc_m.rtbc005
            AND ooef001 != g_rtbc_m.rtbc001
         IF l_cnt > 0 THEN
            LET g_errno = 'aoo-00277'
         ELSE
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt FROM rtbc_t
             WHERE rtbcent = g_enterprise
               AND rtbcstus = 'N'
               AND rtbc005 = g_rtbc_m.rtbc005
               AND rtbcdocno != g_rtbc_m.rtbcdocno
            IF l_cnt > 0 THEN
               LET g_errno = 'art-00342'            
            END IF            
         END IF
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc166_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc166_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbc_m.rtbc166
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2093' AND oocql002=? AND oocql003='"||g_dlang||"'",
                      "")
        RETURNING g_rtn_fields
   LET g_rtbc_m.rtbc166_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbc166_desc

END FUNCTION
#檢查 交易對象編號 是否為散客資料
PRIVATE FUNCTION artt100_chk_rtbc108()
   DEFINE l_stus      LIKE type_t.chr10
   DEFINE l_pmaa002   LIKE pmaa_t.pmaa002
   DEFINE l_pmab087   LIKE pmab_t.pmab087
   DEFINE l_ooib007   LIKE ooib_t.ooib007
   #150504-00022#1 Add-S By Ken 150506
   DEFINE l_pmaa230   LIKE pmaa_t.pmaa230
   DEFINE l_pmaa092   LIKE pmaa_t.pmaa092
   #150504-00022#1 Add-E By Ken 150506   
   
   LET l_stus = ''
   LET g_errno = ''
   LET l_pmaa002 = ''
   #150504-00022#1 Modify-S By Ken 150506   
   SELECT pmaastus,pmaa002,pmaa230,pmaa092 INTO l_stus,l_pmaa002,l_pmaa230,l_pmaa092 FROM pmaa_t
    WHERE pmaaent = g_enterprise
      AND pmaa001 = g_rtbc_m.rtbc108   
   #SELECT pmaastus,pmaa002 INTO l_stus,l_pmaa002 FROM pmaa_t
   # WHERE pmaaent = g_enterprise
   #   AND pmaa001 = g_rtbc_m.rtbc108
   #150504-00022#1 Modify-E By Ken 150506 
      
   CASE WHEN SQLCA.SQLCODE = 100   LET g_errno = 'sub-00416'
        WHEN l_stus='N'            LET g_errno = 'sub-00415'
        WHEN l_stus='X'            LET g_errno = 'sub-00414'
        WHEN l_pmaa002 != '2'      LET g_errno = 'adb-00019'
        #150504-00022#1 Add-S By Ken 150506
        WHEN l_pmaa230 != '1'      LET g_errno = 'adb-00422'
        WHEN l_pmaa092 != '1'      LET g_errno = 'adb-00423'
        #150504-00022#1 Add-E By Ken 150506        
        OTHERWISE                  LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
   
   IF NOT cl_null(g_errno) THEN
      RETURN
   END IF
   
   LET l_stus = ''
   LET l_pmab087 = ''
   SELECT pmabstus,pmab087 INTO l_stus,l_pmab087 FROM pmab_t
    WHERE pmabent = g_enterprise
      AND pmabsite = 'ALL'
      AND pmab001 = g_rtbc_m.rtbc108
   CASE WHEN SQLCA.SQLCODE = 100   LET g_errno = 'ais-00055'
        WHEN l_stus !='Y'          LET g_errno = 'art-00350'
        WHEN cl_null(l_pmab087)    LET g_errno = 'art-00346'
        OTHERWISE                  LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
   
   IF NOT cl_null(g_errno) THEN
      RETURN
   END IF
   
   LET l_stus = ''
   LET l_ooib007 = ''
   SELECT ooibstus,ooib007 INTO l_stus,l_ooib007 FROM ooib_t
    WHERE ooibent = g_enterprise
      AND ooib001 = '2'
      AND ooib002 = l_pmab087
      
   CASE WHEN SQLCA.SQLCODE = 100   LET g_errno = 'art-00347'
        WHEN l_stus !='Y'          LET g_errno = 'art-00348'
        WHEN l_ooib007 != 'Y'      LET g_errno = 'art-00349'
        OTHERWISE                  LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 帶出主檔單身資料
# Memo...........:
# Usage..........: CALL artt100_carry_detail()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/05/05 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION artt100_carry_detail()
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_sql        STRING
   DEFINE l_cnt        LIKE type_t.num5
   DEFINE l_wc         STRING
   DEFINE l_oofb001    LIKE oofb_t.oofb001
   DEFINE l_oofb001_t  LIKE oofb_t.oofb001
   DEFINE l_oofc001    LIKE oofc_t.oofc001
   DEFINE l_oofc001_t  LIKE oofc_t.oofc001
   DEFINE l_success    LIKE type_t.num5

   LET g_errno = ''
   IF g_rtbc_m.rtbc000 = 'I' THEN
      RETURN
   END IF
   
   IF NOT cl_null(g_ooef012) THEN
      
      DECLARE artt100_oofb_cl CURSOR FOR
         SELECT oofb001
           FROM oofb_t
          WHERE oofbent = g_enterprise
            AND oofb002 = g_ooef012
      
      FOREACH artt100_oofb_cl INTO l_oofb001_t
                                                         
         LET l_wc = " oofbent = ",g_enterprise
         CALL s_aooi350_get_idno('oofb001','oofb_t',l_wc)
            RETURNING l_success,l_oofb001
         IF NOT l_success THEN
            LET g_errno = 'oofb001'
            RETURN
         END IF

         LET l_cnt = 1  
         SELECT COUNT(*) INTO l_cnt FROM oofb_t 
          WHERE oofbent = g_enterprise 
            AND oofb001 = l_oofb001
            AND oofb002 = g_rtbc_m.rtbc012
 
             
         #資料未重複, 插入新增資料
         IF l_cnt = 0 THEN 
            LET l_sql = " INSERT INTO oofb_t( ",
                        "        oofbstus, oofbent, oofb001, oofb002, oofb003, oofb004, oofb005, oofb006, ",
                        "        oofb007, oofb008, oofb009, oofb010, oofb011, oofb012, oofb013, oofb014, ",
                        "        oofb015, oofb016, oofb017, oofb018, oofbownid, oofbowndp, oofbcrtid, ",
                        "        oofbcrtdp, oofbcrtdt, oofbmodid, oofbmoddt, oofb019, oofb020, oofb021, oofb022 ",
                        "        )",
                        " SELECT oofbstus, oofbent, '",l_oofb001,"','",g_rtbc_m.rtbc012,"', oofb003, oofb004, oofb005, oofb006, ",
                        "        oofb007, oofb008, oofb009, oofb010, oofb011, oofb012, oofb013, oofb014, ",
                        "        oofb015, oofb016, oofb017, oofb018, oofbownid, oofbowndp, oofbcrtid, ",
                        "        oofbcrtdp, oofbcrtdt, oofbmodid, oofbmoddt, oofb019, oofb020, oofb021, oofb022 ",
                        "   FROM oofb_t ",
                        "  WHERE oofbent = ",g_enterprise," AND oofb001 = '",l_oofb001_t,"' AND oofb002 = '",g_ooef012,"'"
            PREPARE ins_oofb_pre FROM l_sql
            EXECUTE ins_oofb_pre  
            
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'ins oofb_t'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_errno = SQLCA.sqlcode
            END IF
         ELSE    
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00006"
            LET g_errparam.extend = 'INSERT'
            LET g_errparam.popup = TRUE
            CALL cl_err()

            LET g_errno = "std-00006"
         END IF
         
         IF NOT cl_null(g_errno) THEN
            RETURN
         END IF
      END FOREACH
      
      DECLARE artt100_oofc_cl CURSOR FOR
         SELECT oofc001
           FROM oofc_t
          WHERE oofcent = g_enterprise
            AND oofc002 = g_ooef012
      
      FOREACH artt100_oofc_cl INTO l_oofc001_t
                                                         
         LET l_wc = " oofcent = ",g_enterprise
         CALL s_aooi350_get_idno('oofc001','oofc_t',l_wc)
            RETURNING l_success,l_oofc001
         IF NOT l_success THEN
            LET g_errno = 'oofc001'
            RETURN
         END IF

         LET l_cnt = 1  
         SELECT COUNT(*) INTO l_cnt FROM oofc_t 
          WHERE oofcent = g_enterprise 
            AND oofc001 = l_oofc001
            AND oofc002 = g_rtbc_m.rtbc012
 
             
         #資料未重複, 插入新增資料
         IF l_cnt = 0 THEN 
            LET l_sql = " INSERT INTO oofc_t( ",
                        "        oofcstus, oofcent, oofc001, oofc002, oofc003, oofc004, oofc005, oofc006, ",
                        "         oofc007, oofc008, oofc009, oofc010, oofc011, oofc012, oofc013, oofcownid, ",
                        "         oofcowndp, oofccrtid, oofccrtdp, oofccrtdt, oofcmodid, oofcmoddt, oofc014 ",
                        "        )",
                        " SELECT oofcstus, oofcent,'",l_oofc001,"','",g_rtbc_m.rtbc012,"', oofc003, oofc004, oofc005, oofc006, ",
                        "        oofc007, oofc008, oofc009, oofc010, oofc011, oofc012, oofc013, oofcownid, ",
                        "        oofcowndp, oofccrtid, oofccrtdp, oofccrtdt, oofcmodid, oofcmoddt, oofc014 ",
                        "   FROM oofc_t ",
                        "  WHERE oofcent = ",g_enterprise," AND oofc001 = '",l_oofc001_t,"' AND oofc002 = '",g_ooef012,"'"
            PREPARE ins_oofc_pre FROM l_sql
            EXECUTE ins_oofc_pre  
            
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'ins oofc_t'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_errno = SQLCA.sqlcode
            END IF
         ELSE    
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00006"
            LET g_errparam.extend = 'INSERT'
            LET g_errparam.popup = TRUE
            CALL cl_err()

            LET g_errno = "std-00006"
         END IF     
         IF NOT cl_null(g_errno) THEN
            RETURN
         END IF
      END FOREACH
      LET g_ooef012 = NULL
   END IF
END FUNCTION

################################################################################
# Descriptions...: BPM提交
# Memo...........:
# Usage..........: CALL artt100_send()
#                  RETURNING true/false 
# Input parameter: 無
# Return code....: 成功/失敗
# Date & Author..: 2014/05/26 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_send()
   IF g_rtbc_m.rtbcdocno IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN FALSE
   END IF

   #重新取得與顯示完整單據資料(最新單據資料) 
   SELECT UNIQUE rtbcunit,rtbcdocdt,rtbcdocno,rtbc000,rtbc001,rtbcstus,rtbc017,
                 rtbc101,rtbc105,rtbc102,rtbc103,rtbc100,rtbc104,rtbc106,rtbc108,
                 rtbc107,rtbc115,rtbc116,rtbc109,rtbc110,rtbc111,rtbc112,rtbc113,rtbc114,
                 rtbc120,rtbc121,rtbc122,rtbc123,rtbc124,rtbc125,
                 rtbc126,rtbc127,rtbc128,    #160324-00019#3 s983961--add
                 rtbcownid,rtbcowndp,
                 rtbccrtid,rtbccrtdp,rtbccrtdt,rtbcmodid,rtbcmoddt,rtbccnfid,rtbccnfdt,
                 rtbc014,rtbc016,rtbc004,rtbc005,rtbc015,rtbc006,rtbc018,rtbc019,rtbc007,
                 rtbc020,rtbc022,rtbc008,rtbc010,rtbc011,rtbc013,rtbc023,rtbc024,rtbc025,rtbc026,
                 rtbc021,rtbc150,rtbc151,rtbc152,rtbc153,rtbc154,rtbc155,rtbc156,rtbc157,
                 rtbc158,rtbc159,rtbc160,rtbc161,rtbc162,rtbc163,rtbc164,rtbc165,rtbc166,
                 rtbc002,rtbc003,rtbc009,rtbc012,rtbcsite,rtbcacti 
            INTO g_rtbc_m.rtbcunit,g_rtbc_m.rtbcdocdt,g_rtbc_m.rtbcdocno,g_rtbc_m.rtbc000,
                 g_rtbc_m.rtbc001,g_rtbc_m.rtbcstus,g_rtbc_m.rtbc017,g_rtbc_m.rtbc101,
                 g_rtbc_m.rtbc105,g_rtbc_m.rtbc102,g_rtbc_m.rtbc103,g_rtbc_m.rtbc100,
                 g_rtbc_m.rtbc104,g_rtbc_m.rtbc106,g_rtbc_m.rtbc108,g_rtbc_m.rtbc107,
                 g_rtbc_m.rtbc115,g_rtbc_m.rtbc116,g_rtbc_m.rtbc109,g_rtbc_m.rtbc110,g_rtbc_m.rtbc111,
                 g_rtbc_m.rtbc112,g_rtbc_m.rtbc113,g_rtbc_m.rtbc114,g_rtbc_m.rtbc120,
                 g_rtbc_m.rtbc121,g_rtbc_m.rtbc122,g_rtbc_m.rtbc123,g_rtbc_m.rtbc124,g_rtbc_m.rtbc125,
                 g_rtbc_m.rtbc126,g_rtbc_m.rtbc127,g_rtbc_m.rtbc128,       #160324-00019#3 s983961--add
                 g_rtbc_m.rtbcownid,g_rtbc_m.rtbcowndp,g_rtbc_m.rtbccrtid,
                 g_rtbc_m.rtbccrtdp,g_rtbc_m.rtbccrtdt,g_rtbc_m.rtbcmodid,g_rtbc_m.rtbcmoddt,
                 g_rtbc_m.rtbccnfid,g_rtbc_m.rtbccnfdt,g_rtbc_m.rtbc014,g_rtbc_m.rtbc016,
                 g_rtbc_m.rtbc004,g_rtbc_m.rtbc005,g_rtbc_m.rtbc015,g_rtbc_m.rtbc006,
                 g_rtbc_m.rtbc018,g_rtbc_m.rtbc019,g_rtbc_m.rtbc007,g_rtbc_m.rtbc020,
                 g_rtbc_m.rtbc022,g_rtbc_m.rtbc008,g_rtbc_m.rtbc010,g_rtbc_m.rtbc011,
                 g_rtbc_m.rtbc013,g_rtbc_m.rtbc023,g_rtbc_m.rtbc024,g_rtbc_m.rtbc025,g_rtbc_m.rtbc026,
                 g_rtbc_m.rtbc021,g_rtbc_m.rtbc150,g_rtbc_m.rtbc151,g_rtbc_m.rtbc152,
                 g_rtbc_m.rtbc153,g_rtbc_m.rtbc154,g_rtbc_m.rtbc155,g_rtbc_m.rtbc156,
                 g_rtbc_m.rtbc157,g_rtbc_m.rtbc158,g_rtbc_m.rtbc159,g_rtbc_m.rtbc160,
                 g_rtbc_m.rtbc161,g_rtbc_m.rtbc162,g_rtbc_m.rtbc163,g_rtbc_m.rtbc164,
                 g_rtbc_m.rtbc165,g_rtbc_m.rtbc166,g_rtbc_m.rtbc002,g_rtbc_m.rtbc003,
                 g_rtbc_m.rtbc009,g_rtbc_m.rtbc012,g_rtbc_m.rtbcsite,g_rtbc_m.rtbcacti
            FROM rtbc_t
           WHERE rtbcent = g_enterprise
             AND rtbcdocno = g_rtbc_m.rtbcdocno 
   ERROR ""
   CALL s_transaction_begin()

   OPEN artt100_cl USING g_enterprise,g_rtbc_m.rtbcdocno

   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN artt100_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE artt100_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF 

   #鎖住將被更改的資料
   FETCH artt100_cl INTO g_rtbc_m.rtbcunit,g_rtbc_m.rtbcunit_desc,g_rtbc_m.rtbcdocdt,
                         g_rtbc_m.rtbcdocno,g_rtbc_m.rtbc000,g_rtbc_m.rtbc001,
                         g_rtbc_m.rtbcl002,g_rtbc_m.rtbcl003,g_rtbc_m.rtbcl004,
                         g_rtbc_m.rtbcstus,g_rtbc_m.rtbc017,g_rtbc_m.rtbc017_desc,
                         g_rtbc_m.rtbc101,g_rtbc_m.rtbc105,g_rtbc_m.rtbc105_desc,
                         g_rtbc_m.rtbc102,g_rtbc_m.rtbc103,g_rtbc_m.rtbc100,
                         g_rtbc_m.rtbc104,g_rtbc_m.rtbc104_desc,g_rtbc_m.rtbc106,
                         g_rtbc_m.rtbc106_desc,g_rtbc_m.rtbc108,g_rtbc_m.rtbc108_desc,
                         g_rtbc_m.rtbc107,g_rtbc_m.rtbc115,g_rtbc_m.rtbc116,g_rtbc_m.rtbc109,g_rtbc_m.rtbc110,
                         g_rtbc_m.rtbc111,g_rtbc_m.rtbc112,g_rtbc_m.rtbc113,g_rtbc_m.rtbc114,
                         g_rtbc_m.rtbc120,g_rtbc_m.rtbc121,g_rtbc_m.rtbc122,g_rtbc_m.rtbc123,
                         g_rtbc_m.rtbc123_desc,g_rtbc_m.rtbc124,g_rtbc_m.rtbc124_desc,
                         g_rtbc_m.rtbc125,g_rtbc_m.rtbc125_desc,
                         g_rtbc_m.rtbc126,g_rtbc_m.rtbc126_desc,g_rtbc_m.rtbc127,g_rtbc_m.rtbc127_desc, g_rtbc_m.rtbc128,g_rtbc_m.rtbc128_desc,  #160324-00019#3 s983961--add
                         g_rtbc_m.rtbcownid,
                         g_rtbc_m.rtbcownid_desc,g_rtbc_m.rtbcowndp,g_rtbc_m.rtbcowndp_desc,
                         g_rtbc_m.rtbccrtid,g_rtbc_m.rtbccrtid_desc,g_rtbc_m.rtbccrtdp,
                         g_rtbc_m.rtbccrtdp_desc,g_rtbc_m.rtbccrtdt,g_rtbc_m.rtbcmodid,
                         g_rtbc_m.rtbcmodid_desc,g_rtbc_m.rtbcmoddt,g_rtbc_m.rtbccnfid,
                         g_rtbc_m.rtbccnfid_desc,g_rtbc_m.rtbccnfdt,g_rtbc_m.rtbc014,
                         g_rtbc_m.rtbc014_desc,g_rtbc_m.rtbc016,g_rtbc_m.rtbc016_desc, 
                         g_rtbc_m.rtbc004,g_rtbc_m.rtbc004_desc,g_rtbc_m.rtbc005,
                         g_rtbc_m.rtbc015,g_rtbc_m.rtbc015_desc,g_rtbc_m.rtbc006,
                         g_rtbc_m.rtbc006_desc,g_rtbc_m.rtbc018,g_rtbc_m.rtbc018_desc,
                         g_rtbc_m.rtbc019,g_rtbc_m.rtbc019_desc,g_rtbc_m.rtbc007,g_rtbc_m.rtbc020,
                         g_rtbc_m.rtbc022,g_rtbc_m.rtbc008,g_rtbc_m.rtbc008_desc,g_rtbc_m.rtbc010,
                         g_rtbc_m.rtbc011,g_rtbc_m.rtbc013,g_rtbc_m.rtbc023,g_rtbc_m.rtbc024,
                         g_rtbc_m.rtbc024_desc,g_rtbc_m.rtbc025,g_rtbc_m.rtbc026,g_rtbc_m.rtbc026_desc,g_rtbc_m.rtbc021,g_rtbc_m.rtbc150,
                         g_rtbc_m.rtbc150_desc,g_rtbc_m.rtbc151,g_rtbc_m.rtbc151_desc,g_rtbc_m.rtbc152,
                         g_rtbc_m.rtbc152_desc,g_rtbc_m.rtbc153,g_rtbc_m.rtbc153_desc,g_rtbc_m.rtbc154,
                         g_rtbc_m.rtbc154_desc,g_rtbc_m.rtbc155,g_rtbc_m.rtbc155_desc,g_rtbc_m.rtbc156,
                         g_rtbc_m.rtbc156_desc,g_rtbc_m.rtbc157,g_rtbc_m.rtbc157_desc,g_rtbc_m.rtbc158,
                         g_rtbc_m.rtbc158_desc,g_rtbc_m.rtbc159,g_rtbc_m.rtbc159_desc,g_rtbc_m.rtbc160,
                         g_rtbc_m.rtbc160_desc,g_rtbc_m.rtbc161,g_rtbc_m.rtbc161_desc,g_rtbc_m.rtbc162,
                         g_rtbc_m.rtbc162_desc,g_rtbc_m.rtbc163,g_rtbc_m.rtbc163_desc,g_rtbc_m.rtbc164,
                         g_rtbc_m.rtbc164_desc,g_rtbc_m.rtbc165,g_rtbc_m.rtbc165_desc,g_rtbc_m.rtbc166,
                         g_rtbc_m.rtbc166_desc,g_rtbc_m.rtbc002,g_rtbc_m.rtbc003,g_rtbc_m.rtbc009,
                         g_rtbc_m.rtbc012,g_rtbc_m.rtbcsite

   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_rtbc_m.rtbcdocno
      LET g_errparam.popup = FALSE
      CALL cl_err()

      CLOSE artt100_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF 
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
  #LET g_wc2_table1 = " 1=1"
  #LET g_wc2_table2 = " 1=1"

   CALL artt100_show()
  #CALL apmt400_set_pk_array()  
  
   IF NOT s_artt100_conf_chk(g_rtbc_m.rtbcdocno) THEN
      CLOSE artt100_cl
      CALL s_transaction_end('N',0)
      RETURN
   END IF

   #公用變數初始化
   CALL cl_bpm_data_init()

   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_rtbc_m))

   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 
  #CALL cl_bpm_set_detail_data("s_detail1_aooi350_01", util.JSONArray.fromFGL(g_oofb_d))
  #CALL cl_bpm_set_detail_data("s_detail1_aooi350_02", util.JSONArray.fromFGL(g_oofc_d))

   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功

   #開單失敗
   IF NOT cl_bpm_cli() THEN
      CLOSE artt100_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF 
   
   #完成狀態更新
   CLOSE artt100_cl
   CALL s_transaction_end('Y','0')

   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL artt100_ui_browser_refresh()

   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_row].b_statepic = "stus/16/signing.png"

   #重新取得單頭/單身資料,DISPLAY在畫面上
   #CALL artt100_ui_headershow() 
   
   SELECT UNIQUE rtbcunit,rtbcdocdt,rtbcdocno,rtbc000,rtbc001,rtbcstus,rtbc017,
                 rtbc101,rtbc105,rtbc102,rtbc103,rtbc100,rtbc104,rtbc106,rtbc108,
                 rtbc107,rtbc115,rtbc116,rtbc109,rtbc110,rtbc111,rtbc112,rtbc113,rtbc114,
                 rtbc120,rtbc121,rtbc122,rtbc123,rtbc124,rtbc125,
                 rtbc126,rtbc127,rtbc128,     #160324-00019#3 s983961--add     
                 rtbcownid,rtbcowndp,
                 rtbccrtid,rtbccrtdp,rtbccrtdt,rtbcmodid,rtbcmoddt,rtbccnfid,rtbccnfdt,
                 rtbc014,rtbc016,rtbc004,rtbc005,rtbc015,rtbc006,rtbc018,rtbc019,rtbc007,
                 rtbc020,rtbc022,rtbc008,rtbc010,rtbc011,rtbc013,rtbc023,rtbc024,rtbc025,rtbc026,
                 rtbc021,rtbc150,rtbc151,rtbc152,rtbc153,rtbc154,rtbc155,rtbc156,rtbc157,
                 rtbc158,rtbc159,rtbc160,rtbc161,rtbc162,rtbc163,rtbc164,rtbc165,rtbc166,
                 rtbc002,rtbc003,rtbc009,rtbc012,rtbcsite,rtbcacti 
            INTO g_rtbc_m.rtbcunit,g_rtbc_m.rtbcdocdt,g_rtbc_m.rtbcdocno,g_rtbc_m.rtbc000,
                 g_rtbc_m.rtbc001,g_rtbc_m.rtbcstus,g_rtbc_m.rtbc017,g_rtbc_m.rtbc101,
                 g_rtbc_m.rtbc105,g_rtbc_m.rtbc102,g_rtbc_m.rtbc103,g_rtbc_m.rtbc100,
                 g_rtbc_m.rtbc104,g_rtbc_m.rtbc106,g_rtbc_m.rtbc108,g_rtbc_m.rtbc107,
                 g_rtbc_m.rtbc115,g_rtbc_m.rtbc116,g_rtbc_m.rtbc109,g_rtbc_m.rtbc110,g_rtbc_m.rtbc111,
                 g_rtbc_m.rtbc112,g_rtbc_m.rtbc113,g_rtbc_m.rtbc114,g_rtbc_m.rtbc120,
                 g_rtbc_m.rtbc121,g_rtbc_m.rtbc122,g_rtbc_m.rtbc123,g_rtbc_m.rtbc124,g_rtbc_m.rtbc125,
                 g_rtbc_m.rtbc126,g_rtbc_m.rtbc127,g_rtbc_m.rtbc128,   #160324-00019#3 s983961--add     
                 g_rtbc_m.rtbcownid,g_rtbc_m.rtbcowndp,g_rtbc_m.rtbccrtid,
                 g_rtbc_m.rtbccrtdp,g_rtbc_m.rtbccrtdt,g_rtbc_m.rtbcmodid,g_rtbc_m.rtbcmoddt,
                 g_rtbc_m.rtbccnfid,g_rtbc_m.rtbccnfdt,g_rtbc_m.rtbc014,g_rtbc_m.rtbc016,
                 g_rtbc_m.rtbc004,g_rtbc_m.rtbc005,g_rtbc_m.rtbc015,g_rtbc_m.rtbc006,
                 g_rtbc_m.rtbc018,g_rtbc_m.rtbc019,g_rtbc_m.rtbc007,g_rtbc_m.rtbc020,
                 g_rtbc_m.rtbc022,g_rtbc_m.rtbc008,g_rtbc_m.rtbc010,g_rtbc_m.rtbc011,
                 g_rtbc_m.rtbc013,g_rtbc_m.rtbc023,g_rtbc_m.rtbc024,g_rtbc_m.rtbc025,g_rtbc_m.rtbc026,
                 g_rtbc_m.rtbc021,g_rtbc_m.rtbc150,g_rtbc_m.rtbc151,g_rtbc_m.rtbc152,
                 g_rtbc_m.rtbc153,g_rtbc_m.rtbc154,g_rtbc_m.rtbc155,g_rtbc_m.rtbc156,
                 g_rtbc_m.rtbc157,g_rtbc_m.rtbc158,g_rtbc_m.rtbc159,g_rtbc_m.rtbc160,
                 g_rtbc_m.rtbc161,g_rtbc_m.rtbc162,g_rtbc_m.rtbc163,g_rtbc_m.rtbc164,
                 g_rtbc_m.rtbc165,g_rtbc_m.rtbc166,g_rtbc_m.rtbc002,g_rtbc_m.rtbc003,
                 g_rtbc_m.rtbc009,g_rtbc_m.rtbc012,g_rtbc_m.rtbcsite,g_rtbc_m.rtbcacti
            FROM rtbc_t
           WHERE rtbcent = g_enterprise
             AND rtbcdocno = g_rtbc_m.rtbcdocno
   #CALL artt100_ui_detailshow()

   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: BPM抽單
# Memo...........:
# Usage..........: CALL artt100_draw_out()
#                  RETURNING true/false
# Input parameter: 無
# Return code....: 成功/失敗
# Date & Author..: 2014/05/26 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_draw_out()
   #檢查資料是否存在
   IF g_rtbc_m.rtbcdocno IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN FALSE
   END IF

   #LOCK主檔資料
   CALL s_transaction_begin()

   #進行BPM抽單功能
   OPEN artt100_cl USING g_enterprise,g_rtbc_m.rtbcdocno

   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN artt100_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE artt100_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF 
   
   #鎖住將被更改的資料
   FETCH artt100_cl INTO g_rtbc_m.rtbcunit,g_rtbc_m.rtbcunit_desc,g_rtbc_m.rtbcdocdt,
                         g_rtbc_m.rtbcdocno,g_rtbc_m.rtbc000,g_rtbc_m.rtbc001,
                         g_rtbc_m.rtbcl002,g_rtbc_m.rtbcl003,g_rtbc_m.rtbcl004,
                         g_rtbc_m.rtbcstus,g_rtbc_m.rtbc017,g_rtbc_m.rtbc017_desc,
                         g_rtbc_m.rtbc101,g_rtbc_m.rtbc105,g_rtbc_m.rtbc105_desc,
                         g_rtbc_m.rtbc102,g_rtbc_m.rtbc103,g_rtbc_m.rtbc100,
                         g_rtbc_m.rtbc104,g_rtbc_m.rtbc104_desc,g_rtbc_m.rtbc106,
                         g_rtbc_m.rtbc106_desc,g_rtbc_m.rtbc108,g_rtbc_m.rtbc108_desc,
                         g_rtbc_m.rtbc107,g_rtbc_m.rtbc115,g_rtbc_m.rtbc116,g_rtbc_m.rtbc109,g_rtbc_m.rtbc110,
                         g_rtbc_m.rtbc111,g_rtbc_m.rtbc112,g_rtbc_m.rtbc113,g_rtbc_m.rtbc114,
                         g_rtbc_m.rtbc120,g_rtbc_m.rtbc121,g_rtbc_m.rtbc122,g_rtbc_m.rtbc123,
                         g_rtbc_m.rtbc123_desc,g_rtbc_m.rtbc124,g_rtbc_m.rtbc124_desc,   
                         g_rtbc_m.rtbc125,g_rtbc_m.rtbc125_desc,
                         g_rtbc_m.rtbc126,g_rtbc_m.rtbc126_desc,g_rtbc_m.rtbc127,g_rtbc_m.rtbc127_desc,g_rtbc_m.rtbc128,g_rtbc_m.rtbc128_desc, #160324-00019#3 s983961--add           
                         g_rtbc_m.rtbcownid,g_rtbc_m.rtbcownid_desc,g_rtbc_m.rtbcowndp,g_rtbc_m.rtbcowndp_desc,
                         g_rtbc_m.rtbccrtid,g_rtbc_m.rtbccrtid_desc,g_rtbc_m.rtbccrtdp,
                         g_rtbc_m.rtbccrtdp_desc,g_rtbc_m.rtbccrtdt,g_rtbc_m.rtbcmodid,
                         g_rtbc_m.rtbcmodid_desc,g_rtbc_m.rtbcmoddt,g_rtbc_m.rtbccnfid,
                         g_rtbc_m.rtbccnfid_desc,g_rtbc_m.rtbccnfdt,g_rtbc_m.rtbc014,
                         g_rtbc_m.rtbc014_desc,g_rtbc_m.rtbc016,g_rtbc_m.rtbc016_desc,
                         g_rtbc_m.rtbc004,g_rtbc_m.rtbc004_desc,g_rtbc_m.rtbc005,
                         g_rtbc_m.rtbc015,g_rtbc_m.rtbc015_desc,g_rtbc_m.rtbc006,
                         g_rtbc_m.rtbc006_desc,g_rtbc_m.rtbc018,g_rtbc_m.rtbc018_desc, 
                         g_rtbc_m.rtbc019,g_rtbc_m.rtbc019_desc,g_rtbc_m.rtbc007,g_rtbc_m.rtbc020,
                         g_rtbc_m.rtbc022,g_rtbc_m.rtbc008,g_rtbc_m.rtbc008_desc,g_rtbc_m.rtbc010,
                         g_rtbc_m.rtbc011,g_rtbc_m.rtbc013,g_rtbc_m.rtbc023,g_rtbc_m.rtbc024,
                         g_rtbc_m.rtbc024_desc,g_rtbc_m.rtbc025,g_rtbc_m.rtbc026,g_rtbc_m.rtbc026_desc,g_rtbc_m.rtbc021,g_rtbc_m.rtbc150,
                         g_rtbc_m.rtbc150_desc,g_rtbc_m.rtbc151,g_rtbc_m.rtbc151_desc,g_rtbc_m.rtbc152,
                         g_rtbc_m.rtbc152_desc,g_rtbc_m.rtbc153,g_rtbc_m.rtbc153_desc,g_rtbc_m.rtbc154,
                         g_rtbc_m.rtbc154_desc,g_rtbc_m.rtbc155,g_rtbc_m.rtbc155_desc,g_rtbc_m.rtbc156,
                         g_rtbc_m.rtbc156_desc,g_rtbc_m.rtbc157,g_rtbc_m.rtbc157_desc,g_rtbc_m.rtbc158,
                         g_rtbc_m.rtbc158_desc,g_rtbc_m.rtbc159,g_rtbc_m.rtbc159_desc,g_rtbc_m.rtbc160,
                         g_rtbc_m.rtbc160_desc,g_rtbc_m.rtbc161,g_rtbc_m.rtbc161_desc,g_rtbc_m.rtbc162,
                         g_rtbc_m.rtbc162_desc,g_rtbc_m.rtbc163,g_rtbc_m.rtbc163_desc,g_rtbc_m.rtbc164,
                         g_rtbc_m.rtbc164_desc,g_rtbc_m.rtbc165,g_rtbc_m.rtbc165_desc,g_rtbc_m.rtbc166,
                         g_rtbc_m.rtbc166_desc,g_rtbc_m.rtbc002,g_rtbc_m.rtbc003,g_rtbc_m.rtbc009,
                         g_rtbc_m.rtbc012,g_rtbc_m.rtbcsite

   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_rtbc_m.rtbcdocno
      LET g_errparam.popup = FALSE
      CALL cl_err()

      CLOSE artt100_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF 
   
   #抽單失敗
   IF NOT cl_bpm_draw_out() THEN
      CLOSE artt100_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF

   #完成狀態更新
   CLOSE artt100_cl
   CALL s_transaction_end('Y','0')

   #重新指定此筆單據資料狀態圖片=>抽單
   LET g_browser[g_current_row].b_statepic = "stus/16/draw_out.png"

   #重新取得單頭/單身資料,DISPLAY在畫面上
  #CALL apmt400_ui_headershow() 
   SELECT UNIQUE rtbcunit,rtbcdocdt,rtbcdocno,rtbc000,rtbc001,rtbcstus,rtbc017,
                 rtbc101,rtbc105,rtbc102,rtbc103,rtbc100,rtbc104,rtbc106,rtbc108,
                 rtbc107,rtbc115,rtbc116,rtbc109,rtbc110,rtbc111,rtbc112,rtbc113,rtbc114,
                 rtbc120,rtbc121,rtbc122,rtbc123,rtbc124,rtbc125,
                 rtbc126,rtbc127,rtbc128,                              #160324-00019#3 s983961--add
                 rtbcownid,rtbcowndp,
                 rtbccrtid,rtbccrtdp,rtbccrtdt,rtbcmodid,rtbcmoddt,rtbccnfid,rtbccnfdt,
                 rtbc014,rtbc016,rtbc004,rtbc005,rtbc015,rtbc006,rtbc018,rtbc019,rtbc007,
                 rtbc020,rtbc022,rtbc008,rtbc010,rtbc011,rtbc013,rtbc023,rtbc024,rtbc025,rtbc026,
                 rtbc021,rtbc150,rtbc151,rtbc152,rtbc153,rtbc154,rtbc155,rtbc156,rtbc157,
                 rtbc158,rtbc159,rtbc160,rtbc161,rtbc162,rtbc163,rtbc164,rtbc165,rtbc166,
                 rtbc002,rtbc003,rtbc009,rtbc012,rtbcsite,rtbcacti
            INTO g_rtbc_m.rtbcunit,g_rtbc_m.rtbcdocdt,g_rtbc_m.rtbcdocno,g_rtbc_m.rtbc000,
                 g_rtbc_m.rtbc001,g_rtbc_m.rtbcstus,g_rtbc_m.rtbc017,g_rtbc_m.rtbc101,
                 g_rtbc_m.rtbc105,g_rtbc_m.rtbc102,g_rtbc_m.rtbc103,g_rtbc_m.rtbc100,
                 g_rtbc_m.rtbc104,g_rtbc_m.rtbc106,g_rtbc_m.rtbc108,g_rtbc_m.rtbc107,
                 g_rtbc_m.rtbc115,g_rtbc_m.rtbc116,g_rtbc_m.rtbc109,g_rtbc_m.rtbc110,g_rtbc_m.rtbc111,
                 g_rtbc_m.rtbc112,g_rtbc_m.rtbc113,g_rtbc_m.rtbc114,g_rtbc_m.rtbc120,
                 g_rtbc_m.rtbc121,g_rtbc_m.rtbc122,g_rtbc_m.rtbc123,g_rtbc_m.rtbc124,g_rtbc_m.rtbc125,
                 g_rtbc_m.rtbc126,g_rtbc_m.rtbc127,g_rtbc_m.rtbc128,     #160324-00019#3 s983961--add
                 g_rtbc_m.rtbcownid,g_rtbc_m.rtbcowndp,g_rtbc_m.rtbccrtid,
                 g_rtbc_m.rtbccrtdp,g_rtbc_m.rtbccrtdt,g_rtbc_m.rtbcmodid,g_rtbc_m.rtbcmoddt,
                 g_rtbc_m.rtbccnfid,g_rtbc_m.rtbccnfdt,g_rtbc_m.rtbc014,g_rtbc_m.rtbc016,
                 g_rtbc_m.rtbc004,g_rtbc_m.rtbc005,g_rtbc_m.rtbc015,g_rtbc_m.rtbc006,
                 g_rtbc_m.rtbc018,g_rtbc_m.rtbc019,g_rtbc_m.rtbc007,g_rtbc_m.rtbc020,
                 g_rtbc_m.rtbc022,g_rtbc_m.rtbc008,g_rtbc_m.rtbc010,g_rtbc_m.rtbc011,
                 g_rtbc_m.rtbc013,g_rtbc_m.rtbc023,g_rtbc_m.rtbc024,g_rtbc_m.rtbc025,g_rtbc_m.rtbc026,
                 g_rtbc_m.rtbc021,g_rtbc_m.rtbc150,g_rtbc_m.rtbc151,g_rtbc_m.rtbc152,
                 g_rtbc_m.rtbc153,g_rtbc_m.rtbc154,g_rtbc_m.rtbc155,g_rtbc_m.rtbc156,
                 g_rtbc_m.rtbc157,g_rtbc_m.rtbc158,g_rtbc_m.rtbc159,g_rtbc_m.rtbc160, 
                 g_rtbc_m.rtbc161,g_rtbc_m.rtbc162,g_rtbc_m.rtbc163,g_rtbc_m.rtbc164,
                 g_rtbc_m.rtbc165,g_rtbc_m.rtbc166,g_rtbc_m.rtbc002,g_rtbc_m.rtbc003,
                 g_rtbc_m.rtbc009,g_rtbc_m.rtbc012,g_rtbc_m.rtbcsite,g_rtbc_m.rtbcacti
            FROM rtbc_t
           WHERE rtbcent = g_enterprise
             AND rtbcdocno = g_rtbc_m.rtbcdocno
  #CALL apmt400_ui_detailshow()

   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 清空法人相關欄位
# Memo...........:
# Usage..........: CALL artt100_rtbc017_empty()
# Date & Author..: 20140812 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc017_empty()
   LET g_rtbc_m.rtbc002 = ''     LET g_rtbc_m.rtbc022 = ''   LET g_rtbc_m.rtbc014 = ''   LET g_rtbc_m.rtbc018 = '' 
   LET g_rtbc_m.rtbc007 = ''     LET g_rtbc_m.rtbc011 = ''   LET g_rtbc_m.rtbc016 = ''   LET g_rtbc_m.rtbc019 = '' 
   LET g_rtbc_m.rtbc020 = ''     LET g_rtbc_m.rtbc013 = ''   LET g_rtbc_m.rtbc015 = ''   LET g_rtbc_m.rtbc006_desc = '' 
   LET g_rtbc_m.rtbc021 = ''     LET g_rtbc_m.rtbc023 = ''   LET g_rtbc_m.rtbc006 = ''   LET g_rtbc_m.rtbc014_desc = ''
   LET g_rtbc_m.rtbc015_desc = '' LET g_rtbc_m.rtbc016_desc = '' LET g_rtbc_m.rtbc018_desc = ''  LET g_rtbc_m.rtbc019_desc = '' 
   LET g_rtbc_m.rtbc017 = ''     LET g_rtbc_m.rtbc017_desc = ''
   DISPLAY BY NAME g_rtbc_m.rtbc002,g_rtbc_m.rtbc007,g_rtbc_m.rtbc020,g_rtbc_m.rtbc021,g_rtbc_m.rtbc022,g_rtbc_m.rtbc011,
                   g_rtbc_m.rtbc013,g_rtbc_m.rtbc023,g_rtbc_m.rtbc014,g_rtbc_m.rtbc016,g_rtbc_m.rtbc015,g_rtbc_m.rtbc006,
                   g_rtbc_m.rtbc018,g_rtbc_m.rtbc019,g_rtbc_m.rtbc006_desc,g_rtbc_m.rtbc014_desc,g_rtbc_m.rtbc015_desc,
                   g_rtbc_m.rtbc016_desc,g_rtbc_m.rtbc018_desc,g_rtbc_m.rtbc019_desc,g_rtbc_m.rtbc017,g_rtbc_m.rtbc017_desc
END FUNCTION

################################################################################
# Descriptions...: 帶出法人相關欄位信息
# Memo...........:
# Usage..........: CALL artt100_rtbc017_default()
# Date & Author..: 20140812 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc017_default()
   SELECT ooef002,ooef007,ooef020,ooef021,ooef022,ooef011,ooef013,ooef023,ooef014,ooef016,ooef015,ooef006,ooef018,ooef019
     INTO g_rtbc_m.rtbc002,g_rtbc_m.rtbc007,g_rtbc_m.rtbc020,g_rtbc_m.rtbc021,g_rtbc_m.rtbc022,g_rtbc_m.rtbc011,g_rtbc_m.rtbc013,
          g_rtbc_m.rtbc023,g_rtbc_m.rtbc014,g_rtbc_m.rtbc016,g_rtbc_m.rtbc015,g_rtbc_m.rtbc006,g_rtbc_m.rtbc018,g_rtbc_m.rtbc019
     FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_rtbc_m.rtbc017
   CALL artt100_rtbc006_ref()
   
   CALL artt100_rtbc014_ref()
   
   CALL artt100_rtbc015_ref()
   
   CALL artt100_rtbc016_ref()
   
   CALL artt100_rtbc018_ref()
   
   CALL artt100_rtbc019_ref()
END FUNCTION

################################################################################
# Descriptions...: 檢查法人是否被使用
# Memo...........:
# Usage..........: CALL artt100_chk_rtbc003()
# Date & Author..: 20140812 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_chk_rtbc003()
DEFINE l_n      LIKE type_t.num5

   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef017 = g_rtbc_m.rtbc001
      AND ooef001 <> g_rtbc_m.rtbc001
   IF l_n > 0 THEN
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc026_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/08/22 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc026_ref()
DEFINE l_nmaa001   LIKE nmaa_t.nmaa001   
   
   INITIALIZE g_ref_fields TO NULL
   SELECT nmaa001 INTO l_nmaa001
     FROM nmaa_t,nmas_t
    WHERE nmaaent = nmasent
      AND nmaa001 = nmas001
      AND nmaaent = g_enterprise
      AND nmas002 = g_rtbc_m.rtbc026
   LET g_ref_fields[1] = l_nmaa001
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT nmaal003 FROM nmaal_t WHERE nmaalent='"||g_enterprise||"' AND nmaal001=? AND nmaal002='"||g_dlang||"'",
                      "")
        RETURNING g_rtn_fields
   LET g_rtbc_m.rtbc026_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbc_m.rtbc026_desc
   
END FUNCTION

################################################################################
# Descriptions...: 聯絡地址維護後同步更新銷售片區
# Memo...........:
# Usage..........: CALL artt100_upd_rtbc156()
# Date & Author..: 2014/11/21 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_upd_rtbc156()
   DEFINE l_oofb022   LIKE oofb_t.oofb022   
   DEFINE l_rtbc156   LIKE rtbc_t.rtbc156
   
   LET l_oofb022 = '' 
   SELECT oofb022 INTO l_oofb022
     FROM oofb_t
    WHERE oofbent = g_enterprise
      AND oofb002 = g_rtbc_m.rtbc012
      AND oofb008 = '3'
      AND oofb010 = 'Y'
   
   IF cl_null(l_oofb022) > 0 THEN
      RETURN
   ELSE
      LET l_rtbc156 = ''
      SELECT dbad002 INTO l_rtbc156
        FROM dbad_t
       WHERE dbadent = g_enterprise
         AND dbad001 = l_oofb022
      
      IF cl_null(l_rtbc156) THEN
         RETURN
      ELSE
         UPDATE rtbc_t
            SET rtbc156 = l_rtbc156
          WHERE rtbcent = g_enterprise
            AND rtbcdocno = g_rtbc_m.rtbcdocno
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code =  SQLCA.sqlcode
           LET g_errparam.extend = g_rtbc_m.rtbc001," Update rtbc_t."
           LET g_errparam.popup = TRUE
           RETURN
        END IF
         LET g_rtbc_m.rtbc156 = l_rtbc156
         LET g_rtbc_m.rtbc156_desc = s_desc_get_dbad002_desc(l_rtbc156)
         DISPLAY BY NAME g_rtbc_m.rtbc156 ,g_rtbc_m.rtbc156_desc 
      END IF      
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL artt100_rtbcsite_ref()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/12/30 by Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbcsite_ref()
   DEFINE l_ooefl003     LIKE ooefl_t.ooefl003

   LET l_ooefl003 = ''
   SELECT ooefl003 INTO l_ooefl003
     FROM ooefl_t
    WHERE ooeflent = g_enterprise
      AND ooefl001 = g_rtbc_m.rtbcsite
      AND ooefl002 = g_dlang

   LET g_rtbc_m.rtbcsite_desc = l_ooefl003
   DISPLAY BY NAME g_rtbc_m.rtbcsite_desc
END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc126_ref()
#                  RETURNING 回传参数
# Date & Author..: 20160330 by s983961
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc126_ref()
   CALL s_desc_get_stock_desc(g_rtbc_m.rtbc001,g_rtbc_m.rtbc126) RETURNING g_rtbc_m.rtbc126_desc
   DISPLAY BY NAME g_rtbc_m.rtbc126_desc
END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc127_ref()
#                  RETURNING 回传参数
# Date & Author..: 20160330 by s983961
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc127_ref()
   CALL s_desc_get_stock_desc(g_rtbc_m.rtbc001,g_rtbc_m.rtbc127) RETURNING g_rtbc_m.rtbc127_desc
   DISPLAY BY NAME g_rtbc_m.rtbc127_desc
END FUNCTION

################################################################################
# Descriptions...: 取得參考欄位資訊
# Memo...........:
# Usage..........: CALL artt100_rtbc128_ref()
#                  RETURNING 回传参数
# Date & Author..: 20160330 by s983961
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_rtbc128_ref()
   CALL s_desc_get_stock_desc(g_rtbc_m.rtbc001,g_rtbc_m.rtbc128) RETURNING g_rtbc_m.rtbc128_desc
   DISPLAY BY NAME g_rtbc_m.rtbc128_desc
END FUNCTION

################################################################################
# Date & Author..: 2016/08/22 By 08734
# Modify.........:
################################################################################
PRIVATE FUNCTION artt100_action_chk()
 #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#34 add-S
   SELECT rtbcstus  INTO g_rtbc_m.rtbcstus
     FROM rtbc_t
    WHERE rtbcent = g_enterprise
      AND rtbcdocno = g_rtbc_m.rtbcdocno

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_rtbc_m.rtbcstus
        WHEN 'W'
           LET g_errno = 'sub-00180'
        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
        WHEN 'S'
           LET g_errno = 'sub-00230'
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_rtbc_m.rtbcdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        IF g_rtbc_m.rtbcstus MATCHES "[NDR]" THEN
           CALL cl_set_act_visible("modify,delete,modify_detail",TRUE)
        ELSE 
           CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)
        END IF 
        CALL artt100_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#34 add-E
   #end add-point
      
   RETURN TRUE
END FUNCTION

#end add-point
 
{</section>}
 
